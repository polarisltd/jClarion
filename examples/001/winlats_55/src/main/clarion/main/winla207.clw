                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_SarakstsK          PROCEDURE                    ! Declare Procedure
MB                   BYTE
PB                   BYTE
BAN_NOS_P            STRING(31)
!----------------------------------------------------------------------
!DBFNAME        STRING(50),STATIC
!DBFFILE           FILE,PRE(DBF),DRIVER('dBase3'),CREATE,NAME(DBFNAME)
!RECORD              RECORD
!P_KOD                 STRING(12)
!F_NAMES               STRING(20)
!SURNAME               STRING(20)
!AMOUNT                STRING(@N_12.2)
!S_CTRL                STRING(12)
!                  . .
!DBFUNIB           FILE,PRE(DBU),DRIVER('dbase3'),CREATE,NAME(DBFNAME)
!RECORD              RECORD
!DOK_DAT               STRING(8)
!ID                    STRING(5)
!DBA                   STRING(21)
!DBSUB                 STRING(15)
!DBSUBNAM              STRING(65)
!AMTC                  STRING(16)
!CURR                  STRING(3)
!MFO                   STRING(11)
!CRA                   STRING(21)
!CRNAME                STRING(65)
!CRLUR                 STRING(16)
!CRSUB                 STRING(16)
!CRSUBNAM              STRING(65)
!CRSUBLUR              STRING(16)
!TARGET                STRING(140)
!                  . .
!PAREX             FILE,PRE(PAX),DRIVER('dBase3'),CREATE,NAME(DBFNAME)
!RECORD              RECORD
!BATCH_NR              STRING(@N2)
!TRAN_DATE             DATE
!SLIP_NR               STRING(7)
!CARD_ACCT             STRING(21)
!TRAN_TYPE             STRING(2)
!AMOUNT                STRING(@N_12.2)
!AUTH_CODE             STRING(6)
!CURRENCY              STRING(3)
!REC_DATE              DATE
!CARD                  STRING(21)
!BRANCH                STRING(5)
!OPERATOR              STRING(10)
!REF_NR                STRING(12)
!CONTROL               STRING(1)
!ERR_CODE              STRING(2)
!                 . .
!HANSAMASS        STRING(50),STATIC
!MASPERS          FILE,PRE(P),DRIVER('ASCII'),NAME(HANSAMASS),CREATE   !HANSA
!RECORD             RECORD
!LINE                 string(94)   !90+4
!                 . .
!P:VARDS                string(30) !HANSAS MAX GARUMI; ATDALÎTÂJS TAB(CHR(9))
!P:PERSKODS             string(12)
!P:summa                string(15)
!P:SAN_konts            STRING(21)
!P:SWIFT                string(12)


!HIPOMASS         STRING(50),STATIC
!MASPERSH         FILE,PRE(H),DRIVER('ASCII'),NAME(HIPOMASS),CREATE      !HIPOTÇKU
!RECORD             RECORD
!LINE                 string(200)
!                 . .

XMPFILENAME          CSTRING(200),STATIC
OUTFILEXMP       FILE,DRIVER('ASCII'),NAME(XMPFILENAME),PRE(XMP),CREATE,BINDABLE,THREAD
Record             RECORD,PRE()
LINE                 STRING(170) !MAX IESPÇJAMAIS RINDAS GARUMS=140+2*10+1
                 . .

!----------------------------------------------------------------------
nrsektori            USHORT     ! Izdrukâtais cilv. skaits. tek. sektorâ.
vajag_head           BYTE
KOPA_IZMAKSAT        DECIMAL(10,2)
YYMM                 STRING(6)
TEX:DUF              STRING(140)
rpt_GADS             DECIMAL(4)
MENESIS              STRING(10)
NUMURS               USHORT
ALG_IZMAKSAT         DECIMAL(9,2)
SEIZMAKS             DECIMAL(9,2)
SUMMA_V1             STRING(56)
SUMMA_V2             STRING(56)
VUT                  STRING(35)
SARAKSTS             STRING(60)
T7_KODS              DECIMAL(3) !PÂRSK UZ KARTI

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

DISKS                CSTRING(60)
DISKETE              BYTE
darbiba              STRING(30)
NODALA               STRING(20)
MAKSAJUMA_TAKA       STRING(50)

