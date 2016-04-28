                     MEMBER('winlats.clw')        ! This is a MEMBER module
P_NolApr1            PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:IZSLEGTS)
                     END
B_TABLE              QUEUE,PRE(B)
BKK                    STRING(5)
SUMMA1                 DECIMAL(10,2)
SUMMAI                 DECIMAL(10,2)
SUMMAM                 DECIMAL(10,2)
SUMMA2                 DECIMAL(10,2)
SUMMAU                 DECIMAL(10,2)
SUMMANO                DECIMAL(10,2)
SUMMA3                 DECIMAL(10,2)
                     .
K_TABLE              QUEUE,PRE(K)
KAT                    STRING(1)
SUMMA1                 DECIMAL(10,2)
SUMMAI                 DECIMAL(10,2)
SUMMAM                 DECIMAL(10,2)
SUMMA2                 DECIMAL(10,2)
SUMMAU                 DECIMAL(10,2)
SUMMANO                DECIMAL(10,2)
SUMMA3                 DECIMAL(10,2)
                     .
DATUMS               DATE
VERT_S               DECIMAL(11,2)
VERT_SB               DECIMAL(11,2)
VERT_I               DECIMAL(10,2)
VERT_M               DECIMAL(10,2)
VERT_N               DECIMAL(10,2)
VERT_U               DECIMAL(11,2)
VERT_NON             DECIMAL(10,2)
VERT_B               DECIMAL(12,2)
KOPA                 STRING(15)
BKK                  STRING(5)
VERT_SK              DECIMAL(11,2)
VERT_SBK               DECIMAL(11,2)
VERT_IK              DECIMAL(10,2)
VERT_MK              DECIMAL(10,2)
VERT_NK              DECIMAL(10,2)
VERT_UK              DECIMAL(11,2)
VERT_NONK            DECIMAL(10,2)
VERT_BK              DECIMAL(12,2)
atl_datums           DATE
ATL_DIENA            DECIMAL(2)
KAT_NR               STRING(4)
DAT                 LONG
LAI                 LONG

report REPORT,AT(1000,1696,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(1000,300,12000,1396),USE(?unnamed)
         STRING('uz     Summa'),AT(2865,938,1146,208),USE(?String13:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(4063,938,156,208),USE(?String13:17),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d5),AT(4219,938),USE(atl_datums,,?atl_datums:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taks. per.'),AT(4792,938,573,208),USE(?String13:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliet. par'),AT(5417,729,625,208),USE(?String13:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no gada'),AT(6094,938,677,208),USE(?String13:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gadâ'),AT(6823,938,677,208),USE(?String13:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojums'),AT(7552,938,677,208),USE(?String13:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc sâk.'),AT(8281,938,625,208),USE(?String13:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(9010,938,156,208),USE(?String13:14),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d5),AT(9167,938),USE(atl_datums),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sâkuma'),AT(6094,1146,677,208),USE(?String13:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(6823,1146,156,208),USE(?String13:24),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d5),AT(6979,1146),USE(atl_datums,,?atl_datums:4),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîbas'),AT(8281,1146,625,208),USE(?String13:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(7552,1146,156,208),USE(?String13:21),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d5),AT(7708,1146),USE(atl_datums,,?atl_datums:3),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kat.'),AT(573,729,313,208),USE(?String13:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1354,9635,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('tek.mçn.'),AT(5417,938,625,208),USE(?menesis),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1719,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojuma aprçíins.'),AT(1583,417,1667,260),USE(?String3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(3365,417),USE(menesisunG),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('(Lineârâ metode)'),AT(4844,417,1302,260),USE(?String3:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma LI1'),AT(8073,469,677,156),USE(?String11),CENTER
         STRING(@P<<<#. lapaP),AT(8802,469,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,677,9635,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2813,677,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4740,677,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5365,677,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6042,677,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6771,677,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(8229,677,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(8906,677,0,729),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(9688,677,0,729),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Sâkotnçjâ vçrtîba'),AT(2865,729,1146,208),USE(?String13:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâk. vçrtîba'),AT(4063,729,677,208),USE(?String13:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,677,0,729),USE(?Line2:21),COLOR(COLOR:Black)
         STRING('Nr'),AT(104,729,417,208),USE(?String13:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,677,0,729),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(885,677,0,729),USE(?Line2:22),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(938,729,1875,208),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrt. izm.'),AT(4792,729,573,208),USE(?String13:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(6094,729,677,208),USE(?String13:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(6823,729,677,208),USE(?String13:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7500,677,0,729),USE(?Line2:26),COLOR(COLOR:Black)
         STRING('Uzkrâtais'),AT(7552,729,677,208),USE(?String13:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Noòemts'),AT(8281,729,625,208),USE(?String13:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(8958,729,729,208),USE(?String13:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,677,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_6),AT(104,10,417,156),USE(PAM:U_NR),RIGHT
         LINE,AT(521,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@p#-##p),AT(573,10,,156),USE(KAT_NR),RIGHT
         LINE,AT(885,-10,0,197),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@S29),AT(938,10,,156),USE(PAM:NOS_P),LEFT
         LINE,AT(2813,-10,0,197),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@D5),AT(2865,10,469,156),USE(DATUMS),RIGHT
         STRING(@N_11.2),AT(3333,10,677,156),USE(VERT_S),RIGHT(1)
         LINE,AT(6771,-10,0,197),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,197),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(4792,10,573,156),USE(VERT_I),RIGHT
         LINE,AT(5365,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(5417,10,625,156),USE(AMO:NOL_LIN),RIGHT
         LINE,AT(6042,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(6094,10,625,156),USE(AMO:NOL_G_LI),RIGHT
         LINE,AT(7500,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(7552,10,677,156),USE(AMO:NOL_U_LI),RIGHT
         LINE,AT(8229,-10,0,197),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8281,10,625,156),USE(VERT_NON),RIGHT
         LINE,AT(8906,-10,0,197),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(8958,10,677,156),USE(VERT_B),RIGHT
         STRING(@N_11.2),AT(4063,10,677,156),USE(VERT_SB),RIGHT(1)
         LINE,AT(9688,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,94)
         LINE,AT(52,52,9635,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,114),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line50:1),COLOR(COLOR:Black)
         LINE,AT(885,-10,0,63),USE(?Line50:4),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,114),USE(?Line50:2),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,114),USE(?Line50:3),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,114),USE(?Line50:11),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,114),USE(?Line50:5),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,114),USE(?Line50:6),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,114),USE(?Line50:7),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,114),USE(?Line50:12),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,114),USE(?Line50:8),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,114),USE(?Line50:9),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,114),USE(?Line50:10),COLOR(COLOR:Black)
       END
RepFoot1 DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,197),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@S15),AT(156,10,,156),USE(KOPA),LEFT
         STRING(@S5),AT(2344,10,,156),USE(BKK),LEFT
         LINE,AT(2813,-10,0,197),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(3333,10,677,156),USE(VERT_SK),RIGHT(1)
         LINE,AT(4010,-10,0,197),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,197),USE(?Line3:22),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(4792,10,573,156),USE(VERT_IK),RIGHT
         LINE,AT(5365,-10,0,197),USE(?Line3:13),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(5417,10,625,156),USE(VERT_MK),RIGHT
         LINE,AT(6042,-10,0,197),USE(?Line3:14),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(6094,10,625,156),USE(VERT_NK),RIGHT
         LINE,AT(6771,-10,0,197),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,197),USE(?Line3:19),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(7552,10,677,156),USE(VERT_UK),RIGHT
         LINE,AT(8229,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8281,10,625,156),USE(VERT_NONK),RIGHT
         LINE,AT(8906,-10,0,197),USE(?Line3:17),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(8958,10,677,156),USE(VERT_BK),RIGHT
         STRING(@N_11.2),AT(4063,21,677,156),USE(VERT_SBK),RIGHT(1)
         LINE,AT(9688,-10,0,197),USE(?Line3:18),COLOR(COLOR:Black)
       END
