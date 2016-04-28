                     MEMBER('winlats.clw')        ! This is a MEMBER module
SPZ_KO               PROCEDURE                    ! Declare Procedure
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

sav_kie_nr           LIKE(PAV:KIE_NR)
ATLAIDE              REAL
AN                   REAL
PAV_DATUMS           LONG
RPT_NPK              DECIMAL(3)
RPT_CLIENT           STRING(45)
RPT_GADS             STRING(4)
GADS1                STRING(1)
DATUMS               STRING(2)
ADRESEF              STRING(40)
gov_reg              STRING(40)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(100)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_NOS_P            STRING(35)
PAR_BAN_NR           STRING(18)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TExTEKSTS            STRING(60)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
CONS1                STRING(15)
NPK                  STRING(3)
SUMMA_B              DECIMAL(16,4)
KOPA                 STRING(15)
SUMK_B               DECIMAL(13,2)
NOSK                 STRING(3)
NOS1                 STRING(3)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
SUMK_APMO            DECIMAL(13,2)
SUMK_PVNO            DECIMAL(13,2)
SUMK_BO              DECIMAL(13,2)
SUMK_PVNO0           DECIMAL(13,2)
SUMK_AO0             DECIMAL(13,2)
SUMK_BO0             DECIMAL(13,2)
SUMK_PVNO5           DECIMAL(13,2)
SUMK_AO5             DECIMAL(13,2)
SUMK_BO5             DECIMAL(13,2)
SUMK_PVNO12          DECIMAL(13,2)
SUMK_AO12            DECIMAL(13,2)
SUMK_BO12            DECIMAL(13,2)
SUMK_PVNO18          DECIMAL(13,2)
SUMK_AO18            DECIMAL(13,2)
SUMK_BO18            DECIMAL(13,2)
PVN_PROCO            BYTE
PAV_T_SUMMA          DECIMAL(12,2)
SUMVAR1              STRING(57)
SUMVAR2              STRING(57)
SUMVAR3              STRING(57)
SUMVAR11             STRING(57)
SUMVAR21             STRING(57)
SUMVAR31             STRING(57)
PLKST                TIME
PAV_AUTO             STRING(80)

GGK_SUMMAV           LIKE(GGK:SUMMAV)
GGK_BKK              LIKE(GGK:BKK)
MENESIS              STRING(10)


!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END

report REPORT,AT(146,400,8000,11198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
KO     DETAIL,PAGEBEFORE(-1),AT(,,,1667),USE(?unnamed:2)
         LINE,AT(0,0,3333,0),USE(?Line83:4),COLOR(COLOR:Black)
         LINE,AT(104,0,7604,0),USE(?Line5:9),COLOR(COLOR:Black)
         STRING('Kods'),AT(3083,1135,573,156),USE(?String62:30),CENTER
         STRING('Summa'),AT(1563,1146,1510,156),USE(?String62:29),CENTER
         LINE,AT(938,1094,0,573),USE(?Line84:2),COLOR(COLOR:Black)
         STRING('konts'),AT(385,1302,521,156),USE(?String62:26),CENTER
         STRING('uzsk. k.'),AT(958,1302,521,156),USE(?String62:28),CENTER
         STRING('mçría n.'),AT(3083,1292,573,156),USE(?String62:31),CENTER
         LINE,AT(365,1458,3333,0),USE(?Line83:2),COLOR(COLOR:Black)
         STRING(@s5),AT(1052,1510,365,156),USE(sys:k_Dk_uKA),LEFT
         STRING(@N-_13.2),AT(1667,1510,833,156),USE(sumk_APMO),RIGHT
         STRING(@s3),AT(2604,1510,260,156),USE(PAV:VAL,,?PAV:VAL:2),LEFT
         STRING('Pieòemts no :'),AT(3906,979,729,156),USE(?String62:40),LEFT
         STRING(@s35),AT(4688,979,2240,156),USE(PAR_NOS_P),LEFT
         STRING(@s40),AT(4688,1146,2656,156),USE(GOV_REG,,?GOV_REG:3),LEFT
         STRING(@S14),AT(5208,1479,990,156),USE(PAV:DOK_SENR,,?PAV:DOK_SENR:2),LEFT
         STRING('pçc P/Z  Nr'),AT(4594,1479,625,156),USE(?String62:42),LEFT
         STRING(@D06.),AT(5990,1344,625,156),USE(PAV:DATUMS,,?PAV:DATUMS:2),RIGHT
         STRING('Pamatojums:  Par realizçto produkciju no'),AT(3906,1344,2083,156),USE(?String62:41), |
             LEFT
         STRING('kases ieòçmumu orderim  Nr'),AT(4781,708,1458,208),USE(?String105:3),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('KVÎTS'),AT(4938,510,1667,208),USE(?String105:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5),AT(6240,708,313,208),USE(pav:kie_nr,,?pav:kie_nr:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3698,1094,0,573),USE(?Line84:5),COLOR(COLOR:Black)
         LINE,AT(3073,1094,0,573),USE(?Line84:4),COLOR(COLOR:Black)
         LINE,AT(1510,1094,0,573),USE(?Line84:3),COLOR(COLOR:Black)
         STRING('Analît.'),AT(958,1146,521,156),USE(?String62:27),CENTER
         STRING(@s13),AT(2854,250,833,208),USE(gl:vid_nr,,?gl:vid_nr:3),LEFT
         STRING(@s30),AT(4000,250,1927,208),USE(sys:adrese,,?sys:adrese:2),LEFT
         STRING(@s11),AT(6031,250,729,208),USE(gl:reg_nr,,?gl:reg_nr:2),LEFT
         STRING(@s13),AT(6865,250,833,208),USE(gl:vid_nr,,?gl:vid_nr:2),LEFT
         STRING('Koresp.'),AT(385,1146,521,156),USE(?String62:25),CENTER
         STRING('KASES IEÒÇMUMU ORDERIS Nr'),AT(667,510,1667,208),USE(?String105),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5),AT(2333,510,313,208),USE(pav:kie_nr),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(2073,250,729,208),USE(gl:reg_nr,,?gl:reg_nr:3),LEFT
         STRING(@s45),AT(354,42,3125,208),USE(RPT_client,,?client:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('"'),AT(1760,771,104,208),USE(?String62:24),LEFT
         STRING(@s45),AT(4573,42,2969,208),USE(RPT_client,,?client:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(1865,771,677,208),USE(menesis,,?menesis:2),LEFT
         LINE,AT(365,1094,3333,0),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(365,1094,0,573),USE(?Line84),COLOR(COLOR:Black)
         STRING(@n2),AT(1604,771,156,208),USE(datums,,?datums:2),RIGHT
         STRING('. gada  "'),AT(1188,771,417,208),USE(?String62:23),LEFT
         STRING(@s4),AT(875,771,313,208),USE(RPT_GADS,,?RPT_GADS:2),RIGHT
         STRING(@s30),AT(94,250,1927,208),USE(sys:adrese),LEFT
         LINE,AT(3750,0,0,1667),USE(?Line76),COLOR(COLOR:Black)
       END
detail_kor DETAIL,AT(,,,146)
         LINE,AT(365,-10,0,197),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(938,-10,0,197),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,197),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(3073,-10,0,197),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,197),USE(?Line16),COLOR(COLOR:Black)
         STRING(@s5),AT(458,10,417,156),USE(GGK_BKK),LEFT
         STRING(@N_12.2),AT(1667,0,833,156),USE(GGK_SUMMAV),RIGHT
         LINE,AT(3750,-10,0,197),USE(?Line16:2),COLOR(COLOR:Black)
       END
detail_LINE DETAIL,AT(10,,7958,52)
         LINE,AT(354,0,3333,0),USE(?Line83:5),COLOR(COLOR:Black)
       END
