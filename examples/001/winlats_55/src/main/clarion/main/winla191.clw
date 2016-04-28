                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IzgKonsP           PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------
RPT_NR               DECIMAL(4)
KOPA                 STRING(6)
SUMMAPK              DECIMAL(14,2)
SUMMA_AK             DECIMAL(12,2)
SUMMAP               DECIMAL(14,2)
NOSK                 STRING(3)
DAT                  DATE
LAI                  TIME
V1                   BYTE
V2                   BYTE
CN                   STRING(10)
CP                   STRING(3)
VERT_BEZ_PVNK        DECIMAL(14,2)
SUMMA_PVN            DECIMAL(10,2)
SUMMA_PVNK           DECIMAL(10,2)
ITOGO                DECIMAL(14,2)
ITOGOK               DECIMAL(14,2)

K_TABLE              QUEUE,PRE(K)
NOS                    STRING(3)
SUMMAK                 DECIMAL(14,2)
SUMMA_AK               DECIMAL(12,2)
SUMMA                  DECIMAL(14,2)
SUMMAB                 DECIMAL(14,2)
PVN                    DECIMAL(12,2)
ITOGO                  DECIMAL(14,2)
                     .
VIRSRAKSTS           STRING(110)
FILTRS_TEXT          STRING(100)
PARADS_TEXT          STRING(50)
TAB_4_TEXT           STRING(12) !SAÒÇM/PAMAT.
PAV_PAMAT            STRING(40) !PAR:NOS_P/PAV:PAMAT

