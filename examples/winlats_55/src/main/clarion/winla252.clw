                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_Sastavdalas        PROCEDURE                    ! Declare Procedure
DATUMS              LONG
LAI                 LONG
nom_pap_f           BYTE
NOM_NOSAUKUMS       STRING(45)
NOMENKLAT_R         STRING(21)
NOMENKLAT_S         STRING(21)
SAV_NOMENKLAT       LIKE(KOM:NOMENKLAT)
!-----------------------------------------------------------------------------
Process:View         VIEW(KOMPLEKT)
                       PROJECT(NOMENKLAT)
                       PROJECT(NOM_SOURCE)
                       PROJECT(DAUDZUMS)
                       PROJECT(BAITS)
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
         STRING(@s45),AT(2031,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7302,469),PAGENO,USE(?PageCount),RIGHT
         STRING('Sastâvdaïu atskaite'),AT(3448,417),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1823,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2760,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6771,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Raþojums/Sastâvdaïa'),AT(208,781,1615,208),USE(?String4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(1875,781,885,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kataloga Nr'),AT(2813,781,1094,208),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3906,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(3958,781,2813,208),USE(?String4:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(7042,781,573,208),USE(?String4:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,990,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail_R DETAIL,AT(,,,146)
         LINE,AT(1823,-10,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@N_13B),AT(1865,0,833,146),USE(NOM:KODS,,?NOM:KODS:2),RIGHT,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(2760,-10,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s17),AT(2792,0,1094,146),USE(NOM:KATALOGA_NR,,?NOM:KATALOGA_NR:2),LEFT,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(3938,0,2813,146),USE(NOM_NOSAUKUMS,,?NOM_NOSAUKUMS:2),LEFT,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(6771,-10,0,167),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,167),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s21),AT(188,0,1615,146),USE(KOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
detail_S DETAIL,AT(,,,146)
         LINE,AT(1823,-10,0,167),USE(?Line18:2),COLOR(COLOR:Black)
         STRING(@N_13B),AT(1865,0,833,146),USE(NOM:KODS),RIGHT
         LINE,AT(2760,-10,0,167),USE(?Line18:3),COLOR(COLOR:Black)
         STRING(@s17),AT(2792,0,1094,146),USE(NOM:KATALOGA_NR),LEFT
         STRING(@s45),AT(3938,0,2813,146),USE(NOM_NOSAUKUMS),LEFT
         LINE,AT(6771,-10,0,167),USE(?Line18:4),COLOR(COLOR:Black)
         STRING(@N_12.3),AT(6990,0,729,146),USE(KOM:DAUDZUMS),RIGHT
         LINE,AT(7865,-10,0,167),USE(?Line18:5),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,167),USE(?Line18:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line18),COLOR(COLOR:Black)
         STRING(@s21),AT(188,0,1615,146),USE(KOM:NOM_SOURCE),LEFT,FONT('Courier New',9,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT DETAIL,AT(,,,219),USE(?unnamed:2)
         LINE,AT(156,0,0,63),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(1823,0,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,63),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,63),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,63),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(156,52,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(177,73),USE(?String18),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(688,73),USE(acc_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6771,73),USE(DATUMS,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7354,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
LINE   DETAIL,AT(,,,10)
         LINE,AT(156,0,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,10896,8000,52)
         LINE,AT(156,0,7708,0),USE(?LineF1:4),COLOR(COLOR:Black)
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

window WINDOW('Papildus FiltrI'),AT(,,160,110),GRAY
       OPTION,AT(16,12,106,39),USE(NOM_PAP_F),DISABLE,BOXED
         RADIO('Visas nomenklatûras'),AT(27,26,88,10),USE(?NOM_PAP_F:Radio1)
         RADIO('Tikai aktîvâs'),AT(27,37,88,10),USE(?NOM_PAP_F:Radio2)
       END
       PROMPT('F pçc raþojuma:'),AT(4,61),USE(?PromptR)
       ENTRY(@s21),AT(70,60,60,10),USE(NOMENKLAT_R),UPR
       PROMPT('F pçc sastâvdaïas:'),AT(5,74),USE(?PromptS)
       ENTRY(@s21),AT(70,73,60,10),USE(NOMENKLAT_S),UPR
       BUTTON('&OK'),AT(77,91,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(116,91,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPEN(window)
  nom_pap_f=1
  ACCEPT
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
          LocalResponse = RequestCompleted
          BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCancelled
        close(window)
        DO ProcedureReturn
      END
    END
  END
  close(window)

  datums=today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  IF KOMPLEKT::Used = 0
    CheckOpen(KOMPLEKT)
  END
  KOMPLEKT::Used += 1

  BIND(KOM:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(KOMPLEKT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Sastâvdaïu atskaite'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOM:RECORD)
      KOM:NOMENKLAT = NOMENKLAT_R
      SET(KOM:nom_key,NOM:NOM_KEY)
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      NOMENKLAT=NOMENKLAT_R
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
        IF ~OPENANSI('KOMPL.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Sastâvdaïu atskaite'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Nomenklatûra'&CHR(9)&'Kods'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Nosaukums'&CHR(9)&'Skaits'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF ~CYCLENOM(KOM:NOMENKLAT) AND ~(nom_pap_f=2 AND ~(NOM:REDZAMIBA=0))
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        NOMENKLAT=NOMENKLAT_R
        IF ~CYCLENOM(KOM:NOMENKLAT)
           NOMENKLAT=NOMENKLAT_S
           IF ~CYCLENOM(KOM:NOM_SOURCE)
              IF ~(SAV_NOMENKLAT=KOM:NOMENKLAT) !jauns raþojums
                 SAV_NOMENKLAT=KOM:NOMENKLAT
                 NOM_NOSAUKUMS=GETNOM_K(KOM:NOMENKLAT,0,2)
                 IF F:DBF='W'
                    IF ~(npk#=1) then PRINT(RPT:LINE).
                    PRINT(RPT:DETAIL_R)
                 ELSE
                    IF ~(npk#=1)
                       OUTA:LINE=''
                       ADD(OUTFILEANSI)
                    .
                    OUTA:LINE=NOM:NOMENKLAT&CHR(9)&left(FORMAT(NOM:KODS,@N_13))&CHR(9)&NOM:KATALOGA_NR&CHR(9)&|
                    NOM:NOS_P&CHR(9)&'RAZOJUMS'
                    ADD(OUTFILEANSI)
                 .
              .
              NOM_NOSAUKUMS=GETNOM_K(KOM:NOM_SOURCE,0,2)
              IF F:DBF='W'
                 PRINT(RPT:DETAIL_S)
              ELSE
                 OUTA:LINE=KOM:NOM_SOURCE&CHR(9)&LEFT(FORMAT(NOM:KODS,@N_13))&CHR(9)&NOM:KATALOGA_NR&CHR(9)&|
                 NOM:NOS_P&CHR(9)&LEFT(FORMAT(KOM:DAUDZUMS,@N_8.3))
                 ADD(OUTFILEANSI)
              .
           .
        .
        NOMENKLAT=NOMENKLAT_R
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
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    KOMPLEKT::Used -= 1
    IF KOMPLEKT::Used = 0 THEN CLOSE(KOMPLEKT).
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
  IF ERRORCODE() OR CYCLENOM(KOM:NOMENKLAT)=2
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
A_ZinSAunIIN_969     PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
RPT_GADS             DECIMAL(4)
GADST                DECIMAL(4)
MENESIS              STRING(10)
NPK                  DECIMAL(3)
VARUZV               STRING(30)
OBJEKTS              DECIMAL(9,2)
OBJSUM               DECIMAL(9,2)
SAVE_RECORD          LIKE(ALG:RECORD)
save_position        STRING(250)
SAV_YYYYMM           LIKE(ALG:YYYYMM)
NODOKLIS             DECIMAL(9,2)
RISK                 DECIMAL(9,2)
IETIIN               DECIMAL(9,2)
OBJEKTS_K            DECIMAL(9,2)
NODOKLIS_K           DECIMAL(9,2)
IETIIN_K             DECIMAL(9,2)
RISK_K               DECIMAL(9,2)
OBJEKTS_P            DECIMAL(9,2)
NODOKLIS_P           DECIMAL(9,2)
IETIIN_P             DECIMAL(9,2)
RISK_P               DECIMAL(9,2)
CTRL                 DECIMAL(10,2),DIM(6)
ALG_SOC_V            LIKE(ALG:SOC_V)
VECUMS               BYTE

SS                   STRING(2)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

KOPA_IZMAKSAT        DECIMAL(12,2)
YYYYMM               LONG
M0                   DECIMAL(10,2)
M1                   DECIMAL(10,2)
M2                   DECIMAL(10,2)
M3                   DECIMAL(10,2)
M4                   DECIMAL(10,2)
MM                   DECIMAL(10,2)
SOC_V                STRING(1)        !TÂPAT KÂ KADROS
SOC_VX               STRING(5)
SOC_TEKSTS1          STRING(80)
SOC_TEKSTS2          STRING(80)
IEM_DATUMS           LONG
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

I_TABLE           QUEUE,PRE(I)
KEY                  STRING(7)
ID                   USHORT
SOC_V                BYTE
SOC_V_OLD            BYTE,DIM(2)
UL                   BYTE
INI                  STRING(5)
DIEN                 DECIMAL(10,2)
APRSA                DECIMAL(10,2)
IETIIN               DECIMAL(10,2)
TARIFS               DECIMAL(5,2)
INV_P                STRING(1)
IEM_DATUMS           LONG
STATUSS              STRING(1)
                  END

SUM1                STRING(15)
SUM2                STRING(15)
SUM3                STRING(15)

ATLAISTS            BYTE
E                   STRING(1)
EE                  STRING(40)

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

report REPORT,AT(104,198,8000,10146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,100,8000,104)
       END
RPT_HEAD DETAIL,AT(,,,2948),USE(?unnamed:2)
         STRING('3. pielikums'),AT(6042,52,781,156),USE(?String1)
         STRING(@s40),AT(3177,146,2448,208),USE(EE),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(2875,42,313,313),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('Ministru Kabineta'),AT(6042,208,1458,156),USE(?String1:2)
         STRING('2000. gada 14. novembra'),AT(6042,365,1458,156),USE(?String1:3)
         STRING(@s25),AT(1875,521,1990,208),USE(gl:vid_nos),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('teritoriâlajai iestâdei'),AT(3906,521,1250,208),USE(?String3:2),FONT(,9,,,CHARSET:BALTIC)
         STRING('Noteikumiem Nr 397'),AT(6042,521,1458,156),USE(?String1:4)
         STRING('(ar grozîjumiem Nr 790 un Nr 969)'),AT(5927,677,1771,156),USE(?String1:5),TRN
         LINE,AT(2021,833,0,260),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(3177,833,0,260),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('Nodokïu maksâtâja kods'),AT(479,885,1500,208),USE(?String3:3),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s13),AT(2063,885,1094,208),USE(GL:REG_NR),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(6969,1083,677,208),USE(GL:VID_LNR),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2031,1094,1146,0),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1667,1250,4323,260),USE(client,,?client:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(darba devçja nosaukums vai vârds un uzvârds)'),AT(2573,1510),USE(?String9),CENTER
         STRING('ZIÒOJUMS PAR VALSTS SOCIÂLÂS APDROÐINÂÐANAS OBLIGÂTAJÂM'),AT(1042,1719,5885,208),USE(?String9:3), |
             CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('IEMAKSÂM NO DARBA ÒÇMÇJU DARBA IENÂKUMIEM,'),AT(1042,1927,5885,208),USE(?String9:4), |
             CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('IEDZÎVOTÂJU IENÂKUMA NODOKLI UN UZÒÇMÇJDARBÎBAS RISKA VALSTS NODEVU PÂRSKATA MÇN' &|
             'ESÎ'),AT(375,2135,7188,208),USE(?String9:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N04),AT(3354,2365),USE(rpt_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(3719,2365,469,208),USE(?String15),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(4188,2365,885,208),USE(MENESIS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2604,2583,417,0),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(3021,2583,0,260),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(2031,833,1146,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2604,2583,0,260),USE(?Line36),COLOR(COLOR:Black)
         STRING('Darba ienâkumu izmaksas datums'),AT(760,2635),USE(?String59)
         STRING(@N2),AT(2719,2615),USE(SYS:NOKL_DC),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2615,2833,417,0),USE(?Line34:2),COLOR(COLOR:Black)
         STRING('Valsts ieòçmumu dienesta'),AT(302,521,1625,208),USE(?String3),FONT(,9,,,CHARSET:BALTIC)
       END
SOC_VX_HEAD DETAIL,AT(10,,7990,198)
         STRING('Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, invaliditâtes apdr' &|
             'oðinâðanai, maternitâtes un slimîbas apdroðinâðanai'),AT(729,3594,7188,156),USE(?String62), |
             FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,3854,208,0),USE(?Line40:4),COLOR(COLOR:Black)
         STRING('Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, maternitâtes un sl' &|
             'imîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes'),AT(729,3958,7188,156), |
             USE(?String62:3)
         LINE,AT(417,4010,208,0),USE(?Line40:9),COLOR(COLOR:Black)
         LINE,AT(625,4010,0,260),USE(?Line36:12),COLOR(COLOR:Black)
         STRING(@s1),AT(458,4052,156,208),USE(SOC_VX[5]),CENTER
         LINE,AT(417,4010,0,260),USE(?Line36:11),COLOR(COLOR:Black)
         STRING('gadîjumiem darbâ un arodslimîbâm (darba òçmçji, kuri ir sasnieguði vecumu, kas d' &|
             'od tiesîbas saòemt valsts vecuma pensiju; darba òçmçji,'),AT(729,4115,7188,156),USE(?String62:2), |
             FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,4271,208,0),USE(?Line40:10),COLOR(COLOR:Black)
         STRING('kuriem ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'),AT(729,4271,7188,156), |
             USE(?String62:4)
         STRING('un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (dar' &|
             'ba òçmçji, kuri ir I vai II grupas invalîdi)'),AT(729,3750,7188,156),USE(?String63)
         STRING('Darba òçmçji, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ un kuriem izmaksâ' &|
             'ti neizmaksâtie darba ienâkumi'),AT(729,4479,6979,156),USE(?String64)
         LINE,AT(417,4479,208,0),USE(?Line40:5),COLOR(COLOR:Black)
         LINE,AT(625,4479,0,260),USE(?Line36:8),COLOR(COLOR:Black)
         STRING(@s1),AT(469,4531,156,208),USE(SOC_VX[3]),CENTER
         LINE,AT(417,4479,0,260),USE(?Line36:7),COLOR(COLOR:Black)
         STRING('par darba piespiedu kavçjumu vai kuriem saskaòâ ar tiesas spriedumu izmaksâti la' &|
             'ikus neizmaksâtie darba ienâkumi'),AT(729,4635,7083,156),USE(?String65)
         LINE,AT(417,4740,208,0),USE(?Line40:6),COLOR(COLOR:Black)
         STRING('Personas, no kuru darba ienâkumiem ieturçts iedzîvotâju ienâkuma nodoklis, pamat' &|
             'ojoties uz iepriekðçjâm darba vai dienesta attiecîbâm'),AT(729,4896,7135,156),USE(?String66), |
             FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(469,4844,156,208),USE(SOC_VX[4]),CENTER
         LINE,AT(625,4792,0,260),USE(?Line36:10),COLOR(COLOR:Black)
         LINE,AT(417,4792,0,260),USE(?Line36:9),COLOR(COLOR:Black)
         LINE,AT(417,4792,208,0),USE(?Line40:7),COLOR(COLOR:Black)
         LINE,AT(417,5052,208,0),USE(?Line40:8),COLOR(COLOR:Black)
         STRING('Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'),AT(729,3333,,156),USE(?String61), |
             FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(469,3333,156,208),USE(SOC_VX[1],,?SOC_VX_1:2),CENTER
         LINE,AT(417,3542,208,0),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(417,3594,208,0),USE(?Line40:3),COLOR(COLOR:Black)
         LINE,AT(625,3594,0,260),USE(?Line36:5),COLOR(COLOR:Black)
         STRING(@s1),AT(469,3646,156,208),USE(SOC_VX[2]),CENTER
         LINE,AT(417,3594,0,260),USE(?Line36:6),COLOR(COLOR:Black)
         LINE,AT(625,3281,0,260),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(417,3281,0,260),USE(?Line36:4),COLOR(COLOR:Black)
         LINE,AT(417,3281,208,0),USE(?Line40:2),COLOR(COLOR:Black)
       END
SOCV1_HEAD DETAIL,AT(,,,229),USE(?unnamed:3)
         STRING('1-Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'),AT(729,52,,156),USE(?String61:2), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV2_HEAD DETAIL,AT(,,,563),USE(?unnamed:4)
         STRING('2-Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, invaliditâtes ap' &|
             'droðinâðanai, maternitâtes un slimîbas apdroðinâðanai'),AT(729,42,7188,156),USE(?String62:6), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
         STRING('un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (dar' &|
             'ba òçmçji, kuri ir izdienas pensijas saòçmçji vai'),AT(729,208,7188,156),USE(?String63:3), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
         STRING('III grupas invalîdi - valsts speciâlâs pensijas saòçmçji)'),AT(729,365,7188,156),USE(?String63:2), |
             TRN,FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV3_HEAD DETAIL,AT(,,,573)
         STRING('3-Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, maternitâtes un ' &|
             'slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes'),AT(719,31,7188,156), |
             USE(?String62:7),FONT(,8,,FONT:underline,CHARSET:BALTIC)
         STRING('gadîjumiem darbâ un arodslimîbâm (darba òçmçji, kuri ir sasnieguði vecumu, kas d' &|
             'od tiesîbas saòemt valsts vecuma pensiju; darba òçmçji,'),AT(719,188,7188,156),USE(?String62:8), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
         STRING('kuriem ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'),AT(719,344,7188,156), |
             USE(?String62:9),FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV4_HEAD DETAIL,AT(,,,354)
         STRING('4-Darba òçmçji, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ un kuriem izmak' &|
             'sâti neizmaksâtie darba ienâkumi'),AT(719,31,6979,156),USE(?String64:3),FONT(,8,,FONT:underline,CHARSET:BALTIC)
         STRING('par darba piespiedu kavçjumu vai kuriem saskaòâ ar tiesas spriedumu izmaksâti la' &|
             'ikus neizmaksâtie darba ienâkumi'),AT(719,167,7083,156),USE(?String65:3),FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV5_HEAD DETAIL,AT(,,,229)
         STRING('5-Personas, kuras nav obligâti sociâli apdroðinâmas'),AT(719,42,7135,156),USE(?String66:3), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
PAGE_HEAD DETAIL,AT(,,,938)
         LINE,AT(156,52,7708,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,104,260,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. kods'),AT(521,104,781,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai reì. Nr'),AT(521,313,781,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâkumi,'),AT(3333,313,625,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ls'),AT(3333,521,625,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksas'),AT(4010,521,677,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâk.'),AT(4729,521,521,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apdr.'),AT(5313,521,521,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodeva'),AT(6510,573,677,156),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(7292,573,573,156),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('riska valsts'),AT(6510,417,677,156),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veikðanas'),AT(7292,417,573,156),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('10'),AT(7250,781,573,156),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('1'),AT(208,781,260,156),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(521,781,781,156),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1354,781,1927,156),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(3333,781,625,156),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4010,781,677,156),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(4740,781,521,156),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(5313,781,521,156),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(5885,781,573,156),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(6542,781,573,156),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('soc.'),AT(5313,313,521,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('IIN,  Ls'),AT(5885,313,573,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksu'),AT(7292,260,573,156),USE(?String18:132),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darbîbas'),AT(6510,260,677,156),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Prec.'),AT(5313,104,521,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ietur.'),AT(5885,104,573,208),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmçj-'),AT(6510,104,677,156),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Obligâto'),AT(7292,104,573,156),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7188,52,0,938),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(6458,52,0,938),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(5833,52,0,938),USE(?Line6:8),COLOR(COLOR:Black)
         LINE,AT(5260,52,0,938),USE(?Line6:7),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,938),USE(?Line22),COLOR(COLOR:Black)
         STRING('darba'),AT(4729,313,521,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Prec.'),AT(4729,104,521,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4688,52,0,938),USE(?Line6:6),COLOR(COLOR:Black)
         STRING('soc. apdr.'),AT(4010,313,677,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçíin.'),AT(4010,104,677,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,52,0,938),USE(?Line6:5),COLOR(COLOR:Black)
         STRING('Darba'),AT(3333,104,625,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3281,52,0,938),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('Vârds, uzvârds'),AT(1354,104,1927,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,52,0,938),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(469,52,0,938),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(156,52,0,938),USE(?Line6),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,260)
         LINE,AT(156,0,0,270),USE(?Line15),COLOR(COLOR:Black)
         STRING(@N3),AT(208,52),USE(NPK),RIGHT
         LINE,AT(469,0,0,270),USE(?Line15:2),COLOR(COLOR:Black)
         STRING(@p######-#####p),AT(521,52),USE(KAD:PERSKOD),LEFT
         LINE,AT(1302,0,0,270),USE(?Line15:3),COLOR(COLOR:Black)
         STRING(@s30),AT(1354,52),USE(varuzv),LEFT
         LINE,AT(3281,0,0,270),USE(?Line15:4),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3333,52),USE(OBJEKTS),RIGHT
         LINE,AT(3958,0,0,270),USE(?Line15:5),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(4010,52,583,188),USE(NODOKLIS),RIGHT
         LINE,AT(4688,0,0,270),USE(?Line15:6),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,270),USE(?Line15:7),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,270),USE(?Line15:17),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5865,52),USE(IETIIN),RIGHT
         STRING(@N-_9.2),AT(6563,52),USE(RISK),RIGHT
         STRING(@D6B),AT(7240,52,573,208),USE(IEM_DATUMS),RIGHT
         LINE,AT(7188,0,0,270),USE(?Line15:20),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,270),USE(?Line15:19),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line15:8),COLOR(COLOR:Black)
         LINE,AT(156,0,7708,0),USE(?Line5:4),COLOR(COLOR:Black)
       END
