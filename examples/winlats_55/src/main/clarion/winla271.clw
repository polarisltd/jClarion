                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_ATZ_K              PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
FILE_DAT            LONG
atz_warlevel        STRING(30)

!-----------------------------------------------------------------------------
Process:View         VIEW(PAR_Z)
                       PROJECT(NR)
                       PROJECT(TEKSTS)
                       PROJECT(WARLEVEL)
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
report REPORT,AT(146,1229,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,198,8000,1031),USE(?unnamed)
         STRING(@s45),AT(1688,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7271,469),PAGENO,USE(?PageCount),RIGHT
         STRING('Atzîmes partneriem'),AT(2385,417,1813,229),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4198,417),USE(file_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(604,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(823,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(3458,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Kods'),AT(177,771,417,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1792,781,1094,208),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Lîmenis'),AT(3490,781,646,208),USE(?String4:4),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4135,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Atzîme'),AT(4469,781,646,208),USE(?String4:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Piezîmes'),AT(6438,781,646,208),USE(?String4:3),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,990,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed:4)
         LINE,AT(604,-10,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@N_4B),AT(250,10,292,146),USE(ATZ:NR),RIGHT
         STRING(@N3),AT(3698,-10),USE(ATZ:WARLEVEL),TRN,RIGHT
         LINE,AT(3458,0,0,167),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(823,-10,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s40),AT(854,0,2594,146),USE(ATZ:TEKSTS),LEFT
         STRING(@s30),AT(4177,0,1948,146),USE(ATZ_WARLEVEL),LEFT
         LINE,AT(7865,-10,0,167),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(4135,-10,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,156),USE(?unnamed:3)
         LINE,AT(156,0,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,21),USE(?String18),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,21),USE(acc_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6854,21),USE(DAT,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7448,21),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,11000,8000,52)
         LINE,AT(156,0,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,62),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

!window WINDOW('Papildus Filtrs'),AT(,,155,105),GRAY
!       OPTION('Sadaïa:'),AT(15,9,130,69),USE(F:SADALA),BOXED
!         RADIO('Visas'),AT(26,19,111,10),USE(?F:SADALA:Radio1),VALUE(' ')
!         RADIO('Bilance'),AT(26,29,111,10),USE(?F:SADALA:Radio2),VALUE('B')
!         RADIO('Peïòas/zaudçjumu aprçíins'),AT(26,39,111,10),USE(?F:SADALA:Radio3),VALUE('P')
!         RADIO('Naudas plûsmas pârskats'),AT(26,49,111,10),USE(?F:SADALA:Radio4),VALUE('N')
!         RADIO('Paðu kapitâla izmaiòu pârskats'),AT(26,59,111,10),USE(?F:SADALA:Radio5),VALUE('K')
!       END
!       BUTTON('&OK'),AT(70,81,35,14),USE(?OkButton),DEFAULT
!       BUTTON('&Atlikt'),AT(109,81,36,14),USE(?CancelButton)
!     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPCIJA='1'
!         1
  izzfiltF                     !NO MAINa NEDRÎKST SAUKT....
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  .

