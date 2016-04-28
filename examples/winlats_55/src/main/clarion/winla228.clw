                     MEMBER('winlats.clw')        ! This is a MEMBER module
S_MEHVISI            PROCEDURE                    ! Declare Procedure
DAT                  LONG
LAI                  LONG
NPK                  USHORT
MEH_ID               LONG
VARUZV               STRING(50)

K_NETONE             DECIMAL(12,2)
K_NETOLE             DECIMAL(7,2)
K_NAUDAE             DECIMAL(12,2)
K_LAIKSE             DECIMAL(7,2)
K_NETONR             DECIMAL(12,2)
K_NETOLR             DECIMAL(7,2)
K_NAUDAR             DECIMAL(12,2)
K_LAIKSR             DECIMAL(7,2)
K_LAIKS              DECIMAL(7,2)

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

K_table           QUEUE,PRE(K)
ID                   USHORT
LAIKSE               DECIMAL(7,2)   !LAIKS PASÛTÎJUMIEM
NETONE               DECIMAL(12,2)  !CIK REÂLI IR SAMAKSÂTS
NAUDAE               DECIMAL(12,2)  !CIK BIJA JÂMAKSÂ
LAIKSR               DECIMAL(7,2)   !LAIKS IEKÐÇJIEM PASÛTÎJUMIEM
NETONR               DECIMAL(12,2)  !CIK REÂLI IR SAMAKSÂTS
NAUDAR               DECIMAL(12,2)  !CIK BIJA JÂMAKSÂ
                  .
DTEKSTS             STRING(25)
VIRSRAKSTS          STRING(60)
LAIKSK               DECIMAL(7,2)
NETONK               DECIMAL(12,2)
NAUDAK               DECIMAL(12,2)

!-----------------------------------------------------------------------------
Process:View         VIEW(AUTODARBI)
                       PROJECT(APD:PAV_NR)
                       PROJECT(APD:ID)
                       PROJECT(APD:LAIKS)
                       PROJECT(APD:GARANTIJA)
                       PROJECT(APD:BAITS)
                     END

report REPORT,AT(500,1490,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,198,8000,1292),USE(?unnamed)
         STRING(@P<<<#. lapaP),AT(6510,729,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(208,1250,7240,0),COLOR(COLOR:Black)
         STRING(@s60),AT(1479,365,4667,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2750,677,2188,260),USE(DTEKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,990,0,313),COLOR(COLOR:Black)
         STRING('NPK'),AT(354,1042),USE(?String26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mehâniía ID'),AT(729,1042,823,208),USE(?String26:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(1719,1042,1979,208),USE(?String26:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Stundu skaits kopâ'),AT(3750,1042,1198,208),USE(?String26:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto ieòçmumi kopâ'),AT(5000,1042,1198,208),USE(?String26:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòçmumi kopâ'),AT(6250,1042,1198,208),USE(?String26:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,990,0,313),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(6198,990,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(3698,990,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(4948,990,0,313),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(1552,990,0,313),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s45),AT(1656,52,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,990,7240,0),COLOR(COLOR:Black)
         LINE,AT(677,990,0,313),COLOR(COLOR:Black)
       END
DetailE DETAIL,AT(,,8000,177),USE(?unnamed:3)
         LINE,AT(208,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(1552,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         STRING(@s40),AT(1594,0,2073,156),USE(VARUZV),LEFT
         STRING(@N_7B),AT(927,0,,156),USE(MEH_ID),RIGHT
         STRING(@N_7.2B),AT(4219,0,,156),USE(K:LAIKSE),RIGHT
         STRING(@N-_12.2B),AT(5208,0,,156),USE(K:NETONE),RIGHT
         STRING(@N-_12.2B),AT(6458,0,,156),USE(K:NAUDAE),RIGHT
         LINE,AT(7448,0,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         LINE,AT(208,156,7240,0),USE(?Line16),COLOR(COLOR:Black)
         STRING(@n3B),AT(365,0,,156),USE(NPK,,?NPK:2),RIGHT
       END
DetailR DETAIL,AT(,,8000,177),USE(?unnamed:4)
         LINE,AT(208,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(1552,-31,0,198),USE(?Line12R),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,198),USE(?Line12:4R),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,198),USE(?Line12:3R),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,198),USE(?Line12:2R),COLOR(COLOR:Black)
         STRING(@s40),AT(1594,0,,156),USE(VARUZV,,?VARUZV:R),LEFT
         STRING(@N_7B),AT(917,0,,156),USE(MEH_ID,,?MEH_ID:R),RIGHT
         STRING(@N_7.2B),AT(4219,0,,156),USE(K:LAIKSR),RIGHT
         STRING(@N-_12.2B),AT(6458,0,,156),USE(K:NAUDAR),RIGHT
         STRING(@N-_12.2B),AT(5208,0,,156),USE(K:NETONR),RIGHT
         LINE,AT(7448,0,0,198),USE(?Line12:5R),COLOR(COLOR:Black)
         LINE,AT(208,156,7240,0),USE(?Line16R),COLOR(COLOR:Black)
         STRING(@n3B),AT(365,0,,156),USE(NPK),RIGHT
       END
FOOTER DETAIL,AT(,,,354),USE(?unnamed:2)
         LINE,AT(208,-10,0,166),USE(?Line17),COLOR(COLOR:Black)
         STRING(@N_7.2B),AT(4219,0,,156),USE(LAIKSK),RIGHT
         LINE,AT(4948,0,0,166),USE(?Line17:2),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5208,0,,156),USE(NETONK),RIGHT
         LINE,AT(6198,0,0,166),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(7448,0,0,166),USE(?Line17:7),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6458,0,,156),USE(NAUDAK),RIGHT
         LINE,AT(208,156,7240,0),USE(?Line23),COLOR(COLOR:Black)
         STRING(@D06.),AT(6365,198),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6958,198),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING('Kopâ :'),AT(729,0,885,156),USE(?String26:6),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,-10,0,166),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,166),USE(?Line17:6),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,9000,8000,219)
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

