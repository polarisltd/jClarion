                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_PAZ_FPK            PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
NPK                 USHORT
SAV_NPK             USHORT
A_NM                DECIMAL(10,2)
!RPT_GADS            USHORT
!RPT_MEN_NR          BYTE
MENESS              STRING(12)
SAV_PK              STRING(12)

D_TABLE             QUEUE,PRE(D)
KEY                     STRING(8)    !ID&R1
VARDS                   STRING(15)
UZVARDS                 STRING(15)
INI                     LIKE(KAD:INI)
PK                      STRING(6)
PK1                     STRING(6)
R1                      SHORT        !IENÂKUMA VEIDA KODS(N4) (VID)
K1                      SHORT        !IENÂKUMA VEIDS(N4) (ASSAKO)
S_DAT                   LONG
B_DAT                   LONG
R4                      LONG         !IZMAKSAS DATUMS
R5                      DECIMAL(9,2) !IEÒÇMUMI
R6                      DECIMAL(7,2)
R7                      DECIMAL(9,2)
R8                      DECIMAL(9,2)
R9A                     DECIMAL(3)   !ATVIEGLOJUMU KODS
R9                      DECIMAL(9,2)
R10                     DECIMAL(9,2)
R11                     DECIMAL(9,2)
R12                     DECIMAL(9,2)
R13                     DECIMAL(9,2)
R14                     DECIMAL(9,2)
R15                     DECIMAL(9,2)
R16                     DECIMAL(9,2)
                    .

!R1                  STRING(4)        !IENÂKUMA VEIDA KODS
IV                  STRING(32)       !IENÂKUMA NOSAUKUMS
R2                  STRING(16)       !IENÂKUMA NOSAUKUMS 1.RINDÂ
R2A                 STRING(16)       !IENÂKUMA NOSAUKUMS 2.RINDÂ
RI                  DECIMAL(9,2)

TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

E                   STRING(1)
EE                  STRING(15)

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
report REPORT,AT(1,885,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE, |
         THOUS
       HEADER,AT(1,198,12000,510),USE(?unnamed:4)
         STRING('2. pielikums'),AT(10375,10),USE(?String67),TRN
         STRING('Ministru Kabineta'),AT(10094,135),USE(?String68),TRN,CENTER
         STRING('noteikumiem Nr.677'),AT(9979,385),USE(?String2),TRN
         STRING('2008.gada 25.augusta'),AT(9823,250),USE(?String65),TRN
       END
PageHead DETAIL,AT(10,10,11990,3490),USE(?unnamed:3)
         STRING('Paziòojums par fiziskai personai izmaksâtajâm summâm (kopsavilkums)'),AT(2271,21,7250,229), |
             USE(?String1),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers.'),AT(1594,2552,385,156),USE(?String69:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ien.'),AT(2000,2552,260,156),USE(?String69:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neapliek.'),AT(5000,2552,469,156),USE(?String69:21),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('Neapliek.'),AT(5490,2552,460,156),USE(?String69:23),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7010,2500,2969,0),USE(?Line75),COLOR(COLOR:Black)
         STRING('rçtais'),AT(10719,2708,406,156),USE(?String69:32),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atviegl.'),AT(5979,2552,469,156),USE(?String69:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods/'),AT(6490,2875,510,156),USE(?String69:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnotie izdevumi'),AT(7792,2302,1719,156),USE(?String69:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkums,'),AT(10042,2396,573,156),USE(?String69:51),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('Ietu-'),AT(10760,2552,365,156),USE(?String69:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaks.'),AT(7646,2552,479,156),USE(?String69:52),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11250,2250,0,1250),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(10010,2250,0,1250),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(10625,2240,0,1250),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(4979,2240,0,1250),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5479,2240,0,1250),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(5958,2240,0,1250),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(6469,2240,0,1250),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(3823,2240,0,1250),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(4354,2240,0,1250),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(3292,2240,0,1250),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(2281,2240,0,1250),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('v.'),AT(2010,2708,250,156),USE(?String69:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9385,2500,0,990),USE(?Line2:51),COLOR(COLOR:Black)
         STRING('ieòçmumi'),AT(4375,2552,583,156),USE(?String69:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâkumi'),AT(5000,2719,469,156),USE(?String69:22),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('mini-'),AT(5563,2719,375,156),USE(?String69:24),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('par'),AT(5990,2708,438,156),USE(?String69:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(2010,2875,240,156),USE(?String69:4),CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('apgâdâj.'),AT(5979,2875,479,156),USE(?String69:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('soc.apdr.'),AT(7031,2708,573,156),USE(?String69:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pens.'),AT(7646,2875,479,156),USE(?String69:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(3844,2875,479,156),USE(?String69:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíi-'),AT(10031,2708,563,156),USE(?String69:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksas'),AT(7031,2875,573,156),USE(?String69:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('fondos'),AT(7646,3031,479,156),USE(?String69:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ar uzkrâð.)'),AT(8167,3031,583,156),USE(?String69:36),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('(bez uzkrâð.)'),AT(8792,3031,583,156),USE(?String69:37),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('nâts'),AT(10083,2854,469,156),USE(?String69:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(281,3229,10979,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('09'),AT(6615,3281,323,156),USE(?String69:73),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(9604,3281,281,156),USE(?String69:74),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15'),AT(10177,3281,323,156),USE(?String69:75),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16'),AT(10844,3281,260,156),USE(?String69:76),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(281,3458,10979,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING('01'),AT(2042,3281,198,156),USE(?String69:63),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('02'),AT(2646,3281,323,156),USE(?String69:64),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('03'),AT(3365,3281,396,156),USE(?String69:65),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('04'),AT(3875,3281,427,156),USE(?String69:66),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(7750,3281,302,156),USE(?String69:25),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(7156,3281,375,156),USE(?String69:67),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(8302,3281,375,156),USE(?String69:251),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(8917,3281,375,156),USE(?String69:29),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('05'),AT(4510,3281,292,156),USE(?String69:68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('06'),AT(5073,3281,333,156),USE(?String69:69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('07'),AT(5563,3281,323,156),USE(?String69:70),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('08'),AT(6052,3281,354,156),USE(?String69:71),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(10021,3031,573,156),USE(?String69:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no/lîdz'),AT(3313,3031,500,156),USE(?String69:54),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1990,2240,0,1250),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('Vârds, '),AT(729,2552,646,156),USE(?String69:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(552,2240,0,1250),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(1573,2240,0,1250),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(281,2240,0,1250),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(313,2552,229,156),USE(?String69:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('IENÂKUMA IZMAKSÂTÂJS '),AT(4427,1052,1625,156),USE(?String69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas gads'),AT(4479,396,969,208),USE(?String4:2),LEFT
         STRING(@n_4),AT(5552,365,573,208),USE(GADS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas mçnesis'),AT(4479,615,1010,208),USE(?String4:3),TRN,LEFT
         STRING(@s12),AT(5552,583,1198,208),USE(MENESS),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3083,1281,4292,208),USE(CLIENT),CENTER(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3240,1510,3958,167),USE(GL:ADRESE),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(281,979,10979,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(11250,979,0,740),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(281,1250,10979,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(281,979,0,740),USE(?Line10:8),COLOR(COLOR:Black)
         STRING('valsts'),AT(7042,2552,531,156),USE(?String69:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('priv.'),AT(7698,2708,438,156),USE(?String69:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('prçmijas'),AT(8219,2875,521,156),USE(?String69:53),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('prçmijas'),AT(8865,2875,521,156),USE(?String69:33),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izdevumi'),AT(9417,2552,552,156),USE(?String69:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzvârds'),AT(729,2708,646,156),USE(?String69:31),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis'),AT(10646,2875,563,156),USE(?String69:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mums'),AT(5604,2896,281,156),USE(?String69:55),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('no kura'),AT(10042,2552,563,156),USE(?String69:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8771,2500,0,990),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(7000,2240,0,1250),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(281,2240,10979,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('IENÂKUMA SAÒÇMÇJI'),AT(4448,1865,1635,156),USE(?String69:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkuma'),AT(3323,2552,490,156),USE(?String69:117),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('dzîvîbas'),AT(8219,2552,521,156),USE(?String69:41),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dzîvîbas'),AT(8865,2552,521,156),USE(?String69:34),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ienâkuma'),AT(2500,2552,573,156),USE(?String69:127),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(3313,2875,500,156),USE(?String69:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(3844,2719,500,156),USE(?String69:7),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('(lati, santîmi)'),AT(10458,2073,750,156),USE(?String69:11),CENTER
         STRING('Papildus'),AT(6490,2552,479,156),USE(?String69:15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6490,3031,479,156),USE(?String69:20),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gûðanas'),AT(3302,2708,510,156),USE(?String69:18),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apdroðin.'),AT(8219,2708,521,156),USE(?String69:46),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apdroðin.'),AT(8865,2708,521,156),USE(?String69:35),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atviegloj.'),AT(6490,2719,510,156),USE(?String69:16),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(1594,2708,385,156),USE(?String69:56),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7615,2500,0,990),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(8135,2500,0,990),USE(?Line2:24),COLOR(COLOR:Black)
         STRING('Ienâkuma'),AT(3844,2552,490,156),USE(?String69:6),TRN,CENTER,FONT(,7,,FONT:bold,CHARSET:BALTIC)
         STRING('veids'),AT(2500,2708,573,156),USE(?String69:5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(9688,1281,1198,208),USE(gl:REG_nr),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(281,1708,10979,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(9583,1250,0,469),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(281,1490,10979,0),USE(?Line1:16),COLOR(COLOR:Black)
         STRING(@s1),AT(8281,573,208,280),USE(E),TRN,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING(@s15),AT(8500,698,1052,177),USE(EE),TRN,LEFT(1)
       END
detail DETAIL,AT(10,,,333),USE(?unnamed)
         LINE,AT(281,0,0,323),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@N3B),AT(302,10,,156),USE(NPK),CENTER
         LINE,AT(552,0,0,323),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(1573,0,0,323),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@S15),AT(583,10,979,156),USE(D:VARDS),LEFT
         STRING(@S6),AT(1594,10,396,156),USE(D:PK),LEFT
         STRING(@s4),AT(2021,10,250,156),USE(D:R1),LEFT
         LINE,AT(7615,0,0,323),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(8135,0,0,323),USE(?Line2:39),COLOR(COLOR:Black)
         LINE,AT(8771,0,0,323),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(8802,10,573,156),USE(D:R13),RIGHT
         LINE,AT(9385,0,0,323),USE(?Line2:42),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(9417,10,573,156),USE(D:R14),RIGHT
         LINE,AT(10010,0,0,323),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(10625,0,0,323),USE(?Line2:46),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(10042,10,573,156),USE(D:R15),RIGHT
         LINE,AT(11250,10,0,323),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(7646,10,469,156),USE(D:R11),RIGHT
         STRING(@N_8.2),AT(6510,146,469,156),USE(D:R9),RIGHT
         STRING(@S6),AT(1594,146,396,156),USE(D:PK1),TRN,LEFT
         LINE,AT(7000,0,0,323),USE(?Line2:37),COLOR(COLOR:Black)
         STRING(@S3),AT(6604,10,375,156),USE(D:R9A),RIGHT
         STRING(@N_9.2),AT(8177,10,,156),USE(D:R12),RIGHT
         STRING(@N_7.2),AT(5531,10,417,156),USE(D:R7),RIGHT
         LINE,AT(6469,10,0,323),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(5000,10,469,156),USE(D:R6),RIGHT
         LINE,AT(5958,0,0,323),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(4354,0,0,323),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@d05.B),AT(3854,10,,156),USE(D:R4),LEFT
         LINE,AT(4979,0,0,323),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(3292,0,0,323),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(3823,0,0,323),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(1990,0,0,323),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(2281,0,0,323),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s16),AT(2302,10,979,156),USE(R2),LEFT
         STRING(@d05.B),AT(3323,10,,156),USE(D:S_DAT),LEFT
         STRING(@d05.B),AT(3323,146,,156),USE(D:B_DAT),LEFT
         LINE,AT(5479,0,0,323),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(10656,10,573,156),USE(D:R16),TRN,RIGHT
         STRING(@N_9.2),AT(4375,10,,156),USE(D:R5),RIGHT
         STRING(@N_9.2),AT(5990,10,469,156),USE(D:R8),TRN,RIGHT
         STRING(@N_9.2),AT(7010,10,,156),USE(D:R10),TRN,RIGHT
         STRING(@S15),AT(583,146,979,156),USE(D:UZVARDS),TRN,LEFT
         STRING(@s16),AT(2302,146,979,156),USE(R2a),TRN,LEFT
         LINE,AT(281,313,10979,0),USE(?Line1:12),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(10,,,1052),USE(?unnamed:2)
         LINE,AT(4979,-10,0,271),USE(?Line2:48),COLOR(COLOR:Black)
         LINE,AT(5479,-10,0,271),USE(?Line2:148),COLOR(COLOR:Black)
         LINE,AT(6469,-10,0,271),USE(?Line2:418),COLOR(COLOR:Black)
         LINE,AT(7000,-10,0,271),USE(?Line2:481),COLOR(COLOR:Black)
         LINE,AT(7615,-10,0,271),USE(?Line2:248),COLOR(COLOR:Black)
         LINE,AT(8135,-10,0,271),USE(?Line2:428),COLOR(COLOR:Black)
         LINE,AT(8771,-10,0,271),USE(?Line2:482),COLOR(COLOR:Black)
         LINE,AT(9385,-10,0,271),USE(?Line2:348),COLOR(COLOR:Black)
         LINE,AT(10625,0,0,271),USE(?Line2:438),COLOR(COLOR:Black)
         LINE,AT(11250,-10,0,271),USE(?Line2:49),COLOR(COLOR:Black)
         LINE,AT(10010,0,0,271),USE(?Line2:53),COLOR(COLOR:Black)
         LINE,AT(5958,-10,0,271),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(281,260,10979,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('200__.gada_____._{21}'),AT(781,417),USE(?String117)
         STRING('_{21}'),AT(6063,573),USE(?String119)
         STRING('Izpildîtâjs: _{21}'),AT(7865,573),USE(?String119:3)
         STRING(@s25),AT(4135,583),USE(SYS:amats1),TRN,RIGHT(1)
         STRING(@s25),AT(8354,781),USE(SYS:PARAKSTS2),CENTER
         STRING('Z.V.'),AT(1667,833),USE(?String118)
         STRING('Izpildîtâja tâlruòa numurs:'),AT(7865,1042),USE(?String119:2)
         STRING(@s8),AT(9479,1042),USE(SYS:tel)
         STRING(@s25),AT(5917,781),USE(SYS:PARAKSTS1),CENTER
         LINE,AT(281,-10,0,271),USE(?Line2:50),COLOR(COLOR:Black)
         LINE,AT(552,-10,0,271),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1573,-10,0,271),USE(?Line2:47),COLOR(COLOR:Black)
         LINE,AT(1990,-10,0,271),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(2281,-10,0,271),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(3292,-10,0,271),USE(?Line2:471),COLOR(COLOR:Black)
         LINE,AT(3823,-10,0,271),USE(?Line2:247),COLOR(COLOR:Black)
         LINE,AT(4354,-10,0,271),USE(?Line2:427),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,7750,12000,135),USE(?unnamed:5)
         LINE,AT(10125,10,1042,0),USE(?Line74),COLOR(COLOR:Black)
         STRING('ISF Assako'),AT(10625,31,,100),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
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

  GADS=YEAR(ALP:YYYYMM)         !IZZFILTGMC NETIEK SAUKTS
  MEN_NR=MONTH(ALP:YYYYMM)
  IF F:KRI='B'  !1008UL-JÂNODOD KATRU MÇNESI
     S_DAT=ALP:YYYYMM
     B_DAT=DATE(MEN_NR+1,1,GADS)-1
  ELSE
     S_DAT=DB_S_DAT
     B_DAT=DATE(MEN_NR+1,1,GADS)-1
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGPA::Used = 0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::Used += 1   !JA ÐITÂ NAV, IZSAUKTÂ PROCEDURE NESAPROT, KA FAILS ATVÇRTS...
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
     EE='(PFPISK.XML)'
     DISKETE=FALSE
     disks=''                                          
     MERKIS='1'
     OPEN(TOSCREEN)
     ?Merkis:radio1{prop:text}=USERFOLDER
     ?Merkis:radio3{prop:text}=LONGPATH()
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
        .
     .
     CLOSE(TOSCREEN)
     XMLFILENAME=DISKS&'PFPISK.XML'
     CHECKOPEN(OUTFILEXML,1)
     CLOSE(OUTFILEXML)
     OPEN(OUTFILEXML,18)
     IF ERROR()
        KLUDA(1,XMLFILENAME)
     ELSE
        EMPTY(OUTFILEXML)  !HEDERIS UN VIENÎGÂ TAB SÂKUMS
        F:XML_OK#=TRUE
