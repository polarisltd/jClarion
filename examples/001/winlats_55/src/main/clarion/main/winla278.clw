                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_DEK_2013       PROCEDURE                    ! Declare Procedure
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
R411         DECIMAL(12,2)   !01.10.2011.
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
R66_Prop     DECIMAL(12,2) !26.05.2015
R67          DECIMAL(12,2)
R57          DECIMAL(12,2)
!R68          DECIMAL(12,2)  !01.10.2011.
!R58          DECIMAL(12,2)  !01.10.2011.

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
PAR_IEKS_DARSUMMA DECIMAL(12,2)
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
RINR            STRING(4)
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
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'),AT(594,2531,3073,208),USE(?String18),LEFT, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('40'),AT(6260,2563,208,156),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,2563,885,156),USE(R40),RIGHT
         STRING('ar standartlikmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,2698,3094,156),USE(?String19), |
             LEFT
         STRING('ar PVN 0% apliekamie darîjumi, t.sk.:'),AT(594,3156,2552,156),USE(?String19:2),LEFT
         STRING('-uz ES dalîbvalstîm piegâdâtâs preces'),AT(750,3469,2448,156),USE(?String19:3),LEFT
         STRING('43'),AT(6260,3156,208,156),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3000,885,156),USE(R42),RIGHT
         STRING(@N-_12.2B),AT(6656,3156,885,156),USE(R43),RIGHT
         STRING(@N-_12.2B),AT(6656,3313,885,156),USE(R44),RIGHT
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
         STRING('Ar PVN neapliekamie darîjumi'),AT(594,4365,1823,156),USE(?String31:7)
         STRING('47'),AT(6260,3771,208,156),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3781,885,156),USE(R47),RIGHT
         STRING('-uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'),AT(750,3771,3333,156),USE(?String19:7), |
             LEFT
         STRING('PRIEKÐNODOKLIS (latos), no tâ :'),AT(594,5927,2292,156),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,5052,885,156),USE(R52),RIGHT
         STRING('54'),AT(6260,5365,208,156),USE(?String22:29),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('51'),AT(6260,4688,208,156),USE(?String22:10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4688,885,156),USE(R51),RIGHT
         STRING('No ES dalîbvalstîm saòemtâs preces (samazinâtâ likme)'),AT(594,4688,4208,156),USE(?String31:3)
         STRING('par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'),AT(594,6083,3958,156), |
             USE(?String37),LEFT
         STRING('par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'),AT(594,6240,4740,156), |
             USE(?String38),LEFT
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu (izòemot 64.rindu)'),AT(594,6396,5177,156), |
             USE(?String39),LEFT
         STRING('lauksaimniekiem izmaksâtâ  kompensâcija'),AT(594,6708,3438,156),USE(?String40)
         STRING(@N-_12.2B),AT(6708,6552,833,156),USE(R64),RIGHT
         STRING('66'),AT(6260,6865,208,156),USE(?String22:17),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,7031,833,156),USE(R67),RIGHT
         STRING(@N-_12.2B),AT(6708,6708,833,156),USE(R65),RIGHT
         STRING('[P]'),AT(6260,7396,167,156),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('67'),AT(6260,7031,208,156),USE(?String22:18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas:'),AT(594,7083,729,156),USE(?String46:4),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING('KOPSUMMA:'),AT(594,7438),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitâmais priekðnodoklis'),AT(2000,7396,1719,156),USE(?String46:8),TRN,LEFT
         STRING('[S]'),AT(6260,7552,167,156),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais nodoklis'),AT(2000,7552,1719,156),USE(?String46:9),TRN,LEFT
         STRING(@N-_12.2B),AT(6656,7552,885,156),USE(SS),RIGHT
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
         STRING(@N-_12.2B),AT(6656,7188,885,156),USE(R57),RIGHT
         STRING('iepriekðçjos taks. periodos atskaitîtâ priekðnodokïa samazinâjums'),AT(1323,7188,4375,156), |
             USE(?String46:3),TRN,LEFT
         STRING('iepriekðçjos taks. periodos sam. budþetâ apreíinâtâ nodokïa samazinâjums'),AT(1323,7031,4375,156), |
             USE(?String46:2),TRN,LEFT
         STRING('57'),AT(6260,7188,208,156),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6865,833,156),USE(R66),RIGHT
         STRING('63'),AT(6260,6396,208,156),USE(?String22:14),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais priekðnodoklis par precçm un pakalpojumiem, kas saòemti no ES dalîb' &|
             'valstîm'),AT(594,6552,5458,156),USE(?String39:2),LEFT
         STRING(@N-_12.2B),AT(6708,6083,833,156),USE(R61),RIGHT
         STRING('ar samazinâto likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(594,5677,4792,156), |
             USE(?String31:6)
         STRING(@N-_12.2B),AT(6656,5667,885,156),USE(R56),RIGHT
         STRING('ar standartlikmi  apliekamâm precçm un pakalpojumiem, kas saòemtas no ES dalîbva' &|
             'lstîm'),AT(594,5521,5333,156),USE(?String31:5)
         STRING('70'),AT(6208,7917,260,208),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'),AT(594,7708,4844,208), |
             USE(?String59),LEFT
         STRING('62'),AT(6260,6240,208,156),USE(?String22:13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('61'),AT(6260,6083,208,156),USE(?String22:12),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('60'),AT(6260,5927,208,156),USE(?String22:11),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,5927,833,156),USE(R60),RIGHT
         STRING(@N-_12.2B),AT(6656,5208,885,156),USE(R53),RIGHT
         STRING('55'),AT(6260,5521,208,156),USE(?String22:30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('48'),AT(6260,3917,208,156),USE(?String22:27),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3927,885,156),USE(R48,,?R48:2),RIGHT
         STRING('-eksportçtâs preces'),AT(750,4063,2458,156),USE(?String29),TRN,LEFT
         STRING('48(1)'),AT(6156,4063,313,156),USE(?String22:9),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4083,885,156),USE(R481),TRN,RIGHT
         STRING(@N-_12.2B),AT(6656,4229,885,156),USE(R482),TRN,RIGHT
         STRING('Citâs valstîs veiktie darîjumi'),AT(594,4219,1823,156),USE(?String31),TRN
         STRING('48(2)'),AT(6156,4219,313,156),USE(?String22:32),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Neatskaitâmais priekðnodoklis'),AT(594,6865,1771,156),USE(?String46),LEFT
         STRING('65'),AT(6260,6708,208,156),USE(?String22:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6385,833,156),USE(R63),RIGHT
         STRING('64'),AT(6260,6552,208,156),USE(?String22:15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6240,833,156),USE(R62),RIGHT
         STRING(@N-_12.2B),AT(6656,5365,885,156),USE(R54),RIGHT
         STRING('56'),AT(6260,5677,208,156),USE(?String22:31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar standartlikmi apliekamiem darîjumiem'),AT(594,5052,2240,156),USE(?String19:8),LEFT
         STRING('49'),AT(6260,4375,208,156),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,5521,885,156),USE(R55),RIGHT
         STRING('par saòemtajiem pakalpojumiem'),AT(594,5365,2604,156),USE(?String31:4)
         STRING('ar samazinâto likmi apliekamiem darîjumiem'),AT(594,5198,2969,156),USE(?String19:9), |
             LEFT
         STRING('No ES dalîbvalstîm saòemtâs preces un pakalpojumi (standartlikme)'),AT(604,4531,4188,156), |
             USE(?String31:2)
         STRING('50'),AT(6260,4531,208,156),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4531,885,156),USE(R50),RIGHT
         STRING('46'),AT(6260,3625,208,156),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3625,885,156),USE(R46),RIGHT
         STRING('ârpuskopienas preèu piegâdes muitas noliktavâs un brîvajâs zonâs'),AT(750,3625,4510,156), |
             USE(?String19:6),LEFT
         STRING(@N-_12.2B),AT(6656,4375,885,156),USE(R49),RIGHT
         STRING('-par sniegtajiem pakalpojumiem'),AT(750,3917,2458,156),USE(?String29:2),LEFT
         STRING('45'),AT(6260,3469,208,156),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3469,885,156),USE(R45),RIGHT
         STRING('44'),AT(6260,3313,208,156),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('-darîjumi, kas veikti brîvostâs un SEZ'),AT(750,3313,2292,156),USE(?String19:5),LEFT
         STRING(@N-_12.2B),AT(6656,2698,885,156),USE(R41),RIGHT
         STRING('42'),AT(6260,3000,208,156),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN (latos)'),AT(594,4865),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('52'),AT(6260,5042,208,156),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('53'),AT(6260,5208,208,156),USE(?String22:28),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('41'),AT(6260,2698,208,156),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar samazinâto likmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,3000,3479,156),USE(?String19:4), |
             LEFT
         STRING('Iekðzemç veiktie darîjumi, par kuriem nodokli maksâ preèu vai pakalpojumu saòçmç' &|
             'js'),AT(604,2854,5375,156),USE(?String19:10),TRN,LEFT
         STRING('41(1)'),AT(6156,2854,313,156),USE(?String22:21),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6667,2854,885,156),USE(R411),TRN,RIGHT
       END
