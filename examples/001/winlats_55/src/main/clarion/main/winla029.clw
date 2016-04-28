                     MEMBER('winlats.clw')        ! This is a MEMBER module
F_PrintPar_K         PROCEDURE                    ! Declare Procedure
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

PAR_INFO1            string(70)
PAR_INFO2            string(70)
PAR_INFO3            string(70)
PAR_PAMAT1           STRING(40)
PAR_PAMAT2           STRING(40)
PAR_ATZIME1          string(40)
PAR_ATZIME2          string(40)

NMR                  STRING(50)
FILTRS_TEXT          STRING(150)
CP                   STRING(3)
PPP                  STRING(30) !ParPamat1/ParPamat2vD231
COMPARE_V            STRING(60)
ANALIZE              STRING(50)
S_DATV               LONG
B_DATV               LONG
SUMMAV               DECIMAL(11,2)
SKAITSV              USHORT
V_APGROZIJUMS        DECIMAL(11,2)
V_SKAITS             USHORT
T_APGROZIJUMS        DECIMAL(11,2)
T_SKAITS             USHORT
KEY_SEC              BYTE
ARHIVS               BYTE
DAT                  DATE
LAI                  TIME
REQA                 STRING(4)
KOMATS               STRING(2)

!-----------------------------------------------------------------------------
Process:View         VIEW(PAR_K)
                       PROJECT(PAR:NOS_S)
                       PROJECT(PAR:KARTE)
                       PROJECT(PAR:U_NR)
                       PROJECT(PAR:NMR_KODS)
                       PROJECT(PAR:LIGUMS)
                     END

!-----------------------------------------------------------------------------
!    A4 LANDSCAPE REPORTA Y+H OPTIMÂLAIS=8000
!    REPORTA Y= HEADERA Y+H
!    FOOTERA Y= REPORTA Y+H
!    DETAILA | LINEI OPTIMÂLAIS Y=-5 H=DETAILA H+10
report REPORT,AT(250,1000,12000,6948),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(250,198,12000,802),USE(?unnamed)
         STRING(@s45),AT(3542,52,4219,208),USE(client),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(83,573,208,208),USE(?String19),CENTER(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s150),AT(833,313,9635,208),USE(FILTRS_text),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#.lapaP),AT(10583,365,573,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(9042,521,0,313),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(52,781,11094,0),COLOR(COLOR:Black)
         LINE,AT(11146,521,0,313),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(313,521,0,313),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(52,521,11094,0),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(729,521,0,313),COLOR(COLOR:Black)
         STRING('Karte'),AT(344,573,365,208),USE(?unnamed:2),CENTER(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(781,573,1719,208),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese,Kontaktpersona/telefons,e-pasts'),AT(3438,573,2656,208),USE(?AKT),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6698,521,0,313),USE(?Line12:3),COLOR(COLOR:Black)
         STRING('Atzîme/atzîme2'),AT(9135,573,1615,208),USE(?String13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,521,0,313),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(2844,531,0,313),USE(?Line9),COLOR(COLOR:Black)
         STRING(@s30),AT(6771,573,2229,208),USE(PPP),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,271),USE(?unnamed:3)
         LINE,AT(52,,0,270),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(313,,0,270),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(729,,0,270),COLOR(COLOR:Black)
         LINE,AT(2844,,0,270),COLOR(COLOR:Black)
         LINE,AT(6698,,0,270),USE(?Line14:3),COLOR(COLOR:Black)
         LINE,AT(9042,,0,270),USE(?Line14:2),COLOR(COLOR:Black)
         LINE,AT(11146,,0,270),USE(?Line14),COLOR(COLOR:Black)
         STRING(@n_5B),AT(375,10,313,145),USE(PAR:KARTE),CENTER(1)
         STRING(@s35),AT(781,10,2042,145),USE(PAR:NOS_p)
         STRING(@s70),AT(2875,10,3802,145),USE(PAR_INFO1),LEFT(1)
         STRING(@s70),AT(2875,125,3802,145),USE(PAR_INFO2),TRN,LEFT(1)
         STRING(@s40),AT(6729,10,2292,145),USE(PAR_PAMAT1),LEFT(1)
         STRING(@s40),AT(6729,125,2292,145),USE(PAR_PAMAT2),TRN,LEFT(1)
         STRING(@s40),AT(9083,10,2031,145),USE(PAR_ATZIME1)
         STRING(@s40),AT(9083,125,2031,145),USE(PAR_ATZIME2),TRN
         LINE,AT(52,260,11094,0),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,208,145),CNT,USE(?Count),CENTER
       END
