                     MEMBER('winlats.clw')        ! This is a MEMBER module
K_VESTURE_AUTO PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
LIST:AUTOAPK         QUEUE,PRE()
DATUMS               LONG
OBJEKTS              STRING(20)
NOBRAUKUMS           DECIMAL(7)
TEK                  STRING(50)
OBJ_NR               BYTE
PAV_NR               ULONG
                     END
window               WINDOW('A/M Servisa vçsture'),AT(,,293,204),FONT(,9,,FONT:bold),VSCROLL,GRAY
                       LIST,AT(4,5,286,179),USE(?List1),FORMAT('40L|~Datums~@D6@80L|~Objekts~@s20@28L|~Nobr.~@n_7@200L~Darbu saturs~@s50@'),FROM(List:AUTOAPK)
                       BUTTON('&Beigt'),AT(252,187,36,14),USE(?CancelButton)
                       BUTTON('Daïas / darbi'),AT(163,187,61,14),USE(?ButtonDD)
                     END
SAV_NOLIKNAME   LIKE(NOLIKNAME)
SAV_AAPKNAME    LIKE(AAPKNAME)

LIST:DD         QUEUE,PRE(DD)
NOMENKLAT            STRING(21)
DAUDZUMS             DECIMAL(11,3)
SUMMA                DECIMAL(11,2)
                     END

