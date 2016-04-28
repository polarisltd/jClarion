                     MEMBER('winlats.clw')        ! This is a MEMBER module
N_IenNomP            PROCEDURE                    ! Declare Procedure
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
NR                      DECIMAL(4)
PIEGAD                  STRING(20)
NOSAUKUMS               STRING(50)
SUMMA_B                 DECIMAL(12,2)
SUMMA_P                 DECIMAL(12,2)
SUMMA_BK                DECIMAL(14,2)
SUMMA_PK                DECIMAL(13,2)
SUMMA_PVN               DECIMAL(12,2)
SUMMA_PVNK              DECIMAL(12,2)
DAUDZUMS                DECIMAL(12,3)
DAUDZUMSK               DECIMAL(14,3)
!SULS                    DECIMAL(13,2)
!SULAT                   DECIMAL(13,2)
KOPA                    STRING(20)
NOS                     STRING(3)
valK                    STRING(3)
KOPAA                   STRING(7)
BKK                     STRING(5)
SB                      DECIMAL(13,2)
NOS_P                   STRING(35)
SANEMTS                 STRING(8)
DAT                     DATE
LAI                     TIME
MERVIEN                 STRING(7)
CN                      STRING(10)
MUI                     DECIMAL(10,2)
AKCIZ                   DECIMAL(10,2)
CITAS                   DECIMAL(10,2)
ITOGO                   DECIMAL(14,2)
TRANS                   DECIMAL(10,2)
MUIK                    DECIMAL(10,2)
AKCIZK                  DECIMAL(10,2)
CITASK                  DECIMAL(10,2)
ITOGOK                  DECIMAL(14,2)
TRANSK                  DECIMAL(10,2)
SUMMA_C                 DECIMAL(13,2)
SUMMA_CK                DECIMAL(13,2)
N_TABLE              QUEUE,PRE(N)
NOMKEY               STRING(25)
NOMENKLAT            STRING(21)
MERVIEN              STRING(7)
DAUDZUMS             DECIMAL(14,3)
SUMMA_B              DECIMAL(12,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
NOS                  STRING(3)
MUI                  DECIMAL(10,2)
AKCIZ                DECIMAL(10,2)
CITAS                DECIMAL(10,2)
TRANS                DECIMAL(10,2)
SUMMA_C              DECIMAL(10,2)
                     .
K_TABLE              QUEUE,PRE(K)
VAL                  STRING(3)
!SUMMA_B              DECIMAL(12,2)
!SUMMA_PVN            DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
                     .
MER                  STRING(7)
RPT_NOMENKLAT        STRING(21)
LINEH                STRING(190)
!!DBFFILE           FILE,PRE(DBF),DRIVER('dBase3'),CREATE,NAME(FILENAME1)
!!RECORD              RECORD
!!nomenklat             STRING(15)
!!MERVIEN               STRING(7)
!!NOS_P                 STRING(30)
!!daudzums              STRING(@N-_11.3)
!!SUMMA_B               STRING(@N-_12.2)
!!SUMMA_P               STRING(@N-_12.2)
!!NOS                   STRING(3)
!!                  . .
DAUDZUMS_R          DECIMAL(12,2)
SUMMA_R             DECIMAL(12,2)
SUMMA_RB            DECIMAL(12,2)
!------------------------------------------------------------------------
report REPORT,AT(198,1635,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,500,12000,1135)
         LINE,AT(4219,625,0,521),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@s45),AT(521,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(4948,104,833,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(5781,104,260,260),USE(LOC_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârpuspavadzîmes izmaksas'),AT(8208,677,1823,156),USE(?String16:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8177,833,1875,0),USE(?Line65),COLOR(COLOR:Black)
         STRING(@s35),AT(3281,365,3385,260),USE(NOS_P),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6719,365,885,260),USE(s_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(7760,365,885,260),USE(b_dat),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE2K'),AT(9688,417,729,156),USE(?String13),LEFT
         STRING(@P<<<#. lapaP),AT(10417,417,625,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,625,10990,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1979,1146,0,-521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(406,677,1563,208),USE(?String16:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1094,10990,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5000,625,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(3646,625,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(365,1146,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(83,677,260,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preces nosaukums'),AT(2021,677,1615,208),USE(?String16:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudz.'),AT(3677,677,521,208),USE(?String16:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(4260,677,729,208),USE(?String16:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, Ls'),AT(5042,677,625,208),USE(?String16:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6771,625,0,521),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(5677,625,0,521),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(5719,677,1042,208),USE(?String16:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transp.'),AT(6813,677,573,208),USE(?String16:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâds'),AT(7438,677,729,208),USE(?String16:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7396,625,0,521),USE(?Line83:2),COLOR(COLOR:Black)
         STRING('Muita'),AT(8219,885,573,208),USE(?String16:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîzes'),AT(8844,885,573,208),USE(?String16:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(9469,885,573,208),USE(?String16:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, Ls'),AT(10094,677,938,208),USE(?String16:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10052,625,0,521),USE(?Line8:12),COLOR(COLOR:Black)
         LINE,AT(9427,833,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         LINE,AT(8802,833,0,313),USE(?Line8:22),COLOR(COLOR:Black)
         LINE,AT(8177,625,0,521),USE(?Line83:286),COLOR(COLOR:Black)
         STRING(@s21),AT(406,885,1563,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba, Ls'),AT(4260,885,729,208),USE(?String16:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(5719,885,1042,208),USE(?String16:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(P/Z, val.)'),AT(6813,885,573,208),USE(?String16:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(11042,625,0,521),USE(?Line10),COLOR(COLOR:Black)
         STRING('-'),AT(7604,365,156,260),USE(?String40),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,1146,0,-521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Izziòa par ienâkuðâm ('),AT(521,365,1771,260),USE(?String2:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s1),AT(2292,365,156,260),USE(d_k),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(') precçm :'),AT(2448,365,833,260),USE(?String2:3),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(4219,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N4),AT(104,10,260,156),USE(NR),RIGHT
         STRING(@S21),AT(417,10,1563,156),USE(rpt_NOMENKLAT),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(10104,10,885,156),USE(itogo),RIGHT
         LINE,AT(11042,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8854,10,573,156),USE(akciz),RIGHT
         LINE,AT(9427,-10,0,198),USE(?Line12:12),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9479,10,573,156),USE(citas),RIGHT
         LINE,AT(10052,-10,0,198),USE(?Line12:13),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         STRING(@S50),AT(2031,10,1615,156),USE(NOSAUKUMS),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(3646,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         STRING(@N-_12.3B),AT(3698,10,521,156),USE(DAUDZUMS),RIGHT
         STRING(@N-_12.2),AT(4271,10,729,156),USE(SUMMA_B),RIGHT
         LINE,AT(5000,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5729,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(6510,10,260,156),USE(NOS),LEFT
         STRING(@N_10.2),AT(6823,10,573,156),USE(trans),RIGHT
         LINE,AT(7396,-10,0,198),USE(?Line12:15),COLOR(COLOR:Black)
         STRING(@N_12.2),AT(7448,10,729,156),USE(SUMMA_C),RIGHT
         LINE,AT(8177,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8229,10,573,156),USE(mui),RIGHT
         LINE,AT(8802,-10,0,198),USE(?Line12:11),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5052,10,625,156),USE(SUMMA_pvn),RIGHT
         LINE,AT(5677,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(52,-10,0,115),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(1979,-10,0,63),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(3646,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,115),USE(?Line38:2),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,115),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,115),USE(?Line19:6),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,115),USE(?Line19:8),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,115),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(8177,-10,0,115),USE(?Line119:7),COLOR(COLOR:Black)
         LINE,AT(8802,-10,0,115),USE(?Line119:27),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,115),USE(?Line191:7),COLOR(COLOR:Black)
         LINE,AT(10052,-10,0,115),USE(?Line19:17),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,115),USE(?Line19:71),COLOR(COLOR:Black)
         LINE,AT(52,52,10990,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(52,-10,0,198),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,198),USE(?Line19:3),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5052,10,625,156),USE(SUMMA_pvnk),RIGHT
         LINE,AT(5677,-10,0,198),USE(?Line19:9),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(6823,10,573,156),USE(transk),RIGHT
         LINE,AT(6771,-10,0,198),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@s20),AT(104,10,1771,156),USE(KOPA),LEFT
         STRING(@N-_14.2B),AT(10104,10,885,156),USE(itogok),RIGHT
         LINE,AT(8177,-10,0,198),USE(?Line19:15),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?Line19:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8854,10,573,156),USE(akcizk),RIGHT
         LINE,AT(9427,-10,0,198),USE(?Line19:12),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(9479,10,573,156),USE(citask),RIGHT
         LINE,AT(10052,-10,0,198),USE(?Line19:13),COLOR(COLOR:Black)
         LINE,AT(8802,-10,0,198),USE(?Line19:11),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(3333,10,885,156),USE(DAUDZUMSk),RIGHT
         STRING(@N-_14.2B),AT(4271,10,729,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_14.2B),AT(5729,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@S3),AT(6510,10,260,156),USE(VALK),LEFT
         LINE,AT(7396,-10,0,198),USE(?Line19:10),COLOR(COLOR:Black)
         STRING(@N_12.2B),AT(7448,10,729,156),USE(SUMMA_Ck),RIGHT
         STRING(@N_10.2B),AT(8229,10,573,156),USE(muik),RIGHT
       END
