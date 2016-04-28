                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_DEKR               PROCEDURE                    ! Declare Procedure
CG                   STRING(10)
CYCLEGGK                   STRING(10)       ! %%%% undefined?

P2190                DECIMAL(13,2)
P2310                DECIMAL(13,2)
P5210                DECIMAL(13,2)
P5310                DECIMAL(13,2)
K2190                DECIMAL(13,2)
K2310                DECIMAL(13,2)
K5210                DECIMAL(13,2)
K5310                DECIMAL(13,2)
V2190                DECIMAL(13,2)
V2310                DECIMAL(13,2)
V5210                DECIMAL(13,2)
V5310                DECIMAL(13,2)
R2190                DECIMAL(13,2)
R2310                DECIMAL(13,2)
R5210                DECIMAL(13,2)
R5310                DECIMAL(13,2)
L2190                DECIMAL(13,2)
L2310                DECIMAL(13,2)
L5210                DECIMAL(13,2)
L5310                DECIMAL(13,2)
KV2190               DECIMAL(13,2)
KV2310               DECIMAL(13,2)
KV5210               DECIMAL(13,2)
KV5310               DECIMAL(13,2)
PV2190               DECIMAL(13,2)
PV2310               DECIMAL(13,2)
PV5210               DECIMAL(13,2)
PV5310               DECIMAL(13,2)
DAT                  LONG
LAI                  TIME
GGNR                 DECIMAL(5)
DATUMS               LONG
DOK_NR               STRING(14)
KOMENT               STRING(70)
NOS_P                STRING(35)
SATURS               STRING(60)
SATURSV              STRING(60)
SATURS2              STRING(60)
SATURS3              STRING(60)
KVNOS                STRING(3)
VNOS                 STRING(3)
PVNOS                STRING(3)
TS                   STRING(12)
TSP                  STRING(12)
FILTRS               STRING(15)
K_TABLE              QUEUE,PRE(K)
NOS                     STRING(3)
k2190                   DECIMAL(12,2)
k2310                   DECIMAL(12,2)
k5210                   DECIMAL(12,2)
k5310                   DECIMAL(12,2)
p2190                   DECIMAL(12,2)
p2310                   DECIMAL(12,2)
p5210                   DECIMAL(12,2)
p5310                   DECIMAL(12,2)
                     .
BKK                  STRING(3)
VALUTA               BYTE
VALUTAP              BYTE
!
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

report REPORT,AT(200,1608,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,150,8000,1458),USE(?unnamed:2)
         STRING('GG'),AT(83,1125,313,208),USE(?String7:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1927,781,0,677),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(1354,781,0,677),USE(?Line2:20),COLOR(COLOR:Black)
         STRING('(-) m�s esam'),AT(6750,990,1042,208),USE(?String55:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(448,1146,885,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(-) m�s esam'),AT(5917,990,781,208),USE(?String55:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('par�d� preci'),AT(5917,1198,781,208),USE(?String55:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(+) mums pa-'),AT(5083,990,781,208),USE(?String55:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('r�d� preci'),AT(4250,1198,781,208),USE(?String55:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('r�d� naudu'),AT(5083,1198,781,208),USE(?String55:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('par�d� naudu'),AT(6750,1198,1042,208),USE(?String55:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(896,427,6052,260),USE(KOMENT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('219*'),AT(4250,833,781,156),USE(?String54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('231*'),AT(5083,833,781,156),USE(?String54:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('521*'),AT(5917,833,781,156),USE(?String54:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('531*'),AT(6750,833,1042,156),USE(?String54:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(+) mums pa-'),AT(4250,990,781,208),USE(?String55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1406,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7813,781,0,677),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(4219,781,0,677),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5052,781,0,677),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5885,781,0,677),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(417,781,0,677),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1615,146,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6719,781,0,677),USE(?Line63),COLOR(COLOR:Black)
         STRING(@p<<<#p),AT(7052,552,365,208),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         STRING('. lapa'),AT(7458,552,333,208),USE(?String6)
         LINE,AT(52,781,7760,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NR'),AT(83,927,313,208),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(448,938,885,208),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(1406,1042,469,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieraksta saturs'),AT(1958,1042,2240,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,677),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(6719,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@D05.),AT(1385,10,521,156),USE(DATUMS),LEFT
         LINE,AT(1927,-10,0,198),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@s60),AT(1958,10,2240,156),USE(SATURS),LEFT
         STRING(@n_5),AT(83,10,313,156),USE(GGNR),RIGHT
         STRING(@S14),AT(448,10,885,156),USE(DOK_NR),RIGHT
         STRING(@n-_13.2b),AT(4271,10,729,156),USE(R2190),RIGHT
         STRING(@n-_13.2b),AT(5104,10,729,156),USE(R2310),RIGHT
         STRING(@n-_13.2b),AT(5938,10,729,156),USE(R5210),RIGHT
         STRING(@n-_13.2b),AT(6771,10,729,156),USE(R5310),RIGHT
         LINE,AT(5885,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
       END
detailV DETAIL,AT(,,,177)
         LINE,AT(5885,-10,0,197),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING('t.s.'),AT(1406,10,313,156),USE(?String65),LEFT
         STRING(@n-_13.2b),AT(5104,10,729,156),USE(v2310),RIGHT
         STRING(@n-_13.2b),AT(5938,10,729,156),USE(v5210),RIGHT
         LINE,AT(6719,-10,0,197),USE(?Line34:7),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(6771,10,729,156),USE(V5310),RIGHT
         LINE,AT(7813,-10,0,197),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@s3),AT(7552,10,260,156),USE(VNOS),LEFT
         STRING(@n-_13.2b),AT(4271,10,729,156),USE(v2190),RIGHT
         STRING(@s60),AT(1958,10,2240,156),USE(SATURSv),LEFT
       END
detail2 DETAIL,AT(,,,177)
         LINE,AT(5885,-10,0,197),USE(?Line112:6),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line112:4),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line112:24),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line112:25),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line112:11),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,197),USE(?Line112:9),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,197),USE(?Line134:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line112:31),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,197),USE(?Line112:2),COLOR(COLOR:Black)
         STRING(@s60),AT(1958,10,2240,156),USE(SATURS2),LEFT
       END
detail3 DETAIL,AT(,,,177)
         LINE,AT(5885,-10,0,197),USE(?Line112:7),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line112:5),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line112:124),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,197),USE(?Line112:125),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,197),USE(?Line112:12),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,197),USE(?Line112:10),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,197),USE(?Line134:2),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line112:131),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,197),USE(?Line112:3),COLOR(COLOR:Black)
         STRING(@s60),AT(1958,10,2240,156),USE(SATURS3),LEFT
       END
