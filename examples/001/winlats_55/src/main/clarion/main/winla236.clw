                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_DEK_NEW        PROCEDURE                    ! Declare Procedure
CG           STRING(10)
RejectRecord LONG
EOF          BYTE
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)
K31          REAL
K33          REAL
K34          REAL
K54          REAL
K56          REAL
R1           DECIMAL(12,2)
R2           DECIMAL(12,2)
R3           DECIMAL(12,2)
R4           DECIMAL(12,2)
R5           DECIMAL(12,2)
R6           DECIMAL(12,2)
R7           DECIMAL(12,2)
R8           DECIMAL(12,2)
R9           DECIMAL(12,2)
R10          DECIMAL(12,2)
R11          DECIMAL(12,2)
R12          DECIMAL(12,2)
R13          DECIMAL(12,2)
R14          DECIMAL(12,2)
R15          DECIMAL(12,2)
R21          DECIMAL(12,2)
R22          DECIMAL(12,2)
R23          DECIMAL(12,2)
R23S         DECIMAL(12,2)
R24          DECIMAL(12,2)
R25          DECIMAL(12,2)
R26          DECIMAL(12,2)
R27          DECIMAL(12,2)
R28          DECIMAL(12,2)
R29          DECIMAL(12,2)
R30          DECIMAL(12,2)
R31          DECIMAL(12,2)
SS           DECIMAL(12,2)
PP           DECIMAL(12,2)
DATUMS       DATE
MEN12        DECIMAL(2),DIM(12)
RSS          STRING(11)
RSSS         STRING(11)

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
PrintSkipDetails     BOOL,AUTO
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
report REPORT,AT(198,104,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
detail DETAIL,AT(,,8000,11510)
         STRING('VALSTS IEÒÇMUMU DIENESTS'),AT(2865,208),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('1.pielikums'),AT(6771,313),USE(?String107)
         STRING('PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJA'),AT(2031,448),USE(?String2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Ministru kabineta'),AT(6615,469),USE(?String108)
         LINE,AT(2240,729,3906,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5365,729,0,729),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(6146,729,0,729),USE(?Line3:10),COLOR(COLOR:Black)
         STRING('2003.g.14.janvâra'),AT(6625,646),USE(?String109)
         STRING('Taksâcijas periods'),AT(2292,781,3073,208),USE(?String3),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('noteikumiem Nr 21'),AT(6563,823),USE(?String110)
         STRING(@N2B),AT(2302,1250,156,208),USE(MEN12[1]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(2552,1250,156,208),USE(MEN12[2]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(2813,1250,156,208),USE(MEN12[3]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(3073,1250,156,208),USE(MEN12[4]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(3333,1250,156,208),USE(MEN12[5]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(3594,1250,156,208),USE(MEN12[6]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(3854,1250,156,208),USE(MEN12[7]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(4115,1250,156,208),USE(MEN12[8]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(4375,1250,156,208),USE(MEN12[9]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(4635,1250,156,208),USE(MEN12[10]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(4896,1250,156,208),USE(MEN12[11]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2B),AT(5156,1250,156,208),USE(MEN12[12]),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2240,1458,3906,0),USE(?Line1:28),COLOR(COLOR:Black)
         STRING('Gads'),AT(5417,1042,729,156),USE(?String6),CENTER,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(2240,729,0,729),USE(?Line3),COLOR(COLOR:Black)
         STRING('Mçneði'),AT(2292,1042,3073,156),USE(?String5),CENTER,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(2240,1198,3906,0),USE(?Line1:27),COLOR(COLOR:Black)
         STRING(@N4),AT(5521,1250,417,208),USE(GL:DB_gads),RIGHT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâtâja saîsinâtais nosaukums:'),AT(260,1563),USE(?String8),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(2448,1563,3333,208),USE(CLIENT),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese:'),AT(260,1823),USE(?String10),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@s45),AT(781,1823,3385,208),USE(GL:adrese),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,1979,2604,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(2240,990,3906,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('PVN reìistrâcijas Nr :'),AT(260,2083),USE(?String12),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@s13),AT(1615,2083,1094,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,1198,0,260),USE(?Line46:12),COLOR(COLOR:Black)
         LINE,AT(4844,1198,0,260),USE(?Line46:3),COLOR(COLOR:Black)
         LINE,AT(4583,1198,0,260),USE(?Line46:4),COLOR(COLOR:Black)
         LINE,AT(4323,1198,0,260),USE(?Line46:5),COLOR(COLOR:Black)
         LINE,AT(4063,1198,0,260),USE(?Line46:6),COLOR(COLOR:Black)
         LINE,AT(3802,1198,0,260),USE(?Line46:7),COLOR(COLOR:Black)
         LINE,AT(3542,1198,0,260),USE(?Line46:8),COLOR(COLOR:Black)
         LINE,AT(3281,1198,0,260),USE(?Line46:9),COLOR(COLOR:Black)
         LINE,AT(3021,1198,0,260),USE(?Line46:10),COLOR(COLOR:Black)
         LINE,AT(2760,1198,0,260),USE(?Line46:11),COLOR(COLOR:Black)
         LINE,AT(2500,1198,0,260),USE(?Line46:2),COLOR(COLOR:Black)
         LINE,AT(5208,1979,0,6510),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(7813,1979,0,6771),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Priekðnodoklis'),AT(5260,2031,1250,208),USE(?String14),CENTER
         STRING('Aprçíinâtais PVN'),AT(6563,2031,1250,208),USE(?String16),CENTER
         STRING('(latos)'),AT(5260,2240,1250,208),USE(?String15),CENTER
         STRING('(latos)'),AT(6563,2240,1250,208),USE(?String17),CENTER
         LINE,AT(3854,2448,3958,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('KOPÇJÂ DARÎJUMU VÇRTÎBA, no tâs'),AT(260,2500,2448,208),USE(?String18),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('1'),AT(5000,2500,208,208),USE(?String22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(3906,2500),USE(R1),RIGHT
         STRING('ar PVN 18% apl. darîj. (arî paðpat.) '),AT(260,2708),USE(?String19),LEFT
         STRING('ar PVN 0% apliekamie darîjumi (t.s.6)'),AT(260,3125,2552,208),USE(?String19:2),LEFT
         STRING('ar PVN neapliekamie darîjumi'),AT(260,3333,2031,208),USE(?String19:3),LEFT
         STRING('4'),AT(5000,3125,208,208),USE(?String22:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(3906,2917),USE(R3),RIGHT
         STRING(@N-_12.2B),AT(3906,3125),USE(R4),RIGHT
         STRING(@N-_12.2B),AT(3906,3542),USE(R6),RIGHT
         STRING('ar PVN 18% apliekamajiem darîjumiem;'),AT(260,4271),USE(?String31)
         STRING('8'),AT(7552,4271,260,208),USE(?String22:8),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,5104,2604,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('PRIEKÐNODOKLIS, no tâ :'),AT(281,5156),USE(?String36),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6563,4271,885,208),USE(R8),RIGHT
         STRING(' 21'),AT(6250,5156,260,208),USE(?String22:10),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('par iekðzemç ievestajâm precçm savas saimn. darbîbas nodr.'),AT(271,5365,3802,208),USE(?String37), |
             LEFT
         STRING('par precçm un pak. iekðzemç savas saimn. darb. nodr.'),AT(260,5573,4063,208),USE(?String38), |
             LEFT,FONT(,9,,)
         STRING('aprçíinâtais priekðnodoklis saskaòâ ar 10.p. I daïas 3.punktu'),AT(260,5781,4063,208), |
             USE(?String39),LEFT
         STRING('zemnieku saimniecîbâm izmaksâtâ PVN 12% kompensâcija'),AT(260,6198),USE(?String40)
         STRING(@N-_12.2B),AT(5313,5990,833,208),USE(R25),RIGHT
         STRING(' 28'),AT(6250,6615,260,208),USE(?String22:17),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitâmais priekðnod. sask. ar likuma 10. p. 9. d.'),AT(260,6823),USE(?String46:3), |
             LEFT
         STRING(@N-_12.2B),AT(5313,6615,833,208),USE(R28),RIGHT
         STRING(@N-_12.2B),AT(5313,6198,833,208),USE(R26),RIGHT
         STRING('[P]'),AT(6292,7604),USE(?String55),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(' 29'),AT(6250,6823,260,208),USE(?String22:18),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Korekcijas'),AT(260,7083),USE(?String46:4),LEFT
         STRING(@N-_12.2B),AT(5313,6823,833,208),USE(R29),RIGHT
         STRING('KOPSUMMA:'),AT(260,7604),USE(?String54),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,7552,7604,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(7500,7031,0,781),USE(?Line3:11),COLOR(COLOR:Black)
         STRING('[S]'),AT(7594,7604),USE(?String55:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,7292,2604,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('Aprçíinâtais nodoklis vai atskaitâmais priekðnodoklis saskaòâ ar likuma 13.2.p'),AT(260,7344), |
             USE(?String46:5),LEFT
         STRING(@N-_12.2B),AT(5313,7344,833,208),USE(R31),RIGHT
         STRING('31'),AT(6250,7344,260,208),USE(?String22:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6563,7344,885,208),USE(R13),RIGHT
         STRING('13'),AT(7552,7344,260,208),USE(?String22:26),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,8490,2604,0),USE(?Line1:11),COLOR(COLOR:Black)
         LINE,AT(6510,8750,1302,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(6563,7604,885,208),USE(SS),RIGHT
         STRING('APSTIPRINU PVN APRÇÍINU :'),AT(2656,9063),USE(?String63),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1458,9740,0,677),USE(?Line3:14),COLOR(COLOR:Black)
         STRING('Atbildîgâ persona :'),AT(313,9531),USE(?String64),LEFT
         LINE,AT(7188,11250,156,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@S1),AT(7667,11156),USE(RS)
         LINE,AT(5625,10052,1406,0),USE(?Line1:24),COLOR(COLOR:Black)
         LINE,AT(5625,10417,1406,0),USE(?Line1:25),COLOR(COLOR:Black)
         LINE,AT(3646,10000,0,417),USE(?Line3:16),COLOR(COLOR:Black)
         LINE,AT(5625,9740,1406,0),USE(?Line1:23),COLOR(COLOR:Black)
         LINE,AT(1458,10000,2188,0),USE(?Line1:21),COLOR(COLOR:Black)
         LINE,AT(1667,10833,6302,0),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(1667,11042,6302,0),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7031,9740,0,677),USE(?Line3:18),COLOR(COLOR:Black)
         STRING('R : '),AT(7406,11156),USE(?String99)
         LINE,AT(1458,10417,2188,0),USE(?Line1:22),COLOR(COLOR:Black)
         STRING('Saòemðanas datums :'),AT(313,11146),USE(?String73),LEFT
         LINE,AT(5625,9740,0,677),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(3177,9740,0,260),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(1667,11250,5052,0),USE(?Line36),COLOR(COLOR:Black)
         STRING(@s5),AT(6771,11146),USE(KKK)
         STRING('Uzvârds :'),AT(313,9792),USE(?String65),LEFT
         STRING(@s20),AT(1563,9792),USE(SYS:PARAKSTS1),LEFT
         STRING('Datums :'),AT(5042,9792),USE(?String68),LEFT
         STRING(@d6),AT(5677,9792),USE(datums)
         LINE,AT(1458,9740,1719,0),USE(?Line1:20),COLOR(COLOR:Black)
         STRING(@s15),AT(5677,10208),USE(SYS:TEL)
         STRING('Inspektora piezîmes :'),AT(4635,10521),USE(?String72)
         STRING('Paraksts :'),AT(313,10208),USE(?String67),LEFT
         STRING('Tâlrunis :'),AT(5042,10208),USE(?String70),LEFT
         STRING('Budþetâ maksâjamâ nodokïa summa, ja P<<S'),AT(250,8542),USE(?String59:2),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,7604,833,208),USE(PP),RIGHT
         STRING(@N-_12.2B),AT(6563,8542,885,208),USE(R15),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,8281,833,208),USE(R14),RIGHT
         STRING('15'),AT(7552,8542,260,208),USE(?String22:20),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas periodu attiecinâmâ nodokïa summa, ja P>S'),AT(313,8281,3490,208),USE(?String60), |
             LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(7500,8490,0,260),USE(?Line3:12),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5313,7083,833,208),USE(R30),RIGHT
         STRING('30'),AT(6250,7083,260,208),USE(?String22:21),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(6563,7083,885,208),USE(R12),RIGHT
         STRING('12'),AT(7552,7083,260,208),USE(?String22:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5208,7031,2604,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5313,6406,833,208),USE(R27),RIGHT
         STRING(' 25'),AT(6250,5990,260,208),USE(?String22:14),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,5365,833,208),USE(R22),RIGHT
         STRING(' 14'),AT(6250,8281,260,208),USE(?String22:19),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamâ nodokïa summa vai uz nâkamo'),AT(250,8073),USE(?String59),LEFT, |
             FONT(,,,,CHARSET:BALTIC)
         STRING(' 24'),AT(6250,5781,260,208),USE(?String22:13),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('par ievestajiem pamatlîdzekïiem saskaòâ ar likuma 10.p. I.daïas 4.punktu'),AT(260,5990,4531,208), |
             USE(?String39:2),LEFT
         STRING(' 23'),AT(6250,5573,260,208),USE(?String22:12),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(' 22'),AT(6250,5365,260,208),USE(?String22:11),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,5156,833,208),USE(R21),RIGHT
         STRING(@N-_12.2B),AT(6563,4479,885,208),USE(R9),RIGHT
         STRING('9'),AT(7552,4479,260,208),USE(?String22:9),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(3906,3750),USE(R7),RIGHT
         STRING('neatskaitâmais priekðnod. sask. ar likuma 10. p. 9. d.'),AT(260,6406),USE(?String46), |
             LEFT
         STRING('neatskaitâmais priekðnod. sask. ar likuma 10. p. 10. d.'),AT(260,6615),USE(?String46:2), |
             LEFT
         STRING(' 27'),AT(6250,6406,260,208),USE(?String22:16),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,5781,833,208),USE(R24),RIGHT
         STRING(' 26'),AT(6250,6198,260,208),USE(?String22:15),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(5313,5573,833,208),USE(R23),RIGHT
         STRING('par saòemtajiem pakalpojumiem saskaòâ ar likuma 3. panta 11. daïu'),AT(260,4688,4063,208), |
             USE(?String34),LEFT,FONT(,9,,)
         STRING(@N-_12.2B),AT(6563,4688,885,208),USE(R10,,?R10:2),RIGHT
         STRING('10'),AT(7552,4688,260,208),USE(?String22:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('par ievestajiem pamatlîdzekïiem saskaòa ar likuma 12.p. 2.1.daïu'),AT(260,4896,4063,208), |
             USE(?String34:2),LEFT,FONT(,9,,)
         STRING(@N-_12.2B),AT(6563,4896,885,208),USE(R11),RIGHT
         LINE,AT(7500,4219,0,885),USE(?Line3:8),COLOR(COLOR:Black)
         STRING('ar PVN 9% apliekamajiem darîjumiem;'),AT(260,4479),USE(?String31:2)
         LINE,AT(6198,5104,0,3385),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('11'),AT(7552,4896,260,208),USE(?String22:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6510,4219,1302,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('7'),AT(5000,3750,208,208),USE(?String22:7),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_12.2B),AT(3906,3333),USE(R5),RIGHT
         STRING('PROPORCIJA   (%)'),AT(260,3750),USE(?String29),LEFT
         STRING('6'),AT(5000,3542,208,208),USE(?String22:6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5000,3333,208,208),USE(?String22:5),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 0% apliekamie darîjumi, kas veikti brîvostâs un SEZ'),AT(260,3542,3594,208),USE(?String19:5), |
             LEFT
         STRING(@N-_12.2B),AT(3906,2708),USE(R2),RIGHT
         STRING('3'),AT(5000,2917,208,208),USE(?String22:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('APRÇÍINÂTAIS PVN '),AT(260,4063),USE(?String16:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3854,3958,1354,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('2'),AT(5000,2708,208,208),USE(?String22:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN 9% apliekamie darîjumi'),AT(260,2917,2031,208),USE(?String19:4),LEFT
         LINE,AT(4948,2448,0,1510),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(3854,2448,0,1510),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(6510,1979,0,6771),USE(?Line3:4),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF KON_K::Used = 0
    CHECKOPEN(KON_K,1)
  end
  KON_K::Used += 1
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN deklarâcijas sagatavoðana'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF INRANGE(MEN_NR,1,12)
        MEN12[MEN_NR]=MEN_NR
      ELSIF INRANGE(MEN_NR,13,17)
        CASE MEN_NR
        OF 13                                          ! 1.CETURKSNIS
          MEN12[1]=1
          MEN12[2]=2
          MEN12[3]=3
        OF 14                                          ! 2.CETURKSNIS
          MEN12[4]=4
          MEN12[5]=5
          MEN12[6]=6
        OF 15                                          ! 3.CETURKSNIS
          MEN12[7]=7
          MEN12[8]=8
          MEN12[9]=9
        OF 16                                          ! 4.CETURKSNIS
          MEN12[10]=10
          MEN12[11]=11
          MEN12[12]=12
        OF 17                                          ! Viss gads
          LOOP M#=1 TO 12
            MEN12[M#]=M#
          .
        .
      ELSE
         STOP('NEGAIDÎTA KÏÛDA NR= '&MEN_NR)
      .
      clear(ggk:record)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K1000'
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      IF ErrorCode()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ErrorCode()
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
      ELSE           !RTF
        IF ~OPENANSI('PVNDKLR.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PIEVIENOTÂS VÇRTÎBAS DEKLARÂCIJA'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Taksâcijas periods'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Mçneði'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Gads'
        ADD(OUTFILEANSI)
        OUTA:LINE=MEN12[1]&CHR(9)&MEN12[2]&CHR(9)&MEN12[3]&CHR(9)&MEN12[4]&CHR(9)&MEN12[5]&CHR(9)&MEN12[6]&CHR(9)&MEN12[7]&CHR(9)&MEN12[8]&CHR(9)&MEN12[9]&CHR(9)&MEN12[10]&CHR(9)&MEN12[11]&CHR(9)&MEN12[12]&CHR(9)&GL:DB_GADS
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        OUTA:LINE='Maksâtâja saîsinâtais nosaukums: '&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Adrese: '&GL:ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE='PVN reìistrâcijas Nr: '&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           CASE GGK:D_K
       !************************ SAMAKSÂTS PVN ********
           OF 'D'                                     ! SAMAKSÂTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
       !       RPT:ANKOP+=GGK:SUMMA
             OF '2'                                   ! PVN_TIPS=2 IMPORTS
               R22+=GGK:SUMMA                     !
             OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               IF GGK:PVN_PROC=12                           ! PIEÐÛTS 12% ZEMNIEKIEM
                  r26+=GGK:SUMMA                  !
               ELSE
                  R23+=GGK:SUMMA
                  R23S+=GGK:SUMMA
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI
               R24+=GGK:SUMMA
             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
               R25+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R30+=GGK:SUMMA
             .
       !************************ SAÒEMTS PVN ********
           OF 'K'                                     ! SAÒEMTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
       !       RPT:ANKOP-=GGK:SUMMA                     ! AN NO FIN NOD.
             OF '2'                                   ! PVN_TIPS=2 IMPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
             OF '0'                                   ! SAÒEMTS,REALIZÇJOT
             OROF ''
             OROF 'N'                                 ! JA PALICIS
               CASE GGK:PVN_PROC
               OF 18
                  R8+=GGK:SUMMA
               OF 9
                  R9+=GGK:SUMMA
               ELSE
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
                  R8+=GGK:SUMMA                      ! LIETOTÂJA KÏÛDA
               .
             OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI
               R10+=GGK:SUMMA
             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
               R11+=GGK:SUMMA
             OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
               R12+=GGK:SUMMA
             .
           .
      !************************ Neapliekamie darîjumi ********
        ELSIF INSTRING(GGK:BKK[1],'568') AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
           C#=GETKON_K(GGK:BKK,2,1)
           LOOP R#=1 TO 2
              CASE KON:PVND[R#]        ! Neapliekamie darîjumi
              OF 4
              OROF 43
              OROF 44
              OROF 45
              OROF 46
              OROF 47
              OROF 48
                 r4 += GGK:SUMMA
              OF 5
              OROF 49
                 r5 += GGK:SUMMA
              OF 6
              OROF 43
                 R6 += GGK:SUMMA  ! 0% SEZOS, IET IEKÐ 4.
              ELSE
     !           KLÛDA
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
  IF TODAY() > B_DAT+15
     DATUMS=B_DAT+15
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    R2=(R8*100)/18                         ! ANALÎTISKI 18%
    R3=(R9*100)/9                          ! ANALÎTISKI  9%
!    R1=R2+R3+r4+r5+R6                     ! 13/03/03
    R1=R2+R3+R4+R5
    IF R1=0                                 ! VISPÂR NAV BIJUÐI IEÒÇMUMI
       R7=100                               ! PROPORCIJA
    ELSE
       R7=ROUND((R2+R3+r4)/R1*100,.01)      ! PROPORCIJA
    .
!    R7=ROUND((R2+R3+r4+R6)/R1*100,.01)     ! PROPORCIJA 13/03/03
    R21=R22+R23+R24+R25+r26                !
    R27=0                                  !?
    r28=ROUND(R21*(100-R7)/100,.01)
    R29=0                                  !?
    IF MINMAXSUMMA
       IF MINMAXSUMMA>0
          R13=MINMAXSUMMA
       ELSE
          R31=ABS(MINMAXSUMMA)
       .
    .
    PP=R21-r27-r28-R29+R30+R31             !
    SS=R8+R9+R10+R11+R12+R13               !
    IF PP > SS
      R14=PP-SS
      R15=0
    ELSE
      R15=SS-PP
      R14=0
    .
    IF R8 AND ~INRANGE(R8/R2*100-18,-3,3)
       KLUDA(85,R8/R2*100&' %')
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Priekðnodoklis (Ls)'&CHR(9)&'Aprçíinâtais PVN (Ls)'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        RSS = R1
        OUTA:LINE='KOPÇJÂ DARÎJUMU VÇRTÎBA {18}'&CHR(9)&RSS&CHR(9)&'1'
        ADD(OUTFILEANSI)
        RSS = R2
        OUTA:LINE='ar PVN 18% apl.darîj.(arî paðpat.) {6}'&CHR(9)&RSS&CHR(9)&'2'
        ADD(OUTFILEANSI)
        RSS = r4
        OUTA:LINE='ar PVN 0% apliekamie darîjumi {11}'&CHR(9)&RSS&CHR(9)&'3'
        ADD(OUTFILEANSI)
        RSS = r5
        OUTA:LINE='ar PVN neapliekamie darîjumi {12}'&CHR(9)&RSS&CHR(9)&'4'
        ADD(OUTFILEANSI)
        RSS=0
        OUTA:LINE=' {40}'&CHR(9)&RSS&CHR(9)&'5'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {40}'&CHR(9)&RSS&CHR(9)&'6'
        ADD(OUTFILEANSI)
        RSS = R7
        OUTA:LINE='PROPORCIJA (%) {26}'&CHR(9)&RSS&CHR(9)&'7'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        OUTA:LINE='APRÇÍINÂTAIS PVN'
        ADD(OUTFILEANSI)
        RSS = R8
        OUTA:LINE='par apliekamajiem darîjumiem {22}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'8'
        ADD(OUTFILEANSI)
        RSS = r10
        OUTA:LINE='par saò. pak. sask. ar likuma 3.p.11.d. {11}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'9'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        RSS = R21
        OUTA:LINE='PRIEKÐNODOKLIS, no tâ: {28}'&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'21'
        ADD(OUTFILEANSI)
        RSS = R22
        OUTA:LINE='par iekðz. ievest. precçm savas saimn.darb.nodr.  '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'22'
        ADD(OUTFILEANSI)
        RSS = R23
        OUTA:LINE='par precçm un pak.iekðzemç savas saimn.darb.nodr. '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'23'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        RSS = R24
        OUTA:LINE='par saò. pak. sask. ar 10.p. I.daïas 3.punktu     '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'24'
        ADD(OUTFILEANSI)
        RSS = r26
        OUTA:LINE='zemn. saimniecîbâm izmaksâtâ PVN 12% kompensâcija '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'25'
        ADD(OUTFILEANSI)
        RSS = r27
        OUTA:LINE='neizskaitâmais priekðnod.sask. ar lik. 10.p.9.d.  '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'26'
        ADD(OUTFILEANSI)
        RSS = r28
        OUTA:LINE='neizskaitâmais priekðnod.sask. ar lik. 10.p.10.d. '&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'27'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {65}'&CHR(9)&CHR(9)&CHR(9)&'28'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {65}'&CHR(9)&CHR(9)&CHR(9)&'29'
        ADD(OUTFILEANSI)
        RSS = R30
        RSSS= r12
        OUTA:LINE=' {20}'&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'30'&CHR(9)&RSSS&CHR(9)&'10'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        RSS = PP
        RSSS= SS
        OUTA:LINE='KOPSUMMA {42}'&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'[P]'&CHR(9)&RSSS&CHR(9)&'[S]'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{118}'
        ADD(OUTFILEANSI)
        RSS = R14
        OUTA:LINE='Ja P>S, tad ierakstît summu, kas atmaksâjama no'
        ADD(OUTFILEANSI)
        OUTA:LINE='budþeta vai attiecinâma uz nâk. taksâcijas periodu'&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'14'
        ADD(OUTFILEANSI)
        RSS = R15
        OUTA:LINE='Ja S>P, tad ierakstît aprçíinâto summu,'
        ADD(OUTFILEANSI)
        OUTA:LINE='maksâjama budþetâ {33}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&RSS&CHR(9)&'15'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'APSTIRPINU PVN APRÇÍINU:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atbildîgâ persona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Uzvârds:'&CHR(9)&CHR(9)&SYS:PARAKSTS1&CHR(9)&CHR(9)&CHR(9)&'Datums: '&format(DATUMS,@D6)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Paraksts:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Inspektora piezîmes'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Saòemðanas datums'
        ADD(OUTFILEANSI)
    END
    endpage(Report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
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
      CLOSE(OUTFILEANSI)
      RUN('WORDPAD '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a WordPad.exe')
      .
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
!------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
B_PVN_DEK03          PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
EOF                  BYTE
CG           STRING(10)
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)

RV1           DECIMAL(12,2)
RV2           DECIMAL(12,2)
RV3           DECIMAL(12,2)
RV4           DECIMAL(12,2)
RV5           DECIMAL(12,2)
RV6           DECIMAL(12,2)
RV7           DECIMAL(12,2)
RV8           DECIMAL(12,2)
RV9           DECIMAL(12,2)
RV10          DECIMAL(12,2)
RV11          DECIMAL(12,2)
RV12          DECIMAL(12,2)
RV13          DECIMAL(12,2)
RV14          DECIMAL(12,2)
RV15          DECIMAL(12,2)
RV21          DECIMAL(12,2)
RV22          DECIMAL(12,2)
RV23          DECIMAL(12,2)
RV24          DECIMAL(12,2)
RV25          DECIMAL(12,2)
RV26          DECIMAL(12,2)
RV27          DECIMAL(12,2)
RV28          DECIMAL(12,2)
RV29          DECIMAL(12,2)
RV30          DECIMAL(12,2)
RV31          DECIMAL(12,2)
SS           DECIMAL(12,2)
PP           DECIMAL(12,2)
APREKINATS   DECIMAL(12,2)

K31          REAL
K33          REAL
K34          REAL
K54          REAL
K56          REAL

R40          DECIMAL(12,2)
R41          DECIMAL(12,2)
R42          DECIMAL(12,2)
R43          DECIMAL(12,2)
R44          DECIMAL(12,2)
R45          DECIMAL(12,2)
R46          DECIMAL(12,2)
R47          DECIMAL(12,2)
R48          DECIMAL(12,2)
R49          DECIMAL(12,2)
R50          DECIMAL(12,2)
R51          DECIMAL(12,2)

R52          DECIMAL(12,2)
R53          DECIMAL(12,2)
R54          DECIMAL(12,2)
R55          DECIMAL(12,2)
R56          DECIMAL(12,2)

R60          DECIMAL(12,2)
R61          DECIMAL(12,2)
R62          DECIMAL(12,2)
R63          DECIMAL(12,2)
R64          DECIMAL(12,2)
R65          DECIMAL(12,2)
R66          DECIMAL(12,2)
R67          DECIMAL(12,2)
R68          DECIMAL(12,2)
R57          DECIMAL(12,2)
R58          DECIMAL(12,2)

R70          DECIMAL(12,2)
R80          DECIMAL(12,2)

PROP         REAL

DATUMS       DATE
G            STRING(4)
rmenesiem    string(8)
SUM1         STRING(11)

Q_TABLE      QUEUE,PRE(Q)
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(2)
             .

K_TABLE      QUEUE,PRE(K)
U_NR            ULONG
SUMMA           DECIMAL(12,2),DIM(2)
PVN             DECIMAL(12,2),DIM(2)
ANOTHER_K       BYTE
             .

SOURCE_FOR_50   DECIMAL(12,2)
SOURCE_FOR_51   DECIMAL(12,2)
SOURCE_FOR_41   DECIMAL(12,2)
SOURCE_FOR_42   DECIMAL(12,2)


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
PrintSkipDetails     BOOL,AUTO
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

report REPORT,AT(300,396,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(10,10,8000,7698),USE(?unnamed)
         STRING('Pielikums'),AT(6302,52,885,156),USE(?String92:5),TRN
         STRING('Ministru kabineta'),AT(6302,208,885,156),USE(?String92:2)
         STRING('2006.gada 10.janvâra'),AT(6302,365,1250,156),USE(?String92:3)
         STRING('Valsts ieòçmumu dienests'),AT(2656,573),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('noteikumiem Nr. 42'),AT(6302,521,1042,156),USE(?String92:4)
         STRING('Pievienotâs vçrtîbas nodokïa deklarâcija'),AT(2104,885),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('par taksâcijas gadu'),AT(2927,1146),USE(?String2:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas gads'),AT(6458,1563),USE(?String3),CENTER,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(208,1510,0,1042),USE(?Line3),COLOR(COLOR:Black)
         STRING(@S1),AT(6458,1823,188,208),USE(G[1]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6719,1823,188,208),USE(G[2]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6979,1823,188,208),USE(G[3]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(7240,1823,188,208),USE(G[4]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,1771,0,260),USE(?Line44:2),COLOR(COLOR:Black)
         STRING('Apliekamâs personas nosaukums'),AT(260,1563),USE(?String8),LEFT,FONT(,10,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6302,1510,0,1042),USE(?Line44:3),COLOR(COLOR:Black)
         LINE,AT(2344,1510,0,260),USE(?Line44),COLOR(COLOR:Black)
         STRING('Juridiskâ adrese'),AT(260,1823,1042,208),USE(?String10),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s50),AT(1406,1823,4219,208),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1771,6094,0),USE(?Line1:53),COLOR(COLOR:Black)
         LINE,AT(208,1510,6094,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Apliekamâs personas reìistrâcijas Nr. LV'),AT(260,2083,2604,208),USE(?String12),LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s13),AT(2865,2083,1146,208),USE(GL:REG_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2292,6094,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('Tâlrunis'),AT(260,2344,573,208),USE(?String10:2),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s15),AT(885,2344,1302,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,2969,0,469),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2448,1563,3854,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,3438,0,-469),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Taksâcijas gadâ aprçíinâtais nodoklis,'),AT(521,3594),USE(?String16),LEFT
         STRING(@N-_12.2),AT(5938,3698),USE(APREKINATS,,?APREKINATS:2),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamais nodoklis'),AT(521,4531,2292,208),USE(?String15),LEFT
         LINE,AT(6406,2031,1042,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(6406,1510,1042,0),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(7188,1771,0,260),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(6406,1771,1042,0),USE(?Line1:55),COLOR(COLOR:Black)
         LINE,AT(208,2552,6094,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(833,2292,0,260),USE(?Line44:4),COLOR(COLOR:Black)
         LINE,AT(5104,2969,2344,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(6927,1771,0,260),USE(?Line1:58),COLOR(COLOR:Black)
         STRING('Taksâcijas gadâ iesniegtajâs'),AT(521,3021,2292,208),USE(?String31),LEFT
         STRING('deklarâcijâs aprçíinâtâ nodokïa summa'),AT(521,3229,2396,208),USE(?String34),LEFT
         STRING(@N-_12.2),AT(5938,3135),USE(APREKINATS),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,3438,2344,0),USE(?Line1:12),COLOR(COLOR:Black)
         LINE,AT(5104,3542,2344,0),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(5104,4479,0,260),USE(?Line1:15),COLOR(COLOR:Black)
         LINE,AT(5104,4115,2344,0),USE(?Line1:26),COLOR(COLOR:Black)
         LINE,AT(5104,4375,2344,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('Budþetâ maksâjamais nodoklis'),AT(521,4167,2292,208),USE(?String15:2),LEFT
         STRING('-'),AT(5156,4531,365,208),USE(?String41:2),CENTER
         LINE,AT(5521,4479,0,260),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(5104,4740,2344,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(208,4948,7240,0),USE(?Line66),COLOR(COLOR:Black)
         STRING('Apstiprinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegtâ informâcija ir p' &|
             'ilnîga un patiesa.'),AT(417,5104),USE(?String39),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,4479,2344,0),USE(?Line1:17),COLOR(COLOR:Black)
         LINE,AT(7448,4479,0,260),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@s25),AT(385,5573),USE(sys:amats1),RIGHT(1)
         LINE,AT(1615,7292,3542,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@S1),AT(990,7448),USE(RS)
         LINE,AT(2292,5729,2552,0),USE(?Line1:24),COLOR(COLOR:Black)
         LINE,AT(208,4948,0,1458),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(208,6406,7240,0),USE(?Line35),COLOR(COLOR:Black)
         STRING('R : '),AT(729,7448),USE(?String99)
         LINE,AT(7448,4948,0,1458),USE(?Line1:22),COLOR(COLOR:Black)
         STRING(@s25),AT(2750,5781,,135),USE(SYS:PARAKSTS1),CENTER,FONT(,8,,FONT:regular+FONT:italic,CHARSET:BALTIC)
         STRING('Saòemðanas datums'),AT(260,7135),USE(?String73),LEFT
         STRING('atbildîgâ amatpersona'),AT(260,6719),USE(?String72:2)
         LINE,AT(1615,6875,5833,0),USE(?Line73),COLOR(COLOR:Black)
         STRING(@s5),AT(260,7448),USE(KKK)
         STRING('Datums :'),AT(781,6094),USE(?String68),LEFT
         LINE,AT(1354,6302,1719,0),USE(?Line67),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(3750,6927,,135),USE(?String46),FONT(,8,,FONT:regular+FONT:italic,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienesta'),AT(260,6510),USE(?String72)
         STRING(@d06.),AT(1823,6094),USE(DATUMS),LEFT
         LINE,AT(7448,4115,0,260),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(5521,4115,0,260),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(7448,3542,0,469),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(5104,4010,2344,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('ievçrojot veiktâs korekcijas'),AT(521,3802),USE(?String16:2),LEFT
         STRING('+'),AT(5156,4167,365,208),USE(?String41),CENTER
         LINE,AT(6667,1771,0,260),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5104,3542,0,469),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(208,2031,6094,0),USE(?Line11:9),COLOR(COLOR:Black)
         LINE,AT(6406,1510,0,521),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7448,1510,0,521),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(5104,4115,0,260),USE(?Line3:4),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  BIND('MEN_NR',MEN_NR)
  BIND('kkk',kkk)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'PVN gada atskaite'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      G=FORMAT(GADS,@N4)
      CG = 'K1000'
      SET(GGK:DAT_key,GGK:DAT_KEY)
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      IF ErrorCode()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ErrorCode()
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
      ELSE           !RTF
        IF ~OPENANSI('PVNDKLRG.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PIEVIENOTÂS VÇRTÎBAS DEKLARÂCIJA'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE='Maksâtâja saîsinâtais nosaukums'&CHR(9)&CLIENT&CHR(9)&CHR(9)&CHR(9)&'Taksâcijas periods'
        ADD(OUTFILEANSI)
        OUTA:LINE='Adrese'&CHR(9)&GL:ADRESE&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'GADS'
        ADD(OUTFILEANSI)
        OUTA:LINE='PVN reìistrâcijas Nr. LV'&CHR(9)&GL:REG_NR&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&G[1]&CHR(9)&G[2]&CHR(9)&G[3]&CHR(9)&G[4]
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
         IF GGK:DATUMS < DATE(5,1,2004) !VECA DEKLARACIJA
           IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
              CASE GGK:D_K
          !************************ SAMAKSÂTS PVN ********
              OF 'D'                                     ! SAMAKSÂTS PVN
                CASE GGK:PVN_TIPS
                OF '1'                                   ! P4=1 budþetam
          !       RPT:ANKOP+=GGK:SUMMA
                OF '2'                                   ! P4=2 IMPORTS
                  RV22+=GGK:SUMMA                     !
                OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
                OROF ''
                  IF GGK:PVN_PROC=12                           ! PIEÐÛTS 12% ZEMNIEKIEM
                     RV26+=GGK:SUMMA                  !
                  ELSE
                     RV23+=GGK:SUMMA
                  .
                .
          !************************ SAÒEMTS PVN ********
              OF 'K'                                     ! SAÒEMTS PVN
                CASE GGK:PVN_TIPS
                OF '1'                                   ! P4=1 budþetam
          !       RPT:ANKOP-=GGK:SUMMA                     ! AN NO FIN NOD.
                OF '2'                                   ! P4=2 IMPORTS
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                OF '0'                                   ! SAÒEMTS,REALIZÇJOT
                OROF ''
                OROF 'N'
                  CASE GGK:PVN_PROC
                  OF 18
                     RV8+=GGK:SUMMA
                  OF 9
                     RV9+=GGK:SUMMA
                  ELSE
                     KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                     RV8+=GGK:SUMMA                      ! LIETOTÂJA KÏÛDA
                  .
                .
              .
         !************************ Neapliekamie darîjumi ********
           ELSIF INSTRING(GGK:BKK[1],'568') AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
              C#=GETKON_K(GGK:BKK,2,1)
              LOOP R#=1 TO 2
                 CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                 OF 4
                    RV4 += GGK:SUMMA
                 OF 5
                    RV5 += GGK:SUMMA
                 OF 6
                    RV6 += GGK:SUMMA
                 ELSE
        !           KLÛDA
                 .
              .
           .
        ELSE  !JAUNAA DEKLARAACIJA
           IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
              CASE GGK:D_K
          !************************ SAMAKSÂTS PVN ********
              OF 'D'                                     ! SAMAKSÂTS PVN
                CASE GGK:PVN_TIPS
                OF '1'                                   ! PVN_TIPS=1 budþetam
          !       RPT:ANKOP+=GGK:SUMMA
                OF '2'                                   ! PVN_TIPS=2 PREÈU IMPORTS ~ES
                  R61+=GGK:SUMMA
                OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
                OROF ''
                OROF 'N'                                 ! JA PALICIS
                  IF GGK:PVN_PROC=12                     ! PIEÐÛTS 12% ZEMNIEKIEM
                     r65+=GGK:SUMMA
                  ELSE
                     IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                        R64+=GGK:SUMMA
                     ELSE
                        R62+=GGK:SUMMA
                     .
                  .
                OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                  R63+=GGK:SUMMA
   !             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
   !               R25+=GGK:SUMMA
                OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
                  R67+=GGK:SUMMA
                .
          !************************ SAÒEMTS PVN ********
              OF 'K'                                     ! SAÒEMTS PVN
          ! GGK:DAT_KEY= DATUMS-U_NR-D/K
                CASE GGK:PVN_TIPS
                OF '1'                                   ! PVN_TIPS=1 budþetam
          !       RPT:ANKOP-=GGK:SUMMA                     ! AN NO FIN NOD.
                OF '2'                                   ! PVN_TIPS=2 IMPORTS
                  KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                OF '0'                                   ! SAÒEMTS,REALIZÇJOT
                OROF ''
                OROF 'N'                                 ! JA PALICIS
                  CASE GGK:PVN_PROC
                  OF 18
                     IF GETPAR_K(GGK:PAR_NR,0,20)='C'    ! PRECES NO ES
                        Q:U_NR=GGK:U_NR
                        GET(Q_TABLE,Q:U_NR)
                        IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
                           Q:PVN[1]+=GGK:SUMMA
                           PUT(Q_TABLE)
                        ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                           SOURCE_FOR_50+=GGK:SUMMA
                        .
                        R55+=GGK:SUMMA
                     ELSE
                        K:U_NR=GGK:U_NR
                        GET(K_TABLE,K:U_NR)
                        IF ~ERROR() !D261..(KA) IR JÂBÛT JAU ATRASTAM, JA TÂDS IR
                           K:PVN[1]+=GGK:SUMMA
                           PUT(K_TABLE)
                        ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                           SOURCE_FOR_41+=GGK:SUMMA
                        .
                        R52+=GGK:SUMMA
                     .
                  OF 5
                     IF GETPAR_K(GGK:PAR_NR,0,20)='C'
                        Q:U_NR=GGK:U_NR
                        GET(Q_TABLE,Q:U_NR)
                        IF ~ERROR() !D213.. IR JÂBÛT JAU ATRASTIEM, JA TÂDI IR
                           Q:PVN[2]+=GGK:SUMMA
                           PUT(Q_TABLE)
                        ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                           SOURCE_FOR_51+=GGK:SUMMA
                        .
                        R56+=GGK:SUMMA
                     ELSE
                        K:U_NR=GGK:U_NR
                        GET(K_TABLE,K:U_NR)
                        IF ~ERROR() !D261..(KA) IR JÂBÛT JAU ATRASTAM, JA TÂDS IR
                           K:PVN[2]+=GGK:SUMMA
                           PUT(K_TABLE)
                        ELSE        !DIEVS VIÒU ZINA, KUR AIZKONTÇTS,BÛS JÂRÇÍINA ANALÎTISKI
                           SOURCE_FOR_42+=GGK:SUMMA
                        .
                        R53+=GGK:SUMMA
                     .
                  ELSE
                     KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
                     SOURCE_FOR_41+=GGK:SUMMA   ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%
                     R52+=GGK:SUMMA
                  .
                OF 'I'                                   ! PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                  R54+=GGK:SUMMA
   !             OF 'P'                                   ! PVN_TIPS=P IEVESTIE P/L
   !               R11+=GGK:SUMMA
                OF 'A'                                   ! PVN_TIPS=A MÇS ATGRIEÞAM PRECI
                  R57+=GGK:SUMMA
                .
              .
         !************************ Neapliekamie darîjumi ********
           ELSIF GETKON_K(GGK:BKK,2,6) AND GGK:D_K='K' ! IR DEFINÇTI NEAPLIEKAMIE DARÎJUMI
              LOOP R#=1 TO 2
                 IF KON:PVND[R#]
                    CASE KON:PVND[R#]        ! Neapliekamie darîjumi
                    OF 43
                       R43 += GGK:SUMMA
                    OF 44                    
                       R44 += GGK:SUMMA
                    OF 45
                       R45 += GGK:SUMMA      ! ES PRECES
                    OF 46
                       R46 += GGK:SUMMA
                    OF 47
                       R47 += GGK:SUMMA      ! ES JAUNAS A/M
                    OF 48
                       R48 += GGK:SUMMA
                    OF 49
                       R49 += GGK:SUMMA
                    .
                 .
              .
         !************************ MEKLÇJAM PRETKONTUS PRECÇM NO ES ********
           ELSIF GGK:BKK[1:3]='213' AND GGK:D_K='D' AND GETPAR_K(GGK:PAR_NR,0,20)='C' ! ES
           ! GGK:DAT_KEY= DATUMS-U_NR-D/K
              Q:U_NR=GGK:U_NR
              CLEAR(Q:PVN)
              CLEAR(Q:SUMMA)
              GET(Q_TABLE,Q:U_NR)
              IF ERROR()
                 DO FILL_Q_TABLE
                 ADD(Q_TABLE)
                 SORT(Q_TABLE,Q:U_NR)
              ELSE
                 DO FILL_Q_TABLE
                 PUT(Q_TABLE)
              .
         !******** MEKLÇJAM 261..un 61... KONTUS KASES AP, PÂRB. VAI NAV CITU KONTÇJUMU ******
           ELSIF GGK:BKK[1:3]='261' AND GGK:D_K='D' ! VAR BÛT KASES AP
           ! GGK:DAT_KEY= DATUMS-U_NR-D/K
              K:U_NR=GGK:U_NR
              CLEAR(K:PVN)
              CLEAR(K:SUMMA)
              K:ANOTHER_K=FALSE
              GET(K_TABLE,K:U_NR)
              IF ERROR()
                 K:U_NR=GGK:U_NR
                 ADD(K_TABLE)
                 SORT(K_TABLE,K:U_NR)
              .
           ELSIF GGK:BKK[1:2]='61' AND GGK:D_K='K' ! VAR BÛT 61... NO KASES AP
           ! GGK:DAT_KEY= DATUMS-U_NR-D/K
              K:U_NR=GGK:U_NR
              GET(K_TABLE,K:U_NR)
              IF ~ERROR()  ! D261 IR ATRASTS
                 IF GGK:PVN_PROC=5
                    K:SUMMA[2]+=GGK:SUMMA
                 ELSIF GGK:PVN_PROC=18
                    K:SUMMA[1]+=GGK:SUMMA
                 ELSE
                    KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
                    K:SUMMA[1]+=GGK:SUMMA       ! LIETOTÂJA KÏÛDA,PIEÒEMAM, KA 18%
                    K:ANOTHER_K=TRUE            ! LABÂK RÇÍINÂSIM ANALÎTISKI
                 .
                 PUT(K_TABLE)
              .
           ELSIF GGK:D_K='K' ! CITI K KONTÇJUMI
           ! GGK:DAT_KEY= DATUMS-U_NR-D/K
              K:U_NR=GGK:U_NR
              GET(K_TABLE,K:U_NR)
              IF ~ERROR()  
                 K:ANOTHER_K=TRUE
                 PUT(K_TABLE)
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
  IF TODAY() > DATE(4,30,YEAR(B_DAT)+1)
     DATUMS=DATE(4,30,YEAR(B_DAT)+1)
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    RV2=(RV8*100)/18                         ! ANALÎTISKI 18%
    RV3=(RV9*100)/9                          ! ANALÎTISKI  9%
    RV1=RV2+RV3+RV4+RV5+RV6
!    RV7=ROUND((RV2+RV3+RV4)/RV1*100,.01)        ! PROPORCIJA
    RV7=ROUND((RV2+RV3+RV4+RV6)/RV1*100,.01)        ! PROPORCIJA
    RV21=RV22+RV23+RV24+RV25+RV26
    RV27=0                                  !?
    RV28=ROUND(RV21*(100-RV7)/100,.01)
    RV29=0                                  !?
    RV30=0                                  !?
    RV12=0                                  !?
!    IF MINMAXSUMMA
!       IF MINMAXSUMMA>0
!          RV13=MINMAXSUMMA
!       ELSE
!          RV31=ABS(MINMAXSUMMA)
!       .
!    .
    PP=RV21-RV27-RV28-RV29-RV30+RV31
    SS=RV8+RV9+RV10+RV11+RV12+RV13
    APREKINATS=SS-PP


!    R41=(R52*100)/18                               ! ANALÎTISKI 18%
!    R42=(R53*100)/5                                ! ANALÎTISKI  5%
    GET(K_TABLE,0)
    LOOP I# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
!       STOP(K:PVN[1] &' '& K:SUMMA[1] &' '& K:ANOTHER_K)
       IF K:PVN[1] AND K:SUMMA[1] AND ~K:ANOTHER_K !IR PVN 18%,ATRASTS D261.. KONTS,NAV CITU K KONTU BEZ K61...
          R41+=K:SUMMA[1]
       ELSE
          SOURCE_FOR_41+=K:PVN[1]
       .
       IF K:PVN[2] AND K:SUMMA[2] AND ~K:ANOTHER_K !IR PVN 5%,ATRASTS D261.. KONTS,NAV CITU K KONTU BEZ K61...
          R42+=K:SUMMA[2]
       ELSE
          SOURCE_FOR_42+=K:PVN[2]
       .
    .
    R41+=(SOURCE_FOR_41*100)/18               ! ANALÎTISKI 18% ES
    R42+=(SOURCE_FOR_42*100)/5                ! ANALÎTISKI  5% ES
!    R50=(R55*100)/18                              ! ANALÎTISKI 18% ES
!    R51=(R56*100)/5                               ! ANALÎTISKI  5% ES
    GET(Q_TABLE,0)
    LOOP I# = 1 TO RECORDS(Q_TABLE)
       GET(Q_TABLE,I#)
       IF Q:PVN[1]                                 !IR 18%
!          stop('pvn='&Q:PVN[1]&' '&Q:SUMMA[1]&'DELTA18='&(Q:SUMMA[1]/100)*18-Q:PVN[1])
          IF INRANGE((Q:SUMMA[1]/100)*18-Q:PVN[1],-0.005,0.005) !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R50+=Q:SUMMA[1]
          ELSE
             SOURCE_FOR_50+=Q:PVN[1]
          .
       .
       IF Q:PVN[2]                                  !IR 5%
!          stop('pvn='&Q:PVN[2]&' DELTA5='&(Q:SUMMA[2]/100)*18-Q:PVN[2])
          IF INRANGE((Q:SUMMA[2]/100)*5-Q:PVN[2],-0.005,0.005)  !UZ VIENU DOKUMENTU PVN KÏÛDA NEVAR BÛT LIELÂKA
             R51+=Q:SUMMA[2]
          ELSE
             SOURCE_FOR_51+=Q:PVN[2]
          .
       .
    .
    R50+=(SOURCE_FOR_50*100)/18               ! ANALÎTISKI 18% ES
    R51+=(SOURCE_FOR_51*100)/5                ! ANALÎTISKI  5% ES

    R40=R41+R42+R43+R49+R50+R51
    IF R40=0                                 ! VISPÂR NAV BIJUÐI IEÒÇMUMI
!       PROP=100                              ! PROPORCIJA
       PROP=0                                ! PROPORCIJA
    ELSE
!       PROP=ROUND((R41+R42+R43)/(R41+R42+R43+R49)*100,.01) ! PROPORCIJA
        PROP=ROUND(R49/R40*100,.01) ! PROPORCIJA
    .
    R60=R61+R62+R63+R64+R65
!    R66=ROUND(R60*(100-PROP)/100,.01)
    R66=ROUND(R60*PROP/100,.01)
    IF MINMAXSUMMA                           !KOKMATERIÂLI
       IF MINMAXSUMMA>0
          R58=MINMAXSUMMA
       ELSE
          R68=ABS(MINMAXSUMMA)
       .
    .
    PP=R60-R66+R67+R68                       !
    SS=R52+R53+R54+R55+R56+R57+R58           !
    APREKINATS+=SS-PP

    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)                              !  PRINT DETAIL LINES
    ELSE
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}| Pievienotâs vçrtîbas |'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}|   nodoklis (latos)   |'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Aprçíinâtais {60}|      '&FORMAT(APREKINATS,@N_12.2)&' {5}|'
        ADD(OUTFILEANSI)
!        SUM1 = RSG
        OUTA:LINE=' {10}Samaksâtais '&GADS&'. gadâ {50}|      '&FORMAT(APREKINATS,@N_12.2)&' {5}|'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Budþetâ maksâjamais vai no budþeta atmaksâjamais {24}| {22}|'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {6}Apstirpinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegta informâcija ir pilnîga un patiesa'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atbildîgâ persona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Uzvârds:'&CHR(9)&CHR(9)&SYS:PARAKSTS1&CHR(9)&CHR(9)&CHR(9)&'Datums: '&format(DATUMS,@D6)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Paraksts:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Inspektora piezîmes'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Saòemðanas datums'
        ADD(OUTFILEANSI)
    END
    endpage(Report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
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
      CLOSE(OUTFILEANSI)
      RUN('WORDPAD '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a WordPad.exe')
      .
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
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
  FREE(Q_TABLE)
  FREE(K_TABLE)
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
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
  IF ERRORCODE() OR GGK:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
FILL_Q_TABLE ROUTINE
     Q:U_NR=GGK:U_NR
     IF GGK:PVN_PROC=5
        Q:SUMMA[2]+=GGK:SUMMA
     ELSIF GGK:PVN_PROC=18
        Q:SUMMA[1]+=GGK:SUMMA
     ELSE
        KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.)&' '&GGK:BKK)
        Q:SUMMA[1]+=GGK:SUMMA !LIETOTÂJA KÏÛDA, PIEÒEMAM, KA 18%
     .



N_InvAktsRez         PROCEDURE                    ! Declare Procedure
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

NOMEN                STRING(21)
INV8                 STRING(8)
FAKT                 DECIMAL(12,2)
CENA                 DECIMAL(12,3)
KOPA                 STRING(10)
DAUDZUMSK            DECIMAL(12,2)
FAKTK                DECIMAL(12,2)
SUMMAK               DECIMAL(12,2)
SUMMAFAKT            DECIMAL(12,2)
SUMMAFAKTK           DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
NOL_NR               BYTE
NOL_DAT              LONG

K_TABLE              QUEUE,PRE(K)
NOS                   STRING(3)
SUMMA                 DECIMAL(12,2)
                     .

DAUD                STRING(6)
SUMMAS              STRING(12)
CENAS               STRING(10)

NOS                  STRING(3)
MER                  STRING(7)
SUMMA_IZTR          DECIMAL(12,2)
SUMMA_PARP          DECIMAL(12,2)
STARPIBA            DECIMAL(12,2)
STARPIBALS          DECIMAL(12,2)
STARPIBAK           DECIMAL(12,2)
IZTRUKUMS           DECIMAL(12,2)
PARPALIKUMS         DECIMAL(12,2)
STARPIBALSK         DECIMAL(12,2)
NOM_SER             STRING(20)
NOMENKL             STRING(21)
RET                 BYTE
DOKDATUMS           STRING(25)
AKTS_NR             DECIMAL(3)

!-----------------------------------------------------------------------------
Process:View         VIEW(INVENT)
                       PROJECT(INV:NOMENKLAT)
                       PROJECT(INV:KODS)
                       PROJECT(INV:KATALOGA_NR)
                       PROJECT(INV:NOSAUKUMS)
                       PROJECT(INV:NOS_A)
                       PROJECT(INV:CENA)
                       PROJECT(INV:ATLIKUMS)
                       PROJECT(INV:ATLIKUMS_F)
                       PROJECT(INV:X)
                       PROJECT(INV:ACC_KODS)
                       PROJECT(INV:ACC_DATUMS)
                     END

report REPORT,AT(198,390,8000,10802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,255,8000,135),USE(?unnamed)
         STRING(@P<<<#. lapaP),AT(7135,0,573,140),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,135,7604,0),USE(?Line1:10),COLOR(COLOR:Black)
       END
PAGE_HEAD0 DETAIL,AT(,,,3010),USE(?unnamed:4)
         STRING(@s45),AT(260,177,4323,200),USE(CLIENT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('_{32}'),AT(5625,781,1875,260),USE(?String2:14),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(5521,427,2031,260),USE(DOKDATUMS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Inventarizâcijas akts  Nr'),AT(260,625,1979,198),USE(?String2:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('_{10}'),AT(2188,625,990,198),USE(?String2:3),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisijas locekïi'),AT(573,1667,1667,260),USE(?String2:7),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1927,2031,260),USE(?String2:8),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,2188,2031,260),USE(?String2:9),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('un konstatçja sekojoðo :'),AT(573,2708,1667,260),USE(?String2:11),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,2448,2031,260),USE(?String2:10),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(208,885,677,198),USE(NOL_dat),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('veikta preèu krâjumu un naudas lîdzekïu inventarizâcija.'),AT(938,885,3802,198),USE(?String2:4), |
             LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Izveidota komisija sekojoðâ sastâvâ :'),AT(208,1146,2552,198),USE(?String2:5),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('"APSTIPRINU"'),AT(5771,167,1458,260),USE(?String2:12),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava:'),AT(260,396,833,198),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(1146,396,260,198),USE(NOL_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisijas priekðsçdçtâjs'),AT(573,1406,1667,260),USE(?String2:6),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1406,2031,260),USE(?String2:30),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2240,1667,2031,260),USE(?String2:31),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD DETAIL,AT(,,,500),USE(?unnamed:5)
         LINE,AT(3594,0,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(7760,0,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,0,7656,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s20),AT(146,52,1563,208),USE(NOM_SER),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1740,0,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(1781,156,1302,208),USE(?String19:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3146,0,0,521),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('Daudz.'),AT(3667,52,521,208),USE(?String19:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(4240,52,490,208),USE(?String19:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4240,260,490,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4781,52,573,208),USE(?String19:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz.'),AT(5458,52,521,208),USE(?String19:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6031,52,573,208),USE(?String19:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6615,0,0,521),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,521),USE(?Line2:20),COLOR(COLOR:Black)
         STRING('Starpîba'),AT(6656,156,521,208),USE(?String19:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Starpîba'),AT(7229,52,521,208),USE(?String19:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5990,0,0,521),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('Mçrv.'),AT(3167,156,410,208),USE(?String19:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(146,260,1563,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc dok.'),AT(3667,260,521,208),USE(?String19:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4781,260,573,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc fakta'),AT(5458,260,521,208),USE(?String19:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc fakta'),AT(6031,260,573,208),USE(?String19:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(7260,260,490,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,469,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,0,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         STRING(@n-_12.2),AT(3625,0,570,156),USE(INV:ATLIKUMS),RIGHT
         LINE,AT(4219,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@n_12.2),AT(4240,0,469,156),USE(INV:cena),RIGHT
         LINE,AT(4740,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(4760,0,583,156),USE(summa),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7760,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(1740,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5406,0,573,156),USE(INV:ATLIKUMS_F),RIGHT
         LINE,AT(5990,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(6010,0,580,156),USE(SUMMAFAKT),RIGHT
         LINE,AT(6615,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(6667,0,469,156),USE(STARPIBA),RIGHT
         STRING(@s26),AT(1771,0,1350,156),USE(INV:nosaukums),LEFT
         LINE,AT(3146,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s7),AT(3177,0,365,156),USE(nom:mervien),LEFT
         LINE,AT(7188,-10,0,198),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7219,0,521,156),USE(STARPIBALS),RIGHT
         LINE,AT(3594,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@s21),AT(156,10,1563,156),USE(nomenkl),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,115),USE(?Line30:4),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,115),USE(?Line30:3),COLOR(COLOR:Black)
         LINE,AT(7760,0,0,115),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(1740,0,0,63),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,115),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(4219,0,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(3146,0,0,63),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,63),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(104,0,0,115),USE(?Line22),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,698),USE(?unnamed:2)
         LINE,AT(7760,-10,0,650),USE(?Line32:5),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7219,10,521,156),USE(STARPIBALSK),RIGHT
         STRING(@n-_12.2),AT(6010,10,583,156),USE(SUMMAFAKTK),RIGHT
         LINE,AT(5365,-10,0,650),USE(?Line32:4),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,650),USE(?Line32:6),COLOR(COLOR:Black)
         LINE,AT(6615,-10,0,650),USE(?Line32:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(6667,10,469,156),USE(STARPIBAK),RIGHT
         LINE,AT(7188,-10,0,650),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,650),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,650),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,650),USE(?Line32),COLOR(COLOR:Black)
         STRING(@s10),AT(156,10,729,156),USE(kopa),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(3458,10,729,156),USE(daudzumsk),RIGHT
         STRING(@n-_12.2),AT(4760,10,583,156),USE(summaK),RIGHT
         STRING(@n-_12.2),AT(5406,10,573,156),USE(faktk),RIGHT
         LINE,AT(104,208,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('t.s. iztrûkums'),AT(156,260,,156),USE(?String65),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(7219,260,521,156),USE(summa_iztr),RIGHT
         STRING(@n-_12.2),AT(6667,260,469,156),USE(IZTRUKUMS),RIGHT
         LINE,AT(104,417,7656,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7219,469,521,156),USE(summa_parp),RIGHT
         STRING(@n-_12.2),AT(6667,469,469,156),USE(PARPALIKUMS),RIGHT
         STRING('       pârpalikums'),AT(156,469,,156),USE(?String65:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,625,7656,0),USE(?Line1:12),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,3563),USE(?unnamed:3)
         STRING('_{25}'),AT(2083,2969,2031,208),USE(?String2:27),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sastadîja:'),AT(417,3385),USE(?String60)
         STRING(@s8),AT(938,3385),USE(ACC_kods),LEFT
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,3177,2031,208),USE(?String2:28),LEFT
         STRING('- _{25}'),AT(2188,2292,2031,208),USE(?String2:24),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,2500,2031,208),USE(?String2:25),LEFT
         STRING('- _{25}'),AT(2188,1927,2031,208),USE(?String2:22),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,2135,2031,208),USE(?String2:23),LEFT
         LINE,AT(260,469,7500,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(208,625,7552,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(208,781,7552,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Komisijas priekðsçdçtâjs - _{25}'),AT(521,885,3802,156),USE(?String2:16),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('- _{25}'),AT(2188,1563,2031,208),USE(?String2:20),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,1771,2031,208),USE(?String2:21),LEFT
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,1042,2031,208),USE(?String2:17),LEFT
         STRING('Slçdziens :'),AT(260,156,781,208),USE(?String2:15),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Komisijas locekïi {13}- _{25}'),AT(521,1198,3802,208),USE(?String2:18),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Ðî inventarizâcijas akta datus un aprçíinus pârbaudîju'),AT(521,2708,3646,260),USE(?String2:26), |
             LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('/ amats, vârds, uzvârds, paraksts /'),AT(2188,1406,2031,208),USE(?String2:19),LEFT
         STRING('RS:'),AT(1615,3385),USE(?String59)
         STRING(@s1),AT(1823,3385),USE(RS),CENTER
         STRING(@s25),AT(313,2969,1823,260),USE(DOKDATUMS,,?DOKDATUMS:2),RIGHT,FONT(,10,,FONT:regular)
         LINE,AT(1042,313,6719,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11100,8000,63)
         LINE,AT(104,0,7656,0),USE(?Line1:9),COLOR(COLOR:Black)
       END
     END

Virsraksts_w WINDOW(' '),AT(,,140,115),FONT('MS Sans Serif',10,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Inventarizâcijas Akts Nr :'),AT(12,15),USE(?String1)
       ENTRY(@n4),AT(92,14,20,10),USE(AKTS_NR,,?AKTS_NR:V)
       BUTTON('OK'),AT(100,95,35,14),USE(?Ok_V),DEFAULT
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
  BIND('CYCLENOM',CYCLENOM)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF INVENT::Used = 0
    CheckOpen(INVENT,1)
  END
  INVENT::Used += 1
  INV8=SUB(INVNAME,LEN(CLIP(INVNAME))-12+1,8)
  IF INV8[2] > '9'
     NOL_NR=VAL(INV8[2])-55
  ELSE
     NOL_NR=INV8[2]
  .
  NOL_DAT=DEFORMAT(INV8[3:8],@D11)    ! 'I'&NOLIK&FORMAT(B_DAT,@D11)&'.TPS'
  DOKDATUMS=GETDOKDATUMS(NOL_DAT)
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
  OPEN(VIRSRAKSTS_W)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OK_V
        BREAK
     .
  .
  CLOSE(VIRSRAKSTS_W)

  BIND(INV:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(INVENT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Inventarizâcija'
  ?Progress:UserString{Prop:Text}=''
  SEND(INVENT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(INV:NOM_KEY,INV:NOM_KEY)
      Process:View{Prop:Filter} = ''
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
         PRINT(RPT:PAGE_HEAD0)
         PRINT(RPT:PAGE_HEAD)
      ELSE
          IF ~OPENANSI('INVAKTSR.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' {10}APSTIPRINU'
          ADD(OUTFILEANSI)
          OUTA:LINE='Noliktava: '&CLIP(LOC_NR)&' {40}'&DOKDATUMS
          ADD(OUTFILEANSI)
          OUTA:LINE=' '
          ADD(OUTFILEANSI)
          OUTA:LINE='INVENTARIZÂCIJAS AKTS Nr '&FORMAT(AKTS_NR,@N3B)&' {20}________________________________'
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Mçrv.'&CHR(9)&|
!             'Daudzums pçc'&CHR(9)&'Cena ('&nokl_cp&'), Ls'&CHR(9)&'Summa,Ls'&CHR(9)&'Daudzums'&CHR(9)&'Summa'|
!             &CHR(9)&'Starpîba'&CHR(9)&'Starpîba'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Mçrv.'&CHR(9)&|
             'Daudzums pçc'&CHR(9)&'Cena ('&nokl_cp&'), '&val_uzsk&CHR(9)&'Summa,'&val_uzsk&CHR(9)&'Daudzums'&CHR(9)&'Summa'|
             &CHR(9)&'Starpîba'&CHR(9)&'Starpîba'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'fin.dokum.'&CHR(9)&'bez PVN'&CHR(9)&CHR(9)&'pçc fakta'|
!             &CHR(9)&'pçc fakta'&CHR(9)&'Ls'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'fin.dokum.'&CHR(9)&'bez PVN'&CHR(9)&CHR(9)&'pçc fakta'|
             &CHR(9)&'pçc fakta'&CHR(9)&val_uzsk
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Mçrv.'&CHR(9)&|
!             'Daudzums pçc fin.dokum.'&CHR(9)&'Cena ('&nokl_cp&'), Ls bez PVN'&CHR(9)&'Summa,Ls'&CHR(9)&|
!             'Daudzums pçc fakta'&CHR(9)&'Summa pçc fakta'&CHR(9)&'Starpîba'&CHR(9)&'Starpîba Ls'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Mçrv.'&CHR(9)&|
             'Daudzums pçc fin.dokum.'&CHR(9)&'Cena ('&nokl_cp&'), '&val_uzsk&' bez PVN'&CHR(9)&'Summa,'&val_uzsk&CHR(9)&|
             'Daudzums pçc fakta'&CHR(9)&'Summa pçc fakta'&CHR(9)&'Starpîba'&CHR(9)&'Starpîba '&val_uzsk
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(INV:NOMENKLAT)
           IF ~(F:KRI AND ~(INV:ATLIKUMS OR INV:ATLIKUMS_F))
              SUMMA = INV:CENA*INV:ATLIKUMS
              SUMMAFAKT = INV:CENA*INV:ATLIKUMS_F
              NOMENKL   = GETNOM_K(INV:NOMENKLAT,2,RET)
              STARPIBA   = INV:ATLIKUMS-INV:ATLIKUMS_F
              STARPIBALS = STARPIBA*INV:CENA
              IF F:DBF='W'
                 PRINT(RPT:DETAIL)
              ELSE !EXCEL,WORD
                 OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:KATALOGA_NR&CHR(9)&LEFT(FORMAT(NOM:KODS,@N_13))&CHR(9)&NOM:NOS_P&|
                 CHR(9)&NOM:MERVIEN&CHR(9)&LEFT(FORMAT(INV:ATLIKUMS,@N-_14.3))&CHR(9)&LEFT(FORMAT(INV:CENA,@N_12.3))&|
                 CHR(9)&LEFT(FORMAT(SUMMA,@N-_14.2))&CHR(9)&LEFT(FORMAT(INV:ATLIKUMS_F,@N-_14.3))&CHR(9)&|
                 LEFT(FORMAT(SUMMAFAKT,@N-_14.2))&CHR(9)&LEFT(FORMAT(STARPIBA,@N-_14.2))&CHR(9)&|
                 LEFT(FORMAT(STARPIBALS,@N-_14.2))
                 ADD(OUTFILEANSI)
              .
              DAUDZUMSK += INV:ATLIKUMS
              SUMMAK    += SUMMA
              SUMMAFAKTK += SUMMAFAKT
              FAKTK     += INV:ATLIKUMS_F
              STARPIBAK += STARPIBA
              STARPIBALSK += STARPIBALS
              IF STARPIBA >0
                   IZTRUKUMS += STARPIBA
                   SUMMA_IZTR += INV:CENA*STARPIBA
              ELSIF STARPIBA <0
                   PARPALIKUMS += STARPIBA
                   SUMMA_PARP += INV:CENA*STARPIBA
              END
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
  IF SEND(INVENT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
       PRINT(RPT:RPT_FOOT1)
       KOPA = 'KOPÂ'
       PRINT(RPT:RPT_FOOT2)
       PRINT(RPT:RPT_FOOT3)
       ENDPAGE(report)
    ELSE !EXCEL,WORD
       KOPA = 'KOPÂ'
       OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&|
       CHR(9)&LEFT(FORMAT(SUMMAK,@N-_14.2))&CHR(9)&LEFT(FORMAT(FAKTK,@N-_14.3))&CHR(9)&|
       LEFT(FORMAT(SUMMAFAKTK,@N-_14.2))&CHR(9)&LEFT(FORMAT(STARPIBAK,@N-_14.2))&CHR(9)&|
       LEFT(FORMAT(STARPIBALSK,@N-_14.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    .
    IF F:DBF='W'   !WMF
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
       .
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
    INVENT::Used -= 1
    IF INVENT::Used = 0 THEN CLOSE(INVENT).
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
  IF ERRORCODE() OR CYCLENOM(INV:NOMENKLAT)=2
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'INVENT')
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
