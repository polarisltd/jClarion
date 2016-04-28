                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETBIL_FIFO          FUNCTION (OPC,BILVERT,DAUDZUMS,ATLIKUMS_N) ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG

REALIZETS            DECIMAL(13,3)
!BILVERT              DECIMAL(14,2)
CTRL_I               DECIMAL(13,3)
VS_DAUDZUMS          DECIMAL(13,3)
VS_SUMMA             DECIMAL(13,3)
ERR                  BYTE

FIFO                 QUEUE,PRE(F)
KEY                    STRING(10)
DATUMS                 LONG
D_K                    string(2)
NOL_NR                 BYTE
DAUDZUMS               DECIMAL(11,3)
SUMMA                  DECIMAL(11,2)
                     .

  CODE                                            ! Begin processed code
!
! JÂBÛT POZICIONÇTAM NOL_KOPS
!
! OPC: 1-SARÇÍINÂT ATLIKUMUS:IN -
!                            OUT-DAUDZUMS,BILVERT,ATLIKUMS_N[]
!
!

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

!  IF NOL_KOPS::USED=0
!     CHECKOPEN(NOL_KOPS,1)
!  .
!  NOL_KOPS::USED+=1

  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1

  REALIZETS=0
  BILVERT=0
  DAUDZUMS=0
  CLEAR(ATLIKUMS_N)
  ERR=0
  B_DAT=DATE(12,31,DB_GADS)

! STOP(KOPS:NOMENKLAT&'U='&KOPS:U_NR)
!----------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI, SASKAITAM REALIZÂCIJU UN ATLIKUMUS NOLIKTAVÂS,F:------

  CLEAR(FIFO:RECORD)
  FIFO:U_NR=KOPS:U_NR
  FIFO:DATUMS=DATE(1,1,DB_GADS)
  SET(FIFO:NR_KEY,FIFO:NR_KEY)
  LOOP
     NEXT(NOL_FIFO)
     IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND FIFO:DATUMS<=B_DAT) THEN BREAK.
     F:KEY     =FIFO:DATUMS&FIFO:D_K
     F:DATUMS  =FIFO:DATUMS
     F:NOL_NR  =FIFO:NOL_NR
     F:D_K     =FIFO:D_K
     F:DAUDZUMS=FIFO:DAUDZUMS
     F:SUMMA   =FIFO:SUMMA
     ADD(FIFO)

     CASE FIFO:D_K
     OF 'A '
        IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
           REALIZETS+=ABS(FIFO:DAUDZUMS)
        ELSE
           VS_DAUDZUMS+=FIFO:DAUDZUMS
           VS_SUMMA+=FIFO:SUMMA
        .
        ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
     OF 'D '
     OROF 'DR'
        IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
           REALIZETS+=ABS(FIFO:DAUDZUMS)
        ELSE
           VS_DAUDZUMS+=FIFO:DAUDZUMS
           VS_SUMMA+=FIFO:SUMMA
        .
        ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
     OF 'DI'
        ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
        CTRL_I+=FIFO:DAUDZUMS
     OF 'K '
!        IF FIFO:DAUDZUMS<0 AND IS[FIFO:NOL_NR]='I' !PÇRKAM
!           F:D_K     ='D'
!           F:DAUDZUMS=ABS(FIFO:DAUDZUMS)
!           F:SUMMA   =ABS(FIFO:SUMMA)
!           PUT(FIFO)
!           VS_DAUDZUMS+=FIFO:DAUDZUMS
!           VS_SUMMA+=FIFO:SUMMA
!        ELSE
           REALIZETS+=FIFO:DAUDZUMS   !JA - ,LAI SAMAZINA REALIZÂCIJU,JA PIEPRASÎTS STORNÇT
!        .
        ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
     OF 'KR' !PERIODA BEIGÂS UZ RAÞOÐANU NEDRÎKST BÛT ATLIKUMI....???
        REALIZETS+=FIFO:DAUDZUMS
        ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
     OF 'KI'
        ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
        CTRL_I-=FIFO:DAUDZUMS
     .
  .
  IF CTRL_I
     ERR=2 !'IP KÏÛDA'
  .
  CASE GL:FMI_TIPS
  OF 'FIFO'

!---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
     SORT(FIFO,F:KEY)
     GET(FIFO,0)
! STOP(KOPS:NOMENKLAT&'RF='&RECORDS(FIFO))
     LOOP F#=1 TO RECORDS(FIFO)
       GET(FIFO,F#)
       IF ~INSTRING(F:D_K,'A D DR',2) THEN CYCLE.
       IF F:DAUDZUMS<0  THEN CYCLE.   !MÇS ESAM ATGRIEZUÐI, JAU PIESKAITÎJÂM REALIZÂCIJAI
                                      !VADÎBAS ATSKAITEI VIENKÂRÐI IGNORÇJAM
       IF REALIZETS > F:DAUDZUMS
          REALIZETS-=F:DAUDZUMS       !NO KOPÇJÂS REALIZÂCIJAS ATÒEMAM ÐITO IENÂKUÐO DAUDZUMU
       ELSIF REALIZETS
          BILVERT=(F:SUMMA/F:DAUDZUMS)*(F:DAUDZUMS-REALIZETS)
          DAUDZUMS=F:DAUDZUMS-REALIZETS
          REALIZETS=0
       ELSE                           !atlikums,nav realizçts
          BILVERT+=F:SUMMA
          DAUDZUMS+=F:DAUDZUMS
       .
     .
     IF REALIZETS <0    !ATGRIEZTA PRECE, KURAI NAV NE D NE S
        DAUDZUMS=ABS(REALIZETS)
        BILVERT=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*DAUDZUMS  !PIC
        ERR=3 !'PIC'
     ELSIF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
        ERR=4 !RE KÏÛDA'
     .
     FREE(FIFO)
  ELSE
!---------------------RÇÍINAM VS------------------
     IF REALIZETS > VS_DAUDZUMS !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
        ERR=4 !'RE KÏÛDA'
     ELSE
        DAUDZUMS=VS_DAUDZUMS-REALIZETS
        BILVERT=VS_SUMMA/VS_DAUDZUMS*DAUDZUMS
     .
  .
!-------------------------------------------------
  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
  RETURN(ERR)





OMIT('MARIS')

!----------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI, SASKAITAM REALIZÂCIJU UN ATLIKUMUS NOLIKTAVÂS,F:------

           CLEAR(FIFO:RECORD)
           FIFO:U_NR=KOPS:U_NR
           FIFO:DATUMS=DATE(1,1,DB_GADS)
           SET(FIFO:NR_KEY,FIFO:NR_KEY)
           LOOP
              NEXT(NOL_FIFO)
              IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND FIFO:DATUMS<=B_DAT) THEN BREAK.
              IF ~INRANGE(FIFO:NOL_NR,1,NOL_SK) AND INSTRING(FIFO:D_K,'A D DIK KIKR',2)
                 ERR='NR KÏÛDA'
                 CTRL_I=0
                 FIFO:NOL_NR=1
              .
              F:KEY     =FIFO:DATUMS&FIFO:D_K
              F:DATUMS  =FIFO:DATUMS
              F:NOL_NR  =FIFO:NOL_NR
              F:D_K     =FIFO:D_K
              F:DAUDZUMS=FIFO:DAUDZUMS
              F:SUMMA   =FIFO:SUMMA
              ADD(FIFO)

              CASE FIFO:D_K
              OF 'A '
                 IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                    REALIZETS+=ABS(FIFO:DAUDZUMS)
                 ELSE
                    VS_DAUDZUMS+=FIFO:DAUDZUMS
                    VS_SUMMA+=FIFO:SUMMA
                 .
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
              OF 'D '
                 IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                    REALIZETS+=ABS(FIFO:DAUDZUMS)
                 ELSE
                    VS_DAUDZUMS+=FIFO:DAUDZUMS
                    VS_SUMMA+=FIFO:SUMMA
                 .
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
              OF 'DI'
                 ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS
                 CTRL_I+=FIFO:DAUDZUMS
              OF 'K '
                 IF FIFO:DAUDZUMS<0 AND VMIS[FIFO:NOL_NR,2]='I' !PÇRKAM
                    F:D_K     ='D'
                    F:DAUDZUMS=ABS(FIFO:DAUDZUMS)
                    F:SUMMA   =ABS(FIFO:SUMMA)
                    PUT(FIFO)
                    VS_DAUDZUMS+=FIFO:DAUDZUMS
                    VS_SUMMA+=FIFO:SUMMA
                 ELSE
                    REALIZETS+=FIFO:DAUDZUMS   !JA - ,LAI SAMAZINA REALIZÂCIJU,JA PIEPRASÎTS STORNÇT
                 .
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
              OF 'KR' !PERIODA BEIGÂS UZ RAÞOÐANU NEDRÎKST BÛT ATLIKUMI....???
                 REALIZETS+=FIFO:DAUDZUMS
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
              OF 'KI'
                 ATLIKUMS_N[FIFO:NOL_NR]-=FIFO:DAUDZUMS
                 CTRL_I-=FIFO:DAUDZUMS
              .
           .
           IF CTRL_I
              ERR='IP KÏÛDA'
           .
           CASE GL:FMI_TIPS
           OF 'FIFO'