!        XML:LINE='<?xml version="1.0" encoding="utf-8" ?>'
!        XML:LINE='<?xml version="1.0" ?>'
        XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
        ADD(OUTFILEXML)
        XML:LINE=' DokPFPISK2008v1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
        ADD(OUTFILEXML)
        IF ~GL:REG_NR THEN KLUDA(87,'Jûsu NM Nr').              !vienkârði kontrolei
        XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
        ADD(OUTFILEXML)
        XML:LINE=' NmAdrese>'&CLIP(GL:ADRESE)&'</NmAdrese>'
        ADD(OUTFILEXML)
        XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
        ADD(OUTFILEXML)
        TEX:DUF=CLIENT
        DO CONVERT_TEX:DUF
        XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
        ADD(OUTFILEXML)
        IF ALP:YYYYMM > TODAY() THEN KLUDA(27,'taksâcijas periods'). !vienkârði kontrolei
        XML:LINE=' TaksGads>'&gads&'</TaksGads>'
        ADD(OUTFILEXML)
        XML:LINE=' DatumsAizp>'&FORMAT(TODAY(),@D010-)&'T00:00:00</DatumsAizp>'
        ADD(OUTFILEXML)
        XML:LINE=' TaksMen>'&MEN_NR&'</TaksMen>'
        ADD(OUTFILEXML)
        XML:LINE=' Vaditajs>'&CLIP(SYS:PARAKSTS1)&'</Vaditajs>'
        ADD(OUTFILEXML)
        XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
        ADD(OUTFILEXML)
        XML:LINE=' Tab>'
        ADD(OUTFILEXML)
        XML:LINE=' Rs>'
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
  ProgressWindow{Prop:Text} = 'Paziòojums par FP izm. summâm'
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
        IF ~F:IDP OR|                                                          !VISI
        (F:IDP='1' AND YEAR(KAD:D_GR_END)=GADS) OR|                            !TIKAI ATLAISTIE Ð.G.
        (F:IDP='2' AND ~INRANGE(YEAR(KAD:D_GR_END),1,GADS)) OR|                !TIKAI NEATLAISTIE
        (F:IDP='3' AND YEAR(KAD:D_GR_END)=GADS AND MONTH(KAD:D_GR_END)=MEN_NR) !TIKAI ATLAISTIE Ð.M.
           D:VARDS  = KAD:VAR
           D:UZVARDS= KAD:UZV
           D:INI    = KAD:INI
           D:PK=KAD:PERSKOD[1:6]
           D:PK1=KAD:PERSKOD[7:12]
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
           DO CLEARD_TABLE
           K#=0
           CLEAR(ALG:RECORD)
           ALG:ID=KAD:ID
           ALG:YYYYMM=S_DAT
           SET(ALG:ID_DAT,ALG:ID_DAT)
           LOOP
              NEXT(ALGAS)
              IF ERROR() OR ~(ALG:ID=KAD:ID) OR ALG:YYYYMM>B_DAT THEN BREAK.
              K#+=1
              ?Progress:UserString{PROP:TEXT}=CLIP(K#)&' '&D:UZVARDS
              DISPLAY(?Progress:UserString)
              D:K1 = ALG:K[1] !TIKAI 1-AIS ASSAKO KODS
              IF ALG:K[1]=879
                 D:R1 = 1011 !DIVIDENDES SHORT IENÂKUMA VEIDA KODS(N4) (VID)
                 D:R4 = ALG:IIN_DATUMS
                 D:S_DAT = ALG:IIN_DATUMS
                 D:B_DAT = ALG:IIN_DATUMS
              ELSE
!                 D:R1 = 1001 !DARBA ALGA
                 D:R1 = GETDAIEV(ALG:K[1],0,8)
              .
              D:KEY=FORMAT(ALG:ID,@N_04)&FORMAT(D:R1,@N_04) !ID&IVK
!              STOP(D:KEY)
              GET(D_TABLE,D:KEY)
              IF ERROR()
                 D:R5=ROUND(SUM(33),.01)
                 IF ~(D:R1 = 1011) !~DIVIDENDES
                    D:R6=ROUND(SUM(2),.01)+ROUND(SUM(53),.01)
                    D:R10=ROUND(SUM(6),.01)
                    D:R11=ALG:PPF
                    D:R14=ALG:DZIVAP+ALG:IZDEV  !21.08.2010
                    D:R7=CALCNEA(1,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
                    D:R8=CALCNEA(2,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
                    IF INRANGE(ALG:INV_P,1,3)
                       D:R9=CALCNEA(3,0,0)         !INVAL F(KAL,PIEN/ATL/B-LAPA)
                    ELSIF INRANGE(ALG:INV_P,4,5)
                       D:R9=CALCNEA(3,0,0)         !PRP F(KAL,PIEN/ATL/B-LAPA)
                    .

                    IF MONTH(ALG:YYYYMM)=12
                      A_NM=SUM(21)                !ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS  ?05.05.2011
                    .
                 ELSE
                    DO CLEARD_TABLE
                 .
                 D:R16=ROUND(SUM(22)+SUM(23)+SUM(26)+SUM(27)+SUM(42),.01) !APRÇÍINÂTAIS NODOKLIS
                 D:R15=D:R5-D:R6-D:R10-D:R7-D:R8-D:R9-D:R11-D:R14

                 IF D:R5 !IR IEÒÇMUMI
                     ADD(D_TABLE)
                     SORT(D_TABLE,D:KEY)
                    IF ERROR() THEN STOP(ERROR()).
!              STOP(D:INI&D:R5)
                 .
              ELSE
                 D:R5+=ROUND(SUM(33),.01)
                 IF ~(D:R1 = 1011) !~DIVIDENDES
                    D:R6+=ROUND(SUM(2),.01)+ROUND(SUM(53),.01)
                    D:R10+=ROUND(SUM(6),.01)
                    D:R11+=ALG:PPF
                    D:R14+=ALG:DZIVAP+ALG:IZDEV  !21.08.2010
                    D:R7+=CALCNEA(1,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
                    D:R8+=CALCNEA(2,0,0)         !F(KAL,PIEN/ATL/B-LAPA)
                    IF INRANGE(ALG:INV_P,1,3)
                       D:R9+=CALCNEA(3,0,0)         !INVAL F(KAL,PIEN/ATL/B-LAPA)
                    ELSIF INRANGE(ALG:INV_P,4,5)
                       D:R9+=CALCNEA(3,0,0)         !PRP F(KAL,PIEN/ATL/B-LAPA)
                    .

                    IF MONTH(ALG:YYYYMM)=12
                      A_NM+=SUM(21)                !ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS  ?05.05.2011
                    .
                 .
                 D:R16+=ROUND(SUM(22)+SUM(23)+SUM(26)+SUM(27)+SUM(42),.01) !APRÇÍINÂTAIS NODOKLIS
                 D:R15=D:R5-D:R6-D:R10-D:R7-D:R8-D:R9-D:R11-D:R14
                 IF D:R5 !IR IEÒÇMUMI
                    PUT(D_TABLE)
                    IF ERROR() THEN STOP(ERROR()).
!              STOP(D:INI&D:R5)
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    MENESS=MENVAR(ALP:YYYYMM,2,2)
    PRINT(RPT:PageHead)
    SORT(D_TABLE,D:INI)
    GET(D_TABLE,0)
    LOOP I#=1 TO RECORDS(D_TABLE)
      GET(D_TABLE,I#)
      IF ~((F:KRI='A' AND D:R1=1001) OR (F:KRI='V' AND D:R1=1011) OR (F:KRI='B' AND D:R1=1008)) THEN CYCLE.
      IF SAV_PK=D:PK&D:PK1
         SAV_NPK=NPK
         NPK=0
      ELSE
         SAV_PK=D:PK&D:PK1
         NPK+=SAV_NPK+1
         SAV_NPK=0
      .
      IF D:R15<0 THEN D:R15=0.
      IF D:R16<0 THEN D:R16=0.
!      R1 =GETDAIEV(D:R1,0,8) !IVK
      IV=GETDAIEV(D:K1,0,9)   !IVK TEKSTS
      R2=IV[1:16]
      R2A=IV[17:32]
!      IF D:R1 = 1001 !DARBA ALGAI IZM.DATUMU NENORÂDA
!         D:R4=0
!      ELSE
!         IF ~INRANGE(D:R4,D:S_DAT,D:B_DAT)
!            KLUDA(0,'Ja ien.kods lielâks par 1001,izm.datumam jâbût atskaites periodâ:'&|
!            CLIP(D:VARDS)&' '&CLIP(D:UZVARDS))
!         .
!      .
!      STOP(D:INI&D:R5)
      PRINT(RPT:DETAIL)
      IF F:XML_OK#=TRUE
         XML:LINE='<R>'
         ADD(OUTFILEXML)
         XML:LINE=' Npk>'&CLIP(NPK)&'</Npk>'
         ADD(OUTFILEXML)
         XML:LINE=' SanNmrKods>'&DEFORMAT(D:PK&D:PK1,@P######-#####P)&'</SanNmrKods>'
         ADD(OUTFILEXML)
         XML:LINE=' SanNosaukums>'&CLIP(D:VARDS)&' '&CLIP(D:UZVARDS)&'</SanNosaukums>'
         ADD(OUTFILEXML)
         XML:LINE=' IenKods>'&D:R1&'</IenKods>'
!         XML:LINE=' IenKods>'&R1&'</IenKods>'
         ADD(OUTFILEXML)
         XML:LINE=' IenVeids>'&CLIP(IV)&'</IenVeids>'
         ADD(OUTFILEXML)
         XML:LINE=' IenPeriodsNo>'&FORMAT(D:S_DAT,@D010-)&'T00:00:00</IenPeriodsNo>'
         ADD(OUTFILEXML)
         XML:LINE=' IenPeriodsLidz>'&FORMAT(D:B_DAT,@D010-)&'T00:00:00</IenPeriodsLidz>'
         ADD(OUTFILEXML)
         IF D:R4
            XML:LINE=' IenIzmDatums>'&FORMAT(D:R4,@D010-)&'T00:00:00</IenIzmDatums>'
            ADD(OUTFILEXML)
         .
         LOOP R#=5 TO 16
            EXECUTE R#-4
               RI=D:R5
               RI=D:R6
               RI=D:R7
               RI=D:R8
               RI=D:R9
               RI=D:R10
               RI=D:R11
               RI=D:R12
               RI=D:R13
               RI=D:R14
               RI=D:R15
               RI=D:R16
            .
            IF ~RI THEN CYCLE.
            XML:LINE='<R'&FORMAT(R#,@N02)&'>'&CLIP(RI)&'</R'&FORMAT(R#,@N02)&'>'
            ADD(OUTFILEXML)
         .
         XML:LINE='</R>'
         ADD(OUTFILEXML)
      .
    .
    PRINT(RPT:DETAIL1)     !Kopâ
    IF F:XML_OK#=TRUE
        XML:LINE='</Rs>'
        ADD(OUTFILEXML)
        XML:LINE='</Tab>'
        ADD(OUTFILEXML)
        XML:LINE='</DokPFPISK2008v1>'
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
    ALGPA::Used -= 1
    IF ALGPA::Used = 0 THEN CLOSE(ALGPA).
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
  NEXT(Process:View)  !CAURI KADRIEM
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

!-----------------------------------------------------------------------------
CLEARD_TABLE  ROUTINE
!  D:R1=''    !IEN V KODS (VID)
!  D:K1=''    !IEN VEIDS (ASSAKO)
!  R2=''
!  R2A=''
!  D:R4=0     !IIN_DATUMS
!  D:R5=0
  D:R6=0
  D:R7=0
  D:R8=0
  D:R9=0
  D:R10=0
  D:R11=0
  D:R12=0
  D:R13=0
  D:R14=0
  D:R15=0
  D:R16=0
  A_NM  =0

B_Bilance2008        PROCEDURE                    ! Declare Procedure
LocalRequest         LONG,AUTO
LocalResponse        LONG,AUTO
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
RejectRecord         LONG
OriginalRequest      LONG

CG                   STRING(10)
DAT                  DATE
LAI                  TIME

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA0          DECIMAL(13,2)
SUMMA           DECIMAL(13,2)
SUMMAR0         DECIMAL(11)
SUMMAR          DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(8)
SUMMA           DECIMAL(13,2)
            .
!I_TABLE     QUEUE,PRE(I)
!BKK             STRING(5)
!DATUMS          LONG
!SUMMA           DECIMAL(13,2)
!            .

R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
R_USER               LIKE(KONR:USER)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
CNTRL1               DECIMAL(13,2)
CNTRL2               DECIMAL(13,2)
CNTRL3               DECIMAL(13,2)
CNTRL10              DECIMAL(13,2)
CNTRL20              DECIMAL(13,2)
CNTRL30              DECIMAL(13,2)
CNTRLR1              DECIMAL(11)
CNTRLR2              DECIMAL(11)
CNTRLR3              DECIMAL(11)
CNTRLR4              DECIMAL(11)
CNTRLR10             DECIMAL(11)
CNTRLR20             DECIMAL(11)
CNTRLR30             DECIMAL(11)
CNTRLR40             DECIMAL(11)
BA400                DECIMAL(11)
NPP2450              DECIMAL(11)
BP520                DECIMAL(11)
PZA2180              DECIMAL(11)
CITI_DOK             BYTE
R10                  STRING(30)
R20                  STRING(30)
R40                  STRING(30)

NOLIDZ               STRING(30)
S_SUMMA              STRING(15)  !WMF
S_SUMMA0             STRING(15)
E_SUMMA              STRING(15)  !EXCEL
E_SUMMA0             STRING(15)
E                    STRING(1)
EE                   STRING(15)
CNTRL                DECIMAL(13,2)
ERR_BKK              LIKE(KON:BKK)

TEX:XML             STRING(100)
XMLFILENAME         CSTRING(200),STATIC
XMLSFILENAME        CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END
OUTFILEXMLS  FILE,DRIVER('ASCII'),NAME(XMLSFILENAME),PRE(XMLS),CREATE,BINDABLE,THREAD
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
!report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
report REPORT,AT(100,300,8000,10896),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
TIT_List DETAIL,AT(,,,6677),USE(?RPT:TIT_List)
         STRING(@s1),AT(6260,313),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING(@s15),AT(6625,417),USE(EE),TRN
         STRING('Izstrâdâts atbilstoði'),AT(6594,802),USE(?T1),TRN,HIDE
         STRING('2006.g.19.oktobrî '),AT(6667,979),USE(?T2),TRN,HIDE
         STRING('pieòemtajiem grozîjumiem likumâ'),AT(5979,1156),USE(?T3),TRN,HIDE
         STRING('"Pat uzòçmuma gada pârskatiem"'),AT(5896,1333),USE(?T4),TRN,HIDE
         STRING('Nosaukums'),AT(417,3135),USE(?String375),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Reìistrâcijas kods komercreìistrâ vai uzòçmumu  reìistrâ'),AT(417,2865),USE(?String375:3), |
             LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Vidçjais darbinieku skaits'),AT(417,3698),USE(?String375:7),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s4),AT(2760,3698,417,208),USE(PAR_GRUPA),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatdarbîbas veids NACE'),AT(427,3979),USE(?String375:2),TRN,LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@n_4),AT(2760,3979,417,208),USE(GL:NACE),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskata periods'),AT(417,2615,1458,208),USE(?String375:8),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s30),AT(2760,2604,2552,208),USE(nolidz),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('B I L A N C E'),AT(2833,4396,2240,365),USE(?String377:2),CENTER,FONT(,26,,FONT:bold,CHARSET:BALTIC)
         STRING('Iesniegðanas datums _{21}'),AT(4375,5052,3500,240),USE(?String381:4),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Saòemðanas datums _{21}'),AT(4375,5573,3396,240),USE(?String381:3),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s45),AT(2750,3125,4271,208),USE(CLIENT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2750,3396,5104,208),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Juridiskâ adrese'),AT(427,3406),USE(?String375:4),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s11),AT(4688,2865),USE(gl:reg_nr),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
TIT_List1 DETAIL,AT(,,,9250),USE(?RPT:TIT_List1)
         STRING(@s1),AT(6260,281),USE(E,,?E1),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING(@s15),AT(6625,417),USE(EE,,?EE1),TRN
         STRING('Izstrâdâts atbilstoði'),AT(6594,802),USE(?T11),TRN
         STRING('2006.g.19.oktobrî '),AT(6667,979),USE(?T21),TRN
         STRING('pieòemtajiem grozîjumiem likumâ'),AT(5979,1156),USE(?T31),TRN
         STRING('"Pat uzòçmuma gada pârskatiem"'),AT(5896,1333),USE(?T41),TRN
         STRING('Nosaukums'),AT(417,3135),USE(?String3751),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Reìistrâcijas kods komercreìistrâ vai uzòçmumu  reìistrâ'),AT(417,2865),USE(?String375:31), |
             LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Vidçjais darbinieku skaits'),AT(417,3698),USE(?String375:71),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s4),AT(2760,3698,417,208),USE(PAR_GRUPA,,?PG1),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatdarbîbas veids NACE'),AT(427,3979),USE(?String375:21),TRN,LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@n_4),AT(2760,3979,417,208),USE(GL:NACE,,?NC1),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârskata periods'),AT(417,2615,1458,208),USE(?String375:81),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s30),AT(2760,2604,2552,208),USE(nolidz,,?NO1),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('B I L A N C E'),AT(2833,6146,2240,365),USE(?String377),CENTER,FONT(,26,,FONT:bold,CHARSET:BALTIC)
         STRING('Iesniegðanas datums'),AT(4375,8177,1448,240),USE(?String381),LEFT,FONT(,11,,,CHARSET:BALTIC)
         LINE,AT(5833,8438,1719,0),USE(?Line40),COLOR(COLOR:Black)
         STRING('Saòemðanas datums'),AT(4375,8698,1458,240),USE(?String381:2),LEFT,FONT(,11,,,CHARSET:BALTIC)
         LINE,AT(5833,8958,1719,0),USE(?Line40:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2750,3125,4271,208),USE(CLIENT,,?C1),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2750,3396,5104,208),USE(GL:ADRESE,,?AD1),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Juridiskâ adrese'),AT(427,3406),USE(?String375:41),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s11),AT(4688,2865),USE(gl:reg_nr,,?RE1),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
