                     MEMBER('winlats.clw')        ! This is a MEMBER module
P_IIVIV              PROCEDURE                    ! Declare Procedure
VERT_SG              DECIMAL(12,2)
VERT_IEGG            DECIMAL(12,2)
VERT_PARG            DECIMAL(12,2)
VERT_IZNG            DECIMAL(12,2)
VERT_SBG             DECIMAL(12,2)
VERT_NSG             DECIMAL(12,3)
VERT_NG              DECIMAL(12,3)
VERT_NIZNG           DECIMAL(12,3)
VERT_NBG             DECIMAL(12,3)
VERT_ASG             DECIMAL(12,2)
VERT_ABG             DECIMAL(12,2)
VERT_SM              DECIMAL(12,2),DIM(4)
VERT_IEGM            DECIMAL(12,2),DIM(4)
VERT_PARM            DECIMAL(12,2),DIM(4)
VERT_IZNM            DECIMAL(12,2),DIM(4)
VERT_SBM             DECIMAL(12,2),DIM(4)
VERT_NSM             DECIMAL(12,3),DIM(4)
VERT_NM              DECIMAL(12,3),DIM(4)
VERT_NIZNM           DECIMAL(12,3),DIM(4)
VERT_NBM             DECIMAL(12,3),DIM(4)
VERT_ASM             DECIMAL(12,2),DIM(4)
VERT_ABM             DECIMAL(12,2),DIM(4)
IEGVEIDS             STRING(46)
IEGkopa              STRING(35)

VERT_S               DECIMAL(12,2)
VERT_IEG             DECIMAL(12,2)
VERT_PAR             DECIMAL(12,2)
VERT_IZN             DECIMAL(12,2)
VERT_SB              DECIMAL(12,2)
VERT_NS              DECIMAL(12,3)
VERT_N               DECIMAL(12,3)
VERT_NIZN            DECIMAL(12,3)
VERT_NB              DECIMAL(12,3)
VERT_AS              DECIMAL(12,2)
VERT_AB              DECIMAL(12,2)
VERT_SK              DECIMAL(12,2)
VERT_IEGK            DECIMAL(12,2)
VERT_PARK            DECIMAL(12,2)
VERT_IZNK            DECIMAL(12,2)
VERT_SBK             DECIMAL(12,2)
VERT_NSK             DECIMAL(12,3)
VERT_NK              DECIMAL(12,3)
VERT_NIZNK           DECIMAL(12,3)
VERT_NBK             DECIMAL(12,3)
VERT_ASK             DECIMAL(12,2)
VERT_ABK             DECIMAL(12,2)
VERT_I               SREAL
IEGADATS             DECIMAL(12,2)
SAVE_IIV             STRING(1)
GADS2                DECIMAL(2)
SAV_U_NR             ULONG
VIRSRAKSTS           STRING(80)

K_TABLE           QUEUE,PRE(K)
IIV                  STRING(2)
VERT_S               DECIMAL(12,2)
VERT_IEG             DECIMAL(12,2)
VERT_PAR             DECIMAL(12,2)
VERT_IZN             DECIMAL(12,2)
VERT_NS              DECIMAL(12,3)
VERT_N               DECIMAL(12,3)
VERT_NIZN            DECIMAL(12,3)
                  .

B_TABLE           QUEUE,PRE(B)
BKK                  STRING(5)
VERT_S               DECIMAL(12,2)
VERT_IEG             DECIMAL(12,2)
VERT_PAR             DECIMAL(12,2)
VERT_IZN             DECIMAL(12,2)
VERT_NS              DECIMAL(12,3)
VERT_N               DECIMAL(12,3)
VERT_NIZN            DECIMAL(12,3)
                  .

C_TABLE           QUEUE,PRE(C)
KAT                  STRING(3)
VERT_S               DECIMAL(12,2)
VERT_IEG             DECIMAL(12,2)
VERT_PAR             DECIMAL(12,2)
VERT_IZN             DECIMAL(12,2)
VERT_NS              DECIMAL(12,3)
VERT_N               DECIMAL(12,3)
VERT_NIZN            DECIMAL(12,3)
                  .

N_TABLE           QUEUE,PRE(N)
NODALA               STRING(2)
VERT_S               DECIMAL(12,2)
VERT_IEG             DECIMAL(12,2)
VERT_PAR             DECIMAL(12,2)
VERT_IZN             DECIMAL(12,2)
VERT_SB              DECIMAL(12,2)
VERT_NS              DECIMAL(12,3)
VERT_N               DECIMAL(12,3)
VERT_NIZN            DECIMAL(12,3)
VERT_NB              DECIMAL(12,3)
VERT_AS              DECIMAL(12,2)
VERT_AB              DECIMAL(12,2)
                  .
TS                   STRING(4)
NOD                  STRING(2)
NodText              STRING(25)

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
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:DATUMS)
                     END

!    PAGE FOOTER,AT(250,7800,12000,0)     7800-LANDSCAPE OPTIMÂLAIS GARUMS NAV REPORTS
!  report REPORT,AT(250,2150,12000,5700)  2150=500+1600+50(?KOREKCIJA) 5700=7800-2100
!    PAGE HEADER,AT(250,500,12000,1600)   NAV REPORTS

