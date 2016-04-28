                     MEMBER('winlats.clw')        ! This is a MEMBER module
CUT0                 FUNCTION (CENA,DECMAX,DECREQ,<DECDEL>,<COMPRESS>) ! Declare Procedure
Cena_s       string(15)
  CODE                                            ! Begin processed code

!
! DECMAX - MAX ZÎMJU SKAITS AIZ KOMATA
! DECREQ - OBLIGÂTAIS ZÎMJU SKAITS AIZ KOMATA
! DECDEL - DECIMÂLAIS ATDALÎTÂJS (0=. 1=`)
! COMPRESS - 1=NOVÂKT TUKÐUMUS PRIEKÐÂ
!

 IF CENA=0 AND DECREQ=0
    RETURN('')
 .
 IF DECDEL
    EXECUTE DECMAX
       CENA_S = FORMAT(CENA,@N-_15`1)
       CENA_S = FORMAT(CENA,@N-_15`2)
       CENA_S = FORMAT(CENA,@N-_15`3)
       CENA_S = FORMAT(CENA,@N-_15`4)
       CENA_S = FORMAT(CENA,@N-_15`5)
    .
 ELSE
    EXECUTE DECMAX
       CENA_S = FORMAT(CENA,@N-_15.1)
       CENA_S = FORMAT(CENA,@N-_15.2)
       CENA_S = FORMAT(CENA,@N-_15.3)
       CENA_S = FORMAT(CENA,@N-_15.4)
       CENA_S = FORMAT(CENA,@N-_15.5)
    .
 .