SOCV_FOOT DETAIL,AT(,,,323)
         LINE,AT(469,0,0,270),USE(?Line15:10),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,270),USE(?Line15:9),COLOR(COLOR:Black)
         STRING('KOPÂ  :'),AT(521,52),USE(?String46),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,0,0,270),USE(?Line15:11),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,270),USE(?Line15:12),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3333,52),USE(OBJEKTS_K),RIGHT
         LINE,AT(3958,0,0,270),USE(?Line15:13),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(4073,52),USE(NODOKLIS_K),RIGHT
         LINE,AT(4688,0,0,270),USE(?Line15:14),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,270),USE(?Line15:15),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,270),USE(?Line15:18),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5865,52),USE(IETIIN_k),RIGHT
         STRING(@N-_9.2),AT(6563,52),USE(RISK_k),RIGHT
         STRING('X'),AT(7240,52,625,208),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7188,0,0,270),USE(?Line15:22),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,270),USE(?Line15:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line15:16),COLOR(COLOR:Black)
         LINE,AT(156,260,7708,0),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(156,0,7708,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,313),USE(?unnamed:5)
         LINE,AT(469,0,0,270),USE(?Line115:10),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,270),USE(?Line115:9),COLOR(COLOR:Black)
         STRING('PAVISAM :'),AT(521,52),USE(?String46:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,0,0,270),USE(?Line115:11),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,270),USE(?Line115:12),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3333,52),USE(OBJEKTS_P),RIGHT
         LINE,AT(3958,0,0,270),USE(?Line115:13),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(4073,52),USE(NODOKLIS_P),RIGHT
         LINE,AT(4688,0,0,270),USE(?Line115:14),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,270),USE(?Line115:15),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,270),USE(?Line115:18),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5865,52),USE(IETIIN_P),RIGHT
         STRING(@N-_9.2),AT(6563,52),USE(RISK_P),RIGHT
         STRING('X'),AT(7240,52,625,208),USE(?String318:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7188,0,0,270),USE(?Line115:22),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,270),USE(?Line115:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line115:16),COLOR(COLOR:Black)
         LINE,AT(156,260,7708,0),USE(?Line35:3),COLOR(COLOR:Black)
         LINE,AT(156,0,7708,0),USE(?Line315:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,10320,8000,823),USE(?RPT:PAGE_FOOTER)
         STRING('Z. V.'),AT(990,250,365,208),USE(?String55),CENTER
         STRING(@N4),AT(5240,563),USE(gadsT),RIGHT
         STRING('. gada "____"_{20}'),AT(5656,563),USE(?String54),LEFT
         STRING(@s25),AT(3198,563),USE(SYS:TEL),CENTER
         STRING(@s25),AT(4375,198,1979,208),USE(sys:amats1,,?sys:amats1:2),RIGHT
         STRING('Izpildîtâjs :_{20}'),AT(2229,188),USE(?String49),LEFT
         STRING(@s25),AT(2646,385),USE(sys:paraksts2),CENTER(1)
         STRING('Tâlruòa numurs:'),AT(2208,563),USE(?String49:3),LEFT
         LINE,AT(156,0,7708,0),USE(?Line315:2),COLOR(COLOR:Black)
         STRING('_{20}'),AT(6406,188),USE(?String49:2),LEFT
         STRING(@s25),AT(6094,396),USE(sys:paraksts1),CENTER(1)
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

