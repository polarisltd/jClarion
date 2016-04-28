                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_PIEK           PROCEDURE                    ! Declare Procedure
R4                   DECIMAL(12,2)
R41                  DECIMAL(12,2)
R42                  DECIMAL(12,2)
R43                  DECIMAL(12,2)
R44                  DECIMAL(12,2)
R45                  DECIMAL(12,2)
R5                   DECIMAL(12,2)
R51                  DECIMAL(12,2)
R52                  DECIMAL(12,2)
R53                  DECIMAL(12,2)
R54                  DECIMAL(12,2)
R6                   DECIMAL(12,2)
R61                  DECIMAL(12,2)
R62                  DECIMAL(12,2)
R63                  DECIMAL(12,2)
R64                  DECIMAL(12,2)
R65                  DECIMAL(12,2)
R7                   DECIMAL(12,2)
R71                  DECIMAL(12,2)
R72                  DECIMAL(12,2)
R73                  DECIMAL(12,2)
R8                   DECIMAL(12,2)
R9                   DECIMAL(12,2)
R10                  DECIMAL(12,2)
R101                 DECIMAL(12,2)
R102                 DECIMAL(12,2)
R103                 DECIMAL(12,2)
R104                 DECIMAL(12,2)
R105                 DECIMAL(12,2)
R106                 DECIMAL(12,2)
R11                  DECIMAL(12,2)
R111                 DECIMAL(12,2)
R112                 DECIMAL(12,2)
R12                  DECIMAL(12,2)
R13                  DECIMAL(12,2)
R14                  DECIMAL(12,2)
R15                  DECIMAL(12,2)

K31                  REAL
K33                  REAL
K34                  REAL
K54                  REAL
K56                  REAL

RPT_MENESIEM         STRING(8)
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
CG                   STRING(10)
NPK                  DECIMAL(3)

VID_DATUMS           LONG
PAR_NOS_P            STRING(30)
PAR_NOS_PP           STRING(30)
PAR_REGNR            STRING(13)
PAR_LVREGNR          STRING(13)

SUMMA1               DECIMAL(12,2)
SUMMA2               DECIMAL(12,2)
SUMMA3               DECIMAL(12,2)
SUMMA4               DECIMAL(12,2)
SUMMA1K              DECIMAL(12,2)
SUMMA2K              DECIMAL(12,2)
SUMMA3K              DECIMAL(12,2)
SUMMA4K              DECIMAL(12,2)

E                    STRING(1)

GG_DATUMS            LONG
GG_DOK_DAT           LONG
GG_DOK_SENR          STRING(14)
GG_DOK_SE            STRING(7)  !VAJAG EDSam
GG_DOK_NR            STRING(14) !VAJAG EDSam
KOPA_P               DECIMAL(12,2)
KOPA_P_PVN           DECIMAL(12,2)
KOPA_S               DECIMAL(12,2)
KOPA_S_PVN           DECIMAL(12,2)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC
MENESIS              STRING(10)

P_TABLE    QUEUE,PRE(P)
DATUMS       LONG
PAR_NR       ULONG
DOK_DAT      LONG
DOK_SENR     STRING(14)
ATT_DOK      STRING(1)
D_K          STRING(1)
SUMMA_B      DECIMAL(12,2)
SUMMA_PVN    DECIMAL(11,2)
           .

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

!-----------------------------------------------------------------------------
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
!report REPORT,AT(198,500,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
report REPORT,AT(100,500,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,AT(,10,,677),USE(?unnamed:2)
         STRING(@s1),AT(3958,354),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING('Pielikums Ministru kabineta 2001.gada 12.jûnija'),AT(5490,354),USE(?StringNOT1:2)
         STRING(' noteikumiem Nr.251'),AT(6802,531),USE(?StringNOT1),TRN
       END
detail DETAIL,AT(,,,9719),USE(?unnamed)
         STRING('PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJAS PIELIKUMS'),AT(1250,52,5677,260),USE(?String1), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('PAR KOKMATERIÂLU PIEGÂDÇM UN PAKALPOJUMIEM DARÎJUMOS AR KOKMATERIÂLIEM'),AT(365,313,7083,260), |
             USE(?String1:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('I. PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJÂ IEKÏAUJAMÂS PVN SUMMAS APRÇÍINS'),AT(365,625,5677,260), |
             USE(?String1:3),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,885,7135,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(625,885,0,8750),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('1.'),AT(365,938,260,208),USE(?String3),CENTER
         STRING('Taksâcijas periods :'),AT(677,938,1302,208),USE(?String3:2),LEFT
         STRING(@n4),AT(1979,938),USE(GL:DB_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(2292,938,417,208),USE(?String3:3),LEFT
         STRING(@s12),AT(2708,938,833,208),USE(MENESIS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(6854,927),USE(SYS:NOKL_TE),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         LINE,AT(313,1146,7135,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('2.'),AT(365,1198,260,208),USE(?String3:5),CENTER
         LINE,AT(313,1406,7135,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('3.'),AT(365,1458,260,208),USE(?String3:7),CENTER
         STRING('Valsts ieòçmumu dienesta (VID) ar PVN apliekamo personu reìistrâ pieðíirtais num' &|
             'urs :'),AT(677,1458,4427,208),USE(?String3:8),LEFT
         STRING(@s13),AT(5104,1458,1042,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,1667,7135,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(6250,1875,0,7760),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('(latos)'),AT(6302,1719,1146,156),USE(?String3:9),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,1875,7135,0),USE(?Line1:20),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6260,1927,948,156),USE(R4),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,2083,313,156),USE(?String3:12),LEFT
         STRING('apliekamâm personâm, neizmantojot mazumtirdzniecîbas tîklu (PVN 18%)'),AT(990,2083,4427,156), |
             USE(?String3:53),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2083,,156),USE(R41),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('izmantojot mazumtirdzniecîbas tîklu (PVN 18%)'),AT(990,2240,3698,156),USE(?String3:14), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2240,854,156),USE(R42),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('neapliekamajâm personâm , neizmantojot mazumtirdzniecîbas tîklu (PVN 18%)'),AT(990,2396,4583,156), |
             USE(?String3:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2396,854,156),USE(R43),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,3177,7135,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('5.'),AT(365,3229,260,156),USE(?String3:52),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Sniegto pakalpojumu vçrtîba kopâ (5.1. + 5.2. + 5.3. + 5.4.)'),AT(677,3229,3698,156), |
             USE(?String3:54),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,3385,417,156),USE(?String3:55),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('apliekamâm personâm (PVN 18%)'),AT(990,3385,3698,156),USE(?String3:13),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.1.'),AT(365,3385,260,156),USE(?String3:56),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.5.'),AT(365,2708,260,156),USE(?String3:22),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.4.'),AT(365,2552,260,156),USE(?String3:21),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.3.'),AT(365,2396,260,156),USE(?String3:20),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.2.'),AT(365,2240,260,156),USE(?String3:19),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('kokmateriâlu eksports (PVN 0%)'),AT(990,2552,3698,156),USE(?String3:16),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2552,854,156),USE(R44),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.'),AT(365,4219,260,156),USE(?String3:24),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemto kokmateriâlu vçrtîba - kopâ (6.1. + 6.2. + 6.3. + 6.4. + 6.5.)'),AT(677,4219,4063,156), |
             USE(?String3:23),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('no apliekamâm personâm (neizmantojot mazumtirdzniecîbas tîklu)'),AT(990,4375,4271,156), |
             USE(?String3:26),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('izmantojot mazumtirdzniecîbas tîklu'),AT(990,4531,3698,156),USE(?String3:27),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4531,854,156),USE(R62),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3542,854,156),USE(R52),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.3.'),AT(365,3698,260,156),USE(?String3:59),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('pakalpojumi, kas apliekami ar 0% PVN likmi'),AT(990,4010,3698,156),USE(?String3:60), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('kokmateriâlu imports'),AT(990,4844,3698,156),USE(?String3:29),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4844,854,156),USE(R64),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.5.'),AT(365,5000,260,156),USE(?String3:87),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas noliktavâs ar PVN 0% likmi saòemto kokmateriâlu vçrtîba' &|
             ', ja'),AT(990,5000,5260,156),USE(?String3:88),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5000,854,156),USE(R65),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('kokmateriâli Latvijas Republikâ no treðajâm valstîm vai treðajâm teritorijâm un ' &|
             'nav izlaisti'),AT(990,5156,5260,156),USE(?String3:89),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvam apgrozîjumam iekðzemç'),AT(990,5313,5260,156),USE(?String3:90),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('8.'),AT(365,6198,260,208),USE(?String3:38),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas piegâdâti izmantojot mazumtirdzniecîbas tîklu (4.2. x 18' &|
             '%)'),AT(990,7031,5104,156),USE(?String3:39),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7031,854,156),USE(R102),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6198),USE(R8),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,6146,7135,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('9.'),AT(365,6458,260,208),USE(?String3:40),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Neapliekamo darîjumu veikðanai izmantoto pakalpojumu vçrtîba'),AT(677,6458,4271,208), |
             USE(?String3:71),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas piegâdâti neapliekamâm personâm (4.3. x 18%)'),AT(990,7188,5000,156), |
             USE(?String3:41),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7188,854,156),USE(R103),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.4.'),AT(365,7344,260,156),USE(?String3:76),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas saòemti no apliekamâm personâm (7.1. x 18%)'),AT(990,7344,5052,156), |
             USE(?String3:77),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7344,854,156),USE(R104),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.5.'),AT(365,7500,260,156),USE(?String3:78),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas sniegti neapliekamâm personâm (5.2. x 18%)'),AT(990,7500,5052,156), |
             USE(?String3:79),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7500,854,156),USE(R105),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.6.'),AT(365,7656,260,156),USE(?String3:91),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas sniegti citâs Eiropas Savienîbas dalîbvalstîs vai treðajâ' &|
             's valstîs,'),AT(990,7656,5260,156),USE(?String3:92),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7656,854,156),USE(R106),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('vai treðajâs teritorijâs reìistrçtâm personâm, kas nav reìistrçtas VID ar PVN ap' &|
             'liekamo'),AT(990,7813,5260,156),USE(?String3:93),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('personu reìistrâ (5.3. x 18%)'),AT(990,7969,5260,156),USE(?String3:94),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.3.'),AT(365,7188,260,156),USE(?String3:75),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6458),USE(R9),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,6406,7135,0),USE(?Line1:10),COLOR(COLOR:Black)
         STRING('10.'),AT(365,6719,260,156),USE(?String3:42),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksâtais PVN kopâ (11.1. + 11.2.)'),AT(677,8177,2917,156),USE(?String3:43),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,8333,417,156),USE(?String3:66),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8333,854,156),USE(R111),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('11.2.'),AT(365,8490,260,156),USE(?String3:83),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('11.1.'),AT(365,8333,260,156),USE(?String3:81),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas saòemti, izmantojot mazumtirdzniecîbas tîklu (6.2. x 18%' &|
             ')'),AT(990,8333,5052,156),USE(?String3:82),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6719,854,156),USE(R10),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,6875,313,156),USE(?String3:73),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.1.'),AT(365,6875,260,156),USE(?String3:74),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6875,854,156),USE(R101),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.2.'),AT(365,7031,260,156),USE(?String3:80),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,8125,7135,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('14.'),AT(365,9219,260,208),USE(?String3:50),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atskaitâmais priekðnodoklis (10.1. + 10.4. + 11.1. + 11.2. - 12.)'),AT(677,8958,3906,208), |
             USE(?String3:51),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,9219),USE(R14),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,8906,7135,0),USE(?Line1:15),COLOR(COLOR:Black)
         STRING('Pievienotâs vçrtîbas nodokïa deklarâcijâ iekïaujamâ PVN summa, par kuru palielin' &|
             'âma vai'),AT(677,9219,5573,190),USE(?String3:17),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(' samazinâma budþetâ maksâjamâ pievienotâs vçrtîbas nodokïa summa (10. - 13.)'),AT(677,9427,4896,188), |
             USE(?String3:47),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,9635,7135,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(313,9167,7135,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING('13.'),AT(365,8958,260,208),USE(?String3:48),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Neatskaitâmais priekðnodoklis ((8. + 9.) x 18%)'),AT(677,8698,3333,208),USE(?String3:49), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8958),USE(R13),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8698),USE(R12),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,8646,7135,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('12.'),AT(365,8698,260,208),USE(?String3:46),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,6667,7135,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Aprçíinâtais PVN kopâ (10.1. + 10.2. + 10.3. + 10.4. + 10.5. + 10.6.)'),AT(677,6719,4271,156), |
             USE(?String3:72),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('11.'),AT(365,8177,260,156),USE(?String3:44),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par importçtajiem kokmateriâliem (6.4. x 18%)'),AT(990,8490,3021,156),USE(?String3:45), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8490,854,156),USE(R112),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8177,854,156),USE(R11),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3854,854,156),USE(R54),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Neapliekamo darîjumu veikðanai izmantoto kokmateriâlu vçrtîba'),AT(677,6198,4271,208), |
             USE(?String3:35),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4219,854,156),USE(R6),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,5469,7135,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('7.'),AT(365,5521,260,156),USE(?String3:36),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemto pakalpojumu vçrtîba kopâ (7.1. + 7.2. + 7.3.)'),AT(677,5521,3698,156),USE(?String3:63), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas saòemti no apliekamâm personâm (6.1. x 18%)'),AT(990,6875,5052,156), |
             USE(?String3:37),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5521,854,156),USE(R7),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,5677,313,156),USE(?String3:64),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.1.'),AT(365,5677,260,156),USE(?String3:34),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('no apliekamâm personâm'),AT(990,5677,3698,156),USE(?String3:65),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5677,854,156),USE(R71),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no neapliekamâm personâm'),AT(990,5833,3698,156),USE(?String3:68),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5833,854,156),USE(R72),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('pakalpojumi, kas apliekami ar 0% PVN likmi'),AT(990,5990,3698,156),USE(?String3:69), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5990,854,156),USE(R73),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.3.'),AT(365,5990,260,156),USE(?String3:70),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.2.'),AT(365,5833,260,156),USE(?String3:67),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,4167,7135,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('6.4.'),AT(365,4844,260,156),USE(?String3:33),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.3.'),AT(365,4688,260,156),USE(?String3:32),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.2.'),AT(365,4531,260,156),USE(?String3:31),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.1.'),AT(365,4375,260,156),USE(?String3:30),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3385,854,156),USE(R51),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.2.'),AT(365,3542,260,156),USE(?String3:57),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('neapliekamâm personâm (PVN 18%)'),AT(990,3542,3698,156),USE(?String3:58),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no neapliekamâm personâm (neizmantojot mazumtirdzniecîbas tîklu)'),AT(990,4688,4323,156), |
             USE(?String3:28),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4688,854,156),USE(R63),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3698,854,156),USE(R53),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('personâm, kas nav reìistrçtas VID ar PVN apliekamo personu reìistrâ (PVN 18%)'),AT(990,3854,5208,156), |
             USE(?String3:86),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.4.'),AT(365,4010,260,156),USE(?String3:61),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('citâs Eiropas Savienîbas dalîbvalstîs vai treðajâs valstîs, vai treðajâs teritor' &|
             'ijâs reìistrçtâm'),AT(990,3698,5208,156),USE(?String3:62),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3229,854,156),USE(R5),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,4375,313,156),USE(?String3:25),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4375,854,156),USE(R61),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.1.'),AT(365,2083,260,156),USE(?String3:18),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas noliktavâs iegâdâto kokmateriâlu vçrtîba, ja kokmateriâ' &|
             'li ievesti'),AT(990,2708,5208,156),USE(?String3:15),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2708,854,156),USE(R45),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Latvijas Republikâ no treðajâm valstîm vai treðajâm teritorijâm un nav izlaisti ' &|
             'brîvam'),AT(990,2865,5208,156),USE(?String3:84),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('apgrozîjumam iekðzemç (PVN 0%)'),AT(990,3021,5208,156),USE(?String3:85),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.'),AT(365,1927,260,156),USE(?String3:10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdâto kokmateriâlu vçrtîba - kopâ (4.1. + 4.2. + 4.3. + 4.4. + 4.5.)'),AT(677,1927,4010,156), |
             USE(?String3:11),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,885,0,8750),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@s45),AT(4323,1198,2865,208),USE(client),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Ar pievienotâs vçrtîbas nodokli (PVN) apliekamâs personas nosaukums :'),AT(677,1198,3646,208), |
             USE(?String3:6),LEFT
         LINE,AT(313,885,0,8750),USE(?Line2),COLOR(COLOR:Black)
       END
