                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_RIKOJUMI           PROCEDURE                    ! Declare Procedure
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
!NPK                  DECIMAL(3)
DAT                  LONG
LAI                  LONG
VIRSRAKSTS           STRING(70)
R_FAILS              LIKE(RIK:R_FAILS)
SATURS               STRING(120)
StringLIDZ           STRING(1)
RIK_TIPS             STRING(6)

!-----------------------------------------------------------------------------
Process:View         VIEW(KAD_RIK)
                       PROJECT(RIK:U_NR)
                       PROJECT(RIK:ID)
                       PROJECT(RIK:TIPS)
                       PROJECT(RIK:Z_KODS)
                       PROJECT(RIK:DATUMS)
                       PROJECT(RIK:DOK_NR)
                       PROJECT(RIK:DATUMS1)
                       PROJECT(RIK:DATUMS2)
                       PROJECT(RIK:SATURS)
                       PROJECT(RIK:SATURS1)
                       PROJECT(RIK:R_FAILS)
                       PROJECT(RIK:ACC_DATUMS)
                       PROJECT(RIK:ACC_KODS)
                     END

!-----------------------------------------------------------------------------------------------
report REPORT,AT(100,1375,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,396,8000,969),USE(?PAGEHEADER)
         STRING(@s45),AT(1698,52,4479,260),USE(CLIENT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(1292,333,5302,260),USE(virsraksts),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7063,490,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(188,677,7573,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(917,677,0,313),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(1583,677,0,313),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(3031,677,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(3333,677,0,313),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(4542,677,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(3750,677,0,313),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7760,677,0,313),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(198,938,7573,0),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nr'),AT(615,740,125,177),USE(?String33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1021,729,531,177),USE(?String33:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no - lîdz'),AT(1969,729,854,177),USE(?String33:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ZK'),AT(3063,729,240,177),USE(?String33:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ID'),AT(3385,729,302,177),USE(?String33:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Fails'),AT(3958,729,458,177),USE(?String33:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saturs'),AT(5208,729,625,177),USE(?String33:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('T'),AT(1656,729,63,177),USE(?String24),TRN,CENTER
         LINE,AT(188,677,0,313),USE(?Line3:7),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         STRING(@S10),AT(219,10,635,156),USE(RIK:DOK_NR),RIGHT(1)
         LINE,AT(917,,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@D06.),AT(958,10,604,156),USE(RIK:DATUMS),CENTER
         LINE,AT(1583,,0,198),USE(?Line13:3),COLOR(COLOR:Black)
         LINE,AT(3031,,0,198),USE(?Line13:31),COLOR(COLOR:Black)
         LINE,AT(3333,,0,198),USE(?Line13:32),COLOR(COLOR:Black)
         STRING(@N_5B),AT(3365,10,344,156),USE(RIK:ID),RIGHT
         LINE,AT(4542,,0,198),USE(?Line13:33),COLOR(COLOR:Black)
         STRING(@S120),AT(4583,10,3135,156),USE(SATURS),LEFT(1)
         STRING(@S12),AT(3771,10,750,156),USE(R_FAILS),TRN,RIGHT(2)
         STRING(@N2B),AT(3083,10,188,156),USE(RIK:Z_KODS),TRN,RIGHT(1)
         STRING(@s1),AT(1604,0,125,156),USE(RIK:TIPS),TRN,CENTER
         LINE,AT(3750,,0,198),USE(?Line13:34),COLOR(COLOR:Black)
         STRING(@D06.B),AT(1740,10,573,156),USE(RIK:DATUMS1),CENTER
         STRING(@s1),AT(2302,10,125,156),USE(StringLIDZ),TRN,CENTER
         STRING(@D06.B),AT(2427,10,573,156),USE(RIK:DATUMS2),CENTER
         LINE,AT(7760,,0,198),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(188,,0,198),USE(?Line13),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,448),USE(?unnamed:2)
         LINE,AT(188,,0,271),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1583,0,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,63),USE(?Line282:4),COLOR(COLOR:Black)
         LINE,AT(3750,0,0,63),USE(?Line282:2),COLOR(COLOR:Black)
         LINE,AT(3333,0,0,63),USE(?Line282:3),COLOR(COLOR:Black)
         LINE,AT(3031,,0,63),USE(?Line281),COLOR(COLOR:Black)
         LINE,AT(3927,-32646,0,63),USE(?Line282),COLOR(COLOR:Black)
         LINE,AT(7760,,0,271),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(198,63,7573,0),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(188,271,7573,0),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(917,0,0,63),USE(?Line284),COLOR(COLOR:Black)
         STRING(@D06.),AT(6594,292,625,156),USE(DAT),RIGHT(1),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7229,292,521,156),USE(LAI),RIGHT(12),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(198,10900,8000,10),USE(?unnamed:3)
         LINE,AT(198,260,7573,0),USE(?Line23:3),COLOR(COLOR:Black)
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