RepFoot3 DETAIL,AT(,,,417)
         LINE,AT(52,-10,0,62),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,62),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,62),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,62),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,62),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,62),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(8229,-10,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(52,52,9635,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(365,156),USE(?String54)
         STRING(@s8),AT(938,156),USE(ACC_KODS),LEFT
         STRING(@D6),AT(8021,156),USE(DAT)
         STRING(@T4),AT(8802,156),USE(LAI)
       END
       FOOTER,AT(1000,7800,12000,52)
         LINE,AT(52,0,9635,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  CHECKOPEN(PAMAT,1)
  CHECKOPEN(KAT_K,1)
  DAT = TODAY()
  LAI = CLOCK()
  ATL_DATUMS = DATE(MEN_NR+1,1,GADS)-1
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('MEN_NR',MEN_NR)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      AMO:YYYYMM=DATE(MEN_NR,1,GADS)
      SET(AMO:YYYYMM_KEY,AMO:YYYYMM_KEY)
      CLEAR(AMO:RECORD)
      SET(AMO:NR_KEY,AMO:NR_KEY)
      Process:View{Prop:Filter} = 'AMO:yyyymm=DATE(MEN_NR,1,GADS)'
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
        VERT_N  =AMO:NOL_LIN
        VERT_NON+=AMO:IZSLEGTS
        VERT_B  = AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN-VERT_NON+PAM:NOL_V
        PRINT(RPT:DETAIL)
        VERT_SK += VERT_S
        VERT_IK += VERT_I
        VERT_MK += VERT_M
        VERT_NK += VERT_N
        VERT_UK += VERT_U
        VERT_NONK+= VERT_NON
        VERT_BK += VERT_B
        B:BKK=PAM:BKK
        GET(B_TABLE,B:BKK)
        IF ERROR()
          B:BKK=PAM:BKK
          B:SUMMA1=VERT_S
          B:SUMMAI=VERT_I
          B:SUMMAM=VERT_M
          B:SUMMA2=VERT_N
          B:SUMMAU=VERT_U
          B:SUMMANO=VERT_NON
          B:SUMMA3=VERT_B
          ADD(B_TABLE)
          SORT(B_TABLE,B:BKK)
        ELSE
          B:SUMMA1+=VERT_S
          B:SUMMAI+=VERT_I
          B:SUMMAM+=VERT_M
          B:SUMMA2+=VERT_N
          B:SUMMAU+=VERT_U
          B:SUMMANO+=VERT_NON
          B:SUMMA3+=VERT_B
          PUT(B_TABLE)
        .
!        K:KAT=SUB(PAM:KAT_NR,1,1)
        GET(K_TABLE,K:KAT)
        IF ERROR()
!          K:KAT=SUB(PAM:KAT_NR,1,1)
          K:SUMMA1=VERT_S
          K:SUMMAI=VERT_I
          K:SUMMAM=VERT_M
          K:SUMMA2=VERT_N
          K:SUMMAU=VERT_U
          K:SUMMANO=VERT_NON
          K:SUMMA3=VERT_B
          ADD(K_TABLE)
          SORT(K_TABLE,K:KAT)
        ELSE
          K:SUMMA1+=VERT_S
          K:SUMMAI+=VERT_I
          K:SUMMAM+=VERT_M
          K:SUMMA2+=VERT_N
          K:SUMMAU+=VERT_U
          K:SUMMANO+=VERT_NON
          K:SUMMA3+=VERT_B
          PUT(K_TABLE)
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
    PRINT(RPT:DETAIL1)
    PRINT(RPT:REPFOOT1)
    KOPA='Kopâ:'
    bkk=''
!   RPT:VERT_1K = rpt:vert_nk/12
!   RPT:VERT_3K = rpt:vert_nk/4
!!!    PRINT(RPT:REPFOOT2)
    KOPA='t.s. '
    loop i#= 1 to records(b_table)
      get(b_table,i#)
      bkk=b:bkk
      VERT_SK = b:summa1
      VERT_IK = b:summaI
      VERT_MK = b:summaM
      VERT_NK = b:summa2
      VERT_UK = b:summaU
      VERT_NONK= b:summaNO
!     RPT:VERT_1K = b:summa2/12
!     RPT:VERT_3K = b:summa2/4
      VERT_BK = b:summa3
!!!      PRINT(RPT:REPFOOT2)
      KOPA=''
    .
    PRINT(RPT:REPFOOT1)
    KOPA='t.s. '
    loop i#= 1 to records(K_table)
      get(K_table,i#)
      bkk=K:KAT
      VERT_SK = K:summa1
      VERT_IK = K:summaI
      VERT_MK = K:summaM
      VERT_NK = K:summa2
      VERT_UK = K:summaU
      VERT_NONK= K:summaNO
!     RPT:VERT_1K = K:summa2/12
!     RPT:VERT_3K = K:summa2/4
      VERT_BK = K:summa3
!!!      PRINT(RPT:REPFOOT2)
      KOPA=''
    .
    PRINT(RPT:REPFOOT3)
    ENDPAGE(report)
    ReportPreview(PrintPreviewQueue)
    IF GlobalResponse = RequestCompleted
      report{PROP:FlushPreview} = True
    END
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
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
  IF FilesOpened
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(B_TABLE)
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
P_NolAprG            PROCEDURE                    ! Declare Procedure
VERT_S               SREAL
VERT_I               SREAL
SAV_NOD              STRING(2)
SAV_NG               STRING(4)
SAK                  DECIMAL(12,2),DIM(5)
NOL                  DECIMAL(12,2),DIM(5)
NOD                  STRING(2),DIM(5)
!StringKatNod         STRING(30)
DAT                  LONG
LAI                  LONG
JADRUKA              BYTE

N_TABLE              QUEUE,PRE(N)  !NODAÏAS
NG                   STRING(2)
VERTS                DECIMAL(12,2),DIM(5)
VERTN                DECIMAL(12,2),DIM(5)
VERTB                DECIMAL(12,2),DIM(5)
                     .

O_TABLE              QUEUE,PRE(O)  !OBJEKTI
OBJ_NR               ULONG
VERTS                DECIMAL(12,2),DIM(5)
VERTN                DECIMAL(12,2),DIM(5)
VERTB                DECIMAL(12,2),DIM(5)
                     .

B_TABLE              QUEUE,PRE(B)
BKK                  STRING(5)
VERTS                DECIMAL(12,2),DIM(5)
VERTN                DECIMAL(12,2),DIM(5)
VERTB                DECIMAL(12,2),DIM(5)
                     .

GR                   STRING(3),DIM(5)
likme                sreal
VERTS1               DECIMAL(12,2)
VERTS2               DECIMAL(12,2)
VERTS3               DECIMAL(12,2)
VERTS4               DECIMAL(12,2)
VERTS5               DECIMAL(12,2)
VERTN1               DECIMAL(12,2)
VERTN2               DECIMAL(12,2)
VERTN3               DECIMAL(12,2)
VERTN4               DECIMAL(12,2)
VERTN5               DECIMAL(12,2)
VERTB1               DECIMAL(12,2)
VERTB2               DECIMAL(12,2)
VERTB3               DECIMAL(12,2)
VERTB4               DECIMAL(12,2)
VERTB5               DECIMAL(12,2)

N_BKK                STRING(5)
VERTSK1              DECIMAL(12,2)
VERTSK2              DECIMAL(12,2)
VERTSK3              DECIMAL(12,2)
VERTSK4              DECIMAL(12,2)
VERTSK5              DECIMAL(12,2)
VERTNK1              DECIMAL(12,2)
VERTNK2              DECIMAL(12,2)
VERTNK3              DECIMAL(12,2)
VERTNK4              DECIMAL(12,2)
VERTNK5              DECIMAL(12,2)
VERTBK1              DECIMAL(12,2)
VERTBK2              DECIMAL(12,2)
VERTBK3              DECIMAL(12,2)
VERTBK4              DECIMAL(12,2)
VERTBK5              DECIMAL(12,2)

VERT_NON             DECIMAL(12,2)

ATL_DATUMS1          LONG
ATL_DATUMS2          LONG
ATL_DATUMS3          LONG
ATL_DATUMS4          LONG
ATL_DATUMS5          LONG

VIRSRAKSTS           STRING(80)
NodText              STRING(30)
C                    ULONG,DIM(4,2)

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

!       FOOTER,AT(120,7950,12000,52)
!         LINE,AT(104,0,11094,0),USE(?Line1:4),COLOR(00H)
!       END
!report REPORT,AT(120,1727,12000,6302),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),LANDSCAPE,THOUS
!       HEADER,AT(120,300,12000,1427)
!

report REPORT,AT(500,1402,10000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,100,10000,1302),USE(?unnamed)
         LINE,AT(104,1250,9740,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2969,156,4375,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1802,417,6729,260),USE(VIRSRAKSTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma LI7'),AT(9198,260,573,208),USE(?String115),LEFT
         STRING(@P<<<#. lapaP),AT(8958,469,729,208),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(104,781,9740,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,781,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2552,781,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3385,781,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4167,781,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5000,781,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5781,781,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6615,781,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7396,781,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(8229,781,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(9010,781,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(9844,781,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Uzsk.vçrtîba'),AT(1802,833,729,208),USE(?String5:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(2594,833,781,208),USE(?String5:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.vçrtîba'),AT(3417,833,729,208),USE(?String5:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(4198,833,781,208),USE(?String5:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.vçrtîba'),AT(5031,833,729,208),USE(?String5:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(5823,833,781,208),USE(?String5:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.vçrtîba'),AT(6646,833,729,208),USE(?String5:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(7438,833,781,208),USE(?String5:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.vçrtîba'),AT(8271,833,729,208),USE(?String5:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrtîba'),AT(9052,833,781,208),USE(?String5:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(1802,1042,729,208),USE(?String5:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(2604,1042,156,208),USE(?String5:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(2750,1042,625,208),USE(atl_datums1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(3417,1042,729,208),USE(?String5:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(4219,1042,156,208),USE(?String5:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4354,1042,625,208),USE(atl_datums2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(5031,1042,729,208),USE(?String5:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(5833,1042,156,208),USE(?String5:14),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(5979,1042,625,208),USE(atl_datums3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(6646,1042,729,208),USE(?String5:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(7448,1042,156,208),USE(?String5:17),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(7594,1042,625,208),USE(atl_datums4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(8271,1042,729,208),USE(?String5:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(9063,1042,156,208),USE(?String5:20),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(9208,1042,625,208),USE(atl_datums5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,781,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,313),USE(?unnamed:4)
         STRING(@N-_13.2),AT(5813,10,780,156),USE(VERTB3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6615,-10,0,333),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(5052,10,677,156),USE(VERTS3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5781,-10,0,333),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,333),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4198,10,780,156),USE(VERTB2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4167,-10,0,333),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,333),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(3438,10,677,156),USE(VERTS2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2552,-10,0,333),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(1823,156,,156),USE(VERTN1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(3438,156,,156),USE(VERTN2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(5052,156,,156),USE(VERTN3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(6667,156,,156),USE(VERTN4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(8281,156,,156),USE(VERTN5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9844,-10,0,333),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(9042,0,781,156),USE(VERTB5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s25),AT(135,156,1615,156),USE(NodText),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9010,-10,0,333),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(8281,10,677,156),USE(VERTS5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8229,-10,0,333),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(7427,10,780,156),USE(VERTB4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7396,-10,0,333),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(6667,10,677,156),USE(VERTS4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(2583,10,780,156),USE(VERTB1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,-10,0,333),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@s7),AT(135,0,521,156),USE(N_BKK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,-10,0,333),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(1823,10,677,156),USE(VERTS1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
LINE   DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,114),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,114),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(2552,0,0,114),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,114),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,114),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(5781,0,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,114),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,114),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(8229,0,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(104,52,9740,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
KOPA   DETAIL,AT(,,,313),USE(?unnamed:5)
         STRING(@N-_13.2),AT(5813,10,780,156),USE(VERTBK3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6615,-10,0,333),USE(?Line21:20),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(5052,10,677,156),USE(VERTSK3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5781,-10,0,333),USE(?Line21:19),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,333),USE(?Line21:18),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4198,10,780,156),USE(VERTBK2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4167,-10,0,333),USE(?Line21:17),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,333),USE(?Line21:16),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(3438,10,677,156),USE(VERTSK2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2552,-10,0,333),USE(?Line21:15),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(1823,156,,156),USE(VERTNK1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(3448,156,,156),USE(VERTNK2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(5063,156,,156),USE(VERTNK3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(6667,156,,156),USE(VERTNK4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(8281,156,,156),USE(VERTNK5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9844,-10,0,333),USE(?Line21:24),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(9042,10,780,156),USE(VERTBK5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9010,-10,0,333),USE(?Line21:23),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(8250,10,677,156),USE(VERTSK5),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8229,-10,0,333),USE(?Line21:22),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(7427,10,780,156),USE(VERTBK4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7396,-10,0,333),USE(?Line21:21),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(6635,10,677,156),USE(VERTSK4),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(2583,10,780,),USE(VERTBK1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,-10,0,333),USE(?Line21:13),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(208,104,417,208),USE(?KOPA),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,-10,0,333),USE(?Line21:14),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(1823,10,677,156),USE(VERTSK1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
FOOTER DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(104,0,0,62),USE(?Line27:2),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,62),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(2552,0,0,62),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,62),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,62),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,62),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5781,0,0,62),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,62),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,62),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(8229,0,0,62),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,62),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(9844,-10,0,62),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(104,52,9740,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@d06.),AT(8906,63),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t1),AT(9531,63),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(500,7950,10000,10),USE(?unnamed:3)
         LINE,AT(104,0,9740,0),USE(?Line1:5),COLOR(COLOR:Black)
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

  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  DAT = TODAY()
  LAI = CLOCK()
