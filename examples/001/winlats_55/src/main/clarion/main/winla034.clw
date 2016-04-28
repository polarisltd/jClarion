                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_AvanSar            PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
RPT_NPK              DECIMAL(4)
NR                   DECIMAL(4)
NOS_P                STRING(45)
VAL_NOS_R            STRING(3)
ATL0                 DECIMAL(13,2)
DEB                  DECIMAL(13,2)
KRE                  DECIMAL(13,2)
ATL                  DECIMAL(13,2)
KOPA                 STRING(5)
KATL0                DECIMAL(13,2)
KDEB                 DECIMAL(13,2)
KKRE                 DECIMAL(13,2)
KATL                 DECIMAL(13,2)
DAT                  LONG
LAI                  LONG
KNOS                 STRING(3)
CG                   STRING(10)

P_table              QUEUE,PRE(P)
PAR_NR                  ULONG
VAL                     STRING(3)
ATL0                    DECIMAL(12,2)
DEB                     DECIMAL(12,2)
KRE                     DECIMAL(12,2)
                     END

K_TABLE              QUEUE,PRE(K)
VAL                     STRING(3)
ATL0                    DECIMAL(12,2)
DEB                     DECIMAL(12,2)
KRE                     DECIMAL(12,2)
                     END
SAV_NR               DECIMAL(4)
LINEH               STRING(190)

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

AtlikumsUZ           STRING(22)

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
report REPORT,AT(198,1390,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,150,8000,1240),USE(?unnamed)
         STRING(@s45),AT(1615,104,4688,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Avansieru Pârskats'),AT(2865,417,2135,208),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6563,729),PAGENO,USE(?PageCount),RIGHT
         STRING('Konts :'),AT(3385,677),USE(?String3),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(3958,677),USE(KKK),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,938,0,365),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(573,938,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3438,938,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4427,938,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5417,938,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6354,938,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7604,938,0,313),USE(?Line4),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,990,417,208),USE(?String5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Avansieris'),AT(625,990,2813,208),USE(?String6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(3490,990),USE(?String7),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(3698,990),USE(s_dat),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemts'),AT(4479,990,885,208),USE(?String6:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izlietots'),AT(5521,990,781,208),USE(?String6:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s22),AT(6406,990,1180,208),USE(ATLIKUMSUZ),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1198,7500,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,938,7500,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,197),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,197),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,197),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,197),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,197),USE(?Line5:7),COLOR(COLOR:Black)
         STRING(@n_4b),AT(156,10,,156),USE(RPT_npk),RIGHT
         STRING(@n_5b),AT(594,10,,156),USE(nR),RIGHT
         STRING(@s45),AT(1031,10,2396,156),USE(NOS_P)
         STRING(@N-_13.2B),AT(3542,10,,156),USE(ATL0),RIGHT
         STRING(@N-_13.2B),AT(4531,10,,156),USE(DEB),RIGHT
         STRING(@N-_13.2B),AT(5500,10,,156),USE(KRE),RIGHT
         STRING(@N-_13.2B),AT(6458,10,,156),USE(ATL),RIGHT
         STRING(@s3),AT(7344,10,260,156),USE(Val_NOS_R),LEFT
       END
DET_FOOT DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(104,-10,0,197),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,62),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,197),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,197),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,197),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(104,52,7500,0),USE(?Line24),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(6354,-10,0,197),USE(?Line25:5),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,197),USE(?Line25:6),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,197),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line25),COLOR(COLOR:Black)
         STRING(@s5),AT(417,10,,156),USE(KOPA),LEFT
         STRING(@N-_13.2B),AT(3542,10,,156),USE(KATL0),RIGHT
         STRING(@N-_13.2B),AT(4531,10,,156),USE(KDEB),RIGHT
         STRING(@N-_13.2B),AT(5500,10,,156),USE(KKRE),RIGHT
         STRING(@N-_13.2B),AT(6458,10,,156),USE(KATL),RIGHT
         STRING(@s3),AT(7344,10,260,156),USE(KNOS),LEFT
       END
RPT_FOOT DETAIL,AT(,,,94),USE(?unnamed:3)
         LINE,AT(104,-10,0,62),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,62),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,62),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(104,52,7500,0),USE(?Line37),COLOR(COLOR:Black)
       END
FOOT   DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(125,10,,156),USE(?String26),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s8),AT(698,10,,156),USE(ACC_kods)
         STRING('RS:'),AT(1375,10,,156),USE(?String31),LEFT
         STRING(@s1),AT(1583,10,,156),USE(RS),CENTER
         STRING(@d6),AT(6469,10,,156),USE(dat)
         STRING(@t4),AT(7146,10,,156),USE(lai)
       END
       FOOTER,AT(198,10800,8000,52)
         LINE,AT(104,0,7813,0),USE(?Line44),COLOR(COLOR:Black)
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
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled

  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  FilesOpened = True

  RecordsToProcess = records(ggk)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Avansieru Pârskats'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
!      GGK:DATUMS=S_DAT
      SET(GGK:DAT_KEY,GGK:DAT_KEY)
      CG='K100011'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      AtlikumsUZ='Atl. uz '&FORMAT(B_DAT,@D6)

      Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG) AND ~BAND(ggk:BAITS,00000001b)' !&~IEZAKS
