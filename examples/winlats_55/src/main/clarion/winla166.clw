                     MEMBER('winlats.clw')        ! This is a MEMBER module
P_KARLI_OBJ          PROCEDURE                    ! Declare Procedure
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
LIKME                STRING(10)
LIKME_TEXT           STRING(4)
VERT_S               SREAL
uzsk_v               SREAL
AMO_NOL_LING         LIKE(AMO:NOL_LIN)
RPT_GADS             DECIMAL(4)

SKAITS               DECIMAL(3)
IEGADATS             DECIMAL(12,2)
AMO_YYYYMM           STRING(9)

P_TABLE           QUEUE,PRE(P)
DATUMS               ULONG
SKAITS               DECIMAL(3)
AMO_NOL_LIN          LIKE(AMO:NOL_LIN)
A2                   STRING(10)   !OP.DATUMS
A3                   DECIMAL(11,2)
A4                   DECIMAL(11,2)
A5                   DECIMAL(11,2)
A6                   DECIMAL(11,2)
A8                   DECIMAL(11,2)
A9                   DECIMAL(11,2)
A11                  DECIMAL(11,2)
A12                  DECIMAL(11,2)
A13                  DECIMAL(12,2)
AMO_IZSLEGTS         LIKE(AMO:IZSLEGTS)
                  .

PAM_TEXT             STRING(120)
PAM_TEXT1            STRING(120)
VIRSRAKSTS           STRING(100)
OBJ_NOS_P            STRING(100)
StringNODALA         STRING(6)
A3K                  DECIMAL(11,2)
A4K                  DECIMAL(11,2)
A5K                  DECIMAL(11,2)
AMO_IZSLEGTSK        DECIMAL(11,2)

Process:View         VIEW(PAMAT)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:OBJ_NR)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:DATUMS)
                     END

report REPORT,AT(500,2323,12000,5500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,250,12000,2073),USE(?unnamed)
         LINE,AT(6563,1563,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7344,1563,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(8125,1563,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(3385,1563,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4167,1563,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4948,1563,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Pamatlîdzekïi :'),AT(365,1083,1302,208),USE(?StringPL),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s120),AT(1719,1083,8802,208),USE(PAM_TEXT,,?PAM_TEXT:2),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1708,1260,8802,208),USE(PAM_TEXT1),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(2802,1823,573,208),USE(?String7:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,10313,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Periods'),AT(260,1708,521,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(854,1563,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Operâcijas'),AT(3417,1615,729,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3469,1823,625,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai raþ. pi.'),AT(4198,1823,729,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(4979,1823,729,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+ / -'),AT(5896,1823,521,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+ / -'),AT(6698,1823,521,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(7427,1823,625,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periodâ'),AT(8260,1823,521,208),USE(?String181),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('per.b.'),AT(8958,1823,729,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(9792,1823,729,208),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2031,10313,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Atlikusî'),AT(9792,1615,729,208),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkr.nol.'),AT(8958,1615,729,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,1563,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9688,1563,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(10521,1563,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('P/L'),AT(2792,1615,573,208),USE(?String7:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums'),AT(8167,1615,729,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzskaites'),AT(7375,1615,729,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(6594,1615,729,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrtçðana'),AT(5760,1615,781,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5729,1563,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Kapitâlâs'),AT(4979,1615,729,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes izm.'),AT(4198,1615,729,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,0,521),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(1542,1563,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(2135,1563,0,521),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(2760,1563,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s45),AT(3802,104,4427,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1781,365,8490,208),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Objekta nosaukums :'),AT(365,875,1302,208),USE(?String7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(1719,854,7396,208),USE(OBJ_nos_p),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@N-_11.2B),AT(6615,0,625,156),USE(P:AMO_IZSLEGTS),RIGHT
         LINE,AT(7344,-10,0,198),USE(?Line3:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7396,0,677,156),USE(P:A9),RIGHT
         LINE,AT(8125,-10,0,198),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8177,0,677,156),USE(P:AMO_NOL_LIN),RIGHT
         LINE,AT(8906,-10,0,198),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8958,0,677,156),USE(P:A12),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9740,0,729,156),USE(P:A13),RIGHT
         STRING(@n3),AT(2917,0,365,156),USE(P:skaits),CENTER
         LINE,AT(2135,-10,0,198),USE(?Line3:121),COLOR(COLOR:Black)
         LINE,AT(2760,-10,0,198),USE(?Line3:1211),COLOR(COLOR:Black)
         STRING(@s9),AT(229,0,,156),USE(AMO_YYYYMM),CENTER
         LINE,AT(854,-10,0,198),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(1542,-10,0,198),USE(?Line3:112),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,198),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(208,156,10313,0),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,198),USE(?Line3:7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4219,0,677,156),USE(P:A3),RIGHT
         LINE,AT(4948,-10,0,198),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5010,0,677,156),USE(P:A4),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5781,0,,156),USE(P:A5),RIGHT
         LINE,AT(6563,-10,0,198),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line3:1221),COLOR(COLOR:Black)
         STRING(@S10),AT(3417,0,729,156),USE(P:A2),CENTER
       END
detailK DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@N-_11.2B),AT(6615,10,625,156),USE(AMO_IZSLEGTSK),RIGHT
         LINE,AT(7344,-10,0,198),USE(?Line3:K1),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,198),USE(?Line3:K2),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,198),USE(?Line3:K3),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,198),USE(?Line3:K4),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,198),USE(?Line3:K121),COLOR(COLOR:Black)
         LINE,AT(2760,-10,0,198),USE(?Line3:K1211),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(292,10,,156),USE(?StringKopa),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(854,-10,0,198),USE(?Line3:K12),COLOR(COLOR:Black)
         LINE,AT(1542,-10,0,198),USE(?Line3:K112),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,198),USE(?Line3:K5),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,198),USE(?Line3:K7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4219,10,677,156),USE(A3K),RIGHT
         LINE,AT(4948,-10,0,198),USE(?Line3:K8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5010,10,677,156),USE(A4K),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line3:K9),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5781,10,,156),USE(A5K),RIGHT
         LINE,AT(6563,-10,0,198),USE(?Line3:K10),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line3:K11),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line3:K1221),COLOR(COLOR:Black)
       END
RepFooT DETAIL,AT(,-10,,198),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(219,73),USE(?String30),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9427,73),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10063,73),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(719,73),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(208,0,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(854,0,0,63),USE(?Line52:2),COLOR(COLOR:Black)
         LINE,AT(1542,0,0,63),USE(?Line52:3),COLOR(COLOR:Black)
         LINE,AT(2135,0,0,63),USE(?Line52:4),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line52:5),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,63),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,63),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,63),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,63),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,63),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,63),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(8125,0,0,63),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(8906,0,0,63),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(9688,0,0,63),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(10521,0,0,63),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(208,52,10313,0),USE(?Line1:3),COLOR(COLOR:Black)
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
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(PAM:RECORD)
  BIND('GADS',GADS)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Objekta Karte (LIN)'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAMAT)
!      Process:View{Prop:Filter} = ''
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

      VIRSRAKSTS ='OBJEKTA Nr '&clip(F:OBJ_NR)&' ANALÎTISKÂS UZSKAITES UN NOLIETOJUMA APRÇÍINA KARTE uz '&FORMAT(B_DAT,@D06.)
      OBJ_NOS_P  =GETPROJEKTI(F:OBJ_NR,1)
      DAT=TODAY()
      LAI=CLOCK()
      PAM_TEXT =''
      PAM_TEXT1=''
      SKAITS   =0  !PL SKAITS OBJEKTÂ

    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF F:OBJ_NR=PAM:OBJ_NR
          FIRST_REC#=TRUE
          SKAITS+=1
          IF LEN(CLIP(PAM_TEXT))+LEN(CLIP(PAM:NOS_P))>120
             PAM_TEXT1=CLIP(PAM_TEXT1)&' '&CLIP(PAM:NOS_P)
          ELSE
             PAM_TEXT =CLIP(PAM_TEXT)&' '&CLIP(PAM:NOS_P)
          .
          CLEAR(AMO:RECORD)
          AMO:U_NR=PAM:U_NR
          SET(AMO:NR_KEY,AMO:NR_KEY)
          LOOP
            NEXT(PAMAM)
            IF ERROR() OR ~(PAM:U_NR=AMO:U_NR AND AMO:YYYYMM<=B_DAT) THEN BREAK.
!            INDEX#=YEAR(AMO:YYYYMM)-YEAR(PAM:EXPL_DATUMS)+1
            INDEX#=YEAR(AMO:YYYYMM)-1994+1
