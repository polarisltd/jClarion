                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_RekinsGG           PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
FilesOpened          LONG

SAV_REKINA_SENR      LIKE(GG:DOK_SENR)
SAV_REKINA_DATUMS    LIKE(GG:APMDAT)
GG_PAR_NR            LIKE(GG:PAR_NR)
REKINANR             STRING(14)
rekinadatums         DATE
samaksatlidz         DATE
PD                   STRING(1)
PIEGADESDATUMS       STRING(15)
PAR_ban_NR           STRING(21)
gov_reg              STRING(45)
banka1               string(55)
banka2               string(45)
banka3               string(45)
RMENESIS             STRING(11)
RNAKMENESIS          STRING(11)
AIZNAKMENESIS        STRING(11)
BAN_NOS_P            STRING(31)
MB                   BYTE
PB                   BYTE
!Laikaperiods         string(13)
Download             STRING(122)
www                  STRING(20)
BankasRekviziti      STRING(85)
Registracija         STRING(90)
SUMMALS_TEX          STRING(9)
!04022014 VAL_UZSK             STRING(3)
LS_                  STRING(3)
PAV_VAL              STRING(5)

LBKURSS              DECIMAL(14,6)

delta                DECIMAL(12,2)
Atlaide              DECIMAL(12,2)
Atlaide2             DECIMAL(12,2)
Avanss               DECIMAL(12,2)
Avanss2              DECIMAL(12,2)
PVN                  DECIMAL(12,2),DIM(4)
PP                   BYTE,DIM(4)
PVN2                 DECIMAL(12,2),DIM(4)
D23100               DECIMAL(12,2)
D231002              DECIMAL(12,2)
apmaksai             DECIMAL(12,2)
apmaksai2            DECIMAL(12,2)
sumvar1              STRING(70)
sumvar2              STRING(70)
bridin               STRING(120)
bridin1              STRING(120)
BRIDIN2              STRING(120)
BRIDIN3              STRING(120)
dienas3              byte
SamSumma             Decimal(12,2)
SamDat               LONG
Atlaide_Proc         decimal(3,1)
SummaKopa            DECIMAL(12,2)
SummaKopa2           DECIMAL(12,2)
R_BILANCE            Decimal(12,2)
R_BILANCE2           Decimal(12,2)
R_N�KOTNEI           Decimal(12,2)       !N�KOTNES PAR�DS
R_N�KOTNEI2          Decimal(12,2)       !N�KOTNES PAR�DS Latos
R_BILANCE_S          STRING(20)
Pavisam              DECIMAL(12,2)
Pavisam2             DECIMAL(12,2)
SummaKopa10          DECIMAL(12,2)
SummaKopa12          DECIMAL(12,2)
AtlaideText          STRING(30)
PVNText1             STRING(35)

PrecuNosaukums       string(50),dim(12)    !parastajiem 7, speci�lajiem 12
PrecuDaudzums        STRING(12),dim(12)
PrecuSumma           DECIMAL(12,2),dim(12)
Cena                 DECIMAL(12,2),dim(12)

PrecuNosaukums1J     string(50)
PrecuDaudzums1J      STRING(12)
PrecuSumma1J         DECIMAL(12,2)
PrecuSumma2J         DECIMAL(12,2)
CenaJ                DECIMAL(12,2)

PrecuNosaukums1      LIKE(PrecuNosaukums),OVER(PrecuNosaukums)
PrecuDaudzums1       LIKE(PrecuDaudzums),OVER(PrecuDaudzums)
PrecuSumma1          LIKE(PrecuSumma),OVER(PrecuSumma)
PrecuSumma2          DECIMAL(12,2),dim(10)

gg_position          STRING(256)
CLIENT1              STRING(40)
CLIENT2              STRING(40)
Padrese1             string(50)
Padrese2             string(50)
Jadrese1             string(50)
Jadrese2             string(50)
SAV_POSITION         STRING(260)

GGK_D_K              STRING(1),DIM(8)
GGK_BKK              STRING(5),DIM(8)
GGK_SUMMA            DECIMAL(12,2),DIM(8)

REK_PVN              STRING(2)
SUMK_PVN             DECIMAL(12,2)
SUMK_PVN2            DECIMAL(12,2)
SUMK_PVN10           DECIMAL(12,2)
SUMK_PVN12           DECIMAL(12,2)
EXTRA_PVN_PROC       BYTE

BASEPVN              DECIMAL(12,2),DIM(5)
BASEPVNTEXT          STRING(20)
VIRSRAKSTS           STRING(80)
SAV_PVN              BYTE
PrecuPVN             STRING(2),DIM(12)

GG_DOK_SENR          LIKE(gg:dok_SENr)
GG_DOKDAT            LIKE(gg:dokdat)

MAKSATAJS            STRING(20)
SANEMEJS             STRING(20)
REKINSNR             STRING(24)
MAXRINDAS            BYTE
SODA_INDEX           BYTE
SYS_AMATS            STRING(25)
SvitraParakstam      STRING(28)
SYS_PARAKSTS         STRING(25)
CODE39               STRING(30) !1+25+3+1
CODE39_TEXT          STRING(60)
CODE39_TEXT_2        STRING(60)
SYS_BAITS            BYTE !00000001B=MAKARONU PARAKSTS
S_LIKME              DECIMAL(6,2) !STUNDAS LIKME BEZ PV

SYS_TEL              STRING(27)  !10+17
INFO_LINE            STRING(120)
KON_VAL              STRING(5)
PECGARANTIJA         BYTE
GG_APMDAT            LIKE(GG:APMDAT)
GG_VAL               LIKE(GG:VAL)
VARDS                STRING(30)
NEDAMAKSA            DECIMAL(12,2)
SAV_VAL              LIKE(GGK:VAL)
CHANGE_VAL           BYTE

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:VAL)
                     END

!-----------------------------------------------------------------------------
Report REPORT('ASSAKO'),AT(500,500,7990,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
det_Konikai DETAIL,AT(,,,1000),USE(?unnamed:4)
         STRING(@s20),AT(104,0,,150),USE(SANEMEJS,,?SANEMEJS:2),TRN,CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,156,7865,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING(@s45),AT(104,208,3125,156),USE(client),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('R��INS'),AT(5615,313),USE(?StringREKINS:2),FONT(,28,COLOR:Silver,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(677,344,3802,156),USE(gl:adrese,,?gl:adrese:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Jur.adrese:'),AT(104,344,573,156),USE(?String66:4),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s60),AT(833,479,3594,156),USE(sys:adrese,,?sys:adrese:3),FONT(,8,,,CHARSET:BALTIC)
         STRING('Pasta adrese:'),AT(104,479,677,156),USE(?String66:3),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,979,7865,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING(@s50),AT(104,625,3229,156),USE(Registracija),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s85),AT(104,781,5417,156),USE(BankasRekviziti),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
det_Visiem DETAIL,AT(,,,1000),USE(?unnamed:3)
         STRING(@s20),AT(2396,0,,150),USE(SANEMEJS),TRN,CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,156,7865,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s45),AT(2396,208,3125,156),USE(client,,?CLIENT:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('R��INS'),AT(5677,260,1823,521),USE(?StringREKINS),FONT(,28,COLOR:Silver,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2396,344,3229,156),USE(gl:adrese),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(3094,479,2500,156),USE(sys:adrese,,?sys:adrese:2),FONT(,8,,,CHARSET:BALTIC)
         STRING('Pasta adrese:'),AT(2396,479,677,156),USE(?String66:2),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,979,7865,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s50),AT(2396,625,3229,156),USE(Registracija,,?REGISTRACIJA:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s85),AT(2396,781,5365,156),USE(BankasRekviziti,,?BankasRekviziti:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,5115),USE(?unnamed:9)
         STRING(@s20),AT(104,0),USE(MAKSATAJS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(6198,260),USE(rekinanr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s24),AT(4063,260,1771,208),USE(RekinsNr),RIGHT
         STRING(@s40),AT(177,260,3865,188),USE(CLIENT1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(177,469,3865,188),USE(CLIENT2),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(6198,573),USE(rekinadatums),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(188,885,3844,156),USE(PADRESE2),TRN,CENTER
         STRING(@s50),AT(188,729,3844,156),USE(PADRESE1),CENTER
         STRING('Datums'),AT(5365,573),USE(?String59)
         STRING(@n_5b),AT(6198,885),USE(par:karte),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S50),AT(156,1042,3906,156),USE(JADRESE1),CENTER
         STRING('Klienta Nr'),AT(5260,885),USE(?String60)
         STRING(@d06.B),AT(6198,1198,781,208),USE(samaksatlidz),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S50),AT(156,1198,3906,156),USE(JADRESE2),TRN,CENTER
         STRING('Samaks�t l�dz'),AT(5052,1198),USE(?String61)
         LINE,AT(52,2240,7865,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Pamatojums'),AT(1198,2344),USE(?String50),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s9),AT(5646,2344),USE(SUMMALS_TEX),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6510,2344),USE(?String52),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(4063,2344),USE(?String50:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4740,2344),USE(?String50:3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,2604,7865,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING(@s40),AT(490,1510,3229,156),USE(gov_reg),CENTER
         STRING(@s55),AT(104,1667,4010,156),USE(BANKA1),CENTER
         STRING('Pre�u pieg�des, '),AT(4896,1458,,180),USE(?String61:2)
         STRING(@S15),AT(6198,1667,1250,208),USE(piegadesdatums),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(333,1823,3552,156),USE(BANKA2),CENTER
         STRING(@s45),AT(333,1979,3552,156),USE(BANKA3),CENTER
         STRING('datums'),AT(5469,1854,,180),USE(?String61:4),RIGHT
         STRING('pakalpojumu snieg�anas'),AT(4427,1667,,180),USE(?String61:3),RIGHT
         STRING(@s50),AT(104,2708,3698,156),USE(Precunosaukums1[1],,?Precunosaukums1_1:2)
         STRING(@n-_10.2B),AT(3906,2708,677,156),USE(cena[1],,?cena_1:3),RIGHT(5)
         STRING(@n-_10.2B),AT(3906,2969,677,156),USE(cena[2]),RIGHT(5)
         STRING(@s12),AT(4646,2708,938,156),USE(PrecuDaudzums1[1],,?PrecuDaudzums1_1:2),CENTER
         STRING(@n-_10.2B),AT(5594,2708,677,156),USE(Precusumma2[1]),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,2708,677,156),USE(Precusumma1[1],,?Precusumma1_1:2),RIGHT(5)
         STRING(@s50),AT(104,2969,3698,156),USE(Precunosaukums1[2],,?Precunosaukums1_1:21)
         STRING(@s12),AT(4646,2969,938,156),USE(PrecuDaudzums1[2]),CENTER
         STRING(@n-_10.2B),AT(6417,2969,677,156),USE(Precusumma1[2]),RIGHT(5)
         STRING(@n-_10.2B),AT(5594,2969,677,156),USE(Precusumma2[2]),RIGHT(5)
         STRING(@s50),AT(104,3229,3698,156),USE(Precunosaukums1[3])
         STRING(@n-_10.2B),AT(3906,3229,677,156),USE(cena[3]),RIGHT(5)
         STRING(@s12),AT(4646,3229,938,156),USE(PrecuDaudzums1[3]),CENTER
         STRING(@n-_10.2B),AT(5594,3229,677,156),USE(Precusumma2[3]),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,3229,677,156),USE(Precusumma1[3]),RIGHT(5)
         STRING(@n-_10.2B),AT(3906,3490,677,156),USE(cena[4]),RIGHT(5)
         STRING(@s50),AT(104,3490,3698,156),USE(Precunosaukums1[4])
         STRING(@s12),AT(4646,3490,938,156),USE(PrecuDaudzums1[4]),CENTER
         STRING(@n-_10.2B),AT(5583,3490,677,156),USE(Precusumma2[4]),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,3490,677,156),USE(Precusumma1[4]),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,3750,677,156),USE(Precusumma1[5]),RIGHT(5)
         STRING(@s12),AT(4646,3750,938,156),USE(PrecuDaudzums1[5]),CENTER
         STRING(@n-_10.2B),AT(5594,3750,677,156),USE(Precusumma2[5]),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,4010,677,156),USE(Precusumma1[6]),RIGHT(5)
         STRING(@n-_10.2B),AT(5594,4010,677,156),USE(Precusumma2[6]),RIGHT(5)
         STRING(@s50),AT(104,3750,3698,156),USE(Precunosaukums1[5])
         STRING(@n-_10.2B),AT(3906,3750,677,156),USE(cena[5]),RIGHT(5)
         STRING(@s12),AT(4646,4010,938,156),USE(PrecuDaudzums1[6]),CENTER
         STRING(@s50),AT(104,4010,3698,156),USE(Precunosaukums1[6])
         STRING(@n-_10.2B),AT(3906,4010,677,156),USE(cena[6]),RIGHT(5)
         STRING(@s12),AT(4646,4271,938,156),USE(PrecuDaudzums1[7]),CENTER
         STRING(@n-_10.2B),AT(6417,4271,677,156),USE(Precusumma1[7]),RIGHT(5)
         STRING(@n-_10.2B),AT(5594,4271,677,156),USE(Precusumma2[7]),RIGHT(5)
         STRING(@s50),AT(104,4271,3698,156),USE(Precunosaukums1[7],,?Precunosaukums1_7:2)
         STRING(@n-_10.2B),AT(3906,4271,677,156),USE(cena[7]),RIGHT(5)
         STRING(@N-_10.2b),AT(6417,4531,677,156),USE(Atlaide),RIGHT(5)
         STRING(@N-_10.2b),AT(5604,4531,677,156),USE(Atlaide2),RIGHT(5)
         LINE,AT(52,4740,7865,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@s50),AT(104,4531,3698,156),USE(AtlaideText)
         STRING(@n-_11.2),AT(6302,4792,781,208),USE(SummaKopa),RIGHT
         STRING(@s3),AT(7135,4792,281,208),USE(GG:VAL,,?GG:VAL:2)
         STRING(@n-_11.2B),AT(5490,4792,781,208),USE(SummaKopa2),RIGHT
         STRING('Kop�'),AT(313,4792,417,208),USE(?String53),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,5000,7865,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
detailH DETAIL,AT(,,,2656),USE(?unnamed)
         STRING(@s20),AT(104,0),USE(MAKSATAJS,,?MAKSATAJS:H),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(6198,260),USE(rekinanr,,?rekinanr:H),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s24),AT(4063,260,1771,208),USE(RekinsNr,,?RekinsNr:H),RIGHT
         STRING(@s40),AT(177,260,3865,188),USE(CLIENT1,,?CLIENT1:H),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(177,469,3865,188),USE(CLIENT2,,?CLIENT2:H),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6198,573),USE(rekinadatums,,?rekinadatums:H),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(188,885,3844,156),USE(PADRESE2,,?PADRESE2:H),TRN,CENTER
         STRING(@s50),AT(188,729,3844,156),USE(PADRESE1,,?PADRESE1:H),CENTER
         STRING('Datums'),AT(5365,573),USE(?String59H)
         STRING(@n_5b),AT(6198,885),USE(par:karte,,?par:karte:H),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S50),AT(156,1042,3906,156),USE(JADRESE1,,?JADRESE1:H),CENTER
         STRING('Klienta Nr'),AT(5260,885),USE(?String60H)
         STRING(@d6B),AT(6198,1198,938,208),USE(samaksatlidz,,?samaksatlidz:H),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@S50),AT(156,1198,3906,156),USE(JADRESE2,,?JADRESE2:H),TRN,CENTER
         STRING('Samaks�t l�dz'),AT(5052,1198),USE(?String61H)
         LINE,AT(52,2240,7865,0),USE(?Line1:8H),COLOR(COLOR:Black)
         STRING('Pamatojums'),AT(1198,2344),USE(?String50H),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s9),AT(5646,2344),USE(SUMMALS_TEX,,?SUMMALS_TEX:H),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6510,2344),USE(?String52H),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(4063,2344),USE(?String50:2H),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4740,2344),USE(?String50:3H),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,2604,7865,0),USE(?Line1:9H),COLOR(COLOR:Black)
         STRING(@s40),AT(490,1510,3229,156),USE(gov_reg,,?gov_reg:H),CENTER
         STRING(@s55),AT(104,1667,4010,156),USE(BANKA1,,?BANKA1:H),CENTER
         STRING('Pre�u pieg�des, '),AT(4896,1458,,180),USE(?String61:2H)
         STRING(@S15),AT(6198,1667,1250,208),USE(piegadesdatums,,?piegadesdatums:H),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(333,1823,3552,156),USE(BANKA2,,?BANKA2:H),CENTER
         STRING(@s45),AT(333,1979,3552,156),USE(BANKA3,,?BANKA3:H),CENTER
         STRING('datums'),AT(5469,1854,,180),USE(?String61:4H),RIGHT
         STRING('pakalpojumu snieg�anas'),AT(4427,1667,,180),USE(?String61:3H),RIGHT
       END
