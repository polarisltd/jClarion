                     MEMBER('winlats.clw')        ! This is a MEMBER module
SPZ_Pavad            PROCEDURE                    ! Declare Procedure
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

SUMMA_BS             STRING(15)
DAUDZUMS_S           STRING(15)
DAUDZUMSK_S          STRING(15)
CENA_S               STRING(15)
CENA_A               STRING(15)
CenaArPVN_S          STRING(15)
LBKURSS              DECIMAL(14,6)
LS_SUMMA             DECIMAL(12,2)
LS_PVN               DECIMAL(12,2)
LS_                  STRING(3)
PAV_VAL              STRING(3)
VAL_UZSK1            STRING(5)
ATLAIDE              REAL
AN                   REAL
RPT_NPK              DECIMAL(3)
KESKA                STRING(65)
LAI                  ULONG

RPT_client           STRING(61) !45+15+1
GOV_REG              STRING(40)
JUADRESE             STRING(47)
FADRESE              STRING(52)
VARDS                STRING(30)

PAR_NOS_P            STRING(54) !45+8+1
PAR_gov_reg          STRING(40)
PAR_JUADRESE         STRING(60)
PAR_FADRESE          STRING(60)
PAR_BANKA            STRING(31)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)

SPEC_ATZ             STRING(60)
TEXTEKSTS            STRING(60)
CONS                 STRING(15)
CONS1                STRING(21)
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_NOSAUKUMS        STRING(50)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSZ            DECIMAL(12,3)
DAUDZUMSZ1           DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
AKCZ                 DECIMAL(5,3)
CENA                 DECIMAL(16,5)

CENAA                DECIMAL(16,5)
CenaArPVN            DECIMAL(16,5)

SUMMA_B              DECIMAL(16,4)
KOPA                 STRING(25)
NOL_IEPAK_D          DECIMAL(3)
IEPAK_DK             DECIMAL(3)
SUMK_X               DECIMAL(16,4)
SUMK_B               DECIMAL(13,2)
SUMK_12              DECIMAL(13,2) !Elya 07/08/2012
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
SUMK_ZEM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
PAV_T_PVN            DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PAV_AUTO             STRING(100)
RET                  BYTE
GGK_D_K              STRING(1),DIM(8)
GGK_BKK              STRING(5),DIM(8)
GGK_SUMMAV           DECIMAL(12,2),DIM(8)
PAV_PVN              STRING(2)
PAV_PAMAT            STRING(35)
NOL_PVN_PROC         STRING(2)
LINE                 STRING(132)
DOK_SENR             STRING(15)
Pavadzime            STRING(35)
SDA                  STRING(47)
pav_c_datums         LIKE(pav:c_datums)
STRINGSDA            STRING(20)
RKT                  STRING(1)
PAVISAM_APMAKSAI     STRING(60)
PRECUNOSAUKUMS_TEXT  STRING(30)
IZZINA               BYTE
SYS_BAITS            BYTE

SYS_AMATS            STRING(25)
SYS_PARAKSTS         STRING(25)
CODE39               STRING(30) !1+25+3+1
CODE39_TEXT          STRING(60)
CODE39_TEXT_2        STRING(60) !22/04/2013

DOKDATUMS            STRING(25)
LIDZ                 STRING(4)
ATGRIEZTA            STRING(20)

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

!-----------------------------------------------------------------------------
report REPORT,AT(146,400,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detailA4 DETAIL,AT(,,,1000),USE(?unnamed:27)
         STRING(@s35),AT(1781,573,4729,260),USE(pavadzime),TRN,CENTER(1),FONT(,14,,FONT:bold,CHARSET:BALTIC)
       END
detail0 DETAIL,AT(,,,1000),USE(?unnamed:24)
       END
PAGE_HEAD DETAIL,AT(,,,2271),USE(?unnamed:7)
         STRING(@s35),AT(5208,1823,2344,156),USE(pav_pamat),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(135,1823,1156,156),USE(StringSDA),TRN,LEFT
         STRING(@d06.b),AT(2677,1958,625,156),USE(pav_c_datums),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s4),AT(2396,1958,302,156),USE(LIDZ),TRN
         STRING(@s21),AT(1354,2094,1406,156),USE(cons1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samaksas kârtîba'),AT(344,2094,938,156),USE(?String1:19),LEFT
         STRING(@s60),AT(4063,2125,3802,156),USE(TEXTEKSTS),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(4063,1979,3802,156),USE(SPEC_ATZ),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7854,313,0,1458),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('08. Speciâlas atzîmes'),AT(4063,1823,1146,156),USE(?String1:17),LEFT
         LINE,AT(52,1771,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s65),AT(1490,0,4792,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_8),AT(7250,135),USE(PAV:U_NR),TRN,RIGHT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
         STRING(@s20),AT(3177,167,1438,177),USE(ATGRIEZTA),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(6885,0,938,156),USE(DOK_SENR),RIGHT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
         STRING(@s11),AT(7063,1510,781,208),USE(par_ban_kods),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,1406,2656,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Izkrauðanas vieta'),AT(365,1406,938,156),USE(?String1:18),LEFT
         STRING(@s60),AT(1354,1406,3438,156),USE(PAR_Fadrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods :'),AT(6698,1510,365,208),USE(?String1:15),LEFT
         STRING(@s21),AT(5260,1510,1417,208),USE(par_ban_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(5260,1146,2552,208),USE(PAR_gov_reg),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(4792,1510,365,208),USE(?String1:14),RIGHT
         STRING('Konts'),AT(4792,781,365,208),USE(?String1:9),RIGHT
         STRING(@s11),AT(7063,781,781,156),USE(BKODS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4521,781,313,156),USE(BVAL),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1042,7813,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('04. Preèu saòçmçjs'),AT(156,1094,1094,156),USE(?String1:10),LEFT
         STRING(@s21),AT(5260,781,1406,156),USE(REK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods :'),AT(6698,781,365,208),USE(?String1:7),LEFT
         LINE,AT(5208,677,2656,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s61),AT(1354,313,3490,156),USE(RPT_client),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(4844,417,313,208),USE(?String1:8),RIGHT
         STRING(@s40),AT(5260,417,2552,208),USE(GOV_REG),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegðanas vieta'),AT(365,625,938,156),USE(?String1:3),LEFT
         STRING(@s52),AT(1354,625,3438,156),USE(Fadrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('03. Norçíinu rekvizîti'),AT(156,781,1094,156),USE(?String1:4),LEFT
         STRING(@s31),AT(1354,781,2292,156),USE(BANKA),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,313,2656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5208,313,0,1458),USE(?Line81),COLOR(COLOR:Black)
         STRING('07. Samaksas veids'),AT(156,1958,1094,156),USE(?String1:16),LEFT
         STRING(@s15),AT(1354,1958,990,156),USE(cons),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(1354,1563,2344,156),USE(par_banka),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1354,1250,3438,156),USE(PAR_JUadrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s54),AT(1354,1094,3438,156),USE(PAR_nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,1771,0,521),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s47),AT(1354,1823,2646,156),USE(SDA),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('06. Norçíinu rekvizîti'),AT(156,1563,1094,156),USE(?String1:12),LEFT
         STRING('Kods'),AT(4844,1146,313,208),USE(?String1:13),RIGHT
         STRING('05. Adrese'),AT(156,1250,1094,156),USE(?String1:11),LEFT
         STRING(@s47),AT(1354,469,3490,156),USE(JUadrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('01. Preèu nosûtîtâjs'),AT(156,313,1094,156),USE(?String1),LEFT
         STRING('02. Juridiskâ adrese'),AT(156,469,1094,156),USE(?String1:2),LEFT
       END
TEKSTS DETAIL,AT(,,,167),USE(?unnamed:12)
         LINE,AT(4010,-10,0,197),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@s60),AT(4063,10,3802,156),USE(TEXTEKSTS,,?TEXTEKSTS:TEKSTS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD1 DETAIL,AT(,,,302),USE(?unnamed:10)
         LINE,AT(2385,0,0,313),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line8:46),COLOR(COLOR:Black)
         STRING(@s30),AT(396,52,1927,146),USE(PrecuNosaukums_text),CENTER
         STRING(@s21),AT(2438,63,1510,146),USE(nom_SER),CENTER
         STRING('Iep'),AT(4042,52,208,146),USE(?String38:4),CENTER
         STRING('10. Mçr.'),AT(4323,52,375,146),USE(?String38:5),CENTER
         STRING('11. Daudz.'),AT(4771,52,573,146),USE(?String38:6),CENTER
         STRING('12. Cena'),AT(5396,52,885,146),USE(?String38:7),CENTER
         STRING('13. Summa'),AT(6333,52,1146,146),USE(?String38:8),CENTER
         STRING('PVN'),AT(7531,52,313,146),USE(?String38:3),CENTER
         LINE,AT(4010,0,0,323),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(365,0,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,52,188,146),USE(?String38),CENTER
         LINE,AT(104,261,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,156),USE(?unnamed:6)
         LINE,AT(2385,-10,0,176),USE(?Line8:30),COLOR(COLOR:Black)
         STRING(@s21),AT(2438,0,1563,156),USE(nomenk),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,176),USE(?Line8:29),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(4042,0,208,156),USE(nol_iepak_d),RIGHT
         LINE,AT(4271,-10,0,176),USE(?Line8:12),COLOR(COLOR:Black)
         STRING(@s7),AT(4302,0,417,156),USE(nom:mervien),CENTER
         LINE,AT(4740,-10,0,176),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@S15),AT(4792,0,521,156),USE(daudzums_S),RIGHT
         LINE,AT(5365,-10,0,176),USE(?Line8:26),COLOR(COLOR:Black)
         STRING(@S15),AT(5417,0,833,156),USE(cena_S),RIGHT
         LINE,AT(6302,-10,0,176),USE(?Line8:27),COLOR(COLOR:Black)
         STRING(@S15),AT(6354,0,885,156),USE(summa_bS),RIGHT
         STRING(@s3),AT(7292,0,208,156),USE(nol:val),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line8:23),COLOR(COLOR:Black)
         STRING(@S2),AT(7542,0,156,156),USE(nol_pvn_proc),RIGHT
         STRING('%'),AT(7698,0,156,156),USE(?String38:9),LEFT
         LINE,AT(7854,-10,0,176),USE(?Line8:47),COLOR(COLOR:Black)
         STRING(@s35),AT(396,0,1979,156),USE(nom_nosaukums),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s3),AT(135,0,208,156),USE(RPT_npk),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,-10,,94),USE(?unnamed:20)
         LINE,AT(104,0,0,115),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(365,0,0,115),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2385,0,0,55),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,115),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,115),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,115),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,115),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,115),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,115),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
PAGE_HEAD1C DETAIL,AT(,,,302),USE(?unnamed:22)
         LINE,AT(2948,0,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,313),USE(?Line8:11C),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,313),USE(?Line8:14C),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,313),USE(?Line8:15C),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,313),USE(?Line8:18C),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line8:20C),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line8:46C),COLOR(COLOR:Black)
         STRING(@s30),AT(396,52,1927,146),USE(PrecuNosaukums_text,,?PrecuNosaukums_textC),CENTER
         STRING('Iep'),AT(4042,52,208,146),USE(?String38:2),CENTER
         STRING('10. Mçr.'),AT(4323,52,375,146),USE(?String38:5C),CENTER
         STRING('11. Daudz.'),AT(4771,52,573,146),USE(?String38:6C),CENTER
         STRING('12. Cena'),AT(5396,52,885,146),USE(?String38:7C),CENTER
         STRING('13. Summa'),AT(6333,52,1146,146),USE(?String38:8C),CENTER
         STRING('PVN'),AT(7531,52,313,146),USE(?String38:3C),CENTER
         STRING('Kods'),AT(3281,52,375,146),USE(?String38:10),TRN,CENTER
         LINE,AT(4010,0,0,323),USE(?Line8:3C),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line8:4C),COLOR(COLOR:Black)
         LINE,AT(365,0,0,313),USE(?Line8:7C),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,52,188,146),USE(?String38C),CENTER
         LINE,AT(104,261,7760,0),USE(?Line5:4C),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line5:3C),COLOR(COLOR:Black)
       END
detailC DETAIL,AT(,,,156),USE(?unnamed:21)
         LINE,AT(2948,-10,0,176),USE(?Line8:8),COLOR(COLOR:Black)
         STRING(@s13),AT(2975,0,1020,156),USE(nomenk,,?nomenk:3),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,176),USE(?Line8:29C),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(4042,0,208,156),USE(nol_iepak_d,,?nol_iepak_dC),RIGHT
         LINE,AT(4271,-10,0,176),USE(?Line8:12C),COLOR(COLOR:Black)
         STRING(@s7),AT(4302,0,417,156),USE(nom:mervien,,?nom:mervienC),CENTER
         LINE,AT(4740,-10,0,176),USE(?Line8:25C),COLOR(COLOR:Black)
         STRING(@S15),AT(4792,0,521,156),USE(daudzums_S,,?daudzums_SC),RIGHT
         LINE,AT(5365,-10,0,176),USE(?Line8:26C),COLOR(COLOR:Black)
         STRING(@S15),AT(5417,0,833,156),USE(cena_S,,?cena_SC),RIGHT
         LINE,AT(6302,-10,0,176),USE(?Line8:27C),COLOR(COLOR:Black)
         STRING(@S15),AT(6354,0,885,156),USE(summa_bS,,?summa_bSC),RIGHT
         STRING(@s3),AT(7292,0,208,156),USE(nol:val,,?nol:valC),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line8:23C),COLOR(COLOR:Black)
         STRING(@S2),AT(7542,0,156,156),USE(nol_pvn_proc,,?nol_pvn_procC),RIGHT
         STRING('%'),AT(7698,0,156,156),USE(?String38:9C),LEFT
         LINE,AT(7854,-10,0,176),USE(?Line8:47C),COLOR(COLOR:Black)
         STRING(@s50),AT(417,0,2500,156),USE(nom_nosaukums,,?nom_nosaukums:2),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:31C),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:32C),COLOR(COLOR:Black)
         STRING(@s3),AT(135,0,208,156),USE(RPT_npk,,?RPT_npkC),RIGHT
       END