!            IF ~INRANGE(INDEX#,1,15)
!25/04/2015            IF ~INRANGE(INDEX#,1,20)
            IF ~INRANGE(INDEX#,1,25)
               KLUDA(0,'Gada indekss = '&CLIP(INDEX#)&' '&PAM:NOS_P)
            ELSE
               P:DATUMS=AMO:YYYYMM
               GET(P_TABLE,P:DATUMS)
               IF ERROR()
                  P:A2=''
                  P:A3=0
                  IEGADATS=0                        !IEP_V+1994
                  P:SKAITS=SKAITS
                  IF FIRST_REC#=TRUE
                     IEGADATS     =PAM:BIL_V
                     P:A2=FORMAT(PAM:DATUMS,@D06.)  !OP.DATUMS
                     P:A3=PAM:IEP_V
                     FIRST_REC#=FALSE
                  ELSIF AMO:KAPREM OR AMO:PARCEN OR AMO:PARCENLI
                     P:A2=FORMAT(AMO:YYYYMM,@D014.)
                  .
                  P:A4 =AMO:KAPREM
                  P:A5 =AMO:PARCEN+AMO:PARCENLI
                  P:A9 =IEGADATS+AMO:SAK_V_LI + AMO:KAPREM + P:A5
                  P:A12=AMO:NOL_U_LI + AMO:NOL_LIN
                  IF AMO:IZSLEGTS
                     P:A2=FORMAT(PAM:END_DATE,@D06.)
                     P:AMO_IZSLEGTS=AMO:IZSLEGTS
                     SKAITS-=1
                     P:A13=0
                  ELSE
                     P:AMO_IZSLEGTS=0 !10.03.08.
                     P:A13=IEGADATS+AMO:SAK_V_LI + AMO:KAPREM + P:A5 - P:A12
                  .
                  P:AMO_NOL_LIN=AMO:NOL_LIN
                  ADD(P_TABLE)
                  SORT(P_TABLE,P:DATUMS)
               ELSE
                  IEGADATS=0
                  P:SKAITS=SKAITS
                  IF FIRST_REC#=TRUE
                     IEGADATS    = PAM:BIL_V
                     P:A2        = FORMAT(PAM:DATUMS,@D06.)  !OP.DATUMS
                     P:A3       +=PAM:IEP_V
                     FIRST_REC#=FALSE
                  ELSIF AMO:KAPREM OR AMO:PARCEN OR AMO:PARCENLI
                     P:A2        =FORMAT(AMO:YYYYMM,@D014.)
                  .
                  P:A4          +=AMO:KAPREM
                  P:A5          +=AMO:PARCEN+AMO:PARCENLI
                  P:A9          +=IEGADATS+AMO:SAK_V_LI + AMO:KAPREM + AMO:PARCEN + AMO:PARCENLI
                  P:A12         +=AMO:NOL_U_LI + AMO:NOL_LIN
                  IF AMO:IZSLEGTS
                     P:A2           =FORMAT(PAM:END_DATE,@D06.)
                     P:AMO_IZSLEGTS+=AMO:IZSLEGTS
                     P:A13         -=AMO:IZSLEGTS
                  ELSE
                     P:A13         +=IEGADATS + AMO:SAK_V_LI + AMO:KAPREM + AMO:PARCEN + AMO:PARCENLI - AMO:NOL_U_LI - AMO:NOL_LIN
                  .
                  P:AMO_NOL_LIN    +=AMO:NOL_LIN
                  PUT(P_TABLE)
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    GET(P_TABLE,0)
    LOOP I#=1 TO RECORDS(P_TABLE)
        GET(P_TABLE,I#)
        AMO_YYYYMM=FORMAT(P:DATUMS,@D014.)
        PRINT(RPT:DETAIL)
        A3K+=P:A3
        A4K+=P:A4
        A5K+=P:A5
        AMO_IZSLEGTSK+=P:AMO_IZSLEGTS
    .
    PRINT(RPT:DETAILK)
    PRINT(RPT:REPFOOT)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(P_TABLE)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & ' %'
      DISPLAY()
    END
  END
P_KARLI              PROCEDURE                    ! Declare Procedure
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
LIKME                STRING(10)
LIKME_TEXT           STRING(4)
VERT_S               SREAL
uzsk_v               SREAL
AMO_NOL_LIN          LIKE(AMO:NOL_LIN)
AMO_NOL_LING         LIKE(AMO:NOL_LIN)
IEGADATS             DECIMAL(12,2)
RPT_GADS             DECIMAL(4)

AMO_YYYYMM           STRING(9)
KAT_NR               STRING(3)
A2                   STRING(10)
A3                   DECIMAL(11,2)
A4                   DECIMAL(11,2)
A5                   DECIMAL(11,2)
AMO_IZSLEGTS         LIKE(AMO:IZSLEGTS)
A6                   DECIMAL(11,2)
A8                   DECIMAL(11,2)
A9                   DECIMAL(11,2)
A11                  DECIMAL(11,2)
A12                  DECIMAL(11,2)
A13                  DECIMAL(12,2)

OLDPAM_TEXT          STRING(100)
VIRSRAKSTS           STRING(100)
PAM_NOS_P            STRING(100)
PAM_IZG_GAD          USHORT
pam_atb_nos          STRING(30)
A3K                  DECIMAL(11,2)
A4K                  DECIMAL(11,2)
A5K                  DECIMAL(11,2)
AMO_IZSLEGTSK        DECIMAL(11,2)
PAM_EXPL_DATUMS      LIKE(PAM:EXPL_DATUMS)


Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:NOL_G_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:PARCENLI)
                       PROJECT(AMO:IZSLEGTS)
                       PROJECT(AMO:SKAITS)
                     END

report REPORT,AT(500,2323,12000,5500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,250,12000,2073),USE(?unnamed)
         LINE,AT(6563,1563,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7344,1563,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(8125,1563,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(3385,1563,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4167,1563,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4948,1563,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@n4b),AT(1823,1094,417,208),USE(pam_izg_gad),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes datums :'),AT(365,1302,1198,208),USE(?StringIEGDAT),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(1823,1302,7448,208),USE(OLDPAM_TEXT),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Likme'),AT(1563,1615,573,208),USE(?String7:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodaïa'),AT(2177,1708,573,208),USE(?StringNODALA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(2802,1708,573,208),USE(?String7:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,10313,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Periods'),AT(260,1708,521,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(854,1563,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Operâcijas'),AT(3417,1615,729,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3469,1823,625,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai raþ. pi.'),AT(4198,1823,729,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(4979,1823,729,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+ / -'),AT(5896,1823,521,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+ / -'),AT(6698,1823,521,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(7427,1823,625,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periodâ'),AT(8260,1823,521,208),USE(?String181),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('per.b.'),AT(8958,1823,729,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(9792,1823,729,208),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s4),AT(1563,1823,573,208),USE(likme_text),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2031,10313,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Atlikusî'),AT(9792,1615,729,208),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkr.nol.'),AT(8958,1615,729,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,1563,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9688,1563,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(10521,1563,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Nolietojums'),AT(8167,1615,729,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzskaites'),AT(7375,1615,729,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(6594,1615,729,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrtçðana'),AT(5760,1615,781,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5729,1563,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Kapitâlâs'),AT(4979,1615,729,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes izm.'),AT(4198,1615,729,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Izgatavoðanas gads :'),AT(365,1094,1302,208),USE(?StringIZGG),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kategorija'),AT(865,1708,677,208),USE(?String7:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1542,1563,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(2135,1563,0,521),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(2760,1563,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s45),AT(3802,104,4427,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1688,365,8646,208),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums :'),AT(365,677,1042,208),USE(?String7:3),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(1823,677,7396,208),USE(pam_nos_p),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Atbildîgais :'),AT(365,885,1042,208),USE(?String7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s30),AT(1823,885,2292,208),USE(pam_atb_nos),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@N-_11.2B),AT(6615,0,625,156),USE(AMO_IZSLEGTS),RIGHT
         LINE,AT(7344,-10,0,198),USE(?Line3:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7396,0,677,156),USE(A9),RIGHT
         LINE,AT(8125,-10,0,198),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8177,0,677,156),USE(AMO_NOL_LIN),RIGHT
         LINE,AT(8906,-10,0,198),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8958,0,677,156),USE(A12),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9740,0,729,156),USE(A13),RIGHT
         STRING(@n3),AT(2917,0,365,156),USE(amo:skaits),LEFT
         STRING(@N_6.3),AT(1635,0,396,156),USE(AMO:LIN_G_PR)
         STRING(@S2),AT(2240,0,469,156),USE(AMO:NODALA),CENTER
         LINE,AT(2135,-10,0,198),USE(?Line3:121),COLOR(COLOR:Black)
         LINE,AT(2760,-10,0,198),USE(?Line3:1211),COLOR(COLOR:Black)
         STRING(@s9),AT(229,0,,156),USE(AMO_YYYYMM),CENTER
         STRING(@p#-##p),AT(1031,0,313,156),USE(kat_nr),LEFT
         LINE,AT(854,-10,0,198),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(1542,-10,0,198),USE(?Line3:112),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,198),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(208,156,10313,0),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,198),USE(?Line3:7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4219,0,677,156),USE(A3),RIGHT
         LINE,AT(4948,-10,0,198),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5010,0,677,156),USE(A4),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5781,0,,156),USE(A5),RIGHT
         LINE,AT(6563,-10,0,198),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line3:1221),COLOR(COLOR:Black)
         STRING(@S10),AT(3417,0,729,156),USE(A2),CENTER
       END
