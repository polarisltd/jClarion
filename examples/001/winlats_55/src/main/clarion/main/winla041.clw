                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_ZurnalsVKVP        PROCEDURE                    ! Declare Procedure
atlmas               DECIMAL(10,2),DIM(20,5)
RejectRecord         LONG
EOF                  BYTE
CG                   STRING(10)
CP                   STRING(3)

VIRSRAKSTS           STRING(90)
FILTRS_TEXT          STRING(100)

SAV_VAL              STRING(3)
VAL_NR               BYTE
MULTIVALUTAS         BYTE
BRIDINAJUMS19        BYTE
JADRUKA_SALDO        BYTE
JADRUKA_SAK_APGROZ   BYTE
IZDRUKATS_SAK_APGROZ BYTE
VAL_VAL              STRING(3)
NGG                  STRING(5)
DATUMS               LONG
PARTNER              STRING(15)
SATURS               CSTRING(240)   !
SATURS1              STRING(40)
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
!   RPT_FOOT1 DETAIL
DAT                  LONG
LAI                  TIME
LDEB                 DECIMAL(14,2)
LKRE                 DECIMAL(14,2)
LATL                 DECIMAL(14,2)
!- - - - - - - - - - - - - - - - - - -
DEB1                 DECIMAL(14,2)
KRE1                 DECIMAL(14,2)
!- - - - - - - - - - - - - - - - - - -
LINEH                STRING(190)
PAR_REG_NR           STRING(13)
NORADE               STRING(25)

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

report REPORT,AT(145,1475,8021,9563),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',,,,CHARSET:BALTIC), |
         THOUS                          !177*54RINDAS=9560
       HEADER,AT(145,104,8000,1365),USE(?unnamed:3)
         LINE,AT(5052,885,0,469),USE(?Line59:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1563,260,4427,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Partneris '),AT(2344,1042,938,208),USE(?String30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(417,490,6719,156),USE(VIRSRAKSTS),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7188,521,625,208),PAGENO,USE(?PageCount),RIGHT,FONT(,,,,CHARSET:BALTIC)
         STRING(@s100),AT(469,677,6615,208),USE(filtrs_text),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5521,885,0,469),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(52,885,0,469),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(417,885,0,469),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(1354,885,0,469),USE(?Line5),COLOR(COLOR:Black)
         STRING('Nr'),AT(104,938,313,208),USE(?String15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(469,938,885,208),USE(?String16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('P '),AT(1927,1042,156,208),USE(?String15:2),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('N'),AT(2167,1042,104,208),USE(?String15:3),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1833,885,0,469),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(2135,885,0,469),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('Atlikums no'),AT(7031,938,938,208),USE(?String21),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1365,1042,469,208),USE(?String17),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieraksta saturs'),AT(3333,1042,1719,208),USE(?String18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(5104,1042,365,208),USE(?String23:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(5573,1042,625,208),USE(?String19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(6302,1042,677,208),USE(?String20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('gada sâkuma'),AT(7031,1146,938,208),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,885,0,469),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(6250,885,0,469),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(6979,885,0,469),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7969,885,0,469),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(3281,885,0,469),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Numurs'),AT(469,1146,885,208),USE(?String24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('GG'),AT(104,1146,313,208),USE(?String23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1354,7917,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(52,885,7917,0),USE(?Line1),COLOR(COLOR:Black)
       END
atlikums_Ls DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,-10,0,197),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,197),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line37:5),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line37:6),COLOR(COLOR:Black)
         STRING('Atlikums uz'),AT(167,10,573,156),USE(?String62)
         LINE,AT(5521,-10,0,197),USE(?Line37:4),COLOR(COLOR:Black)
         STRING(@D06.),AT(844,10,615,156),USE(DATUMS),CENTER
         STRING(@s7),AT(1563,10,677,156),USE(ST),CENTER
         STRING(@n-14.2b),AT(7010,10,677,156),USE(atl,,?atl:2),RIGHT(1)
         LINE,AT(6250,-10,0,197),USE(?Line37:3),COLOR(COLOR:Black)
         STRING(@s3),AT(7708,10,240,156),USE(val_uzsk),CENTER
       END
atlikums_val DETAIL,AT(,,,177),USE(?unnamed:8)
         LINE,AT(52,-10,0,197),USE(?Line53:18),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line58:3),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,197),USE(?Line58:2),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,2969,156),USE(ts),LEFT
         STRING(@s3),AT(7698,10,260,156),USE(VAL_VAL,,?VAL_VAL:3),CENTER
         LINE,AT(6979,-10,0,197),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line53:15),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line58:4),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(7010,10,677,156),USE(atlV),RIGHT
       END