PER_FOOT DETAIL,AT(,,,250),USE(?unnamed:4)
         LINE,AT(52,52,7760,0),USE(?Line32),COLOR(COLOR:Black)
         STRING('KOP� pa periodu :'),AT(177,104,,156),USE(?String20)
         LINE,AT(1927,-10,0,62),USE(?Line96),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,270),USE(?Line97:2),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,270),USE(?Line97:3),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,270),USE(?Line97:4),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,270),USE(?Line97:5),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(4271,104,729,156),USE(P2190),RIGHT
         STRING(@n-_13.2b),AT(6771,104,729,156),USE(P5310),RIGHT
         STRING(@s3),AT(7552,104,260,156),USE(val_uzsk),LEFT
         LINE,AT(7813,-10,0,270),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,270),USE(?Line97),COLOR(COLOR:Black)
         LINE,AT(1354,-10,0,62),USE(?Line95),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(5938,104,729,156),USE(P5210),RIGHT
         STRING(@n-_13.2b),AT(5104,104,729,156),USE(P2310),RIGHT
         LINE,AT(417,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
       END
PER_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,52,7760,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,114),USE(?Line116),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,114),USE(?Line115),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,114),USE(?Line114),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,114),USE(?Line113),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,114),USE(?Line112),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,114),USE(?Line111),COLOR(COLOR:Black)
       END
RPT_FOOT0 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(417,-10,0,62),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,115),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,115),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,115),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,115),USE(?Line107),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,62),USE(?Line106),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,62),USE(?Line105),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(5885,-10,0,197),USE(?Line212:130),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,197),USE(?Line112:8),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,197),USE(?Line212:128),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line12:24),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,197),USE(?Line34:11),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line12:31),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(4271,10,729,156),USE(K2190),RIGHT
         STRING(@n-_13.2b),AT(5104,10,729,156),USE(K2310),RIGHT
         STRING(@n-_13.2b),AT(5938,10,729,156),USE(K5210),RIGHT
         STRING(@n-_13.2b),AT(6771,10,729,156),USE(K5310),RIGHT
         STRING(@s3),AT(7552,10,260,156),USE(val_uzsk,,?val_uzsk:2),LEFT
         STRING('KOP� no gada s�kuma :'),AT(177,10,1510,156),USE(?String65:2),LEFT
       END