detail1 DETAIL,AT(,,,385),USE(?unnamed:5)
         LINE,AT(52,,0,385),USE(?Line131),COLOR(COLOR:Black)
         LINE,AT(313,,0,385),USE(?Line311),COLOR(COLOR:Black)
         LINE,AT(729,,0,385),COLOR(COLOR:Black)
         LINE,AT(2844,,0,385),COLOR(COLOR:Black)
         LINE,AT(6698,,0,385),USE(?Line14:31),COLOR(COLOR:Black)
         LINE,AT(9042,,0,385),USE(?Line14:21),COLOR(COLOR:Black)
         LINE,AT(11146,,0,385),USE(?Line141),COLOR(COLOR:Black)
         STRING(@n_5B),AT(375,10,313,145),USE(PAR:KARTE,,?PK1),CENTER(1)
         STRING(@s35),AT(781,10,2042,145),USE(PAR:NOS_p,,?NP1)
         STRING(@s70),AT(2875,10,3802,145),USE(PAR_INFO1,,?I1),LEFT(1)
         STRING(@s70),AT(2875,125,3802,145),USE(PAR_INFO2,,?PAR_INFO2:3),TRN,LEFT(1)
         STRING(@s70),AT(2875,240,3802,145),USE(PAR_INFO3),TRN,LEFT(1)
         STRING(@s40),AT(6729,10,2292,145),USE(PAR_PAMAT1,,?P1),LEFT(1)
         STRING(@s40),AT(6729,125,2292,145),USE(PAR_PAMAT2,,?PAR_PAMAT2:2),TRN,LEFT(1)
         STRING(@s40),AT(9083,10,2031,145),USE(PAR_ATZIME1,,?A1)
         STRING(@s40),AT(9083,125,2031,145),USE(PAR_ATZIME2,,?PAR_ATZIME2:2),TRN
         LINE,AT(52,375,11094,0),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@n_4),AT(83,10,208,145),CNT,USE(?Count:1),CENTER
       END
