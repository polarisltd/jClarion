                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_VSAOIIN_2009       PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
RPT_GADS             DECIMAL(4)
GADST                DECIMAL(4)
MENESIS              STRING(10)
NPK                  DECIMAL(3)
VARUZV               STRING(30)
OBJEKTS              DECIMAL(9,2)
OBJSUM               DECIMAL(9,2)
SAVE_RECORD          LIKE(ALG:RECORD)
save_position        STRING(250)
SAV_YYYYMM           LIKE(ALG:YYYYMM)
NODOKLIS             DECIMAL(9,2)
RISK                 DECIMAL(9,2)
IETIIN               DECIMAL(9,2)
OBJEKTS_K            DECIMAL(9,2)
NODOKLIS_K           DECIMAL(9,2)
IETIIN_K             DECIMAL(9,2)
RISK_K               DECIMAL(9,2)
OBJEKTS_P            DECIMAL(9,2)
NODOKLIS_P           DECIMAL(9,2)
IETIIN_P             DECIMAL(9,2)
RISK_P               DECIMAL(9,2)
CTRL                 DECIMAL(10,2),DIM(6)
ALG_SOC_V            LIKE(ALG:SOC_V)
VECUMS               BYTE
DAV                  STRING(1)
IEM_DATUMS           LONG
STSK                 USHORT
CAL_STUNDAS          USHORT

SS                   STRING(2)
TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

KOPA_IZMAKSAT        DECIMAL(12,2)
YYYYMM               LONG
M0                   DECIMAL(10,2)
M1                   DECIMAL(10,2)
M2                   DECIMAL(10,2)
M3                   DECIMAL(10,2)
M4                   DECIMAL(10,2)
MM                   DECIMAL(10,2)
SOC_V                STRING(1)        !TÂPAT KÂ KADROS
SOC_VX               STRING(5)
SOC_TEKSTS1          STRING(80)
SOC_TEKSTS2          STRING(80)

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

I_TABLE           QUEUE,PRE(I)
KEY                  STRING(7)
ID                   USHORT
SOC_V                BYTE
SOC_V_OLD            BYTE,DIM(2)
UL                   BYTE
INI                  STRING(5)
DIEN                 DECIMAL(10,2)
APRSA                DECIMAL(10,2)
IETIIN               DECIMAL(10,2)
DAV                  STRING(1)
TARIFS               DECIMAL(5,2)
INV_P                STRING(1)
IEM_DATUMS           LONG
STSK                 USHORT
STATUSS              STRING(1)
                  END

SUM1                STRING(15)
SUM2                STRING(15)
SUM3                STRING(15)

ATLAISTS            BYTE
E                   STRING(1)
EE                  STRING(15)

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

report REPORT,AT(104,198,8000,10146),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,100,8000,104)
       END
RPT_HEAD DETAIL,AT(,,,2948),USE(?unnamed:2)
         STRING('3. pielikums'),AT(6042,52,781,156),USE(?String1)
         STRING(@s15),AT(3177,146,1073,208),USE(EE),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(2875,42,313,313),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
         STRING('Ministru Kabineta'),AT(6042,208,1458,156),USE(?String1:2)
         STRING('2008. gada 20. novembra'),AT(6042,365,1458,156),USE(?String1:3)
         STRING(@s25),AT(1875,521,2042,208),USE(gl:vid_nos),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('teritoriâlajai iestâdei'),AT(3948,521,1250,208),USE(?String3:2),FONT(,9,,,CHARSET:BALTIC)
         STRING('Noteikumiem Nr 942'),AT(6042,521,1458,156),USE(?String1:4)
         LINE,AT(2021,833,0,260),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(3177,833,0,260),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('Nodokïu maksâtâja kods'),AT(479,885,1500,208),USE(?String3:3),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s13),AT(2063,885,1094,208),USE(GL:REG_NR),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s6),AT(6969,1083,677,208),USE(GL:VID_LNR),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2031,1094,1146,0),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1667,1250,4323,260),USE(client,,?client:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(darba devçja nosaukums vai vârds un uzvârds)'),AT(2573,1510),USE(?String9),CENTER
         STRING('ZIÒOJUMS PAR VALSTS SOCIÂLÂS APDROÐINÂÐANAS OBLIGÂTAJÂM'),AT(1042,1719,5885,208),USE(?String9:3), |
             CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('IEMAKSÂM NO DARBA ÒÇMÇJU DARBA IENÂKUMIEM,'),AT(1042,1927,5885,208),USE(?String9:4), |
             CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('IEDZÎVOTÂJU IENÂKUMA NODOKLI UN UZÒÇMÇJDARBÎBAS RISKA VALSTS NODEVU PÂRSKATA MÇN' &|
             'ESÎ'),AT(375,2135,7188,208),USE(?String9:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N04),AT(3354,2365),USE(rpt_gads),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(3719,2354,469,208),USE(?String15),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(4188,2354,885,208),USE(MENESIS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2604,2583,417,0),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(3021,2583,0,260),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(2031,833,1146,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2604,2583,0,260),USE(?Line36),COLOR(COLOR:Black)
         STRING('Darba ienâkumu izmaksas datums'),AT(760,2635),USE(?String59)
         STRING(@N2),AT(2719,2615),USE(SYS:NOKL_DC),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2615,2833,417,0),USE(?Line34:2),COLOR(COLOR:Black)
         STRING('Valsts ieòçmumu dienesta'),AT(302,521,1625,208),USE(?String3),FONT(,9,,,CHARSET:BALTIC)
       END
SOC_VX_HEAD DETAIL,AT(10,,7990,198)
         STRING('Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, invaliditâtes apdr' &|
             'oðinâðanai, maternitâtes un slimîbas apdroðinâðanai'),AT(729,3594,7188,156),USE(?String62), |
             FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,3854,208,0),USE(?Line40:4),COLOR(COLOR:Black)
         STRING('Darba òçmçji, kuri ir pakïauti valsts pensiju apdroðinâðanai, maternitâtes un sl' &|
             'imîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes'),AT(729,3958,7188,156), |
             USE(?String62:3)
         LINE,AT(417,4010,208,0),USE(?Line40:9),COLOR(COLOR:Black)
         LINE,AT(625,4010,0,260),USE(?Line36:12),COLOR(COLOR:Black)
         STRING(@s1),AT(458,4052,156,208),USE(SOC_VX[5]),CENTER
         LINE,AT(417,4010,0,260),USE(?Line36:11),COLOR(COLOR:Black)
         STRING('gadîjumiem darbâ un arodslimîbâm (darba òçmçji, kuri ir sasnieguði vecumu, kas d' &|
             'od tiesîbas saòemt valsts vecuma pensiju; darba òçmçji,'),AT(729,4115,7188,156),USE(?String62:2), |
             FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,4271,208,0),USE(?Line40:10),COLOR(COLOR:Black)
         STRING('kuriem ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'),AT(729,4271,7188,156), |
             USE(?String62:4)
         STRING('un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (dar' &|
             'ba òçmçji, kuri ir I vai II grupas invalîdi)'),AT(729,3750,7188,156),USE(?String63)
         STRING('Darba òçmçji, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ un kuriem izmaksâ' &|
             'ti neizmaksâtie darba ienâkumi'),AT(729,4479,6979,156),USE(?String64)
         LINE,AT(417,4479,208,0),USE(?Line40:5),COLOR(COLOR:Black)
         LINE,AT(625,4479,0,260),USE(?Line36:8),COLOR(COLOR:Black)
         STRING(@s1),AT(469,4531,156,208),USE(SOC_VX[3]),CENTER
         LINE,AT(417,4479,0,260),USE(?Line36:7),COLOR(COLOR:Black)
         STRING('par darba piespiedu kavçjumu vai kuriem saskaòâ ar tiesas spriedumu izmaksâti la' &|
             'ikus neizmaksâtie darba ienâkumi'),AT(729,4635,7083,156),USE(?String65)
         LINE,AT(417,4740,208,0),USE(?Line40:6),COLOR(COLOR:Black)
         STRING('Personas, no kuru darba ienâkumiem ieturçts iedzîvotâju ienâkuma nodoklis, pamat' &|
             'ojoties uz iepriekðçjâm darba vai dienesta attiecîbâm'),AT(729,4896,7135,156),USE(?String66), |
             FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(469,4844,156,208),USE(SOC_VX[4]),CENTER
         LINE,AT(625,4792,0,260),USE(?Line36:10),COLOR(COLOR:Black)
         LINE,AT(417,4792,0,260),USE(?Line36:9),COLOR(COLOR:Black)
         LINE,AT(417,4792,208,0),USE(?Line40:7),COLOR(COLOR:Black)
         LINE,AT(417,5052,208,0),USE(?Line40:8),COLOR(COLOR:Black)
         STRING('Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'),AT(729,3333,,156),USE(?String61), |
             FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(469,3333,156,208),USE(SOC_VX[1],,?SOC_VX_1:2),CENTER
         LINE,AT(417,3542,208,0),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(417,3594,208,0),USE(?Line40:3),COLOR(COLOR:Black)
         LINE,AT(625,3594,0,260),USE(?Line36:5),COLOR(COLOR:Black)
         STRING(@s1),AT(469,3646,156,208),USE(SOC_VX[2]),CENTER
         LINE,AT(417,3594,0,260),USE(?Line36:6),COLOR(COLOR:Black)
         LINE,AT(625,3281,0,260),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(417,3281,0,260),USE(?Line36:4),COLOR(COLOR:Black)
         LINE,AT(417,3281,208,0),USE(?Line40:2),COLOR(COLOR:Black)
       END
SOCV1_HEAD DETAIL,AT(,,,229),USE(?unnamed:3)
         STRING('1-Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'),AT(729,52,,156),USE(?String61:2), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV2_HEAD DETAIL,AT(,,,229),USE(?unnamed:4)
         STRING('2-DN, izdienas pensijas saòçmçji vai invalîdi- valsts speciâlâs pensijas saòçmçj' &|
             'i'),AT(729,42,4156,156),USE(?String62:6),FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV3_HEAD DETAIL,AT(,,,229),USE(?unnamed:9)
         STRING('3-Valsts vecuma pensija, pieðíirta vecuma pensija ar atvieglotiem noteikumiem'),AT(719,31,4198,156), |
             USE(?String62:7),FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
SOCV4_HEAD DETAIL,AT(,,,229),USE(?unnamed:8)
         STRING('4-Personas, kuras nav obligâti sociâli apdroðinâmas'),AT(750,21,3073,156),USE(?String66:3), |
             FONT(,8,,FONT:underline,CHARSET:BALTIC)
       END