RPT_FOOTV DETAIL,AT(,,,177)
         LINE,AT(4219,-10,0,198),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,198),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,198),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,198),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line34),COLOR(COLOR:Black)
         STRING(@s12),AT(365,10,,156),USE(TS),LEFT
         STRING(@n-_13.2b),AT(4271,10,729,156),USE(KV2190),RIGHT
         STRING(@n-_13.2b),AT(5104,10,729,156),USE(KV2310),RIGHT
         STRING(@n-_13.2b),AT(5938,10,729,156),USE(KV5210),RIGHT
         STRING(@n-_13.2b),AT(6771,10,729,156),USE(KV5310),RIGHT
         STRING(@s3),AT(7552,10,260,156),USE(KVNOS),LEFT
       END
PER_FOOTV DETAIL,AT(,,,177)
         LINE,AT(4219,-10,0,198),USE(?Line34:8),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line34:9),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,198),USE(?Line34:10),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,198),USE(?Line34:12),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,198),USE(?Line34:16),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line134),COLOR(COLOR:Black)
         STRING(@s12),AT(365,10,,156),USE(TSP),LEFT
         STRING(@n-_13.2b),AT(4271,10,729,156),USE(PV2190),RIGHT
         STRING(@n-_13.2b),AT(5104,10,729,156),USE(PV2310),RIGHT
         STRING(@n-_13.2b),AT(5938,10,729,156),USE(PV5210),RIGHT
         STRING(@n-_13.2b),AT(6771,10,729,156),USE(PV5310),RIGHT
         STRING(@s3),AT(7552,10,260,156),USE(PVNOS),LEFT
       END
RPT_FOOT1 DETAIL,AT(,,,250),USE(?unnamed)
         LINE,AT(52,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,63),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,63),USE(?Line45:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line46:2),COLOR(COLOR:Black)
         STRING('Sast�d�ja :'),AT(63,73,573,156),USE(?String41),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,73,625,156),USE(ACC_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1677,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6719,-10,0,63),USE(?Line119),COLOR(COLOR:Black)
         STRING(@d06.),AT(6604,73,625,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7281,73,594,156),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('RS:'),AT(1490,73,177,156),USE(?String74),FONT(,7,,,CHARSET:ANSI)
       END
PAGE_FOOT DETAIL,AT(,,,323)
         LINE,AT(5885,-10,0,271),USE(?Line49:3),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,271),USE(?Line49:4),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,271),USE(?Line49:5),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line54),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(4271,104,729,156),USE(L2190),RIGHT
         STRING(@n-_13.2b),AT(5104,104,729,156),USE(L2310),RIGHT
         STRING(@n-_13.2b),AT(5938,104,729,156),USE(L5210),RIGHT
         STRING(@n-_13.2b),AT(6771,104,729,156),USE(L5310),RIGHT
         STRING(@s3),AT(7552,94,260,156),USE(val_uzsk,,?val_uzsk:3),LEFT
         LINE,AT(52,260,7760,0),USE(?Line55),COLOR(COLOR:Black)
         STRING('KOP� pa lapu : '),AT(177,104,885,156),USE(?String48)
         LINE,AT(5052,-10,0,271),USE(?Line49:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,271),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,271),USE(?Line49),COLOR(COLOR:Black)
       END