detail1 DETAIL,PAGEBEFORE(-1),AT(,,,1760)
         STRING('II. KOKMATERIÂLU PIEGÂDÂTÂJU (SAÒÇMÇJU) UN PAKALPOJUMU SNIEDZÇJU (SAÒÇMÇJU) SARA' &|
             'KSTS'),AT(417,104,6563,260),USE(?String1:4),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,365,7813,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,417,208,208),USE(?String135),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,417,469,208),USE(?String136),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(990,521,2813,208),USE(?String137),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('VID ar PVN'),AT(2917,938,885,156),USE(?String137:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3854,938,521,208),USE(?String149:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(4427,938,990,208),USE(?String149:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('muitas deklarâcija'),AT(3854,677,1563,208),USE(?String143:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumi (Ls)'),AT(5469,729,1198,156),USE(?String147:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kokmat. vai sniegti'),AT(5469,573,1198,156),USE(?String147:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumi (Ls)'),AT(6719,729,1198,156),USE(?String147:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kokmat. vai saòemti'),AT(6719,573,1198,156),USE(?String147:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,885,6979,0),USE(?Line35),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(5469,1094,573,156),USE(?String149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6094,990,573,208),USE(?String149:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(6719,1094,573,156),USE(?String149:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,885,0,885),USE(?Line36:2),COLOR(COLOR:Black)
         STRING('vçrtba'),AT(6719,938,573,156),USE(?String149:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7344,990,573,208),USE(?String149:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(5469,938,573,156),USE(?String149:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,885,0,885),USE(?Line36:4),COLOR(COLOR:Black)
         STRING('apliekamo'),AT(2917,1094,885,156),USE(?String137:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pers. reì.'),AT(2917,1250,885,156),USE(?String137:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pieðíirtais'),AT(2917,1406,885,156),USE(?String137:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(2917,1563,885,156),USE(?String137:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(990,938,1875,208),USE(?String137:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2865,885,0,885),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(104,1719,7813,0),USE(?Line1:17),COLOR(COLOR:Black)
         STRING('Piegâdâti (ari eksp.)'),AT(5469,417,1198,156),USE(?String147),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemti (ari import.)'),AT(6719,417,1198,156),USE(?String147:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,885,0,885),USE(?Line36),COLOR(COLOR:Black)
         STRING('Pavadzme-rçíins vai'),AT(3854,417,1563,208),USE(?String143),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,365,0,1406),USE(?Line27:2),COLOR(COLOR:Black)
         LINE,AT(6667,365,0,1406),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7917,365,0,1406),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(3802,365,0,1406),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(938,365,0,1406),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(417,365,0,1406),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(104,365,0,1406),USE(?Line23),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,177)
         STRING(@n3),AT(156,10,208,156),USE(NPK),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line29),COLOR(COLOR:Black)
         STRING(@d5.),AT(448,10,469,156),USE(GG_DATUMS),RIGHT
         LINE,AT(938,-10,0,197),USE(?Line30),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_P),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line31),COLOR(COLOR:Black)
         STRING(@s13),AT(2938,10,833,156),USE(PAR_LVREGNR),LEFT
         LINE,AT(3802,-10,0,197),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line32),COLOR(COLOR:Black)
         STRING(@d5.),AT(3844,10,,156),USE(GG_dok_dat),RIGHT
         LINE,AT(4375,-10,0,197),USE(?Line32:3),COLOR(COLOR:Black)
         STRING(@s14),AT(4438,10,,156),USE(GG_DOK_SENR),LEFT
         STRING(@n-_12.2b),AT(5448,10,573,156),USE(summa1),RIGHT
         LINE,AT(6667,-10,0,197),USE(?Line40),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(6698,10,573,156),USE(summa3),RIGHT
         LINE,AT(7292,-10,0,197),USE(?Line39),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(7323,10,573,156),USE(summa4),RIGHT
         LINE,AT(7917,-10,0,197),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line41),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(6073,10,573,156),USE(summa2),RIGHT
         LINE,AT(104,-10,0,197),USE(?Line28),COLOR(COLOR:Black)
       END
detail2P DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(417,-10,0,197),USE(?Line29P),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,197),USE(?Line30P),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_PP),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line31P),COLOR(COLOR:Black)
         LINE,AT(3802,-10,0,197),USE(?Line32P:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line32P),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,197),USE(?Line32P:3),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,197),USE(?Line40P),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,197),USE(?Line39P),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,197),USE(?Line33P),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line41P),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line28P),COLOR(COLOR:Black)
       END
detail3 DETAIL,AT(,,,1438),USE(?unnamed:4)
         LINE,AT(417,0,0,52),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(938,0,0,52),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,52),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(3802,0,0,313),USE(?Line47:3),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,313),USE(?Line47:6),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line47:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line47:44),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,313),USE(?Line47:5),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,313),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line47:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7813,0),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line43),COLOR(COLOR:Black)
         STRING('Kopâ par taksâcijas periodu:'),AT(417,104,1771,208),USE(?String159),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(5448,104,573,156),USE(summa1K),RIGHT
         STRING(@n-_12.2b),AT(6073,104,573,156),USE(summa2K),RIGHT
         STRING(@n-_12.2b),AT(6698,104,573,156),USE(summa3K),RIGHT
         STRING(@n-_12.2b),AT(7323,104,573,156),USE(summa4K),RIGHT
         LINE,AT(104,313,7813,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING('Uzòçmuma vadîtâjs :'),AT(573,469,1354,208),USE(?String82:5),LEFT
         LINE,AT(1927,625,2448,0),USE(?Line22),COLOR(COLOR:Black)
         STRING(@s25),AT(2396,677,1719,208),USE(sys:paraksts1),CENTER
         STRING('Grâmatvedis :'),AT(573,938,1354,208),USE(?String82),LEFT
         LINE,AT(1927,1094,2448,0),USE(?Line22:2),COLOR(COLOR:Black)
         STRING(@s25),AT(2396,1146,1719,208),USE(sys:paraksts2),CENTER
         STRING(@d6.),AT(6396,1146,615,177),USE(VID_datums),RIGHT
         STRING(@s5),AT(7094,1146,417,177),USE(KKK),LEFT
         STRING(' - R:'),AT(7510,1146,260,177),USE(?String82:4),LEFT
         STRING(@S1),AT(7771,1146),USE(RS),CENTER
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  VID_DATUMS=TODAY()
  MENESIS=MENVAR(B_DAT,2,2)

  IF INRANGE(MEN_NR,1,11) !?
    RPT_MENESIEM='      '&FORMAT(MEN_NR,@S2)
  ELSIF INRANGE(MEN_NR,12,17)
    CASE MEN_NR
    OF 12
      RPT_MENESIEM='     '&FORMAT(MEN_NR,@S2)
    OF 13                                          ! 1.CETURKSNIS
      RPT_MENESIEM='  1,2,3'
    OF 14                                          ! 2.CETURKSNIS
      RPT_MENESIEM='  4,5,6'
    OF 15                                          ! 3.CETURKSNIS
      RPT_MENESIEM='  7,8,9'
    OF 16                                          ! 4.CETURKSNIS
      RPT_MENESIEM='10,11,12'
    OF 17
      RPT_MENESIEM='  1-12  '
    .
  ELSE
     STOP('NEGAIDÎTA KÏÛDA NR= '&MEN_NR)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('KKK',KKK)
  BIND('CYCLEBKK',CYCLEBKK)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      CG = 'K1000'
      IF F:XML THEN E='E' ELSE E=''.

      CLEAR(ggk:RECORD)
      GGK:DATUMS=S_DAT
      SET(ggk:DAT_key,GGK:DAT_key)
!      Process:View{Prop:Filter} = '(GGK:BKK=KKK OR GGK:BKK[1]=S1) AND ~CYCLEGGK(CG) AND ~(GGK:U_NR=1)'
      Process:View{Prop:Filter} = '(~CYCLEGGK(CG) AND ~(GGK:U_NR=1)' !23/03/2004
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
      IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_PIIK.DUF'
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
           XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationFile type="pvn_k_dar">'
           ADD(OUTFILEXML)
           XML:LINE='<<Declaration>'
           ADD(OUTFILEXML)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!-------------analizçjam PVN kontu-----------------
        IF GGK:BKK=KKK
           ADDTABLE#=1
           CASE GGK:D_K
           OF 'D'                                       !************************ SAMAKSÂTS PVN ********
             IF INSTRING(GGK:PVN_TIPS,'2348') AND GGK:PVN_PROC=0
                KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' PVN%=0')
             .
             CASE GGK:PVN_TIPS
             OF '1'                                   ! P4=1 budþetam
             OF '2'                                   ! P4=2 IMPORTS
               R64+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R112+=GGK:SUMMA
             OF '3'                                   ! IEPIRKTS VAIRUMµ
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R61+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R101 +=GGK:SUMMA
               ELSE                                   ! NAV PVN MAKSÂTÂJS
!                  R63+=(GGK:SUMMA*100)/GGK:PVN_PROC  ! NORÂDA RK KONTU PLÂNÂ
               .
             OF '4'                                   ! IEPIRKTS MAZUMÂ
               R62+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R111+=GGK:SUMMA
             OF '8'                                   ! SAÒEMTI PAKALPOJUMI
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R71+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R104 +=GGK:SUMMA
               ELSE
!                  R72+=(GGK:SUMMA*100)/GGK:PVN_PROC  !NORÂDA RK KONTU PLÂNÂ
               .
             ELSE                                     !
               ADDTABLE#=0
             .
           OF 'K'                                     !************************ SAÒEMTS PVN ********
             IF INSTRING(GGK:PVN_TIPS,'569') AND GGK:PVN_PROC=0
                KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' PVN%=0')
             .
             CASE GGK:PVN_TIPS
             OF '1'                                   ! P4=1 budþetam
             OF '2'                                   ! P4=2 EKSPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' Eksports?')
             OF '5'                                   ! REALIZÇTS VAIRUMÂ
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R41+=(GGK:SUMMA*100)/GGK:PVN_PROC
               ELSE                                   ! NAV PVN MAKSÂTÂJS
                  R43+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R103+=GGK:SUMMA
               .
             OF '6'                                   ! REALIZÇTS MAZUMÂ
               R42+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R102+=GGK:SUMMA
             OF '9'                                   ! REALIZÇTS VAIRUMÂ
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R51+=(GGK:SUMMA*100)/GGK:PVN_PROC
               ELSE                                   ! NAV PVN MAKSÂTÂJS
                  R52+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R105+=GGK:SUMMA
               .
             ELSE                                       ! SAÒEMTS,PÂRDODOT
               ADDTABLE#=0
             .
           .
           IF ADDTABLE#
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              P:D_K=GGK:D_K
              P:SUMMA_B= (GGK:SUMMA*100)/GGK:PVN_PROC
              P:SUMMA_PVN=GGK:SUMMA
              ADD(P_TABLE)
              KOPA_P+=P:SUMMA_B
              KOPA_P_PVN+=P:SUMMA_PVN
           .
