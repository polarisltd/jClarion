                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETCAL               FUNCTION (datums)            ! Declare Procedure
  CODE                                            ! Begin processed code
 IF CAL::USED=0
    checkopen(cal,1)
 .
 CAL::USED+=1
 cal:datums=datums
 get(cal,cal:dat_key)
 if error()
   if DATUMS%7=0
      cal:stundas=' '    !SVÇTDIENA
   elsif DATUMS%7=6
      cal:stundas='S'    !SESTDIENA
   ELSE
      cal:stundas='8'    !DARBADIENA
   .
   ADD(CAL)
 .
 CAL::USED-=1
 IF CAL::USED=0 THEN CLOSE(CAL).
 RETURN(CAL:STUNDAS)
K_P_FIFO             PROCEDURE                    ! Declare Procedure
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

ERRORFILE            FILE,DRIVER('ASCII'),PRE(ERR),CREATE,NAME(FILENAME1),BINDABLE,THREAD
Record                   RECORD,PRE()
line                        STRING(132)
                         END
                      END

!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------

B_TABLE              QUEUE,PRE(B)
BKK                    STRING(5)
SUMMA                  REAL
                     .

FIFO                 QUEUE,PRE(F)
KEY                    STRING(10)
DATUMS                 LONG
D_K                    string(2)
NOL_NR                 BYTE
DAUDZUMS               DECIMAL(11,3)
SUMMA                  DECIMAL(11,2)
                     .

NOLLIST              STRING(45)
PA                   SHORT
NR                   DECIMAL(4)
NOSAUKUMS            STRING(29)
ERR                  STRING(8)
VID                  DECIMAL(11,4)
P_DATUMS             LONG
P_MEN_NR             BYTE
CTRL_I               DECIMAL(13,3)
REALIZ_A             DECIMAL(13,3),DIM(2)
REALIZETS            DECIMAL(13,3),DIM(2)
REALIZETS_P          DECIMAL(13,3)
RAZOSANA_D           DECIMAL(13,3),DIM(2)
RAZOSANA_S           DECIMAL(13,2),DIM(2)
RAZOSANA_DP          DECIMAL(13,3)
RAZOSANA_SP          DECIMAL(13,2)
SUMMA_R              DECIMAL(13,2)
SUMMA_RP             DECIMAL(13,2)
REALIZETS_N          DECIMAL(13,3),DIM(2,25)
FMI_K                DECIMAL(13,2)
FMI_TS               DECIMAL(13,2)
REA_TS               DECIMAL(13,3)
KOPA                 STRING(65)
FMI                  DECIMAL(14,2),DIM(2)
FMI_N                DECIMAL(14,2),DIM(25)
REA_N                DECIMAL(13,3),DIM(25)
FMI_P                DECIMAL(14,2)
FMI_PICK             DECIMAL(14,2)
DAT                  DATE
LAI                  TIME
SUM1                 STRING(15)
SUM2                 STRING(15)
SUM3                 STRING(15)
VAD_BIL_A            STRING(20)
VS_DAUDZUMS          DECIMAL(13,3),DIM(2)
VS_SUMMA             DECIMAL(13,2),DIM(2)
VS_FIFO_TEXT         STRING(80)

ATGR_TEXT            STRING(120)
ATGR_TEXT2           STRING(120)
KOMP_TEXT            STRING(120)
ERRK                 USHORT
BRIK                 USHORT
ERRORTEXT            STRING(100)
VMIS                 STRING(1),DIM(25,2)
SAV_JOB_NR           LIKE(JOB_NR)