windowDD WINDOW('Daïas/darbi'),AT(,,172,202),FONT(,9,,FONT:bold,CHARSET:BALTIC),VSCROLL,GRAY
       LIST,AT(5,5,162,177),USE(?List2),FORMAT('86L|~Nomenklat~@S21@40L|~Daudzums~@n_9.3@200L~Summa~@n_9.2@'), |
           FROM(List:DD)
       BUTTON('&Beigt'),AT(124,184,36,14),USE(?CancelButtonDD)
     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SAV_NOLIKNAME = NOLIKNAME
  SAV_AAPKNAME  = AAPKNAME
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I# = 1 TO 2
     CLOSE(AUTOAPK)
  !   NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)
     AAPKNAME='AAPK'&FORMAT(I#,@N02)
     CHECKOPEN(AUTOAPK,1)
     CLEAR(APK:RECORD)
     APK:AUT_NR=AUT:U_NR
     APK:DATUMS=9999999
     SET(APK:AUT_KEY,APK:AUT_KEY)
     LOOP
        NEXT(AUTOAPK)
        IF ERROR() OR ~(APK:AUT_NR=AUT:U_NR) THEN BREAK.
        DATUMS      = APK:DATUMS
        OBJ_NR      = I#
        PAV_NR      = APK:PAV_NR
        OBJEKTS     = CLIP(I#)&'-Vietçjais serviss'
        NOBRAUKUMS  = APK:NOBRAUKUMS
        TEK         = APK:TEKSTS
        ADD(LIST:AUTOAPK)
     .
  .
  SORT(LIST:AUTOAPK,-DATUMS)
  
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?List1)
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
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOLIKNAME=SAV_NOLIKNAME
        AAPKNAME =SAV_AAPKNAME
        BREAK
      END
    OF ?ButtonDD
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          GET(LIST:AUTOAPK,CHOICE(?list1))
          CLOSE(NOLIK)
          NOLIKNAME='NOLIK'&FORMAT(OBJ_NR,@N02)
        !   AAPKNAME='AAPK'&FORMAT(I#,@N02)
          CHECKOPEN(NOLIK,1)
          CLEAR(NOL:RECORD)
          NOL:U_NR=PAV_NR
          SET(NOL:NR_KEY,NOL:NR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR=PAV_NR) THEN BREAK.
             DD:NOMENKLAT   = NOL:NOMENKLAT
             DD:DAUDZUMS    = NOL:DAUDZUMS
             DD:SUMMA       = NOL:SUMMA
             ADD(LIST:DD)
          .
          OPEN(WINDOWDD)
          ACCEPT
            CASE FIELD()
            OF ?CancelButtonDD
              CASE EVENT()
              OF EVENT:Accepted
                BREAK
              END
            END
          END
          CLOSE(WINDOWDD)
          FREE(LIST:DD)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('K_VESTURE_AUTO','winlats.INI')
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF WindowOpened
    INISaveWindow('K_VESTURE_AUTO','winlats.INI')
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
F_DerTer             PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
nom_pap_f           BYTE
NOM_PZ              BYTE
SUMS                STRING(11)
ATL                 DECIMAL(12,3)
ATLDIENAS           DECIMAL(3)

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

report REPORT,AT(146,1229,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,198,8000,1031)
         STRING(@s45),AT(1771,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6854,531),PAGENO,USE(?PageCount),RIGHT
         STRING('Derîguma termiòa atskaite uz'),AT(1719,417),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4115,417),USE(B_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(5104,417),USE(sys:avots),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7448,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2240,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(5833,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6771,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7604,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Npk'),AT(188,771,365,208),USE(?String4:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,729,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(604,771,1615,208),USE(?String4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(5865,771,885,208),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Der.term.'),AT(5188,771,625,208),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5156,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(2271,771,2865,208),USE(?String4:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. dienas'),AT(6802,771,781,208),USE(?String4:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,990,7448,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed)
         LINE,AT(2240,-10,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@D06.B),AT(5198,0,604,156),USE(NOM:DER_TERM),RIGHT(1)
         STRING(@s45),AT(2271,0,2865,156),USE(NOM:NOS_P),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6771,-10,0,167),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N3),AT(208,0,313,156),CNT,USE(?Counter),RIGHT
         LINE,AT(573,-10,0,167),USE(?Line8:7),COLOR(COLOR:Black)
         STRING(@N-_12.3),AT(5938,0,729,146),USE(Atl),RIGHT
         STRING(@N-4B),AT(7115,0,313,156),USE(AtlDienas),RIGHT
         LINE,AT(7604,-10,0,167),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,167),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s21),AT(604,0,1615,146),USE(NOM:NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT DETAIL,AT(,,,271),USE(?unnamed:2)
         LINE,AT(156,0,0,63),USE(?Line113),COLOR(COLOR:Black)
         LINE,AT(573,0,0,63),USE(?Line115:6),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,63),USE(?Line115),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,63),USE(?Line115:2),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,63),USE(?Line115:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,63),USE(?Line115:3),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,63),USE(?Line115:4),COLOR(COLOR:Black)
         LINE,AT(156,52,7448,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(208,83),USE(?String18:2),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(688,83),USE(acc_kods,,?acc_kods:2),FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1354,83),USE(?String120),FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6542,83),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7146,83),USE(LAI,,?LAI:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1542,83),USE(RS,,?RS:2),CENTER,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,10896,8000,52),USE(?unnamed:3)
         LINE,AT(156,0,7500,0),USE(?Line1:4),COLOR(COLOR:Black)
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

