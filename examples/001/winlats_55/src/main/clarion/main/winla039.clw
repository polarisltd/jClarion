                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PZA                PROCEDURE                    ! Declare Procedure
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

CG                   STRING(10)
izl_tex              STRING(60)
IZLAISTAS_S          DECIMAL(13,2)   ! 6,7,8 BEZ VAI NEPAREIZIEM rindu kodiem
BKK_SUMMA            DECIMAL(13,2)
DAT                  DATE
LAI                  TIME
FILTRS_TEXT          STRING(100)

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA           DECIMAL(13,2)
SUMMAR          DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(8)
SUMMA           DECIMAL(13,2)
            .
I_TABLE     QUEUE,PRE(I)  !IZLAISTÂS SUMMAS
BKK             STRING(5)
SUMMA           DECIMAL(13,2)
            .
R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
CNTRL1               DECIMAL(13,2)
CNTRL1R              DECIMAL(11)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)

VIRSRAKSTS           STRING(45)
PP                   STRING(1)
S_SUMMA              STRING(15) !WMF
E_SUMMA              STRING(15) !EXCEL
E                    STRING(1)
RK_OK                BYTE


TEX:DUF              STRING(100)
XMLFILENAME          CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END


!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:OBJ_NR)
                    END

!-----------------------------------------------------------------------------
!report REPORT,AT(250,4508,8000,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
! Y+H max=11250
report REPORT,AT(250,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
HEADER DETAIL,AT(,,,4698),USE(?unnamed)
         STRING('(klasificçts pçc apgrozîjuma izmaksu metodes)'),AT(2135,3438,3542,260),USE(?S2),CENTER, |
             FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(1563,3698,4688,260),USE(VIRSRAKSTS),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(760,4052,6302,208),USE(FILTRS_TEXT),CENTER
         LINE,AT(156,4271,0,417),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(156,4271,7552,0),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(5000,4271,0,417),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(5521,4271,0,417),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(6615,4271,0,417),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Pârskata perioda'),AT(5552,4323,1042,156),USE(?S11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,4271,0,417),USE(?Line19:3),COLOR(COLOR:Black)
         STRING('Rindas'),AT(5010,4344,469,156),USE(?S9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Gada'),AT(6625,4313,1042,156),USE(?S13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Râdîtâja nosaukums'),AT(781,4427,3438,208),USE(?S6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(5552,4479,1042,156),USE(?S12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(5010,4500,469,156),USE(?S10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sâkumâ'),AT(6625,4469,1042,156),USE(?S14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(167,4688,7552,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('Apstiprinâjusi LR Finansu ministrija'),AT(6000,125),USE(?String103),RIGHT
         STRING(@s45),AT(1667,781,3854,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Vienotais reìistrâcijas Nr.'),AT(156,1094),USE(?String4),LEFT
         LINE,AT(1875,1042,1042,0),USE(?Line15:4),COLOR(COLOR:Black)
         STRING(@s11),AT(1979,1094,885,208),USE(gl:reg_nr,,?gl:reg_nr:2),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,1302,1042,0),USE(?Line15:5),COLOR(COLOR:Black)
         LINE,AT(1875,1354,0,260),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(3073,1354,0,260),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(1875,1354,1198,0),USE(?Line15:9),COLOR(COLOR:Black)
         STRING('PVN maksâtâja reì. Nr.'),AT(156,1406),USE(?String4:3),LEFT
         STRING(@s13),AT(1979,1406,1042,208),USE(gl:VID_NR),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,1615,1198,0),USE(?Line15:10),COLOR(COLOR:Black)
         STRING('Adrese'),AT(156,1771,521,208),USE(?String2),FONT(,,,,CHARSET:BALTIC)
         STRING('Tâlrunis'),AT(156,2063,521,208),USE(?String2:2),FONT(,,,,CHARSET:BALTIC)
         STRING('Fakss'),AT(2552,2063,469,208),USE(?String6),FONT(,,,,CHARSET:BALTIC)
         STRING(@s15),AT(3125,2063,1198,208),USE(SYS:FAX),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(1615,2385,1927,208),USE(GL:VID_NOS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_4),AT(1646,2667),USE(GL:NACE),TRN,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING('VID teritoriâlâ iestâde'),AT(156,2385,1354,208),USE(?String2:6),FONT(,,,,CHARSET:BALTIC)
         STRING('Pamatdarbîbas veids NACE'),AT(156,2688,1406,208),USE(?String2:4)
         STRING('Mçrvienîba : Ls'),AT(156,3125,990,208),USE(?String2:5),FONT(,,,,CHARSET:BALTIC)
         STRING('PEÏÒAS VAI ZAUDÇJUMU APRÇÍINS'),AT(2135,3177,3542,260),USE(?S1),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(990,2063,1198,208),USE(SYS:tel),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(990,1771,4635,208),USE(GL:ADRESE),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2917,1042,0,260),USE(?Line17:14),COLOR(COLOR:Black)
         LINE,AT(1875,1042,0,260),USE(?Line17:13),COLOR(COLOR:Black)
         STRING('(ar 2000. g. 5. janvâra likuma grozîjumiem)'),AT(5625,750),USE(?String103:4),RIGHT
         STRING('ceturkðòa pârskatiem'),AT(6656,542),USE(?String103:3),RIGHT
         STRING('Uzòçmuma nosaukums'),AT(156,833),USE(?String4:2),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING('1993. gada grâmatvedîbas'),AT(6396,333),USE(?String103:2),RIGHT
         STRING(@s1),AT(3333,260),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
       END
detail DETAIL,AT(,,,198),USE(?unnamed:2)
         LINE,AT(156,0,0,200),USE(?Line43:3),COLOR(COLOR:Black)
         STRING(@n3),AT(5031,21,469,167),USE(r:kods),CENTER
         LINE,AT(5521,0,0,200),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@S15),AT(5552,21,990,167),USE(S_SUMMA),RIGHT(3)
         STRING(@s100),AT(208,21,4740,170),USE(R_NOSAUKUMS),LEFT(1)
         LINE,AT(6615,0,0,200),USE(?Line1:31),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,200),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,200),USE(?Line1:2),COLOR(COLOR:Black)
       END
SVITRA DETAIL,AT(,,,0)
         LINE,AT(156,,7552,0),USE(?LineSVITRA),COLOR(COLOR:Black)
       END
DETAILBKK DETAIL,AT(,,,198),USE(?unnamed:3)
         STRING(@N-15.2B),AT(5604,21,938,167),USE(B:SUMMA),RIGHT(3)
         LINE,AT(7708,0,0,197),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(156,0,0,197),USE(?Line1B:11),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,200),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(5521,0,0,200),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(6615,0,0,200),USE(?Line1B:31),COLOR(COLOR:Black)
         STRING(@s5),AT(417,21,,156),USE(B_BKK)
         STRING(@s60),AT(990,21,3906,156),USE(B_NOSAUKUMS),LEFT
       END
HEADERIZL DETAIL,AT(,,,198),USE(?unnamed:5)
         LINE,AT(156,0,0,197),USE(?Line1I:11),COLOR(COLOR:Black)
         STRING(@s60),AT(521,21,3906,208),USE(izl_tex),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7708,0,0,197),USE(?Line1I:2),COLOR(COLOR:Black)
       END
DETAILIZL DETAIL,AT(,,,198),USE(?unnamed:4)
         STRING(@N-15.2B),AT(5604,21,938,167),USE(I:SUMMA),RIGHT(3)
         LINE,AT(7708,0,0,197),USE(?Line1I:14),COLOR(COLOR:Black)
         LINE,AT(156,0,0,197),USE(?Line11I:11),COLOR(COLOR:Black)
         STRING(@s5),AT(417,21,,156),USE(I:BKK)
         STRING(@s60),AT(990,21,3854,156),USE(I_NOSAUKUMS),LEFT
       END
FUTER  DETAIL,AT(,,,1292),USE(?unnamed:6)
         LINE,AT(3125,104,0,208),USE(?Line64:7),COLOR(COLOR:Black)
         LINE,AT(4156,104,0,208),USE(?Line64:9),COLOR(COLOR:Black)
         LINE,AT(4323,104,0,208),USE(?Line64:8),COLOR(COLOR:Black)
         LINE,AT(5365,104,0,208),USE(?Line64:10),COLOR(COLOR:Black)
         LINE,AT(5469,104,0,208),USE(?Line64:11),COLOR(COLOR:Black)
         LINE,AT(6510,104,0,208),USE(?Line64:12),COLOR(COLOR:Black)
         LINE,AT(3115,94,1042,0),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(4323,104,1042,0),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(5469,104,1042,0),USE(?Line63:2),COLOR(COLOR:Black)
         STRING('Revidents ir apstiprinâjis gada pârskatu :'),AT(354,125),USE(?String136)
         STRING('bez iebildumiem'),AT(3219,125),USE(?String137)
         STRING('ar iebildumiem'),AT(4469,125),USE(?String137:2)
         STRING('nav apstiprinâjis'),AT(5615,125),USE(?String139)
         LINE,AT(3125,313,1042,0),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(4323,313,1042,0),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(5469,313,1042,0),USE(?Line62:2),COLOR(COLOR:Black)
         STRING(@s25),AT(1927,802,2135,208),USE(SYS:AMATS1),RIGHT(2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4115,938,3490,0),USE(?Line70:2),COLOR(COLOR:Black)
         STRING(@s25),AT(4604,1010,1979,208),USE(SYS:PARAKSTS1,,?SYS:PARAKSTS1:2),CENTER,FONT(,8,,,CHARSET:BALTIC)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

!PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CheckOpen(KON_R,1)
  KON_R::Used += 1
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams fails '&CLIP(LONGPATH())&'\'&KONRNAME)
     DO PROCEDURERETURN
  .
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  .
  GGK::Used += 1
  FilesOpened = True

  VIRSRAKSTS=YEAR(S_DAT)&'.gada '&day(S_dat)&'.'&MENVAR(S_dat,2,1)&' - '&|
  YEAR(B_DAT)&'.gada '&day(B_dat)&'.'&MENVAR(B_dat,2,1)
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).

  CLEAR(KONR:RECORD)
  KONR:UGP='P'
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='P') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA=0
     ADD(R_TABLE)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

!****************************** 1. SOLIS ********************************
  BIND(GGK:RECORD)
  BIND(KON:RECORD)
  bind('b_dat',b_dat)
  bind('s_dat',s_dat)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Peïòas/Zaudçjumu aprçíins'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(ggk:RECORD)
     GGK:BKK='6'
     CG = 'K120011'
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
!     Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
        IF F:VALODA='1'  !ANGLISKI
!          SETTARGET(REPORT)
!          ?S1{Prop:Text}='PROFIT OR LOSS STATEMENT'
!          ?S2{Prop:Text}=''
!          ?S3{Prop:Text}='Period'
!!          ?S4{Prop:Text}='No'
!!          ?S5{Prop:Text}=''
!          ?S6{Prop:Text}='Special rate'
!!          ?S7{Prop:Text}='Note'
!!          ?S8{Prop:Text}=''
!          ?S9{Prop:Text}='Row'
!          ?S10{Prop:Text}='Code'
!          ?S11{Prop:Text}='End of the'
!          ?S12{Prop:Text}='period of account'
!          ?S13{Prop:Text}='Beginning of the'
!          ?S14{Prop:Text}='period of account'
        END
      ELSE           !RTF
        IF ~OPENANSI('PELNA.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        IF F:VALODA=0
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&E
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma nosaukums'&CHR(9)&CLIP(CLIENT)
            ADD(OUTFILEANSI)
            OUTA:LINE='Vienotais reìistrâcijas Nr.'&CHR(9)&GL:REG_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='PVN maksâtâja reì. Nr.'&CHR(9)&GL:VID_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='Adrese'&CHR(9)&CLIP(GL:adrese)
            ADD(OUTFILEANSI)
            OUTA:LINE='Tâlrunis'&CHR(9)&CLIP(SYS:TEL)
            ADD(OUTFILEANSI)
            OUTA:LINE='VID teritoriâlâ iestâde'&CHR(9)&CLIP(GL:VID_NOS)
            ADD(OUTFILEANSI)
            OUTA:LINE='Pamatdarbîbas veids NACE'&CHR(9)&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Mçrvienîba: Ls'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='PEÏÒAS VAI ZAUDÇJUMU APRÇÍINS'
            ADD(OUTFILEANSI)
            OUTA:LINE='(klasificçts pçc apgrozîjuma izmaksu metodes)'
            ADD(OUTFILEANSI)
            OUTA:LINE=VIRSRAKSTS
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            IF F:dbf='E'
                OUTA:LINE='Râdîtâja nosaukums'&CHR(9)&'Piezîmes Nr'&CHR(9)&'Rindas'&CHR(9)&'Pârskata perioda'&CHR(9)&'Gada'
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&'kods'&CHR(9)&'beigâs'&CHR(9)&'sâkumâ'
                ADD(OUTFILEANSI)
            ELSE
                OUTA:LINE='Râdîtâja nosaukums'&CHR(9)&'Piezîmes Nr'&CHR(9)&'Rindas kods'&CHR(9)&'Pârskata perioda beigâs'&CHR(9)&'Gada sâkumâ'
                ADD(OUTFILEANSI)
            END
        ELSE
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Registration Nr. '&CHR(9)&GL:REG_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='VAT Registration Nr. '&CHR(9)&GL:VID_NR
            ADD(OUTFILEANSI)
            OUTA:LINE='Address'&CHR(9)&CLIP(GL:adrese)
            ADD(OUTFILEANSI)
            OUTA:LINE='Phone number'&CHR(9)&CLIP(SYS:TEL)
            ADD(OUTFILEANSI)
            OUTA:LINE='Branch NACE'&CHR(9)&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='PROFIT OR LOSS STATEMENT'
            ADD(OUTFILEANSI)
            OUTA:LINE=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            IF F:DBF='E'
                OUTA:LINE='No'&CHR(9)&'Special Rate'&CHR(9)&'Note'&CHR(9)&'Row'&CHR(9)&'At the end of the'&CHR(9)&|
                'At the beginning of the'
                ADD(OUTFILEANSI)
                OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'code'&CHR(9)&'period of accountant'&CHR(9)&'period of accountant'
                ADD(OUTFILEANSI)
            ELSE
                OUTA:LINE='No'&CHR(9)&'Special Rate'&CHR(9)&'Note'&CHR(9)&'Row code'&CHR(9)&|
                'At the end of the period of accountant'&CHR(9)&'At the beginning of the period of accountant'
                ADD(OUTFILEANSI)
            END
        END
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\UGP_UZ_2006_PZA2.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
        .
      .
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
       IF ~CYCLEGGK(CG) AND ~(GGK:U_NR=1) !~SALDO
          IF ~GETKON_K(ggk:BKK,2,1,FORMAT(GGK:DATUMS,@D6.)&' U_Nr='&GGK:U_NR)
             DO PROCEDURERETURN
          .
          IF INSTRING(KON:BKK[1],'678',1) AND ~(GGK:BKK[1:3]='861') !IR OPERÂCIJU KONTS UN NAV PEÏÒA/ZAUDÇJUMI
             nk#+=1
             ?Progress:UserString{Prop:Text}=NK#
             DISPLAY(?Progress:UserString)
             RK_OK=FALSE
             LOOP J# = 1 TO 3
                IF kon:PZB[J#]
                   R:KODS=kon:PZB[J#]
                   GET(R_TABLE,R:KODS)
                   IF ERROR()
                      KLUDA(71,'WWW.VID.GOV.LV PZA2 :'&kon:PZB[J#]&' kontam '&KON:BKK)
                   ELSE
                      RK_OK=TRUE
                      IF GGK:D_K='D'
                         R:SUMMA+=GGK:SUMMA
                      ELSE
                         R:SUMMA-=GGK:SUMMA
                      .
                      PUT(R_TABLE)
                      IF F:DTK  !IZVÇRSTÂ VEIDÂ
                         B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_3)
                         GET(B_TABLE,B:BKK_KODS)
                         IF ERROR()
                            IF GGK:D_K='D'
                               B:SUMMA=GGK:SUMMA
                            ELSE
                               B:SUMMA=-GGK:SUMMA
                            .
                            ADD(B_TABLE)
                            SORT(B_TABLE,B:BKK_KODS)
                         ELSE
                            IF GGK:D_K='D'
                               B:SUMMA+=GGK:SUMMA
                            ELSE
                               B:SUMMA-=GGK:SUMMA
                            .
                            PUT(B_TABLE)
                         .
                      .
                   .
                .
             .
             IF RK_OK=FALSE
                 IZLAISTAS_S+= GGK:SUMMA
                 I:BKK=GGK:BKK
                 GET(I_TABLE,I:BKK)
                 IF ERROR()
                    I:SUMMA=GGK:SUMMA
                    ADD(I_TABLE)
                    SORT(I_TABLE,I:BKK)
                 ELSE
                    I:SUMMA+=GGK:SUMMA
                    PUT(I_TABLE)
                 .
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

!****************************** 2. SOLIS ********************************
  IF F:DBF = 'W'
     PRINT(RPT:HEADER)
  ELSE
     OUTA:LINE=CLIENT
     ADD(OUTFILE)
  .
  DO FILL_R_TABLE !AIZPILDA VISAS STARPSUMMAS UN PÂRBAUDA APAÏOJUMUS
  GET(R_TABLE,0)
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF F:VALODA=1 !ANGLISKI
        R_NOSAUKUMS=GETKON_R('P',R:KODS,0,2)
     ELSE
        R_NOSAUKUMS=GETKON_R('P',R:KODS,0,1)
     .
     IF R:KODS=10 OR R:KODS=30  OR R:KODS=60  OR R:KODS=70  OR R:KODS=80 OR|
        R:KODS=90 OR R:KODS=120 OR R:KODS=130 OR R:KODS=140 OR R:KODS=150 OR R:KODS=180
        R:SUMMA =-R:SUMMA                       !MAINAM ZÎMI IZDRUKAI
        R:SUMMAR=-R:SUMMAR
     .
     IF F:NOA   !LS BEZ SANTÎMIEM
        S_SUMMA=FORMAT(R:SUMMAR,@N-15)        !WMF
        E_SUMMA=LEFT(FORMAT(R:SUMMAR,@N-_15)) !WORD,EXCEL
     ELSE
        S_SUMMA=FORMAT(R:SUMMA,@N-15.2)
        E_SUMMA=LEFT(FORMAT(R:SUMMA,@N-_15.2))
     .
     IF R:KODS=180 AND R:SUMMA<0
        IF F:VALODA=1 !ANGLISKI
           R_NOSAUKUMS='19. LOSS'
        ELSE
           R_NOSAUKUMS='19. Pârskata perioda zaudçjumi'
        .
     ELSIF R:KODS=180 AND R:SUMMA>0
        IF F:VALODA=1 !ANGLISKI
           R_NOSAUKUMS='19. PROFIT'
        ELSE
           R_NOSAUKUMS='19. Pârskata perioda peïòa'
        .
     .
     IF F:DBF = 'W'
        PRINT(RPT:DETAIL)                     
        IF F:DTK AND ~(R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180) !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 PRINT(RPT:DETAILBKK)                     
              .
           .
        .
        PRINT(RPT:SVITRA)                                 
     ELSE !WORD,EXCEL
        OUTA:LINE=CLIP(R_NOSAUKUMS)&CHR(9)&PP&CHR(9)&R:KODS&CHR(9)&E_SUMMA
        ADD(OUTFILEANSI)
        IF F:DTK AND ~(R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180) !IZVÇRSTÂ VEIDÂ
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 OUTA:LINE=B_BKK&CHR(9)&CLIP(B_NOSAUKUMS)&CHR(9)&CHR(9)&LEFT(FORMAT(B:SUMMA,@N-_15.2))
                 ADD(OUTFILEANSI)
              .
           .
        .
     .
     IF F:XML_OK#=TRUE
        XML:LINE='<<Row>'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="tabula" value="2" />'   !2-PZA2
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="rinda" value="'&CLIP(R:KODS)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iepr_vert" value="0" />'   !?
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="vertiba" value="'&CLIP(R:SUMMAR)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</Row>'
        ADD(OUTFILEXML)
     .
  .

!  IF B_DAT=DATE(12,31,GADS)
!     IF ~IZLAISTAS_S                              ! PZA OK.
!        IF ~BAND(SYS:control_byte,00000001b)      ! nebija OK
!           SYS:control_byte += 1
!           PUT(SYSTEM)
!        .
!     ELSE                                         ! PZA NAV OK.
!        IF BAND(SYS:control_byte,00000001b)       ! bija OK
!           SYS:control_byte -= 1
!           PUT(SYSTEM)
!        .
!     .
!  .
  IF IZLAISTAS_S
     IZL_TEX='Kïûda kontu plânâ : izlaistas summas par Ls '&IZLAISTAS_S
     PRINT(RPT:HEADERIZL)
     IF F:DTK  !IZVÇRSTÂ VEIDÂ
        LOOP J#= 1 TO RECORDS(I_TABLE)
           GET(I_TABLE,J#)
           I_NOSAUKUMS=GETKON_K(I:BKK,0,2)
           PRINT(RPT:DETAILIZL)
        .
        PRINT(RPT:SVITRA)
     .
  ELSE
     IZL_TEX=''
  .

  IF F:DBF = 'W'
     PRINT(RPT:FUTER)
  ELSE
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     OUTA:LINE=' Revidents ir apstiprinâjis gada pârskatu: bez iebildumiem;  ar iebildumiem;  nav apstiprinâjis'
     ADD(OUTFILEANSI)
     OUTA:LINE=IZL_TEX
     ADD(OUTFILEANSI)
     OUTA:LINE=''
     ADD(OUTFILEANSI)
     OUTA:LINE='Vadîtâjs (îpaðnieks):______________________________'
     ADD(OUTFILEANSI)
  .
  IF F:XML_OK#=TRUE
     CLOSE(OUTFILEXML)
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    endpage(Report)
    pr:skaits=2
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

!------------------------------------------------------------------------
ProcedureReturn ROUTINE
  free(PrintPreviewQueue)
  free(PrintPreviewQueue1)
  FREE(R_TABLE)
  FREE(B_TABLE)
  FREE(I_TABLE)
  CLOSE(REPORT)
  KON_R::Used -= 1
  IF KON_R::Used = 0 THEN CLOSE(KON_R).
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  .
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN

!------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!------------------------------------------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
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

!------------------------------------------------------------------------
FILL_R_TABLE ROUTINE
  LOOP I#=1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF R:KODS=30 OR R:KODS=120 OR R:KODS=150 OR R:KODS=180 !STARPSUMMAS
        R:SUMMA =CNTRL1
        R:SUMMAR=CNTRL1R
     ELSE
        R:SUMMAR=ROUND(R:SUMMA,1)
        CNTRL1 +=R:SUMMA
        CNTRL1R+=R:SUMMAR
     .
     PUT(R_TABLE)
  .
  IF F:NOA AND R:KODS=180
     DELTA#=R:SUMMAR-ROUND(R:SUMMA,1)
     IF DELTA#
        KLUDA(0,'Summçjot pçc noapaïoðanas 180R='&CLIP(R:SUMMAR)&',jâbût '&CLIP(ROUND(R:SUMMA,1))&' izlîdzinu uz 160R',2,1)
        IF KLU_DARBIBA
           R:SUMMAR-=DELTA#
           PUT(R_TABLE)
           LOOP I#=1 TO RECORDS(R_TABLE)
              GET(R_TABLE,I#)
              IF R:KODS=160 !UIN
                 R:SUMMAR-=DELTA#
                 PUT(R_TABLE)
                 BREAK
              .
           .
        .
     .
  .


B_Bilance            PROCEDURE                    ! Declare Procedure
LocalRequest         LONG,AUTO
LocalResponse        LONG,AUTO
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
RejectRecord         LONG
OriginalRequest      LONG

CG                   STRING(10)
DAT                  DATE
LAI                  TIME

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
SUMMA0          DECIMAL(13,2)
SUMMA           DECIMAL(13,2)
SUMMAR0         DECIMAL(11)
SUMMAR          DECIMAL(11)
            .
B_TABLE     QUEUE,PRE(B)
BKK_KODS        STRING(8)
SUMMA           DECIMAL(13,2)
            .
!I_TABLE     QUEUE,PRE(I)
!BKK             STRING(5)
!DATUMS          LONG
!SUMMA           DECIMAL(13,2)
!            .

R_NOSAUKUMS          LIKE(KONR:NOSAUKUMS)
B_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
B_BKK                STRING(5)
I_NOSAUKUMS          LIKE(KON:NOSAUKUMS)
CNTRL1               DECIMAL(13,2)
CNTRL2               DECIMAL(13,2)
CNTRL3               DECIMAL(13,2)
CNTRL10              DECIMAL(13,2)
CNTRL20              DECIMAL(13,2)
CNTRL30              DECIMAL(13,2)
CNTRLR1              DECIMAL(11)
CNTRLR2              DECIMAL(11)
CNTRLR3              DECIMAL(11)
CNTRLR4              DECIMAL(11)
CNTRLR10             DECIMAL(11)
CNTRLR20             DECIMAL(11)
CNTRLR30             DECIMAL(11)
CNTRLR40             DECIMAL(11)
NOLIDZ               STRING(30)
S_SUMMA              STRING(15)  !WMF
S_SUMMA0             STRING(15)
E_SUMMA              STRING(15)  !EXCEL
E_SUMMA0             STRING(15)
E                    STRING(1)
CNTRL                DECIMAL(13,2)

TEX:DUF         STRING(100)
XMLFILENAME         CSTRING(200),STATIC
XMLSFILENAME        CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END
OUTFILEXMLS  FILE,DRIVER('ASCII'),NAME(XMLSFILENAME),PRE(XMLS),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

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
report REPORT,AT(100,200,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
TIT_List DETAIL,AT(,,,9250),USE(?RPT:TIT_List)
         STRING(@s1),AT(7188,313),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:ANSI)
         STRING('Uzòçmuma  nosaukums'),AT(417,2531),USE(?String375),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ'),AT(417,3063),USE(?String375:3), |
             LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Darbinieku skaits'),AT(417,3302),USE(?String375:7),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s4),AT(2760,3302,417,208),USE(PAR_GRUPA),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatdarbîbas veids NACE'),AT(427,3573),USE(?String375:2),TRN,LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@n_4),AT(2760,3573,417,208),USE(GL:NACE),TRN,LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas periods'),AT(417,4438,1458,208),USE(?String375:8),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s30),AT(2760,4427,2552,208),USE(nolidz),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('B I L A N C E'),AT(2833,6146,2240,365),USE(?String377),CENTER,FONT(,26,,FONT:bold,CHARSET:BALTIC)
         STRING('Iesniegðanas datums'),AT(4375,8177,1448,240),USE(?String381),LEFT,FONT(,11,,,CHARSET:BALTIC)
         LINE,AT(5833,8438,1719,0),USE(?Line40),COLOR(COLOR:Black)
         STRING('Saòemðanas datums'),AT(4375,8698,1458,240),USE(?String381:2),LEFT,FONT(,11,,,CHARSET:BALTIC)
         LINE,AT(5833,8958,1719,0),USE(?Line40:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2750,2531,4271,208),USE(CLIENT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(2750,2802,5104,208),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese'),AT(417,2813),USE(?String375:4),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s11),AT(4688,3063),USE(gl:reg_nr),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
       END
AKTIVS DETAIL,PAGEBEFORE(-1),AT(,,8000,260),USE(?unnamed:5)
         STRING('Slçgums'),AT(5865,63,938,188),USE(?FB),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6854,63,938,188),USE(?BB),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,0,0,260),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('AKTÎVS'),AT(1156,63,3385,190),USE(?client:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,260),USE(?Line2),COLOR(COLOR:Black)
       END
AKTIVSA DETAIL,PAGEBEFORE(-1),AT(,,8000,260)
         STRING('Final balance'),AT(5865,63,938,188),USE(?FB:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beginning b.'),AT(6854,63,938,188),USE(?BB:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5833,0,0,260),USE(?Line2A:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2A:4),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2A:5),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2A:2),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1A),COLOR(COLOR:Black)
         STRING('A S S E T S'),AT(1115,52,3438,208),USE(?ASSES:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,260),USE(?Line2A),COLOR(COLOR:Black)
       END
VIRSRAKSTSB DETAIL,AT(,,8000,198)
         LINE,AT(156,0,0,197),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s100),AT(198,10,5208,156),USE(R_NOSAUKUMS,,?V_NOSAUKUMS:4),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5417,0,0,197),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,197),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,197),USE(?Line2:10),COLOR(COLOR:Black)
       END