!---------------------------------------------------------------------------
report REPORT,AT(104,1333,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,104,8000,1229),USE(?unnamed:5)
         STRING(@s45),AT(2083,156,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s20),AT(510,208),USE(VAD_BIL_A),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(521,417,6010,260),USE(VS_FIFO_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,729,6667,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(938,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3490,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5260,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('NPK'),AT(573,781,365,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(990,781,1406,208),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2448,781,1042,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2396,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Vienas vienîbas'),AT(4219,781,990,208),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Faktiskâs izmaksas'),AT(5313,781,1875,208),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vidçjâ vçrtîba'),AT(4219,990,990,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5313,990,938,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa Ls'),AT(6250,990,938,208),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1198,6667,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(521,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@P<<<#. lapaP),AT(6458,521,677,156),PAGENO,USE(?PA),RIGHT
       END
detail DETAIL,AT(,,,135)
         LINE,AT(521,0,0,155),USE(?Line7),COLOR(COLOR:Black)
         STRING(@N_5),AT(573,0,313,130),USE(NR),RIGHT
         LINE,AT(2396,0,0,155),USE(?Line7:8),COLOR(COLOR:Black)
         STRING(@s16),AT(2448,0,1042,130),USE(KOPS:nos_s),LEFT
         LINE,AT(938,0,0,155),USE(?Line7:2),COLOR(COLOR:Black)
         STRING(@s21),AT(990,0,1406,130),USE(KOPS:nomenklat),LEFT
         LINE,AT(3490,0,0,155),USE(?Line7:6),COLOR(COLOR:Black)
         STRING(@s8),AT(3594,0,521,130),USE(ERR),CENTER
         LINE,AT(4167,0,0,155),USE(?Line7:3),COLOR(COLOR:Black)
         STRING(@N_11.4),AT(4375,0,,130),USE(VID),RIGHT
         LINE,AT(5260,0,0,155),USE(?Line7:5),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(5365,0,,130),USE(REALIZETS_P),RIGHT
         STRING(@N-_13.2),AT(6250,0,,130),USE(FMI_P),RIGHT
         LINE,AT(7188,0,0,155),USE(?Line7:4),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:3)
         LINE,AT(521,0,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(938,0,0,63),USE(?Line16),COLOR(COLOR:Black)
         LINE,AT(2396,0,0,63),USE(?Line16:2),COLOR(COLOR:Black)
         LINE,AT(3490,-52,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4167,-52,0,115),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,115),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(521,0,0,198),USE(?Line7:7),COLOR(COLOR:Black)
         STRING(@s65),AT(625,10,4594,156),USE(KOPA),LEFT
         STRING(@N-_13.3b),AT(5365,10,,156),USE(REA_TS),RIGHT
         LINE,AT(5260,0,0,198),USE(?Line25),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,10,,156),USE(FMI_TS),RIGHT
         LINE,AT(7188,0,0,198),USE(?Line25:2),COLOR(COLOR:Black)
       END
RPT_RAZ DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(521,0,0,198),USE(?Line7:77),COLOR(COLOR:Black)
         STRING(@N-_13.3),AT(5365,10,,156),USE(Razosana_dp),RIGHT
         LINE,AT(5260,0,0,198),USE(?Line257),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,10,,156),USE(Razosana_sP),RIGHT
         STRING('...tai skaitâ norakstîts raþoðanâ :'),AT(604,10),USE(?String35)
         LINE,AT(7188,0,0,198),USE(?Line25:52),COLOR(COLOR:Black)
         LINE,AT(521,0,6667,0),USE(?Line1:7),COLOR(COLOR:Black)
       END
RPT_KOPA DETAIL,AT(,,8000,313),USE(?unnamed:6)
         LINE,AT(521,0,0,323),USE(?Line25:3),COLOR(COLOR:Black)
         LINE,AT(521,52,6667,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Summa :'),AT(625,104,625,208),USE(?String28),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2),AT(6188,104),USE(FMI_k),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(1271,104,4896,208),USE(ERRORTEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,0,0,52),USE(?Line25:6),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,323),USE(?Line25:7),COLOR(COLOR:Black)
       END
RPT_RET DETAIL,AT(,,,177),USE(?ATGRIEZTS)
         LINE,AT(521,0,0,198),USE(?Line7:77R),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,10,,156),USE(SUMMA_R),RIGHT
         STRING('mçs esam atgriezuði preci'),AT(604,10),USE(?String35R)
         LINE,AT(7188,0,0,198),USE(?Line25:52R),COLOR(COLOR:Black)
         LINE,AT(521,0,6667,0),USE(?Line1:7R),COLOR(COLOR:Black)
       END