linija DETAIL,AT(,,,0),USE(?unnamed:6)
         LINE,AT(52,0,7917,0),USE(?Line57),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8021,177),USE(?unnamed)
         LINE,AT(6979,-10,0,197),USE(?Line53:28),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line53:34),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,197),USE(?Line53:27),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line53:29),COLOR(COLOR:Black)
         LINE,AT(1833,-10,0,197),USE(?Line53:31),COLOR(COLOR:Black)
         STRING(@N_6b),AT(1865,0,260,156),USE(GGK:OBJ_NR),TRN,RIGHT
         LINE,AT(2135,-10,0,197),USE(?Line53:3),COLOR(COLOR:Black)
         STRING(@S2),AT(2156,10,208,156),USE(GGK:NODALA),TRN,LEFT
         LINE,AT(1354,-10,0,197),USE(?Line53:32),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line53:33),COLOR(COLOR:Black)
         STRING(@d05.),AT(1385,10,438,156),USE(DATUMS,,?DATUMS:2),LEFT(1)
         STRING(@N_5B),AT(104,10,313,156),USE(NGG),CENTER
         STRING(@S14),AT(448,10,885,156),USE(GG:DOK_SENR),RIGHT(1)
         STRING(@N-14.2B),AT(5552,10,677,156),USE(DEB),RIGHT
         STRING(@N-14.2B),AT(6281,10,677,156),USE(KRE),RIGHT
         STRING(@n-14.2b),AT(7010,10,677,156),USE(atl),RIGHT(1)
         STRING(@s3),AT(7719,10,240,156),USE(val_uzsk,,?val_uzsk:2),CENTER
         LINE,AT(5521,-10,0,197),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(3281,-10,0,197),USE(?Line53:30),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line53:39),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,197),USE(?Line53:2),COLOR(COLOR:Black)
         STRING(@s6),AT(5104,10,417,156),USE(ggk:bkk),LEFT
         STRING(@s40),AT(3313,10,1719,156),USE(SATURS),LEFT
         STRING(@s15),AT(2323,10,938,156),USE(PARTNER,,?PARTNER:2)
       END
detailv DETAIL,AT(,,8021,177),USE(?unnamed:2)
         STRING(@s4),AT(1490,10,313,156),USE(ts0)
         STRING(@s40),AT(3313,10,1719,156),USE(SATURS1),LEFT
         LINE,AT(5521,-10,0,197),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,197),USE(?Line53:13),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,197),USE(?Line53:16),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(5552,10,677,156),USE(debV),RIGHT
         STRING(@n-14.2b),AT(6281,10,677,156),USE(kreV),RIGHT
         STRING(@n-14.2b),AT(7010,10,677,156),USE(atlv,,?atlv:2),RIGHT
         STRING(@s3),AT(7698,10,260,156),USE(VAL_VAL),CENTER(1)
         LINE,AT(2135,-10,0,197),USE(?Line53:4),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,197),USE(?Line53:5),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line53:17),COLOR(COLOR:Black)
         LINE,AT(3281,-10,0,197),USE(?Line53:11),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line53:7),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line53:8),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line53:10),COLOR(COLOR:Black)
         LINE,AT(1833,-10,0,197),USE(?Line53:12),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line53:45),COLOR(COLOR:Black)
       END
Apgrozijums_Ls DETAIL,AT(,,,177),USE(?unnamed:9)
         LINE,AT(52,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         STRING(@s50),AT(990,10,3385,156),USE(APGRTEXT),LEFT(3)
         LINE,AT(6979,-10,0,197),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,197),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line66),COLOR(COLOR:Black)
         STRING(@n-14.2),AT(5552,10,677,156),USE(debapg),RIGHT
         STRING(@n-14.2),AT(6281,10,677,156),USE(kreapg),RIGHT
         STRING(@n-14.2),AT(7010,10,677,156),USE(apg),RIGHT
         STRING(@s3),AT(7708,10,229,156),USE(val_uzsk,,?val_uzsk:3),CENTER
         STRING('Apgrozîjums  '),AT(156,10,688,156),USE(?String57),LEFT
       END
apgrozijums_val DETAIL,AT(,,,177)
         LINE,AT(5052,-10,0,197),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,197),USE(?Line53:20),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,197),USE(?Line53:21),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,197),USE(?Line53:19),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line63:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line53:23),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,2917,156),USE(ts,,?ts:2),LEFT
         STRING(@n-14.2b),AT(5552,10,677,156),USE(debapgv),RIGHT
         STRING(@n-14.2b),AT(6281,10,677,156),USE(kreapgv),RIGHT
         STRING(@n-14.2b),AT(7010,10,677,156),USE(apgv),RIGHT
         STRING(@s3),AT(7698,10,260,156),USE(VAL_VAL,,?VAL_VAL:2),CENTER
       END