PAGE_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(52,0,0,63),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(5052,0,0,63),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,63),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(6719,0,0,63),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,63),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7760,0),USE(?Line56),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10990,8000,63)
         LINE,AT(52,0,7760,0),USE(?Line48:2),COLOR(COLOR:Black)
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
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  CHECKOPEN(VAL_K,1)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)
  VALUTA =0
  VALUTAP=0
  V#=0
  ! NOS_P = GETPAR_K(PAR_NR,2,2)    ! %%%%% disabled function -> winla044
  KOMENT='Nor��ini ar : '&CLIP(nos_p)&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  CHECKOPEN(VAL_K)
  CLEAR(VAL:RECORD)
  SET(VAL:NOS_KEY)
  DO NEXTVAL
  LOOP UNTIL V#
    K:NOS=VAL:VAL
    K:k2190 = 0
    K:k2310 = 0
    K:k5210 = 0
    K:k5310 = 0
    K:p2190 = 0
    K:p2310 = 0
    K:p5210 = 0
    K:p5310 = 0
    GET(K_TABLE,0)
    ADD(K_TABLE,K:NOS)
    DO NEXTVAL
  .
  SORT(K_TABLE,K:NOS)
  k2190 = 0
  k2310 = 0
  k5210 = 0
  k5310 = 0
  p2190 = 0
  p2310 = 0
  p5210 = 0
  p5310 = 0
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
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'B�v�jam izzi�u'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:PAR_NR = PAR_NR
!      GGK:DATUMS = DATE(1,1,GADS)
      GGK:DATUMS = DATE(1,1,YEAR(S_DAT))
      CG = 'K1100'
      SET(GGK:PAR_KEY,GGK:PAR_KEY)
      Process:View{Prop:Filter} = 'INSTRING(GGK:BKK[1:3],''219231521531'',3,1) AND ~CYCLEGGK(CG)'
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
          !IF ~OPENANSI('DEKR.TXT')   ! disabled -> 224 %%%%%%
          !  POST(Event:CloseWindow)
          !  CYCLE
          !.
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=KOMENT
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE='NR GG'&CHR(9)&'Dokumenta'&CHR(9)&'Datums'&CHR(9)&'Ieraksta saturs'&CHR(9)&'219** (+)-mums'&CHR(9)&'231** (+)-mums'&CHR(9)&'521** (-)-m�s esam'&CHR(9)&'531** (-)-m�s esam'
            ADD(OUTFILEANSI)
            OUTA:LINE=        CHR(9)&'numurs'   &CHR(9)         &CHR(9)                  &CHR(9)&'par�d� preci'  &CHR(9)&'par�d� naudu'  &CHR(9)&'par�d� preci'      &CHR(9)&'par�d� naudu'
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='NR GG'&CHR(9)&'Dokumenta numurs'&CHR(9)&'Datums'&CHR(9)&'Ieraksta saturs'&CHR(9)&'219** (+)-mums par�d� preci'&CHR(9)&'231** (+)-mums par�d� naudu'&CHR(9)&'521** (-)-m�s esam par�d� preci'&CHR(9)&'531** (-)-m�s esam par�d� naudu'
            ADD(OUTFILEANSI)
          END
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF GGK:D_K = 'K'
           GGK:SUMMA  = -GGK:SUMMA
           GGK:SUMMAV = -GGK:SUMMAV
        .
!************************** 1.SOLIS-SKAITAM NO GADA S�KUMA *****************
        BKK=GGK:BKK[1:3]
        CASE BKK
        OF '219'
           k2190 += ggk:summa
        OF '231'
           k2310 += ggk:summa
        OF '521'
           k5210 += ggk:summa
        OF '531'
           k5310 += ggk:summa
        ELSE
           STOP(BKK)
        .
        !El IF ~(GGK:val = 'LVL' or GGK:val = 'Ls')
        IF ~(GGK:val = val_uzsk)
          VALUTA=TRUE
        .
        IF ~BAND(GGK:BAITS,00000001b)                 ! NAV IEZAKS
           GET(K_TABLE,0)
           K:NOS=GGK:VAL
           GET(K_TABLE,K:NOS)
           IF ERROR()
              KLUDA('16',GGK:U_NR)
              FREE(K_TABLE)
              CLOSE(REPORT)
              DO PROCEDURERETURN
           .
           BKK=SUB(GGK:BKK,1,3)
           CASE BKK
           OF '219'
              K:k2190 += ggk:summav
           OF '231'
              K:k2310 += ggk:summav
           OF '521'
              K:k5210 += ggk:summav
           OF '531'
              K:k5310 += ggk:summav
           .
           PUT(K_TABLE)
        .
        IF GGK:DATUMS >= S_DAT
      !************************** 2.SOLIS SKAITAM PA PERIODU *********************
          r2190 = 0
          r2310 = 0
          r5210 = 0
          r5310 = 0
          v2190 = 0
          v2310 = 0
          v5210 = 0
          v5310 = 0
          BKK=SUB(GGK:BKK,1,3)
          CASE bkk
          OF '219'
             p2190 += ggk:summa
             l2190 += ggk:summa
             r2190  = ggk:summa
          OF '231'
             p2310 += ggk:summa
             l2310 += ggk:summa
             r2310  = ggk:summa
          OF '521'
             p5210 += ggk:summa
             l5210 += ggk:summa
             r5210  = ggk:summa
          OF '531'
             p5310 += ggk:summa
             l5310 += ggk:summa
             r5310  = ggk:summa
          .
          !El IF ~(GGK:val = 'LVL' or GGK:val = 'Ls')
          IF ~(GGK:val = val_uzsk)
            VALUTAP=TRUE
          .
          IF ~BAND(GGK:BAITS,00000001b)     ! NAV IEZAKS
             GET(K_TABLE,0)
             K:NOS=GGK:VAL
             GET(K_TABLE,K:NOS)
             IF ERROR()
                KLUDA('16',GGK:U_NR)
                FREE(K_TABLE)
                CLOSE(REPORT)
                DO PROCEDURERETURN
             .
             BKK=SUB(GGK:BKK,1,3)
             CASE bkk
             OF '219'
                K:p2190 += ggk:summav
                v2190 = ggk:summav
             OF '231'
                K:p2310 += ggk:summav
                v2310 = ggk:summav
             OF '521'
                K:p5210 += ggk:summav
                v5210 = ggk:summav
             OF '531'
                K:p5310 += ggk:summav
                v5310 = ggk:summav
             .
             vnos = ggk:VAL
             PUT(K_TABLE)
          .
          gg:U_nr = ggk:U_nr
          GET(gg,gg:nr_key)
          IF ERROR() THEN CLEAR(gg:RECORD).
          GGNR   = GG:u_nr
          datums = gg:datums
          TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
          ! FORMAT_TEKSTS(55,'ARIAL',8,'')   ! %%%% disabled -> 049
          SATURS = F_TEKSTS[1]
          SATURSV = F_TEKSTS[2]
          SATURS2 = F_TEKSTS[2]
          SATURS3 = F_TEKSTS[3]
