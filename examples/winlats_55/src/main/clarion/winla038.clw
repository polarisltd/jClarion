                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_PIE            PROCEDURE                    ! Declare Procedure
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
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
PAR_NOS_P            STRING(35)
GGTEX                STRING(60)
DOK_NR               STRING(10)
PERS_KODS            STRING(13)
DOK_SUMMA            DECIMAL(12,2)
PVN_SUMMA            DECIMAL(12,2)
DOK_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_P          DECIMAL(12,2)
PVN_SUMMA_K          DECIMAL(12,2)
DOK_SUMMA_K          DECIMAL(12,2)
DATUMS               DATE
RMENESIEM            STRING(11)
MEN12                BYTE,DIM(12)
NPK                  ULONG
CG                   STRING(10)

R_TABLE      QUEUE,PRE(R)
KEY            STRING(15)
DATUMS         LONG
U_NR           ULONG
PAR_NR         ULONG
PVNS           DECIMAL(12,2)
PVN_PROC       BYTE
PVN_TIPS       STRING(1)
             .

PVNS                DECIMAL(12,2)
DOK_DAT             LONG
SUM1                STRING(11)
SUM2                STRING(11)

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

report REPORT,AT(500,604,12000,7198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(500,208,12000,302)
       END
Page_Head DETAIL,AT(,,,2385)
         STRING('2. pielikums'),AT(9104,104,1156,156),USE(?String39) 
         STRING('Ministru kabineta'),AT(9104,260,1156,156),USE(?String40) 
         STRING('Valsts ieòçmumu dienests'),AT(3125,52),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('2001. gada 30. janvâra'),AT(9104,417,1156,156),USE(?String41) 
         STRING('noteikumiem Nr. 46'),AT(9104,573,1156,156),USE(?String42) 
         STRING('Pârskats par priekðnodokïa summâm, kas iekïautas pievienotâs vçrtîbas nodokïa de' &|
             'klarâcijâ'),AT(1125,313,7031,260),USE(?String1:2),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas periods :'),AT(365,677),USE(?String1:3),FONT(,10,,,CHARSET:BALTIC)
         STRING(' mçnesis'),AT(2969,677),USE(?String1:4),FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(5000,625,0,260),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(5313,625,0,260),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(5625,625,0,260),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(5938,625,0,260),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(6250,625,0,260),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(6875,625,0,260),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(6563,625,0,260),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(7500,625,0,260),USE(?Line1:11),COLOR(COLOR:Black)
         STRING(@n2B),AT(3802,677),USE(men12[1]),CENTER
         STRING(@n2B),AT(4115,677),USE(men12[2]),CENTER
         STRING(@n2B),AT(4427,677),USE(men12[3]),CENTER
         STRING(@n2B),AT(4740,677),USE(men12[4]),CENTER
         STRING(@n2B),AT(5052,677),USE(men12[5]),CENTER
         STRING(@n2B),AT(5365,677),USE(men12[6]),CENTER
         STRING(@n2B),AT(5677,677),USE(men12[7]),CENTER
         STRING(@n2B),AT(5990,677),USE(men12[8]),CENTER
         STRING(@n2B),AT(6302,677),USE(men12[9]),CENTER
         STRING(@n2B),AT(6615,677),USE(men12[10]),CENTER
         STRING(@n2B),AT(6927,677),USE(men12[11]),CENTER
         STRING(@n2B),AT(7240,677),USE(men12[12]),CENTER
         LINE,AT(4688,625,0,260),USE(?Line1:12),COLOR(COLOR:Black)
         LINE,AT(7188,625,0,260),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(4375,625,0,260),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(4063,625,0,260),USE(?Line1:15),COLOR(COLOR:Black)
         LINE,AT(3750,885,3750,0),USE(?Line1:16),COLOR(COLOR:Black)
         STRING('Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums'),AT(365,990),USE(?String1:6), |
             FONT(,10,,,CHARSET:BALTIC)
         STRING('Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs'),AT(365,1198), |
             USE(?String1:7),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s13),AT(4948,1198,1094,208),USE(gl:vid_nr),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(9427,1250),PAGENO,USE(?PageCount),RIGHT 
         STRING(@s45),AT(4323,990,3438,208),USE(client),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3750,625,0,260),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(3750,625,3750,0),USE(?Line35),COLOR(COLOR:Black)
         STRING(@n4),AT(1615,677),USE(GL:DB_gads),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('.  gads'),AT(2031,677,469,208),USE(?String1:5),FONT(,10,,,CHARSET:BALTIC)
         STRING('Darîjuma partnera nosaukums'),AT(573,1563,2240,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partnera'),AT(2865,1563,1146,156),USE(?String1:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN apliekamâs'),AT(2865,1719,1146,156),USE(?String1:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('tiesîbas atskaitît'),AT(4063,1719,1198,156),USE(?String1:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pakalpojumu'),AT(5313,1719,885,156),USE(?String1:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personas reì. nr.'),AT(2865,1875,1146,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('priekðnod. (sask.'),AT(4063,1875,1198,156),USE(?String1:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN (Ls)'),AT(5313,2031,885,156),USE(?String1:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('dokumenta) numurs un datums'),AT(7135,1875,3333,156),USE(?String1:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(5313,1875,885,156),USE(?String1:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar likuma 10.p. 1.d.)'),AT(4063,2031,1198,156),USE(?String1:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,10365,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(2813,1510,0,885),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4010,1510,0,885),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(104,2188,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(156,2240,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(573,2240,2240,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,2240,1094,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(4115,2240,1146,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5313,2240,885,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(6250,2240,833,156),USE(?String3:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7135,2240,3333,156),USE(?String3:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Attaisnojuma dokumenta'),AT(7135,1563,3333,156),USE(?String1:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('NPK'),AT(156,1563,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(521,1510,0,885),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(6198,1510,0,885),USE(?Line2:6),COLOR(COLOR:Black)
         STRING('(preèu pavadzîmes-rçíina, maksâjuma'),AT(7135,1719,3333,156),USE(?String1:13),CENTER, |
             FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10469,1510,0,885),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('PVN (Ls)'),AT(6250,1563,833,156),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7083,1510,0,885),USE(?Line2:30),COLOR(COLOR:Black)
         LINE,AT(5260,1510,0,885),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Preèu vai'),AT(5313,1563,885,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums, kurâ rodas'),AT(4063,1563,1198,156),USE(?String1:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,0,885),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,208)
         STRING(@s60),AT(7135,52,3333,156),USE(GGTEX),LEFT(1) 
         LINE,AT(5260,-10,0,229),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,229),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,229),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,229),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,229),USE(?Line2:31),COLOR(COLOR:Black)
         STRING(@s35),AT(573,52,2240,156),USE(PAR_nos_p),LEFT 
         LINE,AT(6198,-10,0,229),USE(?Line2:13),COLOR(COLOR:Black)
         LINE,AT(10469,-10,0,229),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(104,0,10365,0),USE(?Line1:17),COLOR(COLOR:Black)
         STRING(@s13),AT(2917,52,938,156),USE(PERS_KODS),LEFT(2) 
         STRING(@n_4),AT(156,52,,156),CNT,USE(NPK),RIGHT 
         LINE,AT(104,-10,0,229),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(5365,52,,156),USE(dok_summa),RIGHT 
         STRING(@n-_11.2),AT(6354,52,677,156),USE(pvn_summa),RIGHT 
         STRING(@d6),AT(4375,52,,156),USE(DOK_DAT,,?DOK_DAT:2),RIGHT 
       END
