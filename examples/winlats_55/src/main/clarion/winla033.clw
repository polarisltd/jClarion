                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PUK                PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
A_SUMMA_N            DECIMAL(13,2)
A_SUMMA_S            DECIMAL(13,2)
K_SUMMA_N            DECIMAL(13,2)
K_SUMMA_S            DECIMAL(13,2)
B_SUMMA_N            DECIMAL(13,2)
B_SUMMA_S            DECIMAL(13,2)
NOS_P                STRING(35)
DAT                  DATE
LAI                  TIME
P_TABLE              QUEUE,PRE(P)
BKK                     STRING(5)
DATUMS                  LONG
DOK_SENR                STRING(14)
REFDAT                  LONG
SUMMA                   DECIMAL(12,2)
                     .
S_TABLE              QUEUE,PRE(S)
BKK                     STRING(5)
DATUMS                  LONG
DOK_SENR                  STRING(14)
SUMMA                   DECIMAL(12,2)
                     .
skaits               DECIMAL(4)
SALDO                DECIMAL(12,2)
CG                   STRING(10)
LINEH                STRING(190)
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
!-----------------------------------------------------------------------------
report REPORT,AT(198,2177,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1979),USE(?unnamed)
         LINE,AT(6302,1510,0,469),USE(?Line7:7),COLOR(COLOR:Black)
         LINE,AT(5313,1510,0,469),USE(?Line7:6),COLOR(COLOR:Black)
         LINE,AT(4635,1510,0,469),USE(?Line7:5),COLOR(COLOR:Black)
         LINE,AT(2917,1510,0,469),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(2240,1510,0,469),USE(?Line7:3),COLOR(COLOR:Black)
         LINE,AT(1250,1510,0,469),USE(?Line7:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(4688,1771,625,208),USE(?String15:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(5365,1771,865,208),USE(?String15:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1979,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(573,1510,0,469),USE(?Line7),COLOR(COLOR:Black)
         STRING('Summa'),AT(6354,1563,708,208),USE(?String21:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7042,1563,385,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(5365,1563,885,208),USE(?String15:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(2292,1771,625,208),USE(?String15:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P / Z'),AT(2969,1771,1146,208),USE(?String22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(4688,1563,625,208),USE(?String15:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('BKK'),AT(4167,1563,469,208),USE(?String14:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(938,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PIRCÇJA UZSKAITES KARTIÒA    konti :'),AT(1219,417),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4156,417),USE(KKK),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4667,417),USE(KKK1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1375,646,3615,208),USE(par:nos_p),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6771,1042),PAGENO,USE(?pa),RIGHT
         STRING(@D06.),AT(2552,823),USE(S_DAT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3396,823),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1250,7396,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(7448,1250,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nosûtîts'),AT(104,1302,4010,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksâts'),AT(4167,1302,3281,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1510,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('BKK'),AT(104,1563,469,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(625,1563,625,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(625,1771,625,208),USE(?String15:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(1302,1771,938,208),USE(?String15:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(1302,1563,938,208),USE(?String15:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçí.'),AT(2292,1563,625,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(2969,1563,1146,208),USE(?String21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,1250,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1250,0,729),USE(?Line2),COLOR(COLOR:Black)
         STRING('-'),AT(3271,823,156,208),USE(?String9),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
ATLIKUMS DETAIL,AT(,,,219)
         LINE,AT(7448,-10,0,217),USE(?Line41:3),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,217),USE(?Line41:2),COLOR(COLOR:Black)
         STRING('Atlikums : '),AT(208,10,656,156),USE(?String29),CENTER
         STRING(@n-_13.3b),AT(2979,10,1021,156),USE(A_summa_N),RIGHT
         STRING(@n-_13.3b),AT(6302,10,1021,156),USE(A_summa_S),RIGHT
         LINE,AT(52,208,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,217),USE(?Line41),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s5),AT(4167,10,427,156),USE(S:bkk),CENTER
         STRING(@d06.B),AT(4688,10,594,156),USE(S:datums)
         STRING(@S14),AT(5365,10,885,156),USE(S:dok_SEnr),RIGHT
         STRING(@n-_13.2b),AT(6365,10,1031,156),USE(S:summa),RIGHT
         LINE,AT(52,-10,0,197),USE(?Line7:8),COLOR(COLOR:Black)
         STRING(@s5),AT(104,10,427,156),USE(p:bkk),CENTER
         STRING(@d06.B),AT(625,10,594,156),USE(p:datums)
         STRING(@S14),AT(1302,10,885,156),USE(p:dok_SEnr),RIGHT
         STRING(@d06.B),AT(2292,10,594,156),USE(P:refDat)
         STRING(@n-_13.2b),AT(2969,10,1031,156),USE(P:summa),RIGHT
         LINE,AT(2240,-10,0,197),USE(?Line7:11),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line7:12),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,197),USE(?Line7:13),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,197),USE(?Line7:14),COLOR(COLOR:Black)
         LINE,AT(5313,-10,0,197),USE(?Line7:15),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,197),USE(?Line7:16),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,197),USE(?Line7:17),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,197),USE(?Line7:10),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,197),USE(?Line7:9),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,573),USE(?unnamed:2)
         LINE,AT(4115,-10,0,427),USE(?Line7:19),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,427),USE(?Line7:18),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(208,104,510,156),USE(?String41)
         STRING('Saldo :'),AT(208,260,625,156),USE(?String42)
         STRING(@n-_13.2b),AT(2969,260,1031,156),USE(b_summa_N),RIGHT
         STRING(@n-_13.2b),AT(6365,260,1031,156),USE(B_summa_S),RIGHT
         LINE,AT(52,417,7396,0),USE(?Line42:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,438),USE(?String47),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(563,438),USE(ACC_kods),FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6365,438),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6979,438),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6302,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,427),USE(?Line7:20),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(2969,104,1031,156),USE(k_summa_N),RIGHT
         STRING(@n-_13.2b),AT(6365,104,1031,156),USE(k_summa_S),RIGHT
         LINE,AT(52,52,7396,0),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(5313,-10,0,62),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,52)
         LINE,AT(52,0,7396,0),USE(?Line42:3),COLOR(COLOR:Black)
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
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
!!  STOP('KKK - '&KKK)
!!  STOP('KKK1 - '&KKK1)
  NOS_P = GETPAR_K(PAR_NR,2,2)
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
  ProgressWindow{Prop:Text} = 'PUK'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    BIND('S_DAT',S_DAT)
    BIND('B_DAT',B_DAT)
    BIND('PAR_NR',PAR_NR)
    BIND('KKK',KKK)
    BIND('KKK1',KKK1)
    BIND('cyclebkk',CYCLEBKK)
    BIND('CYCLEGGK',CYCLEGGK)
    BIND('CG',CG)
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:PAR_NR = PAR_NR
      GGK:DATUMS = DATE(1,1,GADS)
      SET(GGK:PAR_KEY,GGK:PAR_KEY)
      CG='K11'
      IF KKK=''
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK1) AND ~CYCLEGGK(CG)'
      ELSIF KKK1=''
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG)'
      ELSE
         Process:View{Prop:Filter} = '(~CYCLEBKK(GGK:BKK,KKK) OR ~CYCLEBKK(GGK:BKK,KKK1)) AND ~CYCLEGGK(CG)'
      .
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
        IF ~OPENANSI('PUK.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='PIRCÇJA UZSKAITES KARTIÒA konti: '&CLIP(KKK)&' '&CLIP(KKK1)
        ADD(OUTFILEANSI)
        OUTA:LINE='Saòçmçjs: '&CLIP(NOS_P)
        ADD(OUTFILEANSI)
        OUTA:LINE=format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NOSÛTÎTS'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'SAMAKSÂTS'
        ADD(OUTFILEANSI)
        OUTA:LINE='BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Norçíina datums'&CHR(9)&|
        'Summa pçc P/Z'&CHR(9)&'BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Summa '&val_uzsk
        !El 'Summa pçc P/Z'&CHR(9)&'BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Summa Ls'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~getgg(ggk:u_nr)
           KLUDA(6,'Iekðçjais U_NR='&GGK:U_NR)
        .
        CASE GGK:D_K
        OF 'D'
          IF GGK:DATUMS < S_DAT
            A_SUMMA_N += GGK:SUMMA
          ELSE
            P:bkk   =GGK:BKK
!            IF CHECKPZ(1)
!               P:DOK_NR=RIGHT(FORMAT(GG:DOK_NR,....
!            ELSE
!               IF GG:DOK_NR
!                  P:DOK_NR=RIGHT(GG:DOK_NR)
!               ELSE
!                  P:DOK_NR=''
!               .
!            .
            P:DOK_SENR=GG:DOK_SENR
            P:DATUMS=GGK:DATUMS
            P:REFDAT = GG:DOKDAT
            P:SUMMA  = ggk:summa
            ADD(P_TABLE)
          .
          K_SUMMA_N += GGK:SUMMA
        OF 'K'
          IF GGK:DATUMS < S_DAT
            A_SUMMA_S += GGK:SUMMA
          ELSE
            S:BKK=''
            BUILDKORMAS(1,0,0,0,0)
            LOOP I#=1 TO 20
              IF SUB(KOR_KONTS[I#],1,2)='26'
                S:BKK=KOR_KONTS[I#]
                BREAK
              .
            .
            S:DATUMS=GGK:DATUMS
!            IF CHECKPZ(1)
!               S:DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!            ELSE
!               IF GG:DOK_NR
!                  S:DOK_NR=RIGHT(GG:DOK_NR)
!               ELSE
!                  S:DOK_NR=''
!               .
!            .
            S:DOK_SENR=GG:DOK_SENR
            S:SUMMA =GGK:SUMMA
            ADD(S_TABLE)
          .
          K_SUMMA_S += GGK:SUMMA
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
  SALDO=K_SUMMA_N-K_SUMMA_S
  IF SALDO > 0
     B_SUMMA_N = SALDO
     B_SUMMA_S = 0
  ELSE
     B_SUMMA_S = ABS(SALDO)
     B_SUMMA_N = 0
  .
!  PRINT(RPT:PAGE_HEAD)
  IF F:DBF = 'W'
    PRINT(RPT:ATLIKUMS)
  ELSE
    OUTA:LINE=CHR(9)&'Atlikums :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(A_SUMMA_N,@N-_13.2))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(A_SUMMA_S,@N-_13.2))
    ADD(OUTFILEANSI)
  END
  GET(P_TABLE,0)
  GET(S_TABLE,0)
  IF RECORDS(P_TABLE)>RECORDS(S_TABLE)
     SKAITS=RECORDS(P_TABLE)
  ELSE
     SKAITS=RECORDS(S_TABLE)
  .
  LOOP J# = 1 TO SKAITS
!     STOP(J# &'NO'&SKAITS)
     IF J#>RECORDS(P_TABLE)
       P:BKK=''
       P:DOK_SENR=''
       P:DATUMS=0
       P:REFDAT = 0
       P:SUMMA  = 0
     ELSE
       GET(P_TABLE,J#)
     .
     IF J#>RECORDS(S_TABLE)
       S:BKK=''
       S:DATUMS=0
       S:DOK_SENR=''
       S:SUMMA =0
     ELSE
       GET(S_TABLE,J#)
     .
     IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=CLIP(P:BKK)&CHR(9)&FORMAT(P:DATUMS,@D06.)&CHR(9)&CLIP(P:DOK_SENR)&CHR(9)&FORMAT(P:REFDAT,@D06.)&|
            CHR(9)&LEFT(FORMAT(P:SUMMA,@N-_13.2B))&CHR(9)&CLIP(S:BKK)&CHR(9)&FORMAT(S:DATUMS,@D06.)&CHR(9)&|
            CLIP(S:DOK_SENR)&CHR(9)&LEFT(FORMAT(S:SUMMA,@N-_13.2B))
            ADD(OUTFILEANSI)
        END
     END
  .                                              !
  dat = today()
  lai = clock()
  IF F:DBF = 'W'
    PRINT(RPT:REP_FOOT)
    ENDPAGE(report)
  ELSE
    OUTA:LINE=CHR(9)&'Kopâ :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K_SUMMA_N,@N-_13.2B))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(K_SUMMA_S,@N-_13.2B))
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&'Saldo :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(B_SUMMA_N,@N-_13.2B))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(B_SUMMA_S,@N-_13.2B))
    ADD(OUTFILEANSI)
  END
  FREE(P_TABLE)
  FREE(S_TABLE)
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
  ELSE           !W,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!---------------------------------------------------------------------------------------------------------------------------------------------------------
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

!------------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~(ggk:par_nr=par_nr)
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
!------------------------------------------------------------------------
B_PIK                PROCEDURE                    ! Declare Procedure
LI                   SHORT
GARUMS               DECIMAL(2,2)
PA                   SHORT
A_SUMMA_N            DECIMAL(13,2)
A_SUMMA_S            DECIMAL(13,2)
K_SUMMA_N            DECIMAL(13,2)
K_SUMMA_S            DECIMAL(13,2)
B_SUMMA_N            DECIMAL(13,2)
B_SUMMA_S            DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
P_TABLE              QUEUE,PRE(P)
BKK                     STRING(5)
DATUMS                  LONG
DOK_SENR                STRING(14)
REFDAT                  LONG
SUMMA                   DECIMAL(12,2)
                     .
S_TABLE              QUEUE,PRE(S)
BKK                     STRING(5)
DATUMS                  LONG
DOK_SENR                STRING(14)
SUMMA                   DECIMAL(12,2)
                     .
skaits               DECIMAL(4)
SALDO                DECIMAL(12,2)
CG                   STRING(10)
LINEH                STRING(190)
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
!-----------------------------------------------------------------------------
report REPORT,AT(198,2177,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1979),USE(?unnamed)
         LINE,AT(6354,1510,0,469),USE(?Line7:7),COLOR(COLOR:Black)
         LINE,AT(5313,1510,0,469),USE(?Line7:6),COLOR(COLOR:Black)
         LINE,AT(4635,1510,0,469),USE(?Line7:5),COLOR(COLOR:Black)
         LINE,AT(2917,1510,0,469),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(2240,1510,0,469),USE(?Line7:3),COLOR(COLOR:Black)
         LINE,AT(1250,1510,0,469),USE(?Line7:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(4688,1771,625,208),USE(?String15:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(5365,1771,990,208),USE(?String15:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1979,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(573,1510,0,469),USE(?Line7),COLOR(COLOR:Black)
         STRING('Summa'),AT(6406,1563,635,208),USE(?String21:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7042,1563,396,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(5365,1563,990,208),USE(?String15:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(2292,1771,625,208),USE(?String15:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P / Z'),AT(2969,1771,1146,208),USE(?String22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(4688,1563,625,208),USE(?String15:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('BKK'),AT(4167,1563,469,208),USE(?String14:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(885,104,4635,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Iepirkumu uzskaites kartiòa,  konti :'),AT(1448,406),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4021,417),USE(KKK),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(4552,417),USE(KKK1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(94,615,7250,208),USE(par:nos_p),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6771,1042),PAGENO,USE(?pa),RIGHT
         STRING(@D06.),AT(2583,781),USE(S_DAT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3406,781),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1250,7396,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(7448,1250,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Saòemts'),AT(104,1302,4010,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksâts'),AT(4167,1302,3281,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1510,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('BKK'),AT(104,1563,469,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(625,1563,625,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(625,1771,625,208),USE(?String15:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(1302,1771,938,208),USE(?String15:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(1302,1563,938,208),USE(?String15:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçí.'),AT(2292,1563,625,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa pçc'),AT(2969,1563,1146,208),USE(?String21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,1250,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1250,0,729),USE(?Line2),COLOR(COLOR:Black)
         STRING('-'),AT(3302,771,156,208),USE(?String9),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
ATLIKUMS DETAIL,AT(,,,219)
         LINE,AT(7448,-10,0,217),USE(?Line41:3),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,217),USE(?Line41:2),COLOR(COLOR:Black)
         STRING('Atlikums : '),AT(208,10,656,156),USE(?String29),CENTER
         STRING(@n-_13.3b),AT(2938,10,1021,156),USE(A_summa_N),RIGHT
         STRING(@n-_13.3b),AT(6302,10,1021,156),USE(A_summa_S),RIGHT
         LINE,AT(52,208,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,217),USE(?Line41),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s5),AT(4167,0,427,156),USE(S:bkk),CENTER
         STRING(@d06.B),AT(4688,10,594,156),USE(S:datums)
         STRING(@s14),AT(5365,10,938,156),USE(S:dok_SEnr),RIGHT
         STRING(@n-_13.2b),AT(6406,10,938,156),USE(S:summa),RIGHT
         LINE,AT(52,-10,0,197),USE(?Line7:8),COLOR(COLOR:Black)
         STRING(@s5),AT(104,10,427,156),USE(p:bkk),CENTER
         STRING(@d06.B),AT(625,10,594,156),USE(p:datums)
         STRING(@s14),AT(1302,10,885,156),USE(p:dok_SEnr),RIGHT
         STRING(@d06.B),AT(2292,10,594,156),USE(P:refDat)
         STRING(@n-_13.2b),AT(2969,10,990,156),USE(P:summa),RIGHT
         LINE,AT(2240,-10,0,197),USE(?Line7:11),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,197),USE(?Line7:12),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,197),USE(?Line7:13),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,197),USE(?Line7:14),COLOR(COLOR:Black)
         LINE,AT(5313,-10,0,197),USE(?Line7:15),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,197),USE(?Line7:16),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,197),USE(?Line7:17),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,197),USE(?Line7:10),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,197),USE(?Line7:9),COLOR(COLOR:Black)
       END
rep_foot DETAIL,AT(,,,594),USE(?unnamed:2)
         LINE,AT(4115,-10,0,427),USE(?Line7:19),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,62),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,427),USE(?Line7:18),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(208,104,510,156),USE(?String41)
         STRING('Saldo :'),AT(208,260,625,156),USE(?String42)
         STRING(@n-_13.2b),AT(2927,260,1031,156),USE(b_summa_N),RIGHT
         STRING(@n-_13.2b),AT(6292,260,1031,156),USE(B_summa_S),RIGHT
         LINE,AT(52,417,7396,0),USE(?Line42:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(104,448),USE(?String47),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(552,448),USE(ACC_kods),FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6354,448),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6969,448),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6354,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,427),USE(?Line7:20),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(2927,104,1031,156),USE(k_summa_N),RIGHT
         STRING(@n-_13.2b),AT(6292,104,1031,156),USE(k_summa_S),RIGHT
         LINE,AT(52,52,7396,0),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(5313,-10,0,62),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,62),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,62),USE(?Line35),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,52)
         LINE,AT(52,0,7396,0),USE(?Line42:3),COLOR(COLOR:Black)
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
!!  STOP('KKK - '&KKK)
!!  STOP('KKK1 - '&KKK1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('KKK1',KKK1)
  BIND('PAR_NR',PAR_NR)
  BIND('cyclebkk',CYCLEBKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK:par_key)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PIK'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:PAR_NR = PAR_NR
      GGK:DATUMS = 0
      SET(GGK:PAR_KEY,GGK:PAR_KEY)
      CG='K11'
      IF KKK=''
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK1) AND ~CYCLEGGK(CG)'
      ELSIF KKK1=''
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG)'
      ELSE
         Process:View{Prop:Filter} = '(~CYCLEBKK(GGK:BKK,KKK) OR ~CYCLEBKK(GGK:BKK,KKK1)) AND ~CYCLEGGK(CG)'
      .
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
        IF ~OPENANSI('PIK.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Iepirkumu uzskaites kartiòa, konti: '&CHR(9)&KKK&CHR(9)&KKK1
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR:NOS_P
        ADD(OUTFILEANSI)
        OUTA:LINE=format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='SAÒEMTS'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'SAMAKSÂTS'
        ADD(OUTFILEANSI)
        IF F:DBF='E'
            OUTA:LINE='BKK'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Norçíina'&CHR(9)&'Summa'&CHR(9)&'BKK'&|
            CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Summa '&val_uzsk
            !El CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Summa Ls'
            ADD(OUTFILEANSI)
            OUTA:LINE=      CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&'Datums'&CHR(9)&'pçc P/Z'&CHR(9)&CHR(9)&'Datums'&|
            CHR(9)&'Numurs'
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE='BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Norçíina datums'&CHR(9)&|
            'Summa pçc P/Z'&CHR(9)&'BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Summa '&val_uzsk
            !El 'Summa pçc P/Z'&CHR(9)&'BKK'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Summa Ls'
            ADD(OUTFILEANSI)
        END
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        G#=getgg(ggk:u_nr)
        CASE GGK:D_K
        OF 'K'
          IF GGK:DATUMS < S_DAT
            A_SUMMA_N += GGK:SUMMA
          ELSE
            P:bkk   =GGK:BKK
            P:DOK_SENR=GG:DOK_SENR
            P:DATUMS=GGK:DATUMS
!----------------reference = dokdat???
            P:REFDAT = GG:dokdat
!----------------reference = dokdat???
            P:SUMMA  = ggk:summa
            ADD(P_TABLE)
          .
          K_SUMMA_N += GGK:SUMMA
        OF 'D'
          IF GGK:DATUMS < S_DAT
            A_SUMMA_S += GGK:SUMMA
          ELSE
            BUILDKORMAS(1,0,0,0,0)
            LOOP I#=1 TO 20
              IF SUB(KOR_KONTS[I#],1,2)='26'
                S:BKK=KOR_KONTS[I#]
                BREAK
              .
            .
            S:DATUMS=GGK:DATUMS
            S:DOK_SENR=GG:DOK_SENR
            S:SUMMA =GGK:SUMMA
            ADD(S_TABLE)
          .
          K_SUMMA_S += GGK:SUMMA
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
  SALDO=K_SUMMA_N-K_SUMMA_S
  IF SALDO > 0
    B_SUMMA_N = SALDO
    B_SUMMA_S = 0
  ELSE
    B_SUMMA_S = ABS(SALDO)
    B_SUMMA_N = 0
  .
!  PRINT(RPT:PAGE_HEAD)
  IF F:DBF = 'W'
    PRINT(RPT:ATLIKUMS)
  ELSE
    OUTA:LINE=CHR(9)&'Atlikums :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(A_SUMMA_N,@N-_13.2))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(A_SUMMA_S,@N-_13.2))
    ADD(OUTFILEANSI)
  END
  GET(P_TABLE,0)
  GET(S_TABLE,0)
  IF RECORDS(P_TABLE)>RECORDS(S_TABLE)
    SKAITS=RECORDS(P_TABLE)
  ELSE
    SKAITS=RECORDS(S_TABLE)
  .
  LOOP J# = 1 TO SKAITS
    IF J#>RECORDS(P_TABLE)
      P:BKK=''
      P:DOK_SENR=''
      P:DATUMS=0
      P:REFDAT = 0
      P:SUMMA  = 0
    ELSE
      GET(P_TABLE,J#)
    .
    IF J#>RECORDS(S_TABLE)
      S:BKK=''
      S:DATUMS=0
      S:DOK_SENR=''
      S:SUMMA =0
    ELSE
      GET(S_TABLE,J#)
    .
     IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=CLIP(P:BKK)&CHR(9)&FORMAT(P:DATUMS,@D06.)&CHR(9)&CLIP(P:DOK_SENR)&CHR(9)&FORMAT(P:REFDAT,@D06.)&|
            CHR(9)&LEFT(FORMAT(P:SUMMA,@N-_13.2B))&CHR(9)&CLIP(S:BKK)&CHR(9)&FORMAT(S:DATUMS,@D06.)&CHR(9)&|
            CLIP(S:DOK_SENR)&CHR(9)&LEFT(FORMAT(S:SUMMA,@N-_13.2B))
            ADD(OUTFILEANSI)
        END
     END
  .                                              !
  dat = today()
  lai = clock()
  IF F:DBF = 'W'
    PRINT(RPT:REP_FOOT)
    ENDPAGE(report)
  ELSE
    OUTA:LINE=CHR(9)&'Kopâ :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K_SUMMA_N,@N-_13.2B))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(K_SUMMA_S,@N-_13.2B))
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&'Saldo :'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(B_SUMMA_N,@N-_13.2B))&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
    LEFT(FORMAT(B_SUMMA_S,@N-_13.2B))
    ADD(OUTFILEANSI)
  END
  FREE(P_TABLE)
  FREE(S_TABLE)
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
  ELSE           !W,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-------------------------------------------------------------------------------------------------------------------------------------------------------
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
  IF ERRORCODE() OR ~(ggk:par_nr=par_nr)
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
!------------------------------------------------------------------------
B_Avansieri          PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
DOK_SK               DECIMAL(2)
DAT_A                DATE
DATUMS_SAN           DATE
DAT_AA               DATE
SUMMA_ATL            DECIMAL(12,2)
SUMMA_SAN            DECIMAL(12,2)
SUMMA_SANK           DECIMAL(12,2)
SUMMA_IZLK           DECIMAL(12,2)
SUMMA_ATLK           DECIMAL(12,2)
NOS_ATL              STRING(3)
NOS_SAN              STRING(3)
NOS_SANK             STRING(3)
NOS_IZLK             STRING(3)
NOS_ATLK             STRING(3)
KONTS2               STRING(5)
DK3                  STRING(1)
KONTS3               STRING(5)
NODALA3              STRING(2)
NPK                  DECIMAL(3)
UNR                  STRING(3)
SATURS               STRING(55)
SATURS2              STRING(55)
SUMMAV               DECIMAL(12,2)
SUMMA1               DECIMAL(12,2)
SUMMA2               DECIMAL(12,2)
SUMMA3               DECIMAL(12,2)
PAVISAM              DECIMAL(12,2)
RPT_SUMMA            DECIMAL(12,2)
dat                  long
CG                   STRING(10)
lai                  long
atlikums1            STRING(15)
kopa                 STRING(4)
atlikums2            STRING(15)
STRINGNODOBJ         STRING(30)
Sum_var              STRING(100)
Sum_var_a            STRING(100)
GOV_REG              STRING(45)
JUADRESE             STRING(87)

s_table              queue,pre(s)
DATUMS                  LONG
summa                   decimal(12,2)
NOS                     STRING(3)
                     .

k_table              queue,pre(k)
summa_ATL               decimal(12,2)
summa_SAN               decimal(12,2)
summa_IZLK              decimal(12,2)
NOS                     STRING(3)
                     .

F_table              queue,pre(F)
NR                      ulong
summaLS                 decimal(12,2)
summav                  decimal(12,2)
KONTS                   string(5),DIM(20)
NOD                     string(2),DIM(20)
summa                   decimal(12,2),DIM(20)
nos                     string(3)
                     .

B_table              queue,pre(B)
DK                      string(1)
KONTS_NOD               string(7)
summa                   decimal(12,2)
                     .

NOS                  STRING(3)
                     GROUP,PRE(SAV)
nr                      SHORT
                     .
VIRSRAKSTS          STRING(70)
DOKDATUMS           STRING(25)

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
report REPORT,AT(198,350,8000,10792),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
PAGE_HEAD DETAIL,AT(,,7990,1563),USE(?unnamed)
         STRING(@s45),AT(1458,21,5052,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1479,229,5052,260),USE(GOV_REG),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s87),AT(271,427,7479,260),USE(JUADRESE),TRN,CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(844,625,6333,208),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7125,1094),PAGENO,USE(?PageCount),RIGHT
         STRING('Nodaïa, amats      :'),AT(83,938),USE(?String6),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5469,1302,2240,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s25),AT(1240,948,1875,208),USE(par:kontakts),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds     :'),AT(83,1146),USE(?String6:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5469,1302,0,260),USE(?Line2),COLOR(COLOR:Black)
         STRING('Pers. kods, pase  :'),AT(104,1354,1094,208),USE(?String6:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S12),AT(1240,1365,833,156),USE(par:NMR_kods),LEFT
         STRING(@s37),AT(2073,1365,2396,156),USE(par:Pase),LEFT
         LINE,AT(7708,1302,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6250,1302,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Summa'),AT(6927,1323),USE(?String14:3)
         STRING('Datums'),AT(5677,1323),USE(?String14:2)
         LINE,AT(5469,1510,2240,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s35),AT(1240,1156,2656,208),USE(par:nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
detail_A DETAIL,AT(,,,146)
         STRING(@S15),AT(4469,0),USE(ATLIKUMS1),LEFT(1)
         LINE,AT(5469,0,0,156),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,156),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,156),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@d06.B),AT(5521,0,625,156),USE(dat_A)
         STRING(@n-15.2b),AT(6406,0,885,156),USE(summa_Atl),RIGHT
         STRING(@s3),AT(7396,0,260,156),USE(nos_Atl),RIGHT
       END
LINE   DETAIL,AT(,,,156)
         LINE,AT(5469,-10,0,176),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(5469,52,2240,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,176),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,176),USE(?Line2:8),COLOR(COLOR:Black)
       END
detail_S DETAIL,AT(,,,156)
         LINE,AT(6250,-10,0,176),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,176),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('2. Saòemts'),AT(4479,0,573,156),USE(?SANEMTS)
         STRING(@d06.),AT(5521,0,625,156),USE(datums_San)
         STRING(@n-15.2b),AT(6406,0,885,156),USE(summa_San),RIGHT
         STRING(@s3),AT(7396,0,260,156),USE(nos_San),RIGHT
         LINE,AT(5469,-10,0,176),USE(?Line2:10),COLOR(COLOR:Black)
       END