PAGE_HEAD DETAIL,AT(,,,938),USE(?unnamed)
         LINE,AT(156,52,7708,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,104,260,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. kods'),AT(521,104,698,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai reì. Nr'),AT(521,313,719,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâk.'),AT(3354,313,490,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ls'),AT(3333,521,510,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iem.'),AT(3927,521,490,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ienâk.'),AT(4479,521,438,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaks.'),AT(5000,521,521,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sk.'),AT(7542,521,302,208),USE(?String18:39),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodeva'),AT(6323,573,573,156),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(6938,573,573,156),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('riska v.'),AT(6323,417,573,156),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veikðanas'),AT(6938,417,573,156),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('v.'),AT(6135,365,156,208),USE(?String18:38),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('st.'),AT(7552,302,302,208),USE(?String18:139),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('10'),AT(7010,771,427,156),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('1'),AT(208,781,260,156),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(521,781,781,156),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1354,771,1927,156),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(3365,771,458,156),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(4010,781,323,156),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(4521,771,365,156),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(5135,771,354,156),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(5656,771,354,156),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(6479,781,313,156),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('VSAO'),AT(5052,313,448,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('IIN,  Ls'),AT(5552,302,510,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iemaksu'),AT(6938,260,573,156),USE(?String18:132),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darbîbas'),AT(6323,260,583,156),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Prec.'),AT(5021,104,438,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ietur.'),AT(5573,104,490,208),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzòçm.'),AT(6323,104,573,156),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Obligâto'),AT(6938,104,573,156),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nostr'),AT(7552,104,302,208),USE(?String18:239),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('DA'),AT(6135,198,156,208),USE(?String18:37),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6917,52,0,938),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(6125,52,0,938),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(5521,52,0,938),USE(?Line6:8),COLOR(COLOR:Black)
         LINE,AT(4979,42,0,938),USE(?Line6:7),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,938),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7521,63,0,938),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(6302,42,0,938),USE(?Line6:10),COLOR(COLOR:Black)
         STRING('darba'),AT(4479,302,427,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Prec.'),AT(4479,104,427,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4438,31,0,938),USE(?Line6:6),COLOR(COLOR:Black)
         STRING('VSAO'),AT(3969,313,438,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprçí.'),AT(3938,104,500,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3906,52,0,938),USE(?Line6:5),COLOR(COLOR:Black)
         STRING('Darba'),AT(3323,104,531,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3281,52,0,938),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('Vârds, uzvârds'),AT(1354,104,1927,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,52,0,938),USE(?Line6:3),COLOR(COLOR:Black)
         LINE,AT(469,52,0,938),USE(?Line6:2),COLOR(COLOR:Black)
         LINE,AT(156,52,0,938),USE(?Line6),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,260),USE(?unnamed:7)
         LINE,AT(156,0,0,270),USE(?Line15),COLOR(COLOR:Black)
         STRING(@N3),AT(198,52),USE(NPK),RIGHT
         LINE,AT(469,10,0,270),USE(?Line15:2),COLOR(COLOR:Black)
         STRING(@p######-#####p),AT(500,52),USE(KAD:PERSKOD),LEFT
         LINE,AT(1302,10,0,270),USE(?Line15:3),COLOR(COLOR:Black)
         STRING(@s30),AT(1333,52),USE(varuzv),LEFT
         LINE,AT(3281,10,0,270),USE(?Line15:4),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3302,52),USE(OBJEKTS),RIGHT
         LINE,AT(3906,10,0,270),USE(?Line15:5),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3938,52,479,188),USE(NODOKLIS),RIGHT
         LINE,AT(4438,10,0,270),USE(?Line15:6),COLOR(COLOR:Black)
         LINE,AT(4979,10,0,270),USE(?Line15:7),COLOR(COLOR:Black)
         LINE,AT(5521,10,0,270),USE(?Line15:17),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5542,52),USE(IETIIN),RIGHT
         STRING(@s1),AT(6135,52),USE(DAV),TRN,CENTER
         STRING(@N-_9.2),AT(6333,42),USE(RISK),RIGHT
         STRING(@D06.B),AT(6938,42,573,177),USE(IEM_DATUMS),RIGHT
         STRING(@N3B),AT(7552,42,240,177),USE(STSK),TRN,RIGHT
         LINE,AT(6917,10,0,270),USE(?Line15:20),COLOR(COLOR:Black)
         LINE,AT(6125,10,0,270),USE(?Line15:19),COLOR(COLOR:Black)
         LINE,AT(7521,10,0,270),USE(?Line15:25),COLOR(COLOR:Black)
         LINE,AT(6302,10,0,270),USE(?Line15:24),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line15:8),COLOR(COLOR:Black)
         LINE,AT(156,0,7708,0),USE(?Line5:4),COLOR(COLOR:Black)
       END
