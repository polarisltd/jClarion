                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_DEK_2010       PROCEDURE                    ! Declare Procedure
CG           STRING(10)
RejectRecord LONG
ceturksnis   BYTE
pusgads      BYTE

K31          REAL
K33          REAL
K34          REAL
K54          REAL
K56          REAL

R40          DECIMAL(12,2)
R41          DECIMAL(12,2)
R42          DECIMAL(12,2)
R43          DECIMAL(12,2)
R44          DECIMAL(12,2)
R45          DECIMAL(12,2)
R46          DECIMAL(12,2)
R47          DECIMAL(12,2)
R48          DECIMAL(12,2)
R481         DECIMAL(12,2)
R482         DECIMAL(12,2)
R49          DECIMAL(12,2)
R50          DECIMAL(12,2)
R51          DECIMAL(12,2)

R52          DECIMAL(12,2)
R53          DECIMAL(12,2)
R54          DECIMAL(12,2)
R55          DECIMAL(12,2)
R56          DECIMAL(12,2)

R60          DECIMAL(12,2)
R61          DECIMAL(12,2)
R62          DECIMAL(12,2)
R63          DECIMAL(12,2)
R64          DECIMAL(12,2)
R65          DECIMAL(12,2)
R66          DECIMAL(12,2)
R67          DECIMAL(12,2)
R68          DECIMAL(12,2)
R57          DECIMAL(12,2)
R58          DECIMAL(12,2)

R70          DECIMAL(12,2)
R80          DECIMAL(12,2)

SS           DECIMAL(12,2)
PP           DECIMAL(12,2)
PVN1_1       BYTE
PVN1_2       BYTE
PVN1_3       BYTE
PIELIKUMI    STRING(25)

NODOKLKODS   BYTE,DIM(2)
NovirzSumma  DECIMAL(12,2),DIM(2)    !PVN PÂRMAKSU novirzît UZ CITU NODOKLI
KONTANR      STRING(7),DIM(2)

IbanNumurs            STRING(21)
ParmaksUzKontuSumma   DECIMAL(12,2)  !PVN PÂRMAKSU UZ NM IBAN-u

PROP         REAL
DATUMS       DATE
MENESS       STRING(20)
RSS          STRING(11)
RSSS         STRING(11)

NOT1         STRING(45)
NOT2         STRING(45)
NOT3         STRING(45)
PRECIZETA    STRING(10)
E            STRING(1)
EE           STRING(15)
VIRSRAKSTS   STRING(70)

!Q_TABLE      QUEUE,PRE(Q) !ES
!U_NR            ULONG
!SUMMA           DECIMAL(12,2),DIM(2)
!PVN             DECIMAL(12,2),DIM(2)
!             .

K_TABLE      QUEUE,PRE(K) !KASE
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(6) !10.02.2011
ANOTHER_K       BYTE
             .

PPR             BYTE,DIM(2)

SOURCE_FOR_50   DECIMAL(12,2),DIM(3)
SOURCE_FOR_51   DECIMAL(12,2),DIM(3)
SOURCE_FOR_41   DECIMAL(12,2),DIM(3)
SOURCE_FOR_42   DECIMAL(12,2),DIM(3)

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

TEX:DUF         STRING(100)
RI              DECIMAL(12,2)
SB_DAT          STRING(23)
VK_PAR_NR       LIKE(PAR_NR)

XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

!-----------------------------------------------------------------------------
PrintSkipDetails     BOOL,AUTO
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



report REPORT,AT(198,104,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',9,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(10,10,8000,11250),USE(?unnamed)
         STRING(@S10),AT(469,156),USE(PRECIZETA),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienests'),AT(2313,625),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7375,813),USE(?String1:2),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4938,604,2813,156),USE(NOT3),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,302,2813,156),USE(NOT1),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,458,2813,156),USE(NOT2),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@S70),AT(406,927,6719,229),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(taksâcijas periods)'),AT(5135,1146,1198,156),USE(?String3),CENTER
         STRING(@s23),AT(2281,1135),USE(SB_DAT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pielikums'),AT(7177,156,469,156),USE(?String107),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(3677,167),USE(EE),TRN,LEFT(1)
         STRING(@S1),AT(3385,52,281,333),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums:'),AT(521,1406),USE(?String8),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(2656,1406,3333,208),USE(CLIENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(7219,1417),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('Juridiskâ adrese:'),AT(521,1625),USE(?String10),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(1615,1625,3385,208),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1354,0,6979),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(208,1354,7552,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Apliekamâs personas reìistrâcijas Numurs :'),AT(521,1833),USE(?String12),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(3229,1833,1094,208),USE(GL:VID_NR),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6115,2281,0,6052),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(6521,2281,0,6052),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(7760,1354,0,6979),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Tâlrunis:'),AT(521,2052),USE(?String10:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s15),AT(1094,2052,1198,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2281,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'),AT(594,2333,3073,208),USE(?String18),LEFT, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('40'),AT(6260,2396,208,156),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,2396,885,156),USE(R40),RIGHT
         STRING('ar standartlikmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,2531,3094,156),USE(?String19), |
             LEFT
         STRING('ar PVN 0% apliekamie darîjumi, t.sk.:'),AT(594,2833,2552,156),USE(?String19:2),LEFT
         STRING('-uz ES dalîbvalstîm piegâdâtâs preces'),AT(750,3146,2448,156),USE(?String19:3),LEFT
         STRING('43'),AT(6260,2844,208,156),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,2688,885,156),USE(R42),RIGHT
         STRING(@N-_12.2B),AT(6656,2844,885,156),USE(R43),RIGHT
         STRING(@N-_12.2B),AT(6656,3000,885,156),USE(R44),RIGHT
         LINE,AT(208,8333,7552,0),USE(?Line11:4),COLOR(COLOR:Black)
         LINE,AT(3594,8594,0,573),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(4010,8594,0,573),USE(?Line29:4),COLOR(COLOR:Black)
         LINE,AT(5313,8594,0,573),USE(?Line29:2),COLOR(COLOR:Black)
         STRING('Novirzâmâ summa'),AT(4115,8646),USE(?String134:2),TRN
         STRING('Novirzît PVN pârmaksas summu citu nodokïu,'),AT(938,8750,2708,208),USE(?String59:2), |
             TRN,LEFT
         STRING('Kods'),AT(3646,8646),USE(?String134),TRN
         STRING('Valsts budþeta ieò. konta pçdçjie 7 cipari'),AT(5417,8646),USE(?String134:3),TRN
         STRING(@N-_12.2B),AT(4271,8854,833,156),USE(NOVIRZSUMMA[1]),TRN,RIGHT
         STRING(@s7),AT(5885,8854,917,156),USE(KONTANR[1]),TRN,CENTER
         STRING(@N1B),AT(3750,8854),USE(NODOKLKODS[1],,?NODOKLKODS1:2),TRN
         STRING(@N-_12.2B),AT(4271,9010,833,156),USE(NOVIRZSUMMA[2]),TRN,RIGHT
         STRING(@s7),AT(5885,9010,917,156),USE(KONTANR[2]),TRN,CENTER
         STRING(@N1B),AT(3750,9010),USE(NODOKLKODS[2]),TRN
         LINE,AT(3594,8594,4167,0),USE(?Line11:2),COLOR(COLOR:Black)
         STRING('Pârskaitît PVN pârmaksas summu'),AT(938,9271,2083,208),USE(?String59:4),TRN,LEFT
         STRING(@N-_12.2B),AT(4271,9323,833,156),USE(ParmaksUzKontuSumma),TRN,RIGHT
         STRING(@s21),AT(5583,9313,1719,208),USE(IbanNumurs),TRN,CENTER
         LINE,AT(3594,8802,4167,0),USE(?Line11:5),COLOR(COLOR:Black)
         LINE,AT(3594,9167,4167,0),USE(?Line11:3),COLOR(COLOR:Black)
         STRING('Ar PVN neapliekamie darîjumi'),AT(594,4063,1823,156),USE(?String31:7)
         STRING('47'),AT(6260,3469,208,156),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3469,885,156),USE(R47),RIGHT
         STRING('-uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'),AT(750,3458,3333,156),USE(?String19:7), |
             LEFT
         STRING('PRIEKÐNODOKLIS (latos), no tâ :'),AT(594,5615,2292,156),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4740,885,156),USE(R52),RIGHT
         STRING('54'),AT(6260,5052,208,156),USE(?String22:29),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('51'),AT(6260,4375,208,156),USE(?String22:10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4375,885,156),USE(R51),RIGHT
         STRING('No ES dalîbvalstîm saòemtâs preces (samazinâtâ likme)'),AT(594,4375,4208,156),USE(?String31:3)
         STRING('par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'),AT(594,5771,3958,156), |
             USE(?String37),LEFT
         STRING('par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'),AT(594,5927,4740,156), |
             USE(?String38),LEFT
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu (izòemot 64.rindu)'),AT(594,6083,5177,156), |
             USE(?String39),LEFT
         STRING('lauksaimniekiem izmaksâtâ  kompensâcija'),AT(594,6396,3438,156),USE(?String40)
         STRING(@N-_12.2B),AT(6708,6240,833,156),USE(R64),RIGHT
         STRING('66'),AT(6260,6552,208,156),USE(?String22:17),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6719,833,156),USE(R67),RIGHT
         STRING(@N-_12.2B),AT(6708,6396,833,156),USE(R65),RIGHT
         STRING('[P]'),AT(6260,7396,167,156),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('67'),AT(6260,6719,208,156),USE(?String22:18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas:'),AT(594,6771,729,156),USE(?String46:4),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@N-_12.2B),AT(6708,7031,833,156),USE(R68),RIGHT
         STRING(@N-_12.2B),AT(6656,7188,885,156),USE(R58),RIGHT
         STRING('KOPSUMMA:'),AT(594,7438),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitâmais priekðnodoklis'),AT(2000,7396,1719,156),USE(?String46:8),TRN,LEFT
         STRING('aprçíinâtais nodoklis'),AT(2000,7188,1719,156),USE(?String46:7),TRN,LEFT
         STRING('atskaitâmais priekðnodoklis'),AT(2000,7031,1719,156),USE(?String46:6),TRN,LEFT
         STRING('[S]'),AT(6260,7552,167,156),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais nodoklis'),AT(2000,7552,1719,156),USE(?String46:9),TRN,LEFT
         STRING('Sask.ar likuma 13.2.p.:'),AT(594,7083,1344,156),USE(?String46:5),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@N-_12.2B),AT(6656,7552,885,156),USE(SS),RIGHT
         STRING('58'),AT(6260,7188,208,156),USE(?String22:26),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APSTIPRINU PIEVIENOTÂS VÇRTÎBAS NODOKÏA APRÇÍINU .'),AT(313,9896),USE(?String63),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,9271,0,313),USE(?Line29:11),COLOR(COLOR:Black)
         LINE,AT(7760,8594,0,573),USE(?Line29:8),COLOR(COLOR:Black)
         LINE,AT(365,8750,469,0),USE(?Line29:7),COLOR(COLOR:Black)
         LINE,AT(365,9063,469,0),USE(?Line29:6),COLOR(COLOR:Black)
         LINE,AT(365,8750,0,313),USE(?Line29:5),COLOR(COLOR:Black)
         STRING('nodevu vai noteikto maksâjumu veikðanai'),AT(938,8906,2552,208),USE(?String59:5),TRN, |
             LEFT
         STRING('Atbildîgâ persona :'),AT(313,10208),USE(?String64),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(365,9271,469,0),USE(?Line29:9),COLOR(COLOR:Black)
         STRING(@S1),AT(7604,11042,156,188),USE(RS),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(1979,10885,5729,0),USE(?Line1:18),COLOR(COLOR:Black)
         STRING('R : '),AT(7448,11042,135,188),USE(?String99),FONT(,7,,,CHARSET:ANSI)
         STRING('VID atbildîgâ amatpersona:'),AT(313,10677),USE(?String73),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Konta Nr. (IBAN 21 simbols)'),AT(5552,9542,1875,208),USE(?String59:8),TRN,LEFT
         STRING(@s5),AT(6875,11042),USE(KKK)
         STRING(@s20),AT(4063,10208),USE(SYS:PARAKSTS1),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('(datums)'),AT(5729,10469),USE(?String68),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(7760,9271,0,260),USE(?Line29:15),COLOR(COLOR:Black)
         LINE,AT(5313,9271,0,260),USE(?Line29:14),COLOR(COLOR:Black)
         LINE,AT(3594,9531,4167,0),USE(?Line11:7),COLOR(COLOR:Black)
         LINE,AT(3594,9271,0,260),USE(?Line29:13),COLOR(COLOR:Black)
         STRING('uz apliekamâs personas kontu'),AT(938,9427,1875,208),USE(?String59:6),TRN,LEFT
         LINE,AT(833,9271,0,313),USE(?Line29:12),COLOR(COLOR:Black)
         LINE,AT(365,9583,469,0),USE(?Line29:10),COLOR(COLOR:Black)
         STRING('Pielikumi: '),AT(344,9688),USE(?String158),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s25),AT(1031,9688),USE(PIELIKUMI),TRN
         LINE,AT(833,8750,0,313),USE(?Line29:3),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2292,10469,1646,198),USE(?String67:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(3594,9271,4167,0),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@d06.),AT(5677,10208),USE(datums),FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(1510,10417,2448,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2448,10938),USE(?String67),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Pieprasîjums par pievienotâs vçrtîbas nodokïa pârmaksas atmaksu'),AT(2240,8385),USE(?String63:2), |
             TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('(datums)'),AT(5729,10938,531,198),USE(?String68:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Budþetâ maksâjamâ nodokïa summa, ja P<<S'),AT(594,8125),USE(?String59:3),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,8125,885,208),USE(R80),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,7917,885,208),USE(R70),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('80'),AT(6208,8125,260,208),USE(?String22:20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('attiecinâmâ nodokïa summa, ja P>S'),AT(594,7917,3490,208),USE(?String60),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,7396,833,156),USE(PP),RIGHT
         STRING('68'),AT(6260,7031,208,156),USE(?String22:21),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,6875,885,156),USE(R57),RIGHT
         STRING('iepriekðçjos taks. periodos atskaitîtâ priekðnodokïa samazinâjums'),AT(1323,6875,4375,156), |
             USE(?String46:3),TRN,LEFT
         STRING('iepriekðçjos taks. periodos sam. budþetâ apreíinâtâ nodokïa samazinâjums'),AT(1323,6719,4375,156), |
             USE(?String46:2),TRN,LEFT
         STRING('57'),AT(6260,6875,208,156),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6552,833,156),USE(R66),RIGHT
         STRING('63'),AT(6260,6083,208,156),USE(?String22:14),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais priekðnodoklis par precçm un pakalpojumiem, kas saòemti no ES dalîb' &|
             'valstîm'),AT(594,6240,5458,156),USE(?String39:2),LEFT
         STRING(@N-_12.2B),AT(6708,5771,833,156),USE(R61),RIGHT
         STRING('ar samazinâto likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(594,5365,4792,156), |
             USE(?String31:6)
         STRING(@N-_12.2B),AT(6656,5354,885,156),USE(R56),RIGHT
         STRING('ar standartlikmi  apliekamâm precçm un pakalpojumiem, kas saòemtas no ES dalîbva' &|
             'lstîm'),AT(594,5208,5333,156),USE(?String31:5)
         STRING('70'),AT(6208,7917,260,208),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'),AT(594,7708,4844,208), |
             USE(?String59),LEFT
         STRING('62'),AT(6260,5927,208,156),USE(?String22:13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('61'),AT(6260,5771,208,156),USE(?String22:12),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('60'),AT(6260,5615,208,156),USE(?String22:11),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,5615,833,156),USE(R60),RIGHT
         STRING(@N-_12.2B),AT(6656,4896,885,156),USE(R53),RIGHT
         STRING('55'),AT(6260,5208,208,156),USE(?String22:30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('48'),AT(6260,3615,208,156),USE(?String22:27),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3615,885,156),USE(R48,,?R48:2),RIGHT
         STRING('-eksportçtâs preces'),AT(760,3750,2458,156),USE(?String29),TRN,LEFT
         STRING('48(1)'),AT(6156,3750,313,156),USE(?String22:9),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3771,885,156),USE(R481),TRN,RIGHT
         STRING(@N-_12.2B),AT(6656,3917,885,156),USE(R482),TRN,RIGHT
         STRING('Citâs valstîs veiktie darîjumi'),AT(594,3906,1823,156),USE(?String31),TRN
         STRING('48(2)'),AT(6156,3906,313,156),USE(?String22:32),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Neatskaitâmais priekðnodoklis'),AT(594,6552,1771,156),USE(?String46),LEFT
         STRING('65'),AT(6260,6396,208,156),USE(?String22:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6083,833,156),USE(R63),RIGHT
         STRING('64'),AT(6260,6240,208,156),USE(?String22:15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,5927,833,156),USE(R62),RIGHT
         STRING(@N-_12.2B),AT(6656,5052,885,156),USE(R54),RIGHT
         STRING('56'),AT(6260,5365,208,156),USE(?String22:31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar standartlikmi apliekamiem darîjumiem'),AT(594,4740,2240,156),USE(?String19:8),LEFT
         STRING('49'),AT(6260,4063,208,156),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,5208,885,156),USE(R55),RIGHT
         STRING('par saòemtajiem pakalpojumiem'),AT(594,5052,2604,156),USE(?String31:4)
         STRING('ar samazinâto likmi apliekamiem darîjumiem'),AT(594,4896,2969,156),USE(?String19:9), |
             LEFT
         STRING('No ES dalîbvalstîm saòemtâs preces un pakalpojumi (standartlikme)'),AT(604,4219,4188,156), |
             USE(?String31:2)
         STRING('50'),AT(6260,4219,208,156),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4219,885,156),USE(R50),RIGHT
         STRING('46'),AT(6260,3313,208,156),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3313,885,156),USE(R46),RIGHT
         STRING('ârpuskopienas preèu piegâdes muitas noliktavâs un brîvajâs zonâs'),AT(750,3302,4510,156), |
             USE(?String19:6),LEFT
         STRING(@N-_12.2B),AT(6656,4063,885,156),USE(R49),RIGHT
         STRING('-par sniegtajiem pakalpojumiem'),AT(750,3604,2458,156),USE(?String29:2),LEFT
         STRING('45'),AT(6260,3156,208,156),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3156,885,156),USE(R45),RIGHT
         STRING('44'),AT(6260,3000,208,156),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('-darîjumi, kas veikti brîvostâs un SEZ'),AT(750,2990,2292,156),USE(?String19:5),LEFT
         STRING(@N-_12.2B),AT(6656,2531,885,156),USE(R41),RIGHT
         STRING('42'),AT(6260,2688,208,156),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN (latos)'),AT(594,4552),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('52'),AT(6260,4740,208,156),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('53'),AT(6260,4896,208,156),USE(?String22:28),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('41'),AT(6260,2531,208,156),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar samazinâto likmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,2677,3479,156),USE(?String19:4), |
             LEFT
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

