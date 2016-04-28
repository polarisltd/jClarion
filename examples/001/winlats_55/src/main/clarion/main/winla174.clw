                     MEMBER('winlats.clw')        ! This is a MEMBER module
AI_R_BARMAN          PROCEDURE                    ! Declare Procedure
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
FOLDERIS              CSTRING(60)
FILENAME3             CSTRING(60)
FILENAME4             CSTRING(60)
REZIMS                STRING(1)
SAV_RECORD            LIKE(NOL:RECORD)
NOL_SUMMAV            LIKE(NOL:SUMMAV)
ParrekRaz             BYTE
KODS_ACM              DECIMAL(13)
SKAITS                DECIMAL(8,2)
ATSTAT                BYTE
SKIPATLIKUMI          BYTE
IGNORE                BYTE   !IGNORÇT NEPAZÎSTAMUS KODUS
NOM_OK                BYTE
NOM_SK                USHORT
EXTENSION             CSTRING(30)
NOM3                  STRING(3)
NOM1                  STRING(1)
NOM14                 STRING(14)
NOMR                  STRING(3)
SKANERIS              STRING(15)
DOK_SE_NR             STRING(14)

N_TABLE      QUEUE,PRE(N)
NOMENKLAT    STRING(15)
DAUDZUMS     DECIMAL(11,3)
DAUDZUMS1    DECIMAL(11,3)
             .

X                    BYTE
Process              STRING(35)
Process1             STRING(35)
Process2             STRING(35)
raksti               USHORT

