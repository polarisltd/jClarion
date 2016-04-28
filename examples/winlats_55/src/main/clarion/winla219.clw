                     MEMBER('winlats.clw')        ! This is a MEMBER module
RW_Pav_dbf           PROCEDURE (OPC)              ! Declare Procedure
LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
darbiba               STRING(40)
FAILS                 CSTRING(20)

ToScreen WINDOW('Nor�diet, kur rakst�t'),AT(,,185,86),GRAY
       STRING('Rakstu ...'),AT(39,6,108,10),FONT(,9,,FONT:bold),USE(?StringRakstu),CENTER
       OPTION,AT(9,19,173,46),USE(merkis),BOXED
         RADIO('Teko�� direktorij�'),AT(16,28,161,10),USE(?Merkis:Radio1)
         RADIO('E:\'),AT(16,39),USE(?Merkis:Radio2)
         RADIO('Priv�taj� folder�'),AT(16,50),USE(?Merkis:Radio3)
       END
       BUTTON('&Atlikt'),AT(109,67,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(147,67,35,14),USE(?OkButton),DEFAULT
     END

ReadScreen WINDOW('Lasu apmai�as failu'),AT(,,180,55),GRAY
       STRING(@s40),AT(24,20),USE(darbiba)
     END

  CODE                                            ! Begin processed code
 CHECKOPEN(NOLIK,1)
 NOLIK::USED+=1
 CHECKOPEN(NOM_K,1)
 NOM_K::USED+=1
 DISKETE=FALSE

 CASE OPC
 OF 1                           !RAKST�T
   disks=''
   OPEN(TOSCREEN)
   ?StringRakstu{prop:text}='Faila v�rds: BP'&clip(GETDOK_SENR(2,PAV:DOK_SENR,,'2'))&'.DBF'
   ?Merkis:radio3{prop:text}=USERFOLDER
   ?Merkis:radio1{prop:text}=longpath()
   MERKIS=USERFOLDER
   SELECT(?Merkis:radio3)
   DISPLAY
   ACCEPT
      CASE FIELD()
      OF ?OkButton
         CASE EVENT()
         OF EVENT:Accepted
            EXECUTE CHOICE(?MERKIS)
               DISKS=''
               BEGIN
                  DISKS=USERFOLDER&'\'
                  DISKETE=TRUE
               .
               DISKS=USERFOLDER&'\'
            .
            LocalResponse = RequestCompleted
            BREAK
         END
      OF ?CancelButton
         CASE EVENT()
         OF EVENT:Accepted
            LocalResponse = RequestCancelled
            BREAK
         END
      END
   .
   IF LocalResponse = RequestCancelled
      CLOSE(TOSCREEN)
      DO PROCEDURERETURN
   .
   HIDE(1,?OkButton)
   UNHIDE(?STRINGRAKSTU)
   DISPLAY

   B_PAVADNAME=DISKS&'BP'&CLIP(GETDOK_SENR(2,PAV:DOK_SENR,,'2'))&'.DBF'
   CREATE(B_PAVAD)
   IF ERROR()
      STOP(ERROR())
      DO PROCEDURERETURN
   .
   CLOSE(B_PAVAD)
   OPEN(B_PAVAD,18)
   if error()
      KLUDA(1,B_PAVADNAME)
      DO PROCEDURERETURN
   .
   EMPTY(B_PAVAD)
   CLEAR(NOL:RECORD)
   NOL:U_NR=PAV:U_NR
   SET(NOL:NR_KEY,NOL:NR_KEY)
   LOOP
      NEXT(NOLIK)
      IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
      BPA:DATUMS   =PAV:DATUMS
      BPA:D_K      =PAV:D_K
      BPA:DOK_SENR =PAV:DOK_SENR
!      BPA:PAR_NR   =GL:REG_NR
      BPA:PAR_NR   =LOC_NR
      BPA:APM_V    =PAV:apm_k
      BPA:APM_K    =PAV:apm_v
      BPA:C_DATUMS =PAV:C_DATUMS
      BPA:C_SUMMA  =PAV:C_SUMMA
      BPA:T_SUMMA  =PAV:T_SUMMA
      BPA:T_PVN    =PAV:T_PVN
      BPA:VAL      =PAV:val
      BPA:NOMENKLAT=getnom_k(NOL:NOMENKLAT,2,1)
      BPA:KODS     =NOM:KODS
      BPA:ARTIKULS =NOM:KATALOGA_NR
      BPA:TIPS     =NOM:TIPS
      BPA:NOSAUKUMS=NOM:NOS_P
      BPA:NOS_S    =NOM:NOS_S
      BPA:MERVIEN  =NOM:MERVIEN
      BPA:SVARS    =NOM:SVARSKG
      BPA:SKAITS_I =NOM:SKAITS_I
      BPA:DER_TERM =NOM:DER_TERM
      BPA:Daudzums =NOL:DAUDZUMS
      BPA:SUMMAV   =NOL:SUMMAV
      BPA:ATLAIDE_PR=NOL:ATLAIDE_PR
      BPA:PVN_PROC =NOL:PVN_PROC
      BPA:ARBYTE   =NOL:ARBYTE
      APPEND(B_PAVAD)
      RAKSTI#+=1
      IF ERROR() THEN STOP('RAKSTOT DBF:'&ERROR()).
   .
   CLOSE(TOSCREEN)
   IF DISKETE
      KLUDA(99,'un sagatavotas kop��anai uz E:\ '&clip(raksti#)&' nomenklat�ras')
      close(B_PAVAD)
      COPY(B_pavad,'E:\')
      IF ERROR()
         KLUDA(3,B_PAVADNAME&' uz E:\ '&error())
      .
   ELSE
      KLUDA(99,'un sekm�gi p�rrakst�tas '&clip(raksti#)&' nomenklat�ras')
   .
 OF 2                           !LAS�T
   TTAKA"=LONGPATH()
   B_PAVADNAME=''
   IF FILEDIALOG('...TIKAI BXXXXXXX.TPS FAILI !!!',B_PAVADNAME,'DBF3|*.dbf',0)
      SETPATH(TTAKA")
      IF FILENAME1[1]='A'
         LOOP I#=LEN(B_PAVADNAME)-1 TO 1 BY -1
            IF B_PAVADNAME[I#]='\'
               FAILS=B_PAVADNAME[I#+1:LEN(B_PAVADNAME)]
               FOUND#=1
               BREAK
            .
         .
!         USERFOLDER=USERFOLDER&'\'
         COPY(B_pavad,USERFOLDER&'\')
         IF ERROR()
            KLUDA(3,B_PAVADNAME&' '&error())
            DO PROCEDURERETURN
         .
         B_PAVADNAME=USERFOLDER&'\'&FAILS
      .
      OPEN(ReadScreen)
      CHECKOPEN(B_PAVAD,1)
      DO AUTONUMBER
      FILLPVN(0)
      SET(B_PAVAD)
      LOOP
        NEXT(B_PAVAD)
        DARBIBA='Lasu '&BPA:NOMENKLAT
        DISPLAY
        IF ERROR() THEN BREAK.
        DO WRITENOM_K
        DO WRITENOLIK
        PAV:SUMMA_A+=NOL:SUMMA*NOL:ATLAIDE_PR/100
      .
      DARBIBA='Rakstu Pavad '
      DISPLAY
      PAV:D_K='D'
      PAV:DATUMS=BPA:DATUMS
      PAV:DOK_SENR=BPA:DOK_SENR
      PAV:PAMAT='Apm. faila nolas�jums'
      PAV:noka  =''
      PAV:APM_V=BPA:APM_V
      PAV:APM_K=BPA:APM_K
      PAV:PAR_NR=BPA:PAR_NR
      PAV:SUMMA=ROUND(GETPVN(3),.01)+ROUND(getpvn(1),.01)
      PAV:SUMMA_B=ROUND(GETPVN(3),.01)
      PAV:VAL=BPA:VAL
      PAV:ACC_KODS=ACC_KODS
      PAV:ACC_DATUMS=TODAY()
      IF RIUPDATE:PAVAD()
         KLUDA(24,'PAVAD')
         DO PROCEDURERETURN
      .
      CLOSE(ReadScreen)
      KLUDA(99,'un sekm�gi ierakst�tas '&clip(raksti#)&' nomenklat�ras')
    .
 .
 DO PROCEDURERETURN
!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ RE�LO PAVAD
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
          DO PROCEDURERETURN
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  NOLIK::USED-=1
  IF NOLIK::USED=0
     CLOSE(NOLIK)
  .
  NOM_K::USED-=1
  IF NOM_K::USED=0
     CLOSE(NOM_K)
  .
  CLOSE(B_PAVAD)
  RETURN
!---------------------------------------------------------------------------------------------
WRITENOM_K    ROUTINE
     IF GETNOM_K(BPA:NOMENKLAT,2,1)
        DARBIBA='Mainu atlikumus '&BPA:NOMENKLAT
        DISPLAY
        AtlikumiN('D',BPA:NOMENKLAT,BPA:DAUDZUMS,'','',0)
        KopsN(BPA:NOMENKLAT,BPA:DATUMS,'D')
     ELSE
        DARBIBA='Jauna nomenklat�ra, rakstu '&BPA:NOMENKLAT
        DISPLAY
        CLEAR(NOM:RECORD)
        NOM:KODS=BPA:KODS
        NOM:NOS_P=BPA:NOSAUKUMS
        NOM:NOMENKLAT=BPA:NOMENKLAT
        AtlikumiN('D',BPA:NOMENKLAT,BPA:DAUDZUMS,'','',0)
        NOM:TIPS=BPA:TIPS
        LOOP I#= 1 TO 5
           NOM:VAL[I#]='Ls'
        .
        NOM:KATALOGA_NR=BPA:ARTIKULS
        NOM:NOS_S      =BPA:NOS_S 
        NOM:MERVIEN    =BPA:MERVIEN
        NOM:SVARSKG    =BPA:SVARS
        NOM:SKAITS_I   =BPA:SKAITS_I
        NOM:DER_TERM   =BPA:DER_TERM
        ADD(NOM_K)
        IF ERROR()
           stop(error())
           KLUDA(24,'NOM_K (ADD) NOM='&BPA:NOMENKLAT&' KODS='&BPA:KODS)
        .
     .

!---------------------------------------------------------------------------------------------
WRITENOLIK    ROUTINE
        DARBIBA='Rakstu Nolik '&BPA:NOMENKLAT
        DISPLAY
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        NOL:D_K      ='D'
        NOL:NOMENKLAT=NOM:NOMENKLAT
        NOL:PAR_NR   =BPA:PAR_NR
        NOL:DATUMS   =BPA:DATUMS
        NOL:DAUDZUMS =BPA:Daudzums
        NOL:SUMMAV   =BPA:SUMMAV
        NOL:SUMMA    =BPA:SUMMAV
        NOL:ATLAIDE_PR=BPA:ATLAIDE_PR
        NOL:PVN_PROC =BPA:PVN_PROC
        NOL:ARBYTE   =BPA:ARBYTE 
        NOL:VAL      =BPA:VAL
        FILLPVN(1)
        raksti#+=1
        ADD(nolik)
        IF ERROR()
           KLUDA(24,'NOLIK(ADD) NOM='&NOL:NOMENKLAT)
           DO PROCEDURERETURN
        .


CALCKOPS             FUNCTION (K_MEN_NR,K_NOL_NR,RET) ! Declare Procedure
CIPARS     REAL
D          DECIMAL(11,3)
S          DECIMAL(11,2)
S_MEN      BYTE
B_MEN      BYTE
  CODE                                            ! Begin processed code
!
! J�B�T UZB�V�TIEM KOPS:: AR CHECKKOPS
! K_MEN_NR-INDEKSS KOPS::MAS�V� VAI 13-17,18
!
!  1   REALIZ�CIJAS SUMMA M�NES�,CET,G KONKR�T� NOLIKTAV� (E)
!  2   REALIZ�CIJAS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (E)
!  3   REALIZ�CIJAS DAUDZUMS M�NES�,CET,G KONKR�T� NOLIKTAV� (E)
!  4   REALIZ�CIJAS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (E)
!  5   VID�J� IEPIRKUMA CENA NO 1.M UZ M BEIG�M VIS� SIST�M� + SALDO (E,R)
!  6   VID�J� REALIZ�CIJAS CENA M�NES�,CET,G VIS� SIST�M� (E)
!  7   IEK��J� P�RVIETO�ANA - DEBETS M�NES�,CET,G KONKR�T� NOLIKTAV� (I)
!  8   IEK��J� P�RVIETO�ANA - KRED�TS M�NES�,CET,G KONKR�T� NOLIKTAV� (I)
!  9   IEK��J� P�RVIETO�ANA - KRED�TS NO G.S�K. L�DZ M�NE�A BEIG�M KONKR�T� NOLIKTAV� (I)
!  10  KOP�J� IEPIRKUMA SUMMA NO GADA S�KUMA VIS� SIST�M� + SALDO
!  11  KOP�JAIS IEPIRKUMA DAUDZUMS NO GADA S�KUMA VIS� SIST�M� + SALDO
!  12  ATLIKUMS UZ M BEIG�M VIS� SIST�M� + SALDO
!  13  IEN�CIS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (E)
!  14  IEN�CIS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (E)
!  15  IZG�JIS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (R)
!  16  IZG�JIS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (R)
!  17  ATLIKUMS UZ M S�KUMU VIS� SIST�M� + SALDO
!  18  VID�J� IEPIRKUMA CENA NO 1.M UZ M S�KUMU VIS� SIST�M� + SALDO (E,R)

  IF K_MEN_NR <= 12
     S_MEN=K_MEN_NR
     B_MEN=K_MEN_NR
  ELSIF K_MEN_NR=13 ! I CETURKSNIS
     S_MEN=1
     B_MEN=3
  ELSIF K_MEN_NR=14 ! II CETURKSNIS
     S_MEN=4
     B_MEN=6
  ELSIF K_MEN_NR=15 ! III CETURKSNIS
     S_MEN=7
     B_MEN=9
  ELSIF K_MEN_NR=16 ! IV CETURKSNIS
     S_MEN=10
     B_MEN=12
  ELSIF K_MEN_NR=17 ! FGADS
     S_MEN=1
     B_MEN=12
  ELSIF K_MEN_NR=18 ! PERIODS-TO NEVAJADZ�TU PIE�AUT
     S_MEN=1
     B_MEN=12
  .

  CASE RET
  OF 1 ! REALIZ�CIJAS SUMMA M�NES�,CET,G KONKR�T� NOLIKTAV� (E)
     LOOP M#=S_MEN TO B_MEN
        CIPARS+=KOPS::K_SUMMA[M#,K_NOL_NR]
     .
  OF 2 ! REALIZ�CIJAS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (E)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::K_SUMMA[M#,I#]
        .
     .
  OF 3 ! REALIZ�CIJAS DAUDZUMS M�NES�,CET,G KONKR�T� NOLIKTAV� (E)
     LOOP M#=S_MEN TO B_MEN
        CIPARS+=KOPS::K_DAUDZUMS[M#,K_NOL_NR]
     .
  OF 4 ! REALIZ�CIJAS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (E)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::K_DAUDZUMS[M#,I#]
        .
     .
  OF 5 ! VID�J� IEPIRKUMA CENA NO GADA S�KUMA UZ M BEIG�M VIS� SIST�M� + SALDO (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO B_MEN
           S+=KOPS::D_SUMMA[M#,I#]
           D+=KOPS::D_DAUDZUMS[M#,I#]
        .
        S+=KOPS::A_SUMMA[I#]
        D+=KOPS::A_DAUDZUMS[I#]
     .
     CIPARS=S/D
  OF 6 ! VID�J� REALIZ�CIJAS CENA M�NES�,CET,G VIS� SIST�M� (E)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           S+=KOPS::K_SUMMA[M#,I#]
           D+=KOPS::K_DAUDZUMS[M#,I#]
        .
     .
     CIPARS=S/D
  OF 7 ! IEK��J� P�RVIETO�ANA - DEBETS M�NES�,CET,G KONKR�T� NOLIKTAV� (I)
     LOOP M#=S_MEN TO B_MEN
        CIPARS+=KOPS::DI_DAUDZUMS[M#,K_NOL_NR]
     .
  OF 8 ! IEK��J� P�RVIETO�ANA - KRED�TS M�NES�,CET,G KONKR�T� NOLIKTAV� (I)
     LOOP M#=S_MEN TO B_MEN
        CIPARS+=KOPS::KI_DAUDZUMS[M#,K_NOL_NR]
     .
  OF 9 ! IEK��J� P�RVIETO�ANA - KRED�TS NO G.S�K. L�DZ M�NE�A BEIG�M KONKR�T� NOLIKTAV� (I)
     LOOP M#=1 TO B_MEN
        CIPARS+=KOPS::KI_DAUDZUMS[M#,K_NOL_NR]
     .
  OF 10 ! KOP�J� IEPIRKUMA SUMMA NO GADA S�KUMA VIS� SIST�M� + SALDO
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO B_MEN
           S+=KOPS::D_SUMMA[M#,I#]
        .
        S+=KOPS::A_SUMMA[I#]
     .
     CIPARS=S
  OF 11 ! KOP�JAIS IEPIRKUMA DAUDZUMS NO GADA S�KUMA VIS� SIST�M� + SALDO (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO B_MEN
           D+=KOPS::D_DAUDZUMS[M#,I#]
        .
        D+=KOPS::A_DAUDZUMS[I#]
     .
     CIPARS=D
  OF 12 ! ATLIKUMS UZ M BEIG�M VIS� SIST�M� + SALDO (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO B_MEN
           D+=KOPS::D_DAUDZUMS[M#,I#] !E,R
           D-=KOPS::K_DAUDZUMS[M#,I#]+KOPS::KR_DAUDZUMS[M#,I#] !E+R
        .
        D+=KOPS::A_DAUDZUMS[I#]
     .
     CIPARS=D
  OF 13 ! IEN�CIS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::D_DAUDZUMS[M#,I#]
        .
     .
  OF 14 ! IEN�CIS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::D_SUMMA[M#,I#]
        .
     .
  OF 15 ! REALIZ�CIJAS DAUDZUMS M�NES�,CET,G VIS�S NOLIKTAV�S (R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::KR_DAUDZUMS[M#,I#]
        .
     .
  OF 16 ! REALIZ�CIJAS SUMMA M�NES�,CET,G VIS�S NOLIKTAV�S (R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=S_MEN TO B_MEN
           CIPARS+=KOPS::KR_SUMMA[M#,I#]
        .
     .
  OF 17 ! ATLIKUMS UZ M S�KUMU VIS� SIST�M� + SALDO (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO S_MEN-1
           D+=KOPS::D_DAUDZUMS[M#,I#] !E,R
           D-=KOPS::K_DAUDZUMS[M#,I#]+KOPS::KR_DAUDZUMS[M#,I#] !E+R
        .
        D+=KOPS::A_DAUDZUMS[I#]
     .
     CIPARS=D
  OF 18 ! VID�J� IEPIRKUMA CENA NO GADA S�KUMA UZ M S�KUMU VIS� SIST�M� + SALDO (E,R)
     LOOP I#= 1 TO NOL_SK
        LOOP M#=1 TO S_MEN-1
           S+=KOPS::D_SUMMA[M#,I#]
           D+=KOPS::D_DAUDZUMS[M#,I#]
        .
        S+=KOPS::A_SUMMA[I#]
        D+=KOPS::A_DAUDZUMS[I#]
     .
     CIPARS=S/D
  ELSE
     KLUDA(0,'CALCKOPS IZSAUKUMA K��DA : '&RET)
  .
  RETURN(CIPARS)




KopsN                PROCEDURE (NOL_nomenklat,NOL_datums,NOL_D_K,<G_REQ>) ! Declare Procedure
Auto::Save:KOPS:U_NR ULONG
AUTO::ATTEMPTS       LONG
LocalResponse        BYTE
  CODE                                            ! Begin processed code
!j�b�t pozicion�tam NOM_K
  IF ~INSTRING(NOM:TIPS,'TAIV',1) AND ~(NOM:REDZAMIBA=2)    !Taru,Pakalpojumus,Iepakojumus,Virtu�los,N�KOTNES izlai�am
     CHECKOPEN(NOL_KOPS,1)
     CLEAR(KOPS:RECORD)
     KOPS:NOMENKLAT=NOL_NOMENKLAT
     IF G_REQ=3
        GET(NOL_KOPS,KOPS:NOM_key)
        IF ~ERROR()
           IF RIDELETE:NOL_KOPS()
              KLUDA(0,'DELETE NOL_KOPS')
           .
        .
     ELSE
        IF INSTRING(NOL_D_K,'DK')
           IF ~(YEAR(DB_S_DAT)=YEAR(DB_B_DAT)) AND|  !CIT�DS FINANSU GADS
               (YEAR(NOL_DATUMS)<DB_GADS)            !PZ IEPRIEK��J� GAD�
              M#=1
           ELSE
              M#=MONTH(NOL_DATUMS)+DB_FGK
           .
           GET(NOL_KOPS,KOPS:NOM_key)
           IF ERROR()
              DO AUTONUMBER
   !        STOP('ADD NOL_KOPS '&KOPS:U_NR&' '&ERROR())
              KOPS:NOMENKLAT=NOL_NOMENKLAT
              KOPS:KATALOGA_NR=NOM:KATALOGA_NR
              KOPS:NOS_S=NOM:NOS_S
              KOPS:STATUSS[M#,LOC_NR]=1 !JAUNS, LAI P�RR��INA
           .
           IF KOPS:STATUSS[M#,LOC_NR]>1 !VISS OK
              KOPS:STATUSS[M#,LOC_NR]=1 !MAIN�TS
           .
           PUT(NOL_KOPS)
      !     STOP('PUT'&M#&LOC_NR&KOPS:STATUSS[M#,LOC_NR]&ERROR())
        .
     .
     CLOSE(NOL_KOPS)
  .
!-------------------------------------------------------------------------------------
AUTONUMBER ROUTINE
  Auto::Attempts = 0
  LOOP
    SET(KOPS:NR_KEY)
    PREVIOUS(NOL_KOPS)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:KOPS:U_NR = 1
    ELSE
      Auto::Save:KOPS:U_NR = KOPS:U_NR + 1
    END
    CLEAR(KOPS:RECORD)
    KOPS:U_NR = Auto::Save:KOPS:U_NR
    ADD(NOL_KOPS)
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