RPT_FOOT DETAIL,AT(,,,240),USE(?unnamed:5)
         LINE,AT(52,-10,0,63),USE(?Line54:28),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line54:26),COLOR(COLOR:Black)
         LINE,AT(52,52,7917,0),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(7969,-10,0,63),USE(?Line54:27),COLOR(COLOR:Black)
         STRING('Sastâdîja  :'),AT(63,73),USE(?String64),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(531,73),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS  :'),AT(1313,73),USE(?String66),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@S1),AT(1531,73),USE(rS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(6250,-10,0,63),USE(?Line61),COLOR(COLOR:Black)
         STRING(@d06.),AT(6875,73),USE(dat),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(7510,73),USE(lai),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(5521,-10,0,63),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line65),COLOR(COLOR:Black)
       END
       FOOTER,AT(145,11035,8000,10),USE(?unnamed:7) !11035=9560+1475
         LINE,AT(52,0,7917,0),USE(?Line48:3),COLOR(COLOR:Black)
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
!  Þurnâls visiem partneriem pa kontu grupu
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  VIRSRAKSTS='Kontu grupa: '& CLIP(KKK) &' '&CLIP(GETKON_K(KKK,0,7))&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  FILTRS_TEXT=''
  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&par_grupa.
  IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
  IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
  IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF GG::Used = 0           !DÇÏ GETGG
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  BIND(PAR:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('kkk',kkk)
  BIND('cyclebkk',cyclebkk)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)

  BRIDINAJUMS19=FALSE
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  SAV_VAL=''

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(ggk:record)
!      GGK:DATUMS = DATE(1,1,GADS)
!      GGK:DATUMS = DATE(1,1,YEAR(S_DAT))
      GGK:DATUMS = DB_S_DAT
      CG = 'K100011'
      CP = 'K11'
      SET(GGK:DAT_key,GGK:DAT_key)  !Lai izdrukâ ir datumu sacîbâ
      Process:View{Prop:Filter} ='~CYCLEGGK(CG) AND ~cyclebkk(ggk:bkk,kkk) AND ~CYCLEPAR_K(CP)'
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
      TS=''
      ST=''
      DEBAPGS=0
      KREAPGS=0
      DEBAPG=0
      KREAPG=0
      ATL=0
      MULTIVALUTAS=FALSE
      JADRUKA_SAK_APGROZ=FALSE
      IZDRUKATS_SAK_APGROZ=FALSE
      JADRUKA_SALDO=FALSE
      CLEAR(ATLMAS)
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('ZURNVKVP.TXT')
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
          'Partneris'&CHR(9)&'Reì. Nr.'&CHR(9)&'Ieraksta saturs'&CHR(9)&'Konts'&CHR(9)&'Debets'&CHR(9)&'Kredîts'&CHR(9)&|
          'Atlikums no finansu gada sâkuma'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         npk#+=1
         ?Progress:UserString{Prop:Text}=NPK#
         DISPLAY(?Progress:UserString)
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
                     KLUDA(0,'Pârâk daudz valûtu, nebûs pareizi "tai skaitâ.."')
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
    ELSIF F:DBF='E'
        !OUTA:LINE='Apgrozîjums'&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Apgrozîjums'&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
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
                !VAL_VAL='Ls'
                VAL_VAL=val_uzsk
                TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'
             ELSE
                VAL_VAL=VALNR(I#,2)
             .
             IF F:DBF='W'
                PRINT(RPT:apgrozijums_VAL)
             ELSE
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
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
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
        LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
!El        LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
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
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2))&|
                CHR(9)&LEFT(FORMAT(KREAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
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
        !El OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS=TRUE
       TS='tai skaitâ'
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
                 OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                 ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    DAT = TODAY()
    LAI = CLOCK()
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
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
    IF GGK:U_NR > 1 AND JADRUKA_SALDO=TRUE
!       DATUMS = DATE(1,1,GL:DB_GADS)
       DATUMS = DATE(1,1,YEAR(S_DAT))
       ST='(Saldo)'
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS=TRUE
          TS='tai skaitâ'
          LOOP I#=1 TO 10
             IF ATLMAS[I#,1]
                ATLV=ATLMAS[I#,1]
                VAL_VAL=VALNR(I#,2)
                IF F:DBF='W'
                    PRINT(RPT:Atlikums_Val)
                ELSE
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
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
    IF GGK:DATUMS >= S_DAT AND JADRUKA_SAK_APGROZ=TRUE AND IZDRUKATS_SAK_APGROZ=FALSE
       DATUMS=S_DAT-1
       ST=''
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Atlikums uz'&CHR(9)&format(DATUMS,@D06.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
           ADD(OUTFILEANSI)
       END
       IF MULTIVALUTAS=TRUE
          TS='tai skaitâ'
          LOOP I#=1 TO 10
             IF ATLMAS[I#,1]
                ATLV=ATLMAS[I#,1]
                VAL_VAL=VALNR(I#,2)
                IF F:DBF='W'
                    PRINT(RPT:Atlikums_Val)
                ELSE
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                    ADD(OUTFILEANSI)
                END
                TS=''
             .
          .
       .
       JADRUKA_SAK_APGROZ=FALSE
       IZDRUKATS_SAK_APGROZ=TRUE
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
      IF GETGG(GGK:U_NR)
         DATUMS = GG:DATUMS
         IF ~(GG:PAR_NR=GGK:PAR_NR)
            TEKSTS = CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
         ELSE
            TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
         .
         IF F:DBF='W' OR F:DBF='E' !WMF,EXCEL
            FORMAT_TEKSTS(44,'Arial',8,'')
            SATURS = F_TEKSTS[1]
         ELSE !A-WORD
            SATURS = TEKSTS  !DODAM VISU VIENÂ RINDÂ
            CLEAR(F_TEKSTS)
         .
      ELSE
         DATUMS =GGK:DATUMS
         SATURS='GG NAV ATRASTS....'
      .
      NGG    =GGK:U_NR
      IF GGK:PAR_NR=0
         PARTNER=GG:NOKA
      ELSE
         NORADE=FORMAT(GG:DATUMS,@D06.)&' GG_U_Nr='&GGK:U_NR
         PARTNER=GETPAR_K(GGK:PAR_NR,2,1,,NORADE)
      .
!      IF SUB(GGK:BKK,1,4)=SUB(SYS:BKK_PVN,1,4)       ! PVN KONTS
!         IF GGK:PVN_TIPS
!            SATURS[43]=FORMAT(GGK:PVN_TIPS,@N1B)
!         .
!         SATURS[44:45]=FORMAT(GGK:PVN_PROC,@S2)
!      .

      IF F:DBF='W'
        PRINT(RPT:DETAIL)     !1.RINDA WMF
      ELSE                    !EXCEL,A-WORD
        NORADE=FORMAT(GG:DATUMS,@D06.)&' GG_U_Nr='&GGK:U_NR
        PAR_REG_NR=GETPAR_K(GGK:PAR_NR,0,8,,NORADE)
        !El OUTA:LINE=FORMAT(NGG,@N_5B)&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&PARTNER&CHR(9)&PAR_REG_NR&CHR(9)&SATURS&CHR(9)&GGK:BKK&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE=FORMAT(NGG,@N_5B)&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&PARTNER&CHR(9)&PAR_REG_NR&CHR(9)&SATURS&CHR(9)&GGK:BKK&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
      .
      !Elya 01/12/2013 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
      IF ~(GGK:VAL=val_uzsk)
         TS0='t.s.'
         SATURS1=F_TEKSTS[2]  !1.1 RINDA, WORDAM VISI F_TEKSTS[] CLEARED
         val_VAL=GGK:VAL
         atlv = ATLMAS[VAL_NR,1]
         IF F:DBF='W'
           PRINT(RPT:DETAILV) !+1.1.RINDA VALÛTÂ
         ELSE                 !WORD, EXCEL
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         .
      ELSIF F_TEKSTS[2]       !2.RINDA WMF,EXCEL
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         SATURS1=F_TEKSTS[2]
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
      TS0='    '
      IF F_TEKSTS[3]          !3.RINDA WMF,EXCEL
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         SATURS1=F_TEKSTS[3]
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
             OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         .
      .
    .
   PRTEXT# = 0

!-------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:DATUMS>B_DAT
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
      ?Progress:PctText{Prop:Text} =FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
VALNR                FUNCTION (VALUTA,OPC)        ! Declare Procedure
  CODE                                            ! Begin processed code
 CASE OPC
 OF 0
    FREE(VALTABLE)
 OF 1
    V:VAL=VALUTA
    GET(VALTABLE,V:VAL)
    IF ERROR()
       V:NR=RECORDS(VALTABLE)+1
       ADD(VALTABLE)
       SORT(VALTABLE,V:VAL)
    .
    RETURN(V:NR)
 OF 2
    LOOP I#= 1 TO RECORDS(VALTABLE)
!       STOP(V:VAL&' '&V:NR)
       GET(VALTABLE,I#)
       IF V:NR=VALUTA     !NODODAM VAL_NR
          RETURN(V:VAL)
       .
    .
 ELSE
   STOP('OPC:'&OPC)
 .
 RETURN('')


B_Zurnals1KVP        PROCEDURE                    ! Declare Procedure
ATLMAS               DECIMAL(10,2),DIM(20,5)
RejectRecord         LONG
EOF                  BYTE
CG                   STRING(10)
CP                   STRING(3)
FILTRS_TEXT          STRING(200)
SAV_VAL              STRING(3)
VAL_NR               BYTE
MULTIVALUTAS         BYTE
BRIDINAJUMS19        BYTE
JADRUKA_SALDO        BYTE
JADRUKA_SAK_APGROZ   BYTE
VAL_VAL              STRING(3)
VIRSRAKSTS           STRING(90)
NGG                  STRING(5)
DATUMS               LONG
PARTNER              STRING(15)
SATURS               CSTRING(247)
SATURS1              STRING(47)
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
NS                   STRING(12)
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

N_TABLE            QUEUE,PRE(N)
NODALA               STRING(2)
DEB                  DECIMAL(12,2)
KRE                  DECIMAL(12,2)
                   .

N_ATL                DECIMAL(12,2)
LINEH                STRING(190)
PAR_REG_NR           STRING(13)

LocalRequest         LONG
LocalResponse        LONG
ggk_u_nr             LONG
rakstsggk            byte
FilesOpened          LONG
WindowOpened         LONG

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:VAL)
                     END
                               
report REPORT,AT(146,1680,8021,9406),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,104,8000,1552),USE(?unnamed:8)
         STRING(@s45),AT(1719,313,4375,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(1052,573,5729,208),USE(VIRSRAKSTS),CENTER(2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Partneris '),AT(2323,1198,990,208),USE(?String30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s200),AT(42,833,7760,208),USE(FILTRS_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7188,563,573,208),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(0,1042,0,521),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(365,1042,0,521),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(1302,1042,0,521),USE(?Line5),COLOR(COLOR:Black)
         STRING('Nr'),AT(42,1094,313,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(396,1094,885,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums no'),AT(6979,1094,990,208),USE(?String21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1333,1198,469,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR'),AT(1865,1198,208,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('N'),AT(2104,1198,188,208),USE(?String17:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,1042,0,521),USE(?Line6:4),COLOR(COLOR:Black)
         LINE,AT(2083,1042,0,521),USE(?Line6:3),COLOR(COLOR:Black)
         STRING('Ieraksta saturs'),AT(3365,1198,2135,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(5552,1198,677,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(6250,1198,677,208),USE(?String20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gada sâkuma'),AT(6979,1302,990,208),USE(?String22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1823,1042,0,521),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(5521,1042,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(6229,1042,0,521),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(6938,1042,0,521),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(8021,1042,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(3333,1042,0,521),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Numurs'),AT(396,1302,885,208),USE(?String24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('GG'),AT(42,1302,313,208),USE(?String23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(0,1563,8021,0),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(0,1042,8021,0),USE(?Line1),COLOR(COLOR:Black)
       END
atlikums_Ls DETAIL,AT(,,,177),USE(?unnamed:7)
         LINE,AT(0,-10,0,197),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,197),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line37:5),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line37:4),COLOR(COLOR:Black)
         STRING('Konta atlikums uz '),AT(156,10,1146,156),USE(?String61),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(1323,10,615,156),USE(DATUMS),CENTER
         STRING(@s7),AT(2083,10,490,156),USE(ST),CENTER
         STRING(@n-14.2),AT(6958,10,688,156),USE(atl,,?atl:2),RIGHT(1)
         LINE,AT(6229,-10,0,197),USE(?Line37:3),COLOR(COLOR:Black)
         STRING(@s3),AT(7667,10,260,156),USE(val_uzsk),CENTER
       END
atlikums_val DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(0,-10,0,197),USE(?Line53:18),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line58:3),COLOR(COLOR:Black)
         LINE,AT(6229,-10,0,197),USE(?Line58:2),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,3385,156),USE(ts),LEFT
         STRING(@s3),AT(7667,10,260,156),USE(VAL_VAL,,?VAL_VAL:3),CENTER
         LINE,AT(6938,-10,0,197),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line53:15),COLOR(COLOR:Black)
         STRING(@n-14.2),AT(6958,10,688,156),USE(atlV),RIGHT
       END
linija DETAIL,AT(,,,0),USE(?unnamed)
         LINE,AT(0,0,8021,0),USE(?Line57),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8021,177),USE(?unnamed:4)
         LINE,AT(6938,-10,0,197),USE(?Line53:5),COLOR(COLOR:Black)
         LINE,AT(0,-10,0,197),USE(?Line53:9),COLOR(COLOR:Black)
         LINE,AT(6229,-10,0,197),USE(?Line53:25),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line53:24),COLOR(COLOR:Black)
         LINE,AT(1823,-10,0,197),USE(?Line53:3),COLOR(COLOR:Black)
         LINE,AT(1302,-10,0,197),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@d05.),AT(1354,10,438,156),USE(DATUMS,,?DATUMS:2),LEFT(1)
         STRING(@N_5B),AT(52,10,313,156),USE(NGG),CENTER
         STRING(@S14),AT(396,10,885,156),USE(GG:DOK_SENR),RIGHT(1)
         STRING(@s15),AT(2323,10,990,156),USE(PARTNER,,?PARTNER:2),LEFT
         STRING(@N-14.2B),AT(5542,10,677,156),USE(DEB),RIGHT
         STRING(@N-14.2B),AT(6250,10,677,156),USE(KRE),RIGHT
         STRING(@n-14.2b),AT(6958,10,688,156),USE(atl),RIGHT(1)
         STRING(@s3),AT(7667,10,260,156),USE(val_uzsk,,?val_uzsk:2),CENTER
         LINE,AT(3333,-10,0,197),USE(?Line53:4),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line53:6),COLOR(COLOR:Black)
         STRING(@s2),AT(2135,10,200,156),USE(GGK:NODALA),TRN,LEFT
         STRING(@N3B),AT(1865,10,200,156),USE(GGK:OBJ_NR),RIGHT
         LINE,AT(2083,-10,0,197),USE(?Line53:26),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,197),USE(?Line53:28),COLOR(COLOR:Black)
         STRING(@s47),AT(3365,10,2135,156),USE(SATURS),LEFT
       END
detailv DETAIL,AT(,,8021,177),USE(?unnamed:9)
         STRING(@s4),AT(1458,10,313,156),USE(ts0)
         STRING(@s47),AT(3365,10,2135,156),USE(SATURS1),LEFT
         LINE,AT(6229,-10,0,197),USE(?Line53:13),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,197),USE(?Line53:16),COLOR(COLOR:Black)
         STRING(@n-14.2b),AT(5542,10,677,156),USE(debV),RIGHT
         STRING(@n-14.2b),AT(6250,10,677,156),USE(kreV),RIGHT
         STRING(@n-14.2b),AT(6958,10,688,156),USE(atlv,,?atlv:2),RIGHT
         STRING(@s3),AT(7667,10,260,156),USE(VAL_VAL),CENTER
         LINE,AT(8021,-10,0,197),USE(?Line53:17),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,197),USE(?Line53:29),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,197),USE(?Line53:11),COLOR(COLOR:Black)
         LINE,AT(0,-10,0,197),USE(?Line53:7),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,197),USE(?Line53:8),COLOR(COLOR:Black)
         LINE,AT(1302,-10,0,197),USE(?Line53:10),COLOR(COLOR:Black)
         LINE,AT(1823,-10,0,197),USE(?Line53:12),COLOR(COLOR:Black)
         LINE,AT(2083,-10,0,197),USE(?Line53:27),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line53:14),COLOR(COLOR:Black)
       END
