                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_R309               PROCEDURE                    ! Declare Procedure
DATUMS               LONG
LAI                  LONG
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
Process:View         VIEW(NOM_K)
                       PROJECT(NOMENKLAT)
                       PROJECT(EAN)
                       PROJECT(KODS)
                       PROJECT(BKK)
                       PROJECT(NOS_P)
                       PROJECT(NOS_S)
                       PROJECT(MERVIEN)
                       PROJECT(SVARSKG)
                       PROJECT(TIPS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(302,1698,8000,9448),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
       HEADER,AT(302,302,8000,1396)
         STRING(@s45),AT(1823,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold)
         STRING('IZZIÒA PÇC RÎKOJUMA Nr 309'),AT(2344,417,3333,260),USE(?String2),CENTER,FONT(,12,,FONT:bold)
         STRING('uz'),AT(3177,677),USE(?String4),FONT(,12,,FONT:bold)
         STRING(@d6),AT(3438,677),USE(datums),RIGHT,FONT(,12,,FONT:bold)
         STRING('"Apstiprinu"'),AT(6510,365),USE(?String6),CENTER,FONT(,10,,FONT:bold)
         LINE,AT(6250,885,1510,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(313,1094,6667,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(1615,1094,0,313),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(3542,1094,0,313),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(6979,1094,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         STRING('Kods'),AT(365,1146,1250,208),USE(?String7),CENTER,FONT(,9,,FONT:bold)
         STRING('Nosaukums saîsinâtais'),AT(1667,1146,1875,208),USE(?String7:2),CENTER,FONT(,9,,FONT:bold)
         STRING('Nosaukums pilns'),AT(3594,1146,3385,208),USE(?String7:3),CENTER,FONT(,9,,FONT:bold)
         LINE,AT(313,1354,6667,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(313,1094,0,313),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(6979,-10,0,198),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@S50),AT(3646,10,3333,156),USE(NOM:NOS_P),LEFT,FONT(,8,,)
         LINE,AT(3542,-10,0,198),USE(?Line3:7),COLOR(COLOR:Black)
         STRING(@S20),AT(1823,10,1719,156),USE(NOM:NOS_S),LEFT,FONT(,8,,)
         LINE,AT(1615,-10,0,198),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(313,-10,0,198),USE(?Line3:5),COLOR(COLOR:Black)
         STRING(@N_13),AT(573,10,,156),USE(NOM:KODS),RIGHT,FONT(,8,,)
       END
RPT_FOOT DETAIL,AT(,,,417)
         LINE,AT(6979,-10,0,63),USE(?Line12:4),COLOR(COLOR:Black)
         STRING('RS :'),AT(1979,156),USE(?String13:2),FONT(,8,,)
         STRING(@s1),AT(2188,156),USE(RS),CENTER,FONT(,8,,)
         STRING(@D6),AT(4948,156),USE(DATUMS,,?DATUMS:2),RIGHT,FONT(,8,,)
         STRING(@T4),AT(5885,156),USE(LAI),RIGHT,FONT(,8,,)
         LINE,AT(313,52,6667,0),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Sastâdîja:'),AT(573,156),USE(?String13),FONT(,8,,)
         STRING(@s8),AT(1094,156),USE(ACC_kods),LEFT,FONT(,8,,)
         LINE,AT(3542,-10,0,63),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,63),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(313,-10,0,63),USE(?Line12),COLOR(COLOR:Black)
       END
       FOOTER,AT(302,11000,8000,240)
         STRING(@P<<<#. lapaP),AT(6094,52),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,)
         LINE,AT(313,0,6667,0),USE(?Line2:4),COLOR(COLOR:Black)
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
  BIND('CYCLENOM',CYCLENOM)
  BIND('F:KRI',F:KRI)        !!!! Razobratjsa s etimi
  BIND('F:PAK',F:PAK)        !!!! Razobratjsa s etimi   !!!Ne uchtena Cena>0 i jâsûta uz KA (IDP)
  BIND('JOB_NR',JOB_NR)
  datums = today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Rîkojums Nr 309'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nom:RECORD)                              !MAKE SURE RECORD CLEARED
      NOM:NOMENKLAT = NOMENKLAT
      CASE F:SECIBA
      OF 'N'
        SET(nom:nom_key,nom:nom_key)                             !  POINT TO FIRST RECORD
      OF 'K'
        SET(nom:KOD_key,nom:KOD_key)                             !  POINT TO FIRST RECORD
      OF 'A'
        SET(nom:NOS_key,nom:NOS_key)                             !  POINT TO FIRST RECORD
      ELSE
        STOP('F:SECIBA')
      .
      Process:View{Prop:Filter} = '(~F:KRI OR NOM:ATLIKUMS[job_NR]>=0) AND (F:PAK OR ~NOM:TIPS=''A'')'
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:RPT_FOOT)
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
  NEXT(Process:View)
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)
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
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nom_k)                          !  READ UNTIL END OF FILE
    NEXT(nom_k)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
    IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.          !FILTRS PðC NOMENKLATÞTAS
    IF F:KRI AND NOM:ATLIKUMS[SYS:AVOTA_NR]<=0 THEN CYCLE.
    IF ~F:PAK AND NOM:TIPS='A' THEN CYCLE.
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
N_KriAtl             PROCEDURE                    ! Declare Procedure
DAT                  LONG
LAI                  LONG
FILTRS_TEXT          STRING(100)
NOM_KRIT_LS          DECIMAL(11,2)
NOM_MAX_LS           DECIMAL(11,2)
NOM_JAP_LS           DECIMAL(11,2)
NOM_JAP_LSK          DECIMAL(11,2)
ATLIKUMS             DECIMAL(12,3)
ATLIKUMS_LS          DECIMAL(11,2)
JAPASUTA             DECIMAL(12,3)
VIRSRAKSTS           STRING(100)
ATLIKUMS_TEX         STRING(25)
Faktiskais           STRING(10)
KRIT_DAU             DECIMAL(7,2)
MAX_DAU              DECIMAL(7,2)

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR  LIKE(PAV:U_NR)
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
Process:View         VIEW(NOM_K)
                       PROJECT(NOMENKLAT)
                       PROJECT(EAN)
                       PROJECT(KODS)
                       PROJECT(BKK)
                       PROJECT(NOS_P)
                       PROJECT(NOS_S)
                       PROJECT(MERVIEN)
                       PROJECT(SVARSKG)
                       PROJECT(TIPS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(0,2052,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS                !2052=500+1552
       HEADER,AT(0,500,12000,1563),USE(?unnamed)
         STRING(@s100),AT(1823,719,7583,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3281,104,4792,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(2615,417,6135,198),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10344,781),PAGENO,USE(?PageCount),RIGHT,FONT(,9,,,CHARSET:ANSI)
         LINE,AT(313,990,11145,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1979,990,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4479,990,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(11458,990,0,552),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7000,1000,0,552),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(9521,1000,0,552),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(344,1042,1615,208),USE(?String7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(7240,1052,2094,208),USE(ATLIKUMS_TEX),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2219,1146,1969,208),USE(?String7:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums (daudzums)'),AT(5010,1021,1417,208),USE(?String7:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4479,1250,2510,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(5323,1250,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6146,1250,0,313),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@s21),AT(354,1281),USE(NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kritiskais'),AT(4510,1292,781,208),USE(?String7:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(6188,1292,781,208),USE(Faktiskais),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kritiskais'),AT(7031,1281,781,208),USE(?String7:7),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksimâlais'),AT(7865,1281,781,208),USE(?String7:4),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(8708,1281,781,208),USE(Faktiskais,,?FAKTISKAIS:1),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksimâlais'),AT(5344,1292,781,208),USE(?String7:44),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Jâpasûta(max),'),AT(9677,1063,1250,208),USE(?String7:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(9688,1281,1250,208),USE(val_uzsk),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7010,1250,2510,0),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(7823,1260,0,313),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(8677,1260,0,313),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(313,1531,11145,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(313,990,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,10,11740,188),USE(?unnamed:3)
         LINE,AT(1979,0,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s40),AT(2010,10,2448,156),USE(NOM:NOS_P),LEFT
         LINE,AT(4479,0,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(4510,10,781,156),USE(KRIT_DAU,,?KRIT_DAU:2),RIGHT
         LINE,AT(5323,0,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(6188,10,792,156),USE(ATLIKUMS),RIGHT
         STRING(@N-_10.2B),AT(7021,10,781,156),USE(NOM_KRIT_LS),TRN,RIGHT
         STRING(@N-_10.2B),AT(7865,10,781,156),USE(NOM_MAX_LS),TRN,RIGHT
         STRING(@N-_10.2),AT(8708,10,792,156),USE(ATLIKUMS_LS),TRN,RIGHT
         LINE,AT(7000,0,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(9521,0,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@s7),AT(10229,10,521,156),USE(NOM:MERVIEN),LEFT
         STRING(@N-_10.2B),AT(10750,10,688,156),USE(NOM_JAP_LS),TRN,RIGHT
         STRING(@N-_11.3B),AT(9542,10,688,156),USE(japasuta),RIGHT
         LINE,AT(6146,0,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(11458,0,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7823,0,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(8677,0,0,198),USE(?Line2:151),COLOR(COLOR:Black)
         STRING(@N-_11.3),AT(5344,10,781,156),USE(MAX_DAU),TRN,RIGHT
         LINE,AT(313,0,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s21),AT(344,10,1615,156),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
detailK DETAIL,AT(,10,11740,250),USE(?unnamed:5)
         LINE,AT(1979,0,0,250),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,250),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5323,0,0,250),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(7000,0,0,250),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(9521,0,0,250),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(10594,73,844,156),USE(NOM_JAP_LSK),TRN,RIGHT
         STRING('Kopâ:'),AT(417,42),USE(?String42),TRN
         LINE,AT(6146,0,0,250),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(11458,0,0,250),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(313,10,11145,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7823,0,0,250),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(8677,0,0,250),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(313,0,0,250),USE(?Line2:28),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,11792,219),USE(?unnamed:4)
         LINE,AT(313,-10,0,63),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(5323,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(11458,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(9521,-21,0,83),USE(?Line17:7),COLOR(COLOR:Black)
         LINE,AT(8677,-21,0,83),USE(?Line17:8),COLOR(COLOR:Black)
         LINE,AT(7823,-21,0,83),USE(?Line17:6),COLOR(COLOR:Black)
         LINE,AT(7000,-21,0,83),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(313,52,11145,0),USE(?Line19),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(333,73),USE(?String17),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(823,83),USE(ACC_kods),FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(10302,63,677,156),USE(dat,,?dat:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6146,-31,0,83),USE(?Line17:4),COLOR(COLOR:Black)
         STRING(@t4),AT(10969,63),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(250,7980,11500,63),USE(?unnamed:2) !8020=1720+6300
         LINE,AT(52,0,11145,0),USE(?Line22:3),COLOR(COLOR:Black)
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

F:REDZAMIBA      BYTE
STRINGBYTE       STRING(8)
FiltrsScreen WINDOW('Nomenklatûru Filtrs'),AT(,,118,91),GRAY
       GROUP('Pçc Redazmîbas'),AT(10,6,93,58),USE(?Group1),BOXED
       END
       CHECK('Aktîvâs'),AT(18,18,52,10),USE(STRINGBYTE[8]),VALUE('1','')
       CHECK('Arhîva'),AT(18,29,52,10),USE(STRINGBYTE[7]),VALUE('1','')
       CHECK('Nâkotnes'),AT(18,40,52,10),USE(STRINGBYTE[6]),VALUE('1','')
       CHECK('Likvidçjamâs'),AT(18,50),USE(STRINGBYTE[5]),VALUE('1','')
       BUTTON('&OK'),AT(59,68,43,14),USE(?Ok:F),DEFAULT
     END
  CODE                                            ! Begin processed code
  STRINGBYTE[8]='1' ! AKTÎVAS
  open(filtrsscreen)
  display
  accept
     case field()
     OF ?OK:F
        case event()
        of event:accepted
           IF ~STRINGBYTE 
              BEEP
              CYCLE
           ELSE
              break
           .
        .
     .
  .
  F:REDZAMIBA=0
  LOOP B#=1 TO 8
     IF STRINGBYTE[9-B#]
        F:REDZAMIBA+=2^(B#-1)
     .
  .
  close(filtrsscreen)

  PUSHBIND

  DAT  =today()
  LAI  =CLOCK()
  B_DAT=TODAY()

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(PAVAD,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(PAR_K,1)
  BIND('CYCLENOM',CYCLENOM)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)

!      IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR).
!      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala).
!      IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
!      IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
      IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!      IF ~(NOM_TIPS='PTAKRI') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:'&NOM_TIPS.
      FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:Prece,Kokmateriâli Redzamîba:'
!      IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
      IF BAND(F:REDZAMIBA,00000001B) THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Aktîvâs'.
      IF BAND(F:REDZAMIBA,00000010B) THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Arhîva'.
      IF BAND(F:REDZAMIBA,00000100B) THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nâkotnes'.
      IF BAND(F:REDZAMIBA,00001000B) THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Likvidçjamâs'.

  ATLIKUMS_TEX='Atlikums ('&NOKL_CP&'.cena,'&val_uzsk&')'
  IF F:PAK
     Faktiskais='Pieejamais'
  ELSE
     Faktiskais='Faktiskais'
  .

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kritiskie atlikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      VIRSRAKSTS='Kritiskie atlikumi uz '&FORMAT(B_DAT,@D6.)&'  '&LOC_NR&'. Noliktava '&SYS:AVOTS

      CLEAR(nom:RECORD)
      NOM:NOMENKLAT=NOMENKLAT
      SET(nom:nom_key,nom:nom_key)
      Process:View{Prop:Filter} = 'INSTRING(NOM:TIPS,''PK'')'   !TIKAI PRECE&KOKMATERIÂLI
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
      IF F:IDP !UZBÛVÇT FAILU
         DO AUTONUMBER
         PAV:DATUMS=TODAY()
         PAV:DOKDAT=PAV:DATUMS
         PAV:D_K='1'
         PAV:PAMAT='Pasûtîjums no Krit.atl.'
         PAR:NOS_U=NOMENKLAT[19:21]
         GET(PAR_K,PAR:NOS_U_KEY)
         IF ERROR()
            PAV:PAR_NR=0
         ELSE
            PAV:PAR_NR=PAR:U_NR
            PAV:NOKA=PAR:NOS_S
         .
         PAV:DOK_SENR=''
         PAV:NODALA=SYS:NODALA
!         PAV:DOK_NR=performgl(4)
         PAV:apm_v='2'
         PAV:apm_k='1'
         !PAV:VAL='Ls'
         PAV:VAL=val_uzsk
         PAV:ACC_KODS=ACC_KODS
         PAV:ACC_DATUMS=TODAY()
         IF RIUPDATE:PAVAD()
            KLUDA(24,'PAVAD')
            CLOSE(ProgressWindow)
            LocalResponse = RequestCancelled
            BREAK
         .
      .
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('KRIATL.TXT')
             CLOSE(ProgressWindow)
             LocalResponse = RequestCancelled
             BREAK
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(FILTRS_TEXT)&' '&NOKL_CP&'. cena'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&'Atlikums'&CHR(9)&'Atlikums'&CHR(9)&|
             'Kritiskais'&CHR(9)&'Maksimâlais'&CHR(9)&Faktiskais&CHR(9)&'Jâpasûta'
             ADD(OUTFILEANSI)
!             OUTA:LINE=nomenklat&CHR(9)&CHR(9)&'Kritiskais'&CHR(9)&'Maksimâlais'&CHR(9)&Faktiskais&CHR(9)&'Ls'&CHR(9)&|
!             'Ls'&CHR(9)&'Ls'&CHR(9)
             OUTA:LINE=nomenklat&CHR(9)&CHR(9)&'Kritiskais'&CHR(9)&'Maksimâlais'&CHR(9)&Faktiskais&CHR(9)&val_uzsk&CHR(9)&|
             val_uzsk&CHR(9)&val_uzsk&CHR(9)
             ADD(OUTFILEANSI)
          ELSE !WORD
!             OUTA:LINE='Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&' Atlikums Kritiskais'&CHR(9)&' Atlikums Maksimâlais'|
!             &CHR(9)&' Atlikums '&Faktiskais&CHR(9)&' Atl. Ls'&CHR(9)&'Maksimâlais Ls'&CHR(9)&Faktiskais&' Ls'&CHR(9)&'Jâpasûta'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&' Atlikums Kritiskais'&CHR(9)&' Atlikums Maksimâlais'|
             &CHR(9)&' Atlikums '&Faktiskais&CHR(9)&' Atl. '&val_uzsk&CHR(9)&'Maksimâlais '&val_uzsk&CHR(9)&Faktiskais&' '&val_uzsk&CHR(9)&'Jâpasûta'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT)! NAV JÂIZLAIÞ
!        IF (~F:ATBILDIGAIS OR  NOM:ATBILDIGAIS=ACC_KODS_N) AND BAND(F:REDZAMIBA,CONVERTREDZ(NOM:REDZAMIBA)) AND (F:N OR ~(NOM:STATUSS[LOC_NR] = N))
        IF BAND(F:REDZAMIBA,CONVERTREDZ(NOM:REDZAMIBA))
        IF ~(F:DTK AND NOM:KRIT_DAU[LOC_NR]=0) !IGNORÇT, KAM KRITISKAIS=0 ÍÎPSALA
           IF F:PAK                    !ATLIKUMS-K_Projekts
              ATLIKUMS = GETNOM_A(NOM:NOMENKLAT,3,0,LOC_NR)
           ELSE
              ATLIKUMS = GETNOM_A(NOM:NOMENKLAT,1,0,LOC_NR)
           .
           KRIT_DAU = NOM:KRIT_DAU[LOC_NR]
           MAX_DAU  = NOM:MAX_DAU[LOC_NR]
           NOM_KRIT_LS=NOM:KRIT_DAU[LOC_NR]*GETNOM_K(NOM:NOMENKLAT,0,7)
           NOM_MAX_LS=NOM:MAX_DAU[LOC_NR]*GETNOM_K(NOM:NOMENKLAT,0,7)
           ATLIKUMS_LS=ATLIKUMS*GETNOM_K(NOM:NOMENKLAT,0,7)
           IF ~(ATLIKUMS > NOM:KRIT_DAU[LOC_NR])
!             JAPASUTA=NOM:KRIT_DAU[LOC_NR]-ATLIKUMS
             JAPASUTA=NOM:MAX_DAU[LOC_NR]-ATLIKUMS
             NOM_JAP_LS=JAPASUTA*GETNOM_K(NOM:NOMENKLAT,0,7)
             NOM_JAP_LSK+=NOM_JAP_LS
           ELSE
             JAPASUTA=0
           .
           IF JAPASUTA OR ~F:KRI ! ~DRUKÂT TIKAI KAS JÂPASÛTA
             IF F:DBF='W'
               PRINT(RPT:DETAIL)                                
             ELSE
               OUTA:LINE=NOM:nomenklat&CHR(9)&NOM:NOS_P&CHR(9)&LEFT(FORMAT(NOM:KRIT_DAU[LOC_NR],@N-_11.3B))&CHR(9)&|
               LEFT(FORMAT(NOM:MAX_DAU[LOC_NR],@N-_11.3B))&CHR(9)&LEFT(FORMAT(ATLIKUMS,@N-_11.3))&CHR(9)&|
               LEFT(FORMAT(NOM_KRIT_LS,@N-_10.2B))&CHR(9)&LEFT(FORMAT(NOM_MAX_LS,@N-_10.2B))&CHR(9)&|
               LEFT(FORMAT(ATLIKUMS_Ls,@N-_10.2))&CHR(9)&LEFT(FORMAT(JAPASUTA,@N-_11.3B))&CHR(9)&NOM:MERVIEN&|
               LEFT(FORMAT(NOM_JAP_LS,@N-_10.2))
               ADD(OUTFILEANSI)
             .
             IF F:IDP !UZBÛVÇT D_PROJEKTU
                DO WRITENOLIK
             .
           END
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
     IF F:IDP
        IF RIUPDATE:PAVAD()
           KLUDA(24,'PAVAD')
        .
     .
     IF F:DBF='W'
        PRINT(RPT:DETAILK)
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
     ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Sastâdîja: '&ACC_KODS&' '&FORMAT(DAT,@D06.)&' '&FORMAT(LAI,@T4)
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
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
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
!          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
WRITENOLIK    ROUTINE
  CLEAR(NOL:RECORD)
  NOL:U_NR=PAV:U_NR
  NOL:DATUMS=PAV:DATUMS
  NOL:NOMENKLAT=NOM:NOMENKLAT
  NOL:PAR_NR=PAV:PAR_NR
  NOL:D_K=PAV:D_K
  NOL:DAUDZUMS=JAPASUTA
  NOL:SUMMAV=NOM:PIC*JAPASUTA
  NOL:SUMMA=NOL:SUMMAV
  !NOL:VAL='Ls'
  NOL:VAL=val_uzsk
  NOL:PVN_PROC = NOM:PVN_PROC
!  NOL:ARBYTE = 1                !AR PVN
!  FILLPVN(1)
  ADD(nolik)
  IF ERROR()
     KLUDA(24,'NOLIK (ADD)')
     DO PROCEDURERETURN
  ELSE
     AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
  .
  PAV:SUMMA+=NOL:SUMMA
  PAV:SUMMA_B+=NOL:SUMMA
N_DinAtl             PROCEDURE                    ! Declare Procedure
DATUMS              LONG
DATUMS1             LONG
DATUMS2             LONG
LAI                 LONG
rpt_INTENS          DECIMAL(10,3)
rpt_ATLIKUMS        DECIMAL(9,2)
KRIDIENAS           DECIMAL(3)
ATLIKUMS            DECIMAL(12,3)
!DIENAS              DECIMAL(2)
!DIENASign           DECIMAL(2)
intens              real
!periods             DECIMAL(2)
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
Process:View         VIEW(NOM_K)
                       PROJECT(NOMENKLAT)
                       PROJECT(EAN)
                       PROJECT(KODS)
                       PROJECT(BKK)
                       PROJECT(NOS_P)
                       PROJECT(NOS_S)
                       PROJECT(MERVIEN)
                       PROJECT(SVARSKG)
                       PROJECT(TIPS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(302,1688,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(302,198,8000,1490)
         STRING(@s45),AT(1771,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6719,781),PAGENO,USE(?PageCount),RIGHT 
         LINE,AT(260,990,7396,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2031,990,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4948,990,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6042,990,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7240,990,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7656,990,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(313,1042,1719,208),USE(?String11),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2083,1042,2865,208),USE(?String11:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizâcijas'),AT(5000,1042,1042,208),USE(?String11:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktiskais'),AT(6094,1042,1146,208),USE(?String11:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('DS'),AT(7292,1042,365,208),USE(?String11:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('intensitâte'),AT(5000,1250,1042,208),USE(?String11:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('atlikums'),AT(6094,1250,1146,208),USE(?String11:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@n3),AT(7292,1250),USE(dienas),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1458,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(260,990,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Realizâcijas intensitâte    Noliktava :'),AT(2396,417),USE(?String2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5260,417,313,260),USE(LOC_NR),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(2031,729),USE(?String2:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(2292,729),USE(datums),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(3333,729),USE(?String2:3),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(4010,729),USE(datums1),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4948,729,104,260),USE(?String2:4),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(5052,729),USE(datums2),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(2031,-10,0,198),USE(?Line9:2),COLOR(COLOR:Black)
         STRING(@s40),AT(2135,10,2708,156),USE(NOM:NOS_P),LEFT
         LINE,AT(4948,-10,0,198),USE(?Line9:3),COLOR(COLOR:Black)
         STRING(@N-_10.3),AT(5208,10,,156),USE(INTENS),RIGHT 
         LINE,AT(6042,-10,0,198),USE(?Line9:4),COLOR(COLOR:Black)
         STRING(@N-_9.1),AT(6094,10,,156),USE(ATLIKUMS),RIGHT 
         STRING(@s7),AT(6719,10,,156),USE(NOM:MERVIEN),LEFT 
         LINE,AT(7240,-10,0,198),USE(?Line9:5),COLOR(COLOR:Black)
         STRING(@n3),AT(7344,10,,156),USE(KRIdienas),RIGHT 
         LINE,AT(7656,-10,0,198),USE(?Line9:6),COLOR(COLOR:Black)
         LINE,AT(260,-10,0,198),USE(?Line9),COLOR(COLOR:Black)
         STRING(@s21),AT(365,10,1667,156),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT DETAIL,AT(,,,406)
         LINE,AT(6042,-10,0,63),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,63),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(260,-10,0,63),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,63),USE(?Line9:7),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line9:8),COLOR(COLOR:Black)
         LINE,AT(260,52,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja:'),AT(469,156),USE(?String25) 
         STRING(@s8),AT(990,156),USE(ACC_kods),LEFT 
         STRING('RS :'),AT(2031,156),USE(?String25:2) 
         STRING(@s1),AT(2240,156),USE(RS),CENTER 
         STRING(@d6),AT(5885,156),USE(datums,,?datums:2),RIGHT 
         STRING(@T4),AT(6771,156),USE(LAI),RIGHT 
       END
       FOOTER,AT(302,11200,8000,52)
         LINE,AT(260,0,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  BIND('CYCLENOM',CYCLENOM)
  LAI = CLOCK()
  datums=today()
!!  NOL_TEX = FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% ir gatavs'
  ProgressWindow{Prop:Text} = 'Dinamiskie atlikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nom:RECORD)                              !MAKE SURE RECORD CLEARED
      NOM:NOMENKLAT=NOMENKLAT
      SET(nom:nom_key,nom:nom_key)                               !  POINT TO FIRST RECORD
      Process:View{Prop:Filter} = '~(NOM:TIPS=''A'')'
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
      datums1=today()-dienasign-periods
      datums2=today()-dienasign
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        ATLIKUMS = LOOKATL(3)
!!        STOP('ATLIKUMS: '&ATLIKUMS)
        INTENS = LOOKINT(DIENASIGN,PERIODS)
!!        STOP('INTENS: '&INTENS)
        IF (~(ATLIKUMS>INTENS*DIENAS) AND ~(INTENS<=0))
          RPT_ATLIKUMS=ATLIKUMS
          RPT_INTENS  =INTENS
          IF ATLIKUMS > 0
            KRIDIENAS=ATLIKUMS/INTENS
          ELSE
            KRIDIENAS=0
          .
          PRINT(RPT:DETAIL)                            !  PRINT DETAIL LINES
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
    PRINT(RPT:RPT_FOOT)
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
  NEXT(Process:View)
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% ir gatavs'
      DISPLAY()
    END
  END
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nom_k)                          !  READ UNTIL END OF FILE
    NEXT(nom_k)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
    IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.          !FILTRS PÇC NOMENKLATÛTAS
    IF NOM:TIPS='A' THEN CYCLE.
    ATLIKUMS=lookatl(3)     ! ar filtru pçc RST
    intens=LOOKINT(DIENASIGN,periods)
    IF ATLIKUMS > INTENS*DIENAS THEN CYCLE.
    IF INTENS<=0 THEN CYCLE.
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
