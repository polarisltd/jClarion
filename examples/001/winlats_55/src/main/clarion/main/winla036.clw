                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_KaseVAL            PROCEDURE                    ! Declare Procedure
KOMENT               STRING(70)
DOK_NR               STRING(14)
DATUMS               DATE
SATURS               STRING(43)
SATURS2              STRING(43)
ATL                  DECIMAL(15,2)
ATLV                 DECIMAL(15,2)
KKK1D                STRING(5)
KKK2D                STRING(5)
KKK1K                STRING(5)
KKK2K                STRING(5)
BANKURSSD            DECIMAL(10,6)
BANKURSSK            DECIMAL(10,6)
GGK_SUMMAD           DECIMAL(12,2)
GGK_SUMMADV          DECIMAL(12,2)
GGK_SUMMAK           DECIMAL(12,2)
GGK_SUMMAKV          DECIMAL(12,2)
KAPGP                DECIMAL(15,2)
KAPGPV               DECIMAL(15,2)
KATL                 DECIMAL(15,2)
KATLV                DECIMAL(15,2)
GGK_NOS              STRING(3)
GGK_NOSK             STRING(3)
GGK_NOSD             STRING(3)
L                    STRING(1)
LB                   BYTE
POS                  STRING(255)
!KKK1                 STRING(5)
!KKK2                 STRING(5)
CG                   STRING(10)
SUM1                STRING(11)
SUM2                STRING(11)
IEN_SK              USHORT
IZD_SK              USHORT
LINEH               STRING(190)
KDEB                DECIMAL(13,2)
KDEBV               DECIMAL(13,2)
KKRE                DECIMAL(13,2)
KKREV               DECIMAL(13,2)
!-----------------------------------------------------------------------------
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
!-----------------------------------------------------------------------------
report REPORT,AT(198,1781,8219,9302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,104,8000,1677)
         STRING('Izmaksâts (naudas vienîbâs)'),AT(5729,1094,2083,208),USE(?String26:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,1302,0,365),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(3490,1042,0,625),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7031,1302,0,365),USE(?Line4:7),COLOR(COLOR:Black)
         LINE,AT(6771,1302,0,365),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(6094,1302,0,365),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(4896,1302,0,365),USE(?Line4:4),COLOR(COLOR:Black)
         LINE,AT(4635,1302,0,365),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(3906,1302,0,365),USE(?Line4:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2031,156,4375,260),USE(CLIENT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârvalstu valûtas apgrozîjuma pârskats'),AT(2708,469),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(260,781,6094,208),USE(koment),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7156,833),PAGENO,USE(?PageCounter),RIGHT
         LINE,AT(52,1042,7760,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Saòemts (naudas vienîbâs)'),AT(3542,1094,2135,208),USE(?String26),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,1302,0,365),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(52,1302,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Dokum.'),AT(104,1354,469,156),USE(?String8),CENTER
         STRING('Numurs'),AT(104,1510,469,156),USE(?String9),CENTER
         STRING('Val.'),AT(7083,1510,729,156),USE(?String18:2),CENTER
         LINE,AT(52,1667,7750,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('konts'),AT(3542,1510,365,156),USE(?String13),CENTER
         STRING('kurss'),AT(3958,1510,677,156),USE(?String15),CENTER
         STRING('Val.'),AT(4948,1510,729,156),USE(?String18),CENTER
         STRING('konts'),AT(5729,1510,365,156),USE(?String13:2),CENTER
         LINE,AT(5677,1042,0,625),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(7813,1042,0,625),USE(?Line20:19),COLOR(COLOR:Black)
         STRING('kurss'),AT(6146,1510,625,156),USE(?String15:2),CENTER
         STRING('No kâ saòemts,  kam izsniegts,  pamatojums'),AT(1146,1354,2344,156),USE(?String11),CENTER, |
             FONT(,8,,,CHARSET:BALTIC)
         STRING('Kor.'),AT(3542,1354,365,156),USE(?String12),CENTER
         STRING('Valûtas'),AT(3958,1354,677,156),USE(?String14),CENTER
         STRING('Val'),AT(4688,1354,208,156),USE(?String16),CENTER
         STRING(@s3),AT(4948,1354,729,156),USE(val_uzsk),CENTER
         STRING('Kor.'),AT(5729,1354,365,156),USE(?String12:2),CENTER
         STRING('Valûtas'),AT(6146,1354,625,156),USE(?String14:2),CENTER
         STRING('Val'),AT(6823,1354,167,188),USE(?String16:2),CENTER
         STRING(@s3),AT(7083,1354,729,156),USE(val_uzsk,,?val_uzsk:2),CENTER
         STRING('Datums'),AT(625,1354,469,156),USE(?String10),CENTER
         LINE,AT(52,1042,0,625),USE(?Line2),COLOR(COLOR:Black)
       END
ATLIKUMS DETAIL,AT(,,,354)
         LINE,AT(52,-10,0,374),USE(?Line9:2),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,374),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,374),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,374),USE(?Line20:3),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,374),USE(?Line20:4),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,374),USE(?Line20:5),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,374),USE(?Line20:6),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,374),USE(?Line20:7),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,374),USE(?Line20:8),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,374),USE(?Line20:18),COLOR(COLOR:Black)
         STRING('Atlikums uz perioda sâkumu : '),AT(260,0,1510,156),USE(?String28)
         STRING(@n-15.2),AT(2552,0,833,156),USE(atl),RIGHT
         STRING(@n-15.2),AT(2552,156,833,156),USE(atlV),RIGHT
         STRING(@s3),AT(2281,146,229,156),USE(ggk_nos),CENTER
         LINE,AT(52,313,7760,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(573,323,0,42),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(1094,323,0,42),USE(?Line81),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,52)
         LINE,AT(52,-10,0,72),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,72),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(52,21,7760,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,72),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,72),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,72),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,72),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,72),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,72),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,72),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,72),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,72),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,72),USE(?Line33),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,354)
         LINE,AT(52,-10,0,374),USE(?Line4:8),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,374),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,374),USE(?Line4:9),COLOR(COLOR:Black)
         STRING(@s14),AT(73,10,485,156),USE(DOK_NR),RIGHT
         STRING(@D5),AT(625,10,469,156),USE(DATUMS),LEFT
         STRING(@s43),AT(1146,10,2292,156),USE(SATURS),LEFT
         STRING(@s5),AT(3542,10,365,156),USE(KKK1D)
         STRING(@N_10.8B),AT(3958,10,677,156),USE(BANKURSSD),RIGHT
         STRING(@s3),AT(4656,10,229,156),USE(val_uzsk,,?val_uzsk:3),CENTER
         STRING(@n-_12.2b),AT(4927,10,729,156),USE(ggk_Summad),RIGHT
         STRING(@s5),AT(5729,10,365,156),USE(KKK1k)
         STRING(@N_10.8B),AT(6146,10,625,156),USE(BANKURSSk),RIGHT
         STRING(@s3),AT(6792,10,229,156),USE(val_uzsk,,?val_uzsk:5),CENTER
         STRING(@n-_12.2b),AT(7063,10,729,156),USE(ggk_Summak),RIGHT
         STRING(@s43),AT(1146,167,2292,156),USE(SATURS2),LEFT
         STRING(@s3),AT(4656,167,229,156),USE(ggk_nosd),CENTER
         STRING(@n-_12.2b),AT(4927,167,729,156),USE(ggk_SummadV),RIGHT
         STRING(@s5),AT(5729,167,365,156),USE(KKK2k)
         STRING(@s3),AT(6792,167,229,156),USE(ggk_nosk),CENTER
         STRING(@n-_12.2b),AT(7063,167,729,156),USE(ggk_SummakV),RIGHT
         LINE,AT(3490,-10,0,374),USE(?Line20:9),COLOR(COLOR:Black)
         LINE,AT(3906,-10,0,374),USE(?Line20:10),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,374),USE(?Line20:11),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,374),USE(?Line20:12),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,374),USE(?Line20:13),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,374),USE(?Line20:14),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,374),USE(?Line20:15),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,374),USE(?Line20:16),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,374),USE(?Line20:17),COLOR(COLOR:Black)
         STRING(@s5),AT(3542,167,365,156),USE(KKK2D)
       END
