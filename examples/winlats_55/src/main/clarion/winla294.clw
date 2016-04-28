                     MEMBER('winlats.clw')        ! This is a MEMBER module
PerfAtable_NoKont    FUNCTION (opc,ref_nr,ggk_bkk,RST,par_u_nr,ggk_nodala,ggk_obj_nr,ggk_u_nr,f_nodala,GGK_PVN_PROC,<B_DATUMS>) ! Declare Procedure
RET         BYTE
KontaGarums BYTE
A_SUMMAV    DECIMAL(11,2)
A_SUMMA     DECIMAL(11,2)
A_DATUMS    LONG
FNODALA     STRING(2)
  CODE                                            ! Begin processed code
 !
 !   OPC 1- SA�EM   GL: KKK,D_K,KKK1,D_K1
 !          ATGRIE� GL: SUMMA (KOP�J� K APMAKSU SUMMA IESKAITAM)
 !   OPC 2- SA�EM   GL: VAL_NOS (R��INA VAL�TA)
 !          ATGRIE� GL: PERIODS,VAL_NOS=Ls,JA DA��DAS
 !
    !STOP('OPC='&OPC)
 RET=1
 case OPC
 of 1                          ! Uzb�v�jam apmaksu tabulu  D531 un(vai) K231 KONKR�TAM PARTNERIM, ATGRIE� APMAKSAS NO
   KontaGarums=LEN(CLIP(KKK))  ! SALDO CAUR BILANCE
   FNODALA=F_NODALA
   SUMMA=0
   BILANCE=0
   free(A_TABLE)
   IF GGK::USED=0
      CHECKOPEN(GGK,1)
   .
   GGK::USED+=1
   CLEAR(GGK:RECORD)
   ggk:par_nr=PAR_U_NR
   SET(GGK:PAR_KEY,GGK:PAR_KEY)
   LOOP
     NEXT(GGK)
     IF ERROR() THEN BREAK.
     IF ~(GGK:PAR_NR=PAR_U_NR) THEN BREAK.
     IF B_DATUMS AND GGK:DATUMS>B_DATUMS THEN BREAK.
!     IF ~(GGK:BKK[1:KontaGarums]=KKK) THEN CYCLE.
     IF ~((GGK:BKK[1:KontaGarums]=KKK  AND GGK:D_K=D_K)  OR|
          (GGK:BKK[1:KontaGarums]=KKK1 AND GGK:D_K=D_K1)) THEN CYCLE.
!     IF ~(GGK:D_K=D_K) THEN CYCLE.
     IF (RST='A' AND GGK:RS='1') OR (RST='N' AND GGK:RS='') THEN CYCLE.
     IF BAND(ggk:BAITS,00000001b) THEN CYCLE. !IEZAKS

     IF ~(GGK:NODALA=FNODALA OR (GGK:NODALA[1]=FNODALA[1] AND FNODALA[2]='') OR| !LIELAS J�GAS NO �IT� NAV
     (GGK:NODALA[2]=FNODALA[2] AND FNODALA[1]='') OR FNODALA='') THEN CYCLE.

     A:REFERENCE=GGK:REFERENCE
     IF ~A:REFERENCE         !M�SU(VI�U) R��IN� VAR B�T V�L AR� K23100(D53100)
        IF GETGG(GGK:U_NR) THEN A:REFERENCE=GG:DOK_SENR.
     .
     A:PAR_NR=GGK:PAR_NR
     A:SUMMAV=GGK:SUMMAV
     A:SUMMA =GGK:SUMMA
     A:VAL=GGK:VAL
     A:SUMMAV_T=0            !TEKO�� APMAKSA
     A:VAL_T=''
     A:DATUMS=GGK:DATUMS