FOOTER DETAIL,USE(?unnamed:4)
         LINE,AT(63,52,11094,0),USE(?Line15),COLOR(COLOR:Black)
         STRING(@D06.),AT(10052,63),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10635,63),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(2844,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(6698,0,0,63),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(9042,-10,0,63),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(11146,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(313,-10,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,63),USE(?Line20:2),COLOR(COLOR:Black)
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

Window WINDOW('Filtrs klienta aktivitâtes samazinâjuma konststçðanai'),AT(,,316,92),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC), |
         GRAY
       STRING('Analizçt veiktos darîjumus no vçstures faila norçíiniem par 231.. no'),AT(6,8),USE(?String1)
       ENTRY(@D6.),AT(214,8,40,10),USE(S_DATV)
       STRING('lîdz'),AT(257,8),USE(?String2)
       ENTRY(@D6.),AT(270,8,40,10),USE(B_DATV)
       STRING('ja darîjumu kopsumma sasniedz vismaz Ls'),AT(19,21),USE(?String3)
       ENTRY(@N_11.2),AT(153,21,29,10),USE(SUMMAV)
       STRING('un to skaits nav mazâks par'),AT(186,21),USE(?String4)
       ENTRY(@N_4),AT(273,21,24,10),USE(SkaitsV)
       STRING('Iegûto rezultâtu salîdzinât ar periodu tekoðajâ gadâ no'),AT(26,35),USE(?String5)
       ENTRY(@D6.),AT(197,35,40,10),USE(S_DAT)
       STRING('lîdz'),AT(239,35),USE(?String21)
       ENTRY(@D6.),AT(252,35,40,10),USE(B_DAT)
       STRING('un drukât tikai, ja konstatçts darîjumu summas vai skaita samazinâjums'),AT(47,49),USE(?String7)
       STRING('Iegûtie skaitïi tiks pievienoti tikai EXCEL izdrukai'),AT(87,61),USE(?String71)
       BUTTON('OK'),AT(277,75,35,14),USE(?Ok),DEFAULT
       BUTTON('Nerçíinât'),AT(239,75,36,14),USE(?NEREKINAT)
     END


Key_window WINDOW(' '),AT(,,147,130),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),CENTER,GRAY
       OPTION('Secîba :'),AT(3,8,78,67),USE(KEY_SEC),BOXED
         RADIO('Nosaukumu'),AT(11,21),USE(?Option1:Radio1),VALUE('1')
         RADIO('Karðu Nr'),AT(11,31),USE(?Option1:Radio2),VALUE('2')
         RADIO('Reìistrâcijas Nr'),AT(11,41),USE(?Option1:Radio3),VALUE('3')
         RADIO('Raþotâju kodu'),AT(11,52),USE(?Option1:Radio4),VALUE('4')
       END
       GROUP('vçl adreses :'),AT(82,8,55,67),USE(?Group1),BOXED
         CHECK('Fileâles'),AT(88,23),USE(REQA[1]),VALUE('F',' ')
         CHECK('Veikala'),AT(88,44),USE(REQA[3]),VALUE('V',' ')
         CHECK('Arhîvs'),AT(88,55),USE(REQA[4]),VALUE('A',' ')
       END
       CHECK('Pasta'),AT(88,33),USE(REQA[2]),VALUE('P',' ')
       BUTTON('Iekïaut partnerus no arhîva'),AT(7,86,97,14),USE(?Button:Arhivs)
       IMAGE('CHECK3.ICO'),AT(105,80,15,22),USE(?Image:ARHIVS),HIDE
       BUTTON('&OK'),AT(65,106,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(102,105,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  OPCIJA='000048000003001102'
!         123456789012345678
  izzfiltB                     !NO MAINa NEDRÎKST SAUKT....
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  .
  KEY_SEC=1
  OPEN(KEY_window)
!  DISPLAY()
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY()
      SELECT(?OkButton)
    OF EVENT:GainFocus
      DISPLAY()
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?BUTTON:ARHIVS
      CASE EVENT()
      OF EVENT:Accepted
         IF ARHIVS=FALSE
            ARHIVS=TRUE
            UNHIDE(?IMAGE:ARHIVS)
         ELSE
            ARHIVS=FALSE
            HIDE(?IMAGE:ARHIVS)
         .
         DISPLAY()
      .
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
!       LocalResponse = RequestCompleted
       BREAK
       END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
         DO PROCEDURERETURN
      END
    END
  END
  CLOSE(KEY_WINDOW)

  IF F:XML !PIEPRASITS ANALIZÇT VÇSTURI
     S_DATV= DATE(MONTH(S_DAT),DAY(S_DAT),YEAR(S_DAT)-1)
     B_DATV= DATE(MONTH(B_DAT),DAY(B_DAT),YEAR(B_DAT)-1)
     OPEN(WINDOW)
     ACCEPT
        CASE FIELD()
        OF ?NEREKINAT
           IF EVENT()=EVENT:ACCEPTED
              F:XML=''
              BREAK
           .
        OF ?OK
           IF EVENT()=EVENT:ACCEPTED
              BREAK
           .
        .
     .
     CLOSE(WINDOW)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  .
  PAR_K::Used += 1
  IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  .
  VESTURE::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  .
  GGK::Used += 1
  IF PAR_A::USED = 0
    CHECKOPEN(PAR_A,1)
  .
  PAR_A::USED += 1
  FilesOpened = True

  BIND(PAR:RECORD)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)

  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Partneru saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CP = 'R11'
      CLEAR(PAR:RECORD)
      EXECUTE(KEY_SEC)
         SET(PAR:NOS_KEY)
         SET(PAR:KARTE_KEY)
         SET(PAR:NMR_KEY)
         SET(PAR:NOS_U_KEY)
      .
      Process:View{Prop:Filter} ='~CYCLEPAR_K(CP)'
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
      IF F:XML !VAJAG SALÎDZINÂT APGROZÎJUMUS VÇSTURÇ UN TEK.DB
         COMPARE_V=FORMAT(S_DATV,@D6.)&'-'&FORMAT(B_DATV,@D6)&CHR(9)&'Skaits'&CHR(9)&FORMAT(S_DAT,@D6.)&'-'&FORMAT(B_DAT,@D6.)&CHR(9)&'Skaits'
      ELSE
         COMPARE_V=''
      .
      FILTRS_TEXT='Partneru saraksts uz '&format(TODAY(),@D06.)
      IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
      IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
      IF F:X THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' X= '&F:X.
      IF ARHIVS THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Arî arhîvs'.

      IF F:DTK
         PPP='Lîgums1/pçdçjais D231'
      ELSE
         PPP='Lîgums1/Lîgums2'
      .
      DAT=TODAY()
      LAI=CLOCK()

      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PARTNERI.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'   !EXCEL
           OUTA:LINE='Npk'&CHR(9)&'Karte'&CHR(9)&'Nosaukums'&CHR(9)&'Adrese,Kontaktpersona'&CHR(9)&|
           CLIP(PPP)&CHR(9)&'Atzîme' &CHR(9)&'NMR/PK'&CHR(9)&'U_nr'&CHR(9)&'Grupa..'&CHR(9)&'X'&CHR(9)&'Kredîtlimits'&|
           CHR(9)&'IBAN'&CHR(9)&'Atlaide'&CHR(9)&COMPARE_V
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'telefons,e-pasts'&CHR(9)
        ELSE
           OUTA:LINE='Npk'&CHR(9)&'Karte'&CHR(9)&'Nosaukums'&CHR(9)&'Adrese,Kontaktpersona/telefons,e-pasts'&CHR(9)&|
           CLIP(PPP)&CHR(9)&'Atzîme' &CHR(9)&'NMR/PK'&CHR(9)&'U_nr'&CHR(9)&'Grupa..'&CHR(9)&'X'&CHR(9)&'Kredîtlimits'&|
           CHR(9)&'IBAN'&CHR(9)&'Atlaide'&CHR(9)&COMPARE_V
        .
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF (~F:X OR PAR:BAITS=F:X) |                         ! ÍEKSIS
        AND ~(ACC_kods_n=0 AND PAR:NOS_P[1:9]='REZERVÇTS') | ! NEDRUKÂT ATVÇRTOS Nr
        AND ~(ARHIVS=FALSE AND PAR:REDZAMIBA='A')            ! NEVAJAG ARHÎVU
            NPK#+=1
            PRINT#=TRUE
            PAR_PAMAT2=''
            TEKSTS=''
            PAR_INFO3=''

            IF REQA !VÇL ADRESES
               CLEAR(ADR:RECORD)
               ADR:PAR_NR=PAR:U_NR
               SET(ADR:NR_KEY,ADR:NR_KEY)
               LOOP
                  NEXT(PAR_A)
                  IF ERROR() OR ~(ADR:PAR_NR=PAR:U_NR) THEN BREAK.
                  IF INSTRING(ADR:TIPS,REQA)
                     TEKSTS=CLIP(TEKSTS)&' '&ADR:TIPS&': '&CLIP(ADR:ADRESE)
                  .
               .
               IF TEKSTS
                  TEKSTS=CLIP(PAR:ADRESE)&' '&CLIP(PAR:KONTAKTS)&' '&CLIP(PAR:TEL)&' '&CLIP(PAR:EMAIL)&' '&CLIP(TEKSTS)
                  FORMAT_TEKSTS(90,'Arial',8,'')
                  PAR_INFO1=F_TEKSTS[1]
                  PAR_INFO2=F_TEKSTS[2]
                  PAR_INFO3=F_TEKSTS[3]
               ELSE
                  PAR_INFO1=CLIP(PAR:ADRESE)&' '&CLIP(PAR:KONTAKTS) !JURIDISKÂ ADRESE
                  PAR_INFO2=CLIP(PAR:TEL)&' '&CLIP(PAR:EMAIL)
               .
            ELSE
               PAR_INFO1=CLIP(PAR:ADRESE)&' '&CLIP(PAR:KONTAKTS) !JURIDISKÂ ADRESE
               PAR_INFO2=CLIP(PAR:TEL)&' '&CLIP(PAR:EMAIL)
            .
            IF ACC_kods_n=0   !ASSAKO
               PAR_PAMAT1=PAR:GRUPA[1:3]&CLIP(PAR:LIGUMS)&' '&LEFT(FORMAT(PAR:L_SUMMA,@N_8.2B))
            ELSE
               PAR_PAMAT1=PAR:LIGUMS&' '&LEFT(FORMAT(PAR:L_SUMMA,@N_8.2B))
            .
            IF F:DTK !PÇDÇJAIS RÇÍINS
               CLEAR(GGK:RECORD)
               GGK:PAR_NR=PAR:U_NR
               GGK:DATUMS=TODAY()
               SET(GGK:PAR_KEY,GGK:PAR_KEY)
               LOOP
                  PREVIOUS(GGK)
                  IF ERROR() OR ~(GGK:PAR_NR=PAR:U_NR) THEN BREAK.
                  IF GGK:BKK[1:3]='231' AND GGK:D_K='D'
                     IF GETGG(GGK:U_NR)
                        PAR_PAMAT2=CLIP(GG:DOK_SENR)&' '&FORMAT(GGK:DATUMS,@D05.)&' '&LEFT(FORMAT(GGK:SUMMA,@N_8.2))
                     ELSE
                        PAR_PAMAT2=FORMAT(GGK:DATUMS,@D05.)&' '&LEFT(FORMAT(GGK:SUMMA,@N_8.2))
                     .
                     BREAK
                  .
               .
            ELSE
!               PAR_PAMAT2=PAR:LIGUMS2&' '&LEFT(FORMAT(PAR:SUMMA2,@N_8.2B))
            .
            PAR_ATZIME1=CLIP(GETPAR_ATZIME(PAR:ATZIME1,1))
            PAR_ATZIME2=CLIP(GETPAR_ATZIME(PAR:ATZIME2,1))
            NMR=GETPAR_K(PAR:U_NR,0,8)
!            IF PAR:TIPS='F' THEN NMR=CLIP(NMR)&' '&CLIP(PAR:PVN_PASE).
            IF F:XML !PIEPRASITS ANALIZÇT VÇSTURI & SALÎDZINÂT AR TEKOÐO APGROZÎJUMU
               V_APGROZIJUMS=0
               V_SKAITS=0
               ANALIZE=''
               CLEAR(VES:RECORD)
               VES:PAR_NR=PAR:U_NR
               VES:DATUMS=S_DATV
               SET(VES:PAR_KEY,VES:PAR_KEY)
               LOOP
                  NEXT(VESTURE)
                  IF ERROR() OR ~(VES:PAR_NR=PAR:U_NR AND VES:DATUMS<=B_DATV) THEN BREAK.
                  IF VES:D_K_KONTS[1:3]='231' 
                     V_APGROZIJUMS+=VES:SUMMA
                     V_SKAITS+=1
                  .
               .
               T_APGROZIJUMS=0
               T_SKAITS=0
               CLEAR(GGK:RECORD)
               GGK:PAR_NR=PAR:U_NR
               GGK:DATUMS=S_DAT
               SET(GGK:PAR_KEY,GGK:PAR_KEY)
               LOOP
                  NEXT(GGK)
                  IF ERROR() OR ~(GGK:PAR_NR=PAR:U_NR AND GGK:DATUMS<=B_DAT) THEN BREAK.
                  IF GGK:BKK[1:3]='231' AND GGK:D_K='D'
                     T_APGROZIJUMS+=GGK:SUMMA
                     T_SKAITS+=1
                  .
               .
               IF V_APGROZIJUMS>=SUMMAV AND V_SKAITS>SKAITSV AND (T_APGROZIJUMS<V_APGROZIJUMS OR T_SKAITS<V_SKAITS)
                  PRINT#=TRUE
                  ANALIZE=FORMAT(V_APGROZIJUMS,@N-_14.2)&CHR(9)&FORMAT(V_SKAITS,@N_4)&CHR(9)&|
                  LEFT(FORMAT(T_APGROZIJUMS,@N-_14.2))&CHR(9)&CLIP(T_SKAITS)
               ELSE
                  PRINT#=FALSE
               .
            .
            IF PRINT#=TRUE
               IF F:DBF='W'
                  IF PAR_INFO3 !INFO 3 RINDÂS
                     PRINT(RPT:detail1)
                  ELSE
                     PRINT(RPT:detail)
                  .
               ELSIF F:DBF='E'
                  OUTA:LINE=CLIP(NPK#)&CHR(9)&CLIP(PAR:KARTE)&CHR(9)&CLIP(PAR:NOS_P)&CHR(9)&CLIP(PAR_INFO1)&|
                  CHR(9)&CLIP(PAR_PAMAT1)&CHR(9)&CLIP(PAR_ATZIME1)&|
                  CHR(9)&CLIP(NMR)&CHR(9)&CLIP(PAR:U_NR)&CHR(9)&PAR:grupa&CHR(9)&FORMAT(PAR:BAITS,@N1B)&CHR(9)&|
                  LEFT(FORMAT(PAR:KRED_LIM,@N_11.2B))&CHR(9)&PAR:BAN_NR&CHR(9)&LEFT(FORMAT(PAR:ATLAIDE,@N_5.1B))&|
                  CHR(9)&CLIP(ANALIZE)
                  ADD(OUTFILEANSI)
                  OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CLIP(PAR_INFO2)&|
                  CHR(9)&CLIP(PAR_PAMAT2)&CHR(9)&CLIP(PAR_ATZIME2)&|
                  CHR(9)&CLIP(NMR)&CHR(9)&CLIP(PAR:U_NR)&CHR(9)&PAR:grupa&CHR(9)&FORMAT(PAR:BAITS,@N1B)&CHR(9)&|
                  LEFT(FORMAT(PAR:KRED_LIM,@N_11.2B))&CHR(9)&PAR:BAN_NR&CHR(9)&LEFT(FORMAT(PAR:ATLAIDE,@N_5.1B))&|
                  CHR(9)&CLIP(ANALIZE)
                  ADD(OUTFILEANSI)
               ELSE
                  OUTA:LINE=CLIP(NPK#)&CHR(9)&CLIP(PAR:KARTE)&CHR(9)&CLIP(PAR:NOS_P)&CHR(9)&CLIP(PAR_INFO1)&' '&|
                  CLIP(PAR_INFO2)&' '&CLIP(PAR_INFO3)&CHR(9)&CLIP(PAR_PAMAT1)&' '&CLIP(PAR_PAMAT2)&CHR(9)&CLIP(PAR_ATZIME1)&' '&|
                  CLIP(PAR_ATZIME2)&CHR(9)&CLIP(NMR)&CHR(9)&CLIP(PAR:U_NR)&CHR(9)&PAR:grupa&CHR(9)&|
                  FORMAT(PAR:BAITS,@N1B)&CHR(9)&LEFT(FORMAT(PAR:KRED_LIM,@N_11.2B))&CHR(9)&PAR:BAN_NR&CHR(9)&|
                  LEFT(FORMAT(PAR:ATLAIDE,@N_5.1B))&|
                  CHR(9)&CLIP(ANALIZE)
                  ADD(OUTFILEANSI)
               .
!               IF REQA !VÇL ADRESES
!                  CLEAR(ADR:RECORD)
!                  ADR:PAR_NR=PAR:U_NR
!                  SET(ADR:NR_KEY,ADR:NR_KEY)
!                  LOOP
!                     NEXT(ADR_K)
!                     IF ERROR() OR ~(ADR:PAR_NR=PAR:U_NR) THEN BREAK.
!                     IF INSTRING(ADR:TIPS,REQA)
!                        PAR_INFOF=ADR:TIPS&': '&CLIP(ADR:ADRESE)
!                        IF F:DBF='W'
!                           PRINT(RPT:detailF)
!                        ELSE
!                           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CLIP(PAR_INFOF)&CHR(9)&|
!                           CLIP(PAR_PAMAT1)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
!                           CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)
!                           ADD(OUTFILEANSI)
!                        .
!                     .
!                  .
!               .
            .
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
  IF SEND(PAR_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:FOOTER)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAR_A::USED-=1
    IF PAR_A::USED=0 THEN CLOSE(PAR_A).
  .
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
      StandardWarning(Warn:RecordFetchError,'PAR_K')
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
F_PrintKon_k         PROCEDURE                    ! Declare Procedure
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
!RejectRecord         LONG
!LocalRequest         LONG
!LocalResponse        LONG
!FilesOpened          LONG
!WindowOpened         LONG
!RecordsToProcess     LONG,AUTO
!RecordsProcessed     LONG,AUTO
!RecordsPerCycle      LONG,AUTO
!RecordsThisCycle     LONG,AUTO
!PercentProgress      BYTE
!RecordStatus         BYTE,AUTO

DAT                  LONG
LAI                  LONG
!-----------------------------------------------------------------------------
Process:View         VIEW(KON_K)
                       PROJECT(KON:BKK)
                       PROJECT(KON:BAITS)
                       PROJECT(KON:NOSAUKUMS)
                       PROJECT(KON:NOSAUKUMSA)
                       PROJECT(KON:VAL)
                     END

!         LINE,AT(7552,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
!         LINE,AT(0,0,0,198),USE(?Line2:28),COLOR(COLOR:Black)
!         LINE,AT(0,0,0,208),USE(?Line2:31),COLOR(COLOR:Black)

!-----------------------------------------------------------------------------
report REPORT,AT(200,1160,11250,7000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(200,100,11000,1063),USE(?unnamed)
         STRING('2'),AT(6708,865,208,146),USE(?String4:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('1'),AT(7042,865,208,146),USE(?String4:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(7313,865,208,146),USE(?String4:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7281,844,0,208),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(6688,833,0,208),USE(?Line2:23),COLOR(COLOR:Black)
         STRING('1'),AT(6458,865,208,146),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6406,573,0,469),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6979,573,0,469),USE(?Line2:26),COLOR(COLOR:Black)
         STRING('Bilance / PZA2'),AT(5219,615,938,156),USE(?String4:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7552,573,0,469),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(9490,573,0,469),USE(?Line2:27),COLOR(COLOR:Black)
         STRING('PVNDne'),AT(6427,625,552,156),USE(?String4:12),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PieKokm.'),AT(7010,625,521,156),USE(?String4:16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Naudas plûsmas pârskats NPP2'),AT(7604,625,1823,156),USE(?String4:13),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Paðu kap.izm.p.'),AT(9521,625,1094,156),USE(?String4:17),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10625,573,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(5313,833,0,208),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(5677,833,0,208),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6042,833,0,208),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('1'),AT(5000,865,208,146),USE(?String4:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(5365,865,208,146),USE(?String4:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(5729,865,208,146),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(6094,865,208,146),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4948,573,0,469),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@s45),AT(3104,52,4427,200),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kontu plâns'),AT(3104,313,4427,208),USE(?String3),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10000,417,573,156),PAGENO,USE(?PageCount),FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(260,573,10365,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Konts'),AT(292,729,365,208),USE(?String4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1042,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(813,750,3177,146),USE(?String4:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valûta'),AT(4042,750,469,150),USE(?String4:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iezak'),AT(4563,750,365,146),USE(?String4:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(677,573,0,469),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4010,573,0,469),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4531,573,0,469),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4948,833,5677,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(260,573,0,469),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,11000,208),USE(?unnamed:2)
         LINE,AT(6979,0,0,208),USE(?Line2:25),COLOR(COLOR:Black)
         STRING(@n3),AT(6448,0,208,156),USE(kon:PVND[1]),RIGHT
         STRING(@n3),AT(6729,0,208,156),USE(kon:PVND[2]),RIGHT
         STRING(@n3),AT(7031,0,208,156),USE(kon:PVNK[1]),TRN,RIGHT
         STRING(@n3),AT(7313,0,208,156),USE(kon:PVNK[2]),TRN,RIGHT
         LINE,AT(7552,0,0,208),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(6688,0,0,208),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@S1),AT(7604,0,208,156),USE(KON:NPPF[1]),TRN,CENTER
         STRING(@n3),AT(7813,0,208,156),USE(KON:NPP2[1],,?KON:NPP2_1:3),TRN,RIGHT
         STRING(@S1),AT(8083,0,208,156),USE(KON:NPPF[2]),TRN,CENTER
         STRING(@n3),AT(8292,0,208,156),USE(KON:NPP2[2]),TRN,RIGHT
         STRING(@S1),AT(8563,0,208,156),USE(KON:NPPF[3]),TRN,CENTER
         STRING(@n3),AT(8771,0,208,156),USE(KON:NPP2[3]),TRN,RIGHT
         STRING(@S1),AT(9031,0,208,156),USE(KON:NPPF[4]),TRN,CENTER
         STRING(@n3),AT(9240,0,208,156),USE(KON:NPP2[4]),TRN,RIGHT
         LINE,AT(9490,0,0,208),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@n3),AT(9688,0,208,156),USE(KON:pkip[1]),TRN,RIGHT
         STRING(@S1),AT(10000,0,208,156),USE(KON:PKIF[2]),TRN,CENTER
         STRING(@n3),AT(10135,0,208,156),USE(KON:pkip[2]),TRN,RIGHT
         LINE,AT(10625,0,0,208),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(7281,0,0,208),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@S1),AT(9542,10,208,156),USE(KON:PKIF[1]),TRN,CENTER
         LINE,AT(6406,0,0,208),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@n3),AT(6146,0,208,156),USE(kon:PZB[4]),RIGHT
         LINE,AT(6042,0,0,208),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@n3),AT(5781,0,208,156),USE(kon:PZB[3]),RIGHT
         LINE,AT(5677,0,0,208),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@n3),AT(5417,0,208,156),USE(kon:PZB[2]),RIGHT
         LINE,AT(5313,0,0,208),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@n3),AT(5052,0,208,156),USE(kon:PZB[1]),RIGHT
         LINE,AT(4948,0,0,208),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@n1b),AT(4635,0,260,156),USE(kon:BAITS),RIGHT
         LINE,AT(260,0,0,208),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@s5),AT(313,0,365,156),USE(KON:BKK),LEFT
         LINE,AT(677,0,0,208),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@s50),AT(740,0,3177,156),USE(KON:NOSAUKUMS),LEFT
         LINE,AT(4531,0,0,208),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s3),AT(4167,0,281,156),USE(KON:val),LEFT
         LINE,AT(4010,0,0,208),USE(?Line2:5),COLOR(COLOR:Black)
       END