report REPORT,AT(250,2150,12000,5698),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(250,500,12000,1604),USE(?unnamed:7)
         LINE,AT(208,1615,10208,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Atlikusî vçrtîba'),AT(9063,1146,1354,208),USE(?String6:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums (Vçrtîbas norakstîjumi)'),AT(5781,1146,3229,208),USE(?String6:4),CENTER, |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ vçrtîba'),AT(2656,1146,3073,208),USE(?String6:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ieguldîjuma veids'),AT(344,1385,2083,208),USE(?String6:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(2563,1406,625,156),USE(S_DAT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieg.&Izg.'),AT(3281,1406,573,156),USE(?String6:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrt.'),AT(3906,1406,573,156),USE(?String6:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izòemð.'),AT(4500,1406,573,156),USE(?String6:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5094,1406,625,156),USE(B_DAT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5740,1406,625,156),USE(S_DAT,,?S_DAT:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçíin.'),AT(6406,1406,573,156),USE(?String6:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Koriìçts'),AT(7115,1406,573,156),USE(?String6:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgts'),AT(7760,1406,625,156),USE(?String6:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(8396,1406,625,156),USE(B_DAT,,?B_DAT:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(9708,1406,625,156),USE(B_DAT,,?B_DAT:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(9042,1406,625,156),USE(S_DAT,,?S_DAT:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2500,1354,7917,0),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(3219,1354,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(3854,1354,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(4479,1354,0,260),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(5083,1354,0,260),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(6354,1354,0,260),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7063,1354,0,260),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7708,1354,0,260),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(8385,1354,0,260),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(9688,1354,0,260),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(208,1094,10208,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2500,1094,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(5729,1094,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(9010,1094,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(10417,1094,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Ilgtermiòa'),AT(344,1146,2083,208),USE(?String6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1094,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(2604,104,4271,260),USE(client),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6927,104),USE(GL:VID_NR),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2552,365,5677,0),USE(?Line66),COLOR(COLOR:Black)
         STRING('uzòçmuma (uzòçmçjsabiedrîbas) nosaukums, nod. maks. reì. Nr.'),AT(3333,417,3281,156), |
             USE(?String64)
         STRING('Mçra vienîba: Ls'),AT(9531,885,833,208),USE(?String66)
         STRING(@s80),AT(1615,729,7458,260),USE(VIRSRAKSTS),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
GRHEAD DETAIL,AT(,,,354),USE(?unnamed:4)
         LINE,AT(208,0,0,375),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(2500,0,0,375),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(3219,0,0,375),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,375),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,375),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5083,0,0,375),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,375),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,375),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(7063,0,0,375),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,375),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(8385,0,0,375),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,375),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(9688,0,0,375),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(10417,0,0,375),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(208,52,10208,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s35),AT(240,104,2240,156),USE(IegKopa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_11.2B),AT(2521,104,677,208),USE(vert_sg),RIGHT
         STRING(@N_11.2B),AT(3260,104,573,208),USE(VERT_IEGG),RIGHT
         STRING(@N-_10.2B),AT(3896,104,573,208),USE(VERT_PARG),RIGHT
         STRING(@N_10.2B),AT(4531,104,521,208),USE(VERT_IZNG),RIGHT
         STRING(@N_11.2B),AT(5115,104,594,208),USE(VERT_SBG),RIGHT
         STRING(@N_11.2B),AT(5760,104,573,208),USE(VERT_NSG),RIGHT
         STRING(@N_11.2B),AT(6375,104,677,208),USE(VERT_NG),RIGHT
         STRING(@N_10.2B),AT(7760,104,573,208),USE(VERT_NIZNG),RIGHT
         STRING(@N_11.2B),AT(8417,104,573,208),USE(VERT_NBG),RIGHT
         STRING(@N_11.2B),AT(9052,104,625,208),USE(VERT_ASG),RIGHT
         STRING(@N_11.2B),AT(9771,104,625,208),USE(VERT_ABG),RIGHT
         LINE,AT(208,313,10208,0),USE(?Line19:2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(5083,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5104,10,594,156),USE(VERT_SB),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5760,10,573,208),USE(VERT_NS),RIGHT
         LINE,AT(6354,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6375,10,677,208),USE(VERT_N),RIGHT
         LINE,AT(7063,-10,0,198),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:38),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7760,10,573,156),USE(VERT_NIZN),RIGHT
         LINE,AT(8385,-10,0,198),USE(?Line2:39),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8417,10,573,208),USE(VERT_NB),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line2:40),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9052,0,625,156),USE(VERT_AS),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line2:41),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9740,10,625,208),USE(VERT_AB),RIGHT
         LINE,AT(10417,-10,0,198),USE(?Line2:42),COLOR(COLOR:Black)
         LINE,AT(3219,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3260,10,573,156),USE(VERT_IEG),RIGHT
         LINE,AT(3854,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(3896,10,573,208),USE(VERT_PAR),RIGHT
         LINE,AT(4479,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(4531,10,521,156),USE(VERT_IZN),RIGHT
         LINE,AT(2500,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         STRING(@s46),AT(250,10,2240,156),USE(IEGVEIDS),LEFT
         STRING(@N_11.2B),AT(2521,10,677,156),USE(vert_s),RIGHT
       END
RepFoot DETAIL,AT(,,,354),USE(?unnamed:6)
         LINE,AT(5083,-10,0,375),USE(?Line2:48),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,375),USE(?Line2:46),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,375),USE(?Line2:47),COLOR(COLOR:Black)
         LINE,AT(3219,-10,0,375),USE(?Line2:45),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,375),USE(?Line2:44),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,375),USE(?Line2:43),COLOR(COLOR:Black)
         LINE,AT(208,52,10208,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('KOPÂ :'),AT(313,104),USE(?String53),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_11.2B),AT(2521,104,677,208),USE(vert_sK),RIGHT
         STRING(@N_11.2B),AT(3260,104,573,208),USE(VERT_IEGK),RIGHT
         STRING(@N-_10.2B),AT(3896,104,573,208),USE(VERT_PARK),RIGHT
         STRING(@N_10.2B),AT(4531,104,521,208),USE(VERT_IZNK),RIGHT
         STRING(@N_11.2B),AT(5115,104,594,208),USE(VERT_SBK),RIGHT
         STRING(@N_11.2B),AT(5760,104,573,208),USE(VERT_NSK),RIGHT
         STRING(@N_11.2B),AT(6375,104,677,208),USE(VERT_NK),RIGHT
         STRING(@N_10.2B),AT(7760,104,573,208),USE(VERT_NIZNK),RIGHT
         STRING(@N_11.2B),AT(8417,104,573,208),USE(VERT_NBK),RIGHT
         STRING(@N_11.2B),AT(9052,104,625,208),USE(VERT_ASK),RIGHT
         STRING(@N_11.2B),AT(9760,104,625,208),USE(VERT_ABK),RIGHT
         LINE,AT(208,313,10208,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,375),USE(?Line2:55),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,375),USE(?Line2:54),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,375),USE(?Line2:53),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,375),USE(?Line2:52),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,375),USE(?Line2:51),COLOR(COLOR:Black)
         LINE,AT(7063,-10,0,375),USE(?Line2:50),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,375),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,375),USE(?Line2:49),COLOR(COLOR:Black)
       END
TS     DETAIL,AT(,,,177),USE(?unnamed)
         STRING('tai skaitâ'),AT(313,10,677,156),USE(?String6:17),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(2490,-10,0,197),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,197),USE(?Line68:2),COLOR(COLOR:Black)
         LINE,AT(4479,-10,0,197),USE(?Line68:21),COLOR(COLOR:Black)
         LINE,AT(5083,-10,0,197),USE(?Line68:4),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,197),USE(?Line68:23),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,197),USE(?Line68:24),COLOR(COLOR:Black)
         LINE,AT(7063,-10,0,197),USE(?Line68:25),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,197),USE(?Line68:26),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,197),USE(?Line68:27),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,197),USE(?Line68:28),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,197),USE(?Line68:29),COLOR(COLOR:Black)
         LINE,AT(10417,-10,0,197),USE(?Line68:3),COLOR(COLOR:Black)
         LINE,AT(3219,-10,0,197),USE(?Line68),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,197),USE(?Line19),COLOR(COLOR:Black)
       END
