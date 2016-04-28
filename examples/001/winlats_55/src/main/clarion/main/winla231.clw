                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_DAK231             PROCEDURE                    ! Declare Procedure
CG                   STRING(10)
CP                   STRING(3)
DEB                  DECIMAL(13,2)
DEBP                 DECIMAL(13,2)
PARADS               DECIMAL(13,2)
KOEF                 real
KKOEF                real
KDEBP                DECIMAL(13,2)
KPARADS              DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
NPK                  DECIMAL(4)
NOS_P                STRING(45)
FILTRS_TEXT          STRING(30)
PART                 STRING(25)

P_Table              QUEUE,PRE(P)
NR                     ULONG
NOS_A                  STRING(7) !par:grupa
DEBP                   decimal(12,2)
DEB                    decimal(12,2)
KRE                    decimal(12,2)
                     end

VAL_NR               BYTE
MULTIVALUTAS         BYTE
ATLMAS               DECIMAL(10,2),DIM(20,4)
BKK                  STRING(3)
VALUTA               BYTE
VALUTAP              BYTE
!NR                  DECIMAL(4)
LINEH                STRING(190)
VIRSRAKSTS           STRING(60)

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
report REPORT,AT(396,1438,8000,9698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(396,146,8000,1292),USE(?unnamed:3)
         STRING('Apgrozîjums'),AT(3583,833,938,208),USE(?String54),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâds'),AT(4573,938,938,208),USE(?String54:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Apmaksas'),AT(5563,833,938,208),USE(?String54:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(948,1042),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('periodâ'),AT(3583,1042,938,208),USE(?String33),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('koeficients'),AT(5563,1042,938,208),USE(?String54:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1250,6458,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(3542,781,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4531,781,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5521,781,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(469,781,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(896,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,781,0,521),USE(?Line63),COLOR(COLOR:Black)
         STRING(@s60),AT(708,417,4792,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(5979,552,521,208),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(52,781,6458,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(83,833,365,208),USE(?String7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(771,833,2552,208),USE(part),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(6510,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@n_6.2),AT(5625,10,625,156),USE(KOEF),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(4583,10,885,156),USE(PARADS),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n_4),AT(104,10,313,156),USE(NPK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(521,10,2969,156),USE(NOS_P),FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(3594,10,885,156),USE(DEBP),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5521,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
       END
PER_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,115),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,302)
         LINE,AT(52,52,6458,0),USE(?Line32),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(208,104,417,156),USE(?String20),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(3594,104,885,156),USE(KDEBP),RIGHT,FONT(,9,,)
         STRING(@n-_13.2),AT(4583,104,885,156),USE(KPARADS),RIGHT,FONT(,9,,)
         STRING(@n_6.2),AT(5625,104,625,156),USE(KKOEF),RIGHT,FONT(,9,,)
         LINE,AT(6510,-10,0,333),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,333),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,333),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,333),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,333),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line26),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,250),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,63),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(52,52,6458,0),USE(?Line46:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(52,73,521,156),USE(?String41),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(604,73,677,156),USE(ACC_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING('RS:'),AT(1302,73,156,156),USE(?String64),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1510,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(5531,73,521,156),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(6073,73,469,156),USE(lai),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(396,11104,8000,10),USE(?unnamed:2)
         LINE,AT(52,0,6458,0),USE(?Line48:2),COLOR(COLOR:Black)
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
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CLEAR(ATLMAS)
  LocalResponse = RequestCancelled

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END

  BIND(GGK:RECORD)
  FilesOpened = True

  VIRSRAKSTS='Debitoru apmaksas koeficients '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
!  IF PAR_GRUPA THEN FILTRS='Grupa = '&PAR_grupa.
  FILTRS_TEXT=GETFILTRS_TEXT('00110000') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN,8-(1:parâdi)
!                             12345678
  IF F:DTK=2
    PART='Summâs pa grupâm'
  ELSE
    PART='Partnera Nr un nosaukums'
  END

  RecordsToProcess = records(ggk)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  IF ~F:DTK
    ProgressWindow{Prop:Text} = 'Debitoru apmaksas koeficients'
  ELSIF F:DTK=2
    ProgressWindow{Prop:Text} = 'Debitoru apmaksas koeficients, sasp. pa grupâm'
  END
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS = DATE(1,1,GADS)
      CG = 'K1000'
      CP = 'K10'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      IF PAR_NR=999999999
         GGK:BKK='231'
         SET(GGK:BKK_DAT,GGK:BKK_DAT)
      ELSE
         GGK:PAR_NR=PAR_NR
         SET(GGK:PAR_KEY,GGK:PAR_KEY)
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('DAK231.TXT')
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
          OUTA:LINE='Npk'&CHR(9)&PART&CHR(9)&'Apgrozîjums'&CHR(9)&'Parâds'&CHR(9)&'Koeficients'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&filtrs_TEXT&CHR(9)&CHR(9)&CHR(9)
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF (PAR_NR=999999999 AND (~CYCLEGGK(CG) AND ~CYCLEPAR_K(CP) AND GGK:DATUMS<=B_DAT)) OR|
           (~(PAR_NR=999999999) AND GGK:BKK[1:3]='231')
           ACT#=1
           IF ~F:DTK
               GET(P_TABLE,0)
               LOOP J# = 1 TO RECORDS(P_TABLE)
                 GET(P_TABLE,J#)
                 IF P:NR=GGK:PAR_NR
                   ACT#=2
                   BREAK
                 .
               .
           ELSIF F:DTK=2   !PA PAR:GRUPÂM
               G#=GETPAR_K(GGK:PAR_NR,2,1)
               GET(P_TABLE,0)
               P:NOS_A=PAR:GRUPA
               GET(P_TABLE,P:NOS_A)
               LOOP J# = 1 TO RECORDS(P_TABLE)
                 GET(P_TABLE,J#)
                 IF P:NOS_A=PAR:GRUPA
                   ACT#=2
                   BREAK
                 .
               .
           END
           IF ACT#=1
             P:DEB = 0
             P:KRE = 0
             P:DEBP=0
             IF ~F:DTK
                 P:NR=GGK:PAR_NR
                 C#=GETPAR_K(GGK:PAR_NR,2,1)
                 P:NOS_A=PAR:NOS_A
             ELSIF F:DTK=2
                 G#=GETPAR_K(GGK:PAR_NR,2,1)
                 P:NOS_A=PAR:GRUPA
             END
           .
           CASE GGK:D_K
           OF 'D'
             IF GGK:DATUMS>=S_DAT AND ~(GGK:U_NR=1)
                P:DEBP += ggk:summa
             .
             P:DEB += ggk:summa
             P:KRE += 0
           OF 'K'
             P:DEB += 0
             P:KRE += ggk:summa
           .
           EXECUTE ACT#
             ADD(P_TABLE)
             PUT(P_TABLE)
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
  dat = today()
  lai = clock()
  IF ~F:DTK
    SORT(P_TABLE,P:NR)
  ELSIF F:DTK=2
    SORT(P_TABLE,P:NOS_A)
  END
  GET(P_TABLE,0)
  LOOP J# = 1 TO RECORDS(P_TABLE)
    GET(P_TABLE,J#)
    PARADS=0
    IF ~F:DTK
        NOS_P=GETPAR_K(P:NR,2,2)
        NOS_P=P:NR&'  '&NOS_P
    ELSIF F:DTK=2
        IF ~P:NOS_A
            NOS_P='Pârçjie'
        ELSE
            NOS_P=P:NOS_A
        END
    END
    IF P:DEBP OR P:KRE
      NPK+=1
      DEBP=P:DEBP
      PARADS += P:DEB-P:KRE
      IF PARADS=0
        KOEF=100
      ELSE
        KOEF=DEBP/PARADS
      END
      IF KOEF<0 THEN KOEF=0.
      IF KOEF>100 THEN KOEF=100.
      KDEBP += DEBP
      KPARADS += PARADS
      IF F:DBF = 'W'
            PRINT(RPT:detail)
      ELSE
            OUTA:LINE=CLIP(NPK)&CHR(9)&NOS_P&CHR(9)&LEFT(FORMAT(DEBP,@N-_13.2))&CHR(9)&LEFT(FORMAT(PARADS,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(KOEF,@N_6.2))
            ADD(OUTFILEANSI)
      .
    .
  .
  IF KPARADS=0
     KKOEF=100
  ELSE
     KKOEF=KDEBP/KPARADS
  END
  IF KKOEF<0 THEN KOEF=0.
  IF KKOEF>100 THEN KKOEF=100.
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)
  ELSE
    OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&LEFT(FORMAT(KDEBP,@N-_13.2))&CHR(9)&LEFT(FORMAT(KPARADS,@N-_13.2))&CHR(9)&|
               LEFT(FORMAT(KKOEF,@N_6.2))
    ADD(OUTFILEANSI)
  END
  PRINT(RPT:RPT_FOOT1)
  ENDPAGE(report)
  FREE(VALTABLE)
  FREE(P_TABLE)
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    CLOSE(ProgressWindow)
    F:DTK=''
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

!-----------------------------------------------------------------------------------------------------------------------
ProcedureReturn ROUTINE
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
  POPBIND
  RETURN

!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE() OR (~(GGK:BKK[1:3]='231') AND PAR_NR=999999999) OR (~(PAR_NR=GGK:PAR_NR) AND ~(PAR_NR=999999999))
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) &'%'
      DISPLAY()
    END
  END
SPZ_DProjIzv         PROCEDURE                    ! Declare Procedure
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
NPK                  USHORT
VIRSRAKSTS           STRING(100)
DAUDK                DECIMAL(10,3)
SUMMA_V              DECIMAL(13,2)
SUMMA_VK             DECIMAL(13,2)
CENA                 DECIMAL(12,2)
CENAX                DECIMAL(12,2)
NOMENK               STRING(21)
KATALOGA_NR          STRING(17)
NOSAUKUMS            STRING(30)
DAT                  LONG
LAI                  LONG
TESTAKURSS           DECIMAL(17,10)
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
report REPORT,AT(198,1438,12000,6198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,1240),USE(?unnamed:2)
         STRING(@s45),AT(2448,104,4844,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(990,417,7760,260),USE(VIRSRAKSTS),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9688,573,,156),PAGENO,USE(?PageNo),RIGHT
         STRING('Nomenklatûra'),AT(521,885,1406,208),USE(?String2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1927,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Kataloga Nr'),AT(1979,885,1146,208),USE(?String2:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3177,885,1979,208),USE(?String2:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5208,885,729,208),USE(?String2:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa valûtâ'),AT(5990,833,885,156),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena par'),AT(6917,750,885,156),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzc. %'),AT(7865,885,521,208),USE(?String2:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kalkulçtâ'),AT(8438,833,885,156),USE(?String2:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârdoðanas'),AT(9375,833,885,156),USE(?String2:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vienîbu, Ls'),AT(6917,896,885,156),USE(?String2:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('cena +%5C+18%'),AT(8427,1000,885,156),USE(?String2:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(testa kurss)'),AT(6927,1042,885,156),USE(?String2:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('cena'),AT(9458,990,469,156),USE(?String2:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n1),AT(9990,990,156,156),USE(NOKL_CP),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(6156,1000,573,156),USE(?String39),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1198,10104,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(9323,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(10260,729,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(8385,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,885,260,208),USE(?String2:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6875,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5938,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5156,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3125,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(469,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(156,729,10104,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(156,-10,0,198),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,198),USE(?Line14:45),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,198),USE(?Line14:4),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,198),USE(?Line14:5),COLOR(COLOR:Black)
         STRING(@s35),AT(3177,10,1979,156),USE(NOSAUKUMS),LEFT(1)
         LINE,AT(5156,-10,0,198),USE(?Line14:46),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,198),USE(?Line14:47),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,198),USE(?Line14:48),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6927,10,,156),USE(CENA),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line14:49),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,198),USE(?Line14:2),COLOR(COLOR:Black)
         LINE,AT(9323,-10,0,198),USE(?Line14:3),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(9375,10,,156),USE(NOM:REALIZ[1]),RIGHT
         LINE,AT(10260,-10,0,198),USE(?Line14:6),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(8438,10,,156),USE(CENAX),RIGHT
         STRING(@s17),AT(1979,10,,156),USE(KATALOGA_NR),LEFT(1)
         STRING(@s21),AT(521,10,,156),USE(NOMENK),LEFT(1)
         STRING(@N-_7.2),AT(7865,10,,156),USE(NOM:PROC5),RIGHT
         STRING(@N-_13.2),AT(5990,10,,156),USE(SUMMA_V),RIGHT
         STRING(@N-_10.3),AT(5260,10,,156),USE(NOL:DAUDZUMS),RIGHT
         STRING(@N4),AT(208,10,260,156),USE(NPK),RIGHT
       END
detail1 DETAIL,USE(?unnamed)
         LINE,AT(156,-10,0,271),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,63),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,63),USE(?Line26:25),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,271),USE(?Line26:2),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,271),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,271),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,271),USE(?Line25:5),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,271),USE(?Line25:6),COLOR(COLOR:Black)
         LINE,AT(9323,-10,0,271),USE(?Line25:7),COLOR(COLOR:Black)
         LINE,AT(10260,-10,0,271),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(156,52,10104,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(417,104,365,156),USE(?String28),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_10.3),AT(5260,104,,156),USE(DAUDk),RIGHT
         STRING(@N-_13.2),AT(5990,104,,156),USE(SUMMA_Vk),RIGHT
         LINE,AT(156,260,10104,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line26:34),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7500,12000,177),USE(?unnamed:3)
         LINE,AT(156,0,10104,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@D06.),AT(9115,21,,156),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(9760,21,,156),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
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
  IF ~PAV:D_K='1'
    STOP('Jâbût D-Projekts!')
    DO ProcedureReturn
  END
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  DAT=TODAY()
  LAI=clock()
  GETMYBANK('')
  IF ~((PAV:VAL='Ls') OR (PAV:VAL='LVL'))
     TESTAKURSS=BANKURS(PAV:VAL,0,'',1)
     VIRSRAKSTS='D-projekts '&CLIP(PAV:DOK_SENR)&' '&GETPAR_K(PAV:PAR_NR,2,2)&' Testa kurss: '&|
     FORMAT(TESTAKURSS,@N-_17.10)&' Ls/'&PAV:VAL
  ELSE
     VIRSRAKSTS='D-projekts '&CLIP(PAV:DOK_SENR)&' '&GETPAR_K(PAV:PAR_NR,2,2)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'D-projekta izvçrsums'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
