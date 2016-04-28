                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_ParKops            PROCEDURE                    ! Declare Procedure
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

P_TABLE           QUEUE,PRE(P)
NOS_KEY              STRING(19)  !5+8+6  NOS+U_NR+DOK_DAT
PAR_NR               ULONG
DOK_SENR             STRING(14)
DATUMS               LONG
NORDAT               LONG
SUMMAV               DECIMAL(12,2)
VAL                  STRING(3)
                  .
V_TABLE           QUEUE,PRE(V)
VALUTA               STRING(3)
SUMMAV               DECIMAL(12,2)
P_C_SUMMAV           DECIMAL(12,2)
KAV120               DECIMAL(12,3)
KAV90                DECIMAL(12,3)
KAV60                DECIMAL(12,3)
KAV30                DECIMAL(12,3)
KAV1                 DECIMAL(12,3)
                  .
NPK                  DECIMAL(4)
NOS_P                STRING(40)
DAT                  LONG
LAI                  LONG
FILTRS               STRING(25)
VIRSRAKSTS           STRING(90)
FILTRS_TEXT          STRING(100)
CHECKSUMMA           DECIMAL(12,2)
SAV_PAR_NR           ULONG
ATSK_V               BYTE
ATSK_V_TEXT          STRING(30)
CG                   STRING(10)
CP                   STRING(3)
JAU_SAM_SUMMAV       DECIMAL(11,2)
P_C_SUMMAV           DECIMAL(11,2)
P_C_SUMMAVK          DECIMAL(11,2)
SUMMAVK              DECIMAL(11,2)
KAV                  SHORT

SUMMAP               DECIMAL(12,2)
P_C_SUMMAP          DECIMAL(12,2)
KAV120P              DECIMAL(12,3)
KAV90P               DECIMAL(12,3)
KAV60P               DECIMAL(12,3)
KAV30P               DECIMAL(12,3)
KAV1P                DECIMAL(12,3)

KAV120               DECIMAL(12,3)
KAV90                DECIMAL(12,3)
KAV60                DECIMAL(12,3)
KAV30                DECIMAL(12,3)
KAV1                 DECIMAL(12,3)
B_DATUMS             LONG

Atsk_V_window WINDOW,AT(,,193,57),CENTER,GRAY
       STRING('P/Z , kas izrakstîtas periodâ'),AT(5,11),USE(?String1P)
       STRING(@D06.),AT(100,11),USE(S_DAT)
       STRING('-'),AT(142,11),USE(?String5)
       STRING(@D06.),AT(150,11),USE(B_DAT)
       STRING('Apmaksu meklçt lîdz :'),AT(19,22),USE(?String1)
       ENTRY(@D06.B),AT(92,21,50,10),USE(B_DATUMS),LEFT(1)
       BUTTON('&OK'),AT(112,36,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(151,36,36,14),USE(?CancelButton)
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

report REPORT,AT(198,1177,12000,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,979),USE(?unnamed:3)
         STRING(@s45),AT(3240,10,4427,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1729,406,7469,156),USE(FILTRS_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9375,417,677,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s90),AT(1125,198,8667,208),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,625,10573,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,625,0,365),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,677,313,208),USE(?String4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòçmçjs (Pârdevçjs)'),AT(563,656,1458,156),USE(?String4:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2083,625,0,365),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Dok. Nr.'),AT(2229,677,729,208),USE(?String4:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok. dat.'),AT(3208,677,625,208),USE(?String4:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apm. lîdz'),AT(3885,677,625,208),USE(?String4:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('VAL'),AT(4583,677,260,208),USE(?String4:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok. summa'),AT(4896,677,833,208),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(5781,677,781,208),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav. > 120'),AT(6615,677,781,208),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav. 90 - 120'),AT(7448,677,781,208),USE(?String4:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav. 60 - 89'),AT(8281,677,781,208),USE(?String4:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav. 30 - 59'),AT(9115,677,781,208),USE(?String4:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav. 1 - 29'),AT(9948,677,781,208),USE(?String4:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(542,781,1531,156),USE(FILTRS),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,938,10573,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(9063,625,0,365),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(9896,625,0,365),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(10729,625,0,365),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(8229,625,0,365),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7396,625,0,365),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(3177,625,0,365),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3854,625,0,365),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4531,625,0,365),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4844,625,0,365),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5729,625,0,365),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6563,625,0,365),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(156,625,0,365),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,198)
         LINE,AT(5729,,0,198),USE(?Line17:3),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(5781,21,729,156),USE(P_C_SUMMAV),RIGHT(1)
         LINE,AT(6563,,0,198),USE(?Line17:9),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6615,21,729,156),USE(KAV120),RIGHT(1)
         LINE,AT(7396,,0,198),USE(?Line17:8),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(7448,21,729,156),USE(KAV90),RIGHT(1)
         LINE,AT(8229,,0,198),USE(?Line17:7),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(8281,21,729,156),USE(KAV60),RIGHT(1)
         LINE,AT(9063,,0,198),USE(?Line17:6),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(9115,21,729,156),USE(KAV30),RIGHT(1)
         LINE,AT(9896,,0,198),USE(?Line17:5),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(9948,21,729,156),USE(KAV1),RIGHT(1)
         LINE,AT(10729,,0,198),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(2083,,0,198),USE(?Line17:14),COLOR(COLOR:Black)
         STRING(@D06.),AT(3208,21,615,156),USE(P:DATUMS),CENTER
         LINE,AT(156,,0,198),USE(?Line17),COLOR(COLOR:Black)
         STRING(@N_4),AT(208,21,260,156),USE(NPK),RIGHT
         LINE,AT(521,,0,198),USE(?Line17:2),COLOR(COLOR:Black)
         STRING(@S40),AT(542,21,1530,156),USE(NOS_P),LEFT
         STRING(@S14),AT(2115,21,1042,156),USE(P:DOK_SENR),CENTER
         LINE,AT(3177,,0,198),USE(?Line17:13),COLOR(COLOR:Black)
         LINE,AT(3854,,0,198),USE(?Line17:12),COLOR(COLOR:Black)
         STRING(@D06.),AT(3885,21,615,156),USE(P:NORDAT),CENTER
         LINE,AT(4531,,0,198),USE(?Line17:11),COLOR(COLOR:Black)
         STRING(@S3),AT(4583,21,260,156),USE(P:VAL),LEFT
         LINE,AT(4844,,0,198),USE(?Line17:10),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4896,21,781,156),USE(P:SUMMAV),RIGHT(1)
       END