RPT_FOOT3 DETAIL,AT(,,,417)
         LINE,AT(52,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4219,-10,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,63),USE(?Line36:2),COLOR(COLOR:Black)
         LINE,AT(8177,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(8802,-10,0,63),USE(?Line136),COLOR(COLOR:Black)
         LINE,AT(9427,-10,0,63),USE(?Line236),COLOR(COLOR:Black)
         LINE,AT(10052,-10,0,63),USE(?Line362),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,63),USE(?Line326),COLOR(COLOR:Black)
         LINE,AT(52,52,10990,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,63),USE(?Line36:3),COLOR(COLOR:Black)
         LINE,AT(5000,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         STRING('Sastadîja :'),AT(208,156,573,208),USE(?String52)
         STRING(@s8),AT(781,156),USE(ACC_kods),LEFT
         STRING('RS :'),AT(1615,156,208,208),USE(?String54)
         STRING(@s1),AT(1823,156),USE(RS),CENTER
         STRING(@D6),AT(8750,156),USE(DAT)
         STRING(@T4),AT(9583,156),USE(LAI)
       END
       FOOTER,AT(198,7900,12000,63)
         LINE,AT(52,0,10990,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!********************izziòa par konkrçta partnera piegâdâtâm precçm
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(PAR_K,1)
  BIND('S_DAT',S_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)
  DAT = TODAY()
  LAI = CLOCK()
  NOS_P=GETPAR_K(PAR_NR,2,2)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
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
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçju Izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'N1011'
      CLEAR(nol:RECORD)                              
      NOL:D_K = D_K
      NOL:DATUMS = s_dat
      NOL:PAR_NR = PAR_NR
      SET(nol:PAR_KEY,NOL:PAR_KEY)                   
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLENOM(NOL:NOMENKLAT)'
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
          IF ~OPENANSI('IENNOMP.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&' NOLIKTAVA: '&LOC_NR
          ADD(OUTFILEANSI)
          IF F:DBF='E'
            OUTA:LINE='IZZIÒA PAR IENAKUÐÂM ('&D_K&') PRECÇM: '&NOS_P&' '&format(S_DAT,@d10.)&' LÎDZ '&format(B_DAT,@d10.)
            ADD(OUTFILEANSI)
          ELSE
            OUTA:LINE='IZZIÒA PAR IENAKUÐÂM ('&D_K&') PRECÇM: '&NOS_P&' '&format(S_DAT,@d6)&' LÎDZ '&format(B_DAT,@d6)
            ADD(OUTFILEANSI)
          END
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
          OUTA:LINE='Npk '&CHR(9)&'Nomenklatûra {9}'&CHR(9)&'Preces Nosaukums {34}'&CHR(9)&'  Daudzums  '&CHR(9)&'  Bilances  '&CHR(9)&'  PVN, Ls   '&CHR(9)&'  Vçrtîba   '&CHR(9)&CHR(9)&'    Parâds   '&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&CHR(9)&'Kopâ, Ls'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&format(NOMENKLAT,@s21)&CHR(9)&' {50}'&CHR(9)&' {12}'&CHR(9)&' vçrtîba, Ls'&CHR(9)&' {12}'&CHR(9)&'ar PVN, val.'&CHR(9)&' {20}'&CHR(9)&'(P/Z,val.)'&CHR(9)&CHR(9)&'   Muita  '&CHR(9)&'  Akcîze  '&CHR(9)&'  Citas   '
          ADD(OUTFILEANSI)
          OUTA:LINE=LINEH
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        K:VAL=NOL:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL=NOL:VAL
!          K:SUMMA_B  = CALCSUM(15)
!          K:SUMMA_PVN= CALCSUM(17)
          K:SUMMA_P  = CALCSUM(4,2)
          ADD(K_TABLE)
          SORT(K_TABLE,K:VAL)
        ELSE
!          K:SUMMA_B  += CALCSUM(15)
!          K:SUMMA_PVN+= CALCSUM(17)
          K:SUMMA_P  += CALCSUM(4,2)
          PUT(K_TABLE)
        .
        DAUDZUMSK +=  NOL:DAUDZUMS ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        GET(N_TABLE,0)
        N:NOMKEY=NOL:NOMENKLAT&NOL:VAL
        GET(N_TABLE,N:NOMKEY)
        IF ERROR()
          N:NOMKEY=NOL:NOMENKLAT&NOL:VAL
          N:NOMENKLAT=NOL:NOMENKLAT
          N:MERVIEN  =''
          N:DAUDZUMS =NOL:DAUDZUMS
          N:SUMMA_B  =CALCSUM(15,2)
          N:SUMMA_P  =CALCSUM(4,2) !VALÛTÂ AR PVN -A
          N:SUMMA_PVN=CALCSUM(17,2)
          IF NOL:BAITS
            N:SUMMA_C =CALCSUM(4,2)
          ELSE
            N:SUMMA_C = 0
          .
          N:NOS=NOL:VAL
          N:MUI = NOL:MUITA
          N:AKCIZ = NOL:AKCIZE
          N:CITAS = NOL:CITAS
          N:TRANS = NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
          ADD(N_TABLE)
          SORT(N_TABLE,N:NOMKEY)
        ELSE
          N:DAUDZUMS+=NOL:DAUDZUMS
          N:SUMMA_B +=CALCSUM(15,2)
          N:SUMMA_P +=CALCSUM(4,2) !VALÛTÂ AR PVN -A
          N:SUMMA_PVN+=CALCSUM(17,2)
          IF NOL:BAITS
            N:SUMMA_C +=CALCSUM(4,2)
          .
          N:MUI += NOL:MUITA
          N:AKCIZ += NOL:AKCIZE
          N:CITAS += NOL:CITAS
          N:TRANS += NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
          PUT(N_TABLE)
        .
        IF NOL:DAUDZUMS<0  !ATGRIEZTA PRECE
              DAUDZUMS_R += NOL:DAUDZUMS
              SUMMA_RB   += CALCSUM(15,2)
              SUMMA_R    += CALCSUM(15,2)+CALCSUM(17,2)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP N#=1 TO RECORDS(N_TABLE)
      GET(N_TABLE,N#)
      NOSAUKUMS=GETNOM_K(N:NOMENKLAT,2,2)
      NR+=1
      rpt_NOMENKLAT=N:NOMENKLAT
      MERVIEN = N:MERVIEN
      DAUDZUMS= N:DAUDZUMS
      SUMMA_B = N:SUMMA_B
      SUMMA_P = N:SUMMA_P  !VALÛTÂ
      SUMMA_PVN = N:SUMMA_PVN
      SUMMA_C = N:SUMMA_C
      NOS     = N:NOS
      MUI     = N:MUI
      AKCIZ   = N:AKCIZ
      CITAS   = N:CITAS
      TRANS   = N:TRANS
      ITOGO   = SUMMA_B + SUMMA_PVN + MUI + AKCIZ + CITAS + TRANS
      SUMMA_BK   += SUMMA_B
      SUMMA_PVNK += SUMMA_PVN
      SUMMA_PK   += SUMMA_B+SUMMA_PVN !Ls
      MUIK       += MUI
      SUMMA_CK   += SUMMA_C
      AKCIZK     += AKCIZ
      CITASK     += CITAS
      TRANSK     += TRANS
      ITOGOK     += ITOGO
      IF ~F:DTK
        IF F:DBF='W'
          PRINT(RPT:DETAIL)
        ELSIF F:DBF='E'
          OUTA:LINE=FORMAT(NR,@N_4)&CHR(9)&FORMAT(RPT_NOMENKLAT,@S21)&CHR(9)&FORMAT(NOSAUKUMS,@S50)&CHR(9)&FORMAT(DAUDZUMS,@N-_12.3)&CHR(9)&FORMAT(SUMMA_B,@N_12.2)&CHR(9)&FORMAT(SUMMA_PVN,@N_12.2)&CHR(9)&FORMAT(SUMMA_P,@N_12.2)&CHR(9)&NOS&CHR(9)&FORMAT(SUMMA_C,@N_13.2)&CHR(9)&FORMAT(TRANS,@N_10.2)&CHR(9)&FORMAT(MUI,@N_10.2)&CHR(9)&FORMAT(AKCIZ,@N_10.2)&CHR(9)&FORMAT(CITAS,@N_10.2)&CHR(9)&FORMAT(ITOGO,@N_14.2)
          ADD(OUTFILEANSI)
        ELSE
          OUTA:LINE=FORMAT(NR,@N_4)&CHR(9)&FORMAT(RPT_NOMENKLAT,@S21)&CHR(9)&FORMAT(NOSAUKUMS,@S50)&CHR(9)&FORMAT(DAUDZUMS,@N-_12.3)&CHR(9)&FORMAT(SUMMA_B,@N12.2)&CHR(9)&FORMAT(SUMMA_PVN,@N12.2)&CHR(9)&FORMAT(SUMMA_P,@N12.2)&CHR(9)&NOS&CHR(9)&FORMAT(SUMMA_C,@N13.2)&CHR(9)&FORMAT(TRANS,@N10.2)&CHR(9)&FORMAT(MUI,@N10.2)&CHR(9)&FORMAT(AKCIZ,@N10.2)&CHR(9)&FORMAT(CITAS,@N10.2)&CHR(9)&FORMAT(ITOGO,@N14.2)
          ADD(OUTFILEANSI)
        END
      END
  !!  IF DBF
  !!    DBF:NOMENKLAT=N:NOMENKLAT
  !!    DBF:MERVIEN = N:MERVIEN
  !!    DBF:NOS_P   = RPT:NOSAUKUMS
  !!    DBF:DAUDZUMS= N:DAUDZUMS
  !!    DBF:SUMMA_B = N:SUMMA_B
  !!    DBF:SUMMA_P = N:SUMMA_P
  !!    DBF:NOS     = N:NOS
  !!    ADD(DBFFILE)
  !!  .
    .
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
        OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PK,@N_12.2)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N_13.2)&CHR(9)&FORMAT(TRANSK,@N_10.2)&CHR(9)&FORMAT(MUIK,@N_10.2)&CHR(9)&FORMAT(AKCIZK,@N_10.2)&CHR(9)&FORMAT(CITASK,@N_10.2)&CHR(9)&FORMAT(ITOGOK,@N_14.2)
        ADD(OUTFILEANSI)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N12.2)&CHR(9)&FORMAT(SUMMA_PK,@N12.2)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N13.2)&CHR(9)&FORMAT(TRANSK,@N10.2)&CHR(9)&FORMAT(MUIK,@N10.2)&CHR(9)&FORMAT(AKCIZK,@N10.2)&CHR(9)&FORMAT(CITASK,@N10.2)&CHR(9)&FORMAT(ITOGOK,@N14.2)
        ADD(OUTFILEANSI)
    END
    DAUDZUMSK  = 0
    SUMMA_BK   = 0
    SUMMA_PK   = 0
    SUMMA_PVNK = 0
    SUMMA_CK   = 0
    MUIK       = 0
    AKCIZK     = 0
    CITASK     = 0
    TRANSK     = 0
    ITOGOK     = 0
    KOPA = 't.s.'
    GET(K_TABLE,0)
    LOOP J# = 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,J#)
       IF K:SUMMA_P <> 0
