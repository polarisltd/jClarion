                     MEMBER('winlats.clw')        ! This is a MEMBER module
SPZ_ServApgLapa      PROCEDURE (OPC)              ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
KESKA                STRING(50)
APK_DARBI            STRING(110)
APK_NEDARBI          STRING(110)
PAR_NOS_P            STRING(35)
PAR_FIN_NR           STRING(13)
PAR_ADRESE           STRING(40)
AUT_AUTO             STRING(40)
AUT_VADITAJS         STRING(35)
SKALOT               STRING(26)
DALAS_DARBI          STRING(50)
nom_NOSAUKUMS        STRING(50)
cena                 decimal(11,2)
summa1               decimal(11,2)
summak               decimal(11,2)
summaPK              decimal(11,2)
VUT1                 STRING(20)
VUT2                 STRING(20)
VUT3                 STRING(20)
VUT4                 STRING(20)
VUT                  STRING(20)
!PLKST                TIME
RPT_NPK              BYTE
KOMATS               STRING(1)
!dat                  LONG
LAI                  LONG
MERV                 STRING(7)
MAKSATAJS            STRING(80)
LINE                 STRING(132)

OBJ_ADRESE           STRING(60)
NOM_SER              STRING(21)
NOMENKL              STRING(21)
RET                  BYTE
pav_rek_nr           STRING(12)
pav_rek_nr_end       STRING(13)
GL_ADRESE            STRING(55)
SYS_ADRESE           STRING(55)
SYS_PARAKSTS         STRING(25)

!-----------------------------------------------------------------------------
report REPORT,AT(146,198,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,2135),USE(?unnamed:5)
         STRING(@s45),AT(3708,0,4063,208),USE(client),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s55),AT(3667,167,4104,188),USE(GL_ADRESE,,?GL_ADRESE:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s55),AT(3667,323,4104,188),USE(SYS_ADRESE),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6677,479,1094,190),USE(GL:VID_NR),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(2281,500,4375,208),USE(KESKA),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Odometrs'),AT(4115,1719,781,208),USE(?String73:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_7B),AT(4927,1719),USE(APK:NOBRAUKUMS),LEFT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_8),AT(6969,1802),USE(PAV:U_NR),TRN,RIGHT
         STRING(@S14),AT(6969,1927),USE(PAV:DOK_SENR,,?PAV:DOK_NR:2)
         STRING(@s80),AT(469,1927,5990,208),USE(MAKSATAJS,,?MAKSATAJS:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasûtîtâjs:'),AT(469,979,729,208),USE(?String73:6),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1198,979,2656,208),USE(PAR_NOS_P),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Tâlr. nr.'),AT(469,1719,469,208),USE(?String73:16),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Vadîtâjs:'),AT(469,1510,469,208),USE(?String95:1)
         STRING(@s35),AT(1042,1510,2969,208),USE(aut_vaditajs)
         STRING(@s20),AT(1042,1719),USE(aut:telefons)
         STRING(@s20),AT(4927,1323),USE(AUT:KRASA),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(1198,1323,2833,208),USE(PAR_adrese),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(1198,1156),USE(PAR_FIN_NR),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Krâsa'),AT(4115,1333,417,208),USE(?String73:8),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s20),AT(4927,1521),USE(AUT:VIRSB_NR),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Dzinçjs'),AT(4104,1125,573,208),USE(?String73:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Datums:'),AT(469,781,521,208),USE(?String73),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(1167,792),USE(PAV:DATUMS),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts Nr.'),AT(4115,740,625,208),USE(?String73:4),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s12),AT(4927,740),USE(AUT:V_NR),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s7),AT(5969,740),USE(AUT:V_NR2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Automaðîna '),AT(4104,938,781,208),USE(?String73:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s35),AT(4927,938,2656,208),USE(AUT_AUTO),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Virsbûves Nr.'),AT(4115,1521,781,208),USE(?String73:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s20),AT(4927,1125),USE(AUT:DZINEJS),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(6458,1125),USE(AUT:Dzineja_K),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
