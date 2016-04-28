                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_IemaksasPPF        PROCEDURE                    ! Declare Procedure
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

PPFSUMMAK            DECIMAL(8,2)
NPK                  DECIMAL(3)
DAT                  DATE
LAI                  TIME
FILTRS_TEXT          STRING(60)
VUT                  STRING(30)

K_TABLE              QUEUE,PRE(K)
ID                      USHORT
VUT                     STRING(5)
NODALA                  STRING(2)
PPF                     DECIMAL(7,2)
                     .

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
report REPORT,AT(198,1583,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,250,8000,1333),USE(?unnamed)
         STRING(@s45),AT(1302,104,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods'),AT(4000,1094,1031,208),USE(?String25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,1042,0,313),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(1042,1042,5729,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1406,1042,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3906,1042,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6771,1042,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('NPK'),AT(1094,1094,260,208),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodaïa'),AT(1458,1094,365,208),USE(?String2:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(2094,1094,1573,208),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,1042,0,313),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Summa'),AT(5344,1094,1052,208),USE(?String2:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1042,1302,5729,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(1042,1042,0,313),USE(?Line2),COLOR(COLOR:Black)
         STRING('Iemaksas privâtajos pensiju fondos'),AT(1458,417,2604,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D014.),AT(4115,417),USE(S_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4792,417,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D014.),AT(5000,417),USE(B_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1406,729,4427,260),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6198,833,573,208),PAGENO,USE(?PageCount),RIGHT
       END
