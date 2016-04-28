                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_KasesZurnals       PROCEDURE                    ! Declare Procedure
KOMENT               STRING(48)
ATL                  DECIMAL(15,2)
UNR                  STRING(3)
NGG                  DECIMAL(7)
DOK_NR               STRING(14)
DATUMS               DATE
SATURS               STRING(35)
SATURS1              STRING(80)
SATURS2              STRING(80)
!KKK1                 STRING(5)
!KKK2                 STRING(5)
DEB                  DECIMAL(12,2)
KRE                  DECIMAL(12,2)
LDEB                 DECIMAL(12,2)
LKRE                 DECIMAL(12,2)
KAPGP                DECIMAL(15,2)
KATL                 DECIMAL(15,2)
KDEBP                DECIMAL(13,2)
KKREP                DECIMAL(13,2)
L                    STRING(1)
POS                  STRING(255)
LB                   BYTE
FORMA                STRING(30)
FORMAT               STRING(1)
CG                   STRING(10)
IEN_sk               USHORT
IZD_sk               USHORT
LINEH                STRING(190)
NPK                  LONG

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
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(200,1517,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,100,8000,1417),USE(?unnamed:5)
         STRING('Kases orderu reìistrâcijas þurnâls'),AT(1875,521,4146,219),USE(?unnamed:6),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6250,708,1563,0),USE(?Line53),COLOR(COLOR:Black)
         STRING('laikâ no'),AT(2594,729,552,208),USE(?String2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s48),AT(2542,354,3594,208),USE(KOMENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3208,729,781,208),USE(S_DAT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(4438,729,729,208),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Valûta'),AT(6396,729,521,208),USE(?String2:6),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('EUR'),AT(7250,729,344,208),USE(?String2:7),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,720,0,220),USE(?Line50:3),COLOR(COLOR:Black)
         LINE,AT(7031,720,0,220),USE(?Line50:2),COLOR(COLOR:Black)
         LINE,AT(6250,720,0,220),USE(?Line50),COLOR(COLOR:Black)
         STRING('lîdz'),AT(4021,729,396,208),USE(?String2:5),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s48),AT(2542,177,3594,208),USE(GL:VID_NR),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2542,0,3594,208),USE(CLIENT),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Kases konts konta plânâ'),AT(156,344,2354,208),USE(?String2:4),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Reìistrâcijas nr.'),AT(156,167,2354,208),USE(?String2:3),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Firmas, organizâcijas nosaukums'),AT(156,0,2354,208),USE(?String2:2),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,938,7708,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Pamatojums'),AT(4177,1094,2052,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(6281,1094,729,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(7063,1094,729,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(188,1094,469,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1406,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7813,938,0,469),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('No kâ saòemts vai  kam izsniegts'),AT(1656,1094,2052,208),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3865,938,0,469),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6250,938,0,469),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7031,938,0,469),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(1615,938,0,469),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Dok.numurs'),AT(823,1094,740,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,938,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(104,938,0,469),USE(?Line2),COLOR(COLOR:Black)
       END
