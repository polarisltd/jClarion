                     MEMBER('winlats.clw')        ! This is a MEMBER module
CALCSUM              FUNCTION (OPC,RET)           ! Declare Procedure
AP           DECIMAL(4,1)
PVN          DECIMAL(2)
ATLAIDEL     REAL
ATLAIDEV     REAL
SUMMAL       REAL
SUMMAV       REAL
RET_S        REAL
SBEZAV       DECIMAL(13,2)
SBEZAL       DECIMAL(13,2)
  CODE                                            ! Begin processed code
!*************************************************************
!
! SARÇÍINA NOLIKTAVAS IERAKSTA SUMMU
!
! ******** JÂBÛT POZICIONÇTAM NOLIK FAILAM
!
! 1 - ATGRIEÞ SUMMU BEZ PVN Ls -A+T
! 2 - ATGRIEÞ SUMMU AR PVN Ls -A+T
! 3 - ATGRIEÞ SUMMU BEZ PVN VALÛTÂ - ATLAIDE
! 4 - ATGRIEÞ SUMMU AR PVN VALÛTÂ - ATLAIDE
!----------------------------------
! 5 - ATGRIEÞ PVN Ls
! 6 - ATGRIEÞ PVN VALÛTÂ
! 7 - ATGRIEÞ ATLAIDI Ls (AR PVN)
! 8 - ATGRIEÞ ATLAIDI VALÛTÂ (AR PVN)
! 9 - ATGRIEÞ SUMMU BEZ PVN Ls
!10 - ATGRIEÞ SUMMU AR PVN Ls
!11 - ATGRIEÞ SUMMU BEZ PVN VALÛTÂ
!12 - ATGRIEÞ SUMMU AR PVN VALÛTÂ
!----------------------------------
!13 - ATGRIEÞ PVN Ls - ATLAIDE +T+C
!14 - ATGRIEÞ PVN VALÛTÂ - ATLAIDE
!15 - ATGRIEÞ SUMMU BEZ PVN Ls -A
!16 - ATGRIEÞ SUMMU AR PVN Ls -A
!17 - ATGRIEÞ PVN Ls - ATLAIDE
!18 - ATGRIEÞ PARÂDU Ls -A
!19 - ATGRIEÞ PARÂDU VALÛTÂ -A
!
!
!*************************************************************

 SUMMAL= NOL:SUMMA
 SUMMAV= NOL:SUMMAV
 PVN   = NOL:PVN_PROC
 AP    = NOL:ATLAIDE_PR

 IF NOL:U_NR=1     !SALDO
    NOL:ARBYTE=0   !Lietotâja kïûda
 .
 IF NOL:VAL='' THEN NOL:VAL='Ls'.



 CASE NOL:ARBYTE
 OF 0             ! BEZ PVN
    ATLAIDEL =SUMMAL*(AP/100)  ! VÇL BÛS KRIETNI JÂDOMÂ...
    ATLAIDEV =SUMMAV*(AP/100)  !
    EXECUTE OPC
      RET_S=SUMMAL-ATLAIDEL+NOL:T_SUMMA/(1+PVN/100)   ! 1 ATGRIEÞ SUMMU BEZ PVN Ls -A+T
      RET_S=(SUMMAL-ATLAIDEL)*(1+PVN/100)+NOL:T_SUMMA ! 2 ATGRIEÞ SUMMU AR PVN Ls -A+T
      RET_S=SUMMAV-ATLAIDEV                           ! 3 ATGRIEÞ SUMMU BEZ PVN VALÛTÂ - ATLAIDE
      RET_S=(SUMMAV-ATLAIDEV)*(1+PVN/100)             ! 4 ATGRIEÞ SUMMU AR PVN VALÛTÂ - ATLAIDE
      RET_S=SUMMAL*PVN/100                            ! 5 ATGRIEÞ PVN Ls
      RET_S=SUMMAV*PVN/100                            ! 6 ATGRIEÞ PVN VALÛTÂ
      RET_S=SUMMAL*(1+PVN/100)*AP/100                 ! 7 ATGRIEÞ ATLAIDI Ls (AR PVN)
      RET_S=SUMMAV*(1+PVN/100)*AP/100                 ! 8 ATGRIEÞ ATLAIDI VALÛTÂ (AR PVN)
      RET_S=SUMMAL                                    ! 9 ATGRIEÞ SUMMU BEZ PVN Ls
      RET_S=SUMMAL*(1+PVN/100)                        !10 ATGRIEÞ SUMMU AR PVN Ls
      RET_S=SUMMAV                                    !11 ATGRIEÞ SUMMU BEZ PVN VALÛTÂ
      RET_S=SUMMAV*(1+PVN/100)                        !12 ATGRIEÞ SUMMU AR PVN VALÛTÂ
      RET_S=(SUMMAL-ATLAIDEL)*PVN/100                 !13 ATGRIEÞ PVN Ls - ATLAIDE
      RET_S=(SUMMAV-ATLAIDEV)*PVN/100                 !14 ATGRIEÞ PVN VALÛTÂ - ATLAIDE
      RET_S=SUMMAL-ATLAIDEL                           !15 ATGRIEÞ SUMMU BEZ PVN Ls -A
      RET_S=(SUMMAL-ATLAIDEL)*(1+PVN/100)             !16 ATGRIEÞ SUMMU AR PVN Ls -A
      RET_S=(SUMMAL-ATLAIDEL)*PVN/100                 !17 ATGRIEÞ PVN Ls - ATLAIDE
      BEGIN
        IF BAND(NOL:BAITS,00000001b)                  !18 ATGRIEÞ PARÂDU Ls AR PVN -A
          RET_S=(SUMMAL-ATLAIDEL)*(1+PVN/100)
        ELSE
          RET_S=0
        .
      .
      BEGIN
        IF BAND(NOL:BAITS,00000001b)                  !19 ATGRIEÞ PARÂDU VALÛTÂ AR PVN -A
          RET_S=(SUMMAV-ATLAIDEV)*(1+PVN/100)
        ELSE
          RET_S=0
        .
      .
    .
 ELSE     ! SUMMA AR PVN

    SBEZAL =SUMMAL*(1-AP/100)           ! UZ ÈEKA IR NOAPAÏOTA SUMMA AR PVN
    SBEZAV =SUMMAV*(1-AP/100)
    ATLAIDEL = SUMMAL-SBEZAL
    ATLAIDEV = SUMMAV-SBEZAV
    EXECUTE OPC
      RET_S=(SBEZAL+NOL:T_SUMMA)/(1+PVN/100)          ! 1 SUMMU BEZ PVN Ls-ATLAIDE+T
      RET_S=SBEZAL+NOL:T_SUMMA                        ! 2 SUMMU AR PVN Ls-ATLAIDE+T
      RET_S=(SBEZAV)/(1+PVN/100)                      ! 3 SUMMU BEZ PVN VALÛTÂ - ATLAIDE
      RET_S=SBEZAV                                    ! 4 SUMMU AR PVN VALÛTÂ-ATLAIDE
      RET_S=SUMMAL*(1-1/(1+PVN/100))                  ! 5 PVN Ls
      RET_S=SUMMAV*(1-1/(1+PVN/100))                  ! 6 PVN VALÛTÂ
      RET_S=ATLAIDEL                                  ! 7 ATLAIDI Ls (AR PVN)
      RET_S=ATLAIDEV                                  ! 8 ATLAIDI VALÛTÂ (AR PVN)
      RET_S=SUMMAL/(1+PVN/100)                        ! 9 SUMMU BEZ PVN Ls
      RET_S=SUMMAL                                    !10 SUMMU AR PVN Ls
      RET_S=SUMMAV/(1+PVN/100)                        !11 SUMMU BEZ PVN VALÛTÂ
      RET_S=SUMMAV                                    !12 SUMMU AR PVN VALÛTÂ
      RET_S=SBEZAL*(1-1/(1+PVN/100))                  !13 PVN Ls - ATLAIDE
      RET_S=SBEZAV*(1-1/(1+PVN/100))                  !14 PNV VALÛTÂ- ATLAIDE
      RET_S=SBEZAL/(1+PVN/100)                        !15 SUMMU BEZ PVN Ls -ATLAIDE
      RET_S=SBEZAL                                    !16 SUMMU AR PVN Ls -A
      RET_S=SBEZAL*(1-1/(1+PVN/100))                  !17 PVN Ls - ATLAIDE
      BEGIN
        IF BAND(NOL:BAITS,00000001b)                  !18 ATGRIEÞ PARÂDU Ls AR PVN -A
           RET_S=SBEZAL
        ELSE
           RET_S=0
        .
      .
      BEGIN
        IF BAND(NOL:BAITS,00000001b)                  !19 ATGRIEÞ PARÂDU VALÛTÂ AR PVN -A
           RET_S=SBEZAV
        ELSE
           RET_S=0
        .
      .
    .
 .
 EXECUTE RET
    RETURN(RET_S)               ! REAL
    RETURN(ROUND(RET_S,.01))    ! 2 DEC
    RETURN(ROUND(RET_S,.001))   ! 3 DEC
    RETURN(ROUND(RET_S,.0001))  ! 4 DEC
    RETURN(ROUND(RET_S,.00001)) ! 5 DEC
 .