detail_summa DETAIL,AT(10,,7958,135)
         STRING(@N-_13.2),AT(4458,10,833,167),USE(sumk_BO,,?sumk_BO:2),RIGHT
         STRING('Summa ='),AT(3917,10,521,170),USE(?String62:43),LEFT
         STRING(',  PVN'),AT(5375,10,313,167),USE(?String62:44),LEFT
         STRING('% ='),AT(6010,10,250,167),USE(?String173:2)
         STRING(@N-_13.2),AT(6323,10,833,167),USE(sumk_PVNO,,?sumk_PVNO:2),RIGHT
         LINE,AT(3740,-21,0,197),USE(?Line16:3),COLOR(COLOR:Black)
         STRING(@N2),AT(5740,10,219,167),USE(PVN_PROC,,?PVN_PROC:2),CENTER
         STRING('Summa ='),AT(375,10,521,170),USE(?String62:32),LEFT
         STRING(@N-_13.2),AT(906,10,833,167),USE(sumk_BO),RIGHT
         STRING(',  PVN '),AT(1750,10,417,167),USE(?String62:33),RIGHT
         STRING(@N2),AT(2177,10,219,167),USE(PVN_PROC),CENTER
         STRING('% ='),AT(2406,10,250,167),USE(?String173)
         STRING(@N-_13.2),AT(2708,10,833,167),USE(sumk_PVNO),RIGHT
       END
KO1    DETAIL,AT(,,,1844),USE(?unnamed)
         LINE,AT(3750,0,0,1823),USE(?Line76:3),COLOR(COLOR:Black)
         STRING('Summa kopâ :'),AT(3917,10,729,208),USE(?String62:45),LEFT
         STRING(@N-_13.2),AT(4656,10,833,208),USE(sumk_apmO,,?sumk_apmO:2),RIGHT
         STRING('Pieòemts no :'),AT(365,52,729,208),USE(?String62:34),LEFT
         STRING(@s35),AT(1146,52,2240,156),USE(PAR_NOS_P,,?PAR_NOS_P:2),LEFT
         STRING(@s3),AT(5542,10,260,208),USE(nos1),LEFT
         STRING(@s40),AT(1146,208,2552,208),USE(GOV_REG,,?GOV_REG:2),LEFT
         STRING('Summa vârdiem :'),AT(3906,469,885,208),USE(?String62:46),LEFT
         STRING(@s50),AT(4792,469,2813,208),USE(SUMVAR11),LEFT
         STRING('Summa vârdiem :'),AT(365,729,885,208),USE(?String62:37),LEFT
         STRING(@s50),AT(1250,729,2500,208),USE(SUMVAR1,,?SUMVAR1:2),LEFT
         STRING(@s50),AT(4792,677,2813,208),USE(SUMVAR21),LEFT
         STRING(@s50),AT(1250,938,2500,208),USE(SUMVAR2,,?SUMVAR2:2),LEFT
         STRING(@s50),AT(4792,885,2813,208),USE(SUMVAR31),LEFT
         STRING(@s4),AT(3927,1135,313,208),USE(RPT_GADS,,?RPT_GADS:3),RIGHT
         STRING('. gada  "'),AT(4240,1135,417,208),USE(?String62:49),LEFT
         STRING(@n2),AT(4656,1135,156,208),USE(datums,,?datums:3),RIGHT
         STRING('"'),AT(4813,1135,104,208),USE(?String62:50),LEFT
         STRING(@s10),AT(4917,1135,677,208),USE(menesis,,?menesis:3),LEFT
         STRING(@S50),AT(1250,1146,2500,208),USE(SUMVAR3),LEFT
         STRING('Galvenais grâmatvedis'),AT(3906,1406,1198,208),USE(?String62:47),LEFT
         STRING('Galvenais grâmatvedis'),AT(417,1406,1198,208),USE(?String62:38),LEFT
         STRING('Saòçma kasieris'),AT(417,1615,1198,208),USE(?String62:39),LEFT
         STRING('Kasieris'),AT(3906,1615,1198,208),USE(?String62:48),LEFT
         STRING('Pamatojums:  Par realiz. no'),AT(365,469,1406,208),USE(?String62:35),LEFT
         STRING(@D06.),AT(1771,469,625,208),USE(PAV:DATUMS),RIGHT
         STRING('P/Z  Nr'),AT(2448,469,365,208),USE(?String62:36),LEFT
         STRING(@S14),AT(2813,469,885,208),USE(PAV:DOK_SENR),LEFT
       END
detail DETAIL,AT(,,8000,1656)
         LINE,AT(5938,1354,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7448,1354,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4271,1354,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1771,1354,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2969,1354,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@s35),AT(1688,167,3490,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maks.  Reì. Nr  :'),AT(1094,469),USE(?String2),LEFT
         STRING(@s11),AT(2708,458,885,208),USE(GL:REG_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN maks.  Reì. Nr  :'),AT(3698,469),USE(?String2:2),LEFT
         STRING(@s13),AT(5104,458,1146,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KASES IZDEVUMU ORDERIS Nr'),AT(1875,729,2396,260),USE(?String6),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5),AT(4323,729,938,208),USE(PAV:KIE_NR,,?PAV:KIE_NR:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(2271,1042,385,208),USE(rpt_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('.  gada'),AT(2656,1042,469,208),USE(?String2:3),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('"'),AT(3177,1042,52,208),USE(?String10),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3229,1042,219,208),USE(datums),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('."'),AT(3490,1042,94,208),USE(?String10:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(3646,1042),USE(menesis),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,1354,6823,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Koresp. konts'),AT(677,1406,1094,208),USE(?String2:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Analit. uzsk. k.'),AT(3021,1406,1250,208),USE(?String2:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(1823,1406,1146,208),USE(?String2:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4323,1406,1615,208),USE(?String2:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods mçría nol.'),AT(5990,1406,1458,208),USE(?String2:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,1615,6823,0),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(625,1354,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177)
         LINE,AT(2969,-10,0,197),USE(?Line9:3),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,197),USE(?Line9:4),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,197),USE(?Line9:5),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,197),USE(?Line9:6),COLOR(COLOR:Black)
         STRING(@s5),AT(3438,10,,156),USE(SYS:K_DK_UKA,,?SYS:K_DK_UKA:2),CENTER,FONT(,9,,)
         STRING(@N14.2),AT(4427,10,,156),USE(SUMK_APMO,,?SUMK_APMO:3),RIGHT,FONT(,9,,)
         STRING(@s3),AT(5469,10,,156),USE(PAV:val),RIGHT,FONT(,9,,)
         LINE,AT(1771,-10,0,197),USE(?Line9:2),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line9),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,146)
         LINE,AT(7448,-10,0,197),USE(?Line9:12),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,197),USE(?Line9:11),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,197),USE(?Line9:10),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,197),USE(?Line9:9),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,197),USE(?Line9:8),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line9:7),COLOR(COLOR:Black)
       END
detail3 DETAIL,AT(,,8021,1750),USE(?unnamed:3)
         STRING(@S37),AT(1823,469,2813,156),USE(REG_NR),LEFT,FONT(,9,,)
         STRING('Par saòemto produkciju no'),AT(1823,781,1615,156),USE(?pamatojums),LEFT,FONT(,9,,)
         STRING(@D06.),AT(3438,781,677,156),USE(PAV:DATUMS,,?PAV:DATUMS:3),RIGHT,FONT(,9,,)
         STRING('pçc P/Z Nr'),AT(4167,781,625,156),USE(?pamatojums:2),LEFT,FONT(,9,,)
         STRING(@S14),AT(4792,781,1094,156),USE(PAV:DOK_SENR,,?PAV:DOK_NR:3),RIGHT,FONT(,9,,)
         STRING('Pielikumâ'),AT(677,990,1010,156),USE(?String2:12),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa vârdiem'),AT(677,1198,1010,156),USE(?String2:15),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S50),AT(1823,1198,3750,156),USE(sumvar1),LEFT,FONT(,9,,),COLOR(COLOR:Silver)
         STRING(@S50),AT(1823,1354,3750,156),USE(sumvar2),LEFT,COLOR(COLOR:Silver)
         STRING(@S50),AT(1823,1510,3750,156),USE(sumvar3,,?sumvar3:2),LEFT,COLOR(COLOR:Silver)
         STRING(':'),AT(1719,1198,104,156),USE(?String2:22),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(':'),AT(1719,990,104,156),USE(?String2:23),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(1823,990,4896,156),USE(PAV:PIELIK),LEFT,FONT(,9,,)
         STRING(':'),AT(1719,781,104,156),USE(?String2:21),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(':'),AT(1719,313,104,208),USE(?String2:17),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S55),AT(1823,313,4167,156),USE(PAR:NOS_P,,?PAR:NOS_P:3),LEFT,FONT(,9,,)
         STRING(@S40),AT(1823,625,3021,156),USE(ADRESE),LEFT,FONT(,9,,)
         STRING('Pamatojums'),AT(677,781,1010,156),USE(?String2:14),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegt'),AT(677,313,1010,156),USE(?String2:13),LEFT,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,-10,0,62),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,62),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,62),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(625,52,6823,0),USE(?Line27),COLOR(COLOR:Black)
         STRING('Summa ='),AT(646,94,521,170),USE(?String62:132),LEFT
         STRING(@N-_13.2),AT(1167,94,833,167),USE(sumk_BO,,?SUMK_BO:3),RIGHT
         STRING(',  PVN '),AT(2000,94,417,167),USE(?String62:133),RIGHT
         STRING(@N2),AT(2417,94,219,167),USE(PVN_PROC,,?PVN_PROC:3),CENTER
         STRING('% ='),AT(2625,94,250,167),USE(?String1173)
         STRING(@N-_13.2),AT(2938,94,833,167),USE(sumk_PVNO,,?sumk_PVNO:3),RIGHT
       END