!--------------REALIZÂCIJA BEZ PVN------------------
        ELSIF GGK:BKK[1]='6' AND GGK:D_K='K'
           C#=GETKON_K(GGK:BKK,2,1)
           FOUND#=0
           LOOP R#=1 TO 2
              CASE KON:PVNK[R#]       ! Neapliekamie KOKU darîjumi
              OF 44
                 R44+= GGK:SUMMA
                 FOUND#=1
              OF 45
                 R45+= GGK:SUMMA
                 FOUND#=1
              OF 53
                 R53+= GGK:SUMMA
                 FOUND#=1
              OF 54
                 R54+= GGK:SUMMA
                 FOUND#=1
              .
           .
           IF FOUND#
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              P:D_K=GGK:D_K
       !      P:SUMMA_B= (GGK:SUMMA*100)/GGK:PVN_PROC
       !      P:SUMMA_PVN=GGK:SUMMA
              P:SUMMA_B= GGK:SUMMA
              P:SUMMA_PVN=0           !neapliekamie darîjumi
              ADD(P_TABLE)
              KOPA_P+=P:SUMMA_B
              KOPA_P_PVN+=P:SUMMA_PVN
           .
!--------------SAÒEMTS BEZ PVN------------------
        ELSIF (GGK:BKK[1]='7' OR GGK:BKK[1:2]='21') AND GGK:D_K='D'
           C#=GETKON_K(GGK:BKK,2,1)
           FOUND#=0
           LOOP R#=1 TO 2
              CASE KON:PVNK[R#]       !no neapliekamâm personâm
              OF 63                   !KOKMATERIÂLI
                 R63+= GGK:SUMMA
                 FOUND#=1
              OF 65                   !NOLIKTS MUITAS ZONÂ
                 R65+= GGK:SUMMA
                 FOUND#=1
              OF 72
                 R72+= GGK:SUMMA      !PAKALPOJUMI
                 FOUND#=1
              .
           .
           IF FOUND#
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              P:D_K=GGK:D_K
              P:SUMMA_B= GGK:SUMMA
              P:SUMMA_PVN=0          !No neapliekamâm personâm
              ADD(P_TABLE)
              KOPA_S+=P:SUMMA_B
              KOPA_S_PVN+=P:SUMMA_PVN
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
     R4 =R41+R42+R43+R44
     R5 =R51+R52
     R6 =R61+R62+R63+R64+R65
     R7 =R71+R72
     R8 =0
     R9 =0
     R10=R101+R102+R103+R104+R105
     R11=R111+R112
     R12=0
     R13=R101+R104+R11-R12
     R14=R10-R13
     PRINT(RPT:CEPURE)
     PRINT(RPT:DETAIL)                              
!--------------------------------- Kokmateriâlu piegâdâtâju(saòçmçju saraksts---------------------------
     PRINT(RPT:DETAIL1)
     IF F:XML_OK#=TRUE
        XML:LINE='<<DeclarationHeader>'
        ADD(OUTFILEXML)
        IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
        XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
        ADD(OUTFILEXML)
        TEX:DUF=CLIENT
        DO CONVERT_TEX:DUF
        XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="taks_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
        ADD(OUTFILEXML)
        IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.)&',ðodien '&FORMAT(TODAY(),@D06.)).
        XML:LINE='<<Field name="taks_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="k_piegad" value="'&CUT0(KOPA_P,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="k_piegad_pvn" value="'&CUT0(KOPA_P_PVN,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="k_sanem" value="'&CUT0(KOPA_S,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="k_sanem_pvn" value="'&CUT0(KOPA_S_PVN,2,2,1,1)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</DeclarationHeader>'
        ADD(OUTFILEXML)
     .
     LOOP I#=1 TO RECORDS(P_TABLE)
        GET(P_TABLE,I#)
        NPK+=1
        GG_DATUMS=P:DATUMS
        GG_DOK_DAT=P:DOK_DAT
        GG_DOK_SENR=P:DOK_SENR
        GG_DOK_SE=GETDOK_SENR(1,P:DOK_SENR,,P:ATT_DOK)
        GG_DOK_NR=GETDOK_SENR(2,P:DOK_SENR,,P:ATT_DOK)
        TEKSTS = GETPAR_K(P:PAR_NR,0,2)
        FORMAT_TEKSTS(47,'Arial',8,'')
        PAR_NOS_P = F_TEKSTS[1]
        PAR_LVREGNR=GETPAR_K(P:PAR_NR,0,8) ! LV&11z
        PAR_REGNR=GETPAR_K(P:PAR_NR,0,12)  ! PAR_KODS


        CASE P:D_K
        OF 'K'     !REALIZÂCIJA
           SUMMA1=P:SUMMA_B
           SUMMA2=P:SUMMA_PVN
           SUMMA3=0
           SUMMA4=0
        ELSE       !IEPIRKÐANA
           SUMMA1=0
           SUMMA2=0
           SUMMA3=P:SUMMA_B
           SUMMA4=P:SUMMA_PVN
        .
        SUMMA1K  +=SUMMA1
        SUMMA2K  +=SUMMA2
        SUMMA3K  +=SUMMA3
        SUMMA4K  +=SUMMA4

        PRINT(RPT:DETAIL2)
        IF F_TEKSTS[2]
           PAR_NOS_PP=F_TEKSTS[2]
           PRINT(RPT:DETAIL2P)
        .
        IF F_TEKSTS[3]
           PAR_NOS_PP=F_TEKSTS[3]
           PRINT(RPT:DETAIL2P)
        .
        IF F:XML_OK#=TRUE
           XML:LINE='<<Row>'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="rindas_nr" value="'&NPK&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="datums" value="'&FORMAT(GG_DATUMS,@D06.)&'" />'
           ADD(OUTFILEXML)
           IF ~PAR_REGNR THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z
           XML:LINE='<<Field name="nmr_kods_dp" value="'&CLIP(PAR_REGNR)&'" />'
           ADD(OUTFILEXML)
           TEX:DUF=CLIP(TEKSTS) !PAR:NOS_P
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="isais_nosauk_dp" value="'&CLIP(TEX:DUF)&'" />' !max 120z
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="datums_dok" value="'&FORMAT(GG_DOK_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           IF GG_DOK_SE
              XML:LINE='<<Field name="dok_ser" value="'&clip(GG_DOK_SE)&'" />'
              ADD(OUTFILEXML)
           .
           XML:LINE='<<Field name="dok_nr" value="'&clip(GG_DOK_NR)&'" />'
           ADD(OUTFILEXML)
           CASE P:D_K
           OF 'K'     !REALIZÂCIJA
              XML:LINE='<<Field name="piegadats" value="'&CUT0(SUMMA1,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="piegadats_pvn" value="'&CUT0(SUMMA2,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
           ELSE       !IEPIRKÐANA
              XML:LINE='<<Field name="sanemts" value="'&CUT0(SUMMA3,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="sanemts_pvn" value="'&CUT0(SUMMA4,2,2,1,1)&'" />'
              ADD(OUTFILEXML)
           .
           XML:LINE='<</Row>'
           ADD(OUTFILEXML)
        .
     .
    PRINT(RPT:DETAIL3)
    IF F:XML_OK#=TRUE
       XML:LINE='<</Declaration>'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationFile>'
       ADD(OUTFILEXML)
    .
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
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



B_PVN_PIEK_MKN1028   PROCEDURE                    ! Declare Procedure
!
!  EMBEDA TEXTS IR TUVU MAKSIMUMAM !!!!!!!!!!!!!!!!!!!!!!!
!


R4                   DECIMAL(12,2)
R41                  DECIMAL(12,2)
R42                  DECIMAL(12,2)
R43                  DECIMAL(12,2)
R44                  DECIMAL(12,2)
R45                  DECIMAL(12,2)
R5                   DECIMAL(12,2)
R51                  DECIMAL(12,2)
R52                  DECIMAL(12,2)
R53                  DECIMAL(12,2)
R54                  DECIMAL(12,2)
R6                   DECIMAL(12,2)
R61                  DECIMAL(12,2)
R62                  DECIMAL(12,2)
R63                  DECIMAL(12,2)
R64                  DECIMAL(12,2)
R7                   DECIMAL(12,2)
R71                  DECIMAL(12,2)
R72                  DECIMAL(12,2)
R73                  DECIMAL(12,2)
R8                   DECIMAL(12,2)
R9                   DECIMAL(12,2)
R10                  DECIMAL(12,2)
R101                 DECIMAL(12,2)
R102                 DECIMAL(12,2)
R103                 DECIMAL(12,2)
R104                 DECIMAL(12,2)
R105                 DECIMAL(12,2)
R106                 DECIMAL(12,2)
R107                 DECIMAL(12,2)
R11                  DECIMAL(12,2)
R12                  DECIMAL(12,2)
R13                  DECIMAL(12,2)
R14                  DECIMAL(12,2)
R15                  DECIMAL(12,2)

K31                  REAL
K33                  REAL
K34                  REAL
K54                  REAL
K56                  REAL

CG                   STRING(10)
NPK                  DECIMAL(3)

VID_DATUMS           LONG
PAR_NOS_P            STRING(30)
PAR_NOS_PP           STRING(30)
PAR_REGNR            STRING(13)
PAR_LVREGNR          STRING(13)

E                    STRING(1)
GG_DATUMS            LONG
GG_DOK_DAT           LONG
GG_DOK_SENR          STRING(14)
GG_DOK_SE            STRING(7)  !VAJAG EDSam
GG_DOK_NR            STRING(14) !VAJAG EDSam
KOPA_P               DECIMAL(12,2)
KOPA_P_PVN           DECIMAL(12,2)
KOPA_S               DECIMAL(12,2)
KOPA_S_PVN           DECIMAL(12,2)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC
MENESIS              STRING(10)

P_TABLE    QUEUE,PRE(P)
SADALA       BYTE
DATUMS       LONG
PAR_NR       ULONG
DOK_DAT      LONG
DOK_SENR     STRING(14)
ATT_DOK      STRING(1)
SUMMA        DECIMAL(12,2),DIM(9)
           .

SUMMAK               DECIMAL(12,2),DIM(4,9)

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

!-----------------------------------------------------------------------------
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


report1 REPORT,AT(100,500,8000,10802),PAPER(PAPER:A4),PRE(RPT1),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(,,,9719),USE(?unnamed1)
         STRING('PVN 6'),AT(7135,0),USE(?PVN6),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING('PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJAS PIELIKUMS'),AT(1406,156,5000,156),USE(?String11), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('PAR KOKMATERIÂLU PIEGÂDÇM UN PAKALPOJUMIEM DARÎJUMOS AR KOKMATERIÂLIEM'),AT(354,344,7083,260), |
             USE(?String11:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('I daïa.  PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJÂ IEKÏAUJAMÂS PVN SUMMAS APRÇÍIN' &|
             'S'),AT(625,677,6563,156),USE(?String11:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,885,7135,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(625,885,0,8750),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('1.'),AT(365,938,260,208),USE(?String3),CENTER
         STRING(@n4),AT(1979,948),USE(GL:DB_gads,,?GL:DB_GADS:1),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(2396,927,417,208),USE(?String13:3),LEFT
         LINE,AT(313,1146,7135,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('2.'),AT(365,1198,260,208),USE(?String3:5),CENTER
         LINE,AT(313,1406,7135,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Ar pievienotâs vçrtîbas nodokli (PVN) apliekamâs personas reìistrâcijas numurs :'),AT(688,1438,4115,208), |
             USE(?String13:8),LEFT
         STRING(@s13),AT(4823,1438,1042,208),USE(GL:VID_NR,,?GL:VID_NR:1),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('3.'),AT(365,1458,260,208),USE(?String3:7),CENTER
         LINE,AT(313,1667,7135,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(6313,1667,0,7969),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('(latos)'),AT(6563,1500,573,156),USE(?String3:9),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6344,1781,865,156),USE(R4),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,1938,313,156),USE(?String3:12),LEFT
         STRING('apliekamâm personâm, neizmantojot mazumtirdzniecîbas tîklu '),AT(990,1938,3698,156), |
             USE(?String3:53),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,1938,,156),USE(R41),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('izmantojot mazumtirdzniecîbas tîklu '),AT(990,2094,2135,156),USE(?String3:14),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2094,854,156),USE(R42),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('neapliekamajâm personâm , neizmantojot mazumtirdzniecîbas tîklu'),AT(990,2250,4010,156), |
             USE(?String3:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2250,854,156),USE(R43),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,3042,7135,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('5.'),AT(365,3083,260,156),USE(?String3:52),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Sniegto pakalpojumu vçrtîba (bez PVN)  kopâ (5.1. + 5.2. + 5.3. + 5.4.)'),AT(677,3073,4323,156), |
             USE(?String3:54),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,3385,417,156),USE(?String3:55),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('apliekamâm personâm '),AT(990,3240,1458,156),USE(?String3:13),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.1.'),AT(365,3240,260,156),USE(?String3:56),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.5.'),AT(365,2708,260,156),USE(?String3:22),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.4.'),AT(365,2406,260,156),USE(?String3:21),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.3.'),AT(365,2250,260,156),USE(?String3:20),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.2.'),AT(365,2094,260,156),USE(?String3:19),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('citâs Eiropas Savienîbas dalîbvalstîs vai treðajâs valstîs, vai treðajâs teritor' &|
             'ijâs reìistrçtâm'),AT(990,2406,5208,156),USE(?String3:16),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2406,854,156),USE(R44),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('personâm, kas nav reìistrçtas VID ar PVN apliekamo personu reìistrâ '),AT(990,2552,4167,156), |
             USE(?String3:2),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.'),AT(365,4219,260,156),USE(?String3:24),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemto kokmateriâlu vçrtîba - kopâ (6.1. + 6.2. + 6.3. + 6.4.)'),AT(677,4219,4063,156), |
             USE(?String3:23),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('no apliekamâm personâm, neizmantojot mazumtirdzniecîbas tîklu'),AT(990,4375,4271,156), |
             USE(?String3:26),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no apliekamâm personâm, izmantojot mazumtirdzniecîbas tîklu'),AT(990,4531,3698,156), |
             USE(?String3:27),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4531,854,156),USE(R62),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3396,854,156),USE(R52),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.3.'),AT(365,3552,260,156),USE(?String3:59),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas nol. sniegtie pakalpojumi, kas tieði saistîti ar kokm..' &|
             ',kas ievesti LR'),AT(990,3854,5260,156),USE(?String3:60),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4844,854,156),USE(R64),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas noliktavâs saòemtie kokmateriâlii, kas ievesti Latvijas' &|
             ' Republikâ'),AT(990,4844,5156,156),USE(?String3:88),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no treðajâm valstîm vai treðajâm teritorijâm un nav izlaisti brîvam apgrozîjumam' &|
             ' iekðzemç'),AT(990,5000,5260,156),USE(?String3:89),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('8.'),AT(365,6021,260,208),USE(?String3:38),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas piegâdâti izmantojot mazumtirdzniecîbas tîklu (4.2. x 21' &|
             '%)'),AT(823,6833,5104,156),USE(?String3:39),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6833,854,156),USE(R102),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6031),USE(R8),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,5990,7135,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('9.'),AT(365,6250,260,208),USE(?String3:40),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('No apliekamâm personâm saòemto neapl. darîjumu veikðanai izmantoto pakalpojumu v' &|
             'çrtîba'),AT(646,6250,5573,208),USE(?String3:71),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas piegâdâti neapliekamâm per.,neizmantojot mazum.tîklu (4.' &|
             '3. x 21%)'),AT(823,6990,5260,156),USE(?String3:41),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6990,854,156),USE(R103),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.4.'),AT(344,7135,260,156),USE(?String3:29),TRN,CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas piegâdâti citâs ES dalîbvalstîs vai treðajâs valstîs,vai' &|
             ' treðajâs teritorijâs'),AT(833,7135,5417,156),USE(?String3:73),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('reìistrçtâm personâm, kas nav reìistrçtas VID ar PVN apliekamo personu reìistrâ ' &|
             '(4.4. x 21%)'),AT(813,7292,5417,156),USE(?String3:45),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.5.'),AT(344,7427,260,156),USE(?String3:76),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas saòemti no apliekamâm personâm (7.1. x 21%)'),AT(823,7438,5052,156), |
             USE(?String3:77),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7146,854,156),USE(R104),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.6.'),AT(344,7583,260,156),USE(?String3:78),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas sniegti neapliekamâm personâm (5.2. x 21%)'),AT(823,7583,5052,156), |
             USE(?String3:79),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7438,854,156),USE(R105),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.7.'),AT(344,7740,260,156),USE(?String3:91),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('par pakalpojumiem, kas sniegti citâs ES dalîbvalstîs vai treðajâs valstîs,vai tr' &|
             'eðajâs teritorijâs'),AT(823,7740,5313,156),USE(?String3:92),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7750,854,156),USE(R107),TRN,RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,7583,854,156),USE(R106,,?R106:2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('reìistrçtâm personâm, kas nav reìistrçtas VID ar PVN apliekamo personu reìistrâ ' &|
             '(5.3. x 21%)'),AT(823,7896,5417,156),USE(?String3:93),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.3.'),AT(344,6990,260,156),USE(?String3:75),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6250),USE(R9),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,6229,7135,0),USE(?Line1:10),COLOR(COLOR:Black)
         STRING('10.'),AT(365,6490,260,156),USE(?String3:42),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksâtais PVN'),AT(677,8177,1198,156),USE(?String3:43),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(646,5365,313,156),USE(?String3:66),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas saòemti, izmantojot mazumtirdzniecîbas tîklu (6.2. x 21%' &|
             ')'),AT(990,8333,5052,156),USE(?String3:82),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6490,854,156),USE(R10),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('10.1.'),AT(344,6677,260,156),USE(?String3:74),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,6677,854,156),USE(R101),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('10.2.'),AT(344,6833,260,156),USE(?String3:80),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,8125,7135,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('14.'),AT(365,9219,260,208),USE(?String3:50),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atskaitâmais priekðnodoklis (10.1. + 10.5. + 11. - 12.)'),AT(677,8938,3281,208),USE(?String3:51), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,9219),USE(R14),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,8865,7135,0),USE(?Line1:15),COLOR(COLOR:Black)
         STRING('Pievienotâs vçrtîbas nodokïa deklarâcijâ iekïaujamâ PVN summa, par kuru palielin' &|
             'âma vai'),AT(677,9219,5573,190),USE(?String3:17),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(' samazinâma budþetâ maksâjamâ pievienotâs vçrtîbas nodokïa summa (10. - 13.)'),AT(677,9427,4896,188), |
             USE(?String3:47),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,9635,7135,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(313,9167,7135,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING('13.'),AT(365,8938,260,208),USE(?String3:48),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Neatskaitâmais priekðnodoklis ((8. + 9.) x 21%)'),AT(677,8615,3333,208),USE(?String3:49), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8938),USE(R13),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8615),USE(R12),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,8563,7135,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('12.'),AT(365,8615,260,208),USE(?String3:46),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,6458,7135,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Aprçíinâtais PVN kopâ (10.1. + 10.2. + 10.3. + 10.4. + 10.5. + 10.6. + 10.7.)'),AT(677,6490,4792,156), |
             USE(?String3:72),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('11.'),AT(365,8177,260,156),USE(?String3:44),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,8177,854,156),USE(R11),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3854,854,156),USE(R54),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('No apliekamâm personâm saòemto neapl. darîjumu veikðanai izmantoto kokmatewriâlu' &|
             ' vçrtîba'),AT(646,6010,5625,208),USE(?String3:35),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4219,854,156),USE(R6),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,5167,7135,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('7.'),AT(365,5208,260,156),USE(?String3:36),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemto pakalpojumu vçrtîba kopâ (7.1. + 7.2. + 7.3.)'),AT(677,5208,3698,156),USE(?String3:63), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('par kokmateriâliem, kas saòemti no apliekamâm personâm (6.1. x 21%)'),AT(969,6677,4323,156), |
             USE(?String3:37),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5208,854,156),USE(R7),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(667,6677,260,156),USE(?String3:64),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.1.'),AT(365,5365,260,156),USE(?String3:34),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('no apliekamâm personâm'),AT(979,5365,3698,156),USE(?String3:65),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5365,854,156),USE(R71),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no neapliekamâm personâm'),AT(979,5521,3698,156),USE(?String3:68),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5521,854,156),USE(R72),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas nol. saòemtie pakalpojumi, kas tieði saistîti ar kokm..' &|
             ',kas ievesti LR'),AT(990,5677,5313,156),USE(?String3:69),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,5677,854,156),USE(R73),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no treðajâm valstîm vai treðajâm teritorijâm un nav izlaisti brîvam apgrozîjumam' &|
             ' iekðzemç'),AT(979,5823,5208,156),USE(?String3:6),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.3.'),AT(365,5677,260,156),USE(?String3:70),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('7.2.'),AT(365,5521,260,156),USE(?String3:67),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(313,4177,7135,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('6.4.'),AT(365,4844,260,156),USE(?String3:33),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.3.'),AT(365,4688,260,156),USE(?String3:32),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.2.'),AT(365,4531,260,156),USE(?String3:31),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('6.1.'),AT(365,4375,260,156),USE(?String3:30),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3240,854,156),USE(R51),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.2.'),AT(365,3396,260,156),USE(?String3:57),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('neapliekamâm personâm '),AT(990,3396,1615,156),USE(?String3:58),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no neapliekamâm personâm'),AT(990,4688,1771,156),USE(?String3:28),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4688,854,156),USE(R63),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3552,854,156),USE(R53),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('personâm, kas nav reìistrçtas VID ar PVN apliekamo personu reìistrâ'),AT(990,3698,5208,156), |
             USE(?String3:86),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('5.4.'),AT(365,3865,260,156),USE(?String3:61),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('no treðajâm valstîm vai treðajâm teritorijâm un nav izlaisti brîvam apgrozîjumam' &|
             ' iekðzemç'),AT(990,4000,5208,156),USE(?String3:3),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('citâs Eiropas Savienîbas dalîbvalstîs vai treðajâs valstîs, vai treðajâs teritor' &|
             'ijâs reìistrçtâm'),AT(990,3552,5208,156),USE(?String3:62),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,3083,854,156),USE(R5),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.sk. :'),AT(677,4375,313,156),USE(?String3:25),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,4375,854,156),USE(R61),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.1.'),AT(365,1938,260,156),USE(?String3:18),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('brîvajâs zonâs un muitas noliktavâs piegâdâtie kokmateriâli, kas ievesti Latvija' &|
             's Republikâ'),AT(990,2708,5208,156),USE(?String3:15),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6354,2708,854,156),USE(R45),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no treðajâm valstîm vai treðajâm teritorijâm un nav izlaisti brîvam apgrozîjumam' &|
             ' iekðzemç'),AT(990,2865,5208,156),USE(?String3:84),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('4.'),AT(365,1781,260,156),USE(?String3:10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdâto kokmateriâlu vçrtîba (bez PVN) kopâ (4.1. + 4.2. + 4.3. + 4.4. + 4.5.)'),AT(677,1781,4635,156), |
             USE(?String3:11),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,885,0,8750),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Taksâcijas periods :'),AT(677,927,1146,208),USE(?String13:2),LEFT
         STRING(@s12),AT(2813,927,833,208),USE(MENESIS,,?MENESIS:1),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Ar pievienotâs vçrtîbas nodokli (PVN) apliekamâs personas nosaukums :'),AT(667,1177,3646,208), |
             USE(?String13:6),LEFT
         STRING(@s45),AT(4354,1177,2865,208),USE(client,,?CLIENT:1),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(313,885,0,8750),USE(?Line2),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,510),USE(?FOOTER)
         STRING(@s25),AT(708,42,1354,208),USE(SYS:AMATS1,,?SYS:AMATS:1),LEFT
         LINE,AT(2135,208,2448,0),USE(?Line1:22),COLOR(COLOR:Black)
         STRING(@s25),AT(2531,250,1719,208),USE(sys:paraksts1,,?SYS:PARAKSTS1:1),CENTER
         STRING(@d06.),AT(1042,229,677,208),USE(VID_datums,,?VID_DATUMS:1),RIGHT,FONT(,8,,,CHARSET:ANSI)
         STRING('Datums:'),AT(510,229,417,208),USE(?String182:4),RIGHT
         STRING(@S1),AT(52,0),USE(RS,,?RS:1),CENTER,FONT(,7,,,CHARSET:ANSI)
       END
     END