! STOP(CENA&'='&CENA_S)
 IF DECREQ=0
    POINT#=15-DECMAX+DECREQ         !LAI NOVÂKTU '.'
 ELSE
    POINT#=15-DECMAX+DECREQ+1
 .
 LOOP I#= 15 TO POINT# BY -1
    IF INSTRING(CENA_S[I#],'0.,')
       CENA_S[I#]=CHR(32)
    ELSE
       BREAK
    END
 .
! STOP(CENA&'='&CENA_S)
 IF COMPRESS 
    RETURN(CLIP(LEFT(CENA_S)))
 ELSE
    RETURN(CENA_S)
 .
P_PamKarGD           PROCEDURE                    ! Declare Procedure
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
VERT_S               SREAL
uzsk_v               SREAL
KAT_NR               STRING(4)
LIKME                STRING(10)
! Pçc ailes numura
S0                   DATE
S2                   DATE
S3                   DECIMAL(11,2)
S4                   DECIMAL(11,2)
s5                   decimal(11,2)
S6                   DECIMAL(11,2)
s7                   decimal(11,2)
S8                   DECIMAL(11,2)
S9                   DECIMAL(11,2)
s10                  decimal(11,2)
S11                  DECIMAL(11,2)
S12                  DECIMAL(2)
S13                  string(20)     ! aprçíins
s14                  decimal(11,2)
s15                  decimal(11,2)
s16                  decimal(11,2)
RPT_GADS             DECIMAL(4)
A2                   DATE
A3                   DECIMAL(11,2)
A4                   DECIMAL(11,2)
A6                   DECIMAL(11,2)
A8                   DECIMAL(11,2)
A9                   DECIMAL(11,2)
A11                  DECIMAL(11,2)
A12                  DECIMAL(11,2)
A13                  DECIMAL(12,2)
B2                   DATE
B4                   DECIMAL(11,2)
B6                   DECIMAL(11,2)
B8                   DECIMAL(11,2)
B9                   DECIMAL(11,2)
B13                  DECIMAL(12,2)

Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_G_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:IZSLEGTS)
                       PROJECT(AMO:SKAITS)
                     END

report REPORT,AT(100,902,12000,7000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(100,100,12000,802)
         STRING('Nodokïiem'),AT(9979,156),USE(?String70:2) 
         STRING(@s45),AT(1771,156,3490,208),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('PAMATLÎDZEKÏA  ANALÎTISKÂS  UZSKAITES  UN  NOLIETOJUMA  APRÇÍINA  KARTE  Nr'),AT(729,469), |
             USE(?String2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_6),AT(7344,469),USE(PAM:U_NR),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma nosaukums :'),AT(208,156,1563,208),USE(?String7),LEFT,FONT(,10,,)
       END
Page_head DETAIL,AT(,,,3677)
         STRING('Pamatlîdzekïa nosaukums (un kods)'),AT(208,104),USE(?String62:5)
         STRING('Apdroðinâðana'),AT(7448,0),USE(?String62:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Atraðanâs vieta'),AT(208,313),USE(?String62)
         STRING('Apdroðinâðanas sabiedrîba'),AT(5938,313),USE(?String62:8)
         LINE,AT(1146,469,4583,0),USE(?Line63:2),COLOR(COLOR:Black)
         STRING('Iegâdes datums un pamatojums'),AT(208,521),USE(?String62:2)
         STRING('Polise Nr'),AT(5938,521),USE(?String62:9)
         STRING('Summa'),AT(8177,521),USE(?String62:10)
         LINE,AT(6510,677,1615,0),USE(?Line63:11),COLOR(COLOR:Black)
         LINE,AT(8646,677,1198,0),USE(?Line63:12),COLOR(COLOR:Black)
         LINE,AT(2135,677,3594,0),USE(?Line63:3),COLOR(COLOR:Black)
         LINE,AT(7604,469,2240,0),USE(?Line63:10),COLOR(COLOR:Black)
         LINE,AT(208,885,5521,0),USE(?Line63:4),COLOR(COLOR:Black)
         LINE,AT(2448,260,3281,0),USE(?Line63),COLOR(COLOR:Black)
         STRING('Nodoðanas ekspluatâcijâ datums'),AT(208,938),USE(?String62:12)
         LINE,AT(2240,1094,3490,0),USE(?Line63:5),COLOR(COLOR:Black)
         LINE,AT(6563,1094,3281,0),USE(?Line63:13),COLOR(COLOR:Black)
         STRING('Izslçgðanas datums un pamatojums'),AT(208,1146),USE(?String62:3)
         STRING('Sâkotnçjâ uzskaites vçrtîba, Ls'),AT(5938,1146),USE(?String62:13)
         STRING('Kategorija'),AT(5938,938),USE(?String62:11)
         LINE,AT(2396,1302,3333,0),USE(?Line63:6),COLOR(COLOR:Black)
         LINE,AT(7865,1302,1979,0),USE(?Line63:14),COLOR(COLOR:Black)
         STRING('Likvidâcijas (lûþòu) vçrtîba, Ls'),AT(5938,1354),USE(?String62:14)
         LINE,AT(208,1510,5521,0),USE(?Line63:7),COLOR(COLOR:Black)
         LINE,AT(7760,1510,2083,0),USE(?Line63:15),COLOR(COLOR:Black)
         STRING('Kartes atvçrðanas datums'),AT(208,1563),USE(?String62:4)
         STRING('Gada nolietojuma likme'),AT(5938,1563),USE(?String62:15)
         STRING('(latos)'),AT(10156,1823),USE(?String70:22) 
         LINE,AT(1823,1719,3906,0),USE(?Line63:8),COLOR(COLOR:Black)
         LINE,AT(7396,1719,2448,0),USE(?Line63:16),COLOR(COLOR:Black)
         STRING('Piezîmes'),AT(208,1771),USE(?String62:6)
         LINE,AT(781,1927,4948,0),USE(?Line63:9),COLOR(COLOR:Black)
         LINE,AT(208,2031,0,1667),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(1667,2031,0,1667),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2396,2031,0,1667),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4375,2031,0,1667),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6198,2031,0,1667),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6875,2031,0,1667),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7604,2031,0,1667),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7917,2031,0,1667),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9115,2031,0,1667),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(10573,2031,0,1667),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Taksâ-'),AT(260,2083,521,208),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojoðâ'),AT(833,2083,833,208),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,2031,0,1667),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('periods'),AT(260,2500,521,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes vçrtîba'),AT(1771,2083,365,1302),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Kapitâlâs izmaksas'),AT(2500,2083,365,1302),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3125,2031,0,1667),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('Pârvçrtçðana'),AT(3177,2083,1198,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(4427,2083,1771,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamat-'),AT(6250,2083,625,156),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Likme % (dubultotâ)'),AT(7656,2083,260,1198),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Taksâcijas perioda'),AT(7969,2083,1146,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkrâtais nolietojums'),AT(9323,2083,208,1302),USE(?String18:53),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('nodokïiem'),AT(9583,2083,208,1302),USE(?String18:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('Atlikusî'),AT(9896,2083,677,156),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9844,2031,0,1667),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Atlikusî'),AT(6927,2083,677,156),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('"+"'),AT(3177,2344,573,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3750,2292,0,1406),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('sâkotnçjâ'),AT(4531,2344,208,990),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('vçrtîba'),AT(4740,2344,208,990),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(5000,2292,0,1406),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('koriìçtâ'),AT(6250,2396,625,156),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojums'),AT(7969,2292,1146,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no kuras'),AT(6927,2396,677,156),USE(?String18:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(9896,2396,677,156),USE(?String18:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un datums'),AT(833,2500,833,208),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7917,2500,1198,0),USE(?Line80:2),COLOR(COLOR:Black)
         STRING('aprçíins'),AT(7969,2552,677,208),USE(?String18:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8646,2500,0,1198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('summa'),AT(8698,2552,365,573),USE(?String18:52),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('perioda'),AT(9896,2552,677,156),USE(?String18:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(6250,2865,625,156),USE(?String18:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(6250,3021,625,156),USE(?String18:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojumu'),AT(6927,3021,677,156),USE(?String18:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ðanas'),AT(9896,3021,677,156),USE(?String18:63),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(6927,2865,677,156),USE(?String18:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitî-'),AT(9896,2865,677,156),USE(?String18:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(11.*12.:100)'),AT(7969,2760,677,208),USE(?String18:51),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietoj.'),AT(9896,2708,677,156),USE(?String18:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta Nr'),AT(833,2292,833,208),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,3385,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(260,3438,521,208),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(833,3438,833,208),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1719,3438,677,208),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(2448,3438,677,208),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(3177,3438,573,208),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(3802,3438,573,208),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(4427,3438,573,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(5052,3438,469,208),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(5729,3438,469,208),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(6250,3438,625,208),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(6927,3438,677,208),USE(?String18:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(7656,3438,260,208),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(7969,3438,677,208),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(8698,3438,417,208),USE(?String18:61),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15'),AT(9167,3438,677,208),USE(?String18:60),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16'),AT(9896,3438,677,208),USE(?String18:59),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíina'),AT(6927,2552,677,156),USE(?String18:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(6250,2552,625,156),USE(?String18:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba (7. - 8.)'),AT(5938,2344,208,990),USE(?String18:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('taksâcijas'),AT(6250,2708,625,156),USE(?String18:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(6927,2708,677,156),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzkrâtais'),AT(5052,2344,208,990),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('atlikusî'),AT(5729,2344,208,990),USE(?String18:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('nolietojums'),AT(5260,2344,208,990),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(5625,2292,0,1406),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('"-"'),AT(3802,2344,573,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3125,2292,3073,0),USE(?Line80),COLOR(COLOR:Black)
         STRING('lîdzekïa'),AT(6250,2240,625,156),USE(?String18:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba,'),AT(6927,2240,677,156),USE(?String18:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba pçc'),AT(9896,2240,677,156),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('cijas'),AT(260,2292,521,208),USE(?String18:62),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,3646,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(208,2031,10365,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(5052,10,573,156),USE(S8),RIGHT 
         LINE,AT(5625,-10,0,270),USE(?Line32:8),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,270),USE(?Line32:0),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6250,10,625,156),USE(S10),RIGHT 
         LINE,AT(6875,-10,0,270),USE(?Line32:9),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line32:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6927,10,677,156),USE(S11),RIGHT 
         LINE,AT(9115,-10,0,270),USE(?Line32:2),COLOR(COLOR:Black)
         STRING(@N2),AT(7656,10,,156),USE(S12),RIGHT 
         STRING(@N-_12.2B),AT(9896,10,677,156),USE(S16),RIGHT 
         LINE,AT(9844,-10,0,270),USE(?Line32:3),COLOR(COLOR:Black)
         STRING(@s20),AT(7969,10,677,156),USE(S13),LEFT 
         STRING(@N-_12.2B),AT(8698,10,417,156),USE(S14),RIGHT 
         STRING(@N-_11.2B),AT(5677,10,521,156),USE(S9),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line32:4),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line32:5),COLOR(COLOR:Black)
         LINE,AT(1667,-10,0,270),USE(?Line32:6),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(1719,10,677,156),USE(S3),RIGHT 
         LINE,AT(2396,-10,0,270),USE(?Line32:16),COLOR(COLOR:Black)
         LINE,AT(3125,-10,0,270),USE(?Line32:17),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3177,10,573,156),USE(S5),RIGHT 
         STRING(@N_11.2B),AT(2448,10,677,156),USE(S4),RIGHT 
         LINE,AT(3750,-10,0,270),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,270),USE(?Line32:18),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3802,10,573,156),USE(S6),RIGHT 
         LINE,AT(4375,-10,0,270),USE(?Line32:27),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4427,10,573,156),USE(S7),RIGHT 
         LINE,AT(7604,-10,0,270),USE(?Line32:19),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line32:10),COLOR(COLOR:Black)
         STRING(@D5),AT(260,10,,156),USE(S0) 
         STRING(@N-_12.2B),AT(9167,10,677,156),USE(S15),RIGHT 
         LINE,AT(781,-10,0,270),USE(?Line32:11),COLOR(COLOR:Black)
         STRING(@D5),AT(1146,10,,156),USE(S2) 
       END