detail DETAIL,AT(,,,177)
         LINE,AT(1042,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N3),AT(1146,10,,156),USE(NPK),RIGHT
         LINE,AT(1406,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@S1),AT(1510,10,313,156),USE(K:NODALA),CENTER
         LINE,AT(1875,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@S30),AT(1938,10,1927,156),USE(VUT),LEFT
         LINE,AT(3906,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5156,10,1042,156),USE(K:PPF),RIGHT
         LINE,AT(6771,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@P######-#####P),AT(4115,10,,156),USE(KAD:PERSKOD),RIGHT
         LINE,AT(5104,-10,0,198),USE(?Line22),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,500),USE(?unnamed:3)
         LINE,AT(1042,-10,0,323),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,63),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,63),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(1146,104,1198,208),USE(?String2:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5156,104,1042,156),USE(PPFSUMMAK),RIGHT
         STRING(@d06.),AT(5708,333,625,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6385,333,521,156),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(1042,313,5729,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(1042,52,5729,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,323),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,323),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,323),USE(?Line23),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,52),USE(?unnamed:2)
         LINE,AT(1042,0,5729,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  DAT=TODAY()
  LAI=CLOCK()

  IF ID THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&GETKADRI(ID,0,1).
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
! IF DAV_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc DAIEV grupas: '&DAV_GRUPA.
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
  ProgressWindow{Prop:Text} = 'Iemaksas PPF'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
!      ALG:YYYYMM=ALP:YYYYMM
      ALG:YYYYMM=S_DAT
      ALG:NODALA=F:NODALA
      SET(ALG:NOD_KEY,ALG:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
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
          IF ~OPENANSI('IemPPF.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='IEMAKSAS PRIVÂTAJOS PENSIJU FONDOS '&format(S_DAT,@d014.)&'-'&format(B_DAT,@d014.)
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Nodaïa'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Personas kods'&CHR(9)&'Summa'
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
            IF ALG:PPF<>0
               K:ID=ALG:ID
               GET(K_TABLE,K:ID)
               IF ERROR()
                  VUT=GETKADRI(ALG:ID,2,3)
                  K:VUT=VUT[1:5]
                  K:NODALA=ALG:NODALA
                  K:PPF=ALG:PPF
                  ADD(K_TABLE)
                  SORT(K_TABLE,K:ID)
               ELSE
                  K:NODALA=ALG:NODALA   !ATCERAMIES PÇDÇJO
                  K:PPF+=ALG:PPF
                  PUT(K_TABLE)
               .
               PPFSUMMAK += ALG:PPF
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(K_TABLE,K:VUT)
    LOOP I#= 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       VUT=GETKADRI(K:ID,2,1)
       NPK += 1
       IF F:DBF = 'W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=NPK&CHR(9)&K:NODALA&CHR(9)&VUT&CHR(9)&KAD:PERSKOD&CHR(9)&LEFT(FORMAT(K:PPF,@N-_12.2))
          ADD(OUTFILEANSI)
       END
    .
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PPFSUMMAK,@N-_12.2))
        ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
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
  FREE(K_TABLE)
  IF FilesOpened
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
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
RemoveFile           PROCEDURE (name_file)        ! Declare Procedure
namefile         string(60),static
KAFILE           FILE,DRIVER('DOS'),NAME(NameFILE),PRE(KA)
RECORD              RECORD
G                     BYTE
                 . .
  CODE                                            ! Begin processed code
  namefile=name_file
  CLOSE(KAFILE)
  REMOVE(KAFILE)
  IF ERROR()
     KLUDA(0,'Kïûda dzçðot failu: '&name_file&' '&ERROR())
  .
K_PRECES             PROCEDURE                    ! Declare Procedure
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
!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------
NOLLIST              STRING(45)
PA                   SHORT
NPK                  DECIMAL(4)
CENA                 DECIMAL(12,3)
DAT                  DATE
LAI                  TIME
H_TEXT               STRING(100)
atlikums             decimal(12,3)
SUMMAKOPA            decimal(12,2)

!---------------------------------------------------------------------------
report REPORT,AT(104,800,8000,10198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,104,7990,677),USE(?unnamed:3)
         STRING(@s45),AT(1354,156,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(104,417,7083,260),USE(H_TEXT),CENTER(1),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7240,521,677,156),PAGENO,USE(?PA),RIGHT
       END
HeaderFirst DETAIL,AT(,,,510)
         LINE,AT(104,0,7760,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(104,0,0,521),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(521,0,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1927,0,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6979,0,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('('),AT(5156,52,52,208),USE(?String10:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(5198,52),USE(NOKL_CP),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(') Cena'),AT(5354,52,469,208),USE(?String10:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(135,156,365,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(552,156,1354,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1958,156,3125,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kataloga Numurs'),AT(5865,156,1094,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Svîtru kods'),AT(7010,156,833,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(5146,260,677,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,469,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
detailFirst DETAIL,AT(,,,135)
         LINE,AT(104,-10,0,156),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(156,10,313,125),USE(NPK),RIGHT
         LINE,AT(521,-10,0,156),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@s21),AT(552,10,1354,125),USE(kops:nomenklat),LEFT
         LINE,AT(1927,-10,0,156),USE(?Line7:7),COLOR(COLOR:Black)
         STRING(@s50),AT(1958,10,3125,125),USE(NOM:NOS_P),LEFT
         LINE,AT(5104,-10,0,156),USE(?Line7:6),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,156),USE(?Line7:3),COLOR(COLOR:Black)
         STRING(@s17),AT(5865,10,1094,125),USE(NOM:KATALOGA_NR),LEFT
         STRING(@N_13B),AT(7010,10,833,125),USE(NOM:KODS),RIGHT
         STRING(@N_11.3),AT(5135,10,677,125),USE(CENA),RIGHT
         LINE,AT(6979,-10,0,156),USE(?Line7:5),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,156),USE(?Line7:4),COLOR(COLOR:Black)
       END
RPT_FOOT_First DETAIL,AT(,,,271),USE(?unnamed)
         LINE,AT(104,-10,0,63),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line25:31),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,63),USE(?Line25:131),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,63),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line25:6),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line25:5),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(94,83,573,208),USE(?String30),LEFT
         STRING(@s8),AT(667,83,573,208),USE(ACC_KODS),LEFT
         STRING('RS :'),AT(1344,83,313,208),USE(?String30:2),LEFT
         STRING(@s1),AT(1656,83,156,208),USE(RS),CENTER
         STRING(@D6),AT(6740,83),USE(DAT)
         STRING(@T4),AT(7385,83),USE(LAI)
         LINE,AT(7865,-10,0,63),USE(?Line25:7),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,10)
         LINE,AT(104,0,7760,0),USE(?Line11:7),COLOR(COLOR:Black)
       END