AKTIVS DETAIL,AT(,,8000,260),USE(?unnamed:5)
         STRING('Slçgums'),AT(5865,63,938,188),USE(?FB),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6854,63,938,188),USE(?BB),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,0,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('AKTÎVS'),AT(1156,63,3385,190),USE(?client:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,260),USE(?Line2),COLOR(COLOR:Black)
       END
AKTIVS1 DETAIL,PAGEBEFORE(-1),AT(,,8000,260),USE(?unnamed:51)
         STRING('Slçgums'),AT(5865,63,938,188),USE(?FB1),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6854,63,938,188),USE(?BB1),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,0,0,260),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:41),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:51),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line11),COLOR(COLOR:Black)
         STRING('AKTÎVS'),AT(1156,63,3385,190),USE(?client:31),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,260),USE(?Line21),COLOR(COLOR:Black)
       END
AKTIVSA DETAIL,PAGEBEFORE(-1),AT(,,8000,260)
         STRING('Final balance'),AT(5865,63,938,188),USE(?FB:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beginning b.'),AT(6854,63,938,188),USE(?BB:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,0,0,260),USE(?Line2A:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2A:4),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2A:5),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2A:2),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1A),COLOR(COLOR:Black)
         STRING('A S S E T S'),AT(1115,52,3438,208),USE(?ASSES:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,260),USE(?Line2A),COLOR(COLOR:Black)
       END
VIRSRAKSTSBB DETAIL,AT(,,8000,198)
         LINE,AT(156,0,0,197),USE(?Line2:6B),COLOR(COLOR:Black)
         STRING(@s100),AT(198,10,5208,156),USE(R_NOSAUKUMS,,?V_NOSAUKUMS:2B),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,0,0,197),USE(?Line2:7B),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,197),USE(?Line2:8B),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,197),USE(?Line2:9B),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,197),USE(?Line2:10B),COLOR(COLOR:Black)
       END