!!    AND GGK:BAITS???
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
        IF ~OPENANSI('AVANSAR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='AVANSIERU SARAKSTS KONTS '&KKK
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Npk'&CHR(9)&'Avansieris'&CHR(9)&'uz '&format(S_DAT,@D06.)&CHR(9)&'Saòemts'&CHR(9)&'Izlietots'&CHR(9)&|
        'Atlikums'
        ADD(OUTFILEANSI)
!!        OUTA:LINE=''
!!        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        STOP('1')
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        ACT#=1
        GET(P_TABLE,0)
        LOOP J# = 1 TO RECORDS(P_TABLE)
!          STOP('2')
          GET(P_TABLE,J#)
          IF P:PAR_NR=GGK:PAR_NR AND P:VAL=GGK:VAL
            ACT#=2
            BREAK
          .
        .
        IF ACT#=1
          P:ATL0 = 0
          P:DEB  = 0
          P:KRE  = 0
        .
        IF GGK:DATUMS<S_DAT
          CASE GGK:D_K
          OF 'D'
            P:ATL0+= ggk:summav
          OF 'K'
            P:ATL0-= ggk:summav
          .
        ELSE
          CASE GGK:D_K
          OF 'D'
            P:DEB += ggk:summav
          OF 'K'
            P:KRE += ggk:summav
          .
        .
        P:PAR_NR=GGK:PAR_NR
        P:VAL=GGK:VAL
        EXECUTE ACT#
          ADD(P_TABLE)
          PUT(P_TABLE)
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
    SAV_NR=999999999
    kopa='Kopâ:'
    SORT(P_TABLE,P:PAR_NR)
    GET(P_TABLE,0)
    LOOP J# = 1 TO RECORDS(P_TABLE)
      GET(P_TABLE,J#)
      IF P:PAR_NR=SAV_NR
        rpt_npk=0
        nr=0
        NOS_P=''
      ELSE
        NPK#+=1
        rpt_npk=NPK#
        nr=P:PAR_NR
        IF P:PAR_NR=0
          NOS_P='Pârçjie'
        ELSE
!          GET(PAR_K,0)
!          PAR:U_NR=P:PAR_NR
          NOS_P=GETPAR_K(P:PAR_NR,2,2)
        .
      .
      SAV_NR=P:PAR_NR
      ATL0=P:ATL0
      DEB=P:DEB
      KRE=P:KRE
      ATL=P:ATL0+P:DEB-P:KRE
      VAL_NOS_R=P:VAL
!      IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=CLIP(RPT_NPK)&CHR(9)&CLIP(NR)&' '&NOS_P&CHR(9)&LEFT(FORMAT(ATL0,@N-_13.2B))&CHR(9)&|
            LEFT(FORMAT(DEB,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KRE,@N-_13.2B))&CHR(9)&LEFT(FORMAT(ATL,@N-_13.2B))|
            &CHR(9)&VAL_NOS_R
            ADD(OUTFILEANSI)
        END
!      END
      K:VAL=P:VAL
      GET(K_TABLE,K:VAL)
      IF ERROR()
        K:ATL0=P:ATL0
        K:DEB=P:DEB
        K:KRE=P:KRE
        ADD(K_TABLE)
        SORT(K_TABLE,K:VAL)
      ELSE
        K:ATL0+=P:ATL0
        K:DEB+=P:DEB
        K:KRE+=P:KRE
        PUT(K_TABLE)
      .
    .
    PRINT(RPT:DET_FOOT)                            !PRINT GRAND TOTALS
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)                !READ ALL RECORDS IN FILE
      GET(K_TABLE,J#)
      KATL0=K:ATL0
      KDEB=K:DEB
      KKRE=K:KRE
      KATL=KATL0+KDEB-KKRE
      KNOS =K:VAL
      IF F:DBF = 'W'
        PRINT(RPT:DETAIL1)
      ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(KATL0,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KDEB,@N-_13.2B))&CHR(9)&|
        LEFT(FORMAT(KKRE,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KATL,@N-_13.2B))&CHR(9)&KNOS
        ADD(OUTFILEANSI)
      END
      kopa=''
    .
    dat = today()
    lai = clock()
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)                            !PRINT GRAND TOTALS
        PRINT(RPT:FOOT)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
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

!-----------------------------------------------------------------------------------------------------------------------
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
  FREE(P_TABLE)
  FREE(K_TABLE)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
  J#=0
  DONE# = 0                                      !TURN OFF DONE FLAG
! CLEAR(ggk:RECORD)                              !MAKE SURE RECORD CLEARED
! GGK:DATUMS = S_DAT
! GGK:BKK    = KKK
! SET(GGK:DAT_KEY,GGK:DAT_KEY)
! NEXT(GGK)
! K#=POINTER(GGK:DAT_KEY)
  CLEAR(ggk:RECORD)                              !MAKE SURE RECORD CLEARED
  GGK:DATUMS = B_DAT+1
  SET(GGK:DAT_KEY,GGK:DAT_KEY)
  NEXT(GGK)
  IF EOF(GGK)
     K#=RECORDS(GGK:DAT_KEY)-K#+1
  ELSE
     K#=POINTER(GGK:DAT_KEY)-K#
  .
  SHOW(15,38,' no '&K#)
!*************************** 3.solis ********************************
  CLEAR(ggk:RECORD)                              !MAKE SURE RECORD CLEARED
! GGK:DATUMS = S_DAT
  SET(GGK:DAT_KEY,GGK:DAT_KEY)
  DO NEXT_RECORD                                 !READ FIRST RECORD
  LOOP UNTIL DONE#                               !READ ALL RECORDS IN FILE
  .                                              !
!*************************** 4.solis ********************************
  LI=0
  PA=1
  OPEN(REPORT)                                   !OPEN THE REPORT
  CLOSE(REPORT)                                  !CLOSE REPORT
  RETURN                                         !RETURN TO CALLER
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(ggk)                            !  READ UNTIL END OF FILE
    NEXT(ggk)                                    !    READ NEXT RECORD
    IF ~(GGK:DATUMS <= B_DAT) THEN BREAK.
    JJ#+=1
    SHOW(15,32,JJ#,@N_5)
    IF GGK:P3 THEN CYCLE. ! Ignorñjam IEZAK-us
    IF ~RST() THEN CYCLE.
    IF CYCLEBKK(GGK:BKK,KKK) THEN CYCLE.
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
B_Sahs               PROCEDURE                    ! Declare Procedure
KOMENT               STRING(70)
TAISKAITA            STRING(15)
SD_ATLIKUMS          DECIMAL(14,2)
SK_ATLIKUMS          DECIMAL(14,2)
NGG                  DECIMAL(5)
DOK_NR               STRING(14)
DATUMS               LONG
SATURS               STRING(50)
NOS                  STRING(3)
BKKD                 STRING(5)
DEB                  DECIMAL(14,2)
BKKK                 STRING(5)
KRE                  DECIMAL(14,2)
Konta_ATLIKUMS       DECIMAL(14,2)
RPT_Konta_ATLIKUMS   DECIMAL(14,2)
BD_ATLIKUMS          DECIMAL(14,2)
BK_ATLIKUMS          DECIMAL(14,2)
KDEB                 DECIMAL(14,2)
KKRE                 DECIMAL(14,2)
BKK1                 STRING(5)
SUMMA1               DECIMAL(14,2)
BKK2                 STRING(5)
SUMMA2               DECIMAL(14,2)
TEXT                 STRING(60)
DAT                  DATE
LAI                  TIME
ggk_summa            DECIMAL(14,2)
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

P_TABLE      QUEUE,PRE(P)    ! Pointeri pieprasîtâ konta rakstiem periodâ
NR           DECIMAL(6)      ! UNIKÂLAIS NUMMURS
BAITS        BYTE            ! PAZÎME IE/ZA KS
D_K          STRING(1)       ! D/K
SUMMA        DECIMAL(12,2)   ! SUMMA KONTA D/k
POINTER      LONG,DIM(20)    ! KONTA POINTERIS, VAIRÂKI, JA KONTS DOKUMENTÂ ATKÂRTOJAS
KK           BYTE
             .
D_TABLE      QUEUE,PRE(D)    ! KONTA DEBETS (KOPÂ,T.S.)
BKK          STRING(5)       ! BKK
SUMMA        DECIMAL(12,2)   ! SUMMA KONTA D AR ÐAHA KONTA KREDÎTU
             .
K_TABLE      QUEUE,PRE(K)    ! KONTA KREDÎTS (KOPÂ,T.S.)
BKK          STRING(5)       ! BKK
SUMMA        DECIMAL(12,2)   ! SUMMA KONTA K AR ÐAHA KONTA DEBETU
             .
G_TABLE      QUEUE,PRE(G)    ! GGK
NOS          STRING(3)       ! VALÛTA
BKK          STRING(5)       ! BKK
SUMMA        DECIMAL(12,2)   ! SUMMA
KK           BYTE
             .
CTRL_D       DECIMAL(12,2)   ! KONTROLSUMMA  D
CTRL_K       DECIMAL(12,2)   ! KONTROLSUMMA  K
K_ATLIKUMS   DECIMAL(14,2)
SAV_BKK      STRING(5)

!-----------------------------------------------------------------------------
!Process:View         VIEW(GGK)
!                       PROJECT(GGK:BAITS)
!                       PROJECT(GGK:BKK)
!                       PROJECT(GGK:DATUMS)
!                       PROJECT(GGK:D_K)
!                       PROJECT(GGK:KK)
!                       PROJECT(GGK:PAR_NR)
!                       PROJECT(GGK:PVN_PROC)
!                       PROJECT(GGK:PVN_TIPS)
!                       PROJECT(GGK:REFERENCE)
!                       PROJECT(GGK:RS)
!                       PROJECT(GGK:SUMMA)
!                       PROJECT(GGK:SUMMAV)
!                       PROJECT(GGK:U_NR)
!                       PROJECT(GGK:VAL)
!                     END
!-----------------------------------------------------------------------------
Process:View         VIEW(KON_K)
                       PROJECT(KON:BKK)
                       PROJECT(KON:BAITS)
                       PROJECT(KON:NOSAUKUMS)
                       PROJECT(KON:NOSAUKUMSA)
                       PROJECT(KON:VAL)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(146,1515,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,150,8000,1375),USE(?unnamed)
         STRING(@s45),AT(1719,156,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7083,521),PAGENO,USE(?PageCount),RIGHT
         STRING(@D06.),AT(4563,469,833,219),USE(S_DAT,,?S_DAT:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5396,469,104,219),USE(?String61),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5521,469),USE(B_DAT,,?B_DAT:3),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu korespondence Datumu Secîbâ'),AT(1656,469,2865,219),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,729,0,625),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1354,729,0,625),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(1875,729,0,625),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(4000,729,0,625),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(4770,729,0,625),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('Konta Debets'),AT(4865,781,990,156),USE(?String6:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5917,729,0,625),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('Konta Kredîts'),AT(5990,781,990,156),USE(?String6:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7083,729,0,625),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(7900,729,0,625),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(104,729,7796,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('UNR'),AT(156,938,260,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok. Numurs'),AT(469,938,885,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1406,938,469,208),USE(?String7:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts/Pamatojums'),AT(1979,938,1990,208),USE(?String7:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4052,1146,573,208),USE(?String6:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu Debetos'),AT(5969,990,990,156),USE(?String6:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta '),AT(4052,938,573,208),USE(?String6:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu Kredîtos'),AT(4844,990,990,156),USE(?String6:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta '),AT(7135,938,677,208),USE(?String6:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kor.k. sum.'),AT(4833,1198,698,156),USE(?String6:4),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kor.k. sum.'),AT(5948,1198,781,156),USE(?String6:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5573,1198,260,156),USE(val_uzsk),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6698,1198,281,156),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(7146,1146,625,208),USE(?String6:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1354,7796,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,729,0,625),USE(?Line2),COLOR(COLOR:Black)
       END
SAKATL DETAIL,AT(,,,250),USE(?unnamed:4)
         LINE,AT(7900,0,0,260),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@s70),AT(344,52,4427,156),USE(KOMENT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7083,0,0,260),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5917,0,0,260),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(104,0,0,260),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(104,208,7796,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(4000,208,0,52),USE(?Line81),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(4770,0,0,260),USE(?Line2:19),COLOR(COLOR:Black)
       END
SAKATL1 DETAIL,AT(,,,250),USE(?unnamed:3)
         LINE,AT(104,-10,0,270),USE(?Line2:201),COLOR(COLOR:Black)
         STRING('Atlikums uz '),AT(1510,10,833,156),USE(?String18),LEFT
         STRING(@d06.),AT(2448,10,740,156),USE(S_DAT),LEFT
         STRING('(rîts)'),AT(3281,10,365,156),USE(?String18:2),CENTER
         LINE,AT(4000,-10,0,270),USE(?Line2:202),COLOR(COLOR:Black)
         LINE,AT(4770,-10,0,270),USE(?Line2:203),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5073,10,833,156),USE(sd_atlikums),RIGHT
         LINE,AT(5917,-10,0,270),USE(?Line2:204),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(6240,10,833,156),USE(sk_atlikums),RIGHT
         LINE,AT(7083,-10,0,270),USE(?Line2:205),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7115,10,760,156),USE(Konta_atlikums),RIGHT
         LINE,AT(7900,-10,0,270),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(104,208,7796,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(417,208,0,52),USE(?Line81:3),COLOR(COLOR:Black)
         LINE,AT(1354,208,0,52),USE(?Line81:4),COLOR(COLOR:Black)
         LINE,AT(1875,208,0,52),USE(?Line81:2),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(417,-10,0,197),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,197),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4000,-10,0,197),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4770,-10,0,197),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5917,-10,0,197),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7900,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@N_5B),AT(135,10,260,156),USE(NGG),RIGHT
         STRING(@s14),AT(469,10,885,156),USE(DOK_NR),RIGHT
         STRING(@D5B),AT(1406,10,469,156),USE(DATUMS),LEFT
         STRING(@s40),AT(1927,10,2063,156),USE(SATURS),LEFT
         STRING(@N_12.2B),AT(4010,10,755,156),USE(GGK_SUMMA),RIGHT(2)
         STRING(@s5),AT(4813,10,365,156),USE(BKKK),LEFT
         STRING(@n-_13.2B),AT(5156,10,750,156),USE(KRE),RIGHT(3)
         STRING(@s5),AT(5958,10,365,156),USE(BKKD),LEFT
         STRING(@n-_13.2B),AT(6292,10,781,156),USE(DEB),RIGHT(3)
         STRING(@n-_13.2B),AT(7115,10,760,156),USE(Rpt_Konta_atlikums),RIGHT
       END