!report REPORT,AT(198,500,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
!report REPORT,AT(100,500,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
!         THOUS
!detail1H DETAIL,PAGEBEFORE(-1),AT(,,,1760),USE(?unnamed)

report2 REPORT,AT(200,600,12000,7198),PAPER(PAPER:A4),PRE(RPT2),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(200,200,12000,302),USE(?unnamed)
       END
CEPURE DETAIL,AT(,10,,1531),USE(?unnamed:2)
         STRING(@s1),AT(9344,52),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING('1. pielikums'),AT(10385,63),USE(?String1p)
         STRING('Ministru kabineta'),AT(10125,198),USE(?Stringmk),TRN
         STRING('2006.gada 19.decembra'),AT(9740,323),USE(?StringNOT1:3),TRN
         STRING('PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJAS PIELIKUMS'),AT(2490,63,5000,260),USE(?String1), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(' noteikumiem Nr. 1028'),AT(9865,458),USE(?StringNOT1:2),TRN
         STRING('PAR KOKMATERIÂLU PIEGÂDÇM UN PAKALPOJUMIEM DARÎJUMOS AR KOKMATERIÂLIEM'),AT(1604,323,7083,260), |
             USE(?String1:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('II daïa. KOKMATERIÂLU PIEGÂDÂTÂJU (SAÒÇMÇJU) UN PAKALPOJUMU SNIEDZÇJU (SAÒÇMÇJU)' &|
             ' SARAKSTS'),AT(1698,604,6927,260),USE(?String1:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas periods :'),AT(1813,896,1302,208),USE(?StringC3:2),LEFT
         STRING(@n4),AT(3229,896),USE(GL:DB_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(3542,896,417,208),USE(?StringC3:3),LEFT
         STRING(@s12),AT(3958,896,833,208),USE(MENESIS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(10458,698),USE(SYS:NOKL_TE),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('Ar pievienotâs vçrtîbas nodokli (PVN) apliekamâs personas nosaukums :'),AT(1813,1094,3646,208), |
             USE(?StringC3:6),LEFT
         STRING(@s45),AT(5500,1094,2865,208),USE(client),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Ar pievienotâs vçrtîbas nodokli (PVN) apliekamâs personas reìistrâcijas numurs :'),AT(1813,1302,4115,208), |
             USE(?String3:8),LEFT
         STRING(@s13),AT(5948,1302,1042,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detail1H DETAIL,AT(,,,1281),USE(?unnamed:9)
         STRING('1.  KOKMATERIÂLU PIEGÂDÂTÂJU  SARAKSTS'),AT(1365,104,4948,208),USE(?String1:3),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,365,9740,0),USE(?Line11:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,542,208,208),USE(?String135),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,542,469,208),USE(?String136),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partneris'),AT(1240,542,2188,208),USE(?String137:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apl.pers.'),AT(2865,938,938,156),USE(?String137:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3854,958,521,208),USE(?String149:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(4427,958,990,208),USE(?String149:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('muitas deklarâcija'),AT(3844,625,1563,208),USE(?String143:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(5510,729,1094,156),USE(?String147:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apliekamâm'),AT(5521,573,1094,156),USE(?String147:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(Ls)'),AT(6833,729,885,156),USE(?String147:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(7938,729,938,156),USE(?String147:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâs (Ls)'),AT(8917,729,938,156),USE(?String147:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mazumtirdzniecîbâ '),AT(6698,573,1198,156),USE(?String147:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('neapliekamâm'),AT(7938,573,938,156),USE(?String147:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un muitas'),AT(8969,573,781,156),USE(?String147:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,885,8906,0),USE(?Line35:2),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(5469,1094,573,156),USE(?String149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6094,958,573,208),USE(?String149:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(6719,1094,573,156),USE(?String149:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(9063,990,573,156),USE(?String149:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,885,0,365),USE(?Line36:8),COLOR(COLOR:Black)
         STRING('vçrtba'),AT(6719,938,573,156),USE(?String149:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7344,990,573,156),USE(?String149:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(8125,990,573,156),USE(?String149:91),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(5469,938,573,156),USE(?String149:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,885,0,417),USE(?Line36:6),COLOR(COLOR:Black)
         STRING('reìistrâc. Nr'),AT(2917,1094,885,156),USE(?String137:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(990,958,1875,208),USE(?String137:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2865,885,0,365),USE(?Line36:5),COLOR(COLOR:Black)
         LINE,AT(104,1260,9740,0),USE(?Line11:2),COLOR(COLOR:Black)
         STRING('no'),AT(5500,417,1094,156),USE(?String147),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no'),AT(8010,417,781,156),USE(?String147:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8885,365,0,938),USE(?Line27:7),COLOR(COLOR:Black)
         STRING('brîvajâs zonâs'),AT(8906,417,885,156),USE(?String147:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9844,365,0,885),USE(?Line27:8),COLOR(COLOR:Black)
         LINE,AT(6042,885,0,417),USE(?Line36:7),COLOR(COLOR:Black)
         STRING('Pavadzme-rçíins vai'),AT(3854,469,1563,156),USE(?String143:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,365,0,938),USE(?Line27:5),COLOR(COLOR:Black)
         LINE,AT(6667,365,0,938),USE(?Line27:6),COLOR(COLOR:Black)
         LINE,AT(7917,365,0,885),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(3802,365,0,885),USE(?Line26:2),COLOR(COLOR:Black)
         LINE,AT(938,365,0,885),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(417,365,0,885),USE(?Line24:2),COLOR(COLOR:Black)
         LINE,AT(104,365,0,885),USE(?Line23:2),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:7)
         STRING(@n3),AT(156,10,208,156),USE(NPK),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line29),COLOR(COLOR:Black)
         STRING(@d05.),AT(448,10,469,156),USE(GG_DATUMS,,?GG_DATUMS:2),RIGHT
         LINE,AT(938,-10,0,197),USE(?Line30),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_P),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line31),COLOR(COLOR:Black)
         STRING(@s13),AT(2938,10,833,156),USE(PAR_LVREGNR),LEFT
         LINE,AT(3802,-10,0,197),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line32),COLOR(COLOR:Black)
         STRING(@d05.),AT(3844,10,,156),USE(GG_dok_dat),RIGHT
         LINE,AT(4375,-10,0,197),USE(?Line32:3),COLOR(COLOR:Black)
         STRING(@s14),AT(4438,10,,156),USE(GG_DOK_SENR),LEFT
         LINE,AT(6667,-10,0,197),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,197),USE(?Line39),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(5448,10,573,156),USE(P:summa[1]),RIGHT
         STRING(@n-_12.2b),AT(6073,10,573,156),USE(P:SUMMA[2]),RIGHT
         STRING(@n-_11.2b),AT(6698,10,573,156),USE(P:SUMMA[3]),RIGHT
         STRING(@n-_11.2b),AT(7323,10,573,156),USE(P:SUMMA[4]),RIGHT
         STRING(@n-_11.2b),AT(8188,10,573,156),USE(P:SUMMA[5]),RIGHT
         STRING(@n-_11.2b),AT(9115,10,573,156),USE(P:SUMMA[7]),RIGHT
         LINE,AT(7917,-10,0,197),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(8885,0,0,197),USE(?Line33:6),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,197),USE(?Line33:5),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line28),COLOR(COLOR:Black)
       END
detail1K DETAIL,AT(,,,354),USE(?unnamed:10)
         LINE,AT(417,0,0,52),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(938,0,0,52),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,52),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(3802,0,0,313),USE(?Line47:3),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,313),USE(?Line47:6),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line47:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line47:44),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,313),USE(?Line47:5),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,313),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line47:2),COLOR(COLOR:Black)
         LINE,AT(8885,0,0,313),USE(?Line47:9),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,313),USE(?Line47:8),COLOR(COLOR:Black)
         LINE,AT(104,52,9740,0),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line43),COLOR(COLOR:Black)
         STRING('Kopâ par taksâcijas periodu:'),AT(417,104,1771,208),USE(?String159),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(5448,104,573,156),USE(summaK[1,1]),RIGHT
         STRING(@n-_12.2b),AT(6073,104,573,156),USE(summaK[1,2]),RIGHT
         STRING(@n-_12.2b),AT(6698,104,573,156),USE(summaK[1,3]),RIGHT
         STRING(@n-_12.2b),AT(7323,104,573,156),USE(summaK[1,4]),RIGHT
         STRING(@n-_11.2b),AT(8188,104,573,156),USE(SUMMAK[1,5]),TRN,RIGHT
         STRING(@n-_11.2b),AT(9115,104,573,156),USE(SUMMAK[1,7]),TRN,RIGHT
         LINE,AT(104,313,9740,0),USE(?Line1:19),COLOR(COLOR:Black)
       END
