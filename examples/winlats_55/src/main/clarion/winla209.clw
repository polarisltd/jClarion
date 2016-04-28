                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_PAZ_ALNODK         PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
NPK                 USHORT
A_NM                DECIMAL(10,2)
RPT_GADS            USHORT
RPT_MEN_NR          BYTE
D_B_DAT             LONG

D_TABLE             QUEUE,PRE(D)
VUT                     STRING(25)
PK                      STRING(12)
TK                      DECIMAL(6)
PIERADR                 LIKE(KAD:PIERADR)
STATUSS                 LIKE(KAD:STATUSS)
kartnr                  LIKE(KAD:KARTNR)
S_DAT                   LONG
B_DAT                   LONG
S1                      DECIMAL(9,2)
S2                      DECIMAL(9,2)
S3                      DECIMAL(9,2)
S15                     DECIMAL(9,2)
S16                     DECIMAL(9,2)
S5                      DECIMAL(9,2)
S6                      DECIMAL(9,2)
S7                      DECIMAL(9,2)
S8                      DECIMAL(9,2)
S9                      DECIMAL(9,2)
S10                     DECIMAL(9,2)
S10P                    DECIMAL(9,2)
                    .

S1K                 DECIMAL(9,2)
S2K                 DECIMAL(9,2)
S3K                 DECIMAL(9,2)
S5K                 DECIMAL(9,2)
S15K                DECIMAL(9,2)
S16K                DECIMAL(9,2)
S6K                 DECIMAL(9,2)
S7K                 DECIMAL(9,2)
S8K                 DECIMAL(9,2)
S9K                 DECIMAL(9,2)
S10K                DECIMAL(9,2)
S10PK               DECIMAL(9,2)

TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

E                   STRING(1)
EE                  STRING(40)

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
Process:View         VIEW(KADRI)
                       PROJECT(KAD:AMATS)
                       PROJECT(KAD:APGAD_SK)
                       PROJECT(KAD:AVANSS)
                       PROJECT(KAD:DARBA_GR)
                       PROJECT(KAD:DZIM)
                       PROJECT(KAD:D_GR_END)
                       PROJECT(KAD:ID)
                       PROJECT(KAD:INI)
                       PROJECT(KAD:INV_P)
                       PROJECT(KAD:IZGLITIBA)
                       PROJECT(KAD:KARTNR)
                       PROJECT(KAD:VID_U_NR)
                       PROJECT(KAD:DAR_LIG)
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END
!------------------------------------------------------------------------

!!report REPORT,AT(104,2135,12000,6000),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),LANDSCAPE,THOUS
!!       HEADER,AT(104,146,12000,1990)