detail2012 DETAIL,AT(-10,10,8000,11250),USE(?unnamed:2)
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
         LINE,AT(6115,2281,0,6052),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(6521,2281,0,6052),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(7760,1354,0,6979),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Tâlrunis:'),AT(521,2052),USE(?String10:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s15),AT(1094,2052,1198,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2281,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA (latos), no tâs'),AT(594,2531,3073,208),USE(?String18),LEFT, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('40'),AT(6260,2563,208,156),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,2563,885,156),USE(R40),RIGHT
         STRING('ar standartlikmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,2698,3094,156),USE(?String19), |
             LEFT
         STRING('ar PVN 0% apliekamie darîjumi, t.sk.:'),AT(594,3156,2552,156),USE(?String19:2),LEFT
         STRING('-uz ES dalîbvalstîm piegâdâtâs preces'),AT(750,3469,2448,156),USE(?String19:3),LEFT
         STRING('43'),AT(6260,3156,208,156),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3000,885,156),USE(R42),RIGHT
         STRING(@N-_12.2B),AT(6656,3156,885,156),USE(R43),RIGHT
         STRING(@N-_12.2B),AT(6656,3313,885,156),USE(R44),RIGHT
         LINE,AT(208,8333,7552,0),USE(?Line11:4),COLOR(COLOR:Black)
         STRING('Informâcija par pârmaksâto PVN summu par iekðzemç veiktiem darîjumiem'),AT(833,8344,6448,188), |
             USE(?String303),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kuriem nodokli maksâ preèu vai pakalpojumu saòçmçjs'),AT(1385,8500,5188,188),USE(?String304), |
             TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârmaksâtâ PVN summa, kas pârsniedz 1 000 latu un ir izveidojusies par iekðzemç ' &|
             'veiktiem '),AT(406,8719,5688,208),USE(?String59:7),TRN,LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6719,8781,833,156),USE(PAR_IEKS_DARSUMMA),TRN,RIGHT
         STRING('Pârskaitît PVN pârmaksas summu'),AT(938,9271,2083,208),USE(?String59:4),TRN,LEFT
         STRING(@N-_12.2B),AT(4271,9323,833,156),USE(ParmaksUzKontuSumma),TRN,RIGHT
         STRING(@s21),AT(5583,9313,1719,208),USE(IbanNumurs),TRN,CENTER
         LINE,AT(365,8698,7400,0),USE(?Line11:8),COLOR(COLOR:Black)
         LINE,AT(365,9031,7400,0),USE(?Line11:9),COLOR(COLOR:Black)
         STRING('Ar PVN neapliekamie darîjumi'),AT(594,4365,1823,156),USE(?String31:7)
         STRING('47'),AT(6260,3771,208,156),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3781,885,156),USE(R47),RIGHT
         STRING('-uz ES dalîbvalstîm piegâdâtie jaunie transportlîdzekïi'),AT(750,3771,3333,156),USE(?String19:7), |
             LEFT
         STRING('PRIEKÐNODOKLIS (latos), no tâ :'),AT(594,5927,2292,156),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,5052,885,156),USE(R52),RIGHT
         STRING('54'),AT(6260,5365,208,156),USE(?String22:29),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('51'),AT(6260,4688,208,156),USE(?String22:10),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4688,885,156),USE(R51),RIGHT
         STRING('No ES dalîbvalstîm saòemtâs preces (samazinâtâ likme)'),AT(594,4688,4208,156),USE(?String31:3)
         STRING('par importçtajâm precçm savas saimn. darbîbas nodroðinâðanai'),AT(594,6083,3958,156), |
             USE(?String37),LEFT
         STRING('par precçm un pakalpojumiem iekðzemç savas saimn. darbîbas nodroðinâðanai'),AT(594,6240,4740,156), |
             USE(?String38),LEFT
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu (izòemot 64.rindu)'),AT(594,6396,5177,156), |
             USE(?String39),LEFT
         STRING('lauksaimniekiem izmaksâtâ  kompensâcija'),AT(594,6708,3438,156),USE(?String40)
         STRING(@N-_12.2B),AT(6708,6552,833,156),USE(R64),RIGHT
         STRING('66'),AT(6260,6865,208,156),USE(?String22:17),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,7031,833,156),USE(R67),RIGHT
         STRING(@N-_12.2B),AT(6708,6708,833,156),USE(R65),RIGHT
         STRING('[P]'),AT(6260,7396,167,156),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('67'),AT(6260,7031,208,156),USE(?String22:18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas:'),AT(594,7083,729,156),USE(?String46:4),LEFT,FONT(,9,,FONT:bold,CHARSET:ANSI)
         STRING('KOPSUMMA:'),AT(594,7438),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitâmais priekðnodoklis'),AT(2000,7396,1719,156),USE(?String46:8),TRN,LEFT
         STRING('[S]'),AT(6260,7552,167,156),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais nodoklis'),AT(2000,7552,1719,156),USE(?String46:9),TRN,LEFT
         STRING(@N-_12.2B),AT(6656,7552,885,156),USE(SS),RIGHT
         STRING('APSTIPRINU PIEVIENOTÂS VÇRTÎBAS NODOKÏA APRÇÍINU .'),AT(313,9896),USE(?String63),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,9271,0,313),USE(?Line29:11),COLOR(COLOR:Black)
         LINE,AT(365,8708,0,313),USE(?Line29:16),COLOR(COLOR:Black)
         STRING('darijumiem, par kuriem nodokli maksâ preèu vai pakalpojumu saòçmçjs'),AT(406,8865,5688,208), |
             USE(?String59:9),TRN,LEFT
         LINE,AT(7750,8708,0,313),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(6115,8708,0,313),USE(?Line51),COLOR(COLOR:Black)
         STRING('Atbildîgâ persona :'),AT(313,10208),USE(?String64),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(365,9271,469,0),USE(?Line29:17),COLOR(COLOR:Black)
         STRING(@S1),AT(7604,11042,156,188),USE(RS),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(1979,10885,5729,0),USE(?Line1:18),COLOR(COLOR:Black)
         STRING('R : '),AT(7448,11042,135,188),USE(?String99),FONT(,7,,,CHARSET:ANSI)
         STRING('VID atbildîgâ amatpersona:'),AT(313,10677),USE(?String73),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Konta Nr. (IBAN 21 simbols)'),AT(5552,9542,1875,208),USE(?String59:8),TRN,LEFT
         STRING(@s5),AT(6875,11042),USE(KKK)
         STRING(@s20),AT(4063,10208),USE(SYS:PARAKSTS1,,?SYS:PARAKSTS1:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
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
         STRING('(paraksts un tâ atðifrçjums)'),AT(2292,10469,1646,198),USE(?String67:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(3594,9271,4167,0),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@d06.),AT(5677,10208),USE(datums),FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(1510,10417,2448,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(2448,10938),USE(?String67),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Pieprasîjums par pievienotâs vçrtîbas nodokïa pârmaksas atmaksu'),AT(2240,9073),USE(?String63:3), |
             TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('(datums)'),AT(5729,10938,531,198),USE(?String68:2),TRN,LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Budþetâ maksâjamâ nodokïa summa, ja P<<S'),AT(594,8125),USE(?String59:3),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,8125,885,208),USE(R80),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,7917,885,208),USE(R70),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('80'),AT(6208,8125,260,208),USE(?String22:20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('attiecinâmâ nodokïa summa, ja P>S'),AT(594,7917,3490,208),USE(?String60),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,7396,833,156),USE(PP),RIGHT
         STRING(@N-_12.2B),AT(6656,7188,885,156),USE(R57),RIGHT
         STRING('iepriekðçjos taks. periodos atskaitîtâ priekðnodokïa samazinâjums'),AT(1323,7188,4375,156), |
             USE(?String46:3),TRN,LEFT
         STRING('iepriekðçjos taks. periodos sam. budþetâ apreíinâtâ nodokïa samazinâjums'),AT(1323,7031,4375,156), |
             USE(?String46:2),TRN,LEFT
         STRING('57'),AT(6260,7188,208,156),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6865,833,156),USE(R66),RIGHT
         STRING('63'),AT(6260,6396,208,156),USE(?String22:14),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíinâtais priekðnodoklis par precçm un pakalpojumiem, kas saòemti no ES dalîb' &|
             'valstîm'),AT(594,6552,5458,156),USE(?String39:2),LEFT
         STRING(@N-_12.2B),AT(6708,6083,833,156),USE(R61),RIGHT
         STRING('ar samazinâto likmi apliekamâm precçm, kas saòemtas no ES dalîbvalstîm'),AT(594,5677,4792,156), |
             USE(?String31:6)
         STRING(@N-_12.2B),AT(6656,5667,885,156),USE(R56),RIGHT
         STRING('ar standartlikmi  apliekamâm precçm un pakalpojumiem, kas saòemtas no ES dalîbva' &|
             'lstîm'),AT(594,5521,5333,156),USE(?String31:5)
         STRING('70'),AT(6208,7917,260,208),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo taksâcijas periodu'),AT(594,7708,4844,208), |
             USE(?String59),LEFT
         STRING('62'),AT(6260,6240,208,156),USE(?String22:13),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('61'),AT(6260,6083,208,156),USE(?String22:12),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('60'),AT(6260,5927,208,156),USE(?String22:11),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,5927,833,156),USE(R60),RIGHT
         STRING(@N-_12.2B),AT(6656,5208,885,156),USE(R53),RIGHT
         STRING('55'),AT(6260,5521,208,156),USE(?String22:30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('48'),AT(6260,3917,208,156),USE(?String22:27),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3927,885,156),USE(R48,,?R48:2),RIGHT
         STRING('-eksportçtâs preces'),AT(750,4063,2458,156),USE(?String29),TRN,LEFT
         STRING('48(1)'),AT(6156,4063,313,156),USE(?String22:9),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4083,885,156),USE(R481),TRN,RIGHT
         STRING(@N-_12.2B),AT(6656,4229,885,156),USE(R482),TRN,RIGHT
         STRING('Citâs valstîs veiktie darîjumi'),AT(594,4219,1823,156),USE(?String31),TRN
         STRING('48(2)'),AT(6156,4219,313,156),USE(?String22:32),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Neatskaitâmais priekðnodoklis'),AT(594,6865,1771,156),USE(?String46),LEFT
         STRING('65'),AT(6260,6708,208,156),USE(?String22:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6385,833,156),USE(R63),RIGHT
         STRING('64'),AT(6260,6552,208,156),USE(?String22:15),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6708,6240,833,156),USE(R62),RIGHT
         STRING(@N-_12.2B),AT(6656,5365,885,156),USE(R54),RIGHT
         STRING('56'),AT(6260,5677,208,156),USE(?String22:31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar standartlikmi apliekamiem darîjumiem'),AT(594,5052,2240,156),USE(?String19:8),LEFT
         STRING('49'),AT(6260,4375,208,156),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,5521,885,156),USE(R55),RIGHT
         STRING('par saòemtajiem pakalpojumiem'),AT(594,5365,2604,156),USE(?String31:4)
         STRING('ar samazinâto likmi apliekamiem darîjumiem'),AT(594,5198,2969,156),USE(?String19:9), |
             LEFT
         STRING('No ES dalîbvalstîm saòemtâs preces un pakalpojumi (standartlikme)'),AT(604,4531,4188,156), |
             USE(?String31:2)
         STRING('50'),AT(6260,4531,208,156),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,4531,885,156),USE(R50),RIGHT
         STRING('46'),AT(6260,3625,208,156),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3625,885,156),USE(R46),RIGHT
         STRING('ârpuskopienas preèu piegâdes muitas noliktavâs un brîvajâs zonâs'),AT(750,3625,4510,156), |
             USE(?String19:6),LEFT
         STRING(@N-_12.2B),AT(6656,4375,885,156),USE(R49),RIGHT
         STRING('-par sniegtajiem pakalpojumiem'),AT(750,3917,2458,156),USE(?String29:3),LEFT
         STRING('45'),AT(6260,3469,208,156),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6656,3469,885,156),USE(R45),RIGHT
         STRING('44'),AT(6260,3313,208,156),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('-darîjumi, kas veikti brîvostâs un SEZ'),AT(750,3313,2292,156),USE(?String19:5),LEFT
         STRING(@N-_12.2B),AT(6656,2698,885,156),USE(R41),RIGHT
         STRING('42'),AT(6260,3000,208,156),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN (latos)'),AT(594,4865),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('52'),AT(6260,5042,208,156),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('53'),AT(6260,5208,208,156),USE(?String22:28),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('41'),AT(6260,2698,208,156),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar samazinâto likmi apliekamie darîjumi (arî paðpatçriòð)'),AT(594,3000,3479,156),USE(?String19:4), |
             LEFT
         STRING('Iekðzemç veiktie darîjumi, par kuriem nodokli maksâ preèu vai pakalpojumu saòçmç' &|
             'js'),AT(604,2854,5375,156),USE(?String19:10),TRN,LEFT
         STRING('41(1)'),AT(6156,2854,313,156),USE(?String22:21),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6667,2854,885,156),USE(R411),TRN,RIGHT
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

