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
!  1-ALGA BEZ SOCI�LAJIEM,ATV,SLILAPAS
!  2-SOCI�LIE PABALSTI
!  3-SLILAPAS
!  4-ATVA�IN�JUMI UN ATVA�IN�JUMU NAUDAS
!  5-NODOK�I �aj�,n�kamajos un pag�ju�ajos m�ne�os
!  6-DARBA ��M�JA SOCI�LAIS NODOKLIS
!  7-IZPILDRAKSTS                                    >=912T=2
!  8-CITI IETUR�JUMI(1)                              >=912T=1
!  9-AVANSS                                           =904
! 10-P�RMAKSA/PAR�DS                                  =905
! 11-IZMAKS�T UZ ROKAS
! 12-LAIKA DARBA ALGA
! 13-GABALDARBA ALGA
! 14-PR�MIJAS
! 15-PIEMAKSAS PAR BR�VDIEN�M UN NAKTSSTUND�M
! 16-CITAS PIEMAKSAS(1)                               T=5
! 17-ALGA KOP� PAMATDARBINIEKIEM (BEZ ATV.n�k. & aizn�k.m., BEZ SLILAPAS) F(97)
! 18-ALGA KOP� SAVIETOT�JIEM (BEZ ATV.n�k. & aizn�k.m., BEZ SLILAPAS) F(97)
! 19-ALGA KOP� (BEZ ATV.n�k. & aizn�k.m., BEZ SLILAPAS) F(97)
! 20-PIESKAIT�JUMI NO SOC-L�DZEK�IEM KOP�
! 21-ATVA�IN�JUMI N�KAMAJOS M�NE�OS
! 22-NODOK�U PAMATLIKME �aj� m�nes�
! 23-NODOK�U PAPILDLIKME �aj� m�nes�
! 24-�RK�RTAS IZMAKSAS                               >=912T=3
! 25-PAR�DI PAR IEPRIEK��JO M�NESI
! 26-IEN�KUMA NODOKLIS par n�ko�o m�nesi
! 27-IEN�KUMA NODOKLIS par aizn�ko�o m�nesi
! 28-IETUR�JUMI KOP�
! 29-CITAS PIEMAKSAS(2)                               T=6
! 30-ATVA�IN�JUMI �AJ� M�NES�
! 31-ALGA ADMINISTR�CIJAI(BEZ ATV N�K.M. BEZ SOC) F(97)
! 32-ALGA STR�DNIEKIEM   (BEZ ATV N�K.M. BEZ SOC) F(97)
! 33-PIESKAIT�JUMI KOP�
! 34-NOSTR�D�T�S STUNDAS
! 35-BRUTO IE��MUMI
! 36-IZMAKS�T (BEZ SOCI�LAJIEM PABALSTIEM)
! 37-NEAPLIEKAMAIS MINIMUMS F(A,97) !P�RR��INS, TAS, KO LIETOJAM APR��INIEM
! 38-ATVIEGLOJUMI PAR APG�D�JAMAJIEM F(97)
! 39-ATVIEGLOJUMI PAR INVALIDIT�TI+PRP F(97) ???????????????????
! 40-IEN�KUMS, NO KURA R��INA SOCI�LOS F(97)
! 41-SLILAPAS IEPRIEK��JOS M�NE�OS
! 42-IENNODOKLIS PAR IEPRIEK��JIEM M�NE�IEM
! 43-APR��IN�T� ALGA KOP� PRIEK� SOCI�LAJIEM PAR �O M�NESI F(97)
! 44-APR��IN�TAIS ATVA�IN�JUMS PAR �O M�NESI, IZMAKS�TS PAG�JU�AJ� M�NES�
! 45-APR��IN�TAIS ATVA�IN�JUMS PAR �O M�NESI, IZMAKS�TS AIZPAG�JU�AJ� M�NES�
! 46-ATVA�IN�JUMI N�K,AIZN�K.M. PAMATDARBINIEKIEM
! 47-ATVA�IN�JUMI N�K,AIZN�K.M. SAVIETOT�JIEM
! 48-ATVA�IN�JUMI N�K,AIZN�K.M. ADMINISTR�CIJAI
! 49-ATVA�IN�JUMI N�K,AIZN�K.M. STR�DNIEKIEM
! 50-ATVIEGLOJUMI POLITISKI REPRES�T�M PERSON�M
! 51-ATVIEGLOJUMI PAR INVALIDIT�TI
! 52-MAX STUNDAS
! 53-NEAPLIEKAMIE IE��MUMI
! 54-IEN�KUMS, KAS APLIKTS AR IEN.NODOKLI PAR �O M�NESI
! 55-CITI IETUR�JUMI(2)                              >=912T=6
! 56-P�RSKAIT�JUMS UZ KARTI(BIJ.CITI IETUR�JUMI(3))                              >=912T=7
! 57-D�vanas u.c. neapliekamie                            T=9
! 58-SLILAPAS �AJ� & IEPR.M�N.
! 59-SLILAPAS N�K.M�N.
! 60-DARBA ��M�JA SOCI�LAIS  NODOKLIS par �O m�nesi
! 61-DARBA ��M�JA SOCI�LAIS  NODOKLIS par n�k. un aizn. m�ne�iem
! 62-SLILAPA PAR �O M�NESI, IZMAKS�TA PAG�JU�AJ� M�NES�
! 63-SLILAPA N�K.M. PAMATDARBINIEKIEM
! 64-SLILAPA N�K.M. SAVIETOT�JIEM
! 65-SLILAPA N�K.M. ADMINISTR�CIJAI
! 66-SLILAPA N�K.M. STR�DNIEKIEM
!

  SAV_ALP=ALP:RECORD  ! ATSKAIT� VAR B�T VAJADZ�GAS V�RT�BAS
  IF ALGPA::USED=0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::USED+=1

  CASE OPC
  OF 1                ! ALGA BEZ SOCI�LAJIEM,ATV,SLILAPAS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879 !NO 880 ATKAL S�KAS PIESKAIT�JUMI
          SU+=ALG:R[I#]
       .
    .
  OF 2                      !SOCI�LIE BEZ SLILAPAS
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
  OF 4                      !ATVA�IN�JUMI KOP� (�,N,AN)
    LOOP I#=1 TO 20
       IF INRANGE(ALG:K[I#],840,845)
            SU+=ALG:R[I#]
       .
    .
  OF 5                      !NODOK�I SAJ�, N�kamajos & PAG.M�ne�os
     LOOP I#=1 TO 15
        IF INRANGE(ALG:I[I#],901,902) OR INRANGE(ALG:I[I#],906,909)
           SU+=ALG:N[I#]
        .
     .
  OF 6                      !DARBA ��M�JA SOCI�LAIS  NODOKLIS par �o, n�k un aizn. m�ne�iem
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
  OF 10                     !P�rmaksa/par�ds
     LOOP I#=1 TO 15
        IF ALG:I[I#]=905
           SU+=ALG:N[I#]
        .
     .
  OF 11                     !IZMAKS�T UZ ROKAS
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
  OF 14                     !PR�MIJAS
    LOOP I#=1 TO 20
       IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
          IF getdaiev(alg:K[I#],0,2)='3'
             SU+=ALG:R[I#]
          .
       .
    .
  OF 15                     !PIEMAKSA PAR BR�VDIEN�M & NS
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
  OF 17                     !ALGA KOP� (PIE-ATVN-ATVAN-SOC) PAMATDARBINIEKIEM
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
  OF 18                     !ALGA KOP� SAVIETOT�JIEM
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
  OF 19                     !ALGA KOP�
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
  OF 20                     !SOC-PIESKAIT�JUMI KOP�
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
  OF 21                     !ATVA�IN�JUMI N�KAMAJOS M�NE�OS
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
             SU+=ALG:R[I#]
        .
     .
  OF 22                     !NODOK�A PAMATLIKME
     LOOP I#=1 TO 15
        IF ALG:I[I#]=901
           SU+=ALG:N[I#]
        .
     .
  OF 23                     !NODOK�A PAPILDLIKME
     LOOP I#=1 TO 15
        IF ALG:I[I#]=902
           SU+=ALG:N[I#]
        .
     .
  OF 24                     !�RK�RTAS IZMAKSAS
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF GETDAIEV(ALG:I[I#],0,2)='3'
              SU+=ALG:N[I#]
           .
        .
     .
  OF 25                     !P�RMAKSA/PAR�DS NO IEPR.M�N.
     LOOP I#=1 TO 15
        IF ALG:I[I#]=905
           SU+=ALG:N[I#]
        .
     .
  OF 26                     !NODOKLI n�kamaj� m�nes�
     LOOP I#=1 TO 15
        IF ALG:I[I#]=908
           SU+=ALG:N[I#]
        .
     .
  OF 27                     !NODOKLI aizn�kamaj� m�nes�
     LOOP I#=1 TO 15
        IF ALG:I[I#]=909
           SU+=ALG:N[I#]
        .
     .
  OF 28                     !IETUR�JUMI KOP�
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
  OF 30                     !ATVA�IN�JUMU naudas �AJ� M�NES�
     LOOP I#=1 TO 20
        IF ALG:K[I#]=840 OR INRANGE(ALG:K[I#],843,845)
             SU+=ALG:R[I#]
        .
     .
  OF 31                     !ALGA KOP� ADMINISTR�CIJAI BEZ ATV.N�K.M.BEZ SOC.
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
  OF 32                     !ALGA KOP� STR�DNIEKIEM BEZ ATV.N�K.M.BEZ SOC.
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
  OF 33                     !PIESKAIT�JUMI KOPA
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],1,899)
           SU+=ALG:R[I#]
        .
     .
!  OF 34                     !NOSTR�D�T�S STUNDAS KOP�
  OF 34                     !NOSTR�D�T�S STUNDAS KOP� NO FAILA
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
  OF 35                     !BRUTO IE��MUMS
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
  OF 36                     !IZMAKS�T (BEZ SOCI�LAJIEM PABALSTIEM)
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
     MIA=CALCNEA(1,0,0) !(OPC,REQ,A_DIENAS) NEAPL.MIN �AJ� M�NES�
     CASE ALG:STATUSS
     OF '1'
     OROF '3'
        LOOP I#=1 TO 20
           IF YEAR(ALG:YYYYMM)<1997
              IF ALG:K[I#]<850 AND ~INRANGE(ALG:K[I#],841,842)
                 SU+=ALG:R[I#]
              .
           ELSE
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCI�LAIS PAB & NAV ATV.N�K.M.
                 SU+=ALG:R[I#]
              .
           .
        .
        SAVERECORD=ALG:RECORD
        ALG:YYYYMM=DATE(MONTH(SAV:YYYYMM)+11,1,YEAR(SAV:YYYYMM)-1)  !LAI DAB�TU 1 M�NESI ATPAKA�
!    STOP(FORMAT(ALG:YYYYMM,@D6)&' 841')
        ALG:ID=SAV:ID
        GET(ALGAS,ALG:ID_KEY)
        IF ~ERROR()
           LOOP I#=1 TO 20
              IF ALG:K[I#] = 841 !ATV.N�K.M
                 SU+=ALG:R[I#]
              .
           .
        .
        ALG:YYYYMM=DATE(MONTH(SAV:YYYYMM)+10,1,YEAR(SAV:YYYYMM)-1)  !LAI DAB�TU 2 M�NE�US ATPAKA�
!   STOP(FORMAT(ALG:YYYYMM,@D6)&' 841')
        ALG:ID=SAV:ID
        GET(ALGAS,ALG:ID_KEY)
        IF ~ERROR()
           LOOP I#=1 TO 20
              IF ALG:K[I#] = 842 !ATV.AIZN�K.M
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
  OF 38                     !ATVIEGLOJUMI PAR APG�D�JAMIEM
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
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCI�LAIS PAB & NAV ATV.N�K.M.
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
  OF 39                     !ATVIEGLOJUMI PAR INVALIDIT�TI +PRP
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
              IF ~(ALG:K[I#]=860) AND ~INRANGE(ALG:K[I#],841,842) !NAV SOCI�LAIS PAB & NAV ATV.N�K.M.
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
  OF 40                     !ALGA KOP� NO KURAS R��INA SOCI�LOS
     LOOP I#=1 TO 20
        IF ALG:K[I#] <= 849 OR ALG:K[I#] > 860 OR (ALG:K[I#] <= 859 AND YEAR(ALG:YYYYMM)>=1997)
           IF getdaiev(ALG:K[I#],2,1) AND dai:SOCYN='Y'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 41                     !SLILAPAS IEPRIEK��JOS M�NE�OS
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],851,852)
             SU+=ALG:R[I#]
        .
     .
  OF 42                     !iennodoklis par pag�ju�ajiem m�ne�iem
     LOOP I#=1 TO 15
        IF INRANGE(ALG:I[I#],906,907)
           SU+=ALG:N[I#]
        .
     .
  OF 43                     !APR��IN�T� ALGA KOP� PRIEK� SOCI�LAJIEM PAR �O M�NESI
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
  OF 44                     !APR��IN�TAIS ATVA�IN�JUMS, IZMAKS�TS PAG�JU�AJ� M�NES�
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)  !LAI DAB�TU 1 M�NESI ATPAKA�
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
  OF 45                     !APR��IN�TAIS ATVA�IN�JUMS, IZMAKS�TS AIZPAG�JU�AJ� M�NES�
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+10,1,YEAR(ALG:YYYYMM)-1)  !LAI DAB�TU 2 M�NE�US ATPAKA�
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
  OF 46                     !ATVA�IN�JUMI N�K,AIZN�K.M. PAMATDARBINIEKIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS='1' or ALG:STATUSS='3'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 47                     !ATVA�IN�JUMI N�K,AIZN�K.M. SAVIETOT�JIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS='2' or ALG:STATUSS='4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 48                     !ATVA�IN�JUMI N�K,AIZN�K.M. ADMINISTR�CIJAI
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 49                     !ATVA�IN�JUMI N�K,AIZN�K.M. STR�DNIEKIEM
     LOOP I#=1 TO 20
        IF INRANGE(ALG:K[I#],841,842)
           IF ALG:STATUSS = '3' OR  ALG:STATUSS = '4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 50                     !ATVIEGLOJUMI INVAL�DIEM
     IF INSTRING(ALG:STATUSS,'13') AND INRANGE(ALG:INV_P,'1','3')  !AR D.GR�MATI�U
        IF ~(ALG:YYYYMM=ALP:YYYYMM)
           ALP:YYYYMM=ALG:YYYYMM
           GET(ALGPA,ALP:YYYYMM_KEY)
           IF ERROR() THEN STOP('PARSK '&ERROR()).
        .
        SU=CALCNEA(3,0,0)
     ELSE
        SU=0
     .
  OF 51                     !ATVIEGLOJUMI POLITISKI REPRES�T�M PERSON�M
     IF INSTRING(ALG:STATUSS,'13') AND INRANGE(ALG:INV_P,'4','5')  !AR D.GR�MATI�U
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
  OF 53                     !NEAPLIEKAMAIE IE��MUMI
     LOOP I#=1 TO 20
        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
           IF getdaiev(ALG:K[I#],2,1) AND dai:IENYN='N'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 54                     !IEN�KUMS, KAS APLIKTS AR IEN�KUMA NODOKLI PAR �O M�NESI
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
  OF 56                      !P�RSKAIT�JUMS UZ KARTI(BIJ.CITI ATVILKUMI(3))
     LOOP I#=1 TO 15
        IF ALG:I[I#]>=912
           IF getdaiev(alg:I[I#],0,2)='7'
             SU+=ALG:N[I#]
           .
        .
     .
  OF 57                     !D�vanas u.c neapliekamie
     LOOP I#=1 TO 20
        IF ALG:K[I#] < 840 OR INRANGE(ALG:K[I#],846,849) OR ALG:K[I#] > 879
           IF getdaiev(alg:K[I#],0,2)='9'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 58                      ! SLILAPAS �AJ� & PAG.M�N.
    LOOP I#=1 TO 20
       IF INRANGE(ALG:K[I#],850,859) AND ~(ALG:K[I#]=852)
          SU+=ALG:R[I#]
       .
    .
  OF 59                      ! SLILAPAS N�K.M�N.
    LOOP I#=1 TO 20
       IF ALG:K[I#]=852
          SU+=ALG:R[I#]
       .
    .
  OF 60                      !DARBA ��M�JA SOCI�LAIS  NODOKLIS par �O m�nesi
     LOOP I#=1 TO 15
        IF ALG:I[I#]=903
           SU+=ALG:N[I#]
        .
     .
  OF 61                      !DARBA ��M�JA SOCI�LAIS  NODOKLIS par n�k. un aizn. m�ne�iem
     LOOP I#=1 TO 15
        IF ALG:I[I#]=910 OR ALG:I[I#]=911
           SU+=ALG:N[I#]
        .
     .
  OF 62                      !APR��IN�T� SLILAPA PAR �O M�NESI, IZMAKS�TA PAG�JU�AJ� M�NES�
     SAVERECORD=ALG:RECORD
     ALG:YYYYMM=DATE(MONTH(ALG:YYYYMM)+11,1,YEAR(ALG:YYYYMM)-1)  !LAI DAB�TU 1 M�NESI ATPAKA�
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
  OF 63                     !SLILAPA N�K.M. PAMATDARBINIEKIEM
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS='1' or ALG:STATUSS='3'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 64                     !SLILAPA N�K.M. SAVIETOT�JIEM
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS='2' or ALG:STATUSS='4'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 65                     !SLILAPA N�K.M. ADMINISTR�CIJAI
     LOOP I#=1 TO 20
        IF ALG:K[I#]=852
           IF ALG:STATUSS = '1' OR  ALG:STATUSS = '2'
             SU+=ALG:R[I#]
           .
        .
     .
  OF 66                     !SLILAPA N�K.M. STR�DNIEKIEM
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
  ALP:RECORD=SAV_ALP  ! ATSKAIT� VAR B�T VAJADZ�GAS V�RT�BAS
  RETURN(SU)


CALCNEA              FUNCTION (OPC,REQ,A_DIENAS)  ! Declare Procedure
SUM_A      DECIMAL(10,2)
  CODE                                            ! Begin processed code
!
! REQ=1 OBLIG�TI J�P�RR��INA, PAT JA LOCKed
! AR �ITO SAR��INA RE�LO DARBALAIKU UN ATVIEGLOJUMUS TEKO�AJ� M�NES�
! UN ATVIEGLOJUMUS PAR N�K, AIZN�K ATVA�IN�JUMA DIEN�M
!
! OPC 1 NEAPLIEKAMAIS MINIMUMS
! OPC 2 ATVIEGLOJUMI PAR APG�D�JAMAJIEM
! OPC 3 ATVIEGLOJUMI PAR INV,PRP
! OPC 4 NEAPLIEKAMAIS MINIMUMS PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
! OPC 7 NEAPLIEKAMAIS MINIMUMS PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
! OPC 5 ATVIEGLOJUMI PAR APG�D�JAMAJIEM PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
! OPC 8 ATVIEGLOJUMI PAR APG�D�JAMAJIEM PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
! OPC 6 ATVIEGLOJUMI PAR INV PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
! OPC 9 ATVIEGLOJUMI PAR INV PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
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
    S2#=CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,8)  !KALDD+SE+SV   T� AR� J�B�T
 ELSIF INRANGE(OPC,4,6)
    S2#=CALCSTUNDAS(DATE(MONTH(ALG:YYYYMM)+1,1,YEAR(ALG:YYYYMM)),ALG:ID,0,0,8)  !KALDD+SE+SV
 ELSIF INRANGE(OPC,7,9)
    S2#=CALCSTUNDAS(DATE(MONTH(ALG:YYYYMM)+2,1,YEAR(ALG:YYYYMM)),ALG:ID,0,0,8)  !KALDD+SE+SV
 ELSE
    STOP('CALCNEA IZSAUKUMA K��DA.OPC='&OPC)
    RETURN(0)
 .

 CASE OPC
 OF 1                                        !NEAPLIEKAMAIS MINIMUMS
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P < 1   !AR D-GR�M. & NAV INVAL�DS
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
 OF 2                                          !ATVIEGLOJUMI PAR APG�D�JAMAJIEM
    IF INSTRING(ALG:STATUSS,'13')              !AR D-GR�MATI�U
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
 OF 4                                        !NEAPLIEKAMAIS MINIMUMS PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
 OROF 7                                      !NEAPLIEKAMAIS MINIMUMS PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
    IF INSTRING(ALG:STATUSS,'13') AND ALG:INV_P < 1   !AR D-GR�M. & NAV INVAL�DS
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
 OF 5                                          !ATVIEGLOJUMI PAR APG�D�JAMAJIEM PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
 OROF 8                                        !ATVIEGLOJUMI PAR APG�D�JAMAJIEM PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
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
 OF 6                                          !ATVIEGLOJUMI PAR INV PAR ATVA�IN�JUMU,SLILAPU N�KO�AJ� M�NES�
 OROF 9                                        !ATVIEGLOJUMI PAR INV PAR ATVA�IN�JUMU AIZN�KO�AJ� M�NES�
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
!  RET=8  IEN�K.VEIDA KODS NO DAIEV
!     =9  IEN�K.VEIDA NOSAUKUMS NO IEN�K.VEIDA KODA 
!     =10 IEN�K.VEIDA tips no DAIEV
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
     IV='1OO3-Ien�kumi no intelektu�l� �pa�uma'
     IV='1OO4-Met�ll���u p�rdo�anas ien�kumi'
     IV=''
     IV='1OO6-Ien�kumi no nekustam� �p�uma izmanto�anas'
     IV='1OO7-Ien�kumi no citas saimniecisk�s darb�bas'
     IV='1OO8-Ien�kumi no uz��muma l�guma'
     IV='1OO9-Ien�kumi no kustam� �p�uma izmanto�anas'
     IV='1O1O-Ien�kumi no kokmateri�lu un augo�a me�a atsavin��anas'
     IV='1O11-Dividendes'
     IV='1O12-Mantojuma rezult�t� g�tais ien�kums'
     IV='1O13-Pre�u p�rdo�ana (likuma "Par IIN" 9.panta I d.19.p.a-apak�punkts)'
     IV='1O14-No juridisk�s personas sa�emtais d�vin�jums'
     IV=''
     IV='1O16-Stipendijas'
     IV='1O17-Apdro�in��anas atl�dz�ba'
     IV='1O18-Ien�kumi no pien�kumu pild��anas padom� vai vald�'
     IV='1O19-Procenti'
     IV='1O20-Citi ar nodokli apliekamie ien�kumi, no kuriem nodokli ietur izmaksas viet�'
     IV=''
     IV=''
     IV=''
     IV=''
     IV=''
     IV='1O26-Papildpensijas kapit�ls, as veidojas no DD veiktaj�m iemaks�m PPF'
     IV=''
     IV=''
     IV='1O29-Izlo�u un azartsp��u laimesti, kuri p�rsniedz 500 Ls (iz�emot pre�u un pak. laim.)'
     IV=''
     IV=''
     IV='1O32-Atl�dz�ba, kuru izmaks� sag�des u.c. organiz. par med�jumiem u.c. savva�as produkc.'
     IV='1O33-Slim�bas pabalsti (B-da�a)'
     IV='1O34-Vecuma pensija'
     IV='1O35-Invalidit�tes pensija'
  .
