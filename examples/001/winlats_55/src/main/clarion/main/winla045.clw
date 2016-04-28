                     MEMBER('winlats.clw')        ! This is a MEMBER module
CYCLEGGK             FUNCTION (C)                 ! Declare Procedure
  CODE                                            ! Begin processed code
IF C[1]='K'      !GGK
  IF (C[2]='1' AND ((RS='A' AND GGK:RS='1') OR (RS='N' AND GGK:RS=''))) OR| !GGK:RS=0- APSTIPRINÂTIE
     (C[3]='1' AND ~(GGK:DATUMS<=B_DAT)) OR|                                !DATUMS <= b_dat
     (C[3]='2' AND ~INRANGE(GGK:DATUMS,S_DAT,B_DAT)) OR|                    !S_DAT<=DATUMS<=B_dat
     (C[4]='1' AND ~(GGK:D_K='D')) OR|                                      !D
     (C[4]='2' AND ~(GGK:D_K='K')) OR|                                      !K
     (C[4]='3' AND ~(GGK:D_K=D_K)) OR|                                      !D_K
     (C[5]='1' AND ~(GGK:PVN_TIPS=F:PVN_T OR F:PVN_T='')) OR|               !PVN_TIPS
     (C[5]='1' AND ~(GGK:PVN_PROC=F:PVN_P OR F:PVN_P= 0)) OR|               !&PVN_%
     (C[6]='1' AND ~(GGK:OBJ_NR=F:OBJ_NR OR F:OBJ_NR=0)) OR|                !OBJEKTS/PROJEKTS
     (C[7]='1' AND ~(GGK:NODALA=F:NODALA OR (GGK:NODALA[1]=F:NODALA[1] AND F:NODALA[2]='') OR|
     (GGK:NODALA[2]=F:NODALA[2] AND F:NODALA[1]='') OR F:NODALA=''))        !NODAÏA
     RETURN(TRUE)
  ELSE
     RETURN(FALSE)
  .
ELSIF C[1]='G'   !GG
  IF (C[2]='1' AND ((RS='A' AND GG:RS='1') OR (RS='N' AND GG:RS=''))) OR| !GGK:RS=0- APSTIPRINÂTIE
     (C[3]='1' AND ~(GG:DATUMS<=B_DAT))                                   !DATUMS
     RETURN(TRUE)
  ELSE
     RETURN(FALSE)
  .
ELSE
  STOP('CYCLEGGK[1]='&C[1])
  RETURN(FALSE)
.



CYCLEBKK             FUNCTION (GGK_BKK,BKK)       ! Declare Procedure
  CODE                                            ! Begin processed code
 IF (BKK[1] AND GGK_BKK[1]>BKK[1]) OR|
    (GGK_BKK[1]  =BKK[1]   AND BKK[2] AND GGK_BKK[2]>BKK[2]) OR|
    (GGK_BKK[1:2]=BKK[1:2] AND BKK[3] AND GGK_BKK[3]>BKK[3]) OR|
    (GGK_BKK[1:3]=BKK[1:3] AND BKK[4] AND GGK_BKK[4]>BKK[4]) OR|
    (GGK_BKK[1:4]=BKK[1:4] AND BKK[5] AND GGK_BKK[5]>BKK[5])
    RETURN(2)  !NAV UN VAIRÂK NEBÛS
 .
 loop F#=1 to 5
    IF ~(GGK_BKK[F#]=BKK[F#] OR BKK[F#]=' ')
       RETURN(TRUE)
    .
 .
 RETURN(FALSE)
WRGG                 PROCEDURE                    ! Declare Procedure
  CODE                                            ! Begin processed code

  KLUDA(5,'GGK-GG '&FORMAT(GGK:DATUMS,@D5))

OMIT('MARIS')
  CHECKOPEN(GG,1)
  CLEAR(GG:RECORD)
  GG:U_NR=GGK:U_NR
  GET(GG,GG:NR_KEY)
  IF ERROR()
     GG:DATUMS=GGK:DATUMS
     GG:DATUMS1=GGK:DATUMS
     GG:SATURS='... ???'
     IF ~(GGK:PAR_NR=0)
        CLEAR(PAR:RECORD)
        PAR:U_NR=GGK:PAR_NR
        GET(PAR_K,PAR:NR_KEY)
        IF ~ERROR()
           GG:PAR_NR=PAR:U_NR
           GG:NOKA=PAR:NOS_S
        .
     .
     ADD(GG)
     IF ERROR()
        STOP('KÏÛDA REÌENERÇJOT PAZUDUÐU RAKSTU')
     .
  ELSE
     GG:DATUMS=GGK:DATUMS
     GG:DATUMS1=GGK:DATUMS
     GG:SATURS='... ???'
     IF ~(GGK:PAR_NR=0)
        CLEAR(PAR:RECORD)
        PAR:U_NR=GGK:PAR_NR
        GET(PAR_K,PAR:NR_KEY)
        IF ~ERROR()
           GG:PAR_NR=PAR:U_NR
           GG:NOKA=PAR:NOS_S
        .
     .
     PUT(GG)
     IF ERROR()
        STOP('KÏÛDA PÂRRAKSTOT PAZUDUÐU RAKSTU')
     .
  .
  RETURN
MARIS