PVNA02Window WINDOW('PVN-A-02'),AT(,,369,95),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Novirzît PVN pârmaksas summu citu maks. veikðanai   Kods      Summa         Budþ' &|
           '.konta pçd.7 cipari'),AT(3,8,347,10),USE(?String1A01)
       ENTRY(@n1B),AT(183,19,11,10),USE(NODOKLKODS[1],,?NODOKLKODS1W),IMM
       ENTRY(@N10.2B),AT(206,19,48,10),USE(NOVIRZSUMMA[1],,?NOVIRZSUMMA1W),IMM,RIGHT
       ENTRY(@s7),AT(264,19,37,10),USE(KONTANR[1],,?KONTANR1W)
       ENTRY(@n1B),AT(183,32,11,10),USE(NODOKLKODS[2],,?NODOKLKODS2W),IMM
       ENTRY(@N10.2B),AT(206,32,48,10),USE(NOVIRZSUMMA[2],,?NOVIRZSUMMA2W),IMM,RIGHT
       ENTRY(@s7),AT(264,32,37,10),USE(KONTANR[2],,?KONTANR2W)
       STRING('Kodi: 1-VSAOI; 2-IIN; 3-UIN; 4-Dabas resursu nod.; 5-Nodokïi atsev.precçm un pak' &|
           'alpojumiem; 7-Muita; 8-Citi'),AT(3,46),USE(?String3W),FONT(,,COLOR:Gray,,CHARSET:ANSI)
       STRING('Pârskaitît PVN pârmaksas summu uz norçíinu kontu (IBAN)'),AT(3,59),USE(?String2)
       ENTRY(@N10.2B),AT(206,59,48,10),USE(ParmaksUzKontuSumma,,?ParmaksUzKontuSummaW),IMM,RIGHT
       ENTRY(@s21),AT(261,59,97,10),USE(IbanNumurs,,?IbanNumursW),UPR
       BUTTON('OK'),AT(325,72,35,14),USE(?OK:PVNA02),DEFAULT
     END
  CODE                                            ! Begin processed code
!
! PVN DEKLARÂCIJA AR PVN PÂRMAKSAS NOVIRZI/ATMAKSU
! PÇC XML SINTAKSES TE JÂLIEK KLÂT ARÎ KOKMATERIÂLI
!
! INDEKSS 1 :18%/21%/22%
!         2 :5%/10%/12%
!
! SOURCE_FOR_41[1] !18%
! SOURCE_FOR_41[2] !21%
! SOURCE_FOR_41[3] !22%
! SOURCE_FOR_42[1] !5%
! SOURCE_FOR_41[2] !10%
! SOURCE_FOR_41[3] !12%

  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
!  IF VESTURE::USED=0
     CHECKOPEN(VESTURE,1)
!  .
!  VESTURE::USED+=1
!  IF GG::Used = 0
    CHECKOPEN(GG,1)
!  end
!  GG::Used += 1
!  IF KON_K::Used = 0
    CHECKOPEN(KON_K,1)
!  end
!  KON_K::Used += 1
!  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
!  end
!  GGK::Used += 1
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
!  LocalResponse = GlobalResponse
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  OPEN(PVNA02Window)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?ParmaksUzKontuSummaW
        CASE EVENT()
        OF EVENT:Accepted
           IF ParmaksUzKontuSumma AND ~IbanNumurs
              GETMYBANK('') !BANKA=BAN:NOS_P BKODS=BAN:KODS BSPEC=BAN:SPEC BINDEX=BAN:INDEX
                            !REK=GL:REK[SYS:NOKL_B] KOR=GL:KOR[SYS:NOKL_B]
              IbanNumurs=REK
              DISPLAY
           .
        .
     OF ?OK:PVNA02
        CASE EVENT()
        OF EVENT:Accepted
           BREAK
        .
     .
  .
  CLOSE(PVNA02Window)

  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN deklarâcija'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      MENESS=MENVAR(MEN_NR,1,3)
      IF MENESS
         VIRSRAKSTS='Pievienotâs vçrtîbas nodokïa deklarâcija par '&FORMAT(GADS,@N04)&'. gada '&MENESS
      ELSE
         VIRSRAKSTS='Pievienotâs vçrtîbas nodokïa deklarâcija'
      .
      SB_DAT=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
      clear(ggk:record)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K100000'  !GGK,RS,DATUMI,D/K,PVNTi&PVN%,OBJ,NOD