detailK DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@N-_11.2B),AT(6615,10,625,156),USE(AMO_IZSLEGTSK),RIGHT
         LINE,AT(7344,-10,0,198),USE(?Line3:K1),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,198),USE(?Line3:K2),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,198),USE(?Line3:K3),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,198),USE(?Line3:K4),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,198),USE(?Line3:K121),COLOR(COLOR:Black)
         LINE,AT(2760,-10,0,198),USE(?Line3:K1211),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(292,10,,156),USE(?StringKopa),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(854,-10,0,198),USE(?Line3:K12),COLOR(COLOR:Black)
         LINE,AT(1542,-10,0,198),USE(?Line3:K112),COLOR(COLOR:Black)
         LINE,AT(10521,-10,0,198),USE(?Line3:K5),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,198),USE(?Line3:K7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4219,10,677,156),USE(A3K),RIGHT
         LINE,AT(4948,-10,0,198),USE(?Line3:K8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5010,10,677,156),USE(A4K),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line3:K9),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5781,10,,156),USE(A5K),RIGHT
         LINE,AT(6563,-10,0,198),USE(?Line3:K10),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line3:K11),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line3:K1221),COLOR(COLOR:Black)
       END
RepFooT DETAIL,AT(,-10,,198),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(219,73),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(9427,73),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10063,73),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(719,73),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(208,0,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(854,0,0,63),USE(?Line52:2),COLOR(COLOR:Black)
         LINE,AT(1542,0,0,63),USE(?Line52:3),COLOR(COLOR:Black)
         LINE,AT(2135,0,0,63),USE(?Line52:4),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line52:5),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,63),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,63),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,63),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,63),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,63),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,63),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(8125,0,0,63),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(8906,0,0,63),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(9688,0,0,63),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(10521,0,0,63),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(208,52,10313,0),USE(?Line1:3),COLOR(COLOR:Black)
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
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:U_NR',PAM:U_NR)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P/L Karte (LIN)'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(AMO:RECORD)
      AMO:U_NR=PAM:U_NR
      SET(AMO:NR_KEY,AMO:NR_KEY)
!      Process:View{Prop:Filter} = 'AMO:U_NR=PAM:U_NR'
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
      VIRSRAKSTS='PAMATLÎDZEKÏA ANALÎTISKÂS UZSKAITES UN NOLIETOJUMA APRÇÍINA KARTE Nr '&CLIP(PAM:U_NR)&' uz '&FORMAT(B_DAT,@D06.)
      PAM_NOS_P  =PAM:NOS_P
      PAM_IZG_GAD=PAM:IZG_GAD
      OLDPAM_TEXT=FORMAT(PAM:DATUMS,@D06.)&' '&CLIP(PAM:DOK_SENR)
      IF PAM:EXPL_DATUMS<DATE(1,1,1995)
         OLDPAM_TEXT=CLIP(OLDPAM_TEXT)&' Vçrtîbas izmaiòu un nolietojuma summa uz 01.01.1995 = '&CLIP(LEFT(FORMAT(PAM:KAP_V+PAM:NOL_V,@N10.2)))
      .
      IF ~(PAM:EXPL_DATUMS=PAM:DATUMS)
         OLDPAM_TEXT=CLIP(OLDPAM_TEXT)&' Ekspluatâcijâ nodots '&format(PAM:EXPL_DATUMS,@D06.)
      .
      IF PAM:ATB_NR
         PAM_ATB_NOS=CLIP(PAM:ATB_NR)&' '&PAM:ATB_NOS
      ELSE
         PAM_ATB_NOS=''
      .
      DAT=TODAY()
      LAI=CLOCK()
      IF SUB(PAM:KAT[1],1,1)='1'     !1.KATEGORIJA
         LIKME_TEXT='%'
      ELSE
         LIKME_TEXT='gadi'
      .
      FIRST_REC#=TRUE

      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
        IF ~OPENANSI('P_KARLI.TXT')
          POST(Event:CloseWindow)
          CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE='Nosaukums: '&PAM_NOS_P
        ADD(OUTFILEANSI)
        OUTA:LINE='Atbildîgais: '&PAM_ATB_NOS
        ADD(OUTFILEANSI)
        OUTA:LINE='Izgatavoðanas gads: '&PAM_IZG_GAD       
        ADD(OUTFILEANSI)
        OUTA:LINE='Iegâdes datums: '&OLDPAM_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Periods'&CHR(9)&'Kategorija'&CHR(9)&'Likme'&CHR(9)&'Nodaïa'&CHR(9)&'Skaits'&CHR(9)&|
        'Operâcijas'&CHR(9)&'Iegâdes'&CHR(9)&'Kapitâlâs'&CHR(9)&'Pârvçrtçðana'&CHR(9)&'Izslçgðana'&CHR(9)&|
        'Uzskaites'&CHR(9)&'Nolietojums'&CHR(9)&'Uzkrâtais'&CHR(9)&'Atlikusî'
        ADD(OUTFILEANSI)
        OUTA:LINE=''&CHR(9)&''&CHR(9)&'(gadi)'&CHR(9)&''&CHR(9)&''&CHR(9)&|
        'datums'&CHR(9)&'izmaksas'&CHR(9)&'izmaksas'&CHR(9)&''&CHR(9)&''&CHR(9)&|
        'vçrtîba'&CHR(9)&'periodâ'&CHR(9)&'nolietojums'&CHR(9)&'vçrtîba'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF YEAR(PAM:EXPL_DATUMS) < 1995
           PAM_EXPL_DATUMS=DATE(1,1,1995) !1=1995,15=2009(GD: 1994 iekð PAMAT NAV...)
        ELSE
           PAM_EXPL_DATUMS=PAM:EXPL_DATUMS
        .
        INDEX#=YEAR(AMO:YYYYMM)-YEAR(PAM_EXPL_DATUMS)+1  ! PÂRINDEKSÂCIJA iekð PAMAT:GD[] MAX=15
        IF INDEX#<1 THEN INDEX#=1. !DÇÏ AMO:1994.12
