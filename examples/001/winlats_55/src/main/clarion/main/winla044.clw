                     MEMBER('winlats.clw')        ! This is a MEMBER module
getpar_k             FUNCTION (parnr,REQ,RET,<DOKDAT>,<RAZ_K>) ! Declare Procedure
PARTEX               CSTRING(20)
Auto::Save:PAR:U_NR  LIKE(PAR:U_NR)
PAR_END_U_NR         LIKE(PAR:U_NR)
NOKL_DC              BYTE
RAZ_KB               BYTE
  CODE                                            ! Begin processed code
 !
 !  PARNR - PIEPRASÎTAIS PARTNERA U_NR
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD,JA NAV
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU UN NOTÎRA RECORD,JA NAV
 !        3 IZSAUC KÏÛDU UN UZBVÇ RECORD,JA NAV
 !  RET - 1 ATGRIEÞ NOS_S
 !        2 ATGRIEÞ NOS_P
 !        3 ATGRIEÞ NOS_P vai PAV:NOKA
 !        4 ATGRIEÞ NOS_S vai GG:NOKA
 !        5 ATGRIEÞ NOS_S vai PAV:NOKA
 !        6 ATGRIEÞ NOS_P vai GG:NOKA
 !        7 ATGRIEÞ NOS_P vai ''
 !        8 ATGRIEÞ PAR:PVN_PASE[1:22] VAI PAR:KODS (ÎSÂ REÌISTRÂCIJA)
 !        9 ATGRIEÞ PAR:KODS UN LV.......... (GARÂ REÌISTRÂCIJA)
 !       10 ATGRIEÞ NOS_U
 !    KN 11 ATGRIEÞ NOS_P, SAÒEM KARTES NR
 !       12 ATGRIEÞ PAR:KODS (ÎSÂ REÌISTRÂCIJA BEZ LV)
 !       13 ATGRIEÞ [1:13](E) VAI PVN(CN) VAI NEKO
 !       14 ATGRIEÞ NOS_A (VISÂDÂM TABULÂM)
 !       15 ATGRIEÞ PAR:GRUPA
 !       16 ATGRIEÞ PAR:FAX
 !       17 ATGRIEÞ PAR:TEL
 !    KN 18 ATGRIEÞ U_NR, SAÒEM KARTES NR
 !       19 ATGRIEÞ V_KODS
 !       20 ATGRIEÞ PAR:TIPS
 !       21 ATGRIEÞ NMR: PAR:KODS UN PVN: LV........../######-#####/1:40 (REÌISTRÂCIJA P/Z)
 !       22 ATGRIEÞ PAR:KRED_LIM
 !       23 ATGRIEÞ PAR:LIGUMS1/PAR:LIGUMS2 KÂ F:LT
 !       24 ATGRIEÞ PAR:ADRESE
 !       25 ATGRIEÞ PAV:NOKA un NOS_S
 !       26 ATGRIEÞ PAR:LIGUMS2 ???????????????
 !       27 ATGRIEÞ PAR:NOKL_DC
 !    RK 28 ATGRIEÞ NOS_P, SAÒEM RAZ_K
 !       29 ATGRIEÞ 1, JA IR DEFINÇTA ZEM RAZ_K PADOTÂ ATZÎME
 !<DOKDAT> - LAI 27 VARÇTU SASKAITÎT BANKAS DIENAS
 !<RAZ_K>  - LAI 28 VARÇTU DABÛT NO RAÞOTÂJA KODA, 29 NODOD MEKLÇJAMÂS ATZÎMES Nr
 !
 !
 !

 IF ~INRANGE(RET,1,29)
    KLUDA(0,'GETPAR_K: Pieprasîts atgriezt '&RET)
    RETURN('')
 .
 IF (PARNR=0 AND REQ=0) OR PARNR=999999999
    RETURN('')
 .

 IF PAR_K::Used = 0
   CheckOpen(PAR_K,1) !IZSKATÂS, KA AR ÐITO CLEAR(PAR:RECORD)
 .
 PAR_K::Used += 1

 IF RET=11 OR RET=18      !KARTE
    IF ~(PAR:KARTE=PARNR) !NAV JAU POZICIONÇTS
       PARTEX='Partnera Kartes Nr:'
       PAR:KARTE=PARNR
       GET(PAR_K,PAR:KARTE_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    .
 ELSIF RET=28             !NOS_U- RAÞOTÂJA KODS
    IF RAZ_K
       PARTEX='Partnera Raþotâja kods:'
       PAR:NOS_U=RAZ_K
       GET(PAR_K,PAR:NOS_U_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    ELSE
    RETURN('')
    .
 ELSE
    IF ~(PAR:U_NR=PARNR) OR PARNR=0 !NAV JAU POZICIONÇTS VAI PIEPRASÎTS 0-TAIS
       PARTEX='Partnera U_nr:'
       PAR:U_NR=PARNR
       GET(PAR_K,PAR:NR_KEY)
       IF ERROR() THEN ERROR#=TRUE.
    .
 .
 IF ERROR#=TRUE
    IF REQ = 2
       KLUDA(17,ParTex&CLIP(PARNR)&' '&CLIP(RAZ_K)&' '&ERROR())  !RAZ_K-STRING NORÂDE
       clear(par:record)
    ELSIF REQ = 3
       KLUDA(17,ParTex&CLIP(PARNR)&' ...BÛVÇJU ')
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
          KLUDA(45,'PAR_K autonumerâcijas apgabalâ atlikuði '&PAR_END_U_NR-PAR:U_NR&' brîvi ieraksti')
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
    BEGIN                  !8 PVN (îsâ) reìistrâcija
       IF PAR:PVN
          RETURN(PAR:PVN)
       ELSE
          RETURN(PAR:NMR_KODS)
       .
    .
    BEGIN                  !9 GARÂ reìistrâcija
       IF PAR:TIPS = 'F'
          return('personas kods: '&CLIP(PAR:NMR_KODS)&' '&PAR:PVN)
       ELSE
          return(CLIP(PAR:NMR_KODS)&' '&PAR:PVN)
       .
    .
    RETURN(PAR:nos_U)      !10
    RETURN(PAR:nos_P)      !11
    RETURN(PAR:NMR_KODS)   !12 îsâ reìistrâcija
    RETURN(PAR:PVN)        !13 PNV REÌISTRÂCIJAS Nr
    RETURN(PAR:nos_A)      !14
    RETURN(PAR:GRUPA)      !15
    RETURN(PAR:FAX)        !16
    RETURN(PAR:TEL)        !17
    RETURN(PAR:U_NR)       !18
    RETURN(PAR:V_KODS)     !19
    RETURN(PAR:TIPS)       !20
    BEGIN                  !21 REÌISTRÂCIJA P/Z
       IF PAR:TIPS = 'F'
          IF PAR:PVN  ! IR PVN MAKSÂTÂJS
             RETURN('P/K: '&CLIP(PAR:NMR_KODS)&'   PVN: '&PAR:PVN)
          ELSE
             RETURN('P/K: '&CLIP(PAR:NMR_KODS))
          .
       ELSE
          IF PAR:PVN  ! IR PVN MAKSÂTÂJS
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
       RETURN(PAR:LIGUMS)  !??? JÂDOMÂ
    .
    BEGIN                  !27
       IF PAR:NOKL_DC_TIPS='2' !Nenorâdît apmaksas termiòu
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
!  IF INRANGE(BKK,1,10) !PIEPRASÎTA KONKRÇTA NO GLOBÂÏIEM
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
  KOR=GL:KOR[NOKL_B]  !EL_MAKS TIEK PIEMINÇTS...
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
         RADIO('44-darîjums veikts brîvostâ vai SEZ'),AT(8,16),USE(?GG:BAITS:Radio1),VALUE('1')
         RADIO('45-uz ES valstîm piegâdâtâ prece'),AT(8,25),USE(?GG:BAITS:Radio2),VALUE('2')
         RADIO('46-preces piegâde muitas noliktavâ vai brîvajâ zonâ'),AT(8,35),USE(?GG:BAITS:Radio3), |
             VALUE('3')
         RADIO('48-par sniegtajiem pakalpojumiem'),AT(8,45),USE(?GG:BAITS:Radio4),VALUE('4')
         RADIO('482-citâ valstî veiktais darîjums'),AT(8,55),USE(?GG:BAITS:Radio5),VALUE('5')
         RADIO('411-kokmateriâlu, metâllûþòu realizâcija LR'),AT(8,64),USE(?GG:BAITS:Radio6),VALUE('6')
       END
       BUTTON('OK'),AT(103,79,35,14),USE(?OkButton),DEFAULT
       BUTTON('Cancel'),AT(141,79,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
!
!  POZICIONÇ GG UN ATGRIEÞ TRUE , JA ATRADIS vai PVND rindas kodu
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
