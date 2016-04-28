                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_Izg_SNom           PROCEDURE                    ! Declare Procedure
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
NPK                  USHORT
RPT_NOMENKLAT        STRING(21)
NOSAUKUMS            STRING(30)
DAUDZUMSK            DECIMAL(14,3)
SUMMA_P              DECIMAL(14,2)
SUMMA_PK             DECIMAL(14,2)
SUMMA_B              DECIMAL(13,2)
SUMMA_BK             DECIMAL(13,2)
ITOGO                DECIMAL(14,2)
ITOGOK               DECIMAL(14,2)
SUMMA_PVN            DECIMAL(10,2)
SUMMA_PVNK           DECIMAL(10,2)
TRANS                DECIMAL(10,2)
TRANSK               DECIMAL(10,2)
ATL                  DECIMAL(14,2)
ATLK                 DECIMAL(14,2)
SVARS                DECIMAL(14,2)
SVARSK               DECIMAL(14,2)
SUMMA_C              DECIMAL(13,2)
SUMMA_CK             DECIMAL(13,2)
KOPA                 STRING(20)
NOS                  STRING(3)
VALK                 STRING(3)
DAT                  DATE
LAI                  TIME
NOS_P                STRING(35)
CN                   STRING(10)
CP                   STRING(3)
PIC_PROC             DECIMAL(6,1)

N_TABLE              QUEUE,PRE(N)
NOMKEY                  STRING(24)
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_P                 DECIMAL(14,2)
SUMMA_C                 DECIMAL(13,2)
PVN                     DECIMAL(12,2)
TRANS                   DECIMAL(12,2)
ATLAIDE                 DECIMAL(11,2)
ATL                     DECIMAL(14,2)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                     STRING(3)
SUMMA_P                 DECIMAL(14,2)
                     .
C_TABLE              QUEUE,PRE(C)
NOMENKLAT               STRING(21)
                     .

MERVIEN              STRING(7)
MER                  STRING(7)
DAUDZUMS             DECIMAL(12,3)
ATLAIDE              DECIMAL(11,2)
ATLAIDEK             DECIMAL(11,2)
DAUDZUMS_R           DECIMAL(12,2)
SUMMA_R              DECIMAL(12,2)
SUMMA_RB             DECIMAL(12,2)
filtrs_text          STRING(120)
VIRSRAKSTS           STRING(110)
FORMA_TEXT           STRING(10)
VAL_TEXT             STRING(15)
VAL                  STRING(3)
SECIBA               BYTE
VIRS1                STRING(16)
TAB2_TEXT            STRING(30) !NOM/FGR/AGR/RAZ+ NOSAUKUMS
TAB6_TEXT            STRING(15) ! Ls/VAL.

!--------------------------------------------------------------------------
report REPORT,AT(500,1750,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,500,12000,1188),USE(?unnamed:3)
         STRING(@s15),AT(6229,990,990,208),USE(TAB6_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaide'),AT(9406,990,625,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('daudzums'),AT(10083,990,625,208),USE(?String17:15),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pret PIC'),AT(8010,990,510,156),USE(?String17:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(9875,365,781,156),USE(FORMA_TEXT),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s120),AT(823,500,8958,208),USE(filtrs_text),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9979,521,677,156),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,729,10677,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4010,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(104,875,313,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(469,885,2125,208),USE(TAB2_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4042,885,677,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4740,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(4771,781,729,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(5552,781,625,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5563,990,625,156),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7240,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6198,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(6229,781,990,208),USE(?String17:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâds,'),AT(7281,781,677,208),USE(?String17:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7292,990,677,156),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7969,729,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Kopâ, '),AT(8573,781,781,208),USE(?String17:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(8583,990,781,156),USE(val_uzsk,,?val_uzsk:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s.'),AT(9406,781,625,208),USE(?String17:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10052,729,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(10729,729,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(9375,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(8542,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('bez PVN, '),AT(4760,990,500,156),USE(?String17:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5292,990,229,156),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1198,10677,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5521,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(3125,0,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(10083,781,625,208),USE(?String17:141),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzcen.% '),AT(8000,781,510,208),USE(?String17:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(1125,250,8375,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@n-_14.2),AT(6250,10,677,156),USE(SUMMA_P),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,0,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@n_4),AT(104,10,260,156),CNT,USE(npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,0,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@s21),AT(448,10,1563,156),USE(rpt_NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(2083,10,1927,156),USE(NOSAUKUMS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4010,0,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@n-_13.3b),AT(4042,0,680,156),USE(DAUDZUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,0,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(4792,10,677,156),USE(SUMMA_b),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5521,0,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@s3),AT(6969,10,260,156),USE(NOS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_13.2),AT(7271,10,677,156),USE(SUMMA_C),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7240,0,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         STRING(@n_10.2),AT(5573,10,573,156),USE(SUMMA_PVN),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6198,0,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         LINE,AT(8542,0,0,198),USE(?Line11:9),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(8563,10,802,156),USE(ITOGO),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9375,0,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         STRING(@n-_11.2),AT(9427,10,573,156),USE(ATLAIDE),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10052,0,0,198),USE(?Line11:13),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(10104,10,573,156),USE(ATL),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_6.1),AT(8094,10,354,156),USE(PIC_PROC,,?PIC_PROC:2),TRN,RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10729,0,0,198),USE(?Line11:12),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:5)
         STRING(@n-_14.2),AT(6219,10,729,156),USE(SUMMA_P,,?SUMMA_P:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,0,0,198),USE(?Line111),COLOR(COLOR:Black)
         STRING(@n_4),AT(104,10,260,156),CNT,USE(npk,,?NPK:1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(417,0,0,198),USE(?Line111:2),COLOR(COLOR:Black)
         LINE,AT(802,0,0,198),USE(?Line111:3),COLOR(COLOR:Black)
         STRING(@s4),AT(469,10,313,156),USE(rpt_NOMENKLAT,,?rpt_NOMENKLAT:2),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(885,10,3073,156),USE(NOSAUKUMS,,?NOSAUKUMS:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4010,0,0,198),USE(?Line11:14),COLOR(COLOR:Black)
         STRING(@n-_13.3b),AT(4042,10,677,156),USE(DAUDZUMS,,?DAUDZUMS:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,0,0,198),USE(?Line11:15),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(4760,10,729,156),USE(SUMMA_b,,?SUMMA_b:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5521,0,0,198),USE(?Line11:16),COLOR(COLOR:Black)
         STRING(@s3),AT(6958,10,260,156),USE(NOS,,?NOS:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2),AT(7271,21,677,156),USE(SUMMA_C,,?SUMMA_C:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_11.2),AT(9448,21,573,156),USE(ATLAIDE,,?ATLAIDE:2),TRN,RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_6.1),AT(8094,21,354,156),USE(PIC_PROC),TRN,RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(9375,0,0,198),USE(?Line11:22),COLOR(COLOR:Black)
         LINE,AT(7240,0,0,198),USE(?Line11:18),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line11:19),COLOR(COLOR:Black)
         STRING(@n-_10.2),AT(5583,10,573,156),USE(SUMMA_PVN,,?SUMMA_PVN:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6198,0,0,198),USE(?Line11:17),COLOR(COLOR:Black)
         LINE,AT(8542,0,0,198),USE(?Line11:20),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(8563,10,800,156),USE(ITOGO,,?ITOGO:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10052,0,0,198),USE(?Line11:21),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(10104,10,573,156),USE(ATL,,?ATL:2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(10729,0,0,198),USE(?Line111:12),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(52,,10677,0),USE(?Line22),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(52,,0,198),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(4740,,0,198),USE(?Line21:9),COLOR(COLOR:Black)
         LINE,AT(5521,,0,198),USE(?Line21:8),COLOR(COLOR:Black)
         LINE,AT(6198,,0,198),USE(?Line21:7),COLOR(COLOR:Black)
         LINE,AT(7240,,0,198),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(7969,,0,198),USE(?Line21:10),COLOR(COLOR:Black)
         LINE,AT(8542,,0,198),USE(?Line21:4),COLOR(COLOR:Black)
         LINE,AT(9375,,0,198),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(10052,,0,198),USE(?Line21:5),COLOR(COLOR:Black)
         LINE,AT(10729,,0,198),USE(?Line21:11),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(6250,10,677,156),USE(SUMMA_PK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(6979,10,260,156),USE(VALK),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.3b),AT(3750,10,938,156),USE(DAUDZUMSk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2b),AT(4792,10,677,156),USE(SUMMA_BK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(5573,10,573,156),USE(SUMMA_PVNK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_13.2B),AT(7292,10,677,156),USE(SUMMA_CK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2b),AT(8594,10,729,156),USE(ITOGOK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_11.2B),AT(9427,10,573,156),USE(ATLAIDEK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s20),AT(313,10,1510,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT2V DETAIL,AT(,,,177),USE(?F2V)
         LINE,AT(7240,0,0,198),USE(?Line21V:3),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line21V:10),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(6250,10,677,156),USE(SUMMA_PK,,?SUMMAPK:V),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(6979,10,260,156),USE(VALK,,?VALK:V),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8542,0,0,198),USE(?Line21V:4),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,198),USE(?Line21V:5),COLOR(COLOR:Black)
         LINE,AT(10729,0,0,198),USE(?Line21V:11),COLOR(COLOR:Black)
         LINE,AT(9375,0,0,198),USE(?Line21V:6),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,198),USE(?Line21V:9),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,198),USE(?Line21V:8),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,198),USE(?Line21V:7),COLOR(COLOR:Black)
         STRING(@s20),AT(313,10,1510,156),USE(KOPA,,?KOPA:V),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(52,0,0,198),USE(?Line21V:2),COLOR(COLOR:Black)
       END