PVNA02Window WINDOW('PVN-A-02'),AT(,,369,104),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Novirzît PVN pârmaksas summu citu maks. veikðanai   Kods      Summa         Budþ' &|
           '.konta pçd.7 cipari'),AT(3,8,347,10),USE(?String1A01)
       ENTRY(@n1B),AT(183,19,11,10),USE(NODOKLKODS[1],,?NODOKLKODS1W),IMM
       ENTRY(@N10.2B),AT(206,19,48,10),USE(NOVIRZSUMMA[1],,?NOVIRZSUMMA1W),IMM,RIGHT
       ENTRY(@s7),AT(264,19,37,10),USE(KONTANR[1],,?KONTANR1W)
       STRING('Pârmaksâtâ PVN summa, kas pârsniedz 1 000 Eur un ir izveidojusies par iekð.'),AT(3,33,259,10), |
           USE(?String4)
       ENTRY(@N10.2B),AT(264,37,48,10),USE(PAR_IEKS_DARSUMMA),IMM,RIGHT
       STRING('darîjumiem, par kuriem nodokli maksâ preèu vai pakalpojumu saòçmçjs'),AT(3,43,251,10), |
           USE(?String5)
       STRING('Kodi: 1-VSAOI; 2-IIN; 3-UIN; 4-Dabas resursu nod.; 5-Nodokïi atsev.precçm un pak' &|
           'alpojumiem; 7-Muita; 8-Citi'),AT(3,60),USE(?String3W),FONT(,,COLOR:Gray,,CHARSET:ANSI)
       STRING('Pârskaitît PVN pârmaksas summu uz norçíinu kontu (IBAN)'),AT(3,73),USE(?String2)
       ENTRY(@N10.2B),AT(206,73,48,10),USE(ParmaksUzKontuSumma,,?ParmaksUzKontuSummaW),IMM,RIGHT
       ENTRY(@s21),AT(261,73,97,10),USE(IbanNumurs,,?IbanNumursW),UPR
       BUTTON('OK'),AT(325,86,35,14),USE(?OK:PVNA02),DEFAULT
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
           XML:LINE=' DokPVNv4 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
           ADD(OUTFILEXML)