!          IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL') OR F_TEKSTS[2]  !B�S J�DRUK� VISMAZ 2 RINDAS
!             DOK_NR = GETDOK_SENR(4,GG:DOK_SENR,,GG:ATT_DOK)
!          ELSE
             DOK_NR = GG:DOK_SENR
!          .
          IF ~F:DTK
              IF F:DBF = 'W'                                              !
                  PRINT(RPT:DETAIL)
              ELSE
                  OUTA:LINE=CLIP(GGNR)&CHR(9)&DOK_NR&CHR(9)&FORMAT(DATUMS,@D06.)&CHR(9)&SATURS&CHR(9)&|
                            LEFT(FORMAT(R2190,@N-_13.2B))&CHR(9)&LEFT(FORMAT(R2310,@N-_13.2B))&CHR(9)&|
                            LEFT(FORMAT(R5210,@N-_13.2B))&CHR(9)&LEFT(FORMAT(R5310,@N-_13.2B))
                  ADD(OUTFILEANSI)
              .
          END
          !El IF ~(GGK:VAL='Ls' or GGK:VAL='LVL')
          IF ~(GGK:VAL=val_uzsk)
            IF ~F:DTK
!              DOK_NR = GETDOK_SENR(5,GG:DOK_SENR,,GG:ATT_DOK)
              IF F:DBF = 'W'                                              !
                  PRINT(RPT:DETAILV)
              ELSE
                  OUTA:LINE='T.S.'&CHR(9)&CHR(9)&CHR(9)&SATURSV&CHR(9)&LEFT(FORMAT(V2190,@N-_13.2))&CHR(9)&|
                             LEFT(FORMAT(V2310,@N-_13.2))&CHR(9)&LEFT(FORMAT(V5210,@N-_13.2))&CHR(9)&|
                             LEFT(FORMAT(V5310,@N-_13.2))&CHR(9)&VNOS
                  ADD(OUTFILEANSI)
              END
            END
          ELSIF SATURS2
           IF ~F:DTK