!  IF F:KAT_NR>'000' THEN StringKatNod='Kategorija: '&FORMAT(F:KAT_NR,@P#-##P).
!  IF F:NODALA THEN StringKatNod=clip(StringKatNod)&' Nodaïa: '&F:NODALA.
  VIRSRAKSTS = 'Pamatlîdzekïu nolietojuma kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' (LIN.metode)'
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

  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND('S_DAT',S_DAT)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
!      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1))' !NAV NOÒEMTS IEPR.G-OS
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
          IF ~OPENANSI('NOLAPRG.TXT')
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
          OUTA:LINE='Nodaïa'&CHR(9)&'Uzsk.vçrtîba'&CHR(9)&'Atl.vçrtîba'&CHR(9)&'Uzsk.vçrtîba'&CHR(9)&'Atl.vçrtîba'&CHR(9)&|
          'Uzsk.vçrtîba'&CHR(9)&'Atl.vçrtîba'&CHR(9)&'Uzsk.vçrtîba'&CHR(9)&'Atl.vçrtîba'&CHR(9)&'Uzsk.vçrtîba'&CHR(9)&|
          'Atl.vçrtîba'
          ADD(OUTFILEANSI)
          OUTA:LINE='BKK'&CHR(9)&'Nolietojums'&CHR(9)&'uz '&format(atl_datums1,@d10.)&CHR(9)&'Nolietojums'&CHR(9)&|
          'uz '&format(atl_datums2,@d10.)&CHR(9)&'Nolietojums'&CHR(9)&'uz '&format(atl_datums3,@d10.)&CHR(9)&|
          'Nolietojums'&CHR(9)&'uz '&format(atl_datums4,@d10.)&CHR(9)&'Nolietojums'&CHR(9)&'uz '&format(atl_datums5,@d10.)
          ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        CLEAR(SAK)
        CLEAR(NOL)
        CLEAR(NOD)
        JADRUKA=FALSE
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
            CLEAR(AMO:RECORD)
            AMO:yyyymm=DATE(1,1,GADS)
            AMO:U_NR=PAM:U_NR
            SET(AMO:NR_KEY,AMO:NR_KEY)
            LOOP
               NEXT(PAMAM)
               IF ERROR() OR ~(PAM:U_NR=AMO:U_NR) OR (YEAR(AMO:YYYYMM) > GADS)
                  BREAK
               .
               JADRUKA=TRUE
               M#=MONTH(AMO:YYYYMM)
               IF M#=1
                  NOD[1]= AMO:NODALA
                  NOL[1]= AMO:NOL_U_LI+PAM:NOL_V
                  SAK[1]= AMO:SAK_V_LI+PAM:NOL_V
               ELSIF M#=3 OR M#=6 OR M#=9 OR M#=12
                  NOD[M#/3+1]= AMO:NODALA
!                     VERT_N  +=AMO:NOL_LIN
                  IF INRANGE(PAM:END_DATE,DATE(MONTH(AMO:YYYYMM),1,GADS),DATE(MONTH(AMO:YYYYMM)+1,1,GADS)-1)
                     VERT_NON=AMO:IZSLEGTS+PAM:NOL_V !+UZKRÂTAIS LÎDZ 1995.G.(IZMAIÒAS PÇD.MÇNESÎ IEKÐ AMO:IZSLEGTS)
                     NOL[M#/3+1]=0
                  ELSE
                     VERT_NON=0
                     NOL[M#/3+1]= AMO:NOL_U_LI+AMO:NOL_LIN+PAM:NOL_V !+NOLIETOJUMS X.MÇN.+UZKRÂTAIS LÎDZ 1995.G.
                  .
                  IF INRANGE(PAM:EXPL_DATUMS,DATE(M#,1,GADS),DATE(M#+1,1,GADS)-1) !IEGÂDÂTS PÇD.M.,NAV SÂK.V.
                     SAK[M#/3+1]= PAM:BIL_V+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
                  ELSE
                     SAK[M#/3+1]= AMO:SAK_V_LI+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
!       stop(SAK[M#/3+1]&'='&AMO:SAK_V_LI&'+'&PAM:NOL_V&'+'&AMO:KAPREM&'+'&AMO:PARCEN&'+'&AMO:PARCENLI&'-'&VERT_NON) !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
                  .
!                     VERT_N  +=AMO:NOL_LIN
!                     IF INRANGE(PAM:END_DATE,DATE(MONTH(AMO:YYYYMM),1,GADS),DATE(MONTH(AMO:YYYYMM)+1,1,GADS)-1)
!                        VERT_NON=AMO:IZSLEGTS+PAM:NOL_V !+UZKRÂTAIS LÎDZ 1995.G.(IZMAIÒAS PÇD.MÇNESÎ IEKÐ AMO:IZSLEGTS)
!                        VERT_U=0
!                     ELSE
!                        VERT_NON=0
!                        VERT_U  = AMO:NOL_U_LI+AMO:NOL_LIN+PAM:NOL_V !+NOLIETOJUMS 12.MÇN.+UZKRÂTAIS LÎDZ 1995.G.
!                     .
!                     IF INRANGE(PAM:EXPL_DATUMS,DATE(MEN_NR,1,GADS),DATE(MEN_NR+1,1,GADS)-1) !IEGÂDÂTS PÇD.M.,NAV SÂK.V.
!                        VERT_B  = PAM:BIL_V+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_U-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
!                     ELSE
!                        VERT_B  = AMO:SAK_V_LI+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_U-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
!                     .
               .
            .
            IF JADRUKA=TRUE
              LOOP N# = 1 TO 5
                GET(N_TABLE,0)
                N:NG=NOD[N#]
                GET(N_TABLE,N:NG)
                IF ERROR()
                  CLEAR(N:VERTS)
                  CLEAR(N:VERTN)
                  N:VERTS[N#]=SAK[N#]
                  N:VERTN[N#]=NOL[N#]
                  ADD(N_TABLE)
                  SORT(N_TABLE,N:NG)
                ELSE
                  N:VERTS[N#]+=SAK[N#]
                  N:VERTN[N#]+=NOL[N#]
                  PUT(N_TABLE)
                .
              .
              LOOP N# = 1 TO 5
                GET(O_TABLE,0)
                O:OBJ_NR=PAM:OBJ_NR
                GET(O_TABLE,O:OBJ_NR)
                IF ERROR()
                  CLEAR(O:VERTS)
                  CLEAR(O:VERTN)
                  O:VERTS[N#]=SAK[N#]
                  O:VERTN[N#]=NOL[N#]
                  ADD(O_TABLE)
                  SORT(O_TABLE,O:OBJ_NR)
                ELSE
                  O:VERTS[N#]+=SAK[N#]
                  O:VERTN[N#]+=NOL[N#]
                  PUT(O_TABLE)
                .
              .
              LOOP N# = 1 TO 5
                GET(B_TABLE,0)
                B:BKK=PAM:BKK
                GET(B_TABLE,B:BKK)
                IF ERROR()
                  CLEAR(B:VERTS)
                  CLEAR(B:VERTN)
                  B:VERTS[N#]=SAK[N#]
                  B:VERTN[N#]=NOL[N#]
                  ADD(B_TABLE)
                  SORT(B_TABLE,B:BKK)
                ELSE
                  B:VERTS[N#]+=SAK[N#]
                  B:VERTN[N#]+=NOL[N#]
                  PUT(B_TABLE)
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF RECORDS(N_TABLE)>1
       GET(N_TABLE,0)         !Nodaïas
       LOOP I#=1 TO RECORDS(N_TABLE)
         GET(N_TABLE,I#)
         VERTS1 = N:VERTS[1]
         VERTS2 = N:VERTS[2]
         VERTS3 = N:VERTS[3]
         VERTS4 = N:VERTS[4]
         VERTS5 = N:VERTS[5]
         VERTN1 = N:VERTN[1]
         VERTN2 = N:VERTN[2]
         VERTN3 = N:VERTN[3]
         VERTN4 = N:VERTN[4]
         VERTN5 = N:VERTN[5]
         VERTB1 = N:VERTS[1]-N:VERTN[1]
         VERTB2 = N:VERTS[2]-N:VERTN[2]
         VERTB3 = N:VERTS[3]-N:VERTN[3]
         VERTB4 = N:VERTS[4]-N:VERTN[4]
         VERTB5 = N:VERTS[5]-N:VERTN[5]
         N_BKK  = N:NG
         IF N_BKK
            NodText = GETNODALAS(N_BKK,1)
         ELSE
            NodText = 'bez nodaïas'
         .
         IF F:DBF='W'
           PRINT(RPT:DETAIL)
         ELSE   !EXCEL
           OUTA:LINE=N_BKK&CHR(9)&LEFT(FORMAT(VERTS1,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB1,@N-_13.2))&CHR(9)&|
           LEFT(FORMAT(VERTS2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS3,@N-_13.2))&|
           CHR(9)&LEFT(FORMAT(VERTB3,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS4,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB4,@N-_13.2))&|
           CHR(9)&LEFT(FORMAT(VERTS5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
           ADD(OUTFILEANSI)
           OUTA:LINE=NodText&CHR(9)&LEFT(FORMAT(VERTN1,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN2,@N-_13.2))&CHR(9)&|
           CHR(9)&LEFT(FORMAT(VERTN3,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN4,@N-_13.2))&CHR(9)&CHR(9)&|
           LEFT(FORMAT(VERTN5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
           ADD(OUTFILEANSI)
         END
       .
       IF F:DBF='W'
           PRINT(RPT:LINE)
       ELSE
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
    .
    IF RECORDS(O_TABLE)>1
       GET(O_TABLE,0)         !Objekti
       LOOP I#=1 TO RECORDS(O_TABLE)
         GET(O_TABLE,I#)
         VERTS1 = O:VERTS[1]
         VERTS2 = O:VERTS[2]
         VERTS3 = O:VERTS[3]
         VERTS4 = O:VERTS[4]
         VERTS5 = O:VERTS[5]
         VERTN1 = O:VERTN[1]
         VERTN2 = O:VERTN[2]
         VERTN3 = O:VERTN[3]
         VERTN4 = O:VERTN[4]
         VERTN5 = O:VERTN[5]
         VERTB1 = O:VERTS[1]-O:VERTN[1]
         VERTB2 = O:VERTS[2]-O:VERTN[2]
         VERTB3 = O:VERTS[3]-O:VERTN[3]
         VERTB4 = O:VERTS[4]-O:VERTN[4]
         VERTB5 = O:VERTS[5]-O:VERTN[5]
         N_BKK  = O:OBJ_NR
         IF O:OBJ_NR
            NodText = GETPROJEKTI(O:OBJ_NR,1)
         ELSE
            NodText = 'bez Obj.(Pr.)'
         .
         IF F:DBF='W'
           PRINT(RPT:DETAIL)
         ELSE
           OUTA:LINE=N_BKK&CHR(9)&LEFT(FORMAT(VERTS1,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB1,@N-_13.2))&CHR(9)&|
           LEFT(FORMAT(VERTS2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS3,@N-_13.2))&|
           CHR(9)&LEFT(FORMAT(VERTB3,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS4,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB4,@N-_13.2))&|
           CHR(9)&LEFT(FORMAT(VERTS5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
           ADD(OUTFILEANSI)
           OUTA:LINE=NodText&CHR(9)&LEFT(FORMAT(VERTN1,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN2,@N-_13.2))&CHR(9)&|
           CHR(9)&LEFT(FORMAT(VERTN3,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN4,@N-_13.2))&CHR(9)&CHR(9)&|
           LEFT(FORMAT(VERTN5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
           ADD(OUTFILEANSI)
         END
       .
       IF F:DBF='W'
           PRINT(RPT:LINE)
       ELSE
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       .
    .
    GET(B_TABLE,0)            !bkk
    LOOP I#=1 TO RECORDS(B_TABLE)
      GET(B_TABLE,I#)
      VERTS1 = B:VERTS[1]
      VERTS2 = B:VERTS[2]
      VERTS3 = B:VERTS[3]
      VERTS4 = B:VERTS[4]
      VERTS5 = B:VERTS[5]
      VERTN1 = B:VERTN[1]
      VERTN2 = B:VERTN[2]
      VERTN3 = B:VERTN[3]
      VERTN4 = B:VERTN[4]
      VERTN5 = B:VERTN[5]
      VERTB1 = B:VERTS[1]-B:VERTN[1]
      VERTB2 = B:VERTS[2]-B:VERTN[2]
      VERTB3 = B:VERTS[3]-B:VERTN[3]
      VERTB4 = B:VERTS[4]-B:VERTN[4]
      VERTB5 = B:VERTS[5]-B:VERTN[5]
      N_BKK  = B:BKK
      NodText = GETKON_K(B:BKK,0,2)
      IF F:DBF='W'
         PRINT(RPT:DETAIL)
      ELSE
         OUTA:LINE=N_BKK&CHR(9)&LEFT(FORMAT(VERTS1,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB1,@N-_13.2))&CHR(9)&|
         LEFT(FORMAT(VERTS2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS3,@N-_13.2))&CHR(9)&|
         LEFT(FORMAT(VERTB3,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTS4,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB4,@N-_13.2))&CHR(9)&|
         LEFT(FORMAT(VERTS5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
         ADD(OUTFILEANSI)
         OUTA:LINE=NodText&CHR(9)&LEFT(FORMAT(VERTN1,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN2,@N-_13.2))&CHR(9)&CHR(9)&|
         LEFT(FORMAT(VERTN3,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTN4,@N-_13.2))&CHR(9)&CHR(9)&|
         LEFT(FORMAT(VERTN5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
         ADD(OUTFILEANSI)
      END
      VERTSK1+= VERTS1
      VERTSK2+= VERTS2
      VERTSK3+= VERTS3
      VERTSK4+= VERTS4
      VERTSK5+= VERTS5
      VERTNk1+= VERTN1
      VERTNK2+= VERTN2
      VERTNK3+= VERTN3
      VERTNK4+= VERTN4
      VERTNK5+= VERTN5
      VERTBK1+= VERTS1-VERTN1
      VERTBK2+= VERTS2-VERTN2
      VERTBK3+= VERTS3-VERTN3
      VERTBK4+= VERTS4-VERTN4
      VERTBK5+= VERTS5-VERTN5
    .

    IF F:DBF='W'
        PRINT(RPT:LINE)
        PRINT(RPT:KOPA)
        PRINT(RPT:FOOTER)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&LEFT(FORMAT(VERTSk1,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTBk1,@N-_13.2))&CHR(9)&|
        LEFT(FORMAT(VERTSk2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTBk2,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTSk3,@N-_13.2))&CHR(9)&|
        LEFT(FORMAT(VERTBk3,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTSk4,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTBk4,@N-_13.2))&CHR(9)&|
        LEFT(FORMAT(VERTSk5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTBk5,@N-_13.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&LEFT(FORMAT(VERTNk1,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTNk2,@N-_13.2))&CHR(9)&CHR(9)&|
        LEFT(FORMAT(VERTNk3,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERTNk4,@N-_13.2))&CHR(9)&CHR(9)&|
        LEFT(FORMAT(VERTNk5,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERTB5,@N-_13.2))
        ADD(OUTFILEANSI)
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(N_TABLE)
  FREE(B_TABLE)
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
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAMAM')
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

P_IIKP               PROCEDURE                    ! Declare Procedure
VERT_SG              DECIMAL(10,2)
VERT_IEGG            DECIMAL(10,2)
VERT_PARG            DECIMAL(10,2)
VERT_IZNG            DECIMAL(10,2)
VERT_SBG             DECIMAL(10,2)
VERT_NSG             DECIMAL(10,3)
VERT_NG              DECIMAL(10,3)
VERT_NIZNG           DECIMAL(10,3)
VERT_NBG             DECIMAL(10,3)
VERT_ASG             DECIMAL(10,2)
VERT_ABG             DECIMAL(10,2)
VERT_SM              DECIMAL(10,2),DIM(4)
VERT_IEGM            DECIMAL(10,2),DIM(4)
VERT_PARM            DECIMAL(10,2),DIM(4)
VERT_IZNM            DECIMAL(10,2),DIM(4)
VERT_SBM             DECIMAL(10,2),DIM(4)
VERT_NSM             DECIMAL(10,3),DIM(4)
VERT_NM              DECIMAL(10,3),DIM(4)
VERT_NIZNM           DECIMAL(10,3),DIM(4)
VERT_NBM             DECIMAL(10,3),DIM(4)
VERT_ASM             DECIMAL(10,2),DIM(4)
VERT_ABM             DECIMAL(10,2),DIM(4)
IEGVEIDS             STRING(40)
IEGkopa              STRING(40)
VERT_S               DECIMAL(10,2)
VERT_IEG             DECIMAL(10,2)
VERT_PAR             DECIMAL(10,2)
VERT_IZN             DECIMAL(10,2)
VERT_SB              DECIMAL(10,2)
VERT_NS              DECIMAL(10,3)
VERT_N               DECIMAL(10,3)
VERT_NIZN            DECIMAL(10,3)
VERT_NB              DECIMAL(10,3)
VERT_AS              DECIMAL(10,2)
VERT_AB              DECIMAL(10,2)
VERT_SK              DECIMAL(10,2)
VERT_IEGK            DECIMAL(10,2)
VERT_PARK            DECIMAL(10,2)
VERT_IZNK            DECIMAL(10,2)
VERT_SBK             DECIMAL(10,2)
VERT_NSK             DECIMAL(10,3)
VERT_NK              DECIMAL(10,3)
VERT_NIZNK           DECIMAL(10,3)
VERT_NBK             DECIMAL(10,3)
VERT_ASK             DECIMAL(10,2)
VERT_ABK             DECIMAL(10,2)
VERT_I               SREAL
IEGADATS             DECIMAL(10,2)
SAVE_IIV             STRING(1)
GADS2                DECIMAL(2)
SAV_U_NR             ULONG
VIRSRAKSTS           STRING(80)

K_TABLE              QUEUE,PRE(K)
IIV                  STRING(2)
VERT_S               DECIMAL(10,2)
VERT_IEG             DECIMAL(10,2)
VERT_PAR             DECIMAL(10,2)
VERT_IZN             DECIMAL(10,2)
VERT_NS              DECIMAL(10,3)
VERT_N               DECIMAL(10,3)
VERT_NIZN            DECIMAL(10,3)
                     .

B_TABLE              QUEUE,PRE(B)
BKK                  STRING(5)
VERT_S               DECIMAL(10,2)
VERT_IEG             DECIMAL(10,2)
VERT_PAR             DECIMAL(10,2)
VERT_IZN             DECIMAL(10,2)
VERT_NS              DECIMAL(10,3)
VERT_N               DECIMAL(10,3)
VERT_NIZN            DECIMAL(10,3)
                     .

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
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:DATUMS)
                     END

report REPORT,AT(250,2625,12000,5000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(250,1000,12000,1625),USE(?unnamed)
         LINE,AT(208,1615,10208,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Atlikusî vçrtîba'),AT(9094,1146,1219,208),USE(?String6:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums (Vçrtîbas norakstîjumi)'),AT(6188,1146,2688,208),USE(?String6:4),CENTER, |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ vçrtîba'),AT(3281,1146,1760,208),USE(?String6:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ieguldîjuma veids'),AT(260,1406,2344,208),USE(?String6:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(2635,1406,573,156),USE(S_DAT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieg.&Izg.'),AT(3271,1406,573,208),USE(?String6:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrt.'),AT(3885,1406,573,208),USE(?String6:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izòemð.'),AT(4531,1406,573,208),USE(?String6:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçíin.'),AT(6406,1406,573,208),USE(?String6:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Koriìçts'),AT(7031,1406,677,208),USE(?String6:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgts'),AT(7760,1406,625,208),USE(?String6:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5135,1406,573,156),USE(B_DAT),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5771,1406,573,156),USE(S_DAT,,?S_DAT:2),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(8417,1406,573,156),USE(B_DAT,,?B_DAT:2),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(9052,1406,573,156),USE(S_DAT,,?S_DAT:3),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(9740,1406,573,156),USE(B_DAT,,?B_DAT:3),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2604,1354,7813,0),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(3229,1354,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(3854,1354,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4479,1354,0,260),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(5104,1354,0,260),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6354,1354,0,260),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(6979,1354,0,260),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7708,1354,0,260),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(8385,1354,0,260),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(9688,1354,0,260),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(208,1094,10208,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2604,1094,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(5729,1094,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(9010,1094,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(10417,1094,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Ilgtermiòa'),AT(260,1146,2344,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1094,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2604,104,4271,260),USE(client),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6979,104),USE(GL:VID_NR),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2552,365,5729,0),USE(?Line66),COLOR(COLOR:Black)
         STRING('uzòçmuma (uzòçmçjsabiedrîbas) nosaukums, nod. maks. reì. Nr.'),AT(3333,417,3281,156), |
             USE(?String64)
         STRING('Mçra vienîba: EUR'),AT(9500,885,927,208),USE(?String66)
         STRING(@s80),AT(1563,719,7938,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
GRHEAD DETAIL,AT(,,,406)
         LINE,AT(208,-10,0,427),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(2604,-10,0,427),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,427),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,427),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,427),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,427),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,427),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,427),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,427),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,427),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,427),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,427),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,427),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,427),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(208,52,10208,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s35),AT(260,104,2240,156),USE(IegKopa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_9B),AT(2625,104,573,208),USE(vert_sg),RIGHT
         STRING(@N_9B),AT(3260,104,563,208),USE(VERT_IEGG),RIGHT
         STRING(@N-_10B),AT(3885,104,563,208),USE(VERT_PARG),RIGHT
         STRING(@N_9B),AT(4500,104,573,208),USE(VERT_IZNG),RIGHT
         STRING(@N_9B),AT(5135,104,563,208),USE(VERT_SBG),RIGHT
         STRING(@N_9B),AT(5760,104,563,208),USE(VERT_NSG),RIGHT
         STRING(@N_9B),AT(6396,104,552,208),USE(VERT_NG),RIGHT
         STRING(@N_9B),AT(7760,94,594,208),USE(VERT_NIZNG),RIGHT
         STRING(@N_9B),AT(8417,94,573,208),USE(VERT_NBG),RIGHT
         STRING(@N_9B),AT(9031,94,635,208),USE(VERT_ASG),RIGHT
         STRING(@N_9B),AT(9708,94,677,208),USE(VERT_ABG),RIGHT
         LINE,AT(208,313,677,0),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(1615,313,8802,0),USE(?Line19:2),COLOR(COLOR:Black)
         STRING('tai skaitâ'),AT(938,260,677,156),USE(?String6:17),CENTER,FONT(,9,,,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(5104,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N_9B),AT(5135,10,563,156),USE(VERT_SB),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N_9B),AT(5750,10,573,156),USE(VERT_NS),RIGHT
         LINE,AT(6354,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N_9B),AT(6385,10,563,156),USE(VERT_N),RIGHT
         LINE,AT(6979,-10,0,198),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         STRING(@N_9B),AT(7750,10,604,156),USE(VERT_NIZN),RIGHT
         LINE,AT(8385,-10,0,198),USE(?Line2:39),COLOR(COLOR:Black)
         STRING(@N_9B),AT(8417,10,563,156),USE(VERT_NB),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N_9B),AT(9052,10,604,156),USE(VERT_AS),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line2:41),COLOR(COLOR:Black)
         STRING(@N_9B),AT(9708,10,677,156),USE(VERT_AB),RIGHT
         LINE,AT(10417,-10,0,198),USE(?Line2:42),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N_9B),AT(3260,10,563,156),USE(VERT_IEG),RIGHT
         LINE,AT(3854,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-_8B),AT(3885,10,563,156),USE(VERT_PAR),RIGHT
         LINE,AT(4479,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N_9B),AT(4510,10,563,156),USE(VERT_IZN),RIGHT
         LINE,AT(2604,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@s40),AT(260,0,2292,156),USE(IEGVEIDS),LEFT
         STRING(@N_9B),AT(2635,10,563,156),USE(vert_s),RIGHT
       END
RepFoot DETAIL,AT(,,,396)
         LINE,AT(5104,-10,0,323),USE(?Line2:48),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,323),USE(?Line2:46),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,323),USE(?Line2:47),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,323),USE(?Line2:45),COLOR(COLOR:Black)
         LINE,AT(2604,-10,0,323),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,323),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(208,52,10208,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('KOPÂ :'),AT(313,104),USE(?String53),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_9B),AT(2635,94,563,208),USE(vert_sK),RIGHT
         STRING(@N_9B),AT(3260,104,563,208),USE(VERT_IEGK),RIGHT
         STRING(@N-_10B),AT(3865,104,583,208),USE(VERT_PARK),RIGHT
         STRING(@N_9B),AT(4510,104,563,208),USE(VERT_IZNK),RIGHT
         STRING(@N_9B),AT(5125,104,573,208),USE(VERT_SBK),RIGHT
         STRING(@N_9B),AT(5760,104,563,208),USE(VERT_NSK),RIGHT
         STRING(@N_9B),AT(6385,104,563,208),USE(VERT_NK),RIGHT
         STRING(@N_9B),AT(7740,94,615,208),USE(VERT_NIZNK),RIGHT
         STRING(@N_9B),AT(8396,94,594,208),USE(VERT_NBK),RIGHT
         STRING(@N_9B),AT(9042,94,625,208),USE(VERT_ASK),RIGHT
         STRING(@N_9B),AT(9708,94,677,208),USE(VERT_ABK),RIGHT
         LINE,AT(208,313,10208,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,323),USE(?Line2:55),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,323),USE(?Line2:54),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,323),USE(?Line2:53),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,323),USE(?Line2:52),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,323),USE(?Line2:51),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,323),USE(?Line2:50),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,323),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,323),USE(?Line2:49),COLOR(COLOR:Black)
       END
PARAKSTI DETAIL,AT(,,,823)
         STRING(@s25),AT(198,313),USE(SYS:AMATS1),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1760,521,2292,0),USE(?Line67),COLOR(COLOR:Black)
         STRING(@s25),AT(2135,573),USE(SYS:PARAKSTS1),CENTER
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  VIRSRAKSTS = 'Pamatlîdzekïu nolietojuma kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' (LIN.metode)'
  F:DTK=1 !IZVÇRSUNU NEVAJAG...PAGAIDÂM...

  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1

  BIND('S_DAT',S_DAT)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ilgtermiòa ieguldîjumu kustîbas pârskats'
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
          IF ~OPENANSI('P_IIKK.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(CLIENT)&' '&GL:VID_NR
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Ilgtermiòa'&CHR(9)&'Sakotnçjâ vçrtîba'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
             'Nolietojums (Vçrtîbas norakstîjumi)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Atlikusî vçrtîba'
             ADD(OUTFILEANSI)
             OUTA:LINE='ieguldîjuma veids'&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&'Ieg,Izg.'&CHR(9)&'Pârvçrt.'&CHR(9)&|
             'Izòemð.'&CHR(9)&FORMAT(B_DAT,@D06.)&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&'Aprçíin.'&CHR(9)|
             &'Koriìçts'&CHR(9)&'Izslçgts'&CHR(9)&FORMAT(B_DAT,@N06.)&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&|
             FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
          ELSE !WORD
             OUTA:LINE='Ilgtermiòa ieguldîjuma veids'&CHR(9)&'Sâk.v. '&FORMAT(S_DAT,@D06.)&CHR(9)&'Ieg, Izg.'&CHR(9)&|
             'Pârvçrt.'&CHR(9)&'Izòemð.'&CHR(9)&'Sâk.v. '&FORMAT(B_DAT,@D06.)&CHR(9)&'Noliet. '&|
             FORMAT(S_DAT,@D06.)&CHR(9)&'Aprçíin.'&CHR(9)&'Koriìçts'&CHR(9)&'Izslçgts'&CHR(9)&'Noliet. '&|
             FORMAT(B_DAT,@D06.)&CHR(9)&'Atlik.v. '&FORMAT(S_DAT,@D06.)&CHR(9)&'Atl.v. '&FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         VERT_IEG =0
         VERT_PAR =0
         VERT_IZN =0
         VERT_S   =0
         VERT_NS  =0
         VERT_N   =0
         VERT_NIZN =0
         CLEAR(AMO:RECORD)
         AMO:yyyymm=S_DAT
         AMO:U_NR=PAM:U_NR
         SET(AMO:NR_KEY,AMO:NR_KEY)
         LOOP
           NEXT(PAMAM)
           IF ERROR() OR ~(PAM:U_NR=AMO:U_NR AND AMO:YYYYMM < B_DAT)
              BREAK
           .
!           IF MONTH(AMO:YYYYMM)=1             ! VÇRTÎBA UZ GADA SÂKUMU
           IF MONTH(AMO:YYYYMM)=MONTH(S_DAT)  ! VÇRTÎBA UZ GADA SÂKUMU
              VERT_S=AMO:SAK_V_LI+PAM:NOL_V   !+NOLIETOJUMS 1994
              VERT_NS=AMO:NOL_U_LI+PAM:NOL_V  !+NOLIETOJUMS 1994
           .
           GADS=YEAR(AMO:YYYYMM)
           IF INRANGE(PAM:EXPL_DATUMS,DATE(MONTH(AMO:YYYYMM),1,GADS),DATE(MONTH(AMO:YYYYMM)+1,1,GADS)-1) !IEGÂDÂTS Ð.M.
              VERT_IEG =PAM:BIL_V
           .
           VERT_IEG +=AMO:KAPREM
           VERT_PAR +=AMO:PARCEN+AMO:PARCENLI
           VERT_N   +=AMO:NOL_LIN
           IF MONTH(AMO:YYYYMM)=12 OR AMO:IZSLEGTS    !GADA VAI P/L BEIGAS
              IF YEAR(PAM:EXPL_DATUMS)<1995
                 Y#=YEAR(AMO:YYYYMM)-1995+1
              ELSE
                 Y#=YEAR(AMO:YYYYMM)-YEAR(PAM:EXPL_DATUMS)+1
              .
              IF AMO:IZSLEGTS !NOÒEMTS
                 VERT_IZN +=AMO:IZSLEGTS+PAM:NOL_V
                 VERT_NIZN+=VERT_NS+VERT_N            !PAM:NOL_V JAU PIESKAITÎTS
              .
              K:IIV=GETKAT_K(PAM:KAT[Y#],2,1,PAM:NOS_P)
              GET(K_TABLE,K:IIV)
              IF ERROR()
                K:VERT_S   =VERT_S
                K:VERT_IEG =VERT_IEG
                K:VERT_PAR =VERT_PAR
                K:VERT_IZN =VERT_IZN
                K:VERT_NS  =VERT_NS
                K:VERT_N   =VERT_N
                K:VERT_NIZN=VERT_NIZN
                ADD(K_TABLE)
                SORT(K_TABLE,K:IIV)
              ELSE
                K:VERT_S   +=VERT_S
                K:VERT_IEG +=VERT_IEG
                K:VERT_PAR +=VERT_PAR
                K:VERT_IZN +=VERT_IZN
                K:VERT_NS  +=VERT_NS
                K:VERT_N   +=VERT_N
                K:VERT_NIZN+=VERT_NIZN
                PUT(K_TABLE)
              .
              B:BKK=PAM:BKK
              GET(B_TABLE,B:BKK)
              IF ERROR()
                B:VERT_S   =VERT_S
                B:VERT_IEG =VERT_IEG
                B:VERT_PAR =VERT_PAR
                B:VERT_IZN =VERT_IZN
                B:VERT_NS  =VERT_NS
                B:VERT_N   =VERT_N
                B:VERT_NIZN=VERT_NIZN
                ADD(B_TABLE)
                SORT(B_TABLE,B:BKK)
              ELSE
                B:VERT_S   +=VERT_S
                B:VERT_IEG +=VERT_IEG
                B:VERT_PAR +=VERT_PAR
                B:VERT_IZN +=VERT_IZN
                B:VERT_NS  +=VERT_NS
                B:VERT_N   +=VERT_N
                B:VERT_NIZN+=VERT_NIZN
                PUT(B_TABLE)
              .
              IF ~F:DTK
                 IEGVEIDS=PAM:BKK &'  '& PAM:NOS_P
                 VERT_SB  = VERT_S+VERT_IEG+VERT_PAR-VERT_IZN
                 VERT_NB  = VERT_NS+VERT_N-VERT_NIZN
                 VERT_AS  = VERT_S-VERT_NS
                 VERT_AB  = VERT_SB-VERT_NB
                 IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                 ELSE
                    OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N_8B))&CHR(9)&|
                    LEFT(FORMAT(VERT_PAR,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_SB,@N_8B))&|
                    CHR(9)&LEFT(FORMAT(VERT_NS,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_N,@N_8B))&CHR(9)&CHR(9)&|
                    LEFT(FORMAT(VERT_NIZN,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_NB,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_AS,@N_8B))&|
                    CHR(9)&LEFT(FORMAT(VERT_AB,@N_8B))
                    ADD(OUTFILEANSI)
                 END
              .
              X#=K:IIV[1]
   !           STOP(X#&'='&K:IIV[1]&'-'&K:IIV&'='&KAT:IIV)
              IF ~INRANGE(X#,1,3) THEN X#=4.
              VERT_SM[X#]   += VERT_S
              VERT_IEGM[X#] += VERT_IEG
              VERT_PARM[X#] += VERT_PAR
              VERT_IZNM[X#] += VERT_IZN
              VERT_SBM[X#]  += VERT_S+VERT_IEG+VERT_PAR-VERT_IZN
              VERT_NSM[X#]  += VERT_NS
              VERT_NM[X#]   += VERT_N
              VERT_NIZNM[X#]+= VERT_NIZN
              VERT_NBM[X#]  += VERT_NS+VERT_N-VERT_NIZN
              VERT_ASM[X#]  += VERT_S-VERT_NS
              VERT_ABM[X#]   = VERT_SBM[X#]-VERT_NBM[X#]
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
  SAVE_IIV='9'
  IF LocalResponse = RequestCompleted
    loop i#= 1 to records(K_table)
      get(K_table,i#)
      IF ~(SAVE_IIV=K:IIV[1])
         SAVE_IIV=K:IIV[1]
         X#=K:IIV[1]
         IF ~INRANGE(X#,1,3) THEN X#=4.
         EXECUTE X#
            IegKopa='I   Nemateriâlie ieguldîjumi'
            IegKopa='II  Pamatlîdzekïi'
            IegKopa='III Ilgtermiòa fin.ieguldîjumi'
            IegKopa='?   Nepazîstami'
        .
        VERT_SG  = VERT_SM[X#]
        VERT_IEGG= VERT_IEGM[X#]
        VERT_PARG= VERT_PARM[X#]
        VERT_IZNG= VERT_IZNM[X#]
        VERT_SBG = VERT_SBM[X#]
        VERT_NSG = VERT_NSM[X#]
        VERT_NG  = VERT_NM[X#]
        VERT_NIZNG=VERT_NIZNM[X#]
        VERT_NBG = VERT_NBM[X#]
        VERT_ASG = VERT_ASM[X#]
        VERT_ABG = VERT_ABM[X#]
        IF F:DBF='W'
            PRINT(RPT:GRHEAD)
        ELSE
            OUTA:LINE=CLIP(IegKopa)&', tai skaitâ'&CHR(9)&LEFT(FORMAT(VERT_SG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IEGG,@N_8B))&CHR(9)&|
            LEFT(FORMAT(VERT_PARG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IZNG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_SBG,@N_8B))&CHR(9)&|
            LEFT(FORMAT(VERT_NSG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_NG,@N_8B))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_NIZNG,@N_8B))&|
            CHR(9)&LEFT(FORMAT(VERT_NBG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_ASG,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_ABG,@N_8B))
            ADD(OUTFILEANSI)
        END
      .
      XX#=K:IIV-20
      IF ~INRANGE(XX#,1,7) THEN XX#=8.
      EXECUTE XX#
        IEGVEIDS='1.Zemes gabali'
        IEGVEIDS='2.Çkas,bûves un ilggad.stâdîjumi'
        IEGVEIDS='3.Ilgtermiòa ieguldîjumi nomâtajos P/L'
        IEGVEIDS='4.Iekârtas un maðînas'
        IEGVEIDS='5.Pârçjie P/L un inventârs'
        IEGVEIDS='6.P/L izveid.un nep.celtn.obj.izm.'
        IEGVEIDS='7.Avansa maksâjumi par P/L'
        IEGVEIDS=k:iiv&'.'
      .
      VERT_S   = K:VERT_S
      VERT_IEG = K:VERT_IEG
      VERT_PAR = K:VERT_PAR
      VERT_IZN = K:VERT_IZN
      VERT_SB  = K:VERT_S+K:VERT_IEG+K:VERT_PAR-K:VERT_IZN
      VERT_NS  = K:VERT_NS
      VERT_N   = K:VERT_N
      VERT_NIZN= K:VERT_NIZN
      VERT_NB  = K:VERT_NS+K:VERT_N-K:VERT_NIZN
      VERT_AS  = K:VERT_S-K:VERT_NS
      VERT_AB  = VERT_SB-VERT_NB
      IF F:DBF='W'
         PRINT(RPT:DETAIL)
      ELSE
         OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N_8B))&CHR(9)&|
         LEFT(FORMAT(VERT_PAR,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_SB,@N_8B))&CHR(9)&|
         LEFT(FORMAT(VERT_NS,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_N,@N_8B))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_NIZN,@N_8B))&CHR(9)&|
         LEFT(FORMAT(VERT_NB,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_AS,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_AB,@N_8B))
         ADD(OUTFILEANSI)
      END
      VERT_SK  += K:VERT_S
      VERT_IEGK+= K:VERT_IEG
      VERT_PARK+= K:VERT_PAR
      VERT_IZNK+= K:VERT_IZN
      VERT_SBK += K:VERT_S+K:VERT_IEG+K:VERT_PAR-K:VERT_IZN
      VERT_NSK += K:VERT_NS
      VERT_NK  += K:VERT_N
      VERT_NIZNK+= K:VERT_NIZN
      VERT_NBK += K:VERT_NS+K:VERT_N-K:VERT_NIZN
      VERT_ASK += VERT_AS
      VERT_ABK += VERT_AB
    .
    IF F:DBF='W'
        PRINT(RPT:REPFOOT)
    ELSE
        OUTA:LINE='Kopâ:'&CHR(9)&LEFT(FORMAT(VERT_SK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IEGK,@N_8B))&CHR(9)&|
        LEFT(FORMAT(VERT_PARK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IZNK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_SBK,@N_8B))&CHR(9)&|
        LEFT(FORMAT(VERT_NSK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_NK,@N_8B))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_NIZNK,@N_8B))&|
        CHR(9)&LEFT(FORMAT(VERT_NBK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_ASK,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_ABK,@N_8B))
        ADD(OUTFILEANSI)
    .
    IF ~F:DTK
       loop i#= 1 to records(B_table)
         get(B_table,i#)
         IEGVEIDS = B:BKK
         VERT_S   = B:VERT_S
         VERT_IEG = B:VERT_IEG
         VERT_PAR = B:VERT_PAR
         VERT_IZN = B:VERT_IZN
         VERT_SB  = B:VERT_S+B:VERT_IEG+B:VERT_PAR-B:VERT_IZN
         VERT_NS  = B:VERT_NS
         VERT_N   = B:VERT_N
         VERT_NIZN= B:VERT_NIZN
         VERT_NB  = B:VERT_NS+B:VERT_N-B:VERT_NIZN
         VERT_AS  = B:VERT_S-B:VERT_NS
         VERT_AB  = VERT_SB-VERT_NB
         IF F:DBF='W'
            PRINT(RPT:DETAIL)
         ELSE
            OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N_8B))&CHR(9)&|
            LEFT(FORMAT(VERT_PAR,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_SB,@N_8B))&CHR(9)&|
            LEFT(FORMAT(VERT_NS,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_N,@N_8B))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_NIZN,@N_8B))&|
            CHR(9)&LEFT(FORMAT(VERT_NB,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_AS,@N_8B))&CHR(9)&LEFT(FORMAT(VERT_AB,@N_8B))
            ADD(OUTFILEANSI)
         END
       .
    .
    IF F:DBF='W'
        PRINT(RPT:paraksti)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF<>'W' THEN F:DBF='W'.
  POPBIND
  FREE(K_TABLE)
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