NOMFwindow WINDOW('Papildus Nom Filtrs'),AT(,,142,98),GRAY
       OPTION('Papildus Nom filtrs'),AT(16,12,106,39),USE(NOM_PAP_F),BOXED
         RADIO('Visas nomenklatûras'),AT(27,26,88,10),USE(?NOM_PAP_F:Radio1)
         RADIO('Tikai aktîvâs'),AT(27,37,88,10),USE(?NOM_PAP_F:Radio2)
       END
       BUTTON('Tikai pçc izvçlçtâs P/Z'),AT(9,56,102,14),USE(?ButtonPZ)
       IMAGE('CHECK2.ICO'),AT(117,55,14,15),USE(?ImagePZ),HIDE
       BUTTON('&OK'),AT(57,75,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(96,75,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPEN(NOMFwindow)
  nom_pap_f=1
  ACCEPT
    CASE FIELD()
    OF ?ButtonPZ
      CASE EVENT()
      OF EVENT:Accepted
         IF NOM_PZ=0
            NOM_PZ=1
            UNHIDE(?IMAGEPZ)
         ELSE
            NOM_PZ=0
            HIDE(?IMAGEPZ)
         .
      .
      DISPLAY
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
         LocalResponse = RequestCompleted
         BREAK
      .
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
         LocalResponse = RequestCancelled
         BREAK
      .
    END
  END
  close(NOMFwindow)
  IF LocalResponse = RequestCancelled
     DO ProcedureReturn
  .
  LAI = CLOCK()
  DAT = TODAY()
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

  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Derîguma termiòa atskaite'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
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
      ELSE           !RTF
        IF ~OPENANSI('DERTER.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Derîguma termiòa atskaite uz '&format(B_DAT,@d06.)&' '&SYS:AVOTS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'Derîguma term.'&CHR(9)&'Atlikums'&CHR(9)&'Atl. dienas'
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT) AND ~(nom_pap_f=2 AND ~(NOM:REDZAMIBA=0)) AND (NOM_TIPS7='PTAKRIV' OR INSTRING(NOM:TIPS,NOM_TIPS7))
           PRINT#=TRUE
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           ATL=GETNOM_A(NOM:NOMENKLAT,1,0)
           IF NOM:DER_TERM
              ATLDIENAS=NOM:DER_TERM-B_DAT
           ELSE
              ATLDIENAS=0
           .
           IF NOM_PZ                           !TIKAI PÇC IZVÇLÇTÂS P/Z
              NOL:U_NR=PAV:U_NR
              NOL:NOMENKLAT=NOM:NOMENKLAT
              GET(NOLIK,NOL:NR_KEY)
              IF ERROR()
                 PRINT#=FALSE
              .
           .
           IF PRINT#=TRUE
             IF F:DBF='W'
                PRINT(RPT:DETAIL)                           
             ELSE
                OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:NOS_P&CHR(9)&FORMAT(NOM:DER_TERM,@D06.B)&CHR(9)&LEFT(FORMAT(ATL,@N-10.2))&CHR(9)&LEFT(FORMAT(ATLDIENAS,@N-4B))
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
!       IF NOM_PZ                            !TIKAI PÇC IZVÇLÇTÂS P/Z
!          PRINT(RPT:RPT_FOOT1)
!       ELSE
          PRINT(RPT:RPT_FOOT)
!       .
       ENDPAGE(report)
    ELSE
!       OUTA:LINE='-{140}'
!       ADD(OUTFILEANSI)
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
B_Lasotra            PROCEDURE                    ! Declare Procedure
LocalRequest        LONG
LocalResponse       LONG
DOK_NR              STRING(14)
RPT_GADS            STRING(4)
RPT_DATUMS          BYTE
RPT_MENESIS         STRING(11)
PADRESE             STRING(45)
REGNR               STRING(13)
SATURS              STRING(45)
MERV                STRING(7)
DAUDZUMS            DECIMAL(11,3)
CENA                DECIMAL(12,2)
nos                 STRING(3)
IeAdrese            string(45)
IeDatums            long
IzAdrese            string(45)
IzDatums            long
K_Saturs            string(45)
VNR                 STRING(10)
PNR                 STRING(10)
PROJ_NR             LIKE(GGK:OBJ_NR)
NULLPVN             STRING(20)

P_TABLE          QUEUE,PRE(P)
NULLPVNP            STRING(12)
                 .
PVN_PR              BYTE
BKK                 STRING(5),DIM(10)
BKK_SUMMAS          DECIMAL(12,2),DIM(10)
LATVENG             BYTE

SUMMAV              DECIMAL(12,2)
SUMMALS             DECIMAL(12,2)
PVNSUMMAV           DECIMAL(12,2)
PVNSUMMA            DECIMAL(12,2)
KOPAV               DECIMAL(12,2)
KOPALS              DECIMAL(12,2)

KURSS               DECIMAL(10,8)
APMDAT              LONG

report REPORT,AT(198,2500,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,500,8000,2000)
       END
detail DETAIL,AT(,,,7865),USE(?unnamed)
         STRING('R Ç Í I N S  Nr.'),AT(2917,52),USE(?String1),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(4167,52),USE(GG:DOK_SENR),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s4),AT(2708,417),USE(Rpt_Gads),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(3125,417),USE(?String4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3594,417),USE(Rpt_Datums),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(3854,417,104,260),USE(?String4:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(3958,417),USE(Rpt_Menesis),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Adresâts:'),AT(365,885,625,208),USE(?String8),LEFT
         STRING(@s45),AT(990,896,3375,208),USE(PAR:NOS_P),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Reì.Nr.:'),AT(4365,885),USE(?String11)
         STRING(@s13),AT(4938,885),USE(RegNr),LEFT
         STRING(@s40),AT(990,1094,2969,208),USE(PAR:ADRESE),LEFT
         STRING('Transporta pakalpojums'),AT(500,1500,3125,208),USE(?trpak),LEFT
         STRING(@n_12.2),AT(5469,1563),USE(SUMMAV,,?SUMMAV:2),CENTER
         STRING(@s3),AT(6510,1563,573,208),USE(gg:val),CENTER
         STRING('gab.'),AT(3938,1573),USE(?String22:17)
         STRING('1'),AT(4875,1552),USE(?String22:18)
         STRING('1. Iekrauðanas adrese'),AT(365,1927),USE(?String22)
         STRING(@s45),AT(2500,1927,3333,208),USE(IeAdrese),LEFT
         STRING('2. Iekrauðanas datums'),AT(365,2135),USE(?String22:2)
         STRING(@d6),AT(2500,2135,833,208),USE(IeDatums),LEFT
         STRING('3. Izkrauðanas adrese'),AT(365,2344),USE(?String22:3)
         STRING(@s45),AT(2500,2344,3333,208),USE(IzAdrese),LEFT
         STRING('4. Izkrauðanas datums'),AT(365,2552),USE(?String22:4)
         STRING(@d6),AT(2500,2552,833,208),USE(IzDatums),LEFT
         STRING('5. Kravas saturs'),AT(365,2760),USE(?String22:5)
         STRING(@s45),AT(2500,2760,3333,208),USE(K_saturs),LEFT
         STRING('6. Vilcçja Nr.'),AT(365,2969),USE(?String22:6)
         STRING(@s10),AT(2500,2969),USE(VNR),LEFT
         STRING('7. Piekabes Nr.'),AT(365,3177),USE(?String22:7)
         STRING(@s10),AT(2500,3177),USE(PNR),LEFT
         STRING('8. Projekta Nr.'),AT(365,3385),USE(?String22:19)
         STRING(@n_5b),AT(2500,3385),USE(PROJ_NR),LEFT
         STRING('9. Summa apmaksai'),AT(365,3906,1552,208),USE(?String22:8),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_12.2),AT(3802,3906),USE(KOPAV),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4844,3906,313,208),USE(gg:val,,?gg:val:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_12.2),AT(5313,3906),USE(KOPALS),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('LVL'),AT(6354,3906,260,208),USE(?String22:9),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,4115,7031,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s45),AT(365,4167,3333,208),USE(SATURS,,?SATURS:3),LEFT
         STRING(@n_12.2),AT(3802,4167),USE(SUMMAV,,?SUMMAV:4),RIGHT
         STRING(@s3),AT(4844,4167,313,208),USE(gg:val,,?gg:val:5),LEFT
         STRING(@n_12.2),AT(5313,4167),USE(SUMMALS,,?SUMMALS:3),CENTER
         STRING('LVL'),AT(6354,4167,260,208),USE(?String122:9)
         STRING('PVN'),AT(365,4375,365,208),USE(?String22:10)
         STRING(@N2),AT(729,4375),USE(PVN_PR)
         STRING('% likme'),AT(938,4375,573,208),USE(?String22:11)
         STRING(@n_12.2),AT(3802,4375),USE(PVNsummav),RIGHT
         STRING(@s3),AT(4844,4375,313,208),USE(gg:val,,?gg:val:4),LEFT
         STRING(@n_12.2),AT(5313,4375),USE(PVNsumma),CENTER
         STRING('LVL'),AT(6354,4375,260,208),USE(?String222:9)
         STRING('Valûtas kurss'),AT(365,4583,885,208),USE(?String22:12)
         STRING(@N_10.8),AT(1302,4583),USE(kurss),RIGHT
         STRING('Lûdzam apmaksu veikt lîdz'),AT(365,4896,1667,208),USE(?String22:13)
         STRING(@d6),AT(2083,4896),USE(gg:ApmDat),RIGHT
         STRING('.'),AT(2865,4896,208,208),USE(?String22:14),LEFT
         STRING('Neapmaksâjot rçíinu norâdîtâjâ termiòâ, kavçjuma nauda 0.5% no apmaksas summas p' &|
             'ar katru kavçjuma dienu.'),AT(365,5104,7333,208),USE(?String22:15)
         STRING('Pateicamies par sadarbîbu.'),AT(365,5469,1667,208),USE(?String22:16)
         STRING(@S20),AT(4688,7198),USE(SYS:PARAKSTS2),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S20),AT(3063,7198),USE(SYS:amats2),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(396,6083),USE(BKK[1],,?BKK_1:2),TRN
         STRING(@N_11.2B),AT(865,6083),USE(BKK_SUMMAS[1],,?BKK_SUMMAS_1:3),TRN
         STRING(@s5),AT(396,6292),USE(BKK[2]),TRN
         STRING(@N_11.2B),AT(865,6292),USE(BKK_SUMMAS[2]),TRN
         LINE,AT(3260,7146,2844,0),USE(?Line3),COLOR(COLOR:Black)
         STRING(@s5),AT(396,6500),USE(BKK[3]),TRN
         STRING(@N_11.2B),AT(865,6500),USE(BKK_SUMMAS[3]),TRN
         STRING(@s5),AT(396,6708),USE(BKK[4]),TRN
         STRING(@N_11.2B),AT(865,6708),USE(BKK_SUMMAS[4]),TRN
         STRING(@N_11.2B),AT(865,6917),USE(BKK_SUMMAS[5]),TRN
         STRING(@s5),AT(396,6917),USE(BKK[5]),TRN
         STRING(@N_11.2B),AT(865,7125),USE(BKK_SUMMAS[6]),TRN
         STRING(@s5),AT(396,7125),USE(BKK[6]),TRN
         STRING(@s5),AT(396,7333),USE(BKK[7]),TRN
         STRING(@N_11.2B),AT(865,7333),USE(BKK_SUMMAS[7]),TRN
         STRING(@N_11.2B),AT(865,7563),USE(BKK_SUMMAS[8]),TRN
         STRING(@s5),AT(396,7573),USE(BKK[8]),TRN
         STRING(@s20),AT(354,3635,1542,208),USE(NULLPVN,,?NULLPVN:2),TRN,RIGHT(1)
         STRING(@s12),AT(1938,3635,927,208),USE(P:NULLPVNP,,?P:NULLPVNP:2),TRN,LEFT(1)
         STRING('Mçrv.'),AT(3802,1354,573,208),USE(?String14),CENTER
         STRING('Daudzums'),AT(4479,1354,938,208),USE(?String14:2),CENTER
         STRING('Cena'),AT(5469,1354,990,208),USE(?String14:3),CENTER
         STRING('Valûta'),AT(6510,1354,573,208),USE(?String14:4),CENTER
       END