!---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
              SORT(FIFO,F:KEY)
              GET(FIFO,0)
              LOOP F#=1 TO RECORDS(FIFO)
                GET(FIFO,F#)
                IF ~INSTRING(F:D_K,'A D ',2) THEN CYCLE.
                IF F:DAUDZUMS<0  THEN CYCLE.   !MÇS ESAM ATGRIEZUÐI, JAU PIESKAITÎJÂM REALIZÂCIJAI
                                               !VADÎBAS ATSKAITEI VIENKÂRÐI IGNORÇJAM
                IF REALIZETS > F:DAUDZUMS
                   REALIZETS-=F:DAUDZUMS
                ELSIF REALIZETS
                   BILVERT=(F:SUMMA/F:DAUDZUMS)*(F:DAUDZUMS-REALIZETS)
                   DAUDZUMS=F:DAUDZUMS-REALIZETS
                   REALIZETS=0
                ELSE                           !atlikums,nav realizçts
                   BILVERT+=F:SUMMA
                   DAUDZUMS+=F:DAUDZUMS
                .
              .
              IF REALIZETS <0    !ATGRIEZTA PRECE, KURAI NAV NE D NE S
                 DAUDZUMS=ABS(REALIZETS)
                 BILVERT=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*DAUDZUMS  !PIC
                 ERR='PIC'
              ELSIF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                 ERR='RE KÏÛDA'
              .
              FREE(FIFO)

!              CLEAR(FIFO:RECORD)
!              FIFO:U_NR=KOPS:U_NR
!              FIFO:DATUMS=DATE(1,1,DB_GADS)
!              SET(FIFO:NR_KEY,FIFO:NR_KEY)
!              LOOP
!                 NEXT(NOL_FIFO)
!                 IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND FIFO:DATUMS<=B_DAT) THEN BREAK.
!                 IF ~INSTRING(FIFO:D_K,'A D ',2) THEN CYCLE.
!                 IF FIFO:DAUDZUMS>0
!                    IF REALIZETS > FIFO:DAUDZUMS   !ðitais FIFO:daudzums pilnîbâ realizçts
!                       REALIZETS-=FIFO:DAUDZUMS
!                    ELSIF REALIZETS                !no  ðitâ FIFO:daudzuma realizçta daïa
!                       BILVERT=(FIFO:SUMMA/FIFO:DAUDZUMS)*(FIFO:DAUDZUMS-REALIZETS)
!                       DAUDZUMS=FIFO:DAUDZUMS-REALIZETS
!                       REALIZETS=0
!   !           STOP(KOPS:NOMENKLAT&'1-'&FIFO:DAUDZUMS&'-'&REALIZETS)
!                    ELSE                           !atlikums,nav realizçts
!                       BILVERT+=FIFO:SUMMA
!                       DAUDZUMS+=FIFO:DAUDZUMS
!   !           STOP(KOPS:NOMENKLAT&'2-'&FIFO:DAUDZUMS&'-'&REALIZETS)
!                    .
!                 .
!              .
!              IF REALIZETS >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
!   !                 STOP('REALIZÂCIJAS KÏÛDA:'&KOPS:NOMENKLAT&'L:'&L#&'A:'&REALIZETS)
!                 ERR='R KÏÛDA'
!              .
           ELSE
!---------------------RÇÍINAM VS------------------
              IF REALIZETS > VS_DAUDZUMS !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                 ERR='RE KÏÛDA'
              .
              DAUDZUMS=VS_DAUDZUMS-REALIZETS
              BILVERT=VS_SUMMA/VS_DAUDZUMS*DAUDZUMS
!                 STOP(L#&' '&FMI[L#]&'= '&VS_SUMMA[L#]&'/'&VS_DAUDZUMS[L#]&'*'&REALIZ_A[L#])
!-------------------------------------------------
           .
           VID=BILVERT/DAUDZUMS
           BILVERT_K+=BILVERT
           LOOP I#= 1 TO NOL_SK
              DAUDZUMS_N[I#]+=ATLIKUMS_N[I#]
              BILVERT_N[I#]+=ATLIKUMS_N[I#]*VID
           .
           IF DAUDZUMS OR ERR     !IR ATLIKUMS VAI IR KÏÛDA
              IF ERR AND ERR='PIC'
                 BRIK+=1
              ELSIF ERR
                 ERRK+=1
              .
              IF ~F:IDP OR (ERR AND F:IDP) !TIKAI KÏÛDAS
                 IF F:DBF = 'W'
                   PRINT(RPT:DETAIL)
                 ELSE
                   OUTA:LINE=NR&CHR(9)&KOPS:NOMENKLAT&CHR(9)&KOPS:NOS_S&CHR(9)&ERR&CHR(9)&FORMAT(VID,@N_9.3)&CHR(9)&FORMAT(DAUDZUMS,@N_11.3)&CHR(9)&FORMAT(BILVERT,@N_10.2)
                   ADD(OUTFILEANSI)
                 END
              .
              DO PERFORMR_TABLE   !PÇC RAÞOTÂJU KODIEM
              DO PERFORMB_TABLE   !PÇC BKK
           .
        .
        .

MARIS
IZZFILTbilform PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
par_filtrs           STRING(1)
SAV_PAR_FILTRS       STRING(1)
PAR_NOS_S            STRING(20)
GADS1                DECIMAL(4)
GADS2                DECIMAL(4)
List1:Queue          QUEUE,PRE()
Avots1               STRING(20)
                     END
List2:Queue          QUEUE,PRE()
Avots2               STRING(20)
                     END
window               WINDOW('Norâdiet periodu'),AT(,,255,147),CENTER,IMM,GRAY,MDI
                       ENTRY(@n4),AT(13,13,25,12),USE(GADS1),HIDE
                       STRING('.g.'),AT(40,13),USE(?StringG1),HIDE
                       LIST,AT(50,13,68,12),USE(Avots1),HIDE,FORMAT('80L~List 1 : Queue~@s20@'),DROP(12),FROM(List1:Queue)
                       ENTRY(@n4),AT(140,13,24,12),USE(GADS2),HIDE
                       STRING('.g.'),AT(167,13),USE(?StringG2),HIDE
                       LIST,AT(177,13,68,12),USE(Avots2),HIDE,FORMAT('80L~List 2 : Queue~@s20@'),DROP(12),FROM(List2:Queue)
                       LINE,AT(123,19,12,0),USE(?Line1),COLOR(COLOR:Black)
                       STRING('Nomenklatûra:'),AT(10,40),USE(?S:nomenklat)
                       ENTRY(@s21),AT(8,51,89,9),USE(NOMENKLAT),DISABLE,UPR
                       OPTION('Filtrs pçc partnera'),AT(129,39,119,70),USE(par_filtrs),BOXED,HIDE
                         RADIO('Visi'),AT(137,50),USE(?par_filtrs:Radio1),HIDE
                         RADIO('Konkrçts'),AT(138,85),USE(?par_filtrs:Radio2),HIDE
                       END
                       STRING('tips:'),AT(162,50,14,10),USE(?PromptTips),HIDE
                       STRING(@s6),AT(177,50),USE(PAR_TIPS),HIDE
                       BUTTON('&Mainît'),AT(205,48,39,12),USE(?MT),HIDE
                       PROMPT('Grupa:'),AT(143,63),USE(?PromptGRUPA),HIDE
                       ENTRY(@s6),AT(167,62,32,10),USE(PAR_GRUPA),HIDE,FONT('Fixedsys',,,,CHARSET:BALTIC)
                       BUTTON('&Mainît'),AT(186,83,39,12),USE(?MP),HIDE
                       STRING(@s20),AT(144,96),USE(PAR_NOS_S),HIDE
                       BUTTON('D&rukas parametri'),AT(170,111,79,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('Analizçt arî neapstiprinâtâs'),AT(5,67,96,14),USE(?ButtonRs),HIDE
                       IMAGE('CHECK3.ICO'),AT(103,66,16,15),USE(?ImageRs),HIDE
                       STRING('1234567'),AT(170,74,28,8),USE(?String7),FONT('Fixedsys',,COLOR:Gray,FONT:regular,CHARSET:BALTIC)
                       OPTION('Izdrukas &Formâts'),AT(5,85,121,24),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(10,95,30,10),USE(?F:DBF:Radio1)
                         RADIO('Word'),AT(40,95),USE(?F:DBF:WORD),VALUE('A')
                         RADIO('Excel'),AT(75,95),USE(?F:DBF:EXCEL),VALUE('E')
                       END
                       BUTTON('&OK'),AT(170,127,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(211,127,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ~F:DBF THEN F:DBF='W'.
  par_filtrs = 'V'
  IF par_nr=0 THEN PAR_NR=999999999.
  SAV_PAR_FILTRS = PAR_FILTRS
  PAR_GRUPA=''
  PAR_TIPS='EFCNIR'
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !
  ! OPCIJA 1=1:GADS
  !        2=1:MEN,CET,G
  !         =2:MEN
  !         =3:G
  !        3=1:NOMENKLATÛRA
  !        4=1:PARTNERIS
  !        5=1:RS
  gads1=GADS
  gads2=GADS
  avots1='Janvâris'
  ADD(LIST1:QUEUE)
  avots1='Februâris'
  ADD(LIST1:QUEUE)
  avots1='Marts'
  ADD(LIST1:QUEUE)
  avots1='Aprîlis'
  ADD(LIST1:QUEUE)
  avots1='Maijs'
  ADD(LIST1:QUEUE)
  avots1='Jûnijs'
  ADD(LIST1:QUEUE)
  avots1='Jûlijs'
  ADD(LIST1:QUEUE)
  avots1='Augusts'
  ADD(LIST1:QUEUE)
  avots1='Septembris'
  ADD(LIST1:QUEUE)
  avots1='Oktobris'
  ADD(LIST1:QUEUE)
  avots1='Novembris'
  ADD(LIST1:QUEUE)
  avots1='Decembris'
  ADD(LIST1:QUEUE)
  !!GET(LIST1:QUEUE,month(alp:yyyymm))
  avots2='Janvâris'
  ADD(LIST2:QUEUE)
  avots2='Februâris'
  ADD(LIST2:QUEUE)
  avots2='Marts'
  ADD(LIST2:QUEUE)
  avots2='Aprîlis'
  ADD(LIST2:QUEUE)
  avots2='Maijs'
  ADD(LIST2:QUEUE)
  avots2='Jûnijs'
  ADD(LIST2:QUEUE)
  avots2='Jûlijs'
  ADD(LIST2:QUEUE)
  avots2='Augusts'
  ADD(LIST2:QUEUE)
  avots2='Septembris'
  ADD(LIST2:QUEUE)
  avots2='Oktobris'
  ADD(LIST2:QUEUE)
  avots2='Novembris'
  ADD(LIST2:QUEUE)
  avots2='Decembris'
  ADD(LIST2:QUEUE)
  !!GET(LIST2:QUEUE,month(alp:yyyymm))
  RS='A'
  LOOP I#=1 TO 6
     IF OPCIJA[I#] <> '0'
        EXECUTE I#
           BEGIN
              UNHIDE(?GADS1)                       !  1  Laika periods
              UNHIDE(?GADS2)
              UNHIDE(?StringG1)
              UNHIDE(?StringG2)
              UNHIDE(?AVOTS1)
              UNHIDE(?AVOTS2)
           .
           ENABLE(?NOMENKLAT)                      !  2  Filtrs pçc nomenklatûras
           BEGIN                                   !  4  =>  3 Filtrs pçc partnera
              UNHIDE(?PAR_FILTRS)
              UNHIDE(?PAR_NOS_S)
  !!            UNHIDE(?MP)
              unhide(?par_filtrs:Radio1)
              unhide(?par_filtrs:Radio2)
              unhide(?PromptGrupa)
              unhide(?par_grupa)
              IF ~(par_nr=999999999)
                  PAR_NOS_S=GETPAR_K(PAR_NR,0,1)
                  par_filtrs = 'K'
                  SAV_PAR_FILTRS = PAR_FILTRS
              .
              IF OPCIJA[I#]='2'                    ! TIKAI KONKRÇTS
                  par_filtrs = 'K'
                  UNHIDE(?MP)
                  HIDE(?PAR_GRUPA)
                  HIDE(?PAR_FILTRS:RADIO1)
                  HIDE(?PromptGRUPA)
              .
              IF OPCIJA[I#]='3'                    ! GRUPA UN VISI
                  HIDE(?PAR_FILTRS:RADIO2)
              .
           .
           BEGIN
              IF ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1')
                 UNHIDE(?ButtonRs)     !  5=>4  ANALIZÇT ARÎ NEAPSTIPRINÂTÂS
              .
           .
           BEGIN                       !  6=>5  Uzbûvçt DBF failu
              IF OPCIJA[I#]='2'        !  GATAVS WMF/TXT
                 UNHIDE(?F:DBF)
              .
           .
           BEGIN
              UNHIDE(?PAR_FILTRS)       !  7=>6
              UNHIDE(?PromptTips)
              UNHIDE(?PAR_TIPS)
              UNHIDE(?PromptGrupa)
              UNHIDE(?PAR_GRUPA)
              UNHIDE(?MT)
              PAR_GRUPA = ''
              IF OPCIJA[I#]='2'         ! KONKRÇTS
                 PAR_FILTRS='K'
                 HIDE(?PAR_GRUPA)
                 HIDE(?PAR_FILTRS:RADIO1)
                 HIDE(?PromptTips)
                 HIDE(?PAR_TIPS)
                 HIDE(?PromptGrupa)
                 HIDE(?MT)
              ELSIF PAR_NR AND ~(PAR_NR=999999999)
                 IF GETPAR_K(PAR_NR,0,1)
                    UNHIDE(?PAR_NOS_S)
                    PAR_FILTRS='K'
                    SAV_PAR_FILTRS=PAR_FILTRS
                 ELSE
                    PAR_NR=999999999
                    PAR_FILTRS = 'V'
                    SAV_PAR_FILTRS=PAR_FILTRS
                 .
              ELSE
                 PAR_NR=999999999
                 PAR_FILTRS = 'V'
                 SAV_PAR_FILTRS=PAR_FILTRS
              .
           END
        .
     .
  .
  !?select(?menesis,MEN_NR)
  ACCEPT
    IF ~(SAV_PAR_FILTRS=PAR_FILTRS)
        CASE PAR_FILTRS
        OF 'V'
            IF OPCIJA[7]=1
                UNHIDE(?PromptTips)
                UNHIDE(?PAR_TIPS)
                UNHIDE(?MT)
            ELSE
                HIDE(?PromptTips)
                HIDE(?PAR_TIPS)
                HIDE(?MT)
            END
            PAR_NR = 999999999
            HIDE(?PAR_NOS_S)
            HIDE(?MP)
            UNHIDE(?PROMPTGRUPA)
            UNHIDE(?PAR_GRUPA)
            SELECT(?PAR_GRUPA)
        OF 'K'
            IF OPCIJA[7]=1
                UNHIDE(?PAR_TIPS)
                UNHIDE(?PromptTips)
                UNHIDE(?MT)
            ELSE
                HIDE(?MT)
                HIDE(?PAR_TIPS)
                HIDE(?promptTips)
            END
            UNHIDE(?PAR_NOS_S)
            UNHIDE(?MP)
            HIDE(?PAR_GRUPA)
            HIDE(?PromptGrupa)
            GlobalRequest = SelectRecord
            BrowsePAR_K
            LocalResponse = GlobalResponse
            GlobalResponse = RequestCancelled
            IF LocalResponse = RequestCompleted
              PAR_NR=PAR:U_NR
              PAR_NOS_S=PAR:NOS_S
            ELSE
              PAR_NR=999999999
              PAR_NOS_S=''
            END
            LocalResponse = RequestCancelled
        END
        SAV_PAR_FILTRS = PAR_FILTRS
    .
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?GADS1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?Avots1
      CASE EVENT()
      OF EVENT:Accepted
        S_DAT = DATE(avots1,1,GADS)
      END
    OF ?Avots2
      CASE EVENT()
      OF EVENT:Accepted
        B_DAT = DATE(avots2,1,GADS)
      END
    OF ?MT
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SEL_PAR_TIPS5
        DISPLAY(?PAR_TIPS)
      END
    OF ?MP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePar_K
        LocalResponse = GlobalResponse
        GlobalResponse = RequestCancelled
        IF LocalResponse = RequestCompleted
            PAR_NR = PAR:U_NR
            PAR_NOS_S = PAR:NOS_S
        ELSE
            LocalResponse = RequestCancelled
            DO ProcedureReturn
        END
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?ButtonRs
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF RS='A'
           RS='V'
           UNHIDE(?IMAGERS)
        ELSE
           RS='A'
           HIDE(?IMAGERS)
        .
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        CASE avots1
        OF 'Janvâris'
          S_DAT=DATE(1,1,GADS1)
        OF 'Februâris'
          S_DAT=DATE(2,1,GADS1)
        OF 'Marts'
          S_DAT=DATE(3,1,GADS1)
        OF 'Aprîlis'
          S_DAT=DATE(4,1,GADS1)
        OF 'Maijs'
          S_DAT=DATE(5,1,GADS1)
        OF 'Jûnijs'
          S_DAT=DATE(6,1,GADS1)
        OF 'Jûlijs'
          S_DAT=DATE(7,1,GADS1)
        OF 'Augusts'
          S_DAT=DATE(8,1,GADS1)
        OF 'Septembris'
          S_DAT=DATE(9,1,GADS1)
        OF 'Oktobris'
          S_DAT=DATE(10,1,GADS1)
        OF 'Novembris'
          S_DAT=DATE(11,1,GADS1)
        OF 'Decembris'
          S_DAT=DATE(12,1,GADS1)
        .
        CASE avots2
        OF 'Janvâris'
          B_DAT=DATE(1,1,GADS2)
        OF 'Februâris'
          B_DAT=DATE(2,1,GADS2)
        OF 'Marts'
          B_DAT=DATE(3,1,GADS2)
        OF 'Aprîlis'
          B_DAT=DATE(4,1,GADS2)
        OF 'Maijs'
          B_DAT=DATE(5,1,GADS2)
        OF 'Jûnijs'
          B_DAT=DATE(6,1,GADS2)
        OF 'Jûlijs'
          B_DAT=DATE(7,1,GADS2)
        OF 'Augusts'
          B_DAT=DATE(8,1,GADS2)
        OF 'Septembris'
          B_DAT=DATE(9,1,GADS2)
        OF 'Oktobris'
          B_DAT=DATE(10,1,GADS2)
        OF 'Novembris'
          B_DAT=DATE(11,1,GADS2)
        OF 'Decembris'
          B_DAT=DATE(12,1,GADS2)
        .
        LocalResponse = RequestCompleted
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LOCALRESPONSE = REQUESTCANCELLED
        BREAK
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
SPZ_Invoice          PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO

VAT                  STRING(25)
BKODS_REK            STRING(45)
SYS_TEL_FAX          STRING(45)
VARDS                STRING(30)
PAV_PAMAT            STRING(35)  !10/03/2014
SPEC_ATZ             STRING(120) !10/03/2014

PAR_NOS_P            STRING(45)
PAR_VAT              STRING(30)
PAR_ADRESE           STRING(60)
PAR_ADRESEF          STRING(60)
PAR_BANKA            STRING(31)
PAR_BKODS_REK        STRING(45)
PAR_TEL_FAX          STRING(45)

RET                  BYTE
!sys_nom_cit          LIKE(sys:nom_cit)

N_TABLE             QUEUE,PRE(N)
EUCODE                STRING(10)    !2
NOMENKLAT             STRING(21)    !4
COL5                  DECIMAL(12,2) !QUANTITY
COL6                  DECIMAL(12,2) !NETO SVARS
COL7                  DECIMAL(12,2)
COL8                  DECIMAL(12,2)
COL9                  DECIMAL(12,2)
COL10                 DECIMAL(12,2)
                    .
COL3_TEXT             STRING(40)
COL4_TEXT             STRING(10)
COL5_TEXT             STRING(7)
COL6_TEXT             STRING(8)
COL61_TEXT            STRING(2)
COL6_BRUTTO           STRING(11)
COL7_TEXT             STRING(10)
COL8_TEXT             STRING(11)
COL81_TEXT             STRING(11)
COL9_TEXT             STRING(11)
COL91_TEXT             STRING(11)
COL10_TEXT             STRING(11)

NPK                   BYTE
COL3                  STRING(50)
COL4                  STRING(22)
COL5                  STRING(6)
COL6                  STRING(10)
COL7                  STRING(10)
COL8                  DECIMAL(12,2)
COL9                  DECIMAL(12,2)
COL10                 DECIMAL(12,2)

COL5K                 STRING(10)
COL6K                 STRING(10)
COL6KB                DECIMAL(12,2) !NETO SVARS
COL6KKB               DECIMAL(12,2) !BRUTO SVARS
COL8K                 DECIMAL(12,2)
COL8LVL               DECIMAL(12,2)
COL5KK                DECIMAL(12,2)
COL6KK                DECIMAL(12,2)
atlaide               DECIMAL(12,2)
SUMV                  STRING(120)
line                  STRING(120)

TermsofDEL:Queue  QUEUE,PRE()
TermsofDEL          STRING(30)
                  .

TermsOfPAY            STRING(20)
CMR                   STRING(20)
country               STRING(20)
FORMA                 STRING(1)
VAT28ITEMS            STRING(15)
VAT28                 STRING(100)
TOTAL_DISC            STRING(45)
SYS_PARAKSTS          STRING(25)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(146,500,8000,10500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,3208),USE(?unnamed)
         STRING('INVOICE'),AT(3469,52,3906,573),USE(?StringINVOICE),RIGHT,FONT(,36,COLOR:Gray,FONT:bold)
         STRING('INVOICE NO:'),AT(4563,625,1781,156),USE(?StringINVOICE2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(6406,625,729,156),USE(PAV:REK_NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('DATE:'),AT(5563,781,781,156),USE(?String1:5),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(6406,781,573,156),USE(PAV:DATUMS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('SELLER:'),AT(406,1010,469,156),USE(?String1:8),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(156,1167,3750,208),USE(client),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(948,1354,2240,156),USE(VAT),CENTER,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@s30),AT(4719,1354,2240,156),USE(PAR_VAT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@s60),AT(104,1510,3750,156),USE(GL:adrese),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(396,1677,3333,156),USE(SYS_TEL_FAX),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('BUYER:'),AT(4104,1010,469,156),USE(?String1:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(3854,3010,4021,146),USE(SPEC_ATZ),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3958,1167,3750,208),USE(PAR_nos_p),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(3906,1510,4063,156),USE(PAR_adrese),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4167,1802,3333,156),USE(PAR_BKODS_REK),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(4667,1958,2292,156),USE(PAR_BANKA),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4198,1656,3333,156),USE(PAR_TEL_FAX),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Contract:'),AT(177,2188,521,156),USE(?String1:12),TRN,LEFT
         STRING(@s45),AT(1198,2188,3594,156),USE(PAR:LIGUMS),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Terms of delivery:'),AT(177,2323,990,156),USE(?String1:9),TRN,LEFT
         STRING(@s30),AT(1198,2323,1615,156),USE(TermsOfDel),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Place of loading:'),AT(177,2458,990,156),USE(?String1:10),TRN,LEFT
         STRING(@s60),AT(1198,2458,4427,156),USE(SYS:adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Place of discharge:'),AT(177,2604,990,156),USE(?String1:11),TRN,LEFT
         STRING(@s60),AT(1198,2594,4479,156),USE(PAR_adreseF,,?PAR_adreseF:2),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('CMR:'),AT(177,2740,313,156),USE(?String1:13),TRN,LEFT
         STRING(@s20),AT(1198,2729,1615,156),USE(CMR),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Country of origin:'),AT(177,2865,938,156),USE(?String1:14),TRN,LEFT
         STRING(@s20),AT(1198,2865,1615,156),USE(COUNTRY),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Description of goods:'),AT(177,3021,1063,156),USE(?String1:15),TRN,LEFT
         STRING(@s35),AT(1271,3010,2594,188),USE(PAV_PAMAT),TRN,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD1 DETAIL,AT(,10,,302),USE(?unnamed:2)
         LINE,AT(10,10,0,313),USE(?Line8:41),COLOR(COLOR:Black)
         LINE,AT(1000,10,0,313),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(3938,0,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5875,10,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(6510,10,0,313),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(7177,0,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         LINE,AT(10,0,7865,0),USE(?Line55:3),COLOR(COLOR:Black)
         STRING('EU Code'),AT(365,83,625,167),USE(?String38:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(1094,83,2656,167),USE(col3_text),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(4135,83,813,167),USE(col4_text),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(5438,73,417,167),USE(col5_text),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s9),AT(5896,63,625,167),USE(COL6_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(6542,73,625,167),USE(COL7_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(7198,73,667,167),USE(COL8_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(344,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(10,281,7865,0),USE(?Line55:4),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,156),USE(?unnamed:6)
         LINE,AT(1000,-10,0,177),USE(?Line8:30),COLOR(COLOR:Black)
         STRING(@s50),AT(1042,0,2865,156),USE(COL3),LEFT
         STRING(@s22),AT(3958,0,,156),USE(COL4),LEFT
         STRING(@S10),AT(365,0,625,156),USE(N:EUCODE),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3938,-10,0,177),USE(?Line8:12),COLOR(COLOR:Black)
         LINE,AT(5406,-10,0,177),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@S6),AT(5438,0,440,156),USE(COL5),CENTER
         LINE,AT(6510,-10,0,177),USE(?Line8:5),COLOR(COLOR:Black)
         LINE,AT(5875,-10,0,177),USE(?Line8:26),COLOR(COLOR:Black)
         STRING(@S10),AT(6542,0,625,156),USE(COL7),RIGHT(1)
         LINE,AT(7177,-10,0,177),USE(?Line8:27),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7219,0,625,156),USE(COL8),RIGHT(1)
         STRING(@S10),AT(5917,0,573,156),USE(N:COL6),TRN,RIGHT(1)
         LINE,AT(7865,-10,0,177),USE(?Line8:28),COLOR(COLOR:Black)
         STRING(@N3),AT(42,0,300,156),USE(NPK),TRN,CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10,-10,0,177),USE(?Line8:42),COLOR(COLOR:Black)
         LINE,AT(344,-10,0,177),USE(?Line8:7),COLOR(COLOR:Black)
       END
PAGE_HEAD1A DETAIL,AT(,10,,302),USE(?unnamed:7)
         LINE,AT(10,10,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(344,0,0,313),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(3271,10,0,313),USE(?Line8:24),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,313),USE(?Line8:22),COLOR(COLOR:Black)
         LINE,AT(5219,0,0,313),USE(?Line8:34),COLOR(COLOR:Black)
         LINE,AT(5781,10,0,313),USE(?Line8:36),COLOR(COLOR:Black)
         LINE,AT(6458,10,0,313),USE(?Line8:40),COLOR(COLOR:Black)
         LINE,AT(7115,0,0,313),USE(?Line8:39),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,313),USE(?Line8:221),COLOR(COLOR:Black)
         LINE,AT(21,0,7865,0),USE(?Line55:2),COLOR(COLOR:Black)
         STRING('Product description'),AT(469,73,1448,167),USE(?String1:3),TRN,LEFT,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s10),AT(3438,73,990,167),USE(col4_text,,?col4_text:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('QTY'),AT(4760,73,365,167),USE(?qty),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Unit'),AT(5344,73,365,167),USE(?Unit),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Unit price'),AT(5802,73,646,167),USE(?Unit:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Discount'),AT(6521,73,531,167),USE(?Unit:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(7135,73,729,167),USE(COL8_TEXT,,?COL8_TEXT:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10,281,7865,0),USE(?Line55:5),COLOR(COLOR:Black)
       END
detailA DETAIL,AT(,,,156),USE(?unnamed:9)
         STRING(@s50),AT(375,0,2865,156),USE(COL3,,?COL3:3),LEFT
         STRING(@s22),AT(3302,0,,156),USE(COL4,,?COL4:3),CENTER
         LINE,AT(4740,-10,0,177),USE(?Line8:23),COLOR(COLOR:Black)
         LINE,AT(5219,-10,0,177),USE(?Line8:33),COLOR(COLOR:Black)
         STRING(@S6),AT(4771,0,440,156),USE(COL5,,?COL5:2),CENTER
         LINE,AT(6458,-10,0,177),USE(?Line8:37),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,177),USE(?Line8:35),COLOR(COLOR:Black)
         STRING(@N_4.1),AT(6510,0,406,156),USE(N:COL10,,?N:COL10:2),RIGHT
         LINE,AT(7115,-10,0,177),USE(?Line8:38),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7219,0,625,156),USE(COL8,,?COL8:3),RIGHT(1)
         STRING(@S7),AT(5250,10,521,156),USE(NOM:MERVIEN),TRN,CENTER
         STRING('%'),AT(6927,0,167,156),USE(?String38:2S:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_9.2),AT(5844,0,594,156),USE(COL7,,?COL7:3),TRN,RIGHT(1)
         LINE,AT(7865,-10,0,177),USE(?Line8:328),COLOR(COLOR:Black)
         LINE,AT(3271,0,0,177),USE(?Line8:29),COLOR(COLOR:Black)
         STRING(@N3),AT(42,0,300,156),USE(NPK,,?NPK:8),TRN,CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10,-10,0,177),USE(?Line8:32),COLOR(COLOR:Black)
         LINE,AT(344,-10,0,177),USE(?Line8:87),COLOR(COLOR:Black)
       END
PAGE_HEAD1S DETAIL,AT(,,,354),USE(?unnamed:4)
         LINE,AT(10,10,0,313),USE(?Line8:2S),COLOR(COLOR:Black)
         LINE,AT(1000,10,0,313),USE(?Line8:9S),COLOR(COLOR:Black)
         LINE,AT(3042,0,0,313),USE(?Line8:17S),COLOR(COLOR:Black)
         LINE,AT(4500,0,0,313),USE(?Line8:19S),COLOR(COLOR:Black)
         LINE,AT(5146,0,0,313),USE(?Line8:20S),COLOR(COLOR:Black)
         LINE,AT(6292,0,0,313),USE(?Line8:22S),COLOR(COLOR:Black)
         LINE,AT(7000,0,0,313),USE(?Line8:23S),COLOR(COLOR:Black)
         LINE,AT(5615,0,0,313),USE(?Line8:20S:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,313),USE(?Line8:21S),COLOR(COLOR:Black)
         STRING('EU Code'),AT(365,115,625,167),USE(?String38:2S),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(1031,83,1792,167),USE(col3_text,,?col3_text:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(3573,83,677,167),USE(col4_text,,?col4_text:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(4552,83,563,167),USE(col5_text,,?col5_text:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(5635,83,667,167),USE(COL7_TEXT,,?COL7_TEXT:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Disc.'),AT(7563,21,302,167),USE(?String38:2S:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(6313,31,667,170),USE(COL9_TEXT,,?COL9_TEXT:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(7063,31,469,167),USE(COL8_TEXT,,?COL8_TEXT:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7552,0,0,313),USE(?Line8:23S:2),COLOR(COLOR:Black)
         STRING(@s11),AT(6313,167,667,170),USE(COL91_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7063,167,469,167),USE(PAV:VAL),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('%'),AT(7635,167,167,167),USE(?String38:2S:38),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(5229,167,281,167),USE(col61_text,,?col61_text:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(5177,31,417,167),USE(col6_text,,?col6_text:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(344,10,0,313),USE(?Line8:4S),COLOR(COLOR:Black)
         LINE,AT(10,323,7865,0),USE(?Line55:4S),COLOR(COLOR:Black)
         LINE,AT(10,0,7865,0),USE(?Line5:3S),COLOR(COLOR:Black)
       END
detailS DETAIL,AT(,,,156),USE(?unnamed:3)
         LINE,AT(1000,0,0,177),USE(?Line8:30S),COLOR(COLOR:Black)
         STRING(@s40),AT(1042,0,1979,156),USE(COL3,,?COL3:2),LEFT
         STRING(@s22),AT(3073,0,,156),USE(COL4,,?COL4:2),CENTER
         STRING(@S10),AT(365,0,625,156),USE(N:EUCODE,,?N:EUCODE:1),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3042,0,0,177),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(4500,0,0,177),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(5146,0,0,177),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(6292,0,0,177),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@S8),AT(6323,0,625,156),USE(COL9),TRN,CENTER
         STRING(@S10),AT(5646,0,625,156),USE(COL7,,?COL7:2),CENTER
         LINE,AT(6990,0,0,177),USE(?Line8:16),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(7021,10,531,156),USE(COL8,,?COL8:2),CENTER
         STRING(@N_4.1),AT(7583,10),USE(N:COL10),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(7552,0,0,177),USE(?Line8:20),COLOR(COLOR:Black)
         STRING(@S6),AT(5135,10,500,156),USE(N:COL6,,?N:COL6:3),TRN,CENTER
         LINE,AT(5625,0,0,177),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@S10),AT(4531,0,573,156),USE(N:COL5),TRN,CENTER(1)
         LINE,AT(7865,0,0,177),USE(?Line8:28S),COLOR(COLOR:Black)
         LINE,AT(10,10,0,177),USE(?Line8:19),COLOR(COLOR:Black)
         STRING(@N3),AT(42,0,300,156),USE(NPK,,?NPK:1),TRN,CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(344,0,0,177),USE(?Line8:7S),COLOR(COLOR:Black)
       END
detailCYR DETAIL,AT(,,,156)
         LINE,AT(1000,-10,0,177),USE(?Line8:30C),COLOR(COLOR:Black)
         STRING(@s50),AT(1042,0,2865,156),USE(COL3,,?COL3C),LEFT,FONT(,8,,,CHARSET:CYRILLIC)
         STRING(@s22),AT(3990,0,,156),USE(COL4,,?COL4C),LEFT,FONT(,8,,,CHARSET:CYRILLIC)
         STRING(@s10),AT(365,0,625,156),USE(N:EUCODE,,?N:EUCODEC),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3938,-10,0,177),USE(?Line8:12C),COLOR(COLOR:Black)
         LINE,AT(5438,-10,0,177),USE(?Line8:25C),COLOR(COLOR:Black)
         STRING(@S6),AT(5458,0,440,156),USE(COL5,,?COL5C),CENTER
         LINE,AT(6531,-10,0,177),USE(?Line8:5C),COLOR(COLOR:Black)
         LINE,AT(5906,-10,0,177),USE(?Line8:26C),COLOR(COLOR:Black)
         STRING(@S10),AT(6563,0,625,156),USE(COL7,,?COL7C),RIGHT(1)
         LINE,AT(7198,-10,0,177),USE(?Line8:27C),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7219,0,625,156),USE(COL8,,?COL8C),RIGHT(1)
         STRING(@S10),AT(5948,0,573,156),USE(N:COL6,,?COL6C),TRN,RIGHT(1)
         LINE,AT(7865,-10,0,177),USE(?Line8:28C),COLOR(COLOR:Black)
         STRING(@N3),AT(42,0,300,156),USE(NPK,,?NPKC),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10,-10,0,177),USE(?Line8:32C),COLOR(COLOR:Black)
         LINE,AT(344,-10,0,177),USE(?Line8:7C),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,1927),USE(?unnamed:5)
         LINE,AT(10,0,0,300),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,300),USE(?Line58:12),COLOR(COLOR:Black)
         LINE,AT(0,292,7865,0),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(10,0,7865,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@S6),AT(5385,94,521,156),USE(COL5K,,?COL5K:2),TRN,CENTER
         STRING('Subtotal :'),AT(3563,104,833,156),USE(?String62:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S10),AT(5917,94,573,156),USE(COL6K,,?COL6K:2),TRN,RIGHT(1)
         STRING(@N_10.2),AT(7219,94,625,156),USE(COL8k,,?COL8k:4),RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s100),AT(1417,365,6427,208),USE(VAT28),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Total :'),AT(6292,500,573,170),USE(?String62:12),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,500,625,167),USE(COL8k),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(':'),AT(6698,615,167,167),USE(?String62:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6292,625,427,167),USE(val_uzsk),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,615,625,167),USE(COL8LVL),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(260,625,3438,156),USE(TOTAL_DISC),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Total amount in words:'),AT(260,781,1510,208),USE(?String62:14),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1615,781,6250,156),USE(SUMV),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Terms of payment:'),AT(260,938,1198,208),USE(?String62:15),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(1406,938,1615,156),USE(TermsOfPAY),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Please transfer amount to the following account:'),AT(260,1104,2865,208),USE(?String62:16), |
             TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(3229,1250,2552,156),USE(BANKA),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Signature of sender_{18}'),AT(323,1708,2417,208),USE(?String62:5),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2771,1729),USE(SYS_PARAKSTS),TRN
         STRING(@s45),AT(3229,1094,3438,156),USE(BKODS_REK),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT2A DETAIL,AT(,,,2219),USE(?unnamed:8)
         LINE,AT(10,0,0,300),USE(?Line58:10),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,300),USE(?Line58:512),COLOR(COLOR:Black)
         LINE,AT(0,292,7865,0),USE(?Line5:57),COLOR(COLOR:Black)
         LINE,AT(10,0,7865,0),USE(?Line5:52),COLOR(COLOR:Black)
         STRING(@S10),AT(4677,94,719,156),USE(COL5K),TRN,CENTER
         STRING('Subtotal :'),AT(3563,104,833,156),USE(?String62:53),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2),AT(7219,104,531,156),USE(COL8k,,?COL8k:5),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s100),AT(1458,365,6385,208),USE(VAT28,,?VAT28:2),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Total :'),AT(6292,500,573,170),USE(?String62:612),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,500,625,167),USE(COL8k,,?COL8k:6),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Total Gross weight kg.'),AT(260,1510,1406,208),USE(?COL6_BRUTTO:2),TRN,LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2B),AT(1656,1510,677,208),USE(COL6KKB,,?COL6KB:3),TRN,RIGHT(1)
         STRING(':'),AT(6677,615,188,167),USE(?String62:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6292,625,406,167),USE(val_uzsk,,?val_uzsk:2),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,615,625,167),USE(COL8LVL,,?COL8LVL:6),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(260,625,3438,156),USE(TOTAL_DISC,,?TOTAL_DISC:8),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Total amount in words:'),AT(260,781,1510,208),USE(?String62:814),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1615,781,6250,156),USE(SUMV,,?SUMV:6),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Terms of payment:'),AT(260,938,1198,208),USE(?String62:615),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(1406,938,1615,156),USE(TermsOfPAY,,?TermsOfPAY:6),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Please transfer amount to the following account:'),AT(260,1104,2865,208),USE(?String62:6), |
             TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(3229,1250,2552,156),USE(BANKA,,?BANKA:6),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Total Nett weight kg.'),AT(260,1344,1406,208),USE(?COL6_BRUTTO:3),TRN,LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2B),AT(1656,1344,677,208),USE(COL6KB,,?COL6KB:2),TRN,RIGHT(1)
         STRING('Signature of sender_{18}'),AT(260,1969,2865,208),USE(?String62:4),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2667,2000),USE(SYS_PARAKSTS,,?SYS_PARAKSTS:2),TRN
         STRING(@s45),AT(3229,1094,3438,156),USE(BKODS_REK,,?BKODS_REK:2),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT2S DETAIL,AT(,,,2219),USE(?unnamed:8S)
         LINE,AT(10,0,0,300),USE(?Line58:510),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,300),USE(?Line58:512),COLOR(COLOR:Black)
         LINE,AT(0,292,7865,0),USE(?Line5:57),COLOR(COLOR:Black)
         LINE,AT(10,0,7865,0),USE(?Line5:52),COLOR(COLOR:Black)
         STRING(@S10),AT(4490,94,719,156),USE(COL5K,,?COL5K:3),TRN,CENTER
         STRING('Subtotal :'),AT(3563,104,833,156),USE(?String62:53),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2),AT(6979,104,531,156),USE(COL8k,,?COL8k:2),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s100),AT(1479,344,6365,208),USE(VAT28,,?VAT28:82),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Total :'),AT(6292,500,573,170),USE(?String62:812),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,500,625,167),USE(COL8k,,?COL8k:3),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Total Gross weight kg.'),AT(260,1510,1406,208),USE(?COL6_BRUTTO,,?COL6_BRUTTO:62),TRN, |
             LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2B),AT(1656,1510,677,208),USE(COL6KKB,,?COL6KB:63),TRN,RIGHT(1)
         STRING(':'),AT(6698,615,167,167),USE(?String62:62),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6344,615,375,167),USE(val_uzsk,,?val_uzsk:3),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_10.2),AT(7219,615,625,167),USE(COL8LVL,,?COL8LVL:6),TRN,RIGHT(1),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(260,625,3438,156),USE(TOTAL_DISC,,?TOTAL_DISC:2S),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Total amount in words:'),AT(260,781,1510,208),USE(?String62:2S14),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1615,781,6250,156),USE(SUMV,,?SUMV:2S),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Terms of payment:'),AT(260,938,1198,208),USE(?String62:2S15),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(1406,938,1615,156),USE(TermsOfPAY,,?TermsOfPAY:2S),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Please transfer amount to the following account:'),AT(260,1104,2865,208),USE(?String62:2S6), |
             TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(3229,1250,2552,156),USE(BANKA,,?BANKA:2S),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Total Nett weight kg.'),AT(260,1344,1406,208),USE(?COL6_BRUTTO,,?COL6_BRUTTO:2S3),TRN, |
             LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2B),AT(1656,1344,677,208),USE(COL6KB,,?COL6KB:2S2),TRN,RIGHT(1)
         STRING('Signature of sender_{18}'),AT(260,1969,2865,208),USE(?String62:2S4),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2667,2000),USE(SYS_PARAKSTS,,?SYS_PARAKSTS:2S),TRN
         STRING(@s45),AT(3229,1094,3438,156),USE(BKODS_REK,,?BKODS_REK:22),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
