                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_VestuleKlientam    PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
FilesOpened          LONG

opc                  BYTE
samaksatlidz         DATE
laikaperiods         STRING(24)
PAR_ban_NR           STRING(18)
pamatX               STRING(60)
gov_reg              STRING(45)
banka1               string(45)
banka2               string(45)
RMENESIS             STRING(11)
RNAKMENESIS          STRING(11)
RAIZNAKMENESIS       STRING(11)
VestulesTips         STRING(11)
pvn                  DECIMAL(9,2)
apmaksai             DECIMAL(9,2)
sumvar1              STRING(70)
sumvar2              STRING(70)
bridin1              STRING(100)
BRIDIN2              STRING(100)
BRIDIN3              STRING(100)
SamSumma             Decimal(12,2)
SamDat1              LONG

SamDat               LONG,DIM(100)
SummaKopa            DECIMAL(12,2)
PrecuNosaukums       string(55),dim(100,2)
PN                   string(55),dim(100)
DokumentaNr          STRING(20),dim(100)
PrecuSumma           DECIMAL(12,2),dim(100)

PrecuNosaukums1      string(55)
DokumentaNr1         STRING(20)
PrecuSumma1          DECIMAL(12,2)
GG_DOK_SENR          LIKE(GG:DOK_SENR)
GG_APMDAT            LIKE(GG:APMDAT)
LIDZ_TEX             STRING(60)
LIDZ_DAT             LONG
TEX_V                BYTE

CLIENT1              STRING(40)
CLIENT2              STRING(40)
adrese               string(60)
adrese1              string(50)
adrese2              string(50)
NOS_P                string(35),DIM(3,2)
ADR                  string(45),DIM(3,2)
LINE                 STRING(132)
dat                  long
FixVesture           BYTE
kam                  STRING(30)
SASKANA              STRING(80)
SASKANA1             STRING(80)
bridinajums          STRING(12)
X                    BYTE
SAV_OPC              BYTE

SYS_AMATS            STRING(25)
SvitraParakstam      STRING(28)
SYS_PARAKSTS         STRING(25)
CODE39               STRING(30) !1+25+3+1
CODE39_TEXT          STRING(60)
SYS_BAITS            BYTE !00000001B=MAKARONU PARAKSTS
REIZES               BYTE(1)

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:VAL)
                     END

!
!         DETAIL 3 JÂBÛT ÐÂDAM (FORMATIERIS NOMAITÂ)
!         STRING(@s132),AT(604,10,7083,208),FONT('Times New Roman Baltic',10,,FONT:bold,CHARSET:BALTIC),USE(LINE)
!