VIRSRAKSTSB DETAIL,AT(,,8000,198)
         LINE,AT(156,0,0,197),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s100),AT(198,10,5208,156),USE(R_NOSAUKUMS,,?V_NOSAUKUMS:4),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,0,0,197),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,197),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,197),USE(?Line2:10),COLOR(COLOR:Black)
       END
VIRSRAKSTS DETAIL,AT(,,8000,198)
         LINE,AT(156,0,0,197),USE(?Line2V:6),COLOR(COLOR:Black)
         STRING(@s100),AT(198,10,5208,156),USE(R_NOSAUKUMS),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5417,0,0,197),USE(?Line2V:7),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,197),USE(?Line2V:8),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,197),USE(?Line2V:9),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,197),USE(?Line2V:10),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,156)
         STRING(@s3),AT(5521,5,260,140),USE(R:KODS),CENTER,FONT(,9,,)
         STRING(@S15),AT(5865,5,938,135),USE(S_SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S15),AT(6854,5,938,135),USE(S_SUMMA0),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(156,0,0,156),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,156),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,156),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,156),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,156),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s100),AT(198,5,5208,140),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT(1)
       END
DETAILB DETAIL,AT(,,,177)
         STRING(@s100),AT(198,5,5208,150),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2B),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5521,5,260,150),USE(R:KODS,,?R:KODS:B),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(5865,5,938,156),USE(S_SUMMA,,?S_SUMMA:B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(6854,5,938,156),USE(S_SUMMA0,,?S_SUMMA0:B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,177),USE(?Line2B:11),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,177),USE(?Line2B:12),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,177),USE(?Line2B:13),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,177),USE(?Line2B:14),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,177),USE(?Line2B:15),COLOR(COLOR:Black)
       END
DETAILBB DETAIL,AT(,,,177)
         STRING(@s100),AT(198,5,5208,150),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2BB),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5521,5,260,150),USE(R:KODS,,?R:KODS:B1),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(5865,5,938,156),USE(S_SUMMA,,?S_SUMMA:B1),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(6854,5,938,156),USE(S_SUMMA0,,?S_SUMMA0:B1),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,177),USE(?Line2B:11B),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,177),USE(?Line2B:12B),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,177),USE(?Line2B:13B),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,177),USE(?Line2B:14B),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,177),USE(?Line2B:15B),COLOR(COLOR:Black)
       END
DETAILBKK DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(156,0,0,177),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s50),AT(1042,10,4271,150),USE(B_NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,150),USE(KON:BKK),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5885,10,,150),USE(B:SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5417,0,0,177),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,177),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,177),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,177),USE(?Line2:20),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,104)
         LINE,AT(156,0,0,104),USE(?Line2:211),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,104),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,104),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,104),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,104),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(156,,7656,0),USE(?Line1L:2),COLOR(COLOR:Black)
       END
PAGE_FOOT DETAIL,AT(,,,115)
         LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,62),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,62),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,62),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(156,0,0,62),USE(?Line2:25),COLOR(COLOR:Black)
       END
PASIVS DETAIL,AT(,,,260),USE(?unnamedP)
         LINE,AT(156,0,0,260),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:311),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,260),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:34),COLOR(COLOR:Black)
         STRING('PASÎVS'),AT(208,52,5208,208),USE(?client:8),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Slçgums'),AT(5885,52,938,208),USE(?client:7),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6875,52,938,208),USE(?client:6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
PASIVS1 DETAIL,PAGEBEFORE(-1),AT(,,,260),USE(?unnamedP1)
         LINE,AT(156,0,0,260),USE(?Line2:301),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:311P),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,260),USE(?Line2:321),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:331),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:341),COLOR(COLOR:Black)
         STRING('PASÎVS'),AT(208,52,5208,208),USE(?client:81),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Slçgums'),AT(5885,52,938,208),USE(?client:71),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6875,52,938,208),USE(?client:61),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,7656,0),USE(?Line1:41),COLOR(COLOR:Black)
       END