!!report REPORT,AT(104,885,12000,7500),PAPER(9),PRE(RPT),FONT('Arial Baltic',10,,),LANDSCAPE,THOUS
report REPORT,AT(104,885,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(104,198,12000,688),USE(?unnamed:4)
         STRING('2. pielikums'),AT(8021,52),USE(?String67)
         STRING('DARBA DÇVÇJA (IENÂKUMA IZMAKSÂTÂJA) PAZIÒOJUMS'),AT(2448,104),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Ministru Kabineta 2000. gada 2. maija Noteikumiem Nr. 166'),AT(8021,219),USE(?String68)
         STRING('par algas nodokli'),AT(3958,365),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(8010,385,208,280),USE(E),TRN,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING(@s40),AT(8219,490),USE(EE),TRN,LEFT(1)
         LINE,AT(104,677,10885,0),USE(?Line1),COLOR(COLOR:Black)
       END
PageHead DETAIL,AT(,,,3469),USE(?unnamed:3)
         STRING('Pers. kods'),AT(1531,2292,781,156),USE(?String69:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkuma'),AT(2354,2292,573,156),USE(?String69:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bruto'),AT(2948,2292,625,156),USE(?String69:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neapliek.'),AT(3625,2292,573,156),USE(?String69:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neapliek.'),AT(4250,2292,625,156),USE(?String69:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atviegl.'),AT(4938,2292,625,156),USE(?String69:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Papildu atvieglojumi'),AT(5604,2292,1615,156),USE(?String69:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnotie izdevumi'),AT(7271,2292,1719,156),USE(?String69:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkums,'),AT(9042,2271,625,156),USE(?String69:51),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieturçtais'),AT(9740,2292,573,156),USE(?String69:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Likumâ'),AT(10365,2292,573,156),USE(?String69:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10990,2240,0,1250),USE(?Line2:45),COLOR(COLOR:Black)
         LINE,AT(9688,2240,0,1250),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(10313,2240,0,1250),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(9010,2240,0,1250),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(4896,2240,0,1250),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5573,2240,0,1250),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(4219,2240,0,1250),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(3594,2240,0,1250),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(2927,2240,0,1250),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('Ter. kods'),AT(438,2448,990,156),USE(?String69:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâk. veids'),AT(1531,2458,781,156),USE(?String69:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gûðanas'),AT(2354,2448,573,156),USE(?String69:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ieòçmumi'),AT(2958,2448,625,156),USE(?String69:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâkumi'),AT(3625,2448,573,156),USE(?String69:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('minimums'),AT(4260,2448,625,156),USE(?String69:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('par'),AT(4927,2448,625,156),USE(?String69:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(2344,2615,573,156),USE(?String69:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apgâdâj.'),AT(4927,2604,625,156),USE(?String69:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('invali-'),AT(5604,2656,469,156),USE(?String69:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('repres.'),AT(6125,2656,521,156),USE(?String69:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kustîbas'),AT(6698,2656,521,156),USE(?String69:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('soc.apdr.'),AT(7271,2656,573,156),USE(?String69:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pens.'),AT(7896,2656,521,156),USE(?String69:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíi-'),AT(9042,2604,625,156),USE(?String69:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('termiòâ'),AT(10365,2604,573,156),USE(?String69:53),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personai'),AT(6125,2813,521,156),USE(?String69:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dalibn.'),AT(6698,2813,521,156),USE(?String69:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksas'),AT(7271,2813,573,156),USE(?String69:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('fondos'),AT(7896,2813,521,156),USE(?String69:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nâts'),AT(9042,2760,625,156),USE(?String69:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pârskait.'),AT(10365,2917,573,156),USE(?String69:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(10365,3073,573,156),USE(?String69:59),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,3229,10885,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('15'),AT(7896,3260,521,156),USE(?String69:72),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16'),AT(8542,3260,417,156),USE(?String69:73),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('17'),AT(9115,3260,521,156),USE(?String69:74),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('18'),AT(9719,3260,573,156),USE(?String69:75),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('19'),AT(10365,3260,573,156),USE(?String69:76),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,3438,10885,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING('1'),AT(156,3260,156,156),USE(?String69:60),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2, 4'),AT(469,3260,990,156),USE(?String69:61),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3, 5'),AT(1615,3260,677,156),USE(?String69:62),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(2396,3260,469,156),USE(?String69:63),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(2958,3260,625,156),USE(?String69:64),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(3635,3260,573,156),USE(?String69:65),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(4260,3260,625,156),USE(?String69:66),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(4938,3260,625,156),USE(?String69:67),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(5604,3260,469,156),USE(?String69:68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(6125,3260,521,156),USE(?String69:69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(6698,3260,521,156),USE(?String69:70),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(7271,3260,573,156),USE(?String69:71),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(9052,2917,573,156),USE(?String69:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('budþetâ'),AT(10365,2760,573,156),USE(?String69:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ditâti'),AT(5604,2813,469,156),USE(?String69:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2323,2240,0,1250),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('Vârds, uzvârds'),AT(438,2292,990,156),USE(?String69:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,2240,0,1250),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1510,2240,0,1250),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(104,2240,0,1250),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(115,2292,240,156),USE(?String69:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienesta'),AT(208,21,1667,208),USE(?String4)
         STRING(@s25),AT(2083,21,2135,208),USE(gl:vid_nos),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6823,0,0,260),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('teritoriâlâ iestâde'),AT(6854,21,1510,208),USE(?String4:3),CENTER
         LINE,AT(104,260,10885,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('DARBA DÇVÇJS (IENÂKUMA IZMAKSÂTÂJS)'),AT(156,365,10833,156),USE(?String69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8385,0,0,260),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Taksâcijas gads'),AT(8417,21,1615,208),USE(?String4:2),CENTER
         STRING(@n_4),AT(10083,21,885,208),USE(RPT_gads),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,573,10885,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(10990,573,0,469),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@s45),AT(708,625,4292,208),USE(CLIENT),RIGHT(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(5104,625,3854,208),USE(GL:ADRESE),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(104,833,10885,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('(uzòçmuma (uzòçmçjsabiedrîbas), ârvalstu uzòçmuma (nerezidenta) pastâvîgâs pârst' &|
             'âvniecîbas, iestâdes vai organizâcijas nosaukums)'),AT(469,865,6979,156),USE(?String69:2)
         LINE,AT(104,1042,10885,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('vai'),AT(5625,1094,938,156),USE(?String69:5),CENTER
         LINE,AT(104,1250,10885,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(3750,1250,0,469),USE(?Line10:7),COLOR(COLOR:Black)
         LINE,AT(5156,1250,0,469),USE(?Line10:6),COLOR(COLOR:Black)
         LINE,AT(104,1250,0,469),USE(?Line10:8),COLOR(COLOR:Black)
         LINE,AT(5573,2448,3438,0),USE(?Line1:10),COLOR(COLOR:Black)
         STRING('par'),AT(5604,2500,469,156),USE(?String69:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('politiski'),AT(6125,2500,521,156),USE(?String69:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nac. pret.'),AT(6698,2500,521,156),USE(?String69:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts'),AT(7271,2500,573,156),USE(?String69:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,2448,0,1042),USE(?Line2:24),COLOR(COLOR:Black)
         STRING('iem.priv.'),AT(7896,2500,521,156),USE(?String69:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izd.'),AT(8531,2500,417,156),USE(?String69:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('noteiktajâ'),AT(10365,2448,573,156),USE(?String69:52),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(9740,2448,573,156),USE(?String69:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no kura'),AT(9042,2448,625,156),USE(?String69:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8438,2448,0,1042),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(7240,2240,0,1250),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(6667,2448,0,1042),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(6094,2448,0,1042),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(104,2240,10885,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('IENÂKUMA SAÒÇMÇJI'),AT(156,1875,10833,156),USE(?String69:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(lati, santîmi)'),AT(9635,2083,1250,156),USE(?String69:11),RIGHT
         STRING(@s13),AT(9688,625,1198,208),USE(gl:REG_nr),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1719,10885,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(9583,573,0,469),USE(?Line10:3),COLOR(COLOR:Black)
         STRING('(reìistrâcijas Nr)'),AT(9615,865,1354,156),USE(?String69:4),CENTER
         STRING('(juridiskâ adrese)'),AT(7656,865,938,156),USE(?String69:3)
         LINE,AT(10990,1250,0,469),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(9583,1250,0,469),USE(?Line10:5),COLOR(COLOR:Black)
         STRING('(fiziskâs personas vârds un uzvârds)'),AT(135,1542,3594,156),USE(?String69:6),CENTER
         STRING('(personas kods)'),AT(3781,1542,1354,156),USE(?String69:7),CENTER
         STRING('(dzîvesvietas adrese taksâcijas gada sâkumâ)'),AT(5188,1542,4375,156),USE(?String69:8), |
             CENTER
         STRING('(dzîvesvietas kods)'),AT(9615,1542,1354,156),USE(?String69:9),CENTER
         LINE,AT(104,1510,10885,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(104,573,0,469),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(10990,0,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1979,0,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(104,0,0,260),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,313),USE(?unnamed)
         LINE,AT(104,0,0,323),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@N3),AT(125,10,,156),USE(NPK),CENTER
         LINE,AT(365,0,0,323),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(1510,0,0,323),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@S25),AT(385,10,1100,156),USE(D:VUT),LEFT
         STRING(@S12),AT(1531,10,781,156),USE(D:PK),LEFT
         LINE,AT(7865,0,0,323),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(8438,0,0,323),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,323),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(9063,10,573,156),USE(D:S9),RIGHT
         LINE,AT(9688,0,0,323),USE(?Line2:42),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(9719,10,573,156),USE(D:S10),RIGHT
         LINE,AT(10313,0,0,323),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(10990,0,0,323),USE(?Line2:46),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(10365,10,573,156),USE(D:S10P),RIGHT
         STRING(@N_8.2),AT(8490,0,469,156),USE(D:S16),RIGHT
         STRING(@N_8.2),AT(7938,0,469,156),USE(D:S15),RIGHT
         LINE,AT(7240,0,0,323),USE(?Line2:37),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(7250,10,573,156),USE(D:S3),RIGHT
         STRING(@N_9.2),AT(6125,10,521,156),USE(D:S8),RIGHT
         LINE,AT(6667,0,0,323),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(5604,10,469,156),USE(D:S7),RIGHT
         LINE,AT(6094,0,0,323),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(4271,21,,156),USE(D:S5),RIGHT
         LINE,AT(4896,0,0,323),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(4948,10,,156),USE(D:S6),RIGHT
         LINE,AT(5573,0,0,323),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,323),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(3604,21,600,156),USE(D:S2),RIGHT
         LINE,AT(4219,0,0,323),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(2323,0,0,323),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(2938,0,0,323),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(2969,21,600,156),USE(D:S1),RIGHT
         STRING(@d05.),AT(2365,10,,156),USE(D:S_DAT),LEFT
         STRING('-'),AT(2813,10,104,156),USE(?String24),CENTER
         STRING(@N06),AT(469,156,417,156),USE(D:TK),LEFT
         STRING(@d05.),AT(2344,156,,156),USE(D:B_DAT),RIGHT
         LINE,AT(104,313,10885,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('Darba alga'),AT(1615,156,,156),USE(?String104),LEFT
       END
detail1 DETAIL,AT(,,,1052),USE(?unnamed:2)
         LINE,AT(5573,-10,0,271),USE(?Line2:48),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,271),USE(?Line2:148),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,271),USE(?Line2:418),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,271),USE(?Line2:481),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,271),USE(?Line2:248),COLOR(COLOR:Black)
         LINE,AT(8438,-10,0,271),USE(?Line2:428),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,271),USE(?Line2:482),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,271),USE(?Line2:348),COLOR(COLOR:Black)
         LINE,AT(10313,-10,0,271),USE(?Line2:438),COLOR(COLOR:Black)
         LINE,AT(10990,-10,0,271),USE(?Line2:49),COLOR(COLOR:Black)
         STRING('KOPÂ:'),AT(677,52,,156),USE(?String106),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_10.2),AT(2969,52,600,156),USE(S1K),RIGHT
         STRING(@N_10.2),AT(3604,52,600,156),USE(S2K),RIGHT
         STRING(@N_9.2),AT(4271,52,,156),USE(S5K),RIGHT
         STRING(@N_9.2),AT(4948,52,,156),USE(S6K),RIGHT
         STRING(@N_9.2),AT(5604,52,469,156),USE(S7K),RIGHT
         STRING(@N_9.2),AT(6125,52,521,156),USE(S8K),RIGHT
         STRING(@N_9.2),AT(7250,52,573,156),USE(S3K),RIGHT
         STRING(@N-_10.2),AT(9063,52,573,156),USE(S9K),RIGHT
         STRING(@N_9.2),AT(9698,52,573,156),USE(S10K),RIGHT
         STRING(@N_9.2),AT(10365,52,573,156),USE(S10PK),RIGHT
         STRING(@N_8.2),AT(8510,52,469,156),USE(S16K),RIGHT
         STRING(@N_8.2),AT(7938,52,469,156),USE(S15k),RIGHT
         LINE,AT(104,260,10885,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('200__.gada_____._{21}'),AT(781,417),USE(?String117)
         STRING('_{21}'),AT(6063,573),USE(?String119)
         STRING('Izpildîtâjs: _{21}'),AT(7865,573),USE(?String119:3)
         STRING(@s25),AT(4135,583),USE(SYS:amats1),TRN,RIGHT(1)
         STRING(@s25),AT(8354,781),USE(SYS:PARAKSTS2),CENTER
         STRING('Z.V.'),AT(1667,833),USE(?String118)
         STRING('Izpildîtâja tâlruòa numurs:'),AT(7865,1042),USE(?String119:2)
         STRING(@s8),AT(9479,1042),USE(SYS:tel)
         STRING(@s25),AT(5917,781),USE(SYS:PARAKSTS1),CENTER
         LINE,AT(104,-10,0,271),USE(?Line2:50),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,271),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,271),USE(?Line2:47),COLOR(COLOR:Black)
         LINE,AT(2323,-10,0,271),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(2938,-10,0,271),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,271),USE(?Line2:471),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,271),USE(?Line2:247),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,271),USE(?Line2:427),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,7750,12000,104)
         STRING('(C) Assako'),AT(10625,0,,100),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atcelt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
