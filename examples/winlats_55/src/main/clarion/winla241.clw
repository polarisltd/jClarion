                     MEMBER('winlats.clw')        ! This is a MEMBER module
S_UZSKAITE           PROCEDURE                    ! Declare Procedure
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
                       PROJECT(NOL:AKCIZE)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:CITAS)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:BAITS)
                       PROJECT(NOL:LOCK)
                       PROJECT(NOL:MUITA)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:RS)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:T_SUMMA)
                       PROJECT(NOL:U_NR)
                       PROJECT(NOL:val)
                     END
!-----------------------------------------------------------------------------
AUTOTEXT            STRING(20)
SKAITS              SHORT
AUTOMARKA           STRING(25)
NOSAUKUMS           STRING(40)
DAT                 LONG
LAI                 LONG

M_TABLE     QUEUE,PRE(M)
KEY           STRING(51)
SKAITS        SHORT
            .

!-----------------------------------------------------------------------------
report REPORT,AT(198,1740,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(198,302,8000,1438)
         STRING(@P<<<#.lapaP),AT(6667,938,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         STRING('SERVISA DARBU UZSKAITE'),AT(2135,313,3698,260),USE(?String17),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1823,52,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1146,0,313),COLOR(COLOR:Black)
         LINE,AT(573,1146,0,313),COLOR(COLOR:Black)
         LINE,AT(1458,1146,0,313),COLOR(COLOR:Black)
         LINE,AT(3229,1146,0,313),COLOR(COLOR:Black)
         LINE,AT(4740,1146,0,313),COLOR(COLOR:Black)
         LINE,AT(7604,1146,0,313),COLOR(COLOR:Black)
         STRING(@D6),AT(2969,573,885,260),USE(S_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4115,573,885,260),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(208,1198,365,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(625,1198,833,208),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Automarka'),AT(1510,1198,1719,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(3281,1198,1458,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(4792,1198,2813,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1406,7448,0),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(156,1146,7448,0),COLOR(COLOR:Black)
         STRING('-'),AT(3854,573,260,260),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,8000,177)
         STRING(@S25),AT(1563,10,1615,156),USE(AUTOMARKA),LEFT 
         STRING(@s21),AT(3333,10,1396,167),USE(NOMENKLAT),LEFT 
         STRING(@S40),AT(4844,10,2708,156),USE(NOSAUKUMS),LEFT 
         LINE,AT(7604,-10,0,198),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(1458,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line9),COLOR(COLOR:Black)
         STRING(@n_4),AT(677,10,625,156),USE(skaits),RIGHT 
         STRING(@N_4),AT(208,10,313,156),CNT,USE(?NPK),RIGHT 
       END
detail1 DETAIL,AT(,-10,,406)
         LINE,AT(156,0,0,52),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(573,0,0,52),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(1458,0,0,52),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(3229,0,0,52),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line15:6),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,52),USE(?Line15:2),COLOR(COLOR:Black)
         LINE,AT(156,52,7448,0),USE(?Line21),COLOR(COLOR:Black)
         STRING(@D6),AT(5208,156),USE(DAT),RIGHT 
         STRING(@T4),AT(6094,156),USE(LAI),RIGHT 
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(156,0,7448,0),USE(?Line21:2),COLOR(COLOR:Black)
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
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Servisa darbu uzskaite'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOL:DATUMS=S_DAT
      SET(NOL:DAT_KEY,NOL:DAT_KEY)
      Process:View{Prop:Filter} = ''
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
        I#=GETPAVADZ(NOL:U_NR)
        M:KEY=Getauto(pav:ved_nr,8)
        M:KEY=M:KEY[1:25]&NOL:NOMENKLAT
        GET(M_TABLE,M:KEY)
        IF ERROR()
           M:SKAITS=NOL:DAUDZUMS
           ADD(M_TABLE)
           SORT(M_TABLE,M:KEY)
        ELSE
           M:SKAITS+=NOL:DAUDZUMS
           PUT(M_TABLE)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=1 TO RECORDS(M_TABLE)
        GET(M_TABLE,I#)
        AUTOMARKA=M:KEY[1:25]
        NOMENKLAT=M:KEY[26:51]
        SKAITS=M:SKAITS
        NOSAUKUMS=GETNOM_K(NOMENKLAT,0,2)
        PRINT(RPT:DETAIL)
    .
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
  IF ERRORCODE() OR NOL:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
S_NOVERT             PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(AUTOAPK)
                       PROJECT(APK:ACC_DATUMS)
                       PROJECT(APK:ACC_KODS)
                       PROJECT(APK:AUT_NR)
                       PROJECT(APK:CTRL_DATUMS)
                       PROJECT(APK:DATUMS)
                       PROJECT(APK:Nobraukums)
                       PROJECT(APK:PAR_NR)
                       PROJECT(APK:PAV_NR)
                       PROJECT(APK:SAVIRZE_A)
                       PROJECT(APK:SAVIRZE_P)
                       PROJECT(APK:TEKSTS)
                     END
!-----------------------------------------------------------------------------
DAT                 LONG
LAI                 LONG
KAROGI_             DECIMAL(3),DIM(73)
KAROGI1             DECIMAL(3),DIM(73)
KAROGI23            DECIMAL(3),DIM(73)
KAROGI3             DECIMAL(3),DIM(73)
!-----------------------------------------------------------------------------
report REPORT,AT(198,1075,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(200,200,8000,875)
         STRING(@s45),AT(1719,52,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6771,365,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         STRING('Transportlîdzekïu tehniskâ stâvokïa novçrtçjuma analîze'),AT(1646,313,4740,240),CENTER, |
             FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(2969,573),USE(S_DAT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4115,573),USE(B_DAT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(3906,573,208,240),USE(?String177),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(-10,,8000,7333)
         LINE,AT(208,417,7292,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('5. Ritoðâs D.pârbaude:'),AT(260,521,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,521,208,156),USE(KAROGI_[1]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,521,208,156),USE(KAROGI1[1]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,521,208,156),USE(KAROGI23[1]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,521,208,156),USE(KAROGI3[1]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3385,417,0,6563),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(3073,417,0,6563),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('5.1. Pr.tilts'),AT(260,677,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2135,417,0,6563),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N3),AT(2188,677,208,156),USE(KAROGI_[2]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,677,208,156),USE(KAROGI1[2]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,677,208,156),USE(KAROGI23[2]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,677,208,156),USE(KAROGI3[2]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.1.1. Pr.Râmja bukse'),AT(260,833,,156) 
         STRING(@N3),AT(2188,833,208,156),USE(KAROGI_[3]),RIGHT 
         STRING(@N3),AT(2500,833,208,156),USE(KAROGI1[3]),RIGHT 
         STRING(@N3),AT(2813,833,208,156),USE(KAROGI23[3]),RIGHT 
         STRING(@N3),AT(3125,833,208,156),USE(KAROGI3[3]),RIGHT 
         STRING('5.1.2. Sviras,lodbalsti,stab.-atsaite'),AT(260,990,,156) 
         STRING(@N3),AT(2188,990,208,156),USE(KAROGI_[4]),RIGHT 
         STRING(@N3),AT(2500,990,208,156),USE(KAROGI1[4]),RIGHT 
         STRING(@N3),AT(2813,990,208,156),USE(KAROGI23[4]),RIGHT 
         STRING(@N3),AT(3125,990,208,156),USE(KAROGI3[4]),RIGHT 
         LINE,AT(208,52,0,6927),USE(?Line3),COLOR(COLOR:Black)
         STRING('5.1.3. Rumbas gultòi'),AT(260,1146,,156) 
         STRING(@N3),AT(2188,1146,208,156),USE(KAROGI_[5]),RIGHT 
         STRING(@N3),AT(2500,1146,208,156),USE(KAROGI1[5]),RIGHT 
         STRING(@N3),AT(2813,1146,208,156),USE(KAROGI23[5]),RIGHT 
         STRING(@N3),AT(3125,1146,208,156),USE(KAROGI3[5]),RIGHT 
         STRING('5.1.4. Pusas put.sargi'),AT(260,1302,,156) 
         STRING(@N3),AT(2188,1302,208,156),USE(KAROGI_[6]),RIGHT 
         STRING(@N3),AT(2500,1302,208,156),USE(KAROGI1[6]),RIGHT 
         STRING(@N3),AT(2813,1302,208,156),USE(KAROGI23[6]),RIGHT 
         STRING(@N3),AT(3125,1302,208,156),USE(KAROGI3[6]),RIGHT 
         STRING('5.1.5. Pr.amort.atbalstbukses'),AT(260,1458,,156) 
         STRING(@N3),AT(2188,1458,208,156),USE(KAROGI_[7]),RIGHT 
         STRING(@N3),AT(2500,1458,208,156),USE(KAROGI1[7]),RIGHT 
         STRING(@N3),AT(2813,1458,208,156),USE(KAROGI23[7]),RIGHT 
         STRING(@N3),AT(3125,1458,208,156),USE(KAROGI3[7]),RIGHT 
         STRING('5.1.6. Pr.amort.put.sargi'),AT(260,1615,,156) 
         STRING(@N3),AT(2188,1615,208,156),USE(KAROGI_[8]),RIGHT 
         STRING(@N3),AT(2500,1615,208,156),USE(KAROGI1[8]),RIGHT 
         STRING(@N3),AT(2813,1615,208,156),USE(KAROGI23[8]),RIGHT 
         STRING(@N3),AT(3125,1615,208,156),USE(KAROGI3[8]),RIGHT 
         STRING('5.2. Stûres iekârta'),AT(260,1771,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,1771,208,156),USE(KAROGI_[9]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,1771,208,156),USE(KAROGI1[9]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,1771,208,156),USE(KAROGI23[9]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,1771,208,156),USE(KAROGI3[9]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.2.1. Stûres ðarnîri'),AT(260,1927,,156) 
         STRING(@N3),AT(2188,1927,208,156),USE(KAROGI_[10]),RIGHT 
         STRING(@N3),AT(2500,1927,208,156),USE(KAROGI1[10]),RIGHT 
         STRING(@N3),AT(2813,1927,208,156),USE(KAROGI23[10]),RIGHT 
         STRING(@N3),AT(3125,1927,208,156),USE(KAROGI3[10]),RIGHT 
         STRING('5.2.2. Stûres meh.'),AT(260,2083,,156) 
         STRING(@N3),AT(2188,2083,208,156),USE(KAROGI_[11]),RIGHT 
         STRING(@N3),AT(2500,2083,208,156),USE(KAROGI1[11]),RIGHT 
         STRING(@N3),AT(2813,2083,208,156),USE(KAROGI23[11]),RIGHT 
         STRING(@N3),AT(3125,2083,208,156),USE(KAROGI3[11]),RIGHT 
         STRING('5.2.3. St.Meh.Put.sargi'),AT(260,2240,,156) 
         STRING(@N3),AT(2188,2240,208,156),USE(KAROGI_[12]),RIGHT 
         STRING(@N3),AT(2500,2240,208,156),USE(KAROGI1[12]),RIGHT 
         STRING(@N3),AT(2813,2240,208,156),USE(KAROGI23[12]),RIGHT 
         STRING(@N3),AT(3125,2240,208,156),USE(KAROGI3[12]),RIGHT 
         STRING('5.2.4. St.statnis,krustiòð'),AT(260,2396,,156) 
         STRING(@N3),AT(2188,2396,208,156),USE(KAROGI_[13]),RIGHT 
         STRING(@N3),AT(2500,2396,208,156),USE(KAROGI1[13]),RIGHT 
         STRING(@N3),AT(2813,2396,208,156),USE(KAROGI23[13]),RIGHT 
         STRING(@N3),AT(3125,2396,208,156),USE(KAROGI3[13]),RIGHT 
         STRING('5.3. Pr.Bremþu iekârta'),AT(260,2552,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,2552,208,156),USE(KAROGI_[14]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,2552,208,156),USE(KAROGI1[14]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,2552,208,156),USE(KAROGI23[14]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,2552,208,156),USE(KAROGI3[14]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.3.1. Pr.br.Ðïauciòas'),AT(260,2708,,156) 
         STRING(@N3),AT(2188,2708,208,156),USE(KAROGI_[15]),RIGHT 
         STRING(@N3),AT(2500,2708,208,156),USE(KAROGI1[15]),RIGHT 
         STRING(@N3),AT(2813,2708,208,156),USE(KAROGI23[15]),RIGHT 
         STRING(@N3),AT(3125,2708,208,156),USE(KAROGI3[15]),RIGHT 
         STRING('5.3.2. Pr.br.uzlikas'),AT(260,2865,,156) 
         STRING(@N3),AT(2188,2865,208,156),USE(KAROGI_[16]),RIGHT 
         STRING(@N3),AT(2500,2865,208,156),USE(KAROGI1[16]),RIGHT 
         STRING(@N3),AT(2813,2865,208,156),USE(KAROGI23[16]),RIGHT 
         STRING(@N3),AT(3125,2865,208,156),USE(KAROGI3[16]),RIGHT 
         STRING('5.3.3. Pr.br.diski'),AT(260,3021,,156) 
         STRING(@N3),AT(2188,3021,208,156),USE(KAROGI_[17]),RIGHT 
         STRING(@N3),AT(2500,3021,208,156),USE(KAROGI1[17]),RIGHT 
         STRING(@N3),AT(2813,3021,208,156),USE(KAROGI23[17]),RIGHT 
         STRING(@N3),AT(3125,3021,208,156),USE(KAROGI3[17]),RIGHT 
         STRING('5.3.4. Pr.br.devçji'),AT(260,3177,,156) 
         STRING(@N3),AT(2188,3177,208,156),USE(KAROGI_[18]),RIGHT 
         STRING(@N3),AT(2500,3177,208,156),USE(KAROGI1[18]),RIGHT 
         STRING(@N3),AT(2813,3177,208,156),USE(KAROGI23[18]),RIGHT 
         STRING(@N3),AT(3125,3177,208,156),USE(KAROGI3[18]),RIGHT 
         STRING('5.3.5. Pr.br.suporti'),AT(260,3333,,156) 
         STRING(@N3),AT(2188,3333,208,156),USE(KAROGI_[19]),RIGHT 
         STRING(@N3),AT(2500,3333,208,156),USE(KAROGI1[19]),RIGHT 
         STRING(@N3),AT(2813,3333,208,156),USE(KAROGI23[19]),RIGHT 
         STRING(@N3),AT(3125,3333,208,156),USE(KAROGI3[19]),RIGHT 
         STRING('5.4. Transmisija'),AT(260,3490,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,3490,208,156),USE(KAROGI_[20]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,3490,208,156),USE(KAROGI1[20]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,3490,208,156),USE(KAROGI23[20]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,3490,208,156),USE(KAROGI3[20]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.4.1. Dzinçja,kârbas spilveni'),AT(260,3646,,156) 
         STRING(@N3),AT(2188,3646,208,156),USE(KAROGI_[21]),RIGHT 
         STRING(@N3),AT(2500,3646,208,156),USE(KAROGI1[21]),RIGHT 
         STRING(@N3),AT(2813,3646,208,156),USE(KAROGI23[21]),RIGHT 
         STRING(@N3),AT(3125,3646,208,156),USE(KAROGI3[21]),RIGHT 
         STRING('5.4.2. Kardâna krust.,piekares gultnis'),AT(260,3802,,156) 
         STRING(@N3),AT(2188,3802,208,156),USE(KAROGI_[22]),RIGHT 
         STRING(@N3),AT(2500,3802,208,156),USE(KAROGI1[22]),RIGHT 
         STRING(@N3),AT(2813,3802,208,156),USE(KAROGI23[22]),RIGHT 
         STRING(@N3),AT(3125,3802,208,156),USE(KAROGI3[22]),RIGHT 
         STRING('5.4.3. Reduktors,spilvens,bukses'),AT(260,3958,,156) 
         STRING(@N3),AT(2188,3958,208,156),USE(KAROGI_[23]),RIGHT 
         STRING(@N3),AT(2500,3958,208,156),USE(KAROGI1[23]),RIGHT 
         STRING(@N3),AT(2813,3958,208,156),USE(KAROGI23[23]),RIGHT 
         STRING(@N3),AT(3125,3958,208,156),USE(KAROGI3[23]),RIGHT 
         STRING('5.5. Aizm.tilts'),AT(260,4115,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,4115,208,156),USE(KAROGI_[24]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,4115,208,156),USE(KAROGI1[24]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,4115,208,156),USE(KAROGI23[24]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,4115,208,156),USE(KAROGI3[24]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.5.1. Aizm.tilta,râmja bukses'),AT(260,4271,,156) 
         STRING(@N3),AT(2188,4271,208,156),USE(KAROGI_[25]),RIGHT 
         STRING(@N3),AT(2500,4271,208,156),USE(KAROGI1[25]),RIGHT 
         STRING(@N3),AT(2813,4271,208,156),USE(KAROGI23[25]),RIGHT 
         STRING(@N3),AT(3125,4271,208,156),USE(KAROGI3[25]),RIGHT 
         STRING('5.5.2. Sviras,lodbalsti,stab.-atsaite'),AT(260,4427,,156) 
         STRING(@N3),AT(2188,4427,208,156),USE(KAROGI_[26]),RIGHT 
         STRING(@N3),AT(2500,4427,208,156),USE(KAROGI1[26]),RIGHT 
         STRING(@N3),AT(2813,4427,208,156),USE(KAROGI23[26]),RIGHT 
         STRING(@N3),AT(3125,4427,208,156),USE(KAROGI3[26]),RIGHT 
         STRING('5.5.3. Rumbas gultòi'),AT(260,4583,,156) 
         STRING(@N3),AT(2188,4583,208,156),USE(KAROGI_[27]),RIGHT 
         STRING(@N3),AT(2500,4583,208,156),USE(KAROGI1[27]),RIGHT 
         STRING(@N3),AT(2813,4583,208,156),USE(KAROGI23[27]),RIGHT 
         STRING(@N3),AT(3125,4583,208,156),USE(KAROGI3[27]),RIGHT 
         STRING('5.5.4. Pusas put.sargi'),AT(260,4740,,156) 
         STRING(@N3),AT(2188,4740,208,156),USE(KAROGI_[28]),RIGHT 
         STRING(@N3),AT(2500,4740,208,156),USE(KAROGI1[28]),RIGHT 
         STRING(@N3),AT(2813,4740,208,156),USE(KAROGI23[28]),RIGHT 
         STRING(@N3),AT(3125,4740,208,156),USE(KAROGI3[28]),RIGHT 
         STRING('5.5.5. Aizm.amort.atbalstbukses'),AT(260,4896,,156) 
         STRING(@N3),AT(2188,4896,208,156),USE(KAROGI_[29]),RIGHT 
         STRING(@N3),AT(2500,4896,208,156),USE(KAROGI1[29]),RIGHT 
         STRING(@N3),AT(2813,4896,208,156),USE(KAROGI23[29]),RIGHT 
         STRING(@N3),AT(3125,4896,208,156),USE(KAROGI3[29]),RIGHT 
         STRING('5.5.6. Aizm.amort.put.sargi'),AT(260,5052,,156) 
         STRING(@N3),AT(2188,5052,208,156),USE(KAROGI_[30]),RIGHT 
         STRING(@N3),AT(2500,5052,208,156),USE(KAROGI1[30]),RIGHT 
         STRING(@N3),AT(2813,5052,208,156),USE(KAROGI23[30]),RIGHT 
         STRING(@N3),AT(3125,5052,208,156),USE(KAROGI3[30]),RIGHT 
         STRING('5.6. Aizm.br.iekârta'),AT(260,5208,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,5208,208,156),USE(KAROGI_[31]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,5208,208,156),USE(KAROGI1[31]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,5208,208,156),USE(KAROGI23[31]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,5208,208,156),USE(KAROGI3[31]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5.6.1. Aizm.br.Ðïauciòas'),AT(260,5365,,156) 
         STRING(@N3),AT(2188,5365,208,156),USE(KAROGI_[32]),RIGHT 
         STRING(@N3),AT(2500,5365,208,156),USE(KAROGI1[32]),RIGHT 
         STRING(@N3),AT(2813,5365,208,156),USE(KAROGI23[32]),RIGHT 
         STRING(@N3),AT(3125,5365,208,156),USE(KAROGI3[32]),RIGHT 
         STRING('5.6.2. Aizm.br.uzlikas'),AT(260,5521,,156) 
         STRING(@N3),AT(2188,5521,208,156),USE(KAROGI_[33]),RIGHT 
         STRING(@N3),AT(2500,5521,208,156),USE(KAROGI1[33]),RIGHT 
         STRING(@N3),AT(2813,5521,208,156),USE(KAROGI23[33]),RIGHT 
         STRING(@N3),AT(3125,5521,208,156),USE(KAROGI3[33]),RIGHT 
         STRING('5.6.3. Aizm.br.diski,trumuïi'),AT(260,5677,,156) 
         STRING(@N3),AT(2188,5677,208,156),USE(KAROGI_[34]),RIGHT 
         STRING(@N3),AT(2500,5677,208,156),USE(KAROGI1[34]),RIGHT 
         STRING(@N3),AT(2813,5677,208,156),USE(KAROGI23[34]),RIGHT 
         STRING(@N3),AT(3125,5677,208,156),USE(KAROGI3[34]),RIGHT 
         STRING('5.6.4. Aizm.br.devçji'),AT(260,5833,,156) 
         STRING(@N3),AT(2188,5833,208,156),USE(KAROGI_[35]),RIGHT 
         STRING(@N3),AT(2500,5833,208,156),USE(KAROGI1[35]),RIGHT 
         STRING(@N3),AT(2813,5833,208,156),USE(KAROGI23[35]),RIGHT 
         STRING(@N3),AT(3125,5833,208,156),USE(KAROGI3[35]),RIGHT 
         STRING('5.6.5. Aizm.br.suporti'),AT(260,5990,,156) 
         STRING(@N3),AT(2188,5990,208,156),USE(KAROGI_[36]),RIGHT 
         STRING(@N3),AT(2500,5990,208,156),USE(KAROGI1[36]),RIGHT 
         STRING(@N3),AT(2813,5990,208,156),USE(KAROGI23[36]),RIGHT 
         STRING(@N3),AT(3125,5990,208,156),USE(KAROGI3[36]),RIGHT 
         STRING('5.6.6. Stâvbremze'),AT(260,6146,,156) 
         STRING(@N3),AT(2188,6146,208,156),USE(KAROGI_[37]),RIGHT 
         STRING(@N3),AT(2500,6146,208,156),USE(KAROGI1[37]),RIGHT 
         STRING(@N3),AT(2813,6146,208,156),USE(KAROGI23[37]),RIGHT 
         STRING(@N3),AT(3125,6146,208,156),USE(KAROGI3[37]),RIGHT 
         STRING('6. Izplûdes sist.'),AT(260,6302,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,6302,208,156),USE(KAROGI_[38]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,6302,208,156),USE(KAROGI1[38]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,6302,208,156),USE(KAROGI23[38]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,6302,208,156),USE(KAROGI3[38]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6.1. Izplûdes sist.korozija'),AT(260,6458,,156) 
         STRING(@N3),AT(2188,6458,208,156),USE(KAROGI_[39]),RIGHT 
         STRING(@N3),AT(2500,6458,208,156),USE(KAROGI1[39]),RIGHT 
         STRING(@N3),AT(2813,6458,208,156),USE(KAROGI23[39]),RIGHT 
         STRING(@N3),AT(3125,6458,208,156),USE(KAROGI3[39]),RIGHT 
         STRING('6.2. Stiprinâjumi,bojâjumi'),AT(260,6615,,156),USE(?String42) 
         STRING(@N3),AT(2188,6615,208,156),USE(KAROGI_[40]),RIGHT 
         STRING(@N3),AT(2500,6615,208,156),USE(KAROGI1[40]),RIGHT 
         STRING(@N3),AT(2813,6615,208,156),USE(KAROGI23[40]),RIGHT 
         STRING(@N3),AT(3125,6615,208,156),USE(KAROGI3[40]),RIGHT 
         STRING('7. Mehâniski bojâjumi,korozija'),AT(260,6771,,156),USE(?String43),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2188,6771,208,156),USE(KAROGI_[41]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2500,6771,208,156),USE(KAROGI1[41]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(2813,6771,208,156),USE(KAROGI23[41]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(3125,6771,208,156),USE(KAROGI3[41]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,6979,7292,0),USE(?Line9),COLOR(COLOR:Black)
         STRING(@T4),AT(6875,7083),USE(LAI),RIGHT 
         STRING(@D6),AT(6146,7083),USE(DAT),RIGHT 
         STRING('8. Eïïu noplûde'),AT(4531,521,,156),USE(?String44),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,521,208,156),USE(KAROGI_[42]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,521,208,156),USE(KAROGI1[42]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,521,208,156),USE(KAROGI23[42]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,521,208,156),USE(KAROGI3[42]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6875,417,0,6563),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(6563,417,0,6563),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(2448,417,0,6563),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(6250,417,0,6563),USE(?Line3:4),COLOR(COLOR:Black)
         STRING('8.1. Dzinçjs'),AT(4531,677,,156),USE(?String45) 
         STRING(@N3),AT(6302,677,208,156),USE(KAROGI_[43]),RIGHT 
         STRING(@N3),AT(6615,677,208,156),USE(KAROGI1[43]),RIGHT 
         STRING(@N3),AT(6927,677,208,156),USE(KAROGI23[43]),RIGHT 
         STRING(@N3),AT(7240,677,208,156),USE(KAROGI3[43]),RIGHT 
         LINE,AT(7188,417,0,6563),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(2760,417,0,6563),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(7500,52,0,6927),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('8.2. Kârba,sad.kârba'),AT(4531,833,,156),USE(?String46) 
         STRING(@N3),AT(6302,833,208,156),USE(KAROGI_[44]),RIGHT 
         STRING(@N3),AT(6615,833,208,156),USE(KAROGI1[44]),RIGHT 
         STRING(@N3),AT(6927,833,208,156),USE(KAROGI23[44]),RIGHT 
         STRING(@N3),AT(7240,833,208,156),USE(KAROGI3[44]),RIGHT 
         STRING('8.3. Reduktors'),AT(4531,990,,156),USE(?String47) 
         STRING(@N3),AT(6302,990,208,156),USE(KAROGI_[45]),RIGHT 
         STRING(@N3),AT(6615,990,208,156),USE(KAROGI1[45]),RIGHT 
         STRING(@N3),AT(6927,990,208,156),USE(KAROGI23[45]),RIGHT 
         STRING(@N3),AT(7240,990,208,156),USE(KAROGI3[45]),RIGHT 
         STRING('9. Siksnas'),AT(4531,1146,,156),USE(?String48),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,1146,208,156),USE(KAROGI_[46]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,1146,208,156),USE(KAROGI1[46]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,1146,208,156),USE(KAROGI23[46]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,1146,208,156),USE(KAROGI3[46]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,52,7292,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('9.1. Ìeneratora siksna'),AT(4531,1302,,156),USE(?String49) 
         STRING(@N3),AT(6302,1302,208,156),USE(KAROGI_[47]),RIGHT 
         STRING(@N3),AT(6615,1302,208,156),USE(KAROGI1[47]),RIGHT 
         STRING(@N3),AT(6927,1302,208,156),USE(KAROGI23[47]),RIGHT 
         STRING(@N3),AT(7240,1302,208,156),USE(KAROGI3[47]),RIGHT 
         STRING('9.2. Agregâtsiksnas'),AT(4531,1458,,156),USE(?String50) 
         STRING(@N3),AT(6302,1458,208,156),USE(KAROGI_[48]),RIGHT 
         STRING(@N3),AT(6615,1458,208,156),USE(KAROGI1[48]),RIGHT 
         STRING(@N3),AT(6927,1458,208,156),USE(KAROGI23[48]),RIGHT 
         STRING(@N3),AT(7240,1458,208,156),USE(KAROGI3[48]),RIGHT 
         STRING('10. Riepas'),AT(4531,1615,,156),USE(?String51),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,1615,208,156),USE(KAROGI_[49]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,1615,208,156),USE(KAROGI1[49]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,1615,208,156),USE(KAROGI23[49]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,1615,208,156),USE(KAROGI3[49]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10.1. Protektors'),AT(4531,1771,,156),USE(?String52) 
         STRING(@N3),AT(6302,1771,208,156),USE(KAROGI_[50]),RIGHT 
         STRING(@N3),AT(6615,1771,208,156),USE(KAROGI1[50]),RIGHT 
         STRING(@N3),AT(6927,1771,208,156),USE(KAROGI23[50]),RIGHT 
         STRING(@N3),AT(7240,1771,208,156),USE(KAROGI3[50]),RIGHT 
         STRING('10.2. Bojâjumi'),AT(4531,1927,,156),USE(?String53) 
         STRING(@N3),AT(6302,1927,208,156),USE(KAROGI_[51]),RIGHT 
         STRING(@N3),AT(6615,1927,208,156),USE(KAROGI1[51]),RIGHT 
         STRING(@N3),AT(6927,1927,208,156),USE(KAROGI23[51]),RIGHT 
         STRING(@N3),AT(7240,1927,208,156),USE(KAROGI3[51]),RIGHT 
         STRING('11. Gaismas ierîces'),AT(4531,2083,,156),USE(?String54),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,2083,208,156),USE(KAROGI_[52]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,2083,208,156),USE(KAROGI1[52]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,2083,208,156),USE(KAROGI23[52]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,2083,208,156),USE(KAROGI3[52]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11.1. Gabarîti'),AT(4531,2240,,156),USE(?String55) 
         STRING(@N3),AT(6302,2240,208,156),USE(KAROGI_[53]),RIGHT 
         STRING(@N3),AT(6615,2240,208,156),USE(KAROGI1[53]),RIGHT 
         STRING(@N3),AT(6927,2240,208,156),USE(KAROGI23[53]),RIGHT 
         STRING(@N3),AT(7240,2240,208,156),USE(KAROGI3[53]),RIGHT 
         STRING('11.2. Tuvie'),AT(4531,2396,,156),USE(?String56) 
         STRING(@N3),AT(6302,2396,208,156),USE(KAROGI_[54]),RIGHT 
         STRING(@N3),AT(6615,2396,208,156),USE(KAROGI1[54]),RIGHT 
         STRING(@N3),AT(6927,2396,208,156),USE(KAROGI23[54]),RIGHT 
         STRING(@N3),AT(7240,2396,208,156),USE(KAROGI3[54]),RIGHT 
         STRING('11.3. Tâlie'),AT(4531,2552,,156),USE(?String57) 
         STRING(@N3),AT(6302,2552,208,156),USE(KAROGI_[55]),RIGHT 
         STRING(@N3),AT(6615,2552,208,156),USE(KAROGI1[55]),RIGHT 
         STRING(@N3),AT(6927,2552,208,156),USE(KAROGI23[55]),RIGHT 
         STRING(@N3),AT(7240,2552,208,156),USE(KAROGI3[55]),RIGHT 
         STRING('11.4. Pr.miglas'),AT(4531,2708,,156),USE(?String58) 
         STRING(@N3),AT(6302,2708,208,156),USE(KAROGI_[56]),RIGHT 
         STRING(@N3),AT(6615,2708,208,156),USE(KAROGI1[56]),RIGHT 
         STRING(@N3),AT(6927,2708,208,156),USE(KAROGI23[56]),RIGHT 
         STRING(@N3),AT(7240,2708,208,156),USE(KAROGI3[56]),RIGHT 
         STRING('11.5. Virzienrâdîtâji'),AT(4531,2865,,156),USE(?String59) 
         STRING(@N3),AT(6302,2865,208,156),USE(KAROGI_[57]),RIGHT 
         STRING(@N3),AT(6615,2865,208,156),USE(KAROGI1[57]),RIGHT 
         STRING(@N3),AT(6927,2865,208,156),USE(KAROGI23[57]),RIGHT 
         STRING(@N3),AT(7240,2865,208,156),USE(KAROGI3[57]),RIGHT 
         STRING('11.6. Br.signâli'),AT(4531,3021,,156),USE(?String60) 
         STRING(@N3),AT(6302,3021,208,156),USE(KAROGI_[58]),RIGHT 
         STRING(@N3),AT(6615,3021,208,156),USE(KAROGI1[58]),RIGHT 
         STRING(@N3),AT(6927,3021,208,156),USE(KAROGI23[58]),RIGHT 
         STRING(@N3),AT(7240,3021,208,156),USE(KAROGI3[58]),RIGHT 
         STRING('11.7. Atpakaïgaita'),AT(4531,3177,,156),USE(?String61) 
         STRING(@N3),AT(6302,3177,208,156),USE(KAROGI_[59]),RIGHT 
         STRING(@N3),AT(6615,3177,208,156),USE(KAROGI1[59]),RIGHT 
         STRING(@N3),AT(6927,3177,208,156),USE(KAROGI23[59]),RIGHT 
         STRING(@N3),AT(7240,3177,208,156),USE(KAROGI3[59]),RIGHT 
         STRING('11.8. Aizm.miglas'),AT(4531,3333,,156),USE(?String62) 
         STRING(@N3),AT(6302,3333,208,156),USE(KAROGI_[60]),RIGHT 
         STRING(@N3),AT(6615,3333,208,156),USE(KAROGI1[60]),RIGHT 
         STRING(@N3),AT(6927,3333,208,156),USE(KAROGI23[60]),RIGHT 
         STRING(@N3),AT(7240,3333,208,156),USE(KAROGI3[60]),RIGHT 
         STRING('11.9. Nummurapg.'),AT(4531,3490,,156),USE(?String63) 
         STRING(@N3),AT(6302,3490,208,156),USE(KAROGI_[61]),RIGHT 
         STRING(@N3),AT(6615,3490,208,156),USE(KAROGI1[61]),RIGHT 
         STRING(@N3),AT(6927,3490,208,156),USE(KAROGI23[61]),RIGHT 
         STRING(@N3),AT(7240,3490,208,156),USE(KAROGI3[61]),RIGHT 
         STRING('12. Aprîkojums'),AT(4531,3646,,156),USE(?String64),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,3646,208,156),USE(KAROGI_[62]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,3646,208,156),USE(KAROGI1[62]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,3646,208,156),USE(KAROGI23[62]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,3646,208,156),USE(KAROGI3[62]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12.1. Vçjstiklu tîrîtâji'),AT(4531,3802,,156),USE(?String65) 
         STRING(@N3),AT(6302,3802,208,156),USE(KAROGI_[63]),RIGHT 
         STRING(@N3),AT(6615,3802,208,156),USE(KAROGI1[63]),RIGHT 
         STRING(@N3),AT(6927,3802,208,156),USE(KAROGI23[63]),RIGHT 
         STRING(@N3),AT(7240,3802,208,156),USE(KAROGI3[63]),RIGHT 
         STRING('12.2. Skaòas signâli'),AT(4531,3958,,156),USE(?String66) 
         STRING(@N3),AT(6302,3958,208,156),USE(KAROGI_[64]),RIGHT 
         STRING(@N3),AT(6615,3958,208,156),USE(KAROGI1[64]),RIGHT 
         STRING(@N3),AT(6927,3958,208,156),USE(KAROGI23[64]),RIGHT 
         STRING(@N3),AT(7240,3958,208,156),USE(KAROGI3[64]),RIGHT 
         STRING('12.3. Atpakaïgaitas spogulis'),AT(4531,4115,,156),USE(?String67) 
         STRING(@N3),AT(6302,4115,208,156),USE(KAROGI_[65]),RIGHT 
         STRING(@N3),AT(6615,4115,208,156),USE(KAROGI1[65]),RIGHT 
         STRING(@N3),AT(6927,4115,208,156),USE(KAROGI23[65]),RIGHT 
         STRING(@N3),AT(7240,4115,208,156),USE(KAROGI3[65]),RIGHT 
         STRING('13. Atgâzes,dûmainîba'),AT(4531,4271,,156),USE(?String68),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,4271,208,156),USE(KAROGI_[66]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,4271,208,156),USE(KAROGI1[66]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,4271,208,156),USE(KAROGI23[66]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,4271,208,156),USE(KAROGI3[66]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14. Akumolators'),AT(4531,4427,,156),USE(?String69),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,4427,208,156),USE(KAROGI_[67]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,4427,208,156),USE(KAROGI1[67]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,4427,208,156),USE(KAROGI23[67]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,4427,208,156),USE(KAROGI3[67]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15. Dzesçðanas ðíidrums'),AT(4531,4583,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,4583,208,156),USE(KAROGI_[68]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,4583,208,156),USE(KAROGI1[68]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,4583,208,156),USE(KAROGI23[68]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,4583,208,156),USE(KAROGI3[68]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16. Logu ðíidrums'),AT(4531,4740,,156),USE(?String71),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,4740,208,156),USE(KAROGI_[69]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,4740,208,156),USE(KAROGI1[69]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,4740,208,156),USE(KAROGI23[69]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,4740,208,156),USE(KAROGI3[69]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('17. Bremþu ðí.'),AT(4531,4896,,156),USE(?String72),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,4896,208,156),USE(KAROGI_[70]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,4896,208,156),USE(KAROGI1[70]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,4896,208,156),USE(KAROGI23[70]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,4896,208,156),USE(KAROGI3[70]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('18. Lukturu lîmenis'),AT(4531,5052,,156),USE(?String73),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,5052,208,156),USE(KAROGI_[71]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,5052,208,156),USE(KAROGI1[71]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,5052,208,156),USE(KAROGI23[71]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,5052,208,156),USE(KAROGI3[71]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('19. Vizuâlais apskats'),AT(4531,5208,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,5208,208,156),USE(KAROGI_[72]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,5208,208,156),USE(KAROGI1[72]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,5208,208,156),USE(KAROGI23[72]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,5208,208,156),USE(KAROGI3[72]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('20. Akumolatora stirpinâjums'),AT(4531,5365,,156),USE(?String75),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6302,5365,208,156),USE(KAROGI_[73]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6615,5365,208,156),USE(KAROGI1[73]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(6927,5365,208,156),USE(KAROGI23[73]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N3),AT(7240,5365,208,156),USE(KAROGI3[73]),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail1 DETAIL
         STRING('1. Kontrolbrauciens:'),AT(635,542,,156),USE(?String103),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2.Savirze: pr.'),AT(2146,542,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-6.2),AT(2927,542,310,156),USE(APK:SAVIRZE_P) 
         STRING('3.Amortizatori: pr.'),AT(3344,542,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-4.0),AT(4438,542,310,156),USE(APK:AMORT_P[1]) 
         STRING(@n-4.0),AT(4750,542,310,156),USE(APK:AMORT_P[2]) 
         STRING('4.Bremzes: pr.'),AT(5167,542,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-5.1),AT(6052,542,310,156),USE(APK:BREMZES_P[1]) 
         STRING(@n-5.1),AT(6365,542,310,156),USE(APK:BREMZES_P[2]) 
         STRING(@n-6.2),AT(2927,698,310,156),USE(APK:SAVIRZE_A) 
         STRING('aizm.'),AT(4073,698,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-4.0),AT(4438,698,310,156),USE(APK:AMORT_A[1]) 
         STRING(@n-4.0),AT(4750,698,310,156),USE(APK:AMORT_A[2]) 
         STRING('aizm.'),AT(5688,698,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-5.1),AT(6052,698,310,156),USE(APK:BREMZES_A[1]) 
         STRING(@n-5.1),AT(6365,698,310,156),USE(APK:BREMZES_A[2]) 
         STRING('aizm.'),AT(2573,729,,156),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(200,9000,8000,219)
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
  DAT = TODAY()
  LAI = CLOCK()
  CLEAR(KAROGI_)
  CLEAR(KAROGI1)
  CLEAR(KAROGI23)
  CLEAR(KAROGI3)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  FilesOpened = True
  RecordsToProcess = RECORDS(AUTOAPK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTOAPK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(APK:RECORD)
      APK:DATUMS=S_DAT
      SET(APK:DAT_KEY,APK:DAT_KEY)
      Process:View{Prop:Filter} = ''
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
            LOOP I#=1 TO 73
                IF APK:KAROGI[I#]=' '
                    KAROGI_[I#]+=1
                ELSIF APK:KAROGI[I#]='1'
                    KAROGI1[I#]+=1
                ELSIF APK:KAROGI[I#]='2' OR APK:KAROGI[I#]='3'
                    KAROGI23[I#]+=1
                ELSIF APK:KAROGI[I#]='3'
                    KAROGI3[I#]+=1
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
  IF SEND(AUTOAPK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:detail)
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
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
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  PREVIOUS(Process:View)
  IF ERRORCODE() OR APK:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
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
CHECKServiss         FUNCTION (Pav_NR,AUTO_NR)    ! Declare Procedure
  CODE                                            ! Begin processed code
  IF Pav_NR=0
     return(0)
  ELSE
     IF AUTOAPK::USED=0
        CHECKOPEN(AUTOAPK,1)
     .
     AUTOAPK::USED+=1
     CLEAR(APK:RECORD)
     APK:PAV_NR=PAV_NR
     GET(AUTOAPK,APK:PAV_KEY)
     IF ~ERROR()
        IF AUTO_NR AND ~(AUTO_NR=APK:AUT_NR) !ja p/z nofiksçta a/m,bet servisâ vçl nav
           APK:AUT_NR=AUTO_NR
           IF RIUPDATE:AUTOAPK()
              KLUDA(24,'AUTOAPK')
           .
        .
        RET#=1
     ELSE
        RET#=0
     .
  .
  AUTOAPK::USED-=1
  IF AUTOAPK::USED=0
     CLOSE(AUTOAPK)
  .
  EXECUTE RET#+1
     RETURN(0)
     RETURN(1)
  .