PPR_TXT DETAIL,AT(,,,156)
         STRING(@s132),AT(156,0,7708,156),USE(LINE),LEFT
       END
SVITRA DETAIL,AT(,,,10)
         LINE,AT(573,0,7292,0),USE(?Line5:707),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11335,8000,104),USE(?unnamed:23)
         LINE,AT(6875,0,1042,0),USE(?Line323),COLOR(COLOR:Black)
         STRING('ISF Assako'),AT(7458,0,,100),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO


IZDRUKA WINDOW('Parametri izdrukai'),AT(,,191,204),GRAY
       STRING('Nr'),AT(59,6),USE(?String5),FONT(,14,,FONT:bold,CHARSET:ANSI)
       STRING(@s10),AT(69,6),USE(PAV:REK_NR,,?PAV:REK_NR:2),FONT(,14,,FONT:bold,CHARSET:ANSI)
       OPTION('Izdrukas &Formâts'),AT(12,21,112,23),USE(F:DBF),BOXED
         RADIO('WMF'),AT(20,31),USE(?F:DBF:Radio1)
         RADIO('EXCEL'),AT(70,31),USE(?F:DBF:Radio2)
       END
       OPTION('&Valoda'),AT(12,45,159,24),USE(F:VALODA),BOXED
         RADIO('Latvieðu'),AT(20,57),USE(?F:VALODA:Radio1),DISABLE,VALUE('L')
         RADIO('Angïu'),AT(70,57,40,10),USE(?F:VALODA:Radio2),VALUE('A')
         RADIO('Krievu'),AT(118,57,40,10),USE(?F:VALODA:Radio3),DISABLE,VALUE('K')
       END
       OPTION('&Kâ Code drukât'),AT(12,72,159,24),USE(RET),BOXED
         RADIO('Nomenklatûra'),AT(20,83,55,10),USE(?sys_nom_cit:Radio1),VALUE('1')
         RADIO('Kods'),AT(77,83,27,10),USE(?sys_nom_cit:Radio2),VALUE('4')
         RADIO('Kataloga Nr'),AT(107,83,58,10),USE(?sys_nom_cit:Radio3),VALUE('14')
       END
       OPTION('&Invoisa forma'),AT(12,99,159,24),USE(forma),BOXED
         RADIO('Regulârâ'),AT(20,110,55,10),USE(?F:Radio1),VALUE('R')
         RADIO('Speciâlâ'),AT(77,110,58,10),USE(?F:Radio2),VALUE('S')
       END
       STRING('Terms of delivery :'),AT(13,129),USE(?String1)
       STRING('CRM: (pav:pielikumâ)'),AT(13,140),USE(?String1W)
       ENTRY(@s30),AT(86,139,91,10),USE(CMR,,?CMRW)
       STRING('Country of origin:'),AT(13,152),USE(?String11W)
       ENTRY(@s30),AT(86,151,91,10),USE(country,,?COUNTRYW)
       STRING('VAT article '),AT(13,165),USE(?String17W)
       ENTRY(@S15),AT(86,163,91,10),USE(VAT28ITEMS)
       BUTTON('&OK'),AT(104,181,36,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(143,181,36,14),USE(?CancelButton)
       COMBO(@s30),AT(86,127,91,10),USE(TermsofDEL,,?TermsofDELW),DROP(10),FROM(TermsofDEL:Queue)
     END


  CODE                                            ! Begin processed code
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOM_K,1)

  IF ~INSTRING(F:DBF,'WE') THEN F:DBF = 'W'.
  F:VALODA='A'  !PAGAIDÂM TIKAI ANGLISKI
