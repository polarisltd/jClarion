                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTPAM PROCEDURE


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
TEKG                 STRING(31)
window               WINDOW('Filtrs P/L'),AT(,,153,145),CENTER,IMM,GRAY,MDI
                       STRING(@s31),AT(12,9),USE(TEKG),HIDE,CENTER
                       PROMPT('&Uz:'),AT(41,21),USE(?Prompt:B_DAT),HIDE
                       SPIN(@D06.B),AT(57,21,51,10),USE(B_DAT ),HIDE
                       PROMPT('&Kategorija :'),AT(40,34),USE(?Promptkat),HIDE
                       ENTRY(@S1),AT(87,34,10,9),USE(F:KAT_NR[],,?F:KAT_NR1),IMM,HIDE
                       STRING('-'),AT(98,34),USE(?StringMINUS),HIDE
                       ENTRY(@S2),AT(102,34,15,9),USE(F:KAT_NR[2:3],,?F:KAT_NR2),IMM,HIDE
                       PROMPT('&Nodaïa :'),AT(40,46),USE(?F:NODALA:Prompt),HIDE
                       ENTRY(@s2),AT(87,45,15,9),USE(F:NODALA),HIDE
                       PROMPT('Objekts(Pr.) :'),AT(40,58),USE(?F:OBJ_NR:Prompt),HIDE
                       ENTRY(@n13B),AT(87,56,32,9),USE(F:OBJ_NR),HIDE,LEFT
                       PROMPT('Atbildîgais :'),AT(40,70),USE(?PAR_NR:Prompt),HIDE
                       ENTRY(@n_7B),AT(87,68,32,9),USE(PAR_NR),HIDE,LEFT
                       OPTION('Izdrukas &Formâts'),AT(23,81,121,24),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(28,91),USE(?F:DBF:RadioWMF),VALUE('W')
                         RADIO('EXCEL'),AT(99,91,34,10),USE(?F:DBF:EXCEL),VALUE('E')
                         RADIO('WORD'),AT(62,91,34,10),USE(?F:DBF:WORD),VALUE('A')
                       END
                       BUTTON('D&rukas parametri'),AT(67,109,81,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('&OK'),AT(67,124,43,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(112,124,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  F:NODALA=''
  F:OBJ_NR=0
  PAR_NR=0
  !F:KAT_NR='000'
  IF OPCIJA[4]<'1' THEN F:DBF='W'.
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !
  ! OPCIJA 1=1:GADS-teksts
  !        2=KATEGORIJA
  !        3=NODAÏA
  !        4=WMF/EXCEL
  !        5=OBJ_NR
  !        6=ATBILDÎGAIS
  !        7=B_DAT
  
  LOOP I#=1 TO 7
     IF OPCIJA[I#] > '0'
        EXECUTE I#
           BEGIN
              IF OPCIJA[I#]='1'                       !1 1-vajag AIZPILDÎT un gada tekstu
                 S_DAT=GETFING(5,DB_GADS)             !5:MAX -12 MÇN. PERIODA SÂKUMS
                 B_DAT=DB_B_DAT
                 TEKG=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
                 UNHIDE(?TEKG)
              .
           .
           BEGIN
              UNHIDE(?F:KAT_NR1)                      !2 1-VAJAG KATEGORIJU
              IF OPCIJA[I#] = '1'
                 UNHIDE(?STRINGMINUS)
                 UNHIDE(?F:KAT_NR2)
              .
              UNHIDE(?Promptkat)
           .
           BEGIN
              UNHIDE(?F:NODALA)                       !3 1-VAJAG NODAÏU
              UNHIDE(?F:NODALA:Prompt)
           .
           BEGIN                                   !  12  WMF/Word/Excel
              UNHIDE(?F:DBF)
              CASE OPCIJA[I#]
              OF '1'                               !  WMF/WORD
                 HIDE(?F:DBF:EXCEL)
                 F:DBF='W'
                 IF F:DBF='E' THEN F:DBF='W'.
              OF '2'                               !  WMF/EXCEL
                 HIDE(?F:DBF:WORD)
                 IF F:DBF='A' THEN F:DBF='W'.
              OF '3'                               !  WMF/Word/EXCEL
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              ELSE
                 KLUDA(0,'WMF/WORD/EXCEL izsaukums: '&OPCIJA[I#])
              .
           .
           BEGIN
              UNHIDE(?F:OBJ_NR)                       !5 1-VAJAG OBJ_NR
              UNHIDE(?F:OBJ_NR:Prompt)
           .
           BEGIN
              UNHIDE(?PAR_NR)                         !6 1-VAJAG ATBILDÎGO
              UNHIDE(?PAR_NR:Prompt)
           .
           UNHIDE(?B_DAT)                             !7
        .
     .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?TEKG)
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
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        IF OPCIJA[2] = '2' AND ~F:KAT_NR
           BEEP
           SELECT(?F:KAT_NR1)
        ELSE
           LOCALRESPONSE = REQUESTCOMPLETED
           BREAK
        .
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
S_DARBI              PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:AKCIZE)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:CITAS)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:BAITS)
                       PROJECT(NOL:LOCK)
                       PROJECT(NOL:MUITA)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:RS)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:T_SUMMA)
                       PROJECT(NOL:U_NR)
                       PROJECT(NOL:val)
                     END
!-----------------------------------------------------------------------------
NOS_P               STRING(35)
NOSAUKUMS           STRING(40)
AUTOTEXT            STRING(25)
DAT                 LONG
LAI                 LONG
!-----------------------------------------------------------------------------
report REPORT,AT(198,1485,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(198,300,8000,1188)
         STRING(@s45),AT(1875,52,4323,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,885,0,313),COLOR(COLOR:Black)
         STRING('Npk'),AT(417,938,417,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(885,938,729,208),USE(?String28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(1667,938,1510,208),USE(?String28:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3229,938,4115,208),USE(?String28:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,1146,6979,0),COLOR(COLOR:Black)
         LINE,AT(833,885,0,313),COLOR(COLOR:Black)
         LINE,AT(1615,885,0,313),COLOR(COLOR:Black)
         LINE,AT(3177,885,0,313),COLOR(COLOR:Black)
         LINE,AT(7344,885,0,313),COLOR(COLOR:Black)
         STRING('Klients:'),AT(417,625,573,208),HIDE,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(990,625,2656,208),USE(NOS_P),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Automaðîna:'),AT(3646,625,885,208),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(4531,625,1927,208),USE(autotext),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(2917,313),USE(S_DAT),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(3854,313,208,260),USE(?String30),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4063,313),USE(B_DAT),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6615,677,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(365,885,6979,0),USE(?Line8),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,7729,177)
         LINE,AT(365,-10,0,198),COLOR(COLOR:Black)
         STRING(@n_4),AT(469,10,313,156),CNT,USE(?NPK),RIGHT 
         STRING(@D6),AT(938,10,573,156),USE(NOL:DATUMS),RIGHT(1) 
         STRING(@s21),AT(1719,10,1396,167),USE(NOL:NOMENKLAT),LEFT 
         STRING(@S40),AT(3281,10,2552,156),USE(NOSAUKUMS),LEFT 
         LINE,AT(7344,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(3177,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,198),USE(?Line9),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,-10,,406)
         LINE,AT(365,0,0,52),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(833,0,0,52),USE(?Line13:3),COLOR(COLOR:Black)
         LINE,AT(1615,0,0,52),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(3177,0,0,52),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,52),USE(?Line13:2),COLOR(COLOR:Black)
         LINE,AT(365,52,6979,0),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@D6),AT(5156,156),USE(DAT),RIGHT 
         STRING(@T4),AT(5885,156),USE(LAI),RIGHT 
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(365,0,6979,0),USE(?Line8:3),COLOR(COLOR:Black)
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
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('NOMENKLAT',NOMENKLAT)
  BIND('CYCLENOM',CYCLENOM)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)

  DAT = TODAY()
  LAI = CLOCK()
!  NOS_P = GETPAR_K(PAR_NR,2,3)
  IF AUT_NR AND ~(AUT_NR=999999999)
    AUTOTEXT = GETAUTO(AUT_NR,5)
  ELSE
    AUTOTEXT='Visas'
  END

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Daïas un darbi'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOL:DATUMS=S_DAT
      SET(NOL:DAT_KEY,NOL:DAT_KEY)
      Process:View{Prop:Filter} = '~cyclenom(nol:nomenklat)'
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        I#=GETPAVADZ(NOL:U_NR)
        IF AUT_NR=PAV:VED_NR
           NOSAUKUMS = GETNOM_K(NOL:NOMENKLAT,2,2)
           PRINT(RPT:detail)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAIL1)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    RP
    loop J#=1 to PR:SKAITS
       report{Prop:FlushPreview} = True
       IF ~(J#=PR:SKAITS)
          loop I#= 1 to RECORDS(PrintPreviewQueue1)
            GET(PrintPreviewQueue1,I#)
            PrintPreviewImage=PrintPreviewImage1
            add(PrintPreviewQueue)
          .
       END
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
  AUT_NR=0
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR NOL:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
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
IZZFILTS PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
AUTO_filtrs          STRING(1)
SAV_AUTO_FILTRS      STRING(1)
AUTOTEXT             STRING(25)
window               WINDOW('Filtrs izziòâm'),AT(,,270,141),GRAY,MDI
                       OPTION('&Raksta statuss'),AT(199,3,64,40),USE(RS),BOXED,HIDE
                         RADIO('Apstiprinâtie'),AT(202,11),USE(?RC:Radio1)
                         RADIO('Visi'),AT(202,20,23,10),USE(?RC:Radio2)
                         RADIO('Neapstiprinâtie'),AT(202,30,58,8),USE(?RC:Radio3)
                       END
                       STRING('Sastâdît izziòu'),AT(8,11,49,10),USE(?SastIzzinu1),HIDE
                       PROMPT('&No'),AT(60,11,9,10),USE(?Prompt:NO),HIDE
                       SPIN(@D06.B),AT(77,11,49,12),USE(S_DAT),HIDE
                       BUTTON('='),AT(127,11,44,12),USE(?ButtonNo),HIDE
                       STRING('Sastâdît izziòu'),AT(8,25),USE(?SastIzzinu2),HIDE
                       PROMPT('&Lîdz'),AT(60,25,15,10),USE(?Prompt:LIDZ),HIDE
                       SPIN(@D06.B),AT(77,25,49,12),USE(B_DAT),HIDE
                       BUTTON('='),AT(127,24,44,12),USE(?ButtonLidz),HIDE
                       OPTION('Filtrs pçc automaðînas'),AT(5,45,119,48),USE(AUTO_filtrs),BOXED,HIDE
                         RADIO('Visas'),AT(12,55,28,9),USE(?AUTO_FI:Radio1)
                         RADIO('Konkrçta'),AT(12,65,41,9),USE(?AUTO_FI:Radio2)
                       END
                       STRING(@s25),AT(16,74,101,9),USE(AUTOTEXT),HIDE
                       ENTRY(@s21),AT(133,68,90,10),USE(NOMENKLAT),HIDE,FONT('Fixedsys',9,,FONT:regular),UPR
                       STRING('123456789012345678901'),AT(135,80,86,10),USE(?NOM_FILTRS),HIDE,FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                       BUTTON('&Grupa'),AT(130,55,44,11),USE(?Bgrupa),HIDE
                       BUTTON('Apakðgr&upa'),AT(175,55,44,11),USE(?BAgrupa),HIDE
                       BUTTON('Raþotâ&js'),AT(220,55,44,11),USE(?Braz),HIDE
                       OPTION('Nomenkla&tûra'),AT(127,45,139,48),USE(?Nomen),BOXED,HIDE
                       END
                       OPTION('Izdrukas &Formâts'),AT(5,99,119,22),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(12,108,29,10),USE(?F:DBF:Radio1)
                         RADIO('Word'),AT(42,108,32,10),USE(?F:DBF:Radio2),VALUE('A')
                         RADIO('Excel'),AT(76,108,32,10),USE(?F:DBF:E),VALUE('A')
                       END
                       BUTTON('&OK'),AT(185,120,35,13),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(226,120,36,13),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  RS        ='Apstiprinâtie'
  IF ~F:DBF THEN F:DBF='W'.
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 6  
     IF INSTRING(OPCIJA[I#],'1234')
        EXECUTE I#
           BEGIN                         !  1
              UNHIDE(?S_DAT)
              UNHIDE(?PROMPT:NO)
              UNHIDE(?SASTIZZINU1)
              IF OPCIJA[I#]='3'
                 UNHIDE(?BUTTONNO)
                 ?BUTTONNO{PROP:TEXT}='='&FORMAT(SAV_DATUMS,@D6)
              .
           .
           BEGIN
              UNHIDE(?B_DAT)             !  2
              UNHIDE(?PROMPT:LIDZ)
              IF OPCIJA[I#]='2'
                 ?Prompt:LIDZ{PROP:TEXT}='&Uz'
              .
              IF OPCIJA[I#-1]='0'
                 UNHIDE(?SASTIZZINU2)
              .
              IF OPCIJA[I#]='3'
                 UNHIDE(?BUTTONLIDZ)
                 ?BUTTONLIDZ{PROP:TEXT}='='&FORMAT(SAV_DATUMS,@D6)
              .
           .
           BEGIN
              UNHIDE(?AUTO_FILTRS)       !  3
              IF OPCIJA[I#]='2'         ! KONKRÇTA
                 AUTO_FILTRS='K'
                 AUTOTEXT=GETAUTO(AUT_NR,5)
                 UNHIDE(?AUTOTEXT)
                 SAV_AUTO_FILTRS=AUTO_FILTRS
                 HIDE(?AUTO_FI:Radio1)
                 DISABLE(?AUTO_FI:Radio1)
              ELSIF AUT_NR AND ~(AUT_NR=999999999)
                 IF GETAUTO(AUT_NR,5)
                    AUTOTEXT=GETAUTO(AUT_NR,5)
                    UNHIDE(?AUTOTEXT)
                    AUTO_FILTRS='K'
                    SAV_AUTO_FILTRS=AUTO_FILTRS
                 ELSE
                    AUT_NR=999999999
                    AUTO_FILTRS = 'V'
                    SAV_AUTO_FILTRS=AUTO_FILTRS
                 .
              ELSE
                 AUT_NR=999999999
                 AUTO_FILTRS = 'V'
                 SAV_AUTO_FILTRS=AUTO_FILTRS
              .
           END
           BEGIN                         !  4
              UNHIDE(?NOMEN)
              UNHIDE(?NOMENKLAT)
              UNHIDE(?NOM_FILTRS)
              UNHIDE(?BGRUPA)
              UNHIDE(?BAGRUPA)
              UNHIDE(?BRAZ)
           .
           BEGIN                         !  5  WMF/TXT
              IF OPCIJA[I#]='2'
                 UNHIDE(?F:DBF)
              .
           .
           BEGIN                         !  6  RS 1-vispâr atïauti neapstiprinâtie
              IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
                 UNHIDE(?RS)
              .
           .
        .
     .
  .
  ACCEPT
    IF ~(SAV_AUTO_FILTRS=AUTO_FILTRS)
       CASE AUTO_FILTRS
       OF 'V'
           AUT_NR = 999999999
           HIDE(?AUTOTEXT)
       OF 'K'
           GlobalRequest = SelectRecord
           BrowseAUTO
           IF GlobalResponse = RequestCompleted
             AUT_NR=AUT:U_NR
           ELSE
             AUT_NR=999999999
           END
           AUTOTEXT = GETAUTO(AUT_NR,5)
           UNHIDE(?AUTOTEXT)
       END
       SAV_AUTO_FILTRS = AUTO_FILTRS
    .
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?RC:Radio1)
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
    OF ?ButtonNo
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        S_DAT=SAV_DATUMS
        DISPLAY
      END
    OF ?ButtonLidz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        B_DAT=SAV_DATUMS
        DISPLAY
      END
    OF ?Bgrupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         GlobalRequest = SelectRecord             ! Set Action for Lookup
         BrowseGrupas                             ! Call the Lookup Procedure
         LocalResponse = GlobalResponse           ! Save Action for evaluation
         GlobalResponse = RequestCancelled        ! Clear Action
         IF LocalResponse = RequestCompleted      ! IF Lookup completed
           NOMENKLAT[1:3]=GR1:GRUPA1;DISPLAY      ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?BAgrupa
      CASE EVENT()
      OF EVENT:Accepted
        IF ~getgrupa(NOMENKLAT[1:3],1,1)
           CYCLE
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        UpdateGrupa1 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOMENKLAT[4]=GR2:GRUPA2
        .
        DISPLAY
      END
    OF ?Braz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOMENKLAT[19:21]=PAR:NOS_U
           DISPLAY
        .
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        IF OPCIJA[1]>'0' AND B_DAT<S_DAT !ATVÇRTS S_DAT
           BEEP
           SELECT(?B_DAT)
           CYCLE
        .
        LocalResponse = RequestCompleted
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        BREAK
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
  INIRestoreWindow('IZZFILTS','winlats.INI')
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
    INISaveWindow('IZZFILTS','winlats.INI')
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
