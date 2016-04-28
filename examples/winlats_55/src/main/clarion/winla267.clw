                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_DEK_2009       PROCEDURE                    ! Declare Procedure
CG           STRING(10)
RejectRecord LONG
EOF          BYTE
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)
M            STRING(1)

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
precizeta    STRING(10)
E            STRING(1)
EE           STRING(15)
VIRSRAKSTS   STRING(70)

Q_TABLE      QUEUE,PRE(Q) !ES
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(2)
             .

K_TABLE      QUEUE,PRE(K) !KASE
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(4)
ANOTHER_K       BYTE
             .

PPR             BYTE,DIM(2)

SOURCE_FOR_50   DECIMAL(12,2)
SOURCE_FOR_51   DECIMAL(12,2)
SOURCE_FOR_41   DECIMAL(12,2),DIM(2)
SOURCE_FOR_42   DECIMAL(12,2),DIM(2)

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
SB_DAT          STRING(21)
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
detail DETAIL,AT(-10,10,8000,11250),USE(?unnamed)
         STRING(@S10),AT(469,156),USE(PRECIZETA),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienests'),AT(2313,625),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7375,813),USE(?String1:2),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4938,604,2813,156),USE(NOT3),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,302,2813,156),USE(NOT1),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(4938,458,2813,156),USE(NOT2),TRN,RIGHT(4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@S70),AT(42,927,6938,229),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(taksâcijas periods)'),AT(5135,1146,1198,156),USE(?String3),CENTER
         STRING(@s21),AT(2365,1135),USE(SB_DAT),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pielikums'),AT(7177,156,469,156),USE(?String107),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(3677,167),USE(EE),TRN,LEFT(1)
         STRING(@S1),AT(3385,52,281,333),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums:'),AT(260,1406),USE(?String8),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(2396,1406,3333,208),USE(CLIENT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(7219,1417),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('Juridiskâ adrese:'),AT(260,1667),USE(?String10),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(1354,1667,3385,208),USE(GL:adrese),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1354,0,6979),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(208,1354,7552,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Apliekamâs personas reìistrâcijas Numurs :'),AT(260,1927),USE(?String12),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(2969,1927,1094,208),USE(GL:VID_NR),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,2448,0,5885),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(7760,1354,0,6979),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Tâlrunis:'),AT(260,2188),USE(?String10:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s15),AT(833,2188,1198,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2448,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'),AT(260,2500,3073,208),USE(?String18),LEFT, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('40'),AT(5521,2552,208,156),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,2552,885,156),USE(R40),RIGHT
         STRING('ar PVN 21% apliekamie darîjumi (arî paðpatçriòð)'),AT(260,2688,2865,156),USE(?String19), |
             LEFT
         STRING('ar PVN 0% apliekamie darîjumi, t.sk.:'),AT(260,3000,2552,156),USE(?String19:2),LEFT
         STRING('-uz ES dalîbvalstîm piegâdâtâs preces'),AT(417,3313,2448,156),USE(?String19:3),LEFT
         STRING('43'),AT(5521,3000,208,156),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,2844,885,156),USE(R42),RIGHT
         STRING(@N-_12.2B),AT(5781,3000,885,156),USE(R43),RIGHT
         STRING(@N-_12.2B),AT(5781,3156,885,156),USE(R44),RIGHT
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
         STRING('Ar PVN neapliekamie darîjumi'),AT(260,4063,1823,156),USE(?String31)
         STRING('47'),AT(5521,3625,208,156),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,3625,885,156),USE(R47),RIGHT
         STRING('-uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'),AT(417,3625,3333,156),USE(?String19:7), |
             LEFT
         STRING('PRIEKÐNODOKLIS (latos), no tâ :'),AT(260,5615,2292,156),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,4740,885,156),USE(R52),RIGHT
         STRING('54'),AT(5521,5052,208,156),USE(?String22:29),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('51'),AT(5521,4375,208,156),USE(?String22:10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,4375,885,156),USE(R51),RIGHT
         STRING('No ES dalîbvalstîm saòemtâs preces (10%)'),AT(260,4375,2552,156),USE(?String31:3)
         STRING('par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'),AT(260,5771,3958,156), |
             USE(?String37),LEFT
         STRING('par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'),AT(260,5927,4740,156), |
             USE(?String38),LEFT
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu'),AT(260,6083,4063,156), |
             USE(?String39),LEFT
         STRING('zemnieku saimniecîbâm izmaksâtâ PVN 12% kompensâcija'),AT(260,6396,3438,156),USE(?String40)
         STRING(@N-_12.2B),AT(5833,6240,833,156),USE(R64),RIGHT
         STRING('66'),AT(5521,6552,208,156),USE(?String22:17),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,6719,833,156),USE(R67),RIGHT
         STRING(@N-_12.2B),AT(5833,6396,833,156),USE(R65),RIGHT
         STRING('[P]'),AT(5521,7396,167,156),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('67'),AT(5521,6719,208,156),USE(?String22:18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas:'),AT(260,6771,729,156),USE(?String46:4),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@N-_12.2B),AT(5833,7031,833,156),USE(R68),RIGHT
         STRING(@N-_12.2B),AT(5781,7188,885,156),USE(R58),RIGHT
         STRING('KOPSUMMA:'),AT(260,7438),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitâmais priekðnodoklis'),AT(1667,7396,1719,156),USE(?String46:8),TRN,LEFT
         STRING('aprçíinâtais nodoklis'),AT(1667,7188,1719,156),USE(?String46:7),TRN,LEFT
         STRING('atskaitâmais priekðnodoklis'),AT(1667,7031,1719,156),USE(?String46:6),TRN,LEFT
         STRING('[S]'),AT(5521,7552,167,156),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais nodoklis'),AT(1667,7552,1719,156),USE(?String46:9),TRN,LEFT
         STRING('Sask.ar likuma 13.2.p.:'),AT(260,7083,1344,156),USE(?String46:5),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING(@N-_12.2B),AT(5781,7552,885,156),USE(SS),RIGHT
         STRING('58'),AT(5521,7188,208,156),USE(?String22:26),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
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
         LINE,AT(833,8750,0,313),USE(?Line29:3),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2292,10469,1646,198),USE(?String67:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(3594,9271,4167,0),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@d06.),AT(5677,10208),USE(datums),FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(1510,10417,2448,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2448,10938),USE(?String67),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Pieprasîjums par pievienotâs vçrtîbas nodokïa pârmaksas atmaksu'),AT(2240,8385),USE(?String63:2), |
             TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('(datums)'),AT(5729,10938,531,198),USE(?String68:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Budþetâ maksâjamâ nodokïa summa, ja P<<S'),AT(260,8125),USE(?String59:3),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,8125,885,208),USE(R80),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,7917,885,208),USE(R70),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('80'),AT(5469,8125,260,208),USE(?String22:20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('attiecinâmâ nodokïa summa, ja P>S'),AT(260,7917,3490,208),USE(?String60),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,7396,833,156),USE(PP),RIGHT
         STRING('68'),AT(5521,7031,208,156),USE(?String22:21),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,6875,885,156),USE(R57),RIGHT
         STRING('iepriekðçjos taks. periodos atskaitîtâ priekðnodokïa samazinâjums'),AT(990,6875,4375,156), |
             USE(?String46:3),TRN,LEFT
         STRING('iepriekðçjos taks. periodos sam. budþetâ apreíinâtâ nodokïa samazinâjums'),AT(990,6719,4375,156), |
             USE(?String46:2),TRN,LEFT
         STRING('57'),AT(5521,6875,208,156),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,6552,833,156),USE(R66),RIGHT
         STRING('63'),AT(5521,6083,208,156),USE(?String22:14),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais priekðnodoklis par precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,6240,4531,156), |
             USE(?String39:2),LEFT
         STRING(@N-_12.2B),AT(5833,5771,833,156),USE(R61),RIGHT
         STRING('ar PVN 10% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,5365,4792,156), |
             USE(?String31:6)
         STRING(@N-_12.2B),AT(5781,5354,885,156),USE(R56),RIGHT
         STRING('ar PVN 21% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(260,5208,4792,156), |
             USE(?String31:5)
         STRING('70'),AT(5469,7917,260,208),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'),AT(260,7708,4844,208), |
             USE(?String59),LEFT
         STRING('62'),AT(5521,5927,208,156),USE(?String22:13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('61'),AT(5521,5771,208,156),USE(?String22:12),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('60'),AT(5521,5615,208,156),USE(?String22:11),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,5615,833,156),USE(R60),RIGHT
         STRING(@N-_12.2B),AT(5781,4896,885,156),USE(R53),RIGHT
         STRING('55'),AT(5521,5208,208,156),USE(?String22:30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('48'),AT(5521,3771,208,156),USE(?String22:27),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,3771,885,156),USE(R48,,?R48:2),RIGHT
         STRING('-eksportçtâs preces'),AT(427,3917,2458,156),USE(?String29),TRN,LEFT
         STRING('48(1)'),AT(5417,3906,313,156),USE(?String22:9),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,3927,885,156),USE(R481),TRN,RIGHT
         STRING('Neatskaitâmais priekðnodoklis'),AT(260,6552,1771,156),USE(?String46),LEFT
         STRING('65'),AT(5521,6396,208,156),USE(?String22:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,6083,833,156),USE(R63),RIGHT
         STRING('64'),AT(5521,6240,208,156),USE(?String22:15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5833,5927,833,156),USE(R62),RIGHT
         STRING(@N-_12.2B),AT(5781,5052,885,156),USE(R54),RIGHT
         STRING('56'),AT(5521,5365,208,156),USE(?String22:31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 21% apliekamiem darîjumiem'),AT(260,4740,2240,156),USE(?String19:8),LEFT
         STRING('49'),AT(5521,4063,208,156),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,5208,885,156),USE(R55),RIGHT
         STRING('par saòemtajiem pakalpojumiem'),AT(260,5052,2604,156),USE(?String31:4)
         STRING('ar PVN 10% apliekamiem darîjumiem'),AT(260,4896,2969,156),USE(?String19:9),LEFT
         STRING('No ES dalîbvalstîm saòemtâs preces (21%)'),AT(260,4219,2604,156),USE(?String31:2)
         LINE,AT(5729,2448,0,5885),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('50'),AT(5521,4219,208,156),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,4219,885,156),USE(R50),RIGHT
         STRING('46'),AT(5521,3469,208,156),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,3469,885,156),USE(R46),RIGHT
         STRING('-citâs ES dalîbvalstîs uzstâdîtâs vai montçtâs preces'),AT(417,3469,3333,156),USE(?String19:6), |
             LEFT
         STRING(@N-_12.2B),AT(5781,4063,885,156),USE(R49),RIGHT
         STRING('-par sniegtajiem pakalpojumiem'),AT(417,3771,2458,156),USE(?String29:2),LEFT
         STRING('45'),AT(5521,3313,208,156),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5781,3313,885,156),USE(R45),RIGHT
         STRING('44'),AT(5521,3156,208,156),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('-darîjumi, kas veikti brîvostâs un SEZ'),AT(417,3156,2292,156),USE(?String19:5),LEFT
         STRING(@N-_12.2B),AT(5781,2688,885,156),USE(R41),RIGHT
         STRING('42'),AT(5521,2844,208,156),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN (latos)'),AT(260,4552),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('52'),AT(5521,4740,208,156),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('53'),AT(5521,4896,208,156),USE(?String22:28),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('41'),AT(5521,2688,208,156),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 10% apliekamie darîjumi (arî paðpatçriòð)'),AT(260,2844,2969,156),USE(?String19:4), |
             LEFT
         LINE,AT(6719,2448,0,5885),USE(?Line3:4),COLOR(COLOR:Black)
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
! INDEKSS 1 :18%/21%
!         2 :5%/10%
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF VESTURE::USED=0
     CHECKOPEN(VESTURE,1)
  .
  VESTURE::USED+=1
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
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

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF KON_K::Used = 0
    CHECKOPEN(KON_K,1)
  end
  KON_K::Used += 1
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
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
!        M='<'
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
!           XML:LINE=' ?xml version="1.0" encoding="utf-8" ?>'
           XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokPVNv1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
           ADD(OUTFILEXML)
           XML:LINE=' Id>1100322</Id>'  !?
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu PVN maks. Nr').       !vienkârði kontrolei
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods'). !vienkârði kontrolei
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
           XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
           ADD(OUTFILEXML)
           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
           ADD(OUTFILEXML)
           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
           ADD(OUTFILEXML)
           TEX:DUF=GL:ADRESE                                       !max 250
           DO CONVERT_TEX:DUF
           XML:LINE=' NmAdrese>'&CLIP(TEX:DUF)&'</NmAdrese>'
           ADD(OUTFILEXML)
           XML:LINE=' ParskCeturksnis xsi:nil="true" />'           !lauks netiek aizpildîts
           ADD(OUTFILEXML)
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
           XML:LINE=' ParskPusgads xsi:nil="true" />'              !lauks netiek aizpildîts
           ADD(OUTFILEXML)
        .
    .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           CASE GGK:D_K
       !************************ SAMAKSÂTS PVN ********
           OF 'D'                                     ! SAMAKSÂTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! 1-budþetam
               VK_PAR_NR=GGK:PAR_NR
             OF '2'                                   ! 2-PREÈU IMPORTS ~ES
               R61+=GGK:SUMMA
             OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               IF GGK:PVN_PROC=12                     ! PIEÐÛTS 12% ZEMNIEKIEM
                  r65+=GGK:SUMMA
               ELSE
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                     R64+=GGK:SUMMA
                  ELSE
                     R62+=GGK:SUMMA
                  .
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
               R63+=GGK:SUMMA