detail DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(AMO:IZSLEGTS),RIGHT 
         LINE,AT(5521,-10,0,270),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,270),USE(?Line3:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(A9),RIGHT 
         LINE,AT(6771,-10,0,270),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6875,10,,156),USE(A11),RIGHT 
         LINE,AT(9167,-10,0,270),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7865,10,,156),USE(A12),RIGHT 
         LINE,AT(9844,0,0,270),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9063,0,,156),USE(A13),RIGHT 
         STRING(@D16),AT(385,10,,156),USE(AMO:YYYYMM) 
         LINE,AT(10573,-10,0,270),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,270),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line3:28),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,270),USE(?Line3:37),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(2031,10,,156),USE(A3),RIGHT 
         LINE,AT(3229,-10,0,270),USE(?Line3:38),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(AMO:KAPREM),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line3:48),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,270),USE(?Line3:49),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4010,10,,156),USE(AMO:PARCEN),RIGHT 
         LINE,AT(4479,-10,0,270),USE(?Line3:58),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,270),USE(?Line3:110),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,270),USE(?Line3:12),COLOR(COLOR:Black)
         STRING(@s10),AT(1229,10,729,156),USE(A2),CENTER 
       END
detailB DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(B8),RIGHT 
         LINE,AT(5000,-10,0,270),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,270),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,270),USE(?Line4:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(B9),RIGHT 
         LINE,AT(6771,-10,0,270),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,270),USE(?Line4:12),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,270),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,270),USE(?Line4:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(8854,10,,156),USE(B13),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,270),USE(?Line4:7),COLOR(COLOR:Black)
         LINE,AT(3229,-10,0,270),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(B4),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line4:19),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4010,10,,156),USE(B6),RIGHT 
         LINE,AT(4479,-10,0,270),USE(?Line4:29),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,270),USE(?Line4:110),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line4:119),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,270),USE(?Line4:129),COLOR(COLOR:Black)
         STRING(@D6),AT(1250,10,,156),USE(B2) 
         LINE,AT(2708,-10,0,270),USE(?Line4:37),COLOR(COLOR:Black)
       END
