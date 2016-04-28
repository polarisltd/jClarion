                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTKRIT PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
window               WINDOW('Fitrs izziòâm'),AT(,,200,91),GRAY
                       STRING('Ievadiet:'),AT(12,12,30,10),USE(?String1),LEFT
                       STRING('kritisko dienu skaitu'),AT(52,22,68,10),USE(?String1:2),LEFT
                       ENTRY(@n4.0),AT(157,22,22,10),USE(DIENAS)
                       STRING('cik pçdçjâs dienas ignorçt'),AT(52,35,86,10),USE(?String1:3),LEFT
                       ENTRY(@n4.0),AT(157,35,22,10),USE(DIENASIGN)
                       STRING('par kadu periodu veikt aprçíinu'),AT(52,48,104,10),USE(?String1:4),LEFT
                       ENTRY(@n4.0),AT(157,48,22,10),USE(PERIODS)
                       BUTTON('&OK'),AT(98,68,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(148,68,36,14),USE(?CancelButton)
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
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String1)
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
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCompleted
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCancelled
        BREAK
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IZZFILTKRIT','winlats.INI')
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
  END
  IF WindowOpened
    INISaveWindow('IZZFILTKRIT','winlats.INI')
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
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
N_DPIETEIK           PROCEDURE                    ! Declare Procedure
!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------
DATUMS               LONG
DAT                  LONG
LAI                  LONG
DAUDZUMS             DECIMAL(9,1)
A                    STRING(1)
!------------------------------------------------------------------------
ATLIKUMS            DECIMAL(12,3)
PIEEJAMS            DECIMAL(12,3)
DAUDZUMS1           DECIMAL(9,1)
DAUDZUMS2           DECIMAL(9,1)
DAUDZUMS3           DECIMAL(9,1)
DAUDZUMS4           DECIMAL(9,1)
intens              real
PERIODS1            DECIMAL(2)
PERIODS2            DECIMAL(2)
PERIODS3            DECIMAL(2)
PERIODS4            DECIMAL(2)
NoMoreFields        BYTE(0)                       !No more fields flag
NonStopSelect       BYTE(0)

RecordQueue         QUEUE,PRE(SAV)                !Queue for concurrency checking
SaveRecord           LIKE(pav:Record),PRE(SAV)   !size of primary file record
                    END                           !End Queue structure

AbortTransaction    BYTE
Auto:pav:npk        LIKE(pav:U_NR)                  ! AutoInc Save Value
Auto:Hold:pav:npk   LIKE(pav:U_NR)                  ! AutoInc Save Value
Auto:paR:nR         LIKE(pav:U_NR)                  ! AutoInc Save Value
Auto:Hold:paR:nR    LIKE(pav:U_NR)                  ! AutoInc Save Value
AutoIncAdd          BYTE(0)
SavePointer         STRING(255)                    !Position of current record
AutoAddPtr          STRING(255)                    !Position of Autoinc record