detailP DETAIL,AT(,,,198)
         LINE,AT(5729,,0,198),USE(?Line17:3P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(5781,21,729,156),USE(P_C_SUMMAP),RIGHT(1)
         LINE,AT(6563,,0,198),USE(?Line17:9P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6615,21,729,156),USE(KAV120P),RIGHT(1)
         LINE,AT(7396,,0,198),USE(?Line17:8P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(7448,21,729,156),USE(KAV90P),RIGHT(1)
         LINE,AT(8229,,0,198),USE(?Line17:7P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(8281,21,729,156),USE(KAV60P),RIGHT(1)
         LINE,AT(9063,,0,198),USE(?Line17:6P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(9115,21,729,156),USE(KAV30P),RIGHT(1)
         LINE,AT(9896,,0,198),USE(?Line17:5P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(9948,21,729,156),USE(KAV1P),RIGHT(1)
         LINE,AT(10729,,0,198),USE(?Line17:4P),COLOR(COLOR:Black)
         LINE,AT(2083,,0,198),USE(?Line17:14P),COLOR(COLOR:Black)
         LINE,AT(156,,0,198),USE(?Line17:P),COLOR(COLOR:Black)
         LINE,AT(521,,0,198),USE(?Line17:2P),COLOR(COLOR:Black)
         LINE,AT(3177,,0,198),USE(?Line17:13P),COLOR(COLOR:Black)
         LINE,AT(3854,,0,198),USE(?Line17:12P),COLOR(COLOR:Black)
         LINE,AT(4531,,0,198),USE(?Line17:11P),COLOR(COLOR:Black)
         STRING('Ls'),AT(4583,21,260,156),USE(?Ls),LEFT
         LINE,AT(4844,,0,198),USE(?Line17:10P),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4896,21,781,156),USE(SUMMAP),RIGHT(1)
       END
detailN DETAIL,AT(,,,198),USE(?unnamed:4)
         LINE,AT(5729,,0,198),USE(?Line117:3),COLOR(COLOR:Black)
         LINE,AT(6563,,0,198),USE(?Line117:9),COLOR(COLOR:Black)
         LINE,AT(7396,,0,198),USE(?Line117:8),COLOR(COLOR:Black)
         LINE,AT(8229,,0,198),USE(?Line117:7),COLOR(COLOR:Black)
         LINE,AT(9063,,0,198),USE(?Line117:6),COLOR(COLOR:Black)
         LINE,AT(9896,,0,198),USE(?Line117:5),COLOR(COLOR:Black)
         LINE,AT(10729,,0,198),USE(?Line117:4),COLOR(COLOR:Black)
         LINE,AT(2083,,0,198),USE(?Line117:14),COLOR(COLOR:Black)
         STRING(@D06.),AT(3208,21,615,156),USE(A:DATUMS),CENTER
         LINE,AT(156,,0,198),USE(?Line117),COLOR(COLOR:Black)
         LINE,AT(521,,0,198),USE(?Line117:2),COLOR(COLOR:Black)
         STRING(@S35),AT(573,21,1490,156),USE(NOS_P,,?NOS_P:2),LEFT
         LINE,AT(3177,,0,198),USE(?Line117:13),COLOR(COLOR:Black)
         LINE,AT(3854,,0,198),USE(?Line117:12),COLOR(COLOR:Black)
         LINE,AT(4531,,0,198),USE(?Line117:11),COLOR(COLOR:Black)
         STRING(@S3),AT(4583,21,260,156),USE(A:VAL),LEFT
         LINE,AT(4844,,0,198),USE(?Line117:10),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4896,21,781,156),USE(A:SUMMAV),RIGHT(1)
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(156,0,10573,0),USE(?Line1:3P),COLOR(COLOR:Black)
       END
REP_FOOTV DETAIL,AT(,,,198),USE(?unnamed)
         LINE,AT(4844,,0,197),USE(?Line247:2),COLOR(COLOR:Black)
         LINE,AT(5729,,0,197),USE(?Line247:9),COLOR(COLOR:Black)
         LINE,AT(6563,,0,197),USE(?Line247:8),COLOR(COLOR:Black)
         LINE,AT(7396,,0,197),USE(?Line247:7),COLOR(COLOR:Black)
         LINE,AT(8229,,0,197),USE(?Line247:6),COLOR(COLOR:Black)
         LINE,AT(9063,,0,197),USE(?Line247:5),COLOR(COLOR:Black)
         LINE,AT(9896,,0,197),USE(?Line247:4),COLOR(COLOR:Black)
         LINE,AT(10729,,0,197),USE(?Line247:3),COLOR(COLOR:Black)
         STRING('KOPÂ:'),AT(417,21,417,156),USE(?String42:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S3),AT(4573,21,260,156),USE(V:VALUTA),LEFT
         STRING(@N-_13.2B),AT(4896,21,781,156),USE(V:SUMMAV),RIGHT(1)
         STRING(@N-_13.2B),AT(5781,21,729,156),USE(V:P_C_SUMMAV),RIGHT(1)
         STRING(@N-_13.2B),AT(6615,21,729,156),USE(V:KAV120),RIGHT(1)
         STRING(@N-_13.2B),AT(7448,21,729,156),USE(V:KAV90),RIGHT(1)
         STRING(@N-_13.2B),AT(8281,21,729,156),USE(V:KAV60),RIGHT(1)
         STRING(@N-_13.2B),AT(9115,21,729,156),USE(V:KAV30),RIGHT(1)
         STRING(@N-_13.2B),AT(9948,21,729,156),USE(V:KAV1),RIGHT(1)
         LINE,AT(156,,0,197),USE(?Line247),COLOR(COLOR:Black)
       END
REP_FOOTER DETAIL,AT(,,,219),USE(?unnamed:2)
         LINE,AT(4844,0,0,62),USE(?Line147:2),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,62),USE(?Line147:9),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,62),USE(?Line147:8),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,62),USE(?Line147:7),COLOR(COLOR:Black)
         LINE,AT(8229,0,0,62),USE(?Line147:6),COLOR(COLOR:Black)
         LINE,AT(9063,0,0,62),USE(?Line147:5),COLOR(COLOR:Black)
         LINE,AT(9896,0,0,62),USE(?Line147:4),COLOR(COLOR:Black)
         LINE,AT(10729,0,0,62),USE(?Line147:3),COLOR(COLOR:Black)
         LINE,AT(156,52,10573,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RS:'),AT(156,73),USE(?String50),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(344,73),USE(RS),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9625,73),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10250,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(156,0,0,62),USE(?Line147),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7104,12000,52)
         LINE,AT(156,0,10573,0),USE(?Line1:4),COLOR(COLOR:Black)
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

  B_DATUMS=B_DAT
  open(Atsk_V_window)
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

  IF KKK[1] < '3'
     D_K='D'
  ELSE
     D_K='K'
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(PAR_K,1)
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
  ProgressWindow{Prop:Text} = 'Parâdu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:BKK=KKK
      SET(GGK:BKK_DAT)
      CG='K113001'  !GGK,RS,GGK:DATUMS<B_DAT,D_K,....
      CP='K10'
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
      VIRSRAKSTS='Parâdu kopsavilkums dokumentiem, izrakstîtiem lîdz '&FORMAT(B_DAT,@D06.)&' uz '&FORMAT(B_DATUMS,@D06.)&|
      ' konts '&KKK
      IF F:NODALA THEN FILTRS_TEXT='F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF PAR_NR=999999999
        IF PAR_GRUPA
          FILTRS='GRUPA= '&PAR_GRUPA
        ELSE
          FILTRS='   Visi'
        .
      ELSE
        FILTRS=getpar_k(par_nr,2,2)
      .
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('BPARKOPS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='PARÂDU KOPSAVILKUMS DOKUMENTU LÎMENÎ UZ '&format(B_DATUMS,@d06.)&' '&KKK
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Saòçmçjs (Pârdevçjs)'&CHR(9)&'Dokumenta Num.'&CHR(9)&'Dok. dat.'&CHR(9)&'Apm. dat.'&CHR(9)&'VAL'&CHR(9)&'Dok. summa'&CHR(9)&'Atlikums'&CHR(9)&'Kav. > 120'&CHR(9)&'Kav.90 - 120'&CHR(9)&'Kav. 60 - 89'&CHR(9)&'Kav. 30 - 59'&CHR(9)&'Kav. 1 - 29'
          ADD(OUTFILEANSI)
          OUTA:LINE=      CHR(9)&filtrs&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG) AND ~CYCLEPAR_K(CP) AND ~(BAND(GGK:BAITS,00000001B)) !~IEZAKS 
            nk#+=1                                                                                !(RÇÍINAM UZ DOKUMENTIEM)
            ?Progress:UserString{Prop:Text}=NK#
            DISPLAY(?Progress:UserString)
            IF ~GETGG(GGK:U_NR)
               KLUDA(5,'GGK:U_NR:'&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
            .
            IF ~GG:APMDAT THEN GG:APMDAT=GG:DATUMS.
            IF GGK:REFERENCE AND GGK:SUMMA<0  !STORNO
               LOOP I#= 1 TO RECORDS(P_TABLE)
                  GET(P_TABLE,I#)
                  IF P:DOK_SENR=GGK:REFERENCE AND P:PAR_NR=GGK:PAR_NR
                     P:SUMMAV+=GGK:SUMMAV
                     PUT(P_TABLE)
                     BREAK
                  .
               .
            ELSE                               !NORMÂLA P/Z(RÇÍINS)
               P:PAR_NR=GGK:PAR_NR
               P:NOS_KEY=SUB(GETPAR_K(GGK:PAR_NR,2,14),1,5)&FORMAT(P:PAR_NR,@N_8)&FORMAT(GGK:DATUMS,@D11)
               IF GGK:U_NR=1                     !SALDO
                  P:DOK_SENR=GGK:REFERENCE
                  P:NORDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1)
               ELSE
                  P:DOK_SENR=GG:DOK_SENR
                  P:NORDAT=GG:APMDAT   !JA NAV, JAU PASPÇJÂM PIEÐÍIRT DOKDATUMU
               .
               P:DATUMS=GGK:DATUMS
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
!---------P_TABLÇ TAGAD IR VISAS P/Z PARTNERIM(GRUPAI) 231/531 KONTAM(KONTIEM) UZ B_DAT-----------------
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
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,0,'',RS,P:PAR_NR,'',0,0,'',0,B_DATUMS)  !Uzbûvç apmaksas ðitam partnerim
     .
     IF ~(P:PAR_NR=SAV_PAR_NR)     !MAINÎJIES PARTNERIS
        DO PRINTNESAMAKSA          !par ðito vçl ir jâdomâ
        DO PRINTDETAILP
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,0,'',RS,P:PAR_NR,'',0,0,'',0,B_DATUMS)  !Uzbûvç apmaksas
     .
     DO PRINTSAMAKSA
  .
  DO PRINTNESAMAKSA
  DO PRINTDETAILP
  dat = today()
  lai = clock()