RepFooT3 DETAIL,AT(,-10,,146)
         LINE,AT(208,0,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(1406,0,0,62),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,62),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(3229,0,0,62),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,62),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,62),USE(?Line56:3),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,62),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(2708,0,0,62),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,62),USE(?Line56:12),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,62),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,62),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,62),USE(?Line517),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,62),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(9167,0,0,62),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(9740,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,62),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(208,52,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,7900,12000,52)
         LINE,AT(208,0,10365,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer    BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(PAMAT,1)
  CHECKOPEN(KAT_K,1)
  CLEAR(KAT:RECORD)
!  KAT:NR=PAM:KAT_nr
!  GET(KAT_K,KAT:NR_KEY)
!  IF ERROR() THEN STOP('KATEGORIJAS').
!  IF SUB(PAM:KAT_NR,1,1)='1' ! ÇKAS
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' %'
!  ELSE
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' gadi'
!  .
!  DATUMS = DATE(12,31,GADS)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:U_NR',PAM:U_NR)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(AMO:RECORD)
      SET(AMO:NR_KEY,AMO:NR_KEY)
      Process:View{Prop:Filter} = 'AMO:U_NR=PAM:U_NR'
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
      s2=pam:datums
      s3=pam:iep_v
      s4=pam:kap_v
      s6=0
      s8=0
      uzsk_v=pam:bil_v+pam:nol_v
      s9=uzsk_v
      s11=0
      s12=pam:nol_v
      a12=pam:nol_v
      s13=pam:bil_v
      PRINT(RPT:DETAIL0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        LOOP
          PRINT(RPT:DETAIL)
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAILB)
    PRINT(RPT:REPFOOT3)
!    KOPA='Kopâ:'
    ENDPAGE(report)
    ReportPreview(PrintPreviewQueue)
    IF GlobalResponse = RequestCompleted
      report{PROP:FlushPreview} = True
    END
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  DO ProcedureReturn
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
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
      StandardWarning(Warn:RecordFetchError,'PAMAM')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
P_PamKar2P           PROCEDURE                    ! Declare Procedure
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
VERT_S               SREAL
uzsk_v               SREAL
KAT_NR               STRING(4)
LIKME                STRING(10)
!    Pçc ailes numura
S0                   DATE
S2                   DATE
S3                   DECIMAL(11,2)
S4                   DECIMAL(3)
s5                   decimal(11,2)
S6                   DECIMAL(11,2)
s7                   decimal(11,2)
S8                   DECIMAL(11,2)
S9                   DECIMAL(11,2)
s10                  decimal(11,2)
S11                  DECIMAL(11,2)
S12                  DECIMAL(11,2)
S13                  DECIMAL(12,2)
s14                  decimal(11,2)
s15                  string(20)
s16                  decimal(11,2)
s17                  decimal(11,2)
s18                  decimal(11,2)
RPT_GADS             DECIMAL(4)
A2                   DATE
A3                   DECIMAL(11,2)
A4                   DECIMAL(11,2)
A6                   DECIMAL(11,2)
A8                   DECIMAL(11,2)
A9                   DECIMAL(11,2)
A11                  DECIMAL(11,2)
A12                  DECIMAL(11,2)
A13                  DECIMAL(12,2)
B2                   DATE
B4                   DECIMAL(11,2)
B6                   DECIMAL(11,2)
B8                   DECIMAL(11,2)
B9                   DECIMAL(11,2)
B13                  DECIMAL(12,2)
Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_G_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:IZSLEGTS)
                       PROJECT(AMO:SKAITS)
                     END