TIPSWindow WINDOW('Norâdiet dokumenta tipu'),AT(,,123,98),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC), |
         GRAY
       CHECK('Kadri'),AT(7,11),USE(RIK_TIPS[1]),VALUE('K','')
       CHECK('Atvaïinâjumi'),AT(7,21),USE(RIK_TIPS[2]),VALUE('A','')
       CHECK('Rîkojumi'),AT(7,32),USE(RIK_TIPS[3]),VALUE('C','')
       CHECK('Protokoli'),AT(7,42),USE(RIK_TIPS[3]),VALUE('P','')
       CHECK('Izglîtîbas dokumenti'),AT(7,53),USE(RIK_TIPS[4]),VALUE('I','')
       CHECK('Bçrnu dokumenti'),AT(7,64),USE(RIK_TIPS[5]),VALUE('B','')
       BUTTON('&OK'),AT(49,78,35,14),USE(?OKTIPS),DEFAULT
       BUTTON('&Atlikt'),AT(86,78,32,14),USE(?CancelTIPS)
       BUTTON('At&zîmçt visu'),AT(7,78,40,14),USE(?ButtonAtVi),DEFAULT
     END
  CODE                                            ! Begin processed code
!
!
!
  LocalResponse = RequestCancelled
  OPEN(TIPSWindow)
  RIK_TIPS='  C   '
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OKTIPS
        IF EVENT()=EVENT:ACCEPTED
           LocalResponse = RequestCompleted
           BREAK
        .
     OF ?CancelTIPS
        IF EVENT()=EVENT:ACCEPTED
           BREAK
        .
     OF ?ButtonAtVi
        IF EVENT()=EVENT:ACCEPTED
           RIK_TIPS='KACPIB'
           DISPLAY
        .
     .
  .
  CLOSE(TIPSWindow)
  IF LocalResponse = RequestCancelled THEN RETURN.

  F:DBF='W'   !WMF     PAGAIDÂM

  PUSHBIND

  DAT = TODAY()
  LAI = CLOCK()