RPT_FOOT DETAIL,AT(,,,1688),USE(?unnamed)
         STRING(@n-15.2),AT(2542,625,885,156),USE(KATLV),RIGHT
         LINE,AT(52,781,7760,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Visas valûtas operâcijas tiek fiksçtas pçc fakta, ieòçmumi / zaudçjumi no kursu ' &|
             'svârstîbâm netiek òemti verâ.'),AT(104,885,5677,156),USE(?String59),CENTER
         STRING(@D6),AT(1198,104,625,156),USE(s_DAT)
         STRING(@s25),AT(1448,1260),USE(sys:amats2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(3396,1458),USE(sys:paraksts2),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(6042,1458),USE(sys:paraksts3),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kasieris _{24}'),AT(5563,1250,2396,208),USE(?String39:2),LEFT
         STRING('_{26}'),AT(3385,1250,1885,208),USE(?String39),LEFT
         LINE,AT(52,0,0,781),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(573,0,0,52),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,52),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,781),USE(?Line4:12),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,781),USE(?Line4:13),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,781),USE(?Line4:14),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,781),USE(?Line4:15),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,781),USE(?Line4:16),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,781),USE(?Line4:17),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,781),USE(?Line4:18),COLOR(COLOR:Black)
         LINE,AT(7031,0,0,781),USE(?Line4:19),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,781),USE(?Line4:20),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(' - '),AT(1771,104,156,156),USE(?String5:2)
         STRING(@D6),AT(1927,104,625,156),USE(B_DAT)
         STRING(@n-_13.2),AT(6896,854,729,156),USE(KAPGP),HIDE,RIGHT
         STRING(@n-_13.2),AT(6896,1010,729,156),USE(KAPGPV),HIDE,RIGHT
         STRING(@s3),AT(4656,260,229,156),USE(ggk_nos,,?ggk_nos:2),CENTER
         STRING(@n-_13.2),AT(4927,260,729,156),USE(KDEBV,,?KDEBV:2),RIGHT
         STRING(@s3),AT(6792,260,229,156),USE(ggk_nos,,?ggk_nos:4),CENTER
         STRING(@n-_13.2),AT(7063,260,729,156),USE(KKREV),RIGHT
         STRING('Atlikums beigâs : '),AT(104,469,885,156),USE(?String49:2)
         STRING(@n-15.2),AT(2542,469,885,156),USE(KATL),RIGHT
         STRING(@s3),AT(2281,469,229,156),USE(val_uzsk,,?val_uzsk:7),CENTER
         STRING(@s3),AT(2281,615,229,156),USE(ggk_nos,,?ggk_nos:3),CENTER
         STRING(' : '),AT(2500,104),USE(?String53)
         STRING(@s3),AT(4656,104,229,156),USE(val_uzsk,,?val_uzsk:4),CENTER
         STRING(@n-_13.2),AT(4927,104,729,156),USE(KDEB),RIGHT
         STRING(@s3),AT(6792,104,229,156),USE(val_uzsk,,?val_uzsk:6),CENTER
         STRING(@n-_13.2),AT(7063,104,729,156),USE(KKRE),RIGHT
         STRING('Apgrozîjums periodâ'),AT(104,104,1094,156),USE(?String49)
         STRING(@D6),AT(1198,104,0,156),USE(S_DAT,,?S_DAT:2)
         STRING('Kopçjais kases orderu skaits : Ieòçmumu'),AT(219,1063),USE(?String41)
         STRING(@n4),AT(2323,1063,260,188),USE(ien_sk),LEFT
         STRING(@n4),AT(3135,1063,260,188),USE(izd_sk),LEFT
         STRING('Izdevumu'),AT(2625,1063,479,188),USE(?String41:2)
       END
