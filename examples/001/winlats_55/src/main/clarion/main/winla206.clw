                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_SarakstsA          PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
                     GROUP,PRE(SAV)
NODALA                 STRING(2)
                     .
ALGA                 DECIMAL(9,2)
AVANSS               DECIMAL(9,2)
GADS0                DECIMAL(4)
RPT_GADS             DECIMAL(4)
MENESIS              STRING(10)
NPK                  USHORT
IZMAKS               DECIMAL(9,2)
SEIZMAKS             DECIMAL(9,2)
SEPARADS             DECIMAL(9,2)
SEIZMAK1             DECIMAL(9,2)
KOIZMAKS             DECIMAL(9,2)
SUMMAVAR             STRING(100)
NODTEXT              STRING(25)

B_TABLE          QUEUE,PRE(B)
NODALA               STRING(2)
VUT                  STRING(31)
AMATS                STRING(25)
IZMAKSAT             DECIMAL(9,2)
                  .

!------------------------------------------------------------------------
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
!--------------------------------------------------------------------------

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

!---------------------------------------------------------------------------
report REPORT,AT(200,1752,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,200,8000,1552)
         STRING(@P<<<#. lapaP),AT(7250,52),PAGENO,USE(?PageCount:2)
         STRING(@s45),AT(1719,52,4427,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Avansu saraksts Nr _____'),AT(1771,365,2135,260),USE(?String1:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(3958,365,417,260),USE(gads0),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(4375,365,573,260),USE(?String1:3),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(5000,365,1146,260),USE(menesis),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kases izdevumu orderis Nr'),AT(833,677,1823,208),USE(?String1),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(4500,677,1823,208),USE(SYS:AMATS1),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2656,833,833,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(6375,833,1458,0),USE(?Line29),COLOR(COLOR:Black)
         STRING(@n4),AT(833,885),USE(RPT_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada "___"_{24}'),AT(1250,885,2604,208),USE(?String3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(4500,1000,1823,208),USE(SYS:AMATS2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6385,1188,1458,0),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(365,1250,0,313),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(729,1250,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(4375,1250,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(6302,1250,0,313),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(7865,1250,0,313),USE(?Line3:26),COLOR(COLOR:Black)
         LINE,AT(365,1250,7500,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nr'),AT(406,1302,313,208),USE(?String12),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds,Uzvârds {30}Amats'),AT(771,1292,3385,208),USE(?String12:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksât'),AT(4792,1292,1198,208),USE(?String12:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Paraksts'),AT(6344,1292,1510,208),USE(?String12:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,1510,7500,0),USE(?Line2:2),COLOR(COLOR:Black)
       END
GRP_HEAD DETAIL,AT(,,,240),USE(?unnamed:3)
         LINE,AT(365,0,0,260),USE(?Line3:81),COLOR(COLOR:Black)
         LINE,AT(729,0,0,260),USE(?Line3:82),COLOR(COLOR:Black)
         STRING('Nodaïa :'),AT(1240,0,573,208),USE(?String12:12),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(1760,0,208,208),USE(B:NODALA),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,0,0,260),USE(?Line3:83),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,260),USE(?Line3:84),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,260),USE(?Line3:85),COLOR(COLOR:Black)
         STRING(@s25),AT(2115,0,1667,208),USE(NODTEXT),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,208,7500,0),USE(?Line33:2),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,7990,188),USE(?unnamed)
         LINE,AT(365,-10,0,197),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line3:27),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,197),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,197),USE(?Line3:6),COLOR(COLOR:Black)
         STRING(@n_10.2),AT(4771,10,885,156),USE(B:IZMAKSAT),RIGHT
         STRING(@s31),AT(781,0,1979,156),USE(B:VUT),LEFT
         STRING(@s25),AT(2740,0,1615,156),USE(B:amats),LEFT
         LINE,AT(729,-10,0,197),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@n3),AT(417,10,,156),USE(NPK),RIGHT
         LINE,AT(365,177,7500,0),USE(?Line33:3),COLOR(COLOR:Black)
       END
grp_foot DETAIL,AT(,,,281),USE(?unnamed:2)
         LINE,AT(6302,-10,0,313),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,313),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,313),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,313),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,313),USE(?Line25),COLOR(COLOR:Black)
         STRING('Kopâ pa nodaïu:'),AT(938,52,1198,156),USE(?String12:13),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,260,7500,0),USE(?Line33:5),COLOR(COLOR:Black)
         STRING(@n_10.2),AT(4771,52,885,156),USE(SEIZMAKS),RIGHT
       END
RPT_FOOT DETAIL,AT(,,,1781),USE(?unnamed:4)
         STRING('Kasieris'),AT(4188,1198,521,208),USE(?String12:10),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(6198,1198,1823,208),USE(SYS:PARAKSTS3,,?SYS:PARAKSTS3:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ :'),AT(938,260,1198,208),USE(?String12:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,-10,0,479),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,479),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,479),USE(?Line3:41),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,479),USE(?Line3:42),COLOR(COLOR:Black)
         STRING('Kopâ pa nodaïu :'),AT(938,21,1198,156),USE(?String12:6),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,469,7500,0),USE(?Line33),COLOR(COLOR:Black)
         STRING('KOPÂ :'),AT(469,573,573,208),USE(?String12:7),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1094,573,6771,208),USE(SUMMAVAR),LEFT,FONT(,9,,),COLOR(COLOR:Silver)
         STRING(@n_10.2),AT(4771,21,885,156),USE(SEIZMAK1),RIGHT
         LINE,AT(365,208,7500,0),USE(?Line33:6),COLOR(COLOR:Black)
         STRING('Pçc esoðâ avansu saraksta izmaksâts :_{43}' &|
             '_{51}'),AT(469,990,7344,208),USE(?String12:8),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n_10.2),AT(4771,260,885,208),USE(KOIZMAKS),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deponçts :_{37}'),AT(469,1302,3646,208),USE(?String12:9),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4729,1365,1458,0),USE(?Line29:3),COLOR(COLOR:Black)
         STRING(@s25),AT(2813,1563,1875,208),USE(SYS:AMATS2,,?SYS:AMATS2:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(6198,1542,1823,208),USE(SYS:PARAKSTS2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4729,1667,1458,0),USE(?Line29:4),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,479),USE(?Line3:40),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,11000,8000,52)
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
  CHECKOPEN(KADRI,1)
  CHECKOPEN(DAIEV,1)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  BIND(ALP:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Avansu saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      alg:YYYYMM=ALP:YYYYMM
      ALG:NODALA=F:NODALA
      SET(ALG:NOD_key,alg:NOD_key)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~ALG:NODALA=F:NODALA) AND ~(ID AND ~ALG:ID=ID)'
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

      RPT_GADS  = YEAR(ALP:YYYYMM)  !gads, kad drukâ
      GADS0     = YEAR(ALP:YYYYMM)  !gads, par kuru avansu saraksts
      MENESIS   = MENVAR(ALP:YYYYMM,2,2)
      NODTEXT   = GETNODALAS(ALG:NODALA,1)
