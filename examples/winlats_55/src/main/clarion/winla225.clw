                     MEMBER('winlats.clw')        ! This is a MEMBER module
K_PrIeKusN           PROCEDURE                    ! Declare Procedure
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
PROCESS:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:NOS_S)
                     END
!---------------------------------------------------------------------------
I_TABLE              QUEUE,PRE(I)
NOL_NR                 STRING(4)
DAUDZUMS               DECIMAL(13,3)
SUMMA                  DECIMAL(13,2)
                     .
NOLTEXT              STRING(45)
IEN_DAUDZUMS         DECIMAL(13,3)
IEN_SUMMA            DECIMAL(14,2)
VID                  DECIMAL(11,4)

!---------------------------------------------------------------------------
kops_gads            SHORT
PA                   SHORT
NR                   DECIMAL(4)
NOSAUKUMS            STRING(29)
BKK                  STRING(5)
REALIZETS            DECIMAL(13,3)
DAUDZUMS             DECIMAL(13,3)
SUMMA_K              DECIMAL(13,2)
KOPA                 STRING(8)
BKKK                 STRING(5)
BILVERT              DECIMAL(14,2)
BILVERT_K            DECIMAL(14,2)
DAT                  DATE
LAI                  TIME
!---------------------------------------------------------------------------
report REPORT,AT(104,1333,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,104,8000,1229),USE(?unnamed)
         STRING(@s45),AT(1510,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu iekðçjâ kustîba starp noliktavâm (VS)  '),AT(729,417,3594,260),USE(?String4),RIGHT(1), |
             FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4333,427),USE(menesisunG),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,729,6667,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(938,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3490,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5260,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(573,781,365,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5313,990,938,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa Ls'),AT(6250,990,938,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1198,6667,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(521,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6604,531,677,156),PAGENO,USE(?PA),RIGHT
       END
detail DETAIL,AT(,,,135)
         LINE,AT(521,-10,0,155),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(573,0,313,130),USE(NR),RIGHT
         STRING(@s45),AT(990,0,2396,208),USE(NOLTEXT)
         LINE,AT(938,-10,0,155),USE(?Line7:2),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,155),USE(?Line7:6),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,155),USE(?Line7:3),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,155),USE(?Line7:5),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(5365,0,,130),USE(I:DAUDZUMS),RIGHT
         STRING(@N-_13.2),AT(6250,0,,130),USE(I:SUMMA),RIGHT
         LINE,AT(7188,-10,0,155),USE(?Line7:4),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(521,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,115),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,510),USE(?unnamed:2)
         LINE,AT(521,-10,0,323),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Summa :'),AT(625,104,625,208),USE(?String28),LEFT
         LINE,AT(3490,-10,0,323),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,323),USE(?Line25:5),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,323),USE(?Line25:6),COLOR(COLOR:Black)
         LINE,AT(521,313,6667,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(510,333,573,146),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(979,333,573,146),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1760,333,208,146),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1990,333,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6073,333,615,146),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6698,333),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(7188,-10,0,323),USE(?Line25:7),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,11000,8000,63)
         LINE,AT(521,0,6667,0),USE(?Line1:6),COLOR(COLOR:Black)
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
  checkopen(global,1)
  kops_gads=GADS
  CHECKOPEN(NOL_FIFO,1)
  CHECKOPEN(NOL_KOPS,1)
  NOL_KOPS::USED+=1
  FilesOpened=TRUE
  BIND(KOPS:RECORD)
  BIND('KOPS_GADS',KOPS_GADS)
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% apstrâdâti'
  ProgressWindow{Prop:Text} = 'Preèu kustîba starp noliktavâm'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
