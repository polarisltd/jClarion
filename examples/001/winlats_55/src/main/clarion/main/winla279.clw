                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_PIE_2013_XML   PROCEDURE                    ! Declare Procedure
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

ceturksnis           BYTE
pusgads              BYTE
PER                  BYTE
PAR_NOS_P            STRING(35)
GGTEX                STRING(60)
GG_DOK_SE            STRING(7)
GG_DOK_NR            STRING(14)
GG_DOKDAT            LIKE(GG:DOKDAT)
PERS_KODS            STRING(22)
RINDA3               STRING(4)
DOK_SUMMA            DECIMAL(12,2)
DOK_SUMMAV           DECIMAL(12,2)
DOK_VAL              STRING(3)
PVN_SUMMA            DECIMAL(12,2)
DOK_SUMMA_X          DECIMAL(12,2)
PVN_SUMMA_X          DECIMAL(12,2)
DOK_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_K          DECIMAL(12,2)
DOK_SUMMA_K          DECIMAL(12,2)
PVN_SUMMA_K2         DECIMAL(12,2)
DOK_SUMMA_K2         DECIMAL(12,2)
PVN_SUMMA_K3         DECIMAL(12,2)
DOK_SUMMA_K3         DECIMAL(12,2)
DOK_SUMMA_P3         DECIMAL(12,2)
PVN_SUMMA_P3         DECIMAL(12,2)
SUMMA_PEC_KL         DECIMAL(12,2)
SUMMA_PEC_DOK        DECIMAL(12,2)

GGK_SUMMAV           LIKE(GGK:SUMMAV)
GGK_SUMMA            LIKE(GGK:SUMMA)

DATUMS               DATE
RMENESIEM            STRING(11)
MENESS               STRING(20)
NPK                  ULONG
CG                   STRING(10)
StringLimitSumma     string(30)

NOT0                 STRING(10)
NOT1                 STRING(45)
NOT2                 STRING(45)
NOT3                 STRING(45)

R_TABLE      QUEUE,PRE(R)
KEY             STRING(16) !Elya 18.08.2013
U_NR            ULONG
NOS_P           STRING(15)
PAR_TIPS        STRING(1)
D_K             STRING(1)
SADALA          BYTE
DATUMS          LONG
PAR_NR          ULONG
PVNS            DECIMAL(12,2),DIM(20,2) !18/5/18I/5I/12/21/10/22/12/21I/22I/10I/12I/21IN/22IN/10IN/12IN
SUMMA           DECIMAL(12,2)
RINDA           STRING(4)
VAL             STRING(3)
PVN_TIPS        STRING(1)
PAR_PVN         LIKE(PAR:PVN)
             .

C_TABLE      QUEUE,PRE(C)
U_NR            ULONG
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KK_TABLE      QUEUE,PRE(KK)
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

K_TABLE      QUEUE,PRE(K)
PAR_NR          ULONG
PVN             DECIMAL(12,2)
SUMMA           DECIMAL(12,2)
            .

CPR_TABLE      QUEUE,PRE(CPR)
U_NR            ULONG
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KKPR_TABLE      QUEUE,PRE(KKPR)
PAR_NR          ULONG
DOKSUMMA        DECIMAL(12,2)
             .

KPR_TABLE      QUEUE,PRE(KPR)
PAR_NR          ULONG
PVN             DECIMAL(12,2)
SUMMA           DECIMAL(12,2)
DV              STRING(4)
            .
PVNS                DECIMAL(12,2)
DOK_DAT             LONG
ATTDOK              STRING(30)
TEX:DUF             STRING(100)
KOPA_PVN            DECIMAL(12,2)
SUMMA_KOPA          DECIMAL(12,2)
DAR_SK              USHORT
PVN_KOPA            DECIMAL(12,2)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

E               STRING(1)
EE1             STRING(15)
EE2             STRING(15)
EE3             STRING(15)
DV              STRING(2)
DEKL            STRING(15)
CTRL            DECIMAL(12,2)
CTRL_TEXT       STRING(100)
RINDA           BYTE
PRECIZETA       STRING(15)
R63             DECIMAL(12,2)

!-----------------------------------------------------------------------------
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
!-----------------------------------------------------------------------------
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

  CODE                                            ! Begin processed code
!
! Tiek izsaukts tikai, ja GGK:DATUMS>2009
!
!R:DOKS[1] 231 Ls/Es 18%
!R:DOKS[2] 231 Ls/Es 5%
!R:DOKS[3] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI 18%
!R:DOKS[4] 231,PVN_TIPS=I IMPORTA PAKALPOJUMI  5%
!R:DOKS[5] 231 Ls 14%
!R:DOKS[6] 231 Ls/ES 21%
!R:DOKS[7] 231 Ls/ES 10%
!
!R:PVNS[1] PVN Ls 18%
!R:PVNS[2] PVN Ls 5%
!R:PVNS[3] PVN_TIPS=I IMPORTA PAKALPOJUMI 18%
!R:PVNS[4] PVN_TIPS=I IMPORTA PAKALPOJUMI  5%
!R:PVNS[5] PVN Ls 14%
!R:PVNS[6] PVN Ls 21%
!R:PVNS[7] PVN Ls 10%
!R:PVNS[8] PVN Ls 22%
!R:PVNS[9] PVN Ls 12%
!R:PVNS[10] PVN_TIPS=I IMPORTA PAKALPOJUMI 21%
!R:PVNS[11] PVN_TIPS=I IMPORTA PAKALPOJUMI 22%
!R:PVNS[12] PVN_TIPS=I IMPORTA PAKALPOJUMI 10%
!R:PVNS[13] PVN_TIPS=I IMPORTA PAKALPOJUMI 12%
!R:PVNS[14] PVN_TIPS=I IMPORTA PAKALPOJUMI 21% ES PVN Nemaksâtâjs
!R:PVNS[15] PVN_TIPS=I IMPORTA PAKALPOJUMI 22% ES PVN Nemaksâtâjs
!R:PVNS[16] PVN_TIPS=I IMPORTA PAKALPOJUMI 10% ES PVN Nemaksâtâjs
!R:PVNS[17] PVN_TIPS=I IMPORTA PAKALPOJUMI 12% ES PVN Nemaksâtâjs
!R:PVNS[18] PVN_TIPS=3,4 KOKI(PÇRKAM)
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  DATUMS=TODAY()
  MENESS=MENVAR(MEN_NR,1,3)
  IF BILANCE   !LIELÂKÂ SUMMA NO IZZFILTPVN
     StringLimitSumma='no '&CLIP(MINMAXSUMMA)&' lîdz '&clip(bilance)&' (neieskaitot)'
  ELSE
     StringLimitSumma='Ls '&CLIP(MINMAXSUMMA)&' un vairâk'
  .