!           1234567
      IF F:IDP THEN PRECIZETA='Precizçtâ'.
      IF F:XML
         E='E'
         EE='(PVN_D.XML)'
      .
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      IF ErrorCode()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ErrorCode()
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !XLS
        IF ~OPENANSI('PVNDKLR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&SB_DAT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas nosaukums:'&CHR(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiskâ adrese:'&CHR(9)&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas reìistrâcijas numurs:'&CHR(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlrunis:'&CHR(9)&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\PVN_D.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
!           XML:LINE=' ?xml version="1.0" encoding="utf-8" ?>'
           XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokPVNv2 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
           ADD(OUTFILEXML)
!           XML:LINE=' Id>1100322</Id>'  !?
!           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu PVN maks. Nr').       !vienkârði kontrolei
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.),,1). !vienkârði kontrolei
           XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
           ADD(OUTFILEXML)
           IF INRANGE(B_DAT-S_DAT,32,100)
              ceturksnis=MONTH(B_DAT)/3
              XML:LINE=' ParskCeturksnis>'&ceturksnis&'</ParskCeturksnis>'
           ELSIF INRANGE(B_DAT-S_DAT,180,200)
              pusgads=MONTH(B_DAT)/6
              XML:LINE=' ParskPusgads>'&pusgads&'</ParskPusgads>'
           ELSE
              XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
           .
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
           ADD(OUTFILEXML)
           XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
           ADD(OUTFILEXML)
!           XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
!           ADD(OUTFILEXML)
           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
           ADD(OUTFILEXML)
           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
           ADD(OUTFILEXML)
!           TEX:DUF=GL:ADRESE                                       !max 250
!           DO CONVERT_TEX:DUF
!           XML:LINE=' NmAdrese>'&CLIP(TEX:DUF)&'</NmAdrese>'
!           ADD(OUTFILEXML)
!           XML:LINE=' ParskCeturksnis xsi:nil="true" />'           !lauks netiek aizpildîts
!           ADD(OUTFILEXML)
           XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
           ADD(OUTFILEXML)
           IF NovirzSumma[1] OR NovirzSumma[2]                     !PVN PÂRMAKSA TIKS NOVIRZÎTA CITA NOD. ATMAKSAI
              XML:LINE=' ParmaksNovirze>1</ParmaksNovirze>'        !TURPINÂJUMS VISAM ÐITAM IR PAÐÂS BEIGÂS <TAB2>
              ADD(OUTFILEXML)
           .
           IF ParmaksUzKontuSumma AND IbanNumurs                   !PVN PÂRMAKSU UZ NM IBAN-u
              XML:LINE=' ParmaksUzKontu>1</ParmaksUzKontu>'
              ADD(OUTFILEXML)
              XML:LINE=' ParmaksUzKontuSumma>'&CLIP(ParmaksUzKontuSumma)&'</ParmaksUzKontuSumma>'
              ADD(OUTFILEXML)
              XML:LINE=' IbanNumurs>'&IbanNumurs&'</IbanNumurs>'
              ADD(OUTFILEXML)
           .
!           XML:LINE=' ParskPusgads xsi:nil="true" />'              !lauks netiek aizpildîts
!           ADD(OUTFILEXML)
        .
    .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           CASE GGK:D_K
       !************************ PVN (P,P IEGÂDE) ********
           OF 'D'                                     ! SAMAKSÂTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! 1-budþetam
               VK_PAR_NR=GGK:PAR_NR
             OF '2'                                   ! 2-PREÈU IMPORTS ~ES
               R61+=GGK:SUMMA
             OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
             OROF ''
             OROF 'N'                                 !
               IF GGK:PVN_PROC=14                     ! KOMPENSÂCIJA 14% ZEMNIEKIEM
                  r65+=GGK:SUMMA
               ELSE
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'    ! ES
                     R64+=GGK:SUMMA
                  ELSE
                     R62+=GGK:SUMMA                   ! LV
                  .
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
               IF GETPAR_K(GGK:PAR_NR,0,20)='C' AND|  ! ES
                  GETPAR_K(GGK:PAR_NR,0,13)           ! PVN MAKSÂTÂJS
                  R64+=GGK:SUMMA
               ELSE                                   ! 10.p.Id
                  R63+=GGK:SUMMA
               .
!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!               R25+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
             OROF 'Z'                                 ! PVN_TIPS=Z ZAUDÇTS PARÂDS
               R67+=GGK:SUMMA
             .
       !************************ SAÒEMTS PVN (REALIZÂCIJA) VAI D&K ES,pakalpojumi RU ********
           OF 'K'                                     ! SAÒEMTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! 1-budþetam
             OF '2'                                   ! 2-OTRA PUSE prece IMPORTS RU ????
               R52+=GGK:SUMMA
!               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
             OF '0'                                   ! SAÒEMTS,REALIZÇJOT VAI D&K ES
             OROF ''
             OROF 'N'                                 ! JA PALICIS iekðzemç nesamaksâtais
             OROF 'I'                                 ! PVN OTRA PUSE PAKALPOJUMIEM NO ES,RU
               CASE GGK:PVN_PROC
               OF 18
               OROF 21
               OROF 22
!                  PPR[1]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'    ! PRECES UZ ES? vai PVN DK no ES
!                     Q:U_NR=GGK:U_NR
!                     GET(Q_TABLE,Q:U_NR)
!                     IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
!                        Q:PVN[1]+=GGK:SUMMA
!                        PUT(Q_TABLE)
!                     ELSE        !ANALÎTISKI
                     IF GGK:PVN_PROC=18
                        SOURCE_FOR_50[1]+=GGK:SUMMA !ES STANDARTLIKME
                     ELSIF GGK:PVN_PROC=21
                        SOURCE_FOR_50[2]+=GGK:SUMMA !ES STANDARTLIKME
                     ELSE
                        SOURCE_FOR_50[3]+=GGK:SUMMA !ES STANDARTLIKME 22%
                     .
!                     STOP(GGK:SUMMA)
!                     .
                     R55+=GGK:SUMMA
                  ELSIF GETPAR_K(GGK:PAR_NR,0,20)='N'    ! PRECES UZ RU? vai PAKALPOJUMU PVN DK no RU
                     R54+=GGK:SUMMA
                  ELSE
!                     K:U_NR=GGK:U_NR       21.04,2011-ARÎ KASI RÇÍINAM ANALÎTISKI
!                     GET(K_TABLE,K:U_NR)
!                     IF ~ERROR() !KASES D261..IR JÂBÛT ATRASTAM, JA TÂDS IR
!!                     STOP('K:PVN: '&GGK:SUMMA)
!                        IF GGK:PVN_PROC=18
!                           K:PVN[1]+=GGK:SUMMA
!                        ELSIF GGK:PVN_PROC=21 !21
!                           K:PVN[2]+=GGK:SUMMA
!                        ELSE !22
!                           K:PVN[3]+=GGK:SUMMA
!                        .
!                        PUT(K_TABLE)
!                     ELSE        !ANALÎTISKI
                        IF GGK:PVN_PROC=18
                           SOURCE_FOR_41[1]+=GGK:SUMMA
                        ELSIF GGK:PVN_PROC=21 !21
                           SOURCE_FOR_41[2]+=GGK:SUMMA
                        ELSE !22
                           SOURCE_FOR_41[3]+=GGK:SUMMA
                        .
!                     .
                     R52+=GGK:SUMMA   !PVN
                  .
               OF 5
               OROF 10
               OROF 12
!                  PPR[2]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'
!                     Q:U_NR=GGK:U_NR
!                     GET(Q_TABLE,Q:U_NR)
!                     IF ~ERROR() !D213.. IR JÂBÛT ATRASTIEM, JA TÂDI IR
!                        Q:PVN[2]+=GGK:SUMMA
!                        PUT(Q_TABLE)
!                     ELSE        !ANALÎTISKI
                     IF GGK:PVN_PROC=5
                        SOURCE_FOR_51[1]+=GGK:SUMMA ! ES SAMAZINÂTÂ LIKME
                     ELSIF GGK:PVN_PROC=10
                        SOURCE_FOR_51[2]+=GGK:SUMMA ! ES SAMAZINÂTÂ LIKME
                     ELSE
                        SOURCE_FOR_51[3]+=GGK:SUMMA ! ES SAMAZINÂTÂ LIKME 12%
                     .
!                     .
                     R56+=GGK:SUMMA
                  ELSIF GETPAR_K(GGK:PAR_NR,0,20)='N'    ! PRECES UZ RU? vai PAKALPOJUMU PVN DK no RU
                     R54+=GGK:SUMMA
                  ELSE
                     K:U_NR=GGK:U_NR
                     GET(K_TABLE,K:U_NR)
                     IF ~ERROR() !KASES D261..IR JÂBÛT ATRASTAM, JA TÂDS IR
                        IF GGK:PVN_PROC=5
                           K:PVN[4]+=GGK:SUMMA
                        ELSIF GGK:PVN_PROC=10 !10
                           K:PVN[5]+=GGK:SUMMA
                        ELSE !12
                           K:PVN[6]+=GGK:SUMMA
                        .
                        PUT(K_TABLE)
                     ELSE        !ANALÎTISKI
                        IF GGK:PVN_PROC=5
                           SOURCE_FOR_42[1]+=GGK:SUMMA
                        ELSIF GGK:PVN_PROC=10
                           SOURCE_FOR_42[2]+=GGK:SUMMA
                        ELSE !12
                           SOURCE_FOR_42[3]+=GGK:SUMMA
                        .
                     .
                     R53+=GGK:SUMMA       !PVN
                  .
               ELSE
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                  SOURCE_FOR_41[3]+=GGK:SUMMA   ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 22%
                  R52+=GGK:SUMMA
               .
! 28.07.2010            OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
!               IF GETPAR_K(GGK:PAR_NR,0,20)='C'       ! ES
!                  R55+=GGK:SUMMA
!               ELSE
!                  R54+=GGK:SUMMA
!               .
!!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!!               R11+=GGK:SUMMA
             OF 'A'                                    ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R57+=GGK:SUMMA
             .
           .
      !************************ 0% un Neapliekamie darîjumi,~PVN KONTS ********
        ELSIF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)) AND GGK:D_K='K' !IR DEFINÇTI NEAPL. DARÎJUMI
           LOOP R#=1 TO 2
              IF KON:PVND[R#]
                 CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                 OF 43
                    R43 += GGK:SUMMA      ! 0% KOPÂ
                 OF 44                    
                    R44 += GGK:SUMMA      ! SEZ
                 OF 45
                    R45 += GGK:SUMMA      ! ES PRECES
                 OF 46
                    R46 += GGK:SUMMA      ! ES DARBI PRECÇM
                 OF 47
                    R47 += GGK:SUMMA      ! ES JAUNAS A/M
                 OF 48
                    R48 += GGK:SUMMA      ! 0% PAKALPOJUMI
                 OF 481                   
                    R481+= GGK:SUMMA      ! EXPORTÇTÂS PRECES
                 OF 482                   
                    R482+= GGK:SUMMA      ! EXPORTÇTIE PAKALPOJUMI?
                 OF 49
                    R49 += GGK:SUMMA      ! PVN NEAPLIEKAMIE
                 .
              .
           .
      !************************ MEKLÇJAM PRETKONTUS PRECÇM,PAKALPOJUMIEM NO ES ********
!        ELSIF GGK:BKK[1:3]='531' AND GGK:D_K='K' AND GETPAR_K(GGK:PAR_NR,0,20)='C' ! ES, BEZ PVN 531-07.06.2010
!        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
!!        STOP(GGK:SUMMA)
!           Q:U_NR=GGK:U_NR
!           GET(Q_TABLE,Q:U_NR)
!           IF ERROR()
!              CLEAR(Q:PVN)
!              CLEAR(Q:SUMMA)
!              DO FILL_Q_TABLE
!              ADD(Q_TABLE)
!              SORT(Q_TABLE,Q:U_NR)
!           ELSE
!              DO FILL_Q_TABLE
!              PUT(Q_TABLE)
!           .
      !******** MEKLÇJAM 261,232..un 61... KONTUS KASES AP, PÂRB. VAI NAV CITU KONTÇJUMU ******
        ELSIF (GGK:BKK[1:3]='261' OR GGK:BKK[1:3]='232') AND GGK:D_K='D' ! VAR BÛT KASES AP
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           CLEAR(K:PVN)
           CLEAR(K:SUMMA)
           K:ANOTHER_K=FALSE
           GET(K_TABLE,K:U_NR)
           IF ERROR()
              K:U_NR=GGK:U_NR
              ADD(K_TABLE) !PIEFIKSÇJAM, KA ÐITAM U_NR IR KASE
              SORT(K_TABLE,K:U_NR)
           .
        ELSIF GGK:BKK[1:2]='61' AND GGK:D_K='K' ! VAR BÛT 61... NO KASES AP
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           GET(K_TABLE,K:U_NR)
           IF ~ERROR()  !D261 UZ ÐO NR IR BIJIS
!           STOP('K:SUMMA '&GGK:SUMMA)
              IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10 OR GGK:PVN_PROC=12
                 K:SUMMA[2]+=GGK:SUMMA
              ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21 OR GGK:PVN_PROC=22
                 K:SUMMA[1]+=GGK:SUMMA
              ELSE
                 KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
                 K:SUMMA[1]+=GGK:SUMMA       ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%(21%/22%)
                 K:ANOTHER_K=TRUE            ! LABÂK RÇÍINÂSIM ANALÎTISKI
              .
              PUT(K_TABLE)
           .
        ELSIF GGK:D_K='K' ! CITI K KONTÇJUMI
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           K:U_NR=GGK:U_NR
           GET(K_TABLE,K:U_NR)
           IF ~ERROR()  
              K:ANOTHER_K=TRUE
              PUT(K_TABLE)
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
  IF TODAY() > B_DAT+15 AND ~(CL_NR=1237) !GROSAM ÐITAIS NEPATÎK
     DATUMS=B_DAT+15
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    GET(K_TABLE,0)
    LOOP I# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       IF K:PVN[1]                       !IR KASES PVN 18%
!          IF K:SUMMA[1] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R41+=K:SUMMA[1]
!          ELSE
             SOURCE_FOR_41[1]+=K:PVN[1]
!          .
       ELSIF K:PVN[2]                    !IR KASES PVN 21%
!          IF K:SUMMA[1] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R41+=K:SUMMA[1]
!          ELSE
             SOURCE_FOR_41[2]+=K:PVN[2]
!          .
       ELSIF K:PVN[3]                    !IR KASES PVN 22%
!          IF K:SUMMA[1] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R41+=K:SUMMA[1]
!          ELSE
             SOURCE_FOR_41[3]+=K:PVN[3]
!          .
       .
       IF K:PVN[4]                       !IR KASES PVN 5%
!          IF K:SUMMA[2] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R42+=K:SUMMA[2]
!          ELSE
             SOURCE_FOR_42[1]+=K:PVN[4]
!          .
       ELSIF K:PVN[5]                    !IR KASES PVN 10%
!          IF K:SUMMA[2] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R42+=K:SUMMA[2]
!          ELSE
             SOURCE_FOR_42[2]+=K:PVN[5]
!          .
       ELSIF K:PVN[6]                    !IR KASES PVN 12%
!          IF K:SUMMA[2] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
!             R42+=K:SUMMA[2]
!          ELSE
             SOURCE_FOR_42[3]+=K:PVN[6]
!          .
       .
    .
    R41+=(SOURCE_FOR_41[1]*100)/18   ! ANALÎTISKI 18%
    R41+=(SOURCE_FOR_41[2]*100)/21   ! ANALÎTISKI 21%
    R41+=(SOURCE_FOR_41[3]*100)/22   ! ANALÎTISKI 22%
    R42+=(SOURCE_FOR_42[1]*100)/5    ! ANALÎTISKI 5%
    R42+=(SOURCE_FOR_42[2]*100)/10   ! ANALÎTISKI 10%
    R42+=(SOURCE_FOR_42[3]*100)/12   ! ANALÎTISKI 12%

!    GET(Q_TABLE,0)
!    LOOP I# = 1 TO RECORDS(Q_TABLE)
!       GET(Q_TABLE,I#)
!       IF Q:PVN[1]                                 !IR 18%/21%
!!          stop('pvn='&Q:PVN[1]&' '&Q:SUMMA[1]&'DELTA18='&(Q:SUMMA[1]/100)*18-Q:PVN[1])
!          IF INRANGE((Q:SUMMA[1]/100)*18-Q:PVN[1],-0.005,0.005) OR| !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
!             INRANGE((Q:SUMMA[1]/100)*21-Q:PVN[1],-0.005,0.005)     !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
!             R50+=Q:SUMMA[1]
!             STOP(Q:SUMMA[1])
!          ELSE
!             SOURCE_FOR_50+=Q:PVN[1]
!          .
!       .
!       IF Q:PVN[2]                                  !IR 5%/10%
!!          stop('pvn='&Q:PVN[2]&' DELTA5='&(Q:SUMMA[2]/100)*18-Q:PVN[2])
!          IF INRANGE((Q:SUMMA[2]/100)*5-Q:PVN[2],-0.005,0.005) OR| !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
!             INRANGE((Q:SUMMA[2]/100)*10-Q:PVN[2],-0.005,0.005)    !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
!             R51+=Q:SUMMA[2]
!          ELSE
!             SOURCE_FOR_51+=Q:PVN[2]
!          .
!       .
!    .
!!    R50+=(SOURCE_FOR_50*100)/18               ! ANALÎTISKI 18% ES
!!    R51+=(SOURCE_FOR_51*100)/5                ! ANALÎTISKI  5% ES
!!    R50=(SOURCE_FOR_50*100)/21               ! ANALÎTISKI 21% ES
!!    R51=(SOURCE_FOR_51*100)/10               ! ANALÎTISKI 10% ES

    R50=(SOURCE_FOR_50[1]*100)/18+(SOURCE_FOR_50[2]*100)/21+(SOURCE_FOR_50[3]*100)/22
    R51=(SOURCE_FOR_51[1]*100)/5+(SOURCE_FOR_51[2]*100)/10+(SOURCE_FOR_51[3]*100)/12

!    R40=R41+R42+R43+R482+R49                ! 17.05.2010
!    R40=R41+R42+R43+R481+R482               ! 11.03.2011
!    R40=R41+R42+R43+R481+R482+R49           ! 11.04.2011
    R40=R41+R42+R43+R482+R49                 ! 13.04.2011 R481 jau ir R43-Inga
    NOT1='Ministru kabineta'
    NOT2='2009.gada 22.decembra'
    NOT3='noteikumiem Nr.1640'
!   Inga:Nr 50 no 13.01.2009.
    IF R40=0                                 ! VISPÂR NAV BIJUÐI IEÒÇMUMI
!       PROP=100                              ! PROPORCIJA
       PROP=0                                ! PROPORCIJA
    ELSE
!       PROP=ROUND((R41+R42+R43)/(R41+R42+R43+R49)*100,.01) ! PROPORCIJA
        IF SYS:D_PR='N'
           PROP=0
        ELSE
!           PROP=ROUND(R49/R40*100,.01) ! PROPORCIJA
           PROP=R49/R40 ! PROPORCIJA
        .
    .
    R60=R61+R62+R63+R64+R65
!    R66=ROUND(R60*(100-PROP)/100,.01)
!    R66=ROUND(R60*PROP/100,.01)
    R66=ROUND(R60*PROP,.01)
    IF MINMAXSUMMA                           !KOKMATERIÂLI
       IF MINMAXSUMMA>0
          R58=MINMAXSUMMA
       ELSE
          R68=ABS(MINMAXSUMMA)
       .
    .
!    PP=R60-R66+R67+R68              !
!    PP=R60-R57                      !
    PP=R60-R66+R67                   !
    SS=R52+R53+R54+R55+R56+R57       !
!    SS=R52+R53+R54+R55+R56-R67      !
!    SS=R52-R67                      !
    IF PP > SS
      R70=PP-SS
      R80=0
    ELSE
      R80=SS-PP
      R70=0
    .

    IF ~(R43=R44+R45+R46+R47+R48+R481)  ! 17.05.2010
       KLUDA(0,'Kontu plânâ nepereizi norâdîti rindu kodi (43,44-481)')
    .
    IF R52 AND ~INRANGE(R52/R41*100-22,-0.5,0.5)
       KLUDA(85,R52/R41*100 &'% (jâbût 22%)')
    .
    IF R53 AND ~INRANGE(R53/R42*100-12,-0.5,0.5)
       KLUDA(85,R53/R42*100 &'% (jâbût 12%)')
    .
    IF PP
       PVN1_1=1
       PIELIKUMI='PVN1 I,'
    .
    IF R55+R66
       PVN1_2=1
       PIELIKUMI=CLIP(PIELIKUMI)&'PVN1 II,'
    .
    IF SS
       PVN1_3=1
       PIELIKUMI=CLIP(PIELIKUMI)&'PVN1 III'
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE='KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'&CHR(9)&'40'&CHR(9)&FORMAT(R40,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 21% apliekamie darîjumi (arî paðpatçriòð)'&CHR(9)&'41'&CHR(9)&FORMAT(R41,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 10% apliekamie darîjumi (arî paðpatçriòð)'&CHR(9)&'42'&CHR(9)&FORMAT(R42,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 0% apliekamie darîjumi, t.sk.:'&CHR(9)&'43'&CHR(9)&FORMAT(R43,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' darîjumi, kas veikti brîvostâs un SEZ'&CHR(9)&'44'&CHR(9)&FORMAT(R44,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' uz ES dalîbvalstîm piegâdâtâs preces'&CHR(9)&'45'&CHR(9)&FORMAT(R45,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' citâs ES dalîbvalstîs uzstâdîtâs vai montçtas preces'&CHR(9)&'46'&CHR(9)&FORMAT(R46,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'&CHR(9)&'47'&CHR(9)&FORMAT(R47,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' par sniegtajiem pakalpojumiem'&CHR(9)&'48'&CHR(9)&FORMAT(R48,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=' eksportçtâs preces'&CHR(9)&'48(1)'&CHR(9)&FORMAT(R481,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Citâs valstîs veiktie darîjumi'&CHR(9)&'48(2)'&CHR(9)&FORMAT(R482,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar PVN neapliekamie darîjumi'&CHR(9)&'49'&CHR(9)&FORMAT(R49,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (21%)'&CHR(9)&'50'&CHR(9)&FORMAT(R50,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (10%)'&CHR(9)&'51'&CHR(9)&FORMAT(R51,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='APRÇÍINÂTAIS PVN (latos)'
        ADD(OUTFILEANSI)
        OUTA:LINE='ar standartlikmi apliekamiem darîjumiem'&CHR(9)&'52'&CHR(9)&FORMAT(R52,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar samazinâto likmi apliekamiem darîjumiem'&CHR(9)&'53'&CHR(9)&FORMAT(R53,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par saòemtajiem pakalpojumiem'&CHR(9)&'54'&CHR(9)&FORMAT(R54,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar standartlikmi likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'55'&CHR(9)&FORMAT(R55,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar samazinâto likmi likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'56'&CHR(9)&FORMAT(R56,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='PRIEKÐNODOKLIS (latos), no tâ:'&CHR(9)&'60'&CHR(9)&FORMAT(R60,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'&CHR(9)&'61'&CHR(9)&FORMAT(R61,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'&CHR(9)&'62'&CHR(9)&FORMAT(R62,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu'&CHR(9)&'63'&CHR(9)&FORMAT(R63,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='aprçíinâtais priekðnodoklis par precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'64'&CHR(9)&FORMAT(R64,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='zemnieku saimniecîbâm izmaksâtâ PVN 12% kompensâcija'&CHR(9)&'65'&CHR(9)&FORMAT(R65,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Neatskaitâmais priekðnodoklis'&CHR(9)&'66'&CHR(9)&FORMAT(R66,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Korekcijas: iepr.taks. periodos sam. budþetâ aprçíinâtâ nodokïa samazinâjums'&CHR(9)&'67'&CHR(9)&FORMAT(R67,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Korekcijas: iepr.taks. periodos sam. atskaitîtâ priekðnodokïa samazinâjums'&CHR(9)&'57'&CHR(9)&FORMAT(R57,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Saskaòâ ar likuma 13.2.p: atskaitâmais priekðnodoklis'&CHR(9)&'68'&CHR(9)&FORMAT(R68,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Saskaòâ ar likuma 13.2.p: aprçíinâtais nodoklis'&CHR(9)&'58'&CHR(9)&FORMAT(R58,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPSUMMA: atskaitâmais priekðnodoklis'&CHR(9)&'[P]'&CHR(9)&FORMAT(PP,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPSUMMA: aprçíinâtais nodoklis'&CHR(9)&'[S]'&CHR(9)&FORMAT(SS,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu '&|
        'attiecinâmâ nodokïa summa, ja P>S'&CHR(9)&'70'&CHR(9)&FORMAT(R70,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='Budþetâ maksâjamâ nodokïa summa, ja P<S'&CHR(9)&'80'&CHR(9)&FORMAT(R80,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Novirzît PVN pârmaksas summu citu maks. veikðanai(Kods,Summa,Budþ.konta pçd.7 cipari)'&CHR(9)&|
        FORMAT(NODOKLKODS[1],@N1B)&CHR(9)&LEFT(FORMAT(NOVIRZSUMMA[1],@N-_12.2B))&CHR(9)&KONTANR[1]
        ADD(OUTFILEANSI)
        IF NOVIRZSUMMA[2]
           OUTA:LINE='Novirzît PVN pârmaksas summu citu maks. veikðanai(Kods,Summa,Budþ.konta pçd.7 cipari)'&CHR(9)&|
           FORMAT(NODOKLKODS[2],@N1B)&CHR(9)&LEFT(FORMAT(NOVIRZSUMMA[2],@N-_12.2B))&CHR(9)&KONTANR[2]
           ADD(OUTFILEANSI)
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Pârskaitît PVN pârmaksas summu uz norçíinu kontu (Summa,IBAN)'&CHR(9)&|
        LEFT(FORMAT(ParmaksUzKontuSumma,@N-_12.2B))&CHR(9)&IbanNumurs
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Pielikumi: '&pielikumi
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'APSTIPRINU PVN APRÇÍINU:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atbildîgâ persona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Uzvârds:'&CHR(9)&SYS:PARAKSTS1&CHR(9)&CHR(9)&'Datums: '&format(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Paraksts:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'VID atbildîgâ amatpersona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&KKK&CHR(9)&'R:'&CHR(9)&RS
        ADD(OUTFILEANSI)
    END
    IF F:XML_OK#=TRUE
       XML:LINE='<R1>' !nâkoðâ sadaïa
       ADD(OUTFILEXML)
       LOOP I#=40 TO 68+2+4
          J#=I#-40+1
          EXECUTE J#
             RI=R40
             RI=R41
             RI=R42
             RI=R43
             RI=R44
             RI=R45
             RI=R46
             RI=R47
             RI=R48
             RI=R481 !49 RINDA
             RI=R482 !50 RINDA
             RI=R49
             RI=R50
             RI=R51
             RI=R52
             RI=R53
             RI=R54
             RI=R55
             RI=R56
             RI=R57
             RI=R58
             RI=0    !ÐITÂDAS RINDAS NAV
             RI=R60
             RI=R61
             RI=R62
             RI=R63
             RI=R64
             RI=R65
             RI=R66
             RI=R67
             RI=R68  !70 RINDA
             RI=PP
             RI=SS
             RI=R70
             RI=R80
          .
          IF ~RI THEN CYCLE.
          IF I#<=48
             XML:LINE='<R'&FORMAT(I#,@N2)&'>'&CLIP(RI)&'</R'&FORMAT(I#,@N2)&'>'
             ADD(OUTFILEXML)
          ELSIF I#=49
             XML:LINE='<R48_1>'&CLIP(RI)&'</R48_1>'
             ADD(OUTFILEXML)
          ELSIF I#=50
             XML:LINE='<R48_2>'&CLIP(RI)&'</R48_2>'
             ADD(OUTFILEXML)
          ELSIF I#<=70
             XML:LINE='<R'&FORMAT(I#-2,@N2)&'>'&CLIP(RI)&'</R'&FORMAT(I#-2,@N2)&'>'
             ADD(OUTFILEXML)
          ELSE
             EXECUTE I#-70
                XML:LINE='<P>'&CLIP(RI)&'</P>'
                XML:LINE='<S>'&CLIP(RI)&'</S>'
                XML:LINE='<R70>'&CLIP(RI)&'</R70>'
                XML:LINE='<R80>'&CLIP(RI)&'</R80>'
             .
             ADD(OUTFILEXML)
          .
       .
       XML:LINE='</R1>' !beidzas ðitâ sadaïa
       ADD(OUTFILEXML)
!
!      SADAÏAS PVN5,PVN6
!
       IF NOVIRZSUMMA[1] OR NOVIRZSUMMA[2] !KAUT KAS TIKS NOVIRZÎTS CITIEM NODOKÏIEM
          XML:LINE=' Tab2>' !nâkoðâ tabula
          ADD(OUTFILEXML)
          XML:LINE=' Rs>' !nâkoðâ sadaïa
          ADD(OUTFILEXML)
          LOOP I#=1 TO 2
             IF NovirzSumma[I#]
                XML:LINE='<R>' !I# rinda
                ADD(OUTFILEXML)
                XML:LINE=' Npk>'&CLIP(I#)&'</Npk>'
                ADD(OUTFILEXML)
                XML:LINE=' NodoklKods>'&Nodoklkods[I#]&'</NodoklKods>'
                ADD(OUTFILEXML)
                XML:LINE=' NovirzSumma>'&NovirzSumma[I#]&'</NovirzSumma>'
                ADD(OUTFILEXML)
                XML:LINE=' KontaNr>'&KontaNr[I#]&'</KontaNr>'
                ADD(OUTFILEXML)
                XML:LINE='</R>' !BEIDZAS I# rinda
                ADD(OUTFILEXML)
             .
          .
          XML:LINE='</Rs>' !BEIDZAS sadaïa
          ADD(OUTFILEXML)
          XML:LINE='</Tab2>' !BEIDZAS tabula
          ADD(OUTFILEXML)
       .
       IF PVN1_1+PVN1_2+PVN1_3
          XML:LINE=' Tab3>' !nâkoðâ tabula
          ADD(OUTFILEXML)
          XML:LINE=' PVN1_1>'&PVN1_1&'</PVN1_1>'
          ADD(OUTFILEXML)
          XML:LINE=' PVN1_2>'&PVN1_2&'</PVN1_2>'
          ADD(OUTFILEXML)
          XML:LINE=' PVN1_3>'&PVN1_3&'</PVN1_3>'
          ADD(OUTFILEXML)
       .
       XML:LINE='</Tab3>' !BEIDZAS tabula
       ADD(OUTFILEXML)
       XML:LINE='</DokPVNv2>' !BEIDZAS DOKUMENTS
       ADD(OUTFILEXML)
       SET(OUTFILEXML)
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR() THEN BREAK.
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
          .
       .
       CLOSE(OUTFILEXML)
    .
    ENDPAGE(report)
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
      .
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
  IF SS+PP
     IF ~VK_PAR_NR !ÐAJÂ M. NEKAS NAV MAKSÂTS
        IF ~GL:VIDPVN_U_NR
           clear(ggk:record) !MEKLÇJAM PA VISU BÂZI
           GGK:BKK=KKK !57210
           SET(GGK:BKK_DAT,GGK:BKK_DAT)
           LOOP
              NEXT(GGK)
              IF ERROR() OR ~(GGK:BKK=KKK) THEN BREAK.
              IF GGK:PVN_TIPS='1' ! 1-budþetam
                 VK_PAR_NR=GGK:PAR_NR
                 BREAK
              .
           .
        ELSE
           VK_PAR_NR=GL:VIDPVN_U_NR
        .
     .
     IF VK_PAR_NR
        IF ~GL:VIDPVN_U_NR
           GL:VIDPVN_U_NR=VK_PAR_NR
           IF RIUPDATE:GLOBAL()
              KLUDA(24,'Global')
           .
        .
        CLEAR(VES:RECORD)
        VES:PAR_NR=VK_PAR_NR
        VES:DOK_SENR=FORMAT(S_DAT,@D014.B) !DOKUMANTA Nr
        GET(VESTURE,VES:REF_KEY)
        IF ERROR()
!           KLUDA(0,CLIP(GETPAR_K(VK_PAR_NR,0,1))&' Vçsturç nav atrodams dokuments Nr '&VES:DOK_SENR)
           VES:DOKDAT=B_DAT
           VES:DATUMS=B_DAT  !VAR PADOMÂT
           VES:SECIBA=CLOCK()
           IF F:IDP
              VES:SATURS='PVN Deklarâcija.Precizçtâ'
              VES:SAMAKSATS=SS-PP
              VES:SAM_DATUMS=TODAY()
           ELSE
              VES:SATURS='PVN Deklarâcija'
              VES:SUMMA =SS-PP
           .
           VES:VAL='Ls'
           VES:ACC_KODS=ACC_KODS
           VES:ACC_DATUMS=TODAY()
           ADD(VESTURE)
        ELSE  !VÇSTURÇ ÐÎ DEKLARÂCIJA JAU IR
           IF F:IDP
              VES:SATURS='PVN Deklarâcija.Precizçtâ'
              KLU_DARBIBA=0
              IF VES:SAMAKSATS AND ~(VES:SAMAKSATS = SS-PP)
                 KLUDA(0,'Vçsturç jau ir fiksçta ðî preciz.Dekl. Ls '&VES:SAMAKSATS&', aizvietot ar Ls '&SS-PP&' ?',9,1)
              .
              VES:SAMAKSATS = SS-PP
           ELSE
              VES:SATURS='PVN Deklarâcija'
              IF ~(VES:SUMMA = SS-PP)
                 KLUDA(0,'Vçsturç jau ir fiksçta ðî Deklarâcija Ls '&VES:SUMMA&', aizvietot ar Ls '&SS-PP&' ?',9,1)
              .
              VES:SUMMA = SS-PP
           .
           IF ~KLU_DARBIBA
              VES:ACC_KODS=ACC_KODS
              VES:ACC_DATUMS=TODAY()
              IF RIUPDATE:VESTURE()
                 KLUDA(24,'VESTURE')
              .
           .
        .
     ELSE
        KLUDA(0,'Globâlajos datos nav ievadîts VK-PVN saòçmçja U_NR')
!        KLUDA(0,'Periodâ '&FORMAT(DB_S_DAT,@D06.)&'-'&FORMAT(DB_B_DAT,@D06.)&' nav atrasts neviens PVN maksâjums VK')
     .
  .
  DO ProcedureReturn


!-----------------------------------------------------------------------------
!FILL_Q_TABLE ROUTINE  !SUMMAS BEZ PVN
!     Q:U_NR=GGK:U_NR
!     IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10
!        Q:SUMMA[2]+=GGK:SUMMA
!     ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21
!        Q:SUMMA[1]+=GGK:SUMMA
!     ELSE
!        KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
!        Q:SUMMA[1]+=GGK:SUMMA !LIETOTÂJA KÏÛDA, PIEÒEMAM, KA 18%(21%)
!     .

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

!  FREE(Q_TABLE)
  FREE(K_TABLE)
!  IF FilesOpened
!    IF GG::Used = 0 THEN CLOSE(GG).
!    KON_K::Used -= 1
!    IF KON_K::Used = 0 THEN CLOSE(KON_K).
!    GGK::Used -= 1
!    IF GGK::Used = 0 THEN CLOSE(GGK).
!    VESTURE::USED-=1
!    IF VESTURE::USED=0
!       CLOSE(VESTURE)
!    .
!  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF <> 'W' THEN F:DBF='W'.
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

!------------------------------------------------------------------------------
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!------------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
B_PVN_PIE_2010       PROCEDURE                    ! Declare Procedure
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

ceturksnis           BYTE
pusgads              BYTE
PAR_NOS_P            STRING(35)
GGTEX                STRING(60)
GG_DOK_SE            STRING(7)
GG_DOK_NR            STRING(14)
GG_DOKDAT            LIKE(GG:DOKDAT)
PERS_KODS            STRING(22)
DOK_SUMMA            DECIMAL(12,2)
DOK_SUMMAV           DECIMAL(12,2)
DOK_VAL              STRING(3)
PVN_SUMMA            DECIMAL(12,2)
DOK_SUMMA_X          DECIMAL(12,2)
PVN_SUMMA_X          DECIMAL(12,2)
DOK_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_K          DECIMAL(12,2)
DOK_SUMMA_K          DECIMAL(12,2)
PVN_SUMMA_K2         DECIMAL(12,2)
DOK_SUMMA_K2         DECIMAL(12,2)
PVN_SUMMA_K3         DECIMAL(12,2)
DOK_SUMMA_K3         DECIMAL(12,2)
DOK_SUMMA_P3         DECIMAL(12,2)
PVN_SUMMA_P3         DECIMAL(12,2)
GGK_SUMMAV           LIKE(GGK:SUMMAV)
GGK_SUMMA            LIKE(GGK:SUMMA)

DATUMS               DATE
RMENESIEM            STRING(11)
MENESS               STRING(20)
NPK                  ULONG
CG                   STRING(10)
StringLimitSumma     string(30)

NOT0                 STRING(10)
NOT1                 STRING(45)
NOT2                 STRING(45)
NOT3                 STRING(45)

R_TABLE      QUEUE,PRE(R)
KEY             STRING(10)
U_NR            ULONG
NOS_P           STRING(15)
PAR_TIPS        STRING(1)
D_K             STRING(1)
DATUMS          LONG
PAR_NR          ULONG
PVNS            DECIMAL(12,2),DIM(17,2) !18/5/18I/5I/12/21/10/22/12/21I/22I/10I/12I/21IN/22IN/10IN/12IN
SUMMA           DECIMAL(12,2)
RINDA           USHORT
VAL             STRING(3)
PVN_TIPS        STRING(1)
PAR_PVN         LIKE(PAR:PVN)
             .
PVNS                DECIMAL(12,2)
DOK_DAT             LONG
ATTDOK              STRING(30)
TEX:DUF             STRING(100)
KOPA_PVN            DECIMAL(12,2)
SUMMA_KOPA          DECIMAL(12,2)
DAR_SK              USHORT
PVN_KOPA            DECIMAL(12,2)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

E               STRING(1)
EE1             STRING(15)
EE2             STRING(15)
EE3             STRING(15)
DV              STRING(1)
DEKL            STRING(15)
CTRL            DECIMAL(12,2)
CTRL_TEXT       STRING(100)
RINDA           BYTE
PRECIZETA       STRING(15)
R63             DECIMAL(12,2)

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
report REPORT,AT(500,500,12000,7604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,200,12000,302),USE(?unnamed:9)
       END
RPT_Head DETAIL,AT(,10,,1000),USE(?unnamed:2)
         STRING(@s10),AT(9594,219,833,156),USE(NOT0),RIGHT(1)
         STRING(@s45),AT(3427,552,3385,220),USE(client),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskats par priekðnodokïa un nodokïa summâm, kas iekïautas pievienotâs vçrtîbas' &|
             ' nodokïa deklarâcijâ par'),AT(979,52,7948,208),USE(?String11:2),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('.gada'),AT(3542,260),USE(?String120),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(3063,260),USE(GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(4063,260),USE(MENESS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums'),AT(667,542,2406,219),USE(?String1:6),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(7510,667,2917,156),USE(NOT3),TRN,RIGHT(1)
         STRING(@s45),AT(7510,365,2917,156),USE(NOT1),TRN,RIGHT(1)
         STRING(@s45),AT(7510,510,2917,156),USE(NOT2),TRN,RIGHT(1)
         STRING('PVN 1 '),AT(9854,31,625,156),USE(?String107:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas reìistrâcijas numurs'),AT(677,781,2719,198),USE(?String51:7),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(3427,781,1094,208),USE(gl:vid_nr,,?gl:vid_nr:2),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(8938,823),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING(@PLapa<<<#/______P),AT(9469,833),PAGENO,USE(?PageCount),RIGHT
       END
D1_Head DETAIL,AT(,10,,1396),USE(?unnamed:4)
         STRING('I.Priekðnodoklis par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'),AT(1667,125,6208,208), |
             USE(?String211:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9135,135,313,313),USE(E,,?E:2),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,250,958,208),USE(EE1,,?EE1:2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('kuru kopçjâ vçrtîba bez PVN ir'),AT(2240,302,1875,208),USE(?String1:2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4167,302,2292,208),USE(StringLimitSumma),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(7844,125),USE(PRECIZETA),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera nosaukums'),AT(688,729,1979,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2875,563,1146,156),USE(?String1:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2854,719,1146,156),USE(?String1:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumu'),AT(4583,729,833,156),USE(?String1:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîj.'),AT(4125,698,396,156),USE(?String1:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2854,875,1146,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(4583,1031,833,156),USE(?String1:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta veids'),AT(6635,1031,1302,156),USE(?String1:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8417,1031,990,156),USE(?String134:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9458,1031,990,156),USE(?String145:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,979,0,417),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(8385,979,0,417),USE(?Line2:33),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(4583,885,833,156),USE(?String1:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veids'),AT(4125,875,396,156),USE(?String1:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6354,979,4115,0),USE(?Line55:3),COLOR(COLOR:Black)
         LINE,AT(104,510,10365,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2771,510,0,885),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4083,510,0,885),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(104,1188,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,1240,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1240,2146,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1240,1094,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4938,1229,260,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5781,1240,313,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7042,1240,719,156),USE(?String3:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(8438,1240,938,156),USE(?String93:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(9531,1240,938,156),USE(?String134:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4198,1219,260,156),USE(?String3:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojuma dokuments'),AT(7510,719,1938,156),USE(?String1:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(135,719,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,510,0,885),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6344,510,0,885),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10469,510,0,885),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4542,521,0,885),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5542,719,760,156),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5448,510,0,885),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Preèu vai'),AT(4583,573,833,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,510,0,885),USE(?Line2),COLOR(COLOR:Black)
       END
D1_detail DETAIL,AT(,,,208),USE(?unnamed:8)
         LINE,AT(5448,-10,0,229),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4083,0,0,229),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,229),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,229),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@s35),AT(573,52,2188,156),USE(PAR_nos_p),LEFT
         LINE,AT(6344,-10,0,229),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(125,0,10365,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@s22),AT(2813,52,1250,156),USE(PERS_KODS),CENTER
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK),RIGHT
         LINE,AT(104,-10,0,229),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4635,52,,156),USE(dok_summa),RIGHT(1)
         STRING(@n-_11.2),AT(5594,52,677,156),USE(pvn_summa),RIGHT(1)
         STRING(@s30),AT(6490,52,1875,156),USE(ATTDOK),LEFT
         STRING(@S14),AT(8417,52,980,156),USE(GG_DOK_NR),CENTER
         STRING(@D06.B),AT(9635,52,615,156),USE(GG_DOKDAT)
         STRING(@s1),AT(4208,52,208,156),USE(DV),TRN,CENTER
         LINE,AT(8385,-10,0,229),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,229),USE(?Line2:36),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line72:21),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,115),USE(?Line72:2),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line71:3),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,62),USE(?Line72:26),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,62),USE(?Line72:37),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,115),USE(?Line72:19),COLOR(COLOR:Black)
         LINE,AT(5448,-10,0,115),USE(?Line72:18),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line72:16),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,115),USE(?Line72:32),COLOR(COLOR:Black)
         LINE,AT(4083,-10,0,115),USE(?Line72:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line72:15),COLOR(COLOR:Black)
       END
D1_FOOTER DETAIL,AT(,-10,,250),USE(?unnamed:7)
         STRING(@n-_12.2),AT(5490,21,781,156),USE(pvn_summa_k),RIGHT(1)
         STRING(@n-_13.2),AT(4583,21,,156),USE(dok_summa_k),RIGHT(1)
         STRING('Kopâ : '),AT(625,21,1146,156),USE(?String3:9),LEFT
         LINE,AT(10469,0,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(104,10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(521,10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(104,198,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(6344,10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(4542,10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(5448,0,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4083,0,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(2771,0,0,198),USE(?Line2:23),COLOR(COLOR:Black)
       END
PAGEBREAK DETAIL,PAGEAFTER(-1),AT(,,,10),USE(?PAGEBREAK)
       END
D2_Head DETAIL,AT(,10,,1396),USE(?unnamed:3)
         STRING(@s1),AT(9135,94,313,313),USE(E,,?E:3),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('II. Priekðnodoklis par precçm un pakalpojumiem, kas saòemti no Eiropas Savienîba' &|
             's dalîbvalstîm'),AT(635,104,7167,208),USE(?String2211:2),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,208,958,208),USE(EE2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('G-prece, P-pakalpojumi'),AT(1490,302,2240,208),USE(?String23:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(7833,104),USE(PRECIZETA),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,979,0,417),USE(?Line22:30),COLOR(COLOR:Black)
         STRING('Darîjuma partnera nosaukums'),AT(552,760,2240,208),USE(?String23:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba valûtâ'),AT(7073,781,1240,156),USE(?String21:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2969,646,1146,156),USE(?String21:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîj.'),AT(4302,708,302,156),USE(?String21:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reìistrâcijas'),AT(2969,802,1146,156),USE(?String21:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(2969,958,1146,156),USE(?String21:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(latos)'),AT(4844,927,688,156),USE(?String21:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veids'),AT(4281,938,333,156),USE(?String21:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6906,1031,854,156),USE(?String21:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('val.kods'),AT(7854,1031,490,156),USE(?String2123:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8438,1031,990,156),USE(?String2134:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9479,1031,990,156),USE(?String2145:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,979,0,417),USE(?Line22:34),COLOR(COLOR:Black)
         LINE,AT(8385,510,0,896),USE(?Line22:7),COLOR(COLOR:Black)
         STRING('aprçíinâts PVN'),AT(4802,781,885,156),USE(?String21:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6719,979,3750,0),USE(?Line255:3),COLOR(COLOR:Black)
         LINE,AT(104,510,10365,0),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(2813,510,0,885),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(4250,510,0,885),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(104,1188,10365,0),USE(?Line21:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,1240,365,156),USE(?String23:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1240,2146,156),USE(?String23:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1240,1094,156),USE(?String23:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4385,1229,208,156),USE(?String23:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5031,1219,375,156),USE(?String23:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5865,1208,438,156),USE(?String23:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(9635,1208,375,156),USE(?String2134:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7198,1229,365,156),USE(?String23:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(7938,1229,375,156),USE(?String293:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(8760,1229,375,156),USE(?String2134:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('saòemtais rçíins'),AT(8969,781,1177,156),USE(?String121:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(146,760,365,208),USE(?String21:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,510,0,885),USE(?Line22:29),COLOR(COLOR:Black)
         LINE,AT(6719,510,0,885),USE(?Line22:6),COLOR(COLOR:Black)
         LINE,AT(10469,510,0,885),USE(?Line22:5),COLOR(COLOR:Black)
         LINE,AT(4635,521,0,885),USE(?Line22:15),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5906,792,677,156),USE(?String21:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5781,510,0,885),USE(?Line22:4),COLOR(COLOR:Black)
         STRING('Vçrtîba, no kuras'),AT(4750,615,979,156),USE(?String21:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('No darîjuma partnera'),AT(8490,573,1927,156),USE(?String221:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,510,0,885),USE(?Line22),COLOR(COLOR:Black)
       END
D2_detail DETAIL,AT(,,,208),USE(?unnamed)
         LINE,AT(5781,-10,0,229),USE(?Line22:11),COLOR(COLOR:Black)
         LINE,AT(4250,-10,0,229),USE(?Line22:10),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,229),USE(?Line22:8),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,229),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line22:31),COLOR(COLOR:Black)
         STRING(@s35),AT(563,52,2240,156),USE(PAR_nos_p,,?PAR_NOS_P2),LEFT
         LINE,AT(6719,-10,0,229),USE(?Line22:13),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line22:12),COLOR(COLOR:Black)
         LINE,AT(104,0,10365,0),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(4635,10,0,229),USE(?Line22:16),COLOR(COLOR:Black)
         STRING(@s22),AT(2833,52,1406,156),USE(PERS_KODS,,?PERS_KODS2),CENTER
         STRING(@s1),AT(4365,31,208,156),USE(DV,,?DV:2),TRN,CENTER
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK,,?NPK2),RIGHT
         LINE,AT(104,-10,0,229),USE(?Line22:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4917,52,,156),USE(dok_summa,,?dok_summa:2),RIGHT
         STRING(@n-_11.2),AT(5927,52,677,156),USE(pvn_summa,,?PVN_SUMMA:2),RIGHT
         STRING(@n-_12.2),AT(6854,52,781,156),USE(dok_summav),RIGHT(1)
         STRING(@S3),AT(7875,52,469,156),USE(DOK_VAL),CENTER
         STRING(@S14),AT(8427,52,980,156),USE(GG_DOK_NR,,?GG_DOK_NR:2),CENTER
         STRING(@D06.),AT(9635,52,615,156),USE(GG_DOKDAT,,?GG_DOKDAT:2)
         LINE,AT(8385,-10,0,229),USE(?Line22:35),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,229),USE(?Line22:36),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(0,0,0,115),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(4635,10,0,115),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,62),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,115),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5771,-10,0,115),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,115),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(4250,-10,0,115),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line2:15),COLOR(COLOR:Black)
       END
D2_FOOTER DETAIL,AT(,,,250),USE(?unnamed:37)
         LINE,AT(104,208,10365,0),USE(?Line31:19),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5875,42,729,156),USE(pvn_summa_k2),RIGHT
         STRING(@n-_13.2),AT(4854,42,,156),USE(dok_summa_k2),RIGHT
         STRING('Kopâ : '),AT(625,42,1146,156),USE(?String33:9),LEFT
         LINE,AT(10469,0,0,208),USE(?Line32:28),COLOR(COLOR:Black)
         LINE,AT(521,0,0,208),USE(?Line32:27),COLOR(COLOR:Black)
         LINE,AT(104,10,10365,0),USE(?Line31:18),COLOR(COLOR:Black)
         LINE,AT(6719,10,0,208),USE(?Line32:25),COLOR(COLOR:Black)
         LINE,AT(4635,10,0,208),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5781,0,0,208),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(4250,0,0,208),USE(?Line32:24),COLOR(COLOR:Black)
         LINE,AT(2813,0,0,208),USE(?Line32:23),COLOR(COLOR:Black)
         LINE,AT(104,0,0,208),USE(?Line32:22),COLOR(COLOR:Black)
       END
D3_Head DETAIL,AT(,10,,1396),USE(?unnamed:34)
         STRING('III.Nodoklis par piegâdâtajâm precçm un sniegtajiem pakalpojumiem'),AT(1740,125,5083,208), |
             USE(?String211:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9135,135,313,313),USE(E,,?E:32),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(7271,125),USE(PRECIZETA),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,250,958,208),USE(EE3),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('kuru kopçjâ vçrtîba bez PVN ir'),AT(2240,302,1875,208),USE(?String1:32),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4167,302,2292,208),USE(StringLimitSumma,,?StringLimitSumma3),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera nosaukums'),AT(688,729,1979,208),USE(?String3:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2875,563,1146,156),USE(?String1:317),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2854,719,1146,156),USE(?String1:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumu'),AT(4583,729,833,156),USE(?String1:318),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVND'),AT(4125,698,396,156),USE(?String1:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2854,875,1146,156),USE(?String1:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(4583,1031,833,156),USE(?String1:321),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta veids'),AT(6635,1031,1302,156),USE(?String1:314),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8417,1031,990,156),USE(?String134:314),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9458,1031,990,156),USE(?String145:314),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,979,0,417),USE(?Line2:334),COLOR(COLOR:Black)
         LINE,AT(8385,979,0,417),USE(?Line2:333),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(4583,885,833,156),USE(?String1:322),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('rinda'),AT(4125,875,396,156),USE(?String1:312),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6354,979,4115,0),USE(?Line55:33),COLOR(COLOR:Black)
         LINE,AT(104,510,10365,0),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(2771,510,0,885),USE(?Line2:332),COLOR(COLOR:Black)
         LINE,AT(4083,510,0,885),USE(?Line2:3333),COLOR(COLOR:Black)
         LINE,AT(104,1188,10365,0),USE(?Line1:32),COLOR(COLOR:Black)
         STRING('1'),AT(156,1240,365,156),USE(?String3:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1240,2146,156),USE(?String3:392),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1240,1094,156),USE(?String3:393),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4938,1229,260,156),USE(?String3:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5781,1240,313,156),USE(?String3:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7042,1240,719,156),USE(?String3:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(8438,1240,938,156),USE(?String93:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(9531,1240,938,156),USE(?String134:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4198,1219,260,156),USE(?String3:37),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojuma dokuments'),AT(7510,719,1938,156),USE(?String1:316),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(135,719,365,208),USE(?String1:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,510,0,885),USE(?Line2:329),COLOR(COLOR:Black)
         LINE,AT(6344,510,0,885),USE(?Line2:336),COLOR(COLOR:Black)
         LINE,AT(10469,510,0,885),USE(?Line2:335),COLOR(COLOR:Black)
         LINE,AT(4542,521,0,885),USE(?Line2:314),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5521,708,760,177),USE(?String1:323),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5448,510,0,885),USE(?Line2:434),COLOR(COLOR:Black)
         STRING('Preèu vai'),AT(4583,573,833,156),USE(?String1:320),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,510,0,885),USE(?Line32),COLOR(COLOR:Black)
       END
D3_detail DETAIL,AT(,,,208),USE(?unnamed:38)
         LINE,AT(5448,-10,0,229),USE(?Line2:311),COLOR(COLOR:Black)
         LINE,AT(4083,0,0,229),USE(?Line2:310),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,229),USE(?Line2:330),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,229),USE(?Line2:338),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line2:331),COLOR(COLOR:Black)
         STRING(@s35),AT(573,52,2188,156),USE(PAR_nos_p,,?PAR_NOS_P3),LEFT
         LINE,AT(6344,-10,0,229),USE(?Line2:313),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line2:312),COLOR(COLOR:Black)
         LINE,AT(125,0,10365,0),USE(?Line1:35),COLOR(COLOR:Black)
         STRING(@s20),AT(2813,52,1250,156),USE(PERS_KODS,,?PERS_KODS3),CENTER
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK,,?NPK3),RIGHT
         LINE,AT(104,-10,0,229),USE(?Line2:439),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4646,52,,156),USE(dok_summa,,?dok_summa:3),RIGHT
         STRING(@n-_11.2B),AT(5594,52,677,156),USE(pvn_summa,,?pvn_summa3),RIGHT
         STRING(@s30),AT(6490,52,1875,156),USE(ATTDOK,,?ATTDOK:2),LEFT
         STRING(@S14),AT(8417,52,980,156),USE(GG_DOK_NR,,?GG_DOK_NR3),CENTER
         STRING(@D06.B),AT(9635,52,615,156),USE(GG_DOKDAT,,?GG_DOKDAT3)
         STRING(@N3B),AT(4208,63,208,156),USE(R:RINDA),TRN,CENTER
         LINE,AT(8385,-10,0,229),USE(?Line2:3335),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,229),USE(?Line2:3336),COLOR(COLOR:Black)
       END