RPT_FOOT2A DETAIL,AT(,,,177),USE(?F2A)
         LINE,AT(52,0,0,198),USE(?Line21A:2),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,198),USE(?Line21A:9),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,198),USE(?Line21A:8),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,198),USE(?Line21A:7),COLOR(COLOR:Black)
         LINE,AT(7240,0,0,198),USE(?Line21A:3),COLOR(COLOR:Black)
         LINE,AT(7969,0,0,198),USE(?Line21A:10),COLOR(COLOR:Black)
         LINE,AT(8542,0,0,198),USE(?Line21A:4),COLOR(COLOR:Black)
         LINE,AT(9375,0,0,198),USE(?Line21A:6),COLOR(COLOR:Black)
         LINE,AT(10052,0,0,198),USE(?Line21A:5),COLOR(COLOR:Black)
         LINE,AT(10729,0,0,198),USE(?Line21A:11),COLOR(COLOR:Black)
         STRING(@n-_14.2B),AT(6250,10,677,156),USE(SUMMA_PK,,?SUMMAPK:A),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(6979,10,260,156),USE(VALK,,?VALK:A),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.3b),AT(3750,10,938,156),USE(DAUDZUMSK,,?DAUDZUMSK:A),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2b),AT(4792,10,677,156),USE(SUMMA_BK,,?SUMMA_BK:A),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_14.2b),AT(8594,10,729,156),USE(ITOGOK,,?ITOGOK:A),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s20),AT(313,10,1510,156),USE(KOPA,,?KOPA:A),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,146),USE(?F3)
         LINE,AT(52,,10677,0),USE(?Line22:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(83,21,479,125),USE(?String50),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(563,21,458,125),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1333,21,208,125),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1542,21,125,125),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(9729,21,521,125),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10323,21,417,125),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(500,8000,12000,63)
         LINE,AT(,,10677,0),USE(?Line22:3),COLOR(COLOR:Black)
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
!******************* izziòa par V/K IZGÂJUÐÂM precçm
!                    Saspiesta pçc Nomenklatûrâm/GRUPÂM/APAKÐGRUPÂM/RAÞOTÂJIEM
!
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('NOMENKLAT',NOMENKLAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('PAR_TIPS',PAR_TIPS)
  BIND('PAR_GRUPA',PAR_GRUPA)
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAR_K::Used = 0            !DÇÏ CYCLEPARK
     CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF NOM_K::Used = 0            !DÇÏ GETNOM_K
     CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1              !DÇÏ VIEWA
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      EXECUTE OPCIJA_NR
         VIRS1='S_NOMENKLATÛRÂM'
         VIRS1='S_NOM_GRUPÂM'
         VIRS1='S_NOM_A_GRUPÂM'
         VIRS1='S_NOM_RAÞOTÂJIEM'
      .
      VIRSRAKSTS='Izziòa par izgâjuðajâm ('&D_K&') precçm ('&CLIP(VIRS1)&') no '&FORMAT(s_DAT,@D06.)&' lîdz '&|
      FORMAT(b_DAT,@D06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FORMA_TEXT='FORMA IZ'&CLIP(OPCIJA_NR+1)
      IF F:DBF = 'W'
         EXECUTE OPCIJA_NR
            TAB2_TEXT='Nomenklatûra, Nosaukums'
            TAB2_TEXT='Grupa, Nosaukums'
            TAB2_TEXT='Grupa, apakðgrupa, Nosaukums'
            TAB2_TEXT='Raþotâja kods, Nosaukums'
         .
      ELSE !WORDAM & EXCELIM SAVÂS KOLONNÂS
         EXECUTE OPCIJA_NR
            TAB2_TEXT='Nomenklatûra'
            TAB2_TEXT='Grupa'
            TAB2_TEXT='Grupa, apakðgrupa'
            TAB2_TEXT='Raþotâja kods'
         .
      .
      IF F:DTK ! LATOS
         TAB6_TEXT='ar PVN, Ls'
      ELSE
         TAB6_TEXT='ar PVN, VAL'
      .
!      IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
      IF PAR_NR=999999999  !VISI
         FORMA_TEXT=CLIP(FORMA_TEXT)&'V'
         FILTRS_TEXT=GETFILTRS_TEXT('111110000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
      ELSE
         FORMA_TEXT=CLIP(FORMA_TEXT)&'P'
         FILTRS_TEXT=GETFILTRS_TEXT('110010000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs:'&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_ADRESE(PAR_NR,ADR_NR,0,0)
      .
!      ELSE
!         FILTRS_TEXT=GETFILTRS_TEXT('110011100') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
!         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs:'&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_ADRESE(PAR_NR,ADR_NR,0,0)
!         SAN_DOK_TEXT='Dokumenta Nr'
!      .
      IF ~(PAR_NR=999999999)                 !KONKRÇTS
         SECIBA=3
      ELSIF NOMENKLAT[1]                     !IR JÇGA FILTRÇT PÇC NOMENKLATÛRAS
         SECIBA=2
      ELSE
         SECIBA=1
      .
      CP = 'N11' !P/N/paR_k/ggK,grupa,EFCNIR
      CLEAR(nol:RECORD)
      CASE SECIBA
      OF 1
         CN = 'N1001111'  !P/N,RS,tikaiDKP,INR(SB_DAT),D_K=D_K,OBJ,NODALA,ADR_NR
!              12345678
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:DAT_KEY,nol:DAT_KEY)        !DATUMU
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT) AND ~CYCLEPAR_K(CP)'
      OF 2
         CN = 'N1011111'
!              12345678
         NOL:NOMENKLAT=NOMENKLAT
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:NOM_KEY,nol:NOM_KEY)        !NOMENKLATÛRU
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
      OF 3
         CN = 'N1011111'
!              12345678
         NOL:PAR_NR = PAR_NR
         NOL:DATUMS = s_dat
         NOL:D_K = D_K
         SET(nol:PAR_KEY,NOL:PAR_KEY)        !PARTNERU
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
          IF ~OPENANSI('IZGNOM.TXT')
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
!             OUTA:LINE='Npk'&CHR(9)&TAB2_TEXT&CHR(9)&'Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&|
!             'PVN,Ls'&CHR(9)&'Vçrtîba ar'&CHR(9)&CHR(9)&'Parâds,'&CHR(9)&'Kopâ,Ls'&CHR(9)&|
!             't.sk. atlaide'&CHR(9)&'Atlikums'&CHR(9)&'Svars'
             OUTA:LINE='Npk'&CHR(9)&TAB2_TEXT&CHR(9)&'Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez'&CHR(9)&|
             'PVN,'&val_uzsk&CHR(9)&'Vçrtîba ar'&CHR(9)&CHR(9)&'Parâds,'&CHR(9)&'Kopâ,'&val_uzsk&CHR(9)&|
             't.sk. atlaide'&CHR(9)&'Atlikums'&CHR(9)&'Svars'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,Ls'&CHR(9)&CHR(9)&TAB6_TEXT&CHR(9)&'Ls'&CHR(9)&'daudzums'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PVN,'&val_uzsk&CHR(9)&CHR(9)&TAB6_TEXT&CHR(9)&val_uzsk&CHR(9)&'daudzums'
             ADD(OUTFILEANSI)
          ELSE !WORD
!             OUTA:LINE='Npk'&CHR(9)&TAB2_TEXT&CHR(9)&'Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez PVN,Ls'&CHR(9)&|
!             'PVN,Ls'&CHR(9)&'Vçrtîba '&CLIP(TAB6_TEXT)&CHR(9)&CHR(9)&'Parâds, Ls'&CHR(9)&'Kopâ,Ls'&CHR(9)&|
!             't.sk. atlaide'&CHR(9)&'Atlikums daudzums'&CHR(9)&'Svars'
             OUTA:LINE='Npk'&CHR(9)&TAB2_TEXT&CHR(9)&'Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Vçrtîba bez PVN,'&val_uzsk&CHR(9)&|
             'PVN,'&val_uzsk&CHR(9)&'Vçrtîba '&CLIP(TAB6_TEXT)&CHR(9)&CHR(9)&'Parâds, '&val_uzsk&CHR(9)&'Kopâ,'&val_uzsk&CHR(9)&|
             't.sk. atlaide'&CHR(9)&'Atlikums daudzums'&CHR(9)&'Svars'
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
!        IF (~NOMENKLAT[1] OR (NOMENKLAT[1] AND ~CYCLENOM(NOL:NOMENKLAT))) AND|
        IF ~(SECIBA=2 AND CYCLENOM(NOL:NOMENKLAT)) AND|
           ~((F:DIENA='N' AND ~BAND(NOL:BAITS,00000100b)) OR (F:DIENA='D' AND BAND(NOL:BAITS,00000100b)))
              K:VAL=NOL:VAL
              GET(K_TABLE,K:VAL)
              IF ERROR()
                K:VAL=NOL:VAL
                K:SUMMA_P = CALCSUM(4,2)   !AR PVN VAL-A
                ADD(K_TABLE,K:VAL)
                SORT(K_TABLE,K:VAL)
              ELSE
                K:SUMMA_P+=CALCSUM(4,2)
                PUT(K_TABLE)
              .
      !*************************SADALAM PÇC NOMENKLATÛRÂM/Grupâm/Apakðgrupâm ********
              IF F:DTK                     !PÂRRÇÍINÂT LATOS
                 SUMMA_P=CALCSUM(16,2)     !AR PVN Ls-A
                 !VAL='Ls'
                 VAL=val_uzsk
              ELSE
                 SUMMA_P=CALCSUM(4,2)      !AR PVN VAL-A
                 VAL=NOL:VAL
              .
              GET(C_TABLE,0)
              C:NOMENKLAT=NOL:NOMENKLAT
              ATL#=FALSE
              GET(C_TABLE,C:NOMENKLAT)
              IF ERROR()
                 ATL#=TRUE
                 ADD(C_TABLE)
                 SORT(C_TABLE,C:NOMENKLAT)
              .
              GET(N_TABLE,0)
              EXECUTE OPCIJA_NR
                 N:NOMKEY=NOL:NOMENKLAT&VAL
                 N:NOMKEY=NOL:NOMENKLAT[1:3]&VAL
                 N:NOMKEY=NOL:NOMENKLAT[1:4]&VAL
                 N:NOMKEY=NOL:NOMENKLAT[19:21]&VAL
              .
              GET(N_TABLE,N:NOMKEY)
              IF ERROR()
                N:DAUDZUMS =NOL:DAUDZUMS
                N:SUMMA_B  =CALCSUM(15,2)
                N:SUMMA_P  =SUMMA_P
                IF BAND(NOL:BAITS,00000001b)  
                  N:SUMMA_C = CALCSUM(16,2)  !AR PVN Ls-A
                ELSE
                  N:SUMMA_C = 0
                .
                N:PVN      =CALCSUM(17,2)
                N:ATLAIDE  =CALCSUM(7,2)
                IF ATL#=TRUE
                   N:ATL=GETNOM_A(NOL:NOMENKLAT,1,0)
                ELSE
                   N:ATL=0
                .
                ADD(N_TABLE)
                SORT(N_TABLE,N:NOMKEY)
              ELSE
                N:DAUDZUMS+=NOL:DAUDZUMS
                N:SUMMA_B +=CALCSUM(15,2)     !BEZ PVN LS-A
                N:SUMMA_P +=SUMMA_P
                IF BAND(NOL:BAITS,00000001b)  !IR PARÂDS
                  N:SUMMA_C += CALCSUM(16,2)  !AR PVN Ls-A
                .
                N:PVN     += CALCSUM(17,2)    !PVN LS-A
                N:ATLAIDE += CALCSUM(7,2)
                IF ATL#=TRUE
                   N:ATL  += GETNOM_A(NOL:NOMENKLAT,1,0)
                .
                PUT(N_TABLE)
              .
!           .
           IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
             DAUDZUMS_R += NOL:DAUDZUMS
             SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
             SUMMA_RB   += CALCSUM(15,2)
           END
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
      NPK+=1
      CASE OPCIJA_NR
      OF 1
         RPT_NOMENKLAT= N:NOMKEY[1:21]
         NOSAUKUMS    = GETNOM_K(N:NOMKEY[1:21],2,2)
         NOS          = N:NOMKEY[22:24]
         SVARS        = NOM:SVARSKG
      OF 2
         RPT_NOMENKLAT= N:NOMKEY[1:3]
         NOSAUKUMS    = GETGRUPA(N:NOMKEY[1:3],0,1)
         NOS          = N:NOMKEY[4:6]
      OF 3
         RPT_NOMENKLAT= N:NOMKEY[1:4]
         NOSAUKUMS    = GETGRUPA2(N:NOMKEY[1:4],0,1)
         NOS          = N:NOMKEY[5:7]
      OF 4
         RPT_NOMENKLAT= N:NOMKEY[1:3]
         CLEAR(PAR:RECORD)
         PAR:NOS_U=N:NOMKEY[1:3]
         GET(PAR_K,PAR:NOS_U_KEY)
         NOSAUKUMS    = PAR:NOS_P
         NOS          = N:NOMKEY[4:6]
      .
      DAUDZUMS  = N:DAUDZUMS
      SUMMA_B   = N:SUMMA_B
      PIC_PROC  = (SUMMA_B/DAUDZUMS-GETNOM_K(N:NOMKEY[1:21],0,7,6))/GETNOM_K(N:NOMKEY[1:21],0,7,6)*100
      MERVIEN   = NOM:MERVIEN
      SUMMA_P   = N:SUMMA_P
      SUMMA_PVN = N:PVN
      SUMMA_C   = N:SUMMA_C
      TRANS     = N:TRANS
      ATLAIDE   = N:ATLAIDE
      ITOGO     = N:SUMMA_B + N:PVN
      ATL       = N:ATL
      SVARS     = SVARS*DAUDZUMS

      SUMMA_BK   += SUMMA_B
      SUMMA_PVNK += SUMMA_PVN
      SUMMA_PK   += N:SUMMA_B+N:PVN
      DAUDZUMSK  += DAUDZUMS
      TRANSK     += TRANS
      ATLAIDEK   += ATLAIDE
      SUMMA_CK   += SUMMA_C
      ITOGOK     += ITOGO
      ATLK       += ATL
      SVARSK     += SVARS

      IF F:DBF='W'
        EXECUTE OPCIJA_NR
           PRINT(RPT:DETAIL)
           PRINT(RPT:DETAIL1)
           PRINT(RPT:DETAIL1)
           PRINT(RPT:DETAIL1)
      .
      ELSE
        OUTA:LINE=NPK&CHR(9)&RPT_NOMENKLAT&CHR(9)&NOSAUKUMS&CHR(9)&LEFT(format(DAUDZUMS,@N-_14.3))&CHR(9)&|
        LEFT(FORMAT(SUMMA_B,@N-_13.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N-_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_14.2))&|
        CHR(9)&NOS&CHR(9)&LEFT(FORMAT(SUMMA_C,@N-_13.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(ATLAIDE,@N-_13.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_14.2))&CHR(9)&LEFT(FORMAT(SVARS,@N-_14.2))
        ADD(OUTFILEANSI)
      .
    .
    IF F:DBF='W'
        PRINT(RPT:LINE)
    .
!****************************DRUKÂJAM KOPÂ Ls **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDZUMSk,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_Bk,@N-_13.2))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PVNk,@N-_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_Pk,@N-_14.2))&CHR(9)&valk&CHR(9)&|
        LEFT(FORMAT(SUMMA_Ck,@N-_13.2))&CHR(9)&LEFT(FORMAT(ITOGOk,@N-_14.2))&CHR(9)&|
        LEFT(FORMAT(ATLAIDEK,@N-_13.2))&CHR(9)&LEFT(FORMAT(ATLK,@N-_14.2))&CHR(9)&LEFT(FORMAT(SVARSK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
!****************************PÇC VALÛTÂM*******************
    KOPA='t.s.'
    !IF RECORDS(K_TABLE)>1 OR K:VAL<>'Ls'
    IF RECORDS(K_TABLE)>1 OR ((~(K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL<>val_uzsk))
      GET(K_TABLE,0)
       LOOP J# = 1 TO RECORDS(K_TABLE)
         GET(K_TABLE,J#)
         IF K:SUMMA_P>0
           SUMMA_PK = K:SUMMA_P
           VALK     = K:VAL
           IF F:DBF='W'
               PRINT(RPT:RPT_FOOT2V)
           ELSE
               OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_Pk,@N-_14.2B))&CHR(9)&valk&|
               CHR(9)&CHR(9)&CHR(9)&CHR(9)
               ADD(OUTFILEANSI)
           .
           kopa=''
         .
       .
    .
!****************************DRUKÂJAM ATGRIZTO PRECI*******************
    IF DAUDZUMS_R
        SUMMA_PK = 0
        ATLAIDEK = 0
        DAUDZUMSK = DAUDZUMS_R
        VALK     = ''
        ITOGOK    = SUMMA_R
        SUMMA_BK  = SUMMA_RB
        KOPA = 't.s. Atgrieztâ prece'
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2A)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(format(DAUDZUMSk,@N-_14.3B))&CHR(9)&LEFT(FORMAT(SUMMA_Bk,@N-_13.2B))&|
            CHR(9)&CHR(9)&CHR(9)&valk&CHR(9)&CHR(9)&LEFT(FORMAT(ITOGOk,@N-_14.2B))&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
        .
    END
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

!----------------------------------------------------------------------------------------
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
  FREE(C_TABLE)
  IF FilesOpened
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
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
  CASE SECIBA
  OF 1
    IF ERRORCODE() OR NOL:DATUMS>B_DAT THEN VISS#=TRUE.           !DATUMU
  OF 2
    IF ERRORCODE() OR CYCLENOM(NOL:NOMENKLAT)=2 THEN VISS#=TRUE.  !NOMENKLATÛRU
  OF 3
    IF ERRORCODE() OR ~(NOL:PAR_NR=PAR_NR) THEN VISS#=TRUE.       !PARTNERU
  .
  IF VISS#=TRUE
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
N_IzgPav             PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAV:SUMMA)
                     END