Apgrozijums_Ls DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(0,-10,0,197),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line34:4),COLOR(COLOR:Black)
         STRING(@s50),AT(990,10,3385,156),USE(APGRTEXT),LEFT(3)
         LINE,AT(6938,-10,0,197),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(6229,-10,0,197),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line35:6),COLOR(COLOR:Black)
         STRING(@n-14.2),AT(5542,10,677,156),USE(debapg),RIGHT
         STRING(@n-14.2),AT(6250,10,677,156),USE(kreapg),RIGHT
         STRING(@n-14.2),AT(6958,10,688,156),USE(apg),RIGHT
         STRING(@s3),AT(7667,10,260,156),USE(val_uzsk,,?val_uzsk:3),CENTER
         STRING('Apgrozîjums  '),AT(156,10,,156),USE(?String57),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
apgrozijums_val DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(5521,-10,0,197),USE(?Line53:22),COLOR(COLOR:Black)
         LINE,AT(6229,-10,0,197),USE(?Line53:20),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,197),USE(?Line53:21),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line53:19),COLOR(COLOR:Black)
         LINE,AT(0,-10,0,197),USE(?Line53:23),COLOR(COLOR:Black)
         STRING(@s45),AT(156,10,3177,156),USE(ts,,?ts:3),LEFT
         STRING(@n-14.2b),AT(5542,10,677,156),USE(debapgv),RIGHT
         STRING(@n-14.2b),AT(6250,10,677,156),USE(kreapgv),RIGHT
         STRING(@n-14.2b),AT(6958,10,688,156),USE(apgv),RIGHT
         STRING(@s3),AT(7667,10,260,156),USE(VAL_VAL,,?VAL_VAL:2),CENTER
       END