HEADER:1 DETAIL,AT(,,,2135),USE(?unnamed:6)
         STRING(@s45),AT(3708,0,4063,208),USE(client,,?CLIENT:1),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4385,177,3385,208),USE(GL:ADRESE,,?GL:ADRESE:1),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6677,354,1094,208),USE(GL:VID_NR,,?GL:VID_NR:1),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(2281,500,4375,208),USE(KESKA,,?KESKA:1),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(469,1927,5990,208),USE(MAKSATAJS,,?MAKSATAJS:1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasûtîtâjs:'),AT(469,979,729,208),USE(?String73:6:1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1198,979,2656,208),USE(PAR_NOS_P,,?PAR_NOS_P:1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Tâlr. nr.'),AT(5000,1208,469,208),USE(?String73:10:1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kontaktpersona:'),AT(4646,1000),USE(?String95:11)
         STRING(@s35),AT(5552,990,2292,208),USE(aut_vaditajs,,?aut_vaditajs:2:1)
         STRING(@s20),AT(5531,1208),USE(aut:telefons,,?aut:telefons:2:1)
         STRING(@s40),AT(1198,1323,2833,208),USE(PAR_adrese,,?PAR_ADRESE:1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(1198,1156),USE(PAR_FIN_NR,,?PAR_FIN_NR:2:1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Objekta adrese:'),AT(198,1708,938,208),USE(?String73:14:1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(1198,1708,4427,208),USE(OBJ_ADRESE),TRN,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums:'),AT(469,781,521,208),USE(?String73:1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(1167,792),USE(PAV:DATUMS,,?PAV:DATUMS:1),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Lîguma Nr:'),AT(458,1510,677,208),USE(?String73:14:11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(1198,1510,3385,208),USE(par:LIGUMS),FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
CAR_HEAD DETAIL,AT(,,,3010),USE(?CAR_HEAD)
         STRING('Tehniskâ pase servisâ'),AT(469,271,1354,208),USE(?String73:11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('paliek'),AT(1927,271,625,208),USE(?String93),CENTER,FONT(,9,,)
         STRING('nepaliek'),AT(2865,271,625,208),USE(?String93:2),CENTER,FONT(,9,,)
         LINE,AT(1875,231,0,260),USE(?Line81:2),COLOR(COLOR:Black)
         LINE,AT(3490,231,0,260),USE(?Line81:24),COLOR(COLOR:Black)
         LINE,AT(2813,231,0,260),USE(?Line81:25),COLOR(COLOR:Black)
         LINE,AT(2552,231,0,260),USE(?Line81:26),COLOR(COLOR:Black)
         LINE,AT(1875,492,1875,0),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(3750,231,0,260),USE(?Line81:22),COLOR(COLOR:Black)
         LINE,AT(1875,231,1875,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('Nomainîtâs daïas servisâ'),AT(4167,271,1552,208),USE(?String73:13),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('paliek'),AT(5927,271,625,208),USE(?String193),CENTER,FONT(,9,,)
         STRING('nepaliek'),AT(6865,271,625,208),USE(?String193:2),CENTER,FONT(,9,,)
         LINE,AT(5875,231,0,260),USE(?Line181:2),COLOR(COLOR:Black)
         LINE,AT(7490,231,0,260),USE(?Line181:24),COLOR(COLOR:Black)
         LINE,AT(6813,231,0,260),USE(?Line181:25),COLOR(COLOR:Black)
         LINE,AT(6552,231,0,260),USE(?Line181:26),COLOR(COLOR:Black)
         LINE,AT(5875,492,1875,0),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(7750,231,0,260),USE(?Line811:22),COLOR(COLOR:Black)
         LINE,AT(5875,231,1875,0),USE(?Line15:2),COLOR(COLOR:Black)
         STRING('A/M mazgât ?'),AT(4177,573,1552,208),USE(?StringM73:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('jâ'),AT(5990,573,438,208),USE(?StringM193),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('nç'),AT(6927,573,448,208),USE(?StringM193:2),CENTER
         LINE,AT(5875,531,0,260),USE(?Line181:M2),COLOR(COLOR:Black)
         LINE,AT(6813,1021,0,-490),USE(?Line181:M26:3),COLOR(COLOR:Black)
         LINE,AT(7490,1021,0,-490),USE(?Line181:M26:4),COLOR(COLOR:Black)
         LINE,AT(6552,1021,0,-490),USE(?Line181:M26),COLOR(COLOR:Black)
         LINE,AT(5875,792,1875,0),USE(?Line15:M5),COLOR(COLOR:Black)
         LINE,AT(7750,802,0,260),USE(?Line811:M22:2),COLOR(COLOR:Black)
         STRING('jâ'),AT(6000,813,438,208),USE(?StringM193:3),TRN,CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('nç'),AT(6927,823,448,208),USE(?StringM193:4),TRN,CENTER
         STRING(@s26),AT(4177,854,1677,208),USE(SKALOT),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5875,1042,1875,0),USE(?Line15:M5:2),COLOR(COLOR:Black)
         LINE,AT(5875,792,0,260),USE(?Line181:M2:2),COLOR(COLOR:Black)
         LINE,AT(7750,531,0,260),USE(?Line811:M22),COLOR(COLOR:Black)
         LINE,AT(5875,531,1875,0),USE(?Line15:M2),COLOR(COLOR:Black)
         STRING('Lîdz kuram laikam jâbût gatavai:'),AT(5552,1094,1927,208),USE(?String73:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(52,10,7813,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(5573,1531,1823,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@s12),AT(208,1479,2031,438),USE(pav_rek_nr),TRN,CENTER,FONT('Code 3 de 9',26,,,CHARSET:SYMBOL)
         STRING(@s13),AT(5604,1677,2104,438),USE(pav_rek_nr_END),CENTER,FONT('Code 3 de 9',26,,,CHARSET:SYMBOL)
       END
DARBI_HEAD DETAIL,AT(,,,427),USE(?unnamed:13)
         LINE,AT(271,21,7604,0),USE(?Line5:3),COLOR(COLOR:Black)
         STRING('Klienta sûdzîbas'),AT(1698,73,4406,208),USE(?String38:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(271,375,7594,0),USE(?Line116),COLOR(COLOR:Black)
         LINE,AT(7865,31,0,344),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(271,31,0,344),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(625,21,0,344),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(302,52,313,208),USE(?String38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1625,7604,0),USE(?Line5:4),COLOR(COLOR:Black)
       END
SUD_HEAD DETAIL,AT(,,,354),USE(?unnamed:14)
         LINE,AT(7865,63,0,313),USE(?Line118:3),COLOR(COLOR:Black)
         LINE,AT(625,52,0,313),USE(?Line118:2),COLOR(COLOR:Black)
         LINE,AT(260,52,7604,0),USE(?Line117),COLOR(COLOR:Black)
         STRING('Klienta sûdzîbas'),AT(3177,94,1427,177),USE(?String143),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(271,302,7583,0),USE(?Line121),COLOR(COLOR:Black)
         LINE,AT(260,52,0,313),USE(?Line118),COLOR(COLOR:Black)
         STRING('Npk'),AT(292,94,333,177),USE(?String144),TRN,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
PDARBI_HEAD DETAIL,AT(,,,302),USE(?unnamed:12)
         LINE,AT(7865,0,0,313),USE(?Line8:P21),COLOR(COLOR:Black)
         STRING('Veicamie darbi'),AT(1656,31,4469,208),USE(?String38:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,0,0,313),USE(?Line8:P4),COLOR(COLOR:Black)
         LINE,AT(625,0,0,313),USE(?Line8:P7),COLOR(COLOR:Black)
         LINE,AT(260,261,7604,0),USE(?Line5:P4),COLOR(COLOR:Black)
       END
DARBI  DETAIL,AT(,,,177)
         LINE,AT(7865,-10,0,197),USE(?Line8:28),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line8:31),COLOR(COLOR:Black)
         STRING(@s110),AT(729,0,7031,156),USE(apk_darbi),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(260,-10,0,197),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s3),AT(365,10,208,156),USE(RPT_npk),RIGHT
       END
DARBI_FOOT DETAIL,AT(,-10,,104),USE(?unnamed:3)
         LINE,AT(260,0,0,52),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(625,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(260,52,7604,0),USE(?Line5:7),COLOR(COLOR:Black)
       END
DARBI_FOOT1 DETAIL,PAGEAFTER(-1),AT(,-10,,1198),USE(?unnamed:4)
         STRING(@T1),AT(7500,0),USE(LAI,,?LAI:3),FONT(,7,,,CHARSET:BALTIC)
         STRING('Par automaðînâ atstâtajâm mantâm serviss atbildîbu neuzòemas.'),AT(313,94,4427,208), |
             USE(?String47:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Automaðîna testa brauciena nepiecieðamîbas gadîjumâ var atrasties ârpus uzòçmuma' &|
             ' teritorijas'),AT(313,229,5677,208),USE(?String47:3),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Jûsu dati tiks izmantoti raþotâja kvalitâtes aptaujas veikðanai'),AT(313,375,3521,208), |
             USE(?String47),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         BOX,AT(3833,406,1813,198),USE(?Box1),COLOR(COLOR:Black),FILL(COLOR:White)
         LINE,AT(4521,406,0,188),USE(?Line113:3),COLOR(COLOR:Black)
         LINE,AT(5365,406,0,188),USE(?Line113:2),COLOR(COLOR:Black)
         LINE,AT(4792,417,0,188),USE(?Line113),COLOR(COLOR:Black)
         STRING('nç'),AT(4885,427,438,156),USE(?StringM193:6),TRN,CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('jâ'),AT(4021,427,438,156),USE(?StringM193:5),TRN,CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieòçmçjs'),AT(313,729),USE(?String49)
         LINE,AT(4750,885,2656,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s25),AT(1115,875),USE(SYS_PARAKSTS,,?SYS_PARAKSTS:3),TRN,CENTER
         STRING('Automaðîna nodota servisâ ar atslçgâm'),AT(4635,990,2500,208),USE(?String73:15),LEFT, |
             FONT(,10,,,CHARSET:BALTIC)
         STRING('Klients'),AT(4156,729,573,208),USE(?String49:2)
         LINE,AT(865,833,2656,0),USE(?Line77:2),COLOR(COLOR:Black)
       END
DARBI_FOOT1:1 DETAIL,PAGEAFTER(-1),AT(,-10,,1198),USE(?unnamed:7)
         STRING(@T1),AT(7552,0),USE(LAI,,?LAI:4),TRN,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s35),AT(313,781,2240,156),USE(CLIENT,,?CLIENT:5),RIGHT(1)
         LINE,AT(2594,938,2031,0),USE(?Line77:2:1),COLOR(COLOR:Black)
         LINE,AT(5135,938,2656,0),USE(?Line77:5:1),COLOR(COLOR:Black)
         STRING(@s25),AT(2750,969),USE(SYS_PARAKSTS,,?SYS_PARAKSTS:4),TRN,CENTER
         STRING('Klients'),AT(4677,771,417,208),USE(?String49:3:1)
       END
NOM_HEAD DETAIL,AT(,,,500)
         STRING(@s50),AT(313,42,3625,208),USE(DALAS_DARBI),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,260,0,260),USE(?Line78:7),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(625,260,0,260),USE(?Line78:3),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?Line5:6),COLOR(COLOR:Black)
         STRING('Summa'),AT(6656,302,469,156),USE(?String47:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(281,292,313,156),USE(?String38:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Skaits'),AT(5135,302,365,156),USE(?String47:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçrvien.'),AT(5563,302,521,156),USE(?String47:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,260,0,260),USE(?Line78:5),COLOR(COLOR:Black)
         STRING('Cena'),AT(6135,302,417,156),USE(?String47:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(646,302,1354,156),USE(NOM_SER),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2052,302,3021,156),USE(?String47:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6563,260,0,260),USE(?Line78:51),COLOR(COLOR:Black)
         LINE,AT(7135,260,0,260),USE(?Line78:6),COLOR(COLOR:Black)
         LINE,AT(2031,260,0,260),USE(?Line78:4),COLOR(COLOR:Black)
         LINE,AT(5104,260,0,260),USE(?Line78:57),COLOR(COLOR:Black)
         LINE,AT(5521,260,0,260),USE(?Line78:8),COLOR(COLOR:Black)
         LINE,AT(7865,260,0,260),USE(?Line78:61),COLOR(COLOR:Black)
       END
NOMEN  DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(260,-10,0,197),USE(?Line79:7),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line79:3),COLOR(COLOR:Black)
         STRING(@s21),AT(667,10,1354,156),USE(nomenkl)
         STRING(@s50),AT(2104,10,2969,156),USE(nom_Nosaukums)
         STRING(@n_6.2b),AT(5135,10,354,156),USE(nol:daudzums),RIGHT
         STRING(@n_8.2b),AT(6125,10,417,156),USE(cena),RIGHT
         STRING(@n_8.2b),AT(6594,0,521,156),USE(summa1),RIGHT
         LINE,AT(7135,-10,0,197),USE(?Line79:5),COLOR(COLOR:Black)
         STRING(@s3),AT(354,10,208,156),USE(RPT_npk,,?RPT_NPK:2),RIGHT
         LINE,AT(6563,-10,0,197),USE(?Line79:51),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,197),USE(?Line79:4),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,197),USE(?Line79:57),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,197),USE(?Line79:8),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line79:6),COLOR(COLOR:Black)
         STRING(@s7),AT(5604,10,469,156),USE(merv),LEFT
         LINE,AT(6094,-10,0,197),USE(?Line79:511),COLOR(COLOR:Black)
       END