!      sav:NODALA= alg:NODALA

    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        AVANSS = SUM(9)
        IF AVANSS
           B:NODALA=ALG:NODALA
           B:VUT=GETKADRI(ALG:ID,2,1)
           B:AMATS=KAD:AMATS
           B:IZMAKSAT=AVANSS
           ADD(B_TABLE)
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
     LOOP I#=1 TO RECORDS(B_TABLE)
         GET(B_TABLE,I#)
         DO CHECK_BREAK
         NPK += 1
         PRINT(RPT:DETAIL)
         seizmaks += B:IZMAKSAT
         KOizmaks += B:IZMAKSAT
     .
     seizmak1=seizmaks
     SUMMAVAR=SUMVAR(KOIZMAKS,val_uzsk,0)
     PRINT(RPT:RPT_FOOT)
     ENDPAGE(report)
     CLOSE(ProgressWindow)
     F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
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
  IF FilesOpened
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(B_TABLE)
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
  IF ERRORCODE() OR ~(Alg:YYYYMM=ALP:YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CHECK_BREAK  ROUTINE
  IF B:NODALA <> sav:NODALA
    IF I#>1 THEN PRINT(RPT:GRP_FOOT).
    NODTEXT=GETNODALAS(B:NODALA,1)
    PRINT(RPT:GRP_head)
    sav:NODALA=B:NODALA
    seizmaks = 0
  .
F_KadruSar           PROCEDURE                    ! Declare Procedure
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
FILTRS_TEXT          STRING(60)
NPK                  USHORT

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

report REPORT,AT(146,1583,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,292,8000,1292),USE(?PAGEHEADER)
         STRING(@s45),AT(1760,94,4396,219),USE(CLIENT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kadru saraksts uz '),AT(2813,417),USE(?String33),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4375,417,990,260),USE(datums),LEFT(1),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1813,688,4688,156),USE(FILTRS_TEXT),CENTER,FONT(,9,,,CHARSET:ANSI)
         LINE,AT(52,990,7865,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(1708,990,0,313),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(7917,990,0,313),USE(?Line6:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,1042,260,208),USE(?String37:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,990,0,313),USE(?Line6:11),COLOR(COLOR:Black)
         STRING('ID'),AT(417,1042,260,208),USE(?String37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,990,0,313),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('Uzvârds'),AT(719,1042,990,208),USE(?String37:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. kods'),AT(1729,1042,781,208),USE(?String37:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2510,990,0,313),USE(?Line6:5),COLOR(COLOR:Black)
         STRING('Pases dati'),AT(2552,1042,2135,208),USE(?String37:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4688,990,0,313),USE(?Line6:6),COLOR(COLOR:Black)
         STRING('Ter. k.'),AT(4698,1042,417,208),USE(?String37:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5115,990,0,313),USE(?Line6:7),COLOR(COLOR:Black)
         STRING('Kartes Nr'),AT(5125,1042,781,208),USE(?String37:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5917,990,0,313),USE(?Line6:8),COLOR(COLOR:Black)
         STRING('S'),AT(5938,1042,104,208),USE(?String37:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6052,990,0,313),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(6958,990,0,313),USE(?Line6:10),COLOR(COLOR:Black)
         STRING('Amats'),AT(6073,1042,885,208),USE(?String37:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pieòemts   Atl.'),AT(6979,1042,938,208),USE(?String37:9),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1250,7865,0),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(52,990,0,313),USE(?Line6),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8000,177)
         LINE,AT(7917,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,198),USE(?Line13:9),COLOR(COLOR:Black)
         LINE,AT(2510,-10,0,198),USE(?Line13:3),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(1708,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,198),USE(?Line13:2),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,260,156),CNT,USE(npk),RIGHT
         STRING(@n4),AT(396,10,260,156),USE(KAD:ID),LEFT(1)
         STRING(@s20),AT(698,10,990,156),USE(varuzv),LEFT
         STRING(@p######-#####p),AT(1729,10,781,156),USE(KAD:PERSKOD)
         STRING(@s35),AT(2542,10,2135,156),USE(KAD:PASE)
         STRING(@n06),AT(4698,10,417,156),USE(KAD:TERKOD),CENTER
         STRING(@s12),AT(5135,10,781,156),USE(KAD:KARTNR),LEFT
         STRING(@s1),AT(5938,10,104,156),USE(KAD:STATUSS),CENTER
         STRING(@s14),AT(6073,10,885,156),USE(KAD:AMATS)
         STRING(@D05.),AT(6979,10,469,156),USE(KAD:DARBA_GR),LEFT
         STRING(@D05.B),AT(7448,10,469,156),USE(KAD:D_GR_END),LEFT
         LINE,AT(4688,-10,0,198),USE(?Line13:4),COLOR(COLOR:Black)
         LINE,AT(5115,-10,0,198),USE(?Line13:5),COLOR(COLOR:Black)
         LINE,AT(5917,-10,0,198),USE(?Line13:6),COLOR(COLOR:Black)
         LINE,AT(6052,-10,0,198),USE(?Line13:7),COLOR(COLOR:Black)
         LINE,AT(6958,-10,0,198),USE(?Line13:8),COLOR(COLOR:Black)
       END
PageFoot DETAIL,AT(,,,198),USE(?unnamed:2)
         STRING(@D06.),AT(6792,83,625,156),USE(DATUMS,,?DATUMS:2),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(52,0,0,63),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(1708,0,0,63),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,63),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,63),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(5115,0,0,63),USE(?Line10:7),COLOR(COLOR:Black)
         LINE,AT(5917,0,0,63),USE(?Line10:6),COLOR(COLOR:Black)
         LINE,AT(6052,0,0,63),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(6958,0,0,63),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(365,0,0,63),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(677,0,0,63),USE(?Line10:9),COLOR(COLOR:Black)
         LINE,AT(2510,0,0,63),USE(?Line10:8),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@T4),AT(7438,83,490,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,11000,8000,198)
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
        OUTA:LINE='Kadru saraksts uz '&FORMAT(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Npk'&CHR(9)&'ID'&CHR(9)&'Uzvârds,Vârds'&CHR(9)&'Pers.kods'&CHR(9)&'Pases dati'&CHR(9)&'Ter.kods' &CHR(9)&|
        'Statuss'&CHR(9)&'Nodaïa'&CHR(9)&'Amats'&CHR(9)&'Pieòemts'&CHR(9)&'Atlaists'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK+=1
        IF F:DBF='W'   !WMF
          VARUZV = CLIP(KAD:UZV)&' '&SUB(KAD:VAR,1,1)&'.'
          PRINT(RPT:detail)
        ELSE           !WORD,EXCEL
          OUTA:LINE=FORMAT(NPK,@N_4)&CHR(9)&FORMAT(ID,@N_5)&CHR(9)&CLIP(KAD:UZV)&' '&CLIP(KAD:VAR)&CHR(9)&|
          FORMAT(KAD:PERSKOD,@p######-#####p)&CHR(9)&CLIP(KAD:PASE)&FORMAT(KAD:TERKOD,@N_06)&CHR(9)&KAD:KARTNR&CHR(9)&|
          KAD:STATUSS&CHR(9)&KAD:NODALA&CHR(9)& KAD:AMATS&CHR(9)&FORMAT(KAD:DARBA_GR,@D06.B)&CHR(9)&FORMAT(KAD:D_GR_END,@D06.B)
        .
          ADD(OUTFILEANSI)
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
A_SarakstsL          PROCEDURE                    ! Declare Procedure
!---------------------------------------------------------------------------
SEKTORS              STRING(2)     ! Tekoðais sektors
NPK                  USHORT        ! Numurs pçc kârtas
NPS                  USHORT        ! Numurs tek. sektorâ
CIL_SK               USHORT        ! Izdrukâtais cilv. skaits. tek. sektorâ.
NOD_SK               USHORT        ! Izdrukâto NODAÏU SKAITS
SAV_NODALA           STRING(2)
VUT                  STRING(25)
KOPA_IZMAKSAT        DECIMAL(10,2)
RPT_GADS             DECIMAL(4)    ! vajag
NUMURS               DECIMAL(3)
ALGA                 DECIMAL(10,2)
SOCPAB               DECIMAL(9,2)
SLIM                 DECIMAL(9,2)
ATVALIN              DECIMAL(9,2)
CITIP                DECIMAL(9,2)
CITIP2               DECIMAL(9,2)
PKOPA                DECIMAL(10,2)
NODOKLI              DECIMAL(9,2)
SOCAPDR              DECIMAL(9,2)
IZP                  DECIMAL(9,2)
CITI_ATV1            DECIMAL(9,2)
CITI_ATV2            DECIMAL(9,2)
CITI_ATV3            DECIMAL(9,2)
AVANS                DECIMAL(9,2)
CITIET               DECIMAL(9,2)
IZMAKS               DECIMAL(10,2)
PARADS               STRING(6)
SEALGA               DECIMAL(10,2)
SESOCPAB             DECIMAL(9,2)
SESLIM               DECIMAL(9,2)
SEATVALIN            DECIMAL(9,2)
SECITIP              DECIMAL(9,2)
SECITIP2             DECIMAL(9,2)
SEPKOPA              DECIMAL(10,2)
SENODOKLI            DECIMAL(9,2)
SESOCAPDR            DECIMAL(9,2)
SEIZP                DECIMAL(9,2)
SECITI_ATV1          DECIMAL(9,2)
SECITI_ATV2          DECIMAL(9,2)
SECITI_ATV3          DECIMAL(9,2)
SEAVANS              DECIMAL(9,2)
SECITIET             DECIMAL(9,2)
SEIZMAKS             DECIMAL(10,2)
SEPARADS             DECIMAL(10,2)
KOALGA               DECIMAL(10,2)
KOSOCPAB             DECIMAL(9,2)
KOSLIM               DECIMAL(9,2)
KOATVALIN            DECIMAL(9,2)
KOCITIP              DECIMAL(9,2)
KOCITIP2             DECIMAL(9,2)
KOPKOPA              DECIMAL(10,2)
KONODOKLI            DECIMAL(9,2)
KOSOCAPDR            DECIMAL(9,2)
KOIZP                DECIMAL(9,2)
KOCITI_ATV1          DECIMAL(9,2)
KOCITI_ATV2          DECIMAL(9,2)
KOCITI_ATV3          DECIMAL(9,2)
KOAVANS              DECIMAL(9,2)
KOCITIET             DECIMAL(9,2)
KOIZMAKS             DECIMAL(10,2)
KOPARADS             DECIMAL(10,2)
SUMMA_V              STRING(120)
SUMMA_V1             STRING(120)

VIRSRAKSTS           STRING(80)

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

!---------------------------------------------------------------------------
report REPORT,AT(104,2135,12000,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(104,146,12000,1990),USE(?unnamed)
         STRING(@s45),AT(3229,104,4635,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10104,1250,573,208),PAGENO,USE(?PageCount:2),RIGHT !         LINE,AT(6406,625,2073,0),USE(?Line50),COLOR(COLOR:Black)
         STRING(@n4),AT(1427,677),USE(RPT_gads),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada "___"_{24}'),AT(1729,667,2635,208),USE(?String3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(5417,677,1615,208),USE(SYS:AMATS2),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(8521,708,1677,208),USE(sys:paraksts2),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7052,833,1458,0),USE(?Line51),COLOR(COLOR:Black)
         STRING('Kasei samaksai termiòâ no ____g._{12} lîdz ____g._{12}'),AT(1427,938,4844,208),USE(?String1:2), |
             LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,11302,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2760,1510,0,469),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(3333,1510,0,469),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(3854,1510,0,469),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(4375,1510,0,469),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(4896,1510,0,469),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(5417,1510,0,469),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(6042,1510,0,469),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(6094,1510,0,469),USE(?Line3:35),COLOR(COLOR:Black)
         LINE,AT(6563,1510,0,469),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(7083,1510,0,469),USE(?Line3:20),COLOR(COLOR:Black)
         LINE,AT(7552,1510,0,469),USE(?Line3:21),COLOR(COLOR:Black)
         LINE,AT(8125,1510,0,469),USE(?Line3:23),COLOR(COLOR:Black)
         LINE,AT(8646,1510,0,469),USE(?Line3:26),COLOR(COLOR:Black)
         LINE,AT(9146,1510,0,469),USE(?Line3:43),COLOR(COLOR:Black)
         LINE,AT(9635,1510,0,469),USE(?Line3:55),COLOR(COLOR:Black)
         LINE,AT(10156,1510,0,469),USE(?Line3:44),COLOR(COLOR:Black)
         LINE,AT(10781,1510,0,469),USE(?Line3:45),COLOR(COLOR:Black)
         LINE,AT(11406,1510,0,469),USE(?Line3:46),COLOR(COLOR:Black)
         LINE,AT(417,1510,0,469),USE(?Line3:61),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,1667,260,208),USE(?String12:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(469,1667,208,208),USE(?String12:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,1510,0,469),USE(?Line3:58),COLOR(COLOR:Black)
         STRING('Pârm/Par,'),AT(7583,1563,521,156),USE(?String12:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citi'),AT(8656,1563,469,156),USE(?String12:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citi'),AT(9198,1563,417,156),USE(?String12:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârsk.'),AT(9677,1563,469,156),USE(?String12:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksât'),AT(10188,1563,573,156),USE(?String12:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Alga,'),AT(2792,1563,521,156),USE(?StringALGA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piesk.'),AT(5448,1563,573,156),USE(?String12:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâk.'),AT(6594,1563,469,156),USE(?String12:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Slim.'),AT(3365,1563,469,156),USE(?String12:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atvaïin.'),AT(3885,1563,469,156),USE(?String12:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citi'),AT(4406,1563,469,156),USE(?String12:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citi'),AT(4927,1563,469,156),USE(?String12:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Soc.'),AT(6156,1573,365,156),USE(?String12:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izpild-'),AT(7115,1563,417,156),USE(?String12:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds,Uzvârds '),AT(729,1667,1458,156),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Avanss'),AT(8156,1667,469,156),USE(?String12:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Paraksts'),AT(10813,1667,573,156),USE(?String12:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.k.'),AT(2448,1719,208,156),USE(?String12:30),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(5448,1771,573,156),USE(?String12:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('lapa'),AT(3365,1771,469,156),USE(?String12:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nauda'),AT(3885,1771,469,156),USE(?String12:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('piesk(1)'),AT(4406,1771,469,156),USE(?String12:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('piesk(2)'),AT(4927,1771,469,156),USE(?String12:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apdr.'),AT(6135,1771,406,156),USE(?String12:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nod.'),AT(6667,1771,365,156),USE(?String12:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('raksts'),AT(7115,1771,417,156),USE(?String12:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ârk. izm.'),AT(7583,1771,521,156),USE(?String12:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iet.(1)'),AT(8667,1771,469,156),USE(?String12:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iet.(2)'),AT(9198,1771,417,156),USE(?String12:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uz karti'),AT(9667,1771,480,156),USE(?String12:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('/parâds'),AT(10188,1771,573,156),USE(?String12:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1979,11302,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('prçmija'),AT(2792,1771,521,156),USE(?StringPREMIJA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kases izdevumu orderis Nr :'),AT(1427,469,1667,208),USE(?String1),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(5417,469,1615,208),USE(SYS:AMATS1),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(8521,479,1677,208),USE(sys:paraksts1),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7052,583,1458,0),USE(?Line51:2),COLOR(COLOR:Black)
         STRING(@s80),AT(2458,1198,6188,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,0,469),USE(?Line3:25),COLOR(COLOR:Black)
       END
NOD_HEAD DETAIL,AT(,,,208),USE(?unnamed:4)
         LINE,AT(104,0,0,229),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,229),USE(?Line561),COLOR(COLOR:Black)
         LINE,AT(3333,0,0,229),USE(?Line562),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,229),USE(?Line563),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,229),USE(?Line564),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,229),USE(?Line564:2),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,229),USE(?Line566),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,229),USE(?Line568),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,229),USE(?Line569),COLOR(COLOR:Black)
         LINE,AT(7552,0,0,229),USE(?Line560),COLOR(COLOR:Black)
         LINE,AT(8125,0,0,229),USE(?Line56:3),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,229),USE(?Line56:2),COLOR(COLOR:Black)
         STRING('Nodaïa Nr'),AT(1094,10,625,156),USE(?String12:24),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(1729,10,156,156),USE(alg:NODALA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9146,0,0,229),USE(?Line56:4),COLOR(COLOR:Black)
         LINE,AT(10156,0,0,229),USE(?Line56:6),COLOR(COLOR:Black)
         LINE,AT(10781,0,0,229),USE(?Line56:7),COLOR(COLOR:Black)
         LINE,AT(11406,0,0,229),USE(?Line56:5),COLOR(COLOR:Black)
         LINE,AT(417,0,0,229),USE(?Line561:3),COLOR(COLOR:Black)
         LINE,AT(677,0,0,229),USE(?Line561:2),COLOR(COLOR:Black)
         LINE,AT(9635,0,0,229),USE(?Line56:8),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,229),USE(?Line565:2),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,229),USE(?Line565:3),COLOR(COLOR:Black)
         LINE,AT(208,208,11302,0),USE(?Line31),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,219),USE(?unnamed:3)
         LINE,AT(104,-10,0,229),USE(?Line3:28),COLOR(COLOR:Black)
         STRING(@s6),AT(10938,10,427,156),USE(parads),LEFT
         STRING(@n_7.2b),AT(6125,21,417,156),USE(SocApdr),RIGHT
         STRING(@n_8.2b),AT(8677,10,469,156),USE(CITI_ATV1),RIGHT
         STRING(@n_8.2b),AT(9688,10,469,156),USE(CITI_ATV3),RIGHT
         STRING(@n-_8.2b),AT(4948,10,469,156),USE(CitiP2),RIGHT
         LINE,AT(8646,-10,0,229),USE(?Line3:27),COLOR(COLOR:Black)
         LINE,AT(9146,-10,0,229),USE(?Line3:50),COLOR(COLOR:Black)
         LINE,AT(10156,-10,0,229),USE(?Line3:51),COLOR(COLOR:Black)
         LINE,AT(10781,-10,0,229),USE(?Line3:53),COLOR(COLOR:Black)
         LINE,AT(11406,-10,0,229),USE(?Line3:47),COLOR(COLOR:Black)
         STRING(@n06),AT(2344,10,417,156),USE(ALG:TERKOD),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(156,10,260,156),USE(NPK),RIGHT
         LINE,AT(417,-10,0,229),USE(?Line3:62),COLOR(COLOR:Black)
         STRING(@n3),AT(469,10,208,156),USE(NPS),RIGHT
         LINE,AT(677,-10,0,229),USE(?Line3:59),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(4427,10,469,156),USE(CitiP),RIGHT
         LINE,AT(6094,-10,0,229),USE(?Line3:36),COLOR(COLOR:Black)
         LINE,AT(115,208,11302,0),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,229),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,229),USE(?Line3:6),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3385,10,469,156),USE(Slim),RIGHT
         LINE,AT(4375,-10,0,229),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3906,10,469,156),USE(Atvalin),RIGHT
         LINE,AT(4896,-10,0,229),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@n-9.2b),AT(6573,21,500,156),USE(Nodokli),RIGHT
         LINE,AT(5417,-10,0,229),USE(?Line3:12),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(5469,10,573,156),USE(PKOPA),RIGHT
         LINE,AT(6042,-10,0,229),USE(?Line3:14),COLOR(COLOR:Black)
         STRING(@n_7.2b),AT(7135,10,417,156),USE(IZP),RIGHT
         STRING(@n_8.2b),AT(9167,10,469,156),USE(CITI_ATV2),RIGHT
         LINE,AT(9635,-10,0,229),USE(?Line3:56),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,229),USE(?Line3:18),COLOR(COLOR:Black)
         STRING(@n_8.2b),AT(8177,10,469,156),USE(AVANS),RIGHT
         LINE,AT(7083,-10,0,229),USE(?Line3:19),COLOR(COLOR:Black)
         STRING(@n-_9.2b),AT(7625,10,469,156),USE(citiet),RIGHT
         LINE,AT(7552,-10,0,229),USE(?Line3:22),COLOR(COLOR:Black)
         STRING(@n-9.2b),AT(10260,10,521,156),USE(IZMAKS),RIGHT
         LINE,AT(8125,-10,0,229),USE(?Line3:24),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(2813,10,521,156),USE(alga),RIGHT
         STRING(@s25),AT(729,10,1615,156),USE(vut),LEFT
         LINE,AT(2760,-10,0,229),USE(?Line3:2),COLOR(COLOR:Black)
       END
