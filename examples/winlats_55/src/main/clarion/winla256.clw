                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_PERSKART           PROCEDURE                    ! Declare Procedure
NODALA_TEXT          STRING(50)
AMATS_TEXT           STRING(25)

VIRSRAKSTS           STRING(30)
VIRSRAKSTS1          STRING(50)
DATUMS               LONG
DOK_NR               STRING(8)
ZINAS                STRING(100)
ZINA                 STRING(100),DIM(4)
VUT                  STRING(30)
KAD_DARBA_GR         LIKE(KAD:DARBA_GR)
RPT_KAD_DARBA_GR     LONG
KAD_LIG_PRO_NR       STRING(8)
PK                   STRING(25)
DZIM                 STRING(5)
IZGLITIBA            STRING(25)
DAT                  LONG


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
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END

!---------------------------------------------------------------------------

report REPORT,AT(100,200,8000,10896),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,PAGEBEFORE(-1),AT(,,,3208),USE(?unnamed:4)
         STRING(@s45),AT(781,208,3385,208),USE(client),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Juridiskâ adrese:'),AT(63,396,1510,208),USE(?String2:2),TRN,RIGHT
         STRING(@s45),AT(1667,396,2969,208),USE(gl:adrese),TRN,LEFT(1)
         STRING(@s25),AT(2385,625),USE(PK),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, Uzvârds:'),AT(365,927,990,177),USE(?String7:2)
         STRING(@s30),AT(2542,938,2656,208),USE(VUT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods:'),AT(365,1146,750,177),USE(?String7:7)
         STRING(@p######-#####p),AT(3417,1146),USE(kad:perskod),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Dzimums:'),AT(365,1354,448,177),USE(?String7:5),TRN
         STRING(@s5),AT(2094,1333,417,208),USE(DZIM),TRN,LEFT
         STRING('Dzimðanas vieta, pilsonîba:'),AT(365,1594,1458,156),USE(?String7:8),TRN
         STRING(@s30),AT(2094,1583,1354,177),USE(KAD:DZV_PILS),TRN,LEFT
         STRING('Apgâdâjamo skaits:'),AT(365,1813,1146,177),USE(?String7:9),TRN
         STRING(@n2),AT(2094,1823,208,208),USE(KAD:APGAD_SK),TRN,LEFT
         STRING(@s50),AT(2094,2021,2656,177),USE(NODALA_TEXT,,?NODALA_TEXT:3),TRN,LEFT
         STRING('Nodaïa, struktûrvienîba:'),AT(365,2031,1302,156),USE(?String7:3),TRN
         STRING('Ieòemamais amats:'),AT(365,2240,1094,156),USE(?String7:10),TRN
         STRING(@s25),AT(2094,2229,1667,177),USE(AMATS_TEXT),TRN,LEFT
         STRING('Personu apliecinoðs dokuments:'),AT(365,2438,1615,177),USE(?String7:17)
         STRING(@s60),AT(2094,2427,3854,208),USE(KAD:PASE),TRN,LEFT
         STRING('Derîgs lîdz:'),AT(365,2625,625,156),USE(?String7:11)
         STRING(@D06.B),AT(2094,2615,729,177),USE(KAD:PASE_END),TRN,LEFT
         STRING('Dzîvesvietas adrese:'),AT(365,2823,1031,177),USE(?String7:12),TRN
         STRING(@s60),AT(2094,2833,4427,177),USE(KAD:PIERADR),TRN,LEFT
         STRING('Izglîtîba:'),AT(365,3021),USE(?String7:13),TRN
         STRING(@s25),AT(2094,3021,1667,177),USE(IZGLITIBA),TRN,LEFT
       END
HEADER DETAIL,AT(,,,417),USE(?ZINAS:3)
         STRING(@s30),AT(198,21,2083,156),USE(VIRSRAKSTS),TRN,LEFT
         LINE,AT(156,198,0,228),USE(?Line258),COLOR(COLOR:Black)
         LINE,AT(813,198,0,228),USE(?Line259),COLOR(COLOR:Black)
         LINE,AT(1354,208,0,228),USE(?Line620),COLOR(COLOR:Black)
         STRING(@s50),AT(2031,240,3333,156),USE(VIRSRAKSTS1),TRN,LEFT
         LINE,AT(156,198,7708,0),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(302,240,417,156),USE(?DATUMS),TRN,RIGHT
         STRING('Dok.'),AT(833,240,469,156),USE(?DOK_NR),TRN,CENTER
         LINE,AT(7865,198,0,228),USE(?Line262),COLOR(COLOR:Black)
         LINE,AT(156,406,7708,0),USE(?Line6:3),COLOR(COLOR:Black)
       END
ZINAS  DETAIL,AT(,-10,,167),USE(?ZINAS:1)
         LINE,AT(156,-10,0,170),USE(?Line58),COLOR(COLOR:Black)
         STRING(@D06.B),AT(177,10,615,160),USE(DATUMS,,?DATUMS:2),CENTER
         LINE,AT(813,0,0,170),USE(?Line59),COLOR(COLOR:Black)
         STRING(@S8),AT(823,10,521,156),USE(DOK_NR,,?DOK_NR:2),CENTER
         LINE,AT(1354,0,0,170),USE(?Line60),COLOR(COLOR:Black)
         STRING(@s100),AT(1406,10,6406,156),USE(ZINAS),LEFT
         LINE,AT(7865,-10,0,170),USE(?Line62),COLOR(COLOR:Black)
       END
ZINAS_END DETAIL,AT(,-10,,104),USE(?unnamed:7)
         LINE,AT(156,52,7708,0),USE(?Line66:3),COLOR(COLOR:Black)
         LINE,AT(156,0,0,52),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(813,0,0,52),USE(?Line63:2),COLOR(COLOR:Black)
         LINE,AT(1354,0,0,52),USE(?Line63:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line63:4),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,490),USE(?FOOTER)
         STRING('Aizpildîja :'),AT(167,229),USE(?aizpildija),TRN
         STRING(@s25),AT(1094,250),USE(sys:amats1),TRN,RIGHT
         STRING('_{30}'),AT(2771,302),USE(?String48),TRN
         STRING(@D06.B),AT(6344,250,729,177),USE(DAT),TRN,LEFT
         STRING(@s25),AT(4667,250),USE(sys:PARAKSTS1),TRN,LEFT
       END
       FOOTER,AT(100,11100,8000,10),USE(?unnamed:3)
         LINE,AT(156,0,7708,0),USE(?Line6:5),COLOR(COLOR:Black)
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
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  DAT=TODAY()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Personas kartîte'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KAD:RECORD)
      KAD:NODALA=F:NODALA
      SET(KAD:NOD_KEY,KAD:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(kad:NODALA=F:NODALA)) and ~(id AND ~(kad:id=id))'
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
         IF ~(KAD:STATUSS='7' AND F:IDP) !ARHÎVS UN IGNORÇT A
            PK='PERSONAS KARTÎTE N '&CLIP(KAD:ID)
            VUT = GETKADRI(KAD:ID,0,1)
            IF KAD:NODALA THEN NODALA_TEXT=KAD:NODALA&' '&GetNodalas(KAD:nodala,1).
            IF KAD:AMATS THEN AMATS_TEXT=KAD:AMATS.
            IF KAD:DZIM='S' THEN DZIM='Siev.' ELSE DZIM='Vîr.'.
            EXECUTE INSTRING(KAD:IZGLITIBA,'NPVRKA',1,1)
               IZGLITIBA=''
               IZGLITIBA='Pamata'
               IZGLITIBA='Vidçjâ'
               IZGLITIBA='Arodskolas'
               IZGLITIBA='Koledþa'
               IZGLITIBA='Augstâkâ'
            .
            SETTARGET(REPORT)
            IMAGE(5800,280,2000,2500,DOCFOLDERK&'\'&FORMAT(KAD:ID,@N04)&'-K.JPG')  !X/Y=80/100
            PRINT(rpt:CEPURE)
            LOOP I#= 1 TO 5
               EXECUTE I#
                  VIRSRAKSTS='Ziòas par bçrniem'
                  VIRSRAKSTS='Mâcîbu iestâdes un kursi'
                  VIRSRAKSTS='Iecelðana un pârcelðana'
                  VIRSRAKSTS='Atvaïinâjumi'
                  VIRSRAKSTS='Citi rîkojumi'
               .
               EXECUTE I#
                  VIRSRAKSTS1='Vârds Uzvârds, Piezîmes'
                  VIRSRAKSTS1='Mâcîbu iestâdes nosaukums, iegûtâ specialitâte'
                  VIRSRAKSTS1='Iecelðana un pârcelðana'
                  VIRSRAKSTS1='Par kâdu periodu, sâkuma, beigu datums'
                  VIRSRAKSTS1='Rîkojuma saturs'
               .
               PRINT(RPT:HEADER)
               IF I#=3 !PIEÒEMTS
                  DATUMS=KAD:DAR_DAT
                  DOK_NR=KAD:DAR_LIG
                  LOOP J#=1 TO 4
                     ZINA[J#]=FILL_ZINA(KAD:Z_KODS,J#,KAD:DARBA_GR)
                  .
                  ZinaS=ZINA[1]
                  PRINT(RPT:ZINAS)
                  DATUMS=0
                  DOK_NR=''
                  IF ZINA[2]
                     ZinaS=ZINA[2]
                     PRINT(RPT:ZINAS)
                  .
                  IF ZINA[3]
                     ZinaS=ZINA[3]
                     PRINT(RPT:ZINAS)
                  .
                  IF ZINA[4]
                     ZinaS=ZINA[4]
                     PRINT(RPT:ZINAS)
                  .
               .
               CLEAR(RIK:RECORD)
               RIK:ID = KAD:ID
               SET(RIK:ID_KEY,RIK:ID_KEY) !+ID,-DATUMS
               LOOP
                  PREVIOUS(KAD_RIK)
                  IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
                  EXECUTE I#
                     IF ~INSTRING(RIK:TIPS,'B') THEN CYCLE. ! ZIÒAS PAR BÇRNIEM
                     IF ~INSTRING(RIK:TIPS,'I') THEN CYCLE. ! IZGLÎTÎBA
                     IF ~INSTRING(RIK:TIPS,'K') THEN CYCLE. ! KADRI
                     IF ~INSTRING(RIK:TIPS,'A') THEN CYCLE. ! ATVAÏINÂJUMI
                     IF ~INSTRING(RIK:TIPS,'C') THEN CYCLE. ! CITI RÎKOJUMI
                  .
                  DATUMS=RIK:DATUMS
                  DOK_NR=RIK:DOK_NR
                  EXECUTE I#
                     ZinaS=CLIP(RIK:SATURS)&' dz. '&FORMAT(RIK:DATUMS1,@D06.)
                     ZinaS=CLIP(RIK:SATURS)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
                     ZinaS=RIK:SATURS
                     ZinaS=CLIP(RIK:SATURS)&' no '&FORMAT(RIK:DATUMS1,@D06.)&' lîdz '&FORMAT(RIK:DATUMS2,@D06.)
                     ZinaS=RIK:SATURS
                  .
                  PRINT(RPT:ZINAS)
                  DATUMS=0
                  DOK_NR=''
                  IF RIK:SATURS1
                     ZinaS=RIK:SATURS1
                     PRINT(RPT:ZINAS)
                  .
!                  IF RIK:SATURS2
!                     ZinaS=RIK:SATURS2
!                     PRINT(RPT:ZINAS)
!                  .
!                  IF RIK:SATURS3
!                     ZinaS=RIK:SATURS3
!                     PRINT(RPT:ZINAS)
!                  .
               .
               IF I#=3 AND KAD:Z_KODS_END !ATLAISTS
                  DATUMS=KAD:NEDAR_DAT
                  DOK_NR=KAD:NEDAR_LIG
                  LOOP J#=1 TO 4
                     ZINA[J#]=FILL_ZINA(KAD:Z_KODS_END,J#,KAD:D_GR_END)
                  .
                  ZinaS=ZINA[1]
                  PRINT(RPT:ZINAS)
                  DATUMS=0
                  DOK_NR=''
                  IF ZINA[2]
                     ZinaS=ZINA[2]
                     PRINT(RPT:ZINAS)
                  .
                  IF ZINA[3]
                     ZinaS=ZINA[3]
                     PRINT(RPT:ZINAS)
                  .
                  IF ZINA[4]
                     ZinaS=ZINA[4]
                     PRINT(RPT:ZINAS)
                  .
               .
               PRINT(RPT:ZINAS_END)
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     CLOSE(ProgressWindow)
     F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
     IF F:DBF='W'   !WMF
        PRINT(rpt:FOOTER)
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

SPZ_DefektacijasAkts PROCEDURE (OPC)              ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
KESKA                STRING(50)
AUT_AUTO             STRING(40)
AUT_VADITAJS         STRING(35)
DALAS_DARBI          STRING(50)
nom_NOSAUKUMS        STRING(50)
cena                 decimal(11,2)
summa1               decimal(11,2)
summaR               decimal(11,2)
summaRA              decimal(11,2)
summaRK              decimal(11,2)
summaD               decimal(11,2)
summaDA              decimal(11,2)
summaDK              decimal(11,2)
summaK               decimal(11,2)
VUT                  STRING(20)
!PLKST                TIME
RPT_NPK              BYTE
KOMATS               STRING(1)
!dat                  LONG
LAI                  LONG
MERV                 STRING(7)
LINE                 STRING(132)

OBJ_ADRESE           STRING(60)
NOM_SER              STRING(21)
NOMENKL              STRING(21)
RET                  BYTE
POLISE               STRING(50)
GL_ADRESE            STRING(80)

!-----------------------------------------------------------------------------
report REPORT,AT(146,198,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,2135),USE(?unnamed:5)
         STRING(@s45),AT(104,146,4063,208),USE(client),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,385,5885,0),USE(?Line83),COLOR(COLOR:Black)
         STRING(@s80),AT(104,469,5885,208),USE(GL_ADRESE),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(1531,1000,4375,208),USE(KESKA),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(1146,1625),USE(AUT:VIRSB_NR),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Apdroðinâðanas polises un lietas Nr'),AT(323,1906,2240,208),USE(?String73:2),TRN,LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING(@s50),AT(2604,1906,4948,208),USE(POLISE),TRN,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts Nr.'),AT(4115,1375,625,208),USE(?String73:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s12),AT(4927,1375),USE(AUT:V_NR),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(5969,1375),USE(AUT:V_NR2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Automaðîna '),AT(323,1375,781,208),USE(?String73:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s35),AT(1146,1375,2656,208),USE(AUT_AUTO),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Virsbûves Nr.'),AT(323,1625,781,208),USE(?String73:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
NOM_HEAD DETAIL,AT(,,,500),USE(?unnamed:3)
         STRING(@s50),AT(313,94,3646,156),USE(DALAS_DARBI),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,260,0,260),USE(?Line78:7),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(625,260,0,260),USE(?Line78:3),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?Line5:6),COLOR(COLOR:Black)
         STRING('Summa'),AT(7208,302,469,156),USE(?String47:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(281,292,313,156),USE(?String38:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(5688,302,365,156),USE(?String47:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvien.'),AT(6115,302,521,156),USE(?String47:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,260,0,260),USE(?Line78:5),COLOR(COLOR:Black)
         STRING('Cena'),AT(6688,302,417,156),USE(?String47:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(646,302,1354,156),USE(NOM_SER),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2052,302,3021,156),USE(?String47:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6635,260,0,260),USE(?Line78:51),COLOR(COLOR:Black)
         LINE,AT(7135,260,0,260),USE(?Line78:6),COLOR(COLOR:Black)
         LINE,AT(2031,260,0,260),USE(?Line78:4),COLOR(COLOR:Black)
         LINE,AT(5521,260,0,260),USE(?Line78:8),COLOR(COLOR:Black)
         LINE,AT(7865,260,0,260),USE(?Line78:61),COLOR(COLOR:Black)
       END
NOMEN  DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(260,-10,0,197),USE(?Line79:7),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line79:3),COLOR(COLOR:Black)
         STRING(@s21),AT(667,10,1354,156),USE(nomenkl)
         STRING(@s50),AT(2135,0,3333,156),USE(nom_Nosaukums)
         STRING(@n_6.2b),AT(5677,10,354,156),USE(nol:daudzums),RIGHT
         STRING(@n_7.2b),AT(6688,10,417,156),USE(cena),RIGHT
         STRING(@n_8.2b),AT(7229,0,521,156),USE(summa1),RIGHT
         LINE,AT(7135,-10,0,197),USE(?Line79:5),COLOR(COLOR:Black)
         STRING(@s3),AT(354,10,208,156),USE(RPT_npk,,?RPT_NPK:2),RIGHT
         LINE,AT(6635,-10,0,197),USE(?Line79:51),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,197),USE(?Line79:4),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line79:8),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line79:6),COLOR(COLOR:Black)
         STRING(@s7),AT(6135,10,469,156),USE(merv),LEFT
         LINE,AT(6094,-10,0,197),USE(?Line79:511),COLOR(COLOR:Black)
       END