PER_APGR DETAIL,AT(,,,469),USE(?unnamed:5)
         LINE,AT(1354,-10,0,62),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,62),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(4000,-10,0,489),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(4770,-10,0,489),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(5917,-10,0,489),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,489),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(7900,-10,0,489),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,62),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(104,52,7796,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Atlikums uz '),AT(1563,104,781,156),USE(?String18:3),LEFT
         STRING(@d06.),AT(2458,104,740,156),USE(B_DAT),LEFT
         STRING('(vakars)'),AT(3281,104,625,156),USE(?String18:4),LEFT
         STRING(@n-_14.2),AT(5073,104,833,156),USE(bd_atlikums),RIGHT
         STRING(@n-_14.2),AT(6240,104,833,156),USE(bk_atlikums),RIGHT
         STRING(@n-_13.2),AT(7115,104,760,156),USE(Konta_atlikums,,?Konta_atlikums:2),RIGHT
         LINE,AT(104,260,7796,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5073,313,833,156),USE(kkre),RIGHT
         STRING(@n-_14.2),AT(6240,313,833,156),USE(kdeb),RIGHT
         STRING('Apgrozîjums periodâ '),AT(313,313,1302,156),USE(?String18:5),LEFT
         STRING(@d06.),AT(1646,313,740,156),USE(s_dat,,?s_dat:2)
         STRING(' - '),AT(2385,313,156,156),USE(?String18:6),LEFT
         STRING(@d06.),AT(2552,313,573,156),USE(b_dat,,?b_dat:2)
         STRING(' : '),AT(3125,313,156,156),USE(?String18:7),LEFT
         LINE,AT(104,-10,0,489),USE(?Line2:28),COLOR(COLOR:Black)
       END
PER_TS DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(104,-10,0,197),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(4000,-10,0,197),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(4770,-10,0,197),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(5917,-10,0,197),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(7900,-10,0,197),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@s20),AT(208,10,1302,156),USE(taiskaita),LEFT
         STRING(@s5),AT(4813,10,365,156),USE(BKK2),LEFT
         STRING(@n-_13.2B),AT(5156,10,750,156),USE(summa2),RIGHT
         STRING(@s5),AT(5958,10,365,156),USE(BKK1,,?BKK1:2),LEFT
         STRING(@n-_13.2B),AT(6292,10,781,156),USE(summa1,,?summa1:2),RIGHT
       END
PER_APGR1 DETAIL,AT(,,,94)
         LINE,AT(104,-10,0,114),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,114),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,114),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,114),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(4000,-10,0,114),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(4770,-10,0,114),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(5917,-10,0,114),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,114),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(7900,-10,0,114),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(104,52,7796,0),USE(?Line57),COLOR(COLOR:Black)
       END
PER_APGR2 DETAIL,AT(,-10,,198),USE(?unnamed:8)
         LINE,AT(104,0,0,62),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(104,52,7796,0),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,62),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(7900,0,0,62),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(5917,0,0,62),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(4770,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(4000,0,0,62),USE(?Line59),COLOR(COLOR:Black)
       END
LASTDETAIL DETAIL,AT(,,,229),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(156,21,573,177),USE(?String18:9),LEFT
         STRING(@s8),AT(729,21,552,177),USE(ACC_kods),LEFT
         STRING('R :'),AT(1302,21,135,177),USE(?String54),LEFT
         STRING(@S1),AT(1458,21),USE(RS)
         STRING(@d06.),AT(6698,21),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7323,21,490,146),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