detail3 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line72:321),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,115),USE(?Line72:432),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line71:33),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,62),USE(?Line72:326),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,62),USE(?Line72:337),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,115),USE(?Line72:319),COLOR(COLOR:Black)
         LINE,AT(5448,-10,0,115),USE(?Line72:318),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line72:316),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,115),USE(?Line72:332),COLOR(COLOR:Black)
         LINE,AT(4083,-10,0,115),USE(?Line72:317),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line72:315),COLOR(COLOR:Black)
       END
D3_FOOTER DETAIL,PAGEAFTER(-1),AT(,,,885),USE(?unnamed:5)
         STRING(@n-_12.2),AT(5490,21,781,156),USE(pvn_summa_k3),RIGHT
         STRING(@n-_13.2),AT(4583,21,,156),USE(dok_summa_k3),RIGHT
         STRING('Kopâ : '),AT(625,21,1146,156),USE(?String3:39),LEFT
         LINE,AT(10469,-10,0,205),USE(?Line2:328),COLOR(COLOR:Black)
         LINE,AT(104,0,0,205),USE(?Line2:322),COLOR(COLOR:Black)
         LINE,AT(521,0,0,205),USE(?Line2:327),COLOR(COLOR:Black)
         LINE,AT(104,198,10365,0),USE(?Line1:34),COLOR(COLOR:Black)
         LINE,AT(6344,0,0,205),USE(?Line2:325),COLOR(COLOR:Black)
         LINE,AT(4542,0,0,205),USE(?Line2:3338),COLOR(COLOR:Black)
         LINE,AT(5448,-10,0,205),USE(?Line2:437),COLOR(COLOR:Black)
         LINE,AT(4083,-10,0,205),USE(?Line2:324),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,205),USE(?Line2:323),COLOR(COLOR:Black)
         STRING('Atbildîgâ persona'),AT(219,563),USE(?sys:amats1:2),RIGHT(1)
         STRING('20___. gada____. _{29}'),AT(5781,573),USE(?sys:amats1),TRN,RIGHT(1)
         STRING(@d06.),AT(9385,240),USE(datums,,?datums:2),FONT(,6,,,CHARSET:ANSI)
         STRING('RS: '),AT(10010,240,208,135),USE(?String37),RIGHT,FONT(,6,,,CHARSET:ANSI)
         STRING(@S1),AT(10229,240,208,135),USE(RS),CENTER,FONT(,6,,,CHARSET:ANSI)
         STRING(@S100),AT(802,292,6344,177),USE(CTRL_TEXT),TRN
         STRING('Kontrole:'),AT(240,292),USE(?String151),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s25),AT(4063,573),USE(SYS:PARAKSTS1),LEFT
         LINE,AT(1146,729,2865,0),USE(?Line55),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,8100,12000,0),USE(?unnamed:6)
         LINE,AT(104,,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
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

DVWindow WINDOW('Darîjuma veids'),AT(,,180,140),GRAY
       STRING(@s35),AT(6,6),USE(PAR_nos_p)
       STRING(@s22),AT(6,16),USE(PERS_KODS)
       STRING('Summa bez PVN'),AT(6,26),USE(?String3)
       STRING(@n-12.2),AT(63,26),USE(dok_summa)
       STRING('PVN'),AT(109,26),USE(?String4)
       STRING(@N-11.2),AT(125,26),USE(pvn_summa)
       STRING(@s47),AT(6,35,165,10),USE(gg:saturs)
       STRING(@s47),AT(6,43,165,10),USE(gg:saturs2)
       OPTION('PVN1 I daïa'),AT(4,55,170,61),USE(DV),BOXED,TRN
         RADIO('I-imports'),AT(7,64),USE(?DV:Radio1),TRN,VALUE('I')
         RADIO('A-darîjums ar apliekamu personu LR vai ES'),AT(7,73),USE(?DV:Radio2),VALUE('A')
         RADIO('N-darîjuma partnerim nav PVN reìistrâcijas Nr'),AT(7,83),USE(?DV:Radio3),VALUE('N')
         RADIO('K-lauksaimniekam izmaksâtâ kompensâcija'),AT(7,93),USE(?DV:Radio4),VALUE('K')
         RADIO('Z-zaudçtie parâdi'),AT(7,103),USE(?DV:Radio5)
       END
       BUTTON('&OK'),AT(126,118,45,14),USE(?OKDV)
     END
  CODE                                            ! Begin processed code
!
! Tiek izsaukts tikai, ja GADS>2009
!
!R:DOKS[1] 231 Ls/Es 18%
!R:DOKS[2] 231 Ls/Es 5%
!R:DOKS[3] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI 18%
!R:DOKS[4] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI  5%
!R:DOKS[5] 231 Ls 14%
!R:DOKS[6] 231 Ls/ES 21%
!R:DOKS[7] 231 Ls/ES 10%
!
!R:PVNS[1] PVN Ls 18%
!R:PVNS[2] PVN Ls 5%
!R:PVNS[3] PVN_TIPS=I IMPORTA PAKALPOJUMI 18%
!R:PVNS[4] PVN_TIPS=I IMPORTA PAKALPOJUMI  5%
!R:PVNS[5] PVN Ls 14%
!R:PVNS[6] PVN Ls 21%
!R:PVNS[7] PVN Ls 10%
!R:PVNS[8] PVN Ls 22%
!R:PVNS[9] PVN Ls 12%
!R:PVNS[10] PVN_TIPS=I IMPORTA PAKALPOJUMI 21%
!R:PVNS[11] PVN_TIPS=I IMPORTA PAKALPOJUMI 22%
!R:PVNS[12] PVN_TIPS=I IMPORTA PAKALPOJUMI 10%
!R:PVNS[13] PVN_TIPS=I IMPORTA PAKALPOJUMI 12%
!R:PVNS[14] PVN_TIPS=I IMPORTA PAKALPOJUMI 21% ES PVN Nemaksâtâjs
!R:PVNS[15] PVN_TIPS=I IMPORTA PAKALPOJUMI 22% ES PVN Nemaksâtâjs
!R:PVNS[16] PVN_TIPS=I IMPORTA PAKALPOJUMI 10% ES PVN Nemaksâtâjs
!R:PVNS[17] PVN_TIPS=I IMPORTA PAKALPOJUMI 12% ES PVN Nemaksâtâjs
!
!
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  DATUMS=TODAY()
  MENESS=MENVAR(MEN_NR,1,3)
  IF BILANCE   !LIELÂKÂ SUMMA NO IZZFILTPVN
     StringLimitSumma='no '&CLIP(MINMAXSUMMA)&' lîdz '&clip(bilance)&' (neieskaitot)'
  ELSE
     StringLimitSumma='Ls '&CLIP(MINMAXSUMMA)&' un vairâk'
  .
  NOT0='Pielikums'
  NOT1='Ministru kabineta'
  NOT2='2009.gada 22.decembra noteikumiem Nr.1640'
  NOT3=''

  IF F:IDP THEN PRECIZETA='Precizçtâ jâ nç'.
  IF F:XML
     E='E'
     EE1='(PVN_PI.XML)'
     EE2='(PVN_PII.XML)'
     EE3='(PVN_PIII.XML)'
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  .
  GG::Used += 1
  IF PAR_K::Used = 0
    CHECKOPEN(PAR_K,1)
  .
  PAR_K::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  .
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('kkk',kkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN pielikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K100000'  !GGK,RS,DATUMI,D/K,PVNTi&PVN%,OBJ,NOD
!           1234567
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      .
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        .
      .
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      .
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:RPT_HEAD)
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PVN_PIE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {200}PVN 1'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}Pârskats par priekðnodokïa summâm, kas iekïautas Pievienotâs Vçrtîbas Nodokïa deklarâcijâ par'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {75}'&GL:DB_GADS&'. gada '&MENESS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums: '&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiska adrese: '&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs: '&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
      .
      IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_PI.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokPVNMDPv1>'
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.),,1). !vienkârði kontrolei
        .
      .
    OF Event:Timer

