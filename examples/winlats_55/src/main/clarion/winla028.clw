                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_AtvalSar           PROCEDURE                    ! Declare Procedure
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
NPK                  DECIMAL(3)
DAT                  LONG
LAI                  LONG
VARUZV               STRING(25)
SUMMAK               DECIMAL(9,2)
VIRSRAKSTS           STRING(60)
!-----------------------------------------------------------------------------
Process:View         VIEW(PERNOS)
                       PROJECT(PER:ACC_DATUMS)
                       PROJECT(PER:ACC_KODS)
                       PROJECT(PER:A_DIENAS)
                       PROJECT(PER:BEI_DAT)
                       PROJECT(PER:DIENAS)
                       PROJECT(PER:DIENAS0)
                       PROJECT(PER:DIENAS1)
                       PROJECT(PER:DIENAS1C)
                       PROJECT(PER:DIENAS2)
                       PROJECT(PER:DIENAS2C)
                       PROJECT(PER:DIENASS)
                       PROJECT(PER:DIENASX)
                       PROJECT(PER:DIENASXC)
                       PROJECT(PER:ID)
                       PROJECT(PER:INI)
                       PROJECT(PER:PAZIME)
                       PROJECT(PER:SAK_DAT)
                       PROJECT(PER:SUMMA)
                       PROJECT(PER:SUMMA0)
                       PROJECT(PER:SUMMA1)
                       PROJECT(PER:SUMMA2)
                       PROJECT(PER:SUMMAS)
                       PROJECT(PER:SUMMAX)
                       PROJECT(PER:VSUMMA)
                       PROJECT(PER:VSUMMAS)
                       PROJECT(PER:YYYYMM)
                     END