!         SUMMA_BK   = K:SUMMA_B
!         SUMMA_PVNK = K:SUMMA_PVN
         SUMMA_PK   = K:SUMMA_P
         valK       = K:val
         IF F:DBF='W'
             PRINT(RPT:RPT_FOOT2)                      !PRINT GRAND TOTALS
         ELSIF F:DBF='E'
             OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PK,@N_12.2)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N_13.2)&CHR(9)&FORMAT(TRANSK,@N_10.2)&CHR(9)&FORMAT(MUIK,@N_10.2)&CHR(9)&FORMAT(AKCIZK,@N_10.2)&CHR(9)&FORMAT(CITASK,@N_10.2)&CHR(9)&FORMAT(ITOGOK,@N_14.2)
             ADD(OUTFILEANSI)
         ELSE
             OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N12.2)&CHR(9)&FORMAT(SUMMA_PK,@N12.2)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N13.2)&CHR(9)&FORMAT(TRANSK,@N10.2)&CHR(9)&FORMAT(MUIK,@N10.2)&CHR(9)&FORMAT(AKCIZK,@N10.2)&CHR(9)&FORMAT(CITASK,@N10.2)&CHR(9)&FORMAT(ITOGOK,@N14.2)
             ADD(OUTFILEANSI)
         END
         KOPA=''
       .
    .