!************************ BÛVÇJAM R_TABLE ********

      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
      !************************ PVN KONTS ****************************************
!         IF INSTRING(GGK:PVN_TIPS,' 02NIPA') AND ~CYCLEBKK(GGK:BKK,KKK) AND| ! IR PVN KONTS
!         ~(GGK:PVN_TIPS='I')                                                 ! IMPORTA PAKALPOJUMI
         IF (INSTRING(GGK:PVN_TIPS,' 024NIPAZ') OR INSTRING(GGK:PVN_TIPS,'38KMB')) AND ~CYCLEBKK(GGK:BKK,KKK)  ! IR PVN KONTS
            R:U_NR=GGK:U_NR
            R:D_K=GGK:D_K
            GGK_SUMMAV=GGK:SUMMAV
            GGK_SUMMA=GGK:SUMMA
            IF (GGK:D_K='K' AND GGK:PVN_TIPS='A' AND GGK:PVN_TIPS='4')    ! K+PVN_TIPS=A MÇS ATGRIEÞAM PRECI R57
               R:D_K='D'
               IF GGK_SUMMAV>0
                  GGK_SUMMAV=-GGK_SUMMAV
                  GGK_SUMMA=-GGK_SUMMA
               .
            ELSIF (GGK:D_K='D' AND GGK:PVN_TIPS='A') ! D+PVN_TIPS=A MUMS ATGRIEÞ PRECI R67
               R:D_K='D'
            ELSE
               R:D_K=GGK:D_K
            .
            R:KEY=CLIP(R:U_NR)&R:D_K
            GET(R_TABLE,R:KEY)
            IF ~ERROR()
               CASE GGK:PVN_PROC
               OF 5
                  IF GGK:PVN_TIPS='I'   !PVN_TIPS=I
                     R:PVNS[4,1]+=GGK_SUMMAV
                     R:PVNS[4,2]+=GGK_SUMMA
                  ELSE
                     R:PVNS[2,1]+=GGK_SUMMAV
                     R:PVNS[2,2]+=GGK_SUMMA
                  .
               OF 10
                  IF GGK:PVN_TIPS='I'  !IMPORTA PAKALPOJUMI
                     R:PVNS[12,1]+=GGK_SUMMAV
                     R:PVNS[12,2]+=GGK_SUMMA
                  ELSE
                     R:RINDA=42
                     R:PVNS[7,1]+=GGK_SUMMAV
                     R:PVNS[7,2]+=GGK_SUMMA
                  .
               OF 12
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    R:PVNS[13,1]+=GGK_SUMMAV
                    R:PVNS[13,2]+=GGK_SUMMA
                  ELSE
                    R:RINDA=42
                    R:PVNS[9,1]+=GGK_SUMMAV
                    R:PVNS[9,2]+=GGK_SUMMA
                  .
               OF 14
                  R:PVNS[5,1]+=GGK_SUMMAV !VAR BÛT TIKAI Ls&LR
                  R:PVNS[5,2]+=GGK_SUMMA  !VAR BÛT TIKAI Ls&LR
               OF 18
                  IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                    R:PVNS[3,1]+=GGK_SUMMAV
                    R:PVNS[3,2]+=GGK_SUMMA
                  ELSE
                    R:PVNS[1,1]+=GGK_SUMMAV
                    R:PVNS[1,2]+=GGK_SUMMA
                  .
               OF 21
                  IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                    R:PVNS[10,1]+=GGK_SUMMAV
                    R:PVNS[10,2]+=GGK_SUMMA
                  ELSE
                    R:RINDA=41
                    R:PVNS[6,1]+=GGK_SUMMAV
                    R:PVNS[6,2]+=GGK_SUMMA
                  .
               OF 22
                  IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                    R:PVNS[11,1]+=GGK_SUMMAV
                    R:PVNS[11,2]+=GGK_SUMMA
                  ELSE
                    R:RINDA=41
                    R:PVNS[8,1]+=GGK_SUMMAV
                    R:PVNS[8,2]+=GGK_SUMMA
                  .
               ELSE
                  KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                  DO ProcedureReturn
               .
               PUT(R_TABLE)
            ELSE !R:KEY NAV ATRASTS
