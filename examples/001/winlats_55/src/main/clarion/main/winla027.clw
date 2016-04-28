                     MEMBER('winlats.clw')        ! This is a MEMBER module
bankurs              FUNCTION (v_nos,datums,norade,test) ! Declare Procedure
  CODE                                            ! Begin processed code
!
! NORADE  -KUR MEKLÇJAMA KÏÛDA
! TEST   1-JÂATGRIEÞ TESTA KURSS
!
!Elya 16/09/2013 <
!  CASE UPPER(V_NOS)
!  OF 'LS'
!  OROF 'LVL'
!     RETURN(1)
!  .
  IF datums < DATE(1,1,2014)
     CASE UPPER(V_NOS)
     OF 'LS'
     OROF 'LVL'
        RETURN(1)
     .
  ELSE
     IF UPPER(V_NOS) = 'EUR'
        RETURN(1)
     .
  .
!Elya 16/09/2013 >
  IF ~V_NOS AND TEST    !VALÛTAS NAV UN NEVAJAG
     RETURN(0)
  .
  IF VAL_K::USED=0
     CHECKOPEN(VAL_K,1)
  .
  VAL_K::USED+=1
  CLEAR(VAL:RECORD)
  VAL:VAL=V_NOS
  GET(VAL_K,VAL:NOS_KEY)
  IF ERROR()
     KLUDA(14,V_NOS&' BANKURS() '&NORADE)
     VAL_K::USED-=1
     IF VAL_K::USED=0
        CLOSE(VAL_K)
     .
     RETURN(0)
  ELSIF TEST=1     !JÂATGRIEÞ TESTA KURSS
     VAL_K::USED-=1
     IF VAL_K::USED=0
        CLOSE(VAL_K)
     .
     RETURN(VAL:TEST)
  .
  IF KURSI_K::USED=0
     checkopen(kursi_k,1)
  .
  KURSI_K::USED+=1
  CLEAR(KUR:RECORD)
  GET(KURSI_K,0)
  KUR:VAL=V_NOS
  KUR:DATUMS=DATUMS
  GET(KURSI_K,KUR:NOS_KEY)
  IF ERROR()
!     GGK_NOS=V_NOS
!     GGK_DATUMS=DATUMS
     GLOBALREQUEST=InsertRECORD
     UPDATEKURSI_K
  .
!  stop(kur:kurss)
  VAL_K::USED-=1
  IF VAL_K::USED=0
     CLOSE(VAL_K)
  .
  KURSI_K::USED-=1
  IF KURSI_K::USED=0
     CLOSE(KURSI_K)
  .
  CASE KUR:TIPS
  OF '1'                                         ! Ls/NV
     RETURN(KUR:KURSS)
  OF '2'                                         ! Ls/100NV
     RETURN(KUR:KURSS/100)
  OF '3'                                         ! Ls/1000NV
     RETURN(KUR:KURSS/1000)
  OF '4'                                         ! NV/LS
     RETURN(1/KUR:KURSS)
  ELSE
     STOP('KUR:TIPS='&KUR:TIPS)
     RETURN(0)
  .
ELMAKS PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
PAYMENT              STRING(1)
OPC                  BYTE
MAKSAJUMA_TAKA       STRING(55)
NOTIRIT              BYTE
FAILAVARDS           STRING(20)
ARMAKS_KODS          DECIMAL(3)
ARM_NOS_P            STRING(71)
SAVBANKAS_K  LIKE(BANKAS_K:RECORD),PRE(B)
SAVGG        LIKE(GG:RECORD),PRE(G)
GGPOSITION   STRING(10)
TEX:DUF      STRING(105)

!LUBNAME      STRING(50),STATIC
!HANSAMASY    STRING(50),STATIC
!HANSAMASS    STRING(50),STATIC

PL           STRING(1)
PAR_REK      STRING(34)
PAR_KOR      STRING(15)
SATURS       STRING(135)
ASTE         STRING(45)
REG_NR       STRING(35)
R72          STRING(35)
P_summa      decimal(7,2)
GGK_SUMMA    STRING(11)
!CLIENTIDBANK ULONG
GGK_VAL      STRING(3)
CYCLES       USHORT
MU_SUMMA     LIKE(GGK:SUMMA)
SAV_POSITION STRING(260)
SAV_U_NR     LIKE(GGK:U_NR)
PAR_NMR_KODS LIKE(PAR:NMR_KODS)

PAYNAME              CSTRING(80),STATIC  !e-KASE
XMLFILENAME          CSTRING(200),STATIC !FIDAVISTA
XMPFILENAME          CSTRING(200),STATIC

PAYORD       FILE,PRE(PAY),DRIVER('ASCII'),NAME(PAYNAME),CREATE
RECORD          RECORD
LINE               STRING(500)
             .  .
OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(170) !MAX IESPÇJAMAIS RINDAS GARUMS=140+2*10+1
             .  .
OUTFILEXMP   FILE,DRIVER('ASCII'),NAME(XMPFILENAME),PRE(XMP),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(170) !MAX IESPÇJAMAIS RINDAS GARUMS=140+2*10+1
             .  .