!        IF ~INRANGE(INDEX#,1,15)
        !12/05/2015 IF ~INRANGE(INDEX#,1,20)
        IF ~INRANGE(INDEX#,1,40)
           KLUDA(0,'Gada indekss = '&CLIP(INDEX#)&' '&PAM:NOS_P)
        ELSE
           KAT_NR=PAM:KAT[INDEX#]
           A2=''
           A3=0
           IEGADATS=0
           IF FIRST_REC#=TRUE
              IEGADATS     =PAM:BIL_V
              A2=FORMAT(PAM:DATUMS,@D06.)
              A3=PAM:IEP_V
              FIRST_REC#=FALSE
           ELSIF AMO:KAPREM OR AMO:PARCEN OR AMO:PARCENLI
              A2=FORMAT(AMO:YYYYMM,@D014.)
           .
           A4 =AMO:KAPREM
           A5 =AMO:PARCEN+AMO:PARCENLI
           A9 =IEGADATS+AMO:SAK_V_LI + AMO:KAPREM + A5
           A12=AMO:NOL_U_LI + AMO:NOL_LIN
           A3K+=A3
           A4K+=A4
           A5K+=A5
           AMO_IZSLEGTSK+=AMO:IZSLEGTS
           IF AMO:IZSLEGTS
              IF AMO_NOL_LING !IR NOLIETOJUMS IZSLÇGÐANAS GADÂ
!                 AMO_YYYYMM='1-'&CLIP(MONTH(AMO:YYYYMM))&'/'&CLIP(YEAR(AMO:YYYYMM))
                 AMO_YYYYMM=FORMAT(AMO:YYYYMM,@D014.)
                 AMO_NOL_LIN=AMO_NOL_LING !SASKAITAM VISU GADU, JA VAJAG
                 IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                 ELSE
                    OUTA:LINE=AMO_YYYYMM&CHR(9)&LEFT(FORMAT(kat_nr,@p#-##p))&CHR(9)&LEFT(FORMAT(AMO:LIN_G_PR,@N_6.3))&|
                    CHR(9)&AMO:NODALA&CHR(9)&LEFT(FORMAT(amo:skaits,@N_3B))&CHR(9)&A2&CHR(9)&LEFT(FORMAT(A3,@N_11.2B))&|
                    CHR(9)&LEFT(FORMAT(A4,@N-_12.2B))&CHR(9)&LEFT(FORMAT(A5,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_IZSLEGTS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A9,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_NOL_LIN,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A12,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(A13,@N-_11.2B))
                    ADD(OUTFILEANSI)
                 .
              .
              A2=FORMAT(PAM:END_DATE,@D06.)
              AMO_IZSLEGTS=AMO:IZSLEGTS
              A13=0
           ELSE
              A13=IEGADATS+AMO:SAK_V_LI + AMO:KAPREM + A5 - A12
           .
           IF F:DTK                    !JÂDRUKÂ PA GADIEM
              AMO_NOL_LING+=AMO:NOL_LIN
              IF A2                    !KAUT KAS IR MAINÎJIES
                 AMO_YYYYMM=FORMAT(AMO:YYYYMM,@D014.)
                 AMO_NOL_LIN=AMO:NOL_LIN
                 IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                 ELSE
                    OUTA:LINE=AMO_YYYYMM&CHR(9)&LEFT(FORMAT(kat_nr,@p#-##p))&CHR(9)&LEFT(FORMAT(AMO:LIN_G_PR,@N_6.3))&|
                    CHR(9)&AMO:NODALA&CHR(9)&LEFT(FORMAT(amo:skaits,@N_3B))&CHR(9)&A2&CHR(9)&LEFT(FORMAT(A3,@N_11.2B))&|
                    CHR(9)&LEFT(FORMAT(A4,@N-_12.2B))&CHR(9)&LEFT(FORMAT(A5,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_IZSLEGTS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A9,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_NOL_LIN,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A12,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(A13,@N-_11.2B))
                    ADD(OUTFILEANSI)
                 .
                 A2=''
                 A3=0
                 A4=0
                 A5=0
              .
              IF MONTH(AMO:YYYYMM)=12
                 AMO_YYYYMM=YEAR(AMO:YYYYMM)&'.g.'
                 AMO_NOL_LIN=AMO_NOL_LING
                 IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                 ELSE
                    OUTA:LINE=AMO_YYYYMM&CHR(9)&LEFT(FORMAT(kat_nr,@p#-##p))&CHR(9)&LEFT(FORMAT(AMO:LIN_G_PR,@N_6.3))&|
                    CHR(9)&AMO:NODALA&CHR(9)&LEFT(FORMAT(amo:skaits,@N_3B))&CHR(9)&A2&CHR(9)&LEFT(FORMAT(A3,@N_11.2B))&|
                    CHR(9)&LEFT(FORMAT(A4,@N-_12.2B))&CHR(9)&LEFT(FORMAT(A5,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_IZSLEGTS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A9,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(AMO_NOL_LIN,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A12,@N-_11.2B))&CHR(9)&|
                    LEFT(FORMAT(A13,@N-_11.2B))
                    ADD(OUTFILEANSI)
                 .
                 AMO_NOL_LING=0
              .
           ELSE
              AMO_YYYYMM=FORMAT(AMO:YYYYMM,@D014.)
              AMO_NOL_LIN=AMO:NOL_LIN
              IF F:DBF='W'
                 PRINT(RPT:DETAIL)
              ELSE
                 OUTA:LINE=AMO_YYYYMM&CHR(9)&LEFT(FORMAT(kat_nr,@p#-##p))&CHR(9)&LEFT(FORMAT(AMO:LIN_G_PR,@N_6.3))&|
                 CHR(9)&AMO:NODALA&CHR(9)&LEFT(FORMAT(amo:skaits,@N_3B))&CHR(9)&A2&CHR(9)&LEFT(FORMAT(A3,@N_11.2B))&|
                 CHR(9)&LEFT(FORMAT(A4,@N-_12.2B))&CHR(9)&LEFT(FORMAT(A5,@N-_11.2B))&CHR(9)&|
                 LEFT(FORMAT(AMO_IZSLEGTS,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A9,@N-_11.2B))&CHR(9)&|
                 LEFT(FORMAT(AMO_NOL_LIN,@N-_11.2B))&CHR(9)&LEFT(FORMAT(A12,@N-_11.2B))&CHR(9)&|
                 LEFT(FORMAT(A13,@N-_11.2B))
                 ADD(OUTFILEANSI)
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAILK)
    PRINT(RPT:REPFOOT)
    ENDPAGE(report)
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
  IF ERRORCODE() OR ~(AMO:U_NR=PAM:U_NR AND AMO:YYYYMM<=B_DAT)
!    STOP(FORMAT(AMO:YYYYMM,@D6)&' '&FORMAT(B_DAT,@D6)&' '&AMO:U_NR&' '&PAM:U_NR&' '&ERROR())
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
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
P_NolaprLIN          PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:OBJ_NR)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:DATUMS)
                     END
!-----------------------------------------------------------------------------

SAV_AMO_U_NR        LIKE(AMO:U_NR)
DATUMS_S            LONG
JADRUKA             BYTE
FILTRS_TEXT         STRING(80)
CP                  STRING(10)

NOLM                DECIMAL(10,2),DIM(12)
VERT_S              DECIMAL(11,2)
VERT_I              DECIMAL(10,2)
VERT_NON            DECIMAL(10,2)
VERT_SB             DECIMAL(11,2)
NOLMK               DECIMAL(10,2),DIM(12)
VERT_SK             DECIMAL(11,2)
VERT_IK             DECIMAL(10,2)
VERT_MK             DECIMAL(10,2)
VERT_NK             DECIMAL(10,2)
VERT_UK             DECIMAL(11,2)
VERT_NONK           DECIMAL(10,2)
VERT_BK             DECIMAL(12,2)

TS                  STRING(4)
BS                  STRING(5)
BN_NODALA           STRING(2)

B_TABLE           QUEUE,PRE(B)
BKK                 STRING(5)
NOLMK               DECIMAL(10,2),DIM(12)
VERT_NK             DECIMAL(10,2)
VERT_UK             DECIMAL(11,2)
VERT_NONK           DECIMAL(10,2)
VERT_BK             DECIMAL(12,2)
                  .
BN_TABLE          QUEUE,PRE(BN)
BKK_NOD             STRING(7)
NOLMK               DECIMAL(10,2),DIM(12)
                  .
N_TABLE           QUEUE,PRE(N)
NODALA              STRING(2)
NOLMK               DECIMAL(10,2),DIM(12)
                  .
O_TABLE           QUEUE,PRE(O)
OBJ_NR              ULONG
NOLMK               DECIMAL(10,2),DIM(12)
                  .
N_VERT_NK         DECIMAL(10,2)
N_VERT_UK         DECIMAL(11,2)  !?
N_VERT_NONK       DECIMAL(10,2)  !?
N_VERT_BK         DECIMAL(12,2)  !?

VERT_N              DECIMAL(10,3) !VIENÎGAIS, KAM SKAITA 3 ZÎMES,KAD SASKAITÎTI VISI MÇNEÐI, NOAPAÏO
VERT_N_PIRMS        DECIMAL(10,2)
VERT_U              DECIMAL(11,2)
VERT_B              DECIMAL(12,2)
KOPA                STRING(15)
BKK                 STRING(5)

ATL_DATUMS          LONG
ATL_DIENA           BYTE
DAT                 LONG
LAI                 LONG
NOText              STRING(30)
NODALA              STRING(2),DIM(12)

DELTA               DECIMAL(10,3)
VIRSRAKSTS          STRING(80)
M                   STRING(8),DIM(12)

!-----------------------------------------------------------------------------
report REPORT,AT(120,1727,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(120,300,12000,1427),USE(?unnamed:2)
         STRING(@s8),AT(3458,1042,490,208),USE(M[3]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s8),AT(2417,1042,490,208),USE(M[1]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('fin.gada'),AT(8688,990,521,208),USE(?String13:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliet.'),AT(9271,990,521,208),USE(?String13:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc SV'),AT(9854,990,521,208),USE(?String13:12),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1406,11094,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s20),AT(6583,1042,490,208),USE(M[9]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(7104,1042,490,208),USE(M[10]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(7625,1042,490,208),USE(M[11]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(8146,1042,490,208),USE(M[12]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6563,938,0,521),USE(?Line48:4),COLOR(COLOR:Black)
         LINE,AT(7083,938,0,521),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(7604,938,0,521),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(8125,938,0,521),USE(?Line55:3),COLOR(COLOR:Black)
         STRING(@s20),AT(6063,1042,490,208),USE(M[8]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,938,0,521),USE(?Line48:3),COLOR(COLOR:Black)
         STRING(@s20),AT(5542,1042,490,208),USE(M[7]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5521,938,0,521),USE(?Line48:2),COLOR(COLOR:Black)
         STRING(@s20),AT(5021,1042,490,208),USE(M[6]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5000,938,0,521),USE(?Line48),COLOR(COLOR:Black)
         STRING(@s20),AT(4500,1042,490,208),USE(M[5]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4479,938,0,521),USE(?Line46:2),COLOR(COLOR:Black)
         STRING(@s20),AT(3979,1042,490,208),USE(M[4]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,938,0,521),USE(?Line46),COLOR(COLOR:Black)
         STRING('sâkuma'),AT(8677,1198,521,208),USE(?String13:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+1994'),AT(9271,1198,521,208),USE(?String13:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+1994'),AT(9854,1198,521,208),USE(?String13:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3438,938,0,521),USE(?Line42:2),COLOR(COLOR:Black)
         STRING(@s8),AT(2938,1042,490,208),USE(M[2]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3750,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,938,0,521),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(2396,938,6250,0),USE(?Line41),COLOR(COLOR:Black)
         STRING(@s80),AT(2510,302,6927,219),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma PL:LI:1'),AT(10448,396,729,156),USE(?String11),RIGHT
         STRING(@P<<<#. lapaP),AT(10500,552,677,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s80),AT(3354,510,5208,177),USE(FILTRS_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,11094,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,729,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2396,729,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(8646,729,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(9219,729,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(9823,729,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(10396,729,0,729),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(11198,729,0,729),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Nr'),AT(177,1031,260,156),USE(?String13:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(573,1042,1615,156),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums par'),AT(4917,760,1177,156),USE(?String13:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nol. no'),AT(8698,781,469,208),USE(?String13:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkr.'),AT(9323,781,469,208),USE(?String13:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Noò.'),AT(9854,781,521,208),USE(?String13:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(10448,990,625,208),USE(?String13:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(104,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_6),AT(115,10,340,156),USE(PAM:U_NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,-10,0,197),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@S35),AT(510,10,1875,156),USE(PAM:NOS_P),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_9.2b),AT(7115,10,469,156),USE(NOLM[10]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(NOLM[11]),RIGHT
         STRING(@N_9.2b),AT(8156,10,469,156),USE(NOLM[12]),RIGHT
         LINE,AT(2396,-10,0,197),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(NOLM[1]),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(NOLM[2]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(NOLM[6]),RIGHT
         STRING(@N_9.2b),AT(5552,10,469,156),USE(NOLM[7]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(NOLM[9]),RIGHT
         LINE,AT(2917,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8677,10,521,156),USE(VERT_N),RIGHT
         LINE,AT(9219,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9240,0,573,156),USE(VERT_U),RIGHT
         LINE,AT(9823,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(9854,10,521,156),USE(VERT_NON),RIGHT
         LINE,AT(10396,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(10448,10,729,156),USE(VERT_B),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(NOLM[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(NOLM[4]),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(4510,10,469,156),USE(NOLM[5]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(NOLM[8]),RIGHT
         LINE,AT(8125,-10,0,197),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,197),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line58),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,-10,,177),USE(?unnamed:7)
         LINE,AT(104,0,0,197),USE(?Line68:4),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,197),USE(?Line68:5),COLOR(COLOR:Black)
         LINE,AT(2917,0,0,197),USE(?Line68:6),COLOR(COLOR:Black)
         LINE,AT(3438,0,0,197),USE(?Line68:7),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,197),USE(?Line68:8),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,197),USE(?Line68:9),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,197),USE(?Line68:10),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,197),USE(?Line68:11),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,197),USE(?Line68:12),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,197),USE(?Line68:13),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,197),USE(?Line68:14),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,197),USE(?Line68:15),COLOR(COLOR:Black)
         LINE,AT(8125,0,0,197),USE(?Line68:16),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,197),USE(?Line68:17),COLOR(COLOR:Black)
         LINE,AT(9219,0,0,197),USE(?Line68:18),COLOR(COLOR:Black)
         LINE,AT(9823,0,0,197),USE(?Line68:19),COLOR(COLOR:Black)
         LINE,AT(10396,0,0,197),USE(?Line68:20),COLOR(COLOR:Black)
         LINE,AT(11198,0,0,197),USE(?Line68:3),COLOR(COLOR:Black)
         LINE,AT(104,52,11094,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(469,0,0,63),USE(?Line68:2),COLOR(COLOR:Black)
       END
LINE1  DETAIL,AT(,,,0)
         LINE,AT(104,,11094,0),USE(?Line11:5),COLOR(COLOR:Black)
       END
RepFootKOPA DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,197),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8156,10,469,156),USE(NOLMK[12]),RIGHT
         LINE,AT(8125,-10,0,197),USE(?Line3:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8677,10,521,156),USE(VERT_NK),RIGHT
         LINE,AT(8646,-10,0,197),USE(?Line3:15),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9240,10,573,156),USE(VERT_UK),RIGHT
         LINE,AT(9219,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(156,10,,156),USE(?String58),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(NOLMK[1]),RIGHT
         STRING(@N_10.2B),AT(9854,10,521,156),USE(VERT_NONK),RIGHT
         LINE,AT(10396,-10,0,197),USE(?Line3:17),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(10448,10,729,156),USE(VERT_BK),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(NOLMK[2]),RIGHT
         STRING(@N_9.2b),AT(4510,10,469,156),USE(NOLMK[5]),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line3:18),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(5552,10,469,156),USE(NOLMK[7]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(NOLMK[8]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(NOLMK[9]),RIGHT
         STRING(@N_9.2b),AT(7115,10,469,156),USE(NOLMK[10]),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(NOLMK[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(NOLMK[4]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(NOLMK[6]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(NOLMK[11]),RIGHT
         LINE,AT(7604,-10,0,197),USE(?Line77),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line76),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line74),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line73),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line72),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line70),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,197),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,197),USE(?Line66),COLOR(COLOR:Black)
       END
RepFootBKK DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(104,-10,0,197),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,197),USE(?Line4:14),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,197),USE(?Line4:15),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,197),USE(?Line4:16),COLOR(COLOR:Black)
         STRING(@s4),AT(135,10,,156),USE(TS),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10396,0,0,197),USE(?Line4:17),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(B:NOLMK[1]),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(B:NOLMK[2]),RIGHT
         STRING(@N_9.2b),AT(4510,10,469,156),USE(B:NOLMK[5]),RIGHT
         STRING(@N_9.2b),AT(5552,10,469,156),USE(B:NOLMK[7]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(B:NOLMK[8]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(B:NOLMK[9]),RIGHT
         STRING(@N_9.2b),AT(7115,10,469,156),USE(B:NOLMK[10]),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(B:NOLMK[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(B:NOLMK[4]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(B:NOLMK[6]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(B:NOLMK[11]),RIGHT
         STRING(@N_10.2B),AT(8156,10,469,156),USE(B:NOLMK[12]),RIGHT
         STRING(@N_10.2B),AT(8677,10,521,156),USE(B:VERT_NK),RIGHT
         STRING(@N-_12.2B),AT(10448,10,729,156),USE(B:VERT_BK),RIGHT
         STRING(@s30),AT(823,0,1563,156),USE(NoText,,?NoText:3),TRN,LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_11.2B),AT(9240,10,573,156),USE(B:VERT_UK),RIGHT
         STRING(@N_10.2B),AT(9854,10,521,156),USE(B:VERT_NONK),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line4:18),COLOR(COLOR:Black)
         STRING(@s5),AT(458,10,,156),USE(BS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7604,-10,0,197),USE(?Line477),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line476),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line475),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line474),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line473),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line472),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line471),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line470),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line469),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line468),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,197),USE(?Line467),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,197),USE(?Line466),COLOR(COLOR:Black)
       END