NOM_FOOT:R DETAIL,AT(,-10,,271),USE(?unnamed)
         STRING('Rezerves daïas kopâ :'),AT(4010,83,1458,156),USE(?StringR47:8),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,83,521,156),USE(summaR),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,52,7604,0),USE(?LineR5:9),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,260),USE(?LineR5:23),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?LineR5:10),COLOR(COLOR:Black)
         LINE,AT(260,0,0,260),USE(?LineR5:11),COLOR(COLOR:Black)
         LINE,AT(625,0,0,260),USE(?LineR5:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,260),USE(?LineR5:121),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,260),USE(?LineR5:13),COLOR(COLOR:Black)
         LINE,AT(6635,0,0,260),USE(?LineR5:22),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,260),USE(?LineR5:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,260),USE(?LineR5:15),COLOR(COLOR:Black)
       END
NOM_FOOT:RK DETAIL,AT(,-10,,479),USE(?unnamed:8)
         STRING('Atlaide :'),AT(4740,104,729,156),USE(?StringR747:8),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,104,521,156),USE(summaRA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rezerves daïas kopâ ar atlaidi :'),AT(3594,260,1875,156),USE(?StringR47:10),RIGHT(1), |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,260,521,156),USE(summaRK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,0,0,469),USE(?LineR75:131),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?LineR5:16),COLOR(COLOR:Black)
         LINE,AT(260,0,0,469),USE(?LineR5:20),COLOR(COLOR:Black)
         LINE,AT(625,0,0,469),USE(?LineR75:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,469),USE(?LineR75:121),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,469),USE(?LineR75:13),COLOR(COLOR:Black)
         LINE,AT(6635,0,0,469),USE(?LineR75:931),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,469),USE(?LineR75:132),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,469),USE(?LineR75:15),COLOR(COLOR:Black)
       END