ToScreen WINDOW('XML faila sagatavoðana'),AT(,,185,79),GRAY
       OPTION('Norâdiet, kur rakstît'),AT(9,12,173,45),USE(merkis),BOXED
         RADIO('Privâtais folderis'),AT(16,21),USE(?Merkis:Radio1),VALUE('1')
         RADIO('A:\'),AT(16,30),USE(?Merkis:Radio2),VALUE('2')
         RADIO('Tekoðâ direktorijâ'),AT(16,40,161,10),USE(?Merkis:Radio3),VALUE('3')
       END
       BUTTON('&Atlikt'),AT(109,61,36,14),USE(?CancelButton:T)
       BUTTON('&OK'),AT(147,61,35,14),USE(?OkButton:T),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  RPT_gads=YEAR(ALP:YYYYMM)
  RPT_MEN_NR=MONTH(ALP:YYYYMM)
  S_DAT=DATE(1,1,RPT_GADS)
  B_DAT=DATE(12,31,RPT_GADS)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGPA::USED=0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::USED+=1
  CHECKOPEN(ALGAS,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND(KAD:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  BIND('F:IDP',F:IDP)

  IF F:XML
     E='E'
     EE='(Ieien paziòojums... ieien_paz.duf)'
     DISKETE=FALSE
     disks=''
     MERKIS='1'
     OPEN(TOSCREEN)
     ?Merkis:radio1{prop:text}=USERFOLDER
     ?Merkis:radio3{prop:text}=path()
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?OkButton:T
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
              BREAK
           END
        OF ?CancelButton:T
           CASE EVENT()
           OF EVENT:Accepted
             LocalResponse = RequestCancelled
              DO ProcedureReturn
           .
        END
     END
     CLOSE(TOSCREEN)
     XMLFILENAME=DISKS&'IEIEN_PAZ.DUF'
!     stop(XMLFILENAME)
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
        XML:LINE='<<DeclarationFile type="ieien_paz">'
        ADD(OUTFILEXML)
        XML:LINE='<<Declaration>'
        ADD(OUTFILEXML)
     .
  .

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'DD Paziòojums par Algas Nod.'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KAD:RECORD)
      SET(KAD:INI_KEY,KAD:INI_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(KAD:NODALA=F:NODALA)) AND ~(ID AND ~(KAD:ID=ID))'
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
! STOP(F:IDP&' '&YEAR(KAD:D_GR_END)&' '&RPT_GADS&' '&MONTH(KAD:D_GR_END)&' '&MONTH(ALP:YYYYMM))
        IF ~F:IDP OR|                                                   !VISI
           (F:IDP='1' AND YEAR(KAD:D_GR_END)=RPT_GADS) OR|              !TIKAI ATLAISTIE Ð.G.
           (F:IDP='2' AND ~INRANGE(YEAR(KAD:D_GR_END),1,RPT_GADS)) OR|  !TIKAI NEAATLAISTIE
           (F:IDP='3' AND YEAR(KAD:D_GR_END)=RPT_GADS AND MONTH(KAD:D_GR_END)=RPT_MEN_NR) !TIKAI ATLAISTIE Ð.M.
           D:VUT= CLIP(KAD:VAR)&' '&CLIP(KAD:UZV)
           D:PK=KAD:PERSKOD
           D:TK=KAD:TERKOD
           D:PIERADR=KAD:PIERADR
           D:STATUSS=KAD:STATUSS   !VISPÂR JAU VAR MAINÎTIES......
           D:kartnr=KAD:KARTNR
           IF INRANGE(KAD:DARBA_GR,S_DAT,B_DAT)
             D:S_DAT=KAD:DARBA_GR
           ELSE
             D:S_DAT=S_DAT
           .
           IF INRANGE(KAD:D_GR_END,S_DAT,B_DAT)
             D:B_DAT=KAD:D_GR_END
           ELSE
             D:B_DAT=B_DAT
           .
           D:S1=0
           D:S2=0
           D:S3=0
           D:S15=0
           D:S16=0
           D:S5=0
           D:S6=0
           D:S7=0
           D:S8=0
           D:S9=0
           D:S10=0
           D:S10P=0
           A_NM  =0
           K#=0
           CLEAR(ALG:RECORD)
           ALG:ID=KAD:ID
           ALG:YYYYMM=DATE(MONTH(D:S_DAT),1,RPT_GADS)
           SET(ALG:ID_DAT,ALG:ID_DAT)
           LOOP
             NEXT(ALGAS)
             IF ERROR() OR ~(ALG:ID=KAD:ID) OR ~(YEAR(ALG:YYYYMM)=RPT_GADS) THEN BREAK.
             K#+=1
             ?Progress:UserString{PROP:TEXT}=CLIP(K#)&' '&D:VUT
             DISPLAY(?Progress:UserString)
             D:S1+=ROUND(SUM(33),.01)
             D:S2+=ROUND(SUM(2),.01)+ROUND(SUM(53),.01)
             D:S3+=ROUND(SUM(6),.01)
             D:S15+=ALG:PPF
             D:S16+=ALG:DZIVAP+ALG:IZDEV  !21.08.2010
!             D:S5+=ROUND(SUM(37),.01)     !F(KAL,PIEN/ATL/B-LAPA,ALGA)
             D:S5+=CALCNEA(1,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
!             D:S6+=ROUND(SUM(38),.01)     !F(KAL,PIEN/ATL/B-LAPA,ALGA)
             D:S6+=CALCNEA(2,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
             IF INRANGE(ALG:INV_P,1,3)
                D:S7+=CALCNEA(3,0,0)         !INVAL F(KAL,PIEN/ATL/B-LAPA)
             ELSIF INRANGE(ALG:INV_P,4,5)
                D:S8+=CALCNEA(3,0,0)         !PRP F(KAL,PIEN/ATL/B-LAPA)
             .
             D:S10+=ROUND(SUM(22)+SUM(23)+SUM(26)+SUM(27)+SUM(42),.01) !APRÇÍINÂTAIS NODOKLIS
!             D:S10+=ALG:IIN                                            !IETURÇTAIS NODOKLIS
             D:S10P+=ALG:IIN                                           !PÂRSKAITÎTAIS NODOKLIS

             IF MONTH(ALG:YYYYMM)=12
               A_NM+=SUM(21)                !ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS
             .
             D_B_DAT=DATE(MONTH(ALG:YYYYMM)+1,1,RPT_GADS)-1
           .
           IF D_B_DAT < D:B_DAT
              D:B_DAT=D_B_DAT
           .
   !        RPT:SV6=ROUND(RPT:S1-RPT:S2-RPT:S3-RPT:S6-RPT:S7,.01)
   !        IF RPT:SV6<0 THEN RPT:SV6=0.
   !        RPT:S9=ROUND(APLIEN,.01)
           D:S9=D:S1-D:S2-D:S3-D:S5-D:S6-D:S7-D:S8-D:S15-D:S16  !NO KÂ RÇÍINA NODOKLI
           IF D:S9<0 THEN D:S9=0.
   !        CASE KAD:STATUSS
   !        OF '0'
   !        OROF '1'
   !          RPT:GRAM_NR=KAD:KARTNR
   !          RPT:KART_NR=''
   !        ELSE
   !          RPT:GRAM_NR=''
   !          RPT:KART_NR=KAD:KARTNR
   !        .
   !?       IF A_NM
   !?         RPT:RINDA='Atvaïinâjumi nâkamajâ gadâ : '&a_nm
   !?       ELSE
   !?         RPT:RINDA=''
   !?       .
   !?       a_nm=0
           IF D:S1
             ADD(D_TABLE)
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:PageHead)
    IF F:XML_OK#=TRUE
       XML:LINE='<<DeclarationHeader>'
       ADD(OUTFILEXML)
       IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
       XML:LINE='<<Field name="dd_nmr_kods" value="'&GL:REG_NR&'" />'
       ADD(OUTFILEXML)
       TEX:DUF=CLIENT
       DO CONVERT_TEX:DUF
       XML:LINE='<<Field name="dd_isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
       ADD(OUTFILEXML)
       TEX:DUF=GL:ADRESE
       DO CONVERT_TEX:DUF
       XML:LINE='<<Field name="dd_adrese" value="'&CLIP(TEX:DUF)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="taks_gads" value="'&RPT_GADS&'" />'
       ADD(OUTFILEXML)
       IF ~SYS:PARAKSTS1 THEN KLUDA(87,'Vadîtâjs').
       XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
       ADD(OUTFILEXML)
       IF ~SYS:PARAKSTS2 THEN KLUDA(87,'Izpildîtâjs').
       XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="telef" value="'&CLIP(SYS:TEL)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<<Field name="datums_aizp" value="'&FORMAT(TODAY(),@D06.)&'" />'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationHeader>'
       ADD(OUTFILEXML)
    .
    GET(D_TABLE,0)
    LOOP I#=1 TO RECORDS(D_TABLE)
      GET(D_TABLE,I#)
      NPK+=1
      PRINT(RPT:DETAIL)
      S1K+= D:S1
      S2K+= D:S2
      S3K+= D:S3
      S15K+=D:S15
      S16K+=D:S16
      S5K+= D:S5
      S6K+= D:S6
      S7K+= D:S7
      S8K+= D:S8
      S9K+= D:S9
      S10K+= D:S10
      S10PK+= D:S10P
      IF F:XML_OK#=TRUE
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="dn_nmr_kods" value="'&DEFORMAT(D:PK,@P######-#####P)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="dn_isais_nosauk" value="'&CLIP(D:VUT)&'" />'
         ADD(OUTFILEXML)
         TEX:DUF=D:PIERADR
         DO CONVERT_TEX:DUF
         XML:LINE='<<Field name="dn_adrese" value="'&CLIP(TEX:DUF)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="dn_atkkods" value="'&D:TK&'" />'     !TERKODS
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="datums_no" value="'&FORMAT(D:S_DAT,@D06.)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="datums_lidz" value="'&FORMAT(D:B_DAT,@D06.)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="ienak_veids" value="1" />'           !Cieti darba alga
         ADD(OUTFILEXML)
         IF D:STATUSS='1' OR D:STATUSS='3'   !VISPÂR JAU VAR MAINÎTIES......
            XML:LINE='<<Field name="gram_ser" value="'&D:kartnr[1:3]&'" />'       !Algas nodokïa grâmatiòas sçrija
            ADD(OUTFILEXML)
            XML:LINE='<<Field name="gram_num" value="'&CLIP(D:kartnr[4:12])&'" />'!Algas nodokïa grâmatiòas Nr
            ADD(OUTFILEXML)
         ELSIF D:kartnr                      !TAGAD KARTE VAR ARÎ NEBÛT...
            XML:LINE='<<Field name="kart_ser" value="'&D:kartnr[1]&'" />'         !Algas nodokïa kartes sçrija
            ADD(OUTFILEXML)
            XML:LINE='<<Field name="kart_num" value="'&CLIP(D:kartnr[2:12])&'" />'!Algas nodokïa kartes Nr
            ADD(OUTFILEXML)
         .
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="1r" />'           !Bruto ieòçmumi
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S1,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="2r" />'           !Neapliekamie ienâkumi
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S2,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="3r" />'           !Neapliekamais minimums
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S5,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="4r" />'           !Atvieglojumi par apgâdâjamiem
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S6,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="5r" />'           !Atvieglojumi par invaliditâti
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S7,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="6r" />'           !Atvieglojumi PRP
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S8,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="7r" />'           !Atvieglojumi NPKD
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="0,00" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="8r" />'           !VSAI
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S3,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="9r" />'           !Iemaksas PPF
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S15,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="10r" />'           !Iemaksas PPF
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S16,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="11r" />'           !Ien, no kura aprçíinâts nodoklis
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S9,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="12r" />'           !Ieturçts nodoklis
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S10,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Row>'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="rinda" value="13r" />'           !Pârskaitîts nodoklis
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vertiba" value="'&CUT0(D:S10P,2,2,1,1)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
         XML:LINE='<</Row>'
         ADD(OUTFILEXML)
      .
    .
    PRINT(RPT:DETAIL1)     !Kopâ
    IF F:XML_OK#=TRUE
        XML:LINE='<</Declaration>'
        ADD(OUTFILEXML)
        XML:LINE='<</DeclarationFile>'
        ADD(OUTFILEXML)
        CLOSE(OUTFILEXML)
        IF DISKETE=TRUE
           FILENAME2='A:\IEIEN_PAZ.DUF'
           IF ~CopyFileA(XMLFILENAME,FILENAME2,0)
              KLUDA(3,XMLFILENAME&' uz '&FILENAME2)
           .
        .
    .
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
      ENDPAGE(report)
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
  FREE(D_TABLE)
  IF FilesOpened
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    ALGPA::USED -= 1
    IF ALGPA::USED = 0 THEN CLOSE(ALGPA).
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
      StandardWarning(Warn:RecordFetchError,'KADRI')
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
A_DSAK98             PROCEDURE                    ! Declare Procedure
!-----------------------------------------------------------------
OBJEKTS              DECIMAL(10,2)
OBJSUM               DECIMAL(10,2)
NODOKLISDD_V         DECIMAL(9,2)
NODOKLISDN_V         DECIMAL(9,2)
NODOKLIS_V           DECIMAL(9,2)
NODOKLISDD           DECIMAL(9,2)
NODOKLISDN           DECIMAL(9,2)
NODOKLIS             DECIMAL(9,2)
OBJEKTSK             DECIMAL(10,2)
NODOKLISDD_VK        DECIMAL(9,2)
NODOKLISDN_VK        DECIMAL(9,2)
NODOKLIS_VK          DECIMAL(9,2)
NODOKLISDDK          DECIMAL(9,2)
NODOKLISDNK          DECIMAL(9,2)
NODOKLISK            DECIMAL(9,2)

LIKMEDN              DECIMAL(5,2)
LIKMEDD              DECIMAL(5,2)
LIKME                DECIMAL(5,2)
LAIKA_P              STRING(20)
KOPA_IZMAKSAT        DECIMAL(10,2)
M0                   DECIMAL(10,2)
M1                   DECIMAL(10,2)
M2                   DECIMAL(10,2)
M3                   DECIMAL(10,2)
M4                   DECIMAL(10,2)
ZINAS                STRING(100)
ZINA                 STRING(100),DIM(4)
Z_KODS               DECIMAL(2)
RPT_Z_KODS           DECIMAL(2)
VUT                  STRING(30)
KAD_DARBA_GR         LIKE(KAD:DARBA_GR)
RPT_KAD_DARBA_GR     LONG
KAD_LIG_PRO_NR       STRING(8)

client_REG           STRING(60)
NODALA_TEXT          STRING(50)
AMATS_TEXT           STRING(25)

Z_TABLE             QUEUE,PRE(Z)
KEY                   LONG
KODS                  DECIMAL(2)
DOK_NR                STRING(8)
SATURS                STRING(100)
SATURS1               STRING(100)
SATURS2               STRING(100)
SATURS3               STRING(100)
                    .

VECUMS               STRING(2)

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
Process:View         VIEW(KADRI)
                       PROJECT(KAD:AMATS)
                       PROJECT(KAD:APGAD_SK)
                       PROJECT(KAD:AVANSS)
                       PROJECT(KAD:DARBA_GR)
                       PROJECT(KAD:DZIM)
                       PROJECT(KAD:D_GR_END)
                       PROJECT(KAD:ID)
                       PROJECT(KAD:INI)
                       PROJECT(KAD:INV_P)
                       PROJECT(KAD:IZGLITIBA)
                       PROJECT(KAD:KARTNR)
                       PROJECT(KAD:VID_U_NR)
                       PROJECT(KAD:DAR_LIG)
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END

!---------------------------------------------------------------------------

report REPORT,AT(104,198,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
CEPURE DETAIL,PAGEBEFORE(-1),AT(,,,990),USE(?unnamed:4)
         STRING('4. pielikums Ministru kabineta'),AT(6354,635),USE(?String94),TRN,RIGHT
         STRING('2000.gada 14.novembra noteikumiem Nr 397'),AT(5573,802),USE(?String94:2),TRN,RIGHT
       END
HEAD   DETAIL,AT(,,,1854),USE(?unnamed:2)
         LINE,AT(7865,1563,0,313),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(1510,1563,0,313),USE(?Line7:3),COLOR(COLOR:Black)
         LINE,AT(813,1563,0,313),USE(?Line7:2),COLOR(COLOR:Black)
         STRING('1. Ziòas par darba òçmçjiem'),AT(3021,1302,2135,208),USE(?String7:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(156,1385,2656,160),USE(AMATS_TEXT),TRN,LEFT
         LINE,AT(156,1563,7708,0),USE(?Line6),COLOR(COLOR:Black)
         STRING('Datums'),AT(188,1615,573,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dok.'),AT(938,1615,260,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1281,1563,0,313),USE(?Line7:17),COLOR(COLOR:Black)
         STRING('ZK'),AT(1292,1615,208,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ziòu atðifrçjums'),AT(2448,1615,3854,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1823,7708,0),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(156,1563,0,313),USE(?Line7),COLOR(COLOR:Black)
         STRING('(vârds, uzvârds)'),AT(4656,1021,990,208),USE(?String7:2)
         STRING(@s50),AT(156,1250,2656,160),USE(NODALA_TEXT,,?NODALA_TEXT:2),TRN,LEFT
         LINE,AT(3802,969,2813,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('DARBA ÒÇMÇJA VALSTS SOCIÂLÂS APDROÐINÂÐANAS OBLIGÂTO IEMAKSU UZSKAITES KARTÎTE'),AT(313,52), |
             USE(?String1),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma (uzòçmçjsabiedrîbas), organizâcijas, iestâdes nosaukums'),AT(167,313,3500,208), |
             USE(?String2),RIGHT
         STRING(@s60),AT(3750,313,4167,208),USE(client_REG),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Juridiskâ adrese'),AT(2156,500,1510,208),USE(?String2:2),TRN,RIGHT
         STRING(@s45),AT(3760,500,4167,208),USE(gl:adrese),TRN,LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,708,1042,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@p######-#####p),AT(698,760),USE(kad:perskod),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(3854,760,2656,208),USE(VUT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,708,0,260),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(625,969,1042,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('(personas kods vai speciâlâs vîzas numurs)'),AT(125,1021),USE(?String7:5)
         LINE,AT(1667,708,0,260),USE(?Line3:2),COLOR(COLOR:Black)
       END
ZINAS  DETAIL,AT(,,,146),USE(?unnamed)
         LINE,AT(156,-10,0,228),USE(?Line58),COLOR(COLOR:Black)
         STRING(@d6B),AT(177,0,615,156),USE(RPT_kad_darba_gr),RIGHT
         LINE,AT(813,-10,0,228),USE(?Line59),COLOR(COLOR:Black)
         STRING(@S8),AT(833,0,417,156),USE(KAD_LIG_PRO_NR)
         LINE,AT(1281,0,0,228),USE(?Line60),COLOR(COLOR:Black)
         STRING(@N2B),AT(1323,0,156,156),USE(RPT_Z_KODS),CENTER
         LINE,AT(1510,-10,0,228),USE(?Line61),COLOR(COLOR:Black)
         STRING(@s100),AT(1542,0,6302,156),USE(ZINAS),LEFT !         LINE,AT(1563,156,0,52),USE(?Line63:3),COLOR(00H)
         LINE,AT(7865,-10,0,228),USE(?Line62),COLOR(COLOR:Black)
       END
ZINAS_END DETAIL,AT(,-10,,135)
         LINE,AT(156,52,7708,0),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(1510,0,0,52),USE(?Line63:5),COLOR(COLOR:Black)
         LINE,AT(156,0,0,52),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(813,0,0,52),USE(?Line63:2),COLOR(COLOR:Black)
         LINE,AT(1281,0,0,52),USE(?Line63:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line63:4),COLOR(COLOR:Black)
       END
DETAIL_HEAD DETAIL,AT(,,,1698),USE(?unnamed:6)
         STRING('6'),AT(7167,1448,677,208),USE(?String18:52),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1667,7708,0),USE(?Line6:8),COLOR(COLOR:Black)
         STRING('8'),AT(6438,1448,677,208),USE(?String18:51),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(5760,1448,625,208),USE(?String18:50),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(4302,1448,677,208),USE(?String18:49),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(2375,1448,521,208),USE(?String18:48),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(5031,1448,677,208),USE(?String18:47),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(2948,1448,521,208),USE(?String18:46),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('2. Valsts sociâlâs apdroðinâðanas (SA) obligâto iemaksu aprçíins'),AT(1458,52,4531,208), |
             USE(?String7:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(6021,73),USE(GADS),RIGHT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('.gads'),AT(6375,73,417,177),USE(?String7:6),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,313,7708,0),USE(?Line6:6),COLOR(COLOR:Black)
         STRING('Pârskata'),AT(208,708,781,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mçnesis'),AT(208,917,781,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâkumi'),AT(1042,792,729,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(EUR)'),AT(1042,1000,729,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('obligâto'),AT(1802,781,521,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2344,573,1146,0),USE(?Line20),COLOR(COLOR:Black)
         STRING('iemaksu'),AT(1802,990,521,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('likme (%)'),AT(1802,1198,521,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(EUR)'),AT(3521,1198,729,208),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(EUR)'),AT(5760,1198,625,208),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1406,7708,0),USE(?Line6:7),COLOR(COLOR:Black)
         STRING('1'),AT(188,1448,781,208),USE(?String18:42),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1021,1448,729,208),USE(?String18:43),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1802,1448,521,208),USE(?String18:44),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(3521,1448,729,208),USE(?String18:45),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,313,0,1406),USE(?Line7:16),COLOR(COLOR:Black)
         STRING('oblig. iem.'),AT(7167,1042,677,208),USE(?String18:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(7167,833,677,208),USE(?String18:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darba dev.'),AT(7167,625,677,208),USE(?String18:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,573,0,1146),USE(?Line7:15),COLOR(COLOR:Black)
         STRING('oblig. iem.'),AT(6438,1042,677,208),USE(?String18:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(6438,833,677,208),USE(?String18:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6406,573,1458,0),USE(?Line20:3),COLOR(COLOR:Black)
         STRING('darba òçm.'),AT(6438,625,677,208),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('tai skaitâ'),AT(6438,354,1406,208),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6406,313,0,1406),USE(?Line7:14),COLOR(COLOR:Black)
         STRING('iemaksas'),AT(5760,990,625,208),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('obligâtas'),AT(5760,781,625,208),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(5760,573,625,208),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Veiktâs'),AT(5760,365,625,208),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5729,313,0,1406),USE(?Line7:13),COLOR(COLOR:Black)
         STRING('oblig. iem.'),AT(5031,1042,677,208),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(5031,833,677,208),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darba dev.'),AT(5031,625,677,208),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5000,573,0,1146),USE(?Line7:12),COLOR(COLOR:Black)
         STRING('oblig. iem.'),AT(4302,1042,677,208),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(4302,833,677,208),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darba òçm.'),AT(4302,625,677,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,573,1458,0),USE(?Line20:2),COLOR(COLOR:Black)
         STRING('tai skaitâ'),AT(4302,354,1406,208),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,313,0,1406),USE(?Line7:11),COLOR(COLOR:Black)
         STRING('iemaksas'),AT(3521,990,729,208),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('obligâtâs'),AT(3521,781,729,208),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts SA'),AT(3521,573,729,208),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçíinâtâs'),AT(3521,365,729,208),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3490,313,0,1406),USE(?Line7:10),COLOR(COLOR:Black)
         STRING('likme (%)'),AT(2948,1042,521,208),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('devçja'),AT(2948,833,521,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darba'),AT(2948,625,521,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,573,0,1146),USE(?Line7:9),COLOR(COLOR:Black)
         STRING('likme (%)'),AT(2375,1042,521,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('òçmçja'),AT(2375,833,521,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darba'),AT(2375,625,521,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('tai skaitâ'),AT(2375,354,1094,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2344,313,0,1406),USE(?Line7:8),COLOR(COLOR:Black)
         STRING('SA'),AT(1802,573,521,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts'),AT(1802,365,521,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,313,0,1406),USE(?Line7:7),COLOR(COLOR:Black)
         STRING('Darba'),AT(1042,583,729,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(990,313,0,1406),USE(?Line7:6),COLOR(COLOR:Black)
         LINE,AT(156,313,0,1406),USE(?Line7:5),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,250)
         LINE,AT(7865,-10,0,270),USE(?Line33:12),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,270),USE(?Line33:11),COLOR(COLOR:Black)
         LINE,AT(6406,-10,0,270),USE(?Line33:10),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,270),USE(?Line33:9),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line33:8),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,270),USE(?Line33:7),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,270),USE(?Line33:5),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,270),USE(?Line33:4),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,270),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,270),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(156,208,7708,0),USE(?Line6:9),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(1094,10,625,156),USE(OBJEKTS),RIGHT
         STRING(@N_9.2),AT(7240,10,573,156),USE(NODOKLISDD_V),RIGHT
         STRING(@N_9.2),AT(6510,10,573,156),USE(NODOKLISDN_V),RIGHT
         STRING(@N_9.2),AT(5781,10,573,156),USE(NODOKLIS_V),RIGHT
         STRING(@N_9.2),AT(5052,10,573,156),USE(NODOKLISDD),RIGHT
         STRING(@N_9.2),AT(4323,10,573,156),USE(NODOKLISDN),RIGHT
         STRING(@N_9.2),AT(3646,10,573,156),USE(NODOKLIS),RIGHT
         STRING(@N5.2B),AT(2500,10,313,156),USE(LIKMEDN),RIGHT
         STRING(@N5.2B),AT(3073,10,313,156),USE(LIKMEDD),RIGHT
         STRING(@N5.2B),AT(1927,10,313,156),USE(LIKME),RIGHT
         STRING(@s15),AT(188,10,781,156),USE(LAIKA_P),LEFT
         LINE,AT(156,-10,0,270),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(3490,-10,0,270),USE(?Line33:6),COLOR(COLOR:Black)
       END
FOOT   DETAIL,AT(,,,271),USE(?unnamed:5)
         LINE,AT(7865,-10,0,270),USE(?Line33:12F),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,270),USE(?Line33:11F),COLOR(COLOR:Black)
         LINE,AT(6406,-10,0,270),USE(?Line33:10F),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,270),USE(?Line33:9F),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line33:8F),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,270),USE(?Line33:7F),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,270),USE(?Line33:5F),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,270),USE(?Line33:4F),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,270),USE(?Line33:3F),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,270),USE(?Line33:2F),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(7240,42,573,156),USE(NODOKLISDD_VK),RIGHT
         LINE,AT(156,260,7708,0),USE(?Line6:4),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(6510,42,573,156),USE(NODOKLISDN_VK),RIGHT
         STRING(@N_9.2),AT(5781,42,573,156),USE(NODOKLIS_VK),RIGHT
         STRING(@N_9.2),AT(5052,42,573,156),USE(NODOKLISDDK),RIGHT
         STRING(@N_9.2),AT(4323,42,573,156),USE(NODOKLISDNK),RIGHT
         STRING(@N_9.2),AT(3646,42,573,156),USE(NODOKLISK),RIGHT
         LINE,AT(3490,-10,0,270),USE(?Line33:6F),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,270),USE(?Line33F),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(177,42,781,156),USE(?KOPA),CENTER
         STRING(@N_10.2),AT(1094,42,625,156),USE(OBJEKTSK),RIGHT
       END
       FOOTER,AT(100,11100,8000,10),USE(?unnamed:3)
         LINE,AT(156,0,7708,0),USE(?Line6:5),COLOR(COLOR:Black)
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
  CHECKOPEN(ALGAS,1)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  S_DAT=DATE(1,1,YEAR(ALP:YYYYMM))
  B_DAT=DATE(12,31,YEAR(ALP:YYYYMM))
  GADS =YEAR(ALP:YYYYMM)
  Client_REG=CLIP(CLIENT)&' '&GL:VID_NR

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'DN SA obl. iemaksu kart.'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KAD:RECORD)
      KAD:NODALA=F:NODALA
      SET(KAD:NOD_KEY,KAD:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(kad:NODALA=F:NODALA)) and ~(id AND ~(kad:id=id))'
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
         CLEAR(ALG:RECORD)
         alg:id=kad:id
         ALG:YYYYMM=DATE(1,1,GADS)
         SET(ALG:ID_DAT,ALG:ID_DAT)
         NEXT(ALGAS)
         IF ~ERROR() AND ALG:ID=KAD:ID AND YEAR(ALG:YYYYMM)=GADS !PAR PIEPRASÎTO GADU IR RAKSTI ÐIM ID
            VUT = GETKADRI(KAD:ID,0,1)
            IF KAD:NODALA THEN NODALA_TEXT='Nodaïa: '&KAD:NODALA&' '&GetNodalas(KAD:nodala,1).
            IF KAD:AMATS THEN AMATS_TEXT='Amats: '&KAD:AMATS.
            PRINT(rpt:CEPURE)
            PRINT(rpt:HEAD)
            LOOP I#= 1 TO 2   ! 2 IESPÇJAMÂS ZIÒAS NO KADRIEM
               EXECUTE I#
                  KAD_DARBA_GR=KAD:DARBA_GR
                  KAD_DARBA_GR=KAD:D_GR_END
               .
               EXECUTE I#
                  Z_KODS=KAD:Z_KODS
                  Z_KODS=KAD:Z_KODS_END
               .
               IF INRANGE(KAD_DARBA_GR,DATE(1,1,GADS),DATE(12,31,GADS))
                  Z:KEY = KAD_DARBA_GR
                  Z:KODS= Z_KODS
                  IF I#=1
                     Z:DOK_NR=CLIP(KAD:DAR_LIG)
                  ELSE
                     Z:DOK_NR=''
                  .
                  ADD(Z_TABLE)
               END
            .
            CLEAR(RIK:RECORD)
            RIK:ID = KAD:ID
            SET(RIK:DAT_KEY,RIK:DAT_KEY)
            LOOP
               NEXT(KAD_RIK)
               IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
               IF ~INSTRING(RIK:TIPS,'K') THEN CYCLE. ! IESPÇJAMÂS ZIÒAS NO RÎKOJUMIEM
               IF ~INRANGE(RIK:DATUMS,DATE(1,1,GADS),DATE(12,31,GADS)) THEN CYCLE.
               Z:KODS=RIK:Z_KODS
               Z:KEY=RIK:DATUMS
               Z:DOK_NR=RIK:DOK_NR
               Z:SATURS=RIK:SATURS
               Z:SATURS1=RIK:SATURS1