detail2 DETAIL,AT(,,,94)
         LINE,AT(10469,-10,0,115),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(104,52,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,115),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(6198,-10,0,115),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,115),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,115),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,115),USE(?Line2:32),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,115),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,115),USE(?Line2:15),COLOR(COLOR:Black)
       END
detail3 DETAIL,PAGEAFTER(-1),AT(,-10,,1354)
         LINE,AT(104,365,10365,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING('RS: '),AT(417,1094,271,208),USE(?String37),LEFT 
         STRING(@S1),AT(729,1094,208,208),USE(RS),CENTER 
         STRING(@n-_12.2),AT(6250,208,781,156),USE(pvn_summa_k),RIGHT 
         STRING(@n-_13.2),AT(5313,208,,156),USE(dok_summa_k),RIGHT 
         STRING('Kopâ : '),AT(625,208,1146,156),USE(?String3:9),LEFT 
         LINE,AT(10469,0,0,365),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(521,0,0,365),USE(?Line2:27),COLOR(COLOR:Black)
         STRING('Visi pârçjie darîjumi'),AT(625,0,1146,156),USE(?String3:8),LEFT 
         STRING(@n-_12.2),AT(5365,0,,156),USE(dok_summa_p),RIGHT 
         STRING(@n-_11.2),AT(6354,0,677,156),USE(pvn_summa_p),RIGHT 
         STRING(@d6),AT(7813,1094),USE(datums) 
         STRING('Uzòçmuma vadîtâjs'),AT(260,521),USE(?String55:3)
         STRING('Grâmatvedis'),AT(4583,521),USE(?String55)
         LINE,AT(1458,729,2552,0),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(5365,729,2552,0),USE(?Line55:2),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(1823,781),USE(?String55:2)
         STRING('(paraksts un tâ atðifrçjums)'),AT(5729,781),USE(?String55:4)
         LINE,AT(104,156,10365,0),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,365),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6198,0,0,365),USE(?Line2:26),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,365),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,365),USE(?Line2:24),COLOR(COLOR:Black)
         LINE,AT(2813,0,0,365),USE(?Line2:23),COLOR(COLOR:Black)
         LINE,AT(104,0,0,365),USE(?Line2:22),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,7604,12000,73)
         LINE,AT(104,0,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
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
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  DOK_summa  =0
  PVN_summa  =0
  DOK_summa_k=0
  PVN_SUMMA_K=0
  DATUMS=TODAY()
  DONE# = 0                                      !TURN OFF DONE FLAG
  NUM#  = 0
  IF INRANGE(MEN_NR,1,11)
    RMENESIEM='      '&FORMAT(MEN_NR,@S2)
    MEN12[MEN_NR]=MEN_NR
  ELSIF INRANGE(MEN_NR,12,17)
    CASE MEN_NR
    OF 12
      RMENESIEM='     '&FORMAT(MEN_NR,@S2)
      MEN12[12]=12
    OF 13                                          ! 1.CETURKSNIS
      RMENESIEM='  1,2,3'
      MEN12[1]=1
      MEN12[2]=2
      MEN12[3]=3
    OF 14                                          ! 2.CETURKSNIS
      RMENESIEM='  4,5,6'
      MEN12[4]=4
      MEN12[5]=5
      MEN12[6]=6
    OF 15                                          ! 3.CETURKSNIS
      RMENESIEM='  7,8,9'
      MEN12[7]=7
      MEN12[8]=8
      MEN12[9]=9
    OF 16                                          ! 4.CETURKSNIS
      RMENESIEM='10,11,12'
      MEN12[10]=10
      MEN12[11]=11
      MEN12[12]=12
    OF 17
      RMENESIEM='  1-12  '
      LOOP M#=1 TO 12
         MEN12[M#]=M#
      .
    .
  ELSE
     STOP('NEGAIDÎTA KÏÛDA NR= '&MEN_NR)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GG::Used = 0
    CHECKOPEN(GG,1)
  end
  GG::Used += 1
  IF PAR_K::Used = 0
    CHECKOPEN(PAR_K,1)
  end
  PAR_K::Used += 1
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
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
  ProgressWindow{Prop:Text} = 'PVN pielikums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K101'
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !RTF
        IF ~OPENANSI('PVN_PIE.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {50}VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}Pârskats par priekðnodokïa summâm, kas iekïautas Pievienotâs Vçrtîbas Nodokïa deklarâcijâ'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Taksâcijas periods:'&CHR(9)&GL:DB_GADS&'. gads Mçnesis:'&CHR(9)&MEN12[1]&' '&MEN12[2]&' '&MEN12[3]&' '&MEN12[4]&' '&MEN12[5]&' '&MEN12[6]&' '&MEN12[7]&' '&MEN12[8]&' '&MEN12[9]&' '&MEN12[10]&' '&MEN12[11]&' '&MEN12[12]
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums'&chr(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs'&chr(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{165}'
        ADD(OUTFILEANSI)
        OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums   '&CHR(9)&'Darîjuma partnera'&CHR(9)&'Datums, kurâ rodas'&CHR(9)&'Preèu vai'&CHR(9)&'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&' {30}'&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'tiesîbas atskaitît'&CHR(9)&'pakalpojumu'&CHR(9)&' {8}'&CHR(9)&'(preèu pavadzîmes-rçíina, maksâjuma'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&' {30}'&CHR(9)&'personas reì. Nr'&CHR(9)&'priekðnod. (sask.  '&CHR(9)&'vçrtîba'&CHR(9)&' {8}'&CHR(9)&'dokumenta) numurs un datums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&' {42}'&CHR(9)&'ar likuma 10.p. 1.d.)'&CHR(9)&'bez PVN (Ls)'
        ADD(OUTFILEANSI)
        OUTA:LINE='-{165}'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
      !************************ SAMAKSÂTS UN NESAMAKSÂTS PVN ********
         IF INSTRING(GGK:PVN_TIPS,'02NA') AND ~CYCLEBKK(GGK:BKK,KKK) AND ~(GGK:U_NR=1) AND ~CYCLEGGK(CG)
           R:KEY=GETPAR_K(GGK:PAR_NR,0,1)
           R:PVNS=GGK:SUMMA
           R:DATUMS=GGK:DATUMS
           R:U_NR=GGK:U_NR
           R:PAR_NR=GGK:PAR_NR
           R:PVN_TIPS=GGK:PVN_TIPS
           R:PVN_PROC=GGK:PVN_PROC
           ADD(R_TABLE)
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(R_TABLE,R:KEY)
  !************************ SAMAKSÂTAIS PVN ********
    PRINT(RPT:PAGE_HEAD)
    LOOP I#= 1 TO RECORDS(R_TABLE)
      GET(R_TABLE,I#)
!      IF ~INRANGE(R:PVNS,-0.02,0.02)     !NOÒEMTS 15/04/2002
        IF R:PVN_TIPS='A'
           PAR_nos_p = '30:'&GETPAR_K(R:PAR_NR,0,2)
        ELSE
           PAR_nos_p = GETPAR_K(R:PAR_NR,0,2)
        .
        pers_kods = GETPAR_K(R:PAR_NR,0,8)
        X#=GETGG(R:U_NR)
        DOK_DAT   = R:DATUMS
        PVN_SUMMA = R:PVNS
        PVN_SUMMA_K+= R:PVNS
        IF R:PVN_PROC=0                        ! PVN %
           DOK_SUMMA=(R:PVNS*100)/SYS:NOKL_PVN
        ELSE
           DOK_SUMMA=(R:PVNS*100)/R:PVN_PROC
        .
!        IF CHECKPZ(1)
!           DOK_NR=RIGHT(FORMAT(GG:DOK_NR,@N06))
!        ELSE
!           IF GG:DOK_NR
!              DOK_NR=RIGHT(GG:DOK_NR)
!           ELSE
!              DOK_NR=''
!           .
!        .
        DOK_NR=GG:DOK_SENR
        GGTEX=CLIP(GG:DOK_SENR)&' '&FORMAT(R:DATUMS,@D6)&' '&GG:SATURS2
        DOK_SUMMA_K+=DOK_SUMMA
        IF ABS(DOK_SUMMA) < MINMAXSUMMA
           DOK_SUMMA_P+=DOK_SUMMA
           PVN_SUMMA_P+=PVN_SUMMA
        ELSE
           NPK+=1
           IF F:DBF = 'W'
                PRINT(RPT:DETAIL)
           ELSE
                SUM1 = DOK_SUMMA
                SUM2 = PVN_SUMMA
                OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&FORMAT(DOK_DAT,@D6)&' {8}'&CHR(9)&SUM1&CHR(9)&SUM2&CHR(9)&GGTEX
                ADD(OUTFILEANSI)
                OUTA:LINE='-{165}'
                ADD(OUTFILEANSI)
           END
        .
!      .
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL2)
        PRINT(RPT:DETAIL3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE='-{165}'
        ADD(OUTFILEANSI)
        SUM1 = DOK_SUMMA_P
        SUM2 = PVN_SUMMA_P
        OUTA:LINE='Visi pârçjie darîjumi: {40}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SUM1&CHR(9)&SUM2
        ADD(OUTFILEANSI)
        OUTA:LINE='-{165}'
        ADD(OUTFILEANSI)
        SUM1 = DOK_SUMMA_k
        SUM2 = PVN_SUMMA_k
        OUTA:LINE='Kopâ: {55}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&SUM1&CHR(9)&SUM2
        ADD(OUTFILEANSI)
        OUTA:LINE='-{165}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {15}Uzòçmuma vadîtâjs____________________ {20}Grâmatvedis____________________'
        ADD(OUTFILEANSI)
    END
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
      ?Progress:PctText{Prop:Text} = 'analizçti '&FORMAT(PercentProgress,@N3) & '% no DB'
      DISPLAY()
    END
  END
B_KOKU_R_REG         PROCEDURE                    ! Declare Procedure
!-----------------------------------------------------------------------------
RPT_MENESIEM         STRING(8)
NPK                  DECIMAL(3)
R7                   DECIMAL(10,2)
R8                   DECIMAL(9,2)
R9                   DECIMAL(10,2)
R10                  DECIMAL(9,2)
R11                  DECIMAL(10,2)
R12                  DECIMAL(9,2)
R13                  DECIMAL(10,2)
R14                  DECIMAL(9,2)
R7K                  DECIMAL(10,2)
R8K                  DECIMAL(9,2)
R9K                  DECIMAL(10,2)
R10K                 DECIMAL(9,2)
R11K                 DECIMAL(10,2)
R12K                 DECIMAL(9,2)
R13K                 DECIMAL(10,2)
R14K                 DECIMAL(9,2)
DAT                  LONG
DATUMS               LONG
LAI                  LONG
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
S1                   STRING(1)
BKK_PVN              STRING(5)
CG                   STRING(10)
DOK_NR               STRING(14)
PAR_NOS_S            LIKE(par:nos_s)

!-----------------------------------------------------------------------------
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
!-----------------------------------------------------------------------------
report REPORT,AT(100,2067,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,150,8000,1917),USE(?unnamed:3)
         STRING('Neapliekamâm pers.'),AT(5448,1531,1146,156),USE(?String11:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Eksports    t.s.'),AT(6646,1531,1146,156),USE(?String11:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mazumtirdzniecîba'),AT(4250,1531,1146,156),USE(?String11:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('KOKMATERIÂLU  PIEGÂDES  (REALIZÂCIJAS)  REÌISTRS'),AT(1719,156,4844,260),USE(?String1), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(2979,396,1708,260),USE(menesisunG),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums :'),AT(979,740),USE(?String7),LEFT
         STRING(@s45),AT(1719,740,3490,208),USE(client),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reìistrâcijas Nr :'),AT(552,938),USE(?String7:2),LEFT
         STRING(@s13),AT(1719,938,1094,208),USE(gl:vid_nr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7260,1000),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,1198,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,1198,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(990,1198,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1979,1198,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3021,1198,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Npk'),AT(208,1375,219,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(500,1375,469,156),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partn.'),AT(1021,1323,938,156),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P/Z vai MD'),AT(2010,1240,990,208),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdâts (realizçts), Ls'),AT(3760,1240,3104,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reì. Nr.'),AT(1021,1510,938,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(2010,1531,990,156),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâm pers.'),AT(3052,1531,1146,156),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(2010,1698,990,156),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(3052,1698,1146,156),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(4250,1698,1146,156),USE(?String11:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(5448,1698,1146,156),USE(?String11:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kopâ'),AT(6646,1698,521,156),USE(?String11:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('brîvzonâm'),AT(7188,1698,625,156),USE(?String11:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,1198,0,729),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(1979,1458,5833,0),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(4219,1458,0,469),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5417,1458,0,469),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6615,1458,0,469),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(156,1198,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,313),USE(?unnamed:4)
         STRING(@n3),AT(219,10,208,154),USE(npk),CENTER
         STRING(@N_9.2B),AT(7271,10,521,154),USE(R14),RIGHT
         STRING(@N_10.2B),AT(6646,10,573,154),USE(R13),RIGHT
         STRING(@N_9.2B),AT(6073,10,521,154),USE(R12),RIGHT
         STRING(@N_10.2B),AT(5448,10,573,154),USE(R11),RIGHT
         STRING(@N_9.2B),AT(4875,10,521,154),USE(R10),RIGHT
         STRING(@N_10.2B),AT(4250,10,573,154),USE(R9),RIGHT
         STRING(@N_9.2B),AT(3677,10,521,154),USE(R8),RIGHT
         STRING(@N_10.2B),AT(3052,10,573,154),USE(R7),RIGHT
         LINE,AT(3021,,0,310),USE(?Line14:5),COLOR(COLOR:Black)
         LINE,AT(4219,,0,310),USE(?Line14:6),COLOR(COLOR:Black)
         LINE,AT(5417,,0,310),USE(?Line14:7),COLOR(COLOR:Black)
         LINE,AT(6615,,0,310),USE(?Line14:8),COLOR(COLOR:Black)
         LINE,AT(7813,,0,310),USE(?Line14:10),COLOR(COLOR:Black)
         STRING(@D06.),AT(2010,10,656,154),USE(GG:DOKDAT),LEFT
         STRING(@S13),AT(1021,156,938,154),USE(PAR:PVN),LEFT
         STRING(@S15),AT(2010,156,990,154),USE(DOK_NR),LEFT
         STRING(@S15),AT(1021,10,938,154),USE(PAR_NOS_S),LEFT
         STRING(@D05.),AT(500,10,469,154),USE(GGK:DATUMS),CENTER
         LINE,AT(469,,0,310),USE(?Line14:2),COLOR(COLOR:Black)
         LINE,AT(990,,0,310),USE(?Line14:3),COLOR(COLOR:Black)
         LINE,AT(1979,,0,310),USE(?Line14:4),COLOR(COLOR:Black)
         LINE,AT(156,,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,,0,310),USE(?Line14),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,896),USE(?unnamed)
         STRING(' - R:'),AT(7240,344),USE(?String50:2)
         STRING(@S1),AT(7500,344),USE(RS),CENTER
         LINE,AT(156,,0,220),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(3021,,0,220),USE(?Line24:3),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(3073,31,573,156),USE(R7K),RIGHT
         STRING(@N_9.2B),AT(3677,31,521,156),USE(R8K),RIGHT
         LINE,AT(4219,,0,220),USE(?Line24:4),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(4271,31,573,156),USE(R9K),RIGHT
         STRING(@N_9.2B),AT(4875,31,521,156),USE(R10K),RIGHT
         STRING(@N_10.2B),AT(5469,31,573,156),USE(R11K),RIGHT
         STRING(@N_9.2B),AT(6073,31,521,156),USE(R12K),RIGHT
         STRING(@N_10.2B),AT(6667,31,573,156),USE(R13K),RIGHT
         STRING(@N_9.2B),AT(7271,31,521,156),USE(R14K),RIGHT
         LINE,AT(156,208,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@d06.),AT(6740,219),USE(dat),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7365,219),USE(lai),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(417,417),USE(?String50)
         LINE,AT(1094,573,2552,0),USE(?Line36),COLOR(COLOR:Black)
         STRING(@s25),AT(1031,625,1938,208),USE(Sys:paraksts2),CENTER
         STRING(@d06.),AT(3021,625),USE(datums),LEFT
         STRING(@s5),AT(6865,344),USE(bkk_pvn),LEFT
         LINE,AT(7813,,0,220),USE(?Line24:8),COLOR(COLOR:Black)
         LINE,AT(6615,,0,220),USE(?Line24:6),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5417,0,0,220),USE(?Line24:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10850,8000,52),USE(?unnamed:2)
         LINE,AT(156,0,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('S1',S1)
  BIND('B_DAT',B_DAT)
  BIND('BKK_PVN',BKK_PVN)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('KKK',KKK)
  BKK_PVN = KKK
  S1 = '6'
  DATUMS=TODAY()
  NPK=0
  R7K= 0
  R8K= 0
  R9K= 0
  R10K= 0
  R11K= 0
  R12K= 0
  R13K= 0
  R14K= 0
  NUM#  = 0
  dat = today()
  lai = clock()
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
  ProgressWindow{Prop:Text} = 'Kokmateriâlu realizâcijas reìistrs'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)                             
      GGK:DATUMS=S_DAT
      CG = 'K1020'
      SET(ggk:DAT_key,GGK:DAT_key)
      Process:View{Prop:Filter} = '(GGK:BKK=BKK_PVN or GGK:BKK[1]=S1) AND ~CYCLEGGK(CG) AND ~(GGK:U_NR=1)'
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
        R7= 0
        R8= 0
        R9= 0
        R10= 0
        R11= 0
        R12= 0
        R13= 0
        R14= 0
!-------------analizçjam PVN kontu-----------------
        IF GGK:BKK=BKK_PVN
          CASE GGK:PVN_TIPS
          OF '5'                                   ! REALIZÇTS VAIRUMÂ
            IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
              R7=(GGK:SUMMA*100)/GGK:PVN_PROC
              R8=GGK:SUMMA
            ELSE                                   ! NAV PVN MAKSÂTÂJS
              R11=(GGK:SUMMA*100)/GGK:PVN_PROC
              R12=GGK:SUMMA
            .
          OF '6'                                   ! REALIZÇTS MAZUMÂ
            R9 =(GGK:SUMMA*100)/GGK:PVN_PROC
            R10=GGK:SUMMA
          .
!--------------REALIZÂCIJA BEZ PVN------------------
        ELSIF GGK:BKK[1]='6'
          C#=GETKON_K(GGK:BKK,2,1)
          LOOP R#=1 TO 2
            CASE KON:PVND[R#]        ! Neapliekamie darîjumi
            OF 44
              R13= GGK:SUMMA
            OF 45
              R13+= GGK:SUMMA
              R14= GGK:SUMMA
            .
          .
        .
        IF R7+R8+R9+R10+R11+R12+R13+R14
           I#=GETGG(GGK:U_NR)
           PAR_NOS_S=GETPAR_K(GGK:PAR_NR,0,4)
           NPK+=1
           DOK_NR=GG:DOK_SENR
           PRINT(RPT:DETAIL)
           R7K += R7
           R8K += R8
           R9K += R9
           R10K+= R10
           R11K+= R11
           R12K+= R12
           R13K+= R13
           R14K+= R14
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:FOOTER)                               
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
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
B_KOKU_I_REG         PROCEDURE                    ! Declare Procedure
!-----------------------------------------------------------------------------
CG                   STRING(10)
RPT_MENESIEM         STRING(8)
NPK                  DECIMAL(3)
R7                   DECIMAL(10,2)
R8                   DECIMAL(9,2)
R9                   DECIMAL(10,2)
R10                  DECIMAL(9,2)
R11                  DECIMAL(10,2)
R12                  DECIMAL(9,2)
R13                  DECIMAL(10,2)
R7K                  DECIMAL(10,2)
R8K                  DECIMAL(9,2)
R9K                  DECIMAL(10,2)
R10K                 DECIMAL(9,2)
R11K                 DECIMAL(10,2)
R12K                 DECIMAL(9,2)
R13K                 DECIMAL(10,2)
DAT                  LONG
DATUMS               LONG
LAI                  LONG
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
BKK_PVN              STRING(5)
DOK_NR               STRING(14)
PAR_NOS_S            LIKE(PAR:NOS_S)

!-----------------------------------------------------------------------------
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

!-----------------------------------------------------------------------------
report REPORT,AT(100,2067,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,150,8000,1917),USE(?unnamed:3)
         STRING('No neapl.'),AT(5865,1531,625,156),USE(?String11:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Imports'),AT(6542,1531,1250,156),USE(?String11:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Mazumtirdzniecîba'),AT(4615,1531,1198,156),USE(?String11:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('SAÒEMTO  (IEGÂDÂTO)  KOKMATERIÂLU  UZSKAITES  REÌISTRS'),AT(1083,156,5729,260),USE(?String1), |
             CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@S15),AT(2958,417,1771,260),USE(menesisunG),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums :'),AT(885,729),USE(?String7),LEFT
         STRING(@s45),AT(1719,729,3438,208),USE(client),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reìistrâcijas Nr :'),AT(375,938),USE(?String7:2),LEFT
         STRING(@s13),AT(1719,938,1094,208),USE(gl:vid_nr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7240,1000),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,1198,7656,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(417,1198,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1042,1198,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(2083,1198,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3333,1198,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Npk'),AT(188,1417,208,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(469,1417,573,156),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma partn.'),AT(1073,1333,990,156),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P/Z vai muitas dekl.'),AT(2115,1240,1198,208),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòemts (iegâdâts), Ls'),AT(3885,1240,3052,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN reì. Nr.'),AT(1073,1531,990,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(2219,1510,573,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('No apliek. pers.'),AT(3365,1531,1198,156),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sçrija Numurs'),AT(2219,1667,885,208),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(3365,1698,1198,156),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(4615,1698,1198,156),USE(?String11:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('personâm'),AT(5865,1698,625,156),USE(?String11:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba     PVN'),AT(6542,1698,1250,156),USE(?String11:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,1198,0,729),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(2083,1458,5729,0),USE(?Line6),COLOR(COLOR:Black)
         LINE,AT(4583,1458,0,469),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5833,1458,0,469),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6510,1458,0,469),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(156,1198,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,313),USE(?unnamed:4)
         STRING(@n3),AT(188,10,208,154),USE(npk),CENTER
         STRING(@N_10.2B),AT(6563,10,625,154),USE(R12),RIGHT
         STRING(@N_9.2B),AT(7188,10,573,154),USE(R13,,?R13:2),RIGHT
         STRING(@N_10.2B),AT(5865,10,625,154),USE(R11),RIGHT
         STRING(@N_9.2B),AT(5240,10,573,154),USE(R10),RIGHT
         STRING(@N_10.2B),AT(4615,10,625,154),USE(R9),RIGHT
         STRING(@N_9.2B),AT(3990,10,573,154),USE(R8),RIGHT
         STRING(@N_10.2B),AT(3365,10,625,154),USE(R7),RIGHT
         LINE,AT(3333,,0,310),USE(?Line14:5),COLOR(COLOR:Black)
         LINE,AT(4583,,0,310),USE(?Line14:6),COLOR(COLOR:Black)
         LINE,AT(5833,,0,310),USE(?Line14:7),COLOR(COLOR:Black)
         LINE,AT(6510,,0,310),USE(?Line14:8),COLOR(COLOR:Black)
         LINE,AT(7813,,0,310),USE(?Line14:10),COLOR(COLOR:Black)
         STRING(@D06.),AT(2135,10,813,156),USE(GG:DOKDAT),LEFT
         STRING(@S13),AT(1073,156,990,154),USE(PAR:PVN),LEFT
         STRING(@S15),AT(2135,156,938,154),USE(DOK_NR),LEFT
         STRING(@S15),AT(1073,10,990,154),USE(PAR_NOS_S),LEFT
         STRING(@D06.),AT(448,10,573,154),USE(GGK:DATUMS),CENTER
         LINE,AT(417,,0,310),USE(?Line14:2),COLOR(COLOR:Black)
         LINE,AT(1042,,0,310),USE(?Line14:3),COLOR(COLOR:Black)
         LINE,AT(2083,,0,310),USE(?Line14:4),COLOR(COLOR:Black)
         LINE,AT(156,0,7656,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,,0,310),USE(?Line14),COLOR(COLOR:Black)
       END
FOOTER DETAIL,AT(,,,896),USE(?unnamed)
         STRING(' - R:'),AT(7260,333),USE(?String50:2)
         STRING(@S1),AT(7521,333),USE(RS),CENTER
         LINE,AT(156,-10,0,220),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(3333,-10,0,220),USE(?Line24:3),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(3365,31,625,156),USE(R7K),RIGHT
         STRING(@N_9.2B),AT(3990,31,573,156),USE(R8K),RIGHT
         LINE,AT(4583,-10,0,220),USE(?Line24:4),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(4615,31,625,156),USE(R9K),RIGHT
         STRING(@N_9.2B),AT(5240,31,573,156),USE(R10K),RIGHT
         STRING(@N_10.2B),AT(5865,31,625,156),USE(R11K),RIGHT
         STRING(@N_9.2B),AT(7188,31,573,156),USE(R13K,,?R13K:2),RIGHT
         STRING(@N_10.2B),AT(6563,31,625,156),USE(R12K),RIGHT
         STRING('Sastâdîja :'),AT(417,417),USE(?String50)
         LINE,AT(1094,573,2552,0),USE(?Line36),COLOR(COLOR:Black)
         STRING(@s25),AT(979,625,2042,177),USE(Sys:paraksts2),CENTER
         STRING(@d06.),AT(3052,625),USE(datums),CENTER
         STRING(@s5),AT(6906,333),USE(bkk_pvn),LEFT
         LINE,AT(7813,-10,0,220),USE(?Line24:8),COLOR(COLOR:Black)
         LINE,AT(167,198,7656,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@d06.),AT(6760,219),USE(dat),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7365,219),USE(lai),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6510,-10,0,220),USE(?Line24:6),COLOR(COLOR:Black)
         LINE,AT(156,-10,7656,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,220),USE(?Line24:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,10850,8000,52),USE(?unnamed:2)
         LINE,AT(156,0,7656,0),USE(?Line1:5),COLOR(COLOR:Black)
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
  BIND('B_DAT',B_DAT)
  BIND('BKK_PVN',BKK_PVN)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)

  BKK_PVN = KKK
  DATUMS=TODAY()
  NPK=0
  R7K= 0
  R8K= 0
  R9K= 0
  R10K= 0
  R11K= 0
  R12K= 0
  R13K= 0
  NUM#  = 0
  dat = today()
  lai = clock()
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
  ProgressWindow{Prop:Text} = 'Iegâdâto kokmateriâlu reìistrs'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:DATUMS=S_DAT
      CG = 'K1010'
      SET(ggk:DAT_key,GGK:DAT_key)
      Process:View{Prop:Filter} = '(GGK:BKK=BKK_PVN) AND ~CYCLEGGK(CG) AND ~(GGK:U_NR=1)'
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
        R7= 0
        R8= 0
        R9= 0
        R10= 0
        R11= 0
        R12= 0
        R13= 0
        IF GGK:BKK=BKK_PVN
          CASE GGK:Pvn_tips
          OF '2'                                   ! IMPORTS
            R12=(GGK:SUMMA*100)/GGK:Pvn_proc
            R13=GGK:SUMMA
          OF '3'                                   ! IEPIRKTS VAIRUMÂ
          OROF '8'                                 ! PAKALPOJUMI
            IF GETPAR_K(GGK:PAR_NR,2,13)           ! IR PVN MAKSÂTÂJS
              R7=(GGK:SUMMA*100)/GGK:PVN_PROC
              R8=GGK:SUMMA
            ELSE                                   ! NAV PVN MAKSÂTÂJS
              R11=(GGK:SUMMA*100)/GGK:PVN_PROC
            .
          OF '4'                                   ! IEPIRKTS MAZUMÂ
            R9 =(GGK:SUMMA*100)/GGK:PVN_PROC
            R10=GGK:SUMMA
          .
        .
        IF R7+R8+R9+R10+R11+R12+R13
           I#=GETGG(GGK:U_NR)
           PAR_NOS_S=GETPAR_K(GGK:PAR_NR,0,4)
           NPK+=1
           DOK_NR=GG:DOK_SENR
           PRINT(RPT:DETAIL)
           R7K += R7
           R8K += R8
           R9K += R9
           R10K+= R10
           R11K+= R11
           R12K+= R12
           R13K+= R13
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:FOOTER)
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
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