GETNOM_K             FUNCTION (NOM,REQUESTED,RET,<REQ_C>) ! Declare Procedure
BKK         STRING(5)
KLSTRING    STRING(13)
CENA        DECIMAL(11,4)
ATLIKUMS    DECIMAL(9,3)
ARBYTE      STRING(10)
REQ_NOKL_CA LIKE(NOKL_CA)
REQ_NOKL_CP LIKE(NOKL_CP)

  CODE                                            ! Begin processed code
 !  NOM - PIEPRASÎTÂ NOMENKLATÛRA
 !  REQUESTED- 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD,JA NAV
 !           - 1 IZSAUC BROWSE
 !           - 2 IZSAUC KÏÛDU
 !  RET - 1 ATGRIEÞ NOMENKLATÛRU
 !        2 ATGRIEÞ NOM:NOSAUKUMS
 !        3 ATGRIEÞ NOM:NOS_S
 !        4 ATGRIEÞ NOM:KODS
 !        5 ATGRIEÞ NOM:KATALOGA_NR
 !        6 ATGRIEÞ BKK NO NOM_K VAI SYSTEM
 !        7 ATGRIEÞ CENU
 !        8 ATGRIEÞ NOM:KODS,------SAÒEM KODU
 !        9 ATGRIEÞ CENU,----------SAÒEM KODU
 !       10 ATGRIEÞ 'ar PVN' vai ''
 !       11 ATGRIEÞ NOM:NOMENKLAT,------SAÒEM KODU
 !       12 ATGRIEÞ NOM:NOMENKLAT,------IZSAUC BROWSENOM_ATLIKUMI
 !       13 ATGRIEÞ NOM:VAL
 !       14 ATGRIEÞ NOM:KATALOGA_NR
 !       15 ATGRIEÞ CENU BEZ PVN
 !       16 ATGRIEÞ NOM:TIPS
 !       17 ATGRIEÞ NOM:MUITA
 !       18 ATGRIEÞ NOM:AKCIZE
 !       19 ATGRIEÞ NOM:SERTIF (CITS TEKSTS)
 !       20 ATGRIEÞ NOM:MERVIEN
 !       21 ATGRIEÞ NOM:MUITAS_KODS
 !       22 ATGRIEÞ NOM:SVARS*F(BAITS1 4,5BITI)
 !       23 ATGRIEÞ NOM:SVARS_BR*F(BAITS1 4,5BITI)  !NOÒEMTS 18/06/2004
 !       24 ATGRIEÞ NOM:KOEF_ESKNPM VAI 1
 !       25 ATGRIEÞ NOM:RINDA2PZ
 !       26 ATGRIEÞ NOM:DG (VW_DG)
 !       27 ATGRIEÞ NOM:MINRC
 !       28 ATGRIEÞ NOM:KODS_PLUS   !13/11/2015
 !

 !13/11/2015 IF ~INRANGE(RET,1,27)
 IF ~INRANGE(RET,1,28)  !13/11/2015
     STOP('IZSAUCOT GETNOM_K, PIEPRASÎTS ATGRIEZT:'&RET)
    RETURN('')
 .
 IF REQ_C
    REQ_NOKL_CA=REQ_C
    REQ_NOKL_CP=REQ_C
 ELSE
    REQ_NOKL_CA=NOKL_CA
    REQ_NOKL_CP=NOKL_CP
 .
 IF ~INRANGE(REQ_NOKL_CP,1,6) THEN REQ_NOKL_CP=1.
 IF ~INRANGE(REQ_NOKL_CA,1,6) THEN REQ_NOKL_CA=1.
 IF ~NOM AND REQUESTED
    KLUDA(0,'Nav norâdîta Nomenklatûra (kods)')