NOM_FOOT:D DETAIL,AT(,-10,,271),USE(?unnamed:4)
         STRING('Darba izmaksas kopâ :'),AT(4010,83,1458,156),USE(?StringD47:3),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,83,521,156),USE(summaD),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,52,7604,0),USE(?LineD5:9),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,260),USE(?LineD5:23),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?LineD5:10),COLOR(COLOR:Black)
         LINE,AT(260,0,0,260),USE(?LineD5:11),COLOR(COLOR:Black)
         LINE,AT(625,0,0,260),USE(?LineD5:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,260),USE(?LineD5:121),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,260),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(6635,0,0,260),USE(?LineD5:22),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,260),USE(?LineD5:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,260),USE(?LineD5:15),COLOR(COLOR:Black)
       END
NOM_FOOT:DK DETAIL,AT(,-10,,479),USE(?unnamed:6)
         STRING('Atlaide :'),AT(4740,104,729,156),USE(?StringD747:8),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,104,521,156),USE(summaDA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darba izmaksas kopâ ar atlaidi :'),AT(3594,260,1875,156),USE(?StringD47:2),RIGHT(1), |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,260,521,156),USE(summaDK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,0,0,469),USE(?LineD75:131),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?LineD5:16),COLOR(COLOR:Black)
         LINE,AT(260,0,0,469),USE(?LineD5:20),COLOR(COLOR:Black)
         LINE,AT(625,0,0,469),USE(?LineD75:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,469),USE(?LineD75:121),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,469),USE(?LineD75:13),COLOR(COLOR:Black)
         LINE,AT(6635,0,0,469),USE(?LineD75:931),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,469),USE(?LineD75:132),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,469),USE(?LineD75:15),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,-10,,698),USE(?unnamed:7)
         STRING('Rezerves daïas un darba izmaksas kopâ :'),AT(3073,83,2396,156),USE(?String47:7),RIGHT(1), |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(7219,83,521,156),USE(summak,,?summak:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vadîtâjs:'),AT(2438,479,469,208),USE(?String95:1)
         STRING(@t1),AT(7552,281,313,104),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING('Datums:'),AT(260,479,677,208),USE(?String249:5:1)
         STRING(@d06.),AT(1042,479,677,208),USE(PAV:DATUMS,,?PAV:DATUMS:3)
         LINE,AT(6094,0,0,260),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s35),AT(3042,479,2240,208),USE(aut_vaditajs)
         STRING('_{42}'),AT(5281,542),USE(?String51),TRN
         LINE,AT(260,0,0,260),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(625,0,0,260),USE(?Line5:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,260),USE(?Line5:121),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,260),USE(?LineF5:13),COLOR(COLOR:Black)
         LINE,AT(6635,0,0,260),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,260),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,260),USE(?Line5:15),COLOR(COLOR:Black)
       END