NODALA DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(5083,-10,0,198),USE(?Line213:34),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5104,10,594,156),USE(N:VERT_SB),RIGHT
         LINE,AT(5729,-10,0,198),USE(?Line212:35),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5760,10,573,208),USE(N:VERT_NS),RIGHT
         LINE,AT(6354,-10,0,198),USE(?Line213:36),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6375,10,677,208),USE(N:VERT_N),RIGHT
         LINE,AT(7063,-10,0,198),USE(?Line213:37),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line212:38),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7760,10,573,156),USE(N:VERT_NIZN),RIGHT
         LINE,AT(8385,-10,0,198),USE(?Line212:39),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8417,10,573,208),USE(N:VERT_NB),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line213:40),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9052,0,625,156),USE(N:VERT_AS),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line232:41),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9729,0,677,156),USE(N:VERT_AB),RIGHT
         STRING(@s25),AT(833,10,1667,156),USE(NodText),TRN,LEFT
         STRING(@s2),AT(625,10,156,156),USE(NOD),LEFT
         LINE,AT(10417,-10,0,198),USE(?Line212:42),COLOR(COLOR:Black)
         LINE,AT(3219,-10,0,198),USE(?Line258:31),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3260,10,573,156),USE(N:VERT_IEG),RIGHT
         LINE,AT(3854,-10,0,198),USE(?Line245:32),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(3896,10,573,208),USE(N:VERT_PAR),RIGHT
         LINE,AT(4479,-10,0,198),USE(?Line278:33),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(4531,10,521,156),USE(N:VERT_IZN),RIGHT
         LINE,AT(2500,-10,0,198),USE(?Line201:30),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line205:29),COLOR(COLOR:Black)
         STRING(@s4),AT(313,10,313,156),USE(TS),LEFT
         STRING(@N_11.2B),AT(2521,10,677,156),USE(N:vert_s),RIGHT
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(208,0,10208,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
PARAKSTI DETAIL,AT(,-10,,750),USE(?unnamed:3)
         LINE,AT(208,52,10208,0),USE(?Line121:5),COLOR(COLOR:Black)
         LINE,AT(208,0,0,52),USE(?Line82),COLOR(COLOR:Black)
         LINE,AT(2500,0,0,52),USE(?Line821),COLOR(COLOR:Black)
         LINE,AT(3219,0,0,52),USE(?Line822),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,52),USE(?Line823),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,52),USE(?Line824),COLOR(COLOR:Black)
         LINE,AT(5083,0,0,52),USE(?Line825),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,52),USE(?Line826),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,52),USE(?Line827),COLOR(COLOR:Black)
         LINE,AT(7063,0,0,52),USE(?Line828),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,52),USE(?Line829),COLOR(COLOR:Black)
         LINE,AT(8385,0,0,52),USE(?Line812),COLOR(COLOR:Black)
         LINE,AT(9010,0,0,52),USE(?Line899),COLOR(COLOR:Black)
         LINE,AT(9688,0,0,52),USE(?Line832),COLOR(COLOR:Black)
         LINE,AT(10417,0,0,52),USE(?Line82:2),COLOR(COLOR:Black)
         STRING(@s25),AT(292,323),USE(SYS:AMATS1),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1927,521,2292,0),USE(?Line67),COLOR(COLOR:Black)
         STRING(@s25),AT(2271,573),USE(SYS:PARAKSTS1,,?SYS:PARAKSTS1:2),CENTER
       END
       FOOTER,AT(250,7800,12000,0)
         LINE,AT(208,0,10208,0),USE(?Linef1:6),COLOR(COLOR:Black)
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

  VIRSRAKSTS = 'Pamatlîdzekïu nolietojuma kopsavilkums izvçrstâ v. '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' (LIN.metode)'

  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND('S_DAT',S_DAT)
  BIND('PAM:END_DATE',PAM:END_DATE)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'IIKP izvçrstâ veidâ'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),S_DAT-1)' !NAV NOÒEMTS IEPR.G-OS
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('P_IIVIV.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&CHR(9)&GL:VID_NR
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Ilgtermiòa'&CHR(9)&'Sakotnçjâ vçrtîba'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
             'Nolietojums (Vçrtîbas norakstîjumi)'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Atlikusî vçrtîba'
             ADD(OUTFILEANSI)
             OUTA:LINE='ieguldîjuma veids'&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&'Ieg,Izg.'&CHR(9)&'Pârvçrt.'&CHR(9)&|
             'Izòemð.'&CHR(9)&FORMAT(B_DAT,@D06.)&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&'Aprçíin.'&CHR(9)|
             &'Koriìçts'&CHR(9)&'Izslçgts'&CHR(9)&FORMAT(B_DAT,@N06.)&CHR(9)&FORMAT(S_DAT,@D06.)&CHR(9)&|
             FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
          ELSE !WORD
             OUTA:LINE='Ilgtermiòa ieguldîjuma veids'&CHR(9)&'Sâk.v. '&FORMAT(S_DAT,@D06.)&CHR(9)&'Ieg, Izg.'&CHR(9)&|
             'Pârvçrt.'&CHR(9)&'Izòemð.'&CHR(9)&'Sâk.v. '&FORMAT(B_DAT,@D06.)&CHR(9)&'Noliet. '&|
             FORMAT(S_DAT,@D06.)&CHR(9)&'Aprçíin.'&CHR(9)&'Koriìçts'&CHR(9)&'Izslçgts'&CHR(9)&'Noliet. '&|
             FORMAT(B_DAT,@D06.)&CHR(9)&'Atlik.v. '&FORMAT(S_DAT,@D06.)&CHR(9)&'Atl.v. '&FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
          .
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         VERT_IEG =0
         VERT_PAR =0
         VERT_IZN =0
         VERT_S   =0
         VERT_NS  =0
         VERT_N   =0
         VERT_NIZN =0
         CLEAR(AMO:RECORD)
         AMO:yyyymm=S_DAT
         AMO:U_NR=PAM:U_NR
         SET(AMO:NR_KEY,AMO:NR_KEY)
         LOOP
           NEXT(PAMAM)
           IF ERROR() OR ~(PAM:U_NR=AMO:U_NR AND AMO:YYYYMM < DATE(12,31,GADS))
              BREAK
           .
!           IF MONTH(AMO:YYYYMM)=1             ! VÇRTÎBA UZ GADA SÂKUMU
           IF MONTH(AMO:YYYYMM)=MONTH(S_DAT)  ! VÇRTÎBA UZ GADA SÂKUMU
              VERT_S =AMO:SAK_V_LI+PAM:NOL_V  !+NOLIETOJUMS 1994
              VERT_NS=AMO:NOL_U_LI+PAM:NOL_V  !+NOLIETOJUMS 1994
           .
           GADS=YEAR(S_DAT)
           IF INRANGE(PAM:EXPL_DATUMS,DATE(MONTH(AMO:YYYYMM),1,GADS),DATE(MONTH(AMO:YYYYMM)+1,1,GADS)-1) !IEGÂDÂTS ÐM
              VERT_IEG =PAM:BIL_V
           .
           VERT_IEG +=AMO:KAPREM
           VERT_PAR +=AMO:PARCEN+AMO:PARCENLI
           VERT_N   +=AMO:NOL_LIN
           IF MONTH(AMO:YYYYMM)=12 OR AMO:IZSLEGTS    !GADA VAI P/L BEIGAS
              IF YEAR(PAM:EXPL_DATUMS)<1995
                 Y#=YEAR(AMO:YYYYMM)-1995+1
              ELSE
                 Y#=YEAR(AMO:YYYYMM)-YEAR(PAM:EXPL_DATUMS)+1
              .
              IF AMO:IZSLEGTS !NOÒEMTS
                 VERT_IZN +=AMO:IZSLEGTS+PAM:NOL_V
                 VERT_NIZN+=VERT_NS+VERT_N            !PAM:NOL_V JAU PIESKAITÎTS
              .
              K:IIV=GETKAT_K(PAM:KAT[Y#],2,1,PAM:NOS_P)
!              STOP(K:IIV&' '&PAM:KAT[Y#])
              GET(K_TABLE,K:IIV)
              IF ERROR()
                K:VERT_S   =VERT_S
                K:VERT_IEG =VERT_IEG
                K:VERT_PAR =VERT_PAR
                K:VERT_IZN =VERT_IZN
                K:VERT_NS  =VERT_NS
                K:VERT_N   =VERT_N
                K:VERT_NIZN=VERT_NIZN
                ADD(K_TABLE)
                SORT(K_TABLE,K:IIV)
              ELSE
                K:VERT_S   +=VERT_S
                K:VERT_IEG +=VERT_IEG
                K:VERT_PAR +=VERT_PAR
                K:VERT_IZN +=VERT_IZN
                K:VERT_NS  +=VERT_NS
                K:VERT_N   +=VERT_N
                K:VERT_NIZN+=VERT_NIZN
                PUT(K_TABLE)
              .
              B:BKK=PAM:BKK
              GET(B_TABLE,B:BKK)
              IF ERROR()
                B:VERT_S   =VERT_S
                B:VERT_IEG =VERT_IEG
                B:VERT_PAR =VERT_PAR
                B:VERT_IZN =VERT_IZN
                B:VERT_NS  =VERT_NS
                B:VERT_N   =VERT_N
                B:VERT_NIZN=VERT_NIZN
                ADD(B_TABLE)
                SORT(B_TABLE,B:BKK)
              ELSE
                B:VERT_S   +=VERT_S
                B:VERT_IEG +=VERT_IEG
                B:VERT_PAR +=VERT_PAR
                B:VERT_IZN +=VERT_IZN
                B:VERT_NS  +=VERT_NS
                B:VERT_N   +=VERT_N
                B:VERT_NIZN+=VERT_NIZN
                PUT(B_TABLE)
              .
              C:KAT=PAM:KAT[Y#]
              GET(C_TABLE,C:KAT)
              IF ERROR()
                C:VERT_S   =VERT_S
                C:VERT_IEG =VERT_IEG
                C:VERT_PAR =VERT_PAR
                C:VERT_IZN =VERT_IZN
                C:VERT_NS  =VERT_NS
                C:VERT_N   =VERT_N
                C:VERT_NIZN=VERT_NIZN
                ADD(C_TABLE)
                SORT(C_TABLE,C:KAT)
              ELSE
                C:VERT_S   +=VERT_S
                C:VERT_IEG +=VERT_IEG
                C:VERT_PAR +=VERT_PAR
                C:VERT_IZN +=VERT_IZN
                C:VERT_NS  +=VERT_NS
                C:VERT_N   +=VERT_N
                C:VERT_NIZN+=VERT_NIZN
                PUT(C_TABLE)
              .
              N:NODALA=PAM:NODALA
              GET(N_TABLE,N:NODALA)
              IF ERROR()
                N:VERT_S   =VERT_S
                N:VERT_IEG =VERT_IEG
                N:VERT_PAR =VERT_PAR
                N:VERT_IZN =VERT_IZN
                N:VERT_SB  =VERT_SB
                N:VERT_NS  =VERT_NS
                N:VERT_N   =VERT_N
                N:VERT_NIZN=VERT_NIZN
                N:VERT_NB  =VERT_NB
                N:VERT_AS  =VERT_AS
                N:VERT_AB  =VERT_AB
                ADD(N_TABLE)
                SORT(N_TABLE,N:NODALA)
              ELSE
                N:VERT_S   +=VERT_S
                N:VERT_IEG +=VERT_IEG
                N:VERT_PAR +=VERT_PAR
                N:VERT_IZN +=VERT_IZN
                N:VERT_SB  +=VERT_SB
                N:VERT_NS  +=VERT_NS
                N:VERT_N   +=VERT_N
                N:VERT_NIZN+=VERT_NIZN
                N:VERT_NB  +=VERT_NB
                N:VERT_AS  +=VERT_AS
                N:VERT_AB  +=VERT_AB
                PUT(N_TABLE)
              .
              IF ~F:DTK !netiek aizpildîts
                 VERT_NS  =ROUND(VERT_NS,.01)
                 VERT_N   =ROUND(VERT_N,.01)
                 VERT_NIZN=ROUND(VERT_NIZN,.01)
                 IEGVEIDS= K:IIV&' '&PAM:BKK&' '&CLIP(PAM:U_NR)&' '&PAM:NOS_P
                 VERT_SB  = VERT_S+VERT_IEG+VERT_PAR-VERT_IZN
                 VERT_NB  = VERT_NS+VERT_N-VERT_NIZN
                 VERT_AS  = VERT_S-VERT_NS
                 VERT_AB  = VERT_SB-VERT_NB
                 IF F:DBF='W'
                    PRINT(RPT:DETAIL)
                 ELSE
                    OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N-_13.2))&CHR(9)&|
                    LEFT(FORMAT(VERT_PAR,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N-_13.2))&CHR(9)&|
                    LEFT(FORMAT(VERT_SB,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_NS,@N-_13.2))&CHR(9)&|
                    LEFT(FORMAT(VERT_N,@N-_13.2))&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_NIZN,@N-_13.2))&CHR(9)&|
                    LEFT(FORMAT(VERT_NB,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_AS,@N-_13.2))&CHR(9)&|
                    LEFT(FORMAT(VERT_AB,@N-_13.2))
                    ADD(OUTFILEANSI)
                 END
              .
              X#=K:IIV[1]
   !           STOP(X#&'='&K:IIV[1]&'-'&K:IIV&'='&KAT:IIV)
              IF ~INRANGE(X#,1,3) THEN X#=4.
              VERT_SM[X#]   += VERT_S
              VERT_IEGM[X#] += VERT_IEG
              VERT_PARM[X#] += VERT_PAR
              VERT_IZNM[X#] += VERT_IZN
              VERT_SBM[X#]  += VERT_S+VERT_IEG+VERT_PAR-VERT_IZN
              VERT_NSM[X#]  += VERT_NS
              VERT_NM[X#]   += VERT_N
              VERT_NIZNM[X#]+= VERT_NIZN
              VERT_NBM[X#]  += VERT_NS+VERT_N-VERT_NIZN
              VERT_ASM[X#]  += VERT_S-VERT_NS
              VERT_ABM[X#]   = VERT_SBM[X#]-VERT_NBM[X#]
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  SAVE_IIV='9'
  IF LocalResponse = RequestCompleted
    loop i#= 1 to records(K_table)
      get(K_table,i#)
      IF ~(SAVE_IIV=K:IIV[1])
         SAVE_IIV=K:IIV[1]
         X#=K:IIV[1]
         IF ~INRANGE(X#,1,3) THEN X#=4.
         EXECUTE X#
            IegKopa='I   Nemateriâlie ieguldîjumi'
            IegKopa='II  Pamatlîdzekïi'
            IegKopa='III Ilgtermiòa fin.ieguldîjumi'
            IegKopa='?   Nepazîstami'
        .
        VERT_SG  = VERT_SM[X#]
        VERT_IEGG= VERT_IEGM[X#]
        VERT_PARG= VERT_PARM[X#]
        VERT_IZNG= VERT_IZNM[X#]
        VERT_SBG = VERT_SBM[X#]
        VERT_NSG = VERT_NSM[X#]
        VERT_NG  = VERT_NM[X#]
        VERT_NIZNG=VERT_NIZNM[X#]
        VERT_NBG = VERT_NBM[X#]
        VERT_ASG = VERT_ASM[X#]
        VERT_ABG = VERT_ABM[X#]
        VERT_NSG = ROUND(VERT_NSG,.01)
        VERT_NG  = ROUND(VERT_NG,.01)
        VERT_NIZNG=ROUND(VERT_NIZNG,.01)
        VERT_NBG = ROUND(VERT_NBG,.01)
        IF F:DBF='W'
           PRINT(RPT:GRHEAD)
        ELSE
           OUTA:LINE=IegKopa&CHR(9)&FORMAT(VERT_Sg,@N-_13.2)&CHR(9)&FORMAT(VERT_IEGg,@N-_13.2)&CHR(9)&FORMAT(VERT_PARg,@N-_13.2)&CHR(9)&FORMAT(VERT_IZNg,@N-_13.2)&CHR(9)&FORMAT(VERT_SBg,@N-_13.2)&CHR(9)&FORMAT(VERT_NSg,@N-_13.2)&CHR(9)&FORMAT(VERT_Ng,@N-_13.2)&CHR(9)&CHR(9)&FORMAT(VERT_NIZNg,@N-_13.2)&CHR(9)&FORMAT(VERT_NBg,@N-_13.2)&CHR(9)&FORMAT(VERT_ASg,@N-_13.2)&CHR(9)&FORMAT(VERT_ABg,@N-_13.2)
           ADD(OUTFILEANSI)
        END
      .
      XX#=K:IIV-20
      IF ~INRANGE(XX#,1,7) THEN XX#=8.
      EXECUTE XX#
        IEGVEIDS='t.s. 1.Zemes gabali'
        IEGVEIDS='t.s. 2.Çkas,bûves un ilggad.stâdîjumi'
        IEGVEIDS='t.s. 3.Ilgtermiòa iegudîjumi nomâtajos P/L'
        IEGVEIDS='t.s. 4.Iekârtas un maðînas'
        IEGVEIDS='t.s. 5.Pârçjie P/L un inventârs'
        IEGVEIDS='t.s. 6.P/L izveid.un nep.celtn.obj.izm.'
        IEGVEIDS='t.s. 7.Avansa maksâjumi par P/L'
        IEGVEIDS='t.s. '&k:iiv&'.'
      .
      VERT_S   = K:VERT_S
      VERT_IEG = K:VERT_IEG
      VERT_PAR = K:VERT_PAR
      VERT_IZN = K:VERT_IZN
      VERT_SB  = K:VERT_S+K:VERT_IEG+K:VERT_PAR-K:VERT_IZN
      VERT_NS  = K:VERT_NS
      VERT_N   = K:VERT_N
      VERT_NIZN= K:VERT_NIZN
      VERT_NS  = ROUND(VERT_NS,.01)
      VERT_N   = ROUND(VERT_N,.01)
      VERT_NIZN= ROUND(VERT_NIZN,.01)
      VERT_NB  = K:VERT_NS+K:VERT_N-K:VERT_NIZN
      VERT_AS  = K:VERT_S-K:VERT_NS
      VERT_AB  = VERT_SB-VERT_NB
      IF F:DBF='W'
         PRINT(RPT:DETAIL)
      ELSE
         OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N-_13.2))&CHR(9)&|
         LEFT(FORMAT(VERT_PAR,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_SB,@N-_13.2))&|
         CHR(9)&LEFT(FORMAT(VERT_NS,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_N,@N-_13.2))&CHR(9)&CHR(9)&|
         LEFT(FORMAT(VERT_NIZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_NB,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_AS,@N-_13.2))&|
         CHR(9)&LEFT(FORMAT(VERT_AB,@N-_13.2))
         ADD(OUTFILEANSI)
      END
      VERT_SK  += K:VERT_S
      VERT_IEGK+= K:VERT_IEG
      VERT_PARK+= K:VERT_PAR
      VERT_IZNK+= K:VERT_IZN
      VERT_SBK += K:VERT_S+K:VERT_IEG+K:VERT_PAR-K:VERT_IZN
      VERT_NSK += VERT_NS
      VERT_NK  += VERT_N
      VERT_NIZNK+= VERT_NIZN
      VERT_NBK += VERT_NS+VERT_N-VERT_NIZN
      VERT_ASK += VERT_AS
      VERT_ABK += VERT_AB
    .
    IF f:dbf='w'
        PRINT(RPT:REPFOOT)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
    IF F:DBF='W'
        PRINT(RPT:LINE)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
    IF ~F:DTK
       loop i#= 1 to records(B_table)
         get(B_table,i#)
         IEGVEIDS = 't.s. '&B:BKK
         VERT_S   = B:VERT_S
         VERT_IEG = B:VERT_IEG
         VERT_PAR = B:VERT_PAR
         VERT_IZN = B:VERT_IZN
         VERT_SB  = B:VERT_S+B:VERT_IEG+B:VERT_PAR-B:VERT_IZN
         VERT_NS  = B:VERT_NS
         VERT_N   = B:VERT_N
         VERT_NIZN= B:VERT_NIZN
         VERT_NS  = ROUND(VERT_NS,.01)
         VERT_N   = ROUND(VERT_N,.01)
         VERT_NIZN= ROUND(VERT_NIZN,.01)
         VERT_NB  = VERT_NS+VERT_N-VERT_NIZN
         VERT_AS  = VERT_S-VERT_NS
         VERT_AB  = VERT_SB-VERT_NB
         IF F:DBF='W'
            PRINT(RPT:DETAIL)
         ELSE
            OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N-_13.2))&CHR(9)&|
            LEFT(FORMAT(VERT_PAR,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_SB,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(VERT_NS,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_N,@N-_13.2))&CHR(9)&CHR(9)&|
            LEFT(FORMAT(VERT_NIZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_NB,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_AS,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(VERT_AB,@N-_13.2))
            ADD(OUTFILEANSI)
         END
       .
       IF F:DBF='W'
         PRINT(RPT:LINE)
       ELSE
         OUTA:LINE=''
         ADD(OUTFILEANSI)
       END
       loop i#= 1 to records(C_table)
         get(C_table,i#)
         IEGVEIDS = 't.s. '&FORMAT(C:KAT,@P#-##P)
         VERT_S   = C:VERT_S
         VERT_IEG = C:VERT_IEG
         VERT_PAR = C:VERT_PAR
         VERT_IZN = C:VERT_IZN
         VERT_SB  = C:VERT_S+C:VERT_IEG+C:VERT_PAR-C:VERT_IZN
         VERT_NS  = C:VERT_NS
         VERT_N   = C:VERT_N
         VERT_NIZN= C:VERT_NIZN
         VERT_NS  = ROUND(VERT_NS,.01)
         VERT_N   = ROUND(VERT_N,.01)
         VERT_NIZN= ROUND(VERT_NIZN,.01)
         VERT_NB  = VERT_NS+VERT_N-VERT_NIZN
         VERT_AS  = C:VERT_S-VERT_NS
         VERT_AB  = VERT_SB-VERT_NB
         IF F:DBF='W'
            PRINT(RPT:DETAIL)
         ELSE
            OUTA:LINE=IegVeids&CHR(9)&LEFT(FORMAT(VERT_S,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IEG,@N-_13.2))&CHR(9)&|
            LEFT(FORMAT(VERT_PAR,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_IZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_SB,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(VERT_NS,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_N,@N-_13.2))&CHR(9)&CHR(9)&|
            LEFT(FORMAT(VERT_NIZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_NB,@N-_13.2))&CHR(9)&LEFT(FORMAT(VERT_AS,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(VERT_AB,@N-_13.2))
            ADD(OUTFILEANSI)
         END
       .
    .
    IF F:DBF='W'
      PRINT(RPT:LINE)
    ELSE
      OUTA:LINE=''
      ADD(OUTFILEANSI)
    END
    TS = 't.s.'
    IF RECORDS(N_TABLE)>1
       LOOP I#= 1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          NOD=N:NODALA
          IF NOD
            NodText = GetNodalas(NOD,1)
          ELSE
            NodText = 'Bez nodaïas'
          END
          IF F:DBF='W'
            PRINT(RPT:NODALA)
          ELSE
            OUTA:LINE=NOD&' '&NodText&CHR(9)&LEFT(FORMAT(N:VERT_S,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_IEG,@N-_13.2))&|
            CHR(9)&LEFT(FORMAT(N:VERT_PAR,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_IZN,@N-_13.2))&CHR(9)&|
            LEFT(FORMAT(N:VERT_SB,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_NS,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_N,@N-_13.2))&|
            CHR(9)&CHR(9)&LEFT(FORMAT(N:VERT_NIZN,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_NB,@N-_13.2))&CHR(9)&|
            LEFT(FORMAT(N:VERT_AS,@N-_13.2))&CHR(9)&LEFT(FORMAT(N:VERT_AB,@N-_13.2))
            ADD(OUTFILEANSI)
          END
          TS=''
       .
    .
    IF F:DBF='W'
        PRINT(RPT:paraksti)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
  ELSE           !WORD,EXCEL
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  FREE(K_TABLE)
  FREE(B_TABLE)
  FREE(C_TABLE)
  IF F:DBF<>'W' THEN F:DBF='W'.
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
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
P_INVLIN             PROCEDURE                    ! Declare Procedure
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

STRINGAGDM           STRING(120)
CP                   STRING(10)
KAT_NR               STRING(3)
DATUMS               LONG
VERT_S               DECIMAL(12,2)
VERT_B               DECIMAL(12,2)
FILTRS_TEXT          STRING(120)
TEXTS                STRING(30) !ATZÎMES PAR IZIEÐANU NO IERINDAS
SKAITS_K             DECIMAL(4)
VERT_SK              DECIMAL(12,2)
VERT_BK              DECIMAL(12,2)
DAT                  LONG
LAI                  LONG
AKTS_NR              USHORT
KOM1                 STRING(30)
KOM2                 STRING(30)
KOM3                 STRING(30)

!-----------------------------------------------------------------------------
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:ACC_DATUMS)
                       PROJECT(PAM:ACC_KODS)
                       PROJECT(PAM:ATB_NOS)
                       PROJECT(PAM:ATB_NR)
                       PROJECT(PAM:BIL_V)
                       PROJECT(PAM:BKK)
                       PROJECT(PAM:BKKN)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:DOK_SENR)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:EXPL_DATUMS)
                       PROJECT(PAM:OBJ_NR)
                       PROJECT(PAM:IEP_V)
                       PROJECT(PAM:IZG_GAD)
                       PROJECT(PAM:KAP_V)
                       PROJECT(PAM:LIN_G_PR)
                       PROJECT(PAM:NERAZ)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:NOS_A)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOS_S)
                       PROJECT(PAM:OKK7)
                       PROJECT(PAM:SKAITS)
                       PROJECT(PAM:U_NR)
                     END

report REPORT,AT(198,1538,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,300,12000,1240),USE(?unnamed)
         STRING(@s45),AT(3021,52,4896,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10406,500,625,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         STRING(''),AT(2375,271),USE(?String29),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(729,260,9479,208),USE(StringAGDM),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s120),AT(1552,490,7865,156),USE(FILTRS_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5625,938,3542,0),COLOR(COLOR:Black)
         STRING('Skaits'),AT(5656,979,469,208),USE(?String36:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(6177,979,781,208),USE(?String36:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(7010,979,469,208),USE(?String36:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzsk.Vçrtîba'),AT(7531,979,781,208),USE(?String36:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl.Vçrtîba'),AT(8365,990,781,208),USE(?String36:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1198,10885,0),COLOR(COLOR:Black)
         LINE,AT(8333,938,0,313),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(7500,938,0,313),USE(?Line6:8),COLOR(COLOR:Black)
         LINE,AT(6146,938,0,313),USE(?Line6:6),COLOR(COLOR:Black)
         LINE,AT(156,677,0,573),COLOR(COLOR:Black)
         STRING('Numurs'),AT(188,833,885,208),USE(?String36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kat.'),AT(1125,833,417,208),USE(?String36:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1594,833,2656,208),USE(?String36:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ekspl. nod.'),AT(4302,729,677,208),USE(?String36:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izl. gads'),AT(5031,833,573,208),USE(?String36:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktiski'),AT(5656,719,1302,208),USE(?String36:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc grâmatvedîbas datiem'),AT(7010,719,2135,208),USE(?String36:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atzîmes par izieð. no ierindas'),AT(9198,833,1823,208),USE(?String36:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11042,677,0,573),USE(?Line6:11),COLOR(COLOR:Black)
         LINE,AT(9167,677,0,573),USE(?Line6:10),COLOR(COLOR:Black)
         LINE,AT(6979,677,0,573),USE(?Line6:7),COLOR(COLOR:Black)
         LINE,AT(5625,677,0,573),USE(?Line6:5),COLOR(COLOR:Black)
         LINE,AT(5000,677,0,573),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('datums'),AT(4302,990,677,208),USE(?String36:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,677,0,573),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(1563,677,0,573),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(1094,677,0,573),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(156,677,10885,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,177)
         STRING(@n_9),AT(281,10,729,156),USE(PAM:U_NR),RIGHT
         LINE,AT(11042,-10,0,198),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,198),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,198),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7500,-10,0,198),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,198),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(6146,-10,0,198),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,198),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(1563,-10,0,198),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line16),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(8385,10,729,156),USE(VERT_B),RIGHT(1)
         STRING(@n4),AT(5156,10,313,156),USE(PAM:IZG_GAD),RIGHT(1)
         STRING(@D06.),AT(4323,10,625,156),USE(PAM:EXPL_DATUMS),RIGHT(1)
         STRING(@s40),AT(1667,10,2604,156),USE(PAM:NOS_P),LEFT
         STRING(@s30),AT(9219,10,1771,156),USE(TEXTS),LEFT
         STRING(@p#-##p),AT(1146,10,365,156),USE(KAT_NR),CENTER
         STRING(@n-_12.2),AT(7552,10,729,156),USE(VERT_S),RIGHT(12)
         STRING(@n4),AT(7083,10,313,156),USE(AMO:SKAITS),RIGHT(12)
       END
detail1 DETAIL,AT(,-10,,1104),USE(?unnamed:2)
         STRING(@n4),AT(7083,104,313,156),USE(SKAITS_K),RIGHT(12)
         LINE,AT(156,0,0,313),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(156,52,10885,0),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(5625,0,0,313),USE(?Line34:3),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,313),USE(?Line34:4),COLOR(COLOR:Black)
         LINE,AT(6979,0,0,313),USE(?Line34:5),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line34:6),COLOR(COLOR:Black)
         LINE,AT(8333,0,0,313),USE(?Line34:7),COLOR(COLOR:Black)
         LINE,AT(9167,0,0,313),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,313),USE(?Line34:2),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,52),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(1563,0,0,52),USE(?Line30:34),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,52),USE(?Line30:33),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,52),USE(?Line30:35),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7552,104,729,156),USE(VERT_SK),RIGHT(16)
         STRING('KOPÂ ( t.s. noòemtie pçdçjâ mçnesî ) :'),AT(365,104),USE(?String37),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,313,10885,0),USE(?Line29:2),COLOR(COLOR:Black)
         STRING(@T4),AT(10594,344),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(1250,573,5313,0),USE(?Line43),COLOR(COLOR:Black)
         STRING(@s30),AT(4646,646),USE(KOM2),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(1271,833,5313,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING(@s30),AT(4646,885),USE(KOM3),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(1271,1073,5313,0),USE(?Line43:3),COLOR(COLOR:Black)
         STRING('Komisija :'),AT(208,396),USE(?String41),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(4646,385),USE(KOM1),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@D06.),AT(9969,344),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@N-_12.2),AT(8385,104,729,156),USE(VERT_BK),RIGHT
       END
       FOOTER,AT(198,8000,12000,52)
         LINE,AT(156,0,10885,0),USE(?Line29:3),COLOR(COLOR:Black)
       END
     END

KOM  WINDOW('Komisijas sastâvs'),AT(,,173,91),CENTER,GRAY,DOUBLE
       STRING('Akts Nr :'),AT(53,9),USE(?String1)
       ENTRY(@N_4B),AT(81,8,27,10),USE(AKTS_NR,,?AKTS_NR:1)
       ENTRY(@s30),AT(11,27),USE(KOM1,,?KOM1:1)
       ENTRY(@s30),AT(11,41),USE(KOM2,,?KOM2:1)
       ENTRY(@s30),AT(11,54),USE(KOM3,,?KOM3:1)
       BUTTON('OK'),AT(131,70,33,15),USE(?OK)
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
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(PAM:RECORD)
  BIND('GADS',GADS)

  AKTS_NR =1
  KOM1    =SYS:PARAKSTS1
  KOM2    =SYS:PARAKSTS2
  KOM3    =GetPAR_K(PAR_NR,0,2)
  OPEN(KOM)
  DISPLAY
  ACCEPT
     DISPLAY
     CASE FIELD()
     OF ?OK
        CASE EVENT()
        OF EVENT:ACCEPTED
           BREAK
        .
     .
  .
  CLOSE(KOM)

  DAT = TODAY()
  LAI = CLOCK()
  STRINGAGDM='Pamatlîdzekïu inventarizâcijas AKTS Nr '&CLIP(AKTS_NR)&' uz '&CLIP(GADS)&'.g.'&CLIP(DAY(B_DAT))&'.'&|
  CLIP(MENVAR(B_DAT,2,3))&' (Lineârâ metode)'
  IF F:KAT_NR>'000' THEN FILTRS_TEXT='Kategorija: '&F:KAT_NR[1]&'-'&F:KAT_NR[2:3].
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Objekta(Pr.): '&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
  IF PAR_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Atbildîgâ: '&PAR_NR&' '&GetPAR_K(PAR_NR,0,2).
  CP='1'

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Inventarizâcijas Akts'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1))' !NAV NOÒEMTS IEPR.G-OS
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('P_INVLIN.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=STRINGAGDM
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Nr'&CHR(9)&'Kat.'&CHR(9)&'Nosaukums'&CHR(9)&'Ekspl. nod.'&CHR(9)&'Izl.'&CHR(9)&|
             'Faktiski'&CHR(9)&'Faktiski'&CHR(9)&'Skaits'&CHR(9)&'Uzskaites'&CHR(9)&'Atlikusî'&CHR(9)&|
             'Atzîmes par izieð. no ierindas'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'datums'&CHR(9)&'gads'&CHR(9)&'skaits'&CHR(9)&'vçrtîba'&CHR(9)&CHR(9)&|
             'vçrtîba'&CHR(9)&'vçrtîba'
          ELSE
             OUTA:LINE='Nr'&CHR(9)&'Kat.'&CHR(9)&'Nosaukums'&CHR(9)&'Ekspl. nod. datums'&CHR(9)&'Izl. gads'&CHR(9)&|
             'Faktiski skaits'&CHR(9)&'Faktiski vçrtîba'&CHR(9)&'Skaits'&CHR(9)&'Uzskaites vçrtîba'&CHR(9)&|
             'Atlikusî vçrtîba'&CHR(9)&'Atzîmes par izieð. no ierindas'
          .
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(F:OBJ_NR AND ~(PAM:OBJ_NR=F:OBJ_NR)) AND ~(PAR_NR AND ~(PAM:ATB_NR=PAR_NR)) !OBJ,ATBILDÎGO NEVAR MAINÎT
           CLEAR(AMO:RECORD)
           AMO:YYYYMM=DATE(MONTH(B_DAT),1,YEAR(B_DAT))
           AMO:U_NR=PAM:U_NR
           VERT_S=0
           VERT_B=0
           TEXTS=''
           GET(PAMAM,AMO:YYYYMM_KEY)
           IF ~ERROR() !Nav noòemts jau lîdz MM
              IF PAM:EXPL_DATUMS>=DATE(1,1,1995)
                 START_GD#=YEAR(PAM:EXPL_DATUMS)
              ELSE
                 START_GD#=1995
              .
              I#=0
              LOOP G#=START_GD# TO GADS
                I#+=1
              .
              IF ~CYCLEKAT(PAM:KAT[I#]) AND ~CYCLENODALA(AMO:NODALA)  !KAT VAR MAINÎTIES REIZI GADÂ,NODAÏA REIZI MÇNESÎ
   !           ~(F:NODALA AND ~(F:NODALA=AMO:NODALA)) !NODAÏA VAR MAINÎTIES KATRU MÇNESI
                  IF INRANGE(PAM:EXPL_DATUMS,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),DATE(MONTH(B_DAT)+1,1,YEAR(B_DAT))-1) !IEGÂDÂTS MMÇN.,NAV SÂK.V.
                     VERT_S=PAM:BIL_V   +PAM:nol_v+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !SÂK.V. MM BEIGÂS
                  ELSE
                     VERT_S=AMO:SAK_V_LI+PAM:nol_v+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !+1994
                  .
                  IF ~INRANGE(PAM:END_DATE,DATE(MONTH(B_DAT),1,YEAR(B_DAT)),DATE(MONTH(B_DAT)+1,1,YEAR(B_DAT))-1) !NOÒEMTS MM.
!                     VERT_B=VERT_S-PAM:KAP_V-PAM:NOL_V-AMO:NOL_U_LI-AMO:NOL_LIN
                     VERT_B=VERT_S-PAM:NOL_V-AMO:NOL_U_LI-AMO:NOL_LIN  !26.11.2008
                  ELSE
                     TEXTS='noòemts '&format(PAM:END_DATE,@D6)
                  .
                  KAT_NR=PAM:KAT[I#]
                  IF F:DBF='W'
                     PRINT(RPT:detail)
                  ELSE
                     OUTA:LINE=LEFT(FORMAT(PAM:U_NR,@N_11))&CHR(9)&FORMAT(KAT_NR,@P#_##P)&CHR(9)&PAM:NOS_P&CHR(9)&|
                     FORMAT(PAM:EXPL_DATUMS,@D06.)&CHR(9)&FORMAT(PAM:IZG_GAD,@N_4)&CHR(9)&CHR(9)&CHR(9)&|
                     FORMAT(AMO:SKAITS,@N_4)&CHR(9)&LEFT(FORMAT(VERT_S,@N-_12.2))&CHR(9)&LEFT(FORMAT(VERT_B,@N-_12.2))&|
                     CHR(9)&TEXTS
                     ADD(OUTFILEANSI)
                  .
                  VERT_SK+=VERT_S
                  VERT_BK+=VERT_B
                  SKAITS_K+=AMO:SKAITS
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:DETAIL1)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'KOPÂ'&CHR(9)&'(t.s. noòemtie pçdçjâ mçnesî):'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
        FORMAT(SKAITS_k,@N_4)&CHR(9)&LEFT(FORMAT(VERT_Sk,@N-_12.2))&CHR(9)&LEFT(FORMAT(VERT_Bk,@N-_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Komisija:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM1
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM2
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&'_{40} '&KOM3
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
  ELSE           !WORD,EXCEL
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF<>'W' THEN F:DBF='W'.
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
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
calcamort            PROCEDURE (OPC)              ! Declare Procedure
IZM_SAK_V           SREAL
!SAV_RECORD          LIKE(AMO:RECORD),PRE(SAV)
SAV_RECORD          LIKE(AMO:RECORD)
SAV_GADS            USHORT
GD_index            BYTE
END_DATE            LONG
SAK_V_LI            LIKE(AMO:SAK_V_LI)
SAK_V_GD            LIKE(AMO:SAK_V_LI)
IEGADATS            LIKE(AMO:SAK_V_LI)
END_LI              LONG
START_LI            LONG
AMO_NOL_U_LI        LIKE(AMO:NOL_U_LI)
AMO_SAK_V_LI        LIKE(AMO:SAK_V_LI)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
PercentProgress      BYTE
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,45),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
     END


  CODE                                            ! Begin processed code
!            JÂBÛT POZICIONÇTAM PAMAT FAILAM
!    OPC: 0-PÂRRÇÍINÂT SÂK V, PÂRRÇÍINÂT AMORTIZÂCIJU, KAM NAV LOCK
!         1-PÂRRÇÍINÂT SÂK V, PÂRRÇÍINÂT AMORTIZÂCIJU VISAM  --------------BAIL LIKT
!


 IF PAM:END_DATE                                            !OBLIGÂTI JÂPÂRBAUDA UZ 0
    END_LI=DATE(month(PAM:END_DATE),1,year(PAM:END_DATE))   !Nolietojums jârçíina arî pçdçjâ mçnesî
 ELSE
    END_LI=DATE(12,1,GADS)
 .
 START_LI=DATE(MONTH(PAM:EXPL_DATUMS),1,YEAR(PAM:EXPL_DATUMS))       !1. MÇN. UZSKAITAM AR 0-ES NOLIETOJUMU
 IF START_LI<DATE(1,1,1995) THEN START_LI=DATE(12,1,1994).
 !30/04/2015 IF YEAR(END_LI)-YEAR(START_LI)+1>20 !MAX DIM 20
 IF YEAR(END_LI)-YEAR(START_LI)+1>40 !MAX DIM 40
    KLUDA(0,CLIP(PAM:NOS_S)&' nav iespçjams sarçíinât amortizâciju uz '&GADS&' gadu')
    END_LI=DATE(12,1,YEAR(START_LI)+14) !
 .

 IF PAMAM::USED=0
    CHECKOPEN(PAMAM,1)
 .                                                                 
 PAMAM::USED+=1

 GD_INDEX=0
 SAK_V_GD=PAM:BIL_V
 AMO_NOL_U_LI=0
 AMO_SAK_V_LI=0           !NAV SÂKUMA VÇRTÎBAS UZ IEGÂDES MÇNEÐA SÂKUMU

 RecordsToProcess = (B_DAT-START_LI)/30
 RecordsProcessed = 0
 PercentProgress = 0
 OPEN(ProgressWindow)
 Progress:Thermometer = 0
 ?Progress:PctText{Prop:Text} = '0%'
 ProgressWindow{Prop:Text} = 'Rçíinam nolietojumu'
 ?Progress:UserString{Prop:Text}=PAM:NOS_P

 CLEAR(AMO:RECORD)
 AMO:U_NR=PAM:U_NR
 AMO:YYYYMM=START_LI
! LOOP UNTIL AMO:YYYYMM > DATE(12,1,YEAR(END_LI))
 LOOP UNTIL AMO:YYYYMM > B_DAT
    IF AMO:YYYYMM <= END_LI
       GET(PAMAM,AMO:NR_KEY)
       IF ERROR()                             ! RÇÍINAM JAUNU
          IF AMO:YYYYMM   =START_LI           ! NAV 1. APRÇÍINA
             AMO:U_NR     =pam:U_nr
             AMO:LIN_G_PR =PAM:LIN_G_PR
             AMO:NODALA   =PAM:NODALA
             AMO:SKAITS   =PAM:SKAITS
             IEGADATS     =PAM:BIL_V
          ELSE
             IEGADATS     =0
          .
          AMO:KAPREM   =0
          AMO:LOCK_LIN =0
          AMO:PARCEN   =0
          AMO:PARCENLI =0
          AMO:NOL_U_LI =AMO_NOL_U_LI
          AMO:SAK_V_LI =AMO_SAK_V_LI
          DO IZSLEGTS
          DO CALCLIN
          ADD(PAMAM)   !JA NAV ATRASTS, PÂRÇJOS DATUS ÒEMAM NO IEPRIEKÐÇJÂ
          IF ERROR()
             KLUDA(0,'ADD PAMAM '&CLIP(PAM:U_NR)&' '&PAM:NOS_S)
          .
       ELSE                                   ! LABOJAM VECU
          SAV_RECORD=AMO:RECORD
          AMO:NOL_U_LI =AMO_NOL_U_LI
          AMO:SAK_V_LI =AMO_SAK_V_LI
          IF AMO:YYYYMM   =START_LI           ! 1. APRÇÍINS
             IEGADATS     =PAM:BIL_V
          ELSE
             IEGADATS     =0
          .
          DO IZSLEGTS
          DO CALCLIN
          IF ~(SAV_RECORD=AMO:RECORD)
!             STOP(FORMAT(AMO:YYYYMM,@D06.)&' '&AMO:SAK_V_LI&' rakstu')
             IF RIUPDATE:PAMAM()
                KLUDA(0,'PUT PAMAM '&CLIP(PAM:U_NR)&' '&PAM:NOS_S)
             .
          .
       .
       AMO_NOL_U_LI=AMO:NOL_U_LI+AMO:NOL_LIN  !Uzkrâtais nolietojums mçneða beigâs
       AMO_SAK_V_LI=IEGADATS+AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-AMO:IZSLEGTS
!       STOP(FORMAT(AMO:YYYYMM,@D06.)&' '&AMO:SAK_V_LI&' '&AMO_SAK_V_LI)
       SAK_V_GD+=AMO:KAPREM+AMO:PARCEN    !?IZSLÇGTS
   !-----------------GD-------------------------------------
       IF MONTH(AMO:YYYYMM)=12 AND YEAR(AMO:YYYYMM)>=1995 AND|
       ~INRANGE(PAM:END_DATE,DATE(1,1,YEAR(AMO:YYYYMM)),DATE(12,31,YEAR(AMO:YYYYMM)))  !NAV NOÒEMTS ÐAJÂ GADÂ
!          STOP(YEAR(AMO:YYYYMM)&' '&MONTH(AMO:YYYYMM))
          GD_INDEX+=1
          PAM:SAK_V_GD[GD_INDEX]=SAK_V_GD
          IF GD_INDEX > 1
             IF ~PAM:KAT[GD_INDEX] THEN PAM:KAT[GD_INDEX]=PAM:KAT[GD_INDEX-1]. !ÒEMAM NO IEPRIEKÐÇJÂ
             IF ~PAM:GD_PR[GD_INDEX] THEN PAM:GD_PR[GD_INDEX]=PAM:GD_PR[GD_INDEX-1].
             IF ~PAM:GD_KOEF[GD_INDEX] THEN PAM:GD_KOEF[GD_INDEX]=PAM:GD_KOEF[GD_INDEX-1].
          .
          DO CALCGD
          SAK_V_GD-=PAM:NOL_GD[GD_INDEX]
       .
   !------------------------------------------------------
       AMO:YYYYMM=DATE(month(AMO:YYYYMM)+1,1,year(AMO:YYYYMM))
    ELSE !JAU NOÒEMTS
       GET(PAMAM,AMO:NR_KEY)
       IF ~ERROR()
          DELETE(PAMAM)
       .
       AMO:YYYYMM=DATE(month(AMO:YYYYMM)+1,1,year(AMO:YYYYMM))
    .
    RecordsProcessed += 1
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
 .
! IF RIUPDATE:PAMAT()
 PUT(PAMAT)
 IF ERROR()
    KLUDA(24,'PAMAT '&PAM:U_NR&' '&GD_INDEX&' '&PAM:NOS_S)
 .
 CLOSE(ProgressWindow)


!-----------------------------------------------------------------------------------
IZSLEGTS    ROUTINE
 IF PAM:END_DATE AND AMO:YYYYMM=DATE(month(PAM:END_DATE),1,year(PAM:END_DATE))  !IZSLÇGTS
    AMO:IZSLEGTS =AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !+IZMAIÒAS PÇD.MÇNESÎ
    IF GD_INDEX
       IF ~PAM:KAT[GD_INDEX+1] THEN PAM:KAT[GD_INDEX+1]=PAM:KAT[GD_INDEX].
       IF ~PAM:GD_PR[GD_INDEX+1] THEN PAM:GD_PR[GD_INDEX+1]=PAM:GD_PR[GD_INDEX].
       IF ~PAM:GD_KOEF[GD_INDEX+1] THEN PAM:GD_KOEF[GD_INDEX+1]=PAM:GD_KOEF[GD_INDEX].
       PAM:SAK_V_GD[GD_INDEX+1]=SAK_V_GD
    .
    X#=0
    !30/04/2015 LOOP UNTIL GD_INDEX+X#=19
    LOOP UNTIL GD_INDEX+X#=39
       X#+=1
       PAM:NOL_GD[GD_INDEX+X#]=0   !MAX=40
       PAM:LOCK_GD[GD_INDEX+X#]=0
       IF X#>1
          PAM:KAT[GD_INDEX+X#]=''
          PAM:SAK_V_GD[GD_INDEX+X#]=0
       .
    .
 ELSE
    AMO:IZSLEGTS =0
 .

!-----------------------------------------------------------------------------------
CALCLIN    ROUTINE
 IF ~AMO:LOCK_LIN
    IF ~(AMO:YYYYMM=START_LI)         !NAV 1. MÇNESIS
       IF SUB(PAM:KAT[1],1,1)='1'     !ÇKAS, PIEÒEMAM, KA NO/UZ 1.KATEGORIJU NEKAS NEVAR MAINÎTIES
          IF BAND(PAM:BAITS,00000001B) !JÂNOLIETO LÎDZ DD.MM.GG NEATKARÎGI NO IZMAIÒÂM
             MENESI#=(100/PAM:LIN_G_PR)*12
!             ATLIKUSI#=(DATE(MONTH(START_LI)+1+MENESI#,1,YEAR(START_LI))-AMO:YYYYMM)/30
             ATLIKUSI#=0
             SAV_MEN_NR#=0
             LOOP D#=AMO:YYYYMM TO DATE(MONTH(START_LI)+MENESI#,1,YEAR(START_LI))
                IF ~(SAV_MEN_NR#=MONTH(D#))
                   ATLIKUSI#+=1
                   SAV_MEN_NR#=MONTH(D#)
                .
             .
!             STOP(FORMAT(DATE(MONTH(START_LI)+1+MENESI#,1,YEAR(START_LI)),@D06.)&' '&ATLIKUSI#)
             AMO:NOL_LIN=ROUND((AMO:SAK_V_LI-AMO:NOL_U_LI)/ATLIKUSI#,.001)
          ELSE
             AMO:NOL_LIN=ROUND(AMO:SAK_V_LI*(AMO:LIN_G_PR/100/12),.001)
          .
       ELSE                            !GADI
          IF BAND(PAM:BAITS,00000001B) !JÂNOLIETO LÎDZ DD.MM.GG NEATKARÎGI NO IZMAIÒÂM
             MENESI#=PAM:LIN_G_PR*12
!             ATLIKUSI#=(DATE(MONTH(START_LI)+1+MENESI#,1,YEAR(START_LI))-AMO:YYYYMM)/30
             ATLIKUSI#=0
             SAV_MEN_NR#=0
             LOOP D#=AMO:YYYYMM TO DATE(MONTH(START_LI)+MENESI#,1,YEAR(START_LI))
                IF ~(SAV_MEN_NR#=MONTH(D#))
                   ATLIKUSI#+=1
                   SAV_MEN_NR#=MONTH(D#)
                .
             .
             AMO:NOL_LIN=ROUND((AMO:SAK_V_LI-AMO:NOL_U_LI)/ATLIKUSI#,.001)
          ELSE                         !VÇRTÎBAS IZMAIÒAS NOLIETOSIES LIN_G_PR LAIKÂ
             AMO:NOL_LIN=ROUND(AMO:SAK_V_LI/(AMO:LIN_G_PR*12),.001)
          .
       .
       IF INRANGE(AMO:NOL_U_LI+AMO:NOL_LIN-(AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-AMO:IZSLEGTS),-0.03,0.03) !NAV VÇRTS SKAITÎT TÂLÂK
          AMO:NOL_LIN=AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-AMO:IZSLEGTS-AMO:NOL_U_LI
       ELSIF AMO:NOL_U_LI+AMO:NOL_LIN > AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI !-AMO:IZSLEGTS
          AMO:NOL_LIN=AMO:SAK_V_LI+AMO:KAPREM+AMO:PARCEN+AMO:PARCENLI-AMO:NOL_U_LI !-AMO:IZSLEGTS
       .
    ELSE
       AMO:NOL_LIN  =0
    .
 .
!-----------------------------------------------------------------------------------
CALCGD     ROUTINE
 IF YEAR(AMO:YYYYMM) >= YEAR(PAM:EXPL_DATUMS)               ! PAR VISU GADU
    IF (OPC=0 AND ~PAM:LOCK_GD[GD_INDEX]) OR OPC=1
       IF PAM:GD_KOEF[GD_INDEX]
!          PAM:NOL_GD[GD_INDEX]=ROUND(PAM:SAK_V_GD[GD_INDEX]*PAM:GD_PR[GD_INDEX]*2/100,.01)*PAM:GDPLUS_KOEF[GD_INDEX]
          PAM:NOL_GD[GD_INDEX]=ROUND(PAM:SAK_V_GD[GD_INDEX]*PAM:GD_PR[GD_INDEX]*PAM:GD_KOEF[GD_INDEX]/100,.01)
          !PAM:GDPLUS_KOEF[GD_INDEX]-DUBULTAIS VAI CITS KOEFICIENTS(TAGAD arî A/M NO 2007.G.)
       ELSE
!          PAM:NOL_GD[GD_INDEX]=ROUND(PAM:SAK_V_GD[GD_INDEX]*PAM:GD_PR[GD_INDEX]*2/100,.01)
          STOP('GD DUBULTAIS KOEFICIENTS=0')
          PAM:NOL_GD[GD_INDEX]=0
       .
    .
 .