!  NPK=0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
!  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  BIND('RIK_TIPS',RIK_TIPS) 
  BIND('F:NOA',F:NOA)

  FilesOpened = True
  RecordsToProcess = RECORDS(KAD_RIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Rîkojumi un Dokumenti'
  IF RIK_TIPS='KACPIB'
     VIRSRAKSTS='Visi dokumenti'
  ELSIF RIK_TIPS='K    '
     VIRSRAKSTS='Pavçles kadriem'
  ELSIF RIK_TIPS=' A   '
     VIRSRAKSTS='Atvaïinâjumi'
  ELSIF RIK_TIPS='  C  '
     VIRSRAKSTS='Rîkojumu saraksts '
  ELSIF RIK_TIPS='   P  '
     VIRSRAKSTS='Protokolu saraksts '
  ELSIF RIK_TIPS='    I '
     VIRSRAKSTS='Izglîtîbas dokumenti'
  ELSIF RIK_TIPS='     B'
     VIRSRAKSTS='Bçrnu dokumenti'
  ELSIF RIK_TIPS='KAC  '
     VIRSRAKSTS='Pavçles un rîkojumi'
  ELSE
     VIRSRAKSTS='Rîkojumi un dokumenti'
  .
  VIRSRAKSTS=CLIP(VIRSRAKSTS)&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  IF ID
     VIRSRAKSTS=CLIP(VIRSRAKSTS)&' '&GETKADRI(ID,0,1)
  .
  VIRSRAKSTS=CLIP(VIRSRAKSTS)&' Tips='&RIK_TIPS
  IF F:NOA
     VIRSRAKSTS=CLIP(VIRSRAKSTS)&' Nepersonalizçtie'
  .
  ?Progress:UserString{Prop:Text}=''
  SEND(PERNOS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(rik:record)
!      per:pazime=F:DTK
      RIK:DATUMS=S_DAT
      SET(RIK:dat_key,RIK:dat_key)
!      Process:View{Prop:Filter} = '~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
      Process:View{Prop:Filter} = '~(ID AND ~(RIK:ID=ID)) AND ~(F:NOA AND RIK:ID) AND INSTRING(RIK:TIPS,RIK_TIPS,1)'
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
      SETTARGET(REPORT,?PAGEHEADER)
      IMAGE(188,1,2083,521,'USER.BMP')
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF RIK:DATUMS2
           StringLIDZ='-'
        ELSE
           StringLIDZ=''
        .
        IF OPENANSI(RIK:R_FAILS,3)
           IF BYTES(OUTFILEANSI)
              R_FAILS=RIK:R_FAILS
           ELSE
              R_FAILS=''
           .
           CLOSE(OUTFILEANSI)
        .
        IF ~ID AND RIK:ID !NAV PIEPRASÎTS TIKAI 1
           SATURS=CLIP(GETKADRI(RIK:ID,0,1))&' '&CLIP(RIK:SATURS)&' '&RIK:SATURS1
        ELSE
           SATURS=CLIP(RIK:SATURS)&' '&RIK:SATURS1
        .
        PRINT(RPT:detail)
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
!  IF ERRORCODE() !OR ~(F:DTK=per:pazime)
  IF ERRORCODE() OR RIK:DATUMS > B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
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
P_NORLIN             PROCEDURE                    ! Declare Procedure
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

STRINGAGDM           STRING(100)
CP                   STRING(10)
KAT_NR               STRING(3)
DATUMS               LONG
VERT_S               DECIMAL(12,2)
VERT_B               DECIMAL(12,2)
NULL_DATUMS          LONG
SKAITS_SK            DECIMAL(4)
SKAITS_K             DECIMAL(4)
VERT_SK              DECIMAL(12,2)
VERT_BK              DECIMAL(12,2)
DAT                  LONG
LAI                  LONG
AKTS_NR              USHORT
KOM1                 STRING(30)
KOM2                 STRING(30)
KOM3                 STRING(30)

N_TABLE             QUEUE,PRE(N)
BKK                    STRING(5)
BKKN                   STRING(5)
VERT_S                 DECIMAL(12,2)
VERT_B                 DECIMAL(12,2)
                    .

!-----------------------------------------------------------------------------
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:ACC_DATUMS)
                       PROJECT(PAM:ACC_KODS)
                       PROJECT(PAM:ATB_NOS)
                       PROJECT(PAM:ATB_NR)
                       PROJECT(PAM:BIL_V)
                       PROJECT(PAM:BKK)
                       PROJECT(PAM:BKKN)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:DOK_SENR)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:EXPL_DATUMS)
                       PROJECT(PAM:OBJ_NR)
                       PROJECT(PAM:IEP_V)
                       PROJECT(PAM:IZG_GAD)
                       PROJECT(PAM:KAP_V)
                       PROJECT(PAM:LIN_G_PR)
                       PROJECT(PAM:NERAZ)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:NOS_A)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOS_S)
                       PROJECT(PAM:OKK7)
                       PROJECT(PAM:SKAITS)
                       PROJECT(PAM:U_NR)
                     END

