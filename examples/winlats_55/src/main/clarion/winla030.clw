                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_PrintGrupas        PROCEDURE                    ! Declare Procedure
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
DAT                  LONG
LAI                  LONG
!-----------------------------------------------------------------------------
Process:View         VIEW(GRUPA1)
                       PROJECT(GR1:GRUPA1)
                       PROJECT(GR1:NOSAUKUMS)
                     END
report REPORT,AT(500,1281,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,198,8000,1083)
         STRING(@s45),AT(1250,156,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(1042,833,313,208),USE(?String6:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Grupa/apakðgrupa'),AT(1406,833,1521,208),USE(?String6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3125,833,3958,208),USE(?String6:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(990,1042,6094,0),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('Nomenklatûru grupas un apakðgrupas'),AT(1250,469,4427,260),USE(?unnamed:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6542,604,542,167),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(990,781,0,313),COLOR(COLOR:Black)
         LINE,AT(1354,781,0,313),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(7083,781,0,313),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(3073,781,0,313),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(990,781,6094,0),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,188)
         STRING(@n3),AT(1042,0,,188),CNT,USE(?Counter)
         LINE,AT(1354,-10,0,208),USE(?Line8),COLOR(COLOR:Black)
         STRING(@S3),AT(2135,0,469,188),USE(GR1:GRUPA1),LEFT
         LINE,AT(3073,-10,0,208),USE(?Line8:20),COLOR(COLOR:Black)
         STRING(@S50),AT(3177,0,3750,188),USE(GR1:NOSAUKUMS),LEFT
         LINE,AT(7083,-10,0,208),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,208),USE(?Line8:19),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,188)
         LINE,AT(1354,-10,0,208),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@S3),AT(2396,0,469,188),USE(GR2:GRUPA2),LEFT
         LINE,AT(3073,-10,0,208),USE(?Line8:16),COLOR(COLOR:Black)
         STRING(@S50),AT(3177,0,3750,188),USE(GR2:NOSAUKUMS),LEFT
         LINE,AT(7083,-10,0,208),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,208),USE(?Line8:26),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,229),USE(?unnamed)
         LINE,AT(990,0,0,52),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,52),USE(?Line15:1),COLOR(COLOR:Black)
         LINE,AT(3073,0,0,52),USE(?Line15:13),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,52),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(990,52,6094,0),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@d06.),AT(5990,73),USE(dat),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6625,73),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(500,11100,8000,52)
         LINE,AT(990,0,6094,0),USE(?Line3:4),COLOR(COLOR:Black)
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
  CHECKOPEN(GRUPA2,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GRUPA1::Used = 0
    CheckOpen(GRUPA1,1)
  END
  GRUPA1::Used += 1
  BIND(GR1:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(GRUPA1)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Grupas un apakðgrupas'
  ?Progress:UserString{Prop:Text}=''
  SEND(GRUPA1,'QUICKSCAN=on')
  DAT = TODAY()
  LAI = CLOCK()
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GR1:RECORD)
      SET(GR1:GR1_KEY,GR1:GR1_KEY)
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
          DONEGR2#=0
          PRINT(RPT:detail)
          CLEAR(GR2:RECORD)
          GR2:GRUPA1=GR1:GRUPA1
          SET(GR2:GR1_KEY,GR2:GR1_KEY)
          DO NEXTGR2
          LOOP UNTIL DONEGR2#
            PRINT(RPT:DETAIL1)
            DO NEXTGR2
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
  IF SEND(GRUPA1,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:Detail2)
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
    GRUPA1::Used -= 1
    IF GRUPA1::Used = 0 THEN CLOSE(GRUPA1).
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
      StandardWarning(Warn:RecordFetchError,'GRUPA1')
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
NEXTGR2 ROUTINE
  LOOP UNTIL EOF(GRUPA2)
    NEXT(GRUPA2)
    IF ~(GR2:GRUPA1=GR1:GRUPA1) THEN BREAK.
    EXIT
  END
  DONEGR2#=1
F_AtlaidesKlientiem  PROCEDURE                    ! Declare Procedure
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
head_text            string(50)
REP_ATL_K            STRING(50)
REP_ATL              STRING(5)
ATS_PROC             STRING(5)
NPK                  DECIMAL(4)
ATS_NOMENKLAT        STRING(21)
DAT                  LONG
LAI                  LONG
CP                   STRING(3)
!-------------------------------------------------------------------------------------------
Process:View         VIEW(PAR_K)
                       PROJECT(PAR:NOS_P)
                       PROJECT(PAR:U_NR)
                       PROJECT(PAR:ADRESE)
                       PROJECT(PAR:ATLAIDE)
                     END
report REPORT,AT(198,1313,8000,9698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,500,8000,813)
         STRING(@s45),AT(1563,10,4948,208),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(1563,260,4948,208),USE(head_text),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#.lapaP),AT(6667,313,698,135),PAGENO,USE(?PageCount),FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(52,781,7448,0),COLOR(COLOR:Black)
         LINE,AT(7500,521,0,313),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(521,521,0,313),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(52,521,7448,0),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(4115,521,0,313),COLOR(COLOR:Black)
         LINE,AT(3333,521,0,313),USE(?unnamed:3),COLOR(COLOR:Black)
         STRING('Klients/Atlaides definîcija'),AT(833,563,2344,208),USE(?unnamed:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(104,563,354,208),USE(?String10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Komentârs'),AT(4146,563,3333,208),USE(?String13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,521,0,313),USE(?Line10),COLOR(COLOR:Black)
         STRING('Atlaide/ %'),AT(3417,563,667,208),USE(?unnamed:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,156)
         LINE,AT(3333,-10,0,177),USE(?unnamed:5),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,177),USE(?Line14:2),COLOR(COLOR:Black)
         STRING(@s45),AT(563,0,2740,156),USE(PAR:NOS_p),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7500,-10,0,177),USE(?Line14),COLOR(COLOR:Black)
         STRING(@n_4),AT(156,0,,156),USE(NPK),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,-10,0,177),USE(?Line21),COLOR(COLOR:Black)
         STRING(@s5),AT(3500,0,458,156),USE(REP_ATL),RIGHT
         STRING(@s50),AT(4219,0,3281,156),USE(REP_ATL_K),LEFT(1)
         LINE,AT(52,-10,0,177),USE(?Line13),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,94),USE(?unnamed:6)
         LINE,AT(52,52,7448,0),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,115),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,115),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,156),USE(?unnamed:2)
         LINE,AT(52,-10,0,177),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,177),USE(?Line21:12),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,177),USE(?Line21:4),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,177),USE(?Line21:5),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,177),USE(?Line21:3),COLOR(COLOR:Black)
         STRING(@s5),AT(3479,0,479,156),USE(ATS_PROC),RIGHT
         STRING(@s21),AT(813,0,,156),USE(ATS_NOMENKLAT),LEFT
       END