RPT_FOOT1C DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,115),USE(?Line32C),COLOR(COLOR:Black)
         LINE,AT(365,0,0,115),USE(?Line33C),COLOR(COLOR:Black)
         LINE,AT(2948,0,0,55),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,115),USE(?Line35C),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,115),USE(?Line36C),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,115),USE(?Line37C),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,115),USE(?Line38C),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,115),USE(?Line39C),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,115),USE(?Line40C),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,115),USE(?Line41:2C),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:5C),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,156),USE(?unnamed:8)
         LINE,AT(4010,-10,0,176),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(4063,0,208,156),USE(iepak_dk),RIGHT
         LINE,AT(4271,-10,0,176),USE(?Line8:24),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,176),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,176),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,176),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(6354,0,885,156),USE(sumk_b),RIGHT(1)
         STRING(@s3),AT(7292,0,208,156),USE(PAV:val),LEFT
         STRING(@S15),AT(4792,0,521,156),USE(daudzumsK_S),RIGHT
         LINE,AT(7500,-10,0,176),USE(?Line8:19),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,176),USE(?Line8:49),COLOR(COLOR:Black)
         STRING(@s25),AT(417,0,1771,156),USE(kopa),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177),USE(?unnamed:14)
         LINE,AT(104,0,0,52),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,52),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,52),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,52),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,52),USE(?Line62:3),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:7),COLOR(COLOR:Black)
         STRING(@T1),AT(7521,52),USE(LAI,,?LAI:5),TRN,FONT(,7,,,CHARSET:ANSI)
       END
RPT_ATLAIDE DETAIL,AT(,-10,,219),USE(?unnamed:19)
         STRING('Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu'),AT(156,0,3542,208), |
             USE(?String62),LEFT
         STRING(@n-_10.2),AT(4031,0,625,208),USE(pav:summa_A),RIGHT
         STRING(@s3),AT(4792,0,260,208),USE(pav:val,,?pav:val:7),LEFT
       END
RPT_FOOT32 DETAIL,AT(,,,219),USE(?unnamed:5)
         STRING('Preèu, taras svars :'),AT(156,10,1094,208),USE(?String62:2),LEFT
         STRING(@n_9.2),AT(1302,10,625,208),USE(svars),RIGHT
         STRING('kg.'),AT(1979,10,208,208),USE(?String62:3),LEFT
       END
RPT_FOOT33 DETAIL,AT(,,,219),USE(?unnamed:4)
         STRING('Transporta pakalpojumi :'),AT(156,21,1302,208),USE(?String62:4),LEFT
         STRING(@n-_12.2),AT(6479,21,781,208),USE(pav_T_summa),RIGHT
         STRING(@s3),AT(7292,21,260,208),USE(pav:val,,?pav:val:4),LEFT
       END
RPT_LS DETAIL,AT(,,,250),USE(?unnamed:3)
         STRING('Visas cenas '),AT(156,21,667,208),USE(?String62:23),LEFT
         STRING(' pârrçíinâtas pçc Latvijas Bankas kursa :'),AT(1031,21,2135,208),USE(?String62:8),LEFT
         STRING(@n_12.6),AT(3177,21),USE(lbkurss),RIGHT
         STRING(@s5),AT(4010,21,323,208),USE(VAL_UZSK1,,?String62:24),LEFT
         STRING(@s3),AT(4344,21,260,208),USE(PAV_VAL),LEFT
         STRING(@s5),AT(823,21,208,208),USE(VAL_UZSK1,,?String62:25),LEFT
       END
RPT_ZEM DETAIL,AT(,,,167),USE(?unnamed:26)
         STRING('Akcîzes nodoklis lauksaimniecîbas produkcijas raþotâjam '),AT(146,10,2948,156),USE(?String62:6), |
             LEFT
         STRING(@N5.3),AT(3104,10,333,156),USE(AKCZ),TRN
         STRING(' Ls/litrâ'),AT(3438,10,365,156),USE(?String303),TRN
         STRING(@n-_13.2),AT(6042,0,833,156),USE(sumk_ZEM),RIGHT
         STRING(@s3),AT(6927,0,260,156),USE(pav:val,,?pav:val:2),LEFT
       END
RPT_PVN DETAIL,AT(,,,167),USE(?unnamed)
         STRING('17. Pievienotâs vçrtîbas nodoklis'),AT(156,21,1667,156),USE(?String62:5),LEFT
         STRING(@n-_13.2),AT(6042,0,833,156),USE(sumk_PVN,,?sumk_PVN:2),RIGHT
         STRING(@s3),AT(6927,0,260,156),USE(pav:val,,?pav:val:22),LEFT
         STRING(@s3),AT(5813,0,260,156),USE(LS_),TRN,LEFT
         STRING(@n-_13.2B),AT(4927,0,833,156),USE(LS_PVN),TRN,RIGHT
         STRING(@S2),AT(1875,0,177,156),USE(PAV_PVN),RIGHT
         STRING('%'),AT(2083,0,156,156),USE(?String142),LEFT
       END
RPT_FOOT4 DETAIL,AT(,,,406),USE(?unnamed:2)
         STRING(@s60),AT(156,31,4500,156),USE(pavisam_apmaksai),LEFT
         STRING(@s3),AT(5802,21,260,156),USE(LS_,,?LS_:1),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(6042,21,833,156),USE(sumk_APM),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6927,21,260,156),USE(pav:val,,?pav:val:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_13.2B),AT(4927,21,833,156),USE(LS_SUMMA),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ar vârdiem)'),AT(156,208,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(833,208,7135,208),USE(sumV),LEFT,COLOR(0D3D3D3H)
       END
RPT_FOOT41 DETAIL,AT(,,,281),USE(?unnamed:9)
         STRING('Pârvadâtâjs,a/m,vadîtâjs:'),AT(156,52,1302,208),USE(?String62:9),LEFT
         STRING(@s100),AT(1510,52,6250,208),USE(pav_auto),LEFT
       END
RPT_FOOT5 DETAIL,AT(,,,1354),USE(?unnamed:11)
         LINE,AT(2240,1083,2292,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(5417,1042,2240,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s1),AT(156,1198,156,156),USE(GGK_D_K[8]),LEFT
         STRING(@s5),AT(313,1198,365,156),USE(GGK_BKK[8])
         STRING(@N-_12.2B),AT(677,1198,,156),USE(GGK_SUMMAV[8]),RIGHT
         STRING(@s25),AT(2604,521,1927,208),USE(SYS_PARAKSTS),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,0,7760,0),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(4583,0,0,1354),USE(?Line76),COLOR(COLOR:Black)
         STRING(@s1),AT(156,104,156,156),USE(GGK_D_K[1]),LEFT
         STRING(@s5),AT(313,104,365,156),USE(GGK_BKK[1])
         STRING(@N-_12.2B),AT(677,104,,156),USE(GGK_SUMMAV[1]),RIGHT
         STRING('20. Pieòçma :'),AT(4688,104,781,156),USE(?String62:13),LEFT
         STRING(@s1),AT(156,260,156,156),USE(GGK_D_K[2]),LEFT
         STRING(@s5),AT(313,260,365,156),USE(GGK_BKK[2])
         STRING(@N-_12.2B),AT(677,260,,156),USE(GGK_SUMMAV[2]),RIGHT
         STRING(@s25),AT(2281,271,1729,208),USE(DOKDATUMS,,?DOKDATUMS:2),TRN,CENTER
         LINE,AT(1510,0,0,1354),USE(?Line76:2),COLOR(COLOR:Black)
         STRING('19. Preèu piegâdes vai pakalpojumu sniegðanas datums:'),AT(1667,104,2865,156),USE(?String62:11), |
             LEFT
         STRING('Vârds, uzvârds'),AT(4688,313,885,208),USE(?String62:14),LEFT
         STRING(@s1),AT(156,417,156,156),USE(GGK_D_K[3]),LEFT
         STRING(@s5),AT(313,417,365,156),USE(GGK_BKK[3])
         STRING(@N-_12.2B),AT(677,417,,156),USE(GGK_SUMMAV[3]),RIGHT
         STRING('Vârds, uzvârds'),AT(1688,521,885,208),USE(?String62:12),LEFT
         LINE,AT(5573,469,1875,0),USE(?Line77),COLOR(COLOR:Black)
         STRING(@s1),AT(156,573,156,156),USE(GGK_D_K[4]),LEFT
         STRING(@s5),AT(313,573,365,156),USE(GGK_BKK[4])
         STRING(@N-_12.2B),AT(677,573,,156),USE(GGK_SUMMAV[4]),RIGHT
         STRING('. gada  "'),AT(5104,625,417,208),USE(?String62:17),LEFT
         STRING('"'),AT(5781,625,104,208),USE(?String62:18),LEFT
         STRING(@s1),AT(156,729,156,156),USE(GGK_D_K[5]),LEFT
         STRING(@s5),AT(313,729,365,156),USE(GGK_BKK[5])
         STRING(@N-_12.2B),AT(677,729,,156),USE(GGK_SUMMAV[5]),RIGHT
         LINE,AT(4688,729,365,0),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(5521,729,260,0),USE(?Line78:2),COLOR(COLOR:Black)
         LINE,AT(5885,729,1615,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING(@s1),AT(156,885,156,156),USE(GGK_D_K[6]),LEFT
         STRING(@s5),AT(313,885,365,156),USE(GGK_BKK[6])
         STRING(@N-_12.2B),AT(677,885,,156),USE(GGK_SUMMAV[6]),RIGHT
         STRING('Paraksts'),AT(1719,906,521,208),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(4688,885,521,208),USE(?String62:20),LEFT
         STRING(@s1),AT(156,1042,156,156),USE(GGK_D_K[7]),LEFT
         STRING(@s5),AT(313,1042,365,156),USE(GGK_BKK[7])
         STRING(@N-_12.2B),AT(677,1042,,156),USE(GGK_SUMMAV[7]),RIGHT
       END
RPT_FOOT5:6R DETAIL,AT(,,,1354),USE(?unnamed:13)
         STRING(@s1),AT(156,1198,156,156),USE(GGK_D_K[8],,?GGK_D_K_8R),LEFT
         STRING(@s5),AT(313,1198,365,156),USE(GGK_BKK[8],,?GGK_BKK_8R)
         STRING(@N-_12.2B),AT(677,1198,,156),USE(GGK_SUMMAV[8],,?GGK_SUMMA_8R),RIGHT
         STRING(@s60),AT(2260,1125,4156,177),USE(CODE39_TEXT_2,,?String300),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2271,583,3521,313),USE(CODE39),TRN,LEFT,FONT('Code 3 de 9',20,,FONT:regular,CHARSET:SYMBOL)
         LINE,AT(104,0,7760,0),USE(?Line5:8R),COLOR(COLOR:Black)
         STRING(@s1),AT(156,104,156,156),USE(GGK_D_K[1],,?GGK_D_K_1R),LEFT
         STRING(@s5),AT(313,104,365,156),USE(GGK_BKK[1],,?GGK_BKK_1R)
         STRING(@N-_12.2B),AT(677,104,,156),USE(GGK_SUMMAV[1],,?GGK_SUMMA_1R),RIGHT
         STRING(@s1),AT(156,260,156,156),USE(GGK_D_K[2],,?GGK_D_K_2R),LEFT
         STRING(@s5),AT(313,260,365,156),USE(GGK_BKK[2],,?GGK_BKK_2R)
         STRING(@N-_12.2B),AT(677,260,,156),USE(GGK_SUMMAV[2],,?GGK_SUMMA_2R),RIGHT
         LINE,AT(1510,0,0,1354),USE(?Line76:2R),COLOR(COLOR:Black)
         STRING('19. Preèu piegâdes vai pakalpojumu sniegðanas datums:'),AT(1677,83,4219,208),USE(?CODE39_TEXT), |
             LEFT
         STRING(@s1),AT(156,417,156,156),USE(GGK_D_K[3],,?GGK_D_K_3R),LEFT
         STRING(@s5),AT(313,417,365,156),USE(GGK_BKK[3],,?GGK_BKK_3R)
         STRING(@N-_12.2B),AT(677,417,,156),USE(GGK_SUMMAV[3],,?GGK_SUMMA_3R),RIGHT
         STRING(@s60),AT(1677,927,3885,208),USE(CODE39_TEXT,,?CODE39_TEXT:2),LEFT
         STRING(@s1),AT(156,573,156,156),USE(GGK_D_K[4],,?GGK_D_K_4R),LEFT
         STRING(@s5),AT(313,573,365,156),USE(GGK_BKK[4],,?GGK_BKK_4R)
         STRING(@N-_12.2B),AT(677,573,,156),USE(GGK_SUMMAV[4],,?GGK_SUMMA_4R),RIGHT
         STRING(@s25),AT(2333,292,1729,208),USE(DOKDATUMS,,?DOKDATUMS:6R),CENTER
         STRING(@s1),AT(156,729,156,156),USE(GGK_D_K[5],,?GGK_D_K_5R),LEFT
         STRING(@s5),AT(313,729,365,156),USE(GGK_BKK[5],,?GGK_BKK_5R)
         STRING(@N-_12.2B),AT(677,729,,156),USE(GGK_SUMMAV[5],,?GGK_SUMMA_5R),RIGHT
         STRING(@s1),AT(156,885,156,156),USE(GGK_D_K[6],,?GGK_D_K_6R),LEFT
         STRING(@s5),AT(313,885,365,156),USE(GGK_BKK[6],,?GGK_BKK_6R)
         STRING(@N-_12.2B),AT(677,885,,156),USE(GGK_SUMMAV[6],,?GGK_SUMMA_6R),RIGHT
         STRING(@s1),AT(156,1042,156,156),USE(GGK_D_K[7],,?GGK_D_K_7R),LEFT
         STRING(@s5),AT(313,1042,365,156),USE(GGK_BKK[7],,?GGK_BKK_7R)
         STRING(@N-_12.2B),AT(677,1042,,156),USE(GGK_SUMMAV[7],,?GGK_SUMMA_7R),RIGHT
       END
RPT_FOOT5:6T DETAIL,AT(,,,1354),USE(?unnamed:25)
         STRING('Z. V.'),AT(625,885,521,208),USE(?String62:27T),LEFT
         LINE,AT(2240,979,2292,0),USE(?Line77:5T),COLOR(COLOR:Black)
         STRING(@s25),AT(2875,229,1927,208),USE(sys_paraksts,,?SYS_PARAKSTS:T),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,0,7760,0),USE(?Line5:8T),COLOR(COLOR:Black)
         STRING('19. Tâmi sastâdîja :'),AT(792,229,1146,208),USE(?String62:10T),LEFT
         STRING('Vârds, uzvârds'),AT(1958,229,885,208),USE(?String62:12T),LEFT
         STRING(@s25),AT(4542,781,1750,208),USE(DOKDATUMS,,?DOKDATUMS6R),LEFT
         STRING('Paraksts'),AT(1698,781,521,208),USE(?String62:26T),LEFT
       END
PPR_TXT DETAIL,AT(,,,156)
         STRING(@s132),AT(156,0,7708,156),USE(LINE),LEFT
       END
