                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_ZurnalsVK1P        PROCEDURE                    ! Declare Procedure
ATLMAS               DECIMAL(10,2),DIM(20,5)
RejectRecord         LONG
EOF                  BYTE
!- - - - - - - - - - - - - - - - - -
CG                   STRING(10)
VIRSRAKSTS           STRING(90)
FILTRS_TEXT          STRING(120)
SAV_VAL              STRING(3)
VAL_NR               BYTE
MULTIVALUTAS         BYTE
BRIDINAJUMS19        BYTE
JADRUKA_SALDO        BYTE
JADRUKA_SAK_APGROZ   BYTE
VAL_VAL              STRING(3)
NGG                  STRING(5)
DATUMS               DATE
PARTNER              STRING(35)
SATURS               CSTRING(255)  !
DEB                  DECIMAL(14,2)
KRE                  DECIMAL(14,2)
ATL                  DECIMAL(14,2)
TS0                  STRING(4)
SATURS1              STRING(55)
DEBV                 DECIMAL(14,2)
KREV                 DECIMAL(14,2)
ATLV                 DECIMAL(15,2)
DEBAPG               DECIMAL(15,2)
KREAPG               DECIMAL(15,2)
DEBAPGs              DECIMAL(15,2)
KREAPGs              DECIMAL(15,2)
APG                  DECIMAL(15,2)
ST                   STRING(7)
TS                   STRING(45)
APGRTEXT             STRING(50)
DEBAPGV              DECIMAL(15,2)
KREAPGV              DECIMAL(15,2)
APGV                 DECIMAL(15,2)
!   RPT_FOOT1 DETAIL
DAT                  LONG
LAI                  TIME
LDEB                 DECIMAL(14,2)
LKRE                 DECIMAL(14,2)
LATL                 DECIMAL(14,2)
!- - - - - - - - - - - - - - - - - - -
DEB1                 DECIMAL(14,2)
KRE1                 DECIMAL(14,2)
!RC                   DECIMAL(1)
!- - - - - - - - - - - - - - - - - - -
LINEH                STRING(190)
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

!-----------------------------------------------------------------------------
report REPORT,AT(120,1420,8021,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(120,104,8000,1302),USE(?unnamed:2)
         STRING('Nr'),AT(2313,1094,365,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta'),AT(2313,885,365,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(0,417,7448,208),USE(VIRSRAKSTS),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1510,146,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7313,625,573,208),PAGENO,USE(?PageCount),RIGHT(2)
         STRING(@s120),AT(156,615,7135,208),USE(FILTRS_TEXT),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,833,0,469),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(469,833,0,469),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(1406,833,0,469),USE(?Line5),COLOR(COLOR:Black)
         STRING('Nr'),AT(135,885,313,208),USE(?String15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(500,885,885,208),USE(?String16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(7219,885,625,208),USE(?String21),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s4),AT(6896,896),USE(kkk),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1417,990,469,208),USE(?String17),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR'),AT(1927,990,156,208),USE(?String15:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('N'),AT(2135,990,156,208),USE(?String15:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,833,0,469),USE(?Line6:3),COLOR(COLOR:Black)
         STRING('Ieraksta saturs'),AT(2740,990,2500,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(5292,990,729,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(6073,990,729,208),USE(?String20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no gada sâkuma'),AT(6854,1094,990,208),USE(?String22),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,833,0,469),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(2115,833,0,469),USE(?Line6:4),COLOR(COLOR:Black)
         LINE,AT(5260,833,0,469),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(6042,833,0,469),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(6823,833,0,469),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7865,833,0,469),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(2688,833,0,469),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Numurs'),AT(500,1094,885,208),USE(?String24),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('GG'),AT(135,1094,313,208),USE(?String23),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1302,7760,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(104,833,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
atlikums_Ls DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(104,-10,0,197),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line37:5),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,197),USE(?Line37:4),COLOR(COLOR:Black)
         STRING('Konta atlikums uz '),AT(156,10,906,156),USE(?String61),LEFT
         STRING(@D06.),AT(1302,10,615,156),USE(DATUMS),CENTER
         STRING(@s7),AT(2240,10,677,156),USE(ST),CENTER
         STRING(@n-14.2b),AT(6875,10,729,156),USE(atl,,?atl:2),RIGHT(1)
         LINE,AT(6042,-10,0,197),USE(?Line37:3),COLOR(COLOR:Black)
         STRING(@s3),AT(7615,10,240,156),USE(val_uzsk),CENTER
       END
atlikums_val DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(104,-10,0,197),USE(?Line53:18),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,197),USE(?Line58:3),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line58:2),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,3021,156),USE(ts),LEFT
         STRING(@s3),AT(7646,10,208,156),USE(VAL_VAL,,?VAL_VAL:3),TRN,CENTER
         LINE,AT(6823,-10,0,197),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line53:15),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(6875,10,729,156),USE(atlV),RIGHT
       END
linija DETAIL,AT(,,,10),USE(?unnamed:6)
         LINE,AT(104,0,7760,0),USE(?Line57),COLOR(COLOR:Black)
       END
detail DETAIL,AT(-10,10,8021,177),USE(?unnamed:4)
         LINE,AT(6823,-10,0,197),USE(?Line53:5),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:9),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line53:25),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,197),USE(?Line53:24),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,197),USE(?Line53:3),COLOR(COLOR:Black)
         STRING(@n3b),AT(1885,10,208,156),USE(ggk:obj_nr),TRN,RIGHT
         LINE,AT(2115,-10,0,197),USE(?Line53:26),COLOR(COLOR:Black)
         STRING(@s2),AT(2156,10,208,156),USE(ggk:nodala),TRN,LEFT
         LINE,AT(2292,-10,0,197),USE(?Line53:4),COLOR(COLOR:Black)
         STRING(@s5),AT(2344,10,365,156),USE(ggk:bkk),TRN,LEFT
         LINE,AT(1406,-10,0,197),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@d05.),AT(1417,10,469,156),USE(DATUMS,,?DATUMS:2),TRN,CENTER(1)
         STRING(@N_5B),AT(156,10,313,156),USE(NGG),TRN,CENTER
         STRING(@S14),AT(500,10,885,156),USE(GG:DOK_SENR),TRN,RIGHT(1)
         STRING(@s55),AT(2708,10,2552,156),USE(SATURS),LEFT
         STRING(@N-14.2B),AT(5292,10,729,156),USE(DEB),RIGHT
         STRING(@N-14.2B),AT(6073,10,729,156),USE(KRE),RIGHT
         STRING(@n-14.2b),AT(6875,10,729,156),USE(atl),RIGHT(1)
         STRING(@s3),AT(7635,10,219,156),USE(val_uzsk,,?val_uzsk:2)
         LINE,AT(2688,-10,0,197),USE(?Line53:486),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line53:6),COLOR(COLOR:Black)
       END
detailv DETAIL,AT(,,8021,177),USE(?unnamed:3)
         STRING(@s4),AT(1510,10,313,156),USE(ts0)
         STRING(@s55),AT(2708,10,2552,156),USE(SATURS1),LEFT
         LINE,AT(6042,-10,0,197),USE(?Line53:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line53:16),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(5292,10,729,156),USE(debV),RIGHT
         STRING(@n-14.2b),AT(6073,10,729,156),USE(kreV),RIGHT
         STRING(@n-14.2b),AT(6875,10,729,156),USE(atlv,,?atlv:2),RIGHT
         STRING(@s3),AT(7646,10,208,156),USE(VAL_VAL),TRN,CENTER
         LINE,AT(7865,-10,0,197),USE(?Line53:17),COLOR(COLOR:Black)
         LINE,AT(2688,-10,0,197),USE(?Line53:11),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:7),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,197),USE(?Line53:8),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,197),USE(?Line53:10),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,197),USE(?Line53:12),COLOR(COLOR:Black)
         LINE,AT(2115,-10,0,197),USE(?Line53:119),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,197),USE(?Line53:27),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,197),USE(?Line53:14),COLOR(COLOR:Black)
       END