detail_K DETAIL,AT(,,,156)
         LINE,AT(5469,-10,0,176),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,176),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,176),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@s4),AT(4740,0,260,156),USE(Kopa)
         STRING(@n-15.2b),AT(6406,0,885,156),USE(summa_Sank),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7396,0,260,156),USE(nos_Sank),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail_I DETAIL,AT(,,,156)
         LINE,AT(5469,-10,0,176),USE(?Line27:2),COLOR(COLOR:Black)
         STRING(@n-15.2b),AT(6406,0,885,156),USE(summa_Izlk),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7396,0,260,156),USE(nos_Izlk),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6250,-10,0,176),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,176),USE(?Line27:3),COLOR(COLOR:Black)
         STRING('3. Izlietots'),AT(4479,0,521,156),USE(?IZLIETOTS)
       END
detail_AA DETAIL,AT(,,,156)
         LINE,AT(5469,-10,0,176),USE(?Line27:4),COLOR(COLOR:Black)
         STRING(@d06.B),AT(5521,0,625,156),USE(dat_AA)
         LINE,AT(6250,-10,0,176),USE(?Line27:5),COLOR(COLOR:Black)
         STRING(@n-15.2b),AT(6406,0,885,156),USE(summa_Atlk),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7396,0,260,156),USE(nos_Atlk),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,-10,0,176),USE(?Line27:6),COLOR(COLOR:Black)
         STRING(@s15),AT(4479,0,990,156),USE(Atlikums2),LEFT(1)
       END