PAGE_HEAD1:5 DETAIL,AT(,,,302)
         LINE,AT(2188,0,0,313),USE(?Line8T:9),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,313),USE(?Line8T:11),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,313),USE(?Line8T:14),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,313),USE(?Line8T:15),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line8T:41),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,313),USE(?Line8T:18),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,313),USE(?Line8T:20),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line8T:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(406,63,1771,146),USE(?String38T:2),CENTER
         STRING(@s21),AT(2229,63,1615,146),USE(nom_SER,,?NOM_SER:T),CENTER
         STRING('10.Mçrv.'),AT(3865,63,340,146),USE(?String38T:11),LEFT
         STRING('11.Dau.'),AT(4250,63,365,146),USE(?String38T:6),CENTER
         STRING('Cena bez Atl.'),AT(4677,63,729,146),USE(?String38T:10),CENTER
         STRING('12. Cena'),AT(5458,63,729,146),USE(?String38T:7),CENTER
         STRING('13. Summa'),AT(6240,63,1042,146),USE(?String38T:8),CENTER
         STRING('PVN'),AT(7302,63,280,150),USE(?String38T:3),CENTER
         STRING('A%'),AT(7635,63,208,146),USE(?String38T:12),CENTER
         LINE,AT(3854,0,0,323),USE(?Line8T:45),COLOR(COLOR:Black)
         LINE,AT(73,0,0,313),USE(?Line8T:4),COLOR(COLOR:Black)
         LINE,AT(365,0,0,313),USE(?Line8T:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(146,63,188,146),USE(?String38T),CENTER
         LINE,AT(52,250,7813,0),USE(?Line5T:4),COLOR(COLOR:Black)
         LINE,AT(52,0,7813,0),USE(?Line5T:3),COLOR(COLOR:Black)
       END
detail:5 DETAIL,AT(,,,156)
         LINE,AT(2188,-10,0,176),USE(?Line8T:30),COLOR(COLOR:Black)
         STRING(@s21),AT(2219,0,1615,156),USE(nomenk,,?NOMENK:T),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3854,-10,0,176),USE(?Line8T:29),COLOR(COLOR:Black)
         STRING(@s6),AT(3885,0,313,156),USE(nom:mervien,,?NOM:MERVIEN:T),LEFT
         LINE,AT(4219,-10,0,176),USE(?Line8T:25),COLOR(COLOR:Black)
         STRING(@S15),AT(4250,0,365,156),USE(daudzums_S,,?DAUDZUMS_S:T),RIGHT
         LINE,AT(4635,-10,0,176),USE(?Line8T:26),COLOR(COLOR:Black)
         STRING(@S15),AT(4667,0,729,156),USE(cena_A),RIGHT
         LINE,AT(5417,-10,0,176),USE(?Line8T:42),COLOR(COLOR:Black)
         STRING(@S15),AT(5448,0,729,156),USE(cena_S,,?CENA_S:T),RIGHT
         LINE,AT(6198,-10,0,176),USE(?Line8T:27),COLOR(COLOR:Black)
         STRING(@S15),AT(6250,0,781,156),USE(summa_bS,,?SUMMA_BS:T),RIGHT
         STRING(@s3),AT(7063,0,208,156),USE(nol:val,,?NOL:VAL:T),LEFT
         LINE,AT(7292,-10,0,176),USE(?Line8T:23),COLOR(COLOR:Black)
         STRING(@S3),AT(7344,0,208,156),USE(nol_pvn_proc,,?NOL_PVN_PROC:T),RIGHT
         LINE,AT(7604,-10,0,176),USE(?Line8T:38),COLOR(COLOR:Black)
         STRING(@n4.1),AT(7625,0,208,156),USE(NOL:ATLAIDE_PR),RIGHT
         LINE,AT(7854,-10,0,176),USE(?Line8T:28),COLOR(COLOR:Black)
         STRING(@s50),AT(396,0,1771,156),USE(NOM:NOS_P),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8T:31),COLOR(COLOR:Black)
         LINE,AT(73,-10,0,176),USE(?Line8T:32),COLOR(COLOR:Black)
         STRING(@s3),AT(135,0,208,156),USE(RPT_npk,,?RPT_NPK:T),RIGHT
       END
RPT_FOOT1:5 DETAIL,AT(,-10,,94)
         LINE,AT(73,0,0,115),USE(?Line32T),COLOR(COLOR:Black)
         LINE,AT(365,0,0,115),USE(?Line33T),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,115),USE(?Line34T),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,115),USE(?Line35T),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,115),USE(?Line36T),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,115),USE(?Line37T),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,115),USE(?Line38T),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,115),USE(?Line39T),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,115),USE(?Line39T:2),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,115),USE(?Line40T),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,115),USE(?Line41T),COLOR(COLOR:Black)
         LINE,AT(52,52,7813,0),USE(?Line5T:5),COLOR(COLOR:Black)
       END
RPT_FOOT2:5 DETAIL,AT(,,,156)
         LINE,AT(2188,-10,0,176),USE(?Line8T:8),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,176),USE(?Line8T:10),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,176),USE(?Line8T:24),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,176),USE(?Line8T:13),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,176),USE(?Line8T:43),COLOR(COLOR:Black)
         LINE,AT(4635,-10,0,176),USE(?Line8T:16),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,176),USE(?Line8T:17),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(6250,0,781,156),USE(sumk_b,,?SUMK_B:T),RIGHT(1)
         STRING(@s3),AT(7063,0,208,156),USE(PAV:val,,?PAV:VAL:T),LEFT
         STRING(@S15),AT(4250,0,365,156),USE(daudzumsK_S,,?DAUDZUMSK_S:T),RIGHT
         LINE,AT(7292,-10,0,176),USE(?Line8T:19),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,176),USE(?Line8T:22),COLOR(COLOR:Black)
         STRING(@s25),AT(396,0,1771,156),USE(kopa,,?KOPA:T),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8T:6),COLOR(COLOR:Black)
         LINE,AT(73,0,0,176),USE(?Line8T:5),COLOR(COLOR:Black)
       END
RPT_FOOT3:5 DETAIL,AT(,-10,,177),USE(?unnamed:16)
         LINE,AT(73,0,0,52),USE(?Line53T:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54T:2),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,52),USE(?Line55T:2),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,52),USE(?Line56T:2),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line57T:2),COLOR(COLOR:Black)
         LINE,AT(4635,0,0,52),USE(?Line58T:2),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,52),USE(?Line59T:2),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,52),USE(?Line60T:2),COLOR(COLOR:Black)
         LINE,AT(7604,0,0,52),USE(?Line61T:2),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,52),USE(?Line62T:2),COLOR(COLOR:Black)
         LINE,AT(63,52,7813,0),USE(?Line5T:7),COLOR(COLOR:Black)
         STRING(@T1),AT(7542,52),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6198,0,0,52),USE(?Line59T:3),COLOR(COLOR:Black)
       END
PAGE_HEAD1:2 DETAIL,AT(,,,302)
         LINE,AT(2292,0,0,261),USE(?Line82:9),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,313),USE(?Line82:11),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,313),USE(?Line82:14),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,313),USE(?Line82:15),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,313),USE(?Line82:18),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line82:20),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line82:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(396,42,1875,208),USE(?String382:2),CENTER
         STRING(@s21),AT(2323,42,1615,208),USE(nom_SER,,?NOM_SER:2),CENTER
         STRING('Iep'),AT(3990,42,208,208),USE(?String382:4),CENTER
         STRING('10.Mçr.'),AT(4271,42,365,208),USE(?String382:5),CENTER
         STRING('11. Daudz.'),AT(4771,42,625,208),USE(?String382:6),CENTER
         STRING('12. Cena'),AT(5448,42,833,208),USE(?String382:7),CENTER
         STRING('13. Summa'),AT(6333,42,1146,208),USE(?String382:8),CENTER
         STRING('PVN'),AT(7521,42,313,208),USE(?String382:10),CENTER
         LINE,AT(3958,0,0,260),USE(?Line82:3),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line82:4),COLOR(COLOR:Black)
         LINE,AT(365,0,0,313),USE(?Line82:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,42,188,208),USE(?String382),CENTER
         LINE,AT(104,260,7760,0),USE(?Line52:4),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line52:3),COLOR(COLOR:Black)
       END
detail:2 DETAIL,AT(,,,313)
         STRING(@s21),AT(2344,0,1640,156),USE(nomenk,,?NOMENK:2),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_3.0b),AT(3990,0,208,156),USE(nol:iepak_d),RIGHT
         LINE,AT(4219,-10,0,333),USE(?Line82:12),COLOR(COLOR:Black)
         STRING(@s6),AT(4271,0,417,156),USE(nom:mervien,,?NOM:MERVIEN:2),LEFT
         LINE,AT(4688,-10,0,333),USE(?Line82:25),COLOR(COLOR:Black)
         STRING(@S15),AT(4740,0,625,156),USE(daudzums_S,,?DAUDZUMS_S:2),RIGHT
         LINE,AT(5417,-10,0,333),USE(?Line82:26),COLOR(COLOR:Black)
         STRING(@S15),AT(5469,0,781,156),USE(cena_S,,?CENA_S:2),RIGHT
         LINE,AT(6302,-10,0,333),USE(?Line82:27),COLOR(COLOR:Black)
         STRING(@S15),AT(6354,0,833,156),USE(summa_bS,,?SUMMA_BS:2),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(nol:val,,?NOL:VAL:2),LEFT
         LINE,AT(7500,-10,0,333),USE(?Line82:23),COLOR(COLOR:Black)
         STRING(@S2),AT(7531,0,156,156),USE(nol_pvn_proc,,?nol_pvn_proc:2),RIGHT
         STRING('%'),AT(7688,0,156,156),USE(?String382:11),LEFT
         STRING(@s50),AT(417,156,3177,156),USE(nom:RINDA2PZ),LEFT
         LINE,AT(7854,-10,0,333),USE(?Line82:28),COLOR(COLOR:Black)
         STRING(@s30),AT(406,0,1927,156),USE(NOM:NOS_P,,?NOM:NOS_P:2),LEFT
         LINE,AT(365,-10,0,333),USE(?Line82:29),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,333),USE(?Line82:30),COLOR(COLOR:Black)
         STRING(@s3),AT(135,0,208,156),USE(RPT_npk,,?RPT_NPK:2),RIGHT
       END
RPT_FOOT1:2 DETAIL,AT(,,,94),USE(?unnamed:15)
         LINE,AT(104,-10,0,114),USE(?Line322),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,114),USE(?Line332),COLOR(COLOR:Black)
         LINE,AT(2292,52,0,52),USE(?Line342),COLOR(COLOR:Black)
         LINE,AT(3958,52,0,52),USE(?Line352),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,114),USE(?Line362),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,114),USE(?Line372),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,114),USE(?Line382),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,114),USE(?Line392),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,114),USE(?Line402),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,114),USE(?Line412),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line52:5),COLOR(COLOR:Black)
       END
RPT_FOOT2:2 DETAIL,AT(,,,156)
         LINE,AT(2292,-10,0,176),USE(?Line82:8),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,176),USE(?Line82:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(4010,0,156,156),USE(iepak_dk,,?IEPAK_DK:2),RIGHT
         LINE,AT(4219,-10,0,176),USE(?Line82:36),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,176),USE(?Line82:35),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,176),USE(?Line82:34),COLOR(COLOR:Black)
         LINE,AT(6302,-10,0,176),USE(?Line82:31),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6458,0,729,156),USE(sumk_b,,?SUMK_B:2),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(PAV:val,,?PAV:VAL:222),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line82:32),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,176),USE(?Line82:41),COLOR(COLOR:Black)
         STRING(@S15),AT(4740,0,625,156),USE(daudzumsK_S,,?DAUDZUMSK_S:2),RIGHT
         STRING(@s25),AT(469,0,1719,156),USE(kopa,,?KOPA:2),LEFT
         LINE,AT(365,-10,0,176),USE(?Line82:916),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line82:915),COLOR(COLOR:Black)
       END
RPT_FOOT3:2 DETAIL,AT(,-10,,156),USE(?unnamed:17)
         LINE,AT(104,0,0,52),USE(?Line532:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line542:2),COLOR(COLOR:Black)
         LINE,AT(2292,0,0,52),USE(?Line552:2),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,52),USE(?Line562:2),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line572:2),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,52),USE(?Line582:2),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,52),USE(?Line592:2),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,52),USE(?Line602:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line612:2),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,52),USE(?Line622:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line52:7),COLOR(COLOR:Black)
         STRING(@T1),AT(7552,42),USE(LAI,,?LAI:2),TRN,FONT(,7,,,CHARSET:ANSI)
       END
PAGE_HEAD1:3 DETAIL,AT(,,,302)
         LINE,AT(2292,0,0,313),USE(?Line84:9),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,313),USE(?Line84:11),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,313),USE(?Line84:14),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,313),USE(?Line84:15),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,313),USE(?Line84:18),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,313),USE(?Line84:20),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line84:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(448,63,1823,146),USE(?String384:15),CENTER
         STRING(@s21),AT(2323,63,1615,146),USE(nom_SER,,?nom_SER:3),CENTER
         STRING('Iep'),AT(3990,63,208,146),USE(?String384:14),CENTER
         STRING('10. Mçrv.'),AT(4250,63,417,146),USE(?String384:13),CENTER
         STRING('11.Daudz.'),AT(4740,63,469,146),USE(?String384:12),CENTER
         STRING('12. Cena'),AT(5344,63,677,146),USE(?String384:11),CENTER
         STRING('13. Summa'),AT(6146,63,938,146),USE(?String384:8),CENTER
         STRING('Cena ar PVN'),AT(7156,63,677,146),USE(?String384:10),CENTER
         LINE,AT(3958,0,0,313),USE(?Line84:3),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line84:4),COLOR(COLOR:Black)
         LINE,AT(417,0,0,313),USE(?Line84:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,63,188,146),USE(?String384),CENTER
         LINE,AT(104,250,7760,0),USE(?Line54:4),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line54:3),COLOR(COLOR:Black)
       END
detail:3 DETAIL,AT(,,,156)
         LINE,AT(2292,-10,0,176),USE(?Line84:30),COLOR(COLOR:Black)
         STRING(@s21),AT(2344,0,1615,156),USE(nomenk,,?NOMENK:4),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,-10,0,176),USE(?Line84:29),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(4010,0,156,156),USE(nol:iepak_d,,?NOL:IEPAKD:4),RIGHT
         LINE,AT(4219,-10,0,176),USE(?Line84:12),COLOR(COLOR:Black)
         STRING(@s6),AT(4271,0,417,156),USE(nom:mervien,,?NOM:MERVIEN:4),LEFT
         LINE,AT(4688,-10,0,176),USE(?Line84:25),COLOR(COLOR:Black)
         STRING(@S15),AT(4740,0,469,156),USE(daudzums_S,,?DAUDZUMS_S:4),RIGHT
         LINE,AT(5260,-10,0,176),USE(?Line84:26),COLOR(COLOR:Black)
         STRING(@S15),AT(5313,0,677,156),USE(cena_S,,?CENA_S:4),RIGHT
         LINE,AT(6042,-10,0,176),USE(?Line84:27),COLOR(COLOR:Black)
         STRING(@s3),AT(6875,0,260,156),USE(nol:val,,?NOL:VAL:4),LEFT
         STRING(@S15),AT(6094,0,729,156),USE(summa_bS,,?summa_bS:4),RIGHT
         LINE,AT(7854,-10,0,176),USE(?Line84:23),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,176),USE(?Line84:28),COLOR(COLOR:Black)
         STRING(@S15),AT(7188,0,625,156),USE(CenaArPVN_S),RIGHT
         STRING(@s30),AT(448,0,1823,156),USE(NOM:NOS_P,,?NOM:NOS_P:4),LEFT
         LINE,AT(417,-10,0,176),USE(?Line84:31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line84:32),COLOR(COLOR:Black)
         STRING(@s3),AT(188,0,208,156),USE(RPT_npk,,?RPT_NPK:4),RIGHT
       END