PASIVSA DETAIL,PAGEBEFORE(-1),AT(,,,260)
         LINE,AT(156,0,0,260),USE(?Line2A:30),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2A:31),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,260),USE(?Line2A:32),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2A:33),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2A:34),COLOR(COLOR:Black)
         STRING('L I A B I L I T I E S'),AT(208,52,5208,208),USE(?LA:8),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Final balance'),AT(5885,52,938,208),USE(?FB:7),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beginning b.'),AT(6875,52,938,208),USE(?BB:6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,7656,0),USE(?Line1A:4),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,542),USE(?unnamed:2)
         LINE,AT(156,0,0,62),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,62),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,62),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,62),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RC :'),AT(167,73),USE(?String31),FONT(,6,,,CHARSET:ANSI)
         STRING(@s1),AT(344,73,104,135),USE(RS),CENTER,FONT(,6,,,CHARSET:ANSI)
         STRING(@D06.),AT(6677,73,625,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7313,73,521,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(1010,281),USE(SYS:AMATS1),TRN,RIGHT
         STRING(@s25),AT(4969,281),USE(SYS:PARAKSTS1),TRN,LEFT
         STRING('_{38}'),AT(2583,396),USE(?String35),TRN
       END
       FOOTER,AT(100,11200,8000,156),USE(?unnamed:4)
         STRING(@P<<<#. lapaP),AT(7240,10,573,156),PAGENO,USE(?PageCount),RIGHT
       END
     END

!       FOOTER,AT(100,11200,8000,156),USE(?unnamed:4)
!         LINE,AT(156,0,7656,0),USE(?Line1:6),COLOR(COLOR:Black)
!         STRING(@P<<<#. lapaP),AT(7240,10,573,156),PAGENO,USE(?PageCount),RIGHT
!       END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,152,63),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

Window WINDOW('Citi dokumenti'),AT(,,245,85),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Norâdiet failu vârdus :'),AT(68,10),USE(?String3)
       STRING('10.rinda "Pielikums"'),AT(9,22),USE(?String1)
       ENTRY(@s30),AT(136,22,100,10),USE(R10)
       STRING('20.rinda "Vadîbas ziòojums"'),AT(9,35),USE(?String2)
       ENTRY(@s30),AT(136,35,100,10),USE(R20)
       STRING('40.rinda "Paskaidrojums par UGP apst."'),AT(9,48),USE(?String4)
       ENTRY(@s30),AT(136,48,100,10),USE(R40)
       BUTTON('OK'),AT(161,65,35,14),USE(?OkCITI),DEFAULT
       BUTTON('Atlikt'),AT(200,65,36,14),USE(?CancelCITI)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  FilesOpened = True

  IF F:XML
     E='E'
     EE='(UGP2008.XML)'
  .
  CLEAR(KONR:RECORD)
  KONR:UGP='B'
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='B') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA0=0  !SÂKUMA BILANCE
     R:SUMMA=0   !SLÇGUMA BILANCE
     ADD(R_TABLE)
  .

  IF KON_K::USED=0
     CHECKOPEN(KON_K,1)
  .
  KON_K::Used += 1
  IF GG::USED=0
     CHECKOPEN(GG,1)
  .
  GG::Used += 1
  IF GGK::USED=0
     CHECKOPEN(GGK,1)
  .
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bilance'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(GGK:RECORD)
     CG = 'K120000'
!          1234567
     NOLIDZ='no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
     Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
     DAT = TODAY()
     LAI = CLOCK()
      IF F:DBF='W'   !WMF
         OPEN(report)
         report{Prop:Preview} = PrintPreviewImage
         SETTARGET(REPORT,?rpt:TIT_List)
         IMAGE(188,281,2083,521,'USER.BMP')
         print(rpt:TIT_List)
      ELSE           !Word,Excel
        IF ~OPENANSI('BILANCE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        IF F:VALODA=0
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma  nosaukums '&CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Adrese '&GL:ADRESE
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ '&gl:reg_nr
            ADD(OUTFILEANSI)
            IF GL:VID_NR
               OUTA:LINE='Uzòçmuma reìistrâcijas numurs PVN apliekamo personu reìistrâ '&GL:VID_NR
            .
            ADD(OUTFILEANSI)
            OUTA:LINE='Darbinieku skaits '&PAR_GRUPA
            ADD(OUTFILEANSI)
            OUTA:LINE='Pamatdarbîbas veids NACE '&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Taksâcijas periods '&NOLIDZ
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='                 BILANCE'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Address '&GL:ADRESE
            ADD(OUTFILEANSI)
            OUTA:LINE='Registration Nr '&gl:reg_nr
            ADD(OUTFILEANSI)
            IF GL:VID_NR
               OUTA:LINE='VAT Registration Nr '&GL:VID_NR
            .
            ADD(OUTFILEANSI)
            OUTA:LINE='Emploies '&PAR_GRUPA
            ADD(OUTFILEANSI)
            OUTA:LINE='Branch NACE '&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Period '&NOLIDZ
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='                 BALANCE'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
        .
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\UGP2008.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           EMPTY(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods'). !vienkârði kontrolei
           F:XML_OK#=TRUE
           XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE=' DokUGP2008v1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
           ADD(OUTFILEXML)
           IF ~GL:REG_NR THEN KLUDA(87,'Jûsu NMR kods').       !vienkârði kontrolei
           XML:LINE=' NmrKods>'&CLIP(GL:REG_NR)&'</NmrKods>'             !bez LV
           ADD(OUTFILEXML)
           XML:LINE=' TaksNo>'&FORMAT(S_DAT,@D010-)&'T00:00:00</TaksNo>'
           ADD(OUTFILEXML)
           XML:LINE=' TaksLidz>'&FORMAT(B_DAT,@D010-)&'T00:00:00</TaksLidz>'
           ADD(OUTFILEXML)
           IF PAR_GRUPA<1
              KLUDA(87,'darbinieku skaits')       !kïuda neies cauri EDSâ
              PAR_GRUPA='0'
           .
           XML:LINE=' Darbinieki>'&CLIP(PAR_GRUPA)&'</Darbinieki>'
           ADD(OUTFILEXML)
           XML:LINE=' Vaditajs>'&CLIP(SYS:PARAKSTS1)&'</Vaditajs>'
           ADD(OUTFILEXML)
           XML:LINE=' SlegBilance>1</SlegBilance>'
           ADD(OUTFILEXML)
!revidents
           XML:LINE=' Darbv>'
           ADD(OUTFILEXML)
           XML:LINE=' Rs>'
           ADD(OUTFILEXML)
           XML:LINE='<R>'
           ADD(OUTFILEXML)
           XML:LINE=' Npk>1</Npk>'
           ADD(OUTFILEXML)
           XML:LINE=' NaceDarb>'&GL:NACE&'</NaceDarb>'
           ADD(OUTFILEXML)
           XML:LINE=' PamatDarb>1</PamatDarb>'
           ADD(OUTFILEXML)
           XML:LINE='</R>'
           ADD(OUTFILEXML)
           XML:LINE='</Rs>'
           ADD(OUTFILEXML)
           XML:LINE='</Darbv>'
           ADD(OUTFILEXML)

           XMLSFILENAME=USERFOLDER&'\PZA22008.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (PEÏÒAS/ZAUDÇJUMU APRÇÍINS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
           XMLSFILENAME=USERFOLDER&'\NPP22008.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (NAUDAS PLÛSMAS PÂRSKATS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
           XMLSFILENAME=USERFOLDER&'\PKIP2008.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (PAÐU KAPITÂLA IZMAIÒU PÂRSKATS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
           OPEN(WINDOW)
           CITI_DOK=FALSE
!           R10=USERFOLDER&'\UGP_PIELIKUMS.RAR'
!           R20=USERFOLDER&'\UGP_VADZIN.RAR'
!           R40=USERFOLDER&'\UGP_PASKAIDROJUMS.RAR'
           R10='UGP_PIELIKUMS.RAR'
           R20='UGP_VADZIN.RAR'
           R40='UGP_PASKAIDROJUMS.RAR'
           DISPLAY
           ACCEPT
              CASE FIELD()
              OF ?OKCITI
                 IF EVENT()=EVENT:ACCEPTED
                    IF R10 OR R20 OR R40
                       CITI_DOK=TRUE
                    .
                    BREAK
                 .
              OF ?CANCELCITI
                 IF EVENT()=EVENT:ACCEPTED THEN BREAK.
              .
           .
           CLOSE(WINDOW)
        .
      .
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
        IF GETKON_K(GGK:BKK,3,1)
           LOOP J# = 1 TO 4
              IF kon:PZB[J#]
                 R:KODS=kon:PZB[J#]
                 GET(R_TABLE,R:KODS)
                 IF ERROR()
                    IF ~(ERR_BKK=KON:BKK)
                       KLUDA(71,KON:BKK&': '&kon:PZB[J#])
                       ERR_BKK=KON:BKK
                    .
                 ELSE
                    IF GGK:D_K='D'
                       R:SUMMA+=GGK:SUMMA
                       IF GGK:U_NR=1 THEN R:SUMMA0+=GGK:SUMMA.
                    ELSE
                        R:SUMMA-=GGK:SUMMA
                        IF GGK:U_NR=1 THEN R:SUMMA0-=GGK:SUMMA.
                    .
                    PUT(R_TABLE)
                    IF F:DTK  !IZVÇRSTÂ VEIDÂ
                       B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_3)
                       GET(B_TABLE,B:BKK_KODS)
                       IF ERROR()
                          IF GGK:D_K='D'
                             B:SUMMA=GGK:SUMMA
                          ELSE
                             B:SUMMA=-GGK:SUMMA
                          .
                          ADD(B_TABLE)
                          SORT(B_TABLE,B:BKK_KODS)
                       ELSE
                          IF GGK:D_K='D'
                             B:SUMMA+=GGK:SUMMA
                          ELSE
                             B:SUMMA-=GGK:SUMMA
                          .
                          PUT(B_TABLE)
                       .
                    .
                 .
              .
           .
        ELSE    ! KONTA NAV VISPAR
           KLUDA(0,'Kontu plânâ nav atrodams: '&ggk:bkk&' U_nr='&GGK:U_NR&' no '&FORMAT(GGK:DATUMS,@D06.))
           CLOSE(ProgressWindow)
           CLOSE(report)
           DO PROCEDURERETURN
        .
        LOOP
          DO GetNextRecord
          DO ValidateRecord
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:Ok
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          Localresponse = RequestCompleted
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
     CASE EVENT()
     OF Event:Accepted
       LocalResponse = RequestCancelled
       POST(Event:CloseWindow)
     END
   END
  END

  IF F:VALODA=1 !ANGLISKI
     IF F:DBF = 'W'
        print(RPT:AKTIVSA)
        print(RPT:SVITRA)
     ELSE
        OUTA:LINE='A S S E T S'&CHR(9)&'CODE'&CHR(9)&'FINAL BALANCE'&CHR(9)&'BEGINNING BALANCE'
        ADD(OUTFILEANSI)
     .
  ELSE
     IF F:DBF = 'W'
        print(RPT:AKTIVS)
        print(RPT:SVITRA)
     ELSE
        OUTA:LINE=' AKTÎVS'&CHR(9)&'Kods'&CHR(9)&'Slçgums'&CHR(9)&'Sâkums'
        ADD(OUTFILEANSI)
     .
  .
  IF F:XML_OK#=TRUE
     XML:LINE=' Ba>' !Bilance-Aktîvs
     ADD(OUTFILEXML)
  .
!------------------
  DO FILL_R_TABLE
!------------------
  LOOP I#= 1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N03),'010210430540580',3)  !PIRMS ÐITIEM LIELAIS VIRSRAKSTS
     IF V#
        IF F:VALODA=1 !ANGLISKI
           EXECUTE V#
              R_NOSAUKUMS='1.LONG-TERM INVESTMENTS'
              R_NOSAUKUMS='2.CURRENT ASSETS'
              R_NOSAUKUMS='1.EQUITY CAPITAL'
              R_NOSAUKUMS='2.STOCKPILES'
              R_NOSAUKUMS='3.CREDITORS'
           .
        ELSE
           EXECUTE V#
              R_NOSAUKUMS='1. Ilgtermiòa ieguldîjumi'
              R_NOSAUKUMS='2. Apgrozâmie lîdzekïi'
              R_NOSAUKUMS='1. Paðu kapitâls'
              R_NOSAUKUMS='2. Uzkrâjumi'
              R_NOSAUKUMS='3. Kreditori'
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:VIRSRAKSTSBB)
        ELSE
           OUTA:LINE=R_NOSAUKUMS
           ADD(OUTFILEANSI)
        .
     .
     V#=INSTRING(FORMAT(R:KODS,@N03),'010060103109115210272280360460510580650',3)  !PIRMS ÐITIEM MAZAIS VIRSRAKSTS
     IF V#
        IF F:VALODA=1 !ANGLISKI
           EXECUTE V#
              R_NOSAUKUMS='I.INTANGIBLE INVESTMENTS'
              R_NOSAUKUMS='II.FIXED ASSETS'
              R_NOSAUKUMS='III'
              R_NOSAUKUMS='IV'
              R_NOSAUKUMS='V.LONG=TERM FINANCIAL INVESTMENTS'
              R_NOSAUKUMS='I.STOCKS'
              R_NOSAUKUMS='II.'
              R_NOSAUKUMS='III.DEBTORS'
              R_NOSAUKUMS='IV.SECURITIES AND PARTICIPATION IN CAPITALS'
              R_NOSAUKUMS='5.Reserves'
              R_NOSAUKUMS='9.'
              R_NOSAUKUMS='I.LONG-TERM DEBTS'
              R_NOSAUKUMS='II.SHORT-TERM DEBTS'
           .
        ELSE
           EXECUTE V#
              R_NOSAUKUMS='I Nemateriâlie ieguldîjumi'
              R_NOSAUKUMS='II Pamatlîdzekïi'
              R_NOSAUKUMS='III Ieguldîjuma îpaðumi'
              R_NOSAUKUMS='IV Bioloìiskie aktîvi'
              R_NOSAUKUMS='V Ilgtermiòa finansu ieguldîjumi'
              R_NOSAUKUMS='I Krâjumi'
              R_NOSAUKUMS='II Pârdoðanai turçti ilgtermiòa ieguldîjumi'
              R_NOSAUKUMS='III Debitori'
              R_NOSAUKUMS='IV Îstermiòa finansu ieguldîjumi'
              R_NOSAUKUMS='5.Rezerves'
              R_NOSAUKUMS='9.Nesadalîtâ peïòa'
              R_NOSAUKUMS='I Ilgtermiòa kreditori'
              R_NOSAUKUMS='II Îstermiòa kreditori'
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:VIRSRAKSTSB)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS
           ADD(OUTFILEANSI)
        .
!       CNTRL1 =0
!       CNTRL10=0
     .

     IF F:VALODA=1 !ANGLISKI
        R_NOSAUKUMS=GETKON_R('B',R:KODS,0,2)
     ELSE
        R_NOSAUKUMS=GETKON_R('B',R:KODS,0,1)
     .
     R_USER=GETKON_R('B',R:KODS,0,3)
     IF R:KODS=50 OR R:KODS=100 OR R:KODS=107 OR R:KODS=113 OR R:KODS=190 OR R:KODS=270 OR R:KODS=276 OR|
        R:KODS=350 OR R:KODS=390 OR R:KODS=500 OR R:KODS=640 OR R:KODS=780 !MAZIE KOPÂ
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)                                          
        .
     ELSIF R:KODS=200 OR R:KODS=410 OR R:KODS=530 OR R:KODS=570 OR R:KODS=790 !LIELIE KOPÂ
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILBB)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
        .
     ELSIF R:KODS=420   !BILANCE_Aktîvs
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILBB)
           PRINT(RPT:LINE)
           IF F:VALODA=1 !ANGLISKI
              print(RPT:PASIVSA)
           ELSE
              print(RPT:PASIVS)
           .
           print(RPT:SVITRA)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
           IF F:VALODA=1 !ANGLISKI
              OUTA:LINE=''
              ADD(OUTFILEANSI)
              OUTA:LINE='LIABILITIES'&CHR(9)&'CODE'&CHR(9)&'FINAL BALANCE'&CHR(9)&'BEGINNING BALANCE'
              ADD(OUTFILEANSI)
           ELSE
              OUTA:LINE=''
              ADD(OUTFILEANSI)
              OUTA:LINE=' PASÎVS'&CHR(9)&'Kods'&CHR(9)&'Slçgums'&CHR(9)&'Sâkums'
              ADD(OUTFILEANSI)
           .
        .
     ELSIF R:KODS=800
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
        .
     ELSE
        DO FILL_SUMMAS
        IF R:KODS=400 !NAUDA
           IF F:DBF = 'W'
              PRINT(RPT:DETAILBB)
           ELSE
              OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
              ADD(OUTFILEANSI)
           .
        ELSE
           IF ~(F:CEN AND ~R:SUMMA AND ~R:SUMMA0) !NEDRUKÂT TUKÐAS RINDAS
              IF F:DBF = 'W'
                 PRINT(RPT:DETAIL)
              ELSE
                 OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
                 ADD(OUTFILEANSI)
              .
           .
        .
        IF F:DTK !IZVÇRSTÂ VEIDÂ BEZ STARPSUMMÂM
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 !15.01.2015 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 IF F:VALODA=1 !ANGLISKI
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,4)
                 ELSE
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 .

                 IF F:DBF = 'W'
                    PRINT(RPT:DETAILBKK)
                 ELSE
                    OUTA:LINE='   '&B_BKK&' '&B_NOSAUKUMS&CHR(9)&CHR(9)&LEFT(FORMAT(B:SUMMA,@N-_14.2)) !ÐITOS NEAPAÏOJAM
                    ADD(OUTFILEANSI)
                 .
              .
           .
        .
        IF F:DBF = 'W'
           IF ~(F:CEN AND ~R:SUMMA AND ~R:SUMMA0) !NEDRUKÂT TUKÐAS RINDAS
              PRINT(RPT:LINE)
           .
        .
     .
     IF F:XML_OK#=TRUE
        IF (R:SUMMAR0 OR R:SUMMAR)
           XML:LINE='<R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
           XML:LINE=' VertSak>'&CLIP(R:SUMMAR0)&'</VertSak>'
           ADD(OUTFILEXML)
           XML:LINE=' VertBeig>'&CLIP(R:SUMMAR)&'</VertBeig>'
           ADD(OUTFILEXML)
           IF R_USER
              XML:LINE=' Teksts>'&CLIP(R_NOSAUKUMS)&'</Teksts>'
              ADD(OUTFILEXML)
           .
           XML:LINE='</R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
        .
        IF R:KODS=420
           XML:LINE='</Ba>' !Bilance-Aktîvs beigas
           ADD(OUTFILEXML)
           XML:LINE=' Bp>'  !Bilance-Pasîvs
           ADD(OUTFILEXML)
        .
        IF R:KODS=400 !ÐITO PÂRBAUDA ARÎ EDSv5.12.
           BA400=R:SUMMAR
        .
        IF R:KODS=520 !ÐITO PÂRBAUDA ARÎ EDSv5.12.
           BP520=R:SUMMAR
        .
     .
  .
  IF F:DBF = 'W'
    PRINT(RPT:FOOTER)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='          '&CLIP(SYS:AMATS1)&':________________________'&CLIP(SYS:PARAKSTS1)
    ADD(OUTFILEANSI)
  .

  IF F:XML_OK#=TRUE
     XML:LINE='</Bp>' !Beigas Bilance-Pasîvs
     ADD(OUTFILEXML)
     IF CITI_DOK=TRUE
        XML:LINE=' Citidok>'
        ADD(OUTFILEXML)
        XML:LINE=' R10>'
        ADD(OUTFILEXML)
        XML:LINE=' FailaNos>'&CLIP(R10)&'</FailaNos>'
        ADD(OUTFILEXML)
        XML:LINE=' Fails>VG1rYWgkcG11bedycw0K</Fails>'
        ADD(OUTFILEXML)
        XML:LINE=' DokKoment />'
        ADD(OUTFILEXML)
        XML:LINE=' DocTypeId>990000060</DocTypeId>'
        ADD(OUTFILEXML)
        XML:LINE=' /R10>'
        ADD(OUTFILEXML)
        XML:LINE=' R20>'
        ADD(OUTFILEXML)
        XML:LINE=' FailaNos>'&CLIP(R20)&'</FailaNos>'
        ADD(OUTFILEXML)
        XML:LINE=' Fails>VG1rYWgkcG11bedycw0K</Fails>'
        ADD(OUTFILEXML)
        XML:LINE=' DokKoment />'
        ADD(OUTFILEXML)
        XML:LINE=' DocTypeId>990000061</DocTypeId>'
        ADD(OUTFILEXML)
        XML:LINE=' /R20>'
        ADD(OUTFILEXML)
        XML:LINE=' R40>'
        ADD(OUTFILEXML)
        XML:LINE=' FailaNos>'&CLIP(R40)&'</FailaNos>'
        ADD(OUTFILEXML)
        XML:LINE=' Fails>VG1rYWgkcG11bedycw0K</Fails>'
        ADD(OUTFILEXML)
        XML:LINE=' DokKoment />'
        ADD(OUTFILEXML)
        XML:LINE=' DocTypeId>990003002</DocTypeId>'
        ADD(OUTFILEXML)
        XML:LINE=' /R40>'
        ADD(OUTFILEXML)
        XML:LINE=' /Citidok>'
        ADD(OUTFILEXML)
     .
     XML:LINE=' AizpAmats>'&CLIP(SYS:AMATS2)&'</AizpAmats>'
     ADD(OUTFILEXML)
     XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
     ADD(OUTFILEXML)
     XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
     ADD(OUTFILEXML)
     TEX:XML=CLIENT
     DO CONVERT_TEX:XML
     XML:LINE=' NmNosaukums>'&CLIP(TEX:XML)&'</NmNosaukums>'
     ADD(OUTFILEXML)
     TEX:XML=GL:ADRESE                                       !max 250
     DO CONVERT_TEX:XML
     XML:LINE=' NmAdrese>'&CLIP(TEX:XML)&'</NmAdrese>'
     ADD(OUTFILEXML)
     XML:LINE=' DatumsAizp>'&FORMAT(TODAY(),@D010-)&'T00:00:00</DatumsAizp>'
     ADD(OUTFILEXML)
     XML:LINE='</DokUGP2008v1>'
     ADD(OUTFILEXML)
     SET(OUTFILEXML)
     LOOP
        NEXT(OUTFILEXML)
        IF ERROR() THEN BREAK.
        IF ~XML:LINE[1]
           XML:LINE[1]='<'
           PUT(OUTFILEXML)
        .
        IF XML:LINE[2:6]='Npp2>'
           NPP2#=TRUE
        .
        IF XML:LINE[1:7]='</Npp2>'
           NPP2#=FALSE
        .
        IF NPP2#=TRUE AND XML:LINE[1:6]='<R450>'
           NPP2R#=TRUE
        .
        IF NPP2R#=TRUE AND XML:LINE[2:10]='VertBeig>'
           R#=INSTRING('/',XML:LINE,1)
           NPP2450=XML:LINE[11:R#-2]
           NPP2R#=FALSE
           NPP2#=FALSE
        .
        IF XML:LINE[2:6]='Pza2>'
           PZA2#=TRUE
!           STOP('Pza2')
        .
        IF XML:LINE[1:7]='</Pza2>'
           PZA2#=FALSE
!           STOP('/Pza2')
        .
        IF PZA2#=TRUE AND XML:LINE[1:6]='<R180>'
           PZA2R#=TRUE
!           STOP('R180')
        .
        IF PZA2R#=TRUE AND XML:LINE[2:10]='VertBeig>'
           R#=INSTRING('/',XML:LINE,1)
           PZA2180=XML:LINE[11:R#-2]
!           STOP(XML:LINE[11:R#-2])
           PZA2R#=FALSE
           PZA2#=FALSE
        .
     .
     IF ~(BA400=NPP2450)
        KLUDA(0,'Sadaïas Bilance(A) 400 rindas vçrtîba Ls '&BA400&' nesakrît ar NPP2 450 r.vçrt. Ls '&NPP2450)
     .
     IF ~(BP520=PZA2180)
        KLUDA(0,'Sadaïas Bilance(P) 520 rindas vçrtîba Ls '&BP520&' nesakrît ar PZA2 180 r.vçrt. Ls '&PZA2180)
     .
     CLOSE(OUTFILEXML)
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    endpage(Report)
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
  DO ProcedureReturn

!---------------------------------------------------------------------------------------------------
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
  KON_R::Used -= 1
  IF KON_R::Used = 0 THEN CLOSE(KON_R).
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
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

!---------------------------------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~INSTRING(GGK:BKK[1],' 12345')
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
    IF PercentProgress <> Progress:Thermometer
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
    END
  END
  ?Progress:UserString{Prop:Text}=RecordsProcessed
!  STOP(RecordsProcessed) SKAITA...
  DISPLAY

!---------------------------------------------------------------------------------------------------
FILL_SUMMAS  ROUTINE
  IF F:NOA   !LS BEZ SANTÎMIEM
     S_SUMMA =FORMAT(R:SUMMAR,@N-15)          !WMF
     S_SUMMA0=FORMAT(R:SUMMAR0,@N-15)
     E_SUMMA =LEFT(FORMAT(R:SUMMAR,@N-_15.2)) !WORD,EXCEL
     E_SUMMA0=LEFT(FORMAT(R:SUMMAR0,@N-_15.2))
  ELSE
     S_SUMMA =FORMAT(R:SUMMA,@N-15.2)         !WMF
     S_SUMMA0=FORMAT(R:SUMMA0,@N-15.2)
     E_SUMMA =LEFT(FORMAT(R:SUMMA,@N-_15.2))  !WORD,EXCEL
     E_SUMMA0=LEFT(FORMAT(R:SUMMA0,@N-_15.2))
  .

!---------------------------------------------------------------------------------------------------
FILL_R_TABLE  ROUTINE
  LOOP I#= 1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF R:KODS>420 THEN R:SUMMA =-R:SUMMA.
     IF R:KODS>420 THEN R:SUMMA0=-R:SUMMA0.
     IF R:KODS=460 !PA VIDU IEBÂZTAS REZERVES
        CNTRL1  =0
        CNTRL10 =0
        CNTRLR1 =0
        CNTRLR10=0
     .
     IF R:KODS=50 OR R:KODS=100 OR R:KODS=107 OR R:KODS=113 OR R:KODS=190 OR R:KODS=270 OR R:KODS=276 OR|
        R:KODS=350 OR R:KODS=390 OR R:KODS=500 OR R:KODS=640 OR R:KODS=780 !MAZIE KOPÂ
!     IF R:KODS=50 OR R:KODS=100 OR R:KODS=190 OR R:KODS=270 OR R:KODS=350 OR R:KODS=390 OR R:KODS=500 OR|
!      R:KODS=640 OR R:KODS=780 !MAZIE KOPÂ
        R:SUMMA  =CNTRL1
        R:SUMMA0 =CNTRL10
        R:SUMMAR =CNTRLR1
        R:SUMMAR0=CNTRLR10
        CNTRL1 =0
        CNTRL10=0
        CNTRLR1 =0
        CNTRLR10=0
     ELSIF R:KODS=200 OR R:KODS=410 OR R:KODS=530 OR R:KODS=570 OR R:KODS=790 !LIELIE KOPÂ
        R:SUMMA  =CNTRL2
        R:SUMMA0 =CNTRL20
        R:SUMMAR =CNTRLR2
        R:SUMMAR0=CNTRLR20
        CNTRL2  =0
        CNTRL20 =0
        CNTRL1  =0
        CNTRL10 =0
        CNTRLR2 =0
        CNTRLR20=0
        CNTRLR1 =0
        CNTRLR10=0
     ELSIF R:KODS=420   !BILANCE_Aktîvs
        R:SUMMA  =CNTRL3
        R:SUMMA0 =CNTRL30
        R:SUMMAR =CNTRLR3
        R:SUMMAR0=CNTRLR30
        CNTRLR4   =CNTRLR3  !R4 TIKAI NOAPAÏOÐANAS KÏÛDAI
        CNTRLR40  =CNTRLR30
        CNTRL3   =0
        CNTRL30  =0
        CNTRLR3  =0
        CNTRLR30 =0
     ELSIF R:KODS=800  !BILANCE_Pasîvs
        R:SUMMA  =CNTRL3
        R:SUMMA0 =CNTRL30
        R:SUMMAR =CNTRLR3
        R:SUMMAR0=CNTRLR30
        CNTRLR4 -=CNTRLR3
        CNTRLR40-=CNTRLR30
     ELSE
        R:SUMMAR =ROUND(R:SUMMA,1)
        R:SUMMAR0=ROUND(R:SUMMA0,1)
        IF R:KODS>420
           CNTRL -=R:SUMMA !BEZ STARPSUMMÂM GALA KONTROLEI
        ELSE
           CNTRL +=R:SUMMA !BEZ STARPSUMMÂM GALA KONTROLEI
        .
        CNTRL1  +=R:SUMMA
        CNTRL10 +=R:SUMMA0
        CNTRL2  +=R:SUMMA
        CNTRL20 +=R:SUMMA0
        CNTRL3  +=R:SUMMA
        CNTRL30 +=R:SUMMA0
        CNTRLR1 +=R:SUMMAR
        CNTRLR10+=R:SUMMAR0
        CNTRLR2 +=R:SUMMAR
        CNTRLR20+=R:SUMMAR0
        CNTRLR3 +=R:SUMMAR
        CNTRLR30+=R:SUMMAR0
     .
     PUT(R_TABLE)
  .
  IF CNTRL
     KLUDA(0,'NEIET AKTÎVS/PASÎVS par Ls '&CNTRL)
     IF B_DAT=DATE(12,31,GADS)
        IF BAND(SYS:control_byte,00000010b)       ! bija OK
           SYS:control_byte -= 2
           PUT(SYSTEM)
        .
     .
  ELSE
     IF (CNTRLR4 OR CNTRLR40) AND (F:XML_OK#=TRUE OR F:NOA) !NEIET PÇC NOAPAÏOÐANAS
        IF CNTRLR4
           KLUDA(0,'pçc noapaïoðanas(XML) NEIET slçguma BILANCE par Ls '&clip(CNTRLR4)&|
           ' ,izlîdzinu uz 730. rindu ')
        .
        IF CNTRLR40
           KLUDA(0,'pçc noapaïoðanas(XML) NEIET sâkuma BILANCE par Ls '&clip(CNTRLR40)&|
           ',izlîdzinu uz 730. rindu ')
        .
        R:KODS=730  !Nodokïi
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=780  !II kopâ
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=790  !3.iedaïas kopsumma
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=800  !Bilance-Pasîvs
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
     .
     IF B_DAT=DATE(12,31,GADS)
        IF ~BAND(SYS:control_byte,00000010b)      ! nebija OK
           SYS:control_byte += 2
           PUT(SYSTEM)
        .
     .
  .


!------------------------------------------------------------------------------
CONVERT_TEX:XML  ROUTINE
  LOOP J#= 1 TO LEN(TEX:XML)  !CSTRING NEVAR LIKT
     IF TEX:XML[J#]='"'
        TEX:XML=TEX:XML[1:J#-1]&'&quot;'&TEX:XML[J#+1:LEN(CLIP(TEX:XML))]
     ELSIF TEX:XML[J#]='<<'
        TEX:XML=TEX:XML[1:J#-1]&'&lt;'&TEX:XML[J#+1:LEN(CLIP(TEX:XML))]
     ELSIF TEX:XML[J#]='>'
        TEX:XML=TEX:XML[1:J#-1]&'&gt;'&TEX:XML[J#+1:LEN(CLIP(TEX:XML))]
     ELSIF TEX:XML[J#]='&'
        TEX:XML=TEX:XML[1:J#-1]&'&amp;'&TEX:XML[J#+1:LEN(CLIP(TEX:XML))]
     ELSIF TEX:XML[J#]=''''
        TEX:XML=TEX:XML[1:J#-1]&'apos;'&TEX:XML[J#+1:LEN(CLIP(TEX:XML))]
     .
  .
B_PZA2008            PROCEDURE                    ! Declare Procedure
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

CG                   STRING(10)
izl_tex              STRING(60)
IZLAISTAS_S          DECIMAL(13,2)   ! 6,7,8 BEZ VAI NEPAREIZIEM rindu kodiem
BKK_SUMMA            DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
FILTRS_TEXT          STRING(100)

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA           DECIMAL(13,2)
SUMMAR          DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(8)
SUMMA           DECIMAL(13,2)
            .
I_TABLE     QUEUE,PRE(I)  !IZLAISTÂS SUMMAS
BKK             STRING(5)
SUMMA           DECIMAL(13,2)
            .
R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
R_USER               LIKE(KONR:USER)
CNTRL1               DECIMAL(13,2)
CNTRL1R              DECIMAL(11)
DELTA                DECIMAL(2),DIM(4)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)

VIRSRAKSTS           STRING(45)
PP                   STRING(1)
S_SUMMA              STRING(15) !WMF
E_SUMMA              STRING(15) !EXCEL
E                    STRING(1)
EE                   STRING(15)
RK_OK                BYTE


TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END


!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
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
                       PROJECT(GGK:KK)
                       PROJECT(GGK:OBJ_NR)
                    END

!-----------------------------------------------------------------------------
!report REPORT,AT(250,4508,8000,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
! Y+H max=11250
report REPORT,AT(250,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,4698),USE(?unnamed)
         STRING(@s1),AT(3365,260,260,333),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING('Izstrâdâts atbilstoði'),AT(6688,125),USE(?T1),TRN,HIDE
         STRING('2006.g.19.oktobrî '),AT(6760,302),USE(?T2),TRN,HIDE
         STRING(@s15),AT(3677,354),USE(EE),TRN,LEFT
         STRING('pieòemtajiem grozîjumiem likumâ'),AT(6073,479),USE(?T3),TRN,HIDE
         STRING('"Pat uzòçmuma gada pârskatiem"'),AT(5990,656),USE(?T4),TRN,HIDE
         STRING(@s3),AT(833,3125,323,208),USE(val_uzsk),TRN
         STRING('(klasificçts pçc apgrozîjuma izmaksu metodes)'),AT(2135,3438,3542,260),USE(?S2),CENTER, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(1563,3698,4688,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(760,4052,6302,208),USE(FILTRS_TEXT),CENTER
         LINE,AT(156,4271,0,417),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(156,4271,7552,0),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(5000,4271,0,417),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(5521,4271,0,417),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(6615,4271,0,417),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Pârskata perioda'),AT(5552,4323,1042,156),USE(?S11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,4271,0,417),USE(?Line19:3),COLOR(COLOR:Black)
         STRING('Rindas'),AT(5010,4344,469,156),USE(?S9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Gada'),AT(6625,4313,1042,156),USE(?S13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Râdîtâja nosaukums'),AT(781,4427,3438,208),USE(?S6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(5552,4479,1042,156),USE(?S12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(5010,4500,469,156),USE(?S10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sâkumâ'),AT(6625,4469,1042,156),USE(?S14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(167,4688,7552,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING(@s45),AT(1667,781,3854,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Vienotais reìistrâcijas Nr.'),AT(156,1094),USE(?String4),LEFT
         LINE,AT(1875,1042,1042,0),USE(?Line15:4),COLOR(COLOR:Black)
         STRING(@s11),AT(1979,1094,885,208),USE(gl:reg_nr,,?gl:reg_nr:2),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,1302,1042,0),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(1875,1354,0,260),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(3073,1354,0,260),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(1875,1354,1198,0),USE(?Line15:9),COLOR(COLOR:Black)
         STRING('PVN maksâtâja reì. Nr.'),AT(156,1406),USE(?String4:3),LEFT
         STRING(@s13),AT(1979,1406,1042,208),USE(gl:VID_NR),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,1615,1198,0),USE(?Line15:10),COLOR(COLOR:Black)
         STRING('Adrese'),AT(156,1771,521,208),USE(?String2),FONT(,,,,CHARSET:BALTIC)
         STRING('Tâlrunis'),AT(156,2063,521,208),USE(?String2:2),FONT(,,,,CHARSET:BALTIC)
         STRING('Fakss'),AT(2552,2063,469,208),USE(?String6),FONT(,,,,CHARSET:BALTIC)
         STRING(@s15),AT(3125,2063,1198,208),USE(SYS:FAX),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(1615,2385,1927,208),USE(GL:VID_NOS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(1646,2667),USE(GL:NACE),TRN,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('VID teritoriâlâ iestâde'),AT(156,2385,1354,208),USE(?String2:6),FONT(,,,,CHARSET:BALTIC)
         STRING('Pamatdarbîbas veids NACE'),AT(156,2688,1406,208),USE(?String2:4)
         STRING('Mçrvienîba :'),AT(156,3125,635,208),USE(?String2:5)
         STRING('PEÏÒAS VAI ZAUDÇJUMU APRÇÍINS'),AT(2135,3177,3542,260),USE(?S1),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING(@s17),AT(990,2063,1313,208),USE(SYS:tel),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(990,1771,4635,208),USE(GL:ADRESE),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,1042,0,260),USE(?Line17:14),COLOR(COLOR:Black)
         LINE,AT(1875,1042,0,260),USE(?Line17:13),COLOR(COLOR:Black)
         STRING('Uzòçmuma nosaukums'),AT(156,833),USE(?String4:2),LEFT,FONT(,,,,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,198),USE(?unnamed:2)
         LINE,AT(156,0,0,200),USE(?Line43:3),COLOR(COLOR:Black)
         STRING(@n3),AT(5031,21,469,167),USE(r:kods),CENTER
         LINE,AT(5521,0,0,200),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@S15),AT(5552,21,990,167),USE(S_SUMMA),RIGHT(3)
         STRING(@s100),AT(208,21,4740,170),USE(R_NOSAUKUMS),LEFT(1)
         LINE,AT(6615,0,0,200),USE(?Line1:31),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,200),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,200),USE(?Line1:2),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,0)
         LINE,AT(156,,7552,0),USE(?LineSVITRA),COLOR(COLOR:Black)
       END
DETAILBKK DETAIL,AT(,,,198),USE(?unnamed:3)
         STRING(@N-15.2B),AT(5604,21,938,167),USE(B:SUMMA),RIGHT(3)
         LINE,AT(7708,0,0,197),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(156,0,0,197),USE(?Line1B:11),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,200),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,200),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,200),USE(?Line1B:31),COLOR(COLOR:Black)
         STRING(@s5),AT(417,21,,156),USE(B_BKK)
         STRING(@s60),AT(990,21,3906,156),USE(B_NOSAUKUMS),LEFT
       END
HEADERIZL DETAIL,AT(,,,198),USE(?unnamed:5)
         LINE,AT(156,0,0,197),USE(?Line1I:11),COLOR(COLOR:Black)
         STRING(@s60),AT(521,21,3906,208),USE(izl_tex),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,0,0,197),USE(?Line1I:2),COLOR(COLOR:Black)
       END
DETAILIZL DETAIL,AT(,,,198),USE(?unnamed:4)
         STRING(@N-15.2B),AT(5604,21,938,167),USE(I:SUMMA),RIGHT(3)
         LINE,AT(7708,0,0,197),USE(?Line1I:14),COLOR(COLOR:Black)
         LINE,AT(156,0,0,197),USE(?Line11I:11),COLOR(COLOR:Black)
         STRING(@s5),AT(417,21,,156),USE(I:BKK)
         STRING(@s60),AT(990,21,3854,156),USE(I_NOSAUKUMS),LEFT
       END
FUTER  DETAIL,AT(,,,1292),USE(?unnamed:6)
         LINE,AT(3125,104,0,208),USE(?Line64:7),COLOR(COLOR:Black)
         LINE,AT(4156,104,0,208),USE(?Line64:9),COLOR(COLOR:Black)
         LINE,AT(4323,104,0,208),USE(?Line64:8),COLOR(COLOR:Black)
         LINE,AT(5365,104,0,208),USE(?Line64:10),COLOR(COLOR:Black)
         LINE,AT(5469,104,0,208),USE(?Line64:11),COLOR(COLOR:Black)
         LINE,AT(6510,104,0,208),USE(?Line64:12),COLOR(COLOR:Black)
         LINE,AT(3115,94,1042,0),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(4323,104,1042,0),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(5469,104,1042,0),USE(?Line63:2),COLOR(COLOR:Black)
         STRING('Revidents ir apstiprinâjis gada pârskatu :'),AT(354,125),USE(?String136)
         STRING('bez iebildumiem'),AT(3219,125),USE(?String137)
         STRING('ar iebildumiem'),AT(4469,125),USE(?String137:2)
         STRING('nav apstiprinâjis'),AT(5615,125),USE(?String139)
         LINE,AT(3125,313,1042,0),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(4323,313,1042,0),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(5469,313,1042,0),USE(?Line62:2),COLOR(COLOR:Black)
         STRING(@s25),AT(1927,802,2135,208),USE(SYS:AMATS1),RIGHT(2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,938,3490,0),USE(?Line70:2),COLOR(COLOR:Black)
         STRING(@s25),AT(4604,1010,1979,208),USE(SYS:PARAKSTS1,,?SYS:PARAKSTS1:2),CENTER,FONT(,8,,,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

!PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  .
  GGK::Used += 1
  FilesOpened = True

  VIRSRAKSTS=YEAR(S_DAT)&'.gada '&day(S_dat)&'.'&MENVAR(S_dat,2,1)&' - '&|
  YEAR(B_DAT)&'.gada '&day(B_dat)&'.'&MENVAR(B_dat,2,1)
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).

  CLEAR(KONR:RECORD)
  KONR:UGP='P'
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='P') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA=0
     ADD(R_TABLE)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

!****************************** 1. SOLIS ********************************
  BIND(GGK:RECORD)
  BIND(KON:RECORD)
  bind('b_dat',b_dat)
  bind('s_dat',s_dat)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Peïòas/Zaudçjumu aprçíins'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(ggk:RECORD)
     GGK:BKK='6'
     CG = 'K120011'
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
!     Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
        IF F:VALODA='1'  !ANGLISKI
!          SETTARGET(REPORT)
!          ?S1{Prop:Text}='PROFIT OR LOSS STATEMENT'
!          ?S2{Prop:Text}=''
!          ?S3{Prop:Text}='Period'
!!          ?S4{Prop:Text}='No'
!!          ?S5{Prop:Text}=''
!          ?S6{Prop:Text}='Special rate'
!!          ?S7{Prop:Text}='Note'
!!          ?S8{Prop:Text}=''
!          ?S9{Prop:Text}='Row'
!          ?S10{Prop:Text}='Code'
!          ?S11{Prop:Text}='End of the'
!          ?S12{Prop:Text}='period of account'
!          ?S13{Prop:Text}='Beginning of the'
!          ?S14{Prop:Text}='period of account'
        END
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PELNA.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        IF F:VALODA=0
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&E
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma nosaukums'&CHR(9)&CLIP(CLIENT)
            ADD(OUTFILEANSI)
            OUTA:LINE='Vienotais reìistrâcijas Nr.'&CHR(9)&GL:REG_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='PVN maksâtâja reì. Nr.'&CHR(9)&GL:VID_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='Adrese'&CHR(9)&CLIP(GL:adrese)
            ADD(OUTFILEANSI)
            OUTA:LINE='Tâlrunis'&CHR(9)&CLIP(SYS:TEL)
            ADD(OUTFILEANSI)
            OUTA:LINE='VID teritoriâlâ iestâde'&CHR(9)&CLIP(GL:VID_NOS)
            ADD(OUTFILEANSI)
            OUTA:LINE='Pamatdarbîbas veids NACE'&CHR(9)&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Mçrvienîba: Ls'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='PEÏÒAS VAI ZAUDÇJUMU APRÇÍINS'
            ADD(OUTFILEANSI)
            OUTA:LINE='(klasificçts pçc apgrozîjuma izmaksu metodes)'
            ADD(OUTFILEANSI)
            OUTA:LINE=VIRSRAKSTS
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            IF F:dbf='E'
                OUTA:LINE='Râdîtâja nosaukums'&CHR(9)&'Piezîmes Nr'&CHR(9)&'Rindas'&CHR(9)&'Pârskata perioda'&CHR(9)&'Gada'
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&'kods'&CHR(9)&'beigâs'&CHR(9)&'sâkumâ'
                ADD(OUTFILEANSI)
            ELSE
                OUTA:LINE='Râdîtâja nosaukums'&CHR(9)&'Piezîmes Nr'&CHR(9)&'Rindas kods'&CHR(9)&'Pârskata perioda beigâs'&CHR(9)&'Gada sâkumâ'
                ADD(OUTFILEANSI)
            END
        ELSE
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Registration Nr. '&CHR(9)&GL:REG_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='VAT Registration Nr. '&CHR(9)&GL:VID_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='Address'&CHR(9)&CLIP(GL:adrese)
            ADD(OUTFILEANSI)
            OUTA:LINE='Phone number'&CHR(9)&CLIP(SYS:TEL)
            ADD(OUTFILEANSI)
            OUTA:LINE='Branch NACE'&CHR(9)&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='PROFIT OR LOSS STATEMENT'
            ADD(OUTFILEANSI)
            OUTA:LINE=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            IF F:DBF='E'
                OUTA:LINE='No'&CHR(9)&'Special Rate'&CHR(9)&'Note'&CHR(9)&'Row'&CHR(9)&'At the end of the'&CHR(9)&|
                'At the beginning of the'
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'code'&CHR(9)&'period of accountant'&CHR(9)&'period of accountant'
                ADD(OUTFILEANSI)
            ELSE
                OUTA:LINE='No'&CHR(9)&'Special Rate'&CHR(9)&'Note'&CHR(9)&'Row code'&CHR(9)&|
                'At the end of the period of accountant'&CHR(9)&'At the beginning of the period of accountant'
                ADD(OUTFILEANSI)
            END
        END
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\PZA22008.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EE='(PZA22008.XML)'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE 
           XML:LINE=' Pza2>'
           ADD(OUTFILEXML)
        .
      .
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
       IF ~CYCLEGGK(CG) AND ~(GGK:U_NR=1) !~SALDO
          IF ~GETKON_K(ggk:BKK,2,1,FORMAT(GGK:DATUMS,@D6.)&' U_Nr='&GGK:U_NR)
             DO PROCEDURERETURN
          .
          IF INSTRING(KON:BKK[1],'678',1) AND ~(GGK:BKK[1:3]='861') !IR OPERÂCIJU KONTS UN NAV PEÏÒA/ZAUDÇJUMI
             nk#+=1
             ?Progress:UserString{Prop:Text}=NK#
             DISPLAY(?Progress:UserString)
             RK_OK=FALSE
             LOOP J# = 1 TO 3
                IF kon:PZB[J#]
                   R:KODS=kon:PZB[J#]
                   GET(R_TABLE,R:KODS)
                   IF ERROR()
                      KLUDA(71,'WWW.VID.GOV.LV PZA2 :'&kon:PZB[J#]&' kontam '&KON:BKK)
                   ELSE
                      RK_OK=TRUE
                      IF GGK:D_K='D'
                         R:SUMMA+=GGK:SUMMA
                      ELSE
                         R:SUMMA-=GGK:SUMMA
                      .
                      PUT(R_TABLE)
                      IF F:DTK  !IZVÇRSTÂ VEIDÂ
                         B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_3)
                         GET(B_TABLE,B:BKK_KODS)
                         IF ERROR()
                            IF GGK:D_K='D'
                               B:SUMMA=GGK:SUMMA
                            ELSE
                               B:SUMMA=-GGK:SUMMA
                            .
                            ADD(B_TABLE)
                            SORT(B_TABLE,B:BKK_KODS)
                         ELSE
                            IF GGK:D_K='D'
                               B:SUMMA+=GGK:SUMMA
                            ELSE
                               B:SUMMA-=GGK:SUMMA
                            .
                            PUT(B_TABLE)
                         .
                      .
                   .
                .
             .
             IF RK_OK=FALSE
                 IZLAISTAS_S+= GGK:SUMMA
                 I:BKK=GGK:BKK
                 GET(I_TABLE,I:BKK)
                 IF ERROR()
                    I:SUMMA=GGK:SUMMA
                    ADD(I_TABLE)
                    SORT(I_TABLE,I:BKK)
                 ELSE
                    I:SUMMA+=GGK:SUMMA
                    PUT(I_TABLE)
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

!****************************** 2. SOLIS ********************************
  IF F:DBF = 'W'
     PRINT(RPT:HEADER)
  ELSE
     OUTA:LINE=CLIENT
     ADD(OUTFILE)
  .
  DO FILL_R_TABLE !AIZPILDA VISAS STARPSUMMAS UN PÂRBAUDA APAÏOJUMUS
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF F:VALODA=1 !ANGLISKI
        R_NOSAUKUMS=GETKON_R('P',R:KODS,0,2)
     ELSE
        R_NOSAUKUMS=GETKON_R('P',R:KODS,0,1)
     .
     R_USER=GETKON_R('P',R:KODS,0,3)
     IF R:KODS=10 OR R:KODS=30  OR R:KODS=60  OR R:KODS=70  OR R:KODS=80 OR|
        R:KODS=90 OR R:KODS=120 OR R:KODS=130 OR R:KODS=140 OR R:KODS=150 OR R:KODS=180 OR|
        R:KODS=115  !ZIEDOJUMS 82800 - MANUPRÂT EDS KÏÛDA
        R:SUMMA =-R:SUMMA                       !MAINAM ZÎMI IZDRUKAI
        R:SUMMAR=-R:SUMMAR
     .
     IF F:NOA   !LS BEZ SANTÎMIEM
        S_SUMMA=FORMAT(R:SUMMAR,@N-15)        !WMF
        E_SUMMA=LEFT(FORMAT(R:SUMMAR,@N-_15)) !WORD,EXCEL
     ELSE
        S_SUMMA=FORMAT(R:SUMMA,@N-15.2)
        E_SUMMA=LEFT(FORMAT(R:SUMMA,@N-_15.2))
     .
     IF R:KODS=180 AND R:SUMMA<0
        IF F:VALODA=1 !ANGLISKI
           R_NOSAUKUMS='21. LOSS'
        ELSE
           R_NOSAUKUMS='21. Pârskata perioda zaudçjumi'
        .
     ELSIF R:KODS=180 AND R:SUMMA>0
        IF F:VALODA=1 !ANGLISKI
           R_NOSAUKUMS='21. PROFIT'
        ELSE
           R_NOSAUKUMS='21. Pârskata perioda peïòa'
        .
     .
     IF F:DBF = 'W'
        PRINT(RPT:DETAIL)                     
        IF F:DTK AND ~(R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180) !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 !15.01.2015 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 IF F:VALODA=1 !ANGLISKI
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,4)
                 ELSE
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 .

                 PRINT(RPT:DETAILBKK)
              .
           .
        .
        PRINT(RPT:SVITRA)                                 
     ELSE !WORD,EXCEL
        OUTA:LINE=CLIP(R_NOSAUKUMS)&CHR(9)&PP&CHR(9)&R:KODS&CHR(9)&E_SUMMA
        ADD(OUTFILEANSI)
        IF F:DTK AND ~(R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180) !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 !15.01.2015 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 IF F:VALODA=1 !ANGLISKI
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,4)
                 ELSE
                    B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 .
                 OUTA:LINE=B_BKK&CHR(9)&CLIP(B_NOSAUKUMS)&CHR(9)&CHR(9)&LEFT(FORMAT(B:SUMMA,@N-_15.2))
                 ADD(OUTFILEANSI)
              .
           .
        .
     .
     IF F:XML_OK#=TRUE
        IF R:SUMMAR
           XML:LINE='<R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
!           XML:LINE=' VertSak>'&CLIP(R:SUMMAR0)&'</VertSak>'
!           ADD(OUTFILEXML)
           XML:LINE=' VertBeig>'&CLIP(R:SUMMAR)&'</VertBeig>'
           ADD(OUTFILEXML)
           IF R_USER
              XML:LINE=' Teksts>'&CLIP(R_NOSAUKUMS)&'</Teksts>'
              ADD(OUTFILEXML)
           .
           XML:LINE='</R'&CLIP(R:KODS)&'>'
           ADD(OUTFILEXML)
        .
     .
  .

!  IF B_DAT=DATE(12,31,GADS)
!     IF ~IZLAISTAS_S                              ! PZA OK.
!        IF ~BAND(SYS:control_byte,00000001b)      ! nebija OK
!           SYS:control_byte += 1
!           PUT(SYSTEM)
!        .
!     ELSE                                         ! PZA NAV OK.
!        IF BAND(SYS:control_byte,00000001b)       ! bija OK
!           SYS:control_byte -= 1
!           PUT(SYSTEM)
!        .
!     .
!  .
  IF IZLAISTAS_S
     IZL_TEX='Kïûda kontu plânâ : izlaistas summas par Ls '&IZLAISTAS_S
     PRINT(RPT:HEADERIZL)
     IF F:DTK  !IZVÇRSTÂ VEIDÂ
        LOOP J#= 1 TO RECORDS(I_TABLE)
           GET(I_TABLE,J#)
           I_NOSAUKUMS=GETKON_K(I:BKK,0,2)
           PRINT(RPT:DETAILIZL)
        .
        PRINT(RPT:SVITRA)
     .
  ELSE
     IZL_TEX=''
  .

  IF F:DBF = 'W'
     PRINT(RPT:FUTER)
  ELSE
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     OUTA:LINE=' Revidents ir apstiprinâjis gada pârskatu: bez iebildumiem;  ar iebildumiem;  nav apstiprinâjis'
     ADD(OUTFILEANSI)
     OUTA:LINE=IZL_TEX
     ADD(OUTFILEANSI)
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     OUTA:LINE='Vadîtâjs (îpaðnieks):______________________________'
     ADD(OUTFILEANSI)
  .
  IF F:XML_OK#=TRUE
     XML:LINE='</Pza2>'
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    endpage(Report)
    pr:skaits=2
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

!------------------------------------------------------------------------
ProcedureReturn ROUTINE
  free(PrintPreviewQueue)
  free(PrintPreviewQueue1)
  FREE(R_TABLE)
  FREE(B_TABLE)
  FREE(I_TABLE)
  CLOSE(REPORT)
  KON_R::Used -= 1
  IF KON_R::Used = 0 THEN CLOSE(KON_R).
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  .
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN

!------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!------------------------------------------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
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

!------------------------------------------------------------------------
FILL_R_TABLE ROUTINE
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180 !STARPSUMMAS
        R:SUMMA =CNTRL1
        R:SUMMAR=CNTRL1R
        K#+=1
!        STOP(K#&' '&R:KODS)
        IF F:NOA
           DELTA#=R:SUMMAR-ROUND(R:SUMMA,1)
           IF DELTA#
              R:SUMMAR-=DELTA#
              CNTRL1R-=DELTA#
              DELTA[K#]=DELTA#
           .
        .
     ELSE
        R:SUMMAR=ROUND(R:SUMMA,1)
        CNTRL1 +=R:SUMMA
        CNTRL1R+=R:SUMMAR
     .
     PUT(R_TABLE)
  .
  IF F:NOA
     LOOP K#=1 TO 4
        IF DELTA[K#]
           EXECUTE K#       !RINDAS, UZ KURÂM IZLÎDZINAM
              R:KODS=20
              R:KODS=50
              R:KODS=130
              R:KODS=160
           .
           GET(R_TABLE,R:KODS)
           IF ~ERROR()
              R:SUMMAR-=DELTA[K#]
              PUT(R_TABLE)
           .
           EXECUTE K#
              KLUDA(0,'Summçjot pçc noapaïoðanas kïûda 30R=Ls '&CLIP(DELTA[K#])&' izlîdzinu uz 20R',1,1)
              KLUDA(0,'Summçjot pçc noapaïoðanas kïûda 120R=Ls '&CLIP(DELTA[K#])&' izlîdzinu uz 50R',1,1)
              KLUDA(0,'Summçjot pçc noapaïoðanas kïûda 150R=Ls '&CLIP(DELTA[K#])&' izlîdzinu uz 130R',1,1)
              KLUDA(0,'Summçjot pçc noapaïoðanas kïûda 180R=Ls '&CLIP(DELTA[K#])&' izlîdzinu uz 160R',1,1)
           .
        .
     .
  .

!IF F:NOA AND R:KODS=180
!     DELTA#=R:SUMMAR-ROUND(R:SUMMA,1)
!     IF DELTA#
!        KLUDA(0,'Summçjot pçc noapaïoðanas 180R='&CLIP(R:SUMMAR)&',jâbût '&CLIP(ROUND(R:SUMMA,1))&' izlîdzinu uz 160R',2,1)
!        IF KLU_DARBIBA
!           R:SUMMAR-=DELTA#
!           PUT(R_TABLE)
!           LOOP I#=1 TO RECORDS(R_TABLE)
!              GET(R_TABLE,I#)
!              IF R:KODS=160 !UIN
!                 R:SUMMAR-=DELTA#
!                 PUT(R_TABLE)
!                 BREAK
!              .
!           .
!        .
!     .
!  .