det_FOOTER DETAIL,AT(,,,458),USE(?unnamed:7)
         LINE,AT(5469,-10,0,62),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,62),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,62),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(5469,52,2240,0),USE(?Line40),COLOR(COLOR:Black)
         STRING('Pielikumâ'),AT(573,104),USE(?String33)
         STRING(@n2),AT(1146,104),USE(dok_sk),RIGHT
         STRING('dokumenti'),AT(1458,104,677,208),USE(?String35)
         STRING(@s30),AT(5771,156),USE(StringNODOBJ),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD2 DETAIL,AT(,,,354),USE(?unnamed:5)
         LINE,AT(52,0,7656,0),USE(?Line41),COLOR(COLOR:Black)
         STRING('NPK'),AT(73,104),USE(?String36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,0,0,360),USE(?Line42:9),COLOR(COLOR:Black)
         STRING('Debets Summa'),AT(6563,104,906,208),USE(?String36:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7448,104,260,208),USE(val_uzsk,,?val_uzsk:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6542,0,0,360),USE(?Line42:8),COLOR(COLOR:Black)
         STRING('Summa  Valûtâ'),AT(5438,104,1031,208),USE(?String36:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,0,0,360),USE(?Line42:7),COLOR(COLOR:Black)
         LINE,AT(4531,0,0,360),USE(?Line42:6),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,360),USE(?Line42:5),COLOR(COLOR:Black)
         LINE,AT(1615,0,0,360),USE(?Line42:4),COLOR(COLOR:Black)
         LINE,AT(677,0,0,360),USE(?Line42:3),COLOR(COLOR:Black)
         LINE,AT(302,0,0,360),USE(?Line42:2),COLOR(COLOR:Black)
         STRING('Summa'),AT(4552,115,552,208),USE(?String36:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5073,115,344,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kam un par ko samaksâts'),AT(2229,104,2292,208),USE(?String36:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1656,104,521,208),USE(?String36:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta Nr.'),AT(719,104,885,208),USE(?String36:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(354,104,313,208),USE(UNR),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,0,0,360),USE(?Line42),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(4531,-10,0,197),USE(?Line42:15),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,197),USE(?Line42:14),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,197),USE(?Line42:13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,197),USE(?Line42:12),COLOR(COLOR:Black)
         LINE,AT(302,-10,0,197),USE(?Line42:11),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line42:10),COLOR(COLOR:Black)
         STRING(@n_3b),AT(73,10,208,156),USE(npk),RIGHT
         STRING(@n_6b),AT(323,10,340,156),USE(F:NR),RIGHT
         STRING(@s14),AT(708,10,885,156),USE(GG:DOK_SENR),RIGHT
         STRING(@d05.b),AT(1667,10,490,156),USE(gg:dokdat),CENTER
         STRING(@s55),AT(2219,10,2292,156),USE(saturs),LEFT
         STRING(@n-14.2b),AT(4583,10,781,156),USE(RPT_summa),RIGHT
         STRING(@n14.2b),AT(5438,10,833,156),USE(summaV),RIGHT
         STRING(@s5),AT(6563,10,365,156),USE(KKK1),LEFT
         STRING(@n_12.2b),AT(6917,10,573,156),USE(summa1),RIGHT
         STRING(@s2),AT(7521,0),USE(NODALA3,,?NODALA3:3),TRN,CENTER
         LINE,AT(6542,-10,0,197),USE(?Line42:17),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line42:16),COLOR(COLOR:Black)
         STRING(@s3),AT(6292,10,208,156),USE(nos),LEFT
         LINE,AT(7708,-10,0,197),USE(?Line42:18),COLOR(COLOR:Black)
         LINE,AT(52,0,7656,0),USE(?Line90:2),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(302,-10,0,197),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,197),USE(?Line61:3),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,197),USE(?Line61:4),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,197),USE(?Line61:5),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,197),USE(?Line61:6),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line61:7),COLOR(COLOR:Black)
         LINE,AT(6542,-10,0,197),USE(?Line61:8),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,197),USE(?Line61:9),COLOR(COLOR:Black)
         STRING(@s5),AT(6563,10,365,156),USE(konts2),LEFT
         STRING(@n_12.2b),AT(6917,10,573,156),USE(summa2),RIGHT
         STRING(@s2),AT(7521,0),USE(NODALA3,,?NODALA3:2),TRN,CENTER
         STRING(@s55),AT(2219,10,2292,156),USE(saturs2),LEFT
         LINE,AT(52,-10,0,197),USE(?Line61),COLOR(COLOR:Black)
       END