!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!               R25+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R67+=GGK:SUMMA
             .
       !************************ SAÒEMTS PVN ********
           OF 'K'                                     ! SAÒEMTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! 1-budþetam
             OF '2'                                   ! 2-IMPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
             OF '0'                                   ! SAÒEMTS,REALIZÇJOT VAI D&K ES
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               CASE GGK:PVN_PROC
               OF 18
               OROF 21
!                  PPR[1]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'    ! PRECES NO ES
                     Q:U_NR=GGK:U_NR
                     GET(Q_TABLE,Q:U_NR)
                     IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
                        Q:PVN[1]+=GGK:SUMMA
                        PUT(Q_TABLE)
                     ELSE        !ANALÎTISKI
                        SOURCE_FOR_50+=GGK:SUMMA
                     .
                     R55+=GGK:SUMMA
                  ELSE
                     K:U_NR=GGK:U_NR
                     GET(K_TABLE,K:U_NR)
                     IF ~ERROR() !KASES D261..IR JÂBÛT ATRASTAM, JA TÂDS IR
                        IF GGK:PVN_PROC=18
                           K:PVN[1]+=GGK:SUMMA
                        ELSE !21
                           K:PVN[2]+=GGK:SUMMA
                        .
                        PUT(K_TABLE)
                     ELSE        !ANALÎTISKI
                        IF GGK:PVN_PROC=18
                           SOURCE_FOR_41[1]+=GGK:SUMMA
                        ELSE !21
                           SOURCE_FOR_41[2]+=GGK:SUMMA
                        .
                     .
                     R52+=GGK:SUMMA
                  .
               OF 5
               OROF 10