NOM_FOOTK DETAIL,AT(,-10,,333),USE(?unnamed)
         STRING('Kopâ :'),AT(4646,83,417,156),USE(?String47:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(6594,83,521,156),USE(summak),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,52,7604,0),USE(?Line5:9),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,260),USE(?Line5:23),COLOR(COLOR:Black)
         LINE,AT(260,260,7604,0),USE(?Line5:10),COLOR(COLOR:Black)
         LINE,AT(260,0,0,260),USE(?Line5:11),COLOR(COLOR:Black)
         LINE,AT(625,0,0,260),USE(?Line5:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,260),USE(?Line5:121),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,260),USE(?Line5:24),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,260),USE(?Line5:13),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,260),USE(?Line5:22),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,260),USE(?Line5:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,260),USE(?Line5:15),COLOR(COLOR:Black)
       END
NOM_FOOTPK DETAIL,AT(,-10,,531),USE(?unnamed:8)
         STRING('Kopâ :'),AT(4646,104,417,156),USE(?String747:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(6594,104,521,156),USE(summak,,SUMMAK:1),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pavisam :'),AT(4490,260,573,156),USE(?String47:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(6594,260,521,156),USE(summapk),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,52,7604,0),USE(?Line75:9),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,469),USE(?Line75:131),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?Line5:16),COLOR(COLOR:Black)
         LINE,AT(260,0,0,469),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(625,0,0,469),USE(?Line75:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,469),USE(?Line75:121),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,469),USE(?Line75:122),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,469),USE(?Line75:13),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,469),USE(?Line75:931),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,469),USE(?Line75:132),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,469),USE(?Line75:15),COLOR(COLOR:Black)
       END
NOM_FOOTPKA DETAIL,AT(,-10,,750),USE(?unnamed:9)
         STRING('Kopâ :'),AT(4646,104,417,156),USE(?String1747:8),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(6594,104,521,156),USE(summak,,SUMMAK:11),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pavisam :'),AT(4490,260,573,156),USE(?String147:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n_8.2b),AT(6594,260,521,156),USE(summapk,,?summapk:2),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,52,7604,0),USE(?Line175:9),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,469),USE(?Line175:131),COLOR(COLOR:Black)
         LINE,AT(260,469,7604,0),USE(?Line15:16),COLOR(COLOR:Black)
         LINE,AT(260,0,0,469),USE(?Line15:20),COLOR(COLOR:Black)
         LINE,AT(625,0,0,469),USE(?Line175:12),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,469),USE(?Line175:121),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,469),USE(?Line175:122),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,469),USE(?Line175:13),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,469),USE(?Line175:831),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,469),USE(?Line175:132),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,469),USE(?Line175:15),COLOR(COLOR:Black)
         STRING('Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu'),AT(344,521,3542,208), |
             USE(?String62),LEFT
         STRING(@n-_10.2),AT(4031,521,625,208),USE(pav:summa_A),RIGHT
         STRING(@s3),AT(4792,521,260,208),USE(pav:val),LEFT
       END