FOOTER   DETAIL,AT(10,10,11000,198),USE(?LINE)
         LINE,AT(260,0,10360,1),USE(?Line20:2),COLOR(COLOR:Black)
         STRING(@D06.),AT(9719,21),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@T1),AT(10313,21),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(200,8110,11198,21),USE(?unnamed:3)
         LINE,AT(260,0,10360,1),USE(?Line1:4),COLOR(COLOR:Black)
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
  PUSHBIND

  OPCIJA='0'
  izzfiltF                     !NO MAINa NEDRÎKST SAUKT....
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  DAT = TODAY()
  LAI = CLOCK()
  IF KON_K::Used = 0
    CheckOpen(KON_K,1)
  END
  KON_K::Used += 1
  BIND(KON:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(KON_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kontu plâns'
  ?Progress:UserString{Prop:Text}=''
  SEND(KON_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(KON:BKK_KEY)
      Process:View{Prop:Filter} = ''
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
          PRINT(RPT:detail)
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
  IF SEND(KON_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:FOOTER)
       ENDPAGE(report)
       CLOSE(ProgressWindow)
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
       .
    ELSE
       ANSIJOB
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
!  ELSE
!     CLOSE(OUTFILEANSI)
!     ANSIFILENAME=''
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
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
      StandardWarning(Warn:RecordFetchError,'KON_K')
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
F_AtlaidesReport     PROCEDURE                    ! Declare Procedure
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
head_text            string(40)
REP_ATL_K            STRING(50)
REP_ATL              STRING(5)
!-----------------------------------------------------------------------------
Process:View         VIEW(PAR_K)
                       PROJECT(PAR:NOS_P)
                       PROJECT(PAR:U_NR)
                       PROJECT(PAR:ADRESE)
                       PROJECT(PAR:ATLAIDE)
                     END
report REPORT,AT(146,1010,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(146,198,12000,813)
         STRING(@s45),AT(4167,52,3750,156),USE(client),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(3938,260,4219,208),USE(head_text),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#.lapaP),AT(9531,313,698,135),PAGENO,USE(?PageCount),FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(52,781,10313,0),COLOR(COLOR:Black)
         LINE,AT(10365,521,0,313),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(52,521,10313,0),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(6823,521,0,313),COLOR(COLOR:Black)
         LINE,AT(5885,521,0,313),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(83,563,2240,208),USE(?unnamed:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('U_Nr'),AT(2375,563,885,208),USE(?String10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(3313,563,2552,208),USE(?unnamed:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Komentârs'),AT(6865,563,3490,208),USE(?String13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,521,0,313),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(2344,521,0,313),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(3281,521,0,313),USE(?Line21),COLOR(COLOR:Black)
         STRING('Atlaides Nr/ %'),AT(5917,563,885,208),USE(?unnamed),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,12000,177)
         LINE,AT(2344,-10,0,198),COLOR(COLOR:Black)
         STRING(@N_13),AT(2396,10,833,156),USE(PAR:U_NR),RIGHT
         LINE,AT(3281,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line14:2),COLOR(COLOR:Black)
         STRING(@s35),AT(104,10,2240,156),USE(PAR:NOS_p)
         STRING(@s40),AT(3333,10,2552,156),USE(PAR:adrese),LEFT(1)
         LINE,AT(10365,-10,0,198),USE(?Line14),COLOR(COLOR:Black)
         STRING(@s5),AT(5938,10,677,156),USE(REP_ATL),RIGHT
         STRING(@s50),AT(6927,10,3281,156),USE(REP_ATL_K),LEFT(1)
         LINE,AT(52,-10,0,198),USE(?Line13),COLOR(COLOR:Black)
       END
detail1 DETAIL
         LINE,AT(52,52,10313,0),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(3281,-10,0,63),USE(?Line161),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,63),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(10365,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,7500,12000,52)
         LINE,AT(52,0,10313,0),USE(?Line15:2),COLOR(COLOR:Black)
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
  PUSHBIND

  OPCIJA='0'
  izzfiltF                     !NO MAINa NEDRÎKST SAUKT....
  IF GlobalResponse=RequestCancelled
     DO PROCEDURERETURN
  .

  CHECKOPEN(ATL_K)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Atlaides'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAR:NOS_KEY)
      Process:View{Prop:Filter} = ''
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
      OPEN(report)
      HEAD_TEXT='Pieðíirtâs atlaides'
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF PAR:ATLAIDE>0
            REP_ATL_K=''
            REP_ATL=PAR:ATLAIDE&'%'
            IF PAR:ATLAIDE>100
                C#=GETPAR_ATLAIDE(PAR:ATLAIDE,'')
                REP_ATL=ATL:U_NR
                REP_ATL_K=ATL:KOMENTARS
            END
            PRINT(RPT:detail)
        END
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
  IF SEND(PAR_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:DETAIL1)
       ENDPAGE(report)
       CLOSE(ProgressWindow)
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
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
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
      StandardWarning(Warn:RecordFetchError,'PAR_K')
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