GRP_FOOT DETAIL,AT(,,,292),USE(?unnamed:3)
         LINE,AT(52,52,7656,0),USE(?Line79),COLOR(COLOR:Black)
         STRING('tai skaitâ  :'),AT(5469,104,531,156),USE(?String69)
         LINE,AT(4531,260,885,0),USE(?Line89),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,62),USE(?Line84),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,62),USE(?Line82),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,62),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,62),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,62),USE(?Line77),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,270),USE(?Line76),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(4563,104,833,156),USE(Pavisam),RIGHT
         LINE,AT(6542,-10,0,62),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(302,-10,0,62),USE(?Line81),COLOR(COLOR:Black)
         STRING('Pavisam :'),AT(3906,104,,156),USE(?String56)
         LINE,AT(4531,-10,0,270),USE(?Line75),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,2688),USE(?unnamed:8)
         STRING('Norçíina persona  :  _{28}'),AT(208,104),USE(?String58),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s35),AT(1167,281,2396,156),USE(par:nos_p,,?par:nos_p:2),CENTER
         STRING('Norçíins pârbaudîts'),AT(208,542,1302,208),USE(?String60),FONT(,9,,,CHARSET:BALTIC)
         STRING('Apstiprinâðanai :'),AT(208,781,990,208),USE(?String60:2),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(1198,781,6458,156),USE(sum_var),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(4135,1198,1625,156),USE(DOKDATUMS),TRN,LEFT
         STRING('_{31}'),AT(1844,1219,2313,208),USE(?String67),TRN,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(177,1198,1625,156),USE(SYS:amats2),RIGHT
         STRING(@s25),AT(2115,1417,1792,156),USE(SYS:PARAKSTS2),CENTER
         STRING('Norçíina summu :'),AT(208,1771,1146,208),USE(?String65),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s100),AT(1344,1781,6458,156),USE(sum_var_a),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(219,2271,1625,156),USE(SYS:amats1),RIGHT
         STRING('_{31}'),AT(1844,2281,2313,208),USE(?String67:2),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(4135,2271,1625,156),USE(DOKDATUMS,,?DOKDATUMS:2),TRN,LEFT(1)
         STRING(@s25),AT(2135,2458,1792,156),USE(SYS:PARAKSTS1),CENTER
       END