APMAKSASCREEN WINDOW('Caption'),AT(,,179,64),CENTER,GRAY
       IMAGE('CHECK3.ICO'),AT(150,16,17,18),USE(?ImageKRI),HIDE
       BUTTON('Meklçt P/Z apmaksu (Neto ieòçmumus)'),AT(8,18,139,14),USE(?ButtonKRI)
       BUTTON('OK'),AT(136,41,35,14),USE(?Ok),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  DAT = TODAY()
  LAI = CLOCK()
!
  F:DBF='W'   !PAGAIDÂM
!
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  F:KRI=''
  RAKSTI#=0
  OPEN(APMAKSASCREEN)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?BUTTONKRI
        CASE EVENT()
        OF EVENT:ACCEPTED
           IF F:KRI
              F:KRI=''
              HIDE(?IMAGEKRI)
           ELSE
              F:KRI='1' !MEKLÇT APMAKSAS
              UNHIDE(?IMAGEKRI)
           .
        .
     OF ?OK
        CASE EVENT()
        OF EVENT:ACCEPTED
           BREAK
        .
     .
  .
  CLOSE(APMAKSASCREEN)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(APD:RECORD)
  BIND('ID',ID)
  BIND('F:NODALA',F:NODALA)

  VIRSRAKSTS='Mehâniíu darba laika kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  IF F:NODALA
     DTEKSTS='Nodaïa Nr '&F:NODALA
  ELSIF ID
     DTEKSTS=CLIP(KAD:Var)&' '&CLIP(KAD:Uzv)
  ELSE
     DTEKSTS='Visi mehâniíi'
  .
  DTEKSTS=CLIP(DTEKSTS)&' '&F:DIENA
  FilesOpened = True
  RecordsToProcess = RECORDS(AUTODARBI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Mehâniíu darba stundu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTODARBI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:CloseWindow
       BREAK
    OF Event:OpenWindow
      CLEAR(APD:RECORD)
      APD:DATUMS=S_DAT
      SET(APD:DAT_KEY,APD:DAT_KEY)
      Process:View{Prop:Filter} = '~(ID AND ~(APD:ID=ID))'
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
!         STOP(F:NODALA&'='&GETKADRI(APD:ID,0,5))
         IF ~(F:NODALA AND ~(F:NODALA=GETKADRI(APD:ID,0,5))) AND|
            ~((F:DIENA='N' AND ~BAND(APD:BAITS,00000001b)) OR (F:DIENA='D' AND BAND(APD:BAITS,000000001b)))
            I#=GETPAVADZ(APD:PAV_NR)        !POZICIONÇJAM P/Z
            IF PAV:D_K='K'
               K_NETONE =0
               K_NETOLE =0
               K_NAUDAE =0
               K_LAIKSE =0
               K_NETONR =0
               K_NETOLR =0
               K_NAUDAR =0
               K_LAIKSR =0
               FOUND#=FALSE
               CLEAR(NOL:RECORD)
               NOL:U_NR=APD:PAV_NR
               NOL:NOMENKLAT=APD:NOMENKLAT
               SET(NOL:NR_KEY,NOL:NR_KEY)
               LOOP
                  NEXT(NOLIK)
                  IF ERROR() OR ~(NOL:U_NR=APD:PAV_NR AND NOL:NOMENKLAT=APD:NOMENKLAT) THEN BREAK.
                  IF ((BAND(APD:BAITS,00000001b) AND BAND(NOL:BAITS,00000100b)) OR| !NAKTS
                  (~BAND(APD:BAITS,00000001b) AND ~BAND(NOL:BAITS,00000100b)))      !DIENA
                     FOUND#=TRUE
                     IF (F:DIENA='N' AND ~BAND(NOL:BAITS,00000100b)) OR (F:DIENA='D' AND BAND(NOL:BAITS,00000100b)) THEN CYCLE.
                     IF INRANGE(NOL:PAR_NR,26,50)  !RAÞOÐANA-IEKÐÇJAIS PASÛTÎJUMS
                        K_NAUDAR +=0              !NEBIJA JÂMAKSÂ ....
                        K_LAIKSR +=NOL:DAUDZUMS   !LAIKS
                     ELSE
                        K_NAUDAE +=CALCSUM(15,2)   !CIK BIJA JÂMAKSÂ
                        K_LAIKSE +=NOL:DAUDZUMS    !LAIKS
                     .
                     IF F:KRI !JÂMEKLÇ NETO APMAKSAS
                        CLEAR(GGK:RECORD)
                        GGK:PAR_NR=NOL:PAR_NR
                        SET(GGK:PAR_KEY,GGK:PAR_KEY)
                        LOOP
                           NEXT(GGK)
                           IF ERROR() OR ~(GGK:PAR_NR=NOL:PAR_NR) THEN BREAK.
      !                    IF GGK:REFERENCE=PAV:DOK_NR
      !                     IF GGK:REFERENCE=clip(pav:dok_se)&' '&clip(PAV:DOK_NR)
                           IF GGK:REFERENCE=pav:dok_senr
                              IF INRANGE(NOL:PAR_NR,26,50)  !RAÞOÐANA-IEKÐÇJAIS PASÛTÎJUMS
                                 K_NETONR +=CALCSUM(15,2)   !
                                 K_NETOLR +=NOL:DAUDZUMS
                              ELSE
                                 K_NETONE +=CALCSUM(15,2)    !CIK IR SAMAKSÂTS-PAGAIDÂM PIEÒEMAM, KA SAMAKSÂTS VISS
                                 K_NETOLE +=NOL:DAUDZUMS
                              .
                              BREAK                      !PAGAIDÂM
                           .
                        .
                     .
                  .
               .
               IF FOUND#=FALSE
                  KLUDA(0,'? NOMENKLATÛRA vai D/N AUTODARBI failâ '&FORMAT(APD:DATUMS,@D06.)&' U_NR='&CLIP(APD:PAV_NR)&|
                  ' NOM='&CLIP(APD:NOMENKLAT)&' ID='&APD:ID)
               .
               K_LAIKS=K_LAIKSR+K_LAIKSE
               IF K_LAIKS > 0
                  K:ID = APD:ID
                  GET(K_TABLE,K:ID)
                  IF ERROR()
                     K:ID=APD:ID
                     K:LAIKSE =(K_LAIKSE/K_LAIKS)*APD:LAIKS   !DARBINIEKA PATÇRÇTAIS LAIKS IEKÐÇJIEM PASÛTÎJUMIEM
                     K:NETONE =(K_NETONE/K_NETOLE)*APD:LAIKS  !VISU DARBINIEKU NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:NAUDAE =(K_NAUDAE/K_LAIKSE)*APD:LAIKS  !!VISU DARBINIEKU NOPELNÎTÂ NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:LAIKSR =(K_LAIKSR/K_LAIKS)*APD:LAIKS   !DARBINIEKA PATÇRÇTAIS LAIKS PASÛTÎJUMIEM
                     K:NETONR =(K_NETONR/K_NETOLR)*APD:LAIKS  !VISU DARBINIEKU NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:NAUDAR =(K_NAUDAR/K_LAIKSR)*APD:LAIKS  !!VISU DARBINIEKU NOPELNÎTÂ NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS

   !                  K:STUNDAS=APD:LAIKS                     !DARBINIEKA PATÇRÇTAIS LAIKS
   !                  K:NETO =(K_NETO/K_NETOST)*APD:LAIKS     !CIK VIÒAM PIENÂKAS NO NOÍERTÂS NOMENKLATÛRAS (NETO IEÒÇMUMS)
   !                  K:DARBI=(K_DARBI/K_DARBIST)*APD:LAIKS   !CIK VIÒAM VAJADZÇTU PIENÂKTIES NO NOÍERTÂS NOMENKLATÛRAS

                     ADD(K_TABLE)
                     SORT(K_TABLE,K:ID)
                  ELSE
                     K:LAIKSE +=(K_LAIKSE/K_LAIKS)*APD:LAIKS   !DARBINIEKA PATÇRÇTAIS LAIKS IEKÐÇJIEM PASÛTÎJUMIEM
                     K:NETONE +=(K_NETONE/K_NETOLE)*APD:LAIKS  !VISU DARBINIEKU NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:NAUDAE +=(K_NAUDAE/K_LAIKSE)*APD:LAIKS  !!VISU DARBINIEKU NOPELNÎTÂ NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:LAIKSR +=(K_LAIKSR/K_LAIKS)*APD:LAIKS   !DARBINIEKA PATÇRÇTAIS LAIKS PASÛTÎJUMIEM
                     K:NETONR +=(K_NETONR/K_NETOLR)*APD:LAIKS  !VISU DARBINIEKU SAÒEMTÂ NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS
                     K:NAUDAR +=(K_NAUDAR/K_LAIKSR)*APD:LAIKS  !VISU DARBINIEKU NOPELNÎTÂ NAUDA/VISU LAIKU * KONKRÇTÂ LAIKS

   !                  K:STUNDAS+=APD:LAIKS
   !                  K:NETO +=(K_NETO/K_NETOST)*APD:LAIKS     !CIK VIÒAM PIENÂKAS NO NOÍERTÂS NOMENKLATÛRAS
   !                  K:DARBI+=(K_DARBI/K_DARBIST)*APD:LAIKS   !CIK VIÒAM VAJADZÇTU PIENÂKTIES NO NOÍERTÂS NOMENKLATÛRAS

                     PUT(K_TABLE)
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
  IF SEND(AUTODARBI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       NPK#+=1
       NPK=NPK#
       MEH_ID =K:ID
       VARUZV =GETKADRI(K:ID,0,1)
       IF K:LAIKSE
          PRINT(RPT:DETAILE)
          NPK=0
          MEH_ID =''
       .
       IF K:LAIKSR
          VARUZV=CLIP(VARUZV)&'-Iekðçjais pasûtîjums'
          PRINT(RPT:DETAILR)
       .
       LAIKSK +=K:LAIKSE+K:LAIKSR
       NETONK +=K:NETONE+K:NETONR
       NAUDAK +=K:NAUDAE+K:NAUDAR
    .
    IF F:DBF='W'
       PRINT(RPT:FOOTER)
       ENDPAGE(report)
    ELSE
    .
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
  IF ERRORCODE() OR APD:DATUMS > B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTODARBI')
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
S_MEH1               PROCEDURE                    ! Declare Procedure
VIRSRAKSTS          STRING(60)
MEHANIKIS           STRING(50)
DAT                 LONG
LAI                 LONG
K_ID                USHORT
LAPA                ULONG
VUT                 STRING(30)
DARBI               STRING(40)
NOS_P               STRING(35)
AUTOMAS             STRING(62)
NETO                DECIMAL(12,2)
NETOK               DECIMAL(12,2)
STSK                DECIMAL(7,2)
STSKK               DECIMAL(7,2)
NETOI               DECIMAL(12,2)
NETOIK              DECIMAL(12,2)
NPK                 ULONG

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
Process:View         VIEW(AUTODARBI)
                       PROJECT(APD:PAV_NR)
                       PROJECT(APD:DATUMS)
                       PROJECT(APD:ID)
                       PROJECT(APD:NOMENKLAT)
                       PROJECT(APD:LAIKS)
                       PROJECT(APD:GARANTIJA)
                       PROJECT(APD:BAITS)
                       PROJECT(APD:ACC_KODS)
                       PROJECT(APD:ACC_DATUMS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(200,1610,8000,9698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,10,8000,1604),USE(?unnamed:3)
         STRING(@s45),AT(1594,396,4635,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1333,667,5188,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('AV'),AT(7531,1302,156,208),USE(?String29:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6615,990,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(104,1198,0,417),COLOR(COLOR:Black)
         LINE,AT(417,1198,0,417),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,1302,260,208),USE(?String29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Lapa'),AT(448,1302,365,208),USE(?String29:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darbi'),AT(865,1302,2500,208),USE(?String29:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasûtîtâjs'),AT(3417,1302,2083,208),USE(?String29:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,1198,0,417),USE(?Line8:5),COLOR(COLOR:Black)
         STRING('Neto ieòç-'),AT(6073,1250,677,156),USE(?String29:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòçmumi'),AT(6802,1250,677,156),USE(?String29:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,1198,0,417),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(7500,1198,0,417),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(104,1563,7604,0),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(6771,1198,0,417),USE(?Line8:4),COLOR(COLOR:Black)
         STRING('mumi kopâ'),AT(6073,1406,677,156),USE(?String29:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(6802,1406,677,156),USE(?String29:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5521,1198,0,417),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(3385,1198,0,417),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(833,1198,0,417),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(104,1198,7604,0),COLOR(COLOR:Black)
         STRING(@s50),AT(208,969,3885,188),USE(MEHANIKIS),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Stundas'),AT(5552,1302,469,208),USE(?String29:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,8000,177)
         LINE,AT(104,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         STRING(@N_6.2),AT(5573,10,,156),USE(STSK),RIGHT
         LINE,AT(6042,-10,0,198),USE(?Line13:3),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@S1),AT(7531,10,156,156),USE(PAV:apm_k),CENTER
         LINE,AT(7708,-10,0,198),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(104,167,7604,0),USE(?Line15),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6094,10,625,156),USE(NETOI),RIGHT
         LINE,AT(6771,-10,0,198),USE(?Line13:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6823,10,625,156),USE(NETO),RIGHT
         STRING(@s35),AT(3427,10,2083,156),USE(NOS_P),LEFT
         STRING(@s40),AT(865,10,2500,156),USE(DARBI),LEFT
         STRING(@n_5),AT(469,10,313,156),USE(LAPA),RIGHT
         STRING(@n_4),AT(135,10,260,156),CNT,USE(NPK),RIGHT
       END
detail1 DETAIL,AT(,,,354),USE(?unnamed)
         LINE,AT(104,0,0,156),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(417,0,0,156),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(833,0,0,156),USE(?Line16:6),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,156),USE(?Line16:3),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,156),USE(?Line16:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,156),USE(?Line16:7),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,156),USE(?Line16:5),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,156),USE(?Line16:9),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,156),USE(?Line16:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6823,0,625,156),USE(NETOK),RIGHT
         LINE,AT(104,156,7604,0),USE(?Line22),COLOR(COLOR:Black)
         STRING(@N_7.2),AT(5573,0,417,156),USE(STSKK),RIGHT
         STRING(@D06.),AT(6646,188),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7240,188),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@N-_12.2B),AT(6094,0,625,156),USE(NETOIK),RIGHT
         STRING('Kopâ :'),AT(885,0,417,156),USE(?String29:6),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
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
APMAKSASCREEN WINDOW('Meklçt P/Z apmaksu'),AT(,,179,64),CENTER,GRAY
       IMAGE('CHECK3.ICO'),AT(150,16,17,18),USE(?ImageKRI),HIDE
       BUTTON('Meklçt P/Z apmaksu (Neto ieòçmumus)'),AT(8,18,139,14),USE(?ButtonKRI)
       BUTTON('OK'),AT(136,41,35,14),USE(?Ok),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  DAT = TODAY()
  LAI = CLOCK()
  NPK=0
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  VUT=GETKADRI(KAD:ID,0,1)
  F:KRI=''
  OPEN(APMAKSASCREEN)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?BUTTONKRI
        CASE EVENT()
        OF EVENT:ACCEPTED
           IF F:KRI
              F:KRI=''
              HIDE(?IMAGEKRI)
           ELSE
              F:KRI='1'
              UNHIDE(?IMAGEKRI)
           .
        .
     OF ?OK
        CASE EVENT()
        OF EVENT:ACCEPTED
           BREAK
        .
     .
  .
  CLOSE(APMAKSASCREEN)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(APD:RECORD)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = RECORDS(AUTODARBI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Mehâniía darba laika atskaite'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTODARBI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS = 'Mehâniía darba laika atskaite '&format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
      MEHANIKIS='Mehâniíis: '&ID&' '&VUT
      IF F:DIENA='D' !Diena
         MEHANIKIS=CLIP(MEHANIKIS)&' Diena'
      ELSIF F:DIENA='N' !Nakts
         MEHANIKIS=CLIP(MEHANIKIS)&' Nakts'
      .
      CLEAR(APD:RECORD)
      APD:ID=ID
      APD:DATUMS=S_DAT
      SET(APD:ID_Key,APD:ID_KEY)
      Process:View{Prop:Filter} = ''
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
         IF ~OPENANSI('MEH1.TXT')
            POST(Event:CloseWindow)
            CYCLE
         .
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         OUTA:LINE=CLIENT
         ADD(OUTFILEANSI)
         OUTA:LINE=VIRSRAKSTS
         ADD(OUTFILEANSI)
         OUTA:LINE=MEHANIKIS
         ADD(OUTFILEANSI)
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         IF F:DBF='E'
            OUTA:LINE='Npk'&CHR(9)&'Lapa'&CHR(9)&'Darbi'&CHR(9)&'Pasûtîtâjs'&CHR(9)&'Stundas'&CHR(9)&'Neto ieòçmumi'&|
            CHR(9)&'Ieòçmumi kopâ'&CHR(9)&'AV'&CHR(9)&'Auto'
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'kopâ'
            ADD(OUTFILEANSI)
         ELSE
            OUTA:LINE='Npk'&CHR(9)&'Lapa'&CHR(9)&'Darbi'&CHR(9)&'Pasûtîtâjs'&CHR(9)&'Stundas'&CHR(9)&'Neto ieòçmumi kopâ'&|
            CHR(9)&'Ieòçmumi kopâ'&CHR(9)&'AV'&CHR(9)&'Auto'
            ADD(OUTFILEANSI)
         END
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~((F:DIENA='N' AND ~BAND(APD:BAITS,00000001b)) OR (F:DIENA='D' AND BAND(APD:BAITS,000000001b)))
           NPK+=1
           I#=GETPAVADZ(APD:PAV_NR)
           LAPA=PAV:REK_NR
           DARBI=GETNOM_K(APD:NOMENKLAT,2,2)
           IF BAND(APD:BAITS,00000001b) AND ~(F:DIENA='N') !NAKTS
              DARBI=CLIP(DARBI)&'(N)'
           .
           NOS_P=GETPAR_K(PAV:PAR_NR,0,2)
           STSK = APD:LAIKS
           AUTOMAS=GETAUTO(PAV:VED_NR,10)
           NETO=0
           NETOI=0
           CLEAR(NOL:RECORD)
           NOL:U_NR=APD:PAV_NR
           NOL:NOMENKLAT=APD:NOMENKLAT
           SET(NOL:NR_KEY,NOL:NR_KEY)
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(NOL:U_NR=APD:PAV_NR AND NOL:NOMENKLAT=APD:NOMENKLAT) THEN BREAK.
              IF ((BAND(APD:BAITS,00000001b) AND BAND(NOL:BAITS,00000100b)) OR| !NAKTS
                 (~BAND(APD:BAITS,00000001b) AND ~BAND(NOL:BAITS,00000100b))) AND| !DIENA
                 NOL:D_K='K' !NAV PROJEKTS
                 NETO+=(APD:LAIKS/NOL:DAUDZUMS)*CALCSUM(15,2) !CIK BIJA JÂSAÒEM
              .
           .
!           IF NETO
           IF STSK
              IF F:KRI !JÂMEKLÇ APMAKSAS
                 CLEAR(GGK:RECORD)
                 GGK:PAR_NR=PAV:PAR_NR
                 SET(GGK:PAR_KEY,GGK:PAR_KEY)
                 LOOP
                    NEXT(GGK)
                    IF ERROR() OR ~(GGK:PAR_NR=PAV:PAR_NR) THEN BREAK.
                    IF GGK:REFERENCE=clip(pav:dok_senr)
  !                     NETOI+=(APD:LAIKS/NOL:DAUDZUMS)*CALCSUM(15,2)   !CIK IR SAMAKSÂTS - KÏÛDA !!!!
                        NETOI=NETO
                        BREAK
                    .
                 .
              .
              IF F:DBF='W'
                 PRINT(RPT:detail)
              ELSE
                 OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(LAPA,@N_5)&CHR(9)&DARBI&CHR(9)&NOS_P&CHR(9)&|
                 LEFT(FORMAT(STSK,@N_6.2))&CHR(9)&LEFT(FORMAT(NETOI,@N-_12.2))&CHR(9)&LEFT(FORMAT(NETO,@N-_12.2))&CHR(9)&|
                 PAV:APM_K&CHR(9)&AUTOMAS
                 ADD(OUTFILEANSI)
              END
              STSKK+=STSK
              NETOK+=NETO
              NETOIK+=NETOI
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
  IF SEND(AUTODARBI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:DETAIL1)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(STSKK,@N_6.2))&CHR(9)&LEFT(FORMAT(NETOIK,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(NETOK,@N-_12.2))
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
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
  IF ERRORCODE() OR APD:DATUMS > B_DAT OR ~(APD:ID=ID)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTODARBI')
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
S_AUTOKARTE          PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
DATUMS              LONG
DARBI               STRING(30)
RP                  DECIMAL(12,2)
RPK                 DECIMAL(12,2)
LAPA                ULONG
NOSKREJIENS         ULONG
NPK                 USHORT
KARTINA_TEXT        STRING(60)

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
Process:View         VIEW(AUTOAPK)
                       PROJECT(APK:PAV_NR)
                       PROJECT(APK:PAR_NR)
                       PROJECT(APK:AUT_NR)
                       PROJECT(APK:DATUMS)
                       PROJECT(APK:Nobraukums)
                       PROJECT(APK:CTRL_DATUMS)
                       PROJECT(APK:TEKSTS)
                       PROJECT(APK:SAVIRZE_P)
                       PROJECT(APK:SAVIRZE_A)
                       PROJECT(APK:AMORT_P)
                       PROJECT(APK:AMORT_A)
                       PROJECT(APK:BREMZES_P)
                       PROJECT(APK:BREMZES_A)
                       PROJECT(APK:KAROGI)
                       PROJECT(APK:ACC_KODS)
                       PROJECT(APK:ACC_DATUMS)
                     END

report REPORT,AT(500,1600,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,0,7990,1604),USE(?unnamed)
         STRING(@P<<<#. lapaP),AT(6250,1094,698,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(208,1563,6927,0),COLOR(COLOR:Black)
         STRING(@D06.),AT(2438,1021,740,198),USE(S_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(990,823,4896,156),USE(KARTINA_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1302,0,313),COLOR(COLOR:Black)
         STRING('Npk'),AT(365,1354),USE(?String26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Lapa'),AT(729,1354,521,208),USE(?String26:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1302,1354,729,208),USE(?String26:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,1302,0,313),USE(?Line8:5),COLOR(COLOR:Black)
         STRING('Daïas/Darbi'),AT(2969,1354,2656,208),USE(?String26:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5677,1354,1458,208),USE(?String26:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,1302,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(2031,1302,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(5625,1302,0,313),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(1250,1302,0,313),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s45),AT(1208,396,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noskrçjiens'),AT(2083,1354,833,208),USE(?String26:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1302,6927,0),COLOR(COLOR:Black)
         LINE,AT(677,1302,0,313),COLOR(COLOR:Black)
         STRING('-'),AT(3229,958,208,198),USE(?String24),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3438,1021),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,167)
         LINE,AT(208,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n4B),AT(333,0,,156),USE(npk),RIGHT
         STRING(@N-_12.2B),AT(5990,0,,156),USE(RP),RIGHT
         STRING(@n9b),AT(2104,0,719,156),USE(noskrejiens),RIGHT(1)
         STRING(@S40),AT(3021,0,2604,156),USE(DARBI),LEFT
         STRING(@D06.B),AT(1354,0,,156),USE(DATUMS),RIGHT
         STRING(@N_5B),AT(781,0,,156),USE(LAPA),RIGHT
       END
LINE   DETAIL,AT(,,7729,10)
         LINE,AT(208,0,6927,0),USE(?Line16),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,365),USE(?unnamed:2)
         LINE,AT(208,0,0,156),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,156),USE(?Line17:2),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5990,0,,156),USE(RPK),RIGHT
         LINE,AT(7135,0,0,156),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(208,156,6927,0),USE(?Line23),COLOR(COLOR:Black)
         STRING(@D06.),AT(6073,188),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6656,188),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING('Kopâ :'),AT(1302,0,677,156),USE(?String26:6),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,0,0,156),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,156),USE(?Line17:5),COLOR(COLOR:Black)
         LINE,AT(2917,0,0,156),USE(?Line17:7),COLOR(COLOR:Black)
         LINE,AT(1250,0,0,156),USE(?Line17:6),COLOR(COLOR:Black)
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  DAT = TODAY()
  LAI = CLOCK()
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(APK:RECORD)

  KARTINA_TEXT='Automaðînas kartiòa: '&AUT:V_NR&' '&AUT:MARKA

  FilesOpened = True
  RecordsToProcess = RECORDS(AUTOAPK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Automaðînas kartiòa'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTOAPK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(APK:RECORD)
      APK:AUT_NR=AUT_NR
      SET(APK:AUT_Key,APK:AUT_KEY)
      Process:View{Prop:Filter} = ''
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
        IF INRANGE(APK:DATUMS,S_DAT,B_DAT)
            DATUMS     =APK:DATUMS
            NOSKREJIENS=APK:NOBRAUKUMS
            I#=GETPAVADZ(APK:PAV_NR)
            LAPA   = PAV:REK_NR
            NPK#+=1
            NPK=NPK#
            CLEAR(NOL:RECORD)
            NOL:U_NR=APK:PAV_NR
            SET(NOL:NR_KEY,NOL:NR_KEY)
            LOOP
               NEXT(NOLIK)
               IF ERROR() OR ~(NOL:U_NR=APK:PAV_NR) THEN BREAK.
!               DARBI  = NOL:NOMENKLAT
               CASE sys:nom_cit
               OF 'A'
                 DARBI=GETNOM_K(NOL:NOMENKLAT,2,5)
               OF 'K'
                 DARBI=GETNOM_K(NOL:NOMENKLAT,2,4)
               OF 'C'
                 DARBI=GETNOM_K(NOL:NOMENKLAT,2,19)
               ELSE
                 DARBI=GETNOM_K(NOL:NOMENKLAT,2,1)
               .
               DARBI=CLIP(DARBI)&' '&NOM:NOS_P
               RP     = CALCSUM(16,2)
               RPK   += RP
               PRINT(RPT:detail)
               DATUMS=''
               LAPA=0
               NOSKREJIENS=0
               NPK=0
            .
            PRINT(RPT:line)
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
  IF SEND(AUTOAPK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAIL1)
    ENDPAGE(report)
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
  AUT_NR=0 !LAI NENOMAITÂ BROWSEAUTO
  IF FilesOpened
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR ~(APK:AUT_NR=AUT_NR)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
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