quickwindow          WINDOW('Elektronisko norçíinu sistçma'),AT(,,291,106),GRAY
                       STRING('Tiks sagatavots dokuments elektroniskai     '),AT(7,8,138,10),USE(?String1)
                       ENTRY(@s45),AT(146,13,144,10),USE(MAKSAJUMA_TAKA),OVR,UPR
                       STRING('pârsûtîðanai uz banku sekojoðâ folderî :'),AT(9,17),USE(?String3)
                       OPTION('Maksâjuma veids'),AT(9,28,111,47),USE(OPC),BOXED
                         RADIO('Parastais maksâjums'),AT(18,36),USE(?PAYMENT:Radio1),VALUE('1')
                         RADIO('Budþeta maksâjums'),AT(18,45),USE(?PAYMENT:Radio2),VALUE('2')
                         RADIO('Starptautiskais maksâjums'),AT(18,54,100,10),USE(?PAYMENT:Radio3),VALUE('3')
                         RADIO('Algu maksâjums'),AT(18,63),USE(?PAYMENT:Radio4),VALUE('4')
                       END
                       BUTTON('Ârçjâ maksâjuma kods '),AT(135,61,85,14),USE(?ButtonARMAKS),DISABLE
                       ENTRY(@n3B),AT(223,64,20,10),USE(ARMAKS_KODS),DISABLE,DECIMAL(12)
                       STRING(@s71),AT(2,76,290,10),USE(ARM_NOS_P),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('Notîrît failu'),AT(173,42,47,14),USE(?ButtonNotirit),HIDE
                       IMAGE('CHECK3.ICO'),AT(223,41,15,17),USE(?Image:NOTIRIT),HIDE
                       STRING(@s20),AT(146,24),USE(FAILAVARDS),LEFT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('&OK'),AT(190,88,48,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(241,88,47,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   PAYMENT='P'
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
    GETMYBANK(ggk:bkk)          ! MANA BANKA
    SAVbankas_k=BAN:RECORD
    MAKSAJUMA_TAKA=BAN:MAKSAJUMA_TAKA
  
  !  IF BKODS[1:6]='RIKOLV'      ! DnB NORD banka
  !     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. DnB NORD banka'
  !     IF ~MAKSAJUMA_TAKA
  !         MAKSAJUMA_TAKA='C:\BSCLNT_3\SUBSYS\LATVIAN\IN'
  !     .
  !     DISABLE(?OPC)
  !  ELSIF BKODS[1:6]='VBRILV'   ! UniCredit Bank
  !     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. UniCredit Bank'
  !     IF ~MAKSAJUMA_TAKA
  !         MAKSAJUMA_TAKA=PATH()
  !     .
  !     DISABLE(?OPC)
  !     UNHIDE(?BUTTONNOTIRIT)
  !!  ELSIF BKODS[1:6]='HABALV'   ! SWEDBANK
  !!     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. SWEDBANK'
  !!     DISABLE(?PAYMENT:Radio2) !BUDÞETA MAKSÂJUMS
  !!     IF ~MAKSAJUMA_TAKA
  !!         MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP'
  !!     .
  !!  ELSIF BKODS[1:8]='LHZBLV22' ! HIPOTÇKU UN ZEMES
  !!     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. HipoNet'
  !!     IF ~MAKSAJUMA_TAKA
  !!         MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP'
  !!     .
  !!     DISABLE(?PAYMENT:Radio4)
  !!     UNHIDE(?BUTTONNOTIRIT)
  !!  ELSIF BKODS[1:6]='UNLALV'   ! SEB
  !!     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. Unibanka'
  !!     IF ~MAKSAJUMA_TAKA
  !!         MAKSAJUMA_TAKA='C:\AKMENS'
  !!     .
  !!     DISABLE(?OPC)
  !  ELSIF BKODS[1:8]='UBALLV2X' ! KRÂJBANKA
  !     QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. Krâjbanka'
  !     IF ~MAKSAJUMA_TAKA
  !         MAKSAJUMA_TAKA='C:\PROGRA~1\COMMON~1\BIROJA~1\CSV'
  !     .
  !     DISABLE(?PAYMENT:Radio2) !BUDÞETA MAKSÂJUMS
  !     DISABLE(?PAYMENT:Radio3) !STARPTAUTISKAIS
  !     DISABLE(?PAYMENT:Radio4) !ALGU
  !     CLIENTIDBANK=GETINIFILE('CLIENTIDBANK',0)
  
    IF BKODS[1:8]='TRELLV22' ! VALSTS KASE
       QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma. eKase'
       DISABLE(?PAYMENT:Radio2) !BUDÞETA MAKSÂJUMS
       DISABLE(?PAYMENT:Radio3) !STARPTAUTISKAIS
       DISABLE(?PAYMENT:Radio4) !ALGU
       IF ~MAKSAJUMA_TAKA
           MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP'
       .
       FAILAVARDS='Fails: '&CLIP(BKODS)&'.TXT'
    ELSE
       QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma FiDAViSta. '&BANKA
       DISABLE(?PAYMENT:Radio2) !BUDÞETA MAKSÂJUMS
       DISABLE(?PAYMENT:Radio3) !STARPTAUTISKAIS
       IF INSTRING(GETPAR_K(GGK:PAR_NR,2,20),'CN',1)
          ENABLE(?ButtonARMAKS)
          ENABLE(?ARMAKS_KODS)
       .
       IF ~MAKSAJUMA_TAKA
           MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP'
       .
       FAILAVARDS='Fails: '&CLIP(BKODS)&'.XML'
    .
    OPC=1
    DISPLAY
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
    OF ?MAKSAJUMA_TAKA
      CASE EVENT()
      OF EVENT:Accepted
        ForceRefresh = True
        LocalRequest = OriginalRequest
        DO RefreshWindow
          IF BKODS[1:6]='UNLALV' ! SEB
             IF ~MAKSAJUMA_TAKA
                 MAKSAJUMA_TAKA='C:\AKMENS'
             .
        !  ELSIF BKODS[1:8]='UBALLV2X' ! KRÂJBANKA
        !     IF ~MAKSAJUMA_TAKA
        !         MAKSAJUMA_TAKA='C:\PROGRA~1\COMMON~1\BIROJA~1\CSV'
        !!         MAKSAJUMA_TAKA='C:\PROGRAMFILES\COMMONFILES\BIROJABANKA\CSV'
        !     .
          ELSE
             IF ~MAKSAJUMA_TAKA
                 MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP'
             .
          .
          DISPLAY()
      END
    OF ?ButtonARMAKS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseARM_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
          IF GLOBALRESPONSE=REQUESTCOMPLETED
             ARMAKS_KODS=ARM:KODS
             ARM_NOS_P=ARM:NOS_P
             DISPLAY
          .
      END
    OF ?ARMAKS_KODS
      CASE EVENT()
      OF EVENT:Accepted
          ARM:KODS=GETARM_K(ARMAKS_KODS,1,1)
          ARM_NOS_P=ARM:NOS_P
          DISPLAY
      END
    OF ?ButtonNotirit
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF NOTIRIT
           NOTIRIT=FALSE
           HIDE(?IMAGE:NOTIRIT)
        ELSE
           NOTIRIT=TRUE
           UNHIDE(?IMAGE:NOTIRIT)
        .
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        TTAKA"=LONGPATH()
        IF (MAKSAJUMA_TAKA[LEN(CLIP(MAKSAJUMA_TAKA))]='\')
           MAKSAJUMA_TAKA=MAKSAJUMA_TAKA[1:LEN(CLIP(MAKSAJUMA_TAKA))-1]
        .
        SETPATH(MAKSAJUMA_TAKA)
        IF ERROR()
           KLUDA(17,'Folderis: '&maksajuma_taka)
           SETPATH(TTAKA")
        ELSE
           SETPATH(TTAKA")
           BAN:MAKSAJUMA_TAKA=MAKSAJUMA_TAKA  !KAMÇR VÇL NEESAM ÍÇRUÐIES PIE SAÒÇMÇJA BANKAS
           IF ~(SAVBANKAS_K=BAN:RECORD)
              IF RIUPDATE:BANKAS_K()
                 KLUDA(24,'BANKAS_K')
              .
           .
           PAR:U_NR=GG:PAR_NR
           GET(PAR_K,PAR:NR_KEY)
           CLEAR(BAN:RECORD)
           IF ~(opc=4) !~algu maksâjums
              CASE SYS:nokl_PB
              OF 1
                 BAN:KODS=PAR:BAN_KODS
                 PAR_REK=PAR:BAN_NR
                 PAR_KOR=PAR:BAN_KR
              OF 2
                 BAN:KODS=PAR:BAN_KODS2
                 PAR_REK=PAR:BAN_NR2
                 PAR_KOR=PAR:BAN_KR2
              ELSE kluda(69,'')
              .
              IF ~BAN:KODS
                  KLUDA(87,'saòçmçja bankas kods')
              .
              IF ~par_rek
                  KLUDA(87,'saòçmçja n/r')
              .
              GET(BANKAS_K,BAN:KOD_KEY)      ! SAÒÇMÇJA BANKA
           .

        !*********************************************VALSTS KASE***********************************************
           IF BKODS[1:8]='TRELLV22'        ! VK
              PAYNAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'.TXT'
              CHECKOPEN(PAYORD,1)
              CLEAR(PAY:RECORD)
              IF OPC=1
!                 PAY:LINE=''                              ! JÂBÛT TUKÐAI RINDAI
!                 ADD(PAYORD)
                 PAY:LINE='##'                            ! 1.DOKUMENTA TIPS
                 IF GGK:VAL='Ls' or GGK:VAL='LVL' or GGK:VAL='LS'
                    PAY:LINE=CLIP(PAY:LINE)&',#LVL#'      ! 2.VALÛTA
                 ELSE
                    PAY:LINE=CLIP(PAY:LINE)&',#'&GGK:VAL&'#'
                    VALUTA#=TRUE
                 .
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(BANKURS(GGK:VAL,GGK:DATUMS),@N_18.6)))&'#' !3.KURSS
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(GG:DOK_SENR)&'#'  ! 4.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&FORMAT(GG:DATUMS,@D06.)&'#'  ! 5.DOK DD.MM.YYYY
                 PAY:LINE=CLIP(PAY:LINE)&',##'            ! 6.VALUTÇÐANAS DD.MM.YYYY
                 PAY:LINE=CLIP(PAY:LINE)&',##'            ! 7.DARÎJUMA DD.MM.YYYY
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(GG:SUMMA,@N_11.2)))&'#' !8.DARÎJUMA SUMMA
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(REK)&'#'      ! 9.IBAN
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(BKODS)&'#'    !10.BIC
                 PAY:LINE=CLIP(PAY:LINE)&',##'                   !11.FILEÂLE
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(BANKA)&'#'    !12.
                 PAY:LINE=CLIP(PAY:LINE)&',##'                   !13.
                 PAY:LINE=CLIP(PAY:LINE)&',##'                   !14.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&GL:REG_NR&'#'      !15.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(CLIENT)&'#'   !16.
!                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(PAR_REK)&'#' !17.
                 PAY:LINE=CLIP(PAY:LINE)&',##'                   !17.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(BAN:KODS)&'#' !18.
                 PAY:LINE=CLIP(PAY:LINE)&',##'                   !19.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(BAN:NOS_P)&'#' !20.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(PAR_REK)&'#'   !21.
                 PAY:LINE=CLIP(PAY:LINE)&',##'                    !22.
                 PAR_NMR_KODS=PAR:NMR_KODS
                 IF PAR:TIPS='F'
                    M#=INSTRING('-',PAR:NMR_KODS)
                    IF M#
                       PAR_NMR_KODS=PAR:NMR_KODS[1:M#-1]&PAR:NMR_KODS[M#+1:22]
                    .
                 .
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(PAR_NMR_KODS)&'#' !23.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(PAR:NOS_P)&'#'    !24.
                 PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(gg:saturs)&' '&clip(gg:saturs2)&' '&clip(gg:saturs3)&'#' !25.
                 SAV_POSITION=POSITION(GGK:NR_KEY)
                 SAV_U_NR=GGK:U_NR
                 GGK:BKK='262'
                 SET(GGK:NR_KEY,GGK:NR_KEY)
                 LOOP
                    NEXT(GGK)
                    IF ERROR() OR ~(SAV_U_NR=GGK:U_NR) THEN BREAK.
                    IF ~(GGK:BKK[1:3]='262') THEN CYCLE.
                    PAY:LINE=CLIP(PAY:LINE)&',#'&GGK:OBJ_NR&'#' !26.EEK1-EKONOMISKÂS KLASIFIKÂCIJAS KODS
!                    PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(GGK:SUMMA,@N11.2)))&'#'  !27.
                    PAY:LINE=CLIP(PAY:LINE)&',##'                                           !27.
                    PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(GGK:SUMMA,@N11.2)))&'#'   !28.
                    IF VALUTA#=TRUE
