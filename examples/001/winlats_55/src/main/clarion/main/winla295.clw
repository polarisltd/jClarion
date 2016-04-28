                     MEMBER('winlats.clw')        ! This is a MEMBER module
CALCSTUNDAS_PEC_GRAF FUNCTION (YYYYMM,KAD_ID,ATV,SLI,RET) ! Declare Procedure
CAL_STUNDAS    STRING(1)
KALSTUNDAS     BYTE
KALDD          BYTE
KALXY          BYTE
KALDDSE        BYTE
KALDDSESV      BYTE
XSTUNDAS       BYTE
KSTUNDAS       BYTE
XDIENAS        BYTE
KDIENAS        BYTE

X_TABLE  QUEUE,PRE(X)
DATUMS  LONG
PAZIME  STRING(1)
         .
  CODE                                            ! Begin processed code
!   ATV  1-NORAUJ NOST ATVA�IN�JUMA GABALU
!   SLI  1-NORAUJ NOST SLIM�BAS GABALU
!        2-NORAUJ NOST TIKAI B_LAPAS GABALU
!
!   RET  1- KALEND�R�S STUNDAS YYYYMM
!        2- ATGRIE� KALEND�RA DARBA DIENAS KALDD
!        3- ATGRIE� KALEND�RA DARBA DIENAS+SESTDIENAS KALDDSE
!        4- ATGRIE� NOSTR�D�T�S STUNDAS (KALEND�R�S STUNDAS-KADRU,SLILAPU,ATV STUNDAS)
!        5- ATGRIE� DDIENAS+SE P�RKL�JUMA APGABAL�[S_DAT:B_DAT]
!        6- ATGRIE� KALEND�R�S DIENAS KALDDSESV -KADRU DIENAS
!        7- ATGRIE� B_LAPAS DIENAS, KUR IR KADRU DIENAS
!        8- ATGRIE� KALEND�R�S DIENAS KALDDSESV
!        9- ATGRIE� KALEND�R�S DIENAS KALDDSESV -KADRU DIENAS -B_LAPAS DIENAS
!       10- ATGRIE� SV�TKU DIENAS (KALEND�R�S SV.D darba dien�s,JA BIJU�AS DARBA ATTIEC�BAS UN NAV SLIMOJIS)
!
!       KAD_ID=0 NEAPGRAIZ�T P�C KADRU S_B
!

 CHECKOPEN(CAL,1)
 S# = DATE(MONTH(YYYYMM),1,YEAR(YYYYMM))
 B# = DATE(MONTH(YYYYMM)+1,1,YEAR(YYYYMM))-1

 IF KAD_ID                       ! VAJAG ANAL�ZI P�C KADRIEM
    IF ~GETKADRI(KAD_ID,2,1) THEN RETURN(0).
    IF ~KAD:D_GR_END THEN KAD:D_GR_END=109211.  ! 31/12/2099
