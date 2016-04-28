                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_NorDokLimA         PROCEDURE                    ! Declare Procedure
!
! ADMICULUM/GLIMSTEDT
!

P_TABLE           QUEUE,PRE(P)
NOS_KEY              STRING(19)  !5+8+6  NOS+U_NR+DOK_DAT
PAR_NR               ULONG
DOK_SENR             STRING(14)
DATUMS               LONG
NORDAT               LONG
SUMMA                DECIMAL(12,2)
SUMMAV               DECIMAL(12,2)
VAL                  STRING(3)
                  .
NPK                  DECIMAL(4)
NOS_P                STRING(45)
NOS_PX               STRING(45)
NOS_PN               STRING(50)
SAM_SUMMA            DECIMAL(11,2)
SAM_SUMMAV           DECIMAL(11,2)
JAU_SAM_SUMMA        DECIMAL(11,2)
JAU_SAM_SUMMAV       DECIMAL(11,2)
SAM_DATUMS           LONG
Pav_K_SUMMA          DECIMAL(11,2)
SAM_K_SUMMA          DECIMAL(11,2)
PaR_K_SUMMA          DECIMAL(11,2)
Pav_T_SUMMA          DECIMAL(11,2)
SAM_T_SUMMA          DECIMAL(11,2)
PAR_T_SUMMA          DECIMAL(11,2)
K_KS                 DECIMAL(11,2)
T_KS                 DECIMAL(11,2)
P_DOK_SENR           STRING(14)
P_DATUMS             LONG
P_SUMMA              DECIMAL(12,2)
P_SUMMAV             DECIMAL(12,2)
P_NORDAT             LONG
P_VAL                STRING(3)
P_C_SUMMA            DECIMAL(11,2)
P_C_SUMMAV           DECIMAL(11,2)

K_TABLE            QUEUE,PRE(K)
KP_VAL               STRING(3)
KP_SUMMAV            DECIMAL(12,2)
KSam_SUMMAV          DECIMAL(12,2)
KP_C_SUMMAV          DECIMAL(12,2)
                   .
A_VAL                STRING(3)
DAT                  LONG
LAI                  TIME
A_SUMMA              DECIMAL(12,2)
V_SUMMA              DECIMAL(12,2)
CHECKSUMMA           DECIMAL(12,2)
FILTRS_TEXT0          STRING(100)
FILTRS_TEXT          STRING(100)
SAV_PAR_NR           ULONG
ATSK_V               BYTE
ATSK_V_TEXT          STRING(80)
CG                   STRING(10)
CP                   STRING(3)
KAV                  SHORT
KAV_UZ_B_DAT         SHORT
VAL                  STRING(3)
KS                   DECIMAL(11,2)
KSK                  DECIMAL(11,2)
MAKSAJUMI            BYTE
T_MAKSAJUMS          BYTE

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

Atsk_V_window WINDOW,AT(,,208,92),CENTER,GRAY
       OPTION('Norâdiet atskaites veidu'),AT(6,13,198,52),USE(ATSK_V),BOXED
         RADIO('P/Z , kas izrakstîtas periodâ'),AT(12,31,188,10),USE(?ATSK_V:Radio1),VALUE('1')
         RADIO('P/Z, kas jâapmaksâ periodâ'),AT(12,41,188,10),USE(?ATSK_V:Radio2),VALUE('2')
       END
       BUTTON('&OK'),AT(128,72,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(167,72,36,14),USE(?CancelButton)
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

report REPORT,AT(200,1815,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(200,198,8000,1615),USE(?unnamed)
         LINE,AT(3490,885,0,729),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(4417,885,0,729),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(5365,885,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6063,885,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(365,885,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1563,7310,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Vadîbas atskaite'),AT(6406,313),USE(?String77),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa  '),AT(6146,1250,550,208),USE(?String8:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dienas'),AT(6781,1250,583,208),USE(?String8:25),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokum.'),AT(5396,1344,640,208),USE(?String8:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7365,885,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Summa'),AT(5396,938,640,208),USE(?String8:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6771,885,0,729),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Parâda'),AT(6146,1042,552,208),USE(?String8:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rçíina'),AT(2917,1042,450,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4531,1042,688,208),USE(?String8:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(3604,1250,600,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(2917,1250,531,208),USE(?String8:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(4531,1250,688,208),USE(?String8:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc apm.'),AT(5396,1146,640,208),USE(?String8:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rçíina'),AT(3594,1042,688,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1490,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Kavçtâs'),AT(6781,1042,573,208),USE(?String8:24),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíini par precçm (pakalpojumiem) konts :'),AT(2229,354),USE(?String2),RIGHT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s5),AT(5240,365),USE(kkk),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(729,521,6021,198),USE(FILTRS_TEXT0),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6792,719,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s70),AT(1229,688,5010,198),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,885,7310,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,1125),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Klients'),AT(792,1135,1063,156),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2875,885,0,729),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(52,885,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,167),USE(?unnamed:5)
         STRING(@S45),AT(406,10,2448,156),USE(NOS_P),LEFT
         STRING(@S14),AT(3510,10,885,156),USE(P_DOK_SENR),RIGHT
         STRING(@D06.B),AT(2906,10,570,156),USE(P_DATUMS),CENTER
         STRING(@N-_11.2B),AT(4438,10,667,156),USE(P_SUMMA),RIGHT(1)
         STRING(@N-_11.2B),AT(5375,10,667,156),USE(Sam_SUMMA),RIGHT(1)
         STRING(@N-_11.2B),AT(6083,10,667,156),USE(P_C_SUMMA),RIGHT(1)
         STRING(@N-_4B),AT(6948,10,220,156),USE(KAV_UZ_B_DAT),TRN,RIGHT(1)
         STRING(@s3),AT(5094,10,271,156),USE(val_uzsk),CENTER
         LINE,AT(2875,0,0,167),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(365,0,0,167),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,167),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(4417,0,0,167),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,167),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,167),USE(?Line5:12),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,167),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,167),USE(?Line5:20),COLOR(COLOR:Black)
         LINE,AT(52,0,0,167),USE(?Line5),COLOR(COLOR:Black)
         STRING(@n4B),AT(83,10,260,156),USE(npk),LEFT
       END
LINE   DETAIL,AT(,,,0),USE(?LINE)
         LINE,AT(52,0,7310,0),USE(?Line143:L),COLOR(COLOR:Black)
       END
detailV DETAIL,AT(,,,167),USE(?unnamed:7)
         LINE,AT(52,0,0,167),USE(?Line5:15),COLOR(COLOR:Black)
         LINE,AT(365,0,0,167),USE(?Line5:25),COLOR(COLOR:Black)
         LINE,AT(2875,0,0,167),USE(?Line5:14),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,167),USE(?Line5:16),COLOR(COLOR:Black)
         LINE,AT(4417,0,0,167),USE(?Line5:6),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4438,10,667,156),USE(P_SUMMAV),RIGHT(1)
         STRING(@s3),AT(5115,10,,156),USE(P_VAL),CENTER
         STRING('t.s.'),AT(2615,10,,156),USE(?String68)
         LINE,AT(5365,0,0,167),USE(?Line5:17),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,167),USE(?Line5:75),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,167),USE(?Line5:115),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,167),USE(?Line5:116),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5375,10,667,156),USE(Sam_SUMMAV),RIGHT(1)
         STRING(@N-_11.2B),AT(6083,10,667,156),USE(P_C_SUMMAV),RIGHT(1)
       END
detailN DETAIL,AT(,,,167),USE(?unnamed:3)
         STRING(@S45),AT(417,10,2448,156),USE(NOS_PN),LEFT
         LINE,AT(4417,0,0,167),USE(?Line55:3),COLOR(COLOR:Black)
         LINE,AT(365,0,0,167),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,167),USE(?Line55:7),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,167),USE(?Line55:12),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,167),USE(?Line55:8),COLOR(COLOR:Black)
         LINE,AT(8365,0,0,167),USE(?Line55:20),COLOR(COLOR:Black)
         LINE,AT(52,0,0,167),USE(?Line55),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5375,21,667,156),USE(P_C_SUMMA,,?P_C_SUMMA:2),RIGHT(1)
         STRING(@N-_11.2B),AT(4438,10,667,156),USE(Sam_SUMMA,,?Sam_SUMMA:2),RIGHT(1)
       END