!    CLEAR(NOM:RECORD)
    RETURN('')
 ELSIF (NOM OR REQUESTED) AND ~(NOM='POZICIONÇTS') !AND ~(NOM=NOM:NOMENKLAT) - ÐITÂ NEDRÎKST,JA VAJAG POZICIONÇT..
    IF NOM_K::USED=0
       CheckOpen(NOM_K,1)
    .
    NOM_K::Used += 1
    CLEAR(NOM:RECORD)
    IF RET = 8 OR RET = 9 OR RET = 11
       KLSTRING='Kods '
       NOM:KODS=NOM
       GET(NOM_K,NOM:KOD_KEY)
    ELSE
       KLSTRING='Nomenklatûra '
       NOM:NOMENKLAT=NOM
       GET(NOM_K,NOM:NOM_KEY)
    .
    IF ERROR()
       IF REQUESTED = 2
          IF KLSTRING='Kods '
             KLUDA(17,klstring&NOM)
          ELSE
             KLUDA(16,klstring&NOM)
          .
          CLEAR(NOM:RECORD)
       ELSIF REQUESTED = 1
          globalrequest=Selectrecord
          BROWSENOM_K
          IF GLOBALRESPONSE=REQUESTCANCELLED
             CLEAR(NOM:RECORD)
          .
       ELSE
          CLEAR(NOM:RECORD)
       .
    .
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
 ELSIF ~NOM                                       !NAV DEFINÇTA NOMENKLATÛRA
    RETURN('')
 .

 IF ~NOM:BKK
   IF NOM:TIPS='P' OR NOM:TIPS=''
     BKK=SYS:D_PR
   ELSE
     BKK=SYS:D_TA
   .
 ELSE
   BKK=NOM:BKK
 .
 IF RET=7 OR RET=9 OR RET=15
    IF NOM:TIPS='A' 
       EXECUTE REQ_NOKL_CA
         CENA = NOM:REALIZ[1]
         CENA = NOM:REALIZ[2]
         CENA = NOM:REALIZ[3]
         CENA = NOM:REALIZ[4]
         CENA = NOM:REALIZ[5]
         CENA = NOM:PIC
       .
    ELSE
       EXECUTE REQ_NOKL_CP
         CENA = NOM:REALIZ[1]
         CENA = NOM:REALIZ[2]
         CENA = NOM:REALIZ[3]
         CENA = NOM:REALIZ[4]
         CENA = NOM:REALIZ[5]
         CENA = NOM:PIC
       .
    .
 .
 IF RET=10 OR RET=15
     EXECUTE REQ_NOKL_CP
      IF BAND(NOM:ARPVNBYTE,00000001b) THEN ARBYTE='ar  PVN'.
      IF BAND(NOM:ARPVNBYTE,00000010b) THEN ARBYTE='ar  PVN'.
      IF BAND(NOM:ARPVNBYTE,00000100b) THEN ARBYTE='ar  PVN'.
      IF BAND(NOM:ARPVNBYTE,00001000b) THEN ARBYTE='ar  PVN'.
      IF BAND(NOM:ARPVNBYTE,00010000b) THEN ARBYTE='ar  PVN'.
      ARBYTE=''
    .
 .
 IF RET = 13
    EXECUTE REQ_NOKL_CP
      VAL_NOS = NOM:VAL[1]
      VAL_NOS = NOM:VAL[2]
      VAL_NOS = NOM:VAL[3]
      VAL_NOS = NOM:VAL[4]
      VAL_NOS = NOM:VAL[5]
      !Elya 22/12/2013 VAL_NOS = 'Ls'
      VAL_NOS = val_uzsk
    .
    !Elya 22/12/2013 IF ~VAL_NOS THEN VAL_NOS='Ls'.
    IF ~VAL_NOS THEN VAL_NOS=val_uzsk.
 .
 EXECUTE RET
    RETURN(NOM:nomenklat)       !1
    RETURN(NOM:NOS_P)           !2
    RETURN(NOM:nos_s)           !3
    RETURN(nom:kods)            !4
    RETURN(NOM:KATALOGA_NR)     !5
    RETURN(BKK)                 !6
    RETURN(CENA)                !7
    RETURN(nom:kods)            !8
    RETURN(CENA)                !9
    RETURN(ARBYTE)              !10
    RETURN(NOM:nomenklat)       !11
    RETURN(NOM:nomenklat)       !12
    RETURN(VAL_NOS)             !13
    RETURN(NOM:KATALOGA_NR)     !14
    BEGIN                       !15
       IF ARBYTE
          CENA=CENA/(1+NOM:PVN_PROC/100)
       .
       RETURN(CENA)
    .
    RETURN(NOM:TIPS)            !16
    RETURN(NOM:MUITA)           !17
    RETURN(NOM:AKCIZE)          !18
    RETURN(NOM:CITS_TEKSTSPZ)   !19
    RETURN(NOM:MERVIEN)         !20
    RETURN(LEFT(FORMAT(NOM:MUITAS_KODS,@N_10B))) !21
    RETURN(NOM:SVARSKG)         !22
    RETURN(NOM:SVARSKG)         !23
    BEGIN
      IF NOM:KOEF_ESKNPM
        RETURN(NOM:KOEF_ESKNPM) !24
      ELSE
        RETURN(1)
      .
    .
    RETURN(NOM:RINDA2PZ)        !25
    RETURN(NOM:DG)              !26
    RETURN(NOM:MINRC)           !27
    RETURN(NOM:KODS_PLUS)       !28
 .

