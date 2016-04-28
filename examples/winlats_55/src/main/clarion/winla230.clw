                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTK PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
par_filtrs           STRING(1)
SAV_PAR_FILTRS       STRING(1)
PAR_NOS_S            STRING(20)
window               WINDOW('Filtrs'),AT(,,135,215),CENTER,IMM,GRAY,MDI
                       BUTTON('Izlaist ar 0-es ESKN kodiem'),AT(5,19,96,14),USE(?Button0knk),HIDE
                       IMAGE('CHECK3.ICO'),AT(103,18,16,15),USE(?Image0knk),HIDE
                       STRING('Nomenklatûra:'),AT(7,34),USE(?S:nomenklat),HIDE
                       ENTRY(@s21),AT(5,45,89,9),USE(NOMENKLAT),HIDE,UPR
                       OPTION('Filtrs pçc partnera'),AT(5,58,119,70),USE(par_filtrs),BOXED,HIDE
                         RADIO('Visi'),AT(13,69),USE(?par_filtrs:Radio1),HIDE
                         RADIO('Konkrçts'),AT(14,101),USE(?par_filtrs:Radio2),HIDE
                       END
                       STRING('tips:'),AT(38,69,14,10),USE(?PromptTips),HIDE
                       STRING(@s6),AT(53,69),USE(PAR_TIPS),HIDE
                       BUTTON('&Mainît'),AT(81,67,39,12),USE(?MT),HIDE
                       PROMPT('Grupa:'),AT(19,82),USE(?PromptGRUPA),HIDE
                       ENTRY(@s7),AT(43,81,31,9),USE(PAR_GRUPA),HIDE,FONT('Fixedsys',,,,CHARSET:BALTIC)
                       STRING('1234567'),AT(45,91),USE(?StringPAR_GRUPA),HIDE,FONT('Fixedsys',,COLOR:Gray,FONT:regular,CHARSET:BALTIC)
                       BUTTON('&Mainît'),AT(62,100,39,12),USE(?MP),HIDE
                       STRING(@s20),AT(20,113),USE(PAR_NOS_S),HIDE
                       BUTTON('Analizçt arî neapstiprinâtâs'),AT(5,133,96,14),USE(?ButtonRs),HIDE
                       IMAGE('CHECK3.ICO'),AT(103,132,16,15),USE(?ImageRs),HIDE
                       OPTION('Izdrukas &Formâts'),AT(5,151,121,24),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(10,161),USE(?F:DBF:WMF),VALUE('W')
                         RADIO('Excel'),AT(81,161),USE(?F:DBF:EXCEL),VALUE('E')
                         RADIO('Word'),AT(43,161),USE(?F:DBF:WORD),VALUE('A')
                       END
                       BUTTON('D&rukas parametri'),AT(45,176,80,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('&OK'),AT(46,192,40,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(89,192,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ~F:DBF THEN F:DBF='W'.
  par_filtrs = 'V'
  IF par_nr=0 THEN PAR_NR=999999999.
  SAV_PAR_FILTRS = PAR_FILTRS
  PAR_GRUPA=''
  PAR_TIPS='EFCNIR'
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !
  !OPCIJA  1=1:NOMENKLATÛRA
  !        2=1:PARTNERIS V/T/G/1
  !          2:PARTNERIS V/T/G
  !          3:PARTNERIS GRUPA,TIPS UN VISI
  !        3=1:RS
  !        4=1 WMF/WORD
  !          2 WMF/EXCEL
  !          3 WMF/WORD/EXCEL
  !        5=?
  !        6=1:IZLAIST AR 0-ES ES KNK
  
  RS='A'
  LOOP I#=1 TO 8
     IF OPCIJA[I#] <> '0'
        EXECUTE I#
           BEGIN
              UNHIDE(?S:NOMENKLAT)                 !1: Filtrs pçc nomenklatûras
              UNHIDE(?NOMENKLAT)
           .
           BEGIN                                   !2: Filtrs pçc partnera
              UNHIDE(?PAR_FILTRS)
              unhide(?par_filtrs:Radio1)
              unhide(?par_filtrs:Radio2)
              UNHIDE(?PAR_TIPS)
              UNHIDE(?MT)
              unhide(?PromptGrupa)
              unhide(?par_grupa)
              UNHIDE(?StringPAR_GRUPA)
              UNHIDE(?PAR_NOS_S)
              IF ~(par_nr=999999999)
                  PAR_NOS_S=GETPAR_K(PAR_NR,0,1)
                  par_filtrs = 'K'
                  SAV_PAR_FILTRS = PAR_FILTRS
              .
              IF OPCIJA[I#]='2'                    !2:2-TIKAI KONKRÇTS ????
                  par_filtrs = 'K'
                  UNHIDE(?MP)
                  HIDE(?PAR_TIPS)
                  HIDE(?MT)
                  HIDE(?PAR_GRUPA)
                  HIDE(?StringPAR_GRUPA)
                  HIDE(?PAR_FILTRS:RADIO1)
                  HIDE(?PromptGRUPA)
              .
              IF OPCIJA[I#]='3'                    !2:3-GRUPA,TIPS UN VISI
                  HIDE(?PAR_FILTRS:RADIO2)
                  HIDE(?PAR_NOS_S)
                  par_nr=999999999
              .
              IF OPCIJA[I#]='4'                    !2:4-GRUPA UN VISI
                  HIDE(?PAR_TIPS)
                  HIDE(?MT)
                  HIDE(?PAR_FILTRS:RADIO2)
                  HIDE(?PAR_NOS_S)
                  par_nr=999999999
              .
           .
           BEGIN
  !           BIJA  3: ANALIZÇT ARÎ NEAPSTIPRINÂTÂS
           .
           BEGIN                                   !4: WMF/WORD/EXCEL
              UNHIDE(?F:DBF)
              CASE OPCIJA[I#]
              OF '1'                               !  WMF/WORD
                 HIDE(?F:DBF:EXCEL)
                 F:DBF='W'
                 IF F:DBF='E' THEN F:DBF='W'.
              OF '2'                               !  WMF/EXCEL
                 HIDE(?F:DBF:WORD)
                 IF F:DBF='A' THEN F:DBF='W'.
              OF '3'                               !  WMF/TXT/EXCEL
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              ELSE
                 KLUDA(0,'WMF/WORD/EXCEL izsaukums: '&OPCIJA[I#])
              .
           .
           BEGIN
              UNHIDE(?PAR_FILTRS)                  !5:????????????????
              UNHIDE(?PromptTips)
              UNHIDE(?PAR_TIPS)
              UNHIDE(?PromptGrupa)
              UNHIDE(?PAR_GRUPA)
              UNHIDE(?MT)
              PAR_GRUPA = ''
              IF OPCIJA[I#]='2'         ! KONKRÇTS
                 PAR_FILTRS='K'
                 HIDE(?PAR_GRUPA)
                 HIDE(?PAR_FILTRS:RADIO1)
                 HIDE(?PromptTips)
                 HIDE(?PAR_TIPS)
                 HIDE(?PromptGrupa)
                 HIDE(?MT)
              ELSIF PAR_NR AND ~(PAR_NR=999999999)
                 IF GETPAR_K(PAR_NR,0,1)
                    UNHIDE(?PAR_NOS_S)
                    PAR_FILTRS='K'
                    SAV_PAR_FILTRS=PAR_FILTRS
                 ELSE
                    PAR_NR=999999999
                    PAR_FILTRS = 'V'
                    SAV_PAR_FILTRS=PAR_FILTRS
                 .
              ELSE
                 PAR_NR=999999999
                 PAR_FILTRS = 'V'
                 SAV_PAR_FILTRS=PAR_FILTRS
              .
           END
           F:VALODA=''
           UNHIDE(?BUTTON0KNK)                     !6:IZLAIST 0-ES KNK
        .
     .
  .
  ACCEPT
    IF ~(SAV_PAR_FILTRS=PAR_FILTRS)
        CASE PAR_FILTRS
        OF 'V'
            IF OPCIJA[7]=1
                UNHIDE(?PromptTips)
                UNHIDE(?PAR_TIPS)
                UNHIDE(?MT)
            ELSE
                HIDE(?PromptTips)
                HIDE(?PAR_TIPS)
                HIDE(?MT)
            END
            PAR_NR = 999999999
            HIDE(?PAR_NOS_S)
            HIDE(?MP)
            UNHIDE(?PROMPTGRUPA)
            UNHIDE(?PAR_GRUPA)
            SELECT(?PAR_GRUPA)
        OF 'K'
            IF OPCIJA[7]=1
                UNHIDE(?PAR_TIPS)
                UNHIDE(?PromptTips)
                UNHIDE(?MT)
            ELSE
                HIDE(?MT)
                HIDE(?PAR_TIPS)
                HIDE(?promptTips)
            END
            UNHIDE(?PAR_NOS_S)
            UNHIDE(?MP)
            HIDE(?PAR_GRUPA)
            HIDE(?PromptGrupa)
            GlobalRequest = SelectRecord
            BrowsePAR_K
            LocalResponse = GlobalResponse
            GlobalResponse = RequestCancelled
            IF LocalResponse = RequestCompleted
              PAR_NR=PAR:U_NR
              PAR_NOS_S=PAR:NOS_S
            ELSE
              PAR_NR=999999999
              PAR_NOS_S=''
            END
            LocalResponse = RequestCancelled
        END
        SAV_PAR_FILTRS = PAR_FILTRS
    .
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Button0knk)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?Button0knk
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:VALODA
           F:VALODA=''
           HIDE(?IMAGE0KNK)
        ELSE
           F:VALODA='1'
           UNHIDE(?IMAGE0KNK)
        .
      END
    OF ?MT
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SEL_PAR_TIPS5
        DISPLAY(?PAR_TIPS)
      END
    OF ?MP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePar_K
        LocalResponse = GlobalResponse
        GlobalResponse = RequestCancelled
        IF LocalResponse = RequestCompleted
            PAR_NR = PAR:U_NR
            PAR_NOS_S = PAR:NOS_S
        ELSE
            LocalResponse = RequestCancelled
            DO ProcedureReturn
        END
      END
    OF ?ButtonRs
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF RS='A'
           RS='V'
           UNHIDE(?IMAGERS)
        ELSE
           RS='A'
           HIDE(?IMAGERS)
        .
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        LOCALRESPONSE = REQUESTCOMPLETED
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LOCALRESPONSE = REQUESTCANCELLED
        BREAK
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
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
A_DAIEVPROT          PROCEDURE                    ! Declare Procedure
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

K_TABLE              QUEUE,PRE(K)
KODS                   USHORT
SKAITS                 USHORT
STUNDAS                USHORT
SUMMA                  DECIMAL(9,2)
                     .
DAI_NOSAUKUMS        LIKE(DAI:NOSAUKUMS)
PSUMMAK              DECIMAL(10,2)
ISUMMAK              DECIMAL(10,2)
NPK                  DECIMAL(3)
DAT                  DATE
LAI                  TIME
FILTRS_TEXT          STRING(80)

!-----------------------------------------------------------------------------
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_STUNDAS)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END
!--------------------------------------------------------------------------
report REPORT,AT(198,1542,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,250,8000,1292),USE(?unnamed)
         STRING(@s45),AT(1365,104,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Stundas'),AT(4198,1083,573,156),USE(?String25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5469,1042,0,260),USE(?Line21),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6708,833,573,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@S60),AT(1198,729,5052,208),USE(FILTRS_TEXT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma DAIEV1V'),AT(6448,688,833,156),USE(?String9),LEFT
         LINE,AT(938,1042,6302,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1302,1042,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4167,1042,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4792,1042,0,260),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(7240,1042,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(969,1083,313,156),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(1333,1083,365,156),USE(?String2:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1750,1083,2396,156),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cilv. skaits'),AT(4823,1083,625,156),USE(?String25:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1719,1042,0,260),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Summa'),AT(5854,1083,833,156),USE(?String2:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1250,6302,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(938,1042,0,260),USE(?Line2),COLOR(COLOR:Black)
         STRING('Maksâjumi pçc DAIEV'),AT(2115,417,1615,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D014.),AT(3781,417),USE(S_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4458,417,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D014.),AT(4667,417),USE(B_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(938,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N3),AT(990,10,,156),USE(NPK),RIGHT
         LINE,AT(1302,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@N03),AT(1354,10,313,156),USE(K:KODS),CENTER
         LINE,AT(1719,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@S35),AT(1823,10,2344,156),USE(DAI_NOSAUKUMS),LEFT
         LINE,AT(4167,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5833,0,833,156),USE(K:SUMMA),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,198),USE(?Line22:2),COLOR(COLOR:Black)
         STRING(@N_5B),AT(4948,0,,156),USE(K:SKAITS),TRN,RIGHT
         STRING(@N_5B),AT(4302,10,,156),USE(K:STUNDAS),RIGHT
         LINE,AT(5469,-10,0,198),USE(?Line22),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,448),USE(?unnamed:4)
         LINE,AT(938,-10,0,427),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1302,-10,0,63),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,63),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('Kopâ pieskaitîjumi:'),AT(1042,104,1198,156),USE(?String2:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5833,104,833,156),USE(pSUMMAk),RIGHT
         STRING('Kopâ ieturçjumi:'),AT(1042,260,1198,156),USE(?String2:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5833,260,833,156),USE(iSUMMAk),RIGHT
         LINE,AT(938,417,6302,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(938,52,6302,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,427),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,427),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4792,0,0,427),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,427),USE(?Line23),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,156),USE(?unnamed:2)
         LINE,AT(938,0,6302,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@d06.),AT(6073,21,625,104),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6719,21,521,104),USE(lai),FONT(,7,,,CHARSET:ANSI)
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
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('F:NODALA',F:NODALA)
  BIND('DAV_GRUPA',DAV_GRUPA)
  BIND('ID',ID)

  DAT=TODAY()
  LAI=CLOCK()

  IF ID THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&GETKADRI(ID,0,1).
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF DAV_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc DAIEV grupas: '&DAV_GRUPA.
!  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!  VIRSRAKSTS=KKK&' : '&CLIP(GETKON_K(KKK,2,2))&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Maksâjumu pçc DAIEV protokols'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=S_DAT
      SET(ALG:NOD_KEY,ALG:NOD_KEY)
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
          IF ~OPENANSI('DAIEV1.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='MAKSÂJUMI PÇC DAIEV '&CHR(9)&format(S_DAT,@d014.)&'-'&format(B_DAT,@d014.)
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Stundas'&CHR(9)&'c.Skaits'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF (ALG:NODALA=F:NODALA OR F:NODALA=0) AND (ALG:ID=ID OR ID=0)
            NNR#+=1
            ?Progress:UserString{Prop:Text}=NNR#
            DISPLAY(?Progress:UserString)
!*************** PIESKAITÎJUMI
            LOOP I#=1 TO 20
              IF ALG:R[I#]
                G#=GETDAIEV(ALG:K[I#],0,1)
                IF CYCLEDAIEV('01') THEN CYCLE.
                K:KODS=ALG:K[I#]
                GET(K_TABLE,K:KODS)
                IF ERROR()
                   K:SUMMA=ALG:R[I#]
                   K:SKAITS=1
                   IF DAI:F='ARG' AND UPPER(DAI:ARG_NOS)='STUNDAS'
                      K:STUNDAS=ALG:A[I#]
                   ELSE
                      K:STUNDAS=ALG:S[I#]
                   .
                   ADD(K_TABLE)
                   SORT(K_TABLE,K:KODS)
                ELSE
                   K:SUMMA+=ALG:R[I#]
                   K:SKAITS+=1
                   IF DAI:F='ARG' AND UPPER(DAI:ARG_NOS)='STUNDAS'
                      K:STUNDAS+=ALG:A[I#]
                   ELSE
                      K:STUNDAS+=ALG:S[I#]
                   .
                   PUT(K_TABLE)
                .
!                DSUMMA[ALG:K[I#]]+=ALG:R[I#]
!                IF DAI:F='ARG' AND UPPER(DAI:ARG_NOS)='STUNDAS'
!                   DSTUNDAS[ALG:K[I#]]+=ALG:A[I#]
!                ELSE
!                  DSTUNDAS[ALG:K[I#]]+=ALG:S[I#]
!                .
              .
            .
!*************** IETURÇJUMI
            LOOP I#= 1 TO 15
              IF ALG:N[I#]
                G#=GETDAIEV(ALG:I[I#],0,1)
                IF CYCLEDAIEV('01') THEN CYCLE.
                K:KODS=ALG:I[I#]
                GET(K_TABLE,K:KODS)
                IF ERROR()
                   K:SUMMA=ALG:N[I#]
                   K:SKAITS=1
                   K:STUNDAS=0
                   ADD(K_TABLE)
                   SORT(K_TABLE,K:KODS)
                ELSE
                   K:SUMMA+=ALG:N[I#]
                   K:SKAITS+=1
                   PUT(K_TABLE)
                .
!                DSUMMA[ALG:I[I#]]+=ALG:N[I#]
              .
            .
        END
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       DAI_NOSAUKUMS=GETDAIEV(K:KODS,0,1)
       NPK += 1
       IF F:DBF = 'W'
         PRINT(RPT:DETAIL)
       ELSE
         OUTA:LINE=CLIP(NPK)&CHR(9)&K:KODS&CHR(9)&DAI_NOSAUKUMS&CHR(9)&CLIP(K:STUNDAS)&CHR(9)&CLIP(K:SKAITS)&CHR(9)&|
         LEFT(FORMAT(K:SUMMA,@N-_12.2))
         ADD(OUTFILEANSI)
       END
       IF I#<900
          PSUMMAK+=K:SUMMA
       ELSE
          ISUMMAK+=K:SUMMA
       .
    .
    IF F:DBF = 'W'
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'Kopâ pieskaitîjumi:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PSUMMAK,@N-_12.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'Kopâ ieturçjumi:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ISUMMAK,@N-_12.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    END
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ALG:YYYYMM > B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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
RW_APM_tps           PROCEDURE (OPC)              ! Declare Procedure
LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
SAK_DAT               LONG
BEI_DAT               LONG
darbiba               STRING(30)
X                     BYTE
PAV_RAKSTI            LONG
NOL_RAKSTI            LONG
IZVELETO              BYTE


ToScreen WINDOW('Apmaiòas TPS failu sagatavoðana'),AT(,,185,125),GRAY
       STRING('Rakstu ...'),AT(61,5),USE(?StringRakstu),HIDE,FONT(,9,,FONT:bold)
       STRING(@N_5B),AT(94,5),USE(NOL_RAKSTI),LEFT
       STRING('Kopçju uz E:\ ...'),AT(62,14),USE(?STRINGDISKETE),HIDE,CENTER
       OPTION('Norâdiet, kur rakstît'),AT(9,23,173,45),USE(merkis),BOXED
         RADIO('Privâtais folderis'),AT(16,32),USE(?Merkis:Radio1),VALUE('1')
         RADIO('E:\'),AT(16,41),USE(?Merkis:Radio2),VALUE('2')
         RADIO('Tekoðâ direktorijâ'),AT(16,51,161,10),USE(?Merkis:Radio3),VALUE('3')
       END
       SPIN(@D6),AT(33,71,56,12),USE(SAK_DAT)
       SPIN(@D6),AT(113,71,56,12),USE(BEI_DAT)
       STRING('rakstus ,kam X='),AT(38,89),USE(?String4)
       ENTRY(@N1b),AT(93,87,13,12),USE(X)
       BUTTON('Tikai izvçlçto P/Z'),AT(68,105,76,14),USE(?ButtonIzveleto)
       STRING('lîdz'),AT(96,72),USE(?String3)
       STRING('no'),AT(22,72),USE(?String2)
       BUTTON('&Atlikt'),AT(29,105,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(147,105,35,14),USE(?OkButton),DEFAULT
     END

ReadScreen WINDOW('Lasu apmaiòas failu'),AT(,,180,55),GRAY
       STRING(@s30),AT(24,20),USE(darbiba)
     END


  CODE                                            ! Begin processed code
 CHECKOPEN(NOLIK,1)
 NOLIK::USED+=1
 CHECKOPEN(NOM_K,1)
 NOM_K::USED+=1
 CHECKOPEN(PAR_K,1)
 PAR_K::USED+=1
! CHECKOPEN(AUTODARBI,1)
! AUTODARBI::USED+=1
! CHECKOPEN(AUTOAPK,1)
! AUTOAPK::USED+=1

 DISKETE=FALSE
 IZVELETO=FALSE

 CASE OPC
 OF 1 !****************************RAKSTÎT************************************
   disks=''
   MERKIS='1'
   SAK_dat=pav:datums
   BEI_dat=pav:datums
   OPEN(TOSCREEN)
   ?Merkis:radio1{prop:text}=USERFOLDER
   ?Merkis:radio3{prop:text}=path()
   DISPLAY
   ACCEPT
      CASE FIELD()
      OF ?OkButton
         CASE EVENT()
         OF EVENT:Accepted
            EXECUTE CHOICE(?MERKIS)
               DISKS=USERFOLDER&'\'
               BEGIN
                  DISKS=USERFOLDER&'\'
                  DISKETE=TRUE !FLAÐÐ
               .
               DISKS=''
            .
            LocalResponse = RequestCompleted
            BREAK
         END
      OF ?ButtonIzveleto
         CASE EVENT()
         OF EVENT:Accepted
            EXECUTE CHOICE(?MERKIS)
               DISKS=USERFOLDER&'\'
               BEGIN
                  DISKS=USERFOLDER&'\'
                  DISKETE=TRUE
               .
               DISKS=''
            .
            LocalResponse = RequestCompleted
            IZVELETO=TRUE
            BREAK
         END
      OF ?CancelButton
         CASE EVENT()
         OF EVENT:Accepted
            LocalResponse = RequestCancelled
            BREAK
         END
      END
   .
   IF LocalResponse = RequestCancelled
      CLOSE(TOSCREEN)
      DO PROCEDURERETURN
   .
   HIDE(1,?OkButton)
   UNHIDE(?STRINGRAKSTU)
   UNHIDE(?NOL_RAKSTI)
   DISPLAY

   FILENAME1=DISKS&'A_PAVA'&FORMAT(LOC_NR,@N02)&'.TPS'
   REMOVE(PAVA1)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME1)
      DO PROCEDURERETURN
   .
   CHECKOPEN(PAVA1,1)

   FILENAME2=DISKS&'A_NOLI'&FORMAT(LOC_NR,@N02)&'.TPS'
   remove(NOLI1)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME2)
      DO PROCEDURERETURN
   .
   CHECKOPEN(NOLI1,1)

   FILENAME1=DISKS&'A_PAR_'&FORMAT(LOC_NR,@N02)&'.TPS'
   REMOVE(PAR_K1)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME1)
      DO PROCEDURERETURN
   .
   CHECKOPEN(PAR_K1,1)

   FILENAME1=DISKS&'A_NOM_'&FORMAT(LOC_NR,@N02)&'.TPS'
   REMOVE(NOM_K1)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME1)
      DO PROCEDURERETURN
   .
   CHECKOPEN(NOM_K1,1)

!   FILENAME1=DISKS&'A_AAPK'&FORMAT(LOC_NR,@N02)&'.TPS'
!   REMOVE(AUTOAPK1)
!   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
!      KLUDA(1,FILENAME1)
!      DO PROCEDURERETURN
!   .
!   CHECKOPEN(AUTOAPK1,1)
!
!   FILENAME1=DISKS&'A_ADAR'&FORMAT(LOC_NR,@N02)&'.TPS'
!   REMOVE(AUTODARBI1)
!   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
!      KLUDA(1,FILENAME1)
!      DO PROCEDURERETURN
!   .
!   CHECKOPEN(AUTODARBI1,1)

   IF IZVELETO=FALSE
      CLEAR(PAV:RECORD)
      PAV:DATUMS=BEI_DAT
      PAV:D_K='P'
      PAV:DOK_SENR='zzzzzzzzzzzzzz'
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
   .
   LOOP
      IF IZVELETO=FALSE
         NEXT(PAVAD)
         IF ERROR() OR PAV:DATUMS < SAK_DAT THEN BREAK.
         IF ~(PAV:KEKSIS=X) THEN CYCLE.
      .
      PA1:RECORD=PAV:RECORD
      ADD(PAVA1)
      PAV_raksti+=1
      PAV:KEKSIS=2  !STATUSS::NOIMPORTÇTS
      IF RIUPDATE:PAVAD()
         KLUDA(24,'PAVAD')
      .

      IF GETPAR_K(PAV:PAR_NR,0,1)
         PAR1:RECORD=PAR:RECORD
         IF ~DUPLICATE(PAR_K1)
            ADD(PAR_K1)
         .
      .

!      IF CHECKSERVISS(PAV:U_NR)
!         APK1:RECORD=APK:RECORD
!         IF ~DUPLICATE(AUTOAPK1)
!            ADD(AUTOAPK1)
!         .
!      .

      CLEAR(NOL:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(NOL:NR_KEY,NOL:NR_KEY)
      LOOP
         NEXT(NOLIK)
         IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
         IF CL_NR=1315 AND NOM:TIPS='A' THEN CYCLE. !GA SERVISS
         NO1:RECORD=NOL:RECORD
         ADD(NOLI1)
         IF ERROR()
            KLUDA(24,'A_NOLIK')
         ELSE
            NOL_RAKSTI+=1
            DISPLAY
            IF GETNOM_K(NOL:NOMENKLAT,0,1)
               NOM1:RECORD=NOM:RECORD
               IF ~DUPLICATE(NOM_K1)
                  ADD(NOM_K1)
               .
            .
         .
      .

!      CLEAR(APD:RECORD)
!      APD:PAV_NR=PAV:U_NR
!      SET(APD:NR_KEY,APD:NR_KEY)
!      LOOP
!         NEXT(AUTODARBI)
!         IF ERROR() OR ~(APD:PAV_NR=PAV:U_NR) THEN BREAK.
!         APD1:RECORD=APD:RECORD
!         ADD(AUTODARBI1)
!         IF ERROR()
!            KLUDA(24,'A_ADARBI')
!         .
!      .

      IF IZVELETO=TRUE THEN BREAK.
   .
   KLUDA(99,'un sekmîgi pârrakstîtas '&clip(PAV_raksti)&' P/Z '&clip(NOL_raksti)&' nomenklatûras',1,1)
   IF DISKETE=TRUE   !FLAÐS
      UNHIDE(?STRINGDISKETE)
      DISPLAY

      close(PAVA1)
      close(NOLI1)
      close(NOM_K1)
      close(PAR_K1)

      FILENAME1=DISKS&'A_PAVA'&FORMAT(LOC_NR,@N02)&'.TPS'
      FILENAME2='E:\A_PAVA'&FORMAT(LOC_NR,@N02)&'.TPS'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
      FILENAME1=DISKS&'A_NOLI'&FORMAT(LOC_NR,@N02)&'.TPS'
      FILENAME2='E:\A_NOLI'&FORMAT(LOC_NR,@N02)&'.TPS'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
      FILENAME1=DISKS&'A_NOM_'&FORMAT(LOC_NR,@N02)&'.TPS'
      FILENAME2='E:\A_NOM_'&FORMAT(LOC_NR,@N02)&'.TPS'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
      FILENAME1=DISKS&'A_PAR_'&FORMAT(LOC_NR,@N02)&'.TPS'
      FILENAME2='E:\A_PAR_'&FORMAT(LOC_NR,@N02)&'.TPS'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
!      FILENAME1=DISKS&'A_AAPK'&FORMAT(LOC_NR,@N02)&'.TPS'
!      FILENAME2='E:\A_AAPK'&FORMAT(LOC_NR,@N02)&'.TPS'
!      IF ~CopyFileA(FILENAME1,FILENAME2,0)
!         KLUDA(3,FILENAME1&' uz '&FILENAME2)
!      .
!      FILENAME1=DISKS&'A_ADAR'&FORMAT(LOC_NR,@N02)&'.TPS'
!      FILENAME2='E:\A_ADAR'&FORMAT(LOC_NR,@N02)&'.TPS'
!      IF ~CopyFileA(FILENAME1,FILENAME2,0)
!         KLUDA(3,FILENAME1&' uz '&FILENAME2)
!      .
   .
   CLOSE(TOSCREEN)

 OF 2 !***************************************LASÎT********************************************************************

   COPYREQUEST=2 !LAI BROWSE ZINÂTU, KA JÂLASA APMAIÒAS FAILI
   BROWSEPAVA1
   COPYREQUEST=0
 .
 DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  NOLIK::USED-=1
  IF NOLIK::USED=0 THEN CLOSE(NOLIK).
  NOM_K::USED-=1
  IF NOM_K::USED=0 THEN CLOSE(NOM_K).
  PAR_K::USED-=1
  IF PAR_K::USED=0 THEN CLOSE(PAR_K).
!  AUTODARBI::USED-=1
!  IF AUTODARBI::USED=0 THEN CLOSE(AUTODARBI).
!  AUTOAPK::USED-=1
!  IF AUTOAPK::USED=0 THEN CLOSE(AUTOAPK).

  close(PAVA1)
  close(NOLI1)
  close(NOM_K1)
  close(PAR_K1)
!  CLOSE(AUTODARBI1)
!  CLOSE(AUTOAPK1)

  RETURN
!---------------------------------------------------------------------------------------------