NDEF_HEAD DETAIL,AT(,,,354)
         STRING('Paliekoðie defekti'),AT(656,94,7188,208),USE(?String47:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,313,7604,0),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(260,52,7604,0),USE(?Line5:17),COLOR(COLOR:Black)
         STRING('Npk'),AT(313,104,313,208),USE(?String38:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,52,0,313),USE(?Line78:71),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line78:72),COLOR(COLOR:Black)
         LINE,AT(260,52,0,313),USE(?Line78:73),COLOR(COLOR:Black)
       END
NDEFEKTI DETAIL,AT(,,,177)
         LINE,AT(260,-10,0,197),USE(?Line59),COLOR(COLOR:Black)
         STRING(@s3),AT(365,10,208,156),USE(RPT_npk,,?RPT_NPK:3),RIGHT
         STRING(@s110),AT(719,10,7031,156),USE(apk_nedarbi),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(625,-10,0,197),USE(?Line59:98),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,197),USE(?Line59:2),COLOR(COLOR:Black)
       END
NDEF_FOOT DETAIL,AT(,-10,,104)
         LINE,AT(260,52,7604,0),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line65),COLOR(COLOR:Black)
         LINE,AT(625,0,0,52),USE(?Line64),COLOR(COLOR:Black)
         LINE,AT(260,0,0,52),USE(?Line63),COLOR(COLOR:Black)
       END
FROM_FILE DETAIL,AT(,-10,,146)
         STRING(@s132),AT(250,0,7865,150),USE(LINE),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
NOM_NDEF_FOOT DETAIL,AT(,-10,,1604),USE(?unnamed:11)
         STRING(@t1),AT(7667,10,313,208),USE(LAI,,?LAI:2),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(865,427),USE(SYS_PARAKSTS),TRN,LEFT
         STRING('Pieòçmçjs'),AT(-3125,469),USE(?String149)
         STRING('Paraksts:'),AT(260,771,677,208),USE(?String49:5)
         STRING('Paraksts:'),AT(3958,771,677,208),USE(?String49:6)
         STRING('Datums:'),AT(260,1094,677,208),USE(?String249:5)
         STRING(@d06.),AT(1042,1094,677,208),USE(PAV:DATUMS,,?PAV:DATUMS:2),CENTER
         STRING('Datums:'),AT(3958,1094,677,208),USE(?String349:5)
         STRING('Z.v.'),AT(2813,1396,313,208),USE(?String49:7)
         STRING('Z.v.'),AT(6875,1406,313,208),USE(?String49:8)
         STRING('Izsniedza:'),AT(250,427,604,177),USE(?String49:4)
         STRING('Automaðînu saòçmu:_{33}'),AT(3958,469,3906,208),USE(?StringAM_SANEMU)
       END
NOM_NDEF_FOOT:1 DETAIL,AT(,-10,,1604),USE(?unnamed:10)
         STRING('Pieòçmçjs'),AT(-3125,469),USE(?String149:1)
         STRING('Paraksts:'),AT(260,771,677,208),USE(?String49:5:1)
         STRING('Paraksts:'),AT(3958,771,677,208),USE(?String49:6:1)
         STRING('Datums:'),AT(260,1094,677,208),USE(?String249:5:1)
         STRING(@d06.),AT(1042,1094,677,208),USE(PAV:DATUMS,,?PAV:DATUMS:3)
         STRING(@t1),AT(7656,0,313,208),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING('Datums:'),AT(3958,1094,677,208),USE(?String349:5:1)
         STRING('Z.v.'),AT(2813,1396,313,208),USE(?String49:7:1)
         STRING('Z.v.'),AT(6875,1406,313,208),USE(?String49:8:1)
         STRING('Nodeva:'),AT(260,438,500,177),USE(?String49:4:1)
         STRING(@s25),AT(792,438),USE(SYS_PARAKSTS,,?SYS_PARAKSTS:2),TRN,LEFT
         STRING('Pieòçmu:_{33}'),AT(3958,469,3906,208),USE(?StringAM_SANEMU:2:1)
       END
RPT_line DETAIL,AT(,,,0),USE(?unnamed:15)
         LINE,AT(260,0,7604,0),USE(?Line5:8),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11354,8000,52)
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
window WINDOW('Caption'),AT(,,260,100),GRAY
       END
  CODE                                            ! Begin processed code
!
!
! OPC   1.BAITS: 1-LÎGUMA-PASÛTÎJUMA NODOÐANAS AKTS
!       2.BAITS: 1-PIELIKT MEISTARUS
!       3.BAITS: 1-DRUKÂT SERVISS.TXT/SERVISS1.TXT
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  F:IDP = '' !PAZÎME,KA GROSAM BÛS JÂDRUKÂ TIKAI 1. LAPA
  IF ~PAV:REK_NR
     IF INSTRING(PAV:APM_K,'45') !GARANTIJA,RÛPNÎCAS GARANTIJA
        PAV:REK_NR=performgl(10)
     ELSE
        PAV:REK_NR=performgl(5)
     .
     IF RIUPDATE:PAVAD()
        KLUDA(24,'PAVAD(REK_NR)')
     .
  .
  IF CL_NR=1102 OR| !ADREM
  CL_NR=1464 OR|    !AUTO ÎLE
  CL_NR=1454 OR|    !SD AUTOCENTRS
  ACC_KODS_N=0      !ES
     pav_rek_nr='*'&CLIP(pav:U_NR)&'*'  !code39
     pav_rek_nr_end='*'&CLIP(pav:U_NR)&'/*'
  ELSIF CL_NR=1211 OR| !AUTOSTATUSS
     pav_rek_nr='*'&CLIP(pav:rek_nr)&'*'  !code39
     pav_rek_nr_end='*'&CLIP(pav:rek_nr)&'/*'
  .
  IF CL_NR=1102 OR| !ADREM
  CL_NR=1464        !AUTO ÎLE
     IF OPC[1]='1'
        KESKA = 'DARBA UZDEVUMA Nr. '&CLIP(PAV:REK_NR)&' NODOÐANAS AKTS'
     ELSE
        KESKA = 'DARBA UZDEVUMS Nr. '&PAV:REK_NR
     .
     SKALOT='A/M skalot ?'
  ELSE
     IF OPC[1]='1'
        KESKA = 'LÎGUMA-PASÛTÎJUMA Nr. '&CLIP(PAV:REK_NR)&' NODOÐANAS AKTS'
     ELSE
        KESKA = 'LÎGUMS-PASÛTÎJUMS Nr. '&PAV:REK_NR
     .
     SKALOT='Logu ðíidrumu papildinât ?'
  .
  GETMYBANK('')
  GL_ADRESE ='Jur.adr: '&GL:ADRESE
  SYS_ADRESE='Serv.adr: '&SYS:ADRESE
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
  IF PAV:MAK_NR
     MAKSATAJS='Maksâtâjs:  '&CLIP(GETPAR_K(PAV:MAK_NR,0,2))&' '&GETPAR_K(PAV:MAK_NR,0,8)
  .
  PAR_NOS_P=GETPAR_K(PAV:PAR_NR,2,3) !MAKSÂTÂJS IZKUSTINA
  PAR_FIN_NR=GETPAR_K(PAV:PAR_NR,0,8)
  PAR_ADRESE=PAR:ADRESE  
  OBJ_ADRESE=GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
