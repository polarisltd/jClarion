                     MEMBER('winlats.clw')        ! This is a MEMBER module
K_REALIZ             PROCEDURE                    ! Declare Procedure
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

NOL_TEX                 STRING(80)
DAUDZUMS                DECIMAL(11,3),DIM(12)
SUMMAM                  DECIMAL(11,2),DIM(12)
I_DAUDZUMS              DECIMAL(11,3),DIM(12)
DAUDZUMSK               DECIMAL(11,3),DIM(12)
SUMMAK                  DECIMAL(11,2),DIM(12)
I_DAUDZUMSK             DECIMAL(11,3),DIM(12)
DAT                     LONG
LAI                     LONG
NOS_S                   STRING(30)
RPT_NOMENKLAT           STRING(21)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(198,1844,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,302,12000,1542)
         STRING(@s45),AT(2031,156,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('REALIZÂCIJAS KOPSAVILKUMS'),AT(6406,156,3073,260),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(2344,490,6198,208),USE(NOL_TEX),CENTER
         STRING(@P<<<#. lapaP),AT(10260,625,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(156,781,10885,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(208,833,2083,156),USE(?NOMENKLAT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma K_REALIZ'),AT(9323,625,,156),USE(?String130)
         STRING('janvâris'),AT(2344,833,677,156),USE(?NOMENKLAT:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('februâris'),AT(3073,833,677,156),USE(?NOMENKLAT:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('marts'),AT(3802,833,677,156),USE(?NOMENKLAT:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprîlis'),AT(4531,833,677,156),USE(?NOMENKLAT:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('maijs'),AT(5260,833,677,156),USE(?NOMENKLAT:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûnijs'),AT(5990,833,677,156),USE(?NOMENKLAT:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûlijs'),AT(6719,833,677,156),USE(?NOMENKLAT:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('augusts'),AT(7448,833,677,156),USE(?NOMENKLAT:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('septembris'),AT(8177,833,677,156),USE(?NOMENKLAT:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('oktobris'),AT(8906,833,677,156),USE(?NOMENKLAT:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('novembris'),AT(9635,833,677,156),USE(?NOMENKLAT:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('decembris'),AT(10365,833,677,156),USE(?NOMENKLAT:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8854,781,0,781),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(9583,781,0,781),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(10313,781,0,781),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(11042,781,0,781),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(8125,781,0,781),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(7396,781,0,781),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(6667,781,0,781),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(5938,781,0,781),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5208,781,0,781),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(4479,781,0,781),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(3750,781,0,781),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(2292,781,0,781),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(3021,781,0,781),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(208,1042,2083,156),USE(?nosaukums),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,990,8750,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('daudzums'),AT(2396,1042,625,156),USE(?NOMENKLAT:29),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(3125,1042,625,156),USE(?NOMENKLAT:28),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(3854,1042,625,156),USE(?NOMENKLAT:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(4583,1042,625,156),USE(?NOMENKLAT:39),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(5313,1042,625,156),USE(?NOMENKLAT:26),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(6042,1042,625,156),USE(?NOMENKLAT:38),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(6771,1042,625,156),USE(?NOMENKLAT:25),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(7500,1042,625,156),USE(?NOMENKLAT:24),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(8229,1042,625,156),USE(?NOMENKLAT:37),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(8958,1042,625,156),USE(?NOMENKLAT:23),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(9688,1042,625,156),USE(?NOMENKLAT:20),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(10417,1042,625,156),USE(?NOMENKLAT:17),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(2396,1198,625,156),USE(?NOMENKLAT:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(3125,1198,625,156),USE(?NOMENKLAT:41),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(3854,1198,625,156),USE(?NOMENKLAT:42),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(4583,1198,625,156),USE(?NOMENKLAT:43),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5313,1198,625,156),USE(?NOMENKLAT:44),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6042,1198,625,156),USE(?NOMENKLAT:45),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6771,1198,625,156),USE(?NOMENKLAT:46),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7500,1198,625,156),USE(?NOMENKLAT:47),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(8229,1198,625,156),USE(?NOMENKLAT:48),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(8958,1198,625,156),USE(?NOMENKLAT:49),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(9688,1198,625,156),USE(?NOMENKLAT:21),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(10417,1198,625,156),USE(?NOMENKLAT:18),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(2396,1354,625,156),USE(?NOMENKLAT:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(3125,1354,625,156),USE(?NOMENKLAT:51),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(3854,1354,625,156),USE(?NOMENKLAT:52),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(4583,1354,625,156),USE(?NOMENKLAT:27),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(5313,1354,625,156),USE(?NOMENKLAT:53),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(6042,1354,625,156),USE(?NOMENKLAT:54),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(6771,1354,625,156),USE(?NOMENKLAT:55),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(7500,1354,625,156),USE(?NOMENKLAT:56),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(8229,1354,625,156),USE(?NOMENKLAT:57),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(8958,1354,625,156),USE(?NOMENKLAT:58),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(9688,1354,625,156),USE(?NOMENKLAT:22),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(10417,1354,625,156),USE(?NOMENKLAT:19),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1510,10885,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,781,0,781),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,510),USE(?unnamed)
         LINE,AT(156,-10,0,531),USE(?Line18),COLOR(COLOR:Black)
         STRING(@s21),AT(208,52,,156),USE(RPT_NOMENKLAT),LEFT
         STRING(@n-_12.3b),AT(8906,0,677,156),USE(daudzums[10]),RIGHT
         LINE,AT(9583,-10,0,531),USE(?Line18:12),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(9635,0,677,156),USE(daudzums[11]),RIGHT
         LINE,AT(10313,-10,0,531),USE(?Line18:13),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(10365,0,677,156),USE(daudzums[12]),RIGHT
         LINE,AT(11042,-10,0,531),USE(?Line18:14),COLOR(COLOR:Black)
         LINE,AT(8854,-10,0,531),USE(?Line18:11),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,531),USE(?Line18:2),COLOR(COLOR:Black)
         STRING(@s30),AT(208,208,2031,156),USE(NOS_S),LEFT
         STRING(@n-_12.2b),AT(8906,156,625,156),USE(summaM[10]),RIGHT
         STRING(@n-_12.2b),AT(9635,156,625,156),USE(summam[11]),RIGHT
         STRING(@n-_12.2b),AT(10365,156,625,156),USE(summam[12]),RIGHT
         STRING(@n-_12.3b),AT(2344,313,677,156),USE(i_daudzums[1]),RIGHT
         STRING(@n-_12.3b),AT(3073,313,677,156),USE(i_daudzums[2]),RIGHT
         STRING(@n-_12.3b),AT(3802,313,677,156),USE(i_daudzums[3]),RIGHT
         STRING(@n-_12.3b),AT(4531,313,677,156),USE(i_daudzums[4]),RIGHT
         STRING(@n-_12.3b),AT(5260,313,677,156),USE(i_daudzums[5]),RIGHT
         STRING(@n-_12.3b),AT(5990,313,677,156),USE(i_daudzums[6]),RIGHT
         STRING(@n-_12.3b),AT(6719,313,677,156),USE(i_daudzums[7]),RIGHT
         STRING(@n-_12.3b),AT(7448,313,677,156),USE(i_daudzums[8]),RIGHT
         STRING(@n-_12.3b),AT(8177,313,677,156),USE(i_daudzums[9]),RIGHT
         STRING(@n-_12.3b),AT(8906,313,677,156),USE(i_daudzums[10]),RIGHT
         STRING(@n-_12.3b),AT(9635,313,677,156),USE(i_daudzums[11]),RIGHT
         STRING(@n-_12.3b),AT(10365,313,677,156),USE(i_daudzums[12]),RIGHT
         LINE,AT(156,469,10885,0),USE(?Line61:3),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(2344,156,625,156),USE(summam[1]),RIGHT
         STRING(@n-_12.2b),AT(3073,156,625,156),USE(summam[2]),RIGHT
         STRING(@n-_12.2b),AT(3802,156,625,156),USE(summam[3]),RIGHT
         STRING(@n-_12.2b),AT(4531,156,625,156),USE(summam[4]),RIGHT
         STRING(@n-_12.2b),AT(5260,156,625,156),USE(summam[5]),RIGHT
         STRING(@n-_12.2b),AT(5990,156,625,156),USE(summam[6]),RIGHT
         STRING(@n-_12.2b),AT(6719,156,625,156),USE(summam[7]),RIGHT
         STRING(@n-_12.2b),AT(7448,156,625,156),USE(summam[8]),RIGHT
         STRING(@n-_12.2b),AT(8177,156,625,156),USE(summam[9]),RIGHT
         STRING(@n-_12.3b),AT(2344,0,677,156),USE(daudzums[1]),RIGHT
         LINE,AT(3021,-10,0,531),USE(?Line18:3),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3073,0,677,156),USE(daudzums[2]),RIGHT
         LINE,AT(3750,-10,0,531),USE(?Line18:4),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3802,0,677,156),USE(daudzums[3]),RIGHT
         LINE,AT(4479,-10,0,531),USE(?Line18:5),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(4531,0,677,156),USE(daudzums[4]),RIGHT
         LINE,AT(5208,-10,0,531),USE(?Line18:6),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5260,0,677,156),USE(daudzums[5]),RIGHT
         LINE,AT(5938,-10,0,531),USE(?Line18:7),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5990,0,677,156),USE(daudzums[6]),RIGHT
         LINE,AT(6667,-10,0,531),USE(?Line18:8),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(6719,0,677,156),USE(daudzums[7]),RIGHT
         LINE,AT(7396,-10,0,531),USE(?Line18:9),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(7448,0,677,156),USE(daudzums[8]),RIGHT
         LINE,AT(8125,-10,0,531),USE(?Line18:10),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8177,0,677,156),USE(daudzums[9]),RIGHT
       END
