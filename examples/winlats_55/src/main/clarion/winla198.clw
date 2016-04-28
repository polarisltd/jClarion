                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetPar_Atlaide       FUNCTION (ALAPASNR,MASKA)    ! Declare Procedure
atlaide     real
SPECATL     real
KATALOGA_NR STRING(17)
  CODE                                            ! Begin processed code
!
! MASKA-APSTRÂDÂJAMÂ NOMENKLATÛRA
!
   ATLAIDE=0
   SPECATL=0
   checkopen(atl_K,1)
   IF ALAPASNR > 101
      clear(atl:record)
      BAITI#=0
      SAV_BAITI#=0
      atl:U_nr=alapasNr
      get(atl_K,atl:nr_key)
      if error()
         kluda(88,alapasNr)
         return(0)
      ELSIF ~MASKA
         RETURN(0)
      ELSIF MASKA='CHECK'
         RETURN(1)  ! CHECK FOR LAPA_EXIST
      ELSE
         atlaide=atl:atl_proc_pa
         CHECKOPEN(ATL_S,1)
         CLEAR(ATS:RECORD)
         ATS:U_NR=ATL:U_NR
         SET(ATS:NR_KEY,ATS:NR_KEY)
         loop
            NEXT(ATL_S)
            IF ERROR() OR ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
            IF ((CL_NR=1102 OR|     !ADREM
            CL_NR=1464 OR|          !AUTO ÎLE
            ACC_KODS_N=0)) AND|     !ES
            ATS:nomenklat[1]='*'    !SPEC.ATLAIDE UZ NOM:DG
               VW_DG#=GETNOM_K(MASKA,0,26) !atgrieþ NOM:DG
               IF VW_DG#=ATS:nomenklat[2] !*1-*8
                  ATLAIDE=ATS:atl_proc
               .
            ELSE
               BAITI#=0
               loop j#= 1 to LEN(MASKA)
                  if maska[j#]=ATS:nomenklat[j#] or ATS:NOMENKLAT[j#]=' '
                     if atS:nomenklat[j#]
                        BAITI#+=1
                     .
                     if j#=LEN(MASKA)
                        IF BAITI#>=SAV_BAITI#
                           SAV_BAITI#=BAITI#
                           atlaide=ATS:atl_proc
                        .
                     .
                  else
                     break
                  .
               .
            .
         .
      .
   ELSIF ALAPASNR<=100  !DEFINÇTI %
      atlaide=ALAPASNR
   .
   clear(atl:record)
   BAITI#=0
   SAV_BAITI#=0
   atl:U_nr=101                      ! SPECIÂLA OWERWITE ATLAIDE
   get(atl_K,atl:nr_key)
   if ~error() AND ATL:HIDDEN=1      ! IR AKTIVIZÇTA
      specatl=atl:atl_proc_pa
      CHECKOPEN(ATL_S,1)
      CLEAR(ATS:RECORD)
      ATS:U_NR=ATL:U_NR
      SET(ATS:NR_KEY,ATS:NR_KEY)
      loop
         NEXT(ATL_S)
         IF ERROR() OR ~(ATS:U_NR=ATL:U_NR) THEN BREAK.
         loop j#= 1 to LEN(MASKA)
            if maska[j#]=atS:nomenklat[j#] or ATS:NOMENKLAT[j#]=' '
               if atS:nomenklat[j#]
                  BAITI#+=1
               .
               if j#=LEN(MASKA)
                  IF BAITI#>=SAV_BAITI#
                     SAV_BAITI#=BAITI#
                     specatl=atS:atl_proc
                  .
               .
            else
               break
            .
         .
      .
   .
   IF ATLAIDE>SPECATL or ATLAIDE<0 !AR CIRVI, JA UZCENOJUMS
      return(atlaide)
   ELSE
      return(SPECATL)
   .



CHECKEAN             FUNCTION (EAN,OPC)           ! Declare Procedure
kods0          STRING(13)
kC             STRING(4)
REZULTATS      DECIMAL(13)
  CODE                                            ! Begin processed code
  kods0=EAN
  REZULTATS=EAN
  if kods0[12]
     sum1#=kods0[2]+kods0[4]+kods0[6]+kods0[8]+kods0[10]+kods0[12]
     sum1#=sum1#*3
     sum2#=kods0[1]+kods0[3]+kods0[5]+kods0[7]+kods0[9]+kods0[11]
     sum3#=sum1#+sum2#
     kC=sum3#
     loop i#=4 TO 1 BY -1
        IF KC[I#]
           C#=10-KC[I#]
           IF C#=10 then C#=0.
           BREAK
        .
     .
     if ~KODS0[13]
        RETURN(REZULTATS*10+C#)
     ELSIF ~(KODS0[13]=C#)
        IF OPC
!          STOP(EAN&' '&CLIP(NOM:NOS_S)&' NEPAREIZS KONTROLCIPARS : '&KODS[13]&' '&CLIP(C#))
           kluda(48,CLIP(NOM:NOS_S)&' ir '&KODS0[13]&' jâbût '&CLIP(C#))
        .
        REZULTATS=INT(REZULTATS/10)
        RETURN(REZULTATS*10+C#)
     .
  .
  RETURN(REZULTATS)
CYCLEPAR_K           FUNCTION (c)                 ! Declare Procedure
PAR_U_NR    ULONG
  CODE                                            ! Begin processed code
!
!    JÂBÛT PAZICIONÇTAM NOLIK , JA C[1]='N'
!    JÂBÛT PAZICIONÇTAM PAVAD , JA C[1]='P'
!    JÂBÛT PAZICIONÇTAM PAR_K , JA C[1]='R'
!    BROWSIS                  , JA C[1]='B'
!    JÂBÛT PAZICIONÇTAM GGK   , JA C[1]='K'
!

CASE C[1]
OF 'N'
   PAR_U_NR=NOL:PAR_NR
OF 'P'
   PAR_U_NR=PAV:PAR_NR
OF 'R'
   PAR_U_NR=PAR:U_NR
OF 'B'  !BROWSE PAR_K
!   PAR_U_NR=999999998
   PAR_U_NR=PAR:U_NR
OF 'K'
   PAR_U_NR=GGK:PAR_NR
ELSE
   STOP('CYCLEPAR_K[1]:'&C[1])
   RETURN(FALSE)
.

IF C[1]='B'
!   stop(C[4]&' '&F:ATZIME&' '&PAR:ATZIME1)
   IF C[4]='1'                                     !4.IR ÐÂDA PAR_ATZIME
      IF ~(F:ATZIME=PAR:ATZIME1 OR F:ATZIME=PAR:ATZIME2)
         RETURN(TRUE)
      .
   ELSIF C[4]='2'                                  !NAV PAR_ATZIME
      IF F:ATZIME=PAR:ATZIME1 OR F:ATZIME=PAR:ATZIME2
         RETURN(TRUE)
      .
   .
   RETURN(FALSE)
ELSE
   IF PAR_U_NR=PAR_NR                               !IZZIÒA PAR KONKRÇTU
      RETURN(FALSE)
!   ELSIF PAR_NR=999999999 OR PAR_U_NR=999999998     !IZZIÒA VISI VAI BROWSIS
   ELSIF PAR_NR=999999999                           !IZZIÒA VISI VAI BROWSIS
      LOOP J#=2 TO LEN(CLIP(C))
         EXECUTE J#
            NEVAJAG#=1
            BEGIN
            IF C[2]='1' AND PAR_GRUPA                     !2.PAR_GRUPA
               IF ~GETPAR_K(PAR_U_NR,2,1)
                  RETURN(TRUE)
               ELSE
                  IF F:NOT_GRUPA                          !IZLAIST GRUPU
                     LOOP i#=1 to 7
                        IF PAR_GRUPA[i#]
                           IF PAR_GRUPA[i#]=PAR:GRUPA[i#]
                              RETURN(TRUE)
                           .
                        .
                     .
                  ELSE                                    !GRUPA, VAI PAR:GRUPA=*
                     LOOP i#=1 to 7
                        IF ~((PAR_GRUPA[i#]=PAR:GRUPA[i#]) OR (PAR:GRUPA[i#]='*') OR (PAR_grupa[i#]=''))
                           RETURN(TRUE)
                        .
                     .
                  .
               .
            .
            .
            BEGIN
            IF C[3]='1' AND ~(PAR_TIPS='EFCNIR')            !3.PAR_TIPS
               IF INRANGE(PAR_U_NR,1,25)
                  IF ~INSTRING('I',PAR_TIPS)
                     RETURN(TRUE)
                  .
               ELSIF INRANGE(PAR_U_NR,26,50)
                  IF ~INSTRING('R',PAR_TIPS)
                     RETURN(TRUE)
                  .
               ELSIF PAR_U_NR=0  !citi, jâbût E
                  IF ~INSTRING('E',PAR_TIPS)
                     RETURN(TRUE)
                  .
               ELSE
                  IF ~GETPAR_K(PAR_U_NR,2,1)
                     RETURN(TRUE)
                  ELSE
                     IF ~INSTRING(PAR:TIPS,PAR_TIPS,1,1)
                        RETURN(TRUE)
                     .
                  .
               .
            .
            .
            BEGIN
            IF C[4]='1' AND F:ATZIME                        !4.IR ÐÂDA PAR_ATZIME
               IF ~GETPAR_K(PAR_U_NR,2,1)
                  RETURN(TRUE)
               ELSE
                  IF ~(F:ATZIME=PAR:ATZIME1 OR F:ATZIME=PAR:ATZIME2)
                     RETURN(TRUE)
                  .
               .
            .
            IF C[4]='2'                                     !NAV PAR_ATZIME
               IF ~GETPAR_K(PAR_U_NR,2,1)
                  RETURN(TRUE)
               ELSE
                  IF F:ATZIME=PAR:ATZIME1 OR F:ATZIME=PAR:ATZIME2
                     RETURN(TRUE)
                  .
               .
            .
            .
            BEGIN
            IF C[5]='1'                                      !5.IGNORÇT ARHÎVU
               IF ~GETPAR_K(PAR_U_NR,2,1)
                  RETURN(TRUE)
               ELSE
                  IF F:NOA AND PAR:REDZAMIBA='A'
   !                  STOP(C[5]&PAR:REDZAMIBA&PAR:NOS_S)
                     RETURN(TRUE)
                  .
               .
            .
            .
         .
      .
      RETURN(FALSE)
   ELSE
      RETURN(TRUE)
   .
.