!  DAT=TODAY()
  LAI=CLOCK()
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
  IF AUTO::Used = 0
    CheckOpen(AUTO,1)
  END
  AUTO::Used += 1
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  IF AUTOTEX::Used = 0
    CheckOpen(AUTOTEX,1)
  END
  AUTOTEX::Used += 1
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(APK:RECORD)
  BIND(AUT:RECORD)
  FilesOpened = True
  AUT_AUTO=GETAUTO(PAV:VED_NR,6)     !MARKA&GADS&POZICIONÇJAM AUTO
  AUT_VADITAJS=GETAUTO(PAV:VED_NR,3)
  CLEAR(APK:RECORD)
  APK:PAV_NR=PAV:U_NR
  GET(AUTOAPK,APK:PAV_KEY)           !POZICIONÇJAM AUTOAPK PÇC P/Z U_NR
!  plkst=APK:PLKST
  OPEN(PROGRESSWINDOW)
  OPEN(report)
  SETTARGET(REPORT)
  IMAGE(100,200,2083,521,'USER.BMP')
  SETTARGET(REPORT,?CAR_HEAD)
  IMAGE(2292,1042,3200,1700,'CAR.BMP')
  report{Prop:Preview} = PrintPreviewImage
  IF CL_NR=1479 !SANTEKO
    PRINT(RPT:HEADER:1)
  ELSE
    PRINT(RPT:HEADER)
  .
  IF OPC[1]='0'    !LÎGUMS-PASÛTÎJUMS
     IF ~(CL_NR=1479) !SANTEKO
        PRINT(RPT:CAR_HEAD)
     .
     !PRINT(RPT:darbi_HEAD)
      PRINT(RPT:SUD_HEAD)
     CLEAR(APX:RECORD)
     APX:PAV_NR=PAV:U_NR
     SET(APX:NR_KEY,APX:NR_KEY)
     RPT_NPK_#=0   !14/06/2012
     RPT_NPK=0 !14/06/2012
     LOOP
        NEXT(AUTOTEX)
        IF ERROR() OR ~(APX:PAV_NR=PAV:U_NR) THEN BREAK.
        IF APX:PAZIME='K' !KLIENTA SÛDZÎBA
           APK_DARBI=APX:TEKSTS
           RPT_NPK+=1
           RPT_NPK_#+=1  !14/06/2012
           PRINT(RPT:DARBI)
           PRINT(RPT:RPT_LINE)
        .
     .
     PRINT(RPT:Pdarbi_HEAD)
     CLEAR(APX:RECORD)
     APX:PAV_NR=PAV:U_NR
     SET(APX:NR_KEY,APX:NR_KEY)
     RPT_NPK=0 !14/06/2012
     LOOP
        NEXT(AUTOTEX)
        IF ERROR() OR ~(APX:PAV_NR=PAV:U_NR) THEN BREAK.
        IF APX:PAZIME='P' !PAPILDUS DARBI
           APK_DARBI=APX:TEKSTS
           RPT_NPK+=1
           RPT_NPK_#+=1  !14/06/2012
           PRINT(RPT:DARBI)
           PRINT(RPT:RPT_LINE)
        .
     .
     !Elya 14/06/2012
     ?String38:5{PROP:TEXT}='Papildus veicamie darbi'
     PRINT(RPT:Pdarbi_HEAD)
     !Elya 14/06/2012
     IF OPC[3]='1'
        ANSIFILENAME='SERVISS1.TXT'
        IF DOS_CONT(ANSIFILENAME,2)
           checkopen(OUTFILEANSI)
           SET(OUTFILEANSI)
           LOOP
              NEXT(OUTFILEANSI)
              IF ERROR() THEN BREAK.
              SERVISS1#+=1
           .
        .
        close(OUTFILEANSI)
     .
     RPT_NPK=0 !14/06/2012
     LOOP
        RPT_NPK+=1
        RPT_NPK_#+=1  !14/06/2012
        !Elya IF RPT_NPK>20-SERVISS1# THEN BREAK.
        !14/06/2012IF RPT_NPK>14-SERVISS1# THEN BREAK.
        IF RPT_NPK_#>18-SERVISS1# THEN BREAK.
        APK_DARBI=''
        PRINT(RPT:DARBI)
        PRINT(RPT:RPT_LINE)
     .
     PRINT(RPT:DARBI_FOOT)
     IF OPC[3]='1'
        ANSIFILENAME='SERVISS1.TXT'
        IF DOS_CONT(ANSIFILENAME,2)
           checkopen(OUTFILEANSI)
           SET(OUTFILEANSI)
           LOOP
              NEXT(OUTFILEANSI)
              IF ERROR() THEN BREAK.
              LINE=OUTA:LINE
              PRINT(RPT:FROM_FILE)
           .
        .
        close(OUTFILEANSI)
     .
     IF CL_NR=1479 !SANTEKO
        PRINT(RPT:DARBI_FOOT1:1)
     ELSE
        PRINT(RPT:DARBI_FOOT1)
     .
  .
!--------------------------------------------
     DALAS_DARBI='Uzstâdîtâs detaïas'
     PRINT(RPT:NOM_HEAD)
     RPT_NPK=0
     CLEAR(NOL:RECORD)
     NOL:U_NR=PAV:U_NR
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
        RINDAS#+=1
        RPT_NPK+=1
        nomenkL=GETNOM_K(NOL:NOMENKLAT,2,ret)
        NOM_NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
        IF ~(NOM:TIPS='A')  !~DARBI
           summa1=CALCSUM(16,2)
           CENA=SUMMA1/NOL:DAUDZUMS
           VUT=''
           KOMATS=''
           MERV=NOM:MERVIEN
           PRINT(RPT:NOMEN)
           SUMMAK+=SUMMA1
           SUMMAPK+=SUMMA1
        .
     .
     PRINT(RPT:NOM_FOOTK)