HeaderSecond DETAIL,AT(,,,510)
         LINE,AT(104,0,7760,0),USE(?Line1:23),COLOR(COLOR:Black)
         LINE,AT(104,0,0,521),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(521,0,0,521),USE(?Line2:2:24),COLOR(COLOR:Black)
         LINE,AT(1927,0,0,521),USE(?Line2:71),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,521),USE(?Line2:41),COLOR(COLOR:Black)
         STRING('('),AT(4427,52,52,208),USE(?String10:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(4469,52),USE(NOKL_CP,,?NOKL_CP:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(') Cena'),AT(4625,52,469,208),USE(?String10:11),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,0,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,156,365,208),USE(?String10:101),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(552,156,1354,208),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1958,156,2396,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kataloga Numurs'),AT(5135,156,1094,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Svîtru kods'),AT(6281,156,833,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(7167,156,677,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(4406,260,677,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,469,7760,0),USE(?Line1:25),COLOR(COLOR:Black)
       END
detailSecond DETAIL,AT(,,,135)
         LINE,AT(104,-10,0,156),USE(?Line7:707),COLOR(COLOR:Black)
         STRING(@N_5),AT(156,10,313,125),USE(NPK,,?NPK:2),RIGHT
         LINE,AT(521,-10,0,156),USE(?Line7:207),COLOR(COLOR:Black)
         STRING(@s21),AT(552,10,1354,125),USE(kops:nomenklat,,?KOPS:NOMENKLAT:2),LEFT
         LINE,AT(1927,-10,0,156),USE(?Line7:709),COLOR(COLOR:Black)
         STRING(@s50),AT(1958,10,2396,125),USE(NOM:NOS_P,,?NOM:NOS_P:2),LEFT
         LINE,AT(4375,-10,0,156),USE(?Line7:8),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,156),USE(?Line7:9),COLOR(COLOR:Black)
         STRING(@s17),AT(5146,10,1094,125),USE(NOM:KATALOGA_NR,,?NOM:KATALOGA_NR:2),LEFT
         STRING(@N_13),AT(6281,10,833,125),USE(NOM:KODS,,?NOM:KODS:2),RIGHT
         LINE,AT(7135,-10,0,156),USE(?Line7:11),COLOR(COLOR:Black)
         STRING(@N_11.3),AT(7167,10,677,125),USE(atlikums),RIGHT
         STRING(@N_11.3),AT(4406,10,677,125),USE(CENA,,?CENA:2),RIGHT
         LINE,AT(6250,-10,0,156),USE(?Line7:10),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,156),USE(?Line7:44),COLOR(COLOR:Black)
       END