RPT_FOOT1:3 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,114),USE(?Line324),COLOR(COLOR:Black)
         LINE,AT(417,0,0,114),USE(?Line334),COLOR(COLOR:Black)
         LINE,AT(2292,0,0,114),USE(?Line344),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,114),USE(?Line354),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,114),USE(?Line364),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,114),USE(?Line374),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,114),USE(?Line384),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,114),USE(?Line394),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,114),USE(?Line414),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,114),USE(?Line394:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line54:5),COLOR(COLOR:Black)
       END
RPT_FOOT2:3 DETAIL,AT(,,,156)
         LINE,AT(2292,-10,0,176),USE(?Line84:8),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,176),USE(?Line84:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(4010,0,156,156),USE(iepak_dk,,?IEPAK_DK:4),RIGHT
         LINE,AT(4219,-10,0,176),USE(?Line84:24),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,176),USE(?Line84:13),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,176),USE(?Line84:16),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,176),USE(?Line84:17),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6094,0,729,156),USE(sumk_b,,SUMK_B:4),RIGHT
         STRING(@s3),AT(6875,0,260,156),USE(PAV:val,,?PAV:VAL:44),LEFT
         STRING(@S15),AT(4708,0,521,156),USE(daudzumsK_S,,?DAUDZUMSK_S:4),RIGHT
         LINE,AT(7135,-10,0,176),USE(?Line84:19),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,176),USE(?Line84:22),COLOR(COLOR:Black)
         STRING(@s25),AT(521,0,1719,156),USE(kopa,,?KOPA:4),LEFT
         LINE,AT(417,-10,0,176),USE(?Line84:6),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line84:5),COLOR(COLOR:Black)
       END
RPT_FOOT3:3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line534:2),COLOR(COLOR:Black)
         LINE,AT(417,0,0,52),USE(?Line544:2),COLOR(COLOR:Black)
         LINE,AT(2292,0,0,52),USE(?Line554:2),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,52),USE(?Line564:2),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line574:2),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,52),USE(?Line584:2),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,52),USE(?Line594:2),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,52),USE(?Line604:2),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,52),USE(?Line614:2),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,52),USE(?Line624:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line54:7),COLOR(COLOR:Black)
         STRING(@T1),AT(7531,42),USE(LAI,,?LAI:3),TRN,FONT(,7,,,CHARSET:ANSI)
       END
PAGE_HEAD1:4 DETAIL,AT(,,,302)
         LINE,AT(3385,0,0,313),USE(?Line85:11),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,313),USE(?Line85:28),COLOR(COLOR:Black)
         LINE,AT(5208,0,0,313),USE(?Line85:15),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,313),USE(?Line85:8),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line85:20),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,313),USE(?Line85:21),COLOR(COLOR:Black)
         STRING(@s30),AT(396,63,2917,146),USE(PRECUNOSAUKUMS_TEXT,,?PRECUNOSAUKUMS_TEXT:4),CENTER
         STRING('Iep'),AT(3417,63,260,146),USE(?String385:4),CENTER
         STRING('10. Mçrv.'),AT(3729,63,469,146),USE(?String385:5),CENTER
         STRING('11. Daudzums'),AT(4250,63,938,146),USE(?String385:6),CENTER
         STRING('12. Cena'),AT(5240,63,938,146),USE(?String385:7),CENTER
         STRING('13. Summa'),AT(6229,63,1250,146),USE(?String385:8),CENTER
         STRING('PVN'),AT(7531,63,313,146),USE(?String385:10),CENTER
         LINE,AT(3698,-10,0,313),USE(?Line85:33),COLOR(COLOR:Black)
         LINE,AT(104,0,0,313),USE(?Line85:4),COLOR(COLOR:Black)
         LINE,AT(365,0,0,313),USE(?Line85:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(146,63,188,146),USE(?String385),CENTER
         LINE,AT(104,250,7760,0),USE(?Line55:6),COLOR(COLOR:Black)
         LINE,AT(104,0,7760,0),USE(?Line55:3),COLOR(COLOR:Black)
       END
detail:4 DETAIL,AT(,,,156)
         LINE,AT(3385,-10,0,176),USE(?Line85:29),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(3438,0,208,156),USE(nol:iepak_d,,?NOL:IEPAKD:5),RIGHT
         LINE,AT(3698,-10,0,176),USE(?Line85:12),COLOR(COLOR:Black)
         STRING(@s6),AT(3750,0,417,156),USE(nom:mervien,,?NOM:MERVIEN:5),LEFT
         LINE,AT(4219,-10,0,176),USE(?Line85:25),COLOR(COLOR:Black)
         STRING(@s15),AT(4271,0,885,156),USE(daudzums_s,,?DAUDZUMS_S:5),RIGHT
         LINE,AT(5208,-10,0,176),USE(?Line85:18),COLOR(COLOR:Black)
         STRING(@s15),AT(5260,0,885,156),USE(cena_s,,?CENA_S:5),RIGHT
         LINE,AT(6198,-10,0,176),USE(?Line85:9),COLOR(COLOR:Black)
         STRING(@s15),AT(6250,0,938,156),USE(summa_bs,,?SUMMA_BS:5),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(nol:val,,?NOL:VAL:5),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line85:23),COLOR(COLOR:Black)
         STRING(@S2),AT(7542,0,156,156),USE(nol_pvn_proc,,?NOL_PVN_PROC:5),RIGHT
         STRING('%'),AT(7698,0,156,156),USE(?String385:9),LEFT
         LINE,AT(7854,-10,0,176),USE(?Line85:26),COLOR(COLOR:Black)
         STRING(@s50),AT(417,0,2917,156),USE(nom_nosaukums,,?nom_nosaukums:4),LEFT
         LINE,AT(365,-10,0,176),USE(?Line85:31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line85:32),COLOR(COLOR:Black)
         STRING(@s3),AT(135,0,208,156),USE(RPT_npk,,?RPT_NPK:5),RIGHT
       END
RPT_FOOT1:4 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,104),USE(?Line325),COLOR(COLOR:Black)
         LINE,AT(365,0,0,104),USE(?Line335),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,104),USE(?Line355),COLOR(COLOR:Black)
         LINE,AT(3698,0,0,104),USE(?Line365),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,104),USE(?Line375),COLOR(COLOR:Black)
         LINE,AT(5208,0,0,104),USE(?Line385),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,104),USE(?Line395),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,104),USE(?Line405),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,104),USE(?Line415),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line55:5),COLOR(COLOR:Black)
       END
RPT_FOOT2:4 DETAIL,AT(,,,156)
         LINE,AT(3385,-10,0,176),USE(?Line85:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(3438,0,208,156),USE(iepak_dk,,?IEPAK_DK:5),RIGHT
         LINE,AT(3698,-10,0,176),USE(?Line85:24),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,176),USE(?Line85:13),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,176),USE(?Line85:16),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,176),USE(?Line85:17),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6458,0,729,156),USE(sumk_b,,?SUMK_B:5),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(PAV:val,,?PAV:VAL:55),LEFT
         STRING(@s15),AT(4250,0,938,156),USE(daudzumsK_s,,?DAUDZUMSK_S:5),RIGHT
         LINE,AT(7500,-10,0,176),USE(?Line85:19),COLOR(COLOR:Black)
         LINE,AT(7854,-10,0,176),USE(?Line85:22),COLOR(COLOR:Black)
         STRING(@s25),AT(469,0,2448,156),USE(kopa,,?KOPA:5),LEFT
         LINE,AT(365,-10,0,176),USE(?Line85:6),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line85:5),COLOR(COLOR:Black)
       END
RPT_FOOT3:4 DETAIL,AT(,-10,,177),USE(?unnamed:18)
         LINE,AT(104,0,0,52),USE(?Line535:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line545:2),COLOR(COLOR:Black)
         LINE,AT(3385,0,0,52),USE(?Line565:2),COLOR(COLOR:Black)
         LINE,AT(3698,0,0,52),USE(?Line575:2),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,52),USE(?Line585:2),COLOR(COLOR:Black)
         LINE,AT(5208,0,0,52),USE(?Line595:2),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,52),USE(?Line605:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line615:2),COLOR(COLOR:Black)
         LINE,AT(7854,0,0,52),USE(?Line625:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line55:7),COLOR(COLOR:Black)
         STRING(@T1),AT(7521,63),USE(LAI,,?LAI:4),TRN,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,11335,8000,104),USE(?unnamed:23)
         LINE,AT(6875,0,1042,0),USE(?Line323),COLOR(COLOR:Black)
         STRING('ISF Assako'),AT(7458,0,,100),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
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

KESKA_SCREEN WINDOW(' '),AT(,,145,108),FONT('Microsoft Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       OPTION('Nosaukums'),AT(4,12,140,71),USE(RKT),BOXED
         RADIO('RÇÍINS-FAKTÛRA'),AT(7,25),USE(?RKT:Radio1),VALUE('R')
         RADIO('RÇÍINS-FAKTÛRA ar klienta parakstu'),AT(7,35),USE(?RKT:Radio2),VALUE('K')
         RADIO('TÂME-PIEDÂVÂJUMS'),AT(7,45),USE(?RKT:Radio3),VALUE('T')
         RADIO('PRIEKÐAPMAKSAS RÇÍINS'),AT(7,55),USE(?RKT:Radio4),VALUE('P')
         RADIO('RÇÍINS-FAKTÛRA ar atlaides %'),AT(7,66),USE(?RKT:Radio5),VALUE('A')
       END
       BUTTON('Drukât svîtru parakstu'),AT(5,86,79,14),USE(?Button:MAKARONI),DISABLE
       IMAGE('CHECK3.ICO'),AT(85,84,15,20),USE(?Image:MAKARONI),HIDE
       BUTTON('OK'),AT(108,86,35,14),USE(?Ok:KESKA),DEFAULT
     END
  CODE                                            ! Begin processed code
! OPCIJA_NR:
!   1-8 P/Z
!   6-  RF
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  IF INRANGE(PAV:PAR_NR,1,50) !IEKÐÇJÂ
     PAR_NOS_P   ='tas pats,'&GETPAR_K(PAV:PAR_NR,2,2)
  ELSE
     PAR_NOS_P   =GETPAR_K(PAV:PAR_NR,2,2)
     IF PAR:NMR_PLUS     !ÍÎPSALAI 12.03.08
        PAR_NOS_P=CLIP(PAR_NOS_P)&' ('&CLIP(PAR:U_NR)&')'
     .
  .
  IF PAV:D_K='K' AND GETPAR_ATZIME(PAR:ATZIME1,2)='2' !AIZLIEGTS PARTNERIS
     KLUDA(68,CLIP(PAR:NOS_S)&'-'&ATZ:TEKSTS)
     DO PROCEDURERETURN
  ELSIF PAV:D_K='K' AND GETPAR_ATZIME(PAR:ATZIME2,2)='2' !AIZLIEGTS PARTNERIS
     KLUDA(68,CLIP(PAR:NOS_S)&'-'&ATZ:TEKSTS)
     DO PROCEDURERETURN
  .

  SYS_BAITS=SYS:BAITS  !MAKARONU PARAKSTS

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)

  IF PAV:D_K='D' AND PAV:SUMMA<0   !MÇS ATGRIEÞAM PRECI
     SIGN#=-1
     ATGRIEZTA='Preèu atgrieðana'
  ELSIF INSTRING(PAV:D_K,'KPR')
     SIGN#=1
  ELSE
     KLUDA(0,'...atïauts tikai K,P,R vai -D, drukâju izziòu')
     SIGN#=1
     IZZINA=TRUE
  .
  DOKDATUMS=GETDOKDATUMS(PAV:DATUMS)
  LAI=CLOCK()

!Elya 28.08.2013 <
!  IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z PARÂDAM Ls
!     LBKURSS=BANKURS(PAV:VAL,PAV:DATUMS,1)
!     LS_='Ls'
!     PAV_VAL=PAV:VAL
!  ELSIF EUR_P
!     LBKURSS=0.702804
!     LS_='EUR'
!     PAV_VAL='EUR'
!  .
  !04022014 IF PAV:DATUMS >= date(01,01,2014)
  IF val_uzsk = 'EUR'
     IF ~(PAV:VAL='EUR')     ! VALÛTAS P/Z PARÂDAM Ls
        LBKURSS=BANKURS(PAV:VAL,PAV:DATUMS,1)
        LS_='EUR'
        PAV_VAL=PAV:VAL
     ELSIF EUR_P
        LBKURSS=1.4228718
        LS_='Ls'
        PAV_VAL='Ls'
     .
     VAL_UZSK1 = 'EUR /'
  ELSE
     IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z PARÂDAM Ls
        LBKURSS=BANKURS(PAV:VAL,PAV:DATUMS,1)
        LS_='Ls'
        PAV_VAL=PAV:VAL
     ELSIF EUR_P
        LBKURSS=0.702804
        LS_='EUR'
        PAV_VAL='EUR'
     .
     VAL_UZSK1 = 'Ls  /'
  .
  !Elya 28.08.2013 >

  KESKA = DOKDATUMS
