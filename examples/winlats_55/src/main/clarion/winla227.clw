                     MEMBER('winlats.clw')        ! This is a MEMBER module
SplitPZ PROCEDURE(OPC)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
Nomenklaturas        BYTE
DARBIBA              STRING(20)
ATRASTAS             STRING(20)

PAX:RECORD     LIKE(PAV:RECORD),PRE(PAX)

NOX_TABLE      QUEUE,PRE(NOX)
NOX:RECORD        LIKE(NOL:RECORD),PRE(NOX)
               END
SAV_POSITION   STRING(260)

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

window               WINDOW('Apstipriniet izvçli ...'),AT(,,166,71),GRAY
                       STRING('Izvçlçtâ P/Z tiks sadalîta gabalos pa'),AT(21,5),USE(?StringPZ)
                       ENTRY(@n2),AT(31,15),USE(Nomenklaturas)
                       STRING('nomenklatûrâm (rakstiem)'),AT(51,16),USE(?String2)
                       STRING(@s20),AT(40,30),USE(DARBIBA)
                       STRING(@s20),AT(40,39),USE(ATRASTAS)
                       BUTTON('&OK'),AT(84,53,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(123,53,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  checkopen(system,1)
  nomenklaturas=SYS:Tuksni
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE OPC
  OF 2
     ?StringPZ{PROP:TEXT}='Izvçlçtâ P/Z tiks saspiesta pa'
     HIDE(?NOMENKLATURAS)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?StringPZ)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CASE OPC
        OF 1         !SADALÎT GABALOS
           IF ~INRANGE(NOMENKLATURAS,10,90) !90-MAX DRUKÂJOT NO ABÂM PUSÇM
              KLUDA(87,'(NEKOREKTI NORÂDÎTS) ier. skaits(min=10,max=90)')
              SELECT(?NoMENKLATURAS)
              CYCLE
           .
        
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           SET(NOL:NR_KEY,NOL:NR_KEY)
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
              RINDAS#+=1
              DARBIBA='Lasu '&RINDAS#
              DISPLAY(?DARBIBA)
              NOX:RECORD=NOL:RECORD
        !      stop(nox:daudzums)
              ADD(NOX_TABLE)
           .
           IF RINDAS# <= NOMENKLATURAS
              KLUDA(0,'Nav iespçjams sadalît pa '&nomenklaturas&' rakstiem, P/Z ir tikai '&rindas#&' raksti')
              FREE(NOX_TABLE)
              SELECT(?NoMENKLATURAS)
              CYCLE
           .
        
           PAX:RECORD=PAV:RECORD
           LOOP J#=1 TO RECORDS(NOX_TABLE)
              IF RAKSTI#=0  !JAUNA P/Z
                 PZ#+=1     !IZVEIDOTÂS PZ#
                 IF J#>1    !NAV PIRMÂ
                    PAV:SUMMA=GETPVN(2)
                    IF RIUPDATE:PAVAD()    !FIKSÇJAM P/Z SUMMU
                       KLUDA(24,'PAVAD')
                    .
                 .
                 FILLPVN(0)
                 DO AUTONUMBER
                 PAV:RECORD=PAX:RECORD
                 PAV:U_NR=Auto::Save:PAV:U_NR
        !         IF PZ#>1
                    PAV:DOK_SENR=''        !LAI NEBÛTU DUPLICETE KEY
        !         .
                 IF RIUPDATE:PAVAD()       !FIKSÇJAM P/Z U_NR
                    KLUDA(24,'PAVAD')
                 .
                 SAV_POSITION=POSITION(PAV:DAT_KEY)
                 IF CHECKSERVISS(PAX:U_NR) !IR SERVISS
                    APK:PAV_NR=PAV:U_NR
                    ADD(AUTOAPK)
                    CLEAR(APX:RECORD)
                    APX:PAV_NR=PAX:U_NR
                    SET(APX:NR_KEY,APX:NR_KEY)
                    LOOP
                       NEXT(AUTOTEX)
                       IF ERROR() OR ~(APX:PAV_NR=PAX:U_NR) THEN BREAK.
                       APX:PAV_NR=PAV:U_NR
                       ADD(AUTOTEX)
                    .
                 .
              .
              GET(NOX_TABLE,J#)
              NOL:RECORD=NOX:RECORD
              NOL:U_NR=PAV:U_NR
              ADD(NOLIK)
              IF ERROR() THEN STOP('ADD Nolik '&ERROR()).
              DARBIBA='Rakstu '&J#
              DISPLAY(?DARBIBA)
              FILLPVN(1)
              RAKSTI#+=1
              IF RAKSTI#=NOMENKLATURAS THEN RAKSTI#=0.
           .
        !             IF ~PAV_DOK_NR      !FIKSÇJAM P/Z DOK_SENR
        !                SAV_POSITION=POSITION(PAVAD)
        !                SAV::PAV:Record = PAV:Record !ÐITO VAJAG ASSIGN_DOK_NR_am
        !                DO ASSIGN_DOK_NR  !MAINA DOKSE_NR iekð PAV:Record un SAV::PAV:Record
        !                IF PAV_DOK_SE=SYS:PZ_SERIJA AND PAV_DOK_NR>SYS:PZ_NR_END
        !                   KLUDA(0,'beidzies PPR numerâcijas apgabals Lokâlajos datos...')
        !                   PAV:DOK_SENR=''
        !                .
        !                RESET(PAVAD,SAV_POSITION)
        !                NEXT(PAVAD)
        !                PAV:Record=SAV::PAV:Record !ar jauno DOK_SENR
        !             .
           PAV:SUMMA=GETPVN(2)            !FIKSÇJAM P/Z SUMMU
           IF RIUPDATE:PAVAD()            
              KLUDA(24,'PAVAD')
           .
           IF GETPAVADZ(PAX:U_NR)
              IF RIDELETE:PAVAD()  !NODZÇÐAM VECO(ORIÌINÂLO) P/Z KOPÂ AR VISU SERVISU UN TEKSTIEM
                 KLUDA(26,'PAVAD')
              .
           ELSE
              KLUDA(120,' P/Z U_NR :'&PAX:U_NR)
           .
        
           FREE(NOX_TABLE)
           LOCALRESPONSE=REQUESTCOMPLETED
           RESET(PAV:DAT_KEY,SAV_POSITION)
           NEXT(PAVAD)
        OF 2 !SASPIEST
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           SET(NOL:NR_KEY,NOL:NR_KEY)
           ATRASTAS#=0
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
              RINDAS#+=1
              DARBIBA='Lasu '&RINDAS#
              DISPLAY(?DARBIBA)
              FOUND#=FALSE
              LOOP I#=1 TO RECORDS(NOX_TABLE)
                 GET(NOX_TABLE,I#)
                 IF NOX:NOMENKLAT=NOL:NOMENKLAT AND NOL:PAR_NR=NOX:PAR_NR AND |
                 NOL:ATLAIDE_PR=NOX:ATLAIDE_PR AND NOL:PVN_PROC=NOX:PVN_PROC AND NOL:ARBYTE=NOX:ARBYTE
                    FOUND#=TRUE
                    NOX:IEPAK_D+=NOL:IEPAK_D
                    NOX:DAUDZUMS+=NOL:DAUDZUMS
                    NOX:SUMMA+=NOL:SUMMA
                    NOX:SUMMAV+=NOL:SUMMAV
                    NOX:T_SUMMA+=NOL:T_SUMMA
                    NOX:MUITA+=NOL:MUITA
                    NOX:AKCIZE+=NOL:AKCIZE
                    NOX:CITAS+=NOL:CITAS
                    PUT(NOX_TABLE)
                    ATRASTAS#+=1
                    ATRASTAS='Apvienotas: '&atrastas#
                    DISPLAY(?ATRASTAS)
                    BREAK
                 .
              .
              IF FOUND#=FALSE
                 NOX:RECORD=NOL:RECORD
                 ADD(NOX_TABLE)
              .
           .
           IF ~ATRASTAS#
              KLUDA(0,'Nav atrastas nomenklatûras, ko apvienot')
              FREE(NOX_TABLE)
              BREAK
           .
           RINDAS#=0
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           SET(NOL:NR_KEY,NOL:NR_KEY)
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
              RINDAS#+=1
              DARBIBA='Dzçðu '&RINDAS#
              DISPLAY(?DARBIBA)
              DELETE(NOLIK)
           .
           LOOP J#=1 TO RECORDS(NOX_TABLE)
              GET(NOX_TABLE,J#)
              NOL:RECORD=NOX:RECORD
              ADD(NOLIK)
              IF ERROR() THEN STOP('ADD Nolik '&ERROR()).
              DARBIBA='Rakstu '&J#
              DISPLAY(?DARBIBA)
           .
        .
        FREE(NOX_TABLE)
        BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           LOCALRESPONSE=REQUESTCANCELLED
           BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  BIND(APX:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('SplitPZ','winlats.INI')
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    AUTOTEX::Used -= 1
    IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
  END
  IF WindowOpened
    INISaveWindow('SplitPZ','winlats.INI')
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
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
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

!---------------------------------------------------------------------------------------------
ASSIGN_DOK_NR  ROUTINE    !ÐITO JOKU IZPILDAM TIKAI K-P-R
!    CLEAR(PAV:DOK_SENR,1)
!    PAV:DOK_SENR = CLIP(PAV_DOK_SE)&CHR(33) !'
!    SET(PAV:SENR_KEY,PAV:SENR_KEY)    !SÂKAM AR PIEPRASÎTÂS SÇRIJAS LIELÂKO Nr PIRMS USERA SABAKSTÎTÂM BLÇÒÂM
!    LOOP
!      PREVIOUS(PAVAD)
!       IF ERRORCODE() AND ERRORCODE() <> BadRecErr
!         StandardWarning(Warn:RecordFetchError,'PAVAD')
!         POST(Event:CloseWindow)
!         EXIT
!       .
!       IF ERRORCODE() OR ~(GETDOK_SENR(1,PAV:DOK_SENR,,'2')=PAV_DOK_SE) !Nav atradis tâdu sçriju....
!         IF SUP_A4_NR=1 !Vajag SUP/A4 Nr - VAR BÛT TIKAI KREDÎTS
!            PAV_DOK_NR = SYS:PZ_NR  !Nr_no
!         ELSE
!            PAV_DOK_NR = 1
!         .
!       ELSIF INSTRING(PAV:D_K,'1D') !IGNORÇJAM VISUS 1-D AR TÂDU PAÐU SÇRIJU un lielâku Nr....
!         CYCLE
!       ELSE
!         PAV_DOK_NR = GETDOK_SENR(2,PAV:DOK_SENR,,'2') + 1
!       .
!       PAV:Record = SAV::PAV:Record
!       PAV:DOK_SENR = GETDOK_SENR(3,PAV_DOK_SE,PAV_DOK_NR)
!       SAV::PAV:Record = PAV:Record
!       BREAK
!    .
N_Uzcenojums         PROCEDURE                    ! Declare Procedure
VIRSRAKSTS          STRING(100)
FILTRS_TEXT         STRING(60)
DATUMS              LONG
LAI                 LONG
REALIZ              DECIMAL(12,3)
UZCPROC             DECIMAL(9,2)
NOS                 STRING(3)
RCENA               STRING(16)
CP                  STRING(10)
NOM_PIC             LIKE(NOM:PIC)
PIC_TEXT            STRING(6)
PIC_TEXTT           STRING(16)

R_TABLE             QUEUE,PRE(R)
REALIZ                 DECIMAL(12,3)
                    .

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_K)
                       PROJECT(NOMENKLAT)
                       PROJECT(EAN)
                       PROJECT(KODS)
                       PROJECT(BKK)
                       PROJECT(NOS_S)
                       PROJECT(MERVIEN)
                       PROJECT(SVARSKG)
                       PROJECT(TIPS)
                     END

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

report REPORT,AT(302,1229,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(302,198,8000,1031),USE(?unnamed)
         STRING(@s45),AT(1771,31,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzcen. %'),AT(6875,781,781,208),USE(?String4:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6875,469),PAGENO,USE(?PageCount),RIGHT
         STRING(@s60),AT(1667,500,4604,188),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,,CHARSET:ANSI)
         STRING(@s100),AT(219,260,7531,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,729,7344,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2083,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3073,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4896,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7656,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(365,781,1719,208),USE(?String4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(2135,781,938,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3125,781,1771,208),USE(?String4:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s16),AT(4927,781,781,208),USE(PIC_TEXTT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5729,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s16),AT(5792,781,990,208),USE(RCENA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6823,729,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(313,990,7344,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(313,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146)
         LINE,AT(2083,-10,0,166),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@N_13),AT(2188,0,833,146),USE(NOM:KODS),RIGHT
         LINE,AT(3073,-10,0,166),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s30),AT(3177,0,1719,146),USE(NOM:NOS_S),LEFT
         LINE,AT(4896,-10,0,166),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N_12.3),AT(4948,0,729,146),USE(NOM_PIC),RIGHT
         LINE,AT(5729,-10,0,166),USE(?Line8:6),COLOR(COLOR:Black)
         STRING(@N_12.3),AT(5781,0,729,146),USE(REALIZ),RIGHT
         STRING(@s3),AT(6563,0,,146),USE(NOS),LEFT
         LINE,AT(6823,-10,0,166),USE(?Line8:7),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(6938,0,625,156),USE(UZCPROC),RIGHT
         LINE,AT(7656,-10,0,166),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(313,-10,0,166),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s21),AT(365,0,1615,146),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT DETAIL,AT(,,,260),USE(?unnamed:2)
         LINE,AT(313,-10,0,63),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(2083,-10,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(3073,-10,0,63),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,63),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,63),USE(?Line15:386),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(313,52,7344,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(323,94),USE(?String18),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(813,94),USE(acc_kods),FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1385,94),USE(?String20),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6542,94),USE(DATUMS,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7135,83),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1604,94),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(302,10900,8000,52)
         LINE,AT(313,0,7344,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  datums=today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  IF NOKL_C1=6
     PIC_TEXT ='PIC'
     PIC_TEXTT='PIC'
  ELSE
     PIC_TEXT =NOKL_C1&'.cenu'
     PIC_TEXTT=NOKL_C1&'.c(bez PVN)'
  .
  IF F:DTK !PÇC REALIZÂCIJAS FAKTA
     VIRSRAKSTS='Uzcenojumu analîze pçc Realizâcijas fakta pret '&CLIP(PIC_TEXT)&' '&FORMAT(S_DAT,@D06.)&' - '&|
     FORMAT(B_DAT,@D06.)&' Noliktava N '&LOC_NR
     RCENA='Realiz.(bez PVN)'
     IF PAR_NR = 999999999
        IF PAR_TIPS THEN FILTRS_TEXT='ParTips:'&PAR_TIPS.
        IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
      ELSE
        FILTRS_TEXT=GETPAR_K(PAR_NR,2,2)
     .
  ELSE
     VIRSRAKSTS='Uzcenojumu % pçc '&NOKL_CP&' cenas pret '&CLIP(PIC_TEXT)&' '&FORMAT(DATUMS,@D06.)
     RCENA=NOKL_CP&'.cena(bez PVN)'
  .
  IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.

!  BIND('CP',CP)
!  BIND('CYCLEPAR_K',CYCLEPAR_K)

  CP = 'N11'
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

! STOP(F:DTK)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  CHECKOPEN(PAR_K,1)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Uzcenojuma analîze'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nom:RECORD)
      NOM:NOMENKLAT = NOMENKLAT
      CASE F:SECIBA
      OF 'N'
        SET(nom:nom_key,NOM:NOM_KEY)
      OF 'K'
        SET(nom:KOD_key)
      OF 'A'
        SET(nom:NOS_key)
      ELSE
        STOP('F:SECIBA')
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
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PROFIT.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIP(CLIENT)&' NOLIKTAVA: '&LOC_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Nomenklatûra'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&PIC_TEXTT&CHR(9)&RCENA&CHR(9)&CHR(9)&|
        'Uzcenojuma %'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT)
           PRINT#=TRUE
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           EXECUTE NOKL_CP
             NOS = NOM:VAL[1]
             NOS = NOM:VAL[2]
             NOS = NOM:VAL[3]
             NOS = NOM:VAL[4]
             NOS = NOM:VAL[5]
             NOS = 'Ls'
           .
           IF ~NOS THEN NOS = 'Ls'.
           IF F:DTK !PÇC REALIZÂCIJAS FAKTA
              CLEAR(NOL:RECORD)
              NOL:NOMENKLAT=NOM:NOMENKLAT
              NOL:DATUMS=S_DAT
              NOL:D_K='K'
              FREE(R_TABLE)
              SET(NOL:NOM_KEY,NOL:NOM_KEY)
              LOOP
                 NEXT(NOLIK)
                 IF ERROR() OR ~(NOL:NOMENKLAT=NOM:NOMENKLAT) OR NOL:DATUMS>B_DAT THEN BREAK.
                 IF ~(NOL:D_K='K' AND NOL:SUMMA>0) THEN CYCLE.
                 IF ~CYCLEPAR_K(CP)
                    R:REALIZ=ROUND(calcsum(15,3)/NOL:DAUDZUMS,.001)
                    GET(R_TABLE,R:REALIZ)
                    IF ERROR()
                       ADD(R_TABLE)
                       SORT(R_TABLE,R:REALIZ)
                    .
                 .
              .
           ELSE
              REALIZ=getnom_k('POZICIONÇTS',0,15) !NOKL_C BEZ PVN
           .
           IF F:CEN AND REALIZ <= 0            !kam cena >0
              PRINT#=FALSE
           .
           IF F:KRI                            !tikai, kam ir atlikumi
             IF GETNOM_A(NOM:NOMENKLAT,1,0) <=0
                PRINT#=FALSE
             .
           .
           IF ~F:PAK AND NOM:TIPS='A'          !NAV JÂIEKÏAUJ PAKALPOJUMI
              PRINT#=FALSE
           .
           IF PRINT#=TRUE
             NOM_PIC=GETNOM_K(NOM:NOMENKLAT,2,15,NOKL_C1) ! nokl_c1 bez pvn
             IF REALIZ AND NOM_PIC
                UZCPROC=((REALIZ-NOM_PIC)/NOM_PIC)*100
             ELSE
                UZCPROC=0
             .
             IF F:DBF='W'
                IF F:DTK !PÇC REALIZÂCIJAS FAKTA
                   LOOP I#=1 TO RECORDS(R_TABLE)
                       GET(R_TABLE,I#)
                       REALIZ=R:REALIZ
                       UZCPROC=((REALIZ-NOM_PIC)/NOM_PIC)*100
                       PRINT(RPT:DETAIL)
                   .
                ELSE
                   PRINT(RPT:DETAIL)
                .
             ELSE !WORD,EXCEL
                IF F:DTK !PÇC REALIZÂCIJAS FAKTA
                   LOOP I#=1 TO RECORDS(R_TABLE)
                      GET(R_TABLE,I#)
                      REALIZ=R:REALIZ
                      UZCPROC=((REALIZ-NOM_PIC)/NOM_PIC)*100
                      OUTA:LINE=NOM:NOMENKLAT&CHR(9)&FORMAT(NOM:KODS,@N_13)&CHR(9)&NOM:NOS_S&CHR(9)&|
                      LEFT(FORMAT(NOM_PIC,@N_12.3))&CHR(9)&LEFT(FORMAT(REALIZ,@N_12.3))&CHR(9)&NOS&CHR(9)&|
                      LEFT(FORMAT(UZCPROC,@N-_10.2))
                      ADD(OUTFILEANSI)
                   .
                ELSE
                   OUTA:LINE=NOM:NOMENKLAT&CHR(9)&FORMAT(NOM:KODS,@N_13)&CHR(9)&NOM:NOS_S&CHR(9)&|
                   LEFT(FORMAT(NOM_PIC,@N_12.3))&CHR(9)&LEFT(FORMAT(REALIZ,@N_12.3))&CHR(9)&NOS&CHR(9)&|
                   LEFT(FORMAT(UZCPROC,@N-_10.2))
                   ADD(OUTFILEANSI)
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    .
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
      .
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(R_TABLE)
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
  IF ERRORCODE() OR (F:SECIBA='N' AND CYCLENOM(NOM:NOMENKLAT)=2)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOM_K')
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
AI_SK_WRITE PROCEDURE(SKAITS_N)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
Cena                 DECIMAL(7,2)
Skaits               SHORT
NOSAUKUMS         STRING(30)
GAR               BYTE                                       
LEIBLS            STRING(5)
NOM:SKODS         CSTRING(14)
SCENA             CSTRING(13)
NOM:SNOMENKLAT    CSTRING(22)
NOM:SKATALOGA_NR  CSTRING(18)
NOM:SNOSAUKUMS    CSTRING(51)
SPLAUKTS          CSTRING(15)
SPORT             CSTRING(30)
SFONT             CSTRING(30)
Srazkods          CSTRING(4)
Sdatums           CSTRING(11)
NOM_NOMENKLAT     LIKE(NOM:NOMENKLAT)
NOM_NOSAUKUMS     LIKE(NOM:NOS_P)

!************** DATU FAILS BZB-2 *******************************
BZB               FILE,PRE(Z),DRIVER('dBase3'),CREATE
RECORD              RECORD
NOMENKLAT             STRING(21)
!KODS                  STRING(@N_13)
KODS                  STRING(13)
NOSAUK                STRING(50)
!CENA                  STRING(@N_9.2)
CENA                  STRING(12)
SERTIF                STRING(21)
SKAITS                STRING(@N_3)
                  . .



window               WINDOW('Caption'),AT(,,248,92),GRAY
                       STRING('Tiks drukâtas uzlîmes uz svîtru koda drukâtâja '),AT(15,13,229,10),USE(?StringSKD),CENTER
                       STRING('Nomenklatûra :'),AT(54,30),USE(?String2)
                       STRING(@s21),AT(106,30),USE(NOM_NOMENKLAT)
                       STRING('Nosaukums :'),AT(60,39),USE(?String4)
                       STRING(@s30),AT(107,39),USE(NOM_NOSAUKUMS)
                       STRING('Cena :'),AT(82,48),USE(?String6)
                       STRING(@n-10.2B),AT(108,48),USE(Cena)
                       STRING('Skaits :'),AT(79,58),USE(?String8)
                       ENTRY(@n4B),AT(110,57,35,12),USE(Skaits),REQ
                       STRING('Spiediet jebkuru taustiòu, lai turpinâtu'),AT(28,74),USE(?StringSPIEDIET),HIDE
                       BUTTON('&OK'),AT(154,72,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(192,72,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  ANSIFILENAME='assako.txt'
  SKAITS=SKAITS_N
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE SYS:SK_DRUKA
  OF '1'     !INTERMEC
     ?STRINGSKD{PROP:TEXT}='Tiks drukâtas uzlîmes uz svîtru koda drukâtâja INTERMEC'
     NOM_NOMENKLAT=NOM:NOMENKLAT
     NOM_NOSAUKUMS=NOM:NOS_P
     CENA=GETNOM_K('POZICIONÇTS',0,7)
     SCENA=FORMAT(CENA,@N_8.2)&' '&GETNOM_K('POZICIONÇTS',0,13) ! &valûta
  OF '2'     !EPL
     ?STRINGSKD{PROP:TEXT}='Tiks drukâtas uzlîmes uz EPL grupas svîtru koda drukâtâja'
     NOM_NOMENKLAT=NOM:NOMENKLAT
     NOM_NOSAUKUMS=NOM:NOS_P
     CENA=GETNOM_K('POZICIONÇTS',0,7)
     SCENA=FORMAT(CENA,@N_8.2)&' '&GETNOM_K('POZICIONÇTS',0,13) ! &valûta
  OF '3'     !BZB-2
     ?STRINGSKD{PROP:TEXT}='Tiks sagatavots BZB.dbf svîtru koda drukâtâjam'
     DISABLE(?SKAITS)
     NOM_NOMENKLAT='Visas no PPR '&CLIP(Pav:Dok_SENR)
     NOM_NOSAUKUMS=''
     CENA=0
     SCENA=''
     SKAITS=0
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?StringSKD)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         CASE SYS:SK_DRUKA
         OF '1'     !INTERMEC
            IF CENA=0
               KLUDA(31,NOM:NOMENKLAT)
               DO PROCEDURERETURN
            .
            close(OUTFILEANSI)
            OPEN(OUTFILEANSI,18)
            IF ERROR()
               kluda(1,'OUTFILEANSI')
               DO ProcedureReturn
            .
            EMPTY(OUTFILEANSI)
        
        !    IF CL_NR = 1000        !AIGAS NAMS
        !       LEIBLS='37X24'
        !    ELSE
               LEIBLS='58X40'
        !    .
        
            NOSAUKUMS=NOM:NOS_P[1:30]
            GAR=LEN(CLIP(NOSAUKUMS))
            LOOP I#=1 TO GAR
               IF INSTRING(NOSAUKUMS[I#],'#&')     !SPECIÂLIE SIMBOLI
                  NOSAUKUMS[I#]=' '
               .
            .
            OUTA:LINE='INPUT ON'
            ADD(OUTFILEANSI)
            IF GAR<=20
               IF LEIBLS='58X40'
                  OUTA:LINE='LAYOUT RUN "s125840"'     !58X40 mm ar cenu
               ELSIF LEIBLS='37X24'
                  IF CL_NR = 1000  !AIGAS NAMS
                     OUTA:LINE='LAYOUT RUN "s093724b"' !37X24 mm BEZ cenas
                  ELSE
                     OUTA:LINE='LAYOUT RUN "s093724"'  !37X24 mm AR cenu
                  .
               ELSE
               .
            ELSIF GAR<=24
               IF LEIBLS='58X40'
                  OUTA:LINE='LAYOUT RUN "s105840"'     !58X40 mm ar cenu
               ELSIF LEIBLS='37X24'
                  IF CL_NR = 1000  !AIGAS NAMS
                     OUTA:LINE='LAYOUT RUN "s073724b"' !37X24 mm BEZ cenas
                  ELSE
                     OUTA:LINE='LAYOUT RUN "s073724"'  !37X24 mm AR cenu
                  .
               ELSE
               .
            ELSE
               IF LEIBLS='58X40'
                  OUTA:LINE='LAYOUT RUN "s085840"'     !58X40 mm ar cenu
               ELSIF LEIBLS='37X24'
                  IF CL_NR = 1000  !AIGAS NAMS
                     OUTA:LINE='LAYOUT RUN "s063724b"' !37X24 mm BEZ cenas
                  ELSE
                     OUTA:LINE='LAYOUT RUN "s063724"'  !37X24 mm AR cenu
                  .
               ELSE
               .
            .
            ADD(OUTFILEANSI)
            OUTA:LINE='#'&CLIP(NOSAUKUMS)
            ADD(OUTFILEANSI)
            IF ~(CL_NR = 1000)     !AIGAS NAMS
               OUTA:LINE=CLIP(FORMAT(CENA,@N_7.2))
               ADD(OUTFILEANSI)
            .
            OUTA:LINE=FORMAT(INT(NOM:KODS/10),@N012)&'&'
            ADD(OUTFILEANSI)
            OUTA:LINE='PF'&CLIP(SKAITS)
            ADD(OUTFILEANSI)
            OUTA:LINE='INPUT OFF'
            ADD(OUTFILEANSI)
        
            CLOSE(OUTFILEANSI)
            CASE SYS:SK_DRUKA
            OF '1'            ! INTERMEC
               run('COPY ASSAKO.TXT LPT1')
            .
         OF '2'   !LP 2824
            IF CENA=0
               KLUDA(31,NOM:NOMENKLAT)
               DO PROCEDURERETURN
            .
        !   LabelConfig(),BOOL,PASCAL,RAW,DLL
            NOM:SKODS=NOM:KODS
            NOM:SNOMENKLAT=NOM:NOMENKLAT
            NOM:SKATALOGA_NR=NOM:KATALOGA_NR
            NOM:SNOSAUKUMS=NOM:NOS_P
            IF CL_NR=1315 !GA SERVISS
               SPLAUKTS=NOM:ANALOGS        !TEKSTS1 - GA1.INI
            ELSE
               SPLAUKTS=GETNOM_ADRESE(NOM:NOMENKLAT,0)
            .
            SRAZKODS=NOM:NOMENKLAT[19:21]  !TEKSTS2 - GA1.INI
            SDATUMS=FORMAT(TODAY(),@D06.)    !TEKSTS3 - GA1.INI
            !I#=LabelNomenklatura(NOM:SKODS,NOM:SNOMENKLAT,NOM:SKATALOGA_NR,SCENA,NOM:SNOSAUKUMS,SPLAUKTS,SRAZKODS,SDATUMS,SKAITS,0)    !%%% GA1.DLL missing
            !IF I#                                                                                                                       !%%% GA1.DLL missing
            !  EXECUTE I#                                                                                                               !%%% GA1.DLL missing
            !     KLUDA(0,'LP: Nevar atvçrt portu')                                                                                     !%%% GA1.DLL missing
            !      KLUDA(0,'LP: Etiíeðu skaits mazâks par 1')                                                                           !%%% GA1.DLL missing
            !      KLUDA(0,'LP: Nezinâms valodas tips -> INI -> [Printer] Type=')                                                       !%%% GA1.DLL missing
            !      KLUDA(0,'LP: Nevar atrast INI failâ [Printer] Port=')                                                                !%%% GA1.DLL missing
            !      KLUDA(0,'LP: Nevar atvçrt konfigurâcijas failu [Printer] Config=')                                                   !%%% GA1.DLL missing
            !   .                                                                                                                       !%%% GA1.DLL missing
            !.                                                                                                                          !%%% GA1.DLL missing
        !!  LabelNomenklatura(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SHORT,SHORT)
        !!  LabelPartneris(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SHORT)
        !   LabelConfig(),BOOL,PASCAL,RAW,DLL
         OF '3'   !BZB-2
            CHECKOPEN(BZB,1)
            close(BZB)
            OPEN(BZB,18)
            IF ERROR()
               kluda(1,'BZB.DBF')
               DO ProcedureReturn
            .
            EMPTY(BZB)
            CLEAR(NOL:RECORD)
            NOL:U_NR=PAV:U_NR
            SET(NOL:NR_KEY,NOL:NR_KEY)
            LOOP
               NEXT(NOLIK)
               IF ~(NOL:U_NR=PAV:U_NR) OR ERROR() THEN BREAK.
               IF GETNOM_K(NOL:NOMENKLAT,0,4) !IR SVÎTRU KODS
                  CENA       =GETNOM_K('POZICIONÇTS',0,7)
                  IF CENA=0
                     KLUDA(31,NOM:NOMENKLAT)
                  ELSE
                     Z:NOMENKLAT=NOM:NOMENKLAT
                     Z:KODS     =FORMAT(NOM:KODS,@N_13)
                     Z:NOSAUK   =NOM:NOS_P
        !             Z:CENA     =CLIP(FORMAT(CENA,@N_8.2))&' Ls'
                     Z:CENA     =FORMAT(CENA,@N_8.2)&' '&GETNOM_K('POZICIONÇTS',0,13) ! &valûta
                     Z:SERTIF   =NOM:CITS_TEKSTSPZ
                     Z:SKAITS   =ROUND(NOL:DAUDZUMS,1)
                     NOM_NOMENKLAT=NOL:NOMENKLAT
                     SKAITS+=Z:SKAITS
                     DISPLAY
                     ADD(BZB)
                  .
               ELSE
                  KLUDA(30,nol:nomenklat)
               .
            .
            CLOSE(BZB)
            IF SKAITS
               NOM_NOMENKLAT=''
               NOM_NOSAUKUMS='Kopâ uzlîmes:'
               CENA=0
               UNHIDE(?StringSPIEDIET)
               HIDE(?OKBUTTON)
               HIDE(?CANCELBUTTON)
               DISPLAY
               ASK
               RUN('C:\PROGRA~1\BZB\BZB.EXE WINLATS.DRW')
               IF RUNCODE()=-4
                  KLUDA(120,'C:\PROGRAM FILES\BZB\BZB.EXE')
               .
            ELSE
               KLUDA(0,'Nav atrasta neviena nomenklatûra, ko drukât..')
            .
        
         OMIT('MARIS')
            SPORT='BZB 2 - Label Gap'
            SFONT='Arial'
            NOM:SKODS=NOM:KODS
            NOM:SNOMENKLAT=NOM:NOMENKLAT
        !    NOM:SKATALOGA_NR=NOM:KATALOGA_NR
            NOM:SNOSAUKUMS=NOM:NOSAUKUMS
        !    SPLAUKTS=GETNOM_ADRESE(NOM:NOMENKLAT,0)
        !    SRAZKODS=NOM:NOMENKLAT[19:21]
        !    SDATUMS=FORMAT(TODAY(),@D6)
            IF ~OpenPort(SPORT)
               KLUDA(0,'LP: Nevar atvçrt portu '&SPORT)
            .
        !    IF ~BeginJob(30,4,1,0,3,0)
            H=30
            D=4
            S=1
            M=0
            G=3
            T=0
            IF ~BeginJob(H,D,S,M,G,T)
               KLUDA(0,'LP: Kïûda uzsâkot darbu')
            .
            IF ~ecTextOut(20,34,SFONT,NOM:SNOMENKLAT)
               KLUDA(0,'LP: Kïûda drukâjot tekstu')
            .
            I#=EndJob()
            I#=ClosePort()
        
        !      OpenPort(*LPCSTR),SHORT,C,RAW,DLL
        !      BeginJob(SHORT,SHORT,SHORT,SHORT,SHORT,SHORT),SHORT,C,RAW,DLL
        !      ecTextOut(SHORT,SHORT,*LPCSTR,*LPCSTR),SHORT,C,RAW,DLL
        !      PrintBar(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR),SHORT,C,RAW,DLL
        !      EndJob(),SHORT,C,RAW,DLL
        !      ClosePort(),SHORT,C,RAW,DLL
         MARIS
        
         ELSE
            KLUDA(44,'Svîtru kodu drukâtâjs Ârçjâs iekârtâs')
         .
         DO PROCEDURERETURN
      END
    OF ?CancelButton
         DO PROCEDURERETURN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF OUTFILEANSI::Used = 0
    CheckOpen(OUTFILEANSI,1)
  END
  OUTFILEANSI::Used += 1
  BIND(OUTA:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('AI_SK_WRITE','winlats.INI')
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    OUTFILEANSI::Used -= 1
    IF OUTFILEANSI::Used = 0 THEN CLOSE(OUTFILEANSI).
  END
  IF WindowOpened
    INISaveWindow('AI_SK_WRITE','winlats.INI')
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