RPT_line DETAIL,AT(,,,0)
         LINE,AT(260,0,7604,0),USE(?Line5:8),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11354,8000,10),USE(?unnamed:9)
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
window WINDOW('Caption'),AT(,,260,100),GRAY
       END


POLISE:Window WINDOW('Apdroðinâðanas polises un lietas Nr:'),AT(,,273,38),FONT('MS Sans Serif',8,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       ENTRY(@s50),AT(11,5,249,10),USE(POLISE,,?POLISE:W)
       BUTTON('OK'),AT(226,18,35,14),USE(?Ok),DEFAULT
     END
  CODE                                            ! Begin processed code
!
!
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  OPEN(POLISE:WINDOW)
  DISPLAY
  ACCEPT
     IF FIELD()=?OK AND EVENT()=EVENT:ACCEPTED THEN BREAK.
  .
  CLOSE(POLISE:WINDOW)

  KESKA = 'DEFEKTÂCIJAS AKTS'
  GETMYBANK('')
  IF SYS:TEL THEN GL_ADRESE='tâlr. '&SYS:TEL.
  IF SYS:FAX THEN GL_ADRESE=CLIP(GL_ADRESE)&' fakss '&SYS:FAX.
  GL_ADRESE=CLIP(GL_ADRESE)&' '&CLIP(SYS:E_MAIL)&' '&GL:ADRESE
  OBJ_ADRESE=GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
!  DAT=TODAY()
  LAI=CLOCK()
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
  OF 'K'
    nom_ser='Kods'
    RET=4
  OF 'C'
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF AUTO::Used = 0
    CheckOpen(AUTO,1)
  END
  AUTO::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(AUT:RECORD)
  FilesOpened = True
  AUT_AUTO=GETAUTO(PAV:VED_NR,6)     !POZICIONÇJAM AUTO
  AUT_VADITAJS=GETAUTO(PAV:VED_NR,3)
  OPEN(PROGRESSWINDOW)
  OPEN(report)
  SETTARGET(REPORT)
  IMAGE(5700,100,2083,521,'USER.BMP')
  report{Prop:Preview} = PrintPreviewImage
  PRINT(RPT:HEADER)
!--------------------------------------------
  DALAS_DARBI='Rezerves daïas'
  PRINT(RPT:NOM_HEAD)
  RPT_NPK=0
  CLEAR(NOL:RECORD)
  NOL:U_NR=PAV:U_NR
  SET(NOL:NR_KEY,NOL:NR_KEY)
  LOOP
     NEXT(NOLIK)
     IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
     RINDAS#+=1
     RPT_NPK+=1
     nomenkL=GETNOM_K(NOL:NOMENKLAT,2,ret)
     NOM_NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
     IF ~(NOM:TIPS='A')  !~DARBI
        summa1=CALCSUM(10,2) !AR PVN Ls
        CENA=SUMMA1/NOL:DAUDZUMS
        summaR+=SUMMA1
        summaRA+=CALCSUM(7,2) !ATLAIDE AR PVN Ls
        VUT=''
        KOMATS=''
        MERV=NOM:MERVIEN
        PRINT(RPT:NOMEN)
     .
  .
  summaRK=summaR-summaRA
  PRINT(RPT:NOM_FOOT:R)
  PRINT(RPT:NOM_FOOT:RK)
!--------------------------------------------
  DALAS_DARBI='Darbi'
  PRINT(RPT:NOM_HEAD)
  RPT_NPK=0
  SUMMAK=0
  CLEAR(NOL:RECORD)
  NOL:U_NR=PAV:U_NR
  SET(NOL:NR_KEY,NOL:NR_KEY)
  LOOP
     NEXT(NOLIK)
     IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
     RINDAS#+=1
     RPT_NPK+=1
     I#=GETNOM_K(NOL:NOMENKLAT,2,2)
     IF NOM:TIPS='A'  !DARBI
        nomenkL=GETNOM_K(NOL:NOMENKLAT,2,ret)
        summa1=CALCSUM(10,2)
        CENA=SUMMA1/NOL:DAUDZUMS
        summaD+=SUMMA1
        summaDA+=CALCSUM(7,2) !ATLAIDE AR PVN Ls
        MERV=NOM:MERVIEN
        VUT=''
        KOMATS=''
        IF VUT
           NOM_NOSAUKUMS=CLIP(VUT)&'-'&GETNOM_K(NOL:NOMENKLAT,2,2)
        ELSE
           NOM_NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
        .
        PRINT(RPT:NOMEN)
     .
  .
  summaDK=summaD-summaDA
  PRINT(RPT:NOM_FOOT:D)
  PRINT(RPT:NOM_FOOT:DK)
  SUMMAK=SUMMARK+SUMMADK
  PRINT(RPT:FOOTER)
  ENDPAGE(report)
  CLOSE(PROGRESSWINDOW)
  pr:skaits=0
  RP
  loop J#=1 to PR:SKAITS
     report{Prop:FlushPreview} = True
     IF ~(J#=PR:SKAITS)
        loop I#= 1 to RECORDS(PrintPreviewQueue1)
          GET(PrintPreviewQueue1,I#)
          PrintPreviewImage=PrintPreviewImage1
          add(PrintPreviewQueue)
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
  IF FilesOpened
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
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
FILL_ZINA            FUNCTION (Z_KODS,OPC,<Z_DATUMS>) ! Declare Procedure
ZINA     STRING(100),DIM(4)
TEXT     STRING(15)
  CODE                                            ! Begin processed code
   IF ~INRANGE(OPC,1,4)
      RETURN('')
   .
   IF Z_DATUMS
      TEXT=' no '&FORMAT(Z_DATUMS,@D06.)
   .
   CASE Z_KODS                                                                                                    !100COL
   OF 11
      ZINA[1]='Tâda darba òçmçja statusa iegûðana, kurð ir apdroðinâms atbilstoði visiem valsts sociâlâs          '
      ZINA[2]='apdroðinâðanas veidiem'&TEXT
   OF 12
      ZINA[1]='Tâda darba òçmçja statusa iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðanai, invaliditâtes  '
      ZINA[2]='apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai, vecâku apdroðinâðanai un sociâlajai '
      ZINA[3]='apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kurð ir izdienas'
      ZINA[4]='pensijas saòçmçjs vai invalîds - valsts speciâlâs pensijas saòçmçjs)'&TEXT
   OF 13
      ZINA[1]='Tâda darba òçmçja statusa iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðanai, maternitâtes un'
      ZINA[2]='slimîbas apdroðinâðanai,vecâku apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem'
      ZINA[3]='darbâ un arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod tiesîbas saòemt valsts '
      ZINA[4]='vecuma pensiju, un darba òçmçjam, kuram ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'&TEXT
   OF 14
      ZINA[1]='Tâda darba òçmçja statusa iegûðana, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'
      ZINA[2]='un ir pakïauts valsts pensiju apdroðinâðanai, invaliditâtes apdroðinâðanai un apdroðinâðanai pret'
      ZINA[3]='bezdarbu'&TEXT
   OF 15
      ZINA[1]='Tâda darba òçmçja statusa iegûðana, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'
      ZINA[2]='un ir pakïauts valsts pensiju apdroðinâðanai (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod '
      ZINA[3]='tiesîbas saòemt valsts vecuma pensiju, un darba òçmçjam, kuram ir pieðíirta valsts vecuma pensija'
      ZINA[4]='ar atvieglotiem noteikumiem)'&TEXT
   OF 16
      ZINA[1]='Tâda mikrouzòçmuma darbinieka statusa iegûðana, kurð ir apdroðinâms atbilstoði visiem valsts'
      ZINA[2]='sociâlâs apdroðinâðanas veidiem'&TEXT
   OF 17
      ZINA[1]='Tâda mikrouzòçmuma darbinieka statusa iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðanai,'
      ZINA[2]='invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai, vecâku apdroðinâðanai un'
      ZINA[3]='sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kurð ir'
      ZINA[4]='izdienas pensijas saòçmçjs vai invalîds - valsts speciâlâs pensijas saòçmçjs)'&TEXT
   OF 18
      ZINA[1]='Tâda mikrouzòçmuma darbinieka statusa iegûðana,kurð ir pakïauts valsts pensiju apdroð.,maternitâtes'
      ZINA[2]='un slimîbas apdroðinâðanai,vecâku apdroðinâðanai un sociâlajai apdroðinâð. pret nelaimes gadîjumiem'
      ZINA[3]='darbâ un arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod tiesîbas saòemt valsts '
      ZINA[4]='vecuma pensiju, un darba òçmçjam, kuram ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'&TEXT
   OF 21
      ZINA[1]='Darba òçmçja vai mikrouzòçmuma darbinieka statusa zaudçðana, pamatojoties uz darba òçmçja uzteikumu'&TEXT
   OF 22
      ZINA[1]='Darba òçmçja vai mikrouzòçmuma darbinieka statusa zaudçðana sakarâ ar darba òçmçja pârkâpumu'
      ZINA[2]='normatîvajos aktos, kuros noteikta personu atbrîvoðana no darba, noteiktajos gadîjumos'&TEXT
   OF 23
      ZINA[1]='Darba òçmçja vai mikrouzòçmuma darbinieka statusa zaudçðana sakarâ ar darba devçja  vai'
      ZINA[2]='mikrouzòçmuma nodokïa maksâtâja likvidâciju'&TEXT
   OF 24
      ZINA[1]='Darba òçmçja vai mikrouzòçmuma darbinieka statusa zaudçðana sakarâ ar nespçju veikt nolîgto darbu'
      ZINA[2]='veselîbas stâvokïa dçï'&TEXT
   OF 25
      ZINA[1]='Darba òçmçja vai mikrouzòçmuma darbinieka statusa zaudçðana citos gadîjumos'&TEXT
   OF 31
      ZINA[1]='Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir apdroðinâms visiem valsts'
      ZINA[2]='sociâlâs apdroðinâðanas veidiem (darba òçmçjam, kam ir pârtraukta izdienas pensijas vai valsts)'
      ZINA[3]='speciâlâs pensijas izmaksa)'&TEXT
   OF 32
      ZINA[1]='Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valsts pensiju apdroði-'
      ZINA[2]='nâðanai, invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai, vecâku apdroðinâðanai'
      ZINA[3]='un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kuram ir'
      ZINA[4]='pieðíirta izdienas pensija vai valsts speciâlâ pensija)'&TEXT
   OF 33
      ZINA[1]='Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valsts pensiju apdroði-'
      ZINA[2]='nâðanai, maternitâtes un slimîbas apdroðinâðanai, vecâku apdroðinâðanai un sociâlajai apdroðinâðanai'
      ZINA[3]='pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod'
      ZINA[4]='tiesîbas saòemt vecuma pensiju,un darba òçmçjam,kuram ir pieðíirta vecuma pensija ar atv. noteikumiem'&TEXT
   OF 34
      ZINA[1]='Darba òçmçja, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ,statusa maiòa-darba òçmçjs'
      ZINA[2]=', kurð ir pakïauts valsts pensiju apdroðinâðanai(darba òçmçjam, kurð ir sasniedzis vecumu, kas dod'
      ZINA[3]='tiesîbas saòemt vecuma pensiju,un darba òçmçjam,kuram ir pieðíirta vecuma pensija ar atvieglotiem'
      ZINA[4]='noteikumiem'&TEXT
   OF 35
      ZINA[1]='Mikrouzòçmuma darbinieka apdroðinâðanas statusa maiòa - mikrouzòçmuma darbinieka, kurð ir apdroðinâms'
      ZINA[2]='atbilstoði visiem valsts sociâlâs apdroðinâðanas veidiem (mikrouzòçmuma darbiniekam, kam ir pârtraukta'
      ZINA[3]=' izdienas pensijas vai valsts speciâlâs pensijas izmaksa)'&TEXT
   OF 36
      ZINA[1]='Mikrouzòçmuma darbinieka apdroðinâðanas statusa maiòa - mikrouzòçmuma darbinieks, kurð ir pakïauts'
      ZINA[2]='valsts pensiju apdroðinâðanai, invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai,'
      ZINA[3]='vecâku apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm'
      ZINA[4]='(mikrouzòçmuma darbiniekam, kuram ir pieðíirta izdienas pensija vai valsts speciâlâ pensija)'&TEXT  !100COL
   OF 37
      ZINA[1]='Mikrouzòçmuma darbinieka apdroðinâðanas statusa maiòa -mikr.u darbin.,kurð ir pakïauts valsts pensiju'
      ZINA[2]='apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai,vecâku apdroðinâðanai un un soc.apdroð. pret'
      ZINA[3]='nelaimes gadîjumiem darbâ un arodslimîbâm (mikr.u darbin.,kurð ir sasniedzis vecumu,kas dod tiesîbas'
      ZINA[4]='saòemt vecuma pensiju,un mikr.u darbiniekam,kuram ir pieðíirta vecuma pensija ar atvieglotiem not.'&TEXT
   OF 40
      ZINA[1]='Darba òçmçjam ir pieðíirts bçrna kopðanas atvaïinâjums'&TEXT
   OF 41
      ZINA[1]='Darba òçmçjam ir beidzies bçrna kopðanas atvaïinâjums'&TEXT
   OF 50
      ZINA[1]='Darba òçmçjam ir pieðíirts atvaïinâjums bez darba algas saglabâðanas'&TEXT
   OF 51
      ZINA[1]='Darba òçmçjam ir beidzies atvaïinâjums bez darba algas saglabâðanas'&TEXT
!   OF 51
!      ZINA[1]='Darba òçmçjs, kuram ir bçrns vecumâ lîdz trim gadiem, nodarbinâts nepilnu darba nedçïu (lîdz 20'
!     ZINA[2]='stundâm nedçïâ, ja bçrns ir vecumâ lîdz pusotram gadam, un lîdz 34 stundâm nedçïâ, ja bçrns ir'
!      ZINA[3]='vecumâ no pusotra lîdz trim gadiem)'
!   OF 52
!      ZINA[1]='Darba òçmçjs, kuram ir bçrns vecumâ lîdz trim gadiem, nodarbinâts pilnu darba nedçïu (vairâk par 20'
!      ZINA[2]='stundâm nedçïâ, ja bçrns ir vecumâ lîdz pusotram gadam, un vairâk par 34 stundâm nedçïâ, ja bçrns'
!      ZINA[3]='ir vecumâ no pusotra lîdz trim gadiem)'
   .
   RETURN(ZINA[OPC])