! 28.07.2010              IF GGK:PVN_TIPS='I' AND ~(GETPAR_K(GGK:PAR_NR,0,20)='C') !PVN_TIPS=I IMPORTA PAKALPOJUMI
!                  KLUDA(0,'NEPAREIZS PARTNERA TIPS IMPORTA PAKALPOJUMIEM...'&FORMAT(GGK:DATUMS,@D06.)&'U_NR='&GGK:U_NR)
!               .
               R:NOS_P=GETPAR_K(GGK:PAR_NR,0,1)
               R:PAR_TIPS=GETPAR_K(GGK:PAR_NR,0,20) !LAI ZINÂTU, KA ES,RU
               R:PAR_PVN= GETPAR_K(GGK:PAR_NR,0,13) !PVN RNr
               R:VAL=GGK:VAL
               R:PVN_TIPS=GGK:PVN_TIPS !VAJADZÎGS ATGRIEZTAI PRECEI UN ES PAKALPOJUMIEM
               CLEAR(R:PVNS)
               CASE GGK:PVN_PROC
               OF 5
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    R:PVNS[4,1]=GGK_SUMMAV
                    R:PVNS[4,2]=GGK_SUMMA
                  ELSE
                    R:PVNS[2,1]=GGK_SUMMAV
                    R:PVNS[2,2]=GGK_SUMMA
                  .
               OF 10
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    IF R:PAR_PVN
                       R:PVNS[12,1]=GGK_SUMMAV
                       R:PVNS[12,2]=GGK_SUMMA
                    ELSE
                       R:PVNS[16,1]=GGK_SUMMAV
                       R:PVNS[16,2]=GGK_SUMMA
                    .
                  ELSE
                    R:RINDA=42
                    R:PVNS[7,1]=GGK_SUMMAV
                    R:PVNS[7,2]=GGK_SUMMA
                  .
               OF 12
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                    IF R:PAR_PVN
                       R:PVNS[13,1]=GGK_SUMMAV
                       R:PVNS[13,2]=GGK_SUMMA
                    ELSE
                       R:PVNS[17,1]=GGK_SUMMAV
                       R:PVNS[17,2]=GGK_SUMMA
                    .
                  ELSE
                    R:RINDA=42
                    R:PVNS[9,1]=GGK_SUMMAV
                    R:PVNS[9,2]=GGK_SUMMA
                  .
               OF 14
                  R:PVNS[5,1]+=GGK_SUMMAV   !VAR BÛT TIKAI Ls&LR
                  R:PVNS[5,2]+=GGK_SUMMA    !VAR BÛT TIKAI Ls&LR

               OF 18
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                    R:PVNS[3,1]=GGK_SUMMAV
                    R:PVNS[3,2]=GGK_SUMMA
                  ELSE
                    R:PVNS[1,1]=GGK_SUMMAV
                    R:PVNS[1,2]=GGK_SUMMA
                  .
               OF 21
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                    IF R:PAR_PVN
                       R:PVNS[10,1]=GGK_SUMMAV
                       R:PVNS[10,2]=GGK_SUMMA
                    ELSE
                       R:PVNS[14,1]=GGK_SUMMAV
                       R:PVNS[14,2]=GGK_SUMMA
                    .
                  ELSE
                    R:RINDA=41
                    R:PVNS[6,1]=GGK_SUMMAV
                    R:PVNS[6,2]=GGK_SUMMA
                  .
               OF 22
                  IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                    IF R:PAR_PVN
                       R:PVNS[11,1]=GGK_SUMMAV
                       R:PVNS[11,2]=GGK_SUMMA
                    ELSE
                       R:PVNS[15,1]=GGK_SUMMAV
                       R:PVNS[15,2]=GGK_SUMMA
                    .
                  ELSE
                    R:RINDA=41
                    R:PVNS[8,1]=GGK_SUMMAV
                    R:PVNS[8,2]=GGK_SUMMA
                  .
               ELSE
                  KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                  DO ProcedureReturn
               .
               R:DATUMS=GGK:DATUMS         !Ls pârrçíins  ?
               R:PAR_NR=GGK:PAR_NR
               ADD(R_TABLE)
               SORT(R_TABLE,R:U_NR)
            .
      !************************ 0% un Neapliekamie darîjumi,~PVN KONTS ********
         ELSIF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)) AND GGK:D_K='K' !IR DEFINÇTI NEAPL. DARÎJUMI
            FOUND43#=FALSE
            FOUND2R#=FALSE
            LOOP R#=1 TO 2
               IF KON:PVND[R#]
                  CASE KON:PVND[R#]         ! Neapliekamie darîjumi
                  OF 43
                     FOUND43#=TRUE          ! 0% KOPÂ
                  OF 44                     ! SEZ
!                  OROF 45                   ! ES PRECES
!                  OROF 46                   ! ES DARBI PRECÇM
!                  OROF 47                   ! ES JAUNAS A/M
                  OROF 48                   ! SNIEGTIE PAKALPOJUMI
!                  OROF 481                  ! EXPORTÇTÂS PRECES
                  OROF 482                  ! EXPORTÇTIE PAKALPOJUMI?
!                  OROF 49                   ! PVN NEAPLIEKAMIE
                     FOUND2R#=TRUE
                     R:SUMMA = GGK_SUMMA
                     R:RINDA = KON:PVND[R#]
                  .
               .
            .
!            IF FOUND43# AND ~FOUND2R#
!               KLUDA(0,'Kïûda kontu plânâ kontam '&GGK:BKK)
            IF FOUND2R#
               CLEAR(R:PVNS)
               R:U_NR=GGK:U_NR
               R:KEY=CLIP(R:U_NR)&R:D_K
               R:NOS_P=GETPAR_K(GGK:PAR_NR,0,1)
               R:PAR_TIPS=GETPAR_K(GGK:PAR_NR,0,20) !LAI ZINÂTU, KA ES
               R:VAL=GGK:VAL
               R:PVN_TIPS=GGK:PVN_TIPS !VAJADZÎGS ATGRIEZTAI PRECEI UN ES PAKALPOJUMIEM
               R:PAR_PVN= GETPAR_K(GGK:PAR_NR,0,13) !PVN RNr
               R:DATUMS=GGK:DATUMS         !Ls pârrçíins  ?
               R:PAR_NR=GGK:PAR_NR
               ADD(R_TABLE)
               SORT(R_TABLE,R:U_NR)
            .
         .
         R:SUMMA = 0
         R:RINDA = 0
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
    .
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted

!************* I.Priekðnodoklis par iekðzemç &ES iegâdâtajâm precçm un saòemtajiem pakalpojumiem ********
!*************** un mums atgrieztâ prece,pakalpojumi (kredîtrçíins) un zaudçts parâds *******************

    SORT(R_TABLE,R:NOS_P)
    IF F:DBF='W'   !WMF
       PRINT(RPT:D1_HEAD)
    ELSIF F:DBF='E'
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='          I.Priekðnodoklis par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'Darîj.'&CHR(9)&|
       'Preèu vai'&CHR(9)&'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'veids'&CHR(9)&'pakalpojumu'&CHR(9)&CHR(9)&'veids'&CHR(9)&|
       'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&CHR(9)&'vçrtîba'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    ELSE !WORD 
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='          I.Priekðnodoklis par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera PVN reìistrâcijas numurs'&|
       CHR(9)&'Darî- juma veids'&CHR(9)&'Preèu vai pakalpojumu vçrtîba bez PVN (Ls)'&CHR(9)&'PVN, Ls'&|
       CHR(9)&'Attaisnojuma dokumenta veids'&CHR(9)&'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
       XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
       ADD(OUTFILEXML)
       TEX:DUF=CLIENT
       DO CONVERT_TEX:DUF
       XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
       ADD(OUTFILEXML)
       XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
       ADD(OUTFILEXML)
       XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
       ADD(OUTFILEXML)
       XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
       ADD(OUTFILEXML)
       XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
       ADD(OUTFILEXML)
       IF INRANGE(B_DAT-S_DAT,32,100)
          ceturksnis=MONTH(B_DAT)/3
          XML:LINE=' ParskCeturksnis>'&ceturksnis&'</ParskCeturksnis>'
       ELSIF INRANGE(B_DAT-S_DAT,180,200)
          pusgads=MONTH(B_DAT)/6
          XML:LINE=' TaksPusgads>'&pusgads&'</TaksPusgads>'
       ELSE
          XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
       .
       ADD(OUTFILEXML)
       XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
       ADD(OUTFILEXML)
       XML:LINE=' Tab>'
       ADD(OUTFILEXML)
       XML:LINE=' Rs>'
       ADD(OUTFILEXML)
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
!       IF ~(R:PAR_TIPS='C') OR R:PVNS[3,2] OR R:PVNS[4,2]   ! +IMPORTA PAKALPOJUMI LATVIJÂ 23.03.2009
       IF ~(R:PAR_TIPS='C') OR (R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !NAV ES vai ES Pakalpojumu PVNnemaksâtâjs
           IF R:D_K='D'              !IEGÂDE,arî imports vai ATGRIEZTA REALIZÂCIJA,VAI MÇS ATGRIEÞAM(-),vai ZAUDÇTS PARÂDS
             PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
!             PAR_PVN   = GETPAR_K(R:PAR_NR,0,13)
             CASE R:PAR_TIPS
             OF 'N'
                DV='I' !IMPORTS NO ~ES
             ELSE
                DV='A' !LATVIJA,ES
             .
             IF ~R:PAR_PVN THEN DV='N'.     !NAV PVN REÌISTRÂCIJAS Nr
             IF R:PVN_TIPS='Z' THEN DV='Z'. !ZAUDÇTS PARÂDS
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
             GG_DOKDAT = GG:DOKDAT
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+R:PVNS[8,2]+|
             R:PVNS[9,2]+R:PVNS[14,2]+R:PVNS[15,2]+R:PVNS[16,2]+R:PVNS[17,2] !18+5+14+21+10+22+12+N21+N10+N22+N12%   Ls
!R:PVNS[1] PVN Ls 18%
!R:PVNS[2] PVN Ls 5%
!R:PVNS[3] PVN_TIPS=I IMPORTA PAKALPOJUMI 18%
!R:PVNS[4] PVN_TIPS=I IMPORTA PAKALPOJUMI  5%
!R:PVNS[5] PVN Ls 14%
!R:PVNS[6] PVN Ls 21%
!R:PVNS[7] PVN Ls 10%
!R:PVNS[8] PVN Ls 22%
!R:PVNS[9] PVN Ls 12%
!R:PVNS[10] PVN_TIPS=I IMPORTA PAKALPOJUMI 21%
!R:PVNS[11] PVN_TIPS=I IMPORTA PAKALPOJUMI 22%
!R:PVNS[12] PVN_TIPS=I IMPORTA PAKALPOJUMI 10%
!R:PVNS[13] PVN_TIPS=I IMPORTA PAKALPOJUMI 12%
!R:PVNS[14] PVN_TIPS=I IMPORTA PAKALPOJUMI 21% ES PVN Nemaksâtâjs
!R:PVNS[15] PVN_TIPS=I IMPORTA PAKALPOJUMI 22% ES PVN Nemaksâtâjs
!R:PVNS[16] PVN_TIPS=I IMPORTA PAKALPOJUMI 10% ES PVN Nemaksâtâjs
!R:PVNS[17] PVN_TIPS=I IMPORTA PAKALPOJUMI 12% ES PVN Nemaksâtâjs
             DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[5,2]/0.14+|
             R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12+R:PVNS[14,2]/0.21+R:PVNS[15,2]/0.22+|
             R:PVNS[16,2]/0.1+R:PVNS[17,2]/0.12
             PVN_SUMMA_K+= PVN_SUMMA
             IF R:PAR_TIPS='C' THEN R63+=PVN_SUMMA.
             GG_DOK_NR=GG:DOK_SENR
             KLUDA#=FALSE

             CASE GG:ATT_DOK
             OF '1'
                ATTDOK='1-nodokïa rçíins'
             OF '2'
                ATTDOK='2-kases èeks vai kvîts'
             OF '3'
                ATTDOK='3-bezskaidras naudas MD'
             OF '4'
                ATTDOK='4-kredîtrçíins'
             OF '5'
                ATTDOK='5-cits'
             OF '6'
                ATTDOK='6-muitas deklarâcija'
             OF 'X'
                ATTDOK='X-atseviðíi neuzrâdâmie darîjumi'
             ELSE
                KLUDA#=TRUE
             .

             DOK_SUMMA_K+=DOK_SUMMA
             IF (BILANCE AND ~INRANGE(ABS(DOK_SUMMA),MINMAXSUMMA,BILANCE-0.01)) OR|     !TÂ BILANCE (max sum) NO IZZFILTPVN
                (~BILANCE AND INRANGE(ABS(DOK_SUMMA),0,MINMAXSUMMA-0.01) AND ~(DV='Z')) !DAR.VEIDS=T
                DOK_SUMMA_P+=DOK_SUMMA
                PVN_SUMMA_P+=PVN_SUMMA
             ELSE
                OPEN(DVWINDOW)
                DISPLAY
                ACCEPT
                   CASE(FIELD())
                   OF ?DV
                      IF EVENT()=EVENT:ACCEPTED THEN BREAK.
                   OF ?OKDV
                      IF EVENT()=EVENT:ACCEPTED THEN BREAK.
                   .
                .
                CLOSE(DVWINDOW)
                NPK+=1
                IF KLUDA#=TRUE
                   KLUDA(27,'attaisnojuma dok. kods: '&CLIP(GG:NOKA)&' '&FORMAT(GG:DATUMS,@D06.)&' UNR='&GG:U_NR)
                .
                IF F:DBF = 'W'
                   PRINT(RPT:D1_DETAIL)
                ELSE
                   OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&DV&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
                   CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK&CHR(9)&GG_DOK_NR&CHR(9)&FORMAT(GG_DOKDAT,@D06.)
                   ADD(OUTFILEANSI)
                .
                IF F:XML_OK#=TRUE
                   XML:LINE=' R>'
                   ADD(OUTFILEXML)
                   XML:LINE=' Npk>'&NPK&'</Npk>'
                   ADD(OUTFILEXML)
                   IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                   XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                   ADD(OUTFILEXML)
                   IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z Idaïai
                   XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
                   ADD(OUTFILEXML)
                   TEX:DUF=PAR_NOS_P
                   DO CONVERT_TEX:DUF
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DarVeids>'&DV&'</DarVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokVeids>'&GG:att_dok&'</DokVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'T00:00:00'&'</DokDatums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' /R>'
                   ADD(OUTFILEXML)
                .
             .
          .
       .
    .
    NPK+=1
    IF F:DBF='W'   !WMF
       PAR_nos_p=''
       PERS_KODS=''
       DV='T'
       dok_summa=dok_summa_p
       PVN_SUMMA=PVN_SUMMA_P
       ATTDOK=''
       GG_DOK_NR=''
       GG_DOKDAT=0
       PRINT(RPT:D1_DETAIL)
       PRINT(RPT:DETAIL1)
       PRINT(RPT:D1_FOOTER)
    ELSE
       OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'T'&CHR(9)&LEFT(FORMAT(DOK_SUMMA_P,@N-_12.2))&CHR(9)&|
       LEFT(FORMAT(PVN_SUMMA_P,@N-_12.2))
       ADD(OUTFILEANSI)
       OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K,@N-_12.2))&CHR(9)&LEFT(FORMAT(PVN_SUMMA_K,@N-_12.2))
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       IF DOK_SUMMA   !EDS 0-es NEÒEM PRETÎ
          XML:LINE=' R>'
          ADD(OUTFILEXML)
          XML:LINE=' Npk>'&NPK&'</Npk>'
          ADD(OUTFILEXML)
          XML:LINE=' DarVeids>'&'T'&'</DarVeids>'    !T-DAR.ZEM 1000,-
          ADD(OUTFILEXML)
          XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
          ADD(OUTFILEXML)
          XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
       XML:LINE=' /Rs>'
       ADD(OUTFILEXML)
       XML:LINE=' VertibaBezPvnSum>'&DOK_SUMMA_K&'</VertibaBezPvnSum>'
       ADD(OUTFILEXML)
       XML:LINE=' PvnVertibaSum>'&PVN_SUMMA_K&'</PvnVertibaSum>'
       ADD(OUTFILEXML)
       XML:LINE=' /Tab>'
       ADD(OUTFILEXML)
       XML:LINE=' /DokPVNMDPv1>'
       ADD(OUTFILEXML)

       SET(OUTFILEXML)
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR() THEN BREAK.
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
          .
       .
       CLOSE(OUTFILEXML)
    .

!************************II.D.SAÒEMTÂS ES PRECES(SAMAKSÂTS PAR PRECI) UN PVN MAKSÂTÂJU PAKALPOJUMI********

    NPK=0
    IF F:DBF='W'   !WMF
       IF F:DTK
           PRINT(RPT:PAGEBREAK)
       .
       PRINT(RPT:D2_HEAD)
    ELSIF F:DBF='E'   !EXCEL
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='  II. Priekðnodoklis par precçm un pakalpojumiem, kas saòemti no ES dalîbvalstîm'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&CHR(9)&'Vçrtîba,'&CHR(9)&|
        'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'No darîjuma partnera'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'PVN reìistrâcijas'&CHR(9)&'Darîj.'&CHR(9)&'no kuras'&CHR(9)&CHR(9)&'valûtâ'&|
        CHR(9)&'Val.'& CHR(9)&'saòemtais rçíins'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'numurs'&CHR(9)&'veids'&CHR(9)&'aprçíinâts PVN'&CHR(9)&CHR(9)&'Summa'&CHR(9)&'kods'&CHR(9)&|
        'Numurs'&CHR(9)&'Datums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    ELSE              !WORD
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' II. Priekðnodoklis par ar precçm un pakalpojumiem, kas saòemti no ES dalîbvalstîm'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera PVN reìistrâcijas numurs'&|
        CHR(9)&'Darî- juma veids'&CHR(9)&'Vçrtîba,no kuras aprçíinâts PVN (Ls)'&CHR(9)&|
        'PVN, Ls'&CHR(9)&'Vçrtîba valûtâ'&CHR(9)&'Val. kods'&CHR(9)&|
        'No darîjuma partnera saòemtâ rçíina Numurs'&CHR(9)&'Datums'
        ADD(OUTFILEANSI)
    .
    IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_PII.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
           F:XML_OK#=FALSE
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
!                     <?xml version="1.0" encoding="windows-1257"?>
           XML:LINE='<<?xml version="1.0" encoding="windows-1257"?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokPVNPESv1>'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
           ADD(OUTFILEXML)
           XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
           ADD(OUTFILEXML)
           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
           ADD(OUTFILEXML)
           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
           ADD(OUTFILEXML)
           XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
           ADD(OUTFILEXML)
           IF INRANGE(B_DAT-S_DAT,32,100)
              ceturksnis=MONTH(B_DAT)/3
              XML:LINE=' ParskCeturksnis>'&ceturksnis&'</ParskCeturksnis>'
           ELSIF INRANGE(B_DAT-S_DAT,180,200)
              pusgads=MONTH(B_DAT)/6
              XML:LINE=' TaksPusgads>'&pusgads&'</TaksPusgads>'
           ELSE
              XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
           .
           ADD(OUTFILEXML)
           XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
           ADD(OUTFILEXML)
           XML:LINE=' Tab>'
           ADD(OUTFILEXML)
           XML:LINE=' Rs>'
           ADD(OUTFILEXML)
        .
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF R:PAR_TIPS='C' AND ~(R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !TIKAI ES PRECE UN PVN MAKS. PAKALPOJUMI
          IF R:D_K='D'
!             IF R:PVN_TIPS='A'
!                PAR_nos_p = '67:'&GETPAR_K(R:PAR_NR,0,2)
!                PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
!             ELSE
                PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
!             .
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
             IF R:PVN_TIPS='I'
                DV='P' !PAKALPOJUMI
                PVN_SUMMA = R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[10,2]+R:PVNS[11,2]+R:PVNS[12,2]+R:PVNS[13,2] !Ls
                DOK_SUMMAV=R:PVNS[3,1]/0.18+R:PVNS[4,1]/0.05+R:PVNS[10,1]/0.21+R:PVNS[11,1]/0.22+R:PVNS[12,1]/0.1+|
                R:PVNS[13,1]/0.12 !ES
                DOK_SUMMA =R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[10,2]/0.21+R:PVNS[11,2]/0.22+R:PVNS[12,2]/0.1+|
                R:PVNS[13,2]/0.12 !Ls
             ELSE
                DV='G' !PRECES
                PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[6,2]+R:PVNS[7,2]+R:PVNS[8,2]+R:PVNS[9,2] !Ls
                DOK_SUMMAV=R:PVNS[1,1]/0.18+R:PVNS[2,1]/0.05+R:PVNS[6,1]/0.21+R:PVNS[7,1]/0.1+R:PVNS[8,1]/0.22+|
                R:PVNS[9,1]/0.12 !ES
                DOK_SUMMA =R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+|
                R:PVNS[9,2]/0.12 !Ls
             .
             X#=GETGG(R:U_NR)  ! POZICIONÇJAM GG
             GG_DOKDAT = GG:DOKDAT
             PVN_SUMMA_K2+= PVN_SUMMA
             DOK_VAL=R:VAL
             GG_DOK_NR=GG:DOK_SENR
             DOK_SUMMA_K2+=DOK_SUMMA
             IF DOK_SUMMA
                NPK+=1
                IF F:DBF = 'W'
                     PRINT(RPT:D2_DETAIL)                                                                                                 
                ELSE
                     OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&DV&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N12.2))&|
                     CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N12.2))&CHR(9)&LEFT(FORMAT(dok_summav,@N12.2))&CHR(9)&|
                     DOK_VAL&CHR(9)&GG:DOK_SENR&CHR(9)&FORMAT(GG_DOKDAT,@D06.)
                     ADD(OUTFILEANSI)
                .
                IF F:XML_OK#=TRUE
                   XML:LINE=' R>'
                   ADD(OUTFILEXML)
                   XML:LINE=' Npk>'&NPK&'</Npk>'
                   ADD(OUTFILEXML)
                   IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                   XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                   ADD(OUTFILEXML)
                   IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z ???
                   XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'             !atïaujam 20
                   ADD(OUTFILEXML)
                   TEX:DUF=PAR_NOS_P
                   DO CONVERT_TEX:DUF
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DarVeids>'&DV&'</DarVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValVeriba>'&DOK_SUMMAV&'</ValVeriba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValKods>'&DOK_VAL&'</ValKods>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'T00:00:00'&'</DokDatums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' /R>'
                   ADD(OUTFILEXML)
                .
             .
          .
       .
    .
    IF F:DBF = 'W'
        PRINT(RPT:D2_FOOTER)
    ELSE
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K2,@N_12.2))&CHR(9)&|
        LEFT(FORMAT(PVN_SUMMA_K2,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       XML:LINE=' /Rs>'
       ADD(OUTFILEXML)
       XML:LINE=' VertibaBezPvnSum>'&DOK_SUMMA_K2&'</VertibaBezPvnSum>'
       ADD(OUTFILEXML)
       XML:LINE=' PvnVertibaSum>'&PVN_SUMMA_K2&'</PvnVertibaSum>'
       ADD(OUTFILEXML)
       XML:LINE=' /Tab>'
       ADD(OUTFILEXML)
       XML:LINE=' /DokPVNPESv1>'
       ADD(OUTFILEXML)
!       CLOSE(OUTFILEXML)

       SET(OUTFILEXML)
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR() THEN BREAK.
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
          .
       .
       CLOSE(OUTFILEXML)
    .

!************* III.Nodoklis par piegâdâtajâm precçm un sniegtajiem pakalpojumiem ********
!************* ja mçs atgrieþam preci- NEUZRÂDAM 20.07.2010 *****************************

!    SORT(R_TABLE,R:NOS_P)
    IF F:DBF='W'   !WMF
       IF F:DTK
           PRINT(RPT:PAGEBREAK)
       .
       PRINT(RPT:D3_HEAD)
    ELSIF F:DBF='E'
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='         III.Nodoklis par piegâdâtajâm precçm un sniegtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'PVND'&CHR(9)&'Preèu vai'&|
       CHR(9)&'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'rinda'&CHR(9)&'pakalpojumu'&CHR(9)&CHR(9)&'Nosaukums'&CHR(9)&|
       'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&CHR(9)&'vçrtîba'
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    ELSE !WORD 
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='         III.Nodoklis par piegâdâtajâm precçm un sniegtajiem pakalpojumiem'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera PVN reìistrâcijas numurs'&|
       CHR(9)&'PVND rinda'&CHR(9)&'Preèu vai pakalpojumu vçrtîba bez PVN (Ls)'&CHR(9)&'PVN, Ls'&|
       CHR(9)&'Attaisnojuma dokumenta veids'&CHR(9)&'Numurs'&CHR(9)&'Datums'
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       XMLFILENAME=USERFOLDER&'\PVN_PIII.XML'
       CHECKOPEN(OUTFILEXML,1)
       CLOSE(OUTFILEXML)
       OPEN(OUTFILEXML,18)
       IF ERROR()
          KLUDA(1,XMLFILENAME)
          F:XML_OK#=FALSE
       ELSE
          EMPTY(OUTFILEXML)
          F:XML_OK#=TRUE
          XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
          ADD(OUTFILEXML)
          XML:LINE=' DokPVNMDNv1>'
          ADD(OUTFILEXML)
       .
       IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
       XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
       ADD(OUTFILEXML)
       TEX:DUF=CLIENT
       DO CONVERT_TEX:DUF
       XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
       ADD(OUTFILEXML)
       XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
       ADD(OUTFILEXML)
       XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
       ADD(OUTFILEXML)
       XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
       ADD(OUTFILEXML)
       XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
       ADD(OUTFILEXML)
       IF INRANGE(B_DAT-S_DAT,32,100)
          ceturksnis=MONTH(B_DAT)/3
          XML:LINE=' ParskCeturksnis>'&ceturksnis&'</ParskCeturksnis>'
       ELSIF INRANGE(B_DAT-S_DAT,180,200)
          pusgads=MONTH(B_DAT)/6
          XML:LINE=' TaksPusgads>'&pusgads&'</TaksPusgads>'
       ELSE
          XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
       .
       ADD(OUTFILEXML)
       XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
       ADD(OUTFILEXML)
       XML:LINE=' Tab>'
       ADD(OUTFILEXML)
       XML:LINE=' Rs>'
       ADD(OUTFILEXML)
    .
    NPK=0
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C')
!          IF R:D_K='K' AND ~(R:PVN_TIPS='A')| !20.07.2010 KO MÇS ATGRIEÞAM-NERÂDAM, JO 57 RINDA EDS NEIET...
          IF R:D_K='K'| !07.03.2011 ARÎ KO MUMS ATGRIEÞ
             AND ~(R:PVN_TIPS='I')  !28.07.2010 PAKALPOJUMI NO RU-NERÂDAM
             PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
!             GG_DOKDAT = GG:DOKDAT
             GG_DOKDAT = GG:DATUMS
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+|
             R:PVNS[8,2]+R:PVNS[9,2] !18+5+14+21+10+22+12%   Ls
             IF R:SUMMA
                DOK_SUMMA=R:SUMMA
             ELSE
                DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.14+|
                R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12
             .
!             IF R:PVN_TIPS='A'  20.07.2010
!                PVN_SUMMA=-PVN_SUMMA
!                DOK_SUMMA=-DOK_SUMMA
!             .
!             PVN_SUMMA_K+= PVN_SUMMA
             GG_DOK_NR=GG:DOK_SENR
             KLUDA#=FALSE

             CASE GG:ATT_DOK
             OF '1'
                ATTDOK='1-nodokïa rçíins'
             OF '2'
                ATTDOK='2-kases èeks vai kvîts'
             OF '3'
                ATTDOK='3-bezskaidras naudas MD'
             OF '4'
                ATTDOK='4-kredîtrçíins'
             OF '5'
                ATTDOK='5-cits'
             OF '6'
                ATTDOK='6-muitas deklarâcija'
             OF 'X'
                ATTDOK='X-atseviðíi neuzrâdâmie darîjumi'
             ELSE
                KLUDA#=TRUE
             .
!             IF DOK_SUMMA < 0
!             IF R:PVN_TIPS='A'          !20.07.2010
!                R:RINDA=57              !JÂSKATÂS
!             .
             DOK_SUMMA_K3+=DOK_SUMMA
             PVN_SUMMA_K3+=PVN_SUMMA
!             IF (BILANCE AND ~INRANGE(DOK_SUMMA,MINMAXSUMMA,BILANCE-0.01)) OR|
!                (~BILANCE AND ABS(DOK_SUMMA) < MINMAXSUMMA)
             IF (BILANCE AND ~INRANGE(ABS(DOK_SUMMA),MINMAXSUMMA,BILANCE-0.01)) OR|   !TÂ BILANCE NO IZZFILTPVN
                (~BILANCE AND INRANGE(ABS(DOK_SUMMA),0,MINMAXSUMMA-0.01))             !SADAÏA T
                DOK_SUMMA_P3+=DOK_SUMMA
                PVN_SUMMA_P3+=PVN_SUMMA
             ELSIF GG:ATT_DOK='X'
                DOK_SUMMA_X+=DOK_SUMMA
                PVN_SUMMA_X+=PVN_SUMMA
             ELSE
                NPK+=1
                IF KLUDA#=TRUE
                   KLUDA(27,'attaisnojuma dok. kods: '&CLIP(GG:NOKA)&' '&FORMAT(GG:DATUMS,@D06.)&' UNR='&GG:U_NR)
                .
                IF F:DBF = 'W'
                   PRINT(RPT:D3_DETAIL)
                ELSE
                   OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&R:RINDA&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
                   CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK&CHR(9)&GG_DOK_NR&CHR(9)&FORMAT(GG_DOKDAT,@D06.)
                   ADD(OUTFILEANSI)
                .
                IF F:XML_OK#=TRUE
                   XML:LINE=' R>'
                   ADD(OUTFILEXML)
                   XML:LINE=' Npk>'&NPK&'</Npk>'
                   ADD(OUTFILEXML)
                   IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                   XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                   ADD(OUTFILEXML)
                   IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z ???
                   XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
                   ADD(OUTFILEXML)
                   TEX:DUF=PAR_NOS_P
                   DO CONVERT_TEX:DUF
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DeklRindNr>'&R:RINDA&'</DeklRindNr>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokVeids>'&GG:att_dok&'</DokVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'T00:00:00'&'</DokDatums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' /R>'
                   ADD(OUTFILEXML)
                .
             .
          .
       .
    .
    IF F:XML_OK#=TRUE AND DOK_SUMMA_X
       NPK+=1
       PAR_nos_p=''
       PERS_KODS=''
       dok_summa=dok_summa_X
       PVN_SUMMA=PVN_SUMMA_X
       ATTDOK='X-atseviðíi neuzrâdâmie'
       GG_DOK_NR=''
       GG_DOKDAT=0
       IF F:DBF='W'   !WMF
          PRINT(RPT:D3_DETAIL)
       ELSE
          OUTA:LINE=NPK&CHR(9)&CHR(9)&CHR(9)&R:RINDA&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
          CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK
          ADD(OUTFILEANSI)
       .
       XML:LINE=' R>'
       ADD(OUTFILEXML)
       XML:LINE=' Npk>'&NPK&'</Npk>'
       ADD(OUTFILEXML)
       XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
       ADD(OUTFILEXML)
       XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
       ADD(OUTFILEXML)
       XML:LINE=' DokVeids>'&'X'&'</DokVeids>'
       ADD(OUTFILEXML)
       XML:LINE=' /R>'
       ADD(OUTFILEXML)
    .
    NPK+=1
    PAR_nos_p=''
    PERS_KODS=''
    dok_summa=dok_summa_p3
    PVN_SUMMA=PVN_SUMMA_P3
    ATTDOK='T-darîjumi zem Ls 1000,-'
    GG_DOK_NR=''
    GG_DOKDAT=0
    R:RINDA=0
    IF F:DBF='W'   !WMF
       IF DOK_SUMMA
          PRINT(RPT:D3_DETAIL)
       .
       PRINT(RPT:DETAIL3)     !SVÎTRA
       CTRL=PVN_SUMMA_K3-(PVN_SUMMA_K-R63)
       IF CTRL >0
          RINDA=80
       ELSE
          RINDA=70
       .
       CTRL_TEXT='PVN1_III ('&CLIP(LEFT(FORMAT(PVN_SUMMA_K3,@n-_12.2)))&') - (PVN1_I ('&|
       CLIP(LEFT(FORMAT(PVN_SUMMA_K,@n-_12.2)))&') - R63 ('&CLIP(LEFT(FORMAT(R63,@n-_12.2)))&|
       ')) = '&CLIP(LEFT(FORMAT(CTRL,@n_12.2)))&' jâsakrît ar Deklarâcijas '&RINDA&' rindu'

       PRINT(RPT:D3_FOOTER)
       ENDPAGE(report)
    ELSE
       IF DOK_SUMMA
          OUTA:LINE=NPK&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
          CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK
          ADD(OUTFILEANSI)
       .
       OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K3,@N-_12.2))&CHR(9)&|
       LEFT(FORMAT(PVN_SUMMA_K3,@N-_12.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='Atbildîgâ persona_______________________________________'
       ADD(OUTFILEANSI)
    .
    IF F:XML_OK#=TRUE
       IF DOK_SUMMA
          XML:LINE=' R>'
          ADD(OUTFILEXML)
          XML:LINE=' Npk>'&NPK&'</Npk>'
          ADD(OUTFILEXML)
          XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
          ADD(OUTFILEXML)
          XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
          ADD(OUTFILEXML)
          XML:LINE=' DokVeids>'&'T'&'</DokVeids>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
       XML:LINE=' /Rs>'
       ADD(OUTFILEXML)
       XML:LINE=' VertibaBezPvnSum>'&DOK_SUMMA_K3&'</VertibaBezPvnSum>'
       ADD(OUTFILEXML)
       XML:LINE=' PvnVertibaSum>'&PVN_SUMMA_K3&'</PvnVertibaSum>'
       ADD(OUTFILEXML)
       XML:LINE=' /Tab>'
       ADD(OUTFILEXML)
       XML:LINE=' /DokPVNMDNv1>'
       ADD(OUTFILEXML)
!       CLOSE(OUTFILEXML)

       SET(OUTFILEXML)
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR() THEN BREAK.
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
          .
       .
       CLOSE(OUTFILEXML)
    .
  .
!***********************************************************************************************
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
     .
  ELSE
     ANSIJOB
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
  FREE(R_TABLE)
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
     ANSIFILENAME=''
  .
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
B_PVN_PIE2_2010      PROCEDURE                    ! Declare Procedure
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
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
MENESS               STRING(20)
NPK                  ULONG
CG                   STRING(10)
NOT0                 STRING(10)
NOT1                 STRING(45)
NOT2                 STRING(45)
NOT3                 STRING(45)

R_TABLE      QUEUE,PRE(R)
KEY             STRING(23) !Elya
REG_NR          STRING(22)
SUMMA           DECIMAL(12,2)
V_KODS          STRING(2) !PAGAIDÂM NEIZMANTO
K               STRING(1)
             .

R_SUMMA              DECIMAL(12,2)
SUMMA_K              DECIMAL(12,2)
E                    STRING(1)
EE                   STRING(8)
DV                   STRING(1)  !DARÎJUMA VEIDS P/G

TEX:DUF             STRING(100)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
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

!-----------------------------------------------------------------------------
report REPORT,AT(198,198,8000,10604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,200,8000,302),USE(?unnamed:4)
         STRING(@s1),AT(3635,21,365,260),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN 2 '),AT(7250,115,521,156),USE(?String107:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
RPT_Head DETAIL,AT(10,10,7990,1385),USE(?unnamed)
         STRING(@s10),AT(7146,115,521,156),USE(NOT0)
         STRING(@s45),AT(3177,708,3385,208),USE(client),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskats par preèu piegâdçm un sniegtajiem pakalpojumiem Eiropas Savienîbas teri' &|
             'torijâ '),AT(344,52,6792,208),USE(?String11:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('.gada'),AT(2490,260),USE(?String120),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(2052,260),USE(GADS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(2969,260),USE(MENESS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums'),AT(510,719),USE(?String1:6),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s6),AT(7240,1042),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('Juridiskâ adrese'),AT(510,917),USE(?String1:7),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(3177,917,3385,208),USE(gl:adrese),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(5354,260,2396,156),USE(NOT1,,?NOT1:2),TRN,RIGHT(4)
         STRING(@s45),AT(5354,385,2396,156),USE(NOT2),TRN,RIGHT(4)
         STRING(@s8),AT(7094,854),USE(EE),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(5354,510,2396,156),USE(NOT3),TRN,RIGHT(4)
         STRING('Apliekamâs personas reìistrâcijas numurs'),AT(521,1125),USE(?String1:74),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(3177,1115,1094,208),USE(gl:vid_nr,,?gl:vid_nr:2),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Tâlrunis'),AT(4313,1125),USE(?String1:73),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s15),AT(4833,1115,1094,208),USE(SYS:TEL),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
Head   DETAIL,AT(,,,1083),USE(?unnamed:2)
         STRING('Valsts kods'),AT(1052,625,1458,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera ar PVN apliekamâs'),AT(2844,573,2292,156),USE(?String1:17),CENTER, |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reìistrâcijas numurs '),AT(2750,729,2385,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(latos)'),AT(5625,729,625,156),USE(?String1:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,521,6927,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2719,521,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(5156,521,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(417,885,6927,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(448,938,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(948,938,1719,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2844,938,2292,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(5188,938,1458,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(6698,938,625,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(448,625,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,521,0,573),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7344,521,0,573),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('K'),AT(6698,625,625,208),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6667,521,0,573),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Preèu piegâdes summa'),AT(5188,573,1458,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,521,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,208)
         LINE,AT(6667,0,0,229),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,229),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2719,-10,0,229),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(833,0,0,229),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@s2),AT(1521,52,677,156),USE(R:REG_NR[1:2]),CENTER
         LINE,AT(7344,0,0,229),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(417,0,6927,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s20),AT(3260,52,1458,156),USE(R:REG_NR[3:22]),CENTER(2)
         STRING(@n_4),AT(469,52,,156),CNT,USE(NPK),RIGHT
         LINE,AT(417,0,0,229),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5563,52,,156),USE(R:summa),RIGHT
         STRING(@S1),AT(6833,52,417,156),USE(R:K),CENTER
       END
