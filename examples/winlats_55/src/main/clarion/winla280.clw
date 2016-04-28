                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_PIE2_2013_XML  PROCEDURE                    ! Declare Procedure
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
SAK_MEN              STRING(2)
BEI_MEN              STRING(2)
BEI_DAT              STRING(2)
MENESS               STRING(20)
NPK                  ULONG
CG                   STRING(10)
NOT0                 STRING(10)
NOT1                 STRING(45)
NOT2                 STRING(45)
NOT3                 STRING(45)

R_TABLE      QUEUE,PRE(R)
KEY             STRING(23) !Elya
REG_NR          STRING(22)
SUMMA           DECIMAL(12,2)
V_KODS          STRING(2) !PAGAIDÂM NEIZMANTO
K               STRING(1)
             .

R_SUMMA              DECIMAL(12,2)
SUMMA_K              DECIMAL(12,2)
E                    STRING(1)
EE                   STRING(8)
DV                   STRING(1)  !DARÎJUMA VEIDS P/G

TEX:DUF             STRING(100)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
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
!report REPORT,AT(198,198,8000,10604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
!         THOUS
!       HEADER,AT(200,200,8000,302),USE(?unnamed:4)
!         STRING(@s1),AT(3635,21,365,260),USE(E),TRN,CENTER,FONT(,18,,FONT:bold,CHARSET:BALTIC)
!         STRING('PVN 2 '),AT(7250,115,521,156),USE(?String107:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
!       END
!RPT_Head DETAIL,AT(10,10,7990,1385),USE(?unnamed)
!         STRING(@s10),AT(7146,115,521,156),USE(NOT0)
!         STRING(@s45),AT(3177,708,3385,208),USE(client),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
!         STRING('Pârskats par preèu piegâdçm un sniegtajiem pakalpojumiem Eiropas Savienîbas teri' &|
!             'torijâ '),AT(344,52,6792,208),USE(?String11:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
!         STRING('.gada'),AT(2490,260),USE(?String120),FONT(,12,,FONT:bold,CHARSET:BALTIC)
!         STRING(@N4),AT(2052,260),USE(GADS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
!         STRING(@s20),AT(2969,260),USE(MENESS),FONT(,12,,FONT:bold,CHARSET:BALTIC)
!         STRING('Apliekamâs personas nosaukums'),AT(510,719),USE(?String1:6),FONT(,10,,,CHARSET:BALTIC)
!         STRING(@s6),AT(7240,1042),USE(GL:VID_LNR),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
!         STRING('Juridiskâ adrese'),AT(510,917),USE(?String1:7),FONT(,10,,,CHARSET:BALTIC)
!         STRING(@s45),AT(3177,917,3385,208),USE(gl:adrese),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
!         STRING(@s45),AT(5354,260,2396,156),USE(NOT1,,?NOT1:2),TRN,RIGHT(4)
!         STRING(@s45),AT(5354,385,2396,156),USE(NOT2),TRN,RIGHT(4)
!         STRING(@s8),AT(7094,854),USE(EE),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:ANSI)
!         STRING(@s45),AT(5354,510,2396,156),USE(NOT3),TRN,RIGHT(4)
!         STRING('Apliekamâs personas reìistrâcijas numurs'),AT(521,1125),USE(?String1:74),FONT(,10,,,CHARSET:BALTIC)
!         STRING(@s13),AT(3177,1115,1094,208),USE(gl:vid_nr,,?gl:vid_nr:2),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
!         STRING('Tâlrunis'),AT(4313,1125),USE(?String1:73),FONT(,10,,,CHARSET:BALTIC)
!         STRING(@s15),AT(4833,1115,1094,208),USE(SYS:TEL),LEFT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
!       END
!Head   DETAIL,AT(,,,1083),USE(?unnamed:2)
!         STRING('Valsts kods'),AT(1052,625,1458,208),USE(?String3:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('Darîjuma partnera ar PVN apliekamâs'),AT(2844,573,2292,156),USE(?String1:17),CENTER, |
!             FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('personas reìistrâcijas numurs '),AT(2750,729,2385,156),USE(?String1:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('(latos)'),AT(5625,729,625,156),USE(?String1:2),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         LINE,AT(417,521,6927,0),USE(?Line1),COLOR(COLOR:Black)
!         LINE,AT(2719,521,0,573),USE(?Line2:2),COLOR(COLOR:Black)
!         LINE,AT(5156,521,0,573),USE(?Line2:3),COLOR(COLOR:Black)
!         LINE,AT(417,885,6927,0),USE(?Line1:2),COLOR(COLOR:Black)
!         STRING('1'),AT(448,938,365,156),USE(?String3:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('2'),AT(948,938,1719,156),USE(?String3:92),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('3'),AT(2844,938,2292,156),USE(?String3:93),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('4'),AT(5188,938,1458,156),USE(?String3:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('5'),AT(6698,938,625,156),USE(?String3:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         STRING('NPK'),AT(448,625,365,208),USE(?String1:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         LINE,AT(833,521,0,573),USE(?Line2:6),COLOR(COLOR:Black)
!         LINE,AT(7344,521,0,573),USE(?Line2:5),COLOR(COLOR:Black)
!         STRING('K'),AT(6698,625,625,208),USE(?String1:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         LINE,AT(6667,521,0,573),USE(?Line2:4),COLOR(COLOR:Black)
!         STRING('Preèu piegâdes summa'),AT(5188,573,1458,156),USE(?String1:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
!         LINE,AT(417,521,0,573),USE(?Line2),COLOR(COLOR:Black)
!       END
!detail DETAIL,AT(,,,208)
!         LINE,AT(6667,0,0,229),USE(?Line2:11),COLOR(COLOR:Black)
!         LINE,AT(5156,0,0,229),USE(?Line2:10),COLOR(COLOR:Black)
!         LINE,AT(2719,-10,0,229),USE(?Line2:8),COLOR(COLOR:Black)
!         LINE,AT(833,0,0,229),USE(?Line2:13),COLOR(COLOR:Black)
!         STRING(@s2),AT(1521,52,677,156),USE(R:REG_NR[1:2]),CENTER
!         LINE,AT(7344,0,0,229),USE(?Line2:12),COLOR(COLOR:Black)
!         LINE,AT(417,0,6927,0),USE(?Line1:4),COLOR(COLOR:Black)
!         STRING(@s20),AT(3260,52,1458,156),USE(R:REG_NR[3:22]),CENTER(2)
!         STRING(@n_4),AT(469,52,,156),CNT,USE(NPK),RIGHT
!         LINE,AT(417,0,0,229),USE(?Line2:9),COLOR(COLOR:Black)
!         STRING(@n-_12.2),AT(5563,52,,156),USE(R:summa),RIGHT
!         STRING(@S1),AT(6833,52,417,156),USE(R:K),CENTER
!       END
!detail2 DETAIL,AT(,,,94)
!         LINE,AT(417,52,6927,0),USE(?Line1:3),COLOR(COLOR:Black)
!         LINE,AT(7344,0,0,115),USE(?Line2:19),COLOR(COLOR:Black)
!         LINE,AT(6667,0,0,115),USE(?Line2:18),COLOR(COLOR:Black)
!         LINE,AT(833,0,0,115),USE(?Line2:16),COLOR(COLOR:Black)
!         LINE,AT(2719,-10,0,115),USE(?Line2:32),COLOR(COLOR:Black)
!         LINE,AT(5156,0,0,115),USE(?Line2:17),COLOR(COLOR:Black)
!         LINE,AT(417,0,0,115),USE(?Line2:15),COLOR(COLOR:Black)
!       END
!FOOTER DETAIL,PAGEAFTER(-1),AT(,-10,,1604),USE(?unnamed:3)
!         LINE,AT(417,365,6927,0),USE(?Line31:19),COLOR(COLOR:Black)
!         STRING('G-preces P-pakalpojumi'),AT(6250,385,1104,135),USE(?String37:8),TRN,LEFT,FONT(,7,,,CHARSET:ANSI)
!         STRING('Atbildîgâ persona'),AT(365,573,938,177),USE(?String37:4),TRN,LEFT
!         STRING('RS: '),AT(7365,1375,208,208),USE(?String37),LEFT
!         STRING(@S1),AT(7573,1375,208,208),USE(RS),CENTER
!         STRING(@n-_13.2),AT(5500,208,,156),USE(summa_k),RIGHT
!         STRING('Kopâ : '),AT(938,208,1146,156),USE(?String33:9),LEFT
!         LINE,AT(833,0,0,365),USE(?Line32:27),COLOR(COLOR:Black)
!         LINE,AT(2969,1198,3438,0),USE(?Line55:3),COLOR(COLOR:Black)
!         STRING('200____. gada_____. _{23}'),AT(365,1250,2604,208),USE(?String37:7),TRN,LEFT
!         STRING('Valsts Ieòçmumu Dienesta atbildigâ amatpersona:'),AT(365,1042,2500,208),USE(?String37:3), |
!             LEFT
!         LINE,AT(1302,729,3021,0),USE(?Line55),COLOR(COLOR:Black)
!         STRING('(paraksts un tâ atðifrçjums)'),AT(2990,750,1406,208),USE(?String37:2),TRN,LEFT
!         STRING('200____. gada_____. _{23}'),AT(365,781,2604,208),USE(?String37:6),TRN,LEFT
!         STRING('(paraksts un tâ atðifrçjums)'),AT(3385,1250,1406,208),USE(?String37:5),TRN,LEFT
!         STRING(@s25),AT(4323,573),USE(SYS:PARAKSTS1),LEFT
!         LINE,AT(417,156,6927,0),USE(?Line31:18),COLOR(COLOR:Black)
!         LINE,AT(7344,0,0,365),USE(?Line32:25),COLOR(COLOR:Black)
!         LINE,AT(6667,0,0,365),USE(?Line32:7),COLOR(COLOR:Black)
!         LINE,AT(5156,0,0,365),USE(?Line32:24),COLOR(COLOR:Black)
!         LINE,AT(2719,0,0,365),USE(?Line32:23),COLOR(COLOR:Black)
!         LINE,AT(417,0,0,365),USE(?Line32:22),COLOR(COLOR:Black)
!       END
!       FOOTER,AT(200,10900,8000,188),USE(?unnamed:5)
!         LINE,AT(104,0,10365,0),USE(?Line48:3),COLOR(COLOR:Black)
!         STRING(@PLapa<<<#/______P),AT(6823,21),PAGENO,USE(?PageCount),RIGHT
!       END
!     END


Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

 OMIT('MARIS')
!detail3 DETAIL,PAGEAFTER(-1),AT(,,,1354)
!         LINE,AT(104,260,10365,0),USE(?Line1:19),COLOR(00H)
!         STRING('RS: '),AT(417,1094,271,208) ,USE(?String37),LEFT
!         STRING(@S1),AT(729,1094,208,208) ,USE(RS),CENTER
!         STRING(@n-_12.2),AT(5000,104,781,156) ,USE(pvn_summa_k),RIGHT
!         STRING(@n-_13.2),AT(4063,104,,156) ,USE(dok_summa_k),RIGHT
!         STRING('Kopâ : '),AT(625,104,1146,156),FONT(,8,,FONT:bold,CHARSET:BALTIC),USE(?String3:9),LEFT
!         LINE,AT(10469,0,0,260),USE(?Line2:28),COLOR(00H)
!         LINE,AT(521,0,0,260),USE(?Line2:27),COLOR(00H)
!         STRING(@d6),AT(8802,521) ,USE(datums)
!         STRING('Uzòçmuma vadîtâjs'),AT(260,521),USE(?String55:3)
!         STRING('Grâmatvedis'),AT(4583,521),USE(?String55)
!         LINE,AT(1458,729,2552,0),USE(?Line55),COLOR(00H)
!         LINE,AT(5365,729,2552,0),USE(?Line55:2),COLOR(00H)
!         STRING('(paraksts un tâ atðifrçjums)'),AT(1823,781),USE(?String55:2)
!         STRING('(paraksts un tâ atðifrçjums)'),AT(5729,781),USE(?String55:4)
!         LINE,AT(104,52,10365,0),USE(?Line1:18),COLOR(00H)
!         LINE,AT(8385,0,0,260),USE(?Line2:38),COLOR(00H)
!         LINE,AT(9427,0,0,260),USE(?Line2:39),COLOR(00H)
!         LINE,AT(7813,0,0,260),USE(?Line2:7),COLOR(00H)
!         LINE,AT(5833,0,0,260),USE(?Line2:26),COLOR(00H)
!         LINE,AT(4948,0,0,260),USE(?Line2:25),COLOR(00H)
!         LINE,AT(4010,0,0,260),USE(?Line2:24),COLOR(00H)
!         LINE,AT(2813,0,0,260),USE(?Line2:23),COLOR(00H)
!         LINE,AT(104,0,0,260),USE(?Line2:22),COLOR(00H)
!       END
 MARIS
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  IF F:XML
     EE='PVN2.XML'
  .
  MENESS=MENVAR(MEN_NR,1,2)
  IF S_DAT >= DATE(1,1,2006) !N42
       NOT0=''
       NOT1=''
       NOT2=''
       NOT3=''
  ELSIF S_DAT >= DATE(7,1,2005) !VID RÎKOJUMS N1414
       NOT0='Pielikums'
       NOT1='ar Valsts ieòçmumu dienesta'
       NOT2='2005.gada 12.jûlija rîkojumu Nr.1414'
       NOT3='apstiprinâtajiem metodiskajiem norâdîjumiem'
  ELSE
       NOT0='Pielikums'
       NOT1='Ministru kabineta'
       NOT2='2004.g.13.janvâra'
       NOT3='noteikumiem Nr 29'
  .
!    IF F:XML THEN E='E' ELSE E=''. PAGAIDÂM VÇL NAV

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
  ProgressWindow{Prop:Text} = 'PVN 2'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:DATUMS=S_DAT
      SET(GGK:DAT_key,GGK:DAT_KEY)
      CG = 'K102000'
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
!      IF F:DBF='W'   !WMF
!        OPEN(report)
!        report{Prop:Preview} = PrintPreviewImage
!      ELSE           !EXCEL,WORD
!        IF ~OPENANSI('PVN_PIE.TXT')
!           POST(Event:CloseWindow)
!           CYCLE
!        .
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        OUTA:LINE=' {50}VALSTS IEÒÇMUMU DIENESTS'
!        ADD(OUTFILEANSI)
!        OUTA:LINE=' {25}Pârskats par preèu piegâdçm un sniegtajiem pakalpojumiem Eiropas Savienîbas teritorijâ'
!        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        OUTA:LINE='Taksâcijas periods:'&CHR(9)&GL:DB_GADS&'. gads '&MENESS
!        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas nosaukums'&chr(9)&CLIENT
!        ADD(OUTFILEANSI)
!        OUTA:LINE='Ar pievienotâs vçrtîbas nodokli apliekamâs personas reìistrâcijas numurs'&chr(9)&GL:VID_NR
!        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        IF F:DBF='E'   !EXCEL
!           OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera'&CHR(9)&'Preèu vai'&CHR(9)&|
!           'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta'
!           ADD(OUTFILEANSI)
!           OUTA:LINE=CHR(9)&CHR(9)&'ar PVN apliekamâs'&CHR(9)&'pakalpojumu'&CHR(9)&CHR(9)&'Nosaukums'&CHR(9)&'Sçrija '&|
!           CHR(9)&'Numurs'&CHR(9)&'Datums'
!           ADD(OUTFILEANSI)
!           OUTA:LINE=CHR(9)&CHR(9)&'personas reì. Nr'&CHR(9)&'vçrtîba'
!           ADD(OUTFILEANSI)
!           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'bez PVN (Ls)'
!           ADD(OUTFILEANSI)
!        ELSE
!           OUTA:LINE='NPK'&CHR(9)&'Darîjuma partnera nosaukums'&CHR(9)&'Darîjuma partnera ar PVN apliekamâs personas reì. Nr'&|
!           CHR(9)&'Preèu vai pakalpojumu vçrtîba bez PVN (Ls)'&CHR(9)&'PVN, Ls'&CHR(9)&'Attaisnojuma dokumenta Nosaukums'&|
!           CHR(9)&'Sçrija '&CHR(9)&'Datums'
!         .
!!        OUTA:LINE=''
!!        ADD(OUTFILEANSI)
!      .
      IF F:XML
        XMLFILENAME=USERFOLDER&'\PVN_D.XML'
        CHECKOPEN(OUTFILEXML,1)
        CLOSE(OUTFILEXML)
        OPEN(OUTFILEXML,18)
        IF ERROR()
           KLUDA(1,XMLFILENAME)
        ELSE
!           EMPTY(OUTFILEXML)
           F:XML_OK#=TRUE
!           XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
!           ADD(OUTFILEXML)
!           XML:LINE=' KSParsk>'
!           ADD(OUTFILEXML)
!           IF ~GL:VID_NR THEN KLUDA(87,'Jûsu NMR kods').
!           XML:LINE=' NmrKods>'&GL:REG_NR&'</NmrKods>'
!           ADD(OUTFILEXML)
!           XML:LINE=' ParskGads>'&YEAR(B_DAT)&'</ParskGads>'
!           ADD(OUTFILEXML)
!           XML:LINE=' ParskMen>'&MONTH(B_DAT)&'</ParskMen>'
!           ADD(OUTFILEXML)
!           TEX:DUF=CLIENT
!           DO CONVERT_TEX:DUF
!           XML:LINE=' NmNosaukums>'&CLIP(TEX:DUF)&'</NmNosaukums>'
!           ADD(OUTFILEXML)
!           XML:LINE=' Amats>'&CLIP(SYS:AMATS1)&'</Amats>'
!           ADD(OUTFILEXML)
!           XML:LINE=' Talrunis>'&CLIP(SYS:TEL)&'</Talrunis>'
!           ADD(OUTFILEXML)
!           XML:LINE=' SastDat>'&FORMAT(TODAY(),@D010-)&'T00:00:00</SastDat>'
!           ADD(OUTFILEXML)
!           XML:LINE=' AtbPers>'&CLIP(SYS:PARAKSTS1)&'</AtbPers>'
!           ADD(OUTFILEXML)
!           XML:LINE=' Tab>'
!           ADD(OUTFILEXML)
!           XML:LINE=' Rs>'
!           ADD(OUTFILEXML)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         nk#+=1
         ?Progress:UserString{Prop:Text}=NK#
         DISPLAY(?Progress:UserString)
!         IF INSTRING(GGK:BKK[1],'568') AND GGK:SUMMA AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
         !Elya IF INSTRING(GGK:BKK[1],'68') AND GGK:SUMMA AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
         IF GETKON_K(GGK:BKK,2,6,'U_Nr='&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))  AND GGK:SUMMA AND GGK:D_K='K' !IR DEFINÇTI NEAPL. DARÎJUMI
 !stop(ggk:summa)
            R_SUMMA=0
!            stop (GGK:BKK)
!                stop (GETPAR_K(GGK:PAR_NR,0,20))
            IF GETPAR_K(GGK:PAR_NR,0,20)='C' !C=ES
               C#=GETKON_K(GGK:BKK,2,1)
               DV='G' !PRECE
               LOOP R#=1 TO 2
!                  stop(KON:PVND[R#]&' '&GGK:SUMMA)
                  CASE KON:PVND[R#]
                  !Elya un ari seit var but 45 0% (preces uz ES (trissturveida darijumi) ar S piez. un sask 33.p 3.dala ar C piez.)
                  OF 45
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='G' !PRECES
                  OF 458
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='S' !PRECES
                  OF 450
                     R_SUMMA += GGK:SUMMA      ! ES PRECES
                     DV='C' !PRECES
                  OF 482
                     R_SUMMA += GGK:SUMMA      ! ES PAKALPOJUMI
                     DV='P' !PAKALPOJUMI
                  !Elya 
!                  OF 43                        ! Neapliekamie darîjumi
!                     R_SUMMA += GGK:SUMMA
!                  OF 44                    
!    !                 R44 += GGK:SUMMA         ! BRÎVOSTAS UN SEZ
!                  OF 45
!                     R_SUMMA += GGK:SUMMA      ! ES PRECES
!                     DV='G' !PRECES
!                  OF 46
!                     R_SUMMA += GGK:SUMMA      ! ES MONTÂÞAS DARBI
!                  OF 47
!                     R_SUMMA += GGK:SUMMA      ! ES JAUNAS A/M
!                  OF 48
!                     R_SUMMA += GGK:SUMMA      ! ÐITAM TE NEVAJADZÇTU BÛT
!                     DV='P' !PAKALPOJUMI
!                  OF 481
!                     R_SUMMA += GGK:SUMMA      !
!                  OF 482
!                     R_SUMMA += GGK:SUMMA      ! ES PAKALPOJUMI
!                     DV='P' !PAKALPOJUMI
!                  OF 49
!    !                 R49 += GGK:SUMMA
                  ELSE
    !                 KLÛDA
                  .
                  IF R_SUMMA THEN BREAK.       ! LAI NENODUBLÇ
               .
               IF R_SUMMA
                  R:REG_NR=PAR:PVN !S22
                  R:K=DV
                  !Elya GET(R_TABLE,R:REG_NR)
                  R:KEY=CLIP(R:REG_NR)&R:K
                  GET(R_TABLE,R:KEY)
                  IF ERROR()
                     R:SUMMA =R_SUMMA
    !                 R:V_KODS=PAR:V_KODS
                     R:REG_NR=PAR:PVN !S22
                     R:K=DV
                     ADD(R_TABLE)
                     !Elya SORT(R_TABLE,R:REG_NR)
                     SORT(R_TABLE,R:KEY)
                  ELSE
                     R:SUMMA +=R_SUMMA
                     PUT(R_TABLE)
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(R_TABLE,R:REG_NR)
!    PRINT(RPT:RPT_HEAD)
!    PRINT(RPT:HEAD)
    IF F:XML_OK#=TRUE
       XML:LINE=' PVN2>'
       ADD(OUTFILEXML)
    .
    LOOP I#= 1 TO RECORDS(R_TABLE)
       GET(R_TABLE,I#)
       SUMMA_K+=R:SUMMA
       NPK+=1
!       IF F:DBF = 'W'
!          PRINT(RPT:DETAIL)
!       ELSE
!!           OUTA:LINE=NPK&CHR(9)&PAR_NOS_P&CHR(9)&PERS_KODS&CHR(9)&FORMAT(DOK_SUMMA,@N12.2)&CHR(9)&FORMAT(PVN_SUMMA,@N12.2)&CHR(9)&ATTDOK&CHR(9)&FORMAT(GG:DOK_SE,@S7)&CHR(9)&FORMAT(GG:DOK_NR,@N_10)&CHR(9)&FORMAT(GG:DATUMS,@D6)
!!           ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
!       END
       IF F:XML_OK#=TRUE
          XML:LINE=' R>'
          ADD(OUTFILEXML)
          IF ~R:REG_NR[1:2] THEN KLUDA(87,CLIP(getpar_k(R:REG_NR,0,1))&' Valsts kods').
          XML:LINE=' Valsts>'&R:REG_NR[1:2]&'</Valsts>'
          ADD(OUTFILEXML)
          IF ~CLIP(R:REG_NR[3:22]) THEN KLUDA(87,CLIP(GETPAR_K(R:REG_NR,0,1))&' NMR kods'). !dati:max=11z ???
   !       XML:LINE=' PVNNumurs>'&CLIP(R:REG_NR[3:13])&'</PVNNumurs>'
          XML:LINE=' PVNNumurs>'&CLIP(R:REG_NR[3:22])&'</PVNNumurs>'                        !atïaujam 20,EDS pârbauda
          ADD(OUTFILEXML)
          XML:LINE=' Summa>'&R:summa&'</Summa>'
          ADD(OUTFILEXML)
          XML:LINE=' Pazime>'&R:K&'</Pazime>'
          ADD(OUTFILEXML)
          XML:LINE=' /R>'
          ADD(OUTFILEXML)
       .
    .

!    PRINT(RPT:DETAIL2)
!    PRINT(RPT:FOOTER)
!    IF F:DBF = 'W'
!        ENDPAGE(report)
!    ELSE
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!!        OUTA:LINE='Kopâ: {55}'&CHR(9)&CHR(9)&CHR(9)&FORMAT(DOK_SUMMA_K,@N12.2)&CHR(9)&FORMAT(PVN_SUMMA_K,@N12.2)
!        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
!        OUTA:LINE=' Uzòçmuma vadîtâjs____________________'&CHR(9)&'Grâmatvedis____________________'
!        ADD(OUTFILEANSI)
!    END
    CLOSE(ProgressWindow)
!    IF F:DBF='W'   !WMF
!      RP
!      IF Globalresponse = RequestCompleted
!         loop J#=1 to PR:SKAITS
!            report{Prop:FlushPreview} = True
!            IF ~(J#=PR:SKAITS)
!               loop I#= 1 to RECORDS(PrintPreviewQueue1)
!                  GET(PrintPreviewQueue1,I#)
!                  PrintPreviewImage=PrintPreviewImage1
!                  add(PrintPreviewQueue)
!               .
!            .
!         .
!      END
!    ELSE
!        ANSIJOB
!    .
  .
!  IF F:DBF='W'   !WMF
!     CLOSE(report)
!     FREE(PrintPreviewQueue)
!     FREE(PrintPreviewQueue1)
!  ELSE           !RTF,EXCEL
!     CLOSE(OUTFILEANSI)
!     ANSIFILENAME=''
!  .
  IF F:XML_OK#=TRUE
!     XML:LINE=' /Rs>'
!     ADD(OUTFILEXML)
!     XML:LINE=' /Tab>'
!     ADD(OUTFILEXML)
!     XML:LINE=' /KSParsk>'
!     ADD(OUTFILEXML)
!!       CLOSE(OUTFILEXML)
!
     XML:LINE=' /PVN2>'
     ADD(OUTFILEXML)
     XML:LINE='</DokPVNv4>' !BEIDZAS DOKUMENTS
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END
!-----------------------------------------------------------------------------
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