!  PAR_T_SUMMA=PAV_T_SUMMA-SAM_T_SUMMA-T_KS
  IF F:DBF='W'
      PRINT(RPT:LINE)
  ELSIF F:DBF='E'
      OUTA:LINE=''
      ADD(OUTFILEANSI)
  END
  LOOP I#=1 TO RECORDS(V_TABLE)
     GET(V_TABLE,I#)
     IF F:DBF='W'
        PRINT(RPT:REP_FOOTV)
     ELSE
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&V:VALUTA&CHR(9)&LEFT(FORMAT(V:SUMMAV,@N-_12.2))&CHR(9)&LEFT(FORMAT(V:P_C_SUMMAV,@N-_12.2))&CHR(9)&LEFT(FORMAT(V:KAV120,@N-_12.3))&CHR(9)&LEFT(FORMAT(V:KAV90,@N-_12.3))&CHR(9)&LEFT(FORMAT(V:KAV60,@N-_12.3))&CHR(9)&LEFT(FORMAT(V:KAV30,@N-_12.3))&CHR(9)&LEFT(FORMAT(V:KAV1,@N-_12.3))
        ADD(OUTFILEANSI)
     .
  .
  IF F:DBF='W'
      PRINT(RPT:REP_FOOTER)
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
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(A_TABLE)
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
!   IF (ATSK_V=1 AND INRANGE(P:DATUMS,S_DAT,B_DAT)) OR (ATSK_V=2 AND INRANGE(P:NORDAT,S_DAT,B_DAT))
   ! P/Z TRÂPA PIEPRASÎTAJÂ APGABALÂ
       JAU_SAM_SUMMAV=0
       GET(A_TABLE,0)
       LOOP I#= 1 TO RECORDS(A_TABLE)
          GET(A_TABLE,I#)
          IF ~(A:REFERENCE=P:DOK_SENR) THEN CYCLE.
          JAU_SAM_SUMMAV+=A:SUMMAV   !LAI UZZINÂTU, VAI PA VISIEM LÂGIEM IR SAMAKSÂTS KOPÂ VISS
          A:SUMMA=0                  !NONULLÇJAM A_TABLI
          A:SUMMAV=0                 !NONULLÇJAM A_TABLI
          PUT(A_TABLE)
       .
!       STOP(P:SUMMAV&'='&JAU_SAM_SUMMAV) !VISS SAMAKSÂTS
       IF ~(P:SUMMAV=JAU_SAM_SUMMAV) !VISS SAMAKSÂTS
          NPK+=1
          NOS_P=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)
          KAV=B_DATUMS-P:NORDAT
          IF KAV<0 THEN KAV=0.
          P_C_SUMMAV=P:SUMMAV-JAU_SAM_SUMMAV  !TEKOÐAIS PARÂDS UZ P/Z
          IF P_C_SUMMAV > 0
             IF KAV>120
                KAV120 =P_C_SUMMAV
             ELSIF KAV>=90
                KAV90  =P_C_SUMMAV
             ELSIF KAV>=60
                KAV60  =P_C_SUMMAV
             ELSIF KAV>=30
                KAV30  =P_C_SUMMAV
             ELSIF KAV>=1
                KAV1   =P_C_SUMMAV
             .
          .
          DO PRINTDETAILS
          SUMMAP  +=P:SUMMAV*BANKURS(P:VAL,P:DATUMS)
          P_C_SUMMAP+=P_C_SUMMAV*BANKURS(P:VAL,P:DATUMS)
          KAV120P += KAV120*BANKURS(P:VAL,P:DATUMS)
          KAV90P  += KAV90*BANKURS(P:VAL,P:DATUMS)
          KAV60P  += KAV60*BANKURS(P:VAL,P:DATUMS)
          KAV30P  += KAV30*BANKURS(P:VAL,P:DATUMS)
          KAV1P   += KAV1*BANKURS(P:VAL,P:DATUMS)

          V:VALUTA=P:VAL
          GET(V_TABLE,V:VALUTA)
          IF ERROR()
             V:SUMMAV=P:SUMMAV
             V:P_C_SUMMAV=P_C_SUMMAV
             V:KAV120 = KAV120
             V:KAV90  = KAV90
             V:KAV60  = KAV60
             V:KAV30  = KAV30
             V:KAV1   = KAV1
             ADD(V_TABLE)
             SORT(V_TABLE,V:VALUTA)
          ELSE
             V:SUMMAV +=P:SUMMAV
             V:P_C_SUMMAV+=P_C_SUMMAV
             V:KAV120 += KAV120
             V:KAV90  += KAV90
             V:KAV60  += KAV60
             V:KAV30  += KAV30
             V:KAV1   += KAV1
             PUT(V_TABLE)
          .
          KAV120=0
          KAV90 =0
          KAV60 =0
          KAV30 =0
          KAV1  =0
       .
       JAU_SAM_SUMMAV=0
       P_C_SUMMAV=0
!    ELSE
    ! P/Z NETRÂPA PIEPRASÎTAJÂ APGABALÂ, BÛS JÂNONULLÇ A_TABLE
!       DO NULLA_TABLE
!    .
!-------------------------------------------------------------------------
PRINTDETAILS      ROUTINE
     IF F:DBF='W'
        PRINT(RPT:DETAIL)
     ELSE
        OUTA:LINE=NPK&CHR(9)&NOS_P&CHR(9)&P:DOK_SENR&CHR(9)&FORMAT(P:DATUMS,@D06.)&CHR(9)&FORMAT(P:NORDAT,@D06.)&|
        CHR(9)&P:VAL&CHR(9)&LEFT(FORMAT(P:SUMMAV,@N-_12.2))&CHR(9)&LEFT(FORMAT(P_C_SUMMAV,@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(KAV120,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV90,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV60,@N-_12.3))&|
        CHR(9)&LEFT(FORMAT(KAV30,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV1,@N-_12.3))
        ADD(OUTFILEANSI)
     .
     DOKUMENTI#+=1
!-------------------------------------------------------------------------
PRINTDETAILP      ROUTINE
  IF DOKUMENTI#>1
     IF F:DBF='W'
        PRINT(RPT:DETAILP)
     ELSE
        OUTA:LINE=NPK&CHR(9)&NOS_P&CHR(9)&''&CHR(9)&''&CHR(9)&''&|
        CHR(9)&P:VAL&CHR(9)&LEFT(FORMAT(SUMMAP,@N-_12.2))&CHR(9)&LEFT(FORMAT(P_C_SUMMAP,@N-_12.2))&CHR(9)&|
        LEFT(FORMAT(KAV120P,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV90P,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV60P,@N-_12.3))&|
        CHR(9)&LEFT(FORMAT(KAV30P,@N-_12.3))&CHR(9)&LEFT(FORMAT(KAV1P,@N-_12.3))
        ADD(OUTFILEANSI)
     .
  .
  PRINT(RPT:LINE)
  DOKUMENTI#=0
  SUMMAP  =0
  P_C_SUMMAP=0
  KAV120P = 0
  KAV90P  = 0
  KAV60P  = 0
  KAV30P  = 0
  KAV1P   = 0

!-------------------------------------------------------------------------
PrintNESamaksa ROUTINE
  GET(A_TABLE,0)
  LOOP I#= 1 TO RECORDS(A_TABLE)       !NEPAZÎSTAMÂS APMAKSAS
     GET(A_TABLE,I#)
     IF A:SUMMAV=0 THEN CYCLE.
     IF A:DATUMS>B_DAT THEN CYCLE.     !LAI NEDRUKÂ, KO NEVAJAG
     NOS_P=A:PAR_NR&' Samaksa bez references'
     IF F:DBF='W'
         PRINT(RPT:DETAILN)
     ELSE
         OUTA:LINE=CHR(9)&NOS_P&CHR(9)&CHR(9)&FORMAT(A:DATUMS,@D06.)&CHR(9)&CHR(9)&A:VAL&CHR(9)&|
         LEFT(FORMAT(A:SUMMAV,@N12.2))
         ADD(OUTFILEANSI)
     END
  .
SPZ_Akts             PROCEDURE                    ! Declare Procedure
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
SUMMA_BS             STRING(15)
DAUDZUMS_S           STRING(15)
DAUDZUMSK_S          STRING(15)
CENA_S               STRING(15)
LBKURSS              DECIMAL(14,6)
LSSUMMA              DECIMAL(12,2)
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
MENESIS              STRING(10)
gov_reg              STRING(37)
RPT_CLIENT           STRING(35)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(18)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
NOS_P                STRING(35)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
REKINS               STRING(20)
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
NOSK                 STRING(3)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
DAT                  LONG
LAI                  LONG
ADRESEF              STRING(60)
RET                  BYTE
KOM1                 STRING(30)
KOM2                 STRING(30)
KOM3                 STRING(30)
dok_nr               STRING(5)
PAV_AUTO             STRING(100)

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
!report REPORT,AT(146,400,8000,11000),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),THOUS
!report REPORT,AT(500,2533,8000,8000),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),THOUS
report REPORT,AT(500,620,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,400,8000,219)
         STRING(@P<<<#. lapaP),AT(6521,31,573,156),PAGENO,USE(?PageCount:2),RIGHT
         LINE,AT(42,188,7083,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
HEADER DETAIL,AT(,,,2333),USE(?unnamed)
         STRING(@s45),AT(1458,52,4740,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.B),AT(4188,365,781,208),USE(PAV:DATUMS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçs, apakðâ parakstîjusies komisija sekojoðâ sastâvâ:'),AT(208,677),USE(?String33),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('1.'),AT(208,885),USE(?String33:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(354,885),USE(KOM1)
         STRING('2. '),AT(208,1073),USE(?String33:3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(354,1073),USE(KOM2)
         STRING('3.'),AT(208,1260),USE(?String33:4),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(354,1260),USE(KOM3)
         STRING('ar ðo apliecinam, ka visi turpmâk uzskaitîtie materiâli (preces) ir_{13}' &|
             '_{41}'),AT(208,1510,6979,208),USE(?String33:5),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1823,7083,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,1823,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,1979,313,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(469,1979,1563,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2083,1979,1979,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4115,1979,781,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(4948,1979,781,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN %'),AT(6771,1979,365,208),USE(?String17:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5781,1875,938,208),USE(?String17:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, '),AT(5813,2083,615,208),USE(?String17:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6385,2083,302,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,2292,7083,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(2031,1823,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4063,1823,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4896,1823,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5729,1823,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6719,1823,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7135,1823,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(52,1823,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s5),AT(3698,365,490,208),USE(DOK_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(5052,365,781,208),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(5833,365,260,208),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu un materiâlu norakstîðanas AKTS Nr'),AT(500,365,3177,208),USE(?String4),LEFT(1), |
             FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@n4),AT(104,10,260,156),USE(RPT_npk),RIGHT
         LINE,AT(417,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@S21),AT(469,10,1563,156),USE(NOMENK),LEFT(1),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@s35),AT(2083,10,1979,156),USE(NOM:NOS_P),LEFT
         STRING(@n2),AT(6771,10,208,156),USE(NOL:PVN_PROC),RIGHT
         STRING('%'),AT(6979,10,156,156),USE(?String36),CENTER
         LINE,AT(4063,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@S15),AT(4115,10,729,156),USE(DAUDZUMS_S),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@S15),AT(5781,10,885,156),USE(SUMMA_BS),RIGHT
         LINE,AT(7135,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@S15),AT(4948,10,729,156),USE(CENA_S),RIGHT
         LINE,AT(6719,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(52,52,7083,0),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,115),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,115),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,115),USE(?Line28:6),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(4063,-10,0,63),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,63),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,417),USE(?unnamed:4)
         LINE,AT(5729,-10,0,228),USE(?Line21:3),COLOR(COLOR:Black)
         STRING(@S15),AT(3958,10,885,156),USE(DAUDZUMSK_S),RIGHT
         STRING(@n-_15.2B),AT(5781,10,885,156),USE(SUMK_B),RIGHT
         LINE,AT(4896,-10,0,228),USE(?Line21:5),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,228),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,228),USE(?Line21:4),COLOR(COLOR:Black)
         STRING(@s5),AT(260,10,365,156),USE(KOPA),LEFT
         LINE,AT(52,208,7083,0),USE(?Line22:2),COLOR(COLOR:Black)
         STRING(@s100),AT(94,240,6406,208),USE(PAV_AUTO),TRN
         LINE,AT(52,-10,0,228),USE(?Line21:2),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,1031),USE(?unnamed:3)
         STRING('Komisija apstiprina :'),AT(2240,125,1563,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(5635,125),USE(KOM1,,?KOM1:2),LEFT(3)
         STRING('_{25}'),AT(3698,125),USE(?String51:2)
         STRING(@s20),AT(5635,458),USE(KOM2,,?KOM2:2),LEFT(3)
         STRING('_{25}'),AT(3698,458),USE(?String51)
         STRING(@s20),AT(5635,813),USE(KOM3,,?KOM3:2),LEFT(3)
         STRING('_{25}'),AT(3698,813),USE(?String511)
       END
RPT_FOOT4 DETAIL,AT(,,,708)
         STRING('Pievienotâs vçrtîbas nodoklis'),AT(156,52,2031,208),USE(?String62:5),LEFT
         STRING('Pavisam'),AT(156,260,2031,208),USE(?String62:6),LEFT
         STRING('(ar cipariem)'),AT(5104,260,677,208),USE(?String62:8),LEFT
         STRING(@n-_13.2),AT(5833,260,833,208),USE(sumk_APM),RIGHT
         STRING(@s3),AT(6719,260,260,208),USE(pav:val,,?pav:val:3),LEFT
         STRING('(ar vârdiem)'),AT(156,469,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(833,469,7135,208),USE(sumV),LEFT,COLOR(0D3D3D3H)
         STRING(@n-_13.2),AT(5833,52,833,208),USE(sumk_PVN),RIGHT
         STRING(@s3),AT(6719,52,260,208),USE(pav:val,,?pav:val:2),LEFT
       END
       FOOTER,AT(500,11400,8000,52),USE(?unnamed:2)
         LINE,AT(52,10,7083,0),USE(?Line22:3),COLOR(COLOR:Black)
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

KOM  WINDOW('Komisijas sastâvs'),AT(,,172,83),CENTER,GRAY,DOUBLE
       STRING('Dokumenta Nr'),AT(35,5),USE(?String1)
       ENTRY(@s5),AT(85,3,31,12),USE(dok_nr,,?DOK_NR:2)
       ENTRY(@s30),AT(15,18),USE(KOM1,,?KOM11)
       ENTRY(@s30),AT(15,32),USE(KOM2,,?KOM21)
       ENTRY(@s30),AT(15,45),USE(KOM3,,?KOM31)
       BUTTON('&OK'),AT(120,63,33,15),USE(?OK),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  IF PAV:D_K='D' AND PAV:SUMMA<0   !MÇS ATGRIEÞAM PRECI
     SIGN#=-1
  ELSIF PAV:D_K='K'
     SIGN#=1
  ELSE
     KLUDA(0,'...atïauts tikai K vai -D !!!')
     do procedurereturn
  .
  DAT = TODAY()
  LAI = CLOCK()
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  RPT_gads=year(pav:datums)
  datums=day(pav:datums)
  menesis=MENVAR(pav:datums,2,2)
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

  KOM1=SYS:PARAKSTS1
  KOM2=SYS:PARAKSTS2
  OPEN(KOM)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OK
        CASE EVENT()
        OF EVENT:ACCEPTED
           BREAK
        .
     .
  .
  CLOSE(KOM)

  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Numurçtâ Pavadzîme'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      PAV:SUMMA=PAV:SUMMA*SIGN#
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
      PRINT(RPT:HEADER)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NOL:DAUDZUMS=NOL:DAUDZUMS*SIGN#
        NOL:SUMMA=NOL:SUMMA*SIGN#
        NOL:SUMMAV=NOL:SUMMAV*SIGN#
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,1)
        SVARS+=NOM:SVARSKG*nol:daudzums
        fillpvn(1)
        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
        CENA_S = CUT0(CENA,5,2)
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
        PRINT(RPT:DETAIL)                            !  PRINT DETAIL LIS
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
    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
    PRINT(RPT:RPT_FOOT1)
    SUMK_B=ROUND(GETPVN(3),.01)
    NOSK=PAV:VAL
    kopa='Kopâ:'
    PAV_AUTO=CLIP(GETAUTO(PAV:VED_NR,4))&' '&GETAUTO(PAV:VED_NR,11) !VISS, KAS VAJADZÎGS P/Z: "PARVADATAJS.. " & ðas.nr
    PRINT(RPT:RPT_FOOT2)
    IF GETPVN(20)                                ! IR VAIRÂK PAR VIENU PREÈU TIPU
!!      LOOP I#=4 TO 9
!!        SUMK_B=ROUND(GETPVN(I#),.01)
!!        IF SUMK_B <> 0
!!          EXECUTE I#-3
!!            kopa='t.s. prece'
!!            kopa='t.s. tara '
!!            kopa='t.s. pakalpojumi'
!!            kopa='t.s. kokmateriâli'
!!            kopa='t.s. raþojumi'
!!            kopa='t.s. citi'
!!          .
!!          PRINT(RPT:RPT_FOOT2)
!!        .
!!      .
      KLUDA(0,'Norakstîðanas Aktâ jâbût tikai precçm!')
    .
!************************* ATLAIDE ***********
!    IF PAV:SUMMA_A <= 0
!      PRINT(RPT:RPT_FOOT3)
!    ELSE
!      PRINT(RPT:RPT_FOOT31)
!    .
!************************* SVARS ***********
!    IF SVARS
!        IF SYS:SVN_SVJ='Jâ'
!          PRINT(RPT:RPT_FOOT32)
!        .
!    END
!************************* TRANSPORTS ***********
!    IF pav:t_summa > 0
!      PAV_T_SUMMA=ROUND(pav:t_summa/(1+PAV:T_PVN/100),.01)
!      PRINT(RPT:RPT_FOOT33)
!    .
!************************* PVN ***********
    SUMK_PVN = ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît summas')
!!      kluda(74,'')
!!      print(rpt:rpt_err)
!!      CLOSE(REPORT)
!!      RETURN
    .
    SUMK_B=ROUND(GETPVN(3),.01)
    NOSK=PAV:VAL
!    SUMK_APM = SUMK_B + SUMK_PVN + PAV:T_SUMMA
    SUMK_APM = SUMK_B + SUMK_PVN    !10/03/03
    SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
    PRINT(RPT:RPT_FOOT4)
!    IF PAV_AUTO OR PAV:PIELIK
!        PRINT(RPT:RPT_FOOT41)
!    END
!    IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z SPECIÂLA RINDA    LBKURSS=BANKURS(PAV:NOS,PAV:DATUMS,1)
!      LSSUMMA = SUMK_APM*LBKURSS
!      PRINT(RPT:RPT_LS)
!    .
!    IF F:DBF = 'F'                          ! NUMURÇTÂ FAKTORINGA PAVADZÎME
!        PRINT(RPT:FAKTORING)
!    END
    PRINT(RPT:RPT_FOOT3)                    !PRINT GRAND TOTALS
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
GETNOM_ADRESE        FUNCTION (NOMEN,OPC)         ! Declare Procedure
PLAUKTS     STRING(50)
  CODE                                            ! Begin processed code
!
!  OPC=0
!  OPC=2 JÂMAINA NOP:NOMENKLAT
!
!  ATGRIEÞ PLAUKTU
!
  IF NOM_P::USED=0
     CHECKOPEN(NOM_P,1)
  .
  NOM_P::USED+=1
  IF NOMEN
     CLEAR(NOP:RECORD)
     NOP:NOMENKLAT=NOMEN
     SET(NOP:NOM_KEY,NOP:NOM_KEY)
     LOOP
        NEXT(NOM_P)
        IF ERROR() OR ~(NOP:NOMENKLAT=NOMEN) THEN BREAK.
        IF NOP:NOL_NR
           LOC_NR#=NOP:NOL_NR
        ELSIF NOP:KOMENTARS[2]=':' AND INRANGE(NOP:KOMENTARS[1],1,9)
           LOC_NR#=NOP:KOMENTARS[1]
        ELSIF NOP:KOMENTARS[3]=':' AND INRANGE(NOP:KOMENTARS[1:2],10,25)
           LOC_NR#=NOP:KOMENTARS[1:2]
        ELSE
!           NOP:KOMENTARS=CLIP(LOC_NR)&':'&NOP:KOMENTARS
           NOP:NOL_NR=LOC_NR
           IF RIUPDATE:NOM_P()
              KLUDA(24,'NOM_P: '&NOMEN&' -> '&NOM:NOMENKLAT)
           .
           LOC_NR#=LOC_NR
        .
        IF PLAUKTS
           IF LOC_NR#=LOC_NR THEN PLAUKTS=CLIP(PLAUKTS)&','&NOP:PLAUKTS.
        ELSE
           IF LOC_NR#=LOC_NR THEN PLAUKTS=NOP:PLAUKTS.
        .
        IF OPC=2  !JÂMAINA
!          IF GNET   GLOBÂLÂ TÎKLÂ MAINÎT NEDRÎKST
           NOP:NOMENKLAT=NOM:NOMENKLAT
           IF RIUPDATE:NOM_P()
              KLUDA(24,'NOM_P: '&NOMEN&' -> '&NOM:NOMENKLAT)
           .
        .
     .
  ELSE
     CLEAR(NOP:RECORD)
  .
  NOM_P::USED-=1
  IF NOM_P::USED=0
     CLOSE(NOM_P)
  .
  RETURN(PLAUKTS)