RPT_FOOT_Second DETAIL,AT(,,,260),USE(?unnamed:2)
         LINE,AT(104,-10,0,63),USE(?Line25:39),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line25:314),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,63),USE(?Line25:109),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line1:355),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,63),USE(?Line25:455),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,63),USE(?Line25:655),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,63),USE(?Line25:665),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,63),USE(?Line25:598),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(115,83,573,208),USE(?String302),LEFT
         STRING(@s8),AT(688,83,573,208),USE(ACC_KODS,,?ACC_KODS:2),LEFT
         STRING('RS :'),AT(1365,83,313,208),USE(?String30:211),LEFT
         STRING(@s1),AT(1677,83,156,208),USE(RS,,?RS:2),CENTER
         STRING(@D6),AT(6760,83),USE(DAT,,?DAT:2)
         STRING(@T4),AT(7417,83),USE(LAI,,?LAI:2)
         STRING(@N_11.2),AT(4333,73,677,125),USE(summakopa),TRN,RIGHT
         STRING('Kopçjâ preèu vçrtîba'),AT(3229,73,1146,208),USE(?KOPA_TEXT),TRN
         LINE,AT(7865,-10,0,63),USE(?Line25:743),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,11000,8000,63)
         LINE,AT(104,0,7760,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  dat=today()
  lai=clock()
  NPK = 0
  IF F:ATL[1]='0'
     H_TEXT='Izziòa par precçm bez kustîbas un bez atlikuma '&MENESISUNG
  ELSE
     H_TEXT='Izziòa par precçm bez kustîbas '&MENESISUNG
  .

  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1
  IF NOL_KOPS::USED=0
     CHECKOPEN(NOL_KOPS,1)
  .
  NOL_KOPS::USED+=1
  BIND(KOPS:RECORD)
  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preces bez kustîbas'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      kops:nomenklat=nomenklat
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
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
          IF F:ATL[1]=0
            PRINT(RPT:HEADERFIRST) !BEZ ATLIKUMA
          ELSE
            PRINT(RPT:HEADERSECOND)!AR ATLIKUMU + BEZ ATLIKUMA
          .
      ELSE
          IF ~OPENANSI('K_PRECES.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=H_TEXT&CHR(9)&FORMAT(B_DAT,@D6)
          ADD(OUTFILEANSI)
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
          IF F:ATL[1]=0
            OUTA:LINE='  NPK'&CHR(9)&'Nomenklatûra {9}'&CHR(9)&'Nosaukums {41}'&CHR(9)&'('&NOKL_CP&')    Cena'&CHR(9)&'Kataloga   Numurs'&CHR(9)&'Svîtru kods'
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='  NPK'&CHR(9)&'Nomenklatûra {9}'&CHR(9)&'Nosaukums {41}'&CHR(9)&'('&NOKL_CP&')    Cena'&CHR(9)&'Kataloga   Numurs'&CHR(9)&'Svîtru kods'&CHR(9)&'Atlikums'
            ADD(OUTFILEANSI)
          END
          OUTA:LINE='-{130}'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
       LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
         IF ~CYCLENOM(KOPS:NOMENKLAT)
            CLEAR(FIFO:RECORD)
            JADRUKA#=TRUE
            ATLIKUMS=0
            FIFO:U_NR=KOPS:U_NR
            SET(FIFO:NR_KEY,FIFO:NR_KEY)
            LOOP
               NEXT(NOL_FIFO)
               IF ~(FIFO:U_NR=KOPS:U_NR) OR ERROR() THEN BREAK. !NAV NEVIENA IERAKSTA (KUSTÎBAS UN ATLIKUMA)
               IF FIFO:DATUMS>B_DAT THEN BREAK.
               IF FIFO:D_K='A' ! IR ATLIKUMS
                  ATLIKUMS=FIFO:DAUDZUMS
               ELSIF INRANGE(FIFO:DATUMS,S_DAT,B_DAT) !IR KUSTÎBA PIEPRASÎTAJÂ PERIODÂ
                  JADRUKA#=FALSE
                  BREAK
               ELSE
                  IF FIFO:D_K[1]='D' THEN ATLIKUMS+=FIFO:DAUDZUMS.
                  IF FIFO:D_K[1]='K' THEN ATLIKUMS-=FIFO:DAUDZUMS.
               .
            .
            IF JADRUKA#=TRUE AND ~(F:ATL[1]=0 AND ATLIKUMS) !Nevajag ar Atlikumiem
               CENA=GETNOM_K(KOPS:NOMENKLAT,0,7)   !PIE REIZES POZICIONÇJAM NOM_K
               NPK += 1
               IF F:DBF = 'W'
                    IF F:ATL[1]=0  ! bez kustîbas un bez atlikuma
                        PRINT(RPT:DETAILFIRST)
                    ELSE           ! bez kustîbas
                        IF F:ATL[2]=1 OR (F:ATL[2]=0 AND ATLIKUMS)
                           PRINT(RPT:DETAILSECOND)
                           SUMMAKOPA+=CENA*ATLIKUMS
                        .
                    .
               ELSE
                    IF F:ATL[1]=0
                        OUTA:LINE=FORMAT(NPK,@N_5)&CHR(9)&KOPS:NOMENKLAT&CHR(9)&NOM:NOS_P&CHR(9)&FORMAT(CENA,@N_11.3)&CHR(9)&FORMAT(NOM:KATALOGA_NR,@S17)&CHR(9)&FORMAT(NOM:KODS,@N_13)
                        ADD(OUTFILEANSI)
                    ELSE
                        OUTA:LINE=FORMAT(NPK,@N_5)&CHR(9)&KOPS:NOMENKLAT&CHR(9)&NOM:NOS_P&CHR(9)&FORMAT(CENA,@N_11.3)&CHR(9)&FORMAT(NOM:KATALOGA_NR,@S17)&CHR(9)&FORMAT(NOM:KODS,@N_13)&CHR(9)&FORMAT(ATLIKUMS,@N_11.3)
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
        POST(Event:CloseWindow)
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
  IF F:DBF = 'W'
    IF F:ATL[1]=0
        PRINT(RPT:RPT_FOOT_FIRST)
    ELSE
        PRINT(RPT:RPT_FOOT_SECOND)
    END
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!!     report{Prop:Preview} = PrintPreviewImage
     ENDPAGE(report)
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
  NOL_KOPS::USED-=1
  IF NOL_KOPS::USED=0
     CLOSE(NOL_KOPS)
  .
  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
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
  IF ERRORCODE() OR (CYCLENOM(KOPS:NOMENKLAT)=2)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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