!!      PAV:SUMMA=PAV:SUMMA*SIGN#
      CLEAR(nol:RECORD)                              !MAKE SURE RECORD CLEARED
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)                     !SET TO FIRST SELECTED RECORD
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,1)
        KATALOGA_NR=GETNOM_K(NOL:NOMENKLAT,2,14)
        NOSAUKUMS = GETNOM_K(NOL:NOMENKLAT,2,2)
        SUMMA_V=calcsum(3,2) !summa val bez PVN -A
        IF NOL:DAUDZUMS=0
          CENA = calcsum(3,2)*TESTAKURSS   !summa Ls bez PVN -A
        ELSE
          CENA = calcsum(3,2)*TESTAKURSS/NOL:DAUDZUMS
        .
        CENAX=CENA*(1+nom:proc5/100)*(1+nom:pvn_proc/100)  !cena+18% +uzcenojums
        DAUDK += NOL:DAUDZUMS
        SUMMA_VK+=SUMMA_V
        NPK+=1
        PRINT(RPT:DETAIL)
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
    PRINT(RPT:DETAIL1)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!***************************************************************************
OMIT('D2')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    IF ~(nol:NR = PAV:NPK) THEN BREAK.           !BREAK ON END OF SELECTION
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
D2
!***************************************************************************
!***************************************************************************
!***************************************************************************
K_Kartdru            PROCEDURE                    ! Declare Procedure
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