report REPORT,AT(50,1500,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(50,300,8000,1198),USE(?unnamed)
         STRING(@s45),AT(1521,52,4896,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7260,500,625,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         STRING(''),AT(2375,271),USE(?String29),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(219,250,7500,208),USE(StringAGDM),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4885,938,2198,0),USE(?unnamed:3),COLOR(COLOR:Black)
         STRING('Skaits'),AT(4896,979,344,208),USE(?String36:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(5365,979,573,208),USE(?String36:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(6052,979,354,208),USE(?String36:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.Vçrt.'),AT(6438,979,615,208),USE(?String36:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gads'),AT(4531,969,271,208),USE(?String36:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietoð.dat.'),AT(7125,969,781,208),USE(?String36:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1188,7781,0),USE(?unnamed:5),COLOR(COLOR:Black)
         LINE,AT(7083,688,0,573),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(6417,938,0,313),USE(?Line6:8),COLOR(COLOR:Black)
         LINE,AT(5250,938,0,313),USE(?Line6:6),COLOR(COLOR:Black)
         LINE,AT(156,677,0,573),COLOR(COLOR:Black)
         STRING('Numurs'),AT(250,969,552,208),USE(?String36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kat.'),AT(906,792,313,208),USE(?String36:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1729,760,1396,208),USE(?String36:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ekspl. nod.'),AT(3823,781,677,208),USE(?String36:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pilnîgas'),AT(7208,781),USE(?String39),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Uzskaites '),AT(240,781,625,208),USE(?String36:15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izl. '),AT(4531,781,271,208),USE(?String36:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdâts'),AT(5104,719,719,208),USE(?String36:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(6094,719,948,208),USE(?String36:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7927,677,0,573),USE(?Line6:10),COLOR(COLOR:Black)
         LINE,AT(6031,677,0,573),USE(?Line6:7),COLOR(COLOR:Black)
         LINE,AT(4875,667,0,573),USE(?Line6:5),COLOR(COLOR:Black)
         LINE,AT(4500,677,0,573),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('datums'),AT(3854,969,573,208),USE(?String36:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3802,677,0,573),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(1240,677,0,573),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(844,677,0,573),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(156,677,7781,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,177),USE(?unnamed:4)
         STRING(@n_9),AT(198,10,604,156),USE(PAM:U_NR),RIGHT
         LINE,AT(7927,-10,0,198),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,198),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(6417,-10,0,198),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6031,-10,0,198),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(5250,-10,0,198),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(4875,-10,0,198),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(4500,-10,0,198),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(3802,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(1240,0,0,198),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(844,-10,0,198),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line16),COLOR(COLOR:Black)
         STRING(@n_10.2),AT(6458,10,604,156),USE(VERT_B),RIGHT(1)
         STRING(@D06.B),AT(7198,21,625,156),USE(NULL_DATUMS),TRN,RIGHT(1)
         STRING(@n4),AT(4896,10,313,156),USE(PAM:SKAITS),TRN,RIGHT(12)
         STRING(@n4),AT(4531,10,313,156),USE(PAM:IZG_GAD),RIGHT(1)
         STRING(@D06.),AT(3833,10,625,156),USE(PAM:EXPL_DATUMS),RIGHT(1)
         STRING(@s40),AT(1271,10,2521,156),USE(PAM:NOS_P),LEFT
         STRING(@p#-##p),AT(865,10,365,156),USE(KAT_NR),CENTER
         STRING(@n_12.2),AT(5281,10,729,156),USE(VERT_S),RIGHT(12)
         STRING(@n4),AT(6073,10,313,156),USE(AMO:SKAITS),RIGHT(12)
       END
detail1 DETAIL,AT(,-10,,2198),USE(?unnamed:2)
         STRING(@n4),AT(6063,104,313,156),USE(SKAITS_K),RIGHT(12)
         STRING(@N_4),AT(4906,94),USE(SKAITS_SK),TRN,RIGHT(12)
         LINE,AT(156,0,0,313),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(146,63,7781,0),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(4875,0,0,313),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(5250,0,0,313),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(6031,0,0,313),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(6417,0,0,313),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,313),USE(?Line34:7),COLOR(COLOR:Black)
         LINE,AT(7927,0,0,313),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(844,10,0,52),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(1240,10,0,52),USE(?Line30:34),COLOR(COLOR:Black)
         LINE,AT(3802,10,0,52),USE(?Line30:33),COLOR(COLOR:Black)
         LINE,AT(4500,10,0,52),USE(?Line30:35),COLOR(COLOR:Black)
         STRING(@n_10.2),AT(6448,94,604,156),USE(VERT_BK,,?VERT_BK:2),RIGHT(16)
         STRING('KOPÂ '),AT(365,104),USE(?String37),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,313,7781,0),USE(?Line29:2),COLOR(COLOR:Black)
         STRING('Sakarâ ar pilnîgu nolietoðanos un(vai) to, ka uzskaitîtos pamatlîdzekïus vairs n' &|
             'av iespçjams izmantot saimnieciskajâ darbîbâ, mçs, apakðâ parakstîjusies'),AT(177,427), |
             USE(?String40,CHARSET:BALTIC),TRN
         STRING('komisija, tos noòemam no uzskaites. Pçc savstarpçjas vienoðanâs minçtie pamatlîd' &|
             'zekïi tiek pârdoti _{44}'),AT(177,719),USE(?String42,CHARSET:BALTIC),TRN
         STRING('%_{23} minçto summu ieturçt no darba algas.'),AT(3042,1031),USE(?String44,CHARSET:BALTIC), |
             TRN
         STRING('par kopçjo summu _{21} ar PVN '),AT(177,1031,2740,177),USE(?String43,CHARSET:BALTIC), |
             TRN
         STRING(@N2),AT(2906,1031),USE(SYS:NOKL_PVN),TRN
         LINE,AT(1250,1646,5313,0),USE(?Line43),COLOR(COLOR:Black)
         STRING(@s30),AT(4646,1719),USE(KOM2),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1271,1896,5313,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING(@s30),AT(4646,1958),USE(KOM3),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1271,2135,5313,0),USE(?Line43:3),COLOR(COLOR:Black)
         STRING('Komisija :'),AT(208,1313),USE(?String41),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4646,1458),USE(KOM1),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_12.2),AT(5281,104,729,156),USE(VERT_SK),RIGHT
       END
