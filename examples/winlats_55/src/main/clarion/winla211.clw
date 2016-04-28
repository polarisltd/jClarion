                     MEMBER('winlats.clw')        ! This is a MEMBER module
SUM                  FUNCTION (OPC)               ! Declare Procedure
SU                 SREAL
SA                 SREAL
SNAM               SREAL
SANM               SREAL
MIA                DECIMAL(10,2)
SAVERECORD         LIKE(ALG:RECORD),PRE(SAV)
SAV_ALP            LIKE(ALP:RECORD)
  CODE                                            ! Begin processed code
!      SUM F(I) :
!
!  1-ALGA BEZ SOCIÂLAJIEM,ATV,SLILAPAS
!  2-SOCIÂLIE PABALSTI
!  3-SLILAPAS
!  4-ATVAÏINÂJUMI UN ATVAÏINÂJUMU NAUDAS
!  5-NODOKÏI ðajâ,nâkamajos un pagâjuðajos mçneðos
!  6-DARBA ÒÇMÇJA SOCIÂLAIS NODOKLIS
!  7-IZPILDRAKSTS                                    >=912T=2
!  8-CITI IETURÇJUMI(1)                              >=912T=1
!  9-AVANSS                                           =904
! 10-PÂRMAKSA/PARÂDS                                  =905
! 11-IZMAKSÂT UZ ROKAS
! 12-LAIKA DARBA ALGA
! 13-GABALDARBA ALGA
! 14-PRÇMIJAS
! 15-PIEMAKSAS PAR BRÎVDIENÂM UN NAKTSSTUNDÂM
! 16-CITAS PIEMAKSAS(1)                               T=5
! 17-ALGA KOPÂ PAMATDARBINIEKIEM (BEZ ATV.nâk. & aiznâk.m., BEZ SLILAPAS) F(97)
! 18-ALGA KOPÂ SAVIETOTÂJIEM (BEZ ATV.nâk. & aiznâk.m., BEZ SLILAPAS) F(97)
! 19-ALGA KOPÂ (BEZ ATV.nâk. & aiznâk.m., BEZ SLILAPAS) F(97)
! 20-PIESKAITÎJUMI NO SOC-LÎDZEKÏIEM KOPÂ
! 21-ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS
! 22-NODOKÏU PAMATLIKME ðajâ mçnesî
! 23-NODOKÏU PAPILDLIKME ðajâ mçnesî
! 24-ÂRKÂRTAS IZMAKSAS                               >=912T=3
! 25-PARÂDI PAR IEPRIEKÐÇJO MÇNESI
! 26-IENÂKUMA NODOKLIS par nâkoðo mçnesi
! 27-IENÂKUMA NODOKLIS par aiznâkoâo mçnesi
! 28-IETURÇJUMI KOPÂ
! 29-CITAS PIEMAKSAS(2)                               T=6
! 30-ATVAÏINÂJUMI ÐAJÂ MÇNESÎ
! 31-ALGA ADMINISTRÂCIJAI(BEZ ATV NÂK.M. BEZ SOC) F(97)
! 32-ALGA STRÂDNIEKIEM   (BEZ ATV NÂK.M. BEZ SOC) F(97)
! 33-PIESKAITÎJUMI KOPÂ
! 34-NOSTRÂDÂTÂS STUNDAS
! 35-BRUTO IEÒÇMUMI
! 36-IZMAKSÂT (BEZ SOCIÂLAJIEM PABALSTIEM)
! 37-NEAPLIEKAMAIS MINIMUMS F(A,97) !PÂRRÇÍINS, TAS, KO LIETOJAM APRÇÍINIEM
! 38-ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM F(97)
! 39-ATVIEGLOJUMI PAR INVALIDITÂTI+PRP F(97) ???????????????????
! 40-IENÂKUMS, NO KURA RÇÍINA SOCIÂLOS F(97)
! 41-SLILAPAS IEPRIEKÐÇJOS MÇNEÐOS
! 42-IENNODOKLIS PAR IEPRIEKÐÇJIEM MÇNEÐIEM
! 43-APRÇÍINÂTÂ ALGA KOPÂ PRIEKÐ SOCIÂLAJIEM PAR ÐO MÇNESI F(97)
! 44-APRÇÍINÂTAIS ATVAÏINÂJUMS PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ
! 45-APRÇÍINÂTAIS ATVAÏINÂJUMS PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ
! 46-ATVAÏINÂJUMI NÂK,AIZNÂK.M. PAMATDARBINIEKIEM
! 47-ATVAÏINµJUMI NÂK,AIZNÂK.M. SAVIETOTµJIEM
! 48-ATVAÏINµJUMI NÂK,AIZNÂK.M. ADMINISTRÂCIJAI
! 49-ATVAÏINÂJUMI NÂK,AIZNÂK.M. STRÂDNIEKIEM
! 50-ATVIEGLOJUMI POLITISKI REPRESÇTÂM PERSONÂM
! 51-ATVIEGLOJUMI PAR INVALIDITÂTI
! 52-MAX STUNDAS
! 53-NEAPLIEKAMIE IEÒÇMUMI
! 54-IENÂKUMS, KAS APLIKTS AR IEN.NODOKLI PAR ÐO MÇNESI
! 55-CITI IETURÇJUMI(2)                              >=912T=6
! 56-PÂRSKAITÎJUMS UZ KARTI(BIJ.CITI IETURÇJUMI(3))                              >=912T=7
! 57-Dâvanas u.c. neapliekamie                            T=9
! 58-SLILAPAS ÐAJÂ & IEPR.MÇN.
! 59-SLILAPAS NÂK.MÇN.
! 60-DARBA ÒÇMÇJA SOCIÂLAIS  NODOKLIS par ÐO mçnesi
! 61-DARBA ÒÇMÇJA SOCIÂLAIS  NODOKLIS par nâk. un aizn. mçneðiem
! 62-SLILAPA PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
! 63-SLILAPA NÂK.M. PAMATDARBINIEKIEM
! 64-SLILAPA NÂK.M. SAVIETOTµJIEM
! 65-SLILAPA NÂK.M. ADMINISTRÂCIJAI
! 66-SLILAPA NÂK.M. STRÂDNIEKIEM
!

  SAV_ALP=ALP:RECORD  ! ATSKAITÇ VAR BÛT VAJADZÎGAS VÇRTÎBAS
  IF ALGPA::USED=0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::USED+=1

  CASE OPC
  OF 1                ! ALGA BEZ SOCIÂLAJIEM,ATV,SLILAPAS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879 !NO 880 ATKAL SÂKAS PIESKAITÎJUMI
          SU+=ALG:R[I#]
       .
    .
  OF 2                      !SOCIÂLIE BEZ SLILAPAS
    LOOP I#=1 TO 20
       IF ALG:K[I#]=860
          SU+=ALG:R[I#]
       .
    .
  OF 3                      ! SLILAPAS
    LOOP I#=1 TO 20
       IF INRANGE(ALG:K[I#],850,859)
            SU+=ALG:R[I#]
       .
    .
  OF 4                      !ATVAÏINÂJUMI KOPÂ (Ð,N,AN)
    LOOP I#=1 TO 20
       IF INRANGE(ALG:K[I#],840,845)
            SU+=ALG:R[I#]
       .
    .
  OF 5                      !NODOKÏI SAJÂ, Nâkamajos & PAG.Mçneðos
     LOOP I#=1 TO 15
        IF INRANGE(ALG:I[I#],901,902) OR INRANGE(ALG:I[I#],906,909)
           SU+=ALG:N[I#]
        .
     .
  OF 6                      !DARBA ÒÇMÇJA SOCIÂLAIS  NODOKLIS par ðo, nâk un aizn. mçneðiem
     LOOP I#=1 TO 15
        IF ALG:I[I#]=903 OR ALG:I[I#]=910 OR ALG:I[I#]=911
           SU+=ALG:N[I#]
        .
     .
  OF 7                      !IZPILDRAKSTS
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF getdaiev(alg:I[I#],0,2)='2'
             SU+=ALG:N[I#]
           .
        .
     .
  OF 8                      !CITI ATVILKUMI
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF getdaiev(alg:I[I#],0,2)='1'
             SU+=ALG:N[I#]
           .
        .
     .
  OF 9                      !AVANSS
     LOOP I#=1 TO 15
        IF ALG:I[I#]=904
           SU+=ALG:N[I#]
        .
     .
  OF 10                     !Pârmaksa/parâds
     LOOP I#=1 TO 15
        IF ALG:I[I#]=905
           SU+=ALG:N[I#]
        .
     .
  OF 11                     !IZMAKSÂT UZ ROKAS
     LOOP I#=1 TO 20
        SU+=ALG:R[I#]
     .
     LOOP I#=1 TO 15
        SU-=ALG:N[I#]
     .
  OF 12                     !LAIKA DARBA ALGA
     LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='2'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 13                     !GABALDARBA ALGA
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='1'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 14                     !PRÇMIJAS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='3'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 15                     !PIEMAKSA PAR BRÎVDIENÂM & NS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='4'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 16                     !CITAS PIEMAKSAS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='5'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 17                     !ALGA KOPÂ (PIE-ATVN-ATVAN-SOC) PAMATDARBINIEKIEM
    LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
          IF ALG:K[I#] <=840 OR INRANGE(ALG:K[I#],843,849) OR ALG:K[I#] > 879
             IF ALG:STATUSS='1' or ALG:STATUSS='3'
               SU+=ALG:R[I#]
             .
          .
        ELSE
          IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,851) OR ALG:K[I#] > 879
             IF ALG:STATUSS='1' or ALG:STATUSS='3'
               SU+=ALG:R[I#]
             .
          .
        .
    .
  OF 18                     !ALGA KOPÂ SAVIETOTÂJIEM
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,849) OR ALG:K[I#] > 879
              IF ALG:STATUSS='2' or ALG:STATUSS='4'
                SU+=ALG:R[I#]
              .
           .
        ELSE
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,851) OR ALG:K[I#] > 879
              IF ALG:STATUSS='2' or ALG:STATUSS='4'
                SU+=ALG:R[I#]
              .
           .
        .
     .
  OF 19                     !ALGA KOPÂ
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,849) OR ALG:K[I#] > 879
                SU+=ALG:R[I#]
           .
        ELSE
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,851) OR ALG:K[I#] > 879
                SU+=ALG:R[I#]
           .
        .
     .
  OF 20                     !SOC-PIESKAITÎJUMI KOPÂ
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF INRANGE(ALG:K[I#],850,879)
                SU+=ALG:R[I#]
           .
        ELSE
           IF ALG:K[I#]=860
                SU+=ALG:R[I#]
           .
        .
     .
  OF 21                     !ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
             SU+=ALG:R[I#]
        .
     .
  OF 22                     !NODOKÏA PAMATLIKME
     LOOP I#=1 TO 15
        IF ALG:I[I#]=901
           SU+=ALG:N[I#]
        .
     .
  OF 23                     !NODOKÏA PAPILDLIKME
     LOOP I#=1 TO 15
        IF ALG:I[I#]=902
           SU+=ALG:N[I#]
        .
     .
  OF 24                     !ÂRKÂRTAS IZMAKSAS
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF GETDAIEV(ALG:I[I#],0,2)='3'
              SU+=ALG:N[I#]
           .
        .
     .
  OF 25                     !PÂRMAKSA/PARÂDS NO IEPR.MÇN.
     LOOP I#=1 TO 15
        IF ALG:I[I#]=905
           SU+=ALG:N[I#]
        .
     .
  OF 26                     !NODOKLI nâkamajâ mçnesî
     LOOP I#=1 TO 15
        IF ALG:I[I#]=908
           SU+=ALG:N[I#]
        .
     .
  OF 27                     !NODOKLI aiznâkamajâ mçnesî
     LOOP I#=1 TO 15
        IF ALG:I[I#]=909
           SU+=ALG:N[I#]
        .
     .
  OF 28                     !IETURÇJUMI KOPÂ
     LOOP I#=1 TO 15
        IF ALG:I[I#]>900
           SU+=ALG:N[I#]
        .
     .
  OF 29                     !CITAS PIEMAKSAS(2)
     LOOP I#=1 TO 20
        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
           IF getdaiev(alg:K[I#],0,2)='6'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 30                     !ATVAÏINÂJUMU naudas ÐAJÂ MÇNESÎ
     LOOP I#=1 TO 20
        IF ALG:K[I#]=840 OR INRANGE(ALG:K[I#],843,845)
             SU+=ALG:R[I#]
        .
     .
  OF 31                     !ALGA KOPÂ ADMINISTRÂCIJAI BEZ ATV.NÂK.M.BEZ SOC.
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],846,849)
              IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
                SU+=ALG:R[I#]
              .
           .
        ELSE
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,851) OR ALG:K[I#] > 879
              IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
                SU+=ALG:R[I#]
              .
           .
        .
     .
  OF 32                     !ALGA KOPÂ STRÂDNIEKIEM BEZ ATV.NÂK.M.BEZ SOC.
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],846,849)
              IF ALG:STATUSS = '3' OR  ALG:STATUSS = '4'
                SU+=ALG:R[I#]
              .
           .
        ELSE
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,851) OR ALG:K[I#] > 879
              IF ALG:STATUSS = '3' OR  ALG:STATUSS = '4'
                SU+=ALG:R[I#]
              .
           .
        .
     .
  OF 33                     !PIESKAITÎJUMI KOPA
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],1,899)
           SU+=ALG:R[I#]
        .
     .
!  OF 34                     !NOSTRÂDÂTÂS STUNDAS KOPÂ
  OF 34                     !NOSTRÂDÂTÂS STUNDAS KOPÂ NO FAILA
     SU=ALG:N_STUNDAS
!     LOOP I#=1 TO 20
!        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
!           clear(dai:record)
!           dai:kods=alg:K[I#]
!           get(daiev,dai:kod_key)
!           if dai:F='CAL'
!             SU+=ALG:S[I#]
!           .
!        .
!     .
  OF 35                     !BRUTO IEÒÇMUMS
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 849
                SU+=ALG:R[I#]
           .
        ELSE
           IF ~(ALG:K[I#]= 860) !NAV SOCPAB
                SU+=ALG:R[I#]
           .
        .
     .
  OF 36                     !IZMAKSÂT (BEZ SOCIÂLAJIEM PABALSTIEM)
     LOOP I#=1 TO 20
        IF ~(ALG:K[I#]=860)
           SU+=ALG:R[I#]
        .
     .
     LOOP I#=1 TO 15
        SU-=ALG:N[I#]
     .
  OF 37                     !NEAPLIEKAMAIS MINIMUMS
     IF ~(ALG:YYYYMM=ALP:YYYYMM)
        ALP:YYYYMM=ALG:YYYYMM
        GET(ALGPA,ALP:YYYYMM_KEY)
        IF ERROR() THEN STOP('ALGPA '&ERROR()).
     .
     MIA=CALCNEA(1,0,0) !(OPC,REQ,A_DIENAS) NEAPL.MIN ÐAJÂ MÇNESÎ
     CASE ALG:STATUSS
     OF '1'
     OROF '3'
        LOOP I#=1 TO 20
           IF YEAR(ALG:YYYYMM)<1997
              IF ALG:K[I#]<850 AND ~INRANGE(ALG:K[I#],841,842)
                 SU+=ALG:R[I#]
              .
           ELSE
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCIÂLAIS PAB & NAV ATV.NÂK.M.
                 SU+=ALG:R[I#]
              .
           .
        .
        SAVERECORD=ALG:RECORD
        ALG:YYYYMM=DATE(MONTH(SAV:YYYYMM)+11,1,YEAR(SAV:YYYYMM)-1)  !LAI DABÛTU 1 MÇNESI ATPAKAÏ
!    STOP(FORMAT(ALG:YYYYMM,@D6)&' 841')
        ALG:ID=SAV:ID
        GET(ALGAS,ALG:ID_KEY)
        IF ~ERROR()
           LOOP I#=1 TO 20
              IF ALG:K[I#] = 841 !ATV.NÂK.M
                 SU+=ALG:R[I#]
              .
           .
        .
        ALG:YYYYMM=DATE(MONTH(SAV:YYYYMM)+10,1,YEAR(SAV:YYYYMM)-1)  !LAI DABÛTU 2 MÇNEÐUS ATPAKAÏ
!   STOP(FORMAT(ALG:YYYYMM,@D6)&' 841')
        ALG:ID=SAV:ID
        GET(ALGAS,ALG:ID_KEY)
        IF ~ERROR()
           LOOP I#=1 TO 20
              IF ALG:K[I#] = 842 !ATV.AIZNÂK.M
                 SU+=ALG:R[I#]
              .
           .
        .
        ALG:RECORD=SAVERECORD
!    STOP(FORMAT(ALG:YYYYMM,@D6)&' '&SU&' '&MIA)
        IF SU > MIA
           SU=MIA
        .
     ELSE
        SU=0
     .
  OF 38                     !ATVIEGLOJUMI PAR APGÂDÂJAMIEM
     CASE ALG:STATUSS
     OF '1'
     OROF '3'
        IF ~(ALG:YYYYMM=ALP:YYYYMM)
           ALP:YYYYMM=ALG:YYYYMM
           GET(ALGPA,ALP:YYYYMM_KEY)
           IF ERROR() THEN STOP('PARSK '&ERROR()).
        .
        MIA=CALCNEA(2,0,0)
        LOOP I#=1 TO 20
           IF YEAR(ALG:YYYYMM)<1997
              IF ALG:K[I#]<850 AND ~INRANGE(ALG:K[I#],841,842)
                 SU+=ALG:R[I#]
              .
           ELSE
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCIÂLAIS PAB & NAV ATV.NÂK.M.
                 SU+=ALG:R[I#]
              .
           .
        .
        IF SU > MIA
           SU=MIA
        .
     ELSE
        SU=0
     .
  OF 39                     !ATVIEGLOJUMI PAR INVALIDITÂTI +PRP
     CASE ALG:STATUSS
     OF '1'
     OROF '3'
        IF ~(ALG:YYYYMM=ALP:YYYYMM)
           ALP:YYYYMM=ALG:YYYYMM
           GET(ALGPA,ALP:YYYYMM_KEY)
           IF ERROR() THEN STOP('PARSK '&ERROR()).
        .
        MIA=CALCNEA(3,0,0)
        LOOP I#=1 TO 20
           IF YEAR(ALG:YYYYMM)<1997
              IF ALG:K[I#]<850 AND ~INRANGE(ALG:K[I#],841,842)
                 SU+=ALG:R[I#]
              .
           ELSE
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCIÂLAIS PAB & NAV ATV.NÂK.M.
                 SU+=ALG:R[I#]
              .
           .
        .
        IF SU > MIA
           SU=MIA
        .
     ELSE
        SU=0
     .
  OF 40                     !ALGA KOPÂ NO KURAS RÇÍINA SOCIÂLOS
     LOOP I#=1 TO 20
        IF ALG:K[I#] <= 849 OR ALG:K[I#] > 860 OR (ALG:K[I#] <= 859 AND YEAR(ALG:YYYYMM)>=1997)
           IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 41                     !SLILAPAS IEPRIEKÐÇJOS MÇNEÐOS
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],851,852)
             SU+=ALG:R[I#]
        .
     .
  OF 42                     !iennodoklis par pagâjuðajiem mçneðiem
     LOOP I#=1 TO 15
        IF INRANGE(ALG:I[I#],906,907)
           SU+=ALG:N[I#]
        .
     .
  OF 43                     !APRÇÍINÂTÂ ALGA KOPÂ PRIEKÐ SOCIÂLAJIEM PAR ÐO MÇNESI
     LOOP I#=1 TO 20
        IF YEAR(ALG:YYYYMM)<1997
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],846,849)
              IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
                SU+=ALG:R[I#]
              .
           .
        ELSE
!          IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],846,859)
           IF ALG:K[I#] <= 840 OR INRANGE(ALG:K[I#],843,849) OR ALG:K[I#] > 860
              IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
                SU+=ALG:R[I#]
              .
           .
        .
     .
  OF 44                     !APRÇÍINÂTAIS ATVAÏINÂJUMS, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)  !LAI DABÛTU 1 MÇNESI ATPAKAÏ
     ALG:ID=SAV:ID
     GET(ALGAS,ALG:ID_KEY)
     IF ~ERROR()
        LOOP I#=1 TO 20
           IF ALG:K[I#] = 841
              IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
                SU+=ALG:R[I#]
              .
           .
        .
     .
     ALG:RECORD=SAVERECORD
  OF 45                     !APRÇÍINÂTAIS ATVAÏINÂJUMS, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+10,1,YEAR(ALG:YYYYMM)-1)  !LAI DABÛTU 2 MÇNEÐUS ATPAKAÏ
     ALG:ID=SAV:ID
     GET(ALGAS,ALG:ID_KEY)
     IF ~ERROR()
        LOOP I#=1 TO 20
           IF ALG:K[I#] = 842
              IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
                SU+=ALG:R[I#]
              .
           .
        .
     .
     ALG:RECORD=SAVERECORD
  OF 46                     !ATVAÏINÂJUMI NÂK,AIZNÂK.M. PAMATDARBINIEKIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS='1' or ALG:STATUSS='3'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 47                     !ATVAÏINÂJUMI NÂK,AIZNÂK.M. SAVIETOTÂJIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS='2' or ALG:STATUSS='4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 48                     !ATVAÏINÂJUMI NÂK,AIZNÂK.M. ADMINISTRÂCIJAI
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 49                     !ATVAÏINÂJUMI NÂK,AIZNÂK.M. STRÂDNIEKIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS = '3' OR  ALG:STATUSS = '4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 50                     !ATVIEGLOJUMI INVALÎDIEM
     IF INSTRING(ALG:STATUSS,'13') AND INRANGE(ALG:INV_P,'1','3')  !AR D.GRÂMATIÒU
        IF ~(ALG:YYYYMM=ALP:YYYYMM)
           ALP:YYYYMM=ALG:YYYYMM
           GET(ALGPA,ALP:YYYYMM_KEY)
           IF ERROR() THEN STOP('PARSK '&ERROR()).
        .
        SU=CALCNEA(3,0,0)
     ELSE
        SU=0
     .
  OF 51                     !ATVIEGLOJUMI POLITISKI REPRESÇTÂM PERSONÂM
     IF INSTRING(ALG:STATUSS,'13') AND INRANGE(ALG:INV_P,'4','5')  !AR D.GRÂMATIÒU
        IF ~(ALG:YYYYMM=ALP:YYYYMM)
           ALP:YYYYMM=ALG:YYYYMM
           GET(ALGPA,ALP:YYYYMM_KEY)
           IF ERROR() THEN STOP('PARSK '&ERROR()).
        .
        SU=CALCNEA(3,0,0)
     ELSE
        SU=0
     .
  OF 52                     !STUNDAS
     LOOP I#=1 TO 20
        IF ALG:S[I#]>SU
          SU=ALG:S[I#]
        .
        ALGA#+=ALG:R[I#]
     .
     IF ALGA#
        CS#=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4)
!       STOP(ALG:ID&'-'&CS#)
        IF ~SU OR SU>CS#
           SU=CS#
        .
     .
  OF 53                     !NEAPLIEKAMAIE IEÒÇMUMI
     LOOP I#=1 TO 20
        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
           IF getdaiev(ALG:K[I#],2,1) AND dai:IENYN='N'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 54                     !IENÂKUMS, KAS APLIKTS AR IENÂKUMA NODOKLI PAR ÐO MÇNESI
     LOOP I#=1 TO 15
        IF ALG:I[I#]=901
           SU+=ALG:C[I#]
        .
     .
  OF 55                     !CITI ATVILKUMI(2)
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF getdaiev(alg:I[I#],0,2)='6'
             SU+=ALG:N[I#]
           .
        .
     .
  OF 56                      !PÂRSKAITÎJUMS UZ KARTI(BIJ.CITI ATVILKUMI(3))
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF getdaiev(alg:I[I#],0,2)='7'
             SU+=ALG:N[I#]
           .
        .
     .
  OF 57                     !Dâvanas u.c neapliekamie
     LOOP I#=1 TO 20
        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
           IF getdaiev(alg:K[I#],0,2)='9'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 58                      ! SLILAPAS ÐAJÂ & PAG.MÇN.
    LOOP I#=1 TO 20
       IF INRANGE(ALG:K[I#],850,859) AND ~(ALG:K[I#]=852)
          SU+=ALG:R[I#]
       .
    .
  OF 59                      ! SLILAPAS NÂK.MÇN.
    LOOP I#=1 TO 20
       IF ALG:K[I#]=852
          SU+=ALG:R[I#]
       .
    .
  OF 60                      !DARBA ÒÇMÇJA SOCIÂLAIS  NODOKLIS par ÐO mçnesi
     LOOP I#=1 TO 15
        IF ALG:I[I#]=903
           SU+=ALG:N[I#]
        .
     .
  OF 61                      !DARBA ÒÇMÇJA SOCIÂLAIS  NODOKLIS par nâk. un aizn. mçneðiem
     LOOP I#=1 TO 15
        IF ALG:I[I#]=910 OR ALG:I[I#]=911
           SU+=ALG:N[I#]
        .
     .
  OF 62                      !APRÇÍINÂTÂ SLILAPA PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)  !LAI DABÛTU 1 MÇNESI ATPAKAÏ
     ALG:ID=SAV:ID
     GET(ALGAS,ALG:ID_KEY)
     IF ~ERROR()
        LOOP I#=1 TO 20
           IF ALG:K[I#] = 852
              IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
                SU+=ALG:R[I#]
              .
           .
        .
     .
     ALG:RECORD=SAVERECORD
  OF 63                     !SLILAPA NÂK.M. PAMATDARBINIEKIEM
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS='1' or ALG:STATUSS='3'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 64                     !SLILAPA NÂK.M. SAVIETOTÂJIEM
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS='2' or ALG:STATUSS='4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 65                     !SLILAPA NÂK.M. ADMINISTRÂCIJAI
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 66                     !SLILAPA NÂK.M. STRÂDNIEKIEM
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS = '3' OR  ALG:STATUSS = '4'
             SU+=ALG:R[I#]
           .
        .
     .
  .
  ALGPA::USED-=1
  IF ALGPA::USED=0 THEN CLOSE(ALGPA).
  ALP:RECORD=SAV_ALP  ! ATSKAITÇ VAR BÛT VAJADZÎGAS VÇRTÎBAS
  RETURN(SU)


CALCNEA              FUNCTION (OPC,REQ,A_DIENAS)  ! Declare Procedure
SUM_A      DECIMAL(10,2)
  CODE                                            ! Begin processed code
!
! REQ=1 OBLIGÂTI JÂPÂRRÇÍINA, PAT JA LOCKed
! AR ÐITO SARÇÍINA REÂLO DARBALAIKU UN ATVIEGLOJUMUS TEKOÐAJÂ MÇNESÎ
! UN ATVIEGLOJUMUS PAR NÂK, AIZNÂK ATVAÏINÂJUMA DIENÂM
!
! OPC 1 NEAPLIEKAMAIS MINIMUMS
! OPC 2 ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM
! OPC 3 ATVIEGLOJUMI PAR INV,PRP
! OPC 4 NEAPLIEKAMAIS MINIMUMS PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
! OPC 7 NEAPLIEKAMAIS MINIMUMS PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
! OPC 5 ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
! OPC 8 ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
! OPC 6 ATVIEGLOJUMI PAR INV PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
! OPC 9 ATVIEGLOJUMI PAR INV PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
!

 IF CAL::USED=0
    checkopen(cal,1)
 .
 CAL::USED+=1

 IF ~(ALP:YYYYMM=ALG:YYYYMM)
    ALP:YYYYMM=ALG:YYYYMM
    GET(ALGPA,ALP:YYYYMM_KEY)
    IF ERROR()
       KLUDA(0,'GET ALGPA: '&FORMAT(ALG:YYYYMM,@D06.))
    .
 .

 S1#=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,2,9)  !KALDD+SE+SV-KADRI-BLAPA
 IF INRANGE(OPC,1,3)
    S2#=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,8)  !KALDD+SE+SV   TÂ ARÎ JÂBÛT
 ELSIF INRANGE(OPC,4,6)
    S2#=CALCSTUNDAS(DATE(MONTH(ALG:YYYYMM)+1,1,YEAR(ALG:YYYYMM)),ALG:ID,0,0,8)  !KALDD+SE+SV
 ELSIF INRANGE(OPC,7,9)
    S2#=CALCSTUNDAS(DATE(MONTH(ALG:YYYYMM)+2,1,YEAR(ALG:YYYYMM)),ALG:ID,0,0,8)  !KALDD+SE+SV
 ELSE
    STOP('CALCNEA IZSAUKUMA KÏÛDA.OPC='&OPC)
    RETURN(0)
 .

 CASE OPC
 OF 1                                        !NEAPLIEKAMAIS MINIMUMS
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P < 1   !AR D-GRÂM. & NAV INVALÎDS
       IF ~ALG:LMIA OR REQ
          IF ~(S1#=S2#)
             SUM_A=ALP:MIA*S1#/S2#
          ELSE
             SUM_A=ALP:MIA
          .
       ELSE
          SUM_A=ALG:LMIA
       .
    ELSE
       SUM_A=0
    .
! stop(SUM_A&'='&ALP:MIA&'='&ALG:LMIA)
 OF 2                                          !ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM
    IF INSTRING(ALG:STATUSS,'13')              !AR D-GRÂMATIÒU
       IF ~ALG:LBER OR REQ
          IF ~(S1#=S2#)
             SUM_A=ALP:APGADSUM*ALG:APGAD_SK*S1#/S2#
          ELSE
             SUM_A=ALP:APGADSUM*ALG:APGAD_SK
          .
       ELSE
          SUM_A=ALG:LBER
       .
    ELSE
       SUM_A=0
    .
 OF 3                                          !ATVIEGLOJUMI PAR INV,PRP
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P > 0
       EXECUTE ALG:INV_P
          SUM_A=ALP:AT_INV1
          SUM_A=ALP:AT_INV2
          SUM_A=ALP:AT_INV3
          SUM_A=ALP:AT_POLR
          SUM_A=ALP:AT_POLRNP
       .
       IF ~ALG:LINV OR REQ
          IF ~(S1#=S2#)
             SUM_A=SUM_A*S1#/S2#
          .
       ELSE
          SUM_A=ALG:LINV
       .
    ELSE
       SUM_A=0
    .
 OF 4                                        !NEAPLIEKAMAIS MINIMUMS PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
 OROF 7                                      !NEAPLIEKAMAIS MINIMUMS PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P < 1   !AR D-GRÂM. & NAV INVALÎDS
       IF A_DIENAS
          IF ~(A_DIENAS=S2#)
             SUM_A=ALP:MIA*A_DIENAS/S2#
          ELSE
             SUM_A=ALP:MIA
          .
       ELSE
          SUM_A=0
       .
    ELSE
       SUM_A=0
    .
 OF 5                                          !ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
 OROF 8                                        !ATVIEGLOJUMI PAR APGÂDÂJAMAJIEM PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
    IF INSTRING(ALG:STATUSS,'13')
       IF A_DIENAS
          IF ~(A_DIENAS=S2#)
             SUM_A=ALP:APGADSUM*ALG:APGAD_SK*A_DIENAS/S2#
          ELSE
             SUM_A=ALP:APGADSUM*ALG:APGAD_SK
          .
       ELSE
          SUM_A=0
       .
    ELSE
       SUM_A=0
    .
 OF 6                                          !ATVIEGLOJUMI PAR INV PAR ATVAÏINÂJUMU,SLILAPU NÂKOÐAJÂ MÇNESÎ
 OROF 9                                        !ATVIEGLOJUMI PAR INV PAR ATVAÏINÂJUMU AIZNÂKOÐAJÂ MÇNESÎ
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P > 0
       EXECUTE ALG:INV_P
          SUM_A=ALP:AT_INV1
          SUM_A=ALP:AT_INV2
          SUM_A=ALP:AT_INV3
          SUM_A=ALP:AT_POLR
          SUM_A=ALP:AT_POLRNP
       .
       IF A_DIENAS
          IF ~(A_DIENAS=S2#)
             SUM_A=SUM_A*A_DIENAS/S2#
          .
       ELSE
          SUM_A=0
       .
    ELSE
       SUM_A=0
    .
 .
 CAL::USED-=1
 IF CAL::USED=0 THEN CLOSE(cal).

 RETURN(SUM_A)

GETDAIEV             FUNCTION (DAI_KODS,REQ,RET)  ! Declare Procedure
IV      STRING(60)
  CODE                                            ! Begin processed code
!
!  RET=8  IENÂK.VEIDA KODS NO DAIEV
!     =9  IENÂK.VEIDA NOSAUKUMS NO IENÂK.VEIDA KODA 
!     =10 IENÂK.VEIDA tips no DAIEV
!
!
!

  IF ~INRANGE(RET,1,10)
     RETURN('')
  .
  IF RET<=10
     IF DAIEV::USED=0
        CHECKOPEN(DAIEV,1)
     .
     DAIEV::USED+=1
     CLEAR(DAI:RECORD)
     DAI:KODS=DAI_KODS
     GET(DAIEV,DAI:KOD_KEY)
     IF ERROR()
        RET=0
        IF REQ=2 AND DAI_KODS
!           kluda(60,DAI_KODS&' '&FORMAT(ALG:YYYYMM,@D014.B))
           kluda(60,DAI_KODS&' '&FORMAT(ALG:YYYYMM,@D014.B)&GETKADRI(ALG:ID,0,1))
        .
     .
     DAIEV::USED-=1
     IF DAIEV::USED=0 THEN CLOSE(DAIEV).
     IF ~DAI:IENAK_VEIDS THEN DAI:IENAK_VEIDS=1.
  .
  EXECUTE(RET+1)
     RETURN('')             !0
     RETURN(DAI:NOSAUKUMS)  !1
     RETURN(DAI:T)          !2
     RETURN(DAI:DKK)        !3
     RETURN(DAI:KKK)        !4
     RETURN(DAI:ALGA)       !5
     RETURN(DAI:NODALA)     !6
     RETURN(DAI:VIDYN)      !7
     RETURN(FORMAT(DAI:IENAK_VEIDS,@N_4B)) !8 IVK
     BEGIN                  !9
!        I#=INSTRING(FORMAT(DAI:IENAK_VEIDS,@N02),'0103040607080910111213141617181920262932333435',2)
        I#=DAI:IENAK_VEIDS-1000
        DO FILLIV
        IV=IV[6:60]
        RETURN(IV)          !IENAK_VEIDA TEKSTS
     .
     RETURN(DAI:F)          !10
  .

FILLIV  ROUTINE
  EXECUTE I#
     IV='1OO1-Darba alga'
     IV=''
     IV='1OO3-Ienâkumi no intelektuâlâ îpaðuma'
     IV='1OO4-Metâllûþòu pârdoðanas ienâkumi'
     IV=''
     IV='1OO6-Ienâkumi no nekustamâ îpðuma izmantoðanas'
     IV='1OO7-Ienâkumi no citas saimnieciskâs darbîbas'
     IV='1OO8-Ienâkumi no uzòçmuma lîguma'
     IV='1OO9-Ienâkumi no kustamâ îpðuma izmantoðanas'
     IV='1O1O-Ienâkumi no kokmateriâlu un augoða meþa atsavinâðanas'
     IV='1O11-Dividendes'
     IV='1O12-Mantojuma rezultâtâ gûtais ienâkums'
     IV='1O13-Preèu pârdoðana (likuma "Par IIN" 9.panta I d.19.p.a-apakðpunkts)'
     IV='1O14-No juridiskâs personas saòemtais dâvinâjums'
     IV=''
     IV='1O16-Stipendijas'
     IV='1O17-Apdroðinâðanas atlîdzîba'
     IV='1O18-Ienâkumi no pienâkumu pildîðanas padomç vai valdç'
     IV='1O19-Procenti'
     IV='1O20-Citi ar nodokli apliekamie ienâkumi, no kuriem nodokli ietur izmaksas vietâ'
     IV=''
     IV=''
     IV=''
     IV=''
     IV=''
     IV='1O26-Papildpensijas kapitâls, as veidojas no DD veiktajâm iemaksâm PPF'
     IV=''
     IV=''
     IV='1O29-Izloþu un azartspçïu laimesti, kuri pârsniedz 500 Ls (izòemot preèu un pak. laim.)'
     IV=''
     IV=''
     IV='1O32-Atlîdzîba, kuru izmaksâ sagâdes u.c. organiz. par medîjumiem u.c. savvaïas produkc.'
     IV='1O33-Slimîbas pabalsti (B-daïa)'
     IV='1O34-Vecuma pensija'
     IV='1O35-Invaliditâtes pensija'
  .