!  PVNMASMODE=0 !0=12% 1=22%
  IF IZZINA=FALSE   !AIZPILDAM SAVUS UN KLIENTA REKVIZÎTUS
     GETMYBANK('') !BANKA=BAN:NOS_P BKODS=BAN:KODS BSPEC=BAN:SPEC BINDEX=BAN:INDEX REK=GL:REK[SYS:NOKL_B] KOR=GL:KOR[SYS:NOKL_B]

     IF OPCIJA_NR=10 OR OPCIJA_NR=11 !PIESPIEDU IEKÐÇJÂ
          CONS1 = 'Apmaksa nav paredzçta'
     ELSE
        IF INSTRING(PAV:APM_K,'12')
           EXECUTE PAV:APM_V
             CONS1 = 'Priekðapmaksa'
             CONS1 = 'Pçcapmaksa'
             CONS1 = 'pçc realizâcijas' !bij. konsignâcija
             CONS1 = 'Apmaksa uzreiz'
             CONS1 = 'Apmaksa nav paredzçta'
           .
        .
        IF INSTRING(PAV:APM_V,'1234')
           EXECUTE PAV:APM_K
             CONS = 'Pârskaitîjums'
             CONS = 'Skaidrâ naudâ'
             CONS = 'Barters'
             CONS = 'Garantija'
             CONS = 'Rûpn.garantija'
           .
        .
     .

     pav_c_datums=pav:c_datums
     IF pav_c_datums THEN LIDZ='lîdz'.
     RPT_CLIENT=CLIENT
     IF ~(OPCIJA_NR=6 OR OPCIJA_NR=9)   !~RÇÍINS
        STRINGSDA='Saimn. dar. apraksts'
        IF INRANGE(PAV:PAR_NR,1,50) OR OPCIJA_NR=10 OR OPCIJA_NR=11 ! VAI PIESPIEDU IEKÐÇJÂ
           RPT_CLIENT=CLIP(CLIENT)&','&SYS:AVOTS
           SDA='Iekðçjâ preèu pârvietoðana'
           pav_c_datums=0
        ELSIF INSTRING(PAV:APM_V,'35')
           SDA='Izsniegðana citam nodokïu maksâtâjam'
           pav_c_datums=0
        ELSE
           SDA='Preèu piegâde(pârdoðana)/ Pakalpojumu sniegðana'
        .
     .
     IF CHECKSERVISS(PAV:U_NR,PAV:VED_NR)    !IR ATRASTS IERAKSTS SERVISÂ
        PAV_PAMAT=PAV:PAMAT
        SPEC_ATZ=GETAUTO(PAV:VED_NR,8)       !MARKA
        IF AUT:VIRSB_NR THEN SPEC_ATZ=CLIP(SPEC_ATZ)&' Ðas.N '&CLIP(AUT:VIRSB_NR).
        IF GETAUTOAPK(PAV:U_NR,2) THEN SPEC_ATZ=CLIP(SPEC_ATZ)&' Nobr. '&CLIP(GETAUTOAPK(PAV:U_NR,2)).
     ELSE
        PAV_PAMAT=PAV:PAMAT
        IF OPCIJA_NR=6 OR OPCIJA_NR=9        !RÇÍINS
           SPEC_ATZ =GETAUTO(PAV:VED_NR,8)   !MARKA
        ELSE
           SPEC_ATZ =SYS:ATLAUJA
           IF PAV:REK_NR
              SPEC_ATZ=CLIP(SPEC_ATZ)&' Rçíins Nr '&clip(pav:rek_nr)
           .
        .
     .
     PAV_AUTO=CLIP(GETAUTO(PAV:VED_NR,4))  !VISS, KAS VAJADZÎGS P/Z "PARVADATAJS.. "
     IF ~PAV_AUTO OR|
        CL_NR=1694 !WILLENBROCK
        PAV_AUTO='Saòçmçja transports'
     .
     JUADRESE=GL:ADRESE
     FADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
     GOV_REG='NMR: '&gl:reg_nr
     IF gl:VID_NR THEN GOV_REG=CLIP(GOV_REG)&' PVN: '&gl:VID_NR.

     PAR_gov_reg =GETPAR_K(PAV:PAR_NR,0,21)
     PAR_JUADRESE=PAR:ADRESE
     PAR_FADRESE = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
   !--------------------
     IF CL_NR=1304 !EZERKAULIÒI
        IF PAR:GRUPA[1:2]='VP'
           IF INRANGE(PAR:GRUPA[3],1,5)
              NOKL_CP=PAR:GRUPA[3]
           ELSE
              KLUDA(0,'Nav definçta cenu grupa '&CLIP(PAR:NOS_S))
           .
           PAV:MAK_NR=253
        ELSIF PAR:GRUPA[1:4]='MEGO'
           NOKL_CP=4
           PAV:MAK_NR=523
        .
     .
   !--------------------
     IF F:PAK = '2'   !F:PAK NO SELPZ
       par_BAN_kods=par:ban_kods2
       par_ban_nr=par:ban_nr2
     ELSE
       par_BAN_kods=par:ban_kods
       par_ban_nr=par:ban_nr
     .
     par_banka=Getbankas_k(PAR_BAN_KODS,2,1)
     SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  ELSE !D-PAVADZÎME,DRUKÂJAM SPRAVKU
     RPT_CLIENT=GETPAR_K(PAV:PAR_NR,2,2)
     BANKA=''
     REK=''
     BKODS=''
     PAR_NOS_P=CLIENT
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 5
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'pavadzîme'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      PAV:SUMMA=PAV:SUMMA*SIGN#
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR = PAV:U_NR'
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

      IF IZZINA=FALSE
         IF F:IDP='A' OR OPCIJA_NR=6 OR INRANGE(OPCIJA_NR,9,11) OR INRANGE(PAV:PAR_NR,1,50) !DRUKÂT PPR,RÇÍINU,REKKOKIEM,PIESPIEDU IePZ,IePZ UZ A4 LAPAS
            IF OPCIJA_NR=6 OR OPCIJA_NR=9
                VARDS=CLIP(INIGEN(PAV:NOKA,15,1))&' '&CLIP(PAV:REK_NR)
                Report{Prop:Text} = CLIP(VARDS)&'XXXX'
                IF PAV:APM_V='1' !PRIEKÐAPMAKSA
                   RKT = 'P' !PRIEKÐ.RÇÍINS
                ELSE
                   RKT = 'R' !RÇÍINS-FAKTÛRA
                .
                OPEN(KESKA_SCREEN)
                IF INSTRING(RKT,'RA') !TIKAI RÇÍINS-FAKTÛRA,RF AR A%
                   ENABLE(?BUTTON:MAKARONI)
                   IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
                      UNHIDE(?Image:Makaroni)
                   .
                .
                DISPLAY
                ACCEPT
                   CASE FIELD()
                   OF ?RKT
                     IF EVENT()=EVENT:ACCEPTED
                        IF INSTRING(RKT,'RA')
                           ENABLE(?BUTTON:MAKARONI)
                           IF BAND(SYS_BAITS,00000001B)
                              UNHIDE(?Image:Makaroni)
                           ELSE
                              HIDE(?Image:Makaroni)
                           .
                        ELSE
                           DISABLE(?BUTTON:MAKARONI)
                           HIDE(?Image:Makaroni)
                        .
                     .
                   OF ?Button:MAKARONI  !SVÎTRU PARAKSTS, ...NEIZMANTOJAM GLOBAL
                     CASE EVENT()
                     OF EVENT:Accepted
                        IF BAND(SYS_BAITS,00000001B)
                           SYS_BAITS-=1
                           HIDE(?Image:Makaroni)
                        ELSE
                           SYS_BAITS+=1
                           UNHIDE(?Image:Makaroni)
                        .
                        display()
                     .
                   OF ?OK:KESKA
                      IF EVENT()=EVENT:ACCEPTED
                         BREAK
                      .
                   .
                .
                CLOSE(KESKA_SCREEN)
                IF INSTRING(RKT,'RKA',1) !R,RarKl.PARAKSTU,RarA%
                   PAVADZIME='RÇÍINS-FAKTÛRA'
                ELSIF RKT='P'
                   PAVADZIME='PRIEKÐAPMAKSAS RÇÍINS'
                ELSE
                   PAVADZIME='TÂME-PIEDÂVÂJUMS'
                .
                pavadzime = CLIP(pavadzime)&' Nr '&PAV:REK_NR
            ELSE
                VARDS=CLIP(INIGEN(PAV:NOKA,15,1))&' PZ:'&CLIP(PAV:DOK_SENR)
                Report{Prop:Text} = CLIP(VARDS)&'XXXX'
                pavadzime='pavadzîme '&CLIP(PAV:dok_senr)
                IF CL_NR = 1860
                   pavadzime=''
                   pavadzime='pavadzîme-rçíins '&CLIP(PAV:dok_senr)
                .
            .
            SETTARGET(REPORT)
            IMAGE(188,281,2083,521,'USER.BMP')
            IF INRANGE(PAV:PAR_NR,1,50) !IEKÐÇJÂ
               DOK_SENR=PAV:U_NR
            ELSE
               DOK_SENR=''
            .
            PRINT(RPT:DETAILA4)
         ELSE     !DRUKÂT UZ VEIDLAPAS
            DOK_SENR=CLIP(PAV:dok_senr)
            pavadzime=''
            PRINT(RPT:DETAIL0)
         .
      ELSE
         pavadzime='izziòa '&CLIP(PAV:dok_senr)
         PRINT(RPT:DETAILA4)
      .
      IF INRANGE(OPCIJA_NR,7,9) !KOKMATERIÂLI
         PRECUNOSAUKUMS_TEXT='09. Kokmateriâlu nosaukums'
      ELSE
         PRECUNOSAUKUMS_TEXT='09. Preèu nosaukums'
      .
      IF PAV:MAK_NR
         IF ~SPEC_ATZ
            SPEC_ATZ='Maksâtâjs: '&GETPAR_K(PAV:MAK_NR,0,2)
            TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1) !1.RINDIÒU IETÛCAM HEADERÎ
            TEX_S#=2
         ELSE
            TEXTEKSTS='Maksâtâjs: '&GETPAR_K(PAV:MAK_NR,0,2)
            TEX_S#=1
         .
      ELSE
         IF ~SPEC_ATZ
            SPEC_ATZ=GETTEX(PAV:TEKSTS_NR,1)  !1.RINDIÒU IETÛCAM HEADERÎ
            TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,2) !2.RINDIÒU IETÛCAM HEADERÎ
            TEX_S#=3
         ELSE
            TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1) !1.RINDIÒU IETÛCAM HEADERÎ
            TEX_S#=2
         .
      .
      PRINT(RPT:PAGE_HEAD)
      LOOP I#=TEX_S# TO 3
         TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,I#)
         IF TEXTEKSTS
            PRINT(RPT:TEKSTS)
         .
      .
      EXECUTE OPCIJA_NR
         BEGIN
            IF sys:nom_cit = 'K' !KODS
               PRINT(RPT:PAGE_HEAD1C)
            ELSE
               PRINT(RPT:PAGE_HEAD1)
            .
         .
         PRINT(RPT:PAGE_HEAD1:5)  !2  AR ATLAIDES %
         PRINT(RPT:PAGE_HEAD1:2)  !3  2 RINDAS
         PRINT(RPT:PAGE_HEAD1:3)  !4  CENA AR PVN
         PRINT(RPT:PAGE_HEAD1:4)  !5  GARAIS NOSAUKUMS
         BEGIN
            IF RKT='A'
               PRINT(RPT:PAGE_HEAD1:5) !6  RÇÍINS AR ATLAIDES %
            ELSE
               PRINT(RPT:PAGE_HEAD1) !6  RÇÍINS
            .
         .
         PRINT(RPT:PAGE_HEAD1)    !7  KOKI MAZUMÂ
         PRINT(RPT:PAGE_HEAD1:4)  !8  KOKI VAIRUMÂ
         PRINT(RPT:PAGE_HEAD1:4)  !9  RÇÍINS KOKIEM
         BEGIN                    !10 PIESPIEDU IEKÐÇJÂ
            IF sys:nom_cit = 'K' !KODS
               PRINT(RPT:PAGE_HEAD1C)
            ELSE
               PRINT(RPT:PAGE_HEAD1)
            .
         .
         PRINT(RPT:PAGE_HEAD1:2)  !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          BEGIN    !12 cena pec noklusejuma cenas
            IF sys:nom_cit = 'K' !KODS
               PRINT(RPT:PAGE_HEAD1C)
            ELSE
               PRINT(RPT:PAGE_HEAD1)
            .
         .
     .
      !stop('10_PVNMASMODE'&PVNMASMODE)

      fillpvn(0)
       !stop('20_PVNMASMODE'&PVNMASMODE)
   OF Event:Timer
      IF ~(NOL:U_NR=PAV:U_NR) THEN BREAK. !PÂRTRAUCAM ACCEPT
      LOOP RecordsPerCycle TIMES
        NOL:DAUDZUMS=NOL:DAUDZUMS*SIGN#
        NOL:SUMMA=NOL:SUMMA*SIGN#
        NOL:SUMMAV=NOL:SUMMAV*SIGN#
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,ret)
        IF CL_NR=1237 AND GETAUTOAPK(PAV:U_NR,2) AND NOL:IEPAK_D>0 !GAG SERVISS
           NOM_NOSAUKUMS=CLIP(NOM:NOS_P)&' '&CLIP(NOL:IEPAK_D)&' gab.'
           NOL_IEPAK_D=0
         ELSIF (CL_NR=1344 OR CL_NR=1334 OR CL_NR=1493) AND NOM:KATALOGA_NR !ONDULATS & BÛVE &Rîgas Bûvmater.
           NOM_NOSAUKUMS=CLIP(NOM:KATALOGA_NR)&' '&CLIP(NOM:NOS_P)
         ELSE
           NOM_NOSAUKUMS=NOM:NOS_P
           NOL_IEPAK_D=NOL:IEPAK_D
        .
        SVARS+=GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums
       !stop('11_PVNMASMODE'&PVNMASMODE)
       fillpvn(1)
             !stop('21_PVNMASMODE'&PVNMASMODE)

        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
        IF NOL:NOMENKLAT[1:8]='DDZZ2010'
           ZEMNIEKS#=TRUE
           DAUDZUMSZ+=DAUDZUMS
           AKCZ=0.223
        ELSIF NOL:NOMENKLAT[1:8]='DDZZ2011'
           ZEMNIEKS#=TRUE
           DAUDZUMSZ1+=DAUDZUMS
           AKCZ=0.234
        .
        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
          cenaa= calcsum(11,5)    !cena,neòemot vçrâ atlaidi
          CENAarPVN= calcsum(4,3) !CENA AR PVN
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)   !REAL/
          cenaa= ROUND(calcsum(11,1)/nol:daudzums,.00001)
          CENAarPVN= ROUND(calcsum(4,1)/NOL:DAUDZUMS,.001)
        .
!------------------
        IF (~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.03,0.03) AND CL_NR=1304) | !EZERKAULINI-DÂRZEÒU LOÌISTIKA
        OR (~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01) AND CL_NR=1312)   !CABEL
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
!        ELSIF CL_NR=1302 OR CL_NR=1033 !PERMALAT, SAIMNIEKS
        ELSIF F:NOA[1]='J' !NOAPAÏOT CENU
           CENA = ROUND(CENA,.01)
        ELSIF F:NOA[1]='3' !NOAPAÏOT CENU 3zîmes
           CENA = ROUND(CENA,.001)
        .
!------------------
        CENA_S     = CUT0(CENA,5,2)      !STRINGS UZ PPR