RepFootBN DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,197),USE(?Line5486:10),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,197),USE(?Line5487:14),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,197),USE(?Line5487:15),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,197),USE(?Line5486:16),COLOR(COLOR:Black)
         STRING(@s4),AT(469,10,,156),USE(TS,,?TS:3),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10396,-10,0,197),USE(?Line5486:17),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(BN:NOLMK[1]),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(BN:NOLMK[2]),RIGHT
         STRING(@N_9.2b),AT(4510,10,469,156),USE(BN:NOLMK[5]),RIGHT
         STRING(@N_9.2b),AT(5552,10,469,156),USE(BN:NOLMK[7]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(BN:NOLMK[8]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(BN:NOLMK[9]),RIGHT
         STRING(@N_9.2b),AT(7115,10,469,156),USE(BN:NOLMK[10]),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(BN:NOLMK[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(BN:NOLMK[4]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(BN:NOLMK[6]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(BN:NOLMK[11]),RIGHT
         STRING(@N_10.2B),AT(8156,10,469,156),USE(BN:NOLMK[12]),RIGHT
         STRING(@N_10.2B),AT(8677,10,521,156),USE(N_VERT_NK),RIGHT
         STRING(@N-_12.2B),AT(10448,10,729,156),USE(N_VERT_BK),RIGHT
         STRING(@N_11.2B),AT(9240,10,573,156),USE(N_VERT_UK),RIGHT
         STRING(@N_10.2B),AT(9854,10,521,156),USE(N_VERT_NONK),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line486:18),COLOR(COLOR:Black)
         STRING(@s30),AT(979,10,1406,156),USE(NoText),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(792,10,,156),USE(BN_NODALA,,?BN_NODALA:2),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7604,-10,0,197),USE(?Line5477:11),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line5476:12),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line5475:65),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line5474:78),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line5473:46),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line5472:89),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line5471:87),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line5470:43),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line5469:834),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line5468:63),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,197),USE(?Line5467:91),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,197),USE(?Line5466:34),COLOR(COLOR:Black)
       END