RPT_FOOT1 DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@s1),AT(6177,10,188,156),USE(DK3),TRN,CENTER
         STRING(@s5),AT(6406,10,365,156),USE(konts3),LEFT
         STRING(@n_12.2b),AT(6823,10,573,156),USE(summa3),RIGHT
         STRING(@s2),AT(7448,0),USE(NODALA3),TRN,CENTER
       END
       FOOTER,AT(198,11090,8000,10),USE(?page_footer)
         LINE,AT(52,0,7656,0),USE(?Line48:3),COLOR(COLOR:Black)
       END
     END

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
  CHECKOPEN(GG,1)

  dat = today()
  lai = clock()
  DOKDATUMS=GETDOKDATUMS(B_DAT)
  IF CL_NR=1206 !Auziòa
     VIRSRAKSTS='Avansa Norçíins  Nr _______________ konts '&KKK&' '&FORMAT(S_DAT,@D06.)&'-'&|
     FORMAT(B_DAT,@D06.)
  ELSE
     VIRSRAKSTS='Avansa Norçíins  Nr '&MONTH(B_DAT)&'-'&CLIP(PAR_NR)&'  konts '&KKK&' '&FORMAT(S_DAT,@D06.)&'-'&|
     FORMAT(B_DAT,@D06.)
  .
  GOV_REG='Reì.Nr.'&GL:VID_NR
  JUADRESE='Juridiskâ adrese: '&GL:ADRESE
  IF F:NODALA THEN StringNODOBJ=F:NODALA&' Nodaïa'.
  IF F:OBJ_NR THEN StringNODOBJ=CLIP(StringNODOBJ)&' '&F:OBJ_NR&' Projekts'.
  IF ~F:DTK THEN UNR='UNR'.

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('PAR_NR',PAR_NR)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  FilesOpened = True
  free(s_table)
  free(k_table)
  free(F_TABLE)
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Avansa norçíins'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:PAR_NR=PAR_NR
      GGK:DATUMS=0
      CG='K110011'
      SET(ggk:PAR_KEY,GGK:PAR_KEY)
      Process:View{Prop:Filter} = 'GGK:BKK=KKK AND ~CYCLEGGK(CG) AND ~BAND(ggk:BAITS,00000001b)' !&~IEZAKS
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
        IF ~OPENANSI('AVANSREK.TXT')
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
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         IF GGK:DATUMS<S_DAT OR GGK:U_NR=1
            nk#+=1
            ?Progress:UserString{Prop:Text}=NK#
            DISPLAY(?Progress:UserString)
            K:NOS=GGK:VAL
            GET(K_TABLE,K:NOS)
            IF ERROR()
              CASE GGK:D_K
              OF 'D'
                K:SUMMA_ATL=GGK:SUMMAV
                K:NOS=GGK:VAL
              ELSE
                K:SUMMA_ATL=-GGK:SUMMAV
                K:NOS=GGK:VAL
              .
              ADD(K_TABLE)
              SORT(K_TABLE,K:NOS)
            ELSE
              CASE GGK:D_K
              OF 'D'
                K:SUMMA_ATL+=GGK:SUMMAV
              ELSE
                K:SUMMA_ATL-=GGK:SUMMAV
              .
              PUT(K_TABLE)
            .
         ELSE
            CASE GGK:D_K
            OF 'D'
              S:DATUMS=GGK:DATUMS
              S:SUMMA=GGK:SUMMAV
              S:NOS=GGK:VAL
              ADD(S_TABLE)                !SAÒÇMIS AVANSIERIS PA DATUMIEM PERIODÂ
              SUMMA_SAN+=GGK:SUMMA
            ELSE
              CLEAR(F:KONTS)              !IZLIETOTS PA KORKONTIEM PERIODÂ
              CLEAR(F:SUMMA)
              IF F:NOA                    !NODAÏU IZVÇRSUMS
                 BUILDKORMAS(1,0,0,1,0)
              ELSE
                 BUILDKORMAS(1,0,0,0,0)
              .
              F:NR=GGK:U_NR
              F:SUMMALS=GGK:SUMMA
              F:SUMMAV=GGK:SUMMAV
              LOOP K#=1 TO 20
                 F:KONTS[K#]=KOR_KONTS[K#]
                 IF F:KONTS[K#]='' THEN BREAK.
                 F:SUMMA[K#]=KOR_SUMMA[K#]
                 F:NOD[K#]=KOR_NODALA[K#]
                 B:KONTS_NOD=KOR_KONTS[K#]&KOR_NODALA[K#]
                 GET(B_TABLE,B:KONTS_NOD)
                 IF ERROR()
                    B:SUMMA=KOR_SUMMA[K#]
                    ADD(B_TABLE)
                    SORT(B_TABLE,B:KONTS_NOD)
                 ELSE
                    B:SUMMA+=KOR_SUMMA[K#]
                    PUT(B_TABLE)
                 .
              .
              F:NOS   =GGK:VAL
              PAVISAM +=GGK:SUMMA
              DOK_SK+=1
              ADD(F_TABLE)
              SUMMA_IZLK+=GGK:SUMMA
            .
            K:NOS=GGK:VAL                  ! PERIODÂ
            GET(K_TABLE,K:NOS)
            IF ERROR()
               CASE GGK:D_K
               OF 'D'
                  K:SUMMA_ATL=0
                  K:SUMMA_SAN=GGK:SUMMAV
                  K:SUMMA_IZLK=0
               ELSE
                  K:SUMMA_ATL=0
                  K:SUMMA_SAN=0
                  K:SUMMA_IZLK=GGK:SUMMAV
               .
               ADD(K_TABLE)
               SORT(K_TABLE,K:NOS)
            ELSE
               CASE GGK:D_K
               OF 'D'
                 K:SUMMA_SAN+=GGK:SUMMAV
               ELSE
                 K:SUMMA_IZLK+=GGK:SUMMAV
               .
               PUT(K_TABLE)
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
    END   !---CASE
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
        PRINT(RPT:PAGE_HEAD)
  ELSE
        OUTA:LINE='Nodaïa, amats: '&par:kontakts
        ADD(OUTFILEANSI)
        OUTA:LINE='Vârds, uzvârds: '&par:nos_p
        ADD(OUTFILEANSI)
        OUTA:LINE='Pers. kods, pase: '&PAR:NMR_KODS&chr(9)&par:pase
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
  END
  DAT_A=S_DAT
  ATLIKUMS1='1. Atlikums uz'
  LOOP I#=1 TO RECORDS(K_TABLE)  !ATLIKUMI
     GET(K_TABLE,I#)
     SUMMA_ATL=K:SUMMA_ATL
     nos_ATL=K:nos
     IF F:DBF = 'W'
        PRINT(RPT:detail_a)
     ELSE
        OUTA:LINE='1. Atlikums uz '&CHR(9)&format(DAT_A,@D06.)&CHR(9)&LEFT(FORMAT(SUMMA_ATL,@N-_15.2B))&CHR(9)&NOS_ATL
        ADD(OUTFILEANSI)
     END
     DAT_A=0
     ATLIKUMS1=''
  .
  PRINT(RPT:LINE)
  LOOP I#=1 TO RECORDS(S_TABLE)  !SAÒEMTS
    GET(S_TABLE,I#)
    DATUMS_SAN=S:DATUMS
    SUMMA_SAN=S:SUMMA
    nos_SAN=S:nos
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL_s)
    ELSE
        OUTA:LINE='2. Saòemts '&CHR(9)&format(DATums_SAn,@D06.)&CHR(9)&LEFT(FORMAT(SUMMA_SAN,@N-_15.2B))&CHR(9)&NOS_SAn
        ADD(OUTFILEANSI)
    END
  .
  PRINT(RPT:LINE)
  KOPA='Kopâ'
  LOOP I#=1 TO RECORDS(K_TABLE)  !KOPÂ
     GET(K_TABLE,I#)
     SUMMA_SANK=K:SUMMA_ATL+K:SUMMA_SAN
     nos_SANK=K:nos
     IF F:DBF = 'W'
        PRINT(RPT:detail_K)
     ELSE
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_SANK,@N-_15.2))&CHR(9)&NOS_SANK
        ADD(OUTFILEANSI)
     END
     KOPA=''
  .
  PRINT(RPT:LINE)
  LOOP I#=1 TO RECORDS(K_TABLE)  !IZLIETOTS
    GET(K_TABLE,I#)
    IF K:SUMMA_IZLK
      SUMMA_IZLK=K:SUMMA_IZLK
      nos_IZLK=K:nos
      IF F:DBF = 'W'
        PRINT(RPT:DETAIL_I)
      ELSE
        OUTA:LINE='3. Izlietots '&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_IZLK,@N-_15.2B))&CHR(9)&NOS_IZLK
        ADD(OUTFILEANSI)
      END
    .
  .
  PRINT(RPT:LINE)
  DAT_AA=B_DAT
  ATLIKUMS2='4. Atlikums uz'
  LOOP I#=1 TO RECORDS(K_TABLE)  !ATLIKUMS UZ
    GET(K_TABLE,I#)
    SUMMA_ATLK=K:SUMMA_ATL+K:SUMMA_SAN-K:SUMMA_IZLK
    nos_ATLK=K:nos
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL_AA)
    ELSE
        OUTA:LINE='4. Atlikums uz'&CHR(9)&format(DAT_AA,@D06.)&CHR(9)&LEFT(FORMAT(SUMMA_ATLK,@N-_15.2B))&CHR(9)&NOS_ATLK
        ADD(OUTFILEANSI)
    END
    DAT_AA=0
    ATLIKUMS2=''
  .
  IF F:DBF = 'W'
        PRINT(RPT:DET_FOOTER)
        PRINT(RPT:PAGE_HEAD2)
  ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Pielikumâ '&DOK_SK&' dokumenti'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&' NGG'&CHR(9)&'Dokumenta Nr.'&CHR(9)&'Datums'&CHR(9)&'Kam un par ko samaksâts'&CHR(9)&|
        'Summa '&val_uzsk&CHR(9)&'Summa valûtâ'&CHR(9)&CHR(9)&'Debets'&CHR(9)&'Summa '&val_uzsk
        !El 'Summa Ls'&CHR(9)&'Summa valûtâ'&CHR(9)&CHR(9)&'Debets'&CHR(9)&'Summa Ls'
        ADD(OUTFILEANSI)
  END
  LOOP I#=1 TO RECORDS(F_TABLE)
    GET(F_TABLE,I#)
!    GET(B_TABLE,0)
!    LOOP J#=1 TO 16
!      IF F:KONTS[J#]
!        B:KONTS_NOD=F:KONTS[J#]&F:NODALA
!        GET(B_TABLE,B:KONTS_NOD)
!        IF ERROR()
!          B:KONTS=F:KONTS[J#]&F:NODALA
!          B:SUMMA=F:SUMMA[J#]
!          ADD(B_TABLE)
!          SORT(B_TABLE,B:KONTS_NOD)
!        ELSE
!          B:SUMMA+=F:SUMMA[J#]
!          PUT(B_TABLE)
!        .
!      .
!    .
    RPT_SUMMA=F:SUMMALS
    SUMMAV=F:SUMMAV
    NOS=F:NOS
    KKK1=F:KONTS[1]
    NODALA3=F:NOD[1]
    SUMMA1=F:SUMMA[1]
    npk+=1
    CLEAR(GG:RECORD)
    GG:U_NR=F:NR
    GET(GG,GG:NR_KEY)
    IF ~ERROR()
!       IF cl_nr=1237  !GAG
!          TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
!       ELSE
       TEKSTS = CLIP(GG:NOKA)&'-'&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
!       .
       FORMAT_TEKSTS(60,'Arial',8,'')
       SATURS = F_TEKSTS[1]
    ELSE
       SATURS='???'
    .
    IF F:DTK THEN F:NR=0. !NERÂDÎT UNR
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE=CLIP(NPK)&CHR(9)&CLIP(F:NR)&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(GG:DOKDAT,@D06.)&CHR(9)&CLIP(SATURS)&CHR(9)&|
        LEFT(FORMAT(RPT_SUMMA,@N-_14.2B))&CHR(9)&LEFT(FORMAT(SUMMAV,@N-_14.2B))&CHR(9)&NOS&CHR(9)&CLIP(KKK1)&CHR(9)&|
        LEFT(FORMAT(SUMMA1,@N-_12.2B))
        ADD(OUTFILEANSI)
    END
!    END
    LOOP J#= 2 TO 16 !DIMENSIJAS F:KONTS-am
      KONTS2=''
      SUMMA2=0
      SATURS2=''
      IF J# <= 3 THEN SATURS2=F_TEKSTS[J#].
      IF F:KONTS[J#] OR SATURS2
        KONTS2=F:KONTS[J#]
        SUMMA2=F:SUMMA[J#]
        NODALA3=F:NOD[J#]
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL1)
!            SUM3 = SUMMA2
        ELSE
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(SATURS2)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(KONTS2)&CHR(9)&|
            LEFT(FORMAT(SUMMA2,@N-_12.2B))
            ADD(OUTFILEANSI)
        END
      .
    .
  .
  IF F:DBF = 'W'
    !El Sum_var=SUMVAR(PAVISAM,'Ls',0)
    Sum_var=SUMVAR(PAVISAM,val_uzsk,0)
    Sum_var_a=CLIP(SUM_VAR)&' apstiprinu'
    print(rpt:grp_foot)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE=CHR(9)&CHR(9)&'Pavisam:  '&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAVISAM,@N-_14.2B))&CHR(9)&'tai skaitâ:'
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  loop i#=1 to records(b_table)
    get(b_table,i#)
    DK3='D'
    KONTS3=b:KONTS_NOD[1:5]
    NODALA3=b:KONTS_NOD[6:7]
    SUMMA3=b:SUMMA
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT1)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(KONTS3)&CHR(9)&|
        LEFT(FORMAT(SUMMA3,@N-_12.2B))
        ADD(OUTFILEANSI)
    END
  .
  DK3='K'
  KONTS3=KKK
  NODALA3=''
  SUMMA3=PAVISAM
  IF F:DBF = 'W'
      PRINT(RPT:RPT_FOOT1)
      PRINT(RPT:RPT_FOOT)
  ELSE
      OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(KONTS3)&CHR(9)&|
      LEFT(FORMAT(SUMMA3,@N-_12.2B))
      ADD(OUTFILEANSI)
      OUTA:LINE=''
      ADD(OUTFILEANSI)
      OUTA:LINE='  Norçíina persona : ___________________'&par:nos_p
      ADD(OUTFILEANSI)
      OUTA:LINE= CHR(9)&DOKDATUMS
      ADD(OUTFILEANSI)
  .
  free(F_TABLE)
  free(s_table)
  free(K_table)
  free(b_table)
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    ENDPAGE(report)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