detail2 DETAIL,AT(,,,156),USE(?unnamed:6)
         STRING(@N_12.2),AT(531,10,729,156),USE(N:VERT_S,,?N:VERT_S:3),RIGHT
         STRING(@S5),AT(1375,10,354,156),USE(N:BKKN),TRN,RIGHT
         STRING(@N_12.2),AT(1740,10,729,156),USE(N:VERT_S,,?N:VERT_S:2),TRN,RIGHT
         STRING('D'),AT(1281,10,104,156),USE(?String49:2),TRN,CENTER
         STRING('K'),AT(83,10,104,156),USE(?String49),TRN,CENTER
         STRING(@S5),AT(167,10,354,156),USE(N:BKK),TRN,RIGHT
       END
       FOOTER,AT(10,11160,8000,0)
         LINE,AT(156,0,7781,0),USE(?Line29:3),COLOR(COLOR:Black)
       END
     END

KOM  WINDOW('Komisijas sastâvs'),AT(,,173,91),CENTER,GRAY,DOUBLE
       STRING('Akts Nr :'),AT(53,9),USE(?String1)
       ENTRY(@N_4B),AT(81,8,27,10),USE(AKTS_NR,,?AKTS_NR:1)
       ENTRY(@s30),AT(11,27),USE(KOM1,,?KOM1:1)
       ENTRY(@s30),AT(11,41),USE(KOM2,,?KOM2:1)
       ENTRY(@s30),AT(11,54),USE(KOM3,,?KOM3:1)
       BUTTON('OK'),AT(131,70,33,15),USE(?OK)
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
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(PAM:RECORD)
  BIND('B_DAT',B_DAT)

  AKTS_NR =1
  KOM1    =SYS:PARAKSTS1
  KOM2    =SYS:PARAKSTS2
  KOM3    =GetPAR_K(PAR_NR,0,2)
  OPEN(KOM)
  DISPLAY
  ACCEPT
     DISPLAY
     CASE FIELD()
     OF ?OK
        CASE EVENT()
        OF EVENT:ACCEPTED
           BREAK
        .
     .
  .
  CLOSE(KOM)

  STRINGAGDM='Pamatlîdzekïu norakstîðanas AKTS Nr '&CLIP(AKTS_NR)&' '&CLIP(GADS)&'.g.'&CLIP(DAY(B_DAT))&'.'&|
  CLIP(MENVAR(B_DAT,2,2))
  CP='1'

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Norakstîðanas Akts'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAM:NR_KEY)
!      Process:View{Prop:Filter} = 'PAM:END_DATE=B_DAT'
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
          IF ~OPENANSI('P_NORLIN.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=STRINGAGDM
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Nr'&CHR(9)&'Kat.'&CHR(9)&'Nosaukums'&CHR(9)&'Ekspl. nod.'&CHR(9)&'Izl.'&CHR(9)&|
             CHR(9)&'Skaits'&CHR(9)&'Uzskaites'&CHR(9)&'Atlikusî'&CHR(9)&|
             'Pinîgas nolietoð.'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'datums'&CHR(9)&'gads'&CHR(9)&CHR(9)&CHR(9)&|
             'vçrtîba'&CHR(9)&'vçrtîba'&CHR(9)&'datums'
          ELSE
             OUTA:LINE='Nr'&CHR(9)&'Kat.'&CHR(9)&'Nosaukums'&CHR(9)&'Ekspl. nod. datums'&CHR(9)&'Izl. gads'&CHR(9)&|
             'Skaits'&CHR(9)&'Uzskaites vçrtîba'&CHR(9)&|
             'Atlikusî vçrtîba'&CHR(9)&'Pinîgas nolietoð. datums'
          .
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF PAM:END_DATE=B_DAT
           CLEAR(AMO:RECORD)
           AMO:YYYYMM=DATE(MONTH(B_DAT),1,YEAR(B_DAT))
           AMO:U_NR=PAM:U_NR
           VERT_S=0
           VERT_B=0
           GET(PAMAM,AMO:YYYYMM_KEY)
           IF ~ERROR() !Nav noòemts jau lîdz MM
              IF PAM:EXPL_DATUMS>=DATE(1,1,1995)
                 START_GD#=YEAR(PAM:EXPL_DATUMS)
              ELSE
                 START_GD#=1995
              .
              I#=0
              LOOP G#=START_GD# TO GADS
                I#+=1
              .
              IF ~CYCLEKAT(PAM:KAT[I#]) AND ~CYCLENODALA(AMO:NODALA)  !KAT VAR MAINÎTIES REIZI GADÂ,NODAÏA REIZI MÇNESÎ
   !           ~(F:NODALA AND ~(F:NODALA=AMO:NODALA)) !NODAÏA VAR MAINÎTIES KATRU MÇNESI
                  IF INRANGE(PAM:EXPL_DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),DATE(MONTH(B_DAT)+1,1,YEAR(B_DAT))-1) !IEGÂDÂTS MMÇN.,NAV SÂK.V.
                     VERT_S=PAM:BIL_V   +PAM:nol_v+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !SÂK.V. MM BEIGÂS
                  ELSE
                     VERT_S=AMO:SAK_V_LI+PAM:nol_v+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !+1994
                  .
                  IF ~INRANGE(PAM:END_DATE,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),DATE(MONTH(B_DAT)+1,1,YEAR(B_DAT))-1) !NOÒEMTS MM.
!                     VERT_B=VERT_S-PAM:KAP_V-PAM:NOL_V-AMO:NOL_U_LI-AMO:NOL_LIN
                     VERT_B=VERT_S-PAM:NOL_V-AMO:NOL_U_LI-AMO:NOL_LIN  !26.11.2008
                  ELSE
!                     TEXTS='noòemts '&format(PAM:END_DATE,@D6)
                  .
                  KAT_NR=PAM:KAT[I#]

                  NULL_DATUMS=0
                  NPK#=0
                  CLEAR(AMO:RECORD)
                  AMO:U_NR=PAM:U_NR
                  SET(AMO:NR_KEY,AMO:NR_KEY)
                  LOOP
                     NEXT(PAMAM)
                     IF ERROR() OR ~(AMO:U_NR=PAM:U_NR) THEN BREAK.
                     NPK#+=1
                     IF NPK#=1 THEN CYCLE.
                     IF AMO:NOL_LIN=0
                        NULL_DATUMS=AMO:YYYYMM
                        BREAK
                     .
                  .

                  N:BKK=PAM:BKK
                  GET (N_TABLE,N:BKK)
                  IF ERROR()
                     N:BKKN=PAM:BKKN
                     N:VERT_S=VERT_S
                     N:VERT_B=VERT_B
                     ADD(N_TABLE)
                     SORT(N_TABLE,N:BKK)
                  ELSE
                     N:VERT_S+=VERT_S
                     N:VERT_B+=VERT_B
                     PUT(N_TABLE)
                  .

                  IF F:DBF='W'
                     PRINT(RPT:detail)
                  ELSE
                     OUTA:LINE=LEFT(FORMAT(PAM:U_NR,@N_11))&CHR(9)&FORMAT(KAT_NR,@P#_##P)&CHR(9)&PAM:NOS_P&CHR(9)&|
                     FORMAT(PAM:EXPL_DATUMS,@D06.)&CHR(9)&FORMAT(PAM:IZG_GAD,@N_4)&CHR(9)&|
                     FORMAT(PAM:SKAITS,@N_4)&CHR(9)&LEFT(FORMAT(VERT_S,@N-_12.2))&CHR(9)&LEFT(FORMAT(VERT_B,@N-_12.2))&|
                     CHR(9)&format(NULL_DATUMS,@D06.B)
                     ADD(OUTFILEANSI)
                  .
                  VERT_SK+=VERT_S
                  VERT_BK+=VERT_B
                  SKAITS_K+=AMO:SKAITS
                  SKAITS_SK+=PAM:SKAITS
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:DETAIL1)
        LOOP I#=1 TO RECORDS(N_TABLE)
           GET(N_TABLE,I#)
           PRINT(RPT:DETAIL2)
        .
    ELSE
        OUTA:LINE=CHR(9)&'KOPÂ'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
        FORMAT(SKAITS_k,@N_4)&CHR(9)&LEFT(FORMAT(VERT_Sk,@N-_12.2))&CHR(9)&LEFT(FORMAT(VERT_Bk,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Sakarâ ar pilnîgu nolietoðanos un(vai) to, ka uzskaitîtos pamatlîdzekïus vairs'
        ADD(OUTFILEANSI)
        OUTA:LINE='nav iespçjams izmantot saimnieciskajâ darbîbâ, mçs, apakðâ parakstîjusies'
        ADD(OUTFILEANSI)
        OUTA:LINE='komisija, tos noòemam no uzskaites. Pçc savstarpçjas vienoðanâs minçtie '
        ADD(OUTFILEANSI)
        OUTA:LINE='pamatlîdzekïi tiek pârdoti _{44}'
        ADD(OUTFILEANSI)
        OUTA:LINE='par kopçjo summu _{21} ar PVN '&SYS:NOKL_PVN&'% _{21}minçto summu ieturçt no darba algas.'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Komisija:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM1
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM2
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM3
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF<>'W' THEN F:DBF='W'.
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
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
SelftestKadri        PROCEDURE                    ! Declare Procedure
VIRSRAKSTS           STRING(60)
KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME

JPG_NOLD             STRING(10) !PAIDÂM
JPG_NAME             STRING(10)

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

!----------------------------------------
report REPORT,AT(200,105,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
header DETAIL,AT(,,,948)
         STRING(@s45),AT(1458,104,5521,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1802,490,4823,229),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s90),AT(208,21,7344,156),USE(KOMENT),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
footer DETAIL,AT(,,,229),USE(?unnamed)
         LINE,AT(104,52,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@t4),AT(7229,83),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(156,83),USE(?String5),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,83),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6667,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
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
  CHECKOPEN(KADRI,1)
  KADRI::used+=1
  CHECKOPEN(KAD_RIK,1)
  KAD_RIK::used+=1
  CHECKOPEN(GLOBAL,1)

  VIRSRAKSTS='VS "WinLats"  paðtests  - KADRI,KAD_RIK '&FORMAT(TODAY(),@D06.)
  CLEAR(KAD:RECORD)
  dat=today()
  lai=clock()
  FilesOpened = True

  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Selftest (Paðtests)'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  RecordsToProcess = RECORDS(KADRI)+RECORDS(KAD_RIK)
  DISPLAY()
  OPEN(report)
  report{Prop:Preview} = PrintPreviewImage
  PRINT(rpt:header)
  !***********************KADRI******************************
  SET(KADRI) !DAT_KEY NAVA
  LOOP
     NEXT(KADRI)
     IF ERROR() THEN BREAK.
     DO COUNTER
!----1
     JPG_NOLD='K'&CLIP(KAD:ID)&'.jpg'
     JPG_NAME=FORMAT(KAD:ID,@N04)&'-K.jpg'
     COPY(JPG_NOLD,JPG_NAME)                 !BIJA DATU FOLDERÎ
     IF ~ERROR()
        ANSIFILENAME = DOCFOLDERK&'\'&JPG_NAME
        IF ~(DOS_CONT(ANSIFILENAME,1))       !VÇL NAV IZVEIDOTS
           RENAME(JPG_NAME,ANSIFILENAME)
           IF ~ERROR()
              KOMENT='Mainu '&CLIP(JPG_NOLD)&' uz '&ANSIFILENAME
              print(rpt:detail)
           .
        .
     .
!----2
     IF KAD:DAR_DAT>=GL:FREE_N  !REÌ.DAT
        CLEAR(RIK:RECORD)
        RIK:ID=KAD:ID
        RIK:DATUMS=KAD:DAR_DAT
        GET(KAD_RIK,RIK:ID_KEY)
        IF ERROR()
           DO AUTONUMBER
           IF ~RIK:U_NR THEN CYCLE.
           RIK:ID=KAD:ID
           RIK:DATUMS=KAD:DAR_DAT
           IF KAD:DAR_LIG
              RIK:DOK_NR=KAD:DAR_LIG
           ELSE
              RIK:DOK_NR=PERFORMGL(11)   !PIEÐÍIRAM RIK. NR
              KAD:DAR_LIG=RIK:DOK_NR
              PUT(KADRI)
           .
           RIK:DATUMS1=KAD:DARBA_GR
           RIK:TIPS='K'
           RIK:Z_KODS=KAD:Z_KODS
           RIK:SATURS='Pieòemt darbâ no '&FORMAT(KAD:DARBA_GR,@D06.)&', amats- '&CLIP(kad:amats)
           RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-SAK.doc'
           RIK:ACC_KODS=ACC_kods
           RIK:ACC_DATUMS=today()
           PUT(KAD_RIK)
           IF ~ERROR()
              KOMENT='Ievadu pavçli Nr '&CLIP(RIK:DOK_NR)&' par pieòemðanu: '&CLIP(KAD:UZV)&' no '&FORMAT(KAD:DARBA_GR,@D06.)
              print(rpt:detail)
           .
        .
     .
!----3
     IF KAD:NEDAR_DAT>=GL:FREE_N  !REÌ.DAT
        CLEAR(RIK:RECORD)
        RIK:ID=KAD:ID
        RIK:DATUMS=KAD:NEDAR_DAT
        GET(KAD_RIK,RIK:ID_KEY)
        IF ERROR()
           DO AUTONUMBER
           IF ~RIK:U_NR THEN CYCLE.
           RIK:ID=KAD:ID
           RIK:DATUMS=KAD:NEDAR_DAT
           IF KAD:NEDAR_LIG
              RIK:DOK_NR=KAD:NEDAR_LIG
           ELSE
              RIK:DOK_NR=PERFORMGL(11)   !PIEÐÍIRAM RIK. NR
              KAD:NEDAR_LIG=RIK:DOK_NR
              PUT(KADRI)
           .
           RIK:DATUMS1=KAD:D_GR_END
           RIK:TIPS='K'
           RIK:Z_KODS=KAD:Z_KODS_END
           RIK:SATURS='Atlaist no darba '&FORMAT(KAD:D_GR_END,@D06.)
           RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-END.doc'
           RIK:ACC_KODS=ACC_kods
           RIK:ACC_DATUMS=today()
           PUT(KAD_RIK)
           IF ~ERROR()
              KOMENT='Ievadu pavçli Nr '&CLIP(RIK:DOK_NR)&' par atlaiðanu: '&CLIP(KAD:UZV)&' '&FORMAT(KAD:D_GR_END,@D06.)
              print(rpt:detail)
           .
        .
     .
  .
  !***********************RÎKOJUMI*******************************
  CLEAR(RIK:RECORD)
  SET(RIK:NR_key) !DAT_KEY NAVA
  LOOP
     NEXT(KAD_RIK)
     IF ERROR() THEN BREAK.
     DO COUNTER
     IF UPPER(RIK:R_FAILS)='R'&CLIP(RIK:U_NR)&'.DOC' !VECIE R-VÂRDI
        FILENAME1 = DOCFOLDER&'\'&RIK:R_FAILS        !VECAIS R-FOLDERIS
        FILENAME2 = DOCFOLDERK&'\'&FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
        RIK:R_FAILS = FORMAT(RIK:ID,@N04)&'-R'&CLIP(RIK:U_NR)&'.doc'
        IF DOS_CONT(FILENAME1,1)
           RENAME(FILENAME1,FILENAME2)
           IF ~ERROR()
              KOMENT='Mainu '&CLIP(FILENAME1)&' uz '&FILENAME2
              print(rpt:detail)
           ELSE
              STOP(CLIP(RIK:R_FAILS)&' '&ERROR())
           .
        .
     .
  .
!------------------------------
  PRINT(RPT:footer)
  ENDPAGE(report)
  pr:skaits=1
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
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO PROCEDURERETURN

!--------------------------------------------------------------------------------------------------------
PROCEDURERETURN        ROUTINE
  close(ProgressWindow)
  KADRI::used-=1
  IF KADRI::used=0 THEN close(KADRI).
  KAD_RIK::used-=1
  IF KAD_RIK::used=0 THEN close(KAD_RIK).
  RETURN

!--------------------------------------------------------------------------------------------------------
COUNTER        ROUTINE
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
      DISPLAY()
    END
  END

!--------------------------------------------------------------------------------------------------------
AUTONUMBER        ROUTINE
  LOOP
    SET(RIK:NR_KEY)
    PREVIOUS(KAD_RIK)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'KAD_RIK')
!      POST(Event:CloseWindow)
      RIK:U_NR = 0
      EXIT
    END
    IF ERRORCODE()
      RIK:U_NR = 1
    ELSE
      RIK:U_NR += 1
    END
    ADD(KAD_RIK)
    IF ERRORCODE()
      STOP(KAD:ID&ERROR())
      RIK:U_NR = 0
      EXIT
    .
    BREAK
  .