SOC_V_window WINDOW('Filtrs pçc SA statusa'),AT(,,301,150),GRAY
       OPTION,AT(7,5,290,124),USE(SOC_V),BOXED
         RADIO('1-DN, kuri ir apdroðinâmi atbilstoði visiem valsts sociâlâs apdroðinâðanas veidi' &|
             'em'),AT(10,13),USE(?SOC_V:Radio1),VALUE('1')
         RADIO('2-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (DN, I,II gr.Inv.)'),AT(10,33), |
             USE(?SOC_V:Radio2),VALUE('2')
         RADIO('5-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (vecuma pens.)'),AT(11,55),USE(?SOC_V:Radio5), |
             VALUE('5')
         RADIO('3-DN, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ utt.'),AT(10,78),USE(?SOC_V:Radio3), |
             VALUE('3')
         RADIO('4-Personas, no kuru darba ienâkumiem ieturçts IIN, pamat. un iepr. darba attiecî' &|
             'bâm'),AT(10,98),USE(?SOC_V:Radio4),VALUE('4')
       END
       STRING('(DBF tiks bûvçts no jauna)'),AT(13,22),USE(?StringDBF1)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(13,43),USE(?StringDBF2)
       STRING('(no 2003.g)'),AT(247,55,39,10),FONT(,,0FFH,),USE(?String6)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(14,65),USE(?StringDBF5)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(14,88),USE(?StringDBF3)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(15,108),USE(?StringDBF4)
       BUTTON('&OK'),AT(223,132,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(261,132,36,14),USE(?CancelButton)
     END

DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
ToScreen WINDOW('XML faila sagatavoðana'),AT(,,185,79),GRAY
       OPTION('Norâdiet, kur rakstît'),AT(9,12,173,45),USE(merkis),BOXED
         RADIO('Privâtais folderis'),AT(16,21),USE(?Merkis:Radio1),VALUE('1')
         RADIO('A:\'),AT(16,30),USE(?Merkis:Radio2),VALUE('2')
         RADIO('Tekoðâ direktorijâ'),AT(16,40,161,10),USE(?Merkis:Radio3),VALUE('3')
       END
       BUTTON('&Atlikt'),AT(109,61,36,14),USE(?CancelButton:T)
       BUTTON('&OK'),AT(147,61,35,14),USE(?OkButton:T),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  IF F:XML
     E='E'
     EE='(Darba devçja... ddz_p.duf)'
     DISKETE=FALSE
     disks=''
     MERKIS='1'
     OPEN(TOSCREEN)
     ?Merkis:radio1{prop:text}=USERFOLDER
     ?Merkis:radio3{prop:text}=path()
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?OkButton:T
           CASE EVENT()
           OF EVENT:Accepted
              EXECUTE CHOICE(?MERKIS)
                 DISKS=USERFOLDER&'\'
                 BEGIN
                    DISKS=USERFOLDER&'\'
                    DISKETE=TRUE
                 .
                 DISKS=''
              .
              LocalResponse = RequestCompleted
              BREAK
           END
        OF ?CancelButton:T
           CASE EVENT()
           OF EVENT:Accepted
             LocalResponse = RequestCancelled
              DO ProcedureReturn
           .
        END
     END
     CLOSE(TOSCREEN)
     XMLFILENAME=DISKS&'DDZ_P.DUF'
!     stop(XMLFILENAME)
     CHECKOPEN(OUTFILEXML,1)
     CLOSE(OUTFILEXML)
     OPEN(OUTFILEXML,18)
     IF ERROR()
        KLUDA(1,XMLFILENAME)
     ELSE
        EMPTY(OUTFILEXML)
        F:XML_OK#=TRUE
        XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
        ADD(OUTFILEXML)
!        XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
!        ADD(OUTFILEXML)
        XML:LINE='<<DeclarationFile type="ddz_p">'
        ADD(OUTFILEXML)
        XML:LINE='<<Declaration>'
        ADD(OUTFILEXML)
     .
  .
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
  ProgressWindow{Prop:Text} = '3.pielikums MKN Nr 397+790+969'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      YYYYMM=ALP:YYYYMM
      ALG:YYYYMM=DATE(MONTH(YYYYMM)+10,1,YEAR(YYYYMM)-1)  !LAI DABÛTU 2 MÇNEÐUS ATPAKAÏ
!      STOP(FORMAT(ALG:YYYYMM,@D6))
      SET(ALG:ID_KEY,ALG:ID_KEY)
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
      RPT_GADS =YEAR(YYYYMM)
      GADST=YEAR(TODAY())
      MENESIS=MENVAR(YYYYMM,2,1)
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
!        IF YYYYMM < DATE(1,1,2003)
!           PRINT(RPT:RPT_HEAD)
!        ELSE
           PRINT(RPT:RPT_HEAD)
!        .
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('ZINSAIIN.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'3.pielikums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2000.g. 14.nov.'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 397'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Valsts ieòçmumu dienesta '&GL:VID_NOS&' teritoriâlâ iestâde'
        ADD(OUTFILEANSI)
        OUTA:LINE='Nodokïu maksâtâja kods '&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='ZIÒOJUMS PAR VALSTS SOCIÂLÂS APDROÐINÂÐANAS OBLIGÂTAJÂM'
        ADD(OUTFILEANSI)
        OUTA:LINE='IEMAKSÂM NO DARBA ÒÇMÇJU DARBA IENÂKUMIEM,'
        ADD(OUTFILEANSI)
        OUTA:LINE='IEDZÎVOTÂJU IENÂKUMA NODOKLI UN UZÒÇMÇJDARBÎBAS RISKA VALSTS NODEVU PÂRSKATA MÇNESÎ'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=RPT_GADS&'. gada '&MENESIS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Darba ienâkumu izmaksas datums '&SYS:NOKL_DC
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY
        IF INRANGE(GETKADRI(ALG:ID,0,7),DATE(MONTH(YYYYMM)+10,1,YEAR(YYYYMM)-1),YYYYMM-1) !ATLAISTS PAG V AIZPAG MÇN.
           ALG_SOC_V=4
        ELSIF ALG:SOC_V
           ALG_SOC_V=ALG:SOC_V
        ELSE
           ALG_SOC_V=1
        .
!           IF ~(F:NODALA AND ~(alg:NODALA=F:NODALA)) and ~(id AND ~(alg:id=id)) AND SOC_V=ALG_SOC_V
        IF ~(F:NODALA AND ~(alg:NODALA=F:NODALA)) and ~(id AND ~(alg:id=id))
           IF YYYYMM=alg:YYYYMM  !TEKOÐAIS MÇNESIS
              M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
              M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
              M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
              M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
              M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
              OBJEKTS=M0+M1+M2+M3+M4
              IF SYS:PZ_NR                            !IR DEFINÇTS OBJEKTS (2007.g. Ls23800)
                 DO SUMSOCOBJ                         !SASKAITAM OBLIGÂTO IEMAKSU OBJEKTU NO GADA SÂKUMA
                 IF ~SYS:PZ_NR THEN SYS:PZ_NR=23800.  !OBJEKTS 2007.g.
                 IF SYS:PZ_NR-(OBJSUM+OBJEKTS)<0      !MKN 193
                    KLUDA(0,'Ir sasniegts obligâto iemaksu objekta MAX apmçrs '&CLIP(GETKADRI(ALG:ID,0,1)),,1)
                    OBJEKTS=SYS:PZ_NR-OBJSUM
                    IF OBJEKTS<0 THEN OBJEKTS=0.
                 .
              .
              IF GETKADRI(ALG:ID,0,10)='R' !REZIDENTS
                 VECUMS=GETKADRI(ALG:ID,0,15)
                 IF VECUMS<15
                    OBJEKTS=0  !TÂ ARÎ VAJAG-DATI
                 .
              .
              nodoklis   =  ROUND(objekts*alg:pr37/100,.01)+ROUND(objekts*alg:pr1/100,.01)
              I:KEY=ALG_SOC_V&BAND(ALG:BAITS,00000001b)&ALG:ID !Uzòçmuma lîgums
              GET(I_TABLE,I:KEY)  !Rakstam visu pçc algu saraksta fakta
              IF ERROR()
                 I:ID    =ALG:ID
                 I:SOC_V =ALG_SOC_V
                 I:SOC_V_OLD[2] =ALG:SOC_V
                 I:SOC_V_OLD[1] =0
!                 IF ALG:ID=19
!                  STOP(ALG_SOC_V&I:SOC_V_OLD&ALG:SOC_V)
!                 .
                 I:UL     =BAND(ALG:BAITS,00000001b)
                 I:INI    =ALG:INI
                 I:DIEN   =objekts
                 I:APRSA  =NODOKLIS
                 I:IETIIN =0
                 I:INV_P  =ALG:INV_P
                 I:TARIFS =alg:pr37+alg:pr1
                 I:STATUSS=ALG:STATUSS
!                 I:IEM_DATUMS=ALG:IIN_DATUMS
                 ADD(I_TABLE)
                 SORT(I_TABLE,I:KEY)
              ELSE
                 I:DIEN  +=objekts
                 I:APRSA +=NODOKLIS
                 I:SOC_V_OLD[2] =ALG:SOC_V
                 PUT(I_TABLE)
              .
           .
!           STOP(FORMAT(YYYYMM,@D6)&'='&FORMAT(DATE(MONTH(alg:IIN_DATUMS),1,YEAR(ALG:IIN_DATUMS)),@D6))
           IF YYYYMM=DATE(MONTH(alg:IIN_DATUMS),1,YEAR(ALG:IIN_DATUMS))  !IETURÇTS IIN TEKOÐAJÂ MÇNESÎ
              I:KEY=ALG_SOC_V&BAND(ALG:BAITS,00000001b)&ALG:ID
              GET(I_TABLE,I:KEY)
              IF ERROR()
                 I:ID    =ALG:ID
                 I:SOC_V =ALG_SOC_V
                 I:SOC_V_OLD[1] =ALG:SOC_V
                 I:SOC_V_OLD[2] =0
                 I:UL    =BAND(ALG:BAITS,00000001b)
                 I:INI   =ALG:INI
                 I:DIEN  =0
!                 IF ALG:ID=19
!                  STOP(ALG_SOC_V&I:SOC_V_OLD&ALG:SOC_V)
!                 .
                 I:APRSA =0
                 I:INV_P =ALG:INV_P
                 I:IETIIN=ALG:IIN
                 I:TARIFS=alg:pr37+alg:pr1
                 I:STATUSS=ALG:STATUSS
                 ADD(I_TABLE)
                 SORT(I_TABLE,I:KEY)
              ELSE
                 I:IETIIN+=ALG:IIN
                 I:SOC_V_OLD[1] =ALG:SOC_V !?
                 PUT(I_TABLE)
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     GET(I_TABLE,0)
     LOOP I#= 1 TO RECORDS(I_TABLE)
        GET(I_TABLE,I#)
        IF I:UL AND I:SOC_V=4 THEN CYCLE. !ATLAISTS U.lîgumdarbinieks-visi
        objekts    =  I:DIEN
        nodoklis   =  I:APRSA
        IetIIN     =  I:IETIIN
        IF INSTRING(I:STATUSS,'1234')
           RISK    =  SYS:D_KO
        ELSE
           RISK    =  0
        .
!        STOP(I:STATUSS&' '&I:ID)
        IEM_DATUMS =  I:IEM_DATUMS
!        STOP(I:ID&' '&I:SOC_V_OLD[2]&' '&I:SOC_V_OLD[1]) !IR MAINÎJIES SOC V STATUSS
        IF I:SOC_V_OLD[1] AND ~(I:SOC_V_OLD[1] =I:SOC_V_OLD[2]) AND I:SOC_V=1 !IR MAINÎJIES SOC V STATUSS
           RISK=0
        .
        IF I:SOC_V =  4 THEN RISK=0.    !ATLAISTS JAU IEPRIEKÐÇJÂ MÇNESÎ
        IF I:UL                         !U.Lîgumdarbinieks
           IETIIN  =  0
           RISK    =  0
        .
        objekts_P  += OBJEKTS
        nodoklis_P += NODOKLIS
        IetIIN_P   += IetIIN
        RISK_P     += RISK
!        CTRL[I:SOC_V]  += OBJEKTS+NODOKLIS+IetIIN+RISK
        CTRL[I:SOC_V]  += 1 !lai drukâtu draòía valdes locekïus arî bez algas
     .
     IF F:XML_OK#=TRUE
        XML:LINE='<<DeclarationHeader>'
        ADD(OUTFILEXML)
        IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
        XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
        ADD(OUTFILEXML)
        TEX:DUF=CLIENT
        DO CONVERT_TEX:DUF
        XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="taks_gads" value="'&RPT_GADS&'" />'
        ADD(OUTFILEXML)
        IF YYYYMM > TODAY() THEN KLUDA(27,'taksâcijas periods').
        XML:LINE='<<Field name="taks_men" value="'&MONTH(YYYYMM)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="datums_izm" value="'&SYS:NOKL_DC&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="alga_k" value="'&CUT0(objekts_P,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iemaks_k" value="'&CUT0(NODOKLIS_P,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="algap_k" value="0,00" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iemakp_k" value="0,00" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="ietiin_k" value="'&CUT0(IETIIN_P,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        IF ~SYS:PARAKSTS1 THEN KLUDA(87,'Vadîtâjs').
        XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
        ADD(OUTFILEXML)
        IF ~SYS:PARAKSTS2 THEN KLUDA(87,'Izpildîtâjs').
        XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="telef" value="'&CLIP(SYS:TEL)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="datums_aizp" value="'&FORMAT(TODAY(),@D06.)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="risks_k" value="'&CUT0(RISK_P,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</DeclarationHeader>'
        ADD(OUTFILEXML)
     .

     SORT(I_TABLE,I:INI)
     LOOP SV#=1 TO 5  !5 SOC VEIDI
        EXECUTE SV#   !DB IR BIÐÍI CITA SECÎBA
           SOC_V=1
           SOC_V=2
           SOC_V=5
           SOC_V=3
           SOC_V=4
        .
        objekts_K  = 0
        nodoklis_K = 0
        IetIIN_K   = 0
        RISK_k     = 0
        IF F:DBF = 'W'
           EXECUTE SV#
              PRINT(RPT:SOCV1_HEAD)
              PRINT(RPT:SOCV2_HEAD)
              PRINT(RPT:SOCV3_HEAD)
              PRINT(RPT:SOCV4_HEAD)
              PRINT(RPT:SOCV5_HEAD)
           .
        ELSE
           CASE SV#
           OF 1
              OUTA:LINE='1.Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 2
              OUTA:LINE='2.Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai'
              ADD(OUTFILEANSI)
              OUTA:LINE='un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçji, kuri ir'
              ADD(OUTFILEANSI)
              OUTA:LINE='izdienas pensijas saòçmçji vai III grupas invalîdi-valsts speciâlâs pensijas saòçmçji)'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 3
              OUTA:LINE='3.Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret '
              ADD(OUTFILEANSI)
              OUTA:LINE='nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçji, kuri ir sasniegusi vecumu, kas dod tiesîbas saòemt valsts vecuma pensiju; darba òçmçji,)'
              ADD(OUTFILEANSI)
              OUTA:LINE='kuriem ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 4
              OUTA:LINE='4.Darba òçmçji, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ un kuriem izmaksâti neizmaksâtie darba ienâkumi'
              ADD(OUTFILEANSI)
              OUTA:LINE='par darba piespiedu kavçjumu vai kuriem saskaòâ ar tiesas spriedumu izmaksâti laikus neizmaksâtie darba ienâkumi'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 5
              OUTA:LINE='5.Personas, kuras nav sociâli apdroðinâmas'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           .
        END
        IF ~CTRL[SOC_V] THEN CYCLE.

        IF F:DBF = 'W'
           PRINT(RPT:PAGE_HEAD)
        ELSIF F:DBF = 'E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
           OUTA:LINE='Npk'&CHR(9)&'Personas kods'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Darba'&CHR(9)&'Aprçíin.'&CHR(9)&|
           'Prec.'&CHR(9)&'Prec.'&CHR(9)&'Ietur.'&CHR(9)&'Uzòçmçj-'&CHR(9)&'Obligâto'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'vai reì.Nr.'&CHR(9)&CHR(9)&'ienâkumi,'&CHR(9)&'soc.apdr.'&CHR(9)&'darba'&CHR(9)&|
           'soc.'&CHR(9)&'IIN, Ls'&CHR(9)&'darbîbas'&CHR(9)&'iemaksu'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&'iemaksas'&CHR(9)&'ienâk.'&CHR(9)&'apdr.'&CHR(9)&CHR(9)&|
           'riska v.'&CHR(9)&'veikðanas'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'nodeva'&CHR(9)&'datums'
           ADD(OUTFILEANSI)
        ELSE
           OUTA:LINE=''
           ADD(OUTFILEANSI)
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai reì.Nr'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Darba ienâkumi Ls'&CHR(9)&|
           'Aprçíin.soc.apdr. iemaksas'&CHR(9)&'Prec.darba ienâk.'&CHR(9)&'Prec.soc. apdr.'&CHR(9)&'Ietur.IIN, Ls'&CHR(9)&|
           'Uzòçmçjdarbîbas riska v.nodeva'&CHR(9)&'Obligâto iemaksu veikðanas datums'
           ADD(OUTFILEANSI)
        .
        GET(I_TABLE,0)
        LOOP I#= 1 TO RECORDS(I_TABLE)
           GET(I_TABLE,I#)
           IF ~(I:SOC_V=SOC_V) THEN CYCLE.
           IF I:UL AND I:SOC_V=4 THEN CYCLE. !ATLAISTS U.lîgumdarbinieks-visi
           NPK+=1
           VARUZV     =  GETKADRI(I:ID,2,1)
           objekts    =  I:DIEN
           nodoklis   =  I:APRSA
           IetIIN     =  I:IETIIN
           IF INSTRING(I:STATUSS,'1234')
              RISK    =  SYS:D_KO
           ELSE
              RISK    =  0
           .
!           RISK       =  SYS:D_KO
           IEM_DATUMS =  I:IEM_DATUMS
!           STOP(I:SOC_V_OLD[1]& '=' &I:SOC_V_OLD[2])
           IF I:SOC_V_OLD[1] AND ~(I:SOC_V_OLD[1] =I:SOC_V_OLD[2]) AND I:SOC_V=1 !IR MAINÎJIES SOC V STATUSS
              RISK=0
           .
           IF I:SOC_V =  4 THEN RISK=0.    !ATLAISTS JAU IEPRIEKÐÇJÂ MÇNESÎ
           IF I:UL                         !U.Lîgumdarbinieks
              IETIIN  =  0
              RISK    =  0
           .
           objekts_K  += OBJEKTS
           nodoklis_K += NODOKLIS
           IetIIN_K   += IetIIN
           RISK_k     += RISK
           IF F:DBF = 'W'
              PRINT(RPT:DETAIL)
           ELSE
              OUTA:LINE=FORMAT(Npk,@N3)&CHR(9)&FORMAT(KAD:PERSKOD,@P######-#####P)&CHR(9)&VARUZV&CHR(9)&|
              LEFT(FORMAT(OBJEKTS,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS,@N9.2))&CHR(9)&CHR(9)&CHR(9)&|
              LEFT(FORMAT(IETIIN,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK,@N8.2))
              ADD(OUTFILEANSI)
           END
           IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="num_pk" value="'&npk&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="pers_kods" value="'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="uzv_vards" value="'&CLIP(VARUZV)&'" />'
              ADD(OUTFILEXML)
              !1-DN, kuri ir apdroðinâmi atbilstoði visiem valsts sociâlâs apdroðinâðanas veidiem
              !2-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (DN, I,II gr.Inv.)
              !5-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (vecuma pens.)
              !3-DN, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ utt.
              !4-Personas, no kuru darba ienâkumiem ieturçts IIN, pamat. un iepr. darba attiecîbâm
              EXECUTE SOC_V
                 SS = 'DN'
                 SS = 'DI'
                 SS = 'DN'
                 SS = 'DN'
                 SS = 'DP'
              .
              XML:LINE='<<Field name="statuss" value="'&SS&'" />'
              ADD(OUTFILEXML)
              IF I:SOC_V=4
                 XML:LINE='<<Field name="darbs" value="I" />'
                 ADD(OUTFILEXML)
              .
              XML:LINE='<<Field name="alga" value="'&CUT0(objekts,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="iemaksa" value="'&CUT0(nodoklis,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="iet_iin" value="'&CUT0(IetIIN,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="risks" value="'&CUT0(RISK,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:SOCV_FOOT)
        ELSE
           OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(OBJEKTS_K,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS_K,@N_9.2))&|
           CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(IETIIN_K,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK_k,@N_6.2))
           ADD(OUTFILEANSI)
           OUTA:LINE=''
           ADD(OUTFILEANSI)
        END
     .
     IF F:XML_OK#=TRUE
        XML:LINE='<</Declaration>'
        ADD(OUTFILEXML)
        XML:LINE='<</DeclarationFile>'
        ADD(OUTFILEXML)
        CLOSE(OUTFILEXML)
        IF DISKETE=TRUE
           FILENAME2='A:\DDZ_P.DUF'
           IF ~CopyFileA(XMLFILENAME,FILENAME2,0)
              KLUDA(3,XMLFILENAME&' uz '&FILENAME2)
           .
        .
     .
     IF F:DBF = 'W'
        PRINT(RPT:REP_FOOT)
!        SETTARGET(REPORT,?RPT:PAGE_FOOTER)
!        HIDE(?RPT:PAGE_FOOTER)
!        TARGET{PROP:HEIGHT}=0
        ENDPAGE(report)
     ELSE
        OUTA:LINE=CHR(9)&'PAVISAM:'&CHR(9)&CHR(9)&LEFT(FORMAT(OBJEKTS_P,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS_P,@N_9.2))&|
        CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(IETIIN_P,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK_P,@N_6.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpildîtâjs:___________________'
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlruòa numurs:'&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Vadîtâjs:___________________/'&SYS:PARAKSTS1&'/'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Z.V.'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&GADST&'. gada "___"___________________'
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(I_TABLE)
  CLOSE(OUTFILEXML)
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
  IF ERRORCODE() OR ~(alg:YYYYMM<=YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% '
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .

!-----------------------------------------------------------------------------
SUMSOCOBJ  ROUTINE
! SAVE_RECORD=ALG:RECORD
! save_position=POsition(Process:View)
 SAV_YYYYMM=ALG:YYYYMM
 OBJSUM = 0
 ALG:YYYYMM=DATE(1,1,YEAR(ALG:YYYYMM)) ! NO GADA SÂKUMA
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR (ALG:YYYYMM = SAV_YYYYMM) THEN BREAK.
    M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
    M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
    M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
    M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
    M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
    OBJSUM+=M0+M1+M2+M3+M4
 .
 SET(ALG:ID_KEY,ALG:ID_KEY)
! RESET(Process:View,SAVE_POSITION)
 NEXT(ALGAS)
! ALG:RECORD=SAVE_RECORD

B_PavIzlAtsk         PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(gg)
                       PROJECT(GG:U_NR)
                       PROJECT(GG:RS)
                       PROJECT(GG:DOK_SENR)
                       PROJECT(GG:ATT_DOK)
                       PROJECT(GG:DOKDAT)
                       PROJECT(GG:DATUMS)
                       PROJECT(GG:PAR_NR)
                     END
!------------------------------------------------------------------------

Periods_TEXT         STRING(80)
RPT_NPK              STRING(2)
PAR_PVN_PASE         STRING(13)
SUMMAK               DECIMAL(12,2)
SUMMAAK              DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)
DIVI                 BYTE
E                    STRING(1)
EE                   STRING(50)
FF                   STRING(1),DIM(6)
SERIJA               STRING(5),DIM(6)
NRNO                 DECIMAL(6),DIM(6)
NRLIDZ               DECIMAL(6),DIM(6)

C_DOK_SE             STRING(5)
C_DOK_NR             DECIMAL(6)
GG_DOK_SE            STRING(5)
GG_DOK_NR            DECIMAL(6)
JAUNSPPRBLOKS        BYTE
ASIAA_TEXT           STRING(30)
LINEH                STRING(180)
SKAITS               ULONG
SKAITSK              ULONG
SKAITSXML            ULONG,DIM(5)
DOK_dat              string(25)
VUTA                 STRING(51)
num_no               STRING(10)
num_lidz             STRING(12)
SAV_SE               STRING(5)
JABUT_NR             DECIMAL(6)


I_TABLE          QUEUE,PRE(I)
F                    STRING(1)
SERIJA               STRING(5)
NRNO                 DECIMAL(6)
NRLIDZ               DECIMAL(6)
                 .

P_TABLE            QUEUE,PRE(P)
DOK_SENR             STRING(14)
DOK_SE               STRING(5)
DOK_NR               STRING(6)
SUMMA_P              DECIMAL(12,2)
                   .

TEX:DUF             STRING(100)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

!-------------------------------------------------------------------------
!report REPORT,AT(198,1385,8000,11198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
! Y+H max=11250
report REPORT,AT(198,1505,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADSUP DETAIL,AT(,,,3188),USE(?unnamed:6)
         STRING(@s1),AT(2844,104),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('2.pielikums'),AT(5208,208,2292,208),USE(?String301),TRN,RIGHT
         STRING(@s50),AT(3156,260,3188,156),USE(EE),TRN,LEFT
         STRING('Ministru kabineta'),AT(6646,344),USE(?String302),TRN,RIGHT
         STRING('2003.gada 25. jûnija'),AT(6479,479),USE(?String303),TRN,RIGHT
         STRING('PÂRSKATS'),AT(3438,781),USE(?String39),TRN,CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('noteikumiem Nr. 339'),AT(6479,604),USE(?String304),TRN,RIGHT
         STRING('par stingrâs uzskaites preèu pavadzîmes-rçíina'),AT(2083,948),USE(?String39:4),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('veidlapu izlietojumu'),AT(3073,1125),USE(?String39:3),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1635,1302,4375,208),USE(PERIODS_TEXT),TRN,CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('no'),AT(6219,2948,521,156),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('lîdz'),AT(7000,2948,521,156),USE(?String10:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(' skaits'),AT(4375,2885,833,156),USE(?String10:21),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2083,2094,4375,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S13),AT(2083,1875,1302,208),USE(GL:VID_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maksâtâja reìistrâcijas kods'),AT(156,1896),USE(?String30:2),TRN
         STRING('Juridiskâs personas nosaukums'),AT(156,2115),USE(?String30),TRN
         LINE,AT(104,2635,0,573),USE(?Line2:23),COLOR(COLOR:Black)
         STRING('Juridiskâ adrese'),AT(156,2323),USE(?String30JA),TRN
         STRING(@s45),AT(2094,2302,4375,208),USE(GL:adrese),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2625,7604,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,2781,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Komplektu '),AT(4375,2729,833,156),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,2635,0,573),USE(?Line2:231),COLOR(COLOR:Black)
         STRING('Numuri'),AT(6250,2677,1302,156),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,2635,0,573),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5260,2635,0,573),USE(?Line2:232),COLOR(COLOR:Black)
         LINE,AT(6094,2635,0,573),USE(?Line2:233),COLOR(COLOR:Black)
         LINE,AT(469,2635,0,573),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6104,2896,1615,0),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,2906,0,300),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(104,3146,7604,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Sçrija'),AT(5406,2781,573,208),USE(?String10:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
HEADA4 DETAIL,AT(,,,2458),USE(?unnamed)
         STRING('3.pielikums Ministru kabineta'),AT(6083,10),USE(?String301:2A),TRN,RIGHT
         STRING(@s1),AT(2656,10,271,333),USE(E,,?E:2),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(2948,104,3000,156),USE(EE,,?EE:2),TRN,LEFT
         STRING('2005.gada 27. decembra'),AT(6240,135),USE(?String303a),TRN,RIGHT
         STRING('noteikumiem Nr. 1038'),AT(6427,260),USE(?String304A),TRN,RIGHT
         STRING(@s30),AT(1313,667,2604,208),USE(GL:VID_NOS),TRN,RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskats par pavadzîmju numuru izlietojumu'),AT(2333,375),USE(?String39:4a),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmuma dienesta teritoriâlâ iestâde'),AT(3969,688),USE(?String30:3a),TRN
         STRING(@s80),AT(448,1552,6885,208),USE(PERIODS_TEXT,,?PERIODS_TEXT:2),TRN,CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('no'),AT(5469,2219,521,156),USE(?String10:8A),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('lîdz'),AT(6250,2219,521,156),USE(?String10:2A),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(6917,2135,729,156),USE(?String10:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2833,1094,4375,208),USE(CLIENT,,?CLIENT:A),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S13),AT(2833,875,1302,208),USE(GL:VID_NR,,?GL:VID_NR:A),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maksâtâja reìistrâcijas kods'),AT(906,896),USE(?String30:3),TRN
         STRING('Nodokïu maksâtâja nosaukums'),AT(906,1115),USE(?String30A),TRN
         LINE,AT(104,1885,0,573),USE(?Line2:23A),COLOR(COLOR:Black)
         STRING('Juridiskâ adrese'),AT(906,1323),USE(?String30JA:2),TRN
         STRING(@s45),AT(2844,1302,4375,208),USE(GL:adrese,,?GL:ADRESE:A),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1875,7604,0),USE(?Line1A),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,2104,313,156),USE(?String10A),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,1885,0,573),USE(?Line2:231A),COLOR(COLOR:Black)
         STRING('Numuri'),AT(5427,1927,1302,156),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,1885,0,573),USE(?Line2:22A),COLOR(COLOR:Black)
         LINE,AT(5260,1885,0,573),USE(?Line2:232A),COLOR(COLOR:Black)
         LINE,AT(6823,1885,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(469,1885,0,573),USE(?Line2:7A),COLOR(COLOR:Black)
         LINE,AT(5260,2146,1570,0),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6094,2156,0,300),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(104,2406,7604,0),USE(?Line1:2A),COLOR(COLOR:Black)
         STRING('Sçrija'),AT(4500,2104,573,156),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detailA4 DETAIL,AT(,,,156),USE(?unnamed:4)
         LINE,AT(469,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@N_4),AT(7063,10,417,156),USE(skaits,,?skaits:2),RIGHT(1)
         STRING(@N06B),AT(5427,10,521,156),USE(I:NRNO),TRN,RIGHT
         STRING(@s30),AT(521,10,3000,156),USE(ASIAA_TEXT,,?ASIAA_TEXT:2),TRN
         STRING(@S5),AT(4573,10,469,156),USE(I:serija),TRN,CENTER
         LINE,AT(6094,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N06B),AT(6177,10,521,156),USE(I:NRLIDZ,,?I:NRLIDZ:2),RIGHT
         LINE,AT(5260,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@S2),AT(135,10,313,156),USE(RPT_NPK,,?RPT_NPK:2),CENTER
       END
detail DETAIL,AT(,,,156)
         LINE,AT(469,-10,0,198),USE(?Line2:6N),COLOR(COLOR:Black)
         STRING(@N_4),AT(4552,10,417,156),USE(skaits),RIGHT(1)
         STRING(@N06B),AT(6156,10,521,156),USE(I:NRNO,,?I:NRNO:N),TRN,RIGHT
         STRING(@s30),AT(521,10,3000,156),USE(ASIAA_TEXT,,?ASIAA_TEXT:2N),TRN
         STRING(@S5),AT(5510,10,469,156),USE(I:serija,,?I:SERIJA:N),TRN,LEFT
         LINE,AT(6094,-10,0,198),USE(?Line2:4N),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2:33N),COLOR(COLOR:Black)
         STRING(@N06B),AT(6990,10,521,156),USE(I:NRLIDZ),RIGHT
         LINE,AT(5260,-10,0,198),USE(?Line2:17N),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2:21N),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:11N),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:5N),COLOR(COLOR:Black)
         STRING(@S2),AT(135,10,313,156),USE(RPT_NPK,,?RPT_NPK:2N),CENTER
       END