rpt_foot DETAIL,AT(,,,833),USE(?unnamed:2)
         LINE,AT(156,-10,0,490),USE(?Line181),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8906,0,677,156),USE(daudzumsK[10]),RIGHT
         LINE,AT(9583,-10,0,490),USE(?Line18:121),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(9635,0,677,156),USE(daudzumsK[11]),RIGHT
         LINE,AT(10313,-10,0,490),USE(?Line18:131),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(10365,0,677,156),USE(daudzumsK[12]),RIGHT
         STRING('Kopâ:'),AT(208,0),USE(?String127),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11042,-10,0,490),USE(?Line18:141),COLOR(COLOR:Black)
         LINE,AT(8854,-10,0,490),USE(?Line18:111),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,490),USE(?Line18:21),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(8906,156,625,156),USE(summaK[10]),RIGHT
         STRING(@n-_12.2b),AT(9635,156,625,156),USE(summaK[11]),RIGHT
         STRING(@n-_12.2b),AT(10365,156,625,156),USE(summaK[12]),RIGHT
         STRING(@n-_12.3b),AT(2344,313,677,156),USE(i_daudzumsK[1]),RIGHT
         STRING(@n-_12.3b),AT(3073,313,677,156),USE(i_daudzumsK[2]),RIGHT
         STRING(@n-_12.3b),AT(3802,313,677,156),USE(i_daudzumsK[3]),RIGHT
         STRING(@n-_12.3b),AT(4531,313,677,156),USE(i_daudzumsK[4]),RIGHT
         STRING(@n-_12.3b),AT(5260,313,677,156),USE(i_daudzumsK[5]),RIGHT
         STRING(@n-_12.3b),AT(5990,313,677,156),USE(i_daudzumsK[6]),RIGHT
         STRING(@n-_12.3b),AT(6719,313,677,156),USE(i_daudzumsK[7]),RIGHT
         STRING(@n-_12.3b),AT(7448,313,677,156),USE(i_daudzumsK[8]),RIGHT
         STRING(@n-_12.3b),AT(8177,313,677,156),USE(i_daudzumsK[9]),RIGHT
         STRING(@n-_12.3b),AT(8906,313,677,156),USE(i_daudzumsK[10]),RIGHT
         STRING(@n-_12.3b),AT(9635,313,677,156),USE(i_daudzumsK[11]),RIGHT
         STRING(@n-_12.3b),AT(10365,313,677,156),USE(i_daudzumsK[12]),RIGHT
         LINE,AT(156,469,10885,0),USE(?Line61),COLOR(COLOR:Black)
         STRING('Atgrieztâ prece (-K) samazina real. dauzdumu un summu (Bilances atskaitçs kâ pie' &|
             'prasîts katrâ konkrçtâ noliktavâ)'),AT(208,521,7031,208),USE(?String133),TRN
         STRING(@D6),AT(9906,573),USE(DAT),RIGHT
         STRING(@T4),AT(10563,573),USE(LAI),RIGHT
         STRING(@n-_12.2b),AT(2344,156,625,156),USE(summaK[1]),RIGHT
         STRING(@n-_12.2b),AT(3073,156,625,156),USE(summaK[2]),RIGHT
         STRING(@n-_12.2b),AT(3802,156,625,156),USE(summaK[3]),RIGHT
         STRING(@n-_12.2b),AT(4531,156,625,156),USE(summaK[4]),RIGHT
         STRING(@n-_12.2b),AT(5260,156,625,156),USE(summaK[5]),RIGHT
         STRING(@n-_12.2b),AT(5990,156,625,156),USE(summaK[6]),RIGHT
         STRING(@n-_12.2b),AT(6719,156,625,156),USE(summaK[7]),RIGHT
         STRING(@n-_12.2b),AT(7448,156,625,156),USE(summaK[8]),RIGHT
         STRING(@n-_12.2b),AT(8177,156,625,156),USE(summaK[9]),RIGHT
         STRING(@n-_12.3b),AT(2344,0,677,156),USE(daudzumsK[1]),RIGHT
         LINE,AT(3021,-10,0,490),USE(?Line18:32),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3073,0,677,156),USE(daudzumsK[2]),RIGHT
         LINE,AT(3750,-10,0,490),USE(?Line18:41),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3802,0,677,156),USE(daudzumsK[3]),RIGHT
         LINE,AT(4479,-10,0,490),USE(?Line18:51),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(4531,0,677,156),USE(daudzumsK[4]),RIGHT
         LINE,AT(5208,-10,0,490),USE(?Line18:61),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5260,0,677,156),USE(daudzumsK[5]),RIGHT
         LINE,AT(5938,-10,0,490),USE(?Line18:71),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5990,0,677,156),USE(daudzumsK[6]),RIGHT
         LINE,AT(6667,-10,0,490),USE(?Line18:81),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(6719,0,677,156),USE(daudzumsK[7]),RIGHT
         LINE,AT(7396,-10,0,490),USE(?Line18:91),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(7448,0,677,156),USE(daudzumsK[8]),RIGHT
         LINE,AT(8125,-10,0,490),USE(?Line18:101),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8177,0,677,156),USE(daudzumsK[9]),RIGHT
       END
       FOOTER,AT(198,7750,12000,52)
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
  S_DAT=DB_S_DAT   !IZZFILTGMC VIETÂ
  B_DAT=DB_B_DAT   !IZZFILTGMC VIETÂ
  DAT = TODAY()
  LAI = CLOCK()
  NOL_TEX=FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOL_KOPS::Used = 0
    CheckOpen(NOL_KOPS,1)
  END
  NOL_KOPS::Used += 1
  BIND(KOPS:RECORD)
  BIND('CYCLENOM',CYCLENOM)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Realizâcijas kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      KOPS:NOMENKLAT=NOMENKLAT
      SET(KOPS:NOM_key,KOPS:NOM_key)
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
           CHECKKOPS('POZICIONÇTS',0,1) !UZBÛVÇJAM KOPS MASÎVUS
           LOOP I#=1 TO NOL_SK
             IF NOL_NR25[I#]
                LOOP J#=1 TO 12
                  DAUDZUMS[J#]   += KOPS::K_DAUDZUMS[J#,I#]
                  SUMMAM[J#]     += KOPS::K_SUMMA[J#,I#]
                  I_DAUDZUMS[J#] += KOPS::KI_DAUDZUMS[J#,I#]
                  DAUDZUMSK[J#]  += KOPS::K_DAUDZUMS[J#,I#]
                  SUMMAK[J#]     += KOPS::K_SUMMA[J#,I#]
                  I_DAUDZUMSK[J#]+= KOPS::KI_DAUDZUMS[J#,I#]
                .
             .
           .
           RPT_NOMENKLAT=KOPS:NOMENKLAT
           NOS_S = KOPS:NOS_S
           PRINT(RPT:DETAIL)
           CLEAR(DAUDZUMS)
           CLEAR(SUMMAM)
           CLEAR(I_DAUDZUMS)
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
        POST(Event:CloseWindow)
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
  IF SEND(NOL_KOPS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
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
    ELSE
       ANSIJOB
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
    NOL_KOPS::Used -= 1
    IF NOL_KOPS::Used = 0 THEN CLOSE(NOL_KOPS).
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
  IF ERRORCODE() OR CYCLENOM(KOPS:NOMENKLAT)=2
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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

K_IENMAT             PROCEDURE                    ! Declare Procedure
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

NOL_TEX                 STRING(80)
DAUDZUMS                DECIMAL(11,3),DIM(12)
SUMMAM                  DECIMAL(11,2),DIM(12)
I_DAUDZUMS              DECIMAL(11,3),DIM(12)
DAUDZUMSK               DECIMAL(11,3),DIM(12)
SUMMAK                  DECIMAL(11,2),DIM(12)
I_DAUDZUMSK             DECIMAL(11,3),DIM(12)
DAT                     LONG
LAI                     LONG
NOS_S                   STRING(30)
RPT_NOMENKLAT           STRING(21)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(198,1844,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,302,12000,1542)
         STRING(@s45),AT(2969,156,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(2813,469,6354,208),USE(NOL_TEX),CENTER
         STRING('Forma K_IEN'),AT(9323,625,,156),USE(?String131)
         STRING('IENÂKUÐO PREÈU KOPSAVILKUMS'),AT(7323,156,3385,260),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10260,625,698,135),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(156,781,10885,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(208,979,2083,156),USE(?NOMENKLAT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('janvâris'),AT(2344,833,677,156),USE(?NOMENKLAT:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('februâris'),AT(3073,833,677,156),USE(?NOMENKLAT:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('marts'),AT(3802,833,677,156),USE(?NOMENKLAT:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprîlis'),AT(4531,833,677,156),USE(?NOMENKLAT:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('maijs'),AT(5260,833,677,156),USE(?NOMENKLAT:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûnijs'),AT(5990,833,677,156),USE(?NOMENKLAT:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('jûlijs'),AT(6719,833,677,156),USE(?NOMENKLAT:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('augusts'),AT(7448,833,677,156),USE(?NOMENKLAT:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('septembris'),AT(8177,833,677,156),USE(?NOMENKLAT:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('oktobris'),AT(8906,833,677,156),USE(?NOMENKLAT:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('novembris'),AT(9635,833,677,156),USE(?NOMENKLAT:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('decembris'),AT(10365,833,677,156),USE(?NOMENKLAT:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8854,781,0,781),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(9583,781,0,781),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(10313,781,0,781),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(11042,781,0,781),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(8125,781,0,781),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(7396,781,0,781),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(6667,781,0,781),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(5938,781,0,781),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5208,781,0,781),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(4479,781,0,781),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(3750,781,0,781),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(2292,781,0,781),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(3021,781,0,781),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Nosaukums'),AT(208,1188,2083,156),USE(?nosaukums),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,990,8750,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('daudzums'),AT(2396,1042,625,156),USE(?NOMENKLAT:29),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(3125,1042,625,156),USE(?NOMENKLAT:28),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(3854,1042,625,156),USE(?NOMENKLAT:3),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(4583,1042,625,156),USE(?NOMENKLAT:39),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(5313,1042,625,156),USE(?NOMENKLAT:26),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(6042,1042,625,156),USE(?NOMENKLAT:38),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(6771,1042,625,156),USE(?NOMENKLAT:25),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(7500,1042,625,156),USE(?NOMENKLAT:24),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(8229,1042,625,156),USE(?NOMENKLAT:37),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(8958,1042,625,156),USE(?NOMENKLAT:23),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(9688,1042,625,156),USE(?NOMENKLAT:20),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(10417,1042,625,156),USE(?NOMENKLAT:17),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(2396,1198,625,156),USE(?NOMENKLAT:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(3125,1198,625,156),USE(?NOMENKLAT:41),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(3854,1198,625,156),USE(?NOMENKLAT:42),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(4583,1198,625,156),USE(?NOMENKLAT:43),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5313,1198,625,156),USE(?NOMENKLAT:44),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6042,1198,625,156),USE(?NOMENKLAT:45),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(6771,1198,625,156),USE(?NOMENKLAT:46),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7500,1198,625,156),USE(?NOMENKLAT:47),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(8229,1198,625,156),USE(?NOMENKLAT:48),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(8958,1198,625,156),USE(?NOMENKLAT:49),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(9688,1198,625,156),USE(?NOMENKLAT:21),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(10417,1198,625,156),USE(?NOMENKLAT:18),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(2396,1354,625,156),USE(?NOMENKLAT:5),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(3125,1354,625,156),USE(?NOMENKLAT:51),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(3854,1354,625,156),USE(?NOMENKLAT:52),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(4583,1354,625,156),USE(?NOMENKLAT:27),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(5313,1354,625,156),USE(?NOMENKLAT:53),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(6042,1354,625,156),USE(?NOMENKLAT:30),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(6771,1354,625,156),USE(?NOMENKLAT:55),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(7500,1354,625,156),USE(?NOMENKLAT:56),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(8229,1354,625,156),USE(?NOMENKLAT:57),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(8958,1354,625,156),USE(?NOMENKLAT:58),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(9688,1354,625,156),USE(?NOMENKLAT:22),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('iekð. pârv.'),AT(10417,1354,625,156),USE(?NOMENKLAT:19),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1510,10885,0),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,781,0,781),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,510),USE(?unnamed)
         LINE,AT(156,-10,0,531),USE(?Line18),COLOR(COLOR:Black)
         STRING(@s21),AT(208,52,1510,156),USE(RPT_NOMENKLAT),LEFT
         STRING(@n-_12.3b),AT(8906,0,677,156),USE(daudzums[10]),RIGHT
         LINE,AT(9583,-10,0,531),USE(?Line18:12),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(9635,0,677,156),USE(daudzums[11]),RIGHT
         LINE,AT(10313,-10,0,531),USE(?Line18:13),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(10365,0,677,156),USE(daudzums[12]),RIGHT
         LINE,AT(11042,-10,0,531),USE(?Line18:14),COLOR(COLOR:Black)
         LINE,AT(8854,-10,0,531),USE(?Line18:11),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,531),USE(?Line18:2),COLOR(COLOR:Black)
         STRING(@s30),AT(208,208,,156),USE(NOS_S),LEFT,FONT(,8,,)
         STRING(@n-_12.2b),AT(8906,156,625,156),USE(summam[10]),RIGHT
         STRING(@n-_12.2b),AT(9635,156,625,156),USE(summam[11]),RIGHT
         STRING(@n-_12.2b),AT(10365,156,625,156),USE(summam[12]),RIGHT
         STRING(@n-_12.3b),AT(2344,313,677,156),USE(i_daudzums[1]),RIGHT
         STRING(@n-_12.3b),AT(3073,313,677,156),USE(i_daudzums[2]),RIGHT
         STRING(@n-_12.3b),AT(3802,313,677,156),USE(i_daudzums[3]),RIGHT
         STRING(@n-_12.3b),AT(4531,313,677,156),USE(i_daudzums[4]),RIGHT
         STRING(@n-_12.3b),AT(5260,313,677,156),USE(i_daudzums[5]),RIGHT
         STRING(@n-_12.3b),AT(5990,313,677,156),USE(i_daudzums[6]),RIGHT
         STRING(@n-_12.3b),AT(6719,313,677,156),USE(i_daudzums[7]),RIGHT
         STRING(@n-_12.3b),AT(7448,313,677,156),USE(i_daudzums[8]),RIGHT
         STRING(@n-_12.3b),AT(8177,313,677,156),USE(i_daudzums[9]),RIGHT
         STRING(@n-_12.3b),AT(8906,313,677,156),USE(i_daudzums[10]),RIGHT
         STRING(@n-_12.3b),AT(9635,313,677,156),USE(i_daudzums[11]),RIGHT
         STRING(@n-_12.3b),AT(10365,313,677,156),USE(i_daudzums[12]),RIGHT
         LINE,AT(156,469,10885,0),USE(?Line61:3),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(2344,156,625,156),USE(summam[1]),RIGHT
         STRING(@n-_12.2b),AT(3073,156,625,156),USE(summam[2]),RIGHT
         STRING(@n-_12.2b),AT(3802,156,625,156),USE(summam[3]),RIGHT
         STRING(@n-_12.2b),AT(4531,156,625,156),USE(summam[4]),RIGHT
         STRING(@n-_12.2b),AT(5260,156,625,156),USE(summam[5]),RIGHT
         STRING(@n-_12.2b),AT(5990,156,625,156),USE(summam[6]),RIGHT
         STRING(@n-_12.2b),AT(6719,156,625,156),USE(summam[7]),RIGHT
         STRING(@n-_12.2b),AT(7448,156,625,156),USE(summam[8]),RIGHT
         STRING(@n-_12.2b),AT(8177,156,625,156),USE(summam[9]),RIGHT
         STRING(@n-_12.3b),AT(2344,0,677,156),USE(daudzums[1]),RIGHT
         LINE,AT(3021,-10,0,531),USE(?Line18:3),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3073,0,677,156),USE(daudzums[2]),RIGHT
         LINE,AT(3750,-10,0,531),USE(?Line18:4),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3802,0,677,156),USE(daudzums[3]),RIGHT
         LINE,AT(4479,-10,0,531),USE(?Line18:5),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(4531,0,677,156),USE(daudzums[4]),RIGHT
         LINE,AT(5208,-10,0,531),USE(?Line18:6),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5260,0,677,156),USE(daudzums[5]),RIGHT
         LINE,AT(5938,-10,0,531),USE(?Line18:7),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5990,0,677,156),USE(daudzums[6]),RIGHT
         LINE,AT(6667,-10,0,531),USE(?Line18:8),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(6719,0,677,156),USE(daudzums[7]),RIGHT
         LINE,AT(7396,-10,0,531),USE(?Line18:9),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(7448,0,677,156),USE(daudzums[8]),RIGHT
         LINE,AT(8125,-10,0,531),USE(?Line18:10),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8177,0,677,156),USE(daudzums[9]),RIGHT
       END
rpt_foot DETAIL,AT(,,,833)
         LINE,AT(156,-10,0,490),USE(?Line181),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8906,0,677,156),USE(daudzumsK[10]),RIGHT
         LINE,AT(9583,-10,0,490),USE(?Line18:121),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(9635,0,677,156),USE(daudzumsK[11]),RIGHT
         LINE,AT(10313,-10,0,490),USE(?Line18:131),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(10365,0,677,156),USE(daudzumsK[12]),RIGHT
         STRING('Kopâ:'),AT(208,0),USE(?String127),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11042,-10,0,490),USE(?Line18:141),COLOR(COLOR:Black)
         LINE,AT(8854,-10,0,490),USE(?Line18:111),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,490),USE(?Line18:21),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(8906,156,625,156),USE(summaK[10]),RIGHT
         STRING(@n-_12.2b),AT(9635,156,625,156),USE(summaK[11]),RIGHT
         STRING(@n-_12.2b),AT(10365,156,625,156),USE(summaK[12]),RIGHT
         STRING(@n-_12.3b),AT(2344,313,677,156),USE(i_daudzumsK[1]),RIGHT
         STRING(@n-_12.3b),AT(3073,313,677,156),USE(i_daudzumsK[2]),RIGHT
         STRING(@n-_12.3b),AT(3802,313,677,156),USE(i_daudzumsK[3]),RIGHT
         STRING(@n-_12.3b),AT(4531,313,677,156),USE(i_daudzumsK[4]),RIGHT
         STRING(@n-_12.3b),AT(5260,313,677,156),USE(i_daudzumsK[5]),RIGHT
         STRING(@n-_12.3b),AT(5990,313,677,156),USE(i_daudzumsK[6]),RIGHT
         STRING(@n-_12.3b),AT(6719,313,677,156),USE(i_daudzumsK[7]),RIGHT
         STRING(@n-_12.3b),AT(7448,313,677,156),USE(i_daudzumsK[8]),RIGHT
         STRING(@n-_12.3b),AT(8177,313,677,156),USE(i_daudzumsK[9]),RIGHT
         STRING(@n-_12.3b),AT(8906,313,677,156),USE(i_daudzumsK[10]),RIGHT
         STRING(@n-_12.3b),AT(9635,313,677,156),USE(i_daudzumsK[11]),RIGHT
         STRING(@n-_12.3b),AT(10365,313,677,156),USE(i_daudzumsK[12]),RIGHT
         LINE,AT(156,469,10885,0),USE(?Line61),COLOR(COLOR:Black)
         STRING('Atgrieztâ prece (-D) samazina ien. dauzdumu un summu (Bilances atskaitçs nemaina' &|
             ', bet palielina realizâciju)'),AT(156,521,5969,188),USE(?String133)
         STRING(@D6),AT(9271,573),USE(DAT),RIGHT,FONT(,8,,)
         STRING(@T4),AT(10104,573),USE(LAI),RIGHT
         STRING(@n-_12.2b),AT(2344,156,625,156),USE(summaK[1]),RIGHT
         STRING(@n-_12.2b),AT(3073,156,625,156),USE(summaK[2]),RIGHT
         STRING(@n-_12.2b),AT(3802,156,625,156),USE(summaK[3]),RIGHT
         STRING(@n-_12.2b),AT(4531,156,625,156),USE(summaK[4]),RIGHT
         STRING(@n-_12.2b),AT(5260,156,625,156),USE(summaK[5]),RIGHT
         STRING(@n-_12.2b),AT(5990,156,625,156),USE(summaK[6]),RIGHT
         STRING(@n-_12.2b),AT(6719,156,625,156),USE(summaK[7]),RIGHT
         STRING(@n-_12.2b),AT(7448,156,625,156),USE(summaK[8]),RIGHT
         STRING(@n-_12.2b),AT(8177,156,625,156),USE(summaK[9]),RIGHT
         STRING(@n-_12.3b),AT(2344,0,677,156),USE(daudzumsK[1]),RIGHT
         LINE,AT(3021,-10,0,490),USE(?Line18:32),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3073,0,677,156),USE(daudzumsK[2]),RIGHT
         LINE,AT(3750,-10,0,490),USE(?Line18:41),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(3802,0,677,156),USE(daudzumsK[3]),RIGHT
         LINE,AT(4479,-10,0,490),USE(?Line18:51),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(4531,0,677,156),USE(daudzumsK[4]),RIGHT
         LINE,AT(5208,-10,0,490),USE(?Line18:61),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5260,0,677,156),USE(daudzumsK[5]),RIGHT
         LINE,AT(5938,-10,0,490),USE(?Line18:71),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(5990,0,677,156),USE(daudzumsK[6]),RIGHT
         LINE,AT(6667,-10,0,490),USE(?Line18:81),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(6719,0,677,156),USE(daudzumsK[7]),RIGHT
         LINE,AT(7396,-10,0,490),USE(?Line18:91),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(7448,0,677,156),USE(daudzumsK[8]),RIGHT
         LINE,AT(8125,-10,0,490),USE(?Line18:101),COLOR(COLOR:Black)
         STRING(@n-_12.3b),AT(8177,0,677,156),USE(daudzumsK[9]),RIGHT
       END
       FOOTER,AT(198,7750,12000,52)
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
  S_DAT=DB_S_DAT  !IZZFILTGMC VIETÂ
  B_DAT=DB_B_DAT  !IZZFILTGMC VIETÂ
  DAT = TODAY()
  LAI = CLOCK()
  NOL_TEX=FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOL_KOPS::Used = 0
    CheckOpen(NOL_KOPS,1)
  END
  NOL_KOPS::Used += 1
  BIND(KOPS:RECORD)
  BIND('CYCLENOM',CYCLENOM)
  FilesOpened = True

  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ien.preèu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      KOPS:NOMENKLAT=NOMENKLAT
      SET(KOPS:NOM_key,KOPS:NOM_key)
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
           CHECKKOPS('POZICIONÇTS',0,1) !UZBÛVÇJAM KOPS MASÎVUS
           LOOP I#=1 TO NOL_SK
             IF NOL_NR25[I#]
                LOOP J#=1 TO 12
                  DAUDZUMS[J#]   += KOPS::D_DAUDZUMS[J#,I#]
                  SUMMAM[J#]     += KOPS::D_SUMMA[J#,I#]
                  I_DAUDZUMS[J#] += KOPS::DI_DAUDZUMS[J#,I#]
                  DAUDZUMSK[J#]  += KOPS::D_DAUDZUMS[J#,I#]
                  SUMMAK[J#]     += KOPS::D_SUMMA[J#,I#]
                  I_DAUDZUMSK[J#]+= KOPS::DI_DAUDZUMS[J#,I#]
                .
             .
           .
           RPT_NOMENKLAT=KOPS:NOMENKLAT
           NOS_S = KOPS:NOS_S
           PRINT(RPT:DETAIL)
           CLEAR(DAUDZUMS)
           CLEAR(SUMMAM)
           CLEAR(I_DAUDZUMS)
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
        POST(Event:CloseWindow)
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
  IF SEND(NOL_KOPS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
     IF F:DBF='W'   !WMF
        PRINT(RPT:RPT_FOOT)
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
     ELSE
        ANSIJOB
     .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
    NOL_KOPS::Used -= 1
    IF NOL_KOPS::Used = 0 THEN CLOSE(NOL_KOPS).
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
  IF ERRORCODE() OR CYCLENOM(KOPS:NOMENKLAT)=2
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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
K_PrIeKusA           PROCEDURE                    ! Declare Procedure
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
!---------------------------------------------------------------------------
PROCESS:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:NOS_S)
                     END
!---------------------------------------------------------------------------
kops_gads            SHORT
NOL_NR               BYTE
DAUDZUMS             REAL
IE_DAUDZUMS          REAL
IZ_DAUDZUMS          REAL
IE_SUMMA             DECIMAL(12,2)
IZ_SUMMA             DECIMAL(12,2)
IE_DAUDZUMSN         REAL,DIM(25)
IZ_DAUDZUMSN         REAL,DIM(25)
IE_SUMMAN            REAL,DIM(25)
IZ_SUMMAN            REAL,DIM(25)
IE_DAUDZUMSK         REAL
IZ_DAUDZUMSK         REAL
IE_SUMMAK            REAL
IZ_SUMMAK            REAL
IE_SUMMAD            DECIMAL(12,2)
IZ_SUMMAD            DECIMAL(12,2)
MAXSUMMA             DECIMAL(12,2)
DELTA                DECIMAL(12,2)
VID                  REAL
DAT                  DATE
LAI                  TIME
!---------------------------------------------------------------------------
report REPORT,AT(104,1492,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,200,8000,1292),USE(?unnamed)
         STRING(@s45),AT(1771,104,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu iekðçjâs kustîbas analîze (VS)'),AT(1250,417,2969,260),USE(?String4),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4156,417,1542,260),USE(menesisunG),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,729,6823,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2344,729,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(7344,729,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Noliktava'),AT(625,781,1667,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4844,729,0,573),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Ienâcis'),AT(2448,781,2344,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjis'),AT(4948,781,2344,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2344,990,5000,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(3594,990,0,313),USE(?Line19),COLOR(COLOR:Black)
         STRING('Daudzums'),AT(2448,1042,1094,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(3698,1042,1094,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4948,1042,1094,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,990,0,313),USE(?Line19:2),COLOR(COLOR:Black)
         STRING('Summa'),AT(6198,1042,1094,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1250,6823,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(521,729,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(521,-10,0,197),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(625,10,313,156),USE(J#),RIGHT
         LINE,AT(2344,-10,0,197),USE(?Line7:2),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,197),USE(?Line7:6),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(3750,10,990,156),USE(IE_SUMMA),RIGHT
         LINE,AT(4844,-10,0,197),USE(?Line7:4),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(5000,10,990,156),USE(IZ_DAUDZUMS),RIGHT
         LINE,AT(6094,-10,0,197),USE(?Line7:5),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(6250,10,990,156),USE(IZ_SUMMA),RIGHT
         STRING(@s15),AT(1146,10,990,156),USE(sys:avots),LEFT
         LINE,AT(7344,-10,0,197),USE(?Line7:3),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(2500,10,990,156),USE(IE_DAUDZUMS),RIGHT
       END
RPT_FOOT3 DETAIL,AT(,,,667),USE(?unnamed:2)
         LINE,AT(521,-10,0,270),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(2344,-10,0,270),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,270),USE(?Line25:14),COLOR(COLOR:Black)
         LINE,AT(521,52,6823,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(573,104,729,156),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_15.2),AT(2500,104,990,156),USE(IE_DAUDZUMSK),RIGHT
         STRING(@N-_15.2),AT(3750,104,990,156),USE(IE_SUMMAD),RIGHT
         STRING(@N-_15.2),AT(5000,104,990,156),USE(IZ_DAUDZUMSK),RIGHT
         STRING(@N-_15.2),AT(6250,104,990,156),USE(IZ_SUMMAD),RIGHT
         LINE,AT(4844,-10,0,270),USE(?Line25:41),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,270),USE(?Line25:42),COLOR(COLOR:Black)
         LINE,AT(7344,-10,0,270),USE(?Line25:5),COLOR(COLOR:Black)
         LINE,AT(521,260,6823,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@N-_15.2),AT(2500,292,990,156),USE(IE_DAUDZUMSK,,?IE_DAUDZUMSK:2),RIGHT
         STRING(@N-_15.2),AT(3750,302,990,156),USE(IE_SUMMAK),RIGHT
         STRING('CTRL: pirms apaïoðanas '),AT(573,313,1667,156),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_15.2),AT(6260,292,990,156),USE(IZ_SUMMAK),RIGHT
         STRING(@N-_15.2),AT(5010,292,990,156),USE(IZ_DAUDZUMSK,,?IZ_DAUDZUMSK:2),RIGHT
         LINE,AT(521,469,6823,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(583,510,573,146),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(1073,510,573,146),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1833,510,313,146),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(2042,510,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6240,510),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6844,510,458,146),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(104,11000,8000,63)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
WMFANSI WINDOW('Izdrukas Formâts'),AT(,,185,72),GRAY
       OPTION('Izdrukas &Formâts'),AT(25,12,132,27),USE(F:DBF),BOXED
         RADIO('WMF'),AT(35,24),USE(?F:DBF:Radio1)
         RADIO('ANSI:TXT'),AT(106,24),USE(?F:DBF:Radio2)
       END
       BUTTON('&OK'),AT(98,48,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(136,48,35,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  OPEN(WMFANSI)
  IF ~F:DBF THEN F:DBF='W'.
  DISPLAY
  ACCEPT
    CASE FIELD()
    OF ?OKButton
        CASE EVENT()
        OF EVENT:Accepted
            BREAK
        .
    OF ?CancelButton
        CASE EVENT()
        OF EVENT:Accepted
            close(WMFANSI)
            do ProcedureReturn
        .
    END
  END
  CLOSE(WMFANSI)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  checkopen(global,1)
  kops_gads=GADS
  CHECKOPEN(NOL_FIFO,1)
  CHECKOPEN(NOL_KOPS,1)
  NOL_KOPS::USED+=1
  FilesOpened=TRUE
  BIND(KOPS:RECORD)
  BIND('KOPS_GADS',KOPS_GADS)
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Preèu iekðçjâ kustîba(VS)'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
!      Process:View{Prop:Filter} ='KOPS:GADS=KOPS_GADS'
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
          IF ~OPENANSI('KPrIeKuA.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='PREÈU IEKÐÇJÂS KUSTÎBAS ANALÎZE (VS) '&MENESISunG
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='-{95}'
          ADD(OUTFILEANSI)
          OUTA:LINE='NOLIKTAVA'&CHR(9)&'IENÂCIS'&CHR(9)&CHR(9)&'IZGÂJIS'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&'DAUDZUMS'&CHR(9)&'SUMMA'&CHR(9)&'DAUDZUMS'&CHR(9)&'SUMMA'
          ADD(OUTFILEANSI)
          OUTA:LINE='-{95}'
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
       LOOP RecordsPerCycle TIMES
           NPK#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           VID=0
           DAUDZUMS=0
           CHECKKOPS('POZICIONÇTS',0,1)
           LOOP M#= MONTH(S_DAT) TO MONTH(B_DAT)
              VID=CALCKOPS(M#,0,5) !VIDÇJÂ VÇRTÎBA UZ MÇNEÐA BEIGÂM
              LOOP J#= 1 TO NOL_SK
                 IF NOL_NR25[J#]=TRUE
                    DAUDZUMS=CALCKOPS(M#,J#,7)
                    IE_DAUDZUMSN[J#]+=DAUDZUMS
                    IE_SUMMAN[J#]+=DAUDZUMS*VID
                    IE_DAUDZUMSK+=DAUDZUMS
                    IE_SUMMAK+=DAUDZUMS*VID
                    DAUDZUMS=CALCKOPS(M#,J#,8)
                    IZ_DAUDZUMSN[J#]+=DAUDZUMS
                    IZ_SUMMAN[J#]+=DAUDZUMS*VID
                    IZ_DAUDZUMSK+=DAUDZUMS
                    IZ_SUMMAK+=DAUDZUMS*VID
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
        POST(Event:CloseWindow)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     DELTA=IE_SUMMAK-IZ_SUMMAK
     IF DELTA
        MAXSUMMA=0
        LOOP J#= 1 TO NOL_SK       !MEKLÇJAM MAXSUMMU IZEJOÐJÂM
           IF NOL_NR25[J#]=TRUE
              IE_DAUDZUMS=IE_DAUDZUMSN[J#]
              IF IZ_SUMMAN[J#] > MAXSUMMA
                 MAXSUMMA=IZ_SUMMA
                 MAX_NR#=J#
              .
           .
        .
     .
     SAV_JOB_NR#=JOB_NR
     IE_SUMMAD=0
     IZ_SUMMAD=0
     LOOP J#= 1 TO NOL_SK
        IF NOL_NR25[J#]=TRUE
            JOB_NR=J#+15 !NOLIKTAVAS SYSTEM
            CHECKOPEN(SYSTEM,1)
            IE_DAUDZUMS=IE_DAUDZUMSN[J#]
            IE_SUMMA=IE_SUMMAN[J#]
            IE_SUMMAD+=IE_SUMMA
            IZ_DAUDZUMS=IZ_DAUDZUMSN[J#]
            IZ_SUMMA=IZ_SUMMAN[J#]
            IF J#=MAX_NR#
               IZ_SUMMA+=DELTA
            .
            IZ_SUMMAD+=IZ_SUMMA
            IF F:DBF = 'W'
                PRINT(RPT:DETAIL)
            ELSE
                OUTA:LINE=FORMAT(J#,@N_5)&' '&SYS:AVOTS&CHR(9)&LEFT(FORMAT(IE_DAUDZUMS,@N12.2))&CHR(9)&|
                LEFT(FORMAT(IE_SUMMA,@N12.2))&CHR(9)&LEFT(FORMAT(IZ_DAUDZUMS,@N12.2))&CHR(9)&LEFT(FORMAT(IZ_SUMMA,@N12.2))
                ADD(OUTFILEANSI)
            END
        .
     .
     JOB_NR=SAV_JOB_NR#
     CLOSE(SYSTEM)
     DAT=TODAY()
     LAI=CLOCK()
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT3)
     ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&LEFT(FORMAT(IE_DAUDZUMSK,@N12.2))&CHR(9)&LEFT(FORMAT(IE_SUMMAK,@N12.2))&CHR(9)&|
        LEFT(FORMAT(IZ_DAUDZUMSK,@N12.2))&CHR(9)&LEFT(FORMAT(IZ_SUMMAK,@N12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
     END
!     report{Prop:Preview} = PrintPreviewImage
     ENDPAGE(report)
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
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
  NOL_KOPS::USED-=1
  IF NOL_KOPS::USED=0
     CLOSE(NOL_KOPS)
  .
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
  IF ERRORCODE() OR (CYCLENOM(NOM:NOMENKLAT)=2)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOM_K')
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
