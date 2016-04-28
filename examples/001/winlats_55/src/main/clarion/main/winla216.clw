                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETPAR_Adrese        FUNCTION (PARNR,ADRNR,BROWSE,RET) ! Declare Procedure
!03/07/2013 FAILS     BYTE
FAILS     SHORT
  CODE                                            ! Begin processed code
!
!
!  JÂBÛT POZICIONÇTAM PAR_K......
!
! PARNR:  PARTNERA U_NR
! ADRNR:  1-253-ADRESES U_NR
!         254 - ADRESES un ILN tikai Edisoft klintiem   06/07/2013
!         255-ATGRIEÂZ PASTA VAI PAR:ADRESE
! BROWSE: ADRESES IZVÇLES LOGS
! RET:    0-ADRESE
!         1-DARBALAIKS
!         2-TELEFONS
!         3-GRUPA
!         4-KONTAKTPERSONA
!         5-PIEGADES ADRESE  tikai Edisoft klintiem 02/07/2013
!         6-PIEGADES ILN     tikai Edisoft klintiem 02/07/2013
!
  !03/07/2013 IF ~INRANGE(RET,0,4)
  IF ~INRANGE(RET,0,6)
     KLUDA(0,'ADRESES: Pieprasîts atgriezt '&RET)
     RETURN('')
  .
  IF ~PARNR
     RETURN('')
  .
  IF PAR_A::USED=0
     CHECKOPEN(PAR_A,1)
  .
  PAR_A::USED+=1
  IF BROWSE
     CLEAR(ADR:RECORD)
     ADR:PAR_NR=PARNR
     SET(ADR:NR_KEY,ADR:NR_KEY)
     NEXT(PAR_A)
     IF ~ERROR() AND ADR:PAR_NR=PARNR
        GlobalRequest=SelectRecord
        BrowsePAR_A
        IF GlobalResponse=RequestCompleted
           FAILS=1 !CITA ADRESE
        ELSE
           CLEAR(ADR:RECORD)
           FAILS=6 !JURIDISKÂ
        .
     ELSE
        FAILS=6
     .
   !02/07/2013 <
   ELSIF INRANGE(ADRNR,1,253) AND (RET = 5 OR RET = 6) !VAJAG PIEGADES ILN (darbalaiku) vai adresu
     FAILS=11-RET
     CLEAR(ADR:RECORD)
     ADR:PAR_NR=PARNR
     ADR:ADR_NR=ADRNR
     SET(ADR:NR_KEY,ADR:NR_KEY)
     LOOP
        NEXT(PAR_A)
        IF ERROR() OR ~(ADR:PAR_NR=PARNR) THEN BREAK.
        IF INSTRING(ADR:TIPS,'8')
           FAILS=-4
           BREAK
        .
     .
     !02/07/2013 >
  !03/07/2013 ELSIF INRANGE(ADRNR,1,254)
  ELSIF INRANGE(ADRNR,1,253)
     CLEAR(ADR:RECORD)
     GET(PAR_A,0)
     ADR:PAR_NR=PARNR
     ADR:ADR_NR=ADRNR
     GET(PAR_A,ADR:NR_KEY)
     IF ERROR()
        FAILS=6
     ELSE
        FAILS=1
     .
  ELSIF ADRNR=255 !VAJAG PASTA ADRESI.
     FAILS=6
     CLEAR(ADR:RECORD)
     ADR:PAR_NR=PARNR
     SET(ADR:NR_KEY,ADR:NR_KEY)
     LOOP
        NEXT(PAR_A)
        IF ERROR() OR ~(ADR:PAR_NR=PARNR) THEN BREAK.
        !02/07/2013 IF ADR:TIPS='P'
        IF INSTRING(ADR:TIPS,'1234567P')
           FAILS=1
           BREAK
        .
     .
  !02/07/2013 <
   ELSIF ADRNR=254 !VAJAG KLIENTA EDISOFT ILN (darbalaiku)
     FAILS=11-RET
     CLEAR(ADR:RECORD)
     ADR:PAR_NR=PARNR
     SET(ADR:NR_KEY,ADR:NR_KEY)
     LOOP
        NEXT(PAR_A)
        IF ERROR() OR ~(ADR:PAR_NR=PARNR) THEN BREAK.
        IF INSTRING(ADR:TIPS,'1234567') 
           FAILS=1
           BREAK
        .
     .
   !02/07/2013 >
  ELSE
     FAILS=6
  .
  PAR_A::USED-=1
  IF PAR_A::USED=0
     CLOSE(PAR_A)
  .
  EXECUTE(FAILS+RET)
     RETURN(ADR:ADRESE)        !1
     RETURN(ADR:DARBALAIKS)    !2
     RETURN(ADR:TELEFAX)       !3
     RETURN(ADR:GRUPA)         !4
     RETURN(ADR:KONTAKTS)      !5
     RETURN(PAR:ADRESE)        ! 6
     RETURN(PAR:PIEZIMES)      ! 7
     RETURN(PAR:TEL)           ! 8
     RETURN(PAR:GRUPA)         ! 9
     RETURN(PAR:KONTAKTS)      ! 10
     RETURN('')                ! 11
     RETURN('')                ! 12
  .
  STOP('KLUDA GETPAR_ADRESE()')
B_PaskBilPos         PROCEDURE                    ! Declare Procedure
LocalRequest         LONG,AUTO
LocalResponse        LONG,AUTO
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
RejectRecord         LONG
EOF                  BYTE
OriginalRequest      LONG
POSTENIS             STRING(30)
RK                   STRING(3)
POSTENIS1            STRING(40)
TEXT                 STRING(50)
 !-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END