!------------------------------------------------------------------------

BANKURSS            REAL
ITOGO               DECIMAL(14,2)
ITOGOK              DECIMAL(14,2)
SUMMA_PVN           DECIMAL(10,2)
SUMMA_PVNK          DECIMAL(10,2)
SUMMA_TK            DECIMAL(10,2)
NR                  DECIMAL(4)
SUMMA_P             DECIMAL(14,2)
SUMMA_AK            DECIMAL(13,2)
SUMMA_B             DECIMAL(13,2)
KOPA                STRING(20)
SUMMA_PK            DECIMAL(14,2)
SUMMA_BK            DECIMAL(13,2)
SUMMAPAR            DECIMAL(13,2)
VALK                STRING(3)
PRECE               DECIMAL(13,2)
TARA                DECIMAL(13,2)
PAKALPOJUMI         DECIMAL(13,2)
DAT                 DATE
LAI                 TIME
PAR_NOS_P           LIKE(PAR:NOS_P) !VAI PAV:PAMAT

CN                  STRING(10)
CP                  STRING(3)

K_TABLE        QUEUE,PRE(K)
VAL              STRING(3)
SUMMA_P          DECIMAL(14,2)
SUMMA_AK         DECIMAL(13,2)
SUMMABK          DECIMAL(13,2)
SUMMApar         DECIMAL(13,2)
PVN              DECIMAL(12,2)
SUMMA_T          DECIMAL(10,2)
ITOGO            DECIMAL(14,2)
               .