report REPORT,AT(100,1131,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(100,100,12000,1031)
         STRING('Nodokïiem'),AT(9927,156),USE(?String70:2) 
         STRING(@s45),AT(1771,156,3438,208),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('PAMATLÎDZEKÏA  ANALÎTISKÂS  UZSKAITES  UN  NOLIETOJUMA  APRÇÍINS'),AT(1792,469),USE(?String2), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('uzòçmumâ, kas reìistrçts un darbojas îpaði atbalstâmajâ reìionâ'),AT(2177,729),USE(?String2:2), |
             CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçmuma nosaukums :'),AT(208,156,1563,208),USE(?String7),LEFT,FONT(,10,,)
       END
Page_head DETAIL,AT(,,,3677)
         STRING('Pamatlîdzekïa nosaukums (un kods)'),AT(208,104),USE(?String62:5)
         STRING('Apdroðinâðana'),AT(7448,0),USE(?String62:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Atraðanâs vieta'),AT(208,313),USE(?String62)
         STRING('Apdroðinâðanas sabiedrîba'),AT(5938,313),USE(?String62:8)
         LINE,AT(1146,469,4583,0),USE(?Line63:2),COLOR(COLOR:Black)
         STRING('Iegâdes datums un pamatojums'),AT(208,521),USE(?String62:2)
         STRING('Polise Nr'),AT(5938,521),USE(?String62:9)
         STRING('Summa'),AT(8177,521),USE(?String62:10)
         LINE,AT(6510,677,1615,0),USE(?Line63:11),COLOR(COLOR:Black)
         LINE,AT(8646,677,1198,0),USE(?Line63:12),COLOR(COLOR:Black)
         STRING('(latos)'),AT(10104,1823),USE(?String62:17) 
         LINE,AT(2135,677,3594,0),USE(?Line63:3),COLOR(COLOR:Black)
         LINE,AT(7604,469,2240,0),USE(?Line63:10),COLOR(COLOR:Black)
         LINE,AT(208,885,5521,0),USE(?Line63:4),COLOR(COLOR:Black)
         LINE,AT(2448,260,3281,0),USE(?Line63),COLOR(COLOR:Black)
         STRING('Nodoðanas ekspluatâcijâ datums'),AT(208,938),USE(?String62:12)
         LINE,AT(2240,1094,3490,0),USE(?Line63:5),COLOR(COLOR:Black)
         LINE,AT(6563,1094,3281,0),USE(?Line63:13),COLOR(COLOR:Black)
         STRING('Izslçgðanas datums un pamatojums'),AT(208,1146),USE(?String62:3)
         STRING('Sâkotnçjâ uzskaites vçrtîba, Ls'),AT(5938,1146),USE(?String62:13)
         STRING('Kategorija'),AT(5938,938),USE(?String62:11)
         LINE,AT(2396,1302,3333,0),USE(?Line63:6),COLOR(COLOR:Black)
         LINE,AT(7865,1302,1979,0),USE(?Line63:14),COLOR(COLOR:Black)
         STRING('Likvidâcijas (lûþòu) vçrtîba, Ls'),AT(5938,1354),USE(?String62:14)
         LINE,AT(208,1510,5521,0),USE(?Line63:7),COLOR(COLOR:Black)
         LINE,AT(7760,1510,2083,0),USE(?Line63:15),COLOR(COLOR:Black)
         STRING('Kartes atvçrðanas datums'),AT(208,1563),USE(?String62:4)
         STRING('Gada nolietojuma likme %'),AT(5938,1563),USE(?String62:15)
         LINE,AT(1823,1719,3906,0),USE(?Line63:8),COLOR(COLOR:Black)
         LINE,AT(7552,1719,2292,0),USE(?Line63:16),COLOR(COLOR:Black)
         STRING('Piezîmes'),AT(208,1771),USE(?String62:6)
         STRING('Koeficients (13.p. 1.d. 9.p.)'),AT(5938,1771),USE(?String62:16)
         LINE,AT(781,1927,4948,0),USE(?Line63:9),COLOR(COLOR:Black)
         LINE,AT(7604,1927,2240,0),USE(?Line63:17),COLOR(COLOR:Black)
         LINE,AT(208,2031,0,1667),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(1563,2031,0,1667),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2135,2031,0,1667),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4479,2031,0,1667),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6042,2031,0,1667),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6771,2031,0,1667),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7500,2031,0,1667),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7760,2031,0,1667),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9167,2031,0,1667),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(10573,2031,0,1667),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Taksâcijas'),AT(260,2083,260,1250),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('Attaisnojoðâ'),AT(781,2083,208,1250),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(729,2031,0,1667),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('periods'),AT(521,2083,208,1250),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('Iegâdes vçrtîba'),AT(1615,2083,521,1302),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Koeficients'),AT(2188,2083,208,1302),USE(?String18:62),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('Koriìçtâ iegâdes'),AT(2448,2083,260,1302),USE(?String18:63),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('vçrtîba (3. * 4.)'),AT(2708,2083,260,1302),USE(?String18:64),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(2396,2031,0,1667),USE(?Line2:18),COLOR(COLOR:Black)
         STRING('Kapitâlâs izmaksas'),AT(3021,2083,365,1302),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3438,2031,0,1667),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(2969,2031,0,1667),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('Pârvçrtçðana'),AT(3490,2083,990,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(4531,2083,1510,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamat-'),AT(6094,2083,677,156),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Likme % (dubultotâ)'),AT(7552,2083,208,1198),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Taksâcijas perioda'),AT(7813,2083,1354,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkrâtais nolietojums'),AT(9219,2083,208,1302),USE(?String18:53),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('nodokïiem'),AT(9479,2083,208,1302),USE(?String18:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('Atlikusî'),AT(9792,2083,781,156),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9740,2031,0,1667),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Atlikusî'),AT(6823,2083,677,156),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('"+"'),AT(3490,2344,469,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,2292,0,1406),USE(?Line2:16),COLOR(COLOR:Black)
         STRING('sâkotnçjâ'),AT(4531,2344,260,990),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('vçrtîba'),AT(4792,2344,208,990),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(5000,2292,0,1406),USE(?Line2:15),COLOR(COLOR:Black)
         STRING('koriìçtâ'),AT(6094,2396,677,156),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojums'),AT(7813,2292,1354,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no kuras'),AT(6823,2396,677,156),USE(?String18:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(9792,2396,781,156),USE(?String18:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr un datums'),AT(1198,2083,208,1250),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(7760,2500,1406,0),USE(?Line80:2),COLOR(COLOR:Black)
         STRING('aprçíins'),AT(7813,2552,833,208),USE(?String18:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8646,2500,0,1198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('summa'),AT(8698,2552,365,573),USE(?String18:52),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('perioda'),AT(9792,2552,781,156),USE(?String18:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(6094,2865,677,156),USE(?String18:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(6094,3021,677,156),USE(?String18:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojumu'),AT(6823,3021,677,156),USE(?String18:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(6823,2865,677,156),USE(?String18:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitîðanas'),AT(9792,2865,781,156),USE(?String18:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(13.*14.:100)'),AT(7813,2760,833,208),USE(?String18:51),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojuma'),AT(9792,2708,781,156),USE(?String18:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta'),AT(990,2083,208,1250),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(208,3385,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(260,3438,469,208),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(781,3438,781,208),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1615,3438,521,208),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(2188,3438,208,208),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(2448,3438,521,208),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(3021,3438,417,208),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(3490,3438,469,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(4010,3438,469,208),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(4531,3438,469,208),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(5052,3438,469,208),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(5573,3438,469,208),USE(?String18:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(6094,3438,677,208),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(6823,3438,677,208),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(7552,3438,208,208),USE(?String18:61),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15'),AT(7813,3438,833,208),USE(?String18:60),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('16'),AT(8698,3438,469,208),USE(?String18:59),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('17'),AT(9219,3438,521,208),USE(?String18:66),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('18'),AT(9792,3438,781,208),USE(?String18:65),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíina'),AT(6823,2552,677,156),USE(?String18:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(6094,2552,677,156),USE(?String18:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba (9. - 10.)'),AT(5781,2344,208,990),USE(?String18:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('taksâcijas'),AT(6094,2708,677,156),USE(?String18:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(6823,2708,677,156),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzkrâtais'),AT(5052,2344,208,990),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('atlikusî'),AT(5573,2344,208,990),USE(?String18:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         STRING('nolietojums'),AT(5260,2344,208,990),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC),ANGLE(900)
         LINE,AT(5521,2292,0,1406),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('"-"'),AT(4010,2344,469,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3438,2292,2604,0),USE(?Line80),COLOR(COLOR:Black)
         STRING('lîdzekïa'),AT(6094,2240,677,156),USE(?String18:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba,'),AT(6823,2240,677,156),USE(?String18:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba pçc'),AT(9792,2240,781,156),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,3646,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(208,2031,10365,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(3021,10,417,156),USE(S6),RIGHT 
         LINE,AT(5521,-10,0,270),USE(?Line32:8),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,270),USE(?Line32:0),COLOR(COLOR:Black)
         STRING(@s20),AT(7813,10,833,156),USE(S15),LEFT 
         STRING(@N_11.2B),AT(3490,10,469,156),USE(S7),RIGHT 
         LINE,AT(6771,-10,0,270),USE(?Line32:9),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line32:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4010,10,469,156),USE(S8),RIGHT 
         LINE,AT(9167,-10,0,270),USE(?Line32:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(4531,10,469,156),USE(S9),RIGHT 
         LINE,AT(9740,-10,0,270),USE(?Line32:3),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5052,10,469,156),USE(S10),RIGHT 
         STRING(@N-_12.2B),AT(5573,10,469,156),USE(S11),RIGHT 
         STRING(@N-_12.2B),AT(6094,10,677,156),USE(S12),RIGHT 
         STRING(@N-_12.2B),AT(6823,10,677,156),USE(S13),RIGHT 
         STRING(@N2B),AT(7552,10,208,156),USE(S14),RIGHT 
         STRING(@N-_12.2B),AT(9219,10,521,156),USE(S17),RIGHT 
         STRING(@N-_12.2B),AT(9792,10,677,156),USE(S18),RIGHT 
         STRING(@N-_12.2B),AT(8698,10,469,156),USE(S16),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line32:4),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,270),USE(?Line32:11),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line32:5),COLOR(COLOR:Black)
         LINE,AT(2396,-10,0,270),USE(?Line32:6),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(1615,10,521,156),USE(S3),RIGHT 
         LINE,AT(2969,-10,0,270),USE(?Line32:116),COLOR(COLOR:Black)
         LINE,AT(3438,-10,0,270),USE(?Line32:117),COLOR(COLOR:Black)
         STRING(@N3),AT(2188,10,208,156),USE(S4),RIGHT 
         LINE,AT(3958,-10,0,270),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,270),USE(?Line32:89),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(2448,10,521,156),USE(S5),RIGHT 
         LINE,AT(4479,-10,0,270),USE(?Line32:79),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,270),USE(?Line32:99),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line32:10),COLOR(COLOR:Black)
         STRING(@D5),AT(260,10,469,156),USE(S0) 
         LINE,AT(1563,-10,0,270),USE(?Line32:112),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,270),USE(?Line32:12),COLOR(COLOR:Black)
         STRING(@D5),AT(781,10,469,156),USE(S2) 
       END