detail2H DETAIL,AT(,,,1281),USE(?unnamed:29)
         STRING('2.  PAKALPOJUMU SNIEDZÇJU SARAKSTS'),AT(1365,104,4948,208),USE(?String21:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,365,8802,0),USE(?Line21:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,542,208,208),USE(?String2135),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,542,469,208),USE(?String2136),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partneris'),AT(1240,542,2188,208),USE(?String2137:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apl.pers.'),AT(2865,938,938,156),USE(?String2137:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3854,958,521,208),USE(?String2149:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(4427,958,990,208),USE(?String2149:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('muitas deklarâcija'),AT(3844,625,1563,208),USE(?String2143:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(5510,729,1094,156),USE(?String2147:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apliekamâm'),AT(5521,573,1094,156),USE(?String2147:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(6865,729,938,156),USE(?String2147:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâs (Ls)'),AT(7948,729,938,156),USE(?String2147:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('neapliekamâm'),AT(6865,573,938,156),USE(?String2147:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un muitas'),AT(8000,573,781,156),USE(?String2147:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,885,7969,0),USE(?Line235:2),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(5469,1094,573,156),USE(?String2149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6115,958,573,208),USE(?String2149:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(7010,990,573,156),USE(?String2149:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(8125,990,573,156),USE(?String2149:91),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(5469,938,573,156),USE(?String2149:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,885,0,417),USE(?Line236:6),COLOR(COLOR:Black)
         STRING('reìistrâc. Nr'),AT(2917,1094,885,156),USE(?String2137:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(990,958,1875,208),USE(?String2137:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2865,885,0,365),USE(?Line236:5),COLOR(COLOR:Black)
         LINE,AT(104,1260,8802,0),USE(?Line21:2),COLOR(COLOR:Black)
         STRING('no'),AT(5500,417,1094,156),USE(?String2147),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no'),AT(6938,417,781,156),USE(?String2147:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,365,0,938),USE(?Line227:7),COLOR(COLOR:Black)
         STRING('brîvajâs zonâs'),AT(7938,417,885,156),USE(?String2147:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,885,0,417),USE(?Line236:7),COLOR(COLOR:Black)
         STRING('Pavadzme-rçíins vai'),AT(3854,469,1563,156),USE(?String2143:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,365,0,938),USE(?Line227:5),COLOR(COLOR:Black)
         LINE,AT(6771,365,0,938),USE(?Line227:6),COLOR(COLOR:Black)
         LINE,AT(7917,365,0,885),USE(?Line238:2),COLOR(COLOR:Black)
         LINE,AT(3802,365,0,885),USE(?Line226:2),COLOR(COLOR:Black)
         LINE,AT(938,365,0,885),USE(?Line225:2),COLOR(COLOR:Black)
         LINE,AT(417,365,0,885),USE(?Line224:2),COLOR(COLOR:Black)
         LINE,AT(104,365,0,885),USE(?Line223:2),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,177),USE(?unnamed:27)
         STRING(@n3),AT(156,10,208,156),USE(NPK,,?NPK:2),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line229),COLOR(COLOR:Black)
         STRING(@d05.),AT(448,10,469,156),USE(GG_DATUMS,,?GG_DATUMS2),RIGHT
         LINE,AT(938,-10,0,197),USE(?Line230),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_P,,?PAR_NOS_P:2),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line231),COLOR(COLOR:Black)
         STRING(@s13),AT(2938,10,833,156),USE(PAR_LVREGNR,,?PR2),LEFT
         LINE,AT(3802,-10,0,197),USE(?Line232:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line232),COLOR(COLOR:Black)
         STRING(@d05.),AT(3844,10,,156),USE(GG_dok_dat,,?GD2),RIGHT
         LINE,AT(4375,-10,0,197),USE(?Line232:3),COLOR(COLOR:Black)
         STRING(@s14),AT(4438,10,,156),USE(GG_DOK_SENR,,?DS2),LEFT
         STRING(@n-_12.2b),AT(5448,10,573,156),USE(P:SUMMA[1],,?P:SUMMA_2:1),RIGHT
         STRING(@n-_12.2b),AT(6125,10,573,156),USE(P:SUMMA[2],,?P:SUMMA_2:2),RIGHT
         STRING(@n-_11.2b),AT(7042,10,573,156),USE(P:SUMMA[5],,?P:SUMMA_2:5),RIGHT
         STRING(@n-_11.2b),AT(8104,10,573,156),USE(P:SUMMA[7],,?P:SUMMA_2:7),RIGHT
         LINE,AT(6771,-10,0,197),USE(?Line240),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,197),USE(?Line233),COLOR(COLOR:Black)
         LINE,AT(0,0,0,197),USE(?Line233:4),COLOR(COLOR:Black)
         LINE,AT(0,0,0,197),USE(?Line233:3),COLOR(COLOR:Black)
         LINE,AT(8906,0,0,197),USE(?Line233:6),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line241),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line228),COLOR(COLOR:Black)
       END
detail2K DETAIL,AT(,,,354),USE(?unnamed:25)
         LINE,AT(417,0,0,52),USE(?Line244),COLOR(COLOR:Black)
         LINE,AT(938,0,0,52),USE(?Line245),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,52),USE(?Line246),COLOR(COLOR:Black)
         LINE,AT(3802,0,0,313),USE(?Line247:3),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,313),USE(?Line247:6),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line247:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line247:44),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,313),USE(?Line247:5),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line247:2),COLOR(COLOR:Black)
         LINE,AT(8906,0,0,313),USE(?Line247:10),COLOR(COLOR:Black)
         LINE,AT(104,52,8802,0),USE(?Line21:18),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line243),COLOR(COLOR:Black)
         STRING('Kopâ par taksâcijas periodu:'),AT(417,104,1771,208),USE(?String2159),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(5448,104,573,156),USE(summaK[2,1]),RIGHT
         STRING(@n-_12.2b),AT(6125,104,573,156),USE(summaK[2,2]),RIGHT
         STRING(@n-_12.2b),AT(7042,104,573,156),USE(summaK[2,5]),RIGHT
         STRING(@n-_12.2b),AT(8115,104,573,156),USE(summaK[2,7]),RIGHT
         LINE,AT(104,313,8802,0),USE(?Line21:19),COLOR(COLOR:Black)
       END