!****************************JA IR ATGRIEZTA PRECE**************
    IF DAUDZUMS_R<0
        KOPA='Atgriezta prece'
        VALK = ''
        DAUDZUMSK  = DAUDZUMS_R
        SUMMA_BK   = SUMMA_RB
        SUMMA_PK   = 0
        SUMMA_PVNK = 0
        SUMMA_CK   = 0
        MUIK       = 0
        AKCIZK     = 0
        CITASK     = 0
        TRANSK     = 0
        ITOGOK     = SUMMA_R
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSIF F:DBF='E'
            OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N_12.2)&CHR(9)&FORMAT(SUMMA_PK,@N_12.2B)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N_13.2)&CHR(9)&FORMAT(TRANSK,@N_10.2)&CHR(9)&FORMAT(MUIK,@N_10.2)&CHR(9)&FORMAT(AKCIZK,@N_10.2)&CHR(9)&FORMAT(CITASK,@N_10.2)&CHR(9)&FORMAT(ITOGOK,@N_14.2)
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&' {60}'&CHR(9)&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N12.2)&CHR(9)&FORMAT(SUMMA_PK,@N12.2B)&CHR(9)&VALK&CHR(9)&FORMAT(SUMMA_CK,@N13.2)&CHR(9)&FORMAT(TRANSK,@N10.2)&CHR(9)&FORMAT(MUIK,@N10.2)&CHR(9)&FORMAT(AKCIZK,@N10.2)&CHR(9)&FORMAT(CITASK,@N10.2)&CHR(9)&FORMAT(ITOGOK,@N14.2)
            ADD(OUTFILEANSI)
        END
    END
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
!|------------------------------------------------------------------------------------------
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
  IF ERRORCODE() OR ~(NOL:PAR_NR=PAR_NR)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!***************************************************************************