!        IF CL_NR = 1502
!            cena = ROUND(NOL:CITAS/100,.00001)
!            CENA_S     = CUT0(cena,5,2) !Elya 17/09/2012
!        END
        IF OPCIJA_NR = 12
            cena = ROUND(GETNOM_K(NOL:NOMENKLAT,2,7),.00001)
            CENA_S     = CUT0(cena,5,2) !Elya 31/01/2014
        END
        CENA_A     = CUT0(CENAA,5,2)     !CENA,NEÒEMOT VÇRÂ ATLAIDI
        CENAARPVN_S= CUT0(CENAARPVN,3,2) !CENA AR PVN
        SUMMA_B = calcsum(3,4)
        !STOP('pvn21_SUMMA_B'&SUMMA_B)
        SUMMA_BS = CUT0(SUMMA_B,4,2)
        IF SUMMA_BS[15]='0'
           SUMMA_BS[15]=CHR(32)
           IF SUMMA_BS[14]='0'
              SUMMA_BS[14]=CHR(32)
           END
        END
        SUMK_X+=SUMMA_B
        iepak_DK  += nol_iepak_d
        DAUDZUMSK += DAUDZUMS
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        IF BAND(NOL:BAITS,00000010b) !NEAPLIEKAMS  *
           nol_pvn_proc='-'                        !*
        ELSE                                       !*
           nol_pvn_proc=NOL:PVN_PROC               !*
        .                                          !*
        EXECUTE OPCIJA_NR
           BEGIN                 !1
              IF sys:nom_cit = 'K'
                 PRINT(RPT:DETAILC)
              ELSE
                 PRINT(RPT:DETAIL)
              .
           .
           PRINT(RPT:DETAIL:5)
           PRINT(RPT:DETAIL:2)
           PRINT(RPT:DETAIL:3)
           PRINT(RPT:DETAIL:4)
           BEGIN
              IF RKT='A'
                 PRINT(RPT:DETAIL:5)     !6 AR A%
              ELSE
                 PRINT(RPT:DETAIL)     !6
              .
           .
           PRINT(RPT:DETAIL)     !7
           PRINT(RPT:DETAIL:4)   !8
           PRINT(RPT:DETAIL:4)   !9
           BEGIN                 !10 PIESPIEDU IEKÐÇJÂ
              IF sys:nom_cit = 'K'
                 PRINT(RPT:DETAILC)
              ELSE
                 PRINT(RPT:DETAIL)
              .
           .
           PRINT(RPT:DETAIL:2)   !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
            BEGIN                 !12
              IF sys:nom_cit = 'K'
                 PRINT(RPT:DETAILC)
              ELSE
                 PRINT(RPT:DETAIL)
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
      END !LOOP RECORDSPERCYCLE
      IF LocalResponse = RequestCompleted
        POST(Event:CloseWindow) !DÇÏ TÂ EKRÂNA PA VIDU, ÐITAIS NESTRÂDÂ
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
  CLOSE(ProgressWindow)
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
    EXECUTE OPCIJA_NR
       BEGIN                   !1
          IF sys:nom_cit = 'K'
             PRINT(RPT:RPT_FOOT1C)
          ELSE
             PRINT(RPT:RPT_FOOT1)
          .
       .
       PRINT(RPT:RPT_FOOT1:5)
       PRINT(RPT:RPT_FOOT1:2)
       PRINT(RPT:RPT_FOOT1:3)
       PRINT(RPT:RPT_FOOT1:4)
       BEGIN
          IF RKT='A'
             PRINT(RPT:RPT_FOOT1:5)  !6 AR A%
          ELSE
             PRINT(RPT:RPT_FOOT1)    !6
          .
       .
       PRINT(RPT:RPT_FOOT1)    !7
       PRINT(RPT:RPT_FOOT1:4)  !8
       PRINT(RPT:RPT_FOOT1:4)  !9
       BEGIN                   !10 PIESPIEDU IEKÐÇJÂ
          IF sys:nom_cit = 'K'
             PRINT(RPT:RPT_FOOT1C)
          ELSE
             PRINT(RPT:RPT_FOOT1)
          .
       .
       PRINT(RPT:RPT_FOOT1:2)  !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
        BEGIN                   !12
          IF sys:nom_cit = 'K'
             PRINT(RPT:RPT_FOOT1C)
          ELSE
             PRINT(RPT:RPT_FOOT1)
          .
       .
   .
    SUMK_B=ROUND(GETPVN(3),.01)
    !STOP('SUMK_B'&SUMK_B)
    !stop('PVNMASMODE'&PVNMASMODE)
    kopa='Kopâ :'
    EXECUTE OPCIJA_NR
       PRINT(RPT:RPT_FOOT2)
       PRINT(RPT:RPT_FOOT2:5)
       PRINT(RPT:RPT_FOOT2:2)
       PRINT(RPT:RPT_FOOT2:3)
       PRINT(RPT:RPT_FOOT2:4)
       BEGIN
          IF RKT='A'
             PRINT(RPT:RPT_FOOT2:5)  !6 AR A%
          ELSE
             PRINT(RPT:RPT_FOOT2)    !6
          .
       .
       PRINT(RPT:RPT_FOOT2)    !7
       PRINT(RPT:RPT_FOOT2:4)  !8
       PRINT(RPT:RPT_FOOT2:4)  !9
       PRINT(RPT:RPT_FOOT2)    !10 PIESPIEDU IEKÐÇJÂ
       PRINT(RPT:RPT_FOOT2:2)  !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
       PRINT(RPT:RPT_FOOT2)    !12
    .
    IEPAK_DK=0
    DAUDZUMSK_S=''
    IF GETPVN(14)
       SUMK_B=ROUND(GETPVN(14),.01)
!  PVNMASMODE=1: 22/12% PVN
!             2: 18/5%  PVN
!             3: 22/12% PVN
       IF PVNMASMODE=1
          kopa='t.s. 21% PVN grupâ:'
       ELSIF PVNMASMODE=3
          kopa='t.s. 22% PVN grupâ:'
       ELSE
          kopa='t.s. 18% PVN grupâ:'
       .
       EXECUTE OPCIJA_NR
          PRINT(RPT:RPT_FOOT2)
          PRINT(RPT:RPT_FOOT2:5)
          PRINT(RPT:RPT_FOOT2:2)
          PRINT(RPT:RPT_FOOT2:3)
          PRINT(RPT:RPT_FOOT2:4)
          BEGIN
             IF RKT='A'
                PRINT(RPT:RPT_FOOT2:5) !6 AR A%
             ELSE
                PRINT(RPT:RPT_FOOT2)   !6
             .
          .
          PRINT(RPT:RPT_FOOT2)   !7
          PRINT(RPT:RPT_FOOT2:4) !8
          PRINT(RPT:RPT_FOOT2:4) !9
          PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
          PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          PRINT(RPT:RPT_FOOT2)   !12
       .
    .
    IF GETPVN(16)
       SUMK_B=ROUND(GETPVN(16),.01)
       kopa='t.s.  9% PVN grupâ:'
       EXECUTE OPCIJA_NR
          PRINT(RPT:RPT_FOOT2)
          PRINT(RPT:RPT_FOOT2:5)
          PRINT(RPT:RPT_FOOT2:2)
          PRINT(RPT:RPT_FOOT2:3)
          PRINT(RPT:RPT_FOOT2:4)
          BEGIN
             IF RKT='A'
                PRINT(RPT:RPT_FOOT2:5) !6 AR A%
             ELSE
                PRINT(RPT:RPT_FOOT2)   !6
             .
          .
          PRINT(RPT:RPT_FOOT2)   !7
          PRINT(RPT:RPT_FOOT2:4) !8
          PRINT(RPT:RPT_FOOT2:4) !9
          PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
          PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          PRINT(RPT:RPT_FOOT2)   !12
      .
    .
    IF GETPVN(12)
       SUMK_B=ROUND(GETPVN(12),.01)
       kopa='t.s.  0% PVN grupâ:'
       EXECUTE OPCIJA_NR
          PRINT(RPT:RPT_FOOT2)
          PRINT(RPT:RPT_FOOT2:5)
          PRINT(RPT:RPT_FOOT2:2)
          PRINT(RPT:RPT_FOOT2:3)
          PRINT(RPT:RPT_FOOT2:4)
          BEGIN
             IF RKT='A'
                PRINT(RPT:RPT_FOOT2:5) !6 AR A%
             ELSE
                PRINT(RPT:RPT_FOOT2)   !6
             .
          .
          PRINT(RPT:RPT_FOOT2)   !7
          PRINT(RPT:RPT_FOOT2:4) !8
          PRINT(RPT:RPT_FOOT2:4) !9
          PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
          PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          PRINT(RPT:RPT_FOOT2)   !12
       .
    .
    IF GETPVN(17)
       SUMK_B=ROUND(GETPVN(17),.01)
       kopa='t.s.  Neapliekami:'
       EXECUTE OPCIJA_NR
          PRINT(RPT:RPT_FOOT2)
          PRINT(RPT:RPT_FOOT2:5)
          PRINT(RPT:RPT_FOOT2:2)
          PRINT(RPT:RPT_FOOT2:3)
          PRINT(RPT:RPT_FOOT2:4)
          BEGIN
             IF RKT='A'
                PRINT(RPT:RPT_FOOT2:5) !6 AR A%
             ELSE
                PRINT(RPT:RPT_FOOT2)   !6
             .
          .
          PRINT(RPT:RPT_FOOT2)   !7
          PRINT(RPT:RPT_FOOT2:4) !8
          PRINT(RPT:RPT_FOOT2:4) !9
          PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
          PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          PRINT(RPT:RPT_FOOT2)   !12
       .
    .
    !Elya 07.08.2012 IF GETPVN(19)                     !16/03/04
    IF PAV:DATUMS > date(06,30,2012)
      SUMK_12 = GETPVN(13)
    ELSE
      SUMK_12 = GETPVN(19)
    .
    IF SUMK_12
       SUMK_B=ROUND(SUMK_12,.01)
!  PVNMASMODE=3: 22/12% PVN
!             2: 18/5%  PVN
       !Elya IF PVNMASMODE=1
       IF PVNMASMODE=1 AND PAV:DATUMS > date(06,30,2012)
          kopa='t.s. 12% PVN grupâ:'
       ELSIF PVNMASMODE=1
          kopa='t.s. 10% PVN grupâ:'
       ELSIF PVNMASMODE=3
          kopa='t.s. 12% PVN grupâ:'
       ELSE
          kopa='t.s.  5% PVN grupâ:'
       .
       EXECUTE OPCIJA_NR
          PRINT(RPT:RPT_FOOT2)
          PRINT(RPT:RPT_FOOT2:5)
          PRINT(RPT:RPT_FOOT2:2)
          PRINT(RPT:RPT_FOOT2:3)
          PRINT(RPT:RPT_FOOT2:4)
          BEGIN
             IF RKT='A'
                PRINT(RPT:RPT_FOOT2:5) !6 AR A%
             ELSE
                PRINT(RPT:RPT_FOOT2)   !6
             .
          .
          PRINT(RPT:RPT_FOOT2)   !7
          PRINT(RPT:RPT_FOOT2:4) !8
          PRINT(RPT:RPT_FOOT2:4) !9
          PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
          PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
          PRINT(RPT:RPT_FOOT2)   !12
       .
    .
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
          EXECUTE OPCIJA_NR
             PRINT(RPT:RPT_FOOT2)
             PRINT(RPT:RPT_FOOT2:5)
             PRINT(RPT:RPT_FOOT2:2)
             PRINT(RPT:RPT_FOOT2:3)
             PRINT(RPT:RPT_FOOT2:4)
             BEGIN
                IF RKT='A'
                   PRINT(RPT:RPT_FOOT2:5) !6 AR A%
                ELSE
                   PRINT(RPT:RPT_FOOT2)   !6
                .
             .
             PRINT(RPT:RPT_FOOT2)   !7
             PRINT(RPT:RPT_FOOT2:4) !8
             PRINT(RPT:RPT_FOOT2:4) !9
             PRINT(RPT:RPT_FOOT2)   !10 PIESPIEDU IEKÐÇJÂ
             PRINT(RPT:RPT_FOOT2:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
             PRINT(RPT:RPT_FOOT2)   !12
          .
        .
      .
    .
    EXECUTE OPCIJA_NR
       PRINT(RPT:RPT_FOOT3)
       PRINT(RPT:RPT_FOOT3:5)
       PRINT(RPT:RPT_FOOT3:2)
       PRINT(RPT:RPT_FOOT3:3)
       PRINT(RPT:RPT_FOOT3:4)
       BEGIN
          IF RKT='A'
             PRINT(RPT:RPT_FOOT3:5) !6 AR A%
          ELSE
             PRINT(RPT:RPT_FOOT3)   !6
          .
       .
       PRINT(RPT:RPT_FOOT3)   !7
       PRINT(RPT:RPT_FOOT3:4) !8
       PRINT(RPT:RPT_FOOT3:4) !9
       PRINT(RPT:RPT_FOOT3)   !10 PIESPIEDU IEKÐÇJÂ
       PRINT(RPT:RPT_FOOT3:2) !11 PIESPIEDU IEKÐÇJÂ 2 RINDAS
       PRINT(RPT:RPT_FOOT3)   !12
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A > 0
       PRINT(RPT:RPT_ATLAIDE)
    .
!************************* SVARS ***********
    IF SVARS AND BAND(SYS:BAITS1,00010000B)
          PRINT(RPT:RPT_FOOT32)
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
!      PAV_T_SUMMA=ROUND(pav:t_summa/(1+PAV:T_PVN/100),.01)                  !TRANSPORTS BEZ PVN
      PAV_T_PVN=ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)               !23/11/05
      PAV_T_SUMMA=PAV:T_SUMMA-PAV_T_PVN                                      !10/03/03
      PRINT(RPT:RPT_FOOT33)
    .
!************************* PVN ***********
    IF GETPVN(11)+PAV_T_PVN
       SUMK_PVN = ROUND(getpvn(11)+PAV_T_PVN,.01) !18/21/22% PVN + TRANSPORTA PVN(REQEST 18/21%...)
       IF PVNMASMODE=1
          PAV_PVN = '21'
       ELSIF PVNMASMODE=3
          PAV_PVN = '22'
       ELSE
          PAV_PVN = '18'
       .
       !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = SUMK_PVN*LBKURSS
!       ELSIF EUR_P
!          LS_PVN = SUMK_PVN/LBKURSS
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS  !1,4.....
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS   !0,702804
          .
       .
       !Elya 27.08.2013 >
       PRINT(RPT:RPT_PVN)
    .
    IF GETPVN(15)
       SUMK_PVN = ROUND(getpvn(15),.01)
       PAV_PVN = '9'
      !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = SUMK_PVN*LBKURSS
!       ELSIF EUR_P
!          LS_PVN = SUMK_PVN/LBKURSS
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS  !1,4.....
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS   !0,702804
          .
       .
       !Elya 27.08.2013 >

       PRINT(RPT:RPT_PVN)
    .
!    IF GETPVN(18)                          !16/03/04
!    stop(GETPVN(19)&' '&PVNMASMODE)                          !08/01/11
    IF GETPVN(18)                          !08/01/11
       SUMK_PVN = ROUND(getpvn(18),.01)
       IF PVNMASMODE=1
          PAV_PVN = '10'
       ELSIF PVNMASMODE=3
          PAV_PVN = '12'
       ELSE
          PAV_PVN = '5'
       .
      !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = SUMK_PVN*LBKURSS