detail5 DETAIL,AT(,,,1708)
         STRING('Saòçma'),AT(677,625),USE(?String2:10),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1823,781,5781,0),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(1823,990,5781,0),USE(?Line28:2),COLOR(COLOR:Black)
         STRING(':'),AT(1719,625,104,208),USE(?String2:19),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING('. g.  Paraksts  : _{30}'),AT(4115,1146),USE(?String2:16),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5677,260,1510,0),USE(?Line30:2),COLOR(COLOR:Black)
         STRING('Izsniedza kasieris  :'),AT(677,1458),USE(?String2:20),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1771,260,1510,0),USE(?Line30),COLOR(COLOR:Black)
         STRING('" ____ " _{15}'),AT(2083,1146,1615,208),USE(?String50),LEFT,FONT(,9,,)
         STRING(@n4),AT(3698,1146,385,208),USE(rpt_gads,,?RPT:GADS:1),RIGHT,FONT(,9,,)
         STRING('Vadîtâjs'),AT(677,104,990,208),USE(?String2:9),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Galv. grâmatvedis   :'),AT(4479,104),USE(?String2:18),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('/'),AT(1792,313),USE(?String43)
         STRING(@s16),AT(1896,313),USE(sys:paraksts1),CENTER,FONT(,9,,)
         STRING('/'),AT(3146,313),USE(?String43:2)
         STRING('/'),AT(5698,313),USE(?String43:3)
         STRING(@s16),AT(5802,313),USE(sys:paraksts2),CENTER,FONT(,9,,)
         STRING('/'),AT(7052,313),USE(?String43:4)
         STRING(':'),AT(1719,104,104,208),USE(?String2:11),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(146,11450,8000,52)
         LINE,AT(104,0,7604,0),USE(?Line5:10),COLOR(COLOR:Black)
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

KOscreen WINDOW('Kases orderis'),AT(,,213,163),CENTER,GRAY
       ENTRY(@n_7),AT(115,11),USE(pav:kie_nr,,?pav:kie_nr:1)
       ENTRY(@D6),AT(115,26),USE(PAV_DATUMS)
       STRING('Datums :'),AT(83,27),USE(?pavdatums)
       STRING('Kases ieòçmumu orderis :'),AT(26,13),USE(?KIEKIZ)
       STRING('Summa ar PVN:'),AT(61,42),USE(?String1)
       STRING('Summa:'),AT(120,42),USE(?String11)
       ENTRY(@n-_9.2),AT(70,55),USE(SUMK_AO0)
       STRING(@n12.2),AT(113,56),USE(sumk_bo0)
       ENTRY(@n-_9.2),AT(70,69),USE(SUMK_AO5)
       STRING(@n12.2),AT(113,70),USE(sumk_bo5)
       STRING('5/10% PVN grupa:'),AT(5,71,62,10),USE(?String3),RIGHT
       STRING(@n12.2),AT(159,70),USE(sumk_pvno5)
       STRING('PVN:'),AT(169,42),USE(?String2:113)
       STRING('12% PVN grupa:'),AT(15,84),USE(?String123),RIGHT
       ENTRY(@n-_9.2),AT(70,83),USE(SUMK_AO12)
       STRING(@n12.2),AT(113,84),USE(sumk_bo12)
       STRING(@n12.2),AT(159,84),USE(sumk_pvno12)
       STRING('18/21 % PVN grupa:'),AT(3,98),USE(?String31),RIGHT
       ENTRY(@n-_9.2),AT(70,97),USE(SUMK_AO18)
       STRING(@n12.2),AT(113,98),USE(sumk_bo18)
       STRING(@n12.2),AT(159,98),USE(sumk_pvno18)
       STRING('Kopâ:'),AT(17,113),USE(?String131)
       STRING(@N-_9.2),AT(75,114),USE(SUMK_APM)
       STRING('0% PVN grupa:'),AT(19,56),USE(?String13),RIGHT
       BUTTON('&OK'),AT(128,136,35,14),USE(?Ok),DEFAULT
       BUTTON('&Atlikt'),AT(169,136,35,14),USE(?Cancel)
       OPTION('Norâdiet :'),AT(10,125,100,33),USE(F:KONTI),BOXED
         RADIO('Drukât kontçjumus'),AT(18,134),USE(?F:KONTI:Radio1)
         RADIO('Nedrukât kontçjumus'),AT(18,143),USE(?F:KONTI:Radio2)
       END
     END

  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  PAV_DATUMS=PAV:DATUMS
  PAV_AUTO=GETAUTO(PAV:VED_NR,2)
  TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
  SAV_KIE_NR=PAV:KIE_NR
  F:KONTI='D'
  GETMYBANK('')
  MENESIS=MENVAR(PAV:DATUMS,2,2)
  CASE PAV:D_K
  OF 'D'
    RPT_CLIENT=GETPAR_K(pav:par_nr,0,3)
    ADRESE=PAR:ADRESE
    reg_nr=PAR:NMR_KODS
    RPT_BANKA=''
!   RPT:BKODS=PAR:BAN_KODS
    RPT_REK  =PAR:BAN_NR
    ATLAUJA =''
    PAR_NOS_P=CLIENT
    gov_reg=gl:reg_nr
    ADRESE1=SYS:ADRESE
!   RPT:NOLIKTAVA=''
  ELSE
    RPT_CLIENT=CLIENT
    ADRESE=CLIP(SYS:ADRESE)&' t.'&clip(sys:tel)
    reg_nr=gl:reg_nr
    fin_nr=gl:VID_NR
    RPT_BANKA=BANKA
!   RPT:BKODS=BKODS
    RPT_REK  =REK
    ATLAUJA =SYS:ATLAUJA
    par_nos_p=GETPAR_K(pav:par_nr,0,3)
    gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
    ADRESE1=PAR:ADRESE
    ADRESEF = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
!   RPT:NOLIKTAVA=SYS:AVOTS
    checkopen(bankas_k)
    clear(ban:record)
    IF F:PAK = '2'   !F:PAK NO SELPZ
       PAR_ban_kods=par:ban_kods2
       par_ban_nr=par:ban_nr2
    ELSE
       PAR_ban_kods=par:ban_kods
       par_ban_nr=par:ban_nr
    .
!    get(bankas_k,ban:kod_key)
!    par_BAN_kods=ban:kods
    par_banka=GETBANKAS_K(PAR_BAN_KODS,2,1)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)
  BIND(PAV:RECORD)
  BIND(TEK:RECORD)
  BIND(BAN:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  CASE PAV:D_K
  OF 'D'
    ProgressWindow{Prop:Text} = 'Kases izdevumu orderis'
  ELSE
    ProgressWindow{Prop:Text} = 'Kases ieòçmumu orderis'
  END
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)                              !MAKE SURE RECORD CLEARED
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)                     !SET TO FIRST SELECTED RECORD
      Process:View{Prop:Filter} = 'NOL:U_NR=PAV:U_NR'
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
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        fillpvn(1)
        SUMMA_B= calcsum(3,4)
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
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
        POST(Event:CloseWindow)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
 !   PRINT(RPT:RPT_FOOT1)
    SUMK_B=ROUND(GETPVN(3),.01)
    NOSK=PAV:VAL
    kopa='Kopâ:'
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A <= 0
!      PRINT(RPT:RPT_FOOT3)                        !PRINT GRAND TOTALS
    ELSE