!           XML:LINE=' Id>1100322</Id>'  !?
!           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu PVN maks. Nr').       !vienkârði kontrolei
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
!           XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
!           ADD(OUTFILEXML)
!          XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
!           ADD(OUTFILEXML)
           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
           ADD(OUTFILEXML)
!           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
!           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.),,1). !vienkârði kontrolei
           XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
           ADD(OUTFILEXML)
           IF INRANGE(B_DAT-S_DAT,32,100)
              ceturksnis=MONTH(B_DAT)/3
              XML:LINE=' ParskCeturksnis>'&ceturksnis&'</ParskCeturksnis>'
           ELSIF INRANGE(B_DAT-S_DAT,180,200)
              pusgads=MONTH(B_DAT)/6
              !17/07/2013 < XML:LINE=' ParskPusgads>'&pusgads&'</ParskPusgads>'
              IF S_DAT >= DATE(1,1,2013)
                XML:LINE=' TaksPusgads>'&pusgads&'</TaksPusgads>'
              ELSE
                XML:LINE=' ParskPusgads>'&pusgads&'</ParskPusgads>'
              .
              !17/07/2013 >
          ELSE
              XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
           .
           ADD(OUTFILEXML)
!           XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
!           ADD(OUTFILEXML)
!           TEX:DUF=GL:ADRESE                                       !max 250
!           DO CONVERT_TEX:DUF
!           XML:LINE=' NmAdrese>'&CLIP(TEX:DUF)&'</NmAdrese>'
!           ADD(OUTFILEXML)
!           XML:LINE=' ParskCeturksnis xsi:nil="true" />'           !lauks netiek aizpildîts
!           ADD(OUTFILEXML)
!           XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
!           ADD(OUTFILEXML)
!           IF NovirzSumma[1] OR NovirzSumma[2]                     !PVN PÂRMAKSA TIKS NOVIRZÎTA CITA NOD. ATMAKSAI
!!              XML:LINE=' ParmaksNovirze>1</ParmaksNovirze>'        !TURPINÂJUMS VISAM ÐITAM IR PAÐÂS BEIGÂS <TAB2>
!              XML:LINE=' ParmaksUzKontu>1</ParmaksUzKontu>'        !TURPINÂJUMS VISAM ÐITAM IR PAÐÂS BEIGÂS <TAB2>
!              ADD(OUTFILEXML)
!           .
           IF ParmaksUzKontuSumma AND IbanNumurs                   !PVN PÂRMAKSU UZ NM IBAN-u
              XML:LINE=' ParmaksUzKontu>1</ParmaksUzKontu>'
              ADD(OUTFILEXML)
              XML:LINE=' ParmaksUzKontuSumma>'&CLIP(ParmaksUzKontuSumma)&'</ParmaksUzKontuSumma>'
              ADD(OUTFILEXML)
              XML:LINE=' IbanNumurs>'&IbanNumurs&'</IbanNumurs>'
              ADD(OUTFILEXML)
           .