Apgrozijums_Ls DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         STRING(@s50),AT(990,10,3385,156),USE(APGRTEXT),LEFT(3)
         LINE,AT(6823,-10,0,197),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,197),USE(?Line35:6),COLOR(COLOR:Black)
         STRING(@n-14.2),AT(5292,10,729,156),USE(debapg),RIGHT
         STRING(@n-14.2),AT(6073,10,729,156),USE(kreapg),RIGHT
         STRING(@n-14.2),AT(6875,10,729,156),USE(apg),RIGHT
         STRING(@s3),AT(7635,10,219,156),USE(val_uzsk,,?val_uzsk:3),CENTER
         STRING('Apgrozîjums  '),AT(156,10,688,156),USE(?String57),LEFT
       END
apgrozijums_val DETAIL,AT(,,,177),USE(?unnamed:8)
         LINE,AT(5260,-10,0,197),USE(?Line53:22),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line53:20),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line53:21),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line53:19),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:23),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,2969,156),USE(ts,,?ts:2),LEFT
         STRING(@n-14.2b),AT(5292,10,729,156),USE(debapgv),RIGHT
         STRING(@n-14.2b),AT(6073,10,729,156),USE(kreapgv),RIGHT
         STRING(@n-14.2b),AT(6875,10,729,156),USE(apgv),RIGHT
         STRING(@s3),AT(7646,10,208,156),USE(VAL_VAL,,?VAL_VAL:2),TRN,CENTER
       END