VIRSRAKSTS DETAIL,AT(,,,188),USE(?unnamed:12)
         STRING(@s80),AT(115,10,6042,208),USE(VIRSRAKSTS),FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detailS DETAIL,AT(,,,219),USE(?unnamed:10)
         STRING(@s50),AT(104,21,3698,156),USE(Precunosaukums1J)
         STRING(@n-_10.2B),AT(3906,21,677,156),USE(cenaJ),RIGHT(5)
         STRING(@s12),AT(4646,21,938,156),USE(PrecuDaudzums1J),CENTER
         STRING(@n-_10.2B),AT(5594,21,677,156),USE(Precusumma2J),RIGHT(5)
         STRING(@n-_10.2B),AT(6417,21,677,156),USE(Precusumma1J),RIGHT(5)
       END
LINE   DETAIL,AT(,,,0),USE(?LINE:2)
         LINE,AT(52,1,7865,0),USE(?Line),COLOR(COLOR:Black)
       END
detailK DETAIL,AT(,,,302),USE(?unnamed:11)
         LINE,AT(52,10,7865,0),USE(?Line1:15K),COLOR(COLOR:Black)
         STRING(@n-_11.2),AT(6302,42,781,208),USE(SummaKopa,,?SummaKopa:K),RIGHT
         STRING(@s3),AT(7135,42,281,208),USE(GG:VAL,,?GG:VAL:4K)
         STRING(@n-_11.2B),AT(5490,42,781,208),USE(SummaKopa2,,?SummaKopa2:K),RIGHT
         STRING('Kop�'),AT(313,42,417,208),USE(?String53K),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,260,7865,0),USE(?Line1:16K),COLOR(COLOR:Black)
       END
RPT_PVN DETAIL,AT(,,,219),USE(?unnamed:7)
         STRING('% pievienot�s v�rt�bas nodoklis'),AT(521,21),USE(?String54),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(3229,21,1563,208),USE(BASEPVNTEXT),TRN
         STRING(@n-_10.2B),AT(5531,21,740,156),USE(SUMK_pvn2),RIGHT
         STRING(@n-_10.2),AT(6323,21,760,156),USE(SUMK_pvn),RIGHT
         STRING(@s3),AT(7135,21,281,156),USE(GG:VAL,,?GG:VAL:4)
         STRING(@s2),AT(260,21),USE(REK_PVN),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
RPT_NPVN DETAIL,AT(,,,219),USE(?unnamed:6)
         STRING('ar PVN neapliekams  '),AT(313,10),USE(?Stringnpvn),FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
NOBEIGUMS DETAIL,AT(10,,7979,1313),USE(?unnamed:5)
         LINE,AT(52,0,7865,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Apmaksai'),AT(313,104),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(1042,104,4375,156),USE(sumvar1)
         STRING(@n-_12.2),AT(6229,104,885,156),USE(apmaksai),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7156,104,281,156),USE(GG:VAL,,?GG:VAL:333),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5354,104,885,156),USE(apmaksai2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1042,313,6250,156),USE(sumvar2)
         STRING(@s120),AT(52,573,7865,260),USE(bridin1)
         STRING(@s120),AT(52,813,7865,260),USE(BRIDIN2)
         STRING(@s120),AT(52,1073,7865,260),USE(BRIDIN3)
         LINE,AT(52,469,7865,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
NOBEIGUM1 DETAIL,AT(,,,1427),USE(?unnamed:13)
         LINE,AT(52,0,7865,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('Pavisam'),AT(313,21),USE(?String55:4),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5344,52,885,156),USE(pavisam2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(6240,52,885,156),USE(pavisam),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,52,281,156),USE(GG:VAL,,?GG:VAL:433),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Avans� samaks�ts'),AT(313,219),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(6240,250,885,156),USE(AVANSS),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5344,250,885,156),USE(AVANSS2,,?AVANSS2:3),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,250,281,156),USE(GG:VAL,,?GG:VAL:1433),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Apmaksai'),AT(313,958),USE(?String55:3),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(1042,958,4375,156),USE(sumvar1,,?sumvar11)
         STRING(@n-_12.2),AT(6240,958,885,156),USE(apmaksai,,?apmaksai:2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,958,281,156),USE(GG:VAL,,?GG:VAL:533),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5375,958,885,156),USE(apmaksai2,,?apmaksai2:3),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1042,1167,6250,156),USE(sumvar2,,?SUmvar22)
         STRING('apmaksas summa bez PVN'),AT(302,479,3854,156),USE(?AvanssText:3)
         STRING(@N-_10.2b),AT(5542,490,740,156),USE(SummaKopa12),RIGHT(5)
         STRING(@N-_10.2b),AT(6333,479,760,156),USE(SummaKopa10),RIGHT(5)
         STRING(@N-_10.2b),AT(5521,667,760,156),USE(Sumk_pvn12),RIGHT(5)
         STRING(@s55),AT(302,667,4104,156),USE(PVNText1)
         STRING(@N-_10.2b),AT(6333,667,760,156),USE(Sumk_pvn10),RIGHT(5)
         LINE,AT(52,1375,7865,0),USE(?Line1:11),COLOR(COLOR:Black)
       END
NOBEIGUM2 DETAIL,AT(,,,1771),USE(?unnamed:14)
         LINE,AT(52,0,7865,0),USE(?Line1:122),COLOR(COLOR:Black)
         STRING('Pavisam'),AT(313,21),USE(?String55:42),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5344,52,885,156),USE(pavisam2,,?pavisam2:22),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(6240,52,885,156),USE(pavisam,,?pavisam:22),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,52,281,156),USE(GG:VAL,,?GG:VAL:4332),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(302,219,1531,208),USE(R_BILANCE_S),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(6240,250,885,156),USE(R_BILANCE),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,250,281,156),USE(GG:VAL,,?GG:VAL:14332),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5344,250,885,156),USE(R_BILANCE2),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Apmaksai'),AT(313,458),USE(?String55:32),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(1042,458,4375,156),USE(sumvar1,,?sumvar11:22)
         STRING(@n-_12.2),AT(6240,458,885,156),USE(apmaksai,,?apmaksai:32),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7167,458,281,156),USE(GG:VAL,,?GG:VAL:5332),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(5354,458,885,156),USE(apmaksai2,,?apmaksai2:22),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1042,667,6250,156),USE(sumvar2,,?SUmvar22:22)
         LINE,AT(52,865,7865,0),USE(?Line1:152),COLOR(COLOR:Black)
         STRING(@s120),AT(52,917,7865,260),USE(bridin1,,?bridin12)
         STRING(@s120),AT(52,1156,7865,260),USE(BRIDIN2,,?bridin22)
         STRING(@s120),AT(52,1417,7865,260),USE(BRIDIN3,,?bridin32)
       END
RPT_LS DETAIL,AT(,,,250),USE(?unnamed:LB)
         STRING('Visas cenas '),AT(323,21,792,177),USE(?String62:23),LEFT
         STRING(' p�rr��in�tas p�c Latvijas Bankas kursa :'),AT(1427,21,2531,177),USE(?String62:26),LEFT
         STRING(@n_12.6),AT(3927,21),USE(lbkurss),RIGHT
         STRING(@s5),AT(5260,21,479,177),USE(PAV_VAL,,?String62:24),LEFT
         STRING(@s3),AT(4927,21,271,177),USE(VAL_UZSK,,?GG:val:5),LEFT
         STRING(@s5),AT(1104,21,323,177),USE(LS_,,?String62:25),RIGHT
       END
ASTE   DETAIL,AT(,,,2563),USE(?unnamed:2)
         STRING(@s1),AT(313,63,,156),USE(GGK_D_K[1]),CENTER
         STRING(@s5),AT(521,63,,156),USE(GGK_BKK[1])
         STRING(@N-_12.2B),AT(927,63,750,156),USE(GGK_SUMMA[1]),RIGHT
         STRING(@s1),AT(313,219,,156),USE(GGK_D_K[2]),CENTER
         STRING(@s5),AT(521,219,,156),USE(GGK_BKK[2])
         STRING(@N-_12.2B),AT(927,219,750,156),USE(GGK_SUMMA[2]),RIGHT
         STRING(@s1),AT(313,375,,156),USE(GGK_D_K[3]),CENTER
         STRING(@s5),AT(521,375,,156),USE(GGK_BKK[3])
         STRING(@N-_12.2B),AT(927,375,750,156),USE(GGK_SUMMA[3]),RIGHT
         STRING(@s28),AT(3698,656,2031,208),USE(SvitraParakstam)
         STRING(@s1),AT(313,531,,156),USE(GGK_D_K[4]),CENTER
         STRING(@s5),AT(521,531,,156),USE(GGK_BKK[4])
         STRING(@N-_12.2B),AT(927,531,750,156),USE(GGK_SUMMA[4]),RIGHT
         STRING(@s30),AT(3833,875,3646,313),USE(CODE39),TRN,CENTER,FONT('Code 3 de 9',20,,,CHARSET:SYMBOL)
         STRING(@s25),AT(5750,656),USE(SYS_PARAKSTS),LEFT
         STRING(@s25),AT(1771,656,1896,208),USE(sys_amats),RIGHT(1)
         STRING(@s1),AT(313,688,,156),USE(GGK_D_K[5]),CENTER
         STRING(@s5),AT(521,688,,156),USE(GGK_BKK[5])
         STRING(@N-_12.2B),AT(927,688,750,156),USE(GGK_SUMMA[5]),RIGHT
         STRING(@s1),AT(313,844,,156),USE(GGK_D_K[6]),CENTER
         STRING(@s5),AT(521,844,,156),USE(GGK_BKK[6])
         STRING(@N-_12.2B),AT(927,844,750,156),USE(GGK_SUMMA[6]),RIGHT
         STRING(@s1),AT(313,1000,,156),USE(GGK_D_K[7]),CENTER
         STRING(@s5),AT(521,1000,,156),USE(GGK_BKK[7])
         STRING(@N-_12.2B),AT(927,1000,750,156),USE(GGK_SUMMA[7]),RIGHT
         STRING(@s1),AT(313,1156,,156),USE(GGK_D_K[8]),CENTER
         STRING(@s5),AT(521,1156,,156),USE(GGK_BKK[8])
         STRING(@N-_12.2B),AT(927,1156,750,156),USE(GGK_SUMMA[8]),RIGHT
         STRING(@s60),AT(104,1354,3906,156),USE(CODE39_TEXT),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s60),AT(3927,1167,3729,208),USE(CODE39_TEXT_2,,?String249),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1510,7865,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s122),AT(104,1594,6250,156),USE(Download,,?Download:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s20),AT(6417,1583,990,156),USE(www),TRN,LEFT,FONT(,8,COLOR:Blue,FONT:underline,CHARSET:BALTIC)
         STRING('L�dzam maks�juma uzdevum� nor�d�t : Apmaksa r��inam Nr'),AT(104,1771,3031,188),USE(?String56), |
             FONT(,8,,,CHARSET:BALTIC)
         STRING(@s15),AT(3177,1771,990,188),USE(rekinanr,,?rekinanr:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(94,1969,7656,156),USE(info_line),TRN,LEFT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s27),AT(2375,2146,1823,156),USE(sys_tel),LEFT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s35),AT(94,2146,2240,156),USE(sys:e_mail),LEFT,FONT(,8,COLOR:Blue,FONT:underline,CHARSET:BALTIC)
         LINE,AT(52,2385,7865,0),USE(?Line1:10),COLOR(COLOR:Black)
         STRING('Assako smart'),AT(6844,2417,740,104),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
       END
ASTE_Konikai DETAIL,AT(,,,1385),USE(?unnamed:8)
         STRING(@s1),AT(313,63,,156),USE(GGK_D_K[1],,?ggk_d_k_1:12),CENTER
         STRING(@s5),AT(521,63,,156),USE(GGK_BKK[1],,?GGK_BKK_1:12)
         STRING(@N-_12.2B),AT(927,63,750,156),USE(GGK_SUMMA[1],,?GGK_SUMMAV_1:12),RIGHT
         STRING(@s1),AT(313,219,,156),USE(GGK_D_K[2],,?GGK_D_K_1:13),CENTER
         STRING(@s5),AT(521,219,,156),USE(GGK_BKK[2],,?GGK_BKK_1:13)
         STRING(@N-_12.2B),AT(927,219,750,156),USE(GGK_SUMMA[2],,?GGK_SUMMAV_1:13),RIGHT
         STRING(@s1),AT(313,375,,156),USE(GGK_D_K[3],,?GGK_D_K_1:14),CENTER
         STRING(@s5),AT(521,375,,156),USE(GGK_BKK[3],,?GGK_BKK_1:14)
         STRING(@N-_12.2B),AT(927,375,750,156),USE(GGK_SUMMA[3],,?GGK_SUMMAV_1:14),RIGHT
         STRING(@s30),AT(3802,844,3688,313),USE(CODE39,,?CODE39:2),TRN,CENTER,FONT('Code 3 de 9',20,,,CHARSET:SYMBOL)
         STRING(@s28),AT(3677,635,1927,208),USE(SvitraParakstam,,?SvitraParakstam:2)
         STRING(@s1),AT(313,531,,156),USE(GGK_D_K[4],,?GGK_D_K_1:15),CENTER
         STRING(@s5),AT(521,531,,156),USE(GGK_BKK[4],,?GGK_BKK_1:15)
         STRING(@N-_12.2B),AT(927,531,750,156),USE(GGK_SUMMA[4],,?GGK_SUMMAV_1:15),RIGHT
         STRING(@s1),AT(313,688,,156),USE(GGK_D_K[5],,?GGK_D_K_1:16),CENTER
         STRING(@s5),AT(521,688,,156),USE(GGK_BKK[5],,?GGK_BKK_1:16)
         STRING(@N-_12.2B),AT(927,688,750,156),USE(GGK_SUMMA[5],,?GGK_SUMMAV_1:16),RIGHT
         STRING(@s1),AT(313,844,,156),USE(GGK_D_K[6],,?GGK_D_K_1:17),CENTER
         STRING(@s5),AT(521,844,,156),USE(GGK_BKK[6],,?GGK_BKK_1:17)
         STRING(@N-_12.2B),AT(927,844,750,156),USE(GGK_SUMMA[6],,?GGK_SUMMAV_1:17),RIGHT
         STRING(@s1),AT(313,1000,,156),USE(GGK_D_K[7],,?GGK_D_K_1:18),CENTER
         STRING(@s5),AT(521,1000,,156),USE(GGK_BKK[7],,?GGK_BKK_1:18)
         STRING(@N-_12.2B),AT(927,1000,750,156),USE(GGK_SUMMA[7],,?GGK_SUMMAV_1:18),RIGHT
         STRING(@s1),AT(313,1156,,156),USE(GGK_D_K[8],,?GGK_D_K_1:19),CENTER
         STRING(@s5),AT(521,1156,,156),USE(GGK_BKK[8],,?GGK_BKK_1:19)
         STRING(@N-_12.2B),AT(927,1156,750,156),USE(GGK_SUMMA[8],,?GGK_SUMMAV_1:19),RIGHT
         STRING(@s60),AT(1823,1156,3958,156),USE(CODE39_TEXT,,?CODE39_TEXT:2),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s25),AT(5635,635),USE(sys_paraksts,,?SYS_PARAKSTS_1:15),LEFT
         STRING(@s25),AT(1760,635,1896,208),USE(sys_amats,,?SYS_AMATS_1:15),RIGHT(1)
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