VIRSRAKSTS DETAIL,AT(,,8000,198)
         LINE,AT(156,0,0,197),USE(?Line2V:6),COLOR(COLOR:Black)
         STRING(@s100),AT(198,10,5208,156),USE(R_NOSAUKUMS),LEFT,FONT(,9,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5417,0,0,197),USE(?Line2V:7),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,197),USE(?Line2V:8),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,197),USE(?Line2V:9),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,197),USE(?Line2V:10),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,,156)
         STRING(@s3),AT(5521,5,260,140),USE(R:KODS),CENTER,FONT(,9,,)
         STRING(@S15),AT(5865,5,938,135),USE(S_SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S15),AT(6854,5,938,135),USE(S_SUMMA0),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(156,0,0,156),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,156),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,156),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,156),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,156),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@s100),AT(198,5,5208,140),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2),LEFT(1)
       END
DETAILB DETAIL,AT(,,,177)
         STRING(@s3),AT(5521,5,260,150),USE(R:KODS,,?R:KODS:B),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(5865,5,938,156),USE(S_SUMMA,,?S_SUMMA:B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(6854,5,938,156),USE(S_SUMMA0,,?S_SUMMA0:B),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,0,177),USE(?Line2B:11),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,177),USE(?Line2B:12),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,177),USE(?Line2B:13),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,177),USE(?Line2B:14),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,177),USE(?Line2B:15),COLOR(COLOR:Black)
         STRING(@s100),AT(198,5,5208,150),USE(R_NOSAUKUMS,,?R_NOSAUKUMS:2B),LEFT(1),FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