detail3H DETAIL,AT(,,,1292),USE(?unnamed:39)
         STRING('3.  KOKMATERIÂLU SAÒÇMÇJU  SARAKSTS'),AT(1365,104,4948,208),USE(?String1:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,365,11094,0),USE(?Line31:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,542,208,208),USE(?String3135),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,542,469,208),USE(?String3136),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partneris'),AT(1240,542,2188,208),USE(?String3137:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apl.pers.'),AT(2865,938,938,156),USE(?String3137:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3854,958,521,208),USE(?String3149:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(4427,958,990,208),USE(?String3149:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('muitas deklarâcija'),AT(3844,625,1563,208),USE(?String3143:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai treðajâs valstîs'),AT(9198,573,1146,156),USE(?String3147:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(5510,729,1094,156),USE(?String3147:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apliekamâm'),AT(5521,573,1094,156),USE(?String3147:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(Ls)'),AT(6833,729,885,156),USE(?String3147:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(8073,729,938,156),USE(?String3147:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('reìistrçtâm pers.'),AT(9198,729,1146,156),USE(?String3147:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâs'),AT(10417,729,781,156),USE(?String3147:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(9167,927,573,156),USE(?String3149:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(7948,927,573,156),USE(?String3149:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mazumtirdzniecîbâ '),AT(6698,573,1198,156),USE(?String3147:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('neapliekamâm'),AT(8073,573,938,156),USE(?String3147:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un muitas'),AT(10417,573,781,156),USE(?String3147:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,885,10260,0),USE(?Line335:2),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(5469,1094,573,156),USE(?String3149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6094,958,573,208),USE(?String3149:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(6719,1094,573,156),USE(?String3149:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(10479,990,573,156),USE(?String3149:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(8615,990,469,156),USE(?String3149:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(9844,990,469,156),USE(?String3149:13),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,885,0,365),USE(?Line336:8),COLOR(COLOR:Black)
         LINE,AT(8542,885,0,365),USE(?Line336:2),COLOR(COLOR:Black)
         LINE,AT(9771,885,0,365),USE(?Line336:3),COLOR(COLOR:Black)
         STRING('vçrtba'),AT(6719,938,573,156),USE(?String3149:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(9167,1083,573,156),USE(?String3149:12),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7323,990,573,156),USE(?String3149:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(7948,1083,573,156),USE(?String3149:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(5469,938,573,156),USE(?String3149:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,885,0,417),USE(?Line336:6),COLOR(COLOR:Black)
         STRING('reìistrâc. Nr'),AT(2917,1094,885,156),USE(?String3137:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(990,958,1875,208),USE(?String3137:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2865,885,0,365),USE(?Line336:5),COLOR(COLOR:Black)
         LINE,AT(146,1260,11042,0),USE(?Line31:2),COLOR(COLOR:Black)
         STRING('no'),AT(5500,417,1094,156),USE(?String3147),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no'),AT(8146,417,781,156),USE(?String3147:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9156,365,0,938),USE(?Line327:7),COLOR(COLOR:Black)
         STRING('brîvajâs zonâs'),AT(10396,417,781,156),USE(?String3147:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10375,365,0,885),USE(?Line327:3),COLOR(COLOR:Black)
         LINE,AT(11198,375,0,885),USE(?Line327:2),COLOR(COLOR:Black)
         LINE,AT(6042,885,0,417),USE(?Line336:7),COLOR(COLOR:Black)
         STRING('Pavadzme-rçíins vai'),AT(3854,469,1563,156),USE(?String3143:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('citâs ES valstîs'),AT(9323,417,885,156),USE(?String3147:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,365,0,938),USE(?Line327:5),COLOR(COLOR:Black)
         LINE,AT(6667,365,0,938),USE(?Line327:6),COLOR(COLOR:Black)
         LINE,AT(7917,365,0,885),USE(?Line338:2),COLOR(COLOR:Black)
         LINE,AT(3802,365,0,885),USE(?Line326:2),COLOR(COLOR:Black)
         LINE,AT(938,365,0,885),USE(?Line325:2),COLOR(COLOR:Black)
         LINE,AT(417,365,0,885),USE(?Line324:2),COLOR(COLOR:Black)
         LINE,AT(104,365,0,885),USE(?Line323:2),COLOR(COLOR:Black)
       END
detail3 DETAIL,AT(,,,177),USE(?unnamed:37)
         STRING(@n3),AT(156,10,208,156),USE(NPK,,?NPK:3),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line329),COLOR(COLOR:Black)
         STRING(@d05.),AT(448,10,469,156),USE(GG_DATUMS,,?GGD3),RIGHT
         LINE,AT(938,-10,0,197),USE(?Line330),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_P,,?NP3),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line331),COLOR(COLOR:Black)
         STRING(@s13),AT(2938,10,833,156),USE(PAR_LVREGNR,,?LV3),LEFT
         LINE,AT(3802,-10,0,197),USE(?Line332:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line332),COLOR(COLOR:Black)
         STRING(@d05.),AT(3844,10,,156),USE(GG_dok_dat,,?DD3),RIGHT
         LINE,AT(4375,-10,0,197),USE(?Line332:3),COLOR(COLOR:Black)
         STRING(@s14),AT(4438,10,,156),USE(GG_DOK_SENR,,?DS3),LEFT
         LINE,AT(6667,-10,0,197),USE(?Line340),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(5448,10,573,156),USE(P:SUMMA[1],,?P:SUMMA_3:1),RIGHT
         STRING(@n-_12.2b),AT(6073,10,573,156),USE(P:SUMMA[2],,?P:SUMMA_3:2),RIGHT
         STRING(@n-_11.2b),AT(6698,10,573,156),USE(P:SUMMA[3],,?P:SUMMA_3:3),RIGHT
         STRING(@n-_11.2b),AT(7323,10,573,156),USE(P:SUMMA[4],,?P:SUMMA_3:4),RIGHT
         STRING(@n-_11.2b),AT(7948,52,573,156),USE(P:SUMMA[5],,?P:SUMMA_3:5),TRN,RIGHT
         STRING(@n-_11.2b),AT(8563,52,573,156),USE(P:SUMMA[6],,?P:SUMMA_3:6),TRN,RIGHT
         STRING(@n-_11.2b),AT(9188,52,573,156),USE(P:SUMMA[8],,?P:SUMMA_3:8),TRN,RIGHT
         STRING(@n-_11.2b),AT(9792,52,573,156),USE(P:SUMMA[9],,?P:SUMMA_3:9),TRN,RIGHT
         STRING(@n-_11.2b),AT(10531,52,573,156),USE(P:SUMMA[7],,?P:SUMMA_3:7),TRN,RIGHT
         LINE,AT(7292,-10,0,197),USE(?Line339),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,197),USE(?Line333),COLOR(COLOR:Black)
         LINE,AT(8542,0,0,197),USE(?Line333:5),COLOR(COLOR:Black)
         LINE,AT(9156,0,0,197),USE(?Line333:6),COLOR(COLOR:Black)
         LINE,AT(9771,0,0,197),USE(?Line333:7),COLOR(COLOR:Black)
         LINE,AT(10375,0,0,197),USE(?Line333:2),COLOR(COLOR:Black)
         LINE,AT(11198,0,0,197),USE(?Line333:4),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line341),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line328),COLOR(COLOR:Black)
       END
detail3K DETAIL,AT(,,,354),USE(?unnamed:35)
         LINE,AT(417,0,0,52),USE(?Line344),COLOR(COLOR:Black)
         LINE,AT(938,0,0,52),USE(?Line345),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,52),USE(?Line346),COLOR(COLOR:Black)
         LINE,AT(3802,0,0,313),USE(?Line347:3),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,313),USE(?Line347:6),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line347:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line347:44),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,313),USE(?Line347:5),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,313),USE(?Line347),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line347:2),COLOR(COLOR:Black)
         LINE,AT(8542,0,0,313),USE(?Line347:11),COLOR(COLOR:Black)
         LINE,AT(9156,0,0,313),USE(?Line347:12),COLOR(COLOR:Black)
         LINE,AT(9771,0,0,313),USE(?Line347:7),COLOR(COLOR:Black)
         LINE,AT(10375,0,0,313),USE(?Line347:10),COLOR(COLOR:Black)
         LINE,AT(11198,0,0,313),USE(?Line347:8),COLOR(COLOR:Black)
         LINE,AT(104,52,11146,0),USE(?Line31:18),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line343),COLOR(COLOR:Black)
         STRING('Kopâ par taksâcijas periodu:'),AT(417,104,1771,208),USE(?String3159),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(5448,104,573,156),USE(summaK[3,1]),RIGHT
         STRING(@n-_12.2b),AT(6073,104,573,156),USE(summaK[3,2]),RIGHT
         STRING(@n-_12.2b),AT(6698,104,573,156),USE(summaK[3,3]),RIGHT
         STRING(@n-_12.2b),AT(7323,104,573,156),USE(summaK[3,4]),RIGHT
         STRING(@n-_12.2b),AT(7938,104,573,156),USE(summaK[3,5]),TRN,RIGHT
         STRING(@n-_12.2b),AT(8563,104,573,156),USE(summaK[3,6]),TRN,RIGHT
         STRING(@n-_12.2b),AT(9188,104,573,156),USE(summaK[3,8]),TRN,RIGHT
         STRING(@n-_12.2b),AT(9802,104,573,156),USE(summaK[3,9]),TRN,RIGHT
         STRING(@n-_12.2b),AT(10542,104,573,156),USE(summaK[3,7]),TRN,RIGHT
         LINE,AT(104,313,11146,0),USE(?Line31:19),COLOR(COLOR:Black)
       END
detail4H DETAIL,AT(,,,1302),USE(?unnamed:49)
         STRING('4.  PAKALPOJUMU SAÒÇMÇJU SARAKSTS'),AT(1365,104,4948,208),USE(?String41:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('citâs ES valstîs'),AT(8094,406,885,156),USE(?String3147:23),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai treðajâs valstîs'),AT(7938,563,1146,156),USE(?String3147:83),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,365,10000,0),USE(?Line41:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,542,208,208),USE(?String4135),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,542,469,208),USE(?String4136),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partneris'),AT(1240,542,2188,208),USE(?String4137:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apl.pers.'),AT(2865,938,938,156),USE(?String4137:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3854,958,521,208),USE(?String4149:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(4427,958,990,208),USE(?String4149:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('muitas deklarâcija'),AT(3844,625,1563,208),USE(?String4143:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(5510,625,1094,156),USE(?String4147:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apliekamâm'),AT(5521,469,1094,156),USE(?String4147:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm (Ls)'),AT(6865,625,938,156),USE(?String4147:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noliktavâs (Ls)'),AT(9146,729,938,156),USE(?String4147:11),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(7938,927,573,156),USE(?String4149:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('neapliekamâm'),AT(6865,469,938,156),USE(?String4147:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un muitas'),AT(9219,573,781,156),USE(?String4147:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,885,9167,0),USE(?Line435:2),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(5469,1094,573,156),USE(?String4149),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6094,958,573,208),USE(?String4149:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(6719,1094,573,156),USE(?String4149:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(9250,990,573,156),USE(?String4149:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,885,0,365),USE(?Line436:8),COLOR(COLOR:Black)
         STRING('vçrtba'),AT(6719,938,573,156),USE(?String4149:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8521,938,0,365),USE(?Line436:2),COLOR(COLOR:Black)
         STRING('bez PVN'),AT(7938,1083,573,156),USE(?String4149:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(7344,990,573,156),USE(?String4149:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(8542,990,573,156),USE(?String4149:91),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtba'),AT(5469,938,573,156),USE(?String4149:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4375,885,0,417),USE(?Line436:6),COLOR(COLOR:Black)
         STRING('reìistrâc. Nr'),AT(2917,1094,885,156),USE(?String4137:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nosaukums'),AT(990,958,1875,208),USE(?String4137:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2865,885,0,365),USE(?Line436:5),COLOR(COLOR:Black)
         LINE,AT(104,1271,10000,0),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(9125,365,0,938),USE(?Line427:7),COLOR(COLOR:Black)
         STRING('brîvajâs zonâs'),AT(9156,417,885,156),USE(?String4147:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10094,365,0,885),USE(?Line427:8),COLOR(COLOR:Black)
         STRING('reìistrçtâm pers.'),AT(7938,719,1146,156),USE(?String3147:15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,885,0,417),USE(?Line436:7),COLOR(COLOR:Black)
         STRING('Pavadzme-rçíins vai'),AT(3854,469,1563,156),USE(?String4143:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,365,0,938),USE(?Line427:5),COLOR(COLOR:Black)
         LINE,AT(6667,365,0,938),USE(?Line427:6),COLOR(COLOR:Black)
         LINE,AT(7917,365,0,885),USE(?Line438:2),COLOR(COLOR:Black)
         LINE,AT(3802,365,0,885),USE(?Line426:2),COLOR(COLOR:Black)
         LINE,AT(938,365,0,885),USE(?Line425:2),COLOR(COLOR:Black)
         LINE,AT(417,365,0,885),USE(?Line424:2),COLOR(COLOR:Black)
         LINE,AT(104,365,0,885),USE(?Line423:2),COLOR(COLOR:Black)
       END
detail4 DETAIL,AT(,,,177),USE(?unnamed:47)
         STRING(@n3),AT(156,10,208,156),USE(NPK,,?NPK:4),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line429),COLOR(COLOR:Black)
         STRING(@d05.),AT(448,10,469,156),USE(GG_DATUMS,,?GG4),RIGHT
         LINE,AT(938,-10,0,197),USE(?Line430),COLOR(COLOR:Black)
         STRING(@s30),AT(990,10,1875,156),USE(PAR_NOS_P,,?NP4),LEFT
         LINE,AT(2865,-10,0,197),USE(?Line431),COLOR(COLOR:Black)
         STRING(@s13),AT(2938,10,833,156),USE(PAR_LVREGNR,,?LV4),LEFT
         LINE,AT(3802,-10,0,197),USE(?Line432:2),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,197),USE(?Line432),COLOR(COLOR:Black)
         STRING(@d05.),AT(3844,10,,156),USE(GG_dok_dat,,?DD4),RIGHT
         LINE,AT(4375,-10,0,197),USE(?Line432:3),COLOR(COLOR:Black)
         STRING(@s14),AT(4438,10,,156),USE(GG_DOK_SENR,,?DS4),LEFT
         LINE,AT(6667,-10,0,197),USE(?Line440),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(5448,10,573,156),USE(P:SUMMA[1],,?P:SUMMA_4:1),RIGHT
         STRING(@n-_12.2b),AT(6073,10,573,156),USE(P:SUMMA[2],,?P:SUMMA_4:2),RIGHT
         STRING(@n-_11.2b),AT(6698,10,573,156),USE(P:SUMMA[5],,?P:SUMMA_4:5),RIGHT
         STRING(@n-_11.2b),AT(7323,10,573,156),USE(P:SUMMA[6],,?P:SUMMA_4:6),RIGHT
         STRING(@n-_11.2b),AT(7938,10,573,156),USE(P:SUMMA[8],,?P:SUMMA_4:8),TRN,RIGHT
         STRING(@n-_11.2b),AT(8542,10,573,156),USE(P:SUMMA[9],,?P:SUMMA_4:9),TRN,RIGHT
         STRING(@n-_11.2b),AT(9333,10,573,156),USE(P:SUMMA[7],,?P:SUMMA_4:7),TRN,RIGHT
         LINE,AT(7292,-10,0,197),USE(?Line439),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,197),USE(?Line433),COLOR(COLOR:Black)
         LINE,AT(0,0,0,197),USE(?Line433:4),COLOR(COLOR:Black)
         LINE,AT(8521,0,0,197),USE(?Line433:2),COLOR(COLOR:Black)
         LINE,AT(9125,0,0,197),USE(?Line433:6),COLOR(COLOR:Black)
         LINE,AT(10094,0,0,197),USE(?Line433:5),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,197),USE(?Line441),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,197),USE(?Line428),COLOR(COLOR:Black)
       END
