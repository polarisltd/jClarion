                     MEMBER('winlats.clw')        ! This is a MEMBER module
SelfNom_k            PROCEDURE                    ! Declare Procedure
KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME
NOL_U_NR             LIKE(NOL:U_NR)
KON_NOS              STRING(3)
CHECKPAVSUMMA         DECIMAL(12,2)
NOL_SUMMA             DECIMAL(12,2)
PAV_SUMMA_LS          DECIMAL(12,2)
PAV_SUMMA_VAL         DECIMAL(12,2)
MULTIVAL             BYTE
PAV_D_K              LIKE(PAV:D_K)
STRINGBYTE           STRING(8)
ADDTIPS              BYTE
PUTPAVAD             BYTE
PUTNOLIK             BYTE
LASTONE              BYTE
!----------------------------------------
LocalRequest         LONG
LocalResponse        LONG
rakstsggk            byte
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,72),CENTER,TIMER(1),GRAY,DOUBLE
       STRING(@n_7),AT(49,2),USE(RecordsProcessed)
       PROGRESS,USE(Progress:Thermometer),AT(15,28,111,12),RANGE(0,100)
       STRING(''),AT(0,16,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,43,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,55,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  dat=today()
  lai=clock()
  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Paveikti'
  ProgressWindow{Prop:Text} = 'Nomenklatûru pârbûvçðana'
  ?Progress:UserString{Prop:Text}='Kopçju Nom_k->Nom_old'
  display
  CLOSE(nom_K)
  COPY(NOM_K,'NOM_OLD')
  IF ERROR()
     KLUDA(1,'/KOPÇT MOM_K')
     DO PROCEDURERETURN
  .
  FILENAME1='NOM_OLD'
  CHECKOPEN(NOM_K1,1)
  OPEN(NOM_K,12h)
  IF ERROR()
     KLUDA(1,'MOM_K')
     DO PROCEDURERETURN
  .
  ?Progress:UserString{Prop:Text}='Dzçðu Nom_k'
  display
  EMPTY(NOM_K)
  ?Progress:UserString{Prop:Text}='Analizçju Nom_old, bûvçju Nom_k'
  display
  SET(NOM_K1)
  LOOP
     NEXT(NOM_K1)
     IF ERROR()
        BREAK
     .
     NOM:RECORD=NOM1:RECORD
     GET(NOM_K,0)
     IF DUPLICATE(NOM_K)
        DUP#+=1
        ?Progress:UserString{Prop:Text}=DUP#&' DUPLICATE:'&NOM1:NOMENKLAT&' '&NOM1:NOS_S
        DISPLAY()
        STOP(DUP#&' DUPLICATE:'&NOM1:NOMENKLAT&' '&NOM1:NOS_S)
     ELSE
        ADD(NOM_K)
        IF ERROR() THEN STOP(NOM:NOMENKLAT&ERROR()).
     .
     RecordsProcessed += 1
     RecordsThisCycle += 1
     IF PercentProgress < 100
       PercentProgress = (RecordsProcessed / RecordsToProcess)*100
       IF PercentProgress > 100
         PercentProgress = 100
       END
       IF PercentProgress <> Progress:Thermometer THEN
         Progress:Thermometer = PercentProgress
         ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
         DISPLAY()
       END
     END
     DISPLAY
  .
  DO PROCEDURERETURN

!--------------------------------------------------------
PROCEDURERETURN        ROUTINE
  close(ProgressWindow)
  CLOSE(NOM_K1)
  CLOSE(NOM_K)
  RETURN
PAS_Invoice          PROCEDURE                    ! Declare Procedure
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
RPT_GADS             STRING(4)
DATUMS               STRING(2)
gov_reg              STRING(37)
RPT_CLIENT           STRING(45)
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

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLPAS)
                       PROJECT(NOS:DATUMS)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:NOMENKLAT)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:VAL)
                       PROJECT(NOS:PAR_NR)
                       PROJECT(NOS:U_NR)
                     END
!-----------------------------------------------------------------------------

report REPORT,AT(146,400,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
detail0 DETAIL,AT(,,,1000)
       END
PAGE_HEAD DETAIL,AT(,,8031,2344)
         STRING(@s52),AT(417,573,4948,208),USE(adrese),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s11),AT(5469,573,1146,208),USE(BKODS),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(52,2031,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('We order following items'),AT(2500,2083,2604,260),USE(?String24),FONT(,14,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s60),AT(417,1458,5052,156),USE(adreseF),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(52,990,7813,0),USE(?Line5),COLOR(COLOR:Black)
         STRING(@s45),AT(417,156,4427,208),USE(RPT_client),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s11),AT(5469,156,1094,208),USE(reg_nr),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s13),AT(6615,156,1302,208),USE(fin_nr),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s31),AT(417,781,3021,208),USE(BANKA),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s31),AT(417,1615,2708,156),USE(par_banka),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s30),AT(417,1823,2708,156),USE(FAX),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s40),AT(417,1250,3854,156),USE(adrese1),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s18),AT(5260,1250,1510,156),USE(par_ban_nr),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s11),AT(6823,1250,990,156),USE(par_ban_kods),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s35),AT(417,1094,3333,156),USE(nos_p),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s37),AT(4635,1094,3125,156),USE(gov_reg),LEFT,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s47),AT(417,365,4479,208),USE(ju_adrese),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@s18),AT(5469,365,1823,208),USE(REK),LEFT,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
       END
PAGE_HEAD1 DETAIL,AT(,10,,333)
         LINE,AT(4010,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5990,52,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         STRING('Quantity'),AT(4115,104,1823,208),USE(?String38:2),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(1354,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(1771,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Nr'),AT(1406,104,365,208),USE(?String38),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Item No'),AT(1875,104,2083,208),USE(?String38:3),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(1354,313,4635,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(1354,52,4635,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,250)
         STRING(@s22),AT(1833,10,2135,156),USE(NOS_KATALOGA_NR),LEFT,FONT(,12,,,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,280),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@n-_11),AT(4219,10,1406,156),USE(NOS:daudzums),RIGHT,FONT(,12,,,CHARSET:BALTIC)
         LINE,AT(1354,208,4635,0),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,280),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,280),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,280),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s3),AT(1406,10,313,156),USE(RPT_npk),RIGHT,FONT(,12,,,CHARSET:BALTIC)
       END
BLANK  DETAIL,AT(,-10,,177)
         LINE,AT(4010,0,0,197),USE(?Line8:37),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,197),USE(?Line8:36),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,197),USE(?Line8:35),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,197),USE(?Line8:937),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(1354,0,0,115),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,115),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,115),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(1354,52,4635,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(4010,-10,0,197),USE(?Line8:13),COLOR(COLOR:Black)
         STRING(@n-_11),AT(4219,10,1406,156),USE(daudzumsK),RIGHT,FONT(,12,,,CHARSET:BALTIC)
         LINE,AT(5990,-10,0,197),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@s15),AT(1875,10,1969,156),USE(kopa),LEFT,FONT(,12,,,CHARSET:BALTIC)
         LINE,AT(1771,-10,0,197),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(1354,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(1354,52,4635,0),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,52),USE(?Line58:992),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11350,8000,52)
         LINE,AT(1354,0,4635,0),USE(?Line5:7),COLOR(COLOR:Black)
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
  OPEN(IZDRUKA)
  IF ~F:DBF THEN F:DBF='W'.
  DISPLAY
  ACCEPT
    CASE FIELD()
    OF ?OKButton
        BREAK
    OF ?CancelButton
        BREAK
    END
  END
  CLOSE(IZDRUKA)
  RPT_gads=year(pas:datums)
  datums=day(pas:datums)
  plkst=clock()
  KESKA = RPT_GADS&'. gada '&datums&'. '&MENVAR(pas:datums,2,2)
  GETMYBANK('')
  PAR:NOS_P=GETPAR_K(PAS:PAR_NR,2,2)
  IF PAR:FAX THEN FAX='FAX: '&PAR:FAX.
  RPT_CLIENT=CLIENT
  JU_ADRESE=GL:ADRESE
  ADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
  reg_nr=gl:reg_nr
  fin_nr=gl:VID_NR
  RPT_BANKA=BANKA
