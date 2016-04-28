                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTsf PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
window               WINDOW('Self-testam'),AT(,,200,108),GRAY
                       BUTTON('IgnorÁt da˛‚dus partnerus'),AT(12,15,163,14),USE(?IDP),HIDE
                       IMAGE('CHECK3.ICO'),AT(179,15,13,13),USE(?Image:IDP),HIDE
                       BUTTON('P‚rbaudÓt Kontu pl‚nu'),AT(12,32,164,14),USE(?ATL),HIDE
                       IMAGE('CHECK3.ICO'),AT(179,32,13,13),USE(?Image:ATL),HIDE
                       BUTTON('SameklÁt tukus dokumentus'),AT(12,48,164,14),USE(?KRI),HIDE
                       IMAGE('CHECK3.ICO'),AT(179,48,13,13),USE(?Image:KRI),HIDE
                       BUTTON('P‚rbaudÓt AutoServisu'),AT(12,64,164,14),USE(?PAK),HIDE
                       IMAGE('CHECK3.ICO'),AT(179,64,13,13),USE(?Image:PAK),HIDE
                       BUTTON('Olgai'),AT(16,84,45,14),USE(?DTK),HIDE
                       IMAGE('CHECK3.ICO'),AT(64,84,13,13),USE(?Image:DTK),HIDE
                       BUTTON('OK'),AT(118,88,35,14),USE(?OkButton),DEFAULT
                       BUTTON('Atlikt'),AT(157,88,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   F:IDP=''
   F:ATL=''
   F:KRI=''
   F:PAK=''
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 4
     IF INSTRING(OPCIJA[I#],'12')
        EXECUTE I#
           BEGIN
              UNHIDE(?IDP)                ! 1-B¬ZE IGNOR«T DAﬁ¬DUS PARTNERUS
              IF INRANGE(JOB_NR,16,40)    ! NOLIKTAVA
                 ?IDP{PROP:TEXT}='P‚rbaudÓt PIC'
              ELSE                        ! B¬ZE
                 F:IDP='1'
                 UNHIDE(?IMAGE:IDP)
              .
           .
           BEGIN                        
              UNHIDE(?ATL)                ! 2-B¬ZE p‚rbaudÓt kontu pl‚nu
              IF F:ATL
                 UNHIDE(?IMAGE:ATL)
              .
              IF INRANGE(JOB_NR,16,40)    ! NOLIKTAVA
                 ?ATL{PROP:TEXT}='P‚rbaudÓt Atlikumus'
              ELSIF INRANGE(JOB_NR,66,80) ! ALGA
                 ?ATL{PROP:TEXT}='P‚rbaudÓt Atv.&Slilapas'
              .
           .
           BEGIN                        
              UNHIDE(?KRI)                ! 3-B¬ZE,NOLIKTAVA meklÁt tukus dokumentus
           .
           BEGIN
              UNHIDE(?PAK)                ! 4-NOLIKTAVA p‚rbaudÓt servisu
              IF INRANGE(JOB_NR,16,40)    ! NOLIKTAVA
              .
           .
        .
     .
  .
  IF CL_NR=1464 OR CL_NR=1102  !Œle&ADRem
              IF INRANGE(JOB_NR,16,40)    ! NOLIKTAVA
                 UNHIDE(?DTK)
                 F:DTK=''
              .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?IDP)
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
    OF ?IDP
      CASE EVENT()
      OF EVENT:Accepted
        IF F:IDP
           F:IDP=''
           HIDE(?IMAGE:IDP)
        ELSE
           F:IDP='1'
           UNHIDE(?IMAGE:IDP)
         .
        display
        DO SyncWindow
      END
    OF ?ATL
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:ATL
           F:ATL=''
           HIDE(?IMAGE:ATL)
        ELSE
           F:ATL='1'
           UNHIDE(?IMAGE:ATL)
        .
        display
      END
    OF ?KRI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:KRI
           F:KRI=''
           HIDE(?IMAGE:KRI)
        ELSE
           F:KRI='1'
           UNHIDE(?IMAGE:KRI)
        .
        display
      END
    OF ?PAK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:PAK
           F:PAK=''
           HIDE(?IMAGE:PAK)
        ELSE
           F:PAK='1'
           UNHIDE(?IMAGE:PAK)
        .
        display
      END
    OF ?DTK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK=''
           HIDE(?IMAGE:DTK)
        ELSE
           F:DTK='1'
           UNHIDE(?IMAGE:DTK)
        .
        display
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
  INIRestoreWindow('IZZFILTsf','winlats.INI')
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
    INISaveWindow('IZZFILTsf','winlats.INI')
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
BuildKorMas          PROCEDURE (SECIBA,OPC,VALUTA,REQNODALAS,EQUPVN_PROC) ! Declare Procedure
GGK_U_nr     ULONG
GGK_BKK      STRING(5)
GGK_D_K      STRING(1)
GGK_VAL      STRING(3)
GGK_SUMMA    DECIMAL(12,2)
GGK_SUMMAV   DECIMAL(12,2)
GGK_KK       BYTE
C_SUMMA      DECIMAL(12,2)
C_SUMMAV     DECIMAL(12,2)
POS          STRING(260)
SAV_POS      STRING(255)
GGK_NODALA   LIKE(GGK:NODALA)
GGK_PVN_PROC STRING(2)

G_TABLE QUEUE,PRE(G)
KEY         STRING(10)
BKK         STRING(5)
NODALA      STRING(2)
SUMMA       DECIMAL(12,2)
SUMMAV      DECIMAL(12,2)
PVN_PROC    STRING(2)
VAL         STRING(3)
U_NR        ULONG
        .
  CODE                                            ! Begin processed code
   !
   !                  BUILDKORMAS
   !
   !
   !   SECIBA: GGK TEKO–¬ LASŒ–NAS SECŒBA  0-NAV
   !                                       1-PAR_KEY
   !                                       2-BKK_DAT
   !                                       3-NR_KEY
   !                                       4-DAT_KEY
   !
   !   OPC:         0-MEKL« KORESPOND«JO–OS KONTUS
   !                1-MEKL« T¬ PA–A KONT«JUMA KONTUS
   !
   !   VALUTA:      0-MEKL« KONTUS Ls
   !   VALUTA:      1-MEKL« KONTUS VAL
   !
   !   REQNODALAS:  1-SADALŒT PA NODAœ¬M
   !
   !   EQUPVN_PROC: 1-IR PIEPRASŒTS 57210 AR T¬DU PA–U PVN%
   !
       CLEAR(kor_KONTS)
       CLEAR(kor_SUMMA)
       CLEAR(kor_VAL)
       CLEAR(kor_NODALA)
       F:X=0
       EXECUTE SECIBA
         pos=position(ggk:PAR_KEY)
         pos=position(ggk:bkk_dat)
         pos=position(ggk:NR_KEY)
         pos=position(ggk:DAT_KEY)
       .
       SAV_POS=position(ggk) !fixÁjam pai sevi
       GGK_U_nr=ggk:U_nr
       GGK_BKK=GGK:BKK
       EXECUTE OPC+1
          GGK_D_K=INVDK(ggk:d_k)
          GGK_D_K=ggk:d_k
       .
       GGK_SUMMAV=GGK:SUMMAV
       GGK_SUMMA=GGK:SUMMA
       GGK_VAL=GGK:VAL
       GGK_KK=GGK:KK
       GGK_PVN_PROC=GGK:PVN_PROC
       C_SUMMA=0
       IF GGK:BKK='26100' AND GGK:D_K='D' THEN F:X=1.  !VAR B€T KASES AP
       clear(ggk:record)
       ggk:U_nr=GGK_U_NR
       set(ggk:nr_key,ggk:nr_key)
       loop
          next(ggk)
          IF ERROR() THEN BREAK.
          IF ~(ggk:U_nr=GGK_U_NR) then break.
          IF GGK:BKK='26500' AND GGK:D_K='D' THEN F:X+=1. !KASES AP-KREDŒTKARTE
          IF GGK_KK                            !IR DEFIN«TA KONTU KORESPODENCE
             IF ~BAND(GGK_KK,GGK:KK) THEN CYCLE.
          .
          IF EQUPVN_PROC AND GGK:BKK[1:4]='5721'  !IR PIEPRASŒTS 57210 AR T¬DU PA–U PVN%
             IF ~(GGK_PVN_PROC=GGK:PVN_PROC) THEN CYCLE. !NEATRISIN¬S,KAM«R NEB€S GGKPVN%(S2)....
          .
          IF ~(ggk:d_k=GGK_D_K) THEN CYCLE.
          IF SAV_POS=POSITION(GGK) THEN CYCLE. !LAI NEPA“EMTU PATS SEVI
          IF REQNODALAS
             GGK_NODALA=GGK:NODALA
          ELSE
             GGK_NODALA=''
          .
          IF BAND(ggk:BAITS,00000010b) !NEAPLIEKAMS
             GGK_PVN_PROC=''
          ELSE
             GGK_PVN_PROC=GGK:PVN_PROC
          .
          IF GGK:BKK[1:4]='2380' AND GGK:D_K='K' !AVANSIERIS(INKASENTS) VAJADZŒGS KASES IE“. ORDERIM
             PERIODS=GGK:PAR_NR                  !NODODAM CAUR PERIODS
          .
          G:KEY=GGK:BKK&GGK:VAL&GGK_PVN_PROC&GGK_NODALA
          GET(G_TABLE,G:KEY)
          IF ERROR()
             G:BKK=GGK:BKK
             G:SUMMA=GGK:SUMMA
             G:SUMMAV=GGK:SUMMAV
             G:VAL=GGK:VAL
             G:U_NR=GGK:U_NR
             G:PVN_PROC=GGK_PVN_PROC
             G:NODALA=GGK_NODALA
             ADD(G_TABLE)
             SORT(G_TABLE,G:KEY)
          ELSE
             G:SUMMA+=GGK:SUMMA
             G:SUMMAV+=GGK:SUMMAV
             PUT(G_TABLE)
          .
       .
       IF RECORDS(G_TABLE)=0
          KLUDA(0,'Nav atrasts neviens kor_konts : '&ggk_u_nr)
          DO PROCEDURERETURN
       .
!*************** P‚rbaudam , vai ir tiei t‚da summa Ls ***********

       SORT(g_table,g:summa)
       G:SUMMA=GGK_SUMMA
       GET(G_TABLE,G:SUMMA)
       IF ~ERROR()
          KOR_KONTS[1]   =G:BKK
          KOR_PVN_PROC[1]=G:PVN_PROC
          KOR_NODALA[1]  =G:NODALA
          IF VALUTA
             KOR_SUMMA[1]=G:SUMMAV
             KOR_VAL[1]  =G:VAL
          ELSE
             KOR_SUMMA[1]=G:SUMMA
             KOR_VAL[1]  ='Ls'
          .
          DO PROCEDURERETURN
       .
!**********************GRIEﬁAM CAURI TABULU*********************

       SORT(g_table,g:BKK)
       LOOP I#= 1 TO RECORDS(G_TABLE)
          IF I#>20
             KLUDA(66,'U_NR='&G:U_NR)
             DO PROCEDURERETURN
          .
          GET(G_TABLE,I#)
!          STOP(C_SUMMA&'+'&g:SUMMA&'='&GGK_SUMMA&'-'&I#&'-'&RECORDS(G_TABLE))
          IF C_SUMMA+g:SUMMA<GGK_SUMMA AND ~(I#=RECORDS(G_TABLE))
             KOR_KONTS[I#]   =g:bkk
             KOR_PVN_PROC[I#]=G:PVN_PROC
             KOR_NODALA[I#]  =G:NODALA
             IF VALUTA
                KOR_SUMMA[I#]=G:SUMMAV
                KOR_VAL[I#]  =G:VAL
             ELSE
                KOR_SUMMA[I#]=G:SUMMA
                KOR_VAL[I#]  ='Ls'
             .
          ELSIF C_SUMMA+g:SUMMA<GGK_SUMMA AND I#=RECORDS(G_TABLE) !nolÓdzinam uz pÁdÁjo
             KOR_KONTS[I#]   =g:bkk
             KOR_PVN_PROC[I#]=G:PVN_PROC
             KOR_NODALA[I#]  =G:NODALA
!             IF ~INRANGE(C_SUMMA,-0.03,0.03)
!                KLUDA(0,'KontÁjumam '&FORMAT(GG:DATUMS,@D6.)&' U_Nr='&GG:U_NR&' nepiecieams nor‚dÓt KK')
!             ELSE
                IF VALUTA
                   KOR_SUMMA[I#]=GGK_SUMMAV-C_SUMMAV
                   KOR_VAL[I#]  =G:VAL
                ELSE
                   KOR_SUMMA[I#]=GGK_SUMMA-C_SUMMA
                   KOR_VAL[I#]  ='Ls'
                .
!             .
             DO PROCEDURERETURN
          ELSIF C_SUMMA+g:SUMMA=GGK_SUMMA
             KOR_KONTS[I#]   =g:bkk
             KOR_PVN_PROC[I#]=G:PVN_PROC
             KOR_NODALA[I#]  =G:NODALA
             IF VALUTA
                KOR_SUMMA[I#]=G:SUMMAV
                KOR_VAL[I#]  =G:VAL
             ELSE
                KOR_SUMMA[I#]=G:SUMMA
                KOR_VAL[I#]  ='Ls'
             .
             DO PROCEDURERETURN
          ELSIF C_SUMMA+g:SUMMA>GGK_SUMMA AND I#=RECORDS(G_TABLE)
             KOR_KONTS[I#]   =g:bkk
             KOR_PVN_PROC[I#]=G:PVN_PROC
             KOR_NODALA[I#]  =G:NODALA
             IF VALUTA AND G:VAL=GGK_VAL
                KOR_SUMMA[I#]=GGK_SUMMAV-C_SUMMAV
                KOR_VAL[I#]  =G:VAL
             ELSE
                KOR_SUMMA[I#]=GGK_SUMMA-C_SUMMA
                KOR_VAL[I#]  ='Ls'
             .
             DO PROCEDURERETURN
          ELSE
             KOR_KONTS[I#]   =g:bkk
             KOR_PVN_PROC[I#]=G:PVN_PROC
             KOR_NODALA[I#]  =G:NODALA
             IF VALUTA
                KOR_SUMMA[I#]=G:SUMMAV
                KOR_VAL[I#]  =G:VAL
             ELSE
                KOR_SUMMA[I#]=G:SUMMA
                KOR_VAL[I#]  ='Ls'
             .
          .
          C_SUMMA+=G:SUMMA
          C_SUMMAV+=G:SUMMAV
       .
       STOP('NEGAIDŒTA Kœ€DA')
       DO PROCEDURERETURN

!******************************************************
PROCEDURERETURN ROUTINE
       FREE(G_TABLE)
       IF SECIBA
          EXECUTE SECIBA
             reset(ggk:PAR_KEY,pos)
             reset(ggk:bkk_dat,pos)
             reset(ggk:NR_KEY,pos)
             reset(ggk:DAT_KEY,pos)
          .
          NEXT(GGK)
       .
       RETURN
CALCKK               FUNCTION (GGK_KK)            ! Declare Procedure
KK_STRING   STRING(8)
  CODE                                            ! Begin processed code
 KK_STRING='........'
 IF BAND(ggK:KK,00000001b) THEN KK_STRING[8]='*'.
 IF BAND(ggK:KK,00000010b) THEN KK_STRING[7]='*'.
 IF BAND(ggK:KK,00000100b) THEN KK_STRING[6]='*'.
 IF BAND(ggK:KK,00001000b) THEN KK_STRING[5]='*'.
 IF BAND(ggK:KK,00010000b) THEN KK_STRING[4]='*'.
 IF BAND(ggK:KK,00100000b) THEN KK_STRING[3]='*'.
 IF BAND(ggK:KK,01000000b) THEN KK_STRING[2]='*'.
 IF BAND(ggK:KK,10000000b) THEN KK_STRING[1]='*'.
 RETURN(KK_STRING)