RPT_PAVISAM DETAIL,AT(,,,177),USE(?PAVISAM)
         LINE,AT(521,0,0,198),USE(?Line7:77P),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(6188,10,,156),USE(SUMMA_RP),RIGHT,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Pavisam :'),AT(604,10),USE(?String35:2P),FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(7188,0,0,198),USE(?Line25:52P),COLOR(COLOR:Black)
         LINE,AT(521,0,6667,0),USE(?Line1:8P),COLOR(COLOR:Black)
       END
RPT_FOOTER DETAIL,AT(,,8000,802),USE(?unnamed)
         LINE,AT(531,0,6667,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(510,20,469,156),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(979,20,573,156),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1760,20,219,156),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1969,20,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6146,20,615,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6729,20,490,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING('Vid. iepirkuma cena tiek rçíinâta kâ faktisko izmaksu summas un daudzuma attiecî' &|
             'ba periodâ, informatîvs raksturs'),AT(333,177,5990,156),USE(?String30:3),TRN,LEFT
         STRING(@s120),AT(333,323,7198,156),USE(atgr_text),LEFT
         STRING(@s120),AT(333,469,7198,156),USE(atgr_text2),TRN,LEFT
         STRING(@s120),AT(333,625,7198,156),USE(KOMP_text),TRN,LEFT
       END
       FOOTER,AT(104,11000,8000,63)
         LINE,AT(521,0,6667,0),USE(?Line1:6),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(65,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  dat=today()
  lai=clock()
  SAV_JOB_NR=JOB_NR
  LOOP I#= 1 TO NOL_SK
     JOB_NR=I#+15
     CHECKOPEN(SYSTEM,1)
     IF BAND(SYS:BAITS1,00000100B)  ! Vairumtirdzniecîba
        VMIS[I#,1]='V'
     ELSE
        VMIS[I#,1]='M'
     .
     IF DAIKODS                  ! VADÎBAS ATSKAITE
        VMIS[I#,2]='V'
     ELSE
        VMIS[I#,2]='S'
     .
  .
  JOB_NR=SAV_JOB_NR
  CHECKOPEN(SYSTEM,1)
  IF DAIKODS !VADÎBAS ATSKAITE
     VAD_BIL_A='Vadîbas atskaite'
     ATGR_TEXT='Ðajâ atskaitç mûsu atgrieztâs preces netiek uzskatîtas par realizâciju'
  ELSE     !BILANCES ATSKAITE
     VAD_BIL_A='Bilances atskaite'
     ATGR_TEXT='Mûsu atgrieztâs preces(-D), kurâm nav definçta p/z,no kuras atgrieþ,tiek uzskatîtas par realizâciju'
  .
  IF BAND(REG_NOL_ACC,00010000b) ! ATÏAUTA KOMPLEKTÂCIJA
     KOMP_TEXT='Raþojumi tiek ignorçti, paðizmaksu rçíinam pçc R norakstîtajâm sastâvdaïâm'
  .
  CHECKOPEN(GLOBAL,1)
  CASE GL:FMI_TIPS
  OF 'VS'
     VS_FIFO_TEXT='Paðizmaksas aprçíins VS metode no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
  ELSE
     VS_FIFO_TEXT='Paðizmaksas aprçíins FIFO metode no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
  .
  IF NOL_KOPS::USED=0
     CHECKOPEN(NOL_KOPS,1)
  .
  NOL_KOPS::USED+=1
  IF NOL_FIFO::USED=0
     CHECKOPEN(NOL_FIFO,1)
  .
  NOL_FIFO::USED+=1
  BIND(KOPS:RECORD)

  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% '
  ProgressWindow{Prop:Text} = 'Paðizmaksa '&GL:FMI_TIPS
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KOPS:RECORD)
      KOPS:NOMENKLAT=NOMENKLAT
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
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
      FILENAME1=USERFOLDER&'\ERRORFILE.TXT'
      CHECKOPEN(ERRORFILE,1)
      CLOSE(ERRORFILE)
      OPEN(ERRORFILE,18)
      IF ERROR()
         KLUDA(1,FILENAME1)
      ELSE
         EMPTY(ERRORFILE)
      .
      IF F:DBF='W'
         OPEN(report)
         report{Prop:Preview} = PrintPreviewImage
      ELSE
         IF DAIKODS                  ! VADÎBAS ATSKAITE
            IF ~OPENANSI('KPVFIFO.TXT')
              POST(Event:CloseWindow)
              CYCLE
            .
         ELSE
            IF ~OPENANSI('KPFIFO.TXT')
              POST(Event:CloseWindow)
              CYCLE
            .
         .
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         OUTA:LINE=CLIENT
         ADD(OUTFILEANSI)
         OUTA:LINE=VAD_BIL_A
         ADD(OUTFILEANSI)
         OUTA:LINE=VS_FIFO_TEXT
         ADD(OUTFILEANSI)
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         IF F:DBF='E'
            OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&'Vienas vienîbas'&CHR(9)&|
            'Faktiskâs izmaksas'
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vidçja vçrtîba'&CHR(9)&'Daudzums'&CHR(9)&'Summa Ls'
            ADD(OUTFILEANSI)
         ELSE
            OUTA:LINE='NPK'&CHR(9)&'Nomenklatûra'&CHR(9)&'Nosaukums'&CHR(9)&CHR(9)&'Vienas vienîbas vidçja vçrtîba'&|
            CHR(9)&'Faktiskâs izmaksas daudzums'&CHR(9)&'Faktiskâs izmaksas summa Ls'
            ADD(OUTFILEANSI)
         .
         OUTA:LINE=''
         ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
        IF ~(BAND(REG_NOL_ACC,00010000b) AND GETNOM_K(KOPS:NOMENKLAT,0,16)='R')! ~(ATÏAUTA KOMPLEKTÂCIJA UN RAÞOJUMS)
           nk#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           CHECKKOPS('POZICIONÇTS',0,0) !UZ REQ=0 NEPÂRBÛVÇJAM
           CLEAR(FMI)
           CLEAR(REALIZETS_N)
           CLEAR(REALIZ_A)
           CLEAR(VS_DAUDZUMS)
           CLEAR(VS_SUMMA)
           ERR=''
           CTRL_I=0
           LOOP L#=1 TO 2  !UZ MÇNEÐA SÂKUMU UN BEIGÂM
!              FOUND_D# =0
!              FMI_P6   =0
              EXECUTE L#
                 P_DATUMS=S_DAT-1 !UZ S_DAT
                 P_DATUMS=B_DAT   !UZ B_DAT
              .
              EXECUTE L#
                 P_MEN_NR=MONTH(S_DAT)-1
                 P_MEN_NR=MONTH(B_DAT)
              .
!----------PIRMAJÂ PIEGÂJIENÂ SAMEKLÂJAM MÛSU ATGRIEZTO PRECI, SASKAITAM REALIZÂCIJU UN ATLIKUMUS NOLIKTAVÂS------

              CLEAR(FIFO:RECORD)
              FIFO:U_NR=KOPS:U_NR
              FIFO:DATUMS=DATE(1,1,DB_GADS)
              SET(FIFO:NR_KEY,FIFO:NR_KEY)
              LOOP
                 NEXT(NOL_FIFO)
                 IF ERROR() OR ~(FIFO:U_NR=KOPS:U_NR AND FIFO:DATUMS<=P_DATUMS) THEN BREAK.
                 F:KEY     =FIFO:DATUMS&FIFO:D_K
                 F:DATUMS  =FIFO:DATUMS
                 F:NOL_NR  =FIFO:NOL_NR
                 F:D_K     =FIFO:D_K
                 F:DAUDZUMS=FIFO:DAUDZUMS
                 F:SUMMA   =FIFO:SUMMA
                 ADD(FIFO)

                 CASE FIFO:D_K
                 OF 'A '
                    IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU
                       IF ~DAIKODS     !IR BILANCES ATSKAITE
                          REALIZ_A[L#]+=ABS(FIFO:DAUDZUMS)
                          REALIZETS_N[L#,FIFO:NOL_NR]+=ABS(FIFO:DAUDZUMS)
                       .
                    ELSE
                       VS_DAUDZUMS[L#]+=FIFO:DAUDZUMS
                       VS_SUMMA[L#]+=FIFO:SUMMA
                    .
!                 OF 'D '
!                 OROF 'DR'
!                    IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU (VARBÛT NE?)
!                       REALIZETS+=ABS(FIFO:DAUDZUMS)
!                       IF X#=2   !UZ B_DAT
!                          IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
!                             SUMMA_R+=ABS(FIFO:SUMMA)
!                             DAUK-=FIFO:DAUDZUMS
!                          .
!                          DAU2+=FIFO:DAUDZUMS
!                       .
!                    ELSE
                 OF 'D '
                 OROF 'DR'
                    IF FIFO:DAUDZUMS<0 !MÇS ESAM ATGRIEZUÐI PRECI,JÂUZSKATA PAR REALIZÂCIJU (VARBÛT NE?)
                       IF ~DAIKODS     !IR BILANCES ATSKAITE
                          REALIZ_A[L#]+=ABS(FIFO:DAUDZUMS)
                          REALIZETS_N[L#,FIFO:NOL_NR]+=ABS(FIFO:DAUDZUMS)
                       .
                       IF L#=2   !UZ B_DAT
                          IF INRANGE(FIFO:DATUMS,S_DAT,B_DAT)
                             SUMMA_R+=ABS(FIFO:SUMMA)
                          .
                       .
                    ELSE
                       VS_DAUDZUMS[L#]+=FIFO:DAUDZUMS
                       VS_SUMMA[L#]+=FIFO:SUMMA
                    .
                 OF 'DI'
                    CTRL_I+=FIFO:DAUDZUMS
                 OF 'K '
!                    IF (CL_NR=1237 OR CL_NR=1308) AND FIFO:DAUDZUMS<0  !GAG
!                    IF FIFO:DAUDZUMS<0 AND VMIS[FIFO:NOL_NR,2]='I' !PÇRKAM
!                       F:D_K     ='D'
!                       F:DAUDZUMS=ABS(FIFO:DAUDZUMS)
!                       F:SUMMA   =ABS(FIFO:SUMMA)
!                       PUT(FIFO)
!                    ELSE
                       REALIZ_A[L#]+=FIFO:DAUDZUMS   !JA - ,LAI SAMAZINA REALIZÂCIJU,JA PIEPRASÎTS STORNÇT
                       REALIZETS_N[L#,FIFO:NOL_NR]+=FIFO:DAUDZUMS
!                    .
                 OF 'KR' !PERIODA BEIGÂS UZ RAÞOÐANU NEDRÎKST BÛT ATLIKUMI....???
                    REALIZ_A[L#]+=FIFO:DAUDZUMS
                    REALIZETS_N[L#,FIFO:NOL_NR]+=FIFO:DAUDZUMS
                    RAZOSANA_D[L#]+=FIFO:DAUDZUMS
                    RAZOSANA_S[L#]+=FIFO:SUMMA
                 OF 'KI'
                    CTRL_I-=FIFO:DAUDZUMS
                 .
              .
              REALIZETS[L#]=REALIZ_A[L#]
              IF CTRL_I
                 ERR='IP KÏÛDA'
              .

              CASE GL:FMI_TIPS
              OF 'FIFO'
!              IF CL_NR=1237 OR CL_NR=1308  !GAG
!---------------------RÇÍINAM REÂLÂS FIFO TABULAS------------------
                 SORT(FIFO,F:KEY)
                 GET(FIFO,0)
                 LOOP F#=1 TO RECORDS(FIFO)
!                   STOP(F:D_K&F:DAUDZUMS&' '&F:SUMMA&' '&REALIZ_A[1]&' '&REALIZ_A[2])
                  GET(FIFO,F#)
                   IF ~INSTRING(F:D_K,'A D DR',2) THEN CYCLE.
                   IF F:DAUDZUMS<0  THEN CYCLE.   !MÇS ESAM ATGRIEZUÐI, JAU PIESKAITÎJÂM REALIZÂCIJAI
                                                  !VADÎBAS ATSKAITEI VIENKÂRÐI IGNORÇJAM
                   IF REALIZ_A[L#] > F:DAUDZUMS
                      FMI[L#]+=F:SUMMA
                      REALIZ_A[L#]-=F:DAUDZUMS
                   ELSE
                      FMI[L#]+=F:SUMMA/F:DAUDZUMS*REALIZ_A[L#]
                      REALIZ_A[L#]=0
                      BREAK
                   .
                 .
                 IF REALIZ_A[L#] >0    !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT (ARÎ JA ATGRIEZTS VAIRÂK KÂ PÂRDOTS)
                    ERR='RE KÏÛDA'
                 .
                 FREE(FIFO)
              ELSE
!---------------------RÇÍINAM VS------------------
                 IF REALIZ_A[L#] > VS_DAUDZUMS[L#] !NEBIJA IENÂCIS TIK DAUDZ, CIK VAJADZÇJA REALIZÇT
                    ERR='RE KÏÛDA'
                 .
                 FMI[L#]=VS_SUMMA[L#]/VS_DAUDZUMS[L#]*REALIZ_A[L#]
!                 STOP(L#&' '&FMI[L#]&'= '&VS_SUMMA[L#]&'/'&VS_DAUDZUMS[L#]&'*'&REALIZ_A[L#])
              .
           .
!--------------------------------------------------
           REALIZETS_P=REALIZETS[2]-REALIZETS[1]
           RAZOSANA_DP=RAZOSANA_D[2]-RAZOSANA_D[1]
           RAZOSANA_SP=RAZOSANA_S[2]-RAZOSANA_S[1]
           FMI_P=FMI[2]-FMI[1]

!!           IF REALIZETS_P<0 AND FMI_P=0 !ATGRIEÐANA, KUR NAV BIJIS NE SALDO,NE IENÂKOÐÂ, ÒEMAM PIC
!           IF REALIZETS_P AND FMI_P=0 !ÐÎ IR VAI IR BIJUSI ATGRIEÐANA, KUR NAV BIJIS NE SALDO,NE IENÂKOÐÂ, ÒEMAM PIC
!              FMI_P=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*REALIZETS_P  !PIC
!              IF FMI_P
!                 ERR='PIC'
!                 IF REALIZETS_P<0
!                    FMI_PICK+=FMI_P
!                 .
!              ELSE
!                 ERR='BV KÏÛDA'
!              .
!           .

           IF REALIZETS_P
              IF FMI_P=0  !ÐÎ IR VAI IR BIJUSI ATGRIEÐANA VAI REALIZÂCIJA, KUR NAV BIJIS NE SALDO,NE IENÂKOÐÂ, ÒEMAM PIC
                 FMI_P=GETNOM_K(KOPS:NOMENKLAT,0,7,6)*REALIZETS_P  !PIC
                 IF FMI_P
                    ERR='PIC'
                    IF REALIZETS_P<0
                       FMI_PICK+=FMI_P
                    .
                 ELSE
                    ERR='BV KÏÛDA'
                 .
              .
           ELSE
              FMI_P=0 !PERIODÂ NAV BIJIS NE REALIZÂCIJAS, NE ATGRIEÐANAS
           .


           FMI_K+=FMI_P
           VID=FMI_P/REALIZETS_P

           CASE ERR[1:2]
           OF 'RE'
              ERR:LINE='Realizâcijas kïûda nomenklatûrai '&KOPS:NOMENKLAT
              ADD(ERRORFILE)
           OF 'BV'
              ERR:LINE='Nav atrodama iepirkuma cena nomenklatûrai '&KOPS:NOMENKLAT
              ADD(ERRORFILE)
           OF 'NR'
              ERR:LINE='Neatïauts noliktavas NR nomenklatûrai '&KOPS:NOMENKLAT
              ADD(ERRORFILE)
           OF 'IP'
              ERR:LINE='Iekðçjâs pârvietoðanas kïûda nomenklatûrai '&KOPS:NOMENKLAT
              ADD(ERRORFILE)
           OF 'PI'
              ERR:LINE='Izmantojam pçdçjo iepirkuma cenu no '&FORMAT(NOM:PIC_DATUMS,@D06.)&' nomenklatûrai '&KOPS:NOMENKLAT
              ADD(ERRORFILE)
           .

           LOOP N# = 1 TO NOL_SK
              FMI_N[N#]+=(REALIZETS_N[2,N#]-REALIZETS_N[1,N#])*VID
              REA_N[N#]+=REALIZETS_N[2,N#]-REALIZETS_N[1,N#]
!              STOP(REALIZETS_N[2,N#]&'-'&REALIZETS_N[1,N#])
           .
           DO PERFORMB_TABLE
           IF REALIZETS_P               !IR REALIZÂCIJA
 !         IF REALIZETS_P OR F:ATL[2]   !IEKÏAUT O-ES
              NR+=1
              IF ERR AND ERR='PIC'
                 BRIK+=1
              ELSIF ERR
                 ERRK+=1
              .
              IF F:DBF = 'W'
                PRINT(RPT:DETAIL)
              ELSE
                OUTA:LINE=NR&CHR(9)&KOPS:NOMENKLAT&CHR(9)&KOPS:NOS_S&CHR(9)&ERR&CHR(9)&LEFT(FORMAT(VID,@N_11.4))&|
                CHR(9)&LEFT(FORMAT(REALIZETS_P,@N-_12.3))&CHR(9)&LEFT(FORMAT(FMI_P,@N-_13.2))
                ADD(OUTFILEANSI)
              END
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
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT1)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  END
  LOOP I#= 1 TO NOL_SK
     KOPA='NOL'&CLIP(I#)
     IF VMIS[I#,1]='V'
        KOPA=CLIP(KOPA)&' Vairumtirdzniecîba'
     ELSE
        KOPA=CLIP(KOPA)&' Mazumtirdzniecîba'
     .
     FMI_TS=FMI_N[I#]
     REA_TS=REA_N[I#]
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT2)
     ELSE
        OUTA:LINE=CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(REA_TS,@N-_13.3B))&CHR(9)&|
        LEFT(FORMAT(FMI_TS,@N-_14.2))
        ADD(OUTFILEANSI)
     END
  .
  LOOP I#= 1 TO RECORDS(B_TABLE)   !PÇC BKK
     GET(B_TABLE,I#)
     KOPA='BKK: '&B:BKK
     REA_TS=0
     FMI_TS=B:SUMMA
     IF F:DBF = 'W'
        PRINT(RPT:RPT_FOOT2)
     ELSE
        OUTA:LINE=CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(REA_TS,@N-_13.3B))&CHR(9)&|
        LEFT(FORMAT(FMI_TS,@N-_14.2))
        ADD(OUTFILEANSI)
     END
  .
  IF F:DBF = 'W'
     PRINT(RPT:RPT_RAZ)
  ELSE
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     OUTA:LINE=CHR(9)&'...tai skaitâ norakstîts raþoðanâ'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(RAZOSANA_DP,@N-_13.2))&|
     CHR(9)&LEFT(FORMAT(RAZOSANA_SP,@N-_13.2))
     ADD(OUTFILEANSI)
  END
  IF ERRK
     ERRORTEXT=CLIP(ERRK)&' kïûdas'
  .
  IF BRIK
     ERRORTEXT=CLIP(ERRORTEXT)&' '&CLIP(BRIK)&' brîdinâjumi'
  .
  IF ERRK OR BRIK
     ERRORTEXT=CLIP(ERRORTEXT)&' '&'sk. '&clip(FILENAME1)
  .
  IF FMI_PICK
     ATGR_TEXT2='Paðizmaksa ir samazinâta par mums atgriezto,iepriekðçjos periodos realizçto,'&|
     'preci kopçjâ iepirkuma vçrtîbâ Ls '&clip(FMI_PICK)
  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_KOPA)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='SUMMA:'&CHR(9)&ERRORTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(FMI_K,@N-_14.2))
    ADD(OUTFILEANSI)
  .
  IF SUMMA_R AND| !MÇS ESAM ATGRIEZUÐI
  ~DAIKODS        !~VADÎBAS ATSKAITE

     SUMMA_RP=FMI_K-SUMMA_R
     IF F:DBF = 'W'
       PRINT(RPT:RPT_RET)
       PRINT(RPT:RPT_PAVISAM)
     ELSE
       OUTA:LINE='mçs esam atgriezuði preci'&CHR(9)&ERRORTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
       LEFT(FORMAT(SUMMA_R,@N-_14.2))
       ADD(OUTFILEANSI)
       OUTA:LINE='Pavisam:'&CHR(9)&ERRORTEXT&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
       LEFT(FORMAT(SUMMA_RP,@N-_14.2))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
     .
  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOTER)
  ELSE
    OUTA:LINE='Sastâdîja '&acc_kods&' '&FORMAT(DAT,@D06.)
    ADD(OUTFILEANSI)
    OUTA:LINE=atgr_text
    ADD(OUTFILEANSI)
    OUTA:LINE=atgr_text2
    ADD(OUTFILEANSI)
    OUTA:LINE=KOMP_text
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
  .
  IF SEND(NOL_KOPS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!!     report{Prop:Preview} = PrintPreviewImage
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
  NOL_FIFO::USED-=1
  IF NOL_FIFO::USED=0
     CLOSE(NOL_FIFO)
  .
  CLOSE(ERRORFILE)
  POPBIND
  IF ~F:DBF='W' THEN F:DBF='W'.
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
  IF ERRORCODE() OR (CYCLENOM(KOPS:NOMENKLAT)=2)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
PERFORMB_TABLE ROUTINE

  B:BKK=GETNOM_K(KOPS:NOMENKLAT,0,6)
  IF ~B:BKK THEN B:BKK='21300'.
  GET(B_TABLE,B:BKK)
  IF ERROR()
     B:SUMMA=FMI_P
     ADD(B_TABLE)
     SORT(B_TABLE,B:BKK)
  ELSE
     B:SUMMA+=FMI_P
     PUT(B_TABLE)
  .
GetParoles           FUNCTION (PAROLE,RET)        ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RET 1-PUB DAÏA
!     2-VÂRDS UZVÂRDS
!

 IF ~INRANGE(RET,1,2)
     STOP('PAROLES:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN('')
 .
 IF parole
    IF Paroles::USED=0
       CHECKOPEN(Paroles,1)
    .
    Paroles::USED+=1
    CLEAR(SEC:RECORD)
    SEC:U_NR=PAROLE
    GET(Paroles,SEC:NR_KEY)
    IF ERROR()
       RET=0
    .
    Paroles::USED-=1
    IF Paroles::USED=0
       CLOSE(Paroles)
    .
 ELSE
    RET=0
 .
 EXECUTE RET+1
   RETURN('')
   RETURN(SEC:PUBLISH)
   RETURN(SEC:VUT)
 .