!      PRINT(RPT:RPT_FOOT31)                       !PRINT GRAND TOTALS
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
!      PAV_T_SUMMA=ROUND(pav:t_summa/(1+PAV:T_PVN/100),.01)                  !TRANSPORTS BEZ PVN
      PAV_T_SUMMA=PAV:T_SUMMA-ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01) !10/03/03
!!      PRINT(RPT:RPT_FOOT33)
    .
!************************* PVN ***********
!   RPT:SUMK_PVN= ROUND(SUMK_AN-SUMK_BN+pav:t_summa*(1-1/(1+PAV:T_AN/100)),.01)
!   RPT:SUMK_PVN = ROUND(getpvn(1),.01)
    SUMK_PVN  = ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)
    SUMK_PVNO = SUMK_PVN
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît summas')
!     kluda(74,'')
!     print(rpt:rpt_err)
!     CLOSE(REPORT)
!     RETURN
    .
    SUMK_B=ROUND(GETPVN(3),.01)
    NOSK=PAV:VAL
!    SUMK_APM = SUMK_B + SUMK_PVN + PAV_T_SUMMA
    SUMK_APM = SUMK_B + SUMK_PVN + PAV:T_SUMMA
    SUMK_APMO= SUMK_APM

!******** Summas pa PVN % grupâm *******************
    sumk_pvno0=0
    sumk_Bo0=getpvn(12)   !summa, kur PVN = 0%
    sumk_Ao0=getpvn(12)   !summa, kur PVN = 0%
    sumk_pvno5=getpvn(18)
    sumk_Bo5=getpvn(19)                !summa, kur PVN = 5%
    sumk_Ao5=getpvn(19)+SUMK_PVNO5     !summa+PVN, kur PVN = 5%
    sumk_pvno12=getpvn(10)
    sumk_Bo12=getpvn(13)               !summa, kur PVN = 12%
    sumk_Ao12=getpvn(13)+SUMK_PVNO12   !summa+PVN, kur PVN = 12%
    sumk_pvno18=getpvn(11)
    sumk_Bo18=getpvn(14)               !summa, kur PVN = 18%
    sumk_Ao18=getpvn(14)+SUMK_PVNO18   !summa+PVN, kur PVN = 18%
    OPEN(KOSCREEN)
    accept
       CASE PAV:D_K
       OF 'K'
           ?KIEKIZ{Prop:Text}='Kases ieòçmumu orderis'
       ELSE
           ?KIEKIZ{Prop:Text}='Kases izdevumu orderis'
       END
       DISPLAY(?KIEKIZ)
       sumk_apm=sumk_Ao0+sumk_Ao12+sumk_Ao18
       SUMK_BO0=SUMK_AO0
       display
       case field()
       of ?SUMK_AO5
          CASE EVENT()
          OF EVENT:Accepted
             SUMK_BO5=SUMK_AO5/1.05
             sumk_pvno5=sumk_Ao5-SUMK_BO5
          .
       of ?SUMK_AO12
          CASE EVENT()
          OF EVENT:Accepted
             SUMK_BO12=SUMK_AO12/1.12
             sumk_pvno12=sumk_Ao12-SUMK_BO12
          .
       of ?SUMK_AO18
          CASE EVENT()
          OF EVENT:Accepted
             SUMK_BO18=SUMK_AO18/1.18
             sumk_pvno18=sumk_Ao18-SUMK_BO18
          .
       of ?ok
          CASE EVENT()
          OF EVENT:Accepted
             break
          .
       of ?cancel
          CASE EVENT()
          OF EVENT:Accepted
             close(koscreen)
             do procedurereturn
          .
       .
    .
    CLOSE(KOSCREEN)

    IF ~(SAV_KIE_NR=PAV:KIE_NR)
       IF RIUPDATE:PAVAD() THEN KLUDA(24,'PAVAD').
    .
    gads1=year(pav_datums)-1990
    RPT_gads=year(pav_datums)
    datums=day(pav_datums)
    menesis=MENVAR(pav_datums,2,2)
    KESKA = RPT_GADS&'. gada '&datums&'. '&menesis
    sumk_APMO=sumk_APM
    TEKSTS=SUMVAR(SUMK_APM,PAV:VAL,0)
    FORMAT_TEKSTS(60,'Arial',8,'')
    SUMVAR1 = F_TEKSTS[1]
    SUMVAR11= F_TEKSTS[1]
    SUMVAR2 = F_TEKSTS[2]
    SUMVAR21= F_TEKSTS[2]
    SUMVAR3 = F_TEKSTS[3]
    SUMVAR31= F_TEKSTS[3]
    IF PAV:D_K='K'
       PRINT(RPT:KO)
       IF F:KONTI='D'    !DRUKÂT KOR_KONTUS
          BUILDGGKTABLE(1)
          CLEAR(GGK_SUMMAV)
          CLEAR(GGK_BKK)
          LOOP J#=1 TO RECORDS(ggK_TABLE)
             GET(GGK_TABLE,J#)
             IF GGT:D_K='K'
                GGK_SUMMAV=ROUND(GGT:SUMMAV,.01)
                GGK_BKK=GGT:BKK
                PRINT(RPT:DETAIL_KOR)
             .
          .
       .
       PRINT(RPT:DETAIL_LINE)
    .
    PVN_PROC=0
    if sumk_bo0
      sumk_bo=sumk_bo0
      sumk_pvno=0
      IF PAV:D_K='K' THEN PRINT(RPT:DETAIL_SUMMA).
    .
    IF PVNMASMODE
       PVN_PROC=10
    ELSE
       PVN_PROC=5
    .
    if sumk_bo5
      sumk_bo=sumk_bo5
      sumk_pvno=sumk_pvno5
      IF PAV:D_K='K' THEN PRINT(RPT:DETAIL_SUMMA).
    .
    PVN_PROC=12
    if sumk_bo12
      sumk_bo=sumk_bo12
      sumk_pvno=sumk_pvno12
      IF PAV:D_K='K' THEN PRINT(RPT:DETAIL_SUMMA).
    .
    IF PVNMASMODE
      PVN_PROC=21
    ELSE
      PVN_PROC=18
    .
    if sumk_bo18
      sumk_bo=sumk_bo18
      sumk_pvno=sumk_pvno18
      IF PAV:D_K='K' THEN PRINT(RPT:DETAIL_SUMMA).
    .
    IF PAV:D_K='K' THEN PRINT(RPT:KO1).
    IF PAV:D_K='D'
        PRINT(RPT:DETAIL)
        PRINT(RPT:DETAIL1)
        PRINT(RPT:DETAIL2)
        PRINT(RPT:DETAIL3)
        PRINT(RPT:DETAIL5)
    END
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
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
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
SPZ_PavadA           PROCEDURE                    ! Declare Procedure
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
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
RPT_GADS             STRING(4)
GADS1                STRING(1)
DATUMS               STRING(2)
ADRESEF              STRING(60)
gov_reg              STRING(40)
RPT_CLIENT           STRING(45)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
MKD                  STRING(45)
NOSAUKUMS            STRING(50)
KESKA                STRING(60)
TexTeksts            STRING(60)
KEKSIS               STRING(1)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEKTEKSTS            STRING(60)
NOS_P                STRING(45)
ADRESE1              STRING(60)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
CONS1                STRING(15)
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
DAUDZUMS_S           STRING(15)
DAUDZUMSK_S          STRING(15)
CENA                 DECIMAL(16,5)
CENA_S               STRING(15)
SUMMA_B              DECIMAL(16,4)
SUMMA_BS             STRING(15)
KOPA                 STRING(15)
IEPAK_DK             DECIMAL(3)
SUMK_B               DECIMAL(13,2)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
PAV_T_PVN            DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PLKST                TIME
PAV_AUTO             STRING(80)
SYS_PARAKSTS         STRING(25)
MENESIS              STRING(10)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
report REPORT,AT(146,398,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
DETAIL0 DETAIL,AT(,,,1000)
       END
PAGE_HEAD DETAIL,AT(,,,2292),USE(?unnamed)
         STRING(@s25),AT(5104,1823,1615,156),USE(pav:pamat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.b),AT(2396,1823,625,156),USE(pav:c_datums),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksas kârtîba'),AT(344,1979,938,156),USE(?String1:14),LEFT
         STRING(@s15),AT(1354,1979,990,156),USE(cons1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1302,1406,3490,156),USE(adreseF),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s51),AT(3854,2135,3281,156),USE(TexTEKSTS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3854,1979,2917,156),USE(atlauja),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,313,0,1458),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('08. Speciâlas atzîmes'),AT(3854,1823,1146,156),USE(?String1:16),LEFT
         LINE,AT(52,1771,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s60),AT(365,52,7552,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(7083,1510,781,208),USE(par_ban_kods),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,1406,2604,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Izkrauðanas vieta'),AT(344,1406,938,156),USE(?String1:13),LEFT
         STRING('Kods :'),AT(6719,1510,365,208),USE(?String1:5),LEFT
         STRING(@s21),AT(5292,1510,1417,208),USE(par_ban_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(5313,1146,2552,208),USE(gov_reg),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(4792,1510,365,208),USE(?String1:9),RIGHT
         STRING('Konts'),AT(4792,781,365,208),USE(?String1:7),RIGHT
         STRING(@s11),AT(7083,781,781,208),USE(BKODS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1042,7813,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('04. Preèu saòçmçjs'),AT(156,1094,1094,156),USE(?String1:10),LEFT
         STRING(@s21),AT(5292,781,1427,208),USE(REK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods :'),AT(6719,781,365,208),USE(?String1:3),LEFT
         LINE,AT(5260,677,2604,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s47),AT(1302,677,3490,156),USE(adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Iekrauðanas vieta'),AT(344,677,938,156),USE(?String1:17),LEFT
         STRING(@s45),AT(1302,365,3438,156),USE(RPT_client),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(4792,417,313,208),USE(?String1:6),RIGHT
         STRING(@s13),AT(6823,417,833,208),USE(fin_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(6490,396),USE(?String101)
         STRING('NMR'),AT(5313,406),USE(?String100)
         STRING('03. Norçíinu rekvizîti'),AT(156,833,1094,156),USE(?String1:4),LEFT
         STRING(@s31),AT(1302,833,2344,156),USE(banka),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,313,2604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5260,313,0,1458),USE(?Line81),COLOR(COLOR:Black)
         STRING('07. Samaksas veids'),AT(156,1823,1146,156),USE(?String1:15),LEFT
         STRING(@s15),AT(1354,1823,990,156),USE(cons),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(1302,1563,2344,156),USE(par_banka),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1302,1250,3490,156),USE(adrese1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1302,1094,3490,156),USE(nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3646,1771,0,521),USE(?Line8),COLOR(COLOR:Black)
         STRING('06. Norçíinu rekvizîti'),AT(156,1563,1094,156),USE(?String1:12),LEFT
         STRING('Kods'),AT(4844,1146,313,208),USE(?String1:8),RIGHT
         STRING('05. Adrese'),AT(156,1250,1094,156),USE(?String1:11),LEFT
         STRING(@s11),AT(5646,417,729,208),USE(reg_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s47),AT(1302,521,3490,156),USE(ju_adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('01. Preèu nosûtîtâjs'),AT(156,365,1094,156),USE(?String1),LEFT
         STRING('02. Juridiskâ adrese'),AT(156,521,1094,156),USE(?String1:2),LEFT
       END
PAGE_HEAD1 DETAIL,AT(,,,354)
         LINE,AT(4219,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5156,52,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(6146,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7500,52,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(417,104,3229,208),USE(?String38:2),CENTER
         STRING('10. Mçrv.'),AT(3698,104,521,208),USE(?String38:5),CENTER
         STRING('11. Daudzums'),AT(4271,104,885,208),USE(?String38:6),CENTER
         STRING('12. Cena'),AT(5208,104,938,208),USE(?String38:4),CENTER
         STRING('13. Summa'),AT(6198,104,1302,208),USE(?String38:7),CENTER
         STRING('PVN'),AT(7552,104,313,208),USE(?String38:3),CENTER
         LINE,AT(3646,0,0,374),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(104,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(365,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,104,188,188),USE(?String38),CENTER
         LINE,AT(104,313,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,313)
         LINE,AT(3646,-10,0,333),USE(?Line8:9),COLOR(COLOR:Black)
         STRING(@s6),AT(3750,0,417,156),USE(nom:mervien),LEFT
         LINE,AT(4219,-10,0,333),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@S15),AT(4271,0,833,156),USE(daudzums_S),RIGHT
         LINE,AT(5156,-10,0,333),USE(?Line8:11),COLOR(COLOR:Black)
         STRING(@S15),AT(5208,0,885,156),USE(cena_S),RIGHT
         LINE,AT(6146,-10,0,333),USE(?Line8:12),COLOR(COLOR:Black)
         STRING(@S15),AT(6198,0,968,156),USE(summa_bS),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(nol:val),LEFT
         LINE,AT(7500,-10,0,333),USE(?Line8:23),COLOR(COLOR:Black)
         STRING(@n2),AT(7552,0,156,156),USE(nol:pvn_proc),RIGHT
         STRING('%'),AT(7708,0,156,156),USE(?String38:8),LEFT
         LINE,AT(7865,-10,0,333),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@s50),AT(417,156,3229,156),USE(noM:RINDA2PZ),LEFT
         STRING(@s50),AT(417,0,3229,156),USE(nosaukums),LEFT
         LINE,AT(365,-10,0,333),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,333),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@s3),AT(156,0,208,156),USE(RPT_npk),RIGHT
       END
BLANK  DETAIL,AT(,-10,,156)
         LINE,AT(3646,0,0,176),USE(?Line8:24),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,176),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,176),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,176),USE(?Line8:17),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,176),USE(?Line8:19),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,176),USE(?Line8:22),COLOR(COLOR:Black)
         LINE,AT(365,0,0,176),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(104,0,0,176),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,104),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(365,0,0,104),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(3646,0,0,104),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,104),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,104),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,104),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,104),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,104),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,156)
         LINE,AT(3646,-10,0,176),USE(?Line8:29),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,176),USE(?Line8:30),COLOR(COLOR:Black)
         LINE,AT(5156,-10,0,176),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(6146,-10,0,176),USE(?Line8:26),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6438,0,729,156),USE(sumk_b),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(PAV:val),LEFT
         STRING(@S15),AT(4271,0,833,156),USE(daudzumsK_S),RIGHT
         LINE,AT(7500,-10,0,176),USE(?Line8:27),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,176),USE(?Line8:28),COLOR(COLOR:Black)
         STRING(@s15),AT(417,0,1094,156),USE(kopa),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:916),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:115),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,156)
         LINE,AT(104,0,0,52),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(3646,0,0,52),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,52),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,52),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:7),COLOR(COLOR:Black)
       END
