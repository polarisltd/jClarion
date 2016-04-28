                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateKAD_RIK PROCEDURE


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
VUT                  STRING(30)
CAL_DIENAS           STRING(10)
Update::Reloop  BYTE
Update::Error   BYTE
History::RIK:Record LIKE(RIK:Record),STATIC
SAV::RIK:Record      LIKE(RIK:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:RIK:U_NR     LIKE(RIK:U_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Rîkojumi un Dokumenti: Kad_Rik.tps'),AT(,,394,198),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateRIKOJUMI'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(1,8,393,188),USE(?CurrentTab)
                         TAB('Vârds, Uzvârds'),USE(?Tab:1)
                           STRING(@n_7),AT(350,11),USE(RIK:U_NR),RIGHT,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('Dokumenta &Nr:'),AT(14,32,74,10),USE(?RIK:DOK_NR:Prompt)
                           ENTRY(@S10),AT(90,32,42,10),USE(RIK:DOK_NR),RIGHT(1)
                           PROMPT('&Dokumenta Datums:'),AT(14,43,70,10),USE(?RIK:DATUMS:Prompt)
                           ENTRY(@D06.b),AT(90,43,41,10),USE(RIK:DATUMS),CENTER(1),REQ
                           PROMPT('No'),AT(14,56,74,10),USE(?RIK:DATUMS1:Prompt),HIDE
                           ENTRY(@D06.B),AT(90,56,41,10),USE(RIK:DATUMS1),HIDE,CENTER(1)
                           PROMPT('&Lîdz'),AT(14,67,74,10),USE(?RIK:DATUMS2:Prompt),HIDE
                           ENTRY(@D06.B),AT(90,67,41,10),USE(RIK:DATUMS2),HIDE,CENTER(1)
                           OPTION('&Rîkojuma (Dokumenta) tips:'),AT(145,27,242,88),USE(RIK:TIPS),BOXED,HIDE
                             RADIO('Kadri (iecelðana, pârcelðana, SA statusa maiòa,bçrnu/bezalgas atv.)'),AT(146,38),USE(?RIK:TIPS:Radio1),VALUE('K')
                             RADIO('Atvaïinâjumi (ikgadçjie)'),AT(146,49),USE(?RIK:TIPS:Radio2),VALUE('A')
                             RADIO('Rîkojumi'),AT(146,60),USE(?RIK:TIPS:Radio3),VALUE('C')
                             RADIO('Protokoli'),AT(146,71),USE(?RIK:TIPS:Radio4),VALUE('P')
                             RADIO('Izglîtîbas dokumenti'),AT(146,81),USE(?RIK:TIPS:Radio5),VALUE('I')
                             RADIO('Bçrnu dokumenti'),AT(146,92),USE(?RIK:TIPS:Radio6),VALUE('B')
                             RADIO('Profesijas koda uzstadîðana'),AT(146,103,117,10),USE(?RIK:TIPS:Radio7),VALUE('F')
                           END
                           STRING(@s10),AT(238,49),USE(CAL_DIENAS)
                           PROMPT('&Ziòas kods:'),AT(14,78,51,10),USE(?RIK:Z_KODS:Prompt),HIDE
                           ENTRY(@n3b),AT(90,80,23,10),USE(RIK:Z_KODS),HIDE
                           BUTTON('pierakstît no-lidz '),AT(258,118,65,14),USE(?ButtonNoLidz),HIDE
                           ENTRY(@s12),AT(122,148,51,10),USE(RIK:R_FAILS ),DISABLE
                           BUTTON('Teksts'),AT(10,116,45,14),USE(?ButtonSagataves)
                           ENTRY(@S60),AT(58,118,193,10),USE(RIK:SATURS)
                           BUTTON('Notîrît .doc failu'),AT(277,145,115,14),USE(?ButtonNotirit)
                           ENTRY(@S100),AT(58,129,193,10),USE(RIK:SATURS1)
                           BUTTON('Mainît (Sagatavot) Dokumentu'),AT(10,145,109,14),USE(?ButtonDokuments)
                           BUTTON('Mainît faila vârdu'),AT(194,145,75,14),USE(?ButtonFvards)
                           STRING(@s99),AT(10,161,381,10),USE(DOCFOLDERK),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           IMAGE('CHECK3.ICO'),AT(178,142,15,17),USE(?ImageBytes),HIDE
                           STRING(@n_4B),AT(174,11,23,10),USE(RIK:ID),LEFT(1)
                         END
                       END
                       BUTTON('Darbinieks(mainît)'),AT(108,6,66,14),USE(?ButtonDN),HIDE
                       BUTTON('Vispârçjs (nepersonalizçts) rîkojums'),AT(198,6,128,14),USE(?ButtonDN0),HIDE
                       IMAGE('CHECK2.ICO'),AT(330,4,14,16),USE(?ImageVR),HIDE
                       STRING(@s8),AT(14,180),USE(RIK:ACC_KODS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@d06.B),AT(50,180),USE(RIK:ACC_DATUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('Pievienot Avaïinâjumiem'),AT(194,175,101,14),USE(?ButtonAtvalinajumi),HIDE
                       BUTTON('&OK'),AT(298,175,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(346,175,45,14),USE(?Cancel)
                     END
SAV_R_FAILS     LIKE(RIK:R_FAILS)
NEWAFILENAME    LIKE(ANSIFILENAME)
JAMAINA         BYTE
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  VUT=GETKADRI(RIK:ID,0,1)
  ?Tab:1{PROP:TEXT}=VUT
  IF OPCIJA_NR <= 1
!     STOP(OPCIJA_NR)
     UNHIDE(?RIK:TIPS)
     IF ~OPCIJA_NR
        UNHIDE(?ButtonDN)
     ELSE ! OPCIJA_NR=1 !RIKOJUMI(KAD.-Atv.-Citi)
        HIDE(?RIK:TIPS:Radio4)  !NEIET
        HIDE(?RIK:TIPS:Radio5)
        HIDE(?RIK:TIPS:Radio6)
        DISABLE(?RIK:TIPS:Radio4)
        DISABLE(?RIK:TIPS:Radio5)
        DISABLE(?RIK:TIPS:Radio6)
        !09/07/2013 <
        IF RIK:Z_KODS = 71 OR RIK:Z_KODS = 72
           ?ButtonSagataves{PROP:TEXT}='Valsts kods'
        ELSIF RIK:TIPS = 'F'
            ?ButtonSagataves{PROP:TEXT}='Prof.kods'
        ELSE
           ?ButtonSagataves{PROP:TEXT}='Teksts'
        .
        !09/07/2013 >
     .
  .
  DO MODIFYSCREEN
  DO DOCFILE
  SAV_R_FAILS=RIK:R_FAILS


  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
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
      SELECT(?RIK:U_NR)
      SELECT(?RIK:DATUMS)
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
        History::RIK:Record = RIK:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(KAD_RIK)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(RIK:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'RIK:NR_KEY')
                SELECT(?RIK:U_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?RIK:U_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::RIK:Record <> RIK:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:KAD_RIK(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?RIK:U_NR)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
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
    IF RIK:TIPS='A' AND RIK:DATUMS2
       CAL_DIENAS=RIK:DATUMS2-RIK:DATUMS1+1&' dienas'
    ELSE
       CAL_DIENAS=''
    .
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?RIK:TIPS
      CASE EVENT()
      OF EVENT:Accepted
        DO MODIFYSCREEN
        IF RIK:Z_KODS = 71 OR RIK:Z_KODS = 72
           ?ButtonSagataves{PROP:TEXT}='Valsts kods'
        ELSIF RIK:TIPS = 'F'
            ?ButtonSagataves{PROP:TEXT}='Prof.kods'
        ELSE
           ?ButtonSagataves{PROP:TEXT}='Teksts'
        .
        DISPLAY
      END
    OF ?RIK:Z_KODS
      CASE EVENT()
      OF EVENT:Accepted
        !IF RIK:Z_KODS AND ~RIK:SATURS
        !   LOOP I#=1 TO 3
        !      EXECUTE I#
        !         RIK:SATURS =FILL_ZINA(RIK:Z_KODS,I#)
        !         RIK:SATURS1=FILL_ZINA(RIK:Z_KODS,I#)
        !!                RIK:SATURS2=FILL_ZINA(RIK:Z_KODS,I#)
        !      .
        !   .
        !   DISPLAY
        !.
        IF RIK:Z_KODS = 71 OR RIK:Z_KODS = 72
           ?ButtonSagataves{PROP:TEXT}='Valsts kods'
        ELSIF RIK:TIPS = 'F'
            ?ButtonSagataves{PROP:TEXT}='Prof.kods'
        ELSE
           ?ButtonSagataves{PROP:TEXT}='Teksts'
        .
        
      END
    OF ?ButtonNoLidz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
!        IF LEN(CLIP(RIK:SATURS)) < (100-32)
           RIK:SATURS =CLIP(RIK:SATURS)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
!        ELSIF LEN(CLIP(RIK:SATURS1)) < (100-32)
!           RIK:SATURS1=CLIP(RIK:SATURS1)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
!        ELSIF LEN(CLIP(RIK:SATURS2)) < (100-32)
!           RIK:SATURS2=CLIP(RIK:SATURS2)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
!        ELSIF LEN(CLIP(RIK:SATURS3)) < (100-32)
!           RIK:SATURS3=CLIP(RIK:SATURS3)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
!        .
        DISPLAY
      END
    OF ?RIK:R_FAILS 
      CASE EVENT()
      OF EVENT:Accepted
        IF ~(SAV_R_FAILS=RIK:R_FAILS)
           KLUDA(0,'Aizvietot(pârrakstît) failu '&CLIP(RIK:R_FAILS)&' ar '&CLIP(SAV_R_FAILS)&' ?',7,1)
           IF KLU_DARBIBA
              JAMAINA=TRUE
           ELSE
              JAMAINA=FALSE
           .
           DO DOCFILE
           SAV_R_FAILS=RIK:R_FAILS
        .
      END
    OF ?ButtonSagataves
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseTex 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           RIK:SATURS =TEX:TEKSTS1
           RIK:SATURS1=TEX:TEKSTS2
        !   RIK:SATURS2=TEX:TEKSTS3
        !   RIK:TIPS=TEX:S5_1[1]
        .
        DISPLAY
      END
    OF ?ButtonNotirit
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        KLUDA(0,'Vai tieðâm dzçst failu '&clip(RIK:R_FAILS)&' ?',7,1)
        IF KLU_DARBIBA
        !   TTAKA"=PATH()
        !   ANSIFILENAME=TTAKA"[1:3]&'WINLATS\DOKUMENTI\'&RIK:R_FAILS
        !   STOP('REMOVE'&ANSIFILENAME)
           CLOSE(OUTFILEANSI)
           REMOVE(OUTFILEANSI)
           IF ERROR() THEN STOP(ERROR()).
           HIDE(?ImageBytes)
        .
        
      END
    OF ?ButtonDokuments
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF INSTRING('.DOC',UPPER(RIK:R_FAILS),1)
           IF OPENANSI(RIK:R_FAILS,3)  !ARÎ FULL OUTFILENAME
              F:DBF='A'
              BYTES#=BYTES(OUTFILEANSI)
              IF ~BYTES#
                 OUTA:LINE=CLIENT
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:VID_NR
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:ADRESE
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=GL:REK[1]
                 ADD(OUTFILEANSI)
                 RAKSTI#=1
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 IF RIK:TIPS='K'
                    OUTA:LINE='Pavçle '&RIK:DOK_NR
                 ELSE
                    OUTA:LINE='Rîkojums Nr '&RIK:DOK_NR
                 .
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE='Rîga, '&FORMAT(RIK:DATUMS,@D06.)
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=RIK:SATURS
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 ADRESE"=GETKADRI(RIK:ID,0,18)
                 IF ADRESE"
                    OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)&' dzîvojoðs '&ADRESE"
                 ELSE
                    OUTA:LINE=GETKADRI(RIK:ID,0,1)&' personas kods '&GETKADRI(RIK:ID,0,14)
                 .
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 IF RIK:DATUMS2
                    OUTA:LINE=CLIP(RIK:SATURS1)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
                 ELSE
                    OUTA:LINE=CLIP(RIK:SATURS1)&' no '&FORMAT(RIK:DATUMS1,@D06.)
                 .
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 IF RIK:Z_KODS
                    OUTA:LINE='kods '&RIK:Z_KODS
                    ADD(OUTFILEANSI)
                    RAKSTI#+=1
                    LOOP I#=1 TO 4
                       OUTA:LINE=FILL_ZINA(RIK:Z_KODS,I#)
                       IF OUTA:LINE
                          ADD(OUTFILEANSI)
                          RAKSTI#+=1
                       .
                    .
                 .
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 OUTA:LINE=SYS:AMATS1&'________________________'&SYS:PARAKSTS1
                 ADD(OUTFILEANSI)
                 RAKSTI#+=1
                 KLUDA(0,'Pievienoti '&raksti#&' raksti',,1)
                 UNHIDE(?ImageBytes)
              .
              CLOSE(OUTFILEANSI)
           !   STOP('ANSIJOB'&ANSIFILENAME)
           .
        ELSE
           ANSIFILENAME = DOCFOLDERK&'\'&RIK:R_FAILS
        .
        ANSIJOB
      END
    OF ?ButtonFvards
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ENABLE(?RIK:R_FAILS)
        SELECT(?RIK:R_FAILS)
        DISPLAY
        
      END
    OF ?ButtonDN
      CASE EVENT()
      OF EVENT:Accepted
        ID=RIK:ID
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKadri 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           RIK:ID=KAD:ID
           VUT=GETKADRI(RIK:ID,0,1)
           ?Tab:1{PROP:TEXT}=VUT
           ID=RIK:ID
           RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
           IF RIK:TIPS='A' THEN UNHIDE(?ButtonAtvalinajumi).
           IF ~(SAV_R_FAILS=RIK:R_FAILS)
              KLUDA(0,'Aizvietot(pârrakstît) failu '&CLIP(RIK:R_FAILS)&'(tukðs) ar '&CLIP(SAV_R_FAILS)&' ?',7,1)
              IF KLU_DARBIBA
                 JAMAINA=TRUE
              ELSE
                 JAMAINA=FALSE
              .
              DO DOCFILE
              SAV_R_FAILS=RIK:R_FAILS
           .
           HIDE(?ImageVR)
           ID=0
        .
      END
    OF ?ButtonDN0
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        RIK:ID=0
        VUT='nav personalizçts'
        ?Tab:1{PROP:TEXT}=VUT
        ID=0
        RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
        HIDE(?ButtonAtvalinajumi)
        IF ~(SAV_R_FAILS=RIK:R_FAILS)
           KLUDA(0,'Aizvietot(pârrakstît) failu '&CLIP(RIK:R_FAILS)&'(tukðs) ar '&CLIP(SAV_R_FAILS)&' ?',7,1)
           IF KLU_DARBIBA
              JAMAINA=TRUE
           ELSE
              JAMAINA=FALSE
           .
           DO DOCFILE
           SAV_R_FAILS=RIK:R_FAILS
        .
        UNHIDE(?ImageVR)
        DISPLAY
        
        
      END
    OF ?ButtonAtvalinajumi
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF RIK:DATUMS1 AND RIK:DATUMS2
        !   RIK:DOK_NR=PERFORMGL(11,RIK:DOK_NR)
           CLEAR(PER:RECORD)
           GLOBALREQUEST=1
           PER:ID=RIK:ID
           PER:PAZIME='A'
           SET(PER:ID_KeY,PER:ID_KEY)
           LOOP
              NEXT(PERNOS)
              IF ERROR() OR ~(RIK:ID=PER:ID) THEN BREAK.
              IF ~(PER:PAZIME='A') THEN CYCLE.
              IF INRANGE(PER:SAK_DAT,RIK:DATUMS1,RIK:DATUMS2) OR|
                 INRANGE(PER:BEI_DAT,RIK:DATUMS1,RIK:DATUMS2)
                 KLUDA(0,'ðajâ periodâ atvaïinâjums jau ir',,1)
                 GLOBALREQUEST=2
                 BREAK
              .
           .
           IF GLOBALREQUEST=1
              PER:ID=RIK:ID
              PER:PAZIME='A'
              PER:RIK_NR=RIK:U_NR
              PER:YYYYMM=DATE(MONTH(RIK:DATUMS1),1,YEAR(RIK:DATUMS1))
              PER:SAK_DAT=RIK:DATUMS1
              PER:BEI_DAT=RIK:DATUMS2
              PER:ACC_KODS=ACC_KODS
              PER:ACC_DATUMS=TODAY()
           .
           OPCIJA='R' !LAI ZINÂTU, KA SAUC NO RÎKOJUMIEM
           PUT(KAD_RIK)
           IF ERROR() THEN STOP(ERROR()).
           DISABLE(?CANCEL)
           UPDATEPERNOS !Atvaïinâjumi
           OPCIJA=''
           SELECT(?OK)
        ELSE
           KLUDA(0,'nav norâdîts atvaïinâjuma periods')
        .
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        RIK:DOK_NR=PERFORMGL(11,RIK:DOK_NR)
        RIK:ACC_KODS=ACC_kods
        RIK:ACC_DATUMS=today()
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
  IF PERNOS::Used = 0
    CheckOpen(PERNOS,1)
  END
  PERNOS::Used += 1
  BIND(PER:RECORD)
  FilesOpened = True
  RISnap:KAD_RIK
  SAV::RIK:Record = RIK:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    IF OPCIJA_NR  !NO KADRIEM
       RIK:ID=KAD:ID
    ELSE          !NO FAILIEM VAI ATVAÏINÂJUMIEM
       RIK:ID=ID
    .
    IF OPCIJA='A' !TIEK SAUKTS NO ATVAÏINÂJUMIEM
       RIK:DATUMS=PER:YYYYMM
       RIK:TIPS='A'
       RIK:DATUMS1=PER:SAK_DAT
       RIK:DATUMS2=PER:BEI_DAT
    ELSE
       RIK:DATUMS=TODAY()
!       EXECUTE OPCIJA_NR+1
!          RIK:TIPS='C'
!          RIK:TIPS='C'
!          RIK:TIPS='I'
!          RIK:TIPS='B'
!       .
       RIK:TIPS=RIK_TIPS
       IF RIK:TIPS='C' !PRIEKÐ A
          RIK:DOK_NR=PERFORMGL(11)   !PIEÐÍIRAM RIK. NR
          RIK:DATUMS1=TODAY()
          RIK:DATUMS2=RIK:DATUMS1+28-1 !4 NEDÇÏAS
       .
    .
!    RIK:R_FAILS = 'R'&CLIP(RIK:ID)&'_'&CLIP(LEFT(FORMAT(RIK:U_NR,@N_6B)))&'.doc'
!    RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
    RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-'&RIK:TIPS&CLIP(RIK:DOK_NR)&'.doc'
    RIK:ACC_KODS=ACC_kods
    RIK:ACC_DATUMS=today()
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:KAD_RIK()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateKAD_RIK','winlats.INI')
  WinResize.Resize
  ?RIK:U_NR{PROP:Alrt,255} = 734
  ?RIK:DOK_NR{PROP:Alrt,255} = 734
  ?RIK:DATUMS{PROP:Alrt,255} = 734
  ?RIK:DATUMS1{PROP:Alrt,255} = 734
  ?RIK:DATUMS2{PROP:Alrt,255} = 734
  ?RIK:TIPS{PROP:Alrt,255} = 734
  ?RIK:Z_KODS{PROP:Alrt,255} = 734
  ?RIK:SATURS{PROP:Alrt,255} = 734
  ?RIK:SATURS1{PROP:Alrt,255} = 734
  ?RIK:ID{PROP:Alrt,255} = 734
  ?RIK:ACC_KODS{PROP:Alrt,255} = 734
  ?RIK:ACC_DATUMS{PROP:Alrt,255} = 734
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
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
    PERNOS::Used -= 1
    IF PERNOS::Used = 0 THEN CLOSE(PERNOS).
  END
  IF WindowOpened
    INISaveWindow('UpdateKAD_RIK','winlats.INI')
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
MODIFYSCREEN    ROUTINE
   IF RIK:TIPS='K'  !KADRI
      UNHIDE(?RIK:Z_KODS)
      UNHIDE(?RIK:Z_KODS:Prompt)
      ?RIK:DOK_NR:Prompt{PROP:TEXT}='Dokumenta &Nr:'
      UNHIDE(?RIK:DATUMS1:Prompt)
      UNHIDE(?RIK:DATUMS1)
      ?RIK:DATUMS1:Prompt{PROP:TEXT}='&Datums no:'
      UNHIDE(?RIK:DATUMS2:Prompt)
      UNHIDE(?RIK:DATUMS2)
      ?RIK:DATUMS2:Prompt{PROP:TEXT}='&Datums lîdz:'
   ELSIF RIK:TIPS='A'  !ATVAÏINÂJUMI
      HIDE(?RIK:Z_KODS)
      HIDE(?RIK:Z_KODS:Prompt)
      ?RIK:DOK_NR:Prompt{PROP:TEXT}='Dokumenta &Nr:'
      UNHIDE(?RIK:DATUMS1:Prompt)
!      UNHIDE(?ButtonNoLidz)
      UNHIDE(?RIK:DATUMS1)
      ?RIK:DATUMS1:Prompt{PROP:TEXT}='&Datums no:'
      UNHIDE(?RIK:DATUMS2)
      ?RIK:DATUMS2:Prompt{PROP:TEXT}='&Datums lîdz:'
      UNHIDE(?RIK:DATUMS1:Prompt)
      UNHIDE(?RIK:DATUMS2:Prompt)
      IF ~(OPCIJA='A') !NETIEK SAUKTS NO ATVAÏINÂJUMIEM
         UNHIDE(?ButtonAtvalinajumi)
      .
   ELSIF RIK:TIPS='I'  !MÂCÎBU IESTÂDES, KURSI
      HIDE(?RIK:Z_KODS)
      HIDE(?RIK:Z_KODS:Prompt)
      ?RIK:DOK_NR:Prompt{PROP:TEXT}='Apliecîbas &Nr:'
      UNHIDE(?RIK:DATUMS1:Prompt)
      UNHIDE(?RIK:DATUMS1)
      ?RIK:DATUMS1:Prompt{PROP:TEXT}='&Datums no:'
      UNHIDE(?RIK:DATUMS2:Prompt)
      UNHIDE(?RIK:DATUMS2)
      ?RIK:DATUMS2:Prompt{PROP:TEXT}='&Datums lîdz:'
!      UNHIDE(?ButtonNoLidz)
   ELSIF RIK:TIPS='B'  !BÇRNI
      HIDE(?RIK:Z_KODS)
      HIDE(?RIK:Z_KODS:Prompt)
      ?RIK:DOK_NR:Prompt{PROP:TEXT}='Dzimðanas apl.&Nr:'
      UNHIDE(?RIK:DATUMS1:Prompt)
      UNHIDE(?RIK:DATUMS1)
      ?RIK:DATUMS1:Prompt{PROP:TEXT}='Dzimðanas &Datums:'
      RIK:DATUMS1{PROP:REQ}='A'
!      STOP(RIK:DATUMS1{PROP:REQ})
      HIDE(?RIK:DATUMS2:Prompt)
      HIDE(?RIK:DATUMS2)
!      HIDE(?ButtonNoLidz)
   ELSE !RIK:TIPS='C'
      HIDE(?RIK:Z_KODS)
      HIDE(?RIK:Z_KODS:Prompt)
      ?RIK:DOK_NR:Prompt{PROP:TEXT}='Dokumenta &Nr:'
!      HIDE(?ButtonNoLidz)
!      HIDE(?RIK:DATUMS1)
!      HIDE(?RIK:DATUMS2)
!      HIDE(?RIK:DATUMS1:Prompt)
!      HIDE(?RIK:DATUMS2:Prompt)
      UNHIDE(?RIK:DATUMS1)
      UNHIDE(?RIK:DATUMS2)
      UNHIDE(?RIK:DATUMS1:Prompt)
      UNHIDE(?RIK:DATUMS2:Prompt)
      HIDE(?ButtonAtvalinajumi)
      UNHIDE(?ButtonDN)
      UNHIDE(?ButtonDN0)
!      HIDE(?ButtonNoLidz)
   .
   IF RIK:TIPS='F' !profesijas koda izmaiòa
      RIK:Z_KODS = 255
   .


DOCFILE    ROUTINE
  TTAKA"=PATH()
  IF UPPER(RIK:R_FAILS)='R'&CLIP(RIK:U_NR)&'.DOC' !VECIE R-VÂRDI
     ANSIFILENAME = DOCFOLDER&'\'&RIK:R_FAILS     !VECAIS FOLDERIS
     NEWAFILENAME = DOCFOLDERK&'\'&FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
     RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
     JAMAINA=TRUE
  ELSIF ~(UPPER(SAV_R_FAILS)=UPPER(RIK:R_FAILS)) !MAINÎTS F_VÂRDS
     ANSIFILENAME = DOCFOLDERK&'\'&SAV_R_FAILS
     NEWAFILENAME = DOCFOLDERK&'\'&RIK:R_FAILS
!!!     JAMAINA=TRUE
  ELSE
     JAMAINA=FALSE
  .
  IF JAMAINA=TRUE
     IF DOS_CONT(ANSIFILENAME,1)
        RENAME(ANSIFILENAME,NEWAFILENAME)
        IF ERROR() THEN STOP(CLIP(RIK:R_FAILS)&' '&ERROR()).
     .
  .
  ANSIFILENAME = DOCFOLDERK&'\'&RIK:R_FAILS
!  IF DOS_CONT(DOCFOLDERK&'\'&RIK:R_FAILS,1)
  IF DOS_CONT(ANSIFILENAME,1)
     UNHIDE(?ImageBytes)
  .
  IF ~RIK:ID
     UNHIDE(?ImageVR)
  .
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?RIK:U_NR
      RIK:U_NR = History::RIK:Record.U_NR
    OF ?RIK:DOK_NR
      RIK:DOK_NR = History::RIK:Record.DOK_NR
    OF ?RIK:DATUMS
      RIK:DATUMS = History::RIK:Record.DATUMS
    OF ?RIK:DATUMS1
      RIK:DATUMS1 = History::RIK:Record.DATUMS1
    OF ?RIK:DATUMS2
      RIK:DATUMS2 = History::RIK:Record.DATUMS2
    OF ?RIK:TIPS
      RIK:TIPS = History::RIK:Record.TIPS
    OF ?RIK:Z_KODS
      RIK:Z_KODS = History::RIK:Record.Z_KODS
    OF ?RIK:SATURS
      RIK:SATURS = History::RIK:Record.SATURS
    OF ?RIK:SATURS1
      RIK:SATURS1 = History::RIK:Record.SATURS1
    OF ?RIK:ID
      RIK:ID = History::RIK:Record.ID
    OF ?RIK:ACC_KODS
      RIK:ACC_KODS = History::RIK:Record.ACC_KODS
    OF ?RIK:ACC_DATUMS
      RIK:ACC_DATUMS = History::RIK:Record.ACC_DATUMS
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  RIK:Record = SAV::RIK:Record
  SAV::RIK:Record = RIK:Record
  Auto::Attempts = 0
  LOOP
    SET(RIK:NR_KEY)
    PREVIOUS(KAD_RIK)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:RIK:U_NR = 1
    ELSE
      Auto::Save:RIK:U_NR = RIK:U_NR + 1
    END
    RIK:Record = SAV::RIK:Record
    RIK:U_NR = Auto::Save:RIK:U_NR
    SAV::RIK:Record = RIK:Record
    ADD(KAD_RIK)
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
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
    IF OriginalRequest = InsertRecord
      IF LocalResponse = RequestCancelled
        DELETE(KAD_RIK)
      END
    END
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

BrowseKAD_RIK PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
SATURS               STRING(120)
SAV_ID               USHORT
VUT                  STRING(35)

BRW1::View:Browse    VIEW(KAD_RIK)
                       PROJECT(RIK:DOK_NR)
                       PROJECT(RIK:DATUMS)
                       PROJECT(RIK:DATUMS1)
                       PROJECT(RIK:DATUMS2)
                       PROJECT(RIK:TIPS)
                       PROJECT(RIK:Z_KODS)
                       PROJECT(RIK:U_NR)
                       PROJECT(RIK:ID)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::RIK:DOK_NR       LIKE(RIK:DOK_NR)           ! Queue Display field
BRW1::RIK:DATUMS       LIKE(RIK:DATUMS)           ! Queue Display field
BRW1::RIK:DATUMS1      LIKE(RIK:DATUMS1)          ! Queue Display field
BRW1::RIK:DATUMS2      LIKE(RIK:DATUMS2)          ! Queue Display field
BRW1::RIK:TIPS         LIKE(RIK:TIPS)             ! Queue Display field
BRW1::RIK:Z_KODS       LIKE(RIK:Z_KODS)           ! Queue Display field
BRW1::SATURS           LIKE(SATURS)               ! Queue Display field
BRW1::RIK:U_NR         LIKE(RIK:U_NR)             ! Queue Display field
BRW1::OPCIJA_NR        LIKE(OPCIJA_NR)            ! Queue Display field
BRW1::RIK:ID           LIKE(RIK:ID)               ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:Reset:SAV_ID LIKE(SAV_ID)
BRW1::Sort6:KeyDistribution LIKE(RIK:DATUMS),DIM(100)
BRW1::Sort6:LowValue LIKE(RIK:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort6:HighValue LIKE(RIK:DATUMS)            ! Queue position of scroll thumb
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Kad_Rik.tps'),AT(,,429,314),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseRikojumi'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,411,266),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('43R(1)|M~Dok. Nr~C(0)@S10@45C|M~Dok.Dat~@D06.@45C|M~Datums no~@D06.B@45C|M~Datum' &|
   's lîdz~@D06.B@10C|M~T~@s1@12C|M~ZK~@n3B@280L(1)|M~Saturs~@s120@23R(1)|M~U NR~C(0' &|
   ')@n5@'),FROM(Queue:Browse:1)
                       BUTTON('&Ievadît'),AT(224,294,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(273,294,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dzçst'),AT(321,294,45,14),USE(?Delete:3)
                       BUTTON('&Beigt'),AT(373,294,45,14),USE(?Close)
                       BUTTON('Skatît dokumentus (doc,pdf,jpg)'),AT(109,294,111,14),USE(?ButtonRD)
                       SHEET,AT(0,0,425,291),USE(?CurrentTab)
                         TAB('Visi'),USE(?Tab1)
                           STRING('DDMMYY:'),AT(18,297),USE(?String1)
                           ENTRY(@D06.B),AT(54,295,40,12),USE(RIK:DATUMS)
                         END
                         TAB('1 darbinieks'),USE(?Tab2)
                         END
                         TAB('Nepersonalizçtie'),USE(?Tab3)
                         END
                         TAB('Pavçles kadriem'),USE(?Tab4)
                         END
                         TAB('Rîkojumi'),USE(?Tab5)
                         END
                         TAB('Protokoli'),USE(?Tab6)
                         END
                       END
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF OPCIJA_NR !NO UPD_KADRIEM vai BRK(4)
     SAV_ID=KAD:ID
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
      IF OPCIJA_NR   !NO UPDATEKADRI VAI BRKADRI
         EXECUTE OPCIJA_NR
           ?Tab2{PROP:TEXT}='Rîkojumi'
           ?Tab2{PROP:TEXT}='Mâcîbu iestâdes, kursi'
           ?Tab2{PROP:TEXT}='Bçrni lîdz 18.g.v.'
           ?Tab2{PROP:TEXT}=GETKADRI(KAD:ID,2,1)  !NO BRKADRI
         .
         EXECUTE OPCIJA_NR
           RIK_TIPS='C'
           RIK_TIPS='I'
           RIK_TIPS='B'
           RIK_TIPS='C'
         .
         HIDE(?Tab1)
         HIDE(?Tab3)
         HIDE(?Tab4)
         HIDE(?Tab5)
         HIDE(?Tab6)
      .
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
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        ID=RIK:ID
        IF ~OPCIJA_NR !~NO KADRIEM
           EXECUTE CHOICE(?CurrentTab)
              RIK_TIPS='C'
              RIK_TIPS='C'
              RIK_TIPS='C'
              RIK_TIPS='K'
              RIK_TIPS='C'
              RIK_TIPS='P'
           .
        .
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonRD
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           TTAKA"=PATH()
           IF CHOICE(?CurrentTab) = 1 !VISI
              ANSIFILENAME='*.*'
              IF FILEDIALOG('...VISI FAILI ',ANSIFILENAME,'*|'&DOCFOLDERK&'\*.*',0)
        !         F:DBF=UPPER(ANSIFILENAME[LEN(ANSIFILENAME)-2])
                 ANSIJOB
              .
           ELSiF CHOICE(?CurrentTab) = 2 !1 KADRS
              ANSIFILENAME=FORMAT(KAD:ID,@N04)&'*.*'
              VUT = GETKADRI(KAD:ID,2,1)
        !      IF FILEDIALOG('...TIKAI '&FORMAT(KAD:ID,@N04)&'*.* FAILI ',ANSIFILENAME,'*|'&DOCFOLDERK&'\'&|
              IF FILEDIALOG(VUT,ANSIFILENAME,'*|'&DOCFOLDERK&'\'&FORMAT(KAD:ID,@N04)&'*.*',0)
        !         F:DBF=UPPER(ANSIFILENAME[LEN(ANSIFILENAME)-2])
                 ANSIJOB
              .
           ELSE
              ANSIFILENAME='0000*.*'
              VUT = 'Nepersonalizçtie'
        !      IF FILEDIALOG('...TIKAI '&FORMAT(KAD:ID,@N04)&'*.* FAILI ',ANSIFILENAME,'*|'&DOCFOLDERK&'\'&|
              IF FILEDIALOG(VUT,ANSIFILENAME,'*|'&DOCFOLDERK&'\0000*.*',0)
        !         F:DBF=UPPER(ANSIFILENAME[LEN(ANSIFILENAME)-2])
                 ANSIJOB
              .
           .
           SETPATH(TTAKA")
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        SAV_ID=RIK:ID
        SELECT(?BROWSE:1)
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
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseKAD_RIK','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('OPCIJA_NR',OPCIJA_NR)
  BIND('SAV_ID',SAV_ID)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
  END
  IF WindowOpened
    INISaveWindow('BrowseKAD_RIK','winlats.INI')
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
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSIF CHOICE(?CurrentTab) = 3
    BRW1::SortOrder = 2
  ELSIF CHOICE(?CurrentTab) = 4
    BRW1::SortOrder = 3
  ELSIF CHOICE(?CurrentTab) = 5
    BRW1::SortOrder = 4
  ELSIF CHOICE(?CurrentTab) = 6
    BRW1::SortOrder = 5
  ELSE
    BRW1::SortOrder = 6
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:SAV_ID <> SAV_ID
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:SAV_ID = SAV_ID
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 6
    BRW1::Sort6:HighValue = RIK:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 6
    BRW1::Sort6:LowValue = RIK:DATUMS
    SetupRealStops(BRW1::Sort6:LowValue,BRW1::Sort6:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort6:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  RIK:DOK_NR = BRW1::RIK:DOK_NR
  RIK:DATUMS = BRW1::RIK:DATUMS
  RIK:DATUMS1 = BRW1::RIK:DATUMS1
  RIK:DATUMS2 = BRW1::RIK:DATUMS2
  RIK:TIPS = BRW1::RIK:TIPS
  RIK:Z_KODS = BRW1::RIK:Z_KODS
  SATURS = BRW1::SATURS
  RIK:U_NR = BRW1::RIK:U_NR
  OPCIJA_NR = BRW1::OPCIJA_NR
  RIK:ID = BRW1::RIK:ID
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  IF RIK:ID AND ~OPCIJA_NR ! ~NO KADRIEM
     SATURS=CLIP(GETKADRI(RIK:ID,0,1))&' '&CLIP(RIK:SATURS)&' '&RIK:SATURS1
  ELSE
     SATURS=CLIP(RIK:SATURS)&' '&RIK:SATURS1
  .
  BRW1::RIK:DOK_NR = RIK:DOK_NR
  BRW1::RIK:DATUMS = RIK:DATUMS
  BRW1::RIK:DATUMS1 = RIK:DATUMS1
  BRW1::RIK:DATUMS2 = RIK:DATUMS2
  BRW1::RIK:TIPS = RIK:TIPS
  BRW1::RIK:Z_KODS = RIK:Z_KODS
  BRW1::SATURS = SATURS
  BRW1::RIK:U_NR = RIK:U_NR
  BRW1::OPCIJA_NR = OPCIJA_NR
  BRW1::RIK:ID = RIK:ID
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
      OF 2
      OF 3
      OF 4
      OF 5
      OF 6
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort6:KeyDistribution[BRW1::CurrentScroll] => RIK:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  CASE BRW1::SortOrder
  OF 1
  OROF 2
  OROF 3
  OROF 4
  OROF 5
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
  END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
      OF 2
        IF CHR(KEYCHAR())
          IF UPPER(SUB(RIK:ID,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(RIK:ID,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            RIK:ID = CHR(KEYCHAR())
            CLEAR(RIK:DATUMS,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 3
      OF 4
        IF CHR(KEYCHAR())
          IF UPPER(SUB(RIK:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(RIK:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            RIK:DATUMS = CHR(KEYCHAR())
            CLEAR(RIK:DOK_NR,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 5
        IF CHR(KEYCHAR())
          IF UPPER(SUB(RIK:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(RIK:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            RIK:DATUMS = CHR(KEYCHAR())
            CLEAR(RIK:DOK_NR,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 6
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 6
      RIK:DATUMS = BRW1::Sort6:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'KAD_RIK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:ID_KEY)
      RESET(RIK:ID_KEY,BRW1::HighlightedPosition)
    ELSE
      RIK:ID = SAV_ID
      SET(RIK:ID_KEY,RIK:ID_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'RIK:ID = SAV_ID AND (~OPCIJA_NR OR (opcija_nr=1 and INSTRING(rik:tips,' & |
    '''KACF'')) OR (opcija_nr=2 and rik:tips=''I'') OR (opcija_nr=3 and rik:tip' & |
    's=''B'') OR (opcija_nr=4))'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:ID_KEY)
      RESET(RIK:ID_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(RIK:ID_KEY,RIK:ID_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:ID=0)'
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:DAT_DKEY)
      RESET(RIK:DAT_DKEY,BRW1::HighlightedPosition)
    ELSE
      SET(RIK:DAT_DKEY,RIK:DAT_DKEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''K'')'
  OF 4
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:DAT_DKEY)
      RESET(RIK:DAT_DKEY,BRW1::HighlightedPosition)
    ELSE
      SET(RIK:DAT_DKEY,RIK:DAT_DKEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''C'')'
  OF 5
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:DAT_DKEY)
      RESET(RIK:DAT_DKEY,BRW1::HighlightedPosition)
    ELSE
      SET(RIK:DAT_DKEY,RIK:DAT_DKEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''P'')'
  OF 6
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(RIK:DAT_DKEY)
      RESET(RIK:DAT_DKEY,BRW1::HighlightedPosition)
    ELSE
      SET(RIK:DAT_DKEY,RIK:DAT_DKEY)
    END
    BRW1::View:Browse{Prop:Filter} = ''
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(RIK:Record)
    BRW1::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    RIK:ID = SAV_ID
    SET(RIK:ID_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'RIK:ID = SAV_ID AND (~OPCIJA_NR OR (opcija_nr=1 and INSTRING(rik:tips,' & |
    '''KACF'')) OR (opcija_nr=2 and rik:tips=''I'') OR (opcija_nr=3 and rik:tip' & |
    's=''B'') OR (opcija_nr=4))'
  OF 2
    SET(RIK:ID_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:ID=0)'
  OF 3
    SET(RIK:DAT_DKEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''K'')'
  OF 4
    SET(RIK:DAT_DKEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''C'')'
  OF 5
    SET(RIK:DAT_DKEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(RIK:TIPS=''P'')'
  OF 6
    SET(RIK:DAT_DKEY)
    BRW1::View:Browse{Prop:Filter} = ''
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW1::SortOrder
  OF 1
    SAV_ID = BRW1::Sort1:Reset:SAV_ID
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(KAD_RIK,0)
  CLEAR(RIK:Record,0)
  CASE BRW1::SortOrder
  OF 1
    RIK:ID = BRW1::Sort1:Reset:SAV_ID
  END
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateKAD_RIK) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateKAD_RIK
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(KAD_RIK,0)
        CLEAR(RIK:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


UpdateAmati PROCEDURE


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
NODTEXT              STRING(25)
PROTEXT              STRING(25)
Update::Reloop  BYTE
Update::Error   BYTE
History::AMS:Record LIKE(AMS:Record),STATIC
SAV::AMS:Record      LIKE(AMS:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Amati.tps'),AT(,,247,98),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateAmati'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,4,243,74),USE(?CurrentTab)
                         TAB('Amats'),USE(?Tab:1)
                           ENTRY(@s25),AT(12,26,125,10),USE(AMS:AMATS),LEFT(1)
                           STRING(@s5),AT(139,26),USE(AMS:AMA_A)
                           STRING('sâkas ar U. -uzò. lîgums'),AT(163,26,81,10),USE(?String6),LEFT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           BUTTON('&Nodaïa'),AT(9,40,41,14),USE(?ButtonNodala)
                           STRING(@s2),AT(51,43),USE(AMS:NODALA)
                           STRING(@s25),AT(64,43),USE(NODTEXT)
                           BUTTON('Objekts/&Projekts'),AT(10,58,65,14),USE(?ButtonNodala:2)
                           STRING(@n_6B),AT(76,60),USE(AMS:OBJ_NR)
                           STRING(@s25),AT(105,60),USE(PROTEXT)
                         END
                       END
                       BUTTON('&OK'),AT(151,82,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(200,82,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  NODTEXT =GETNODALAS(AMS:NODALA,1)
  PROTEXT =GETPROJEKTI(AMS:OBJ_NR,1)
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
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
      SELECT(?AMS:AMATS)
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
        History::AMS:Record = AMS:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(AMATI)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?AMS:AMATS)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::AMS:Record <> AMS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:AMATI(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?AMS:AMATS)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
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
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?AMS:AMATS
      CASE EVENT()
      OF EVENT:Accepted
        AMS:AMA_A=INIGEN(AMS:AMATS,5,1)
      END
    OF ?ButtonNodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           AMS:NODALA=NOD:U_NR
           NODTEXT =GETNODALAS(AMS:NODALA,1)
           DISPLAY
        .
      END
    OF ?ButtonNodala:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           AMS:OBJ_NR=PRO:U_NR
           PROTEXT =GETPROJEKTI(AMS:OBJ_NR,1)
           DISPLAY
        .
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AMATI::Used = 0
    CheckOpen(AMATI,1)
  END
  AMATI::Used += 1
  BIND(AMS:RECORD)
  FilesOpened = True
  RISnap:AMATI
  SAV::AMS:Record = AMS:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:AMATI()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdateAmati','winlats.INI')
  WinResize.Resize
  ?AMS:AMATS{PROP:Alrt,255} = 734
  ?AMS:AMA_A{PROP:Alrt,255} = 734
  ?AMS:NODALA{PROP:Alrt,255} = 734
  ?AMS:OBJ_NR{PROP:Alrt,255} = 734
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
    AMATI::Used -= 1
    IF AMATI::Used = 0 THEN CLOSE(AMATI).
  END
  IF WindowOpened
    INISaveWindow('UpdateAmati','winlats.INI')
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?AMS:AMATS
      AMS:AMATS = History::AMS:Record.AMATS
    OF ?AMS:AMA_A
      AMS:AMA_A = History::AMS:Record.AMA_A
    OF ?AMS:NODALA
      AMS:NODALA = History::AMS:Record.NODALA
    OF ?AMS:OBJ_NR
      AMS:OBJ_NR = History::AMS:Record.OBJ_NR
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  AMS:Record = SAV::AMS:Record
  SAV::AMS:Record = AMS:Record
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