SOCV_FOOT DETAIL,AT(,,,323),USE(?unnamed:6)
         LINE,AT(469,0,0,270),USE(?Line15:10),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,270),USE(?Line15:9),COLOR(COLOR:Black)
         STRING('KOPÂ  :'),AT(521,52),USE(?String46),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,0,0,270),USE(?Line15:11),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,270),USE(?Line15:12),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3302,52),USE(OBJEKTS_K),RIGHT
         LINE,AT(3906,0,0,270),USE(?Line15:13),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3938,52,479,188),USE(NODOKLIS_K),RIGHT
         LINE,AT(4438,0,0,270),USE(?Line15:14),COLOR(COLOR:Black)
         LINE,AT(4979,0,0,270),USE(?Line15:15),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,270),USE(?Line15:18),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5542,52),USE(IETIIN_k),RIGHT
         STRING(@N-_9.2),AT(6333,52),USE(RISK_k),RIGHT
         STRING('X'),AT(7073,52,354,208),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6917,0,0,270),USE(?Line15:22),COLOR(COLOR:Black)
         LINE,AT(6125,0,0,270),USE(?Line15:21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line15:16),COLOR(COLOR:Black)
         LINE,AT(7521,10,0,270),USE(?Line15:26),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,270),USE(?Line15:23),COLOR(COLOR:Black)
         LINE,AT(156,260,7708,0),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(156,0,7708,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,896),USE(?unnamed:5)
         LINE,AT(469,0,0,270),USE(?Line115:10),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,270),USE(?Line115:9),COLOR(COLOR:Black)
         STRING('PAVISAM :'),AT(521,52),USE(?String46:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,0,0,270),USE(?Line115:11),COLOR(COLOR:Black)
         LINE,AT(3281,0,0,270),USE(?Line115:12),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(3302,52),USE(OBJEKTS_P),RIGHT
         LINE,AT(3906,0,0,270),USE(?Line115:13),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3938,52,479,188),USE(NODOKLIS_P),RIGHT
         LINE,AT(4438,0,0,270),USE(?Line115:14),COLOR(COLOR:Black)
         LINE,AT(4979,0,0,270),USE(?Line115:15),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,270),USE(?Line115:18),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5542,63),USE(IETIIN_P),RIGHT
         STRING(@N-_9.2),AT(6333,52),USE(RISK_P),RIGHT
         STRING('X'),AT(7073,52,406,208),USE(?String318:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6906,0,0,270),USE(?Line115:22),COLOR(COLOR:Black)
         LINE,AT(6125,0,0,270),USE(?Line115:21),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,270),USE(?Line115:2),COLOR(COLOR:Black)
         LINE,AT(7521,0,0,270),USE(?Line115:3),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,270),USE(?Line115:16),COLOR(COLOR:Black)
         LINE,AT(156,260,7708,0),USE(?Line35:3),COLOR(COLOR:Black)
         STRING('Darba attiecîbu veidi (DA v.): 1-VSAOI veic pats DD,deklarçtâs iemaksas, A-VSAOI' &|
             ' veic PA, C-VSAOI veic cits DD, D-VSAOI veic cits DD,DÒ-tiesas ceïâ '),AT(115,292),USE(?String121:2), |
             TRN
         STRING('atjaunots darbâ, I-Personas, no kuru darba ienâkumiem ieturçts IIN pie iepriekðç' &|
             'jâ DD, M-DÒ, kura darba ienâkumi sasnieguði VSAOI maksimumu, '),AT(115,438),USE(?String121:3), |
             TRN
         STRING('R-DÒ strâdâ un dzîvo ârpus LR, T-VSAOI veic DD.DÒ-tiesas ceïâ vai ar lçmumu atja' &|
             'unots darbâ.'),AT(115,583),USE(?String121),TRN
         STRING('Nostrâdâto stundu skaits tiek deklarçts tikai tiem darbiniekiem, kam darba ienâk' &|
             'umi mazâki par minimâlo mçneðalgu.'),AT(115,740),USE(?String121:4),TRN
         LINE,AT(156,0,7708,0),USE(?Line315:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(100,10320,8000,823),USE(?RPT:PAGE_FOOTER)
         STRING('Z. V.'),AT(990,250,365,208),USE(?String55),CENTER
         STRING(@N4),AT(5240,563),USE(gadsT),RIGHT
         STRING('. gada "____"_{20}'),AT(5656,563),USE(?String54),LEFT
         STRING(@s25),AT(3198,563),USE(SYS:TEL),CENTER
         STRING(@s25),AT(4375,198,1979,208),USE(sys:amats1,,?sys:amats1:2),RIGHT
         STRING('Izpildîtâjs :_{20}'),AT(2229,188),USE(?String49),LEFT
         STRING(@s25),AT(2646,385),USE(sys:paraksts2),CENTER(1)
         STRING('Tâlruòa numurs:'),AT(2208,563),USE(?String49:3),LEFT
         LINE,AT(156,0,7708,0),USE(?Line315:2),COLOR(COLOR:Black)
         STRING('_{20}'),AT(6406,188),USE(?String49:2),LEFT
         STRING(@s25),AT(6094,396),USE(sys:paraksts1),CENTER(1)
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

SOC_V_window WINDOW('Filtrs pçc SA statusa'),AT(,,301,150),GRAY
       OPTION,AT(7,5,290,124),USE(SOC_V),BOXED
         RADIO('1-DN, kuri ir apdroðinâmi atbilstoði visiem valsts sociâlâs apdroðinâðanas veidi' &|
             'em'),AT(10,13),USE(?SOC_V:Radio1),VALUE('1')
         RADIO('2-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (DN, I,II gr.Inv.)'),AT(10,33), |
             USE(?SOC_V:Radio2),VALUE('2')
         RADIO('5-DN, kuri pakïauti valsts pensiju apdroðinâðanai utt. (vecuma pens.)'),AT(11,55),USE(?SOC_V:Radio5), |
             VALUE('5')
         RADIO('3-DN, kuri saskaòâ ar tiesas spriedumu atjaunoti darbâ utt.'),AT(10,78),USE(?SOC_V:Radio3), |
             VALUE('3')
         RADIO('4-Personas, no kuru darba ienâkumiem ieturçts IIN, pamat. un iepr. darba attiecî' &|
             'bâm'),AT(10,98),USE(?SOC_V:Radio4),VALUE('4')
       END
       STRING('(DBF tiks bûvçts no jauna)'),AT(13,22),USE(?StringDBF1)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(13,43),USE(?StringDBF2)
       STRING('(no 2003.g)'),AT(247,55,39,10),FONT(,,0FFH,),USE(?String6)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(14,65),USE(?StringDBF5)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(14,88),USE(?StringDBF3)
       STRING('(DBF tiks papildinâts, lai viss bûtu vienâ)'),AT(15,108),USE(?StringDBF4)
       BUTTON('&OK'),AT(223,132,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(261,132,36,14),USE(?CancelButton)
     END

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

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  IF F:XML
     E='E'
     EE='(ddz_p.xml)'
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
     XMLFILENAME=DISKS&'DDZ_P.XML'
     CHECKOPEN(OUTFILEXML,1)
     CLOSE(OUTFILEXML)
     OPEN(OUTFILEXML,18)
     IF ERROR()
        KLUDA(1,XMLFILENAME)
     ELSE                   !Hedera sâkums-pabeigsim, kad bûs saskaitîtas summas
        EMPTY(OUTFILEXML)
        F:XML_OK#=TRUE
!        XML:LINE='<?xml version="1.0" encoding="utf-8" ?>'
!        XML:LINE='<?xml version="1.0" ?>'
        XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
        ADD(OUTFILEXML)
        XML:LINE=' DokDDZv1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
        ADD(OUTFILEXML)
        IF ALP:YYYYMM > TODAY() THEN KLUDA(27,'taksâcijas periods'). !vienkârði kontrolei
        XML:LINE=' TaksGads>'&YEAR(ALP:YYYYMM)&'</TaksGads>'
        ADD(OUTFILEXML)
        XML:LINE=' TaksMenesis>'&MONTH(ALP:YYYYMM)&'</TaksMenesis>'
        ADD(OUTFILEXML)
        IF ~GL:REG_NR THEN KLUDA(87,'Jûsu NM Nr').              !vienkârði kontrolei
        XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
        ADD(OUTFILEXML)
        TEX:DUF=CLIENT
        DO CONVERT_TEX:DUF
        XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
        ADD(OUTFILEXML)
        XML:LINE=' IzmaksasDatums>'&SYS:NOKL_DC&'</IzmaksasDatums>'
        ADD(OUTFILEXML)
!        XML:LINE=' AtbildPers>'&INIGEN(SYS:PARAKSTS1,LEN(CLIP(SYS:PARAKSTS1)),1)&'</AtbildPers>'
        XML:LINE=' AtbildPers>'&CLIP(SYS:PARAKSTS1)&'</AtbildPers>'
        ADD(OUTFILEXML)
        XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
        ADD(OUTFILEXML)
        XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
        ADD(OUTFILEXML)
        XML:LINE=' DatumsAizp>'&FORMAT(TODAY(),@D010-)&'T00:00:00</DatumsAizp>'
        ADD(OUTFILEXML)
     .
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
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
  ProgressWindow{Prop:Text} = '3.pielikums MKN Nr 942'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      YYYYMM=ALP:YYYYMM
      ALG:YYYYMM=DATE(MONTH(YYYYMM)+10,1,YEAR(YYYYMM)-1)  !LAI DABÛTU 2 MÇNEÐUS ATPAKAÏ
!      STOP(FORMAT(ALG:YYYYMM,@D6))
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
      RPT_GADS =YEAR(YYYYMM)
      GADST=YEAR(TODAY())
      MENESIS=MENVAR(YYYYMM,2,1)
      CAL_STUNDAS=CALCSTUNDAS(YYYYMM,0,0,0,1) !KALENDÂRS
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
!        IF YYYYMM < DATE(1,1,2003)
!           PRINT(RPT:RPT_HEAD)
!        ELSE
           PRINT(RPT:RPT_HEAD)
!        .
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PAZFPIS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'3.pielikums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2008.g.20.nove4mbra'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 942'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Valsts ieòçmumu dienesta '&GL:VID_NOS&' teritoriâlâ iestâde'
        ADD(OUTFILEANSI)
        OUTA:LINE='Nodokïu maksâtâja kods '&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='ZIÒOJUMS PAR VALSTS SOCIÂLÂS APDROÐINÂÐANAS OBLIGÂTAJÂM'
        ADD(OUTFILEANSI)
        OUTA:LINE='IEMAKSÂM NO DARBA ÒÇMÇJU DARBA IENÂKUMIEM,'
        ADD(OUTFILEANSI)
        OUTA:LINE='IEDZÎVOTÂJU IENÂKUMA NODOKLI UN UZÒÇMÇJDARBÎBAS RISKA VALSTS NODEVU PÂRSKATA MÇNESÎ'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=RPT_GADS&'. gada '&MENESIS
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Darba ienâkumu izmaksas datums '&SYS:NOKL_DC
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY
        IF INRANGE(GETKADRI(ALG:ID,0,7),DATE(MONTH(YYYYMM)+10,1,YEAR(YYYYMM)-1),YYYYMM-1) !ATLAISTS PAG V AIZPAG MÇN.
           ALG_SOC_V=4           !lîdz ar to nav VSA
           DAV='I'               !varbût...
        ELSIF INRANGE(ALG:SOC_V,1,4)
           ALG_SOC_V=ALG:SOC_V   !VAR IZMÇTÂT PA DAÞÂDÂM SADAÏÂM, JA MAINÂS
           DAV='1'
        ELSE
           KLUDA(0,'Neatïauts VSA statuss='&ALG:SOC_V&' '&CLIP(GETKADRI(ALG:ID,0,1))&' '&FORMAT(alg:YYYYMM,@D14.))
           DO PROCEDURERETURN
        .
        IF ~(F:NODALA AND ~(alg:NODALA=F:NODALA)) and ~(id AND ~(alg:id=id))
!******************************TEKOÐAIS MÇNESIS*****************************
           IF YYYYMM=alg:YYYYMM
              M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
              M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
              M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
              M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
              M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
              OBJEKTS=M0+M1+M2+M3+M4
              IF SYS:PZ_NR                            !IR DEFINÇTS OBJEKTS (2007.g. Ls23800)
                 DO SUMSOCOBJ                         !SASKAITAM OBLIGÂTO IEMAKSU OBJEKTU NO GADA SÂKUMA
                 IF ~SYS:PZ_NR THEN SYS:PZ_NR=23800.  !OBJEKTS 2007.g.
                 IF SYS:PZ_NR-(OBJSUM+OBJEKTS)<0      !MKN 193
                    KLUDA(0,'Ir sasniegts obligâto iemaksu objekta MAX apmçrs '&CLIP(GETKADRI(ALG:ID,0,1)),,1)
                    OBJEKTS=SYS:PZ_NR-OBJSUM
                    IF OBJEKTS<0 THEN OBJEKTS=0.
                 .
              .
              IF GETKADRI(ALG:ID,0,10)='R' !REZIDENTS
                 VECUMS=GETKADRI(ALG:ID,0,15)
                 IF VECUMS<15
                    OBJEKTS=0  !TÂ ARÎ VAJAG-DATI
                 .
              .
              nodoklis   =  ROUND(objekts*alg:pr37/100,.01)+ROUND(objekts*alg:pr1/100,.01)
              I:KEY=ALG_SOC_V&BAND(ALG:BAITS,00000001b)&ALG:ID !Uzòçmuma lîgums
              GET(I_TABLE,I:KEY)  !Rakstam visu pçc algu saraksta fakta
              IF ERROR()
                 I:ID    =ALG:ID
                 I:SOC_V =ALG_SOC_V
                 I:SOC_V_OLD[2] =ALG:SOC_V
                 I:SOC_V_OLD[1] =0
                 I:UL     =BAND(ALG:BAITS,00000001b)
                 I:INI    =ALG:INI
                 I:DIEN   =objekts
                 I:APRSA  =NODOKLIS
                 I:IETIIN =0
                 I:DAV    =DAV
                 I:INV_P  =ALG:INV_P
                 I:TARIFS =alg:pr37+alg:pr1
                 I:STATUSS=ALG:STATUSS
!                 I:IEM_DATUMS=ALG:IIN_DATUMS   !TIKAI ULîgumam
!                 IF ALG:N_STUNDAS<CAL_STUNDAS
                 IF OBJEKTS<180 AND ALG:YYYYMM>=DATE(1,1,2009) !MAZÂK PAR MINIMÂLO
                    I:STSK   =ALG:N_STUNDAS
                 ELSE
                    I:STSK   =0
                 .
                 ADD(I_TABLE)
                 SORT(I_TABLE,I:KEY)
              ELSE  !ADD VARÇJA BÛT DOTS ARÎ IEPRIEKÐÇJÂ MÇNESÎ
                 I:DIEN  +=objekts
                 I:APRSA +=NODOKLIS
                 I:SOC_V =ALG_SOC_V
                 I:SOC_V_OLD[2] =ALG:SOC_V
!                 I:UL     =BAND(ALG:BAITS,00000001b) 09.06.2011
                 I:DAV    =DAV
                 I:INV_P  =ALG:INV_P
                 I:TARIFS =alg:pr37+alg:pr1
                 I:STATUSS=ALG:STATUSS
!                 I:IEM_DATUMS=ALG:IIN_DATUMS   !TIKAI ULîgumam
                 IF ALG:N_STUNDAS<CAL_STUNDAS
                    I:STSK   =ALG:N_STUNDAS
                 ELSE
                    I:STSK   =0
                 .
                 PUT(I_TABLE)
              .
           .
!******************IETURÇTS IIN TEKOÐAJÂ MÇNESÎ PAR VECÂKU SARAKSTU****************************
           IF YYYYMM=DATE(MONTH(alg:IIN_DATUMS),1,YEAR(ALG:IIN_DATUMS))
              I:KEY=ALG_SOC_V&BAND(ALG:BAITS,00000001b)&ALG:ID
              GET(I_TABLE,I:KEY)
              IF ERROR()
                 I:ID    =ALG:ID
                 I:SOC_V =ALG_SOC_V
                 I:SOC_V_OLD[1] =ALG:SOC_V
                 I:SOC_V_OLD[2] =0
                 I:UL    =BAND(ALG:BAITS,00000001b)
                 I:INI   =ALG:INI
                 I:DIEN  =0
                 I:APRSA =0
                 I:INV_P =ALG:INV_P
                 I:IETIIN=ALG:IIN
                 I:DAV    =DAV
                 I:TARIFS=alg:pr37+alg:pr1
                 I:STATUSS=ALG:STATUSS
                 ADD(I_TABLE)
                 SORT(I_TABLE,I:KEY)
              ELSE
                 I:IETIIN+=ALG:IIN
                 I:SOC_V_OLD[1] =ALG:SOC_V
                 PUT(I_TABLE)
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
     GET(I_TABLE,0)
     LOOP I#= 1 TO RECORDS(I_TABLE)
        GET(I_TABLE,I#)
        IF I:UL AND I:SOC_V=4 THEN CYCLE. !ATLAISTS U.lîgumdarbinieks-visi
        objekts    =  I:DIEN
        nodoklis   =  I:APRSA
        IetIIN     =  I:IETIIN
        DAV        =  I:DAV
        IF INSTRING(I:STATUSS,'1234')
           RISK    =  SYS:D_KO
        ELSE
           RISK    =  0
        .
        IEM_DATUMS =  I:IEM_DATUMS
        STSK       =  I:STSK
        IF I:SOC_V_OLD[1] AND ~(I:SOC_V_OLD[1] =I:SOC_V_OLD[2]) AND I:SOC_V=1 !IR MAINÎJIES SOC V STATUSS
           RISK=0
        .
        IF I:SOC_V =  4 THEN RISK=0.    !ATLAISTS JAU IEPRIEKÐÇJÂ MÇNESÎ VAI NAV SOCIÂLI APDROÐINÂMS
        IF I:UL                         !U.Lîgumdarbinieks
!           IETIIN  =  0  vairâk nevajag 16.07.2009.
           IETIIN  =  0 !09.06.2011.
           RISK    =  0
        .
        objekts_P  += OBJEKTS
        nodoklis_P += NODOKLIS
        IetIIN_P   += IetIIN
        RISK_P     += RISK
!        CTRL[I:SOC_V]  += OBJEKTS+NODOKLIS+IetIIN+RISK
        CTRL[I:SOC_V]  += 1 !lai drukâtu draòía valdes locekïus arî bez algas
     .
     IF F:XML_OK#=TRUE    !HEDERA BEIGAS
        XML:LINE=' Ienakumi>'&CLIP(objekts_P)&'</Ienakumi>'
        ADD(OUTFILEXML)
        XML:LINE=' Iemaksas>'&CLIP(NODOKLIS_P)&'</Iemaksas>'
        ADD(OUTFILEXML)
!        XML:LINE=' PrecizetieIenakumi xsi:nil="true" />'
!        ADD(OUTFILEXML)
!        XML:LINE=' PrecizetasIemaksas xsi:nil="true" />'
!        ADD(OUTFILEXML)
        XML:LINE=' IetIedzNodoklis>'&CLIP(IetIIN_P)&'</IetIedzNodoklis>'
        ADD(OUTFILEXML)
        XML:LINE=' RiskaNod>'&CLIP(RISK_P)&'</RiskaNod>'
        ADD(OUTFILEXML)
     .

     SORT(I_TABLE,I:INI)
     LOOP SV#=1 TO 4  !4 SOC VEIDI
        SOC_V=SV#  !DB SECÎBA 2009 SAKRÎT
        objekts_K  = 0
        nodoklis_K = 0
        IetIIN_K   = 0
        RISK_k     = 0
        IF F:DBF = 'W'
           EXECUTE SV#
              PRINT(RPT:SOCV1_HEAD)
              PRINT(RPT:SOCV2_HEAD)
              PRINT(RPT:SOCV3_HEAD)
              PRINT(RPT:SOCV4_HEAD)
           .
        ELSE
           CASE SV#
           OF 1
              OUTA:LINE='1.Darba òçmçji, kuri apdroðinâmi atbilstoði visiem VSA veidiem'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 2
              OUTA:LINE='2.DN, izdienas pensijas saòçmçji vai invalîdi- valsts speciâlâs pensijas saòçmçji'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 3
              OUTA:LINE='3.Valsts vecuma pensija, pieðíirta vecuma pensija ar atvieglotiem noteikumiem'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           OF 4
              OUTA:LINE='4.Personas, kuras nav sociâli apdroðinâmas'
              ADD(OUTFILEANSI)
              OUTA:LINE=''
              ADD(OUTFILEANSI)
           .
        END

        IF ~CTRL[SOC_V] THEN CYCLE. !NAV RAKSTU PAR ÐO SOC_V.

        IF F:XML_OK#=TRUE   !VISU TABULU UN SADAÏAS RINDU SÂKUMS
           XML:LINE=' Tab'&CLIP(SV#)&'>'
           ADD(OUTFILEXML)
           XML:LINE=' Rs>'
           ADD(OUTFILEXML)
        .
        IF F:DBF = 'W'
           PRINT(RPT:PAGE_HEAD)
        ELSIF F:DBF = 'E'
           OUTA:LINE=''
           ADD(OUTFILEANSI)
           OUTA:LINE='Npk'&CHR(9)&'Personas kods'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Darba'&CHR(9)&'Aprçíin.'&CHR(9)&|
           'Prec.'&CHR(9)&'Prec.'&CHR(9)&'Ietur.'&CHR(9)&'Uzòçmçj-'&CHR(9)&'Obligâto'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'vai reì.Nr.'&CHR(9)&CHR(9)&'ienâkumi,'&CHR(9)&'soc.apdr.'&CHR(9)&'darba'&CHR(9)&|
           'soc.'&CHR(9)&'IIN, Ls'&CHR(9)&'darbîbas'&CHR(9)&'iemaksu'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'Ls'&CHR(9)&'iemaksas'&CHR(9)&'ienâk.'&CHR(9)&'apdr.'&CHR(9)&CHR(9)&|
           'riska v.'&CHR(9)&'veikðanas'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'nodeva'&CHR(9)&'datums'
           ADD(OUTFILEANSI)
        ELSE
           OUTA:LINE=''
           ADD(OUTFILEANSI)
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai reì.Nr'&CHR(9)&'Vârds, uzvârds'&CHR(9)&'Darba ienâkumi Ls'&CHR(9)&|
           'Aprçíin.soc.apdr. iemaksas'&CHR(9)&'Prec.darba ienâk.'&CHR(9)&'Prec.soc. apdr.'&CHR(9)&'Ietur.IIN, Ls'&CHR(9)&|
           'Uzòçmçjdarbîbas riska v.nodeva'&CHR(9)&'Obligâto iemaksu veikðanas datums'
           ADD(OUTFILEANSI)
        .
        GET(I_TABLE,0)
        LOOP I#= 1 TO RECORDS(I_TABLE)
           GET(I_TABLE,I#)
           IF ~(I:SOC_V=SOC_V) THEN CYCLE.
           IF I:UL AND I:SOC_V=4 THEN CYCLE. !ATLAISTS U.lîgumdarbinieks-visi
           NPK+=1
           VARUZV     =  GETKADRI(I:ID,2,1)
           objekts    =  I:DIEN
           nodoklis   =  I:APRSA
           IetIIN     =  I:IETIIN
           DAV        =  I:DAV
           IF INSTRING(I:STATUSS,'1234')
              RISK    =  SYS:D_KO
           ELSE
              RISK    =  0
           .
           IEM_DATUMS =  I:IEM_DATUMS
           STSK       =  I:STSK
           IF I:SOC_V_OLD[1] AND ~(I:SOC_V_OLD[1] =I:SOC_V_OLD[2]) AND I:SOC_V=1 !IR MAINÎJIES SOC V STATUSS
              RISK=0
           .
           IF I:SOC_V =  4 THEN RISK=0.    !ATLAISTS JAU IEPRIEKÐÇJÂ MÇNESÎ
           IF I:UL                         !U.Lîgumdarbinieks
!              IETIIN  =  0  vairâk nevajag 16.07.2009.
              IETIIN  =  0 !09.06.2011
              RISK    =  0
           .
           objekts_K  += OBJEKTS
           nodoklis_K += NODOKLIS
           IetIIN_K   += IetIIN
           RISK_k     += RISK
           IF F:DBF = 'W'
              PRINT(RPT:DETAIL)
           ELSE
              OUTA:LINE=FORMAT(Npk,@N3)&CHR(9)&FORMAT(KAD:PERSKOD,@P######-#####P)&CHR(9)&VARUZV&CHR(9)&|
              LEFT(FORMAT(OBJEKTS,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS,@N9.2))&CHR(9)&CHR(9)&CHR(9)&|
              LEFT(FORMAT(IETIIN,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK,@N8.2))
              ADD(OUTFILEANSI)
           END
           IF F:XML_OK#=TRUE !SADAÏAS RINDA(S)
              XML:LINE='<R>'
              ADD(OUTFILEXML)
              XML:LINE=' Npk>'&CLIP(NPK)&'</Npk>'
              ADD(OUTFILEXML)
              XML:LINE=' PersonasKods>'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'</PersonasKods>'
              ADD(OUTFILEXML)
              XML:LINE=' VardsUzvards>'&CLIP(VARUZV)&'</VardsUzvards>'
              ADD(OUTFILEXML)
              !1-DN, kuri ir apdroðinâmi atbilstoði visiem VSA veidiem
              !2-DN, kuri pakïauti izdienas pensiju apdroðinâðanai utt.
              !3-DN, kuri pakïauti valsts vecuma pensiju apdroðinâðanai utt.
              !4-Personas, kuras nav obl.sociâli apdroðinâtas
              EXECUTE SOC_V
                 SS = 'DN'
                 SS = 'DP'
                 SS = 'DP'
                 SS = 'DN'
              .
              XML:LINE=' SamStat>'&SS&'</SamStat>'
              ADD(OUTFILEXML)
              XML:LINE=' Ienakumi>'&CLIP(objekts)&'</Ienakumi>'
              ADD(OUTFILEXML)
              XML:LINE=' Iemaksas>'&CLIP(nodoklis)&'</Iemaksas>'
              ADD(OUTFILEXML)
              XML:LINE=' PrecizetieIenakumi xsi:nil="true" />'
              ADD(OUTFILEXML)
              XML:LINE=' PrecizetasIemaksas xsi:nil="true" />'
              ADD(OUTFILEXML)
              XML:LINE=' IetIedzNodoklis>'&CLIP(IetIIN)&'</IetIedzNodoklis>'
              ADD(OUTFILEXML)
              XML:LINE=' DarbaVeids>'&CLIP(DAV)&'</DarbaVeids>' !DARBA ATTIECÎBU VEIDS...
              ADD(OUTFILEXML)
              IF RISK
                 XML:LINE=' RiskaNodPazime>1</RiskaNodPazime>'
              ELSE
                 XML:LINE=' RiskaNodPazime>0</RiskaNodPazime>'
              .
              ADD(OUTFILEXML)
              XML:LINE=' RiskaNod>'&CLIP(RISK)&'</RiskaNod>'
              ADD(OUTFILEXML)
              IF IEM_DATUMS !VAJAG TIKAI ULîgumam
                 XML:LINE=' IemaksuDatums>'&FORMAT(IEM_DATUMS,@D010-)&'T00:00:00</IemaksuDatums>'
                 ADD(OUTFILEXML)
              .
              XML:LINE=' Stundas>'&CLIP(STSK)&'</Stundas>'
              ADD(OUTFILEXML)
              XML:LINE='</R>'
              ADD(OUTFILEXML)
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:SOCV_FOOT)
        ELSE
           OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(OBJEKTS_K,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS_K,@N_9.2))&|
           CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(IETIIN_K,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK_k,@N_6.2))
           ADD(OUTFILEANSI)
           OUTA:LINE=''
           ADD(OUTFILEANSI)
        END
        IF F:XML_OK#=TRUE   !SADAÏAS RINDU BEIGAS UN KOPÂ,TABULAS BEIGAS
           XML:LINE='</Rs>'
           ADD(OUTFILEXML)
           XML:LINE=' Ienakumi>'&CLIP(objekts_K)&'</Ienakumi>'
           ADD(OUTFILEXML)
           XML:LINE=' Iemaksas>'&CLIP(nodoklis_K)&'</Iemaksas>'
           ADD(OUTFILEXML)
!           XML:LINE=' PrecizetieIenakumi xsi:nil="true" />'
!           ADD(OUTFILEXML)
!           XML:LINE=' PrecizetasIemaksas xsi:nil="true" />'
!           ADD(OUTFILEXML)
           XML:LINE=' IetIedzNodoklis>'&CLIP(IetIIN_K)&'</IetIedzNodoklis>'
           ADD(OUTFILEXML)
           XML:LINE=' RiskaNod>'&CLIP(RISK_K)&'</RiskaNod>'
           ADD(OUTFILEXML)
           XML:LINE='</Tab'&CLIP(SV#)&'>'
           ADD(OUTFILEXML)
        .
     .
     IF F:XML_OK#=TRUE   !DEKLARÂCIJAS BEIGAS
        XML:LINE='</DokDDZv1>'
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
           FILENAME2='A:\DDZ_P.XML'
           IF ~CopyFileA(XMLFILENAME,FILENAME2,0)
              KLUDA(3,XMLFILENAME&' uz '&FILENAME2)
           .
        .
     .
     IF F:DBF = 'W'
        PRINT(RPT:REP_FOOT)
!        SETTARGET(REPORT,?RPT:PAGE_FOOTER)
!        HIDE(?RPT:PAGE_FOOTER)
!        TARGET{PROP:HEIGHT}=0
        ENDPAGE(report)
     ELSE
        OUTA:LINE=CHR(9)&'PAVISAM:'&CHR(9)&CHR(9)&LEFT(FORMAT(OBJEKTS_P,@N_9.2))&CHR(9)&LEFT(FORMAT(NODOKLIS_P,@N_9.2))&|
        CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(IETIIN_P,@N_7.2))&CHR(9)&LEFT(FORMAT(RISK_P,@N_6.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpildîtâjs:___________________'
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlruòa numurs:'&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Vadîtâjs:___________________/'&SYS:PARAKSTS1&'/'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Z.V.'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&GADST&'. gada "___"___________________'
        ADD(OUTFILEANSI)
     END
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
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(I_TABLE)
  CLOSE(OUTFILEXML)
  IF F:DBF='E' THEN F:DBF='W'.
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% '
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
SUMSOCOBJ  ROUTINE
! SAVE_RECORD=ALG:RECORD
! save_position=POsition(Process:View)
 SAV_YYYYMM=ALG:YYYYMM
 OBJSUM = 0
 ALG:YYYYMM=DATE(1,1,YEAR(ALG:YYYYMM)) ! NO GADA SÂKUMA
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR (ALG:YYYYMM = SAV_YYYYMM) THEN BREAK.
    M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
    M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
    M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
    M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
    M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
    OBJSUM+=M0+M1+M2+M3+M4
 .
 SET(ALG:ID_KEY,ALG:ID_KEY)
! RESET(Process:View,SAVE_POSITION)
 NEXT(ALGAS)
! ALG:RECORD=SAVE_RECORD

A_DNKUS_2009         PROCEDURE                    ! Declare Procedure
NPK             LONG
DATUMS          LONG
PERSKODS        STRING(12)
VUT             STRING(22)
ZDAT            LONG
ZK              STRING(2)
E               STRING(1)

TEX:DUF         STRING(100)
XMLFILENAME     CSTRING(200),STATIC

OUTFILEXML      FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record             RECORD,PRE()
LINE                  STRING(256)
                   END
                END

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

!-----------------------------------------------------------------------------
report REPORT,AT(198,2136,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1938),USE(?unnamed:3)
         STRING('1. pielikums'),AT(6458,52,,156),USE(?String1),LEFT
         STRING('Ministru kabineta'),AT(6458,208,,156),USE(?String1:2),LEFT
         LINE,AT(781,1927,6510,0),USE(?Line3:17),COLOR(COLOR:Black)
         STRING('2008. gada 20. novembra'),AT(6458,365,,156),USE(?String1:3),LEFT
         STRING('noteikumiem Nr. 942'),AT(6458,521,,156),USE(?String1:4),LEFT
         STRING('Valsts ieòçmumu dienesta'),AT(781,625,1979,208),USE(?String5),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2813,625),USE(gl:VID_NOS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('teritoriâlajai iestâdei'),AT(4479,625,1250,208),USE(?String5:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maksâtâja kods'),AT(781,833,1979,208),USE(?String5:3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(2813,833),USE(GL:REG_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2240,1042,3906,260),USE(CLIENT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,1302,6510,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('(darba devçja nosaukums vai vârds un uzvârds)'),AT(1146,1354,5521,208),USE(?String1:5), |
             CENTER
         STRING('ZIÒAS PAR DARBA ÒÇMÇJIEM'),AT(2656,1615,2656,260),USE(?String9),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(ZDN.XML)'),AT(5354,1646),USE(?String104),TRN
         STRING(@D06.),AT(5948,1656,,156),USE(S_DAT),TRN
         STRING(@D06.),AT(6646,1656,,156),USE(B_DAT),TRN
         STRING('-'),AT(6552,1656,42,156),USE(?String106),TRN
       END
PAGE_HEAD DETAIL,AT(,,,396)
         LINE,AT(781,0,6510,0),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(1198,0,0,417),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(2552,0,0,417),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(4115,0,0,417),USE(?Line4:4),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,417),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,417),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,417),USE(?Line4:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(813,52,365,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods vai'),AT(1229,52,1302,156),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas dzimðanas dati'),AT(2583,52,1510,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(4146,52,1667,156),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums,'),AT(5865,52,885,156),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ziòu'),AT(6802,52,469,156),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('reìistrâcijas numurs'),AT(1229,208,1302,156),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ja nav personas koda)'),AT(2583,208,1510,156),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mçnesis, gads'),AT(5865,208,885,156),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6802,208,469,156),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,0,0,417),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(781,365,6510,0),USE(?Line3:2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,167)
         LINE,AT(781,-10,0,188),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_3),AT(885,10,,156),USE(NPK),RIGHT
         LINE,AT(1198,-10,0,188),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,188),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,188),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,188),USE(?Line4:12),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,188),USE(?Line4:13),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,188),USE(?Line4:14),COLOR(COLOR:Black)
         STRING(@S2),AT(6979,10,,156),USE(ZK),LEFT
         STRING(@s22),AT(4167,10,,156),USE(VUT)
         STRING(@D06.),AT(5990,10,,156),USE(ZDAT)
         STRING(@S12),AT(1396,10,,156),USE(PERSKODS)
       END
