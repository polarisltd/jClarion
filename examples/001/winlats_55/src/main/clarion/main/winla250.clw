                     MEMBER('winlats.clw')        ! This is a MEMBER module
CYCLENODALA          FUNCTION (NODALA)            ! Declare Procedure
  CODE                                            ! Begin processed code
!
!
!
!
!

IF ~(NODALA=F:NODALA OR (NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
   (NODALA[2]=F:NODALA[2] AND F:NODALA[1]='') OR F:NODALA='')
   RETURN(TRUE)
ELSE
   RETURN(FALSE)
.

M_RealizKops         PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------
NPK                 BYTE
BANKURSS            REAL
KOPA                STRING(20)
NOLNOS              STRING(20)
DAT                 DATE
LAI                 TIME
VIRSRAKSTS          STRING(80)
FILTRS_TEXT         STRING(100)
CN                  STRING(10)
CP                  STRING(10)

N_TABLE        QUEUE,PRE(N)
NOL_NR           BYTE
SUMMA_B          DECIMAL(13,2)
SUMMA            DECIMAL(13,2)
               .
SUMMA_BK         DECIMAL(13,2)
SUMMAK           DECIMAL(13,2)
SAV_PAVADNAME   LIKE(PAVADNAME)
SAV_LOC_NR      LIKE(LOC_NR)


!-------------------------------------------------------------------------
report REPORT,AT(200,1719,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,500,8000,1219),USE(?unnamed)
         STRING('Noliktava'),AT(1594,979,990,208),USE(?String2:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2990,938,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(5781,729,625,156),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s70),AT(1094,729,4688,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1563,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(771,344,6094,208),USE(VIRSRAKSTS),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,938,5365,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(1125,979,417,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc p/z bez  PVN,'),AT(3052,979,1104,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4146,979,375,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmçm ar PVN,'),AT(4563,979,1542,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6115,979,333,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,1198,5365,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(1563,938,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4531,938,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6458,938,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1094,938,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(1563,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(2990,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@S20),AT(1615,0,1354,156),USE(NOLNOS),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(3677,10,781,156),USE(N:SUMMA_B),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(5510,10,781,156),USE(N:SUMMA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1094,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(1146,10,365,156),USE(NPK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94),USE(?unnamed:5)
         LINE,AT(1094,0,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(1563,0,0,63),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(1094,52,5365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,115),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(4531,0,0,115),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(2990,0,0,115),USE(?Line19),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(4531,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(5563,10,781,156),USE(SUMMAK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(2990,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,198),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@S20),AT(1250,10,1302,156),USE(KOPA),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(3677,10,781,156),USE(SUMMA_BK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,-10,,302),USE(?unnamed:6)
         LINE,AT(2990,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(4531,0,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(1094,73,573,167),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(1667,73,458,167),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(2396,73,198,167),USE(?String38),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(2604,73,125,167),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(5510,73,521,167),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(6042,73),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(1094,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(1094,52,5365,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)
  BIND(PAV:RECORD)

  SAV_PAVADNAME=PAVADNAME
  SAV_LOC_NR=LOC_NR
  KOPA='Kopâ :'
  NR#     = 0
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::USED += 1

 LOOP N#=1 TO NOL_SK
  CLOSE(PAVAD)
  PAVADNAME='PAVAD'&FORMAT(N#,@N02)
  CHECKOPEN(PAVAD,1)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Realizâcijas kopsavilkums'
  ?Progress:UserString{Prop:Text}='Noliktava '&N#
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P1001110'
!           12345678
      CP = 'P11'
      CLEAR(PAV:RECORD)
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
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
      IF N#=1

         VIRSRAKSTS='REALIZÂCIJAS KOPSAVILKUMS ('&D_K&') '&format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
         IF PAR_NR = 999999999
            FILTRS_TEXT=GETFILTRS_TEXT('1111000') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN
!                                       1234567
          ELSE
            FILTRS_TEXT=GETPAR_K(PAR_NR,0,1)&' '&GETFILTRS_TEXT('1100000') !1-OB,2-NO,3-PT,4-PG,5-NOM,6-NT,7-DN
!                                                                1234567
         .

         IF F:DBF='W'
             OPEN(report)
             report{Prop:Preview} = PrintPreviewImage
         ELSE
             IF ~OPENANSI('IZGPAV.TXT')
               POST(Event:CloseWindow)
               CYCLE
             .
             OUTA:LINE=''
             ADD(OUTFILEANSI)
             OUTA:LINE=CLIENT
             ADD(OUTFILEANSI)
             OUTA:LINE=VIRSRAKSTS
             ADD(OUTFILEANSI)
             OUTA:LINE=FILTRS_TEXT
             ADD(OUTFILEANSI)
             OUTA:LINE=''
             ADD(OUTFILEANSI)
         .
      .
    OF Event:Timer
      Loop RecordsPerCycle TIMES
        IF PAV:VAL AND PAV:DATUMS
           BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
        ELSE
           BANKURSS=0
        .
        NR#+=1
        ?Progress:UserString{Prop:Text}='Noliktava '&N#&' '&NR#
        DISPLAY(  ?Progress:UserString)
        N:NOL_NR=N#
        GET(N_TABLE,N:NOL_NR)
        IF ERROR()
          N:summa    = PAV:SUMMA*BANKURSS
          N:summa_B  = PAV:SUMMA_b*BANKURSS
          ADD(N_TABLE)
          SORT(N_TABLE,N:NOL_NR)
        ELSE
          N:summa    += PAV:SUMMA*BANKURSS
          N:summa_B  += PAV:SUMMA_b*BANKURSS
          PUT(N_TABLE)
        .
        SUMMAK     += PAV:SUMMA*BANKURSS
        SUMMA_BK   += PAV:SUMMA_b*BANKURSS
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  CLOSE(Process:View)
  CLOSE(PAVAD)
  CLOSE(ProgressWindow)
 .
!  IF LocalResponse = RequestCompleted
    SAV_JOB_NR#=JOB_NR
    LOOP I#= 1 TO RECORDS(N_TABLE)
       GET(N_TABLE,I#)
       JOB_NR=N:NOL_NR+15
       CHECKOPEN(SYSTEM)
       NOLNOS=N:NOL_NR&':'&SYS:AVOTS
       IF F:DBF='W'
          NPK+=1
!          NOLNOS=N:NOL_NR&'.noliktava'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=NOLNOS&CHR(9)&LEFT(FORMAT(N:SUMMA_B,@N-_13.2))&CHR(9)&left(format(N:SUMMA,@N-_10.2))
          ADD(OUTFILEANSI)
       .
    .
    JOB_NR=SAV_JOB_NR#
    CHECKOPEN(SYSTEM)
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
        PRINT(RPT:RPT_FOOT2)
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_13.2))&CHR(9)&LEFT(Format(SUMMAK,@N-_10.2))
        ADD(OUTFILEANSI)
    END
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
!  .
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVADNAME=SAV_PAVADNAME
    LOC_NR=SAV_LOC_NR
    CHECKOPEN(PAVAD,1)
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(N_TABLE)
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
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
ViewASCIIFile PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
ASCIIFileSize        LONG
ASCIIBytesThisRead   LONG
ASCIIBytesRead       LONG
ASCIIBytesThisCycle  LONG
ASCIIPercentProgress BYTE
Queue:ASCII          QUEUE
                     STRING(255)
                   END
ASC1:FileName        STRING(80)
ASC1:CurrentFileName STRING(80)
ASC1:ASCIIFile        FILE,PRE(ASC1),DRIVER('ASCII'),NAME(ASCIIFileName),OEM
RECORD                 RECORD,PRE()
STRING                   STRING(255)
                       END
                     END
 OMIT('ENDOMIT')
Queue:ASCII          QUEUE
                     STRING(255)
                   END
ASC1:FileName        STRING(80)
ASC1:CurrentFileName STRING(80)
ASC1:ASCIIFile        FILE,PRE(ASC1),DRIVER('ASCII'),NAME(ASCIIFileName)
RECORD                 RECORD,PRE()
STRING                   STRING(255)
                       END
                     END
 ENDOMIT
ASCIIFILENAME1   LIKE(ASCIIFILENAME)
Window               WINDOW('Izdrukas aplûkoðana (PAV.TXT)'),AT(,,397,287),FONT(,8,,FONT:bold,CHARSET:BALTIC),IMM,SYSTEM,GRAY,RESIZE
                       LIST,AT(1,18),USE(?AsciiBox),FULL,HVSCROLL,FONT('Courier',8,,FONT:regular,CHARSET:BALTIC),FORMAT('528L(2)|M@s132@'),FROM(Queue:ASCII)
                       BUTTON('&Drukât'),AT(4,2,44,14),USE(?ButtonDrukat),LEFT,ICON(ICON:Print)
                       BUTTON('&Atlikt'),AT(50,2,43,14),USE(?CancelButton),LEFT,ICON(ICON:NoPrint)
                       BUTTON('&Labot'),AT(98,2,35,14),USE(?ButtonDrukat:2)
                     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  !ASCIIFILENAME='PAV.RPT'
  !ANSIFILENAME='PAVM.RPT'
  !ASCIIFILENAME='GA1.TXT'
  ASCIIFILENAME1=ASCIIFILENAME
  ASCIIFILENAME='AA.TXT'
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  WINDOW{PROP:TEXT}='Izdrukas aplûkoðana '&ASCIIFILENAME1
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?AsciiBox)
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
    OF ?ButtonDrukat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        RUN('command.com /c copy '&ASCIIFILENAME1&' prn')
        BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BREAK
      END
    OF ?ButtonDrukat:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        RUN('cedt '&ASCIIFILENAME1&' '&ASCIIFILENAME1,1)
        DO ASC1:FillQueue
        DISPLAY
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF OUTFILE::Used = 0
    CheckOpen(OUTFILE,1)
  END
  OUTFILE::Used += 1
  BIND(OUT:RECORD)
  FilesOpened = True
  OPEN(Window)
  WindowOpened=True
  INIRestoreWindow('ViewASCIIFile','winlats.INI')
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
    OUTFILE::Used -= 1
    IF OUTFILE::Used = 0 THEN CLOSE(OUTFILE).
  END
  IF WindowOpened
    INISaveWindow('ViewASCIIFile','winlats.INI')
    CLOSE(Window)
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
  IF Window{Prop:AcceptAll} THEN EXIT.
  ASC1:FileName = ASCIIFILENAME1
  IF ASC1:FileName <> ASC1:CurrentFileName
    ASCIIFileName = ASC1:FileName
    DO ASC1:FillQueue
    ASC1:CurrentFileName = ASC1:Filename
  END
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
!-------------------------------------------------------
ASC1:FillQueue ROUTINE
!|
!| This routine is used to fill the queue Queue:ASCII with the contents of the
!| requested file.
!|
!| First, the file is opened, and its size noted.
!|
!| Next, The progress window is opened. This window will remain open while the
!| file is being loaded into the queue. This window has a timer on it.
!|
!| Next, the file is loaded. For each tick of the timer, 20000 bytes of the file
!| are read. The contents of each line of the file are moved directly into the
!| queue.
!|
!| After the 20000 bytes are read, the progress window is updated to show the
!| percentage of the file read so far.
!|
!| The progress window also has a Cancel button. If the cancel button is pressed,
!| the file read terminates after the current block of 20000 bytes is read.
!|
!| Finally, the progress window is closed.
!|
  FREE(Queue:ASCII)
  IF NOT ASCIIFileName
    ?AsciiBox{Prop:Disable} = True
    EXIT
  ELSE
    ?AsciiBox{Prop:Disable} = False
  END
  OPEN(ASC1:ASCIIFile,10h)
  IF ERRORCODE()
    DISABLE(?AsciiBox)
    STOP(ERROR())
    IF StandardWarning(Warn:FileLoadError,ASC1:FileName)
      EXIT
    END
  ELSE
    ENABLE(?AsciiBox)
  END
  ASCIIFileSize = BYTES(ASC1:ASCIIFile)
  IF ASCIIFileSize = 0
    CLOSE(ASC1:ASCIIFile)
    DISABLE(?AsciiBox)
    IF StandardWarning(Warn:FileZeroLength,ASC1:FileName)
      EXIT
    END
    EXIT
  END
  OPEN(ProgressWindow)
  ASCIIPercentProgress = 0
  ASCIIBytesRead = 0
  ProgressWindow{Prop:Text} = 'Reading File'
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ?Progress:UserString{Prop:Text} = ''
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(ASC1:ASCIIFile)
    OF Event:Timer
      ASCIIBytesThisCycle = 0
      LOOP WHILE ASCIIBytesThisCycle < 20000
        NEXT(ASC1:ASCIIFile)
        IF ERRORCODE()
          LocalResponse = RequestCompleted
          BREAK
        END
        ASCIIBytesThisRead = BYTES(ASC1:ASCIIFile)
        ASCIIBytesThisCycle += ASCIIBytesThisRead
        ASCIIBytesRead += ASCIIBytesThisRead
        Queue:ASCII = ASC1:String
        ADD(Queue:ASCII)
      END
      IF ASCIIPercentProgress < 100
        ASCIIPercentProgress = (ASCIIBytesRead/ASCIIFileSize)*100
        IF ASCIIPercentProgress > 100
          ASCIIPercentProgress = 100
        END
        IF Progress:Thermometer <> ASCIIPercentProgress THEN
          Progress:Thermometer = ASCIIPercentProgress
          ?Progress:PctText{Prop:Text} = FORMAT(ASCIIPercentProgress,@N3) & '% Completed (' & ASCIIBytesRead & ') bytes'
          DISPLAY(?Progress:Thermometer)
          DISPLAY(?Progress:PctText)
        END
      END
      IF LocalResponse = RequestCompleted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE EVENT()
      OF Event:Accepted
        IF StandardWarning(Warn:ConfirmCancelLoad,ASC1:FileName)=Button:OK
          POST(Event:CloseWindow)
        END
      END
    END
  END
  CLOSE(ProgressWindow)
  CLOSE(ASC1:ASCIIFile)