PAGE_FOOT DETAIL
         LINE,AT(52,0,0,156),USE(?Line4:22),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,156),USE(?Line4:23),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,156),USE(?Line4:24),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,156),USE(?Line4:25),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,156),USE(?Line4:26),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,156),USE(?Line4:27),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,156),USE(?Line4:28),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,156),USE(?Line4:29),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,156),USE(?Line4:30),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,156),USE(?Line4:31),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,10900,8219,52)
         LINE,AT(52,0,7750,0),USE(?Line1:8),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL)
  CHECKOPEN(SYSTEM)
  CHECKOPEN(GGK)
  CHECKOPEN(GG)
  CHECKOPEN(PAR_K)
  CHECKOPEN(KON_K)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND(KON:RECORD)
  KON:BKK = KKK
  GET(KON_K,KON:BKK_KEY)
  KOMENT=KKK&' : '&CLIP(KON:NOSAUKUMS)&' '&FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)
  J# = 0
  KAPGP = 0
  ATL = 0
  KDEB = 0
  KKRE = 0
  KDEBV= 0
  KKREV= 0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK:BKK_DAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ârvalstu valûtas apgr. pârsk.'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    BIND('S_DAT',S_DAT)
    BIND('B_DAT',B_DAT)
    BIND('KKK',KKK)
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK = KKK
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K11'
!!      IF F:DBF='E'
!!         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
!!            LINEH[I#]=CHR(151)
!!         .
!!      ELSE
!!         LOOP I#=1 TO 190
!!            LINEH[I#]='-'
!!         .
!!      .
      Process:View{Prop:Filter}='~CYCLEGGK(CG)'
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
          IF ~OPENANSI('KASEVAL.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='ÂRVALSTU VALÛTAS APGROZÎJUMA PÂRSKATS'
          ADD(OUTFILEANSI)
          OUTA:LINE=KOMENT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Saòemts (naudas vienîbâs)'&CHR(9)&CHR(9)&'Izmaksâts (naudas vienîbâs)'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Dokumenta Numurs'&CHR(9)&'Datums'&CHR(9)&'No kâ saòemts, kam izsniegts, pamatojums'&CHR(9)&'Kor.konts'&CHR(9)&'Valûtas kurss'&CHR(9)&'Val.'&CHR(9)&'LVL'&CHR(9)&'Kor.konts'&CHR(9)&'Valûtas kurss'&CHR(9)&'Val.'&CHR(9)&'LVL'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
!        IF BAND(ggk:BAITS,00000001b) THEN GGK:SUMMAV=0. !IEZAKS
        IF ~BAND(ggk:BAITS,00000001b)  !IEZAKS
           DO CHECKSAKAT
           CASE GGK:D_K
           OF 'D'
             ATL  += GGK:SUMMA
             ATLV += GGK:SUMMAV
           OF 'K'
             ATL -= GGK:SUMMA
             ATLV -= GGK:SUMMAV
           END
           DO CHECKTEXT
           KATL = ATL
           KATLV = ATLV
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
  IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
  ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        !El OUTA:LINE='Apgrozîjums periodâ: '&format(s_dat,@D10.)&' - '&format(b_dat,@D10.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))
        OUTA:LINE='Apgrozîjums periodâ: '&format(s_dat,@D10.)&' - '&format(b_dat,@D10.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&GGK_NOS&CHR(9)&LEFT(FORMAT(KDEBV,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&GGK_NOS&CHR(9)&LEFT(FORMAT(KKREV,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Atlikums beigâs:'&CHR(9)&CHR(9)&LEFT(FORMAT(KATL,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Visas valûtas operâcijas tiek fiksçtas pçc fakta, ieòçmumi/zaudçjumi no kursu svârstîbâm netiek òemti verâ.'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Grâmatvedis:_______________'&CHR(9)&'Kasieris:_______________'
        ADD(OUTFILEANSI)
  ELSE
        !El OUTA:LINE='Apgrozîjums periodâ: '&format(s_dat,@d06.)&' - '&format(b_dat,@d06.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))
        OUTA:LINE='Apgrozîjums periodâ: '&format(s_dat,@d06.)&' - '&format(b_dat,@d06.)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(KDEB,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(KKRE,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&GGK_NOS&CHR(9)&LEFT(FORMAT(KDEBV,@N-_12.2))&CHR(9)&CHR(9)&CHR(9)&GGK_NOS&CHR(9)&LEFT(FORMAT(KKREV,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Atlikums beigâs:'&CHR(9)&CHR(9)&LEFT(FORMAT(KATL,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&LEFT(FORMAT(KATLV,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Visas valûtas operâcijas tiek fiksçtas pçc fakta, ieòçmumi/zaudçjumi no kursu svârstîbâm netiek òemti vçrâ.'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Grâmatvedis:_______________'&CHR(9)&'Kasieris:_______________'
        ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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

!-----------------------------------------------------------------------------
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CHECKSAKAT ROUTINE
  IF GGK:DATUMS >= S_DAT AND ~PRSAKAT# AND ~GGK:U_NR = 1
    KATL = ATL
    KATLV = ATLV
    GGK_NOS=GGK:VAL
    IF F:DBF = 'W'
        PRINT(RPT:ATLIKUMS)
    ELSIF F:DBF='E'
        OUTA:LINE='Atlikums uz perioda sâkumu:'&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='                           '&CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE='Atlikums uz perioda sâkumu:'&CHR(9)&CHR(9)&LEFT(FORMAT(ATL,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&LEFT(FORMAT(ATLV,@N-_12.2))
        ADD(OUTFILEANSI)
    END
    PRSAKAT# = 2
  END

!-----------------------------------------------------------------------------
CHECKTEXT ROUTINE
  IF GGK:DATUMS >= S_DAT AND GGK:U_NR > 1
    GG:U_NR = GGK:U_NR
    GET(GG,GG:NR_KEY)
    BUILDKORMAS(2,0,0,0,0)
!    IF BAND(ggk:BAITS,00000001b) THEN GGK:SUMMAV=0. !IEZAKS
    KKK1 = KOR_KONTS[1]
    KKK2 = KOR_KONTS[2]
!    IF CHECKPZ(1)
!       DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!    ELSE
!       IF GG:DOK_NR
!          DOK_NR=RIGHT(GG:DOK_NR)
!       ELSE
!          DOK_NR=''
!       .
!    .
    DOK_NR = GG:DOK_SENR
    DATUMS = GG:DATUMS
    TEKSTS = CLIP(GG:NOKA)&' '&CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
    FORMAT_TEKSTS(60,'Arial',8,'',)
    SATURS = F_TEKSTS[1]
    SATURS2 = F_TEKSTS[2]
    CASE GGK:D_K
    OF 'D'
      IEN_SK+=1
      BANKURSSD = BANKURS(GGK:VAL,GGK:DATUMS)
      GGK_SUMMAD = GGK:SUMMA
      GGK_SUMMADV = GGK:SUMMAV
      GGK_NOSD = GGK:VAL
      KAPGP += GGK:SUMMA
      KAPGPV += GGK:SUMMAV
      KDEB += GGK:SUMMA
      KDEBV+= GGK:SUMMAV
      KKK1D = KKK1
      KKK2D = KKK2
      KKK1K = ''
      KKK2K = ''
      BANKURSSK = 0
      GGK_SUMMAK = 0
      GGK_SUMMAKV = 0
      GGK_NOSK = ''
    OF 'K'
      IZD_SK+=1
      BANKURSSK = BANKURS(GGK:VAL,GGK:DATUMS)
      GGK_SUMMAK = GGK:SUMMA
      GGK_SUMMAKV = GGK:SUMMAV
      GGK_NOSK = GGK:VAL
      KAPGP -= GGK:SUMMA
      KAPGPV -= GGK:SUMMAV
      KKRE += GGK:SUMMA
      KKREV+= GGK:SUMMAV
      KKK1K = KKK1
      KKK2K = KKK2
      KKK1D = ''
      KKK2D = ''
      BANKURSSD = 0
      GGK_SUMMAD = 0
      GGK_SUMMADV = 0
      GGK_NOSD = ''
    END
    IF PRSAKATL# = 1
!!      PRINT(RPT:DETAIL0)
    ELSE
      PRSAKATL# = 1
    END
    IF ~F:DTK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)
        ELSE
            !El OUTA:LINE=DOK_NR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&SATURS&CHR(9)&KKK1D&CHR(9)&LEFT(FORMAT(BANKURSSD,@N10.8))&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(GGK_SUMMAD,@N-_12.2))&CHR(9)&KKK1K&CHR(9)&LEFT(FORMAT(BANKURSSK,@N10.8))&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(GGK_SUMMAK,@N-_12.2))
            OUTA:LINE=DOK_NR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&SATURS&CHR(9)&KKK1D&CHR(9)&LEFT(FORMAT(BANKURSSD,@N10.8))&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(GGK_SUMMAD,@N-_12.2))&CHR(9)&KKK1K&CHR(9)&LEFT(FORMAT(BANKURSSK,@N10.8))&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(GGK_SUMMAK,@N-_12.2))
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&CHR(9)&SATURS2&CHR(9)&KKK2D&CHR(9)&CHR(9)&GGK_NOSD&CHR(9)&LEFT(FORMAT(GGK_SUMMADV,@N-_12.2))&CHR(9)&KKK2K&CHR(9)&CHR(9)&GGK_NOSK&CHR(9)&LEFT(FORMAT(GGK_SUMMAKV,@N-_12.2))
            ADD(OUTFILEANSI)
        END
    END
  END
B_GG                 PROCEDURE                    ! Declare Procedure
LI                   SHORT
PA                   SHORT
NR                   DECIMAL(5)
DATUMS               DATE
DAT                  DATE
LAI                  TIME
DOK_SENR             STRING(14)
SATURS               STRING(50)
NMR_KODS             STRING(15)
S                    DECIMAL(14)
C                    LONG
CG                   STRING(10)
RAKSTUSKAITS         DECIMAL(2)
SUMMAK               DECIMAL(12,2)

!-----------------------------------------------------------------------------
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
Process:View         VIEW(GG)
                     PROJECT(GG:DATUMS)
                     PROJECT(GG:SECIBA)
                     PROJECT(GG:DOKDAT)
                     PROJECT(GG:U_NR)
                     PROJECT(GG:PAR_NR)
                     PROJECT(GG:SATURS)
                     PROJECT(GG:SATURS2)
                     PROJECT(GG:dok_SENR)
                     PROJECT(GG:RS)
                     PROJECT(GG:VAL)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(180,865,8198,10188),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(180,198,8198,667),USE(?unnamed:2)
         LINE,AT(52,365,7813,0),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(417,365,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('VIRSGRÂMATA : '),AT(677,104,1458,208),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2135,104,4323,208),USE(CLIENT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6979,104,573,208),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(979,365,0,313),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(1510,365,0,313),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(3958,365,0,313),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(5000,365,0,313),USE(?Line5:10),COLOR(COLOR:Black)
         LINE,AT(5938,365,0,313),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(6771,365,0,313),USE(?Line5:15),COLOR(COLOR:Black)
         STRING('Npk.'),AT(104,417,313,208),USE(?String3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(490,417,438,188),USE(?String4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1021,417,469,208),USE(?String5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieraksta saturs'),AT(1615,417,2344,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NMR kods'),AT(4010,417,990,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P/N  Konts  D/K'),AT(5052,417,885,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5938,417,552,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6448,417,344,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa Valutâ'),AT(6823,417,1042,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,625,7813,0),USE(?Line4),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,8198,177)
         LINE,AT(417,-10,0,198),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(979,-10,0,198),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,198),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,198),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line5:9),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,198),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,198),USE(?Line5:14),COLOR(COLOR:Black)
         STRING(@N_5B),AT(94,10,313,156),USE(NR),LEFT
         STRING(@s14),AT(448,10,520,156),USE(DOK_SENR),RIGHT
         STRING(@D05.B),AT(1021,10,469,156),USE(DATUMS),LEFT
         STRING(@s50),AT(1552,10,2396,156),USE(SATURS),LEFT
         STRING(@s15),AT(3990,10,990,156),USE(NMR_KODS),CENTER
         STRING(@N_5),AT(5052,10,365,156),USE(GGK:PAR_NR)
         STRING(@s5),AT(5417,10,365,156),USE(GGK:BKK),LEFT
         STRING(@s1),AT(5813,10,104,156),USE(GGK:D_K),LEFT
         STRING(@N-_12.2B),AT(5990,10,729,156),USE(GGK:SUMMA),RIGHT(1)
         STRING(@N-_12.2B),AT(6823,10,729,156),USE(GGK:SUMMAV),RIGHT
         STRING(@s3),AT(7604,10,260,156),USE(GGK:VAL),LEFT
       END
GRP_FOOT DETAIL,AT(,,8198,94)
         LINE,AT(5938,-10,0,115),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,115),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(52,52,7813,0),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,115),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,115),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,115),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(979,-10,0,115),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,115),USE(?Line5:16),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,8198,219),USE(?unnamed)
         LINE,AT(417,-10,0,63),USE(?Line5:30),COLOR(COLOR:Black)
         LINE,AT(979,-10,0,63),USE(?Line5:32),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,63),USE(?Line5:33),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,63),USE(?Line5:34),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,63),USE(?Line5:29),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,63),USE(?Line5:35),COLOR(COLOR:Black)
         LINE,AT(52,52,7813,0),USE(?Line4:6),COLOR(COLOR:Black)
         STRING('Sastadîja : '),AT(94,73),USE(?String25),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(573,73),USE(ACC_kods),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(1510,-10,0,63),USE(?Line47),COLOR(COLOR:Black)
         STRING(@d06.),AT(6750,73),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7375,73),USE(lai),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(180,11000,8198,406),USE(?unnamed:3)
         LINE,AT(52,52,7813,0),USE(?Line4:4),COLOR(COLOR:Black)
         STRING('Kopâ pa lapu '),AT(313,104,948,198),USE(?String22),LEFT
         STRING(@N2),AT(1260,104,198,198),CNT,PAGE,USE(RAKSTUSKAITS),RIGHT,TALLY(detail)
         STRING('drukâtas rindas par kopçjo summu :'),AT(1500,104,2469,208),USE(?String24),CENTER
         STRING(@N-_12.2B),AT(5813,83,906,156),SUM(GG:SUMMA),PAGE,USE(SUMMAK),RIGHT(1),TALLY(GRP_FOOT)
         LINE,AT(52,313,7813,0),USE(?Line4:5),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  dat = today()
  lai = clock()
  SKAITS#=0
  NPK#=0
  N#=0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  FilesOpened = True
  RecordsToProcess = RECORDS(GG:DAT_KEY)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Galvenâ Grâmata'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GG,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(gg:RECORD)
      GG:DATUMS=S_DAT
      SET(GG:DAT_KEY,GG:DAT_KEY)
      CG = 'G10'
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
          IF ~OPENANSI('VIRSGRAM.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='VIRSGRÂMATA '&CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk'&CHR(9)&'Dokumenta Num.'&CHR(9)&'Datums'&CHR(9)&'Ieraksta saturs'&CHR(9)&'NMR'&|
          CHR(9)&'P / N'&CHR(9)&'Konts'&CHR(9)&'D/K'&CHR(9)&'Summa'&CHR(9)&'Summa valûtâ'&CHR(9)&CHR(9)&'P/A'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=Nk#
        DISPLAY(?Progress:UserString)
        NPKGGK#=0
        NPK#+=1
        clear(ggk:record)
        ggk:U_nr=gg:U_nr
        SET(ggk:nr_KEY,GGK:NR_KEY)
        LOOP
           NEXT(GGK)
           IF ERROR() OR ~(GG:U_NR=GGK:U_NR) THEN BREAK.
           NPKGGK#+=1
           teksts=CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)&' '&GETPAR_K(GG:PAR_NR,0,1)
           FORMAT_TEKSTS(62,'Arial',8,'')
           NMR_KODS=GETPAR_K(GGK:PAR_NR,0,8)
           DOK_SENR=''
           CASE NPKGGK#
           OF 1
             NR=NPK#
             DOK_SENR=GETDOK_SENR(1,GG:DOK_SENR,,GG:ATT_DOK)
             IF ~DOK_SENR THEN DOK_SENR=GETDOK_SENR(2,GG:DOK_SENR,,GG:ATT_DOK).
             DATUMS=GG:DATUMS
             SATURS = F_TEKSTS[1]
           OF 2
             IF F:DBF = 'W'
                NR=GG:U_NR
             ELSE
                !28/10/2015NR=''
                NR=GG:U_NR
             .
             IF GETDOK_SENR(1,GG:DOK_SENR,,GG:ATT_DOK)
                DOK_SENR=GETDOK_SENR(2,GG:DOK_SENR,,GG:ATT_DOK)
             .
             DATUMS=0
             SATURS = F_TEKSTS[2]
           OF 3
             NR=''
             DOK_SENR=''
             DATUMS=0
             SATURS = F_TEKSTS[3]
             DOK_SENR=''
           ELSE
             NR=''
             DOK_SENR=''
             DATUMS=0
             SATURS=''
           .
           IF F:DBF = 'W'
               PRINT(RPT:DETAIL)
           ELSE
               OUTA:LINE=LEFT(FORMAT(NR,@N_6B))&CHR(9)&CLIP(DOK_SENR)&CHR(9)&FORMAT(DATUMS,@D06.B)&CHR(9)&|
               CLIP(SATURS)&CHR(9)&CLIP(NMR_KODS)&CHR(9)&CLIP(GGK:PAR_NR)&CHR(9)&CLIP(GGK:BKK)&CHR(9)&CLIP(GGK:D_K)&|
               CHR(9)&LEFT(FORMAT(GGK:SUMMA,@N-_12.2B))&CHR(9)&LEFT(FORMAT(GGK:SUMMAV,@N-_12.2B))&CHR(9)&CLIP(GGK:VAL)&|
               CHR(9)&GETPAR_K(GGK:PAR_NR,0,1)
               ADD(OUTFILEANSI)
           .
        .
        PRINT(RPT:GRP_FOOT)
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
  IF SEND(GG,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF = 'W'
          PRINT(RPT:RPT_FOOT)
          ENDPAGE(report)
    ELSE
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Operators: '&ACC_KODS&' '&FORMAT(DAT,@D06.)&' '&FORMAT(LAI,@T4)
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  PREVIOUS(Process:View)
  IF ERRORCODE() OR GG:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
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

B_SnDekl             PROCEDURE                    ! Declare Procedure
KOMENT               STRING(68)
RPT_NPK              STRING(3)
REGunnos             string(63)
par_nos_P            string(40)
DEB                  DECIMAL(12,2)
KRE                  DECIMAL(12,2)
KDEBP                DECIMAL(12,2)
KKREP                DECIMAL(12,2)
LDEB                 DECIMAL(12,2)
LKRE                 DECIMAL(12,2)
NOS                  STRING(3)
RPT_DATUMS           DECIMAL(2)
RPT_MENESIS          STRING(11)
RPT_DATUMS1          DECIMAL(2)
RPT_MENESIS1         STRING(11)
DAT                  LONG
LAI                  LONG
CG                   STRING(10)
MEN12                DECIMAL(2),DIM(12)
kopa                 decimal(12,2)
kopak                decimal(12,2)
DATUMS               LONG
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

P_TABLE              QUEUE,PRE(P)
PAR_NR               ULONG
SUMMALS              DECIMAL(12,2)
DEB                  DECIMAL(12,2)
KRE                  DECIMAL(12,2)
kopa                 DECIMAL(12,2)
                     END
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
report REPORT,AT(198,2448,8000,8302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,104,8000,2302)
         STRING('2001. gada 24. jûlija noteikumiem Nr.329'),AT(5729,365,1979,156),USE(?String57:2)
         STRING('DEKLARÂCIJA PAR SKAIDRÂ NAUDÂ VEIKTAJIEM DARÎJUMIEM'),AT(1458,573,5417,260),USE(?String3), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1979,885,4427,0),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(5729,885,0,677),USE(?Line49:2),COLOR(COLOR:Black)
         LINE,AT(6406,885,0,677),USE(?Line49:3),COLOR(COLOR:Black)
         STRING('Periods'),AT(2031,938,3698,156),USE(?String46:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Gads'),AT(5781,1042,625,156),USE(?String46:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1979,885,0,677),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(1979,1094,3750,0),USE(?Line48:2),COLOR(COLOR:Black)
         STRING('Mçnesis'),AT(2031,1146,3698,156),USE(?String46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(2031,1354),USE(MEN12[1]),CENTER
         STRING(@N2B),AT(2344,1354),USE(MEN12[2]),CENTER
         STRING(@N2B),AT(2656,1354),USE(MEN12[3]),CENTER
         STRING(@N2B),AT(2969,1354),USE(MEN12[4]),CENTER
         STRING(@N2B),AT(3281,1354),USE(MEN12[5]),CENTER
         STRING(@N2B),AT(3594,1354),USE(MEN12[6]),CENTER
         STRING(@N2B),AT(3906,1354),USE(MEN12[7]),CENTER
         STRING(@N2B),AT(4219,1354),USE(MEN12[8]),CENTER
         STRING(@N2B),AT(4531,1354),USE(MEN12[9]),CENTER
         STRING(@N2B),AT(4844,1354),USE(MEN12[10]),CENTER
         STRING(@N2B),AT(5156,1354),USE(MEN12[11]),CENTER
         STRING(@N2B),AT(5469,1354),USE(MEN12[12]),CENTER
         STRING(@N4),AT(5833,1354),USE(GL:DB_gads),CENTER
         LINE,AT(1979,1563,4427,0),USE(?Line48:4),COLOR(COLOR:Black)
         LINE,AT(2292,1302,0,260),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(2604,1302,0,260),USE(?Line501),COLOR(COLOR:Black)
         LINE,AT(2917,1302,0,260),USE(?Line502),COLOR(COLOR:Black)
         LINE,AT(3229,1302,0,260),USE(?Line503),COLOR(COLOR:Black)
         LINE,AT(3542,1302,0,260),USE(?Line504),COLOR(COLOR:Black)
         LINE,AT(3854,1302,0,260),USE(?Line505),COLOR(COLOR:Black)
         LINE,AT(4167,1302,0,260),USE(?Line506),COLOR(COLOR:Black)
         LINE,AT(4479,1302,0,260),USE(?Line507),COLOR(COLOR:Black)
         LINE,AT(4792,1302,0,260),USE(?Line508),COLOR(COLOR:Black)
         LINE,AT(5104,1302,0,260),USE(?Line509),COLOR(COLOR:Black)
         LINE,AT(5417,1302,0,260),USE(?Line50:2),COLOR(COLOR:Black)
         LINE,AT(1979,1302,4427,0),USE(?Line48:3),COLOR(COLOR:Black)
         STRING('Pielikums Ministru kabineta'),AT(5729,208,1302,156),USE(?String57)
         STRING(@s45),AT(2813,1667,3385,208),USE(CLIENT),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienests'),AT(3365,365),USE(?String44)
         STRING(@s45),AT(1354,1875,3490,208),USE(SYS:ADRESE),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese:'),AT(677,1875),USE(?String61:2)
         STRING(@s13),AT(2031,2083,1042,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reìistrâcijas Nr.'),AT(677,2083),USE(?String61:3)
         STRING(@s48),AT(4844,2083,2969,208),USE(koment),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2292,7448,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Maksâtâja saîsinâtais nosaukums:'),AT(677,1667),USE(?String61)
       END
HEADER DETAIL,AT(,,,708)
         LINE,AT(104,0,7448,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,0,0,719),USE(?Line3),COLOR(COLOR:Black)
         STRING('Nr.'),AT(156,52,260,208),USE(?String19),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma dalîbnieka - nodokïu makstâtâja -'),AT(469,52,2917,156),USE(?String20),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Rezidences'),AT(3438,52,781,156),USE(?String30:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Val'),AT(7240,52,313,156),USE(?String22),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('veids'),AT(4271,260,781,208),USE(?String30:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(5104,260,677,156),USE(?String25:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5781,208,0,510),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(5052,208,2135,0),USE(?Line7),COLOR(COLOR:Black)
         STRING(' nosaukums un reì. kods '),AT(469,260,2917,156),USE(?String21),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts'),AT(3438,260,781,208),USE(?String30:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,208,0,510),USE(?Line11),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,719),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(7552,0,0,719),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(104,469,7448,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(5052,0,0,719),USE(?Line10),COLOR(COLOR:Black)
         STRING('06'),AT(5833,521,677,156),USE(?String27),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('07'),AT(6563,521,625,156),USE(?String28),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,677,7448,0),USE(?Line12),COLOR(COLOR:Black)
         STRING('01'),AT(156,521,260,156),USE(?String31),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3385,0,0,719),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,719),USE(?Line10:2),COLOR(COLOR:Black)
         STRING('Darîjuma'),AT(4271,52,781,156),USE(?String30),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('08'),AT(7240,521,260,156),USE(?String29),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('04'),AT(4271,521,781,156),USE(?String33),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('05'),AT(5104,521,677,156),USE(?String33:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('02'),AT(469,521,2865,156),USE(?String32),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('03'),AT(3490,521,729,156),USE(?String33:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izdots'),AT(6563,260,625,156),USE(?String26),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('p/k'),AT(156,260,260,208),USE(?String19:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemts'),AT(5833,260,677,156),USE(?String25),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjumu kopsumma'),AT(5104,52,1729,156),USE(?String23),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6833,52,344,156),USE(val_uzsk),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,0,0,719),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@s63),AT(469,10,2917,156),USE(REGunnos)
         STRING(@n_12.2b),AT(5833,10,677,156),USE(deb),RIGHT
         STRING(@n_12.2b),AT(6563,10,625,156),USE(kre),RIGHT
         STRING(@s3),AT(7271,10,229,156),USE(val_uzsk,,?val_uzsk:2),LEFT
         LINE,AT(7552,-10,0,198),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,198),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line17),COLOR(COLOR:Black)
         STRING(@n_12.2b),AT(5104,10,677,156),USE(kopa),RIGHT
         LINE,AT(5781,-10,0,198),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line14),COLOR(COLOR:Black)
         STRING(@n3b),AT(156,10,240,156),USE(RPT_NPK),RIGHT
       END