!  OPEN(window)
!  ACCEPT
!    CASE FIELD()
!    OF ?OkButton
!      CASE EVENT()
!      OF EVENT:Accepted
!          LocalResponse = RequestCompleted
!          BREAK
!      END
!    OF ?CancelButton
!      CASE EVENT()
!      OF EVENT:Accepted
!        LocalResponse = RequestCancelled
!        close(window)
!        DO ProcedureReturn
!      END
!    END
!  END
!  close(window)

  FILE_dat=today()
  dat=today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(PAR_Z,1)
  PAR_Z::Used += 1
  IF RECORDS(PAR_Z)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\PAR_Z')
     DO PROCEDURERETURN
  .
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  FilesOpened = True

  RecordsToProcess = RECORDS(PAR_Z)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Atzîmes partneriem'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_Z,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ATZ:RECORD)
      SET(ATZ:NR_KEY)
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
        IF ~OPENANSI('ATZ.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Atzîmes partneriem uz '&format(FILE_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Kods'&CHR(9)&' '&CHR(9)&' Teksts'&CHR(9)&'Lîmenis'&CHR(9)&'Atzîme'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF LÎMEÒA FILTRS
            npk#+=1
            ?Progress:UserString{Prop:Text}=NPK#
            DISPLAY(?Progress:UserString)
            EXECUTE ATZ:WARLEVEL+1
               ATZ_WARLEVEL='Zinâðanai'
               ATZ_WARLEVEL='Jâbrîdina, sastâdot dokumentu'
               ATZ_WARLEVEL='Aizliegts izrakstît P/Z'
               ATZ_WARLEVEL='Aizliegts tirgot caur kasi'
            .
            IF F:DBF = 'W'
               PRINT(RPT:DETAIL)
            ELSE
               OUTA:LINE=ATZ:NR&CHR(9)&CHR(9)&ATZ:TEKSTS&CHR(9)&ATZ:WARLEVEL&CHR(9)&ATZ_WARLEVEL
               ADD(OUTFILEANSI)
            .
!        .
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
  IF SEND(KON_R,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE !WORD,EXCEL
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
    PAR_Z::Used -= 1
   IF PAR_Z::Used  = 0 THEN CLOSE(PAR_Z).
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
      StandardWarning(Warn:RecordFetchError,'BANKAS_K')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  .
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

N_Mat_SNom           PROCEDURE                    ! Declare Procedure
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

DAT                  DATE
LAI                  TIME
NOSAUKUMS            STRING(50)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSN            DECIMAL(15,3)
DAUDZUMSK            DECIMAL(15,3)
CENA_P               DECIMAL(12,2)
CENA_B               DECIMAL(12,2)
CENA_A               DECIMAL(12,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_A              DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
SUMMA_AK             DECIMAL(12,2)
SUMMA_PK             DECIMAL(12,2)
NOM_VAL              STRING(3)
VALK                 STRING(3)
KOPA                 STRING(10)
MER                  STRING(7)
PLAUKTS              STRING(30)
NOLIKTAVA            STRING(50)
FORMAPN1             STRING(10)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA                 DECIMAL(14,2)
                     .
N_TABLE              QUEUE,PRE(N)
NOMENKLAT               STRING(3) !GRUPA
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_A                 DECIMAL(11,2)
SUMMA_P                 DECIMAL(14,2)
                     .

VIRSRAKSTS           STRING(80)
FILTRS_TEXT          STRING(100)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_K)
                       PROJECT(NOM:NOMENKLAT)
                       PROJECT(NOM:EAN)
                       PROJECT(NOM:KODS)
                       PROJECT(NOM:BKK)
                       PROJECT(NOM:NOS_P)
                       PROJECT(NOM:NOS_S)
                       PROJECT(NOM:NOS_A)
                       PROJECT(NOM:PVN_PROC)
                       PROJECT(NOM:SVARSKG)
                       PROJECT(NOM:SKAITS_I)
                       PROJECT(NOM:TIPS)
                       PROJECT(NOM:KRIT_DAU)
                       PROJECT(NOM:MERVIEN)
                     END


report REPORT,AT(400,1300,8000,9750),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(400,100,8000,1198),USE(?unnamed)
         STRING(@s45),AT(1219,52,4583,156),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(521,260,5979,156),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(6760,323,771,156),USE(FORMAPN1),CENTER
         STRING(@P<<<#. lapaP),AT(6958,469,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s95),AT(42,469,6948,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,,CHARSET:ANSI)
         LINE,AT(104,677,7450,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Grupa, Nosaukums'),AT(375,833,1667,208),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(3740,823,729,208),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba pçc 6.c.'),AT(4583,729,854,208),USE(?String4:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba pçc '),AT(6385,719,708,208),USE(?String4:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(4604,938,677,208),USE(?String34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(6385,927,917,208),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(5510,938,615,208),USE(?String34:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1146,7450,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@S1),AT(7104,719,156,208),USE(nokl_cp),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba pçc 6.c.'),AT(5479,729,844,208),USE(?String4:11),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('c.'),AT(7281,719,115,208),USE(?String4:2),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5448,677,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(6344,677,0,521),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(3656,677,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4552,677,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7542,677,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(104,677,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8000,146),USE(?unnamed:5)
         LINE,AT(104,0,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(458,0,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(3656,0,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4552,0,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5448,0,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7542,0,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@s3),AT(146,10,260,156),USE(N:NOMENKLAT),RIGHT(1)
         STRING(@s50),AT(500,10,3125,156),USE(NOSAUKUMS),LEFT
         STRING(@N-_12.2),AT(3688,10,833,156),USE(N:DAUDZUMS),RIGHT
         STRING(@N-_12.2),AT(4583,10,833,156),USE(N:SUMMA_B),RIGHT
         STRING(@N-_12.2),AT(5479,10,833,156),USE(N:SUMMA_A),RIGHT
         STRING(@N-_14.2),AT(6427,10,781,156),USE(N:SUMMA_P),RIGHT
         STRING(@s3),AT(7281,10,229,156),USE(NOM_VAL),LEFT
       END
detailN DETAIL,AT(,,8000,146),USE(?unnamed:2)
         LINE,AT(3656,0,0,198),USE(?Line22:11),COLOR(COLOR:Black)
         LINE,AT(4552,0,0,198),USE(?Line22:12),COLOR(COLOR:Black)
         LINE,AT(5448,0,0,198),USE(?Line22:13),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,198),USE(?Line22:16),COLOR(COLOR:Black)
         LINE,AT(7542,0,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,0,0,198),USE(?Line22:8),COLOR(COLOR:Black)
         STRING(@s15),AT(2698,10,938,156),USE(NOLIKTAVA),LEFT
         STRING(@N-_12.2),AT(3698,10,833,156),USE(DAUDZUMSN),RIGHT
       END
LINE   DETAIL,AT(,,8000,0)
         LINE,AT(104,,7450,0),USE(?Line24),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,8000,177),USE(?unnamed:3)
         LINE,AT(104,0,0,198),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(4552,0,0,198),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(5448,0,0,198),USE(?Line25:5),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,198),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(7542,0,0,198),USE(?Line25:6),COLOR(COLOR:Black)
         STRING(@s10),AT(156,21,677,156),USE(KOPA),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(3635,21,885,156),USE(DAUDZUMSK),RIGHT
         STRING(@N-_14.2),AT(6396,21,813,156),USE(SUMMA_PK),RIGHT
         STRING(@s3),AT(7281,21,229,156),USE(VALK),LEFT
         STRING(@N-_14.2),AT(4604,21,813,156),USE(SUMMA_BK),TRN,RIGHT
         STRING(@N-_14.2),AT(5500,10,813,156),USE(SUMMA_AK),TRN,RIGHT
       END
RPT_FOOT3 DETAIL,AT(,,8000,271),USE(?unnamed:4)
         LINE,AT(104,,0,63),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(4552,,0,63),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(5448,,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(6344,,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(7542,,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7450,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,83),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1667,83),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1927,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6229,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6958,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(688,83),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(0,11000,8000,0),USE(?unnamed:6)
         LINE,AT(104,,7450,0),USE(?Line1:4),COLOR(COLOR:Black)
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
! TIEK SAUKTS NO IZZIÒÂM UN MultiN_IZZIÒÂM
!
  PUSHBIND

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  IF NOLIK::Used = 0        
    CheckOpen(NOLIK,1)
  END
  NOLIK::USED+=1
  CHECKOPEN(SYSTEM,1)
  IF NOM_K::USED=0
     CheckOpen(NOM_K,1)
  .
  NOM_K::Used += 1
  BIND(NOM:RECORD)

  dat = today()
  lai = clock()

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu atlikumi noliktavâ'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      IF F:NOA      !sauc no Failiem vai M-atskaitçm
!         B_DAT=TODAY()
!         Stringplaukts='Noliktava'
         FORMAPN1='FORMA FPN1'
         VIRSRAKSTS='Preèu atlikumi (S_Nom_grupâm) uz '&FORMAT(B_DAT,@D06.)&' visas noliktavas'
      ELSE          !SAUC NO NOL_IZZIÒÂM
         IF CL_NR=1671 !LATLADA
!            Stringplaukts='Krâsa'
         ELSE
!            Stringplaukts='Plaukts'
         .
         FORMAPN1='FORMA PN1'
         VIRSRAKSTS='Preèu atlikumi (S_Nom_grupâm) uz '&FORMAT(B_DAT,@D06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      .
!      FILTRS_TEXT=GETFILTRS_TEXT('000011000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
      FILTRS_TEXT=GETFILTRS_TEXT('000001000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                 123456789
      IF F:ATL THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Pçc atlikumiem: '.
      IF F:ATL[1]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'+A'.
      IF F:ATL[2]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'0A'.
      IF F:ATL[3]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'-A'.

      CLEAR(nom:RECORD)
      NOM:nomenklat=nomenklat
      SET(nom:NOM_key,nom:nom_key)
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
        IF ~OPENANSI('PRATNOL.TXT')
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
        IF F:DBF='E'
           OUTA:LINE='Grupa'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'Vçrtîba pçc 6.c.'&CHR(9)&'Vçrtîba pçc 6.c.'&CHR(9)&'Vçrtîba ar PVN'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'bez PVN'&CHR(9)&'ar PVN'&CHR(9)&'pçc '&nokl_cp&'.c.'
           ADD(OUTFILEANSI)
        ELSE   !WORD
           OUTA:LINE='Grupa'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'Vçrtîba pçc 6.c. bez PVN'&CHR(9)&'Vçrtîba pçc 6.c. ar PVN'&CHR(9)&'Vçrtîba ar PVN pçc '&nokl_cp&'.c.'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF ~CYCLENOM(NOM:NOMENKLAT) AND INSTRING(NOM:TIPS,NOM_TIPS7)
        IF INSTRING(NOM:TIPS,NOM_TIPS7)
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
!           DAUDZUMS=LOOKATL(2)
           IF F:NOA                                   !VISAS NOLIKTAVAS
              IF (B_DAT=TODAY() OR B_DAT=DB_B_DAT) AND RS='A' AND ~F:CEN !NAV JÇGAS & NAV PIEPRASÎTS PÂRRÇÍINÂT
                 DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,5,0) ! KOPÂ VISÂS NOLIKTAVÂS
              ELSE
                 DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,5,2) ! PÂRRÇÍINA ATLIKUMUS VISÂS NOLIKTAVÂS UZ B_DAT
              .
           ELSE
              IF (B_DAT=TODAY() OR B_DAT=DB_B_DAT) AND RS='A' !NAV JÇGAS PÂRRÇÍINÂT
                 DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,1,0)
              ELSE
                 DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,1,2) ! PÂRRÇÍINA ATLIKUMUS KONKRÇTÂ NOLIKTAVÂ UZ B_DAT
!                 DAUDZUMS=LOOKATL(3) !KÂ F-JA NO RST
              .
           .
           IF ~(NOM:REDZAMIBA=1 AND DAUDZUMS=0) !~ARHÎVS AR ATLIKUMU
              IF (DAUDZUMS>0 AND F:ATL[1]='1') OR (DAUDZUMS=0 AND F:ATL[2]='1') OR (DAUDZUMS<0 AND F:ATL[3]='1')
                EXECUTE NOKL_CP
                   CP#=00000001B
                   CP#=00000010B
                   CP#=00000100B
                   CP#=00001000B
                   CP#=00010000B
                .
                IF BAND(NOM:ARPVNBYTE,CP#) ! AR PVN
                   Cena_P = GETNOM_K(NOM:NOMENKLAT,0,7)
                   CENA_P = Cena_P/(1+NOM:PVN_PROC/100)
                ELSE                       ! BEZ PVN
                   CENA_P = GETNOM_K(NOM:NOMENKLAT,0,7)
                   Cena_P = CENA_P*(1+NOM:PVN_PROC/100)

                .
                CENA_B = GETNOM_K(NOM:NOMENKLAT,0,7,6)
                CENA_A = CENA_B*(1+NOM:PVN_PROC/100)
!                IF ~F:NOA THEN PLAUKTS=GETNOM_ADRESE(NOM:NOMENKLAT,0).
!                IF CL_NR=1671 THEN PLAUKTS=GETNOM_K(NOM:NOMENKLAT,0,25). !RINDA2PZ   Colour LATLADA

                NOM_VAL= GETNOM_K(NOM:NOMENKLAT,0,13)
                SUMMA_P = DAUDZUMS*CENA_P
                SUMMA_B = DAUDZUMS*CENA_B
                SUMMA_A = DAUDZUMS*CENA_A
                GET(K_TABLE,0)
                K:VAL=NOM_VAL
                GET(K_TABLE,K:VAL)
                IF ERROR()
                  K:VAL=NOM_VAL
                  K:SUMMA=SUMMA_P
                  ADD(K_TABLE)
                  IF ERROR()
                    kluda(29,'Valûtas-'&k:VAL)
                    FREE(K_TABLE)
                    RETURN
                  .
                  SORT(K_TABLE,K:VAL)
                ELSE
                  K:SUMMA+=SUMMA_P
                  PUT(K_TABLE)
                .

                N:NOMENKLAT=NOM:NOMENKLAT[1:3]
                GET(N_TABLE,N:NOMENKLAT)
                IF ERROR()
                   N:DAUDZUMS=DAUDZUMS
                   N:SUMMA_B=SUMMA_B
                   N:SUMMA_A=SUMMA_A
                   N:SUMMA_P=SUMMA_P
                   ADD(N_TABLE)
                ELSE
                   N:DAUDZUMS+=DAUDZUMS
                   N:SUMMA_B+=SUMMA_B
                   N:SUMMA_A+=SUMMA_A
                   N:SUMMA_P+=SUMMA_P
                   PUT(N_TABLE)
                .
                DAUDZUMSK += DAUDZUMS
                SUMMA_BK+=SUMMA_B
                SUMMA_AK+=SUMMA_A
                SUMMA_PK+=SUMMA_P
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
!    IF ~F:DTK
       LOOP I#=1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          NOSAUKUMS    = GETGRUPA(N:NOMENKLAT[1:3],0,1)
          IF F:DBF='W'              !tikai WMF t.s. noliktavas
             IF F:NOA               !VISAS NOLIKTAVAS
                VAIRAK_KA_1#=0
                LOOP N#= 1 TO NOL_SK
                    IF GETNOM_A('POZICIONÇTS',1,0,N#)
                       VAIRAK_KA_1#+=1
                       FOUND#=N#
                    .
                .
                IF VAIRAK_KA_1#>1
!                            PLAUKTS=''
                   PRINT(RPT:DETAIL)
                   LOOP N#= 1 TO NOL_SK
                       DAUDZUMSN=GETNOM_A(NOM:NOMENKLAT,1,0,N#)
                       IF DAUDZUMSN AND ~(CL_NR=1033)     !ÍÎPSALA
                          NOLIKTAVA='t.s.  N '&CLIP(N#)
                          PRINT(RPT:DETAILN)
                       .
                   .
                ELSE
!                            PLAUKTS='N '&CLIP(FOUND#)
                   PRINT(RPT:DETAIL)
                .
             ELSE
                PRINT(RPT:DETAIL)
             .
          ELSE                      !EXCEL NE+NN
             OUTA:LINE=N:NOMENKLAT&CHR(9)&NOSAUKUMS&LEFT(FORMAT(DAUDZUMS,@N-_15.3))&CHR(9)&|
             LEFT(FORMAT(N:SUMMA_B,@N_13.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_A,@N_13.2))&CHR(9)&|
             LEFT(FORMAT(N:SUMMA_P,@N-_14.2))&CHR(9)&NOM_VAL
             ADD(OUTFILEANSI)
          .
       .
!    .

    IF F:DBF='W'   !WMF
       PRINT(RPT:LINE)
    .
    KOPA='Kopâ :'
    !VALK='Ls'
    VALK=val_uzsk
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT2)
    ELSE
       OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_15.3))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_14.2))&|
       CHR(9)&LEFT(FORMAT(SUMMA_AK,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&CHR(9)&VALK
       ADD(OUTFILEANSI)
    .
    KOPA=' t.s.'
    DAUDZUMSK   = 0
    !IF ~(RECORDS(K_TABLE)=1 AND K:VAL='Ls')
    IF ~(RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)))
      GET(K_TABLE,0)
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF ~(K:SUMMA = 0)
          SUMMA_PK = K:SUMMA
          VALK    = K:VAL
          IF F:DBF='W'   !WMF
             PRINT(RPT:RPT_FOOT2)
          ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&CHR(9)&VALK
            ADD(OUTFILEANSI)
          .
        .
      .
    .
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT3)
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
  .
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
  free(k_table)
  IF FilesOpened
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    NOLIK::USED-=1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
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
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)=2
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
CALCWL FUNCTION(L_DATUMS,PAR_LIGUMS,OPC)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
WLDATUMS             STRING(10)
WLC                  STRING(26)
WLCG                 GROUP,PRE(),OVER(WLC)
WLC0102              STRING(2)
WLC3                 STRING(1)
WLC4                 STRING(1)
WLC5                 STRING(1)
WLC0607              STRING(2)
WLC8                 STRING(1)
WLC0910              STRING(2)
WLC11                STRING(1)
WLC12                STRING(1)
WLC13                STRING(1)
WLC14                STRING(1)
WLC15                STRING(1)
WLC16                STRING(1)
WLC17                STRING(1)
WLC1819              STRING(2)
WLC20                STRING(1)
WLC2122              STRING(2)
WLC23                STRING(1)
WLC2425              STRING(2)
WLC26                STRING(1)
                     END
WLCR                 STRING(50)
SUMMAKOPA            DECIMAL(7,2)
DSL                  BYTE
DSL_BASE             BYTE
DSL_ALGA             BYTE
DSL_NOLIK            BYTE
DSL_PAM              BYTE
DSL_LA               BYTE
DSL_FP               BYTE
WL          DECIMAL(3),DIM(6,7) !MODUÏI,KODOLS+MAX PAPLAÐINÂJUMI
ROUTE       BYTE,DIM(6)         !6 MODUÏU POZÎCIJA WLC STRINGÂ
MODULE      BYTE,DIM(14)        !6+8 MODUÏU,PAPLAÐINÂJUMU POZÎCIJA WLC STRINGÂ
Window               WINDOW('Winlats konfigurâcija'),AT(,,172,260),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
                       STRING(@S10),AT(43,4,58,12),USE(WLDATUMS),CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
                       STRING(@s26),AT(27,16),USE(WLC,,?WLC0)
                       OPTION('Moduïi'),AT(8,31,151,189),USE(?WLC),BOXED
                       END
                       CHECK('Bâze'),AT(32,44),USE(WLC3),VALUE('B',' ')
                       CHECK('+dienesta auto uzskaite'),AT(42,55),USE(WLC4),DISABLE,VALUE('D','')
                       CHECK('+alt. kontu plâns, budþets'),AT(42,66),USE(WLC5),DISABLE,VALUE('Z','')
                       ENTRY(@n2B),AT(15,76,13,10),USE(DSL_ALGA),HIDE,RIGHT,REQ
                       CHECK('Alga'),AT(32,76),USE(WLC8),VALUE('A','')
                       ENTRY(@n2B),AT(15,90,13,10),USE(DSL_NOLIK),HIDE,RIGHT,REQ
                       CHECK('Noliktava'),AT(32,89),USE(WLC11),VALUE('N',' ')
                       CHECK('+pieslçgums kases ap.'),AT(42,100),USE(WLC12),DISABLE,VALUE('K','')
                       CHECK('+servisa modulis'),AT(42,111),USE(WLC13),DISABLE,VALUE('S','')
                       CHECK('+pasûtîjumu bûvçðana  '),AT(42,122),USE(WLC14),DISABLE,VALUE('J','')
                       CHECK('+aptieku modulis'),AT(42,132),USE(WLC15),DISABLE,VALUE('T','')
                       CHECK('+komplektâcija'),AT(42,143),USE(WLC16),DISABLE,VALUE('O','')
                       CHECK('+I-veikals'),AT(42,153),USE(WLC17),DISABLE,VALUE('I','')
                       ENTRY(@n2B),AT(15,165,13,10),USE(DSL_PAM),HIDE,RIGHT,REQ
                       CHECK('Pamatlîdzekïi'),AT(32,165),USE(WLC20),VALUE('P','')
                       ENTRY(@n2B),AT(15,178,13,10),USE(DSL_LA),HIDE,RIGHT,REQ
                       CHECK('Laika uzskaite'),AT(32,178),USE(WLC23),VALUE('L','')
                       ENTRY(@n2B),AT(15,191,13,10),USE(DSL_FP),HIDE,RIGHT,REQ
                       CHECK('Fiskâlâ druka'),AT(32,191),USE(WLC26),VALUE('F','')
                       STRING('Atvçrtâ'),AT(32,226),USE(?StringAtverta),HIDE
                       STRING(@n-10.2),AT(15,236),USE(SUMMAKOPA),RIGHT
                       ENTRY(@n2B),AT(15,44,13,10),USE(DSL_BASE),HIDE,RIGHT,REQ
                       BUTTON('OK'),AT(91,239,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(129,239,36,14),USE(?CancelButton)
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
  !
  ! CENAS: arî LICENCEi
  !
   WL[1,1]=300 !BÂZE
   WL[1,2]=80  !+D_AUTO
   WL[1,3]=200 !+BUDZETS
   WL[2,1]=150 !ALGA
   WL[3,1]=200 !NOLIKTAVA
   WL[3,2]=100 !+KASES
   WL[3,3]=150 !+AUTOSERVISS
   WL[3,4]=150 !+STATISTIKA
   WL[3,5]=100 !+APTIEKA
   WL[3,6]=100 !+KOMPLEKTÂCIJA
   WL[3,7]=50  !+I_VEIKALS
   WL[4,1]=100 !P/L
   WL[5,1]=200 !LAika uzskaite
   WL[6,1]=100 !FP
  !
   ROUTE[1]=3    !B-POS WLC STRINGÂ
   ROUTE[2]=8    !A-POS WLC STRINGÂ
   ROUTE[3]=11   !N-POS WLC STRINGÂ
   ROUTE[4]=20   !P-POS WLC STRINGÂ
   ROUTE[5]=23   !L-POS WLC STRINGÂ
   ROUTE[6]=26   !F-POS WLC STRINGÂ
  !
   MODULE[1]=3   !BASE POZÎCIJA WLC STRINGÂ
   MODULE[2]=4
   MODULE[3]=5
   MODULE[4]=8   !ALGA POZÎCIJA WLC STRINGÂ
   MODULE[5]=11  !NOLIKTAVAS POZÎCIJA WLC STRINGÂ
   MODULE[6]=12
   MODULE[7]=13
   MODULE[8]=14
   MODULE[9]=15
   MODULE[10]=16
   MODULE[11]=17
   MODULE[12]=20 !PAMAT POZÎCIJA WLC STRINGÂ
   MODULE[13]=23 !LA POZÎCIJA WLC STRINGÂ
   MODULE[14]=26 !FP POZÎCIJA WLC STRINGÂ
  !
  ! WLDATUMS=PAR_LIGUMS[1:9]
   WLDATUMS=FORMAT(L_DATUMS,@D06.)
  ! LOOP I#=15 TO 45             !LÎGUMS-DSL VAJAG 50
   LOOP I#=1 TO 30              !LÎGUMS=30,WLC=26
      DSL=1
      IF I#-1>0
         IF INRANGE(PAR_LIGUMS[I#-1],1,9)
            DSL=PAR_LIGUMS[I#-1]
            IF I#-2>0
               IF INRANGE(PAR_LIGUMS[I#-2],1,9)
                  DSL=PAR_LIGUMS[I#-2:I#-1]
               .
            .
         .
      .
      E1#=I#+1
      IF E1#>30 THEN E1#=30.
      E2#=I#+2
      IF E2#>30 THEN E2#=30.
      E6#=I#+6
      IF E6#>30 THEN E6#=30.
  
      IF PAR_LIGUMS[I#]='B'                     !***BÂZE
         DSL_BASE=DSL
         WLC[1:3]=FORMAT(DSL_BASE,@N02)&'B'
         IF INSTRING('D',PAR_LIGUMS[E1#:E2#]) !DIENESTA AUTO
            WLC[4]='D'
         .
         IF INSTRING('Z',PAR_LIGUMS[E1#:E2#]) !BUDÞETS
            WLC[5]='Z'
         .
      ELSIF PAR_LIGUMS[I#]='A'                  !***ALGA
         DSL_ALGA=DSL
         WLC[6:8]=FORMAT(DSL_ALGA,@N02)&'A'
      ELSIF PAR_LIGUMS[I#]='N'                  !***NOLIKTAVA
         DSL_NOLIK=DSL
         WLC[9:11]=FORMAT(DSL_NOLIK,@N02)&'N'
         IF INSTRING('K',PAR_LIGUMS[E1#:E6#]) !KASES AP
            WLC[12]='K'
         .
         IF INSTRING('S',PAR_LIGUMS[E1#:E6#]) !AUTOSERVISS
            WLC[13]='S'
         .
         IF INSTRING('J',PAR_LIGUMS[E1#:E6#]) !PASÛTÎJUMI
            WLC[14]='J'
         .
         IF INSTRING('T',PAR_LIGUMS[E1#:E6#]) !APTIEKA
            WLC[15]='T'
         .
         IF INSTRING('O',PAR_LIGUMS[E1#:E6#]) !KOMPLEKTÂCIJA
            WLC[16]='O'
         .
         IF INSTRING('I',PAR_LIGUMS[E1#:E6#]) !I-VEIKALS
            WLC[17]='I'
         .
      ELSIF PAR_LIGUMS[I#]='P'                  !***Pamatlîdzekïi
         DSL_PAM=DSL
         WLC[18:20]=FORMAT(DSL_PAM,@N02)&'P'
      ELSIF PAR_LIGUMS[I#]='L'                  !***LAIKA M.
         DSL_LA=DSL
         WLC[21:23]=FORMAT(DSL_LA,@N02)&'L'
      ELSIF PAR_LIGUMS[I#]='F'                  !***FISCAL_P
         DSL_FP=DSL
         WLC[24:26]=FORMAT(DSL_FP,@N02)&'F'
      .
   .
  ACCEPT
     LOOP I#=1 TO 6  !6 MODUÏI
        J#=ROUTE[I#] !MODUÏA POZÎCIJA WLC STRINGÂ
    !    STOP(I#&J#&WLC[J#])
        IF WLC[J#]
           EXECUTE I#
              IF ~DSL_BASE THEN DSL_BASE=1.
              IF ~DSL_ALGA THEN DSL_ALGA=1.
              IF ~DSL_NOLIK THEN DSL_NOLIK=1.
              IF ~DSL_PAM THEN DSL_PAM=1.
              IF ~DSL_LA THEN DSL_LA=1.
              IF ~DSL_FP THEN DSL_FP=1.
           .
           EXECUTE I#
              UNHIDE(?DSL_BASE)
              UNHIDE(?DSL_ALGA)
              UNHIDE(?DSL_NOLIK)
              UNHIDE(?DSL_PAM)
              UNHIDE(?DSL_LA)
              UNHIDE(?DSL_FP)
           .
           EXECUTE I#
              WLC[1:2]=FORMAT(DSL_BASE,@N02)
              WLC[6:7]=FORMAT(DSL_ALGA,@N02)
              WLC[9:10]=FORMAT(DSL_NOLIK,@N02)
              WLC[18:19]=FORMAT(DSL_PAM,@N02)
              WLC[21:22]=FORMAT(DSL_LA,@N02)
              WLC[24:25]=FORMAT(DSL_FP,@N02)
           .
           IF I#=1 THEN ENABLE(?WLC4,?WLC5).   !BASE PAPLAÐINÂJUMI
           IF I#=3 THEN ENABLE(?WLC12,?WLC17). !NOLIK PAPLAÐINÂJUMI
        ELSE
           EXECUTE I#
              HIDE(?DSL_BASE)
              HIDE(?DSL_ALGA)
              HIDE(?DSL_NOLIK)
              HIDE(?DSL_PAM)
              HIDE(?DSL_LA)
              HIDE(?DSL_FP)
           .
           EXECUTE I#
              DSL_BASE=0
              DSL_ALGA=0
              DSL_NOLIK=0
              DSL_PAM=0
              DSL_LA=0
              DSL_FP=0
           .
           EXECUTE I#
              WLC[1:2]='  '
              WLC[6:7]='  '
              WLC[9:10]='  '
              WLC[18:19]='  '
              WLC[21:22]='  '
              WLC[24:25]='  '
           .
           IF I#=1 THEN WLC[4:5]='  '.          !BASE PAPLAÐINÂJUMI
           IF I#=3 THEN WLC[12:17]='      '.    !NOLIK PAPLAÐINÂJUMI
           IF I#=1 THEN DISABLE(?WLC4,?WLC5).   !BASE PAPLAÐINÂJUMI
           IF I#=3 THEN DISABLE(?WLC12,?WLC17). !NOLIK PAPLAÐINÂJUMI
        .
     .
     DISPLAY
    
     SUMMAKOPA=0
     LOOP I#=1 TO 14  !6 MODUÏI+8 PAPLAÐINÂJUMI
        J#=MODULE[I#] !MODUÏA(PAPLAÐINÂJUMA) POZÎCIJA WLC STRINGÂ
    !    STOP(I#&J#&WLC[J#])
        IF WLC[J#]
           EXECUTE I#
              SUMMAKOPA+=WL[1,1]+WL[1,1]*.2*DSL_BASE
              SUMMAKOPA+=WL[1,2]+WL[1,2]*.2*DSL_BASE
              SUMMAKOPA+=WL[1,3]+WL[1,3]*.2*DSL_BASE
              SUMMAKOPA+=WL[2,1]+WL[2,1]*.2*DSL_ALGA
              SUMMAKOPA+=WL[3,1]+WL[3,1]*.2*DSL_NOLIK  !5
              SUMMAKOPA+=WL[3,2]+WL[3,2]*.2*DSL_NOLIK
              SUMMAKOPA+=WL[3,3]+WL[3,3]*.2*DSL_NOLIK
              SUMMAKOPA+=WL[3,4]+WL[3,4]*.2*DSL_NOLIK
              SUMMAKOPA+=WL[3,5]+WL[3,5]*.2*DSL_NOLIK  
              SUMMAKOPA+=WL[3,6]+WL[3,6]*.2*DSL_NOLIK
              SUMMAKOPA+=WL[3,7]+WL[3,7]*.2*DSL_NOLIK  
              SUMMAKOPA+=WL[4,1]+WL[4,1]*.2*DSL_PAM    !12
              SUMMAKOPA+=WL[5,1]+WL[5,1]*.2*DSL_LA     !13
              SUMMAKOPA+=WL[6,1]*DSL_FP                !14
           .
        .
     .
     IF PAR:GRUPA[2]='A'
        UNHIDE(?StringAtverta)
        SUMMAKOPA*=2
     .
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?WLDATUMS)
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
    OF ?DSL_BASE
      CASE EVENT()
      OF EVENT:Accepted
        WLC[1:2]=DSL_BASE
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CASE OPC
        OF 1
           WLC=LEFT(WLC)
           LOOP I#= 1 TO LEN(CLIP(WLC))
              IF ~INSTRING(WLC[I#],' 0')
                 WLCR=CLIP(WLCR)&WLC[I#]
              .
           .
        !   WLCR=PAR_LIGUMS[1:15]&' '&CLIP(WLCR)&'  '&LEFT(FORMAT(SUMMAKOPA,@N_7.2))
        !   WLCR=CLIP(WLCR)&'  '&LEFT(FORMAT(SUMMAKOPA,@N_7.2))
        !   SUMMA=SUMMAKOPA*0.02  !MÇNEÐMAKSA
           SUMMA=SUMMAKOPA       !SUMMA KOPÂ bez PVN
        OF 2
           WLCR=WLC
           SUMMA=SUMMAKOPA       !SUMMA KOPÂ bez PVN
        .
        LOCALRESPONSE=REQUESTCOMPLETED
        BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SUMMA=0       !SUMMA KOPÂ bez PVN, LAI NEDRUKÂ
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(Window)
  WindowOpened=True
  INIRestoreWindow('CALCWL','winlats.INI')
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
!| Finally, we return to the calling procedure, passing WLCR back.
!|
  IF FilesOpened
  END
  IF WindowOpened
    INISaveWindow('CALCWL','winlats.INI')
    CLOSE(Window)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN(WLCR)
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