detailSkaits DETAIL,AT(,,,156),USE(?unnamed:5)
         LINE,AT(7708,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@S2),AT(135,10,313,156),USE(RPT_NPK,,?RPT_NPK:1),TRN,CENTER
         LINE,AT(469,-10,0,198),USE(?Line2P:2),COLOR(COLOR:Black)
         STRING(@s30),AT(521,10,3000,156),USE(ASIAA_TEXT,,?ASIAA_TEXT:1),TRN
         LINE,AT(6094,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('X'),AT(6375,10,208,156),USE(?X4),TRN,LEFT
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(3573,10,573,156),USE(?String10:13),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_4),AT(4552,10,417,156),USE(skaitsK),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('X'),AT(7240,10,208,156),USE(?X5),TRN,LEFT
         STRING('X'),AT(5615,10,208,156),USE(?X:3),TRN,LEFT
       END
detailSumma DETAIL,AT(,,,156),USE(?unnamed:3)
         LINE,AT(469,-10,0,198),USE(?Line2P:6),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2P:33),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line2P:17),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2P:21),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2P:11),COLOR(COLOR:Black)
         STRING('Izlietotajâs pavadzîmes-rçíina veidlapâs norâdîto darîjumu kopsumma'),AT(521,10,3698,156), |
             USE(?SUMMA_PK_TEXT),TRN
         STRING('4.'),AT(135,10,313,156),USE(?RPT_NPK4),TRN,CENTER
         STRING('X'),AT(5615,10,208,156),USE(?X),TRN,LEFT
         STRING('X'),AT(6375,10,208,156),USE(?X1),TRN,LEFT
         LINE,AT(6094,-10,0,198),USE(?Line2:41),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(4406,10,729,156),USE(SUMMAK),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('X'),AT(7240,10,208,156),USE(?X2),TRN,LEFT
         LINE,AT(104,-10,0,198),USE(?Line2P:5),COLOR(COLOR:Black)
       END