detail2 DETAIL,AT(,,,177)
         LINE,AT(781,-10,0,63),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,63),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,63),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,63),USE(?Line19:6),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(781,52,6510,0),USE(?Line3:3),COLOR(COLOR:Black)
       END
Zinu_Kodi_New DETAIL,AT(,,,5802),USE(?unnamed)
         LINE,AT(781,5417,6510,0),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(781,52,6510,0),USE(?Line3:51),COLOR(COLOR:Black)
         STRING('Npk'),AT(833,104,365,156),USE(?String11:109),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ziòu'),AT(1250,104,469,156),USE(?String11:108),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atðifrçjums'),AT(1771,104,5521,156),USE(?String11:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,63,0,5354),USE(?Line4:22),COLOR(COLOR:Black)
         STRING('apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, ka' &|
             'm ir pieðíirta izdienas'),AT(1771,3719,5510,156),USE(?String11:66),LEFT
         STRING('pensija vai valsts speciâlâ pensija)'),AT(1771,3865,5510,156),USE(?String11:107),LEFT
         STRING('gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas ' &|
             'dod tiesîbas saòemt valsts'),AT(1771,4333,5510,156),USE(?String11:65),LEFT
         STRING('vecuma pensiju; darba òçmçjam, kuram ir pieðíirta vecuma pensija ar atvieglotiem' &|
             ' noteikumiem)'),AT(1771,4479,5510,156),USE(?String11:64),LEFT
         LINE,AT(781,4635,6510,0),USE(?Line3:30),COLOR(COLOR:Black)
         STRING('12.'),AT(833,4656,260,156),USE(?String11:102),RIGHT
         LINE,AT(781,4021,6510,0),USE(?Line3:21),COLOR(COLOR:Black)
         STRING('11.'),AT(833,4042,260,156),USE(?String11:98),RIGHT
         STRING('33'),AT(1250,4042,469,156),USE(?String11:99),CENTER
         STRING('Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valst' &|
             's pensiju apdroðinâðanai,'),AT(1771,4042,5510,156),USE(?String11:100),LEFT
         STRING('maternitâtes un slimîbas apdroðinâðanai, vecâku apdroðinâðanai un sociâlajai apd' &|
             'roðinâðanai pret nelaimes'),AT(1771,4188,5510,156),USE(?String11:101),LEFT
         STRING('6.'),AT(833,2594,260,156),USE(?String11:87),RIGHT
         STRING('23'),AT(1250,2594,469,156),USE(?String11:88),CENTER
         STRING('Darba òçmçja statusa zaudçðana sakarâ ar darba devçja likvidâciju'),AT(1771,2594,5510,156), |
             USE(?String11:89),LEFT
         LINE,AT(781,2760,6510,0),USE(?Line3:27),COLOR(COLOR:Black)
         STRING('40'),AT(1250,4656,469,156),USE(?String11:103),CENTER
         STRING('Darba òçmçjam ir pieðíirts bçrna kopðanas atvaïinâjums'),AT(1771,4656,5510,156),USE(?String11:63), |
             LEFT
         STRING('Darba òçmçjam ir pieðíirts atvaïinâjums bez darba algas saglabâðanas'),AT(1771,5021,5510,156), |
             USE(?String11:62),LEFT
         LINE,AT(781,5000,6510,0),USE(?Line3:19),COLOR(COLOR:Black)
         STRING('15.'),AT(833,5260,260,156),USE(?String11:106),RIGHT
         STRING('8.'),AT(833,2938,260,156),USE(?String11:93),RIGHT
         STRING('25'),AT(1250,2938,469,156),USE(?String11:94),CENTER
         STRING('Darba òçmçja statusa zaudçðana citos gadîjumos'),AT(1771,2938,5510,156),USE(?String11:95), |
             LEFT
         LINE,AT(781,3094,6510,0),USE(?Line3:29),COLOR(COLOR:Black)
         STRING('personu atbrîvoðana no darba noteiktajos gadîjumos'),AT(1760,2417,5510,156),USE(?String11:11), |
             TRN,LEFT
         STRING('51'),AT(1250,5260,469,156),USE(?String11:60),CENTER
         STRING('Darba òçmçjam ir beidzies atvaïinâjums bez darba algas saglabâðanas'),AT(1771,5260,5510,156), |
             USE(?String11:15),TRN,LEFT
         STRING('Darba òçmçjam ir beidzies bçrna kopðanas atvaïinâjums'),AT(1771,4844,5510,156),USE(?String11:14), |
             TRN,LEFT
         STRING('41'),AT(1250,4844,469,156),USE(?String11:13),TRN,CENTER
         STRING('13.'),AT(833,4844,260,156),USE(?String11:12),TRN,RIGHT
         LINE,AT(781,5208,6510,0),USE(?Line3:18),COLOR(COLOR:Black)
         STRING('9.'),AT(833,3104,260,156),USE(?String11:96),RIGHT
         LINE,AT(781,4813,6510,0),USE(?Line3:20),COLOR(COLOR:Black)
         STRING('14.'),AT(833,5021,260,156),USE(?String11:104),RIGHT
         STRING('7.'),AT(833,2771,260,156),USE(?String11:90),RIGHT
         STRING('24'),AT(1250,2771,469,156),USE(?String11:91),CENTER
         STRING('Darba òçmçja statusa zaudçðana sakarâ ar nespçju veikt nolîgto darbu veselîbas s' &|
             'tâvokïa dçï'),AT(1771,2771,5510,156),USE(?String11:92),LEFT
         LINE,AT(781,2927,6510,0),USE(?Line3:28),COLOR(COLOR:Black)
         STRING('50'),AT(1250,5021,469,156),USE(?String11:105),CENTER
         STRING('kods'),AT(1250,260,469,156),USE(?String11:110),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,417,6510,0),USE(?Line3:31),COLOR(COLOR:Black)
         STRING('1'),AT(833,427,365,156),USE(?String11:111),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1250,427,469,156),USE(?String11:816),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1771,427,5521,156),USE(?String11:917),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,583,6510,0),USE(?Line3:32),COLOR(COLOR:Black)
         STRING('1.'),AT(833,594,260,156),USE(?String11:114),RIGHT
         STRING('11'),AT(1250,594,469,156),USE(?String11:113),CENTER
         STRING('Tâda darba òçmçja statusa iegûðana, kurð ir apdroðinâms atbilstoði visiem VSA ve' &|
             'idiem'),AT(1771,594,5510,156),USE(?String11:112),LEFT
         LINE,AT(781,750,6510,0),USE(?Line783:8),COLOR(COLOR:Black)
         STRING('2.'),AT(833,760,260,156),USE(?String11:252),RIGHT
         STRING('12'),AT(1250,760,469,156),USE(?String11:283),CENTER
         STRING('Tâda darba òçmçja statusa iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðan' &|
             'ai, invaliditâtes apdroðinâ-'),AT(1771,760,5510,156),USE(?String11:73),LEFT
         STRING('ðanai, maternitâtes un slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret' &|
             ' nelaimes gadîjumiem darbâ'),AT(1771,906,5510,156),USE(?String11:72),LEFT
         STRING('un arodslimîbâm (darba òçmçjam, kurð ir izdienas pensijas saòçmçjs vai III grupa' &|
             's invalîds - valsts speciâlâs'),AT(1771,1052,5510,156),USE(?String11:74),LEFT
         LINE,AT(781,1354,6510,0),USE(?Line3:24),COLOR(COLOR:Black)
         STRING('3.'),AT(833,1406,260,156),USE(?String11:75),RIGHT
         STRING('13'),AT(1250,1406,469,156),USE(?String11:76),CENTER
         STRING('Tâda darba òçmçja statusa iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðan' &|
             'ai, maternitâtes un slimîbas'),AT(1771,1406,5510,156),USE(?String11:77),LEFT
         STRING('apdroðinâðanai, vecâku apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes' &|
             ' gadîjumiem darbâ un'),AT(1771,1563,5510,156),USE(?String11:78),LEFT
         STRING('arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod tiesîbas saòemt ' &|
             'valsts vecuma pensiju;'),AT(1771,1719,5510,156),USE(?String131:78),LEFT
         STRING('darba òçmçjam, kuram ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'),AT(1771,1875,5510,156), |
             USE(?String11:79),LEFT
         LINE,AT(781,2031,6510,0),USE(?Line3:25),COLOR(COLOR:Black)
         STRING('21'),AT(1250,2063,469,156),USE(?String11:81),CENTER
         STRING('Darba òçmçja statusa zaudçðana, pamatojoties uz darba òçmçja uzteikumu'),AT(1771,2063,5510,156), |
             USE(?String11:71),LEFT
         STRING('pensijas saòçmçjs)'),AT(1771,1198,5510,156),USE(?String11:56),LEFT
         LINE,AT(781,2240,6510,0),USE(?Line3:23),COLOR(COLOR:Black)
         STRING('4.'),AT(833,2063,260,156),USE(?String11:80),RIGHT
         STRING('31'),AT(1250,3104,469,156),USE(?String11:84),CENTER
         STRING('Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir apdroðinâms vi' &|
             'siem valsts sociâlâs apdr-'),AT(1771,3104,5510,156),USE(?String11:70),LEFT
         STRING('oðinâðanas veidiem (darba òçmçjam, kam ir pârtrauktâ izdienas pensija vai valsts' &|
             ' speciâlâs pensijas izmaksa)'),AT(1771,3260,5510,156),USE(?String11:69),LEFT
         LINE,AT(781,3417,6510,0),USE(?Line3:22),COLOR(COLOR:Black)
         STRING('10.'),AT(833,3427,260,156),USE(?String11:97),RIGHT
         STRING('5.'),AT(833,2281,260,156),USE(?String11:82),RIGHT
         STRING('22'),AT(1250,2292,469,156),USE(?String11:85),CENTER
         STRING('Darba òçmçja statusa zaudçðana sakarâ ar darba òçmçja pârkâpumu normatîvajos akt' &|
             'os, kuros noteikta personu atbrîvoðana no darba noteiktajos gadîjumos'),AT(1771,2292,5510,156), |
             USE(?String11:86),LEFT
         LINE,AT(781,2573,6510,0),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('32'),AT(1250,3427,469,156),USE(?String11:83),CENTER
         STRING('Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valst' &|
             's pensiju apdroðinâðanai,'),AT(1771,3427,5510,156),USE(?String11:68),LEFT
         STRING('invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai, vecâku ap' &|
             'droðinâðanai un sociâlajai'),AT(1771,3573,5510,156),USE(?String11:67),LEFT
         LINE,AT(1198,63,0,5365),USE(?Line4:20),COLOR(COLOR:Black)
         LINE,AT(781,52,0,5365),USE(?Line4:21),COLOR(COLOR:Black)
         LINE,AT(1719,52,0,5365),USE(?Line4:19),COLOR(COLOR:Black)
       END