Report REPORT,AT(0,500,8438,12000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
detailA DETAIL,AT(,,,1969),USE(?unnamed)
         LINE,AT(469,156,7813,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@s45),AT(2552,208,2896,156),USE(client),LEFT(1)
         STRING(@s60),AT(2552,344,2865,156),USE(GL:ADRESE)
         STRING(@s12),AT(5469,313),USE(bridinajums),LEFT,FONT(,28,COLOR:Gray,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(3125,469,2292,156),USE(sys:adrese,,?sys:adrese:2)
         STRING('Pasta adr.:'),AT(2552,479,573,156),USE(?String66:2)
         STRING(@s15),AT(2552,615,1042,156),USE(sys:tel)
         STRING(@s35),AT(2552,750,2500,156),USE(sys:e_mail),LEFT(1)
         LINE,AT(469,938,7813,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@d06.),AT(6979,990),USE(dat),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(521,1094,3750,188),USE(CLIENT1),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(521,1260,3750,219),USE(CLIENT2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(521,1479,3802,188),USE(ADRESE1),CENTER
         STRING(@s50),AT(521,1635,3802,188),USE(ADRESE2),TRN,CENTER
       END
detailKAM DETAIL
         STRING(@s30),AT(2427,104,3427,208),USE(kam),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
detail0 DETAIL,AT(,,,979)
         STRING(@s50),AT(2240,52,3802,208),USE(pamatX),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(1146,260,5990,156),USE(saskana),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s80),AT(1146,469,5990,156),USE(saskana1),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('Nr'),AT(938,729,260,208),USE(?String45),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Apmaksas termiòð'),AT(1875,729),USE(?String25),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(3750,729),USE(?String23),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Parâda Summa'),AT(6719,729),USE(?String24:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,938,7344,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,31,,208)
         STRING(@s55),AT(2969,10,3729,156),USE(Precunosaukums1)
         STRING(@s14),AT(781,10,1354,156),USE(DokumentaNr1),CENTER
         STRING(@n-11.2B),AT(6875,10,729,156),USE(Precusumma1),RIGHT(1)
         STRING(@d06.B),AT(2188,10,729,156),USE(samdat1)
       END
detail2 DETAIL,AT(,,,510)
         LINE,AT(469,31,7813,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@n-11.2B),AT(6875,104,729,208),USE(SummaKopa),RIGHT(1)
         STRING(@s80),AT(1198,313,5990,156),USE(LIDZ_TEX),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('Summa kopâ :'),AT(5781,104),USE(?String19:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
       END
detail3 DETAIL,AT(,,,219)
         STRING(@s132),AT(604,10,7083,208),USE(LINE),FONT(,11,,,CHARSET:BALTIC) !         STRING(@s132),AT(604,10,7083,208),FONT('Times New Roman Baltic',10,,FONT:bold,CHARSET:BALTIC),USE(LINE)
       END
detail4 DETAIL,AT(,,,823),USE(?unnamed:2)
         STRING(@s25),AT(2688,188),USE(SYS_AMATS),TRN,RIGHT
         STRING(@s23),AT(6313,188),USE(SYS_PARAKSTS),TRN,LEFT
         STRING(' '),AT(5156,94),USE(?String22)
         STRING(@s30),AT(4365,188),USE(SVITRAPARAKSTAM),TRN
         STRING(@s30),AT(3771,365,4052,240),USE(code39),TRN,CENTER,FONT('Code 3 de 9',36,,FONT:regular,CHARSET:SYMBOL)
         STRING(@s60),AT(458,625,4052,177),USE(code39_text),TRN
       END
detailz DETAIL,AT(,,,2177)
         STRING('Pateicamies par sadarbîbu'),AT(1823,208),USE(?String26)
         STRING('gaiðus Ziemassvçtkus un veiksmîgu Jauno 2005. gadu'),AT(1823,1042),USE(?String29)
         STRING(@s35),AT(1823,417,2708,208),USE(PAR:NOS_P,,?PAR:NOS_P:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('kolektîvam'),AT(1823,625),USE(?String27)
         STRING('un novçlam'),AT(1823,833),USE(?String28)
       END
detailADR_K DETAIL,AT(,,,1948)
         STRING(@s45),AT(104,1302,4583,208),USE(PAR:NOS_P,,?PAR:NOS_P:3),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(52,1510,4688,156),USE(ADRESE),CENTER
       END
detailADR_L DETAIL,AT(,,8438,1448),USE(?unnamed:3)
         STRING(@s35),AT(5479,0,2646,208),USE(NOS_P[3,1]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(5479,188,2646,208),USE(NOS_P[3,2]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(94,0,2650,208),USE(NOS_P[1,1]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(2781,0,2646,208),USE(NOS_P[2,1]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(94,188,2646,208),USE(NOS_P[1,2]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(2781,188,2646,208),USE(NOS_P[2,2]),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(94,396,2656,208),USE(ADR[1,1]),CENTER
         STRING(@s45),AT(94,552,2656,208),USE(ADR[1,2]),CENTER
         STRING(@s45),AT(2781,396,2656,208),USE(ADR[2,1]),CENTER
         STRING(@s45),AT(2781,552,2656,208),USE(ADR[2,2]),CENTER
         STRING(@s45),AT(5479,385,2656,208),USE(ADR[3,1]),CENTER
         STRING(@s45),AT(5479,552,2656,208),USE(ADR[3,2]),CENTER
       END
detailADR_T DETAIL,AT(,,8438,1448)
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

window0 WINDOW('Norâdiet darba veidu'),AT(,,201,97),GRAY
       OPTION,AT(4,7,190,65),USE(OPC),BOXED
         RADIO('Vçstule par parâdiem'),AT(11,17,115,10),USE(?OPC:Radio1),VALUE('1')
         RADIO('Adrese uz parastâ konverta'),AT(11,27),USE(?OPC:Radio3),VALUE('3')
         RADIO('Adrese uz uzlîmjpapîra A4(8x3),atkârtot reizes '),AT(11,36,161,10),USE(?OPC:Radio4),VALUE('4')
         RADIO('Adrese uz uzlîmjpapîra pçc saraksta, kur X='),AT(11,47,154,10),USE(?OPC:Radio5),VALUE('5')
         RADIO('Vçstule'),AT(11,58),USE(?OPC:Radio6),VALUE('6')
       END
       ENTRY(@N2B),AT(174,33,13,12),USE(REIZES),DISABLE,CENTER
       ENTRY(@N1B),AT(165,46,13,12),USE(X),DISABLE,CENTER
       BUTTON('D&rukas parametri'),AT(33,76,78,14),USE(?Button:DRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       BUTTON('&OK'),AT(115,76,35,14),USE(?OkButton0),DEFAULT
       BUTTON('&Atlikt'),AT(155,76,36,14),USE(?CancelButton0)
     END


window1 WINDOW('Vçstules sagatavoðana'),AT(50,50,381,269),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC), |
         GRAY
       OPTION('Labajâ augðçjâ stûri'),AT(272,2,101,44),USE(VestulesTips),BOXED
         RADIO('Tukðs'),AT(277,13),USE(?VestulesTips:Radio1)
         RADIO('Brîdinâjums'),AT(277,23),USE(?VestulesTips:Radio2),VALUE('B')
         RADIO('Atgâdinâjums'),AT(277,33),USE(?VestulesTips:Radio3),VALUE('A')
       END
       STRING(@s40),AT(68,13,166,10),USE(adrese,,?ADRESE:1)
       STRING('Dok.Nr'),AT(234,47,28,10),USE(?String13)
       STRING('Parâda Summa'),AT(295,47),USE(?String14)
       STRING('Atrasti sekojoði neapmaksâti dokumenti:'),AT(13,31),USE(?String18)
       BUTTON('Aizvietot ar DOK_DAT un SUMMU'),AT(13,42,137,14),USE(?ButtonTEX)
       ENTRY(@s55),AT(13,59,207,11),USE(PN[1])
       ENTRY(@S20),AT(225,59,63,11),USE(DokumentaNr[1]),CENTER
       STRING(@n_12.2B),AT(296,59),USE(PrecuSumma[1])
       ENTRY(@s55),AT(13,72,207,11),USE(PN[2])
       ENTRY(@s20),AT(225,72,63,11),USE(DokumentaNr[2]),CENTER
       STRING(@n_12.2B),AT(296,72),USE(PrecuSumma[2])
       ENTRY(@s55),AT(13,85,207,11),USE(PN[3])
       ENTRY(@s20),AT(225,85,63,11),USE(DokumentaNr[3]),CENTER
       STRING(@n_12.2B),AT(296,85),USE(PrecuSumma[3])
       ENTRY(@s55),AT(13,98,207,11),USE(PN[4])
       ENTRY(@s20),AT(225,98,63,11),USE(DokumentaNr[4]),CENTER
       STRING(@n_12.2B),AT(296,98),USE(PrecuSumma[4])
       ENTRY(@s55),AT(13,111,207,11),USE(PN[5])
       ENTRY(@s20),AT(225,111,63,11),USE(DokumentaNr[5]),CENTER
       STRING(@n_12.2B),AT(296,111),USE(PrecuSumma[5])
       ENTRY(@s55),AT(13,124,207,11),USE(PN[6])
       ENTRY(@s20),AT(225,124,63,11),USE(DokumentaNr[6]),CENTER
       STRING(@n_12.2B),AT(296,124),USE(PrecuSumma[6])
       ENTRY(@s55),AT(13,137,207,11),USE(PN[7])
       ENTRY(@s20),AT(225,137,63,11),USE(DokumentaNr[7]),CENTER
       STRING(@n_12.2B),AT(296,137),USE(PrecuSumma[7])
       ENTRY(@s55),AT(13,150,207,11),USE(PN[8])
       ENTRY(@s20),AT(225,150,63,11),USE(DokumentaNr[8]),CENTER
       STRING(@n_12.2B),AT(296,151),USE(PrecuSumma[8])
       ENTRY(@s55),AT(13,162,207,11),USE(PN[9])
       ENTRY(@s20),AT(225,162,63,11),USE(DokumentaNr[9]),CENTER
       ENTRY(@N-_11.2B),AT(292,162,48,11),USE(PrecuSumma[9]),RIGHT
       ENTRY(@s55),AT(13,175,207,11),USE(PN[10])
       ENTRY(@s20),AT(225,175,63,11),USE(DokumentaNr[10]),CENTER
       ENTRY(@N-_11.2B),AT(292,175,48,11),USE(PrecuSumma[10]),RIGHT
       STRING('Lûdzam Jûs apmaksât parâda summu lîdz'),AT(24,190),USE(?StringLudzam)
       ENTRY(@d6),AT(161,188,43,11),USE(LIDZ_DAT)
       BUTTON('Teksta fails:'),AT(78,204,48,14),USE(?Tekstafails)
       STRING(@s60),AT(77,220,207,10),USE(ansifilename)
       BUTTON('Mainît teksta failu'),AT(133,204,71,14),USE(?Mainit)
       BUTTON('Fiksçt vçsturç un PAR_K'),AT(165,241,97,14),USE(?ButtonFixVesture),HIDE,TIP('Partnerim atzîme 10-vçstule')
       IMAGE('CHECK3.ICO'),AT(263,238,18,22),USE(?ImageFixVesture),HIDE
       OPTION('Paraksts:'),AT(12,202,53,61),USE(sys_paraksts_nr),BOXED
         RADIO('Nav'),AT(14,211,37,10),USE(?sys_paraksts_nr:OPTION0),VALUE('0')
         RADIO('1.paraksts'),AT(14,221,47,10),USE(?sys_paraksts_nr:OPTION1),VALUE('1')
         RADIO('2.paraksts'),AT(14,231,45,10),USE(?sys_paraksts_nr:OPTION2),VALUE('2')
         RADIO('3.paraksts'),AT(14,240,45,10),USE(?sys_paraksts_nr:OPTION3),VALUE('3')
         RADIO('Login'),AT(14,250,45,10),USE(?sys_paraksts_nr:OPTION4),VALUE('4')
       END
       BUTTON('Drukât svîtru parakstu'),AT(66,241,79,14),USE(?Button:MAKARONI)
       IMAGE('CHECK3.ICO'),AT(146,238,15,20),USE(?Image:MAKARONI),HIDE
       BUTTON('D&rukas parametri'),AT(292,227,78,14),USE(?Button:DRUKA:1),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
       BUTTON('&OK'),AT(293,243,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(334,243,36,14),USE(?CancelButton)
     END

window2 WINDOW('Vçstules sagatavoðana'),AT(50,50,302,95),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING(@s40),AT(71,22,166,10),USE(adrese,,?ADRESE:11)
       BUTTON('Teksta fails'),AT(17,37,48,14),USE(?Tekstafails2)
       STRING(@s60),AT(71,39,222,10),USE(ansifilename,,?ANSIFILENAME:1)
       BUTTON('Mainît teksta failu'),AT(17,57,71,14),USE(?Mainit2)
       BUTTON('&OK'),AT(202,57,35,14),USE(?OkButton2),DEFAULT
       BUTTON('Atlikt'),AT(245,57,36,14),USE(?CancelButton2)
     END

uzlimes WINDOW('Norâdiet uzlîmi'),AT(50,50,135,162),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       BUTTON('1:1'),AT(12,13,35,14),USE(?Button11)
       BUTTON('1:2'),AT(49,13,35,14),USE(?Button12)
       BUTTON('1:3'),AT(86,13,35,14),USE(?Button13)
       BUTTON('2:1'),AT(12,28,35,14),USE(?Button21)
       BUTTON('2:2'),AT(49,28,35,14),USE(?Button22)
       BUTTON('2:3'),AT(86,28,35,14),USE(?Button23)
       BUTTON('3:1'),AT(12,43,35,14),USE(?Button31)
       BUTTON('3:2'),AT(49,43,35,14),USE(?Button32)
       BUTTON('3:3'),AT(86,43,35,14),USE(?Button33)
       BUTTON('4:1'),AT(12,58,35,14),USE(?Button41)
       BUTTON('4:2'),AT(49,58,35,14),USE(?Button42)
       BUTTON('4:3'),AT(86,58,35,14),USE(?Button43)
       BUTTON('5:1'),AT(12,73,35,14),USE(?Button51)
       BUTTON('5:2'),AT(49,73,35,14),USE(?Button52)
       BUTTON('5:3'),AT(86,73,35,14),USE(?Button53)
       BUTTON('6:1'),AT(12,88,35,14),USE(?Button61)
       BUTTON('6:2'),AT(49,88,35,14),USE(?Button62)
       BUTTON('6:3'),AT(86,88,35,14),USE(?Button63)
       BUTTON('7:1'),AT(12,103,35,14),USE(?Button71)
       BUTTON('7:2'),AT(49,103,35,14),USE(?Button72)
       BUTTON('7:3'),AT(86,103,35,14),USE(?Button73)
       BUTTON('8:1'),AT(12,118,35,14),USE(?Button81)
       BUTTON('8:2'),AT(49,118,35,14),USE(?Button82)
       BUTTON('8:3'),AT(86,118,35,14),USE(?Button83)
       BUTTON('&Atlikt'),AT(84,139,36,14),USE(?CancelButton3)
     END
  CODE                                            ! Begin processed code
!TIEK INICIALIZÇTS TRENDS, IZSAUCOT BROWSEPAR_K IEKÐ MAIN
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  F:IDP=''
  dat=today()
  SASKANA ='Saskaòâ ar mûsu grâmatvedîbas datiem uz '&FORMAT(DAT,@D06.)&' mçs neesam saòçmuði apmaksu'
  SASKANA1='par sekojoðiem dokumentiem :'
  LIDZ_DAT=DAT+7
  DO FILLPARAKSTI !Sâkums...TIEKAM GALÂ AR PARAKSTU DATIEM

  OPEN(window0)
  WindowOpened=True
  OPC=1
  ACCEPT
    IF ~(SAV_OPC=OPC)
      IF OPC=4
         ENABLE(?REIZES)
         SELECT(?OkButton0)
      ELSIF OPC=5
         ENABLE(?X)
         SELECT(?X)
      ELSE
         X=0
         REIZES=1
         DISABLE(?X)
         DISABLE(?REIZES)
      .
      SAV_OPC=OPC
    END
    DISPLAY
    CASE EVENT()
    OF EVENT:OpenWindow
      DISPLAY()
      SELECT(?OkButton0)
    OF EVENT:GainFocus
      DISPLAY()
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OF ?OkButton0
      CASE EVENT()
      OF EVENT:Accepted
        LocalResponse = RequestCompleted
        BREAK
        END
    OF ?CancelButton0
      CASE EVENT()
      OF EVENT:Accepted
         DO PROCEDURERETURN
      END
    END
  END
  CLOSE(WINDOW0)


  CASE OPC
  OF 1                  !*********************Draudu vçstule*******************
     IF GGK::USED=0
        checkopen(ggk,1)
     .
     GGK::USED+=1
     IF GG::USED=0
        checkopen(gg,1)
     .
     GG::USED+=1

     BIND(ggk:RECORD)
     BIND('par_nr',par_nr)
     BIND('KKK',KKK)
     BIND('D_K',D_K)
     IF ~ANSIFILENAME
        ANSIFILENAME='VEST001.TXT'
     .
     KKK='231'
     PAR_NR=PAR:U_NR
     pvn_proc=18
     i#=1     !INDEKSS MASÎVAM
     D_K='K'
     IMAGE#=PerfAtable(1,0,'','',PAR_NR,'',0,0,'',0)
     D_K='D'
     IF getpar_k(par:U_nr,2,1)
        TEKSTS=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
        FORMAT_TEKSTS(80,'ARIAL',10,' ')
        ADRESE1 = F_TEKSTS[1]
        ADRESE2 = F_TEKSTS[2]
        TEKSTS = GETPAR_K(PAR:U_NR,2,2)
        FORMAT_TEKSTS(80,'ARIAL',12,'B')
        IF F_TEKSTS[2]
           CLIENT1 = F_TEKSTS[1]
           CLIENT2 = F_TEKSTS[2]
        ELSE
           CLIENT1 = ''
           CLIENT2 = F_TEKSTS[1]
        .
     .

     FilesOpened = True
     RecordsToProcess = 50
     RecordsPerCycle = 25
     RecordsProcessed = 0
     PercentProgress = 0
     OPEN(ProgressWindow)
     Progress:Thermometer = 0
     ?Progress:PctText{Prop:Text} = '0% Izpildîti'
     ProgressWindow{Prop:Text} = 'Rçíinam parâdus'
     ?Progress:UserString{Prop:Text}=''
     SEND(GGK,'QUICKSCAN=on')
     ACCEPT
       CASE EVENT()
       OF Event:OpenWindow
         clear(ggk:record)
         ggk:PAR_NR=PAR_NR
         SET(GGK:PAR_KEY,GGK:PAR_KEY)
         Process:View{Prop:Filter} = 'GGK:PAR_NR=PAR_NR AND GGK:BKK[1:3]=KKK[1:3] AND GGK:D_K=D_K'
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
       OF Event:Timer
         LOOP RecordsPerCycle TIMES
           IF ~GETGG(GGK:U_NR)
              KLUDA(5,'GGK:U_NR:'&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D06.))
           ELSIF ~BAND(ggk:BAITS,00000001b) !~IEZAKS
              IF GGK:U_NR=1                 ! SALDO
                 GG_DOK_SENR=GGK:REFERENCE
                 GG_APMDAT=GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,1) !Lîdz kuram bija jâsamaksâ
              ELSE
                 GG_DOK_SENR=GG:DOK_SENR !ÐITOS NEDRÎKST AIZTIKT DÇÏ PERFATABLE
                 GG_APMDAT=GG:APMDAT
              .
              IF ~GG_APMDAT THEN GG_APMDAT=GGK:DATUMS.
              SamSumma=PerfAtable(2,GG_DOK_SENR,'','',PAR_NR,'',0,0,'',0)
              IF GGK:SUMMA>Samsumma AND ~INRANGE(GGK:SUMMA-Samsumma,-.02,.02) AND GG_APMDAT<TODAY()
                 SamDat[I#]=GG_APMDAT
!                 IF PAR:KARTE AND ACC_KODS_N=0  !ASSAKO Pçcgarantijas rçkins
!                    DokumentaNr[i#]=format(par:KARTE,@n04)&'-'&gg_dok_SENr
!                 ELSE
                    DokumentaNr[i#]=gg_dok_SENr
!                 .
                 PrecuSumma[i#]=ggk:summa-SAMSUMMA
                 IF GGK:U_NR=1              ! SALDO
                    TEKSTS = CLIP(GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,2))&' '&|
                    CLIP(GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,3))&' '&CLIP(GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,4))
                    PrecuNosaukums[i#,2]='Rçíins no '&FORMAT(GETVESTURE(GGK:PAR_NR,GGK:REFERENCE,5),@D06.)&' par summu '&val_uzsk&' '&ggk:summa
                 ELSE
                    TEKSTS = CLIP(GG:SATURS)&' '&CLIP(GG:SATURS2)&' '&CLIP(GG:SATURS3)
                    PrecuNosaukums[i#,2]='Rçíins no '&FORMAT(GG:DOKDAT,@D06.)&' par summu '&val_uzsk&' '&ggk:summa
                 .
                 FORMAT_TEKSTS(93,'Arial',10,'')
                 PrecuNosaukums[i#,1] = F_TEKSTS[1]
                 PN[i#] = PrecuNosaukums[i#,1]
                 I#+=1
                 IF F_TEKSTS[2] AND I#<=100
                    PrecuNosaukums[i#,1]=F_TEKSTS[2]
                    PN[i#] = PrecuNosaukums[i#,1]
                    I#+=1
                 .
                 IF F_TEKSTS[3] AND I#<=100
                    PrecuNosaukums[i#,1]=F_TEKSTS[3]
                    PN[i#] = PrecuNosaukums[i#,1]
                    I#+=1
                 .
                 SUMMAKOPA+=GGK:SUMMA-samsumma
                 IF I#>=101 !I# PIEÐÍIRTS JAU NÂKOÐAJAM
                    KLUDA(0,'Rindu skaits sasniedzis 100, tâlâku analîzi pârtraucam...')
                    LocalResponse = RequestCompleted
                    BREAK
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

     GGK::USED-=1
     IF GGK::USED=0 THEN CLOSE(ggk).
     GG::USED-=1
     IF GG::USED=0 THEN CLOSE(gg).

     IF I#>10 THEN KLUDA(0,'Rindu skaits > 10, ne visu var parâdît laboðanas reþîmâ ...').
     OPEN(window1)
     VestulesTips='T' !TUKÐS PÇC NOKLUSÇÐANAS
     WindowOpened=True
     IF OPC=1         !DRAUDU VÇSTULE
        VestulesTips='A' !ATGÂDINÂJUMS PÇC NOKLUSÇÐANAS
        UNHIDE(?ButtonFixVesture)
        FixVesture=TRUE
        UNHIDE(?ImageFixVesture)
     .
     ACCEPT
       CASE EVENT()
       OF EVENT:OpenWindow
         DISPLAY()
         SELECT(?OkButton)
       OF EVENT:GainFocus
         DISPLAY()
       OF Event:Rejected
         BEEP
         DISPLAY(?)
         SELECT(?)
       END
       CASE FIELD()
       OF ?Tekstafails
         CASE EVENT()
         OF EVENT:Accepted
           PATH"=PATH()
           IF FILEDIALOG('Izvçlaties failu',AnsiFileName,'Visi *.txt|*.txt',0)
              select(?OkButton)
           .
           SETPATH(PATH")
         END
       OF ?mainit
         CASE EVENT()
         OF EVENT:Accepted
           RUN('NOTEPAD '&AnsiFileName)
         END
       OF ?SYS_PARAKSTS_NR  !AMATS,PARAKSTS
         CASE EVENT()
         OF EVENT:Accepted
            DO FILLPARAKSTI
            display()
         .
       OF ?Button:MAKARONI  !SVÎTRU PARAKSTS, ...NEIZMANTOJAM GLOBAL
         CASE EVENT()
         OF EVENT:Accepted
            IF BAND(SYS_BAITS,00000001B)
               SYS_BAITS-=1
               HIDE(?Image:Makaroni)
            ELSE
               SYS_BAITS+=1
               UNHIDE(?Image:Makaroni)
            .
            DO FILLPARAKSTI
            display()
         .
       OF ?ButtonFixVesture
         CASE EVENT()
         OF EVENT:Accepted
           IF FixVesture
              FixVesture=FALSE
              HIDE(?ImageFixVesture)
           ELSE
              FixVesture=TRUE
              UNHIDE(?ImageFixVesture)
           .
         .
       OF ?ButtonTEX
         CASE EVENT()
         OF EVENT:Accepted
           IF Tex_V
              Tex_V=0
              ?BUTTONTEX{PROP:TEXT}='Aizvietot ar GG:saturu'
              LOOP I#=1 TO 100
                 PN[I#]=PrecuNosaukums[i#,1]
              .
           ELSE
              Tex_V=1
              ?BUTTONTEX{PROP:TEXT}='Aizvietot ar DOK_DAT un SUMMU'
              LOOP I#=1 TO 100
                 PN[I#]=PrecuNosaukums[i#,2]
              .
           .
           DISPLAY
         .
       OF ?OkButton
         CASE EVENT()
         OF EVENT:Accepted
           LocalResponse = RequestCompleted
           BREAK
           END
       OF ?CancelButton
         CASE EVENT()
         OF EVENT:Accepted
            DO PROCEDURERETURN
         END
       END
     END
     CLOSE(WINDOW1)
   !
  OF 2               !********Ziemassvçtki*************************************
     ANSIFILENAME='VESTZ.TXT'
  OF 3               !********Adrese uz konverta*******************************
     IF getpar_k(par:U_nr,2,1)
        ADRESE=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
     .
  OF 4               !********Adrese uz lîmpapîra******************************
     IF getpar_k(par:U_nr,2,1)
        ADRESE=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
     .
     OPEN(UZLIMES)
     WindowOpened=True
     U#=0
     SELECT(?Button11)
     DISPLAY
     ACCEPT
       CASE EVENT()
       OF EVENT:OpenWindow
         DISPLAY()
         SELECT(?OkButton0)
       OF EVENT:GainFocus
         DISPLAY()
       OF Event:Rejected
         BEEP
         DISPLAY(?)
         SELECT(?)
       END
       CASE FIELD()
       OF ?CancelButton3
         CASE EVENT()
         OF EVENT:Accepted
            CLOSE(UZLIMES)
            DO PROCEDURERETURN
         END
       ELSE
         CASE EVENT()
         OF EVENT:Accepted
           U#=FIELD()
           BREAK
         END
       END
     END
     CLOSE(UZLIMES)
  OF 5               !****** Adrese uz lîmpapîra PÇC PAR_K ********************
  OF 6               !******* Vçstule *****************************************
     IF getpar_k(par:U_nr,2,1)
        ADRESE=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
     .
     OPEN(window2)
     DISPLAY()
     ACCEPT
       CASE FIELD()
       OF ?Tekstafails2
         CASE EVENT()
         OF EVENT:Accepted
           PATH"=PATH()
           IF FILEDIALOG('Izvçlaties failu',AnsiFileName,'Visi *.txt|*.txt',0)
              select(?OkButton)
           END
           SETPATH(PATH")
         END
       OF ?mainit2
         CASE EVENT()
         OF EVENT:Accepted
           RUN('NOTEPAD '&AnsiFileName)
         END
       OF ?OkButton2
         CASE EVENT()
         OF EVENT:Accepted
           LocalResponse = RequestCompleted
           BREAK
         END
       OF ?CancelButton2
         CASE EVENT()
         OF EVENT:Accepted
            CLOSE(WINDOW2)
            DO PROCEDURERETURN
         END
       END
     END
     CLOSE(WINDOW2)
  .

!***************************** DRUKÂJAM ***********************

  OPEN(Report)
  !Pçc ðitâ nedrîkst vairs raut vaïâ nevienu logu....
  Report{Prop:Text} = CLIP(PAR:NOS_S)&FORMAT(TODAY(),@D5-)&'XXXX'
  IF ~INRANGE(OPC,3,5) !adrese uz konverta /LÎMPAPÎRIEM
     SETTARGET(REPORT)
     IMAGE(480,208,2083,521,'USER.BMP')
     IF VestulesTips='B'
        BRIDINAJUMS='Brîdinâjums'
     ELSIF VestulesTips='A'
        BRIDINAJUMS='Atgâdinâjums'
     ELSE
        BRIDINAJUMS=''
     .
  .
  Report{Prop:Preview} = PrintPreviewImage
!
  IF LocalResponse = RequestCompleted
     CASE OPC
     OF 1
       IF LIDZ_DAT
          LIDZ_TEX='Lûdzam Jûs apmaksât parâda summu lîdz '&FORMAT(LIDZ_DAT,@D06.)
       .
       GOV_REG=GETPAR_K(PAR_NR,0,9)
       checkopen(bankas_k,1)
       checkopen(system,1)
       clear(ban:record)
       CASE SYS:NOKL_PB
       OF 1
          ban:kods   =par:ban_kods
          PAR_ban_NR =par:ban_NR
       OF 2
          ban:kods   =par:ban_kods2
          PAR_ban_NR =par:ban_NR2
       ELSE
          PAR_ban_NR =''
          KLUDA(87,'noklusçtais partnera n/r Nr Lokâlajos datos')
       .
       IF PAR_ban_NR
          get(bankas_k,ban:kod_key)
          BANKA1='n/r : '&PAR_BAN_NR&' kods : '&ban:kods[1:9]
          BANKA2=BAN:NOS_P
       .
!       IF INRANGE(PAR:KARTE,1,200) AND ACC_KODS_N=0  !ASSAKO
!          pamatX='Lîgums Nr '&par:karte&' no '&par:pamat[1:8]
!       ELSIF PAR:KARTE>200 AND ACC_KODS_N=0  !ASSAKO
!          pamatX='Licence Nr '&par:karte&' no '&par:pamat[1:8]
!       ELSIF PAR:PAMAT
!          pamatX='Lîgums Nr '&par:pamat
!       ELSE
          pamatX=''
!       END
       PVN=ROUND(SUMMAKopa*(pvn_proc/100),.01)
       apmaksai=SUMMAKopa+PVN
       PRINT(RPT:detailA)
       PRINT(RPT:detailKAM)
       IF SUMMAKOPA
          PRINT(RPT:detail0)
          SummaKopa=0
          loop i#=1 to 100
             IF PN[i#] OR PrecuSumma[i#]
                PrecuNosaukums1=PN[i#]
                PrecuSumma1=PrecuSumma[i#]
                DokumentaNr1=DokumentaNr[i#]
                SAMDAT1=SAMDAT[I#]
                PRINT(RPT:detail1)
                SummaKopa+=PrecuSumma[i#] !pârskaitam, ja kas pierakstîts "no rokas"
             END
          .
          PRINT(RPT:detail2)
       .
       IF ~DOS_CONT(ANSIFILENAME,2)
          KLUDA(120,ANSIFILENAME)
          DO PROCEDURERETURN
       .
       IF ~DOS_CONT(ANSIFILENAME,2)
          KLUDA(120,ANSIFILENAME)
          DO PROCEDURERETURN
       .
       checkopen(OUTFILEANSI)
       SET(OUTFILEANSI)
       LOOP
          NEXT(OUTFILEANSI)
          IF ERROR() THEN BREAK.
          LINE=OUTA:LINE
          PRINT(RPT:detail3)
       .
       close(OUTFILEANSI)

       IF OPC=1 THEN PRINT(RPT:detail4). !DRAUDU VÇSTULE
       PR:SKAITS=1

       IF FixVesture !un PAR_K...
          IF VESTURE::USED=0
             CHECKOPEN(VESTURE,1)
          .
          VESTURE::USED+=1
          CLEAR(VES:RECORD)
          VES:APMDAT=LIDZ_DAT
          VES:DOKDAT=TODAY()
          VES:DATUMS=TODAY()
          VES:PAR_NR=PAR_NR
          VES:CRM   =1
          CASE VESTULESTIPS
          OF 'B'
            TEKSTS='Brîdinâjuma vçstule '
          OF 'A'
            TEKSTS='Atgâdinâjuma vçstule '
          ELSE
            TEKSTS='Vçstule '
          .
          loop i#=1 to 100
             IF DokumentaNr[i#] OR PrecuSumma[i#]
                TEKSTS=CLIP(TEKSTS)&' '&CLIP(DokumentaNr[i#])
                VES:SUMMA+=PrecuSumma[I#]
             .
          .
!          STOP(TEKSTS)
          FORMAT_TEKSTS(45,'WINDOW',8,'')
          VES:SATURS=F_TEKSTS[1]
          VES:SATURS2=F_TEKSTS[2]
          VES:SATURS3=F_TEKSTS[3]
          VES:VAL='Ls'
          VES:D_K_KONTS=''
          VES:ACC_DATUMS=today()
          VES:ACC_KODS=ACC_kods
          ADD(vesture)
          VESTURE::USED-=1
          IF VESTURE::USED=0
             CLOSE(VESTURE)
          .
          IF ~(PAR:U_NR=PAR_NR)
             STOP('PAR_K pozicionçts uz '&par:u_nr)
          ELSE
             IF ~(PAR:ATZIME1=10 OR PAR:ATZIME2=10) !DRAUDU VÇSTULE
                IF ~PAR:ATZIME1
                   PAR:ATZIME1=10
                ELSIF ~PAR:ATZIME2
                   PAR:ATZIME2=10
                .
                IF RIUPDATE:PAR_K()
                   KLUDA(24,'PAR_K')
                ELSE
                   F:IDP='1' !JÂPÂRLASA BROWSIS
                .
             .
          .
       .
     OF 2
       IF ~DOS_CONT(ANSIFILENAME,2)
          KLUDA(120,ANSIFILENAME)
          DO PROCEDURERETURN
       .
       checkopen(OUTFILEANSI)
       SET(OUTFILEANSI)
       LOOP
          NEXT(OUTFILEANSI)
          IF ERROR() THEN BREAK.
          LINE=OUTA:LINE
          PRINT(RPT:detail3)
       .
       close(OUTFILEANSI)
       PRINT(RPT:detailZ)
       PR:SKAITS=1
     OF 3                        !Adrese uz konverta
       PRINT(RPT:detailADR_K)
       PR:SKAITS=1
     OF 4                        !Adrese uz LÎMPAPÎRA REIZES REIZES
       TUKSNI#=INT((U#-1)/3)     !U#=FIELD()
       U#=U#-TUKSNI#*3
       IF TUKSNI#
          LOOP I#=1 TO TUKSNI#   !TUKÐAS RINDAS
             PRINT(RPT:detailADR_T)
          .
       .
       LOOP R# = 1 TO REIZES
          DO FILLLABEL
          IF U#%3=0   !AIZPILDÎTAS KÂRTÇJÂS 3 RINDAS
             PRINT(RPT:detailADR_L)
             CLEAR(NOS_P)
             CLEAR(ADR)
             U#=1
          ELSE
             U# += 1
          .
       .
       IF U# > 1   !VÇL KAUT KAS
          PRINT(RPT:detailADR_L)
       .
       PR:SKAITS=1
     OF 5                        !Adrese uz lîmpapîra PÇC PAR_K
       CLEAR(PAR:RECORD)
       SET(PAR:NOS_KEY)
       LOOP
          NEXT(PAR_K)
          IF ERROR() THEN BREAK.
          IF PAR:BAITS=X
             U#+=1
             IF getpar_k(par:U_nr,2,1)
                ADRESE=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
             .
             DO FILLLABEL
             IF U#%3=0   !AIZPILDÎTAS KÂRTÇJÂS 3 RINDAS
                PRINT(RPT:detailADR_L)
                CLEAR(NOS_P)
                CLEAR(ADR)
                U#=0
             .
          .
       .
       IF U#   !VÇL KAUT KAS
          PRINT(RPT:detailADR_L)
       .
     OF 6                        !Vienkârði vçstule
       PRINT(RPT:detailA)
       PRINT(RPT:detailKAM)
       IF ~DOS_CONT(ANSIFILENAME,2)
          KLUDA(120,ANSIFILENAME)
          DO PROCEDURERETURN
       .                                                                  
       checkopen(OUTFILEANSI)
       SET(OUTFILEANSI)
       LOOP
          NEXT(OUTFILEANSI)
          IF ERROR() THEN BREAK.
          LINE=OUTA:LINE
          PRINT(RPT:detail3)
       .
       close(OUTFILEANSI)
       PR:SKAITS=1
     .

     ENDPAGE(Report)
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
  .

  CLOSE(Report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
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
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'REKINI')
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
FILLLABEL ROUTINE
       IF INRANGE(U#,1,3)
          TEKSTS=PAR:NOS_P
          FORMAT_TEKSTS(60,'ARIAL',12,1)
          IF F_TEKSTS[2]
             NOS_P[U#,1]=F_TEKSTS[1]
             NOS_P[U#,2]=F_TEKSTS[2]
          ELSE
             NOS_P[U#,1]=''
             NOS_P[U#,2]=F_TEKSTS[1]
          .
          TEKSTS=ADRESE
!          FORMAT_TEKSTS(60,'ARIAL',10,0)
          FORMAT_TEKSTS(60,'ARIAL',8,0)
          IF F_TEKSTS[2]
             ADR[U#,1]=F_TEKSTS[1]
             ADR[U#,2]=F_TEKSTS[2]
          ELSE
             ADR[U#,1]=F_TEKSTS[1]
             ADR[U#,2]=''
          .
       ELSE
          STOP('U#='&U#)
       .

!-----------------------------------------------------------------------------
FILLPARAKSTI ROUTINE        !SÂKUMS & BUTTON:MAKARONI & OK.
  IF BAND(SYS_BAITS,00000001B) !SYS_BAITS ~GLOBAL...MAKARONU PARAKSTS
     CTRL#=VAL(CODE39[1])+VAL(GG:DOK_SENR[1])+VAL(GG:NOKA[1])
     CODE39=GETPARAKSTI(SYS_PARAKSTS_NR,3,CTRL#)
     CODE39_TEXT='Vçstule sagatavota elektroniski un ir derîga bez paraksta'
     SYS_PARAKSTS=''
     SYS_AMATS=''
     SvitraParakstam=''
  ELSE
     SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)
     SYS_AMATS   =GETPARAKSTI(SYS_PARAKSTS_NR,2)
     SvitraParakstam='_{28}'
     CODE39=''
     CODE39_TEXT=''
  .
  DISPLAY
MENVAR               FUNCTION (DATUMS,DAT_TIPS,OPC) ! Declare Procedure
  CODE                                            ! Begin processed code

   CASE DAT_TIPS
   OF 1              !MENEÐA NR VAI DATUMS
     I#=DATUMS          !-JA MENESA nr
   OF 2              
     I#=MONTH(DATUMS)   !-JA LONG STANDART DATE
   .
   IF ~INRANGE(I#,1,19) THEN RETURN('').
   CASE OPC
   OF 1           !LIELO SÂKUMA BURTU
     EXECUTE I#
        Return('Janvâris')
        Return('Februâris')
        Return('Marts')
        Return('Aprîlis')
        Return('Maijs')
        Return('Jûnijs')
        Return('Jûlijs')
        Return('Augusts')
        Return('Septembris')
        Return('Oktobris')
        Return('Novembris')
        Return('Decembris')
        RETURN('I ceturksnis')
        RETURN('II ceturksnis')
        RETURN('III ceturksnis')
        RETURN('IV ceturksnis')
        RETURN('I pusgads')
        RETURN('II pusgads')
        RETURN('Viss gads')
     .
   OF 2           !MAZIEM BURTIEM
     EXECUTE I#
        RETURN('janvâris')
        RETURN('februâris')
        RETURN('marts')
        RETURN('aprîlis')
        RETURN('maijs')
        RETURN('jûnijs')
        RETURN('jûlijs')
        RETURN('augusts')
        RETURN('septembris')
        RETURN('oktobris')
        RETURN('novembris')
        RETURN('decembris')
        RETURN('I ceturksnis')
        RETURN('II ceturksnis')
        RETURN('III ceturksnis')
        RETURN('IV ceturksnis')
        RETURN('I pusgads')
        RETURN('II pusgads')
        RETURN('viss gads')
     .
   OF 3           !MAZIEM BURTIEM AKUZATÎVS
     EXECUTE I#
        RETURN('janvâri')
        RETURN('februâri')
        RETURN('martu')
        RETURN('aprîli')
        RETURN('maiju')
        RETURN('jûniju')
        RETURN('jûliju')
        RETURN('augustu')
        RETURN('septembri')
        RETURN('oktobri')
        RETURN('novembri')
        RETURN('decembri')
        RETURN('I ceturksni')
        RETURN('II ceturksni')
        RETURN('III ceturksni')
        RETURN('IV ceturksni')
        RETURN('I pusgadu')
        RETURN('II pusgadu')
        RETURN('visu gadu')
     .
   OF 4           !MAZIEM BURTIEM ÌENETÎVS
     EXECUTE I#
        RETURN('janvâra')
        RETURN('februâra')
        RETURN('marta')
        RETURN('aprîïa')
        RETURN('maija')
        RETURN('jûnija')
        RETURN('jûlija')
        RETURN('augusta')
        RETURN('septembra')
        RETURN('oktobra')
        RETURN('novembra')
        RETURN('decembra')
        RETURN('I ceturkðòa')
        RETURN('II ceturkðòa')
        RETURN('III ceturkðòa')
        RETURN('IV ceturkðòa')
        RETURN('I pusgada')
        RETURN('II pusgada')
        RETURN('visa gada')
     .
   OF 5           !MAZIEM BURTIEM DATÎVS
     EXECUTE I#
        RETURN('janvârim')
        RETURN('februârim')
        RETURN('martam')
        RETURN('aprîlim')
        RETURN('maijam')
        RETURN('jûnijam')
        RETURN('jûlijam')
        RETURN('augustam')
        RETURN('septembrim')
        RETURN('oktobrim')
        RETURN('novembrim')
        RETURN('decembrim')
        RETURN('I ceturksnim')
        RETURN('II ceturksnim')
        RETURN('III ceturksnim')
        RETURN('IV ceturksnim')
        RETURN('I pusgadam')
        RETURN('II pusgadam')
        RETURN('visam gadam')
     .
   OF 6           !MAZIEM BURTIEM SAÎSINÂTS
     EXECUTE I#
        RETURN('jan.')
        RETURN('feb.')
        RETURN('mar.')
        RETURN('apr.')
        RETURN('mai.')
        RETURN('jûn.')
        RETURN('jûl.')
        RETURN('aug.')
        RETURN('sept.')
        RETURN('okt.')
        RETURN('nov.')
        RETURN('dec.')
        RETURN('I c.')
        RETURN('II c.')
        RETURN('III c.')
        RETURN('IV c.')
        RETURN('I pg.')
        RETURN('II pg.')
        RETURN('v.g.')
     .
   ELSE
     STOP('Izsaucot MENVAR opcija:'&opc)
   .
IZZFILTGMC PROCEDURE 


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
M                    STRING(30),DIM(19)
C                    ULONG,DIM(6,2)
FING                 STRING(35)
window               WINDOW('Norâdiet periodu'),AT(,,170,270),GRAY
                       OPTION('Y'),AT(97,1,64,37),USE(RS),BOXED,HIDE
                         RADIO('Apstiprinâtie'),AT(99,10),USE(?rs:Radio1)
                         RADIO('Visi'),AT(99,18),USE(?rs:Radio2)
                         RADIO('Neapstiprinâtie'),AT(99,26,60,10),USE(?rs:Radio3)
                       END
                       STRING(@n_4),AT(51,28),USE(DB_GADS)
                       STRING('.gads'),AT(72,28),USE(?StringGads)
                       STRING(@s35),AT(7,39,152,10),USE(FING),CENTER
                       OPTION('Periods :'),AT(2,54,163,192),USE(MenesisunG),BOXED
                         RADIO('Janvâris'),AT(19,61,134,10),USE(?Menesis:Radio1),DISABLE
                         RADIO('Februâris'),AT(19,69,134,10),USE(?Menesis:Radio2),DISABLE
                         RADIO('Marts'),AT(19,77,134,10),USE(?Menesis:Radio3),DISABLE
                         RADIO('Aprîlis'),AT(19,85,134,10),USE(?Menesis:Radio4),DISABLE
                         RADIO('Maijs'),AT(19,94,134,10),USE(?Menesis:Radio5),DISABLE
                         RADIO('Jûnijs'),AT(19,103,134,10),USE(?Menesis:Radio6),DISABLE
                         RADIO('Jûlijs'),AT(19,111,134,10),USE(?Menesis:Radio7),DISABLE
                         RADIO('Augusts'),AT(19,120,134,10),USE(?Menesis:Radio8),DISABLE
                         RADIO('Septembris'),AT(19,129,134,10),USE(?Menesis:Radio9),DISABLE
                         RADIO('Oktobris'),AT(19,138,134,10),USE(?Menesis:Radio10),DISABLE
                         RADIO('Novembris'),AT(19,147,134,10),USE(?Menesis:Radio11),DISABLE
                         RADIO('Decembris'),AT(19,156,134,10),USE(?Menesis:Radio12),DISABLE
                         RADIO('1. Ceturksnis'),AT(19,165,134,10),USE(?Menesis:Radio13),DISABLE
                         RADIO('2. Ceturksnis'),AT(19,174,134,10),USE(?Menesis:Radio14),DISABLE
                         RADIO('3. Ceturksnis'),AT(19,183,134,10),USE(?Menesis:Radio15),DISABLE
                         RADIO('4. Ceturksnis'),AT(19,192,134,10),USE(?Menesis:Radio16),DISABLE
                         RADIO('1. Pusgads'),AT(19,201,134,10),USE(?Menesis:Radio17),DISABLE
                         RADIO('2. Pusgads'),AT(19,210,134,10),USE(?Menesis:Radio18),DISABLE
                         RADIO('Viss gads'),AT(19,219,134,10),USE(?Menesis:Radio19),DISABLE
                         RADIO('Periods:'),AT(19,229,41,10),USE(?Menesis:Radio20),DISABLE
                       END
                       SPIN(@D06.B),AT(60,229,48,10),USE(S_DAT),HIDE,CENTER
                       STRING('--'),AT(109,229),USE(?StringLIDZ),HIDE
                       SPIN(@D06.B),AT(115,229,48,10),USE(B_DAT),HIDE,CENTER
                       BUTTON('&OK'),AT(87,249,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(127,249,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  rs = 'Apstiprinâtie'
!  IF DAIKODS !LAI NEPRASÎTU PERIODU KATRAM RÇÍINAM- MASS R BASE
!     GLOBALRESPONSE=REQUESTCOMPLETED
!     RETURN
!  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ! OPCIJA 1=TUKÐÐ
  !        2=1:MEN,CET,PG,G
  !         =2:MEN
  !         =3:G
  !         =4:MEN, PERIODS='UZ'
  !        3=1:VAR ATVÇRT RS
  !        4=1:VAR ATVÇRT PERIODU, FING>12M
  !          2:VAR ATVÇRT PERIODU(S_DAT) RÇÍINAM
  !

!  IF ACC_kods_n=0  !ASSAKO
!     UNHIDE(?MENESU_SKAITS)
!     if ~menesu_skaits
!        menesu_skaits=3
!     .
!  .

  IF TODAY()>DB_B_DAT
     MEN_NR=12                                 !VISPIRMS EKRÂNAM
  ELSIF INRANGE(MEN_NR,1,12)
     MEN_NR+=12-MONTH(DB_B_DAT)                !AR FIN.G. KOREKCIJU
  ELSE
     MEN_NR=month(today())+12-MONTH(DB_B_DAT)  !AR FIN.G. KOREKCIJU
  .
  FING=GETFING(1,DB_GADS)              !FINANSU GADA TEKSTS
  MEN_SK#=GETFING(4,DB_GADS)           !MEN_SK FIN.G

  M#=MONTH(DB_B_DAT)
  Y#=YEAR(DB_B_DAT)
  LOOP J# =12 TO 1 BY -1
     M[J#]=MENVAR(M#,1,1)&' '&Y#
     M#-=1
     IF M#<=0
        M#+=12
        Y#-=1
     .
     IF DATE(M#,1,Y#)<DB_S_DAT THEN BREAK.
  .
  M#=MONTH(DB_B_DAT)+1
  Y#=YEAR(DB_B_DAT)
  B#=DB_B_DAT
  LOOP C#=4 TO 1 BY -1   !CETURKÐÒI
     C[C#,2]=B#
     M#-=3
     IF M#<=0
        M#+=12
        Y#-=1
     .
     C[C#,1]=DATE(M#,1,Y#)
     M[12+C#]=C#&'.cet. '&FORMAT(C[C#,1],@D06.)&'-'&FORMAT(C[C#,2],@D06.)
     IF C[C#,1]<=DB_S_DAT
        C[C#,1]=DB_S_DAT
        M[12+C#]=C#&'.cet. '&FORMAT(C[C#,1],@D06.)&'-'&FORMAT(C[C#,2],@D06.)
        BREAK
     .
     B#=C[C#,1]-1
     IF B#<=DB_S_DAT THEN B#=DB_S_DAT.
  .
  M#=MONTH(DB_B_DAT)+1
  Y#=YEAR(DB_B_DAT)
  B#=DB_B_DAT
  LOOP C#=6 TO 5 BY -1   !PUSGADI
     C[C#,2]=B#
     M#-=6
     IF M#<=0
        M#+=12
        Y#-=1
     .
     C[C#,1]=DATE(M#,1,Y#)
     M[12+C#]=C#-4&'.pusg. '&FORMAT(C[C#,1],@D06.)&'-'&FORMAT(C[C#,2],@D06.)
     IF C[C#,1]<=DB_S_DAT
        C[C#,1]=DB_S_DAT
        M[12+C#]=C#-4&'.pusg. '&FORMAT(C[C#,1],@D06.)&'-'&FORMAT(C[C#,2],@D06.)
        BREAK
     .
     B#=C[C#,1]-1
     IF B#<=DB_S_DAT THEN B#=DB_S_DAT.
  .

  M[19]='Fin.gads '&FORMAT(DB_S_DAT,@D06.)&'-'&FORMAT(C[4,2],@D06.)

!  S_DAT=GETFING(5,DB_GADS)              !5:MAX -12 MÇN. PERIODA SÂKUMS
!  IF DB_S_DAT<S_DAT
!     ?Menesis:Radio1{PROP:TEXT}=MONTH(DB_S_DAT)&'-'&MONTH(S_DAT)&' '&Y#
!  ELSE
!  .

  ?Menesis:Radio1{PROP:TEXT}=M[1]
  ?Menesis:Radio2{PROP:TEXT}=M[2]
  ?Menesis:Radio3{PROP:TEXT}=M[3]
  ?Menesis:Radio4{PROP:TEXT}=M[4]
  ?Menesis:Radio5{PROP:TEXT}=M[5]
  ?Menesis:Radio6{PROP:TEXT}=M[6]
  ?Menesis:Radio7{PROP:TEXT}=M[7]
  ?Menesis:Radio8{PROP:TEXT}=M[8]
  ?Menesis:Radio9{PROP:TEXT}=M[9]
  ?Menesis:Radio10{PROP:TEXT}=M[10]
  ?Menesis:Radio11{PROP:TEXT}=M[11]
  ?Menesis:Radio12{PROP:TEXT}=M[12]
  ?Menesis:Radio13{PROP:TEXT}=M[13] !1
  ?Menesis:Radio14{PROP:TEXT}=M[14] !2
  ?Menesis:Radio15{PROP:TEXT}=M[15] !3
  ?Menesis:Radio16{PROP:TEXT}=M[16] !4
  ?Menesis:Radio17{PROP:TEXT}=M[17] !1PUS
  ?Menesis:Radio18{PROP:TEXT}=M[18] !2PUS
  ?Menesis:Radio19{PROP:TEXT}=M[19] !FG

  LOOP I#=1 TO 4
     IF OPCIJA[I#] <> '0'
        EXECUTE I#
           TUKSS#=TRUE              !1:BIJA GADS
           BEGIN                    !2:VISKAS
              IF OPCIJA[I#]='1'     !1-MÇNEÐI,CET,PUS,VISS GADS
                 LOOP J#=1 TO 19
                    IF M[J#]
                       ENABLE(J#+8) !8 PIRMS LAUKI UZ EKRÂNA
                    .
                 .
              ELSIF OPCIJA[I#]='2'  !2-TIKAI MÇNEÐI
                 LOOP J#=1 TO 12
                    IF M[J#]
                       ENABLE(J#+8)
                    .
                 .
              ELSIF OPCIJA[I#]='4'  !4-TIKAI UZ MÇNESI
                 ?MENESISunG{PROP:TEXT}='&Uz'
                 LOOP J#=1 TO 12
                    IF M[J#]
                       ENABLE(J#+8)
                    .
                 .
              ELSE                  !3-TIKAI GADS  2.BAITS=3
!                 STOP(OPCIJA[I#])
                 MEN_NR=19
                 ENABLE(19+8)
              .
           .
           BEGIN                    !3:ja 1,var bût RS
              IF (ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1'))
                 UNHIDE(?RS)
              .
           .
           BEGIN                    !4:VAR ATVÇRT Periodu
              CASE OPCIJA[I#]
              OF '1'
                 IF MEN_SK#>12      !MEN_SK FIN.G
                    ENABLE(?Menesis:Radio20)
                    ENABLE(?StringLIDZ)
                    IF ~(OPCIJA[2]='4')  !4-TIKAI UZ MÇNESI
                       ENABLE(?S_DAT)
                    .
                 .
                 ENABLE(?B_DAT) !?
              OF '2'                !2-NO MÇNEÐA, PG RÇÍINAM
                 ENABLE(?Menesis:Radio20)
!                 ENABLE(?S_DAT)
              .
           .
        .
     .
  .
  select(?MENESISunG,MEN_NR)
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?rs:Radio1)
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
    OF ?Menesis:Radio20
      CASE EVENT()
      OF EVENT:Selected
        S_DAT=DB_S_DAT
        B_DAT=DB_B_DAT
        UNHIDE(?S_DAT)
        UNHIDE(?StringLIDZ)
        UNHIDE(?B_DAT)
        !SELECT(?S_DAT)
        DISPLAY
        
      END
    OF ?B_DAT
      CASE EVENT()
      OF EVENT:Accepted
        menesu_skaits=ROUND((B_DAT-S_DAT)/30,1)
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        SELECT
        LOCALRESPONSE = REQUESTCOMPLETED
        MEN_NR=CHOICE(?MENESISunG)               !NO EKRÂNA
        GADS=DB_GADS
        IF INRANGE(MEN_NR,1,12)
           MEN_NR=MEN_NR-(12-MONTH(DB_B_DAT))    !REÂLAIS MEN_NR(jaFG)
           IF MEN_NR<=0
              MEN_NR+=12
              GADS-=1
           .
           IF OPCIJA[2]='4'  !4-NO SÂKUMA UZ MÇNESI
              S_DAT=DB_S_DAT
              B_DAT=DATE(MEN_NR+1,1,GADS)-1
           ELSE              !KONKRÇTS MÇNESIS
              S_DAT=DATE(MEN_NR,1,GADS)
              B_DAT=DATE(MEN_NR+1,1,GADS)-1
           .
           MENESU_SKAITS=1
        ELSIF INRANGE(MEN_NR,13,16)
           S_DAT=C[MEN_NR-12,1]
           B_DAT=C[MEN_NR-12,2]
           MENESU_SKAITS=3
!           MEN_NR=MONTH(S_DAT) !RÇÍINIEM
        ELSIF INRANGE(MEN_NR,17,18)
           S_DAT=C[MEN_NR-12,1]
           B_DAT=C[MEN_NR-12,2]
           MENESU_SKAITS=6
!           MEN_NR=MONTH(S_DAT) !RÇÍINIEM
        ELSIF MEN_NR=19
           S_DAT=DB_S_DAT
!           B_DAT=C[4,2]
           B_DAT=DB_B_DAT
           MENESU_SKAITS=12
!           MEN_NR=MONTH(S_DAT) !RÇÍINIEM
        ELSE               !DEFINÇTS PERIODS
           MENESISunG=FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
!           MEN_NR=MONTH(S_DAT) !VAJADZÎGS RÇÍINIEM PAR 2 GADIEM
           MENESU_SKAITS=ROUND((B_DAT-S_DAT)/30,1)
        .
!        STOP(FORMAT(S_DAT,@D06.)&' '&FORMAT(B_DAT,@D06.)&' '&MENESU_SKAITS)
!        STOP(MENESISUNG)
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        LOCALRESPONSE = REQUESTCANCELLED
        BREAK
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IZZFILTGMC','winlats.INI')
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('IZZFILTGMC','winlats.INI')
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