FOOT   DETAIL,AT(,-10,,1500),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(188,83,521,156),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(688,83,552,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1354,83,208,156),USE(?String38),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1563,83,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(6625,83),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(7229,83),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         STRING('Atbildîgâ persona _{32}'),AT(365,802,2969,208),USE(?String36:2),TRN
         STRING(@s20),AT(3333,802,1302,208),USE(SYS:PARAKSTS1),TRN,LEFT
         STRING(@s15),AT(4896,802,1302,208),USE(SYS:TEL),TRN,LEFT
         STRING('(Paraksts un tâ atðifrçjums)'),AT(1667,958,1510,208),USE(?String36:3),TRN
         STRING('(tâlruòa numurs)'),AT(4927,958,885,208),USE(?String36:4),TRN
         STRING(@s25),AT(365,1167,1510,208),USE(dok_dat),TRN
         LINE,AT(104,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(469,0,0,63),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,63),USE(?Line312),COLOR(COLOR:Black)
         LINE,AT(104,52,7604,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,63),USE(?Line323:2),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line323),COLOR(COLOR:Black)
       END
FOOTA4 DETAIL,AT(,-10,,2104),USE(?unnamed:7)
         STRING('Sastâdîja :'),AT(115,83,521,146),USE(?String36A),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(594,83,552,146),USE(ACC_kods,,?ACC_KODS:A),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1365,83,208,146),USE(?String38A),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1563,83),USE(RS,,?RS:A),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.B),AT(6583,73),USE(DAT,,?DAT:A),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(7208,73),USE(LAI,,?LAI:A),FONT(,7,,,CHARSET:BALTIC)
         STRING('(Nodokïu maksâtâja paraksts)'),AT(4844,1115,1510,208),USE(?String36:6),TRN,CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING('_{56}'),AT(3802,969,3594,208),USE(?String36:5),TRN
         STRING(@s15),AT(5021,1583,1188,208),USE(SYS:TEL,,?SYS:TEL:2),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('(Vârds,Uzvârds un amats)'),AT(4844,1406,1510,208),USE(?Stringvut),TRN,CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING('(tâlruòa numurs)'),AT(5125,1729,990,208),USE(?String36:7),TRN,CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s25),AT(135,323,1510,208),USE(dok_dat,,?dok_dat:2),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(3875,1271,3385,208),USE(VUTA),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,0,0,63),USE(?Line34A),COLOR(COLOR:Black)
         LINE,AT(469,0,0,63),USE(?Line32:3A),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,63),USE(?Line32:2A),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,63),USE(?Line32A),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,63),USE(?Line312A),COLOR(COLOR:Black)
         LINE,AT(104,52,7604,0),USE(?Line1:3A),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,63),USE(?Line323:2A),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line323A),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(104,,7604,0),USE(?SingleLine),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