!             DOK_NR = GETDOK_SENR(2,GG:DOK_SENR,,GG:ATT_DOK)
             IF F:DBF='W'
               PRINT(RPT:DETAIL2)
             ELSE
               OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&SATURS2
               ADD(OUTFILEANSI)
             END
           END
          .
          IF SATURS3
           IF ~F:DTK
            IF F:DBF = 'W'
              PRINT(RPT:DETAIL3)
            ELSE
              OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&SATURS3
              ADD(OUTFILEANSI)
            END
           END
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
  !IF SEND(GGK,'QUICKSCAN=off').   %%%%%% why this causes err?
  IF LocalResponse = RequestCompleted
    dat = today()
    lai = clock()
    IF F:DBF = 'W'
        PRINT(RPT:PER_FOOT)
    ELSE
        OUTA:LINE='Kop� pa periodu:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(P2190,@N-_13.2B))&CHR(9)&|
                   LEFT(FORMAT(P2310,@N-_13.2B))&CHR(9)&LEFT(FORMAT(P5210,@N-_13.2B))&CHR(9)&|
                   LEFT(FORMAT(P5310,@N-_13.2B))&CHR(9)&val_uzsk
                   !El LEFT(FORMAT(P5310,@N-_13.2B))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF VALUTAP
      TSP ='Tai skait� :'
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF k:p2190+k:p2310+k:p5210+k:p5310 <> 0
          pv2190 = k:p2190
          pv2310 = k:p2310
          pv5210 = k:p5210
          pv5310 = k:p5310
          pvnos  = k:nos
          IF F:DBF = 'W'
            PRINT(RPT:PER_FOOTV)
          ELSE
            OUTA:LINE=TSP&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PV2190,@N-_13.2B))&CHR(9)&|
                      LEFT(FORMAT(PV2310,@N-_13.2B))&CHR(9)&LEFT(FORMAT(PV5210,@N-_13.2B))&CHR(9)&|
                      LEFT(FORMAT(PV5310,@N-_13.2B))&CHR(9)&PVNOS
            ADD(OUTFILEANSI)
          END
          tsp= ''
        .
      .
    .
    PRINT(RPT:PER_FOOT1)
    IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT)
    ELSE
        OUTA:LINE='Kop� no gada s�kuma:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K2190,@N-_13.2B))&CHR(9)&|
                   LEFT(FORMAT(K2310,@N-_13.2B))&CHR(9)&LEFT(FORMAT(K5210,@N-_13.2B))&CHR(9)&|
                   LEFT(FORMAT(K5310,@N-_13.2B))&CHR(9)&val_uzsk
                   !El LEFT(FORMAT(K5310,@N-_13.2B))&CHR(9)&'Ls'
        ADD(OUTFILEANSI)
    END
    IF VALUTA
      TS ='Tai skait� :'
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF k:k2190+k:k2310+k:k5210+k:k5310 <> 0
          kv2190 = k:k2190
          kv2310 = k:k2310
          kv5210 = k:k5210
          kv5310 = k:k5310
          kvnos  = k:nos
          IF F:DBF = 'W'
            PRINT(RPT:RPT_FOOTV)
          ELSE
            OUTA:LINE=TS&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KV2190,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KV2310,@N-_13.2B))&|
                      CHR(9)&LEFT(FORMAT(KV5210,@N-_13.2B))&CHR(9)&LEFT(FORMAT(KV5310,@N-_13.2B))&CHR(9)&KVNOS
            ADD(OUTFILEANSI)
          END
          ts = ''
        .
      .
    .
    PRINT(RPT:RPT_FOOT1)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'
        !  RP    ! %%%%% disabled RP -> 050
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
      !  ANSIJOB   ! %%%%% disabled ->258
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

!-----------------------------------------------------------------------------------------------------------------------
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
  FREE(K_TABLE)
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
  IF ERRORCODE() OR ~(GGK:PAR_NR=PAR_NR)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
NEXTVAL     ROUTINE
  LOOP UNTIL EOF(VAL_K)
    NEXT(VAL_K)
    EXIT
  .
  V# = 1
kluda                PROCEDURE (OPC,NORADE,<DA>,<KRASA>) ! Declare Procedure
CLAKLUDA         STRING(80)
ZINA             STRING(90)
ZINA1            STRING(90)
CLANR            DECIMAL(2)
soundfile        CSTRING(80)

window WINDOW('   K��da '),AT(,,358,71),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),CENTER,IMM, |
         ICON('CLARION.ICO'),SYSTEM,GRAY,MODAL
       STRING(@s85),AT(2,11,351,10),USE(zina1),CENTER,FONT(,,COLOR:Blue,FONT:bold,CHARSET:BALTIC)
       STRING(@s85),AT(2,20,351,10),USE(zina),CENTER,FONT(,,COLOR:Red,FONT:bold,CHARSET:BALTIC)
       STRING(@s80),AT(13,32,331,10),USE(CLAKLUDA),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       BUTTON('&dar�t'),AT(293,45,58,14),USE(?darit),DEFAULT
       BUTTON('&nedar�t'),AT(240,45,49,14),USE(?nedarit)
     END
  CODE                                            ! Begin processed code