RPT_FOOT DETAIL,AT(,,8021,219),USE(?unnamed:5)
         LINE,AT(104,0,0,63),USE(?Line54:28),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line54:26),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,63),USE(?Line54:27),COLOR(COLOR:Black)
         STRING('Sastâdîja  :'),AT(104,73),USE(?String64),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(573,73),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING('RS  :'),AT(1198,73),USE(?String66),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@S1),AT(1417,73),USE(rS),CENTER,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6042,0,0,63),USE(?Line61),COLOR(COLOR:Black)
         STRING(@d06.),AT(6813,73),USE(dat),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7427,73),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(5260,0,0,63),USE(?Line62),COLOR(COLOR:Black)
       END
       FOOTER,AT(120,10920,8000,10),USE(?unnamed:9) !10920= 9500+1420
         LINE,AT(104,0,7760,0),USE(?Line48:3),COLOR(COLOR:Black)
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
!
!
!  Þurnâls konkrçtam partnerim pa visiem kontiem
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled

  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0           !DÇÏ GETGG
    CheckOpen(GG,1)
  END
  GG::USED+=1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  FilesOpened = True

  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  BIND(PAR:RECORD)
  BIND('par_nr',par_nr)
  BIND('kkk',kkk)
  BIND('cyclebkk',cyclebkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(ggk:record)
      ggk:par_nr=par_nr
      SET(GGK:par_key,GGK:par_key)
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

      CG = 'K110011'

      VIRSRAKSTS='Partneris: '&CLIP(GETPAR_K(PAR_NR,2,2))&' Periods: '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
      FILTRS_TEXT='Kontu grupa: '&CLIP(KKK)&' '&CLIP(GETKON_K(KKK,0,7))
!      IF PAR_GRUPA THEN StringGRUPA='Grupa: '&par_grupa.
!      IF ~(PAR_TIPS='EFCIR') THEN StringTips='Tips: '&par_Tips.
      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!      IF ~(PAR_TIPS='EFCIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
!      IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
      IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
      IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.

      TS=''
      ST=''
      SAV_VAL=''
      DEBAPGS=0
      KREAPGS=0
      DEBAPG=0
      KREAPG=0
      ATL=0
      MULTIVALUTAS=FALSE
      JADRUKA_SAK_APGROZ=FALSE
      JADRUKA_SALDO=FALSE
      CLEAR(ATLMAS)
      BRIDINAJUMS19=FALSE
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('ZURN1PVK.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Nr GG'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Dokumenta Datums'&CHR(9)&'PRO'&CHR(9)&'NOD'&CHR(9)&|
          'Konta Nr'&CHR(9)&'Ieraksta saturs'&CHR(9)&'Debets'&CHR(9)&'Kredîts'&CHR(9)&'Atlikums no finansu gada sâkuma'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         npk#+=1
         ?Progress:UserString{Prop:Text}=NPK#
         DISPLAY(?Progress:UserString)
         IF ~CYCLEGGK(CG) AND ~cyclebkk(ggk:bkk,kkk)
            DO CHECKSALDO
            DO CHECKSAKAT
            CASE GGK:D_K
            OF 'D'
               DEB  =GGK:SUMMA
               KRE  =0
               DEBV =GGK:SUMMAV
               KREV =0
            OF 'K'
               KRE  =GGK:SUMMA
               KREV =GGK:SUMMAV
               DEBV =0
               DEB  =0
            .
            ATL += DEB-KRE
            IF BAND(ggk:BAITS,00000001b) !IEZAKS
               VAL_NR=20
               SAV_VAL=''
            ELSE
               IF ~(SAV_VAL=GGK:VAL)     !LAI LIEKI NESAUKTU VALNR F-JU
                  SAV_VAL=GGK:VAL
                  VAL_NR=VALNR(GGK:VAL,1)
                  IF ~INRANGE(VAL_NR,1,19)
                     IF BRIDINAJUMS19=FALSE
                        KLUDA(0,'Pârâk daudz valûtu, nebûs pareizi "tai skaitâ..."')
                     .
                     BRIDINAJUMS19=TRUE
                     VAL_NR=19
                  .
               .
            .
            ATLMAS[VAL_NR,1]+=DEBV-KREV
            IF GGK:DATUMS<S_DAT AND GGK:U_NR>1       ! SÂKUMA APGROZÎJUMS
               DEBAPGS+=DEB
               ATLMAS[VAL_NR,2]+=DEBV
               KREAPGS+=KRE
               ATLMAS[VAL_NR,3]+=KREV
            ELSIF GGK:DATUMS >= S_DAT AND GGK:U_NR>1 ! APGROZÎJUMS PERIODÂ
               DEBAPG+=DEB
               ATLMAS[VAL_NR,4]+=DEBV
               KREAPG+=KRE
               ATLMAS[VAL_NR,5]+=KREV
            .
            !Elya 01/12/2013 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
            IF ~(GGK:VAL=val_uzsk)
               MULTIVALUTAS=TRUE
            .
            IF GGK:U_NR=1
               JADRUKA_SALDO=TRUE
            .
            IF GGK:DATUMS < S_DAT AND GGK:U_NR > 1
               JADRUKA_SAK_APGROZ=TRUE
            .
            DO CHECKTEXT
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    APGRTEXT= 'periodâ : '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
    apg=debapg-kreapg
    IF F:DBF='W'
        PRINT(RPT:apgrozijums_Ls)
    ELSE
        !OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       TS='tai skaitâ'
       LOOP I#=1 TO 20
          IF ATLMAS[I#,4] OR ATLMAS[I#,5]
             DEBAPGV=ATLMAS[I#,4]
             KREAPGV=ATLMAS[I#,5]
             APGV=DEBAPGV-KREAPGV
             IF I#=20        !IEZAKS
                !El VAL_VAL='Ls'
                VAL_VAL=val_uzsk
                TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
             ELSE
                VAL_VAL=VALNR(I#,2)
             .
             IF F:DBF='W'
                PRINT(RPT:apgrozijums_VAL)
             ELSE
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
                ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    APGRTEXT= 'no finansu gada sâkuma'
    debapg+=debapgs
    kreapg+=kreapgs
    apg=debapg-kreapg
    IF F:DBF='W'
        PRINT(RPT:apgrozijums_Ls)
    ELSE
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&|
        CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
        !El CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       TS='tai skaitâ'
       LOOP I#=1 TO 20
          IF ATLMAS[I#,2] OR ATLMAS[I#,3] OR ATLMAS[I#,4] OR ATLMAS[I#,5]
             DEBAPGV=ATLMAS[I#,2]+ATLMAS[I#,4]
             KREAPGV=ATLMAS[I#,3]+ATLMAS[I#,5]
             APGV=DEBAPGV-KREAPGV
             IF I#=20        !IEZAKS
                !El VAL_VAL='Ls'
                VAL_VAL=val_uzsk
                TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
             ELSE
                VAL_VAL=VALNR(I#,2)
             .
             IF F:DBF='W'
                PRINT(RPT:apgrozijums_VAL)
             ELSE
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2))&CHR(9)&|
                LEFT(FORMAT(KREAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
                ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    ST=''
    DATUMS = B_DAT
    IF F:DBF='W'
        PRINT(RPT:Atlikums_Ls)
    ELSE
        !OUTA:LINE='Konta atlikums uz'&CHR(9)&LEFT(format(DATUMS,@D06.))&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Konta atlikums uz'&CHR(9)&LEFT(format(DATUMS,@D06.))&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       TS='tai skaitâ'
       LOOP I#=1 TO 20
          IF ATLMAS[I#,1]
             ATLV=ATLMAS[I#,1]
             IF I#=20        !IEZAKS
                !VAL_VAL='Ls'
                VAL_VAL=val_uzsk
                TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
             ELSE
                VAL_VAL=VALNR(I#,2)
             .
             IF F:DBF='W'
                 PRINT(RPT:Atlikums_Val)
             ELSE
                 OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                 ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    DAT = TODAY()
    LAI = CLOCK()
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)                           !PRINT GRAND TOTALS
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'
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
!-----------------------------------------------------------
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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

!-------------------------------------
CHECKSALDO ROUTINE
    IF GGK:U_NR > 1 AND JADRUKA_SALDO
!       DATUMS = DATE(1,1,GL:DB_GADS)
       DATUMS = DATE(1,1,YEAR(S_DAT))
       ST='(Saldo)'
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS
          TS='tai skaitâ'
          LOOP I#=1 TO 10
             IF ATLMAS[I#,1]
                ATLV=ATLMAS[I#,1]
                VAL_VAL=VALNR(I#,2)
                IF F:DBF='W'
                    PRINT(RPT:Atlikums_Val)
                ELSE
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                    ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
       JADRUKA_SALDO=FALSE
       IF F:DBF='W'
           PRINT(RPT:linija)
       ELSIF F:DBF='E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
    .

!-------------------------------------
CHECKSAKAT ROUTINE
    IF GGK:DATUMS >= S_DAT AND JADRUKA_SAK_APGROZ=TRUE
       DATUMS=S_DAT-1
       ST=''
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS
          TS='tai skaitâ'
          LOOP I#=1 TO 10
             IF ATLMAS[I#,1]
                ATLV=ATLMAS[I#,1]
                VAL_VAL=VALNR(I#,2)
                IF F:DBF='W'
                    PRINT(RPT:Atlikums_Val)
                ELSE
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                    ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
       JADRUKA_SAK_APGROZ=FALSE
       IF F:DBF='W'
           PRINT(RPT:linija)
       ELSIF F:DBF='E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
    .
!-------------------------------------
CHECKTEXT ROUTINE
   IF GGK:DATUMS >= S_DAT AND GGK:U_NR>1
      GG:U_NR=GGK:U_NR
      GET(GG,GG:NR_KEY)
      NGG    =GGK:U_NR
      DATUMS =GG:DATUMS
      IF ~(GG:PAR_NR=GGK:PAR_NR)
         TEKSTS = CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
      ELSE
         TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
      .
!      FORMAT_TEKSTS(65,'Arial',8,'')
!      SATURS = F_TEKSTS[1]

      IF F:DBF='W' OR F:DBF='E' !WMF,EXCEL
         FORMAT_TEKSTS(65,'Arial',8,'')
         SATURS = F_TEKSTS[1]
      ELSE !A-WORD
         SATURS = TEKSTS  !DODAM VISU VIENÂ RINDÂ
         CLEAR(F_TEKSTS)
      .

      IF F:DBF='W'
        PRINT(RPT:DETAIL)
      ELSE
        !El OUTA:LINE=NGG&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&GGK:BKK&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE=NGG&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&GGK:BKK&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
      END
      SATURS1 = F_TEKSTS[2]
      !Elya 01/12/2013 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
      IF ~(GGK:VAL=val_uzsk)

         TS0='t.s.'
         val_VAL=GGK:VAL
         atlv = ATLMAS[VAL_NR,1]
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      ELSIF SATURS1
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
      TS0='    '
      SATURS1 = F_TEKSTS[3]
      IF SATURS1   !!!GG:SATURS3
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
    .
   PRTEXT# = 0

!-------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~(GGK:par_nr=par_nr)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
B_Zurnals1K1P        PROCEDURE                    ! Declare Procedure
atlmas               DECIMAL(10,2),DIM(20,5)
CG                   STRING(10)
SAV_VAL              STRING(3)
VAL_NR               BYTE
MULTIVALUTAS         BYTE
BRIDINAJUMS19        BYTE
JADRUKA_SALDO        BYTE
JADRUKA_SAK_APGROZ   BYTE
VAL_VAL              STRING(3)

VIRSRAKSTS           STRING(90)
PAR_NOS_P            STRING(45)
FILTRS_TEXT          STRING(200)

NGG                  STRING(5)
DATUMS               LONG
SATURS               CSTRING(255) !
SATURS1              STRING(55)
DEB                  DECIMAL(14,2)
KRE                  DECIMAL(14,2)
ATL                  DECIMAL(14,2)
TS0                  STRING(4)
DEBV                 DECIMAL(14,2)
KREV                 DECIMAL(14,2)
ATLV                 DECIMAL(15,2)
DEBAPG               DECIMAL(15,2)
KREAPG               DECIMAL(15,2)
DEBAPGs              DECIMAL(15,2)
KREAPGs              DECIMAL(15,2)
APG                  DECIMAL(15,2)
ST                   STRING(7)
TS                   STRING(45)
APGRTEXT             STRING(50)
DEBAPGV              DECIMAL(15,2)
KREAPGV              DECIMAL(15,2)
APGV                 DECIMAL(15,2)
DAT                  LONG
LAI                  TIME
LDEB                 DECIMAL(14,2)
LKRE                 DECIMAL(14,2)
LATL                 DECIMAL(14,2)
DEB1                 DECIMAL(14,2)
KRE1                 DECIMAL(14,2)
LINEH                STRING(190)

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

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
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
                       PROJECT(GGK:BAITS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(100,1670,8021,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,104,8000,1563),USE(?unnamed:6)
         STRING(@s45),AT(1750,302,4531,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(552,531,6927,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2240,698,3542,208),USE(PAR_NOS_P),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s200),AT(104,885,7813,208),USE(FILTRS_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7302,719,573,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(104,1094,0,469),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(448,1094,0,469),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(1354,1094,0,469),USE(?Line5),COLOR(COLOR:Black)
         STRING('Nr'),AT(156,1146,260,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(500,1146,833,208),USE(?String16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums no'),AT(6875,1146,938,208),USE(?String21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1385,1146,521,208),USE(?String17),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR'),AT(1958,1146,156,208),USE(?String17:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('N'),AT(2167,1146,156,208),USE(?String17:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2146,1094,0,469),USE(?Line6:4),COLOR(COLOR:Black)
         LINE,AT(2344,1094,0,469),USE(?Line6:3),COLOR(COLOR:Black)
         STRING('Ieraksta saturs'),AT(2375,1146,2760,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(5188,1146,781,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(6021,1146,781,208),USE(?String20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gada sâkuma'),AT(6875,1354,938,208),USE(?String22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5156,1094,0,469),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(5990,1094,0,469),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(6823,1094,0,469),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7896,1094,0,469),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(1927,1094,0,469),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Numurs'),AT(500,1354,833,208),USE(?String24),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('GG'),AT(156,1354,260,208),USE(?String23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1563,7865,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(104,1094,7800,0),USE(?Line1),COLOR(COLOR:Black)
       END
atlikums_Ls DETAIL,AT(,,8000,177),USE(?unnamed:3)
         LINE,AT(104,-10,0,197),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7896,-10,0,197),USE(?Line37:5),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line37:4),COLOR(COLOR:Black)
         STRING('Konta atlikums uz '),AT(156,10,,156),USE(?String61),LEFT
         STRING(@D06.),AT(1302,10,615,156),USE(DATUMS),CENTER
         STRING(@s7),AT(2250,10,490,156),USE(ST),CENTER
         STRING(@n-14.2b),AT(6844,10,781,156),USE(atl,,?atl:2),RIGHT(1)
         LINE,AT(5990,-10,0,197),USE(?Line37:3),COLOR(COLOR:Black)
         STRING(@s3),AT(7646,10,240,156),USE(val_uzsk),CENTER
       END
atlikums_val DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(104,-10,0,197),USE(?Line53:18),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line58:3),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,197),USE(?Line58:2),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,2917,156),USE(ts),LEFT
         STRING(@s3),AT(7646,10,240,156),USE(VAL_VAL,,?VAL_VAL:3),CENTER
         LINE,AT(6823,-10,0,197),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(7906,-10,0,197),USE(?Line53:15),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(6844,10,781,156),USE(atlV),RIGHT(1)
       END
linija DETAIL,AT(,,,10),USE(?linija)
         LINE,AT(104,0,7800,0),USE(?Line57),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8021,177),USE(?unnamed)
         LINE,AT(6823,-10,0,197),USE(?Line53:5),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:9),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,197),USE(?Line53:22),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line53:12),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(448,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@d06.),AT(1354,10,573,156),USE(DATUMS,,?DATUMS:2),TRN,CENTER
         STRING(@N_5B),AT(115,10,313,156),USE(NGG),TRN,CENTER
         STRING(@S14),AT(458,10,885,156),USE(GG:DOK_SENR),TRN,RIGHT
         STRING(@S2),AT(2167,10,156,156),USE(GGK:NODALA),TRN,RIGHT
         STRING(@s55),AT(2375,10,2760,156),USE(SATURS),LEFT
         STRING(@N-14.2B),AT(5198,10,781,156),USE(DEB),RIGHT
         STRING(@N-14.2B),AT(6042,10,781,156),USE(KRE),RIGHT
         STRING(@n-14.2b),AT(6844,10,781,156),USE(atl),RIGHT(1)
         STRING(@s3),AT(7646,10,240,156),USE(val_uzsk,,?val_uzsk:2),CENTER
         LINE,AT(1927,-10,0,197),USE(?Line53:25),COLOR(COLOR:Black)
         STRING(@N3B),AT(1927,10,208,156),USE(GGK:OBJ_NR),TRN,RIGHT
         LINE,AT(2146,-10,0,197),USE(?Line53:3),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,197),USE(?Line53:24),COLOR(COLOR:Black)
         LINE,AT(7896,-10,0,197),USE(?Line53:6),COLOR(COLOR:Black)
       END
detailv DETAIL,AT(,,8021,177),USE(?unnamed:4)
         STRING(@s4),AT(1563,10,313,156),USE(ts0)
         STRING(@s55),AT(2375,10,2760,156),USE(SATURS1),LEFT
         LINE,AT(5990,-10,0,197),USE(?Line53:13),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line53:16),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(5198,10,781,156),USE(debV),RIGHT
         STRING(@n-14.2b),AT(6031,10,781,156),USE(kreV),RIGHT
         STRING(@n-14.2b),AT(6844,10,781,156),USE(atlv,,?atlv:2),RIGHT(1)
         STRING(@s3),AT(7646,10,240,156),USE(VAL_VAL),CENTER
         LINE,AT(7896,-10,0,197),USE(?Line53:17),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,197),USE(?Line53:4),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:7),COLOR(COLOR:Black)
         LINE,AT(448,-10,0,197),USE(?Line53:8),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line53:10),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,197),USE(?Line53:27),COLOR(COLOR:Black)
         LINE,AT(2146,-10,0,197),USE(?Line53:26),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line53:11),COLOR(COLOR:Black)
       END
Apgrozijums_Ls DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(104,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7896,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         STRING(@s50),AT(990,10,3385,156),USE(APGRTEXT),LEFT(3)
         LINE,AT(6823,-10,0,197),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,197),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,197),USE(?Line35:6),COLOR(COLOR:Black)
         STRING(@n-14.2),AT(5198,10,781,156),USE(debapg),RIGHT
         STRING(@n-14.2),AT(6031,10,781,156),USE(kreapg),RIGHT
         STRING(@n-14.2),AT(6844,10,781,156),USE(apg),RIGHT(1)
         STRING(@s3),AT(7646,10,240,156),USE(val_uzsk,,?val_uzsk:3),CENTER
         STRING('Apgrozîjums  '),AT(156,10,688,156),USE(?String57),LEFT
       END
apgrozijums_val DETAIL,AT(,,,177)
         LINE,AT(5156,-10,0,197),USE(?Line53:14),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,197),USE(?Line53:20),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,197),USE(?Line53:21),COLOR(COLOR:Black)
         LINE,AT(7896,-10,0,197),USE(?Line53:19),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line53:23),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,3021,156),USE(ts,,?ts:2),LEFT
         STRING(@n-14.2b),AT(5198,10,781,156),USE(debapgv),RIGHT
         STRING(@n-14.2b),AT(6031,10,781,156),USE(kreapgv),RIGHT
         STRING(@n-14.2b),AT(6844,10,781,156),USE(apgv),RIGHT(1)
         STRING(@s3),AT(7646,10,240,156),USE(VAL_VAL,,?VAL_VAL:2),CENTER
       END
RPT_FOOT DETAIL,AT(,,8000,271),USE(?unnamed:5)
         LINE,AT(104,0,0,63),USE(?Line54:28),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line54:26),COLOR(COLOR:Black)
         LINE,AT(104,52,7800,0),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(7896,0,0,63),USE(?Line54:27),COLOR(COLOR:Black)
         STRING('Sastâdîja  :'),AT(104,63),USE(?String64),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(573,63),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS  :'),AT(1167,63),USE(?String66),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@S1),AT(1365,63),USE(rS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(5990,0,0,63),USE(?Line61),COLOR(COLOR:Black)
         STRING(@d06.),AT(6906,63),USE(dat),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(7438,63),USE(lai),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(5156,0,0,63),USE(?Line62),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,10970,8000,73)
         LINE,AT(104,0,7800,0),USE(?Line48:3),COLOR(COLOR:Black)
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
!
!
!  Þurnâls konkrçtam kontam vienam partneriem
!  ÐÎTAM IR SÂKTS MÇÌINÂT UZTAISÎT, LAI NEDRUKÂ APGROZÎJUMS T.S.Ls, JA IR TIKAI LATI
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0           !DÇÏ GETGG
    CheckOpen(GG,1)
  END
  GG::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('gads',gads)
  BIND('par_nr',par_nr)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('KKK',KKK)
  FilesOpened = True
  BRIDINAJUMS19=FALSE
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  SAV_VAL = ''
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!  IF ~(PAR_TIPS='EFCIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
!  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
  IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
  IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.
  VIRSRAKSTS=KKK&' : '&CLIP(GETKON_K(KKK,2,2))&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  PAR_NOS_P=GETPAR_K(PAR_NR,2,2)
  CLEAR(ATLMAS)
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Þurnâls 1 konts 1 partneris'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(ggk:record)
      ggk:bkk=kkk
!      GGK:DATUMS = DATE(1,1,GADS)
!      GGK:DATUMS = DATE(1,1,YEAR(S_DAT))
      GGK:DATUMS = DB_S_DAT
      CG = 'K110111'
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      Process:View{Prop:Filter} ='GGK:PAR_NR=PAR_NR AND ~CYCLEGGK(CG)'
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('ZURN1K1P.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=virsraksts
          ADD(OUTFILEANSI)
          OUTA:LINE=PAR_NOS_P
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Nr GG'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Dokumenta Datums'&CHR(9)&'PRO'&CHR(9)&'NOD'&CHR(9)&|
          'Ieraksta saturs'&CHR(9)&'Debets'&CHR(9)&'Kredîts'&CHR(9)&'Atlikums no finansu gada sâkuma'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         npk#+=1
         ?Progress:UserString{Prop:Text}=NPK#
         DISPLAY(?Progress:UserString)
!------------------------------CALCULATIONS--------------------------------
         DO CHECKSALDO
         DO CHECKSAKAT
         CASE GGK:D_K
         OF 'D'
            DEB  =GGK:SUMMA
            KRE  =0
            DEBV =GGK:SUMMAV
            KREV =0
         OF 'K'
            KRE  =GGK:SUMMA
            KREV =GGK:SUMMAV
            DEBV =0
            DEB  =0
         .
         ATL += DEB-KRE
         IF BAND(ggk:BAITS,00000001b) !IEZAKS
            VAL_NR=20
            SAV_VAL=''
         ELSE
            IF ~(SAV_VAL=GGK:VAL)     !LAI LIEKI NESAUKTU VALNR F-JU
               SAV_VAL=GGK:VAL
               VAL_NR=VALNR(GGK:VAL,1)
               IF ~INRANGE(VAL_NR,1,19)
                  IF BRIDINAJUMS19=FALSE
                     KLUDA(0,'Pârâk daudz valûtu, nebûs pareizi "tai skaitâ..."')
                  .
                  BRIDINAJUMS19=TRUE
                  VAL_NR=19
               .
            .
         .
         ATLMAS[VAL_NR,1]+=DEBV-KREV
         IF GGK:DATUMS<S_DAT AND GGK:U_NR>1       ! SÂKUMA APGROZÎJUMS
            DEBAPGS+=DEB
            ATLMAS[VAL_NR,2]+=DEBV
            KREAPGS+=KRE
            ATLMAS[VAL_NR,3]+=KREV
         ELSIF GGK:DATUMS >= S_DAT AND GGK:U_NR>1 ! APGROZÎJUMS PERIODÂ
            DEBAPG+=DEB
            ATLMAS[VAL_NR,4]+=DEBV
            KREAPG+=KRE
            ATLMAS[VAL_NR,5]+=KREV
         .
         !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
         IF ~(GGK:VAL=val_uzsk)
            MULTIVALUTAS=TRUE
         .
         IF GGK:U_NR=1
            JADRUKA_SALDO=TRUE
         .
         IF GGK:DATUMS < S_DAT AND GGK:U_NR > 1
            JADRUKA_SAK_APGROZ=TRUE
         .
         DO CHECKTEXT
 !--------------------END OF CALCULATIONS--------------------------------
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    APGRTEXT= 'periodâ : '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
    apg=debapg-kreapg
    IF F:DBF='W'
        PRINT(RPT:apgrozijums_Ls)
    ELSE
        !El OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPG,@N-_14.2))&CHR(9)&LEFT(format(KREAPG,@N-_14.2))&CHR(9)&LEFT(format(APG,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPG,@N-_14.2))&CHR(9)&LEFT(format(KREAPG,@N-_14.2))&CHR(9)&LEFT(format(APG,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       JADRUKA_TS#=FALSE
       LOOP I#=1 TO 20
          !El IF (ATLMAS[I#,4] OR ATLMAS[I#,5]) AND ~(VALNR(I#,2)='Ls' OR VALNR(I#,2)='LVL')
          IF (ATLMAS[I#,4] OR ATLMAS[I#,5]) AND ~(VALNR(I#,2)=val_uzsk)
             JADRUKA_TS#=TRUE
             BREAK
          .
       .
       IF JADRUKA_TS#=TRUE
          TS='tai skaitâ  '
          LOOP I#=1 TO 20
             IF ATLMAS[I#,4] OR ATLMAS[I#,5]
                DEBAPGV=ATLMAS[I#,4]
                KREAPGV=ATLMAS[I#,5]
                APGV=DEBAPGV-KREAPGV
                IF I#=20        !IEZAKS
                   !VAL_VAL='Ls'
                   VAL_VAL=val_uzsk
                   TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
                ELSE
                   VAL_VAL=VALNR(I#,2)
                .
                IF F:DBF='W'
                   PRINT(RPT:apgrozijums_VAL)
                ELSE
                   OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPGV,@N-_14.2))&CHR(9)&LEFT(format(KREAPGV,@N-_14.2))&CHR(9)&LEFT(format(APGV,@N-_14.2))&CHR(9)&VAL_VAL
                   ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    APGRTEXT= 'no finansu gada sâkuma'
    debapg+=debapgs
    kreapg+=kreapgs
    apg=debapg-kreapg
    IF F:DBF='W'
        PRINT(RPT:apgrozijums_Ls)
    ELSE
        !El OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPG,@N-_14.2))&CHR(9)&LEFT(format(KREAPG,@N-_14.2))&CHR(9)&LEFT(format(APG,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPG,@N-_14.2))&CHR(9)&LEFT(format(KREAPG,@N-_14.2))&CHR(9)&LEFT(format(APG,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       JADRUKA_TS#=FALSE
       LOOP I#=1 TO 20
          !El IF (ATLMAS[I#,2] OR ATLMAS[I#,3] OR ATLMAS[I#,4] OR ATLMAS[I#,5]) AND ~(VALNR(I#,2)='Ls' OR VALNR(I#,2)='LVL')
          IF (ATLMAS[I#,2] OR ATLMAS[I#,3] OR ATLMAS[I#,4] OR ATLMAS[I#,5]) AND ~(VALNR(I#,2)=val_uzsk)
             JADRUKA_TS#=TRUE
             BREAK
          .
       .
       IF JADRUKA_TS#=TRUE
          TS='tai skaitâ  '
          LOOP I#=1 TO 20
             IF ATLMAS[I#,2] OR ATLMAS[I#,3] OR ATLMAS[I#,4] OR ATLMAS[I#,5]
                DEBAPGV=ATLMAS[I#,2]+ATLMAS[I#,4]
                KREAPGV=ATLMAS[I#,3]+ATLMAS[I#,5]
                APGV=DEBAPGV-KREAPGV
                IF I#=20        !IEZAKS
                   !El VAL_VAL='Ls'
                   VAL_VAL=val_uzsk
                   TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
                ELSE
                   VAL_VAL=VALNR(I#,2)
                .
                IF F:DBF='W'
                   PRINT(RPT:apgrozijums_VAL)
                ELSE
                   OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DEBAPGV,@N-_14.2))&CHR(9)&LEFT(format(KREAPGV,@N-_14.2))&CHR(9)&LEFT(format(APGV,@N-_14.2))&CHR(9)&VAL_VAL
                   ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    ST=''
    DATUMS = B_DAT
    IF F:DBF='W'
        PRINT(RPT:Atlikums_Ls)
    ELSE
        !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       JADRUKA_TS#=FALSE
       LOOP I#=1 TO 20
          !El IF ATLMAS[I#,1] AND ~(VALNR(I#,2)='Ls' OR VALNR(I#,2)='LVL')
          IF ATLMAS[I#,1] AND ~(VALNR(I#,2)=val_uzsk)
             JADRUKA_TS#=TRUE
             BREAK
          .
       .
       IF JADRUKA_TS#=TRUE
          TS='tai skaitâ  '
          LOOP I#=1 TO 20
             IF ATLMAS[I#,1]
                ATLV=ATLMAS[I#,1]
                IF I#=20        !IEZAKS
                   !El VAL_VAL='Ls'
                   VAL_VAL=val_uzsk
                   TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
                ELSE
                   VAL_VAL=VALNR(I#,2)
                .
                IF F:DBF='W'
                    PRINT(RPT:Atlikums_Val)
                ELSE
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                    ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
    .
    LAI = CLOCK()
    DAT = TODAY()
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)
        ENDPAGE(report)
    ELSIF F:DBF = 'E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    IF F:DBF='W'
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

!-----------------------------------------------------------
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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

!-------------------------------------
CHECKSALDO ROUTINE
    IF (GGK:U_NR > 1 AND JADRUKA_SALDO)
!       DATUMS = DATE(1,1,GL:DB_GADS)
       DATUMS = DATE(1,1,YEAR(S_DAT))
       ST='(Saldo)'
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS
          JADRUKA_TS#=FALSE
          LOOP I#=1 TO 20
             !El IF ATLMAS[I#,1] AND ~(VALNR(I#,2)='Ls' OR VALNR(I#,2)='LVL')
             IF ATLMAS[I#,1] AND ~(VALNR(I#,2)=val_uzsk)
                JADRUKA_TS#=TRUE
                BREAK
             .
          .
          IF JADRUKA_TS#=TRUE
             TS='tai skaitâ  '
             LOOP I#=1 TO 20
                IF ATLMAS[I#,1]
                   ATLV=ATLMAS[I#,1]
                   VAL_VAL=VALNR(I#,2)
                   IF F:DBF='W'
                       PRINT(RPT:Atlikums_Val)
                   ELSE
                       OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                       ADD(OUTFILEANSI)
                   END
                   TS=''
                .
             .
          .
       .
       JADRUKA_SALDO=FALSE
       IF F:DBF='W'
           PRINT(RPT:linija)
       ELSIF F:DBF = 'E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
    .

!-------------------------------------
CHECKSAKAT ROUTINE
    IF (GGK:DATUMS >= S_DAT AND JADRUKA_SAK_APGROZ)
       DATUMS=S_DAT-1
       ST=''
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS
          JADRUKA_TS#=FALSE
          LOOP I#=1 TO 20
             !El IF ATLMAS[I#,1] AND ~(VALNR(I#,2)='Ls' OR VALNR(I#,2)='LVL')
             IF ATLMAS[I#,1] AND ~(VALNR(I#,2)=val_uzsk)
                JADRUKA_TS#=TRUE
                BREAK
             .
          .
          IF JADRUKA_TS#=TRUE
             TS='tai skaitâ  '
             LOOP I#=1 TO 20
                IF ATLMAS[I#,1]
                   ATLV=ATLMAS[I#,1]
                   VAL_VAL=VALNR(I#,2)
                   IF F:DBF='W'
                       PRINT(RPT:Atlikums_Val)
                   ELSE
                       OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                       ADD(OUTFILEANSI)
                   END
                   TS=''
                .
             .
          .
       .
       JADRUKA_SAK_APGROZ=FALSE
       IF F:DBF='W'
           PRINT(RPT:linija)
       ELSIF F:DBF='E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
    .

!-------------------------------------
CHECKTEXT ROUTINE
   IF (GGK:DATUMS >= S_DAT AND GGK:U_NR>1)
      IF GETGG(GGK:U_NR)
         DATUMS =GG:DATUMS
         IF ~(GG:PAR_NR=GGK:PAR_NR)
            TEKSTS = CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
         ELSE
            TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
         .
!         FORMAT_TEKSTS(70,'Arial',8,'')
!         SATURS = F_TEKSTS[1]

      IF F:DBF='W' OR F:DBF='E' !WMF,EXCEL
         FORMAT_TEKSTS(70,'Arial',8,'')
         SATURS = F_TEKSTS[1]
      ELSE !A-WORD
         SATURS = TEKSTS  !DODAM VISU VIENÂ RINDÂ
         CLEAR(F_TEKSTS)
      .

      ELSE
         DATUMS =GGK:DATUMS
         SATURS = 'GG NAV ATRASTS...'
      .
      NGG    =GGK:U_NR
      IF F:DBF='W'
        PRINT(RPT:DETAIL)
      ELSE
        !El OUTA:LINE=NGG&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE=NGG&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
      END
      SATURS1 = F_TEKSTS[2]
      !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
      IF ~(GGK:VAL=val_uzsk)
         TS0='t.s.'
         val_VAL=GGK:VAL
         atlv = ATLMAS[VAL_NR,1]
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      ELSIF SATURS1
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
      TS0=''
      SATURS1 = F_TEKSTS[3]
      IF SATURS1         !!!GG:SATURS3
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
    .
   PRTEXT# = 0
!-------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~(GGK:BKK=KKK)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
B_DEKRVI             PROCEDURE                    ! Declare Procedure
CG                   STRING(10)
CP                   STRING(5)
P2190                DECIMAL(13,2)
P2310                DECIMAL(13,2)
P5210                DECIMAL(13,2)
P5310                DECIMAL(13,2)
K2190                DECIMAL(13,2)
DK2190               DECIMAL(13,2)
KK2190               DECIMAL(13,2)
K2310                DECIMAL(13,2)
DK2310               DECIMAL(13,2)
KK2310               DECIMAL(13,2)
K5210                DECIMAL(13,2)
DK5210               DECIMAL(13,2)
KK5210               DECIMAL(13,2)
K5310                DECIMAL(13,2)
DK5310               DECIMAL(13,2)
KK5310               DECIMAL(13,2)
L2190                DECIMAL(13,2)
L2310                DECIMAL(13,2)
L5210                DECIMAL(13,2)
L5310                DECIMAL(13,2)
KV2190               DECIMAL(13,2)
KV2310               DECIMAL(13,2)
KV5210               DECIMAL(13,2)
KV5310               DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
NPK                  DECIMAL(4)
NR                   DECIMAL(4)
NOS_P                STRING(45)
KVNOS                STRING(3)
TS                   STRING(12)

FILTRS               STRING(36)
NR_TEXT              STRING(10)

P_Table              QUEUE,PRE(P)
NR                      ULONG
NOS_A                   STRING(5)
p2190                   decimal(12,2)
p2310                   decimal(12,2)
p5210                   decimal(12,2)
p5310                   decimal(12,2)
                     .
K2_Table              QUEUE,PRE(K2)
KEY                     STRING(20)
APMDAT                  LIKE(GG:APMDAT)
SUMMA                   LIKE(ggk:summa)
                     .
K5_Table              QUEUE,PRE(K5)
KEY                     STRING(20)
APMDAT                  LIKE(GG:APMDAT)
SUMMA                   LIKE(ggk:summa)
                     .
KAV231               DECIMAL(3)
KAV531               DECIMAL(3)
VAL_NR               BYTE
MULTIVALUTAS         BYTE
ATLMAS               DECIMAL(10,2),DIM(20,4)
BKK                  STRING(3)
VALUTA               BYTE
VALUTAP              BYTE

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

report REPORT,AT(150,1608,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(150,150,8000,1458),USE(?unnamed:3)
         STRING('(-) mçs esam'),AT(6635,990,885,177),USE(?String55:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kav.'),AT(7573,927),USE(?String66:2),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Kav.'),AT(5438,927),USE(?String66:3),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('(-) mçs esam'),AT(5719,990,865,177),USE(?String55:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('parâdâ preci'),AT(5719,1198,865,177),USE(?String55:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('(+) mums pa-'),AT(4531,990,854,177),USE(?String55:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('râdâ preci'),AT(3573,1198,833,177),USE(?String55:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('râdâ naudu'),AT(4542,1198,844,177),USE(?String55:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('parâdâ naudu'),AT(6615,1198,906,177),USE(?String55:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(500,1219),USE(NR_TEXT),TRN
         STRING('d.'),AT(7635,1125),USE(?String66:4),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('219*'),AT(3646,833,719,156),USE(?String54),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('231*'),AT(4781,833,500,156),USE(?String54:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('521*'),AT(5844,833,583,156),USE(?String54:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('531*'),AT(6771,833,594,156),USE(?String54:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s36),AT(583,1042,2781,177),USE(FILTRS),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('d.'),AT(5458,1125),USE(?String66),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('(+) mums pa-'),AT(3573,990,865,177),USE(?String55),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1406,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7813,781,0,677),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(3542,781,0,677),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4490,781,0,677),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5406,781,0,677),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5688,781,0,677),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(469,781,0,677),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1510,229,4427,156),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6604,781,0,677),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(7531,781,0,677),USE(?Line64:2),COLOR(COLOR:Black)
         STRING('Norçíini ar preèu piegâdâtâjiem / saòçmçjiem'),AT(1406,458,3125,208),USE(?String2),CENTER, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4500,469,740,208),USE(s_dat),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5229,469,125,208),USE(?String4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(5365,469,740,208),USE(b_dat),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7292,542,521,208),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(52,781,7760,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(83,833,365,208),USE(?String7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdâtâjs / Saòçmçjs'),AT(1073,865,1771,208),USE(?String8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,677),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(6604,-10,0,197),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7531,-10,0,197),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@n4),AT(104,10,313,156),USE(NPK),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_5),AT(490,10,365,156),USE(NR),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(875,10,2656,156),USE(NOS_P),FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_11.2b),AT(3594,10,885,156),USE(P2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_11.2b),AT(4510,10,885,156),USE(P2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3B),AT(5438,10,240,146),USE(KAV231),TRN
         LINE,AT(5406,-10,0,197),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(5698,10,885,156),USE(P5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3B),AT(7563,10,240,146),USE(KAV531),TRN
         STRING(@n-_11.2b),AT(6615,0,885,156),USE(P5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5688,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line2:8),COLOR(COLOR:Black)
       END
PER_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:5)
         LINE,AT(52,-10,0,114),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,114),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,114),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,114),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5688,-10,0,114),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6604,-10,0,114),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,114),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,62),USE(?Line44:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,615),USE(?unnamed)
         LINE,AT(7813,-10,0,635),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(7531,0,0,62),USE(?Line44:3),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,635),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line32),COLOR(COLOR:Black)
         STRING('KOPÂ :'),AT(177,104,,156),USE(?String20)
         STRING('D :'),AT(469,260,,156),USE(?String20:2)
         STRING(@n-_13.2b),AT(3594,104,885,156),USE(K2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('K :'),AT(469,417,,156),USE(?String20:3)
         STRING(@n-_13.2b),AT(3594,417,885,156),USE(KK2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(4510,417,885,156),USE(KK2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(5698,417,885,156),USE(KK5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(6615,417,885,156),USE(KK5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,417,260,156),USE(val_uzsk,,?val_uzsk:3),FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3542,573,4271,0),USE(?Line33),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(6615,260,885,156),USE(DK5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,260,260,156),USE(val_uzsk,,?val_uzsk:2),FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(6615,104,885,156),USE(K5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,104,260,156),USE(val_uzsk),FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(5698,260,885,156),USE(DK5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(5698,104,885,156),USE(K5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(4510,260,885,156),USE(DK2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(4510,104,885,156),USE(K2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(3594,260,885,156),USE(DK2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(6604,-10,0,635),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5688,-10,0,635),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,635),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,635),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,635),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line26),COLOR(COLOR:Black)
       END
RPT_FOOTV DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(3542,-10,0,197),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,197),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(5688,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(6604,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,197),USE(?Line34:7),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line34),COLOR(COLOR:Black)
         STRING(@s12),AT(365,10,,156),USE(TS),FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(3594,10,885,156),USE(KV2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(4510,10,885,156),USE(KV2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(5698,10,885,156),USE(KV5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(6615,10,885,156),USE(KV5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(7542,10,271,156),USE(KVNOS),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,281),USE(?unnamed:2)
         LINE,AT(52,-10,0,62),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,62),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,62),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(5688,-10,0,62),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(6604,-10,0,62),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line45:2),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,62),USE(?Line43:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line46:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(52,83,521,120),USE(?String41),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(594,83,521,125),USE(ACC_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING('RS:'),AT(1281,83,177,125),USE(?String64),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1469,83,156,125),USE(RS),FONT(,7,,)
         STRING(@d06.),AT(6854,73,521,125),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(7406,73,417,125),USE(lai),FONT(,7,,,CHARSET:BALTIC)
       END
PAGE_FOOT DETAIL,AT(,,,323)
         LINE,AT(5688,-10,0,271),USE(?Line49:3),COLOR(COLOR:Black)
         LINE,AT(6604,-10,0,271),USE(?Line49:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,271),USE(?Line49:5),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,271),USE(?Line49:6),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line54),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(3594,83,885,156),USE(L2190),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(4510,83,885,156),USE(L2310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(5698,83,885,156),USE(L5210),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n-_13.2b),AT(6615,83,885,156),USE(L5310),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,83,250,156),USE(val_uzsk,,?val_uzsk:4),FONT(,9,,)
         LINE,AT(42,250,7760,0),USE(?Line55),COLOR(COLOR:Black)
         STRING('KOPÂ pa lapu : '),AT(156,83,885,156),USE(?String48),FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4490,-10,0,271),USE(?Line49:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,271),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,271),USE(?Line49),COLOR(COLOR:Black)
       END
PAGE_FOOT1 DETAIL,AT(,,,115),USE(?unnamed:7)
         LINE,AT(52,-10,0,63),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,63),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(5688,0,0,63),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(6604,-10,0,63),USE(?Line54:1),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,63),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(5406,0,0,63),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line56),COLOR(COLOR:Black)
       END
       FOOTER,AT(150,11008,8000,63)
         LINE,AT(52,0,7760,0),USE(?Line48:2),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CLEAR(ATLMAS)
  LocalResponse = RequestCancelled
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  BIND(GGK:RECORD)
  FilesOpened = True
  IF PAR_GRUPA
    FILTRS='Grupa= '&PAR_grupa
  ELSE
    FILTRS='Visi De/Kr'
  .
  FILTRS=CLIP(FILTRS)&' Tips= '&PAR_TIPS
  IF F:NOA
     FILTRS=CLIP(FILTRS)&' bez arhîva'
  .
  IF ACC_KODS_N=0 !ASSAKO
     NR_TEXT='Karte'
  ELSE
     NR_TEXT='U_NR'
  .
  RecordsToProcess = records(ggk)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Norçíini ar '&FILTRS
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS = S_DAT
      GGK:BKK='219'
      CG = 'K1000'
      CP = 'K1101'
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('DEKRVI.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='NORÇÍINI AR PREÈU PIEGÂDÂTÂJIEM / SAÒÇMÇJIEM'
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE=' Npk'&CHR(9)&NR_TEXT&CHR(9)&'Piegâdâtâjs/Saòçmçjs'&CHR(9)&'219** (+)-mums'&CHR(9)&'231** (+)-mums'&|
            CHR(9)&'521** (-)-mçs esam'&CHR(9)&'531** (-)-mçs esam'
            ADD(OUTFILEANSI)
            OUTA:LINE='    '&CHR(9)&NR_TEXT&CHR(9)&filtrs&CHR(9)&'parâdâ preci  '&CHR(9)&'parâdâ naudu  '&CHR(9)&|
            'parâdâ preci      '&CHR(9)&'parâdâ naudu'
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=' Npk'&CHR(9)&NR_TEXT&CHR(9)&'Piegâdâtâjs/Saòçmçjs'&CHR(9)&'219** (+)-mums parâdâ preci'&CHR(9)&|
            '231** (+)-mums parâdâ naudu'&CHR(9)&'521** (-)-mçs esam parâdâ preci'&CHR(9)&'531** (-)-mçs esam parâdâ naudu'
            ADD(OUTFILEANSI)
          END
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEGGK(CG) AND INSTRING(GGK:BKK[1:3],'219231521531',3) AND ~CYCLEPAR_K(CP) AND|
           INRANGE(GGK:DATUMS,S_DAT,B_DAT)
           IF GGK:D_K = 'K'
              GGK:SUMMA  = -GGK:SUMMA
              GGK:SUMMAV = -GGK:SUMMAV
           .
           BKK=GGK:BKK[1:3]
           ACT#=1
           GET(P_TABLE,0)
           LOOP J# = 1 TO RECORDS(P_TABLE)
             GET(P_TABLE,J#)
             IF P:NR=GGK:PAR_NR
               ACT#=2
               BREAK
             .
           .
           IF ACT#=1
             P:P2190 = 0
             P:P2310 = 0
             P:P5210 = 0
             P:P5310 = 0
             P:NR=GGK:PAR_NR
             C#=GETPAR_K(GGK:PAR_NR,2,1)
             P:NOS_A=PAR:NOS_A
           .
           CASE BKK
           OF '219'
             P:P2190 += ggk:summa
             L2190 += ggk:summa
             K2190 += ggk:summa
           OF '231'
             P:P2310 += ggk:summa
             L2310 += ggk:summa
             K2310 += ggk:summa
             IF GGK:D_K = 'D' !MÇS IZRAKSTÎJÂM RÇÍINU
                IF GETGG(GGK:U_NR)
                   K2:KEY=FORMAT(GGK:PAR_NR,@S6)&GG:DOK_SENR
                   K2:APMDAT=GG:APMDAT
                   K2:SUMMA=ggk:summa
                   ADD(K2_TABLE)
                   SORT(K2_TABLE,K2:KEY)
                .
             ELSE             !VIÒI MAKSÂ
                K2:KEY=FORMAT(GGK:PAR_NR,@S6)&GGK:REFERENCE
                GET(K2_TABLE,K2:KEY)
                IF ~ERROR()
                   K2:SUMMA+=ggk:summa
                   PUT(K2_TABLE)
                .
             .
           OF '521'
             P:P5210 += ggk:summa
             L5210 += ggk:summa
             K5210 += ggk:summa
           OF '531'
             P:P5310 += ggk:summa
             L5310 += ggk:summa
             K5310 += ggk:summa
             IF GGK:D_K = 'K' !VIÒI IZRAKSTÎJA RÇÍINU
                IF GETGG(GGK:U_NR)
                   K5:KEY=FORMAT(GGK:PAR_NR,@S6)&GG:DOK_SENR
                   K5:APMDAT=GG:APMDAT
                   K5:SUMMA=ggk:summa
                   ADD(K5_TABLE)
                   SORT(K5_TABLE,K5:KEY)
                .
             ELSE             !MÇS MAKSÂJAM
                K5:KEY=FORMAT(GGK:PAR_NR,@S6)&GGK:REFERENCE
                GET(K5_TABLE,K5:KEY)
                IF ~ERROR()
                   K5:SUMMA+=ggk:summa
                   PUT(K5_TABLE)
                .
             .
           .
           EXECUTE ACT#
             ADD(P_TABLE)
             PUT(P_TABLE)
           .
           !El IF GGK:VAL  <> 'Ls' or GGK:VAL <> 'LVL'
           IF GGK:VAL  <> val_uzsk
             MULTIVALUTAS=TRUE
           .
           VAL_NR=VALNR(GGK:VAL,1)
           IF INRANGE(VAL_NR,1,20)
              CASE BKK
              OF '219'
                 ATLMAS[VAL_NR,1] += ggk:summav
              OF '231'
                 ATLMAS[VAL_NR,2] += ggk:summav
              OF '521'
                 ATLMAS[VAL_NR,3] += ggk:summav
              OF '531'
                 ATLMAS[VAL_NR,4] += ggk:summav
              .
           ELSE
              STOP('VALÛTAS Nr : '&VAL_NR)
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
  dat = today()
  lai = clock()
  SORT(P_TABLE,P:NOS_A)
  GET(P_TABLE,0)
  LOOP J# = 1 TO RECORDS(P_TABLE)
    GET(P_TABLE,J#)
!    IF ~(NR=P:NR)
!      NR=P:NR
!    .
    IF P:NR=0
      NOS_P='Pârçjie'
    ELSE
      NOS_P=GETPAR_K(P:NR,2,2)
    .
    IF ~(P:p2190=0 AND P:p2310=0 AND P:p5210=0 AND P:p5310=0)
      NPK+=1
      IF ACC_KODS_N=0 !ASSAKO
         NR = PAR:KARTE
      ELSE
         NR = P:NR
      .
      p2190=P:p2190
      p2310=P:p2310
      p5210=P:p5210
      p5310=P:p5310
      KAV231=0
      IF P:P2190 > 0
        DK2190+=P:P2190
      ELSE
        KK2190+=ABS(P:P2190)
      .
      IF P:P2310 > 0 !VIÒI IR PARÂDÂ
        DK2310+=P:P2310
        LOOP K#=1 TO RECORDS(K2_TABLE)
           GET(K2_TABLE,K#)
           IF K2:KEY[1:6]=P:NR
              IF K2:SUMMA>0 !ÐITAIS RÇÍIS NAV APMAKSÂTS(PILNÎBÂ)
!                 KAV231=TODAY()-K2:APMDAT
                 KAV231=B_DAT-K2:APMDAT
                 IF KAV231<0 THEN KAV231=0.
                 BREAK
              .
           .
        .
      ELSE
        KK2310+=ABS(P:P2310)
      .
      IF P:P5210 > 0
        DK5210+=P:P5210
      ELSE
        KK5210+=ABS(P:P5210)
      .
      KAV531=0
      IF P:P5310 > 0
        DK5310+=P:P5310
      ELSE !MÇS ESAM PARÂDÂ
        KK5310+=ABS(P:P5310)
        LOOP K#=1 TO RECORDS(K5_TABLE)
           GET(K5_TABLE,K#)
           IF K5:KEY[1:6]=P:NR
              IF K5:SUMMA<0 !ÐITAIS RÇÍIS NAV APMAKSÂTS(PILNÎBÂ)
!                 KAV531=TODAY()-K5:APMDAT
                 KAV531=B_DAT-K5:APMDAT
                 IF KAV531<0 THEN KAV531=0.
                 BREAK
              .
           .
        .
      .
      IF ~F:DTK OR (F:DTK AND P2190>=0 AND P2310>=0 AND P5210<=0 AND P5310<=0)
         IF F:DBF = 'W'
             PRINT(RPT:detail)
         ELSE
             OUTA:LINE=CLIP(NPK)&CHR(9)&CLIP(NR)&CHR(9)&CLIP(NOS_P)&CHR(9)&LEFT(FORMAT(P2190,@N-_13.2))&CHR(9)&|
             LEFT(FORMAT(P2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(P5210,@N-_13.2))&CHR(9)&LEFT(FORMAT(P5310,@N-_13.2))
             ADD(OUTFILEANSI)
         .
      .
    .
  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)
  ELSE
    OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K2190,@N-_13.2))&CHR(9)&LEFT(FORMAT(K2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(K5210,@N-_13.2))&|
               CHR(9)&LEFT(FORMAT(K5310,@N-_13.2))&CHR(9)&val_uzsk
               !El CHR(9)&LEFT(FORMAT(K5310,@N-_13.2))&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='D '&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DK2190,@N-_13.2))&CHR(9)&LEFT(FORMAT(DK2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(DK5210,@N-_13.2))&|
               CHR(9)&LEFT(FORMAT(DK5310,@N-_13.2))&CHR(9)&val_uzsk
               !El CHR(9)&LEFT(FORMAT(DK5310,@N-_13.2))&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
    OUTA:LINE='K '&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KK2190,@N-_13.2))&CHR(9)&LEFT(FORMAT(KK2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(KK5210,@N-_13.2))&|
               CHR(9)&LEFT(FORMAT(KK5310,@N-_13.2))&CHR(9)&val_uzsk
               !El CHR(9)&LEFT(FORMAT(KK5310,@N-_13.2))&CHR(9)&'Ls'
    ADD(OUTFILEANSI)
  END
  IF MULTIVALUTAS=TRUE     !DAÞÂDAS VALÛTAS
     TS ='Tai skaitâ :'
     LOOP I#=1 TO 20
        IF ATLMAS[I#,1] OR ATLMAS[I#,2] OR ATLMAS[I#,3] OR ATLMAS[I#,4]
          kv2190 = ATLMAS[I#,1]
          kv2310 = ATLMAS[I#,2]
          kv5210 = ATLMAS[I#,3]
          kv5310 = ATLMAS[I#,4]
          kvnos  = VALNR(I#,2)
          IF F:DBF = 'W'
            PRINT(RPT:RPT_FOOTV)
          ELSE
            OUTA:LINE=CLIP(TS)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KV2190,@N-_13.2))&CHR(9)&LEFT(FORMAT(KV2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(KV5210,@N-_13.2))&|
                      CHR(9)&LEFT(FORMAT(KV5310,@N-_13.2))&CHR(9)&KVNOS
            ADD(OUTFILEANSI)
          END
          ts = ''
        .
     .
  .
  PRINT(RPT:RPT_FOOT1)
  ENDPAGE(report)
  CLOSE(ProgressWindow)
  FREE(VALTABLE)
  FREE(P_TABLE)
  FREE(K2_TABLE)
  FREE(K5_TABLE)
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
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
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(P_TABLE)
  POPBIND
  RETURN
!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT
!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:BKK[1:3]>'531'
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
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
      ?Progress:PctText{Prop:Text} =  'analizçti '&FORMAT(PercentProgress,@N3) &'% no DB'
      DISPLAY()
    END
  END