!  sys_nom_cit = sys:nom_cit
!  IF ~INSTRING(SYS_NOM_CIT,'NKA') THEN sys_nom_cit='N'.
  RET=1 !NOMENKLATÛRA
  CMR=PAV:PIELIK
  IF ~PAV:REK_NR
     PAV:REK_NR=PERFORMGL(9)
     PUT(PAVAD)
  .

  TERMSOFDEL='EXW'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='FCA'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='FAS'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='FOB'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='CFR'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='CIF'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='CPT'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='CIP Riga'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='DAF'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='DES'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='DEQ'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='DDU'
  ADD(TermsofDEL:Queue)
  TERMSOFDEL='DDP'
  ADD(TermsofDEL:Queue)
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)

  OPEN(IZDRUKA)
  IF CL_NR=1671 OR| !LATLADA~IP
     CL_NR=1569 OR| !!RIPO FABRIKA
     CL_NR=1102 OR| !!AD REM
     CL_NR=1464     !AUTO ÎLE
     FORMA='S'
     VAT28ITEMS='28, items 5'
     GET(TermsofDEL:Queue,8)
     SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  ELSE
     FORMA='R'
     !03/02/2014 VAT28ITEMS='28, items 1,7'
     VAT28ITEMS='138 (1)'
     DISABLE(?F:RADIO2)
     GET(TermsofDEL:Queue,1)
 .

  DISPLAY
  ACCEPT
    CASE FIELD()
    OF ?OKButton
        CASE EVENT()
        OF EVENT:Accepted
            BREAK
        .
    OF ?CancelButton
        CASE EVENT()
        OF EVENT:Accepted
            close(IZDRUKA)
            do ProcedureReturn
        .
    END
  END
  CLOSE(IZDRUKA)

