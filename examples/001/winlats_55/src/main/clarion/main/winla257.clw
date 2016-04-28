                     MEMBER('winlats.clw')        ! This is a MEMBER module
RW_IMP_TXT           PROCEDURE (OPC)              ! Declare Procedure
LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:G1:U_NR    LIKE(GG:U_NR)

DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
darbiba               STRING(50)
FAILS                 CSTRING(20)
DOK_SK                USHORT
KONT_SK               USHORT

SAK_DAT               LONG
BEI_DAT               LONG
X                     BYTE
IZVELETO              BYTE

SAV_POSITION          STRING(260)
LAST_U_NR             LIKE(GGK:U_NR)
GGK_D_K               LIKE(GGK:D_K)
GGK_BKK               LIKE(GGK:BKK)
S1                    STRING(1)
BW                    STRING(1)

ToScreen WINDOW('Apmaiòas TXT faila sagatavoðana'),AT(,,190,138),GRAY
       STRING(@s70),AT(3,3,179,10),USE(ANSIFILENAME),CENTER
       STRING('Rakstu ...'),AT(61,13),USE(?StringRakstu),HIDE,FONT(,9,,FONT:bold)
       STRING(@N_5B),AT(94,13),USE(KONT_SK),LEFT
       STRING('Kopçju uz E:\ ...'),AT(62,22),USE(?STRINGDISKETE),HIDE,CENTER
       OPTION('Norâdiet, kur rakstît'),AT(9,31,173,45),USE(merkis),BOXED
         RADIO('Privâtais folderis'),AT(16,40),USE(?Merkis:Radio1),VALUE('1')
         RADIO('E:\'),AT(16,49),USE(?Merkis:Radio2),VALUE('2')
         RADIO('Tekoðâ direktorijâ'),AT(16,59,161,10),USE(?Merkis:Radio3),VALUE('3')
       END
       SPIN(@D6),AT(33,79,56,12),USE(SAK_DAT)
       SPIN(@D6),AT(113,79,56,12),USE(BEI_DAT)
       STRING('rakstus ,kam D/K='),AT(12,97),USE(?String4)
       ENTRY(@N1b),AT(73,96,13,12),USE(GGK_D_K)
       STRING('un kontçjumâ ir '),AT(90,97),USE(?String4:1)
       ENTRY(@S5),AT(145,96,29,12),USE(GGK_BKK)
       BUTTON('Tikai izvçlçto dokumentu'),AT(58,113,87,14),USE(?ButtonIzveleto)
       STRING('lîdz'),AT(96,80),USE(?String3)
       STRING('no'),AT(22,80),USE(?String2)
       BUTTON('&Atlikt'),AT(19,113,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(147,113,35,14),USE(?OkButton),DEFAULT
     END


ReadScreen WINDOW('Lasu apmaiòas failu'),AT(,,246,55),GRAY
       STRING(@s50),AT(24,20,205,10),USE(darbiba)
     END

  CODE                                            ! Begin processed code
 DISKETE=FALSE
 IZVELETO=FALSE
 ANSIFILENAME=''
 CHECKOPEN(PAR_K,1)

 CASE OPC
 OF 1 !*****************************RAKSTÎT************************************
   disks=''
   MERKIS='1'
   SAK_dat=GG:datums
   BEI_dat=GG:datums
   OPEN(TOSCREEN)
   ?Merkis:radio1{prop:text}=USERFOLDER
   ?Merkis:radio3{prop:text}=path()
   DISPLAY
   ACCEPT
      CASE FIELD()
      OF ?OkButton
         CASE EVENT()
         OF EVENT:Accepted
            EXECUTE CHOICE(?MERKIS)
               DISKS=USERFOLDER&'\'
               BEGIN
                  DISKS=USERFOLDER&'\'
                  DISKETE=TRUE !FLAÐÐ
               .
               DISKS=''
            .
            LocalResponse = RequestCompleted
            BREAK
         END
      OF ?ButtonIzveleto
         CASE EVENT()
         OF EVENT:Accepted
            EXECUTE CHOICE(?MERKIS)
               DISKS=USERFOLDER&'\'
               BEGIN
                  DISKS=USERFOLDER&'\'
                  DISKETE=TRUE
               .
               DISKS=''
            .
            LocalResponse = RequestCompleted
            IZVELETO=TRUE
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
   UNHIDE(?KONT_SK)
   DISPLAY

   ANSIFILENAME=DISKS&'EXP'&FORMAT(TODAY(),@D11)&'.TXT'
   REMOVE(OUTFILEANSI)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME1)
      DO PROCEDURERETURN
   .
   CHECKOPEN(OUTFILEANSI,1)
   CHECKOPEN(GGK,1)

   IF IZVELETO=FALSE
      CLEAR(GGK:RECORD)
      GGK:DATUMS=SAK_DAT
      SET(GGK:DAT_KEY,GGK:DAT_KEY)
   ELSE
      GGK_BKK=''
      GGK_D_K=''
      DISPLAY
      GGK:U_NR=GG:U_NR
      GET(GGK,GGK:NR_KEY)
   .
   LOOP
      IF IZVELETO=FALSE
         NEXT(GGK)
         IF ERROR() OR GGK:DATUMS > BEI_DAT THEN BREAK.
         IF GGK_BKK AND ~(GGK:BKK=GGK_BKK) THEN CYCLE.
         IF GGK_D_K AND ~(GGK:D_K=GGK_D_K) THEN CYCLE.
         IF LAST_U_NR=GGK:U_NR THEN CYCLE. !LAI VIENU DOKUMENTU NERAKSTA VAIRÂKAS REIZES
         LAST_U_NR=GGK:U_NR
         I#=GETGG(GGK:U_NR)
      .
      OUTA:LINE='01:'&FORMAT(GGK:DATUMS,@D06.)
      ADD(OUTFILEANSI)
      OUTA:LINE='02:'&GG:DOK_SENR
      ADD(OUTFILEANSI)
      OUTA:LINE='03:'&FORMAT(GG:APMDAT,@D06.)
      ADD(OUTFILEANSI)
      OUTA:LINE='04:'&GG:ATT_DOK
      ADD(OUTFILEANSI)
      OUTA:LINE='05:'&GGK:PAR_NR
      ADD(OUTFILEANSI)
      OUTA:LINE='06:'&GETPAR_K(GGK:PAR_NR,0,12)
      ADD(OUTFILEANSI)
      OUTA:LINE='07:'&GG:Noka
      ADD(OUTFILEANSI)
      OUTA:LINE='08:'&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
      ADD(OUTFILEANSI)
      OUTA:LINE='09:'&GGK:VAL
      ADD(OUTFILEANSI)
      SAV_POSITION=POSITION(GGK:DAT_KEY)
      CLEAR(GGK:RECORD)
      GGK:U_NR=GG:U_NR
      SET(GGK:NR_KEY,GGK:NR_KEY)
      LOOP                   
         NEXT(GGK)
         IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
         OUTA:LINE='10:'&GGK:D_K&' '&GGK:Bkk&' '&FORMAT(GGK:Pvn_proc,@N02)&' '&|
         GGK:NODALA&' '&FORMAT(GGK:KK,@N1B)&' '&FORMAT(GGK:SUMMAV,@N_11.2)&' '&GGK:Reference
         KONT_SK+=1
         DISPLAY
         ADD(OUTFILEANSI)
      .
      reset(ggk:DAT_KEY,SAV_POSITION)
      NEXT(GGK)
      DOK_SK+=1
      DISPLAY
      GG:KEKSIS=2  !STATUSS::NOEXPORTÇTS
      IF RIUPDATE:GG()
         KLUDA(24,'GG')
      .
      IF IZVELETO=TRUE
         BREAK
      .
   .
   IF DISKETE=TRUE   !FLAÐS
      UNHIDE(?STRINGDISKETE)
      DISPLAY
      CLOSE(OUTFILEANSI)
      FILENAME1=ANSIFILENAME
      FILENAME2='E:\EXP'&FORMAT(TODAY(),@D11)&'.TXT'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
   .
   CLOSE(TOSCREEN)
 OF 2 !****************************LASÎT************************************
   FILENAME1=CLIP(LONGPATH())&'\GGTX.TPS'      !IMPORTA INTERFEISA VÂRDS
   FILENAME2=CLIP(LONGPATH())&'\GGKTX.TPS'
   NOTFIRST#=FALSE
   REMOVE(G1)
   CHECKOPEN(G1,1)
   CLOSE(G1)
   OPEN(G1,18)
!   EMPTY(G1)
   REMOVE(GK1)
   CHECKOPEN(GK1,1)
   CLOSE(GK1)
   OPEN(GK1,18)
!   EMPTY(GK1)

   IF PAR_K::USED=0
      CHECKOPEN(PAR_K,1)
   .
   PAR_K::USED+=1
   TTAKA"=LONGPATH()
   IF FILEDIALOG('...TIKAI IMP*.TXT FAILI !!!',ANSIFILENAME,'TXT|IMP*.txt',0)
      SETPATH(TTAKA")
      IF ANSIFILENAME[1]='A'
         LOOP I#=LEN(ANSIFILENAME)-1 TO 1 BY -1
            IF ANSIFILENAME[I#]='\'
               FAILS=ANSIFILENAME[I#+1:LEN(ANSIFILENAME)]
               FOUND#=1
               BREAK
            .
         .
         USERFOLDER=USERFOLDER&'\'
         COPY(OUTFILEANSI,USERFOLDER)
         IF ERROR()
            KLUDA(3,ANSIFILENAME&' no A:\ '&error())
            DO PROCEDURERETURN
         .
         ANSIFILENAME=USERFOLDER&FAILS
      .
      OPEN(ReadScreen)
      OPEN(OUTFILEANSI)
      IF ERROR()
         KLUDA(0,'Kïûda atverot '&CLIP(ANSIFILENAME)&' '&ERROR())
         DO PROCEDURERETURN
      .
      SET(OUTFILEANSI)
      LOOP
        NEXT(OUTFILEANSI)
        IF ERROR() THEN BREAK.
        NPK#+=1
        DARBIBA='Lasu '&CLIP(ANSIFILENAME)&' rinda '&NPK#
        DISPLAY

!01:dd.mm.yyyy   -DOK.DATUMS -obligâts
!02:S14        -NUMURS(14 BURTI/CIPARI)
!03:dd.mm.yyyy -APMAKSÂT LÎDZ
!04:S1         -DOKUMENTA TIPS SASKAÒÂ AR VID KLASIF.(P/Z-2 Rçíins-6)
!05:N9         -PARTNERA IEKÐÇJAIS NR WINLATA SISTÇMÂ
!06:S37        -PARTNERA UR/REÌ. NUMURS(JA NAV ZINÂMS 05:) !06.04.08, BIJA N11
!07:S15        -PARTNERA NOSAUKUMS(PAPILDUS KONTROLEI)
!08:S135       -DOKUMENTA NOSAUKUMS
!09:S3         -VALÛTA
!10:S1,S5,N2,S2,N1,N11.2,S3,S21,S14 -DEB/KRE,KONTS,PVN%,NODAÏA,KONTU KORESPODENCES ATZÎME(0-8),SUMMA,VALÛTA,REÌ.NR,REFERENCE -(ÐITÂ RINDA VAR ATKÂRTOTIES NEIEROBEÞOTI)

        CASE OUTA:LINE[1:3]
        OF '01:'
           IF NOTFIRST#=TRUE THEN PUT(G1).
           DO AUTONUMBER
           DOK_SK+=1
           NOTFIRST#=TRUE
           G1:DOKDAT=DEFORMAT(OUTA:LINE[4:13],@D06.)
           DARBIBA='Rakstu GG '
           DISPLAY
        OF '02:'
!           G1:DOK_SENR=OUTA:LINE[4:17]
           G1:DOK_SENR=OUTA:LINE[4:LEN(CLIP(OUTA:LINE))]
        OF '03:'
           G1:APMDAT=DEFORMAT(OUTA:LINE[4:13],@D06.)
        OF '04:'
           G1:ATT_DOK=OUTA:LINE[4:5]
        OF '05:'
           PAR:U_NR=OUTA:LINE[4:12]
           IF PAR:U_NR
              GET(PAR_K,PAR:NR_KEY)
              IF ~ERROR()
                 G1:PAR_NR=PAR:U_NR
                 G1:Noka  =PAR:NOS_S
              ELSE
                 KLUDA(0,'WinLata DB nav atrodams Partneris ar U_Nr:'&OUTA:LINE[4:12]&' dokumentam Nr '&G1:DOK_SENR)
                 G1:PAR_NR=0
              .
           .
        OF '06:'
           CLEAR(PAR:RECORD)
           GET(PAR_K,0)
           PAR:NMR_KODS=OUTA:LINE[4:LEN(CLIP(OUTA:LINE))]  !11-22 zîmes
!           STOP(PAR:NMR_KODS)
           IF PAR:NMR_KODS
              GET(PAR_K,PAR:NMR_KEY)
              IF ~ERROR()
                 G1:Par_nr=PAR:U_NR
                 G1:Noka  =PAR:NOS_S
              ELSE
                 KLUDA(0,'WinLata DB nav atrodams Partneris ar NMR Nr:'&OUTA:LINE[4:LEN(CLIP(OUTA:LINE))]&|
                 ' dokumentam Nr '&G1:DOK_SENR)
                 G1:PAR_NR=0
                 G1:Noka  =''
              .
           .
        OF '07:'
!           IF ~G1:Noka THEN G1:Noka= OUTA:LINE[4:18]. !NOS_S
           IF ~G1:Noka THEN G1:Noka= OUTA:LINE[4:LEN(CLIP(OUTA:LINE))]. !NOS_S
!            PAR:NOS_P=INIGEN(PAR:NOS_P,LEN(CLIP(PAR:NOS_P)),3)
        OF '08:'
           G1:SATURS= OUTA:LINE[4:48]
!           G1:SATURS= INIGEN(OUTA:LINE[4:48],45,5)
           G1:SATURS2=OUTA:LINE[49:94]
!            PAR:NOS_P=INIGEN(PAR:NOS_P,LEN(CLIP(PAR:NOS_P)),3)
           G1:SATURS3=OUTA:LINE[95:140]
!            PAR:NOS_P=INIGEN(PAR:NOS_P,LEN(CLIP(PAR:NOS_P)),3)
        OF '09:'
           G1:VAL=OUTA:LINE[4:6]
           IF ~G1:VAL THEN G1:VAL=VAL_LV.
        OF '10:'
           CLEAR(GK1:RECORD)
           GK1:U_nr      = G1:U_NR
           GK1:Rs        = ''
           GK1:Datums    = G1:datums
           GK1:Par_nr    = G1:par_nr
           GK1:D_k       = OUTA:LINE[4]
           GK1:Bkk       = OUTA:LINE[6:10]
           GK1:Pvn_proc  = OUTA:LINE[12:13]
           GK1:Pvn_tips  = '0'
           GK1:NODALA    = OUTA:LINE[15:16]
           B# = OUTA:LINE[18]
           IF INRANGE(B#,1,8)
              GK1:KK     = 2^(B#-1)
           .
           GK1:SummaV    = OUTA:LINE[20:30]
           IF ~(CL_NR=1660) 
              GK1:Val       = G1:VAL
           ELSE !INVEST-RIGA
              GK1:Val       = OUTA:LINE[32:34]
              IF ~G1:VAL THEN G1:VAL=GK1:VAL.
              CLEAR(PAR:RECORD)
              PAR:NMR_KODS=OUTA:LINE[36:56]
              GET(PAR_K,PAR:NMR_KEY)
              IF ~ERROR()
                 GK1:Par_nr=PAR:U_NR
                 IF ~G1:Par_nr
                     G1:PAR_NR=PAR:U_NR
                     G1:Noka  =PAR:NOS_S
                 .
              ELSE
                 KLUDA(0,'WinLata DB nav atrodams Partneris ar NMR Nr:'&OUTA:LINE[36:56]&' dok.Nr '&|
                 CLIP(G1:DOK_SENR)&' Konts:'&GK1:Bkk)
                 G1:PAR_NR=0
                 G1:Noka  =''
                 GK1:PAR_NR=0
              .
           .
           GK1:Reference = OUTA:LINE[58:71]
           GK1:Summa     = GK1:SummaV*BANKURS(GK1:VAL,GK1:DATUMS,' Dokuments:'&G1:DOK_SENR)
           GK1:BAITS     = 0 ! IEZAKS
           GK1:OBJ_NR    = 0
           IF GK1:D_K='D'
              G1:SUMMA+=GK1:SUMMAV
           .
           ADD(GK1)
           KONT_SK+=1
        .
      .
      PUT(G1)
   .
   CLOSE(ReadScreen)
   CLOSE(GK1)
   CLOSE(G1)
   PAR_K::USED-=1
   IF PAR_K::USED=0
      CLOSE(PAR_K)
   .
 .
 DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO G1
  Auto::Attempts = 0
  LOOP
    SET(G1:NR_KEY)
    PREVIOUS(G1)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'G1')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:G1:U_NR = 2
    ELSE
      Auto::Save:G1:U_NR = G1:U_NR + 1
    END
    clear(G1:Record)
    G1:DATUMS=DEFORMAT(OUTA:LINE[4:13],@D06.)
    G1:U_NR = Auto::Save:G1:U_NR
    ADD(G1)
!    STOP('R')
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
   CLOSE(OUTFILEANSI)
   KLUDA(0,'KOPÂ: '&clip(DOK_SK)&' dokumenti '&clip(kont_sk)&' kontçjumi',,1)
   IF ~DOK_SK
      GLOBALRESPONSE=REQUESTCANCELLED
   ELSE
      GLOBALRESPONSE=REQUESTCOMPLETED
   .
   RETURN

A_IzzinaparDA        PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
FilesOpened          LONG

RPT_DATUMS           STRING(35)
IzzinaNR             STRING(14)
Registracija         STRING(50)
BankasRekviziti      STRING(70)
TEXmenesis           STRING(30)
M0                   DECIMAL(10,2)
M1                   DECIMAL(10,2)
M2                   DECIMAL(10,2)
M3                   DECIMAL(10,2)
M4                   DECIMAL(10,2)
ASummamenesi         DECIMAL(10,2)
ASummaKopa           DECIMAL(10,2)
Summamenesi          DECIMAL(10,2)
SummaKopa            DECIMAL(10,2)
VUT                  STRING(55)
IESNIEGSANAI         STRING(45)
VINA                 STRING(4)
VINAS                STRING(5)
SLODZE               STRING(14)

TEX1                 STRING(90)
TEX2                 STRING(90)
TEX3                 STRING(90)
TEX4                 STRING(90)
TEX5                 STRING(80)

!-----------------------------------------------------------------------------
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:YYYYMM)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_STUNDAS)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                     END


Report REPORT,AT(500,500,7990,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,3156),USE(?unnamed:3)
         LINE,AT(52,156,7865,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s45),AT(2396,208,3125,156),USE(client,,?CLIENT:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('IZZIÒA'),AT(5802,260,1510,521),USE(?StringIZZINA),CENTER,FONT(,28,COLOR:Silver,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2396,354,3333,156),USE(gl:adrese),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(3094,479,2500,156),USE(sys:adrese,,?sys:adrese:2),FONT(,8,,,CHARSET:BALTIC)
         STRING('Pasta adrese:'),AT(2396,479,677,156),USE(?String66:2),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,979,7865,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(' Nr'),AT(6063,1250),USE(?String60:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(6323,1250),USE(IzzinaNr),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(365,1250),USE(rpt_datums),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(948,1927,6615,156),USE(TEX1),TRN
         STRING(@s90),AT(948,2115,6615,156),USE(TEX2),TRN
         STRING(@s90),AT(948,2292,6615,156),USE(TEX3),TRN
         LINE,AT(63,2854,7865,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Periods'),AT(1135,2885),USE(?String50),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa  pçc nodokïiem'),AT(5927,2885),USE(?String52:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçíinâts'),AT(4979,2885),USE(?String52),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,3125,7865,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING(@s50),AT(2396,625,3229,156),USE(Registracija,,?REGISTRACIJA:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(2396,781,4844,156),USE(BankasRekviziti),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,344),USE(?unnamed:9)
         STRING(@s50),AT(1135,94,3698,156),USE(TEXmenesis)
         STRING(@n-_10.2B),AT(6354,94,781,208),USE(Summamenesi),RIGHT(5)
         STRING(@n-_10.2B),AT(4896,104,781,208),USE(ASummamenesi),TRN,RIGHT(5)
       END
FOOTER DETAIL,AT(,,,1781),USE(?unnamed:2)
         LINE,AT(21,31,7865,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(21,333,7865,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(1135,104,417,208),USE(?String53),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_11.2),AT(6354,104,781,208),USE(SummaKopa,,?SummaKopa:2),RIGHT
         STRING(@n-_11.2),AT(4896,104,781,208),USE(ASummaKopa),TRN,RIGHT
         STRING(@s80),AT(1250,521,6042,156),USE(TEX5),TRN,CENTER
         STRING('_{18}'),AT(4375,1417),USE(?String28:2)
         STRING(@s25),AT(5708,1417),USE(sys:paraksts2),LEFT
         STRING(@s25),AT(2458,1427,1896,208),USE(sys:amats2),RIGHT(1)
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

window WINDOW('Izziòas sagavoðana'),AT(,,321,93),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),CENTER, |
         GRAY
       ENTRY(@s35),AT(61,7,133,10),USE(rpt_datums,,?rpt_datums:1)
       STRING('Izziòa Nr'),AT(4,21),USE(?String3)
       ENTRY(@s14),AT(61,19,76,10),USE(IzzinaNr,,?izzinanr:1)
       STRING('Izsniegta (kam?)'),AT(4,32),USE(?String1)
       ENTRY(@s55),AT(61,31,253,10),USE(vut)
       STRING('Iesniegðanai'),AT(4,46),USE(?String2)
       ENTRY(@s45),AT(61,45,253,10),USE(IESNIEGSANAI)
       BUTTON('D&rukas parametri'),AT(239,59,79,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       OPTION('Izdrukas &Formâts'),AT(61,60,121,24),USE(F:DBF),BOXED,HIDE
         RADIO('WMF'),AT(65,70,30,10),USE(?F:DBF:WMF)
         RADIO('Word'),AT(96,70),USE(?F:DBF:A),VALUE('A')
         RADIO('Excel'),AT(131,70),USE(?F:DBF:Excel),VALUE('E')
       END
       BUTTON('&OK'),AT(240,76,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(283,76,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  RPT_DATUMS=YEAR(TODAY())&'. gada '&DAY(TODAY())&'. '&MENVAR(TODAY(),2,2)&' , Rîga'
  VUT=CLIP(GETKADRI(ID,2,13))&' (personas kods '&GETKADRI(ID,2,14)&')'
  IF GETKADRI(ID,2,8)='S'
     VINA ='viòa'
     VINAS='viòas'
  ELSE
     VINA ='viòð'
     VINAS='viòa'
  .
  OPEN(window)
  DISPLAY()
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY()
    OF EVENT:GainFocus
      DISPLAY()
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCompleted
        BREAK
      .
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO PROCEDURERETURN
      .
    END
  END
  CLOSE(WINDOW)

  F:DBF='W'   !WMF-pagaidâm, arî beigâs

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  checkopen(system,1)
  CHECKOPEN(GLOBAL,1)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izziòa par DA'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:ID=ID
      ALG:YYYYMM=DATE(MONTH(ALP:YYYYMM)+7,1,YEAR(ALP:YYYYMM)-1)  !LAI DABÛTU 6 MÇNEÐUS ATPAKAÏ
!      STOP(FORMAT(ALG:YYYYMM,@D6)&' '&alg:ID)
      SET(ALG:ID_DAT,ALG:ID_DAT)
      Process:View{Prop:Filter} =''
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

      GetMyBank('')
      BankasRekviziti=REK[1:4]&' '&REK[5:8]&' '&REK[9:12]&' '&REK[13:16]&' '&REK[17:20]&' '&REK[21:LEN(CLIP(REK))]&' '&clip(banka)&',  kods '&bkods
      Registracija='NMR '&GL:REG_NR&' PVN '&GL:VID_NR

      IF GETKADRI(ID,2,19,kad:piesklist[1])<1 THEN SLODZE='uz 1/2 slodzi'.
      TEKSTS=' Dotâ izziòa izsniegta '&CLIP(VUT)&' par to,ka '&VINA&' strâdâ '& clip(client) &' kopð '&|
      FORMAT(GETKADRI(ID,2,12),@D06.)&' , ðobrîd ieòemamais amats ir '&CLIP(GETKADRI(ID,2,11))&' '&CLIP(slodze)&','&|
      CLIP(VINAS)&' darba lîgums nav pârtraukts un darba alga ir sekojoða :'
      FORMAT_TEKSTS(135,'Arial',10,'')
      TEX1=F_TEKSTS[1]
      TEX2=F_TEKSTS[2]
      TEX3=F_TEKSTS[3]

      IF F:DBF='W'   !WMF
        OPEN(report)
        SETTARGET(REPORT)
        IMAGE(188,281,2083,521,'USER.BMP')
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:HEADER)
      ELSE           !EXCEL
        IF ~OPENANSI('IZZINADA.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='IZZIÒA PAR DARBA ALGU'
        ADD(OUTFILEANSI)
        OUTA:LINE='Nr'
        ADD(OUTFILEANSI)
        OUTA:LINE=RPT_DATUMS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=TEX1
        ADD(OUTFILEANSI)
        OUTA:LINE=TEX2
        ADD(OUTFILEANSI)
        OUTA:LINE=TEX3
        ADD(OUTFILEANSI)
        OUTA:LINE=TEX4
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES

        IF ALG:YYYYMM <= ALP:YYYYMM
           TEXmenesis=YEAR(ALG:YYYYMM)&'. gada '&MENVAR(ALG:YYYYMM,2,2)
!        stop(texmenesis)
           M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
           M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ
           M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ
           M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
           M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
           ASUMMAMENESI=M0+M1+M2+M3+M4
           ASUMMAKOPA +=ASUMMAMENESI
           SUMMAMENESI =ASUMMAMENESI-SUM(5)-SUM(6) !NODOKÏI,DN SOCAPD
           SUMMAKOPA  +=SUMMAMENESI
           print(rpt:detail)
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
        CLOSE(ProgressWindow)
        BREAK
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

  IF LocalResponse = RequestCompleted
    CLOSE(ProgressWindow)
    F:DBF='W'   !WMF-pagaidâm, arî sâkumâ
    IF F:DBF='W'   !WMF
       TEX5='Izziòa paredzçta iesniegðanai '&IESNIEGSANAI
       PRINT(RPT:FOOTER)
       ENDPAGE(Report)
       PR:SKAITS=1
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
!      STOP(FORMAT(ALG:YYYYMM,@D6)&' '&alg:ID)
  IF ERRORCODE() OR ~(ALG:ID=ID)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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

ReferFixGGIESK PROCEDURE 


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
local_path           STRING(40)
records_open_all     STRING(25)
dat1_key_nr          LONG
summa_ggkk           DECIMAL(11,2)
summa_ggkkD          DECIMAL(11,2)
summa_ggkkK          DECIMAL(11,2)
summa_s              DECIMAL(11,2)
summa_sk             DECIMAL(11,2)
summa_skD            DECIMAL(11,2)
summa_skK            DECIMAL(11,2)
parads_s             DECIMAL(11,2)
summa_t              DECIMAL(11,2)
summa_tk             DECIMAL(11,2)
summa_tkD            DECIMAL(11,2)
summa_tkK            DECIMAL(11,2)
summa_totD           DECIMAL(11,2)
summa_totK           DECIMAL(11,2)
summa_bezRD          DECIMAL(11,2)
summa_bezRk          DECIMAL(11,2)
i_d_k                STRING(1)
DOK_NR               STRING(14)
GG_APMDAT            LONG
F:NESAMAKSATAS       STRING(1)
SAVE_POSITION   STRING(256)
SAV_POSITION    STRING(260)
GG_RECORD       LIKE(GG:RECORD)
gg_datums_NEW   LIKE(GG:DATUMS)  !GRÂMATOJUMA DATUMS

BRW1::View:Browse    VIEW(GGK)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:VAL)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:U_NR)
                       JOIN(GG:NR_KEY,GGK:U_NR)
                         PROJECT(GG:KEKSIS)
                         PROJECT(GG:RS)
                         PROJECT(GG:DOKDAT)
                         PROJECT(GG:APMDAT)
                         PROJECT(GG:SATURS)
                         PROJECT(GG:U_NR)
                       END
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::GG:KEKSIS        LIKE(GG:KEKSIS)            ! Queue Display field
BRW1::GG:RS            LIKE(GG:RS)                ! Queue Display field
BRW1::DOK_NR           LIKE(DOK_NR)               ! Queue Display field
BRW1::GG:DOKDAT        LIKE(GG:DOKDAT)            ! Queue Display field
BRW1::GG_APMDAT        LIKE(GG_APMDAT)            ! Queue Display field
BRW1::GG:SATURS        LIKE(GG:SATURS)            ! Queue Display field
BRW1::GGK:D_K          LIKE(GGK:D_K)              ! Queue Display field
BRW1::GGK:SUMMAV       LIKE(GGK:SUMMAV)           ! Queue Display field
BRW1::GGK:VAL          LIKE(GGK:VAL)              ! Queue Display field
BRW1::summa_s          LIKE(summa_s)              ! Queue Display field
BRW1::summa_t          LIKE(summa_t)              ! Queue Display field
BRW1::KKK              LIKE(KKK)                  ! Queue Display field
BRW1::i_d_k            LIKE(i_d_k)                ! Queue Display field
BRW1::ATLAUTS          LIKE(ATLAUTS)              ! Queue Display field
BRW1::GGK:PAR_NR       LIKE(GGK:PAR_NR)           ! Queue Display field
BRW1::GGK:DATUMS       LIKE(GGK:DATUMS)           ! Queue Display field
BRW1::GGK:U_NR         LIKE(GGK:U_NR)             ! Queue Display field
BRW1::GG:U_NR          LIKE(GG:U_NR)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(GGK:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(GGK:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(GGK:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR_NR LIKE(PAR_NR)
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
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
WinResize            WindowResizeType
QuickWindow          WINDOW(' '),AT(0,0,449,283),FONT('MS Sans Serif',9,,FONT:bold),IMM,VSCROLL,HLP(' '),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(5,18,438,213),USE(?Browse:1),IMM,VSCROLL,FONT(,9,,),MSG('Browsing Records'),FORMAT('10C|M~X~@n1B@10C|M~Y~@n1@28R(1)|M~Dok Nr~C(0)@S14@44C|M~Dok.Datums~@d06.@44C|M~J' &|
   'âmaksâ~@D06.@125L(1)|M~Dokumenta saturs~C(0)@s45@10C|M@s1@45D(12)|M~Summa~C(0)@n' &|
   '-15.2@17L(1)|M~Val.~C(0)@s3@45D(12)|M~Iepriekð~C(0)@n-15.2@60D(12)|M~Tagad~C(0)@' &|
   'n-15.2@'),FROM(Queue:Browse:1)
                       SHEET,AT(1,-1,447,284),USE(?CurrentTab)
                         TAB('Atrastie Debitoru/Kreditoru dokumenti'),USE(?Tab:2)
                           BUTTON('&Noòemt iesk.'),AT(80,233,56,15),USE(?NonApm)
                           BUTTON('&Fiksçt iesk.'),AT(24,233,54,15),USE(?FixApm)
                           BUTTON('&X'),AT(6,233,12,15),USE(?KeksisX)
                           STRING(@n-15.2),AT(383,235,57,10),USE(summa_tk),RIGHT(1),FONT(,,,FONT:bold)
                           STRING('Debets:'),AT(231,244),USE(?String4:4)
                           STRING(@n-15.2),AT(259,244),USE(summa_ggkkD),RIGHT(1)
                           STRING(@n-15.2),AT(322,235),USE(summa_sk),RIGHT(1)
                           STRING('Bilance :'),AT(231,235),USE(?String4:2)
                           STRING(@n-15.2),AT(259,235),USE(summa_ggkk),RIGHT(1)
                           BUTTON('Fiksçt &savâdâku summu'),AT(138,233,84,15),USE(?FixSavApm)
                           BUTTON('&OK Akceptçt'),AT(119,250,51,15),USE(?OKAkceptet),DEFAULT
                           BUTTON('&Atteikties'),AT(172,250,50,15),USE(?Cancel)
                           STRING(@n-15.2),AT(322,244),USE(summa_skD),RIGHT(1)
                           STRING(@n-15.2),AT(322,253),USE(summa_skK),RIGHT(1)
                           STRING(@n-15.2),AT(383,253,57,10),USE(summa_tkK),RIGHT(1),FONT(,,,FONT:bold)
                           STRING('Kredîts:'),AT(232,253),USE(?String4:5)
                           STRING(@n-15.2),AT(259,253),USE(summa_ggkkK),RIGHT(1)
                           STRING('Atrastas apm. bez Ref.(K) :'),AT(226,271),USE(?String4:3)
                           STRING(@n-15.2B),AT(322,271),USE(summa_bezRD,,?summa_bezRK),RIGHT(1),FONT(,,COLOR:Red,,CHARSET:ANSI)
                           STRING('Atrastas apm. bez Ref.(D) :'),AT(226,262),USE(?String4)
                           STRING(@n-15.2B),AT(322,262),USE(summa_bezRD),RIGHT(1),FONT(,,COLOR:Red,,CHARSET:ANSI)
                           BUTTON('&Tikai nesamaksâtâs'),AT(19,250,73,15),USE(?ButtonFNesam)
                           IMAGE('CHECK2.ICO'),AT(95,249,17,18),USE(?ImageFNES),HIDE
                           STRING(@n-15.2),AT(383,244,57,10),USE(summa_tkD),RIGHT(1),FONT(,,,FONT:bold)
                         END
                       END
                     END
  CODE
  PUSHBIND
  BIND('CycleApmaksa',CycleApmaksa)
  BIND('F:NESAMAKSATAS',F:NESAMAKSATAS)
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(SYSTEM,1)
  SAVE_POSITION=POSITION(GG)
  GG_RECORD=GG:RECORD
  SAV_DATUMS=GG:DATUMS
  GG_DATUMS_NEW=GG:DATUMS
  IF D_K='D'
     I_D_K='K'
  ELSIF D_K='K'
     I_D_K='D'
  ELSE
     STOP('D_K='&D_K)
  .
  IF ATLAUTS[18]='1'  !AIZLIEGTI NEAPSTIPRINÂTIE
     RS='A'
  ELSE
     RS='V'
  .
  SUMMA_TOTD=PerfAtable(1,0,'',RS,PAR_NR,'',0,0,'',0) ! Uzbûvç apmaksu A-table,atgrieþ total_apm summu,arî bez references
  SUMMA_TOTK=SUMMA
  SUMMA=0
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  quickwindow{prop:text}='Norçíini ar: '&CLIP(gg:noka)&' Konti: 231..,531..'
  
  ACCEPT
    IF summa_tk
       DISABLE(?OKAkceptet)
    ELSE
       ENABLE(?OKAkceptet)
    .
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
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
    OF ?NonApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO SyncWindow
        SUMMA=0
        val_nos=''
        I#=PerfAtable(5,DOK_NR,GGK:BKK,'',PAR_NR,'',0,0,'',0)  !5-noòemt apmaksu
        !DO BRW1::InitializeBrowse
        IF GGK:D_K='D'
           summa_tk-=summa_t
           summa_tkD-=SUMMA_T
        ELSE
           summa_tk+=summa_t
           summa_tkK-=SUMMA_T
        .
        IF summa_tk
           DISABLE(?OKAkceptet)
        ELSE
           ENABLE(?OKAkceptet)
        .
        DO BRW1::RefreshPage
        SELECT(?Browse:1)
        DISPLAY
        
      END
    OF ?FixApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO SyncWindow
        SUMMA=GGK:SUMMAV
        val_nos=GGK:VAL
        I#=PerfAtable(4,DOK_NR,GGK:BKK,'',PAR_NR,GGK:NODALA,GGK:OBJ_NR,GGK:U_NR,'',GGK:PVN_PROC)
        
        IF GGK:D_K='D'
           summa_tk+=SUMMA
           summa_tkD+=SUMMA
        ELSE
           summa_tk-=SUMMA
           summa_tkK+=SUMMA
        .
        IF summa_tk
           DISABLE(?OKAkceptet)
        ELSE
           ENABLE(?OKAkceptet)
        .
        DO BRW1::RefreshPage
        SELECT(?Browse:1)
        DISPLAY
      END
    OF ?KeksisX
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        EXECUTE GG:KEKSIS+1
           gg:keksis=1
           GG:KEKSIS=2
           GG:KEKSIS=0
        .
        IF RIUPDATE:GG()
           KLUDA(24,'GG')
        .
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
      END
    OF ?FixSavApm
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO SyncWindow
        SUMMA=GGK:SUMMAV-SUMMA_S
        val_nos=GGK:VAL
        I#=PerfAtable(6,DOK_NR,GGK:BKK,'',PAR_NR,GGK:NODALA,GGK:OBJ_NR,GGK:U_NR,'',GGK:PVN_PROC) !IZSAUC SUMMA_W
        IF SUMMA
           IF GGK:D_K='D'
              summa_tk-=SUMMA_T
              summa_tk+=SUMMA
              summa_tkD-=SUMMA_T
              summa_tkD+=SUMMA
           ELSE
              summa_tk+=SUMMA_T
              summa_tk-=SUMMA
              summa_tkK-=SUMMA_T
              summa_tkK+=SUMMA
           .
           IF summa_tk
              DISABLE(?OKAkceptet)
           ELSE
              ENABLE(?OKAkceptet)
           .
        .
        DO BRW1::RefreshPage
        SELECT(?Browse:1)
        DISPLAY
        
      END
    OF ?OKAkceptet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        localresponse=requestcompleted
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?ButtonFNesam
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:NESAMAKSATAS  !TIKAI NESAMAKSÂTÂS
           F:NESAMAKSATAS=''
           HIDE(?IMAGEFNES)
        ELSE
           F:NESAMAKSATAS='1'
           UNHIDE(?IMAGEFNES)
        .
        DO BRW1::InitializeBrowse
        DO BRW1::RefreshPage
        SELECT(?Browse:1)
        DISPLAY
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('ReferFixGGIESK','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('KKK',KKK)
  BIND('i_d_k',i_d_k)
  BIND('ATLAUTS',ATLAUTS)
  BIND('PAR_NR',PAR_NR)
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
    RESET(GG,SAVE_POSITION)
    NEXT(GG)
    GG:RECORD=GG_RECORD
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('ReferFixGGIESK','winlats.INI')
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
  IF SEND(GGK,'QUICKSCAN=on').
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  summa_tk=0
  summa_sk=0
  summa_tkD=0
  summa_skD=0
  summa_tkK=0
  summa_skK=0
  summa_ggkk=0
  summa_ggkkD=0
  summa_ggkkK=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'GGK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    IF GGK:D_K='D'
       summa_tk+=summa_t
       summa_sk+=summa_s
       summa_tkD+=summa_t
       summa_skD+=summa_s
       summa_ggkk+=ggk:summaV
       summa_ggkkD+=ggk:summaV
    ELSE
       summa_tk-=summa_t
       summa_sk-=summa_s
       summa_tkK+=summa_t
       summa_skK+=summa_s
       summa_ggkk-=ggk:summaV
       summa_ggkkK+=ggk:summaV
    .
  END
  IF F:NeSAMAKSATAS
     summa_bezRD=0     !to kas ir bez references , zaudçjam
     summa_bezRK=0     !to kas ir bez references , zaudçjam
  ELSE
     summa_bezRD=summa_totD-summa_skD
     summa_bezRK=summa_totK-summa_skK
  .
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = GGK:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'GGK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = GGK:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(GGK,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  GG:KEKSIS = BRW1::GG:KEKSIS
  GG:RS = BRW1::GG:RS
  DOK_NR = BRW1::DOK_NR
  GG:DOKDAT = BRW1::GG:DOKDAT
  GG_APMDAT = BRW1::GG_APMDAT
  GG:SATURS = BRW1::GG:SATURS
  GGK:D_K = BRW1::GGK:D_K
  GGK:SUMMAV = BRW1::GGK:SUMMAV
  GGK:VAL = BRW1::GGK:VAL
  summa_s = BRW1::summa_s
  summa_t = BRW1::summa_t
  KKK = BRW1::KKK
  i_d_k = BRW1::i_d_k
  ATLAUTS = BRW1::ATLAUTS
  GGK:PAR_NR = BRW1::GGK:PAR_NR
  GGK:DATUMS = BRW1::GGK:DATUMS
  GGK:U_NR = BRW1::GGK:U_NR
  GG:U_NR = BRW1::GG:U_NR
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
  IF GGK:U_NR=1
     DOK_NR=GGK:REFERENCE
     GG_APMDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1)
  ELSE
     DOK_NR=GG:DOK_SENR
     GG_APMDAT=GG:APMDAT
  .
  IF ~DOK_NR
     KLUDA(0,FORMAT(GG:DATUMS,@D06.)&' dokumentam U_NR='&GG:U_NR&' nav Dok. Numura')
     DO PROCEDURERETURN
  .
  SUMMA_S=PerfAtable(2,DOK_NR,' ',RS,PAR_NR,'',0,0,'',0)
  IF GGK:U_NR=1 AND SUMMA_S<GGK:SUMMA !ÐITAIS FORMATS TIEK SAUKTS n-KÂRTÎGI
     IF ~SAV_POSITION THEN SAV_POSITION=POSITION(GGK).
     IF POSITION(GGK)=SAV_POSITION
        SUMMA_S+=BILANCE
     .
  .
  SUMMA_T=PerfAtable(3,DOK_NR,' ',RS,PAR_NR,'',0,0,'',0)
  
  BRW1::GG:KEKSIS = GG:KEKSIS
  BRW1::GG:RS = GG:RS
  BRW1::DOK_NR = DOK_NR
  BRW1::GG:DOKDAT = GG:DOKDAT
  BRW1::GG_APMDAT = GG_APMDAT
  BRW1::GG:SATURS = GG:SATURS
  BRW1::GGK:D_K = GGK:D_K
  BRW1::GGK:SUMMAV = GGK:SUMMAV
  BRW1::GGK:VAL = GGK:VAL
  BRW1::summa_s = summa_s
  BRW1::summa_t = summa_t
  BRW1::KKK = KKK
  BRW1::i_d_k = i_d_k
  BRW1::ATLAUTS = ATLAUTS
  BRW1::GGK:PAR_NR = GGK:PAR_NR
  BRW1::GGK:DATUMS = GGK:DATUMS
  BRW1::GGK:U_NR = GGK:U_NR
  BRW1::GG:U_NR = GG:U_NR
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
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
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
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => GGK:DATUMS
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
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
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
      GGK:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
  IF BRW1::ItemsToFill > 1
    IF SEND(GGK,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
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
        StandardWarning(Warn:RecordFetchError,'GGK')
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
  IF BRW1::QuickScan
    IF SEND(GGK,'QUICKSCAN=off').
    BRW1::QuickScan = False
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
      BRW1::HighlightedPosition = POSITION(GGK:PARDAT_KEY)
      RESET(GGK:PARDAT_KEY,BRW1::HighlightedPosition)
    ELSE
      GGK:PAR_NR = PAR_NR
      SET(GGK:PARDAT_KEY,GGK:PARDAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'GGK:PAR_NR = PAR_NR AND (((ggk:bkk[1:3]=''231'' AND ggk:d_k=''D'') OR ( GG' & |
    'K:BKK[1:3]=''531'' and ggk:d_k=''K'' )) AND ~CycleApmaksa(F:NESAMAKSATAS) ' & |
    'and ~(GGK:RS=''1''  AND  ATLAUTS[18]=''1''))'
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
  ELSE
    CLEAR(GGK:Record)
    BRW1::CurrentChoice = 0
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
    GGK:PAR_NR = PAR_NR
    SET(GGK:PARDAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'GGK:PAR_NR = PAR_NR AND (((ggk:bkk[1:3]=''231'' AND ggk:d_k=''D'') OR ( GG' & |
    'K:BKK[1:3]=''531'' and ggk:d_k=''K'' )) AND ~CycleApmaksa(F:NESAMAKSATAS) ' & |
    'and ~(GGK:RS=''1''  AND  ATLAUTS[18]=''1''))'
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