!       ELSIF EUR_P
!          LS_PVN = SUMK_PVN/LBKURSS
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS  !1,4.....
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS   !0,702804
          .
       .
       !Elya 27.08.2013 >
       PRINT(RPT:RPT_PVN)
    .
    IF GETPVN(10) AND PAV:DATUMS > date(06,30,2012)
       SUMK_PVN = ROUND(getpvn(10),.01)
       PAV_PVN = '12'
      !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = SUMK_PVN*LBKURSS
!       ELSIF EUR_P
!          LS_PVN = SUMK_PVN/LBKURSS
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS  !1,4.....
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS   !0,702804
          .
       .
       !Elya 27.08.2013 >
       PRINT(RPT:RPT_PVN)
    .
    IF GETPVN(12) ! IR SUMMA AR 0% PVN
       SUMK_PVN = 0
       PAV_PVN = '0'
      !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = SUMK_PVN*LBKURSS
!       ELSIF EUR_P
!          LS_PVN = SUMK_PVN/LBKURSS
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS  !1,4.....
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = SUMK_PVN*LBKURSS
          ELSIF EUR_P
             LS_PVN = SUMK_PVN/LBKURSS   !0,702804
          .
       .
       !Elya 27.08.2013 >
       PRINT(RPT:RPT_PVN)
    .
    IF GETPVN(17) ! IR SUMMA NEAPLIEKAMA AR PVN     !*
       SUMK_PVN = 0                                 !*
       PAV_PVN = '-'                                !*
       !Elya 27.08.2013 <
!       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
!          LS_PVN = 0
!       .
       IF PAV:DATUMS >= date(01,01,2014)
          IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
             LS_PVN = 0
          .
       ELSE
          IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
             LS_PVN = 0
          .
       .
       !Elya 27.08.2013 >
       PRINT(RPT:RPT_PVN)                           !*
    .                                               !*
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)  !3=BEZ PVN 1=PVN
       KLUDA(0,'Nesakrît summas...')
       STOP(PAV:SUMMA&'-'&PAV:T_SUMMA&'-'&GETPVN(3)&'-'&GETPVN(1))
    .
    SUMK_B=ROUND(GETPVN(3),.01)    ! JÂPÂRRÇÍINA
    SUMK_PVN=ROUND(getpvn(1),.01)  ! JÂPÂRRÇÍINA
    SUMK_APM = SUMK_B + SUMK_PVN + PAV:T_SUMMA
   !Elya 27.08.2013 <
!    IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z PARÂDAM Ls
!       LS_SUMMA = SUMK_APM*LBKURSS
!    ELSIF EUR_P
!       LS_SUMMA = SUMK_APM/LBKURSS
!    .
    IF PAV:DATUMS >= date(01,01,2014)
       IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
          LS_SUMMA = SUMK_APM*LBKURSS
       ELSIF EUR_P
          LS_SUMMA = SUMK_APM/LBKURSS  !1,4.....
       .
    ELSE
       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
          LS_SUMMA = SUMK_APM*LBKURSS
       ELSIF EUR_P
          LS_SUMMA = SUMK_APM/LBKURSS  !0,702804
       .
    .
    !Elya 27.08.2013 >
    IF ZEMNIEKS#                       !-AKCÎZE ZEMNIEKAM
       PAVISAM_APMAKSAI='Saimnieciskâ darîjuma novçrtçjums naudâ (ar cipariem)'
       SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
       PRINT(RPT:RPT_FOOT4)
       sumk_ZEM=-(DAUDZUMSZ*.223+DAUDZUMSZ1*.234)
       PRINT(RPT:RPT_ZEM)
       SUMK_APM+=sumk_ZEM
       IF LS_SUMMA THEN LS_SUMMA+=sumk_ZEM.
       PAVISAM_APMAKSAI='18. Pavisam apmaksai (ar cipariem)'
       SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
       PRINT(RPT:RPT_FOOT4)
    ELSIF INRANGE(OPCIJA_NR,8,9)          !KOKMATERIÂLU PZ,RÇÍINS VAIRUMÂ
       PAVISAM_APMAKSAI='Summa kopâ'
       SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
       PRINT(RPT:RPT_FOOT4)
       SUMK_APM-=sumk_PVN
       IF LS_SUMMA THEN LS_SUMMA-=LS_PVN.
       PAVISAM_APMAKSAI='18. Pavisam apmaksai (ar cipariem)'
       SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
       PRINT(RPT:RPT_FOOT4)
    ELSE
       SUMV = SUMVAR(SUMK_APM,PAV:VAL,0)
       IF PAV:APM_V=5 OR OPCIJA_NR=10 OR OPCIJA_NR=11 !IEKÐÇJÂ PÂRVIETOÐANA, PIESPIEDU IEKÐÇJÂ
          PAVISAM_APMAKSAI='18. Pavisam (nav jâmaksâ)'
       ELSE
          PAVISAM_APMAKSAI='18. Pavisam apmaksai (ar cipariem)'
       .
       PRINT(RPT:RPT_FOOT4)
    .
    IF (PAV_AUTO OR F:IDP='A') AND ~(OPCIJA_NR=6 OR OPCIJA_NR=9) !JA TAS AUTO IR VAI A4(raksti kaut ar roku) UN NAV RÇÍINS
       PRINT(RPT:RPT_FOOT41)
    END
    !Elya 27.08.2013 <
!    IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z SPECIÂLA RINDA PAR LB KURSU
!       PRINT(RPT:RPT_LS)
!    ELSIF EUR_P
!       PRINT(RPT:RPT_LS)
!    .
    IF PAV:DATUMS >= date(01,01,2014)
       IF ~(PAV:VAL='EUR')        ! VALÛTAS P/Z PARÂDAM Eur
          PRINT(RPT:RPT_LS)
       ELSIF EUR_P
          PRINT(RPT:RPT_LS)
       .
    ELSE
       IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')        ! VALÛTAS P/Z PARÂDAM Ls
          PRINT(RPT:RPT_LS)
       ELSIF EUR_P
          PRINT(RPT:RPT_LS)
       .
    .
    !Elya 27.08.2013 >

    IF F:DTK
        checkopen(OUTFILEANSI)
        SET(OUTFILEANSI)
        LOOP
           NEXT(OUTFILEANSI)
           IF ERROR() THEN BREAK.
           LINE=OUTA:LINE
           PRINT(RPT:PPR_TXT)
        .
    .
    close(OUTFILEANSI)

    ANSIFILENAME='PZP'&CLIP(PAV:PAR_NR)&'.TXT'
    OPEN(OUTFILEANSI)
    IF ~ERROR()
        SET(OUTFILEANSI)
        LOOP
           NEXT(OUTFILEANSI)
           IF ERROR() THEN BREAK.
           LINE=OUTA:LINE
           PRINT(RPT:PPR_TXT)
        .
    .
    CLOSE(OUTFILEANSI)