paraksti DETAIL,AT(,,,1760),USE(?unnamed:2)
         STRING('Izpildîtâjs'),AT(938,260,677,208),USE(?String23)
         STRING(@s25),AT(2271,500),USE(sys:paraksts2),LEFT
         LINE,AT(1615,469,3021,0),USE(?Line27),COLOR(COLOR:Black)
         STRING('Tâlruòa numurs:'),AT(4719,260,1042,208),USE(?String23:2)
         STRING(@s8),AT(6073,260),USE(sys:tel),LEFT
         STRING(@s25),AT(2813,1094),USE(sys:paraksts1),LEFT
         STRING(@s25),AT(52,833,1875,208),USE(Sys:amats1),RIGHT
         LINE,AT(1958,1042,3021,0),USE(?Line27:2),COLOR(COLOR:Black)
         STRING(@d06.),AT(1698,1313),USE(DATUMS),LEFT
         STRING('Datums'),AT(938,1313,677,208),USE(?String23:4)
         STRING('Z.v.'),AT(938,1563,677,208),USE(?String23:5)
       END
       FOOTER,AT(198,11150,8000,52)
         LINE,AT(781,0,6510,0),USE(?Line3:4),COLOR(COLOR:Black)
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

  IF F:XML
     E='E'
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
     XMLFILENAME=DISKS&'ZDN.XML'
     CHECKOPEN(OUTFILEXML,1)
     CLOSE(OUTFILEXML)
     OPEN(OUTFILEXML,18)
     IF ERROR()
        KLUDA(1,XMLFILENAME)
     ELSE                   !Hederis & vienîgâ TAB sâkums
        EMPTY(OUTFILEXML)
        F:XML_OK#=TRUE
