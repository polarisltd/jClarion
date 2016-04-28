                     MEMBER('winlats.clw')        ! This is a MEMBER module
getpar_k             FUNCTION (parnr,REQ,RET,<DOKDAT>,<RAZ_K>) ! Declare Procedure
PARTEX               CSTRING(20)
Auto::Save:PAR:U_NR  LIKE(PAR:U_NR)
PAR_END_U_NR         LIKE(PAR:U_NR)
NOKL_DC              BYTE
RAZ_KB               BYTE
  CODE                                            ! Begin processed code
 !
 !  PARNR - PIEPRAS�TAIS PARTNERA U_NR
 !  REQ - 0 ATGRIE� TUK�UMU UN NOT�RA RECORD,JA NAV
 !        1 IZSAUC BROWSE
 !        2 IZSAUC K��DU UN NOT�RA RECORD,JA NAV
 !        3 IZSAUC K��DU UN UZBV� RECORD,JA NAV
 !  RET - 1 ATGRIE� NOS_S
 !        2 ATGRIE� NOS_P
 !        3 ATGRIE� NOS_P vai PAV:NOKA
 !        4 ATGRIE� NOS_S vai GG:NOKA
 !        5 ATGRIE� NOS_S vai PAV:NOKA
 !        6 ATGRIE� NOS_P vai GG:NOKA
 !        7 ATGRIE� NOS_P vai ''
 !        8 ATGRIE� PAR:PVN_PASE[1:22] VAI PAR:KODS (�S� RE�ISTR�CIJA)
 !        9 ATGRIE� PAR:KODS UN LV.......... (GAR� RE�ISTR�CIJA)
 !       10 ATGRIE� NOS_U
 !    KN 11 ATGRIE� NOS_P, SA�EM KARTES NR
 !       12 ATGRIE� PAR:KODS (�S� RE�ISTR�CIJA BEZ LV)
 !       13 ATGRIE� [1:13](E) VAI PVN(CN) VAI NEKO
 !       14 ATGRIE� NOS_A (VIS�D�M TABUL�M)
 !       15 ATGRIE� PAR:GRUPA
 !       16 ATGRIE� PAR:FAX
 !       17 ATGRIE� PAR:TEL
 !    KN 18 ATGRIE� U_NR, SA�EM KARTES NR
 !       19 ATGRIE� V_KODS
 !       20 ATGRIE� PAR:TIPS
 !       21 ATGRIE� NMR: PAR:KODS UN PVN: LV........../######-#####/1:40 (RE�ISTR�CIJA P/Z)
 !       22 ATGRIE� PAR:KRED_LIM
 !       23 ATGRIE� PAR:LIGUMS1/PAR:LIGUMS2 K� F:LT
 !       24 ATGRIE� PAR:ADRESE
 !       25 ATGRIE� PAV:NOKA un NOS_S
 !       26 ATGRIE� PAR:LIGUMS2 ???????????????
 !       27 ATGRIE� PAR:NOKL_DC
 !    RK 28 ATGRIE� NOS_P, SA�EM RAZ_K
 !       29 ATGRIE� 1, JA IR DEFIN�TA ZEM RAZ_K PADOT� ATZ�ME
 !<DOKDAT> - LAI 27 VAR�TU SASKAIT�T BANKAS DIENAS
 !<RAZ_K>  - LAI 28 VAR�TU DAB�T NO RA�OT�JA KODA, 29 NODOD MEKL�JAM�S ATZ�MES Nr
 !
 !
 !

 IF ~INRANGE(RET,1,29)
    KLUDA(0,'GETPAR_K: Piepras�ts atgriezt '&RET)
    RETURN('')
 .
 IF (PARNR=0 AND REQ=0) OR PARNR=999999999
    RETURN('')
 .

 IF PAR_K::Used = 0
   CheckOpen(PAR_K,1) !IZSKAT�S, KA AR �ITO CLEAR(PAR:RECORD)
 .
 PAR_K::Used += 1

 IF RET=11 OR RET=18      !KARTE
    IF ~(PAR:KARTE=PARNR) !NAV JAU POZICION�TS
       PARTEX='Partnera Kartes Nr:'
       PAR:KARTE=PARNR
       GET(PAR_K,PAR:KARTE_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    .
 ELSIF RET=28             !NOS_U- RA�OT�JA KODS
    IF RAZ_K
       PARTEX='Partnera Ra�ot�ja kods:'
       PAR:NOS_U=RAZ_K
       GET(PAR_K,PAR:NOS_U_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    ELSE
    RETURN('')
    .
 ELSE
    IF ~(PAR:U_NR=PARNR) OR PARNR=0 !NAV JAU POZICION�TS VAI PIEPRAS�TS 0-TAIS
       PARTEX='Partnera U_nr:'
       PAR:U_NR=PARNR
       GET(PAR_K,PAR:NR_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    .
 .
 IF ERROR#=TRUE
    IF REQ = 2
       KLUDA(17,ParTex&CLIP(PARNR)&' '&CLIP(RAZ_K)&' '&ERROR())  !RAZ_K-STRING NOR�DE
       clear(par:record)
    ELSIF REQ = 3
       KLUDA(17,ParTex&CLIP(PARNR)&' ...B�V�JU ')
       SET(PAR:NR_KEY)
       PREVIOUS(PAR_K)
       IF ERRORCODE() AND ERRORCODE() <> BadRecErr
          StandardWarning(Warn:RecordFetchError,'PAR_K')
          POST(Event:CloseWindow)
          clear(par:record)
       .
       IF ERRORCODE()
          Auto::Save:PAR:U_NR = 1
       ELSE
          Auto::Save:PAR:U_NR = PAR:U_NR + 1
       .
       CLEAR(PAR:Record)
       PAR:U_NR = Auto::Save:PAR:U_NR
       PAR:KARTE=99999
       PAR:NOS_P='BANKSERVISS'
       PAR:NOS_S='BANKSERVISS'
       PAR:NOS_A='BANKSERVISS'
       ADD(PAR_K)
       PAR_END_U_NR=0
       PAR_END_U_NR=GETINIFILE('PAR_END_U_NR',0)
       IF INRANGE(PAR_END_U_NR-PAR:U_NR,1,10)
          KLUDA(45,'PAR_K autonumer�cijas apgabal� atliku�i '&PAR_END_U_NR-PAR:U_NR&' br�vi ieraksti')
       .
    ELSIF REQ = 0
       clear(par:record)
    ELSE
       globalrequest=Selectrecord
       BROWSEPAR_K
       IF GLOBALRESPONSE=REQUESTCOMPLETED
          IF RET=3 OR RET=6 OR RET=7 THEN RET=2.
          IF RET=4 OR RET=5 THEN RET=1.
       .
    .
 ELSIF ~(PARNR=0)
    IF RET=3 OR RET=6 OR RET=7 THEN RET=2.
    IF RET=4 OR RET=5 THEN RET=1.
 .
 PAR_K::Used -= 1
 IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
 EXECUTE RET
    RETURN(PAR:nos_s)      !1
    RETURN(PAR:nos_P)      !2
    RETURN(PAV:NOKA)       !3
    RETURN(GG:NOKA)        !4
    RETURN(PAV:NOKA)       !5
    RETURN(GG:NOKA)        !6
    RETURN('')             !7
    BEGIN                  !8 PVN (�s�) re�istr�cija
       IF PAR:PVN
          RETURN(PAR:PVN)
       ELSE
          RETURN(PAR:NMR_KODS)
       .
    .
    BEGIN                  !9 GAR� re�istr�cija
       IF PAR:TIPS = 'F'
          return('personas kods: '&CLIP(PAR:NMR_KODS)&' '&PAR:PVN)
       ELSE
          return(CLIP(PAR:NMR_KODS)&' '&PAR:PVN)
       .
    .
    RETURN(PAR:nos_U)      !10
    RETURN(PAR:nos_P)      !11
    RETURN(PAR:NMR_KODS)   !12 �s� re�istr�cija
    RETURN(PAR:PVN)        !13 PNV RE�ISTR�CIJAS Nr
    RETURN(PAR:nos_A)      !14
    RETURN(PAR:GRUPA)      !15
    RETURN(PAR:FAX)        !16
    RETURN(PAR:TEL)        !17
    RETURN(PAR:U_NR)       !18
    RETURN(PAR:V_KODS)     !19
    RETURN(PAR:TIPS)       !20
    BEGIN                  !21 RE�ISTR�CIJA P/Z
       IF PAR:TIPS = 'F'
          IF PAR:PVN  ! IR PVN MAKS�T�JS
             RETURN('P/K: '&CLIP(PAR:NMR_KODS)&'   PVN: '&PAR:PVN)
          ELSE
             RETURN('P/K: '&CLIP(PAR:NMR_KODS))
          .
       ELSE
          IF PAR:PVN  ! IR PVN MAKS�T�JS
             RETURN('NMR: '&CLIP(PAR:NMR_KODS)&'   PVN: '&PAR:PVN)
          ELSE
             RETURN('NMR: '&CLIP(PAR:NMR_KODS))
          .
       .
    .
    RETURN(PAR:KRED_LIM)   !22
    BEGIN                  !23
       EXECUTE PAR:LT+1
          RETURN('')
          RETURN(PAR:LIGUMS)
          RETURN(PAR:LIGUMS)
       .
    .
    RETURN(PAR:ADRESE)     !24
    RETURN(CLIP(PAV:NOKA)&':'&PAR:NOS_S)  !25 P/Z NO KASES
    BEGIN                  !26
!      GETPAR_L(...
       RETURN(PAR:LIGUMS)  !??? J�DOM�
    .
    BEGIN                  !27
       IF PAR:NOKL_DC_TIPS='2' !Nenor�d�t apmaksas termi�u
          NOKL_DC=0
       ELSIF PAR:NOKL_DC
          IF PAR:NOKL_DC_TIPS='1' !Bankas dienas
             SESV#=0
             LOOP I#=DOKDAT TO DOKDAT+PAR:NOKL_DC
                IF I#%7=0 OR I#%7=6
                   SESV#+=1
                .
             .
             NOKL_DC=PAR:NOKL_DC+SESV#
          ELSE 
             NOKL_DC=PAR:NOKL_DC
          .
       ELSE
          NOKL_DC=SYS:NOKL_DC
       .
       RETURN(NOKL_DC)
    .
    RETURN(PAR:nos_P)      !28
    BEGIN                  !29
       RAZ_KB=DEFORMAT(RAZ_K)
!       STOP(RAZ_KB&' '&RAZ_K)
       IF PAR:ATZIME1=RAZ_KB OR PAR:ATZIME2=RAZ_KB
          RETURN('1')
       ELSE
          RETURN('')
       .
    .
 .


GetMYBank            PROCEDURE (<BKK>)            ! Declare Procedure
  CODE                                            ! Begin processed code
  IF ~NOKL_B THEN NOKL_B=SYS:NOKL_B.
  CHECKOPEN(GLOBAL,1)
!  IF INRANGE(BKK,1,10) !PIEPRAS�TA KONKR�TA NO GLOB��IEM
  IF BKK AND ~(BKK=GL:BKK[NOKL_B])
     LOOP I#=1 TO 10
        IF BKK=GL:BKK[I#]
           NOKL_B=I#
           BREAK
        .
     .
  .
  CHECKOPEN(BANKAS_K,1)
  BANKAS_K::USED+=1
  REK=GL:REK[NOKL_B]
  KOR=GL:KOR[NOKL_B]  !EL_MAKS TIEK PIEMIN�TS...
  BVAL=GETKON_K(GL:BKK[NOKL_B],0,5)
  CLEAR(BAN:RECORD)
  GET(BANKAS_K,0)
  BAN:KODS=GL:BKODS[NOKL_B]
  GET(BANKAS_K,BAN:KOD_KEY)
  IF ERROR()
     KLUDA(67,'BANKAS '&GL:BKODS[NOKL_B])
  ELSE
     BANKA=BAN:NOS_P
     BKODS=BAN:KODS
     BSPEC=BAN:SPEC
     BINDEX=BAN:INDEX
  .
  BANKAS_K::USED-=1
  IF BANKAS_K::USED=0
     CLOSE(BANKAS_K)
  .
  RETURN

GETGG                FUNCTION (GGKNR,<OPC>)       ! Declare Procedure
RINDASCREEN WINDOW('Caption'),AT(,,186,101),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC),GRAY
       OPTION('Rindas kods PVND'),AT(4,6,174,71),USE(GG:BAITS),BOXED
         RADIO('44-dar�jums veikts br�vost� vai SEZ'),AT(8,16),USE(?GG:BAITS:Radio1),VALUE('1')
         RADIO('45-uz ES valst�m pieg�d�t� prece'),AT(8,25),USE(?GG:BAITS:Radio2),VALUE('2')
         RADIO('46-preces pieg�de muitas noliktav� vai br�vaj� zon�'),AT(8,35),USE(?GG:BAITS:Radio3), |
             VALUE('3')
         RADIO('48-par sniegtajiem pakalpojumiem'),AT(8,45),USE(?GG:BAITS:Radio4),VALUE('4')
         RADIO('482-cit� valst� veiktais dar�jums'),AT(8,55),USE(?GG:BAITS:Radio5),VALUE('5')
         RADIO('411-kokmateri�lu, met�ll���u realiz�cija LR'),AT(8,64),USE(?GG:BAITS:Radio6),VALUE('6')
       END
       BUTTON('OK'),AT(103,79,35,14),USE(?OkButton),DEFAULT
       BUTTON('Cancel'),AT(141,79,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
!
!  POZICION� GG UN ATGRIE� TRUE , JA ATRADIS vai PVND rindas kodu
!
 IF GG::Used = 0
    CheckOpen(GG,1)
 END
 GG::Used += 1
 CLEAR(GG:RECORD)
 GG:U_NR=GGKNR
 GET(GG,GG:NR_KEY)
 IF ERROR() THEN RET#=1.
 CASE OPC
 OF 0
    GG::Used -= 1
    IF GG::Used = 0
       CLOSE(GG)
    .
    EXECUTE RET#+1
       RETURN(1) !OK
       RETURN(0)
    .
 OF 1
    IF ~GG:BAITS
       OPEN(RINDASCREEN)
       DISPLAY
       ACCEPT
          CASE FIELD()
          OF ?OkButton
             BREAK
          .
       .
       CLOSE(RINDASCREEN)
!       STOP(GG:BAITS)
       PUT(GG)
       CLOSE(RINDASCREEN)
       GG::Used -= 1
       IF GG::Used = 0
          CLOSE(GG)
       .
    .
    EXECUTE(GG:BAITS)
       RETURN(44)
       RETURN(45)
       RETURN(46)
       RETURN(48)
       RETURN(482)
       RETURN(411)
    .
 .