!
!  KRASA=1 ZI�A ZIL� KR�S�
!

  soundfile='\WINLATS\BIN\KLUDA.wav'
  ! sndPlaySoundA(soundfile,1)   ! %%%%% kernel proc
  CLAKLUDA=ERROR()
  CLANR   =ERRORCODE()
  OPEN(WINDOW)
  IF OPC
     CHECKOPEN(KLUDAS,1)
     CLEAR(KLU:RECORD)
     KLU:NR=OPC
     GET(KLUDAS,KLU:NR_KEY)
     IF ERROR()
         ZINA='K��das KODS= '&CLIP(OPC)&' pa�emiet KLUDAS.TPS no www.assako.lv <BIN>'
     ELSE
        CASE KLU:KARTIBA
        OF 1                                        ! OTR�DI
            ZINA=CLIP(NORADE)&' '&CLIP(KLU:KOMENT)
        ELSE
            ZINA=CLIP(KLU:KOMENT)&' '&CLIP(NORADE)
        .
        IF ~DA
           DA=KLU:DARBIBA
        .
     .
  ELSE                                              ! IZSAUKTS AR 0
     CLEAR(KLU:RECORD)
     ZINA=CLIP(NORADE)
  .
  CASE(DA)
  OF 0
  OROF 1
     ?DARIT{prop:text}='   &OK  '
     HIDE(?NEDARIT)
  OF 2
     ?DARIT{prop:text}='   &OK  '
     ?NEDARIT{prop:text}=' &Atlikt  '
  OF 3
     ?DARIT{prop:text}=' Aiz&vietot  '
     ?NEDARIT{prop:text}=' &Atlikt  '
  OF 4
     ?DARIT{prop:text}=' &P�rr��in�t  '
     ?NEDARIT{prop:text}=' &Atlikt  '
  OF 5
     ?DARIT{prop:text}=' Aiz&vietot  '
     ?NEDARIT{prop:text}='&Atst�t k� ir'
  OF 6
     ?DARIT{prop:text}=' At&jaunot '
     ?NEDARIT{prop:text}=' &Atlikt  '
  OF 7
     ?DARIT{prop:text}=' &OK '
     ?NEDARIT{prop:text}=' &Nevajag  '
  OF 8
     ?DARIT{prop:text}=' Iz&veidot  '
     ?NEDARIT{prop:text}=' &Atlikt  '
  OF 9
     ?DARIT{prop:text}=' &Atlikt  '
     ?NEDARIT{prop:text}='   &OK  '
  OF 10
     ?DARIT{prop:text}=' &Atlikt  '
     ?NEDARIT{prop:text}='Aiz&vietot'
  OF 11
     ?DARIT{prop:text}=' &Nevajag'
     ?NEDARIT{prop:text}=' &Main�t'
  OF 12
     ?DARIT{prop:text}=' &Apskat�t'
     ?NEDARIT{prop:text}=' &P�rb�v�t'
  .
  IF KRASA=1 !ZIL� KR�S�
     ZINA1=ZINA
     ZINA=''
     WINDOW{PROP:TEXT}='Zi�a'
  .
  CLAKLUDA='WinLats: '&CLIP(OPC)&' Clarion5: '&CLIP(CLANR)&' '&CLAKLUDA
  DISPLAY
  accept
     case field()
     of ?darit
       if event()=EVENT:Accepted
          KLU_DARBIBA=1
          Globalresponse=RequestCompleted
          BREAK
       .
     of ?nedarit
       if event()=EVENT:Accepted
          KLU_DARBIBA=0
          Globalresponse=RequestCompleted
          BREAK
       .
     .
  .
!  STOP(KLU_DARBIBA)
  close(window)
inigen               FUNCTION (LAUKS,<GAR>,OPC)   ! Declare Procedure
BURTI        STRING(25) !22.04.2009. +1 06.05.2009. +2
BURTIM       STRING(22) !CH CASE
SUBST        STRING(6),DIM(4)

  CODE                                            ! Begin processed code