!                  PPR[2]=GGK:PVN_PROC
                  IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                     Q:U_NR=GGK:U_NR
                     GET(Q_TABLE,Q:U_NR)
                     IF ~ERROR() !D213.. IR JÂBÛT ATRASTIEM, JA TÂDI IR
                        Q:PVN[2]+=GGK:SUMMA
                        PUT(Q_TABLE)
                     ELSE        !ANALÎTISKI
                        SOURCE_FOR_51+=GGK:SUMMA
                     .
                     R56+=GGK:SUMMA
                  ELSE
                     K:U_NR=GGK:U_NR
                     GET(K_TABLE,K:U_NR)
                     IF ~ERROR() !KASES D261..IR JÂBÛT ATRASTAM, JA TÂDS IR
                        IF GGK:PVN_PROC=5
                           K:PVN[3]+=GGK:SUMMA
                        ELSE !10
                           K:PVN[4]+=GGK:SUMMA
                        .
                        PUT(K_TABLE)
                     ELSE        !ANALÎTISKI
                        IF GGK:PVN_PROC=5
                           SOURCE_FOR_42[1]+=GGK:SUMMA
                        ELSE !10
                           SOURCE_FOR_42[2]+=GGK:SUMMA
                        .
                     .
                     R53+=GGK:SUMMA
                  .
               ELSE
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                  SOURCE_FOR_41[2]+=GGK:SUMMA   ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 21%
                  R52+=GGK:SUMMA
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
               R54+=GGK:SUMMA