detailK DETAIL,AT(,,,167),USE(?unnamed:4)
         LINE,AT(52,0,0,167),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(365,0,0,167),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,167),USE(?Line23:3),COLOR(COLOR:Black)
         LINE,AT(4417,0,0,167),USE(?Line23:4),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,167),USE(?Line23:6),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,167),USE(?Line23:7),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,167),USE(?Line23:12),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,167),USE(?Line23:11),COLOR(COLOR:Black)
         LINE,AT(2875,0,0,167),USE(?Line23:5),COLOR(COLOR:Black)
         STRING('Kopâ'),AT(469,10,281,156),USE(?String36),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(4438,10,667,156),USE(Pav_K_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(5375,10,667,156),USE(Sam_K_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6083,10,667,156),USE(PAR_K_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5125,10,229,156),USE(val_uzsk,,?val_uzsk:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detailKV DETAIL,AT(,,,167),USE(?unnamed:6)
         LINE,AT(52,0,0,167),USE(?Line5:515),COLOR(COLOR:Black)
         LINE,AT(365,0,0,167),USE(?Line5:525),COLOR(COLOR:Black)
         LINE,AT(2875,0,0,167),USE(?Line5:18),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,167),USE(?Line5:19),COLOR(COLOR:Black)
         LINE,AT(4417,0,0,167),USE(?Line5:13),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4438,10,667,156),USE(K:KP_SUMMAV),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5115,10,,156),USE(K:KP_VAL),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(5375,10,667,156),USE(K:KSam_SUMMAV),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s.'),AT(2615,10),USE(?String68:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5365,0,0,167),USE(?Line5:565),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,167),USE(?Line5:575),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,167),USE(?Line5:5115),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,167),USE(?Line5:5116),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(6083,10,667,156),USE(K:KP_C_SUMMAV),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
REP_FOOT DETAIL,AT(,,,625),USE(?unnamed:2)
         LINE,AT(365,0,0,437),USE(?Line133:15),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,437),USE(?Line133:3),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,437),USE(?Line133:4),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,437),USE(?Line133:132),COLOR(COLOR:Black)
         LINE,AT(7365,0,0,437),USE(?Line133:14),COLOR(COLOR:Black)
         STRING('Pavisam:'),AT(469,104,,156),USE(?String36:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(4438,104,667,156),USE(PAV_T_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6083,104,667,156),USE(PAR_T_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,427,7310,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(52,448),USE(?String46),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(510,448),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING('RS:'),AT(1167,448),USE(?String96),FONT(,7,,,CHARSET:ANSI)
         STRING(@S1),AT(1333,448),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6292,448),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6906,448),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(3490,0,0,62),USE(?Line160),COLOR(COLOR:Black)
         LINE,AT(4417,0,0,62),USE(?Line159),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(5375,104,667,156),USE(Sam_T_SUMMA),RIGHT(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,52,7310,0),USE(?Line143),COLOR(COLOR:Black)
         LINE,AT(2875,0,0,62),USE(?Line160:2),COLOR(COLOR:Black)
         LINE,AT(52,0,0,437),USE(?Line133:16),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,11140,8000,0)
         LINE,AT(52,0,7310,0),USE(?Line43:3),COLOR(COLOR:Black)
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
  open(Atsk_V_window)
  ATSK_V=1
  ?ATSK_V:Radio1{prop:text}='Rçíini, kas izrakstîti '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
  ?ATSK_V:Radio2{prop:text}='Rçíini, kas jâapmaksâ '&format(s_dat,@d06.)&'-'&format(b_dat,@d06.)
  display
  ACCEPT
     CASE FIELD()
     OF ?OKBUTTON
        IF EVENT()=EVENT:ACCEPTED
           LocalResponse = RequestCompleted
           BREAK
        .
     OF ?CANCELBUTTON
        IF EVENT()=EVENT:ACCEPTED
           LocalResponse = RequestCancelled
           BREAK
        .
     .
  .
  CLOSE(Atsk_V_window)
  IF LocalResponse = RequestCancelled
     RETURN
  .
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF KKK[1] < '3'
     D_K='D'
  ELSE
     D_K='K'
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('CG',CG)
  BIND('KKK',KKK)
  BIND('CP',CP)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Norçíini ar Deb/Kred dokumentu lîmenî'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')

  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      EXECUTE ATSK_V
         FILTRS_TEXT0='Izrakstîtie Rçíini periodâ: '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' uz '&FORMAT(B_DAT,@D06.)
         FILTRS_TEXT0='Jânorçíinâs par Rçíiniem periodâ: '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' uz '&FORMAT(B_DAT,@D06.)
      .
      FILTRS_TEXT=GETFILTRS_TEXT('011100000') !1-OBj,2-NOd,3-ParTips,4-ParGr,5-NOM,6-NTips,7-DN,8-(1:parâdi),9-ID