!           STOP (''&S_DAT&' '&DATE(1,1,2012)&' '&PAR_IEKS_DARSUMMA)
           IF S_DAT >= DATE(1,1,2012) And  PAR_IEKS_DARSUMMA > 0
              XML:LINE=' SummaParm>'&CLIP(PAR_IEKS_DARSUMMA)&'</SummaParm>'
              ADD(OUTFILEXML)
           .
!?           XML:LINE=' ParskPusgads xsi:nil="true" />'              !lauks netiek aizpildîts
!           ADD(OUTFILEXML)
        .
    .
     OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
      ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)

!        STOP ('konts '&GGK:BKK[1:5]&'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' debitKredit'&GGK:D_K&' SUM'&GGK:SUMMA)

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
             OF '4'                                   ! nodokli maksa sanemejs (koki,metal.,buvnieciba)
             OROF '3'
             OROF '8'                                 !
             OROF 'K'
             OROF 'M'                                 !
             OROF 'B'
                      R62+=GGK:SUMMA                   ! LV

             ! 26.05.2015 <
             OF 'E'                                   ! 26.05.2015 prieksnodoklia nEapliekamai realizaciji un Proporcijas aprekinam
             OROF 'R'
                  R62+=GGK:SUMMA                   ! LV
                  IF GGK:PVN_TIPS = 'E'
                     R66+=GGK:SUMMA
                  ELSE
                     R66_Prop+=GGK:SUMMA
                  .
             ! 26.05.2015 >

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
             OF '4'                                   ! nodokli maksa sanemejs (koki,metal.,buvnieciba)
             OROF '3'
             OROF '8'                                 !
             OROF 'K'
             OROF 'M'                                 !
             OROF 'B'
               R52+=GGK:SUMMA                   ! LV
!               STOP(GGK:U_NR&' '&GGK:PAR_NR&' '&GGK:SUMMA)
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
                 OF 411
                    R411+= GGK:SUMMA      ! MAKSÂ LATVIJAS PREÈU/PAK SAÒÇMÇJS
                 OF 43
                    R43 += GGK:SUMMA      ! 0% KOPÂ
                 OF 44                    
                    R44 += GGK:SUMMA      ! SEZ
                 OF 45
                    R45 += GGK:SUMMA      ! ES PRECES
                 OF 458
                    R45 += GGK:SUMMA      ! ES PRECES
                 OF 450
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
     !************************ 0% un Neapliekamie darîjumi,~PVN KONTS ********
       ! 19/07/2012 ELSIF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)) AND GGK:D_K='D' !IR DEFINÇTI NEAPL. DARÎJUMI(ATGREISANAS)
       ELSIF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)) AND GGK:D_K='D' AND (GGK:BKK[1:2]='57' OR ~GGK:BKK[1]='5') !IR DEFINÇTI NEAPL. DARÎJUMI(ATGREISANAS)