!--------------------------------------------
     DALAS_DARBI='Paveiktie darbi'
     PRINT(RPT:NOM_HEAD)
     RPT_NPK=0
     SUMMAK=0
     CLEAR(NOL:RECORD)
     NOL:U_NR=PAV:U_NR
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
        RINDAS#+=1
        RPT_NPK+=1
        I#=GETNOM_K(NOL:NOMENKLAT,2,2)
        IF NOM:TIPS='A'  !DARBI
           nomenkL=GETNOM_K(NOL:NOMENKLAT,2,ret)
           summa1=CALCSUM(16,2)
           CENA=SUMMA1/NOL:DAUDZUMS
           MERV=NOM:MERVIEN
           VUT=''
           KOMATS=''
           IF OPC[2]='1' !SERVISA VÇSTURE
              CLEAR(APD:RECORD)
              APD:PAV_NR=NOL:U_NR
              SET(APD:NR_KEY,APD:NR_KEY)
              LOOP
                 NEXT(AUTODARBI)
                 IF ERROR() OR ~(APD:PAV_NR=NOL:U_NR) THEN BREAK.
                 IF APD:NOMENKLAT=NOL:NOMENKLAT
                    VUT=CLIP(VUT)&CLIP(KOMATS)&GETKADRI(APD:ID,0,9)
                    KOMATS=','
                 .
              .
           .
           IF VUT
              NOM_NOSAUKUMS=CLIP(VUT)&'-'&GETNOM_K(NOL:NOMENKLAT,2,2)
           ELSE
              NOM_NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
           .
           PRINT(RPT:NOMEN)
           SUMMAK+=SUMMA1
           SUMMAPK+=SUMMA1
        .
     .
!************************* ATLAIDE ***********
     IF PAV:SUMMA_A <= 0
        PRINT(RPT:NOM_FOOTPK)
     ELSE
        PRINT(RPT:NOM_FOOTPKA)
     .
!--------------------------------------------
!  ELSE         !NODOÐANAS AKTS
!     DALAS_DARBI='Uzstâdîtâs detaïas / Paveiktie darbi'
!     PRINT(RPT:NOM_HEAD)
!     RPT_NPK=0
!     SUMMAK=0
!     CLEAR(NOL:RECORD)
!     NOL:U_NR=PAV:U_NR
!     SET(NOL:NR_KEY,NOL:NR_KEY)
!     LOOP
!        NEXT(NOLIK)
!        IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
!        RINDAS#+=1
!        RPT_NPK+=1
!        NOM_NOSAUKUMS=GETNOM_K(NOL:NOMENKLAT,2,2)
!        summa1=CALCSUM(16,2)
!        CENA=SUMMA1/NOL:DAUDZUMS
!        VUT=''
!        KOMATS=''
!        PRINT(RPT:NOMEN)
!       SUMMAK+=SUMMA1
!     .
!     PRINT(RPT:NOM_FOOTK)
!  .
  PRINT(RPT:NDEF_HEAD)
!--------------------------------------------
  RPT_NPK  = 0
  CLEAR(APX:RECORD)
  APX:PAV_NR=PAV:U_NR
  SET(APX:NR_KEY,APX:NR_KEY)
  LOOP
     NEXT(AUTOTEX)
     IF ERROR() OR ~(APX:PAV_NR=PAV:U_NR) THEN BREAK.
     IF APX:PAZIME='N' !NENOVÇRSTIE DEFEKTI
        APK_NEDARBI=APX:TEKSTS
        RPT_NPK+=1
        PRINT(RPT:NDEFEKTI)
     .
  .