!                                 123456789
!      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF F:DTK THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&'Tikai savlaicîgi nesamaksâtie'.
!      IF PAR_NR=999999999 !VISI
!        IF PAR_GRUPA
!          IF F:NOT_GRUPA
!             FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Izòemot grupu: '&PAR_GRUPA
!          ELSE
!             FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa: '&PAR_GRUPA
!          .
!        .
!        IF ~(PAR_TIPS='EFCNIR')
!          FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Partnera tips: '&par_tips
!        .
!      ELSE
!        FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&getpar_k(par_nr,2,2)
!      .
      CLEAR(ggk:RECORD)
      GGK:BKK=KKK
      SET(GGK:BKK_DAT)
      CG='K103001'!GGK,RS,GGK:DATUMS,D_K,PVN_TIPS,OBJEKTS,NODAÏA
      !   1234567
      CP='K11'
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
          IF ~OPENANSI('NORDL.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='NORÇÍINI PAR PRECÇM (PAKALPOJUMIEM). KONTS '&KKK
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT0
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE=' Npk'&CHR(9)&'Klients'&CHR(9)&' Rçíina'&CHR(9)&' Rçíina'&CHR(9)&'Summa'&CHR(9)&|
             CHR(9)&' Summa pçc'&CHR(9)&|
             'Parâda summa, '&val_uzsk&CHR(9)&'Kavçtâs dienas'
             !El 'Parâda summa, Ls'&CHR(9)&'Kavçtâs dienas'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&CHR(9)&' Datums'&CHR(9)&' Numurs'&CHR(9)&' ar PVN'&CHR(9)&|
             CHR(9)&'apm.dokumenta'&CHR(9)&CHR(9)&'uz '&FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
             OUTA:LINE=''
             ADD(OUTFILEANSI)
          ELSE !WORDAM VIENÂ RINDÂ MAX 256
             OUTA:LINE=' Npk'&CHR(9)&'Klients'&CHR(9)&'Rçíina Datums'&CHR(9)&'Rçíina Numurs'&CHR(9)&|
             'Summa ar PVN'&CHR(9)&CHR(9)&|
             'Summa pçc apm.dokum.'&CHR(9)&'Parâda summa'&CHR(9)&'Kavçtâs dienas uz '&FORMAT(B_DAT,@D06.)
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG) AND ~CYCLEPAR_K(CP) AND ~BAND(ggk:BAITS,00000001b) !&~IEZAKS
            IF ~GETGG(GGK:U_NR)
               KLUDA(5,'GGK:U_NR:'&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
            .
            IF GGK:REFERENCE AND GGK:SUMMA<0  !STORNO
               LOOP I#= 1 TO RECORDS(P_TABLE)
                  GET(P_TABLE,I#)
                  IF P:DOK_SENR=GGK:REFERENCE AND P:PAR_NR=GGK:PAR_NR
                     P:SUMMA+=GGK:SUMMA
                     P:SUMMAV+=GGK:SUMMAV
                     PUT(P_TABLE)
                     BREAK
                  .
               .
            ELSE                               !NORMÂLA P/Z(RÇÍINS)
               P:PAR_NR=GGK:PAR_NR
!               STOP(P:PAR_NR&' '&GGK:PAR_NR)
               P:NOS_KEY=SUB(GETPAR_K(GGK:PAR_NR,2,14),1,5)&FORMAT(P:PAR_NR,@N_8)&FORMAT(GGK:DATUMS,@D11)
!               STOP(P:NOS_KEY)
               IF GGK:U_NR=1                     !SALDO
                  P:DOK_SENR=GGK:REFERENCE
                  P:NORDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1)
               ELSE
                  P:DOK_SENR=GG:DOK_SENR
                  P:NORDAT=GG:APMDAT
               .
               IF ~P:NORDAT THEN P:NORDAT=GG:DATUMS.
               P:DATUMS=GGK:DATUMS
               P:SUMMA=GGK:SUMMA
               P:SUMMAV=GGK:SUMMAV
               P:VAL=GGK:VAL
               ADD(P_TABLE)
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
!---------P_TABLÇ TAGAD IR VISAS P/Z PARTNERIM(GRUPAI) 231/531 KONTAM(KONTIEM)-----------------
  SORT(P_TABLE,P:NOS_KEY)
  SAV_PAR_NR=0
  IF KKK[1] < '3'
     D_K='K'      !APMAKSA A_TABLÇ UZ INVERSAJIEM
  ELSE
     D_K='D'
  .
  GET(P_TABLE,0)
  LOOP P#= 1 TO RECORDS(P_TABLE)
     GET(P_TABLE,P#)
     IF P#=1
        IRRAKSTI#=FALSE
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,'','',RS,P:PAR_NR,'',0,0,F:NODALA,0)  !Uzbûvç apmaksas ðitam partnerim
     .
     IF ~(P:PAR_NR=SAV_PAR_NR)     !MAINÎJIES PARTNERIS
        DO PRINTNESAMAKSA          !par ðito vçl ir jâdomâ
        DO PRINTCLIENT
        IRRAKSTI#=FALSE            !PAGAIDÂM VÇL NEVIENS RAKSTS PAR JAUNO PAR_NR NAV IZDRUKÂTS
        SAV_PAR_NR=P:PAR_NR
        IMAGE#=PerfAtable(1,'','',RS,P:PAR_NR,'',0,0,F:NODALA,0)  !Uzbûvç apmaksas
     .
     DO PRINTSAMAKSA
  .
  DO PRINTNESAMAKSA
  DO PRINTCLIENT
  dat = today()
  lai = clock()
  PAR_T_SUMMA=PAV_T_SUMMA-SAM_T_SUMMA-T_KS
  IF F:DBF='W'
      PRINT(RPT:REP_FOOT)
  ELSE
      OUTA:LINE=CHR(9)&'PAVISAM:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_T_SUMMA,@N-_11.2B))&CHR(9)&CHR(9)&|
      LEFT(FORMAT(SAM_T_SUMMA,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PAR_T_SUMMA,@N-_11.2B))
      ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       ENDPAGE(report)
    ELSE
       OUTA:LINE=''
       ADD(OUTFILEANSI)
    .
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(A_TABLE)
  FREE(P_TABLE)
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
  IF ERRORCODE() OR CYCLEBKK(GGK:BKK,KKK)=2
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

!-------------------------------------------------------------------------
PrintSamaksa ROUTINE
   IF (ATSK_V=1 AND INRANGE(P:DATUMS,S_DAT,B_DAT)) OR (ATSK_V=2 AND INRANGE(P:NORDAT,S_DAT,B_DAT))
   ! P/Z TRÂPA PIEPRASÎTAJÂ APGABALÂ
       JADRUKA#=TRUE
       SAM_SUMMA=0
       SAM_SUMMAV=0
       MAKSAJUMI=0
       GET(A_TABLE,0)
       LOOP I#= 1 TO RECORDS(A_TABLE)
          GET(A_TABLE,I#)
          IF ~(A:REFERENCE=P:DOK_SENR AND A:DATUMS<=B_DAT) THEN CYCLE.
          SAM_SUMMAV+=A:SUMMAV      !LAI UZZINÂTU, VAI PA VISIEM LÂGIEM IR SAMAKSÂTS KOPÂ VISS
          SAM_SUMMA +=A:SUMMA       !PRIEKÐ TOTALS
          MAKSAJUMI+=1              !LAI UZZINÂTU, CIK MAKSÂJUMU TRANZAKCIJAS IR BIJUÐAS ÐITAM DOKUMENTAM
       .
       IF F:DTK AND|                !TIKAI NESAMAKSÂTÂS
          (P:SUMMAV=SAM_SUMMAV OR|  !VISS SAMAKSÂTS,NEBÛS JÂDRUKÂ
          P:NORDAT>B_dat)           !NAV PARÂDA UZ B_DAT
          JADRUKA#=FALSE
          DO NULLA_TABLE
!          DO TOTALS
!          DO SAMTOTALS
       .
       IF JADRUKA#=TRUE
          FOUND#   =FALSE
          NPK#+=1
          NPK=NPK#
          P_DOK_SENR =P:DOK_SENR
          P_DATUMS =P:DATUMS
          P_SUMMA  =P:SUMMA
          P_SUMMAV =P:SUMMAV
          P_NORDAT =P:NORDAT
          P_VAL    =P:VAL
!          NOS_P=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)
          NOS_P=GETPAR_K(SAV_PAR_NR,2,2)
          NOS_PX=SAV_PAR_NR&CHR(9)&GETPAR_K(SAV_PAR_NR,2,1)
          DO TOTALS
          SAM_SUMMA =0
          SAM_SUMMAV=0
          SAM_DATUMS=0
          KS=0
          KAV=B_DAT-P_NORDAT
          KAV_UZ_B_DAT=B_DAT-P_NORDAT
          T_MAKSAJUMS =0
          GET(A_TABLE,0)                       !MEKLÇJAM APMAKSAS
          LOOP I#= 1 TO RECORDS(A_TABLE)
             GET(A_TABLE,I#)
!             IF ~(A:REFERENCE=P:DOK_SENR) THEN CYCLE.
             IF ~(A:REFERENCE=P:DOK_SENR AND A:DATUMS<=B_DAT) THEN CYCLE.
             IF A:SUMMAV=0 THEN CYCLE.
             FOUND#=TRUE                       !VISMAZ KAUT KÂDA APMAKSA IR ATRASTA
             T_MAKSAJUMS+=1
             SAM_SUMMA =A:SUMMA
             SAM_SUMMAV=A:SUMMAV
             SAM_DATUMS=A:DATUMS
             KS=ROUND(A:SUMMAV*BANKURS(P:VAL,P:DATUMS),.01)-ROUND(A:SUMMAV*BANKURS(A:VAL,A:DATUMS),.01)  !IEZAKS
             JAU_SAM_SUMMA +=SAM_SUMMA+KS
             JAU_SAM_SUMMAV+=SAM_SUMMAV
             P_C_SUMMAV=P:SUMMAV-JAU_SAM_SUMMAV   !TEKOÐAIS PARÂDS UZ P/Z Valûtâ
             KAV=SAM_DATUMS-P:NORDAT
             KAV_UZ_B_DAT=0
             IF P_C_SUMMAV                        !KAUT KÂDS PARÂDS PALIEK ARÎ PÇC ÐÎ MAKSÂJUMA
                P_C_SUMMA=P:SUMMA-JAU_SAM_SUMMA   !TEKOÐAIS PARÂDS UZ P/Z Ls
                IF T_MAKSAJUMS=MAKSAJUMI          !TO CIPARU, CIKILGI TA MILAIS NEMAKSÂ, SPÎDINAM TIKAI PÇDÇJAM RAKSTAM
                   KAV_UZ_B_DAT=B_DAT-P:NORDAT
                .
                IF KAV_UZ_B_DAT<0 THEN KAV_UZ_B_DAT=0.
             ELSE
                P_C_SUMMA=0                       !TEKOÐAIS PARÂDS UZ P/Z Ls (CIRVIS)
             .
             DO SAMTOTALS
             DO PRINTDETAILS
             NOS_P=''                         !LAI NEATKÂRTO LÎDZ BEZGALÎBAI NOSAUKUMU
             NOS_PX=''
             A:SUMMA=0                        !NONULLÇJAM A_TABLI
             A:SUMMAV=0                       !NONULLÇJAM A_TABLI
             PUT(A_TABLE)
          .
       .
       IF FOUND#=FALSE            !NU VISPÂR NEKO NAV MAKSÂJIS BEZGODIS
          P_C_SUMMA =P:SUMMA
          P_C_SUMMAV=P:SUMMAV
          DO PRINTDETAILS
       .
       JAU_SAM_SUMMA =0
       JAU_SAM_SUMMAV=0
       P_C_SUMMA=0
    ELSE
    ! P/Z NETRÂPA PIEPRASÎTAJÂ APGABALÂ, BÛS JÂNONULLÇ A_TABLE
       DO NULLA_TABLE
    .

!-------------------------------------------------------------------------
TOTALS      ROUTINE
    PAV_K_SUMMA+=P:SUMMA
    PAV_T_SUMMA+=P:SUMMA

!-------------------------------------------------------------------------
SAMTOTALS      ROUTINE
    SAM_K_SUMMA+=SAM_SUMMA
    SAM_T_SUMMA+=SAM_SUMMA
    K_KS       +=KS
    T_KS       +=KS

!-------------------------------------------------------------------------
PRINTCLIENT    ROUTINE  !KOPÂ PAR KLIENTU
  IF IRRAKSTI#=TRUE     !KAUT VIENS DOKUMENTS PÇC VISIEM FILTRIEM IR IZDRUKÂTS
!     IF JADRUKA#=TRUE
        PAR_K_SUMMA=PAV_K_SUMMA-SAM_K_SUMMA-K_KS
   !    I#=GETPAR_K(SAV_PAR_NR,0,1)
        IF F:DBF='W'
            PRINT(RPT:DETAILK)
        ELSE
            !El OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_K_SUMMA,@N-_11.2B))&CHR(9)&'Ls '&CHR(9)&|
            OUTA:LINE=CHR(9)&'KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_K_SUMMA,@N-_11.2B))&CHR(9)&val_uzsk&' '&CHR(9)&|
            LEFT(FORMAT(SAM_K_SUMMA,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PAR_K_SUMMA,@N-_11.2B))
            ADD(OUTFILEANSI)
        END
        IF RECORDS(K_TABLE)>1 OR VALUTAS#=TRUE
           LOOP I#=1 TO RECORDS(K_TABLE)
              GET(K_TABLE,I#)
              IF F:DBF='W'
                PRINT(RPT:DETAILKV)
              ELSE
                OUTA:LINE=CHR(9)&'t.s.'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(K:KP_SUMMAV,@N-_11.2B))&CHR(9)&K:KP_VAL&CHR(9)&|
                LEFT(FORMAT(K:KSAM_SUMMAV,@N-_11.2B))&CHR(9)&LEFT(FORMAT(K:KP_C_SUMMAV,@N-_11.2B))
                ADD(OUTFILEANSI)
              END
           .
        .
        IF F:DBF='W'
           PRINT(RPT:LINE)
        .
        FREE(K_TABLE)
        VALUTAS#=FALSE
