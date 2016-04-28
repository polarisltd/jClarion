                     MEMBER('winlats.clw')        ! This is a MEMBER module
IntMaker PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
sak_dat              LONG
bei_dat              LONG
avota_nr             BYTE
nokl_c               BYTE
NOLASITS             USHORT
SKAITS          DECIMAL(10,3)
CENA            DECIMAL(10,3)

N_TABLE         QUEUE,PRE(N)
NOMENKLAT          STRING(21)
SKAITS             DECIMAL(10,3)
CENA               DECIMAL(10,3)
PVN_PROC           BYTE
ARBYTE             BYTE
                .

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
window               WINDOW('Caption'),AT(,,384,140),FONT('MS Sans Serif',9,,FONT:bold),CENTER,GRAY
                       STRING(@n6B),AT(121,12),USE(NOLASITS)
                       STRING(@s21),AT(153,12),USE(NOMENKLAT)
                       STRING('Tiks izveidota D (ienâkoðâ-iekðçjâ pârvietoðana) P/Z tekoðajâ'),AT(21,40),USE(?String1)
                       STRING(@n3),AT(226,40),USE(LOC_NR),RIGHT(1)
                       STRING('. noliktavâ '),AT(243,40),USE(?String3)
                       ENTRY(@d06.B),AT(145,52),USE(sak_dat)
                       STRING('lîdz'),AT(203,53),USE(?String4)
                       ENTRY(@d06.B),AT(222,52),USE(bei_dat)
                       ENTRY(@n3),AT(245,69),USE(avota_nr)
                       STRING('pçc realizâcijas fakta ðajâ nol. no'),AT(29,53),USE(?String9)
                       STRING('un atbilstoða K (izejoðâ) P/Z "avota" noliktavâ Nr'),AT(79,72),USE(?String6)
                       STRING('cenas.'),AT(226,89),USE(?String7)
                       BUTTON('Iekïaut tikai tâs preces, kam ir negatîvi atlikumi tekoðajâ noliktavâ'),AT(11,105,248,14),USE(?ButtonNegAtl)
                       IMAGE('CHECK3.ICO'),AT(263,101,17,18),USE(?Image:DTK),HIDE
                       STRING(' Iekðçjo pârvietoðanu veikt pçc'),AT(98,89),USE(?String10)
                       ENTRY(@n1),AT(206,88),USE(nokl_c)
                       BUTTON('&OK'),AT(300,122,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(340,122,36,14),USE(?CancelButton)
                       BUTTON('Iekïaut tikai tâs preces, kas neveido negatîvus atlikumus avota noliktavâ'),AT(10,121,249,14),USE(?ButtonNotNegAtt)
                       IMAGE('CHECK3.ICO'),AT(263,119,17,18),USE(?Image:IDP),HIDE
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  AVOTA_NR=1
  nokl_c=6
  Sak_DAT=TODAY()
  Bei_DAT=TODAY()
  NOMENKLAT=''
  F:DTK = ''
  F:IDP = ''
  
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
      SELECT(?NOLASITS)
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
    OF ?ButtonNegAtl
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK = ''
           HIDE(?IMAGE:DTK)
        ELSE
           F:DTK = '1'
           UNHIDE(?IMAGE:DTK)
        END
        DISPLAY           
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF AVOTA_NR=LOC_NR OR ~INRANGE(AVOTA_NR,1,NOL_SK)
              KLUDA(0,'Nepareizi norâdîts avota Nr: '&AVOTA_NR)
           ELSE
              CHECKOPEN(NOLIK,1)
              FILENAME1='PAVAD'&FORMAT(AVOTA_NR,@N02)
              FILENAME2='NOLIK'&FORMAT(AVOTA_NR,@N02)
              CHECKOPEN(PAVA1,1)
              CHECKOPEN(NOLI1,1)
        
              DO SCROLLFILE
              DO MAKEDPZ
              DO MAKEKPZ
              FREE(N_TABLE)
              CLOSE(PAVA1)
              CLOSE(NOLI1)
           .
           BREAK
        
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           BREAK
      END
    OF ?ButtonNotNegAtt
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:IDP
           F:IDP = ''
           HIDE(?IMAGE:IDP)
        ELSE
           F:IDP = '1'
           UNHIDE(?IMAGE:IDP)
        END
        DISPLAY           
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IntMaker','winlats.INI')
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
    INISaveWindow('IntMaker','winlats.INI')
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
!-----Lasam REALIZÂCIJU tekoðajâ noliktavâ------------------------------------------------------------------

SCROLLFILE  ROUTINE
  CLEAR(NOL:RECORD)
  NOL:D_K='K'
  NOL:DATUMS=SAK_DAT
  SET(NOL:DAT_KEY,NOL:DAT_KEY)
  LOOP
    NEXT(NOLIK)
    IF ERROR() OR ~(INRANGE(NOL:DATUMS,SAK_DAT,BEI_DAT)) THEN BREAK.
    IF ~(NOL:D_K='K') THEN CYCLE.
    IF NOL:RS THEN CYCLE.  !TIKAI APSTIPRINÂTÂS
    IF F:DTK AND GETNOM_A(NOL:NOMENKLAT,1,0)>0 THEN CYCLE. !JA PIEPRASÎTS TIKAI AR - ATLIKUMIEM
    NOLASITS+=1
    DISPLAY(?NOLASITS)
    NOMENKLAT=NOL:NOMENKLAT
    DISPLAY
    CENA=GETNOM_K(NOL:NOMENKLAT,2,7,NOKL_C)
    IF NOM:TIPS='A' THEN CYCLE.
    SKAITS=NOL:DAUDZUMS
    DO FILLNTABLE
  .
!-------------------------------------------------------------------------------------------
 
FILLNTABLE ROUTINE
    GET(N_TABLE,0)
    N:NOMENKLAT=NOMENKLAT
    GET(N_TABLE,N:NOMENKLAT)
    IF ERROR()
       N:NOMENKLAT=NOMENKLAT
       N:SKAITS=SKAITS
       N:CENA=CENA
       N:PVN_PROC=NOM:PVN_PROC
       N:ARBYTE=0            !bez pvn
       IF GETNOM_K('POZICIONÇTS',0,10,NOKL_C)
          N:ARBYTE=1
       .
       ADD(N_TABLE)
       SORT(N_TABLE,N:NOMENKLAT)
    ELSE
       N:SKAITS+=SKAITS
       PUT(N_TABLE)
    .
 
!-----BÛVÇJAM IENÂKOÐO TEKOÐAJÂ NOLIKTAVÂ--------------------------------------------------

MAKEDPZ   ROUTINE
  IF RECORDS(N_TABLE)
     DO AUTONUMBER
     PAV:D_K='D'
     PAV:DOKDAT=BEI_DAT
     PAV:DATUMS=BEI_DAT
     PAV:NOKA='NOL'&CLIP(AVOTA_NR)
     PAV:PAR_NR=AVOTA_NR
     PAV:PAMAT='Iekðçjâ.pârv. '&day(sak_dat)&'-'&format(bei_dat,@d06.)
     PAV:VAL='Ls'
     PAV:NODALA=SYS:NODALA
     PAV:ACC_KODS=ACC_KODS
     PAV:ACC_DATUMS=TODAY()
     PUT(PAVAD)                           ! DROÐÎBAS PÇC
     IF ERROR() THEN STOP(ERROR()).
     GET(N_TABLE,0)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        NOLASITS+=1
        NOMENKLAT=N:NOMENKLAT
        DISPLAY
        IF F:IDP AND GETNOM_A(N:NOMENKLAT,1,0,AVOTA_NR)<N:SKAITS !JA PIEPRASÎTS NEVEIDOT - ATLIKUMUS AVOTAM
           N:SKAITS=GETNOM_A(N:NOMENKLAT,1,0,AVOTA_NR)
        .
        IF N:SKAITS > 0
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           NOL:DATUMS=PAV:DATUMS
           NOL:NOMENKLAT=N:NOMENKLAT
           NOL:PAR_NR=PAV:PAR_NR
           NOL:D_K=PAV:D_K
           NOL:DAUDZUMS=N:SKAITS
           AtlikumiN('D',NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
           KopsN(NOL:NOMENKLAT,NOL:DATUMS,'D')
           NOL:SUMMA=N:CENA*NOL:DAUDZUMS
           NOL:SUMMAV=N:CENA*NOL:DAUDZUMS
           NOL:ARBYTE=N:ARBYTE
           NOL:PVN_PROC=N:PVN_PROC
           NOL:VAL='Ls'
           ADD(NOLIK)
           IF ERROR()
              STOP('KÏÛDA RAKSTOT D-P/Z:'&N:NOMENKLAT&' NOLIKTAVÂ:'&LOC_NR&':'&ERROR())
           .
           IF N:ARBYTE=0
             PAV:SUMMA+=NOL:SUMMA*(1+N:PVN_PROC/100)   
           ELSE
             PAV:SUMMA+=NOL:SUMMA
           .
        .
     .
     PUT(PAVAD)   !FIX SUMMU
  ELSE
     KLUDA(0,' Nav atrasta neviena K-P/Z ðajâ noliktavâ '&day(sak_dat)&'-'&format(bei_dat,@d06.))
  .
!-------------------------------------------------------------------------------------------

MAKEKPZ   ROUTINE
  IF RECORDS(N_TABLE)
     DO AUTONUMBER_AVOTS
     PA1:D_K='K'
     PA1:DOKDAT=BEI_DAT
     PA1:DATUMS=BEI_DAT
     PA1:NOKA='NOL'&CLIP(LOC_NR)
     PA1:PAR_NR=LOC_NR
     PA1:PAMAT='Iekðçjâ.pârv. '&day(sak_dat)&'-'&format(bei_dat,@d6)
     PA1:VAL='Ls'
     PA1:NODALA=SYS:NODALA
     PA1:ACC_KODS=ACC_KODS
     PA1:ACC_DATUMS=TODAY()
     PUT(PAVA1)
     IF ERROR() THEN STOP(ERROR()).
     GET(N_TABLE,0)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        NOLASITS+=1
        NOMENKLAT=N:NOMENKLAT
        DISPLAY
        IF F:IDP AND GETNOM_A(N:NOMENKLAT,1,0,AVOTA_NR)<N:SKAITS !JA PIEPRASÎTS NEVEIDOT - ATLIKUMUS AVOTAM
           N:SKAITS=GETNOM_A(N:NOMENKLAT,1,0,AVOTA_NR)
        .
        IF N:SKAITS > 0
           CLEAR(NO1:RECORD)
           NO1:U_NR=PA1:U_NR
           NO1:DATUMS=PA1:DATUMS
           NO1:NOMENKLAT=N:NOMENKLAT
           NO1:PAR_NR=PA1:PAR_NR
           NO1:D_K=PA1:D_K
           NO1:DAUDZUMS=N:SKAITS
           AtlikumiN('K',NO1:NOMENKLAT,NO1:DAUDZUMS,'','',0,avota_nr)
           KopsN(NO1:NOMENKLAT,NO1:DATUMS,'K')
           NO1:SUMMA=N:CENA*NO1:DAUDZUMS
           NO1:SUMMAV=N:CENA*NO1:DAUDZUMS
           NO1:ARBYTE=N:ARBYTE
           NO1:PVN_PROC=N:PVN_PROC
           NO1:VAL='Ls'
           ADD(NOLI1)
           IF ERROR()
              STOP('KÏÛDADA RAKSTOT K-P/Z:'&N:NOMENKLAT&' NOLIKTAVÂ:'&AVOTA_NR&':'&ERROR())
           .
           IF N:ARBYTE=0
             PA1:SUMMA+=NO1:SUMMA*(1+N:PVN_PROC/100)
           ELSE
             PA1:SUMMA+=NO1:SUMMA
           .
        .
     .
     PUT(PAVA1)
  .
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
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
Autonumber_AVOTS ROUTINE    ! LASOT UZ AVOTA PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PA1:NR_KEY)
    PREVIOUS(PAVA1)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVA1')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PA1:U_NR + 1
    END
    clear(PA1:Record)
    PA1:DATUMS=TODAY()
    PA1:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVA1)
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

