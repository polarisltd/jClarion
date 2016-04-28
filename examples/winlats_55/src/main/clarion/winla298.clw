                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_Tabele             PROCEDURE                    ! Declare Procedure
!---------------------------------------------------------------------------
DIENA       decimal(4,1)
NAKTS       decimal(4,1)
D           USHORT,DIM(31)
SvNaktsSt   USHORT
SvetkuSt    USHORT
Atv         USHORT
Slim        USHORT
DienSt      USHORT
NaktsSt     USHORT
VirsSt      USHORT
SvNaktsStN  USHORT
SvetkuStN   USHORT
AtvN        USHORT
SlimN       USHORT
DienStN     USHORT
NaktsStN    USHORT
VirsStN     USHORT
SvNaktsStK  USHORT
SvetkuStK   USHORT
AtvK        USHORT
SlimK       USHORT
DienStK     USHORT
NaktsStK    USHORT
VirsStK     USHORT
CAL_STUNDAS     STRING(1)
SLODZE          DECIMAL(5,3)
Darba_stundas   DECIMAL(3)
STUNDAS         DECIMAL(3)

X_TABLE  QUEUE,PRE(X)
DATUMS  LONG
PAZIME  STRING(1)
         .

SEKTORS              STRING(2)     ! Tekoðais sektors
NPK                  USHORT        ! Numurs pçc kârtas
NPS                  USHORT        ! Numurs tek. sektorâ
CIL_SK               USHORT        ! Izdrukâtais cilv. skaits. tek. sektorâ.
NOD_SK               USHORT        ! Izdrukâto NODAÏU SKAITS
SAV_NODALA           STRING(2)
VUT                  STRING(25)
KOPA_IZMAKSAT        DECIMAL(10,2)
RPT_GADS             DECIMAL(4)    ! vajag
NUMURS               DECIMAL(3)
ALGA                 DECIMAL(10,2)
SOCPAB               DECIMAL(9,2)
SLIM                 DECIMAL(9,2)
ATVALIN              DECIMAL(9,2)
CITIP                DECIMAL(9,2)
CITIP2               DECIMAL(9,2)
PKOPA                DECIMAL(10,2)
NODOKLI              DECIMAL(9,2)
SOCAPDR              DECIMAL(9,2)
IZP                  DECIMAL(9,2)
CITI_ATV1            DECIMAL(9,2)
CITI_ATV2            DECIMAL(9,2)
CITI_ATV3            DECIMAL(9,2)
AVANS                DECIMAL(9,2)
CITIET               DECIMAL(9,2)
IZMAKS               DECIMAL(10,2)
PARADS               STRING(6)
SEALGA               DECIMAL(10,2)
SESOCPAB             DECIMAL(9,2)
SESLIM               DECIMAL(9,2)
SEATVALIN            DECIMAL(9,2)
SECITIP              DECIMAL(9,2)
SECITIP2             DECIMAL(9,2)
SEPKOPA              DECIMAL(10,2)
SENODOKLI            DECIMAL(9,2)
SESOCAPDR            DECIMAL(9,2)
SEIZP                DECIMAL(9,2)
SECITI_ATV1          DECIMAL(9,2)
SECITI_ATV2          DECIMAL(9,2)
SECITI_ATV3          DECIMAL(9,2)
SEAVANS              DECIMAL(9,2)
SECITIET             DECIMAL(9,2)
SEIZMAKS             DECIMAL(10,2)
SEPARADS             DECIMAL(10,2)
KOALGA               DECIMAL(10,2)
KOSOCPAB             DECIMAL(9,2)
KOSLIM               DECIMAL(9,2)
KOATVALIN            DECIMAL(9,2)
KOCITIP              DECIMAL(9,2)
KOCITIP2             DECIMAL(9,2)
KOPKOPA              DECIMAL(10,2)
KONODOKLI            DECIMAL(9,2)
KOSOCAPDR            DECIMAL(9,2)
KOIZP                DECIMAL(9,2)
KOCITI_ATV1          DECIMAL(9,2)
KOCITI_ATV2          DECIMAL(9,2)
KOCITI_ATV3          DECIMAL(9,2)
KOAVANS              DECIMAL(9,2)
KOCITIET             DECIMAL(9,2)
KOIZMAKS             DECIMAL(10,2)
KOPARADS             DECIMAL(10,2)
SUMMA_V              STRING(120)
SUMMA_V1             STRING(120)