detail1 DETAIL,AT(,,,219),USE(?unnamed)
         LINE,AT(52,52,7448,0),USE(?Line15:23),COLOR(COLOR:Black)
         STRING(@D06.),AT(6354,73),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7031,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(521,0,0,63),USE(?Line16:32),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,63),USE(?Line16:23),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,63),USE(?Line17:99),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,63),USE(?Line18:99),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,63),USE(?Line19:88),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(52,0,7490,0),USE(?Line15:2),COLOR(COLOR:Black)
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

  OPCIJA='000010000000001'
!         123456789012345
  IZZFILTB
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  END

  CHECKOPEN(ATL_K)
  CHECKOPEN(ATL_S)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Atlaides klientiem'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  NPK=0
  DAT = TODAY()
  LAI = CLOCK()
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CP='R1'
      CLEAR(PAR:RECORD)
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
      Process:View{Prop:Filter} = '~CYCLEPAR_K(CP)'
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
      IF PAR_NR = 999999999
        HEAD_TEXT='ATLAIDES KLIENTIEM'
      ELSE
        HEAD_TEXT='ATLAIDES KLIENTAM:  '&PAR:NOS_P
      .
      IF PAR_GRUPA
        head_text='ATLAIDES KLIENTIEM  GRUPA:  '&PAR_GRUPA
      .
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        DONEATS# = 0
        IF PAR:ATLAIDE>100
            C#=GETPAR_ATLAIDE(PAR:ATLAIDE,'')
            REP_ATL=ATL:U_NR
            REP_ATL_K=ATL:KOMENTARS
            NPK+=1
            PRINT(RPT:detail)
            CLEAR(ATS:RECORD)
            ATS:U_NR=ATL:U_NR
            SET(ATS:NR_KEY,ATS:NR_KEY)
            DO NEXTATS
            LOOP UNTIL DONEATS#
                ATS_PROC = ATS:ATL_PROC&'%'
                ATS_NOMENKLAT=ATS:NOMENKLAT
                PRINT(RPT:DETAIL2)
                DO NEXTATS
            END
            IF ATL:ATL_PROC_PA
                ATS_NOMENKLAT='Atlaide visâm pârçjâm'
                ATS_PROC=ATL:ATL_PROC_PA&'%'
                PRINT(RPT:DETAIL2)
            END
            PRINT(RPT:SVITRA)
        ELSE
            IF PAR:ATLAIDE>0 AND PAR:ATLAIDE<=100
                REP_ATL_K=''
                REP_ATL=PAR:ATLAIDE&'%'
                NPK+=1
                PRINT(RPT:detail)
                PRINT(RPT:SVITRA)
            END
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
  IF SEND(PAR_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
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
      StandardWarning(Warn:RecordFetchError,'PAR_K')
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
NEXTATS ROUTINE
    LOOP UNTIL EOF(ATL_S)
        NEXT(ATL_S)
        IF ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
        EXIT
    END
    DONEATS#=1
F_AtlaizuLapas       PROCEDURE                    ! Declare Procedure
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

DAT                  LONG
LAI                  LONG
NPK                  USHORT

!-----------------------------------------------------------------------------
Process:View         VIEW(ATL_K)
                       PROJECT(ATL:ATL_PROC_PA)
                       PROJECT(ATL:HIDDEN)
                       PROJECT(ATL:KOMENTARS)
                       PROJECT(ATL:U_NR)
                     END

report REPORT,AT(500,1479,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,500,8000,979),USE(?unnamed)
         STRING(@s45),AT(1563,52,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('ATLAIÞU LAPAS'),AT(2615,365,2188,260),USE(?unnamed:5),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(5344,521,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(573,677,5469,0),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(573,677,0,313),COLOR(COLOR:Black)
         LINE,AT(1667,677,0,313),COLOR(COLOR:Black)
         STRING('Lapas Nr'),AT(1083,729,573,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums / Nomenklatûru filtrs'),AT(1708,729,3229,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlaides % '),AT(4990,729,990,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,938,5469,0),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(6042,677,0,313),USE(?Line9:3),COLOR(COLOR:Black)
         LINE,AT(4948,677,0,313),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(1042,677,0,313),COLOR(COLOR:Black)
         STRING('Npk'),AT(615,729,417,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,156)
         LINE,AT(573,-10,0,177),COLOR(COLOR:Black)
         LINE,AT(1667,-10,0,177),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,177),COLOR(COLOR:Black)
         STRING(@s5),AT(1146,0,417,156),USE(ATL:U_NR),RIGHT(1)
         STRING(@s50),AT(1771,0,3177,156),USE(ATL:KOMENTARS),LEFT
         STRING(@N_5.1),AT(5115,0,781,156),USE(ATL:ATL_PROC_PA),CENTER
         LINE,AT(6042,-10,0,177),USE(?Line14:2),COLOR(COLOR:Black)
         STRING(@N4),AT(667,0,,156),USE(NPK),RIGHT
         LINE,AT(1042,-10,0,177),USE(?Line13),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,156),USE(?unnamed:4)
         LINE,AT(573,-10,0,177),COLOR(COLOR:Black)
         LINE,AT(1667,-10,0,177),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,177),COLOR(COLOR:Black)
         STRING(@s21),AT(3104,0,1406,156),USE(ATS:NOMENKLAT),LEFT
         STRING(@N_5.1),AT(5115,0,781,156),USE(ATS:ATL_PROC),TRN,CENTER
         LINE,AT(6042,-10,0,177),USE(?Line14:28),COLOR(COLOR:Black)
         LINE,AT(1042,-10,0,177),USE(?Line13:45),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,94)
         LINE,AT(573,-10,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1042,-10,0,115),USE(?Line22:5),COLOR(COLOR:Black)
         LINE,AT(1667,-10,0,115),USE(?Line22:6),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,115),USE(?Line22:7),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(573,52,5469,0),USE(?unnamed:2),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,250),USE(?unnamed:3)
         LINE,AT(573,-10,0,63),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(1042,-10,0,63),USE(?Line22:31),COLOR(COLOR:Black)
         LINE,AT(1667,-10,0,63),USE(?Line22:32),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line22:33),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line22:4),COLOR(COLOR:Black)
         LINE,AT(573,52,5469,0),USE(?Line28),COLOR(COLOR:Black)
         STRING(@D6),AT(4958,73),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(5594,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(500,11000,8000,52)
         LINE,AT(573,0,6354,0),USE(?Line28:2),COLOR(COLOR:Black)
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

  OPCIJA='2'
  izzfiltF                     !NO MAINa NEDRÎKST SAUKT....
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF ATL_S::Used = 0
    CheckOpen(ATL_S,1)
  END
  ATL_S::Used += 1
  IF ATL_K::Used = 0
    CheckOpen(ATL_K,1)
  END
  ATL_K::Used += 1
  BIND(ATL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(ATL_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Atlaiþu lapas'
  ?Progress:UserString{Prop:Text}=''
  SEND(ATL_K,'QUICKSCAN=on')
  NPK = 0
  DAT = TODAY()
  LAI = CLOCK()
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ATL:RECORD)
      SET(ATL:NR_KEY,ATL:NR_KEY)
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('ALAPAS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='ATLAIÞU LAPAS'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Lapas Nr'&CHR(9)&'Nosaukums/Nomenklatûru filtri'&CHR(9)&'Atlaides %'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
          np#+=1
          ?Progress:UserString{Prop:Text}=NP#
          DISPLAY(?Progress:UserString)
          NPK+=1
          IF F:DBF = 'W'
            PRINT(RPT:detail)
          ELSE
            OUTA:LINE=NPK&CHR(9)&ATL:U_NR&CHR(9)&ATL:KOMENTARS&CHR(9)&LEFT(FORMAT(ATL:ATL_PROC_PA,@N_5.1))
            ADD(OUTFILEANSI)
          END
          CLEAR(ATS:RECORD)
          ATS:U_NR=ATL:U_NR
          SET(ATS:NR_KEY,ATS:NR_KEY)
          LOOP
             NEXT(ATL_S)
             IF ERROR() OR ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
             IF F:DBF = 'W'
                 PRINT(RPT:DETAIL1)
             ELSE
                 OUTA:LINE=CHR(9)&CHR(9)&ATS:NOMENKLAT&CHR(9)&LEFT(FORMAT(ATS:ATL_PROC,@N_5.1))
                 ADD(OUTFILEANSI)
             .
          .
          IF F:DBF = 'W'
            PRINT(RPT:SVITRA)
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
  IF SEND(ATL_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL2)
        ENDPAGE(report)
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
    ATL_K::Used -= 1
    IF ATL_K::Used = 0 THEN CLOSE(ATL_K).
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
      StandardWarning(Warn:RecordFetchError,'ATL_K')
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