PAGE_foot DETAIL,AT(,-10,,198)
         LINE,AT(104,0,0,62),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(417,0,0,62),USE(?Line66),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,62),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,62),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(4000,0,0,62),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(4770,0,0,62),USE(?Line70),COLOR(COLOR:Black)
         LINE,AT(5917,0,0,62),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,62),USE(?Line72),COLOR(COLOR:Black)
         LINE,AT(7900,0,0,62),USE(?Line73),COLOR(COLOR:Black)
         LINE,AT(104,52,7796,0),USE(?Line74),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11000,8000,63)
         LINE,AT(104,0,7796,0),USE(?Line74:2),COLOR(COLOR:Black)
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
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('F:DTK',F:DTK)
  BIND(KON:RECORD)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FilesOpened = True
  RecordsToProcess = RECORDS(KON_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kontu korespondence'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KON:RECORD)
      KON:BKK=KKK
      SET(KON:BKK_KEY,KON:BKK_KEY)
      IF KKK
         Process:View{Prop:Filter} = '~CYCLEBKK(KON:BKK,KKK)'
      .
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
        IF ~OPENANSI('SAHS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='KONTU KORESPONDENCE DATUMU SECÎBÂ '&format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'
            OUTA:LINE='UNR'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Konts/Pamatojums'&CHR(9)&'Konta summa'&CHR(9)&'Debets'&CHR(9)&'Kredîtos'&CHR(9)&'Kredîts'&CHR(9)&'Debetos'&CHR(9)&'Konta'
            ADD(OUTFILEANSI)
            !OUTA:LINE=      CHR(9)&'Numurs'&CHR(9)&'Datums'&CHR(9)&CHR(9)&CHR(9)&'Kor. k.'&CHR(9)&'Summa Ls'&CHR(9)&'Kor. k.'&CHR(9)&'Summa Ls'&CHR(9)&'atlikums'
            OUTA:LINE=      CHR(9)&'Numurs'&CHR(9)&'Datums'&CHR(9)&CHR(9)&CHR(9)&'Kor. k.'&CHR(9)&'Summa '&val_uzsk&CHR(9)&'Kor. k.'&CHR(9)&'Summa '&val_uzsk&CHR(9)&'atlikums'
            ADD(OUTFILEANSI)
        ELSE
            !El OUTA:LINE='UNR'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Konts/Pamatojums'&CHR(9)&'Konta summa'&CHR(9)&'Debets Kor.k.'&CHR(9)&'Kredîtos Summa Ls'&CHR(9)&'Kredîts Kor.k.'&CHR(9)&'Debetos Summa Ls'&CHR(9)&'Konta atlikums'
            OUTA:LINE='UNR'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Konts/Pamatojums'&CHR(9)&'Konta summa'&CHR(9)&'Debets Kor.k.'&CHR(9)&'Kredîtos Summa '&val_uzsk&CHR(9)&'Kredîts Kor.k.'&CHR(9)&'Debetos Summa '&val_uzsk&CHR(9)&'Konta atlikums'
            ADD(OUTFILEANSI)
        END
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        SAV_BKK = KON:BKK
        J#=0
        kdeb = 0
        kkre = 0
        pt#  = 0
   !*************************** 1.solis SARAKSTAM P_TABLÇ KONKRÇTÂ KONTA U_NR-us ************
        DONE#=0
        Konta_atlikums= 0
        sd_atlikums   = 0
        sk_atlikums   = 0
        P:NR          = 0
        P:D_K         = ''
        P:SUMMA       = 0
        CLEAR(ggk:RECORD)
        GGK:BKK=KON:BKK
        GGK:DATUMS = DB_S_DAT !NO FINGADA SÂKUMA
        SET(ggk:BKK_DAT,GGK:BKK_DAT)
        LOOP
           NEXT(GGK)
           IF ERROR() THEN BREAK.
           IF ~(SAV_BKK=ggk:bkk) THEN BREAK.
           IF CYCLEGGK('K110000') THEN CYCLE.    !GGK,RS,<B_DAT,D/K,PVN_T,OBJ,NOD
           IF GGK:datums<S_dat OR GGK:U_NR=1     !Nosakam sâkuma atlikumu
              IF GGK:D_K='D'
                 Konta_atlikums  += ggk:summa
                 sd_atlikums += ggk:summa
              ELSE
                 Konta_atlikums  -= ggk:summa
                 sk_atlikums += ggk:summa
              .
           ELSE
             IF GGK:U_NR = P:NR AND GGK:D_K=P:D_K AND GGK:KK=P:KK   ! 2 VIENA KONTA KONTÇJUMI VIENÂ DOKUMENTÂ
                P:SUMMA+= GGK:SUMMA
!                IF GGK:KK
!                   IF ~BAND(GGK:KK,P:KK)
!                      P:KK   += GGK:KK
!                   .
!               .
                PUT(P_TABLE)
                IF ERROR()
                   KLUDA(29,'PUT P_TABLE')
                   FREE(P_TABLE)
                   FREE(D_TABLE)
                   FREE(K_TABLE)
                   RETURN
                .
             ELSE
                P:NR=GGK:U_NR
                P:D_K=GGK:D_K
                P:SUMMA=GGK:SUMMA
                P:KK=GGK:KK
                P:BAITS=GGK:BAITS
                ADD(P_TABLE)
                IF ERROR()
                   KLUDA(29,'ADD P_TABLE')
                   FREE(P_TABLE)
                   FREE(D_TABLE)
                   FREE(K_TABLE)
                   RETURN
                .
             .
           .
        .
   !******************** 2.solis SAMEKLÇJAM KOR KONTUS ********************************
        IF RECORDS(P_TABLE)
           KOMENT=KON:BKK &': '& KON:NOSAUKUMS
           IF F:DBF = 'W'
                PRINT(RPT:sakatl)
                PRINT(RPT:SAKATL1)
           ELSIF F:DBF='E'
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&KOMENT
                ADD(OUTFILEANSI)
                OUTA:LINE=''
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Atlikums uz '&format(S_DAT,@D06.)&' (rîts)'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SD_ATLIKUMS,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SK_ATLIKUMS,@N-_11.2))&CHR(9)&LEFT(FORMAT(KONTA_ATLIKUMS,@N-_14.2))
                ADD(OUTFILEANSI)
                OUTA:LINE=''
                ADD(OUTFILEANSI)
           ELSE
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&KOMENT
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Atlikums uz '&format(S_DAT,@D06.)&' (rîts)'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SD_ATLIKUMS,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SK_ATLIKUMS,@N-_11.2))&CHR(9)&LEFT(FORMAT(KONTA_ATLIKUMS,@N-_14.2))
                ADD(OUTFILEANSI)
           END
           LOOP P#=1 TO RECORDS(P_TABLE)  ! CAUR VISIEM ATRASTAJIEM 1 KONTA KONTÇJUMIEM
              GET(P_TABLE,0)
              GET(P_TABLE,P#)
              IF P:D_K='D'       ! Apstrâdâjamais konts ir D
                 kkre += P:SUMMA ! Konta kredîtos..
                 Konta_atlikums += P:SUMMA
              ELSE
                 kdeb += P:SUMMA
                 Konta_atlikums -= P:SUMMA
              .
              GET(GGK,0)
              CLEAR(GGK:RECORD) !CAUR GGK:STRUKTÛRU NODODAM BUILDKORMAS PARAMETRUS
              GGK:U_NR = P:NR
              GGK:BKK  = KON:BKK
              GGK:D_K  = P:D_K
              GGK:SUMMA= P:SUMMA
              GGK:KK   = P:KK
              GGK:BAITS= P:BAITS
              BUILDKORMAS(0,0,0,0,0)
              DO PRINTTEXT
           .
                                              !
           bd_atlikums = sd_atlikums+kKre
           bk_atlikums = sk_atlikums+kDeb
           IF F:DBF = 'W'
                PRINT(RPT:PER_APGR)
           ELSIF F:DBF='E'
                OUTA:LINE=''
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Atlikums uz '&format(B_DAT,@D10.)&' (vakars)'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(BD_ATLIKUMS,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BK_ATLIKUMS,@N-_11.2))&CHR(9)&LEFT(FORMAT(KONTA_ATLIKUMS,@N-_14.2))
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Apgrozîjums periodâ '&format(S_DAT,@D10.)&' - '&format(B_DAT,@D10.)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKRE,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_11.2))
                ADD(OUTFILEANSI)
           ELSE
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Atlikums uz '&format(B_DAT,@D06.)&' (vakars)'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(BD_ATLIKUMS,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BK_ATLIKUMS,@N-_11.2))&CHR(9)&LEFT(FORMAT(KONTA_ATLIKUMS,@N-_14.2))
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Apgrozîjums periodâ '&format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKRE,@N-_11.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_11.2))
                ADD(OUTFILEANSI)
           END
           IF RECORDS(D_TABLE)>RECORDS(K_TABLE)
              J#=RECORDS(D_TABLE)
           ELSE
              J#=RECORDS(K_TABLE)
           .
           GET(D_TABLE,0)
           GET(K_TABLE,0)
           TAISKAITA='tai skaitâ:'
           LOOP I#=1 TO J#
              GET(D_TABLE,I#)
              IF ~ERROR()
                bkk1= D:BKK
                SUMMA1= D:summa
              ELSE
                bkk1= ''
                SUMMA1= 0
              .
              GET(K_TABLE,I#)
              IF ~ERROR()
                bkk2= K:BKK
                SUMMA2= K:summa
              ELSE
                bkk2= ''
                SUMMA2= 0
              .
              IF F:DBF = 'W'
                    PRINT(RPT:PER_TS)
              ELSE
                    OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&TAISKAITA&CHR(9)&CHR(9)&BKK2&CHR(9)&LEFT(FORMAT(SUMMA2,@N-_11.2B))&CHR(9)&BKK1&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_11.2B))
                    ADD(OUTFILEANSI)
              END
              TAISKAITA=''
           .
           IF F:DBF = 'W'
                PRINT(RPT:PER_APGR2)
           ELSIF F:DBF = 'E'
                OUTA:LINE=''
                ADD(OUTFILEANSI)
           END
        .
        FREE(P_TABLE)
        FREE(D_TABLE)
        FREE(K_TABLE)
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
  IF SEND(KON_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    if ~print#
        TEXT='Nav datu pçc filtra  : konts='&KKK&' periods='&format(s_dat,@d06.)&'-'&format(s_dat,@d06.)      !! bija @d5
    .
    dat = today()
    lai = clock()
    IF F:DBF = 'W'
        PRINT(RPT:LASTDETAIL)
    ELSIF F:DBF = 'E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    FREE(K_TABLE)
    FREE(D_TABLE)
    FREE(P_TABLE)
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
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
      StandardWarning(Warn:RecordFetchError,'KON_K')
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
!------------------------------------------------------------------------
PRINTTEXT    ROUTINE
  I#=GETGG(P:NR)
  LOOP I#=1 TO 20
    TEKSTS=CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
    FORMAT_TEKSTS(50,'Arial',8,'')
    CASE I#
    OF 1
       ngg      = GG:U_NR
!       IF CHECKPZ(1)
!          DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!       ELSE
!          IF GG:DOK_NR
!             DOK_NR=RIGHT(GG:DOK_NR)
!          ELSE
!             DOK_NR=''
!          .
!       .
       DOK_NR=GG:DOK_SENR
       datums   = gg:datums
       ggk_summa= P:summa
       SATURS   = F_TEKSTS[1]
       Rpt_Konta_atlikums=Konta_atlikums
    OF 2
       ngg    = ''
       dok_nr = ''
       datums = ''
       ggk_summa=0
       SATURS = F_TEKSTS[2]
       Rpt_Konta_atlikums=0
       IF ~(KOR_SUMMA[I#] OR SATURS)
          BREAK
       .
    OF 3
       ngg    = ''
       dok_nr = ''
       datums = ''
       ggk_summa=0
       SATURS = F_TEKSTS[3]
       IF ~(KOR_SUMMA[I#] OR SATURS)
          BREAK
       .
    ELSE
       saturs= ''
       ggk_summa=0
       IF ~KOR_SUMMA[I#]
          BREAK
       .
    .
    !El NOS='Ls'
    NOS=val_uzsk
    bkkk = ''
    bkkd = ''
    deb = 0
    kre = 0
    IF P:D_K='K'
       bkkd = KOR_KONTS[I#]
       deb  = KOR_summa[I#]
       IF KOR_SUMMA[I#]
          DO FILLDTABLE
       .
    ELSE
       bkkk = KOR_KONTS[I#]
       kre  = KOR_summa[I#]
       IF KOR_SUMMA[I#]
          DO FILLKTABLE
       .
    .
    IF ~F:DTK
       IF KOR_SUMMA[I#] OR SATURS
          IF ~F:DTK
            IF F:DBF = 'W'
                PRINT(RPT:DETAIL)                    !  PRINT DETAIL LINES
            ELSE
                OUTA:LINE=LEFT(FORMAT(NGG,@N_5B))&CHR(9)&DOK_NR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(GGK_SUMMA,@N_10.2B))&CHR(9)&BKKK&CHR(9)&LEFT(FORMAT(KRE,@N-_11.2))&CHR(9)&BKKD&CHR(9)&LEFT(FORMAT(DEB,@N-_11.2))&CHR(9)&LEFT(FORMAT(Rpt_Konta_Atlikums,@N-_14.2B))
                ADD(OUTFILEANSI)
            END
          END
       .
    .
  .
!------------------------------------------------------------------------
FILLDTABLE ROUTINE
          GET(D_TABLE,0)
          D:BKK=bkkd
          GET(D_TABLE,D:BKK)
          IF ERROR()
             D:BKK=BKKD
             D:SUMMA = DEB
             ADD(D_TABLE)
             IF ERROR()
                KLUDA(29,'ADD D_TABLE')
                DO PROCEDURERETURN
             .
             SORT(D_TABLE,D:BKK)
          ELSE
             D:SUMMA+= DEB
             PUT(D_TABLE)
          .
!------------------------------------------------------------------------
FILLKTABLE ROUTINE
          GET(K_TABLE,0)
          K:BKK=BKKK
          GET(K_TABLE,K:BKK)
          IF ERROR()
             K:BKK=BKKK
             K:SUMMA = KRE
             ADD(K_TABLE)
             IF ERROR()
                KLUDA(29,'ADD K_TABLE')
                DO PROCEDURERETURN
             .
             SORT(K_TABLE,K:BKK)
          ELSE
             K:SUMMA+= KRE
             PUT(K_TABLE)
          .
!------------------------------------------------------------------------
NEXTKON     ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(KON_K)                          !  READ UNTIL END OF FILE
    NEXT(KON_K)                                  !    READ NEXT RECORD
    K#+=1
    IF CYCLEBKK(KON:BKK,KKK)=2 THEN BREAK.
    IF CYCLEBKK(KON:BKK,KKK) THEN CYCLE.
    SAV_BKK=KON:BKK
    EXIT
  .
  DONEKON#=1
B_Sahs2              PROCEDURE                    ! Declare Procedure
KOMENT               STRING(50)
SD_ATLIKUMS          DECIMAL(11,2)
tek_ATLIKUMS         DECIMAL(11,2)
rpt_tek_ATLIKUMS     DECIMAL(11,2)
SK_ATLIKUMS          DECIMAL(11,2)
S_ATLIKUMS           DECIMAL(11,2)
NGG                  DECIMAL(5)
DOK_NR               STRING(14)
SAV_NOS_S            STRING(15)
DATUMS               DATE
SATURS               STRING(60)
NOS                  STRING(3)
BKKD                 STRING(5)
DEB                  DECIMAL(12,2)
BKKK                 STRING(5)
KRE                  DECIMAL(12,2)
RPT_K_ATLIKUMS       DECIMAL(12,2)
BD_ATLIKUMS          DECIMAL(11,2)
BK_ATLIKUMS          DECIMAL(11,2)
B_ATLIKUMS           DECIMAL(11,2)
KDEB                 DECIMAL(12,2)
KKRE                 DECIMAL(12,2)
KDEBP                DECIMAL(12,2)
KKREP                DECIMAL(12,2)
BKK1                 STRING(5)
SUMMA1               DECIMAL(12,2)
BKK2                 STRING(5)
SUMMA2               DECIMAL(12,2)
TEXT                 STRING(60)
DAT                  DATE
LAI                  TIME
ggk_summa            DECIMAL(12,2)
PRINTED_RECS         USHORT
TS                   STRING(20)
CG                   STRING(10)
P_TABLE              QUEUE,PRE(P)    ! KONTA DEBETS
U_NR                    ULONG
NOS_S                   STRING(15)
GGK_D_K                 STRING(1)
GGK_SUMMA               DECIMAL(12,2)
KOR_KONTS               STRING(5),DIM(20)
KOR_SUMMA               DECIMAL(12,2),DIM(20)
                     .
D_TABLE              QUEUE,PRE(D)    ! KONTA DEBETS
BKK                     STRING(5)       ! BKK
SUMMA                   DECIMAL(12,2)   ! SUMMA KONTA D AR ÐAHA KONTA DEBETU
                     .
K_TABLE              QUEUE,PRE(K)    ! KONTA DEBETS
BKK                     STRING(5)       ! BKK
SUMMA                   DECIMAL(12,2)   ! SUMMA KONTA D AR ÐAHA KONTA KRED×TU
                     .
DK_TABLE             QUEUE,PRE(DK)    ! KONTA DEBETS
BKK                     STRING(5)       ! BKK
SUMMA                   DECIMAL(12,2)   ! SUMMA KONTA D AR ÐAHA KONTA DEBETU
                     .
KK_TABLE             QUEUE,PRE(KK)    ! KONTA DEBETS
BKK                     STRING(5)       ! BKK
SUMMA                   DECIMAL(12,2)   ! SUMMA KONTA D AR ÐAHA KONTA KRED×TU
                     .
K_ATLIKUMS           DECIMAL(12,2)
ASTE                 STRING(9)
SUM1                STRING(11)
SUM2                STRING(11)
SUM3                STRING(11)
FILTRS_TEXT         STRING(100)

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

report REPORT,AT(200,1470,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,104,8000,1365),USE(?unnamed)
         STRING(@s45),AT(1667,21,4688,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7094,104),PAGENO,USE(?PageCount),RIGHT
         STRING('Kontu korespondence Partneru Secîbâ'),AT(260,323,2969,208),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(3313,323,4323,208),USE(KOMENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(104,521,7552,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,729,0,625),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1354,729,0,625),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(1875,729,0,625),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(4552,729,0,625),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(5365,729,0,625),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('Konta Debets'),AT(5417,781,1042,208),USE(?String6:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,729,0,625),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('Konta Kredîts'),AT(6583,781,1042,208),USE(?String6:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr.'),AT(156,938,260,208),USE(?String6:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7656,729,0,625),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,729,7552,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('GG'),AT(156,1146,260,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok. Numurs'),AT(469,1146,885,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1406,1146,469,208),USE(?String7:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(1927,1146,2573,208),USE(?String7:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4740,1146,625,208),USE(?String6:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu Debetos'),AT(6594,938,1052,208),USE(?String6:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta '),AT(4740,938,625,208),USE(?String6:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu Kredîtos'),AT(5417,969,1042,208),USE(?String6:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kor.k. Summa'),AT(5375,1146,823,208),USE(?String6:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kor.k. Summa'),AT(6521,1146,865,208),USE(?String6:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6177,1146,281,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7333,1146,323,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1354,7552,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,729,0,625),USE(?Line2),COLOR(COLOR:Black)
       END
SAKATL DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(7656,-10,0,197),USE(?Line2:25),COLOR(COLOR:Black)
         STRING('(rîts)'),AT(2042,0,365,156),USE(?String18:2),CENTER
         STRING(@n-_13.2),AT(3740,0,781,156),USE(s_atlikums),RIGHT
         LINE,AT(6510,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(4552,-10,0,197),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6865,0,781,156),USE(sk_atlikums),RIGHT
         LINE,AT(104,156,7552,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('Atlikums uz '),AT(323,0,833,156),USE(?String18),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(1219,0,740,156),USE(S_DAT),LEFT
         STRING(@n-_13.2),AT(5729,0,781,156),USE(sd_atlikums),RIGHT
       END
partner DETAIL,AT(,,,167)
         LINE,AT(7656,-10,0,197),USE(?Line5:27),COLOR(COLOR:Black)
         STRING(@s20),AT(1927,0,1875,156),USE(p:nos_S),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,-10,0,197),USE(?Line5:15),COLOR(COLOR:Black)
         LINE,AT(4552,-10,0,197),USE(?Line5:24),COLOR(COLOR:Black)
         LINE,AT(1875,52,0,135),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(1354,52,0,135),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(417,52,0,135),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(104,52,1823,0),USE(?Line5:30),COLOR(COLOR:Black)
         LINE,AT(3854,52,3802,0),USE(?Line5:31),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line5:19),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(417,-10,0,197),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,197),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4552,-10,0,197),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,197),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@N_5B),AT(156,10,260,156),USE(NGG),RIGHT
         STRING(@s14),AT(469,10,885,156),USE(DOK_NR),RIGHT
         STRING(@D05.B),AT(1406,10,469,156),USE(DATUMS),LEFT
         STRING(@s44),AT(1896,10,2625,156),USE(SATURS),LEFT
         STRING(@N_13.2B),AT(4563,10,792,156),USE(GGK_SUMMA),RIGHT(2)
         STRING(@s5),AT(5417,10,365,156),USE(BKKK),LEFT
         STRING(@n-_13.2B),AT(5729,10,781,156),USE(KRE),RIGHT(3)
         STRING(@s5),AT(6552,10,365,156),USE(BKKD),LEFT
         STRING(@n-_13.2B),AT(6865,10,781,156),USE(DEB),RIGHT(3)
       END
PER_APGR DETAIL,AT(,,,510),USE(?unnamed:4)
         LINE,AT(4552,-10,0,550),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,550),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,550),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,550),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(104,52,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Atlikums uz '),AT(302,104,781,156),USE(?String18:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(1198,104,740,156),USE(B_DAT),LEFT
         STRING('(vakars)'),AT(2021,104,625,156),USE(?String18:4),LEFT
         STRING(@n-_13.2),AT(5729,104,781,156),USE(bd_atlikums),RIGHT
         STRING(@n-_13.2),AT(6865,104,781,156),USE(bk_atlikums),RIGHT
         STRING(@n-_13.2),AT(3740,104,781,156),USE(b_atlikums),RIGHT
         LINE,AT(104,313,7552,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(5729,365,781,156),USE(kkre),RIGHT
         STRING(@n-_13.2),AT(6865,365,781,156),USE(kdeb),RIGHT
         STRING('Apgrozîjums periodâ '),AT(313,365,1302,156),USE(?String18:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(1667,365,740,156),USE(s_dat,,?s_dat:2)
         STRING(' - '),AT(2396,365,156,156),USE(?String18:6),LEFT
         STRING(@d06.),AT(2552,365,573,156),USE(b_dat,,?b_dat:2)
         STRING(' : '),AT(3125,365,156,156),USE(?String18:7),LEFT
         LINE,AT(104,-10,0,550),USE(?Line2:28),COLOR(COLOR:Black)
       END
PAR_APGR DETAIL,AT(,,,177),USE(?unnamed:8)
         LINE,AT(4552,-10,0,197),USE(?Line6:45),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line6:44),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,197),USE(?Line6:43),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,197),USE(?Line6:36),COLOR(COLOR:Black)
         LINE,AT(104,-10,7552,0),USE(?Line6:10),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(5729,10,781,156),USE(kkreP),RIGHT
         STRING(@n-_13.2),AT(6865,10,781,156),USE(kdebP),RIGHT
         STRING('Apgrozîjums periodâ '),AT(313,10,1302,156),USE(?String68:14),LEFT
         STRING(@d06.),AT(1646,10,740,156),USE(s_dat,,?s_dat:3)
         STRING(' - '),AT(2385,10,156,156),USE(?String68:6),LEFT
         STRING(@d06.),AT(2552,10,573,156),USE(b_dat,,?b_dat:3)
         STRING(' : '),AT(3125,10,156,156),USE(?String68:7),LEFT
         LINE,AT(104,-10,0,197),USE(?Line2:43),COLOR(COLOR:Black)
       END
PER_TS DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(104,-10,0,197),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(4552,-10,0,197),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,197),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,197),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,197),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@s20),AT(260,10,1250,156),USE(TS),LEFT
         STRING(@s5),AT(5417,10,365,156),USE(BKK2),LEFT
         STRING(@n-_13.2B),AT(5729,10,781,156),USE(summa2),RIGHT
         STRING(@s5),AT(6552,10,365,156),USE(BKK1,,?BKK1:2),LEFT
         STRING(@n-_13.2B),AT(6865,10,781,156),USE(summa1,,?summa1:2),RIGHT
       END
PER_APGR1 DETAIL,AT(,-10,,94),USE(?unnamed:9)
         LINE,AT(104,0,0,114),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(417,0,0,114),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,114),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,114),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(4552,0,0,114),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,114),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(6510,0,0,114),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,114),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(104,52,7552,0),USE(?Line57),COLOR(COLOR:Black)
       END
PER_APGR2 DETAIL,AT(,-10,,94),USE(?unnamed:2)
         LINE,AT(104,0,0,62),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(104,0,0,62),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(104,52,7552,0),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,62),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(6510,0,0,62),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(4552,0,0,62),USE(?Line59),COLOR(COLOR:Black)
       END