!      Process:View{Prop:Filter} ='KOPS:GADS=KOPS_GADS'
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
         VID=0
         DAUDZUMS=0
         CHECKKOPS('POZICIONÇTS',0,1)    !UZBÛVÇJAM TABULAS
         LOOP J#= 1 TO NOL_SK
            DAUDZUMS=CALCKOPS(MONTH(B_DAT),J#,8)
            IF DAUDZUMS          !NO ÐÎS NOLIKTAVAS IR BIJUSI IEKÐÇJÂ PÂRVIETOÐANA ðajâ mçnesî
               VID=CALCKOPS(MONTH(B_DAT),0,5) !VIDÇJÂ VÇRTÎBA UZ MÇNEÐA BEIGÂM
               NOLIKNAME='NOLIK'&FORMAT(J#,@N02)
               CHECKOPEN(NOLIK,1)
               CLEAR(NOL:RECORD)
               NOL:NOMENKLAT=KOPS:NOMENKLAT
               NOL:DATUMS=DATE(MONTH(B_DAT),1,GADS)
               SET(NOL:NOM_KEY,NOL:NOM_KEY)
               LOOP
                  NEXT(NOLIK)
                  IF ERROR() OR ~(NOL:NOMENKLAT=KOPS:NOMENKLAT) OR ~(MONTH(NOL:DATUMS)=MONTH(B_DAT)) THEN BREAK.
                  IF INRANGE(NOL:PAR_NR,1,NOL_SK) AND NOL:D_K='K'  !IZGÂJIS UZ INTERNÂLU
                     I:NOL_NR[1:2]=FORMAT(J#,@N02)
                     I:NOL_NR[3:4]=FORMAT(NOL:PAR_NR,@N02)
                     GET(I_TABLE,I:NOL_NR)
                     IF ERROR()
                        I:DAUDZUMS=NOL:DAUDZUMS
                        I:SUMMA=NOL:DAUDZUMS*VID
                        ADD(I_TABLE)
                        SORT(I_TABLE,I:NOL_NR)
                     ELSE
                        I:DAUDZUMS+=NOL:DAUDZUMS
                        I:SUMMA+=NOL:DAUDZUMS*VID
                        PUT(I_TABLE)
                     .
                  .
               .
               CLOSE(NOLIK)
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
  LOOP I#= 1 TO RECORDS(I_TABLE)
     GET(I_TABLE,I#)
     NR=I#
     NOLTEXT='No Noliktavas Nr: '&I:NOL_NR[1:2]&' uz Noliktavu Nr: '&I:NOL_NR[3:4]
!     DAUDZUMS_NOL=I:DAUDZUMS
!     BILVERT_NOL=I:SUMMA
     PRINT(RPT:DETAIL)
  .
  DAT=TODAY()
  LAI=CLOCK()
  PRINT(RPT:RPT_FOOT3)
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       report{Prop:Preview} = PrintPreviewImage
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END








  OMIT('MARIS')
!-----------------------------------------------------------------------------
            LOOP K#=1 TO MONTH(b_dat)
               REALIZETS+=KOPS:K_DAUDZUMS[K#,J#]
               IF KOPS:KI_DAUDZUMS[K#,J#]  !IEKÐÇJÂ PÂRVIETOÐANA
                  FOUND#=TRUE
               .
            .
         .
         IF FOUND#   !VISPÂR IR BIJUSI IEKÐÇJÂ KUSTÎBA ÐAI NOMENKLATÛRAI
!---------------------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI------------------
           CLEAR(FIFO:RECORD)
           FIFO:NOMENKLAT=KOPS:NOMENKLAT
           FIFO:GADS=KOPS:GADS
           SET(FIFO:NOM_KEY,FIFO:NOM_KEY)
           LOOP
              NEXT(NOL_FIFO)
              IF ERROR() OR ~(FIFO:NOMENKLAT=KOPS:NOMENKLAT AND FIFO:GADS=KOPS_GADS AND FIFO:DATUMS<=b_dat) THEN BREAK.
              IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                 REALIZETS+=ABS(FIFO:DAUDZUMS)
              .
           .
!---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
           CLEAR(FIFO:RECORD)
           FIFO:NOMENKLAT=KOPS:NOMENKLAT
           FIFO:GADS=KOPS:GADS
           SET(FIFO:NOM_KEY,FIFO:NOM_KEY)
           LOOP
              NEXT(NOL_FIFO)
              IF ERROR() OR ~(FIFO:NOMENKLAT=KOPS:NOMENKLAT AND FIFO:GADS=KOPS_GADS AND FIFO:DATUMS<=B_DAT) THEN BREAK.
              IF FIFO:DAUDZUMS>0
                 IEN_DAUDZUMS+=FIFO:DAUDZUMS
                 IEN_SUMMA   +=FIFO:SUMMA
                 IF REALIZETS > FIFO:DAUDZUMS   !ðitais FIFO daudzums pilnîbâ realizçts
                    REALIZETS-=FIFO:DAUDZUMS
                 ELSIF REALIZETS                !no  ðitâ FIFO daudzuma realizçta daïa
                    BILVERT=(FIFO:SUMMA/FIFO:DAUDZUMS)*(FIFO:DAUDZUMS-REALIZETS)
                    DAUDZUMS=FIFO:DAUDZUMS-REALIZETS
                    REALIZETS=0
                 ELSE                           !atlikums,nav realizçts
                    BILVERT+=FIFO:SUMMA
                    DAUDZUMS+=FIFO:DAUDZUMS
                  .
              .
            .
               IF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                  REALERROR#=1
             ELSE
                REALERROR#=0
           .
                IF IEN_DAUDZUMS > DAUDZUMS          !JA KAUT KAS IR REALIZÇTS
              DAUDZU                                  RT=IEN_SUMMA
           .
            VID=BILVERT/DAUDZUMS
     MARIS
K_RentKraj           PROCEDURE                    ! Declare Procedure
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
NOL_TEXT             STRING(45)
NOS_P                STRING(50)
IEP_CENA             DECIMAL(12,4)
IEP_CENA_P           DECIMAL(12,4)
REAL_CENA            DECIMAL(12,4)
IEP_CENAV            DECIMAL(12,4)
REAL_CENAV           DECIMAL(12,4)
DAUDZUMS             DECIMAL(11,3)
UZC_PR               REAL
NET_PEL              DECIMAL(13,2)
DAUDZUMSK            DECIMAL(12,3)
D_DAUDZUMSK          DECIMAL(12,3)
UZC_PR_V             REAL
NET_PEL_K            DECIMAL(13,2)
D_SUMMAK             DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
sav_nomenklat        STRING(21)
STRINGARPVN          STRING(10)
STRINGARPVN1         STRING(10)
STRINGTSPVN          STRING(15)
CN                   STRING(5)
CP                   STRING(3)
APGROZ               DECIMAL(12,2)
APGROZK              DECIMAL(12,2)
V1                   DECIMAL(12,2)
S1                   DECIMAL(13,2)
V2                   DECIMAL(12,2)
S2                   DECIMAL(13,2)
V3                   DECIMAL(12,2)
S3                   DECIMAL(13,2)
V4                   DECIMAL(12,2)
S4                   DECIMAL(13,2)
V1K                  DECIMAL(12,2)
S1K                  DECIMAL(13,2)
V2K                  DECIMAL(12,2)
S2K                  DECIMAL(13,2)
V3K                  DECIMAL(12,2)
S3K                  DECIMAL(13,2)
V4K                  DECIMAL(12,2)
S4K                  DECIMAL(13,2)
STARP                DECIMAL(12,2)
STARPK               DECIMAL(12,2)
ALAA                 REAL
ALAPG                REAL
KA                   REAL
RENT                 REAL
LINEH                STRING(190)
!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------
report REPORT,AT(104,1635,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(104,146,12000,1490)
         STRING(@d6),AT(3594,365,917,260),USE(S_DAT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(4740,365,917,260),USE(b_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4583,365,104,260),USE(?String39),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10313,156,833,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s45),AT(3333,52,4479,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Analizçtas Noliktavas :'),AT(5833,365,1667,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(7552,365,3802,260),USE(NOL_TEXT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6198,1198,0,313),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(6979,938,0,573),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(8490,938,0,573),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Rentabilitâtes un krâjumu analîze'),AT(781,365,2708,260),USE(?String4),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,677,11250,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1510,677,0,833),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2240,938,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2969,938,0,573),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3646,938,0,573),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4375,938,0,573),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4792,938,0,573),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5573,677,0,833),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(11354,677,0,833),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(156,990,1354,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('RENTABILITÂTE'),AT(1542,729,4010,208),USE(?String9:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('KRÂJUMI'),AT(5604,729,5729,208),USE(?String9:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1510,938,9844,0),USE(?Line45),COLOR(COLOR:Black)
         STRING('Vid.iep.cena'),AT(1563,990,677,208),USE(?VIDiepCENA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vid.real.cena'),AT(2292,990,677,208),USE(?String9:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realiz.'),AT(3000,990,625,208),USE(?String9:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apgroz.,'),AT(3677,990,677,208),USE(?String9:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vid.'),AT(4406,990,365,208),USE(?String9:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bruto peïòa'),AT(4823,990,729,208),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. mçneða sâkumâ'),AT(5604,990,1354,208),USE(?String9:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâcis'),AT(7010,990,1458,208),USE(?String9:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjis iep.cenâs'),AT(8542,990,1406,208),USE(?String9:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. mçneða beigâs'),AT(9979,990,1354,208),USE(?String9:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9948,938,0,573),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s21),AT(156,1250,1354,208),USE(nomenklat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(1563,1250,677,208),USE(StringARPVN),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2292,1250,677,208),USE(StringARPVN1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzc.%'),AT(4406,1250,365,208),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4823,1250,729,208),USE(StringTSPVN),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vien.'),AT(5604,1250,573,208),USE(?String9:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6229,1250,729,208),USE(?String9:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vien.'),AT(7010,1250,625,208),USE(?String9:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7656,1198,0,313),USE(?Line50:2),COLOR(COLOR:Black)
         LINE,AT(9115,1198,0,313),USE(?Line50:3),COLOR(COLOR:Black)
         STRING('Summa'),AT(7688,1250,781,208),USE(?String9:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vien.'),AT(8521,1250,573,208),USE(?String9:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(9146,1250,781,208),USE(?String9:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vien.'),AT(9979,1250,573,208),USE(?String9:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10573,1198,0,313),USE(?Line50:4),COLOR(COLOR:Black)
         STRING('Summa'),AT(10604,1250,729,208),USE(?String9:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudz.,vien.'),AT(3000,1250,625,208),USE(?String40),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(3677,1250,677,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1458,11250,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5573,1198,5781,0),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(104,677,0,833),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(2240,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(1542,10,677,156),USE(iep_cena),RIGHT
         LINE,AT(3646,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(3677,10,677,156),USE(apgroz),RIGHT(1)
         STRING(@n-_12.4),AT(2271,10,677,156),USE(real_cena),RIGHT
         LINE,AT(4375,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(3000,10,625,156),USE(daudzums),RIGHT
         LINE,AT(4792,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(4406,10,365,156),USE(uzc_pr),RIGHT
         LINE,AT(5573,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5604,10,573,156),USE(V1),RIGHT
         LINE,AT(6198,-10,0,198),USE(?Line11:18),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(4823,10,729,156),USE(net_pel),RIGHT
         LINE,AT(11354,-10,0,198),USE(?Line11:9),COLOR(COLOR:Black)
         LINE,AT(10573,-10,0,198),USE(?Line11:20),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,198),USE(?Line11:22),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(8521,10,573,156),USE(V3),RIGHT
         LINE,AT(9115,-10,0,198),USE(?Line11:23),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(9146,10,781,156),USE(S3),RIGHT
         LINE,AT(9948,-10,0,198),USE(?Line11:17),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(9979,10,573,156),USE(V4),RIGHT
         STRING(@n-_13.2),AT(10604,10,729,156),USE(S4),RIGHT
         STRING(@n-_12.2),AT(7010,10,625,156),USE(V2),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line11:16),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7688,10,781,156),USE(S2),RIGHT
         STRING(@n-_13.2),AT(6229,10,729,156),USE(S1),RIGHT
         LINE,AT(6979,-10,0,198),USE(?Line11:19),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@s21),AT(156,10,1354,156),USE(KOPS:nomenklat)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(1510,0,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(2969,0,0,115),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(3646,0,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(5573,0,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,115),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(6979,0,0,115),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,115),USE(?Line28:4),COLOR(COLOR:Black)
         LINE,AT(8490,0,0,115),USE(?Line28:5),COLOR(COLOR:Black)
         LINE,AT(9115,0,0,115),USE(?Line28:6),COLOR(COLOR:Black)
         LINE,AT(9948,0,0,115),USE(?Line28:7),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,115),USE(?Line28:8),COLOR(COLOR:Black)
         LINE,AT(11354,0,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(104,52,11250,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(4792,-10,0,198),USE(?Line11:14),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(4823,10,729,156),USE(net_pel_k),RIGHT
         LINE,AT(5573,-10,0,198),USE(?Line11:25),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5604,10,573,156),USE(V1K),RIGHT
         LINE,AT(6198,-10,0,198),USE(?Line11:21),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6229,10,729,156),USE(S1K),RIGHT
         LINE,AT(6979,-10,0,198),USE(?Line11:30),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7010,10,625,156),USE(V2K),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line11:31),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7688,10,781,156),USE(S2K),RIGHT
         LINE,AT(8490,-10,0,198),USE(?Line11:32),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(8521,10,573,156),USE(V3K),RIGHT
         LINE,AT(9115,-10,0,198),USE(?Line11:29),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(9146,10,781,156),USE(S3K),RIGHT
         LINE,AT(9948,-10,0,198),USE(?Line11:28),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(9979,10,573,156),USE(V4K),RIGHT
         LINE,AT(10573,-10,0,198),USE(?Line11:27),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(10604,10,729,156),USE(S4K),RIGHT
         STRING(@n-_12.4),AT(2271,10,677,156),USE(real_cenaV),RIGHT
         STRING(@n-_12.4),AT(1542,10,677,156),USE(iep_cenaV),RIGHT
         LINE,AT(11354,-10,0,198),USE(?Line11:15),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,198),USE(?Line11:13),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(4406,10,365,156),USE(uzc_pr_v),RIGHT
         LINE,AT(2240,-10,0,198),USE(?Line11:24),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(3677,10,677,156),USE(apgrozK),RIGHT(1)
         LINE,AT(3646,-10,0,198),USE(?Line11:12),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3000,10,625,156),USE(daudzumsK),RIGHT
         LINE,AT(2969,-10,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,198),USE(?Line11:26),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(156,10,469,156),USE(?String30),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,979),USE(?unnamed)
         LINE,AT(104,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,63),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(4792,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(5573,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,63),USE(?Line65:2),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,63),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(104,52,11250,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Apgrozâmo lîdzekïu aprites âtrums :'),AT(156,104),USE(?String73),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.5),AT(2813,104),USE(ALAA),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11354,-10,0,63),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line41:3),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line41:4),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,63),USE(?Line41:5),COLOR(COLOR:Black)
         LINE,AT(9115,-10,0,63),USE(?Line41:6),COLOR(COLOR:Black)
         LINE,AT(9948,-10,0,63),USE(?Line41:7),COLOR(COLOR:Black)
         LINE,AT(10573,-10,0,63),USE(?Line41:8),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(9552,406,573,208),USE(?String34),LEFT
         STRING(@s8),AT(10125,406,625,208),USE(ACC_kods),LEFT
         STRING('RS :'),AT(11010,406,260,208),USE(?String34:2),LEFT
         STRING(@s1),AT(11271,406,156,208),USE(RS),CENTER
         STRING('Krâjumu aprite :'),AT(156,521),USE(?String73:3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5),AT(3073,521),USE(KA),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dienas'),AT(3542,521),USE(?String73:4),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rentabilitâte :'),AT(156,729),USE(?String73:6),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(3542,729,354,177),USE(val_uzsk,,?val_uzsk:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5.2),AT(3073,729),USE(RENT),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2969,-10,0,63),USE(?Line65:3),COLOR(COLOR:Black)
         STRING(@D6),AT(9844,156,740,208),USE(dat)
         STRING(@T4),AT(10625,156,594,208),USE(LAI)
         STRING('Apgrozâmo lîdzekïu aprites perioda garums :'),AT(156,313),USE(?String73:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5),AT(3073,313),USE(ALAPG),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dienas'),AT(3542,313),USE(?String73:7),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3646,-10,0,63),USE(?Line64),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,7900,12000,63)
         LINE,AT(104,0,11250,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(46,41,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  STRINGARPVN='(bez PVN)'
  STRINGARPVN1='(bez PVN)'
  !STRINGTSPVN='Ls(bez PVN)'
  STRINGTSPVN=val_uzsk&'(bez PVN)'
  dat=today()
  lai=clock()
  IF NOL_KOPS::USED=0
     CHECKOPEN(nol_kops,1)
  .
  NOL_KOPS::USED+=1
  BIND(KOPS:RECORD)
  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Rentabilitâtes un krâjumu analîze'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      KOPS:NOMENKLAT=NOMENKLAT
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
      LOOP I#= 1 TO NOL_SK
        NOL_TEXT = CLIP(NOL_TEXT)&CLIP(I#)&','
      .
      NOL_TEXT[LEN(CLIP(NOL_TEXT))]=' '
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('KRenKraj.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='RENTABILITÂTES UN KRÂJUMU ANALÎZE: '&format(S_DAT,@d10.)&' - '&format(B_DAT,@d10.)!&' GRUPA: '&PAR_GRUPA
          ADD(OUTFILEANSI)
          OUTA:LINE='ANALIZÇTAS NOLIKTAVAS: '&NOL_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='NOMENKLATÛRA'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&'RENTABILITÂTE'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'KRÂJUMI'
          ADD(OUTFILEANSI)
          OUTA:LINE=NOMENKLAT&CHR(9)&CHR(9)&'Vid.iep.cena'&CHR(9)&'Vid.real.cena'&CHR(9)&'Realiz.'&CHR(9)&'Apgroz.,'&CHR(9)&'Vidçjais'&CHR(9)&'Neto peïòa'&CHR(9)&'Atl.mçneða sâkumâ'&CHR(9)&CHR(9)&'Ienâcis'&CHR(9)&CHR(9)&'Izgâjis'&CHR(9)&CHR(9)&'Atl.mçneða beigâs'
          ADD(OUTFILEANSI)
!          OUTA:LINE=CHR(9)&CHR(9)&StringArPvn&CHR(9)&StringArPvn1&CHR(9)&'daudz.,vien.'&CHR(9)&'Ls'&CHR(9)&'uzcen. %'&CHR(9)&StringTsPvn&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'
          OUTA:LINE=CHR(9)&CHR(9)&StringArPvn&CHR(9)&StringArPvn1&CHR(9)&'daudz.,vien.'&CHR(9)&val_uzsk&CHR(9)&'uzcen. %'&CHR(9)&StringTsPvn&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'&CHR(9)&'Vien.'&chr(9)&'Summa'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT) 
           NPK#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           CHECKKOPS('POZICIONÇTS',0,1)            !PÂRBAUDAM KOPSAVILKUMUS & UZBÛVÇJAM KOPS::
           DAUDZUMS  = CALCKOPS(MEN_NR,0,4)        !IZGÂJIS DAUDZUMS VISÂ SISTÇMÂ M E
           IEP_CENA  = CALCKOPS(MEN_NR,0,5)        !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN BEI E,R
           IF ~IEP_CENA THEN IEP_CENA=GETNOM_K(KOPS:NOMENKLAT,0,7,6).
           REAL_CENA = CALCKOPS(MEN_NR,0,6)        !VID REALIZ CENA VISÂ SISTÇMÂ MÇN BEI E
           Apgroz    = CALCKOPS(MEN_NR,0,2)        !REALIZÂCIJAS SUMMA VISÂ SISTÇMÂ M E
!           V1        = CALCKOPS(MEN_NR-1,0,12)     !A DAUDZUMS VISÂ SISTÇMA MÇNEÐA SÂKUMÂ E,R
           V1        = CALCKOPS(MEN_NR,0,17)       !A DAUDZUMS VISÂ SISTÇMA MÇNEÐA SÂKUMÂ E,R
!           IEP_CENA_P= CALCKOPS(MEN_NR-1,0,5)      !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN SÂKUMÂ E,R
           IEP_CENA_P= CALCKOPS(MEN_NR,0,18)       !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN SÂKUMÂ E,R
           IF ~IEP_CENA_P THEN IEP_CENA_P=GETNOM_K(KOPS:NOMENKLAT,0,7,6). !PÇDÇJÂ IEP.CENA
           S1        = IEP_CENA_P*V1               !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN SÂKUMÂ E,R * DAUDZUMS MÇNEÐA SÂKUMÂ
           V2        = CALCKOPS(MEN_NR,0,13)       !IENÂCIS DAUDZUMS VISÂ SISTÇMÂ M E,R
           S2        = CALCKOPS(MEN_NR,0,14)       !IENÂCIS SUMMA VISÂ SISTÇMÂ M E,R
           V3        = CALCKOPS(MEN_NR,0,4)+CALCKOPS(MEN_NR,0,15) !IZGÂJIS DAUDZUMS VISÂ SISTÇMÂ M E+R
!           S3        = CALCKOPS(MEN_NR,0,2)+CALCKOPS(MEN_NR,0,16) !IZGÂJIS SUMMA VISÂ SISTÇMÂ M E+R
           S3        = IEP_CENA*V3                 !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN BEIGÂS E,R * DAUDZUMS IZGÂJIS M
           V4        = CALCKOPS(MEN_NR,0,12)       !A DAUDZUMS VISÂ SISTÇMA MÇNEÐA BEIGÂS E,R
           S4        = IEP_CENA*V4                 !VID IEP CENA VISÂ SISTÇMÂ(+SALDO) MÇN BEI E,R * DAUDZUMS MÇNEÐA BEIGÂS

           DAUDZUMSK +=DAUDZUMS
           V1K        +=V1
           S1K        +=S1
           V2K        +=V2
           S2K        +=S2
           V3K        +=V3
           S3K        +=S3
           V4K        +=V4
           S4K        +=S4
           IF DAUDZUMS  !KAUT KAS IR PÂRDOTS
              D_SUMMAK   += CALCKOPS(MEN_NR,0,10)
              D_DAUDZUMSK+= CALCKOPS(MEN_NR,0,11)
              APGROZK    +=APGROZ
              UZC_PR = (REAL_CENA-IEP_CENA)/IEP_CENA*100
!              UZC_PR_V += UZC_PR
!              SKAITS# += 1
           ELSE
              UZC_PR = 0
           .
           NET_PEL   = (REAL_CENA-IEP_CENA)*DAUDZUMS
           NET_PEL_K+= (REAL_CENA-IEP_CENA)*DAUDZUMS
           IF DAUDZUMS OR V1 OR V2
              IF F:DBF='W'
                PRINT(RPT:DETAIL)
              ELSE
                NOS_P = GETNOM_K(KOPS:NOMENKLAT,2,2)
                OUTA:LINE=KOPS:NOMENKLAT&CHR(9)&NOS_P&CHR(9)&FORMAT(IEP_CENA,@N-_12.4)&CHR(9)&FORMAT(REAL_CENA,@N-_12.4)&CHR(9)&FORMAT(DAUDZUMS,@N-_12.3)&CHR(9)&FORMAT(APGROZ,@N-_12.2)&CHR(9)&FORMAT(UZC_PR,@N-_8.2)&CHR(9)&FORMAT(NET_PEL,@N-_13.2)&CHR(9)&FORMAT(V1,@N-_12.2)&CHR(9)&FORMAT(S1,@N-_12.2)&CHR(9)&FORMAT(V2,@N-_12.2)&CHR(9)&FORMAT(S2,@N-_12.2)&CHR(9)&FORMAT(V3,@N-_12.2)&CHR(9)&FORMAT(S3,@N-_12.2)&CHR(9)&FORMAT(V4,@N-_12.2)&CHR(9)&FORMAT(S4,@N-_12.2)
                ADD(OUTFILEANSI)
              END
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
  IEP_CENAV=D_SUMMAK/D_DAUDZUMSK
  REAL_CENAV=APGROZK/DAUDZUMSK
  UZC_PR_V =(REAL_CENAV-IEP_CENAV)/IEP_CENAV*100
!  UZC_PR_V = UZC_PR_V/SKAITS#
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT1)
    PRINT(RPT:RPT_FOOT2)
  ELSE
    OUTA:LINE=LINEH
    ADD(OUTFILEANSI)
    OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&FORMAT(IEP_CENAV,@N-_12.4)&CHR(9)&FORMAT(REAL_CENAV,@N-_12.4)&CHR(9)&FORMAT(DAUDZUMSK,@N-_12.3)&CHR(9)&FORMAT(APGROZK,@N-_12.2)&CHR(9)&FORMAT(UZC_PR_V,@N-_8.2)&CHR(9)&FORMAT(NET_PEL_K,@N-_13.2)&CHR(9)&FORMAT(V1K,@N-_12.2)&CHR(9)&FORMAT(S1K,@N-_12.2)&CHR(9)&FORMAT(V2K,@N-_12.2)&CHR(9)&FORMAT(S2K,@N-_12.2)&CHR(9)&FORMAT(V3K,@N-_12.2)&CHR(9)&FORMAT(S3K,@N-_12.2)&CHR(9)&FORMAT(V4K,@N-_12.2)&CHR(9)&FORMAT(S4K,@N-_12.2)
    ADD(OUTFILEANSI)
  END
  ALAA=APGROZK/((S1K+S4K)/2)
  ALAPG=30/ALAA
  KA=30/(IEP_CENAV*DAUDZUMSK/((S1K+S4K)/2))
  RENT=NET_PEL_K/APGROZK
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT3)
  ELSE
    OUTA:LINE=LINEH
    ADD(OUTFILEANSI)
    OUTA:LINE='Apgrozâmo lîdzekïu aprites atrums: '&FORMAT(ALAA,@N_10.5)
    ADD(OUTFILEANSI)
    OUTA:LINE='Apgrozâmo lîdzekïu aprites perioda garums: '&FORMAT(ALAPG,@N_5)&' dienas'
    ADD(OUTFILEANSI)
    OUTA:LINE='Krâjumu aprite: '&FORMAT(ka,@N_5)&' dienas'
    ADD(OUTFILEANSI)
    OUTA:LINE='Rentabilitâte: '&FORMAT(rent,@N_5.2)&' '&val_uzsk
    ADD(OUTFILEANSI)
    OUTA:LINE='Sastâdîja: '&ACC_KODS&' RS: '&RS&' '&format(dat,@d10.)&' '&format(lai,@t4)
    ADD(OUTFILEANSI)
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
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
  POPBIND
  IF ~F:DBF='W' THEN F:DBF='W'.
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
SPZ_Pavadi_OEM       PROCEDURE                    ! Declare Procedure
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

SUMMA_BS             STRING(15)
DAUDZUMS_S           STRING(15)
DAUDZUMS_S1          STRING(7)
DAUDZUMSK_S          STRING(15)
DAUDZUMSK_S1         STRING(7)
CENA_S               STRING(15)
CENA_S1              STRING(10)
LBKURSS              DECIMAL(14,6)
LSSUMMA              DECIMAL(12,2)
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
MENESIS              STRING(10)
gov_reg              STRING(40)
RPT_CLIENT           STRING(45)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
NOS_P                STRING(45)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
CONS1                STRING(15)
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
CENA                 DECIMAL(16,5)
SUMMA_B              DECIMAL(16,4)
KOPA                 STRING(15)
IEPAK_DK             DECIMAL(3)
SUMK_B               DECIMAL(13,2)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
PAV_T_PVN            DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PLKST                TIME
ADRESEF              STRING(60)
PAV_AUTO             STRING(80)
DA                   STRING(8)
RET                  BYTE
LINEH                STRING(117)
SYS_PARAKSTS         string(25)


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
!-----------------------------------------------------------------------------
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  FilesOpened = True
  RPT_gads=year(pav:datums)
  datums=day(pav:datums)
  menesis=MENVAR(pav:datums,2,2)
  plkst=clock()
  KESKA = 'pavadzîme Nr '&PAV:DOK_SENR&' '&RPT_GADS&'. gada '&datums&'. '&menesis
  PAV_AUTO=GETAUTO(PAV:VED_NR,2)
  PAR:NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
  TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
  GETMYBANK('')
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
  OF 'K'
    nom_ser='Kods'
    RET=4
  OF 'C'  
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  CASE PAV:D_K
  OF 'D'
    RPT_CLIENT=PAR:NOS_P
    ADRESE=PAR:ADRESE
    reg_nr=PAR:NMR_KODS
    RPT_BANKA=''
!   RPT:BKODS=PAR:BAN_KODS
    RPT_REK  =PAR:BAN_NR
    ATLAUJA =''
    NOS_P=CLIENT
    gov_reg=gl:vid_nr
    ADRESE1=SYS:ADRESE
!   RPT:NOLIKTAVA=''
  ELSE
    RPT_CLIENT=CLIENT
    ADRESE=SYS:ADRESE
    reg_nr=gl:vid_nr
    RPT_BANKA=BANKA
    RPT_REK  =REK
    ATLAUJA =SYS:ATLAUJA
    NOS_P=PAR:NOS_P
    gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
    ADRESE1=PAR:ADRESE
    clear(ban:record)
    IF F:PAK = '2'   !F:PAK NO SELPZ
       PAR_ban_kods=par:ban_kods2
       par_ban_nr=par:ban_nr2
    ELSE
       PAR_ban_kods=par:ban_kods
       par_ban_nr=par:ban_nr
    .
    par_banka=GETBANKAS_K(PAR_BAN_KODS,0,1)
  .
  LOOP I#=1 TO 117
!    LINEH[I#]=CHR(151)
    LINEH[I#]='-'
  .
  !LINEV=CHR(124)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Numurçtâ Pavadzîme OEM uz MATRIX'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR = PAV:U_NR'
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
!      ASCIIFILENAME='PAVI'&CLIP(ACC_KODS_N)&'.R'&FORMAT(JOB_NR,@N02)
      ASCIIFILENAME='PAV.TXT'
      CHECKOPEN(OUTFILE,1)
      close(OUTFILE)
      OPEN(OUTFILE,18)
      IF ERROR()
         kluda(1,ASCIIFILENAME)
         DO ProcedureReturn
      ELSE
         EMPTY(OUTFILE)
      .
      LOOP I#= 1 TO 6
         OUT:LINE=''
         ADD(OUTFILE)
      .
      OUT:LINE='                   '&CHR(27)&CHR(69)&KESKA&CHR(9)&CHR(27)&CHR(70)&CHR(15)  !TREKNA_D,TREKNA_O,SAURA_D
      ADD(OUTFILE)
      OUT:LINE=''
      ADD(OUTFILE)
      OUT:LINE='       01.Preèu nosutîtâjs   '&RPT_CLIENT&' {8}|'&LINEH[1:40]&'|'
      ADD(OUTFILE)
      OUT:LINE='       02. Adrese   '&ADRESE&' {5}Kods |'&REG_NR&' {13}'&SYS:AVOTS&' |'
      ADD(OUTFILE)
      OUT:LINE='       03.Norçíinu rekvizîti '&BANKA&' {16}Konts |'&REK&'                   |'
      ADD(OUTFILE)
!      OUT:LINE=LINEH[1:117]&'|'
      OUT:LINE='       -{116}|'
      ADD(OUTFILE)
      OUT:LINE='       04.Preèu saòçmçjs     '&NOS_P&' {8}| {40}|'
      ADD(OUTFILE)
      OUT:LINE='       05.Adrese             '&ADRESE1&' {8}Kods |'&GOV_REG&'|'
      ADD(OUTFILE)
      OUT:LINE='       06.Norçíinu rekvizîti '&PAR_BANKA&' {16}Konts |'&PAR_BAN_NR&'                   |'
      ADD(OUTFILE)
      OUT:LINE='       -{116}|'
!      OUT:LINE=LINEH[1:117]&'|'
      ADD(OUTFILE)
!!      DA=FORMAT(PAV:C_DATUMS,@D5)
      OUT:LINE='       07.Samaksas veids un kârtîba    '&' {24}| 08.Speciâlâs atzîmes '&PAV:PAMAT&' '&ATLAUJA
      ADD(OUTFILE)
!      LOOP I#=1 TO 3
!         TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,I#)
!      .
      OUT:LINE='          Iekðçjâ preèu kustîba '&CONS1&' {16}| {22}'&TEXTEKSTS
      ADD(OUTFILE)
      OUT:LINE='       |-{115}|'
      ADD(OUTFILE)
      OUT:LINE='       |Npk| {8}09.Preèu nosaukums {8}|'&NOM_SER&'|Iep|10.Mçrv|11.Dau.| 12.Cena  | {6}13.Summa {5}|PVN |'
      ADD(OUTFILE)
      OUT:LINE='       |-{115}|'
      ADD(OUTFILE)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,ret)
        SVARS+=GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums
        fillpvn(1)
        daudzums_s1 = nol:daudzums
        daudzums    = nol:daudzums
!        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
!        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
!        DAUDZUMS_S1=DAUDZUMS_S[7:15]
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
!        CENA_S = CUT0(CENA,5,2)
        IF ~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
        .
        CENA_S1 = CENA
        SUMMA_B = calcsum(3,4)
        SUMMA_BS = CUT0(SUMMA_B,4,2)
        IF SUMMA_BS[15]='0'
           SUMMA_BS[15]=CHR(32)
           IF SUMMA_BS[14]='0'
              SUMMA_BS[14]=CHR(32)
           END
        END
        iepak_DK  += nol:iepak_d
        DAUDZUMSK += DAUDZUMS
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        OUT:LINE='       |'&NPK& '|' &NOM:NOS_P[1:34]& '|' &NOMENK& '|' &format(NOL:IEPAK_D,@N3B)& '|' &NOM:MERVIEN& '|' &right(DAUDZUMS_S1)& '|' &right(CENA_S1)& '| ' &SUMMA_BS&' '&NOL:VAL& '|' &format(NOL:PVN_PROC,@s2)&'%|'
        ADD(OUTFILE)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
!    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
!    SUMK_BS=FORMAT(ROUND(GETPVN(3),.01),@N_12.2)
    SUMK_B=ROUND(GETPVN(3),.01)
    kopa='Kopâ:'
!    DAUDZUMSK_S1=DAUDZUMSK_S[7:15]
    daudzumsk_s1 = daudzumsk
    OUT:LINE='      |'&LINEH[1:116]&'|'
    ADD(OUTFILE)
!    OUT:LINE='      |   | '&KOPA&' {18}| {21}|'&right(format(IEPAK_DK,@s3))&'|'&' {7}|'&right(DAUDZUMSK_S1)&'| {10}|'&right(format(SUMK_BS,@s12))&'0   '&PAV:val&'|   |'
    OUT:LINE='       |   | '&KOPA&' {18}| {21}|'&format(IEPAK_DK,@N3B)&'|'&' {7}|'&right(DAUDZUMSK_S1)&'| {10}|'&FORMAT(SUMK_B,@N14.2)&'   '&PAV:val&'|   |'
    ADD(OUTFILE)
    IF GETPVN(20)  ! IR VAIRÂK PAR VIENU PREÈU TIPU
      LOOP I#=4 TO 9
        IEPAK_DK=0
        DAUDZUMSK_S=''
        SUMK_B=ROUND(GETPVN(I#),.01)
        IF SUMK_B <> 0
          EXECUTE I#-3
            kopa='t.s. prece'
            kopa='t.s. tara '
            kopa='t.s. pakalpojumi'
            kopa='t.s. kokmateriâli'
            kopa='t.s. raþojumi'
            kopa='t.s. citi'
          .
             OUT:LINE='       |   | '&KOPA&' {18}| {21}|   |'&' {7}|       | {10}|'&format(SUMK_B,@N-_14.2)&'   '&PAV:val&'|   |'
             ADD(OUTFILE)
        .
      .
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A <= 0
             OUT:LINE='       |'&LINEH[1:116]&'|'
             ADD(OUTFILE)
    ELSE
             OUT:LINE='       |'&LINEH[1:116]&'|'
             ADD(OUTFILE)
             OUT:LINE='      '
             ADD(OUTFILE)
             OUT:LINE='       Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu '&PAV:SUMMA_A&' '&PAV:VAL
             ADD(OUTFILE)
    .
!************************* SVARS ***********
    IF SVARS AND BAND(SYS:BAITS1,00010000B)
       OUT:LINE='       Preèu, taras svars '&SVARS&' kg.'
       ADD(OUTFILE)
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
       PAV_T_PVN=ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)               !23/11/05
       PAV_T_SUMMA=PAV:T_SUMMA-PAV_T_PVN                                      !10/03/03
       OUT:LINE='       Transporta pakalpojumi               {48}'&FORMAT(PAV_T_SUMMA,@N_13.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
!************************* PVN ***********
    IF GETPVN(11)+PAV_T_PVN
       SUMK_PVN = ROUND(getpvn(11)+PAV_T_PVN,.01) !18%PVN + TRANSPORTA PVN(REQEST 18%...)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis 18% {48}'&FORMAT(SUMK_PVN,@N_14.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(15)
       SUMK_PVN = ROUND(getpvn(15),.01)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  9% {48}'&FORMAT(SUMK_PVN,@N_14.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(18)                          !16/03/04
       SUMK_PVN = ROUND(getpvn(18),.01)
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  5% {48}'&FORMAT(SUMK_PVN,@N_14.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
    IF GETPVN(12) ! IR SUMMA AR 0% PVN
       SUMK_PVN = 0
       OUT:LINE='       17.Pievienotâs vçrtîbas nodoklis  0% {48}'&FORMAT(SUMK_PVN,@N_14.2)&' '&PAV:VAL
       ADD(OUTFILE)
    .
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît summas')
    .
    SUMK_B=ROUND(GETPVN(3),.01)               !JÂPÂRRÇÍINA
    SUMK_PVN = ROUND(getpvn(1),.01)+PAV_T_PVN !JÂPÂRRÇÍINA
    SUMK_APM=SUMK_B+SUMK_PVN+PAV_T_SUMMA
    SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
    OUT:LINE='       18.Pavisam         (ar cipariem) {52}'&FORMAT(SUMK_APM,@N_13.2)&' '&PAV:VAL
    ADD(OUTFILE)
    OUT:LINE='       (ar vârdiem) '&SUMv
    ADD(OUTFILE)
    IF PAV_AUTO OR PAV:PIELIK
       OUT:LINE='       a/m, vadîtâjs '&PAV_AUTO&' Pielikumâ '&PAV:PIELIK
       ADD(OUTFILE)
    END
    IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z SPECIÂLA RINDA
       LBKURSS=BANKURS(PAV:VAL,PAV:DATUMS,1)
       LSSUMMA = SUMK_APM*LBKURSS
       OUT:LINE='       Pçc Latvijas Bankas kursa '&LBKURSS&' Ls/'&PAV:VAL&' tas sastâda Ls '&LSSUMMA
       ADD(OUTFILE)
    .
!    OUT:LINE='      '
!    ADD(OUTFILE)
    OUT:LINE='       -{117}'
    ADD(OUTFILE)
!    OUT:LINE='       {70}|'
!    ADD(OUTFILE)
    OUT:LINE='       19.Izsniedza: {56}| 20.Pieòçma:'
    ADD(OUTFILE)
    OUT:LINE='       Vârds, uzvârds: '&SYS_PARAKSTS&' {28}| Vârds, uzvârds_{20}'
    ADD(OUTFILE)
    DA=FORMAT(PLKST,@T4)
    OUT:LINE='       '&RPT_GADS&'.gada "'&DATUMS&'" '&MENESIS&' '&DA&' {33}| ____.gada "__"__________'
    ADD(OUTFILE)
    OUT:LINE='       {70}|'
    ADD(OUTFILE)
!    OUT:LINE='       {70}|'
!    ADD(OUTFILE)
    OUT:LINE='       Paraksts_{20} {41}| Paraksts_{30}'
    ADD(OUTFILE)
    OUT:LINE='       {70}|'
!    ADD(OUTFILE)
!    OUT:LINE='       {70}|'
    ADD(OUTFILE)
    OUT:LINE='       {13}Z.V. {38}| {13}Z.V.'&CHR(18)&CHR(12) !SAURA_O,FF
    ADD(OUTFILE)
    CLOSE(OUTFILE)
!    RUN('WORDPAD '&ANSIFILENAME)
!    IF RUNCODE()=-4
!       KLUDA(88,'prog-a Wordpad.exe')
!    .
     VIEWASCIIFILE
  END
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
!:
!: This routine provides a common procedure exit point for all template
!: generated procedures.
!:
!: First, all of the files opened by this procedure are closed.
!:
!: Next, GlobalResponse is assigned a value to signal the calling procedure
!: what happened in this procedure.
!:
!: Next, we replace the BINDings that were in place when the procedure initialized
!: (and saved with PUSHBIND) using POPBIND.
!:
!: Finally, we return to the calling procedure.
!:
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
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
!:
!: This routine is used to provide for complex record filtering and range limiting. This
!: routine is only generated if you've included your own code in the EMBED points provided in
!: this routine.
!:
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT
!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!:
!: This routine is used to retrieve the next record from the VIEW.
!:
!: After the record has been retrieved, the PROGRESS control on the
!: Progress window is updated.
!:
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
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
