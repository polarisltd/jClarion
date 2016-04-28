                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTNK PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
NOL_TEX              STRING(80)
NOL_TEX1             STRING(40)
NOL_TEX2             STRING(40)
window               WINDOW('Filtrs kopsavilkumam'),AT(,,290,93),GRAY,MDI
                       PROMPT('&Nomenklat�ra'),AT(8,11,45,9),USE(?Prompt:NOMENKLAT),HIDE
                       ENTRY(@s15),AT(58,11,93,9),USE(NOMENKLAT),HIDE,FONT(,11,,),UPR
                       STRING('(Tuk�ums - nav filtra)'),AT(60,22,68,10),USE(?NOM_FILTRS),HIDE,FONT(,10,COLOR:Gray,)
                       BUTTON('Nolik&tavas'),AT(7,37,58,16),USE(?SelNolNr25),HIDE
                       STRING(@s55),AT(68,39,215,10),USE(NOL_TEX1),HIDE,FONT(,9,,)
                       STRING(@s55),AT(68,49,215,10),USE(NOL_TEX2),HIDE,FONT(,9,,)
                       BUTTON('&OK'),AT(202,62,35,13),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(241,62,36,13),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  !!D_K1      =''
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 2
     IF INSTRING(OPCIJA[I#],'123')
        EXECUTE I#
           BEGIN                         !  1
              UNHIDE(?PROMPT:NOMENKLAT)
              UNHIDE(?NOMENKLAT)
              UNHIDE(?NOM_FILTRS)
           .
           BEGIN                         !  2
              NOL_TEX   = FORMAT_NOLTEX25()
              NOL_TEX1=NOL_TEX[1:40]
              NOL_TEX2=NOL_TEX[41:80]
              UNHIDE(?SELNOLNR25)
              UNHIDE(?NOL_TEX1)
              UNHIDE(?NOL_TEX2)
              DISPLAY(?NOL_TEX1)
              DISPLAY(?NOL_TEX2)
           .
        .
     .
  .
  ACCEPT
    !IF ~(SAV_PAR_FILTRS=PAR_FILTRS)
    !   CASE PAR_FILTRS
    !   OF 'V'
    !       PAR_NR = 999999999
    !       HIDE(?PAR:NOS_S)
    !       UNHIDE(?SelParTipS)
    !       UNHIDE(?PAR_GRUPA)
    !       SELECT(?PAR_GRUPA)
    !   OF 'K'
    !       UNHIDE(?PAR:NOS_S)
    !       HIDE(?PAR_GRUPA)
    !       HIDE(?SelParTipS)
    !       PAR_grupa=''
    !       PAR_TIPS=''
    !       GlobalRequest = SelectRecord
    !       BrowsePAR_K
    !       IF GlobalResponse = RequestCompleted
    !         PAR_NR=PAR:U_NR
    !       ELSE
    !         PAR_NR=999999999
    !       END
    !   END
    !   SAV_PAR_FILTRS = PAR_FILTRS
    !.
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Prompt:NOMENKLAT)
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
    OF ?SelNolNr25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        Sel_Nol_Nr25 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
      NOL_TEX=FORMAT_NOLTEX25()
      NOL_TEX1=NOL_TEX[1:40]
      NOL_TEX2=NOL_TEX[41:80]
      DISPLAY(?NOL_TEX1,?NOL_TEX2)
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        FOUND#=0
        Loop I#=1 TO 25
           IF NOL_NR25[I#]=TRUE
              FOUND#=1
              BREAK
           .
        .
        IF ~FOUND#
           KLUDA(87,'nevienas Noliktavas Nr')
           select(?SelNolNr25)
        ELSE
           LocalResponse = RequestCompleted
           BREAK
        .
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
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IZZFILTNK','winlats.INI')
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('IZZFILTNK','winlats.INI')
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
GETGRUPA             FUNCTION (NOM_GRUPA,REQ,RET) ! Declare Procedure
  CODE                                            ! Begin processed code
!
!  RET=1 GRUPAS NOSAUKUMS
!

  IF ~(RET=1)
     RETURN('')
  .
  IF ~(GR1:GRUPA1=NOM_GRUPA)
     CHECKOPEN(GRUPA1,1)
     GRUPA1::USED+=1
     CLEAR(GR1:RECORD)
     GR1:GRUPA1=NOM_GRUPA
     GET(GRUPA1,GR1:GR1_KEY)
     IF ERROR()
        IF REQ
           KLUDA(16,'GRUPA: '&NOM_GRUPA)
        .
        CLEAR(GR1:RECORD)
        GLOBALRESPONSE=REQUESTCANCELLED
        RET=0
     .
     GRUPA1::USED-=1
     IF GRUPA1::USED=0
        CLOSE(GRUPA1)
     .
  .
  GLOBALRESPONSE=REQUESTCOMPLETED
  EXECUTE RET+1
     RETURN('')
     RETURN(GR1:NOSAUKUMS)
  .
BuildGGKTable        PROCEDURE (OPC)              ! Declare Procedure
NODALA         STRING(2)
REFERENCE      LIKE(GGT:REFERENCE)
OBJ_NR         USHORT
VALUTA         STRING(3)
KK             LIKE(GGK:KK)
SUMMALs        DECIMAL(14,5)
SUMMAV         DECIMAL(14,5)
SUMMALsDo      DECIMAL(14,5)
SUMMAVDo       DECIMAL(14,5)
BKK            STRING(5)
ASTE           STRING(7)
KOKUPVN        REAL
PVNMAKS        BYTE
KOEF           REAL

MAX_SUMMA      DECIMAL(9,2)
CTRL_SUMMA     DECIMAL(9,2)
DELTA          DECIMAL(9,2)
DAUDZUMSZ      LIKE(NOL:DAUDZUMS)

X_TABLE     QUEUE,PRE(X)
KEY            STRING(7)
PVN_PROC       BYTE
BKK            STRING(5)
SUMMA          DECIMAL(9,2)
            .

!PARTABLE       QUEUE,PRE(P)  !LAI SADAL�TU K P/Z D/K PA PARTNERIEM
!PAR_NR            ULONG
!SUMMAV            DECIMAL(14,5)
!               .
  CODE                                            ! Begin processed code
!  mas�vs pvnmas[R,K]: pvn% R:1 -summma kop� kur 'ar'  VISS
!  NO FILLPVN   14,6        R:2 -summma kop� kur 'bez' VISS
!                           R:3 -summma kop� kur 'ar'  PRECE
!                           R:4 -summma kop� kur 'bez' PRECE
!                           R:5 -summma kop� kur 'ar'  TARA
!                           R:6 -summma kop� kur 'bez' TARA
!                           R:7 -summma kop� kur 'ar'  PAKALPOJUMI
!                           R:8 -summma kop� kur 'bez' PAKALPOJUMI
!                           R:9 -summma kop� kur 'ar'  KOKMATERI�LI
!                           R:10-summma kop� kur 'bez' KOKMATERI�LI  
!                           R:11-summma kop� kur 'ar'  RA�OJUMI
!                           R:12-summma kop� kur 'bez' RA�OJUMI
!                           R:13-summma kop� kur 'ar'  IEPAKOJUMI&VIRTU�LIE
!                           R:14-summma kop� kur 'bez' IEPAKOJUMI&VIRTU�LIE
!                           K:1=0
!                           K:2=12%
!                           K:3=18/21/22%
!                           K:4=9%
!                           K:5=NEAPLIEKAMS
!                           K:6=5/10/12%
 FREE(GGK_TABLE)
 !stop('OPC '&OPC)
 CASE OPC
 OF 1     !**************************NOLIKTAVA-B�V� KATRAI P/Z***************************
!
! J�b�t pozicion�tam Pavad
! J�b�t pozicion�tam SYSTEM
! J�b�t atv�rtai Noliktavai
!
       PVNMAKS=0
       KK=''
       ASTE=''
       NODALA=PAV:NODALA
       OBJ_NR=PAV:OBJ_NR
       IF PAV:MAK_NR
          PAR_NR=PAV:MAK_NR
       ELSE
          PAR_NR=PAV:PAR_NR
       .
       CHECKOPEN(SYSTEM,1)
       IF GETPAR_K(PAR_NR,2,1)
          !20/08/2013 IF PAR:PVN[1:2]='LV'            ! IR PVN MAKS�T�JS LR
          IF ~(CLIP(PAR:PVN[1:2]) = '')
             PVNMAKS=1
          .
       .
       SIGN#=0   !Importa interfeis� j�b�t tikai D vai K, P/Z kont�jum� ar� P
       !stop('PAV:D_K '&PAV:D_K)
       CASE PAV:D_K
       OF 'D'
!          IF PAV:SUMMA<0 AND BAND(SYS:BAITS1,01000000B)  !ATGRIEZTA D PRECE ,J�UZSKATA PAR REALIZ�CIJU
!             SIGN#=-1
!             DO PERFORM_K
!          ELSE
             SIGN#=1
             DO PERFORM_D
!          .
       OF 'K'
       OROF 'P'
       OROF 'R'
!          IF PAV:SUMMA<0 AND BAND(SYS:BAITS1,10000000B)  !ATGRIEZTA K PRECE ,J�UZSKATA PAR IEN�KO�O
!             SIGN#=-1
!             DO PERFORM_D
!          ELSE
             SIGN#=1
             DO PERFORM_K
!          .
       ELSE
          STOP('BuildGGKtable::PAV:D_K:'&PAV:D_K)
       .

 OF 2  !***************************ALGA-B�V� VISIEM PA M�NE�IEM PIEPRAS�T� PERIOD�*********************
!
! J�b�t pozicion�tam ALGPA
! J�b�t pozicion�tam SYSTEM
! J�b�t atv�rtai ALGAS
!
       SIGN#    = 1
       PAR_NR   = 0
       PVN_PROC = 0
       PVN_TIPS = 0
       VALUTA   = val_uzsk
       KK       = ''
       ASTE     = ''

       CLEAR(ALG:RECORD)
       ALG:YYYYMM=ALP:YYYYMM
       SET(ALG:ID_KEY,ALG:ID_KEY)
       LOOP
          NEXT(ALGAS)
          IF ERROR() OR ~(ALG:YYYYMM=ALP:YYYYMM) THEN BREAK.
      !************************************* PIESKAIT�JUMI *********************
      !   
          LOOP J#=1 TO 20
             IF ~ALG:K[J#] THEN CYCLE.
             NODALA=GETDAIEV(ALG:K[J#],0,6)            !NODA�A TIEK �EMTA NO DAIEV-visaugst�k� priorit�te imp-int.
             IF ~NODALA THEN NODALA=ALG:NODALA.        !,JA NAV, NO ALG�M (B�V�JOT, NO KADRIEM)
!             NODALA=ALG:NODALA
             OBJ_NR=ALG:OBJ_NR
             BKK=GETDAIEV(ALG:K[J#],0,3)             !***DEBETA KONTI
             IF ~BKK
                IF ALG:K[J#]=860    ! SOCI�LAIE PABALSTI ??????
                   CYCLE
                ELSE
                   CASE ALG:STATUSS
                   OF '1'           ! ADMINSTR�CIJA
                   OROF '2'         ! ADMINSTR�CIJA
                      BKK='72200'
                   ELSE             ! PAMATDARBINIEKS
                      BKK='72100'
                   .
                .
             .
             D_K='D'
             SUMMALs =ALG:R[J#]
             SUMMAV=SUMMALs
             KK=2
             DO ADDTABLE

!             NODALA=''    GROSS
!             OBJ_NR=0
             BKK=GETDAIEV(ALG:K[J#],0,4)             !***KRED�TA KONTI
             IF ~BKK
                BKK='56100'
             .
             D_K='K'
             SUMMALs =ALG:R[J#]
             SUMMAV=SUMMALs
             KK=2
             DO ADDTABLE
          .
      !************************************* SOCI�LIE 37% ***********************
          NODALA=ALG:NODALA        !NO ALG�M, CITAS IESP�JAS NAV
          OBJ_NR=ALG:OBJ_NR
          CASE ALG:STATUSS
          OF '1'           ! ADMINSTR�CIJA
          OROF '2'         ! ADMINSTR�CIJA
             BKK='73100'   ! SOC NODOKLIS NO ADM.ALG�M
          ELSE             ! PAMATDARBINIEKS
             BKK='73110'   ! SOC NODOKLIS NO DARBINIEKU ALG�M ALG�M
          .
          D_K='D'
          SUMMALs =round(sum(40)*ALG:PR37/100,.01)
          SUMMAV=SUMMALs
          KK=4
          DO ADDTABLE

!          NODALA=''     GROSS
!          OBJ_NR=0
          D_K = 'K'
          IF SYS:K_KO
             BKK = SYS:K_KO
          ELSE
             BKK = '57230' ! SOC NODOKLIS
          .
          KK=4
          DO ADDTABLE

      !************************************* IETUR�JUMI ***********************

!          NODALA=''   GROSS
!          OBJ_NR=0
          LOOP J#=1 TO 15
             PAR_NR=0  !SPEC.VAJADZ�BA,JA J�KONT� ATSEVI��I
             BKK=''
             IF ~ALG:I[J#] THEN CYCLE.
             IF ALG:I[J#]='904' THEN CYCLE.          !AVANSUS NEKONT�JAM, LAI NEDUBL�JAS B�Z�
             IF ALG:I[J#] <= 903 OR INRANGE(ALG:I[J#],906,911)  !Iedz ien+Soc,P�R�JAIS PALIEK iek� 56100
                BKK='56100'
             ELSE
                BKK=GETDAIEV(ALG:I[J#],0,3)          !DEBETA KONTI
                IF BKK='*****' THEN CYCLE.           !PIEPRAS�TS NEKONT�T
                IF ~BKK
                   CYCLE
                .
             .
             D_K='D'
             SUMMALs =ALG:N[J#]
             SUMMAV=SUMMALs
             KK=1
             DO ADDTABLE

             IF ALG:I[J#]=903 OR ALG:I[J#]=910 OR ALG:I[J#] = 911  ! 1%
                PAR_NR=1  !SPEC.VAJADZ�BA,LAI IZKONT� ATSEVI��I
                BKK='57230'
             ELSIF INRANGE(ALG:I[J#],901,902) OR INRANGE(ALG:I[J#],906,909) ! NODOKLI
                BKK='57220'
             ELSE
                BKK=GETDAIEV(ALG:I[J#],0,4)          !KRED�TA KONTI
                IF BKK='*****' THEN CYCLE.           !PIEPRAS�TS NEKONT�T
                IF ~BKK
                   BKK='56200'                       !IZDALAM TIKAI, JA NOR�D�TS D-KONTS
                .
             .
             D_K='K'
             SUMMALs =ALG:N[J#]
             SUMMAV=SUMMALs
             KK=1
             DO ADDTABLE
          .
       .
 OF 3  !PAMATL�DZEK�I - B�V� VISIEM PAR KONKR�TU PERIODU
!
! J�b�t pozicion�tam PAMAT
! J�b�t pozicion�tam SYSTEM
! J�b�t atv�rtai PAMAM
!

       SIGN#    = 1
       PAR_NR   = 0
       OBJ_NR   = 0 !P/L NEUZTUR OBJEKTUS
       PVN_PROC = 0
       PVN_TIPS = 0
       VALUTA   = val_uzsk
       KK       = ''
       ASTE     = ''

       CLEAR(PAM:RECORD)
       SET(PAM:NR_KEY)
       LOOP
          GGSUMMA$ = 0
          NEXT(PAMAT)
          IF ERROR() THEN BREAK.
          IF INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1)) THEN CYCLE. !NO�EMTS IEPR.G-OS
          CLEAR(AMO:RECORD)
          BKK   = PAM:OKK7  !NOLIETOJUMA OPER�CIJU KONTS
          IF ~BKK THEN BKK='74200'.
          D_K   = 'D'
          AMO:U_NR=PAM:U_NR
          AMO:YYYYMM=S_DAT
          SET(AMO:NR_KEY,AMO:NR_KEY)
          LOOP
             NEXT(PAMAM)
             IF ERROR() OR ~(PAM:U_NR=AMO:U_NR AND AMO:YYYYMM < B_DAT) THEN BREAK.
             NODALA = AMO:NODALA
             SUMMALs  = AMO:NOL_LIN  !AMO:3 z�mes aiz komata-�EIT AR� RODAS DELTA
             SUMMAV = SUMMALs
             DO ADDTABLE             !OPER�CIJU KONTUS DALAM PA NODA��M
             GGSUMMA$ += AMO:NOL_LIN !3 z�mes aiz komata
          .
          NODALA=''
          BKK    = PAM:BKKN !�EMAM NOST NO NOLIETOJUMA BILANCES KONTA
          IF ~BKK THEN BKK='12900'.
          D_K    = 'K'
!          SUMMALs  = GGSUMMA$
          SUMMALs  = ROUND(GGSUMMA$,.01) !18.04.07.
          SUMMAV = SUMMALs
          DO ADDTABLE
       .
 OF 4  !PAMATL�DZEK�I - B�V� NO�EM�ANU VISIEM KONKR�T� DATUM�
!
! J�b�t pozicion�tam PAMAT
! J�b�t pozicion�tam SYSTEM
! J�b�t atv�rtai PAMAM
!

       SIGN#    = 1
       PAR_NR   = 0
       OBJ_NR   = 0 !P/L NEUZTUR OBJEKTUS
       PVN_PROC = 0
       PVN_TIPS = 0
       VALUTA   = val_uzsk
       KK       = ''
       ASTE     = ''
       NODALA=''

       CLEAR(PAM:RECORD)
       SET(PAM:NR_KEY)
       LOOP
          GGSUMMA$ = 0
          NEXT(PAMAT)
          IF ERROR() THEN BREAK.
          IF ~(PAM:END_DATE=B_DAT) THEN CYCLE. !NAV NO�EMTS PIEPRAS�TAJ� DATUM�
          CLEAR(AMO:RECORD)
          AMO:U_NR=PAM:U_NR
          AMO:YYYYMM=DATE(MONTH(B_DAT),1,YEAR(B_DAT))
          GET(PAMAM,AMO:NR_KEY)
          IF ~ERROR() 
             BKK   = PAM:BKK  !BILANCES KONTS
             IF ~BKK THEN BKK='12300'.  !DATORI-KAUT KAS TA�U J�IELIEK
             D_K   = 'K'       !�EMAM NOST NO BILANCES KONTA
             SUMMALs = AMO:IZSLEGTS
             SUMMAV  = SUMMALs
             DO ADDTABLE             
             D_K    = 'D'
             BKK    = PAM:BKKN !LIEKAM KL�T NOLIETOJUMA BILANCES KONTAM
             IF ~BKK THEN BKK='12390'.
             SUMMALs = AMO:IZSLEGTS
             SUMMAV  = SUMMALs
             DO ADDTABLE
          .
       .
 .

!********************************************************
!*********************** ROUTINES **********************
!********************************************************


!-----------------------------------------------------------------------------------------------
PERFORM_D   ROUTINE
!*********************** IEN�KO��S **********************
!*********************TRANSPORTS UZ D/K ****************************

          SUMMALs =PAV:T_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS)
          SUMMAV=PAV:T_SUMMA
          CASE PAV:APM_V
          OF '1'          ! PRIEK�APMAKSA
             BKK   =SYS:D_DK_PRI
          OF '2'          ! P�CAPMAKSA
          OROF '3'        ! KONSIGN�CIJA
             BKK   =SYS:D_DK_PEC
          OF '4'          ! UZREIZ
             BKK   =SYS:D_DK_UKA
          ELSE            !APMAKSA NAV PAREDZ�TA
             BKK   ='99999'
          .
          ASTE='K000'&PAV:VAL
          DO ADDTABLE
 
!********************* TRANSPORTS-7GRUP� BEZ PVN *********************
 
          SUMMALs =PAV:T_SUMMA/(1+PAV:T_PVN/100)*BANKURS(PAV:VAL,PAV:DATUMS)
          SUMMAV=SUMMALs
          BKK = SYS:D_TR
          ASTE='D000'&val_uzsk
          DO ADDTABLE
 
!********************* PVN TRANSPORTAM *******************************
 
          SUMMALs =PAV:T_SUMMA*(1-1/(1+PAV:T_PVN/100))*BANKURS(PAV:VAL,PAV:DATUMS)
          SUMMAV=SUMMALs
          IF PAV:APM_V='2' OR PAV:APM_V='3' !P�CAPMAKSA/KONSIGN�CIJA
             BKK = SYS:D_PVN_PEC
          ELSE
             BKK = SYS:D_PVN_PRI
          .
          ASTE='D'&FORMAT(PAV:T_PVN,@N02)&'0'&val_uzsk   ! 18/21%
          DO ADDTABLE

!********************GRIE�AM NOLIKTAVU D�� KOP�J�M SUMM�M************

          clear(nol:record)
          NOL:U_NR=PAV:U_NR
          FILLPVN(0)
          SET(NOL:NR_KEY,NOL:NR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR = PAV:U_NR) THEN BREAK.
             I#=GETNOM_K(NOL:NOMENKLAT,2,1)
             !stop ('PVN_PROC '&PVN_PROC)
             FILLPVN(1,NOM:PVN_PROC) !AIZPILDA AR� PVNMASMODE
             !stop ('PVNMASMODE '&PVNMASMODE)
          .

!************************** D/K ****************************
          !Elya 28.05.2013 GETPAR_K(PAV:PAR_NR,0,20)='N'                     ! ~ES
 
          IF NOM:TIPS='K' AND PVNMAKS OR|                   ! KOKMATERI�LI & IR PVN MAKS�T�JS
          GETPAR_K(PAV:PAR_NR,0,20)='C' OR|                 ! ES
          GETPAR_K(PAV:PAR_NR,0,20)='N'  OR|                    ! ~ES
          (NOT PVNMAKS)
             SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3) ! BEZ PVN, Ls
             SUMMAV=GETPVN(3)                               ! BEZ PVN, VAL�T�
          ELSE
             SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(2) ! AR  PVN, Ls
             SUMMAV=GETPVN(2)                               ! AR  PVN, VAL�T�
          .
          CASE PAV:APM_V
          OF '1'          ! PRIEK�APMAKSA
             BKK   =SYS:D_DK_PRI
          OF '2'          ! P�CAPMAKSA
          OROF '3'        ! KONSIGN�CIJA
             BKK   =SYS:D_DK_PEC
          OF '4'          ! UZREIZ
             BKK   =SYS:D_DK_UKA
          .
          IF PVNMASMODE=1    !no FILLPVN
             ASTE='K210'&PAV:VAL
          ELSIF PVNMASMODE=3    !no FILLPVN
             ASTE='K220'&PAV:VAL
          ELSIF PVNMASMODE=2 !no FILLPVN
             ASTE='K180'&PAV:VAL
          ELSE
             ASTE='K000'&PAV:VAL
          .
          IF ~PVNMAKS              !Elya 28.05.2013 
             ASTE='K000'&PAV:VAL   !Elya 28.05.2013
          .                        !Elya 28.05.2013 
          DO ADDTABLE

!************* PVN NO PRECES *************************************
!            ar� ES precei PVN IR j�r��ina
 
          IF PAV:APM_V='2' OR PAV:APM_V='3' !P�CAPMAKSA/KONSIGN�CIJA
             IF ~PVNMAKS              !Elya 28.05.2013
             !Elya 28.05.2013 IF NOM:TIPS='K' AND PVNMAKS ! KOKMATERI�LI & IR PVN MAKS�T�JS
             ELSIF NOM:TIPS='K' AND PVNMAKS ! KOKMATERI�LI & IR PVN MAKS�T�JS
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(1) ! PVN
                SUMMAV=SUMMALs
!                PVN_PROC='18'
!                PVN_PROC=NOM:PVN_PROC
                PVN_PROC=SYS:NOKL_PVN    !�IT� B�S LAB�K
                PVN_TIPS='3'
                DO PERFORM4PVN !reversa kontejums
             ELSE
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(11) ! PVN 18/21%
                SUMMAV=SUMMALs
                IF PVNMASMODE=1    !no FILLPVN
                   ASTE='D210'&val_uzsk
                ELSIF PVNMASMODE=3    !no FILLPVN
                   ASTE='D220'&val_uzsk
                ELSIF PVNMASMODE=2 !no FILLPVN
                   ASTE='D180'&val_uzsk
                ELSE
                   ASTE='D000'&val_uzsk
                .
                BKK = SYS:D_PVN_PEC
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   SUMMAV=GETPVN(11)
                   DO PERFORM2PVN
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(15) ! PVN 9%
                SUMMAV=SUMMALs
                ASTE='D090'&val_uzsk
                BKK = SYS:D_PVN_PEC
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   SUMMAV=GETPVN(15)
                   DO PERFORM2PVN
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(18) ! PVN 5/10%
                SUMMAV=SUMMALs
                IF PVNMASMODE=1
                   ASTE='D100'&val_uzsk
                ELSIF PVNMASMODE=3
                   ASTE='D120'&val_uzsk
                ELSIF PVNMASMODE=2
                   ASTE='D050'&val_uzsk
                ELSE
                   ASTE='D000'&val_uzsk
                .
                BKK = SYS:D_PVN_PEC
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   SUMMAV=GETPVN(18)
                   DO PERFORM2PVN
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                !Elya 28.05.2013 begin
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(10) ! PVN 12%
                SUMMAV=SUMMALs
                !Elya28/05/2013IF PVNMASMODE=1
                IF (PVNMASMODE=1) AND (PAV:DATUMS > date(06,30,2012))  !Elya28/05/2013
                   ASTE= 'D120'&val_uzsk   !Elya28/05/2013
                ELSIF PVNMASMODE=1       !Elya28/05/2013
                   ASTE='D100'&val_uzsk
                ELSIF PVNMASMODE=3
                   ASTE='D120'&val_uzsk
                ELSIF PVNMASMODE=2
                   ASTE='D050'&val_uzsk
                ELSE
                   ASTE='D000'&val_uzsk
                .
                BKK = SYS:D_PVN_PEC
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   !Elya 28.05.2013 SUMMAV=GETPVN(18)
                   SUMMAV=GETPVN(10)
                   DO PERFORM2PVN
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                !Elya 28.05.2013 end

             .
        ELSE
             IF ~PVNMAKS              !Elya 28.05.2013
             !Elya 28.05.2013 IF NOM:TIPS='K'    !KOKMATERI�LI
             ELSIF NOM:TIPS='K'    !KOKMATERI�LI
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(1) ! PVN
                SUMMAV=SUMMALs
                IF PVNMASMODE=1
                   ASTE='D100'&val_uzsk
                   PVN_PROC=10
                ELSIF PVNMASMODE=3
                   ASTE='D120'&val_uzsk
                   PVN_PROC=12
                ELSIF PVNMASMODE=2
                   ASTE='D050'&val_uzsk
                   PVN_PROC=5
                ELSE
                   ASTE='D000'&val_uzsk
                   PVN_PROC=0
                .

                PVN_TIPS='3'
                DO PERFORM4PVN
             ELSE
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(11) ! PVN 18/21%
                SUMMAV=SUMMALs
                IF PVNMASMODE=1
                   ASTE='D210'&val_uzsk
                   PVN_PROC=21
                ELSIF PVNMASMODE=3
                   ASTE='D220'&val_uzsk
                   PVN_PROC=22
                ELSIF PVNMASMODE=2
                   ASTE='D180'&val_uzsk
                   PVN_PROC=18
                ELSE
                   ASTE='D000'&val_uzsk
                   PVN_PROC=0
                .
                BKK = SYS:D_PVN_PRI
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   IF BAND(SYS:BAITS1,00000010B)              ! PVN neKONT� JAU MAKS�JOT - POGA AUTOKONT.
                      SUMMAV=GETPVN(11)
                      DO PERFORM2PVN
                   .
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(15) ! PVN 9%
                SUMMAV=SUMMALs
                ASTE='D090'&val_uzsk
                BKK = SYS:D_PVN_PRI
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   IF BAND(SYS:BAITS1,00000010B)              ! PVN neKONT� JAU MAKS�JOT
                      SUMMAV=GETPVN(15)
                      DO PERFORM2PVN
                   .
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(18) ! PVN 5/10%
                SUMMAV=SUMMALs
                IF PVNMASMODE=1
                   ASTE='D100'&val_uzsk
                ELSIF PVNMASMODE=3
                   ASTE='D120'&val_uzsk
                ELSIF PVNMASMODE=2
                   ASTE='D050'&val_uzsk
                ELSE
                   ASTE='D000'&val_uzsk
                .
                BKK = SYS:D_PVN_PRI
                IF GETPAR_K(PAV:PAR_NR,0,20)='C'              ! ES
                   IF BAND(SYS:BAITS1,00000010B)              ! PVN neKONT� JAU MAKS�JOT
                      SUMMAV=GETPVN(18)
                      DO PERFORM2PVN
                   .
                ELSIF GETPAR_K(PAV:PAR_NR,0,20)='N'           ! ~ES
!                   3.PASAULES VALST�M PVN NO MKD
                ELSE
                   DO ADDTABLE
                .
             .
          .
!******************** GRIE�AM NOLIKTAVU  **************************

          clear(nol:record)
          NOL:U_NR  =PAV:U_NR
          MAX_SUMMA =0
          CTRL_SUMMA=0
          SET(NOL:NR_KEY,NOL:NR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR = PAV:U_NR) THEN BREAK.
             I#=GETNOM_K(NOL:NOMENKLAT,2,1)

!************* PRECE-2GRUP� +(TRANSPORTS???????????) **************

             SUMMALs =CALCSUM(15,5) !Ls -- D�� �IT� NOJ�K SANT�MI !!!
             SUMMAV=SUMMALs
             IF ~NOM:BKK 
                IF NOM:TIPS='T'
                   BKK = SYS:D_TA
                ELSIF NOM:TIPS='A'
                   BKK = SYS:D_PA
                ELSIF NOM:TIPS='K'
                   BKK = SYS:D_KO
                ELSE
                   BKK = SYS:D_PR
                .
             ELSE
                BKK = NOM:BKK
             .
!             X:KEY=BKK&FORMAT(NOM:PVN_PROC,@N2)
             X:KEY=BKK&FORMAT(NOL:PVN_PROC,@N2)
             GET(X_TABLE,X:KEY)
             IF ERROR()
                X:BKK=BKK
!                X:PVN_PROC=NOM:PVN_PROC
                X:PVN_PROC=NOL:PVN_PROC
                X:SUMMA=SUMMALs
                ADD(X_TABLE)
                SORT(X_TABLE,X:KEY)
             ELSE
                X:SUMMA+=SUMMALs
                PUT(X_TABLE)
             .
             IF X:SUMMA > MAX_SUMMA THEN MAX_SUMMA=X:SUMMA.
             CTRL_SUMMA+=SUMMALs
          .
          DELTA=ROUND(BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3),.01)-CTRL_SUMMA
          LOOP X#= 1 TO RECORDS(X_TABLE)
             GET(X_TABLE,X#)
             BKK=X:BKK
             SUMMALs=X:SUMMA
             IF X:SUMMA=MAX_SUMMA
                SUMMALs+=DELTA
                DELTA=0
             .
             SUMMAV=SUMMALs
             ASTE='D'&FORMAT(X:PVN_PROC,@N2)&'0'&val_uzsk
             DO ADDTABLE
          .
          FREE(X_TABLE)

!-----------------------------------------------------------------------------------------------
PERFORM_K   ROUTINE
!*********************** IZEJO��S **********************
!************* TRANSPORTS-6...BEZ PVN Ls *************************************

          SUMMALs =PAV:T_SUMMA/(1+PAV:T_PVN/100)*BANKURS(PAV:VAL,PAV:DATUMS)
          SUMMAV=SUMMALs
          BKK = SYS:K_TR
!          IF GETPAR_K(PAV:PAR_NR,0,20)='C' THEN BKK[5]=SYS:BAITS.   ! ES SYS:SUB_ES
          IF GETPAR_K(PAV:PAR_NR,0,20)='C' THEN BKK[5]=SYS:SUB_ES.   ! ES SYS:SUB_ES
          ASTE='K000'&val_uzsk
          DO ADDTABLE
 
!************* TRANSPORTS UZ D/K *************************************

          CASE PAV:APM_V
          OF '1'                      ! PRIEK�APMAKSA BEZ PVN
             SUMMALs =PAV:T_SUMMA/(1+PAV:T_PVN/100)*BANKURS(PAV:VAL,PAV:DATUMS)
             SUMMAV=PAV:T_SUMMA/(1+PAV:T_PVN/100)
             BKK   =SYS:K_DK_PRI
          OF '2'          ! P�CAPMAKSA
          OROF '3'        ! KONSIGN�CIJA
             SUMMALs =PAV:T_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS)
             SUMMAV=PAV:T_SUMMA
             BKK   =SYS:K_DK_PEC
          OF '4'          ! UZREIZ
             SUMMALs =PAV:T_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS)
             SUMMAV=PAV:T_SUMMA
             BKK   =SYS:K_DK_UKA
          .
          ASTE='D000'&PAV:VAL
          DO ADDTABLE
                                        
!************* PVN TRANSPORTAM *************************************

          IF ~PAV:APM_V='1'               ! ~PRIEK�APMAKSA
             SUMMALs =PAV:T_SUMMA*(1-1/(1+PAV:T_PVN/100))*BANKURS(PAV:VAL,PAV:DATUMS)
             SUMMAV=SUMMALs
             BKK = SYS:K_PVN
             IF PVNMASMODE=1
                ASTE='K210'&val_uzsk   ! CIETI 21%
             ELSIF PVNMASMODE=3
                ASTE='K220'&val_uzsk   ! CIETI 22%
             ELSIF PVNMASMODE=2
                ASTE='K180'&val_uzsk   ! CIETI 18%
             ELSE
                ASTE='K000'&val_uzsk
             .
             DO ADDTABLE
          .
 
!********************GRIE�AM NOLIKTAVU ****************************

          clear(nol:record)
          NOL:U_NR=PAV:U_NR
          FILLPVN(0)
          SET(NOL:NR_KEY,NOL:NR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR = PAV:U_NR) THEN BREAK.
             I#=GETNOM_K(NOL:NOMENKLAT,2,1)
             FILLPVN(1)
             IF NOL:NOMENKLAT[1:8]='DDZZ2010'
                ZEMNIEKS#=TRUE
                DAUDZUMSZ+=NOL:DAUDZUMS
             .
!             P:PAR_NR=NOL:PAR_NR        !DA��DI PARTNERI N�K NO POS-A UN KARTEI/KE�AM/APDRO�IN.
!             GET(PARTABLE,P:PAR_NR)     !LAB�K TAIS�T ATSEVI��AS P/Z
!             IF ~ERROR()
!                P:SUMMAV+=CALCSUM(3,5)  !S BEZ PVN VAL�T�-A !!! AR/BEZ F(AV!!!!!!!)
!                PUT(PARTABLE)
!             ELSE
!                P:SUMMAV =CALCSUM(3,5)
!                ADD(PARTABLE)
!                SORT(PARTABLE,P:PAR_NR)
!             .
          .

!*********************************** D/K ***************************
          PVN#=0
          CASE PAV:APM_V
          OF '1'                                          ! PRIEK�APMAKSA
             IF BAND(SYS:BAITS1,00000001B) AND ~(GETPAR_K(PAV:PAR_NR,0,20)='C')  ! PVN KONT� uz DK un K23990 SA�EMOT NAUDU
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(2) ! AR  PVN, Ls
                SUMMAV=GETPVN(2)                             ! AR  PVN, VAL�T�
             ELSE
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3) ! BEZ PVN, Ls
                SUMMAV=GETPVN(3)                             ! BEZ PVN, VAL�T�
             .
             BKK   =SYS:K_DK_PRI
          OF '2'          ! P�CAPMAKSA
          OROF '3'        ! KONSIGN�CIJA
             IF (NOM:TIPS='K' AND PVNMAKS) |! KOKMATERI�LI & IR PVN MAKS�T�JS
                OR GETPAR_K(PAV:PAR_NR,0,20)='C'    ! ES
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3) ! BEZ PVN, Ls
                SUMMAV=GETPVN(3)                             ! BEZ PVN, VAL�T�
             ELSE
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(2) ! AR  PVN, Ls
                SUMMAV=GETPVN(2)                             ! AR  PVN, VAL�T�
             .
             BKK   =SYS:K_DK_PEC
          OF '4'          ! UZREIZ
             IF GETPAR_K(PAV:PAR_NR,0,20)='C'    ! ES
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3) ! BEZ PVN, Ls
                SUMMAV=GETPVN(3)                             ! BEZ PVN, VAL�T�
             ELSE
                SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(2) ! AR  PVN, Ls
                SUMMAV=GETPVN(2)                             ! AR  PVN, VAL�T�
                BKK =SYS:K_DK_UKA
!                IF ~PVN# AND GETPVN(1)     ! LAI KASES KONTAM PIELIEK KL�T 18/21%
!                   PVN#=1
!                .
             .
          .
!          IF PVN#                          ! LAI KASES KONTAM PIELIEK KL�T 18/21% ....NENOPIETNI
             IF PVNMASMODE=1
                ASTE='D210'&PAV:VAL
             ELSIF PVNMASMODE=3
                ASTE='D220'&PAV:VAL
             ELSIF PVNMASMODE=2
                ASTE='D180'&PAV:VAL
             ELSE
                ASTE='D000'&PAV:VAL
             .
!             PVN#=0
!          ELSE
!             ASTE='D000'&PAV:VAL
!          .
          DO ADDTABLE
          IF ZEMNIEKS#=TRUE
             SUMMALs = DAUDZUMSZ * .223
             SUMMAV  = SUMMALs
             ASTE='K210'&PAV:VAL
             DO ADDTABLE
             BKK='71100'
             ASTE='D210'&PAV:VAL
             DO ADDTABLE
          .

!          LOOP I#=1 TO RECORDS(PARTABLE) !SADALAM D/K PA PARTNERIEM
!             GET(PARTABLE,I#)
!             KOEF=SUMMAV/P:SUMMAV
!             SUMMALs =ROUND(SUMMALs *KOEF,.01)
!             SUMMAV=ROUND(SUMMAV*KOEF,.01)
!             PAR_NR=P:PAR_NR
!             DO ADDTABLE
!          .
!          FREE(PARTABLE)
!          PAR_NR=PAV:PAR_NR

!**************************** 6-GRUPA ******************************

          clear(nol:record)
          NOL:U_NR  =PAV:U_NR
          MAX_SUMMA =0
          CTRL_SUMMA=0
          SET(NOL:NR_KEY,NOL:NR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:U_NR = PAV:U_NR) THEN BREAK.
             I#=GETNOM_K(NOL:NOMENKLAT,2,1)
             SUMMALs =CALCSUM(15,5) !Ls -- D�� �IT� NOJ�K SANT�MI !!!
             SUMMAV=SUMMALs
             IF NOM:OKK6
                BKK=NOM:OKK6
             ELSE
                CASE NOM:TIPS
                OF 'A'    ! APKALPO�ANA 
                   BKK = SYS:K_PA
                OF 'T'    ! TARA
                   BKK = SYS:K_TA
                OF 'K'    ! KOKMATERI�LI
   !                IF PAR:TIPS='C'
   !                   BKK = '62211'   !SEZ & EKSPORTS
   !                ELSE
                      BKK = SYS:K_KO
   !                .
                ELSE      ! PRECE UN RA�OJUMI
                   BKK = SYS:K_PR
                .
             .
             IF GETPAR_K(PAV:PAR_NR,0,20)='C' THEN BKK[5]=SYS:SUB_ES.   ! ES
!             X:KEY=BKK&FORMAT(NOM:PVN_PROC,@N2)
             X:KEY=BKK&FORMAT(NOL:PVN_PROC,@N2)
             GET(X_TABLE,X:KEY)
             IF ERROR()
                X:BKK=BKK
!                X:PVN_PROC=NOM:PVN_PROC
                X:PVN_PROC=NOL:PVN_PROC
                X:SUMMA=SUMMALs
                ADD(X_TABLE)
                SORT(X_TABLE,X:KEY)
             ELSE
                X:SUMMA+=SUMMALs
                PUT(X_TABLE)
             .
             IF X:SUMMA > MAX_SUMMA THEN MAX_SUMMA=X:SUMMA.
             CTRL_SUMMA+=SUMMALs
          .
          DELTA=ROUND(BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(3),.01)-CTRL_SUMMA
          !Stop(DELTA)
          LOOP X#= 1 TO RECORDS(X_TABLE)
             GET(X_TABLE,X#)
             BKK=X:BKK
             SUMMALs=X:SUMMA
             IF X:SUMMA=MAX_SUMMA
                SUMMALs+=DELTA
                DELTA=0
             .
             SUMMAV=SUMMALs
             ASTE='K'&FORMAT(X:PVN_PROC,@N2)&'0'&val_uzsk
             DO ADDTABLE
          .
          FREE(X_TABLE)

!**************************** PVN **********************************
!           no 01.01.2007 PVN ES vairs nevajag.......

          IF ~INSTRING(GETPAR_K(PAV:PAR_NR,0,20),'CN')   ! ES,SEZ&EXPORTS
             KOKUPVN =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(7) ! KOKI BEZ PVN, Ls
             IF PVNMASMODE=1
                KOKUPVN =ROUND(KOKUPVN*21/100,.01)
             ELSIF PVNMASMODE=3
                KOKUPVN =ROUND(KOKUPVN*22/100,.01)
             ELSIF PVNMASMODE=2
                KOKUPVN =ROUND(KOKUPVN*18/100,.01)
             ELSE
                KOKUPVN =0
             .
             CASE PAV:APM_V
             OF '1'
                IF GETPVN(7) AND PVNMAKS ! KOKMATERI�LI & IR PVN MAKS�T�JS
                   SUMMALs =KOKUPVN
                   SUMMAV=SUMMALs
                   IF PVNMASMODE=1
                      PVN_PROC='21'
                   ELSIF PVNMASMODE=3
                      PVN_PROC='22'
                   ELSIF PVNMASMODE=2
                      PVN_PROC='18'
                   ELSE
                      PVN_PROC='00'
                   .
                   PVN_TIPS='5'
                   DO PERFORM4PVN
                ELSIF BAND(SYS:BAITS1,00000001B)     ! PVN KONT� uz DK un K23990 SA�EMOT NAUDU
                   SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(1) ! PVN summa
                   SUMMALs-=KOKUPVN
                   SUMMAV=SUMMALs
                   BKK = '23990'
                   ASTE='K000'&val_uzsk
                   DO ADDTABLE
                .
             ELSE
                IF GETPVN(7) AND PVNMAKS ! KOKMATERI�LI & IR PVN MAKS�T�JS
                   IF PAV:APM_K='2' ! SKAIDR� ANYWAY MAZUMTIRDZNIEC�BA
                      SUMMALs =KOKUPVN
                      SUMMAV=SUMMALs
                      BKK = '57211'
                      IF PVNMASMODE=1
                         ASTE='K216'&val_uzsk
                      ELSIF PVNMASMODE=3
                         ASTE='K226'&val_uzsk
                      ELSIF PVNMASMODE=2
                         ASTE='K186'&val_uzsk
                      ELSE
                         ASTE='K006'&val_uzsk
                      .
                      DO ADDTABLE
                   ELSE
                      SUMMALs =KOKUPVN
                      SUMMAV=SUMMALs
                      IF PVNMASMODE=1
                         PVN_PROC='21'
                      ELSIF PVNMASMODE=3
                         PVN_PROC='22'
                      ELSIF PVNMASMODE=2
                         PVN_PROC='18'
                      ELSE
                         PVN_PROC='00'
                      .
                      PVN_TIPS='5'
                      DO PERFORM4PVN
                   .
                ELSE
                   IF GETPVN(7) ! KOKMATERI�LI & NAV PVN MAKS�T�JS
                      SUMMALs =KOKUPVN
                      SUMMAV=SUMMALs
                      BKK = '57211'
                      IF PVNMASMODE=1
                         ASTE= 'K216'&val_uzsk
                      ELSIF PVNMASMODE=3
                         ASTE= 'K226'&val_uzsk
                      ELSIF PVNMASMODE=2
                         ASTE= 'K186'&val_uzsk
                      ELSE
                         ASTE= 'K006'&val_uzsk
                      .
                      DO ADDTABLE
                   ELSE         ! PARASTS PVN-s
                      !stop('PARASTS PVN-s'&PVNMASMODE)
                      !stop('11 '&GETPVN(11))
                      SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(11) ! PVN 18/21%
                      SUMMALs-=KOKUPVN  !kokupvn var b�t tikai 18/21%
                      SUMMAV=SUMMALs
                      BKK = SYS:K_PVN
                      IF PVNMASMODE=1
                         ASTE='K210'&val_uzsk
                      ELSIF PVNMASMODE=3
                         ASTE='K220'&val_uzsk
                      ELSIF PVNMASMODE=2
                         ASTE='K180'&val_uzsk
                      ELSE
                         ASTE='K000'&val_uzsk
                      .
                      DO ADDTABLE
                      !stop('10 '&GETPVN(10))
                      !stop('15 '&GETPVN(15))
                      SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(15) ! PVN 9%
                      SUMMAV=SUMMALs
                      BKK = SYS:K_PVN
                      ASTE= 'K090'&val_uzsk
                      DO ADDTABLE
                      !stop('18 '&GETPVN(18))
                      SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(18) ! PVN 5/10%
                      SUMMAV=SUMMALs
                      BKK = SYS:K_PVN
                      IF PVNMASMODE=1
                         ASTE= 'K100'&val_uzsk
                      ELSIF PVNMASMODE=3
                         ASTE= 'K120'&val_uzsk
                      ELSIF PVNMASMODE=2
                         ASTE= 'K050'&val_uzsk
                      ELSE
                         ASTE= 'K000'&val_uzsk
                      .
                      DO ADDTABLE
                      !Elya 21.05.2013 begin
                      SUMMALs =BANKURS(PAV:VAL,PAV:DATUMS)*GETPVN(10) ! PVN 12%
                      SUMMAV=SUMMALs
                      BKK = SYS:K_PVN
                      !Elya22/05/2013 IF PVNMASMODE=1 
                      IF (PVNMASMODE=1) AND (PAV:DATUMS > date(06,30,2012))  !Elya22/05/2013
                         ASTE= 'K120'&val_uzsk   !Elya22/05/2013 
                      ELSIF PVNMASMODE=1       !Elya22/05/2013 
                         ASTE= 'K100'&val_uzsk
                      ELSIF PVNMASMODE=3
                         ASTE= 'K120'&val_uzsk
                      ELSIF PVNMASMODE=2
                         ASTE= 'K050'&val_uzsk
                      ELSE
                         ASTE= 'K000'&val_uzsk
                      .



                      DO ADDTABLE
                      !Elya 21.05.2013 end
                      
                   .
                .
             .
          .

!-----------------------------------------------------------------------------------------------
PERFORM4PVN  ROUTINE
   ASTE='D'&FORMAT(PVN_PROC,@N2)&PVN_TIPS&val_uzsk
   BKK = '57211'
   DO ADDTABLE
   ASTE='K'&FORMAT(PVN_PROC,@N2)&PVN_TIPS&val_uzsk
   BKK = '57211'
   DO ADDTABLE
   ASTE='D'&FORMAT(PVN_PROC,@N2)&'0'&val_uzsk
   BKK = '23991'
   DO ADDTABLE
   ASTE='K'&FORMAT(PVN_PROC,@N2)&'0'&val_uzsk
   BKK = '23991'
   DO ADDTABLE
   !stop('PERFORM4PVN')

!-----------------------------------------------------------------------------------------------
PERFORM2PVN  ROUTINE
   SUMMALsDo = SUMMALs !Elya 18/09/2013
   SUMMAVDo = SUMMAV !Elya 18/09/2013
   PVN_PROC = ASTE[2:3]
   ASTE='D'&FORMAT(PVN_PROC,@N2)&'0'&PAV:VAL
   DO ADDTABLE
   SUMMALs = SUMMALsDo !Elya 18/09/2013
   SUMMAV = SUMMAVDo !Elya 18/09/2013
   ASTE='K'&FORMAT(PVN_PROC,@N2)&'0'&PAV:VAL
   DO ADDTABLE
   !stop('PERFORM2PVN')

!-----------------------------------------------------------------------------------------------
ADDTABLE           ROUTINE
 !stop('ADDTABLE'&SUMMALs)
 !stop('SIGN'&SIGN#)
 IF SUMMALs
   IF OPC=1                   !NOLIKTAVAS
      IF (BKK[1:3]='531' OR BKK[1:3]='231') AND PAV:SUMMA < 0
         REFERENCE=PAV:PIELIK
      ELSE
         REFERENCE=''
      .
      D_K      = ASTE[1]
      PVN_PROC = ASTE[2:3]
      PVN_TIPS = ASTE[4]
      VALUTA   = ASTE[5:7]
      IF SUMMALs<0
         IF D_K='D' THEN D_K='K' ELSE D_K='D'.
         SUMMALs=-SUMMALs
         SUMMAV=-SUMMAV
         PVN_TIPS = 'A'
      .
   .
   GET(GGK_TABLE,0)
   LOOP G# = 1 TO RECORDS(GGK_TABLE)
      GET(GGK_TABLE,G#)
      IF BKK=GGT:BKK AND D_K=GGT:D_K AND PVN_PROC=GGT:PVN_PROC AND VALUTA=GGT:VAL AND |
         PVN_TIPS=GGT:PVN_TIPS AND PAR_NR=GGT:PAR_NR AND GGT:NODALA=NODALA AND GGT:OBJ_NR=OBJ_NR
         GGT:SUMMA +=SUMMALs*SIGN#
         GGT:SUMMAV+=SUMMAV*SIGN#
         !stop(GGT:BKK)
         PUT(ggK_TABLE)
         IF ERROR() THEN STOP('PUT GGK_TABLE '&ERROR()).
         EXIT
      .
   .
   GGT:SUMMA    = SUMMALs*SIGN#
   GGT:SUMMAV   = SUMMAV*SIGN#
   GGT:BKK      = BKK
   !stop(GGT:BKK)
   GGT:NODALA   = NODALA
   GGT:OBJ_NR   = OBJ_NR
   GGT:PAR_NR   = PAR_NR
   GGT:REFERENCE= REFERENCE
   GGT:D_K      = D_K
   GGT:PVN_PROC = PVN_PROC
   GGT:PVN_TIPS = PVN_TIPS
   GGT:VAL      = VALUTA
   GGT:KK       = KK
   ADD(GGK_TABLE)
   IF ERROR() THEN STOP('ADD GGK_TABLE '&ERROR()).
 .