!    CLEAR(RIK:RECORD) TAM 40/50 VIENALGA AR 0 VID�JO J�B�T ATVA�IN�JUMOS.....
!    RIK:ID=KAD_ID
!    LOOP
!       NEXT(KAD_RIK)
!       IF ERROR() OR ~(RIK:ID=KAD_ID) THEN BREAK.
!       IF RIK:Z_KODS=40 OR RIK:Z_KODS=50     !B�RNU,BEZALGAS ATVA�IN�JUMS
!          S4050=RIK:DATUMS
!       ELSIF RIK:Z_KODS=41 OR RIK:Z_KODS=51  !BEIDZAS B�RNU,BEZALGAS ATVA�IN�JUMS
!          B4050=RIK:DATUMS
!       .
!    .
!    IF S4050 AND ~B4050 THEN B4050=109211.  ! 31/12/2099
 .
 IF ATV OR SLI                   ! ANALIZ�T ATVA�IN�JUMUS UN (vai) SLILAPAS
    CHECKOPEN(PERNOS,1)
    CLEAR(PER:RECORD)
    PER:ID=KAD_ID
    SET(PER:ID_KEY,PER:ID_KEY)
    LOOP
       NEXT(PERNOS)
       IF ERROR() OR ~(PER:ID=KAD_ID) THEN BREAK.
       IF (SLI=1 AND PER:PAZIME='S') OR|
          (SLI=2 AND PER:PAZIME='S') OR|
          (ATV=1 AND PER:PAZIME='A')
          LOOP X# = PER:SAK_DAT TO PER:BEI_DAT
             IF SLI=2 AND PER:PAZIME='S' AND (X# < PER:SAK_DAT+per:A_DIENAS) THEN CYCLE. !SKAITAM TIKAI B_DIENAS
             IF INRANGE(X#,S#,B#)
                X:DATUMS=X#
                X:PAZIME=PER:PAZIME
                GET(X_TABLE,X:DATUMS)
                IF ERROR()
                   ADD(X_TABLE)
                   SORT(X_TABLE,X:DATUMS)
                .
             .
          .
       .
    .
 .
 LOOP I#= S# TO B#
!    IF INRANGE(I#,S4050,B4050) THEN CYCLE.
    KALDDSESV+=1
    Cal_stundas=GETCAL(I#)
    IF INSTRING(CAL_STUNDAS,'012345678')
       KALSTUNDAS+=CAL_STUNDAS
       KALDD+=1
       KALDDSE+=1
    .
    IF CAL_STUNDAS='S'
       KALDDSE+=1
    .
    IF KAD_ID
       IF INRANGE(I#,KAD:DARBA_GR,KAD:D_GR_END)  ! VISP�R IR BIJU�AS DARBA ATTIEC�BAS
          IF INSTRING(CAL_STUNDAS,'X')  !SV�TKU DIENAS DARBA DIEN�S,KAD NAV SLIMOJIS
             X:DATUMS=I#
             X:PAZIME=''
             GET(X_TABLE,X:DATUMS)
             IF ~X:PAZIME='S'
                KALXY+=1
             .
          .
          IF ATV OR SLI
             X:DATUMS=I#
             GET(X_TABLE,X:DATUMS)
             IF ~ERROR()                             ! SLIMOJIS VAI BIJIS ATVA�IN�JUM� (4)
                IF INSTRING(CAL_STUNDAS,'012345678') ! VAI SLIMOJIS B_APGABAL� (7)
                   XSTUNDAS+=CAL_STUNDAS             ! VAI SLIMOJIS (10)
                .
                XDIENAS+=1                           ! VISAS DIENAS, KAD SLI VAI ATV
             .
          .
       ELSE                                          ! NAV BIJIS PIE�EMTS VAI IR ATLAISTS
          IF INSTRING(CAL_STUNDAS,'012345678')
              KSTUNDAS+=CAL_STUNDAS
          .
          KDIENAS+=1                                 ! VISAS DIENAS KAD ~KADRS
       .
    .
    IF RET = 5
       IF INRANGE(I#,S_DAT,B_DAT)  ! IR P�RKL�JUMS UZ S_DAT,B_DAT
          IF INRANGE(CAL_STUNDAS,0,8) OR CAL_STUNDAS='S'
             XDIENAS+=1
          .
       .
    .
 .
 FREE(X_TABLE)
! STOP(ALG:INI&' '&KALSTUNDAS&'-'&XSTUNDAS&'-'&KSTUNDAS) !4
! STOP('R:'&RET&' '&KALDDSESV&'-'&KDIENAS&'-'&XDIENAS)
 EXECUTE RET
    RETURN(KALSTUNDAS)
    RETURN(KALDD)
    RETURN(KALDDSE)
    RETURN(KALSTUNDAS-XSTUNDAS-KSTUNDAS) !4
    RETURN(XDIENAS)                      !5
    RETURN(KALDDSESV-KDIENAS)            !6
    RETURN(XDIENAS)                      !7
    RETURN(KALDDSESV)                    !8
    RETURN(KALDDSESV-KDIENAS-XDIENAS)    !9
    RETURN(KALXY)                        !10
 .