!                       PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(GGK:SUMMAV,@N11.2)))&'#' !29.
                       PAY:LINE=CLIP(PAY:LINE)&',##'                                           !29.
                       PAY:LINE=CLIP(PAY:LINE)&',#'&CLIP(LEFT(FORMAT(GGK:SUMMAV,@N11.2)))&'#'  !30.
                    ELSE
                       PAY:LINE=CLIP(PAY:LINE)&',##'                                           !29.
                       PAY:LINE=CLIP(PAY:LINE)&',##'                                           !30.
                    .
                 .
                 RESET(GGK:NR_KEY,SAV_POSITION)
                 NEXT(GGK)
!                 PAY:LINE=CLIP(PAY:LINE)&',#'&&'#'        !
                 PAY:LINE=INIGEN(PAY:LINE,LEN(CLIP(PAY:LINE)),6)
                 ADD(PAYORD)
                 CLOSE(PAYORD)
              .
              LocalResponse = RequestCompleted
              DO PROCEDURERETURN
        !*************************************FIDAVISTA:VISAS PÂRÇJÂS***********************************
           ELSE
              XMLFILENAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'.XML'
              XMPFILENAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'_MP.XML'
              CHECKOPEN(OUTFILEXML,1)
              F:XML_OK#=TRUE
              IF OPC=4                               !MASS PAYMENT
                 CHECKOPEN(OUTFILEXMP,1)
                 IF ~BYTES(OUTFILEXMP)               !NO ALGÂM NAV UZTAISÎTS
                    KLUDA(33,XMPFILENAME)
                    DO PROCEDURERETURN
                 ELSE
                    SET(OUTFILEXMP)
                    NEXT(OUTFILEXMP)
                    IF ERROR()
                       KLUDA(0,'Lasot '&XMPFILENAME)
                       DO PROCEDURERETURN
                    .
                    CYCLES=500
                 .
              ELSE
                 CYCLES=1
              .
              LOOP I#=1 TO CYCLES
                 IF BYTES(OUTFILEXML) !MAKSÂJUMS JAU IR PRIEKÐÂ
                    SET(OUTFILEXML)
                    LOOP
                       NEXT(OUTFILEXML)
                       IF ERROR() THEN BREAK.
                       IF XML:LINE[1:12]='</FIDAVISTA>' !AR ÐO BEIDZAS IEPRIEKÐÇJAIS,MP NEBÛS
                          ! 01/07/2014 XML:LINE=' Extension></Extension>' !DELETE ASCII NEIET, RAKSTAM KO NEITRÂLU, DnbNord ÐITÂ NEIET...!28.05.2010
                          XML:LINE=' Payment>' ! 01/07/2014
