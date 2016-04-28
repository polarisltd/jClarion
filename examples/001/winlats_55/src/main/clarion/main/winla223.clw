                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETNOM_A             FUNCTION (NOM,RET,OPC,NOL_NR) ! Declare Procedure
ATLIKUMS        DECIMAL(9,3)
SAV_NOA_RECORD  LIKE(NOA:RECORD)
  CODE                                            ! Begin processed code
 !  NOM - PIEPRASÎTÂ NOMENKLATÛRA
 !
 !  ATGRIEÞ REAL
 !
 !  RET   - 1 ATGRIEÞ ATLIKUMU
 !        - 2 ATGRIEÞ D_PROJEKTS
 !        - 3 ATGRIEÞ ATLIKUMS-K_PROJEKTS
 !        - 4 ATGRIEÞ K_PROJEKTS
 !        - 5 ATGRIEÞ ATLIKUMU KOPÂ
 !        - 6 ATGRIEÞ D_PROJEKTS KOPÂ
 !        - 7 NOÒEMTS....
 !        - 8 ATGRIEÞ K_PROJEKTS KOPÂ
 !        - 9 ATGRIEÞ 1 IR ATRASTA, 0- NAV
 !
 !  OPC-    0 IR JÂBÛT, JA NAV, ATGRIEÞ 0
 !          1 ADD NEW
 !          2 JÂPÂRRÇÍINA(&JÂPÂRRAKSTA,ja F:CEN) ATLIKUMI UZ B_DAT
 !          3 DZÇST
 !          4 MAINÎT, JÂBÛT POZICIONÇTAM NOM_K
 !
 !  NOL_NR  1-25, JA NAV:LOC_NR
 !
 !  GL::NOL_NR25 KURAS NOLIKTAVAS JÂSKATA
 !

 IF ~INRANGE(RET,1,9)
     STOP('NOM_A:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN(0)
 .
 IF ~NOL_NR
    NOL_NR=LOC_NR
    NOL_NR25[LOC_NR]=1
 .
 FOUND#=FALSE
 IF ~NOM
    KLUDA(0,'NAV NORÂDÎTA NOMENKLATÛRA IZSAUCOT GETNOM_A')
    RETURN(0)
 .
 IF ~(NOM='POZICIONÇTS')    ! OR NOM=NOA:NOMENKLAT - ÐITÂ NERÎKST,JA VAJAG POZICIONÇT....
    IF NOM_A::USED=0
       CheckOpen(NOM_A,1)
    .
    NOM_A::Used += 1
    CLEAR(NOA:RECORD)
    NOA:NOMENKLAT=NOM
    GET(NOM_A,NOA:NOM_KEY)
    CASE OPC
    OF 1  !JAUNS vai PÂRBAUDAM EKSISTENCI
       IF ERROR()  !JÂBÛT , BAT NAV
          CLEAR(NOA:RECORD)
          NOA:NOMENKLAT=NOM
          IF GNET
             NOA:GNET_FLAG[1]=1
             NOA:GNET_FLAG[2]=''
             NOA:GNET_FLAG[3]=CHR(NOL_NR)
          .
          ADD(NOM_A)
          IF ~ERROR() THEN FOUND#=TRUE.
       ELSE
          FOUND#=TRUE
       .
    OF 2  !JÂPÂRRÇÍINA ATLIKUMI
       IF ERROR()  !JÂBÛT , BAT NAV
          CLEAR(NOA:RECORD)
          NOA:NOMENKLAT=NOM
          ADD(NOM_A)
          IF ~ERROR() THEN FOUND#=TRUE.
       ELSE
          SAV_NOA_RECORD=NOA:RECORD
          FOUND#=TRUE
       .
       CLEAR(NOA:D_PROJEKTS)
       CLEAR(NOA:ATLIKUMS)
       CLEAR(NOA:K_PROJEKTS)
       IF GNET
          SEL_NOL_NR25   !??????????????????????????
       .
       LOOP T#=1 TO nol_sk
          NOL_NR25[T#]=1    !VIENMÇR JÂPÂRRÇÍINA VISAS
          CLOSE(NOLIK)
          NOLIKNAME='NOLIK'&FORMAT(T#,@N02)
          IF DOS_CONT(CLIP(NOLIKNAME)&'.TPS',2)
             CHECKOPEN(NOLIK,1)
             IF ~ERROR()
                ACTION#=2
                CLEAR(NOL:RECORD)
                NOL:NOMENKLAT=NOM
                NOL:DATUMS=DB_S_DAT
                SET(NOL:NOM_KEY,NOL:NOM_KEY)
                LOOP
                   NEXT(NOLIK)
                   IF ERROR() OR ~(NOL:NOMENKLAT=NOM) OR ~(NOL:DATUMS<=B_DAT) THEN BREAK.
                   CASE NOL:D_K
                   OF '1'
                      NOA:D_PROJEKTS[T#]+=NOL:DAUDZUMS
                   OF 'D'
                      NOA:ATLIKUMS[T#]+=NOL:DAUDZUMS
                   OF 'K'
                      NOA:ATLIKUMS[T#]-=NOL:DAUDZUMS
                   OF 'P'
                      NOA:K_PROJEKTS[T#]+=NOL:DAUDZUMS
                   .
                .
             ELSE
                TAKA"=LONGPATH()
                KLUDA(1,CLIP(TAKA")&'\'&NOLIKNAME)
                ACTION#=0
                BREAK
             .
          .
       .
       IF GNET AND ACTION#
          NOA:GNET_FLAG[1]=ACTION#
          NOA:GNET_FLAG[2]=''
          NOA:GNET_FLAG[3]=CHR(NOL_NR)
       .
       EXECUTE ACTION#+1
          NEKAS#=1
          ADD(NOM_A)
          BEGIN
             IF ~(SAV_NOA_RECORD=NOA:RECORD) AND (B_DAT=TODAY() OR B_DAT=DB_B_DAT)
!             STOP('UPDATE'&NOA:NOMENKLAT)
                IF RIUPDATE:NOM_A() THEN  KLUDA(24,'NOM_A').
             .
          .
       .
       CLOSE(NOLIK)
       NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)      !Noliekam, ko paòçmâm
       CHECKOPEN(NOLIK,1)
    OF 3  !JÂDZÇÐ
       IF ~ERROR()
          IF GNET
             NOA:GNET_FLAG[1]=3
             NOA:GNET_FLAG[2]=''
             NOA:GNET_FLAG[3]=CHR(NOL_NR)
             I#= RIUPDATE:NOM_A()
          ELSE
             DELETE(NOM_A)
          .
       .
    OF 4  !JÂMAINA
       IF ~ERROR()
!          IF GNET   GLOBÂLÂ TÎKLÂ MAINÎT NEDRÎKST
           NOA:NOMENKLAT=NOM:NOMENKLAT
           IF RIUPDATE:NOM_A()
              KLUDA(24,'NOM_A: '&NOM&' -> '&NOM:NOMENKLAT)
           .
       .
    ELSE  !0-IR JÂBÛT
       IF ERROR()
!          STOP('NOM_A OPC= '&OPC&' NOM: '&NOM&ERROR())
          CLEAR(NOA:RECORD)
       ELSE
          FOUND#=TRUE
       .
    .
    NOM_A::USED-=1
    IF NOM_A::USED=0
       CLOSE(NOM_A)
    .
 ELSE   !IR POZICIONÇTS
    FOUND#=TRUE
 .
 EXECUTE RET
    BEGIN
       IF CL_NR=1033 AND INRANGE(NOL_NR,1,2)     !ÍÎPSALA
          RETURN(NOA:ATLIKUMS[1]+NOA:ATLIKUMS[2])      !1
       ELSIF CL_NR=1033 AND INRANGE(NOL_NR,4,5)  !ÍÎPSALA MEÞCIEMS
          RETURN(NOA:ATLIKUMS[4]+NOA:ATLIKUMS[5])      !1
       ELSE
          RETURN(NOA:ATLIKUMS[NOL_NR])      !1
       .
    .
    RETURN(NOA:D_PROJEKTS[NOL_NR])    !2
    RETURN(NOA:ATLIKUMS[NOL_NR]-NOA:K_PROJEKTS[NOL_NR]) !3 ATL-P (PIEEJAMS)
    RETURN(NOA:K_PROJEKTS[NOL_NR])    !4
    BEGIN                             !5
       LOOP I#=1 TO NOL_SK
          IF NOL_NR25[I#]             !PIRMS IZSAUKUMA JÂBÛT SEL_NOL_NR25
             ATLIKUMS+=NOA:ATLIKUMS[I#]
          .
       .
       RETURN(ATLIKUMS)
    .
    BEGIN                             !6
       LOOP I#=1 TO NOL_SK
          IF NOL_NR25[I#]
             ATLIKUMS+=NOA:D_PROJEKTS[I#]
          .
       .
       RETURN(ATLIKUMS)
    .
    RETURN(0)                         !7  NOÒEMTS!!!!!!!!!!!!11
    BEGIN                             !8
       LOOP I#=1 TO NOL_SK
          IF NOL_NR25[I#]
             ATLIKUMS+=NOA:K_PROJEKTS[I#]
          .
       .
       RETURN(ATLIKUMS)
    .
    RETURN(FOUND#)                    !9 IR/NAV ATRASTA
 .
ShowNomA             PROCEDURE (NOM)              ! Declare Procedure
PREC_ATL    STRING(1)
PIEMS       DECIMAL(9,2),DIM(25)
P           string(13),DIM(25)
NOAA        string(13),DIM(25)
NOAD        string(13),DIM(25)
NOAK        string(13),DIM(25)
PLAUKTS     STRING(50)

INFOSCREEN WINDOW('Papildus informâcija'),AT(,,248,257),CENTER,GRAY
       LINE,AT(0,12,250,0),USE(?Line1),COLOR(COLOR:Black)
       LINE,AT(17,0,0,237),USE(?Line27),COLOR(COLOR:Black)
       PROMPT('&Pieejams'),AT(32,1,35,10),USE(?Prompt1),CENTER
       LINE,AT(74,0,0,237),USE(?Line28),COLOR(COLOR:Black)
       PROMPT('&Atlikums'),AT(89,1,35,10),USE(?Prompt2),CENTER
       LINE,AT(131,0,0,237),USE(?Line29),COLOR(COLOR:Black)
       PROMPT('&D-projekts'),AT(146,1,35,10),USE(?Prompt3),CENTER
       LINE,AT(189,0,0,237),USE(?Line30),COLOR(COLOR:Black)
       PROMPT('&K-projekts'),AT(204,1,35,10),USE(?Prompt5),CENTER
       STRING('1'),AT(0,13,17,8),USE(?String01),CENTER
       STRING(@S13),AT(18,13,54,8),USE(P[1]),RIGHT
       STRING('2'),AT(0,22,17,8),USE(?String2),CENTER
       STRING(@S13),AT(18,22,54,8),USE(P[2]),RIGHT
       STRING('3'),AT(0,31,17,8),USE(?String3),CENTER
       STRING(@S13),AT(18,31,54,8),USE(P[3]),RIGHT
       STRING('4'),AT(0,40,17,8),USE(?String4),CENTER
       STRING(@S13),AT(18,40,54,8),USE(P[4]),RIGHT
       STRING('5'),AT(0,49,17,8),USE(?String5),CENTER
       STRING(@S13),AT(18,49,54,8),USE(P[5]),RIGHT
       STRING('6'),AT(0,58,17,8),USE(?String6),CENTER
       STRING(@S13),AT(18,58,54,8),USE(P[6]),RIGHT
       STRING('7'),AT(0,67,17,8),USE(?String7),CENTER
       STRING(@S13),AT(18,67,54,8),USE(P[7]),RIGHT
       STRING('8'),AT(0,76,17,8),USE(?String8),CENTER
       STRING(@S13),AT(18,76,54,8),USE(P[8]),RIGHT
       STRING('9'),AT(0,85,17,8),USE(?String9),CENTER
       STRING(@S13),AT(18,85,54,8),USE(P[9]),RIGHT
       STRING('10'),AT(0,94,17,8),USE(?String10),CENTER
       STRING(@S13),AT(18,94,54,8),USE(P[10]),RIGHT
       STRING('11'),AT(0,103,17,8),USE(?String11),CENTER
       STRING(@S13),AT(18,103,54,8),USE(P[11]),RIGHT
       STRING('12'),AT(0,112,17,8),USE(?String12),CENTER
       STRING(@S13),AT(18,112,54,8),USE(P[12]),RIGHT
       STRING('13'),AT(0,121,17,8),USE(?String13),CENTER
       STRING(@S13),AT(18,121,54,8),USE(P[13]),RIGHT
       STRING('14'),AT(0,130,17,8),USE(?String14),CENTER
       STRING(@S13),AT(18,130,54,8),USE(P[14]),RIGHT
       STRING('15'),AT(0,139,17,8),USE(?String15),CENTER
       STRING(@S13),AT(18,139,54,8),USE(P[15]),RIGHT
       STRING('16'),AT(0,148,17,8),USE(?String16),CENTER
       STRING(@S13),AT(18,148,54,8),USE(P[16]),RIGHT
       STRING('17'),AT(0,157,17,8),USE(?String17),CENTER
       STRING(@S13),AT(18,157,54,8),USE(P[17]),RIGHT
       STRING('18'),AT(0,166,17,8),USE(?String18),CENTER
       STRING(@S13),AT(18,166,54,8),USE(P[18]),RIGHT
       STRING('19'),AT(0,175,17,8),USE(?String19),CENTER
       STRING(@S13),AT(18,175,54,8),USE(P[19]),RIGHT
       STRING('20'),AT(0,184,17,8),USE(?String20),CENTER
       STRING(@S13),AT(18,184,54,8),USE(P[20]),RIGHT
       STRING('21'),AT(0,193,17,8),USE(?String21),CENTER
       STRING(@S13),AT(18,193,54,8),USE(P[21]),RIGHT
       STRING('22'),AT(0,202,17,8),USE(?String22),CENTER
       STRING(@S13),AT(18,202,54,8),USE(P[22]),RIGHT
       STRING('23'),AT(0,211,17,8),USE(?String23),CENTER
       STRING(@S13),AT(18,211,54,8),USE(P[23]),RIGHT
       STRING('24'),AT(0,220,17,8),USE(?String24),CENTER
       STRING(@S13),AT(18,220,54,8),USE(P[24]),RIGHT
       STRING('25'),AT(0,229,17,8),USE(?String25),CENTER
       STRING(@S13),AT(18,229,54,8),USE(P[25]),RIGHT
       STRING(@S13),AT(75,13,54,8),USE(NOAA[1]),RIGHT
       STRING(@S13),AT(75,22,54,8),USE(NOAA[2]),RIGHT
       STRING(@S13),AT(75,31,54,8),USE(NOAA[3]),RIGHT
       STRING(@S13),AT(75,40,54,8),USE(NOAA[4]),RIGHT
       STRING(@S13),AT(75,49,54,8),USE(NOAA[5]),RIGHT
       STRING(@S13),AT(75,58,54,8),USE(NOAA[6]),RIGHT
       STRING(@S13),AT(75,67,54,8),USE(NOAA[7]),RIGHT
       STRING(@S13),AT(75,76,54,8),USE(NOAA[8]),RIGHT
       STRING(@S13),AT(75,85,54,8),USE(NOAA[9]),RIGHT
       STRING(@S13),AT(75,94,54,8),USE(NOAA[10]),RIGHT
       STRING(@S13),AT(75,103,54,8),USE(NOAA[11]),RIGHT
       STRING(@S13),AT(75,112,54,8),USE(NOAA[12]),RIGHT
       STRING(@S13),AT(75,121,54,8),USE(NOAA[13]),RIGHT
       STRING(@S13),AT(75,130,54,8),USE(NOAA[14]),RIGHT
       STRING(@S13),AT(75,139,54,8),USE(NOAA[15]),RIGHT
       STRING(@S13),AT(75,148,54,8),USE(NOAA[16]),RIGHT
       STRING(@S13),AT(75,157,54,8),USE(NOAA[17]),RIGHT
       STRING(@S13),AT(75,166,54,8),USE(NOAA[18]),RIGHT
       STRING(@S13),AT(75,175,54,8),USE(NOAA[19]),RIGHT
       STRING(@S13),AT(75,184,54,8),USE(NOAA[20]),RIGHT
       STRING(@S13),AT(75,193,54,8),USE(NOAA[21]),RIGHT
       STRING(@S13),AT(75,202,54,8),USE(NOAA[22]),RIGHT
       STRING(@S13),AT(75,211,54,8),USE(NOAA[23]),RIGHT
       STRING(@S13),AT(75,220,54,8),USE(NOAA[24]),RIGHT
       STRING(@S13),AT(75,229,54,8),USE(NOAA[25]),RIGHT
       STRING(@S13),AT(133,13,54,8),USE(NOAD[1]),RIGHT
       STRING(@S13),AT(133,22,54,8),USE(NOAD[2]),RIGHT
       STRING(@S13),AT(133,31,54,8),USE(NOAD[3]),RIGHT
       STRING(@S13),AT(133,40,54,8),USE(NOAD[4]),RIGHT
       STRING(@S13),AT(133,49,54,8),USE(NOAD[5]),RIGHT
       STRING(@S13),AT(133,58,54,8),USE(NOAD[6]),RIGHT
       STRING(@S13),AT(133,67,54,8),USE(NOAD[7]),RIGHT
       STRING(@S13),AT(133,76,54,8),USE(NOAD[8]),RIGHT
       STRING(@S13),AT(133,85,54,8),USE(NOAD[9]),RIGHT
       STRING(@S13),AT(133,94,54,8),USE(NOAD[10]),RIGHT
       STRING(@S13),AT(133,103,54,8),USE(NOAD[11]),RIGHT
       STRING(@S13),AT(133,112,54,8),USE(NOAD[12]),RIGHT
       STRING(@S13),AT(133,121,54,8),USE(NOAD[13]),RIGHT
       STRING(@S13),AT(133,130,54,8),USE(NOAD[14]),RIGHT
       STRING(@S13),AT(133,139,54,8),USE(NOAD[15]),RIGHT
       STRING(@S13),AT(133,148,54,8),USE(NOAD[16]),RIGHT
       STRING(@S13),AT(133,157,54,8),USE(NOAD[17]),RIGHT
       STRING(@S13),AT(133,166,54,8),USE(NOAD[18]),RIGHT
       STRING(@S13),AT(133,175,54,8),USE(NOAD[19]),RIGHT
       STRING(@S13),AT(133,184,54,8),USE(NOAD[20]),RIGHT
       STRING(@S13),AT(133,193,54,8),USE(NOAD[21]),RIGHT
       STRING(@S13),AT(133,202,54,8),USE(NOAD[22]),RIGHT
       STRING(@S13),AT(133,211,54,8),USE(NOAD[23]),RIGHT
       STRING(@S13),AT(133,220,54,8),USE(NOAD[24]),RIGHT
       STRING(@S13),AT(133,229,54,8),USE(NOAD[25]),RIGHT
       STRING(@S13),AT(191,13,54,8),USE(NOAK[1]),RIGHT
       LINE,AT(0,21,250,0),USE(?Line2),COLOR(COLOR:Black)
       STRING(@S13),AT(191,22,54,8),USE(NOAK[2]),RIGHT
       LINE,AT(0,30,250,0),USE(?Line3),COLOR(COLOR:Black)
       STRING(@S13),AT(191,31,54,8),USE(NOAK[3]),RIGHT
       LINE,AT(0,39,250,0),USE(?Line4),COLOR(COLOR:Black)
       STRING(@S13),AT(191,40,54,8),USE(NOAK[4]),RIGHT
       LINE,AT(0,48,250,0),USE(?Line5),COLOR(COLOR:Black)
       STRING(@S13),AT(191,49,54,8),USE(NOAK[5]),RIGHT
       LINE,AT(0,57,250,0),USE(?Line6),COLOR(COLOR:Black)
       STRING(@S13),AT(191,58,54,8),USE(NOAK[6]),RIGHT
       LINE,AT(0,66,250,0),USE(?Line7),COLOR(COLOR:Black)
       STRING(@S13),AT(191,67,54,8),USE(NOAK[7]),RIGHT
       LINE,AT(0,75,250,0),USE(?Line8),COLOR(COLOR:Black)
       STRING(@S13),AT(191,76,54,8),USE(NOAK[8]),RIGHT
       LINE,AT(0,84,250,0),USE(?Line9),COLOR(COLOR:Black)
       STRING(@S13),AT(191,85,54,8),USE(NOAK[9]),RIGHT
       LINE,AT(0,93,250,0),USE(?Line10),COLOR(COLOR:Black)
       STRING(@S13),AT(191,94,54,8),USE(NOAK[10]),RIGHT
       LINE,AT(0,102,250,0),USE(?Line11),COLOR(COLOR:Black)
       STRING(@S13),AT(191,103,54,8),USE(NOAK[11]),RIGHT
       LINE,AT(0,111,250,0),USE(?Line12),COLOR(COLOR:Black)
       STRING(@S13),AT(191,112,54,8),USE(NOAK[12]),RIGHT
       LINE,AT(0,120,250,0),USE(?Line13),COLOR(COLOR:Black)
       STRING(@S13),AT(191,121,54,8),USE(NOAK[13]),RIGHT
       LINE,AT(0,129,250,0),USE(?Line14),COLOR(COLOR:Black)
       STRING(@S13),AT(191,130,54,8),USE(NOAK[14]),RIGHT
       LINE,AT(0,138,250,0),USE(?Line15),COLOR(COLOR:Black)
       STRING(@S13),AT(191,139,54,8),USE(NOAK[15]),RIGHT
       LINE,AT(0,147,250,0),USE(?Line16),COLOR(COLOR:Black)
       STRING(@S13),AT(191,148,54,8),USE(NOAK[16]),RIGHT
       LINE,AT(0,156,250,0),USE(?Line17),COLOR(COLOR:Black)
       STRING(@S13),AT(191,157,54,8),USE(NOAK[17]),RIGHT
       LINE,AT(0,165,250,0),USE(?Line18),COLOR(COLOR:Black)
       STRING(@S13),AT(191,166,54,8),USE(NOAK[18]),RIGHT
       LINE,AT(0,174,250,0),USE(?Line19),COLOR(COLOR:Black)
       STRING(@S13),AT(191,175,54,8),USE(NOAK[19]),RIGHT
       LINE,AT(0,183,250,0),USE(?Line20),COLOR(COLOR:Black)
       STRING(@S13),AT(191,184,54,8),USE(NOAK[20]),RIGHT
       LINE,AT(0,192,250,0),USE(?Line21),COLOR(COLOR:Black)
       STRING(@S13),AT(191,193,54,8),USE(NOAK[21]),RIGHT
       LINE,AT(0,201,250,0),USE(?Line22),COLOR(COLOR:Black)
       STRING(@S13),AT(191,202,54,8),USE(NOAK[22]),RIGHT
       LINE,AT(0,210,250,0),USE(?Line23),COLOR(COLOR:Black)
       STRING(@S13),AT(191,211,54,8),USE(NOAK[23]),RIGHT
       LINE,AT(0,219,250,0),USE(?Line24),COLOR(COLOR:Black)
       STRING(@S13),AT(191,220,54,8),USE(NOAK[24]),RIGHT
       LINE,AT(0,228,250,0),USE(?Line25),COLOR(COLOR:Black)
       STRING(@S13),AT(191,229,54,8),USE(NOAK[25]),RIGHT
       LINE,AT(0,237,250,0),USE(?Line26),COLOR(COLOR:Black)
       BUTTON('Precîzi &atlikumi'),AT(2,241,62,14),USE(?PREC_ATL),HIDE
       IMAGE('CHECK3.ICO'),AT(68,240,16,15),USE(?ImageAtl),HIDE
       BUTTON('&Pârrçíinât'),AT(95,241,62,14),USE(?ButtonPARREK)
       BUTTON('&OK'),AT(209,241,36,14),USE(?Ok),DEFAULT
     END

ParrekinuWindow WINDOW(' '),AT(,,161,44),GRAY
       STRING('Pârrçíinu :'),AT(17,16),USE(?String1)
       STRING(@s21),AT(53,16),USE(noa:nomenklat)
     END
  CODE                                            ! Begin processed code
 PREC_ATL=''
 open(infoscreen)
 EXECUTE LOC_NR
    ?String01{PROP:COLOR,1}=0000FF00h
    ?String2{PROP:COLOR,1}=0000FF00h
    ?String3{PROP:COLOR,1}=0000FF00h
    ?String4{PROP:COLOR,1}=0000FF00h
    ?String5{PROP:COLOR,1}=0000FF00h
    ?String6{PROP:COLOR,1}=0000FF00h
    ?String7{PROP:COLOR,1}=0000FF00h
    ?String8{PROP:COLOR,1}=0000FF00h
    ?String9{PROP:COLOR,1}=0000FF00h
    ?String10{PROP:COLOR,1}=0000FF00h
    ?String11{PROP:COLOR,1}=0000FF00h
    ?String12{PROP:COLOR,1}=0000FF00h
    ?String13{PROP:COLOR,1}=0000FF00h
    ?String14{PROP:COLOR,1}=0000FF00h
    ?String15{PROP:COLOR,1}=0000FF00h
    ?String16{PROP:COLOR,1}=0000FF00h
    ?String17{PROP:COLOR,1}=0000FF00h
    ?String18{PROP:COLOR,1}=0000FF00h
    ?String19{PROP:COLOR,1}=0000FF00h
    ?String20{PROP:COLOR,1}=0000FF00h
    ?String21{PROP:COLOR,1}=0000FF00h
    ?String22{PROP:COLOR,1}=0000FF00h
    ?String23{PROP:COLOR,1}=0000FF00h
    ?String24{PROP:COLOR,1}=0000FF00h
    ?String25{PROP:COLOR,1}=0000FF00h
 .
 PLAUKTS=GETNOM_ADRESE(NOM,0)
 INFOSCREEN{PROP:TEXT}='Papildus informâcija:'&clip(NOM)&' Plaukts: '&plaukts
 IF GNET AND ~(ATLAUTS[1]='1')
    HIDE(?ButtonPARREK)
 .
 IF ATLAUTS[1]='1'
    UNHIDE(?PREC_ATL)
 END
 I#=GETNOM_A(NOM,9,0) !POZICIONÇJAM
 LOOP I#=1 TO 25
    PIEMS[I#]=NOA:ATLIKUMS[I#]-NOA:K_PROJEKTS[I#]
    DO NEPREC_ATL
    DO CUTNUL
 .
 display
 accept
    case field()
    of ?ok
       if event()=Event:Accepted
          break
       .
!    .
    OF ?PREC_ATL
      IF EVENT()=EVENT:ACCEPTED
        IF PREC_ATL
           PREC_ATL = ''
           HIDE(?IMAGEATL)
           LOOP I#=1 TO 25
              PIEMS[I#]=NOA:ATLIKUMS[I#]-NOA:K_PROJEKTS[I#]
              DO NEPREC_ATL
              DO CUTNUL
           END
        ELSE
           PREC_ATL = '1'
           UNHIDE(?IMAGEATL)
           LOOP I#=1 TO 25
              P[I#]   =PIEMS[I#]
              NOAA[I#]=NOA:ATLIKUMS[I#]
              NOAD[I#]=NOA:D_PROJEKTS[I#]
              NOAK[I#]=NOA:K_PROJEKTS[I#]
              DO CUTNUL
           END
        END
        DISPLAY
      .
    OF ?ButtonPARREK
      IF EVENT()=EVENT:ACCEPTED
        OPEN(ParrekinuWindow)
        I#=GETNOM_A(NOM:NOMENKLAT,9,2) !PÂRRÇÍINÂT
        LOOP I#=1 TO 25
           PIEMS[I#]=NOA:ATLIKUMS[I#]-NOA:K_PROJEKTS[I#]
           IF PREC_ATL
              P[I#]=PIEMS[I#]
              NOAA[I#]=NOA:ATLIKUMS[I#]
              NOAD[I#]=NOA:D_PROJEKTS[I#]
              NOAK[I#]=NOA:K_PROJEKTS[I#]
              DO CUTNUL
           ELSE
              DO NEPREC_ATL
              DO CUTNUL
           END
        .
        CLOSE(ParrekinuWindow)
        DISPLAY
      END
    END
 .
 close(infoscreen)


!-------------------------------------------------------------------------
NEPREC_ATL      ROUTINE

        IF PIEMS[I#]>10
            P[I#]=RIGHT('>10')
        ELSIF INRANGE (PIEMS[I#],0,10)
            P[I#]=RIGHT(PIEMS[I#])
        ELSIF PIEMS[I#]<0
            P[I#]=RIGHT('negatîvs')
        END
        IF NOA:ATLIKUMS[I#]>10
            NOAA[I#]=RIGHT('>10')
        ELSIF INRANGE (NOA:ATLIKUMS[I#],0,10)
            NOAA[I#]=RIGHT(NOA:ATLIKUMS[I#])
        ELSIF NOA:ATLIKUMS[I#]<0
            NOAA[I#]=RIGHT('negatîvs')
        END
        IF NOA:D_PROJEKTS[I#]>10
            NOAD[I#]=RIGHT('>10')
        ELSIF INRANGE (NOA:D_PROJEKTS[I#],0,10)
            NOAD[I#]=RIGHT(NOA:D_PROJEKTS[I#])
        ELSIF NOA:D_PROJEKTS[I#]<0
            NOAD[I#]=RIGHT('negatîvs')
        END
        IF NOA:K_PROJEKTS[I#]>10
            NOAK[I#]=RIGHT('>10')
        ELSIF INRANGE (NOA:K_PROJEKTS[I#],0,10)
            NOAK[I#]=RIGHT(NOA:K_PROJEKTS[I#])
        ELSIF NOA:K_PROJEKTS[I#]<0
            NOAK[I#]=RIGHT('negatîvs')
        END

!-------------------------------------------------------------------------
CUTNUL      ROUTINE

        IF P[I#]    ='0' THEN P[I#]=''.
        IF NOAA[I#] ='0' THEN NOAA[I#]=''.
        IF NOAD[I#] ='0' THEN NOAD[I#]=''.
        IF NOAK[I#] ='0' THEN NOAK[I#]=''.
BrowseNolPas PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
kataloga_nr          STRING(17)
nos_s                STRING(16)
SAV:VAL              STRING(3)
SAV_PAR_NR           ULONG
FILTRS               ULONG
BRIDINATS            BYTE
ESKN_KODS            ULONG
IZC_V_KODS           STRING(2)
SVARS                DECIMAL(6,3)
!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)


N_TABLE     QUEUE,PRE(N)
PAR_NR        ULONG
NOMENKLAT     STRING(21)
DAUDZUMS      DECIMAL(11,3)
SUMMALs       DECIMAL(11,2)
PVN_PROC      BYTE
ARBYTE        BYTE
            .

FILTRSWINDOW WINDOW('Mainam filtra nosacîjumus'),AT(,,169,60),GRAY
       STRING('Filtrs pçc dokumenta Nr :'),AT(18,16),USE(?String1)
       ENTRY(@n_10),AT(105,15,55,12),USE(FILTRS)
       BUTTON('&OK'),AT(85,43,35,14),USE(?OkF),DEFAULT
       BUTTON('&Atlikt'),AT(125,43,36,14),USE(?CancelF)
     END


BRW1::View:Browse    VIEW(NOLPAS)
                       PROJECT(NOS:KEKSIS)
                       PROJECT(NOS:DOK_NR)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:T_DAUDZUMS)
                       PROJECT(NOS:I_DAUDZUMS)
                       PROJECT(NOS:SUMMAV)
                       PROJECT(NOS:val)
                       PROJECT(NOS:PAR_KE)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::NOS:KEKSIS       LIKE(NOS:KEKSIS)           ! Queue Display field
BRW1::NOS:DOK_NR       LIKE(NOS:DOK_NR)           ! Queue Display field
BRW1::NOS:KATALOGA_NR  LIKE(NOS:KATALOGA_NR)      ! Queue Display field
BRW1::ESKN_KODS        LIKE(ESKN_KODS)            ! Queue Display field
BRW1::nos_s            LIKE(nos_s)                ! Queue Display field
BRW1::NOS:DAUDZUMS     LIKE(NOS:DAUDZUMS)         ! Queue Display field
BRW1::NOS:T_DAUDZUMS   LIKE(NOS:T_DAUDZUMS)       ! Queue Display field
BRW1::NOS:I_DAUDZUMS   LIKE(NOS:I_DAUDZUMS)       ! Queue Display field
BRW1::NOS:SUMMAV       LIKE(NOS:SUMMAV)           ! Queue Display field
BRW1::NOS:val          LIKE(NOS:val)              ! Queue Display field
BRW1::SVARS            LIKE(SVARS)                ! Queue Display field
BRW1::IZC_V_KODS       LIKE(IZC_V_KODS)           ! Queue Display field
BRW1::PAR_NR           LIKE(PAR_NR)               ! Queue Display field
BRW1::FILTRS           LIKE(FILTRS)               ! Queue Display field
BRW1::NOS:PAR_KE       LIKE(NOS:PAR_KE)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(NOS:DOK_NR),DIM(100)
BRW1::Sort1:LowValue LIKE(NOS:DOK_NR)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(NOS:DOK_NR)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR_NR LIKE(PAR_NR)
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('D-Projekta formçðana no Pasûtîjumiem'),AT(,,437,267),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowsePaNolik'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&5-Speciâlâs funkcijas'),USE(?5Speciâlâsfunkcijas)
                           ITEM('&1-Mainît filtra nosacîjumus'),USE(?5Speciâlâsfunkcijas1Mainîtfiltranosacîjumus)
                         END
                       END
                       LIST,AT(9,20,416,219),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('12C|~Iz~@n1B@37R(1)|~Dok Nr~C(0)@n_8@71R(1)|~Raþotâja kods~C(0)@s17@36L(1)|~EsKn' &|
   'Kods~C(0)@n_8@67L(1)|~Nosaukums~@s16@40R(1)|~Pas Daudz.~@n_10@35R(1)|~Tagad~C(0)' &|
   '@n_10@35R(1)|~Izpildîts~C(0)@n-_11@45R(1)|~Summa~C(0)@n-_12.2@14C|~Val~@s3@27R(1' &|
   ')|~Svars~C(0)@n-8.3@8L(1)|~IV~@s2@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,4,428,258),USE(?CurrentTab)
                         TAB('Dok Nr-Raþotâja kodu secîba'),USE(?Tab:2)
                           BUTTON('I&z: 05-iekïaut IP 12-izlaist'),AT(9,244,89,14),USE(?ButtonX),TIP('1-nav jâiekïauj 2 -iepriekð daïçji piegâdâts, nav jâiekïauj ')
                           BUTTON('&Ievadît'),AT(194,244,42,14),USE(?Insert)
                           BUTTON('&Mainît'),AT(239,244,42,14),USE(?Change),DEFAULT
                           BUTTON('Im&portçt'),AT(328,244,45,14),USE(?Importet),DISABLE
                           BUTTON('I&z: 4-izlaist (noòemt)'),AT(101,244,74,14),USE(?ButtonX:2),TIP('4 -iepriekð nepilnîgi piegâdâts, nav jâiekïauj, nav jâpiedâvâ')
                           BUTTON('&Dzçst'),AT(283,244,42,14),USE(?Delete)
                         END
                       END
                       BUTTON('&Atlikt'),AT(378,244,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
    IF RECORDS(Queue:Browse:1) AND ~BRIDINATS
       ENABLE(?Importet)
    ELSE
       DISABLE(?Importet)
    .
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QUICKWINDOW{PROP:TEXT}='D-Projekta formçðana no Pasûtîjumiem. '&CLIP(par:nos_s)
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE ACCEPTED()
    OF ?5Speciâlâsfunkcijas1Mainîtfiltranosacîjumus
      DO SyncWindow
      OPEN(FILTRSWINDOW)
      DISPLAY
      ACCEPT
         CASE FIELD()
         OF ?OKF
            IF EVENT()=EVENT:Accepted
               BREAK
            .
         OF ?CANCELF
            IF EVENT()=EVENT:Accepted
               FILTRS=0
               BREAK
            .
         .
      .
      BRIDINATS=0
      ENABLE(?Importet)
      CLOSE(FILTRSWINDOW)
      DO BRW1::InitializeBrowse
      DO BRW1::RefreshPage
      QUICKWINDOW{PROP:TEXT}='D-Projekta formçðana no Pasûtîjumiem. '&CLIP(par:nos_s)&' FILTRS: '&FILTRS
      
      
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?ButtonX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           IF NOS:KEKSIS=0
              NOS:KEKSIS=5
           ELSIF NOS:KEKSIS=5
              NOS:keksis=1
           ELSIF NOS:KEKSIS=1
              NOS:keksis=2
           ELSIF NOS:KEKSIS=2
              NOS:keksis=0
           .
           IF RIUPDATE:NOLPAS()
              KLUDA(24,'NOLPAS')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?Insert
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Importet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           DO AUTONUMBER
           PAV:PAR_NR=PAR_NR
           PAV:D_K='1'       !D-PROJEKTS
           PAV:NOKA=GETPAR_K(PAV:PAR_NR,0,1)
           PAV:NODALA=SYS:NODALA
           PAV:ACC_KODS=ACC_kods
           PAV:ACC_DATUMS=today()
           CLEAR(NOS:RECORD)
           NOS:PAR_KE=PAV:PAR_NR
           SET(NOS:PARKE_KEY,NOS:PARKE_KEY)
           LOOP
              NEXT(NOLPAS)
              IF ERROR() OR ~(NOS:PAR_KE=PAV:PAR_NR) THEN BREAK.
              IF ~(NOS:RS='S' AND (NOS:KEKSIS=0 OR nos:keksis=5)) THEN CYCLE.!05-pilnîgi vai daïçji jâiekïauj tekoðajâ importa plûsmâ
              IF FILTRS AND ~(NOS:DOK_NR=FILTRS) THEN CYCLE. !IR UZLIKTS FILTRS
              CLEAR(NOL:RECORD)
              NOL:U_NR=PAV:U_NR
              NOL:DATUMS=PAV:DATUMS
              NOL:NOMENKLAT=NOS:NOMENKLAT
              NOL:PAR_NR=PAV:PAR_NR
              NOL:D_K=PAV:D_K            
              NOL:RS=PAV:RS
              IF NOS:T_DAUDZUMS        !TAGAD:Daudzums
                 NOL:DAUDZUMS=NOS:T_DAUDZUMS
                 NOL:SUMMAV=NOS:T_DAUDZUMS*(NOS:SUMMAV/NOS:DAUDZUMS)
                 NOS:I_DAUDZUMS+=NOS:T_DAUDZUMS   !Izpildîts kopâ
                 NOS:T_DAUDZUMS=0
              ELSE                     !VISS VAI VISS, KAS PALICIS
                 NOL:DAUDZUMS=NOS:DAUDZUMS-NOS:I_DAUDZUMS  !-KAS IZPILDÎTS AGRÂK
                 NOL:SUMMAV=NOS:SUMMAV
                 NOS:I_DAUDZUMS=NOS:DAUDZUMS
              .
              IF ~SAV:VAL
                 SAV:VAL=NOS:VAL
              .
              NOL:VAL=SAV:VAL
              NOL:SUMMA =NOL:SUMMAV*BANKURS(NOL:VAL,NOL:DATUMS,NOL:NOMENKLAT)
              IF GETNOM_K(NOL:NOMENKLAT,0,1)
                 NOL:PVN_PROC=NOM:PVN_PROC
                 NOL:IZC_V_KODS=NOM:IZC_V_KODS
              ELSE
                 NOL:PVN_PROC=NOS:PVN_PROC
              .
              NOL:ARBYTE=0
              ADD(NOLIK)
              IF ~ERROR()
                 AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                 IF NOS:I_DAUDZUMS< NOS:DAUDZUMS    !VÇL ARVIEN VISS NAV IZPILDÎTS
                    NOS:KEKSIS=2
                 ELSE
                    NOS:KEKSIS=3
                    NOS:PAR_KE=0
                 .
                 IF RIUPDATE:NOLPAS()
                    KLUDA(24,'NOLPAS')
                 .
                 PAV:SUMMA+=NOL:SUMMAV
                 PAV:VAL=SAV:VAL
                 IF NOS:NOL_NR AND ~(NOS:NOL_NR=LOC_NR)  !CITAI NOLIKTAVAI
                    N:PAR_NR   =NOS:NOL_NR
                    N:NOMENKLAT=NOL:NOMENKLAT
                    N:DAUDZUMS =NOL:DAUDZUMS
                    N:SUMMALs  =NOL:SUMMA
                    N:PVN_PROC =NOL:PVN_PROC
                    N:ARBYTE=0
                    ADD(N_TABLE)
                 ELSIF NOS:SAN_NR         !KONKRÇTAM SAÒÇMÇJAM ÐAJÂ NOLIKTAVÂ
                    N:PAR_NR   =NOS:SAN_NR
                    N:NOMENKLAT=NOL:NOMENKLAT
                    N:DAUDZUMS =NOL:DAUDZUMS
                    N:SUMMALs  =NOS:LIGUMCENA
                    N:PVN_PROC =NOL:PVN_PROC
                    N:ARBYTE=1
                    ADD(N_TABLE)
                 .
              .
           .
           IF RIUPDATE:PAVAD()               !1-D_PROJEKTS
              KLUDA(24,'PAVAD')
           .
           IF RECORDS(N_TABLE)
              SORT(N_TABLE,N:PAR_NR)
              LOOP I#=1 TO RECORDS(N_TABLE)
                 GET(N_TABLE,I#)
                 IF ~(SAV_PAR_NR=N:PAR_NR)
                    IF SAV_PAR_NR            !NAV PIRMAIS
                       IF RIUPDATE:PAVAD()
                          KLUDA(24,'PAVAD')
                       .
                    .
                    SAV_PAR_NR=N:PAR_NR
                    DO AUTONUMBER
                    PAV:PAR_NR=N:PAR_NR
                    PAV:D_K='P'       !K-PROJEKTS
                    PAV:NOKA=GETPAR_K(PAV:PAR_NR,0,1)
                    PAV:NODALA=SYS:NODALA
                    PAV:ACC_KODS=ACC_kods
                    PAV:ACC_DATUMS=today()
                 .
                 NOL:U_NR=PAV:U_NR
                 NOL:DATUMS=PAV:DATUMS
                 NOL:NOMENKLAT=N:NOMENKLAT
                 NOL:PAR_NR=N:PAR_NR
                 NOL:D_K=PAV:D_K
                 NOL:RS=PAV:RS
                 NOL:DAUDZUMS=N:DAUDZUMS
                 NOL:SUMMAV=N:SUMMALs
                 NOL:SUMMA=N:SUMMALs
                 NOL:VAL='Ls'
                 NOL:PVN_PROC=N:PVN_PROC
                 NOL:ARBYTE=N:ARBYTE
                 ADD(NOLIK)
                 IF ~ERROR()
                    AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                    PAV:SUMMA+=NOL:SUMMA
                    PAV:VAL='Ls'
                 .
              .
              IF RIUPDATE:PAVAD()
                 KLUDA(24,'PAVAD')
              .
           .
           FREE(N_TABLE)
           DO PROCEDURERETURN
      END
    OF ?ButtonX:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           NOS:keksis=4
           NOS:PAR_KE=0
           IF RIUPDATE:NOLPAS()
              KLUDA(24,'NOLPAS')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?Delete
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
  IF NOM_K::Used = 0
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1
  BIND(NOM:RECORD)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseNolPas','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('FILTRS',FILTRS)
  BIND('PAR_NR',PAR_NR)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF WindowOpened
    INISaveWindow('BrowseNolPas','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END


!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:PAR_NR <> PAR_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAR_NR = PAR_NR
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOLPAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    IF ~BRIDINATS
       IF ~GETNOM_K(NOS:NOMENKLAT,2,1)
          BRIDINATS=1
          DISABLE(?Importet)
       .
    .
  END
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = NOS:DOK_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = NOS:DOK_NR
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOS:KEKSIS = BRW1::NOS:KEKSIS
  NOS:DOK_NR = BRW1::NOS:DOK_NR
  NOS:KATALOGA_NR = BRW1::NOS:KATALOGA_NR
  ESKN_KODS = BRW1::ESKN_KODS
  nos_s = BRW1::nos_s
  NOS:DAUDZUMS = BRW1::NOS:DAUDZUMS
  NOS:T_DAUDZUMS = BRW1::NOS:T_DAUDZUMS
  NOS:I_DAUDZUMS = BRW1::NOS:I_DAUDZUMS
  NOS:SUMMAV = BRW1::NOS:SUMMAV
  NOS:val = BRW1::NOS:val
  SVARS = BRW1::SVARS
  IZC_V_KODS = BRW1::IZC_V_KODS
  PAR_NR = BRW1::PAR_NR
  FILTRS = BRW1::FILTRS
  NOS:PAR_KE = BRW1::NOS:PAR_KE
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  NOS_S=getnom_k(nos:nomenklat,0,2)
  ESKN_KODS=NOM:MUITAS_KODS
  IZC_V_KODS=NOM:IZC_V_KODS
  SVARS=NOM:SVARSKG
  BRW1::NOS:KEKSIS = NOS:KEKSIS
  BRW1::NOS:DOK_NR = NOS:DOK_NR
  BRW1::NOS:KATALOGA_NR = NOS:KATALOGA_NR
  BRW1::ESKN_KODS = ESKN_KODS
  BRW1::nos_s = nos_s
  BRW1::NOS:DAUDZUMS = NOS:DAUDZUMS
  BRW1::NOS:T_DAUDZUMS = NOS:T_DAUDZUMS
  BRW1::NOS:I_DAUDZUMS = NOS:I_DAUDZUMS
  BRW1::NOS:SUMMAV = NOS:SUMMAV
  BRW1::NOS:val = NOS:val
  BRW1::SVARS = SVARS
  BRW1::IZC_V_KODS = IZC_V_KODS
  BRW1::PAR_NR = PAR_NR
  BRW1::FILTRS = FILTRS
  BRW1::NOS:PAR_KE = NOS:PAR_KE
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert)
      POST(Event:Accepted,?Change)
      POST(Event:Accepted,?Delete)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => NOS:DOK_NR
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert)
    OF DeleteKey
      POST(Event:Accepted,?Delete)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      NOS:DOK_NR = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOLPAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(NOS:PARKE_KEY)
      RESET(NOS:PARKE_KEY,BRW1::HighlightedPosition)
    ELSE
      NOS:PAR_KE = PAR_NR
      SET(NOS:PARKE_KEY,NOS:PARKE_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'NOS:PAR_KE = PAR_NR AND ((~FILTRS OR NOS:DOK_NR=FILTRS )  AND NOS:RS=''' & |
    'S'')'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change{Prop:Disable} = 0
    ?Delete{Prop:Disable} = 0
  ELSE
    CLEAR(NOS:Record)
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
    ?Delete{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    NOS:PAR_KE = PAR_NR
    SET(NOS:PARKE_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'NOS:PAR_KE = PAR_NR AND ((~FILTRS OR NOS:DOK_NR=FILTRS )  AND NOS:RS=''' & |
    'S'')'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW1::SortOrder
  OF 1
    PAR_NR = BRW1::Sort1:Reset:PAR_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=?Insert
  BrowseButtons.ChangeButton=?Change
  BrowseButtons.DeleteButton=?Delete
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(NOLPAS,0)
  CLEAR(NOS:Record,0)
  CASE BRW1::SortOrder
  OF 1
    NOS:PAR_KE = BRW1::Sort1:Reset:PAR_NR
  END
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateNolPas) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNolPas
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(NOLPAS,0)
        CLEAR(NOS:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