FORM_FEED DETAIL,AT(,,,396)
         STRING('Sastadîja :'),AT(156,104,573,208),USE(?String18:8),LEFT
         STRING(@s8),AT(729,104),USE(ACC_kods),LEFT
         STRING('RS :'),AT(1354,104),USE(?String54),LEFT
         STRING(@S1),AT(1563,104),USE(RS),CENTER
         STRING(@s60),AT(1823,104,4115,208),USE(text),LEFT
         STRING(@d6),AT(5938,104),USE(dat)
         STRING(@t4),AT(6719,104),USE(lai)
       END
PAGE_foot DETAIL,AT(,,,219)
         LINE,AT(104,0,0,104),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(417,0,0,104),USE(?Line66),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,104),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,104),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,104),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,104),USE(?Line70),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,104),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,104),USE(?Line73),COLOR(COLOR:Black)
         LINE,AT(104,104,7552,0),USE(?Line74),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,0)
         LINE,AT(104,0,7552,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
APGRPAR DETAIL
         LINE,AT(104,0,7552,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,365),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,365),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,365),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,365),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(104,365,7552,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5781,21,625,156),USE(kkre,,?kkre:2),RIGHT
         STRING(@n-_12.2),AT(6979,21,625,156),USE(kdeb,,?kdeb:2),RIGHT
         STRING('Apgrozîjums periodâ '),AT(313,20,1302,156),USE(?String18:13),LEFT
         STRING(@d06.),AT(1646,20,740,156),USE(s_dat,,?s_dat:4)
         STRING(' - '),AT(2385,20,156,156),USE(?String18:12),LEFT
         STRING(@d06.),AT(2552,20,573,156),USE(b_dat,,?b_dat:4)
         STRING(' : '),AT(3125,20,156,156),USE(?String18:11),LEFT
         STRING('tai skaitâ'),AT(313,188,781,156),USE(?String18:10),LEFT
         LINE,AT(104,0,0,365),USE(?Line2:35),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10900,8000,10),USE(?unnamed:3)
         LINE,AT(94,10,7552,0),USE(?Line1:8),COLOR(COLOR:Black)
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
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('F:DTK',F:DTK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
!*************************** 0.solis ********************************
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1

  s_atlikums  = 0
  sd_atlikums = 0
  sk_atlikums = 0
  koment=kkk&' '&getkon_k(kkk,0,2)
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!  IF ~(PAR_TIPS='EFCIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
!  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
!  IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
!  IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.

  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Kontu korespodence'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK=KKK
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K110011'                 !GGK,RS,<B_DAT,D/K,PVN_T,OBJ,NOD
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
        IF ~OPENANSI('SAHS2.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='KONTU KORESPONDENCE PARTNERU SECÎBÂ '&KOMENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'
            OUTA:LINE='UNR'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Pamatojums'&CHR(9)&'Konta summa'&CHR(9)&CHR(9)&'Debets Kredîtos'&CHR(9)&CHR(9)&'Kredîts Debetos'
            ADD(OUTFILEANSI)
            !El OUTA:LINE=      CHR(9)&'Numurs'&CHR(9)&'Datums'&CHR(9)&CHR(9)&CHR(9)&'Kor.k.'&CHR(9)&'Summa Ls'&CHR(9)&'Kor.k.'&CHR(9)&'Summa Ls'
            OUTA:LINE=      CHR(9)&'Numurs'&CHR(9)&'Datums'&CHR(9)&CHR(9)&CHR(9)&'Kor.k.'&CHR(9)&'Summa '&val_uzsk&CHR(9)&'Kor.k.'&CHR(9)&'Summa '&val_uzsk
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE='UNR'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Pamatojums'&CHR(9)&'Konta summa'&CHR(9)&CHR(9)&'Debets Kredîtos'&CHR(9)&CHR(9)&'Kredîts Debetos'
            ADD(OUTFILEANSI)
            !El OUTA:LINE=      CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Kor.k.'&CHR(9)&'Summa Ls'&CHR(9)&'Kor.k.'&CHR(9)&'Summa Ls'
            OUTA:LINE=      CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Kor.k.'&CHR(9)&'Summa '&val_uzsk&CHR(9)&'Kor.k.'&CHR(9)&'Summa '&val_uzsk
            ADD(OUTFILEANSI)
        END
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
         IF GGK:datums<s_dat OR GGK:U_NR=1     ! Nosakam sâkuma atlikumu
            IF GGK:D_K='D'
               s_atlikums += ggk:summa
               sd_atlikums += ggk:summa
            ELSE
               s_atlikums -= ggk:summa
               sk_atlikums += ggk:summa
            .
         ELSE
            IF ~PRINTSAKATL#
               IF F:DBF = 'W'
                    PRINT(RPT:SAKATL)
               ELSIF F:DBF='E'
                    OUTA:LINE='Atlikums uz '&format(S_DAT,@D06.)&' (rîts)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(S_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SD_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SK_ATLIKUMS,@N-_12.2))
                    ADD(OUTFILEANSI)
                    OUTA:LINE=''
                    ADD(OUTFILEANSI)
               ELSE
                    OUTA:LINE='Atlikums uz '&format(S_DAT,@D06.)&' (rîts)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(S_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SD_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(SK_ATLIKUMS,@N-_12.2))
                    ADD(OUTFILEANSI)
               END
               PRINTSAKATL#=1
               tek_atlikums=s_atlikums
            .
            BUILDKORMAS(2,0,0,0,0)
            DO FILLPTABLE
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
  SORT(P_TABLE,P:NOS_S)
  LOOP K#= 1 TO RECORDS(P_TABLE)
     GET(P_TABLE,K#)
     IF K#=1
        SAV_NOS_S=P:NOS_S
        IF F:DBF = 'W'
            PRINT(RPT:PARTNER)
        ELSE
!!            OUTA:LINE='-{15}     '&P:NOS_S&'-{120}'
            OUTA:LINE=P:NOS_S&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
        END
     .
     DO CHECKPARBREAK
     DO PRINTTEXT
  .
  DO CHECKPARBREAK
  dat = today()
  lai = clock()
  bd_atlikums = sd_atlikums+kkre
  bk_atlikums = sk_atlikums+kdeb
  b_atlikums  = tek_atlikums
  IF F:DBF = 'W'
        PRINT(RPT:PER_APGR)
  ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Atlikums uz: '&format(B_DAT,@D10.)&'(vakars)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(B_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BD_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BK_ATLIKUMS,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Apgrozîjums periodâ: '&format(S_DAT,@D10.)&'-'&format(B_DAT,@D10.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))
        ADD(OUTFILEANSI)
  ELSE
        OUTA:LINE='Atlikums uz: '&format(B_DAT,@D06.)&'(vakars)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(B_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BD_ATLIKUMS,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(BK_ATLIKUMS,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Apgrozîjums periodâ: '&format(S_DAT,@D06.)&'-'&format(B_DAT,@D06.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))
        ADD(OUTFILEANSI)
  END
  IF RECORDS(DK_TABLE)>RECORDS(KK_TABLE)
     J#=RECORDS(DK_TABLE)
  ELSE
     J#=RECORDS(KK_TABLE)
  .
  GET(DK_TABLE,0)
  GET(KK_TABLE,0)
  TS=' tai skaitâ :'
  LOOP I#=1 TO J#
     GET(DK_TABLE,I#)
     IF ~ERROR()
       bkk1= DK:BKK
       SUMMA1= DK:summa
     ELSE
       bkk1= ''
       SUMMA1= 0
     .
     GET(KK_TABLE,I#)
     IF ~ERROR()
       bkk2= KK:BKK
       SUMMA2= KK:summa
     ELSE
       bkk2= ''
       SUMMA2= 0
     .
     IF F:DBF = 'W'
        PRINT(RPT:PER_TS)
     ELSE
        OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&BKK2&CHR(9)&LEFT(FORMAT(SUMMA2,@N-_12.2))&CHR(9)&BKK1&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_12.2))
        ADD(OUTFILEANSI)
     END
     TS=''
  .
  IF F:DBF = 'W'
    PRINT(RPT:PER_APGR2)
  ELSIF F:DBF='E'
    OUTA:LINE=''
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
  GG::Used -= 1
  IF GG::Used = 0 THEN CLOSE(GG).
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  FREE(P_TABLE)
  FREE(D_TABLE)
  FREE(K_TABLE)
  FREE(DK_TABLE)
  FREE(KK_TABLE)
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
  IF ERRORCODE() OR ~(GGK:BKK=KKK)
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
!------------------------------------------------------------------------
CHECKPARTOP    ROUTINE
   IF ~(SAV_NOS_S=P:NOS_S)
      SAV_NOS_S=P:NOS_S
      IF F:DBF = 'W'
          PRINT(RPT:PARTNER)
      ELSE
!!          OUTA:LINE='-{15}     '&P:NOS_S&'-{120}'
          OUTA:LINE=P:NOS_S&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
          ADD(OUTFILEANSI)
      END
      IF PRINTED_RECS>1
         IF RECORDS(D_TABLE)>RECORDS(K_TABLE)
          J#=RECORDS(D_TABLE)
         ELSE
          J#=RECORDS(K_TABLE)
         .
         TS=' tai skaitâ :'
         GET(D_TABLE,0)
         GET(K_TABLE,0)
         LOOP I#=1 TO J#
           GET(D_TABLE,I#)
           IF ~ERROR()
             bkk1= D:BKK
             SUMMA1= D:summa
           ELSE
             bkk1= ''
             SUMMA1= 0
           .
           GET(K_TABLE,I#)
           IF ~ERROR()
             bkk2= K:BKK
             SUMMA2= K:summa
           ELSE
             bkk2= ''
             SUMMA2= 0
           .
           IF F:DBF = 'W'
              PRINT(RPT:PER_TS)
           ELSE
              OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&BKK2&CHR(9)&LEFT(FORMAT(SUMMA2,@N-_12.2))&CHR(9)&BKK1&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_12.2))
              ADD(OUTFILEANSI)
           END
           ts=''
         .
      .
      IF ~(K#=RECORDS(P_TABLE))
        IF F:DBF = 'W'
            PRINT(RPT:PARTNER)
        ELSE
!!            OUTA:LINE='-{15}     '&P:NOS_S&'-{120}'
            OUTA:LINE=P:NOS_S&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
        END
      .
      PRINTED_RECS=0
      KDEBP = 0
      KKREP = 0
      FREE(D_TABLE)
      FREE(K_TABLE)
    .
!------------------------------------------------------------------------
CHECKPARBREAK    ROUTINE
    IF ~(SAV_NOS_S=P:NOS_S) OR K#>RECORDS(P_TABLE)
      SAV_NOS_S=P:NOS_S
      IF F:DBF = 'W'
            PRINT(RPT:PAR_APGR)
      ELSIF F:DBF='E'
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='Apgrozîjums periodâ: '&format(S_DAT,@D10.)&'-'&format(B_DAT,@D10.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKREP,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))
            ADD(OUTFILEANSI)
      ELSE
            OUTA:LINE='Apgrozîjums periodâ: '&format(S_DAT,@D06.)&'-'&format(B_DAT,@D06.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KKREP,@N-_12.2))&CHR(9)&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))
            ADD(OUTFILEANSI)
      END
      IF PRINTED_RECS>1 OR (PRINTED_RECS>0 AND F:DTK) ! DRUKÂT TAI SKAITÂ, JA >1 DOKUMENTU VAI JÂDRUKÂ TIKAI TAI SKAITÂ
         IF RECORDS(D_TABLE)>RECORDS(K_TABLE)
          J#=RECORDS(D_TABLE)
         ELSE
          J#=RECORDS(K_TABLE)
         .
         TS=' tai skaitâ :'
         GET(D_TABLE,0)
         GET(K_TABLE,0)
         LOOP I#=1 TO J#
           GET(D_TABLE,I#)
           IF ~ERROR()
             bkk1= D:BKK
             SUMMA1= D:summa
           ELSE
             bkk1= ''
             SUMMA1= 0
           .
           GET(K_TABLE,I#)
           IF ~ERROR()
             bkk2= K:BKK
             SUMMA2= K:summa
           ELSE
             bkk2= ''
             SUMMA2= 0
           .
           IF F:DBF = 'W'
              PRINT(RPT:PER_TS)
           ELSE
              OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&BKK2&CHR(9)&LEFT(FORMAT(SUMMA2,@N-_12.2))&CHR(9)&BKK1&CHR(9)&LEFT(FORMAT(SUMMA1,@N-_12.2))
              ADD(OUTFILEANSI)
           END
           ts=''
         .
      .
      IF ~(K#>RECORDS(P_TABLE))
        IF F:DBF = 'W'
            PRINT(RPT:PARTNER)
        ELSE
!!            OUTA:LINE='-{15}     '&P:NOS_S&'-{120}'
            OUTA:LINE=P:NOS_S&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
        END
      .
      PRINTED_RECS=0
      KDEBP = 0
      KKREP = 0
      FREE(D_TABLE)
      FREE(K_TABLE)
    .
!------------------------------------------------------------------------
PRINTTEXT    ROUTINE
  I#=GETGG(P:U_NR)
  LOOP I#=1 TO 20
    TEKSTS=CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
    FORMAT_TEKSTS(65,'Arial',8,'')
    CASE I#
    OF 1
       ngg    = GG:U_NR
!       IF CHECKPZ(1)
!          DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!       ELSE
!          IF GG:DOK_NR
!             DOK_NR=RIGHT(GG:DOK_NR)
!          ELSE
!             DOK_NR=''
!          .
!       .
       DOK_NR=GG:DOK_SENR
       datums = gg:datums
       ggk_summa=P:ggk_summa
       SATURS = F_TEKSTS[1]
!!       saturs = gg:saturs
       PRINTED_RECS+=1
    OF 2
       ngg    = ''
       dok_nr = ''
       datums = ''
       ggk_summa=0
       SATURS = F_TEKSTS[2]
!!       saturs= gg:saturs2
       IF ~(P:KOR_SUMMA[I#] OR SATURS)
          BREAK
       .
    OF 3
       ngg    = ''
       dok_nr = ''
       datums = ''
       ggk_summa=0
       SATURS = F_TEKSTS[3]
!!       saturs= gg:saturs3
       IF ~(P:KOR_SUMMA[I#] OR SATURS)
          BREAK
       .
    ELSE
       RPT_K_ATLIKUMS=0
       saturs= ''
       ggk_summa=0
       IF ~(P:KOR_SUMMA[I#] OR SATURS)
          BREAK
       .
    .
    !El NOS='Ls'
    NOS=val_uzsk
    bkkk = ''
    bkkd = ''
    deb = 0
    kre = 0
    rpt_tek_atlikums=0
    IF P:GGK_D_K='K'
       bkkd = P:KOR_KONTS[I#]
       deb  = P:KOR_summa[I#]
       IF P:KOR_SUMMA[I#]
          DO FILLDTABLE
          DO FILLDKTABLE
          KDEB+=DEB
          KDEBP+=DEB
          tek_ATLIKUMS-=deb
          rpt_tek_atlikums=tek_atlikums
       .
    ELSE
       bkkk = P:KOR_KONTS[I#]
       kre  = P:KOR_summa[I#]
       IF P:KOR_SUMMA[I#]
          DO FILLKTABLE
          DO FILLKKTABLE
          KKRE+=KRE
          KKREP+=KRE
          tek_ATLIKUMS+=kre
          rpt_tek_atlikums=tek_atlikums
       .
    .
    IF ~F:DTK
       IF P:KOR_SUMMA[I#] OR SATURS
          IF F:DBF = 'W'
                PRINT(RPT:DETAIL)                    !  PRINT DETAIL LINES
          ELSE
                OUTA:LINE=NGG&CHR(9)&DOK_NR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(GGK_SUMMA,@N-_12.2))&CHR(9)&BKKK&CHR(9)&LEFT(FORMAT(KRE,@N-_12.2))&CHR(9)&BKKD&CHR(9)&LEFT(FORMAT(DEB,@N-_12.2))
                ADD(OUTFILEANSI)
          END
       .
    .
  .
!------------------------------------------------------------------------
FILLPTABLE ROUTINE
    P:U_NR         =GGK:U_NR
    P:NOS_S        =GETPAR_K(GGK:PAR_NR,2,1)
    P:GGK_D_K      =GGK:D_K
    P:GGK_SUMMA    =GGK:SUMMA
    CLEAR(P:KOR_KONTS)
    CLEAR(P:KOR_SUMMA)
    LOOP I#= 1 TO 20
       IF KOR_KONTS[I#]='' THEN BREAK.
       P:KOR_KONTS[I#]=KOR_KONTS[I#]
       P:KOR_SUMMA[I#]=KOR_SUMMA[I#]
    .
    ADD(P_TABLE)
    IF ERROR()
       KLUDA(29,'ADD P_TABLE')
       DO PROCEDURERETURN
    .
!------------------------------------------------------------------------
FILLDTABLE ROUTINE
          GET(D_TABLE,0)
          D:BKK=bkkd
          GET(D_TABLE,D:BKK)
          IF ERROR()
             D:BKK=BKKD
             D:SUMMA = DEB
             ADD(D_TABLE)
             IF ERROR()
                KLUDA(29,'ADD D_TABLE')
                DO PROCEDURERETURN
             .
             SORT(D_TABLE,D:BKK)
          ELSE
             D:SUMMA+= DEB
             PUT(D_TABLE)
          .
!------------------------------------------------------------------------
FILLKTABLE ROUTINE
          GET(K_TABLE,0)
          K:BKK=BKKK
          GET(K_TABLE,K:BKK)
          IF ERROR()
             K:BKK=BKKK
             K:SUMMA = KRE
             ADD(K_TABLE)
             IF ERROR()
                KLUDA(29,'ADD K_TABLE')
                DO PROCEDURERETURN
             .
             SORT(K_TABLE,K:BKK)
          ELSE
             K:SUMMA+= KRE
             PUT(K_TABLE)
          .
!------------------------------------------------------------------------
FILLDKTABLE ROUTINE
          GET(DK_TABLE,0)
          DK:BKK=bkkd
          GET(DK_TABLE,DK:BKK)
          IF ERROR()
             DK:BKK=BKKD
             DK:SUMMA = DEB
             ADD(DK_TABLE)
             IF ERROR()
                KLUDA(29,'ADD DK_TABLE')
                DO PROCEDURERETURN
             .
             SORT(DK_TABLE,DK:BKK)
          ELSE
             DK:SUMMA+= DEB
             PUT(DK_TABLE)
          .
!------------------------------------------------------------------------
FILLKKTABLE ROUTINE
          GET(KK_TABLE,0)
          KK:BKK=BKKK
          GET(KK_TABLE,KK:BKK)
          IF ERROR()
             KK:BKK=BKKK
             KK:SUMMA = KRE
             ADD(KK_TABLE)
             IF ERROR()
                KLUDA(29,'ADD KK_TABLE')
                DO PROCEDURERETURN
             .
             SORT(KK_TABLE,KK:BKK)
          ELSE
             KK:SUMMA+= KRE
             PUT(KK_TABLE)
          .
