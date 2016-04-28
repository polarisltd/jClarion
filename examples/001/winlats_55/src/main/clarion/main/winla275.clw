                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_PIE_2011       PROCEDURE                    ! Declare Procedure
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
PER                  BYTE
PAR_NOS_P            STRING(35)
GGTEX                STRING(60)
GG_DOK_SE            STRING(7)
GG_DOK_NR            STRING(14)
GG_DOKDAT            LIKE(GG:DOKDAT)
PERS_KODS            STRING(22)
RINDA3               STRING(4)
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
SUMMA_PEC_KL         DECIMAL(12,2)
SUMMA_PEC_DOK        DECIMAL(12,2)

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
KEY             STRING(16) !Elya 18.08.2013
U_NR            ULONG
NOS_P           STRING(15)
PAR_TIPS        STRING(1)
D_K             STRING(1)
SADALA          BYTE
DATUMS          LONG
PAR_NR          ULONG
PVNS            DECIMAL(12,2),DIM(20,2) !18/5/18I/5I/12/21/10/22/12/21I/22I/10I/12I/21IN/22IN/10IN/12IN
SUMMA           DECIMAL(12,2)
RINDA           STRING(4)
VAL             STRING(3)
PVN_TIPS        STRING(1)
PAR_PVN         LIKE(PAR:PVN)
             .

C_TABLE      QUEUE,PRE(C)
U_NR            ULONG
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KK_TABLE      QUEUE,PRE(KK)
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

K_TABLE      QUEUE,PRE(K)
PAR_NR          ULONG
PVN             DECIMAL(12,2)
SUMMA           DECIMAL(12,2)
            .