!         RPT:BKODS=BKODS
  RPT_REK  =REK
!  ATLAUJA =SYS:ATLAUJA
  NOS_P=GETPAR_K(PAS:PAR_NR,2,2)
  gov_reg=GETPAR_K(PAS:PAR_NR,0,9)
  ADRESE1=PAR:ADRESE
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
  ProgressWindow{Prop:Text} = 'Pasûtîjums'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLPAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOS:RECORD)                              !MAKE SURE RECORD CLEARED
      NOS:PAR_NR=PAS:PAR_NR
      NOS:DOK_NR=PAS:DOK_NR
      SET(NOS:PAR_KEY,NOS:PAR_KEY)                     !SET TO FIRST SELECTED RECORD
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
      IF F:DBF='W' OR F:DBF='N'
          SETTARGET(REPORT)
          IMAGE(156,156,2448,677,'USER.BMP')
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
          PRINT(RPT:DETAIL0)
          PRINT(RPT:PAGE_HEAD)
          PRINT(RPT:PAGE_HEAD1)
      ELSE
          IF ~OPENANSI('INVOICE.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=RPT_CLIENT&CHR(9)&REG_NR&CHR(9)&FIN_NR
          ADD(OUTFILEANSI)
          OUTA:LINE=JU_ADRESE&CHR(9)&REK
          ADD(OUTFILEANSI)
          OUTA:LINE=ADRESE&CHR(9)&BKODS
          ADD(OUTFILEANSI)
          OUTA:LINE=BANKA
          ADD(OUTFILEANSI)
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
          OUTA:LINE=NOS_P&CHR(9)&GOV_REG
          ADD(OUTFILEANSI)
          OUTA:LINE=ADRESE1&CHR(9)&PAR_BAN_NR&CHR(9)&PAR_BAN_KODS
          ADD(OUTFILEANSI)
          OUTA:LINE=ADRESEF
          ADD(OUTFILEANSI)
          OUTA:LINE=PAR_BANKA
          ADD(OUTFILEANSI)
          OUTA:LINE=FAX
          ADD(OUTFILEANSI)
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=' {15}WE ORDER FOLLOWING ITEMS'
          ADD(OUTFILEANSI)
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
          OUTA:LINE='NR'&CHR(9)&'ITEM NO {10}'&CHR(9)&'QUANTITY'
          ADD(OUTFILEANSI)
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF NOS:U_NR=PAS:U_NR
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
           IF F:DBF='N'
              NOS_KATALOGA_NR=NOS:NOMENKLAT
           ELSE
              NOS_KATALOGA_NR=NOS:KATALOGA_NR
           .
           IF F:DBF = 'W' OR F:DBF='N'
                PRINT(RPT:DETAIL)
           ELSE
                SUMM = NOS:DAUDZUMS
                OUTA:LINE=RPT_NPK&CHR(9)&NOS:KATALOGA_NR&CHR(9)&SUMM
                ADD(OUTFILEANSI)
           END
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
        Close(ProgressWindow)
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
  IF SEND(NOLPAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    kopa='Total:'
    IF F:DBF = 'W' OR F:DBF='N'
!!        PRINT(RPT:RPT_FOOT1)
        PRINT(RPT:RPT_FOOT2)                        !PRINT GRAND TOTALS
        PRINT(RPT:RPT_FOOT3)                        !PRINT GRAND TOTALS
    ELSE
        OUTA:LINE='-{130}'
        ADD(OUTFILEANSI)
        SUMM = DAUDZUMSK
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&SUMM
        ADD(OUTFILEANSI)
        OUTA:LINE='-{130}'
        ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    IF F:DBF='W' OR F:DBF='N'
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
  IF F:DBF='W' OR F:DBF='N'
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
  IF ERRORCODE() OR ~(NOS:PAR_NR=PAS:PAR_NR AND NOS:DOK_NR=PAS:DOK_NR)
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
K_STATISTIKA PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
NOL_NR               BYTE
RecordFiltered       LONG
N_TABLE              QUEUE,PRE()
N:S_GADS             DECIMAL(4)
N:DAUDZUMI1          LONG
N:DAUDZUMI2          LONG
N:DAUDZUMI3          LONG
N:DAUDZUMI4          LONG
N:DAUDZUMI5          LONG
N:DAUDZUMI6          LONG
N:DAUDZUMI7          LONG
N:DAUDZUMI8          LONG
N:DAUDZUMI9          LONG
N:DAUDZUMI10         LONG
N:DAUDZUMI11         LONG
N:DAUDZUMI12         LONG
N:DKOPA              LONG
                     END
N_DKOPA              LONG
ATLIKUMS             DECIMAL(9,2)
ANALOGU_SKAITS       BYTE
TEK_NOMENKLAT        STRING(21)
SAV_NOMENKLAT        STRING(21)
NOM_I                STRING(21)
VIRZIENS             BYTE
A:TABLE              QUEUE,PRE()
A:PIEG               STRING(4)
A:cena               DECIMAL(7,2)
A:ATLIKUMITN         DECIMAL(5)
A:ATLIKUMI           DECIMAL(6)
A:D_PROJEKTS         DECIMAL(8,3)
A:PASUTITS           DECIMAL(7)
A:iet_daudzums       DECIMAL(7)
A:IEP_CENA           DECIMAL(7,2)
A:IEP_VAL            STRING(3)
A:IZDEVIGUMS         BYTE
A:UZC_PROC           DECIMAL(3)
A:REA_CENA           DECIMAL(7,2)
A:KATALOGA_NR        STRING(17)
A:NOS_P              STRING(50)
A:NOMENKLAT          STRING(21)
                     END
A_PAS_DAUDZUMS       DECIMAL(8,3)
PAS_U_NR             ULONG
PAS_SUMMA            DECIMAL(11,2)
PAS_SUMMAV           DECIMAL(11,2)
CENA                 DECIMAL(9,2)
CEN_VAL              STRING(3)
MAT                  BYTE
DAUDZUMS             DECIMAL(9,2)
MAXACENA             DECIMAL(9,2)
P_TABLE              QUEUE,PRE()
P:DATUMS             LONG
P:DOK_NR             ULONG
P:KOMENTARS          STRING(20)
P:U_NR               ULONG
                     END
B:TABLE              QUEUE,PRE()
B:PIEG               STRING(4)
B:1                  DECIMAL(6)
B:2                  DECIMAL(6)
B:3                  DECIMAL(6)
B:4                  DECIMAL(6)
B:5                  DECIMAL(6)
B:6                  DECIMAL(6)
B:7                  DECIMAL(6)
B:8                  DECIMAL(6)
B:9                  DECIMAL(6)
B:10                 DECIMAL(6)
B:11                 DECIMAL(6)
B:12                 DECIMAL(6)
B:13                 DECIMAL(6)
B:14                 DECIMAL(6)
B:15                 DECIMAL(6)
B:16                 DECIMAL(6)
B:17                 DECIMAL(6)
B:18                 DECIMAL(6)
B:19                 DECIMAL(6)
B:20                 DECIMAL(6)
B:21                 DECIMAL(6)
B:22                 DECIMAL(6)
B:23                 DECIMAL(6)
B:24                 DECIMAL(6)
B:25                 DECIMAL(6)
B:NOMENKLAT          STRING(21)
                     END
A_IET_DAUDZUMSK      LONG
A_IET_DAUDZUMS       LONG
F:REDZAMIBA          BYTE
F:MAT                BYTE
F:MATREZ             BYTE
F:IPD                BYTE
VIDMAX               STRING(1)
F:RAZOTAJS           STRING(3)
F_TEK                CSTRING(120)
PASwindow WINDOW('Veidojam pasûtîjumu'),AT(,,162,51),GRAY
       STRING(@s21),AT(7,8),USE(A:NOMENKLAT)
       ENTRY(@N-_11.3),AT(97,6),USE(A_PAS_DAUDZUMS)
       BUTTON('Pas no &GAG'),AT(5,25),USE(?ButtonGAG)
       IMAGE('CHECK3.ICO'),AT(59,24,14,15),USE(?Imagegag),HIDE
       BUTTON('&OK'),AT(77,24),USE(?OK),DEFAULT
       BUTTON('&Atlikt'),AT(112,24),USE(?Atlikt)
     END

PASTABLE WINDOW('Norâdiet Pasûtîjumu'),AT(,,185,92),GRAY
       LIST,AT(7,7,174,66),USE(?ListP),FORMAT('48L|~Datums~C@d6@33L|~Dok_nr~L(1)@n_7@7L|~Komentârs~L(1)@s20@'), |
           FROM(P_TABLE)
       BUTTON('&OK'),AT(108,77,35,14),USE(?OkP),DEFAULT
       BUTTON('Atlikt'),AT(145,77,36,14),USE(?CancelP)
     END


FiltrsScreen WINDOW('Redzamîba'),AT(,,235,106),GRAY
       OPTION('Parâdît uz ekrâna'),AT(4,14,129,51),USE(F:REDZAMIBA),BOXED
         RADIO('Aktîvâs nomenklatûras'),AT(13,37),USE(?F:REDZAMIBA:Radio1),VALUE('0')
         RADIO('Visas nomenklatûras'),AT(13,27),USE(?F:REDZAMIBA:Radio2),VALUE('1')
         RADIO('Aktîvâs un nâkotnes nomenkl.'),AT(13,48),USE(?F:REDZAMIBA:Radio3),VALUE('2')
       END
       OPTION('Parâdît uz ekrâna'),AT(136,15,94,41),USE(F:ATBILDIGAIS),BOXED
         RADIO('Atbildîbâ esoðâs'),AT(145,28),USE(?F:ATBILDIGAIS:Radio1),VALUE('1')
         RADIO('Visas nomenklatûras'),AT(145,39),USE(?F:ATBILDIGAIS:Radio2),VALUE('0')
       END
       STRING('Filtrs pçc raþotâja :'),AT(14,77),USE(?String1)
       ENTRY(@s3),AT(80,76,27,12),USE(F:RAZOTAJS),UPR
       BUTTON('&OK'),AT(185,84,43,14),USE(?OkBUTTON:F),DEFAULT
     END


!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:PAS:U_NR   LIKE(PAV:U_NR)
Update::Reloop  BYTE
Update::Error   BYTE
History::STAT:Record LIKE(STAT:Record),STATIC
SAV::STAT:Record     LIKE(STAT:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Realizâcijas statistika / Pasûtîjumu veidoðana'),AT(0,0,463,297),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateNOL_KOPS'),SYSTEM,GRAY,RESIZE,MDI
                       STRING(@n4),AT(440,1),USE(GADS)
                       BUTTON('Filtrs'),AT(8,3,36,14),USE(?ButtonFiltrs)
                       BUTTON('N&omenklatûra'),AT(47,3,49,14),USE(?ButtonNom)
                       ENTRY(@s21),AT(102,4,101,12),USE(TEK_NOMENKLAT),LEFT(1),FONT('Fixedsys',,,FONT:regular),OVR,UPR
                       STRING('Atlikums sistçmâ ðobrîd :'),AT(207,7),USE(?String155)
                       STRING(@n_9.2),AT(288,7),USE(ATLIKUMS),LEFT(1)
                       BUTTON('&Iepriekðçjâ'),AT(333,5,45,14),USE(?ButtonPrevious)
                       BUTTON('&Nâkoðâ'),AT(381,5,45,14),USE(?ButtonNext)
                       BUTTON('&Realizâcija izvçlçtajai'),AT(4,278,77,14),USE(?RealKonkr)
                       BUTTON('&Atlikumi noliktavâs'),AT(85,278,78,14),USE(?ButtonAtlikumi)
                       BUTTON('&Matemâtika'),AT(169,278,50,14),USE(?ButtonMatematika)
                       IMAGE('CHECK3.ICO'),AT(226,277,17,18),USE(?ImageMAT),HIDE
                       BUTTON('&Pievienot Pasûtîjumam'),AT(303,278,87,14),USE(?DaudzumsUnPievienot),DEFAULT
                       BUTTON('&Beigt'),AT(393,278,45,14),USE(?Cancel)
                       LIST,AT(5,151,451,125),USE(?LIST2),VSCROLL,COLOR(0CCFFCCH),MSG('Browsing Records'),FORMAT('38R(1)|M~Gads~C(0)@n4b@30R(1)|M~1-Jan.~C(0)@n-_6b@30R(1)|M~2-Feb.~C(0)@n-_6b@30R' &|
   '(1)|M~3-Mar.~C(0)@n-_6b@30R(1)|M~4-Apr.~C(0)@n-_6b@30R(1)|M~5-Mai.~C(0)@n-_6b@30' &|
   'R(1)|M~6-Jûn.~C(0)@n-_6b@30R(1)|M~7-Jûl.~C(0)@n-_6b@30R(1)|M~8-Aug.~C(0)@n-_6b@3' &|
   '0R(1)|M~9-Sep.~C(0)@n-_6b@30R(1)|M~10-Okt.~C(0)@n-_6b@30R(1)|M~11-Nov.~C(0)@n-_6' &|
   'b@30R(1)|M~12-Dec.~C(0)@n-_6b@25R(1)|M~Kopâ~C(0)@n-_8b@'),FROM(N_TABLE)
                       SHEET,AT(4,23,452,127),USE(?Sheet1)
                         TAB('Analogi'),USE(?Tab1)
                           STRING('Jâpasûta kopâ:'),AT(126,25),USE(?String4)
                           STRING(@n-_9),AT(178,25),USE(A_IET_DAUDZUMSK)
                           LIST,AT(7,39,445,108),USE(?List1),COLOR(0CCFFCCH),FORMAT('20R(1)|M~Pieg.~C(0)@s4@33R(1)|M~Cena~C(0)@n-_10.2b@29R(1)|M~Atl.TN~C(0)@n-_7b@30' &|
   'R(1)|M~Atl.~C(0)@n-_7b@35R(1)|M~D Proj.~C(0)@n-_7b@30R(1)|M~Pas.~C(0)@n-_7b@31R(' &|
   '1)|M~Jâpas.~C(0)@n-_7b@40R(1)|M~Iep.Cena~C(0)@n-_10.2B@19R(1)|M~Val~C(0)@s3@20R(' &|
   '1)|M~Izd.%~C(0)@n3B@27R(1)|M~Uzc.%~C(0)@n-4.0B@40R(1)|M~Real.C~C(0)@n-_7.2B@41R(' &|
   '1)|M~Kataloga Nr~C(0)@s17@55L(1)|M~Nosaukums~C(0)@s50@'),FROM(A:TABLE)
                         END
                         TAB('Atlikumi'),USE(?Tab2)
                           LIST,AT(6,39,444,109),USE(?List3),COLOR(0CCFFCCH),FORMAT('20R|M~Pieg.~C@s4@24R|M~1~C@n-_6B@23R|M~2~C@n-_6B@24R|M~3~C@n-_6B@24R|M~4~C@n-_6B' &|
   '@24R|M~5~C@n-_6B@24R|M~6~C@n-_6B@24R|M~7~C@n-_6B@24R|M~8~C@n-_6B@24R|M~9~C@n-_6B' &|
   '@24R|M~10~C@n-_6B@24R|M~11~C@n-_6B@24R|M~12~C@n-_6B@24R|M~13~C@n-_6B@24R|M~14~C@' &|
   'n-_6B@24R|M~15~C@n-_6B@24R|M~16~C@n-_6B@24R|M~17~C@n-_6B@24R|M~18~C@n-_6B@24R|M~' &|
   '19~C@n-_6B@24R|M~20~C@n-_6B@24R|M~21~C@n-_6B@24R|M~22~C@n-_6B@24R|M~23~C@n-_6B@2' &|
   '4R|M~24~C@n-_6B@24R|M~25~C@n-_6B@'),FROM(B:TABLE)
                         END
                       END
                     END
DIENAS1         BYTE
DIENAS2         BYTE
PIEAUGUMS       BYTE
x_date          LONG
R_date          LONG
REALINT1        REAL              !DIENÂ NÂKOTNÇ
REALINT2        REAL              !DIENÂ TAGAD
PARDOSIM1       DECIMAL(9,2)      !PIEPRASÎTAJÂ PERIODÂ NÂKOTNÇ
NEPARDOSIM      DECIMAL(9,2)      !NEPÂRDOSIM, KAMÇR ATNÂKS PRECE
PARDOSIM2       DECIMAL(9,2)      !PÂRDOSIM TO, KAS ÐOBRÎD IR PALICIS LÎDZ PRECES ATVEÐANAI
ATLIKUMS2       DECIMAL(9,2)      !ATLIKUMS UZ PRECES ATVEÐANAS BRÎDI PIE PAÐREIZÇJÂS REALIZÂCIJAS INTENSITÂTES
NOL_TEX1        STRING(40)
NOL_TEX2        STRING(40)
NOL_TEX         STRING(80)
MINATLIKUMS     DECIMAL(5)
A_ATLIKUMIK     DECIMAL(5)

PASUT WINDOW('Pasûtîjuma apjoma noteikðanas nosacîjumi'),AT(,,287,180),GRAY
       BUTTON('&Noliktavas'),AT(7,7,47,14),USE(?BN)
       STRING(@s55),AT(57,9,223,10),USE(NOL_TEX1),LEFT
       STRING(@s55),AT(57,20,223,10),USE(NOL_TEX2),LEFT
       STRING('Cik dienâm jânodroðina prece noliktavâ :'),AT(7,32,183,10),USE(?String11)
       ENTRY(@N3),AT(198,31),USE(DIENAS1),RIGHT(2)
       STRING('Pçc cik dienâm prece bûs noliktavâ :'),AT(7,46,183,10),USE(?String2)
       ENTRY(@n3),AT(198,45),USE(DIENAS2),RIGHT(2)
       STRING('Plânotais vidçjais pieaugums mçnesî :'),AT(7,60,183,10),USE(?String3)
       ENTRY(@N3),AT(198,59),USE(PIEAUGUMS),RIGHT(2)
       STRING('%'),AT(220,60,8,10),USE(?String5),CENTER
       STRING('No kura lîdz kuram MMYY  veikt '),AT(7,77,111,10),USE(?String44)
       OPTION(' '),AT(118,69,115,17),USE(vidmax),BOXED
         RADIO('Vidçjo'),AT(130,75),USE(?vidmax:Radio1),VALUE('V')
         RADIO('Maksimâlo'),AT(167,75),USE(?vidmax:Radio2),VALUE('M')
       END
       STRING('realizâcijas intensitâtes aprçíinu  :'),AT(9,89,123,10),USE(?String14)
       ENTRY(@D13),AT(161,88),USE(R_DATE)
       ENTRY(@D13),AT(194,88),USE(X_DATE)
       BUTTON('Ignorçt Pasûtîjumus un D-Proj.'),AT(4,153,112,14),USE(?ButtonIPD)
       IMAGE('CANCEL4.ICO'),AT(122,153,17,16),USE(?ImageIPD),HIDE
       OPTION('Filtrs pçc rezultâta'),AT(4,99,212,51),USE(F:MATREZ),BOXED
         RADIO('Nav'),AT(9,108),USE(?F:MAT:Radio1),VALUE('0')
         RADIO('Râdît, ja kâda ir  jâpasûta'),AT(9,117),USE(?F:MAT:Radio2),VALUE('1')
         RADIO('Râdît, ja ir  0 vai jâpasûta kopâ'),AT(9,126),USE(?F:MAT:Radio3),VALUE('2')
         RADIO('Râdît, ja ir jâpasûta kopâ vai 0 un atlikums << par'),AT(9,135),USE(?F:MAT:Radio4),VALUE('3')
       END
       ENTRY(@N_5),AT(179,135,22,12),USE(MINATLIKUMS)
       BUTTON('&OK'),AT(203,158,36,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(243,158,36,14),USE(?CancelButton)
     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  NOKL_CP=1
  LOOP I#=1 TO NOL_SK
     NOL_NR25[I#]=TRUE
  .
  NOL_TEX=FORMAT_NOLTEX25()
  NOL_TEX1=NOL_TEX[1:40]
  NOL_TEX2=NOL_TEX[41:80]
  F:IDP='' !IZMANTOJAM, LAI PASÛTÎTU NO GAG
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ! TEK_NOMENKLAT=getnom_k('OBLIGÂTI JÂIZSAUC',1,12)
   GLOBALREQUEST=SELECTRECORD
   BROWSENOL_STAT
   IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
      DO PROCEDURERETURN
   .
   TEK_NOMENKLAT=STAT:NOMENKLAT[1:17]
   DO FILLDATI
   SELECT(?LIST1,1)
  ! IF MAT
  !   UNHIDE(?ImageMAT)
  ! ELSE
  !   HIDE(?ImageMAT)
  ! .
  ! DISPLAY(?ImageMAT)
  CASE LocalRequest
  OF InsertRecord
    IF StandardWarning(Warn:InsertDisabled)
      DO ProcedureReturn
    END
  OF ChangeRecord
    IF StandardWarning(Warn:UpdateDisabled)
      DO ProcedureReturn
    END
  OF DeleteRecord
     IF StandardWarning(Warn:DeleteDisabled)
      DO ProcedureReturn
    END
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?GADS)
      IF F:ATBILDIGAIS
         F_TEK='Filtrs pçc atbildîgâ: '&ACC_KODS
      ELSE
         F_TEK='Filtrs pçc atbildîgâ: Nav'
      .
      IF F:REDZAMIBA=1
         F_TEK=F_TEK&'  Pçc redzamîbas: Nav'
      ELSIF F:REDZAMIBA=2
         F_TEK=F_TEK&'  Pçc redzamîbas: Aktîvâs & Nâkotnes'
      ELSE
         F_TEK=F_TEK&'  Pçc redzamîbas: Aktîvâs'
      .
      IF F:RAZOTAJS
         F_TEK=F_TEK&'  Pçc raþotâja: '&F:RAZOTAJS
      ELSE
         F_TEK=F_TEK&'  Pçc raþotâja: Nav'
      .
      
      QUICKWINDOW{PROP:TEXT}=F_TEK
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::STAT:Record = STAT:Record
        CASE LocalRequest
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?ButtonFiltrs
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(FILTRSSCREEN)
        DISPLAY
        ACCEPT
          CASE FIELD()
          OF ?OKButton:F
              BREAK
          END
        END
        CLOSE(FILTRSSCREEN)
        
        IF F:ATBILDIGAIS
           F_TEK='Filtrs pçc atbildîgâ: '&ACC_KODS
        ELSE
           F_TEK='Filtrs pçc atbildîgâ: Nav'
        .
        IF F:REDZAMIBA=1
           F_TEK=F_TEK&'  Pçc redzamîbas: Nav'
        ELSIF F:REDZAMIBA=2
           F_TEK=F_TEK&'  Pçc redzamîbas: Aktîvâs & Nâkotnes'
        ELSE
           F_TEK=F_TEK&'  Pçc redzamîbas: Aktîvâs'
        .
        IF F:RAZOTAJS
           F_TEK=F_TEK&'  Pçc raþotâja: '&F:RAZOTAJS
        ELSE
           F_TEK=F_TEK&'  Pçc raþotâja: Nav'
        .
        
        QUICKWINDOW{PROP:TEXT}=F_TEK
        display
      END
    OF ?ButtonNom
      CASE EVENT()
      OF EVENT:Accepted
        NOMENKLAT=TEK_NOMENKLAT
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNol_Stat 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           TEK_NOMENKLAT=STAT:NOMENKLAT[1:18]
           DO FILLDATI
           DISPLAY
        .
      END
    OF ?TEK_NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
            DO FILLDATI
      END
    OF ?ButtonPrevious
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        VIRZIENS=2
        DO MOVENOM_K
        !select(?List1)
      END
    OF ?ButtonNext
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        VIRZIENS=1
        DO MOVENOM_K
        !select(?List1)
      END
    OF ?RealKonkr
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GET(A:TABLE,CHOICE(?list1))
        TEK_NOMENKLAT=A:NOMENKLAT
        DO FILLDATI
        DISPLAY
        select(?List1)
      END
    OF ?ButtonAtlikumi
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GET(A:TABLE,CHOICE(?list1))
        ShowNomA(A:NOMENKLAT)
        select(?List1)
      END
    OF ?ButtonMatematika
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           OPEN(PASUT)
           IF ~X_DATE
              X_DATE=TODAY()
              R_DATE=TODAY()-60
           .
           IF ~VIDMAX THEN  VIDMAX='V'.      !Vidçjâ vai MAX realizâcija
           IF F:IPD THEN UNHIDE(?ImageIPD).  !Ignorçt Pasûtîjumus un D-projektus
           DISPLAY
           ACCEPT
             CASE FIELD()
             OF ?BN
                 CASE EVENT()
                 OF Event:ACCEPTED
                     Sel_Nol_Nr25
                     NOL_TEX=FORMAT_NOLTEX25()
                     NOL_TEX1=NOL_TEX[1:40]
                     NOL_TEX2=NOL_TEX[41:80]
                     DISPLAY(?NOL_TEX1,?NOL_TEX2)
                 END
             OF ?ButtonIPD
                 CASE EVENT()
                 OF Event:ACCEPTED
                    IF F:IPD
                       F:IPD=0
                       HIDE(?ImageIPD)
                    ELSE
                       F:IPD=1
                       UNHIDE(?ImageIPD)
                    .
                 .
             OF ?OKButton
                 CASE EVENT()
                 OF Event:ACCEPTED
                    MAT=1
                    BREAK
                 .
             OF ?CancelButton
                 CASE EVENT()
                 OF Event:ACCEPTED
                    MAT=0
                    F:MATREZ=0
                    BREAK
                 .
             END
             DISPLAY
           END
           CLOSE(PASUT)
           IF MAT
             X_DATE=DATE(MONTH(X_DATE)+1,1,YEAR(X_DATE))-1
             UNHIDE(?ImageMAT)
             DO FILLDATI
           ELSE
             HIDE(?ImageMAT)
           END
           DISPLAY(?ImageMAT)
      END
    OF ?DaudzumsUnPievienot
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        GET(A:TABLE,CHOICE(?list1))
        OPEN(PASWINDOW)
        A_PAS_DAUDZUMS=A:IET_DAUDZUMS
        IF F:IDP='1'
           UNHIDE(?IMAGEGAG)
        .
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?ButtonGAG
              CASE EVENT()
              OF EVENT:ACCEPTED
                 IF F:IDP
                    F:IDP=''
                    HIDE(?IMAGEGAG)
                 ELSE
                    F:IDP='1'
                    UNHIDE(?IMAGEGAG)
                 .
                 DISPLAY
              .
           OF ?OK
              CASE EVENT()
              OF EVENT:ACCEPTED
                 LOCALRESPONSE=REQUESTCOMPLETED
                 BREAK
              .
           OF ?Atlikt
              CASE EVENT()
              OF EVENT:ACCEPTED
                 LOCALRESPONSE=REQUESTCANCELLED
                 BREAK
              .
           .
        .
        CLOSE(PASWINDOW)
        IF  LOCALRESPONSE=REQUESTCOMPLETED
           PAS_U_NR=0
           IF A_PAS_DAUDZUMS
              CHECKOPEN(PAR_K,1)
              CLEAR(PAR:RECORD)
              IF F:IDP  !PIEPRASÎTS PASÛTÎT NO GAG
                 PAR:NOS_U='GAG'
              ELSE
                 PAR:NOS_U=A:NOMENKLAT[19:21]
              .
              GET(PAR_K,PAR:NOS_U_KEY)
              IF ERROR()
                 KLUDA(120,'Partneris ar raþotâja kodu: '&par:nos_u)
                 BREAK
              ELSE
                 PAR_NR=PAR:U_NR
              .
              CLEAR(PAS:RECORD)
              PAS:PAR_NR=PAR_NR
              SET(PAS:PAR_KEY,PAS:PAR_KEY)
              LOOP
                 NEXT(PAVPAS)
                 IF ERROR() OR ~(PAS:PAR_NR=PAR_NR) THEN BREAK.
                 IF PAS:RS='S'  THEN CYCLE.       !TIKAI, KAS VÇL NAV SLÇGTI
                 IF ~(PAS:TIPS='L') THEN CYCLE.   !TIKAI LIELIE PASÛTÎJUMI
                 PAS_U_NR=PAS:U_NR
                 P:DATUMS=PAS:DATUMS
                 P:DOK_NR=PAS:DOK_NR
                 P:KOMENTARS=PAS:KOMENT
                 P:U_NR=PAS:U_NR
                 ADD(P_TABLE)
              .
              IF ~PAS_U_NR                    !IEVADAM JAUNU
                 DO AUTONUMBER
                 IF Localresponse=REQUESTCOMPLETED
                    PAS_U_NR=PAS:U_NR
                 .
              ELSIF RECORDS(P_TABLE)>1
                 OPEN(PASTABLE)
                 GET(P_TABLE,1)
                 SELECT(?LISTP)
                 DISPLAY
                 ACCEPT
                    CASE FIELD()
                    OF ?OKP
                       CASE EVENT()
                          OF EVENT:Accepted
                          GET(P_TABLE,CHOICE(?listP))
                          PAS_U_NR=P:U_NR
                          BREAK
                       .
                    OF ?CANCELP
                       PAS_U_NR=0
                       BREAK
                    .
                 .
                 CLOSE(PASTABLE)
              END
              FREE(P_table)
              IF PAS_U_NR
                 CLEAR(PAS:RECORD)
                 PAS:U_NR=PAS_U_NR
                 GET(PAVPAS,PAS:NR_KEY)
                 PAS_SUMMA =PAS:SUMMA
                 PAS_SUMMAV=PAS:SUMMAV
                 CHECKOPEN(CENUVEST,1)
                 CLEAR(CEN:RECORD)
                 CENA=0
                 CEN_VAL=''
                 CEN:KATALOGA_NR=A:KATALOGA_NR
                 CEN:NOS_U=A:NOMENKLAT[19:21]
                 SET(CEN:KAT_KEY,CEN:KAT_KEY)
                 LOOP
                    NEXT(CENUVEST)
                    IF ERROR() OR ~(CEN:KATALOGA_NR=A:KATALOGA_NR AND CEN:NOS_U=A:NOMENKLAT[19:21]) THEN BREAK.
                    CENA=CEN:CENA
                    CEN_VAL=CEN:VALUTA
                 .
                 IF ~PAS:VAL AND ~CEN_VAL  !VÇL NAV DEFINÇTA P/Z VALÛTA UN NAV ATRASTA PÇDÇJÂ CENA
                    GLOBALREQUEST=SELECTRECORD
                    BROWSEVAL_K
                    IF GLOBALRESPONSE=REQUESTCOMPLETED
                       PAS:VAL=VAL:VAL
                    ELSE
                       PAS:VAL='EUR'
                    .
                 ELSIF PAS:VAL AND ~(PAS:VAL=CEN_VAL) !IR DEFINÇTA PASÛTÎJUMA VALÛTA UN ATÐÍIRÂS NO CENAS VALÛTAS
                    KLUDA(76,'ignorçju cenu: '&cena&' '&cen_val)
                    CENA=0
                 ELSE
                    PAS:VAL=CEN_VAL
                 .
                 CLEAR(NOS:RECORD)
                 NOS:U_NR=PAS_U_NR
                 NOS:DOK_NR=PAS:DOK_NR
                 NOS:DATUMS=PAS:DATUMS
                 NOS:PAR_NR=PAS:PAR_NR
                 NOS:PAR_KE=PAS:PAR_NR
                 NOS:NOL_NR=LOC_NR
                 NOS:NOMENKLAT=A:nomenklat
                 NOS:NOS_S=A:NOS_P[1:16]
                 NOS:kataloga_nr=A:kataloga_nr
                 NOS:DAUDZUMS=A_PAS_DAUDZUMS
                 NOS:SUMMAV=NOS:DAUDZUMS*CENA
                 NOS:VAL=PAS:VAL
                 NOS:SUMMA=NOS:SUMMAV*BANKURS(NOS:VAL,NOS:DATUMS,,1) ! TESTA KURSS
                 NOS:ACC_KODS=ACC_KODS
                 NOS:ACC_DATUMS=TODAY()
                 ADD(NOLPAS)
                 IF ERROR() THEN STOP('ADD NOLPAS '&ERROR()).
                 A:PASUTITS+=A_PAS_DAUDZUMS
                 A:IET_DAUDZUMS-=A_PAS_DAUDZUMS
                 IF A:IET_DAUDZUMS<0
                    A:IET_DAUDZUMS=0
                 .
                 PUT(A:TABLE)
                 PAS_SUMMA+=NOS:SUMMA
                 PAS_SUMMAV+=NOS:SUMMAV
              .
              PAS:SUMMA =PAS_SUMMA
              PAS:SUMMAV=PAS_SUMMAV
              IF RIUPDATE:PAVPAS()
                 KLUDA(54,'PAVPAS')
              .
           END
           PAR_NR=0
           A_PAS_DAUDZUMS=0
        .
        select(?List1)
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    OF ?Sheet1
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF CENUVEST::Used = 0
    CheckOpen(CENUVEST,1)
  END
  CENUVEST::Used += 1
  BIND(CEN:RECORD)
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
  IF NOL_STAT::Used = 0
    CheckOpen(NOL_STAT,1)
  END
  NOL_STAT::Used += 1
  BIND(STAT:RECORD)
  IF PAVPAS::Used = 0
    CheckOpen(PAVPAS,1)
  END
  PAVPAS::Used += 1
  BIND(PAS:RECORD)
  FilesOpened = True
  RISnap:NOL_STAT
  SAV::STAT:Record = STAT:Record
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('K_STATISTIKA','winlats.INI')
  WinResize.Resize
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
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
    CENUVEST::Used -= 1
    IF CENUVEST::Used = 0 THEN CLOSE(CENUVEST).
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
    NOL_STAT::Used -= 1
    IF NOL_STAT::Used = 0 THEN CLOSE(NOL_STAT).
    PAVPAS::Used -= 1
    IF PAVPAS::Used = 0 THEN CLOSE(PAVPAS).
  END
  IF WindowOpened
    INISaveWindow('K_STATISTIKA','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
!---------------------------------------------------------------------------------------------------------------
FILLDATI     ROUTINE
    I#=0
    K#=0
    ATLIKUMS=0
    A_ATLIKUMIK=0
    MAXACENA=0
    A_IET_DAUDZUMSK=0
    A_IET_DAUDZUMS =0     !0-sarakstâ visas 0 vai <0
    FREE(A:TABLE)
    FREE(B:TABLE)
    FREE(N_TABLE)
    CLEAR(STAT:RECORD)
    STAT:NOMENKLAT=TEK_NOMENKLAT[1:17]
    SET(STAT:NOM_KEY,STAT:NOM_KEY)
    LOOP
       NEXT(NOL_STAT)
       IF ERROR() OR ~(STAT:NOMENKLAT[1:17]=TEK_NOMENKLAT[1:17]) THEN BREAK.

!------------AIZPILDAM STATISTIKU TABULÂ ------------------

       IF STAT:NOMENKLAT[1:len(CLIP(TEK_nomenklat))]=TEK_NOMENKLAT   !TEK_NOMENKLAT: 17 VAI 21 ZÎME
          DAUDZUMS=0
          REALINT1=0
          LOOP G#=1 TO 15      !15 GADI SABÂZTI STATISTIKÂ
             N_DKOPA=0
             LOOP M#= 1 TO 12  !12 MÇNEÐI SABÂZTI STATISTIKÂ
                N_DKOPA+=STAT:DAUDZUMS[M#,G#]
                IF INRANGE(DATE(M#,1,1995+G#),R_DATE,X_DATE) AND MAT
                   DAUDZUMS+=STAT:DAUDZUMS[M#,G#]
                   IF VIDMAX='M'  !MAX PERIODÂ
                      IF STAT:DAUDZUMS[M#,G#]/(DATE(M#+1,1,G#)-DATE(M#,1,G#)) > REALINT1
                         REALINT1 = STAT:DAUDZUMS[M#,G#]/(DATE(M#+1,1,G#)-DATE(M#,1,G#))
                      .
                   .
                .
             .
             IF N_DKOPA        !Par ðo gadu vispâr kaut kas ir
                GET(N_TABLE,0)
                N:S_GADS=G#+1995     !PASAULES RADÎÐANA 1996.GADÂ
                GET(N_TABLE,N:S_GADS)
                IF ERROR()
                   N:DAUDZUMI1=STAT:DAUDZUMS[1,G#]
                   N:DAUDZUMI2=STAT:DAUDZUMS[2,G#]
                   N:DAUDZUMI3=STAT:DAUDZUMS[3,G#]
                   N:DAUDZUMI4=STAT:DAUDZUMS[4,G#]
                   N:DAUDZUMI5=STAT:DAUDZUMS[5,G#]
                   N:DAUDZUMI6=STAT:DAUDZUMS[6,G#]
                   N:DAUDZUMI7=STAT:DAUDZUMS[7,G#]
                   N:DAUDZUMI8=STAT:DAUDZUMS[8,G#]
                   N:DAUDZUMI9=STAT:DAUDZUMS[9,G#]
                   N:DAUDZUMI10=STAT:DAUDZUMS[10,G#]
                   N:DAUDZUMI11=STAT:DAUDZUMS[11,G#]
                   N:DAUDZUMI12=STAT:DAUDZUMS[12,G#]
                   N:DKOPA=N_DKOPA   
                   ADD(N_TABLE)
                   SORT(N_TABLE,N:S_GADS)
                ELSE
                   N:DAUDZUMI1+=STAT:DAUDZUMS[1,G#]
                   N:DAUDZUMI2+=STAT:DAUDZUMS[2,G#]
                   N:DAUDZUMI3+=STAT:DAUDZUMS[3,G#]
                   N:DAUDZUMI4+=STAT:DAUDZUMS[4,G#]
                   N:DAUDZUMI5+=STAT:DAUDZUMS[5,G#]
                   N:DAUDZUMI6+=STAT:DAUDZUMS[6,G#]
                   N:DAUDZUMI7+=STAT:DAUDZUMS[7,G#]
                   N:DAUDZUMI8+=STAT:DAUDZUMS[8,G#]
                   N:DAUDZUMI9+=STAT:DAUDZUMS[9,G#]
                   N:DAUDZUMI10+=STAT:DAUDZUMS[10,G#]
                   N:DAUDZUMI11+=STAT:DAUDZUMS[11,G#]
                   N:DAUDZUMI12+=STAT:DAUDZUMS[12,G#]
                   N:DKOPA+=N_DKOPA
                   PUT(N_TABLE)
                .
             .
          .
          IF VIDMAX='V'  !VIDÇJÂ PERIODÂ
             REALINT1=(DAUDZUMS/(X_DATE-R_DATE+1))*(1+PIEAUGUMS/100)   !DIENÂ NÂKOTNÇ
          ELSE           !MAX PERIODÂ
             REALINT1=REALINT1*(1+PIEAUGUMS/100)                       !DIENÂ NÂKOTNÇ
          .
          REALINT2=(DAUDZUMS/(X_DATE-R_DATE+1))                     !DIENÂ TAGAD
          PARDOSIM1=REALINT1*DIENAS1                                !PIEPRASÎTAJÂ PERIODÂ NÂKOTNÇ NO ÐODIENAS
          NEPARDOSIM=REALINT1*DIENAS2                               !NEPÂRDOSIM NÂKOTNÇ, KAMÇR ATNÂKS PRECE
          PARDOSIM2=REALINT2*DIENAS2                                !PÂRDOSIM TO, KAS ÐOBRÎD IR PALICIS,KAMÇR ATNÂKS PRECE
!          STOP(REALINT1&'  '&PARDOSIM1&' '&REALINT2&' '&PARDOSIM2&' '&NEPARDOSIM)

!-----AIZPILDAM ANALOGUS, JA MAINÎJIES NOM-IDENTIFIKÂTORS-------

!            F:        NAV               AKT                                    AKT&NÂK
          IF F:REDZAMIBA=1 OR (F:REDZAMIBA=0 AND STAT:REDZAMIBA=0) OR (F:REDZAMIBA=2 AND STAT:REDZAMIBA=0 OR STAT:REDZAMIBA=2)
             A:NOMENKLAT=STAT:NOMENKLAT
             A:PIEG=STAT:NOMENKLAT[18:21]
             B:NOMENKLAT=STAT:NOMENKLAT
             B:PIEG=STAT:NOMENKLAT[18:21]
             IF ~MAT
                A:ATLIKUMI=GETNOM_A(STAT:NOMENKLAT,5,0)      !SISTÇMÂ KOPÂ
             ELSE
                A:ATLIKUMI=0
                LOOP I#=1 TO NOL_SK
                   IF NOL_NR25[I#]=TRUE
                      A:ATLIKUMI+=GETNOM_A(STAT:NOMENKLAT,1,0,I#) !KAS NORÂDÎTS MATEMÂTIKÂ
                   .
                .
             .
             A_ATLIKUMIK+=A:ATLIKUMI
             IF A:ATLIKUMI='0' THEN A:ATLIKUMI=''.
             A:D_PROJEKTS=GETNOM_A(STAT:NOMENKLAT,6,0)    !SISTÇMÂ KOPÂ, POZICIONÇTS NOM_A
             LOOP I#=1 TO 25
                EXECUTE I#
                   B:1=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:2=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:3=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:4=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:5=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:6=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:7=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:8=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:9=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:10=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:11=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:12=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:13=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:14=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:15=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:16=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:17=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:18=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:19=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:20=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:21=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:22=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:23=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:24=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                   B:25=NOA:ATLIKUMS[I#]                   !-NOA:K_PROJEKTS[I#]
                .
             .
             A:ATLIKUMITN=GETNOM_A(STAT:NOMENKLAT,1,0,LOC_NR) !ATLIKUMS TEKOÐÂ NOLIKTAVÂ
             A:CENA=GETNOM_K(STAT:NOMENKLAT,0,7)          !POZICIONÇJAM NOM_K
   !--------KONTROL FILL
             IF ~STAT:KATALOGA_NR
                STAT:KATALOGA_NR=GETNOM_K(STAT:NOMENKLAT,0,14)
                IF STAT:KATALOGA_NR
                   PUT(NOL_STAT)
                .
             .
             A:KATALOGA_NR=STAT:KATALOGA_NR
             IF ~STAT:NOS_S
                STAT:NOS_S=NOM:NOS_S
                IF STAT:NOS_S
                   PUT(NOL_STAT)
                .
             .
             A:NOS_P=NOM:NOS_P
   !          A:NOS_S=STAT:NOS_S
             IF ~(STAT:REDZAMIBA=NOM:REDZAMIBA)
                STAT:REDZAMIBA=NOM:REDZAMIBA
                PUT(NOL_STAT)
             .
             IF ~(STAT:ATBILDIGAIS=NOM:ATBILDIGAIS)
                STAT:ATBILDIGAIS=NOM:ATBILDIGAIS
                PUT(NOL_STAT)
             .
   !------------------------
             IF ~(ATLAUTS[15]='2') !IEROBEÞOTA PIEEJA PASÛTÎJUMIEM
                A:UZC_PROC=NOM:PROC5
             ELSE
                A:UZC_PROC=0
             .
             A:IET_DAUDZUMS=0
             A:PASUTITS=0
             CHECKOPEN(NOLPAS,1)
             CLEAR(NOS:RECORD)
             NOS:NOMENKLAT=A:NOMENKLAT
             SET(NOS:NOM_KEY,NOS:NOM_KEY)
             LOOP
                NEXT(NOLPAS)
                IF ~(NOS:NOMENKLAT=A:NOMENKLAT) OR ERROR() THEN BREAK.
   !             IF NOS:RS='S' THEN CYCLE.  !SLÇGTS
                IF NOS:KEKSIS=3 THEN CYCLE. ! JAU KÏUVIS PAR D-PROJEKTU
                IF NOS:KEKSIS=4 THEN CYCLE. ! NAV UN NEBÛS
                CLEAR(PAS:RECORD)
                PAS:U_NR=NOS:U_NR
                GET(PAVPAS,PAS:NR_KEY)
                IF PAS:TIPS='L'
                   IF NOS:KEKSIS=2             ! DAÏÇJI IZPILDÎTS
                      A:PASUTITS+=NOS:DAUDZUMS-NOS:I_DAUDZUMS
                   ELSE                        ! 0 VAI 1 - GAIDA UZ D-PROJ. VAI ATTEIKTS
                      A:PASUTITS+=NOS:DAUDZUMS
                   .
                .
             .
   !
             CHECKOPEN(CENUVEST,1)
             CLEAR(CEN:RECORD)
             A:IEP_CENA=0
             A:IEP_VAL=''
             CEN:KATALOGA_NR=A:KATALOGA_NR
             CEN:NOS_U=A:NOMENKLAT[19:21]
             IF ~(ATLAUTS[15]='2') !IEROBEÞOTA PIEEJA PASÛTÎJUMIEM
                SET(CEN:KAT_KEY,CEN:KAT_KEY)
                LOOP
                   NEXT(CENUVEST)
                   IF ERROR() OR ~(CEN:KATALOGA_NR=A:KATALOGA_NR AND CEN:NOS_U=A:NOMENKLAT[19:21]) THEN BREAK.
                   A:IEP_CENA=CEN:CENA
                   A:IEP_VAL=CEN:VALUTA
                .
             .
             A:REA_CENA=A:IEP_CENA*BANKURS(A:IEP_VAL,0,,1)*(1+A:UZC_PROC/100)*(1+NOM:PVN_PROC/100) ! TESTA KURSS
             IF A:IEP_CENA*BANKURS(A:IEP_VAL,0,,1) > MAXACENA
                MAXACENA=A:IEP_CENA*BANKURS(A:IEP_VAL,0,,1)
             .
   !
             ADD(A:TABLE)
             ADD(B:TABLE)

             ATLIKUMS+=GETNOM_A(STAT:NOMENKLAT,5,0) !Kopçjais visu analogu atlikums

             IF MAT                                    !IR MATEMÂTIKA
                IF PARDOSIM1                           !KAUT KO PÂRDOSIM PIEPRASÎTAJÂ PERIODÂ NÂKOTNÇ NO ÐODIENAS
                   IF A:ATLIKUMI > PARDOSIM2           !JA UZ PRECES ATVEÐANAS BRÎDI BÛS VÇL KAUT KAS PALICIS
                      ATLIKUMS2=A:ATLIKUMI-PARDOSIM2
                   ELSE
                      ATLIKUMS2=0
                   .
                   IF F:IPD   !Ignorçt Pasûtîjumus un D-Projektus
                      A:IET_DAUDZUMS=PARDOSIM1-NEPARDOSIM-ATLIKUMS2
                   ELSE
                      A:IET_DAUDZUMS=PARDOSIM1-NEPARDOSIM-ATLIKUMS2-A:D_PROJEKTS-A:PASUTITS
                   .
                .
                IF A:IET_DAUDZUMS>0
                   A_IET_DAUDZUMS=1               !NO SARAKSTA KAUT KAS BÛS JÂPASÛTA
                .
                A_IET_DAUDZUMSK+=A:IET_DAUDZUMS
                PUT(A:TABLE)
             .
          .
       .
    .
    SORT(N_TABLE,-N:S_GADS)
    LOOP I#= 1 TO RECORDS(A:TABLE)
       GET(A:TABLE,I#)
       A:IZDEVIGUMS=(A:IEP_CENA*BANKURS(A:IEP_VAL,0,,1)/MAXACENA)*100 !%
!       STOP(A:IZDEVIGUMS&'='&A:IEP_CENA&'*'&BANKURS(A:IEP_VAL,0,,1)&'/'&MAXACENA)
       PUT(A:TABLE)
    .


!---------------------------------------------------------------------------------------------------------------
MOVENOM_K    ROUTINE
   CLEAR(STAT:RECORD)
   IF F:ATBILDIGAIS
      STAT:ATBILDIGAIS=ACC_KODS_N
      STAT:NOMENKLAT=TEK_NOMENKLAT
      SET(STAT:ATB_KEY,STAT:ATB_KEY)
   ELSE
      STAT:NOMENKLAT=TEK_NOMENKLAT
      SET(STAT:NOM_KEY,STAT:NOM_KEY)
   .
   LOOP
     EXECUTE VIRZIENS
        NEXT(NOL_STAT)
        PREVIOUS(NOL_STAT)
     .
!     STOP(STAT:NOMENKLAT&ERROR())
     IF ERROR() OR (F:ATBILDIGAIS AND ~(STAT:ATBILDIGAIS=ACC_KODS_N))
        KLUDA(0,'Sasniegtas meklçðanas beigas uz: '&STAT:NOMENKLAT)
        BREAK
     ELSIF ~(STAT:NOMENKLAT[1:17]=TEK_NOMENKLAT[1:17]) AND|
        (F:REDZAMIBA=1 OR (F:REDZAMIBA=0 AND STAT:REDZAMIBA=0) OR (F:REDZAMIBA=2 AND STAT:REDZAMIBA=0 OR STAT:REDZAMIBA=2)) AND|
        (~F:RAZOTAJS OR F:RAZOTAJS=STAT:NOMENKLAT[19:21])
        TEK_NOMENKLAT=STAT:NOMENKLAT[1:17]
        DO FILLDATI
!        stop(tek_nomenklat&' '&F:MATREZ&' '&A_IET_DAUDZUMS&' '&A_IET_DAUDZUMSK)

        IF ~F:MATREZ OR |                                                !('Nav')
        (F:MATREZ=1 AND A_IET_DAUDZUMS) OR |                             !('Râdît, ja kâda ir  jâpasûta')
        (F:MATREZ=2 AND A_IET_DAUDZUMSK>=0) OR |                         !('Râdît, ja ir  0 vai jâpasûta kopâ')
        (F:MATREZ=3 AND A_IET_DAUDZUMSK>0) OR |                          !('Râdît, ja ir jâpasûta kopâ
        (F:MATREZ=3 AND A_IET_DAUDZUMSK=0 AND A_ATLIKUMIK<MINATLIKUMS)   !  vai 0 un atlikums < par minatlikums')
           DISPLAY
           BREAK
        ELSE
           PREVIOUS(NOL_STAT) !NOSTÂJAMIES UZ PÇDÇJÂ BIJUÐÂ,JO FILLDATI PALIEK UZ NÂKOÐÂ STAT:NOMENKLAT[1:17]
        .
     .
   .
!---------------------------------------------------------------
AUTONUMBER ROUTINE
  LocalResponse = RequestCompleted
  CLEAR(PAS:Record)
  Auto::Attempts = 0
  LOOP
    SET(PAS:NR_KEY)
    PREVIOUS(PAVPAS)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVPAS')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAS:U_NR = 1
    ELSE
      Auto::Save:PAS:U_NR = PAS:U_NR + 1
    END
    CLEAR(PAS:RECORD)
    PAS:U_NR = Auto::Save:PAS:U_NR
    PAS:DATUMS=TODAY()
    PAS:RS=''
    PAS:VAL=''
    PAS:TIPS='L'
    PAS:PAR_NR=PAR:U_NR
    PAS:NOKA=PAR:NOS_S
    PAS:KEKSIS=0
    PAS:ACC_KODS=ACC_KODS
    PAS:ACC_DATUMS=TODAY()
    ADD(PAVPAS)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
  END
  DISPLAY()
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

