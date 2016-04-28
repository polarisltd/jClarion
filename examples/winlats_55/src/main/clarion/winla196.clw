                     MEMBER('winlats.clw')        ! This is a MEMBER module
BLUEGEN              PROCEDURE                    ! Declare Procedure
Plu               FILE,PRE(PLU),DRIVER('dBase3'),NAME('PLU.DBF'),CREATE
RECORD              RECORD
CODE                  STRING(14)
ART                   STRING(6)
DESCR                 STRING(35)
PRICE                 STRING(15)
PRICE1                STRING(15)
UNIT                  STRING(2)
DEC                   STRING(1)
TAX                   STRING(1)
TBLOCK                STRING(2)
DISC                  STRING(2)
DISC_A                STRING(2)
DEPT                  STRING(2)
QTY                   STRING(15)
AMT                   STRING(15)
STATUS                STRING(1)
STATUS1               STRING(1)
STATUS2               STRING(1)
BOTTLE                STRING(8)
ACTIVE                STRING(1)
DEL                   STRING(1)
LOAD                  STRING(1)
CRC                   STRING(8)
RC                    STRING(1)
                  . .
Directory         CSTRING(65)
Rtn               SHORT
Title             STRING(21)
Path              CSTRING(80)
Drive             CSTRING(4)
Dir               CSTRING(66)
Name              CSTRING(9)
Ext               CSTRING(5)
!?rs                string(1)
window WINDOW('Kases aparâta rakstîðanai'),AT(,,185,73),GRAY
       PROMPT('&Uzbûvçt .DBF'),AT(8,14,43,10),USE(?Prompt1)
       OPTION,AT(60,6,102,35),USE(RS),BOXED
         RADIO('Visâm'),AT(63,14,31,10),USE(?RS:Radio1)
         RADIO('Tikai ar KA statusu 0 vai 1'),AT(63,24),USE(?RS:Radio2)
       END
       BUTTON('&OK'),AT(82,49,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(126,49,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
  open(screen)
  display
  loop
    ACCEPT
    case field()
    of ?OK
      break
    .
  .
  CLOSE(screen)
  open(SHOWscreen)
  CHECKOPEN(nom_k)
  CREATE(Plu)
  DO CheckError
  OPEN(Plu)
  DO CheckError
  Records# = 0
  SET(nom_k)
  LOOP
    NEXT(nom_k)
    IF ERRORCODE() = 33 THEN BREAK.
    DO CheckError
    if NOM:kods
!      STOP(RS&NOM:STATUSS[NOLNR])
       if RS='V' OR (rs='T' and instring(NOM:statuss[SYS:AVOTA_NR],'01'))
          DO LoadRecord
          APPEND(Plu)
          IF ERROR()
             STOP(ERRORFILE()&' '&ERROR())
          ELSE
             NOM:STATUSS[sys:avota_nr]=3
             PUT(NOM_K)
          .
       .
    .
    Records# += 1
    SHOW(12,20,'konvertñti: '&FORMAT(Records#,@n9))
  .
! SHOW(13,20,'Now Building Key Files')
! BUILD(Plu)
  CLOSE(SHOWscreen)
CheckError ROUTINE
  IF ERRORCODE() THEN STOP(ERRORFILE()&' '&ERROR()).
LoadRecord ROUTINE
  PLU:Code                = FORMAT(NOM:KODS,@N_13)
  PLU:Code[13]            = ' '
  PLU:Art                 = ''
  PLU:Descr               = SUB(NOM:NOSAUKUMS,1,35)
  PLU:Price               = FORMAT(NOM:REALIZ2,@N_10.3)
  PLU:Price1              = ''
  CASE NOM:MERVIEN
  OF 'm.'
     PLU:Unit             = '1'
  OF 'KOMPL.'
     PLU:Unit             = '2'
  OF 'iepak.'
     PLU:Unit             = '3'
  OF 'kg.'
     PLU:Unit             = '4'
  OF 'stundas'
     PLU:Unit             = '5'
  OF 'litri'
     PLU:Unit             = '6'
  OF 'pac.'
     PLU:Unit             = '7'
  OF 'kub.m.'
     PLU:Unit             = '8'
  OF 'kv.m.'
     PLU:Unit             = '9'
  OF 'tek.m.'
     PLU:Unit             = '10'
  OF 't.'
     PLU:Unit             = '11'
  OF 'loksne'
     PLU:Unit             = '12'
  OF 'gab.'
     PLU:Unit             = '13'
  OF 'rullis'
     PLU:Unit             = '14'
  OF 'M'
     PLU:Unit             = '15'
  else
     PLU:Unit             = '16'
  .
  PLU:Dec                 = '0'
  if NOM:an
     PLU:Tax              = '1'
  else
     PLU:Tax              = '2'
  .
  PLU:Tblock              = '0'
  PLU:Disc                = '0'
  PLU:Disc_a              = '0'
  PLU:Dept                = '0'
  PLU:Qty                 = '0'
  PLU:Amt                 = '0'
  PLU:Status              = '0'
  PLU:Status1             = '0'
  PLU:Status2             = '0'
  PLU:Bottle              = '0'
  PLU:Active              = '1'
  PLU:Del                 = '0'
  PLU:Load                = '1'
  PLU:Crc                 = ''
  PLU:Rc                  = ''
DIANA
BARMANLAS            PROCEDURE                    ! Declare Procedure
NoMoreFields       BYTE(0)                       !No more fields flag
NonStopSelect      BYTE(0)
RecordQueue        QUEUE,PRE(SAV)                !Queue for concurrency checking
SaveRecord           LIKE(pav:Record),PRE(SAV)   !size of primary file record
                   END                           !End Queue structure
AbortTransaction   BYTE
!!Auto:pav:npk      LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:Hold:pav:npk LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:paR:nR       LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:Hold:paR:nR  LIKE(pav:npk)                  ! AutoInc Save Value
AutoIncAdd    BYTE(0)
SavePointer   STRING(255)                        !Position of current record
AutoAddPtr    STRING(255)                        !Position of Autoinc record
  CODE                                            ! Begin processed code
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
omit('diana')
  REPORTNAME='BARMAN.RPT'
  CHECKOPEN(OUTFILE)
  OPEN(SCREEN)
!************************ 0.SOLIS *******************************
  OUT:RECORD='--------------SEANSS : '& format(today(),@d5) &' '& format(clock(),@t1) &' ----------------'
  ADD(OUTFILE)
  SHOW(10,1,OUT:RECORD)
  close(barman)
  CASE SYC:BA
  OF '1'
     run('\LATS\axread.exe')
  OF '2'
     run('\LATS\YX.exe')            !ID BALTI
  ELSE
      KLUDA(44,KODS&':')
  .
  IF RUNCODE() THEN STOP(RUNCODE()).
!************************ 1.SOLIS *******************************
  CHECKOPEN(NOM_K)
  CHECKOPEN(barman,,12H)
  IF ERROR() THEN STOP(ERROR()).
  CHECKOPEN(PAVAD)
  CHECKOPEN(NOLIK)
  DO AUTONUMBER
  PAV:PAZIME='K'
  PAV:PAZIME1='K'
  PAV:TIPS='E'
  PAV:DATUMS=TODAY()
  PAV:DATUMS1=TODAY()
  PAV:PAMAT='BARMAN'
  PAV:noka  =''
  PAV:PAR_NR=0
  PAV:C_FAKT='4'
! PAV:T_NOS='Ls'
  PAV:NOS='Ls'
  PAV:OPERATORS=KODS
  PAV:I_DATUMS=TODAY()
  PUT(PAVAD)
  IF ERROR()
     KLUDA(24,'PAVAD')
     DO RET
  .
!********************* 2.SOLIS *******************************
  SET(barman)
  LOOP UNTIL EOF(barman)
     NEXT(barman)
     CLEAR(NOL:RECORD)
     CLEAR(NOM:RECORD)
     NOM:KODS = SUB(bar:KODS,1,BAR:EAN)
     GET(NOM_K,NOM:KOD_KEY)
     IF ERROR()
        KLUDA(16,'KODS='&CLIP(LEFT(bar:KODS)))
        NOM:KODS = bar:KODS
        NOM:NOSAUKUMS= bar:kods
        NOM:NOS_S= ''
        NOM:NOMENKLAT='+'&CLIP(LEFT(bar:KODS))
        NOM:ATLIKUMS[SYS:AVOTA_NR]-=bar:SKAITS
        NOM:STATUSS[SYS:AVOTA_NR] = '3'
        NOM:BKK='21300'
        NOM:NOS1='Ls'
        NOM:NOS2='Ls'
        NOM:NOS3='Ls'
        NOM:NOS4='Ls'
        NOM:NOS5='Ls'
        NOM:TIPS='P'
        ADD(NOM_K)
        OUT:RECORD='--- pârbaudiet nomenklatûru '&nom:nomenklat
        ADD(OUTFILE)
     ELSE
        NOM:ATLIKUMS[SYS:AVOTA_NR]-=bar:SKAITS
        PUT(NOM_K)
     .
     IF ERROR() THEN STOP(ERROR()).
     NOL:NR=PAV:NPK
     NOL:DATUMS=TODAY()
     NOL:NOMENKLAT=NOM:NOMENKLAT
     NOL:PAR_NR=0
     NOL:PAZIME='K'
     NOL:DAUDZUMS=bar:SKAITS
     NOL:MERVIEN  =NOM:MERVIEN
     EXECUTE SYS:NOKL_CP
        NOL:SUMMAV=NOM:realiz1*BAR:SKAITS
        NOL:SUMMAV=NOM:realiz2*BAR:SKAITS
        NOL:SUMMAV=NOM:realiz3*BAR:SKAITS
        NOL:SUMMAV=NOM:realiz4*BAR:SKAITS
        NOL:SUMMAV=NOM:realiz5*BAR:SKAITS
     .
     EXECUTE SYS:NOKL_CP
        NOL:NOS=NOM:NOS1
        NOL:NOS=NOM:NOS2
        NOL:NOS=NOM:NOS3
        NOL:NOS=NOM:NOS4
        NOL:NOS=NOM:NOS5
     .
     NOL:SUMMA=NOL:SUMMAV*BANKURS(NOL:NOS,NOL:DATUMS,0)
     NOL:AN = NOM:AN
     NOL:AR = 'ar'
     PAV:SUMMA+=NOL:SUMMA
     ADD(nolik)
     IF ERROR()
        KLUDA(24,'NOLIK')
        DO RET
     .
     OUT:RECORD='L: '&FORMAT(TODAY(),@D5)&' KODS= '&CLIP(LEFT(bar:KODS)) &' '& nom:NOSAUKUMS & FORMAT(nol:SUMMAV,@N_8.2)&' '&NOL:NOS
     SHOW(12,1,OUT:RECORD)
     ADD(OUTFILE)
     IF NOM:ATLIKUMS[SYS:AVOTA_NR]<0
        OUT:RECORD='--- veidojas negatîvs atlikums...'
        ADD(OUTFILE)
     .
  .
!********************* 3.SOLIS *******************************
  PUT(PAVAD)   !PAV:SUMMA
  CHECKOPEN(GL)
  SET(GL)
  NEXT(GL)
  GL:PAV_NR+=1
  IF GL:PAV_NR<10
     PAV:NR='  '&FORMAT(GL:PAV_NR,@S1)
  ELSIF INRANGE(GL:PAV_NR,10,99)
     PAV:NR=' '&FORMAT(GL:PAV_NR,@S2)
  ELSE
     PAV:NR=GL:PAV_NR
  .
  put(gl)
  SHOW(12,20,FORMAT(PAV:DATUMS,@D5)&' '&PAV:NOKA&' '&PAV:SUMMA)
  EMPTY(BARMAN)
  IF ERROR() THEN STOP(ERROR()).
  DO RET
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
RET          ROUTINE
    CLOSE(BARMAN)
    CLOSE(OUTFILE)
    LocalResponse=RequestCompleted
    BEEP
    SHOW(13,15,'Spiediet jebkuru taustiòu, lai turpinâtu')
    ASK
    CLOSE(SCREEN)
    RETURN
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
AutoNumber Routine                               ! Generate AutoInc Values
  DO SaveAutoNumber                              ! Save AutoNum Prime Value
  DO NextAutoNumber                              ! Generate Next Autonumber
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
SaveAutoNumber ROUTINE
  Auto:pav:npk = 0                               ! Clear AutoInc Value
  Auto:Hold:pav:npk = 0                          ! Other Dup Key checking
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
NextAutoNumber ROUTINE                           ! Get next AutoNum Value
  LOOP                                           ! Loop for autonumbering
    LOOP                                         ! Loop for pav:npk_uni AutoInc
      CLEAR(pav:npk,1)                           ! Clear to high value
      SET(pav:npk_uni,pav:npk_uni)               ! ASCENDING
      PREVIOUS(pavad)                            ! Read last record (Ascending)
      IF ERRORCODE() = BadRecErr                 ! IF No Records
        Auto:pav:npk = 1                         ! then start numbering at 1
      ELSIF ERRORCODE()                          ! On any other error
        GLO:Message1 = 'Unable to READ keyed record'
        GLO:Message2 = 'Cannot continue update....'
        GLO:Message3 = 'Error: '&ERRORCODE() & ' ' & ERROR()
        ShowWarning
        RETURN                       ! and leave the proc
      ELSE                                       ! ELSE (No Errorcode)
        Auto:pav:npk = pav:npk + 1               ! Get next value
      END                                        ! END (IF No Records)
      pav:npk = Auto:pav:npk                     ! Restore key value
      IF DUPLICATE(pav:npk_uni)                  ! IF value already exists
        CYCLE                                    ! Try again
      END                                        ! END (IF Value already...)
      BREAK                                      ! Quit processing this key
    END                                          ! END (Loop for pav:npk_uni ...)
    CLEAR(pav:Record)                            !CLEAR Record buffer
    pav:npk = Auto:pav:npk                       ! Restore values
    ADD(pavad)                                   ! Add the record now
    IF ERRORCODE()                               ! Was there an error?
      CASE ERRORCODE()                           ! Process errors
      OF DupKeyErr                               ! Is it a duplicate key?
        IF Auto:Hold:pav:npk = pav:npk           ! Same value as last time
          GLO:Message1 = 'When adding a record, an unexplained Duplicate' ! set First Message Line
          GLO:Message2 = 'error was encountered.' ! set Second Message Line
          ShowWarning                            ! and inform the user
        ELSE                                     ! ELSE (If not same as last)
          Auto:Hold:pav:npk = pav:npk
          CYCLE                                  ! then try again
        END                                      ! END (IF the same as...)
      ELSE                                       ! ELSE (unexplained error)
        IF DiskError('Record could not be ADDed') ! Check any other error
          RETURN                     ! Leave the procedure
        END                                      ! End IF Diskerror
      END                                        ! End CASE errorcode
    ELSE                                         ! Else no error
      BREAK                                      ! so BREAK Loop
    END                                          ! End IF errorcode
  END                                            ! End LOOP for Autonumbering
  AutoIncAdd = True                              ! Switch AutoIncAdd ON
  AutoAddPtr = POSITION(pav:npk_uni)             ! Save the record position
  RESET(pav:npk_uni,AutoAddPtr)                  ! Position to record we added
  HOLD(pavad,4)                                  ! Hold the record
  NEXT(pavad)                                    ! and read it in to buffer
  IF DiskError('Could not READ Record')          ! Check for I/O error
    RETURN                           ! Leave the procedure
  END                                            ! End IF Diskerror
  EXIT                                           ! Exit the routine
diana
BARMANLASER          PROCEDURE                    ! Declare Procedure
REZIMS       STRING(1)               !REÞÎMS
ATSTAT       STRING(1)               !NENODZÇST BARMAN.BAR
ZINA         STRING(6)
N_TABLE      QUEUE,PRE(N)
NOMENKLAT    STRING(15)
DAUDZUMS     DECIMAL(11,3)
DAUDZUMS1    DECIMAL(11,3)
             .
REGscreen WINDOW('BARMAN lasîðanai'),AT(,,159,144),GRAY
       STRING('Dokumenta formçðana'),AT(31,5),USE(?String1),CENTER
       OPTION,AT(28,16,80,63),USE(rezims),BOXED
         RADIO('K - izçjoðâ P/Z'),AT(32,24,55,10),USE(?rezims:Radio1)
         RADIO('D - ienâkoðâ P/Z'),AT(32,34,63,10),USE(?rezims:Radio2)
         RADIO('SALDO'),AT(32,44,35,10),USE(?rezims:Radio3)
         RADIO('Inventarizâcija'),AT(32,54,59,10),USE(?rezims:Radio4)
         RADIO('C - salîdzinât'),AT(32,65,52,10),USE(?rezims:Radio5)
       END
       STRING('Cena :'),AT(35,82,20,10),USE(?String2)
       ENTRY(@n1),AT(69,82,15,10),USE(sys:nokl_cp),RIGHT
       IMAGE('CHECK3.ICO'),AT(111,99,13,14),USE(?Image1)
       BUTTON('&Nenodzçst BARMAN.BAR'),AT(13,99,92,14),USE(?Button3)
       BUTTON('&OK'),AT(69,122,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(113,122,36,14),USE(?CancelButton)
     END
BARNAME      STRING(40),STATIC
BARLAS       FILE,NAME(BARNAME),PRE(A),DRIVER('ASCII'),CREATE
               RECORD
RAKSTS           STRING(80)
             . .
!            DATU APMAIÒAS FAILA STRUKTÛRA BARMANLASER
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
STR_A        GROUP,OVER(A:RAKSTS),PRE(BA)! APMAIÒAS FAILA STRUKTÛRA
DR1          STRING(5)               !DRAZA 5 cipari
KOMATS1      STRING(1)               !KOMATS
REZIMS       STRING(1)               !REÞÎMS
KOMATS2      STRING(1)               !KOMATS
KODS_ACM     STRING(13)              !ACM KODS 13 KONTROLES CIPARS JAPÂRBAUDA IEVADOT NO KLAVIERES PÇC ALGORITMA....
KOMATS3      STRING(1)               !KOMATS
SKAITS       STRING(7)               !PÂRD PREÈU SKAITS
             .
! ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
!            DATU APMAIÒAS FAILA STRUKTÛRA M90
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
STR_B        GROUP,OVER(A:RAKSTS),PRE(B)! APMAIÒAS FAILA STRUKTÛRA
REZIMS       STRING(2)               !REÞÎMS
DR1          STRING(14)              !DRAZA 14 cipari
KODS_ACM     STRING(13)              !ACM KODS 13 KONTROLES CIPARS JAPÂRBAUDA IEVADOT NO KLAVIERES PÇC ALGORITMA....
DR2          STRING(3)               !DRAZA 3 cipari
SKAITS       STRING(8)               !PÂRD PREÈU SKAITS 5.2
             .
! ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
KODS_ACM     DECIMAL(13)
SKAITS       DECIMAL(8,2)
NoMoreFields       BYTE(0)                       !No more fields flag
NonStopSelect      BYTE(0)
RecordQueue        QUEUE,PRE(SAV)                !Queue for concurrency checking
SaveRecord           LIKE(pav:Record),PRE(SAV)   !size of primary file record
                   END                           !End Queue structure
AbortTransaction   BYTE
!!Auto:pav:npk      LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:Hold:pav:npk LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:paR:nR       LIKE(pav:npk)                  ! AutoInc Save Value
!!Auto:Hold:paR:nR  LIKE(pav:npk)                  ! AutoInc Save Value
AutoIncAdd    BYTE(0)
SavePointer   STRING(255)                        !Position of current record
AutoAddPtr    STRING(255)                        !Position of Autoinc record
  CODE                                            ! Begin processed code
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
OMIT('DIANA')
  CASE SYC:BA
  OF '3'
    BARNAME='BARMAN.BAR'
  OF '4'                !M90
    BARNAME='\HANDY\HANDYLNK\\FROMTERM\DATA0011.APP'
  ELSE
    STOP('?BARMANIS?')
  .
  CLOSE(OUTFILE)
  REPORTNAME='BARMAN.RPT'
  CHECKOPEN(OUTFILE)
  OPEN(regSCREEN)
  display
  loop
     accept
     case field()
     of ?B_atstat
        if atstat
           atstat=''
        else
           atstat='û'
        .
        display
     of ?ok
        break
     of ?cancel
        CLOSE(regSCREEN)
        CLOSE(OUTFILE)
        RETURN
     .
  .
  CLOSE(regSCREEN)
  OPEN(SCREEN)
!************************ 0.SOLIS *******************************
  OUT:RECORD='--------------SEANSS : '& format(today(),@d5) &' '& format(clock(),@t1) &' ----------------'
  ADD(OUTFILE)
  SHOW(10,1,OUT:RECORD)
  close(barlas)
  CASE SYC:BA
  OF '3'
!    run('BARMAN.BAT')
     RUN(COMMAND('COMSPEC',0) & ' /C BARMAN.BAT')
!    STOP('4')
     IF RUNCODE() THEN STOP(RUNCODE()).
  OF '4'  ! M90 LAS×ÐANU INICIALIZð UZ PAÐAS KASTES
  .
!************************ 1.SOLIS *******************************
  CHECKOPEN(NOM_K)
  CHECKOPEN(barlas,,12H)
  IF ERROR() THEN STOP(ERROR()).
  CHECKOPEN(PAVAD)
  CHECKOPEN(NOLIK)
  CHECKOPEN(PAR_K)
  CLEAR(PAR:RECORD)
  IF REZIMS='S'
     NPK#=1
  ELSIF REZIMS='I'        !INVENTARIZÂCIJA
     CHECKOPEN(INV_CEP)
     CHECKOPEN(INV_SAT)
     GET(INC:NPK_UNI,RECORDS(INC:NPK_UNI))
     NPK#=INC:NPK+1
  ELSIF REZIMS='C'        !SALÎDZINÂÐANA
     CHECKOPEN(NOLIK)
     NOL:NR=PAV:NPK
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:NR=PAV:NPK) THEN BREAK.
        N:NOMENKLAT=NOL:NOMENKLAT
        N:DAUDZUMS=NOL:DAUDZUMS
        ADD(N_TABLE)
     .
     SORT(N_TABLE,N:NOMENKLAT)
  ELSE
     DO AUTONUMBER
     PAV:TIPS='E'
     PAV:DATUMS=TODAY()
     PAV:DATUMS1=TODAY()
     PAV:PAMAT='BARMAN_LASER'
     PAV:noka  =PAR:NOS_S
     PAV:PAR_NR=PAR:NR
     PAV:C_FAKT='4'                    !???????????????????
!    PAV:T_NOS='Ls'                    !???????????????????
     PAV:NOS='Ls'
     PAV:OPERATORS=KODS
     PAV:I_DATUMS=TODAY()
     PUT(PAVAD)
     IF ERROR()
        KLUDA(24,'PAVAD')
        DO RET
     .
     GLOBALREQUEST=4
     PARTABLE
     IF GLOBALRESPONSE=REQUESTCANCELLED
        CLEAR(PAR:RECORD)
     .
  .
!********************* 2.SOLIS *******************************
  IF RECORDS(BARLAS)
     COMPAREERROR#=0
  ELSE
     COMPAREERROR#=1
     SHOW(12,15,'Neviens ieraksts no BARMAN nav nolasîts ')
  .
  SET(barlas)
  LOOP
     NEXT(barlas)
     IF ERROR() THEN BREAK.
     CASE SYC:BA
     OF '3'
       KODS_ACM = DEFORMAT(RIGHT(BA:KODS_ACM),@N13)
       SKAITS   = BA:SKAITS      !ÐÍIET, TIKAI VESELI SKAITÎI
     OF '4'                !M90
       IF ~(B:REZIMS='07') THEN CYCLE.   !NAV DATU RINDA
       KODS_ACM = DEFORMAT(RIGHT(B:KODS_ACM),@N13)
       SKAITS   = DEFORMAT(B:SKAITS,@N_8.2)
     .
     CLEAR(NOL:RECORD)
     CLEAR(NOM:RECORD)
     NOM:KODS = KODS_ACM
     GET(NOM_K,NOM:KOD_KEY)
     IF ERROR()
        KLUDA(16,'KODS='&KODS_ACM)
        NOM:KODS = KODS_ACM
        NOM:NOSAUKUMS= kods_ACM
        NOM:NOS_S= ''
        NOM:NOMENKLAT='+'&CLIP(LEFT(KODS_ACM))
        IF REZIMS='K'
           NOM:ATLIKUMS[SYS:AVOTA_NR]-=SKAITS
        ELSIF REZIMS='S' OR REZIMS='D'
           NOM:ATLIKUMS[SYS:AVOTA_NR]+=SKAITS
        .
        NOM:STATUSS[SYS:AVOTA_NR] = '3'
        NOM:BKK='21300'
        NOM:NOS1='Ls'
        NOM:NOS2='Ls'
        NOM:NOS3='Ls'
        NOM:NOS4='Ls'
        NOM:NOS5='Ls'
        NOM:TIPS='P'
        ADD(NOM_K)
        OUT:RECORD='--- pârbaudiet nomenklatûru '&nom:nomenklat
        ADD(OUTFILE)
     ELSE
        IF REZIMS='K'
           NOM:ATLIKUMS[SYS:AVOTA_NR]-=SKAITS
        ELSIF REZIMS='S' OR REZIMS='D'
           NOM:ATLIKUMS[SYS:AVOTA_NR]+=SKAITS
        .
        PUT(NOM_K)
     .
     IF ERROR() THEN STOP(ERROR()).
     IF REZIMS='I'                          !INVENTARIZÂCIJA
        INS:NR=NPK#
        INS:DATUMS=TODAY()
        INS:NOMENKLAT=NOM:NOMENKLAT
        INS:DAUDZUMS=SKAITS
        NOM_SKAITS#+=1
        ADD(INV_SAT)
        IF ERROR()
           KLUDA(24,'INV_SAT')
           DO RET
        .
     ELSIF REZIMS='C'                       !SALÎDZINÂÐANA
        N:NOMENKLAT=NOM:NOMENKLAT
        GET(N_TABLE,N:NOMENKLAT)
        IF ERROR()
           N:DAUDZUMS1=SKAITS
           ADD(N_TABLE)
           COMPAREERROR#=1
        ELSE
           N:DAUDZUMS1=SKAITS
           IF ~(N:DAUDZUMS=N:DAUDZUMS1)
              COMPAREERROR#=1
           .
           PUT(N_TABLE)
        .
     ELSE
        NOL:NR=PAV:NPK
        NOL:DATUMS=TODAY()
        NOL:NOMENKLAT=NOM:NOMENKLAT
        NOL:PAR_NR=PAR:NR
        IF REZIMS='K'
           NOL:PAZIME='K'
        ELSE
           NOL:PAZIME='D'
        .
        NOL:DAUDZUMS=SKAITS
        NOL:MERVIEN  =NOM:MERVIEN
        EXECUTE SYS:NOKL_CP
           NOL:SUMMAV=NOM:realiz1*SKAITS
           NOL:SUMMAV=NOM:realiz2*SKAITS
           NOL:SUMMAV=NOM:realiz3*SKAITS
           NOL:SUMMAV=NOM:realiz4*SKAITS
           NOL:SUMMAV=NOM:realiz5*SKAITS
           NOL:SUMMAV=NOM:PIC*SKAITS
        .
        EXECUTE SYS:NOKL_CP
           NOL:NOS=NOM:NOS1
           NOL:NOS=NOM:NOS2
           NOL:NOS=NOM:NOS3
           NOL:NOS=NOM:NOS4
           NOL:NOS=NOM:NOS5
           NOL:NOS='Ls'
        .
        NOL:SUMMA=NOL:SUMMAV*BANKURS(NOL:NOS,NOL:DATUMS,0)
        IF REZIMS='S'
           NOL:AN = 0
        ELSE
           NOL:AN = NOM:AN
        .
        NOL:AR = 'ar'
        PAV:SUMMA+=NOL:SUMMA
        ADD(nolik)
        IF ERROR()
           KLUDA(24,'NOLIK')
           DO RET
        .
     .
     OUT:RECORD='L: '&FORMAT(TODAY(),@D5)&' KODS= '&CLIP(LEFT(KODS_acm)) &' '& nom:NOSAUKUMS & FORMAT(nol:SUMMAV,@N_8.2)&' '&NOL:NOS
     SHOW(12,1,OUT:RECORD)
     ADD(OUTFILE)
     IF NOM:ATLIKUMS[SYS:AVOTA_NR]<0
        OUT:RECORD='--- veidojas negatîvs atlikums...'
        ADD(OUTFILE)
     .
  .
  CLOSE(OUTFILE)
!********************* 3.SOLIS *******************************
  IF ~(REZIMS='S')
     IF REZIMS='I'
        INC:NPK=NPK#
        INC:NR=NPK#
        INC:DATUMS=TODAY()
        INC:PAMAT='Lâzerskanera nolasîjums'
        INC:nom_skaits= NOM_SKAITS#
        INC:OPERATORS=KODS
        INC:I_DATUMS=TODAY()
        ADD(INV_CEP)
        IF ERROR()
           KLUDA(24,'INV_CEP')
           DO RET
        .
        SHOW(12,20,FORMAT(INC:DATUMS,@D5)&' '&INC:NOM_SKAITS)
     ELSIF REZIMS='C'
        IF COMPAREERROR#
           REPORTNAME='COMP.R'&FORMAT(KODS_N,@N02)
           REMOVE(OUTFILE)
           CHECKOPEN(OUTFILE)
           formats='P'
           SETDRU
           OUT:RECORD='     NOMENKLATÛRA   DAUDZUMS-P/Z DAUDZUMS-BARMAN'
           ADD(OUTFILE)
           LOOP I#= 1 TO RECORDS(N_TABLE)
              GET(N_TABLE,I#)
              IF ~(N:DAUDZUMS=N:DAUDZUMS1)
                 ZINA=' KÏÛDA'
              ELSE
                 ZINA='      '
              .
              OUT:RECORD='     '&N:NOMENKLAT&FORMAT(N:DAUDZUMS,@N-_12.3)&FORMAT(N:DAUDZUMS1,@N-_12.3)&ZINA
              ADD(OUTFILE)
           .
           CLOSE(OUTFILE)
           VIEWASCIIREPORT
        ELSE
           SHOW(12,15,'            P/Z vienâdas                ')
        .
     ELSE
        IF REZIMS='K'
           PAV:PAZIME='K'
           PAV:PAZIME1='K'
           CHECKOPEN(GL)
           SET(GL)
           NEXT(GL)
           GL:PAV_NR+=1
           IF GL:PAV_NR<10
              PAV:NR='  '&FORMAT(GL:PAV_NR,@S1)
           ELSIF INRANGE(GL:PAV_NR,10,99)
              PAV:NR=' '&FORMAT(GL:PAV_NR,@S2)
           ELSE
              PAV:NR=GL:PAV_NR
           .
           put(gl)
        ELSE
           PAV:PAZIME='D'
           PAV:PAZIME1='D'
        .
        PUT(PAVAD)  !PAV:SUMMA PAV:D_K
        SHOW(12,20,FORMAT(PAV:DATUMS,@D5)&' '&PAV:NOKA&' '&PAV:SUMMA)
     .
  .
  IF ~ATSTAT
     EMPTY(BARLAS)
     IF ERROR() THEN STOP(ERROR()).
  .
  DO RET
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
RET          ROUTINE
    CLOSE(BARLAS)
    CLOSE(OUTFILE)
    FREE(N_TABLE)
    LocalResponse=RequestCompleted
    BEEP
    SHOW(13,15,'Spiediet jebkuru taustiòu, lai turpinâtu')
    ASK
    CLOSE(SCREEN)
    RETURN
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
AutoNumber Routine                               ! Generate AutoInc Values
  DO SaveAutoNumber                              ! Save AutoNum Prime Value
  DO NextAutoNumber                              ! Generate Next Autonumber
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
SaveAutoNumber ROUTINE
  Auto:pav:npk = 0                               ! Clear AutoInc Value
  Auto:Hold:pav:npk = 0                          ! Other Dup Key checking
!ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
NextAutoNumber ROUTINE                           ! Get next AutoNum Value
  LOOP                                           ! Loop for autonumbering
    LOOP                                         ! Loop for pav:npk_uni AutoInc
      CLEAR(pav:npk,1)                           ! Clear to high value
      SET(pav:npk_uni,pav:npk_uni)               ! ASCENDING
      PREVIOUS(pavad)                            ! Read last record (Ascending)
      IF ERRORCODE() = BadRecErr                 ! IF No Records
        Auto:pav:npk = 1                         ! then start numbering at 1
      ELSIF ERRORCODE()                          ! On any other error
        GLO:Message1 = 'Unable to READ keyed record'
        GLO:Message2 = 'Cannot continue update....'
        GLO:Message3 = 'Error: '&ERRORCODE() & ' ' & ERROR()
        ShowWarning
        RETURN                       ! and leave the proc
      ELSE                                       ! ELSE (No Errorcode)
        Auto:pav:npk = pav:npk + 1               ! Get next value
      END                                        ! END (IF No Records)
      pav:npk = Auto:pav:npk                     ! Restore key value
      IF DUPLICATE(pav:npk_uni)                  ! IF value already exists
        CYCLE                                    ! Try again
      END                                        ! END (IF Value already...)
      BREAK                                      ! Quit processing this key
    END                                          ! END (Loop for pav:npk_uni ...)
    CLEAR(pav:Record)                            !CLEAR Record buffer
    pav:npk = Auto:pav:npk                       ! Restore values
    PAV:DATUMS=TODAY()
    PAV:DATUMS1=TODAY()
    ADD(pavad)                                   ! Add the record now
    IF ERRORCODE()                               ! Was there an error?
      CASE ERRORCODE()                           ! Process errors
      OF DupKeyErr                               ! Is it a duplicate key?
        IF Auto:Hold:pav:npk = pav:npk           ! Same value as last time
          GLO:Message1 = 'When adding a record, an unexplained Duplicate' ! set First Message Line
          GLO:Message2 = 'error was encountered.' ! set Second Message Line
          ShowWarning                            ! and inform the user
        ELSE                                     ! ELSE (If not same as last)
          Auto:Hold:pav:npk = pav:npk
          CYCLE                                  ! then try again
        END                                      ! END (IF the same as...)
      ELSE                                       ! ELSE (unexplained error)
        IF DiskError('Record could not be ADDed') ! Check any other error
          RETURN                     ! Leave the procedure
        END                                      ! End IF Diskerror
      END                                        ! End CASE errorcode
    ELSE                                         ! Else no error
      BREAK                                      ! so BREAK Loop
    END                                          ! End IF errorcode
  END                                            ! End LOOP for Autonumbering
  AutoIncAdd = True                              ! Switch AutoIncAdd ON
  AutoAddPtr = POSITION(pav:npk_uni)             ! Save the record position
  RESET(pav:npk_uni,AutoAddPtr)                  ! Position to record we added
  HOLD(pavad,4)                                  ! Hold the record
  NEXT(pavad)                                    ! and read it in to buffer
  IF DiskError('Could not READ Record')          ! Check for I/O error
    RETURN                           ! Leave the procedure
  END                                            ! End IF Diskerror
  EXIT                                           ! Exit the routine
DIANA