CPR_TABLE      QUEUE,PRE(CPR)
U_NR            ULONG
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KKPR_TABLE      QUEUE,PRE(KKPR)
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KPR_TABLE      QUEUE,PRE(KPR)
PAR_NR          ULONG
PVN             DECIMAL(12,2)
SUMMA           DECIMAL(12,2)
DV              STRING(4)
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
DV              STRING(2)
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
D1_Head DETAIL,AT(10,,11979,1698),USE(?unnamed:4)
         STRING('R3-bûvniecîbas pak.,V-darîj. ar vienu partneri << 1000Ls, par kop.summu >1000Ls D' &|
             'ok.veids: 1-nod.rçí. 2-kases èeks, 3-bezskaidr.naud.maksâj.dok., 4-kredîtrçí., 5' &|
             '-cits, 6-muitas dekl.'),AT(104,604),USE(?String156:2),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('I.Priekðnodoklis par iekðzemç iegâdâtajâm precçm un saòemtajiem pakalpojumiem'),AT(1667,21,6208,208), |
             USE(?String211:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9135,42,313,313),USE(E,,?E:2),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,146,958,208),USE(EE1,,?EE1:2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('Darîj.veids: I-imports A-darîj.ar apliek. pers. N-darîj. partn. nav PVN reì.Nr K' &|
             '-lauks. izmaks. kompens. T-darîj. zem Ls 1000 Z-zaud. parâdi R1-darîj. ar kokmat' &|
             '. R2-darîj. ar metâllûþòiem,'),AT(104,438),USE(?String156),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('kuru kopçjâ vçrtîba bez PVN ir'),AT(2240,198,1875,208),USE(?String1:2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4167,198,2292,208),USE(StringLimitSumma),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(7844,21),USE(PRECIZETA),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera nosaukums'),AT(688,979,1979,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2875,865,1146,156),USE(?String1:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2854,1021,1146,156),USE(?String1:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumu'),AT(4583,979,833,156),USE(?String1:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîj.'),AT(4125,948,396,156),USE(?String1:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2854,1177,1146,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(4583,1281,833,156),USE(?String1:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta veids'),AT(6635,1260,1302,156),USE(?String1:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs'),AT(8417,1271,990,156),USE(?String134:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(9458,1271,990,156),USE(?String145:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9427,1281,0,417),USE(?Line2:34),COLOR(COLOR:Black)
         LINE,AT(8385,1281,0,417),USE(?Line2:33),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(4583,1135,833,156),USE(?String1:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veids'),AT(4125,1125,396,156),USE(?String1:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6354,1250,4115,0),USE(?Line55:3),COLOR(COLOR:Black)
         LINE,AT(104,813,10365,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2771,813,0,885),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4083,813,0,885),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(104,1438,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,1479,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,1479,2146,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,1479,1094,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4938,1479,260,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5781,1490,313,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7042,1490,719,156),USE(?String3:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(8438,1490,938,156),USE(?String93:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(9531,1490,938,156),USE(?String134:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4198,1469,260,156),USE(?String3:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojuma dokuments'),AT(7510,948,1938,156),USE(?String1:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(135,969,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,813,0,885),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6344,813,0,885),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10469,813,0,885),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4542,813,0,885),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(5542,969,760,156),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5448,813,0,885),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Preèu vai'),AT(4583,823,833,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,813,0,885),USE(?Line2),COLOR(COLOR:Black)
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
         STRING(@s2),AT(4208,52,208,156),USE(DV),TRN,CENTER
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
         STRING(@s1),AT(9135,167,313,313),USE(E,,?E:3),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('II. Priekðnodoklis par precçm un pakalpojumiem, kas saòemti no Eiropas Savienîba' &|
             's dalîbvalstîm'),AT(1521,104,7167,208),USE(?String2211:2),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,281,958,208),USE(EE2),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('G-prece, P-pakalpojumi'),AT(4177,323,2240,167),USE(?String23:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9073,52),USE(PRECIZETA,,?PRECIZETA:2),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
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
         STRING(@s1),AT(4365,52,240,156),USE(DV,,?DV:2),TRN,CENTER
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
         STRING(@s1),AT(9135,115,313,313),USE(E,,?E:32),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(7271,125),USE(PRECIZETA,,?PRECIZETA:3),TRN,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(9479,177,958,208),USE(EE3),TRN,LEFT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('Dok.veids: 1-nodokïa rçíins. 2-kases èeks, 3-bezskaidr.naud.maksâj.dok., 5-cits,' &|
             ' T-darîj. zem Ls 1000,V-darîj. ar vienu partneri << 1000Ls, par kop.summu >1000Ls' &|
             ', X-ats.neuzr.>1000Ls'),AT(94,354,10396,146),USE(?String1:32),FONT(,,,FONT:bold,CHARSET:BALTIC)
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
         STRING(@n-_11.2B),AT(5531,52,740,156),USE(pvn_summa,,?pvn_summa3),RIGHT
         STRING(@s30),AT(6490,52,1875,156),USE(ATTDOK,,?ATTDOK:2),LEFT
         STRING(@S14),AT(8417,52,980,156),USE(GG_DOK_NR,,?GG_DOK_NR3),CENTER
         STRING(@D06.B),AT(9635,52,615,156),USE(GG_DOKDAT,,?GG_DOKDAT3)
         STRING(@s4),AT(4146,52,365,146),USE(RINDA3),TRN,CENTER
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

  CODE                                            ! Begin processed code
!
! Tiek izsaukts tikai, ja GGK:DATUMS>2009
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
!R:PVNS[18] PVN_TIPS=3,4 KOKI(PÇRKAM)
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

  IF F:IDP THEN PRECIZETA='Precizçtâ'.
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
         DRINDA# = ''
         !STOP('==='&GGK:BKK&'==='&R:PAR_NR&' '&GGK:SUMMA)
         IF CYCLEBKK(GGK:BKK,KKK) AND GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))  !NAV PVN KONTS!IR DEFIN?TI NEAPL. DAR?JUMI
            !STOP('***'&KKK1&'==='&GGK:BKK&R:PAR_NR&'R='&R:RINDA&' '&GGK:SUMMA&' '&GGK:D_K)
            irRinda43# = 0
            LOOP R#=1 TO 2
               IF KON:PVND[R#] = 44 OR KON:PVND[R#] = 411 OR KON:PVND[R#] = 482 OR KON:PVND[R#] = 43
                  DRINDA# = '4*'
                  IF KON:PVND[R#] = 43
                     irRinda43# = 1
                  .
               .
            .
            IF R:RINDA = '' AND irRinda43# = 1
               DRINDA# = '4*'
            .
            IF DRINDA# = ''
               GOTO NEXTROW
               !neiet pvn1.3
            .
            ! 10.12.2012 avansa ieskaitisana vai nakamo perioda ienemumu slegsana
            IF DRINDA# = '4*' AND (~GGK:BKK[1:2]='57') AND GGK:BKK[1]='5' AND GGK:D_K='D'
                GOTO NEXTROW
               !neiet pvn1.3
            .
         .

         IF ~CYCLEBKK(GGK:BKK,KKK)  OR (~DRINDA# = '')       ! *****************************************IR PVN KONTS
            !26/05/2015 IF INSTRING(GGK:PVN_TIPS,' 024NIPAZ') OR (~DRINDA# = '') OR (INSTRING(GGK:PVN_TIPS,'38KMB') AND GGK:D_K='D') !no reversa nem tikai Debets
            IF INSTRING(GGK:PVN_TIPS,' 024NIPAZER') OR (~DRINDA# = '') OR (INSTRING(GGK:PVN_TIPS,'38KMB') AND GGK:D_K='D') !no reversa nem tikai Debets
               R:U_NR=GGK:U_NR
               R:D_K=GGK:D_K                
               GGK_SUMMAV=GGK:SUMMAV
               GGK_SUMMA=GGK:SUMMA
               R:RINDA=''
               IF (GGK:D_K='K' AND (GGK:PVN_TIPS='A' OR GGK:PVN_TIPS='4'))   ! K+PVN_TIPS=A MÇS ATGRIEÞAM PRECI R57
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
               IF R:D_K='D'
                  R:SADALA=1
               ELSE
                  R:SADALA=3
               .
               !Elya 18.08.2013 <
               IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                  R:RINDA = ''
                  irRinda43# = 0
                  LOOP R#=1 TO 2
                    IF KON:PVND[R#] = 44
                       R:RINDA='44'      ! SEZ
                    ELSIF KON:PVND[R#] = 411
                       R:RINDA='41.1'
                       IF ~INSTRING(GGK:PVN_TIPS,'38KMB')
                          R:PVN_TIPS = 'K'
                       ELSE
                          R:PVN_TIPS = GGK:PVN_TIPS
                       .
                    ELSIF KON:PVND[R#] = 482
                       R:RINDA='48.2'
                    ELSIF KON:PVND[R#] = 43
                       irRinda43# = 1
                    .
                  .
                  IF R:RINDA = '' AND irRinda43# = 1
                     R:RINDA='43'
                  .
               ELSE
                  R:RINDA = ''
                  IF GGK:PVN_TIPS='I'
                     R:RINDA = ''
                  ELSE
                     CASE GGK:PVN_PROC
                     OF 10
                        R:RINDA='42'
                     OF 12
                        R:RINDA='42'
                     OF 21
                        R:RINDA='41'
                     OF 22
                        IF INSTRING(GGK:PVN_TIPS,'KMB')
                        ELSE
                           R:RINDA='41'
                        .
                     .
                  .
               .              
               R:KEY=CLIP(R:U_NR)&R:D_K&CLIP(R:RINDA)&CLIP(GGK:PVN_TIPS)
               GET(R_TABLE,R:KEY)
               IF ~ERROR()
                  IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                     R:SUMMA+=GGK:SUMMA !6-T?S GRUPAS SUMMA 
                  ELSE
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
                        IF R:PAR_PVN
                           R:PVNS[12,1]+=GGK_SUMMAV
                           R:PVNS[12,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[16,1]+=GGK_SUMMAV
                           R:PVNS[16,2]+=GGK_SUMMA
                        .
                     ELSE
                        R:RINDA='42'
                        R:PVNS[7,1]+=GGK_SUMMAV
                        R:PVNS[7,2]+=GGK_SUMMA
                     .
                  OF 12
                     IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[13,1]+=GGK_SUMMAV
                           R:PVNS[13,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[17,1]+=GGK_SUMMAV
                           R:PVNS[17,2]+=GGK_SUMMA
                        .
                     ELSE
                       R:RINDA='42'
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
                        IF R:PAR_PVN
                           R:PVNS[10,1]+=GGK_SUMMAV
                           R:PVNS[10,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[14,1]+=GGK_SUMMAV
                           R:PVNS[14,2]+=GGK_SUMMA
                        .
                     ELSE
                       R:RINDA='41'
                       R:PVNS[6,1]+=GGK_SUMMAV
                       R:PVNS[6,2]+=GGK_SUMMA
                     .
                  OF 22
                     IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[11,1]+=GGK_SUMMAV
                           R:PVNS[11,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[15,1]+=GGK_SUMMAV
                           R:PVNS[15,2]+=GGK_SUMMA
                        .                     
                     ELSIF GGK:PVN_TIPS='K'
                        R:PVNS[18,1]+=GGK_SUMMAV
                        R:PVNS[18,2]+=GGK_SUMMA
                     ELSIF GGK:PVN_TIPS='M'
                        R:PVNS[19,1]+=GGK_SUMMAV
                        R:PVNS[19,2]+=GGK_SUMMA
                     ELSIF GGK:PVN_TIPS='B'
                        R:PVNS[20,1]+=GGK_SUMMAV
                        R:PVNS[20,2]+=GGK_SUMMA
                     ELSE
                       R:RINDA='41'
                       R:PVNS[8,1]+=GGK_SUMMAV
                       R:PVNS[8,2]+=GGK_SUMMA
                     .
                  ELSE
                     KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                     DO ProcedureReturn
                  .
                  .
                  PUT(R_TABLE)
               ELSE !R:KEY NAV ATRASTS

                  !Elya 18.03.2013 >
                  R:NOS_P=GETPAR_K(GGK:PAR_NR,0,1)
                  R:PAR_TIPS=GETPAR_K(GGK:PAR_NR,0,20) !LAI ZINÂTU, KA ES,RU
                  R:PAR_PVN= GETPAR_K(GGK:PAR_NR,0,13) !PVN RNr
                  R:VAL=GGK:VAL
                  R:PVN_TIPS=GGK:PVN_TIPS !VAJADZÎGS ATGRIEZTAI PRECEI UN ES PAKALPOJUMIEM UN KOKIEM
                  R:SUMMA=0
                  CLEAR(R:PVNS)
                  IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                           R:SUMMA=GGK:SUMMA !6-T?S GRUPAS SUMMA
                           R:RINDA = ''
                           irRinda43# = 0
                           LOOP R#=1 TO 2
                             IF KON:PVND[R#] = 44
                                R:RINDA='44'      ! SEZ
                             ELSIF KON:PVND[R#] = 411
                                R:RINDA='41.1'
                                IF ~INSTRING(GGK:PVN_TIPS,'38KMB')
                                   R:PVN_TIPS = 'K'
                                ELSE
                                   R:PVN_TIPS = GGK:PVN_TIPS
                                .
                             ELSIF KON:PVND[R#] = 482
                                R:RINDA='48.2'
                             ELSIF KON:PVND[R#] = 43
                                irRinda43# = 1
                             .
                           .
                           IF R:RINDA = '' AND irRinda43# = 1
                              R:RINDA='43'
                           .
   !                        IF INSTRING(R:PVN_TIPS,'38KMB')
   !                          R:PVNS[18,1]=GGK_SUMMAV
   !                          R:PVNS[18,2]=GGK_SUMMA
   !                        ELSIF R:PVN_TIPS='M'
   !                          R:PVNS[19,1]=GGK_SUMMAV
   !                          R:PVNS[19,2]=GGK_SUMMA
   !                        ELSIF R:PVN_TIPS='B'
   !                          R:PVNS[20,1]=GGK_SUMMAV
   !                          R:PVNS[20,2]=GGK_SUMMA
   !                        .
                  ELSE
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
                          R:RINDA='42'
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
                          R:RINDA='42'
                          R:PVNS[9,1]=GGK_SUMMAV
                          R:PVNS[9,2]=GGK_SUMMA
                        .
                     OF 14
                        R:PVNS[5,1]=GGK_SUMMAV   !VAR BÛT TIKAI Ls&LR
                        R:PVNS[5,2]=GGK_SUMMA    !VAR BÛT TIKAI Ls&LR

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
                          R:RINDA='41'
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

                        ELSIF GGK:PVN_TIPS='K'
                          R:PVNS[18,1]=GGK_SUMMAV
                          R:PVNS[18,2]=GGK_SUMMA
                        ELSIF GGK:PVN_TIPS='M'
                          R:PVNS[19,1]=GGK_SUMMAV
                          R:PVNS[19,2]=GGK_SUMMA
                        ELSIF GGK:PVN_TIPS='B'
                          R:PVNS[20,1]=GGK_SUMMAV
                          R:PVNS[20,2]=GGK_SUMMA

                        ELSE
                          R:RINDA='41'
                          R:PVNS[8,1]=GGK_SUMMAV
                          R:PVNS[8,2]=GGK_SUMMA
                        .
                     ELSE
                        KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                        DO ProcedureReturn
                     .
                  .  !14.06.2012
                  R:DATUMS=GGK:DATUMS         !Ls pârrçíins  ?
                  R:PAR_NR=GGK:PAR_NR
                  !STOP('==='&GGK:BKK&R:PAR_NR&'R='&R:RINDA&' '&R:SUMMA)

                  ADD(R_TABLE)
                  SORT(R_TABLE,R:U_NR)
!14.06.2012               .
               .!Elya 18.08.2013
            .
         .!BEIDZAS PVN KONTS

NEXTROW LOOP
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

  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************* I.Priekðnodoklis par iekðzemç &ES iegâdâtajâm precçm un saòemtajiem pakalpojumiem ********
!*************** un mums atgrieztâ prece,pakalpojumi (kredîtrçíins) un zaudçts parâds *******************
!Elya ~begin
    SORT(R_TABLE,R:PAR_NR,R:U_NR)
    GET(R_TABLE,0)

    U_NR_C# = R:U_NR
    IR# = 0
    LINE# = 0
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') OR (R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !NAV ES vai ES Pakalpojumu PVNnemaksâtâjs
          IF R:D_K='D'  AND R:SADALA=1             !IEGÂDE,arî imports vai ATGRIEZTA REALIZÂCIJA,VAI MÇS ATGRIEÞAM(-),vai ZAUDÇTS PARÂDS
!       STOP(''&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
          IF ~U_NR_C#=R:U_NR AND LINE# = 1
!               STOP(CPR:U_NR&' '&CPR:DOKSUMMA)
               ADD(CPR_TABLE)
               LINE# = 0
               CPR:DOKSUMMA = 0
          .
          IF ~INSTRING(R:PVN_TIPS,'K38MBZ')
             CPR:DOKSUMMA+= R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[5,2]/0.14+|
             R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12+R:PVNS[14,2]/0.21+R:PVNS[15,2]/0.22+|
             R:PVNS[16,2]/0.1+R:PVNS[17,2]/0.12+R:PVNS[18,2]/0.22+R:PVNS[19,2]/0.22+R:PVNS[20,2]/0.22
          .
          CPR:U_NR = R:U_NR
          CPR:PAR_NR = R:PAR_NR
          U_NR_C#=R:U_NR
          IR# = 1
          LINE# = 1
          .
       .
    .
    IF LINE#=1 AND IR# = 1
       ADD(CPR_TABLE)
       SORT(CPR_TABLE,CPR:U_NR)
    .
    SORT(CPR_TABLE,CPR:PAR_NR,CPR:U_NR)
    GET(CPR_TABLE,0)
    PAR_NR_K# = CPR:PAR_NR
    IRK# = 0
    LINEK# = 0
    LOOP I#= 1 TO RECORDS(CPR_TABLE)
       GET(CPR_TABLE,I#)
          IF ~PAR_NR_K#=CPR:PAR_NR AND LINEK# = 1
 !              STOP(KKPR:PAR_NR&' '&KKPR:DOKSUMMA)
               ADD(KKPR_TABLE)
               LINEK# = 0
               KKPR:DOKSUMMA = 0
          .
          IF  (INRANGE(ABS(CPR:DOKSUMMA),0,MINMAXSUMMA-0.01))
            KKPR:DOKSUMMA+= CPR:DOKSUMMA
          .
          KKPR:PAR_NR = CPR:PAR_NR
          PAR_NR_K# = CPR:PAR_NR
          IRK# = 1
          LINEK# = 1
    .
    IF LINEK#=1 AND IRK# = 1
       ADD(KKPR_TABLE)
       SORT(KKPR_TABLE,KKPR:PAR_NR)
    .
    SORT(R_TABLE,R:U_NR)
    IF INRANGE(B_DAT-S_DAT,0,31) THEN PER = 0 !menesis
    ELSIF INRANGE(B_DAT-S_DAT,32,100) THEN PER = 1 !ceturksnis
    ELSIF INRANGE(B_DAT-S_DAT,180,200) THEN PER = 2 !pusgads
    ELSE PER = 3 !gads
    .
!Elya ~end
!Elya    SORT(R_TABLE,R:NOS_P)
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
       DO CONVERT_TEX:DUF_
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
!             IF INSTRING(R:PVN_TIPS,'3456') THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = 'K' THEN DV='R1'. !KOKI     tikai reversam, ja bez reversa jabut A - 22%
             IF R:PVN_TIPS = '3' THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = '8' THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = 'M' THEN DV='R2'. !METALUZNI
             IF R:PVN_TIPS = 'B' THEN DV='R3'. !BUVNIECIBA
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
             GG_DOKDAT = GG:DOKDAT
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+R:PVNS[8,2]+|
             R:PVNS[9,2]+R:PVNS[14,2]+R:PVNS[15,2]+R:PVNS[16,2]+R:PVNS[17,2]+R:PVNS[18,2]+R:PVNS[19,2]+R:PVNS[20,2] !18+5+14+21+10+22+12+N21+N10+N22+N12%   Ls
             DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[5,2]/0.14+|
             R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12+R:PVNS[14,2]/0.21+R:PVNS[15,2]/0.22+|
             R:PVNS[16,2]/0.1+R:PVNS[17,2]/0.12+R:PVNS[18,2]/0.22+R:PVNS[19,2]/0.22+R:PVNS[20,2]/0.22
             IF R:SUMMA
                DOK_SUMMA=R:SUMMA
             .
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
!                                 STOP('##'&R:PAR_NR&'R='&R:RINDA&' '&R:SUMMA)
                KLUDA#=TRUE
             .

             DOK_SUMMA_K+=DOK_SUMMA

             CPR:U_NR = R:U_NR
             GET(CPR_TABLE,CPR:U_NR)
             IF ERRORCODE()
                SUMMA_PEC_DOK = 0
             ELSE
                SUMMA_PEC_DOK = CPR:DOKSUMMA
             .
             KKPR:PAR_NR = R:PAR_NR
             GET(KKPR_TABLE,KKPR:PAR_NR)
             IF ERRORCODE()
                SUMMA_PEC_KL = 0
             ELSE
                SUMMA_PEC_KL = KKPR:DOKSUMMA
             .
!             IF ((BILANCE AND ~INRANGE(ABS(SUMMA_PEC_DOK),MINMAXSUMMA,BILANCE-0.01)) OR|         !TÂ BILANCE (max sum) NO IZZFILTPVN
!                (~BILANCE AND INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01) AND ~(DV='Z'))) AND| !DAR.VEIDS=T
!                ~INSTRING(R:PVN_TIPS,'KMB')
             IF R:SADALA=1                                                               !KOKI
                IF (~INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) OR INSTRING(R:PVN_TIPS,'K38MBZ')
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
                      DO CONVERT_TEX:DUF_
                      XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                      ADD(OUTFILEXML)
                      XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
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
                ELSIF ((S_DAT >=DATE(3,1,2012) AND PER = 0) OR (S_DAT >=DATE(1,1,2012) AND ~PER = 0)) AND |
                   (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND (~INRANGE(ABS(SUMMA_PEC_KL),0,MINMAXSUMMA-0.01)) AND |
                   ~(DV='Z') AND ~INSTRING(R:PVN_TIPS,'KMB') AND UPPER(PERS_KODS[1:2]) = 'LV'
                   IR_KL# = 1
                   KPR:PAR_NR = R:PAR_NR
                   KPR:DV = DV
                   GET(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   IF ERROR()
                      KPR:SUMMA=DOK_SUMMA
                      KPR:PVN=PVN_SUMMA
                      ADD(KPR_TABLE)
!                     STOP(R:PAR_NR&'R='&R:RINDA&' '&K:SUMMA)
                      SORT(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   ELSE
                      KPR:SUMMA+=DOK_SUMMA
                      KPR:PVN+=PVN_SUMMA
!                     STOP(K:SUMMA)
                      PUT(KPR_TABLE)
                      SORT(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   .
                ELSE !(INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND ~INSTRING(R:PVN_TIPS,'KMB') !SADAÏA T
                   DOK_SUMMA_P+=DOK_SUMMA
                   PVN_SUMMA_P+=PVN_SUMMA
                .
             .
          .
       .
    .
    LOOP I#= 1 TO RECORDS(KPR_TABLE)
       GET(KPR_TABLE,I#)
       NPK+=1
       PAR_nos_p = GETPAR_K(KPR:PAR_NR,0,2)
       pers_kods = GETPAR_K(KPR:PAR_NR,0,8)
       PVN_SUMMA = KPR:PVN
       DOK_SUMMA = KPR:SUMMA
       ATTDOK=''
       GG_DOK_NR=''
       GG_DOKDAT=0
       DV = 'V'
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
           DO CONVERT_TEX:DUF_
           XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
           ADD(OUTFILEXML)
           XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
           ADD(OUTFILEXML)
           XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
           ADD(OUTFILEXML)
           XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
           ADD(OUTFILEXML)
           XML:LINE=' /R>'
           ADD(OUTFILEXML)
       .
    .
    NPK+=1
    IF dok_summa_p
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
        ELSE
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'T'&CHR(9)&LEFT(FORMAT(DOK_SUMMA_P,@N-_12.2))&CHR(9)&|
           LEFT(FORMAT(PVN_SUMMA_P,@N-_12.2))
           ADD(OUTFILEANSI)
        .
    .
    IF F:DBF='W'   !WMF
        PRINT(RPT:DETAIL1)
        PRINT(RPT:D1_FOOTER)
    ELSE
        OUTA:LINE='Kopâ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DOK_SUMMA_K,@N-_12.2))&CHR(9)&LEFT(FORMAT(PVN_SUMMA_K,@N-_12.2))
        ADD(OUTFILEANSI)
    .

    IF F:XML_OK#=TRUE
       IF DOK_SUMMA_P   !EDS 0-es NEÒEM PRETÎ
          XML:LINE=' R>'
          ADD(OUTFILEXML)
          XML:LINE=' Npk>'&NPK&'</Npk>'
          ADD(OUTFILEXML)
          XML:LINE=' DarVeids>'&'T'&'</DarVeids>'    !T-DAR.ZEM 1000,-
          ADD(OUTFILEXML)
          XML:LINE=' VertibaBezPvn>'&DOK_SUMMA_P&'</VertibaBezPvn>'
          ADD(OUTFILEXML)
          XML:LINE=' PvnVertiba>'&PVN_SUMMA_P&'</PvnVertiba>'
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
           XML:LINE='<<?xml version="1.0" encoding="windows-1257"?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokPVNPESv1>'
           ADD(OUTFILEXML)
           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF_
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
                PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
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
                   DO CONVERT_TEX:DUF_
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValVertiba>'&DOK_SUMMAV&'</ValVertiba>'
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
       DO CONVERT_TEX:DUF_
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
    SORT(R_TABLE,R:PAR_NR,R:U_NR)
    GET(R_TABLE,0)

    U_NR_C# = R:U_NR
    PAR_NR_K# = R:PAR_NR
    IR# = 0
    LINE# = 0
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') AND R:SADALA=3
          IF R:D_K='K'| !07.03.2011 ARÎ KO MUMS ATGRIEÞ
          AND ~(R:PVN_TIPS='I')  !28.07.2010 PAKALPOJUMI NO RU-NERÂDAM
!       STOP(''&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
          IF ~U_NR_C#=R:U_NR AND LINE# = 1
!               STOP(C:U_NR&' '&C:DOKSUMMA)
               ADD(C_TABLE)
               LINE# = 0
               C:DOKSUMMA = 0
          .
          IF ~INSTRING(R:PVN_TIPS,'KMB')
             IF R:SUMMA
                C:DOKSUMMA+=R:SUMMA
             ELSE
                C:DOKSUMMA+=R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.14+|
                R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12
             .
          .
          C:U_NR = R:U_NR
          C:PAR_NR = R:PAR_NR
          U_NR_C#=R:U_NR
          IR# = 1
          LINE# = 1
          .
       .
    .
    IF LINE#=1 AND IR# = 1
       ADD(C_TABLE)
       SORT(C_TABLE,C:U_NR)
    .
    SORT(C_TABLE,C:PAR_NR,C:U_NR)
    GET(C_TABLE,0)
    PAR_NR_K# = C:PAR_NR
    IRK# = 0
    LINEK# = 0
    LOOP I#= 1 TO RECORDS(C_TABLE)
       GET(C_TABLE,I#)
          IF ~PAR_NR_K#=C:PAR_NR AND LINEK# = 1
!               STOP(KKPR:PAR_NR&' '&KKPR:DOKSUMMA)
               ADD(KK_TABLE)
               LINEK# = 0
               KK:DOKSUMMA = 0
          .
          IF (INRANGE(ABS(C:DOKSUMMA),0,MINMAXSUMMA-0.01))
            KK:DOKSUMMA+= C:DOKSUMMA
          .
          KK:PAR_NR = C:PAR_NR
          PAR_NR_K# = C:PAR_NR
          IRK# = 1
          LINEK# = 1
    .
    IF LINEK#=1 AND IRK# = 1
!       STOP('*'&KK:PAR_NR&' '&KK:DOKSUMMA)
       ADD(KK_TABLE)
       SORT(KK_TABLE,KK:PAR_NR)
    .
    SORT(R_TABLE,R:U_NR)

    NPK=0
    IR_KL# = 0
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') AND R:SADALA=3
          IF R:D_K='K'| !07.03.2011 ARÎ KO MUMS ATGRIEÞ
          AND ~(R:PVN_TIPS='I')  !28.07.2010 PAKALPOJUMI NO RU-NERÂDAM
!             STOP(R:PAR_NR&'R='&R:RINDA)
!           STOP('***'&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
             PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
!             GG_DOKDAT = GG:DOKDAT
             GG_DOKDAT = GG:DATUMS
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+|
             R:PVNS[8,2]+R:PVNS[9,2] !18+5+14+21+10+22+12%   Ls
             IF R:SUMMA
                DOK_SUMMA=R:SUMMA
                !PVN_SUMMA = 0
             ELSE
                DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.14+|
                R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12
             .
             GG_DOK_NR=GG:DOK_SENR
             RINDA3 = R:RINDA
             KLUDA#=FALSE

             CASE GG:ATT_DOK
             OF '1'
                ATTDOK='1-nodokïa rçíins'
             OF '2'
                ATTDOK='2-kases èeks vai kvîts'
             OF '3'
                ATTDOK='3-bezskaidras naudas MD'
!             OF '4'
!                ATTDOK='4-kredîtrçíins'
             OF '5'
                ATTDOK='5-cits'
!             OF '6'
!                ATTDOK='6-muitas deklarâcija'
             OF 'X'
                ATTDOK='X-atseviðíi neuzrâdâmie darîjumi'
             ELSE
                KLUDA#=TRUE
             .
             DOK_SUMMA_K3+=DOK_SUMMA
             PVN_SUMMA_K3+=PVN_SUMMA
             C:U_NR = R:U_NR
             GET(C_TABLE,C:U_NR)
             IF ERRORCODE()
                SUMMA_PEC_DOK = 0
             ELSE
                SUMMA_PEC_DOK = C:DOKSUMMA
             .
             KK:PAR_NR = R:PAR_NR
             GET(KK_TABLE,KK:PAR_NR)
             IF ERRORCODE()
                SUMMA_PEC_KL = 0
             ELSE
                SUMMA_PEC_KL = KK:DOKSUMMA
             .

!             IF (BILANCE AND ~INRANGE(DOK_SUMMA,MINMAXSUMMA,BILANCE-0.01)) OR|
!                (~BILANCE AND ABS(DOK_SUMMA) < MINMAXSUMMA)
!             IF (BILANCE AND ~INRANGE(ABS(DOK_SUMMA),MINMAXSUMMA,BILANCE-0.01)) OR|     !TÂ BILANCE NO IZZFILTPVN
!                (~BILANCE AND INRANGE(ABS(DOK_SUMMA),0,MINMAXSUMMA-0.01)) AND PVN_SUMMA !SADAÏA T
             IF GG:ATT_DOK='X'
                DOK_SUMMA_X+=DOK_SUMMA
                PVN_SUMMA_X+=PVN_SUMMA
             ELSIF (~INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) OR INSTRING(R:PVN_TIPS,'KMB')
                NPK+=1
                IF KLUDA#=TRUE
!                STOP('5')
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
                   DO CONVERT_TEX:DUF_
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DeklRindNr>'&CLIP(R:RINDA)&'</DeklRindNr>'
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

             ELSIF ((S_DAT >=DATE(3,1,2012) AND PER = 0) OR (S_DAT >=DATE(1,1,2012) AND ~PER = 0)) AND |
                (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND (~INRANGE(ABS(SUMMA_PEC_KL),0,MINMAXSUMMA-0.01)) AND  |
                ~INSTRING(R:PVN_TIPS,'KMB') AND UPPER(PERS_KODS[1:2]) = 'LV' !SADAÏA V
!                   STOP('WWWWW'&R:PAR_NR&'R='&R:RINDA&' '&DOK_SUMMA&' '&SUMMA_PEC_DOK)
                IR_KL# = 1
                K:PAR_NR = R:PAR_NR
                GET(K_TABLE,K:PAR_NR)
                IF ERROR()
                    K:SUMMA=DOK_SUMMA
                    K:PVN=PVN_SUMMA
                    ADD(K_TABLE)
!                   STOP(R:PAR_NR&'R='&R:RINDA&' '&K:SUMMA)
                    SORT(K_TABLE,K:PAR_NR)
                ELSE
                    K:SUMMA+=DOK_SUMMA
                    K:PVN+=PVN_SUMMA
!                    STOP(K:SUMMA)
                    PUT(K_TABLE)
                    SORT(K_TABLE,K:PAR_NR)
                .
             ELSE !IF (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND ~INSTRING(R:PVN_TIPS,'KMB') !SADAÏA T
                 DOK_SUMMA_P3+=DOK_SUMMA
                 PVN_SUMMA_P3+=PVN_SUMMA
             .
          .
       .
    .
    IF DOK_SUMMA_X
       NPK+=1
       PAR_nos_p=''
       PERS_KODS=''
       dok_summa=dok_summa_X
       PVN_SUMMA=PVN_SUMMA_X
       ATTDOK='X-atseviðíi neuzrâdâmie'
       GG_DOK_NR=''
       GG_DOKDAT=0
       RINDA3 = ''
       IF F:DBF='W'   !WMF
          PRINT(RPT:D3_DETAIL)
       ELSE
          OUTA:LINE=NPK&CHR(9)&CHR(9)&CHR(9)&R:RINDA&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
          CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK
          ADD(OUTFILEANSI)
       .
       IF F:XML_OK#=TRUE
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
    .
!    STOP (F:XML_OK#)
    LOOP I#= 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       IF K:SUMMA
           NPK+=1
           PAR_nos_p = GETPAR_K(K:PAR_NR,0,2)
           pers_kods = GETPAR_K(K:PAR_NR,0,8)
           PVN_SUMMA = K:PVN
           DOK_SUMMA = K:SUMMA
           ATTDOK='V'
           GG_DOK_NR=''
           GG_DOKDAT=0
           RINDA3 = ''
           IF F:DBF='W'   !WMF
              PRINT(RPT:D3_DETAIL)
           ELSE
              OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&''&CHR(9)&LEFT(FORMAT(DOK_SUMMA,@N-_12.2))&|
              CHR(9)&LEFT(FORMAT(PVN_SUMMA,@N-_12.2))&CHR(9)&ATTDOK
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
              DO CONVERT_TEX:DUF_
              XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
              ADD(OUTFILEXML)
              XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
              ADD(OUTFILEXML)
              XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
              ADD(OUTFILEXML)
              XML:LINE=' DokVeids>'&'V'&'</DokVeids>'
              ADD(OUTFILEXML)
              XML:LINE=' /R>'
              ADD(OUTFILEXML)
           .
       .
    .
    NPK+=1
    PAR_nos_p=''
    PERS_KODS=''
    dok_summa=dok_summa_p3
    PVN_SUMMA=PVN_SUMMA_P3
    ATTDOK='T-darîjumi zem Ls 1000,-'
    GG_DOK_NR=''
    GG_DOKDAT=0
    RINDA3 = ''
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
CONVERT_TEX:DUF_  ROUTINE
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