Window WINDOW('Ievadiet sâkuma datus'),AT(,,220,130),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       STRING('Anulçtie VID pieðíirtie P/Z numuri'),AT(72,9,123,10),USE(?StringANR),HIDE,CENTER
       STRING('Sçrija'),AT(82,18),USE(?String1)
       STRING('Numuri no        lîdz'),AT(117,18),USE(?String16)
       BUTTON('Atlikums'),AT(39,27,35,12),USE(?Button1)
       ENTRY(@s5),AT(77,28,27,10),USE(SERIJA[1],,?SERIJA1),UPR
       ENTRY(@N06B),AT(109,28,42,10),USE(NRNO[1],,?NRNO1)
       ENTRY(@N06B),AT(155,28,42,10),USE(NRLIDZ[1],,?NRLIDZ1)
       BUTTON('Atlikums'),AT(39,39,35,12),USE(?Button2)
       ENTRY(@s5),AT(77,40,27,10),USE(SERIJA[2],,?SERIJA2),UPR
       ENTRY(@N06B),AT(109,40,42,10),USE(NRNO[2],,?NRNO2)
       ENTRY(@N06B),AT(155,40,42,10),USE(NRLIDZ[2],,?NRLIDZ2)
       BUTTON('Saòemts'),AT(39,65,35,12),USE(?Button4)
       ENTRY(@s5),AT(77,53,27,10),USE(SERIJA[3],,?SERIJA3),UPR
       ENTRY(@N06B),AT(109,53,42,10),USE(NRNO[3],,?NRNO3)
       ENTRY(@N06B),AT(155,53,42,10),USE(NRLIDZ[3],,?NRLIDZ3)
       BUTTON('Saòemts'),AT(39,52,35,12),USE(?Button3)
       ENTRY(@s5),AT(77,66,27,10),USE(SERIJA[4],,?SERIJA4),UPR
       ENTRY(@N06B),AT(109,66,42,10),USE(NRNO[4],,?NRNO4)
       ENTRY(@N06B),AT(155,66,42,10),USE(NRLIDZ[4],,?NRLIDZ4)
       BUTTON('Notîrît'),AT(39,78,35,12),USE(?Button5)
       STRING('Anulçts'),AT(13,80),USE(?StringB5)
       STRING('Anulçts'),AT(13,91),USE(?StringB6)
       ENTRY(@s5),AT(77,79,27,10),USE(SERIJA[5],,?SERIJA5),UPR
       ENTRY(@N06B),AT(109,79,42,10),USE(NRNO[5],,?NRNO5)
       ENTRY(@N06B),AT(156,79,42,10),USE(NRLIDZ[5],,?NRLIDZ5)
       BUTTON('Notîrît'),AT(39,91,35,12),USE(?Button6)
       ENTRY(@s5),AT(77,92,27,10),USE(SERIJA[6],,?SERIJA6),UPR
       ENTRY(@N06B),AT(109,92,42,10),USE(NRNO[6],,?NRNO6)
       ENTRY(@N06B),AT(156,92,42,10),USE(NRLIDZ[6],,?NRLIDZ6)
       BUTTON('&OK'),AT(176,108,35,14),USE(?Ok),DEFAULT
       BUTTON('&Atlikt'),AT(136,108,36,14),USE(?Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  BIND('DIVI',DIVI)
  VUTA= CLIP(SYS:PARAKSTS1)&','&SYS:AMATS1
  DAT = TODAY()
  LAI = CLOCK()

  IF F:IDP='S' !SUP
     E='E'
     EE='(Pârskats... sup_ppr_izlietojums.duf)'
     PERIODS_TEXT='par '&format(YEAR(S_DAT),@n_4)&'.gada '&CLIP(DAY(S_DAT))&'.'&CLIP(MENVAR(S_DAT,2,3))&'-'&CLIP(DAY(B_DAT))&'.'&CLIP(MENVAR(B_DAT,2,3))
     num_no  ='num_no'
     num_lidz='num_lidz'
     STARTJ#=5
     FF[1]='A'
     FF[2]='A'
     FF[3]='S'
     FF[4]='S'
     FF[5]='X'
     FF[6]='X'
  ELSE         !VID MR
     E='E'
     EE='(Darîj.att.d./pârskats... PN_izlietojums.duf)'
     PERIODS_TEXT ='Pârskata periods: no '&format(YEAR(S_DAT),@n_4)&'.gada '&CLIP(DAY(S_DAT))&'.'&CLIP(MENVAR(S_DAT,2,4))&|
     ' lîdz '&format(YEAR(B_DAT),@n_4)&'.gada '&CLIP(DAY(B_DAT))&'.'&CLIP(MENVAR(B_DAT,2,5))
     num_no  ='numurs_no'
     num_lidz='numurs_lidz'
     STARTJ#=1
     FF[1]='X'
     FF[2]='X'
     FF[3]='X'
     FF[4]='X'
     FF[5]='X'
     FF[6]='X'
  .
  dok_dat=format(YEAR(TODAY()),@n_4)&'.gada '&CLIP(DAY(TODAY()))&'.'&CLIP(MENVAR(TODAY(),2,2))

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::USED += 1

  BIND(GG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GG)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pârskats par P/Z izlietojumu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GG,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      DIVI=2
      CLEAR(GG:RECORD)
      GG:DATUMS=S_DAT    !DESC.KEY
      SET(GG:DAT_KEY,GG:DAT_KEY)
      Process:View{Prop:Filter} ='GG:ATT_DOK=DIVI'  !TIKAI P/Z
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
          IF F:IDP='S'
             PRINT(RPT:HEADSUP)
           ELSE
             PRINT(RPT:HEADA4)
           .
      ELSE !WORD,EXCEL
          IF ~OPENANSI('PZIZPARSK.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='Pârskats '&CHR(9)&format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&CHR(9)&'Komplektu skaits'&CHR(9)&'Sçrija'&'Nr no'&CHR(9)&'Nr lîdz'
          ADD(OUTFILEANSI)
      .
      IF F:XML 
        IF F:IDP='S' ! STINGRÂS UZSKAITES
           XMLFILENAME=USERFOLDER&'\SUP_PPR_IZLIETOJUMS.DUF'
        ELSE
           XMLFILENAME=USERFOLDER&'\PN_IZLIETOJUMS.DUF'
        .
!      STOP('XML:'&XMLFILENAME)
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
           ADD(OUTFILEXML)
           IF F:IDP='S' ! STINGRÂS UZSKAITES
              XML:LINE='<<DeclarationFile type="sup_ppr">'
              ADD(OUTFILEXML)
              XML:LINE='<<Declaration>'
              ADD(OUTFILEXML)
              XML:LINE='<<DeclarationHeader>'
              ADD(OUTFILEXML)
              TEX:DUF=CLIENT
              DO CONVERT_TEX:DUF
              XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
              ADD(OUTFILEXML)
              IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
              XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="gads" value="'&CLIP(YEAR(B_DAT))&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="menesis" value="'&FORMAT(MONTH(B_DAT),@N02)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="datums_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods').
              XML:LINE='<<Field name="datums_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
              ADD(OUTFILEXML) !SUP HEDERIM BÛS VÇL...
           ELSE  !VID NR
              XML:LINE='<<DeclarationFile type="sup_ppi">'
              ADD(OUTFILEXML)
              XML:LINE='<<Declaration>'
              ADD(OUTFILEXML)
              XML:LINE='<<DeclarationHeader>'
              ADD(OUTFILEXML)
              TEX:DUF=CLIENT
              DO CONVERT_TEX:DUF
              XML:LINE='<<Field name="nosaukums" value="'&CLIP(TEX:DUF)&'" />'
              ADD(OUTFILEXML)
              IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
              XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="amats" value="'&CLIP(SYS:AMATS1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="datums_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods').
              XML:LINE='<<Field name="datums_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              TEX:DUF=GL:ADRESE
              DO CONVERT_TEX:DUF
              XML:LINE='<<Field name="adrese" value="'&CLIP(TEX:DUF)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="telef" value="'&CLIP(SYS:tel)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="sast_dat" value="'&FORMAT(TODAY(),@D06.)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<</DeclarationHeader>'
              ADD(OUTFILEXML)
           .
        .
    .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(GG:U_NR=1) AND ~INRANGE(GG:PAR_NR,26,50) AND GG:RS='' AND INRANGE(GG:DATUMS,S_DAT,B_DAT) !SALDO un RAÞOÐANU un ~A IGNORÇJAM
           IF (F:IDP='S' AND INSTRING('-',GG:DOK_SENR)) OR| !SUP
           (F:IDP='A' AND ~INSTRING('-',GG:DOK_SENR))       !A4
              FOUND#=FALSE
              SKAITS=0
              CLEAR(GGK:RECORD)
              GGK:U_NR=GG:U_NR
              SET(GGK:NR_KEY,GGK:NR_KEY)
              LOOP
                 NEXT(GGK)
                 IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
                 IF ~(GGK:D_K='D') THEN CYCLE.
                 IF K(GGK:BKK,'231') OR |  !IZEJOÐÂ P/Z
                    K(GGK:BKK,'521') OR |  !IZEJOÐÂ P/Z, JA PRIEKÐAPMAKSA
                    K(GGK:BKK,'561') OR |  !IZEJOÐÂ P/Z UZ ALGU
                    K(GGK:BKK,'261') OR |  !IZEJOÐÂ P/Z UZ KASI ULDIS-22/10/05
                    K(GGK:BKK,'262') OR |  !IZEJOÐÂ P/Z UZ BANKU ULDIS-22/10/05
                    K(GGK:BKK,'238') OR |  !IZEJOÐÂ P/Z UZ AVANSIERI
                    K(GGK:BKK,'871')       !IZEJOÐÂ P/Z UZ PEÏNAS IZLIETOJUMU
                    FOUND#=TRUE
                    BREAK
                 .
              .
              IF FOUND#=TRUE
                 P:DOK_SENR=GG:DOK_SENR
                 P:SUMMA_P =GGK:SUMMA
                 P:DOK_SE  =GETDOK_SENR(1,GG:DOK_SENR,,GG:ATT_DOK)
                 P:DOK_NR  =GETDOK_SENR(2,GG:DOK_SENR,,GG:ATT_DOK)
                 ADD(P_TABLE)
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
  IF SEND(GG,'QUICKSCAN=off').
  CLOSE(ProgressWindow)
  IF LocalResponse = RequestCompleted
    IF RECORDS(P_TABLE)   !Atrastâs PZ periodâ
        JAUNSPPRBLOKS=TRUE
        FIRSTDETAIL#=TRUE
        SORT(P_TABLE,P:DOK_SENR)
        GET(P_TABLE,0)
        LOOP I#=1 TO RECORDS(P_TABLE)
           GET(P_TABLE,I#)
           DO INITIALIZE_SE_NR
           SUMMAK  += P:SUMMA_P
           IF ~(C_DOK_SE=P:DOK_SE AND C_DOK_NR=P:DOK_NR) !JAUNA PAKA VAI PA VIDU KAS IZLAISTS(ANULÇTS)
              DO BUILD_I_TABLE
              JAUNSPPRBLOKS=TRUE
              DO INITIALIZE_SE_NR
           .
        .
        DO INITIALIZE_SE_NR
        DO BUILD_I_TABLE
    ELSE
        KLUDA(88,'neviena K pavadzîme...')
        IF F:IDP='S' !SUP
           SERIJA[1]=SYS:PZ_SERIJA
           NRNO[1]  =SYS:PZ_NR+1
           NRLIDZ[1]=SYS:CEKA_NR
        .
    .
!**************************SAN/ATL/ANU SUP, ANU VIDNR LOGS
    IF RECORDS(I_TABLE)
       OPEN(WINDOW)
       IF F:IDP='A' !Vid Nr
          UNHIDE(?StringANR)
          ?BUTTON1{PROP:TEXT}='Notîrît'
          ?BUTTON2{PROP:TEXT}='Notîrît'
          ?BUTTON3{PROP:TEXT}='Notîrît'
          ?BUTTON4{PROP:TEXT}='Notîrît'
          HIDE(?stringB5,?stringB6)
       .
       DISPLAY
       ACCEPT
          CASE FIELD()
          OF ?BUTTON1
             IF EVENT()=EVENT:ACCEPTED
                IF F:IDP='S' !SUP
                   IF FF[1]='A'
                      FF[1]='S'
                      ?BUTTON1{PROP:TEXT}='Saòemts'
                   ELSE
                      FF[1]='A'
                      ?BUTTON1{PROP:TEXT}='Atlikums'
                   .
                ELSE !VID NR
                   SERIJA[1]=''
                   NRNO[1]  =0
                   NRLIDZ[1]=0
                .
             .
          OF ?BUTTON2
             IF EVENT()=EVENT:ACCEPTED
                IF F:IDP='S' !SUP
                   IF FF[2]='A'
                      FF[2]='S'
                      ?BUTTON2{PROP:TEXT}='Saòemts'
                   ELSE
                      FF[2]='A'
                      ?BUTTON2{PROP:TEXT}='Atlikums'
                   .
                ELSE !VID NR
                   SERIJA[2]=''
                   NRNO[2]  =0
                   NRLIDZ[2]=0
                .
             .
          OF ?BUTTON3
             IF EVENT()=EVENT:ACCEPTED
                IF F:IDP='S' !SUP
                   IF FF[3]='S'
                      FF[3]='A'
                      ?BUTTON3{PROP:TEXT}='Atlikums'
                   ELSE
                      FF[3]='S'
                      ?BUTTON3{PROP:TEXT}='Saòemts'
                   .
                ELSE !VID NR
                   SERIJA[3]=''
                   NRNO[3]  =0
                   NRLIDZ[3]=0
                .
             .
          OF ?BUTTON4
             IF EVENT()=EVENT:ACCEPTED
                IF F:IDP='S' !SUP
                   IF FF[4]='S'
                      FF[4]='A'
                      ?BUTTON4{PROP:TEXT}='Atlikums'
                   ELSE
                      FF[4]='S'
                      ?BUTTON4{PROP:TEXT}='Saòemts'
                   .
                ELSE !VID NR
                   SERIJA[4]=''
                   NRNO[4]  =0
                   NRLIDZ[4]=0
                .
             .
          OF ?Button5
             IF EVENT()=EVENT:ACCEPTED
                SERIJA[5]=''
                NRNO[5]  =0
                NRLIDZ[5]=0
             .
          OF ?Button6
             IF EVENT()=EVENT:ACCEPTED
                SERIJA[6]=''
                NRNO[6]  =0
                NRLIDZ[6]=0
             .
          OF ?OK
             LOCALRESPONSE=REQUESTCOMPLETED
             BREAK
          OF ?CANCEL
             LOCALRESPONSE=REQUESTCANCELLED
             BREAK
          .
          DISPLAY
       .
       CLOSE(WINDOW)
       IF LOCALRESPONSE=REQUESTCANCELLED
          DO PROCEDURERETURN
       .
       LOOP I#= 1 TO 6
          IF SERIJA[I#]
             I:F     =FF[I#]
             I:SERIJA=SERIJA[I#]
             I:NRNO  =NRNO[I#]
             I:NRLIDZ=NRLIDZ[I#]
             ADD(I_TABLE)
          .
       .
       SORT(I_TABLE,I:SERIJA)

       IF F:XML_OK#=TRUE
          GET(I_TABLE,0)
          LOOP I#=1 TO RECORDS(I_TABLE)
             GET(I_TABLE,I#)
             IF I:F='A' AND I:SERIJA
                SKAITS=I:NRLIDZ-I:NRNO+1
                SKAITSXML[1]+=SKAITS
             ELSIF I:F='S' AND I:SERIJA
                SKAITS=I:NRLIDZ-I:NRNO+1
                SKAITSXML[2]+=SKAITS
             ELSIF I:F='I' AND I:SERIJA  !IZLIETOTS
                SKAITS=I:NRLIDZ-I:NRNO+1
                SKAITSXML[3]+=SKAITS
                LOOP J#= 1 TO 4  !AIZPILDAM GALA ATLIKUMUS
                   IF SERIJA[J#]=I:SERIJA
                      NRNO[J#]  =I:NRLIDZ+1
                   .
                .
             ELSIF I:F='X' AND I:SERIJA
!                IF SERIJA[J#]=I:SERIJA AND I:NRNO<=I:NRLIDZ
                IF SERIJA[I#]=I:SERIJA AND I:NRNO<=I:NRLIDZ
                   SKAITS=I:NRLIDZ-I:NRNO+1
                   SKAITSXML[4]+=SKAITS   !ANULÇTS KOPÂâ
                .
             .
          .
          LOOP J#= 1 TO 4
             IF NRNO[J#]<=NRLIDZ[J#] AND SERIJA[J#]
                SKAITS=NRLIDZ[J#]-NRNO[J#]+1
                SKAITSXML[5]+=SKAITS      !ATLIKUMS KOPÂ
             .
          .
          IF F:IDP='S' ! STINGRÂS UZSKAITES
             XML:LINE='<<Field name="kopa_sak" value="'&CLIP(SKAITSXML[1])&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopa_pirkt" value="'&CLIP(SKAITSXML[2])&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopa_izliet" value="'&CLIP(SKAITSXML[3])&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopa_anul" value="'&CLIP(SKAITSXML[4])&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopa_beig" value="'&CLIP(SKAITSXML[5])&'" />'
             ADD(OUTFILEXML)
             TEX:DUF=GL:ADRESE
             DO CONVERT_TEX:DUF
             XML:LINE='<<Field name="adrese" value="'&CLIP(TEX:DUF)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="telefons" value="'&CLIP(SYS:tel)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopsum_izlietots" value="'&CUT0(SUMMAK,2,2,1,1)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="kopsum_anulets" value="'&CUT0(SUMMAAK,2,2,1,1)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<<Field name="sast_dat" value="'&FORMAT(TODAY(),@D06.)&'" />'
             ADD(OUTFILEXML)
             XML:LINE='<</DeclarationHeader>'
             ADD(OUTFILEXML)
          .
       .
       IF F:DBF='W' !WMF
!*******************Atlikums SUP
          IF F:IDP='S' !SUP
              RPT_NPK='1.'
              ASIAA_TEXT='Atlikums uz perioda sâkumu'
              IF F:XML_OK#=TRUE
                 XML:LINE='<<Row>'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="rinda" value="1" />'
                 ADD(OUTFILEXML)
              .
              GET(I_TABLE,0)
              LOOP I#=1 TO RECORDS(I_TABLE)
                 GET(I_TABLE,I#)
                 IF I:F='A' AND I:SERIJA
                    SKAITS=I:NRLIDZ-I:NRNO+1
                    SKAITSK+=SKAITS
                    PRINT(RPT:DETAIL)
                    RPT_NPK=''
                    ASIAA_TEXT=''
                    IF F:XML_OK#=TRUE
                       XML:LINE='<<Row>'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="sup_skaits" value="'&CLIP(SKAITS)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="serija" value="'&CLIP(I:SERIJA)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_no" value="'&CLIP(I:NRNO)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_lidz" value="'&CLIP(I:NRLIDZ)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<</Row>'
                       ADD(OUTFILEXML)
                    .
                 .
              .
              IF F:XML_OK#=TRUE
                 XML:LINE='<</Row>'
                 ADD(OUTFILEXML)
              .
              PRINT(RPT:detailSkaits)
              PRINT(RPT:LINE)
!*******************Saòemts SUP
              IF F:XML_OK#=TRUE
                 XML:LINE='<<Row>'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="rinda" value="2" />'
                 ADD(OUTFILEXML)
              .
              RPT_NPK='2.'
              ASIAA_TEXT='Saòemts'
              SKAITSK=0
              GET(I_TABLE,0)
              LOOP I#=1 TO RECORDS(I_TABLE)
                 GET(I_TABLE,I#)
                 IF I:F='S' AND I:SERIJA !Saòemts SUP
                    SKAITS=I:NRLIDZ-I:NRNO+1
                    SKAITSK+=SKAITS
                    PRINT(RPT:DETAIL)
                    RPT_NPK=''
                    ASIAA_TEXT=''
                    IF F:XML_OK#=TRUE
                       XML:LINE='<<Row>'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="sup_skaits" value="'&CLIP(SKAITS)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="serija" value="'&CLIP(I:SERIJA)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_no" value="'&CLIP(I:NRNO)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_lidz" value="'&CLIP(I:NRLIDZ)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<</Row>'
                       ADD(OUTFILEXML)
                    .
                 .
              .
              IF F:XML_OK#=TRUE
                 XML:LINE='<</Row>'
              .
              ADD(OUTFILEXML)
              PRINT(RPT:detailSkaits)
              PRINT(RPT:LINE)
          .
!**********BEIDZAS Atlikums,SAÒEMTS SUP
!*******************Izlietots SUP/A4
          IF F:IDP='S'
              RPT_NPK='3.'
          ELSE
              RPT_NPK='1.'
          .
          IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="rinda" value="'&RPT_NPK[1]&'" />'
              ADD(OUTFILEXML)
          .
          ASIAA_TEXT='Izlietots'
          SKAITSK=0
          GET(I_TABLE,0)
          LOOP I#=1 TO RECORDS(I_TABLE)
              GET(I_TABLE,I#)
              IF I:F='I' AND I:SERIJA
                 SKAITS=I:NRLIDZ-I:NRNO+1
                 SKAITSK+=SKAITS
                 IF F:IDP='S' !SUP
                    PRINT(RPT:DETAIL)
                 ELSE
                    PRINT(RPT:DETAILA4)
                 .
                 RPT_NPK=''
                 ASIAA_TEXT=''
                 IF F:XML_OK#=TRUE
                    XML:LINE='<<Row>'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="sup_skaits" value="'&CLIP(SKAITS)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="serija" value="'&CLIP(I:SERIJA)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="'&CLIP(num_no)&'" value="'&CLIP(I:NRNO)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="'&CLIP(num_lidz)&'" value="'&CLIP(I:NRLIDZ)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<</Row>'
                    ADD(OUTFILEXML)
                 .
                 LOOP J#= 1 TO 4  !AIZPILDAM GALA ATLIKUMUS SUP
                    IF SERIJA[J#]=I:SERIJA
                       NRNO[J#]  =I:NRLIDZ+1
                    .
                 .
              .
          .
          IF F:XML_OK#=TRUE
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
          .
          IF F:IDP='S'
              PRINT(RPT:detailSkaits)
              PRINT(RPT:detailSumma)
          .
          PRINT(RPT:LINE)

!*******************Anulçts SUP/A4
           IF F:IDP='S'
              RPT_NPK='5.'   !3.-ai vçl klât 4-summa
           ELSE
              RPT_NPK='2.'
           .
           IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="rinda" value="'&RPT_NPK[1]&'" />'
              ADD(OUTFILEXML)
           .

           ASIAA_TEXT='Anulçts'
           SKAITSK=0
           GET(I_TABLE,0)
           LOOP I#=1 TO RECORDS(I_TABLE)
              GET(I_TABLE,I#)
              IF I:F='X' AND I:SERIJA
                 SKAITS=I:NRLIDZ-I:NRNO+1
                 SKAITSK+=SKAITS
                 IF F:IDP='S'
                    PRINT(RPT:DETAIL)
                 ELSE
                    PRINT(RPT:DETAILA4)
                 .
                 RPT_NPK=''
                 ASIAA_TEXT=''
                 IF F:XML_OK#=TRUE
                    XML:LINE='<<Row>'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="sup_skaits" value="'&CLIP(SKAITS)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="serija" value="'&CLIP(I:SERIJA)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="'&CLIP(num_no)&'" value="'&CLIP(I:NRNO)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<<Field name="'&CLIP(num_lidz)&'" value="'&CLIP(I:NRLIDZ)&'" />'
                    ADD(OUTFILEXML)
                    XML:LINE='<</Row>'
                    ADD(OUTFILEXML)
                 .
              .
           .
           IF F:XML_OK#=TRUE
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
           .
           IF F:IDP='S'
              PRINT(RPT:detailSkaits)
              PRINT(RPT:LINE)
           .
!**********BEIDZAS Izlietots,Anulçts SUP/A4
!*******************Atlikums SUP
           IF F:IDP='S'
              IF F:XML_OK#=TRUE
                 XML:LINE='<<Row>'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="rinda" value="5" />'
                 ADD(OUTFILEXML)
              .
              RPT_NPK='7.'
              ASIAA_TEXT='Atlikums perioda beigâs'
              SKAITSK=0
              FREE(I_TABLE)
              LOOP J#= 1 TO 4  
                 IF NRNO[J#]<=NRLIDZ[J#]
                    I:SERIJA=SERIJA[J#]
                    I:NRNO  =NRNO[J#]
                    I:NRLIDZ=NRLIDZ[J#]
                    ADD(I_TABLE)
                 .
              .
              SORT(I_TABLE,I:SERIJA)
              GET(I_TABLE,0)
              LOOP I#=1 TO RECORDS(I_TABLE)
                 GET(I_TABLE,I#)
                 IF I:SERIJA
                    SKAITS=I:NRLIDZ-I:NRNO+1
                    SKAITSK+=SKAITS
                    PRINT(RPT:DETAIL)
                    RPT_NPK=''
                    ASIAA_TEXT=''
                    IF F:XML_OK#=TRUE
                       XML:LINE='<<Row>'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="sup_skaits" value="'&CLIP(SKAITS)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="serija" value="'&CLIP(I:SERIJA)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_no" value="'&CLIP(I:NRNO)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<<Field name="num_lidz" value="'&CLIP(I:NRLIDZ)&'" />'
                       ADD(OUTFILEXML)
                       XML:LINE='<</Row>'
                       ADD(OUTFILEXML)
                    .
                 .
              .
              IF F:XML_OK#=TRUE
                 XML:LINE='<</Row>'
                 ADD(OUTFILEXML)
              .
              PRINT(RPT:detailSkaits)
           .
!*************BEIDZAS Alikums SUP
           IF F:IDP='S'
              PRINT(RPT:FOOT)
           ELSE
              PRINT(RPT:FOOTA4)
           .
           IF F:XML_OK#=TRUE
              XML:LINE='<</Declaration>'
              ADD(OUTFILEXML)
              XML:LINE='<</DeclarationFile>'
              ADD(OUTFILEXML)
              CLOSE(OUTFILEXML)
           .
           ENDPAGE(report)
       ELSE !Word,EXCEL ?
           RPT_NPK='1.'
           ASIAA_TEXT='Atlikums uz perioda sâkumu'
           OUTA:LINE=RPT_NPK&CHR(9)&CLIP(ASIAA_TEXT)&CHR(9)&FORMAT(SKAITS,@N_5)&CHR(9)&I:SERIJA&CHR(9)&FORMAT(I:NRNO,@N_6)&CHR(9)&FORMAT(I:NRLIDZ,@N_6)
           ADD(OUTFILEANSI)
           RPT_NPK='2.'
           ASIAA_TEXT='Saòemts'
           OUTA:LINE=RPT_NPK&CHR(9)&CLIP(ASIAA_TEXT)&CHR(9)&FORMAT(SKAITS,@N_5)&CHR(9)&I:SERIJA&CHR(9)&FORMAT(I:NRNO,@N_6)&CHR(9)&FORMAT(I:NRLIDZ,@N_6)
           ADD(OUTFILEANSI)
           OUTA:LINE=RPT_NPK&CHR(9)&CLIP(ASIAA_TEXT)&CHR(9)&FORMAT(SKAITS,@N_5)&CHR(9)&I:SERIJA&CHR(9)&FORMAT(I:NRNO,@N_6)&CHR(9)&FORMAT(I:NRLIDZ,@N_6)
           ADD(OUTFILEANSI)
       .
    .
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
  ELSE           !W,EXCEL
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
    GGK::USED -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  FREE(P_TABLE)
  FREE(I_TABLE)
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
! stop(format(GG:DATUMS,@d06.)&' '&format(S_DAT,@d06.))
  IF ERRORCODE() OR GG:DATUMS>B_DAT   !desc dat_key
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
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

!-----------------------------------------------------------------------------
INITIALIZE_SE_NR  ROUTINE
     IF JAUNSPPRBLOKS=TRUE
        C_DOK_SE=P:DOK_SE
        C_DOK_NR=P:DOK_NR
        I:NRNO=C_DOK_NR
        I:SERIJA=C_DOK_SE
        JAUNSPPRBLOKS=FALSE
     ELSE
        C_DOK_NR+=1
     .

!-----------------------------------------------------------------------------
BUILD_I_TABLE ROUTINE
     I:NRLIDZ=C_DOK_NR-1
     I:F='I'
     ADD(I_TABLE)
     IF F:IDP='S' !SUP
        LOOP J#= 1 TO 4  !AIZPILDAM SÂKUMA ATLIKUMUS UN SAÒEMTOS PRIEKÐ EKRÂNA
           IF ~SERIJA[J#] OR SERIJA[J#]=I:SERIJA
              SERIJA[J#]=I:SERIJA
              IF ~NRNO[J#] THEN NRNO[J#]=I:NRNO.
              IF SYS:PZ_SERIJA=SERIJA[J#] AND SYS:CEKA_NR > I:NRLIDZ
                 NRLIDZ[J#]=SYS:CEKA_NR
              ELSE
                 NRLIDZ[J#]=I:NRLIDZ
              .
              BREAK
           .
        .
        IF J#>4
           KLUDA(0,'Nevar apstrâdât vairâk par 4 PPR pakâm')
        .
     .
     IF C_DOK_SE=P:DOK_SE AND ~(I#>RECORDS(P_TABLE)) !NÂKOÐAM BLOKAM TÂ PATI SÇRIJA, BET CITI NR UN NAV PÇDÇJAIS IERAKSTS
        LOOP J#= STARTJ# TO 6  !AIZPILDAM ANULÇTOS PRIEKÐ EKRÂNA
           IF ~SERIJA[J#] OR SERIJA[J#]=I:SERIJA
              IF I:NRLIDZ+1 <= P:DOK_NR-1
                 NRLIDZ[J#]=P:DOK_NR-1
                 SERIJA[J#]=I:SERIJA
                 NRNO[J#]  =I:NRLIDZ+1
                 NRLIDZ[J#]=P:DOK_NR-1
                 BREAK
              ELSE
                 KLUDA(0,'PPR Numuru pârklâjums '&P:DOK_SENR)
              .
           .
        .
     .
     NPK#+=1
     ?Progress:UserString{Prop:Text}=NPK#
     DISPLAY(  ?Progress:UserString)

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