!-----------------------------------------------------------------------------------------------
report REPORT,AT(198,1375,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,396,8000,969),USE(?unnamed)
         STRING(@s45),AT(1198,52,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1198,365,4479,260),USE(virsraksts),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(5823,490,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(625,677,5885,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(938,677,0,313),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(1354,677,0,313),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(3021,677,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(3906,677,0,313),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(4531,677,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(5156,677,0,313),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(6510,677,0,313),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(625,938,5885,0),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(677,729),USE(?String33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ID'),AT(990,729,365,208),USE(?String33:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(1406,729,1615,208),USE(?String33:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. kods'),AT(3073,729,833,208),USE(?String33:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksa'),AT(3958,729,573,208),USE(?String33:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4583,729,573,208),USE(?String33:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(5208,729,625,208),USE(?String33:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Beigas'),AT(5885,729,625,208),USE(?String33:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,677,0,313),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(625,677,0,313),USE(?Line3:7),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8000,177)
         STRING(@n3),AT(677,10,208,156),USE(NPK),RIGHT
         LINE,AT(938,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@n4),AT(990,10,313,156),USE(KAD:ID),RIGHT
         LINE,AT(1354,-10,0,198),USE(?Line13:3),COLOR(COLOR:Black)
         STRING(@s25),AT(1406,10,1615,156),USE(VARUZV),LEFT
         LINE,AT(3021,-10,0,198),USE(?Line13:31),COLOR(COLOR:Black)
         STRING(@P######-#####P),AT(3125,10,781,156),USE(KAD:PERSKOD)
         LINE,AT(3906,-10,0,198),USE(?Line13:32),COLOR(COLOR:Black)
         STRING(@D014.),AT(4010,10,469,156),USE(PER:YYYYMM)
         LINE,AT(4531,-10,0,198),USE(?Line13:33),COLOR(COLOR:Black)
         STRING(@n_8.2),AT(4583,10,521,156),USE(PER:SUMMA),RIGHT
         LINE,AT(5156,-10,0,198),USE(?Line13:34),COLOR(COLOR:Black)
         STRING(@D06.),AT(5208,10,573,156),USE(PER:SAK_DAT),RIGHT(1)
         LINE,AT(5833,-10,0,198),USE(?Line13:35),COLOR(COLOR:Black)
         STRING(@D06.),AT(5885,10,573,156),USE(PER:BEI_DAT),RIGHT(1)
         LINE,AT(6510,-10,0,198),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,448),USE(?unnamed:2)
         LINE,AT(625,-10,0,271),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(3021,-10,0,63),USE(?Line281),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,63),USE(?Line282),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,271),USE(?Line221),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,271),USE(?Line222),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,271),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(625,52,5885,0),USE(?Line23),COLOR(COLOR:Black)
         STRING('Summa kopâ:'),AT(885,104,833,156),USE(?String33:9),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2),AT(4583,104,521,156),USE(SUMMAK),RIGHT
         LINE,AT(625,260,5885,0),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,63),USE(?Line284),COLOR(COLOR:Black)
         STRING(@D06.),AT(5365,292,625,156),USE(DAT),RIGHT(1),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6000,292,521,156),USE(LAI),RIGHT(12),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(198,10900,8000,10),USE(?unnamed:3)
         LINE,AT(625,0,5885,0),USE(?Line23:3),COLOR(COLOR:Black)
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
!
! CAUR F:DTK NODOD PIEPRASÎTO 'A'/'S'
!
  PUSHBIND

  DAT = TODAY()
  LAI = CLOCK()
  NPK=0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PERNOS::Used = 0
    CheckOpen(PERNOS,1)
  END
  PERNOS::Used += 1
  BIND(PER:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PERNOS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  IF F:DTK='A'
     ProgressWindow{Prop:Text} = 'Atvaïinâjumu saraksts'
     VIRSRAKSTS='Atvaïinâjumu saraksts '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  ELSE
     ProgressWindow{Prop:Text} = 'Slimîbas lapu saraksts'
     VIRSRAKSTS='Slimîbas lapu saraksts '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  .
  ?Progress:UserString{Prop:Text}=''
  SEND(PERNOS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(per:record)
      per:pazime=F:DTK
      PER:SAK_DAT=S_DAT !
      SET(per:dat_key,per:dat_key)
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
        ATVALINAJUMS#=FALSE
        LOOP DA#=PER:SAK_DAT TO PER:BEI_DAT
           IF INRANGE(DA#,S_DAT,B_DAT)
              ATVALINAJUMS#=TRUE
              BREAK
           .
        .
        IF ATVALINAJUMS#
            VARUZV=GETKADRI(PER:ID,2,1)
            NPK += 1
            PRINT(RPT:detail)
            SUMMAK += PER:SUMMA
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
  IF SEND(PERNOS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
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
  IF FilesOpened
    PERNOS::Used -= 1
    IF PERNOS::Used = 0 THEN CLOSE(PERNOS).
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
!  NEXT(Process:View)
  PREVIOUS(Process:View) !
  IF ERRORCODE() OR ~(F:DTK=per:pazime)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PERNOS')
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
F_Meklejumi          PROCEDURE                    ! Declare Procedure
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

VIRSRAKSTS          STRING(80)
DAT                 LONG
LAI                 LONG
NOS_P               STRING(50)
RPT_NOMENKLAT       STRING(21)
DAUDZUMS            DECIMAL(10,2)
COUNT               DECIMAL(6)
CENA                DECIMAL(10,2)

N_TABLE             QUEUE,PRE(N)
NOMENKLAT               STRING(21)
DAUDZUMS                DECIMAL(12,2)
COUNT                   DECIMAL(5)
KOMENT                  STRING(60)
                    .

NR                  DECIMAL(5)
KOMENT              STRING(60)
DAUDZUMS_S          STRING(8)
CENA_S              STRING(8)
COUNT_S             STRING(6)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_N)
                       PROJECT(NON:ACC_DATUMS)
                       PROJECT(NON:ACC_KODS)
                       PROJECT(NON:DAUDZUMS)
                       PROJECT(NON:KOMENTARS)
                       PROJECT(NON:NOMENKLAT)
                       PROJECT(NON:STATUSS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(302,1063,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(302,198,12000,865),USE(?unnamed)
         STRING(@s45),AT(3594,52,4375,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9323,573,0,313),USE(?Line26),COLOR(COLOR:Black)
         STRING(@s1),AT(10260,625),USE(SYS:NOKL_CP),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(313,625,417,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(729,573,0,313),USE(?Line20),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(10052,365,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(5677,573,0,313),COLOR(COLOR:Black)
         LINE,AT(9844,573,0,313),COLOR(COLOR:Black)
         LINE,AT(10938,573,0,313),COLOR(COLOR:Black)
         LINE,AT(2396,573,0,313),COLOR(COLOR:Black)
         LINE,AT(260,573,0,313),COLOR(COLOR:Black)
         STRING('Nomenklatûra (kat. Nr.)'),AT(781,625,1615,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2448,625,3229,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Komentârs'),AT(5729,625,3594,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz.'),AT(9375,625,469,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena (      )'),AT(9844,625,677,208),USE(?String16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10521,573,0,313),USE(?Line25),COLOR(COLOR:Black)
         STRING('M.sk.'),AT(10573,625,365,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,833,10677,0),USE(?Line9),COLOR(COLOR:Black)
         STRING(@s80),AT(1625,313,8333,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,573,10677,0),USE(?Line8),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,11625,177)
         STRING(@S21),AT(781,10,1615,156),USE(RPT_NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_5),AT(10573,10,313,156),USE(count),RIGHT
         STRING(@s50),AT(2500,10,3177,156),USE(NOS_P),LEFT
         LINE,AT(5677,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         STRING(@s60),AT(5729,10,3594,156),USE(KOMENT),LEFT
         LINE,AT(9323,-10,0,198),USE(?Line27),COLOR(COLOR:Black)
         STRING(@n_6),AT(9375,10,417,156),USE(DAUDZUMS),RIGHT
         LINE,AT(9844,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(9896,10,573,156),USE(CENA),RIGHT
         LINE,AT(10521,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(260,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(10938,-10,0,198),COLOR(COLOR:Black)
         STRING(@N_5),AT(313,10,,156),USE(NR),RIGHT
         LINE,AT(729,-10,0,198),USE(?Line23),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,-10,,200),USE(?unnamed:2)
         LINE,AT(10521,0,0,52),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(729,0,0,52),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(9323,0,0,52),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(10938,0,0,52),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,52),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,52),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,52),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(260,0,0,52),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(260,52,10677,0),USE(?Line22),COLOR(COLOR:Black)
         STRING(@D06.),AT(9833,73),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10479,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(302,7500,12000,52),USE(?unnamed:3)
         LINE,AT(260,0,10677,0),USE(?Line22F),COLOR(COLOR:Black)
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

  CHECKOPEN(SYSTEM,1)
  DAT = TODAY()
  LAI = CLOCK()

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOM_N::Used = 0
    CheckOpen(NOM_N,1)
  END
  NOM_N::Used += 1
  BIND(NON:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_N)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Meklçjumu statistika'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_N,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Meklçjumu statistika '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
      SET(NON:KAT_KEY)
      Process:View{Prop:Filter} = 'INRANGE(NON:ACC_DATUMS,S_DAT,B_DAT)'
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
        IF ~OPENANSI('MEKLSTAT.TXT')
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
        OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra (Kat.Nr)'&CHR(9)&'Nosaukums'&CHR(9)&'Komentârs'&CHR(9)&'Daudzums'&CHR(9)&|
        'Cena ('&NOKL_CP&')'&CHR(9)&'Mekl.sk.'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        np#+=1
        ?Progress:UserString{Prop:Text}=NP#
        DISPLAY(?Progress:UserString)
        GET(N_TABLE,0)
        N:NOMENKLAT=NON:NOMENKLAT
        GET(N_TABLE,N:NOMENKLAT)
        IF ERROR()
            N:NOMENKLAT= NON:NOMENKLAT
            N:COUNT    = 1
            N:DAUDZUMS = NON:DAUDZUMS
            N:KOMENT   = CLIP(NON:KOMENTARS)
            ADD(N_TABLE)
            SORT(N_TABLE,N:NOMENKLAT)
        ELSE
            N:DAUDZUMS += NON:DAUDZUMS
            N:COUNT += 1
            N:KOMENT = CLIP(N:KOMENT)&' '&CLIP(NON:KOMENTARS)
            PUT(N_TABLE)
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
  LOOP N#=1 TO RECORDS(N_TABLE)
    GET(N_TABLE,N#)
    GET(NOM_K,0)
    CLEAR(NOM:RECORD)
!!    NOM:NOMENKLAT=N:NOMENKLAT
    NOM:KATALOGA_NR = N:NOMENKLAT
!!    GET(NOM_K,NOM:NOM_KEY)
    GET(NOM_K,NOM:KAT_KEY)
    IF ERROR()
        NOS_P = 'Nav atrasts'
    ELSE
        NOS_P = NOM:NOS_P
        CENA = NOM:REALIZ[NOKL_CP]
    END
    RPT_NOMENKLAT = N:NOMENKLAT
    DAUDZUMS      = N:DAUDZUMS
    COUNT         = N:COUNT
    KOMENT        = N:KOMENT
    NR           += 1
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE=NR&CHR(9)&RPT_NOMENKLAT&CHR(9)&NOS_P&CHR(9)&KOMENT&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N_7))&CHR(9)&|
        LEFT(FORMAT(CENA,@N_8.2))&CHR(9)&COUNT
        ADD(OUTFILEANSI)
    END
  END
  IF F:DBF = 'W'
    PRINT(RPT:DETAIL1)
    ENDPAGE(report)
  .
  IF SEND(NOM_N,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
!     CLOSE(OUTFILEANSI)
!     ANSIFILENAME=''
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
    NOM_N::Used -= 1
    IF NOM_N::Used = 0 THEN CLOSE(NOM_N).
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
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOM_N')
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
B_MAKRIK             PROCEDURE                    ! Declare Procedure
MUVEIDS              STRING(1)
TYPEFACE     string(20)
rpt_menesis  string(11)
RPT_GADS     decimal(4)
RPT_DATUMS   decimal(2)
rpt_REG_ADRESE string(34)
rpt_BAN_NR   string(34)
rpt_BAN_KR   string(11)
rpt_SUMVAR1  string(150)
rpt_SUMVAR2  string(150)
GG_SATURS1   string(150)
GG_SATURS2   string(150)
PVN_TEX      STRING(35)
tex          string(100)
SUMMAV       DECIMAL(12,2)

SAV_POSITION         STRING(260)
GGK_D_K              STRING(1),DIM(8)
GGK_BKK              STRING(5),DIM(8)
GGK_SUMMAV           DECIMAL(12,2),DIM(8)
DUPLEX               BYTE

report REPORT,AT(198,198,8104,12000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
detail0 DETAIL,AT(10,,8000,302)
         STRING(@s100),AT(104,52,7344,208),USE(tex),FONT(,12,,,CHARSET:BALTIC)
       END
detail DETAIL,AT(42,,8000,5906),USE(?unnamed)
         LINE,AT(4167,104,1042,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Maksâjuma uzdevums Nr'),AT(1927,208,2125,240),USE(?String22),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4167,104,0,417),USE(?Line3),COLOR(COLOR:Black)
         STRING(@S9),AT(4229,208),USE(gg:dok_SENR),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,104,0,417),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(4167,521,1042,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@n4),AT(2729,615,448,208),USE(rpt_gads),CENTER,FONT(,12,,,CHARSET:BALTIC)
         STRING('. gada'),AT(3219,625,375,208),USE(?String28),LEFT
         STRING(@n2),AT(3635,615,260,208),USE(rpt_datums),FONT(,12,,,CHARSET:BALTIC)
         STRING('.'),AT(3896,615,104,208),USE(?String40),LEFT
         STRING(@s11),AT(3958,625),USE(rpt_menesis),LEFT
         STRING('Maksâtâjs'),AT(313,885),USE(?String29),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('DEBETS'),AT(4844,1010),USE(?String30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('SUMMA'),AT(6198,1010),USE(?String31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1146,0,469),USE(?Line5),COLOR(COLOR:Black)
         STRING(@s45),AT(1042,1146,3354,208),USE(CLIENT),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1042,1354,2760,208),USE(pvn_tex),LEFT(1)
         LINE,AT(4427,1302,2708,0),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(260,1615,4167,0),USE(?Line6),COLOR(COLOR:Black)
         STRING(@s31),AT(313,1719,2396,208),USE(BANKA),LEFT
         LINE,AT(3385,1615,0,365),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@s11),AT(3438,1719,938,208),USE(BKODS),LEFT
         LINE,AT(4427,1302,0,677),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s21),AT(4469,1563,1563,208),USE(REK),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,1302,0,3177),USE(?Line5:4),COLOR(COLOR:Black)
         STRING(@N11.2),AT(6229,1771),USE(summav),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,1302,0,3177),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(323,2000,5781,0),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Saòçmçjs'),AT(292,2083,729,208),USE(?String17),FONT(,9,,,CHARSET:BALTIC)
         STRING('KREDÎTS'),AT(4688,2083,833,208),USE(?String18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,2292,0,469),USE(?Line5:6),COLOR(COLOR:Black)
         STRING(@s45),AT(1042,2344,3354,208),USE(PAR:NOS_P),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1042,2552,2917,208),USE(RPT_REG_ADRESE),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(4427,2500,2708,0),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4427,2500,0,677),USE(?Line5:8),COLOR(COLOR:Black)
         STRING(@s11),AT(4531,2656,885,208),USE(RPT_BAN_KR),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,2760,4167,0),USE(?Line6:3),COLOR(COLOR:Black)
         STRING(@s31),AT(260,2865,2448,208),USE(BAN:NOS_P),LEFT
         LINE,AT(3385,2760,0,417),USE(?Line5:7),COLOR(COLOR:Black)
         STRING(@s11),AT(3438,2865,938,208),USE(BAN:KODS),LEFT
         STRING(@s34),AT(4458,2865,1625,208),USE(RPT_BAN_NR),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,3177,6875,0),USE(?Line6:4),COLOR(COLOR:Black)
         STRING(@S100),AT(260,3281,5823,208),USE(RPT_SUMVAR1),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(260,3490,5823,208),USE(RPT_SUMVAR2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(250,3781,5844,0),USE(?Line6:5),COLOR(COLOR:Black),LINEWIDTH(2)
         STRING('sods       d.   %'),AT(6167,3333,938,208),USE(?String23)
         STRING('summa'),AT(6167,3521),USE(?String24)
         STRING('op.veids    1'),AT(6167,3729),USE(?String25)
         STRING('mak. rinda'),AT(6177,3938),USE(?String26)
         STRING('bankas Nr'),AT(6177,4146),USE(?String27)
         STRING(@s150),AT(260,3906,5823,208),USE(gg_saturs1),LEFT
         STRING(@s150),AT(260,4115,5823,208),USE(gg_saturs2),LEFT
         LINE,AT(6094,4479,1052,0),USE(?Line20),COLOR(COLOR:Black)
         STRING('Pârbaudîts bankâ'),AT(5906,4521),USE(?String37)
         STRING(@s1),AT(313,4635,,156),USE(GGK_D_K[3]),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(469,4635,365,156),USE(GGK_BKK[3]),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(833,4635,750,156),USE(GGK_SUMMAV[3]),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(469,4323,365,156),USE(GGK_BKK[1]),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(313,4323,,156),USE(GGK_D_K[1]),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING('Z.v.'),AT(1979,4583),USE(?String34),LEFT
         STRING('Klienta paraksti:'),AT(1979,4896),USE(?String35),LEFT
         STRING('Bankas paraksti:'),AT(4167,4896),USE(?String36),RIGHT
         STRING(@s1),AT(313,4948,,156),USE(GGK_D_K[5]),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(469,4948,365,156),USE(GGK_BKK[5]),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(833,4948,750,156),USE(GGK_SUMMAV[5]),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(313,4792,,156),USE(GGK_D_K[4]),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(469,4792,365,156),USE(GGK_BKK[4]),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(833,4792,750,156),USE(GGK_SUMMAV[4]),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(833,4323,750,156),USE(GGK_SUMMAV[1]),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(313,4479,,156),USE(GGK_D_K[2]),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(469,4479,365,156),USE(GGK_BKK[2]),FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(833,4479,750,156),USE(GGK_SUMMAV[2]),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

IZDRUKA WINDOW('Filtrs kontçjumiem'),AT(,,115,91),GRAY
       OPTION('&Norâdît'),AT(7,6,100,41),USE(muveids),BOXED
         RADIO('Drukât kontçjumus'),AT(12,18,81,10),USE(?muveids:Radio1)
         RADIO('Nedrukât kontçjumus'),AT(12,30),USE(?muveids:Radio2)
       END
       BUTTON('Drukât 2 uz lapas'),AT(7,51,77,14),USE(?ButtonDUPLEX)
       IMAGE('CHECK3.ICO'),AT(88,50,17,18),USE(?ImageDUPLEX),HIDE
       BUTTON('&OK'),AT(30,70,36,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(70,70,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  OPEN(IZDRUKA)
  IF ~MUVEIDS THEN MUVEIDS='D'.
  DISPLAY
  ACCEPT
    CASE FIELD()
    OF ?ButtonDUPLEX
        CASE EVENT()
        OF EVENT:Accepted
            IF DUPLEX
               DUPLEX=0
               HIDE(?IMAGEDUPLEX)
            ELSE
               DUPLEX=1
               UNHIDE(?IMAGEDUPLEX)
            .
            DISPLAY
        .
    OF ?OKButton
        CASE EVENT()
        OF EVENT:Accepted
            BREAK
        .
    OF ?CancelButton
        CASE EVENT()
        OF EVENT:Accepted
            close(IZDRUKA)
            do ProcedureReturn
        .
    END
  END
  CLOSE(IZDRUKA)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(system,1)
!  CHECKOPEN(GGK,1)
!  RESET(GGK:NR_KEY,T_POSITION)
!  NEXT(GGK)
  CHECKOPEN(PAR_K,1)

  OPEN(ProgressWindow)
  open(report)
  report{Prop:Preview} = PrintPreviewImage
!
!  report{Prop:FONT} = TYPEFACE
!
  rpt_menesis = MENVAR(GG:DOKDAT,2,2)
  RPT_GADS=YEAR(GG:DOKDAT)
  RPT_DATUMS=DAY(GG:DOKDAT)
  IF GL:VID_NR
     PVN_TEX=CLIP(GL:REG_NR)&' PVN: '&GL:VID_NR
  ELSE
     PVN_TEX=GL:REG_NR
  .
  GetMyBank(GGK:BKK)
  RPT_REG_ADRESE=GETPAR_K(GG:PAR_NR,2,9)     ! POZICIONÇ PAR_K
  CASE SYS:nokl_PB
  OF 1
     BAN:KODS=PAR:BAN_KODS
     RPT_BAN_NR=PAR:BAN_NR
     RPT_BAN_KR=PAR:BAN_KR
  OF 2
     BAN:KODS=PAR:BAN_KODS2
     RPT_BAN_NR=PAR:BAN_NR2
     RPT_BAN_KR=PAR:BAN_KR2
  ELSE
     kluda(69,'')
  .
  IF ~RPT_BAN_NR
     KLUDA(44,'Partnera norçíinu rçíins')
  .
  C#=Getbankas_k(BAN:KODS,2,1)      ! SAÒÇMÇJA BANKA
  IF LEN(CLIP(PAR:ADRESE))>23
     LOOP I#=24 TO 1 BY -1
        IF PAR:ADRESE[I#]=' ' OR PAR:ADRESE[I#]=','
           IF I#>1
              IF PAR:ADRESE[I#-1]=' ' OR PAR:ADRESE[I#-1]=','
                 I#-=1
              .
           .
           BREAK
        .
     .
  ELSE
     I#=24
  .
  TEKSTS= SUMVAR(GGK:SUMMAV,GGK:VAL,0)
  FORMAT_TEKSTS(150,'Arial',10,'B')
  RPT_SUMVAR1 = F_TEKSTS[1]
  RPT_SUMVAR2 = F_TEKSTS[2]
  TEKSTS=clip(GG:SATURS)&' '&clip(GG:SATURS2)&' '&clip(GG:SATURS3)
  FORMAT_TEKSTS(140,'Arial',10,'')
  GG_SATURS1=F_TEKSTS[1]
  GG_SATURS2=F_TEKSTS[2]
  SUMMAV=GGK:SUMMAV
!***********************KOR-KONTI*************************
  IF MUVEIDS='D'
     SAV_POSITION=POSITION(GGK:NR_KEY)
     I#=0
     CLEAR(GGK_D_K)
     CLEAR(GGK_BKK)
     CLEAR(GGK_SUMMAV)
     CLEAR(GGK:RECORD)
     GGK:U_NR=GG:U_NR
     SET(GGK:NR_KEY,GGK:NR_KEY)
     LOOP
        NEXT(GGK)
        IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
        I#+=1
        IF I#>8
           KLUDA(0,'Kontçjumi ir vairâk kâ 8, nav vietas uz izdrukas...')
           BREAK
        ELSE
           GGK_D_K[I#]=GGK:D_K
           GGK_BKK[I#]=GGK:BKK
           GGK_SUMMAV[I#]=GGK:SUMMAV
        .
     .
     RESET(GGK:NR_KEY,SAV_POSITION)
     NEXT(GGK)
  .

  print(RPT:detail)
  IF DUPLEX
     print(RPT:detail)
  .
  ENDPAGE(report)
  IF DUPLEX
     pr:skaits=1
  ELSE
     pr:skaits=3
  .
  CLOSE(ProgressWindow)
  RP
  IF Globalresponse = RequestCompleted
     loop j#=1 to PR:SKAITS
        report{Prop:FlushPreview} = True
        IF ~(j#=PR:SKAITS)
           loop i#= 1 to RECORDS(PrintPreviewQueue1)
              get(PrintPreviewQueue1,i#)
              PrintPreviewImage=PrintPreviewImage1
              add(PrintPreviewQueue)
           .
        .
     .
  .
  POST(EVENT:CloseWindow)
  close(report)
  DO PROCEDURERETURN
!----------------------------------------------------------------------------------------------------
ProcedureReturn ROUTINE
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  popBIND
  return
!----------------------------------------------------------------------------------------------------

omit('maris')
!ÐITO MÇS IZMANTOJÂM, LAI DABÛTU BURTA GARUMU mm
  tex='A{50}'
  print(RPT:detail0)
  TEX='Â{50}'
  PRINT(RPT:DETAIL0)
  tex='B{50}'
  print(RPT:detail0)
  tex='C{50}'
  print(RPT:detail0)
  TEX='È{50}'
  PRINT(RPT:DETAIL0)
  TEX='D{50}'
  PRINT(RPT:DETAIL0)
  TEX='E{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ç{50}'
  PRINT(RPT:DETAIL0)
  TEX='F{50}'
  PRINT(RPT:DETAIL0)
  TEX='G{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ì{50}'
  PRINT(RPT:DETAIL0)
  TEX='H{50}'
  PRINT(RPT:DETAIL0)
  TEX='I{50}'
  PRINT(RPT:DETAIL0)
  TEX='Î{50}'
  PRINT(RPT:DETAIL0)
  TEX='J{50}'
  PRINT(RPT:DETAIL0)
  TEX='K{50}'
  PRINT(RPT:DETAIL0)
  TEX='Í{50}'
  PRINT(RPT:DETAIL0)
  TEX='L{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ï{50}'
  PRINT(RPT:DETAIL0)
  TEX='M{50}'
  PRINT(RPT:DETAIL0)
  TEX='N{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ò{50}'
  PRINT(RPT:DETAIL0)
  TEX='O{50}'
  PRINT(RPT:DETAIL0)
  TEX='P{50}'
  PRINT(RPT:DETAIL0)
  TEX='Q{50}'
  PRINT(RPT:DETAIL0)
  TEX='R{50}'
  PRINT(RPT:DETAIL0)
  TEX='S{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ð{50}'
  PRINT(RPT:DETAIL0)
  TEX='T{50}'
  PRINT(RPT:DETAIL0)
  TEX='U{50}'
  PRINT(RPT:DETAIL0)
  TEX='Û{50}'
  PRINT(RPT:DETAIL0)
  TEX='V{50}'
  PRINT(RPT:DETAIL0)
  TEX='W{50}'
  PRINT(RPT:DETAIL0)
  TEX='X{50}'
  PRINT(RPT:DETAIL0)
  TEX='Y{50}'
  PRINT(RPT:DETAIL0)
  TEX='Z{50}'
  PRINT(RPT:DETAIL0)
  tex='a{50}'
  print(RPT:detail0)
  TEX='â{50}'
  PRINT(RPT:DETAIL0)
  tex='b{50}'
  print(RPT:detail0)
  tex='c{50}'
  print(RPT:detail0)
  TEX='è{50}'
  PRINT(RPT:DETAIL0)
  TEX='d{50}'
  PRINT(RPT:DETAIL0)
  TEX='e{50}'
  PRINT(RPT:DETAIL0)
  TEX='ç{50}'
  PRINT(RPT:DETAIL0)
  TEX='f{50}'
  PRINT(RPT:DETAIL0)
  TEX='g{50}'
  PRINT(RPT:DETAIL0)
  TEX='ì{50}'
  PRINT(RPT:DETAIL0)
  TEX='h{50}'
  PRINT(RPT:DETAIL0)
  TEX='i{50}'
  PRINT(RPT:DETAIL0)
  TEX='î{50}'
  PRINT(RPT:DETAIL0)
  TEX='j{50}'
  PRINT(RPT:DETAIL0)
  TEX='k{50}'
  PRINT(RPT:DETAIL0)
  TEX='í{50}'
  PRINT(RPT:DETAIL0)
  TEX='l{50}'
  PRINT(RPT:DETAIL0)
  TEX='ï{50}'
  PRINT(RPT:DETAIL0)
  TEX='m{50}'
  PRINT(RPT:DETAIL0)
  TEX='n{50}'
  PRINT(RPT:DETAIL0)
  TEX='ò{50}'
  PRINT(RPT:DETAIL0)
  TEX='o{50}'
  PRINT(RPT:DETAIL0)
  TEX='p{50}'
  PRINT(RPT:DETAIL0)
  TEX='q{50}'
  PRINT(RPT:DETAIL0)
  TEX='r{50}'
  PRINT(RPT:DETAIL0)
  TEX='s{50}'
  PRINT(RPT:DETAIL0)
  TEX='ð{50}'
  PRINT(RPT:DETAIL0)
  TEX='t{50}'
  PRINT(RPT:DETAIL0)
  TEX='u{50}'
  PRINT(RPT:DETAIL0)
  TEX='û{50}'
  PRINT(RPT:DETAIL0)
  TEX='v{50}'
  PRINT(RPT:DETAIL0)
  TEX='w{50}'
  PRINT(RPT:DETAIL0)
  TEX='x{50}'
  PRINT(RPT:DETAIL0)
  TEX='y{50}'
  PRINT(RPT:DETAIL0)
  TEX='z{50}'
  PRINT(RPT:DETAIL0)
  tex='1{50}'
  print(RPT:detail0)
  TEX='2{50}'
  PRINT(RPT:DETAIL0)
  tex='3{50}'
  print(RPT:detail0)
  tex='4{50}'
  print(RPT:detail0)
  TEX='5{50}'
  PRINT(RPT:DETAIL0)
  TEX='6{50}'
  PRINT(RPT:DETAIL0)
  TEX='7{50}'
  PRINT(RPT:DETAIL0)
  TEX='8{50}'
  PRINT(RPT:DETAIL0)
  TEX='9{50}'
  PRINT(RPT:DETAIL0)
  TEX='0{50}'
  PRINT(RPT:DETAIL0)
  TEX='`{50}'
  PRINT(RPT:DETAIL0)
  TEX='~{50}'
  PRINT(RPT:DETAIL0)
  TEX='!{50}'
  PRINT(RPT:DETAIL0)
  TEX='@{50}'
  PRINT(RPT:DETAIL0)
  TEX='#{50}'
  PRINT(RPT:DETAIL0)
  TEX='${50}'
  PRINT(RPT:DETAIL0)
  TEX='%{50}'
  PRINT(RPT:DETAIL0)
  TEX='^{50}'
  PRINT(RPT:DETAIL0)
  TEX='&{50}'
  PRINT(RPT:DETAIL0)
  TEX='*{50}'
  PRINT(RPT:DETAIL0)
  TEX='({50}'
  PRINT(RPT:DETAIL0)
  TEX='){50}'
  PRINT(RPT:DETAIL0)
  TEX='-{50}'
  PRINT(RPT:DETAIL0)
  TEX='_{50}'
  PRINT(RPT:DETAIL0)
  TEX='={50}'
  PRINT(RPT:DETAIL0)
  TEX='+{50}'
  PRINT(RPT:DETAIL0)
  TEX='|{50}'
  PRINT(RPT:DETAIL0)
  TEX='\{50}'
  PRINT(RPT:DETAIL0)
  TEX='[{50}'
  PRINT(RPT:DETAIL0)
  TEX=']{50}'
  PRINT(RPT:DETAIL0)
  TEX='?{50}'
  PRINT(RPT:DETAIL0)
  tex=',{50}'
  print(RPT:detail0)
  TEX='.{50}'
  PRINT(RPT:DETAIL0)
  tex='/{50}'
  print(RPT:detail0)
  tex=' {50}'&'|'
  print(RPT:detail0)
maris