RepFootNOD DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(104,-10,0,197),USE(?Line486:10),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,197),USE(?Line487:14),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,197),USE(?Line487:15),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,197),USE(?Line486:16),COLOR(COLOR:Black)
         STRING(@s4),AT(135,10,,156),USE(TS,,?TS:2),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10396,-10,0,197),USE(?Line486:17),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(N:NOLMK[1]),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(N:NOLMK[2]),RIGHT
         STRING(@N_9.2b),AT(4510,10,469,156),USE(N:NOLMK[5]),RIGHT
         STRING(@N_9.2b),AT(5552,10,469,156),USE(N:NOLMK[7]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(N:NOLMK[8]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(N:NOLMK[9]),RIGHT
         STRING(@N_9.2b),AT(7115,10,469,156),USE(N:NOLMK[10]),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(N:NOLMK[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(N:NOLMK[4]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(N:NOLMK[6]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(N:NOLMK[11]),RIGHT
         STRING(@N_10.2B),AT(8156,10,469,156),USE(N:NOLMK[12]),RIGHT
         STRING(@N_10.2B),AT(8677,10,521,156),USE(N_VERT_NK,,?N_VERT_NK:2),RIGHT
         STRING(@N-_12.2B),AT(10448,10,729,156),USE(N_VERT_BK,,?N_VERT_BK:2),RIGHT
         STRING(@N_11.2B),AT(9240,10,573,156),USE(N_VERT_UK,,?N_VERT_UK:2),RIGHT
         STRING(@N_10.2B),AT(9854,10,521,156),USE(N_VERT_NONK,,?N_VERT_NONK:2),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line5486:18),COLOR(COLOR:Black)
         STRING(@s30),AT(656,10,1719,156),USE(NoText,,?NoText:2),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(458,10,,156),USE(N:NODALA),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7604,-10,0,197),USE(?Line477:11),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line476:12),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line475:65),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line474:78),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line473:46),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line472:89),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line471:87),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line470:43),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line469:834),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line468:63),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,197),USE(?Line467:91),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,197),USE(?Line466:34),COLOR(COLOR:Black)
       END
RepFootOBJ DETAIL,AT(,,,177),USE(?OBJ_NR)
         LINE,AT(104,-10,0,197),USE(?Line486:O10),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,197),USE(?Line487:O14),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,197),USE(?Line487:O15),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,197),USE(?Line486:O16),COLOR(COLOR:Black)
         LINE,AT(10396,-10,0,197),USE(?Line486:O17),COLOR(COLOR:Black)
         STRING(@N_9.2b),AT(2427,10,469,156),USE(O:NOLMK[1]),RIGHT
         STRING(@N_9.2b),AT(2948,10,469,156),USE(O:NOLMK[2]),RIGHT
         STRING(@N_9.2b),AT(4510,10,469,156),USE(O:NOLMK[5]),RIGHT
         STRING(@N_9.2b),AT(5552,10,469,156),USE(O:NOLMK[7]),RIGHT
         STRING(@N_9.2b),AT(6073,10,469,156),USE(O:NOLMK[8]),RIGHT
         STRING(@N_9.2b),AT(6594,10,469,156),USE(O:NOLMK[9]),RIGHT
         STRING(@N_9.2b),AT(7115,10,469,156),USE(O:NOLMK[10]),RIGHT
         STRING(@N_9.2b),AT(3469,10,469,156),USE(O:NOLMK[3]),RIGHT
         STRING(@N_9.2b),AT(3990,10,469,156),USE(O:NOLMK[4]),RIGHT
         STRING(@N_9.2b),AT(5031,10,469,156),USE(O:NOLMK[6]),RIGHT
         STRING(@N_9.2b),AT(7635,10,469,156),USE(O:NOLMK[11]),RIGHT
         STRING(@N_10.2B),AT(8156,10,469,156),USE(O:NOLMK[12]),RIGHT
         STRING(@N_10.2B),AT(8677,10,521,156),USE(N_VERT_NK,,?N_VERT_NK:O),RIGHT
         STRING(@N-_12.2B),AT(10448,10,729,156),USE(N_VERT_BK,,?N_VERT_BK:O),RIGHT
         STRING(@N_11.2B),AT(9240,10,573,156),USE(N_VERT_UK,,?N_VERT_UK:O),RIGHT
         STRING(@N_10.2B),AT(9854,10,521,156),USE(N_VERT_NONK,,?N_VERT_NONK:O),RIGHT
         LINE,AT(11198,-10,0,197),USE(?Line5486:O18),COLOR(COLOR:Black)
         STRING(@s30),AT(500,10,1875,156),USE(NOText,,?NOText:O2),LEFT(10),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_7),AT(156,10,313,156),USE(O:OBJ_NR),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7604,-10,0,197),USE(?Line477:O11),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,197),USE(?Line476:O12),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,197),USE(?Line475:O65),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line474:O78),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line473:O46),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,197),USE(?Line472:O89),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line471:O87),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,197),USE(?Line470:O43),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,197),USE(?Line469:O834),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line468:O63),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,197),USE(?Line467:O91),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,197),USE(?Line466:O34),COLOR(COLOR:Black)
       END