detail4K DETAIL,AT(,,,354),USE(?unnamed:45)
         LINE,AT(417,0,0,52),USE(?Line444),COLOR(COLOR:Black)
         LINE,AT(938,0,0,52),USE(?Line445),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,52),USE(?Line446),COLOR(COLOR:Black)
         LINE,AT(3802,0,0,313),USE(?Line447:3),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,313),USE(?Line447:6),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line447:4),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line447:44),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,313),USE(?Line447:5),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,313),USE(?Line447),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line447:2),COLOR(COLOR:Black)
         LINE,AT(8521,0,0,313),USE(?Line447:7),COLOR(COLOR:Black)
         LINE,AT(9125,0,0,313),USE(?Line447:9),COLOR(COLOR:Black)
         LINE,AT(10094,0,0,313),USE(?Line447:8),COLOR(COLOR:Black)
         LINE,AT(104,52,10000,0),USE(?Line41:18),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line443),COLOR(COLOR:Black)
         STRING('Kopâ par taksâcijas periodu:'),AT(417,104,1771,208),USE(?String4159),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2b),AT(5448,104,573,156),USE(summaK[4,1]),RIGHT
         STRING(@n-_12.2b),AT(6073,104,573,156),USE(summaK[4,2]),RIGHT
         STRING(@n-_12.2b),AT(6698,104,573,156),USE(summaK[4,5]),RIGHT
         STRING(@n-_12.2b),AT(7323,104,573,156),USE(summaK[4,6]),RIGHT
         STRING(@n-_12.2b),AT(7938,104,573,156),USE(summaK[4,8]),TRN,RIGHT
         STRING(@n-_12.2b),AT(8542,104,573,156),USE(summaK[4,9]),TRN,RIGHT
         STRING(@n-_12.2b),AT(9323,104,573,156),USE(summaK[4,7]),TRN,RIGHT
         LINE,AT(104,313,10000,0),USE(?Line41:19),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,510),USE(?unnamed:44)
         STRING(@s25),AT(729,104,1667,208),USE(SYS:AMATS1),RIGHT
         LINE,AT(2438,323,2448,0),USE(?Line22),COLOR(COLOR:Black)
         STRING(@s25),AT(2802,344,1719,156),USE(sys:paraksts1),CENTER
         STRING(@d06.),AT(1052,302,677,208),USE(VID_datums),RIGHT,FONT(,8,,,CHARSET:ANSI)
         STRING('Datums:'),AT(510,302,417,208),USE(?String82:4),RIGHT
         STRING(@S1),AT(52,0),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(200,7800,12000,177),USE(?unnamed:6)
         LINE,AT(104,0,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
         STRING(@PLapa<<<#/______P),AT(9500,10),PAGENO,USE(?PageCount),RIGHT
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
!
! F:DTK='1'-1.DAÏA,'2'-OTRÂ DAÏA
! Netiek aizpildîtas :    (06.02.2007.)
!   R104  R72
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
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('KKK',KKK)
  BIND('CYCLEBKK',CYCLEBKK)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN Pielikums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      VID_DATUMS=TODAY()
      CG = 'K1000'
      IF F:XML THEN E='E' ELSE E=''.
      MENESIS=MENVAR(B_DAT,2,2)

      CLEAR(ggk:RECORD)
      GGK:DATUMS=S_DAT
      SET(ggk:DAT_key,GGK:DAT_key)
      Process:View{Prop:Filter} = '(~CYCLEGGK(CG) AND ~(GGK:U_NR=1)' !23/03/2004
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
      IF F:DTK='1'
         OPEN(report1)
         report1{Prop:Preview} = PrintPreviewImage
      ELSIF F:DTK='2'
         OPEN(report2)
         report2{Prop:Preview} = PrintPreviewImage
         IF F:XML
           XMLFILENAME=USERFOLDER&'\PVN_K_DAR_2007.DUF'
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
              XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
              ADD(OUTFILEXML)
              XML:LINE='<<DeclarationFile type="pvn_k_dar_2007">'
              ADD(OUTFILEXML)
              XML:LINE='<<Declaration>'
              ADD(OUTFILEXML)
           .
         .
      ELSE
         STOP('F:DTK='&F:DTK)
         DO PROCEDURERETURN
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!-------------analizçjam PVN kontu-----------------
        CLEAR(P:SUMMA)
        IF GGK:BKK=KKK
           ADDTABLE#=TRUE
           CASE GGK:D_K
           OF 'D'                                       !************************ IEGÂDÂTI KM, SAMAKSÂTS PVN ********
             IF INSTRING(GGK:PVN_TIPS,'2348') AND GGK:PVN_PROC=0
                KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' PVN%=0')
                GGK:PVN_PROC=18 !LAI BÛTU...
             .
             P:SADALA=1
             CASE GGK:PVN_TIPS
             OF '1'                                   ! P4=1 budþetam
             OF '2'                                   ! P4=2 IMPORTS(+MUITAS NOLIKTAVAS 06.02.2007)
               R64+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R11+=GGK:SUMMA  !06.02.2007.
               P:SUMMA[6]=(GGK:SUMMA*100)/GGK:PVN_PROC !?
             OF '3'                                   ! IEPIRKTS VAIRUMÂ
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R61+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R101 +=GGK:SUMMA
                  P:SUMMA[1]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[2]=GGK:SUMMA
               ELSE                                   ! NAV PVN MAKSÂTÂJS
!                  R63+=(GGK:SUMMA*100)/GGK:PVN_PROC  ! PVN NEMAZ NAV, JÂNORÂDA RK KONTU PLÂNÂ
               .
             OF '4'                                   ! IEPIRKTS MAZUMÂ
               R62+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R11+=GGK:SUMMA    !06.02.2007
               P:SUMMA[3]=(GGK:SUMMA*100)/GGK:PVN_PROC
               P:SUMMA[4]=GGK:SUMMA
             OF '8'                                   ! SAÒEMTI PAKALPOJUMI
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R71+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R105 +=GGK:SUMMA !104->105
                  P:SADALA=2
                  P:SUMMA[1]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[2]=GGK:SUMMA
               ELSE
!                  R72+=(GGK:SUMMA*100)/GGK:PVN_PROC  !NORÂDA RK KONTU PLÂNÂ
               .
             ELSE                                     !
               ADDTABLE#=FALSE
                 .
           OF 'K'                                     !************************ REALIZÇTI KM, SAÒEMTS PVN ********
             IF INSTRING(GGK:PVN_TIPS,'569') AND GGK:PVN_PROC=0
                KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' PVN%=0')
                GGK:PVN_PROC=18 !LAI BÛTU...
             .
             P:SADALA=3
             CASE GGK:PVN_TIPS
             OF '1'                                   ! P4=1 budþetam
             OF '2'                                   ! P4=2 EKSPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6)&' Eksports?')
             OF '5'                                   ! REALIZÇTS VAIRUMÂ
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R41+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[1]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[2]=GGK:SUMMA
               ELSE                                   ! NAV PVN MAKSÂTÂJS
                  R43+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R103+=GGK:SUMMA
                  P:SUMMA[5]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[6]=GGK:SUMMA
               .
             OF '6'                                   ! REALIZÇTS MAZUMÂ
               R42+=(GGK:SUMMA*100)/GGK:PVN_PROC
               R102+=GGK:SUMMA
               P:SUMMA[3]=(GGK:SUMMA*100)/GGK:PVN_PROC
               P:SUMMA[4]=GGK:SUMMA
             OF '9'                                   ! REALIZÇTI PAKALPOJUMI
               P:SADALA=4
               IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
                  R51+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[1]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[2]=GGK:SUMMA
               ELSE                                   ! NAV PVN MAKSÂTÂJS
                  R52+=(GGK:SUMMA*100)/GGK:PVN_PROC
                  R106+=GGK:SUMMA  !105->106
                  P:SUMMA[3]=(GGK:SUMMA*100)/GGK:PVN_PROC
                  P:SUMMA[4]=GGK:SUMMA
               .
             ELSE
               ADDTABLE#=FALSE
             .
           .
           IF ADDTABLE# = TRUE
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              ADD(P_TABLE)
           .