detail2 DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,198),USE(?Line31:4),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,198),USE(?Line31:3),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,198),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,198),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(104,52,7448,0),USE(?Line34:2),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,177)
         STRING(@n_12.2b),AT(6563,10,625,156),USE(KkreP),RIGHT
         LINE,AT(7188,-10,0,198),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),USE(?Line37:3),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,198),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line371),COLOR(COLOR:Black)
         STRING(@n_12.2b),AT(5104,10,677,156),USE(kopak),RIGHT
         LINE,AT(5781,-10,0,198),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,198),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,198),USE(?Line40),COLOR(COLOR:Black)
         STRING('KOPÂ'),AT(4427,10,469,156),USE(?String70),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_12.2b),AT(5833,10,677,156),USE(KdebP),RIGHT
       END
detail3 DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,63),USE(?Line43:3),COLOR(COLOR:Black)
         LINE,AT(3385,-10,0,63),USE(?Line43:2),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line431),COLOR(COLOR:Black)
         LINE,AT(5781,-10,0,63),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,63),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,63),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(104,52,7448,0),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,63),USE(?Line47),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,281)
         STRING('Atbildîga persona:'),AT(625,52,1094,208),USE(?String41),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('(S >= '),AT(5885,52,,208),USE(?String51),FONT(,9,,)
         STRING(@N10.2),AT(6250,52,729,208),USE(MINMAXSUMMA),RIGHT,FONT(,9,,)
         STRING(')'),AT(7031,52,,208),USE(?String53),FONT(,9,,)
       END