PAV_NR               STRING(6)
DD0                  DECIMAL(10,3)
DS0                  DECIMAL(12,3)
KD0                  DECIMAL(10,3)
KS0                  DECIMAL(12,3)
ATL0                 DECIMAL(10,3)

DD                   DECIMAL(10,3)
DS                   DECIMAL(12,3)
KD                   DECIMAL(10,3)
KS                   DECIMAL(12,3)
ATL                  DECIMAL(10,3)

DDK                  DECIMAL(11,3)
DSK                  DECIMAL(13,3)
KDK                  DECIMAL(11,3)
KSK                  DECIMAL(13,3)
ATLK                 DECIMAL(11,3)

DD_S                 STRING(6)
DS_S                 STRING(8)
KD_S                 STRING(6)
KS_S                 STRING(8)
AT_S                 STRING(8)

DAT                  DATE
LAI                  TIME
NOL_TEX              STRING(60)
TEKSTS1              STRING(45)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOL_FIFO)
                       PROJECT(FIFO:DATUMS)
                       PROJECT(FIFO:U_NR)
                       PROJECT(FIFO:NOL_NR)
                       PROJECT(FIFO:DAUDZUMS)
                       PROJECT(FIFO:SUMMA)
                     END

report REPORT,AT(144,2223,8000,9198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(144,150,8000,2073)
         STRING(@s45),AT(1250,104,4635,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktavas :'),AT(573,708,938,208),USE(?String2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(2031,729,5833,208),USE(Nol_Tex),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu un materiâlu daudzuma un summas uzskaites kartîte uz'),AT(1042,469,4271,260),USE(?String2:2), |
             LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(5365,469,917,260),USE(b_dat),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums:'),AT(573,990,1042,260),USE(?String2:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s40),AT(2031,990,4375,260),USE(NOM:NOS_P),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1563,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3125,1563,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4896,1563,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6771,1563,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7813,1563,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Ienâcis'),AT(3135,1615,1719,208),USE(?String12:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjis'),AT(4948,1615,1823,208),USE(?String12:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(6823,1615,990,208),USE(?String12:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums  Cena (bez PVN)'),AT(3135,1823,1719,208),USE(?String12:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums  Cena (bez PVN)'),AT(4948,1823,1823,208),USE(?String12:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(6823,1823,990,208),USE(?String12:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2031,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,1563,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nomenklatûra:'),AT(573,1250,1406,260),USE(?String2:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s21),AT(2031,1250,1823,260),USE(nom:nomenklat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Raþotâja kods:'),AT(3906,1250,990,260),USE(?String2:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s17),AT(4917,1250,1823,260),USE(nom:kataloga_nr),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6979,1406,,156),PAGENO,USE(?PageCount),RIGHT 
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s45),AT(208,0,2708,156),USE(TEKSTS1),LEFT 
         LINE,AT(3125,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_10.3B),AT(3229,10,677,156),USE(DD),RIGHT 
         STRING(@N-_13.3B),AT(4010,10,833,156),USE(DS),RIGHT 
         LINE,AT(4896,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N-_10.3B),AT(5000,10,677,156),USE(KD),RIGHT 
         STRING(@N-_13.3B),AT(5781,10,833,156),USE(KS),RIGHT 
         LINE,AT(6771,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N-_10.3B),AT(6927,10,833,156),USE(Atl),RIGHT 
         LINE,AT(7813,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,625)
         STRING('RS :'),AT(1667,365,313,208),USE(?String45:2)
         STRING(@s1),AT(1979,365,208,208),USE(RS),CENTER
         STRING(@d6),AT(6146,365,729,208),USE(dat)
         STRING(@T4),AT(7031,365,625,208),USE(lai)
         LINE,AT(104,-10,0,270),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,62),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,270),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('KOPÂ / Vidçji  no gada sâkuma :'),AT(156,104,2031,156),USE(?String12:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.3),AT(3073,94,833,156),USE(DDK),RIGHT 
         STRING(@N-_13.3),AT(4052,94,781,156),USE(DSK),RIGHT 
         STRING(@N-_11.3),AT(4948,104,781,156),USE(KDK),RIGHT 
         STRING(@N-_13.3),AT(5781,94,833,156),USE(KSK),RIGHT 
         STRING(@N-_11.3),AT(6927,104,833,156),USE(Atlk),RIGHT 
         LINE,AT(104,260,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Operators :'),AT(208,365,729,208),USE(?String45)
         STRING(@s8),AT(938,365,677,208),USE(ACC_kods),LEFT
       END
       FOOTER,AT(144,11400,8000,63)
         LINE,AT(104,0,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING('Gaidiet.....'),AT(48,20,38,10),FONT(,10,08000H,FONT:bold,CHARSET:BALTIC),USE(?String3),TRN
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
!
! JÂBÛT POZICIONÇTAM NOl_KOPS
!

  b_dat=today()

  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  DAT=TODAY()
  lai=CLOCK()
  NOL_TEX=FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1

! STOP(1)

  FilesOpened = True
  RecordsToProcess =50
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu uzskaites kartiòa no kopsavilkumiem'
  ?Progress:UserString{Prop:Text}=''

  SEND(NOL_FIFO,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      I#=getnom_k(kops:nomenklat,0,1)
      CLEAR(FIFO:RECORD)
      FIFO:U_NR=KOPS:U_NR
      SET(FIFO:NR_KEY,FIFO:NR_KEY)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      LOOP
! STOP(2)
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
          IF ~OPENANSI('KARTDRU.TXT')
              POST(Event:CloseWindow)
              CYCLE
          END
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Preèu un materiâlu daudzuma un summas uzskaites kartîte uz '&format(B_DAT,@D6)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Noliktavas '&nol_tex
          ADD(OUTFILEANSI)
          OUTA:LINE='Nosaukums '&NOM:NOS_P
          ADD(OUTFILEANSI)
          OUTA:LINE='Nomenklatûra '&NOM:NOMENKLAT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='-{100}'
          ADD(OUTFILEANSI)
          OUTA:LINE='Datums Dok.Nr.'&CHR(9)&CHR(9)&'Partnera'&CHR(9)&CHR(9)&CHR(9)&'Ienâcis'&CHR(9)&CHR(9)&'Izgâjis'&CHR(9)&CHR(9)&'Atlikums'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'T Nr Nosaukums'
          ADD(OUTFILEANSI)
          OUTA:LINE='-{100}'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~INRANGE(FIFO:NOL_NR,1,NOL_SK) THEN FIFO:NOL_NR=1.
        IF NOL_NR25[FIFO:NOL_NR]    !JA MÛS INTERESÇ ÐÎ NOLIKTAVA
          IF INSTRING(FIFO:D_K,'A D DIDR',2)
             CASE FIFO:D_K
             OF 'A'                   !SÂKUMA ATLIKUMS
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Atlikums uz '&format(fifo:datums,@d6)
             OF 'D'                   !IENÂCIS
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Ienâcis (D) '&format(fifo:datums,@d6)
             OF 'DI'                  !IEKÐ. pÂRVIETOÐ
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Iekðçjâ pârvietoðana (DI) '& Menvar(fifo:datums,2,1)
             OF 'DR'                  !NO RAÞOÐANAS
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Ienâcis no raþoðanas (DR) '&format(fifo:datums,@d6)
             .
             DD=FIFO:DAUDZUMS
             DS=ROUND(FIFO:SUMMA/FIFO:DAUDZUMS,.001)
             KD=0
             KS=0
             ATL+=DD
             DDK+=FIFO:DAUDZUMS
             DSK+=FIFO:SUMMA
          ELSIF INSTRING(FIFO:D_K,'K KIKR',2)
             CASE FIFO:D_K
             OF 'K'                   !Realizâcija
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Realizâcija (K) '&Menvar(fifo:datums,2,1)
             OF 'KI'                 !IENÂCIS
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Iekðçjâ pârvietoðana (KI)'&Menvar(fifo:datums,2,1)
             OF 'KR'                !IEKÐ. pÂRVIETOÐ
                TEKSTS1='Noliktava: '&clip(fifo:nol_nr)&' Norakstîts raþoðanâ '& Menvar(fifo:datums,2,1)
             .
             DD=0
             DS=0
             KD=FIFO:DAUDZUMS
             KS=ROUND(FIFO:SUMMA/FIFO:DAUDZUMS,.001)
             ATL-=KD
             KDK+=FIFO:DAUDZUMS
             KSK+=FIFO:SUMMA
          ELSE
             STOP('FIFO:D_K:'&FIFO:D_K)
          .
          IF F:DBF='W'
              PRINT(RPT:DETAIL)
          ELSE
              DD_S=DD0
              DS_S=DS0
              KD_S=KD0
              KS_S=KS0
              AT_S=ATL
              OUTA:LINE='Atlikums uz'&CHR(9)&format(NOL:DATUMS,@d06.)&CHR(9)&DD_S&CHR(9)&DS_S&CHR(9)&KD_S&CHR(9)&KS_S&CHR(9)&AT_S
              ADD(OUTFILEANSI)
          .
        .
! STOP(5)
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
  IF SEND(NOL_FIFO,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    DSK=ROUND(DSK/DDK,.001)
    KSK=ROUND(KSK/KDK,.001)
    ATLK=ATL
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    ELSE
        OUTA:LINE='-{100}'
        ADD(OUTFILEANSI)
        DD_S=DD
        DS_S=DS
        KD_S=KD
        KS_S=KS
        AT_S=ATL
        OUTA:LINE='KOPÂ/Vidçji:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&DD_S&CHR(9)&DS_S&CHR(9)&KD_S&CHR(9)&KS_S&CHR(9)&AT_S
        ADD(OUTFILEANSI)
        OUTA:LINE='-{100}'
        ADD(OUTFILEANSI)
    .
 !STOP(6)
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

  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
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
  IF ERRORCODE() OR ~(KOPS:U_NR=FIFO:U_NR)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_FIFO')
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