!------------------------------------------------------------------------
report REPORT,AT(150,1338,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(150,150,8000,1188)
         STRING(@s45),AT(1771,52,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu pieteikums    Noliktava :'),AT(2292,313,2500,260),USE(?String2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(4792,313,2135,260),USE(LOC_NR),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(3490,625,260,260),USE(?String2:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3802,625),USE(DATUMS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6667,729,,156),PAGENO,USE(?PageCount),RIGHT 
         LINE,AT(479,885,6979,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2135,885,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3125,885,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6563,885,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7448,885,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(521,938,1615,208),USE(?String8:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(3177,938,3385,208),USE(?String8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(6615,938,833,208),USE(?String8:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,1146,6979,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Kods'),AT(2188,938,938,208),USE(?String8:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,885,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(469,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,198),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,198),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,198),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
         STRING(@s21),AT(521,10,1615,156),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_13),AT(2188,10,885,156),USE(NOM:KODS),RIGHT 
         STRING(@s50),AT(3177,10,3177,156),USE(NOM:NOS_P),LEFT
         STRING(@N-_9.1),AT(6615,10,729,156),USE(DAUDZUMS),RIGHT 
       END
RPT_FOOT DETAIL,AT(,,,417)
         LINE,AT(469,-10,0,62),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,62),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,62),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,62),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,62),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(469,52,6979,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(573,156),USE(?String19) 
         STRING(@s8),AT(1146,156),USE(acc_kods) 
         STRING('RS :'),AT(2188,156),USE(?String16),CENTER 
         STRING(@s1),AT(2448,156),USE(RS),CENTER 
         STRING(@D6),AT(5573,156),USE(DAT) 
         STRING(@T4),AT(6354,156),USE(LAI) 
       END
       FOOTER,AT(150,11000,8000,63)
         LINE,AT(469,0,6979,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  BIND('CYCLENOM',CYCLENOM)
  IF F:DTK
      DO AUTONUMBER
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0        !DÇÏ LOOK-iem
    CheckOpen(NOLIK,1)
  END
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  BIND('A',A)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Preèu dinamiskais pieteikums'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  A='A'
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOM:RECORD)
      NOM:NOMENKLAT=NOMENKLAT
      SET(NOM:NOM_KEY,NOM:NOM_KEY)
      Process:View{Prop:Filter} = '~(NOM:TIPS=A)'
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
      sd#=today()-dienasign-periods+1
      S4#=round(periods/4,1)
      p4#=round(periods/4,1)-1
      periods1=format(day(sd#),@n02)&format(month(sd#),@n02)&'-'&|
                   format(day(sd#+p4#),@n02)&format(month(sd#+p4#),@n02)
      periods2=format(day(sd#+S4#),@n02)&format(month(sd#+S4#),@n02)&'-'&|
                   format(day(sd#+S4#+p4#),@n02)&format(month(sd#+S4#+p4#),@n02)
      periods3=format(day(sd#+2*S4#),@n02)&format(month(sd#+2*S4#),@n02)&'-'&|
                   format(day(sd#+2*S4#+p4#),@n02)&format(month(sd#+2*S4#+p4#),@n02)
      periods4=format(day(sd#+3*S4#),@n02)&format(month(sd#+3*S4#),@n02)&'-'&|
                   format(day(TODAY()-DIENASIGN),@n02)&format(month(TODAY()-DIENASIGN),@n02)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT)
           STOP(NOM:NOMENKLAT)
           ATLIKUMS = LOOKATL(4)
           INTENS   = LOOKINT(DIENASIGN,PERIODS)
           IF ~(ATLIKUMS>INTENS*DIENAS) AND ~(INTENS<=0)
               DAUDZUMS1=REALMAS[1]
               DAUDZUMS2=REALMAS[2]
               DAUDZUMS3=REALMAS[3]
               DAUDZUMS4=REALMAS[4]
               pieejams=ATLIKUMS
               DAUDZUMS=(DIENAS-(ATLIKUMS/INTENS))*INTENS
               PRINT(RPT:DETAIL)                            !  PRINT DETAIL LINES
               clear(nol:record)
               IF F:DTK
                 nol:U_nr      =pav:U_NR
                 nol:datums    =pav:datums
                 nol:NOMENKLAT =nom:nomenklat
                 nol:D_K    ='1'
                 nol:daudzums  =daudzums
                 nol:summa     =nom:pic*nol:daudzums
                 nol:summav    =nom:pic*nol:daudzums
                 !nol:VAL       ='Ls'
                 nol:VAL       =val_uzsk
                 nol:PVN_PROC  =nom:PVN_PROC
                 NOL:ARBYTE    ='bez'
                 add(nolik)
                 pav:summa    +=nol:summa
   !              nom:d_projekts[sys:avota_nr]+=nol:daudzums
   !              put(nom_k)
                 fillpvn(1)
               .
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:RPT_FOOT)                            !PRINT GRAND TOTALS
    CLOSE(REPORT)                                  !CLOSE REPORT
    IF F:DTK
       stop(pav:summa&'+'&getpvn(1))
       pav:summa+=getpvn(1)
       put(pavad)
    .
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    PAV:D_K='1'
    PAV:PAMAT='Automâtiski sastâdîts no DIN ATL'
    PAV:ACC_KODS=ACC_KODS
    PAV:ACC_datums=today()
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END

F_PriceList          PROCEDURE                    ! Declare Procedure
DATUMS              LONG
LAI                 LONG
REALIZ              DECIMAL(12,3)
REALIZ1             DECIMAL(12,3)   !summas pçc p/z
REALIZ2             DECIMAL(12,3)   !
REALIZ3             DECIMAL(12,3)   !
NOS                 STRING(3)
nom_pap_f           BYTE
NOM_NOSAUKUMS       STRING(45)
NOM_NEATL           BYTE
NOM_PZ              BYTE
SUMS                STRING(11)

NOM_NOS_P1          STRING(20),DIM(6)
NOM_NOS_P2          STRING(20),DIM(6)
NOM_NOS_P3          STRING(20),DIM(6)
NOM_NOS_P4          STRING(20),DIM(6)
REALIZ_L            USHORT,DIM(6)
REALIZ_S            BYTE,DIM(6)
NOM_GAB             STRING(10),DIM(6)
vitrina             BYTE
!F:X                 BYTE

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_K)
                       PROJECT(NOMENKLAT)
                       PROJECT(EAN)
                       PROJECT(KODS)
                       PROJECT(NOS_P)
                       PROJECT(BKK)
                       PROJECT(NOS_S)
                       PROJECT(MERVIEN)
                       PROJECT(SVARSKG)
                       PROJECT(TIPS)
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
         STRING(@s45),AT(2000,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7271,469),PAGENO,USE(?PageCount),RIGHT
         STRING('CENRÂDIS uz'),AT(2344,417),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(3542,417),USE(datums),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4531,417),USE(sys:avots),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1823,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2760,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6771,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(198,781,1615,208),USE(?String4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(1854,781,885,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kataloga Nr'),AT(2792,781,1094,208),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3906,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(3938,781,2813,208),USE(?String4:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena  ('),AT(6823,781,573,208),USE(?String4:4),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(7396,781),USE(nokl_cp),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(')'),AT(7604,781,156,208),USE(?String4:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,990,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146)
         LINE,AT(1823,-10,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@N_13B),AT(1875,0,833,146),USE(NOM:KODS),RIGHT
         LINE,AT(2760,-10,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s17),AT(2813,0,1094,146),USE(NOM:KATALOGA_NR),LEFT
         STRING(@s45),AT(3938,0,2813,146),USE(NOM_NOSAUKUMS),LEFT
         LINE,AT(6771,-10,0,167),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N_12.3),AT(6823,0,729,146),USE(REALIZ),RIGHT
         STRING(@s3),AT(7604,0,,146),USE(NOS),LEFT
         LINE,AT(7865,-10,0,167),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s21),AT(208,0,1615,146),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT DETAIL,AT(,,,219),USE(?unnamed:3)
         LINE,AT(156,0,0,63),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(1823,0,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,63),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,63),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,63),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(156,52,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,73),USE(?String18),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(625,73),USE(acc_kods),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6854,73),USE(DATUMS,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7448,73),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
RPT_FOOT1 DETAIL,AT(,,,583),USE(?unnamed:2)
         LINE,AT(156,0,0,63),USE(?Line113),COLOR(COLOR:Black)
         LINE,AT(1823,0,0,63),USE(?Line115),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line115:2),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,63),USE(?Line115:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,63),USE(?Line115:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,63),USE(?Line115:4),COLOR(COLOR:Black)
         LINE,AT(156,52,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Summa kopâ pçc P/Z :'),AT(177,94),USE(?String18:3)
         STRING(@N_12.3),AT(1917,94,729,146),USE(REALIZ1),RIGHT
         STRING('Summa kopâ realizâcijas cenâs :'),AT(177,240),USE(?String118:3)
         STRING(@N_12.3),AT(1917,250,729,146),USE(REALIZ2),RIGHT
         STRING('Sastâdîja :'),AT(5854,83),USE(?String18:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(6313,83),USE(acc_kods,,?acc_kods:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6854,83),USE(DATUMS,,?DATUMS:3),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7438,83),USE(LAI,,?LAI:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING('Starpîba:'),AT(177,396),USE(?String18:4)
         STRING(@N_12.3),AT(1917,417,729,146),USE(REALIZ3),RIGHT
       END
       FOOTER,AT(146,10896,8000,52)
         LINE,AT(156,0,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
     END
!-----------------------------------------------------------------------------
reportV REPORT,AT(50,50,8000,10000),PAPER(PAPER:A4),PRE(RPTV),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(,,,9271),USE(?unnamed:V)
         STRING(@s10),AT(6917,1073,990,208),USE(NOM_GAB[2]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4156,1604,2188,313),USE(NOM_NOS_P1[2]),TRN,CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(7469,1802,365,208),USE(REALIZ_S[2]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(6375,1823,1094,417),USE(REALIZ_L[2]),TRN,RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,1917,2031,208),USE(NOM_NOS_P2[2]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,2146,2031,208),USE(NOM_NOS_P3[2]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2813,1073,990,208),USE(NOM_GAB[1]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,2375,2031,208),USE(NOM_NOS_P4[2]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2771,4260,990,208),USE(NOM_GAB[3]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(6927,4260,990,208),USE(NOM_GAB[4]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(10,4781,2188,313),USE(NOM_NOS_P1[3]),TRN,CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4167,4781,2188,313),USE(NOM_NOS_P1[4]),TRN,CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(3302,4990,365,208),USE(REALIZ_S[3]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(2240,5052,1094,417),USE(REALIZ_L[3]),TRN,RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(63,5094,2031,208),USE(NOM_NOS_P2[3]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(7469,4990,365,208),USE(REALIZ_S[4]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(6375,5042,1094,417),USE(REALIZ_L[4]),TRN,RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4219,5094,2031,208),USE(NOM_NOS_P2[4]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(63,5333,2031,208),USE(NOM_NOS_P3[3]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4219,5333,2031,208),USE(NOM_NOS_P3[4]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(63,5563,2031,208),USE(NOM_NOS_P4[3]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4219,5563,2031,208),USE(NOM_NOS_P4[4]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2760,7469,990,208),USE(NOM_GAB[5]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(6917,7458,990,208),USE(NOM_GAB[6]),TRN,LEFT,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(0,7938,2188,313),USE(NOM_NOS_P1[5]),TRN,CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4156,7927,2188,313),USE(NOM_NOS_P1[6]),TRN,CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(3333,8177,365,208),USE(REALIZ_S[5]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(2240,8229,1094,417),USE(REALIZ_L[5]),TRN,RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(52,8250,2031,208),USE(NOM_NOS_P2[5]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(7469,8135,365,208),USE(REALIZ_S[6]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(6375,8188,1094,417),USE(REALIZ_L[6],,?REALIZ_L_6:2),TRN,RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,8240,2031,208),USE(NOM_NOS_P2[6]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(52,8490,2031,208),USE(NOM_NOS_P3[5]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,8479,2031,208),USE(NOM_NOS_P3[6]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(52,8719,2031,208),USE(NOM_NOS_P4[5]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4208,8708,2031,208),USE(NOM_NOS_P4[6]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N02),AT(3302,1802,365,208),USE(REALIZ_S[1]),TRN,LEFT,FONT('Courier New',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(21,1604,2188,313),USE(NOM_NOS_P1[1]),CENTER,FONT('Arial',18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(104,1917,2031,208),USE(NOM_NOS_P2[1]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(104,2146,2031,208),USE(NOM_NOS_P3[1]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(104,2375,2031,208),USE(NOM_NOS_P4[1]),TRN,CENTER,FONT('Arial',12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(2240,1823,1094,417),USE(REALIZ_L[1]),RIGHT,FONT('Courier New',32,,FONT:bold,CHARSET:BALTIC)
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

window WINDOW('Papildus Nom Filtrs'),AT(,,160,142),GRAY
       OPTION('Papildus Nom filtrs'),AT(16,12,106,39),USE(NOM_PAP_F),BOXED
         RADIO('Visas nomenklatûras'),AT(27,26,88,10),USE(?NOM_PAP_F:Radio1)
         RADIO('Tikai aktîvâs'),AT(27,37,88,10),USE(?NOM_PAP_F:Radio2)
       END
       BUTTON('Tikai, kam nedrîkst dot atlaidi'),AT(16,54,102,14),USE(?ButtonNeAtl)
       BUTTON('Tikai pçc izvçlçtâs P/Z'),AT(16,69,102,14),USE(?ButtonPZ)
       IMAGE('CHECK2.ICO'),AT(124,68,14,15),USE(?ImagePZ),HIDE
       BUTTON('Vitrînas formâts'),AT(17,85,102,14),USE(?ButtonVitrina)
       IMAGE('CHECK2.ICO'),AT(124,83,14,15),USE(?ImageVitrina),HIDE
       STRING('Tikai, kur Nom:X ='),AT(17,105),USE(?String1)
       ENTRY(@n1B),AT(80,103,14,10),USE(F:X)
       IMAGE('CHECK2.ICO'),AT(124,51,14,17),USE(?Image1),HIDE
       BUTTON('&OK'),AT(79,120,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(118,120,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPEN(window)
  nom_pap_f=1
  F:X=0
  IF ~(F:DBF='W') THEN DISABLE(?ButtonVitrina).
  ACCEPT
    CASE FIELD()
    OF ?ButtonNeAtl
      CASE EVENT()
      OF EVENT:Accepted
         IF NOM_NEATL=0
            NOM_NEATL=1
            UNHIDE(?IMAGE1)
         ELSE
            NOM_NEATL=0
            HIDE(?IMAGE1)
         .
      .
      DISPLAY
    OF ?ButtonPZ
      CASE EVENT()
      OF EVENT:Accepted
         IF NOM_PZ=FALSE
            NOM_PZ=TRUE
            UNHIDE(?IMAGEPZ)
         ELSE
            NOM_PZ=FALSE
            HIDE(?IMAGEPZ)
         .
      .
      DISPLAY
    OF ?ButtonVitrina
      CASE EVENT()
      OF EVENT:Accepted
         IF vitrina=FALSE
            vitrina=TRUE
            UNHIDE(?IMAGEVitrina)
         ELSE
            vitrina=FALSE
            HIDE(?IMAGEVitrina)
         .
      .
      DISPLAY
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
  IF NOLIK::Used = 0
    CheckOpen(NOLIK)
  END
  NOLIK::Used += 1

  BIND(NOM:RECORD)
  FilesOpened = True
  IF NOM_PZ
     RecordsToProcess = 25 !+-
  ELSE
     RecordsToProcess = RECORDS(NOM_K)
  .
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Cenu lapa'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF NOM_PZ
         CLEAR(NOL:RECORD)
         NOL:U_NR=PAV:U_NR
         SET(NOL:NR_KEY,NOL:NR_KEY)
      ELSE
         CLEAR(nom:RECORD)
         NOM:NOMENKLAT = NOMENKLAT
         CASE F:SECIBA
         OF 'N'
           SET(nom:nom_key,NOM:NOM_KEY)
         OF 'K'
           SET(nom:KOD_key)
         OF 'A'
           SET(nom:NOS_key)
         ELSE
           STOP('F:SECIBA')
         .
         OPEN(Process:View)
         IF ERRORCODE()
           StandardWarning(Warn:ViewOpenError)
         END
      .
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
        IF VITRINA
           OPEN(reportV)
           reportV{Prop:Preview} = PrintPreviewImage
        ELSE
           OPEN(report)
           report{Prop:Preview} = PrintPreviewImage
        .
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PRICE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='CENRÂDIS UZ '&format(DATUMS,@d06.)&' '&SYS:AVOTS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Nomenklatûra'&CHR(9)&'Kods'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Nosaukums'&CHR(9)&'Cena ('&nokl_cp&')'&|
        CHR(9)&CHR(9)&'ES KN kods'&CHR(9)&'Akcija'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT) AND ~(nom_pap_f=2 AND ~(NOM:REDZAMIBA=0)) AND ~(F:X AND ~(NOM:BAITS2=F:X))
           PRINT#=TRUE
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           IF NOM_PZ                           !TIKAI PÇC IZVÇLÇTÂS P/Z
              CLEAR(NOM:RECORD)
              NOM:NOMENKLAT=NOL:NOMENKLAT
              GET(NOM_K,NOM:NOM_KEY)
              IF ERROR()
                 NOM_NOSAUKUMS=NOL:NOMENKLAT&' '&NOL:DAUDZUMS
              ELSE
                 NOM_NOSAUKUMS=NOM:NOS_P[1:35]&' '&NOL:DAUDZUMS
                 REALIZ1+=CALCSUM(4,2)
                 REALIZ2+=REALIZ*NOL:DAUDZUMS
              .
           ELSE
              NOM_NOSAUKUMS=NOM:NOS_P[1:45] !50
           .
           REALIZ=getnom_k('POZICIONÇTS',0,7)
           IF F:CEN AND (REALIZ <= 0) THEN PRINT#=FALSE.                     !kam cena >0
           IF F:KRI AND (GETNOM_A(NOM:NOMENKLAT,1,0) <=0) THEN PRINT#=FALSE. !tikai, kam ir atlikumi
           IF ~F:PAK AND NOM:TIPS='A' THEN PRINT#=FALSE.                     !NAV JÂIEKÏAUJ PAKALPOJUMI
           IF NOM_NEATL AND ~BAND(NOM:NEATL,00000001b) THEN PRINT#=FALSE.    !TIKAI, KAM NEDRÎKST DOT ATLAIDI

           EXECUTE NOKL_CP
             NOS = NOM:VAL[1]
             NOS = NOM:VAL[2]
             NOS = NOM:VAL[3]
             NOS = NOM:VAL[4]
             NOS = NOM:VAL[5]
             NOS = 'Ls'
           .
           IF ~NOS THEN NOS = 'Ls'.

           IF PRINT#=TRUE
             IF F:DBF='W'
                IF VITRINA
                   DO VITRINA
                   IF COUNT#=6 !DRUKÂ PA 6 GAB. UZREIZ
                      PRINT(RPTV:DETAIL)
                   .
                ELSE
                   PRINT(RPT:DETAIL)
                .
             ELSIF F:DBF='E'
                OUTA:LINE=NOM:NOMENKLAT&CHR(9)&FORMAT(NOM:KODS,@N_13B)&CHR(9)&NOM:KATALOGA_NR&CHR(9)&NOM:NOS_P[1:45]&|
                CHR(9)&LEFT(FORMAT(REALIZ,@N_12.3))&CHR(9)&NOS&CHR(9)&FORMAT(NOM:MUITAS_KODS,@N_10B)&CHR(9)&|
                BAND(NOM:NEATL,00000010B) !OLGAI 08.O6.2011
                ADD(OUTFILEANSI)
             ELSE
                OUTA:LINE=NOM:NOMENKLAT&CHR(9)&FORMAT(NOM:KODS,@N_13B)&CHR(9)&NOM:KATALOGA_NR&CHR(9)&NOM:NOS_P[1:45]&|
                CHR(9)&LEFT(FORMAT(REALIZ,@N_12.3))&CHR(9)&NOS&CHR(9)&FORMAT(NOM:MUITAS_KODS,@N_10B)&CHR(9)&|
                BAND(NOM:NEATL,00000010B) !OLGAI 08.O6.2011
                ADD(OUTFILEANSI)
             END
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
    IF F:DBF='W'   !WMF
       IF ~VITRINA
          IF NOM_PZ                           !TIKAI PÇC IZVÇLÇTÂS P/Z
             REALIZ3=REALIZ2-REALIZ1
             PRINT(RPT:RPT_FOOT1)
          ELSE
             PRINT(RPT:RPT_FOOT)
          .
          ENDPAGE(report)
       ELSE
          IF INRANGE(COUNT#,1,6) !NEPILNA 6 GAB. LAPA
             PRINT(RPTV:DETAIL)
          .
          ENDPAGE(reportV)
       .
    ELSE !WORD,EXCEL
       IF NOM_PZ
          REALIZ3=REALIZ2-REALIZ1
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Summa kopâ pçc P/Z :'&chr(9)&LEFT(format(realiz1,@n_12.2))
          ADD(OUTFILEANSI)
          OUTA:LINE='Summa kopâ realizâcijas cenâs :'&chr(9)&LEFT(format(realiz2,@n_12.2))
          ADD(OUTFILEANSI)
          OUTA:LINE='Starpîba:'&chr(9)&LEFT(format(realiz3,@n_12.2))
          ADD(OUTFILEANSI)
       ELSE
          OUTA:LINE=''
          ADD(OUTFILEANSI)
       END
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
  IF NOM_PZ
     NEXT(NOLIK)
     IF ERRORCODE() OR ~(NOL:U_NR=PAV:U_NR)
       IF ERRORCODE() AND ERRORCODE() <> BadRecErr
         StandardWarning(Warn:RecordFetchError,'NOLIK')
       END
       LocalResponse = RequestCancelled
       EXIT
     ELSE
       LocalResponse = RequestCompleted
     END
  ELSE
     NEXT(Process:View)
     IF ERRORCODE() OR (F:SECIBA='N' AND CYCLENOM(NOM:NOMENKLAT)=2)
       IF ERRORCODE() AND ERRORCODE() <> BadRecErr
         StandardWarning(Warn:RecordFetchError,'NOM_K')
       END
       LocalResponse = RequestCancelled
       EXIT
     ELSE
       LocalResponse = RequestCompleted
     END
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

!-----------------------------------------------------------------------------
VITRINA ROUTINE
     COUNT#+=1
     IF COUNT#>6
        CLEAR(NOM_NOS_P1)
        CLEAR(NOM_NOS_P2)
        CLEAR(NOM_NOS_P3)
        CLEAR(NOM_NOS_P4)
        CLEAR(REALIZ_L)
        CLEAR(REALIZ_S)
        CLEAR(NOM_GAB)
        COUNT#=1
     .
     REALIZ_L[COUNT#]=INT(REALIZ)
     REALIZ_S[COUNT#]=(REALIZ-REALIZ_L[count#])*100
     NOM_GAB[COUNT#]='Ls/'&CLIP(NOM:MERVIEN)
     TEKSTS = NOM:NOS_P
     FORMAT_TEKSTS(45,'Arial',18,'',100,100) !100-lai neapgrieþ galu
     NOM_NOS_P1[COUNT#] = F_TEKSTS[1]
     TEKSTS = CLIP(F_TEKSTS[2])&' '&F_TEKSTS[3]
     FORMAT_TEKSTS(45,'Arial',12,'')
     NOM_NOS_P2[COUNT#] = F_TEKSTS[1]
     NOM_NOS_P3[COUNT#] = F_TEKSTS[2]
     NOM_NOS_P4[COUNT#] = F_TEKSTS[3]