!  VAT28='According to Latvian about VAT clause 28, items '&CLIP(VAT28ITEMS)&' VAT, 0%       0.00'
!03/02/2014  VAT28='According to Latvian about VAT clause '&CLIP(VAT28ITEMS)&' VAT, 0%       0.00'
  VAT28='According to article '&CLIP(VAT28ITEMS)&' of the EU VAT Directive (2006/112/EC) VAT, 0%       0.00'
  IF PAV:APM_V=1 ! Priekðapmaksa
     TermsOfPAY='Advanced payment'
  ELSE
     TermsOfPAY=FORMAT(PAV:C_DATUMS,@D06.)
  .
  IF CL_NR=1471          !INVOISS AR NETTO,kg.,ANDO
     COL3_TEXT='Description'
     COL4_TEXT='Code'
     COL5_TEXT='QTY,pcs'
     COL6_TEXT='Netto,kg'
!     COL61_TEXT='kg'
     COL7_TEXT='Unit price'
     COL9_TEXT='Unit price,'
     COL91_TEXT='incl.disc.'
!     COL8_TEXT='Amount,'
!     COL81_TEXT=PAV:VAL
     COL8_TEXT='Amount,'&PAV:VAL
     COL10_TEXT='DP'
  ELSIF FORMA='S' !A/M ÎLEI u.c.
     COL3_TEXT='Model,Code,Identification Nr.(VIN)'
     COL4_TEXT='Engine No'
     COL5_TEXT='Colour'
  ELSE                      ! INVOISS RIPO un PÂRÇJIEM
     COL3_TEXT='Description'
     COL4_TEXT='Code'
     COL5_TEXT='QTY,pcs'
     COL6_TEXT='Netto,'
     COL61_TEXT='kg'
     COL7_TEXT='Unit price'
     COL9_TEXT='Unit price,'
     COL91_TEXT='incl.disc.'
