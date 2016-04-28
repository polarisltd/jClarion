                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_Pavad              PROCEDURE                    ! Declare Procedure
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

RPT_NPK              STRING(3)
DATUMS               STRING(2)
MENVAR               STRING(10)
IzsnDatums           string(35)
PAR_NOS_P            STRING(45)
PAR_REG_NR           STRING(37)
RPT_CLIENT           STRING(45)
KESKA                STRING(60)
KEKSIS               STRING(1)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
ADRESE               STRING(60)
ADRESE1              STRING(60)
Iekr_vieta           STRING(60)
Izkr_vieta           STRING(60)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
C_DATUMS             LONG
NPK                  STRING(3)
KOPA                 STRING(15)
GG_VAL               LIKE(GG:VAL)
RPT_PVN_PROC         STRING(3)
SUMV                 STRING(112)
PLKST                TIME
CENA                 decimal(13,2)
CENA_S               STRING(15)
SUMMA_BN             decimal(13,2)
SUMMA_BNS            STRING(15)
AplSUMMA             decimal(13,2)
SUMMK_BN             DECIMAL(12,2)      !
SUMMK_PVN            DECIMAL(13,2)
SUMMK_AN             DECIMAL(13,2)
SamaksasVeids        STRING(21)
SamaksasKartiba      STRING(21)
NOSAUKUMS            STRING(50)
PrecuNosaukums       string(50),dim(10)
Mervieniba           STRING(7)
Daudzums             decimal(3,1)
DAUDZUMS_S           STRING(15)
PrecuDaudzums        decimal(3,1),dim(10)
PrecuSumma           DECIMAL(12,2),dim(10)
PrecuPVN             DECIMAL(2),dim(10)
LBKURSS              DECIMAL(14,6)
BAN_NOS_P            STRING(31)
MB                   BYTE
PB                   BYTE
PUZ                  STRING(1)
PAVADZIME            STRING(30)
DOK_SENR             STRING(14)
PARVADATAJS          STRING(80)
SDA                  STRING(36)
SYS_PARAKSTS         STRING(25)
PVN                  DECIMAL(12,2),DIM(4)  !PAGAIDÂM TIKAI 1:18/21/22%
STRINGPVN            STRING(40)
ATGRIEZTA            STRING(20)

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
report REPORT,AT(100,400,8000,11198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
DETAIL0 DETAIL,AT(,,,1240),USE(?unnamed:2)
         STRING(@s30),AT(2510,740),USE(PAVADZIME),TRN,CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(3531,1063,1490,177),USE(ATGRIEZTA),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
       END
PAGE_HEAD DETAIL,AT(,21,7990,2719),USE(?unnamed)
         STRING(@s50),AT(2125,52,3802,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(6917,135),USE(dok_senr),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.b),AT(3490,2542,625,156),USE(c_datums),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4354,2479,2865,208),USE(GG:SATURS3),LEFT
         STRING('07. Samaksas veids  '),AT(625,2406,1302,156),USE(?String1:10),LEFT
         STRING(@s21),AT(2104,2406,1302,156),USE(SamaksasVeids),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('    Samaksas  kârtîba'),AT(688,2531,1094,156),USE(?String1:12),LEFT(1)
         STRING(@s21),AT(2104,2542,1354,156),USE(SamaksasKartiba),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(5552,2271,990,208),USE(atlauja),LEFT
         STRING(@s36),AT(1750,2260,2344,156),USE(SDA),TRN,LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,365,0,1875),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('08. Speciâlas atzîmes'),AT(4354,2271,1146,208),USE(?String1:17),LEFT
         LINE,AT(573,2229,7292,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s12),AT(7073,2031,781,156),USE(par_ban_kods),LEFT
         STRING(@s3),AT(4552,1083,313,156),USE(BVAL),TRN,RIGHT
         STRING('Izkrauðanas vieta'),AT(760,1792),USE(?String77:2),LEFT
         STRING(@s60),AT(1823,1792,3406,208),USE(izkr_vieta),LEFT
         STRING('PVN:'),AT(6427,646,313,208),USE(?String1:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,1844,2604,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Kods :'),AT(6698,2031,365,156),USE(?String1:15),LEFT
         STRING(@s21),AT(5281,2031,1406,156),USE(par_ban_nr),LEFT
         STRING(@s37),AT(5344,1563,2396,208),USE(PAR_REG_NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(4854,2031,350,156),USE(?String1:14),RIGHT
         STRING('Konts'),AT(4854,1083,365,156),USE(?String1:9),RIGHT
         STRING(@s12),AT(7073,1083,781,156),USE(BKODS),LEFT
         LINE,AT(573,1302,7292,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('04. Preèu saòçmçjs'),AT(635,1333,1094,208),USE(?String1:6),LEFT
         STRING(@s21),AT(5281,1083,1406,156),USE(REK),LEFT
         STRING('Kods :'),AT(6698,1083,365,156),USE(?String1:7),LEFT
         LINE,AT(5260,927,2604,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Iekrauðanas vieta'),AT(760,875),USE(?String77),LEFT
         STRING(@s60),AT(1823,875,3385,177),USE(iekr_vieta),LEFT
         STRING(@s45),AT(1823,417,3375,208),USE(RPT_client),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(5313,417,313,208),USE(?String1:8),RIGHT
         STRING('NMR:'),AT(5333,646,313,208),USE(?String1:16),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6792,646,833,208),USE(fin_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('03. Norçíinu rekvizîti'),AT(635,1083,1094,208),USE(?String1:3),LEFT
         STRING(@s31),AT(1823,1083,2031,208),USE(BANKA),LEFT
         LINE,AT(5260,365,2604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5260,365,0,1875),USE(?Line81),COLOR(COLOR:Black)
         STRING(@s31),AT(1823,2031,2031,156),USE(par_banka),LEFT
         STRING(@s60),AT(1823,1563,3365,208),USE(adrese1),LEFT
         STRING(@s45),AT(1823,1354,3406,208),USE(PAR_nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,2229,0,490),USE(?Line8),COLOR(COLOR:Black)
         STRING('Saimn. dar. apraksts:'),AT(625,2260,1094,156),USE(?StringSDA),TRN,LEFT
         STRING('06. Norçíinu rekvizîti'),AT(635,2031,1094,156),USE(?String1:4),LEFT
         STRING('Kods'),AT(5313,1354,313,208),USE(?String1:13),RIGHT
         STRING('05. Adrese'),AT(625,1563,1094,208),USE(?String1:11),LEFT
         STRING(@s11),AT(5667,646,740,208),USE(reg_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1823,646,3385,208),USE(adrese),LEFT
         STRING('01. Preèu nosûtîtâjs'),AT(635,417,1094,208),USE(?String1),LEFT
         STRING('02. Adrese'),AT(635,646,677,208),USE(?String1:2),LEFT
       END
PAGE_HEAD1 DETAIL,AT(,,,354)
         LINE,AT(4688,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5521,52,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(6354,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7552,52,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(875,104,3229,208),USE(?String38:2),CENTER
         STRING('10. Mçrv.'),AT(4146,104,521,208),USE(?String38:5),CENTER
         STRING('11. Daudzums'),AT(4719,104,781,208),USE(?String38:6),CENTER
         STRING('12. Cena'),AT(5552,104,781,208),USE(?String38:4),CENTER
         STRING('13. Summa'),AT(6396,104,1146,208),USE(?String38:7),CENTER
         STRING('PVN'),AT(7594,94,260,208),USE(?String38:3),LEFT
         LINE,AT(4115,0,0,365),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(573,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(833,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(625,104,188,208),USE(?String38),CENTER
         LINE,AT(573,313,7292,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(4115,-10,0,198),USE(?Line8:12),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line79),COLOR(COLOR:Black)
         STRING(@S15),AT(4740,10,677,156),USE(daudzums_S),RIGHT
         LINE,AT(7552,-10,0,198),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line8:9),COLOR(COLOR:Black)
         STRING(@S15),AT(5573,10,729,156),USE(cena_S),RIGHT
         LINE,AT(6354,-10,0,198),USE(?Line8:19),COLOR(COLOR:Black)
         STRING(@s3),AT(7240,10,260,156),USE(GG_VAL),LEFT
         STRING(@S15),AT(6396,10,781,156),USE(summa_bNS),RIGHT
         LINE,AT(7865,-10,0,198),USE(?Line8:21),COLOR(COLOR:Black)
         STRING(@S3),AT(7625,10,200,156),USE(RPT_PVN_PROC),RIGHT
         STRING(@s50),AT(938,10,3177,156),USE(nosaukums),LEFT
         LINE,AT(833,-10,0,198),USE(?Line8:23),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line8:24),COLOR(COLOR:Black)
         STRING(@s3),AT(615,10,208,156),USE(RPT_npk),CENTER
         STRING(@s7),AT(4167,10,,156),USE(Mervieniba),CENTER
       END
detailT DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(4115,-10,0,198),USE(?Line18:12),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line179),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,198),USE(?Line18:15),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line18:9),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,198),USE(?Line18:19),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line18:21),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,198),USE(?Line18:23),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line18:24),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(573,-10,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,114),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,114),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,114),USE(?Line75),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(4115,-10,0,198),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line8:10),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,198),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@n_12.2),AT(6396,10,781,156),USE(summk_bn),RIGHT
         STRING(@s3),AT(7240,10,260,156),USE(GG:VAL,,?GG:VAL:3),LEFT
         LINE,AT(7552,-10,0,198),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@s15),AT(1146,10,1094,156),USE(kopa),LEFT
         LINE,AT(833,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,177)
         LINE,AT(573,-10,0,62),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,62),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4688,-10,0,62),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,62),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,62),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,62),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,62),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:6),COLOR(COLOR:Black)
       END