!           stop('**'&GGK:BKK&' '&GGK:SUMMA&' '&GGK:PVN_TIPS)
           LOOP R#=1 TO 2
              IF KON:PVND[R#]
                 CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                 OF 411
                    R411+= -GGK:SUMMA      ! MAKSÂ LATVIJAS PREÈU/PAK SAÒÇMÇJS
                 OF 43
                    R43 += -GGK:SUMMA      ! 0% KOPÂ
                 OF 44                    
                    R44 += -GGK:SUMMA      ! SEZ
                 OF 45
                    R45 += -GGK:SUMMA      ! ES PRECES
                 OF 46
                    R46 += -GGK:SUMMA      ! ES DARBI PRECÇM
                 OF 47
                    R47 += -GGK:SUMMA      ! ES JAUNAS A/M
                 OF 48
                    R48 += -GGK:SUMMA      ! 0% PAKALPOJUMI
                 OF 481                   
                    R481+= -GGK:SUMMA      ! EXPORTÇTÂS PRECES
                 OF 482                   
                    R482+= -GGK:SUMMA      ! EXPORTÇTIE PAKALPOJUMI?
                 OF 49
                    R49 += -GGK:SUMMA      ! PVN NEAPLIEKAMIE
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
!       !************************ REALIZÂCIJA 41.1 R1, R2, R3 ********
!       !******Elya konts nav neapliek. un nav PVN konts, parbaudim tipi ja PVN = 0
!        ELSIF CYCLEBKK(GGK:BKK,KKK) AND INRANGE(GGK:BKK[1:2],'59','99') AND GGK:D_K='K' AND GGK:PVN_PROC = 0 AND (GGK:PVN_TIPS = 'K' OR GGK:PVN_TIPS = 'M' OR GGK:PVN_TIPS = 'B')
!           R411+= GGK:SUMMA      ! MAKSÂ LATVIJAS PREÈU/PAK SAÒÇMÇJS
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
      END !BEIDZAS LOOP RPCT
      IF LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
      END
    END !BEIDZAS CASE EVENT
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
!Elya    R40=R41+R42+R43+R482+R49                 ! 13.04.2011 R481 jau ir R43-Inga
    R40=R41+R411+R42+R43+R482+R49           ! 08.04.2011

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
    !26/05/2015 R66=ROUND(R60*PROP,.01)
    R66+=ROUND(R66_Prop*PROP,.01)  !26/05/2015
!    IF MINMAXSUMMA                     ! 01.10.2011      !KOKMATERIÂLI
!       IF MINMAXSUMMA>0                ! 01.10.2011
!          R58=MINMAXSUMMA              ! 01.10.2011
!       ELSE                            ! 01.10.2011
!          R68=ABS(MINMAXSUMMA)         ! 01.10.2011
!       .                               ! 01.10.2011
!    .                                  ! 01.10.2011
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
!    IF R52 AND ~INRANGE(R52/R41*100-22,-0.5,0.5)
!       KLUDA(85,R52/R41*100 &'% (jâbût 22%)')
!    .
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
        !PRINT(RPT:DETAIL)
        IF S_DAT >= DATE(1,1,2012)
          PRINT(RPT:DETAIL2012)
        ELSE
          PRINT(RPT:DETAIL)
        END
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
!        OUTA:LINE='Saskaòâ ar likuma 13.2.p: atskaitâmais priekðnodoklis'&CHR(9)&'68'&CHR(9)&FORMAT(R68,@N-_12.2B)
!        ADD(OUTFILEANSI)
!        OUTA:LINE='Saskaòâ ar likuma 13.2.p: aprçíinâtais nodoklis'&CHR(9)&'58'&CHR(9)&FORMAT(R58,@N-_12.2B)
!        ADD(OUTFILEANSI)
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
       XML:LINE='<PVN>' !nâkoðâ sadaïa
       ADD(OUTFILEXML)
       LOOP I#=1 TO 33
          EXECUTE I#
             RI=R40
             RI=R41
             RI=R411
             RI=R42
             RI=R43
             RI=R44
             RI=R45
             RI=R46
             RI=R47
             RI=R48   !10
             RI=R481
             RI=R482
             RI=R49
             RI=R50
             RI=R51
             RI=R52
             RI=R53
             RI=R54
             RI=R55
             RI=R56   !20
             RI=R60
             RI=R61
             RI=R62
             RI=R63
             RI=R64
             RI=R65
             RI=R66
             RI=R67
             RI=R57
             RI=PP    !30
             RI=SS
             RI=R70
             RI=R80
          .
          IF ~RI THEN CYCLE.
          EXECUTE I#
             RINR='40'
             RINR='41'
             RINR='411'
             RINR='42'
             RINR='43'
             RINR='44'
             RINR='45'
             RINR='46'
             RINR='47'
             RINR='48'   !10
             RINR='481'
             RINR='482'
             RINR='49'
             RINR='50'
             RINR='51'
             RINR='52'
             RINR='53'
             RINR='54'
             RINR='55'
             RINR='56'   !20
             RINR='60'
             RINR='61'
             RINR='62'
             RINR='63'
             RINR='64'
             RINR='65'
             RINR='66'
             RINR='67'
             RINR='57'
             RINR='P'     !30
             RINR='S'     !31
             RINR='70'
             RINR='80'
          .
!          IF I#=30 OR I#=31
!             XML:LINE='<'&CLIP(RINR)&'>'&CLIP(RI)&'</'&CLIP(RINR)&'>'
!          ELSE
!             XML:LINE='<R'&CLIP(RINR)&'>'&CLIP(RI)&'</R'&CLIP(RINR)&'>'
!!             STOP('R'&CLIP(RINR)&' '&CLIP(RI))
!          .
!          ADD(OUTFILEXML)
          IF I#=1 OR I#=6 OR I#=21 OR I#=30 OR I#=31 OR I#=32 OR I#=33
          ELSE
             XML:LINE='<R'&CLIP(RINR)&'>'&CLIP(RI)&'</R'&CLIP(RINR)&'>'
             ADD(OUTFILEXML)
          .


       .


!OMIT('MARIS')
!          IF I#<=48
!             XML:LINE='<R'&FORMAT(I#,@N2)&'>'&CLIP(RI)&'</R'&FORMAT(I#,@N2)&'>'
!             ADD(OUTFILEXML)
!          ELSIF I#=49
!             XML:LINE='<R48_1>'&CLIP(RI)&'</R48_1>'
!             ADD(OUTFILEXML)
!          ELSIF I#=50
!             XML:LINE='<R48_2>'&CLIP(RI)&'</R48_2>'
!             ADD(OUTFILEXML)
!          ELSIF I#<=70
!             XML:LINE='<R'&FORMAT(I#-2,@N2)&'>'&CLIP(RI)&'</R'&FORMAT(I#-2,@N2)&'>'
!             ADD(OUTFILEXML)
!          ELSE
!             EXECUTE I#-70
!                XML:LINE='<P>'&CLIP(RI)&'</P>'
!                XML:LINE='<S>'&CLIP(RI)&'</S>'
!                XML:LINE='<R70>'&CLIP(RI)&'</R70>'
!                XML:LINE='<R80>'&CLIP(RI)&'</R80>'
!             .
!             ADD(OUTFILEXML)
!          .
!MARIS


       XML:LINE='</PVN>' !beidzas ðitâ sadaïa
       ADD(OUTFILEXML)

!
!      SADAÏAS PVN5,PVN7,TAB3
!
!       IF NOVIRZSUMMA[1] OR NOVIRZSUMMA[2] !KAUT KAS TIKS NOVIRZÎTS CITIEM NODOKÏIEM
       IF NOVIRZSUMMA[1] OR NOVIRZSUMMA[2] !KAUT KAS TIKS ATMAKSÂTS
          XML:LINE=' PVN5>' !nâkoðâ tabula
          ADD(OUTFILEXML)
!          LOOP I#=1 TO 2
!             IF NovirzSumma[I#]
!                XML:LINE='<R>'
!                ADD(OUTFILEXML)
!                XML:LINE=' Npk>'&CLIP(I#)&'</Npk>'
!                ADD(OUTFILEXML)
!                XML:LINE=' NodoklKods>'&Nodoklkods[I#]&'</NodoklKods>'
!                ADD(OUTFILEXML)
!                XML:LINE=' NovirzSumma>'&NovirzSumma[I#]&'</NovirzSumma>'
!                ADD(OUTFILEXML)
!                XML:LINE=' KontaNr>'&KontaNr[I#]&'</KontaNr>'
!                ADD(OUTFILEXML)
!                XML:LINE='</R>' !BEIDZAS I# rinda
!                ADD(OUTFILEXML)
!             .
!          .
          XML:LINE=' R1>'&NovirzSumma[1]&'</R1>'
          ADD(OUTFILEXML)
          XML:LINE='</PVN5>' !BEIDZAS tabula
          ADD(OUTFILEXML)
       .
!Elya error - viss iet Tab3
!       IF PVN1_1+PVN1_2+PVN1_3
!          XML:LINE=' PVN7>' !nâkoðâ tabula ???
!          ADD(OUTFILEXML)
!          XML:LINE=' R3_1>'&PVN1_1&'</R3_1>'
!          ADD(OUTFILEXML)
!          XML:LINE=' R3_2>'&PVN1_2&'</R3_2>'
!          ADD(OUTFILEXML)
!          XML:LINE=' R3_3>'&PVN1_3&'</R3_3>'
!          ADD(OUTFILEXML)
!          XML:LINE=' R3_4>'&PVN1_3&'</R3_4>' 
!          ADD(OUTFILEXML)
!       .
!       XML:LINE='</PVN7>' !BEIDZAS tabula
!       ADD(OUTFILEXML)

!       XML:LINE=' Tab3>' !nâkoðâ tabula ! PVND PIELIKUMI-PVN1
!       ADD(OUTFILEXML)
!       XML:LINE=' PVN1_1>'&PVN1_1&'</PVN1_1>'
!       ADD(OUTFILEXML)
!       XML:LINE=' PVN1_2>'&PVN1_2&'</PVN1_2>'
!       ADD(OUTFILEXML)
!       XML:LINE=' PVN1_3>'&PVN1_3&'</PVN1_3>'
!       ADD(OUTFILEXML)                        !PÇC ÐITÂ VAR BÛT VÇL 6 GAB.
!       XML:LINE=' /Tab3>' !beidszas tabula
!       ADD(OUTFILEXML)

 
!       XML:LINE='</DokPVNv3>' !BEIDZAS DOKUMENTS
!       ADD(OUTFILEXML)
       SET(OUTFILEXML)
       PVN# = 0
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR() THEN BREAK.
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
             PVN# = 1
          .
       .
       CLOSE(OUTFILEXML)
       if PVN# = 1
         B_PVN_PIE_2013_XML()
         B_PVN_PIE2_2013_XML()
       .
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