!***************************PARAKSTI UN KONTÇJUMS********************
    PAV:SUMMA=PAV:SUMMA*SIGN#   !ATGRIEÞAM UZ - , JA TÂDS BIJIS
    IF F:KONTI='D' AND ~INRANGE(OPCIJA_NR,8,11) AND ~INRANGE(PAV:PAR_NR,1,50) !JÂDRUKÂ KONTÇJUMS UN NAV KOKMATERIÂLI VAIRUMÂ,NAV IEKÐÇJÂ
        BUILDGGKTABLE(1)
        CLEAR(GGK_SUMMAV)
        CLEAR(GGK_D_K)
        CLEAR(GGK_BKK)
        LOOP J#=1 TO RECORDS(ggK_TABLE)
           IF J# <= 8
              GET(GGK_TABLE,J#)
              GGT:SUMMA=ROUND(GGT:SUMMA,.01)
              GGT:SUMMAV=ROUND(GGT:SUMMAV,.01)
              GGK_SUMMAV[J#] = GGT:SUMMA !10/05/2004
              GGK_BKK[J#]    = GGT:BKK
              GGK_D_K[J#]    = GGT:D_K
           .
        .
    END
    IF RKT='T'    !TÂME-PIEDÂVÂJUMS
       PRINT(RPT:RPT_FOOT5:6T)
    ELSIF INSTRING(RKT,'RA') !RÇÍINS-FAKTÛRA,RF AR A%
       DO FILLPARAKSTI   !UZTAISA SVÎTRAS, JA VAJAG
       PRINT(RPT:RPT_FOOT5:6R)
    ELSE          !PPR VAI RÇÍINS-FAKTÛRA AR KLIENTA PARAKSTIEM
       PRINT(RPT:RPT_FOOT5)
    .
    !Elya 25/06/2013
    W_pav_EDI 
    ENDPAGE(report)

!    CLOSE(ProgressWindow)
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
!  IF ERRORCODE() OR ~(NOL:U_NR=PAV:U_NR)
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

!-----------------------------------------------------------------------------
!FILLPARAKSTI ROUTINE           !PIRMS DETAIÏA..~~SÂKUMS & BUTTON:MAKARONI & OK.
!  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
!     CODE39=GETPARAKSTI(SYS_PARAKSTS_NR,3,CTRL#)
!     CTRL#=VAL(CODE39[1])+VAL(PAV:DOK_SENR[1])+VAL(PAV:NOKA[1])
!     ?CODE39_TEXT{PROP:TEXT}='Rçíins sagatavots elektroniski un ir derîgs bez paraksta'
!     SYS_PARAKSTS=''
!     ?STRING62:12R{PROP:TEXT}=''
!     ?STRING62:19R{PROP:TEXT}=''
!     HIDE(?LINE77:3R)
!     ?STRING62:21R{PROP:TEXT}=''
!  ELSE
!     HIDE(?CODE39)
!  .
!  DISPLAY

FILLPARAKSTI ROUTINE        !SÂKUMS & BUTTON:MAKARONI & OK.
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  SYS_AMATS   =GETPARAKSTI(SYS_PARAKSTS_NR,2)
  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
!     CTRL#=VAL(CODE39[1])+VAL(GG:DOK_SENR[1])+VAL(GG:NOKA[1])
     CTRL#=VAL(CODE39[1])+VAL(PAV:DOK_SENR[1])+VAL(PAV:NOKA[1])
     CODE39=GETPARAKSTI(SYS_PARAKSTS_NR,3,CTRL#)
     IF PAV:DATUMS>=DATE(5,11,2011)
        CODE39_TEXT='Elektroniksi apliecina '&CLIP(SYS_AMATS)&' '&CLIP(SYS_PARAKSTS)
     ELSE
        !22/04/2013 CODE39_TEXT='Rçíins sagatavots elektroniski un ir derîgs bez paraksta'
        CODE39_TEXT=''!22/04/2013
     .
     CODE39_TEXT_2='Rçíins ir sagatavots elektroniski un derîgs bez paraksta.'  !22/04/2013
     SYS_PARAKSTS=''
     SYS_AMATS=''
!     SvitraParakstam=''
  ELSE
!     SvitraParakstam='_{28}'
     CODE39=''
     CODE39_TEXT_2='' !22/04/2013
     CODE39_TEXT=CLIP(SYS_AMATS)&' _____________________ '&SYS_PARAKSTS
  .
  DISPLAY
FILLPVN              PROCEDURE (OPC,<NOL_PVN_PROC>) ! Declare Procedure
LocalResponse        LONG
  CODE                                            ! Begin processed code
!  JÂBÛT POZICIONÇTAM NOLIK VAI FPN UN NOM_K
!
!  masîvs pvnmas[R,K]: pvn% R:1 -summma kopâ kur 'ar'  VISS
!  NO FILLPVN   14,6        R:2 -summma kopâ kur 'bez' VISS
!                           R:3 -summma kopâ kur 'ar'  PRECE
!                           R:4 -summma kopâ kur 'bez' PRECE
!                           R:5 -summma kopâ kur 'ar'  TARA
!                           R:6 -summma kopâ kur 'bez' TARA
!                           R:7 -summma kopâ kur 'ar'  PAKALPOJUMI
!                           R:8 -summma kopâ kur 'bez' PAKALPOJUMI
!                           R:9 -summma kopâ kur 'ar'  KOKMATERIÂLI
!                           R:10-summma kopâ kur 'bez' KOKMATERIÂLI  
!                           R:11-summma kopâ kur 'ar'  RAÞOJUMI
!                           R:12-summma kopâ kur 'bez' RAÞOJUMI
!                           R:13-summma kopâ kur 'ar'  IEPAKOJUMI&VIRTUÂLIE
!                           R:14-summma kopâ kur 'bez' IEPAKOJUMI&VIRTUÂLIE
!                           K:1=0
!                           K:2=12%
!                           K:3=18/21/22%
!                           K:4=9%
!                           K:5=NEAPLIEKAMS
!                           K:6=5/10/12%
!
!  PVNMASMODE=1: 21/10% PVN   pec datuma > date(06,30,2012)   PVNMASMODE = 1: 21%/12%
!             2: 18/5%  PVN
!             3: 22/12% PVN
!
 LOCALRESPONSE=REQUESTCOMPLETED
 case OPC
 of 0
    clear(pvnmas)
    PVNMASMODE=0
 of 1
    IF INRANGE(JOB_NR,41,60) !POS
      case FPN:PVN_PR
      of 0
        i#=1
      of 12
        i#=2
      OF 18
        i#=3
        IF PVNMASMODE=1
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=2
      OF 21
        i#=3
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=1
      OF 22
        i#=3
        IF PVNMASMODE=1
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 22&21/12&10% PVN')
        .
        PVNMASMODE=3 !?
      of 9
        i#=4
      of 5
        i#=6
        IF PVNMASMODE=1
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=2
      OF 10
        i#=6
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=1
      OF 12
        i#=6
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=1
      ELSE
        STOP('FILLPVN:PVN='&FPN:PVN_PR&' KODS='&FPN:KODS)
        RETURN
      .
      pvnmas[1,i#]+=FPN:summa*(1-FPN:atlaide_PR/100)

    ELSE  !NOLIKTAVA
      IF ~NOL_PVN_PROC THEN NOL_PVN_PROC=NOL:PVN_PROC.
      case NOL_PVN_PROC
      of 0
        IF BAND(NOL:BAITS,00000010b) !NEAPLIEKAMS
           i#=5
        ELSE
           i#=1
        .
      of 12
        IF YEAR(NOL:DATUMS)<2011
           i#=2
        ELSE
           i#=6
           IF PVNMASMODE=2
              KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 5/10/12% PVN')
           .

           !ELYA 07.08.2012 PVNMASMODE=3
           if NOL:DATUMS > date(06,30,2012)
            i#=2
            PVNMASMODE=1
           ELSE
            PVNMASMODE=3
           .
        .
      of 18
        i#=3
        IF PVNMASMODE=1
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=2
      OF 21
        i#=3
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=1
      OF 22
        i#=3
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 22&21/12&10% PVN')
        .
        PVNMASMODE=3
      of 9
        i#=4
      of 5
        i#=6
        IF PVNMASMODE=1
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=2
      OF 10
        i#=6
        IF PVNMASMODE=2
           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 21&18/10&5% PVN')
        .
        PVNMASMODE=1
!      OF 12
!        i#=6
!       IF PVNMASMODE=2
!           KLUDA(0,'Vienâ P/Z nedrîkst bût vienlaicîgi 22&21/12&10% PVN')
!        .
!        PVNMASMODE=3
      ELSE
!        STOP('FILLPVN:PVN='&NOL:PVN_PROC&' '&NOL:NOMENKLAT)
        STOP('FILLPVN:PVN='&NOL_PVN_PROC&' '&NOL:NOMENKLAT)
        RETURN
      .
      if nol:arBYTE=1 !ar
         pvnmas[1,i#]+=nol:summav*(1-nol:atlaide_pr/100)     !ROUNDS TIEK VEIKTS AUTOMÂTISKI
         CASE NOM:TIPS
         OF 'P'      !PRECE
         OROF ''
            pvnmas[3,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'T'      !TARA
            pvnmas[5,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'A'      !PAKALPOJUMI
            pvnmas[7,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'K'      !KOKMATERIÂLI
            pvnmas[9,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'R'      !RAÞOJUMI
            pvnmas[11,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         ELSE        !IEPAKOJUMI&VIRTUÂLIE
            pvnmas[13,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         .
         return
      elsif nol:arBYTE=0 !bez
  !      pvnmas[2,i#]+=ROUND(nol:summav*(1-nol:atlaide_pr/100),.001)
         pvnmas[2,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         CASE NOM:TIPS
         OF 'P'
         OROF ''
            pvnmas[4,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'T'
            pvnmas[6,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'A'
            pvnmas[8,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'K'
            pvnmas[10,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         OF 'R'
            pvnmas[12,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         ELSE
            pvnmas[14,i#]+=nol:summav*(1-nol:atlaide_pr/100)
         .
         return
      else
         stop('ar/bez='&nol:arBYTE&NOL:NOMENKLAT)
      .
    .
 .


GETPVN               FUNCTION (RET)               ! Declare Procedure
LocalResponse           LONG
PVN05                   DECIMAL(4,2) !0.10
PVN18                   DECIMAL(4,2) !0.21
PVN105                  DECIMAL(4,2) !1.10
PVN118                  DECIMAL(4,2) !1.21
  CODE                                            ! Begin processed code
!
!  pvnmasmode   :             2-vecais  PVN 18,5
!                             1-jaunais PVN 21,10
!
!  masîvs pvnmas:   KOLONNAS: 0 12 18/21 9 NEAPLIEKAMS 5/10
!                   RINDAS:   1-summma kopâ kur 'ar'
!                             2-summma kopâ kur 'bez'
!                             3-summma kopâ kur 'ar'  precei
!                             4-summma kopâ kur 'bez' precei
!                                        utt.
!                            12-summma kopâ kur 'bez' raþojumiem
!                            13-summma kopâ kur 'ar'  iepakojumiem,virtuâliem
!                            14-summma kopâ kur 'bez' iepakojumiem,virtuâliem
!
!  RET          :   1-ATGRIEÞ pvn
!                   2-ATGRIEÞ SUMMU AR pvn
!                   3-ATGRIEÞ SUMMU BEZ pvn
!
!                   4-ATGRIEÞ SUMMU BEZ pvn precei
!                   5-ATGRIEÞ SUMMU BEZ pvn tarai
!                   6-ATGRIEÞ SUMMU BEZ pvn apkalpoðanai
!                   7-ATGRIEÞ SUMMU BEZ pvn kokmateriâliem
!                   8-ATGRIEÞ SUMMU BEZ pvn raþojumiem
!                   9-ATGRIEÞ SUMMU BEZ pvn iepakojumiem,virtuâliem
!
!                  10-ATGRIEÞ pvn(12%)
!                  11-ATGRIEÞ pvn(18/21%)
!                  12-ATGRIEÞ SUMMU BEZ pvn(0%)
!                  13-ATGRIEÞ SUMMU BEZ pvn(12%)
!                  14-ATGRIEÞ SUMMU BEZ pvn(18/21/22%)
!
!                  15-ATGRIEÞ pvn(9%)
!                  16-ATGRIEÞ SUMMU BEZ pvn(9%)
!
!                  17-ATGRIEÞ SUMMU BEZ pvn(NEAPLIEKAMIEM)
!
!                  18-ATGRIEÞ pvn(5/10/12%)
!                  19-ATGRIEÞ SUMMU BEZ pvn(5/10/12%)
!
!                  20-ATGRIEÞ 1 ja vairâk kâ 1 summa 4-8
!

!             KASES ÈEKÂ IR NOAPAÏOTA SUMMA AR PVN !

   LOCALRESPONSE=REQUESTCOMPLETED
   pvn1$=0
   pvn2$=0
   pvn3$=0
   pvn4$=0
   pvn5$=0
   IRSUMMA#=0
   IF PVNMASMODE=1 !JAUNIE %
      PVN05 =0.10
      PVN18 =0.21
      PVN105=1.10
      PVN118=1.21
   ELSIF PVNMASMODE=3 !2011 %
      PVN05 =0.12
      PVN18 =0.22
      PVN105=1.12
      PVN118=1.22
   ELSE
      PVN05 =0.05
      PVN18 =0.18
      PVN105=1.05
      PVN118=1.18
   .
    CASE RET
   OF 1
      pvn1$=0                                                              ! 0%PVN
      pvn2$=ROUND(pvnmas[1,2],.01)*(1-1/1.12)+ROUND(ROUND(pvnmas[2,2],.01)*0.12,.01)
      pvn3$=ROUND(pvnmas[1,3],.01)*(1-1/PVN118)+ROUND(ROUND(pvnmas[2,3],.01)*PVN18,.01)
      pvn4$=ROUND(pvnmas[1,4],.01)*(1-1/1.09)+ROUND(ROUND(pvnmas[2,4],.01)*0.09,.01)
      pvn5$=0                                                              ! NEAPLIEKAMI
      pvn6$=ROUND(pvnmas[1,6],.01)*(1-1/PVN105)+ROUND(ROUND(pvnmas[2,6],.01)*PVN05,.01)
   OF 2
      pvn1$=ROUND(pvnmas[1,1],.01)+ROUND(pvnmas[2,1],.01)                  !0%PVN
      pvn2$=ROUND(pvnmas[1,2],.01)+ROUND(ROUND(pvnmas[2,2],.01)*1.12,.01)  !12%PVN
      pvn3$=ROUND(pvnmas[1,3],.01)+ROUND(ROUND(pvnmas[2,3],.01)*PVN118,.01)!18/21/22%PVN
      pvn4$=ROUND(pvnmas[1,4],.01)+ROUND(ROUND(pvnmas[2,4],.01)*1.09,.01)  !9%PVN
      pvn5$=ROUND(pvnmas[1,5],.01)+ROUND(pvnmas[2,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(pvnmas[1,6],.01)+ROUND(ROUND(pvnmas[2,6],.01)*PVN105,.01)!5/10/12%PVN
   OF 3
      pvn1$=ROUND(pvnmas[1,1],.01)+ROUND(pvnmas[2,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[1,2],.01)/1.12,.01)+ROUND(pvnmas[2,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[1,3],.01)/PVN118,.01)+ROUND(pvnmas[2,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[1,4],.01)/1.09,.01)+ROUND(pvnmas[2,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[1,5],.01)+ROUND(pvnmas[2,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[1,6],.01)/PVN105,.01)+ROUND(pvnmas[2,6],.01)!5/10/12%PVN
   OF 4
      pvn1$=ROUND(pvnmas[3,1],.01)+ROUND(pvnmas[4,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[3,2],.01)/1.12,.01)+ROUND(pvnmas[4,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[3,3],.01)/PVN118,.01)+ROUND(pvnmas[4,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[3,4],.01)/1.09,.01)+ROUND(pvnmas[4,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[3,5],.01)+ROUND(pvnmas[4,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[3,6],.01)/PVN105,.01)+ROUND(pvnmas[4,6],.01)!5/10/12%PVN
   OF 5
      pvn1$=ROUND(pvnmas[5,1],.01)+ROUND(pvnmas[6,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[5,2],.01)/1.12,.01)+ROUND(pvnmas[6,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[5,3],.01)/PVN118,.01)+ROUND(pvnmas[6,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[5,4],.01)/1.09,.01)+ROUND(pvnmas[6,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[5,5],.01)+ROUND(pvnmas[6,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[5,6],.01)/PVN105,.01)+ROUND(pvnmas[6,6],.01)!5/10/12%PVN
   OF 6
      pvn1$=ROUND(pvnmas[7,1],.01)+ROUND(pvnmas[8,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[7,2],.01)/1.12,.01)+ROUND(pvnmas[8,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[7,3],.01)/PVN118,.01)+ROUND(pvnmas[8,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[7,4],.01)/1.09,.01)+ROUND(pvnmas[8,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[7,5],.01)+ROUND(pvnmas[8,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[7,6],.01)/PVN105,.01)+ROUND(pvnmas[8,6],.01)!5/10/12%PVN
   OF 7
      pvn1$=ROUND(pvnmas[9,1],.01)+ROUND(pvnmas[10,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[9,2],.01)/1.12,.01)+ROUND(pvnmas[10,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[9,3],.01)/PVN118,.01)+ROUND(pvnmas[10,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[9,4],.01)/1.09,.01)+ROUND(pvnmas[10,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[9,5],.01)+ROUND(pvnmas[10,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[9,6],.01)/PVN105,.01)+ROUND(pvnmas[10,6],.01)!5/10/12%PVN
   OF 8
      pvn1$=ROUND(pvnmas[11,1],.01)+ROUND(pvnmas[12,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[11,2],.01)/1.12,.01)+ROUND(pvnmas[12,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[11,3],.01)/PVN118,.01)+ROUND(pvnmas[12,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[11,4],.01)/1.09,.01)+ROUND(pvnmas[12,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[11,5],.01)+ROUND(pvnmas[12,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[11,6],.01)/PVN105,.01)+ROUND(pvnmas[12,6],.01)!5/10/12%PVN
   OF 9
      pvn1$=ROUND(pvnmas[13,1],.01)+ROUND(pvnmas[14,1],.01)                  !0%PVN
      pvn2$=ROUND(ROUND(pvnmas[13,2],.01)/1.12,.01)+ROUND(pvnmas[14,2],.01)  !12%PVN
      pvn3$=ROUND(ROUND(pvnmas[13,3],.01)/PVN118,.01)+ROUND(pvnmas[14,3],.01)!18/21/22%PVN
      pvn4$=ROUND(ROUND(pvnmas[13,4],.01)/1.09,.01)+ROUND(pvnmas[14,4],.01)  !9%PVN
      pvn5$=ROUND(pvnmas[13,5],.01)+ROUND(pvnmas[14,5],.01)                  !NEAPLIEKAMI
      pvn6$=ROUND(ROUND(pvnmas[13,6],.01)/PVN105,.01)+ROUND(pvnmas[14,6],.01)!5/10/12%PVN
   OF 10
      pvn2$=ROUND(pvnmas[1,2],.01)*(1-1/1.12)+ROUND(ROUND(pvnmas[2,2],.01)*0.12,.01)!12%PVN
      return(ROUND(pvn2$,.01))
   OF 11
      pvn3$=ROUND(pvnmas[1,3],.01)*(1-1/PVN118)+ROUND(ROUND(pvnmas[2,3],.01)*PVN18,.01)!18/21/22%PVN
      return(ROUND(pvn3$,.01))
   OF 15
      pvn4$=ROUND(pvnmas[1,4],.01)*(1-1/1.09)+ROUND(ROUND(pvnmas[2,4],.01)*0.09,.01)!9%PVN
      return(ROUND(pvn4$,.01))
   OF 18
      pvn6$=ROUND(pvnmas[1,6],.01)*(1-1/PVN105)+ROUND(ROUND(pvnmas[2,6],.01)*PVN05,.01)!5/10/12%PVN
      return(ROUND(pvn6$,.01))

   OF 12
      pvn1$=ROUND(pvnmas[1,1],.01)+ROUND(pvnmas[2,1],.01)                  !0%PVN
      return(ROUND(pvn1$,.01))
   OF 13
      pvn2$=ROUND(ROUND(pvnmas[1,2],.01)/1.12,.01)+ROUND(pvnmas[2,2],.01)  !12%PVN
      return(ROUND(pvn2$,.01))
   OF 14
      pvn3$=ROUND(ROUND(pvnmas[1,3],.01)/PVN118,.01)+ROUND(pvnmas[2,3],.01)!18/21/22%PVN
      return(ROUND(pvn3$,.01))
   OF 16
      pvn4$=ROUND(ROUND(pvnmas[1,4],.01)/1.09,.01)+ROUND(pvnmas[2,4],.01)  !9%PVN
      return(ROUND(pvn4$,.01))
   OF 17
      pvn5$=ROUND(pvnmas[1,5],.01)+ROUND(pvnmas[2,5],.01)                  !NEAPLIEKAMI
      return(ROUND(pvn5$,.01))
!   OF 18
!      pvn3$=ROUND(ROUND(pvnmas[1,3],.01)/PVN118,.01)+ROUND(pvnmas[2,3],.01)!18/21/22%PVN
!      return(ROUND(pvn3$,.01))
   OF 19
      pvn6$=ROUND(ROUND(pvnmas[1,6],.01)/PVN105,.01)+ROUND(pvnmas[2,6],.01)!5/10/12%PVN
      return(ROUND(pvn6$,.01))
   OF 20
      LOOP I#=3 TO 14 BY 2   !IR NE TIKAI  PREÈU SUMMA
         IF ROUND(pvnmas[I#,1],.01)+ROUND(pvnmas[I#+1,1],.01)+|    ! 0%PVN
            ROUND(pvnmas[I#,2],.01)+ROUND(pvnmas[I#+1,2],.01)+|    !12%PVN
            ROUND(pvnmas[I#,3],.01)+ROUND(pvnmas[I#+1,3],.01)+|    !18/21/22%PVN
            ROUND(pvnmas[I#,4],.01)+ROUND(pvnmas[I#+1,4],.01)+|    ! 9%PVN
            ROUND(pvnmas[I#,6],.01)+ROUND(pvnmas[I#+1,6],.01)+|    ! 5/10/12%PVN
            ROUND(pvnmas[I#,5],.01)+ROUND(pvnmas[I#+1,5],.01)<>0   ! NEAPLIEKAMI
            IRSUMMA#+=1
         .
         IF IRSUMMA#>1
            RETURN(1)
         .
      .
   .
   return(ROUND(pvn1$+PVN2$+PVN3$+PVN4$+PVN5$+PVN6$,.01))