!--------------------------------------------
  IF OPC[1]='0'    !LÎGUMS-PASÛTÎJUMS
     PRINT(RPT:NDEF_FOOT)
  ELSE         !NODOÐANAS AKTS
     IF CL_NR=1356 !ATLAS M
        ?STRINGAM_SANEMU{PROP:TEXT}='Apmaksai piekrîtu:_________________________________'
     .
     PRINT(RPT:NDEF_FOOT)
     IF OPC[3]='1'
        ANSIFILENAME='SERVISS.TXT'
        IF DOS_CONT(ANSIFILENAME,2)
           checkopen(OUTFILEANSI)
           SET(OUTFILEANSI)
           LOOP
              NEXT(OUTFILEANSI)
              IF ERROR() THEN BREAK.
              LINE=OUTA:LINE
              PRINT(RPT:FROM_FILE)
           .
        .
        close(OUTFILEANSI)
     .
     IF CL_NR=1479 !SANTEKO
        PRINT(RPT:NOM_NDEF_FOOT:1)
     ELSE
        PRINT(RPT:NOM_NDEF_FOOT)
     .
  .
  ENDPAGE(report)
  CLOSE(PROGRESSWINDOW)
  pr:skaits=0
  PR:LAPA:LIDZ=1
  RP
  loop J#=1 to PR:SKAITS
     report{Prop:FlushPreview} = True
     IF ~(J#=PR:SKAITS)
        loop I#= 1 to RECORDS(PrintPreviewQueue1)
          GET(PrintPreviewQueue1,I#)
          PrintPreviewImage=PrintPreviewImage1
          add(PrintPreviewQueue)
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
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    AUTOTEX::Used -= 1
    IF AUTOTEX::Used = 0 THEN CLOSE(AUTOTEX).
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
GETPAMAT             FUNCTION (AMONR)             ! Declare Procedure
  CODE                                            ! Begin processed code
!
!  POZICIONÇ P/L
!  ATGRIEÞ LONG TRUE, JA ATRASTS
!
!

 IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
 END
 PAMAT::Used += 1
 CLEAR(PAM:RECORD)
 PAM:U_NR=AMONR
 GET(PAMAT,PAM:NR_KEY)
 IF ERROR() THEN RET#=1.
 PAMAT::Used -= 1
 IF PAMAT::Used = 0
    CLOSE(PAMAT)
 .
 EXECUTE RET#+1
    RETURN(FALSE)
    RETURN(TRUE)
 .
CHECKKOPS            PROCEDURE (NOM_NOMENKLAT,REQ,BUILDMAS) ! Declare Procedure
F_DATUMS   LONG
F_D_K      string(2)

SAV::KOPS:Record         LIKE(KOPS:Record)
Auto::Attempts           LONG,AUTO
Auto::Save:KOPS:U_NR     LIKE(KOPS:U_NR)
LocalResponse            LONG
SAV_NOLIKNAME            LIKE(NOLIKNAME)

FIFO    QUEUE,PRE(F)
KEY         STRING(11)
DATUMS      LONG
DOK_SENR    string(14)
D_K         string(2)
NOL_NR      BYTE
DAUDZUMS    DECIMAL(11,3)
SUMMA       DECIMAL(11,2)
        .
  CODE                                            ! Begin processed code
!
! ÒEM VÇRÂ MUITU,AKCÎZI UN CITAS, JA TÂDAS IR DEFINÇTAS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111
!
! NOM_NOMENKLAT -KURAI VISS JÂSARÇÍINA
! REQ       JA REQ=0-UZBÛVÇT KOPS:NOMENKLAT,NEPÂRRÇÍINAM
!              REQ=1, PÂRRÇÍINAM JA KAUT KAS MAINÎTS-ANALIZÇ JAU IZSAUCOT 24.05.2011
!              REQ=1,2-PIESPIEDU PÂRRÇÍINS NO GADA SÂKUMA
! BUILDMAS         1-UZBÛVÇT KOPS:: GLOBALTABULU
!

  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1

  IF NOM_NOMENKLAT='POZICIONÇTS' !POZICIONÇTS KOPS:RAKSTS,TIEK SAUKTS NO UPDATE_NOL_KOPS VAI ATSKAITÇM
  ELSE                           !IR POIZICIONÇTS NOM_K,NAV KOPS:
     CLEAR(KOPS:RECORD)
     KOPS:NOMENKLAT=NOM_NOMENKLAT
     GET(NOL_KOPS,KOPS:NOM_key)
!     IF ERROR() THEN STOP(NOM_NOMENKLAT&REQ&ERROR()).
     IF ERROR()
!        IF REQ=1     !JA PÂRBÛVÇ TIKAI MAINÎTOS,JAUNUS NEBÛVÇ
!           DO PROCEDURERETURN
!        .
        KOPS:NOMENKLAT=NOM_NOMENKLAT
        KOPS:KATALOGA_NR=NOM:KATALOGA_NR
        KOPS:NOS_S=NOM:NOS_S
        CLEAR(KOPS:STATUSS)
        DO AUTONUMBER
     .
  .
  IF REQ=0 THEN DO PROCEDURERETURN. !NEPÂRRÇÍINÂT
!  IF REQ=1                          !PÂRRÇÍINÂT, JA KAS MAINÎTS
!     IRMAINITS#=FALSE
!     LOOP I#= 1 TO NOL_SK
!        LOOP M#= 1 TO 12
!           IF KOPS:STATUSS[M#,I#]<2 !NAV OK. ÐAJÂ NOLIKTAVÂ
!              IRMAINITS#=TRUE
!              BREAK
!           .
!        .
!        IF IRMAINITS#=TRUE THEN BREAK.
!        IF I#=NOL_SK THEN DO PROCEDURERETURN.
!     .
!  .

!  STOP('CH:'&KOPS:NOMENKLAT)
!**************** BÛVÇJAM FIFO TABULAS VISAM FG:*****************
  LOOP I#= 1 TO NOL_SK
     CLOSE(NOLIK)
     NOLIKNAME='NOLIK'&FORMAT(I#,@N02)
     CHECKOpen(NOLIK,1)
     CLOSE(PAVAD)
     PAVADNAME='PAVAD'&FORMAT(I#,@N02)
     CHECKOpen(PAVAD,1)
     CLEAR(NOL:RECORD)
     NOL:NOMENKLAT=KOPS:NOMENKLAT
     SET(NOL:NOM_KEY,NOL:NOM_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:NOMENKLAT=KOPS:NOMENKLAT) THEN BREAK.
        IF NOL:RS='1' THEN CYCLE.                                   !1-NEAPSTIPRINÂTIE . ''- APSTIPRINÂTIE
        CASE NOL:D_K
        OF 'D'
           IF NOL:U_NR=1                    !SALDO
              F_D_K='A'
              F_DATUMS=NOL:DATUMS
              DO ADDFIFO
           ELSE
              IF INRANGE(NOL:PAR_NR,1,25)                !IEKÐÇJA PÂRVIETOÐANA
                 F_D_K='DI'
                 F_DATUMS=DATE(MONTH(NOL:DATUMS),1,YEAR(NOL:DATUMS))
                 DO ADDFIFO
              ELSIF INRANGE(NOL:PAR_NR,26,50)            !RAÞOÐANA
                 F_D_K='DR'
                 F_DATUMS=DATE(MONTH(NOL:DATUMS),1,YEAR(NOL:DATUMS))
                 DO ADDFIFO
              ELSE                                       !NOPIRKTS
                 F_D_K='D '
                 F_DATUMS=NOL:DATUMS
                 DO ADDFIFO
              .
           .
        OF 'K'
           IF INRANGE(NOL:PAR_NR,1,25)                   !IEKÐÇJÂ PÂRVIETOÐANA
              F_D_K='KI'
              F_DATUMS=DATE(MONTH(NOL:DATUMS),1,YEAR(NOL:DATUMS))
              DO ADDFIFO
           ELSIF INRANGE(NOL:PAR_NR,26,50)               !RAÞOÐANA
              F_D_K='KR'
              F_DATUMS=DATE(MONTH(NOL:DATUMS),1,YEAR(NOL:DATUMS))
              DO ADDFIFO
           ELSE                                          !PÂRDOTS
              F_D_K='K '
              IF NOL:DAUDZUMS<0                          !MUMS IR ATGRIEZUÐI PRECI
                 F_DATUMS=NOL:DATUMS
              ELSE                                       
                 F_DATUMS=DATE(MONTH(NOL:DATUMS),1,YEAR(NOL:DATUMS))
              .
              DO ADDFIFO
           .
        .
     .
     CLOSE(NOLIK)
     CLOSE(PAVAD)
     LOOP M#= 1 TO 12
        KOPS:STATUSS[M#,I#]=2       !VISS OK. ÐAJÂ NOLIKTAVÂ
     .
  .
  IF RIUPDATE:NOL_KOPS()
     KLUDA(24,'NOL_KOPS: '&KOPS:NOMENKLAT)
  .

!************************** RAKSTAM FIFO NO TABULÂM****************
  GET(NOL_FIFO,0)
  CLEAR(FIFO:RECORD)
  FIFO:U_NR=KOPS:U_NR
  SET(FIFO:NR_KEY,FIFO:NR_KEY)
  LOOP
     NEXT(NOL_FIFO)
     IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR) THEN BREAK.
!     STOP('DZÇÐU '&KOPS:NOMENKLAT&' '&KOPS:U_NR&' '&FIFO:U_NR&' '&FIFO:D_K&' '&FIFO:SUMMA)
     IF RIDELETE:NOL_FIFO()
!!     DELETE(NOL_FIFO)
!!     IF ERROR()
        KLUDA(26,'NOL_FIFO '&ERROR())
     .
  .
  GET(FIFO,0)
  CLEAR(FIFO:RECORD)
  LOOP R#=1 TO RECORDS(FIFO)
     GET(FIFO,R#)
     FIFO:U_NR    =KOPS:U_NR
     FIFO:D_K     =F:D_K
     FIFO:DATUMS  =F:DATUMS
     FIFO:NOL_NR  =F:NOL_NR
     FIFO:DAUDZUMS=F:DAUDZUMS
     FIFO:SUMMA   =F:SUMMA
     ADD(NOL_FIFO)
     IF ERROR()
        KLUDA(0,'Kïûda ADD NOL_FIFO : '&CLIP(KOPS:NOMENKLAT)&' '&ERROR())
        GLOBALRESPONSE=REQUESTCANCELLED
        BREAK
     .
  .
  DO PROCEDURERETURN

!----------------------------------------------------------------------------------------------------------------
PROCEDURERETURN     ROUTINE
  FREE(FIFO)
  IF BUILDMAS
     DO BUILD_MAS
  .
  NOL_FIFO::USED-=1
     IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
  IF NOLIK::USED        !TIEK SAUKTS NO NOLIK
     CLOSE(NOLIK)
     NOLIKNAME=SAV_NOLIKNAME
     CHECKOPEN(NOLIK,1)
  .
  RETURN

!----------------------------------------------------------------------------------------------------------------
BUILD_MAS  ROUTINE
  CLEAR(KOPS::A_DAUDZUMS)
  CLEAR(KOPS::A_SUMMA)
  CLEAR(KOPS::D_DAUDZUMS)
  CLEAR(KOPS::D_SUMMA)
  CLEAR(KOPS::DI_DAUDZUMS)
  CLEAR(KOPS::K_DAUDZUMS)
  CLEAR(KOPS::K_SUMMA)
  CLEAR(KOPS::KI_DAUDZUMS)
  CLEAR(KOPS::KR_DAUDZUMS)
  CLEAR(KOPS::KR_SUMMA)
  CLEAR(FIFO:RECORD)
!  KOREKCIJA#=12-MONTH(DB_B_DAT) !FG KOREKCIJA
  FIFO:U_NR=KOPS:U_NR
  SET(FIFO:NR_KEY,FIFO:NR_KEY)
  LOOP
     NEXT(NOL_FIFO)
     IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR) THEN BREAK.
!     IF FIFO:DATUMS<S_DAT !MAZÂKS PAR -12 MÇN NO B_DAT
!        M#=1              !SKAITAM KLÂT PIE PIRMÂ
!     ELSE
!        M#=MONTH(FIFO:DATUMS)+KOREKCIJA# !FG KOREKCIJA
!        IF M#>12
!           STOP('MENESIS='&M#)
!           M#=12
!        .
!     .
     IF YEAR(FIFO:DATUMS)<DB_GADS
        M#=1
     ELSE
        M#=MONTH(FIFO:DATUMS)+DB_FGK !FG KOREKCIJA
     .
     CASE FIFO:D_K
     OF 'A'   !ATLIKUMS
        KOPS::A_DAUDZUMS[FIFO:NOL_NR] += FIFO:DAUDZUMS
        KOPS::A_SUMMA[FIFO:NOL_NR] += FIFO:SUMMA
     OF 'D'
     OROF 'DR'
        KOPS::D_DAUDZUMS[M#,FIFO:NOL_NR] += FIFO:DAUDZUMS
        KOPS::D_SUMMA[M#,FIFO:NOL_NR] += FIFO:SUMMA
     OF 'DI'
        KOPS::DI_DAUDZUMS[M#,FIFO:NOL_NR] += FIFO:DAUDZUMS
     OF 'K'
        KOPS::K_DAUDZUMS[M#,FIFO:NOL_NR] += FIFO:DAUDZUMS
        KOPS::K_SUMMA[M#,FIFO:NOL_NR] += FIFO:SUMMA
     OF 'KI'
        KOPS::KI_DAUDZUMS[M#,FIFO:NOL_NR] += FIFO:DAUDZUMS
     OF 'KR'  !RAÞOÐANA
        KOPS::KR_DAUDZUMS[M#,FIFO:NOL_NR] += FIFO:DAUDZUMS
        KOPS::KR_SUMMA[M#,FIFO:NOL_NR] += FIFO:SUMMA
     .
  .

!----------------------------------------------------------------------------------------------------------------
ADDFIFO        ROUTINE
  IF NOL:DAUDZUMS<0 AND NOL:D_K='D' ! NOM ATGRIEZTA
     J#=GETPAVADZ(NOL:U_NR)
     IF PAV:PAMAT[1:4]='PZ::' !NORÂDÎTA P/Z, NO KURAS TIEK ATGRIEZTS
        LOOP J# = 1 TO RECORDS(FIFO)
           GET(FIFO,J#)
           IF F:DOK_SENR=PAV:PAMAT[5:18] AND F:D_K='D'
              F:SUMMA   +=CALCSUM(15,2) - NOL:MUITA - NOL:AKCIZE -NOL:CITAS   !-------------------------------------
              F:DAUDZUMS+=NOL:DAUDZUMS
              PUT(FIFO)
              EXIT
           .
        .
     .
  .
  F:KEY=CLIP(I#)&F_D_K&F_DATUMS
  GET(FIFO,F:KEY)
  IF ERROR() OR (NOL:DAUDZUMS<0 AND NOL:D_K='D') !TÂ PATI NOM ATGRIEZTA TAJÂ PAÐÂ DIENÂ
     J#=GETPAVADZ(NOL:U_NR)
     F:NOL_NR  =I#
     F:D_K     =F_D_K
     F:DATUMS  =F_DATUMS
     F:DOK_SENR=PAV:DOK_SENR
     F:SUMMA   =CALCSUM(15,2)
     IF F:SUMMA>0
        F:SUMMA=CALCSUM(15,2) + NOL:MUITA + NOL:AKCIZE +NOL:CITAS   !-------------------------------------
     ELSE
        F:SUMMA=CALCSUM(15,2) - NOL:MUITA - NOL:AKCIZE -NOL:CITAS   !-------------------------------------
     .
     F:DAUDZUMS=NOL:DAUDZUMS
     ADD(FIFO)
     SORT(FIFO,F:KEY)
  ELSE
     F:SUMMA   +=CALCSUM(15,2) + NOL:MUITA + NOL:AKCIZE +NOL:CITAS   !-------------------------------------
     F:DAUDZUMS+=NOL:DAUDZUMS
     PUT(FIFO)
  .

!---------------------------------------------------------------
Autonumber     ROUTINE
  SAV::kops:Record = kops:Record
  Auto::Attempts = 0
  LOOP
    SET(KOPS:NR_KEY)
    PREVIOUS(NOL_KOPS)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:KOPS:U_NR = 1
    ELSE
      Auto::Save:KOPS:U_NR = KOPS:U_NR + 1
    END
    KOPS:Record = SAV::KOPS:Record
    KOPS:U_NR = Auto::Save:KOPS:U_NR
    SAV::KOPS:Record = KOPS:Record
    ADD(NOL_KOPS)
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