window WINDOW('R��ina sagatavo�ana'),AT(,,375,335),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC), |
         CENTER,GRAY
       OPTION('&M�su Banka'),AT(15,10,321,54),USE(MB),BOXED
         RADIO('1'),AT(19,21,156,10),USE(?MB:Radio1),HIDE,VALUE('1')
         RADIO('2'),AT(19,29,156,10),USE(?MB:Radio2),HIDE,VALUE('2')
         RADIO('3'),AT(19,37,156,10),USE(?MB:Radio3),HIDE,VALUE('3')
         RADIO('4'),AT(19,45,156,10),USE(?MB:Radio4),HIDE,VALUE('4')
         RADIO('5'),AT(19,53,156,10),USE(?MB:Radio5),HIDE,VALUE('5')
         RADIO('6'),AT(183,21,149,10),USE(?MB:Radio6),HIDE,VALUE('6')
         RADIO('7'),AT(183,29,149,10),USE(?MB:Radio7),HIDE,VALUE('7')
         RADIO('8'),AT(183,37,149,10),USE(?MB:Radio8),HIDE,VALUE('8')
         RADIO('9'),AT(183,45,149,10),USE(?MB:Radio9),HIDE,VALUE('9')
         RADIO('10'),AT(183,53,149,10),USE(?MB:Radio10),HIDE,VALUE('10')
       END
       OPTION('&Partnera Banka'),AT(15,64,324,21),USE(PB),BOXED
         RADIO('1'),AT(19,73,156,10),USE(?PB:Radio1),HIDE,VALUE('1')
         RADIO('2'),AT(183,73,149,10),USE(?PB:Radio2),HIDE,VALUE('2')
       END
       BUTTON('Aiz&vietot P/Z tekstu ar Dokumenta saturu'),AT(13,94,143,14),USE(?Aizvietot)
       BUTTON('1 kompl.'),AT(226,94,61,14),USE(?ButtonKomplekts),HIDE
       STRING('Summa '),AT(309,97),USE(?String14)
       ENTRY(@s50),AT(13,110,207,11),USE(PrecuNosaukums[1])
       ENTRY(@S12),AT(225,110,63,11),USE(PrecuDaudzums[1]),CENTER
       STRING(@n_12.2B),AT(296,110),USE(PrecuSumma[1])
       BUTTON(' '),AT(346,107,20,30),USE(?summaDW),ICON(ICON:New)
       ENTRY(@s50),AT(13,123,207,11),USE(PrecuNosaukums[2])
       ENTRY(@s12),AT(225,123,63,11),USE(PrecuDaudzums[2]),CENTER
       STRING(@n_12.2B),AT(296,121),USE(PrecuSumma[2])
       ENTRY(@s50),AT(13,136,207,11),USE(PrecuNosaukums[3])
       ENTRY(@s12),AT(225,136,63,11),USE(PrecuDaudzums[3]),CENTER
       STRING(@n_12.2B),AT(296,136),USE(PrecuSumma[3])
       ENTRY(@s50),AT(13,149,207,11),USE(PrecuNosaukums[4])
       ENTRY(@s12),AT(225,149,63,11),USE(PrecuDaudzums[4]),CENTER
       STRING(@n_12.2B),AT(296,149),USE(PrecuSumma[4])
       ENTRY(@s50),AT(13,161,207,11),USE(PrecuNosaukums[5])
       ENTRY(@s12),AT(225,161,63,11),USE(PrecuDaudzums[5]),CENTER
       STRING(@n_12.2B),AT(296,161),USE(PrecuSumma[5])
       ENTRY(@s50),AT(13,174,207,11),USE(PrecuNosaukums[6])
       ENTRY(@s12),AT(225,174,63,11),USE(PrecuDaudzums[6]),CENTER
       STRING(@n_12.2B),AT(296,174),USE(PrecuSumma[6])
       ENTRY(@s50),AT(13,187,207,11),USE(PrecuNosaukums[7])
       ENTRY(@s12),AT(225,187,63,11),USE(PrecuDaudzums[7]),CENTER
       STRING(@n_12.2B),AT(296,187),USE(PrecuSumma[7])
       ENTRY(@s50),AT(13,201,207,11),USE(PrecuNosaukums[8])
       ENTRY(@s12),AT(225,201,63,11),USE(PrecuDaudzums[8]),CENTER
       STRING(@n_12.2B),AT(296,201),USE(PrecuSumma[8])
       BUTTON('Aiz&pild�t no faila'),AT(157,94,66,14),USE(?Aizpildit)
       ENTRY(@s50),AT(13,214,207,11),USE(PrecuNosaukums[9])
       ENTRY(@s12),AT(225,214,63,11),USE(PrecuDaudzums[9]),CENTER
       STRING(@n_12.2B),AT(296,215),USE(PrecuSumma[9])
       ENTRY(@s50),AT(13,227,207,11),USE(PrecuNosaukums[10])
       ENTRY(@s12),AT(225,227,63,11),USE(PrecuDaudzums[10]),CENTER
       STRING(@n_12.2B),AT(296,228),USE(PrecuSumma[10])
       ENTRY(@s50),AT(13,240,207,11),USE(PrecuNosaukums[11])
       ENTRY(@s12),AT(225,240,63,11),USE(PrecuDaudzums[11]),CENTER
       STRING(@n_12.2B),AT(296,241),USE(PrecuSumma[11])
       ENTRY(@s50),AT(13,253,207,11),USE(PrecuNosaukums[12])
       ENTRY(@s12),AT(225,253,63,11),USE(PrecuDaudzums[12]),CENTER
       STRING(@n_12.2B),AT(296,254),USE(PrecuSumma[12])
       STRING('Atlaide :'),AT(265,269),USE(?StringAtlaide)
       STRING(@n_12.2B),AT(296,269),USE(atlaide,,?atlaide:1)
       OPTION('Paraksts:'),AT(14,265,59,61),USE(sys_paraksts_nr),BOXED
         RADIO('Nav'),AT(17,274,37,10),USE(?sys_paraksts_nr:OPTION0),VALUE('0')
         RADIO('1.paraksts'),AT(17,283,47,10),USE(?sys_paraksts_nr:OPTION1),VALUE('1')
         RADIO('2.paraksts'),AT(17,293,45,10),USE(?sys_paraksts_nr:OPTION2),VALUE('2')
         RADIO('3.paraksts'),AT(17,302,45,10),USE(?sys_paraksts_nr:OPTION3),VALUE('3')
         RADIO('Login'),AT(17,312,45,10),USE(?sys_paraksts_nr:OPTION4),VALUE('4')
       END
       OPTION('&Nor�d�t'),AT(176,269,87,41),USE(F:KONTI),BOXED
         RADIO('Druk�t kont�jumus'),AT(181,282,78,10),USE(?F:KONTI:Radio1),VALUE('D')
         RADIO('Nedruk�t kont�jumus'),AT(181,295,80,10),USE(?F:KONTI:Radio2),VALUE('N')
       END
       ENTRY(@d06.b),AT(121,281,42,11),USE(piegadesdatums,,?PIEGADESDATUMS:1),REQ
       BUTTON('Druk�t sv�tru parakstu'),AT(81,313,79,14),USE(?Button:MAKARONI)
       IMAGE('CHECK3.ICO'),AT(161,308,15,20),USE(?Image:MAKARONI),HIDE
       BUTTON('D&rukas parametri'),AT(277,284,78,14),USE(?Button:DRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       OPTION('Pieg�des datums :'),AT(80,268,90,41),USE(PD),BOXED
         RADIO('Datums'),AT(84,281,37,10),USE(?PD:Radio1)
         RADIO('Priek�apmaksa'),AT(84,294),USE(?PD:Radio2)
       END
       BUTTON('EUR p�rr��ins'),AT(179,313,78,14),USE(?ButtonEUR),HIDE
       IMAGE('CHECK2.ICO'),AT(258,310,15,18),USE(?Image_EUR_P),HIDE
       BUTTON('&OK'),AT(277,300,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(319,300,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
!
! �RES R��INIEM J�SADALA 6 GRUPA PA VEIDIEM(�RE,�DENS UTT..)
!               UN AR� 57210 PA PVN GRUP�M; 231 VAR B�T 1 CIPARS
!
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  checkopen(system,1)
  SYS_BAITS=SYS:BAITS             !00000001B=MAKARONU PARAKSTS

  CHECKOPEN(GLOBAL,1)
!  IF GGK::USED=0
!     checkopen(ggk,1)
!  .
!  GGK::USED+=1
  BIND(ggk:RECORD)
  BIND(GG:RECORD)
  BIND('KKK',KKK)
  BIND('D_K',D_K)
  BIND('gg_par_nr',GG_PAR_NR)

  IF F:DTK='S'  !SPEC. P�TERM�JA,LATIOVKV
     MAXRINDAS=12
  ELSE
     MAXRINDAS=7
  .
  IF ACC_KODS_N=0  !ASSAKO r�kins
     S_LIKME=25    !CIETI 25 Ls/h
  .
  IF ACC_KODS_N=0 AND GG:SATURS[1:13]='P�cgarantijas'
     PECGARANTIJA=TRUE
     GG_APMDAT=GG:APMDAT
  .
  gg_par_nr=gg:par_nr
  atlaide=0
  atlaide_proc=gg:atlaide
  GG_VAL=GG:VAL
  GG_POSITION=POSITION(GG)
  KKK='231'
  D_K='K'
  IMAGE#=PerfAtable(1,'','','',GG:PAR_NR,'',0,0,'',0) !VAR IZKUSTIN�T GG...
  RESET(GG,GG_POSITION)
  NEXT(GG)
  D_K='D'
  MAKSATAJS='Maks�t�js:'
  SANEMEJS=''
  REKINSNR='R��ins Nr  '
  R_BILANCE_S='P�rmaksa (BILANCE)'

  FilesOpened = True
  RecordsToProcess = 50
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  IF getpar_k(gg:par_nr,2,1)
     TEKSTS=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrie� par:adrese,JA IR IZSAUC BROWSI
     FORMAT_TEKSTS(77,'ARIAL',10,' ')     !bija 80
     PADRESE1 = F_TEKSTS[1]
     PADRESE2 = F_TEKSTS[2]
     IF ~(TEKSTS=par:adrese)
        TEKSTS='Jur.adrese: '&PAR:ADRESE
        FORMAT_TEKSTS(77,'ARIAL',10,' ')
        IF F_TEKSTS[2]
           JADRESE1 = F_TEKSTS[1]
           JADRESE2 = F_TEKSTS[2]
        ELSE
           JADRESE1 = ''
           JADRESE2 = F_TEKSTS[1]
        .
     ELSE
        JADRESE1=''
        JADRESE2=''
     .
     TEKSTS = GETPAR_K(GG:PAR_NR,2,2)
     FORMAT_TEKSTS(77,'ARIAL',12,'B')
     IF F_TEKSTS[2]
        CLIENT1 = F_TEKSTS[1]
        CLIENT2 = F_TEKSTS[2]
     ELSE
        CLIENT1 = ''
        CLIENT2 = F_TEKSTS[1]
     .
  .

  DO FILLPARAKSTI !S�kums...TIEKAM GAL� AR PARAKSTU DATIEM

  SAV_REKINA_SENR=GG:DOK_SENR    !DRUK�JAMAIS R��INS
  SAV_REKINA_DATUMS=GG:DATUMS    !DRUK�JAM� R��INA DATUMS


  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'R��ins'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(ggk:record)
      ggk:PAR_NR=GG:PAR_NR
      SET(GGK:PAR_KEY,GGK:PAR_KEY)
!      Process:View{Prop:Filter} = 'GGK:PAR_NR=GG:PAR_NR AND GGK:BKK=KKK AND GGK:D_K=D_K'
!      Process:View{Prop:Filter} = 'GGK:PAR_NR=GG_PAR_NR AND GGK:D_K=D_K'
      Process:View{Prop:Filter} = 'GGK:PAR_NR=GG_PAR_NR'
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
!      OPEN(Report)
!      Report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GGK:BKK[1:3]=KKK               !VISI 231/531
           I#=getgg(ggk:u_nr)
           IF SAV_REKINA_SENR=gg:dok_SENR !DRUK�JAMAIS R��INS
               LocalResponse = RequestCompleted
               POST(Event:CloseWindow)
               BREAK
           .
           IF GGK:D_K=D_K                      !ATRASTS M�SU R��INS
              IF GG:APMDAT < SAV_REKINA_DATUMS !JAU BIJA J�B�T SAMAKS�TAM UZ �� R��INA IZRAKST��ANAS BR�DI
                 R_BILANCE+=GGK:SUMMAV         !FIKS�JAM PAR�DU
                 R_BILANCE2+=GGK:SUMMA         !FIKS�JAM PAR�DU Latos
                 SAV_VAL=GGK:VAL               !ATCERAMIES R��INA VAL�TU

                 VAL_NOS=GGK:VAL
                 IF GGK:U_NR=1
                    SAMSUMMA=PerfAtable(2,GGK:REFERENCE,'','',GGK:PAR_NR,'',0,0,'',0)
                    IF SAMSUMMA<GGK:SUMMA !�ITAIS FORMATS TIEK SAUKTS n-K�RT�GI
                       IF ~SAV_POSITION THEN SAV_POSITION=POSITION(GGK).
                       IF POSITION(GGK)=SAV_POSITION
                          SAMSUMMA+=BILANCE
                       .
                    .
                 ELSE
                    SAMSUMMA=PerfAtable(2,GG:DOK_SENR,'','',GG:PAR_NR,'',0,0,'',0)
                 .
                 SamDat=PERIODS    !P�D�J� MAKS�JUMA DATUMS (��iet periodu izmanto tikai noliktava)
                 IF GGK:VAL=VAL_NOS
!                 STOP(GGK:VAL&' '&VAL_NOS)
                    NEDAMAKSA=GGK:SUMMAV-SAMSUMMA
                 ELSE              !SAMSUMMA IR Latos
                    NEDAMAKSA=GGK:SUMMA-SAMSUMMA
                 .
                 IF NEDAMAKSA > 0.02 !Atg�dinam MAX 2x par vec�kajiem par�diem
                    IF GGK:U_NR=1
                       GG_DOK_SENR=GGK:REFERENCE
                       GG_DOKDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,5)
                    ELSE
                       GG_DOK_SENR=gg:dok_SENr
                       GG_DOKDAT=gg:dokdat
                    .
                    IF ~BRIDIN1
                       IF ~SAMSUMMA !NEKAS PAR �O R��INU NAV MAKS�TS
                          bridin1='Atg�din�jums: j�s neesat apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&' par summu '&VAL_NOS&' '&LEFT(FORMAT((ggk:summav),@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' par summu Ls '&LEFT(FORMAT((ggk:summa),@N_9.2))
                          IF PECGARANTIJA=TRUE !ASSAKO P�cgarantijas r�kins
                             bridin3='Apmaksas termi�u neiev�ro�anas gad�jum� J�su p�cgarantija tiks anul�ta '&|
                             FORMAT(gg_apmdat+1,@D06.)
                          .
                       ELSE
                          bridin1='Atg�din�jums: j�s neesat piln�b� apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&', par�ds '&VAL_NOS&' '&LEFT(FORMAT(NEDAMAKSA,@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' summa Ls '&clip(LEFT(FORMAT((ggk:summa),@N_9.2)))&|
!                          ' par�ds Ls '&LEFT(FORMAT((ggk:summa-samsumma),@N_9.2))
                       .
                    ELSIF ~BRIDIN2
                       IF ~SAMSUMMA !NEKAS PAR �O R��INU NAV MAKS�TS
                          bridin2='Atg�din�jums: j�s neesat apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&' par summu '&VAL_NOS&' '&LEFT(FORMAT((ggk:summav),@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' par summu Ls '&LEFT(FORMAT((ggk:summa),@N_9.2))
                          IF ACC_KODS_N=0 AND PECGARANTIJA=TRUE !ASSAKO P�cgarantijas r�kins
                             bridin3='Apmaksas termi�u neiev�ro�anas gad�jum� J�su p�cgarantija tiks anul�ta '&|
                             FORMAT(gg_apmdat+1,@D06.)
                          .
                       ELSE
                          bridin2='Atg�din�jums: j�s neesat piln�b� apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&', par�ds '&VAL_NOS&' '&LEFT(FORMAT(NEDAMAKSA,@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' summa Ls '&clip(LEFT(FORMAT((ggk:summa),@N_9.2)))&|
!                          ' par�ds Ls '&LEFT(FORMAT(ggk:summa-samsumma,@N_9.2))
                       .
                    ELSIF ~BRIDIN3 OR bridin3[1:8]='Apmaksas'
                       IF ~SAMSUMMA !NEKAS PAR �O R��INU NAV MAKS�TS
                          bridin3='Atg�din�jums: j�s neesat apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&' par summu '&VAL_NOS&' '&LEFT(FORMAT((ggk:summav),@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' par summu Ls '&LEFT(FORMAT((ggk:summa),@N_9.2))
!                          IF ACC_KODS_N=0 AND PECGARANTIJA=TRUE !ASSAKO P�cgarantijas r�kins
!                             bridin3='Apmaksas termi�u neiev�ro�anas gad�jum� J�su p�cgarantija tiks anul�ta '&|
!                             FORMAT(gg_apmdat+1,@D06.)
!                          .
                       ELSE
                          bridin3='Atg�din�jums: j�s neesat piln�b� apmaks�ju�i r��inu Nr '&CLIP(gg_dok_SENr)&|
                          ' no '&FORMAT(gg_dokdat,@D06.)&', par�ds '&VAL_NOS&' '&LEFT(FORMAT(NEDAMAKSA,@N_9.2))
!                          ' no '&FORMAT(gg_dokdat,@D05.)&' summa Ls '&clip(LEFT(FORMAT((ggk:summa),@N_9.2)))&|
!                          ' par�ds Ls '&LEFT(FORMAT(ggk:summa-samsumma,@N_9.2))
                       .
                    .
                 ELSIF NEDAMAKSA < -0.02  !P�RMAKSA
                    IF GGK:U_NR=1
!                       GG_DOK_SENR=GGK:REFERENCE
!                       GG_DOKDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,5)
                       bridin='J�s esat veiku�i p�rmaksu par iepriek��jiem periodiem'
                    ELSE
                       GG_DOK_SENR=gg:dok_SENr
                       GG_DOKDAT=gg:dokdat
                       bridin='J�s esat veiku�i p�rmaksu r��inam Nr '&CLIP(gg_dok_SENr)&|
                       ' no '&FORMAT(gg_dokdat,@D06.)
                    .
                    IF ~BRIDIN1
                       bridin1=CLIP(bridin)&', p�rmaksa '&VAL_NOS&' '&CLIP(LEFT(FORMAT(NEDAMAKSA,@N_9.2)))
!                       ' no '&FORMAT(gg_dokdat,@D06.)&' R.summa '&VAL_NOS&' '&clip(LEFT(FORMAT((ggk:summa),@N_9.2)))&|
                    ELSIF ~BRIDIN2
                       bridin2=(bridin)&', p�rmaksa '&VAL_NOS&' '&CLIP(LEFT(FORMAT(NEDAMAKSA,@N_9.2)))
                    .
                 ELSIF GG:APMDAT<SamDat  !L�dzam iev�rot AT tikai p�d�jam, ja nav
                    IF ~BRIDIN3
                       bridin3='L�dzam iev�rot apmaksas termi�us'
                       dienas3=samdat-GG:APMDAT
                    .
!                 ELSE
!                    bridin3=''
                 .
              ELSE !V�L NEBIJA J�APMAKS� UZ �� R��INA IZRAKST��ANAS BR�DI
                 R_N�KOTNEI+=GGK:SUMMAV        !FIKS�JAM N�KOTNES PAR�DU
                 R_N�KOTNEI2+=GGK:SUMMA        !FIKS�JAM N�KOTNES PAR�DU Latos
                 SAV_VAL=GGK:VAL               !ATCERAMIES R��INA VAL�TU
              .
           ELSIF (GGK:BKK[1:3]='231' AND GGK:D_K='K') !SAMAKS�TS M�SU R��INS
              R_BILANCE-=GGK:SUMMAV                   !NO�EMAM PAR�DU VAL�T�
              R_BILANCE2-=GGK:SUMMA                   !NO�EMAM PAR�DU Ls
!              STOP(GGK:VAL&'='&SAV_VAL)
              IF SAV_VAL AND ~(GGK:VAL=SAV_VAL)
                 CHANGE_VAL=TRUE
!                 STOP(CHANGE_VAL)
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
  RESET(GG,GG_POSITION)
  NEXT(GG)
  clear(ggk:record)
  GGK:U_NR=GG:U_NR
  SET(GGK:NR_KEY,GGK:NR_KEY) !CAURI TEKO�AM R��INAM
  I#=0
  LOOP
     NEXT(GGK)
     IF ERROR() OR ~(GG:U_NR=GGK:U_NR) THEN BREAK.
     IF (GGK:BKK[1]='6' AND GGK:D_K='K') OR (GGK:BKK[1:3]='521' AND GGK:D_K='K')|
     OR (GGK:BKK[1]='7' AND GGK:D_K='K') OR (GGK:BKK[1:3]='819' AND GGK:D_K='K') OR (GGK:BKK[1:3]='816' AND GGK:D_K='K')
        I#+=1
        IF GGK:BKK[1:3]='816' THEN SODANAUDA#=TRUE. !Lai nedruk� PVN rindu
        IF I#<=MAXRINDAS
           PrecuNosaukums[i#]=GETKON_K(GGK:BKK,0,2)
           IF F:DTK='S'  !SPEC. P�TERM�JA,LATIOVKV
              PrecuDaudzums[i#]='1 m�nesis'
              IF UPPER(SUB(PrecuNosaukums[i#],1,4))='SODA'
                 SODA_INDEX=I#
                 PrecuNosaukums[i#]=CLIP(PrecuNosaukums[i#])&' '&GETPAR_K(GG:PAR_NR,0,23)
                 PrecuDaudzums[i#]='1 gab.'
              .
           ELSIF I#=1 AND ACC_KODS_N=0  !ASSAKO r�kins
              IF PECGARANTIJA=TRUE
                 IF ~MENESU_SKAITS THEN MENESU_SKAITS=3.    !TOM�R LAB�K NEK� NEKAS.....
                 IF ~MEN_NR THEN MEN_NR=MONTH(GG:DATUMS)-2. !TOM�R LAB�K NEK� NEKAS.....
                 PrecuDaudzums[i#]=clip(MENESU_SKAITS)&' m�ne�i'
              ELSE
                 PrecuDaudzums[i#]=clip(ABS(GGK:SUMMA)/S_LIKME)&' stundas'
              .
           ELSE
              PrecuDaudzums[i#]='1 gab.'
           .
           PrecuSumma[i#]=ggk:summav/(1-atlaide_proc/100)     !Val�t� pirms atlaides
           IF BAND(ggk:BAITS,00000010b) !AR PVN NEAPLIEKAMS
              PrecuPVN[I#]=' '
           ELSE
              PrecuPVN[I#]=GGK:PVN_PROC
           .
           atlaide+=ggk:summav-PrecuSumma[i#]
           SUMMAKOPA+=GGK:SUMMAV

!          !Elya 04.09.2013 <
!!           IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!!              PrecuSumma2[i#]=ggk:summa/(1-atlaide_proc/100)  !Ls pirms atlaides
!!              atlaide2+=ggk:summa-PrecuSumma2[i#]             !Ls
!!              SUMMAKOPA2+=GGK:SUMMA
!!              SUMMALS_TEX='Summa Ls'
!!           .
!           !Elya 04.09.2013 >


        ELSE
           KLUDA(0,'RAKSTI VAIR�K K� '& CLIP(MAXRINDAS))
           BREAK
        .
     ELSIF (GGK:BKK[1:3]='521' AND GGK:D_K='D') !IZRAKST�TS AVANSA R��INS
        AVANSS+=GGK:SUMMAV
!        SUMMAKOPA-=GGK:SUMMAV


     ELSIF (GGK:BKK[1:3]='231' AND GGK:D_K='D') !IZRAKST�TS R��INS
        D23100+=GGK:SUMMAV
     .
  .
  IF BAND(SYS:BAITS,00000010B) !P/Z DRUK�T DOK.SATURU
     PrecuNosaukums[1]=gg:saturs
     PrecuNosaukums[2]=gg:saturs2
     PrecuNosaukums[3]=gg:saturs3
     loop i#=4 to 12
        PrecuNosaukums[i#]=''
     .
  .
  IF SEND(GGK,'QUICKSCAN=off').
!************************************** DATU LOGS*************
  OPEN(window) !viskas&paraksti
  WindowOpened=True
  PD='D'  !PIEG�DES DATUMS
  IF BAND(SYS:BAITS,00000010B) !P/Z DRUK�T DOK.SATURU
     HIDE(?AIZVIETOT)
  .

  !Elya 27.08.2013 <
  IF GG:DATUMS >= date(01,01,2014)
     IF ~(GG:VAL='EUR')
        EUR_P = 0
        HIDE(?IMAGE_EUR_P)
        HIDE(?ButtonEUR)
!        ?ButtonEUR{Prop:Text}='EUR p�rr��ins'
!        EUR_P = 1
     ELSE
        UNHIDE(?ButtonEUR)
        ?ButtonEUR{Prop:Text}='LVL p�rr��ins'
        IF GG:DATUMS >= date(10,01,2013) AND GG:DATUMS < date(07,01,2014)
          EUR_P = 1
       .
    .
  ELSE
     IF ~(GG:VAL='Ls' OR GG:VAL='LVL')
!        stop('!NOT_LVL')
        EUR_P = 0
        HIDE(?IMAGE_EUR_P)
        HIDE(?ButtonEUR)
!
!        ?ButtonEUR{Prop:Text}='LVL p�rr��ins'
!        EUR_P = 1
     ELSE
        UNHIDE(?ButtonEUR)
        ?ButtonEUR{Prop:Text}='EUR p�rr��ins'
        IF GG:DATUMS >= date(10,01,2013) AND GG:DATUMS < date(07,01,2014)
          EUR_P = 1
       .
    .
  .

  !Elya 27.08.2013 >
!  stop(EUR_P)
  IF EUR_P  !P�RR��INS uz EUR
     UNHIDE(?IMAGE_EUR_P)
  .
  SUMMALS_TEX=''
  IF GG:DATUMS >= date(01,01,2014)
     IF ~(GG:VAL='EUR')        ! ggk:summa jau ir euros
         SUMMALS_TEX='Summa EUR'
     ELSIF EUR_P
         SUMMALS_TEX='Summa Ls'
     .
  ELSE
     IF ~(GG:VAL='Ls' OR GG:VAL='LVL')        ! ggk:summa jau ir latos
         SUMMALS_TEX='Summa Ls'
     ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
         SUMMALS_TEX='Summa EUR'
     .
  .
  IF F:DTK='S' !SPECR��INS P�TERM�JA,LATIOVKV
     HIDE(?AIZVIETOT)
     HIDE(?F:KONTI)
     HIDE(?STRINGATLAIDE)
     piegadesdatums=GG:DATUMS
     F:KONTI='N'        !NEDRUK�T KONT�JUMU
  ELSIF PECGARANTIJA=TRUE !ASSAKO P�cgarantijas r�kins
     HIDE(?PrecuNosaukums_8)
     HIDE(?PrecuDaudzums_8)
     HIDE(?Precusumma_8)
     HIDE(?PrecuNosaukums_9)
     HIDE(?PrecuDaudzums_9)
     HIDE(?Precusumma_9)
     HIDE(?PrecuNosaukums_10)
     HIDE(?PrecuDaudzums_10)
     HIDE(?Precusumma_10)
     HIDE(?PrecuNosaukums_11)
     HIDE(?PrecuDaudzums_11)
     HIDE(?Precusumma_11)
     HIDE(?PrecuNosaukums_12)
     HIDE(?PrecuDaudzums_12)
     HIDE(?Precusumma_12)
!     PIEGADESDATUMS=DATE(MONTH(GG:APMDAT)+1,1,YEAR(GG:APMDAT))-1
     PIEGADESDATUMS=DATE(MEN_NR+MENESU_SKAITS,1,YEAR(GG:DATUMS))-1 !MEN_NR N�K NO FILTRA
     F:KONTI='D'
  ELSIF ACC_KODS_N=0  !ASSAKO r��ins
     piegadesdatums=GG:DATUMS
     F:KONTI='D'
     UNHIDE(?BUTTONKOMPLEKTS)
  ELSE
     HIDE(?PrecuNosaukums_8)
     HIDE(?PrecuDaudzums_8)
     HIDE(?Precusumma_8)
     HIDE(?PrecuNosaukums_9)
     HIDE(?PrecuDaudzums_9)
     HIDE(?Precusumma_9)
     HIDE(?PrecuNosaukums_10)
     HIDE(?PrecuDaudzums_10)
     HIDE(?Precusumma_10)
     HIDE(?PrecuNosaukums_11)
     HIDE(?PrecuDaudzums_11)
     HIDE(?Precusumma_11)
     HIDE(?PrecuNosaukums_12)
     HIDE(?PrecuDaudzums_12)
     HIDE(?Precusumma_12)
     piegadesdatums=GG:DATUMS
     F:KONTI='D'        !DRUK�T KONT�JUMU
  .
  MB=SYS:NOKL_B
  PB=SYS:NOKL_PB
  LOOP I#=1 TO 10
     IF GL:BKODS[I#]
        BAN_NOS_P=GETBANKAS_K(GL:BKODS[I#],0,1)
        KON_VAL=GETKON_K(GL:BKK[I#],0,5)
        IF KON_VAL THEN KON_VAL=CLIP(KON_VAL)&': '.
        EXECUTE I#
           ?MB:Radio1{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio2{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio3{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio4{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio5{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio6{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio7{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio8{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio9{Prop:Text}=KON_VAL&BAN_NOS_P
           ?MB:Radio10{Prop:Text}=KON_VAL&BAN_NOS_P
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
  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
     UNHIDE(?Image:Makaroni)
  .
  DISPLAY()
!**********************************DATU LOGS**************
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
         PrecuNosaukums[3]=gg:saturs3
         loop i#=4 to 12
            PrecuNosaukums[i#]=''
         .
         DISPLAY()
      .
    OF ?Aizpildit
      CASE EVENT()
      OF EVENT:Accepted
         ANSIFILENAME='RZP'&CLIP(GG:PAR_NR)&'.TXT'
         OPEN(OUTFILEANSI)
         IF ~ERROR()
            SET(OUTFILEANSI)
            LOOP R#=1 TO 7
               NEXT(OUTFILEANSI)
               IF ERROR()
                  R# = R# - 1
                  BREAK
               .
               PrecuNosaukums[R#]=OUTA:LINE
            .
            CLOSE(OUTFILEANSI)
            loop i#=R#+1 to 12
               PrecuNosaukums[i#]=''
            .
         .
         DISPLAY()
      .
    !Elya 04/09/2013
    OF ?ButtonEUR
      CASE EVENT()
      OF EVENT:Accepted
!        stop('Button')
        IF EUR_P
           EUR_P=0
           HIDE(?IMAGE_EUR_P)
        ELSE
           EUR_P=1
           UNHIDE(?IMAGE_EUR_P)
        .
!        IF (GG:DATUMS >= date(01,01,2014) AND ~(GGK:VAL='EUR')) OR (GG:DATUMS < date(01,01,2014) AND ~(GGK:VAL='Ls' OR GGK:VAL='LVL'))
!           IF EUR_P=0
!              EUR_P=1
!              UNHIDE(?IMAGE_EUR_P)
!           .
!        .
        SUMMALS_TEX=''
        IF GG:DATUMS >= date(01,01,2014)
           IF ~(GG:VAL='EUR')        ! ggk:summa jau ir euros
               SUMMALS_TEX='Summa EUR'
           ELSIF EUR_P
               SUMMALS_TEX='Summa Ls'
           .
        ELSE
           IF ~(GG:VAL='Ls' OR GG:VAL='LVL')        ! ggk:summa jau ir latos
               SUMMALS_TEX='Summa Ls'
           ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
               SUMMALS_TEX='Summa EUR'
           .
        .
        DISPLAY()
      END
    OF ?BUTTONKOMPLEKTS
      CASE EVENT()
      OF EVENT:Accepted
         PrecuDAUDZUMS[1]='1 kompl.'
         display()
      .
    OF ?SummaDW  !SUMMU UZ LEJU
      CASE EVENT()
      OF EVENT:Accepted
         loop i#=6 TO 1 by -1
            if PrecuSumma[i#]
               PrecuDaudzums[i#+1]=PrecuDaudzums1[i#]
               PrecuDaudzums[i#]=''
               PrecuSumma[i#+1]=PrecuSumma[i#]
               PrecuSumma[i#]=0
               display()
               BREAK
            .
         .
       .
    OF ?SYS_PARAKSTS_NR  !AMATS,PARAKSTS
      CASE EVENT()
      OF EVENT:Accepted
         DO FILLPARAKSTI
         display()
      .
    OF ?Button:MAKARONI  !SV�TRU PARAKSTS, ...NEIZMANTOJAM GLOBAL
      CASE EVENT()
      OF EVENT:Accepted
         IF BAND(SYS_BAITS,00000001B)
            SYS_BAITS-=1
            HIDE(?Image:Makaroni)
         ELSE
            SYS_BAITS+=1
            UNHIDE(?Image:Makaroni)
         .
         DO FILLPARAKSTI
         display()
      .
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
       LocalResponse = RequestCompleted
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


!Elya 04.09.2013 <
!  IF ~(GG:VAL='Ls' OR GG:VAL='LVL')     ! VAL�TAS P/Z PAR�DAM Ls
!     LBKURSS=BANKURS(GG:VAL,GG:DATUMS)
!  .
 
  !04022014 IF GG:DATUMS >= date(01,01,2014)
  !   VAL_UZSK = 'EUR'
  IF VAL_UZSK = 'EUR'
     IF ~(GG:VAL='EUR')     ! VAL�TAS P/Z PAR�DAM Ls
        LBKURSS=BANKURS(GG:VAL,GG:DATUMS,1)
        LS_='EUR'
        PAV_VAL='/ '&GG:VAL
     ELSIF EUR_P
        LBKURSS=1.422872
        LS_='Ls'
        PAV_VAL='/ Ls'
     ELSE
        LBKURSS=1
     .
  ELSE
     !VAL_UZSK = 'Ls'
     IF ~(GG:VAL='Ls' OR GG:VAL='LVL')     ! VAL�TAS P/Z PAR�DAM Ls
        LBKURSS=BANKURS(GG:VAL,GG:DATUMS,1)
        LS_='Ls'
        PAV_VAL='/ '&GG:VAL
     ELSIF EUR_P
        LBKURSS=0.702804
        LS_='EUR'
        PAV_VAL='/ EUR'
     ELSE
        LBKURSS=1
     .
  .
  !Elya 04.09.2013 >

!********************************* ls valutam rekinam
  clear(ggk:record)
  GGK:U_NR=GG:U_NR
  SET(GGK:NR_KEY,GGK:NR_KEY) !CAURI TEKO�AM R��INAM
  I#=0
  LOOP
     NEXT(GGK)
     IF ERROR() OR ~(GG:U_NR=GGK:U_NR) THEN BREAK.
     IF (GGK:BKK[1]='6' AND GGK:D_K='K') OR (GGK:BKK[1:3]='521' AND GGK:D_K='K')|
     OR (GGK:BKK[1]='7' AND GGK:D_K='K') OR (GGK:BKK[1:3]='819' AND GGK:D_K='K') OR (GGK:BKK[1:3]='816' AND GGK:D_K='K')
        I#+=1
        IF GGK:BKK[1:3]='816' THEN SODANAUDA#=TRUE. !Lai nedruk� PVN rindu
        IF I#<=MAXRINDAS
!           PrecuNosaukums[i#]=GETKON_K(GGK:BKK,0,2)
!           IF F:DTK='S'  !SPEC. P�TERM�JA,LATIOVKV
!              PrecuDaudzums[i#]='1 m�nesis'
!              IF UPPER(SUB(PrecuNosaukums[i#],1,4))='SODA'
!                 SODA_INDEX=I#
!                 PrecuNosaukums[i#]=CLIP(PrecuNosaukums[i#])&' '&GETPAR_K(GG:PAR_NR,0,23)
!                 PrecuDaudzums[i#]='1 gab.'
!              .
!           ELSIF I#=1 AND ACC_KODS_N=0  !ASSAKO r�kins
!              IF PECGARANTIJA=TRUE
!                 IF ~MENESU_SKAITS THEN MENESU_SKAITS=3.    !TOM�R LAB�K NEK� NEKAS.....
!                 IF ~MEN_NR THEN MEN_NR=MONTH(GG:DATUMS)-2. !TOM�R LAB�K NEK� NEKAS.....
!                 PrecuDaudzums[i#]=clip(MENESU_SKAITS)&' m�ne�i'
!              ELSE
!                 PrecuDaudzums[i#]=clip(ABS(GGK:SUMMA)/S_LIKME)&' stundas'
!              .
!           ELSE
!              PrecuDaudzums[i#]='1 gab.'
!           .
!           PrecuSumma[i#]=ggk:summav/(1-atlaide_proc/100)     !Val�t� pirms atlaides
!           IF BAND(ggk:BAITS,00000010b) !AR PVN NEAPLIEKAMS
!              PrecuPVN[I#]=' '
!           ELSE
!              PrecuPVN[I#]=GGK:PVN_PROC
!           .
!           atlaide+=ggk:summav-PrecuSumma[i#]
!           SUMMAKOPA+=GGK:SUMMAV
!
          !Elya 04.09.2013 <

          !Rekinam valutaa paradam Ls, pec 01.01.2014 - EUR
          !Rekinam reglament.valutaa paradam EUR, pec 01.01.2014 - LVL
!           IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!              PrecuSumma2[i#]=ggk:summa/(1-atlaide_proc/100)  !Ls pirms atlaides
!              atlaide2+=ggk:summa-PrecuSumma2[i#]             !Ls
!              SUMMAKOPA2+=GGK:SUMMA
!              SUMMALS_TEX='Summa Ls'
!           .
           IF GG:DATUMS >= date(01,01,2014)
              IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
                  PrecuSumma2[i#]=ggk:summa/(1-atlaide_proc/100)  !Ls pirms atlaides
                  atlaide2+=ggk:summa-PrecuSumma2[i#]             !Ls
                  SUMMAKOPA2+=GGK:SUMMA
!                  SUMMALS_TEX='Summa EUR'
              ELSIF EUR_P
                  PrecuSumma2[i#]=(ggk:summa/(1-atlaide_proc/100))/LBKURSS  !Ls pirms atlaides
                  atlaide2+=ggk:summa/LBKURSS-PrecuSumma2[i#]             !Ls
                  SUMMAKOPA2+=GGK:SUMMA/LBKURSS  !1,4.....
!                  SUMMALS_TEX='Summa Ls'
              .
           ELSE
              IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
                  PrecuSumma2[i#]=ggk:summa/(1-atlaide_proc/100)  !Ls pirms atlaides
                  atlaide2+=ggk:summa-PrecuSumma2[i#]             !Ls
                  SUMMAKOPA2+=GGK:SUMMA
!                  SUMMALS_TEX='Summa Ls'
              ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
                  PrecuSumma2[i#]=(ggk:summa/(1-atlaide_proc/100))/LBKURSS  !Ls pirms atlaides
                  atlaide2+=ggk:summa/LBKURSS-PrecuSumma2[i#]             !Ls
                  SUMMAKOPA2+=GGK:SUMMA/LBKURSS !0,702804
!                  SUMMALS_TEX='Summa EUR'
              .
           .
           !Elya 04.09.2013 >


        ELSE
           KLUDA(0,'RAKSTI VAIR�K K� '& CLIP(MAXRINDAS))
           BREAK
        .
     ELSIF (GGK:BKK[1:3]='521' AND GGK:D_K='D') !IZRAKST�TS AVANSA R��INS
!        AVANSS+=GGK:SUMMAV
!        SUMMAKOPA-=GGK:SUMMAV

        !Elya 04.09.2013 <
        !Domajam ka atlikumi ir latos, bet pec 01.01.2014 - EURos
!        IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!           AVANSS2+=GGK:SUMMA                   !Ls
!
!
!!           SUMMAKOPA2-=GGK:SUMMA
!        .
         IF ((GG:DATUMS >= date(01,01,2014)) AND ~(GGK:VAL='EUR')) OR ((GG:DATUMS < date(01,01,2014)) AND ~(GGK:VAL='Ls' OR GGK:VAL='LVL'))
            AVANSS2+=GGK:SUMMA
         ELSIF EUR_P
            AVANSS2+=GGK:SUMMA/LBKURSS !0,702804                   !Ls vai EUR pec 01.01.2014
         .
         !Elya 04.09.2013 >

     ELSIF (GGK:BKK[1:3]='231' AND GGK:D_K='D') !IZRAKST�TS R��INS
!        D23100+=GGK:SUMMAV
        !Elya 04.09.2013 <
        !Domajam ka atlikumi ir latos, bet pec 01.01.2014 - EURos
!        IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!           D231002+=GGK:SUMMA                   !Ls
!        .
         IF ((GG:DATUMS >= date(01,01,2014)) AND ~(GGK:VAL='EUR')) OR ((GG:DATUMS < date(01,01,2014)) AND ~(GGK:VAL='Ls' OR GGK:VAL='LVL'))
            D231002+=GGK:SUMMA
         ELSIF EUR_P
            D231002+=GGK:SUMMA/LBKURSS !0,702804                   !Ls vai EUR pec 01.01.2014
         .
         !Elya 04.09.2013 >
     .
  .

!********************************* ls valutam rekinam

!  IF ~(MB=SYS:NOKL_B AND PB=SYS:NOKL_PB)   !SAGLAB�JAM IZV�L�T�S BANKAS T�L�KIEM R��INIEM
!     SYS:NOKL_B=MB
!     SYS:NOKL_PB=PB
!     PUT(SYSTEM)
!  .
  NOKL_B=MB

  IF LocalResponse = RequestCompleted
!    IF PAR:KARTE   !Ir pie��irts klienta Nr
!       rekinanr=clip(par:KARTE)&'-'&CLIP(gg:dok_SENR)
!    else
       rekinanr=CLIP(gg:dok_SENR)
!    .
    rekinadatums=GG:DOKDAT
    samaksatlidz=GG:APMDAT
    GOV_REG=GETPAR_K(GG:PAR_NR,0,21)
    clear(ban:record)
    CASE PB
    OF 1
       ban:kods=par:ban_kods
       PAR_ban_NR =par:ban_NR
    OF 2
       ban:kods=par:ban_kods2
       PAR_ban_NR =par:ban_NR2
    ELSE
       PAR_ban_NR =''
       KLUDA(87,'noklus�tais partnera n/r Nr Lok�lajos datos')
    .
    IF getbankas_K(BAN:KODS,0,1)
       BANKA1='n/r : '&CLIP(PAR_BAN_NR)&' kods : '&ban:kods
       BANKA2=BAN:NOS_P
       IF PAR:BAN_KR
          BANKA3='subkonts '& PAR:BAN_KR
       .
    .
    IF  ACC_KODS_N=0  !ASSAKO R�kins
!       LaikaPeriods='Laika periods'
       DownLoad='P�c r��ina apmaksas Jums ir ties�bas leg�li izmantot visas jaun�ko versiju lejupl�des (download) no m�su interneta adreses'
       www     ='www.assakosmart.lv'
       IF SYS:TEL THEN SYS_TEL='telefons: '&SYS:TEL.
!       INFO_LINE='Labdien! Ja J�s turpm�k esat ar mieru sa�emt elektroniskos r��inus pa e-pastu, l�dzu ats�tiet apstiprin�jumu uz'
    .
    GetMyBank('')
!    BankasRekviziti=clip(rek)&' '&clip(banka)&',  kods '&bkods
    BankasRekviziti=CLIP(BVAL)&' konts '&REK[1:4]&' '&REK[5:8]&' '&REK[9:12]&' '&REK[13:16]&' '&REK[17:20]&' '&REK[21:LEN(CLIP(REK))]&' '&clip(banka)&',  kods '&bkods
    Registracija='NMR '&GL:REG_NR&' PVN '&GL:VID_NR
!!    PVN=ROUND(SUMMAKopa*(pvn_proc/100),.01)
!!    apmaksai=SUMMAKopa+PVN
!!    delta=gg:summa-apmaksai
!!    IF DELTA
!!       STOP('Neiet summas par Ls :'&format(delta,@n-_11.2))
!!       apmaksai=gg:summa
!!       pvn+=delta
!!    .
    IF GG:ATLAIDE
!       IF PECGARANTIJA=TRUE
!          ATLAIDETEXT='Di��ibeles perioda atlaide '&gg:atlaide&'%'
!       ELSE
          ATLAIDETEXT='Atlaide '&gg:atlaide&'%'
!       .
    .
!!    TEKSTS=sumvar(apmaksai,GG:VAL)
!!    FORMAT_TEKSTS(130,'Arial',10,'')
!!    sumvar1=F_TEKSTS[1]
!!    sumvar2=F_TEKSTS[2]
    IF BRIDIN1 OR BRIDIN2
       IF BRIDIN1[1:13]='Atg�din�jums:' OR BRIDIN2[1:13]='Atg�din�jums:'
          KLUDA(105,'par neapmaks�tajiem r��iniem?',,1)
          IF KLU_DARBIBA=0
             BRIDIN1=''
             BRIDIN2=''
          .
       ELSE
!          KLUDA(105,'par p�rmaksu?',,1)
!          IF KLU_DARBIBA=0
!             BRIDIN1=''
!             BRIDIN2=''
!          .
       .
    .
    IF BRIDIN3 AND BRIDIN3[1:6]='L�dzam'
       KLUDA(105,'par savlaic�gu apmaksu? Kav�jums: '&clip(dienas3)&' dienas',,1)
       IF KLU_DARBIBA=0
          BRIDIN3=''
       .
    ELSIF BRIDIN3
       KLUDA(105,'par p�cgarantijas anul��anu?',,1)
       IF KLU_DARBIBA=0
          BRIDIN3=''
       .
    .
    IF ~BRIDIN1 AND ~BRIDIN2 AND ~BRIDIN3
       ANSIFILENAME='PZP'&CLIP(GG:PAR_NR)&'.TXT'
       OPEN(OUTFILEANSI)
       IF ~ERROR()
          SET(OUTFILEANSI)
          LOOP R#=1 TO 3
             NEXT(OUTFILEANSI)
             IF ERROR()  THEN BREAK.
             EXECUTE R#
                BRIDIN1=OUTA:LINE
                BRIDIN2=OUTA:LINE
                BRIDIN3=OUTA:LINE
             .
          .
          CLOSE(OUTFILEANSI)
       .
       IF BRIDIN1 OR BRIDIN2
          KLUDA(105,'no faila'&ANSIFILENAME&'?',,1)
          IF KLU_DARBIBA=0
             BRIDIN1=''
             BRIDIN2=''
             BRIDIN3=''
          .
       .
    .
!    IF ACC_KODS=0 AND ~(PAR:ATZIME1=14 OR PAR:ATZIME2=14)
!       IF ~BRIDIN1
!         BRIDIN1='L�dzu ats�tiet savu e-mail adresi uz assako@assako.lv ,lai turpm�k var�tu Jums s�t�t e-R��inus t�pat, k� citiem.'
!       ELSIF ~BRIDIN2
!         BRIDIN2='L�dzu ats�tiet savu e-mail adresi uz assako@assako.lv ,lai turpm�k var�tu Jums s�t�t e-R��inus t�pat, k� citiem.'
!       ELSIF ~BRIDIN3
!         BRIDIN3='L�dzu ats�tiet savu e-mail adresi uz assako@assako.lv ,lai turpm�k var�tu Jums s�t�t e-R��inus t�pat, k� citiem.'
!       .
!    .
    OPEN(Report)
    SETTARGET(REPORT)
    IMAGE(188,281,2083,521,'USER.BMP')
    Report{Prop:FONT,5}=CHARSET:BALTIC
    Report{Prop:Preview} = PrintPreviewImage
    IF INSTRING('-',GG:DOK_SENR)
       VARDS=CLIP(GG:DOK_SENR) !ASSAKO -P�CGARANTIJAS
    ELSE
       VARDS=CLIP(INIGEN(GG:NOKA,15,1))&' '&CLIP(GG:DOK_SENR)
    .
    Report{Prop:Text} = CLIP(VARDS)&'XXXX'  ! DOCFOLDERP- PRIMO ATCERAS P�D�JO
 
!***********************KOR-KONTI & PVN*************************
    SAV_POSITION=POSITION(GGK:NR_KEY)

    I#=0
    CLEAR(GGK_D_K)
    CLEAR(GGK_BKK)
    CLEAR(GGK_SUMMA)
    CLEAR(PVN)
    CLEAR(GGK:RECORD)
    GGK:U_NR=GG:U_NR
    SET(GGK:NR_KEY,GGK:NR_KEY)
    LOOP
       NEXT(GGK)
       IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
       IF F:KONTI='D' !DRUK�T KONT�JUMU
          I#+=1
          IF I#=9
             KLUDA(0,'Kont�jumi ir vair�k k� 8, nav vietas uz izdrukas...')
          ELSIF I#<9
             GGK_D_K[I#]=GGK:D_K
             GGK_BKK[I#]=GGK:BKK
             GGK_SUMMA[I#]=GGK:SUMMA
          .
       .
!       IF GGK:BKK[1:3]='231'    !D/K KONTS, IESP�JAMS, KA PVN KONTA NEMAZ NEB�S
!          EXTRA_PVN_PROC=GGK:PVN_PROC
!       .
       IF GGK:D_K='K' AND ~(GGK:BKK[1:4]='5721') AND ~(GGK:BKK[1:4]='2399')   !�EMAM VISUS K, IZ�EMOT PVN KONTUS
          CASE GGK:PVN_PROC
          OF 18
          OROF 21
          OROF 22
             BASEPVN[1]+=GGK:SUMMA
          OF 9
             BASEPVN[2]+=GGK:SUMMA
          OF 5
          OROF 10
          OROF 12
             BASEPVN[4]+=GGK:SUMMA
          OF 0
             IF BAND(ggk:BAITS,00000010b) !AR PVN NEAPLIEKAMS
                BASEPVN[3]+=GGK:SUMMA
             ELSE
                BASEPVN[5]+=GGK:SUMMA !0%
             .
          .
       ELSIF GGK:BKK[1:4]='5721' OR GGK:BKK[1:4]='2399' !PVN KONTS
          CASE GGK:PVN_PROC
          OF 18
          OROF 21
          OROF 22
             PVN[1]+=GGK:SUMMAV
             PP[1]=GGK:PVN_PROC
            !Elya 04.09.2013 <
            !Rekinam valutaa paradam Ls, pec 01.01.2014 - EUR
            !Rekinam reglament.valutaa paradam EUR, pec 01.01.2014 - LVL
!             IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                PVN2[1]+=GGK:SUMMA
!             .
             IF GG:DATUMS >= date(01,01,2014)
                IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
                    PVN2[1]+=GGK:SUMMA
                ELSIF EUR_P
                    PVN2[1]+=GGK:SUMMA/LBKURSS  !1,4.....
                .
             ELSE
                IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
                    PVN2[1]+=GGK:SUMMA
                ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
                    PVN2[1]+=GGK:SUMMA/LBKURSS !0,702804
                .
             .
             !Elya 04.09.2013 >
          OF 9
             PVN[2]+=GGK:SUMMAV
             PP[2]=GGK:PVN_PROC
            !Elya 04.09.2013 <
            !Rekinam valutaa paradam Ls, pec 01.01.2014 - EUR
            !Rekinam reglament.valutaa paradam EUR, pec 01.01.2014 - LVL
!             IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                PVN2[2]+=GGK:SUMMA
!             .
             IF GG:DATUMS >= date(01,01,2014)
                IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
                    PVN2[2]+=GGK:SUMMA
                ELSIF EUR_P
                    PVN2[2]+=GGK:SUMMA/LBKURSS  !1,4.....
                .
             ELSE
                IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
                    PVN2[2]+=GGK:SUMMA
                ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
                    PVN2[2]+=GGK:SUMMA/LBKURSS !0,702804
                .
             .
             !Elya 04.09.2013 >
          OF 5
          OROF 10
          OROF 12
             PVN[4]+=GGK:SUMMAV
             PP[4]=GGK:PVN_PROC
             !Elya 04.09.2013 <
            !Rekinam valutaa paradam Ls, pec 01.01.2014 - EUR
            !Rekinam reglament.valutaa paradam EUR, pec 01.01.2014 - LVL
!            IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                PVN2[4]+=GGK:SUMMA
!             .
             IF GG:DATUMS >= date(01,01,2014)
                IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
                    PVN2[4]+=GGK:SUMMA
                ELSIF EUR_P
                    PVN2[4]+=GGK:SUMMA/LBKURSS  !1,4.....
                .
             ELSE
                IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
                    PVN2[4]+=GGK:SUMMA
                ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
                    PVN2[4]+=GGK:SUMMA/LBKURSS !0,702804
                .
             .
             !Elya 04.09.2013 >
          ELSE !lietot�ja k��da, uzskatam par neapliekamu
             PVN[3]+=GGK:SUMMAV
             PP[3]=GGK:PVN_PROC
             !Elya 04.09.2013 <
            !Rekinam valutaa paradam Ls, pec 01.01.2014 - EUR
            !Rekinam reglament.valutaa paradam EUR, pec 01.01.2014 - LVL
!             IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
!                PVN2[3]+=GGK:SUMMA
!             .
             IF GG:DATUMS >= date(01,01,2014)
                IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
                    PVN2[3]+=GGK:SUMMA
                ELSIF EUR_P
                    PVN2[3]+=GGK:SUMMA/LBKURSS  !1,4.....
                .
             ELSE
                IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
                    PVN2[3]+=GGK:SUMMA
                ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
                    PVN2[3]+=GGK:SUMMA/LBKURSS !0,702804
                .
             .
             !Elya 04.09.2013 >
          .
       .
    .
    RESET(GGK:NR_KEY,SAV_POSITION)
    NEXT(GGK)

    IF PD='P'
       piegadesdatums='Priek�apmaksa'
    ELSE
       piegadesdatums=FORMAT(piegadesdatums,@D06.)
    .

    LOOP I#=1 TO 12
       IF PrecuSumma[I#]
          LOOP J#= 12 TO 1 BY -1
             IF NUMERIC(SUB(PrecuDaudzums1[I#],1,J#))
                CENA[I#]=PrecuSumma[I#]/SUB(PrecuDaudzums1[I#],1,J#)
                BREAK
             .
          .
       .
    .
!    stop(1)
!**************Druk�jam �r� visus mas�vus***********

    IF SUMMAKOPA<0  !KRED�TR��INS
       LOOP I#=1 TO 12
          IF PRECUSUMMA1[I#]
             CENA[I#]=-CENA[I#]
             PRECUSUMMA1[I#]=-PRECUSUMMA1[I#]
             PRECUSUMMA2[I#]=-PRECUSUMMA2[I#]
          .
       .
       LOOP I#=1 TO 4
          PVN[I#]=-PVN[I#]
!          PVN2[I#]=-PVN2[I#]  LAI PALIEK M�NUSS
       .
       D23100=-D23100
       SUMMAKOPA=-SUMMAKOPA
       MAKSATAJS='Sa��m�js:'
       SANEMEJS ='Maks�t�js:'
       REKINSNR ='Kred�tr��ins Nr'
       Download =''
       ?StringRekins{PROP:TEXT}='Kred�tr��ins'
       ?StringRekins{PROP:FONTSIZE}=14
    .
    IF PD='P'       !PRIEK�APMAKSAS R��INS
       REKINSNR ='Priek�apmaksas r��ins Nr'
       ?StringRekins{PROP:TEXT}='Pr.R��ins'
       ?StringRekins{PROP:FONTSIZE}=22
    .
    IF CL_NR=1417  !KONIKA
       PRINT(RPT:det_KONIKAI)
    ELSE
       PRINT(RPT:det_Visiem)
    .
!    stop(2)

    IF F:DTK='S'  !spec. P�TERM�JA,LATIOVKV
       PRINT(RPT:detailH)
       VIRSRAKSTS=GG:SATURS
       PRINT(RPT:VIRSRAKSTS)
       LOOP J#= 1 TO 12
           IF PrecuSumma[J#] AND ~(J#=SODA_INDEX)
                 DO PRINTDETAILS
           .
        .
        IF SODA_INDEX
           J#=SODA_INDEX
           PRINT(RPT:LINE)
           DO PRINTDETAILS
        .
        PRINT(RPT:detailK)
    ELSE
       PRINT(RPT:detail)
    .
!************************* PVN ***********
    LOOP J#= 1 TO 5
       IF BASEPVN[J#] THEN DAZADI_PVN#+=1.
    .
    IF BASEPVN[1] OR PVN[1] !18%/21%/22%
       SUMK_PVN = PVN[1]
       SUMK_PVN2 = PVN2[1]
       REK_PVN = PP[1]
       IF AVANSS
          SUMK_PVN= D23100 +AVANSS*(1+PP[1]/100) -SUMMAKOPA !�IT� IR MAZ�KA VARB�T�BA K��D�TIES
          SUMK_PVN2=D231002+AVANSS2*(1+PP[1]/100)-SUMMAKOPA2
       .
       !26/01/2015 IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=CLIP(REK_PVN)&'% no '&FORMAT(BASEPVN[1],@N-_7.2).
       IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=CLIP(REK_PVN)&'% no '&FORMAT(BASEPVN[1],@N-_9.2).
       PRINT(RPT:RPT_PVN)
   .
    IF BASEPVN[2] OR PVN[2] !9%
       SUMK_PVN = PVN[2]
       SUMK_PVN2 = PVN2[2]
       REK_PVN = '9'
       IF AVANSS
          SUMK_PVN= D23100 +AVANSS*1.09 -SUMMAKOPA !�IT� IR MAZ�KA VARB�T�BA K��D�TIES
          SUMK_PVN2=D231002+AVANSS2*1.09-SUMMAKOPA2
       .
       !26/01/2015 IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=' 9% no '&FORMAT(BASEPVN[2],@N-_7.2).
       IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=' 9% no '&FORMAT(BASEPVN[2],@N-_9.2).
       PRINT(RPT:RPT_PVN)
    .
    IF BASEPVN[4] OR PVN[4] !5% VAI 10%
       SUMK_PVN = PVN[4]
       SUMK_PVN2 = PVN2[4]
       REK_PVN = PP[4]
       IF AVANSS
          SUMK_PVN= D23100 +AVANSS*(1+PP[4]/100) -SUMMAKOPA !�IT� IR MAZ�KA VARB�T�BA K��D�TIES
          SUMK_PVN2=D231002+AVANSS2*(1+PP[4]/100)-SUMMAKOPA2
       .
       !26/01/2015 IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=CLIP(REK_PVN)&'% no '&FORMAT(BASEPVN[4],@N-_7.2).
       IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=CLIP(REK_PVN)&'% no '&FORMAT(BASEPVN[4],@N-_9.2).
       PRINT(RPT:RPT_PVN)
    .
    IF BASEPVN[3] OR PVN[3]  !NEAPLIEKAMS VAI LIETOT�JA K��DA
       SUMK_PVN = PVN[3]
       SUMK_PVN2 = PVN2[3]
       REK_PVN = ''
!       IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=' 0% no '&FORMAT(BASEPVN[3],@N-_7.2).
!       BASEPVNTEXT=' 0% no '&FORMAT(BASEPVN[3],@N-_7.2)
       BASEPVNTEXT=' ar PVN neapliekams'
       PRINT(RPT:RPT_NPVN)
    .
    IF BASEPVN[5] AND ~SODANAUDA# !0%
       SUMK_PVN = 0
       SUMK_PVN2 = 0
       REK_PVN = '0'
       !26/01/2015 IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=' 0% no '&FORMAT(BASEPVN[5],@N-_7.2).
       IF DAZADI_PVN# > 1 THEN BASEPVNTEXT=' 0% no '&FORMAT(BASEPVN[5],@N-_9.2).
       PRINT(RPT:RPT_PVN)
    .
!    IF PRINTPVN#=FALSE AND NEAPLPVN#=TRUE
!       PRINT(RPT:RPT_NPVN)
!    ELSIF PRINTPVN#=FALSE     !�ITAIS MURGS IR VAJADZ�GS STARPNIEKU KOMP�NIJ�M
!       SUMK_PVN = SUMMAKOPA-SUMMAKOPA/(1+EXTRA_PVN_PROC/100)
!!       SUMK_PVN2 = SUMK_PVN  !LAI �IE IET PA GAISU...
!       REK_PVN = EXTRA_PVN_PROC
!       PRINT(RPT:RPT_PVN)
!    .
    IF ~AVANSS
       SUMK_PVN=PVN[1]+PVN[2]+PVN[3]+PVN[4]
       SUMK_PVN2=PVN2[1]+PVN2[2]+PVN2[3]+PVN2[4]
    .
    apmaksai=SUMMAKOPA+SUMK_PVN

    !Elya 04.09.2013 <
    apmaksai2=SUMMAKOPA2+SUMK_PVN2
!    IF GG:DATUMS >= date(01,01,2014)
!        stop('apmaksai2_2014')
!       IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
!           apmaksai2=SUMMAKOPA2+SUMK_PVN2
!       ELSIF EUR_P
!           pavisam2 = SUMMAKOPA2+SUMK_PVN2
!       ELSE
!           apmaksai2=SUMMAKOPA2+SUMK_PVN2
!       .
!    ELSE
!       stop('apmaksai2_')
!       IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
!           apmaksai2=SUMMAKOPA2+SUMK_PVN2
!           stop('apmaksai2_'&apmaksai2)
!       ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
!           pavisam2 = SUMMAKOPA2+SUMK_PVN2
!       ELSE
!           apmaksai2=SUMMAKOPA2+SUMK_PVN2
!       .
!    .
    !Elya 04.09.2013 >



    delta=ABS(gg:summa)-(apmaksai-AVANSS*(REK_PVN/100)) !D52100 (AVANSS) BEZ PVN
    IF DELTA
       !10/03/2015 KLUDA(0,'Neiet summas par Ls :'&format(delta,@n-_11.2))
       KLUDA(0,'Neiet summas par '&val_uzsk&' :'&format(delta,@n-_11.2))
!       apmaksai=gg:summa
    .
!    STOP(CHANGE_VAL&' '&GG_VAL&'='&VAL_NOS)

    IF CL_NR=1235 OR CL_NR=1635 OR CL_NR=1041 !ASTARTE,FORTRESS,EZERMALA
        R_BILANCE=0
        R_BILANCE2=0
    ELSIF R_BILANCE
        !10/03/2015 KLUDA(0,'Iek�aut R��in� BILANCI Ls '&R_BILANCE&' ?',7,1)
        KLUDA(0,'Iek�aut R��in� BILANCI '&val_uzsk&' '&R_BILANCE&' ?',7,1)
        IF ~KLU_DARBIBA
           R_BILANCE=0
           R_BILANCE2=0
        .
    .

    !Elya 04.09.2013 IF CHANGE_VAL=FALSE AND GG_VAL=VAL_NOS AND ~(GG_VAL='Ls' OR GG_VAL='LVL') !R UN APMAKSAS UN TEKO�AIS R VIEN� VAL�T�
    IF CHANGE_VAL=FALSE AND GG_VAL=VAL_NOS AND ((GG:DATUMS < date(01,01,2014) AND ~(GG_VAL='Ls' OR GG_VAL='LVL')) OR (GG:DATUMS >= date(01,01,2014) AND ~(GG_VAL='EUR')  )) !R UN APMAKSAS UN TEKO�AIS R VIEN� VAL�T�
!        STOP(R_BILANCE)
       IF R_BILANCE>0
          !10/03/2015 KLUDA(0,'Iek�aut r��in� par�du ? '&VAL_NOS&' '&R_BILANCE,2,1)
          KLUDA(0,'Iek�aut r��in� par�du ? '&val_uzsk&' '&R_BILANCE,2,1)
          IF KLU_DARBIBA
             R_BILANCE_S='Par�ds (BILANCE)'
          ELSE
             R_BILANCE=0
          .
       ELSE   !P�RMAKSA VAI �TR�K K� VAJADZ�JA
          IF R_BILANCE+R_N�KOTNEI<0
             R_BILANCE= R_BILANCE+R_N�KOTNEI
             !10/03/2015 KLUDA(0,'Iek�aut r��in� p�rmaksu ? '&VAL_NOS&' '&ABS(R_BILANCE),2,1)
             KLUDA(0,'Iek�aut r��in� p�rmaksu ? '&val_uzsk&' '&ABS(R_BILANCE),2,1)
             IF ~KLU_DARBIBA
                R_BILANCE=0
             .
          .
       .
!       R_BILANCE2=0 V�L VAJADZ�S LATU KOLONNAI
    !Elya 04.09.2013 ELSIF GG_VAL='Ls' OR GG_VAL='LVL' !TEKO�AIS R LATOS
    ELSIF (GG:DATUMS < date(01,01,2014) AND (GG_VAL='Ls' OR GG_VAL='LVL')) OR (GG:DATUMS >= date(01,01,2014) AND GG_VAL='EUR') !TEKO�AIS R LATOS
       IF R_BILANCE2>0
          !10/03/2015 KLUDA(0,'Iek�aut r��in� par�du ? Ls '&R_BILANCE2,2,1)
          KLUDA(0,'Iek�aut r��in� par�du ? '&val_uzsk&' '&R_BILANCE2,2,1)
          IF KLU_DARBIBA
             R_BILANCE_S='Par�ds (BILANCE)'
          ELSE
             R_BILANCE2=0
          .
       ELSE   !P�RMAKSA VAI �TR�K K� VAJADZ�JA
          IF R_BILANCE2+R_N�KOTNEI2<0
             R_BILANCE2= R_BILANCE2+R_N�KOTNEI2
             !10/03/2015 KLUDA(0,'Iek�aut r��in� p�rmaksu ? Ls '&ABS(R_BILANCE2),2,1)
             KLUDA(0,'Iek�aut r��in� p�rmaksu ? '&val_uzsk&' '&ABS(R_BILANCE2),2,1)
             IF ~KLU_DARBIBA
                R_BILANCE2=0
             .
          .
       .
       R_BILANCE=0
    ELSE
       R_BILANCE=0
       R_BILANCE2=0
    .
    IF AVANSS
       PAVISAM=APMAKSAI
       PAVISAM2=APMAKSAI2
       AVANSS=AVANSS*(1+REK_PVN/100)
       AVANSS2=AVANSS2*(1+REK_PVN/100)
       apmaksai-=AVANSS
       apmaksai2-=AVANSS2
       TEKSTS=sumvar(apmaksai,GG_VAL,0)
       FORMAT_TEKSTS(110,'Arial',10,'')
       sumvar1=F_TEKSTS[1]
       sumvar2=F_TEKSTS[2]
       PVNText1=REK_PVN&'% pievienot�s v�rt�bas nodoklis'
       SUMMAKOPA10 =APMAKSAI/(1+REK_PVN/100)
       SUMMAKOPA12 =APMAKSAI2/(1+REK_PVN/100)
       SUMK_PVN10=APMAKSAI-SUMMAKOPA10
       SUMK_PVN12=APMAKSAI2-SUMMAKOPA12
       PRINT(RPT:NOBEIGUM1)                  ! AVANSA NOBEIGUMS
       !Elya 04.09.2013 <
!       IF ~(GG_VAL='Ls' OR GG_VAL='LVL')     ! VAL�TAS P/Z SPECI�LA RINDA
!          PRINT(RPT:RPT_LS)
!       .
       IF (GG:DATUMS >= date(01,01,2014) AND ~(GG_VAL='EUR')) OR (GG:DATUMS < date(01,01,2014) AND ~(GG_VAL='Ls' OR GG_VAL='LVL'))
          PRINT(RPT:RPT_LS)
       .
       !Elya 04.09.2013 >


    ELSIF R_BILANCE                   !PAR�DS UN TEKO�AIS VIEN� VAL�T�

       PAVISAM=APMAKSAI
       PAVISAM2=APMAKSAI2
       apmaksai+=R_BILANCE
! STOP(Apmaksai&'  '&R_BILANCE)
       apmaksai2+=R_BILANCE2
       IF APMAKSAI<0 THEN APMAKSAI=0.
!       IF APMAKSAI2<0 THEN APMAKSAI2=0.
       TEKSTS=sumvar(apmaksai,GG_VAL,0)
       FORMAT_TEKSTS(110,'Arial',10,'')
       sumvar1=F_TEKSTS[1]
       sumvar2=F_TEKSTS[2]
!       PVNText1=REK_PVN&'% pievienot�s v�rt�bas nodoklis'
       PRINT(RPT:NOBEIGUM2)
       !Elya 04.09.2013 <
!       IF ~(GG_VAL='Ls' OR GG_VAL='LVL')     ! VAL�TAS P/Z SPECI�LA RINDA
!          PRINT(RPT:RPT_LS)
!       .
       IF (GG:DATUMS >= date(01,01,2014) AND ~(GG_VAL='EUR')) OR (GG:DATUMS < date(01,01,2014) AND ~(GG_VAL='Ls' OR GG_VAL='LVL'))
          PRINT(RPT:RPT_LS)
       ELSIF EUR_P
          PRINT(RPT:RPT_LS)
       .
       !Elya 04.09.2013 >
    ELSIF R_BILANCE2                   !PAR�DS UN TEKO�AIS Ls
       !Elya 12.09.2013 <
!       PAVISAM=APMAKSAI
!!       PAVISAM2=APMAKSAI2
!       R_BILANCE=R_BILANCE2
!       R_BILANCE2=0
!       apmaksai+=R_BILANCE
!! STOP(Apmaksai&'  '&R_BILANCE)
!!       apmaksai2+=R_BILANCE2
!       IF APMAKSAI<0 THEN APMAKSAI=0.
!!       IF APMAKSAI2<0 THEN APMAKSAI2=0.
       IF EUR_P
          PAVISAM=APMAKSAI
          PAVISAM2=APMAKSAI2
          R_BILANCE=R_BILANCE2
          apmaksai+=R_BILANCE2
          R_BILANCE2=R_BILANCE2/LBKURSS
          apmaksai2+=R_BILANCE2
          IF APMAKSAI<0 THEN APMAKSAI=0.
          IF APMAKSAI2<0 THEN APMAKSAI2=0.
       ELSE
          PAVISAM=APMAKSAI
          R_BILANCE=R_BILANCE2
          R_BILANCE2=0
          apmaksai+=R_BILANCE
          IF APMAKSAI<0 THEN APMAKSAI=0.
       .
       !Elya 12.09.2013 >
       TEKSTS=sumvar(apmaksai,GG_VAL,0)
       FORMAT_TEKSTS(110,'Arial',10,'')
       sumvar1=F_TEKSTS[1]
       sumvar2=F_TEKSTS[2]
!       PVNText1=REK_PVN&'% pievienot�s v�rt�bas nodoklis'
       PRINT(RPT:NOBEIGUM2)
!       IF ~(GG_VAL='Ls' OR GG_VAL='LVL')     ! VAL�TAS P/Z SPECI�LA RINDA
!          PRINT(RPT:RPT_LS)
!       .
       !Elya 12.09.2013 <
       IF EUR_P
          PRINT(RPT:RPT_LS)
       .
       !Elya 12.09.2013 >

    ELSE
       TEKSTS=sumvar(apmaksai,GG_VAL,0)
       FORMAT_TEKSTS(110,'Arial',10,'')
       sumvar1=F_TEKSTS[1]
       sumvar2=F_TEKSTS[2]
       PRINT(RPT:NOBEIGUMS)                  ! Ls/Ls&VAL NOBEIGUMS
       !Elya 04.09.2013 <
!       IF ~(GG_VAL='Ls' OR GG_VAL='LVL')     ! VAL�TAS P/Z SPECI�LA RINDA
!          PRINT(RPT:RPT_LS)
!       .
       IF (GG:DATUMS >= date(01,01,2014) AND ~(GG_VAL='EUR')) OR (GG:DATUMS < date(01,01,2014) AND ~(GG_VAL='Ls' OR GG_VAL='LVL'))
          PRINT(RPT:RPT_LS)
       ELSIF EUR_P
          PRINT(RPT:RPT_LS)
       .
       !Elya 04.09.2013 >
   .
    IF CL_NR=1417 OR F:DTK='S'        !KONIKA,P�TERM�JA,LATIO
       PRINT(RPT:ASTE_KONIKAI)
    ELSE
       PRINT(RPT:ASTE)
    .
!    stop(3)
    ENDPAGE(Report)
    IF ACC_KODS_N=0  !ASSAKO
       PR:SKAITS=1
    ELSE
       PR:SKAITS=2
    .
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
  CLOSE(Report)
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
      StandardWarning(Warn:RecordFetchError,'REKINI')
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
PRINTDETAILS ROUTINE
  IF J#=2 AND PrecuPVN[J#]=0  !VIENM�R PIRMS 2. RINDAS, JA NEAPLIEKAMIE VISP�R IR
     VIRSRAKSTS='Komun�lie pakalpojumi'
     PRINT(RPT:VIRSRAKSTS)
  ELSIF ~(SAV_PVN=PrecuPVN[J#]) AND ~(J#=SODA_INDEX)
     VIRSRAKSTS='PVN '&PrecuPVN[J#]&'% apliekamie pakalpojumi'
     PRINT(RPT:VIRSRAKSTS)
     SAV_PVN=PrecuPVN[J#]
  .
  PrecuNosaukums1J=PrecuNosaukums[J#]
  CENAJ           =CENA[J#]
  PrecuSumma1J    =PrecuSumma[J#]
  !Elya 08.10.2013 <
  IF GG:DATUMS >= date(01,01,2014)
     IF ~(GGK:VAL='EUR')        ! ggk:summa jau ir euros
         PrecuSumma2J = PrecuSumma1J
     ELSIF EUR_P
         PrecuSumma2J = PrecuSumma1J/LBKURSS  !Ls pirms atlaides
     .
  ELSE
     IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')        ! ggk:summa jau ir latos
         PrecuSumma2J = PrecuSumma1J
     ELSIF EUR_P    ! ggk:summa ir latos un ggk:summav ir latos, vajag parrekinat euros
         PrecuSumma2J = PrecuSumma1J/LBKURSS  !Ls pirms atlaides
     .
  .
  !Elya 08.10.2013 >
  PrecuDaudzums1J =PrecuDaudzums1[J#]
  PRINT(RPT:detailS)

!-----------------------------------------------------------------------------

FILLPARAKSTI ROUTINE        !S�KUMS & BUTTON:MAKARONI & OK.
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  SYS_AMATS   =GETPARAKSTI(SYS_PARAKSTS_NR,2)
  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
     CTRL#=VAL(CODE39[1])+VAL(GG:DOK_SENR[1])+VAL(GG:NOKA[1])
     CODE39=GETPARAKSTI(SYS_PARAKSTS_NR,3,CTRL#)
     IF GG:DATUMS>=DATE(5,11,2011)
        CODE39_TEXT='Elektroniski apliecina '&CLIP(SYS_AMATS)&' '&CLIP(SYS_PARAKSTS)
     ELSE
        !24/04/2013 CODE39_TEXT='R��ins sagatavots elektroniski un ir der�gs bez paraksta'
        CODE39_TEXT='' !24/04/2013 
     .
     CODE39_TEXT_2='R��ins ir sagatavots elektroniski un der�gs bez paraksta.' !24/04/2013
     SYS_PARAKSTS=''
     SYS_AMATS=''
     SvitraParakstam=''
  ELSE
     SvitraParakstam='_{28}'
     CODE39=''
     CODE39_TEXT_2='' !24/04/2013
     CODE39_TEXT=''
  .
  DISPLAY

OMIT('MARIS')
FILLPARAKSTI ROUTINE        !S�KUMS & BUTTON:MAKARONI & OK.
  EXECUTE SYS_PARAKSTS_NR+1 !SYS_PARAKSTS_NR ~GLOBAL ...TIEKAM GAL� AR DRUKU
     SYS_PARAKSTS=''
     SYS_PARAKSTS=SYS:PARAKSTS1
     SYS_PARAKSTS=SYS:PARAKSTS2
     SYS_PARAKSTS=SYS:PARAKSTS3
     SYS_PARAKSTS=SEC:VUT
     SYS_PARAKSTS=''   !E-ME      !6
  .
!  stop(sys_baits)
  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
     UNHIDE(?Image:Makaroni)
     LEN#=LEN(CLIP(SYS_PARAKSTS))
     CODE39=UPPER(INIGEN(SYS_PARAKSTS,LEN#,1))
     CODE39='*'&CLIP(CODE39)&CLIP(VAL(CODE39[1])+VAL(GG:DOK_SENR[1])+VAL(GG:NOKA[1]))&'*'
     CODE39_TEXT='R��ins sagatavots elektroniski un ir der�gs bez paraksta'
     SYS_PARAKSTS=''
     SYS_AMATS=''
     SvitraParakstam=''
  ELSE
     HIDE(?Image:Makaroni)
     EXECUTE SYS_PARAKSTS_NR+1
        SYS_AMATS=''
        SYS_AMATS=SYS:AMATS1
        SYS_AMATS=SYS:AMATS2
        SYS_AMATS='Kasieris'
        SYS_AMATS=''   !LOGIN
        SYS_AMATS=''   !E-ME
     .
     CODE39=''
     SvitraParakstam='_{28}'
     CODE39_TEXT=''
  .
  DISPLAY
MARIS
PerformGL            FUNCTION (OPC,<DOK_SENR>)    ! Declare Procedure
NR    DECIMAL(13) !D�� SV�TRU KODA
SNR   STRING(14)
  CODE                                            ! Begin processed code
  checkopen(GLOBAL,1)
  checkopen(SYSTEM,1)
  IF ~INRANGE(OPC,1,12)
     RETURN('')
  .
  IF DOK_SENR         !JAU IR PIE��IRTS
     RETURN(DOK_SENR)
  .
  EXECUTE(OPC)
     NR=GL:MAU_NR     !1
     NR=GL:KIE_NR     !2
     NR=GL:KIZ_NR     !3
     NR=GL:IESK_NR    !4  IESKAITS
     NR=GL:REK_NR     !5  R��INS
     NR=GL:PIL_NR     !6  PILNVARA
     NR=GL:EAN_NR     !7  SV�TRU KODS, J�B�T >= 20+11 0-ES
     NR=SYS:PZ_NR     !8  tikai BASE
     NR=GL:INVOICE_NR !9  INVOICE
     NR=GL:GARANT_NR  !10 GARANTIJAS LAPA
     NR=GL:RIK_NR     !11 R�KOJUMS
     NR=GL:FREE_N     !12 PAGAID�M RE�.DATUMS
  .
  IF (OPC<7 AND ~(NR=999999)) OR (OPC=7 AND NR>0) OR (OPC>7 AND ~(NR=999999)) ! NUMUR�CIJA NAV ATCELTA
     NR+=1
     EXECUTE(OPC)
        GL:MAU_NR=NR
        GL:KIE_NR=NR
        GL:KIZ_NR=NR
        GL:IESK_NR=NR   !4
        GL:REK_NR=NR
        GL:PIL_NR=NR
        GL:EAN_NR=NR    !7
        BEGIN           !8
           SYS:PZ_NR=NR !B�Z� S�K.NR VISU LAIKU PALIELINAM
           IF ~SYS:PZ_NR_END
              KLUDA(0,'Nav nor�d�ts PPR numer�cijas beigu apgabals Lok�lajos datos...')
           ELSIF SYS:PZ_NR_END<NR
              KLUDA(0,'Beidzies PPR numer�cijas apgabals Lok�lajos datos...')
              SYS:PZ_NR-=1
              NR=0
           ELSIF INRANGE(SYS:PZ_NR_END-NR,0,5)
              KLUDA(0,'PPR numer�cijas apgabal� v�l atliku�as '&CLIP(SYS:PZ_NR_END-NR)&' pavadz�mes')
           .
        .
        GL:INVOICE_NR=NR !9
        GL:GARANT_NR =NR !10
        GL:RIK_NR    =NR !11
!        GL:FREE_N    =NR !12
     .
     IF OPC=8
        PUT(SYSTEM)
     ELSE
        PUT(GLOBAL)
     .
  ELSE
     NR=0
  .
  IF OPC=7 AND BAND(GL:BAITS,00000001b) AND INRANGE(NR,200000000000,209999999998)!J��ENER� SV�TRU KODS
     NR=CHECKEAN(NR*10,0)
  .
  IF NR THEN SNR=NR.               !LAI TIKTU VA�� NO 0-ES
  IF OPC=10 THEN SNR='0'&CLIP(NR). !WOLKSW��IM VAJAG NR TIPA 0700001
  RETURN(SNR)
FORMAT_TEKSTS        PROCEDURE (MAX_R_MM1,FONT,SIZE,BOLD,MAX_R_MM2,MAX_R_MM3) ! Declare Procedure
TOT_GARUMS      LONG
BURTS           STRING(1)
BURTA_MM        DECIMAL(5,2)
RINDAS_MM       DECIMAL(6,2)
RINDAS_BAITI    BYTE
GARUMS          BYTE
MAX_RINDAS_MM   BYTE,DIM(3)
  CODE                                            ! Begin processed code
 CLEAR(F_TEKSTS)
 LASTBREAK#  =0
 STARTPOINT# =1
 I#   =0
 MAX_RINDAS_MM[1]=MAX_R_MM1
 IF MAX_R_MM2
    MAX_RINDAS_MM[2]=MAX_R_MM2
 ELSE
    MAX_RINDAS_MM[2]=MAX_R_MM1
 .
 IF MAX_R_MM3
    MAX_RINDAS_MM[3]=MAX_R_MM3
 ELSE
    MAX_RINDAS_MM[3]=MAX_R_MM1
 .


 IF FONT='WINDOW'
     garums=max_r_mm1    !Rindas garums BAITOS
 .
 LOOP I#= 1 TO 3                               !B�V�JAM MAX 3 RINDAS
   RINDAS_MM=0
   RINDAS_BAITI=0
   SKIPBreak#=FALSE
   LOOP J#= STARTPOINT# TO LEN(CLIP(TEKSTS))
      IF J#>250                                !MAX LEN(TEKSTS)=250
         BREAK
      .
      IF J# = LEN(CLIP(TEKSTS))                !TEKSTA BEIGAS
         LASTBREAK# = J#
         BREAK
      .
      IF INSTRING(TEKSTS[J#],' ,;&#')          !IESP�JAM� RINDAS DAL�JUMA VIETA
         LASTBREAK# = J#
      .
      IF TEKSTS[J#]='.'                        !LAI NEDAL�TU PIEM�RAM: Ls 25.00
         IF J#>1
           IF ~(NUMERIC(TEKSTS[J#-1]) AND NUMERIC(TEKSTS[J#+1]))
              LASTBREAK# = J#
           .
         .
      .
      IF TEKSTS[J#]='-'                        !LAI NEDAL�TU PIEM�RAM: LV-1014
         IF J#>2
           IF ~(TEKSTS[J#-2:J#-1]='LV')
              LASTBREAK# = J#
           .
         .
      .
      CASE FONT
      OF 'WINDOW'                                 !P�C DEFIN�CIJAS GARUMA
         RINDAS_BAITI+=1                          !TEKO�AIS RINDAS GARUMS
         IF RINDAS_BAITI > GARUMS                 !Rindas garums BAITOS > NEK� IESP�JAMS
!   STOP(RINDAS_BAITI&' '&J#&' '&LASTBREAK#&' '&TEKSTS[J#])
            IF RINDAS_BAITI=LASTBREAK#            !N�KO�AIS RIND� IR BREAKS
               SKIPBreak#=TRUE                    !LAI N�KO�� NES�KAS AR BREIKU
               LASTBREAK# = J#-1                  !C�rtam, kur BIJ�M
            ELSIF J#-LASTBREAK#>20                !Iesp�jamais p�rtraukums ir vair�k k� 20 baitus atpaka�
               LASTBREAK# = J#-1                  !C�rtam, kur BIJ�M
            .
            BREAK
         .
      ELSE  !IZDRUKA
         BURTS=TEKSTS[J#]
         DO CALCMM
         RINDAS_MM += BURTA_MM
         IF RINDAS_MM > MAX_RINDAS_MM[I#]         !Rindas garums mm > NEK� IESP�JAMS
            IF RINDAS_BAITI=LASTBREAK#            !N�KO�AIS RIND� IR BREAKS
               SKIPBreak#=TRUE                    !LAI N�KO�� NES�KAS AR BREIKU
               LASTBREAK# = J#-1                  !C�rtam, kur BIJ�M
            ELSIF J#-LASTBREAK#>20                !Iesp�jamais p�rtraukums ir vair�k k� 20 baitus atpaka�
               LASTBREAK# = J#-1                  !C�rtam, kur BIJ�M
            .
            BREAK
         .
      .
   .
   F_TEKSTS[I#]=TEKSTS[STARTPOINT#:LASTBREAK#]
   STARTPOINT#=LASTBREAK#+1 !N�KO�AIS
   IF SKIPBreak#
      STARTPOINT#+=1        !IZLAI�AM BREAKPOINTU
   .
   IF STARTPOINT#>=LEN(CLIP(TEKSTS)) THEN BREAK.         !APTURAM LOOPU
 .

CALCMM ROUTINE
 K#=INSTRING(BURTS,'A�BC�DE�FG�HI�JK�L�MN�OPRS�TU�VZ�XYQWa�bc�de�fg�hi�jk�l�mn�oprs�tu�vz�xyqw1234567890`~!@#$%^&*()-_=+|\[]?.,/ ')
!                   1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
 IF K#
   EXECUTE K#
     BURTA_MM=1.90   !A
     BURTA_MM=1.90   !�
     BURTA_MM=1.90   !B
     BURTA_MM=2.04   !C
     BURTA_MM=2.04   !�
     BURTA_MM=2.04   !D
     BURTA_MM=1.90   !E
     BURTA_MM=1.90   !�
     BURTA_MM=1.74   !F
     BURTA_MM=2.2    !G
     BURTA_MM=2.2    !�
     BURTA_MM=2.04   !H
     BURTA_MM=0.8    !I
     BURTA_MM=0.82   !�
     BURTA_MM=1.44   !J
     BURTA_MM=1.90   !K
     BURTA_MM=1.90   !�
     BURTA_MM=1.56   !L
     BURTA_MM=1.56   !�
     BURTA_MM=2.32   !M
     BURTA_MM=2.04   !N
     BURTA_MM=2.04   !�
     BURTA_MM=2.2    !O
     BURTA_MM=1.90   !P
     BURTA_MM=2.04   !R
     BURTA_MM=1.90   !S
     BURTA_MM=1.90   !�
     BURTA_MM=1.74   !T
     BURTA_MM=2.04   !U
     BURTA_MM=2.04   !�
     BURTA_MM=1.90   !V
     BURTA_MM=1.74   !Z
     BURTA_MM=1.74   !�
     BURTA_MM=1.82   !X
     BURTA_MM=1.90   !Y
     BURTA_MM=2.2    !Q
     BURTA_MM=2.8    !W
     BURTA_MM=1.56   !a
     BURTA_MM=1.56   !�
     BURTA_MM=1.56   !b
     BURTA_MM=1.44   !c
     BURTA_MM=1.44   !�
     BURTA_MM=1.56   !d
     BURTA_MM=1.56   !e
     BURTA_MM=1.56   !�
     BURTA_MM=0.82   !f
     BURTA_MM=1.56   !g
     BURTA_MM=1.56   !�
     BURTA_MM=1.56   !h
     BURTA_MM=0.64   !i
     BURTA_MM=0.76   !�
     BURTA_MM=0.64   !j
     BURTA_MM=1.44   !k
     BURTA_MM=1.44   !�
     BURTA_MM=0.64   !l
     BURTA_MM=0.64   !�
     BURTA_MM=2.4    !m
     BURTA_MM=1.56   !n
     BURTA_MM=1.56   !�
     BURTA_MM=1.56   !o
     BURTA_MM=1.56   !p
     BURTA_MM=0.94   !r
     BURTA_MM=1.44   !s
     BURTA_MM=1.44   !�
     BURTA_MM=0.8    !t
     BURTA_MM=1.56   !u
     BURTA_MM=1.56   !�
     BURTA_MM=1.4    !v
     BURTA_MM=1.4    !z
     BURTA_MM=1.4    !�
     BURTA_MM=1.36   !x
     BURTA_MM=1.4    !y
     BURTA_MM=1.56   !q
     BURTA_MM=2.0    !w
     BURTA_MM=1.56   !1
     BURTA_MM=1.56   !2
     BURTA_MM=1.56   !3
     BURTA_MM=1.56   !4
     BURTA_MM=1.56   !5
     BURTA_MM=1.56   !6
     BURTA_MM=1.56   !7
     BURTA_MM=1.56   !8
     BURTA_MM=1.56   !9
     BURTA_MM=1.56   !0
     BURTA_MM=0.94   !`
     BURTA_MM=1.66   !~
     BURTA_MM=0.94   !!
     BURTA_MM=2.88   !@
     BURTA_MM=1.58   !#
     BURTA_MM=1.58   !$
     BURTA_MM=2.54   !%
     BURTA_MM=1.28   !^
     BURTA_MM=1.90   !&
     BURTA_MM=1.10   !*
     BURTA_MM=0.94   !(
     BURTA_MM=0.94   !)
     BURTA_MM=0.94   !-
     BURTA_MM=1.58   !_
     BURTA_MM=1.66   !'='
     BURTA_MM=1.66   !+
     BURTA_MM=0.72   !|
     BURTA_MM=0.80   !\
     BURTA_MM=0.80   ![
     BURTA_MM=0.80   !]
     BURTA_MM=1.56   !?
     BURTA_MM=0.80   !.
     BURTA_MM=0.80   !,
     BURTA_MM=0.80   !/
     BURTA_MM=0.80   !'' v smisle probel ;-)))
   END
 ELSE
   BURTA_MM=1.5   ! P�R�JIE
 .
 CASE SIZE
 OF 8
    ! *1
 OF 9
    BURTA_MM=BURTA_MM*1.125
 OF 10
    BURTA_MM=BURTA_MM*1.25
 OF 12
    BURTA_MM=BURTA_MM*1.50   !?
 OF 18
    BURTA_MM=BURTA_MM*2      !?
 ELSE
    STOP('FORMAT_TEKSTS:SIZE='&SIZE)
 .



OMIT('MARIS')
LOOP I#= 1 TO 3      !B�V�JAM MAX 3 RINDAS
   TOT_GARUMS=LEN(CLIP(TEKSTS))
   K#=GARUMS*I#
   IF K#+1>200 THEN BREAK.                     ! JA NEATRODAM, C�RTAM UZ GARUMU
   LOOP J#=GARUMS*I#+1 TO GARUMS*I#-15 BY -1   ! ANALIZ�JAM 15 BAITUS ATPAKA�
      IF INSTRING(TEKSTS[J#],' .,;')           ! RINDAS DAL�JUMA VIETA
         K#=J#
         BREAK
      .
   .
   TEKSTS[GARUMS*I#+1:200]=TEKSTS[K#+1:TOT_GARUMS] ! NOB�DAM
   LOOP L#= K#+1 TO GARUMS*I#
      TEKSTS[L#] = ' '                             ! NOT�RAM
   .
.
MARIS