detail2 DETAIL,AT(,,,94)
         LINE,AT(417,52,6927,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,115),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,115),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(833,0,0,115),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(2719,-10,0,115),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,115),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(417,0,0,115),USE(?Line2:15),COLOR(COLOR:Black)
       END
FOOTER DETAIL,PAGEAFTER(-1),AT(,-10,,1604),USE(?unnamed:3)
         LINE,AT(417,365,6927,0),USE(?Line31:19),COLOR(COLOR:Black)
         STRING('G-preces P-pakalpojumi'),AT(6250,385,1104,135),USE(?String37:8),TRN,LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('Atbildîgâ persona'),AT(365,573,938,177),USE(?String37:4),TRN,LEFT
         STRING('RS: '),AT(7365,1375,208,208),USE(?String37),LEFT
         STRING(@S1),AT(7573,1375,208,208),USE(RS),CENTER
         STRING(@n-_13.2),AT(5500,208,,156),USE(summa_k),RIGHT
         STRING('Kopâ : '),AT(938,208,1146,156),USE(?String33:9),LEFT
         LINE,AT(833,0,0,365),USE(?Line32:27),COLOR(COLOR:Black)
         LINE,AT(2969,1198,3438,0),USE(?Line55:3),COLOR(COLOR:Black)
         STRING('200____. gada_____. _{23}'),AT(365,1250,2604,208),USE(?String37:7),TRN,LEFT
         STRING('Valsts Ieòçmumu Dienesta atbildigâ amatpersona:'),AT(365,1042,2500,208),USE(?String37:3), |
             LEFT
         LINE,AT(1302,729,3021,0),USE(?Line55),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2990,750,1406,208),USE(?String37:2),TRN,LEFT
         STRING('200____. gada_____. _{23}'),AT(365,781,2604,208),USE(?String37:6),TRN,LEFT
         STRING('(paraksts un tâ atðifrçjums)'),AT(3385,1250,1406,208),USE(?String37:5),TRN,LEFT
         STRING(@s25),AT(4323,573),USE(SYS:PARAKSTS1),LEFT
         LINE,AT(417,156,6927,0),USE(?Line31:18),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,365),USE(?Line32:25),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,365),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,365),USE(?Line32:24),COLOR(COLOR:Black)
         LINE,AT(2719,0,0,365),USE(?Line32:23),COLOR(COLOR:Black)
         LINE,AT(417,0,0,365),USE(?Line32:22),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10900,8000,188),USE(?unnamed:5)
         LINE,AT(104,0,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
         STRING(@PLapa<<<#/______P),AT(6823,21),PAGENO,USE(?PageCount),RIGHT
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

 OMIT('MARIS')
detail3 DETAIL,PAGEAFTER(-1),AT(,,,1354)
         LINE,AT(104,260,10365,0),USE(?Line1:19),COLOR(00H)
         STRING('RS: '),AT(417,1094,271,208) ,USE(?String37),LEFT
         STRING(@S1),AT(729,1094,208,208) ,USE(RS),CENTER
         STRING(@n-_12.2),AT(5000,104,781,156) ,USE(pvn_summa_k),RIGHT
         STRING(@n-_13.2),AT(4063,104,,156) ,USE(dok_summa_k),RIGHT
         STRING('Kopâ : '),AT(625,104,1146,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String3:9),LEFT
         LINE,AT(10469,0,0,260),USE(?Line2:28),COLOR(00H)
         LINE,AT(521,0,0,260),USE(?Line2:27),COLOR(00H)
         STRING(@d6),AT(8802,521) ,USE(datums)
         STRING('Uzòçmuma vadîtâjs'),AT(260,521),USE(?String55:3)
         STRING('Grâmatvedis'),AT(4583,521),USE(?String55)
         LINE,AT(1458,729,2552,0),USE(?Line55),COLOR(00H)
         LINE,AT(5365,729,2552,0),USE(?Line55:2),COLOR(00H)
         STRING('(paraksts un tâ atðifrçjums)'),AT(1823,781),USE(?String55:2)
         STRING('(paraksts un tâ atðifrçjums)'),AT(5729,781),USE(?String55:4)
         LINE,AT(104,52,10365,0),USE(?Line1:18),COLOR(00H)
         LINE,AT(8385,0,0,260),USE(?Line2:38),COLOR(00H)
         LINE,AT(9427,0,0,260),USE(?Line2:39),COLOR(00H)
         LINE,AT(7813,0,0,260),USE(?Line2:7),COLOR(00H)
         LINE,AT(5833,0,0,260),USE(?Line2:26),COLOR(00H)
         LINE,AT(4948,0,0,260),USE(?Line2:25),COLOR(00H)
         LINE,AT(4010,0,0,260),USE(?Line2:24),COLOR(00H)
         LINE,AT(2813,0,0,260),USE(?Line2:23),COLOR(00H)
         LINE,AT(104,0,0,260),USE(?Line2:22),COLOR(00H)
       END
 MARIS
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  IF F:XML
     EE='PVN2.XML'
  .
  MENESS=MENVAR(MEN_NR,1,2)
  IF S_DAT >= DATE(1,1,2006) !N42
       NOT0=''
       NOT1=''
       NOT2=''
       NOT3=''
  ELSIF S_DAT >= DATE(7,1,2005) !VID RÎKOJUMS N1414
       NOT0='Pielikums'
       NOT1='ar Valsts ieòçmumu dienesta'
       NOT2='2005.gada 12.jûlija rîkojumu Nr.1414'
       NOT3='apstiprinâtajiem metodiskajiem norâdîjumiem'
  ELSE
       NOT0='Pielikums'
       NOT1='Ministru kabineta'
       NOT2='2004.g.13.janvâra'
       NOT3='noteikumiem Nr 29'
  .
!    IF F:XML THEN E='E' ELSE E=''. PAGAIDÂM VÇL NAV

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF PAR_K::Used = 0
    CHECKOPEN(PAR_K,1)
  end
  PAR_K::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('kkk',kkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN 2'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K102000'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !EXCEL,WORD
        IF ~OPENANSI('PVN_PIE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {50}VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}Pârskats par preèu piegâdçm un sniegtajiem pakalpojumiem Eiropas Savienîbas teritorijâ'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Taksâcijas periods:'&CHR(9)&GL:DB_GADS&'. gads '&MENESS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums'&chr(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs'&chr(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'   !EXCEL
           OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'Preèu vai'&CHR(9)&|
           'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'pakalpojumu'&CHR(9)&CHR(9)&'Nosaukums'&CHR(9)&'Sçrija '&|
           CHR(9)&'Numurs'&CHR(9)&'Datums'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&'vçrtîba'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
           ADD(OUTFILEANSI)
        ELSE
           OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera ar PVN apliekamâs personas reì. Nr'&|
           CHR(9)&'Preèu vai pakalpojumu vçrtîba bez PVN (Ls)'&CHR(9)&'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta Nosaukums'&|
           CHR(9)&'Sçrija '&CHR(9)&'Datums'
         .
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
      IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN2.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE=' KSParsk>'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
           ADD(OUTFILEXML)
           XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
           ADD(OUTFILEXML)
           XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
           ADD(OUTFILEXML)
           XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
           ADD(OUTFILEXML)
           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
           ADD(OUTFILEXML)
           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
           ADD(OUTFILEXML)
           XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
           ADD(OUTFILEXML)
           XML:LINE=' Tab>'
           ADD(OUTFILEXML)
           XML:LINE=' Rs>'
           ADD(OUTFILEXML)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
!         IF INSTRING(GGK:BKK[1],'568') AND GGK:SUMMA AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
         !Elya IF INSTRING(GGK:BKK[1],'68') AND GGK:SUMMA AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
         IF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))  AND GGK:SUMMA AND GGK:D_K='K' !IR DEFINÇTI NEAPL. DARÎJUMI
 !stop(ggk:summa)
            R_SUMMA=0
!            stop (GGK:BKK)
!                stop (GETPAR_K(GGK:PAR_NR,0,20))
            IF GETPAR_K(GGK:PAR_NR,0,20)='C' !C=ES
               C#=GETKON_K(GGK:BKK,2,1)
               DV='G' !PRECE
               LOOP R#=1 TO 2
!                  stop(KON:PVND[R#]&' '&GGK:SUMMA)
                  CASE KON:PVND[R#]
                  !Elya un ari seit var but 45 0% (preces uz ES (trissturveida darijumi) ar S piez. un sask 33.p 3.dala ar C piez.)
                  OF 45
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='G' !PRECES
                  OF 458
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='S' !PRECES
                  OF 450
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='C' !PRECES
                  OF 482
                     R_SUMMA += GGK:SUMMA      ! ES PAKALPOJUMI
                     DV='P' !PAKALPOJUMI
                  !Elya 
!                  OF 43                        ! Neapliekamie darîjumi
!                     R_SUMMA += GGK:SUMMA
!                  OF 44                    
!    !                 R44 += GGK:SUMMA         ! BRÎVOSTAS UN SEZ
!                  OF 45
!                     R_SUMMA += GGK:SUMMA      ! ES PRECES
!                     DV='G' !PRECES
!                  OF 46
!                     R_SUMMA += GGK:SUMMA      ! ES MONTÂÞAS DARBI
!                  OF 47
!                     R_SUMMA += GGK:SUMMA      ! ES JAUNAS A/M
!                  OF 48
!                     R_SUMMA += GGK:SUMMA      ! ÐITAM TE NEVAJADZÇTU BÛT
!                     DV='P' !PAKALPOJUMI
!                  OF 481
!                     R_SUMMA += GGK:SUMMA      !
!                  OF 482
!                     R_SUMMA += GGK:SUMMA      ! ES PAKALPOJUMI
!                     DV='P' !PAKALPOJUMI
!                  OF 49
!    !                 R49 += GGK:SUMMA
                  ELSE
    !                 KLÛDA
                  .
                  IF R_SUMMA THEN BREAK.       ! LAI NENODUBLÇ
               .
               IF R_SUMMA
                  R:REG_NR=PAR:PVN !S22
                  R:K=DV
                  !Elya GET(R_TABLE,R:REG_NR)
                  R:KEY=CLIP(R:REG_NR)&R:K
                  GET(R_TABLE,R:KEY)
                  IF ERROR()
                     R:SUMMA =R_SUMMA
    !                 R:V_KODS=PAR:V_KODS
                     R:REG_NR=PAR:PVN !S22
                     R:K=DV
                     ADD(R_TABLE)
                     !Elya SORT(R_TABLE,R:REG_NR)
                     SORT(R_TABLE,R:KEY)
                  ELSE
                     R:SUMMA +=R_SUMMA
                     PUT(R_TABLE)
                  .
               .
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(R_TABLE,R:REG_NR)
    PRINT(RPT:RPT_HEAD)
    PRINT(RPT:HEAD)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       SUMMA_K+=R:SUMMA
       NPK+=1
       IF F:DBF = 'W'
          PRINT(RPT:DETAIL)
       ELSE
!           OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&FORMAT(DOK_SUMMA,@N12.2)&CHR(9)&FORMAT(PVN_SUMMA,@N12.2)&CHR(9)&ATTDOK&CHR(9)&FORMAT(GG:DOK_SE,@S7)&CHR(9)&FORMAT(GG:DOK_NR,@N_10)&CHR(9)&FORMAT(GG:DATUMS,@D6)
!           ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
       END
       IF F:XML_OK#=TRUE
          XML:LINE=' R>'
          ADD(OUTFILEXML)
          IF ~R:REG_NR[1:2] THEN KLUDA(87,CLIP(getpar_k(R:REG_NR,0,1))&' Valsts kods').
          XML:LINE=' Valsts>'&R:REG_NR[1:2]&'</Valsts>'
          ADD(OUTFILEXML)
          IF ~CLIP(R:REG_NR[3:22]) THEN KLUDA(87,CLIP(GETPAR_K(R:REG_NR,0,1))&' NMR kods'). !dati:max=11z ???
   !       XML:LINE=' PVNNumurs>'&CLIP(R:REG_NR[3:13])&'</PVNNumurs>'
          XML:LINE=' PVNNumurs>'&CLIP(R:REG_NR[3:22])&'</PVNNumurs>'                        !atïaujam 20,EDS pârbauda
          ADD(OUTFILEXML)
          XML:LINE=' Summa>'&R:summa&'</Summa>'
          ADD(OUTFILEXML)
          XML:LINE=' Pazime>'&R:K&'</Pazime>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
    .
    PRINT(RPT:DETAIL2)
    PRINT(RPT:FOOTER)
    IF F:DBF = 'W'
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
!        OUTA:LINE='Kopâ: {55}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(DOK_SUMMA_K,@N12.2)&CHR(9)&FORMAT(PVN_SUMMA_K,@N12.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' Uzòçmuma vadîtâjs____________________'&CHR(9)&'Grâmatvedis____________________'
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
  IF F:XML_OK#=TRUE
     XML:LINE=' /Rs>'
     ADD(OUTFILEXML)
     XML:LINE=' /Tab>'
     ADD(OUTFILEXML)
     XML:LINE=' /KSParsk>'
     ADD(OUTFILEXML)
!       CLOSE(OUTFILEXML)

     SET(OUTFILEXML)
     LOOP
        NEXT(OUTFILEXML)
        IF ERROR() THEN BREAK.
        IF ~XML:LINE[1]
           XML:LINE[1]='<'
           PUT(OUTFILEXML)
        .
     .
     CLOSE(OUTFILEXML)
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
  FREE(R_TABLE)
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