detail DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(AMO:IZSLEGTS),RIGHT 
         LINE,AT(5521,-10,0,270),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,270),USE(?Line3:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(A9),RIGHT 
         LINE,AT(6771,-10,0,270),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6875,10,,156),USE(A11),RIGHT 
         LINE,AT(9167,-10,0,270),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7865,10,,156),USE(A12),RIGHT 
         LINE,AT(9740,-10,0,270),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(8854,10,,156),USE(A13),RIGHT 
         STRING(@D16),AT(385,10,,156),USE(AMO:YYYYMM) 
         LINE,AT(10573,-10,0,270),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,270),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(2865,-10,0,270),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,270),USE(?Line3:89),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,270),USE(?Line3:75),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(2031,10,,156),USE(A3),RIGHT 
         LINE,AT(3281,-10,0,270),USE(?Line3:84),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(AMO:KAPREM),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line3:82),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,270),USE(?Line3:91),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4010,10,,156),USE(AMO:PARCEN),RIGHT 
         LINE,AT(4479,-10,0,270),USE(?Line3:81),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,270),USE(?Line3:110),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,270),USE(?Line3:121),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,270),USE(?Line3:112),COLOR(COLOR:Black)
         STRING(@s10),AT(1229,10,729,156),USE(A2),CENTER 
       END
