                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_DNKUS_2013         PROCEDURE                    ! Declare Procedure
NPK             LONG
DATUMS          LONG
PERSKODS        STRING(12)
VUT             STRING(22)
ZDAT            LONG
ZK              STRING(2)
PK              STRING(7)
VK              STRING(2)
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
PAGE_HEAD DETAIL,AT(,,,396),USE(?unnamed:6)
         LINE,AT(781,0,6510,0),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(1198,0,0,417),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,417),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(3406,0,0,417),USE(?Line4:4),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,417),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(5854,0,0,417),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,417),USE(?Line4:7),COLOR(COLOR:Black)
         LINE,AT(6240,10,0,417),USE(?Line4:15),COLOR(COLOR:Black)
         LINE,AT(6667,10,0,417),USE(?Line4:17),COLOR(COLOR:Black)
         STRING('Profesijas'),AT(6688,52,573,156),USE(?String11:18),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6771,208,375,156),USE(?String11:19),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts'),AT(6271,52,385,156),USE(?String11:16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6260,208,375,156),USE(?String11:17),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Npk'),AT(813,52,365,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods'),AT(1208,52,979,156),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pers. dzimð. dati'),AT(2198,52,1208,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vârds, uzvârds'),AT(3552,52,1396,156),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums,'),AT(4969,52,885,156),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ziòu'),AT(5865,52,375,156),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vai reì. numurs'),AT(1208,208,979,156),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ja nav pers. koda)'),AT(2198,208,1208,156),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mçnesis, gads'),AT(4969,208,885,156),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(5865,208,375,156),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,0,0,417),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(781,365,6510,0),USE(?Line3:2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,167),USE(?unnamed:4)
         LINE,AT(781,-10,0,188),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_3),AT(885,10,,156),USE(NPK),RIGHT
         LINE,AT(1198,-10,0,188),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,188),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(3406,-10,0,188),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,188),USE(?Line4:12),COLOR(COLOR:Black)
         LINE,AT(5854,-10,0,188),USE(?Line4:13),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,188),USE(?Line4:14),COLOR(COLOR:Black)
         STRING(@S2),AT(5969,10,,156),USE(ZK),LEFT
         STRING(@S2),AT(6375,10,,156),USE(VK),TRN,LEFT
         STRING(@S7),AT(6760,10,,156),USE(PK),TRN
         LINE,AT(6667,-10,0,188),USE(?Line4:18),COLOR(COLOR:Black)
         LINE,AT(6240,-10,0,188),USE(?Line4:16),COLOR(COLOR:Black)
         STRING(@s22),AT(3469,10,,156),USE(VUT)
         STRING(@D06.),AT(5073,10,,156),USE(ZDAT)
         STRING(@S12),AT(1271,10,,156),USE(PERSKODS)
       END
detail2 DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(781,-10,0,63),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,63),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(2188,-10,0,63),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(3406,-10,0,63),USE(?Line19:6),COLOR(COLOR:Black)
         LINE,AT(4948,-10,0,63),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(5854,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,63),USE(?Line4:23),COLOR(COLOR:Black)
         LINE,AT(6240,-10,0,63),USE(?Line19:8),COLOR(COLOR:Black)
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
             !08/07/2013 <
             PK = ''
             VK = ''
             IF ZK = 11 OR ZK = 12 OR ZK = 13 OR ZK = 14 OR ZK = 15 OR ZK = 16 OR ZK = 17 OR ZK = 61 OR ZK = 62 OR ZK = 63
                CLEAR(RIK:RECORD)
                RIK:ID = KAD:ID
                RIK:DATUMS = ZDAT
                SET(RIK:DAT_KEY,RIK:DAT_KEY)
                LOOP
                   NEXT(KAD_RIK)
                   IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
                   IF ERROR() OR ~(RIK:DATUMS=ZDAT) THEN BREAK.
                   IF (RIK:TIPS='F')
                      PK = RIK:SATURS
                      BREAK
                   .
                .
             .
             IF ZK = 71  OR ZK = 72
                CLEAR(RIK:RECORD)
                RIK:ID = KAD:ID
                RIK:DATUMS = ZDAT
                SET(RIK:DAT_KEY,RIK:DAT_KEY)
                LOOP
                   NEXT(KAD_RIK)
                   IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
                   IF ERROR() OR ~(RIK:DATUMS=ZDAT) THEN BREAK.
                   IF (RIK:Z_KODS = 71) OR (RIK:Z_KODS = 72)
                      VK = RIK:SATURS
                      BREAK
                   .
                .
             .
             !08/07/2013 >

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
                !08/07/2013 <
                IF S_DAT >= DATE(7,1,2013)
                   XML:LINE=' ProfKods>'&CLIP(PK)&'</ProfKods>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValstsKods>'&VK&'</ValstsKods>'
                   ADD(OUTFILEXML)
                 .
                !08/07/2013 <

                XML:LINE='</R>'
                ADD(OUTFILEXML)
             .
             IF F:DBF = 'W'
                PRINT(RPT:detail)
             ELSE
                OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK&CHR(9)&PK&CHR(9)&VK
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
           !08/07/2013 IF ~(RIK:TIPS='K') THEN CYCLE. ! IESPÇJAMÂS ZIÒAS NO RÎKOJUMIEM
           IF ~INSTRING(RIK:TIPS,'KF') THEN CYCLE. !08/07/2013
!           IF ~INRANGE(RIK:DATUMS,S_DAT,B_DAT) THEN CYCLE.
           IF ~RIK:Z_KODS THEN CYCLE.
           IF KAD:DARBA_GR = RIK:DATUMS OR KAD:D_GR_END = RIK:DATUMS THEN CYCLE. !08/07/2013 nevar but 2 statusi viena dienâ
           VUT = CLIP(KAD:VAR) & ' ' &CLIP(KAD:UZV)
           PERSKODS=KAD:PERSKOD
           ZK=RIK:Z_KODS
           ZDAT=RIK:DATUMS
           !08/07/2013 <
           IF (RIK:Z_KODS = 71) OR (RIK:Z_KODS = 72)
              VK = RIK:SATURS
           ELSE
              VK = ''
           END
           IF (RIK:TIPS='F')
              PK = RIK:SATURS
              ZK = 'PM'
           ELSE
              PK =''
           .
           !08/07/2013 >

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
              !08/07/2013 <
              IF S_DAT >= DATE(7,1,2013)
                 XML:LINE=' ProfKods>'&PK&'</ProfKods>'
                 ADD(OUTFILEXML)
                 XML:LINE=' ValstsKods>'&VK&'</ValstsKods>'
                 ADD(OUTFILEXML)
              .
              !08/07/2013 >
              XML:LINE='</R>'
              ADD(OUTFILEXML)
           .
           IF F:DBF = 'W'
              PRINT(RPT:detail)
           ELSE
              OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK&CHR(9)&PK&CHR(9)&VK
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