!  NOT0='Pielikums'
!  NOT1='Ministru kabineta'
!  NOT2='2009.gada 22.decembra noteikumiem Nr.1640'
!  NOT3=''

  IF F:IDP THEN PRECIZETA='Precizçtâ'.
!  IF F:XML
!     E='E'
!     EE1='(PVN_PI.XML)'
!     EE2='(PVN_PII.XML)'
!     EE3='(PVN_PIII.XML)'
!  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GG::Used = 0
    CHECKOPEN(GG,1)
  .
  GG::Used += 1
  IF PAR_K::Used = 0
    CHECKOPEN(PAR_K,1)
  .
  PAR_K::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  .
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('kkk',kkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN pielikumi'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K100000'  !GGK,RS,DATUMI,D/K,PVNTi&PVN%,OBJ,NOD
!           1234567
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      .
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        .
      .
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      .
        XMLFILENAME=USERFOLDER&'\PVN_D.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           F:XML_OK#=TRUE
        .

    OF Event:Timer

!************************ BÛVÇJAM R_TABLE ********
      LOOP RecordsPerCycle TIMES
         nk#+=1

         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
         DRINDA# = ''
         !STOP('==='&GGK:BKK&'==='&R:PAR_NR&' '&GGK:SUMMA)
         IF CYCLEBKK(GGK:BKK,KKK) AND GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))  !NAV PVN KONTS!IR DEFIN?TI NEAPL. DAR?JUMI
            !STOP('***'&KKK1&'==='&GGK:BKK&R:PAR_NR&'R='&R:RINDA&' '&GGK:SUMMA&' '&GGK:D_K)
            irRinda43# = 0
            LOOP R#=1 TO 2
               IF KON:PVND[R#] = 44 OR KON:PVND[R#] = 411 OR KON:PVND[R#] = 482 OR KON:PVND[R#] = 43
                  DRINDA# = '4*'
                  IF KON:PVND[R#] = 43
                     irRinda43# = 1
                  .
               .
            .
            IF R:RINDA = '' AND irRinda43# = 1
               DRINDA# = '4*'
            .
            IF DRINDA# = ''
               GOTO NEXTROW
               !neiet pvn1.3
            .
            ! 10.12.2012 avansa ieskaitisana vai nakamo perioda ienemumu slegsana
            IF DRINDA# = '4*' AND (~GGK:BKK[1:2]='57') AND GGK:BKK[1]='5' AND GGK:D_K='D'
                GOTO NEXTROW
               !neiet pvn1.3
            .
         .

         IF ~CYCLEBKK(GGK:BKK,KKK)  OR (~DRINDA# = '')       ! *****************************************IR PVN KONTS
            IF INSTRING(GGK:PVN_TIPS,' 024NIPAZER') OR (~DRINDA# = '') OR (INSTRING(GGK:PVN_TIPS,'38KMB') AND GGK:D_K='D') !no reversa nem tikai Debets
               R:U_NR=GGK:U_NR
               R:D_K=GGK:D_K                
               GGK_SUMMAV=GGK:SUMMAV
               GGK_SUMMA=GGK:SUMMA
               R:RINDA=''
               IF (GGK:D_K='K' AND (GGK:PVN_TIPS='A' OR GGK:PVN_TIPS='4'))   ! K+PVN_TIPS=A MÇS ATGRIEÞAM PRECI R57
                  R:D_K='D'
                  IF GGK_SUMMAV>0
                     GGK_SUMMAV=-GGK_SUMMAV
                     GGK_SUMMA=-GGK_SUMMA
                  .
               ELSIF (GGK:D_K='D' AND GGK:PVN_TIPS='A') ! D+PVN_TIPS=A MUMS ATGRIEÞ PRECI R67
                  R:D_K='D'
               ELSE
                  R:D_K=GGK:D_K
               .
               IF R:D_K='D'
                  R:SADALA=1
               ELSE
                  R:SADALA=3
               .
               !Elya 18.08.2013 <
               IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                  R:RINDA = ''
                  irRinda43# = 0
                  LOOP R#=1 TO 2
                    IF KON:PVND[R#] = 44
                       R:RINDA='44'      ! SEZ
                    ELSIF KON:PVND[R#] = 411
                       R:RINDA='41.1'
                       IF ~INSTRING(GGK:PVN_TIPS,'38KMB')
                          R:PVN_TIPS = 'K'
                       ELSE
                          R:PVN_TIPS = GGK:PVN_TIPS
                       .
                    ELSIF KON:PVND[R#] = 482
                       R:RINDA='48.2'
                    ELSIF KON:PVND[R#] = 43
                       irRinda43# = 1
                    .
                  .
                  IF R:RINDA = '' AND irRinda43# = 1
                     R:RINDA='43'
                  .
               ELSE
                  R:RINDA = ''
                  IF GGK:PVN_TIPS='I'
                     R:RINDA = ''
                  ELSE
                     CASE GGK:PVN_PROC
                     OF 10
                        R:RINDA='42'
                     OF 12
                        R:RINDA='42'
                     OF 21
                        R:RINDA='41'
                     OF 22
                        IF INSTRING(GGK:PVN_TIPS,'KMB')
                        ELSE
                           R:RINDA='41'
                        .
                     .
                  .
               .              
               R:KEY=CLIP(R:U_NR)&R:D_K&CLIP(R:RINDA)&CLIP(GGK:PVN_TIPS)
               GET(R_TABLE,R:KEY)
               IF ~ERROR()
                  IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                     R:SUMMA+=GGK:SUMMA !6-T?S GRUPAS SUMMA 
                  ELSE
                  CASE GGK:PVN_PROC
                  OF 5
                     IF GGK:PVN_TIPS='I'   !PVN_TIPS=I
                        R:PVNS[4,1]+=GGK_SUMMAV
                        R:PVNS[4,2]+=GGK_SUMMA
                     ELSE
                        R:PVNS[2,1]+=GGK_SUMMAV
                        R:PVNS[2,2]+=GGK_SUMMA
                     .
                  OF 10
                     IF GGK:PVN_TIPS='I'  !IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[12,1]+=GGK_SUMMAV
                           R:PVNS[12,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[16,1]+=GGK_SUMMAV
                           R:PVNS[16,2]+=GGK_SUMMA
                        .
                     ELSE
                        R:RINDA='42'
                        R:PVNS[7,1]+=GGK_SUMMAV
                        R:PVNS[7,2]+=GGK_SUMMA
                     .
                  OF 12
                     IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[13,1]+=GGK_SUMMAV
                           R:PVNS[13,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[17,1]+=GGK_SUMMAV
                           R:PVNS[17,2]+=GGK_SUMMA
                        .
                     ELSE
                       R:RINDA='42'
                       R:PVNS[9,1]+=GGK_SUMMAV
                       R:PVNS[9,2]+=GGK_SUMMA
                     .
                  OF 14
                     R:PVNS[5,1]+=GGK_SUMMAV !VAR BÛT TIKAI Ls&LR
                     R:PVNS[5,2]+=GGK_SUMMA  !VAR BÛT TIKAI Ls&LR
                  OF 18
                     IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                       R:PVNS[3,1]+=GGK_SUMMAV
                       R:PVNS[3,2]+=GGK_SUMMA
                     ELSE
                       R:PVNS[1,1]+=GGK_SUMMAV
                       R:PVNS[1,2]+=GGK_SUMMA
                     .
                  OF 21
                     IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[10,1]+=GGK_SUMMAV
                           R:PVNS[10,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[14,1]+=GGK_SUMMAV
                           R:PVNS[14,2]+=GGK_SUMMA
                        .
                     ELSE
                       R:RINDA='41'
                       R:PVNS[6,1]+=GGK_SUMMAV
                       R:PVNS[6,2]+=GGK_SUMMA
                     .
                  OF 22
                     IF GGK:PVN_TIPS='I'  !SAÒEMTI IMPORTA PAKALPOJUMI
                        IF R:PAR_PVN
                           R:PVNS[11,1]+=GGK_SUMMAV
                           R:PVNS[11,2]+=GGK_SUMMA
                        ELSE
                           R:PVNS[15,1]+=GGK_SUMMAV
                           R:PVNS[15,2]+=GGK_SUMMA
                        .                     
                     ELSIF GGK:PVN_TIPS='K'
                        R:PVNS[18,1]+=GGK_SUMMAV
                        R:PVNS[18,2]+=GGK_SUMMA
                     ELSIF GGK:PVN_TIPS='M'
                        R:PVNS[19,1]+=GGK_SUMMAV
                        R:PVNS[19,2]+=GGK_SUMMA
                     ELSIF GGK:PVN_TIPS='B'
                        R:PVNS[20,1]+=GGK_SUMMAV
                        R:PVNS[20,2]+=GGK_SUMMA
                     ELSE
                       R:RINDA='41'
                       R:PVNS[8,1]+=GGK_SUMMAV
                       R:PVNS[8,2]+=GGK_SUMMA
                     .
                  ELSE
                     KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                     DO ProcedureReturn
                  .
                  .
                  PUT(R_TABLE)
               ELSE !R:KEY NAV ATRASTS
               !Elya 18.08.2013 >

                  R:NOS_P=GETPAR_K(GGK:PAR_NR,0,1)
                  R:PAR_TIPS=GETPAR_K(GGK:PAR_NR,0,20) !LAI ZINÂTU, KA ES,RU
                  R:PAR_PVN= GETPAR_K(GGK:PAR_NR,0,13) !PVN RNr
                  R:VAL=GGK:VAL
                  R:PVN_TIPS=GGK:PVN_TIPS !VAJADZÎGS ATGRIEZTAI PRECEI UN ES PAKALPOJUMIEM UN KOKIEM
                  R:SUMMA=0
                  CLEAR(R:PVNS)
                  IF (~ DRINDA# = '') AND (~GGK:PVN_TIPS='I') !IR DEFIN?TI NEAPL. DAR?JUMI
                           R:SUMMA=GGK:SUMMA !6-T?S GRUPAS SUMMA
                           R:RINDA = ''
                           irRinda43# = 0
                           LOOP R#=1 TO 2
                             IF KON:PVND[R#] = 44
                                R:RINDA='44'      ! SEZ
                             ELSIF KON:PVND[R#] = 411
                                R:RINDA='41.1'
                                IF ~INSTRING(GGK:PVN_TIPS,'38KMB')
                                   R:PVN_TIPS = 'K'
                                ELSE
                                   R:PVN_TIPS = GGK:PVN_TIPS
                                .
                             ELSIF KON:PVND[R#] = 482
                                R:RINDA='48.2'
                             ELSIF KON:PVND[R#] = 43
                                irRinda43# = 1
                             .
                           .
                           IF R:RINDA = '' AND irRinda43# = 1
                              R:RINDA='43'
                           .
   !                        IF INSTRING(R:PVN_TIPS,'38KMB')
   !                          R:PVNS[18,1]=GGK_SUMMAV
   !                          R:PVNS[18,2]=GGK_SUMMA
   !                        ELSIF R:PVN_TIPS='M'
   !                          R:PVNS[19,1]=GGK_SUMMAV
   !                          R:PVNS[19,2]=GGK_SUMMA
   !                        ELSIF R:PVN_TIPS='B'
   !                          R:PVNS[20,1]=GGK_SUMMAV
   !                          R:PVNS[20,2]=GGK_SUMMA
   !                        .
                  ELSE
                     CASE GGK:PVN_PROC
                     OF 5
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                          R:PVNS[4,1]=GGK_SUMMAV
                          R:PVNS[4,2]=GGK_SUMMA
                        ELSE
                          R:PVNS[2,1]=GGK_SUMMAV
                          R:PVNS[2,2]=GGK_SUMMA
                        .
                     OF 10
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                          IF R:PAR_PVN
                             R:PVNS[12,1]=GGK_SUMMAV
                             R:PVNS[12,2]=GGK_SUMMA
                          ELSE
                             R:PVNS[16,1]=GGK_SUMMAV
                             R:PVNS[16,2]=GGK_SUMMA
                          .
                        ELSE
                          R:RINDA='42'
                          R:PVNS[7,1]=GGK_SUMMAV
                          R:PVNS[7,2]=GGK_SUMMA
                        .
                     OF 12
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI
                          IF R:PAR_PVN
                             R:PVNS[13,1]=GGK_SUMMAV
                             R:PVNS[13,2]=GGK_SUMMA
                          ELSE
                             R:PVNS[17,1]=GGK_SUMMAV
                             R:PVNS[17,2]=GGK_SUMMA
                          .
                        ELSE
                          R:RINDA='42'
                          R:PVNS[9,1]=GGK_SUMMAV
                          R:PVNS[9,2]=GGK_SUMMA
                        .
                     OF 14
                        R:PVNS[5,1]=GGK_SUMMAV   !VAR BÛT TIKAI Ls&LR
                        R:PVNS[5,2]=GGK_SUMMA    !VAR BÛT TIKAI Ls&LR

                     OF 18
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                          R:PVNS[3,1]=GGK_SUMMAV
                          R:PVNS[3,2]=GGK_SUMMA
                        ELSE
                          R:PVNS[1,1]=GGK_SUMMAV
                          R:PVNS[1,2]=GGK_SUMMA
                        .
                     OF 21
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                          IF R:PAR_PVN
                             R:PVNS[10,1]=GGK_SUMMAV
                             R:PVNS[10,2]=GGK_SUMMA
                          ELSE
                             R:PVNS[14,1]=GGK_SUMMAV
                             R:PVNS[14,2]=GGK_SUMMA
                          .
                        ELSE
                          R:RINDA='41'
                          R:PVNS[6,1]=GGK_SUMMAV
                          R:PVNS[6,2]=GGK_SUMMA
                        .
                     OF 22
                        IF GGK:PVN_TIPS='I'     !PVN_TIPS=I IMPORTA PAKALPOJUMI ES & ~ES
                          IF R:PAR_PVN
                             R:PVNS[11,1]=GGK_SUMMAV
                             R:PVNS[11,2]=GGK_SUMMA
                          ELSE
                             R:PVNS[15,1]=GGK_SUMMAV
                             R:PVNS[15,2]=GGK_SUMMA
                          .

                        ELSIF GGK:PVN_TIPS='K'
                          R:PVNS[18,1]=GGK_SUMMAV
                          R:PVNS[18,2]=GGK_SUMMA
                        ELSIF GGK:PVN_TIPS='M'
                          R:PVNS[19,1]=GGK_SUMMAV
                          R:PVNS[19,2]=GGK_SUMMA
                        ELSIF GGK:PVN_TIPS='B'
                          R:PVNS[20,1]=GGK_SUMMAV
                          R:PVNS[20,2]=GGK_SUMMA

                        ELSE
                          R:RINDA='41'
                          R:PVNS[8,1]=GGK_SUMMAV
                          R:PVNS[8,2]=GGK_SUMMA
                        .
                     ELSE
                        KLUDA(27,'PVN %='&GGK:PVN_PROC&' '&FORMAT(GGK:DATUMS,@D06.)&' UNR='&GGK:U_NR)
                        DO ProcedureReturn
                     .
                  .  !14.06.2012
                  R:DATUMS=GGK:DATUMS         !Ls pârrçíins  ?
                  R:PAR_NR=GGK:PAR_NR
                  !STOP('==='&GGK:BKK&R:PAR_NR&'R='&R:RINDA&' '&R:SUMMA)

                  ADD(R_TABLE)
                  SORT(R_TABLE,R:U_NR)
   !14.06.2012               .
               .!Elya 18.08.2013
            .
         .!BEIDZAS PVN KONTS

NEXTROW LOOP
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
      END !BEIDZAS LOOP RPCT
      IF LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
      END
    END !BEIDZAS CASE EVENT
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END

  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************* I.Priekðnodoklis par iekðzemç &ES iegâdâtajâm precçm un saòemtajiem pakalpojumiem ********
!*************** un mums atgrieztâ prece,pakalpojumi (kredîtrçíins) un zaudçts parâds *******************
!Elya ~begin
    SORT(R_TABLE,R:PAR_NR,R:U_NR)
    GET(R_TABLE,0)

    U_NR_C# = R:U_NR
    IR# = 0
    LINE# = 0
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') OR (R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !NAV ES vai ES Pakalpojumu PVNnemaksâtâjs
          IF R:D_K='D'  AND R:SADALA=1             !IEGÂDE,arî imports vai ATGRIEZTA REALIZÂCIJA,VAI MÇS ATGRIEÞAM(-),vai ZAUDÇTS PARÂDS
!       STOP(''&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
          IF ~U_NR_C#=R:U_NR AND LINE# = 1
!               STOP(CPR:U_NR&' '&CPR:DOKSUMMA)
               ADD(CPR_TABLE)
               LINE# = 0
               CPR:DOKSUMMA = 0
          .
          IF ~INSTRING(R:PVN_TIPS,'K38MBZ')
             CPR:DOKSUMMA+= R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[5,2]/0.14+|
             R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12+R:PVNS[14,2]/0.21+R:PVNS[15,2]/0.22+|
             R:PVNS[16,2]/0.1+R:PVNS[17,2]/0.12+R:PVNS[18,2]/0.22+R:PVNS[19,2]/0.22+R:PVNS[20,2]/0.22
          .
          CPR:U_NR = R:U_NR
          CPR:PAR_NR = R:PAR_NR
          U_NR_C#=R:U_NR
          IR# = 1
          LINE# = 1
          .
       .
    .
    IF LINE#=1 AND IR# = 1
       ADD(CPR_TABLE)
       SORT(CPR_TABLE,CPR:U_NR)
    .
    SORT(CPR_TABLE,CPR:PAR_NR,CPR:U_NR)
    GET(CPR_TABLE,0)
    PAR_NR_K# = CPR:PAR_NR
    IRK# = 0
    LINEK# = 0
    LOOP I#= 1 TO RECORDS(CPR_TABLE)
       GET(CPR_TABLE,I#)
          IF ~PAR_NR_K#=CPR:PAR_NR AND LINEK# = 1
 !              STOP(KKPR:PAR_NR&' '&KKPR:DOKSUMMA)
               ADD(KKPR_TABLE)
               LINEK# = 0
               KKPR:DOKSUMMA = 0
          .
          IF  (INRANGE(ABS(CPR:DOKSUMMA),0,MINMAXSUMMA-0.01))
            KKPR:DOKSUMMA+= CPR:DOKSUMMA
          .
          KKPR:PAR_NR = CPR:PAR_NR
          PAR_NR_K# = CPR:PAR_NR
          IRK# = 1
          LINEK# = 1
    .
    IF LINEK#=1 AND IRK# = 1
       ADD(KKPR_TABLE)
       SORT(KKPR_TABLE,KKPR:PAR_NR)
    .
    SORT(R_TABLE,R:U_NR)
    IF INRANGE(B_DAT-S_DAT,0,31) THEN PER = 0 !menesis
    ELSIF INRANGE(B_DAT-S_DAT,32,100) THEN PER = 1 !ceturksnis
    ELSIF INRANGE(B_DAT-S_DAT,180,200) THEN PER = 2 !pusgads
    ELSE PER = 3 !gads
    .
!Elya ~end
!Elya    SORT(R_TABLE,R:NOS_P)
    IF F:XML_OK#=TRUE
       XML:LINE=' PVN1I>'
       ADD(OUTFILEXML)
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
!       IF ~(R:PAR_TIPS='C') OR R:PVNS[3,2] OR R:PVNS[4,2]   ! +IMPORTA PAKALPOJUMI LATVIJÂ 23.03.2009
       IF ~(R:PAR_TIPS='C') OR (R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !NAV ES vai ES Pakalpojumu PVNnemaksâtâjs
          IF R:D_K='D'              !IEGÂDE,arî imports vai ATGRIEZTA REALIZÂCIJA,VAI MÇS ATGRIEÞAM(-),vai ZAUDÇTS PARÂDS
             PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
!             PAR_PVN   = GETPAR_K(R:PAR_NR,0,13)
             CASE R:PAR_TIPS
             OF 'N'
                DV='I' !IMPORTS NO ~ES
             ELSE
                DV='A' !LATVIJA,ES
             .
             IF ~R:PAR_PVN THEN DV='N'.     !NAV PVN REÌISTRÂCIJAS Nr
             IF R:PVN_TIPS='Z' THEN DV='Z'. !ZAUDÇTS PARÂDS
!             IF INSTRING(R:PVN_TIPS,'3456') THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = 'K' THEN DV='R1'. !KOKI     tikai reversam, ja bez reversa jabut A - 22%
             IF R:PVN_TIPS = '3' THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = '8' THEN DV='R1'. !KOKI
             IF R:PVN_TIPS = 'M' THEN DV='R2'. !METALUZNI
             IF R:PVN_TIPS = 'B' THEN DV='R3'. !BUVNIECIBA
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
             GG_DOKDAT = GG:DOKDAT
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+R:PVNS[8,2]+|
             R:PVNS[9,2]+R:PVNS[14,2]+R:PVNS[15,2]+R:PVNS[16,2]+R:PVNS[17,2]+R:PVNS[18,2]+R:PVNS[19,2]+R:PVNS[20,2] !18+5+14+21+10+22+12+N21+N10+N22+N12%   Ls
             DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[5,2]/0.14+|
             R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12+R:PVNS[14,2]/0.21+R:PVNS[15,2]/0.22+|
             R:PVNS[16,2]/0.1+R:PVNS[17,2]/0.12+R:PVNS[18,2]/0.22+R:PVNS[19,2]/0.22+R:PVNS[20,2]/0.22
             IF R:SUMMA
                DOK_SUMMA=R:SUMMA
             .
             PVN_SUMMA_K+= PVN_SUMMA
             IF R:PAR_TIPS='C' THEN R63+=PVN_SUMMA.
             GG_DOK_NR=GG:DOK_SENR
             KLUDA#=FALSE

             CASE GG:ATT_DOK
             OF '1'
                ATTDOK='1-nodokïa rçíins'
             OF '2'
                ATTDOK='2-kases èeks vai kvîts'
             OF '3'
                ATTDOK='3-bezskaidras naudas MD'
             OF '4'
                ATTDOK='4-kredîtrçíins'
             OF '5'
                ATTDOK='5-cits'
             OF '6'
                ATTDOK='6-muitas deklarâcija'
             OF 'X'
                ATTDOK='X-atseviðíi neuzrâdâmie darîjumi'
             ELSE
!                                 STOP('##'&R:PAR_NR&'R='&R:RINDA&' '&R:SUMMA)
                KLUDA#=TRUE
             .

             DOK_SUMMA_K+=DOK_SUMMA

             CPR:U_NR = R:U_NR
             GET(CPR_TABLE,CPR:U_NR)
             IF ERRORCODE()
                SUMMA_PEC_DOK = 0
             ELSE
                SUMMA_PEC_DOK = CPR:DOKSUMMA
             .
             KKPR:PAR_NR = R:PAR_NR
             GET(KKPR_TABLE,KKPR:PAR_NR)
             IF ERRORCODE()
                SUMMA_PEC_KL = 0
             ELSE
                SUMMA_PEC_KL = KKPR:DOKSUMMA
             .
!             IF ((BILANCE AND ~INRANGE(ABS(SUMMA_PEC_DOK),MINMAXSUMMA,BILANCE-0.01)) OR|         !TÂ BILANCE (max sum) NO IZZFILTPVN
!                (~BILANCE AND INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01) AND ~(DV='Z'))) AND| !DAR.VEIDS=T
!                ~INSTRING(R:PVN_TIPS,'KMB')
             IF R:SADALA=1                                                               !KOKI
                IF (~INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) OR INSTRING(R:PVN_TIPS,'K38MBZ')
!ELYA
!                OPEN(DVWINDOW)
!                DISPLAY
!                ACCEPT
!                   CASE(FIELD())
!                   OF ?DV
!                      IF EVENT()=EVENT:ACCEPTED THEN BREAK.
!                   OF ?OKDV
!                      IF EVENT()=EVENT:ACCEPTED THEN BREAK.
!                   .
!                .
!                CLOSE(DVWINDOW)
                   NPK+=1
                   IF KLUDA#=TRUE
                      KLUDA(27,'attaisnojuma dok. kods: '&CLIP(GG:NOKA)&' '&FORMAT(GG:DATUMS,@D06.)&' UNR='&GG:U_NR)
                   .
                   IF F:XML_OK#=TRUE
                      XML:LINE=' R>'
                      ADD(OUTFILEXML)
!                      XML:LINE=' Npk>'&NPK&'</Npk>'
!                      ADD(OUTFILEXML)
                      IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                      XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                      ADD(OUTFILEXML)
                      IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z Idaïai
                      XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
                      ADD(OUTFILEXML)
                      TEX:DUF=PAR_NOS_P
                      DO CONVERT_TEX:DUF_
                      XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                      ADD(OUTFILEXML)
                      XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
                      ADD(OUTFILEXML)
                      XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                      ADD(OUTFILEXML)
                      XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                      ADD(OUTFILEXML)
                      XML:LINE=' DokVeids>'&GG:att_dok&'</DokVeids>'
                      ADD(OUTFILEXML)
                      XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                      ADD(OUTFILEXML)
                      XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'</DokDatums>'
                      ADD(OUTFILEXML)
                      XML:LINE=' /R>'
                      ADD(OUTFILEXML)
                   .
                ELSIF ((S_DAT >=DATE(3,1,2012) AND PER = 0) OR (S_DAT >=DATE(1,1,2012) AND ~PER = 0)) AND |
                   (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND (~INRANGE(ABS(SUMMA_PEC_KL),0,MINMAXSUMMA-0.01)) AND |
                   ~(DV='Z') AND ~INSTRING(R:PVN_TIPS,'KMB') AND UPPER(PERS_KODS[1:2]) = 'LV'
                   IR_KL# = 1
                   KPR:PAR_NR = R:PAR_NR
                   KPR:DV = DV
                   GET(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   IF ERROR()
                      KPR:SUMMA=DOK_SUMMA
                      KPR:PVN=PVN_SUMMA
                      ADD(KPR_TABLE)
!                     STOP(R:PAR_NR&'R='&R:RINDA&' '&K:SUMMA)
                      SORT(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   ELSE
                      KPR:SUMMA+=DOK_SUMMA
                      KPR:PVN+=PVN_SUMMA
!                     STOP(K:SUMMA)
                      PUT(KPR_TABLE)
                      SORT(KPR_TABLE,KPR:PAR_NR,KPR:DV)
                   .
                ELSE !(INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND ~INSTRING(R:PVN_TIPS,'KMB') !SADAÏA T
                   DOK_SUMMA_P+=DOK_SUMMA
                   PVN_SUMMA_P+=PVN_SUMMA
                .
             .
          .
       .
    .
    LOOP I#= 1 TO RECORDS(KPR_TABLE)
       GET(KPR_TABLE,I#)
       NPK+=1
       PAR_nos_p = GETPAR_K(KPR:PAR_NR,0,2)
       pers_kods = GETPAR_K(KPR:PAR_NR,0,8)
       PVN_SUMMA = KPR:PVN
       DOK_SUMMA = KPR:SUMMA
       ATTDOK=''
       GG_DOK_NR=''
       GG_DOKDAT=0
       DV = 'V'
       IF F:XML_OK#=TRUE
           XML:LINE=' R>'
           ADD(OUTFILEXML)
!           XML:LINE=' Npk>'&NPK&'</Npk>'
!           ADD(OUTFILEXML)
           IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
           XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
           ADD(OUTFILEXML)
           IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z Idaïai
           XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
           ADD(OUTFILEXML)
           TEX:DUF=PAR_NOS_P
           DO CONVERT_TEX:DUF_
           XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
           ADD(OUTFILEXML)
           XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
           ADD(OUTFILEXML)
           XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
           ADD(OUTFILEXML)
           XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
           ADD(OUTFILEXML)
           XML:LINE=' /R>'
           ADD(OUTFILEXML)
       .
    .
    NPK+=1

    IF F:XML_OK#=TRUE
       IF DOK_SUMMA_P   !EDS 0-es NEÒEM PRETÎ
          XML:LINE=' R>'
          ADD(OUTFILEXML)
!          XML:LINE=' Npk>'&NPK&'</Npk>'
!          ADD(OUTFILEXML)
          XML:LINE=' DarVeids>'&'T'&'</DarVeids>'    !T-DAR.ZEM 1000,-
          ADD(OUTFILEXML)
          XML:LINE=' VertibaBezPvn>'&DOK_SUMMA_P&'</VertibaBezPvn>'
          ADD(OUTFILEXML)
          XML:LINE=' PvnVertiba>'&PVN_SUMMA_P&'</PvnVertiba>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
       XML:LINE=' /PVN1I>'
       ADD(OUTFILEXML)
    .
!************************II.D.SAÒEMTÂS ES PRECES(SAMAKSÂTS PAR PRECI) UN PVN MAKSÂTÂJU PAKALPOJUMI********
    NPK=0
    IF F:XML_OK#=TRUE
       XML:LINE=' PVN1II>'
       ADD(OUTFILEXML)
    .
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF R:PAR_TIPS='C' AND ~(R:PAR_TIPS='C' AND ~R:PAR_PVN AND R:PVN_TIPS='I') !TIKAI ES PRECE UN PVN MAKS. PAKALPOJUMI
          IF R:D_K='D'
!             IF R:PVN_TIPS='A'
!                PAR_nos_p = '67:'&GETPAR_K(R:PAR_NR,0,2)
!                PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
!             ELSE
                PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
!             .
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
             IF R:PVN_TIPS='I'
                DV='P' !PAKALPOJUMI
                PVN_SUMMA = R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[10,2]+R:PVNS[11,2]+R:PVNS[12,2]+R:PVNS[13,2] !Ls
                DOK_SUMMAV=R:PVNS[3,1]/0.18+R:PVNS[4,1]/0.05+R:PVNS[10,1]/0.21+R:PVNS[11,1]/0.22+R:PVNS[12,1]/0.1+|
                R:PVNS[13,1]/0.12 !ES
                DOK_SUMMA =R:PVNS[3,2]/0.18+R:PVNS[4,2]/0.05+R:PVNS[10,2]/0.21+R:PVNS[11,2]/0.22+R:PVNS[12,2]/0.1+|
                R:PVNS[13,2]/0.12 !Ls
             ELSE
                DV='G' !PRECES
                PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[6,2]+R:PVNS[7,2]+R:PVNS[8,2]+R:PVNS[9,2] !Ls
                DOK_SUMMAV=R:PVNS[1,1]/0.18+R:PVNS[2,1]/0.05+R:PVNS[6,1]/0.21+R:PVNS[7,1]/0.1+R:PVNS[8,1]/0.22+|
                R:PVNS[9,1]/0.12 !ES
                DOK_SUMMA =R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+|
                R:PVNS[9,2]/0.12 !Ls
             .
             X#=GETGG(R:U_NR)  ! POZICIONÇJAM GG
             GG_DOKDAT = GG:DOKDAT
             PVN_SUMMA_K2+= PVN_SUMMA
             DOK_VAL=R:VAL
             GG_DOK_NR=GG:DOK_SENR
             DOK_SUMMA_K2+=DOK_SUMMA
             IF DOK_SUMMA
                NPK+=1
                IF F:XML_OK#=TRUE
                   XML:LINE=' R>'
                   ADD(OUTFILEXML)
!                   XML:LINE=' Npk>'&NPK&'</Npk>'
!                   ADD(OUTFILEXML)
                   IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                   XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                   ADD(OUTFILEXML)
                   IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z ???
                   XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'             !atïaujam 20
                   ADD(OUTFILEXML)
                   TEX:DUF=PAR_NOS_P
                   DO CONVERT_TEX:DUF_
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DarVeids>'&CLIP(DV)&'</DarVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValVertiba>'&DOK_SUMMAV&'</ValVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' ValKods>'&DOK_VAL&'</ValKods>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'</DokDatums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' /R>'
                   ADD(OUTFILEXML)
                .
             .
          .
       .
    .
    IF F:XML_OK#=TRUE
       XML:LINE=' /PVN1II>'
       ADD(OUTFILEXML)
    .
!************* III.Nodoklis par piegâdâtajâm precçm un sniegtajiem pakalpojumiem ********
!************* ja mçs atgrieþam preci- NEUZRÂDAM 20.07.2010 *****************************

!    SORT(R_TABLE,R:NOS_P)
    IF F:XML_OK#=TRUE
       XML:LINE=' PVN1III>'
       ADD(OUTFILEXML)
    .
    SORT(R_TABLE,R:PAR_NR,R:U_NR)
    GET(R_TABLE,0)

    U_NR_C# = R:U_NR
    PAR_NR_K# = R:PAR_NR
    IR# = 0
    LINE# = 0
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') AND R:SADALA=3
          IF R:D_K='K'| !07.03.2011 ARÎ KO MUMS ATGRIEÞ
          AND ~(R:PVN_TIPS='I')  !28.07.2010 PAKALPOJUMI NO RU-NERÂDAM
!       STOP(''&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
          IF ~U_NR_C#=R:U_NR AND LINE# = 1
!               STOP(C:U_NR&' '&C:DOKSUMMA)
               ADD(C_TABLE)
               LINE# = 0
               C:DOKSUMMA = 0
          .
          IF ~INSTRING(R:PVN_TIPS,'KMB')
             IF R:SUMMA
                C:DOKSUMMA+=R:SUMMA
             ELSE
                C:DOKSUMMA+=R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.14+|
                R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12
             .
          .
          C:U_NR = R:U_NR
          C:PAR_NR = R:PAR_NR
          U_NR_C#=R:U_NR
          IR# = 1
          LINE# = 1
          .
       .
    .
    IF LINE#=1 AND IR# = 1
       ADD(C_TABLE)
       SORT(C_TABLE,C:U_NR)
    .
    SORT(C_TABLE,C:PAR_NR,C:U_NR)
    GET(C_TABLE,0)
    PAR_NR_K# = C:PAR_NR
    IRK# = 0
    LINEK# = 0
    LOOP I#= 1 TO RECORDS(C_TABLE)
       GET(C_TABLE,I#)
          IF ~PAR_NR_K#=C:PAR_NR AND LINEK# = 1
!               STOP(KKPR:PAR_NR&' '&KKPR:DOKSUMMA)
               ADD(KK_TABLE)
               LINEK# = 0
               KK:DOKSUMMA = 0
          .
          IF (INRANGE(ABS(C:DOKSUMMA),0,MINMAXSUMMA-0.01))
            KK:DOKSUMMA+= C:DOKSUMMA
          .
          KK:PAR_NR = C:PAR_NR
          PAR_NR_K# = C:PAR_NR
          IRK# = 1
          LINEK# = 1
    .
    IF LINEK#=1 AND IRK# = 1
!       STOP('*'&KK:PAR_NR&' '&KK:DOKSUMMA)
       ADD(KK_TABLE)
       SORT(KK_TABLE,KK:PAR_NR)
    .
    SORT(R_TABLE,R:U_NR)

    NPK=0
    IR_KL# = 0
    GET(R_TABLE,0)
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       IF ~(R:PAR_TIPS='C') AND R:SADALA=3
          IF R:D_K='K'| !07.03.2011 ARÎ KO MUMS ATGRIEÞ
          AND ~(R:PVN_TIPS='I')  !28.07.2010 PAKALPOJUMI NO RU-NERÂDAM
!             STOP(R:PAR_NR&'R='&R:RINDA)
!           STOP('***'&I#&' R:PAR_TIPS '&R:PAR_TIPS&' R:D_K '&R:D_K&' par '&R:PAR_NR&'R='&R:RINDA)
             PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
             pers_kods = GETPAR_K(R:PAR_NR,0,8)
             X#=GETGG(R:U_NR)  !POZICIONÇJAM GG
!             GG_DOKDAT = GG:DOKDAT
             GG_DOKDAT = GG:DATUMS
             PVN_SUMMA = R:PVNS[1,2]+R:PVNS[2,2]+R:PVNS[3,2]+R:PVNS[4,2]+R:PVNS[5,2]+R:PVNS[6,2]+R:PVNS[7,2]+|
             R:PVNS[8,2]+R:PVNS[9,2] !18+5+14+21+10+22+12%   Ls
             IF R:SUMMA
                DOK_SUMMA=R:SUMMA
                !PVN_SUMMA = 0
             ELSE
                DOK_SUMMA = R:PVNS[1,2]/0.18+R:PVNS[2,2]/0.05+R:PVNS[3,2]/0.21+R:PVNS[4,2]/0.1+R:PVNS[5,2]/0.14+|
                R:PVNS[6,2]/0.21+R:PVNS[7,2]/0.1+R:PVNS[8,2]/0.22+R:PVNS[9,2]/0.12
             .
             GG_DOK_NR=GG:DOK_SENR
             RINDA3 = R:RINDA
             KLUDA#=FALSE

             CASE GG:ATT_DOK
             OF '1'
                ATTDOK='1-nodokïa rçíins'
             OF '2'
                ATTDOK='2-kases èeks vai kvîts'
             OF '3'
                ATTDOK='3-bezskaidras naudas MD'
!             OF '4'
!                ATTDOK='4-kredîtrçíins'
             OF '5'
                ATTDOK='5-cits'
!             OF '6'
!                ATTDOK='6-muitas deklarâcija'
             OF 'X'
                ATTDOK='X-atseviðíi neuzrâdâmie darîjumi'
             ELSE
                KLUDA#=TRUE
             .
!             IF DOK_SUMMA < 0
!             IF R:PVN_TIPS='A'          !20.07.2010
!                R:RINDA=57              !JÂSKATÂS
!             .
             DOK_SUMMA_K3+=DOK_SUMMA
             PVN_SUMMA_K3+=PVN_SUMMA
             C:U_NR = R:U_NR
             GET(C_TABLE,C:U_NR)
             IF ERRORCODE()
                SUMMA_PEC_DOK = 0
             ELSE
                SUMMA_PEC_DOK = C:DOKSUMMA
             .
             KK:PAR_NR = R:PAR_NR
             GET(KK_TABLE,KK:PAR_NR)
             IF ERRORCODE()
                SUMMA_PEC_KL = 0
             ELSE
                SUMMA_PEC_KL = KK:DOKSUMMA
             .

!             IF (BILANCE AND ~INRANGE(DOK_SUMMA,MINMAXSUMMA,BILANCE-0.01)) OR|
!                (~BILANCE AND ABS(DOK_SUMMA) < MINMAXSUMMA)
!             IF (BILANCE AND ~INRANGE(ABS(DOK_SUMMA),MINMAXSUMMA,BILANCE-0.01)) OR|     !TÂ BILANCE NO IZZFILTPVN
!                (~BILANCE AND INRANGE(ABS(DOK_SUMMA),0,MINMAXSUMMA-0.01)) AND PVN_SUMMA !SADAÏA T
             IF GG:ATT_DOK='X'
                DOK_SUMMA_X+=DOK_SUMMA
                PVN_SUMMA_X+=PVN_SUMMA
             ELSIF (~INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) OR INSTRING(R:PVN_TIPS,'KMB')
                NPK+=1
                IF KLUDA#=TRUE
!                STOP('5')
                   KLUDA(27,'attaisnojuma dok. kods: '&CLIP(GG:NOKA)&' '&FORMAT(GG:DATUMS,@D06.)&' UNR='&GG:U_NR)
                .
                IF F:XML_OK#=TRUE
                   XML:LINE=' R>'
                   ADD(OUTFILEXML)
!                   XML:LINE=' Npk>'&NPK&'</Npk>'
!                   ADD(OUTFILEXML)
                   IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
                   XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
                   ADD(OUTFILEXML)
                   IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z ???
                   XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
                   ADD(OUTFILEXML)
                   TEX:DUF=PAR_NOS_P
                   DO CONVERT_TEX:DUF_
                   XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DarVeids>'&CLIP(R:RINDA)&'</DarVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
                   ADD(OUTFILEXML)
                   XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokVeids>'&GG:att_dok&'</DokVeids>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokNumurs>'&clip(GG_DOK_NR)&'</DokNumurs>'
                   ADD(OUTFILEXML)
                   XML:LINE=' DokDatums>'&FORMAT(GG_DOKDAT,@D010-)&'</DokDatums>'
                   ADD(OUTFILEXML)
                   XML:LINE=' /R>'
                   ADD(OUTFILEXML)
                .

             ELSIF ((S_DAT >=DATE(3,1,2012) AND PER = 0) OR (S_DAT >=DATE(1,1,2012) AND ~PER = 0)) AND |
                (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND (~INRANGE(ABS(SUMMA_PEC_KL),0,MINMAXSUMMA-0.01)) AND  |
                ~INSTRING(R:PVN_TIPS,'KMB') AND UPPER(PERS_KODS[1:2]) = 'LV' !SADAÏA V
!                   STOP('WWWWW'&R:PAR_NR&'R='&R:RINDA&' '&DOK_SUMMA&' '&SUMMA_PEC_DOK)
                IR_KL# = 1
                K:PAR_NR = R:PAR_NR
                GET(K_TABLE,K:PAR_NR)
                IF ERROR()
                    K:SUMMA=DOK_SUMMA
                    K:PVN=PVN_SUMMA
                    ADD(K_TABLE)
!                   STOP(R:PAR_NR&'R='&R:RINDA&' '&K:SUMMA)
                    SORT(K_TABLE,K:PAR_NR)
                ELSE
                    K:SUMMA+=DOK_SUMMA
                    K:PVN+=PVN_SUMMA
!                    STOP(K:SUMMA)
                    PUT(K_TABLE)
                    SORT(K_TABLE,K:PAR_NR)
                .
             ELSE !IF (INRANGE(ABS(SUMMA_PEC_DOK),0,MINMAXSUMMA-0.01)) AND ~INSTRING(R:PVN_TIPS,'KMB') !SADAÏA T
                 DOK_SUMMA_P3+=DOK_SUMMA
                 PVN_SUMMA_P3+=PVN_SUMMA
             .
          .
       .
    .
    IF DOK_SUMMA_X
       NPK+=1
       PAR_nos_p=''
       PERS_KODS=''
       dok_summa=dok_summa_X
       PVN_SUMMA=PVN_SUMMA_X
       ATTDOK='X-atseviðíi neuzrâdâmie'
       GG_DOK_NR=''
       GG_DOKDAT=0
       RINDA3 = ''
       IF F:XML_OK#=TRUE
           XML:LINE=' R>'
           ADD(OUTFILEXML)
    !       XML:LINE=' Npk>'&NPK&'</Npk>'
    !       ADD(OUTFILEXML)
           XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
           ADD(OUTFILEXML)
           XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
           ADD(OUTFILEXML)
           XML:LINE=' DokVeids>'&'X'&'</DokVeids>'
           ADD(OUTFILEXML)
           XML:LINE=' /R>'
           ADD(OUTFILEXML)
       .
    .
!    STOP (F:XML_OK#)
    LOOP I#= 1 TO RECORDS(K_TABLE)
       GET(K_TABLE,I#)
       IF K:SUMMA
           NPK+=1
           PAR_nos_p = GETPAR_K(K:PAR_NR,0,2)
           pers_kods = GETPAR_K(K:PAR_NR,0,8)
           PVN_SUMMA = K:PVN
           DOK_SUMMA = K:SUMMA
           ATTDOK='V'
           GG_DOK_NR=''
           GG_DOKDAT=0
           RINDA3 = ''
           IF F:XML_OK#=TRUE
              XML:LINE=' R>'
              ADD(OUTFILEXML)
!              XML:LINE=' Npk>'&NPK&'</Npk>'
!              ADD(OUTFILEXML)
              IF ~PERS_KODS[1:2] THEN KLUDA(87,CLIP(PAR_NOS_P)&' Valsts kods').
              XML:LINE=' DpValsts>'&PERS_KODS[1:2]&'</DpValsts>'
              ADD(OUTFILEXML)
              IF ~CLIP(PERS_KODS[3:22]) THEN KLUDA(87,CLIP(PAR_NOS_P)&' NMR kods'). !dati:max=11z ???
              XML:LINE=' DpNumurs>'&CLIP(PERS_KODS[3:22])&'</DpNumurs>'
              ADD(OUTFILEXML)
              TEX:DUF=PAR_NOS_P
              DO CONVERT_TEX:DUF_
              XML:LINE=' DpNosaukums>'&CLIP(TEX:DUF)&'</DpNosaukums>'
              ADD(OUTFILEXML)
              XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
              ADD(OUTFILEXML)
              XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
              ADD(OUTFILEXML)
              XML:LINE=' DokVeids>'&'V'&'</DokVeids>'
              ADD(OUTFILEXML)
              XML:LINE=' /R>'
              ADD(OUTFILEXML)
           .
       .
    .
    NPK+=1
    PAR_nos_p=''
    PERS_KODS=''
    dok_summa=dok_summa_p3
    PVN_SUMMA=PVN_SUMMA_P3
    ATTDOK='T-darîjumi zem Ls 1000,-'
    GG_DOK_NR=''
    GG_DOKDAT=0
    RINDA3 = ''
    IF F:XML_OK#=TRUE
       IF DOK_SUMMA
          XML:LINE=' R>'
          ADD(OUTFILEXML)
!          XML:LINE=' Npk>'&NPK&'</Npk>'
!          ADD(OUTFILEXML)
          XML:LINE=' VertibaBezPvn>'&DOK_SUMMA&'</VertibaBezPvn>'
          ADD(OUTFILEXML)
          XML:LINE=' PvnVertiba>'&PVN_SUMMA&'</PvnVertiba>'
          ADD(OUTFILEXML)
          XML:LINE=' DokVeids>'&'T'&'</DokVeids>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
       XML:LINE=' /PVN1III>'
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
    .
  .
!***********************************************************************************************
  CLOSE(ProgressWindow)
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
  FREE(R_TABLE)
  IF FilesOpened
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
!  IF F:DBF='E' THEN F:DBF='W'.
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
CONVERT_TEX:DUF_  ROUTINE
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