VIRSRAKSTS           STRING(80)

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

!---------------------------------------------------------------------------
report REPORT,AT(104,2135,12000,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(104,146,12000,1990),USE(?unnamed)
         LINE,AT(10150,1240,0,739),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('. gada "___"_{24}'),AT(1729,467,2635,208),USE(?String3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3229,10,4635,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10104,760,573,208),PAGENO,USE(?PageCount:2),RIGHT !         LINE,AT(6406,625,2073,0),USE(?Line50),COLOR(COLOR:Black)
         STRING('Dienas'),AT(9031,1542,333,417),USE(?String12:5),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(9100,1240,1750,0),USE(?Line141),COLOR(COLOR:Black)
         STRING(@s25),AT(5417,510,1615,208),USE(SYS:AMATS2),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(8521,542,1677,208),USE(sys:paraksts2),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darbinieks'),AT(729,1521,1323,208),USE(?String12:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nostrâdâtas stundas'),AT(9219,1031,1552,198),USE(?String12:4),CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçneða diena'),AT(4583,1219,2448,156),USE(?String3:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10850,1020,0,959),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Nakts'),AT(9375,1594,333,375),USE(?String12:7),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(6600,1521,0,469),USE(?Line5:31),COLOR(COLOR:Black)
         LINE,AT(10500,1240,0,739),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(9800,1240,0,739),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(9450,1240,0,739),USE(?Line3:443),COLOR(COLOR:Black)
         LINE,AT(9100,1020,0,959),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(52,1020,10798,0),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1979,10798,0),USE(?Line9:3),COLOR(COLOR:Black)
         LINE,AT(2200,1510,6200,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2200,1020,0,959),USE(?Line5:1),COLOR(COLOR:Black)
         LINE,AT(2400,1510,0,469),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(2600,1510,0,469),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(2800,1510,0,469),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(3000,1510,0,469),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(3200,1510,0,469),USE(?Line5:6),COLOR(COLOR:Black)
         LINE,AT(3400,1510,0,469),USE(?Line5:7),COLOR(COLOR:Black)
         STRING('1'),AT(2210,1656,180,156),USE(?String1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(2410,1656,180,156),USE(?String2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2610,1656,180,156),USE(?String3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(2810,1656,180,156),USE(?String4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(3010,1656,180,156),USE(?String5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3600,1510,0,469),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(3800,1510,0,469),USE(?Line5:9),COLOR(COLOR:Black)
         LINE,AT(4000,1510,0,469),USE(?Line5:10),COLOR(COLOR:Black)
         LINE,AT(4200,1510,0,469),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(4400,1510,0,469),USE(?Line5:12),COLOR(COLOR:Black)
         LINE,AT(4600,1510,0,469),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(4800,1510,0,469),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(5000,1510,0,469),USE(?Line5:15),COLOR(COLOR:Black)
         LINE,AT(5200,1510,0,469),USE(?Line5:16),COLOR(COLOR:Black)
         LINE,AT(5400,1510,0,469),USE(?Line5:17),COLOR(COLOR:Black)
         LINE,AT(5600,1510,0,469),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(5800,1510,0,469),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(6000,1510,0,469),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(6200,1510,0,469),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(6400,1510,0,469),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(6800,1510,0,469),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(7000,1510,0,469),USE(?Line5:34),COLOR(COLOR:Black)
         LINE,AT(7200,1510,0,469),USE(?Line5:24),COLOR(COLOR:Black)
         LINE,AT(7400,1510,0,469),USE(?Line5:25),COLOR(COLOR:Black)
         LINE,AT(7600,1510,0,469),USE(?Line5:26),COLOR(COLOR:Black)
         LINE,AT(7800,1510,0,469),USE(?Line5:27),COLOR(COLOR:Black)
         LINE,AT(8000,1510,0,469),USE(?Line5:28),COLOR(COLOR:Black)
         LINE,AT(8200,1510,0,469),USE(?Line5:29),COLOR(COLOR:Black)
         LINE,AT(8400,1020,0,959),USE(?Line3:55),COLOR(COLOR:Black)
         LINE,AT(8750,1020,0,959),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(333,1021,0,959),USE(?Line3:61),COLOR(COLOR:Black)
         STRING('Npk'),AT(73,1521,260,208),USE(?String12:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ID'),AT(354,1521,208,208),USE(?String12:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,1021,0,959),USE(?Line3:58),COLOR(COLOR:Black)
         STRING('Atvaïinâjums, d.'),AT(8333,1052,333,927),USE(?String12:39),TRN,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('6'),AT(3210,1656,180,156),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(3410,1656,180,156),USE(?String7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(3610,1656,180,156),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(3810,1656,180,156),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(4010,1656,180,156),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(4210,1656,180,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(4410,1656,180,156),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(4610,1656,180,156),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(4810,1656,180,156),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15'),AT(5010,1656,180,156),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16'),AT(5210,1656,180,156),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('17'),AT(5410,1656,180,156),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('18'),AT(5610,1656,180,156),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('19'),AT(5810,1656,180,156),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('20'),AT(6010,1656,180,156),USE(?String20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('21'),AT(6210,1656,180,156),USE(?String21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('22'),AT(6410,1656,180,156),USE(?String22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('23'),AT(6610,1656,180,156),USE(?String23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('24'),AT(6810,1656,180,156),USE(?String24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('25'),AT(7010,1656,180,156),USE(?String25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('26'),AT(7210,1656,180,156),USE(?String26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('27'),AT(7410,1656,180,156),USE(?String27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('28'),AT(7610,1656,180,156),USE(?String28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('29'),AT(7810,1656,180,156),USE(?String29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('30'),AT(8010,1656,180,156),USE(?String30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('31'),AT(8210,1656,180,156),USE(?String31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Svçtku nakts'),AT(10448,1260,333,708),USE(?String12:6),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Svçtku'),AT(10073,1542,333,438),USE(?String12:9),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Virsstundas'),AT(9729,1260,333,719),USE(?String12:8),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Slimîba, d.'),AT(8688,1344,333,635),USE(?String12:3),TRN,LEFT,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(52,1979,10,0),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s25),AT(5417,302,1615,208),USE(SYS:AMATS1),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(8521,313,1677,208),USE(sys:paraksts1),LEFT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7052,417,1458,0),USE(?Line51:2),COLOR(COLOR:Black)
         STRING(@s80),AT(2458,760,6188,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1020,0,959),USE(?Line3:25),COLOR(COLOR:Black)
       END
NOD_HEAD DETAIL,AT(,,,208),USE(?unnamed:4)
         LINE,AT(52,0,0,229),USE(?Line56),COLOR(COLOR:Black)
         STRING('Nodaïa Nr'),AT(1042,10,625,156),USE(?String12:24),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(1677,10,156,156),USE(alg:NODALA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10850,0,0,229),USE(?Line56:5),COLOR(COLOR:Black)
         LINE,AT(333,0,0,229),USE(?Line561:3),COLOR(COLOR:Black)
         LINE,AT(573,0,0,229),USE(?Line561:2),COLOR(COLOR:Black)
         LINE,AT(52,208,10798,0),USE(?Line31),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,219),USE(?unnamed:3)
         LINE,AT(52,-10,0,229),USE(?Line3:28),COLOR(COLOR:Black)
         LINE,AT(2200,-10,0,229),USE(?Line103),COLOR(COLOR:Black)
         LINE,AT(2400,-10,0,229),USE(?Line104),COLOR(COLOR:Black)
         LINE,AT(2600,-10,0,229),USE(?Line105),COLOR(COLOR:Black)
         LINE,AT(2800,-10,0,229),USE(?Line106),COLOR(COLOR:Black)
         LINE,AT(3000,-10,0,229),USE(?Line107),COLOR(COLOR:Black)
         LINE,AT(3200,-10,0,229),USE(?Line108),COLOR(COLOR:Black)
         LINE,AT(3400,-10,0,229),USE(?Line109),COLOR(COLOR:Black)
         LINE,AT(3600,-10,0,229),USE(?Line110),COLOR(COLOR:Black)
         LINE,AT(3800,-10,0,229),USE(?Line111),COLOR(COLOR:Black)
         LINE,AT(4000,-10,0,229),USE(?Line112),COLOR(COLOR:Black)
         LINE,AT(4200,-10,0,229),USE(?Line113),COLOR(COLOR:Black)
         LINE,AT(4400,-10,0,229),USE(?Line114),COLOR(COLOR:Black)
         LINE,AT(4600,-10,0,229),USE(?Line115),COLOR(COLOR:Black)
         LINE,AT(4800,-10,0,229),USE(?Line116),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,229),USE(?Line117),COLOR(COLOR:Black)
         LINE,AT(5200,-10,0,229),USE(?Line118),COLOR(COLOR:Black)
         LINE,AT(5400,-10,0,229),USE(?Line119),COLOR(COLOR:Black)
         LINE,AT(5600,-10,0,229),USE(?Line120),COLOR(COLOR:Black)
         LINE,AT(5800,-10,0,229),USE(?Line121),COLOR(COLOR:Black)
         LINE,AT(6000,-10,0,229),USE(?Line122),COLOR(COLOR:Black)
         LINE,AT(6200,-10,0,229),USE(?Line123),COLOR(COLOR:Black)
         LINE,AT(6400,-10,0,229),USE(?Line124),COLOR(COLOR:Black)
         LINE,AT(6600,-10,0,229),USE(?Line125),COLOR(COLOR:Black)
         LINE,AT(6800,-10,0,229),USE(?Line126),COLOR(COLOR:Black)
         LINE,AT(7000,-10,0,229),USE(?Line127),COLOR(COLOR:Black)
         LINE,AT(7200,-10,0,229),USE(?Line128),COLOR(COLOR:Black)
         LINE,AT(7400,-10,0,229),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(7600,-10,0,229),USE(?Line130),COLOR(COLOR:Black)
         LINE,AT(7800,-10,0,229),USE(?Line131),COLOR(COLOR:Black)
         LINE,AT(8000,-10,0,229),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(8200,-10,0,229),USE(?Line133),COLOR(COLOR:Black)
         LINE,AT(8400,-10,0,229),USE(?Line134),COLOR(COLOR:Black)
         STRING(@n2),AT(2210,10,180,156),USE(D[1]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(2410,10,180,156),USE(D[2]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(2610,10,180,156),USE(D[3]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(2810,10,180,156),USE(D[4]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3010,10,180,156),USE(d[5]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3210,10,180,156),USE(d[6]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3410,10,180,156),USE(d[7]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3610,10,180,156),USE(d[8]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3810,10,180,156),USE(d[9]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(4010,10,180,156),USE(d[10]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(4210,10,180,156),USE(d[11]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(4410,10,180,156),USE(d[12]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(4610,10,180,156),USE(d[13]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(4810,10,180,156),USE(d[14]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5010,10,180,156),USE(d[15]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5210,10,180,156),USE(d[16]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5410,10,180,156),USE(d[17]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5610,10,180,156),USE(d[18]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(5810,10,180,156),USE(d[19]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(6010,10,180,156),USE(d[20]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(6210,10,180,156),USE(d[21]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(6410,10,180,156),USE(d[22]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(6610,10,180,156),USE(d[23]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(6810,10,180,156),USE(d[24]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(7010,10,180,156),USE(d[25]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(7210,10,180,156),USE(d[26]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(7410,10,180,156),USE(d[27]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(7610,10,180,156),USE(d[28]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(7810,10,180,156),USE(d[29]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(8010,10,180,156),USE(d[30]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(8210,10,180,156),USE(d[31]),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9100,-10,0,229),USE(?Line3:51),COLOR(COLOR:Black)
         LINE,AT(10500,-10,0,229),USE(?Line3:53),COLOR(COLOR:Black)
         LINE,AT(10850,-10,0,229),USE(?Line3:47),COLOR(COLOR:Black)
         STRING(@n4),AT(73,10,260,156),USE(NPK),RIGHT
         LINE,AT(333,-10,0,229),USE(?Line3:62),COLOR(COLOR:Black)
         STRING(@n3),AT(354,10,208,156),USE(NPS),RIGHT
         LINE,AT(573,-10,0,229),USE(?Line3:59),COLOR(COLOR:Black)
         LINE,AT(52,208,10,0),USE(?Line33:2),COLOR(COLOR:Black)
         STRING(@n3),AT(10531,10,313,156),USE(SvNaktsSt),CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n3),AT(10177,10,313,156),USE(SvetkuSt),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n2),AT(8427,10,313,156),USE(Atv),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n2),AT(8781,10,313,156),USE(Slim),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n3),AT(9135,10,313,156),USE(DienSt),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n3),AT(9479,10,313,156),USE(NaktsSt),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(8750,-10,0,229),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(9450,-10,0,229),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(9800,-10,0,229),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(10150,-10,0,229),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@n3),AT(9823,10,313,156),USE(VirsSt),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s25),AT(615,10,1583,156),USE(vut),LEFT
         LINE,AT(52,219,10798,0),USE(?Line9:5),COLOR(COLOR:Black)
       END
NOD_FOOT DETAIL,AT(,,,219),USE(?unnamed:5)
         LINE,AT(52,-10,0,229),USE(?Line3:29),COLOR(COLOR:Black)
         STRING(@N3),AT(10531,10,313,156),USE(SvNaktsStN),CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n5),AT(9479,10,313,156),USE(NaktsStN),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n4),AT(8427,10,313,156),USE(AtvN),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n4),AT(8781,10,313,156),USE(SlimN),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n5),AT(9135,10,313,156),USE(DienStN),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n3),AT(9823,10,313,156),USE(VirsStN),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(573,-10,0,229),USE(?Line3:60),COLOR(COLOR:Black)
         LINE,AT(10500,-10,0,229),USE(?Line3:48),COLOR(COLOR:Black)
         LINE,AT(9100,-10,0,229),USE(?Line3:52),COLOR(COLOR:Black)
         LINE,AT(9800,-10,0,229),USE(?Line3:54),COLOR(COLOR:Black)
         LINE,AT(10150,-10,0,229),USE(?Line3:49),COLOR(COLOR:Black)
         LINE,AT(333,-10,0,229),USE(?Line3:63),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,229),USE(?Line3:57),COLOR(COLOR:Black)
         LINE,AT(9450,-10,0,229),USE(?Line3:42),COLOR(COLOR:Black)
         STRING('Kopâ pa nodaïu :'),AT(938,10,1198,156),USE(?String12:25),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,208,10,0),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(8400,-10,0,229),USE(?Line3:40),COLOR(COLOR:Black)
         STRING(@n3),AT(10177,10,313,156),USE(SvetkuStN),CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(10850,-10,0,229),USE(?Line3:41),COLOR(COLOR:Black)
         LINE,AT(2200,-10,0,229),USE(?Line3:30),COLOR(COLOR:Black)
         LINE,AT(52,219,10798,0),USE(?Line9:5),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,604),USE(?unnamed:2)
         STRING(@n4),AT(9823,21,313,156),USE(VirsStK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n5),AT(9135,21,313,156),USE(DienStK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n5),AT(9479,21,313,156),USE(NaktsStK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n4),AT(8427,21,313,156),USE(AtvK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n4),AT(8781,21,313,156),USE(SlimK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(52,-10,0,219),USE(?Line13:29),COLOR(COLOR:Black)
         STRING(@n3),AT(10531,21,313,156),USE(SvNaktsStK),CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@n3),AT(10177,21,313,156),USE(SvetkuStK),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(9450,-10,0,219),USE(?Line13:42),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,219),USE(?Line13:421),COLOR(COLOR:Black)
         LINE,AT(10500,-10,0,219),USE(?Line13:422),COLOR(COLOR:Black)
         LINE,AT(9800,-10,0,219),USE(?Line13:423),COLOR(COLOR:Black)
         LINE,AT(10150,-10,0,219),USE(?Line13:424),COLOR(COLOR:Black)
         LINE,AT(333,-10,0,219),USE(?Line13:30),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,219),USE(?Line13:301),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(938,10,1198,156),USE(?String12:31),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,208,10,0),USE(?Line133:2),COLOR(COLOR:Black)
         LINE,AT(9100,-10,0,219),USE(?Line13:499),COLOR(COLOR:Black)
         LINE,AT(8400,-10,0,219),USE(?Line13:40),COLOR(COLOR:Black)
         LINE,AT(10850,-10,0,219),USE(?Line13:41),COLOR(COLOR:Black)
         LINE,AT(2200,-10,0,219),USE(?Line13:302),COLOR(COLOR:Black)
         LINE,AT(52,209,10798,0),USE(?Line9:4),COLOR(COLOR:Black)
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

  CHECKOPEN(SYSTEM,1)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1

  IF GRAFIKS::Used = 0
    CheckOpen(GRAFIKS,1)
  END
  GRAFIKS::Used += 1


  BIND(ALG:RECORD)
  BIND(ALP:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Tabele'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='DARBA LAIKA UZSKAITES TABELE Nr '&MONTH(ALP:YYYYMM)&'  '&YEAR(ALP:YYYYMM)&'. gada '&MENVAR(ALP:YYYYMM,2,2)
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=ALP:YYYYMM
      ALG:NODALA=F:NODALA
      SET(ALG:NOD_KEY,ALG:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
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
      RPT_GADS=YEAR(ALP:YYYYMM)
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer

      SvNaktsStK  = 0
      SvetkuStK   = 0
      AtvK        = 0
      SlimK       = 0
      DienStK     = 0
      NaktsStK    = 0
      VirsStK     = 0


      LOOP RecordsPerCycle TIMES
        LOOP I#=1 TO 31
          D[I#] = 0
        .
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        IF ~(SAV_NODALA = ALG:NODALA)    !MAINÎJUSIES NODALA
          IF CIL_SK>1                   !VAIRÂK PAR 1 CILVÇKU NODAÏÂ
             PRINT(RPT:NOD_FOOT)
             NOD_SK+=1                   !SKAITAM, CIK IR NODAÏU
          .
          PRINT(RPT:NOD_head)
          NPS = 0
          SAV_NODALA = ALG:NODALA
          SvNaktsSt   = 0
          SvetkuSt    = 0
          Atv         = 0
          Slim        = 0
          DienSt      = 0
          NaktsSt     = 0
          VirsSt      = 0
          SvNaktsStN  = 0
          SvetkuStN   = 0
          AtvN        = 0
          SlimN       = 0
          DienStN     = 0
          NaktsStN    = 0
          VirsStN     = 0
        .
        NUMURS += 1
        CIL_SK +=1
        VUT      = GETKADRI(ALG:ID,2,1)
        S# = DATE(MONTH(ALG:YYYYMM),1,YEAR(ALG:YYYYMM))
        B# = DATE(MONTH(ALG:YYYYMM)+1,1,YEAR(ALG:YYYYMM))-1


        CHECKOPEN(PERNOS,1)
        FREE(X_TABLE)
        CLEAR(PER:RECORD)
        PER:ID=ALG:ID
        SET(PER:ID_KEY,PER:ID_KEY)
        LOOP
           NEXT(PERNOS)
           IF ERROR() OR ~(PER:ID=ALG:ID) THEN BREAK.
            IF (PER:PAZIME='S') OR (PER:PAZIME='A')
               LOOP X# = PER:SAK_DAT TO PER:BEI_DAT
                 IF INRANGE(X#,S#,B#)
                    X:DATUMS=X#
                    X:PAZIME=PER:PAZIME
                    GET(X_TABLE,X:DATUMS)
                    IF ERROR()
                       ADD(X_TABLE)
                       SORT(X_TABLE,X:DATUMS)
                    .
                 .
              .
           .
        .

        SvNaktsSt   = 0
        SvetkuSt    = 0
        Atv         = 0
        Slim        = 0
        DienSt      = 0
        NaktsSt     = 0
        VirsSt      = 0

        LOOP L#=1 TO 20
           IF ALG:K[L#]
 !             Stop('L#='&L#)
 !             Stop('ALG:K[L#]='&ALG:K[L#])
              IF ~INRANGE(ALG:K[L#],840,842) AND ~INRANGE(ALG:K[L#],850,852) ! ~ATVAÏINÂJUMS UN ~SLILAPA
                 IF ~GETDAIEV(ALG:K[L#],2,1)
                    CYCLE
                 .
                 IF ~ALG:L[L#]            !~LOCKED
                    STUNDAS =CALCSTUNDAS(ALG:YYYYMM,ALG:ID,1,1,4) !ALG:YYYYMM,ALG:ID-pieò/atl/R40R50,1-atvaï,1-slilapa,4-nostr.stundas
!                    stop('STUNDAS='&STUNDAS)
                    CLEAR(GRA:RECORD)
                    GRA:ID=ALG:ID
                    GRA:YYYYMM = DATE(MONTH(ALG:YYYYMM),1,YEAR(ALG:YYYYMM))
                    GET(GRAFIKS,GRA:ID_DAT)
                    IF ERROR()
                    .

                    SLODZE=GETKADRI(ALG:ID,0,19,ALG:K[L#])
                    IF ~KAD:D_GR_END THEN KAD:D_GR_END=109211.  ! 31/12/2099

!                    stop('SLODZE='&SLODZE)
                    LOOP K#=1 TO 31
                       I# = DATE(MONTH(ALG:YYYYMM),K#,YEAR(ALG:YYYYMM))
!                       Stop('I#='&I#)
                       Cal_stundas=GETCAL(I#)
!                       stop('Cal_stundas='&Cal_stundas)
!                       stop('DAI:F='&DAI:F)
                       IF Cal_stundas=' '    !SVÇTDIENA
                          D[K#]{Prop:Color} = COLOR:RED
                       elsif Cal_stundas='S'    !SESTDIENA
                          D[K#]{Prop:Color} = COLOR:RED
                       ELSE
                          D[K#]{Prop:Color} = COLOR:NONE
                       .
                       CASE DAI:F
                       OF 'CAL'                    !FUNKCIJA NO DLK
!                       OROF 'NAV'
                          Darba_stundas = 0
                          IF INSTRING(CAL_STUNDAS,'012345678')
                             Darba_stundas = Cal_stundas * SLODZE
                             D[K#]+= Darba_stundas
                          .
                          NaktsSt+= 0
                          VirsSt+= 0

                          IF INRANGE(I#,KAD:DARBA_GR,KAD:D_GR_END)  ! VISPÂR IR BIJUÐAS DARBA ATTIECÎBAS
                             IF INSTRING(CAL_STUNDAS,'X')  !SVÇTKU DIENAS DARBA DIENÂS,KAD NAV SLIMOJIS
                                X:DATUMS=I#
                                X:PAZIME=''
                                GET(X_TABLE,X:DATUMS)
                                IF ~X:PAZIME='S' AND ~X:PAZIME='A'
                                   SvNaktsSt+=0
                                   SvetkuSt+=Darba_stundas
                                .
                             .
                             X:DATUMS=I#
                             GET(X_TABLE,X:DATUMS)
                             IF ~ERROR()                             ! SLIMOJIS VAI BIJIS ATVAÏINÂJUMÂ (4)
                                IF INSTRING(CAL_STUNDAS,'012345678') ! VAI SLIMOJIS B_APGABALÂ (7)
                                   IF X:PAZIME='S'             ! VAI SLIMOJIS (10)
                                      Slim+=1
                                   ELSIF X:PAZIME='A'
                                      Atv+=1
                                   .
                                .
                                D[K#]-= Darba_stundas
                             .
                          ELSE                                          ! NAV BIJIS PIEÒEMTS VAI IR ATLAISTS
                             IF INSTRING(CAL_STUNDAS,'012345678')
                                D[K#]-= Darba_stundas
                             .
                          .
                          DienSt+= D[K#]
                       OF 'GRA'                    !FUNKCIJA NO DLK
                          DIENA=0
                          NAKTS=0

                          LOOP L#=1 TO 48
                             IF GRA:G[K#,L#]='*'
                                IF INRANGE(L#,13,44) !DIENA 6:00-20:00
                                   DIENA+=0.5
                                ELSE
                                   NAKTS+=0.5
                                .
                             .
                          .
!                          stop('DIENA'&DIENA)
                          Darba_stundas = DIENA + NAKTS
                          D[K#]+= Darba_stundas
!                          stop('D['&K#&']='&D[K#])

!                          stop('I#'&I#)
!                          stop(KAD:ID)
!                          stop(KAD:DARBA_GR&'-'&KAD:D_GR_END)
                          IF INRANGE(I#,KAD:DARBA_GR,KAD:D_GR_END)  ! VISPÂR IR BIJUÐAS DARBA ATTIECÎBAS
                             IF INSTRING(CAL_STUNDAS,'X')  !SVÇTKU DIENAS DARBA DIENÂS,KAD NAV SLIMOJIS
                                X:DATUMS=I#
                                X:PAZIME=''
                                GET(X_TABLE,X:DATUMS)
                                IF ~X:PAZIME='S' AND ~X:PAZIME='A'
                                   SvNaktsSt+=NAKTS
                                   SvetkuSt+=DIENA
                                .
                             .
                             X:DATUMS=I#
                             GET(X_TABLE,X:DATUMS)
                             IF ~ERROR()                             ! SLIMOJIS VAI BIJIS ATVAÏINÂJUMÂ (4)
                                IF INSTRING(CAL_STUNDAS,'012345678') ! VAI SLIMOJIS B_APGABALÂ (7)
                                   IF X:PAZIME='S'             ! VAI SLIMOJIS (10)
                                      Slim+=1
                                   ELSIF X:PAZIME='A'
                                      Atv+=1
                                   .
                                .
                                D[K#]-=Darba_stundas
                                DIENA-=DIENA
                                NAKTS-=NAKTS
                             .
                          ELSE                                          ! NAV BIJIS PIEÒEMTS VAI IR ATLAISTS
                             IF INSTRING(CAL_STUNDAS,'012345678')
                                D[K#]-=Darba_stundas
                                DIENA-=DIENA
                                NAKTS-=NAKTS
                             .
                          .
                          DienSt+= DIENA
                          NaktsSt+= NAKTS
                          VirsSt+= 0

                       .
                    .
                 .
              .
           .
        .
        NPK += 1
        NPS = ALG:ID

        PRINT(RPT:DETAIL)
!        Stop('RPT:DETAIL')

        SvNaktsStN  += SvNaktsSt
        SvetkuStN   += SvetkuSt
        AtvN        += Atv
        SlimN       += Slim
        DienStN     += DienSt
        NaktsStN    += NaktsSt
        VirsStN     += VirsSt
        SvNaktsStK  += SvNaktsSt
        SvetkuStK   += SvetkuSt
        AtvK        += Atv
        SlimK       += Slim
        DienStK     += DienSt
        NaktsStK    += NaktsSt
        VirsStK     += VirsSt

        LOOP
          DO GetNextRecord
!          Stop('GetNextRecord')
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
!    stop('RequestCompleted')
    IF CIL_SK>1 AND NOD_SK>1         !VAIRÂK PAR 1 CILVÇKU NODALÂ UN VAIRÂK PAR 1 NODAÏU
       PRINT(RPT:NOD_FOOT)
    .
!          Stop('PRINT(RPT:NOD_FOOT)')
    PRINT(RPT:REP_FOOT)
!          Stop('PRINT(RPT:REP_FOOT)')



    ENDPAGE(report)
    CLOSE(ProgressWindow)
    F:DBF='W'
!    IF F:DBF='W'   !WMF
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
!    ELSE
!        ANSIJOB
!    .
  .
!  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
!  ELSE           !WORD,EXCEL
!     CLOSE(OUTFILEANSI)
!     ANSIFILENAME=''
!  .
  DO ProcedureReturn

!--------------ÈEKOJAM ALPA:IZMAKSAT
  IF ~(ALP:izmaksat=KOPA_IZMAKSAT) AND ~F:NODALA AND ~ID
     SUMMA=KOPA_IZMAKSAT
  ELSE
     SUMMA=0
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
    GRAFIKS::Used-=1
    IF GRAFIKS::Used=0 THEN CLOSE(GRAFIKS).

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
!  stop(alg:Id&' '&ALG:YYYYMM&'='&ALP:YYYYMM)
  IF ERRORCODE() OR ~(ALG:YYYYMM=ALP:YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N_3) & '%'
      DISPLAY()
    END
  END