!     .
  .
  Pav_K_summa=0
  Sam_K_Summa=0
  PAR_K_SUMMA =0
  K_KS=0

!-------------------------------------------------------------------------
PRINTDETAILS      ROUTINE
    IF JADRUKA#=TRUE
       !El IF ~(P_VAL='Ls' OR P_VAL='LVL')
       IF ~(P_VAL=val_uzsk)
          VALUTAS#=TRUE
       .
       K:KP_VAL=P_VAL
       GET(K_TABLE,K:KP_VAL)
       IF ERROR()
          K:KP_SUMMAV=P_SUMMAV
          K:KSam_SUMMAV=Sam_SUMMAV
          K:KP_C_SUMMAV=P_SUMMAV-SAM_SUMMAV
          ADD(K_TABLE)
          SORT(K_TABLE,K:KP_VAL)
       ELSE
          K:KP_SUMMAV+=P_SUMMAV
          K:KSam_SUMMAV+=Sam_SUMMAV
          K:KP_C_SUMMAV+=(P_SUMMAV-SAM_SUMMAV)
          PUT(K_TABLE)
       .
       IF F:DBF='W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=NPK&CHR(9)&NOS_P&CHR(9)&FORMAT(P_DATUMS,@D06.B)&CHR(9)&P_DOK_SENR&CHR(9)&|
          LEFT(FORMAT(P_SUMMA,@N-_11.2B))&CHR(9)&val_uzsk&CHR(9)&LEFT(FORMAT(SAM_SUMMA,@N-_11.2B))&CHR(9)&|
          LEFT(FORMAT(P_C_SUMMA,@N-_11.2B))&CHR(9)&FORMAT(KAV_uz_b_dat,@N-_4B)
          ADD(OUTFILEANSI)
       END
       !El IF ~(P_VAL='Ls' OR P_VAL='LVL')
       IF ~(P_VAL=val_uzsk)
          IF F:DBF='W'
            PRINT(RPT:DETAILV)
          ELSE
            OUTA:LINE=CHR(9)&'t.s.'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(P_SUMMAV,@N-_11.2B))&CHR(9)&|
            P_VAL&CHR(9)&LEFT(FORMAT(SAM_SUMMAV,@N-_11.2B))&CHR(9)&LEFT(FORMAT(P_C_SUMMAV,@N-_11.2B))
            ADD(OUTFILEANSI)
          END
       .
       IRRAKSTI#=TRUE
    .
    NPK=0
    P_DOK_SENR =''
    P_DATUMS =0
    P_SUMMA  =0
    P_SUMMAV =0
    P_NORDAT =0
!    P_VAL    =''

!-------------------------------------------------------------------------
PrintNESamaksa ROUTINE
  GET(A_TABLE,0)
  LOOP I#= 1 TO RECORDS(A_TABLE)       !NEPAZÎSTAMÂS APMAKSAS
     GET(A_TABLE,I#)
     IF A:SUMMA=0 THEN CYCLE.
     IF ~(A:DATUMS<=B_DAT) THEN CYCLE.
     !El NOS_PN=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)&' Samaksa bez references Ls'
     NOS_PN=SAV_PAR_NR&' '&GETPAR_K(SAV_PAR_NR,2,1)&' Samaksa bez references '&val_uzsk
!     NOS_P=A:PAR_NR&' Samaksa bez references'
     NPK=0
     P_DOK_SENR=''
     P_DATUMS=0
     P_SUMMA=0
     P_NORDAT=0
     KAV=0
     KS=0
     SAM_SUMMA=A:SUMMA
     SAM_DATUMS=A:DATUMS
     P_C_SUMMA=-SAM_SUMMA
     IF F:DBF='W'
         PRINT(RPT:DETAILN)
     ELSE
         OUTA:LINE=CHR(9)&NOS_PN&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SAM_DATUMS,@D06.B)&|
         CHR(9)&CHR(9)&LEFT(FORMAT(SAM_SUMMA,@N-_11.2B))&CHR(9)&CHR(9)&LEFT(FORMAT(P_C_SUMMA,@N-_11.2B))
         ADD(OUTFILEANSI)
     END
     DO SAMTOTALS
  .

!-------------------------------------------------------------------------
NULLA_TABLE     ROUTINE
       GET(A_TABLE,0)
       LOOP I#= 1 TO RECORDS(A_TABLE)
          GET(A_TABLE,I#)
          IF ~(A:REFERENCE=P:DOK_SENR) THEN CYCLE.
          A:SUMMA=0     !NONULLÇJAM A_TABLI
          A:SUMMAV=0    !NONULLÇJAM A_TABLI
          PUT(A_TABLE)
          IF ERROR() THEN STOP('NULLÇJOT A_TABLI:'&ERROR()).
       .
B_PVN_DEK_KOPS       PROCEDURE                    ! Declare Procedure
MENESS            STRING(24)
FING              STRING(24)
M                 STRING(20),DIM(16,2)
C                 DECIMAL(12,2),DIM(2,16)
C1                DECIMAL(12,2)
C2                DECIMAL(12,2)
C3                DECIMAL(12,2)
C4                DECIMAL(12,2)
C5                DECIMAL(12,2)
C6                DECIMAL(12,2)
C7                DECIMAL(12,2)
C1K               DECIMAL(12,2)
C2K               DECIMAL(12,2)
C3K               DECIMAL(12,2)
C4K               DECIMAL(12,2)
C5K               DECIMAL(12,2)
C6K               DECIMAL(12,2)
C7K               DECIMAL(12,2)
VES_DATUMS        LONG
VK_NR             ULONG

BKK               STRING(5)
RINDA             STRING(20)
VALUTA            BYTE
VALUTAP           BYTE
CG                STRING(10)
DAT               LONG
LAI               LONG
PREC              STRING(1)

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

report REPORT,AT(150,1440,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(150,200,8000,1240),USE(?HEADER)
         LINE,AT(52,1198,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(3188,792,0,438),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4052,792,0,438),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5583,781,0,438),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(6219,792,0,438),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7708,792,0,438),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(1438,792,0,438),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(7104,792,0,438),USE(?Line2:19),COLOR(COLOR:Black)
         STRING('Priekðnod.[P]'),AT(2333,833,875,188),USE(?String8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2313,792,0,438),USE(?Line2:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1240,156,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6823,573,625,156),PAGENO,USE(?PageCount),RIGHT
         STRING('PVN deklarâciju kopsavilkums uz'),AT(1927,396,2490,208),USE(?String2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d06.),AT(4438,396,875,208),USE(dat,,?dat:2),TRN,FONT(,11,,FONT:bold,CHARSET:ANSI)
         LINE,AT(52,781,7656,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Mçnesis'),AT(188,844,813,190),USE(?String8:1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Gala'),AT(7146,833,531,188),USE(?String8:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(' Jâm.-Dekl. '),AT(5604,1010,604,188),USE(?String8:6),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deklarâcija'),AT(6250,1010,740,188),USE(?String8:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('rezultâts'),AT(7146,1010,531,188),USE(?String8:10),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Precizçtâ  '),AT(6313,833,625,188),USE(?String8:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deklarçts'),AT(4344,833,813,188),USE(?String8:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Jâmaksâ[S-P]'),AT(3219,833,813,188),USE(?String8:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Jâprecizç'),AT(5604,833,604,188),USE(?String8:7),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apr.PVN [S]'),AT(1479,833,813,188),USE(?String8:5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,781,0,438),USE(?Line2),COLOR(COLOR:Black)
       END