ToScreen WINDOW('Norâdiet, kur rakstît'),AT(,,339,144),GRAY
       STRING('Tiks sagatavots fails sûtîðanai uz:'),AT(6,52),USE(?String2)
       STRING('Rakstu ...'),AT(161,12),FONT(,9,,FONT:bold,CHARSET:BALTIC),USE(?StringRakstu),HIDE
       STRING('Tiks sagatavots dokuments elektroniskai pârsûtîðanai uz banku '),AT(7,26),USE(?String3)
       ENTRY(@s50),AT(78,36),USE(MAKSAJUMA_TAKA)
       STRING('sekojoðâ folderî :'),AT(9,38),USE(?String113)
       OPTION('&Banka'),AT(6,63,321,54),USE(MB),BOXED
         RADIO('1'),AT(11,73,156,10),USE(?MB:Radio1),HIDE,VALUE('1')
         RADIO('2'),AT(11,81,156,10),USE(?MB:Radio2),HIDE,VALUE('2')
         RADIO('3'),AT(11,89,156,10),USE(?MB:Radio3),HIDE,VALUE('3')
         RADIO('4'),AT(11,97,156,10),USE(?MB:Radio4),HIDE,VALUE('4')
         RADIO('5'),AT(11,105,156,10),USE(?MB:Radio5),HIDE,VALUE('5')
         RADIO('6'),AT(175,73,149,10),USE(?MB:Radio6),HIDE,VALUE('6')
         RADIO('7'),AT(175,81,149,10),USE(?MB:Radio7),HIDE,VALUE('7')
         RADIO('8'),AT(175,89,149,10),USE(?MB:Radio8),HIDE,VALUE('8')
         RADIO('9'),AT(175,97,149,10),USE(?MB:Radio9),HIDE,VALUE('9')
         RADIO('10'),AT(175,105,149,10),USE(?MB:Radio10),HIDE,VALUE('10')
       END
       BUTTON('&Atlikt'),AT(291,123,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(254,123,35,14),USE(?OkButton),DEFAULT
     END
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

!---------------------------------------------------------------------------
report REPORT,AT(104,1229,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,250,8000,979)
         LINE,AT(729,677,0,313),USE(?Line3:4),COLOR(COLOR:Black)
         STRING('Vârds, Uzvârds'),AT(781,729,2083,208),USE(?String12:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(781,365,6042,260),USE(Saraksts),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7188,469,,156),PAGENO,USE(?PageCount)
         STRING(@s20),AT(6250,208),USE(NODALA),LEFT
         LINE,AT(365,677,0,313),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(365,677,7240,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nr'),AT(417,729,260,208),USE(?String12),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3073,677,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(5573,677,0,313),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(7604,677,0,313),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('Personas kods'),AT(3115,729,990,208),USE(?String12:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6646,729,885,208),USE(?String12:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Konta Nr'),AT(4219,729,1094,208),USE(?String12:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Bankas kods'),AT(5604,729,938,208),USE(?String12:11),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,677,0,313),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(365,938,7240,0),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1458,52,4740,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6563,677,0,313),USE(?Line23),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,240)
         LINE,AT(365,-10,0,270),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@s21),AT(4146,10,1410,156),USE(kad:rek_nr1),LEFT(1)
         LINE,AT(7604,-10,0,270),USE(?Line3:27),COLOR(COLOR:Black)
         LINE,AT(365,208,7240,0),USE(?Line33:3),COLOR(COLOR:Black)
         LINE,AT(3073,-10,0,270),USE(?Line3:12),COLOR(COLOR:Black)
         STRING(@p######-#####p),AT(3208,10,885,156),USE(kad:perskod),LEFT
         LINE,AT(4115,-10,0,270),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(5573,-10,0,270),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(6563,-10,0,270),USE(?Line24),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(6615,10,885,156),USE(ALG_IZMAKSAT),RIGHT
         STRING(@s35),AT(781,0,2270,156),USE(VUT),LEFT
         LINE,AT(729,-10,0,270),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@n3),AT(417,10,,156),USE(numurs),RIGHT
         STRING(@s15),AT(5688,10,,156),USE(KAD:BKODS1),LEFT
       END
GRP_FOOT DETAIL,AT(,,,1563),USE(?unnamed)
         LINE,AT(5573,-10,0,218),USE(?Line3:40),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,218),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(729,-10,0,218),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@s25),AT(4125,990,1875,208),USE(SYS:AMATS2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(2260,1198,1563,0),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6063,1198,1563,0),USE(?Line26:2),COLOR(COLOR:Black)
         STRING(@s25),AT(2125,1250,1875,208),USE(SYS:PARAKSTS1),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s56),AT(1094,573,4167,208),USE(SUMMA_V2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(365,-10,0,218),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(7604,-10,0,218),USE(?Line3:42),COLOR(COLOR:Black)
         STRING('Kopâ  :'),AT(990,10,1198,156),USE(?String12:6),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(365,208,7240,0),USE(?Line33),COLOR(COLOR:Black)
         STRING('Summa :'),AT(469,365,573,208),USE(?String12:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s56),AT(1094,365,4167,208),USE(SUMMA_V1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(333,990,1875,208),USE(SYS:AMATS1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Z.V.'),AT(938,1302,260,208),USE(?String12:9),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(5865,1240,1875,208),USE(SYS:PARAKSTS2),CENTER,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(6563,-10,0,218),USE(?Line333:140),COLOR(COLOR:Black)
         STRING(@n-_11.2b),AT(6615,10,885,156),USE(KOPA_IZMAKSAT),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3073,-10,0,218),USE(?Line25),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,9000,8000,52)
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

  CHECKOPEN(BANKAS_K,1)
  BANKAS_K::USED+=1
  CHECKOPEN(SYSTEM,1)
  IF ~NOKL_B THEN NOKL_B=SYS:NOKL_B.  !VAJAG ARÎ VIRSRAKSTAM
  IF F:XML                            !BÛVÇT FAILU
     DISKS=''
     DISKETE=FALSE
     MB=NOKL_B
     GETMYBANK()          ! MANA BANKA
     MAKSAJUMA_TAKA=BAN:MAKSAJUMA_TAKA
!     MAKSAJUMA_TAKA=GETBANKAS_K(GL:BKODS[MB],0,2)
     IF ~MAKSAJUMA_TAKA
        MAKSAJUMA_TAKA=MAKSAJUMA_TAKA[1:2]&'\WINLATS\IMPEXP'
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
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Saraksts bankai'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=ALP:YYYYMM
      SET(ALG:ini_KEY,ALG:ini_KEY)
      Process:View{Prop:Filter} ='~(F:NODALA AND ~(ALG:NODALA=F:NODALA)) AND ~(ID AND ~(ALG:ID=ID))'
!        ~(F:NOA AND ~(BKODS=GETKADRI(ALG:ID,0,17))' NEIET DÇÏ GETKADRI
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

      BAN_NOS_P=GETBANKAS_K(GL:BKODS[NOKL_B],0,1)
      RPT_GADS=YEAR(ALP:YYYYMM)
      MENESIS =MENVAR(ALP:YYYYMM,2,2)
      IF F:NODALA THEN NODALA='Nodaïa: '&F:NODALA.
      IF F:KRI='A'
         SARAKSTS=CLIP(BAN_NOS_P)&'.Algu maksâjumu saraksts Nr _____'
      ELSE
         SARAKSTS=CLIP(BAN_NOS_P)&'.Avansu maksâjumu saraksts Nr _____'
      .
      IF F:KRI='A' ! ALGU PÂRSKAITÎJUMS
         CHECKOPEN(DAIEV,1)
         CLEAR(DAI:RECORD)
         DAI:KODS=900
         SET(DAI:KOD_KEY,DAI:KOD_KEY)
         LOOP
            NEXT(DAIEV)
            IF ERROR() THEN BREAK.
            IF DAI:T='7'
               T7_KODS=DAI:KODS
               BREAK
            .
         .
         IF ~T7_KODS
            KLUDA(0,'Nav atrasts Ieturçjumu kods <T=7 algas pârskaitîjums uz karti>')
            DO PROCEDURERETURN
         .
      .
!----------------------------------------------------------------------------------------------------------------
      IF F:XML  !BÛVÇT FAILU BANKAI
         IF SUB(GL:BKODS[NOKL_B],1,6)='TRELLV'
            KLUDA(0,'e-Kase neuztur mass payment',,1)
            DO PROCEDURERETURN
         ELSE 
            XMPFILENAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'_MP.XML'
!            STOP(XMPFILENAME)
            CHECKOPEN(OUTFILEXMP,1)
            CLOSE(OUTFILEXMP)
            OPEN(OUTFILEXMP,18)
            IF ERROR()
               KLUDA(1,XMPFILENAME)
            .
            EMPTY(OUTFILEXMP)
         .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(F:NOA AND ~(BKODS=GETKADRI(ALG:ID,0,17)))
           nrsektori += 1
           IF F:KRI='A' !ALGAS PÂRSKAITÎJUMS
              ALG_IZMAKSAT = 0
              LOOP I#=1 TO 15
                 IF ALG:I[I#]=T7_KODS
                    ALG_IZMAKSAT += ALG:N[I#]
                 .
              .
           ELSE         !AVANSI
              ALG_IZMAKSAT = 0
              LOOP I#=1 TO 15
                 IF ALG:I[I#]=904
                    ALG_IZMAKSAT += ALG:N[I#]
                 .
              .
           .
           IF ALG_IZMAKSAT>0
              VUT=GETKADRI(ALG:ID,0,1)
              IF ~GETKADRI(ALG:ID,0,4)  !REK_NR
                 KLUDA(44,' bankas KONTA Nr '&VUT)
              .
              NUMURS += 1
              IF ~KAD:BKODS1 THEN KAD:BKODS1=GL:BKODS[SYS:NOKL_B].
              PRINT(RPT:DETAIL)
              KOPA_IZMAKSAT+= ALG_izmaksat
              IF F:XML  !BÛVÇT FAILU
   !               IF UNIB#
   !                  NPK#+=1
   !!                  DBU:DOK_DAT  = FORMAT(DAY(TODAY()),@N02)&FORMAT(MONTH(TODAY()),@N02)&YEAR(TODAY()) !
   !                  DBU:DOK_DAT  = YEAR(TODAY())&FORMAT(MONTH(TODAY()),@N02)&FORMAT(DAY(TODAY()),@N02) !
   !                  DBU:ID       = NPK#
   !                  DBU:DBA      = REK     !
   !                  DBU:DBSUB    = ''      !
   !                  DBU:DBSUBNAM = ''      !
   !                  DBU:AMTC     = FORMAT(ALG_IZMAKSAT,@N_16.2)
   !                  DBU:CURR     = 'LVL'
   !                  IF ~KAD:BKODS1 THEN KAD:BKODS1=GL:BKODS[SYS:NOKL_B].
   !                  DBU:MFO      = KAD:BKODS1                           !NO UNIBANKAS VAR SÛTÎT UZ JEBKURIENI
   !                  DBU:CRA   = KAD:REK_NR1
   !                  DBU:CRNAME   = GETKADRI(ALG:ID,0,1)
   !                  DBU:CRLUR    = FORMAT(KAD:PERSKOD,@P######-#####P)
   !                  DBU:CRSUB    = ''
   !                  DBU:CRSUBNAM = ''
   !                  DBU:CRSUBLUR = ''
   !                  IF F:KRI='A'
   !                     DBU:TARGET= 'Alga '&RPT_GADS&'.gada '&MENESIS
   !                  ELSE
   !                     DBU:TARGET= 'Avanss '&RPT_GADS&'.gada '&MENESIS
   !                  .
   !                  ADD(DBFUNIB)
   !               IF PAREX#
   !                  PAX:BATCH_NR  = 1
   !                  PAX:TRAN_DATE = TODAY()
   !                  PAX:SLIP_NR   = MONTH(ALG:YYYYMM)
   !                  PAX:CARD_ACCT = KAD:REK_NR1
   !                  PAX:TRAN_TYPE = '10'
   !                  PAX:AMOUNT    = FORMAT(ALG_IZMAKSAT,@N_12.2)
   !                  PAX:AUTH_CODE = ''
   !                  PAX:CURRENCY  = 'LVL'
   !                  PAX:REC_DATE  = TODAY()
   !                  PAX:CARD      = ''
   !                  PAX:BRANCH    = '32000'
   !                  PAX:OPERATOR  = SYS:PARAKSTS1[1:10]
   !                  PAX:REF_NR    = ''
   !                  PAX:CONTROL   = ''
   !                  PAX:ERR_CODE  = ''
   !                  ADD(PAREX)
   !               IF SWED#
   !                  CLEAR(P:RECORD)
   !                  P:VARDS      = CLIP(KAD:VAR)&' '&KAD:UZV
   !                  P:PERSKODS   = FORMAT(KAD:PERSKOD,@P######-#####P)
   !                  P:SUMMA      = ALG_IZMAKSAT
   !                  P:SAN_KONTS  = KAD:REK_NR1
   !                  P:SWIFT      = KAD:BKODS1
   !                  P:LINE = CLIP(P:VARDS)&CHR(9)&P:PERSKODS&CHR(9)&CLIP(P:SUMMA)&CHR(9)&P:SAN_KONTS&CHR(9)&P:SWIFT
   !                  ADD(MASPERS)
   !               ELSIF HIZE#
   !                  CLEAR(H:RECORD)
   !                  H:LINE=CLIP(KAD:VAR)&' '&CLIP(KAD:UZV)&CHR(9)& |
   !                         FORMAT(KAD:PERSKOD,@P######-#####P)&CHR(9)& |
   !                         CLIP(ALG_IZMAKSAT)&CHR(9)& |
   !                         KAD:REK_NR1&CHR(9)& |
   !                         KAD:BKODS1
   !                  ADD(MASPERSH)
!                  IF CITA# !DnB NORD,KRÂJBANKA
!                     DBF:P_KOD    = KAD:PERSKOD
!                     DBF:F_NAMES  = KAD:UZV
!                     DBF:SURNAME  = KAD:VAR
!                     DBF:AMOUNT   = ALG_IZMAKSAT
!                     DBF:S_CTRL   = ''
!                     ADD(DBFFILE)

!                  ELSE        !SEB,SWED,HIPO,NORDEA,PÂRÇJÂS
                     XMP:LINE=' BenSet>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' BenExtId>'&KAD:ID&'</BenExtId>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' Priority>N</Priority>'    !N-normal U-urgent X-express
                     ADD(OUTFILEXMP)
                     XMP:LINE=' Comm>OUR</Comm>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' Amt>'&CLIP(LEFT(FORMAT(ALG_IZMAKSAT,@N_12.2)))&'</Amt>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' BenAccNo>'&CLIP(KAD:REK_NR1)&'</BenAccNo>'
                     ADD(OUTFILEXMP)
                     !17/04/2013   105
                     !XMP:LINE=' BenName>'&CLIP(KAD:UZV)&' '&CLIP(KAD:VAR)&'</BenName>'
                     TEX:DUF=CLIP(KAD:UZV)&' '&CLIP(KAD:VAR)
                     DO CONVERT_TEX:DUF_
                     XMP:LINE=' BenName>'&CLIP(TEX:DUF)&'</BenName>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' BenLegalId>'&CLIP(KAD:PERSKOD)&'</BenLegalId>'
                     ADD(OUTFILEXMP)
                     !17/04/2013   70
                     !XMP:LINE=' BenAddress>'&CLIP(KAD:PIERADR)&'</BenAddress>'
                     TEX:DUF=KAD:PIERADR
                     DO CONVERT_TEX:DUF_
                     XMP:LINE=' BenAddress>'&CLIP(TEX:DUF)&'</BenAddress>'
                     
                     ADD(OUTFILEXMP)
                     XMP:LINE=' BenCountry>LV</BenCountry>' !PAGAIDÂM
                     ADD(OUTFILEXMP)
                     !17/04/2013   35
                     !XMP:LINE=' BBName>'&CLIP(GETBANKAS_K(KAD:BKODS1,2,1))&'</BBName>'
                     TEX:DUF=GETBANKAS_K(KAD:BKODS1,2,1)
                     DO CONVERT_TEX:DUF_
                     XMP:LINE=' BBName>'&CLIP(TEX:DUF)&'</BBName>'
                     ADD(OUTFILEXMP)
                     XMP:LINE=' BBSwift>'&CLIP(KAD:BKODS1)&'</BBSwift>'
                     ADD(OUTFILEXMP)
                     XMP:LINE='</BenSet>'
                     ADD(OUTFILEXMP)
!                  .
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
    summa_v1=sub(sumvar(KOPA_IZMAKSAT,val_uzsk,0),1,56)
    summa_v2=sub(sumvar(KOPA_IZMAKSAT,val_uzsk,0),57,56)
    PRINT(RPT:GRP_FOOT)
!    CLOSE(DBFFILE)                                 !CLOSE DBF
!    CLOSE(PAREX)                                   !CLOSE DBF
!    CLOSE(MASPERS)                                 !CLOSE SWED
!    CLOSE(MASPERSH)                                !CLOSE HIZEB
    CLOSE(OUTFILEXMP)                              !FIDAVISTA
    IF F:XML AND DISKETE=TRUE   !JÂPÂRKOPÇ UZ DISKETI
       IF ~CopyFileA(FILENAME1,FILENAME2,0)
          KLUDA(3,FILENAME1&' uz '&FILENAME2)
       .
    .
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    BANKAS_K::USED-=1
    IF BANKAS_K::USED=0
       CLOSE(banKAS_K)
    .
  END
  CLOSE(OUTFILEXMP)
  F:KRI='' ! NOMETAM ALGA
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
  IF ERRORCODE() OR ~(ALG:YYYYMM=ALP:YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
 !-----------------------------------------------------------------------------
CONVERT_TEX:DUF_  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]= CHR(39)
!        stop('aaa'&TEX:DUF[J#])
!        stop('sss'&TEX:DUF[J#+1:J#+3]&' '&VAL(TEX:DUF[J#+1:J#+1])&' '&VAL(TEX:DUF[J#+2:J#+2]))
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<'
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='{'
!        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='}'
!        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='['
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=']'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=';'
        TEX:DUF=TEX:DUF[1:J#-1]&','&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='='
        TEX:DUF=TEX:DUF[1:J#-1]&'-'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='%'
        TEX:DUF=TEX:DUF[1:J#-1]&' proc.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='?'
        TEX:DUF=TEX:DUF[1:J#-1]&'.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='#'
        TEX:DUF=TEX:DUF[1:J#-1]&'Nr'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='/'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='\'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=':'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='*'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='_'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .


A_AlguLapinas        PROCEDURE                    ! Declare Procedure
!--------------------------------------------------------------------
RPT_GADS             DECIMAL(4)
RPT_GADS1            DECIMAL(4)
MENESIS              STRING(10)
VARDS                STRING(30)
STUNDAS              DECIMAL(4)
STUNDAS1             DECIMAL(4)
TEX                  STRING(35)
MIA                  DECIMAL(7,2) ! ÐIE IR SASKAÒOTI AR ALG:RECORD
APGADSUM             DECIMAL(7,2)
INVSUM               DECIMAL(7,2)
PPF_VAP              DECIMAL(7,2)
P_SUMMA              DECIMAL(9,2) 
I_SUMMA              DECIMAL(9,2)
P_SUMMA1             DECIMAL(9,2)
I_SUMMA1             DECIMAL(9,2)
KOP_PIE1             DECIMAL(9,2)
KOP_IE1              DECIMAL(9,2)
IZ1                  DECIMAL(9,2)
PA1                  DECIMAL(9,2)
KOP_PIE              DECIMAL(9,2)
KOP_IE               DECIMAL(9,2)
IZ                   DECIMAL(9,2)
PA                   DECIMAL(9,2)
!-------------------------------------------------------------------------
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
!---------------------------------------------------------------------------
report REPORT,AT(104,300,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,100,8000,198)
       END
GRP_HEAD DETAIL,AT(,,,833),USE(?unnamed:2)
         LINE,AT(4375,521,0,313),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(6667,521,0,313),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(7292,521,0,313),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(156,781,3802,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(4063,781,3854,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING('Piesk.'),AT(2740,573,573,208),USE(?String1:12),CENTER
         STRING('Ieturçj.'),AT(3365,573,573,208),USE(?String1:13),CENTER
         LINE,AT(156,521,3802,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(417,521,0,313),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(2708,521,0,313),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(3333,521,0,313),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(4063,521,3854,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Darba apmaksas / ieturçjuma veids'),AT(4406,573,2240,208),USE(?String1:14),CENTER
         STRING('Piesk.'),AT(6708,573,573,208),USE(?String1:15),CENTER
         STRING('Ieturçj.'),AT(7323,573,573,208),USE(?String1:16),CENTER
         STRING('Darba apmaksas / ieturçjuma veids'),AT(469,573,2188,208),USE(?String1:11),CENTER
         LINE,AT(156,52,3802,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3958,52,0,781),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(4063,52,0,781),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(7917,52,0,781),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(4063,52,3854,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Algu lapa:'),AT(4115,104),USE(?String1:2)
         STRING(@n4),AT(4688,104),USE(RPT_gads1),RIGHT
         STRING('. g.'),AT(5000,104),USE(?String1:4)
         STRING(@s12),AT(5208,104),USE(menesis,,?menesis:2),LEFT
         STRING(@s25),AT(6031,104),USE(KAD:AMATS),TRN
         STRING('Nodaïa :'),AT(208,313,469,177),USE(?String1:7)
         STRING(@S2),AT(667,313,177,177),USE(kad:NODALA),LEFT
         STRING('ID :'),AT(823,313,208,177),USE(?String1:8)
         STRING(@n4),AT(1042,313,302,177),USE(kad:id),LEFT(1)
         STRING(@s30),AT(1375,313,1948,177),USE(vards,,?vards:1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s8),AT(3396,313,552,177),USE(KAD:DAR_LIG),TRN,CENTER
         STRING('Ligums:'),AT(6990,292,354,177),USE(?String59:2),TRN
         STRING(@s8),AT(7354,292,552,177),USE(KAD:DAR_LIG,,?KAD:DAR_LIG:2),TRN,CENTER
         STRING('L:'),AT(3302,313,94,177),USE(?String59),TRN
         STRING('Nodaïa:'),AT(4094,292,375,177),USE(?String1:9)
         STRING(@S2),AT(4479,292,177,177),USE(kad:NODALA,,?kad:NODALA:2),LEFT
         STRING('ID :'),AT(4625,292,208,177),USE(?String1:10)
         STRING(@n4),AT(4792,292,302,177),USE(kad:id,,?kad:id:2),LEFT(1)
         STRING(@s30),AT(-2406,354,1948,208),USE(vards),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(5063,292,1917,177),USE(vards,,VARDS:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(781,104),USE(RPT_gads),RIGHT
         STRING('. g.'),AT(1094,104),USE(?String1:3)
         STRING(@s12),AT(1302,104),USE(menesis),LEFT
         STRING(@n6.2),AT(2125,104),USE(mia),RIGHT
         STRING('-'),AT(2510,104,104,188),USE(?String1:5),CENTER
         STRING(@n6.2),AT(2615,104,333,188),USE(apgadsum),RIGHT
         STRING('-'),AT(2979,104,104,188),USE(?String1:6),CENTER
         STRING(@n6.2),AT(3083,104,333,188),USE(invsum),RIGHT
         STRING('-'),AT(3448,104,104,188),USE(?String11:6),CENTER
         STRING(@n_6.2),AT(3542,104,365,208),USE(PPF_VAP),RIGHT
         LINE,AT(156,52,0,781),USE(?Line3),COLOR(COLOR:Black)
         STRING('Algu lapa:'),AT(208,104),USE(?String1)
       END
DAIEV  DETAIL,WITHPRIOR(1),AT(,,,177)
         STRING(@n-_10.2b),AT(2740,0,573,156),USE(p_summa),RIGHT
         STRING(@n-_10.2b),AT(3365,10,573,156),USE(i_summa),RIGHT
         LINE,AT(3958,-10,0,197),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(4063,-10,0,197),USE(?Line15:4),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,197),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,197),USE(?Line15:6),COLOR(COLOR:Black)
         STRING(@n-_10.2b),AT(6698,10,573,156),USE(p_summa1),RIGHT
         LINE,AT(7292,-10,0,197),USE(?Line15:7),COLOR(COLOR:Black)
         STRING(@n-_10.2b),AT(7323,10,573,156),USE(i_summa1),RIGHT
         LINE,AT(7917,-10,0,197),USE(?Line15:8),COLOR(COLOR:Black)
         STRING(@n4b),AT(4094,10,260,156),USE(stundas1),RIGHT
         STRING(@s35),AT(4427,10,2240,156),USE(tex,,TEX:1),LEFT
         LINE,AT(2708,-10,0,197),USE(?Line15:3),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,197),USE(?Line15:2),COLOR(COLOR:Black)
         STRING(@n4b),AT(188,10,208,156),USE(stundas),RIGHT
         LINE,AT(417,-10,0,197),USE(?Line14),COLOR(COLOR:Black)
         STRING(@s35),AT(458,10,2240,156),USE(tex),LEFT
         LINE,AT(156,-10,0,197),USE(?Line3:7),COLOR(COLOR:Black)
       END
GRP_FOOT1 DETAIL,WITHPRIOR(2),AT(,,,625),USE(?unnamed)
         LINE,AT(4063,521,3854,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(156,521,3802,0),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(156,0,0,521),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(2708,0,0,521),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(3333,0,0,521),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(3958,0,0,521),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(4063,0,0,521),USE(?Line3:16),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,52),USE(?Line3:21),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,521),USE(?Line3:19),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,521),USE(?Line3:20),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,521),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(156,52,3802,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(417,0,0,52),USE(?Line3:18),COLOR(COLOR:Black)
         LINE,AT(4063,52,3854,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING(@N3B),AT(2240,94,240,177),USE(ALG:N_STUNDAS,,?ALG:N_STUNDAS:2),TRN
         STRING('st.'),AT(2500,94),USE(?STUNDAS:2),TRN
         STRING('Kopâ :'),AT(260,104,573,208),USE(?String1:17),LEFT
         STRING(@n-_10.2b),AT(2740,104,573,156),USE(kop_pie1),RIGHT
         STRING(@n-_10.2b),AT(3365,104,573,156),USE(kop_ie1),RIGHT
         STRING('Kopâ :'),AT(4115,104,573,208),USE(?String1:19),LEFT
         STRING(@N3B),AT(6198,104,240,177),USE(ALG:N_STUNDAS,,?ALG:N_STUNDAS:3),TRN
         STRING('st.'),AT(6458,104),USE(?STUNDAS:3),TRN
         STRING(@n-_10.2b),AT(6698,104,573,156),USE(kop_pie),RIGHT
         STRING(@n-_10.2b),AT(7323,104,573,156),USE(kop_ie),RIGHT
         STRING('Izmaksât  (parâds)'),AT(260,313,1146,208),USE(?String1:18),LEFT
         STRING(@n-_10.2b),AT(2740,313,573,156),USE(IZ1),RIGHT
         STRING(@n-_10.2b),AT(3365,313,573,156),USE(PA1),RIGHT
         STRING('Izmaksât  (parâds)'),AT(4115,313,1146,208),USE(?String1:20),LEFT
         STRING(@n-_10.2b),AT(6698,313,573,156),USE(IZ),RIGHT
         STRING(@n_10.2b),AT(7323,313,573,156),USE(PA),RIGHT
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
  RPT_GADS  = YEAR(ALP:YYYYMM)
  RPT_GADS1 = RPT_GADS
  MENESIS   = MENVAR(ALP:YYYYMM,2,2)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF DAIEV::USED=0              !dçï getdaiev
     CHECKOPEN(DAIEV,1)
  .
  DAIEV::USED+=1
  IF KADRI::USED=0              !dçï getKADRI
     CHECKOPEN(KADRI,1)
  .
  KADRI::USED+=1
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Algu lapiòas'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      GET(ALGAS,0)
      CLEAR(alg:record)
      ALG:YYYYMM=ALP:YYYYMM
      ALG:NODALA=F:NODALA
      SET(alg:NOD_KEY,ALG:NOD_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA and ~ALG:NODALA=F:NODALA) AND ~(ID and ~ALG:ID=ID)'
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
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        DO DRUK
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
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
!!!    print(RPT:PAGE_FOOT)
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
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
  IF ERRORCODE() OR ~(ALG:YYYYMM=ALP:YYYYMM)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
DRUK   ROUTINE
  RI#=0
  LOOP I#= 1 TO 20
    IF ALG:R[I#]
       RI#+=1
    .
  .
  LOOP I#= 1 TO 15
    IF ALG:N[I#]
       RI#+=1
    .
  .
  IF RI#
     kop_pie = 0
     kop_pie1 = 0
     kop_ie = 0
     kop_ie1 = 0
     FOUND#=0
     LOOP I#= 1 TO 20
       IF ALG:R[I#]
          IF ~FOUND#
             VARDS=GETKADRI(ALG:ID,2,1)
             MIA=CALCNEA(1,0,0)
             apgadsum=CALCNEA(2,0,0)
             invsum=CALCNEA(3,0,0)
             PPF_VAP=ALG:PPF+ALG:DZIVAP+ALG:IZDEV
             PRINT(rpt:GRP_HEAD)
             FOUND#=1
          .
          TEX = GETDAIEV(ALG:K[I#],0,1)
          P_SUMMA=0
          I_SUMMA=0
          STUNDAS=0
          P_SUMMA1=0
          I_SUMMA1=0
          STUNDAS1=0
          P_summa = ALG:R[I#]
          P_SUMMA1=P_SUMMA
          IF DAI:F = 'CAL'
             STUNDAS=ALG:S[I#]
          ELSIF INRANGE(ALG:K[I#],840,842)
             STUNDAS=ALG:D[I#]
          ELSE
             STUNDAS=ALG:A[I#]
          .
          STUNDAS1=STUNDAS
          PRINT(rpt:DAIEV)
       .
     .
     LOOP I#= 1 TO 15
       IF ALG:I[I#]
          IF ~FOUND#
             VARDS=GETKADRI(ALG:ID,2,1)
             PRINT(rpt:GRP_HEAD)
             FOUND#=1
          .
          TEX = GETDAIEV(ALG:I[I#],0,1)
          P_SUMMA=0
          I_SUMMA=0
          STUNDAS=0
          P_SUMMA1=0
          I_SUMMA1=0
          STUNDAS1=0
          STUNDAS=0
          I_summa = ALG:N[I#]
          I_SUMMA1=I_SUMMA
          STUNDAS1=0
          PRINT(rpt:DAIEV)
!!!          LI+=1
       .
     .
     IF FOUND#
        kop_pie  = SUM(33)
        kop_pie1 = kop_pie
        kop_ie   = SUM(28)
        kop_ie1  = kop_ie
        IF ALG:IZMAKSAT > 0
           iz  = ALG:IZMAKSAT
           iz1 = ALG:IZMAKSAT
           PA  = 0
           PA1 = 0
        ELSE
           PA  = ALG:IZMAKSAT
           PA1 = ALG:IZMAKSAT
           IZ  = 0
           IZ1 = 0
        .
        PRINT(rpt:grp_foot1)
     .
  .
A_PERSKONT           PROCEDURE                    ! Declare Procedure
!-----------------------------------------------------------------------
DA                   DECIMAL(9,2),DIM(12,30)
NODALA               STRING(2),DIM(12)
LAST_NODALA          STRING(2)
SAV_ID               USHORT
DAT                  DATE
LAI                  TIME
ME                   DECIMAL(2)
STU_DD               DECIMAL(3)
STU_DDK              DECIMAL(4)
P2                   DECIMAL(9,2)
P3                   DECIMAL(9,2)
P4                   DECIMAL(9,2)
P5                   DECIMAL(9,2)
P6                   DECIMAL(9,2)
P7                   DECIMAL(9,2)
PD                   DECIMAL(9,2)
P8                   DECIMAL(9,2)
P9                   DECIMAL(9,2)
P10                  DECIMAL(9,2)
P11                  DECIMAL(9,2)
PN                   DECIMAL(9,2)
P12                  DECIMAL(9,2)
P13                  DECIMAL(9,2)
P14                  DECIMAL(9,2)
P15                  DECIMAL(9,2)
P2K                  DECIMAL(9,2)
P3K                  DECIMAL(9,2)
P4K                  DECIMAL(9,2)
P5K                  DECIMAL(9,2)
P6K                  DECIMAL(9,2)
P7K                  DECIMAL(9,2)
PDK                  DECIMAL(9,2)
P8K                  DECIMAL(9,2)
P9K                  DECIMAL(9,2)
P10K                 DECIMAL(9,2)
P11K                 DECIMAL(9,2)
PNK                  DECIMAL(9,2)
P12K                 DECIMAL(9,2)
P13K                 DECIMAL(9,2)
P14K                 DECIMAL(9,2)
ME1                  DECIMAL(2)
P16                  DECIMAL(9,2)
P17                  DECIMAL(9,2)
P18                  DECIMAL(9,2)
P19                  DECIMAL(9,2)
P20                  DECIMAL(9,2)
P21                  DECIMAL(9,2)
P22                  DECIMAL(9,2)
P23                  DECIMAL(9,2)
P24                  DECIMAL(9,2)
P25                  DECIMAL(9,2)
P26                  DECIMAL(9,2)
P28                  DECIMAL(9,2)
P16K                 DECIMAL(9,2)
P17K                 DECIMAL(9,2)
P18K                 DECIMAL(9,2)
P19K                 DECIMAL(9,2)
P20K                 DECIMAL(9,2)
P21K                 DECIMAL(9,2)
P22K                 DECIMAL(9,2)
P23K                 DECIMAL(9,2)
P24K                 DECIMAL(9,2)
P25K                 DECIMAL(9,2)
P28K                 DECIMAL(9,2)
VARUZVAR             STRING(27)
RPT_GADS             STRING(11)
INFO_LINE            STRING(120)

!---------------------------------------------------------------------
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

!---------------------------------------------------------------------------
report REPORT,AT(104,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
page_HEAD DETAIL,AT(,,,813),USE(?unnamed:5)
         STRING(@s12),AT(7073,573,833,208),USE(KAD:KARTNR),LEFT
         LINE,AT(52,781,7865,0),USE(?Line146:2),COLOR(COLOR:Black)
         LINE,AT(52,313,7865,0),USE(?Line146),COLOR(COLOR:Black)
         STRING(@N06),AT(6479,573,469,208),USE(KAD:TERKOD),CENTER
         STRING(@s45),AT(3625,573,2792,208),USE(KAD:PIERADR),LEFT(1)
         STRING(@p######-#####p),AT(2781,573,781,208),USE(KAD:PERSKOD),LEFT
         STRING(@s45),AT(156,104,3385,208),USE(CLIENT),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Personîgais konts'),AT(3802,104,1198,208),USE(?String2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(5000,104),USE(KAD:ID),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,313,0,469),USE(?Line147),COLOR(COLOR:Black)
         STRING('Taks. gads'),AT(135,365,573,208),USE(?String2:2),LEFT
         LINE,AT(823,313,0,469),USE(?Line147:2),COLOR(COLOR:Black)
         STRING('Vârds, Uzvârds'),AT(1208,365,1198,208),USE(?String2:3),CENTER
         LINE,AT(2740,313,0,469),USE(?Line147:3),COLOR(COLOR:Black)
         STRING('Pers. kods'),AT(2792,365,781,208),USE(?String2:4),CENTER
         LINE,AT(3594,313,0,469),USE(?Line147:4),COLOR(COLOR:Black)
         STRING('Dzîvesvietas adrese'),AT(3917,365,2344,208),USE(?String2:5),CENTER
         LINE,AT(6438,313,0,469),USE(?Line147:5),COLOR(COLOR:Black)
         LINE,AT(7917,313,0,469),USE(?Line147:6),COLOR(COLOR:Black)
         STRING('Ter. kods'),AT(6448,365,521,208),USE(?String2:6),CENTER
         LINE,AT(6979,313,0,469),USE(?Line147:7),COLOR(COLOR:Black)
         STRING('Grâmatas Nr'),AT(7000,365,865,208),USE(?String2:7),CENTER
         STRING(@s27),AT(854,563,1854,208),USE(VARUZVAR),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S11),AT(73,573),USE(rpT_GADS),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
INFO_LINE DETAIL,AT(,,,167),USE(?INFO_LINE:2)
         LINE,AT(7917,0,0,176),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@s120),AT(94,0,7635,156),USE(INFO_LINE),TRN,LEFT(1)
         LINE,AT(52,0,0,176),USE(?Line5:2),COLOR(COLOR:Black)
       END
page_HEAD1 DETAIL,AT(,,,708),USE(?unnamed:4)
         LINE,AT(677,0,0,677),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('Aprçíinâts'),AT(3177,63,1365,156),USE(?String2:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(365,0,0,677),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(52,0,7865,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,677),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Mçn.'),AT(83,271,260,156),USE(?String2:10),CENTER
         STRING('Nos'),AT(406,271,260,156),USE(?String2:12),CENTER
         STRING('Daþâdi'),AT(1823,271,2031,156),USE(?String2:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dâvanas'),AT(3885,271,469,156),USE(?String2:67),CENTER
         LINE,AT(5417,438,938,0),USE(?Line143),COLOR(COLOR:Black)
         LINE,AT(1771,438,2083,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(1198,229,0,469),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(1771,229,0,469),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(677,229,7240,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(4375,229,0,469),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(4896,229,0,469),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(5417,229,0,469),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(6875,229,0,469),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(7396,229,0,469),USE(?Line3:4),COLOR(COLOR:Black)
         STRING('st.'),AT(406,479,260,156),USE(?String2:13),CENTER
         STRING('Brutto'),AT(4406,271,469,156),USE(?String2:30),CENTER
         STRING('VSA'),AT(4927,271,469,156),USE(?String2:28),CENTER
         STRING('Atvieglojumi'),AT(5448,271,885,156),USE(?String2:25),CENTER
         LINE,AT(6354,229,0,469),USE(?Line3:30),COLOR(COLOR:Black)
         STRING('Neapl.'),AT(6385,271,469,156),USE(?String2:69),CENTER
         STRING('Apliek.'),AT(6906,271,469,156),USE(?String2:23),CENTER
         STRING('Neapl.'),AT(7479,271,417,156),USE(?String2:21),CENTER
         LINE,AT(2292,438,0,260),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(2813,438,0,260),USE(?Line3:16),COLOR(COLOR:Black)
         LINE,AT(3333,438,0,260),USE(?Line3:17),COLOR(COLOR:Black)
         STRING('u.c.neap.'),AT(3885,479,469,156),USE(?String2:71),CENTER
         STRING('Gabald.'),AT(708,479,469,156),USE(?String2:32),CENTER
         STRING('Laika'),AT(1229,479,521,156),USE(?String2:33),CENTER
         STRING('Prçmija'),AT(1802,479,469,156),USE(?String2:34),CENTER
         STRING('Piem.'),AT(2323,479,469,156),USE(?String2:35),CENTER
         STRING('Atv.'),AT(2844,479,469,156),USE(?String2:36),CENTER
         STRING('Sli.'),AT(3365,479,469,156),USE(?String2:37),CENTER
         LINE,AT(3854,229,0,469),USE(?Line3:33),COLOR(COLOR:Black)
         STRING('ieòçm.'),AT(4406,479,469,156),USE(?String2:31),CENTER
         STRING('+ citi'),AT(4927,479,469,156),USE(?String2:29),CENTER
         STRING('apgâd.*'),AT(5448,479,417,156),USE(?String2:27),CENTER
         LINE,AT(5885,438,0,260),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('IN/PRP*'),AT(5917,479,417,156),USE(?String2:26),CENTER
         STRING('ienâk.'),AT(6385,479,469,156),USE(?String2:70),CENTER
         STRING('ienâk.'),AT(6906,479,469,156),USE(?String2:24),CENTER
         STRING('min.*'),AT(7479,479,417,156),USE(?String2:22),CENTER
         LINE,AT(52,646,7865,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(52,0,0,677),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,156)
         LINE,AT(52,-10,0,176),USE(?Line3:18),COLOR(COLOR:Black)
         STRING(@N2),AT(104,0,156,156),USE(ME),RIGHT
         STRING('.'),AT(260,0,104,156),USE(?String2:38),LEFT
         LINE,AT(365,-10,0,176),USE(?Line3:19),COLOR(COLOR:Black)
         STRING(@N3B),AT(417,0,208,156),USE(STU_DD),RIGHT
         LINE,AT(677,-10,0,176),USE(?Line3:20),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(708,0,469,156),USE(P2),RIGHT
         LINE,AT(1198,-10,0,176),USE(?Line3:21),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(1229,0,521,156),USE(P3),RIGHT
         LINE,AT(1771,-10,0,176),USE(?Line3:22),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(1792,0,490,156),USE(P4),RIGHT
         LINE,AT(2292,-10,0,176),USE(?Line3:23),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(2323,0,470,156),USE(P5),RIGHT
         LINE,AT(2813,-10,0,176),USE(?Line3:24),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2844,0,469,156),USE(P6),RIGHT
         LINE,AT(3333,-10,0,176),USE(?Line3:25),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3365,0,469,156),USE(P7),RIGHT
         STRING(@N_8.2),AT(3885,0,469,156),USE(PD),RIGHT
         LINE,AT(3854,-10,0,176),USE(?Line3:35),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,176),USE(?Line3:32),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(4406,0,469,156),USE(P8),RIGHT
         LINE,AT(4896,-10,0,176),USE(?Line3:27),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(4927,0,469,156),USE(P9),RIGHT
         LINE,AT(5417,-10,0,176),USE(?Line3:28),COLOR(COLOR:Black)
         STRING(@N7.2),AT(5448,0,417,156),USE(P10),RIGHT
         LINE,AT(5885,-10,0,176),USE(?Line3:29),COLOR(COLOR:Black)
         STRING(@N7.2),AT(5917,0,417,156),USE(P11),RIGHT
         STRING(@N_9.2),AT(6385,0,469,156),USE(PN),RIGHT
         LINE,AT(6354,-10,0,176),USE(?Line3:31),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,176),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(6906,0,469,156),USE(P12),RIGHT
         LINE,AT(7396,-10,0,176),USE(?Line3:5),COLOR(COLOR:Black)
         STRING(@N_7.2),AT(7448,0,417,156),USE(P13),RIGHT
         LINE,AT(7917,-10,0,176),USE(?Line3:34),COLOR(COLOR:Black)
       END
detailS DETAIL,AT(,,,156)
         LINE,AT(52,-10,0,176),USE(?Line4:18),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(73,0,260,156),USE(?MEN_SK:2),RIGHT
         LINE,AT(365,-10,0,176),USE(?Line4:19),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,176),USE(?Line4:20),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(708,0,469,156),USE(P2K),RIGHT
         LINE,AT(1198,-10,0,176),USE(?Line4:21),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(1229,0,521,156),USE(P3K),RIGHT
         LINE,AT(1771,-10,0,176),USE(?Line4:22),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(1792,0,490,156),USE(P4K),RIGHT
         LINE,AT(2292,-10,0,176),USE(?Line4:23),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(2323,0,470,156),USE(P5K),RIGHT
         LINE,AT(2813,-10,0,176),USE(?Line4:24),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2844,0,469,156),USE(P6K),RIGHT
         LINE,AT(3333,-10,0,176),USE(?Line4:25),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3365,0,469,156),USE(P7K),RIGHT
         STRING(@N_8.2),AT(3885,0,469,156),USE(PDK),RIGHT
         LINE,AT(3854,-10,0,176),USE(?Line4:26),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,176),USE(?Line4:261),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(4406,0,469,156),USE(P8K),RIGHT
         LINE,AT(4896,-10,0,176),USE(?Line4:27),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(4927,0,469,156),USE(P9K),RIGHT
         LINE,AT(5417,-10,0,176),USE(?Line4:28),COLOR(COLOR:Black)
         STRING(@N7.2),AT(5448,0,417,156),USE(P10K),RIGHT
         LINE,AT(5885,-10,0,176),USE(?Line4:29),COLOR(COLOR:Black)
         STRING(@N7.2),AT(5917,0,417,156),USE(P11K),RIGHT
         STRING(@N_9.2),AT(6385,0,469,156),USE(PNK),RIGHT
         LINE,AT(6354,-10,0,176),USE(?Line4:30),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,176),USE(?Line4:301),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(6906,0,469,156),USE(P12K),RIGHT
         LINE,AT(7396,-10,0,176),USE(?Line4:31),COLOR(COLOR:Black)
         STRING(@N_7.2),AT(7448,0,417,156),USE(P13K),RIGHT
         LINE,AT(7917,-10,0,176),USE(?Line4:34),COLOR(COLOR:Black)
         STRING(@N4B),AT(385,0,260,156),USE(STU_DDK),RIGHT
       END
PAGE_HEAD2 DETAIL,AT(,,,938),USE(?unnamed:3)
         LINE,AT(365,-10,0,956),USE(?Line3:37),COLOR(COLOR:Black)
         STRING('Ieturçts'),AT(2396,104,833,156),USE(?String2:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,-10,0,956),USE(?Line3:36),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line1:7),COLOR(COLOR:Black),LINEWIDTH(3)
         LINE,AT(6406,52,0,906),USE(?Line3:46),COLOR(COLOR:Black)
         LINE,AT(6927,52,0,906),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('Aprçíinâts'),AT(417,104,1094,156),USE(?String2:68),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1552,52,0,906),USE(?Line3:52),COLOR(COLOR:Black)
         LINE,AT(1521,52,0,906),USE(?Line3:44),COLOR(COLOR:Black)
         STRING('Daþâdi'),AT(4167,313,1667,156),USE(?String2:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksa'),AT(6438,104,469,156),USE(?String2:57),CENTER
         STRING('Parâdi'),AT(6958,104,417,156),USE(?String2:62),CENTER
         STRING('Pârsk.'),AT(7427,104,469,156),USE(?String2:64),CENTER
         STRING('Ien. n/k'),AT(396,313,521,156),USE(?String2:18),CENTER
         LINE,AT(938,260,0,687),USE(?Line3:45),COLOR(COLOR:Black)
         STRING('Ien.,kas'),AT(979,313,521,156),USE(?String2:15),CENTER
         LINE,AT(52,260,6354,0),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(2083,260,0,687),USE(?Line3:38),COLOR(COLOR:Black)
         LINE,AT(2604,260,0,687),USE(?Line3:39),COLOR(COLOR:Black)
         LINE,AT(3125,260,0,687),USE(?Line3:40),COLOR(COLOR:Black)
         LINE,AT(3625,260,0,687),USE(?Line3:41),COLOR(COLOR:Black)
         LINE,AT(4115,260,0,687),USE(?Line3:42),COLOR(COLOR:Black)
         LINE,AT(4688,469,0,479),USE(?Line3:43),COLOR(COLOR:Black)
         STRING('Pamat-'),AT(1594,313,469,156),USE(?String2:42),CENTER
         STRING('Papild-'),AT(2115,313,469,156),USE(?String2:44),CENTER
         STRING('Valsts'),AT(2635,313,469,156),USE(?String2:46),CENTER
         STRING('Avanss'),AT(3146,313,469,156),USE(?String2:48),CENTER
         STRING('Izpildr.'),AT(3677,313,417,156),USE(?String2:49),CENTER
         STRING('Pârmaksa'),AT(4146,521,521,156),USE(?String2:51),CENTER
         STRING('IEN/N'),AT(4719,521,521,156),USE(?String2:53),CENTER
         STRING('IEN/N'),AT(5292,521,521,156),USE(?String2:54),CENTER
         STRING('Kopâ'),AT(5865,313,521,156),USE(?String2:56),CENTER
         STRING('bez'),AT(6438,313,469,156),USE(?String2:59),CENTER
         STRING('par'),AT(6958,313,417,156),USE(?String2:63),CENTER
         STRING('algas'),AT(7427,313,469,156),USE(?String2:65),CENTER
         LINE,AT(5260,469,0,479),USE(?Line139),COLOR(COLOR:Black)
         STRING('nodoklis'),AT(7427,521,469,156),USE(?String2:66),CENTER
         STRING('ien/nod'),AT(396,729,521,156),USE(?String2:20),CENTER
         STRING('pag/nâk.m'),AT(979,729,521,156),USE(?String2:17),CENTER
         STRING('Mçn.'),AT(83,521,260,156),USE(?String2:41),CENTER
         STRING('rçíina'),AT(396,521,521,156),USE(?String2:19),CENTER
         STRING('jâpârrçí.'),AT(979,521,521,156),USE(?String2:16),CENTER
         STRING('likme'),AT(1594,521,469,156),USE(?String2:40),CENTER
         STRING('likme'),AT(2115,521,469,156),USE(?String2:45),CENTER
         STRING('soc.apd.'),AT(2635,521,469,156),USE(?String2:47),CENTER
         STRING('un citi'),AT(3677,521,417,156),USE(?String2:50),CENTER
         STRING('Parâds'),AT(4146,729,521,156),USE(?String2:52),CENTER
         STRING('pag. mçn.'),AT(4719,729,519,156),USE(?String2:43),CENTER
         STRING('nâk. mçn.'),AT(5292,729,521,156),USE(?String2:55),CENTER
         STRING('soc.pab.'),AT(6438,521,469,156),USE(?String2:60),CENTER
         STRING('D algu'),AT(6958,521,417,156),USE(?String2:61),CENTER
         LINE,AT(52,885,7865,0),USE(?Line1:11),COLOR(COLOR:Black)
         LINE,AT(5833,52,0,906),USE(?Line145),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,62),USE(?Line87:2),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,62),USE(?Line87:3),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,62),USE(?Line87:4),COLOR(COLOR:Black)
         LINE,AT(4115,469,2292,0),USE(?Line144),COLOR(COLOR:Black)
         LINE,AT(7396,52,0,906),USE(?Line90),COLOR(COLOR:Black)
         LINE,AT(5885,-10,0,62),USE(?Line87),COLOR(COLOR:Black)
         LINE,AT(5417,-10,0,62),USE(?Line86),COLOR(COLOR:Black)
         LINE,AT(4896,-10,0,62),USE(?Line85),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,62),USE(?Line84),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,62),USE(?Line84:2),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,62),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,62),USE(?Line82),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,62),USE(?Line82:3),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,62),USE(?Line82:2),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,956),USE(?Line3:49),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,62),USE(?Line81),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,62),USE(?Line80),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,156)
         LINE,AT(52,-10,0,176),USE(?Line5:18),COLOR(COLOR:Black)
         STRING(@N2),AT(104,0,156,156),USE(ME1),RIGHT
         STRING('.'),AT(260,0,104,156),USE(?String5:38),LEFT
         STRING(@N_9.2),AT(396,0,521,156),USE(P14),RIGHT
         LINE,AT(938,-10,0,176),USE(?Line5:53),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(990,0,469,156),USE(P15),RIGHT
         LINE,AT(365,-10,0,176),USE(?Line5:19),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(1594,0,469,156),USE(P16),RIGHT
         LINE,AT(1521,-10,0,176),USE(?Line5:531),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2135,0,417,156),USE(P17),RIGHT
         LINE,AT(2083,-10,0,176),USE(?Line5:55),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2635,0,469,156),USE(P18),RIGHT
         LINE,AT(2604,-10,0,176),USE(?Line5:56),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3146,0,469,156),USE(P19),RIGHT
         LINE,AT(3125,-10,0,176),USE(?Line5:57),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3656,0,440,156),USE(P20),RIGHT
         LINE,AT(3625,-10,0,176),USE(?Line5:54),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,176),USE(?Line5:58),COLOR(COLOR:Black)
         STRING(@N-_8.2),AT(4146,0,521,156),USE(P21),RIGHT
         LINE,AT(4688,-10,0,176),USE(?Line5:59),COLOR(COLOR:Black)
         STRING(@N6.2),AT(5313,0,469,156),USE(P23),RIGHT
         STRING(@N-_7.2),AT(4740,0,469,156),USE(P22),RIGHT
         LINE,AT(5260,-10,0,176),USE(?Line3:50),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5865,0,521,156),USE(P24),RIGHT
         LINE,AT(5833,-10,0,176),USE(?Line3:48),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(6438,0,469,156),USE(P25),RIGHT
         LINE,AT(6406,-10,0,176),USE(?Line5:30),COLOR(COLOR:Black)
         STRING(@N_7.2),AT(6958,0,417,156),USE(P26),RIGHT
         STRING(@N_8.2),AT(7438,0,469,156),USE(P28),TRN,RIGHT
         LINE,AT(1552,-10,0,176),USE(?Line5:631),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,176),USE(?Line3:47),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,176),USE(?Line3:51),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,176),USE(?Line5:34),COLOR(COLOR:Black)
       END
detail2S DETAIL,AT(,,,156),USE(?unnamed)
         LINE,AT(52,-10,0,176),USE(?Line6:18),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(396,0,521,156),USE(P14K),RIGHT
         LINE,AT(938,-10,0,176),USE(?Line6:53),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,176),USE(?Line6:19),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(1594,0,469,156),USE(P16K),RIGHT
         LINE,AT(1521,-10,0,176),USE(?Line6:532),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2135,0,417,156),USE(P17K),RIGHT
         LINE,AT(2083,-10,0,176),USE(?Line6:55),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(2635,0,469,156),USE(P18K),RIGHT
         LINE,AT(2604,-10,0,176),USE(?Line6:56),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3146,0,469,156),USE(P19K),RIGHT
         LINE,AT(3125,-10,0,176),USE(?Line6:57),COLOR(COLOR:Black)
         STRING(@N_8.2),AT(3656,0,440,156),USE(P20K),RIGHT
         LINE,AT(3625,-10,0,176),USE(?Line6:54),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,176),USE(?Line6:58),COLOR(COLOR:Black)
         STRING(@N-_8.2),AT(4146,0,521,156),USE(P21K),RIGHT
         LINE,AT(4688,-10,0,176),USE(?Line6:59),COLOR(COLOR:Black)
         STRING(@N6.2),AT(5313,0,469,156),USE(P23K),RIGHT
         STRING(@N-_7.2),AT(4740,0,469,156),USE(P22K),RIGHT
         LINE,AT(5260,-10,0,176),USE(?Line6:60),COLOR(COLOR:Black)
         STRING(@N-_9.2),AT(5865,0,521,156),USE(P24K),RIGHT
         LINE,AT(5833,-10,0,176),USE(?Line6:61),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(6448,0,469,156),USE(P25K),RIGHT
         STRING(@N_8.2),AT(7438,0,469,156),USE(P28K),TRN,RIGHT
         STRING('Kopâ'),AT(83,0,260,156),USE(?KOPA),TRN,RIGHT
         LINE,AT(1552,-10,0,176),USE(?Line6:632),COLOR(COLOR:Black)
         LINE,AT(6406,-10,0,176),USE(?Line6:30),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,176),USE(?Line6:62),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,176),USE(?Line6:63),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,176),USE(?Line6:34),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,PAGEAFTER(-1),AT(,-10,,250),USE(?unnamed:2)
         LINE,AT(52,0,0,62),USE(?Line125),COLOR(COLOR:Black)
         LINE,AT(365,0,0,62),USE(?Line126),COLOR(COLOR:Black)
         LINE,AT(1521,0,0,62),USE(?Line127),COLOR(COLOR:Black)
         LINE,AT(1552,0,0,62),USE(?Line127:3),COLOR(COLOR:Black)
         LINE,AT(2083,0,0,62),USE(?Line128),COLOR(COLOR:Black)
         LINE,AT(3125,0,0,62),USE(?Line129),COLOR(COLOR:Black)
         LINE,AT(2604,0,0,62),USE(?Line130),COLOR(COLOR:Black)
         LINE,AT(3625,0,0,62),USE(?Line131),COLOR(COLOR:Black)
         LINE,AT(4115,0,0,62),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(4688,0,0,62),USE(?Line133),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,62),USE(?Line134),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,62),USE(?Line135),COLOR(COLOR:Black)
         LINE,AT(6406,0,0,62),USE(?Line136),COLOR(COLOR:Black)
         LINE,AT(6927,0,0,62),USE(?Line137),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,62),USE(?Line140),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,62),USE(?Line141),COLOR(COLOR:Black)
         LINE,AT(938,0,0,62),USE(?Line127:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7865,0),USE(?Line142),COLOR(COLOR:Black)
         STRING('* - aprçíinâtais saskaòâ ar kalendâru,  pieòemts/atlaists, B-lapu;  faktiski pie' &|
             'lietotais var bût cits'),AT(73,83,5156,156),USE(?String2:72),TRN,CENTER
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

  DO CLEARALL