detailB DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(B8),RIGHT 
         LINE,AT(5000,-10,0,270),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,270),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,270),USE(?Line4:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(B9),RIGHT 
         LINE,AT(6771,-10,0,270),USE(?Line4:111),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,270),USE(?Line4:19),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,270),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,270),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,270),USE(?Line4:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(8854,10,,156),USE(B13),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,270),USE(?Line4:7),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,270),USE(?Line4:37),COLOR(COLOR:Black)
         LINE,AT(3281,-10,0,270),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(B4),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line4:92),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4010,10,,156),USE(B6),RIGHT 
         LINE,AT(4479,-10,0,270),USE(?Line4:91),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,270),USE(?Line4:110),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,270),USE(?Line4:71),COLOR(COLOR:Black)
         LINE,AT(1406,-10,0,270),USE(?Line4:12),COLOR(COLOR:Black)
         STRING(@D6),AT(1250,10,,156),USE(B2) 
         LINE,AT(2865,-10,0,270),USE(?Line4:17),COLOR(COLOR:Black)
       END
RepFooT3 DETAIL,AT(,-10,,146)
         LINE,AT(208,0,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(729,0,0,62),USE(?Line52:2),COLOR(COLOR:Black)
         LINE,AT(1406,0,0,62),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,62),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(2865,0,0,62),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,62),USE(?Line54:3),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,62),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,62),USE(?Line56:3),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,62),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(2292,0,0,62),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,62),USE(?Line56:12),COLOR(COLOR:Black)
         LINE,AT(6042,0,0,62),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,62),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,62),USE(?Line157),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,62),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(9167,0,0,62),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(9740,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,62),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(208,52,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,7600,12000,52)
         LINE,AT(208,0,10365,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer    BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(PAMAT,1)
  CHECKOPEN(KAT_K,1)
  CLEAR(KAT:RECORD)
!  KAT:NR=PAM:KAT_nr
!  GET(KAT_K,KAT:NR_KEY)
!  IF ERROR() THEN STOP('KATEGORIJAS').
!  IF SUB(PAM:KAT_NR,1,1)='1' ! ÇKAS
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' %'
!  ELSE
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' gadi'
!  .
!  DATUMS = DATE(12,31,GADS)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:U_NR',PAM:U_NR)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(AMO:RECORD)
      SET(AMO:NR_KEY,AMO:NR_KEY)
      Process:View{Prop:Filter} = 'AMO:U_NR=PAM:U_NR'
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
      s2=pam:datums
      s3=pam:iep_v
      s4=pam:kap_v
      s6=0
      s8=0
      uzsk_v=pam:bil_v+pam:nol_v
      s9=uzsk_v
      s11=0
      s12=pam:nol_v
      a12=pam:nol_v
      s13=pam:bil_v
      PRINT(RPT:DETAIL0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        LOOP
          PRINT(RPT:DETAIL)
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAILB)
    PRINT(RPT:REPFOOT3)
!    KOPA='Kopâ:'
    ENDPAGE(report)
    ReportPreview(PrintPreviewQueue)
    IF GlobalResponse = RequestCompleted
      report{PROP:FlushPreview} = True
    END
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  DO ProcedureReturn
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
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
      StandardWarning(Warn:RecordFetchError,'PAMAM')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