!------------------------------------------------------------------------
report REPORT,AT(198,1948,12000,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,500,12000,1448),USE(?unnamed:3)
         LINE,AT(104,1406,10781,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2490,73,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(625,302,8188,188),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(2198,490,5063,188),USE(PARADS_TEXT),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(917,698,7625,198),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10219,760,677,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,938,10781,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,938,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1146,938,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2146,938,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4271,938,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4948,938,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,1063,313,208),USE(?String15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(521,990,625,208),USE(?String15:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta SE'),AT(1177,990,917,208),USE(?String15:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(2448,1063,1448,208),USE(TAB_4_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu'),AT(4323,990,625,208),USE(?String15:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâds'),AT(8698,1063,698,208),USE(?String15:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(5000,990,885,208),USE(?String15:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(5938,990,677,208),USE(?String15:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmes'),AT(6667,990,1146,208),USE(?String15:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('..tai skaitâ'),AT(7844,990,781,208),USE(?String15:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(9844,1063,865,208),USE(?String15:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10885,938,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(9635,938,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(6615,938,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7813,938,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(8646,938,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5885,938,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('datums'),AT(521,1198,625,208),USE(?String15:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un numurs'),AT(1188,1198,917,208),USE(?String15:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(4323,1198,625,208),USE(?String15:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(5000,1198,885,208),USE(?String15:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(5938,1198,677,208),USE(?String15:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(6667,1198,1146,208),USE(?String15:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaide'),AT(7865,1198,781,208),USE(?String15:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,938,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('FORMA IZ5'),AT(10167,604,729,156),USE(?String12),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(104,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         STRING(@N_4),AT(156,10,260,156),USE(RPT_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_14.2),AT(9688,10,885,156),USE(ITOGO),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(10625,10,260,156),USE(PAV:VAL,,?PAV:VAL:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10885,-10,0,198),USE(?Line10:20),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,198),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@D06.),AT(500,10,625,156),USE(PAV:DATUMS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1146,-10,0,198),USE(?Line10:3),COLOR(COLOR:Black)
         STRING(@s14),AT(1188,10,,156),USE(PAV:DOK_SEnr),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2146,-10,0,198),USE(?Line10:4),COLOR(COLOR:Black)
         STRING(@s35),AT(2188,10,2052,156),USE(PAV_PAMAT),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4271,-10,0,198),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@D06.),AT(4313,10,625,156),USE(PAV:C_DATUMS),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,198),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N_14.2),AT(8698,10,885,156),USE(PAV:C_SUMMA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6615,-10,0,198),USE(?Line10:12),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6667,10,833,156),USE(PAV:SUMMA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,10,260,156),USE(PAV:VAL),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8646,-10,0,198),USE(?Line10:14),COLOR(COLOR:Black)
         STRING(@N_12.2),AT(7865,10,729,156),USE(PAV:SUMMA_A),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9635,-10,0,198),USE(?Line10:9),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,198),USE(?Line10:13),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(5000,10,833,156),USE(PAV:SUMMA_B),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(5938,10,625,156),USE(SUMMA_PVN),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5885,-10,0,198),USE(?Line10:7),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(469,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(1146,0,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,115),USE(?Line22:4),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,115),USE(?Line22:3),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,115),USE(?Line22:5),COLOR(COLOR:Black)
         LINE,AT(9635,0,0,115),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(2156,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(10885,0,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(104,52,10781,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(104,-10,0,198),USE(?Line10:8),COLOR(COLOR:Black)
         STRING(@s6),AT(156,10,521,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(5938,10,625,156),USE(SUMMA_PVNK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4948,-10,0,198),USE(?Line10:19),COLOR(COLOR:Black)
         STRING(@N_14.2),AT(8698,10,885,156),USE(SUMMAPK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(7552,10,260,156),USE(NOSK),LEFT,FONT(,8,,)
         LINE,AT(5885,-10,0,198),USE(?Line10:18),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(5000,10,833,156),USE(vert_bez_pvnK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6615,-10,0,198),USE(?Line10:15),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6667,10,833,156),USE(SUMMAP),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7813,-10,0,198),USE(?Line10:10),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line10:17),COLOR(COLOR:Black)
         STRING(@N_12.2),AT(7865,10,729,156),USE(SUMMA_Ak),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9635,-10,0,198),USE(?Line10:21),COLOR(COLOR:Black)
         STRING(@N_14.2),AT(9688,10,885,156),USE(ITOGOK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(10625,10,260,156),USE(NOSK,,?NOSK:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10885,-10,0,198),USE(?Line10:16),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,198),USE(?unnamed:2)
         LINE,AT(104,0,0,63),USE(?Line10:11),COLOR(COLOR:Black)
         LINE,AT(4948,0,0,63),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(5885,0,0,63),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,63),USE(?Line29:2),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,63),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,63),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(9635,0,0,63),USE(?Line30:4),COLOR(COLOR:Black)
         LINE,AT(10885,0,0,63),USE(?Line30:3),COLOR(COLOR:Black)
         LINE,AT(104,52,10781,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,73,469,156),USE(?String34),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(646,73,677,156),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1385,73,313,156),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1646,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(9938,73,521,156),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10479,73,417,156),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,7802,12000,63)
         LINE,AT(104,0,10781,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!
!
!  V/K tikai, kur pav:c_datums inrange s_dat,b_dat
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  BIND('D_K',D_K)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('V1',V1)  !pçcapmaksa
  BIND('V2',V2)  !realizâcijai
  BIND('CYCLENOL',CYCLENOL)
  BIND('CYCLEPAR_K',CYCLEPAR_K)

  KOPA='Kopâ:'
  DAT = TODAY()
  LAI = CLOCK()
  D_K = 'K'
  V1='2'
  V2='3'

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(NOL:RECORD)
  BIND(PAR:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izg. pçcapm/rwealiz.preces'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Norçíini par izgâjuðâm (K) pçcapmaksas/realiz. P/Z periodâ: '&FORMAT(S_DAT,@D06.)&'-'&|
      FORMAT(B_DAT,@D06.)&' Noliktava:'&clip(loc_nr)&' '&SYS:AVOTS
      PARADS_TEXT=GETFILTRS_TEXT('000000010')
      CLEAR(PAV:RECORD)
!      PAV:DATUMS=S_DAT VAJAG NO GADA SÂKUMA
      PAV:D_K='D'
      IF PAR_NR = 999999999 !VISI
         CN = 'P11011'
         CP = 'P11'
         FILTRS_TEXT=GETFILTRS_TEXT('101100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         TAB_4_TEXT='Saòçmçjs'
         SET(PAV:DAT_KEY,PAV:DAT_KEY)
!         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
         Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND ~CYCLEPAR_K(CP) AND '&|
         'INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'
      ELSE                  !KONKRÇTS
         CN = 'P10011'
         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Piegâdâtâjs: '&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_K(PAR_NR,0,24)
!         FILTRS_TEXT='Piegâdâtâjs: '&CLIP(GETPAR_K(PAR_NR,0,1))&' '&GETPAR_K(PAR_NR,0,24)
         TAB_4_TEXT='Pamatojums'
         PAV:PAR_NR=PAR_NR
         SET(PAV:PAR_KEY,PAV:PAR_KEY)
!         Process:View{Prop:Filter} ='~CYCLENOL(CN)'
         Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND '&|
         'INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'
      .


!      CN = 'P10011'
!      CLEAR(PAV:RECORD)
!      PAV:PAR_NR=PAR_NR
!      SET(PAV:PAR_KEY,PAV:PAR_KEY)
!      Process:View{Prop:Filter} = '(PAV:APM_V=V1 OR PAV:APM_V=V2) AND ~CYCLENOL(CN) AND INRANGE(PAV:C_DATUMS,S_DAT,B_DAT)'

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
          IF ~OPENANSI('IZGKONSP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=PARADS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dok. SE'&CHR(9)&TAB_4_TEXT&CHR(9)&'Norçíinu'&|
             CHR(9)&'Summa'&CHR(9)&'PVN summa'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&'tai skaitâ'&CHR(9)&'Parâds'&CHR(9)&|
             'Kopâ, valûtâ'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'datums'&CHR(9)&'bez PVN'&CHR(9)&CHR(9)&|
             'ar PVN, valûtâ'&CHR(9)&CHR(9)&'atlaide'
             ADD(OUTFILEANSI)
          ELSE
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dok. SE un numurs'&CHR(9)&TAB_4_TEXT&CHR(9)&|
             'Norçíinu datums'&CHR(9)&'Summa bez PVN'&CHR(9)&'PVN summa'&CHR(9)&'Pçc pavadzîmes ar PVN, valûtâ'&CHR(9)&|
             CHR(9)&'tai skaitâ atlaide'&CHR(9)&'Parâds'&CHR(9)&|
             'Kopâ, valûtâ'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF F:ATL[2]='1' OR PAV:C_SUMMA             ! Iekïaut 0-es parâdus vai parâds~0
           NR#+=1
           RPT_NR=NR#
           ?Progress:UserString{Prop:Text}=NR#
           DISPLAY(?Progress:UserString)
           IF PAR_NR=999999999 !VISI
              PAV_PAMAT=GETPAR_K(PAV:PAR_NR,2,2)
           ELSE
              PAV_PAMAT=PAV:PAMAT
           .
           SUMMA_PVN = PAV:SUMMA-PAV:SUMMA_B
           ITOGO = PAV:SUMMA
           IF ~F:DTK
               IF F:DBF='W'
                   PRINT(RPT:DETAIL)
               ELSE
                   OUTA:LINE=CLIP(RPT_NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&PAV:DOK_SENR&CHR(9)&PAV_PAMAT&|
                   CHR(9)&FORMAT(PAV:C_DATUMS,@D06.)&CHR(9)&LEFT(FORMAT(PAV:SUMMA_B,@N-_14.2))&CHR(9)&|
                   LEFT(FORMAT(SUMMA_PVN,@N_10.2))&CHR(9)&LEFT(FORMAT(PAV:SUMMA,@N-_14.2))&CHR(9)&PAV:VAL&CHR(9)&|
                   LEFT(FORMAT(PAV:SUMMA_A,@N_12.2))&CHR(9)&LEFT(FORMAT(PAV:C_SUMMA,@N_14.2))&CHR(9)&|
                   LEFT(FORMAT(ITOGO,@N_14.2))&CHR(9)&PAV:VAL
                   ADD(OUTFILEANSI)
               END
           END
           GET(K_TABLE,0)
           K:NOS=PAV:VAL
           GET(K_TABLE,K:NOS)
           IF ERROR()
             K:NOS      = PAV:VAL
             K:SUMMAK   = PAV:C_SUMMA
             K:SUMMA_AK = PAV:SUMMA_A
             K:SUMMA    = PAV:SUMMA
             K:PVN      = SUMMA_PVN
             K:SUMMAB   = PAV:SUMMA_B
             K:ITOGO    = ITOGO
             add(K_TABLE)
             SORT(K_TABLE,K:NOS)
           ELSE
             K:SUMMAK   += PAV:C_SUMMA
             K:SUMMA_AK += PAV:SUMMA_A
             K:SUMMA    += PAV:SUMMA
             K:PVN      += SUMMA_PVN
             K:SUMMAB   += PAV:SUMMA_B
             K:ITOGO    += ITOGO
             PUT(K_TABLE)
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF F:ATL[2]='1' OR K:SUMMAK                !Jâdrukâ 0-es vai ir parâds
        SUMMAPK       = K:SUMMAK
        SUMMA_AK      = K:SUMMA_AK
        NOSK          = K:NOS
        VERT_BEZ_PVNK = K:SUMMAB
        SUMMA_PVNK    = K:PVN
        SUMMAP        = K:SUMMA
        ITOGOK        = K:ITOGO
        IF ~F:DTK
            IF F:DBF='W'
                PRINT(RPT:RPT_FOOT2)
            ELSE !WORD,EXCEL
                OUTA:LINE=kopa&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_BEZ_PVNK,@N-_14.2))&CHR(9)&|
                LEFT(FORMAT(SUMMA_PVNK,@N-_10.2))&CHR(9)&LEFT(FORMAT(SUMMAP,@N-_14.2))&CHR(9)&NOSK&CHR(9)&|
                LEFT(FORMAT(SUMMA_AK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMAPK,@N-_14.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))&|
                CHR(9)&NOSK
                ADD(OUTFILEANSI)
            END
        END
        kopa=''
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
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
  FREE(K_TABLE)
  IF FilesOpened
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
  IF ~(PAR_NR=999999999)                 !KONKRÇTS PARTNERIS
     NEXT(Process:View)
     IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR) THEN VISS#=TRUE.
  ELSE
     PREVIOUS(Process:View) !DESC.
     IF ERRORCODE() OR PAV:DATUMS>B_DAT THEN VISS#=TRUE.
  .
  IF VISS#=TRUE
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
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
N_Izgmat5            PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------

NOS_P                STRING(35)
RPT_NOMENKLAT        STRING(21)
NPK                  DECIMAL(4)
NOSAUKUMS            STRING(55)
MERVIEN              STRING(7)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(14,3)
CENA                 DECIMAL(10,2)
SUMMA_P              DECIMAL(14,2)
SUMMA_PK             DECIMAL(14,2)
SUMMA_B              DECIMAL(14,2)
SUMMA_BK             DECIMAL(14,2)
SUMMA_X              DECIMAL(14,2)
SUMMA_XK             DECIMAL(14,2)
SUMMA_PVN            DECIMAL(10,2)
SUMMA_PVNK           DECIMAL(10,2)
NOL_VAL              STRING(3)
NOM_VAL              STRING(3)
KOPA                 STRING(20)
VALK                 STRING(3)
CN                   STRING(10)
CP                   STRING(10)
DAT                  LONG
LAI                  TIME

N_TABLE              QUEUE,PRE(N)
NOMKEY                 STRING(24)
DAUDZUMS               DECIMAL(12,3)
CENA                   DECIMAL(12,2)
NOM_VAL                STRING(3)
SUMMA_B                DECIMAL(14,2)
SUMMA_P                DECIMAL(14,2)
SUMMA_X                DECIMAL(14,2)
PVN                    DECIMAL(12,2)
                     .

K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(14,2)
                     .

VIRSRAKSTS              STRING(110)
FILTRS_TEXT             STRING(100)
FORMA                   STRING(10)
UZC_PR                  DECIMAL(5,1)
UZC_PRK                 DECIMAL(5,1)

!----------------------------------------------------------------------
report REPORT,AT(10,1720,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(10,500,12000,1219),USE(?unnamed)
         LINE,AT(104,1198,11323,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Vçrtîba pçc'),AT(9948,781,906,208),USE(?String19:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzc.%'),AT(10990,854,396,208),USE(?String19:14),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(8000,781,625,208),USE(?String19:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(8000,990,625,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmes'),AT(8750,781,1042,208),USE(?String19:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10917,729,0,521),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(11427,729,0,521),USE(?Line8:4),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(7188,781,729,208),USE(?String19:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8646,729,0,521),USE(?Line8),COLOR(COLOR:Black)
         LINE,AT(9844,729,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         STRING('Daudzums'),AT(6229,854,885,208),USE(?String19:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena ('),AT(5573,854,365,208),USE(?String19:12),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(573,781,1563,208),USE(?String19:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(2240,854,2813,208),USE(?String19:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,729,0,521),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(5521,729,0,521),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(6198,729,0,521),USE(?Line4:5),COLOR(COLOR:Black)
         STRING(@s1),AT(5938,854,104,208),USE(nokl_cp,,?nokl_cp:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,729,0,521),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(7969,729,0,521),USE(?Line4:4),COLOR(COLOR:Black)
         STRING(@s21),AT(573,990,1563,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, '),AT(7156,990,531,208),USE(?String19:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7656,990,292,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ar PVN, valûtâ)'),AT(8750,990,1042,208),USE(?String19:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('. cenas bez PVN'),AT(9969,990,938,208),USE(?String19:10),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(')'),AT(6042,854,104,208),USE(?String19:13),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3094,52,5313,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(1260,292,8979,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(10740,354,667,156),USE(FORMA),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(10802,521,,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s100),AT(1646,510,8250,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,11333,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(156,781,365,208),USE(?String19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1250,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s1),AT(9865,990,104,208),USE(nokl_cp,,?nokl_cp:3),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1250,0,-521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(0,0,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(8677,10,833,156),USE(SUMMA_P),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(9552,10,260,156),USE(NOL_VAL),CENTER,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7969,0,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(7188,10,729,156),USE(SUMMA_B),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9844,0,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(9865,10,,156),USE(SUMMA_X),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(10646,10,260,156),USE(NOM_VAL),TRN,CENTER,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_6.1),AT(10979,21,,156),USE(UZC_PR),TRN,RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(11427,0,0,198),USE(?Line11:12),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(8021,10,573,156),USE(SUMMA_pvn),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8646,0,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         LINE,AT(10917,0,0,198),USE(?Line11:9),COLOR(COLOR:Black)
         LINE,AT(521,0,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@s21),AT(573,10,1563,156),USE(RPT_nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2188,0,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@s55),AT(2240,10,3281,156),USE(NOSAUKUMS),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5521,0,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(5573,10,573,156),USE(CENA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6198,0,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(6250,10,833,156),USE(DAUDZUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7135,0,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         LINE,AT(104,0,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@N_4),AT(156,10,,156),USE(NPK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(104,0,0,114),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(521,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(2188,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,114),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,114),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,114),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,114),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(10917,0,0,114),USE(?Line125:2),COLOR(COLOR:Black)
         LINE,AT(11427,0,0,114),USE(?Line125:3),COLOR(COLOR:Black)
         LINE,AT(104,52,11333,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@s3),AT(9563,10,260,156),USE(VALK),CENTER,FONT(,8,,FONT:regular)
         LINE,AT(7135,0,0,198),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,198),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line28:4),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(8698,10,833,156),USE(SUMMA_PK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9844,0,0,198),USE(?Line128:5),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(6250,10,833,156),USE(DAUDZUMSk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10917,0,0,198),USE(?Line128:586),COLOR(COLOR:Black)
         STRING(@N-_14.2b),AT(7188,10,729,156),USE(SUMMA_BK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_14.2b),AT(9958,10,833,156),USE(SUMMA_XK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_6.1B),AT(10979,21,,156),USE(UZC_PRK),TRN,RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(11427,0,0,198),USE(?Line128:2),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(8021,10,573,156),USE(SUMMA_pvnk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(104,0,0,198),USE(?Line28),COLOR(COLOR:Black)
         STRING(@s20),AT(365,10,1302,156),USE(kopa),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,219),USE(?unnamed:2)
         LINE,AT(104,0,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(7135,0,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,63),USE(?Line137:2),COLOR(COLOR:Black)
         LINE,AT(10917,0,0,63),USE(?Line137),COLOR(COLOR:Black)
         LINE,AT(11427,0,0,63),USE(?Line137:3),COLOR(COLOR:Black)
         LINE,AT(104,52,11333,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(125,73,573,167),USE(?String50),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(698,73),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1563,73,260,167),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1823,73,125,167),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(10385,73,521,167),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10990,73,417,167),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,8000,12000,63),USE(?unnamed:4)
         LINE,AT(-52,0,11333,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  DAT = TODAY()
  LAI = CLOCK()
  FORMA='FORMA IZ7'

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
!  BIND(PAV:RECORD)
  BIND(PAR:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izgâjuðâs pret X-cenu'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa par izgâjuðâm ('&D_K&') precçm (S-nom,RC) no '&format(S_DAT,@d06.)&' lîdz '&format(B_DAT,@d06.)&|
      ' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('111111000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
      ELSE
         FILTRS_TEXT=GETFILTRS_TEXT('110011000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETPAR_K(PAR_NR,2,2)
      .
      CN = 'N1001110'
!           12345678
      CP = 'N11'

      CLEAR(nol:RECORD)
      NOL:DATUMS = s_dat
      NOL:D_K = D_K
      IF PAR_NR = 999999999                 !Izgâjuðâs/PIC (NOM) visiem
         SET(nol:DAT_KEY,NOL:DAT_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
      ELSE                                  !Izgâjuðâs/PIC (NOM) KONKRÇTAM
         NOL:PAR_NR=PAR_NR
         SET(nol:PAR_KEY,NOL:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
      .
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
          IF ~OPENANSI('IZGMAT5.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Npk'&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Cena ('&nokl_cp&')'&CHR(9)&|
!             'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&'PVN,Ls'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&|
!             'Vçrtîba pçc'&CHR(9)&CHR(9)&'Uzc.%'
             OUTA:LINE='Npk'&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Cena ('&nokl_cp&')'&CHR(9)&|
             'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&'PVN,'&val_uzsk&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&|
             'Vçrtîba pçc'&CHR(9)&CHR(9)&'Uzc.%'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,Ls'&CHR(9)&CHR(9)&'ar PVN, valûtâ'&|
!             CHR(9)&CHR(9)&NOKL_CP&'. cenas bez PVN'
             OUTA:LINE=CHR(9)&NOMENKLAT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,'&val_uzsk&CHR(9)&CHR(9)&'ar PVN, valûtâ'&|
             CHR(9)&CHR(9)&NOKL_CP&'. cenas bez PVN'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Npk'&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Cena ('&nokl_cp&')'&CHR(9)&|
!             'Daudzums'&CHR(9)&'Vçrtîba bez PVN'&CHR(9)&'PVN,Ls'&CHR(9)&'Pçc pavadzîmes ar PVN, valûtâ'&CHR(9)&CHR(9)&|
!             'Vçrtîba pçc '&NOKL_CP&'. cenas bez PVN'&CHR(9)&CHR(9)&'Uzc.%'
             OUTA:LINE='Npk'&CHR(9)&'Nomenklatûra'&CHR(9)&'Preces Nosaukums'&CHR(9)&'Cena ('&nokl_cp&')'&CHR(9)&|
             'Daudzums'&CHR(9)&'Vçrtîba bez PVN'&CHR(9)&'PVN,'&val_uzsk&CHR(9)&'Pçc pavadzîmes ar PVN, valûtâ'&CHR(9)&CHR(9)&|
             'Vçrtîba pçc '&NOKL_CP&'. cenas bez PVN'&CHR(9)&CHR(9)&'Uzc.%'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
!        G#=GETPAVADZ(NOL:U_NR)
        IF NOM_TIPS7='PTAKRIV' OR INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),NOM_TIPS7)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
           NOM_VAL=GETNOM_K(NOL:NOMENKLAT,0,13)
           SUMMA_PK   += CALCSUM(16,2)         ! AR PVN Ls
           SUMMA_BK   += CALCSUM(15,2)         ! BEZ PVN Ls
           SUMMA_PVNK += CALCSUM(17,2)         ! PVN Ls
           SUMMA_XK   += NOL:DAUDZUMS*CENA*BANKURS(NOM_VAL,TODAY())
   !!        ELSE
   !!          SUMMA_PK += CENA*nol:daudzums
   !!        .
   !*************************SADALAM PÇC VALÛTÂM********
           GET(K_TABLE,0)
           K:VAL=NOL:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL     = NOL:VAL
             K:SUMMA_P = CALCSUM(4,2)
             ADD(K_TABLE,K:VAL)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P += CALCSUM(4,2)
             PUT(K_TABLE)
           .
   !*************************SADALAM PÇC NOMENKLATÛRÂM & VALÛTÂM********
           GET(N_TABLE,0)
           N:NOMKEY=NOL:NOMENKLAT&NOL:VAL
           GET(N_TABLE,N:NOMKEY)
           IF ERROR()
             N:DAUDZUMS  = NOL:DAUDZUMS
             N:CENA      = CENA
             N:NOM_VAL   = NOM_VAL
             N:SUMMA_P   = CALCSUM(4,2)
             N:SUMMA_B   = CALCSUM(15,2)
             N:SUMMA_X   = NOL:DAUDZUMS*CENA
             N:PVN       = CALCSUM(17,2)
             ADD(N_TABLE)
             SORT(N_TABLE,N:NOMKEY)
           ELSE
             N:DAUDZUMS += NOL:DAUDZUMS
             N:SUMMA_P  += CALCSUM(4,2)
             N:SUMMA_B  += CALCSUM(15,2)
             N:SUMMA_X  += NOL:DAUDZUMS*CENA
             N:PVN      += CALCSUM(17,2)
             PUT(N_TABLE)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP N#=1 TO RECORDS(N_TABLE)
      GET(N_TABLE,N#)
      NOSAUKUMS     = GETNOM_K(N:NOMKEY[1:21],2,2)
      MERVIEN       = NOM:MERVIEN
      RPT_NOMENKLAT = N:NOMKEY[1:21]
      DAUDZUMS      = N:DAUDZUMS
      CENA          = N:CENA
      NOM_VAL       = N:NOM_VAL
      SUMMA_P       = N:SUMMA_P
      NOL_VAL       = N:NOMKEY[22:24]
      SUMMA_B       = N:SUMMA_B
      SUMMA_PVN     = N:PVN
      SUMMA_X       = N:SUMMA_X
      UZC_PR        = (SUMMA_B/SUMMA_X)*100-100

      NPK          += 1
      DAUDZUMSK    += DAUDZUMS
      IF ~F:DTK
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSE
          OUTA:LINE=NPK&CHR(9)&RPT_NOMENKLAT&CHR(9)&NOSAUKUMS&CHR(9)&LEFT(format(CENA,@N_10.2))&CHR(9)&|
          LEFT(format(DAUDzums,@n-_14.3))&CHR(9)&LEFT(format(SUMMA_B,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N_10.2))&|
          CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_14.2))&CHR(9)&NOL_VAL&CHR(9)&LEFT(FORMAT(SUMMA_X,@N_14.2))&CHR(9)&NOM_VAL&|
          CHR(9)&LEFT(FORMAT(UZC_PR,@N-6.1))
          ADD(OUTFILEANSI)
        .
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
!****************************DRUKÂJAM KOPÂ Ls **************
    KOPA = 'Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    UZC_PRK = (SUMMA_BK/SUMMA_XK)*100-100
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDzumsK,@n-_14.3))&CHR(9)&|
!        LEFT(format(SUMMA_BK,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&|
!        CHR(9)&VALK&CHR(9)&LEFT(FORMAT(SUMMA_XK,@N_14.2))&CHR(9)&'Ls'&CHR(9)&LEFT(FORMAT(UZC_PRK,@N-6.1))
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDzumsK,@n-_14.3))&CHR(9)&|
        LEFT(format(SUMMA_BK,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))&|
        CHR(9)&VALK&CHR(9)&LEFT(FORMAT(SUMMA_XK,@N_14.2))&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(UZC_PRK,@N-6.1))
        ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    SUMMA_PK   = 0
    SUMMA_XK   = 0
    KOPA='t.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      !IF RECORDS(K_TABLE)=1 AND (K:VAL='Ls' OR K:VAL='LVL') THEN BREAK.
      IF RECORDS(K_TABLE)=1 AND ((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk) THEN BREAK.
      IF K:SUMMA_P <>0
        SUMMA_PK = K:SUMMA_P
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(Format(DAUDzumsK,@n-_14.3))&CHR(9)&|
            LEFT(format(SUMMA_BK,@N-_14.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_10.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA_PK,@N-_14.2))&CHR(9)&VALK&CHR(9)&LEFT(FORMAT(SUMMA_XK,@N_14.2))
            ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)                          
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
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
  FREE(K_TABLE)
  FREE(N_TABLE)
  IF FilesOpened
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
  IF PAR_NR = 999999999                 !Izgâjuðâs/XC (NOM) visiem
     IF NOL:DATUMS>B_DAT THEN BREAK#=TRUE.
  ELSE                                  !Izgâjuðâs/XC (NOM) KONKRÇTAM
     IF ~(NOL:PAR_NR=PAR_NR AND NOL:DATUMS<=B_DAT) THEN BREAK#=TRUE.
  .
  IF ERRORCODE() OR BREAK#
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
Sel_Par_Tips5 PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
par_tips1   string(1)
par_tips2   string(1)
par_tips3   string(1)
par_tips4   string(1)
par_tips5   string(1)
par_tips6   string(1)
window               WINDOW('Partnera tips'),AT(,,103,101),GRAY
                       CHECK('Eksternâls (Rezidents)'),AT(6,10),USE(PAR_TIPS1),VALUE('E','')
                       CHECK('Fiziska persona'),AT(6,22),USE(PAR_TIPS2),VALUE('F','')
                       CHECK('Citas valsts (ES)'),AT(6,34),USE(PAR_TIPS3),VALUE('C','')
                       CHECK('Internâla noliktava'),AT(6,57),USE(PAR_TIPS5),VALUE('I','')
                       CHECK('Raþoðana'),AT(6,69),USE(PAR_TIPS6),VALUE('R','')
                       CHECK('Citas valsts (ne ES)'),AT(6,45),USE(PAR_TIPS4,,?PAR_TIPS4:2),VALUE('N','')
                       BUTTON('&OK'),AT(61,84,37,14),USE(?OkButton),DEFAULT
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  par_tips1 = par_tips[1]
  par_tips2 = par_tips[2]
  par_tips3 = par_tips[3]
  par_tips4 = par_tips[4]
  par_tips5 = par_tips[5]
  par_tips6 = par_tips[6]
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?PAR_TIPS1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        par_tips[1] = par_tips1
        par_tips[2] = par_tips2
        par_tips[3] = par_tips3
        par_tips[4] = par_tips4
        par_tips[5] = par_tips5
        par_tips[6] = par_tips6
        LocalResponse = RequestCompleted
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('Sel_Par_Tips5','winlats.INI')
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
  END
  IF WindowOpened
    INISaveWindow('Sel_Par_Tips5','winlats.INI')
    CLOSE(window)
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
  IF window{Prop:AcceptAll} THEN EXIT.
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