RepFoot DETAIL,AT(,,,240),USE(?unnamed:5)
         LINE,AT(104,-10,0,62),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,62),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,62),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(8125,-10,0,62),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(9219,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(9823,-10,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(10396,-10,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(11198,-10,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(104,52,11094,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(125,73),USE(?String59),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(583,73),USE(acc_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(10094,73),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(10719,73),USE(lai),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(2396,-10,0,62),USE(?Line87),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,62),USE(?Line86),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,62),USE(?Line85),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,62),USE(?Line84),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,62),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,62),USE(?Line82),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,62),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,62),USE(?Line79),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,62),USE(?Line79:2),COLOR(COLOR:Black)
       END
       FOOTER,AT(120,7950,12000,52)
         LINE,AT(104,0,11094,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  VIRSRAKSTS='Ilgtermiòa ieguldîjumu nolietojuma aprçíins uz '&FORMAT(B_DAT,@D06.)&' (Lin.m.)'
  IF F:KAT_NR>'000' THEN FILTRS_TEXT='Kategorija: '&F:KAT_NR[1]&'-'&F:KAT_NR[2:3].
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Objekta(Pr.): '&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
  CP='1'
  FGK#=12-MONTH(DB_B_DAT)
  LOOP I#=1 TO 12
     M#=I#-FGK#
     IF M#<=0
        M#+=12
        G#=GADS-1
     ELSE
        G#=0
     .
     M[I#]=MENVAR(M#,1,6)&FORMAT(G#,@N_4B)
  .
  S_DAT=DATE(MONTH(DB_B_DAT)+1,1,YEAR(DB_B_DAT)-1)
!  STOP(FORMAT(S_DAT,@D06.))
!  FING=GETFING(1,DB_GADS)             !FINANSU GADA TEKSTS

  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
!  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Nolietojuma aprçíins'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1))' !NAV NOÒEMTS IEPR.G-OS
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
        IF ~OPENANSI('NOLAPRLIN.TXT')
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
          OUTA:LINE='Nr'&CHR(9)&'Nosaukums'&CHR(9)&M[1]&CHR(9)&M[2]&CHR(9)&M[3]&CHR(9)&M[4]&CHR(9)&|
          M[5]&CHR(9)&M[6]&CHR(9)&M[7]&CHR(9)&M[8]&CHR(9)&M[9]&CHR(9)&M[10]&CHR(9)&|
          M[11]&CHR(9)&M[12]&CHR(9)&'Noliet.no'&CHR(9)&'Uzkr.nol.'&CHR(9)&'Noò.pçc SV'&CHR(9)&'Atlikums'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
          'gada sâkuma'&CHR(9)&'+1994'&CHR(9)&'+1994'
          ADD(OUTFILEANSI)
        ELSE
          OUTA:LINE='Nr'&CHR(9)&'Nosaukums'&CHR(9)&M[1]&CHR(9)&M[2]&CHR(9)&M[3]&CHR(9)&M[4]&CHR(9)&|
          M[5]&CHR(9)&M[6]&CHR(9)&M[7]&CHR(9)&M[8]&CHR(9)&M[9]&CHR(9)&M[10]&CHR(9)&|
          M[11]&CHR(9)&M[12]&CHR(9)&'Noliet.no gada sâkuma'&CHR(9)&'Uzkr.nol. +1994'&CHR(9)&'Noò.pçc SV+1994'&|
          CHR(9)&'Atlikums'
          ADD(OUTFILEANSI)
        .
      .
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
!           stop(FORMAT(F:KAT_NR,@P#-##P) & PAM:KAT_NR[I#] & i#)
           IF ~CYCLEKAT(PAM:KAT[I#]) AND ~(F:OBJ_NR AND ~(PAM:OBJ_NR=F:OBJ_NR)) !KAT VAR MAINÎTIES REIZI GADÂ,OBJ NEMAINÂS
               CLEAR(NOLM)
               VERT_N=0
               VERT_N_PIRMS=0
               VERT_NON=0
               VERT_U=0
               VERT_B=0
               CLEAR(NOLM)
               JADRUKA=FALSE
               CLEAR(AMO:RECORD)
               CLEAR(NODALA)
!               AMO:yyyymm=DATE(1,1,GADS)
               AMO:yyyymm=S_DAT
               AMO:U_NR=PAM:U_NR
               SET(AMO:NR_KEY,AMO:NR_KEY)
               LOOP
                  NEXT(PAMAM)
                  IF ERROR() OR ~(PAM:U_NR=AMO:U_NR AND AMO:YYYYMM <= B_DAT) !YYYYMM DD=1 ?
                     BREAK
                  .
                  IF ~CYCLENODALA(AMO:NODALA)  !NODAÏA VAR MAINÎTIES KATRU MÇNESI
                     JADRUKA=TRUE
                     M#=MONTH(AMO:YYYYMM)+FGK#  !FING KOREKCIJA
                     IF M#>12 THEN M#-=12.
                     VERT_N      += AMO:NOL_LIN             !VERT_N 3 ZÎMES AIZ KOMATA KÂ FAILÂ
                     IF AMO:NOL_LIN                         !MISTISKÂ KÂRTÂ 1 SANT VAR PALIKT GAISÂ
                        NOLM[M#]     = VERT_N-VERT_N_PIRMS     !NOLM[M#] 2 ZÎMES AIZ KOMATA
                        VERT_N_PIRMS+= NOLM[M#]                !VERT_N_PIRMS 2 ZÎMES AIZ KOMATA
                     .
!                     NOLM[M#]  =AMO:NOL_LIN    !NOLM 2 ZÎMES AIZ KOMATA
                     NODALA[M#]   = AMO:NODALA
                     IF INRANGE(PAM:END_DATE,DATE(MONTH(AMO:YYYYMM),1,YEAR(AMO:YYYYMM)),|
                                             DATE(MONTH(AMO:YYYYMM)+1,1,YEAR(AMO:YYYYMM))-1)
                        VERT_NON=AMO:IZSLEGTS+PAM:NOL_V !+UZKRÂTAIS LÎDZ 1995.G.(IZMAIÒAS PÇD.MÇNESÎ IEKÐ AMO:IZSLEGTS)
                        VERT_U=0
                     ELSE
                        VERT_NON=0
                        VERT_U  = AMO:NOL_U_LI+AMO:NOL_LIN+PAM:NOL_V !+NOLIETOJUMS 12.MÇN.+UZKRÂTAIS LÎDZ 1995.G.
                     .
                     IF INRANGE(PAM:EXPL_DATUMS,DATE(MEN_NR,1,GADS),DATE(MEN_NR+1,1,GADS)-1) !IEGÂDÂTS PÇD.M.,NAV SÂK.V.
                        VERT_B  = PAM:BIL_V+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_U-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
                     ELSE
                        VERT_B  = AMO:SAK_V_LI+PAM:NOL_V+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-VERT_U-VERT_NON !+UZKR.LÎDZ 1995.G.+IZMAIÒAS PÇD.MÇNESÎ
                        ! vert_u????
                     .
                  .
               .
               VERT_N=ROUND(VERT_N,.01)
!               IF VERT_N-VERT_N_PIRMS         !!!Ðitâ ir laba kontrole, taèu nav vajadzîga, jo rçíina pareizi.
!                  DELTA+=VERT_N-VERT_N_PIRMS
!                  STOP(PAM:U_NR&PAM:NOS_P&VERT_N-VERT_N_PIRMS&' KOPÂ '&DELTA)
!               .
               DO CALCTOTALS !TOTÂÏUS SKAITAM, KAD AIZPILDÎTI VISI MÇNEÐI
               IF JADRUKA=TRUE
                  IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                  ELSE
                    OUTA:LINE=LEFT(FORMAT(PAM:U_NR,@N_6))&CHR(9)&PAM:NOS_P&CHR(9)&LEFT(FORMAT(NOLM[1],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[2],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLM[3],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[4],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLM[5],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLM[7],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[8],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLM[9],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLM[11],@N_9.2B))&CHR(9)&|
                    LEFT(FORMAT(NOLM[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(VERT_N,@N_10.2B))&CHR(9)&|
                    LEFT(FORMAT(VERT_U,@N_11.2B))&CHR(9)&LEFT(FORMAT(VERT_NON,@N_10.2B))&CHR(9)&|
                    LEFT(FORMAT(VERT_B,@N_12.2B))
                    ADD(OUTFILEANSI)
                  END
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
    IF F:DBF='W'
        PRINT(RPT:LINE)
        PRINT(RPT:REPFOOTKOPA)
    ELSE   !WORD,EXCEL
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&LEFT(FORMAT(NOLMK[1],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[2],@N_9.2B))&CHR(9)&|
        LEFT(FORMAT(NOLMK[3],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[4],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[5],@N_9.2B))&|
        CHR(9)&LEFT(FORMAT(NOLMK[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[7],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[8],@N_9.2B))&|
        CHR(9)&LEFT(FORMAT(NOLMK[9],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(NOLMK[11],@N_9.2B))&|
        CHR(9)&LEFT(FORMAT(NOLMK[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(VERT_Nk,@N_10.2B))&CHR(9)&LEFT(FORMAT(VERT_Uk,@N_11.2B))&|
        CHR(9)&LEFT(FORMAT(VERT_NONk,@N_10.2B))&CHR(9)&LEFT(FORMAT(VERT_Bk,@N_12.2B))
        ADD(OUTFILEANSI)
    END
    TS='t.s.'
    IF RECORDS(B_TABLE)>1
       IF F:DBF='W'
          PRINT(RPT:LINE1)
       .
       LOOP I#= 1 TO RECORDS(B_TABLE)
          GET(B_TABLE,I#)
          BS=B:BKK
          NOText = GETKON_K(B:BKK,0,2)
          IF F:DBF='W'
            PRINT(RPT:REPFOOTBKK)
          ELSE !WORD,EXCEL
            OUTA:LINE=TS&CHR(9)&BS&CHR(9)&LEFT(FORMAT(B:NOLMK[1],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[2],@N_9.2B))&|
            CHR(9)&LEFT(FORMAT(B:NOLMK[3],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[4],@N_9.2B))&CHR(9)&|
            LEFT(FORMAT(B:NOLMK[5],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[7],@N_9.2B))&|
            CHR(9)&LEFT(FORMAT(B:NOLMK[8],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[9],@N_9.2B))&CHR(9)&|
            LEFT(FORMAT(B:NOLMK[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:NOLMK[11],@N_9.2B))&CHR(9)&|
            LEFT(FORMAT(B:NOLMK[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(B:VERT_Nk,@N_10.2B))&CHR(9)&|
            LEFT(FORMAT(B:VERT_Uk,@N_11.2B))&CHR(9)&LEFT(FORMAT(B:VERT_NONk,@N_10.2B))&CHR(9)&|
            LEFT(FORMAT(B:VERT_Bk,@N_12.2B))
            ADD(OUTFILEANSI)
          END
          TS=''
          FOUND_BN#=0
          LOOP B#=1 TO RECORDS(BN_TABLE)
             GET(BN_TABLE,B#)
             IF BN:BKK_NOD[1:5]=B:BKK THEN FOUND_BN#+=1.
          .
          IF FOUND_BN# > 1
             TS='t.s.'
             LOOP B#= 1 TO RECORDS(BN_TABLE)
                GET(BN_TABLE,B#)
                IF BN:BKK_NOD[1:5]=B:BKK
                   BN_NODALA=BN:BKK_NOD[6:7]
                   IF BN_NODALA
                      NOText = GetNodalas(BN_NODALA,1)
                   ELSE
                      NOText = 'Bez nodaïas'
                   .
                   N_VERT_NK=0
                   LOOP N#= 1 TO 12
                      N_VERT_NK+=BN:NOLMK[N#]
                   .
                   IF N_VERT_NK
                      IF F:DBF='W'
                         PRINT(RPT:REPFOOTBN)
                      ELSE !WORD,EXCEL
                         OUTA:LINE=TS&CHR(9)&BN_NODALA&' '&NOText&CHR(9)&LEFT(FORMAT(BN:NOLMK[1],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[2],@N_9.2B))&CHR(9)&LEFT(FORMAT(BN:NOLMK[3],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[4],@N_9.2B))&CHR(9)&LEFT(FORMAT(BN:NOLMK[5],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(BN:NOLMK[7],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[8],@N_9.2B))&CHR(9)&LEFT(FORMAT(BN:NOLMK[9],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(BN:NOLMK[11],@N_9.2B))&CHR(9)&|
                         LEFT(FORMAT(BN:NOLMK[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(N_VERT_Nk,@N_10.2B))&CHR(9)&|
                         LEFT(FORMAT(N_VERT_Uk,@N_11.2B))&CHR(9)&LEFT(FORMAT(N_VERT_NONk,@N_10.2B))&CHR(9)&|
                         LEFT(FORMAT(N_VERT_Bk,@N_12.2B))
                         ADD(OUTFILEANSI)
                     .
                     TS=''
                   .
                .
             .
          .
       .
    .

    IF RECORDS(N_TABLE)>1
       TS='t.s.'
       IF F:DBF='W'
          PRINT(RPT:LINE1)
       .
       LOOP I#= 1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          IF N:NODALA
            NOText = GetNodalas(N:NODALA,1)
          ELSE
            NOText = 'Bez nodaïas'
          END
          N_VERT_NK=0
          LOOP N#= 1 TO 12
             N_VERT_NK+=N:NOLMK[N#]
          .
          IF N_VERT_NK
             IF F:DBF='W'
               PRINT(RPT:REPFOOTNOD)
             ELSE
               OUTA:LINE=TS&CHR(9)&N:NODALA&' '&NOText&CHR(9)&LEFT(FORMAT(N:NOLMK[1],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[2],@N_9.2B))&CHR(9)&LEFT(FORMAT(N:NOLMK[3],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[4],@N_9.2B))&CHR(9)&LEFT(FORMAT(N:NOLMK[5],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(N:NOLMK[7],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[8],@N_9.2B))&CHR(9)&LEFT(FORMAT(N:NOLMK[9],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(N:NOLMK[11],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(N:NOLMK[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(N_VERT_Nk,@N_10.2B))&CHR(9)&|
               LEFT(FORMAT(N_VERT_Uk,@N_11.2B))&CHR(9)&LEFT(FORMAT(N_VERT_NONk,@N_10.2B))&CHR(9)&|
               LEFT(FORMAT(N_VERT_Bk,@N_12.2B))
               ADD(OUTFILEANSI)
            .
            TS=''
          .
       .
    .

    IF RECORDS(O_TABLE)>1
       TS='t.s.'
       IF F:DBF='W'
          PRINT(RPT:LINE1)
       .
       LOOP I#= 1 TO RECORDS(O_TABLE)
          GET(O_TABLE,I#)
          IF O:OBJ_NR
            NOText = GetPROJEKTI(O:OBJ_NR,1)
          ELSE
            NoText = 'Bez Obj.(Pr.)'
          END
          N_VERT_NK=0
          LOOP N#= 1 TO 12
             N_VERT_NK+=O:NOLMK[N#]
          .
          IF N_VERT_NK
             IF F:DBF='W'
               PRINT(RPT:REPFOOTOBJ)
             ELSE
               OUTA:LINE=TS&CHR(9)&LEFT(FORMAT(O:OBJ_NR,@N_7))&' '&NOText&CHR(9)&LEFT(FORMAT(O:NOLMK[1],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[2],@N_9.2B))&CHR(9)&LEFT(FORMAT(O:NOLMK[3],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[4],@N_9.2B))&CHR(9)&LEFT(FORMAT(O:NOLMK[5],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[6],@N_9.2B))&CHR(9)&LEFT(FORMAT(O:NOLMK[7],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[8],@N_9.2B))&CHR(9)&LEFT(FORMAT(O:NOLMK[9],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[10],@N_9.2B))&CHR(9)&LEFT(FORMAT(O:NOLMK[11],@N_9.2B))&CHR(9)&|
               LEFT(FORMAT(O:NOLMK[12],@N_9.2B))&CHR(9)&LEFT(FORMAT(N_VERT_Nk,@N_10.2B))&CHR(9)&|
               LEFT(FORMAT(N_VERT_Uk,@N_11.2B))&CHR(9)&LEFT(FORMAT(N_VERT_NONk,@N_10.2B))&CHR(9)&|
               LEFT(FORMAT(N_VERT_Bk,@N_12.2B))
               ADD(OUTFILEANSI)
            .
            TS=''
          .
       .
    .

    IF F:DBF='W'
        PRINT(RPT:REPFOOT)
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF<>'W' THEN F:DBF='W'.
  FREE(B_TABLE)
  FREE(BN_TABLE)
  FREE(N_TABLE)
  FREE(O_TABLE)
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

!-----------------------------------------------------------------------------
CalcTotals       ROUTINE
  LOOP M#= 1 TO 12
    NOLMK[M#]+=NOLM[M#]
  .
  VERT_NK  += VERT_N
  VERT_UK  += VERT_U
  VERT_NONK+= VERT_NON
  VERT_BK  += VERT_B

  B:BKK=PAM:BKK
  GET(B_TABLE,B:BKK)
  IF ERROR()
     LOOP M#= 1 TO 12
       B:NOLMK[M#]=NOLM[M#]
     .
     B:VERT_NK  =VERT_N
     B:VERT_UK  =VERT_U
     B:VERT_NONK=VERT_NON
     B:VERT_BK  =VERT_B
     ADD(B_TABLE)
     SORT(B_TABLE,B:BKK)
  ELSE
     LOOP M#= 1 TO 12
       B:NOLMK[M#]+=NOLM[M#]
     .
     B:VERT_NK  +=VERT_N
     B:VERT_UK  +=VERT_U
     B:VERT_NONK+=VERT_NON
     B:VERT_BK  +=VERT_B
     PUT(B_TABLE)
  .

  LOOP M# = 1 TO 12
     GET(BN_TABLE,0)
     CLEAR(BN:NOLMK)
     BN:BKK_NOD=PAM:BKK&NODALA[M#]
     GET(BN_TABLE,BN:BKK_NOD)
     IF ERROR()
        BN:NOLMK[M#]=NOLM[M#]
        ADD(BN_TABLE)
        SORT(BN_TABLE,BN:BKK_NOD)
      ELSE
        BN:NOLMK[M#]+=NOLM[M#]
        PUT(BN_TABLE)
      .
  .

  LOOP M# = 1 TO 12
     GET(N_TABLE,0)
     CLEAR(N:NOLMK)
     N:NODALA=NODALA[M#]
     GET(N_TABLE,N:NODALA)
     IF ERROR()
        N:NOLMK[M#]=NOLM[M#]
        ADD(N_TABLE)
        SORT(N_TABLE,N:NODALA)
      ELSE
        N:NOLMK[M#]+=NOLM[M#]
        PUT(N_TABLE)
      .
  .

  LOOP M# = 1 TO 12
     GET(O_TABLE,0)
     CLEAR(O:NOLMK)
     O:OBJ_NR=PAM:OBJ_NR
     GET(O_TABLE,O:OBJ_NR)
     IF ERROR()
        O:NOLMK[M#]=NOLM[M#]
        ADD(O_TABLE)
        SORT(O_TABLE,O:OBJ_NR)
      ELSE
        O:NOLMK[M#]+=NOLM[M#]
        PUT(O_TABLE)
      .
  .