detail4 DETAIL,AT(,,,302),USE(?unnamed)
         LINE,AT(1458,0,0,260),USE(?Line74:7),COLOR(COLOR:Black)
         LINE,AT(3448,0,0,260),USE(?Line74:2),COLOR(COLOR:Black)
         LINE,AT(4531,0,1406,0),USE(?Line72:2),COLOR(COLOR:Black)
         LINE,AT(5938,0,0,260),USE(?Line74:5),COLOR(COLOR:Black)
         LINE,AT(4531,0,0,260),USE(?Line74:4),COLOR(COLOR:Black)
         LINE,AT(1458,0,1979,0),USE(?Line72),COLOR(COLOR:Black)
         STRING('Uzvârds'),AT(625,52),USE(?String41:3),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(1563,52),USE(SYS:paraksts1),LEFT,FONT(,9,,)
         STRING('Datums'),AT(3802,52),USE(?String41:4),FONT(,9,,)
         STRING(@D06.),AT(4844,52),USE(DATUMS),RIGHT,FONT(,9,,)
         LINE,AT(1458,260,1979,0),USE(?Line722),COLOR(COLOR:Black)
         LINE,AT(4531,260,1406,0),USE(?Line72:5),COLOR(COLOR:Black)
       END
detail5 DETAIL,AT(,,,354)
         LINE,AT(1458,52,0,260),USE(?Line74),COLOR(COLOR:Black)
         LINE,AT(2865,52,0,260),USE(?Line74:3),COLOR(COLOR:Black)
         LINE,AT(4531,52,0,260),USE(?Line743),COLOR(COLOR:Black)
         LINE,AT(5938,52,0,260),USE(?Line74:6),COLOR(COLOR:Black)
         LINE,AT(4531,52,1406,0),USE(?Line72:3),COLOR(COLOR:Black)
         LINE,AT(1458,52,1406,0),USE(?Line723),COLOR(COLOR:Black)
         STRING('Paraksts'),AT(625,104,573,208),USE(?String41:2),FONT(,9,,)
         STRING('Tâlrunis'),AT(3813,104),USE(?String45),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s15),AT(4667,104),USE(SYS:Tel),CENTER,FONT(,9,,)
         LINE,AT(1458,313,1406,0),USE(?Line72:4),COLOR(COLOR:Black)
         LINE,AT(4531,313,1406,0),USE(?Line72:6),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,10604,8000,260)
         LINE,AT(104,0,7448,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(4948,21),PAGENO,USE(?PageCount),RIGHT
         STRING(@d06.),AT(6500,21),USE(dat),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7083,21),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('KKK1',KKK1)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('MINMAXSUMMA',MINMAXSUMMA)
  FREE(P_TABLE)