SUMMA_R             DECIMAL(14,2)
SUMMA_RB            DECIMAL(14,2)
VIRSRAKSTS          STRING(110)
FILTRS_TEXT         STRING(100)
TAB_4_TEXT          STRING(10)

!-------------------------------------------------------------------------
report REPORT,AT(500,1719,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,500,12000,1219),USE(?unnamed)
         STRING('bez PVN, '),AT(5010,990,573,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5542,990,292,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu summa'),AT(5031,781,781,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pr,Tr PVN'),AT(5875,781,573,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6458,729,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5833,729,0,521),USE(?Line2:18),COLOR(COLOR:Black)
         STRING('ar PVN, valûtâ'),AT(6490,990,1094,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaide'),AT(7635,990,729,208),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(8396,990,552,208),USE(?String10:21),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valûtâ'),AT(9073,990,583,208),USE(?String10:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ, '),AT(5854,990,375,208),USE(?String10:20),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6177,990,271,208),USE(val_uzsk,,?val_uzsk:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sçrija,  numurs, rçíina Nr'),AT(1281,990,1469,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(677,990,573,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1250,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s45),AT(2771,10,4479,198),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(792,260,8417,198),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1073,500,7865,156),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ3'),AT(9771,365,833,156),USE(?String7),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9979,521,625,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,729,10469,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(240,906,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(677,781,573,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(1292,781,1250,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(3021,906,938,208),USE(TAB_4_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pçc pavadzîmes'),AT(6490,781,1094,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('tai skaitâ'),AT(7635,781,729,208),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s. Tran.'),AT(8396,781,550,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8958,729,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         STRING('Parâds,'),AT(8990,781,729,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, '),AT(9771,906,833,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(9781,906,833,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10625,729,0,521),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(9740,729,0,521),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(156,1198,10469,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(625,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2771,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5000,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7604,729,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(8385,729,0,521),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(156,729,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(625,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(656,10,573,156),USE(PAV:DATUMS),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1250,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         STRING(@S14),AT(1281,10,969,156),USE(PAV:DOK_SENR),RIGHT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(9771,10,833,156),USE(ITOGO),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S7),AT(2271,10,469,156),USE(PAV:REK_NR),RIGHT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(9740,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S45),AT(2802,10,2188,156),USE(PAR_NOS_P),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5000,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6510,10,781,156),USE(SUMMA_P),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(7344,10,260,156),USE(PAV:VAL),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6458,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(5865,10,573,156),USE(SUMMA_PVN),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5833,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5031,10,781,156),USE(SUMMA_B),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(8990,10,729,156),USE(pav:c_SUMMA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7604,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(7635,10,729,156),USE(pav:SUMMA_a),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8385,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(8417,10,521,156),USE(PAV:T_SUMMA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8958,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(208,10,365,156),USE(nR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(156,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,63),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(2771,-10,0,63),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(156,52,10469,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,115),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,115),USE(?Line120:2),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,115),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,115),USE(?Line120),COLOR(COLOR:Black)
         LINE,AT(8958,-10,0,115),USE(?Line120:3),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,115),USE(?Line520),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,115),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@N-_13.2B),AT(8990,10,729,156),USE(summaPar),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5000,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(8958,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(5865,10,573,156),USE(SUMMA_PVNK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2B),AT(5031,10,781,156),USE(SUMMA_bK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6458,-10,0,198),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(7635,10,729,156),USE(SUMMA_ak),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8385,-10,0,198),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@S20),AT(313,10,1615,156),USE(KOPA),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(9740,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(9771,10,833,156),USE(ITOGOK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_10.2B),AT(8417,10,521,156),USE(SUMMA_TK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(10625,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6510,10,781,156),USE(SUMMA_PK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(7344,10,260,156),USE(VALK),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT2A DETAIL,AT(,,,469),USE(?unnamed:4)
         LINE,AT(5833,-10,0,490),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,490),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('tara'),AT(698,146,313,156),USE(?String29:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(5031,146,781,156),USE(tara),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('pakalpojumi'),AT(229,313,781,156),USE(?String29:3),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(5031,313,781,156),USE(pakalpojumi),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('t.s.       prece'),AT(208,10,885,156),USE(?String29),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8385,-10,0,490),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,490),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,490),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,490),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,490),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,490),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5031,10,781,156),USE(prece),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8958,-10,0,490),USE(?Line2:37),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,229),USE(?unnamed:2)
         LINE,AT(5000,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,73,573,156),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(656,73,552,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1458,73,208,156),USE(?String38),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1667,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(9656,73,521,156),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10167,73,490,156),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(156,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(8385,-10,0,63),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(8958,-10,0,63),USE(?Line323),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,63),USE(?Line323:2),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,63),USE(?Line333),COLOR(COLOR:Black)
         LINE,AT(6458,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,63),USE(?Line33:386),COLOR(COLOR:Black)
         LINE,AT(156,52,10469,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,8000,12000,63)
         LINE,AT(156,0,10469,0),USE(?Line1:5),COLOR(COLOR:Black)
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

  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)

  KOPA='Kopâ :'
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::USED += 1
  IF PAVAD::Used = 0        !DÇÏ VIEWA
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          

  BIND(PAV:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izgâjuðâs pavadzîmes'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izgâjuðâs pavadzîmes ('&D_K&') no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      CN = 'P1001111' !P/N,RS,tikaiDKP,INR(SB_DAT),D_K=D_K,OBJ,NODALA,ADR_NR
!           12345678
      CP = 'P11'    !P/N/paR_k/ggK,grupa,EFCNIR
      CLEAR(PAV:RECORD)
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=GETFILTRS_TEXT('111100000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         TAB_4_TEXT='Saòçmçjs'
         SET(PAV:DAT_KEY,PAV:DAT_KEY) !-DATUMS-DK-DOK_SENR
         Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
       ELSE   !KONKRÇTS
         FILTRS_TEXT=GETFILTRS_TEXT('110000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                    123456789
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Saòçmçjs:'&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_ADRESE(PAR_NR,ADR_NR,0,0)
         TAB_4_TEXT='Pamatojums'
         PAV:PAR_NR=PAR_NR
         SET(PAV:PAR_KEY,PAV:PAR_KEY)
         Process:View{Prop:Filter} ='~CYCLENOL(CN)'
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
          IF ~OPENANSI('IZGPAV.TXT')
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
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Rçíina'&CHR(9)&TAB_4_TEXT&CHR(9)&|
!             'Preèu summa'&CHR(9)&'Preèu,Transp.'&CHR(9)&'Pçc P/Z'&CHR(9)&CHR(9)&'tai skaitâ'&CHR(9)&'t.s.Transports'&CHR(9)&|
!             'Parâds,'&CHR(9)&'Kopâ,Ls'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Rçíina'&CHR(9)&TAB_4_TEXT&CHR(9)&|
             'Preèu summa'&CHR(9)&'Preèu,Transp.'&CHR(9)&'Pçc P/Z'&CHR(9)&CHR(9)&'tai skaitâ'&CHR(9)&'t.s.Transports'&CHR(9)&|
             'Parâds,'&CHR(9)&'Kopâ,'&val_uzsk
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&'datums'&CHR(9)&'sçrija,numurs'&CHR(9)&'numurs'&CHR(9)&CHR(9)&'bez PVN,Ls'&CHR(9)&'PVN kopâ,Ls'&|
!             CHR(9)&'ar PVN,valûtâ'&CHR(9)&CHR(9)&'atlaide'&CHR(9)&'ar PVN'&CHR(9)&'valûtâ'
             OUTA:LINE=CHR(9)&'datums'&CHR(9)&'sçrija,numurs'&CHR(9)&'numurs'&CHR(9)&CHR(9)&'bez PVN,'&val_uzsk&CHR(9)&'PVN kopâ,'&val_uzsk&|
             CHR(9)&'ar PVN,valûtâ'&CHR(9)&CHR(9)&'atlaide'&CHR(9)&'ar PVN'&CHR(9)&'valûtâ'
             ADD(OUTFILEANSI)
          ELSE  !WORD
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta sçrija,numurs'&CHR(9)&'Rçíina numurs'&CHR(9)&|
!             TAB_4_TEXT&CHR(9)&'Preèu summa bez PVN,Ls'&CHR(9)&'Preèu, Transp. PVN kopâ,Ls'&CHR(9)&'Pçc P/Z ar PVN,valûtâ'&CHR(9)&CHR(9)&|
!             'tai skaitâ atlaide'&CHR(9)&'t.s. Transp. ar PVN'&CHR(9)&'Parâds, valûtâ'&CHR(9)&'Kopâ,Ls'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta datums'&CHR(9)&'Dokumenta sçrija,numurs'&CHR(9)&'Rçíina numurs'&CHR(9)&|
             TAB_4_TEXT&CHR(9)&'Preèu summa bez PVN,'&val_uzsk&CHR(9)&'Preèu, Transp. PVN kopâ,'&val_uzsk&CHR(9)&'Pçc P/Z ar PVN,valûtâ'&CHR(9)&CHR(9)&|
             'tai skaitâ atlaide'&CHR(9)&'t.s. Transp. ar PVN'&CHR(9)&'Parâds, valûtâ'&CHR(9)&'Kopâ,'&val_uzsk
             ADD(OUTFILEANSI)
          .
       .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF PAR_NR=999999999 !VISI
           IF ~PAV:PAR_NR
              PAR_NOS_P=PAV:NOKA
           ELSE
              PAR_NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
           .
        ELSE
           PAR_NOS_P=PAV:PAMAT
        .
        BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
        NR+=1
        ?Progress:UserString{Prop:Text}=NR
        DISPLAY(  ?Progress:UserString)
        summa_P    = PAV:SUMMA
        summa_B    = PAV:SUMMA_b*BANKURSS
!        SUMMA_PVN  = (PAV:SUMMA-PAV:SUMMA_B)*BANKURSS
        SUMMA_PVN  = (PAV:SUMMA-PAV:T_SUMMA-PAV:SUMMA_B)*BANKURSS          !PAV:SUMA_B IR BEZ TRANSPORTA
        SUMMA_PVN += (PAV:T_SUMMA-PAV:T_SUMMA/(1+PAV:T_PVN/100))*BANKURSS  !PAV:SUMA_B IR BEZ TRANSPORTA
!        ITOGO      = SUMMA_p*BANKURSS + PAV:T_SUMMA*BANKURSS !+PAV:C_SUMMA
        ITOGO      = PAV:SUMMA*BANKURSS
        K:VAL=PAV:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL      = PAV:VAL
          K:SUMMA_P  = summa_P
          K:SUMMA_T  = PAV:T_SUMMA
          ADD(K_TABLE)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P  += summa_P
          K:SUMMA_T  += PAV:T_SUMMA
          PUT(K_TABLE)
        .
        SUMMA_PVNK += SUMMA_PVN
        SUMMA_PK   += PAV:SUMMA*BANKURSS     !LS, PÇC TAM BÛS TS
        SUMMA_BK   += PAV:SUMMA_b*BANKURSS
        SUMMAPAR   += PAV:C_SUMMA*BANKURSS
        SUMMA_TK   += PAV:T_SUMMA*BANKURSS   !LS, PÇC TAM BÛS TS
        SUMMA_AK   += PAV:SUMMA_A*BANKURSS
        ITOGOK     += ITOGO
        IF PAV:SUMMA<0      !ATGRIEZTÂ PRECE
            SUMMA_R  += SUMMA_p*BANKURSS + PAV:T_SUMMA*BANKURSS !+PAV:C_SUMMA
            SUMMA_RB += PAV:SUMMA_B*BANKURSS
        END
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSE
            OUTA:LINE=CLIP(NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&PAV:DOK_SENR&CHR(9)&PAV:REK_NR&|
            CHR(9)&PAR_NOS_P&CHR(9)&LEFT(format(SUMMA_B,@N-_13.2))&CHR(9)&LEFT(format(SUMMA_PVN,@N-_10.2))&CHR(9)&|
            LEFT(format(SUMMA_P,@N-_14.2))&CHR(9)&PAV:VAL&CHR(9)&LEFT(format(pav:SUMMA_A,@N-_13.2))&CHR(9)&|
            LEFT(format(pav:t_summa,@N-_10.2))&CHR(9)&LEFT(format(pav:c_SUMMA,@N-_13.2))&CHR(9)&LEFT(format(ITOGO,@N-_14.2))
            ADD(OUTFILEANSI)
          .
        END
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
    END
!****************************DRUKÂJAM KOPÂ Ls UN PÇC valûtâm **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=CHR(9)&CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_BK,@N-_13.2))&CHR(9)&|
        LEFT(format(SUMMA_PVNK,@N-_10.2))&CHR(9)&LEFT(format(SUMMA_PK,@N-_14.2))&CHR(9)&VALK&CHR(9)&|
        LEFT(format(SUMMA_AK,@N-_13.2))&CHR(9)&LEFT(format(SUMMA_TK,@N-_10.2))&CHR(9)&LEFT(format(SUMMAPAR,@N-_13.2))&|
        CHR(9)&LEFT(format(ITOGOK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
    SUMMA_BK   = 0
    SUMMA_PK   = 0
    SUMMAPAR   = 0
    SUMMA_AK   = 0
    SUMMA_PVNK = 0
    SUMMA_TK     = 0
    ITOGOK     = 0
    kopa='t.s.'
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      !IF RECORDS(K_TABLE)=1 AND (K:VAL='Ls' OR K:VAL='LVL') THEN BREAK.
      IF RECORDS(K_TABLE)=1 AND ((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk) THEN BREAK.
      IF K:SUMMA_P
        SUMMA_PK   = K:SUMMA_P
        SUMMA_TK   = K:SUMMA_T
        VALK       = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=CHR(9)&CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_PK,@N-_14.2))&CHR(9)&VALK
            ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
    IF SUMMA_R
        KOPA = 't.s. Atgrieztâ prece'  !!!SUMMA_BK!!!
        VALK = ''
        SUMMA_PK = 0
        SUMMA_BK = SUMMA_RB
        ITOGOK = SUMMA_R
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=CHR(9)&CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(format(SUMMA_BK,@N-_13.2))&CHR(9)&CHR(9)&|
            LEFT(format(SUMMA_PK,@N-_14.2B))&CHR(9)&VALK&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
        .
    END
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
  IF FilesOpened
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(K_TABLE)
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
  POPBIND
  RETURN

!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
  IF ~(PAR_NR=999999999)                 !KONKRÇTS PARTNERIS
     NEXT(Process:View)
     IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR) OR PAV:DATUMS>B_DAT THEN VISS#=TRUE.
  ELSE
     PREVIOUS(Process:View) !DESC.KEY
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
  .
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
N_IzgPavP            PROCEDURE                    ! Declare Procedure
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
DOK_NR                  STRING(10)
KOPA                    STRING(20)
NR                      DECIMAL(4)
SUMMA_p                 DECIMAL(14,2)
SUMMA_PK                DECIMAL(14,2)
SUMMA_AK                DECIMAL(13,2)
SUMMAPAR                DECIMAL(13,2)
valK                    STRING(3)
PRECE                   DECIMAL(13,2)
TARA                    DECIMAL(13,2)
PAKALPOJUMI             DECIMAL(13,2)
SUMMA_B                 DECIMAL(13,2)
SUMMA_BK                DECIMAL(13,2)
SUMMA_PVN               DECIMAL(10,2)
SUMMA_PVNK              DECIMAL(10,2)
SUMMA_TK                DECIMAL(10,2)
ITOGO                   DECIMAL(14,2)
ITOGOK                  DECIMAL(14,2)
DAT                     DATE
LAI                     TIME
PROJEKTS                STRING(50)
NOS_P                   STRING(22)
CN                      STRING(10)
CP                      STRING(1)

K_TABLE        QUEUE,PRE(K)
VAL              STRING(3)
SUMMA_P          DECIMAL(14,2)
SUMMAK           DECIMAL(12,2)
SUMMA_AK         DECIMAL(12,2)
SUMMApar         DECIMAL(12,2)
PVN              DECIMAL(12,2)
SUMMA_T          DECIMAL(10,2)
ITOGO            DECIMAL(14,2)
SUMMABK          DECIMAL(12,2)
               .

LINEH                   STRING(190)
SUMMA_R                 DECIMAL(14,2)
SUMMA_RB                DECIMAL(14,2)
BANKURSS                REAL
!-------------------------------------------------------------------------
report REPORT,AT(500,1650,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,480,12000,1177),USE(?unnamed)
         STRING('Pçc pavadzîmes'),AT(5781,729,1198,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Tai skaitâ'),AT(7031,729,833,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7865,677,0,521),USE(?Line2:29),COLOR(COLOR:Black)
         STRING('Adrese :'),AT(5125,260,677,208),USE(?String2:4),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('datums'),AT(625,938,625,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, Ls'),AT(4167,938,885,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(5781,938,1198,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaide'),AT(7031,938,833,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN,val.'),AT(7917,938,729,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(5083,938,625,208),USE(?String10:16),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1250,677,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s45),AT(1250,52,4427,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(5729,52,885,208),USE(?String2:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Izgâjuðâs Pavadzîmes'),AT(7135,52,1771,208),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1219,260,3906,208),USE(par:nos_p),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(6615,52,260,208),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(2500,469,781,208),USE(S_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(3281,469,104,208),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3385,469,781,208),USE(B_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(4271,469,4323,208),USE(PROJEKTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IZ3K'),AT(9167,521,781,156),USE(?String7),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9896,521,677,156),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,677,10469,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,729,365,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(625,729,625,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum. numurs, pamatojums'),AT(1302,729,2813,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pr.Summa'),AT(4167,729,885,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, Ls'),AT(5104,729,625,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s.Transp.'),AT(7917,729,729,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6979,677,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(5729,677,0,521),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5052,677,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         STRING('Parâds'),AT(8698,729,833,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, Ls'),AT(9583,729,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10625,677,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(9531,677,0,521),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(156,1146,10469,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s60),AT(5802,260,4844,208),USE(par:adrese),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(9010,52),USE(d_k),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,677,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4115,677,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(8646,677,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(156,677,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(573,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D6),AT(625,10,625,156),USE(PAV:DATUMS),FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1250,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@S10),AT(1302,10,625,156),USE(DOK_NR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4115,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(5781,10,833,156),USE(SUMMA_P),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(6667,10,260,156),USE(PAV:VAL),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(8698,10,781,156),USE(pav:c_SUMMA),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(9740,10,833,156),USE(ITOGO),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(10625,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@S40),AT(2031,10,2083,156),USE(PAV:PAMAT),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(9531,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,198),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(8021,10,573,156),USE(pav:t_summa),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6979,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(7031,10,781,156),USE(pav:SUMMA_a),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,198),USE(?Line2:30),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(5104,10,573,156),USE(SUMMA_PVN),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(4167,10,833,156),USE(SUMMA_B),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5052,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(208,10,313,156),USE(nR),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(156,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,63),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(1250,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,115),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,115),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(156,52,10469,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(9531,-10,0,115),USE(?Line120),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,115),USE(?Line20:2),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,115),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,115),USE(?Line41:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         STRING(@N-_13.2B),AT(8750,10,729,156),USE(summaPar),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(8646,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,198),USE(?Line2:32),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(8021,10,573,156),USE(SUMMA_TK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(9531,-10,0,198),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(9740,10,833,156),USE(ITOGOK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_13.2B),AT(7031,10,781,156),USE(SUMMA_ak),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(10625,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,198),USE(?Line2:34),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4167,10,833,156),USE(SUMMA_BK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S20),AT(208,10,1563,156),USE(KOPA),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_10.2B),AT(5104,10,573,156),USE(SUMMA_PVNK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(5781,10,833,156),USE(SUMMA_PK),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S3),AT(6667,10,260,156),USE(VALK),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
RPT_FOOT2A DETAIL,AT(,,,469)
         STRING('Ls'),AT(6667,313,260,156),USE(?String29:6),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('Ls'),AT(6667,156,260,156),USE(?String29:4),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7865,-10,0,490),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(9531,-10,0,490),USE(?Line12:17),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,490),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,490),USE(?Line2:37),COLOR(COLOR:Black)
         STRING('tara'),AT(698,167,313,156),USE(?String29:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(5781,156,833,156),USE(tara),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('pakalpojumi'),AT(229,313,781,156),USE(?String29:5),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@N-_13.2),AT(5781,313,833,156),USE(pakalpojumi),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('t.s.       prece'),AT(208,10,885,156),USE(?String29),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(8646,-10,0,490),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,490),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,490),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,490),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,490),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5781,10,833,156),USE(prece),RIGHT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING('Ls'),AT(6667,10,260,156),USE(?String29:3),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,417),USE(?unnamed:2)
         STRING('Sastadîja :'),AT(260,156,573,208),USE(?String36),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s8),AT(833,156),USE(ACC_kods),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1510,156),USE(?String38),FONT(,8,,,CHARSET:BALTIC)
         STRING(@s1),AT(1719,156),USE(RS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@D6),AT(8490,156),USE(DAT),FONT(,8,,,CHARSET:BALTIC)
         STRING(@T4),AT(9271,156),USE(LAI),FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,63),USE(?Line44:2),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line44:3),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line44),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,63),USE(?Line144),COLOR(COLOR:Black)
         LINE,AT(9531,-10,0,63),USE(?Line244),COLOR(COLOR:Black)
         LINE,AT(156,52,10469,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,7900,12000,63)
         LINE,AT(156,0,10469,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('CN',CN)
  BIND('CYCLENOL',CYCLENOL)
  KOPA='Kopâ :'
  NR     = 0
  DAT = TODAY()
  LAI = CLOCK()
!!  NOL_TEX = FORMAT_NOLTEX25()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(PAR:RECORD)
  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
!!      STOP('PAR_NR '&PAR_NR)
      CN = 'P10111'
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
      PAV:PAR_NR=PAR_NR
      PAV:D_K=D_K
      PAV:DATUMS=S_DAT
      SET(PAV:PAR_KEY,PAV:PAR_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN)'
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
      IF F:OBJ_NR
         PRSTR"=GetProjekti(F:OBJ_NR,1)
         PROJEKTS='Projekts (Objekts) Nr: '&F:OBJ_NR&' - '&PRSTR"
      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IZGPAVP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          OUTA:LINE='IZGÂJUÐÂS PRECES (PAVADZÎMES) '&D_K&' '&CLIP(PAR:NOS_P)&' ADRESE: '&PAR:ADRESE
          ADD(OUTFILEANSI)
          IF F:DBF='E'
              OUTA:LINE=format(S_DAT,@d10.)&' - '&format(B_DAT,@d10.)&' '&PROJEKTS
              ADD(OUTFILEANSI)
          ELSE
              OUTA:LINE=format(S_DAT,@d6)&' - '&format(B_DAT,@d6)&' '&PROJEKTS
              ADD(OUTFILEANSI)
          END
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='  Npk'&CHR(9)&'Dokumenta '&CHR(9)&'Dokumenta '&CHR(9)&'Pamatojums {30}'&CHR(9)&'Summa     bez'&CHR(9)&'PVN,    Ls'&CHR(9)&'Pçc pavadzîmes'&CHR(9)&CHR(9)&'Tai    skaitâ'&CHR(9)&'Transports'&CHR(9)&'       Parâds'&CHR(9)&'      Kopâ, Ls'
          ADD(OUTFILEANSI)
          OUTA:LINE='     '&CHR(9)&'Datums    '&CHR(9)&'Numurs    '&CHR(9)&'           {30}'&CHR(9)&'PVN,       Ls'&CHR(9)&'          '&CHR(9)&'ar PVN, valûtâ'&CHR(9)&CHR(9)&'      atlaide'
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NR+=1
        ?Progress:UserString{Prop:Text}=NR
        DISPLAY(  ?Progress:UserString)
        BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
!!        PAMATOJUMS = CLIP(PAV:DOK_SE)&'-'&CLIP(PAV:DOK_NR)&' '&PAV:PAMAT
        summa_P       = PAV:SUMMA
        SUMMA_B       = PAV:SUMMA_B*BANKURSS
!        SUMMA_PVN     = (PAV:SUMMA-PAV:SUMMA_B)*BANKURS(PAV:VAL,PAV:DATUMS)
        SUMMA_PVN  = (PAV:SUMMA-PAV:T_SUMMA-PAV:SUMMA_B)*BANKURSS          !PAV:SUMA_B IR BEZ TRANSPORTA
        SUMMA_PVN += (PAV:T_SUMMA-PAV:T_SUMMA/(1+PAV:T_PVN/100))*BANKURSS  !PAV:SUMA_B IR BEZ TRANSPORTA
!        ITOGO         = SUMMA_P*BANKURS(PAV:VAL,PAV:DATUMS)+ PAV:T_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS)!!+PAV:C_SUMMA
        ITOGO         = PAV:SUMMA*BANKURSS