omit('diana')
NEXT_RECORD ROUTINE                              !GET NEXT RECORD
  LOOP UNTIL EOF(nolik)                          !  READ UNTIL END OF FILE
    NEXT(nolik)                                  !    READ NEXT RECORD
    I# += 1
    SHOW(15,32,I#,@N_5)
    IF ~(NOL:PAR_NR=PAR_NR AND NOL:PAZIME=D_K)
       BREAK
    .
    IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.          !FILTRS PðC NOMENKLATÞTAS
    IF NOL:NR=1 THEN CYCLE.                         !SALDO
    GETPAVADZ(NOL:NR)                               !POZICIONð PAVADZ×MES
    IF ~RST() THEN CYCLE.
    IF ~INRANGE(NOL:DATUMS,S_DAT,B_DAT)
       CYCLE
    .
    EXIT                                         !    EXIT THE ROUTINE
  .                                              !
  DONE# = 1                                      !  ON EOF, SET DONE FLAG
diana
N_IenPav             PROCEDURE                    ! Declare Procedure
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
DOK_SENR             STRING(14)
KOPA                 STRING(20)
NR                   DECIMAL(4)
RPT_NR               DECIMAL(4)
SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(12,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
VALK                 STRING(3)
PRECE                DECIMAL(12,2)
TARA                 DECIMAL(12,2)
PAKALPOJUMI          DECIMAL(12,2)
DAT                  DATE
LAI                  TIME

CN                   STRING(10)
CP                   STRING(3)

ITOGO                DECIMAL(14,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
SUMMA_TK             DECIMAL(10,2)
MUIK                 DECIMAL(10,2)
AKCIZK               DECIMAL(10,2)
CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
BANKURSS             REAL

K_TABLE              QUEUE,PRE(K)
VAL                    STRING(3)
SUMMA_P                DECIMAL(12,2)
SUMMA_T                DECIMAL(12,2)
                     .

PAR_NOS_P           LIKE(PAR:NOS_P)
DAUDZUMS_R          DECIMAL(12,2)
SUMMA_R             DECIMAL(12,2)
SUMMA_RB            DECIMAL(12,2)
VIRSRAKSTS          STRING(110)
FILTRS_TEXT         STRING(100)

!-------------------------------------------------------------------------
report REPORT,AT(198,1635,12000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,500,12000,1135),USE(?unnamed:3)
         STRING('Numurs'),AT(1135,885,729,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba, '),AT(4417,885,510,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4854,885,354,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(5927,885,1042,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN,val.'),AT(7021,885,625,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,625,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s45),AT(3010,0,4531,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(625,208,9323,208),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1344,417,7865,208),USE(FILTRS_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IE3V'),AT(9948,333,677,156),USE(?String7),RIGHT
         STRING(@P<<<#. lapaP),AT(10052,458,,156),PAGENO,USE(?PageCount),RIGHT
         STRING('Ârpuspavadzîmes izmaksas'),AT(7698,677,1979,156),USE(?String69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7656,833,2031,0),USE(?Line75),COLOR(COLOR:Black)
         LINE,AT(104,625,10521,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(146,677,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(510,677,573,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(1135,677,729,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdâtâjs'),AT(1927,677,1250,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu'),AT(4417,677,781,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(5250,677,323,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5510,677,375,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s Transp.'),AT(7021,677,625,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(5927,677,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Muita'),AT(7698,885,625,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîze'),AT(8375,885,625,208),USE(?String10:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(9052,885,625,208),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(5260,875,625,208),USE(?String10:20),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ, '),AT(9729,677,885,208),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(9729,865,885,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9688,625,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(10625,625,0,521),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(9010,833,0,313),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(8333,833,0,313),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(6979,625,0,521),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5208,625,0,521),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5885,625,0,521),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(104,1094,10521,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(510,885,573,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,625,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1875,625,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4375,625,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7656,625,0,521),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(104,625,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(469,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(500,10,573,156),USE(PAV:DATUMS)
         LINE,AT(1094,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@S14),AT(1115,10,750,156),USE(DOK_SENR),RIGHT(1)
         LINE,AT(1875,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S45),AT(1906,10,2448,156),USE(PAR_NOS_P),LEFT
         LINE,AT(4375,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(4406,10,781,156),USE(SUMMA_B),RIGHT
         LINE,AT(5208,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5240,10,625,156),USE(summa_pvn),RIGHT
         STRING(@N-_13.2),AT(5927,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(6698,10,260,156),USE(PAV:VAL),LEFT
         LINE,AT(6979,-10,0,198),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(7010,10,625,156),USE(PAV:T_SUMMA),RIGHT
         LINE,AT(5885,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7688,10,625,156),USE(PAV:MUITA),RIGHT
         LINE,AT(8333,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8365,10,625,156),USE(PAV:AKCIZE),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9042,10,625,156),USE(PAV:citas),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line2:26),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(9719,10,885,156),USE(itogo),RIGHT
         LINE,AT(10625,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(135,10,313,156),USE(RPT_NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(104,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,63),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(1875,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,115),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,115),USE(?Line119),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,115),USE(?Line191),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,115),USE(?Line219),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,115),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,115),USE(?Line192),COLOR(COLOR:Black)
         LINE,AT(104,52,10521,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,115),USE(?Line319),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(10625,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(7010,10,625,156),USE(SUMMA_TK),RIGHT
         LINE,AT(7656,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(8365,10,625,156),USE(akcizk),RIGHT
         LINE,AT(9010,-10,0,198),USE(?Line21:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(9042,10,625,156),USE(citask),RIGHT
         LINE,AT(9688,-10,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,198),USE(?Line2:113),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,198),USE(?Line2:123),COLOR(COLOR:Black)
         STRING(@S20),AT(208,10,1458,156),USE(KOPA),LEFT
         STRING(@N-_13.2B),AT(4406,10,781,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_11.2B),AT(5240,10,625,156),USE(summa_pvnk),RIGHT
         STRING(@N-_13.2b),AT(5927,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@S3),AT(6698,10,260,156),USE(VALK),LEFT
         STRING(@N_10.2B),AT(7688,10,625,156),USE(muik),RIGHT
         STRING(@N-_14.2B),AT(9719,10,885,156),USE(itogok),RIGHT
       END
RPT_FOOT2A DETAIL,AT(,,,469),USE(?unnamed)
         LINE,AT(10625,-10,0,490),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('tara'),AT(677,156,417,156),USE(?String29:3),LEFT
         STRING(@N-_13.2),AT(5938,156,781,156),USE(tara),RIGHT
         STRING(@s3),AT(6729,156,250,156),USE(val_uzsk,,?val_uzsk:5),LEFT
         STRING('pakalpojumi'),AT(313,313,781,156),USE(?String29:5),LEFT
         STRING(@N-_13.2),AT(5938,313,781,156),USE(pakalpojumi),RIGHT
         STRING(@s3),AT(6729,313,250,156),USE(val_uzsk,,?val_uzsk:6),LEFT
         STRING('t.s.       prece'),AT(208,10,885,156),USE(?String29),LEFT
         LINE,AT(6979,-10,0,490),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,490),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,490),USE(?Line12:17),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,490),USE(?Line21:17),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,490),USE(?Line22:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,490),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,490),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,490),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(5938,10,781,156),USE(prece),RIGHT
         LINE,AT(5885,-10,0,490),USE(?Line12:31),COLOR(COLOR:Black)
         STRING(@s3),AT(6729,10,250,156),USE(val_uzsk,,?val_uzsk:4),LEFT
       END
RPT_FOOT3 DETAIL,AT(,,,250),USE(?unnamed:2)
         STRING('Sastadîja :'),AT(125,73,521,156),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(646,73,552,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1375,73,208,156),USE(?String38),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1583,73,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9542,73,615,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10156,73,490,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(104,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5208,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,63),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line312),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,63),USE(?Line321),COLOR(COLOR:Black)
         LINE,AT(9010,-10,0,63),USE(?Line232),COLOR(COLOR:Black)
         LINE,AT(10625,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,63),USE(?Line322),COLOR(COLOR:Black)
         LINE,AT(104,52,10521,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(6979,-10,0,63),USE(?Line323),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7900,12000,63)
         LINE,AT(104,0,10521,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
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
  ProgressWindow{Prop:Text} = 'Ienâkuðâs P/Z'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10011'
      CP = 'P11'
      VIRSRAKSTS='Ienâkuðâs pavadzîmes ('&D_K&') no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
!      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala).
      IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
      IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
!      IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!      IF ~(NOM_TIPS7='PTAKRIV') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:'&NOM_TIPS7.
!      IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!
      CLEAR(PAV:RECORD)
      PAV:DATUMS=S_DAT
      PAV:D_K=D_K
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
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
          IF ~OPENANSI('IENPAV.TXT')
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
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Piegâdâtâjs'&CHR(9)&'Bilances'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&|
!             CHR(9)&'Kopâ, Ls'
!             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'vçrtîba, Ls'&CHR(9)&CHR(9)&'ar PVN, val.'&|
!             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Piegâdâtâjs'&CHR(9)&'Bilances'&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&|
             CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'vçrtîba, '&val_uzsk&CHR(9)&CHR(9)&'ar PVN, val.'&|
             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             ADD(OUTFILEANSI)
          ELSE !WORD
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Piegâdâtâjs'&CHR(9)&|
!             'Bilances vçrtîba, Ls'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&|
!             CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Piegâdâtâjs'&CHR(9)&|
             'Bilances vçrtîba, '&val_uzsk&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&|
             CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(PAV:U_NR=1)  !SALDO IGNORÇJAM
           IF ~PAV:PAR_NR
              PAR_NOS_P=PAV:NOKA
           ELSE
              PAR_NOS_P=GETPAR_K(PAV:PAR_NR,0,2)
           .
           BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
           RPT_NR+=1
           ?Progress:UserString{Prop:Text}=RPT_NR
           DISPLAY(  ?Progress:UserString)
           SUMMA_P   = PAV:SUMMA
           SUMMA_B   = PAV:SUMMA_B*BANKURSS
!           SUMMA_PVN = (PAV:SUMMA-PAV:SUMMA_B)*BANKURSS
           SUMMA_PVN  = (PAV:SUMMA-PAV:T_SUMMA-PAV:SUMMA_B)*BANKURSS          !PAV:SUMA_B IR BEZ TRANSPORTA
           SUMMA_PVN += (PAV:T_SUMMA-PAV:T_SUMMA/(1+PAV:T_PVN/100))*BANKURSS  !PAV:SUMA_B IR BEZ TRANSPORTA
!           ITOGO = (SUMMA_P+PAV:T_SUMMA)*BANKURSS+PAV:MUITA+PAV:AKCIZE+PAV:CITAS
           ITOGO = PAV:SUMMA*BANKURSS+PAV:MUITA+PAV:AKCIZE+PAV:CITAS
           IF PAV:SUMMA<0      !ATGRIEZTÂ PRECE
               SUMMA_R  += SUMMA_p*BANKURSS + PAV:T_SUMMA*BANKURSS !+PAV:C_SUMMA
               SUMMA_RB += PAV:SUMMA_B*BANKURSS
           END
           IF ~PAR:NOS_P
             PAR:NOS_P=PAV:NOKA
           .
           K:VAL=PAV:VAL
           GET(K_TABLE,K:VAL)
           IF ERROR()
             K:VAL     = PAV:VAL
             K:SUMMA_P = SUMMA_P
             K:SUMMA_T = PAV:T_SUMMA
             ADD(K_TABLE)
             SORT(K_TABLE,K:VAL)
           ELSE
             K:SUMMA_P += SUMMA_P
             K:SUMMA_T += PAV:T_SUMMA
             PUT(K_TABLE)
           .
           DOK_SENR     =PAV:DOK_SENR
           SUMMA_BK   += SUMMA_B
           SUMMA_PVNK += SUMMA_PVN
           SUMMA_PK   += SUMMA_P*BANKURSS      !LS, PÇC TAM BÛS T.S
           SUMMA_TK   += PAV:T_SUMMA*BANKURSS  !LS, PÇC TAM BÛS T.S
           MUIK       += PAV:MUITA
           AKCIZK     += PAV:AKCIZE
           CITASK     += PAV:CITAS
           ITOGOK     += ITOGO
           IF ~F:DTK
             IF F:DBF='W'
               PRINT(RPT:DETAIL)
             ELSE
!26.02.2014               OUTA:LINE=CENTER(RPT_NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_SENR&CHR(9)&PAR:NOS_P&CHR(9)&|
!26.02.2014               LEFT(FORMAT(SUMMA_B,@N_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N_12.2))&|
!26.02.2014               CHR(9)&PAV:VAL&CHR(9)&LEFT(FORMAT(PAV:T_SUMMA,@N_11.2))&CHR(9)&LEFT(FORMAT(PAV:MUITA,@N_10.2))&CHR(9)&|
!26.02.2014               LEFT(FORMAT(PAV:AKCIZE,@N_10.2))&CHR(9)&LEFT(FORMAT(PAV:CITAS,@N_10.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N_14.2))
               OUTA:LINE=CENTER(RPT_NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_SENR&CHR(9)&PAR:NOS_P&CHR(9)&|
               LEFT(FORMAT(SUMMA_B,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_12.2))&|
               CHR(9)&PAV:VAL&CHR(9)&LEFT(FORMAT(PAV:T_SUMMA,@N-_11.2))&CHR(9)&LEFT(FORMAT(PAV:MUITA,@N-_10.2))&CHR(9)&|
               LEFT(FORMAT(PAV:AKCIZE,@N-_10.2))&CHR(9)&LEFT(FORMAT(PAV:CITAS,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
!**************************** DRUKÂJAM KOPÂ Ls UN PÇC valûtâm **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        !26/02/2015
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VALK&CHR(9)&LEFT(FORMAT(SUMMA_TK,@N-_11.2))&CHR(9)&|
        LEFT(FORMAT(MUIK,@N-_10.2))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2))&CHR(9)&|
        LEFT(FORMAT(ITOGOK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
    SUMMA_BK   = 0
    SUMMA_PK   = 0
    SUMMA_PVNK = 0
    MUIK       = 0
    AKCIZK     = 0
    CITASK     = 0
    SUMMA_TK   = 0
    ITOGOK     = 0
    kopa=' t.s.'
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      !IF RECORDS(K_TABLE)=1 AND (K:VAL='Ls' OR K:VAL='LVL') THEN BREAK.
      IF RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)) THEN BREAK. !16/12/2013
      IF K:SUMMA_P
        SUMMA_PK = K:SUMMA_P
        SUMMA_TK = K:SUMMA_T
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            !26/02/2015
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA_PVNK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_TK,@N-_11.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2))&|
            CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
!   IF TARA OR PAKALPOJUMI
!     PRINT(RPT:RPT_FOOT2A)
!   .
!****************************JA IR ATGRIEZTA PRECE**************
    IF SUMMA_R
        SUMMA_BK   = SUMMA_RB
        SUMMA_PK   = 0
        SUMMA_PVNK = 0
        MUIK       = 0
        AKCIZK     = 0
        CITASK     = 0
        SUMMA_TK   = 0
        ITOGOK     = SUMMA_R
        KOPA='Atgriezta prece'
        VALK = ''
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            !26/02/2015 @N-_12.2
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA_PVNK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_TK,@N-_11.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(CITASK,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>B_DAT
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
N_IenPavP            PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAV:DOK_SENR)
                       PROJECT(PAV:DEK_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:RS)
                       PROJECT(PAV:KIE_NR)
                       PROJECT(PAV:REK_NR)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:NOKA)
                       PROJECT(PAV:PAMAT)
                       PROJECT(PAV:PIELIK)
                       PROJECT(PAV:PAR_NR)
                       PROJECT(PAV:VED_NR)
                       PROJECT(PAV:SUMMA)
                       PROJECT(PAV:VAL)
                     END
!------------------------------------------------------------------------
DOK_SENR               STRING(14)
NR                   DECIMAL(4)
SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(12,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
KOPA                 STRING(20)
VALK                 STRING(3)
PRECE                DECIMAL(12,2)
TARA                 DECIMAL(12,2)
PAKALPOJUMI          DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)
MUIK                 DECIMAL(10,2)
AKCIZK               DECIMAL(10,2)
CITASK               DECIMAL(10,2)
SUMMA_TK             DECIMAL(10,2)
ITOGO                DECIMAL(14,2)
ITOGOK               DECIMAL(14,2)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA_P               DECIMAL(12,2)
SUMMA_T               DECIMAL(12,2)
                     .

DAUDZUMS_R          DECIMAL(12,2)
SUMMA_R             DECIMAL(12,2)
SUMMA_RB            DECIMAL(12,2)
BANKURSS            REAL
VIRSRAKSTS          STRING(110)
FILTRS_TEXT         STRING(100)

!-------------------------------------------------------------------------
report REPORT,AT(198,1792,12000,6198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,500,12000,1292),USE(?unnamed:2)
         STRING('numurs'),AT(1354,1042,677,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(4594,1042,469,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5063,1042,302,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, valûtâ'),AT(6094,1042,1042,208),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN,val.'),AT(7167,1042,625,208),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(2083,833,2500,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1302,781,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s45),AT(3031,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s110),AT(375,365,9771,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,990,2031,0),USE(?Line76),COLOR(COLOR:Black)
         STRING('FORMA IE3K'),AT(9948,469,813,156),USE(?String7),RIGHT(1)
         STRING(@P<<<#. lapaP),AT(10188,615,,156),PAGENO,USE(?PageCount),RIGHT(1)
         LINE,AT(156,781,10677,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,833,417,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(656,833,625,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(1354,833,677,208),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(4635,833,729,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN'),AT(5375,833,375,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5708,833,333,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s.Trans.'),AT(7188,833,625,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârpuspavadzîmes izmaksas'),AT(7865,833,1979,156),USE(?String68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(6094,833,1042,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Muita'),AT(7865,1042,625,208),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîze'),AT(8542,1042,625,208),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Citas'),AT(9219,1042,625,208),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(5396,1042,625,208),USE(?String10:18),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9844,781,0,521),USE(?Line10:6),COLOR(COLOR:Black)
         LINE,AT(9844,833,0,521),USE(?Line10:5),COLOR(COLOR:Black)
         STRING('Kopâ,'),AT(9896,833,938,208),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(9906,1021,938,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10833,781,0,521),USE(?Line10:7),COLOR(COLOR:Black)
         LINE,AT(9167,990,0,313),USE(?Line10:8),COLOR(COLOR:Black)
         LINE,AT(7813,781,0,521),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(7135,781,0,521),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(6042,781,0,521),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(5365,781,0,521),USE(?Line2:18),COLOR(COLOR:Black)
         STRING('datums'),AT(656,1042,625,208),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1250,10677,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s100),AT(1542,573,7469,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,781,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2031,781,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4583,781,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(8490,990,0,313),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(156,781,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(625,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(656,10,625,156),USE(PAV:DATUMS)
         LINE,AT(1302,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@S14),AT(1333,0,677,156),USE(DOK_SENR),RIGHT(1)
         LINE,AT(2031,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S40),AT(2063,10,2500,156),USE(PAV:pamat),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(4583,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6094,10,729,156),USE(SUMMA_P),RIGHT
         STRING(@S3),AT(6865,10,260,156),USE(PAV:VAL),LEFT
         STRING(@N-_12.2),AT(4615,10,729,156),USE(SUMMA_B),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(5396,10,625,156),USE(SUMMA_PVN),RIGHT
         LINE,AT(6042,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7167,10,625,156),USE(PAV:T_SUMMA),RIGHT
         LINE,AT(7813,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7844,10,625,156),USE(PAV:MUITA),RIGHT
         LINE,AT(8490,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(8521,10,625,156),USE(PAV:AKCIZE),RIGHT
         LINE,AT(9167,-10,0,198),USE(?Line2:23),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(9198,10,625,156),USE(PAV:citas),RIGHT
         LINE,AT(9844,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(9896,10,885,156),USE(itogo),RIGHT
         LINE,AT(10833,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(208,10,365,156),USE(NR),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(156,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(2031,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,115),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,115),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,115),USE(?Line219),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,115),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,115),USE(?Line192),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,115),USE(?Line191),COLOR(COLOR:Black)
         LINE,AT(156,52,10677,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(10833,-10,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(1302,-10,0,63),USE(?Line116),COLOR(COLOR:Black)
         LINE,AT(9844,-10,0,115),USE(?Line119),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(7813,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,198),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,198),USE(?Line21:26),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(9198,10,625,156),USE(citask),RIGHT
         LINE,AT(9844,-10,0,198),USE(?Line12:26),COLOR(COLOR:Black)
         LINE,AT(10833,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7167,10,625,156),USE(SUMMA_TK),RIGHT
         LINE,AT(156,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(4615,10,729,156),USE(SUMMA_BK),RIGHT
         LINE,AT(5365,-10,0,198),USE(?Line21:13),COLOR(COLOR:Black)
         STRING(@N-_10.2B),AT(5396,10,625,156),USE(SUMMA_PVNK),RIGHT
         LINE,AT(6042,-10,0,198),USE(?Line12:13),COLOR(COLOR:Black)
         STRING(@S20),AT(208,10,1510,156),USE(KOPA),LEFT
         STRING(@N_10.2B),AT(8521,10,625,156),USE(akcizk),RIGHT
         STRING(@N-_14.2B),AT(9896,10,885,156),USE(itogok),RIGHT
         STRING(@N_10.2B),AT(7844,10,625,156),USE(muik),RIGHT
         STRING(@N-_12.2B),AT(6094,10,729,156),USE(SUMMA_PK),RIGHT
         STRING(@S3),AT(6865,10,260,156),USE(VALK),LEFT
       END
RPT_FOOT2A DETAIL,AT(,,,469),USE(?unnamed)
         LINE,AT(10833,-10,0,490),USE(?Line2:17),COLOR(COLOR:Black)
         STRING('tara'),AT(677,156,417,156),USE(?String29:3),LEFT
         STRING(@N-_12.2),AT(6094,156,729,156),USE(tara),RIGHT
         STRING(@s3),AT(6875,135,240,156),USE(val_uzsk,,?val_uzsk:5),LEFT
         STRING('pakalpojumi'),AT(313,313,781,156),USE(?String29:5),LEFT
         STRING(@N-_12.2),AT(6094,313,729,156),USE(pakalpojumi),RIGHT
         STRING(@s3),AT(6875,292,240,156),USE(val_uzsk,,?val_uzsk:6),LEFT
         STRING('t.s.       prece'),AT(208,10,885,156),USE(?String29),LEFT
         LINE,AT(7135,-10,0,490),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,490),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,490),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(9844,-10,0,490),USE(?Line12:17),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,490),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(6094,10,729,156),USE(prece),RIGHT
         STRING(@s3),AT(6875,10,240,156),USE(val_uzsk,,?val_uzsk:4),LEFT
         LINE,AT(4583,-10,0,490),USE(?Line2:116),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,490),USE(?Line21:16),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,490),USE(?Line12:16),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,490),USE(?Line2:30),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,417),USE(?unnamed:3)
         STRING('Sastâdîja :'),AT(167,73,573,156),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(740,73,677,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1625,73,271,156),USE(?String38),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1885,73,188,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9833,73,573,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10417,73,469,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(156,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(5365,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(10833,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(7135,-10,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,63),USE(?Line233),COLOR(COLOR:Black)
         LINE,AT(8490,-10,0,63),USE(?Line331),COLOR(COLOR:Black)
         LINE,AT(9167,-10,0,63),USE(?Line313),COLOR(COLOR:Black)
         LINE,AT(9844,-10,0,63),USE(?Line133),COLOR(COLOR:Black)
         LINE,AT(156,52,10677,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7850,12000,63)
         LINE,AT(156,0,10677,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!    VAJADZÇTU APVIENIT AR N_IENPAV...
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('CN',CN)
  BIND('CYCLENOL',CYCLENOL)
  KOPA='Kopâ :'
  DAT = TODAY()
  LAI = CLOCK()
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
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ienâkuðâs P/Z no '&PAR:NOS_S
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P10111'
      VIRSRAKSTS='Ienâkuðâs pavadzîmes ('&D_K&') no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      FILTRS_TEXT='Piegâdâtâjs: '&CLIP(PAR:NOS_P)&' '&PAR:ADRESE
!      ' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala).
      IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
!      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala).
!      IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
!      IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&PAR_GRUPA.
!      IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
!      IF ~(NOM_TIPS7='PTAKRIV') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:'&NOM_TIPS7.
!      IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.
!
      CLEAR(PAV:RECORD)
      PAV:DATUMS=S_DAT
      PAV:D_K=D_K
      PAV:PAR_NR=PAR_NR
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IENPAVP.TXT')
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
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Pamatojums'&CHR(9)&'Bilances'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&|
!             CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'Dokumenta'&CHR(9)&'Pamatojums'&CHR(9)&'Bilances'&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Ârpuspavadzîmes izmaksas'&CHR(9)&CHR(9)&|
             CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'vçrtîba, Ls'&CHR(9)&CHR(9)&'ar PVN, val.'&|
!             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             OUTA:LINE=CHR(9)&'Datums'&CHR(9)&'Numurs'&CHR(9)&CHR(9)&'vçrtîba, '&val_uzsk&CHR(9)&CHR(9)&'ar PVN, val.'&|
             CHR(9)&CHR(9)&'(P/Z,val.)'&CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'
             ADD(OUTFILEANSI)
          ELSE !WORD
!             OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Pamatojums'&CHR(9)&|
!             'Bilances vçrtîba, Ls'&CHR(9)&'PVN, Ls'&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&|
!             CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'Dokumenta Numurs'&CHR(9)&'Pamatojums'&CHR(9)&|
             'Bilances vçrtîba, '&val_uzsk&CHR(9)&'PVN, '&val_uzsk&CHR(9)&'Vçrtîba ar PVN, val.'&CHR(9)&CHR(9)&'Transports (P/Z,val.)'&|
             CHR(9)&'Muita'&CHR(9)&'Akcîze'&CHR(9)&'Citas'&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NR+=1
        ?Progress:UserString{Prop:Text}=NR
        DISPLAY(?Progress:UserString)
        BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
        SUMMA_P   = PAV:SUMMA
!        SUMMA_PVN = (PAV:SUMMA-PAV:SUMMA_B)*BANKURS(PAV:VAL,PAV:DATUMS)
        SUMMA_PVN  = (PAV:SUMMA-PAV:T_SUMMA-PAV:SUMMA_B)*BANKURSS          !PAV:SUMA_B IR BEZ TRANSPORTA
        SUMMA_PVN += (PAV:T_SUMMA-PAV:T_SUMMA/(1+PAV:T_PVN/100))*BANKURSS  !PAV:SUMA_B IR BEZ TRANSPORTA
        SUMMA_B   = PAV:SUMMA_B*BANKURSS
        ITOGO     = PAV:SUMMA*BANKURSS + PAV:MUITA + PAV:AKCIZE + PAV:CITAS
        SUMMA_PK   += PAV:SUMMA*BANKURSS !LS, PÇC TAM BÛS TS
        SUMMA_BK   += SUMMA_B
        SUMMA_PVNK += SUMMA_PVN
        MUIK   += PAV:MUITA
        AKCIZK += PAV:AKCIZE
        CITASK += PAV:CITAS
        SUMMA_TK  += PAV:T_SUMMA*BANKURS(PAV:VAL,PAV:DATUMS) !LS PÇC PAM BÛS TS
        ITOGOK += ITOGO
        BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
        IF PAV:SUMMA<0      !ATGRIEZTÂ PRECE
            SUMMA_R  += SUMMA_p*BANKURSS + PAV:T_SUMMA*BANKURSS !+PAV:C_SUMMA
            SUMMA_RB += PAV:SUMMA_B*BANKURSS
        END
!        GET(K_TABLE,0)
        K:VAL=PAV:VAL
        GET(K_TABLE,K:VAL)
        IF ERROR()
          K:VAL     = PAV:VAL
          K:SUMMA_P = summa_P
          K:SUMMA_T = PAV:T_SUMMA
          ADD(K_TABLE)
          SORT(K_TABLE,K:VAL)
        ELSE
          K:SUMMA_P += SUMMA_P
          K:SUMMA_T += PAV:T_SUMMA
          PUT(K_TABLE)
        .
        DOK_SENR=PAV:DOK_SENR
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSE
            OUTA:LINE=CLIP(NR)&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&PAV:DOK_SENR&CHR(9)&PAV:PAMAT&CHR(9)&|
            LEFT(FORMAT(SUMMA_B,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVN,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_12.2))&|
            CHR(9)&PAV:VAL&CHR(9)&LEFT(FORMAT(PAV:T_SUMMA,@N-_11.2))&CHR(9)&LEFT(FORMAT(PAV:MUITA,@N-_10.2))&CHR(9)&|
            LEFT(FORMAT(PAV:AKCIZE,@N-_10.2))&CHR(9)&LEFT(FORMAT(PAV:CITAS,@N-_10.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N-_14.2))
            ADD(OUTFILEANSI)
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
!****************************DRUKÂJAM KOPÂ **************
    KOPA='Kopâ:'
    !VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_12.2))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VALK&CHR(9)&LEFT(FORMAT(SUMMA_TK,@N-_11.2))&CHR(9)&|
        LEFT(FORMAT(MUIK,@N-_10.2))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2))&CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2))&CHR(9)&|
        LEFT(FORMAT(ITOGOK,@N-_14.2))
        ADD(OUTFILEANSI)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    SUMMA_BK   = 0
    SUMMA_PVNK = 0
    MUIK       = 0
    AKCIZK     = 0
    CITASK     = 0
    ITOGOK     = 0
    kopa=' t.s.'
    LOOP J# = 1 TO RECORDS(K_TABLE)
      GET(K_TABLE,J#)
      IF K:SUMMA_P > 0
        SUMMA_PK = K:SUMMA_P
        SUMMA_TK = K:SUMMA_T
        VALK     = K:VAL
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2B))&CHR(9)&|
            LEFT(FORMAT(SUMMA_PVNK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2))&CHR(9)&VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_TK,@N-_11.2))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2B))&|
            CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2B))
            ADD(OUTFILEANSI)
        .
        kopa=''
      .
    .
!****************************JA IR ATGRIEZTA PRECE**************
    IF SUMMA_R
        KOPA='Atgriezta prece'
        VALK = ''
        SUMMA_BK   = SUMMA_RB
        SUMMA_PK   = 0
        SUMMA_PVNK = 0
        SUMMA_TK   = 0
        MUIK       = 0
        AKCIZK     = 0
        CITASK     = 0
        ITOGOK     = SUMMA_R
        IF F:DBF='W'
            PRINT(RPT:RPT_FOOT2)
        ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&CHR(9)&|
            LEFT(FORMAT(SUMMA_PVNK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_12.2B))&CHR(9)&VALK&CHR(9)&|
            LEFT(FORMAT(SUMMA_TK,@N-_11.2B))&CHR(9)&LEFT(FORMAT(MUIK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(AKCIZK,@N-_10.2B))&|
            CHR(9)&LEFT(FORMAT(CITASK,@N-_10.2B))&CHR(9)&LEFT(FORMAT(ITOGOK,@N-_14.2))
            ADD(OUTFILEANSI)
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
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|

!-----------------------------------------------------------------------------
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