!     COL8_TEXT='Amount,'
!     COL81_TEXT=PAV:VAL
     COL8_TEXT='Amount,'&PAV:VAL
     COL10_TEXT='DP'
  .
!  ELSE
!     COL3_TEXT='Description'
!     COL4_TEXT='Code'
!     COL5_TEXT='QTY,pcs'
!     COL6_TEXT='Netto,'
!     COL61_TEXT='kg'
!     COL7_TEXT='Unit price'
!!     COL8_TEXT='Amount,'&PAV:VAL
!     COL8_TEXT='Amount,'&PAV:VAL
!  .
!     COL3_TEXT='Description'   !TEST ?
!     COL4_TEXT='Code'
!     COL5_TEXT='QTY,pcs'
!     COL6_TEXT='Netto,'
!     COL61_TEXT='kg'
!     COL7_TEXT='Unit price'
!     COL9_TEXT='Unit price,'
!     COL91_TEXT='incl.disc.'
!!     COL8_TEXT='Amount,'
!!     COL81_TEXT=PAV:VAL
!     COL8_TEXT='Amount,'&PAV:VAL
!     COL10_TEXT='DP'

  VAT='VAT No: '&GL:VID_NR
  GETMYBANK('') !BANKA=BAN:NOS_P BKODS=BAN:KODS BSPEC=BAN:SPEC BINDEX=BAN:INDEX REK=GL:REK[SYS:NOKL_B] KOR=GL:KOR[SYS:NOKL_B]
  BKODS_REK='BIC: '&CLIP(BKODS)&' acc. '&CLIP(REK)
  IF SYS:TEL THEN SYS_TEL_FAX='tel. '&SYS:TEL.
  IF SYS:FAX THEN SYS_TEL_FAX=CLIP(SYS_TEL_FAX)&' fax. '&SYS:FAX.

  PAR_NOS_P=CLIP(GETPAR_K(PAV:PAR_NR,2,2))
  PAR_VAT='VAT No: '&GETPAR_K(PAV:PAR_NR,2,13) !PVN REÌISTRÂCIJA
  PAV_PAMAT=PAV:PAMAT !10/03/2014
  !SPEC_ATZ=GETTEX(PAV:TEKSTS_NR,1)  !1.RINDIÒU IETÛCAM HEADERÎ
  !SPEC_ATZ=SPEC_ATZ&' '&GETTEX(PAV:TEKSTS_NR,2)  !2.RINDIÒU IETÛCAM HEADERÎ
  !SPEC_ATZ=SPEC_ATZ&' '&GETTEX(PAV:TEKSTS_NR,3)  !3.RINDIÒU IETÛCAM HEADERÎ
  SPEC_ATZ=''

  PAR_ADRESE  = PAR:ADRESE
  PAR_ADRESEF = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
  IF F:PAK = '2'   !F:PAK NO SELPZ
    par_banka=Getbankas_k(PAR:BAN_KODS2,2,1)
    IF PAR_BANKA THEN PAR_BKODS_REK='BIC: '&par:ban_kods2&'acc. '&CLIP(par:ban_nr2).
  ELSE
    par_banka=Getbankas_k(PAR:BAN_KODS,2,1)
    IF PAR_BANKA THEN PAR_BKODS_REK='BIC: '&par:ban_kods&'acc. '&CLIP(par:ban_nr).
  .
  IF PAR:TEL THEN PAR_TEL_FAX='tel. '&PAR:TEL.
  IF PAR:FAX THEN PAR_TEL_FAX=CLIP(PAR_TEL_FAX)&' fax. '&PAR:FAX.

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Invoice'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR = PAV:U_NR'
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        END
      END
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      END
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        VARDS=CLIP(INIGEN(PAV:NOKA,15,1))&' I:'&CLIP(PAV:DOK_SENR)
        Report{Prop:Text} = CLIP(VARDS)&'XXXX'
        SETTARGET(REPORT)
        IMAGE(188,281,2083,521,'USER.BMP')
        IF PAV:SUMMA<0 THEN ?StringINVOICE{PROP:TEXT}='CREDIT NOTE'.
        IF PAV:SUMMA<0 THEN ?StringINVOICE2{PROP:TEXT}='CREDIT NOTE'.
        PRINT(RPT:HEADER)