report REPORT,AT(198,250,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(198,198,8000,52)
       END
HEADER DETAIL,AT(,,,1417)
         STRING(@s45),AT(938,52,3385,208),USE(CLIENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(4427,52),USE(GL:VID_NR),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,260,7083,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('uzòçmuma (uzòçmçjsabiedrîbas) nosaukums, nod. maks. reì. Nr.'),AT(1406,313),USE(?String1)
         STRING('Pielikums bilancei'),AT(6250,469,1198,208),USE(?String2),CENTER
         STRING('Paskaidrojums par atseviðíiem bilances posteòiem'),AT(1615,677,4375,260),USE(?String3), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojoties uz grâmatvedîbas datiem par sintçtisko kontu apgrozîjuma pârskatu (' &|
             'galvenâ grâmatâ).'),AT(469,938),USE(?String4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçra vienîba Ls'),AT(6250,1198),USE(?String5)
       END
detail1 DETAIL,AT(,,,563)
         LINE,AT(104,52,7760,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('Bilances postenis'),AT(156,104,2344,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rindas'),AT(2552,104),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atðifrçjums'),AT(3021,104,2760,208),USE(?String7:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5781,52,0,521),USE(?Line3:5),COLOR(COLOR:Black)
         STRING('Pârskata'),AT(5833,104,990,156),USE(?String7:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6823,52,0,521),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(2969,52,0,521),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,521),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('kods'),AT(2552,313,417,208),USE(?String7:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('. g.'),AT(7396,417,469,156),USE(?String7:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('. g.'),AT(6354,417,469,156),USE(?String7:9),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(6875,260,990,156),USE(?String7:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iepriekðçjais'),AT(6875,104,990,156),USE(?String7:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(5833,260,990,156),USE(?String7:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2500,52,0,521),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(104,52,0,521),USE(?Line3),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,198),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,198),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,198),USE(?Line3:37),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line3:47),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s3),AT(2552,10,417,156),USE(RK),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(260,10,,156),USE(POSTENIS),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail3 DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line3:57),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,198),USE(?Line3:67),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,198),USE(?Line3:77),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,198),USE(?Line3:87),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line3:97),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line3:98),COLOR(COLOR:Black)
         STRING(@s50),AT(3021,10,2760,156),USE(TEXT) 
         STRING(@s40),AT(260,10,2240,156),USE(POSTENIS1),LEFT 
       END
LINE   DETAIL,AT(,,,94)
         LINE,AT(104,-10,0,115),USE(?Line13:67),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,115),USE(?Line23:67),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,115),USE(?Line33:67),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,115),USE(?Line43:67),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,115),USE(?Line53:67),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,115),USE(?Line63:69),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line2:3),COLOR(COLOR:Black)
       END
KOPA   DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line37:7),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,198),USE(?Line37:17),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,198),USE(?Line37:27),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,198),USE(?Line37:37),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line37:47),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line37:48),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(5417,10,,156),USE(?String20),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail4 DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,63),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line41),COLOR(COLOR:Black)
       END
PAPILDU DETAIL,AT(,,,531)
         STRING('Papildu ziòas'),AT(521,52,833,208),USE(?String23),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par uzòçmuma ilgtermiòa ieguldîjumiem (nemateriâliem ieguldîjumiem, pamatlîdzekï' &|
             'iem, ilgtermiòa finansu'),AT(1354,52,6250,208),USE(?String24),FONT(,9,,,CHARSET:BALTIC)
         STRING('ieguldîjumiem saskaòâ ar likuma "Par uzòçmuma gada pârskatiem" 16. pantu) un cit' &|
             'a informâcija'),AT(521,260),USE(?String25),FONT(,9,,,CHARSET:BALTIC)
       END
PAPLINE DETAIL,AT(,,,177)
         LINE,AT(104,104,7760,0),USE(?Line41:2),COLOR(COLOR:Black)
       END
PARAKSTI DETAIL,AT(,,,1417)
         STRING(@s16),AT(5417,156),USE(SYS:PARAKSTS1),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Vadîtâjs'),AT(156,208,677,208),USE(?String26),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,365,3385,0),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(4479,365,3385,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING('paraksts'),AT(2292,417),USE(?String27:2),CENTER 
         STRING('paraksta atðifrçjums'),AT(5521,417),USE(?String28),CENTER 
         STRING(@s16),AT(5417,729),USE(SYS:PARAKSTS2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Galvenais grâmatvedis'),AT(156,781,1615,208),USE(?String26:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,938,2448,0),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(4479,938,3385,0),USE(?Line43:3),COLOR(COLOR:Black)
         STRING('paraksts'),AT(2292,990),USE(?String27),CENTER 
         STRING('paraksta atðifrçjums'),AT(5521,990),USE(?String28:2),CENTER 
       END
       FOOTER,AT(198,10000,8000,52)
       END
       FORM,AT(198,1688,8000,9000)
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
  CODE                                            ! Begin processed code
GetTex               FUNCTION (TEX_NR,RET)        ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RET 1 - TEKSTS1
!     2 - TEKSTS2
!     3 - TEKSTS3
!

  IF ~INRANGE(RET,1,3)
     KLUDA(0,'GETTEX(): Pieprasîts atgriezt '&RET)
     RETURN('')
  .
  IF TEX_NR=0
     return('')
  ELSE
     Teksti::used+=1
     CHECKOPEN(TEKSTI,1)
     CLEAR(TEX:RECORD)
     TEX:NR=TEX_NR
     GET(TEKSTI,TEX:NR_KEY)
     IF ERROR()
        RET=0
     .
  .
  Teksti::used-=1
  IF Teksti::used=0
     CLOSE(TEKSTI)
  .
  EXECUTE RET+1
     return('')
     return(TEX:TEKSTS1)  !1
     return(TEX:TEKSTS2)  !2
     return(TEX:TEKSTS3)  !3
  .