Askscreen WINDOW('Uzkrâjoðâ skanera lasîðana'),AT(,,201,130),CENTER,GRAY,MDI
       STRING(@s15),AT(60,8),USE(SKANERIS),CENTER
       OPTION('Izveidot dokumentu '),AT(15,19,178,50),USE(REZIMS),BOXED
         RADIO('kâ K'),AT(18,37),USE(?d_k_tips:1),VALUE('K')
         RADIO('kâ D'),AT(18,28),USE(?d_k_tips:2),VALUE('D')
         RADIO('kâ Inventarizâcijas rezultâtu (klât pie esoðajiem)'),AT(18,46),USE(?d_k_tips:3),VALUE('I')
         RADIO('kâ Invent. rez. (vispirms nodzçðot esoðos)'),AT(18,55),USE(?d_k_tips:4),VALUE('J')
       END
       STRING('Lietot '),AT(20,71),USE(?String5)
       ENTRY(@N1),AT(41,71,10,10),USE(NOKL_CP),CENTER
       STRING('cenu (1-6)'),AT(55,71),USE(?String6),LEFT
       STRING(@s35),AT(15,83),USE(process)
       STRING(@s35),AT(15,91),USE(process1)
       STRING(@s35),AT(15,99),USE(process2)
       BUTTON('&Turpinât'),AT(65,110,45,14),USE(?turpinat),HIDE,DEFAULT
       BUTTON('&OK'),AT(116,110,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(158,110,36,14),USE(?CancelButton)
     END

NEWSCREEN WINDOW('Jauna prece'),AT(,,262,127),IMM,HLP(' '),CURSOR(CURSOR:None),GRAY,MDI
       STRING(@s14),AT(6,10),USE(DOK_SE_NR)
       STRING(@s40),AT(29,22,180,10),USE(KODS_ACM),CENTER
       BUTTON('Grupa'),AT(89,33,29,14),USE(?grupa)
       BUTTON('ApakðGrupa'),AT(119,33,47,14),USE(?agrupa)
       BUTTON('Raþotâjs'),AT(204,33,47,14),USE(?razotajs)
       ENTRY(@s4),AT(110,49,20,12),USE(nom3,,?nom3:2),REQ,UPR
       ENTRY(@s4),AT(133,49,10,12),USE(nom1),REQ,UPR
       ENTRY(@s14),AT(145,49,71,12),USE(nom14),UPR
       ENTRY(@s3),AT(219,49,22,12),USE(nomr),REQ,UPR
       STRING('Ievadiet grupu un apakðgrupu'),AT(10,50),USE(?String2)
       ENTRY(@N2),AT(110,63),USE(NOM:PVN_PROC)
       STRING('Pilnais nosaukums:'),AT(5,68),USE(?StringNos_P)
       ENTRY(@s50),AT(5,78,256,12),USE(NOM:NOS_P)
       STRING('Saîsinâtais nosaukums:'),AT(5,91),USE(?StringNos_S)
       ENTRY(@s16),AT(5,101,108,12),USE(NOM:NOS_S)
       STRING(@s8),AT(122,103),USE(nom:nos_a),FONT(,,COLOR:Gray,,CHARSET:ANSI)
       STRING('PVN %'),AT(85,65),USE(?String1)
       BUTTON('OK'),AT(225,111,35,14),USE(?Ok),DEFAULT
       STRING('Daudzums'),AT(133,64),USE(?String22)
       STRING(@N12.3B),AT(170,64),USE(SKAITS)
     END

BARNAME      STRING(40),STATIC
BARLAS       FILE,NAME(BARNAME),PRE(A),DRIVER('ASCII'),CREATE
               RECORD
RAKSTS           STRING(100)
             . .


!            DATU APMAIÒAS FAILA STRUKTÛRA BARMANLASER

STR_A        GROUP,OVER(A:RAKSTS),PRE(B3)
DR1          STRING(5)               !DRAZA 5 cipari
KOMATS1      STRING(1)               !KOMATS
REZIMS       STRING(1)               !REÞÎMS
KOMATS2      STRING(1)               !KOMATS
KODS_ACM     STRING(13)              !ACM KODS 13 KONTROLES CIPARS JAPÂRBAUDA IEVADOT NO KLAVIERES PÇC ALGORITMA....
KOMATS3      STRING(1)               !KOMATS
SKAITS       STRING(7)               !PÂRD PREÈU SKAITS
             .

!            DATU APMAIÒAS FAILA STRUKTÛRA M90
 
STR_B        GROUP,OVER(A:RAKSTS),PRE(B4)
REZIMS       STRING(2)               !REÞÎMS
DR1          STRING(14)              !DRAZA 14 cipari
KODS_ACM     STRING(13)              !ACM KODS 13
DR2          STRING(3)               !DRAZA 3 cipari
SKAITS       STRING(8)               !PÂRD PREÈU SKAITS 5.2
             .
 
!            DATU APMAIÒAS FAILA STRUKTÛRA AXB
 
STR_C        GROUP,OVER(A:RAKSTS),PRE(B5)
NR           STRING(5)               !NPK
KOMATS1      STRING(1)               !ATDALÎTÂJS
A            STRING(1)               !?
KOMATS2      STRING(1)               !ATDALÎTÂJS
KODS_ACM     STRING(13)              !ACM KODS 13
KOMATS3      STRING(1)               !ATDALÎTÂJS
SKAITS       STRING(8)               !PÂRD PREÈU SKAITS 8
             .

!            DATU APMAIÒAS FAILA STRUKTÛRA DATALOGIC(ARÎ RAKSTÎÐANA),METROLOGIC
 
STR_D        GROUP,OVER(A:RAKSTS),PRE(B6)
KOMATS1      STRING(1)               !ATDALÎTÂJS
KODS_ACM     STRING(13)              !ACM KODS 13
KOMATS2      STRING(3)               !ATDALÎTÂJS
SKAITS       STRING(10)              !PREÈU SKAITS
KOMATS3      STRING(3)               !ATDALÎTÂJS
MERVIEN      STRING(7)               !MÇRVIENÎBA
KOMATS4      STRING(3)               !ATDALÎTÂJS
NOSAUKUMS    STRING(50)              !NOSAUKUMS
             .
 
!            RAKSTÎÐANAS FAILA STRUKTÛRA FORMULA WIZARD-MAINÎGA GARUMA LAUKI, LOSOT KÂ BARMANLASER
 
STR_E        GROUP,OVER(A:RAKSTS),PRE(B7)
KODS_ACM     STRING(13)              !ACM KODS 13
KOMATS1      STRING(1)               !ATDALÎTÂJS ;
NOSAUKUMS    STRING(15)              !NOSAUKUMS MAX=15-MERVIEN (BEZ LATV.BURTIEM)
KOMATS2      STRING(1)               !ATDALÎTÂJS ;
MERVIEN      STRING(7)               !MÇRVIENÎBA MAX=15-NOSAUKUMS
             .
 
  CODE                                            ! Begin processed code
 IF F:KRI !*******************RAKSTÎÐANA*************************
    TTAKA"=LONGPATH()
    INVNAME=''
    EXTENSION='TOPSPEED|I'&CLIP(LOC_NR)&'*.TPS'
    IF ~FILEDIALOG('...TIKAI I(NOL_NR)YYMMDD.TPS FAILI !!!',INVNAME,EXTENSION,2) !2-NEDRÎKST MAINÎT FOLDERI
       SETPATH(TTAKA")
       DO PROCEDURERETURN
    .
    SETPATH(TTAKA")
    CASE SYS:U_SKANERIS
    OF '4' !DATI PRIEKÐ DATALOGIC(ÍÎPSALA)
       BARNAME='DLOGIC.BAR'
       CHECKOPEN(barlas,1,12H)
       EMPTY(barlas)
       CHECKOPEN(INVENT,1)
       SET(INVENT)
       LOOP
          NEXT(INVENT)
          IF ERROR() THEN BREAK.
          B6:KOMATS1 ='"'                  !ATDALÎTÂJS
          B6:KODS_ACM =RIGHT(INV:KODS)     !ACM KODS 13
          B6:KOMATS2 ='","'                !ATDALÎTÂJS
          B6:SKAITS  =''                   !PREÈU SKAITS
          B6:KOMATS3 ='","'                !ATDALÎTÂJS
          B6:MERVIEN =GETNOM_K(INV:NOMENKLAT,0,20)   !MÇRVIENÎBA
          B6:KOMATS4 ='","'                !ATDALÎTÂJS
          B6:NOSAUKUMS=INV:NOSAUKUMS       !NOSAUKUMS
          ADD(BARLAS)
          RAKSTI+=1
       .
       CLOSE(BARLAS)
    OF '6' !DATI PRIEKÐ FORMULA WIZARD(AUTO ÎLE)
       BARNAME='FWIZARD.BAR'
       CHECKOPEN(barlas,1,12H)
       EMPTY(barlas)
       CHECKOPEN(INVENT,1)
       SET(INVENT)
       LOOP
          NEXT(INVENT)
          IF ERROR() THEN BREAK.
          B7:KODS_ACM =RIGHT(INV:KODS)               !ACM KODS 13
          B7:KOMATS1 =';'                            !ATDALÎTÂJS
          B7:MERVIEN =GETNOM_K(INV:NOMENKLAT,0,20)   !MÇRVIENÎBA
          LEN#=LEN(CLIP(B7:MERVIEN))
          B7:NOSAUKUMS=INV:NOSAUKUMS[1:15-LEN#]      !NOSAUKUMS
          LEN#=LEN(CLIP(B7:NOSAUKUMS))
          B7:NOSAUKUMS=INIGEN(B7:NOSAUKUMS,LEN#,1)
          B7:KOMATS2 =';'                            !ATDALÎTÂJS
          A:RAKSTS=B7:KODS_ACM&B7:KOMATS1&CLIP(B7:NOSAUKUMS)&B7:KOMATS2&B7:MERVIEN
          ADD(BARLAS)
          RAKSTI+=1
       .
       CLOSE(BARLAS)
       CLOSE(INVENT)
    .
    KLUDA(0,'Fails: '&clip(BARNAME)&' '&CLIP(RAKSTI)&' raksti',,1)
 ELSE !***********************LASÎTÐANA****************************
    checkopen(NOLIK,1)
    NOLIK::USED+=1
    checkopen(NOM_K,1)
    NOM_K::USED+=1
    OPEN(ASKSCREEN)
    REZIMS='K'
    NOM_SK=0
    FIRST#=1
    NOM#=0
    PAR#=0
    EXECUTE SYS:U_SKANERIS
       SKANERIS='BARMANLASER'       !1
       SKANERIS='M90'               !2
       SKANERIS='AXB'               !3
       SKANERIS='DATALOGIC'         !4
       SKANERIS='METROLOGIC'        !5
       SKANERIS='FORMULA WIZARD'    !6
    .
    PROCESS=''
    PROCESS1=''
    PROCESS2=''
    DISPLAY
    ACCEPT
       CASE FIELD()
       OF ?OkButton
          CASE EVENT()
          OF EVENT:Accepted
             IF ~INRANGE(NOKL_CP,1,6)
                BEEP
                CYCLE
             .
             IF REZIMS='I'OR REZIMS='J'  ! JÂBÛVÇ INVENTARIZÂCIJA
                TTAKA"=PATH()
                INVNAME=''
                EXTENSION='TOPSPEED|I'&CLIP(LOC_NR)&'*.TPS'
                IF ~FILEDIALOG('...TIKAI I(NOL_NR)YYMMDD.TPS FAILI !!!',INVNAME,EXTENSION,2) !2-NEDRÎKST MAINÎT FOLDERI
                   SETPATH(TTAKA")
                   CLOSE(ASKSCREEN)
                   DO PROCEDURERETURN
                .
                SETPATH(TTAKA")
             .
             CASE SYS:U_SKANERIS
             OF '1'                  ! BARMANLASER
                BARNAME='BARMAN.BAR'
                close(barlas)
!                RUN(COMMAND('COMSPEC',0) & ' /C BARMAN.BAT')
                RUN('\WINLATS\BIN\BARMAN.BAT')
                IF RUNCODE()
                   IF RUNCODE()=-4
                      KLUDA(120,'\WINLATS\BIN\BARMAN.BAT')
                   .
                   CLOSE(ASKSCREEN)
                   DO PROCEDURERETURN
                .
             OF '2'                  ! M90
                BARNAME='\HANDY\HANDYLNK\\FROMTERM\DATA0011.APP'
             OF '3'                  ! AXB
                BARNAME='BARMAN.BAR'
                close(barlas)
                RUN('\WINLATS\BIN\AxBComm32.exe')
                IF RUNCODE()
                   IF RUNCODE()=-4
                      KLUDA(120,'\WINLATS\BIN\AxBComm32.exe')
                   .
                   CLOSE(ASKSCREEN)
                   DO PROCEDURERETURN
                .
             OF '4'                  ! DATALOGIC
                BARNAME='DLOGIC.BAR'
             OF '5'                  ! METROLOGIC
                BARNAME='MLOGIC.BAR'
                close(barlas)
                RUN('\WINLATS\BIN\232_READ.EXE')
                IF RUNCODE()
                   IF RUNCODE()=-4
                      KLUDA(120,'\WINLATS\BIN\232_READ.EXE')
                   .
                   CLOSE(ASKSCREEN)
                   DO PROCEDURERETURN
                .
             OF '6'                  ! FORMULA WIZARD
                BARNAME='FWIZARD.BAR'
                close(barlas)
                RUN('\WINLATS\BIN\FWIZARD.BAT')
                IF RUNCODE()
                   IF RUNCODE()=-4
                      KLUDA(120,'\WINLATS\BIN\FWIZARD.BAT')
                   .
                   CLOSE(ASKSCREEN)
                   DO PROCEDURERETURN
                .
             ELSE
                STOP('?BARMANIS?')
                CLOSE(ASKSCREEN)
                DO PROCEDURERETURN
             .
             HIDE(?OKBUTTON)
             HIDE(?CANCELBUTTON)
             UNHIDE(?TURPINAT)
             DISPLAY
          .
       OF ?CancelButton
          CASE EVENT()
          OF EVENT:Accepted
             CLOSE(ASKSCREEN)
             DO PROCEDURERETURN
          END
       OF ?Turpinat
          CASE EVENT()
          OF EVENT:Accepted
             BREAK
          END
       END
    .

    ! 1-BARMANLASER      V
    ! 2-M90              V
    ! 3-AXB              V
    ! 4-DATALOGIC        V
    ! 5-METROLOGIC       V
    ! 6-F_WIZARD         V

    !************************ 1.SOLIS *******************************

    CHECKOPEN(barlas,,12H)

    IF REZIMS='S'                  !SALDO
    ELSIF REZIMS='I'               !INVENTARIZÂCIJA
       CHECKOPEN(INVENT,1)
    ELSIF REZIMS='J'               !INVENTARIZÂCIJA AR INV. REZ. TÎRÎÐANU
       CHECKOPEN(INVENT,1)
       SET(INVENT)
       LOOP
          NEXT(INVENT)
          IF ERROR() THEN BREAK.
          IF ~(INV:ATLIKUMS_F=0)
             INV:ATLIKUMS_F=0
             IF RIUPDATE:INVENT()
                KLUDA(24,'TÎROT INVENT')
             .
          .
       .
    ELSIF REZIMS='C'               !SALÎDZINÂÐANA
       CLEAR(NOL:RECORD)
       NOL:U_NR=PAV:U_NR
       SET(NOL:NR_KEY,NOL:NR_KEY)
       LOOP
          NEXT(NOLIK)
          IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
          N:NOMENKLAT=NOL:NOMENKLAT
          N:DAUDZUMS=NOL:DAUDZUMS
          ADD(N_TABLE)
       .
       SORT(N_TABLE,N:NOMENKLAT)
    ELSE                    !D/K
       DO AUTONUMBER
       PAV:DATUMS=TODAY()
       PAV:D_K=REZIMS
       PAV:PAMAT='BARMAN_LASER'
       PAV:PAR_NR=0
!       IF PAV:D_K='K' THEN PAV:DOK_SE=SYS:PZ_SERIJA.
       PAV:DOK_SENR=''
       PAV:NODALA=SYS:NODALA
       PAV:apm_v='2'
       PAV:apm_k='1'
       PAV:VAL='Ls'
       PAV:ACC_KODS=ACC_KODS
       PAV:ACC_DATUMS=TODAY()
       IF RIUPDATE:PAVAD()
          KLUDA(24,'PAVAD')
          DO PROCEDURERETURN
       .
    !   GLOBALREQUEST=4
    !   PARTABLE
    !   IF GLOBALRESPONSE=REQUESTCANCELLED
    !      CLEAR(PAR:RECORD)
    !   .
    .

    !********************* 2.SOLIS *******************************
    IF ~BYTES(BARLAS)
       KLUDA(0,'Neviens ieraksts no BARMAN nav nolasîts ')
       CLOSE(ASKSCREEN)
       DO PROCEDURERETURN
    .
    SET(barlas)
    LOOP
       NEXT(barlas)
       RINDA#+=1
       IF ERROR() THEN BREAK.
       CASE SYS:U_SKANERIS
       OF '1'
          KODS_ACM = DEFORMAT(RIGHT(B3:KODS_ACM),@N13)
          SKAITS   = B3:SKAITS      !ÐÍIET, TIKAI VESELI SKAITÏI
       OF '2'                !M90
          IF ~(B4:REZIMS='07') THEN CYCLE.   !NAV DATU RINDA
          KODS_ACM = DEFORMAT(RIGHT(B4:KODS_ACM),@N13)
          SKAITS   = DEFORMAT(B4:SKAITS,@N_8.2)
       OF '3'
          KODS_ACM = DEFORMAT(RIGHT(B5:KODS_ACM),@N13)
          SKAITS   = B5:SKAITS      !ÐÍIET, TIKAI VESELI SKAITÏI
       OF '4'                !DATALOGIC
          KODS_ACM = DEFORMAT(RIGHT(B6:KODS_ACM),@N13)
          SKAITS   = B6:SKAITS
       OF '5'                  ! METROLOGIC
          IF RINDA#=1 AND ~NUMERIC(B6:KODS_ACM[1:2])  !ÎSTI NESAPROTU
             IF INSTRING(REZIMS,'DK')
                PAV:DOK_SENR=B6:KODS_ACM
                IF RIUPDATE:PAVAD()
                   KLUDA(24,'PAVAD')
                .
             .
             CYCLE
          ELSIF ~NUMERIC(B6:KODS_ACM[1:2]) 
             IF INSTRING(REZIMS,'DK')
                DO AUTONUMBER
                PAV:DATUMS=TODAY()
                PAV:D_K=REZIMS
                PAV:DOK_SENR=B6:KODS_ACM
                PAV:PAMAT='BARMAN_LASER'
                PAV:PAR_NR=0
!                IF PAV:D_K='K' THEN PAV:DOK_SE=SYS:PZ_SERIJA.
                PAV:NODALA=SYS:NODALA
                PAV:apm_v='2'
                PAV:apm_k='1'
                PAV:VAL='Ls'
                PAV:ACC_KODS=ACC_KODS
                PAV:ACC_DATUMS=TODAY()
                IF RIUPDATE:PAVAD()
                   KLUDA(24,'PAVAD')
                   DO PROCEDURERETURN
                .
             .
             CYCLE
          ELSE
             KODS_ACM = DEFORMAT(RIGHT(B6:KODS_ACM),@N13)
             SKAITS   = B6:SKAITS
          .
       OF '6'                !FORMULA WIZARD
          KODS_ACM = DEFORMAT(RIGHT(B3:KODS_ACM),@N13)
          SKAITS   = B3:SKAITS      !ÐÍIET, TIKAI VESELI SKAITÏI
       .
       DO WRITENOM_K
       IF REZIMS='I' OR REZIMS='J'            !INVENTARIZÂCIJA
          DO WRITEINVENT
       ELSIF REZIMS='C'                       !SALÎDZINÂÐANA
          N:NOMENKLAT=NOM:NOMENKLAT
          GET(N_TABLE,N:NOMENKLAT)
          IF ERROR()
             N:DAUDZUMS=0
             N:DAUDZUMS1=SKAITS
             ADD(N_TABLE)
          ELSE
             N:DAUDZUMS1+=SKAITS
             PUT(N_TABLE)
          .
       ELSE
          DO WRITENOLIK
       .
    .
    !********************* 3.SOLIS *******************************

    IF REZIMS='C'               !SALÎDZINÂÐANA
       COMPAREERROR#=0
       LOOP I#= 1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          IF ~(N:DAUDZUMS=N:DAUDZUMS1)
             COMPAREERROR#=1
             BREAK
          .
       .
       IF COMPAREERROR#
          KLUDA(0,'P/Z NAV VIENÂDAS...')
       .
    .
    IF ~ATSTAT
       EMPTY(BARLAS)
       IF ERROR() THEN STOP(ERROR()).
    .

    ?Turpinat{prop:text}='Beigt'
    DISPLAY
    ACCEPT
       CASE FIELD()
       OF ?Turpinat
          CASE EVENT()
          OF EVENT:Accepted
             BREAK
          .
       .
    .
    CLOSE(ASKSCREEN)
    DO PROCEDURERETURN
 .

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
    PAV:DOKDAT=TODAY()
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    PAV:ACC_KODS=ACC_kods
    PAV:ACC_DATUMS=today()
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
!          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
!---------------------------------------------------------------------------------------------
WRITENOM_K    ROUTINE
     NOM_OK=TRUE
     IF GETNOM_K(KODS_ACM,2,8) >0
        ZUR:RECORD='LBARMAN:'&FORMAT(TODAY(),@D6)&' KODS= '&KODS_ACM &' '&SKAITS
        IF ~SKIPATLIKUMI
           AtlikumiN(REZIMS,NOM:NOMENKLAT,SKAITS,'','',0)
        .
        KopsN(NOM:NOMENKLAT,TODAY(),'K')
     ELSIF ~IGNORE
        ZUR:RECORD='LBARMAN:'&FORMAT(TODAY(),@D6)&' KÏÛDA: Nav atrasts KODS= '&KODS_ACM
        NOM:KODS=KODS_ACM
        DOK_SE_NR=PAV:DOK_SENR
!        NOM:NOSAUKUMS=KODS_ACM
!        NOM:NOMENKLAT='+'&CLIP(LEFT(KODS_ACM))
        OPEN(NEWSCREEN)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?GRUPA
              CASE EVENT()
              OF EVENT:Accepted
                 GlobalRequest = SelectRecord
                 BrowseGrupas
                 IF GlobalResponse = RequestCompleted
                    NOM3=gr1:grupa1
                 .
              .
              DISPLAY
           OF ?AGRUPA
              CASE EVENT()
              OF EVENT:Accepted
                 GlobalRequest = SelectRecord
                 UPDATEGRUPA1
                 IF GLOBALRESPONSE=REQUESTCOMPLETED
                    NOM1=GR2:GRUPA2
                    IF ~BAND(NOM:BAITS1,00000100b) !~LOCKED
                       NOM:PROC5=GR2:PROC
                    .
                 .
              .
              DISPLAY
           OF ?RAZOTAJS
              CASE EVENT()
              OF EVENT:Accepted
                 GlobalRequest = SelectRecord
                 BROWSEPAR_K
                 IF GLOBALRESPONSE=REQUESTCOMPLETED
                    NOMR=PAR:NOS_U
                 .
              .
              DISPLAY
           OF ?NOM:NOS_P
              CASE EVENT()
              OF EVENT:Accepted
                 IF ~NOM:NOS_S THEN NOM:NOS_S=NOM:NOS_P[1:16].
                 NOM:NOS_A = INIGEN(NOM:NOS_P,8,1)
              .
              DISPLAY
           OF ?Ok
              CASE EVENT()
              OF EVENT:Accepted
                 IF NOM3 AND NOM:PVN_PROC=0 OR NOM:PVN_PROC=5 OR NOM:PVN_PROC=18
                    NOM:nomenklat=NOM3&NOM1&NOM14&NOMR
                    IF DUPLICATE(NOM:NOM_KEY)
                       KLUDA(0,'Ðâda nomenkklatûra DB jau ir')
                       SELECT(?grupa)
                    ELSE
                       BREAK
                    .
                 .
              .
           .
        END
        CLOSE(NEWSCREEN)
        IF ~SKIPATLIKUMI
           AtlikumiN(REZIMS,NOM:NOMENKLAT,SKAITS,'','',0)
        .
        NOM:TIPS='P'
        LOOP V#= 1 TO 5
           NOM:VAL[V#]='Ls'
        .
        IF GNET !GLOBÂLAIS TÎKLS
           NOM:GNET_FLAG[1]=1
           NOM:GNET_FLAG[2]=''
        .
        NOM:ACC_KODS=ACC_kods
        NOM:ACC_DATUMS=today()
        NOM#+=1
        PROCESS1='Kopâ: '&CLIP(NOM#)&' jaunas nomenklatûras'
        display(?process1)
        ADD(NOM_K)
        IF ERROR()
           KLUDA(24,'NOM_K (ADD)')
           ZUR:RECORD=CLIP(ZUR:RECORD)&' KÏÛDA RAKSTOT NOM_K (ADD)'
        .
     ELSE
        ZUR:RECORD='LBARMAN:'&FORMAT(TODAY(),@D6)&' Izlaiþu nomenklatûru KODS= '&KODS_ACM
        NOM_OK=FALSE
     .
     ADD(ZURNALS)
     NOM_SK+=1
     PROCESS='Kopâ: '&clip(NOM_sk)&' nomenklatûras'
     display(?process)

!---------------------------------------------------------------------------------------------
WRITENOLIK    ROUTINE
     IF NOM_OK=TRUE
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        NOL:DATUMS=PAV:DATUMS
        NOL:NOMENKLAT=NOM:NOMENKLAT
!        NOL:PAR_NR=PAR_NR
        NOL:D_K=REZIMS
        NOL:DAUDZUMS=SKAITS
        NOL:SUMMAV=GETNOM_K('POZICIONÇTS',0,7)*SKAITS
        NOL:SUMMA=NOL:SUMMAV
        NOL:VAL='Ls'
!        NOL:ATLAIDE_PR=ATLAIDE_PR
        NOL:PVN_PROC = NOM:PVN_PROC
!        NOL:ARBYTE = 1                !AR PVN
        IF GETNOM_K('POZICIONÇTS',0,10) THEN NOL:ARBYTE = 1.
        FILLPVN(1)
        ADD(nolik)
        IF ERROR()
           KLUDA(24,'NOLIK (ADD)')
           DO PROCEDURERETURN
        .
     .
!---------------------------------------------------------------------------------------------
WRITEINVENT    ROUTINE
     INV:NOMENKLAT=NOM:NOMENKLAT
     GET(INVENT,INV:NOM_KEY)
     IF ~ERROR()
        INV:ATLIKUMS_F+=SKAITS
        INV:X=1
        INV:ACC_KODS=ACC_KODS
        INV:ACC_DATUMS=TODAY()
        IF RIUPDATE:INVENT()
           KLUDA(24,'INVENT')
        .
     ELSE
        CLEAR(INV:RECORD)
        INV:NOMENKLAT=NOM:NOMENKLAT
        INV:KODS=KODS_ACM
        INV:ATLIKUMS_F=SKAITS
        INV:ACC_KODS=ACC_KODS
        INV:ACC_DATUMS=TODAY()
        ADD(INVENT)
     .

!---------------------------------------------------------------------------------------------
PROCEDURERETURN ROUTINE
  CLOSE(BARLAS)
  FREE(N_TABLE)
!  CLOSE(ZURNALS)
!  DZNAME='DZ'&FORMAT(JOB_NR,@N02)
!  CHECKOPEN(ZURNALS,1)
  NOLIK::USED-=1
  IF NOLIK::USED=0
     CLOSE(NOLIK)
  .
  NOM_K::USED-=1
  IF NOM_K::USED=0
     CLOSE(NOM_K)
  .
!  CLOSE(ReLoadSCREEN)
  RETURN



AI_SVARI_WRITE       PROCEDURE                    ! Declare Procedure
DOS_A        FILE,NAME(FILENAME1),PRE(A),DRIVER('ASCII'),CREATE
               RECORD,PRE(A)
LINE            STRING(80)
             . .
A            GROUP,PRE(A),OVER(A:LINE)
PLU             STRING(4)               !   1-600 PLU KODS
CENA            STRING(6)               !   CENA BEZ . RIGHT
T0              STRING(2)
CODE            STRING(6)               !   SVÎTRU KODS MAX 19999
T1              STRING(3)               !
T2              STRING(4)               !
T3              STRING(3)               !
NOSAUKUMS       STRING(13)              !
             .
             ! KOPÇJAIS IERAKSTA GARUMS 41 BAITS

DATUMS      LONG
LAIKS       LONG
PARAMETRI   STRING(30)
RINDA       STRING(50) !INFORINDA
RAKSTI      LONG
PLU         STRING(6)
CENA        DECIMAL(7,2)


SHOWSCREEN WINDOW('Rakstu apmaiòas failu ...'),AT(,,202,71),GRAY
       STRING(@s30),AT(31,8),USE(PARAMETRI)
       STRING(@N_5),AT(82,26),USE(RAKSTI)
       STRING(@s50),AT(25,37),USE(RINDA)
       BUTTON('OK'),AT(155,50,35,14),USE(?OkButton),HIDE,DEFAULT
     END
  CODE                                            ! Begin processed code
   CHECKOPEN(SYSTEM,1)

   FILENAME1= 'LOAD.PLW'
   CASE SYS:E_SVARI
   OF 1
      PARAMETRI= 'P=COM'&SYS:COM_NR&' F=LOAD.PLW M=W L=LV I=1'
   OF 2
      PARAMETRI= CLIP(FILENAME1)&' SM06F25.DAT'
   .
   DATUMS=TODAY()
   LAIKS=CLOCK()
   PLU#=0


   CHECKOPEN(DOS_A,1)
   close(DOS_A)
   OPEN(DOS_A,18)
   IF ERROR()
     kluda(1,'DOS_A')
     return
   .
   EMPTY(DOS_A)
   close(DOS_A)
   CHECKOPEN(DOS_A,1)
 
   checkopen(NOM_K,1)

   OPEN(SHOWSCREEN)
   clear(nom:record)
   SET(NOM:NOM_KEY,NOM:NOM_KEY)
   LOOP
      NEXT(NOM_K)
      IF ERROR() THEN BREAK.
      CASE NOM:STATUSS[SYS:AVOTA_NR]     ! 0-RAKSTÎT KA
      OF   '0'                           ! 1-PÂRRAKSTÎT
      OROF ' '                           ! 2-DZÇST
      OROF '1'                           ! 3-NEKAS NAV JÂDARA
!
      OF   '2'
      OROF '3'
        CYCLE
      ELSE
        STOP('NOM:STATUSS='&NOM:STATUSS[SYS:AVOTA_NR])
      .
      CASE SYS:E_SVARI
      OF 1
   !                              xxx           xxx       !xxx-kods 1-600
         IF ~INRANGE(NOM:KODS,2000001000000,2000600000000) THEN CYCLE.
   !      CLEAR(A:RECORD)
         IF NOM:KODS=0
            KLUDA(30,NOM:NOMENKLAT)
            CLOSE(DOS_A)
            RETURN
         .
         A:PLU  = SUB(RIGHT(FORMAT(NOM:KODS,@S13)),5,3)
         PLU    = A:PLU
         A:CODE = RIGHT(A:PLU)
         A:PLU  = RIGHT(A:PLU)
         A:T0   =' 0'
         A:CENA = GETNOM_K(NOM:NOMENKLAT,1,7)*100
         IF A:CENA=0
            KLUDA(31,NOM:NOMENKLAT)
   !         CLOSE(DOS_K)
            CLOSE(DOS_A)
   !         CLOSE(OUTFILE)
            CYCLE
         .
         A:CENA=RIGHT(A:CENA)            !   PÂRDODAMÂS PRECES CENA
         CENA=A:CENA/100
         A:T1='  0'
         A:T2='   0'
         A:T3='  0'
         A:NOSAUKUMS = NOM:NOS_P[1:13]
      OF 2 !DIGI300
   !                            xxxxxx        xxxxxx      !xxx-kods 1-9000 MAX 5000 NOM
         IF ~INRANGE(NOM:KODS,2300000100000,2399999900000) THEN CYCLE.
         PLU = SUB(RIGHT(FORMAT(NOM:KODS,@S13)),3,6)
         CENA = GETNOM_K(NOM:NOMENKLAT,1,7)
         A:LINE='WART;'&PLU&';;;"";'&FORMAT(ROUND(CENA,.01),@N_5.2)&';;;;;8;"'&NOM:NOS_P[1:15]&'";;;;;;;;;0;0;19;255;;;;;;;;;;;;'
      .
      RAKSTI+=1
      ADD(DOS_A)
      RINDA=PLU&' '&CENA&' '&NOM:NOS_P
      DISPLAY
   .
   CLOSE(DOS_A)
   IF RAKSTI=0
      RINDA='Nav atrasta neviena nosûtâma nomenklatûra'
   ELSE
      RINDA='Izsaucam apmaiòas programmu .... MNLP15.exe '
      CASE SYS:E_SVARI
      OF 1
         run('\WINLATS\BIN\MNLP15.EXE '&PARAMETRI)
      OF 2
         run('\WINLATS\BIN\TRSM90X.EXE '&PARAMETRI)
      .
   .
   UNHIDE(?OKBUTTON)
   DISPLAY
   ACCEPT
      CASE FIELD()
      OF ?OKBUTTON
         CASE EVENT()
         OF EVENT:Accepted
            BREAK
         END
      END
   .
   CLOSE(SHOWSCREEN)


!--------------------SOURCE--------------------------------
 OMIT('MARIS')
   REPORTNAME='ZURNALS.RPT'
!*
   FILENAME2='LP15-422.CMD'
   CHECKOPEN(DOS_K)
   IF BYTES(DOS_K)=0
      CONST=' 2 01 LP15-422.PLU'
      ADD(DOS_K)
   .
   SET(DOS_K)
   NEXT(DOS_K)
   IF ERROR() THEN STOP(ERROR()).
   sav_const=const
   OPEN(SCREEN1)
   DISPLAY
   LOOP
      ACCEPT
      CASE FIELD()
      OF ?OK
         BREAK
      OF ?ATLIKT
         CLOSE(DOS_K)
         CLOSE(SCREEN1)
         RETURN
      .
   .
   CLOSE(SCREEN1)
   IF ~(SAV_CONST=CONST)
      PUT(DOS_K)
   .
   CLOSE(DOS_K)
!*
  MARIS
UpdateMER_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
Update::Reloop  BYTE
Update::Error   BYTE
History::MER:Record LIKE(MER:Record),STATIC
SAV::MER:Record      LIKE(MER:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the MER_K File'),AT(,,97,56),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('UpdateMER_K'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,72,30),USE(?CurrentTab)
                         TAB('Mçrvienîba :'),USE(?Tab:1)
                           ENTRY(@s7),AT(21,20,40,10),USE(MER:MERVIEN),FONT(,9,,)
                         END
                       END
                       BUTTON('&OK'),AT(8,38,42,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(52,38,40,14),USE(?Cancel)
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
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?MER:MERVIEN)
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
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::MER:Record = MER:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(MER_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?MER:MERVIEN)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::MER:Record <> MER:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:MER_K(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?MER:MERVIEN)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF MER_K::Used = 0
    CheckOpen(MER_K,1)
  END
  MER_K::Used += 1
  BIND(MER:RECORD)
  FilesOpened = True
  RISnap:MER_K
  SAV::MER:Record = MER:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:MER_K()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdateMER_K','winlats.INI')
  WinResize.Resize
  ?MER:MERVIEN{PROP:Alrt,255} = 734
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
    MER_K::Used -= 1
    IF MER_K::Used = 0 THEN CLOSE(MER_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateMER_K','winlats.INI')
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?MER:MERVIEN
      MER:MERVIEN = History::MER:Record.MERVIEN
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  MER:Record = SAV::MER:Record
  SAV::MER:Record = MER:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