!        IF FORMA='S' AND CL_NR=1569 !SPECIÂLAIS INVOISS RIPO FABRIKAI
!           PRINT(RPT:PAGE_HEAD1S)
!        ELSIF FORMA='S' AND CL_NR=0 !SPECIÂLAIS INVOISS VINCENTAM
        IF CL_NR=1471          !INVOISS AR NETTO,kg.,ANDO
           PRINT(RPT:PAGE_HEAD1)
        ELSE                   !INVOISS AR UNIT un DISCOUNT, RIPO un PÂRÇJIE
           PRINT(RPT:PAGE_HEAD1S)
        .
      ELSE           !RTF
        IF ~OPENANSI('INVOICE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        IF PAV:SUMMA<0
           OUTA:LINE='CREDIT NOTE No:'&PAV:DOK_SENR
           ADD(OUTFILEANSI)
        ELSE
           OUTA:LINE='INVOICE No: '&PAV:DOK_SENR
           ADD(OUTFILEANSI)
        .
        OUTA:LINE='DATE: '&FORMAT(PAV:DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='SELLER: '&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=VAT
        ADD(OUTFILEANSI)
        OUTA:LINE=GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE=SYS_TEL_FAX
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='BUYER: '&PAR_NOS_P
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR_VAT
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR_ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR_BKODS_REK
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR_BANKA
        ADD(OUTFILEANSI)
        OUTA:LINE=PAR_TEL_FAX
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Contract: '&PAR:LIGUMS
        ADD(OUTFILEANSI)
        OUTA:LINE='Terms of delivery: '&TERMSOFDEL
        ADD(OUTFILEANSI)
        OUTA:LINE='Place of loading: '&SYS:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='Place of discharge: '&PAR_ADRESEF
        ADD(OUTFILEANSI)
        OUTA:LINE='CMR: '&CMR
        ADD(OUTFILEANSI)
        OUTA:LINE='Country of origin: '&COUNTRY
        ADD(OUTFILEANSI)
        OUTA:LINE='Description of goods:'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='No'&CHR(9)&'EU CODE'&CHR(9)&COL3_TEXT&CHR(9)&COL4_TEXT&CHR(9)&COL5_TEXT&CHR(9)&COL6_TEXT&CHR(9)&COL7_TEXT&CHR(9)&COL8_TEXT
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~(NOL:NOMENKLAT[1:4]='IEP*')
           N:EUCODE   =GETNOM_K(NOL:NOMENKLAT,0,21) !2
           N:NOMENKLAT=NOL:NOMENKLAT                !3 NOM_K
           N:COL5     =ROUND(NOL:DAUDZUMS,.01)      !5 QTY
           N:COL6     =ROUND(GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums,.01) !6 NETO SVARS
           N:COL7     =ROUND(calcsum(11,2)/nol:daudzums,.01) !7 CENA, NEÒEMOT VÇRÂ ATLAIDI
           N:COL8     =calcsum(3,2)                          !8 AMOUNT
           N:COL9     =ROUND(calcsum(3,2)/nol:daudzums,.01)  !9 CENA - ATLAIDE
           N:COL10    =NOL:ATLAIDE_PR                        !ATLAIDES %
           atlaide   +=(N:COL7-N:COL9)*nol:daudzums
           COL6KB    +=N:COL6       !PREÈU SVARS
           ADD(N_TABLE)
        ELSE        !IEPAKOJUMI
           COL6KKB   +=NOL:DAUDZUMS !IEPAKOJUMA SVARS
        .
        LOOP
          DO GetNextRecord
          DO ValidateRecord              
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:OK
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          LocalResponse = RequestCompleted
          BREAK
        END
        LocalResponse = RequestCancelled
      END
      IF LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(N_TABLE,N:EUCODE)
    GET(N_TABLE,0)
!    SAV_CODE=0
    LOOP I#=1 TO RECORDS(N_TABLE)
       GET(N_TABLE,I#)
       NPK+=1
       CASE F:VALODA
       OF 'L'
          COL3=GETNOM_K(N:NOMENKLAT,0,2)    !NOS_P
       OF 'A'
          COL3=GETNOM_VALODA(N:NOMENKLAT,2) !ANGLISKI
       OF 'K'
          COL3=GETNOM_VALODA(N:NOMENKLAT,3) !CYR
       .
       IF ~COL3 THEN COL3=GETNOM_K(N:NOMENKLAT,0,2).
!       STOP(RET)
       !13/11/2015 <
       !COL4=GETNOM_K(N:NOMENKLAT,0,RET)
       IF RET = 4
          COL4=GETNOM_K(N:NOMENKLAT,0,28)&GETNOM_K(N:NOMENKLAT,0,RET)
       ELSE
          COL4=GETNOM_K(N:NOMENKLAT,0,RET)
       .
       !13/11/2015 >
!       STOP(COL4)
       COL5=CUT0(N:COL5,1,0,,1)
       COL6=CUT0(N:COL6,2,0,,1)
       COL7=FORMAT(N:COL7,@N_10.2)
       COL8=FORMAT(N:COL8,@N_10.2)
       COL9=FORMAT(N:COL9,@N_10.2)
       COL5KK += N:COL5
       COL6KK += N:COL6
       COL8K  += N:COL8
       COL8LVL+= N:COL8*BANKURS(PAV:VAL,PAV:DATUMS)
       IF FORMA='S'
          IF CL_NR=1102 OR CL_NR=1464  !A/M ÎLE,HERBST
             COL3=CLIP(COL3)&', '&clip(GETNOM_K(N:NOMENKLAT,0,3))&', '&GETNOM_K(N:NOMENKLAT,0,5) !ARTIKULS  MODEL,Identification Nr.(VIN)
             COL4=GETNOM_K(N:NOMENKLAT,0,19)!CITS_TEKSTSPZ  ENGINE
             COL5=GETNOM_K(N:NOMENKLAT,0,25)!RINDA2PZ   Colour
             COL5KK=0
          .
       .
       IF F:VALODA='K'  !CYRILICA
          IF F:DBF='W'
              PRINT(RPT:DETAILCYR)
          ELSE
              OUTA:LINE=FORMAT(NPK,@N2)&CHR(9)&N:EUCODE&CHR(9)&COL3&CHR(9)&COL4&CHR(9)&COL5&CHR(9)&COL6&CHR(9)&COL7&CHR(9)&COL8
              ADD(OUTFILEANSI)
          .
       ELSE !ENGLISH
          IF F:DBF='W'
!             IF FORMA='S' AND CL_NR=1569 !SPECIÂLAIS INVOISS RIPO FABRIKAI
!                PRINT(RPT:DETAILS)
!             ELSIF FORMA='S' AND CL_NR=0 !SPECIÂLAIS INVOISS VINCENTAM
             IF CL_NR=1471          !INVOISS AR NETTO,kg.,ANDO
                PRINT(RPT:DETAIL)
             ELSE                   !INVOISS AR UNIT un DISCOUNT, RIPO un PÂRÇJIE
                PRINT(RPT:DETAILS)
             .
!             ELSIF FORMA='S' !A/M ÎLEI
!                PRINT(RPT:DETAIL)
!             ELSE            !REGULÂRAIS
!                PRINT(RPT:DETAIL)
!             .
          ELSE
              OUTA:LINE=FORMAT(NPK,@N2)&CHR(9)&N:EUCODE&CHR(9)&COL3&CHR(9)&COL4&CHR(9)&COL5&CHR(9)&COL6&CHR(9)&COL7&CHR(9)&COL8
              ADD(OUTFILEANSI)
          END
       .
    .
    COL5K=CUT0(COL5KK,1,0,,1)
    COL6K=CUT0(COL6KK,2,0,,1)
    TOTAL_DISC='Total discount '&FORMAT(atlaide,@N_11.2)&' '&PAV:VAL
!    IF COL6KKB !IR IEPAKOJUMI
!       COL6_BRUTTO='Brutto,kg :'
!       COL6KKB=COL6KKB+COL6KK
!       COL6KB=CUT0(COL6KKB,2,0,,1)
!    .
    COL6KKB=COL6KB+COL6KKB
    SUMV = SUMVAR(COL8K,PAV:VAL,1) !1-ANGLISKI
    IF F:DBF = 'W'
        IF CL_NR=1471          !INVOISS AR NETTO,kg.,ANDO
           PRINT(RPT:RPT_FOOT2)
        ELSE                   !RIPO un PÂRÇJIE
           PRINT(RPT:RPT_FOOT2S)
        .
        ENDPAGE(report)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&'SUBTOTAL'&CHR(9)&CHR(9)&FORMAT(COL5K,@N_7B)&CHR(9)&FORMAT(COL6K,@N_11.2)&CHR(9)&CHR(9)&FORMAT(COL8K,@N_11.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&VAT28
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'TOTAL'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(COL8K,@N_11.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Total amount in words: '&SUMV
        ADD(OUTFILEANSI)
        OUTA:LINE='Terms of payment: '&TERMSOFPAY
        ADD(OUTFILEANSI)
        OUTA:LINE='Please transfer amount to the following account:'
        ADD(OUTFILEANSI)
        OUTA:LINE=BANKA
        ADD(OUTFILEANSI)
        OUTA:LINE=BKODS_REK
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
      RP
      IF Globalresponse = RequestCompleted
         loop J#=1 to PR:SKAITS
            report{Prop:FlushPreview} = True
            IF ~(J#=PR:SKAITS)
               loop I#= 1 to RECORDS(PrintPreviewQueue1)
                  GET(PrintPreviewQueue1,I#)
                  PrintPreviewImage=PrintPreviewImage1
                  add(PrintPreviewQueue)
               .
            .
         .
      END
    ELSE
      ANSIJOB
    .
  .
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
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
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT
!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  END
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

















OMIT('MARIS')
           GET(S_TABLE,0)
           S:CODE=NOM:MUITAS_KODS
           GET(S_TABLE,S:CODE)
           IF ERROR()
              S:NETO=NOM:SVARSKG*nol:daudzums
   !           S:BRUTTO=NOM:SVARS_BR*NOL:DAUDZUMS
              S:QUANTITY=N:QUANTITY
              S:AMOUNT=N:AMOUNT
              ADD(S_TABLE)
              SORT(S_TABLE,S:CODE)
           ELSE
              S:NETO+=NOM:SVARSKG*nol:daudzums
   !           S:BRUTTO+=NOM:SVARS_BR*NOL:DAUDZUMS
              S:QUANTITY+=N:QUANTITY
              S:AMOUNT+=N:AMOUNT
              PUT(S_TABLE)
           .

!************************* SVARS , sadalîts pa muitas kodiem ***********
    IF F:DBF = 'W'
        PRINT(RPT:SVARI_HEAD)
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'CODE'&CHR(9)&'NETO'&CHR(9)&'BRUTTO, KG'&CHR(9)&'QUANTITY,PCS'&CHR(9)&AMOUNTS
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
    LOOP I#=1 TO RECORDS(S_TABLE)
       GET(S_TABLE,I#)
       IF F:DBF = 'W'
            PRINT(RPT:SVARI_DET)
       ELSE
            OUTA:LINE=CHR(9)&S:CODE&CHR(9)&FORMAT(S:NETO,@N-_12.2)&CHR(9)&CHR(9)&FORMAT(S:QUANTITY,@N_10)&CHR(9)&FORMAT(S:AMOUNT,@N-_12.2)
            ADD(OUTFILEANSI)
       END
    .
    IF F:DBF = 'W'
        PRINT(RPT:SVARI_FOOT)
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'TOTAL'&CHR(9)&FORMAT(NETO_K,@N-_12.2)&CHR(9)&FORMAT(BRUTTO_K,@N12.2)&CHR(9)&FORMAT(DAUDZUMSK,@N_10)&CHR(9)&FORMAT(SUMK_B,@N-_12.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
    IF NUMERIC(PAV:PAMAT[1:2]) THEN NumOfPallets=PAV:PAMAT[1:2].
    IF NUMERIC(PAV:PAMAT[4:5]) THEN NumOfPlaces =PAV:PAMAT[4:5].
    NumTotal = NumOfPallets + NumOfPlaces
    IF F:DBF = 'W'
       PRINT(RPT:RPT_FOOT4)
       IF F:DTK
           checkopen(OUTFILEANSI)
           SET(OUTFILEANSI)
           LOOP
              NEXT(OUTFILEANSI)
              IF ERROR() THEN BREAK.
              LINE=OUTA:LINE
              PRINT(RPT:PPR_TXT)
           .
       .
       close(OUTFILEANSI)
       ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'NETO, KG'&CHR(9)&FORMAT(NETO_K,@N-_12.2)&CHR(9)&CHR(9)&'SUBTOTAL'&CHR(9)&FORMAT(SUMK_B,@N_11.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'BRUTTO, KG'&CHR(9)&FORMAT(BRUTTO_K,@N-_12.2)&CHR(9)&CHR(9)&'PVN (0%)'&CHR(9)&'0.00'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'QUANTITY, PCS'&CHR(9)&FORMAT(DAUDZUMSK,@N_7)&CHR(9)&CHR(9)&'SHIPPING & HADLING'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'TOTAL DUE'&CHR(9)&FORMAT(SUMK_B,@N_11.2)&CHR(9)&PAV:VAL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'NUMBER OF PALLETS'&CHR(9)&FORMAT(NumOfPallets,@S2)
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'NUMBER OF PLACES'&CHR(9)&FORMAT(numOfPlaces,@S2)
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'TOTAL'&CHR(9)&FORMAT(NumTotal,@N3B)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Conditions of payment DDU'
        ADD(OUTFILEANSI)
    END

MARIS