!     A:BKK=''
     A:BKK=GGK:BKK           !20.06.2007 D�� IESKAITA
     A:NODALA=GGK:NODALA     !LIELAS J�GAS NO
     A:OBJ_NR=GGK:OBJ_NR     !�IT� NAV....
     A:U_NR=0                !14.11.2006
     A:PVN_PROC=GGK:PVN_PROC !15.12.2008
     ADD(A_TABLE)
     IF ERROR() THEN STOP('Rakstot A-table (ATMI�A?)'&ERROR()).
     IF GGK:D_K=D_K     !JA PIEPRASA TIKAI D VAI KRED�TU
        A_SUMMAV+=A:SUMMAV
        IF GGK:U_NR=1 !SALDO
           !BILANCE+=A:SUMMA
           BILANCE+=GGK:SUMMA
        .
     ELSIF GGK:D_K=D_K1 !IESKAITS
        !SUMMA+=A:SUMMAV
        SUMMA+=GGK:SUMMAV
     .
     !STOP(KKK&' '&A:PAR_NR&' '&A:SUMMAV&' '&FORMAT(A:DATUMS,@D6))
   .
   GGK::USED-=1
   IF GGK::USED=0
      CLOSE(GGK)
   .
 of 2                    ! Samekl�jam apmaksas piepras�tajam Dok. p�c references
   A_SUMMAV=0            ! Atgrie�am p�d�jo apmaksas datumu caur PERIODS
   A_SUMMA =0            ! Atgrie� apmaksas val�tu caur DAIF - NEVAJAG
   PERIODS=0
   CHANGEVAL#=FALSE
   GET(A_TABLE,0)
   LOOP I#=1 TO RECORDS(A_TABLE)
     GET(A_TABLE,I#)
     IF A:REFERENCE=REF_NR
        A_SUMMAV+=A:SUMMAV
        A_SUMMA +=A:SUMMA
        IF VAL_NOS AND ~(VAL_NOS=A:VAL) !APMAKSAS VAL NESAKR�T AR R��INA VAL
           CHANGEVAL#=TRUE
        .
        PERIODS=A:DATUMS
     .
   .
   IF CHANGEVAL# =TRUE
      A_SUMMAV=A_SUMMA    !ATGRIE�AM Ls
      !17/02/2015 VAL_NOS='Ls'
      VAL_NOS=val_uzsk !17/02/2015
   .
 of 3                     ! Samekl�jam teko�� seansa apmaksas piepras�tajam Dok. p�c references
   A_SUMMA=0
   A_SUMMAV=0
   GET(A_TABLE,0)
   LOOP I#=1 TO RECORDS(A_TABLE)
     GET(A_TABLE,I#)
     IF A:REFERENCE=REF_NR
        A_SUMMAV+=A:SUMMAV_T
     .
   .
 OF 4                    ! Pierakstam teko�� seansa apmaksas
   A:REFERENCE=REF_NR
!   A:DOK_SE=GG:DOK_SE
   A:SUMMA=0
   A:SUMMAV=0
   A:VAL=''
   A:SUMMAV_T=SUMMA
   A:VAL_T   =VAL_NOS
   A:BKK     =GGK_BKK
   A:NODALA  =GGK_NODALA !lielas j�gas no
   A:OBJ_NR  =GGK_OBJ_NR !�it� nav...
   A:U_NR    =GGK_U_NR
   A:PVN_PROC=GGK_PVN_PROC !15.12.2008
   ADD(A_TABLE)
 OF 5                    ! No�emam teko�� seansa apmaksas
   GET(A_TABLE,0)
   LOOP I#=1 TO RECORDS(A_TABLE)
     GET(A_TABLE,I#)
     IF A:REFERENCE=REF_NR
        A:SUMMAV_T=0
        A:VAL_T=''
        A:BKK=''
        A:U_NR=0
        PUT(A_TABLE)
     .
   .
 OF 6                    ! CIT�DA teko�� seansa apmaksa
   SUMMA_W(2)
   IF GLOBALRESPONSE=REQUESTCOMPLETED
     GET(A_TABLE,0)
     LOOP I#=1 TO RECORDS(A_TABLE)  !NO�EMAM, KAS MAKS�TS TAGAD
        GET(A_TABLE,I#)
        IF A:REFERENCE=REF_NR
           A:SUMMAV_T=0
           A:VAL_T=''
           A:BKK=''
           PUT(A_TABLE)
        .
     .
     A:REFERENCE=REF_NR
     A:SUMMA=0
     A:SUMMAV=0
     A:VAL=''
     A:SUMMAV_T=SUMMA
     A:VAL_T=VAL_NOS
     A:BKK=GGK_BKK
     A:NODALA=GGK_NODALA   !
     A:OBJ_NR=GGK_OBJ_NR   !
     A:PVN_PROC=GGK_PVN_PROC !15.12.2008
     ADD(A_TABLE)
   ELSE
     SUMMA=0
   .
 of 7                    ! Samekl�jam p�d�j�s apmaksas datumu piepras�tajam Dok. p�c references
   A_DATUMS=0
   GET(A_TABLE,0)
   LOOP I#=1 TO RECORDS(A_TABLE)
     GET(A_TABLE,I#)
     IF A:REFERENCE=REF_NR
        A_DATUMS=A:DATUMS
      .
   .
   RET=2
 ELSE
   STOP('OPC='&OPC)
 .
 EXECUTE RET
   RETURN(A_SUMMAV)
   RETURN(A_DATUMS)
 .