RPT_FOOT4 DETAIL,WITHPRIOR(4),AT(,,,885),USE(?unnamed:6)
         STRING(@s40),AT(635,52,2625,208),USE(StringPVN),LEFT
         STRING('18. Pavisam apmaksai'),AT(635,260,2031,208),USE(?String62:6),LEFT
         STRING('(ar cipariem)'),AT(5510,260,677,208),USE(?String62:8),LEFT
         STRING(@n_12.2),AT(6344,260,833,208),USE(sumMk_AN),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7240,260,260,208),USE(GG:VAL,,?GG:VAL:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ar vârdiem)'),AT(635,469,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(635,677,7135,208),USE(sumV),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC),COLOR(0D3D3D3H)
         STRING(@n_12.2),AT(6344,52,833,156),USE(sumMk_PVN),RIGHT
         STRING(@s3),AT(7240,52,260,208),USE(GG:VAL),LEFT
       END
RPT_LS DETAIL,AT(,,,250),USE(?unnamed:LB)
         STRING('Visas cenas Ls pârrçíinâtas pçc Latvijas Bankas kursa :'),AT(635,21,2865,177),USE(?String62:23), |
             LEFT
         STRING(@n_12.6),AT(3510,21),USE(lbkurss),RIGHT
         STRING('Ls /'),AT(4344,21,260,177),USE(?String62:24),LEFT
         STRING(@s3),AT(4594,21,302,177),USE(GG:val,,?GG:val:5),LEFT
       END
