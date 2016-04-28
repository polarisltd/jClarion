                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_PrintVesture       PROCEDURE                    ! Declare Procedure
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

DAT                 LONG
LAI                 LONG
NOS_P               STRING(55)
CP                  STRING(3)
NPK                 USHORT
VES_SATURS          STRING(50)

!-----------------------------------------------------------------------------
Process:View         VIEW(VESTURE)
                       PROJECT(VES:ACC_DATUMS)
                       PROJECT(VES:ACC_KODS)
                       PROJECT(VES:APMDAT)
                       PROJECT(VES:Atlaide)
                       PROJECT(VES:DATUMS)
                       PROJECT(VES:DOKDAT)
                       PROJECT(VES:DOK_SENR)
                       PROJECT(VES:D_K_KONTS)
                       PROJECT(VES:PAR_NR)
                       PROJECT(VES:SAM_VAL)
                       PROJECT(VES:SATURS)
                       PROJECT(VES:SATURS2)
                       PROJECT(VES:SATURS3)
                       PROJECT(VES:SUMMA)
                       PROJECT(VES:Sam_datums)
                       PROJECT(VES:Samaksats)
                       PROJECT(VES:VAL)
                     END

report REPORT,AT(198,1177,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,979),USE(?unnamed:3)
         STRING(@s45),AT(1615,104,4583,208),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6979,521,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         STRING(@s55),AT(1448,365,4948,260),USE(nos_p),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,677,0,313),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(156,677,7500,0),USE(?Line6),COLOR(COLOR:Black)
         STRING('Dok. Nr.'),AT(1250,729,729,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(573,729,625,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apm. lîdz'),AT(4375,729,625,208),USE(?unnamed:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5000,677,0,313),USE(?Line5:5),COLOR(COLOR:Black)
         STRING('Summa'),AT(5052,729,990,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksâts'),AT(6094,729,1563,208),USE(?SAMAKSATS),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saturs'),AT(2031,729,2292,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4323,677,0,313),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(7656,677,0,313),USE(?Line19),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,729,313,208),USE(?String23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,677,0,313),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(1979,677,0,313),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(1198,677,0,313),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(156,938,7500,0),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(521,677,0,313),USE(?Line5:2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:7)
         STRING(@s14),AT(1229,0,729,156),USE(VES:DOK_SENR),LEFT
         STRING(@d06.),AT(573,10,573,156),USE(VES:DATUMS),CENTER
         LINE,AT(1198,-10,0,198),USE(?Line4),COLOR(COLOR:Black)
         STRING(@D06.B),AT(4375,10,573,156),USE(VES:APMDAT),CENTER
         LINE,AT(6042,-10,0,198),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,198),USE(?Line7),COLOR(COLOR:Black)
         STRING(@n-_12.2B),AT(6094,10,677,156),USE(VES:Samaksats),RIGHT
         STRING(@n-_12.2),AT(5052,10,677,156),USE(VES:SUMMA),RIGHT(12)
         STRING(@s3),AT(5781,10,260,156),USE(VES:VAL)
         LINE,AT(7656,-10,0,198),USE(?Line18),COLOR(COLOR:Black)
         STRING(@n3),AT(208,10),USE(NPK,,?NPK:2),RIGHT
         STRING(@s45),AT(2010,10,2300,156),USE(VES_SATURS)
         LINE,AT(4323,-10,0,198),USE(?Line16),COLOR(COLOR:Black)
         STRING(@s3),AT(6802,10,260,156),USE(VES:SAM_VAL),LEFT
         STRING(@D06.B),AT(7063,10,573,156),USE(VES:Sam_datums),CENTER
         LINE,AT(521,-10,0,198),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,177),USE(?unnamed:6)
         STRING(@d06.),AT(573,10,573,156),USE(VES:DATUMS,,?VES:DATUMS:0),CENTER
         LINE,AT(1198,-10,0,198),USE(?Line4:0),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line15:0),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line12:0),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,198),USE(?Line7:0),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line18:0),COLOR(COLOR:Black)
         STRING(@n3),AT(208,10),USE(NPK),RIGHT
         STRING(@s45),AT(2010,10,2300,156),USE(VES_SATURS,,VES_SATURS:0)
         LINE,AT(4323,-10,0,198),USE(?Line16:0),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),USE(?Line3:0),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:0),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(1198,-10,0,198),USE(?Line4:1),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line15:1),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line12:1),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,198),USE(?Line7:1),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line18:1),COLOR(COLOR:Black)
         STRING(@s45),AT(2010,10,2300,156),USE(VES_SATURS,,?VES_SATURS:1)
         LINE,AT(4323,-10,0,198),USE(?Line16:1),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),USE(?Line3:1),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:1),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,240),USE(?unnamed:2)
         LINE,AT(156,52,7500,0),USE(?Line6:3),COLOR(COLOR:Black)
         STRING(@d06.),AT(6563,104),USE(dat),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7198,104),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(5000,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(4323,-10,0,63),USE(?Line21:4),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,63),USE(?Line21:5),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,63),USE(?Line21:7),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,63),USE(?Line21:8),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,10700,8000,10),USE(?unnamed:4)
         LINE,AT(156,0,7500,0),USE(?Line6:4),COLOR(COLOR:Black)
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
!!  BIND('CP',CP)
!!  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('PAR_NR',PAR_NR)

  DAT = TODAY()
  LAI = CLOCK()
  NOS_P = 'Vçsture: '&GETPAR_K(PAR_NR,2,2)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

 IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  END
  VESTURE::Used += 1
  BIND(VES:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(VESTURE)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Vçsture'
  ?Progress:UserString{Prop:Text}=''
  SEND(VESTURE,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(VES:RECORD)
!!      VES:DATUMS=S_DAT
!!      CP='P11'
!!      SET(VES:DAT_KEY,VES:DAT_KEY)
      VES:PAR_NR=PAR_NR
      SET(VES:PAR_KEY,VES:PAR_KEY)
      Process:View{Prop:Filter} = 'VES:PAR_NR = PAR_NR'
!!      Process:View{Prop:Filter} = '~CYCLEPAR_K(CP)'
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
      IF VES:SATURS[1:7]='PVN Dek'
         ?SAMAKSATS{PROP:TEXT}='Precizçtâ'
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK+=1
        TEKSTS=CLIP(VES:SATURS)&' '&CLIP(VES:SATURS2)&' '&VES:SATURS3
        FORMAT_TEKSTS(57,'Arial',8,'')
        VES_SATURS = F_TEKSTS[1]
        IF VES:SUMMA
           PRINT(RPT:detail)
        ELSE
           PRINT(RPT:detail0)
        .
        IF F_TEKSTS[2]
           VES_SATURS = F_TEKSTS[2]
           PRINT(RPT:detail1)
        .
        IF F_TEKSTS[3]
           VES_SATURS = F_TEKSTS[3]
           PRINT(RPT:detail1)
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
  IF SEND(VESTURE,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:FOOTER)
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
       .
    ELSE
      ANSIJOB
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
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
    VESTURE::Used -= 1
    IF VESTURE::Used = 0 THEN CLOSE(VESTURE).
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
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'VESTURE')
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
CYCLEAPMAKSA         FUNCTION (F)                 ! Declare Procedure
  CODE                                            ! Begin processed code
!
! JÂBÛT POZICIONÇTAM GG&GGK
! JÂBÛT AIZPILDÎTAI A_TABLEI
!
 IF F !TIKAI NESAMAKSÂTÂS
    IF GGK:U_NR=1
       IF GGK:SUMMA=PERFATABLE(2,GGK:REFERENCE,'','',GGK:PAR_NR,'',0,0,'',0)
          RETURN(TRUE)
       .
    ELSE
       IF GGK:SUMMA=PERFATABLE(2,GG:DOK_SENR,'','',GGK:PAR_NR,'',0,0,'',0)
          RETURN(TRUE)
       .
    .
 .
 RETURN(FALSE)
OPENANSI             FUNCTION (vards,<INET>)      ! Declare Procedure
  CODE                                            ! Begin processed code
!
! INET 0 -USERFOLDER+FAILA VÂRDS, NOTÎRÎT
!      1 -TIEK DOTS PILNS FAILA VÂRDS, NOTÎRÎT
!      2 -TIEK DOTS PILNS FAILA VÂRDS, RAKSTÎT KLÂT & SHARED
!      3 -DOCFOLDERK+FAILA VÂRDS, RAKSTÎT KLÂT
!      4 -DOCFOLDERP+FAILA VÂRDS, RAKSTÎT KLÂT
!
  EXECUTE INET+1
     ANSIFILENAME=USERFOLDER&'\'&CLIP(VARDS)
     ANSIFILENAME=CLIP(VARDS)
     ANSIFILENAME=CLIP(VARDS)
     ANSIFILENAME=DOCFOLDER&'\KADRI\'&CLIP(VARDS)
     ANSIFILENAME=DOCFOLDER&'\PARTNERI\'&CLIP(VARDS)
  .
! STOP(ANSIFILENAME)
  LOOP
     IF INET=2
        OPEN(OUTFILEANSI,66) !R/W SHARED
     ELSE
        OPEN(OUTFILEANSI,18) !R/W MONOPOLS
     .
     IF ERRORCODE()=2 !FILE ~FOUND
        CREATE(OUTFILEANSI)
        IF ERROR()
           STOP('OPENANSI(CREATE):'&ERROR())
           RETURN(0)
        .
     ELSIF ERROR()
        IF INET=2
           STOP('OPENANSI(66):'&ERROR())
        ELSE
           KLUDA(1,ANSIFILENAME)
        .
        RETURN(0)
     ELSE
        BREAK
     .
  .
  IF INET < 2
     EMPTY(OUTFILEANSI)
  .
  RETURN(1)
