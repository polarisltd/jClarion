                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetFinG              FUNCTION (OPC,<T_GD>,<T_S_DAT>,<T_B_DAT>) ! Declare Procedure
MENESI          STRING(10)
DB_MENESI       BYTE
TEXT            STRING(35)
  CODE                                            ! Begin processed code
!
! <T_GD>   : GADS vai DOK_DATUMS
! <T_S_DAT>: DB S_DAT ????????????????????????VAI MAX MÇN_SK
! <T_B_DAT>: DB B_DAT
! OPC    : 1-ATGRIEÞ TEKSTU SDAT-BDAT MM MENESI
!          2-GL:DB_B_DAT
!          3-T_GD(DATUMS) VAI S/B_DAT JA ATÐÍIRÂS
!          4-MÇNEÐU SKAITS ÐAJÂ FIN_G
!          5-S_DAT VAI DB_S_DAT
!          6-T_GD(DATUMS) VAI DB_B_DAT JA LIELÂKS
!
 IF INRANGE(OPC,1,6)
    IF T_GD=DB_GADS OR ~T_GD OR OPC=3 OR OPC=6
       IF ~T_S_DAT THEN T_S_DAT=DB_S_DAT.
       IF ~T_B_DAT THEN T_B_DAT=DB_B_DAT.
       MENESI=AGE(T_S_DAT,T_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
       DB_MENESI=MENESI[1:2]         !LOCAL
       TEXT='FG: '&FORMAT(T_S_DAT,@D06.)&'-'&FORMAT(T_B_DAT,@D06.)&' '&DB_MENESI&' mçneði'
    ELSE
       DB_MENESI=12
       TEXT=''
    .
    EXECUTE OPC
       RETURN(TEXT)        !1
       RETURN(DB_B_DAT)    !2
       BEGIN               !3
          IF INRANGE(T_GD,T_S_DAT,T_B_DAT)
             RETURN(T_GD)
          ELSIF T_GD > T_B_DAT
             KLUDA(0,'DB paredzçta dokumentiem '&FORMAT(T_S_DAT,@D06.)&'-'&FORMAT(T_B_DAT,@D06.)&|
             '.Prasiet sys_admin. izveidot jaunu DB...',,1)
             RETURN(T_B_DAT)
          ELSE ! T_GD < T_S_DAT
             KLUDA(0,'DB paredzçta dokumentiem '&FORMAT(T_S_DAT,@D06.)&'-'&FORMAT(T_B_DAT,@D06.),,1)
             RETURN(T_S_DAT)
          .
       .
       RETURN(DB_MENESI)   !4
       BEGIN               !5
          LOOP
             IF DB_MENESI>12
                T_S_DAT=DATE(MONTH(T_S_DAT)+1,1,YEAR(T_S_DAT))
                MENESI=AGE(T_S_DAT,T_B_DAT+1) !VIÒÐ RÇÍINA, NEIESKAITOT
                DB_MENESI=MENESI[1:2]         !LOCAL
             ELSE
                BREAK
             .
          .
          RETURN(T_S_DAT)
       .
       BEGIN               !6
          IF T_GD > T_B_DAT
             KLUDA(0,'DB paredzçta dokumentiem '&FORMAT(T_S_DAT,@D06.)&'-'&FORMAT(T_B_DAT,@D06.)&|
             '.Prasiet sys_admin. izveidot jaunu DB...',,1)
             RETURN(T_B_DAT)
          ELSE
             RETURN(T_GD)
          .
       .
    .
 ELSE
    KLUDA(0,'GETFING IZSAUKUMS: OPC='&OPC)
 .

GetUDL               PROCEDURE (AUD_DATUMS)       ! Declare Procedure
  CODE                                            ! Begin processed code
!IF CL_NR=1033  ! ÍÎPSALA
!   EXECUTE AUD_DATUMS%7+1
!      UDL_S =DEFORMAT('00:00',@T1) !  'Svçtdiena'
!      UDL_S =DEFORMAT('08:00',@T1) !  'Pirmdiena'
!      UDL_S =DEFORMAT('08:00',@T1) !  'Otrdiena'
!      UDL_S =DEFORMAT('08:00',@T1) !  'Treðdiena'
!      UDL_S =DEFORMAT('08:00',@T1) !  'Ceturtdiena'
!      UDL_S =DEFORMAT('08:00',@T1) !  'Piektdiena'
!      UDL_S =DEFORMAT('09:00',@T1) !  'Sestdiena'
!   .
!   EXECUTE AUD_DATUMS%7+1
!      UDL_B =DEFORMAT('00:00',@T1) !  'Svçtdiena'
!      UDL_B =DEFORMAT('18:00',@T1) !  'Pirmdiena'
!      UDL_B =DEFORMAT('18:00',@T1) !  'Otrdiena'
!      UDL_B =DEFORMAT('18:00',@T1) !  'Treðdiena'
!      UDL_B =DEFORMAT('18:00',@T1) !  'Ceturtdiena'
!      UDL_B =DEFORMAT('18:00',@T1) !  'Piektdiena'
!      UDL_B =DEFORMAT('17:00',@T1) !  'Sestdiena'
!   .
!ELSE

   EXECUTE AUD_DATUMS%7+1
      UDL_S =SYS:UDL_7S !  'Svçtdiena'
      UDL_S =SYS:UDL_S  !  'Pirmdiena'
      UDL_S =SYS:UDL_S  !  'Otrdiena'
      UDL_S =SYS:UDL_S  !  'Treðdiena'
      UDL_S =SYS:UDL_S  !  'Ceturtdiena'
      UDL_S =SYS:UDL_S  !  'Piektdiena'
      UDL_S =SYS:UDL_6S !  'Sestdiena'
   .
   EXECUTE AUD_DATUMS%7+1
      UDL_B =SYS:UDL_7B !  'Svçtdiena'
      UDL_B =SYS:UDL_B  !  'Pirmdiena'
      UDL_B =SYS:UDL_B  !  'Otrdiena'
      UDL_B =SYS:UDL_B  !  'Treðdiena'
      UDL_B =SYS:UDL_B  !  'Ceturtdiena'
      UDL_B =SYS:UDL_B  !  'Piektdiena'
      UDL_B =SYS:UDL_6B !  'Sestdiena'
   .
W_INET               FUNCTION (OPC,NOM_NOMENKLAT) ! Declare Procedure
ATLIKUMS        DECIMAL(11,3)
ATLIKUMS2       DECIMAL(11,3)
  CODE                                            ! Begin processed code
!
! OPC: 1-NO ATLIKUMI(),SELFTESTA
!      2-NO BROWÐA,ATVÇRTS
! ATGRIEÞ: 1-OK
!          0-~OK
!
 IF ~(BAND(REG_NOL_ACC,01000000b) OR ACC_KODS_N=0) !I-NETS
    RETURN(0)
 .
 IF OPC=1 !NO ATLIKUMI(),SELFTESTA
    ANSIFILENAME=CLIP(LONGPATH())&'\INET\NOM_K.TXT'
    IF ~OPENANSI(ANSIFILENAME,2) !SHARED,RET=1=OK
       RETURN(0)
    .
    IF ~GETNOM_K(NOM_NOMENKLAT,0,1)
       CLOSE(OUTFILEANSI)
       RETURN(0)
    .
 .

 IF ~BYTES(OUTFILEANSI)
    IF CL_NR=1493 !RÎGAS BÛVMATERIÂLI
       OUTA:LINE='Nomenklatûra'&CHR(9)&'Mçrvienîba'&CHR(9)&'Nosaukums'&CHR(9)&'Cena (5)'&CHR(9)&|
       'Pçdçjâ iep.cena'&CHR(9)&'Atlikums'
    ELSIF CL_NR=1479 OR| !SANTEKO
          CL_NR=1033 OR| !SAIMNIEKS-SERVISS
          CL_NR=1734     !INSBERGS
       OUTA:LINE='Kods'&CHR(9)&'Nosaukums'&CHR(9)&'NosaukumsA'&CHR(9)&|
       'Nomenklatûra'&CHR(9)&'Grupa'&CHR(9)&'Gr.nos.'&CHR(9)&'Apakðgr.'&CHR(9)&'Agr.nos.'&CHR(9)&|
       'Cena('&NOKL_CP&')'&CHR(9)&'Atlikums'&CHR(9)&'Mçrvienîba'
    ELSIF CL_NR=1464 OR|  !AUTO ÎLE
          CL_NR=1102      !AD REM
!          ACC_KODS_N=0    !ASSAKO
       OUTA:LINE='Raþotâja kods'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&'Cena('&NOKL_CP&')'&|
       CHR(9)&'Atlikums(1)'&CHR(9)&'Atlikums(2)'&CHR(9)&'DG'
    ELSE 
       OUTA:LINE='Kods'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&|
       'Nomenklatûra'&CHR(9)&'Grupa'&CHR(9)&'Gr.nos.'&CHR(9)&'Apakðgr.'&CHR(9)&'Agr.nos.'&CHR(9)&|
       'Cena('&NOKL_CP&')'&CHR(9)&'Atlikums'
    .
    ADD(OUTFILEANSI)
 .

 IF (NOM:REDZAMIBA=0 OR NOM:REDZAMIBA=2 OR NOM:REDZAMIBA=3) AND| !AKTÎVAS & NÂKOTNES & LIKVIDÇJAMAS
 ~CYCLENOM(NOM:NOMENKLAT)
    IF CL_NR=1493         !RÎGAS BÛVMATERIÂLI
       ATLIKUMS=GETNOM_A(NOM_NOMENKLAT,5,0) !5-ATLIKUMS KOPÂ
       OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:MERVIEN&CHR(9)&NOM:NOS_P&CHR(9)&FORMAT(NOM:REALIZ[5],@N_8.2)&CHR(9)&|
       FORMAT(NOM:PIC,@N_8.2)&CHR(9)&FORMAT(ATLIKUMS,@N-_10.2)
    ELSIF CL_NR=1479 OR|  !SANTEKO
          CL_NR=1033 OR|  !SAIMNIEKS-SERVISS
          CL_NR=1734      !INSBERGS
       ATLIKUMS=GETNOM_A(NOM_NOMENKLAT,5,0) !5-ATLIKUMS KOPÂ
       OUTA:LINE=FORMAT(NOM:KODS,@N_13)&CHR(9)&NOM:NOS_P&CHR(9)&GETNOM_VALODA(NOM:NOMENKLAT,3)&CHR(9)&|
       NOM:NOMENKLAT&CHR(9)&NOM:NOMENKLAT[1:3]&CHR(9)&GETGRUPA(NOM:NOMENKLAT[1:3],0,1)&CHR(9)&NOM:NOMENKLAT[4]&|
       CHR(9)&GETGRUPA2(NOM:NOMENKLAT[1:4],0,1)&CHR(9)&FORMAT(NOM:REALIZ[NOKL_CP],@N_8.2)&CHR(9)&|
       FORMAT(ATLIKUMS,@N-_10.2)&CHR(9)&NOM:MERVIEN
    ELSIF CL_NR=1464 OR|  !AUTO ÎLE
          CL_NR=1102      !AD REM
!          ACC_KODS_N=0    !ASSAKO
       IF ~(NOM:NOMENKLAT[1:2]='OR')
          IF OPC=1 THEN CLOSE(OUTFILEANSI). !NO ATLIKUMI(),SELFTESTA
          RETURN(0)
       ELSE
          ATLIKUMS =GETNOM_A(NOM_NOMENKLAT,3,0,1) !3-ATLIKUMS-P 1.NOLIK.
          ATLIKUMS2=GETNOM_A(NOM_NOMENKLAT,3,0,2) !3-ATLIKUMS-P 2.NOLIK.
          OUTA:LINE=NOM:KATALOGA_NR&CHR(9)&NOM:NOMENKLAT&CHR(9)&NOM:NOS_P&CHR(9)&LEFT(FORMAT(NOM:REALIZ[NOKL_CP],@N_8.2))&|
          CHR(9)&LEFT(FORMAT(ATLIKUMS,@N-_10.2))&CHR(9)&LEFT(FORMAT(ATLIKUMS2,@N-_10.2))&CHR(9)&NOM:DG
       .
    ELSE
       ATLIKUMS=GETNOM_A(NOM_NOMENKLAT,5,0) !5-ATLIKUMS KOPÂ
       OUTA:LINE=FORMAT(NOM:KODS,@N_13)&CHR(9)&NOM:NOS_P&CHR(9)&CHR(9)&|
       NOM:NOMENKLAT&CHR(9)&NOM:NOMENKLAT[1:3]&CHR(9)&GETGRUPA(NOM:NOMENKLAT[1:3],0,1)&CHR(9)&NOM:NOMENKLAT[4]&|
       CHR(9)&GETGRUPA2(NOM:NOMENKLAT[1:4],0,1)&CHR(9)&FORMAT(NOM:REALIZ[NOKL_CP],@N_8.3)&CHR(9)&|
       FORMAT(ATLIKUMS,@N-_10.2)
    .
    ADD(OUTFILEANSI)
    IF OPC=1 THEN CLOSE(OUTFILEANSI). !NO ATLIKUMI(),SELFTESTA
    RETURN(1)
 ELSE
    IF OPC=1 THEN CLOSE(OUTFILEANSI). !NO ATLIKUMI(),SELFTESTA
    RETURN(0)
 .
