                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETGRA               FUNCTION (YYYYMM,KAD_ID)     ! Declare Procedure
DIENA      decimal(4,1)
NAKTS      decimal(4,1)
!GRAF_S     string(96)
  CODE                                            ! Begin processed code
   IF GRAFIKS::Used = 0
     CheckOpen(GRAFIKS,1)
   END
   GRAFIKS::Used += 1

   CLEAR(GRA:RECORD)
   GRA:ID=KAD_ID
   GRA:YYYYMM = DATE(MONTH(YYYYMM),1,YEAR(YYYYMM))
   GET(GRAFIKS,GRA:ID_DAT)
   IF ERROR()
   .



!       SET(GRA:ID_DAT,GRA:ID_DAT)  !DESC
!       LOOP
!          NEXT(KAD_RIK)
!!          STOP(RIK:ID&''&RIK:TIPS)
!          IF ERROR() OR ~(RIK:ID=RIK_NR) THEN BREAK.


   DIENA=0
   NAKTS=0
   LOOP L#=1 TO 48
      IF GRA:G[DAY(YYYYMM),L#]='*'
         IF INRANGE(L#,13,44) !DIENA 6:00-20:00
            DIENA+=0.5
         ELSE
            NAKTS+=0.5
         .
      .
   .
 !  STUNDAS='Diena: '&CLIP(GRA:DIENA)&'  Nakts: '&CLIP(GRA:NAKTS)&'  Kopâ: '&CLIP(GRA:DIENA+GRA:NAKTS)


 GRAFIKS::Used-=1
 IF GRAFIKS::Used=0 THEN CLOSE(GRAFIKS).
 RETURN(DIENA+NAKTS)