RPT_FOOT31 DETAIL,AT(,-10,,417)
         LINE,AT(104,0,0,52),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(3646,0,0,52),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(5156,0,0,52),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,52),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:6),COLOR(COLOR:Black)
         STRING('Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu'),AT(156,156,3542,208), |
             USE(?String62),LEFT
         STRING(@n-_10.2),AT(3750,156,625,208),USE(pav:summa_A),RIGHT
         STRING(@s3),AT(4427,156,260,208),USE(pav:val,,?pav:val:7),LEFT
       END
RPT_FOOT32 DETAIL,AT(,,,281)
         STRING('Preèu, taras svars :'),AT(156,52,1094,208),USE(?String62:2),LEFT
         STRING(@n_9.2),AT(1302,52,625,208),USE(svars),RIGHT
         STRING('kg.'),AT(1979,52,208,208),USE(?String62:3),LEFT
       END
RPT_FOOT33 DETAIL,AT(,,,281)
         STRING('Transporta pakalpojumi :'),AT(156,52,1302,208),USE(?String62:4),LEFT
         STRING(@n-_12.2),AT(6385,52,781,208),USE(pav_T_summa),RIGHT
       END
RPT_FOOT4 DETAIL,AT(,,,708)
         STRING('17. Pievienotâs vçrtîbas nodoklis  '),AT(156,52,2031,208),USE(?String62:5),LEFT
         STRING('18. Pavisam apmaksai'),AT(156,260,2031,208),USE(?String62:6),LEFT
         STRING('(ar cipariem)'),AT(5625,260,677,208),USE(?String62:8),LEFT
         STRING(@n-_13.2),AT(6333,260,833,208),USE(sumk_APM),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7240,260,260,208),USE(pav:val,,?pav:val:3),LEFT
         STRING('(ar vârdiem)'),AT(156,469,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(833,469,7135,208),USE(sumV),LEFT,COLOR(0D3D3D3H)
         STRING(@n-_13.2),AT(6333,52,833,208),USE(sumk_PVN),RIGHT
         STRING(@s3),AT(7240,52,260,208),USE(pav:val,,?pav:val:2),LEFT
       END
RPT_FOOT41 DETAIL,AT(,,,281)
         STRING('a/m, vadîtâjs'),AT(208,52,677,208),USE(?String62:9),LEFT
         STRING(@s80),AT(885,52,4542,208),USE(pav_auto),LEFT
         STRING('Pielikumâ :'),AT(5521,52,573,208),USE(?String62:10),LEFT
         STRING(@s21),AT(6094,52,1615,208),USE(pav:pielik),LEFT
       END
RPT_FOOT5 DETAIL,AT(,,,1292)
         STRING('Z. V.'),AT(729,1094,521,208),USE(?String62:21),LEFT
         STRING('Z. V.'),AT(4427,1094,521,208),USE(?String62:22),LEFT
         LINE,AT(729,990,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(4427,990,2656,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s25),AT(1146,510,2500,208),USE(sys_paraksts),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,52,7760,0),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(3750,52,0,1250),USE(?Line76),COLOR(COLOR:Black)
         STRING('20. Pieòçma :'),AT(3906,104,781,208),USE(?String62:13),LEFT
         STRING('19. Preèu piegâdes vai pakalpojumu sniegðanas datums:'),AT(208,104,3490,208),USE(?String62:11), |
             LEFT
         STRING('Vârds, uzvârds'),AT(3906,313,885,208),USE(?String62:14),LEFT
         STRING('Vârds, uzvârds'),AT(208,510,885,208),USE(?String62:12),LEFT
         LINE,AT(4792,469,2188,0),USE(?Line77),COLOR(COLOR:Black)
         STRING(@s4),AT(354,313,313,208),USE(RPT_GADS),RIGHT
         STRING('. gada  "'),AT(667,313,417,208),USE(?String62:23),LEFT
         STRING(@n2),AT(1083,313,156,208),USE(datums),RIGHT
         STRING('"'),AT(1260,313,104,208),USE(?String62:16),LEFT
         STRING(@s10),AT(1396,313,677,208),USE(menesis),LEFT
         STRING('. gada  "'),AT(4271,521,417,208),USE(?String62:17),LEFT
         STRING('"'),AT(4948,521,104,208),USE(?String62:18),LEFT
         LINE,AT(3906,677,365,0),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(4688,677,260,0),USE(?Line78:2),COLOR(COLOR:Black)
         LINE,AT(5052,677,1615,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING('Paraksts'),AT(208,833,521,208),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(3906,833,521,208),USE(?String62:20),LEFT
       END
       FOOTER,AT(146,11200,8000,52)
         LINE,AT(104,0,7760,0),USE(?Line5:9),COLOR(COLOR:Black)
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
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(BANKAS_K,1)
  V#=0
! SUMMA    =0
  AN       =0
  TARA#=0
  NPK=0
  I# = 0
  GETMYBANK('')
  gads1=year(pav:datums)-1990
  RPT_gads=year(pav:datums)
  datums=day(pav:datums)
  menesis=MENVAR(pav:datums,2,2)
  KESKA = RPT_GADS&'. gada '&datums&'. '&menesis
  PAV_AUTO=GETAUTO(PAV:VED_NR,2)
  TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
  plkst=clock()
! RPT:ATLSUMK=0
  CASE PAV:APM_V
  OF '1'
    CONS1='Priekðapmaksa'
  OF '2'
    CONS1='Pçcapmaksa'
  OF '3'
    CONS1='Konsignâcija'
  OF '4'
    CONS1='Apmaksa uzreiz'
  END
  CASE PAV:APM_K
  OF '1'
    CONS = 'Pârskaitîjums'
  OF '2'
    CONS = 'Skaidrâ naudâ'
  OF '3'
    CONS = 'Barters'
  END
  par:nos_p=GETPAR_K(pav:PAR_NR,2,2)
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  CASE PAV:D_K
  OF 'D'
    RPT_CLIENT=PAR:NOS_P
    ADRESE=PAR:ADRESE
    JU_ADRESE=PAR:ADRESE
    reg_nr=PAR:NMR_KODS
    RPT_BANKA=''
!   RPT:BKODS=PAR:BAN_KODS
    RPT_REK  =PAR:BAN_NR
    NOS_P=CLIENT
    gov_reg=gl:reg_nr
    ADRESE1=SYS:ADRESE
!   RPT:NOLIKTAVA=''
  ELSE
    RPT_CLIENT=CLIENT
    JU_ADRESE=GL:ADRESE
    ADRESE=CLIP(SYS:ADRESE)&' t.'&clip(sys:tel)
    reg_nr=gl:reg_nr
    fin_nr=gl:VID_NR
    RPT_BANKA=BANKA
!   RPT:BKODS=BKODS
    RPT_REK  =REK
    ATLAUJA =SYS:ATLAUJA
!    MKD  =SYS:MKD
    NOS_P=PAR:NOS_P
    gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
    ADRESE1=PAR:ADRESE
    ADRESEF=GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
!   RPT:NOLIKTAVA=SYS:AVOTS
    checkopen(bankas_k)
    clear(ban:record)
    IF F:PAK = '2'   !F:PAK NO SELPZ
       PAR_ban_kods=par:ban_kods2
       par_ban_nr=par:ban_nr2
    ELSE
       PAR_ban_kods=par:ban_kods
       par_ban_nr=par:ban_nr
    .
    par_banka=GETBANKAS_K(PAR_BAN_KODS,2,1)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)
  BIND(PAV:RECORD)
  BIND(TEK:RECORD)
  BIND(BAN:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Generating Report'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR=PAV:U_NR'
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
      PRINT(RPT:DETAIL0)
      PRINT(RPT:PAGE_HEAD)
      PRINT(RPT:PAGE_HEAD1)
      FILLPVN(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
        SVARS+=GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums
        fillpvn(1)
        DAUDZUMS=ROUND(NOL:DAUDZUMS,.001)
        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
        IF ~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
        .
        CENA_S=CUT0(CENA,5,2)
        SUMMA_B= calcsum(3,4)
        SUMMA_BS=CUT0(SUMMA_B,4,2)
        IF SUMMA_BS[15]='0'
            SUMMA_BS[15]=CHR(32)
            IF SUMMA_BS[14]='0'
                SUMMA_BS[14]=CHR(32)
            END
        END
        iepak_DK  += nol:iepak_d
        DAUDZUMSK += DAUDZUMS
!        IF NOL:PARADS
!          KEKSIS='P'
!        ELSE
          KEKSIS=' '
!        .
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        PRINT(RPT:DETAIL)                            !  PRINT DETAIL LIS
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
        POST(Event:CloseWindow)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
    PRINT(RPT:RPT_FOOT1)
    SUMK_B=ROUND(GETPVN(3),.01)
    kopa='Kopâ:'
    PRINT(RPT:RPT_FOOT2)                        !PRINT GRAND TOTALS
    IEPAK_DK=0
    DAUDZUMSK_S=''
    IF GETPVN(20)  ! IR VAIRÂK PAR VIENU PREÈU TIPU
      LOOP I#=4 TO 9
        SUMK_B=ROUND(GETPVN(I#),.01)
        IF SUMK_B <> 0
          EXECUTE I#-3
            kopa='t.s. prece'
            kopa='t.s. tara '
            kopa='t.s. pakalpojumi'
            kopa='t.s. kokmateriâli'
            kopa='t.s. raþojumi'
            kopa='t.s. citi'
          .
          PRINT(RPT:RPT_FOOT2)
        .
      .
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A <= 0
      PRINT(RPT:RPT_FOOT3)
    ELSE
      PRINT(RPT:RPT_FOOT31)
    .
!************************* SVARS ***********
    IF SVARS AND BAND(SYS:BAITS1,00010000B)
       PRINT(RPT:RPT_FOOT32)
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
!      PAV_T_SUMMA=ROUND(pav:t_summa/(1+PAV:T_PVN/100),.01)                  !TRANSPORTS BEZ PVN
      PAV_T_SUMMA=PAV:T_SUMMA-ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01) !10/03/03
      PRINT(RPT:RPT_FOOT33)
    .
!************************* PVN ***********
!   RPT:SUMK_PVN= ROUND(SUMK_AN-SUMK_BN+pav:t_summa*(1-1/(1+PAV:T_AN/100)),.01)
!   RPT:SUMK_PVN = ROUND(getpvn(1),.01)
    SUMK_PVN = ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_pvN/100)),.01)
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît Summas')
!     kluda(74,'')
!     print(rpt:rpt_err)
!     CLOSE(REPORT)
!     RETURN
    .
    SUMK_B=ROUND(GETPVN(3),.01)
    SUMK_APM = SUMK_B + SUMK_PVN + PAV_T_SUMMA
    SUMV=SUMVAR(SUMK_APM,PAV:VAL,0)
    PRINT(RPT:RPT_FOOT4)
!***************************************************
    IF PAV_AUTO OR PAV:PIELIK
        PRINT(RPT:RPT_FOOT41)
    END
    PRINT(RPT:RPT_FOOT5)                           
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
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
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
SPZ_Pilnvara         PROCEDURE                    ! Declare Procedure
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
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
rpt_GADS             STRING(4)
GADS1                STRING(1)
DATUMS               STRING(2)
gov_reg              STRING(40)
RPT_CLIENT           STRING(45)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
ved_PASE             STRING(35)
ved_nos_p            STRING(35)
VED_PERS_KODS        SHORT
nosaukums            STRING(30)
KESKA                STRING(60)
TexTeksts            STRING(60)
KEKSIS               STRING(1)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(18)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEKTEKSTS            STRING(60)
NOS_P                STRING(45)
ADRESE1              STRING(60)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
RET                  BYTE
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
CENA                 DECIMAL(16,5)
SUMMA_B              DECIMAL(16,4)
KOPA                 STRING(15)
IEPAK_DK             DECIMAL(3)
SUMK_B               DECIMAL(13,2)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PLKST                TIME
MENESIS              STRING(10)
!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END

report REPORT,AT(146,1398,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
PAGE_HEAD DETAIL,AT(,,,2958),USE(?unnamed)
         LINE,AT(52,2500,7813,0),USE(?Line5:10),COLOR(COLOR:Black)
         STRING(@s35),AT(1406,1875,2292,208),USE(ved_PASE),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(4896,1406,313,208),USE(?String1:5),RIGHT
         STRING(@s25),AT(1406,2552,1667,208),USE(pav:pamat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1615,7813,0),USE(?Line5:9),COLOR(COLOR:Black)
         STRING(@s60),AT(1417,2760,3802,208),USE(Texteksts),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(1406,1146,990,208),USE(atlauja),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,313,0,2188),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('08. Speciâlas atzîmes'),AT(167,2542,1146,208),USE(?String1:12),LEFT
         STRING(@s60),AT(1406,729,3594,208),USE(GL:adrese),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('04. Licence'),AT(156,1146,677,208),USE(?String1:18),LEFT
         STRING(@s60),AT(365,52,7552,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(5313,1406,2552,208),USE(gov_reg),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(4844,1094,365,208),USE(?String1:6),RIGHT
         STRING(@s11),AT(7083,1094,781,208),USE(BKODS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1354,7813,0),USE(?Line5),COLOR(COLOR:Black)
         STRING(@s18),AT(5313,1094,1198,208),USE(RPT_reK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods :'),AT(6719,1094,365,208),USE(?String1:7),LEFT
         STRING(@d06.),AT(1823,313,677,208),USE(pav:datums),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(4896,521,313,208),USE(?String1:8),RIGHT
         STRING(@s13),AT(6146,521,833,208),USE(fin_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(365,729,469,208),USE(?String1:3),LEFT
         STRING('03. Norçíinu rekvizîti'),AT(156,938,1094,208),USE(?String1:4),LEFT
         STRING(@s31),AT(1406,938,2031,208),USE(RPT_banka),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,313,2604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5260,313,0,2188),USE(?Line81),COLOR(COLOR:Black)
         STRING('07. Saòemðanai no'),AT(156,2083,1198,208),USE(?String1:11),LEFT
         STRING(@s15),AT(1406,2083,990,208),USE(SYS:AVOTS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1406,2292,3802,208),USE(SYS:ADRESE),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('05. Maksâtâjs'),AT(156,1406,729,208),USE(?String1:19),LEFT
         STRING(@s35),AT(1406,1667,2656,208),USE(ved_nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1406,1406,3438,208),USE(nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods'),AT(4375,1875,833,208),USE(?String1:9),RIGHT
         STRING(@P######-#####P),AT(5313,1875),USE(VED_PERS_KODS),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('06. Pilnvarotâ persona'),AT(156,1667,1198,208),USE(?String1:10),LEFT
         STRING(@s11),AT(5313,521,729,208),USE(reg_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1406,521,3333,208),USE(RPT_CLIENT),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('01. Pilnvaras derîguma termiòð'),AT(156,313,1615,208),USE(?String1),LEFT
         STRING('02. Pilnvaras izdevçjs'),AT(156,521,1198,208),USE(?String1:2),LEFT
       END
PAGE_HEAD1 DETAIL,AT(,,,354)
         LINE,AT(2240,52,0,313),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(3854,52,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(4635,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5365,52,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(6250,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7500,52,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(417,104,1823,208),USE(?String38:2),CENTER
         STRING(@s21),AT(2292,104,1563,208),USE(nom_SER),CENTER
         STRING('Iep'),AT(3906,104,260,208),USE(?String38:4),CENTER
         STRING('10.Mçr.'),AT(4219,104,417,208),USE(?String38:5),CENTER
         STRING('11. Daudz.'),AT(4688,104,677,208),USE(?String38:6),CENTER
         STRING('12. Cena'),AT(5417,104,833,208),USE(?String38:7),CENTER
         STRING('13. Summa'),AT(6302,104,1198,208),USE(?String38:8),CENTER
         STRING('PVN'),AT(7552,104,313,208),USE(?String38:3),CENTER
         LINE,AT(4167,52,0,313),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(104,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(365,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,104,188,188),USE(?String38),CENTER
         LINE,AT(104,313,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(2240,-10,0,198),USE(?Line8:30),COLOR(COLOR:Black)
         STRING(@s21),AT(2292,10,1563,156),USE(nomenk),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3854,-10,0,198),USE(?Line8:29),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(3906,10,208,156),USE(nol:iepak_d),RIGHT
         LINE,AT(4167,-10,0,198),USE(?Line8:12),COLOR(COLOR:Black)
         STRING(@s6),AT(4219,10,417,156),USE(nom:mervien),LEFT
         LINE,AT(4635,-10,0,198),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@N-_12.3),AT(4688,10,625,156),USE(daudzums),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line8:26),COLOR(COLOR:Black)
         STRING(@N-_15.5),AT(5417,10,781,156),USE(cena),RIGHT
         LINE,AT(6250,-10,0,198),USE(?Line8:27),COLOR(COLOR:Black)
         STRING(@N-_15.4B),AT(6302,10,781,156),USE(summa_b),RIGHT
         STRING(@s3),AT(7135,10,260,156),USE(nol:val),LEFT
         STRING(@s1),AT(7396,10,104,156),USE(KEKSIS),CENTER
         LINE,AT(7500,-10,0,198),USE(?Line8:23),COLOR(COLOR:Black)
         STRING(@n2),AT(7552,10,156,156),USE(nol:pvn_proc),RIGHT
         STRING('%'),AT(7708,10,156,156),USE(?String38:9),LEFT
         LINE,AT(7865,-10,0,198),USE(?Line8:28),COLOR(COLOR:Black)
         STRING(@s30),AT(417,10,1823,156),USE(NOM:NOS_P),LEFT
         LINE,AT(365,-10,0,198),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s3),AT(156,10,208,156),USE(RPT_npk),RIGHT
       END
BLANK  DETAIL,AT(,-10,,177)
         LINE,AT(2240,0,0,198),USE(?Line8:130),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,198),USE(?Line8:129),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,198),USE(?Line8:112),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,198),USE(?Line8:125),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,198),USE(?Line8:126),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,198),USE(?Line8:127),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,198),USE(?Line8:123),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,198),USE(?Line8:128),COLOR(COLOR:Black)
         LINE,AT(365,0,0,198),USE(?Line8:131),COLOR(COLOR:Black)
         LINE,AT(104,0,0,198),USE(?Line8:132),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(365,0,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,114),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,114),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,114),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,114),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,114),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(2240,-10,0,198),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,198),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(3906,10,208,156),USE(iepak_dk),RIGHT
         LINE,AT(4167,-10,0,198),USE(?Line8:24),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,198),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,198),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6302,10,677,156),USE(sumk_b),RIGHT
         STRING(@s3),AT(7135,10,260,156),USE(PAV:val),LEFT
         LINE,AT(7500,-10,0,198),USE(?Line8:19),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@s15),AT(417,10,1094,156),USE(kopa),LEFT
         LINE,AT(365,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,52),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,52),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,52),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,52),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,52),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:7),COLOR(COLOR:Black)
       END