apgrozijums_N DETAIL,AT(,,,177)
         LINE,AT(5521,-10,0,197),USE(?Line56:22),COLOR(COLOR:Black)
         LINE,AT(6229,-10,0,197),USE(?Line56:20),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,197),USE(?Line56:21),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,197),USE(?Line56:19),COLOR(COLOR:Black)
         STRING(@s12),AT(1094,10,938,156),USE(NS),LEFT
         LINE,AT(0,-10,0,197),USE(?Line56:23),COLOR(COLOR:Black)
         STRING(@s12),AT(156,10,938,156),USE(ts,,?ts:2),LEFT
         STRING(@n-14.2b),AT(5542,10,677,156),USE(N:deb),RIGHT
         STRING(@n-14.2b),AT(6250,10,677,156),USE(N:kre),RIGHT
         STRING(@n-14.2b),AT(6958,10,690,156),USE(N_ATL),RIGHT
         STRING(@s3),AT(7667,10,260,156),USE(val_uzsk,,?val_uzsk:4),CENTER
       END
RPT_FOOT DETAIL,AT(,,,250),USE(?unnamed:2)
         LINE,AT(0,-10,0,63),USE(?Line54:28),COLOR(COLOR:Black)
         LINE,AT(6938,-10,0,63),USE(?Line54:26),COLOR(COLOR:Black)
         LINE,AT(0,52,8021,0),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(8021,-10,0,63),USE(?Line54:27),COLOR(COLOR:Black)
         STRING('Sastâdîja  :'),AT(31,73,573,156),USE(?String64),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(604,73,521,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS  :'),AT(1281,73,313,156),USE(?String66),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@S1),AT(1542,73,188,156),USE(rS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(6229,-10,0,63),USE(?Line61),COLOR(COLOR:Black)
         STRING(@d06.),AT(6833,73,625,156),USE(dat),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(7510,73,458,156),USE(lai),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(5521,-10,0,63),USE(?Line62),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11000,8000,0),USE(?unnamed:10) !11062=(1680+177*53+1=9382) DOMÂJU, VISU NOJAUC TAS -10,TÂPÇC PIEMETU 20 REPORTAM
         LINE,AT(0,0,8021,0),USE(?Line48:3),COLOR(COLOR:Black) !APNIKA DIRSTIES,PACÇLU UZ AUGÐU FOOTERI
       END
     END
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
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
!  Þurnâls konkrçtam kontam pa visiem partneriem vai partneru grupu
!
!

  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF GG::Used = 0           !DÇÏ GETGG
    CheckOpen(GG,1)
  END
  GG::Used += 1
  FilesOpened = True

  BIND(GGK:RECORD)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  BRIDINAJUMS19=FALSE
  SAV_VAL=''
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
  IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Tips: '&par_Tips.
  IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PAR::Grupa: '&par_grupa.
  IF F:PVN_P THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' PVN %: '&F:PVN_P.
  IF F:PVN_T THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'PVN tips: '&F:PVN_T.
  VIRSRAKSTS=KKK &':'& CLIP(GETKON_K(KKK,0,2))&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  TS=''
  ST=''

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
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
      CP = 'K11'
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      Process:View{Prop:Filter} ='~CYCLEGGK(CG) AND ~CYCLEPAR_K(CP)'
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
      DEBAPGS=0
      KREAPGS=0
      DEBAPG=0
      KREAPG=0
      ATL=0
      MULTIVALUTAS=FALSE
      JADRUKA_SAK_APGROZ=FALSE
      JADRUKA_SALDO=FALSE
      CLEAR(ATLMAS)
      IF F:DBF='W'
         OPEN(report)
         report{Prop:Preview} = PrintPreviewImage
      ELSE
         IF ~OPENANSI('ZURNALS.TXT')
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
         'Partneris'&CHR(9)&'Reì.Nr.'&CHR(9)&'Ieraksta saturs'&CHR(9)&'Debets'&CHR(9)&'Kredîts'&CHR(9)&|
         'Atlikums no finansu gada sâkuma'
         ADD(OUTFILEANSI)
      .
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
            DEBV =GGK:SUMMAV
            KRE  =0
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
                     KLUDA(0,'Pârâk daudz valûtu, nebûs pareizi "tai skaitâ.."')
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
            N:NODALA=GGK:NODALA
            GET(N_TABLE,N:NODALA)
            IF ERROR()
               N:DEB=DEB
               N:KRE=KRE
               ADD(N_TABLE)
               SORT(N_TABLE,N:NODALA)
            ELSE
               N:DEB+=DEB
               N:KRE+=KRE
               PUT(N_TABLE)
            .
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
  LAI = CLOCK()
  DAT = TODAY()
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:linija)
    ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    APGRTEXT= 'periodâ : '&format(s_dat,@D06.)&'-'&format(b_dat,@D06.)
    apg=debapg-kreapg
    IF F:DBF='W'
        PRINT(RPT:apgrozijums_Ls)
    ELSE
        !El OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
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
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREAPGV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
                ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    IF RECORDS(N_TABLE)>1
       IF F:DBF='W'
           PRINT(RPT:linija)
       ELSIF F:DBF='E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
       END
       TS='tai skaitâ'
       LOOP I#=1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          N_ATL=N:DEB-N:KRE
          NS=n:nodala&' nodaïa'
          IF F:DBF='W'
             PRINT(RPT:apgrozijums_N)
          ELSE
             !El OUTA:LINE=TS&CHR(9)&NS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(N:DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(N:KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(N_ATL,@N-_14.2))&CHR(9)&'Ls'
             OUTA:LINE=TS&CHR(9)&NS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(N:DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(N:KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(N_ATL,@N-_14.2))&CHR(9)&val_uzsk
             ADD(OUTFILEANSI)
          END
          TS=''
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
        OUTA:LINE='Apgrozîjums '&APGRTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
        LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&val_uzsk
        !El LEFT(FORMAT(DEBAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREAPG,@N-_14.2))&CHR(9)&LEFT(FORMAT(APG,@N-_14.2))&CHR(9)&'Ls'
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
                OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DEBAPGV,@N-_14.2))&|
                CHR(9)&LEFT(FORMAT(KREAPGV,@N-_14.2))&CHR(9)&LEFT(FORMAT(APGV,@N-_14.2))&CHR(9)&VAL_VAL
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
        !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        ADD(OUTFILEANSI)
    END
    IF MULTIVALUTAS
       TS='tai skaitâ'
       LOOP I#=1 TO 20
          IF ATLMAS[I#,1]
             ATLV=ATLMAS[I#,1]
             IF I#=20        !IEZAKS
                !El VAL_VAL='Ls'
                VAL_VAL=val_uzsk
                TS='     ieòçmumi/zaudçjumi no kursu svârstîbâm'   !45
             ELSE
                VAL_VAL=VALNR(I#,2)
             .
             IF F:DBF='W'
                 PRINT(RPT:Atlikums_Val)
             ELSE
                 OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
                 ADD(OUTFILEANSI)
             END
             TS=''
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT)                           
        ENDPAGE(report)
    ELSIF F:DBF='E'
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(N_TABLE)
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
    IF GGK:U_NR > 1 AND JADRUKA_SALDO=TRUE
!       DATUMS = DATE(1,1,GL:DB_GADS)
       DATUMS = DATE(1,1,YEAR(S_DAT))
       ST='(Saldo)'
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
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
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
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
    IF GGK:DATUMS >= S_DAT AND JADRUKA_SAK_APGROZ=TRUE !PIRMS DRUKÂT ÐO
       DATUMS=S_DAT-1
       ST=''
       IF F:DBF='W'
           PRINT(RPT:Atlikums_Ls)
       ELSE
           !El OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
           OUTA:LINE='Konta atlikums uz'&CHR(9)&format(DATUMS,@D6.)&CHR(9)&ST&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
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
                    OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2))&CHR(9)&VAL_VAL
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
   IF (GGK:DATUMS >= S_DAT AND GGK:U_NR>1)
      G#=GETGG(GGK:U_NR)
      NGG    =GGK:U_NR
      DATUMS =GGK:DATUMS
      IF ~(GG:PAR_NR=GGK:PAR_NR)
         TEKSTS = CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
      ELSE
         TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
      .
      IF GGK:PAR_NR=0
         PARTNER=GG:NOKA
      ELSE
         PARTNER=GETPAR_K(GGK:PAR_NR,2,1,GGK:DATUMS)
      .