!  STOP(KONTS1&KONTS2)
  BIND(GG:RECORD)
  DAT = TODAY()
  LAI = CLOCK()
  IF INRANGE(MEN_NR,1,12)
    MEN12[MEN_NR]=MEN_NR
  ELSIF INRANGE(MEN_NR,13,17)
    CASE MEN_NR
    OF 13                                          ! 1.CETURKSNIS
      MEN12[1]=1
      MEN12[2]=2
      MEN12[3]=3
    OF 14                                          ! 2.CETURKSNIS
      MEN12[4]=4
      MEN12[5]=5
      MEN12[6]=6
    OF 15                                          ! 3.CETURKSNIS
      MEN12[7]=7
      MEN12[8]=8
      MEN12[9]=9
    OF 16                                          ! 4.CETURKSNIS
      MEN12[10]=10
      MEN12[11]=11
      MEN12[12]=12
    OF 17                                          ! Viss gads
      LOOP M#=1 TO 12
        MEN12[M#]=M#
      .
    .
  ELSE
     STOP('NEGAIDÎTA KÏÛDA NR= '&MEN_NR)
  .

  CLEAR(KON:RECORD)
  KOMENT = 'Konti: '&KKK&'  un  '&KKK1
  J# = 0
  DONE#=0
  KDEBP = 0
  KKREP = 0
  LDEB = 0
  LKRE = 0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF par_k::used=0
     CHECKOPEN(PAR_K,1)
  .
  PAR_K::USED+=1
  IF KON_K::USED=0
     CHECKOPEN(KON_K,1)
  .
  KON_K::USED+=1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK:DAT_KEY)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Skaidras Naudas Deklarâcija'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      CG = 'K10000'
      SET(GGK:DAT_KEY,GGK:DAT_KEY)
      Process:View{Prop:Filter} = '(~CYCLEBKK(GGK:BKK,KKK) OR ~CYCLEBKK(GGK:BKK,KKK1)) AND ~CYCLEGGK(CG) AND ~(GGK:U_NR=1)'
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
      PRINT(RPT:HEADER)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GETGG(GGK:U_NR)
           ACT# = 1
           GET(P_TABLE,0)
           LOOP J#=1 TO RECORDS(P_TABLE)
              GET(P_TABLE,J#)
              IF P:PAR_NR = GG:PAR_NR
                 ACT# = 2
                 BREAK
              END
           END
           IF ACT# = 1
              CLEAR(P:SUMMALS)
              CLEAR(P:DEB)
              CLEAR(P:KRE)
              CLEAR(P:KOPA)
              P:PAR_NR = GG:PAR_NR
           END
           P:SUMMALS += GGK:SUMMA
           CASE GGK:D_K
           OF 'D'
              P:DEB += GGK:SUMMA
           OF 'K'
              P:KRE += GGK:SUMMA
           END
           P:KOPA=P:DEB+P:KRE
           EXECUTE ACT#
              ADD(P_TABLE)
              PUT(P_TABLE)
           END
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
    LOOP I#=1 TO RECORDS(P_TABLE)
     GET(P_TABLE,I#)
     IF P:SUMMALS >= MINMAXSUMMA AND ~(GETPAR_K(P:PAR_NR,2,20)='F')  !FIZISKÂS PERSONAS NEVAJAG
        NPK# += 1
        RPT_NPK = NPK#
        REGUNNOS = CLIP(GETPAR_K(P:PAR_NR,0,6))&'  '&GETPAR_K(P:PAR_NR,0,8)
        IF P:DEB OR P:KRE
           DEB = P:DEB
           KRE = P:KRE
           KOPA= P:KOPA
           PRINT(RPT:DETAIL)
           REGUNNOS =''
           RPT_NPK = 0
           LDEB += P:DEB
           LKRE += P:KRE
           KDEBP += P:DEB
           KKREP += P:KRE
           KOPAK += P:KOPA
        END
     END
  END
  IF TODAY() > B_DAT+15
     DATUMS=B_DAT+15
  ELSE
     DATUMS=TODAY()
  .
  PRINT(RPT:DETAIL2)
  PRINT(RPT:REP_FOOT)
  PRINT(RPT:DETAIL3)
  PRINT(RPT:DETAIL1)
  PRINT(RPT:DETAIL4)
  PRINT(RPT:DETAIL5)
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  FREE(P_TABLE)
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
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
