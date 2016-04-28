                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_KadruSarArApg      PROCEDURE                    ! Declare Procedure
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
LAI                  TIME
DATUMS               DATE
VARUZV               STRING(20)
ZINAS                STRING(100)
FILTRS_TEXT          STRING(60)
NPK                  USHORT
ZPT                  STRING(1)

!-----------------------------------------------------------------------------
Process:View         VIEW(KADRI)
                       PROJECT(KAD:AMATS)
                       PROJECT(KAD:APGAD_SK)
                       PROJECT(KAD:AVANSS)
                       PROJECT(KAD:DARBA_GR)
                       PROJECT(KAD:DZIM)
                       PROJECT(KAD:D_GR_END)
                       PROJECT(KAD:ID)
                       PROJECT(KAD:INI)
                       PROJECT(KAD:INV_P)
                       PROJECT(KAD:IZGLITIBA)
                       PROJECT(KAD:KARTNR)
                       PROJECT(KAD:VID_U_NR)
                       PROJECT(KAD:DAR_LIG)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:OBJ_NR)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END

report REPORT,AT(146,1886,8000,9500),PAPER(PAPER:A4,8250,11688),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,292,8000,1594),USE(?PAGEHEADER)
         STRING(@s45),AT(1760,94,4396,219),USE(CLIENT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Informâcija pâr nodokïa grâmatiòam uz'),AT(1833,417,3167,229),USE(?String33),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(5083,417,990,260),USE(datums),LEFT(1),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1813,688,4688,156),USE(FILTRS_TEXT),CENTER,FONT(,9,,,CHARSET:ANSI)
         STRING('apgâdîbas periods no-lîdz'),AT(6104,1177,1750,177),USE(?String37:12),TRN,CENTER(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods no'),AT(5417,1354,635,177),USE(?String37:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gûðanas'),AT(5417,1177,635,177),USE(?String37:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3844,1354,1490,177),USE(?String37:5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,990,7865,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(1479,990,0,613),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(7917,990,0,613),USE(?Line6:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,1042,260,208),USE(?String37:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,990,0,613),USE(?Line6:11),COLOR(COLOR:Black)
         STRING('ID'),AT(417,1042,260,208),USE(?String37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,990,0,613),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('Vârds Uzvârds'),AT(1542,1042,2167,208),USE(?String37:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. kods'),AT(698,1042,781,208),USE(?String37:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3760,990,0,613),USE(?Line6:5),COLOR(COLOR:Black)
         STRING('Grâmatiòas reìistrâcijas'),AT(3844,1010,1490,177),USE(?String37:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs un pieðíirðanas'),AT(3844,1177,1490,177),USE(?String37:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5375,990,0,613),USE(?Line6:7),COLOR(COLOR:Black)
         STRING('Ienâkumu'),AT(5417,1010,635,177),USE(?String37:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6083,990,0,613),USE(?Line6:9),COLOR(COLOR:Black)
         STRING('Apgâdâjamâ persona,'),AT(6115,1010,1750,177),USE(?String37:9),CENTER(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1510,7865,0),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(52,990,0,613),USE(?Line6),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8000,177),USE(?unnamed)
         LINE,AT(7917,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,198),USE(?Line13:9),COLOR(COLOR:Black)
         LINE,AT(3760,-10,0,198),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(1479,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,260,156),CNT,USE(npk),RIGHT
         STRING(@n4),AT(396,10,260,156),USE(KAD:ID),LEFT(1)
         STRING(@s36),AT(1510,10,2188,156),USE(varuzv),LEFT
         STRING(@p######-#####p),AT(708,10,771,156),USE(KAD:PERSKOD)
         STRING(@s12),AT(4604,10,740,156),USE(KAD:REGNR),LEFT
         STRING(@s12),AT(3781,10,781,156),USE(KAD:KARTNR),RIGHT
         STRING(@d06.),AT(5438,10,625,156),USE(KAD:DARBA_GR,,?KAD:DARBA_GR:2)
         STRING(@S100),AT(6115,10,1792,156),USE(ZinaS),LEFT
         STRING(@s1),AT(4563,10,135,156),USE(Zpt),TRN
         LINE,AT(5375,-10,0,198),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(6083,-10,0,198),USE(?Line13:7),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,8000,177),USE(?unnamed)
         LINE,AT(7917,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,198),USE(?Line13:9),COLOR(COLOR:Black)
         LINE,AT(3760,-10,0,198),USE(?Line13:6),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(1479,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@d06.),AT(5438,10,625,156),USE(KAD:DARBA_GR)
         STRING(@S100),AT(6115,10,1792,156),USE(ZinaS),LEFT
         LINE,AT(5375,-10,0,198),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(6083,-10,0,198),USE(?Line13:7),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,8000,177),USE(?unnamed)
         LINE,AT(7917,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,198),USE(?Line13:9),COLOR(COLOR:Black)
         LINE,AT(3760,-10,0,198),USE(?Line13:3),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(1479,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@S100),AT(6115,10,1792,156),USE(ZinaS),LEFT
         LINE,AT(5375,-10,0,198),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(6083,-10,0,198),USE(?Line13:7),COLOR(COLOR:Black)
       END
PageFoot DETAIL,AT(,,,198),USE(?unnamed:2)
         STRING(@D06.),AT(6792,83,625,156),USE(DATUMS,,?DATUMS:2),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(52,0,0,63),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(1479,0,0,63),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,63),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(5375,0,0,63),USE(?Line10:7),COLOR(COLOR:Black)
         LINE,AT(6083,0,0,63),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(365,0,0,63),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(677,0,0,63),USE(?Line10:9),COLOR(COLOR:Black)
         LINE,AT(3760,0,0,63),USE(?Line10:8),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@T4),AT(7438,83,490,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,11000,8000,198),USE(?unnamed:3)
         LINE,AT(52,0,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6927,52,573,156),PAGENO,USE(?PageCount),FONT('Arial',8,,,CHARSET:BALTIC)
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
  DATUMS=TODAY()
  LAI=CLOCK()
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
!  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1

  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  BIND('ID',ID)
  BIND('F:NODALA',F:NODALA)
  BIND('F:IDP',F:IDP)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kadru saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(KAD:INI_KEY)
      Process:View{Prop:Filter} = '~(KAD:STATUSS=''7'' AND F:IDP) AND ~(F:NODALA and ~(KAD:NODALA=F:NODALA)) AND ~(ID and ~(KAD:ID=ID))'
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
        SETTARGET(REPORT,?PAGEHEADER)
        IMAGE(188,1,2083,521,'USER.BMP')
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('KADRI.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Informâcija par nodokïa grâmatinâm uz '&FORMAT(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Npk'&CHR(9)&'ID'&CHR(9)&'Pers.kods'&CHR(9)&'Vârds,Uzvârds'&CHR(9)&'Grâmatiòas reìistrâcijas'&CHR(9)&'Ienâkumu' &CHR(9)&|
        'Apgâdâjamâ persona,'
        ADD(OUTFILEANSI)
        OUTA:LINE=''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&'numurs un pieðíirðanas'&CHR(9)&'gûðanas' &CHR(9)&'apgâdîbas periods no-lîdz'
        ADD(OUTFILEANSI)
        OUTA:LINE=''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&'datums'&CHR(9)&'periods no' &CHR(9)&''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK+=1
!        IF F:DBF='W'   !WMF
          VARUZV = CLIP(KAD:VAR)&' '&CLIP(KAD:UZV)
          I# = 0
          ZinaS = ''
          CLEAR(RIK:RECORD)
          RIK:ID = KAD:ID
          SET(RIK:ID_KEY,RIK:ID_KEY) !+ID,-DATUMS
          LOOP
             PREVIOUS(KAD_RIK)
             IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
             IF ~INSTRING(RIK:TIPS,'B') THEN CYCLE. ! ZIÒAS PAR BÇRNIEM
             !03.10.2014 ZinaS=CLIP(RIK:SATURS)&' dz. '&FORMAT(RIK:DATUMS1,@D06.)
             ZinaS=CLIP(RIK:SATURS)
             ZPT=''
             IF I# = 0
                I#+=1
!                IF ~(CLIP(KAD:KARTNR)='') AND ~(CLIP(KAD:REGNR)='')
!
!                   ZPT=','
!                .
                IF F:DBF='W'   !WMF
                   PRINT(RPT:detail)
                ELSE
                   OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(ID,@N_5)&CHR(9)&FORMAT(KAD:PERSKOD,@p######-#####p)&CHR(9)&VARUZV&CHR(9)&|
                   KAD:KARTNR&ZPT&KAD:REGNR&CHR(9)&FORMAT(KAD:DARBA_GR,@D06.)&CHR(9)&ZinaS
                   ADD(OUTFILEANSI)
                .
             ELSE
                IF F:DBF='W'   !WMF
                   PRINT(RPT:detail1)
                ELSE
                   OUTA:LINE=''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&FORMAT(KAD:DARBA_GR,@D06.)&CHR(9)&ZinaS
                   ADD(OUTFILEANSI)
                .
             .
             IF RIK:SATURS1
                ZinaS=RIK:SATURS1
                IF F:DBF='W'   !WMF
                   PRINT(RPT:detail2)
                ELSE
                   OUTA:LINE=''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&''&CHR(9)&ZinaS
                   ADD(OUTFILEANSI)
                .
             .
          .
          IF I# = 0
!             IF KAD:KARTNR & KAD:REGNR
!                ZPT=','
!             .
             IF F:DBF='W'   !WMF
                PRINT(RPT:detail)
             ELSE
                OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(ID,@N_5)&CHR(9)&FORMAT(KAD:PERSKOD,@p######-#####p)&CHR(9)&VARUZV&CHR(9)&|
                KAD:KARTNR&ZPT&KAD:REGNR&CHR(9)&FORMAT(KAD:DARBA_GR,@D06.)&CHR(9)&ZinaS
                ADD(OUTFILEANSI)
             .
          .
          !PRINT(RPT:detail)
!        ELSE           !WORD,EXCEL
!          OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(ID,@N_5)&CHR(9)&CLIP(KAD:VAR)&' '&CLIP(KAD:UZV)&CHR(9)&|
!          FORMAT(KAD:PERSKOD,@p######-#####p)&CHR(9)&CLIP(KAD:PASE)&FORMAT(KAD:TERKOD,@N_06)&CHR(9)&KAD:KARTNR&CHR(9)&|
!          KAD:STATUSS&CHR(9)&KAD:NODALA&CHR(9)& KAD:AMATS&CHR(9)&FORMAT(KAD:DARBA_GR,@D06.B)&CHR(9)&FORMAT(KAD:D_GR_END,@D06.B)
!        .
!          ADD(OUTFILEANSI)
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:PageFoot)
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
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
      StandardWarning(Warn:RecordFetchError,'KADRI')
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