DETAIL DETAIL,AT(,,8000,167),USE(?unnamed)
         LINE,AT(6217,-10,0,197),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,197),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@s24),AT(83,10,1333,156),USE(meness)
         LINE,AT(1438,-10,0,197),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@n-_13.2b),AT(1458,10,833,156),USE(C1),TRN,RIGHT
         STRING(@n-_13.2b),AT(2333,10,833,156),USE(C2),RIGHT
         STRING(@n-_13.2b),AT(3208,10,833,156),USE(C3),RIGHT
         STRING(@n-_13.2b),AT(4094,10,833,156),USE(C4),RIGHT
         STRING(@n-_9.2b),AT(5604,10,542,156),USE(C5),RIGHT
         STRING(@n-_13.2b),AT(6240,10,833,156),USE(C6),TRN,RIGHT
         STRING(@n-_9.2b),AT(7135,21,542,156),USE(C7),TRN,RIGHT
         LINE,AT(7104,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@D06.B),AT(4938,10),USE(VES_DATUMS),TRN,RIGHT
         LINE,AT(5583,-31,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4052,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(3188,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2313,-10,0,197),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,197),USE(?Line2:8),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,94),USE(?unnamed:5)
         LINE,AT(52,-10,0,114),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(3188,-10,0,114),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(4052,-10,0,114),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(5573,0,0,114),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(6217,10,0,114),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,114),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(7104,0,0,114),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(1438,-10,0,114),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(2313,-10,0,114),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(52,52,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,500),USE(?unnamed:4)
         LINE,AT(5583,-10,0,270),USE(?Line49:3),COLOR(COLOR:Black)
         LINE,AT(6217,-10,0,270),USE(?Line49:4),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,270),USE(?Line49:5),COLOR(COLOR:Black)
         LINE,AT(7104,-10,0,270),USE(?Line49:8),COLOR(COLOR:Black)
         LINE,AT(1438,-10,0,270),USE(?Line49:7),COLOR(COLOR:Black)
         LINE,AT(2313,-10,0,270),USE(?Line49:6),COLOR(COLOR:Black)
         LINE,AT(52,52,7656,0),USE(?Line54),COLOR(COLOR:Black)
         STRING(@s24),AT(83,94,1333,156),USE(FING)
         STRING(@n-_9.2b),AT(7135,94,542,156),USE(C7K),TRN,RIGHT
         STRING(@n-_13.2b),AT(6240,83,833,156),USE(C6K),TRN,RIGHT
         STRING(@n-_9.2b),AT(5604,83,542,156),USE(C5K),TRN,RIGHT
         STRING(@n-_13.2b),AT(2333,83,833,156),USE(C2K),RIGHT
         STRING(@n-_13.2b),AT(3208,83,833,156),USE(C3K),RIGHT
         STRING(@n-_13.2b),AT(4094,83,833,156),USE(C4K),RIGHT
         STRING(@n-_13.2b),AT(1458,83,833,156),USE(C1K),TRN,RIGHT
         LINE,AT(52,260,7656,0),USE(?Line55),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(115,271),USE(?String41),LEFT
         STRING(@s8),AT(656,281,625,177),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6417,281,604,177),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7042,281,490,177),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(4052,-10,0,270),USE(?Line49:2),COLOR(COLOR:Black)
         LINE,AT(52,-10,0,270),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(3188,-10,0,270),USE(?Line49),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10700,8000,52)
         LINE,AT(52,0,7500,0),USE(?Line56:22),COLOR(COLOR:Black)
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
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('KKK',KKK)
  BIND('CYCLEBKK',CYCLEBKK)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  BIND('D_K',D_K)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PVN Dekl. kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      dat = today()
      lai = clock()
      M#=MONTH(DB_B_DAT)
      Y#=YEAR(DB_B_DAT)
      LOOP J# =12 TO 1 BY -1
         M[J#,1]=MENVAR(M#,1,1)&' '&Y#
         M[J#,2]=FORMAT(DATE(M#,1,Y#),@D014.B) !DOKUMANTA Nr VÇSTUREI
         M#-=1
         IF M#<=0
            M#+=12
            Y#-=1
         .
         IF DATE(M#,1,Y#)<DB_S_DAT THEN BREAK.
      .
      FING=FORMAT(DB_S_DAT,@D06.)&'-'&FORMAT(DB_B_DAT,@D06.)

      CLEAR(ggk:RECORD)
      GGK:BKK    = '57210'
      GGK:DATUMS = S_DAT
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      CG='K100000'
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
        .
      .
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      .
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !W,E
        IF ~OPENANSI('PVNDKOPS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='PVN Deklarâciju kopsavilkums '&format(S_DAT,@D06.)&' - '&format(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Atsk.per.'&CHR(9)&'Aprçíinâtais PVN'&CHR(9)&'Priekðnodoklis'&CHR(9)&'Jâmaksâ'&CHR(9)&|
        'Deklarçts'&CHR(9)&'Jâprecizç'&CHR(9)&'Precizçtâ Dekl.'&CHR(9)&'Gala rezultats'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        M#=MONTH(GGK:DATUMS)
        IF GGK:PVN_TIPS='0' AND ~(GGK:U_NR=1) !IEKÐZ.SAM.
           IF GGK:D_K='K'
              C[1,M#]+=GGK:SUMMA
           ELSE
              C[2,M#]+=GGK:SUMMA
           .
        ELSIF GGK:PVN_TIPS='1' AND GGK:D_K='D' !MAKS.BUDÞETAM
           VK_NR=GGK:PAR_NR
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
!
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  IF ~VK_NR
     KLUDA(0,'Nav atrasts neviens PVN maksâjums budþetam')
  .

  LOOP J# = 1 TO 16
     MENESS=M[J#,1]
     VES_DATUMS=0
     IF ~(C[1,J#]+C[2,J#]) THEN CYCLE.
     C1=C[1,J#]
     C2=C[2,J#]
     C3=C1-C2
     C4=GETVESTURE(VK_NR,M[J#,2],6)
     IF C4
        VES_DATUMS=GETVESTURE(VK_NR,M[J#,2],5)
        C6=GETVESTURE(VK_NR,M[J#,2],7) !PRECIZÇTÂ
     .
     C5=C3-C4
     IF C6
        C7=C3-C6
     ELSE
        C7=C5
     .
     IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
     ELSE
        OUTA:LINE=MENESS&CHR(9)&LEFT(FORMAT(C1,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C2,@N-_13.2B))&|
        CHR(9)&LEFT(FORMAT(C3,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C4,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C5,@N-_13.2B))&CHR(9)&|
        LEFT(FORMAT(C6,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C7,@N-_13.2B))
        ADD(OUTFILEANSI)
     .
     C1K+=C1
     C2K+=C2
     C3K+=C3
     C4K+=C4
     C5K+=C5
     C6K+=C6
     C7K+=C7
  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT)
    ENDPAGE(report)
  ELSE
    OUTA:LINE=FING&CHR(9)&LEFT(FORMAT(C1K,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C2K,@N-_13.2B))&|
    CHR(9)&LEFT(FORMAT(C3K,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C4K,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C5K,@N-_13.2B))&CHR(9)&|
    LEFT(FORMAT(C6K,@N-_13.2B))&CHR(9)&LEFT(FORMAT(C7K,@N-_13.2B))
    ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  IF ERRORCODE() OR ~(GGK:BKK='57210')
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
A_APR_A              PROCEDURE                    ! Declare Procedure
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

VUT                  STRING(35)
AS_TEXT              STRING(20)
C_STUNDAS            USHORT
C_DIENAS             USHORT
MDIENAS              USHORT
MDIENASST            USHORT   !26/09/2015
MALGA                DECIMAL(10,2)
S_VID                DECIMAL(10,3)
D_VID                DECIMAL(10,3)
DPK                  DECIMAL(5,2)
DK_VID               DECIMAL(10,3)
NPK                  DECIMAL(3)

APREKINS             STRING(30)
CAL_STUNDAS          STRING(1)
C_STUNDASK           USHORT
C_DIENASK            USHORT
ALG_N_STUNDASK       USHORT
MDIENASK             USHORT
MDIENASSTK            USHORT   !26/09/2015
MALGAK               DECIMAL(10,2)
S_VIDK               DECIMAL(10,3)
D_VIDK               DECIMAL(10,3)
DPKK                 DECIMAL(5,2)
DK_VIDK              DECIMAL(10,3)

MPERIODS             STRING(21)
PERIODS_TEXT         STRING(40)
PROC                 BYTE

DAT                  DATE
LAI                  TIME


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
!--------------------------------------------------------------------------
report REPORT,AT(198,1542,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,250,8000,1292),USE(?unnamed)
         STRING(@s45),AT(1458,104,4531,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Stundas'),AT(3000,1073,573,156),USE(?String25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3573,1052,0,260),USE(?Line21),COLOR(COLOR:Black)
         STRING(@S60),AT(1198,417,5052,208),USE(VUT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1042,6302,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2292,1042,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4490,1042,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(2990,1052,0,260),USE(?Line21:2),COLOR(COLOR:Black)
         LINE,AT(7240,1042,0,260),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Mçnesis'),AT(990,1073,688,156),USE(?String2:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('CAL Dienas'),AT(2323,1073,656,156),USE(?String2:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6448,1052,0,260),USE(?Line2:26),COLOR(COLOR:Black)
         STRING('Alga'),AT(5771,1073,625,156),USE(?String25:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5625,1052,0,260),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(1719,1042,0,260),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('CAL St.'),AT(1740,1073,490,156),USE(?String25:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dienas pçc st.'),AT(3625,1073,823,156),USE(?String2:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('D.vidçjâ.'),AT(6552,1073,573,156),USE(?String25:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nostr.dienas (5.d.)'),AT(4552,1073,1031,156),USE(?String2:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1250,6302,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(938,1042,0,260),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s20),AT(1719,646,1781,219),USE(AS_TEXT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3552,646,854,219),USE(PER:SAK_DAT),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4396,646,156,219),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(4573,646),USE(PER:BEI_DAT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Dienas vidçjâs aprçíins:'),AT(927,854),USE(?String43),TRN
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(938,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@D014.),AT(1115,10,,156),USE(ALG:YYYYMM),RIGHT
         LINE,AT(2292,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(4490,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(5771,10,573,156),USE(MALGA),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(2990,-10,0,198),USE(?Line22:2),COLOR(COLOR:Black)
         STRING(@N_5B),AT(1813,10,,156),USE(C_STUNDAS,,?C_STUNDAS:2),RIGHT
         STRING(@N_5B),AT(2427,21,,156),USE(C_DIENAS),TRN,RIGHT
         LINE,AT(6448,0,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         STRING(@N_5B),AT(3094,10,,156),USE(ALG:N_STUNDAS,,?ALG:N_STUNDAS:2),TRN,RIGHT
         STRING(@N_5B),AT(4927,10,,156),USE(MDIENAS,,?MDIENAS:2),TRN,RIGHT
         LINE,AT(3573,0,0,198),USE(?Line22),COLOR(COLOR:Black)
         STRING(@N_5B),AT(3865,0,,156),USE(MDIENASST),TRN,RIGHT
         LINE,AT(5625,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
       END
FOOT   DETAIL,AT(,,,958),USE(?unnamed:7)
         LINE,AT(938,-10,0,427),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Kopâ '),AT(1115,146,438,156),USE(?String2:7),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_5B),AT(2427,146,,156),USE(C_DIENASK),TRN,RIGHT
         STRING(@N_7.3),AT(6615,146,438,156),USE(D_VIDK),TRN,RIGHT
         STRING(@N_5B),AT(3094,146,,156),USE(ALG_N_STUNDASK),TRN,RIGHT
         STRING(@N_5B),AT(3854,146,,156),USE(MDIENASSTK),TRN,RIGHT
         STRING(@N-_10.2),AT(5771,146,573,156),USE(MALGAK),TRN,RIGHT
         STRING(@N_5B),AT(1813,146,,156),USE(C_STUNDASK),TRN,RIGHT
         LINE,AT(938,406,6302,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Dienas vidçjâ APRçíinâtâ = Darba alga / Nostr.dienas pçc 5.d (CAL dienas - Atval' &|
             '.dienas - Slim.dienas) ='),AT(938,458,5333,177),USE(?String40),TRN
         STRING(@N_8.3),AT(6198,458,563,177),USE(DK_VIDK,,?DK_VIDK:2),TRN,RIGHT,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING('Lietotâja definçtâ dienas vidçjâ ='),AT(948,625),USE(?String41),TRN
         STRING(@N_7.3),AT(2635,625,583,177),USE(PER:VSUMMA,,?PER:VSUMMA:2),TRN,FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s30),AT(948,792),USE(APREKINS),TRN
         LINE,AT(938,52,6302,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@N_5B),AT(4948,146,365,156),USE(MDIENASK,,?MDIENASK:2),TRN,RIGHT
         LINE,AT(4490,-10,0,427),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,427),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1719,-10,0,427),USE(?Line23:4),COLOR(COLOR:Black)
         LINE,AT(2990,-10,0,427),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(3573,-10,0,427),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,427),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,427),USE(?Line23:3),COLOR(COLOR:Black)
         LINE,AT(6448,-10,0,427),USE(?Line2:28),COLOR(COLOR:Black)
       END
HEAD_A DETAIL,AT(,,,292),USE(?unnamed:8)
         LINE,AT(938,42,5865,0),USE(?Line1A),COLOR(COLOR:Black)
         LINE,AT(2333,42,0,260),USE(?Line2:2A),COLOR(COLOR:Black)
         LINE,AT(4854,42,0,260),USE(?Line2:12A),COLOR(COLOR:Black)
         STRING('Periods'),AT(1292,73,688,156),USE(?String2:8A),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6135,52,0,260),USE(?Line2:26A),COLOR(COLOR:Black)
         LINE,AT(6802,52,0,260),USE(?Line2:23A),COLOR(COLOR:Black)
         LINE,AT(5458,52,0,260),USE(?Line2:19A),COLOR(COLOR:Black)
         STRING('D.vidçjâ.'),AT(5490,73,573,156),USE(?String25:4A),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(6167,73,573,156),USE(?String25:7A),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dienas'),AT(4896,73,542,156),USE(?String2:9A),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,250,5865,0),USE(?Line1:2A),COLOR(COLOR:Black)
         LINE,AT(938,42,0,260),USE(?Line2A),COLOR(COLOR:Black)
       END
Detail_A DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(938,-10,0,198),USE(?Line2:3A),COLOR(COLOR:Black)
         LINE,AT(2333,-10,0,198),USE(?Line2:4A),COLOR(COLOR:Black)
         STRING(@N_5),AT(4948,10,438,156),USE(MDIENAS,,?MDIENAS:2A),TRN,RIGHT
         STRING(@N_7.3),AT(5573,10,438,156),USE(PER:VSUMMA,,?PER:VSUMMA:3A),TRN,RIGHT
         LINE,AT(6135,0,0,198),USE(?Line2:27A),COLOR(COLOR:Black)
         LINE,AT(4854,0,0,198),USE(?Line2:17A),COLOR(COLOR:Black)
         LINE,AT(5458,-10,0,198),USE(?Line2:20A),COLOR(COLOR:Black)
         LINE,AT(6802,10,0,198),USE(?Line2:24A),COLOR(COLOR:Black)
         STRING(@s21),AT(969,10),USE(MPERIODS),TRN,CENTER
         STRING(@N-_10.2),AT(6167,10,573,156),USE(MALGA,,?MALGA:A),TRN,RIGHT
         STRING(@s40),AT(2385,21,2406,177),USE(PERIODS_TEXT),TRN,LEFT(1)
       END
FOOT_A DETAIL,AT(,,,802),USE(?unnamed:10)
         LINE,AT(938,-10,0,427),USE(?Line2:9A),COLOR(COLOR:Black)
         STRING('Kopâ '),AT(1115,146,438,156),USE(?String2:7A),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_7.3),AT(5583,146,438,156),USE(PER:VSUMMA,,?PER:VSUMMA:4A),TRN,RIGHT
         LINE,AT(938,417,5865,0),USE(?Line1:4A),COLOR(COLOR:Black)
         STRING(@d06.),AT(5667,427,625,104),USE(dat,,?dat:2),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6281,427,521,104),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Izmaksât ar'),AT(948,521),USE(?String58),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('algu sarakstu EUR'),AT(2260,521,958,177),USE(?String58F),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_10.2),AT(3260,500,792,177),USE(MALGAK,,?MALGAK:2A),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING(@D014.),AT(1635,500,615,177),USE(PER:YYYYMM),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,52,5865,0),USE(?Line1:3A),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(6167,146,573,156),USE(MALGAK,,?MALGAK:2AF),TRN,RIGHT
         STRING(@N_5),AT(4948,146,438,156),USE(MDIENASK,,?MDIENASK:A),TRN,RIGHT
         LINE,AT(4854,-10,0,427),USE(?Line2:18A),COLOR(COLOR:Black)
         LINE,AT(6802,-10,0,427),USE(?Line2:25A),COLOR(COLOR:Black)
         LINE,AT(5458,-10,0,427),USE(?Line2:22A),COLOR(COLOR:Black)
         LINE,AT(2333,-10,0,427),USE(?Line23:3A),COLOR(COLOR:Black)
         LINE,AT(6135,-10,0,427),USE(?Line2:28A),COLOR(COLOR:Black)
       END
HEAD_S DETAIL,AT(,,,292),USE(?unnamed:5)
         LINE,AT(938,42,3917,0),USE(?Line1S),COLOR(COLOR:Black)
         LINE,AT(2333,42,0,260),USE(?Line2:2S),COLOR(COLOR:Black)
         LINE,AT(2917,52,0,260),USE(?Line2:12S),COLOR(COLOR:Black)
         STRING('Periods'),AT(1302,73,688,156),USE(?String2:8S),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3583,42,0,260),USE(?Line2:26S),COLOR(COLOR:Black)
         STRING('Apm.%'),AT(3635,73,542,156),USE(?String2:9A:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4188,52,0,260),USE(?Line2:23S),COLOR(COLOR:Black)
         LINE,AT(4854,52,0,260),USE(?Line2:19S),COLOR(COLOR:Black)
         STRING('D.vidçjâ.'),AT(2958,73,573,156),USE(?String25:4S),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4240,73,573,156),USE(?String25:7S),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dienas'),AT(2365,73,542,156),USE(?String2:9S),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,250,3917,0),USE(?Line1:2S),COLOR(COLOR:Black)
         LINE,AT(938,42,0,260),USE(?Line2S),COLOR(COLOR:Black)
       END
Detail_S DETAIL,AT(,,,177),USE(?unnamed:9)
         LINE,AT(938,-10,0,198),USE(?Line2:3S),COLOR(COLOR:Black)
         LINE,AT(2333,-10,0,198),USE(?Line2:4S),COLOR(COLOR:Black)
         STRING(@N_5),AT(2385,10,438,156),USE(MDIENAS,,?MDIENAS:2S),TRN,RIGHT
         STRING(@N_7.3),AT(3010,10,438,156),USE(PER:VSUMMA,,?PER:VSUMMA:3S),TRN,RIGHT
         LINE,AT(3583,0,0,198),USE(?Line2:27S),COLOR(COLOR:Black)
         LINE,AT(4854,0,0,198),USE(?Line2:17S),COLOR(COLOR:Black)
         LINE,AT(2917,0,0,198),USE(?Line2:20S),COLOR(COLOR:Black)
         LINE,AT(4188,0,0,198),USE(?Line2:24S),COLOR(COLOR:Black)
         STRING(@s21),AT(969,10),USE(MPERIODS,,?mperiods:S),TRN,CENTER
         STRING(@N-_10.2),AT(4250,10,573,156),USE(MALGA,,?MALGA:S),TRN,RIGHT
         STRING(@N_2),AT(3771,10,313,156),USE(PROC),TRN,CENTER
       END
FOOT_S DETAIL,AT(,,,802),USE(?unnamed:4)
         LINE,AT(938,-10,0,427),USE(?Line2:9S),COLOR(COLOR:Black)
         STRING('Kopâ '),AT(1115,146,438,156),USE(?String2:7S),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_7.3),AT(3021,146,438,156),USE(PER:VSUMMA,,?PER:VSUMMA:4S),TRN,RIGHT
         LINE,AT(938,417,3917,0),USE(?Line1:4S),COLOR(COLOR:Black)
         STRING(@d06.),AT(3792,458,625,104),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(4438,458,521,104),USE(lai,,?lai:2),FONT(,7,,,CHARSET:ANSI)
         STRING('Izmaksât ar'),AT(948,594),USE(?String58:S),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('algu sarakstu EUR'),AT(2260,594,958,177),USE(?String58S),TRN,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_10.2),AT(3260,573,792,177),USE(MALGAK,,?MALGAK:2S),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:ANSI)
         STRING(@D014.),AT(1635,573,615,177),USE(PER:YYYYMM,,?YYYYMM:S),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,52,3917,0),USE(?Line1:3S),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(4250,146,573,156),USE(MALGAK,,?MALGAK:2AF:2),TRN,RIGHT
         STRING(@N_5),AT(2385,146,438,156),USE(MDIENASK,,?MDIENASK:S),TRN,RIGHT
         LINE,AT(4854,-10,0,427),USE(?Line2:18S),COLOR(COLOR:Black)
         LINE,AT(4188,-10,0,427),USE(?Line2:25S),COLOR(COLOR:Black)
         LINE,AT(2917,-10,0,427),USE(?Line2:22S),COLOR(COLOR:Black)
         LINE,AT(2333,-10,0,427),USE(?Line23:3S),COLOR(COLOR:Black)
         LINE,AT(3583,-10,0,427),USE(?Line2:28S),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11050,8000,156),USE(?unnamed:2)
         LINE,AT(938,0,6302,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('PER:ID',PER:ID)
  BIND('B_DAT',B_DAT)
  BIND('B_DAT',B_DAT)

  DAT=TODAY()
  LAI=CLOCK()

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)

  FilesOpened = True
  RecordsToProcess = 12
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Aprçíins'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VUT=GETKADRI(PER:ID,0,1)
      IF PER:PAZIME='A'
         AS_TEXT='Atvaïinâjums:'
         APREKINS='Atvaïinâjuma aprçíins:'
      ELSE
         AS_TEXT='Slimîbas lapa:'
         APREKINS='Slimîbas lapas aprçíins:'
      .
      CLEAR(ALG:RECORD)
      ALG:ID=PER:ID
      ALG:YYYYMM=DATE(MONTH(PER:YYYYMM),1,YEAR(PER:YYYYMM)-1)
      SET(ALG:ID_DAT,ALG:ID_DAT)
      Process:View{Prop:Filter} = 'ALG:ID=PER:ID'
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
          IF ~OPENANSI('A_APR.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VUT
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(AS_TEXT)&' '&format(PER:SAK_DAT,@D06.)&'-'&format(PER:BEI_DAT,@D06.)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Dienas vidçjâs aprçíins:'
          ADD(OUTFILEANSI)
          OUTA:LINE='Mçnesis'&CHR(9)&'CAL stundas'&CHR(9)&'CAL dienas'&CHR(9)&'Stundas'&CHR(9)&'Dienas pçc st.'&CHR(9)&|
          'Dienas pçc 5d.'&CHR(9)&'Alga'&CHR(9)& 'Dienas vidçjâ'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF BAND(ALG:BAITS,00000010B) !TICIS IZMANTOTS VIDALGAI
           NNR#+=1
           ?Progress:UserString{Prop:Text}=NNR#
           DISPLAY(?Progress:UserString)
           C_STUNDAS=0
           C_DIENAS =0
           LOOP I#=ALG:YYYYMM TO DATE(MONTH(ALG:YYYYMM)+1,1,YEAR(ALG:YYYYMM))-1
              CAL_STUNDAS=GETCAL(I#)
              IF INSTRING(CAL_STUNDAS,'012345678')
!              IF INSTRING(CAL_STUNDAS,'012345678S')
                  C_DIENAS+=1 !DARBA DIENAS
                  C_STUNDAS+=CAL_STUNDAS
              .
           .
           !25/09/2015 <
           MALGA = 0
           MDIENAS = 0
           LOOP I#= 1 TO 20
              IF ALG:K[I#]
                 IF GETDAIEV(ALG:K[I#],0,7)='Y'   !Pieòemam, ka vidçjo visur rçíina vienâdi
                    MALGA+=ALG:R[I#]
                 .
                 IF ~INRANGE(ALG:K[I#],840,842) AND ~INRANGE(ALG:K[I#],850,852) ! ~ATVAÏINÂJUMS UN ~SLILAPA
                    MDIENAS+=ALG:D[I#]
                 .
              .
           .

!           MDIENAS=ALG:N_STUNDAS/8
!           MALGA=SUM(19)
           MDIENASST=ALG:N_STUNDAS/8
           !24/09/2015 >

           S_VID=MALGA/ALG:N_STUNDAS
           D_VID=MALGA/MDIENAS
           DPK=ALG:N_STUNDAS/C_STUNDAS
           DK_VID=D_VID*DPK
           IF F:DBF = 'W'
             PRINT(RPT:DETAIL)
           ELSE
             OUTA:LINE=FORMAT(ALG:YYYYMM,@D06.)&CHR(9)&C_STUNDAS&CHR(9)&C_DIENAS&CHR(9)&ALG:N_STUNDAS&CHR(9)&|
             MDIENASST&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(MALGA,@N-_12.2))&CHR(9)&LEFT(FORMAT(D_VID,@N-_12.3))
             ADD(OUTFILEANSI)
           END
           C_STUNDASK+=C_STUNDAS
           C_DIENASK+=C_DIENAS
           ALG_N_STUNDASK+=ALG:N_STUNDAS
           MDIENASK+=MDIENAS
           MDIENASSTK+=MDIENASST !24/09/2015
           MALGAK+=MALGA
           !25/09/2015 <
           !D_VIDK=MALGAK/MDIENASK
           IF MDIENASK > 0
              D_VIDK=MALGAK/MDIENASK
           ELSE
              D_VIDK=MALGAK/MDIENASST
           .
           !25/09/2015 >
           S_VIDK=MALGAK/ALG_N_STUNDASK
           DPKK=ALG_N_STUNDASK/C_STUNDASK
           !25/09/2015 DK_VIDK=D_VIDK*DPKK
           DK_VIDK = D_VIDK
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF ~NNR#
       kluda(0,'Rakstam nav definçti mçneði,kurus iekïaut rçíinâ:"Mainît","D.vidçjâ","X,X,.","Atlikt"')
    .
    IF F:DBF = 'W'
       PRINT(RPT:FOOT)
    ELSE
       OUTA:LINE='Kopâ: '&CHR(9)&C_STUNDASK&CHR(9)&C_DIENASK&CHR(9)&ALG_N_STUNDASK&CHR(9)&|
       MDIENASK&CHR(9)&MDIENASSTK&CHR(9)&LEFT(FORMAT(MALGAK,@N-_12.2))&CHR(9)&LEFT(FORMAT(D_VIDK,@N-_12.3))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='Dienas vidçjâ APRçíinâtâ = Darba alga / Nostr.dienas pçc 5.d (CAL dienas - Atval.dienas - Slim.dienas) = '&|
       LEFT(FORMAT(DK_VIDK,@N-_12.3))
       ADD(OUTFILEANSI)
       OUTA:LINE='Lietotâja definçtâ dienas vidçjâ= '&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))
       ADD(OUTFILEANSI)
    END
    MDIENASK=0
    MALGAK=0
    IF PER:PAZIME='A'
       IF F:DBF = 'W'
          PRINT(RPT:HEAD_A)
       ELSE
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Atvaïinâjuma aprçíins:'
          ADD(OUTFILEANSI)
          OUTA:LINE='Periods'&CHR(9)&CHR(9)&'Dienas'&CHR(9)&'Dienas vidçjâ'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
       END

       I0#=PER:BEI_DAT
       I1#=PER:BEI_DAT
       I2#=PER:BEI_DAT
       LOOP I#=PER:SAK_DAT TO PER:BEI_DAT
          IF PER:DIENAS0 AND (I#=DATE(MONTH(PER:SAK_DAT)+1,1,YEAR(PER:SAK_DAT))-1 OR I#=I0#)
             MPERIODS=FORMAT(PER:SAK_DAT,@D06.)&'-'&FORMAT(I#,@D06.)
             !24/09/2015 <
             IF I#=I1#
                MPERIODS=FORMAT(PER:SAK_DAT,@D06.)&'-'&FORMAT(I#,@D06.)
             .
             I0#=0
             !24/09/2015 >
             PERIODS_TEXT='Atvaïinâjums ðajâ mçnesî'
             MDIENAS=PER:DIENAS0
             MALGA=PER:SUMMA0
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_A)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&PERIODS_TEXT&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENASK+=PER:DIENAS0
             MALGAK+=PER:SUMMA0
          .
          IF PER:DIENAS1 AND (I#=DATE(MONTH(PER:SAK_DAT)+2,1,YEAR(PER:SAK_DAT))-1 OR I#=I1#)
!          Stop(FORMAT(I#,@D06.))
!          Stop('PER:SAK_DAT '&PER:SAK_DAT)
!          Stop('MONTH '&MONTH(PER:SAK_DAT))
!          Stop('YEAR '&YEAR(PER:SAK_DAT))
!          Stop('DATE '&DATE(MONTH(PER:SAK_DAT)+1,1,YEAR(PER:SAK_DAT)))
!          Stop('DATE D5 '&FORMAT(DATE(MONTH(PER:SAK_DAT)+1,1,YEAR(PER:SAK_DAT)),@D5))
             MPERIODS=FORMAT(DATE(MONTH(PER:SAK_DAT)+1,1,YEAR(PER:SAK_DAT)),@D06.)&'-'&FORMAT(I#,@D06.)
             !24/09/2015 <
             IF I#=I1#
                MPERIODS=FORMAT(PER:SAK_DAT,@D06.)&'-'&FORMAT(I#,@D06.)
             .
             I1#=0
             !24/09/2015 >
             PERIODS_TEXT='Atvaïinâjums nâkoðajâ mçnesî'
             MDIENAS=PER:DIENAS1
             MALGA=PER:SUMMA1
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_A)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&PERIODS_TEXT&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENASK+=PER:DIENAS1
             MALGAK+=PER:SUMMA1
          .
          IF PER:DIENAS2 AND (I#=DATE(MONTH(PER:SAK_DAT)+3,1,YEAR(PER:SAK_DAT))-1 OR I#=I2#)
             MPERIODS=FORMAT(DATE(MONTH(PER:SAK_DAT)+2,1,YEAR(PER:SAK_DAT)),@D06.)&'-'&FORMAT(I#,@D06.)
             !24/09/2015 <
             IF I#=I1#
                MPERIODS=FORMAT(PER:SAK_DAT,@D06.)&'-'&FORMAT(I#,@D06.)
             .
             I2#=0
             !24/09/2015 >
             PERIODS_TEXT='Atvaïinâjums aiznâkoðajâ mçnesî'
             MDIENAS=PER:DIENAS2
             MALGA=PER:SUMMA2
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_A)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&PERIODS_TEXT&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENASK+=PER:DIENAS2
             MALGAK+=PER:SUMMA2
          .
       .
       IF F:DBF = 'W'
          PRINT(RPT:FOOT_A)
          ENDPAGE(report)
       ELSE
          OUTA:LINE='Kopâ'&CHR(9)&CHR(9)&MDIENASK&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
          LEFT(FORMAT(MALGAK,@N-_12.2))
          ADD(OUTFILEANSI)
          OUTA:LINE='Izmaksât ar '&FORMAT(PER:YYYYMM,@D014.)&' Algu sarakstu EUR '&LEFT(FORMAT(MALGAK,@N-_12.2))
          ADD(OUTFILEANSI)
       .
    ELSE !SLILAPA
       IF F:DBF = 'W'
          PRINT(RPT:HEAD_S)
       ELSE
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Slimîbas lapas aprçíins:'
          ADD(OUTFILEANSI)
          OUTA:LINE='Periods'&CHR(9)&'Dienas'&CHR(9)&'Dienas vidçjâ'&CHR(9)&'Apmaksas%'&CHR(9)&'Summa'
          ADD(OUTFILEANSI)
       END
       MDIENAS =0
       MDIENASK=0
       MALGAK  =0
       LOOP I#=PER:SAK_DAT TO PER:BEI_DAT
          CAL_STUNDAS=GETCAL(I#)
          IF INSTRING(CAL_STUNDAS,'012345678')
             MDIENAS +=1
             MDIENASK+=1
          .
          IF MDIENASK=1 OR I#=PER:BEI_DAT
             MPERIODS=FORMAT(I#,@D06.)
             MALGA=0
             PROC=0
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_S)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                'O%'&CHR(9)&LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENAS=0
             MALGAK+=MALGA
          ELSIF MDIENASK=3 OR I#=PER:BEI_DAT
             MPERIODS=FORMAT(I#-1,@D06.)&'-'&FORMAT(I#,@D06.)
             PROC=75
             MALGA=PER:VSUMMA*MDIENAS*0.75
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_S)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                '75%'&CHR(9)&LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENAS=0
             MALGAK+=MALGA
          ELSIF MDIENASK=10 OR I#=PER:BEI_DAT
             MPERIODS=FORMAT(I#-8,@D06.)&'-'&FORMAT(PER:BEI_DAT,@D06.)
             MALGA=PER:VSUMMA*MDIENAS*0.80
             PROC=80
             IF F:DBF = 'W'
                PRINT(RPT:DETAIL_S)
             ELSE
                OUTA:LINE=MPERIODS&CHR(9)&MDIENAS&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&|
                '8O%'&CHR(9)&LEFT(FORMAT(MALGA,@N-_12.2))
                ADD(OUTFILEANSI)
             .
             MDIENAS=0
             MALGAK+=MALGA
             BREAK
          .
       .
       IF F:DBF = 'W'
          PRINT(RPT:FOOT_S)
          ENDPAGE(report)
       ELSE
          OUTA:LINE='Kopâ'&CHR(9)&MDIENASK&CHR(9)&LEFT(FORMAT(PER:VSUMMA,@N-_12.3))&CHR(9)&CHR(9)&|
          LEFT(FORMAT(MALGAK,@N-_12.2))
          ADD(OUTFILEANSI)
          OUTA:LINE='Izmaksât ar '&FORMAT(PER:YYYYMM,@D014.)&' Algu sarakstu EUR '&LEFT(FORMAT(MALGAK,@N-_12.2))
          ADD(OUTFILEANSI)
       .
    .
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
  IF ERRORCODE() OR ALG:YYYYMM > PER:YYYYMM
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