CYCLENOM             FUNCTION (nol_nomenklat)     ! Declare Procedure
NULSTOP  BYTE
  CODE                                            ! Begin processed code
 IF NOL_NOMENKLAT
    NULSTOP=0
    loop F#=1 to len(clip(nomenklat))
       IF NOMENKLAT[F#]=' ' AND ~NULSTOP THEN NULSTOP=F#.    ! MAZÂKAIS "VISI"
       IF ~(NOL_NOMENKLAT[F#]=NOMENKLAT[F#] OR NOMENKLAT[F#]=' ')
          IF ~NULSTOP
             IF NOL_NOMENKLAT[1:F#] > NOMENKLAT[1:F#]
                RETURN(2)                                    ! IR JÂPÂRTRAUC MEKLÇT
             .
          ELSIF NULSTOP>1                                    ! PA VIDU IR "VISI"
             IF NOL_NOMENKLAT[1:NULSTOP-1] > NOMENKLAT[1:NULSTOP-1]
                RETURN(2)                                    ! IR JÂPÂRTRAUC MEKLÇT
             .
!          IF (NOMENKLAT[1] AND NOL_NOMENKLAT[1]>NOMENKLAT[1]) OR |
!             (NOL_NOMENKLAT[1]=NOMENKLAT[1] AND |
!             NOMENKLAT[2] AND NOL_NOMENKLAT[2]>NOMENKLAT[2]) OR |
!             (NOL_NOMENKLAT[1]=NOMENKLAT[1] AND |
!              NOL_NOMENKLAT[2]=NOMENKLAT[2] AND |
!             NOMENKLAT[3] AND NOL_NOMENKLAT[3]>NOMENKLAT[3]) OR |
!             (NOL_NOMENKLAT[1]=NOMENKLAT[1] AND |
!              NOL_NOMENKLAT[2]=NOMENKLAT[2] AND |
!              NOL_NOMENKLAT[3]=NOMENKLAT[3] AND |
!             NOMENKLAT[4] AND NOL_NOMENKLAT[4]>NOMENKLAT[4])
!             RETURN(2)                            ! IR JÂPÂRTRAUC MEKLÇT
!          ELSE
          .
          RETURN(1)                            ! IR JÂIZLAIÞ
       .
    .
 .
 RETURN(0)