!!        GET(K_TABLE,0)
        K:VAL=PAV:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL      = PAV:VAL
          K:SUMMA_P  = SUMMA_P
          K:SUMMA_T  = PAV:T_SUMMA
          ADD(K_TABLE)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P  += summa_P
          K:SUMMA_T  += PAV:T_SUMMA
          PUT(K_TABLE)
        .
        BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
        SUMMA_BK   += SUMMA_B
        SUMMA_PVNK += SUMMA_PVN
        SUMMA_TK   += PAV:T_SUMMA*BANKURSS !PÇC TAM BÛS TS
        summa_pk   += PAV:SUMMA*BANKURSS
        summapar   += PAV:C_SUMMA*BANKURSS
        SUMMA_AK   += PAV:SUMMA_A*BANKURSS
        ITOGOK     += ITOGO
        DOK_NR=PAV:DOK_SENR
        IF PAV:SUMMA<0      !ATGRIEZTÂ PRECE
            SUMMA_R  += SUMMA_p*BANKURSS + PAV:T_SUMMA*BANKURSS !+PAV:C_SUMMA
            SUMMA_RB += PAV:SUMMA_B*BANKURSS
        END
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSIF F:DBF='E'
            OUTA:LINE=format(NR,@N_5)&CHR(9)&FORMAT(PAV:DATUMS,@D10.)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(PAV:PAMAT,@s40)&CHR(9)&format(SUMMA_B,@N-_13.2)&CHR(9)&format(SUMMA_PVN,@N-_10.2)&CHR(9)&format(SUMMA_P,@N-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(pav:SUMMA_A,@N-_13.2)&CHR(9)&format(pav:t_summa,@N-_10.2)&CHR(9)&format(pav:c_SUMMA,@N-_13.2)&CHR(9)&format(ITOGO,@N-_14.2)
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE=format(NR,@n_5)&CHR(9)&FORMAT(PAV:DATUMS,@D6)&CHR(9)&format(DOK_NR,@s10)&CHR(9)&format(PAV:PAMAT,@s40)&CHR(9)&format(SUMMA_B,@n-_13.2)&CHR(9)&format(SUMMA_PVN,@N-_10.2)&CHR(9)&format(SUMMA_P,@n-_14.2)&CHR(9)&PAV:VAL&CHR(9)&format(pav:SUMMA_A,@n-_13.2)&CHR(9)&format(pav:t_summa,@n-_10.2)&CHR(9)&format(pav:c_SUMMA,@n-_13.2)&CHR(9)&format(ITOGO,@n-_14.2)
            ADD(OUTFILEANSI)
          END
        END
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
        PRINT(RPT:RPT_FOOT1)                           !PRINT GRAND TOTALS
    ELSE
        OUTA:LINE=LINEH
        ADD(OUTFILEANSI)
    END
!****************************DRUKÂJAM PÇC valûtâm **************
    KOPA='Kopâ:'
    VALK = 'Ls'
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSIF F:DBF='E'
        OUTA:LINE=format(KOPA,@s5)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {40}'&CHR(9)&format(SUMMA_Bk,@N-_13.2)&CHR(9)&format(SUMMA_PVNk,@N-_10.2)&CHR(9)&format(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@N-_13.2)&CHR(9)&format(SUMMA_TK,@N-_10.2)&CHR(9)&format(SUMMApar,@N-_13.2)&CHR(9)&format(ITOGOk,@N-_14.2)
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE=format(KOPA,@s5)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {40}'&CHR(9)&format(SUMMA_Bk,@n-_13.2)&CHR(9)&format(SUMMA_PVNk,@n-_10.2)&CHR(9)&format(SUMMA_Pk,@n-_14.2)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@n-_13.2)&CHR(9)&format(SUMMA_TK,@n-_10.2)&CHR(9)&format(SUMMApar,@n-_13.2)&CHR(9)&format(ITOGOk,@n-_14.2)
        ADD(OUTFILEANSI)
    END
    SUMMA_BK = 0
    SUMMA_PK = 0
    SUMMA_PVNK = 0
    SUMMA_TK = 0
    ITOGOK = 0
    SUMMA_AK = 0
    SUMMAPAR = 0
    kopa=' t.s.'
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF K:SUMMA_P > 0
        SUMMA_PK      = K:SUMMA_P
        SUMMA_TK      = K:SUMMA_T
!!        SUMMAPar      = K:SUMMApar
!!        SUMMA_AK      = K:SUMMA_AK
        VALK          = K:VAL
!!        VERT_BEZ_PVNK = K:SUMMABK
!!        TRANSK        = K:TRANS
!!        ITOGOK        = K:ITOGO
!!        SUMMA_PVNK    = K:PVN
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
        ELSIF F:DBF='E'
            OUTA:LINE=format(KOPA,@s20)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_Bk,@N-_13.2)&CHR(9)&format(SUMMA_PVNk,@N-_10.2)&CHR(9)&format(SUMMA_Pk,@N-_14.2)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@N-_13.2)&CHR(9)&format(SUMMA_TK,@N-_10.2)&CHR(9)&format(SUMMApar,@N-_13.2)&CHR(9)&format(ITOGOk,@N-_14.2)
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE=format(KOPA,@s20)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_Bk,@n-_13.2)&CHR(9)&format(SUMMA_PVNk,@n-_10.2)&CHR(9)&format(SUMMA_Pk,@n-_14.2)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@n-_13.2)&CHR(9)&format(SUMMA_TK,@n-_10.2)&CHR(9)&format(SUMMApar,@n-_13.2)&CHR(9)&format(ITOGOk,@n-_14.2)
            ADD(OUTFILEANSI)
        END
        kopa=''
      .
    .
    IF SUMMA_R
        VALK = ''
        SUMMA_PK = 0
        SUMMA_BK = SUMMA_RB
        ITOGOK = SUMMA_R
        KOPA = 't.s. Atgrieztâ prece'
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
        ELSIF F:DBF='E'
            OUTA:LINE=format(KOPA,@s20)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_Bk,@N-_13.2B)&CHR(9)&format(SUMMA_PVNk,@N-_10.2B)&CHR(9)&format(SUMMA_Pk,@N-_14.2B)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@N-_13.2B)&CHR(9)&format(SUMMA_TK,@N-_10.2B)&CHR(9)&format(SUMMApar,@N-_13.2B)&CHR(9)&format(ITOGOk,@N-_14.2)
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE=format(KOPA,@s20)&CHR(9)&' {10}'&CHR(9)&' {10}'&CHR(9)&' {20}'&CHR(9)&format(SUMMA_Bk,@n-_13.2B)&CHR(9)&format(SUMMA_PVNk,@n-_10.2B)&CHR(9)&format(SUMMA_Pk,@n-_14.2B)&CHR(9)&VALk&CHR(9)&format(SUMMA_Ak,@n-_13.2B)&CHR(9)&format(SUMMA_TK,@n-_10.2B)&CHR(9)&format(SUMMApar,@n-_13.2B)&CHR(9)&format(ITOGOk,@n-_14.2)
            ADD(OUTFILEANSI)
        END
    END
! if tara or pakalpojumi
!    PRINT(RPT:RPT_FOOT2a)                       !PRINT GRAND TOTALS
! .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)                           !PRINT GRAND TOTALS
        ENDPAGE(report)
    ELSE
        OUTA:LINE=LINEH
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
     ELSIF F:DBF='E'
         CLOSE(OUTFILEANSI)
         RUN('C:\PROGRA~1\MICROS~1\OFFICE\EXCEL.EXE '&ANSIFILENAME)
         IF RUNCODE()=-4
            RUN('EXCEL.EXE '&ANSIFILENAME)
            IF RUNCODE()=-4
                KLUDA(88,'Excel.exe')
            .
         .
    ELSE
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Wordpad.exe')
        .
    .
  END
  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
  ELSE
      ANSIFILENAME=''
  END
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
  NEXT(Process:View)
  IF ERRORCODE() OR ~(PAV:PAR_NR=PAR_NR)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