!--------------REALIZÂCIJA BEZ PVN------------------
        ELSIF GGK:BKK[1]='6' AND GGK:D_K='K'
           P:SADALA=3
           C#=GETKON_K(GGK:BKK,2,1)
           FOUND#=FALSE
           P:SADALA=3
           LOOP R#=1 TO 2
              CASE KON:PVNK[R#]       ! Neapliekamie KOKU darîjumi
              OF 44
                 R44+= GGK:SUMMA
                 FOUND#=TRUE
                 P:SUMMA[8]=GGK:SUMMA
                 P:SUMMA[9]=GGK:SUMMA*GGK:PVN_PROC/100
              OF 45
                 R45+= GGK:SUMMA
                 FOUND#=TRUE
                 P:SUMMA[7]=GGK:SUMMA
              OF 53                   !SNIEGTIE PAKALPOJUMI
                 R53+= GGK:SUMMA
                 FOUND#=TRUE
                 P:SADALA=4
                 P:SUMMA[8]=GGK:SUMMA
                 P:SUMMA[9]=GGK:SUMMA*GGK:PVN_PROC/100
              OF 54                   !SNIEGTIE PAKALPOJUMI
                 R54+= GGK:SUMMA
                 FOUND#=TRUE
                 P:SADALA=4
                 P:SUMMA[7]=GGK:SUMMA
              .
           .
           IF FOUND#=TRUE
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              ADD(P_TABLE)
           .
!--------------SAÒEMTI KOKI UN PAKALPOJUMI BEZ PVN------------------
        ELSIF (GGK:BKK[1]='7' OR GGK:BKK[1:2]='21') AND GGK:D_K='D'
           P:SADALA=1
           C#=GETKON_K(GGK:BKK,2,1)
           FOUND#=FALSE
           P:SADALA=1
           LOOP R#=1 TO 2
              CASE KON:PVNK[R#]       !no neapliekamâm personâm
              OF 63                   !KOKMATERIÂLI
                 R63+= GGK:SUMMA
                 FOUND#=TRUE
                 P:SUMMA[5]=GGK:SUMMA
              OF 64                   !NOLIKTS MUITAS ZONÂ
                 R64+= GGK:SUMMA      !06.02.2007.
                 FOUND#=TRUE
                 P:SUMMA[7]=GGK:SUMMA
              OF 72
                 R72+= GGK:SUMMA      !PAKALPOJUMI NO NEAPL PERS
                 FOUND#=TRUE
                 P:SADALA=2
                 P:SUMMA[5]=GGK:SUMMA
              .
           .
           IF FOUND#=TRUE
              P:DATUMS=GGK:DATUMS
              P:PAR_NR=GGK:PAR_NR
              G#=GETGG(GGK:U_NR)
              P:DOK_DAT=GG:DOKDAT
              P:DOK_SENR=GG:DOK_SENR
              P:ATT_DOK=GG:ATT_DOK
              ADD(P_TABLE)
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
     R4 =R41+R42+R43+R44
     R5 =R51+R52
!     R6 =R61+R62+R63+R64+R65
     R6 =R61+R62+R63+R64  !06.02.2007
     R7 =R71+R72
     R8 =0
     R9 =0
     R10=R101+R102+R103+R105+R106 !104,5->105,6
!     R11=R111+R112  06.02.2007.
     R12=0
     R13=R101+R105+R11-R12 !06.02.2007.
     R14=R10-R13
     IF F:DTK='1'
        PRINT(RPT1:DETAIL)
        PRINT(RPT1:FOOTER)
     ELSIF F:DTK='2'  !-----------------II DAÏA---------------------------
        SORT(P_TABLE,P:SADALA)
        LOOP I#=1 TO RECORDS(P_TABLE)
           GET(P_TABLE,I#)
           LOOP J#= 1 TO 9
              SUMMAK[P:SADALA,J#]+=P:SUMMA[J#]
           .
        .
        PRINT(RPT2:CEPURE)
        IF F:XML_OK#=TRUE
           XML:LINE='<<DeclarationHeader>'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="taks_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods lîdz '&FORMAT(B_DAT,@D06.)&',ðodien '&FORMAT(TODAY(),@D06.)).
           XML:LINE='<<Field name="taks_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_apl_bezpvn" value="'&CUT0(SUMMAK[1,1],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_apl_pvn" value="'&CUT0(SUMMAK[1,2],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_maz_bezpvn" value="'&CUT0(SUMMAK[1,3],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_maz_pvn" value="'&CUT0(SUMMAK[1,4],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_neap" value="'&CUT0(SUMMAK[1,5],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum1_sez" value="'&CUT0(SUMMAK[1,7],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum2_apl_bezpvn" value="'&CUT0(SUMMAK[2,1],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum2_apl_pvn" value="'&CUT0(SUMMAK[2,2],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum2_neap" value="'&CUT0(SUMMAK[2,5],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum2_sez" value="'&CUT0(SUMMAK[2,7],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_apl_bezpvn" value="'&CUT0(SUMMAK[3,1],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_apl_pvn" value="'&CUT0(SUMMAK[3,2],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_maz_bezpvn" value="'&CUT0(SUMMAK[3,3],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_maz_pvn" value="'&CUT0(SUMMAK[3,4],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_neap_bezpvn" value="'&CUT0(SUMMAK[3,5],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_neap_pvn" value="'&CUT0(SUMMAK[3,6],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_es_bezpvn" value="'&CUT0(SUMMAK[3,8],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_es_pvn" value="'&CUT0(SUMMAK[3,9],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum3_sez" value="'&CUT0(SUMMAK[3,7],2,2,1,1)&'" />'  !9
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_apl_bezpvn" value="'&CUT0(SUMMAK[4,1],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_apl_pvn" value="'&CUT0(SUMMAK[4,2],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_neap_bezpvn" value="'&CUT0(SUMMAK[4,5],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_neap_pvn" value="'&CUT0(SUMMAK[4,6],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_es_bezpvn" value="'&CUT0(SUMMAK[4,8],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_es_pvn" value="'&CUT0(SUMMAK[4,9],2,2,1,1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sum4_sez" value="'&CUT0(SUMMAK[4,7],2,2,1,1)&'" />'  !7
           ADD(OUTFILEXML)
           XML:LINE='<</DeclarationHeader>'
           ADD(OUTFILEXML)
        .
        LOOP S#=1 TO 4   !4 SADAÏAS
           EXECUTE S#
               PRINT(RPT2:DETAIL1H)
               PRINT(RPT2:DETAIL2H)
               PRINT(RPT2:DETAIL3H)
               PRINT(RPT2:DETAIL4H)
           .
           NPK=0
           LOOP I#=1 TO RECORDS(P_TABLE)
              GET(P_TABLE,I#)
              IF ~(P:SADALA=S#) THEN CYCLE.
              NPK+=1
              GG_DATUMS=P:DATUMS
              GG_DOK_DAT=P:DOK_DAT
              GG_DOK_SENR=P:DOK_SENR
              GG_DOK_SE=GETDOK_SENR(1,P:DOK_SENR,,P:ATT_DOK)
              GG_DOK_NR=GETDOK_SENR(2,P:DOK_SENR,,P:ATT_DOK)
              TEKSTS = GETPAR_K(P:PAR_NR,0,2)
              FORMAT_TEKSTS(47,'Arial',8,'')
              PAR_NOS_P = F_TEKSTS[1]
              PAR_LVREGNR=GETPAR_K(P:PAR_NR,0,8) ! LV&11z
              PAR_REGNR=GETPAR_K(P:PAR_NR,0,12)  ! PAR_KODS
              EXECUTE S#
                 PRINT(RPT2:DETAIL1)
                 PRINT(RPT2:DETAIL2)
                 PRINT(RPT2:DETAIL3)
                 PRINT(RPT2:DETAIL4)
              .
!              IF F_TEKSTS[2]
!                 PAR_NOS_PP=F_TEKSTS[2]
!                 PRINT(RPT2:DETAIL1P)
!              .
!              IF F_TEKSTS[3]
!                 PAR_NOS_PP=F_TEKSTS[3]
!                 PRINT(RPT2:DETAIL1P)
!              .
              IF F:XML_OK#=TRUE
                 XML:LINE='<<Row>'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="pielikuma_nr" value="'&S#&'" />'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="rindas_nr" value="'&NPK&'" />'
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="datums" value="'&FORMAT(GG_DATUMS,@D06.)&'" />'
                 ADD(OUTFILEXML)
                 IF ~PAR_REGNR THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z
                 XML:LINE='<<Field name="nmr_kods_dp" value="'&CLIP(PAR_REGNR)&'" />'
                 ADD(OUTFILEXML)
                 TEX:DUF=CLIP(TEKSTS) !PAR:NOS_P
                 DO CONVERT_TEX:DUF
                 XML:LINE='<<Field name="isais_nosauk_dp" value="'&CLIP(TEX:DUF)&'" />' !max 120z
                 ADD(OUTFILEXML)
                 XML:LINE='<<Field name="datums_dok" value="'&FORMAT(GG_DOK_DAT,@D06.)&'" />'
                 ADD(OUTFILEXML)
                 IF GG_DOK_SE
                    XML:LINE='<<Field name="dok_ser" value="'&clip(GG_DOK_SE)&'" />'
                    ADD(OUTFILEXML)
                 .
                 XML:LINE='<<Field name="dok_nr" value="'&clip(GG_DOK_NR)&'" />'
                 ADD(OUTFILEXML)
                 LOOP K# = 1 TO 9
                    IF P:SUMMA[K#]
                       EXECUTE K#
                          XML:LINE='<<Field name="apl_bezpvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'
                          XML:LINE='<<Field name="apl_pvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'
                          XML:LINE='<<Field name="maz_bezpvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'
                          XML:LINE='<<Field name="maz_pvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'
                          XML:LINE='<<Field name="neap_bezpvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'
                          XML:LINE='<<Field name="neap_pvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'     !6
                          XML:LINE='<<Field name="sez_vert" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'     !7
                          XML:LINE='<<Field name="es_bezpvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'    !8
                          XML:LINE='<<Field name="es_pvn" value="'&CUT0(P:SUMMA[K#],2,2,1,1)&'" />'       !9
                       .
                       ADD(OUTFILEXML)
                    .
                 .
                 XML:LINE='<</Row>'
                 ADD(OUTFILEXML)
              .
           .
           EXECUTE S#
               PRINT(RPT2:DETAIL1K)
               PRINT(RPT2:DETAIL2K)
               PRINT(RPT2:DETAIL3K)
               PRINT(RPT2:DETAIL4K)
           .
        .
        PRINT(RPT2:FOOTER)
        IF F:XML_OK#=TRUE
          XML:LINE='<</Declaration>'
          ADD(OUTFILEXML)
          XML:LINE='<</DeclarationFile>'
          ADD(OUTFILEXML)
        .
     .
     IF F:DTK='1'
       ENDPAGE(report1)
     ELSE
       ENDPAGE(report2)
     .
     CLOSE(ProgressWindow)
     RP
     IF Globalresponse = RequestCompleted
       loop J#=1 to PR:SKAITS
          IF F:DTK='1'
             report1{Prop:FlushPreview} = True
          ELSE
             report2{Prop:FlushPreview} = True
          .
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
  IF F:DTK='1'
     CLOSE(report1)
  ELSE
     CLOSE(report2)
  .
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
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



RW_SER_TXT           PROCEDURE (OPC)              ! Declare Procedure
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

ToScreen WINDOW('Apmaiòas TXT faila sagatavoðana'),AT(,,185,133),GRAY
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

 CASE OPC
 OF 1 !****************************RAKSTÎT************************************
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

   ANSIFILENAME=DISKS&'ASE'&FORMAT(TODAY(),@D11)&'.TXT'
   REMOVE(OUTFILEANSI)
   IF ERRORCODE() AND ~(ERRORCODE()=2) !2- ~FOUND
      KLUDA(1,FILENAME1)
      DO PROCEDURERETURN
   .
   CHECKOPEN(OUTFILEANSI,1)
   CHECKOPEN(AUTOAPK,1)

   IF IZVELETO=FALSE
      CLEAR(APK:RECORD)
      APK:DATUMS=SAK_DAT
      SET(APK:DAT_KEY,APK:DAT_KEY)
   ELSE
      DISPLAY
      APK:PAV_NR=PAV:U_NR
      GET(AUTOAPK,APK:PAV_KEY)
   .
   LOOP
      IF IZVELETO=FALSE
         PREVIOUS(AUTOAPK)
         IF ERROR() OR APK:DATUMS > BEI_DAT THEN BREAK.
         PAV:U_NR=APK:PAV_NR
         GET(PAVAD,PAV:NR_KEY)
!         I#=GETGG(GGK:U_NR)
      .
      OUTA:LINE='01:'&PAV:REK_NR
      ADD(OUTFILEANSI)
      OUTA:LINE='02:'&GETAUTO(PAV:VED_NR,9)
      ADD(OUTFILEANSI)
      OUTA:LINE='03:'&GETAUTO(PAV:VED_NR,6)
      ADD(OUTFILEANSI)
      OUTA:LINE='04:'&GETPAR_K(PAV:PAR_NR,0,2)
      ADD(OUTFILEANSI)
      OUTA:LINE='05:'&PAR:KARTE
      ADD(OUTFILEANSI)
      OUTA:LINE='06:'&PAR:ADRESE
      ADD(OUTFILEANSI)
      OUTA:LINE='07:'&clip(AUT:TELEFONS)&' '&AUT:VADITAJS
      ADD(OUTFILEANSI)
      OUTA:LINE='08:'&APK:NOBRAUKUMS
      ADD(OUTFILEANSI)
      OUTA:LINE='09:'&AUT:VIRSB_NR
      ADD(OUTFILEANSI)
      OUTA:LINE='10:'&FORMAT(PAV:DATUMS,@D06.)
      ADD(OUTFILEANSI)
      IF INRANGE(PAV:PAR_NR,1,50)
         OUTA:LINE='11:IEKÐÇJAIS PASÛTÎJUMS'
         ADD(OUTFILEANSI)
      ELSIF INSTRING(PAV:APM_K,'45')
         OUTA:LINE='11:GARANTIJA'
         ADD(OUTFILEANSI)
      ELSE
         OUTA:LINE='11:KLIENTA PASÛTÎJUMS'
         ADD(OUTFILEANSI)
      .
      OUTA:LINE=' '
      ADD(OUTFILEANSI)

      DOK_SK+=1
      DISPLAY
!      GG:KEKSIS=2  !STATUSS::NOEXPORTÇTS
!      IF RIUPDATE:GG()
!         KLUDA(24,'GG')
!      .
      IF IZVELETO=TRUE
         BREAK
      .
   .
   IF DISKETE=TRUE   !FLAÐS
      UNHIDE(?STRINGDISKETE)
      DISPLAY
      CLOSE(OUTFILEANSI)
      FILENAME1=ANSIFILENAME
      FILENAME2='E:\ASE'&FORMAT(TODAY(),@D11)&'.TXT'
      IF ~CopyFileA(FILENAME1,FILENAME2,0)
         KLUDA(3,FILENAME1&' uz '&FILENAME2)
      .
   .
   CLOSE(TOSCREEN)
   CLOSE(ReadScreen)
   CLOSE(AUTOAPK)
   CLOSE(AUTO)
   PAR_K::USED-=1
   IF PAR_K::USED=0
      CLOSE(PAR_K)
   .
 .
 DO PROCEDURERETURN
!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
   CLOSE(OUTFILEANSI)
   KLUDA(0,'KOPÂ: '&clip(DOK_SK)&' dokumenti ',,1)
   IF ~DOK_SK
      GLOBALRESPONSE=REQUESTCANCELLED
   ELSE
      GLOBALRESPONSE=REQUESTCOMPLETED
   .
   RETURN