SAKATL DETAIL,AT(,,,354),USE(?unnamed:4)
         LINE,AT(1615,313,0,42),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(3865,-10,0,374),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,374),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,374),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,374),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,374),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Atlikums  uz  perioda  sâkumu  :'),AT(156,104,1979,156),USE(?String18),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_15.2),AT(4260,104,938,156),USE(ATL),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,313,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(781,313,0,42),USE(?Line2:7),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed)
         LINE,AT(7813,-10,0,166),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,166),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(7083,0,677,156),USE(KRE),RIGHT
         STRING(@s40),AT(3906,0,2313,156),USE(SATURS1),TRN
         LINE,AT(3865,-10,0,166),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,166),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@D5),AT(188,0,469,156),USE(DATUMS),RIGHT
         STRING(@s35),AT(1656,0,2198,156),USE(SATURS),LEFT
         LINE,AT(6250,-10,0,166),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6302,0,677,156),USE(DEB),RIGHT
         LINE,AT(781,-10,0,166),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s14),AT(813,0,698,156),USE(DOK_NR),RIGHT
         LINE,AT(104,-10,0,166),USE(?Line2:29),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,-10,,94),USE(?unnamed:7)
         LINE,AT(104,0,0,114),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(781,0,0,114),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(1615,0,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(3865,0,0,114),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
DETAIL1 DETAIL,AT(,,,146),USE(?unnamed:2)
         LINE,AT(7813,-10,0,166),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,166),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,166),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(3865,-10,0,166),USE(?Line41),COLOR(COLOR:Black)
         STRING(@s80),AT(1656,0,2125,156),USE(SATURS2),LEFT
         LINE,AT(6250,-10,0,166),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(781,-10,0,166),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,166),USE(?Line2:15),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,1344),USE(?unnamed:3)
         LINE,AT(104,0,0,260),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(781,0,0,62),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(1615,0,0,62),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(3865,0,0,62),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,260),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,260),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6302,104,677,156),USE(KDEBP),RIGHT
         STRING(@N-_13.2B),AT(7083,104,677,156),USE(KKREP),RIGHT
         STRING('Kopâ'),AT(156,104,1198,156),USE(?String29:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,260,7708,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Kopçjais kases orderu skaits : Ieòçmumu'),AT(135,375),USE(?String41)
         STRING(@n4),AT(2240,375,260,188),USE(ien_sk),LEFT
         STRING(@n4),AT(3052,375,260,188),USE(izd_sk),LEFT
         STRING('Izdevumu'),AT(2542,375,479,188),USE(?String41:2)
         STRING(@s25),AT(1354,781),USE(sys:amats2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(3302,979),USE(sys:paraksts2),CENTER
         STRING(@s25),AT(5948,979),USE(sys:paraksts3),CENTER
         STRING('Kasieris _{24}'),AT(5469,771,2396,208),USE(?String39:2),LEFT
         STRING('_{26}'),AT(3292,771,1885,208),USE(?String39),LEFT
       END
       FOOTER,AT(200,10900,8000,52)
         LINE,AT(104,0,7708,0),USE(?Line1:7),COLOR(COLOR:Black)
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

  CHECKOPEN(GLOBAL)
  CHECKOPEN(SYSTEM)
  CHECKOPEN(GGK)
  CHECKOPEN(GG)
  CHECKOPEN(PAR_K)
  CHECKOPEN(KON_K)

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND(KON:RECORD)

  CLEAR(KON:RECORD)
  KON:BKK = KKK
  GET(KON_K,KON:BKK_KEY)
  KOMENT=KKK&': '&CLIP(KON:NOSAUKUMS)
  J# = 0
  DONE# = 0
  KDEBP = 0
  KKREP = 0
  KAPGP = 0
  LDEB = 0
  LKRE =0
  ATL = 0
  NPK = 0
  IF ~F:NOA THEN UNR='UNR'.

  CLEAR(GGK:RECORD)
  L=SUB(KKK,5,1)
  LB = VAL(L)
  LB += 1
  L = CHR(LB)
  GGK:BKK = SUB(KKK,1,4)&L

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK:BKK_DAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Kases grâmata'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    BIND('KKK',KKK)
    BIND('S_DAT',S_DAT)
    BIND('B_DAT',B_DAT)
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK = KKK
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K1100'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
          IF ~OPENANSI('KASELS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='KONTS - '&CLIP(KOMENT)&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Datums'&CHR(9)&'Dok.numurs'&CHR(9)&'No kâ saòemts, kam izsniegts'&CHR(9)&'Pamatojums'&CHR(9)&'Debets'&CHR(9)&'Kredîts'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        !DO CHECKSAKAT
        CASE GGK:D_K
           OF 'D'
             ATL += GGK:SUMMA
           OF 'K'
             ATL -= GGK:SUMMA
        END
        DO CHECKTEXT
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
  IF SEND(GGK,'QUICKSCAN=off').
  KAPGP = KDEBP - KKREP
  KATL = ATL
  IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
  ELSE
        OUTA:LINE='Kopâ: '&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KDEBP,@N-_13.2))&CHR(9)&LEFT(FORMAT(KKREP,@N-_13.2))
        ADD(OUTFILEANSI)
  END
  IF LocalResponse = RequestCompleted
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
  IF ERRORCODE() OR ~(GGK:BKK=KKK)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
!--------------------------------------------------------------
CHECKSAKAT ROUTINE
 IF GGK:DATUMS >= S_DAT AND ~PRSAKAT# AND ~(GGK:U_NR = 1)
    KATL = ATL
    IF F:DBF = 'W'
        PRINT(RPT:SAKATL)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Atlikums uz perioda sâkumu: '&LEFT(FORMAT(ATL,@N-_15.2))
        ADD(OUTFILEANSI)
    END
    PRSAKAT# = 2
 .
!---------------------------------------------------------------
CHECKTEXT ROUTINE
 IF GGK:DATUMS >= S_DAT AND GGK:U_NR > 1
   GG:U_NR = GGK:U_NR
   GET(GG,GG:NR_KEY)
   BUILDKORMAS(2,0,0,0,0)
   KKK1 = KOR_KONTS[1]
   KKK2 = KOR_KONTS[2]
   IF ~F:NOA THEN NGG = GGK:U_NR.    !LABÂK TOMÇR ÐITÂ
!   NGG += 1
!   IF CHECKPZ(1)
!      DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!   ELSE
!      IF GG:DOK_NR
!         DOK_NR=RIGHT(GG:DOK_NR)
!      ELSE
!         DOK_NR=''
!      .
!   .
   DOK_NR = GG:DOK_SENR
   DATUMS = GG:DATUMS
   SATURS = CLIP(GETPAR_K(GG:PAR_NR,0,3))
   TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
   !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
   IF ~(GGK:VAL=val_uzsk)
      TEKSTS=CLIP(TEKSTS)&' ('&CLIP(GGK:SUMMAV)&' '&CLIP(GGK:VAL)&')'
   .
   FORMAT_TEKSTS(90,'Arial',8,'')
   SATURS1 = F_TEKSTS[1]
   CASE GGK:D_K
   OF 'D'
      IEN_SK+=1
      DEB = GGK:SUMMA
      KRE = 0
   OF 'K'
      IZD_SK+=1
      KRE = GGK:SUMMA
      DEB = 0
   .
   IF PRSAKAT# = 1
   ELSE
      PRSAKAT# = 1
   .
   NPK+=1
   IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            OUTA:LINE=FORMAT(DATUMS,@D06.)&CHR(9)&CLIP(DOK_NR)&CHR(9)&CLIP(SATURS)&CHR(9)&CLIP(SATURS1)&CHR(9)&LEFT(FORMAT(DEB,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KRE,@N-_13.2B))
            ADD(OUTFILEANSI)
        END
   END
   IF KKK2
      SATURS2 = F_TEKSTS[2]
      IF ~F:DTK
        IF F:DBF
            PRINT(RPT:DETAIL1)
        ELSE
            OUTA:LINE=CHR(9)&CHR(9)&CLIP(SATURS2)&CHR(9)
            ADD(OUTFILEANSI)
        END
      END
   .
   LDEB += DEB
   LKRE += KRE
   KDEBP += DEB
   KKREP += KRE
 .