detailEng DETAIL,AT(,,,7865),USE(?unnamed:2)
         STRING('A C C O U N T  Nr'),AT(2708,52,1563,260),USE(?String1:2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(4167,52),USE(GG:DOK_SENR,,?GG:DOK_SENR:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3177,417,885,260),USE(GG:DOKDAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Address:'),AT(365,885,625,208),USE(?String8:2),LEFT
         STRING(@s45),AT(990,885,3375,208),USE(PAR:NOS_P,,?PAR:NOS_P:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(4479,885),USE(RegNr,,?RegNr:2),LEFT
         STRING(@s40),AT(990,1094,2969,208),USE(PAR:ADRESE,,?PAR:ADRESE:2),LEFT
         STRING('Transport service'),AT(500,1500,3125,208),USE(?trpak:2),LEFT
         STRING(@n_12.2),AT(5469,1563),USE(SUMMAV,,?SUMMAV:3),CENTER
         STRING(@s3),AT(6510,1563,573,208),USE(gg:val,,?GG:VAL:12),CENTER
         STRING('1'),AT(4740,1563),USE(?String22:20)
         STRING('1. Loading address'),AT(365,1823),USE(?String22:21)
         STRING(@s45),AT(2240,1823,3333,208),USE(IeAdrese,,?IEADRESE:6),LEFT
         STRING('2. Date of loading'),AT(365,2031),USE(?String22:22)
         STRING(@d6),AT(2240,2031,833,208),USE(IeDatums,,?IeDatums:2),LEFT
         STRING('3. Unloading address'),AT(365,2240),USE(?String22:23)
         STRING(@s45),AT(2240,2240,3333,208),USE(IzAdrese,,?IzAdrese:2),LEFT
         STRING('4. Date of unloading'),AT(365,2448),USE(?String22:24)
         STRING(@d6),AT(2240,2448,833,208),USE(IzDatums,,?IzDatums:2),LEFT
         STRING('5. Description'),AT(365,2656),USE(?String22:25)
         STRING(@s45),AT(2240,2656,3333,208),USE(K_saturs,,?K_saturs:2),LEFT
         STRING('6. Registration Nr. of tractor'),AT(365,2865,1771,208),USE(?String22:26)
         STRING(@s10),AT(2240,2865),USE(VNR,,?VNR:2),LEFT
         STRING('7. Registration Nr. of trailor'),AT(365,3073,1771,208),USE(?String22:27)
         STRING(@s10),AT(2240,3073),USE(PNR,,?PNR:2),LEFT
         STRING('8. Nr. of Project'),AT(365,3281,1042,208),USE(?String22:28),TRN
         STRING(@n_5),AT(2240,3281),USE(PROJ_NR,,?PROJ_NR:2),TRN,LEFT
         STRING(@s12),AT(2010,3542,948,208),USE(P:NULLPVNP),TRN,LEFT(1)
         STRING('9. Sum for payment'),AT(365,3802,1552,208),USE(?String22:29),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_12.2),AT(3802,3802),USE(KOPAV,,?KOPAV:2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4844,3802,313,208),USE(gg:val,,?gg:val:3),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_12.2),AT(5313,3802),USE(KOPALS,,?KOPALS:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('LVL'),AT(6354,3802,260,208),USE(?String22:36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,4010,7031,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s45),AT(365,4063,3333,208),USE(SATURS,,?SATURS:2),LEFT
         STRING(@n_12.2),AT(3802,4063),USE(SUMMAV,,?SUMMAV:13),RIGHT
         STRING(@s3),AT(4844,4063,313,208),USE(gg:val,,?gg:val:31),LEFT
         STRING(@n_12.2),AT(5313,4063),USE(SUMMALS,,?SUMMALS:2),CENTER
         STRING('LVL'),AT(6354,4063,260,208),USE(?String122:2)
         STRING('VAT'),AT(365,4271,365,208),USE(?String22:30)
         STRING(@N2),AT(729,4271),USE(PVN_PR,,?PVN_PR:2)
         STRING('%'),AT(938,4271,573,208),USE(?String22:31)
         STRING(@n_12.2),AT(3802,4271),USE(PVNsummav,,?PVNSUMMAV:2),RIGHT
         STRING(@s3),AT(4844,4271,313,208),USE(gg:val,,?gg:val:51),LEFT
         STRING(@n_12.2),AT(5313,4271),USE(PVNsumma,,?PVNSUMMA:2),CENTER
         STRING('LVL'),AT(6354,4271,260,208),USE(?String222:99)
         STRING('Rate of exchange'),AT(365,4479,1146,208),USE(?String22:32)
         STRING(@N_10.8),AT(1563,4479),USE(kurss,,?kurss:2),RIGHT
         STRING('Please, make the payment untill'),AT(365,4896,2031,208),USE(?String22:33)
         STRING(@d6),AT(2396,4896),USE(gg:ApmDat,,?gg:ApmDat:2),RIGHT
         STRING('.'),AT(3177,4896,208,208),USE(?String22:34),LEFT
         STRING('If invoice not paid in mentioned time, will be calculated 0.5% off unpaid for ea' &|
             'ch day of delay.'),AT(365,5104,6875,208),USE(?String22:35)
         STRING(@S20),AT(4469,6990),USE(SYS:PARAKSTS2,,?SYS:PARAKSTS2:2),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Accountant'),AT(3604,6990),USE(?String20:2),TRN
         STRING(@s5),AT(396,6083),USE(BKK[1],,?BKK_1:12),TRN
         STRING(@N_11.2B),AT(865,6083),USE(BKK_SUMMAS[1],,?BKK_SUMMAS_1:2),TRN
         STRING(@s5),AT(396,6292),USE(BKK[2],,?BKK_2:12),TRN
         STRING(@N_11.2B),AT(865,6292),USE(BKK_SUMMAS[2],,?BKK_SUMMAS_2:12),TRN
         STRING(@s5),AT(396,6500),USE(BKK[3],,?BKK_3:4),TRN
         STRING(@N_11.2B),AT(865,6500),USE(BKK_SUMMAS[3],,?BKK_SUMMAS_3:4),TRN
         STRING(@s5),AT(396,6708),USE(BKK[4],,?BKK_4:5),TRN
         STRING(@N_11.2B),AT(865,6708),USE(BKK_SUMMAS[4],,?BKK_SUMMAS_4:5),TRN
         STRING(@N_11.2B),AT(865,6917),USE(BKK_SUMMAS[5],,?BKK_SUMMAS_5:6),TRN
         LINE,AT(3292,6938,2844,0),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@s5),AT(396,6917),USE(BKK[5],,?BKK_5:6),TRN
         STRING(@N_11.2B),AT(865,7125),USE(BKK_SUMMAS[6],,?BKK_SUMMAS_6:7),TRN
         STRING(@s5),AT(396,7125),USE(BKK[6],,?BKK_6:8),TRN
         STRING(@s5),AT(396,7333),USE(BKK[7],,?BKK_7:8),TRN
         STRING(@N_11.2B),AT(865,7333),USE(BKK_SUMMAS[7],,?BKK_SUMMAS_7:8),TRN
         STRING(@N_11.2B),AT(865,7563),USE(BKK_SUMMAS[8],,?BKK_SUMMAS_8:9),TRN
         STRING(@s5),AT(396,7573),USE(BKK[8],,?BKK_8:9),TRN
         STRING(@s20),AT(385,3542,1594,208),USE(NULLPVN),TRN,RIGHT
         STRING('Count'),AT(4323,1354,938,208),USE(?String14:5),CENTER
         STRING('Price'),AT(5469,1354,990,208),USE(?String14:6),CENTER
         STRING('Currency'),AT(6510,1354,573,208),USE(?String14:7),CENTER
       END
       FOOTER,AT(200,10000,8000,1000)
       END
     END


Datawindow WINDOW('Dati Lasotras rçíinam'),AT(,,272,161),GRAY
       ENTRY(@s45),AT(85,22),USE(IeAdrese,,?ieadrese1)
       STRING('Iekrauðanas adrese'),AT(11,25),USE(?String91)
       ENTRY(@d6),AT(85,37),USE(IeDatums,,?iedatums1)
       STRING('Iekrauðanas datums'),AT(11,41),USE(?String2)
       ENTRY(@s45),AT(85,52),USE(IzAdrese,,?izadrese1)
       STRING('Izkrauðanas adrese'),AT(11,56),USE(?String81)
       ENTRY(@d6),AT(85,66),USE(IzDatums,,?izdatums1)
       STRING('Izkrauðanas datums'),AT(11,69),USE(?String71)
       ENTRY(@s45),AT(84,81),USE(k_saturs,,?k_saturs1)
       STRING('Kravas saturs'),AT(12,84),USE(?String61)
       ENTRY(@s10),AT(84,96),USE(vnr,,?vnr1)
       STRING('Vilcçja Nr'),AT(12,99),USE(?String51)
       ENTRY(@s10),AT(84,111),USE(pnr,,?pnr1)
       STRING('Piekabes Nr'),AT(12,114),USE(?String41)
       LIST,AT(159,111,60,12),USE(p:nullpvnp,,P:NULLPVN:2),DROP(4),FROM(p_table)
       BUTTON('Latviski'),AT(15,138,35,14),USE(?LATVENG)
       BUTTON('&OK'),AT(179,138,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(217,138,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  IeDatums=gg:dokdat
  IzDatums=gg:dokdat
  ButtonRekinsGG#=FALSE

  P:NULLPVNP=''
  ADD(P_TABLE)
  P:NULLPVNP='28.p.4.'
  ADD(P_TABLE)
  P:NULLPVNP='7.p.1.d.2.p.'
  ADD(P_TABLE)
  P:NULLPVNP='7.p.1.d.3.p.'
  ADD(P_TABLE)
  GET(P_TABLE,1)

  OPEN(DATAWINDOW)
  ACCEPT
    CASE FIELD()
    OF ?LATVENG
      CASE EVENT()
      OF EVENT:Accepted
        IF LATVENG
           LATVENG=0
           ?LATVENG{PROP:TEXT}='Latviski'
        ELSE
           LATVENG=1
           ?LATVENG{PROP:TEXT}='Angliski'
        .
        DISPLAY
      END
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
        BREAK
      END
    END
  END
  CLOSE(DATAWINDOW)
  IF LocalResponse = RequestCancelled
     RETURN
  .

!  PUSHBIND
  IF GGK::USED=0
     checkopen(ggk,1)
  .
  GGK::USED+=1

  RPT_GADS=year(gg:dokdat)
  RPT_DATUMS=day(gg:dokdat)
  RPT_MENESIS=MENVAR(gg:dokdat,2,2)
  regnr=GETPAR_K(GG:PAR_NR,0,8)
  kurss=bankurs(gg:val,gg:dokdat)

  CLEAR(GGK:RECORD)
  GGK:U_NR=GG:U_NR
  SET(GGK:NR_KEY,GGK:NR_KEY)
  LOOP
     NEXT(GGK)
     IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
     I#+=1
     BKK[I#]=GGK:BKK
     BKK_SUMMAS[I#]=GGK:SUMMA
     IF (GGK:BKK[1]='6' AND GGK:D_K='K') !IEÒÇMUMI
        SUMMALS+=GGK:SUMMA
        SUMMAV+=GGK:SUMMAV
        PROJ_NR=GGK:OBJ_NR
     ELSIF (GGK:BKK[1:4]='5721' AND GGK:D_K='K') !PVN
        PVNSUMMAV+=GGK:SUMMAV
        PVNSUMMA+=GGK:SUMMA
        PVN_PR=GGK:PVN_PROC
     .
  .
!  IF PVN_PR=0
  IF P:NULLPVNP
     IF LATVENG
        NULLPVN='VAT 0% acc.'
     ELSE
        NULLPVN='PVN 0% sask. ar Lik.'
    .
!  ELSE
!     P:NULLPVNP=''
  .
  KOPAV=SUMMAV+PVNSUMMAV
  KOPALS=SUMMALS+PVNSUMMA
  OPEN(Report)
   Report{Prop:Preview} = PrintPreviewImage
   IF LATVENG
      PRINT(RPT:detailENG)
   ELSE
      PRINT(RPT:detail)
   .
   ENDPAGE(Report)
   PR:SKAITS=2
   RP
   IF LOCALresponse = RequestCompleted
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
  CLOSE(Report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
!  POPBIND
  RETURN