!             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
!               R11+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R57+=GGK:SUMMA
             .
           .
      !************************ 0% un Neapliekamie darîjumi ********
        ELSIF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)) AND GGK:D_K='K' !IR DEFINÇTI NEAPL. DARÎJUMI
           LOOP R#=1 TO 2
              IF KON:PVND[R#]
                 CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                 OF 43
                    R43 += GGK:SUMMA
                 OF 44                    
                    R44 += GGK:SUMMA
                 OF 45
                    R45 += GGK:SUMMA      ! ES PRECES
                 OF 46
                    R46 += GGK:SUMMA
                 OF 47
                    R47 += GGK:SUMMA      ! ES JAUNAS A/M
                 OF 48
                    R48 += GGK:SUMMA
                 OF 481                   ! EXPORTÇTÂS PRECES
                    R481+= GGK:SUMMA
                 OF 49
                    R49 += GGK:SUMMA
                 .
              .
           .
      !************************ MEKLÇJAM PRETKONTUS PRECÇM NO ES ********
        ELSIF GGK:BKK[1:3]='213' AND GGK:D_K='D' AND GETPAR_K(GGK:PAR_NR,0,20)='C' ! ES
        ! GGK:DAT_KEY= DATUMS-U_NR-D/K
           Q:U_NR=GGK:U_NR
           CLEAR(Q:PVN)
           CLEAR(Q:SUMMA)
           GET(Q_TABLE,Q:U_NR)
           IF ERROR()
              DO FILL_Q_TABLE
              ADD(Q_TABLE)
              SORT(Q_TABLE,Q:U_NR)
           ELSE
              DO FILL_Q_TABLE
              PUT(Q_TABLE)
           .
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
              IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10
                 K:SUMMA[2]+=GGK:SUMMA
              ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21
                 K:SUMMA[1]+=GGK:SUMMA
              ELSE
                 KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
                 K:SUMMA[1]+=GGK:SUMMA       ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%(21%)
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
          IF K:SUMMA[1] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
             R41+=K:SUMMA[1]
          ELSE
             SOURCE_FOR_41[1]+=K:PVN[1]
          .
       ELSIF K:PVN[2]                    !IR KASES PVN 21%
          IF K:SUMMA[1] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
             R41+=K:SUMMA[1]
          ELSE
             SOURCE_FOR_41[2]+=K:PVN[2]
          .
       .
       IF K:PVN[3]                       !IR KASES PVN 5%
          IF K:SUMMA[2] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
             R42+=K:SUMMA[2]
          ELSE
             SOURCE_FOR_42[1]+=K:PVN[3]
          .
       ELSIF K:PVN[4]                    !IR KASES PVN 10%
          IF K:SUMMA[2] AND ~K:ANOTHER_K !ATRASTS D261,232.. KONTS,NAV CITU K KONTU BEZ K61...
             R42+=K:SUMMA[2]
          ELSE
             SOURCE_FOR_42[2]+=K:PVN[4]
          .
       .
    .
    R41+=(SOURCE_FOR_41[1]*100)/18   ! ANALÎTISKI 18%
    R41+=(SOURCE_FOR_41[2]*100)/21   ! ANALÎTISKI 21%
    R42+=(SOURCE_FOR_42[1]*100)/5    ! ANALÎTISKI 5%
    R42+=(SOURCE_FOR_42[2]*100)/10   ! ANALÎTISKI 10%
    GET(Q_TABLE,0)

    LOOP I# = 1 TO RECORDS(Q_TABLE)
       GET(Q_TABLE,I#)
       IF Q:PVN[1]                                 !IR 18%/21%
!          stop('pvn='&Q:PVN[1]&' '&Q:SUMMA[1]&'DELTA18='&(Q:SUMMA[1]/100)*18-Q:PVN[1])
          IF INRANGE((Q:SUMMA[1]/100)*18-Q:PVN[1],-0.005,0.005) OR| !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             INRANGE((Q:SUMMA[1]/100)*21-Q:PVN[1],-0.005,0.005)     !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R50+=Q:SUMMA[1]
          ELSE
             SOURCE_FOR_50+=Q:PVN[1]
          .
       .
       IF Q:PVN[2]                                  !IR 5%/10%
!          stop('pvn='&Q:PVN[2]&' DELTA5='&(Q:SUMMA[2]/100)*18-Q:PVN[2])
          IF INRANGE((Q:SUMMA[2]/100)*5-Q:PVN[2],-0.005,0.005) OR| !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             INRANGE((Q:SUMMA[2]/100)*10-Q:PVN[2],-0.005,0.005)    !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R51+=Q:SUMMA[2]
          ELSE
             SOURCE_FOR_51+=Q:PVN[2]
          .
       .
    .
!    R50+=(SOURCE_FOR_50*100)/18               ! ANALÎTISKI 18% ES
!    R51+=(SOURCE_FOR_51*100)/5                ! ANALÎTISKI  5% ES
    R50+=(SOURCE_FOR_50*100)/21               ! ANALÎTISKI 21% ES
    R51+=(SOURCE_FOR_51*100)/10               ! ANALÎTISKI 10% ES

    R40=R41+R42+R43+R49
    NOT1='Ministru kabineta'
    NOT2='2006.gada 10.janvâra'
    NOT3='noteikumiem Nr.42'
!   Inga:Nr 50 no 13.01.2009.
    IF R40=0                                 ! VISPÂR NAV BIJUÐI IEÒÇMUMI
!       PROP=100                              ! PROPORCIJA
       PROP=0                                ! PROPORCIJA
    ELSE
!       PROP=ROUND((R41+R42+R43)/(R41+R42+R43+R49)*100,.01) ! PROPORCIJA
        IF SYS:D_PR='N'
           PROP=0
        ELSE
           PROP=ROUND(R49/R40*100,.01) ! PROPORCIJA
        .
    .
    R60=R61+R62+R63+R64+R65
!    R66=ROUND(R60*(100-PROP)/100,.01)
    R66=ROUND(R60*PROP/100,.01)
    IF MINMAXSUMMA                           !KOKMATERIÂLI
       IF MINMAXSUMMA>0
          R58=MINMAXSUMMA
       ELSE
          R68=ABS(MINMAXSUMMA)
       .
    .
    PP=R60-R66+R67+R68                       !
    SS=R52+R53+R54+R55+R56+R57+R58           !
    IF PP > SS
      R70=PP-SS
      R80=0
    ELSE
      R80=SS-PP
      R70=0
    .
    IF ~(R43=R44+R45+R46+R47+R48+R481)
       KLUDA(0,'Kontu plânâ nepereizi norâdîti rindu kodi (43,44-481)')
    .
    IF R52 AND ~INRANGE(R52/R41*100-21,-0.5,0.5)
       KLUDA(85,R52/R41*100 &'% (jâbût 21%)')
    .
    IF R53 AND ~INRANGE(R53/R42*100-10,-0.5,0.5)
       KLUDA(85,R53/R42*100 &'% (jâbût 10%)')
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
        OUTA:LINE='Ar PVN neapliekamie darîjumi'&CHR(9)&'49'&CHR(9)&FORMAT(R49,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (21%)'&CHR(9)&'50'&CHR(9)&FORMAT(R50,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='No ES dalîbvalstîm saòemtâs preces (10%)'&CHR(9)&'51'&CHR(9)&FORMAT(R51,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='APRÇÍINÂTAIS PVN (latos)'
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 21% apliekamiem darîjumiem'&CHR(9)&'52'&CHR(9)&FORMAT(R52,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 10% apliekamiem darîjumiem'&CHR(9)&'53'&CHR(9)&FORMAT(R53,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='par saòemtajiem pakalpojumiem'&CHR(9)&'54'&CHR(9)&FORMAT(R54,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 21% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'55'&CHR(9)&FORMAT(R55,@N-_12.2B)
        ADD(OUTFILEANSI)
        OUTA:LINE='ar PVN 10% likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'&CHR(9)&'56'&CHR(9)&FORMAT(R56,@N-_12.2B)
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
       LOOP I#=40 TO 68+1+4
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
             RI=R68  !69 RINDA
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
          ELSIF I#<=69
             XML:LINE='<R'&FORMAT(I#-1,@N2)&'>'&CLIP(RI)&'</R'&FORMAT(I#-1,@N2)&'>'
             ADD(OUTFILEXML)
          ELSE
             EXECUTE I#-69
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
          XML:LINE='</Tab2>' !BEIDZAS tabula?
          ADD(OUTFILEXML)
       .
       XML:LINE='</DokPVNv1>' !BEIDZAS DOKUMENTS
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
     IF ~VK_PAR_NR
        clear(ggk:record)
        GGK:BKK=KKK !57210
        SET(GGK:BKK_DAT,GGK:BKK_DAT)
        LOOP
           NEXT(GGK)
           IF ERROR() THEN BREAK.
           IF GGK:PVN_TIPS='1' ! 1-budþetam
              VK_PAR_NR=GGK:PAR_NR
              BREAK
           .
        .
     .
     IF VK_PAR_NR
        CLEAR(VES:RECORD)
        VES:PAR_NR=VK_PAR_NR
        VES:DOK_SENR=FORMAT(S_DAT,@D014.B) !DOKUMANTA Nr
        GET(VESTURE,VES:REF_KEY)
        IF ERROR()
!           KLUDA(0,CLIP(GETPAR_K(VK_PAR_NR,0,1))&' Vçsturç nav atrodams dokuments Nr '&VES:DOK_SENR)
           VES:DOKDAT=B_DAT
           VES:DATUMS=B_DAT   !VAR PADOMÂT
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
              KLU_DARBIBA=1 !NEKO NEDARÎT
              VES:SATURS='PVN Deklarâcija.Precizçtâ'
              IF ~(VES:SUMMA = SS-PP)         !NEKAS NAV JÂPRECIZÇ
                 IF ~(VES:SAMAKSATS = SS-PP)  !NEKAS NAV JÂPRECIZÇ
                    IF VES:SAMAKSATS
                       KLUDA(0,'Vçsturç jau ir fiksçta ðî precizçtâ Dekl. Ls '&VES:SAMAKSATS&|
                       ', aizvietot ar Ls '&SS-PP&' ?',9,1)
                    ELSE
                       KLU_DARBIBA=0
                    .
                 .
              .
              VES:SAMAKSATS = SS-PP
              VES:SAM_DATUMS=TODAY()
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
        KLUDA(0,'Periodâ '&FORMAT(DB_S_DAT,@D06.)&'-'&FORMAT(DB_B_DAT,@D06.)&' nav atrasts neviens PVN maksâjums VK')
     .
  .
  DO ProcedureReturn


!-----------------------------------------------------------------------------
FILL_Q_TABLE ROUTINE
     Q:U_NR=GGK:U_NR
     IF GGK:PVN_PROC=5 OR GGK:PVN_PROC=10
        Q:SUMMA[2]+=GGK:SUMMA
     ELSIF GGK:PVN_PROC=18 OR GGK:PVN_PROC=21
        Q:SUMMA[1]+=GGK:SUMMA
     ELSE
        KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
        Q:SUMMA[1]+=GGK:SUMMA !LIETOTÂJA KÏÛDA, PIEÒEMAM, KA 18%(21%)
     .

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
  FREE(Q_TABLE)
  FREE(K_TABLE)
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    VESTURE::USED-=1
    IF VESTURE::USED=0
       CLOSE(VESTURE)
    .
  END
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
GetArm_k             FUNCTION (ARM,REQ,RET)       ! Declare Procedure
  CODE                                            ! Begin processed code
 !
 !  BKK - PIEPRASÎTAIS KODS
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD, JA NAV
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU
 !  RET - 1 ATGRIEÞ ARM:KODS
 !        2 ATGRIEÞ ARM:NOS_P
 !

 IF ~INRANGE(RET,1,2)
     STOP('GETARM_K:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN('')
 .
 IF ARM OR REQ
    IF ARM_K::USED=0
       CheckOpen(ARM_K,1)
    .
    ARM_K::Used += 1
    CLEAR(ARM:RECORD)
    ARM:KODS=ARM
    GET(ARM_K,ARM:KODS_KEY)
    IF ERROR()
       IF REQ = 2
          KLUDA(15,ARM)
!          ARM=''
       .
    .
    ARM_K::Used -= 1
    IF ARM_K::Used = 0 THEN CLOSE(ARM_K).
 ELSE
    RETURN('')
 .
 EXECUTE RET
    RETURN(ARM)                  !1
    RETURN(ARM:NOS_P)            !2
 .
GETPAM_ADRESE        FUNCTION (U_NR)              ! Declare Procedure
PLAUKTS     STRING(50)
  CODE                                            ! Begin processed code
!
!  ATGRIEÞ PLAUKTU-P/L atraðanâs vieta
!
  IF PAM_P::USED=0
     CHECKOPEN(PAM_P,1)
  .
  PAM_P::USED+=1
  IF U_NR
     CLEAR(PAP:RECORD)
     PAP:U_NR=U_NR
     SET(PAP:NR_KEY,PAP:NR_KEY)
     LOOP
        NEXT(PAM_P)
        IF ERROR() OR ~(PAP:U_NR=U_NR) THEN BREAK.
        IF PLAUKTS
           PLAUKTS=CLIP(PLAUKTS)&','&PAP:VIETA
        ELSE
           PLAUKTS=PAP:VIETA
        .
     .
  ELSE
     CLEAR(PAP:RECORD)
  .
  PAM_P::USED-=1
  IF PAM_P::USED=0
     CLOSE(PAM_P)
  .
  RETURN(PLAUKTS)