RPT_FOOT31 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(2240,0,0,52),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,52),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,52),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,52),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,52),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(6250,0,0,52),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:6),COLOR(COLOR:Black)
       END
RPT_FOOT4 DETAIL,WITHPRIOR(3),AT(,,,708)
         STRING('17. Pievienotâs vçrtîbas nodoklis  '),AT(156,63,2031,208),USE(?String62:5),LEFT
         STRING('18. Preèu vçrtîba'),AT(156,260,1094,208),USE(?String62:6),LEFT
         STRING('(ar cipariem)'),AT(5104,260,677,208),USE(?String62:8),LEFT
         STRING(@n-_13.2),AT(6146,260,833,208),USE(sumk_APM),RIGHT
         STRING(@s3),AT(7135,260,260,208),USE(pav:val,,?pav:val:3),LEFT
         STRING('(ar vârdiem)'),AT(156,469,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(833,469,7135,208),USE(sumV),LEFT,COLOR(0D3D3D3H)
         STRING(@n-_13.2),AT(6146,52,833,208),USE(sumk_PVN),RIGHT
         STRING(@s3),AT(7135,52,260,208),USE(pav:val,,?pav:val:2),LEFT
       END
RPT_FOOT5 DETAIL,WITHPRIOR(4),AT(,,,1708)
         STRING('Z. V.'),AT(729,1406,521,208),USE(?String62:21),LEFT
         LINE,AT(729,1146,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(4427,1146,2656,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING(@s25),AT(1146,365,2552,208),USE(sys:paraksts1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,52,7760,0),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(3750,52,0,1615),USE(?Line76),COLOR(COLOR:Black)
         STRING('20. Pilnvarotas personas'),AT(3906,156,1406,208),USE(?String62:13),LEFT
         STRING('19. Realizâcijas daïas priekðnieks'),AT(208,156,1771,208),USE(?String62:11),LEFT
         STRING('Vârds, uzvârds'),AT(3906,365,885,208),USE(?String62:14),LEFT
         STRING('Vârds, uzvârds'),AT(208,365,885,208),USE(?String62:12),LEFT
         LINE,AT(4792,521,2188,0),USE(?Line77),COLOR(COLOR:Black)
         STRING(@s4),AT(208,625,313,208),USE(RPT_GADS),RIGHT
         STRING('. gada  "'),AT(521,625,417,208),USE(?String62:15),LEFT
         STRING(@n2),AT(938,625,156,208),USE(datums),RIGHT
         STRING('"'),AT(1115,625,104,208),USE(?String62:16),LEFT
         STRING(@s10),AT(1250,625,677,208),USE(menesis),LEFT
         STRING(@T1),AT(2083,625,365,208),USE(plkst),LEFT
         STRING('Paraksts'),AT(208,990,521,208),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(3906,990,521,208),USE(?String62:20),LEFT
       END
       FOOTER,AT(146,11350,8000,52)
         LINE,AT(104,0,7760,0),USE(?Line785:9),COLOR(COLOR:Black)
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
 CHECKOPEN(NOLIK,1)
 CHECKOPEN(NOM_K,1)
 CHECKOPEN(PAR_K,1)
 CHECKOPEN(PAVAD,1)
 CHECKOPEN(TEK_K,1)
 CHECKOPEN(BANKAS_K,1)
 V#=0
!SUMMA    =0
 AN       =0
 TARA#=0
 NPK=0
 I# = 0
 gads1=year(pav:datums)-1990
 RPT_gads='PILNVARA Nr '&PAV:U_NR
!gads=clip(gads)&' '&year(pav:datums)
 datums=day(pav:datums)
 menesis=MENVAR(pav:datums,2,2)
 PLKST = CLOCK()
 KESKA = 'PILNVARA Nr '&PAV:U_NR
 TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
 EXECUTE PAV:APM_K
    CONS = 'Pârskaitîjums'
    CONS = 'Skaidrâ naudâ'
    CONS = 'Barters'
 .
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
  OF 'K'
    nom_ser='Kods'
    RET=4
  OF 'C'  
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .
  VED_NOS_P=GETPAR_K(PAV:VED_NR,2,7)
  VED_NOS_P=PAR:NOS_P
  VED_PERS_KODS=GETPAR_K(pav:ved_nr,0,8)
  VED_PASE     =PAR:pase
  TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
  PAR:NOS_P=GETPAR_K(PAV:PAR_NR,2,3)
  RPT_CLIENT=CLIENT
  ADRESE=CLIP(SYS:ADRESE)&' t.'&clip(sys:tel)
  reg_nr=gl:reg_nr
  fin_nr=gl:VID_NR
  RPT_BANKA=BANKA
! RPT:BKODS=BKODS
  RPT_REK  =REK
  ATLAUJA =SYS:ATLAUJA
  NOS_P=PAR:NOS_P
  gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
! RPT:ADRESE1=PAR:ADRESE
! RPT:NOLIKTAVA=SYS:AVOTS
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)
  BIND(PAV:RECORD)
  BIND(TEK:RECORD)
  BIND(BAN:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pilnvara'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR=PAV:U_NR'
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
      PRINT(RPT:PAGE_HEAD)
      PRINT(RPT:PAGE_HEAD1)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,RET)
        NOSAUKUMS=NOM:NOS_P
        fillpvn(1)
        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
        IF ~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
        .
        SUMMA_B = calcsum(3,4)
        iepak#+=nol:iepak_d
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        PRINT(RPT:DETAIL)
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
        POST(Event:CloseWindow)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    PRINT(RPT:RPT_FOOT1)
    SUMK_B=ROUND(GETPVN(3),.01)
    kopa='Kopâ:'
    PRINT(RPT:RPT_FOOT2)
    IF GETPVN(20)  ! IR VAIRÂK PAR VIENU PREÈU TIPU
      LOOP I#=4 TO 9
        SUMK_B=ROUND(GETPVN(I#),.01)
        IF SUMK_B <> 0
          EXECUTE I#-3
            kopa='t.s. prece'
            kopa='t.s. tara '
            kopa='t.s. pakalpojumi'
            kopa='t.s. kokmateriâli'
            kopa='t.s. raþojumi'
            kopa='t.s. citi'
          .
          PRINT(RPT:RPT_FOOT2)
        .
      .
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A = 0
      PRINT(RPT:RPT_FOOT3)
    ELSE
      PRINT(RPT:RPT_FOOT31)
    .
!************************* PVN ***********
!   RPT:SUMK_PVN= ROUND(SUMK_AN-SUMK_BN+pav:t_summa*(1-1/(1+PAV:T_AN/100)),.01)
!   RPT:SUMK_PVN = ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_AN/100)),.01)
    SUMK_PVN = ROUND(getpvn(1),.01)       !BEZ TRANSPORTA
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît Summas')
!     kluda(74,'')
!     print(rpt:rpt_err)
!     CLOSE(REPORT)
!     RETURN
    .
!   RPT:SUMK_APM=RPT:SUMK_B+RPT:SUMK_PVN+RPT:PAV_T_SUMMA
    SUMK_B=ROUND(GETPVN(3),.01)
    SUMK_APM = SUMK_B + SUMK_PVN                  !TIKAI PRECE
    SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
    PRINT(RPT:RPT_FOOT4)
!***************************************************
    PRINT(RPT:RPT_FOOT5)
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
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
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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


!*************************************************************************
OMIT('DIANA')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    IF ~(nol:NR = PAV:NPK) THEN BREAK.           !BREAK ON END OF SELECTION
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
DIANA
!*************************************************************************
!*************************************************************************
!*************************************************************************