! stop(1)   INIGEN LIETO AR� CHECK_CLIENT
 IF ~INRANGE(OPC,1,10)
    STOP('INIGEN: PIEPRAS�TS ATGRIEZT:'&OPC)
    RETURN('')
 .
 IF ~GAR OR (GAR > LEN(CLIP(LAUKS))) THEN GAR=LEN(CLIP(LAUKS)).
 IF ~GAR THEN RETURN('').
 CASE OPC
 OF 1
     BURTI='AaCcEeGgIiKkLlNnSsUuZz'
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'����������������������')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 2
     BURTI='�����������'
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'�����������')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 3
     KLUDA(0,'Tiks main�ti Lielie/mazie burti(CASE) teko�ajam laukam',5,1)
     IF KLU_DARBIBA
        BURTI ='�����������'
        BURTIM='�����������'
        LOOP I# = 1 TO gar
           J#=INSTRING(lauks[I#],'�����������')
           K#=INSTRING(lauks[I#],'�����������')
           IF J#
              LAUKS[I#]=BURTI[J#]
           ELSIF K#
              LAUKS[I#]=BURTIM[K#]
           ELSE
              !IF ISUPPER(LAUKS[I#])     ! possible ISUPPER is undefined function %%%%
              !   LAUKS[I#]=LOWER(LAUKS[I#])
              !ELSIF ISLOWER(LAUKS[I#])
              !   LAUKS[I#]=UPPER(LAUKS[I#])
              !.
           .
        .
     .
 OF 4
     BURTI='AACCEEGGIIKKLLNNSSUUZZ'
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'����������������������')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
     LAUKS=UPPER(LAUKS)
 OF 5  ! TELEHANSAS BURTI UN SIMBOLI
     BURTI='AaCcEeGgIiKkLlNnSsUuZz Oo'
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'����������������������&��')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 6  ! eBankas SIMBOLI
     BURTI=' #           '
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'@#$%^&*?~;"=\')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 7  ! COMMAND LINE BURTI UN SIMBOLI
     BURTI='AaCcEeGgIiKkLlNnSsUuZzu_'
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'����������������������& ')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 8  ! OUTLOOK COMLINE SIMBOLI
     BURTI=' '
     LOOP I# = 1 TO gar
        J#=INSTRING(lauks[I#],'&')
        IF J#
           LAUKS[I#]=BURTI[J#]
        .
     .
 OF 9  ! UNIKODI UZ 1257 "."
     BURTI='.'
     garumzime196#=FALSE
     garumzime197#=FALSE
     TUKSS# = 0
     K#+=1

     LOOP I# = 1 TO gar
        J#=VAL(lauks[I#])
!        STOP(J#&' = '&LAUKS[I#])
!        STOP(DEFORMAT(lauks[I#],@N_4)&' = '&LAUKS[I#])
!        IF ~INRANGE(DEFORMAT(lauks[I#],@N_4),0020h,007Eh) THEN LAUKS[I#]='.'.
!        IF ~INRANGE(J#,0020h,007Eh) THEN LAUKS[I#]='.'.
        IF garumzime196#=TRUE THEN
           IF J# = 128
              LAUKS[K#]='�'
           ELSIF J# = 146
              LAUKS[K#]='�'
           ELSIF J# = 170
              LAUKS[K#]='�'
           ELSIF J# = 162
              LAUKS[K#]='�'
           ELSIF J# = 182
              LAUKS[K#]='�'
           ELSIF J# = 187
              LAUKS[K#]='�'
           ELSIF J# = 140
              LAUKS[K#]='�'
           ELSIF J# = 129
              LAUKS[K#]='a'
           ELSIF J# = 147
              LAUKS[K#]='�'
           ELSIF J# = 171
              LAUKS[K#]='�'
           ELSIF J# = 163
              LAUKS[K#]='�'
           ELSIF J# = 183
              LAUKS[K#]='�'
           ELSIF J# = 188
              LAUKS[K#]='�'
           ELSIF J# = 141
              LAUKS[K#]='�'
           ELSE
              LAUKS[K#]=' '
           .
           garumzime196#=FALSE
        ELSIF garumzime197#=TRUE THEN
           IF J# = 170
              LAUKS[K#]='�'
           ELSIF J# = 160
              LAUKS[K#]='�'
           ELSIF J# = 189
              LAUKS[K#]='�'
           ELSIF J# = 133
              LAUKS[K#]='�'
           ELSIF J# = 171
              LAUKS[K#]='�'
           ELSIF J# = 161
              LAUKS[K#]='�'
           ELSIF J# = 190
              LAUKS[K#]='�'
           ELSIF J# = 134
              LAUKS[K#]='�'
           ELSE
              LAUKS[K#]=' '
           .
           garumzime197#=FALSE
        ELSE
           IF J# = 196
              !stop ('garumzime196')
              garumzime196#=TRUE
              TUKSS# += 1
              CYCLE
           ELSIF J# = 197
              !stop ('garumzime197')
              garumzime197#=TRUE
              TUKSS# += 1
              CYCLE
           .
           LAUKS[K#]=LAUKS[I#]
        .
        K#+=1
     .
     IF TUKSS# > 0 THEN
        LOOP I# = 0 TO TUKSS#-1
           LAUKS[K#+I#] =''
        .
     .
 OF 10 ! NOV�CAM BANKAS SUBSTIT�CIJAS---PAGAIDU L�P��AN�S
     BURTI='""<>'
     SUBST[1]='&quot;'
     SUBST[2]='&apos;'
     SUBST[3]='&lt;'
     SUBST[4]='&gt;'
     LOOP 2 TIMES
        LOOP I#=1 TO 4
           J#=INSTRING(CLIP(SUBST[I#]),LAUKS,1,1)
           IF J#
              LAUKS[J#]=BURTI[I#]
              LAUKS=LAUKS[1:J#]&LAUKS[J#+LEN(CLIP(SUBST[I#])):LEN(CLIP(LAUKS))]
   !        STOP(I#&'+'&LAUKS)
           .
        .
     .
 .
 RETURN(sub(LAUKS,1,gar))