!      FORMAT_TEKSTS(55,'Arial',8,'')
!      SATURS = F_TEKSTS[1]  !1.rinda

      IF F:DBF='W' OR F:DBF='E' !WMF,EXCEL
         FORMAT_TEKSTS(55,'Arial',8,'')
         SATURS = F_TEKSTS[1]
      ELSE !A-WORD
         SATURS = TEKSTS  !DODAM VISU VIENÂ RINDÂ
         CLEAR(F_TEKSTS)
      .

      IF F:DBF='W'
        PRINT(RPT:DETAIL)
      ELSE
        PAR_REG_NR=GETPAR_K(GGK:PAR_NR,0,8)
        OUTA:LINE=NGG&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&GGK:OBJ_NR&CHR(9)&GGK:NODALA&CHR(9)&|
        PARTNER&CHR(9)&PAR_REG_NR&CHR(9)&SATURS&CHR(9)&LEFT(FORMAT(DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(KRE,@N-_14.2))&|
        CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&val_uzsk
        !El CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
      END
      SATURS1 = F_TEKSTS[2] !2.rinda
      !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
      IF ~(GGK:VAL=val_uzsk)
         TS0='t.s.'
         val_VAL=GGK:VAL
         atlv = ATLMAS[VAL_NR,1]
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&|
           CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
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
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
           ADD(OUTFILEANSI)
         END
      .
      TS0='    '
      SATURS1 = F_TEKSTS[3] !3.rinda
      IF SATURS1
         DEBV=0
         DEB = 0
         KREV=0
         KRE = 0
         ATLV=0
         val_val =''
         IF F:DBF='W'
           PRINT(RPT:DETAILV)
         ELSE
           OUTA:LINE=CHR(9)&TS0&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SATURS1&CHR(9)&LEFT(FORMAT(DEBV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(KREV,@N-_14.2B))&CHR(9)&LEFT(FORMAT(ATLV,@N-_14.2B))&CHR(9)&VAL_VAL
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
      DISPLAY()
    END
  END