DETAILBKK DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(156,0,0,177),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s50),AT(1042,10,4271,150),USE(KON:NOSAUKUMS),LEFT
         STRING(@s5),AT(521,10,417,150),USE(KON:BKK),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5417,0,0,177),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,177),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,177),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,177),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5885,10,,150),USE(B:SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
       END
SVITRA DETAIL,AT(,,,104)
         LINE,AT(156,0,0,104),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,104),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,104),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,104),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,104),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0)
         LINE,AT(156,,7656,0),USE(?Line1L:2),COLOR(COLOR:Black)
       END
PAGE_FOOT DETAIL,AT(,,,115)
         LINE,AT(156,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,62),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,62),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,62),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,62),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(156,0,0,62),USE(?Line2:25),COLOR(COLOR:Black)
       END
PASIVS DETAIL,PAGEBEFORE(-1),AT(,,,260),USE(?unnamed)
         LINE,AT(156,0,0,260),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2:31),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,260),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2:33),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2:34),COLOR(COLOR:Black)
         STRING('PASÎVS'),AT(208,52,5208,208),USE(?client:8),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Slçgums'),AT(5885,52,938,208),USE(?client:7),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkums'),AT(6875,52,938,208),USE(?client:6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
PASIVSA DETAIL,PAGEBEFORE(-1),AT(,,,260)
         LINE,AT(156,0,0,260),USE(?Line2A:30),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,260),USE(?Line2A:31),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,260),USE(?Line2A:32),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line2A:33),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line2A:34),COLOR(COLOR:Black)
         STRING('L I A B I L I T I E S'),AT(208,52,5208,208),USE(?LA:8),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Final balance'),AT(5885,52,938,208),USE(?FB:7),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Beginning b.'),AT(6875,52,938,208),USE(?BB:6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,0,7656,0),USE(?Line1A:4),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,406),USE(?unnamed:2)
         LINE,AT(156,0,0,62),USE(?Line2:40),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,62),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,62),USE(?Line2:36),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,62),USE(?Line2:37),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,62),USE(?Line2:38),COLOR(COLOR:Black)
         LINE,AT(156,52,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('RC :'),AT(167,73),USE(?String31),FONT(,6,,,CHARSET:ANSI)
         STRING(@s1),AT(354,73,167,135),USE(RS),CENTER,FONT(,6,,,CHARSET:ANSI)
         STRING(@D06.),AT(6677,73,625,156),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7313,73,521,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(1010,135),USE(SYS:AMATS1),TRN,RIGHT
         STRING(@s25),AT(4969,135),USE(SYS:PARAKSTS1),TRN,LEFT
         STRING('_{38}'),AT(2583,250),USE(?String35),TRN
       END
       FOOTER,AT(100,11200,8000,156),USE(?unnamed:4)
         STRING(@P<<<#. lapaP),AT(7240,10,573,156),PAGENO,USE(?PageCount),RIGHT
       END
     END

!       FOOTER,AT(100,11200,8000,156),USE(?unnamed:4)
!         LINE,AT(156,0,7656,0),USE(?Line1:6),COLOR(COLOR:Black)
!         STRING(@P<<<#. lapaP),AT(7240,10,573,156),PAGENO,USE(?PageCount),RIGHT
!       END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,152,63),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(KON_R,1)
  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams fails KON_R...')
     DO PROCEDURERETURN
  .
  CLEAR(KONR:RECORD)
  KONR:UGP='B'
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='B') THEN BREAK.
     R:KODS=KONR:KODS
     R:SUMMA0=0  !SÂKUMA BILANCE
     R:SUMMA=0   !SLÇGUMA BILANCE
     ADD(R_TABLE)
  .

  IF KON_K::USED=0
     CHECKOPEN(KON_K,1)
  .
  KON_K::Used += 1
  IF GG::USED=0
     CHECKOPEN(GG,1)
  .
  GG::Used += 1
  IF GGK::USED=0
     CHECKOPEN(GGK,1)
  .
  GGK::Used += 1
  BIND(GGK:RECORD)
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
  ProgressWindow{Prop:Text} = 'Bilance'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(GGK:RECORD)
     CG = 'K120000'
!          1234567
     NOLIDZ='no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
     Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
     DAT = TODAY()
     LAI = CLOCK()
      IF F:DBF='W'   !WMF
         OPEN(report)
         report{Prop:Preview} = PrintPreviewImage
         SETTARGET(REPORT,?rpt:TIT_List)
         IMAGE(188,281,2083,521,'USER.BMP')
         print(rpt:TIT_List)
      ELSE           !Word,Excel
        IF ~OPENANSI('BILANCE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        IF F:VALODA=0
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma  nosaukums '&CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Adrese '&GL:ADRESE
            ADD(OUTFILEANSI)
            OUTA:LINE='Uzòçmuma reìistrâcijas numurs Nodokïu maksâtâju reìistrâ '&gl:reg_nr
            ADD(OUTFILEANSI)
            IF GL:VID_NR
               OUTA:LINE='Uzòçmuma reìistrâcijas numurs PVN apliekamo personu reìistrâ '&GL:VID_NR
            .
            ADD(OUTFILEANSI)
            OUTA:LINE='Darbinieku skaits '&PAR_GRUPA
            ADD(OUTFILEANSI)
            OUTA:LINE='Pamatdarbîbas veids NACE '&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Taksâcijas periods '&NOLIDZ
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='                 BILANCE'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
        ELSE
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE=CLIENT
            ADD(OUTFILEANSI)
            OUTA:LINE='Address '&GL:ADRESE
            ADD(OUTFILEANSI)
            OUTA:LINE='Registration Nr '&gl:reg_nr
            ADD(OUTFILEANSI)
            IF GL:VID_NR
               OUTA:LINE='VAT Registration Nr '&GL:VID_NR
            .
            ADD(OUTFILEANSI)
            OUTA:LINE='Emploies '&PAR_GRUPA
            ADD(OUTFILEANSI)
            OUTA:LINE='Branch NACE '&GL:NACE
            ADD(OUTFILEANSI)
            OUTA:LINE='Period '&NOLIDZ
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
            OUTA:LINE='                 BALANCE'
            ADD(OUTFILEANSI)
            OUTA:LINE=''
            ADD(OUTFILEANSI)
        .
      .
      IF F:XML !EDS
        XMLFILENAME=USERFOLDER&'\UGP_UZ_2006.DUF'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
           E='E'
           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
           ADD(OUTFILEXML)
           XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
           ADD(OUTFILEXML)
           XML:LINE='<<DeclarationFile type="ugp_uz_2006">'
           ADD(OUTFILEXML)
           XML:LINE='<<Declaration>'
           ADD(OUTFILEXML)
    
           XML:LINE='<<DeclarationHeader>'
           ADD(OUTFILEXML)
           IF ~GL:REG_NR THEN KLUDA(87,'Jûsu NMR kods').
           XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
           ADD(OUTFILEXML)
!           XML:LINE='<<Field name="ur_numurs" value="'&GL:REG_NR&'" />'
!           ADD(OUTFILEXML)
           TEX:DUF=CLIENT
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           TEX:DUF=GL:ADRESE
           DO CONVERT_TEX:DUF
           XML:LINE='<<Field name="adrese" value="'&CLIP(TEX:DUF)&'" />'
           ADD(OUTFILEXML)
           IF PAR_GRUPA<1 THEN KLUDA(27,'darbinieku skaits').
           XML:LINE='<<Field name="darbinieki" value="'&CLIP(PAR_GRUPA)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="telefons" value="'&CLIP(SYS:TEL)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="datums_aizp" value="'&FORMAT(TODAY(),@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="datums_iesn" value="'&FORMAT(TODAY(),@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="konsolidets" value="0" />'   !?
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="taks_no" value="'&FORMAT(S_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="taks_lidz" value="'&FORMAT(B_DAT,@D06.)&'" />'
           ADD(OUTFILEXML)
           IF B_DAT > TODAY() THEN KLUDA(27,'taksâcijas periods').
           XML:LINE='<<Field name="shema" value="PZA2" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="npp" value="NPP2" />'
           ADD(OUTFILEXML)
           XML:LINE='<<Field name="sleg_bilance" value="0" />'   !?
           ADD(OUTFILEXML)
           XML:LINE='<</DeclarationHeader>'
           ADD(OUTFILEXML)

           XMLSFILENAME=USERFOLDER&'\UGP_UZ_2006_PZA2.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (PEÏÒAS/ZAUDÇJUMU APRÇÍINS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
           XMLSFILENAME=USERFOLDER&'\UGP_UZ_2006_NPP2.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (NAUDAS PLÛSMAS PÂRSKATS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
           XMLSFILENAME=USERFOLDER&'\UGP_UZ_2006_PKIP.XML'
           OPEN(OUTFILEXMLS,18)
           IF ERROR()
              KLUDA(0,'Nav pieejams fails '&CLIP(XMLSFILENAME)&' (PAÐU KAPITÂLA IZMAIÒU PÂRSKATS)')
           ELSE
              SET(OUTFILEXMLS)
              LOOP
                 NEXT(OUTFILEXMLS)
                 IF ERROR() THEN BREAK.
                 XML:LINE=XMLS:LINE
                 ADD(OUTFILEXML)
              .
              CLOSE(OUTFILEXMLS)
           .
        .
      .
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
        IF GETKON_K(GGK:BKK,3,1)
           LOOP J# = 1 TO 4
              IF kon:PZB[J#]
                 R:KODS=kon:PZB[J#]
                 GET(R_TABLE,R:KODS)
                 IF ERROR()
                    KLUDA(71,' WWW.VID.GOV.LV BILA :'&kon:PZB[J#])
                 ELSE
                    IF GGK:D_K='D'
                       R:SUMMA+=GGK:SUMMA
                       IF GGK:U_NR=1 THEN R:SUMMA0+=GGK:SUMMA.
                    ELSE
                        R:SUMMA-=GGK:SUMMA
                        IF GGK:U_NR=1 THEN R:SUMMA0-=GGK:SUMMA.
                    .
                    PUT(R_TABLE)
                    IF F:DTK  !IZVÇRSTÂ VEIDÂ
                       B:BKK_KODS=GGK:BKK&FORMAT(R:KODS,@N_3)
                       GET(B_TABLE,B:BKK_KODS)
                       IF ERROR()
                          IF GGK:D_K='D'
                             B:SUMMA=GGK:SUMMA
                          ELSE
                             B:SUMMA=-GGK:SUMMA
                          .
                          ADD(B_TABLE)
                          SORT(B_TABLE,B:BKK_KODS)
                       ELSE
                          IF GGK:D_K='D'
                             B:SUMMA+=GGK:SUMMA
                          ELSE
                             B:SUMMA-=GGK:SUMMA
                          .
                          PUT(B_TABLE)
                       .
                    .
                 .
              .
           .
        ELSE    ! KONTA NAV VISPAR
           KLUDA(0,'Kontu plânâ nav atrodams: '&ggk:bkk&' U_nr='&GGK:U_NR&' no '&FORMAT(GGK:DATUMS,@D06.))
           CLOSE(ProgressWindow)
           CLOSE(report)
           DO PROCEDURERETURN
        .
        LOOP
          DO GetNextRecord
          DO ValidateRecord
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:Ok
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          Localresponse = RequestCompleted
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
     CASE EVENT()
     OF Event:Accepted
       LocalResponse = RequestCancelled
       POST(Event:CloseWindow)
     END
   END
  END

  IF F:VALODA=1 !ANGLISKI
     IF F:DBF = 'W'
        print(RPT:AKTIVSA)
        print(RPT:SVITRA)
     ELSE
        OUTA:LINE='A S S E T S'&CHR(9)&'CODE'&CHR(9)&'FINAL BALANCE'&CHR(9)&'BEGINNING BALANCE'
        ADD(OUTFILEANSI)
     .
  ELSE
     IF F:DBF = 'W'
        print(RPT:AKTIVS)
        print(RPT:SVITRA)
     ELSE
        OUTA:LINE=' AKTÎVS'&CHR(9)&'Kods'&CHR(9)&'Slçgums'&CHR(9)&'Sâkums'
        ADD(OUTFILEANSI)
     .
  .
!------------------
  DO FILL_R_TABLE
!------------------
  LOOP I#= 1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     V#=INSTRING(FORMAT(R:KODS,@N03),'010210430540580',3)  !PIRMS ÐITIEM LIELAIS VIRSRAKSTS
     IF V#
        IF F:VALODA=1 !ANGLISKI
           EXECUTE V#
              R_NOSAUKUMS='1.LONG-TERM INVESTMENTS'
              R_NOSAUKUMS='2.CURRENT ASSETS'
              R_NOSAUKUMS='1.EQUITY CAPITAL'
              R_NOSAUKUMS='2.STOCKPILES'
              R_NOSAUKUMS='3.CREDITORS'
           .
        ELSE
           EXECUTE V#
              R_NOSAUKUMS='1. Ilgtermiòa ieguldîjumi'
              R_NOSAUKUMS='2. Apgrozâmie lîdzekïi'
              R_NOSAUKUMS='1. Paðu kapitâls'
              R_NOSAUKUMS='2. Uzkrâjumi'
              R_NOSAUKUMS='3. Kreditori'
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:VIRSRAKSTSB)
        ELSE
           OUTA:LINE=R_NOSAUKUMS
           ADD(OUTFILEANSI)
        .
     .
     V#=INSTRING(FORMAT(R:KODS,@N03),'010060110210280360460580650',3)  !PIRMS ÐITIEM MAZAIS VIRSRAKSTS
     IF V#
        IF F:VALODA=1 !ANGLISKI
           EXECUTE V#
              R_NOSAUKUMS='I.INTANGIBLE INVESTMENTS'
              R_NOSAUKUMS='II.FIXED ASSETS'
              R_NOSAUKUMS='III.LONG=TERM FINANCIAL INVESTMENTS'
              R_NOSAUKUMS='I.STOCKS'
              R_NOSAUKUMS='II.DEBTORS'
              R_NOSAUKUMS='III.SECURITIES AND PARTICIPATION IN CAPITALS'
              R_NOSAUKUMS='5.Reserves'
              R_NOSAUKUMS='I.LONG-TERM DEBTS'
              R_NOSAUKUMS='II.SHORT-TERM DEBTS'
           .
        ELSE
           EXECUTE V#
              R_NOSAUKUMS='I Nemateriâlie ieguldîjumi'
              R_NOSAUKUMS='II Pamatlîdzekïi'
              R_NOSAUKUMS='III Ilgtermiòa finansu ieguldîjumi'
              R_NOSAUKUMS='I Krâjumi'
              R_NOSAUKUMS='II Debitori'
              R_NOSAUKUMS='III Îstermiòa finansu ieguldîjumi'
              R_NOSAUKUMS='5. Rezerves'
              R_NOSAUKUMS='I Ilgtermiòa kreditori'
              R_NOSAUKUMS='II Îstermiòa kreditori'
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:VIRSRAKSTS)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS
           ADD(OUTFILEANSI)
        .
!       CNTRL1 =0
!       CNTRL10=0
     .

     IF F:VALODA=1 !ANGLISKI
        R_NOSAUKUMS=GETKON_R('B',R:KODS,0,2)
     ELSE
        R_NOSAUKUMS=GETKON_R('B',R:KODS,0,1)
     .
     IF R:KODS=50 OR R:KODS=100 OR R:KODS=190 OR R:KODS=270 OR R:KODS=350 OR R:KODS=390 OR R:KODS=500 OR R:KODS=640 OR R:KODS=780 !MAZIE KOPÂ
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)                                          
        .
     ELSIF R:KODS=200 OR R:KODS=410 OR R:KODS=530 OR R:KODS=570 OR R:KODS=790 !LIELIE KOPÂ
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
           PRINT(RPT:LINE)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
        .
     ELSIF R:KODS=420   !BILANCE_Aktîvs
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
           PRINT(RPT:LINE)
           IF F:VALODA=1 !ANGLISKI
              print(RPT:PASIVSA)
           ELSE
              print(RPT:PASIVS)
           .
           print(RPT:SVITRA)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
           IF F:VALODA=1 !ANGLISKI
              OUTA:LINE=''
              ADD(OUTFILEANSI)
              OUTA:LINE='LIABILITIES'&CHR(9)&'CODE'&CHR(9)&'FINAL BALANCE'&CHR(9)&'BEGINNING BALANCE'
              ADD(OUTFILEANSI)
           ELSE
              OUTA:LINE=''
              ADD(OUTFILEANSI)
              OUTA:LINE=' PASÎVS'&CHR(9)&'Kods'&CHR(9)&'Slçgums'&CHR(9)&'Sâkums'
              ADD(OUTFILEANSI)
           .
        .
     ELSIF R:KODS=800  !BILANCE_Pasîvs
        DO FILL_SUMMAS
        IF F:DBF = 'W'
           PRINT(RPT:DETAILB)
        ELSE
           OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
           ADD(OUTFILEANSI)
        .
     ELSE
        DO FILL_SUMMAS
        IF R:KODS=400 !NAUDA
           IF F:DBF = 'W'
              PRINT(RPT:DETAILB)
           ELSE
              OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
              ADD(OUTFILEANSI)
           .
        ELSE
           IF ~(F:CEN AND ~R:SUMMA AND ~R:SUMMA0) !NEDRUKÂT TUKÐAS RINDAS
              IF F:DBF = 'W'
                 PRINT(RPT:DETAIL)
              ELSE
                 OUTA:LINE=R_NOSAUKUMS&CHR(9)&R:KODS&CHR(9)&E_SUMMA&CHR(9)&E_SUMMA0
                 ADD(OUTFILEANSI)
              .
           .
        .
        IF F:DTK !IZVÇRSTÂ VEIDÂ BEZ STARPSUMMÂM
           LOOP J#= 1 TO RECORDS(B_TABLE)
              GET(B_TABLE,J#)
              IF B:BKK_KODS[6:8]=R:KODS
                 B_BKK=B:BKK_KODS[1:5]
                 B_NOSAUKUMS=GETKON_K(B_BKK,0,2)
                 IF F:DBF = 'W'
                    PRINT(RPT:DETAILBKK)
                 ELSE
                    OUTA:LINE='   '&B_BKK&' '&B_NOSAUKUMS&CHR(9)&CHR(9)&FORMAT(B:SUMMA,@N-_14.2) !ÐITOS NEAPAÏOJAM
                    ADD(OUTFILEANSI)
                 .
              .
           .
        .
        IF F:DBF = 'W'
           PRINT(RPT:LINE)
        .
     .
     IF F:XML_OK#=TRUE AND (R:SUMMAR0 OR R:SUMMAR)
        XML:LINE='<<Row>'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="tabula" value="1" />'   !1-BILANCE
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="rinda" value="'&CLIP(R:KODS)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="iepr_vert" value="'&CLIP(R:SUMMAR0)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<<Field name="vertiba" value="'&CLIP(R:SUMMAR)&'" />'
        ADD(OUTFILEXML)
        XML:LINE='<</Row>'
        ADD(OUTFILEXML)
     .
  .
  IF F:DBF = 'W'
    PRINT(RPT:FOOTER)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='          '&CLIP(SYS:AMATS1)&':________________________'&CLIP(SYS:PARAKSTS1)
    ADD(OUTFILEANSI)
  .

  IF F:XML_OK#=TRUE
     XML:LINE='<</Declaration>'
     ADD(OUTFILEXML)
     XML:LINE='<</DeclarationFile>'
     ADD(OUTFILEXML)
     CLOSE(OUTFILEXML)
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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

!---------------------------------------------------------------------------------------------------
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
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

!---------------------------------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~INSTRING(GGK:BKK[1],' 12345')
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
    IF PercentProgress <> Progress:Thermometer
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
    END
  END
  ?Progress:UserString{Prop:Text}=RecordsProcessed
  DISPLAY()

!---------------------------------------------------------------------------------------------------
FILL_SUMMAS  ROUTINE
  IF F:NOA   !LS BEZ SANTÎMIEM
     S_SUMMA =FORMAT(R:SUMMAR,@N-15)          !WMF
     S_SUMMA0=FORMAT(R:SUMMAR0,@N-15)
     E_SUMMA =LEFT(FORMAT(R:SUMMAR,@N-_15.2)) !WORD,EXCEL
     E_SUMMA0=LEFT(FORMAT(R:SUMMAR0,@N-_15.2))
  ELSE
     S_SUMMA =FORMAT(R:SUMMA,@N-15.2)         !WMF
     S_SUMMA0=FORMAT(R:SUMMA0,@N-15.2)
     E_SUMMA =LEFT(FORMAT(R:SUMMA,@N-_15.2))  !WORD,EXCEL
     E_SUMMA0=LEFT(FORMAT(R:SUMMA0,@N-_15.2))
  .

!---------------------------------------------------------------------------------------------------
FILL_R_TABLE  ROUTINE
  LOOP I#= 1 TO RECORDS(R_TABLE)
     GET(R_TABLE,I#)
     IF R:KODS>420 THEN R:SUMMA =-R:SUMMA.
     IF R:KODS>420 THEN R:SUMMA0=-R:SUMMA0.
     IF R:KODS=460 !PA VIDU IEBÂZTAS REZERVES
        CNTRL1  =0
        CNTRL10 =0
        CNTRLR1 =0
        CNTRLR10=0
     .
     IF R:KODS=50 OR R:KODS=100 OR R:KODS=190 OR R:KODS=270 OR R:KODS=350 OR R:KODS=390 OR R:KODS=500 OR R:KODS=640 OR R:KODS=780 !MAZIE KOPÂ
        R:SUMMA  =CNTRL1
        R:SUMMA0 =CNTRL10
        R:SUMMAR =CNTRLR1
        R:SUMMAR0=CNTRLR10
        CNTRL1 =0
        CNTRL10=0
        CNTRLR1 =0
        CNTRLR10=0
     ELSIF R:KODS=200 OR R:KODS=410 OR R:KODS=530 OR R:KODS=570 OR R:KODS=790 !LIELIE KOPÂ
        R:SUMMA  =CNTRL2
        R:SUMMA0 =CNTRL20
        R:SUMMAR =CNTRLR2
        R:SUMMAR0=CNTRLR20
        CNTRL2  =0
        CNTRL20 =0
        CNTRL1  =0
        CNTRL10 =0
        CNTRLR2 =0
        CNTRLR20=0
        CNTRLR1 =0
        CNTRLR10=0
     ELSIF R:KODS=420   !BILANCE_Aktîvs
        R:SUMMA  =CNTRL3
        R:SUMMA0 =CNTRL30
        R:SUMMAR =CNTRLR3
        R:SUMMAR0=CNTRLR30
        CNTRLR4   =CNTRLR3  !R4 TIKAI NOAPAÏOÐANAS KÏÛDAI
        CNTRLR40  =CNTRLR30
        CNTRL3   =0
        CNTRL30  =0
        CNTRLR3  =0
        CNTRLR30 =0
     ELSIF R:KODS=800  !BILANCE_Pasîvs
        R:SUMMA  =CNTRL3
        R:SUMMA0 =CNTRL30
        R:SUMMAR =CNTRLR3
        R:SUMMAR0=CNTRLR30
        CNTRLR4 -=CNTRLR3
        CNTRLR40-=CNTRLR30
     ELSE
        R:SUMMAR =ROUND(R:SUMMA,1)
        R:SUMMAR0=ROUND(R:SUMMA0,1)
        IF R:KODS>420
           CNTRL -=R:SUMMA !BEZ STARPSUMMÂM GALA KONTROLEI
        ELSE
           CNTRL +=R:SUMMA !BEZ STARPSUMMÂM GALA KONTROLEI
        .
        CNTRL1  +=R:SUMMA
        CNTRL10 +=R:SUMMA0
        CNTRL2  +=R:SUMMA
        CNTRL20 +=R:SUMMA0
        CNTRL3  +=R:SUMMA
        CNTRL30 +=R:SUMMA0
        CNTRLR1 +=R:SUMMAR
        CNTRLR10+=R:SUMMAR0
        CNTRLR2 +=R:SUMMAR
        CNTRLR20+=R:SUMMAR0
        CNTRLR3 +=R:SUMMAR
        CNTRLR30+=R:SUMMAR0
     .
     PUT(R_TABLE)
  .
  IF CNTRL
     KLUDA(0,'NEIET AKTÎVS/PASÎVS par Ls '&CNTRL)
     IF B_DAT=DATE(12,31,GADS)
        IF BAND(SYS:control_byte,00000010b)       ! bija OK
           SYS:control_byte -= 2
           PUT(SYSTEM)
        .
     .
  ELSE
     IF (CNTRLR4 OR CNTRLR40) AND (F:XML_OK#=TRUE OR F:NOA) !NEIET PÇC NOAPAÏOÐANAS
        KLUDA(0,'pçc noapaïoðanas NEIET BILANCE: slçgums Ls '&clip(CNTRLR4)&' sâkums Ls '&clip(CNTRLR40)&' izlîdzinam uz 730 rindu ')
        R:KODS=730  !Nodokïi
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=780  !II kopâ
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=790  !3.iedaïas kopsumma
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
        R:KODS=800  !Bilance-Pasîvs
        GET(R_TABLE,R:KODS)
        R:SUMMAR +=CNTRLR4
        R:SUMMAR0+=CNTRLR40
        PUT(R_TABLE)
     .
     IF B_DAT=DATE(12,31,GADS)
        IF ~BAND(SYS:control_byte,00000010b)      ! nebija OK
           SYS:control_byte += 2
           PUT(SYSTEM)
        .
     .
  .


!------------------------------------------------------------------------------
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
SelftestBase         PROCEDURE                    ! Declare Procedure
KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME
GGK_U_NR             LIKE(GGK:U_NR)
KON_NOS              STRING(3)
CHECKGGSUMMA         DECIMAL(12,2)
DK_SUMMA             DECIMAL(12,2)
GGK_SUMMA            DECIMAL(12,2)
GG_SUMMA_LS          DECIMAL(12,2)
GG_SUMMA_VAL         DECIMAL(12,2)
MULTIVAL             BYTE
GG_TIPS              LIKE(GG:TIPS)
STRINGBYTE           STRING(8)
ADDTIPS              BYTE
PUTGG                BYTE
PUTGGK               BYTE
LASTONE              BYTE
!----------------------------------------
K_TABLE         QUEUE,PRE(K)
BKK                  STRING(5)
ATLIKUMS             DECIMAL(12,2)
                .
!----------------------------------------
LocalRequest         LONG
LocalResponse        LONG
rakstsggk            byte
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
!----------------------------------------

report REPORT,AT(200,105,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
header DETAIL,AT(,21,,927)
         STRING(@s45),AT(1458,208,5083,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('VS "WinLats"  paðtests  -  BÂZE :'),AT(1198,573),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(3646,573,219,229),USE(LOC_NR),LEFT(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4010,573),USE(SYS:AVOTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s90),AT(208,21,7344,156),USE(KOMENT),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
footer DETAIL,AT(,,,271),USE(?unnamed)
         LINE,AT(104,52,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@t4),AT(7406,83),USE(lai),FONT(,7,,,CHARSET:BALTIC)
         STRING('Sastâdîja :'),AT(156,83),USE(?String5),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(646,83),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(6885,83),USE(dat),FONT(,7,,,CHARSET:BALTIC)
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
  CHECKOPEN(GG,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(KON_K,1)
  GGK_U_NR=0
  stringbyte=''
  gg_tips=0
  VAL_NOS=''
  gg_summa_val=0
  gg_summa_Ls=0
  MULTIVAL=FALSE
  PUTGG=FALSE
  PUTGGK=FALSE
  LASTONE=FALSE
  dat=today()
  lai=clock()
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  IF F:ATL
     RecordsToProcess += RECORDS(KON_K)
  .
  IF F:KRI
     RecordsToProcess += RECORDS(GG)
  .
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ProgressWindow{Prop:Text} = 'Selftest (Paðtests)'
  close(gg)
  OPEN(GG,12h)
  IF ~ERROR()
     close(ggk)
     OPEN(GGK,12h)
     IF ~ERROR()
        ?Progress:UserString{Prop:Text}='Bûvçjam atslçgas GG ...'
        DISPLAY
        PACK(GG)
        IF ERROR()
           STOP('BUILD GG:'&ERROR())
        .
        ?Progress:UserString{Prop:Text}='Bûvçjam atslçgas GGK ...'
        DISPLAY
        PACK(GGK)
        IF ERROR()
           STOP('BUILD GGK:'&ERROR())
        .
     ELSE
        KLUDA(1,'GGK')
     .
  ELSE
     KLUDA(1,'GG')
  .
  CLOSE(GG)
  CLOSE(GGK)
  CHECKOPEN(GG,1)
  CHECKOPEN(GGK,1)
  ?Progress:PctText{Prop:Text} = '0%'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  OPEN(report)
  report{Prop:Preview} = PrintPreviewImage
  PRINT(rpt:header)
  SET(GGK:NR_key)
  LOOP
     PUTGG=FALSE
     PUTGGK=FALSE
     NEXT(GGK)
     IF ERROR()
        LASTONE=TRUE
        DO CHECKGG
        BREAK
     .
     DO CHECKGG
     DO COUNTER
     clear(gg:record)
     GG:U_NR=GGK:U_NR
     GET(GG,GG:NR_KEY)
     IF ERROR()
        KLUDA(5,'GGK-GG '&FORMAT(ggk:datums,@D6)&' Nr:'&GGK:U_NR)
        IF klu_darbiba
           CLEAR(GG:RECORD)
           GG:U_NR=GGK:U_NR
           GG:DOKDAT=GGK:DATUMS
           GG:DATUMS=GGK:DATUMS
           GG:PAR_NR=GGK:PAR_NR
           GG:SATURS='?????????????????'
           ADD(GG)
           IF ERROR()
              KOMENT='Relâcijas kïûda gg-ggk :'&FORMAT(ggk:datums,@D6)&' Nr:'&CLIP(GGK:U_NR)&' Rakstu nav iespçjams atjaunot'
              print(rpt:detail)
           ELSE
              KOMENT='Relâcijas kïûda gg-ggk :'&FORMAT(ggk:datums,@D6)&' Nr:'&CLIP(GGK:U_NR)&' Raksts ir atjaunots'
              print(rpt:detail)
           .
        ELSE
           KOMENT='Relâcijas kïûda gg-ggk :'&FORMAT(ggk:datums,@D6)&' Nr:'&CLIP(GGK:U_NR)&' LIETOTÂJA ATTEIKUMS atjaunot'
           print(rpt:detail)
        .
     ELSE
        !*********** 0-ES PIELIKÐANA GGK, JA MAZÂK PAR 5 ZÎMÇM ******
        IF LEN(CLIP(GGK:BKK)) < 5
           CLEAR(KON:RECORD)
           KON:BKK=GGK:BKK
           GET(KON_K,KON:BKK_KEY)
           IF ~ERROR()
              KON:BKK=CLIP(KON:BKK)&'00000'
              IF ~DUPLICATE(KON_K)
                  KOMENT='Mainu kontu plânu: '&GGK:BKK&' uz '&KON:BKK
                  print(rpt:detail)
                  PUT(kon_k)
              .
           .
           KOMENT='Mainu kontu: '&GGK:BKK
           print(rpt:detail)
           GGK:BKK=CLIP(GGK:BKK)&'00000'
           PUTGGK=TRUE
        .
        !*********** ATLIKUMU KONTROLE KON_K******
        IF F:ATL AND ~GGK:RS  !NAV NEAPSTIPRINÂTS
           GET(K_TABLE,0)
           K:BKK=GGK:BKK
           GET(K_TABLE,K:BKK)
           IF ERROR()
              CASE GGK:D_K
              OF 'D'
                 K:ATLIKUMS=GGK:SUMMA
              ELSE
                 K:ATLIKUMS=-GGK:SUMMA
              .
              ADD(K_TABLE)
              SORT(K_TABLE,K:BKK)
           ELSE
              CASE GGK:D_K
              OF 'D'
                 K:ATLIKUMS+=GGK:SUMMA
              ELSE
                 K:ATLIKUMS-=GGK:SUMMA
              .
              PUT(K_TABLE)
           END
        .
        !*********** 0-ES NODAÏAS NOVÂKÐANA ******
!        IF GGK:NODALA='0' OR GGK:NODALA<CHR(32)
!           KOMENT='NODALA '&VAL(GGK:NODALA)
!           print(rpt:detail)
!           GGK:NODALA=''
!           PUTGGK=TRUE
!        .
        !*********** DATUMU KONTROLE GGK******
        IF ~(GG:DATUMS=GGK:DATUMS)
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' GGK Datums ir '&format(GGK:DATUMS,@D6)&' jâbût '&format(GG:DATUMS,@D6)
           print(rpt:detail)
           GGK:DATUMS=GG:DATUMS
           PUTGGK=TRUE
        .
        !*********** RS KONTROLE GGK******
        IF ~INSTRING(GG:RS,' 1')
           GG:RS=' '
           IF RIUPDATE:GG()
              KLUDA(24,'GG')
           .
           STOP(GG:RS)
        .
        IF ~(GG:RS=GGK:RS) AND GG:U_NR>1 !SALDO NEANALIZÇJAM
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' GGK RS ir '&GGK:RS&' jâbût '&GG:RS
           print(rpt:detail)
           GGK:RS=GG:RS
           PUTGGK=TRUE
        .
        !*********** BKK KONTROLE KON_K******
        CLEAR(KON:RECORD)
        KON:BKK=GGK:BKK
        GET(KON_K,KON:BKK_KEY)
        IF ERROR()
           KON:NOSAUKUMS='??????????'
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&'Kontu plânâ nav atrasts : '&ggk:bkk
           print(rpt:detail)
           ADD(kon_k)
           IF ERROR()
              STOP('KON_K(ADD) '&ERROR())
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
        .
        !***********VALÛTAS PÂRRÇÍINA KONTROLE GGK *******
        GGK_SUMMA=ROUND(GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS,format(GGK:DATUMS,@d6)&' Nr='&GGK:U_NR),.01)
        IF ~INRANGE(GGK:SUMMA-GGK_SUMMA,-0.01,0.01)            
           KOMENT='Rakstam '&format(GGK:DATUMS,@d6)&' Nr='&GGK:U_NR&' GGK SUMMA ir '&GGK:SUMMA&' jâbût '&GGK_SUMMA
           print(rpt:detail)
           GGK:SUMMA=GGK_SUMMA
           PUTGGK=TRUE
        .
        !***********PVN TIPA KONTROLE GGK *******
        IF GGK:BKK[1:4]='5721' AND ~GGK:PVN_TIPS
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' PVN Tips ir '&GGK:PVN_TIPS&' jâbût 0'
           print(rpt:detail)
           GGK:PVN_TIPS='0'
           PUTGGK=TRUE
        .
        !***********PVN % KONTROLE GGK *******
!        IF (GGK:BKK[1:3]='231' OR GGK:BKK[1:3]='531' OR GGK:BKK[1:4]='5721') AND ~GGK:PVN_PROC
!           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' PVN % ir 0'
!           print(rpt:detail)
!           GGK:PVN_PROC=18
!           PUTGGK=TRUE
!        .
        !************FIX multivalûtas & GG:SUMMA(V) & DK_SUMMA *************
        IF ~VAL_NOS
           val_nos=ggk:val
        .
        IF ~(VAL_NOS=GGK:VAL)
           MULTIVAL=TRUE
        .
        CASE GGK:D_K
        OF 'D'
           gg_summa_ls+=GGK:SUMMA
           GG_SUMMA_VAL+=GGK:SUMMAV
           DK_SUMMA+=GGK:SUMMA
        OF 'K'
           DK_SUMMA-=GGK:SUMMA
        ELSE
           KOMENT='Rakstam '&format(GGK:DATUMS,@d6)&' Nr='&GGK:U_NR&' Nepazîstams D/K: '&GGK:D_K
           print(rpt:detail)
        .
        !***********SASKAITAM kasi/banku/AV/231/531*******
        IF GGK:BKK[1:3]='261'     ! KASE
           STRINGBYTE[8]='1'
        ELSIF GGK:BKK[1:3]='262'  ! BANKA
           STRINGBYTE[7]='1'
        ELSIF GGK:BKK[1:3]='238'  ! AVANSIERI
           STRINGBYTE[6]='1'
        ELSIF GGK:BKK[1:3]='231'  ! 231..
           STRINGBYTE[5]='1'
        ELSIF GGK:BKK[1:3]='531'  ! 531..
           STRINGBYTE[4]='1'
        .
        !***********RAKSTAM GGK*******
        IF PUTGGK=TRUE
           IF RIUPDATE:GGK()
              KLUDA(24,'GGK')
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
        .
     .
  .
  IF F:ATL   !JÂPÂRBAUDA KON_K ATLIKUMI un RINDAS
     CLEAR(KON:RECORD)
     SET(KON:BKK_KEY)
     LOOP
        NEXT(KON_K)
        IF ERROR() THEN BREAK.
        DO COUNTER
        GET(K_TABLE,0)
        K:BKK=KON:BKK
        GET(K_TABLE,K:BKK)
        IF ERROR()
           KON:ATLIKUMS[1]=0
           IF RIUPDATE:KON_K()
              KLUDA(24,'KON_K')
           .
        ELSIF ~(KON:ATLIKUMS[1]=K:ATLIKUMS)
           KON:ATLIKUMS[1]=K:ATLIKUMS
           KOMENT='Kontu plânâ nepareizs konta atlikums: '&kon:bkk
           print(rpt:detail)
           IF RIUPDATE:KON_K()
              KLUDA(24,'KON_K')
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
        END
        IF KON:ATLIKUMS[1] AND ~kon:PZB[1]
           KOMENT='Kontu plânâ NAV norâdîts rindas kods: '&kon:bkk
           print(rpt:detail)
        .
     .
  .
  IF F:KRI   !JÂPÂRBAUDA "TUKÐI" IERAKSTI
     SET(GG)
     LOOP
        NEXT(GG)
        IF ERROR() THEN BREAK.
        DO COUNTER
        CLEAR(GGK:RECORD)
        GGK:U_NR=GG:U_NR
        SET(GGK:NR_KEY,GGK:NR_KEY)
        NEXT(GGK)
        IF ERROR() OR ~(GGK:U_NR=GG:U_NR) !EOF NEKADI NEVAR BUT...
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' nav kontçjumu'
           print(rpt:detail)
        .
     .
  .
  PRINT(RPT:footer)
  ENDPAGE(report)
  pr:skaits=1
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
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO PROCEDURERETURN

!--------------------------------------------------------------------------------------------------------------------

CHECKGG        ROUTINE

     IF ~(GGK_U_NR=GGK:U_NR OR GGK_U_NR=0) OR  LASTONE=TRUE  !MAINÎJIES GGK U_NR
        !***********pârbaudam kasi/banku/AV/231/531*******
        LOOP B#=1 TO 8
          IF STRINGBYTE[9-B#]
             GG_TIPS+=2^(B#-1)
          .
        .
        IF ~(GG:TIPS=GG_TIPS)
           KOMENT='GG TIPS(K/B/A/231/531) ir'&GG:TIPS&' jâbût '&GG_TIPS&'Datums='&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR
           print(rpt:detail)
           GG:TIPS=GG_TIPS
           PUTGG=TRUE
        .
        STRINGBYTE=''
        GG_TIPS=0
        !***********SUMMU KONTROLE GGK & GG *******
        IF ~INRANGE(DK_SUMMA,-0.01,0.01)
           KOMENT='Rakstam '&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR&' nesakrît D/K par Ls '&DK_SUMMA
           print(rpt:detail)
        ELSE
           if MULTIVAL
              IF ~(GG:SUMMA=gg_summa_ls OR GG:VAL='Ls')
                 KOMENT='GG SUMMA ir'&GG:SUMMA&' jâbût '&GG_SUMMA_LS&' Ls'&'Datums='&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR
                 print(rpt:detail)
                 GG:SUMMA=gg_summa_ls
                 GG:VAL='Ls'
                 PUTGG=TRUE
              .
           else
              IF ~(GG:SUMMA=gg_summa_val OR GG:VAL=val_nos)
                 KOMENT='GG SUMMA ir'&GG:SUMMA&' jâbût '&GG_SUMMA_VAL&' '&VAL_NOS&'Datums='&format(GG:DATUMS,@d6)&' Nr='&GG:U_NR
                 print(rpt:detail)
                 GG:SUMMA=gg_summa_val
                 GG:VAL=val_nos
                 PUTGG=TRUE
              .
           .
        .
        MULTIVAL=FALSE
        VAL_NOS=''
        DK_SUMMA=0
        gg_summa_val=0
        gg_summa_Ls=0
        !***********RAKSTAM GG*******
        IF PUTGG
           IF RIUPDATE:GG()
              KLUDA(24,'GG')
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
           PUTGG=FALSE
        .
     .
     GGK_U_NR=GGK:U_NR

!---------------------------------------------------------------------------------------------------------------------

PROCEDURERETURN        ROUTINE

  close(ProgressWindow)
  FREE(K_TABLE)
  RETURN

!---------------------------------------------------------------------------------------------------------------------

COUNTER       ROUTINE

        RecordsProcessed += 1
        RecordsThisCycle += 1
        IF PercentProgress < 100
          PercentProgress = (RecordsProcessed / RecordsToProcess)*100
          IF PercentProgress > 100
            PercentProgress = 100
          END
          IF PercentProgress <> Progress:Thermometer THEN
            Progress:Thermometer = PercentProgress
            ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
            DISPLAY()
          END
        END
