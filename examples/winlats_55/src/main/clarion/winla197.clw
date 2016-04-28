                     MEMBER('winlats.clw')        ! This is a MEMBER module
FORMAT_NOLTEX25      FUNCTION                     ! Declare Procedure
NOL_TEX   STRING(60)
  CODE                                            ! Begin processed code
LOOP I#=1 TO 25
  IF NOL_NR25[I#]
     NOL_TEX=CLIP(NOL_TEX)&'N'&CLIP(I#)&'+'
  .
.
RETURN(NOL_TEX[1:LEN(CLIP(NOL_TEX))-1])
CYCLENOL             FUNCTION (C)                 ! Declare Procedure
  CODE                                            ! Begin processed code
!
! Jâbût pozicionçtam Nolik vai Pavad
!

IF C[1]='N'      !NOLIK
  IF F:NODALA OR ADR_NR<999999999
     G#=GETPAVADZ(NOL:U_NR)                        !POZICIONÇ PAVADZÎMES
  .
  IF (C[2]='1' AND ((RS='A' AND NOL:RS='1') OR (RS='N' AND NOL:RS=''))) OR| !NOL:RS=0- APSTIPRINÂTIE
     (C[3]='1' AND ~INSTRING(NOL:D_K,'DK')) OR|                             !D-K
     (C[3]='2' AND ~INSTRING(NOL:D_K,'DKP')) OR|                            !D-K-P
     (C[4]='1' AND ~INRANGE(NOL:DATUMS,S_DAT,B_DAT)) OR|                    !DATUMS
     (C[4]='2' AND ~(NOL:DATUMS<=B_DAT)) OR|                                !DATUMS < B_DAT
     (C[5]='1' AND ~(NOL:D_K=D_K)) OR|                                      !D_K
     (C[6]='1' AND ~(NOL:OBJ_NR=F:OBJ_NR OR F:OBJ_NR=0)) OR|                !OBJEKTS/PROJEKTS
     (C[7]='1' AND  F:NODALA AND ~(PAV:NODALA=F:NODALA OR (PAV:NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
           (PAV:NODALA[2]=F:NODALA[2] AND F:NODALA[1]=''))) OR|             !PÇC NODAÏAS
     (C[8]='1' AND ~(PAV:PAR_ADR_NR=ADR_NR OR ADR_NR=999999999))            !PÇC ADRESES
     RETURN(TRUE)
  ELSE
     RETURN(FALSE)
  .
ELSIF C[1]='P'   !PAVAD
  IF (C[2]='1' AND ((RS='A' AND PAV:RS='1') OR (RS='N' AND PAV:RS=''))) OR| !PAV:RS=0- APSTIPRINÂTIE
     (C[3]='1' AND ~INSTRING(PAV:D_K,'DK')) OR|                             !D-K
     (C[4]='1' AND ~INRANGE(PAV:DATUMS,S_DAT,B_DAT)) OR|                    !DATUMS
     (C[4]='2' AND ~(PAV:DATUMS<=B_DAT)) OR|                                !DATUMS < B_DAT
     (C[5]='1' AND ~(PAV:D_K=D_K)) OR|                                      !D_K
     (C[6]='1' AND ~(PAV:OBJ_NR=F:OBJ_NR OR F:OBJ_NR=0)) OR|                !OBJEKTS/PROJEKTS
     (C[7]='1' AND  F:NODALA AND ~(PAV:NODALA=F:NODALA OR (PAV:NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
           (PAV:NODALA[2]=F:NODALA[2] AND F:NODALA[1]=''))) OR|             !PÇC NODAÏAS
     (C[8]='1' AND ~(PAV:PAR_ADR_NR=ADR_NR OR ADR_NR=999999999))            !PÇC ADRESES
     RETURN(TRUE)
  ELSE
     RETURN(FALSE)
  .
ELSE
  STOP('CYCLENOL C[1]:'&C[1])
  RETURN(FALSE)
.
LOOKINT              FUNCTION (D,P)               ! Declare Procedure
REALIZ       decimal(12,3)
DATUMS       LONG
  CODE                                            ! Begin processed code
!
!  SARÇÍINA REALIZÂCIJAS INTENSITÂTI NOLIKTAVÂ
!  DRÎKST SAUKT TIKAI UZ POZICIONÇTA NOM_K
!
!
  DONE#=0
  REALIZ=0
  CLEAR(REALMAS)
  sd#=today()-D-P+1
  S4#=round(P/4,1)
  p4#=round(P/4,1)-1
  CLEAR(NOL:RECORD)
  NOL:NOMENKLAT=NOM:NOMENKLAT
  NOL:DATUMS=TODAY()-P-D+1
  SET(nol:NOM_key,nol:NOM_key)
  DO NEXTS
  LOOP UNTIL DONE#
     CASE NOL:D_K
     OF 'K'
        REALIZ += NOL:DAUDZUMS
        IF INRANGE(NOL:DATUMS,SD#,sd#+p4#)
           REALMAS[1]+=NOL:DAUDZUMS
        elsIF INRANGE(NOL:DATUMS,SD#+S4#,sd#+s4#+p4#)
           REALMAS[2]+=NOL:DAUDZUMS
        elsIF INRANGE(NOL:DATUMS,SD#+2*S4#,sd#+2*s4#+p4#)
           REALMAS[3]+=NOL:DAUDZUMS
        elsIF INRANGE(NOL:DATUMS,SD#+3*S4#,today()-dienasign)
           REALMAS[4]+=NOL:DAUDZUMS
        .
     .
     DO NEXTS
  .
  RETURN(REALIZ/P)
NEXTS        ROUTINE
 LOOP UNTIL EOF(NOLIK)
    NEXT(NOLIK)
    IF ~(NOL:NOMENKLAT=NOM:NOMENKLAT) THEN BREAK.
    IF ~(NOL:DATUMS<=TODAY()-D) THEN BREAK.
    IF INRANGE(NOL:PAR_NR,1,25) THEN CYCLE.
    EXIT
 .
 DONE#=1