!  STOP(ROUND((B_DAT-S_DAT)/30,1)) IZSKATÂS,KA TAS B_DAT=31.MM.YYYY
!  IF ROUND((B_DAT-S_DAT)/30,1)+1=12
  IF MONTH(S_DAT)=1 AND ROUND((B_DAT-S_DAT)/30,1)=12 !VISS TEKOÐAIS GADS
     RPT_GADS=YEAR(B_DAT)
     KOREKCIJA#=0
  ELSIF YEAR(S_DAT)=YEAR(B_DAT) !TEKOÐAIS GADS
     RPT_GADS=FORMAT(S_DAT,@D13.)&'-'&FORMAT(B_DAT,@D13.)
     KOREKCIJA#=0
  ELSE
     RPT_GADS=FORMAT(S_DAT,@D13.)&'-'&FORMAT(B_DAT,@D13.)
     KOREKCIJA#=12-MONTH(S_DAT)+1
  .
  CLEAR(DA)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

!  IF ALGAS::Used = 0
!    CheckOpen(ALGAS,1)
!  END
!  ALGAS::Used += 1
!  IF ALGPA::USED=0
!     CHECKOPEN(ALGPA,1)
!  .
  ALGPA::USED+=1
  CHECKOPEN(KADRI,1)
  CHECKOPEN(KAD_RIK,1)
  CHECKOPEN(PERNOS,1)
  CHECKOPEN(ALGAS,1)
  CHECKOPEN(ALGPA,1)
  CHECKOPEN(DAIEV,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('F:NODALA',F:NODALA)
  BIND(ALG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Personîgie konti'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:ID=ID
      SET(ALG:ID_DAT,ALG:ID_DAT)
!      Process:View{Prop:Filter} = '~(F:NODALA and ~(ALG:NODALA=F:NODALA)) AND YEAR(ALG:YYYYMM)=RPT_GADS'
      Process:View{Prop:Filter} = '~(F:NODALA and ~(ALG:NODALA=F:NODALA)) AND INRANGE(ALG:YYYYMM,S_DAT,B_DAT)'
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
            SAV_ID=ALG:ID
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
      ELSE !WORD,EXCEL
          IF ~OPENANSI('A_PERSKONTI.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~(SAV_ID=ALG:ID)
           DO PRINT_ID
           SAV_ID=ALG:ID

        .
        M#=MONTH(ALG:YYYYMM)+KOREKCIJA#
        IF M#>12 THEN M#-=12.
!        IF M#<SM#
!          SM#=M#
!        .
!        DA[M#,1]=SUM(34)
        DA[M#,1]=ALG:N_Stundas
        DA[M#,2]=SUM(13)
        DA[M#,3]=SUM(12)
        DA[M#,4]=SUM(14)
        DA[M#,5]=SUM(15)+SUM(16)+SUM(29)  !BR&NS+CP1+CP2
        DA[M#,6]=SUM(4)
        DA[M#,7]=SUM(3)
        DA[M#,26]=SUM(57)                 !Dâvanas u.c neapliekamie
        DA[M#,8]=SUM(35)                  !Bruto ieòçmums
        DA[M#,9]=SUM(6)
!        DA[M#,10]=SUM(38)
        DA[M#,10]=CALCNEA(2,0,0)          !ATV.APGÂD.-LIKUMÂ NOTEIKTAIS F(KAL,PIE/ATL,BLAPA)
!        DA[M#,11]=SUM(39)
        DA[M#,11]=CALCNEA(3,0,0)          !ATV.INV/PRP.-LIKUMÂ NOTEIKTAIS F(KAL,PIE/ATL,BLAPA)
        DA[M#,27]=SUM(53)                 !Neapliekamie ieòçmumi
        DA[M#,12]=SUM(35)-DA[M#,27]-DA[M#,11]-DA[M#,10]-DA[M#,9]
!        DA[M#,13]=SUM(37)  !ðitik gudri nedrîkst taisît:Astarte
        DA[M#,13]=CALCNEA(1,0,0)
!        DA[M#,14]=DA[M#,12]-DA[M#,13]    20/08/02
        DA[M#,14]=sum(54)
        DA[M#,15]=SUM(21)+SUM(41)
        DA[M#,16]=SUM(22)
        DA[M#,17]=SUM(23)
        DA[M#,18]=SUM(6)
        DA[M#,19]=SUM(9)
        DA[M#,20]=SUM(7)+SUM(8)+SUM(55)+SUM(56)
        DA[M#,21]=SUM(25)
        DA[M#,22]=SUM(42)
        DA[M#,23]=SUM(26)+SUM(27)
        DA[M#,24]=SUM(28)
        DA[M#,25]=SUM(36)
        DA[M#,28]=ALG:IIN      !PÂRSKAITÎTS IIN
        NODALA[M#]=ALG:NODALA  !PAGAIDÂM NETIEK IZMANTOTS
        LAST_NODALA=ALG:NODALA !INFO_LINEI
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
     DO PRINT_ID
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
!  IF FilesOpened
!    ALGAS::Used -= 1
!    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
!    ALGPA::USED -= 1
!    IF ALGPA::USED = 0 THEN CLOSE(ALGPA).
!  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF ~F:DBF='W' THEN F:DBF='W'.
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
  IF ERRORCODE() OR (ID and ~ALG:ID=ID)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
  ?Progress:UserString{PROP:TEXT}=CLIP(RecordsProcessed)
  DISPLAY(?Progress:UserString)

!-----------------------------------------------------------------------------
PRINT_ID  ROUTINE
     DO CLEARALL
     VARUZVAR=GETKADRI(SAV_ID,2,1)
!    ***************** ID **********************
     IF F:DBF='W'
        PRINT(RPT:page_HEAD)
     ELSE !Word,Excel
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Personîgais konts '&CLIP(KAD:ID)
        ADD(OUTFILEANSI)
        OUTA:LINE='Taksâcijas gads: '&format(RPT_GADS,@N4)
        ADD(OUTFILEANSI)
        OUTA:LINE='Vârds, uzvârds: '&VARUZVAR
        ADD(OUTFILEANSI)
        OUTA:LINE='Personas kods: '&FORMAT(KAD:PERSKOD,@P######-#####P)
        ADD(OUTFILEANSI)
        OUTA:LINE='Dzîvesvietas adrese: '&KAD:PIERADR
        ADD(OUTFILEANSI)
        OUTA:LINE='Teritorijas kods: '&FORMAT(KAD:TERKOD,@N06)
        ADD(OUTFILEANSI)
        OUTA:LINE='Grâmatas(Kartes) Nr: '&KAD:KARTNR
        ADD(OUTFILEANSI)
     .
!    ***************** INFO_LINE **********************
     INFO_LINE='Amats: '&CLIP(GETKADRI(SAV_ID,0,11))&' Nodaïa: '&LAST_NODALA&' '&CLIP(GETNODALAS(LAST_NODALA,1))&' Pieòemts darbâ: '&FORMAT(GETKADRI(SAV_ID,0,12),@D06.B)
     IF GETKADRI(SAV_ID,0,7) > '0' !ATLAISTS
        INFO_LINE=CLIP(INFO_LINE)&' Atlaists: '&FORMAT(GETKADRI(SAV_ID,0,7),@D06.B)
     .
     IF F:DBF='W'
        PRINT(RPT:INFO_LINE)
     ELSE !Word,Excel
        OUTA:LINE=INFO_LINE
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
     .
     CLEAR(RIK:RECORD)
     RIK:ID=SAV_ID
     RIK:DATUMS=S_DAT
     SET(RIK:DAT_KEY,RIK:DAT_KEY)
     LOOP
        NEXT(KAD_RIK)
        IF ERROR() OR ~(RIK:ID=SAV_ID AND RIK:DATUMS<=B_DAT) THEN BREAK.
        I#=INSTRING(rik:tips,'KAC')
        !rik:tips='I'
        !rik:tips='B'
        IF I#
           EXECUTE I#
              INFO_LINE=FORMAT(RIK:DATUMS,@D06.)&' Rîkojums Nr '&FORMAT(RIK:DOK_NR,@N_4B)&' Kadri '&RIK:SATURS
              INFO_LINE=FORMAT(RIK:DATUMS,@D06.)&' Rîkojums Nr '&FORMAT(RIK:DOK_NR,@N_4B)&' Atvaïinâjums '&RIK:SATURS
              INFO_LINE=FORMAT(RIK:DATUMS,@D06.)&' Rîkojums Nr '&FORMAT(RIK:DOK_NR,@N_4B)&' '&RIK:SATURS
           .
           IF F:DBF='W'
              PRINT(RPT:INFO_LINE)
           ELSE !Word,Excel
              OUTA:LINE=INFO_LINE
              ADD(OUTFILEANSI)
           .
        .
     .
     CLEAR(PER:RECORD)
     PER:ID=SAV_ID
     PER:PAZIME='S'
!     PER:YYYYMM=DATE(1,1,RPT_GADS)
     SET(PER:ID_KEY,PER:ID_KEY)
     LOOP
        NEXT(PERNOS)
        IF ERROR() OR ~(PER:ID=SAV_ID) THEN BREAK.
        IF ~(INRANGE(PER:SAK_DAT,S_DAT,B_DAT) OR INRANGE(PER:BEI_DAT,S_DAT,B_DAT)) THEN CYCLE.
        INFO_LINE='Slimîbas lapa no '&FORMAT(PER:SAK_DAT,@D06.)&' lîdz '&FORMAT(PER:BEI_DAT,@D06.)&' A-lapa '&|
        PER:DIENAS&' dienas, vidçjâ '&PER:VSUMMA&', kopâ Ls '& PER:SUMMA
!        PER:DIENAS&' dienas, vidçjâ '&PER:VSUMMA&' kopâ Ls '& PER:SUMMA0+PER:SUMMA1+PER:SUMMA2+PER:SUMMAS+PER:SUMMAX
        IF F:DBF='W'
           PRINT(RPT:INFO_LINE)
        ELSE !Word,Excel
           OUTA:LINE=INFO_LINE
           ADD(OUTFILEANSI)
        .
     .
!    ***************** KASTE **********************
     IF F:DBF='W'
        PRINT(RPT:page_HEAD1)
     ELSIF F:DBF='E'
        OUTA:LINE='MM'&CHR(9)&'Nostr.'&CHR(9)&'Gabal-'&CHR(9)&'Laika'&CHR(9)&'Prçmija'&CHR(9)&|
        'Piem.'&CHR(9)&'Atv.'&CHR(9)&'Sli.'&CHR(9)&'Dâvanas'&CHR(9)&'Brutto'&CHR(9)&'VSA+'&|
        CHR(9)&'Apgâd.'&CHR(9)&'IN/PRP'&CHR(9)&'Neapl.'&CHR(9)&'Apliek.'&CHR(9)&'Neapl.'&|
        CHR(9)&'Ien.n/k '&CHR(9)&'Ien.,kas'&CHR(9)&'Pamat-'&CHR(9)&|
        'Papild-'&CHR(9)&'Valsts'&CHR(9)&'Avanss'&CHR(9)&'Izpildr.'&CHR(9)&'Pârmaksa'&|
        CHR(9)&'IEN/N'&CHR(9)&'IEN/N'&CHR(9)&'Kopâ'&CHR(9)&'Izmaksa.'&CHR(9)&|
        'Parâdi par'&CHR(9)&'Pârsk.'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'st.'&CHR(9)&'darbs'&CHR(9)&'darbs'&CHR(9)&CHR(9)&|
        CHR(9)&CHR(9)&CHR(9)&'u.c. neapl.'&CHR(9)&'ieòçmumi'&CHR(9)&'citi'&|
        CHR(9)&CHR(9)&CHR(9)&'ienâk.'&CHR(9)&'ienâk.'&CHR(9)&'minimums'&|
        CHR(9)&'rçíina ien./nod.'&CHR(9)&'jâpârrçí.pag/nâk.m.'&CHR(9)&'likme'&CHR(9)&|
        'likme'&CHR(9)&'soc.apdr.'&CHR(9)&CHR(9)&'u.c.'&CHR(9)&'/Parâds'&|
        CHR(9)&'pag.mçn.'&CHR(9)&'nâk.mçn.'&CHR(9)&CHR(9)&'bez soc.pab.'&CHR(9)&|
        'darba algu'&CHR(9)&'algas nod.'
        ADD(OUTFILEANSI)
     ELSE
        OUTA:LINE='Nor. per.'&CHR(9)&'Nostr. st.'&CHR(9)&'Gabal- darbs'&CHR(9)&'Laika darbs'&CHR(9)&'Prçmija'&CHR(9)&|
        'Piem.'&CHR(9)&'Atv.'&CHR(9)&'Sli.'&CHR(9)&'Dâvanas u.c. neapl.'&CHR(9)&'Brutto ieòçmumi'&CHR(9)&'VSA+ citi'&|
        CHR(9)&'Apgâd.'&CHR(9)&'IN/PRP'&CHR(9)&'Neapl. ienâk.'&CHR(9)&'Apliek. ienâk.'&CHR(9)&'Neapl. minimums'&|
        CHR(9)&'Ien.n/k rçíina ien./nod.'&CHR(9)&'Ien.,kas jâpârrçí. pag./nâk.m.'&CHR(9)&'Pamat- likme'&CHR(9)&|
        'Papild- likme'&CHR(9)&'Valsts soc. apdr.'&CHR(9)&'Avanss'&CHR(9)&'Izpildr. u.c.'&CHR(9)&'Pârmaksa /Parâds'&|
        CHR(9)&'IEN/N pag.mçn.'&CHR(9)&'IEN/N nâk.mçn.'&CHR(9)&'Kopâ'&CHR(9)&'Izmaksa bez soc.pab.'&CHR(9)&|
        'Parâdi par darba algu'&CHR(9)&'Pârsk. algas nod.'
        ADD(OUTFILEANSI)
     .

!    ***************** PIESKAITÎJUMI **********************
     LOOP I#=1 TO 12
        ME       = I#-KOREKCIJA#
        IF ME<1 THEN ME+=12.
        stu_dd   = DA[I#,1]
        p2       = DA[I#,2]
        p3       = DA[I#,3]
        p4       = DA[I#,4]
        p5       = DA[I#,5]
        p6       = DA[I#,6]
        PD       = DA[I#,26]
        p7       = DA[I#,7]
        p8       = DA[I#,8]
        p9       = DA[I#,9]
        P10      = DA[I#,10]
        P11      = DA[I#,11]
        PN       = DA[I#,27]  !NEAPLIEKAMIE IEÒÇMUMI
        IF DA[I#,12]<0 THEN DA[I#,12]=0.
        P12      = DA[I#,12]
        P13      = DA[I#,13]
        IF F:DBF='W' AND P8 THEN PRINT(RPT:DETAIL).    !PIESKAITÎJUMI
!        men_sk  += 1
        STU_DDK += STU_DD
        p2k     += p2
        p3k     += p3
        p4k     += p4
        p5k     += p5
        p6k     += p6
        PDK     += PD
        p7k     += p7
        p8k     += p8
        p9k     += p9
        p10k    += p10
        p11k    += p11
        PNK     += PN
        p12k    += p12
        p13k    += p13
!        IF I#>1 AND F:DBF='W' THEN PRINT(RPT:DETAILS). !PIESK.KOPÂ
     .
     IF F:DBF='W' THEN PRINT(RPT:DETAILS). !PIESK.KOPÂ
     IF F:DBF='W' THEN PRINT(RPT:page_HEAD2).    !IETURÇJUMI
!     ***************** PIESKAIT.14,15 UN IETUTRÇJUMI **********************
     LOOP I#=1 TO 12
        ME1      = I#-KOREKCIJA#
        IF ME1<1 THEN ME1+=12.
        P14   = DA[I#,14]
        P15      = DA[I#,15]
        p16      = DA[I#,16]
        p17      = DA[I#,17]
        p18      = DA[I#,18]
        p19      = DA[I#,19]
        p20      = DA[I#,20]
        p21      = DA[I#,21]
        p22      = DA[I#,22]
        p23      = DA[I#,23]
        p24      = DA[I#,24]
        IF DA[I#,25] > 0
           p25   = DA[I#,25]
           p26   = 0
        ELSE
           p25   = 0
           p26   = DA[I#,25]
        .
        p28      = DA[I#,28]
!        men_sk   = 0
        IF F:DBF='W' AND DA[I#,8] THEN PRINT(RPT:DETAIL2).     !IETURÇJUMI,DRUKÂ, JA IR IEÒÇMUMI
        p14k    += p14
        p16k    += p16
        p17k    += p17
        p18k    += p18
        p19k    += p19
        p20k    += p20
        p21k    += p21
        p22k    += p22
        p23k    += p23
        p24k    += p24
        p25k    += p25
        p28k    += p28
!        IF I#>1 AND F:DBF='W' THEN PRINT(RPT:DETAIL2S). !Starpsummas-IETURÇJUMI KOPÂ
        IF INSTRING(F:DBF,'AE') !ÐITIEM VISU DRUKÂJAM VIENÂ ÍESKÂ
           OUTA:LINE=FORMAT(ME1,@N2)&'.'&CHR(9)&FORMAT(DA[I#,1],@N3B)&CHR(9)&LEFT(FORMAT(DA[I#,2],@N_9.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,3],@N_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,4],@N-_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,5],@N-_9.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,6],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,7],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,26],@N_8.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,8],@N_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,9],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,10],@N_8.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,11],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,27],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,12],@N_9.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,13],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,14],@N_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,15],@N_8.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,16],@N-_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,17],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,18],@N_8.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,19],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,20],@N_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,21],@N-_8.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,22],@N-_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,23],@N_7.2))&CHR(9)&LEFT(FORMAT(DA[I#,24],@N-_9.2))&CHR(9)&|
           LEFT(FORMAT(DA[I#,25],@N_9.2))&CHR(9)&LEFT(FORMAT(DA[I#,26],@N_8.2))&CHR(9)&LEFT(FORMAT(DA[I#,28],@N_9.2))
           ADD(OUTFILEANSI)
!              IF I#>1
!                  OUTA:LINE=FORMAT(MEN_SK,@N2)&'K'&CHR(9)&FORMAT(STU_DDK,@N4B)&CHR(9)&FORMAT(P2K,@N_8.2)&CHR(9)&FORMAT(P3K,@N_8.2)&CHR(9)&FORMAT(P4K,@N-_8.2)&CHR(9)&FORMAT(P5K,@N-_8.2)&CHR(9)&FORMAT(P6K,@N_7.2)&CHR(9)&FORMAT(P7K,@N_7.2)&CHR(9)&FORMAT(PDK,@N_7.2)&CHR(9)&FORMAT(P8K,@N_9.2)&CHR(9)&FORMAT(P9K,@N_7.2)&CHR(9)&FORMAT(P10K,@N6.2)&CHR(9)&FORMAT(P11K,@N6.2)&CHR(9)&FORMAT(PNK,@N_7.2)&CHR(9)&FORMAT(P12K,@N_8.2)&CHR(9)&FORMAT(P13K,@N_6.2)&CHR(9)&FORMAT(P14K,@N_8.2)&CHR(9)&CHR(9)&FORMAT(P16K,@N-_8.2)&CHR(9)&FORMAT(P17K,@N7.2)&CHR(9)&FORMAT(P18K,@N7.2)&CHR(9)&FORMAT(P19K,@N_7.2)&CHR(9)&FORMAT(P20K,@N_8.2)&CHR(9)&FORMAT(P21K,@N-7.2)&CHR(9)&FORMAT(P22K,@N-_7.2)&CHR(9)&FORMAT(P23K,@N6.2)&CHR(9)&FORMAT(P24K,@N-_9.2)&CHR(9)&FORMAT(P25K,@N_9.2)&CHR(9)&CHR(9)&FORMAT(P28K,@N_8.2)
!                  ADD(OUTFILEANSI)
!              END
        .
     .
     IF F:DBF='W' THEN PRINT(RPT:DETAIL2S). !KOPÂ
     IF F:DBF='W' THEN PRINT(RPT:RPT_FOOT2).
!     men_sk1     = 0
!     M#=0
!     SM#=13                                      !RESET SÂKUMA MÇNESIS
     CLEAR(DA)
  ! Ieturçjumu daïâ vispâr neparâdâs piemaksas & pabalsti no soc. lîdz.

!-----------------------------------------------------------------------------
CLEARALL     ROUTINE
  stu_dd   = 0
  STU_DDK  = 0
  p2K      = 0
  p3K      = 0
  p4K      = 0
  p5K      = 0
  p6K      = 0
  p7K      = 0
  PDK      = 0
  p8K      = 0
  p9K      = 0
  p10K     = 0
  p11K     = 0
  PNK      = 0
  p12K     = 0
  p13K     = 0
  P14K     = 0
  p16K     = 0
  p17K     = 0
  p18K     = 0
  p19K     = 0
  p20K     = 0
  p21K     = 0
  p22K     = 0
  p23K     = 0
  p24K     = 0
  p25K     = 0
  p28K     = 0