!        XML:LINE='<?xml version="1.0" encoding="utf-8" ?>'
!        XML:LINE='<?xml version="1.0" ?>'
        XML:LINE='<?xml version="1.0" encoding="windows-1257" ?>'
        ADD(OUTFILEXML)
        XML:LINE=' DokZDNv1 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
        ADD(OUTFILEXML)
        IF ~GL:REG_NR THEN KLUDA(87,'Jûsu NM Nr').              !vienkârði kontrolei
        XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'             !bez LV
        ADD(OUTFILEXML)
        TEX:DUF=CLIENT
        DO CONVERT_TEX:DUF
        XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
        ADD(OUTFILEXML)
        IF ~SYS:PARAKSTS1 THEN KLUDA(87,'Vadîtâjs').
        XML:LINE=' Vaditajs>'&CLIP(SYS:PARAKSTS1)&'</Vaditajs>'
        ADD(OUTFILEXML)
        IF ~SYS:PARAKSTS2 THEN KLUDA(87,'Izpildîtâjs').
        XML:LINE=' Izpilditajs>'&CLIP(SYS:PARAKSTS2)&'</Izpilditajs>'
        ADD(OUTFILEXML)
        XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
        ADD(OUTFILEXML)
        XML:LINE=' DatumsAizp>'&FORMAT(TODAY(),@D010-)&'T00:00:00</DatumsAizp>'
        ADD(OUTFILEXML)
        XML:LINE=' Tab>'
        ADD(OUTFILEXML)
        XML:LINE=' Rs>'
        ADD(OUTFILEXML)
     .
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1

  BIND(KAD:RECORD)
  BIND('ID',ID)
  BIND('F:NODALA',F:NODALA)
  BIND('F:IDP',F:IDP)
  DATUMS=TODAY()

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ziòas par DN'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(KAD:INI_KEY)
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
      IF F:DBF = 'W'
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:PAGE_HEAD)
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('DNKUS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'1.pielikums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2000.g. 14.nov.'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 397'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Valsts ieòçmumu dienesta'&CHR(9)&GL:VID_NOS&CHR(9)&'teritoriâlâ iestâde'
        ADD(OUTFILEANSI)
        OUTA:LINE='Nodokïu maksâtâja kods'&CHR(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='    ZIÒAS PAR DARBA ÒÇMÇJIEM'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF = 'E' !2 LINES
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai'&CHR(9)&'Personas dzimðanas dati'&CHR(9)&'Vârds, uzvârds'&CHR(9)&|
           'Datums'&CHR(9)&'Ziòu'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'reìistrâcijas numurs'&CHR(9)&'(ja nav personas koda)'&CHR(9)&CHR(9)&'mçnesis,gads'&CHR(9)&'kods'
           ADD(OUTFILEANSI)
        ELSE !WORDAM 1 RINDÂ
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai reìistrâcijas numurs'&CHR(9)&|
           'Personas dzimðanas dati (ja nav personas koda)'&CHR(9)&'Vârds, uzvârds'&CHR(9)&|
           'Datums (mçnesis,gads)'&CHR(9)&'Ziòu kods'
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
        LOOP I#= 1 TO 2
           EXECUTE I#
              ZDAT=KAD:DARBA_GR
              ZDAT=KAD:D_GR_END
           .
           IF INRANGE(ZDAT,S_DAT,B_DAT)
             VUT = CLIP(KAD:VAR) & ' ' &CLIP(KAD:UZV)
             PERSKODS=KAD:PERSKOD
             EXECUTE I#
                ZK=KAD:Z_KODS
                ZK=KAD:Z_KODS_END
             .
             NPK+=1
             IF F:XML_OK#=TRUE
                XML:LINE='<R>'
                ADD(OUTFILEXML)
                XML:LINE=' Npk>'&CLIP(NPK)&'</Npk>'
                ADD(OUTFILEXML)
                XML:LINE=' PersonasKods>'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'</PersonasKods>'
                ADD(OUTFILEXML)
                XML:LINE=' DzimsanasDat xsi:nil="true" />'
                ADD(OUTFILEXML)
                XML:LINE=' VardsUzvards>'&CLIP(VUT)&'</VardsUzvards>'
                ADD(OUTFILEXML)
                XML:LINE=' IzmDatums>'&FORMAT(ZDAT,@D010-)&'T00:00:00</IzmDatums>'
                ADD(OUTFILEXML)
                XML:LINE=' ZinuKods>'&ZK&'</ZinuKods>'
                ADD(OUTFILEXML)
                XML:LINE='</R>'
                ADD(OUTFILEXML)
             .
             IF F:DBF = 'W'
                PRINT(RPT:detail)
             ELSE
                OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK
                ADD(OUTFILEANSI)
             END
           .
        .
        CLEAR(RIK:RECORD)
!        RIK:ID = KAD:ID
        RIK:DATUMS = S_DAT
!        SET(RIK:DAT_KEY,RIK:DAT_KEY)
        SET(RIK:DAT_KEY,RIK:DAT_KEY)
        LOOP
           NEXT(KAD_RIK)
!           IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
           IF ERROR() OR ~(RIK:DATUMS<=B_DAT) THEN BREAK.
           IF ~(RIK:ID=KAD:ID) THEN CYCLE.
!           IF ~INSTRING(RIK:TIPS,'KAC') THEN CYCLE. ! IESPÇJAMÂS ZIÒAS NO RÎKOJUMIEM
           IF ~(RIK:TIPS='K') THEN CYCLE. ! IESPÇJAMÂS ZIÒAS NO RÎKOJUMIEM
!           IF ~INRANGE(RIK:DATUMS,S_DAT,B_DAT) THEN CYCLE.
           IF ~RIK:Z_KODS THEN CYCLE.
           VUT = CLIP(KAD:VAR) & ' ' &CLIP(KAD:UZV)
           PERSKODS=KAD:PERSKOD
           ZK=RIK:Z_KODS
           ZDAT=RIK:DATUMS
           NPK+=1
           IF F:XML_OK#=TRUE
              XML:LINE='<R>'
              ADD(OUTFILEXML)
              XML:LINE=' Npk>'&CLIP(NPK)&'</Npk>'
              ADD(OUTFILEXML)
              XML:LINE=' PersonasKods>'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'</PersonasKods>'
              ADD(OUTFILEXML)
              XML:LINE=' DzimsanasDat xsi:nil="true" />'
              ADD(OUTFILEXML)
              XML:LINE=' VardsUzvards>'&CLIP(VUT)&'</VardsUzvards>'
              ADD(OUTFILEXML)
              XML:LINE=' IzmDatums>'&FORMAT(ZDAT,@D010-)&'T00:00:00</IzmDatums>'
              ADD(OUTFILEXML)
              XML:LINE=' ZinuKods>'&ZK&'</ZinuKods>'
              ADD(OUTFILEXML)
              XML:LINE='</R>'
              ADD(OUTFILEXML)
           .
           IF F:DBF = 'W'
              PRINT(RPT:detail)
           ELSE
              OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK
              ADD(OUTFILEANSI)
           .
        .
        LOOP   !LOOP KAD_RIK
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
      .
    .
  .
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:XML_OK#=TRUE  !BEIDZAS TABS,BEIDZAS DEKLARÂCIJA
       XML:LINE='</Rs>'
       ADD(OUTFILEXML)
       XML:LINE='</Tab>'
       ADD(OUTFILEXML)
       XML:LINE='</DokZDNv1>'
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
          FILENAME2='A:\DDZ_P.XML'
          IF ~CopyFileA(XMLFILENAME,FILENAME2,0)
             KLUDA(3,XMLFILENAME&' uz '&FILENAME2)
          .
       .
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL2)
!        PRINT(RPT:ZINU_KODI_NEW)
        PRINT(RPT:PARAKSTI)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    OMIT('MARIS')
        OUTA:LINE='Npk'&CHR(9)&'Ziòu kods'&CHR(9)&'Atðifrçjums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='1.  '&CHR(9)&'11'&CHR(9)&'Tâda darba òçmçja statusa iegûðana, kurð ir apdroðinâms atbilstoði visiem valsts sociâlâs apdroðinâðanas veidiem'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='2.  '&CHR(9)&CHR(9)&'Tâda darba òçmçja iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðanai, invaliditâtes apdroðinâðanai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'maternitâtes un slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'(darba òçmçjam, kurð ir I vai II grupas invalîds)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='3.  '&CHR(9)&CHR(9)&'Tâda darba òçmçja iegûðana, kurð ir pakïauts valsts pensiju apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un arodslimîbâm'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'(darba òçmçjam, kurð ir sasniedzis vecumu, kas dod tiesîbas saòemt valsts vecuma pensiju; darba òçmçjam, kuram ir pieðíirta'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'vecuma pensija ar atvieglotiem noteikumiem)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='4.  '&CHR(9)&CHR(9)&'Darba òçmçja statusa zaudçðana, pamatojoties uz darba òçmçja uzteikumu'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='5.  '&CHR(9)&CHR(9)&'Darba òçmçja statusa zaudçðana sakarâ ar darba òçmçja pârkâpumu normatîvajos aktos noteiktajos gadîjumos'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='6.  '&CHR(9)&CHR(9)&'Darba òçmçja statusa zaudçðana sakarâ ar darba devçja likvidâciju'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='7.  '&CHR(9)&CHR(9)&'Darba òçmçja statusa zaudçðana sakarâ ar nespçju veikt nolîgto darbu veselîbas stâvokïa dçï'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='8.  '&CHR(9)&CHR(9)&'Darba òçmçja statusa zaudçðana citos gadîjumos'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='9.  '&CHR(9)&CHR(9)&'Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir apdroðinâms visiem valsts sociâlâs'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'apdroðinâðanas veidiem (darba òçmçjam, kurð ir zaudçjis I vai II grupas invaliditâti)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='10. '&CHR(9)&CHR(9)&'Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valsts pensiju apdroðinâðanai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'invaliditâtes apdroðinâðanai, maternitâtes un slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'nelaimes gadîjumiem darbâ un arodslimîbâm (darba òçmçjam, kurð ir ieguvis I vai II grupas invaliditâti'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='11. '&CHR(9)&CHR(9)&'Darba òçmçja apdroðinâðanas statusa maiòa - darba òçmçjs, kurð ir pakïauts valsts pensiju apdroðinâðanai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'maternitâtes un slimîbas apdroðinâðanai un sociâlajai apdroðinâðanai pret nelaimes gadîjumiem darbâ un'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'arodslimîbâm (darba òçmçjam, kurð ir sasniedzis vecumu, kas dod tiesîbas saòemt valsts vecuma pensiju;'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'darba òçmçjam, kuram ir pieðíirta vecuma pensija ar atvieglotiem noteikumiem)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='12. '&CHR(9)&CHR(9)&'Darba òçmçjam ir pieðíirts bçrna kopðanas atvaïinâjums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='13. '&CHR(9)&CHR(9)&'Darba òçmçjs, kuram ir bçrns vecumâ lîdz trim gadiem, nodarbinâts nepilnu darba nedçïu (lîdz 20 stundâm'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'nedçïâ, ja bçrns ir vecumâ lîdz pusotram gadam, un lîdz 34 stundâm nedçïâ, ja bçrns ir vecumâ no pusotra'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'lîdz trim gadam)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='14. '&CHR(9)&CHR(9)&'Darba òçmçjs, kuram ir bçrns vecumâ lîdz trim gadiem, nodarbinâts pilnu darba nedçïu (vairâk par 20 stundâm'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'nedçïâ, ja bçrns ir vecumâ lîdz pusotram gadam, un vairâk par 34 stundâm nedçïâ, ja bçrns ir vecumâ no'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'pusotra lîdz trim gadiem)'
        ADD(OUTFILEANSI)
     MARIS
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpildîtâjs:'&CLIP(SYS:PARAKSTS2)&' Tâlruòa numurs:'&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE='Vadîtâjs:'&SYS:PARAKSTS1
        ADD(OUTFILEANSI)
        OUTA:LINE='Datums'&FORMAT(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE='Z.V.'
        ADD(OUTFILEANSI)
    .
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
A_PAZ_FP1            PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
RPT_GADS             DECIMAL(4)
RPT_MEN_NR           BYTE         !TEKOÐAIS MÇNESIS
VUT                  STRING(35)
R5                   DECIMAL(9,2)
R6                   DECIMAL(9,2)
R7                   DECIMAL(9,2)
R8                   DECIMAL(9,2)
R9                   DECIMAL(9,2)
R10                  DECIMAL(9,2)
R11                  DECIMAL(10,2)
R12                  DECIMAL(9,2)
R13                  DECIMAL(9,2)
R14                  DECIMAL(9,2)
R15                  DECIMAL(9,2)
R16                  DECIMAL(9,2)
RINDA                STRING(40)
A_NM                 DECIMAL(10,2)
APLIEN               DECIMAL(10,2)
RPT_S_DAT            LONG
RPT_B_DAT            LONG
E_DAT                LONG
PAR_NOS_P            LIKE(PAR:NOS_P)
MENESS               STRING(12)
IVK1                 STRING(4)
IVK                  STRING(60)
IV                   STRING(90)
!------------------------------------------------------------------------
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
report REPORT,AT(104,198,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,100,8000,104),USE(?unnamed:2)
       END
detail DETAIL,AT(,,,10000),USE(?unnamed)
         STRING('Izsniedz ienâkuma saòçmçjam un '),AT(125,104),USE(?String65:3),TRN
         STRING('Valsts ieòçmumu dienestam'),AT(125,260),USE(?String65:4),TRN
         STRING('1. pielikums'),AT(7354,146),USE(?String65:5),TRN
         STRING('Ministru Kabineta'),AT(7073,281),USE(?String65:2),TRN,CENTER
         STRING('noteikumiem Nr.677'),AT(6958,573),USE(?String65:6),TRN
         STRING('2008.gada 25.augusta'),AT(6802,417),USE(?String65),TRN
         LINE,AT(104,417,1719,0),USE(?Line8:2),COLOR(COLOR:Black)
         STRING('Paziòojums par fiziskai personai izmaksâtajâm summâm'),AT(1125,646,5729,260),USE(?String1), |
             CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas mçnesis'),AT(2729,1219,1198,208),USE(?String4:3),TRN,LEFT(1),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s12),AT(4000,1229),USE(MENESS),TRN,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,7813,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(6250,2667,0,615),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(104,1875,7813,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Taksâcijas gads'),AT(2729,1000,1156,208),USE(?String4:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@n04),AT(4000,1010),USE(RPT_gads),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2146,7813,0),USE(?Line8),COLOR(COLOR:Black)
         STRING('IENÂKUMA IZMAKSÂTÂJS'),AT(2833,1625,2188,177),USE(?String1:4),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('IENÂKUMA SAÒÇMÇJS'),AT(2833,2479,2188,177),USE(?String1:3),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,104,0,313),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,104,1719,0),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(1823,104,0,313),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Ienâkuma izmaksas datums'),AT(156,4313,1552,208),USE(?String13:5)
         STRING(@N2),AT(2240,4323),USE(SYS:NOKL_DC),RIGHT
         LINE,AT(104,4583,7813,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Ieòçmumi'),AT(156,4635,615,208),USE(?String13:6),LEFT
         STRING('Neapliekamie ienâkumi'),AT(156,4844,1344,208),USE(?String13:7),LEFT
         STRING(@N_10.2),AT(7031,4635),USE(R5)
         LINE,AT(104,7240,7813,0),USE(?Line1:16),COLOR(COLOR:Black)
         STRING('Ieturçtais nodoklis'),AT(146,7021,1302,208),USE(?String71)
         STRING('16'),AT(6594,7021,260,208),USE(?String50:12),CENTER
         STRING('Attaisnotie izdevumi'),AT(156,5781,1042,208),USE(?String13:8),LEFT
         STRING('valsts sociâlâs apdroðinâðanas obligâtâs iemaksas'),AT(1208,5781,2760,208),USE(?String13:9), |
             LEFT
         STRING('_____gada "____"_{20}'),AT(365,8177),USE(?String60)
         STRING(@s25),AT(5156,8219),USE(sys:paraksts1),CENTER
         STRING('_{20}'),AT(5469,8010),USE(?String62)
         STRING(@s25),AT(3490,8010),USE(sys:amats1,,?sys:amats1:2),RIGHT
         STRING('Z. V.'),AT(365,8594),USE(?String61)
         STRING('_{20}'),AT(5469,8698),USE(?String63)
         STRING(@s25),AT(3490,8698),USE(sys:amats2),RIGHT
         STRING(@s25),AT(5156,8906),USE(sys:paraksts2),CENTER
         STRING('Tâlr. '),AT(5177,9104),USE(?String64)
         STRING(@s12),AT(5490,9104),USE(Sys:tel),LEFT
         STRING('11'),AT(6594,5990,260,208),USE(?String50:9),CENTER
         STRING(@N_10.2),AT(7031,5990,740,208),USE(R11)
         STRING('12'),AT(6594,6219,260,208),USE(?String50:91),TRN,CENTER
         STRING(@N_10.2),AT(7031,6229,740,208),USE(R12),TRN
         STRING('dzîvîbas apdroðinâðanas (bez lîdzekïu uzkrâðanas), veselîbas vai nelaimes gad.ap' &|
             'droð. prçmiju summas'),AT(1208,6427,5333,208),USE(?String13:10),TRN,LEFT
         STRING('13'),AT(6594,6427,260,208),USE(?String50:6),TRN,CENTER
         STRING(@N_10.2),AT(7031,6427,740,208),USE(R13),TRN
         STRING('dzîvîbas apdroðinâðanas (ar lîdzekïu uzkrâðanu) prçmiju summas'),AT(1208,6219,3448,208), |
             USE(?String13:2),TRN,LEFT
         STRING(@N_10.2),AT(7031,7021,740,208),USE(R16)
         STRING(@N_10.2),AT(7031,6823,740,208),USE(R15)
         STRING('09'),AT(6594,5521,260,208),USE(?String50:5),CENTER
         STRING('10'),AT(6594,5781,260,208),USE(?String50:8),CENTER
         STRING('08'),AT(6594,5260,260,208),USE(?String50:4),CENTER
         STRING('Neapliekamais minimums'),AT(156,5052,1333,208),USE(?String13:11),LEFT
         LINE,AT(104,5729,7813,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING(@s40),AT(156,7333,2969,208),USE(rinda),LEFT
         STRING(@N_10.2),AT(7031,5521,646,177),USE(R9)
         STRING('07'),AT(6594,5042,260,208),USE(?String50:3),CENTER
         LINE,AT(104,4583,0,2656),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@d06.),AT(3021,4063),USE(RPT_b_dat),RIGHT
         LINE,AT(2104,3490,0,1042),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(1813,3500,0,1042),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Ienâkuma gûðanas periods'),AT(156,4063,1469,208),USE(?String13:4)
         STRING('03'),AT(1833,4042,260,208),USE(?String50:15),TRN,CENTER
         STRING(@d06.),AT(2240,4063),USE(RPT_S_dat),LEFT
         STRING('-'),AT(2917,4063,104,208),USE(?String24),CENTER
         LINE,AT(104,2406,7813,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@s35),AT(938,2740),USE(VUT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@p######-#####p),AT(6563,2740),USE(KAD:PERSKOD),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2688,7813,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s35),AT(938,3052,3094,208),USE(kad:pieradr),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n06),AT(6771,3052,521,208),USE(kad:terkod),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,3010,7813,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(104,3281,7813,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@s45),AT(688,1938,3792,208),USE(client),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,4531,7813,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(104,4271,7813,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('04'),AT(1833,4302,260,208),USE(?String50:16),TRN,CENTER
         LINE,AT(104,4010,7813,0),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(7917,4583,0,2656),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@s13),AT(6375,1938,1417,208),USE(GL:REG_NR),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(698,2198,3802,208),USE(GL:adrese),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,3490,7813,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Ienâkuma veida kods'),AT(177,3521,1135,208),USE(?String13:21),TRN
         STRING('01'),AT(1833,3531,260,208),USE(?String50:13),TRN,CENTER
         STRING(@S60),AT(2240,3542,4156,177),USE(IVK),TRN
         LINE,AT(104,3750,7813,0),USE(?Line1:17),COLOR(COLOR:Black)
         STRING('Ienâkuma veids'),AT(156,3802,990,208),USE(?String13:3)
         STRING(@s90),AT(2240,3802,5646,177),USE(IV)
         STRING('02'),AT(1833,3792,260,208),USE(?String50:14),TRN,CENTER
         LINE,AT(104,5469,7813,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('Atvieglojumi par apgâdâjamiem'),AT(156,5260,1760,208),USE(?String13:12),LEFT
         STRING(@N_10.2),AT(7031,4844),USE(R6)
         STRING('05'),AT(6594,4635,260,208),USE(?String50),CENTER
         STRING('Ienâkums, no kura aprçíinâts nodoklis (05-06-07-08-09-10-11-12-13-14.rinda)'),AT(156,6823,4135,208), |
             USE(?String13:16),LEFT
         STRING('15'),AT(6594,6823,260,208),USE(?String50:11),CENTER
         STRING('iemaksas privâtajos pensiju fondos'),AT(1208,5990,2760,208),USE(?String13:17),LEFT
         STRING(@N_10.2),AT(7031,5260),USE(R8)
         STRING('14'),AT(6594,6615,260,208),USE(?String50:10),CENTER
         STRING(@N_10.2),AT(7031,6615,740,208),USE(R14)
         STRING('izdevumi'),AT(1208,6615,2760,208),USE(?String13:19),LEFT
         STRING('06'),AT(6594,4844,260,208),USE(?String50:2),CENTER
         STRING('Papildu atvieglojuma kods'),AT(156,5521,1302,208),USE(?String13:13),LEFT
         STRING('Summa'),AT(4396,5521,604,208),USE(?String13:14),LEFT
         LINE,AT(6563,4583,0,2656),USE(?Line10:7),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7031,5781,740,208),USE(R10)
         LINE,AT(6875,4583,0,2656),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7031,5052),USE(R7)
         LINE,AT(6250,1865,0,300),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(7917,1510,0,3021),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(104,1510,0,3021),USE(?Line10),COLOR(COLOR:Black)
         STRING('ISF Assako'),AT(7469,10760,500,104),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND

  RPT_GADS=YEAR(ALP:YYYYMM)
  RPT_MEN_NR=MONTH(ALP:YYYYMM)
  S_DAT=DATE(1,1,YEAR(ALP:YYYYMM))
  B_DAT=DATE(12,31,YEAR(ALP:YYYYMM))

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

  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  BIND('F:IDP',F:IDP)
  BIND(KAD:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Paziòojums par FP izm.summâm'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KAD:RECORD)
      SET(KAD:INI_KEY,KAD:INI_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA and ~(KAD:NODALA=F:NODALA)) AND ~(ID and ~(KAD:ID=ID))'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WE
        IF ~OPENANSI('PAZFP1.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~F:IDP OR|                                                   !VISI
           (F:IDP='1' AND YEAR(KAD:D_GR_END)=RPT_GADS) OR|              !TIKAI ATLAISTIE Ð.G.
           (F:IDP='2' AND ~INRANGE(YEAR(KAD:D_GR_END),1,RPT_GADS)) OR|  !TIKAI NEATLAISTIE
           (F:IDP='3' AND YEAR(KAD:D_GR_END)=RPT_GADS AND MONTH(KAD:D_GR_END)=RPT_MEN_NR) !TIKAI ATLAISTIE Ð.M.
           VUT=clip(kad:var)&' '&clip(kad:uzv)
           PAR_NOS_P=getpar_k(KAD:VID_U_NR,0,2)
           IF INRANGE(KAD:DARBA_GR,S_DAT,B_DAT)
             RPT_S_DAT=KAD:DARBA_GR
           ELSE
             RPT_S_DAT=S_DAT
           .
           IF INRANGE(KAD:D_GR_END,S_DAT,B_DAT)
             RPT_B_DAT=KAD:D_GR_END
           ELSE
             RPT_B_DAT=B_DAT
           .
           R5=0
           R6=0
           R7=0
           R8=0
           R9=0
           R10=0
           R11=0
           R12=0
           R13=0
           R14=0
           R15=0
           R16=0

           aplien=0
           A_NM  =0
           K#=0
           IVK=''
           IV=''
           FIRST#=TRUE
           
           CLEAR(ALG:RECORD)
           ALG:ID=KAD:ID
           ALG:YYYYMM=DATE(MONTH(RPT_S_DAT),1,YEAR(RPT_S_DAT))
           SET(ALG:ID_DAT,ALG:ID_DAT)
           LOOP
             NEXT(ALGAS)
             IF ERROR() OR ~(ALG:ID=KAD:ID) OR ~(YEAR(ALG:YYYYMM)=RPT_GADS) THEN BREAK.
             K#+=1
             ?Progress:UserString{PROP:TEXT}=CLIP(K#)&' '&VUT
             DISPLAY(?Progress:UserString)
             LOOP I#=1 TO 20
                IF ALG:K[I#] !PIESK.KODS
                   IVK1 =GETDAIEV(ALG:K[I#],0,8)
                   J#=INSTRING(IVK1,IVK,5,1)
                   IF J#
                      BREAK
                   ELSIF FIRST#=TRUE
                      IVK =IVK1
                      IV=GETDAIEV(ALG:K[I#],0,9)
                      FIRST#=FALSE
                   ELSE
                      IVK=CLIP(IVK)&','&IVK1
                      IV=CLIP(IV)&','&GETDAIEV(ALG:K[I#],0,9)
                   .
                .
             .
             R5+=ROUND(SUM(33),.01)
             R6+=ROUND(SUM(2),.01)+ROUND(SUM(53),.01)
             R7+=CALCNEA(1,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             R8+=CALCNEA(2,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             IF INRANGE(ALG:INV_P,1,3)
                R9+=CALCNEA(3,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             ELSIF INRANGE(ALG:INV_P,4,5)
                R9+=CALCNEA(3,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             .
             R10+=ROUND(SUM(6),.01)
             R11+=ALG:PPF
             R12+=0          !BÛS VAJADZÎGS DZA_A
             R13+=ALG:DZIVAP !DZÎVÎBAS APDROÐINÂÐNA BEZ UZKRÂÐANAS
             R14+=ALG:IZDEV  !IZDEVUMI 21.08.2010
             R16+=ROUND(SUM(22)+SUM(23)+SUM(26)+SUM(27)+SUM(42),.01) !APRÇÍINÂTAIS NODOKLIS
             IF MONTH(ALG:YYYYMM)=12
               A_NM+=SUM(21)                !ATVAÏINÂJUMI NÂKAMAJOS MÇNEÐOS
             .
             E_DAT=DATE(MONTH(ALG:YYYYMM)+1,1,RPT_GADS)-1
           .
           IF E_DAT < RPT_B_DAT                  
              RPT_B_DAT=E_DAT
           .
!           S11=S1-S2-S3-S4-S5-S6-S7-S8-S9-S10
           R15=R5-R6-R7-R8-R9-R10-R11-R12-R13-R14
           IF R15<0 THEN R15=0.
           IF A_NM
             RINDA='Atvaïinâjumi nâkamajâ gadâ : '&a_nm
           ELSE
             RINDA=''
           .
           a_nm=0
           MENESS=MENVAR(RPT_B_DAT,2,2) !HEDERI DRUKÂ KOPÂ AR 1 DETAÏU
           IF R5
              IF F:DBF='W'   !WMF
                 PRINT(RPT:DETAIL)
              ELSE           !WE
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'1.pielikums'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2008.g.25.augusta'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 67'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Paziòojums par fiziskai personai izmaksâtajâm summâm'
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Taksâcijas gads     '&RPT_gads
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Taksâcijas mçnesis  '&MENESS
                 ADD(OUTFILEANSI)
                 OUTA:LINE='IENÂKUMA IZMAKSÂTÂJS'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=CLIENT
                 ADD(OUTFILEANSI)
                 OUTA:LINE=GL:ADRESE
                 ADD(OUTFILEANSI)
                 OUTA:LINE='IENÂKUMA SAÒÇMÇJS'
                 ADD(OUTFILEANSI)
                 OUTA:LINE=GETKADRI(KAD:ID,0,1)
                 ADD(OUTFILEANSI)
                 OUTA:LINE=GETKADRI(KAD:ID,0,18)
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ienâkuma veida kods'&CHR(9)&'01'&CHR(9)&IVK
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ienâkuma veids'&CHR(9)&'02'&CHR(9)&IV
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ienâkuma gûðanas periods'&CHR(9)&'03'&CHR(9)&FORMAT(RPT_S_DAT,@D6.)&'-'&FORMAT(RPT_B_DAT,@D6.)
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ienâkuma izmaksas datums'&CHR(9)&'04'&CHR(9)&SYS:NOKL_DC
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ieòçmumi'&CHR(9)&'05'&CHR(9)&LEFT(FORMAT(R5,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Neapliekamie ienâkumi'&CHR(9)&'06'&CHR(9)&LEFT(FORMAT(R6,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Neapliekamais minimums'&CHR(9)&'07'&CHR(9)&LEFT(FORMAT(R7,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Atvieglojumi par apgâdâjamiem'&CHR(9)&'08'&CHR(9)&LEFT(FORMAT(R8,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Papildu atvieglojuma kods     Summa'&CHR(9)&'09'&CHR(9)&LEFT(FORMAT(R9,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Attaisnotie izdevumi'
                 ADD(OUTFILEANSI)
                 OUTA:LINE='valsts sociâlâs apdroðinâðanas obligâtâs iemaksas'&CHR(9)&'10'&CHR(9)&LEFT(FORMAT(R10,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='iemaksas privâtajos pensiju fondos'&CHR(9)&'11'&CHR(9)&LEFT(FORMAT(R11,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='dzîvîbas apdroðinâðanas (ar lîdzekïu uzkrâðanu) prçmiju summas'&CHR(9)&'12'&CHR(9)&|
                 LEFT(FORMAT(R12,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='dzîvîbas apdroðinâðanas (bez lîdzekïu uzkrâðanas), veselîbas vai nelaimes gad.apdroð. prçmiju summas'&|
                 CHR(9)&'13'&CHR(9)&LEFT(FORMAT(R13,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Izdevumi'&CHR(9)&'14'&CHR(9)&LEFT(FORMAT(R14,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ienâkums, no kura aprçíinâts nodoklis (05-06-07-08-09-10-11-12-13-14.rinda)'&CHR(9)&'15'&|
                 CHR(9)&LEFT(FORMAT(R15,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE='Ieturçts nodoklis'&CHR(9)&'16'&CHR(9)&LEFT(FORMAT(R16,@N_9.2))
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE='_________gada______________________ '&CLIP(sys:amats1)&'___________________'
                 ADD(OUTFILEANSI)
                 OUTA:LINE='                                                       '&sys:paraksts1
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE='      Z.V.                          '&CLIP(sys:amats2)&'___________________'
                 ADD(OUTFILEANSI)
                 OUTA:LINE='                                Tâlr.'&SYS:TEL&'         '&sys:paraksts2
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
                 OUTA:LINE=''
                 ADD(OUTFILEANSI)
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     CLOSE(ProgressWindow)
!     F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
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

