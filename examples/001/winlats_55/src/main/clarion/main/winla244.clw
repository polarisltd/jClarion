                     MEMBER('winlats.clw')        ! This is a MEMBER module
PAS_IzzinaNomenklaturai PROCEDURE                 ! Declare Procedure
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
RPT_NPK              DECIMAL(3)
NOS_CENA             DECIMAL(11,2)
NOS_PASUTITAJS       STRING(45)
SAV_NOMEN            STRING(21)
NOS_P                STRING(35)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
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
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
NPK                  STRING(3)
NOMENK               STRING(21)
DAUDZUMSK            DECIMAL(15,3)
KOPA                 STRING(15)
PLKST                TIME
ADRESEF              STRING(60)
PAV_AUTO             STRING(80)
FAX                  STRING(31)
SUMM                 STRING(15)
NOS_KATALOGA_NR      STRING(21)
sanemejs             STRING(30)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLPAS)
                       PROJECT(NOS:DATUMS)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:NOMENKLAT)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:VAL)
                       PROJECT(NOS:PAR_NR)
                       PROJECT(NOS:U_NR)
                       PROJECT(NOS:KEKSIS)
                       PROJECT(NOS:KOMENTARS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(146,1396,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
       HEADER,AT(146,198,8000,1208)
         STRING(@s45),AT(1875,52,4427,208),USE(Client),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Izziòa par veiktajiem pasûtîjumiem'),AT(2667,375,2656,208),USE(?String38:4),CENTER,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîjumu datumi no'),AT(417,729,1458,208),USE(?String138:4),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(3188,729,917,208),USE(B_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(1979,729,917,208),USE(S_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('lîdz'),AT(2906,729,292,208),USE(?String38:3),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(417,938,1042,208),USE(?String38:2),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@S21),AT(1510,938,1625,208),USE(Nomenklat),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,1198,7813,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,302)
         LINE,AT(104,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(1250,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,313),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(4323,0,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,313),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line8:32),COLOR(COLOR:Black)
         LINE,AT(104,0,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,42,365,208),USE(?String11:2),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasût. Nr.'),AT(542,42,708,208),USE(?String12),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Saòçmçjs'),AT(1563,42,1406,208),USE(?String13),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Daudzums'),AT(3521,42,781,208),USE(?String14),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Cena'),AT(4354,42,729,208),USE(?String15),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Komentârs'),AT(5135,42,2344,208),USE(?String16),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('PS'),AT(7521,42,365,208),USE(?String11),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,260,7813,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line8:35),COLOR(COLOR:Black)
         STRING(@n_7),AT(625,10,552,156),USE(pas:dok_nr),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1250,-10,0,198),USE(?Line8:37),COLOR(COLOR:Black)
         STRING(@s30),AT(1333,10,2104,156),USE(sanemejs),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3490,-10,0,198),USE(?Line8:36),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(3542,10,729,156),USE(NOS:daudzums),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4323,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@n_11.2),AT(4375,10,677,156),USE(NOS:LIGUMCENA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5104,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         STRING(@s30),AT(5146,10,2333,156),USE(NOS:KOMENTARS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(7552,10,313,156),USE(NOS:KEKSIS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7500,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
         STRING(@n_4),AT(156,10,313,156),USE(RPT_npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line8:937),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(1250,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(4323,0,0,52),USE(?Line62:12),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,52),USE(?Line62:21),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line62:23),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,52),USE(?Line62:32),COLOR(COLOR:Black)
         LINE,AT(104,52,7813,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line58:992),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11200,8000,52)
         LINE,AT(104,0,7813,0),USE(?Line5:5),COLOR(COLOR:Black)
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
IZDRUKA WINDOW('Izdrukas formâts'),AT(,,185,70),GRAY
       OPTION('Izdrukas &formâts'),AT(6,11,173,27),USE(F:DBF),BOXED
         RADIO('WMF'),AT(8,22),USE(?F:DBF:Radio1)
         RADIO('WMF (pçc nomenklatûtâm)'),AT(38,22),USE(?F:DBF:Radio2),VALUE('N')
         RADIO('ANSI:TXT'),AT(135,22),USE(?F:DBF:Radio3)
       END
       BUTTON('&OK'),AT(45,47,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(107,47,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  F:DBF='W'
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
  BIND(PAS:RECORD)
  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Pasûtîjumi Nomenklatûrai'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLPAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOS:RECORD)
      NOS:NOMENKLAT=NOMENKLAT
      SET(NOS:NOM_KEY,NOS:NOM_KEY)
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
!          SETTARGET(REPORT)
!          IMAGE(156,156,2448,677,'USER.BMP')
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
          PRINT(RPT:DETAIL0)
!      ELSE
!         IF ~OPENANSI('INVOICE.TXT')
!           POST(Event:CloseWindow)
!           CYCLE
!         .
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF NOS:SAN_NR=PAR:NR
           NK#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           DAUDZUMSK += NOS:DAUDZUMS
           NPK+=1
           IF NPK<99
             RPT_NPK=FORMAT(NPK,@N2)&'.'
           ELSE
             RPT_NPK=FORMAT(NPK,@N3)
           .
           CLEAR(PAS:RECORD)
           PAS:U_NR=NOS:U_NR
           GET(PAVPAS,PAS:NR_KEY)
           SANEMEJS=''
           IF NOS:AUT_NR
              SANEMEJS=GETAUTO(NOS:AUT_NR,9)
           .
           SANEMEJS=CLIP(SANEMEJS)&' '&NOS:SAN_NOS
!          IF F:DBF='N'
!             NOS_KATALOGA_NR=NOS:NOMENKLAT
!          ELSE
!             NOS_KATALOGA_NR=NOS:KATALOGA_NR
!           .
!           IF F:DBF = 'W' OR F:DBF='N'
           PRINT(RPT:DETAIL)
!           SAV_NOMEN = NOS:NOMENKLAT
!           ELSE
!                SUMM = NOS:DAUDZUMS
!                OUTA:LINE=RPT_NPK&CHR(9)&NOS:KATALOGA_NR&CHR(9)&SUMM
!                ADD(OUTFILEANSI)
!           END
!        .
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
  IF SEND(NOLPAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    kopa='Total:'
!    IF F:DBF = 'W' OR F:DBF='N'
        PRINT(RPT:RPT_FOOT3)                        !PRINT GRAND TOTALS
!    ELSE
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!        SUMM = DAUDZUMSK
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&SUMM
!        ADD(OUTFILEANSI)
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!    END
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
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Wordpad.exe')
        .
    .
  END
  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
  ELSE
      ANSIFILENAME=''
  END
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
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
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
  IF ERRORCODE() OR ~(NOS:NOMENKLAT=NOMENKLAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
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
CHECKIBAN            PROCEDURE (IBAN,sub)         ! Declare Procedure
SIBAN        STRING(21)
CIBAN        STRING(30)
  CODE                                            ! Begin processed code
 IF INRANGE(LEN(CLIP(IBAN)),9,21) !JÂBÛT IBAN KODAM
    SIBAN=IBAN[5:21]&IBAN[1:4]
    CIBAN=''
    LOOP I#=1 TO 21
       IF VAL(SIBAN[I#])>64 !VAL(A)=65
          CIBAN=CLIP(CIBAN)&VAL(SIBAN[I#])-55
       ELSE
          CIBAN=CLIP(CIBAN)&SIBAN[I#]
       .
    .
    LOOP J#=1 TO 4
       I#=CIBAN[1:9]%97
       CIBAN=I#&CIBAN[10:27]
    .
    IF ~(I#=1)
        KLUDA(0,'Nepareizi norâdîts IBAN kods '&IBAN)
    .
    IF SUB
        KLUDA(0,'Ja IBAN kods, subkonts nav jânorâda...')
    .
 .
B_PVN_DEK_MKN29      PROCEDURE                    ! Declare Procedure
CG           STRING(10)
RejectRecord LONG
EOF          BYTE
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)

K31          REAL
K33          REAL
K34          REAL
K54          REAL
K56          REAL

R40          DECIMAL(12,2)
R41          DECIMAL(12,2)
R42          DECIMAL(12,2)
R43          DECIMAL(12,2)
R44          DECIMAL(12,2)
R45          DECIMAL(12,2)
R46          DECIMAL(12,2)
R47          DECIMAL(12,2)
R48          DECIMAL(12,2)
R49          DECIMAL(12,2)
R50          DECIMAL(12,2)
R51          DECIMAL(12,2)

R52          DECIMAL(12,2)
R53          DECIMAL(12,2)
R54          DECIMAL(12,2)
R55          DECIMAL(12,2)
R56          DECIMAL(12,2)

R60          DECIMAL(12,2)
R61          DECIMAL(12,2)
R62          DECIMAL(12,2)
R63          DECIMAL(12,2)
R64          DECIMAL(12,2)
R65          DECIMAL(12,2)
R66          DECIMAL(12,2)
R67          DECIMAL(12,2)
R68          DECIMAL(12,2)
R57          DECIMAL(12,2)
R58          DECIMAL(12,2)

R70          DECIMAL(12,2)
R80          DECIMAL(12,2)

SS           DECIMAL(12,2)
PP           DECIMAL(12,2)

PROP         REAL
DATUMS       DATE
MENESS       STRING(20)
RSS          STRING(11)
RSSS         STRING(11)

!R1414        STRING(20)
NOT1         STRING(45)
NOT2         STRING(45)
NOT3         STRING(45)
precizeta    STRING(10)
E            STRING(1)
VIRSRAKSTS   STRING(70)

Q_TABLE      QUEUE,PRE(Q)
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(2)
             .

K_TABLE      QUEUE,PRE(K)
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(2)
ANOTHER_K       BYTE
             .

PPR             BYTE,DIM(2)

SOURCE_FOR_50   DECIMAL(12,2)
SOURCE_FOR_51   DECIMAL(12,2)
SOURCE_FOR_41   DECIMAL(12,2)
SOURCE_FOR_42   DECIMAL(12,2)

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

TEX:DUF         STRING(100)
RI              DECIMAL(12,2)
SB_DAT          STRING(21)

XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

!-----------------------------------------------------------------------------
PrintSkipDetails     BOOL,AUTO
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



report REPORT,AT(198,104,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',9,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(10,,8000,11510),USE(?unnamed)
         STRING(@S10),AT(469,156),USE(PRECIZETA),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienests'),AT(2313,625),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7375,813),USE(?String1:2),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4938,604,2813,156),USE(NOT3),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,302,2813,156),USE(NOT1),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,458,2813,156),USE(NOT2),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@S70),AT(42,927,6938,229),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(taksâcijas periods)'),AT(5135,1146,1198,156),USE(?String3),CENTER
         STRING(@s21),AT(2365,1135),USE(SB_DAT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pielikums'),AT(7177,156,469,156),USE(?String107),FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(3583,125),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums:'),AT(260,1406),USE(?String8),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(2396,1406,3333,208),USE(CLIENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(7219,1417),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('Juridiskâ adrese:'),AT(260,1667),USE(?String10),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(1354,1667,3385,208),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1354,0,6719),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(208,1354,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Apliekamâs personas reìistrâcijas Numurs :'),AT(260,1927),USE(?String12),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(2969,1927,1094,208),USE(GL:VID_NR),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,2448,0,4844),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(7802,1354,0,6719),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Tâlrunis:'),AT(260,2188),USE(?String10:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s15),AT(833,2188,1198,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2448,7604,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'),AT(260,2500,3073,208),USE(?String18),LEFT, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('40'),AT(3906,2552,208,156),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,2552,885,156),USE(R40),RIGHT
         STRING('ar PVN 18% apliekamie darîjumi (arî paðpatçriòð)'),AT(260,2708,2865,156),USE(?String19), |
             LEFT
         STRING('ar PVN 0% apliekamie darîjumi, t.sk.:'),AT(260,3021,2552,156),USE(?String19:2),LEFT
         STRING('-uz ES dalîbvalstîm piegâdâtâs preces'),AT(417,3333,2448,156),USE(?String19:3),LEFT
         STRING('43'),AT(3906,3021,208,156),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,2865,885,156),USE(R42),RIGHT
         STRING(@N-_12.2B),AT(4219,3021,885,156),USE(R43),RIGHT
         STRING(@N-_12.2B),AT(4219,3177,885,156),USE(R44),RIGHT
         LINE,AT(208,8073,7604,0),USE(?Line11:4),COLOR(COLOR:Black)
         STRING('Ar PVN neapliekamie darîjumi'),AT(260,3958,1823,156),USE(?String31)
         STRING('47'),AT(3906,3646,208,156),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,3646,885,156),USE(R47),RIGHT
         STRING('-uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'),AT(417,3646,3333,156),USE(?String19:7), |
             LEFT
         LINE,AT(5208,5521,2604,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('PRIEKÐNODOKLIS (latos), no tâ :'),AT(260,5573,2292,208),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6823,4740,885,156),USE(R52),RIGHT
         STRING('54'),AT(6552,5042,208,156),USE(?String22:29),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('51'),AT(3906,4271,208,156),USE(?String22:10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,4271,885,156),USE(R51),RIGHT
         STRING('No ES dalîbvalstîm saòemtâs preces (5%)'),AT(260,4271,2552,156),USE(?String31:3)
         STRING('par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'),AT(260,5781,3958,156), |
             USE(?String37),LEFT
         STRING('par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'),AT(260,5938,4740,156), |
             USE(?String38),LEFT
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu'),AT(260,6094,4063,156), |
             USE(?String39),LEFT
         STRING('zemnieku saimniecîbâm izmaksâtâ PVN 12% kompensâcija'),AT(260,6406,3438,156),USE(?String40)
         STRING(@N-_12.2B),AT(5573,6250,833,156),USE(R64),RIGHT
         STRING('66'),AT(5250,6552,208,156),USE(?String22:17),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5573,6719,833,156),USE(R67),RIGHT
         STRING(@N-_12.2B),AT(5573,6406,833,156),USE(R65),RIGHT
         STRING('[P]'),AT(5260,7083),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('67'),AT(5250,6708,208,156),USE(?String22:18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas (atskaitâmais priekðnodoklis vai aprçíinâtais nodoklis)'),AT(260,6719,3802,156), |
             USE(?String46:4),LEFT
         STRING(@N-_12.2B),AT(5573,6875,833,156),USE(R68),RIGHT
         STRING(@N-_12.2B),AT(6833,6854,885,156),USE(R58),RIGHT
         STRING('KOPSUMMA:'),AT(260,7083),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6771,6667,0,625),USE(?Line3:11),COLOR(COLOR:Black)
         STRING('[S]'),AT(6563,7083),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,7292,2604,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('Aprçíinâtais nodoklis vai atskaitâmais priekðnodoklis saskaòâ ar likuma 13.2.p'),AT(260,6875,4792,156), |
             USE(?String46:5),LEFT
         STRING(@N-_12.2B),AT(6833,7083,885,208),USE(SS),RIGHT
         STRING('58'),AT(6552,6865,208,156),USE(?String22:26),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,7969,1302,0),USE(?Line1:11),COLOR(COLOR:Black)
         LINE,AT(6823,7708,0,260),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(5469,7448,0,260),USE(?Line13:12),COLOR(COLOR:Black)
         LINE,AT(6510,7448,0,521),USE(?Line23:12),COLOR(COLOR:Black)
         LINE,AT(5208,7448,0,260),USE(?Line33:12),COLOR(COLOR:Black)
         LINE,AT(5208,7448,1302,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('APSTIPRINU PIEVIENOTÂS VÇRTÎBAS NODOKÏA APRÇÍINU .'),AT(375,8802),USE(?String63),CENTER, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Atbildîgâ persona :'),AT(313,9552),USE(?String64),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(7188,11094,156,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@S1),AT(7667,10938),USE(RS)
         LINE,AT(1667,10677,6302,0),USE(?Line1:18),COLOR(COLOR:Black)
         STRING('R : '),AT(7406,10938),USE(?String99)
         STRING('VID atbildîgâ amatpersona:'),AT(313,10385),USE(?String73),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s5),AT(6771,10938),USE(KKK)
         STRING(@s20),AT(4052,9552),USE(SYS:PARAKSTS1),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('(datums)'),AT(5781,9792),USE(?String68),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2323,9792),USE(?String67:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@d06.),AT(5677,9552),USE(datums),FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(1510,9792,2448,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2500,10729),USE(?String67),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('(datums)'),AT(5781,10729),USE(?String68:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Budþetâ maksâjamâ nodokïa summa, ja P<<S'),AT(260,7760),USE(?String59:2),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6854,7760,885,208),USE(R80),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5531,7500,885,208),USE(R70),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,7708,2604,0),USE(?Line11:11),COLOR(COLOR:Black)
         STRING('80'),AT(6563,7760,240,167),USE(?String22:20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('attiecinâmâ nodokïa summa, ja P>S'),AT(260,7552,3490,208),USE(?String60),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5573,7083,833,208),USE(PP),RIGHT
         STRING('68'),AT(5250,6865,208,156),USE(?String22:21),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6833,6708,885,156),USE(R57),RIGHT
         STRING('57'),AT(6552,6708,208,156),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,7031,2604,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5573,6563,833,156),USE(R66),RIGHT
         STRING('-'),AT(5490,6552),USE(?String129:2),TRN
         STRING('63'),AT(5250,6083,208,156),USE(?String22:14),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,6667,1302,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('aprçíinâtais priekðnodoklis par precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,6250,4531,156), |
             USE(?String39:2),LEFT
         STRING(@N-_12.2B),AT(5573,5781,833,156),USE(R61),RIGHT
         STRING('ar PVN 5% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,5365,4896,156), |
             USE(?String31:6)
         STRING(@N-_12.2B),AT(6823,5354,885,156),USE(R56),RIGHT
         STRING('ar PVN 18% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,5208,4896,156), |
             USE(?String31:5)
         STRING('70'),AT(5250,7510,208,156),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'),AT(260,7344,4844,208), |
             USE(?String59),LEFT
         STRING('62'),AT(5250,5927,208,156),USE(?String22:13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('61'),AT(5250,5771,208,156),USE(?String22:12),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('60'),AT(5250,5615,208,156),USE(?String22:11),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5573,5625,833,156),USE(R60),RIGHT
         STRING(@N-_12.2B),AT(6823,4896,885,156),USE(R53),RIGHT
         STRING('55'),AT(6552,5198,208,156),USE(?String22:30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('48'),AT(3906,3802,208,156),USE(?String22:9),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,3802,885,156),USE(R48),RIGHT
         STRING('Neatskaitâmais priekðnodoklis'),AT(260,6563,1771,156),USE(?String46),LEFT
         STRING('65'),AT(5250,6396,208,156),USE(?String22:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5573,6094,833,156),USE(R63),RIGHT
         STRING('64'),AT(5250,6240,208,156),USE(?String22:15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5573,5938,833,156),USE(R62),RIGHT
         STRING(@N-_12.2B),AT(6823,5052,885,156),USE(R54),RIGHT
         STRING('56'),AT(6552,5354,208,156),USE(?String22:31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 18% apliekamiem darîjumiem'),AT(260,4740,2240,156),USE(?String19:8),LEFT
         STRING('49'),AT(3906,3958,208,156),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6823,5208,885,156),USE(R55),RIGHT
         STRING('par saòemtajiem pakalpojumiem'),AT(260,5052,2604,156),USE(?String31:4)
         STRING('ar PVN 5% apliekamiem darîjumiem'),AT(260,4896,2969,156),USE(?String19:9),LEFT
         LINE,AT(6771,4688,0,833),USE(?Line3:8),COLOR(COLOR:Black)
         STRING('No ES dalîbvalstîm saòemtâs preces (18%)'),AT(260,4115,2604,156),USE(?String31:2)
         LINE,AT(5469,5521,0,1771),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('50'),AT(3906,4115,208,156),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,4115,885,156),USE(R50),RIGHT
         STRING('+'),AT(5490,5625),USE(?String129),TRN
         LINE,AT(6510,4688,1302,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('46'),AT(3906,3490,208,156),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,3490,885,156),USE(R46),RIGHT
         STRING('-citâs ES dalîbvalstîs uzstâdîtâs vai montçtâs preces'),AT(417,3490,3333,156),USE(?String19:6), |
             LEFT
         STRING(@N-_12.2B),AT(4219,3958,885,156),USE(R49),RIGHT
         STRING('-par sniegtajiem pakalpojumiem'),AT(417,3802,2458,156),USE(?String29),LEFT
         STRING('45'),AT(3906,3333,208,156),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(4219,3333,885,156),USE(R45),RIGHT
         STRING('44'),AT(3906,3177,208,156),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('-darîjumi, kas veikti brîvostâs un SEZ'),AT(417,3177,2292,156),USE(?String19:5),LEFT
         STRING(@N-_12.2B),AT(4219,2708,885,156),USE(R41),RIGHT
         STRING('42'),AT(3906,2865,208,156),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN (latos)'),AT(260,4531),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('52'),AT(6552,4729,208,156),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('53'),AT(6552,4885,208,156),USE(?String22:28),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3854,4479,1354,0),USE(?Line11:5),COLOR(COLOR:Black)
         STRING('41'),AT(3906,2708,208,156),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 5% apliekamie darîjumi (arî paðpatçriòð)'),AT(260,2865,2969,156),USE(?String19:4), |
             LEFT
         LINE,AT(4115,2448,0,2031),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(3854,2448,0,2031),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(6510,2448,0,4844),USE(?Line3:4),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
!
! INDEKSS 1 :18%/21%
!         2 :5%/10%
!
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF KON_K::Used = 0
    CHECKOPEN(KON_K,1)
  end
  KON_K::Used += 1
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN deklarâcija'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      MENESS=MENVAR(MEN_NR,1,3)
      IF MENESS
         VIRSRAKSTS='Pievienotâs vçrtîbas nodokïa deklarâcija par '&FORMAT(GADS,@N04)&'. gada '&MENESS
      ELSE
         VIRSRAKSTS='Pievienotâs vçrtîbas nodokïa deklarâcija'
      .
      SB_DAT=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
      clear(ggk:record)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K1000'
      IF F:IDP THEN PRECIZETA='Precizçtâ'.
      IF F:XML THEN E='E' ELSE E=''.

      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      IF ErrorCode()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ErrorCode()
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
      ELSE           !XLS
        IF ~OPENANSI('PVNDKLR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&SB_DAT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas nosaukums:'&CHR(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiskâ adrese:'&CHR(9)&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas reìistrâcijas numurs:'&CHR(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlrunis:'&CHR(9)&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\PVN_D.DUF'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
!           XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
!           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationFile type="pvn_dekl_2007">'
           ADD(OUTFILEXML)
           XML:LINE='<<Declaration>'
           ADD(OUTFILEXML)
    
           XML:LINE='<<DeclarationHeader>'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           TEX:DUF=GL:ADRESE
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="adrese" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="taks_gads" value="'&YEAR(B_DAT)&'" />'
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods').
           XML:LINE='<<Field name="taks_men1" value="'&MONTH(B_DAT)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="atbild_pers" value="'&CLIP(SYS:PARAKSTS1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="telef" value="'&CLIP(SYS:TEL)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="aizp_datums" value="'&FORMAT(TODAY(),@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<</DeclarationHeader>'
           ADD(OUTFILEXML)
        .
    .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           CASE GGK:D_K
       !************************ SAMAKSÂTS PVN ********
           OF 'D'                                     ! SAMAKSÂTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
       !       RPT:ANKOP+=GGK:SUMMA
             OF '2'                                   ! PVN_TIPS=2 PREÈU IMPORTS ~ES
               R61+=GGK:SUMMA
             OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               IF GGK:PVN_PROC=12                     ! PIEÐÛTS 12% ZEMNIEKIEM
                  r65+=GGK:SUMMA
               ELSE
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                     R64+=GGK:SUMMA
                  ELSE
                     R62+=GGK:SUMMA
                  .
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
               R63+=GGK:SUMMA
!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!               R25+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R67+=GGK:SUMMA
             .
       !************************ SAÒEMTS PVN ********
           OF 'K'                                     ! SAÒEMTS PVN
       ! GGK:DAT_KEY= DATUMS-U_NR-D/K
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
       !       RPT:ANKOP-=GGK:SUMMA                     ! AN NO FIN NOD.
             OF '2'                                   ! PVN_TIPS=2 IMPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
             OF '0'                                   ! SAÒEMTS,REALIZÇJOT
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               CASE GGK:PVN_PROC
               OF 18
               OROF 21
                  PPR[1]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'    ! PRECES NO ES
                     Q:U_NR=GGK:U_NR
                     GET(Q_TABLE,Q:U_NR)
                     IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
                        Q:PVN[1]+=GGK:SUMMA
                        PUT(Q_TABLE)
                     ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                        SOURCE_FOR_50+=GGK:SUMMA
                     .
                     R55+=GGK:SUMMA
                  ELSE
                     K:U_NR=GGK:U_NR
                     GET(K_TABLE,K:U_NR)
                     IF ~ERROR() !D261..(KA) IR JÂBÛT JAU ATRASTAM, JA TÂDS IR
                        K:PVN[1]+=GGK:SUMMA
                        PUT(K_TABLE)
                     ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                        SOURCE_FOR_41+=GGK:SUMMA
                     .
                     R52+=GGK:SUMMA
                  .
               OF 5
               OROF 10
                  PPR[2]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                     Q:U_NR=GGK:U_NR
                     GET(Q_TABLE,Q:U_NR)
                     IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
                        Q:PVN[2]+=GGK:SUMMA
                        PUT(Q_TABLE)
                     ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                        SOURCE_FOR_51+=GGK:SUMMA
                     .
                     R56+=GGK:SUMMA
                  ELSE
                     K:U_NR=GGK:U_NR
                     GET(K_TABLE,K:U_NR)
                     IF ~ERROR() !D261..(KA) IR JÂBÛT JAU ATRASTAM, JA TÂDS IR
                        K:PVN[2]+=GGK:SUMMA
                        PUT(K_TABLE)
                     ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                        SOURCE_FOR_42+=GGK:SUMMA
                     .
                     R53+=GGK:SUMMA
                  .
               ELSE
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
                  SOURCE_FOR_41+=GGK:SUMMA   ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%(21%)
                  R52+=GGK:SUMMA
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
               R54+=GGK:SUMMA
!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!               R11+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R57+=GGK:SUMMA
             .
           .
      !************************ 0% un Neapliekamie darîjumi ********
        ELSIF GETKON_K(GGK:BKK,2,6) AND GGK:D_K='K' ! IR DEFINÇTI NEAPLIEKAMIE DARÎJUMI
           LOOP R#=1 TO 2
              IF KON:PVND[R#]
                 CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                 OF 43
                    R43 += GGK:SUMMA
                 OF 44                    
                    R44 += GGK:SUMMA
                 OF 45
                    R45 += GGK:SUMMA      ! ES PRECES
                 OF 46
                    R46 += GGK:SUMMA
                 OF 47
                    R47 += GGK:SUMMA      ! ES JAUNAS A/M
                 OF 48
                    R48 += GGK:SUMMA
                 OF 49
                    R49 += GGK:SUMMA
                 .
              .
           .
      !************************ MEKLÇJAM PRETKONTUS PRECÇM NO ES ********
        ELSIF GGK:BKK[1:3]='213' AND GGK:D_K='D' AND GETPAR_K(GGK:PAR_NR,0,20)='C' ! ES
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           Q:U_NR=GGK:U_NR
           CLEAR(Q:PVN)
           CLEAR(Q:SUMMA)
           GET(Q_TABLE,Q:U_NR)
           IF ERROR()
              DO FILL_Q_TABLE
              ADD(Q_TABLE)
              SORT(Q_TABLE,Q:U_NR)
           ELSE
              DO FILL_Q_TABLE
              PUT(Q_TABLE)
           .
      !******** MEKLÇJAM 261,232..un 61... KONTUS KASES AP, PÂRB. VAI NAV CITU KONTÇJUMU ******
        ELSIF (GGK:BKK[1:3]='261' OR GGK:BKK[1:3]='232') AND GGK:D_K='D' ! VAR BÛT KASES AP
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           CLEAR(K:PVN)
           CLEAR(K:SUMMA)
           K:ANOTHER_K=FALSE
           GET(K_TABLE,K:U_NR)
           IF ERROR()
              K:U_NR=GGK:U_NR
              ADD(K_TABLE)
              SORT(K_TABLE,K:U_NR)
           .
        ELSIF GGK:BKK[1:2]='61' AND GGK:D_K='K' ! VAR BÛT 61... NO KASES AP
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           GET(K_TABLE,K:U_NR)
           IF ~ERROR()  ! D261 IR ATRASTS
              IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10
                 K:SUMMA[2]+=GGK:SUMMA
              ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21
                 K:SUMMA[1]+=GGK:SUMMA
              ELSE
                 KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' '&GGK:BKK)
                 K:SUMMA[1]+=GGK:SUMMA       ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%(21%)
                 K:ANOTHER_K=TRUE            ! LABÂK RÇÍINÂSIM ANALÎTISKI
              .
              PUT(K_TABLE)
           .
        ELSIF GGK:D_K='K' ! CITI K KONTÇJUMI
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           GET(K_TABLE,K:U_NR)
           IF ~ERROR()  
              K:ANOTHER_K=TRUE
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
  IF TODAY() > B_DAT+15 AND ~(CL_NR=1237) !GROSAM ÐITAIS NEPATÎK
     DATUMS=B_DAT+15
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!    R41=(R52*100)/18                               ! ANALÎTISKI 18%
!    R42=(R53*100)/5                                ! ANALÎTISKI  5%
    GET(K_TABLE,0)
    LOOP I# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
!       STOP(K:PVN[1] &' '& K:SUMMA[1] &' '& K:ANOTHER_K)
       IF K:PVN[1] AND K:SUMMA[1] AND ~K:ANOTHER_K !IR PVN 18%21%,ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
          R41+=K:SUMMA[1]
       ELSE
          SOURCE_FOR_41+=K:PVN[1]
       .
       IF K:PVN[2] AND K:SUMMA[2] AND ~K:ANOTHER_K !IR PVN 5%10%,ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
          R42+=K:SUMMA[2]
       ELSE
          SOURCE_FOR_42+=K:PVN[2]
       .
    .
    R41+=(SOURCE_FOR_41*100)/PPR[1]                ! ANALÎTISKI 18% ES
    R42+=(SOURCE_FOR_42*100)/PPR[2]                ! ANALÎTISKI  5% ES
    GET(Q_TABLE,0)
    LOOP I# = 1 TO RECORDS(Q_TABLE)
       GET(Q_TABLE,I#)
       IF Q:PVN[1]                                 !IR 18%
!          stop('pvn='&Q:PVN[1]&' '&Q:SUMMA[1]&'DELTA18='&(Q:SUMMA[1]/100)*18-Q:PVN[1])
          IF INRANGE((Q:SUMMA[1]/100)*18-Q:PVN[1],-0.005,0.005) !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R50+=Q:SUMMA[1]
          ELSE
             SOURCE_FOR_50+=Q:PVN[1]
          .
       .
       IF Q:PVN[2]                                  !IR 5%
!          stop('pvn='&Q:PVN[2]&' DELTA5='&(Q:SUMMA[2]/100)*18-Q:PVN[2])
          IF INRANGE((Q:SUMMA[2]/100)*5-Q:PVN[2],-0.005,0.005)  !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R51+=Q:SUMMA[2]
          ELSE
             SOURCE_FOR_51+=Q:PVN[2]
          .
       .
    .
    R50+=(SOURCE_FOR_50*100)/18               ! ANALÎTISKI 18% ES
    R51+=(SOURCE_FOR_51*100)/5                ! ANALÎTISKI  5% ES

    IF S_DAT >= DATE(1,1,2006) !MKN 42
       R40=R41+R42+R43+R49
       NOT1='Ministru kabineta'
       NOT2='2006.gada 10.janvâra'
       NOT3='noteikumiem Nr.42'
    ELSIF S_DAT >= DATE(7,1,2005) !VID RÎKOJUMS N1414
       R40=R41+R42+R43+R49
       NOT1='ar Valsts ieòçmumu dienesta'
       NOT2='2005.gada 12.jûlija rîkojumu Nr.1414'
       NOT3='apstiprinâtajiem metodiskajiem norâdîjumiem'
    ELSE
       R40=R41+R42+R43+R49+R50+R51
       NOT1='Ministru kabineta'
       NOT2='2004.g.13.janvâra'
       NOT3='noteikumiem Nr 29'
    .
    IF R40=0                                 ! VISPÂR NAV BIJUÐI IEÒÇMUMI
!       PROP=100                              ! PROPORCIJA
       PROP=0                                ! PROPORCIJA
    ELSE
!       PROP=ROUND((R41+R42+R43)/(R41+R42+R43+R49)*100,.01) ! PROPORCIJA
        IF SYS:D_PR='N'
           PROP=0
        ELSE
           PROP=ROUND(R49/R40*100,.01) ! PROPORCIJA
        .
    .
    R60=R61+R62+R63+R64+R65
!    R66=ROUND(R60*(100-PROP)/100,.01)
    R66=ROUND(R60*PROP/100,.01)
    IF MINMAXSUMMA                           !KOKMATERIÂLI
       IF MINMAXSUMMA>0
          R58=MINMAXSUMMA
       ELSE
          R68=ABS(MINMAXSUMMA)
       .
    .
    PP=R60-R66+R67+R68                       !
    SS=R52+R53+R54+R55+R56+R57+R58           !
    IF PP > SS
      R70=PP-SS
      R80=0
    ELSE
      R80=SS-PP
      R70=0
    .
    IF ~(R43=R44+R45+R46+R47+R48)
       KLUDA(0,'Kontu plânâ nepereizi norâdîti rindu kodi (43,44-48)')
    .
    IF R52 AND ~INRANGE(R52/R41*100-18,-0.5,0.5)
       KLUDA(85,R52/R41*100 &'% (18%)')
    .
    IF R53 AND ~INRANGE(R53/R42*100-5,-0.5,0.5)
       KLUDA(85,R53/R42*100 &'% (5%)')
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE='KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'&CHR(9)&'40'&CHR(9)&FORMAT(R40,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 18% apliekamie darîjumi (arî paðpatçriòð)'&CHR(9)&'41'&CHR(9)&FORMAT(R41,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 5% apliekamie darîjumi (arî paðpatçriòð)'&CHR(9)&'42'&CHR(9)&FORMAT(R42,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 0% apliekamie darîjumi, t.sk.:'&CHR(9)&'43'&CHR(9)&FORMAT(R43,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' darîjumi, kas veikti brîvostâs un SEZ'&CHR(9)&'44'&CHR(9)&FORMAT(R44,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' uz ES dalîbvalstîm piegâdâtâs preces'&CHR(9)&'45'&CHR(9)&FORMAT(R45,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' citâs ES dalîbvalstîs uzstâdîtâs vai montçtas preces'&CHR(9)&'46'&CHR(9)&FORMAT(R46,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'&CHR(9)&'47'&CHR(9)&FORMAT(R47,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' par sniegtajiem pakalpojumiem'&CHR(9)&'48'&CHR(9)&FORMAT(R48,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar PVN neapliekamie darîjumi'&CHR(9)&'49'&CHR(9)&FORMAT(R49,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (18%)'&CHR(9)&'50'&CHR(9)&FORMAT(R50,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (5%)'&CHR(9)&'51'&CHR(9)&FORMAT(R51,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='APRÇÍINÂTAIS PVN (latos)'
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 18% apliekamiem darîjumiem'&CHR(9)&CHR(9)&CHR(9)&'52'&CHR(9)&FORMAT(R52,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 5% apliekamiem darîjumiem'&CHR(9)&CHR(9)&CHR(9)&'53'&CHR(9)&FORMAT(R53,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par saòemtajiem pakalpojumiem'&CHR(9)&CHR(9)&CHR(9)&'54'&CHR(9)&FORMAT(R54,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 18% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&CHR(9)&CHR(9)&'55'&CHR(9)&FORMAT(R55,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 5% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&CHR(9)&CHR(9)&'56'&CHR(9)&FORMAT(R56,@N-_12.2B)
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE='PRIEKÐNODOKLIS (latos), no tâ:'&CHR(9)&'60'&CHR(9)&FORMAT(R60,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'&CHR(9)&'61'&CHR(9)&FORMAT(R61,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'&CHR(9)&'62'&CHR(9)&FORMAT(R62,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu'&CHR(9)&'63'&CHR(9)&FORMAT(R63,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='aprçíinâtais priekðnodoklis par precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'64'&CHR(9)&FORMAT(R64,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='zemnieku saimniecîbâm izmaksâtâ PVN 12% kompensâcija'&CHR(9)&'65'&CHR(9)&FORMAT(R65,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Neatskaitâmais priekðnodoklis'&CHR(9)&'66'&CHR(9)&FORMAT(R66,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Korekcijas (atskaitâmais priekðnodoklis vai aprçíinâtais nodoklis)'&CHR(9)&'67'&CHR(9)&FORMAT(R67,@N-_12.2B)&CHR(9)&'57'&CHR(9)&FORMAT(R57,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Aprçíinâtais nodoklis vai atskaitâmais priekðnodoklis saskaòâ ar likuma 13.2.p.'&CHR(9)&'68'&CHR(9)&FORMAT(R68,@N-_12.2B)&CHR(9)&'58'&CHR(9)&FORMAT(R58,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPSUMMA:'&CHR(9)&'[P]'&CHR(9)&FORMAT(PP,@N-_12.2B)&CHR(9)&'[S]'&CHR(9)&FORMAT(SS,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'
        ADD(OUTFILEANSI)
        OUTA:LINE='attiecinâmâ nodokïa summa, ja P>S'&CHR(9)&'70'&CHR(9)&FORMAT(R70,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='budþetâ maksâjamâ nodokïa summa, ja P<S'&CHR(9)&CHR(9)&CHR(9)&'80'&CHR(9)&FORMAT(R80,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'APSTIPRINU PVN APRÇÍINU:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atbildîgâ persona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Uzvârds:'&CHR(9)&SYS:PARAKSTS1&CHR(9)&CHR(9)&'Datums: '&format(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Paraksts:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'VID atbildîgâ amatpersona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&KKK&CHR(9)&'R:'&CHR(9)&RS
        ADD(OUTFILEANSI)
    END
    IF F:XML_OK#=TRUE
       LOOP I#=40 TO 68+4
          EXECUTE I#-40+1
             RI=R40
             RI=R41
             RI=R42
             RI=R43
             RI=R44
             RI=R45
             RI=R46
             RI=R47
             RI=R48
             RI=R49
             RI=R50
             RI=R51
             RI=R52
             RI=R53
             RI=R54
             RI=R55
             RI=R56
             RI=R57
             RI=R58
             RI=0    !ÐITÂDAS RINDAS NAV
             RI=R60
             RI=R61
             RI=R62
             RI=R63
             RI=R64
             RI=R65
             RI=R66
             RI=R67
             RI=R68
             RI=PP
             RI=SS
             RI=R70
             RI=R80
          .
          CASE I#
          OF 69
             J#=98
          OF 70
             J#=99
          OF 71
             J#=70
          OF 72
             J#=80
          ELSE
             J#=I#
          .
          IF ~RI THEN CYCLE.
          XML:LINE='<<Row>'
          ADD(OUTFILEXML)
          XML:LINE='<<Field name="rinda" value="'&J#&'" />'
          ADD(OUTFILEXML)
          XML:LINE='<<Field name="vertiba" value="'&CUT0(RI,2,2,1,1)&'" />'
          ADD(OUTFILEXML)
! pçc R44 vçl var bût "atk_kods" value=
!                     "sez_summa" value=
          XML:LINE='<</Row>'
          ADD(OUTFILEXML)
       .
       XML:LINE='<</Declaration>'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationFile>'
       ADD(OUTFILEXML)
       CLOSE(OUTFILEXML)
    .
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


!-----------------------------------------------------------------------------
FILL_Q_TABLE ROUTINE
     Q:U_NR=GGK:U_NR
     IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10
        Q:SUMMA[2]+=GGK:SUMMA
     ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21
        Q:SUMMA[1]+=GGK:SUMMA
     ELSE
        KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
        Q:SUMMA[1]+=GGK:SUMMA !LIETOTÂJA KÏÛDA, PIEÒEMAM, KA 18%(21%)
     .

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
  FREE(Q_TABLE)
  FREE(K_TABLE)
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF <> 'W' THEN F:DBF='W'.
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!------------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