!                          XML:LINE[1:12]='' !NEIET 28.05.2010
!                          XML:LINE=' Payment></Payment' !NEIET 28.05.2010
                          PUT(OUTFILEXML)
                          F:XML_OK#=3               !07.04.2015
                          BREAK
                       .
                       F:XML_OK#=2
                    .
                 .
                 IF F:XML_OK#=TRUE                      !TIKAI 1.MU
                    XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
                    ADD(OUTFILEXML)
                    ! 23/04/2013 XML:LINE=' FIDAVISTA xmlns="http://bankasoc.lv/fidavista/fidavista0101.xsd">'
                    XML:LINE=' FIDAVISTA xmlns="http://www.bankasoc.lv/fidavista/fidavista0101.xsd">'

                    ADD(OUTFILEXML)
                    XML:LINE=' Header>'
                    ADD(OUTFILEXML)
                    XML:LINE=' Timestamp>'&FORMAT(TODAY(),@D012)&FORMAT(CLOCK(),@T5)&'000</Timestamp>'
                    ADD(OUTFILEXML)
                    XML:LINE=' From>'&CLIP(CLIENT)&'</From>'
                    IF INSTRING('RIKO',BKODS,1) ! DnB NORD ÐITO VAJAG
                       LOOP
                          P#=INSTRING('"',XML:LINE)
                          IF P#
                             XML:LINE[P#]=' '
                          ELSE
                             BREAK
                          .
                       .
                    .
                    ADD(OUTFILEXML)
                    XML:LINE='</Header>'
                    ADD(OUTFILEXML)
                 ! 01/07/2014.
                 !24.02.2015 XML:LINE=' Payment>'
                 !24.02.2015 ADD(OUTFILEXML)
                 .! 01/07/2014
!                 XML:LINE=' Extid>'&CLIP(GGK:U_NR)&'</Extid>'
                 IF ~(F:XML_OK#=3)            !07.04.2015
                    XML:LINE=' Payment>' !24.02.2015
                    ADD(OUTFILEXML)      !24.02.2015
                 .                            !07.04.2015
                 XML:LINE=' ExtId>'&CLIP(GGK:U_NR)&'</ExtId>'
                 ADD(OUTFILEXML)
                 IF OPC=4                               !MASS PAYMENT
!                    XML:LINE=' DocNo>'&CLIP(GG:DOK_SENR)&'/'&CLIP(I#)&'</DocNo>'
                    XML:LINE=' DocNo>'&CLIP(GG:DOK_SENR)&FORMAT(I#,@N03)&'</DocNo>'
                 ELSE
                    XML:LINE=' DocNo>'&CLIP(GG:DOK_SENR)&'</DocNo>'
                 .
                 ADD(OUTFILEXML)
                 XML:LINE=' RegDate>'&FORMAT(GG:DATUMS,@D010-)&'</RegDate>'
                 ADD(OUTFILEXML)
                 !17/04/2013 IF INSTRING('UBAL',BKODS,1) OR INSTRING('RIKO',BKODS,1) !KRÂJBANKAI,DnB NORD ÐITO VAJAG
                 !03/06/2014 IF INSTRING('UBAL',BKODS,1) OR INSTRING('RIKO',BKODS,1) OR INSTRING('NDEA',BKODS,1) !KRÂJBANKAI,DnB NORD ÐITO VAJAG
                 IF INSTRING('UBAL',BKODS,1) OR INSTRING('RIKO',BKODS,1) OR INSTRING('NDEA',BKODS,1) OR INSTRING('PARX',BKODS,1) !KRÂJBANKAI,DnB NORD ÐITO VAJAG
                    !XML:LINE=' TaxPmtFlg>N</TaxPmtFlg>'                  !N-parastais Y-nodokïu Viktors:NEVAJAG
                    IF OPC = 2
                        XML:LINE=' TaxPmtFlg>Y</TaxPmtFlg>'                  
                    ELSE
                        XML:LINE=' TaxPmtFlg>N</TaxPmtFlg>'
                    .
                    ADD(OUTFILEXML)
                 .
                 GGK_VAL=GGK:VAL
                 IF GGK_VAL='Ls' THEN GGK_VAL='LVL'.
                 XML:LINE=' Ccy>'&CLIP(GGK_VAL)&'</Ccy>'
                 ADD(OUTFILEXML)
                 !17/04/2013  140
                 !XML:LINE=' PmtInfo>'&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)&'</PmtInfo>'
                 TEX:DUF=CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
                 DO CONVERT_TEX:DUF_
                 XML:LINE=' PmtInfo>'&TEX:DUF&'</PmtInfo>'
                 ADD(OUTFILEXML)
                 XML:LINE=' PayLegalId>'&GL:REG_NR&'</PayLegalId>'
                 ADD(OUTFILEXML)
                 XML:LINE=' PayAccNo>'&CLIP(REK)&'</PayAccNo>'
                 ADD(OUTFILEXML)
   !              XML:LINE=' DebitCcy>'&CLIP(GGK_VAL)&'</DebitCcy>' !debitçjamâ val-labâk neaizpildît
   !              ADD(OUTFILEXML)
                 IF OPC=4                             !MASS PAYMENT
                    LOOP
                       XML:LINE=XMP:LINE
                       ADD(OUTFILEXML)
                       IF XML:LINE[1:5]=' Amt>'
                          P#=INSTRING(XML:LINE,'/',1)
                          MU_SUMMA+=XML:LINE[6:P#-2]
                       .
                       NEXT(OUTFILEXMP)
                       IF ERROR()
                          VISS#=TRUE
                          BREAK
                       .
!                       IF XML:LINE[1:9]='</BenSet>'
!                          BREAK
!                       .
                    .
                 ELSE
                    XML:LINE=' BenSet>'
                    ADD(OUTFILEXML)
                    XML:LINE=' Priority>N</Priority>'    !N-normal U-urgent X-express
                    ADD(OUTFILEXML)
                    XML:LINE=' Comm>OUR</Comm>'
                    ADD(OUTFILEXML)
                    XML:LINE=' Amt>'&CLIP(LEFT(FORMAT(GGK:SUMMAV,@N_12.2)))&'</Amt>'
                    ADD(OUTFILEXML)
                    XML:LINE=' BenAccNo>'&CLIP(PAR_REK)&'</BenAccNo>'
                    ADD(OUTFILEXML)
                    !17/04/2013  105
                    !XML:LINE=' BenName>'&CLIP(PAR:NOS_P)&'</BenName>'
                    TEX:DUF=PAR:NOS_P
                    DO CONVERT_TEX:DUF_
                    XML:LINE=' BenName>'&CLIP(TEX:DUF)&'</BenName>'
!                    IF INSTRING('RIKO',BKODS,1) ! DnB NORD ÐITO VAJAG
                       LOOP
                          P#=INSTRING('"',XML:LINE)
                          IF P#
                             XML:LINE[P#]=' '
                          ELSE
                             BREAK
                          .
                       .
!                    .
                    ADD(OUTFILEXML)
                    XML:LINE=' BenLegalId>'&CLIP(PAR:NMR_KODS)&'</BenLegalId>'
                    ADD(OUTFILEXML)
                    !17/04/2013   70
                    !XML:LINE=' BenAddress>'&CLIP(PAR:ADRESE)&'</BenAddress>'
                    TEX:DUF=PAR:ADRESE
                    DO CONVERT_TEX:DUF_
                    XML:LINE=' BenAddress>'&CLIP(TEX:DUF)&'</BenAddress>'
                    ADD(OUTFILEXML)
                    IF ~PAR:V_KODS THEN PAR:V_KODS='LV'.
                    XML:LINE=' BenCountry>'&PAR:V_KODS&'</BenCountry>'
                    ADD(OUTFILEXML)
                    !17/04/2013   70
                    !XML:LINE=' BBName>'&CLIP(BAN:NOS_P)&'</BBName>'
                    TEX:DUF=BAN:NOS_P
                    DO CONVERT_TEX:DUF_
                    XML:LINE=' BBName>'&CLIP(TEX:DUF)&'</BBName>'
                    ADD(OUTFILEXML)
                    XML:LINE=' BBSwift>'&CLIP(BAN:KODS)&'</BBSwift>'
                    ADD(OUTFILEXML)
                    IF ARMAKS_KODS
                       XML:LINE=' AmkSet>' !ÂRÇJÂ MAKSÂJUMA KODS
                       ADD(OUTFILEXML)
                       XML:LINE=' Opc>'&FORMAT(ARMAKS_KODS,@N03)&'</Opc>'
                       ADD(OUTFILEXML)
                       XML:LINE='</AmkSet>'
                       ADD(OUTFILEXML)
                    .
                    XML:LINE='</BenSet>'
                    ADD(OUTFILEXML)
                 .
                 XML:LINE='</Payment>'  
                 ADD(OUTFILEXML)        
                 IF VISS#=TRUE THEN BREAK.
              .
              XML:LINE='</FIDAVISTA>'
              ADD(OUTFILEXML)
              SET(OUTFILEXML)
              LOOP
                 NEXT(OUTFILEXML)
                 IF ERROR() THEN BREAK.
                 IF INSTRING('HABA',BKODS,1) OR INSTRING('UBAL',BKODS,1) !HANSAI/KRÂJBANKAI NEIET LATV BURTI un & ...
                    XML:LINE=INIGEN(XML:LINE,LEN(CLIP(XML:LINE)),5)
                 .
                 IF ~XML:LINE[1] AND XML:LINE[2]
                    XML:LINE[1]='<'
                    PUT(OUTFILEXML)
                 ELSIF XML:LINE[1]='>'
                    XML:LINE[1]=' '
                    PUT(OUTFILEXML)
                 .
              .
              CLOSE(OUTFILEXML)
              CLOSE(OUTFILEXMP)
              IF OPC=4 AND ~(MU_SUMMA=GGK:SUMMA)
                 KLUDA(0,'Nepareiza MU summa: '&GGK:SUMMA&' jâbût: '&MU_SUMMA)
              .
              LocalResponse = RequestCompleted
              DO PROCEDURERETURN
           .
        .
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
  IF BANKAS_K::Used = 0
    CheckOpen(BANKAS_K,1)
  END
  BANKAS_K::Used += 1
  BIND(BAN:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(quickwindow)
  WindowOpened=True
  INIRestoreWindow('ELMAKS','winlats.INI')
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
    BANKAS_K::Used -= 1
    IF BANKAS_K::Used = 0 THEN CLOSE(BANKAS_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('ELMAKS','winlats.INI')
    CLOSE(quickwindow)
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
  IF quickwindow{Prop:AcceptAll} THEN EXIT.
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
!-----------------------------------------------------------------------------
CONVERT_TEX:DUF_  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]= CHR(39)
!        stop('aaa'&TEX:DUF[J#])
!        stop('sss'&TEX:DUF[J#+1:J#+3]&' '&VAL(TEX:DUF[J#+1:J#+1])&' '&VAL(TEX:DUF[J#+2:J#+2]))
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<'
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='{'
!        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='}'
!        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='['
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=']'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=';'
        TEX:DUF=TEX:DUF[1:J#-1]&','&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='='
        TEX:DUF=TEX:DUF[1:J#-1]&'-'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='%'
        TEX:DUF=TEX:DUF[1:J#-1]&' proc.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='?'
        TEX:DUF=TEX:DUF[1:J#-1]&'.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='#'
        TEX:DUF=TEX:DUF[1:J#-1]&'Nr'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='/'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='\'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=':'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='*'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='_'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .

DropSaldo PROCEDURE(GL_DB_S_DAT)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
N231                 BYTE
N531                 BYTE
NEA                  BYTE
KR_SUMMA             DECIMAL(9,2)
SOLIS        SHORT
B_KURSS      REAL
PZLEVEL      BYTE
TARGETNAME   CSTRING(60)

K_TABLE      QUEUE,PRE(K)
BPNR         STRING(30)  ! GK1:BKK&FORMAT(GK1:PAR_NR,@S5)&GK1:VAL&GK1:REFERENCE&NODALA&PVN_PROC
BKK          STRING(5)
NODALA       STRING(2)
PAR_NR       ULONG
REFERENCE    STRING(14)
VAL          STRING(3)
PVN_PROC     BYTE
SUMMA        DECIMAL(13,2)
SUMMAV       DECIMAL(13,2)
             .

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

 
window               WINDOW('Kontu slçgðana'),AT(,,260,140),GRAY
                       STRING('Atïauts spiest arî "neslçgtu" DB (Bilances Aktîvs<<>Pasîvs),starpîba'),AT(14,13),USE(?String1),CENTER
                       STRING('tiks nokontçta uz 99999, kad  viss bûs kârtîbâ, bûvçsiet vçlreiz.'),AT(16,22),USE(?String3)
                       STRING(@s59),AT(50,39),USE(FILENAME1)
                       GROUP('.... tikai, ja izmantojat referenèu lîmeòa uzskaiti'),AT(20,58,187,50),USE(?Group1),BOXED
                         IMAGE('CHECK3.ICO'),AT(186,68,13,15),USE(?Image231),HIDE
                         IMAGE('CHECK3.ICO'),AT(186,85,13,15),USE(?Image531),HIDE
                       END
                       BUTTON('Sadalît neapmaksâtos 231... pa P/Z'),AT(35,69,145,14),USE(?Button231)
                       BUTTON('Sadalît neapmaksâtos 531... pa P/Z'),AT(35,86,145,14),USE(?Button531)
                       BUTTON('&Atlikt'),AT(143,119,36,14),USE(?CancelButton)
                       BUTTON('Veidot Sald&o rakstu'),AT(182,119,69,14),USE(?OkButton),DEFAULT
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  !---------Pirms Claris rauj vaïâ failus-------------
  !SPIEZAM TEKOSAJA UN RAKSTAM FILENAME1 FOLDERI KÂ GG,GGK (NY CREATOR)
  GGNAME='GG'&FORMAT(JOB_NR,@N02)  !LAI TAS MULKIS NELAMÂJAS, TAAPAT BUS JAATVER IEKS FILENAME1
  GGKNAME='GGK'&FORMAT(JOB_NR,@N02)
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
    OF ?Button231
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF N231
           N231=0
           HIDE(?IMAGE231)
        ELSE
           N231=1
           UNHIDE(?IMAGE231)
        .
        DISPLAY
      END
    OF ?Button531
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF N531
           N531=0
           HIDE(?IMAGE531)
        ELSE
           N531=1
           UNHIDE(?IMAGE531)
        .
        DISPLAY
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO PROCEDURERETURN
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        !STOP(FILENAME1&'='&PATH())
        IF FILENAME1=PATH()
          KLUDA(27,'FOLDERIS:'&FILENAME1)
          CYCLE
        .
        FILENAME2=FILENAME1    !?
        
        !
        ! Atrodamies FOLDERÎ, no kurienes JÂLASA
        !
        
        TARGETNAME=FILENAME1     !GRIEÞOT VÇLÂK NOMAITÂ
        LOOP JOB#=1 TO BASE_SK              !CAURI VISÂM ATÏAUTAJÂM BÂZÇM
           TTAKA"=PATH()
           SETPATH(TARGETNAME)                  !EJAM UZ MÇRÍA FOLDERI, KURÂ JÂRAKSTA
           IF ERROR()
              KLUDA(37,TARGETNAME)
              SETPATH(TTAKA")
              DO PROCEDURERETURN
           .
           CLOSE(GG)
           CLOSE(GGK)
           GGNAME='GG'&FORMAT(JOB#,@N02)
           GGKNAME='GGK'&FORMAT(JOB#,@N02)
           CHECKOPEN(GG,1)                  !ATVERAM MERKA FOLDERII, SALDO RAKSTI BÛS GG,GGK
           CHECKOPEN(GGK,1)
           SETPATH(TTAKA")                  !UN ATGRIEZAMIES TEKOSAJA (AVOTAA)
           CLOSE(G1)
           CLOSE(GK1)
           FILENAME1='GG'&FORMAT(JOB#,@N02) !G1 VARDS DATU AVOTA FOLDERII
           FILENAME2='GGK'&FORMAT(JOB#,@N02)
           CHECKOPEN(G1,1)                  !ATVERAM AVOTA FOLDERÎ
           CHECKOPEN(GK1,1)
           DO SASPIEST
        .
        DO PROCEDURERETURN
        
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF WindowOpened
    CLOSE(window)
  END
  CLOSE(ProgressWindow)
  FREE(K_TABLE)
  CLOSE(GLOBAL)
  CLOSE(SYSTEM)
  CLOSE(G1)
  CLOSE(GK1)
  close(KURSI_K)
  CLOSE(GG)
  CLOSE(GGK)
  !   JOB_NR=JOB_NR#
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
!*********KONTU SLÇDZÇJS*******************************************
SASPIEST ROUTINE

  RecordsToProcess = RECORDS(GK1)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  F:X=0  !ÐITÂ SKAITAM KÏÛDAS
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Analizçjam DB'
  ?Progress:UserString{Prop:Text}=''
  DISPLAY()


 !****************************** 1. SOLIS ******************************
 ! Atrodamies FOLDERÎ,no kurienes JÂLASA

  JOB_NR=JOB#             !DÇÏ SYSTEM


  close(GLOBAL)
  CHECKOPEN(GLOBAL,1)                        ! GLOBAL - NO KURIENES LASA
  close(KURSI_K)
  CHECKOPEN(KURSI_K,1)                       ! KURSI_K - NO KURIENES LASA
  close(SYSTEM)
  CHECKOPEN(SYSTEM,1)                        ! SYSTEM - NO KURIENES LASA,JOB:NR 1:1

!  IF ~BAND(SYS:control_byte,00000001b)       ! PZA ~OK
!       KLUDA(21,'objektam '&JOB_NR)
!  ELSIF ~BAND(SYS:control_byte,00000010b)    ! BILANCE ~OK
!       KLUDA(22,'objektam '&JOB_NR)
!  .

  FOUND#=0
  SOLIS=0

  CLEAR(GK1:RECORD)    !IEZAKA KONTROLE
  GK1:DATUMS=GL:DB_B_DAT
  SET(GK1:DAT_KEY,GK1:DAT_KEY)
  LOOP
     NEXT(GK1)
     IF ERROR() THEN BREAK.
     IF BAND(GK1:BAITS,00000001b) !PAZÎME IE/ZA NO KS
        FOUND#=1
        BREAK
     .
  .
  IF ~FOUND#
     KLUDA(25,FORMAT(GL:DB_B_DAT,@D06.)&' objektam '&JOB_NR,1,1) !IEZAKS
     F:X+=1
  .
  CLEAR(KUR:RECORD)       !UZTAISAM 1.DATUMA KURSUS NO 3X.DATUMA, JA TÂDI IR MÇRÍA FOLDERÎ
  SET(KURSI_K)
  LOOP
     NEXT(KURSI_K)
     IF ERROR() THEN BREAK.
     IF KUR:DATUMS=GL:DB_B_DAT
        KUR:DATUMS+=1
        ADD(KURSI_K)
     .
  .

!****************************** 2. SOLIS ******************************

  SOLIS=0
  SUMMA=0
  DONE# = 0
  I#=0
  PR#=0

  CLEAR(gk1:RECORD)
  set(GK1:BKK_DAT,GK1:BKK_DAT)
  DO NEXT_RECORD
  LOOP UNTIL DONE#

    !Elya 25/11/2013 IF ~(GK1:VAL='Ls ' OR GK1:VAL='LVL')         ! KONVERT & NEKONV VALÛTA
    IF (GL:DB_GADS <= 2013 AND ~(GK1:VAL='Ls' OR GK1:VAL='LVL')) OR (GL:DB_GADS > 2013 AND ~(GK1:VAL='EUR'))

                                                 ! PÂRBAUDAM PÇC VALÛTU KODIFIKÂTORA
       IF ~GETVAL_K(GK1:VAL,2)
          DO PROCEDURERETURN
       .
                                   ! PÂRBAUDAM PÇC KONTU PLÂNA
       C#=GETKON_K(GK1:BKK,2,1)
       IF GLOBALRESPONSE=REQUESTCANCELLED
          DO PROCEDURERETURN
       .
                                                                ! VALÛTU "ATCERAMIES" TIKAI, KUR JÂPÂRRÇÍINA
       IF BAND(KON:BAITS,00000001B) AND INRANGE(GK1:BKK[1],1,5) ! UN TIKAI 1-5 GRUPAI
       ELSE
          GK1:SUMMAV=GK1:SUMMA
          !Elya 25/11/2013 GK1:VAL='Ls '
          IF GL:DB_GADS <= 2013
             GK1:VAL='Ls '
          ELSE
             GK1:VAL='EUR'
          .
       .
    ELSE                                         ! PÇDÇJÂ Ls KONTROLE
       IF ~(GK1:SUMMA=GK1:SUMMAV)
          KLUDA(4,FORMAT(Gk1:DATUMS,@D6)&' Nr= '&GK1:U_NR) !?
          F:X+=1
          IF KLU_DARBIBA=0
             DO PROCEDURERETURN
          .
       .
    .

    IF CL_NR=1237                                ! GAG
       IF ~(GK1:BKK[1:3]='118'  OR |         ! ÐITOS IR JÂDALA PA PARTNERIEM
            GK1:BKK[1:3]='125'  OR |
            GK1:BKK[1:3]='131'  OR |
            GK1:BKK[1:3]='132'  OR |
            GK1:BKK[1:3]='133'  OR |
            GK1:BKK[1:3]='134'  OR |
            GK1:BKK[1:3]='136'  OR |
            GK1:BKK[1:3]='138'  OR |
            GK1:BKK[1:3]='219'  OR |
            GK1:BKK[1:3]='231'  OR | !232 Jâatstâj tiem, kam faktiskais naudas maksâtâjs ir bankserviss
            GK1:BKK[1:3]='233'  OR |
            GK1:BKK[1:3]='234'  OR |
            GK1:BKK[1:3]='235'  OR |
            GK1:BKK[1:3]='237'  OR |
            GK1:BKK[1:3]='238'  OR |
            GK1:BKK[1:3]='239'  OR |
            GK1:BKK[1:3]='241'  OR |
            GK1:BKK[1:3]='251'  OR |
            GK1:BKK[1:3]='252'  OR |
            GK1:BKK[1:3]='311'  OR |
            GK1:BKK[1:3]='336'  OR |
            GK1:BKK[1:2]='51'   OR |
            GK1:BKK[1:2]='52'   OR |
            GK1:BKK[1:3]='531'  OR | !532 tas pats kas 232
            GK1:BKK[1:2]='55'   OR |
            GK1:BKK[1:2]='58')
          GK1:PAR_NR=0
       .
    ELSE
       IF ~(GK1:BKK[1:3]='219'  OR |         ! ÐITOS IR JÂDALA PA PARTNERIEM
            GK1:BKK[1:3]='231'  OR | !232 Jâatstâj tiem, kam faktiskais naudas maksâtâjs ir bankserviss
            GK1:BKK[1:3]='521'  OR |
            GK1:BKK[1:3]='531'  OR | !532 tas pats kas 232
            GK1:BKK[1:2]='55'   OR |
            GK1:BKK[1:3]='238'  OR |
            GK1:BKK[1:3]='239')
          GK1:PAR_NR=0
       .
    .
    IF ~((GK1:BKK[1:3]='231' AND N231)  OR |      ! ÐITOS IR JÂDALA PA P/Z UN NODAÏÂM
         (GK1:BKK[1:3]='531' AND N531))
       GK1:REFERENCE=''
       GK1:NODALA=''
    ELSE
       IF GK1:U_NR>1  !~SALDO
          IF ((GK1:D_K='D' AND GK1:BKK[1:3]='231')| !Mûsu P/Z viòiem
          OR (GK1:D_K='K' AND GK1:BKK[1:3]='531'))  !Viòu P/Z mums
!          AND GK1:SUMMA>0                               !..nav STORNO  9/01/06
             CLEAR(G1:RECORD)
             G1:U_NR=GK1:U_NR
             GET(G1,G1:NR_KEY)
             GK1:REFERENCE=G1:DOK_SENR !IEDODAM REFERENCI P/Z KONTÇJUMAM
          .
       .
    .
    IF GK1:REFERENCE AND GK1:SUMMA<0 !ATGRIEZTS(STORNO)  !TIKAI 231.. 531..
       FOUND#=0
       LOOP I#= 1 TO RECORDS(K_TABLE)
          GET(K_TABLE,I#)
!          IF K:REFERENCE=GK1:REFERENCE AND K:PAR_NR=GK1:PAR_NR AND K:BKK=GK1:BKK AND K:VAL=GK1:VAL AND K:NODALA=GK1:NODALA AND GK1:PVN_PROC=K:PVN_PROC
!          IF K:REFERENCE=GK1:REFERENCE AND K:PAR_NR=GK1:PAR_NR AND K:BKK=GK1:BKK AND K:VAL=GK1:VAL AND K:NODALA=GK1:NODALA
          IF K:REFERENCE=GK1:REFERENCE AND K:PAR_NR=GK1:PAR_NR AND K:BKK=GK1:BKK AND K:VAL=GK1:VAL
             DO PUT_K_TABLE
             FOUND#=1
             BREAK
          .
       .
       IF ~FOUND#
          DO ADD_K_TABLE
       .
    ELSE
       GET(K_TABLE,0)
!       K:BPNR=GK1:BKK&FORMAT(GK1:PAR_NR,@S5)&GK1:VAL&GK1:REFERENCE&GK1:NODALA&GK1:PVN_PROC
!       K:BPNR=GK1:BKK&FORMAT(GK1:PAR_NR,@S5)&GK1:VAL&GK1:REFERENCE&GK1:NODALA
       K:BPNR=GK1:BKK&FORMAT(GK1:PAR_NR,@S5)&GK1:VAL&GK1:REFERENCE
          GET(K_TABLE,K:BPNR)
       IF ERROR()
          DO ADD_K_TABLE
       ELSE
          DO PUT_K_TABLE
       .
    .
    DO NEXT_RECORD                               !  GET NEXT RECORD
  .                                              !
!********************************** SARÇÍINAM LS VALÛTU ATLIKUMIEM *****

  SUMMA=0
  GET(K_TABLE,0)
  LOOP K#=1 TO RECORDS(K_TABLE)
    GET(K_TABLE,K#)
    !Elya 21/11/2013 IF ~(K:VAL='Ls' OR K:VAL='LVL')
    IF (GL:DB_GADS <= 2013 AND ~(K:VAL='Ls' OR K:VAL='LVL')) OR (GL:DB_GADS > 2013 AND ~(K:VAL='EUR'))
       B_KURSS=BANKURS(K:VAL,DATE(12,31,GL:DB_GADS))
       K:SUMMA=ROUND(B_KURSS*K:SUMMAV,.01)
       PUT(K_TABLE)
       SUMMA += K:SUMMA
    .
  .

  IF ~INRANGE(SUMMA,-0.05,0.05)
     KLUDA(28,'uz valûtu pârrçíinu par '&SUMMA)
     F:X+=1
  .

   !03/03/2015 IF GL:DB_GADS = 2013 THEN
   IF GL:DB_GADS = 2013 OR (GL:DB_GADS = 2014)
      GET(K_TABLE,0)
      LOOP K#=1 TO RECORDS(K_TABLE)
         GET(K_TABLE,K#)
         IF GL:DB_GADS = 2013 THEN                    !03/03/2015
            IF (K:VAL='Ls' OR K:VAL='LVL')
               K:SUMMA=ROUND(K:SUMMA/0.702804,.01)
               K:SUMMAV=K:SUMMA
               K:VAL='EUR'
            ELSIF K:VAL='EUR'
               K:SUMMA = K:SUMMAV
            ELSE
               K:SUMMA = ROUND(K:SUMMA/0.702804,.01)
            .
         ELSE                                            !03/03/2015
            IF (K:VAL='LTL') AND (GL:DB_GADS = 2014)     !03/03/2015
               K:SUMMAV=K:SUMMA                          !03/03/2015
               K:VAL='EUR'                               !03/03/2015
            .                                            !03/03/2015
         .
         PUT(K_TABLE)
      .
   .
!****************************** 3. SOLIS ******************************

  ProgressWindow{Prop:Text} = '.... rakstam SALDO'
  ?Progress:UserString{Prop:Text}=''
  DISPLAY()

  CLEAR(GG:RECORD)
  GG:U_NR=1
  SET(GG:NR_KEY,GG:NR_KEY)
  NEXT(GG)
  !STOP('1 '&GG:VAL)
  IF ERROR()
     STOP('MEKLÇJOT GG NR=1 MÇRÍA DIREKTORIJÂ')
  .
  IF RIDELETE:GG()
     KLUDA(26,'GG,GGK.TPS NR=1')
     F:X+=1
     DO PROCEDURERETURN
  .


  GG:U_NR=1
  GG:RS=''
  GG:DOK_SENR='SALDO'
  GG:DOKDAT=GL_DB_S_DAT
  GG:DATUMS=GL_DB_S_DAT
  GG:SATURS='Saldo uz '&FORMAT(GL_DB_S_DAT,@D06.)
  IF GL:DB_GADS >= 2013 THEN
     GG:VAL = 'EUR'
  END
  GG:summa=0
  GG:PAR_NR=0
  GG:ACC_DATUMS=TODAY()
  GG:ACC_KODS=ACC_KODS
  !STOP('2 '&GG:VAL)
  ADD(GG)
  !STOP('3 '&GG:VAL)
  IF ERROR()
     KLUDA(24,'GG')
     F:X+=1
     DO PROCEDURERETURN
  .

  GET(K_TABLE,0)
  LOOP K#=1 TO RECORDS(K_TABLE)
    GET(K_TABLE,K#)
    IF K:SUMMA <> 0
       GGK:U_NR=GG:U_NR
       GGK:DATUMS=GG:DATUMS
       GGK:RS=''
       GGK:PAR_NR=K:PAR_NR
       GGK:REFERENCE=K:REFERENCE
       GGK:BKK=K:BKK
       GGK:VAL=K:VAL
       GGK:PVN_PROC=K:PVN_PROC
       GGK:BAITS=0                  !BAITS...(8B-IEZAK)
       GGK:NODALA=K:NODALA
       IF K:SUMMA > 0
          GG:SUMMA+=K:SUMMA
          GGK:D_K = 'D'
          GGK:SUMMA = K:SUMMA
          GGK:SUMMAV = K:SUMMAV
       ELSE
          GGK:D_K = 'K'
          KR_SUMMA+=K:SUMMA
          GGK:SUMMA = ABS(K:SUMMA)
          GGK:SUMMAV = ABS(K:SUMMAV)
       .
       IF GGK:BKK='34100'   !PÂRSKATA GADA NESADALÎTÂ PEÏNA
          GGK:BKK='34200'   !IEPRIEKÐÇJO GADU NESADALÎTÂ PEÏNA
       .
       ADD(GGK)
       IF ERROR()
          KLUDA(24,'ggk.dat')
          F:X+=1
          DO PROCEDURERETURN
       .
    .
  .
  IF ~(GG:SUMMA=ABS(KR_SUMMA))
     KLUDA(28,GG:SUMMA-ABS(KR_SUMMA))
     F:X+=1
     CLEAR(GGK:RECORD)
     GGK:U_NR=GG:U_NR
     GGK:DATUMS=GG:DATUMS
     GGK:BKK='99999'
     !21/11/2013 Elya GGK:VAL='Ls'
     IF GL:DB_GADS >= 2013 THEN
        GGK:VAL='EUR'
     ELSE
        GGK:VAL='Ls'
     .
     IF GG:SUMMA>=ABS(KR_SUMMA) ! D>K
        GGK:D_K = 'K'
        GGK:SUMMA = GG:SUMMA-ABS(KR_SUMMA)
     ELSE
        GGK:D_K = 'D'
        GGK:SUMMA = ABS(KR_SUMMA)-GG:SUMMA
        GG:SUMMA  = ABS(KR_SUMMA)
     .
     GGK:SUMMAV = GGK:SUMMA
     ADD(GGK)
     IF ERROR()
        KLUDA(24,'ggk.dat')
        F:X+=1
        DO PROCEDURERETURN
     .
  .
  IF RIUPDATE:GG()
     KLUDA(24,'GG')
     F:X+=1
  .
  !STOP('4 '&GG:VAL)
  Progress:Thermometer = 100
  ?Progress:PctText{Prop:Text} = '100 %'
  DISPLAY()

  FREE(K_TABLE)
  CLOSE(ProgressWindow)

!-----------------------------------------------------------------------------------------------------
NEXT_RECORD ROUTINE                              !
  LOOP UNTIL EOF(gk1)                            !
    NEXT(gk1)                                    ! 

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
    DISPLAY()

    IF GK1:BKK[1] > '5' THEN BREAK.
    IF ~INRANGE(GK1:DATUMS,DB_S_DAT,DB_B_DAT)
       IF ~FOUNDFY#
          KLUDA(27,' ieraksts DB no '&FORMAT(GK1:DATUMS,@D06.)&' ignorçjam')
          F:X+=1
          FOUNDFY#=1
       .
       CYCLE
    .
    IF GK1:RS THEN CYCLE.                        ! NEAPSTIPRINÂTOS IGNORÇJAM
    IF BAND(GK1:BAITS,00000001b) THEN CYCLE.     ! SAVUS IEÒÇMUMUS/ZAUDÇJUMUS AIZMIRSTAM, JO
                                                 ! VIENALGA PÂRRÇÍINAM VISU UZ 01/01/...

    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG


!-----------------------------------------------------------------------------------------------------
ADD_K_TABLE ROUTINE
          K:BKK      = GK1:BKK
          K:PAR_NR   = GK1:PAR_NR
          K:REFERENCE= GK1:REFERENCE
          K:VAL      = GK1:VAL
          K:NODALA   = GK1:NODALA
          K:PVN_PROC = GK1:PVN_PROC
          IF GK1:D_K='D'
            K:SUMMA  =GK1:SUMMA
            K:SUMMAV =GK1:SUMMAV
          ELSE
            K:SUMMA  =-GK1:SUMMA
            K:SUMMAV =-GK1:SUMMAV
          .
          ADD(K_TABLE)
          IF ERROR()
             KLUDA(29,'')
             F:X+=1
             RETURN
          .
          SORT(K_TABLE,K:BPNR)
          IF ERROR()
             KLUDA(29,'')
             RETURN
          .

!-----------------------------------------------------------------------------------------------------
PUT_K_TABLE ROUTINE
          IF GK1:D_K='D'
            K:SUMMA +=GK1:SUMMA
            K:SUMMAV+=GK1:SUMMAV
          ELSE
            K:SUMMA -=GK1:SUMMA
            K:SUMMAV-=GK1:SUMMAV
          .
          PUT(K_TABLE)
          IF ERROR()
             KLUDA(29,0)
             F:X+=1
             RETURN
          .