NOD_FOOT DETAIL,AT(,,,219),USE(?unnamed:5)
         LINE,AT(104,-10,0,229),USE(?Line3:29),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(10833,10,573,156),USE(SEparads),RIGHT
         LINE,AT(677,-10,0,229),USE(?Line3:60),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(4948,10,469,156),USE(SECitiP2),RIGHT
         STRING(@n-_8.2b),AT(4427,10,469,156),USE(SECitiP),RIGHT
         LINE,AT(9146,-10,0,229),USE(?Line3:48),COLOR(COLOR:Black)
         LINE,AT(10156,-10,0,229),USE(?Line3:52),COLOR(COLOR:Black)
         LINE,AT(10781,-10,0,229),USE(?Line3:54),COLOR(COLOR:Black)
         LINE,AT(11406,-10,0,229),USE(?Line3:49),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,229),USE(?Line3:63),COLOR(COLOR:Black)
         STRING(@n_8.2b),AT(8677,10,469,156),USE(SECITI_ATV1),RIGHT
         LINE,AT(9635,-10,0,229),USE(?Line3:57),COLOR(COLOR:Black)
         STRING(@n_8.2b),AT(9688,10,469,156),USE(SECITI_ATV3),RIGHT
         LINE,AT(6094,-10,0,229),USE(?Line3:37),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,229),USE(?Line3:16),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(5469,10,573,156),USE(SEPKOPA),RIGHT
         LINE,AT(8646,-10,0,229),USE(?Line3:42),COLOR(COLOR:Black)
         STRING('Kopâ pa nodaïu :'),AT(990,10,1198,156),USE(?String12:25),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,208,11302,0),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,229),USE(?Line3:31),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,229),USE(?Line3:32),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3385,10,469,156),USE(SESlim),RIGHT
         LINE,AT(4375,-10,0,229),USE(?Line3:33),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3906,10,469,156),USE(SEAtvalin),RIGHT
         LINE,AT(4896,-10,0,229),USE(?Line3:34),COLOR(COLOR:Black)
         STRING(@n_7.2b),AT(6125,10,417,156),USE(SESocApdr),RIGHT
         STRING(@n-9.2b),AT(6573,10,500,156),USE(SENodokli),RIGHT
         LINE,AT(6042,-10,0,229),USE(?Line3:15),COLOR(COLOR:Black)
         STRING(@n_7.2b),AT(7135,10,417,156),USE(SEIZP),RIGHT
         STRING(@n_8.2b),AT(9167,10,469,156),USE(SECITI_ATV2),RIGHT
         LINE,AT(6563,-10,0,229),USE(?Line3:38),COLOR(COLOR:Black)
         STRING(@n_8.2b),AT(8177,10,469,156),USE(SEAVANS),RIGHT
         LINE,AT(7083,-10,0,229),USE(?Line3:39),COLOR(COLOR:Black)
         STRING(@n-_9.2b),AT(7625,10,469,156),USE(SEcitiet),RIGHT
         LINE,AT(7552,-10,0,229),USE(?Line3:40),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(10188,10,590,156),USE(SEIZMAKS),RIGHT
         LINE,AT(8125,-10,0,229),USE(?Line3:41),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(2813,10,521,156),USE(SEalga),RIGHT
         LINE,AT(2760,-10,0,229),USE(?Line3:30),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,1563),USE(?unnamed:2)
         STRING('Kasieris'),AT(5208,990,677,208),USE(?String12:29),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(6979,990,1677,208),USE(sys:paraksts3),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1510,1146,3646,0),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(5885,1146,1042,0),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(2760,885,5677,0),USE(?Line52),COLOR(COLOR:Black)
         STRING(@s25),AT(4167,1302,1719,208),USE(SYS:AMATS2,,?SYS:AMATS2:2),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(6948,1313,1677,208),USE(sys:paraksts2,,?sys:paraksts2:2),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5885,1458,1042,0),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,219),USE(?Line13:29),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(10833,10,573,156),USE(KOparads),RIGHT
         STRING(@n-9.2b),AT(6573,21,500,156),USE(KONodokli),RIGHT
         STRING(@n_8.2b),AT(9688,10,469,156),USE(KOCITI_ATV3),RIGHT
         STRING(@n_8.2b),AT(8677,10,469,156),USE(KOCITI_ATV1),RIGHT
         STRING(@n-_8.2b),AT(4948,10,469,156),USE(KOCitiP2),RIGHT
         STRING(@n-_8.2b),AT(4427,10,469,156),USE(KOCitiP),RIGHT
         LINE,AT(8646,-10,0,219),USE(?Line13:42),COLOR(COLOR:Black)
         LINE,AT(9146,-10,0,219),USE(?Line13:421),COLOR(COLOR:Black)
         LINE,AT(10156,-10,0,219),USE(?Line13:422),COLOR(COLOR:Black)
         LINE,AT(10781,-10,0,219),USE(?Line13:423),COLOR(COLOR:Black)
         LINE,AT(11406,-10,0,219),USE(?Line13:424),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,219),USE(?Line13:30),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,219),USE(?Line13:301),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,219),USE(?Line13:35),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(990,10,1198,156),USE(?String12:31),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,208,11302,0),USE(?Line133),COLOR(COLOR:Black)
         STRING('Summa :'),AT(885,365,521,208),USE(?String12:26),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1458,365,7656,208),USE(SUMMA_V),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(2813,677,7760,208),USE(SUMMA_V1),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             COLOR(COLOR:Silver)
         STRING('Pçc esoðâ algu saraksta izmaksâts :'),AT(885,677,1875,208),USE(?String12:27),LEFT
         STRING('Deponçts :'),AT(885,990,625,208),USE(?String12:28),LEFT
         LINE,AT(3333,-10,0,219),USE(?Line13:31),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(5469,10,573,156),USE(KOPKOPA),RIGHT
         LINE,AT(3854,-10,0,219),USE(?Line13:32),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3385,10,469,156),USE(KOSlim),RIGHT
         LINE,AT(4375,-10,0,219),USE(?Line13:33),COLOR(COLOR:Black)
         STRING(@n-_8.2b),AT(3906,10,469,156),USE(KOAtvalin),RIGHT
         LINE,AT(4896,-10,0,219),USE(?Line13:34),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,219),USE(?Line13:351),COLOR(COLOR:Black)
         STRING(@n_7.2b),AT(6125,10,417,156),USE(KOSocApdr),RIGHT
         LINE,AT(6042,-10,0,219),USE(?Line13:36),COLOR(COLOR:Black)
         STRING(@n_7.2b),AT(7135,10,417,156),USE(KOIZP),RIGHT
         STRING(@n_8.2b),AT(9167,10,469,156),USE(KOCITI_ATV2),RIGHT
         LINE,AT(9635,-10,0,219),USE(?Line13:499),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,219),USE(?Line13:38),COLOR(COLOR:Black)
         STRING(@n_8.2b),AT(8177,10,469,156),USE(KOAVANS),RIGHT
         LINE,AT(7083,-10,0,219),USE(?Line13:39),COLOR(COLOR:Black)
         STRING(@n-_9.2b),AT(7625,10,469,156),USE(KOcitiet),RIGHT
         LINE,AT(7552,-10,0,219),USE(?Line13:40),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(10188,10,590,156),USE(KOIZMAKS),RIGHT
         LINE,AT(8125,-10,0,219),USE(?Line13:41),COLOR(COLOR:Black)
         STRING(@n-10.2b),AT(2802,10,521,156),USE(KOalga),RIGHT
         LINE,AT(2760,-10,0,219),USE(?Line13:302),COLOR(COLOR:Black)
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(SYSTEM,1)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1

  BIND(ALG:RECORD)
  BIND(ALP:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Lielais algu saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF ALP:STAT=3
         VIRSRAKSTS='Dividenþu saraksts Nr ___ '&YEAR(ALP:YYYYMM)&'. gada '&DAY(ALP:YYYYMM)&'.'&MENVAR(ALP:YYYYMM,2,2)
         ?StringALGA{PROP:TEXT}='Divi-'
         ?StringPREMIJA{PROP:TEXT}='dendes'
      ELSE
         VIRSRAKSTS='Algu saraksts Nr '&MONTH(ALP:YYYYMM)&'  '&YEAR(ALP:YYYYMM)&'. gada '&MENVAR(ALP:YYYYMM,2,2)
      .
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=ALP:YYYYMM
      ALG:NODALA=F:NODALA
      SET(ALG:NOD_KEY,ALG:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
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
      RPT_GADS=YEAR(ALP:YYYYMM)
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE
        IF ~OPENANSI('SARAKSTL.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KASES IZDEVUMU ORDERIS Nr:_____                    VADÎTÂJS:____________________'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=RPT_GADS&'. gada "___"__________                    GALVENAIS GRÂMATVEDIS:____________________'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Kasei samaksai termiòâ no ____g._______________lîdz____g._______________'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'!EXCEL
           OUTA:LINE='Vârds,uzvârds,terit.kods'&CHR(9)&'Alga,'&CHR(9)&'Slimîbas'&CHR(9)&'Atvaïin.'&CHR(9)&'Citi'&CHR(9)&'Citi'&CHR(9)&|
           'Piesk.'&CHR(9)&'Ienâk.'&CHR(9)&'Sociâlais'&CHR(9)&'Izpild-'&CHR(9)&'Pârm/Par.'&CHR(9)&'Avanss'&CHR(9)&'Citi'&|
           CHR(9)&'Citi'&CHR(9)&'Pârsk.uz'&CHR(9)&'Izmaksât/'&CHR(9)&'Paraksts'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'prçmija'&CHR(9)&'lapa'&CHR(9)&'nauda'&CHR(9)&'piesk.(1)'&CHR(9)&'piesk.(2)'&CHR(9)&|
           'kopâ'&CHR(9)&'nodoklis'&CHR(9)&'nodoklis'&CHR(9)&'raksts'&CHR(9)&'ârk.izm.'&CHR(9)&CHR(9)&'ietur.(1)'&|
           CHR(9)&'ietur.(2)'&CHR(9)&' karti'&CHR(9)&'parâds'
           ADD(OUTFILEANSI)
        ELSE !WORD
           OUTA:LINE='Vârds,uzvârds,terit.kods'&CHR(9)&'Alga, prçmija'&CHR(9)&'Slim. lapa'&CHR(9)&'Atv. nauda'&CHR(9)&|
           'Citi piesk. (1)'&CHR(9)&'Citi piesk. (2)'&CHR(9)&'Piesk. kopâ'&CHR(9)&'Ienâk. nodoklis'&CHR(9)&|
           'Sociâlais nodoklis'&CHR(9)&'Izpild- raksts'&CHR(9)&'Pârm/Par, ârk.izm.'&CHR(9)&'Avanss'&CHR(9)&|
           'Citi iet. (1)'&CHR(9)&'Citi iet. (2)'&CHR(9)&'Pârsk. uz karti'&CHR(9)&'Izmaksât /parâds'&CHR(9)&'Paraksts'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        IF ~(SAV_NODALA = ALG:NODALA)    !MAINÎJUSIES NODALA
           IF CIL_SK>1                   !VAIRÂK PAR 1 CILVÇKU NODAÏÂ
             IF F:DBF = 'W'
                PRINT(RPT:NOD_FOOT)
             ELSE
                OUTA:LINE='Kopâ pa Nodaïu:'&CHR(9)&LEFT(FORMAT(SEALGA,@N_10.2))&CHR(9)&LEFT(FORMAT(SESLIM,@N_8.2))&CHR(9)&|
                LEFT(FORMAT(SEATVALIN,@N_8.2))&CHR(9)&LEFT(FORMAT(SECITIP,@N_8.2))&CHR(9)&LEFT(FORMAT(SECITIP2,@N_8.2))&|
                CHR(9)&LEFT(FORMAT(SEPKOPA,@N_10.2))&CHR(9)&LEFT(FORMAT(SENODOKLI,@N_8.2))&CHR(9)&|
                LEFT(FORMAT(SESOCAPDR,@N_7.2))&CHR(9)&LEFT(FORMAT(SEIZP,@N_7.2))&CHR(9)&LEFT(FORMAT(SECITIET,@N_7.2))&|
                CHR(9)&LEFT(FORMAT(SEAVANS,@N_7.2))&CHR(9)&LEFT(FORMAT(SECITI_ATV1,@N_7.2))&CHR(9)&|
                LEFT(FORMAT(SECITI_ATV2,@N_7.2))&CHR(9)&LEFT(FORMAT(SECITI_ATV3,@N_7.2))&CHR(9)&|
                LEFT(FORMAT(SEIZMAKS,@N_11.2))&CHR(9)&LEFT(FORMAT(SEPARADS,@N_10.2B))
                ADD(OUTFILEANSI)
             .
             NOD_SK+=1                   !SKAITAM, CIK IR NODAÏU
          .
          IF F:DBF = 'W'
            PRINT(RPT:NOD_head)
          ELSE 
            OUTA:LINE='  NODALA Nr '&ALG:NODALA
            ADD(OUTFILEANSI)
          .
          NPS = 0
          SAV_NODALA = ALG:NODALA
          SEIZMAKS  = 0
          CIL_SK    =  0
          sealga    =  0
          SEPKOPA   =  0
          SESOCPAB  =  0
          seatvalin =  0
          SEcitiP   =  0
          SEcitiP2  =  0
          seslim    =  0
          sesocapdr =  0
          senodokli =  0
          seizp     =  0
          seciti_atv1 =  0
          seciti_atv2 =  0
          seciti_atv3 =  0
          seavans   =  0
          SEcitiet  =  0
        .
        NUMURS += 1
        CIL_SK +=1
        VUT      = GETKADRI(ALG:ID,2,1)
        IF ALP:STAT=3 !DIVIDENDES
           alga  = ALG:R[1]
        ELSE
           alga  = SUM(1)-SUM(16)-SUM(29) !ALGA BEZ SOC,ATV,SLILAPAS -CITAS_1(T=5) -CITAS_2(T=6)
        .
        SOCPAB   = SUM(2)                 !SOCIÂLIE ???
        ALGA     = ALGA+SOCPAB            !
        slim     = SUM(3)                 !SLILAPAS
        atvalin  = SUM(4)                 !VISI ATVAÏINÂJUMI
        CitiP    = SUM(16)                !CITAS PIEM(1,T=5)
        CitiP2   = SUM(29)                !CITAS PIEM(2,T=6)
        PKOPA    = ALGA+SLIM+ATVALIN+CITIP+CITIP2
        nodokli  = SUM(5)                 !Ienâk.n ðajâ, nâkamajâ, pagâjuðajâ
        socapdr  = SUM(6)                 !darba òçm soc, nâkamajâ, aiznâkamajâ,
        izp      = SUM(7)                 !alimenti(T=2)
        citi_atv1 = SUM(8)                !T=1
        citi_atv2 = SUM(55)               !T=6
        citi_atv3 = SUM(56)               !T=7
        avans    = SUM(9)                 !904
        citiet   = SUM(10)+sum(24)        !PÂRMAKSA+ÂRK.IZMAKSAS
        izmaks   = ALG:izmaksat
!        IF  IZMAKS <= -0.01  !MISTIKA
        IF  IZMAKS < 0  !09.02.2007
          sePARADS +=  izmaks
          KOPARADS +=  izmaks
          PARADS    = 'PARÂDS'
        ELSIF IZMAKS=0 AND CITI_ATV3
          PARADS    = 'Pârsk.'
        ELSE
          seizmaks +=  izmaks
          KOizmaks +=  izmaks
          PARADS    = ''
        .
!        STOP(ALG:INI&IZMAKS&F:IDP)
        IF PKOPA OR IZMAKS OR F:IDP  ! KAUT KAS APRÇÍINÂTS, KO IZMAKSÂT, VAI PIEPRASÎTS DRUKÂT ARÎ NULLES
           NPK += 1
           NPS += 1
           IF F:DBF = 'W'
               PRINT(RPT:DETAIL)
           ELSE
               VUT = clip(VUT)&' '&KAD:TERKOD !POZICIONÇTS
               OUTA:LINE=CLIP(VUT)&CHR(9)&LEFT(FORMAT(ALGA,@N_10.2))&CHR(9)&LEFT(FORMAT(SLIM,@N_8.2))&CHR(9)&|
               LEFT(FORMAT(ATVALIN,@N_8.2))&CHR(9)&LEFT(FORMAT(CITIP,@N_8.2))&CHR(9)&LEFT(FORMAT(CITIP2,@N_8.2))&|
               CHR(9)&LEFT(FORMAT(PKOPA,@N_10.2))&CHR(9)&LEFT(FORMAT(NODOKLI,@N_8.2))&CHR(9)&LEFT(FORMAT(SOCAPDR,@N_7.2))&|
               CHR(9)&LEFT(FORMAT(IZP,@N_7.2))&CHR(9)&LEFT(FORMAT(CITIET,@N_7.2))&CHR(9)&LEFT(FORMAT(AVANS,@N_7.2))&|
               CHR(9)&LEFT(FORMAT(CITI_ATV1,@N_7.2))&CHR(9)&LEFT(FORMAT(CITI_ATV2,@N_7.2))&CHR(9)&|
               LEFT(FORMAT(CITI_ATV3,@N_7.2))&CHR(9)&LEFT(FORMAT(IZMAKS,@N_11.2))&CHR(9)&LEFT(FORMAT(PARADS,@S6))
               ADD(OUTFILEANSI)
           .
        .
        sealga    +=  alga
        SEPKOPA   +=  PKOPA
        SESOCPAB  +=  SOCPAB
        seatvalin +=  atvalin
        seCitiP   +=  CitiP
        seCitiP2  +=  CitiP2
        seslim    +=  slim
        sesocapdr +=  socapdr
        senodokli +=  nodokli
        seizp     +=  izp
        seciti_atv1 +=  citi_atv1
        seciti_atv2 +=  citi_atv2
        seciti_atv3 +=  citi_atv3
        seavans  +=  avans
        SEcitiet +=  citiet
        KOalga    +=  alga
        KOPKOPA   +=  PKOPA
        KOSOCPAB  +=  SOCPAB
        KOatvalin +=  atvalin
        KOCitiP   +=  CitiP
        KOCitiP2  +=  CitiP2
        KOslim    +=  slim
        KOsocapdr +=  socapdr
        KOnodokli +=  nodokli
        KOizp     +=  izp
        KOciti_atv1 +=  citi_atv1
        KOciti_atv2 +=  citi_atv2
        KOciti_atv3 +=  citi_atv3
        KOavans  +=  avans
        KOcitiet +=  citiet
        KOPA_IZMAKSAT+= ALG:izmaksat
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
    IF CIL_SK>1 AND NOD_SK>1         !VAIRÂK PAR 1 CILVÇKU NODALÂ UN VAIRÂK PAR 1 NODAÏU
         IF F:DBF = 'W'
            PRINT(RPT:NOD_FOOT)
         ELSE
            OUTA:LINE='Kopâ pa Nodaïu:'&CHR(9)&LEFT(FORMAT(SEALGA,@N-_11.2))&CHR(9)&LEFT(FORMAT(SESLIM,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(SEATVALIN,@N-_10.2))&CHR(9)&LEFT(FORMAT(SECITIP,@N-_10.2))&CHR(9)&LEFT(FORMAT(SECITIP2,@N-_8.2))&|
            CHR(9)&LEFT(FORMAT(SEPKOPA,@N-_10.2))&CHR(9)&LEFT(FORMAT(SENODOKLI,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(SESOCAPDR,@N-_10.2))&CHR(9)&LEFT(FORMAT(SEIZP,@N-_10.2))&CHR(9)&LEFT(FORMAT(SECITIET,@N-_10.2))&|
            CHR(9)&LEFT(FORMAT(SEAVANS,@N-_10.2))&CHR(9)&LEFT(FORMAT(SECITI_ATV1,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(SECITI_ATV2,@N-_10.2))&CHR(9)&LEFT(FORMAT(SECITI_ATV3,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(SEIZMAKS,@N-_11.2))&CHR(9)&LEFT(FORMAT(SEPARADS,@N-_10.2))
            ADD(OUTFILEANSI)
         END
    .
    SUMMA_V=sumvar(KOPA_IZMAKSAT,val_uzsk,0)
    IF F:XML
       SUMMA_V1=SUMMA_V
    .
    IF F:DBF = 'W'
       PRINT(RPT:REP_FOOT)
    ELSE
       OUTA:LINE='Kopâ:'&CHR(9)&LEFT(FORMAT(KOALGA,@N-_11.2))&CHR(9)&LEFT(FORMAT(KOSLIM,@N-_10.2))&CHR(9)&|
       LEFT(FORMAT(KOATVALIN,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOCITIP,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOCITIP2,@N-_10.2))&|
       CHR(9)&LEFT(FORMAT(KOPKOPA,@N-_10.2))&CHR(9)&LEFT(FORMAT(KONODOKLI,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOSOCAPDR,@N-_10.2))&|
       CHR(9)&LEFT(FORMAT(KOIZP,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOCITIET,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOAVANS,@N-_10.2))&|
       CHR(9)&LEFT(FORMAT(KOCITI_ATV1,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOCITI_ATV2,@N-_10.2))&CHR(9)&|
       LEFT(FORMAT(KOCITI_ATV3,@N-_10.2))&CHR(9)&LEFT(FORMAT(KOIZMAKS,@N-_11.2))&CHR(9)&LEFT(FORMAT(KOPARADS,@N-_10.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='SUMMA:'&CHR(9)&SUMMA_V
       ADD(OUTFILEANSI)
       OUTA:LINE='Pçc esoðâ algu saraksta izmaksâts:'
       ADD(OUTFILEANSI)
       OUTA:LINE='Deponçts:'
       ADD(OUTFILEANSI)
       OUTA:LINE='Kasieris:__________'
       ADD(OUTFILEANSI)
       OUTA:LINE='Pârbaudîja grâmatvedis:__________'
       ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
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
  ELSE           !WORD,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!--------------ÈEKOJAM ALPA:IZMAKSAT
  IF ~(ALP:izmaksat=KOPA_IZMAKSAT) AND ~F:NODALA AND ~ID
     SUMMA=KOPA_IZMAKSAT
  ELSE
     SUMMA=0
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
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
!  stop(alg:Id&' '&ALG:YYYYMM&'='&ALP:YYYYMM)
  IF ERRORCODE() OR ~(ALG:YYYYMM=ALP:YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N_3) & '%'
      DISPLAY()
    END
  END