RPT_FOOT5 DETAIL,WITHPRIOR(5),AT(,,,1917),USE(?unnamed:5)
         STRING('Z. V.'),AT(729,1667,521,208),USE(?String62:21),LEFT
         STRING('Z. V.'),AT(4427,1667,521,208),USE(?String62:22),LEFT
         LINE,AT(1198,1406,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(4427,1406,2656,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s25),AT(1563,833,1875,208),USE(sys_paraksts),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvadâtâjs,a/m,vadîtâjs:'),AT(625,52,1302,208),USE(?String62:9),LEFT
         STRING(@s80),AT(1927,52,5156,208),USE(parvadatajs),TRN,LEFT
         LINE,AT(573,313,7292,0),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(4115,313,0,1250),USE(?Line76),COLOR(COLOR:Black)
         STRING('20. Pieòçma :'),AT(4271,417,781,208),USE(?String62:13),LEFT
         STRING('19. Izsniedza :'),AT(635,417,781,208),USE(?String62:11),LEFT
         STRING('19. Preèu piegâdes vai pakalpojumu sniegðanas datums:'),AT(625,417,2865,208),USE(?String642:11), |
             LEFT
         STRING('Vârds, uzvârds'),AT(4271,625,885,208),USE(?String62:14),LEFT
         STRING('Vârds, uzvârds'),AT(635,833,885,208),USE(?String62:12),LEFT
         LINE,AT(5156,781,2188,0),USE(?Line77),COLOR(COLOR:Black)
         STRING(@s35),AT(781,573,2240,208),USE(IzsnDatums),LEFT
         STRING('. gada  "'),AT(4771,885,417,208),USE(?String62:17),LEFT
         STRING('"'),AT(5594,885,104,208),USE(?String62:18),LEFT
         LINE,AT(5208,1042,365,0),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(4240,1042,542,0),USE(?Line78:2),COLOR(COLOR:Black)
         LINE,AT(5719,1042,1615,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING('Paraksts'),AT(635,1250,521,208),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(4271,1250,521,208),USE(?String62:20),LEFT
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

List1 Queue,PRE(K)
List    string(21)
     .
List2 Queue,PRE(V)
List    string(21)
     .

window WINDOW('P/Z sagatavoðana'),AT(,,350,340),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),CENTER, |
         GRAY
       OPTION('&Mûsu Banka'),AT(15,4,321,54),USE(MB),BOXED
         RADIO('1'),AT(19,14,156,10),USE(?MB:Radio1),HIDE,VALUE('1')
         RADIO('2'),AT(19,22,156,10),USE(?MB:Radio2),HIDE,VALUE('2')
         RADIO('3'),AT(19,30,156,10),USE(?MB:Radio3),HIDE,VALUE('3')
         RADIO('4'),AT(19,38,156,10),USE(?MB:Radio4),HIDE,VALUE('4')
         RADIO('5'),AT(19,46,156,10),USE(?MB:Radio5),HIDE,VALUE('5')
         RADIO('6'),AT(183,14,149,10),USE(?MB:Radio6),HIDE,VALUE('6')
         RADIO('7'),AT(183,22,149,10),USE(?MB:Radio7),HIDE,VALUE('7')
         RADIO('8'),AT(183,30,149,10),USE(?MB:Radio8),HIDE,VALUE('8')
         RADIO('9'),AT(183,38,149,10),USE(?MB:Radio9),HIDE,VALUE('9')
         RADIO('10'),AT(183,46,149,10),USE(?MB:Radio10),HIDE,VALUE('10')
       END
       OPTION('&Partnera Banka'),AT(15,58,324,22),USE(PB),BOXED
         RADIO('1'),AT(19,69,156,10),USE(?PB:Radio1),HIDE,VALUE('1')
         RADIO('2'),AT(183,69,149,10),USE(?PB:Radio2),HIDE,VALUE('2')
       END
       PROMPT('Pârvadâtâjs,a/m,vadîtâjs:'),AT(17,82),USE(?Prompt2)
       BUTTON('Mçs'),AT(103,80,35,11),USE(?ButtonMes)
       BUTTON('Pircçjs'),AT(140,80,35,11),USE(?ButtonPircejs)
       ENTRY(@s80),AT(15,92,307,11),USE(parvadatajs,,?PARVADATAJS:1)
       STRING('Samaksas veids:'),AT(13,112),USE(?String2)
       LIST,AT(70,109,77,12),USE(SamaksasVeids,,?SamaksasVeids:1),DROP(10),FROM(List1)
       STRING('Samaksas kârtîba :'),AT(151,110),USE(?String19)
       LIST,AT(219,108,87,12),USE(SamaksasKartiba,,?SamaksasKartiba:1),DROP(10),FROM(List2)
       ENTRY(@s7),AT(300,137,37,10),USE(MERVIENIBA,,?MERVIENIBA:1)
       PROMPT('&Mçrvienîba'),AT(301,127,42,10),USE(?Mçrvienîba:Prompt1)
       BUTTON('Aiz&vietot P/Z tekstu ar Dokumenta saturu'),AT(13,125,143,14),USE(?Aizvietot)
       STRING('Daudzums'),AT(217,127),USE(?String13)
       STRING('Summa '),AT(260,127),USE(?String14)
       ENTRY(@s50),AT(13,141,207,11),USE(PrecuNosaukums[1])
       ENTRY(@n3.1B),AT(225,141,17,11),USE(PrecuDaudzums[1]),CENTER
       STRING(@n_12.2B),AT(247,141),USE(PrecuSumma[1])
       ENTRY(@s50),AT(13,154,207,11),USE(PrecuNosaukums[2])
       ENTRY(@n3.1B),AT(225,154,17,11),USE(PrecuDaudzums[2]),CENTER
       STRING(@n_12.2B),AT(247,154),USE(PrecuSumma[2])
       ENTRY(@s50),AT(13,167,207,11),USE(PrecuNosaukums[3])
       ENTRY(@n3.1B),AT(225,167,17,11),USE(PrecuDaudzums[3]),CENTER
       STRING(@n_12.2B),AT(247,167),USE(PrecuSumma[3])
       ENTRY(@s50),AT(13,181,207,11),USE(PrecuNosaukums[4])
       ENTRY(@n3.1B),AT(225,181,17,11),USE(PrecuDaudzums[4]),CENTER
       STRING(@n_12.2B),AT(247,181),USE(PrecuSumma[4])
       ENTRY(@s50),AT(13,194,207,11),USE(PrecuNosaukums[5])
       ENTRY(@n3.1B),AT(225,194,17,11),USE(PrecuDaudzums[5]),CENTER
       STRING(@n_12.2B),AT(247,194),USE(PrecuSumma[5])
       ENTRY(@s50),AT(13,206,207,11),USE(PrecuNosaukums[6])
       ENTRY(@n3.1B),AT(225,206,17,11),USE(PrecuDaudzums[6]),CENTER
       STRING(@n_12.2B),AT(247,206),USE(PrecuSumma[6])
       ENTRY(@s50),AT(13,218,207,11),USE(PrecuNosaukums[7])
       ENTRY(@n3.1B),AT(225,218,17,11),USE(PrecuDaudzums[7]),CENTER
       STRING(@n_12.2B),AT(247,218),USE(PrecuSumma[7])
       ENTRY(@s50),AT(13,231,207,11),USE(PrecuNosaukums[8])
       ENTRY(@n3.1B),AT(225,231,17,11),USE(PrecuDaudzums[8]),CENTER
       STRING(@n_12.2B),AT(247,231),USE(PrecuSumma[8])
       ENTRY(@s50),AT(13,245,207,11),USE(PrecuNosaukums[9])
       ENTRY(@n3.1B),AT(225,245,17,11),USE(PrecuDaudzums[9]),CENTER
       STRING(@n_12.2B),AT(247,245),USE(PrecuSumma[9])
       ENTRY(@s50),AT(13,258,207,11),USE(PrecuNosaukums[10])
       ENTRY(@n3.1B),AT(225,258,17,11),USE(PrecuDaudzums[10]),CENTER
       STRING(@n_12.2B),AT(247,258),USE(PrecuSumma[10])
       STRING('PVN % :'),AT(247,274),USE(?String15)
       STRING(@s60),AT(98,274,142,10),USE(IZKR_VIETA,,?IZKR_VIETA:2)
       BUTTON('Izkrauðanas vieta'),AT(12,271,81,14),USE(?ButtonIzkV),DISABLE
       ENTRY(@N2),AT(276,272,15,10),USE(PVN_PROC,,?PVN_PROC:1)
       OPTION('Pavadzîmi drukât kâ'),AT(115,287,81,42),USE(PUZ),BOXED
         RADIO('SUP'),AT(119,300,73,10),USE(?PUZ:Radio1),VALUE('S')
         RADIO('A4'),AT(119,310,42,10),USE(?PUZ:Radio2),VALUE('A')
       END
       OPTION('Paraksts:'),AT(13,287,100,42),USE(sys_paraksts_nr),BOXED
         RADIO('Nav'),AT(17,296,37,10),USE(?sys_paraksts_nr:OPTION0),VALUE('0')
         RADIO('1.paraksts'),AT(16,305,47,10),USE(?sys_paraksts_nr:OPTION1),VALUE('1')
         RADIO('2.paraksts'),AT(16,315,45,10),USE(?sys_paraksts_nr:OPTION2),VALUE('2')
         RADIO('3.paraksts'),AT(62,306,45,10),USE(?sys_paraksts_nr:OPTION3),VALUE('3')
         RADIO('Login'),AT(62,316,45,10),USE(?sys_paraksts_nr:OPTION4),VALUE('4')
       END
       BUTTON('D&rukas parametri'),AT(257,294,78,14),USE(?Button:DRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       BUTTON('&OK'),AT(257,310,40,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(300,310,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(system,1)
  IF GGK::USED=0 THEN CHECKOPEN(GGK,1).
  GGK::USED+=1
  IF PAR_K::USED=0 THEN CHECKOPEN(PAR_K,1).
  PAR_K::USED+=1
  IF KON_K::USED=0 THEN CHECKOPEN(KON_K,1).
  KON_K::USED+=1
  IF BANKAS_K::USED=0 THEN CHECKOPEN(BANKAS_K,1).
  BANKAS_K::USED+=1
  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  FilesOpened = True

  K:LIST='Pârskaitîjums'
  ADD(LIST1)
  K:LIST='Skaidrâ naudâ'
  ADD(LIST1)
  K:LIST='Barters'
  ADD(LIST1)

  V:LIST='Priekðapmaksa'
  ADD(LIST2)
  V:LIST='Pçcapmaksa'
  ADD(LIST2)
  V:LIST='Konsignâcija'
  ADD(LIST2)
  V:LIST='Tûlîtçja'
  ADD(LIST2)
  V:LIST='Apmaksa nav paredzçta'
  ADD(LIST2)

  Mervieniba='gab.'
  SamaksasVeids='Pârskaitîjums'
  SamaksasKartiba='Priekðapmaksa'
  gads=year(gg:dokdat)
  datums=day(gg:dokdat)
  MENVAR=MENVAR(gg:dokdat,2,2)
  SAKUMS#=12
  KESKA=' {60}'
  KESKA[SAKUMS#:SAKUMS#+30]=GADS&'.  gada  '&clip(datums)&'.  '&menvar
!  IzsnDatums = GADS&'. gada '&clip(datums)&'. '&clip(menvar)&' '&format(clock(),@t1)
  IzsnDatums = GADS&'. gada '&clip(datums)&'. '&clip(menvar)
  PAR_NOS_P=GETPAR_K(GG:PAR_NR,2,6)
  RPT_CLIENT=CLIENT
  ADRESE=GL:ADRESE
  IEKR_VIETA=SYS:ADRESE
  reg_nr=gl:reg_nr
  fin_nr=gl:VID_nr
  ATLAUJA =SYS:ATLAUJA
  par_reg_nr=GETPAR_K(GG:PAR_NR,0,21)
  ADRESE1=PAR:ADRESE
  IZKR_VIETA=PAR:ADRESE
  PVN_PROC=SYS:NOKL_PVN
  PVNMASMODE=0
  STRINGPVN='17. Pievienotâs vçrtîbas nodoklis '&CLIP(SYS:NOKL_PVN)&'%'
  IF ~(GG:VAL='Ls' OR GG:VAL='LVL')     ! VALÛTAS P/Z PARÂDAM Ls
     LBKURSS=BANKURS(GG:VAL,GG:DATUMS,1)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P/Z'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:U_NR=GG:U_NR
      SET(GGK:NR_KEY,GGK:NR_KEY)
      Process:View{Prop:Filter} = 'GGK:U_NR=GG:U_NR'
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
   OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GGK:BKK[1]='6' OR (GGK:D_K='K' AND GGK:BKK[1]='7')
           IF GGK:BKK[1]='7' THEN ATGRIEZTA='Preèu atgrieðana'.
           I#+=1
           IF I#<=10
              PrecuNosaukums[i#]=GETKON_K(GGK:BKK,2,2)
              PrecuDaudzums[i#]=1
              PrecuSumma[i#]=ggk:summaV
              PrecuPVN[i#]=ggk:pvn_proc
           ELSE
              STOP('RAKSTI VAIRÂK KÂ 10...')
           .
        ELSIF GGK:BKK[1:4]='5721' OR GGK:BKK[1:4]='2399' !PVN KONTS
           CASE GGK:PVN_PROC
           OF 18
              PVN[1]+=GGK:SUMMAV
           OF 21
           OROF 22
              PVNMASMODE=1 !JAUNAIS%
!              STRINGPVN='17. Pievienotâs vçrtîbas nodoklis 21%'
              STRINGPVN='17. Pievienotâs vçrtîbas nodoklis '&GGK:PVN_PROC&'%'
              PVN_PROC=GGK:PVN_PROC
              PVN[1]+=GGK:SUMMAV
           ELSE
              KLUDA(0,'BASE pavadzîmes izdrukâ tikai 18/21/22% PVN...')
           .
!              OF 9
!                 PVN[2]+=GGK:SUMMAV
!                 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                    PVN2[2]+=GGK:SUMMA
!                 .
!              OF 5
!                 PVN[4]+=GGK:SUMMAV
!                 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                    PVN2[4]+=GGK:SUMMA
!                 .
!              ELSE !lietotâja kïûda, uzskatam par neapliekamu
!                 PVN[3]+=GGK:SUMMAV
!                 IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                    PVN2[3]+=GGK:SUMMA
!                 .
        ELSIF GGK:BKK=SYS:K_PVN
           SamaksasKartiba='Pçcapmaksa'
        ELSIF GGK:BKK[1:3]='261'
           SamaksasVeids='Skaidrâ Naudâ'
           SamaksasKartiba='Tûlîtçja'
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

  OPEN(window)
  WindowOpened=True
  IF ~BAND(SYS:BAITS1,00001000B)
     PUZ='S' !DRUKÂT SUP
  ELSE
     PUZ='A' !A4
  .
  MB=SYS:NOKL_B
  PB=SYS:NOKL_PB
  LOOP I#=1 TO 10
     IF GL:BKODS[I#]
        BAN_NOS_P=GETBANKAS_K(GL:BKODS[I#],0,1)
        EXECUTE I#
           ?MB:Radio1{Prop:Text}=BAN_NOS_P
           ?MB:Radio2{Prop:Text}=BAN_NOS_P
           ?MB:Radio3{Prop:Text}=BAN_NOS_P
           ?MB:Radio4{Prop:Text}=BAN_NOS_P
           ?MB:Radio5{Prop:Text}=BAN_NOS_P
           ?MB:Radio6{Prop:Text}=BAN_NOS_P
           ?MB:Radio7{Prop:Text}=BAN_NOS_P
           ?MB:Radio8{Prop:Text}=BAN_NOS_P
           ?MB:Radio9{Prop:Text}=BAN_NOS_P
           ?MB:Radio10{Prop:Text}=BAN_NOS_P
        .
        EXECUTE I#
           UNHIDE(?MB:Radio1)
           UNHIDE(?MB:Radio2)
           UNHIDE(?MB:Radio3)
           UNHIDE(?MB:Radio4)
           UNHIDE(?MB:Radio5)
           UNHIDE(?MB:Radio6)
           UNHIDE(?MB:Radio7)
           UNHIDE(?MB:Radio8)
           UNHIDE(?MB:Radio9)
           UNHIDE(?MB:Radio10)
        END
     .
  .
  C#=GETPAR_K(GG:PAR_NR,2,12)
  IF PAR:BAN_KODS
     ?PB:Radio1{Prop:Text}=Getbankas_k(PAR:BAN_KODS,0,1)
     UNHIDE(?PB:Radio1)
  .
  IF PAR:BAN_KODS2
     ?PB:Radio2{Prop:Text}=Getbankas_k(PAR:BAN_KODS2,0,1)
     UNHIDE(?PB:Radio2)
  .
  IF ~(IZKR_VIETA=GETPAR_ADRESE(PAR:U_NR,1,0,0)) !IR ARÎ CITAS(vismaz 1.) ADRESES
     ENABLE(?BUTTONIzkV)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY()
      SELECT(?OkButton)
    OF EVENT:GainFocus
      DISPLAY()
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?Aizvietot
      CASE EVENT()
      OF EVENT:Accepted
         PrecuNosaukums[1]=gg:saturs
         PrecuNosaukums[2]=gg:saturs2
         loop i#=3 to 10
            PrecuNosaukums[i#]=''
         .
         DISPLAY()
      .
    OF ?ButtonMes
      CASE EVENT()
      OF EVENT:Accepted
         PARVADATAJS=CLIP(CLIENT)&' '&GL:VID_NR
         IF ACC_KODS_N=0 THEN PARVADATAJS=CLIP(PARVADATAJS)&' HH4675 Mâris Viesis'.
         DISPLAY
      .
    OF ?ButtonPircejs
      CASE EVENT()
      OF EVENT:Accepted
         PARVADATAJS=CLIP(PAR_NOS_P)&' '&GETPAR_K(GG:PAR_NR,0,13)
         DISPLAY
      .
    OF ?ButtonIzkV
      CASE EVENT()
      OF EVENT:Accepted
         PAR_ADR_NR#+=1
         IZKR_VIETA=GETPAR_ADRESE(PAR:U_NR,PAR_ADR_NR#,0,0) !atgrieþ adresi pçc PAR_ADR_NR# vai par:adrese
         IF IZKR_VIETA=PAR:ADRESE THEN PAR_ADR_NR#=0.
         display()
      .
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
       BREAK
       END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
         DO PROCEDURERETURN
      END
    END
  END
  CLOSE(WINDOW)
  IF SEND(GGK,'QUICKSCAN=off').
  NOKL_B=MB
  GETMYBANK('')
  clear(ban:record)
  CASE PB
  OF 2
     ban:kods=par:ban_kods2
     par_ban_nr=par:ban_nr2
  ELSE
     ban:kods=par:ban_kods
     par_ban_nr=par:ban_nr
  .
  get(bankas_k,ban:kod_key)
  par_ban_kods=ban:kods
  par_banka=ban:nos_p
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  IF LocalResponse = RequestCompleted     !?
    IF ~GG:DOK_SENR                               
       IF (~INSTRING(SYS:PZ_SERIJA,'-') AND ~INRANGE(GG:PAR_NR,26,50)) OR | !A4 UN NAV RAÞOÐANA
          (INSTRING(SYS:PZ_SERIJA,'-') AND ~INRANGE(GG:PAR_NR,0,50))        !SUP UN NAV 0,IP,RAÞOÐANA
          GG:DOK_SENR=CLIP(SYS:PZ_SERIJA)&' '&FORMAT(PERFORMGL(8),@N06B)    !PIEÐÍIRAM P/Z NR
          IF RIUPDATE:GG()
             KLUDA(24,'GG')
          .
       .
    .
    IF INRANGE(GG:PAR_NR,1,50)
       SDA='Iekðçjâ preèu pârvietoðana'
    ELSIF SamaksasKartiba='Konsignâcija' OR SamaksasKartiba='Apmaksa nav paredzçta'
       SamaksasVeids=''
       SDA='Izsniegðana citam nodokïu maksâtâjam'
    ELSE
       SDA='Preèu piegâde(pârdoðana)'
    .

    OPEN(report)
    report{Prop:Preview} = PrintPreviewImage
    IF PUZ='A' !DRUKÂT UZ A4 LAPAS
       SETTARGET(REPORT)
       IMAGE(188,281,2083,521,'USER.BMP')
       DOK_SENR=''
       pavadzime='pavadzîme '&CLIP(GG:dok_seNR)
    ELSE     !DRUKÂT UZ VEIDLAPAS
       DOK_SENR=CLIP(GG:dok_seNR)
       pavadzime=''
    .
    PRINT(RPT:DETAIL0)
    PRINT(RPT:PAGE_HEAD)
    PRINT(RPT:PAGE_HEAD1)
    LOOP I#=1 TO 10
       IF PrecuNosaukums[i#] OR PrecuSumma[i#]
           Nosaukums = PrecuNosaukums[i#]  !ja nosaukums 2-âs rindâs
           IF PrecuSumma[i#]
              Daudzums=PrecuDaudzums[i#]
              DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
              IF PrecuDaudzums[i#]=0
                 cena = PrecuSumma[i#]
              else
                 cena = PrecuSumma[i#]/PrecuDaudzums[i#]
              .
              CENA_S=CUT0(CENA,5,2)
              SUMMA_BN = PrecuSumma[i#]
              SUMMA_BNS=CUT0(SUMMA_BN,4,2)
              IF SUMMA_BNS[15]='0'
                 SUMMA_BNS[15]=CHR(32)
                 IF SUMMA_BNS[14]='0'
                    SUMMA_BNS[14]=CHR(32)
                 END
              END
              SUMMK_BN+= PrecuSumma[i#]
              GG_VAL=GG:VAL
              RPT_PVN_PROC=CLIP(PrecuPVN[i#])&'%'
              IF PrecuPVN[i#]            !PIEÒEMAM, KA VAR BÛT TIKAI VIENS PVN%
                 PVN_PROC=PrecuPVN[i#]
                 AplSumma+=PrecuSumma[i#]
              .
              NPK+=1
              IF NPK<99
                RPT_NPK=FORMAT(NPK,@N2)&'.'
              ELSE
                RPT_NPK=FORMAT(NPK,@N3)
              .
           ELSE
              RPT_NPK=''
              MERVIENIBA=''
              DAUDZUMS_S=''
              CENA_S=''
              SUMMA_BNS=''
              GG_VAL=''
              RPT_PVN_PROC=''
           .
           PRINT(RPT:DETAIL)
        ELSE
           PRINT(RPT:DETAILT)
       .
    .
    PRINT(RPT:RPT_FOOT1)
    kopa='Kopâ:'
    IF PVN[1]
       SUMMK_PVN=PVN[1]
    ELSE
       SUMMK_PVN=AplSumma*(PVN_PROC/100)
    .
    SUMMK_AN=SUMMK_BN+SUMMK_PVN
    PRINT(RPT:RPT_FOOT2)
    PRINT(RPT:RPT_FOOT3)
    SUMV=SUMVAR(SUMMK_AN,GG:VAL,0)
    PRINT(RPT:RPT_FOOT4)
    IF ~(GG:VAL='Ls' OR GG:VAL='LVL')     ! VALÛTAS P/Z SPECIÂLA RINDA
       PRINT(RPT:RPT_LS)
    .
    PRINT(RPT:RPT_FOOT5)

    if ~inrange(summk_an-gg:summa,-0.01,0.01)
      kluda(74,1)
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
    GGK::USED-=1
    IF GGK::USED=0 THEN CLOSE(GGK).
    PAR_K::USED-=1
    IF PAR_K::USED=0 THEN CLOSE(PAR_K).
    KON_K::USED-=1
    IF KON_K::USED=0 THEN CLOSE(KON_K).
    BANKAS_K::USED-=1
    IF BANKAS_K::USED=0 THEN CLOSE(BANKAS_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  FREE(LIST1)
  FREE(LIST2)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% '
      DISPLAY()
    END
  END
DarbaZurnals         PROCEDURE                    ! Declare Procedure
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
FDBF                 STRING(1)
OPC   BYTE
OPC1  BYTE

window WINDOW,AT(,,147,86),GRAY
       OPTION,AT(5,6,138,60),USE(opc),BOXED
         RADIO('Tekoðâ moduïa darba þurnâls'),AT(8,16),USE(?Option1:Radio1),VALUE('1')
         RADIO('Sistçmas vienoto failu darba þurnâls'),AT(8,28,132,10),USE(?Option1:Radio2),VALUE('2')
         RADIO('Operatoru darba analîze'),AT(8,40),USE(?Option1:Radio3),DISABLE,VALUE('3')
         RADIO('Kases darba þurnâls'),AT(8,52,132,10),USE(?Option1:Radio4),DISABLE,VALUE('4')
       END
       BUTTON('&OK'),AT(71,68,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(108,68,36,14),USE(?CancelButton)
     END
windowNOM_K WINDOW,AT(,,147,86),GRAY
       OPTION,AT(5,6,138,60),USE(opc1),BOXED
         RADIO('Visas izmaiòas'),AT(8,16),USE(?Opt1:Radio1),VALUE('1')
         RADIO('Tikai Partneri'),AT(8,28),USE(?Opt1:Radio2),DISABLE,VALUE('2')
         RADIO('Tikai Nomenklatûras'),AT(8,40,132,10),USE(?Opt1:Radio3),DISABLE,VALUE('3')
         RADIO('Tikai cenu maiòa Nomenklatûrâm'),AT(8,52,132,10),USE(?Opt1:Radio4),DISABLE,VALUE('4')
       END
       BUTTON('&OK'),AT(71,68,35,14),USE(?OkButton1),DEFAULT
       BUTTON('&Atlikt'),AT(108,68,36,14),USE(?CancelButton1)
     END

T_TABLE     QUEUE,PRE(T)
OPER           STRING(8)
REQ            USHORT,DIM(3)
            .
REQ     BYTE


  CODE                                            ! Begin processed code
  TTAKA"=LONGPATH()
  USERFOLDER='C:\WINLATS\'&CLIP(ACC_KODS)
  SETPATH(USERFOLDER)
  IF ERROR()
     SECURITY_ATT.nLength=Len(SECURITY_ATT)
     SECURITY_ATT.lpSecurityDescriptor=0
     SECURITY_ATT.bInheritHandle=1
     USERFOLDER='C:\WINLATS'
     I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
     USERFOLDER='C:\WINLATS\'&CLIP(ACC_KODS)
     I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
  .
  SETPATH(TTAKA")
  OPC=1
  OPEN(WINDOW)
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?OPTION1:RADIO3)
  .
  IF INRANGE(JOB_NR,16,40) !NOLIKTAVA
     ENABLE(?OPTION1:RADIO4)
  .
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OkButton
        CASE EVENT()
        OF EVENT:Accepted
           BREAK
        END
     OF ?CancelButton
        CASE EVENT()
        OF EVENT:Accepted
           CLOSE(WINDOW)
           RETURN
        END
     END
  END
  CLOSE(WINDOW)
  EXECUTE OPC
     FILENAME1=DZNAME
     DO FAILI     !FAILI
     DO OPDAU     !OPERATORI
     FILENAME1='DZKA'&FORMAT(JOB_NR,@N02)  !KASE
  .
  FILENAME2=USERFOLDER&'\ZURNALS.TXT'
  IF ~CopyFileA(FILENAME1,FILENAME2,0)
     KLUDA(3,FILENAME1&' uz '&FILENAME2)
  .
  RUN('WORDPAD '&FILENAME2)
  IF RUNCODE()=-4
     KLUDA(88,'Wordpad.exe')
  .

!------------------------------------------------------------
OPDAU           ROUTINE
  OPCIJA='00110000000000000000'
!            12345678901234567890
  IZZFILTN
  IF GlobalResponse = RequestCompleted
     CHECKOPEN(ZURNALS,1)
     SET(ZURNALS)
     LOOP
        NEXT(ZURNALS)
        IF ERROR() THEN BREAK.
        IF ~INRANGE(DEFORMAT(ZUR:LINE[10:19],@D06.),S_DAT,B_DAT) THEN CYCLE.
        CASE ZUR:LINE[27:31]
        OF 'Ievad'
           REQ=1
        OF 'Mainu'
           REQ=2
        OF 'Dzçðu'
           REQ=3
        ELSE
           CYCLE
        .
        T:OPER=ZUR:LINE[1:8]
        GET(T_TABLE,T:OPER)
        IF ERROR()
           CLEAR(T:REQ)
           T:REQ[REQ]=1
           ADD(T_TABLE)
           SORT(T_TABLE,T:OPER)
        ELSE
           T:REQ[REQ]+=1
           PUT(T_TABLE)
        .
     .
     IF ~OPENANSI('DZOPER.TXT')
       KLUDA(0,'Atverot DZOPER.TXT')
     .
     OUTA:LINE=CLIENT
     ADD(OUTFILEANSI)
     OUTA:LINE=format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
     ADD(OUTFILEANSI)
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     LOOP I#=1 TO RECORDS(T_TABLE)
        GET(T_TABLE,I#)
        OUTA:LINE=T:OPER&CHR(9)&'Ievadîti:'&CHR(9)&T:REQ[1]&CHR(9)&'Mainîti:'&CHR(9)&T:REQ[2]&CHR(9)&'Dzçsti:'&CHR(9)&T:REQ[3]
        ADD(OUTFILEANSI)
     .
     FREE(T_TABLE)
     F:DBF='E'
     ANSIJOB
     RETURN
  .
!------------------------------------------------------------
FAILI           ROUTINE
  FILENAME1=DZFNAME
  OPC1=1
  OPEN(WINDOWNOM_K)
  IF INRANGE(JOB_NR,16,40) !NOLIKTAVA
     ENABLE(?OPT1:RADIO4)
  .
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OkButton1
        CASE EVENT()
        OF EVENT:Accepted
           BREAK
        END
     OF ?CancelButton1
        CASE EVENT()
        OF EVENT:Accepted
           CLOSE(WINDOWNOM_K)
           RETURN
        END
     END
  END
  CLOSE(WINDOWNOM_K)
  IF OPC1=4 !NOM_CENAS
     OPCIJA='00110000000000000000'
   !            12345678901234567890
     IZZFILTN
     IF GlobalResponse = RequestCompleted
        IF ~OPENANSI('NOM_CENAS.TXT')
          KLUDA(0,'Atverot NOM_CENAS.TXT')
        .
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        CLOSE(ZURNALS)
        DZNAME=DZFNAME
        CHECKOPEN(ZURNALS,1)
        SET(ZURNALS)
        LOOP
           NEXT(ZURNALS)
           IF ERROR() THEN BREAK.
           IF ~INRANGE(DEFORMAT(ZUR:LINE[10:19],@D06.),S_DAT,B_DAT) THEN CYCLE.
!           STOP(ZUR:LINE[10:19]&' '&ZUR:LINE[41:45]&' '&INSTRING('C1:',ZUR:LINE))
           IF ~(ZUR:LINE[41:45]='NOM_K') THEN CYCLE.
           IF ~INSTRING('C1:',ZUR:LINE,1) THEN CYCLE.
           OUTA:LINE=ZUR:LINE
           ADD(OUTFILEANSI)
        .
!        F:DBF='E'
!        ANSIJOB     !PAZUDUÐI TABi
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
           KLUDA(88,'Wordpad.exe')
        .
        RETURN
     .
  .




Browsegg2 PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
DOK_SK               USHORT
KONT_SK              USHORT
LIST1:QUEUE          QUEUE,PRE()
AVOTS1               STRING(20)
                     END
LIST2:QUEUE          QUEUE,PRE()
AVOTS2               STRING(20)
                     END
D                    STRING(3)
MAINFOLDER           STRING(20)
MAINFILE             STRING(20)
gg_dok_nr            STRING(7)
!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts       LONG,AUTO
Auto::Save:GG:U_NR   LIKE(GG:U_NR)
ES                   DECIMAL(1)
Process              STRING(35)

K_TABLE  QUEUE,PRE(K)
SUMMA          DECIMAL(14,5)
SUMMAV         DECIMAL(14,5)
BKK            STRING(5)
PVN_PROC       DECIMAL(2)
VAL            STRING(3)
         .
SUMMAV         DECIMAL(14,5)
PAR_N          DECIMAL(4)
BKK            STRING(5)
DELTA          DECIMAL(11,2)
KOKUPVN        REAL
PVNMAKS        BYTE
JAUEXP         STRING(1)
NODALA         STRING(1)
STRINGBYTE     STRING(8)

Askscreen WINDOW('Caption'),AT(,,159,92),GRAY
       STRING('Importçt visus dokumentus'),AT(10,12),USE(?String1)
       SPIN(@d6),AT(24,26,48,12),USE(s_dat)
       SPIN(@d6),AT(94,26,48,12),USE(B_DAT)
       STRING('kam ES='),AT(17,44),USE(?String4)
       ENTRY(@n1),AT(47,43),USE(ES),CENTER
       STRING('un Y='),AT(65,44),USE(?string:RS),HIDE
       ENTRY(@n1),AT(91,43),USE(RS),HIDE,CENTER
       STRING(@s35),AT(11,60),USE(process)
       STRING('lîdz'),AT(78,27),USE(?String3)
       STRING('no'),AT(11,28),USE(?String2)
       BUTTON('&OK'),AT(76,73,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(118,72,36,14),USE(?CancelButton)
     END
SourceScreen WINDOW('Norâdiet datu avotu'),AT(,,185,79),GRAY
       LIST,AT(22,15),USE(avots1),VSCROLL,DROP(10),FROM(List1:Queue)
       LIST,AT(101,15),USE(avots2),VSCROLL,DROP(10),FROM(List2:Queue)
       ENTRY(@s20),AT(22,32,66,12),USE(AVOTS1,,?AVOTS1:2),HIDE
       STRING(@s40),AT(22,47),USE(FILENAME1)
       BUTTON('&OK'),AT(106,60,35,14),USE(?Ok1),DEFAULT
       BUTTON('Atlikt'),AT(145,60,36,14),USE(?Cancel1)
     END

BRW1::View:Browse    VIEW(G2)
                       PROJECT(G2:RS)
                       PROJECT(G2:ES)
                       PROJECT(G2:DOK_NR)
                       PROJECT(G2:DATUMS)
                       PROJECT(G2:NOKA)
                       PROJECT(G2:SATURS)
                       PROJECT(G2:SUMMA)
                       PROJECT(G2:REFERENCE)
                       PROJECT(G2:DOKDAT)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::G2:RS            LIKE(G2:RS)                ! Queue Display field
BRW1::G2:ES            LIKE(G2:ES)                ! Queue Display field
BRW1::G2:DOK_NR        LIKE(G2:DOK_NR)            ! Queue Display field
BRW1::G2:DATUMS        LIKE(G2:DATUMS)            ! Queue Display field
BRW1::G2:NOKA          LIKE(G2:NOKA)              ! Queue Display field
BRW1::G2:SATURS        LIKE(G2:SATURS)            ! Queue Display field
BRW1::G2:SUMMA         LIKE(G2:SUMMA)             ! Queue Display field
BRW1::G2:REFERENCE     LIKE(G2:REFERENCE)         ! Queue Display field
BRW1::G2:DOKDAT        LIKE(G2:DOKDAT)            ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(G2:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(G2:DATUMS)              ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(G2:DATUMS)             ! Queue position of scroll thumb
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Browse the G2 File'),AT(0,0,402,244),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BROWSEGG1'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(9,21,379,187),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('11C|M~Y~@n1b@11C|M~ES~@n1b@28R(1)|M~Dok Nr~C(0)@s7@46R(1)|M~Datums~C(0)@D6@60L(1' &|
   ')|M~Partneris~C(0)@s15@180L(1)|M~Saturs~C(0)@s45@60D(12)|M~Summa~C(0)@n-15.2@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,4,398,223),USE(?CurrentTab)
                         TAB('Importa intrefeiss'),USE(?Tab:2)
                           BUTTON('ES'),AT(20,210,13,14),USE(?ButtonES)
                           BUTTON('Kontçjums'),AT(70,210,45,14),USE(?kontejums),DISABLE
                           BUTTON('Importçt apgabalu'),AT(223,210,77,14),USE(?ButtonImpApg)
                           BUTTON('Importçt izvçlçto &rakstu'),AT(302,210,86,14),USE(?impRakstu)
                         END
                       END
                       BUTTON('&Beigt'),AT(355,229,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  D=SUB(PATH(),1,3)
  IF INRANGE(JOB_NR,1,15)
     avots1='LATS1999'
     ADD(LIST1:QUEUE)
     avots1='LATS2000'
     ADD(LIST1:QUEUE)
     avots1='LATS2001'
     ADD(LIST1:QUEUE)
     IF ACC_KODS_N=0
        avots1='LATS1999A'
        ADD(LIST1:QUEUE)
        avots1='LATS2000A'
        ADD(LIST1:QUEUE)
        avots1='LATS2001A'
        ADD(LIST1:QUEUE)
     .
     avots1='LATS2002'
     ADD(LIST1:QUEUE)
     avots1='A:\'
     ADD(LIST1:QUEUE)
     avots1='B:\'
     ADD(LIST1:QUEUE)
     avots1='Cits'
     ADD(LIST1:QUEUE)
     GET(LIST1:QUEUE,3)
     LOOP I#= 1 TO BASE_SK
          AVOTS2='Bâze      '&FORMAT(I#,@N02)
          ADD(LIST2:QUEUE)
     .
     LOOP I#= 1 TO NOL_SK
       AVOTS2='Noliktava '&FORMAT(I#,@N02)
       ADD(LIST2:QUEUE)
     .
     GET(LIST2:QUEUE,BASE_SK+1)
     MAINFOLDER=D&CLIP(AVOTS1)
     IF AVOTS2[1]='B'
        MAINFILE='\GG'&AVOTS2[11:12]&'.DAT'
     ELSIF AVOTS2[1]='N'
        MAINFILE='\GGN'&AVOTS2[11:12]&'.DAT'
     .
     FILENAME1=CLIP(MAINFOLDER)&CLIP(MAINFILE)
     OPEN(SourceScreen)
     display
     ACCEPT
        CASE FIELD()
        OF ?AVOTS1
           CASE EVENT()
           OF EVENT:ACCEPTED
              UNHIDE(?AVOTS2)
              CASE AVOTS1
              OF 'Cits'
                 HIDE(?AVOTS2)
                 TTAKA"=PATH()
                 MAINFILE=''
                 F#=FILEDIALOG('...TIKAI GG.DAT FAILI !!!',FILENAME1,'CLARION|*.DAT',0)
                 SETPATH(TTAKA")
  !               STOP(FILENAME1)
              OF 'A:\'
                 MAINFOLDER='A:\'
                 FILENAME1=CLIP(MAINFOLDER)&CLIP(MAINFILE)
              OF 'B:\'
                 MAINFOLDER='B:\'
                 FILENAME1=CLIP(MAINFOLDER)&CLIP(MAINFILE)
              ELSE
                 MAINFOLDER=D&'WINLATS\'&CLIP(AVOTS1)
                 FILENAME1=CLIP(MAINFOLDER)&CLIP(MAINFILE)
              .
              DISPLAY
           .
        OF ?AVOTS2
           CASE EVENT()
           OF EVENT:ACCEPTED
              IF AVOTS2[1]='B'
                 MAINFILE='\GG'&AVOTS2[11:12]&'.TPS'
              ELSIF AVOTS2[1]='N'
                 MAINFILE='\GGN'&AVOTS2[11:12]&'.TPS'
              .
              FILENAME1=CLIP(MAINFOLDER)&CLIP(MAINFILE)
              DISPLAY
           .
        OF ?OK1
           CASE EVENT()
           OF EVENT:ACCEPTED
             SELECT(1)
             SELECT
             LOOP I#=LEN(FILENAME1)-1 TO 2 BY -1     !NODAÏAS NAFTAI
                IF UPPER(FILENAME1[I#-2:I#])='BEN'
                   NODALA=FILENAME1[I#+1]
                   IF NUMERIC(FILENAME1[I#+2])
                      EXECUTE(FILENAME1[I#+1])
                         NODALA=CHR(49+16+FILENAME1[I#+2])  !49=1 65=A [A-J]
                         NODALA=CHR(50+25+FILENAME1[I#+2])  !50=2 75=K [K-P]
                      .
                   .
                   BREAK
                .
             .
             LOOP I#=LEN(FILENAME1)-1 TO 2 BY -1
                IF UPPER(FILENAME1[I#-1:I#])='GG'
                   FILENAME2=FILENAME1[1:I#]&'K'&FILENAME1[I#+1:LEN(FILENAME1)]
                   FOUND#=1
                   BREAK
                .
             .
             IF ~FOUND#
                KLUDA(27,FILENAME1)
                CYCLE
             .
             LOCALRESPONSE=REQUESTCOMPLETED
             BREAK
           .
        OF ?CANCEL1
           CASE EVENT()
           OF EVENT:ACCEPTED
             LOCALRESPONSE=REQUESTCANCELLED
             CLOSE(SourceScreen)
             DO PROCEDURERETURN
           .
        .
     .
     CLOSE(SourceScreen)
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  QUICKWINDOW{PROP:TEXT}='Datu avots: '&filename1
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?ButtonES
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
           EXECUTE G2:ES+1
              G2:ES=1
              G2:ES=2
              G2:ES=0
           .
           IF RIUPDATE:G2()
              KLUDA(24,'G2')
           .
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           SELECT(?Browse:1)
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
      END
    OF ?kontejums
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?ButtonImpApg
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(ASKSCREEN)
        IF ATLAUTS[1]
           UNHIDE(?String:RS)
           UNHIDE(?RS)
        END
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?OkButton
              CASE EVENT()
              OF EVENT:Accepted
                 DO SyncWindow
                 DOK_SK=0
                 KONT_SK=0
                 FIRST#=1
                 CLEAR(G2:RECORD)
                 G2:DATUMS=S_DAT
                 SET(G2:DAT_KEY,G2:DAT_KEY)
                 LOOP
                    NEXT(G2)
                    IF ERROR() OR G2:DATUMS > B_DAT THEN BREAK.
                    IF G2:NR=1 THEN CYCLE.
                    IF ~(ES=G2:ES) THEN CYCLE.
                    IF ~(RS=G2:RS) THEN CYCLE.
        
                    DO AUTONUMBER
        
                    GG:Es                   = G2:ES
                    GG:Imp_nr               = G2:imp_nr
                    GG:Tips                 = 0
                    GG:Dok_seNR             = CLIP(G2:DOK_SE)&' '&G2:DOK_NR
                    IF CL_NR=1235          !ASTARTES NAFTA
                       GG:ATT_DOK='1'
                    .
                    GG:Noka                 = G2:NOKA
                    GG:Par_nr               = G2:par_nr
                    GG:APMdat               = G2:dokdat
                    GG:Dokdat               = G2:dokdat
                    GG:Datums               = G2:datums
                    GG:APMdat               = GG:Datums+GETPAR_K(GG:Par_nr,0,27,GG:Datums)
                    GG:Saturs               = G2:SATURS
                    GG:Saturs2              = G2:saturs2
                    GG:Saturs3              = G2:saturs3
        !            GG:Summa                = G2:summa   ÐITO SKAITA WRITEGGK
                    GG:Val                  = G2:NOS
                    GG:Keksis               = G2:keksis
                    GG:ACC_KODS             = G2:OPERATORS
                    GG:ACC_DATUMS           = G2:i_datums
                    GG:U_NR                 = Auto::Save:GG:U_NR
                    GG:SECIBA               = CLOCK()
        
                    CLEAR(GK2:RECORD)
                    GK2:NR=G2:NR
                    SET(GK2:NR_KEY,GK2:NR_KEY)
                    STRINGBYTE=''
                    DO WRITEGGK
                 !   GG:IMP_NR=CON_NR
                    GG:TIPS=0
                    LOOP B#=1 TO 8
                      IF STRINGBYTE[9-B#]
                         GG:TIPS+=2^(B#-1)
                      .
                    .
                    IF RIUPDATE:GG()
                       KLUDA(24,'GG')
                    ELSE
                       DOK_SK+=1
                       PROCESS='Kopâ: '&CLIP(DOK_SK)&' dokumenti '&clip(kont_sk)&' kontçjumi'
                       display(?process)
                       G2:ES=1
                       IF RIUPDATE:G2()
                          KLUDA(24,'G2')
                       .
                    .
                 .
                 ?CancelButton{prop:text}='Beigt'
                 HIDE(?OKBUTTON)
                 DISPLAY
              .
           OF ?CancelButton
              CASE EVENT()
              OF EVENT:Accepted
                 IF DOK_SK
                    LOCALRESPONSE=REQUESTCOMPLETED
                 ELSE
                    LOCALRESPONSE=REQUESTCANCELLED
                 .
                 break
              END
           END
        .
        CLOSE(ASKSCREEN)
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
        POST(Event:NewSelection)
      END
    OF ?impRakstu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF G2:NR=1            !SALDO
           KLUDA(18,'Eksistçjoðais SALDO ieraksts tiks aizvietots')
           IF KLU_DARBIBA   !AIZVIETOT
              clear(gg:record)
              GG:U_NR=1
              GET(GG,GG:NR_KEY)
              IF ERROR()
                  STOP('MEKLÇJOT GG UNR=1')
                  DO PROCEDURERETURN
              .
              GG:SUMMA=0
              CLEAR(GGK:RECORD)
              GGK:U_NR=1
              SET(GGK:NR_KEY,GGK:NR_KEY)
              LOOP
                 NEXT(GGK)
                 IF ERROR() OR ~(GGK:U_NR=1)
                    BREAK
                 .
                 DELETE(GGK)
                 IF ERROR() THEN STOP(ERROR()).
              .
              CLEAR(GK1:RECORD)
              GK1:U_NR=1
              DO WRITEGGK
              PUT(GG)
              IF ERROR() THEN STOP(ERROR()).
           .
        ELSE       ! importçt izvçlçto rakstu
          DO AUTONUMBER
          execute G2:RS+1
            GG:Rs                 = ''
            GG:RS                 = '1'
          .
          GG:Es                   = G2:ES
          GG:Imp_nr               = G2:imp_nr
          GG:Tips                 = 0
        !  GG:Dok_se               = G2:DOK_SE
        !  GG_Dok_nr               = ''
        !  LOOP I#=1 TO 7
        !     IF G2:DOK_NR[I#] AND ~(INSTRING(G2:DOK_NR[I#],'-.'))
        !        IF NUMERIC(G2:DOK_NR[I#])
        !           GG_Dok_nr      = CLIP(GG_DOK_NR)&G2:DOK_NR[I#]
        !        .
        !     .
        !  .
        !  GG:Dok_nr               = RIGHT(GG_Dok_nr)
          GG:Dok_seNR             = CLIP(G2:DOK_SE)&' '&G2:DOK_NR
          IF CL_NR=1235          !ASTARTES NAFTA
             GG:ATT_DOK='1'
          .
          GG:Noka                 = G2:NOKA
          GG:Par_nr               = G2:par_nr
        !  GG:APMdat               = G2:dokdat1
          GG:Dokdat               = G2:dokdat
          GG:Datums               = G2:datums
          GG:APMdat               = GG:Datums+GETPAR_K(GG:Par_nr,0,27,GG:Datums)
          GG:Saturs               = G2:SATURS
          GG:Saturs2              = G2:saturs2
          GG:Saturs3              = G2:saturs3
        !  GG:Summa                = G2:summa  ÐITO SKAITA WRITEGGK
          GG:Val                  = G2:NOS
          GG:Keksis               = G2:keksis
          GG:ACC_KODS             = G2:OPERATORS
          GG:ACC_DATUMS           = G2:i_datums
        
          GG:U_NR=Auto::Save:GG:U_NR
          KONT_SK=0
          CLEAR(GK2:RECORD)
          GK2:NR=G2:NR
        
          DO WRITEGGK
        
        !   GG:IMP_NR=CON_NR
          IF RIUPDATE:GG()
             KLUDA(24,'GG')
          ELSE
             DOK_SK=1
             KLUDA(7,CLIP(DOK_SK)&' dokuments '&clip(kont_sk)&' kontçjumi',,1)
             G2:ES=1
             PUT(G1)
          .
        .
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
        POST(Event:NewSelection)
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF G2::Used = 0
    CheckOpen(G2,1)
  END
  G2::Used += 1
  BIND(G2:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF GK2::Used = 0
    CheckOpen(GK2,1)
  END
  GK2::Used += 1
  BIND(GK2:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('Browsegg2','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
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
    G2::Used -= 1
    IF G2::Used = 0 THEN CLOSE(G2).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    GK2::Used -= 1
    IF GK2::Used = 0 THEN CLOSE(GK2).
  END
  IF WindowOpened
    INISaveWindow('Browsegg2','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
Autonumber ROUTINE
  Auto::Attempts = 0
  LOOP
    SET(GG:NR_KEY)
    PREVIOUS(GG)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:GG:U_NR = 1
    ELSE
      Auto::Save:GG:U_NR = GG:U_NR + 1
    END
    clear(GG:Record)
    GG:DATUMS=b_dat
    GG:U_NR = Auto::Save:GG:U_NR
    ADD(GG)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END

WRITEGGK ROUTINE
   GG:SUMMA=0

   SET(GK2:NR_KEY,GK2:NR_KEY)
   LOOP
      NEXT(GK2)
      IF ERROR() OR ~(GK2:NR=G2:NR)
         BREAK
      .
      GGK:U_nr                = GK2:NR
      GGK:Rs                  = GK2:rs
      GGK:Datums              = GK2:datums
      GGK:Par_nr              = GK2:par_nr
      GGK:Reference           = GK2:REF_NR
      GGK:NODALA              = NODALA
      GGK:Bkk                 = GK2:BKK
      GGK:D_k                 = GK2:d_k
      GGK:Summa               = GK2:summa
      GGK:Summav              = GK2:summav
      GGK:Val                 = GK2:NOS
      GGK:Pvn_proc            = GK2:P2
      GGK:Pvn_tips            = GK2:P4
      GGK:BAITS               = GK2:P3  ! IEZAKS
      GGK:Kk                  = GK2:KK
      GGK:OBJ_NR              = 0
      GGK:U_NR=GG:U_NR
      IF GGK:D_K='D'
         GG:SUMMA+=GGK:SUMMA
      .
      ADD(GGK)
      IF ERROR()
         STOP(ERROR())
      ELSE
         KONT_SK+=1
!         GETKON_K(GK1:BKK)
      .
   .

!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'G2')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = G2:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'G2')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = G2:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  G2:RS = BRW1::G2:RS
  G2:ES = BRW1::G2:ES
  G2:DOK_NR = BRW1::G2:DOK_NR
  G2:DATUMS = BRW1::G2:DATUMS
  G2:NOKA = BRW1::G2:NOKA
  G2:SATURS = BRW1::G2:SATURS
  G2:SUMMA = BRW1::G2:SUMMA
  G2:REFERENCE = BRW1::G2:REFERENCE
  G2:DOKDAT = BRW1::G2:DOKDAT
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  BRW1::G2:RS = G2:RS
  BRW1::G2:ES = G2:ES
  BRW1::G2:DOK_NR = G2:DOK_NR
  BRW1::G2:DATUMS = G2:DATUMS
  BRW1::G2:NOKA = G2:NOKA
  BRW1::G2:SATURS = G2:SATURS
  BRW1::G2:SUMMA = G2:SUMMA
  BRW1::G2:REFERENCE = G2:REFERENCE
  BRW1::G2:DOKDAT = G2:DOKDAT
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => G2:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(G2:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(G2:DATUMS,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            G2:DATUMS = CHR(KEYCHAR())
            CLEAR(G2:REFERENCE)
            CLEAR(G2:DOKDAT)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      G2:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'G2')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(G2:DAT_KEY)
      RESET(G2:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(G2:DAT_KEY,G2:DAT_KEY)
    END
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
  ELSE
    CLEAR(G2:Record)
    BRW1::CurrentChoice = 0
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(G2:DAT_KEY)
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