!               Z:SATURS2=RIK:SATURS2
               Z:SATURS3=''
               ADD(Z_TABLE)
            .
            SORT(Z_TABLE,Z:KEY)
            LOOP K#=1 TO RECORDS(Z_TABLE)
               CLEAR(ZINA)
               GET(Z_TABLE,K#)
               RPT_KAD_DARBA_GR = Z:KEY
               RPT_Z_KODS = Z:KODS
               KAD_LIG_PRO_NR = Z:DOK_NR
               IF Z:KODS
                  LOOP Z#=1 TO 4
                     ZINA[Z#]=FILL_ZINA(Z:KODS,Z#)
                  .
               ELSE
                  ZINA[1]=Z:SATURS
                  ZINA[2]=Z:SATURS1
                  ZINA[3]=Z:SATURS2
               .
               LOOP J#=1 TO 4
                  IF ZINA[J#]
                     ZINAS=ZINA[J#]
                     PRINT(RPT:ZINAS)
                     RPT_KAD_DARBA_GR = 0
                     RPT_Z_KODS = 0
                     KAD_LIG_PRO_NR = ''
                  .
               .
            END
            FREE(Z_TABLE)
            PRINT(RPT:ZINAS_END)
            PRINT(rpt:DETAIL_HEAD)
            OBJEKTSK     =0
            NODOKLISDD_VK=0
            NODOKLISDN_VK=0
            NODOKLIS_VK  =0
            NODOKLISDDK  =0
            NODOKLISDNK  =0
            NODOKLISK    =0
            OBJSUM       =0
            CLEAR(ALG:RECORD)
            alg:id=kad:id
            ALG:YYYYMM=DATE(1,1,GADS)
            SET(ALG:ID_DAT,ALG:ID_DAT)
            LOOP
               NEXT(ALGAS)
               IF ERROR() OR ~(KAD:ID=ALG:ID) THEN BREAK.
               IF ~(YEAR(ALG:YYYYMM)=GADS) THEN BREAK.
               LAIKA_P  = MENVAR(ALG:YYYYMM,2,1)
               likme    = alg:pr37+alg:pr1

               M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
               M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
               M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
               M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
               M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
               OBJEKTS=M0+M1+M2+M3+M4
               VECUMS=GETKADRI(ALG:ID,0,15)
               IF VECUMS<15
                  OBJEKTS=0  !TÂ ARÎ VAJAG-DATI
               .
               IF SYS:PZ_NR                            !IR DEFINÇTS OBJEKTS (2007.g. Ls23800)
                  IF SYS:PZ_NR-(OBJSUM+OBJEKTS)<0      !MKN 193
                     KLUDA(0,'Ir sasniegts obligâto iemaksu objekta MAX apmçrs '&CLIP(GETKADRI(ALG:ID,0,1)),,1)
                     OBJEKTS=SYS:PZ_NR-OBJSUM
                     IF OBJEKTS<0 THEN OBJEKTS=0.
                  .
               .
               OBJSUM+=OBJEKTS

               nodoklis  =  ROUND(objekts*alg:pr37/100,.01)+ROUND(objekts*alg:pr1/100,.01)
               nodoklis_v= nodoklis
               likmeDD  = alg:pr37
               nodoklisDD = ROUND(objekts*alg:pr37/100,.01)
               nodoklisDD_v= nodoklisDD
               likmeDN  = alg:pr1
               nodoklisDN = ROUND(objekts*alg:pr1/100,.01)
               nodoklisDN_V=nodoklisDN
               PRINT(RPT:DETAIL)
               OBJEKTSK     +=OBJEKTS
               NODOKLISDD_VK+=NODOKLISDD_V
               NODOKLISDN_VK+=NODOKLISDN_V
               NODOKLIS_VK  +=NODOKLIS_V
               NODOKLISDDK  +=NODOKLISDD
               NODOKLISDNK  +=NODOKLISDN
               NODOKLISK    +=NODOKLIS
            .
            PRINT(RPT:FOOT)
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
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
      StandardWarning(Warn:RecordFetchError,'KADRI')
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

A_NODPARS6           PROCEDURE                    ! Declare Procedure
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

YYYYMM               LONG
NPK                  USHORT
VARUZV               STRING(25)
NODOKLIS             DECIMAL(10,2)
NODOKLISK            DECIMAL(10,2)
NODOKLIS_S           DECIMAL(10,2)
NODOKLIS_SK          DECIMAL(10,2)
RPT_GADS             DECIMAL(4)
MENESIS              STRING(10)

T_TABLE             QUEUE,PRE(T)
ID                      ULONG
INI                     STRING(3)
IIN                     DECIMAL(10,2)
                    .
!-----------------------------------------------------------------------------
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_STUNDAS)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END

report REPORT,AT(198,1542,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
       HEADER,AT(198,198,8000,1344)
         STRING('6. pielikums'),AT(6927,52,781,156),USE(?String1),RIGHT 
         STRING('Iesniedz Valsts ieòçmumu dienestâ'),AT(208,104),USE(?String5),LEFT
         STRING('Ministru kabineta'),AT(6719,208,990,156),USE(?String1:2),RIGHT 
         STRING('2000. gada 2. maija'),AT(6719,365,990,156),USE(?String1:3),RIGHT 
         STRING('noteikumiem Nr. 166'),AT(6615,521,1094,156),USE(?String1:4),RIGHT 
         STRING('Pârskats par izmaksas vietâ ieturçto un budþetâ ieskaitîto'),AT(1719,781),USE(?String6:2), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('iedzîvotâju ienâkuma nodokli'),AT(2865,1042),USE(?String6),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
RepHeader DETAIL,AT(,,,1938)
         LINE,AT(1667,52,4688,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@N04),AT(2396,104),USE(GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(2969,104),USE(?String9),LEFT,FONT(,12,,,CHARSET:BALTIC)
         STRING(@S11),AT(3646,104),USE(MENESIS),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,365,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         STRING('Valsts ieòçmumu dienestâ'),AT(625,417,2031,260),USE(?String10),LEFT,FONT(,12,,,CHARSET:BALTIC)
         STRING(@s30),AT(3021,417),USE(GL:VID_NOS),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5938,365,0,313),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7760,365,0,313),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(208,677,7552,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(208,781,0,1094),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(7760,781,0,1094),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('(uzòçmuma (uzòçmçjsabiedrîbas), ârvalstu uzòçmuma (nerezidenta) pastâvîgâs'),AT(1615,833,4792,208), |
             USE(?String13),CENTER
         STRING('pârstâvniecîbas, iestâdes vai organizâcijas nosaukums un juridiskâ adrese)'),AT(1615,1042,4792,208), |
             USE(?String13:2),CENTER
         LINE,AT(208,1250,7552,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@s45),AT(260,1302,3646,260),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3958,1302,3802,260),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,7552,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@s11),AT(5313,1604,2333,260),USE(GL:REG_NR),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5052,1563,0,313),USE(?Line17:14),COLOR(COLOR:Black)
         LINE,AT(208,1875,7552,0),USE(?Line17:17),COLOR(COLOR:Black)
         LINE,AT(208,781,7552,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('teritoriâlâ iestâde'),AT(6094,417,1354,260),USE(?String10:2),LEFT,FONT(,12,,,CHARSET:BALTIC)
         LINE,AT(3490,52,0,313),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(6354,52,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(2917,52,0,625),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(1667,52,0,313),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(208,365,7552,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
HEADER DETAIL,AT(,,,1021)
         LINE,AT(208,52,7552,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Nr. p.k.'),AT(260,104,521,208),USE(?String30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods vai'),AT(833,104,1406,156),USE(?String30:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(2292,104,2135,208),USE(?String30:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkuma'),AT(4479,104,781,156),USE(?String30:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iedzîvotâju ienâkuma'),AT(5313,104,2448,156),USE(?String30:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4427,52,0,990),USE(?Line31:4),COLOR(COLOR:Black)
         LINE,AT(5260,52,0,990),USE(?Line31:5),COLOR(COLOR:Black)
         LINE,AT(7760,52,0,990),USE(?Line31:6),COLOR(COLOR:Black)
         LINE,AT(2240,52,0,990),USE(?Line31:3),COLOR(COLOR:Black)
         STRING('reìistrâcijas numurs'),AT(833,260,1406,156),USE(?String30:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(4479,260,781,156),USE(?String30:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(5313,260,2448,156),USE(?String30:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(4479,417,781,156),USE(?String30:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,417,2500,0),USE(?Line37),COLOR(COLOR:Black)
         STRING('ieturçts'),AT(5313,469,1198,156),USE(?String30:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksâts'),AT(6563,469,1198,156),USE(?String30:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,781,7552,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('1'),AT(260,833,521,156),USE(?String42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(833,833,1406,156),USE(?String42:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2292,833,2135,156),USE(?String42:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4479,833,781,156),USE(?String42:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5313,833,1198,156),USE(?String42:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(6563,833,1198,156),USE(?String42:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,990,7552,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(6510,417,0,625),USE(?Line38),COLOR(COLOR:Black)
         STRING('budþetâ'),AT(6563,625,1198,156),USE(?String30:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,52,0,990),USE(?Line31:2),COLOR(COLOR:Black)
         LINE,AT(208,52,0,990),USE(?Line31),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(208,-10,0,198),USE(?Line41),COLOR(COLOR:Black)
         STRING(@N4),AT(313,10,,156),USE(NPK),RIGHT 
         LINE,AT(781,-10,0,198),USE(?Line141),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,198),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,198),USE(?Line43),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,198),USE(?Line45),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6719,10,,156),USE(NODOKLIS_S),RIGHT 
         LINE,AT(7760,-10,0,198),USE(?Line41:2),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5521,10,,156),USE(NODOKLIS),RIGHT 
         STRING(@N02),AT(4740,10,,156),USE(SYS:NOKL_DC),RIGHT 
         STRING(@s25),AT(2396,10,1771,156),USE(VARUZV),LEFT 
         STRING(@P######-#####P),AT(990,10,,156),USE(KAD:PERSKOD),LEFT 
       END
detail1 DETAIL,AT(,,,354)
         LINE,AT(208,-10,0,271),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(781,-10,0,271),USE(?Line48:4),COLOR(COLOR:Black)
         LINE,AT(2240,-10,0,271),USE(?Line48:2),COLOR(COLOR:Black)
         LINE,AT(4427,-10,0,271),USE(?Line48:3),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,271),USE(?Line48:12),COLOR(COLOR:Black)
         LINE,AT(6510,-10,0,271),USE(?Line48:13),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,271),USE(?Line48:14),COLOR(COLOR:Black)
         LINE,AT(208,52,7552,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('KOPÂ:'),AT(4688,104,,156),USE(?String55),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(5521,104,,156),USE(NODOKLISK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2),AT(6719,104,,156),USE(NODOKLIS_SK),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,260,7552,0),USE(?Line1:12),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,1865)
         STRING(@N4),AT(365,156),USE(RPT_GADS),RIGHT
         STRING('. gada'),AT(781,156),USE(?String59),LEFT
         LINE,AT(1198,365,1771,0),USE(?Line57),COLOR(COLOR:Black)
         STRING('Vadîtâjs:'),AT(4219,365),USE(?String60:2)
         LINE,AT(4792,573,2500,0),USE(?Line58),COLOR(COLOR:Black)
         STRING(@s16),AT(5313,625),USE(SYS:PARAKSTS1),LEFT
         STRING('/'),AT(6563,625,104,208),USE(?String61:4),CENTER
         STRING('Z.v.'),AT(781,781),USE(?String59:2),LEFT
         STRING('Izpildîtâjs:'),AT(4146,990),USE(?String60:3)
         LINE,AT(4792,1198,2500,0),USE(?Line59),COLOR(COLOR:Black)
         STRING('/'),AT(5208,1250,104,208),USE(?String61),CENTER
         STRING(@s16),AT(5313,1250),USE(SYS:PARAKSTS2),LEFT
         STRING('/'),AT(6563,1250,104,208),USE(?String61:2),CENTER
         STRING('Izpildîtâja tâlruòa numurs:'),AT(3208,1563),USE(?String60)
         STRING(@s16),AT(4844,1563),USE(sys:tel)
         STRING('/'),AT(5208,625,104,208),USE(?String61:3),CENTER
       END
       FOOTER,AT(198,11350,8000,52)
         LINE,AT(208,0,7552,0),USE(?Line1:13),COLOR(COLOR:Black)
       END
       FORM,AT(1000,1000,6927,9000)
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = '6.pielikums MKN Nr 166'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      YYYYMM=ALP:YYYYMM
!?      ALG:YYYYMM=DATE(MONTH(YYYYMM)+10,1,YEAR(YYYYMM)-1)  !LAI DABÛTU 2 MÇNEÐUS ATPAKAÏ
      ALG:YYYYMM=ALP:YYYYMM
      SET(ALG:ID_KEY,ALG:ID_KEY)
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
      RPT_GADS=YEAR(TODAY())
      MENESIS=MENVAR(YYYYMM,2,1)
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:RepHeader)
        PRINT(RPT:HEADER)
      ELSE           !W,EX
        IF ~OPENANSI('NODPARS6.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'6.pielikums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2000.g. 2.maija'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 166'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='PÂRSKATS PAR IZMAKSAS VIETÂ IETURÇTO UN BUDÞETÂ IESKAITÎTO'
        ADD(OUTFILEANSI)
        OUTA:LINE='IEDZÎVOTÂJU IENÂKUMA NODOKLI'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=GADS&'. gada'&CHR(9)&MENESIS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Valsts ieòçmumu dienesta'&CHR(9)&GL:VID_NOS&CHR(9)&'teritoriâlâ iestâde'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiskâ adrese:'&CHR(9)&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE=GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{100}'
        ADD(OUTFILEANSI)
        IF F:DBF='E'   !EXCEL 2 LINES
           OUTA:LINE='Npk'&CHR(9)&'Personas kods'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Ienâkuma'&CHR(9)&'Iedzîvotâju ienâkuma nodoklis'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'vai reì.Nr.'&CHR(9)&CHR(9)&'izm. dat.'&CHR(9)&'Ieturçts'&CHR(9)&'Iemaksâts budþetâ'
           ADD(OUTFILEANSI)
        ELSE !WORD 1 RINDÂ
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai reì.Nr.'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Ienâkuma izm. dat.'&|
           CHR(9)&'Iedzîvotâju ienâkuma nodoklis ieturçts'&CHR(9)&'Iedzîvotâju ienâkuma nodoklis iemaksâts budþetâ'
           ADD(OUTFILEANSI)
        .
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY
        IF ~(F:NODALA AND ~(alg:NODALA=F:NODALA)) and ~(id AND ~(alg:id=id)) AND|
        BAND(ALG:BAITS,00000001B)       !U.Lîgums
            GET(T_TABLE,0)
            T:ID=ALG:ID
            GET(T_TABLE,T:ID)
            IF ERROR()
               OPCIJA#   = 1
               T:INI=ALG:INI
               T:IIN     = 0
            ELSE
               OPCIJA#   = 2
            .
            T:IIN+=SUM(5) ! NODOKÏI ÐAJÂ, PAG UN NÂK. MÇNEÐOS
            IF T:IIN
               CASE OPCIJA#
               OF 1
                  ADD(T_TABLE)
                  SORT(T_TABLE,T:ID)
               OF 2
                  PUT(T_TABLE)
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     SORT(T_TABLE,T:INI)
     LOOP I#=1 TO RECORDS(T_TABLE)
         GET(T_TABLE,I#)
         NPK+=1
         VARUZV=GETKADRI(T:ID,2,1)
         nodoklis     = T:IIN
         nodoklis_S   = T:IIN   !UZSKATAM, KA VISS IR SAMAKSÂTS
         nodoklisK   += nodoklis
         nodoklis_SK += nodoklis
         IF F:DBF = 'W'
             PRINT(RPT:DETAIL)
         ELSE
             OUTA:LINE=Npk&CHR(9)&KAD:PERSKOD&CHR(9)&VARUZV&CHR(9)&SYS:NOKL_DC&CHR(9)&left(FORMAT(NODOKLIS,@N_9.2))&|
             CHR(9)&left(FORMAT(NODOKLIS_S,@N_9.2))
             ADD(OUTFILEANSI)
!             OUTA:LINE=''
!             ADD(OUTFILEANSI)
         END
     .
     IF ~NPK THEN KLUDA(0,'Nav atrasts neviens darbinieks, kam amats ir U.Lîgums vai sâkas ar U.').
     IF F:DBF = 'W'
        PRINT(RPT:DETAIL1)
        PRINT(RPT:DETAIL2)
     ELSE
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(NODOKLISK,@N_9.2))&CHR(9)&left(FORMAT(NODOKLIS_SK,@N_9.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpildîtâjs:___________________ tâlruòa numurs: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Vadîtâjs:___________________/'&SYS:PARAKSTS1&'/'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Z.V.              _______ gada "___"___________________'
        ADD(OUTFILEANSI)
     END
     CLOSE(ProgressWindow)
     IF F:DBF='W'
        ENDPAGE(report)
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(T_TABLE)
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
  IF ERRORCODE() OR ~(alg:YYYYMM<=YYYYMM)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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



!   IF REG_NR=14                     !AGROPROJEKTS
!      CLEAR(KAD:RECORD)
!      KAD:ID=ALG:ID
!      GET(KADRI,kad:ID_K)
!      if error() then stop(error()).
!      IF ~(KAD:AMATS[1:2]='U.') THEN CYCLE.
!    ELSE
!      IF alg:PR37+ALG:PR1 THEN CYCLE.
!    .