R_TXTAB              PROCEDURE (OPC)              ! Declare Procedure
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordsProcessed     ULONG
RecordsToProcess     ULONG
PercentProgress      BYTE
RecordsPerCycle      BYTE
KODS_NOM             STRING(21)
SUMMA_A              DECIMAL(12,2)
zina                 STRING(40)
jauni                ULONG
mainiti              ULONG
kludaini             ULONG
FILTRS               STRING(14)
window WINDOW('Apmaiòas faila lasîðana...'),AT(,,190,60),CENTER,TIMER(1),GRAY,DOUBLE,MDI
       STRING(@s40),AT(3,4,178,10),USE(zina),CENTER
       STRING(@s59),AT(3,12,179,10),USE(FILENAME1),CENTER
       BUTTON('&OK'),AT(101,40,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(139,40,35,14),USE(?ButtonCancel)
     END

TXTAB       FILE,PRE(TX),DRIVER('ASCII'),NAME(FILENAME1),CREATE
RECORD             RECORD
LINE                 STRING(200)
                 . .

!--------------INET ÐITO MÇÌINAM SALÂGOT AR VIESTURU&SANTEKO
I:NOMENKLAT    STRING(21)              !NOMENKLATÛRA (EAN KODS?)
I:NOSAUKUMS    STRING(50)              !NOSAUKUMS
I:CENA         STRING(10)              !CENA
I:DAUDZUMS     STRING(10)              !DAUDZUMS
I:TEKSTS       STRING(109)             !PASÛTÎTÂJA TEKSTS,ATSEVIÐÍA RINDA, SÂKAS AR *

!--------------TAMRO
T:KODS         STRING(13)              !EAN KODS
T:DAUDZUMS     STRING(10)              !DAUDZUMS
T:NOSAUKUMS    STRING(40)              !NOSAUKUMS
T:CENA         STRING(10)              !CENA
T:SUMMA        STRING(10)              !SUMMA
T:APV          STRING(3)               !ATTIECÎBA PRET PAMATVIENÎBU
T:DER_TER      STRING(10)              !DERÎGUMA TERMIÒÐ
T:EAN          STRING(13)              !EAN KODS
T:ARTIKULS     STRING(1)               !ARTIKULS
T:SERIJA       STRING(16)              !SÇRIJA
T:KURVA        STRING(1)
T:P_CENA       STRING(10)              !PÂRDOÐANAS CENA
T:I_CENA       STRING(10)              !CENA
T:ATLAIDE_PR   STRING(5)               !ATLAIDES %

!--------------VP
V:D1           STRING(5)
V:D2           STRING(1)
V:KODS0        STRING(18)              !EAN KODS
V:KODS         STRING(18)              !EAN KODS
V:D3           STRING(35)
V:DAUDZUMS     STRING(14)              !DAUDZUMS
V:D4           STRING(2)
V:CENA         STRING(14)              !CENA
V:D5           STRING(5)
V:D6           STRING(2)
V:SUMMA        STRING(14)              !SUMMA
V:NOSAUKUMS    STRING(40)              !NOSAUKUMS

!--------------AGB,SILDA
A:NOMENKLAT    STRING(21)              !NOMENKLATÛRA (EAN KODS?)
A:KATALOGA_NR  STRING(22)              !KATALOGA_NR
A:NOSAUKUMS    STRING(19)              !NOSAUKUMS
A:MERVIEN      STRING(4)               !CENA
A:CENA         STRING(7)               !CENA
A:DAUDZUMS     STRING(9)               !DAUDZUMS
A:SUM          STRING(9)               !SUMMA

!--------------VW
W:KATALOGA_NR  STRING(18)              !RAÞOTÂJA KODS
W:NOSAUKUMS1   STRING(13)              !NOS_VÂCISKI
W:NOSAUKUMS2   STRING(13)              !NOS_ANGLISKI
W:DG           STRING(1)               !ATLAIDES GRUPA
W:CENA         STRING(22)              !CENA


DOSFILES    QUEUE,PRE(A)
NAME           STRING(FILE:MAXFILENAME)
SHORTNAME      STRING(13)
DATE           LONG
TIME           LONG
SIZE           LONG
ATTRIB         BYTE
            .

BAITS        BYTE
EAN_NR       DECIMAL(13)
NOM4         STRING(4)
NOM17        STRING(17)
VP_NOS       STRING(7)
KODS_S       STRING(13)
TXTFAILI     BYTE
VP_PAR_NR    ULONG
NOM_REALIZ   LIKE(NOM:REALIZ[1])
NOM_DG       LIKE(NOM:DG)
NOM_NOMENKLAT LIKE(NOM:NOMENKLAT)
IV2PZ        STRING(210)
IV2PZM       STRING(21),DIM(10),OVER(IV2PZ)
VELREIZ      BYTE
OTRAREIZE    BYTE
TEKOSA       BYTE
PAV_VAL      LIKE(PAV:VAL)

NEWSCREEN WINDOW('Caption'),AT(,,226,78),GRAY
       STRING(@s40),AT(42,10),USE(T:NOSAUKUMS)
       ENTRY(@s4),AT(110,23),USE(nom4),REQ,UPR
       ENTRY(@s17),AT(137,23),USE(nom17),UPR
       STRING('Ievadiet grupu un apakðgrupu'),AT(10,24),USE(?String2)
       ENTRY(@N2),AT(112,40),USE(NOM:PVN_PROC)
       STRING('PVN %'),AT(85,42),USE(?String1)
       BUTTON('OK'),AT(167,56,35,14),USE(?Ok),DEFAULT
       STRING('Uzcenojuma % 5 cenai'),AT(36,57),USE(?String4)
       ENTRY(@N3),AT(113,55),USE(NOM:PROC5)
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,141,57),CENTER,TIMER(1),GRAY,DOUBLE,MDI
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       STRING(@S21),AT(54,42),USE(KODS_NOM),CENTER
       BUTTON('Atlikt'),AT(1,42,50,15),USE(?Progress:Cancel),DISABLE,HIDE
     END

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
Auto::Save:TEX:NR     LIKE(TEX:NR)
  CODE                                            ! Begin processed code
 CASE OPC
 OF 1     !TAMRO
    FILENAME1='TA.TXT'
    TXTFAILI=1
 OF 2     !VP
    DIRECTORY(DOSFILES,CLIP(PATH())&'\VP\*.TXT',FF_:NORMAL)
    IF RECORDS(DOSFILES)= 0
       KLUDA(120,'neviens txt fails folderî '&CLIP(PATH())&'\VP\')
       DO PROCEDURERETURN
    ELSE
       SORT(DOSFILES,-A:DATE)
       TXTFAILI=RECORDS(DOSFILES)
       FILENAME1='Atrasti '&clip(txtfaili)&' *.txt faili folderî \VP'
    .
 OF 3    !INET
    FILTRS='\INET\I'&FORMAT(LOC_NR,@N02)&'*.TXT'  !14
!    DIRECTORY(DOSFILES,CLIP(LONGPATH())&'\INET\I*.TXT',FF_:NORMAL)
    DIRECTORY(DOSFILES,CLIP(LONGPATH())&FILTRS,FF_:NORMAL)
    IF RECORDS(DOSFILES)= 0
       KLUDA(120,'neviens I'&FORMAT(LOC_NR,@N02)&'*.txt fails folderî '&CLIP(LONGPATH())&'\INET')
       DO PROCEDURERETURN
    ELSE
       SORT(DOSFILES,-A:DATE)
       TXTFAILI=RECORDS(DOSFILES)
       FILENAME1='Atrasti '&clip(txtfaili)&' I*.txt faili folderî \INET'
    .
 OF 4     !AGB
    FILENAME1=LONGPATH()&'\IMPEXP\VEDLEGG.TXT'
    TXTFAILI=1
 OF 5     !VW
    FILENAME1=LONGPATH()&'\IMPEXP\VW_Cenas.TXT'
    TXTFAILI=1
 OF 6     !invoice.txt Îlei-no-Silda
    FILENAME1=LONGPATH()&'\IMPEXP\INVOICE.TXT'
    TXTFAILI=1
 OF 7     !Subaru
    FILENAME1=LONGPATH()&'\IMPEXP\Subaru_Cenas.RTF'
    TXTFAILI=1
    IF ~OPENANSI('KLUDAS.TXT')
       DO PROCEDURERETURN
    .
    OUTA:LINE='   KÏÛDAS NOM_K :'
    ADD(OUTFILEANSI)
 .

 OPEN(WINDOW)
 ACCEPT
   CASE FIELD()
   OF ?ButtonCancel
      CASE EVENT()
      OF EVENT:Accepted
         DO PROCEDURERETURN
      .
   OF ?OKBUTTON
      CASE EVENT()
      OF EVENT:Accepted
        !  ATRODAMIES TEKOÐÂ DIREKTORIJÂ
        !
        !  INET: TEKOÐÂ FOLDERA APAKÐFOLDERIS\INET FAILS IYYMMDDPPPPPPNNNN.TXT
        !        LAUKU ATDALÎTÂJS TAB VAI ','
        !        PÇC VEIKSMÎGAS NOLASÎÐANAS DZÇÐ
        !
!        HIDE(?OkButton)
!        HIDE(?ButtonCANCEL)
!        DISPLAY
        CHECKOPEN(NOM_K,1)
        CHECKOPEN(TEKSTI,1)
        BREAK
      .
   .
 .
 CLOSE(WINDOW)

 LOOP R#=1 TO TXTFAILI !TIKAI I-NET BÛS VAIRÂK KÂ 1.
    IF OPC=2     !VP
       GET(DOSFILES,R#)
       FILENAME1=CLIP(LONGPATH())&'\VP\'&A:NAME
    ELSIF OPC=3  !INET
       GET(DOSFILES,R#)
       FILENAME1=CLIP(LONGPATH())&'\INET\'&A:NAME
       IF LEN(CLIP(A:NAME))<21
          KLUDA(0,'NEPAREIZS FAILA VÂRDS: '&FILENAME1)
          CYCLE
       .
    !1-TAMRO,4-AGB,5,7-VW,Subaru FIKSÇTS FAILA VÂRDS
    .
    SUMMA_A=0
    OPEN(TXTAB)
    IF ERROR()
       KLUDA(0,'Nav atrodams fails: '&FILENAME1)
       CLOSE(TXTAB)
       DO PROCEDURERETURN
    .
    SEND(TXTAB,'TAB=-100')
    IF ~(OPC=5 OR OPC=7)
       DO AUTONUMBER
       PAV_VAL=val_uzsk !01/01/2014
       CASE OPC
       OF 1
          PAV:D_K='D'
          PAV:DOKDAT=TODAY()
          PAV:PAMAT='IMPORTS NO TAMRO:TXT'
       OF 2
          PAV:D_K='P'
          PAV:DOKDAT=TODAY()
          PAV:PAMAT='IMPORTS NO VP:TXT'
       OF 3  !INET
          PAV:D_K='P'
          PAV:DOKDAT=DEFORMAT(A:NAME[4:9],@D11)   !yymmdd
          PAV:PAR_NR=A:NAME[10:15] !NOSAUKUMÂ IR U_NR nnnnnn 6
          IF OTRAREIZE
             PAV:DOK_SENR='PI '&A:NAME[16:20]&'-2'   !nnnnn 5
          ELSE
             PAV:DOK_SENR='PI '&A:NAME[16:20]        !nnnnn 5
          .
          PAV:PAMAT='I-NET '&FORMAT(TODAY(),@D06.)
          IV1#=0
          IV2#=0  !SKAITÎTÂJS RAKSTIEM AKCÎZES(1v2)P/Z
       OF 4  !ÎLES AGB
          PAV:D_K='D'
          PAV:DOKDAT=TODAY()
          PAV:PAMAT='IMPORTS NO AGB'
          PAV:PAR_NR=3646 !ÎLES AGB Nr
       OF 6  !ÎLES SILDA
          PAV:D_K='D'
          PAV:DOKDAT=TODAY()
          PAV:PAMAT='IMPORTS NO SILDA'
          PAV:PAR_NR=6105 !ÎLES SILDA Nr
          PAV_VAL='LTL'
       .
       PAV:NOKA=GETPAR_K(PAV:PAR_NR,2,1) !Pozicionçjam PAR_K DÇÏ ATLAIDES
       FILLPVN(0)
    .

    RecordsToProcess = BYTES(TXTAB)/180 !5
    RecordsProcessed = 0
    PercentProgress = 0
    ?Progress:UserString{Prop:Text}=''
    OPEN(ProgressWindow)
    Progress:Thermometer = 0
    RecordsPerCycle = 50
    ?Progress:PctText{Prop:Text} = '0%'
    LocalResponse = RequestCompleted
    ACCEPT
       CASE EVENT()
       OF Event:OpenWindow
          SET(TXTAB)
       OF Event:Timer
          LOOP RecordsPerCycle TIMES
             NEXT(TXTAB)
             IF ERROR()
!             IF ERROR() OR (opc=7 AND RecordsProcessed > 500)  !TESTA STOPS
                LocalResponse = RequestCancelled
                POST(Event:CloseWindow)
                BREAK
             .
             RecordsProcessed += 1
             ?Progress:UserString{Prop:Text}=RecordsProcessed
             DISPLAY(?Progress:UserString)
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
             CASE OPC
             OF 1
                IF RecordsProcessed<6 THEN CYCLE.
                DO FILLGROUPT
                KODS_NOM=T:KODS
             OF 2   !vp
                IF RecordsProcessed=5
                   VP_PAR_NR=0
                   VP_NOS='VPR-'&TX:LINE[2:4]  !R54=VPR-54
                   CLEAR(PAR:RECORD)
                   PAR:NOS_A=VP_NOS
                   GET(PAR_K,PAR:NOS_KEY)
                   IF ERROR() 
                      KLUDA(0,'Nav atrodams saîsinâtais nosaukums '&CLIP(VP_NOS))
                      NOKL_CP#=1
                   ELSE
                      VP_PAR_NR=PAR:U_NR
                      NOKL_CP#=PAR:GRUPA[3]
                      IF ~INRANGE(NOKL_CP#,1,5)
                         KLUDA(0,'Nepareizi/Nav norâdîta cenu grupa '&CLIP(VP_NOS))
                         NOKL_CP#=1
                      .
                   .
                   IF ~VP_PAR_NR
                      KLUDA(0,'Nav atrodams saîsinâtais nosaukums '&CLIP(VP_NOS))
                   .
                   PAV:MAK_NR=253  !LIELAIS VP
                .
                IF RecordsProcessed<9 THEN CYCLE.
                DO FILLGROUPV
                KODS_S=LEFT(V:KODS)
                IF KODS_S[1:2]='20' !PRIVÂTAIS SVERAMAIS KODS
                   KODS_NOM=V:KODS0
                ELSE
                   KODS_NOM=V:KODS
                .
             OF 3  !INET
                DO FILLGROUPI
                KODS_NOM=I:NOMENKLAT
             OF 4 !AGB
                IF TX:LINE[1:4]='KOPÂ' THEN BREAK.
                IF TX:LINE[1:6]='RÇÍINS' THEN PAV:DOK_SENR=LEFT(TX:LINE[21:30]).
                IF TX:LINE[1:8]='PIEZÎMES' THEN TABULA#=TRUE.
                IF TABULA#
                   IF NUMERIC(TX:LINE[16])
                      DO FILLGROUPA
                      KODS_NOM=A:NOMENKLAT
                   ELSE
                      CYCLE
                   .
                ELSE
                   CYCLE
                .
             OF 5 !VW
                IF RecordsProcessed<2 THEN CYCLE.
                DO FILLGROUPW
                KODS_NOM=W:KATALOGA_NR
             OF 6 !SILDA
                LEN#=LEN(CLIP(TX:LINE))
                IF TX:LINE[1:3]='VAT' THEN PAV:DOK_SENR='SLD '&LEFT(TX:LINE[24:LEN#]).
                IF TX:LINE[1:4]='Pos.' THEN TABULA#=TRUE.
                IF TABULA#
                   IF NUMERIC(TX:LINE[1]) !POS.
                      DO FILLGROUPAA
                      KODS_NOM=A:NOMENKLAT
                   ELSE
                      CYCLE
                   .
                ELSE
                   CYCLE
                .
             OF 7 !Subaru
                DO FILLGROUPS
                KODS_NOM=W:KATALOGA_NR
             .
!*************************************** TAISAM NOM_K....
             IF KODS_NOM
                CLEAR(NOM:RECORD)
                GET(NOM_K,0)
                IF OPC=3 OR OPC=6
                   NOM:NOMENKLAT=KODS_NOM
                   GET(NOM_K,NOM:NOM_KEY)
                ELSIF OPC=4 OR OPC=5 OR OPC=7
                   NOM:KATALOGA_NR=KODS_NOM
                   GET(NOM_K,NOM:KAT_KEY)
                ELSE
                   NOM:KODS=KODS_NOM
                   GET(NOM_K,NOM:KOD_KEY)
                .
                IF ERROR() !JAUNA NOMENKLATÛRA(KODS)
                   NOM:mervien  ='gab.'
                   NOM:TIPS='P'
                   NOM:PVN_PROC=SYS:NOKL_PVN
                   NOM:STATUSS='0{25}'
                   NOM17=T:SERIJA
                   CASE OPC
                   OF 1  !--------------------------------------------------------TAMRO
                      KLUDA(17,'EAN-KODS: '&KODS_NOM&' '&T:NOSAUKUMS)
                      NOM:NOS_P=T:NOSAUKUMS
                      NOM:DER_TERM=DEFORMAT(T:DER_TER,@D6.)
                      NOM:ARPVNBYTE=31 !VISAS AR PVN
                      NOM:PIC=ROUND(T:SUMMA/T:DAUDZUMS,.0001)
                      NOM:PIC_DATUMS=TODAY()
                      OPEN(NEWSCREEN)
                      DISPLAY
                      ACCEPT
                         CASE FIELD()
                         OF ?Ok
                            CASE EVENT()
                            OF EVENT:Accepted
                               IF NOM4 AND NOM:PVN_PROC=0 OR NOM:PVN_PROC=5 OR NOM:PVN_PROC=18
                                  BREAK
                               .
                            .
                         .
                      END
                      CLOSE(NEWSCREEN)
                      NOM:nomenklat=NOM4&NOM17
                   OF 2  !----------------------------------------------------------VP
                      KLUDA(17,'EAN-KODS: '&KODS_NOM&' '&V:NOSAUKUMS)
                      NOM:ARPVNBYTE=0 !VISAS BEZ PVN
                      NOM:NOS_P=V:NOSAUKUMS
                      NOM:nomenklat='????'&KODS_NOM
                      NOM:REALIZ[1]=V:CENA
                   OF 3  !----------------------------------------------------------INET
                      KLUDA(17,'Nomenklatûra: '&KODS_NOM&' '&I:NOSAUKUMS)
                      NOM:ARPVNBYTE=1 !PIRMÂ AR PVN
                      NOM:NOS_P='?'&I:NOSAUKUMS
                      NOM:NOS_S='?'&I:NOSAUKUMS[1:15]
                      NOM:nomenklat=KODS_NOM
                      NOM:REALIZ[1]=I:CENA
                   OF 4  !-------------------------------------------------------AGB P/Z
                      KLUDA(17,'KODS: '&KODS_NOM&' '&A:NOSAUKUMS)
                      NOM:ARPVNBYTE=0 !VISAS BEZ PVN
                      NOM:NOS_P=A:NOSAUKUMS
                      NOM:NOS_S=A:NOSAUKUMS
                      NOM:NOS_A=INIGEN(NOM:NOS_S,8,1)
                      IF NUMERIC(A:KATALOGA_NR[4])
                         NOM:nomenklat='OR '&A:KATALOGA_NR[4]&CLIP(A:KATALOGA_NR)
                      ELSE
                         NOM:nomenklat='OR 0'&CLIP(A:KATALOGA_NR)
                      .
                      NOM:KATALOGA_NR=A:KATALOGA_NR
                      NOM:PIC=A:CENA
                      NOM:REALIZ[5]=A:CENA*(1+SYS:NOKL_PVN/100)
                      NOM:PIC_DATUMS=TODAY()
                   OF 5  !-------------------------------------------------------VW
                      NOM:IZC_V_KODS='DE'  !VÂCIJA
                      NOM:ARPVNBYTE=31     !PIRMÂS 5 AR PVN
                      NOM:NOS_P='?'&CLIP(W:NOSAUKUMS1)&'/'&W:NOSAUKUMS2
                      NOM:NOS_S='?'&CLIP(W:NOSAUKUMS1)&'/'&W:NOSAUKUMS2
                      NOM:NOS_A=INIGEN(NOM:NOS_S,8,1)
                      IF NUMERIC(W:KATALOGA_NR[4])
                         NOM:nomenklat='OR '&W:KATALOGA_NR[4]&CLIP(W:KATALOGA_NR)
                      ELSE
                         NOM:nomenklat='OR 0'&CLIP(W:KATALOGA_NR)
                      .
                      NOM:mervien  ='GAB'
                      LOOP I#=1 TO 10
                         IF DUPLICATE(NOM:NOM_KEY)
                            NOM:NOMENKLAT=CLIP(NOM:NOMENKLAT)&I#
                         ELSE
                            BREAK
                         .
                      .
                      NOM:KATALOGA_NR=W:KATALOGA_NR
                      IF ~NOM:PVN_PROC THEN NOM:PVN_PROC=21.
                      NOM:REALIZ[1]=ROUND(W:CENA/100*(1+NOM:PVN_PROC/100),.01) !AR PVN
                      NOM:DG=W:DG
                      JAUNI+=1
                   OF 6  !-------------------------------------------------SILDA INVOICE
                      KLUDA(17,'KODS: '&KODS_NOM)
                      NOM:ARPVNBYTE=0 !VISAS BEZ PVN
                      NOM:NOS_P='' !A:NOSAUKUMS
                      NOM:NOS_S='' !A:NOSAUKUMS
                      NOM:NOS_A='' !INIGEN(NOM:NOS_S,8,1)
                      NOM:nomenklat=A:NOMENKLAT
                      NOM:KATALOGA_NR=A:KATALOGA_NR
                      NOM:PIC=A:CENA*BANKURS(PAV_VAL,PAV:DATUMS)
                      NOM:REALIZ[5]=NOM:PIC*(1+SYS:NOKL_PVN/100)
                      NOM:PIC_DATUMS=TODAY()
                   OF 7  !-----------------------------------------------------------------Subaru
                      NOM:IZC_V_KODS='SE'  !Zviedrija
                      NOM:ARPVNBYTE=31     !PIRMÂS 5 AR PVN
                      NOM:NOS_P='?'&CLIP(W:NOSAUKUMS1)
                      NOM:NOS_S='?'&CLIP(W:NOSAUKUMS1)
                      NOM:NOS_A=INIGEN(NOM:NOS_S,8,1)
                      NOM:DG=W:DG
                      NOM:nomenklat='SR.'&NOM:DG&CLIP(W:KATALOGA_NR)
                      NOM:mervien  ='GAB'
                      LOOP I#=1 TO 10
                         IF DUPLICATE(NOM:NOM_KEY)
                            NOM:NOMENKLAT=CLIP(NOM:NOMENKLAT)&I#
                         ELSE
                            BREAK
                         .
                      .
                      NOM:KATALOGA_NR=W:KATALOGA_NR
                      NOM:PVN_PROC=22
!                      NOM:REALIZ[1]=ROUND(DEFORMAT(W:CENA,@N10.2)*(1+NOM:PVN_PROC/100),.01) !AR PVN EUR
                      NOM:REALIZ[1]=ROUND(DEFORMAT(W:CENA,@N10.2)*(1+NOM:PVN_PROC/100)*BANKURS('EUR',TODAY()),.01) !AR PVN
                      JAUNI+=1
                   .
                   NOM:ACC_KODS=ACC_KODS
                   NOM:ACC_DATUMS=TODAY()
                   ADD(NOM_K)
                   IF ERROR()
                      STOP('ADD NOM_K '&ERROR())
                   .
                ELSE   !NOMENKLATÛRA(kods) IR ATRASTA
                   CASE OPC
                   OF 4  !----------------------------------------------------AGB P/Z
                      NOM:REALIZ[5]=A:CENA*(1+SYS:NOKL_PVN/100)
                      NOM:PIC=A:CENA
                      NOM:PIC_DATUMS=TODAY()
                      NOM:ACC_KODS=ACC_KODS
                      NOM:ACC_DATUMS=TODAY()
                      IF NOM:NOS_P[1]='?'
                         NOM:NOS_P=A:NOSAUKUMS
                         NOM:NOS_S=A:NOSAUKUMS
                         NOM:NOS_A=INIGEN(NOM:NOS_S,8,1)
                         GLOBALREQUEST=2
                         UPDATENOM_K
                      ELSE
                         PUT(NOM_K)
                      .
                   OF 5  !--------------------------------------------------VW CENAS
                      NOM_REALIZ   =ROUND(W:CENA/100*(1+NOM:PVN_PROC/100),.01) !AR PVN
                      NOM_DG=W:DG
                      IF ~(NOM:REALIZ[1]=NOM_REALIZ AND NOM:DG=NOM_DG AND|
                         BAND(NOM:ARPVNBYTE,00000001B) AND NOM:IZC_V_KODS='DE')
                         IF ~BAND(NOM:ARPVNBYTE,00000001B)
                            NOM:ARPVNBYTE+=1     !PIRMÂ AR PVN
                         .
                         NOM:IZC_V_KODS='DE'  !VÂCIJA
                         NOM:REALIZ[1]=NOM_REALIZ
                         NOM:DG=NOM_DG
                         NOM:ACC_KODS=ACC_KODS
                         NOM:ACC_DATUMS=TODAY()
                         IF RIUPDATE:NOM_K()
                            KLUDA(24,'NOM_K')
                         .
                         MAINITI+=1
                      .
                   OF 7  !------------------------------------------------Subaru CENAS
!                      NOM_REALIZ =ROUND(DEFORMAT(W:CENA,@N10.2)*(1+NOM:PVN_PROC/100),.01) !AR PVN EUR
                      NOM_REALIZ =ROUND(DEFORMAT(W:CENA,@N10.2)*(1+NOM:PVN_PROC/100)*BANKURS('EUR',TODAY()),.01) !AR PVN
                      NOM_DG=W:DG
                      NOM_nomenklat='SR.'&NOM_DG&CLIP(W:KATALOGA_NR)
!                      IF ~(NOM:nomenklat=NOM_nomenklat)
!                         OUTA:LINE=NOM:nomenklat& 'jâbût '&NOM_nomenklat
!                         ADD(OUTFILEANSI)
!                         kludaini+=1
!                      .
                      IF ~(NOM:REALIZ[1]=NOM_REALIZ AND NOM:DG=NOM_DG AND|
                         BAND(NOM:ARPVNBYTE,00000001B))
                         IF ~BAND(NOM:ARPVNBYTE,00000001B)
                            NOM:ARPVNBYTE+=1     !PIRMÂ AR PVN
                         .
!                         NOM:IZC_V_KODS='DE'  !VÂCIJA
                         NOM:REALIZ[1]=NOM_REALIZ
                         NOM:DG=NOM_DG
                         NOM:ACC_KODS=ACC_KODS
                         NOM:ACC_DATUMS=TODAY()
                         IF RIUPDATE:NOM_K()
                            KLUDA(24,'NOM_K')
                         .
                         MAINITI+=1
                      .
                   .
                .
                IF OPC=5 OR OPC=7 THEN CYCLE.
!***************************** TAISAM NOLIK....
                CLEAR(NOL:RECORD)
                NOL:U_NR=PAV:U_NR
                NOL:DATUMS=PAV:DATUMS
                NOL:VAL=PAV_VAL
                KODNAV#=0
                KODNUL#=0
                NOMNAV#=0
                NOL:NOMENKLAT=NOM:NOMENKLAT
                CASE OPC
                OF 1
                   NOL:D_K='D'
                   NOL:PAR_NR=100
                   NOL:DAUDZUMS=T:DAUDZUMS
                   NOL:SUMMAV=T:SUMMA
                   NOL:SUMMA=NOL:SUMMAV
                   NOL:ATLAIDE_PR=T:ATLAIDE_PR
                   NOL:ARBYTE=0
                OF 2  !vp
                   NOL:D_K='P'
                   NOL:PAR_NR=VP_PAR_NR
                   NOL:DAUDZUMS=V:DAUDZUMS
       !            NOL:SUMMAV=V:CENA*NOL:DAUDZUMS
                   IF ~(V:CENA=NOM:REALIZ[NOKL_CP#])
                      KLUDA(0,'Nesakrît cenas VP failâ un Nom_k '&V:CENA&'='&NOM:REALIZ[NOKL_CP#])
                   .
                   NOL:SUMMAV=NOM:REALIZ[NOKL_CP#]*NOL:DAUDZUMS
                   NOL:SUMMA=NOL:SUMMAV
                   NOL:ARBYTE=0
                OF 3
                   IV2PZ=GETINIFILE('IV2PZ',0)
                   FOUND2#=FALSE
                   LOOP I#=1 TO 10
                      IF IV2PZM[I#] AND CLIP(IV2PZM[I#])=NOL:NOMENKLAT[1:LEN(CLIP(IV2PZM[I#]))]
                         FOUND2#=TRUE  !BÛS AKCÎZES P/Z
                         BREAK
                      .
                   .
                   IF FOUND2#
                      IV2#+=1
                      IF IV2#=1 AND ~IV1# AND ~TEKOSA
                         TEKOSA=2
                      .
                      IF IV2#=1 AND IV1#
                         VELREIZ=1
                      .
                   ELSE
                      IV1#+=1
                      IF IV1#=1 AND ~IV2# AND ~TEKOSA
                         TEKOSA=1
                      .
                      IF IV1#=1 AND IV2#
                         VELREIZ=1
                      .
                   .
!                   STOP(IV1#&' '&IV2#&' '&VELREIZ&' '&OTRAREIZE&' '&TEKOSA)
                   IF TEKOSA=1 AND FOUND2# THEN CYCLE.
                   IF TEKOSA=2 AND ~FOUND2# THEN CYCLE.
!                   IF VELREIZ+OTRAREIZE=1 THEN CYCLE.
                   NOL:D_K='P'
                   NOL:PAR_NR=PAV:PAR_NR
                   NOL:DAUDZUMS=I:DAUDZUMS
                   IF ~NOL:DAUDZUMS THEN NOL:DAUDZUMS=1.
                   NOL:ATLAIDE_PR=GETPAR_ATLAIDE(PAR:Atlaide,NOL:NOMENKLAT)
                   IF CL_NR=1041 !EZERMALA
                      NOL:SUMMAV=I:CENA*NOL:DAUDZUMS
                   ELSE
                      NOL:SUMMAV=NOM:REALIZ[1]*NOL:DAUDZUMS !varbût nokl_cp?
                   .
                   NOL:SUMMA=NOL:SUMMAV
                   NOL:ARBYTE=1 !AR PVN
                OF 4  !AGB
                   NOL:D_K='D'
                   NOL:PAR_NR=PAV:PAR_NR
                   NOL:DAUDZUMS=A:DAUDZUMS
                   NOL:SUMMAV=A:SUM
                   NOL:SUMMA=NOL:SUMMAV
                   NOL:ATLAIDE_PR=0
                   NOL:ARBYTE=0
                OF 6  !SILDA
                   NOL:D_K='D'
                   NOL:PAR_NR=PAV:PAR_NR
                   NOL:DAUDZUMS=A:DAUDZUMS
                   NOL:SUMMAV=A:SUM
                   NOL:SUMMA=A:SUM*BANKURS(NOL:VAL,NOL:DATUMS)
                   NOL:ATLAIDE_PR=0
                   NOL:ARBYTE=0
                .
                NOL:PVN_PROC=NOM:PVN_PROC
                ADD(NOLIK)
                IF ERROR() THEN STOP('Rakstot nolik :'&ERROR()).
                FILLPVN(1)
          !     pav:summa+=nol:summav*(1-NOL:ATLAIDE_PR/100)
                summa_A+=CALCSUM(8,1) !ATLAIDE
                AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
             . !BIJA LOKALIZÇTA NOMENKLATÛRA
          .  !BEIDZAS RECORDSPERCYCLE-TXTAB LOOPS
       .  !BEIDZAS EVENT:TIMER
       IF LocalResponse = RequestCancelled
!          stop('3')
          BREAK
       .
    .  !BEIDZAS ACCEPT LOOPS
!    STOP('END ACC LOOP')
    CLOSE(ProgressWindow)
!***************************************DARAKSTAM P/Z...
    IF ~(OPC=5 OR OPC=7)
       DISPLAY
       CASE OPC
       OF 2 !vp
          PAV:PAR_NR=VP_PAR_NR
          PAV:NOKA=VP_NOS
       .
!       PAV:DATUMS=TODAY()
       pav:summa=GETPVN(2)
       PAV:SUMMA_A=SUMMA_A
       PAV:APM_V='2'
       PAV:APM_K='1'
       PAV:VAL=PAV_VAL
       PAV:ACC_KODS=ACC_KODS
       PAV:ACC_DATUMS=TODAY()
       IF DUPLICATE(PAV:SENR_KEY)
          KLUDA(0,'Veidojas dubultas atslçgas ar dokumenta Nr '&CLIP(PAV:DOK_SENR)&' ...nullçju')
          PAV:DOK_SENR=''
       .
       IF RIUPDATE:PAVAD()
          KLUDA(24,'PAVAD')
       .
    .
    CLOSE(TXTAB)
    IF OTRAREIZE
       VELREIZ=0
       OTRAREIZE=0
       TEKOSA=0
    .
    IF VELREIZ
       R#-=1
       VELREIZ=0
       OTRAREIZE=1
       IF TEKOSA=1
          TEKOSA=2
       ELSE
          TEKOSA=1
       .
    ELSE
       REMOVE(TXTAB)
    .
 . !TXT FAILI LOOPS
! STOP('2')

 IF OPC=5 OR OPC=7
    KLUDA(0,'Analizçtas '&RecordsProcessed&' Izv.jaunas '&JAUNI&' mainîtas '&MAINITI&' nomenklat., kïûdas '&kludaini,,1)
    CLOSE(OUTFILEANSI)
 .
! UNHIDE(?ButtonCancel)
! ?ButtonCancel{PROP:TEXT}='&Beigt'
! DISPLAY
 FREE(DOSFILES)
        
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
    PAV:DOKDAT=TODAY()
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    PAV:ACC_KODS=ACC_kods
    PAV:ACC_DATUMS=today()
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

!---------------------------------------------------------------------------------------------
FILLGROUPT  ROUTINE
  START#=0
  END#=-1
  ITEM#=0
  T:KODS=''
  T:DAUDZUMS=''
  T:NOSAUKUMS=''
  T:CENA=''
  T:SUMMA=''
  T:APV=''
  T:DER_TER=''
  T:EAN=''
  T:ARTIKULS=''
  T:SERIJA=''
  T:KURVA=''
  T:P_CENA=''
  T:I_CENA=''
  T:ATLAIDE_PR=''
  LOOP I#= 1 TO 200
!     STOP(VAL(TA:LINE[I#]))
     IF TX:LINE[I#]=CHR(9)
        ITEM#+=1
        START#=END#+2
        END#=I#-1
!        STOP(START#&' '&END#&' '&ITEM#)
        EXECUTE ITEM#
           T:KODS      =TX:LINE[START#:END#]  !EAN KODS
           T:DAUDZUMS  =TX:LINE[START#:END#]  !DAUDZUMS
           T:NOSAUKUMS =TX:LINE[START#:END#]  !NOSAUKUMS
           T:CENA      =TX:LINE[START#:END#]  !CENA
           T:SUMMA     =TX:LINE[START#:END#]  !SUMMA
           T:APV       =TX:LINE[START#:END#]  !ATTIECÎBA PRET PAMATVIENÎBU
           T:DER_TER   =TX:LINE[START#:END#]  !DERÎGUMA TERMIÒÐ
           T:EAN       =TX:LINE[START#:END#]  !EAN KODS
           T:ARTIKULS  =TX:LINE[START#:END#]  !ARTIKULS
           T:SERIJA    =TX:LINE[START#:END#]  !SÇRIJA
           T:KURVA=''                         !
           T:P_CENA    =TX:LINE[START#:END#]  !PÂRDOÐANAS CENA
           T:I_CENA    =TX:LINE[START#:END#]  !CENA
           T:ATLAIDE_PR=TX:LINE[START#:END#]  !ATLAIDES %
        .
        IF ITEM#=14 THEN BREAK.
     .
  .

!---------------------------------------------------------------------------------------------
FILLGROUPV  ROUTINE
  START#=0
  END#=-1
  ITEM#=0
  V:KODS=''
  V:DAUDZUMS=''
  V:NOSAUKUMS=''
  V:CENA=''
  V:SUMMA=''
  V:D1=''
  V:D2=''
  V:D3=''
  V:D4=''
  V:D5=''
  V:D6=''
  LOOP I#= 1 TO 200
!     STOP(VAL(TX:LINE[I#]))
     IF TX:LINE[I#]=CHR(9)
        ITEM#+=1
        START#=END#+2
        END#=I#-1
!        STOP(START#&' '&END#&' '&ITEM#)
        EXECUTE ITEM#
           V:D1       =TX:LINE[START#:END#]
           V:D2       =TX:LINE[START#:END#]
           V:KODS0    =TX:LINE[START#:END#]  !EAN KODS
           V:KODS     =TX:LINE[START#:END#]  !EAN KODS
           V:D3       =TX:LINE[START#:END#]
           V:DAUDZUMS =TX:LINE[START#:END#]  !DAUDZUMS
           V:D4       =TX:LINE[START#:END#]
           V:CENA     =TX:LINE[START#:END#]  !CENA
           V:D5       =TX:LINE[START#:END#]
           V:D6       =TX:LINE[START#:END#]
           V:SUMMA    =TX:LINE[START#:END#]  !SUMMA
        .
        V:NOSAUKUMS=TX:LINE[END#+2:END#+37]  !NOSAUKUMS
        IF ITEM#=11 THEN BREAK.
     .
  .
!---------------------------------------------------------------------------------------------
FILLGROUPI  ROUTINE  !INET
  START#=0
  END#=-1
  ITEM#=0
  I:NOMENKLAT=''
  I:NOSAUKUMS=''
  I:CENA=''
  I:DAUDZUMS=''
  ENDLINE#=LEN(CLIP(TX:LINE))
  IF TX:LINE[1]='*'
     Auto::Attempts = 0
     LOOP
        SET(TEX:NR_KEY)
        PREVIOUS(TEKSTI)
        IF ERRORCODE() AND ERRORCODE() <> BadRecErr
           StandardWarning(Warn:RecordFetchError,'TEKSTI')
           EXIT
        .
        IF ERRORCODE()
           Auto::Save:TEX:NR = 1
        ELSE
           Auto::Save:TEX:NR = TEX:NR + 1
        .
        TEX:NR = Auto::Save:TEX:NR
        ADD(TEKSTI)
        IF ERRORCODE()
           Auto::Attempts += 1
           IF Auto::Attempts = 3
              IF StandardWarning(Warn:AutoIncError) = Button:Retry
                 EXIT
              .
           .
        ELSE
           IF ENDLINE#>120
              TEX:TEKSTS1=TX:LINE[2:60]         !TEKSTS PIE PASÛTÎJUMA
              TEX:TEKSTS2=TX:LINE[61:120]
              TEX:TEKSTS3=TX:LINE[121:ENDLINE#]
           ELSIF ENDLINE#>60
              TEX:TEKSTS1=TX:LINE[2:60]
              TEX:TEKSTS2=TX:LINE[61:ENDLINE#]
           ELSE
              TEX:TEKSTS1=TX:LINE[2:ENDLINE#]
           .
           PUT(TEKSTI)
           PAV:TEKSTS_NR=TEX:NR
           EXIT
        .
     .
  ELSE
     LOOP I#= 1 TO ENDLINE#
!        IF TX:LINE[I#]=CHR(9) OR TX:LINE[I#]=',' OR I#=ENDLINE#  !TAB VAI KOMATS
        IF TX:LINE[I#]=CHR(9) OR I#=ENDLINE#  !TAB
           ITEM#+=1
           START#=END#+2
           IF I#=ENDLINE#
              END#=I#
           ELSE
              END#=I#-1
           .
           EXECUTE ITEM#
              I:NOMENKLAT   =TX:LINE[START#:END#]  !NOMENKLATÛRA(EAN KODS?)
              I:NOSAUKUMS   =TX:LINE[START#:END#]  !NOS_P
              I:CENA        =TX:LINE[START#:END#]  !CENA
              I:DAUDZUMS    =TX:LINE[START#:END#]  !DAUDZUMS
           .
        .
     .
  .
!  STOP(TX:LINE[START#:END#]&' '&I:CENA&' '&I:DAUDZUMS)

!---------------------------------------------------------------------------------------------
FILLGROUPA  ROUTINE

!  A:NOMENKLAT   =TX:LINE[12:33]         !NOMENKLATÛRA(EAN KODS?)
  A:KATALOGA_NR =TX:LINE[12:14]&TX:LINE[16:18]&TX:LINE[20:22]&TX:LINE[24:25]&TX:LINE[27:29]  !3+3+3+2+3 RAÞOTÂJA KODS
  A:NOMENKLAT   =A:KATALOGA_NR         !NOMENKLATÛRA
!  STOP(A:KATALOGA_NR)
  A:NOSAUKUMS   =TX:LINE[33:51]        !NOS_P
!  STOP(A:NOSAUKUMS)
  A:MERVIEN     =TX:LINE[52:55]        !MERVIEN
!  STOP(A:MERVIEN)
  A:DAUDZUMS    =LEFT(TX:LINE[56:62])  !DAUDZUMS
  I#=INSTRING(',',A:DAUDZUMS)
  IF I# THEN A:DAUDZUMS[I#]='.'.
!  STOP(A:DAUDZUMS)
  A:CENA        =LEFT(TX:LINE[63:71])  !CENA
  I#=INSTRING(',',A:CENA)
  IF I# THEN A:CENA[I#]='.'.
!  STOP(A:CENA)
  A:SUM         =LEFT(TX:LINE[72:80])  !SUMMA
  I#=INSTRING(',',A:SUM)
  IF I# THEN A:SUM[I#]='.'.
!  STOP(A:SUM)

!---------------------------------------------------------------------------------------------
FILLGROUPW  ROUTINE  !VW Cenas

  START#=0
  END#=-1
  ITEM#=0
  ENDLINE#=LEN(CLIP(TX:LINE))
  LOOP I#= 1 TO ENDLINE#
     IF TX:LINE[I#]='"' THEN TX:LINE[I#]=''.
     IF TX:LINE[I#]=CHR(9) OR I#=ENDLINE#  !TAB VAI VISS
        ITEM#+=1
        START#=END#+2
        IF I#=ENDLINE#
           END#=I#
        ELSE
           END#=I#-1
        .
        EXECUTE ITEM#
           W:KATALOGA_NR =LEFT(TX:LINE[START#:END#])  !RAÞOTÂJA KODS
           W:NOSAUKUMS1  =LEFT(TX:LINE[START#:END#])  !NOS_VÂCISKI
           W:NOSAUKUMS2  =LEFT(TX:LINE[START#:END#])  !NOS_ANGLISKI
           W:DG          =LEFT(TX:LINE[START#:END#])  !ATLAIDES GRUPA
           W:CENA        =LEFT(TX:LINE[START#:END#])  !CENA EUROcentos
        .
     .
  .
!  STOP(W:KATALOGA_NR&W:NOSAUKUMS1&W:NOSAUKUMS2&W:DG&W:CENA)

!---------------------------------------------------------------------------------------------
FILLGROUPS  ROUTINE  !Subaru Cenas

           W:KATALOGA_NR =LEFT(TX:LINE[1:15])   !RAÞOTÂJA KODS
           W:NOSAUKUMS1  =LEFT(TX:LINE[16:46])  !NOS_ANGLISKI
           W:DG          =LEFT(TX:LINE[57:58])  !ATLAIDES GRUPA
           W:CENA        =LEFT(TX:LINE[47:56])  !CENA EUROcentos

!  STOP(W:KATALOGA_NR&W:NOSAUKUMS1&W:DG&W:CENA)

!---------------------------------------------------------------------------------------------
FILLGROUPAA  ROUTINE

  START#=0
  END#=-1
  ITEM#=0
  ENDLINE#=LEN(CLIP(TX:LINE))
  LOOP I#= 1 TO ENDLINE#
     IF TX:LINE[I#]='"' THEN TX:LINE[I#]=''.
     IF TX:LINE[I#]=CHR(9) OR I#=ENDLINE#  !TAB VAI VISS
        ITEM#+=1
        START#=END#+2
        IF I#=ENDLINE#
           END#=I#
        ELSE
           END#=I#-1
        .
        EXECUTE ITEM#
           NPK#+=1
           A:KATALOGA_NR =LEFT(TX:LINE[START#:END#])  !RAÞOTÂJA KODS
           A:DAUDZUMS    =LEFT(TX:LINE[START#:END#])  !
           A:MERVIEN     ='litri'                     !MERVIEN
           NEVAJAG#=TRUE !CENA BEZ ATLAIDES
           NEVAJAG#=TRUE !ATLAIDE
           A:SUM         =LEFT(TX:LINE[START#:END#])  !CENA EURO
        .
        A:NOMENKLAT   ='SI  '&A:KATALOGA_NR           !NOMENKLATÛRA
        A:CENA        =A:SUM/A:DAUDZUMS               !CENA
     .
  .


!---------------------------------------------------------------------------------------------
PROCEDURERETURN ROUTINE    
  CLOSE(TEKSTI)
  RETURN
IZZFILTMINMAX PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
window               WINDOW('Izziòa filtram'),AT(,,266,77),GRAY
                       OPTION('Norâdiet'),AT(38,3,42,30),USE(F:LIELMAZ),BOXED
                         RADIO('Mazâko'),AT(43,10,35,10),USE(?LIELMAZ:Radio1)
                         RADIO('Lielâko'),AT(43,19,35,10),USE(?LIELMAZ:Radio2)
                       END
                       STRING('summu, kas jâatspoguïo atskaitç:'),AT(82,17),USE(?String2)
                       ENTRY(@n-_10),AT(195,17,44,10),USE(MINMAXSUMMA),RIGHT
                       STRING(@s3),AT(242,17,14,10),USE(Val_uzsk)
                       BUTTON('Iekïaut arî to, kas nav noliktavâ'),AT(22,46,110,16),USE(?IEKLAUTKASNAV)
                       IMAGE('CHECK3.ICO'),AT(139,46,16,16),USE(?Image1)
                       BUTTON('&OK'),AT(177,58,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(223,58,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  F:LIELMAZ = 'Mazâko'
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF F:IeklautPK
     UNHIDE(?IMAGE1)
  ELSE
     HIDE(?IMAGE1)
  END
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?LIELMAZ:Radio1)
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
    OF ?IEKLAUTKASNAV
      CASE EVENT()
      OF EVENT:Accepted
        IF F:IeklautPK
           F:IeklautPK = ''
           HIDE(?IMAGE1)
        ELSE
           F:IeklautPK = '1'
           UNHIDE(?IMAGE1)
        END
        DISPLAY
        DO SyncWindow
      END
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
  INIRestoreWindow('IZZFILTMINMAX','winlats.INI')
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
    INISaveWindow('IZZFILTMINMAX','winlats.INI')
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
