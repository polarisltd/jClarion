                     MEMBER('winlats.clw')        ! This is a MEMBER module
PVNsak   STRING(3)
PVNSUB   STRING(2)
B_Bilform            PROCEDURE                    ! Declare Procedure
CG                   STRING(10)
BKK                  STRING(3)
D                    DECIMAL(14,2)
K                    DECIMAL(14,2)
D01                  DECIMAL(14,2)
D02                  DECIMAL(14,2)
D03                  DECIMAL(14,2)
D04                  DECIMAL(14,2)
D05                  DECIMAL(14,2)
D06                  DECIMAL(14,2)
D07                  DECIMAL(14,2)
D08                  DECIMAL(14,2)
D09                  DECIMAL(14,2)
D10                  DECIMAL(14,2) 
D11                  DECIMAL(14,2) 
D12                  DECIMAL(14,2) 
D13                  DECIMAL(14,2) 
D14                  DECIMAL(14,2) 
D15                  DECIMAL(14,2) 
D16                  DECIMAL(14,2) 
D17                  DECIMAL(14,2) 
D18                  DECIMAL(14,2) 
D19                  DECIMAL(14,2) 
D20                  DECIMAL(14,2) 
D21                  DECIMAL(14,2) 
D22                  DECIMAL(14,2) 
D23                  DECIMAL(14,2) 
D24                  DECIMAL(14,2)
D25                  DECIMAL(14,2)
K01                  DECIMAL(14,2)
K02                  DECIMAL(14,2)
K03                  DECIMAL(14,2)
K04                  DECIMAL(14,2)
K05                  DECIMAL(14,2)
K06                  DECIMAL(14,2)
K07                  DECIMAL(14,2)
K08                  DECIMAL(14,2)
K09                  DECIMAL(14,2)
K10                  DECIMAL(14,2) 
K11                  DECIMAL(14,2) 
K12                  DECIMAL(14,2) 
K13                  DECIMAL(14,2) 
K14                  DECIMAL(14,2) 
K15                  DECIMAL(14,2) 
K16                  DECIMAL(14,2) 
K17                  DECIMAL(14,2) 
K18                  DECIMAL(14,2) 
K19                  DECIMAL(14,2) 
K20                  DECIMAL(14,2) 
K21                  DECIMAL(14,2) 
K22                  DECIMAL(14,2) 
K23                  DECIMAL(14,2) 
K24                  DECIMAL(14,2)
K25                  DECIMAL(14,2)
S01                  DECIMAL(14,2)
S02                  DECIMAL(14,2)
S03                  DECIMAL(14,2)
S04                  DECIMAL(14,2)
S05                  DECIMAL(14,2)
S06                  DECIMAL(14,2)
S07                  DECIMAL(14,2)
S08                  DECIMAL(14,2)
S09                  DECIMAL(14,2)
S10                  DECIMAL(14,2) 
S11                  DECIMAL(14,2) 
S12                  DECIMAL(14,2) 
S13                  DECIMAL(14,2) 
S14                  DECIMAL(14,2) 
S15                  DECIMAL(14,2) 
S16                  DECIMAL(14,2) 
S17                  DECIMAL(14,2) 
S18                  DECIMAL(14,2) 
S19                  DECIMAL(14,2) 
S20                  DECIMAL(14,2) 
S21                  DECIMAL(14,2) 
S22                  DECIMAL(14,2) 
S23                  DECIMAL(14,2) 
S24                  DECIMAL(14,2)
S25                  DECIMAL(14,2)
ADK                  DECIMAL(14,2) 
AKK                  DECIMAL(14,2) 
ASK1                 DECIMAL(14,2)
PDK                  DECIMAL(14,2) 
PKK                  DECIMAL(14,2) 
PSK                  DECIMAL(14,2) 
BSK                  DECIMAL(14,2) 
DAT                  DATE
LAI                  TIME
LINEH                STRING(190)
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
PrintSkipDetails     BOOL,AUTO
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
report REPORT,AT(198,198,8000,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(10,10,8000,10000)
         STRING(@s45),AT(1146,156,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('APGROZÎJUMS BILANCES KONTOS NO'),AT(521,521,3229,260),USE(?String2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('LÎDZ'),AT(4948,521,469,260),USE(?String2:2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(5521,521),USE(B_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(5052,8906),USE(PKK),RIGHT
         STRING(@N-_14.2B),AT(3740,8906),USE(PDK),RIGHT
         STRING(@N-_14.2B),AT(6354,9115),USE(BSK),RIGHT
         STRING(@N-_14.2B),AT(6354,8333),USE(S24),RIGHT
         STRING(@N-_14.2B),AT(6354,8125),USE(S23),RIGHT
         STRING('58 Norçíini par dividendçm'),AT(260,8333,2083,208),USE(?String6:38),LEFT
         STRING(@N-_14.2B),AT(6354,7500),USE(S20),RIGHT
         STRING('57 Norçíini par nodokïiem'),AT(260,8125,2083,208),USE(?String6:37),LEFT
         STRING(@D6),AT(3906,521),USE(S_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,885,7396,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3646,885,0,8490),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4948,885,0,8490),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6250,885,0,8490),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7552,885,0,8490),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('AKTÎVS'),AT(1302,990),USE(?String6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('DEBETS'),AT(3948,990,656,208),USE(?String6:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KREDÎTS'),AT(5104,990,833,208),USE(?String6:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('SALDO'),AT(6563,990,729,208),USE(?String6:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1250,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(3740,1563,1115,208),USE(D01),RIGHT
         STRING(@N-_14.2B),AT(5052,1563,1115,208),USE(K01),RIGHT
         STRING(@N-_14.2B),AT(6354,1563,1115,208),USE(S01),RIGHT
         STRING('11 Nemateriâlie'),AT(260,1563,2760,208),USE(?String6:6),LEFT
         STRING('12 Pamatlîdzekïi'),AT(260,1771,2760,208),USE(?String6:7),LEFT
         STRING('13 Ilgtermiòa fin. ieguldîjumi'),AT(260,1979,2760,208),USE(?String6:8),LEFT
         STRING('SALDO'),AT(6563,4271,729,208),USE(?String6:16),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(6354,3333,1115,208),USE(S08),RIGHT
         STRING(@N-_14.2B),AT(5052,3333,1115,208),USE(K08),RIGHT
         STRING(@N-_14.2B),AT(3740,3333,1115,208),USE(D08),RIGHT
         STRING(@N-_14.2B),AT(3740,3125,1115,208),USE(D07),RIGHT
         STRING('KAPITÂLS'),AT(250,4635,1042,208),USE(?String6:17),LEFT
         STRING(@N-_14.2B),AT(6354,3906,1115,208),USE(asK1),RIGHT
         STRING(@N-_14.2B),AT(3740,3906,1115,208),USE(ADK),RIGHT
         STRING(@N-_14.2B),AT(5052,3906,1115,208),USE(AKK),RIGHT
         STRING(@N-_14.2B),AT(6354,4844,1115,208),USE(S10),RIGHT
         STRING(@N-_14.2B),AT(5052,4844,1115,208),USE(K10),RIGHT
         STRING(@N-_14.2B),AT(3740,4844,1115,208),USE(D10),RIGHT
         STRING('31 Pamatkapitâls'),AT(250,4844,1667,208),USE(?String6:18),LEFT
         STRING('32 Privâtkonti'),AT(250,5052,1667,208),USE(?String6:19),LEFT
         STRING('KOPÂ :'),AT(260,8906,990,208),USE(?String6:39),LEFT
         STRING(@N-_14.2B),AT(3740,7917,1115,208),USE(D22),RIGHT
         STRING('BILANCE :'),AT(260,9115,1146,208),USE(?String6:40),LEFT
         STRING(@N-_14.2B),AT(5052,8125,1115,208),USE(K23),RIGHT
         STRING(@N-_14.2B),AT(3740,8125,1115,208),USE(D23),RIGHT
         STRING(@N-_14.2B),AT(6354,7083,1115,208),USE(S18),RIGHT
         STRING(@N-_14.2B),AT(5052,7083,1115,208),USE(K18),RIGHT
         STRING(@N-_14.2B),AT(6354,6406,1115,208),USE(S16),RIGHT
         STRING('KREDITORI'),AT(260,6667,1250,208),USE(?String6:29),LEFT
         STRING(@N-_14.2B),AT(3740,7083,1115,208),USE(D18),RIGHT
         STRING(@N-_14.2B),AT(5052,6406,1115,208),USE(K16),RIGHT
         STRING(@N-_14.2B),AT(6354,5260,1115,208),USE(S12),RIGHT
         STRING(@N-_14.2B),AT(6354,5052,1115,208),USE(S11),RIGHT
         LINE,AT(156,9375,7396,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(5052,8333,1115,208),USE(K24),RIGHT
         STRING(@N-_14.2B),AT(3740,8333,1115,208),USE(D24),RIGHT
         STRING(@N-_14.2B),AT(6354,7271,1115,208),USE(S19),RIGHT
         STRING(@N-_14.2B),AT(5052,7271,1115,208),USE(K19),RIGHT
         STRING(@N-_14.2B),AT(6354,6865,1115,208),USE(S17),RIGHT
         STRING(@N-_14.2B),AT(3740,7271,1115,208),USE(D19),RIGHT
         STRING(@N-_14.2B),AT(5052,6865,1115,208),USE(K17),RIGHT
         STRING(@N-_14.2B),AT(6354,6198,1115,208),USE(S15),RIGHT
         STRING('Sastâdîja :'),AT(208,9479,729,208),USE(?String6:41),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s8),AT(938,9479,625,208),USE(ACC_kods)
         STRING('RS :'),AT(1667,9479,313,208),USE(?String6:42),LEFT
         STRING(@s1),AT(1979,9479,156,208),USE(rS),CENTER
         STRING('Sastâdîts :'),AT(5198,9479,833,208),USE(?String6:43),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(6031,9479),USE(dat)
         STRING(@N-_14.2B),AT(6354,8542,1115,208),USE(S25),RIGHT
         STRING(@t4),AT(6979,9479),USE(lai)
         STRING(@N-_14.2B),AT(5052,8542,1115,208),USE(K25),RIGHT
         STRING(@N-_14.2B),AT(3740,8542,1115,208),USE(D25),RIGHT
         STRING('59 Nâkamo periodu ieòçmumi'),AT(260,8542,2083,208),USE(?String6:44),LEFT
         STRING(@N-_14.2B),AT(6354,7708,1115,208),USE(S21),RIGHT
         STRING(@N-_14.2B),AT(5052,7708,1115,208),USE(K21),RIGHT
         STRING(@N-_14.2B),AT(3740,7708,1115,208),USE(D21),RIGHT
         STRING(@N-_14.2B),AT(5052,7500,1115,208),USE(K20),RIGHT
         STRING(@N-_14.2B),AT(3740,7500,1115,208),USE(D20),RIGHT
         STRING(@N-_14.2B),AT(6354,8906,1115,208),USE(PSK),RIGHT
         STRING(@N-_14.2B),AT(6354,7917,1115,208),USE(S22),RIGHT
         STRING(@N-_14.2B),AT(5052,7917,1115,208),USE(K22),RIGHT
         STRING('56 Nor. par darba sam. un ietur.'),AT(260,7917,2083,208),USE(?String6:35),LEFT
         STRING('UZKRÂJUMI'),AT(250,5781,1250,208),USE(?String6:26),LEFT
         STRING(@N-_14.2B),AT(6354,5990,1115,208),USE(S14),RIGHT
         STRING(@N-_14.2B),AT(5052,5990,1115,208),USE(K14),RIGHT
         STRING(@N-_14.2B),AT(3740,5990,1115,208),USE(D14),RIGHT
         STRING('51 Norçíini ar aizòçmumiem'),AT(260,6865,1927,208),USE(?String6:36),LEFT
         STRING(@N-_14.2B),AT(3740,6198,1115,208),USE(D15),RIGHT
         STRING('52 Norçíini par saòemtiem avansiem'),AT(260,7083,2448,208),USE(?String6:30),LEFT
         STRING(@N-_14.2B),AT(5052,5469,1115,208),USE(K13),RIGHT
         STRING(@N-_14.2B),AT(3740,6406,1115,208),USE(D16),RIGHT
         STRING(@N-_14.2B),AT(5052,5260,1115,208),USE(K12),RIGHT
         STRING(@N-_14.2B),AT(5052,5052,1115,208),USE(K11),RIGHT
         STRING('33 Rezerves'),AT(250,5260,1667,208),USE(?String6:20),LEFT
         STRING('34 Nesadalîtâ peïòa, nesegtie zaudçjumi'),AT(250,5469,2552,208),USE(?String6:25),LEFT
         STRING('41 Uzkrâjumi pens. piel. saist.'),AT(250,5990,2448,208),USE(?String6:27),LEFT
         STRING('55 Nor. ar uzò., dalîbn., pers.'),AT(260,7708,2083,208),USE(?String6:34),LEFT
         STRING('54 Maksâjamie vekseïi'),AT(260,7500,2083,208),USE(?String6:33),LEFT
         STRING(@N-_14.2B),AT(6354,5469,1115,208),USE(S13),RIGHT
         STRING('53 Norçíini ar pieg. un darbuzò.'),AT(260,7271,2083,208),USE(?String6:31),LEFT
         STRING(@N-_14.2B),AT(3740,6865,1115,208),USE(D17),RIGHT
         STRING(@N-_14.2B),AT(5052,6198,1115,208),USE(K15),RIGHT
         LINE,AT(156,8802,7396,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('42 Uzkrâjumi paredz. nodokïiem'),AT(250,6198,2448,208),USE(?String6:32),LEFT
         STRING(@N-_14.2B),AT(3740,5052,1115,208),USE(D11),RIGHT
         STRING('43 Citi uzkrâjumi'),AT(260,6406,2448,208),USE(?String6:28),LEFT
         STRING(@N-_14.2B),AT(3740,5469,1115,208),USE(D13),RIGHT
         STRING(@N-_14.2B),AT(3740,5260,1115,208),USE(D12),RIGHT
         LINE,AT(156,4531,7396,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6354,3542,1115,208),USE(S09),RIGHT
         STRING(@N-_14.2B),AT(5052,3542,1115,208),USE(K09),RIGHT
         STRING(@N-_14.2B),AT(3740,3542,1115,208),USE(D09),RIGHT
         STRING(@N-_14.2B),AT(6354,3125,1115,208),USE(S07),RIGHT
         STRING(@N-_14.2B),AT(5052,3125,1115,208),USE(K07),RIGHT
         STRING('KREDÎTS'),AT(5104,4271,833,208),USE(?String6:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('DEBETS'),AT(3948,4260,656,208),USE(?String6:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,3802,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6354,2688,1115,208),USE(S05),RIGHT
         STRING('24 Nâkamo periodu izdevumi'),AT(260,3125,2448,208),USE(?String6:13),LEFT
         STRING('23 Prasîbas (debitoru parâdi)'),AT(260,2917,2448,208),USE(?String6:12),LEFT
         STRING(@N-_14.2B),AT(5052,2688,1115,208),USE(K05),RIGHT
         STRING('APGROZÂMIE LÎDZEKÏI'),AT(260,2240,1719,208),USE(?String6:9),LEFT
         STRING(@N-_14.2B),AT(6354,1771,1115,208),USE(S02),RIGHT
         STRING(@N-_14.2B),AT(5052,1771,1115,208),USE(K02),RIGHT
         STRING('21 Krâjumi'),AT(260,2479,2448,208),USE(?String6:10),LEFT
         STRING('22 Produktîvie dzîvnieki'),AT(260,2688,2448,208),USE(?String6:11),LEFT
         STRING(@N-_14.2B),AT(5052,1979,1115,208),USE(K03),RIGHT
         STRING('25 Vçrtspap., îsterm. lîdzdalîba'),AT(260,3333,2448,208),USE(?String6:14),LEFT
         STRING(@N-_14.2B),AT(6354,2479,1115,208),USE(S04),RIGHT
         STRING(@N-_14.2B),AT(5052,2479,1115,208),USE(K04),RIGHT
         STRING(@N-_14.2B),AT(3740,2479,1115,208),USE(D04),RIGHT
         STRING(@N-_14.2B),AT(3740,2688,1115,208),USE(D05),RIGHT
         STRING(@N-_14.2B),AT(6354,1979,1115,208),USE(S03),RIGHT
         STRING('KOPÂ :'),AT(271,3906,990,208),USE(?String6:21),LEFT
         STRING(@N-_14.2B),AT(6354,2917,1115,208),USE(S06),RIGHT
         STRING('26 Naudas lîdzekïi'),AT(260,3542,2448,208),USE(?String6:15),LEFT
         STRING(@N-_14.2B),AT(5052,2917,1115,208),USE(K06),RIGHT
         STRING(@N-_14.2B),AT(3740,2917,1115,208),USE(D06),RIGHT
         LINE,AT(156,4167,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('PASÎVS'),AT(1302,4260,781,208),USE(?String6:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(3740,1979,1115,208),USE(D03),RIGHT
         STRING(@N-_14.2B),AT(3740,1771,1115,208),USE(D02),RIGHT
         STRING('ILGTERMIÒA NOGULDÎJUMI'),AT(260,1354,2760,208),USE(?String6:5),LEFT
         LINE,AT(156,885,0,8490),USE(?Line2),COLOR(COLOR:Black)
       END
       FOOTER,AT(1000,9000,6927,1000)
       END
       FORM,AT(1000,1000,6927,9000)
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
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK:DAT_KEY)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Completed'
  ProgressWindow{Prop:Text} = 'Apgrozîjuma Bilances kontos sagatavoðana'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(GGK:RECORD)
     ggk:datums=s_dat
     CG = 'K10'
     SET(GGK:DAT_KEY,ggk:dat_key)
     Process:View{Prop:Filter} = '~CYCLEGGK(CG) AND INRANGE(SUB(GGK:BKK,1,2),11,59)'
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
     dat = today()
     lai= CLOCK()
      IF F:DBF='E'
         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
            LINEH[I#]=CHR(151)
         .
      ELSE
         LOOP I#=1 TO 190
            LINEH[I#]='-'
         .
      .
       d01=0
       d02=0
       d03=0
       d04=0
       d05=0
       d06=0
       d07=0
       d08=0
       d09=0
       d10=0
       d11=0
       d12=0
       d13=0
       d14=0
       d15=0
       d16=0
       d17=0
       d18=0
       d19=0
       d20=0
       d21=0
       d22=0
       d23=0
       d24=0
       d25=0
       k01=0
       k02=0
       k03=0
       k04=0
       k05=0
       k06=0
       k07=0
       k08=0
       k09=0
       k10=0
       k11=0
       k12=0
       k13=0
       k14=0
       k15=0
       k16=0
       k17=0
       k18=0
       k19=0
       k20=0
       k21=0
       k22=0
       k23=0
       k24=0
       k25=0
       ADK=0
       AKK=0
       PDK=0
       PKK=0
       ASK1=0
       SK#=0
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !RTF
        IF ~OPENANSI('BILFORM.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='APGROZÎJUMS BILANCES KONTOS NO '&FORMAT(S_DAT,@D06.)&' LÎDZ '&FORMAT(B_DAT,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      .
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
       nk#+=1
       ?Progress:UserString{Prop:Text}=NK#
       DISPLAY(?Progress:UserString)
       J#=0
       k# = 0
!       DONE# = 0                                      !TURN OFF DONE FLAG
!       CLEAR(GGK:RECORD)
!       GGK:DATUMS=S_DAT
!       SET(ggk:BKK_DAT,GGK:BKK_DAT)                   !  POINT TO FIRST RECORD
!       DO NEXT_RECORD                                 !READ FIRST RECORD
!       LOOP UNTIL DONE#                               !READ ALL RECORDS IN FILE
!         stop('we are in cycle LOOP UNTIL DONE')
         CASE GGK:D_K
         OF 'D'
           D=GGK:SUMMA
           K=0
           IF SUB(GGK:BKK,1,1) <= 2
               ADK += GGK:SUMMA
           ELSE
               PDK += GGK:SUMMA
           .
         OF 'K'
           K=GGK:SUMMA
           D=0
           IF SUB(GGK:BKK,1,1) <= 2
               AKK += GGK:SUMMA
           ELSE
               PKK += GGK:SUMMA
           .
         .
         BKK=SUB(GGK:BKK,1,2)
         case bkk
         OF '11'
            D01 += D                               !  CONDITION IS TRUE
            K01 += K                               !  CONDITION IS TRUE
         OF '12'
            D02 += D                               !  CONDITION IS TRUE
            K02 += K                               !  CONDITION IS TRUE
         OF '13'
            D03 += D                               !  CONDITION IS TRUE
            K03 += K                               !  CONDITION IS TRUE
         OF '21'
            D04 += D                               !  CONDITION IS TRUE
            K04 += K                               !  CONDITION IS TRUE
         OF '22'
            D05 += D                               !  CONDITION IS TRUE
            K05 += K                               !  CONDITION IS TRUE
         OF '23'
            D06 += D                               !  CONDITION IS TRUE
            K06 += K                               !  CONDITION IS TRUE
         OF '24'
            D07  += D                              !  CONDITION IS TRUE
            K07 += K                               !  CONDITION IS TRUE
         OF '25'
            D08  += D                              !  CONDITION IS TRUE
            K08 += K                               !  CONDITION IS TRUE
         OF '26'
            D09  += D                              !  CONDITION IS TRUE
            K09 += K                               !  CONDITION IS TRUE
         OF '31'
            D10  += D                              !  CONDITION IS TRUE
            K10 += K                               !  CONDITION IS TRUE
         OF '32'
            D11  += D                              !  CONDITION IS TRUE
            K11 += K                               !  CONDITION IS TRUE
         OF '33'
            D12  += D                              !  CONDITION IS TRUE
            K12 += K                               !  CONDITION IS TRUE
         OF '34'
            D13  += D                              !  CONDITION IS TRUE
            K13 += K                               !  CONDITION IS TRUE
         OF '41'
            D14  += D                              !  CONDITION IS TRUE
            K14 += K                               !  CONDITION IS TRUE
         OF '42'
            D15  += D                              !  CONDITION IS TRUE
            K15 += K                               !  CONDITION IS TRUE
         OF '43'
            D16  += D                              !  CONDITION IS TRUE
            K16 += K                               !  CONDITION IS TRUE
         OF '51'
            D17  += D                              !  CONDITION IS TRUE
            K17 += K                               !  CONDITION IS TRUE
         OF '52'
            D18  += D                              !  CONDITION IS TRUE
            K18 += K                               !  CONDITION IS TRUE
         OF '53'
            D19  += D                              !  CONDITION IS TRUE
            K19 += K                               !  CONDITION IS TRUE
         OF '54'
            D20  += D                              !  CONDITION IS TRUE
            K20 += K                               !  CONDITION IS TRUE
         OF '55'
            D21  += D                              !  CONDITION IS TRUE
            K21 += K                               !  CONDITION IS TRUE
         OF '56'
            D22  += D                              !  CONDITION IS TRUE
            K22 += K                               !  CONDITION IS TRUE
         OF '57'
            D23  += D                              !  CONDITION IS TRUE
            K23 += K                               !  CONDITION IS TRUE
         OF '58'
            D24  += D                              !  CONDITION IS TRUE
            K24 += K                               !  CONDITION IS TRUE
         OF '59'
            D25  += D                              !  CONDITION IS TRUE
            K25 += K
         ELSE
            STOP(BKK)
         .
!         DO NEXT_RECORD                               !  GET NEXT RECORD
!       .                                              !
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
        S01 =  D01- K01
        S02 =  D02- K02
        S03 =  D03- K03
        S04 =  D04- K04
        S05 =  D05- K05
        S06 =  D06- K06
        S07 =  D07- K07
        S08 =  D08- K08
        S09 =  D09- K09
        S10 =  D10- K10
        S11 =  D11- K11
        S12 =  D12- K12
        S13 =  D13- K13
        S14 =  D14- K14
        S15 =  D15- K15
        S16 =  D16- K16
        S17 =  D17- K17
        S18 =  D18- K18
        S19 =  D19- K19
        S20 =  D20- K20
        S21 =  D21- K21
        S22 =  D22- K22
        S23 =  D23- K23
        S24 =  D24- K24
        S25 =  D25- K25
        ASK1 =  ADK- AKK
        PSK =  PDK- PKK
        BSK =  ASK1+ PSK
        IF F:DBF = 'W'
            PRINT(RPT:DETAIL)                            !PRINT GRAND TOTALS
        ELSE
            OUTA:LINE='AKTÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
            ADD(OUTFILEANSI)
            OUTA:LINE='ILGTERMIÒA IEGULDÎJUMI'&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
            OUTA:LINE=' 11 Nemateriâlie'&CHR(9)&LEFT(FORMAT(D01,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K01,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S01,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 12 Pamatlîdzekïi'&CHR(9)&LEFT(FORMAT(D02,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K02,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S02,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 13 Ilgtermiòa fin. ieguldîjumi'&CHR(9)&LEFT(FORMAT(D03,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K03,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S03,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='APGROZÂMIE LÎDZEKÏI'&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
            OUTA:LINE=' 21 Krâjumi'&CHR(9)&LEFT(FORMAT(D04,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K04,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S04,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 22 Produktîvie dzîvnieki'&CHR(9)&LEFT(FORMAT(D05,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K05,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S05,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 23 Prasîbas (debitoru parâdi)'&CHR(9)&LEFT(FORMAT(D06,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K06,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S06,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 24 Nâkamo periodu izdevumi'&CHR(9)&LEFT(FORMAT(D07,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K07,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S07,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 25 Vçrtspap., îsterm. lîdzdalîba'&CHR(9)&LEFT(FORMAT(D08,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K08,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S08,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 26 Naudas lîdzekïi'&CHR(9)&LEFT(FORMAT(D09,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K09,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S09,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='KOPÂ'&CHR(9)&LEFT(FORMAT(ADK,@N-_14.2B))&CHR(9)&LEFT(FORMAT(AKK,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(ASK1,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='PASÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
            ADD(OUTFILEANSI)
            OUTA:LINE='KAPITÂLS'&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
            OUTA:LINE=' 31 Pamatkapitâls'&CHR(9)&LEFT(FORMAT(D10,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K10,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S10,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 32 Privâtkonti'&CHR(9)&LEFT(FORMAT(D11,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K11,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S11,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 33 Rezerves'&CHR(9)&LEFT(FORMAT(D12,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K12,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(S12,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 34 Nesadal. peïòa, neseg. zaud.'&CHR(9)&LEFT(FORMAT(D13,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K13,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S13,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='UZKRÂJUMI'&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
            OUTA:LINE=' 41 Uzkrâjumi pens. piel. saist.'&CHR(9)&LEFT(FORMAT(D14,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K14,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S14,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 42 Uzkrâjumi paredz. nodokïiem'&CHR(9)&LEFT(FORMAT(D15,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K15,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S15,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 43 Citi uzkrajumi'&CHR(9)&LEFT(FORMAT(D16,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K16,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(S16,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='KREDÎTORI'&CHR(9)&CHR(9)&CHR(9)
            ADD(OUTFILEANSI)
            OUTA:LINE=' 51 Norçíini ar aizòçmumiem'&CHR(9)&LEFT(FORMAT(D17,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K17,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S17,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 52 Norçíini par saòem. avansiem'&CHR(9)&LEFT(FORMAT(D18,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K18,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S18,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 53 Norçíini ar pieg. un darbuzò.'&CHR(9)&LEFT(FORMAT(D19,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K19,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S19,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 54 Maksâjamie vekseïi'&CHR(9)&LEFT(FORMAT(D20,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K20,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S20,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 55 Nor. ar uzò., dalîbn., pers.'&CHR(9)&LEFT(FORMAT(D21,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K21,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S21,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 56 Nor. par darba sam. un ietur.'&CHR(9)&LEFT(FORMAT(D22,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(K22,@N-_14.2B))&CHR(9)&LEFT(FORMAT(S22,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 57 Norçíini par nodokïiem'&CHR(9)&LEFT(FORMAT(D23,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K23,@N-_14.2B))&|
                       LEFT(CHR(9)&FORMAT(S23,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 58 Norçíini par dividendçm'&CHR(9)&LEFT(FORMAT(D24,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K24,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S24,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE=' 59 Nâkamo periodu ieòçmumi'&CHR(9)&LEFT(FORMAT(D25,@N-_14.2B))&CHR(9)&LEFT(FORMAT(K25,@N-_14.2B))&|
                       CHR(9)&LEFT(FORMAT(S25,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='KOPÂ'&CHR(9)&LEFT(FORMAT(PDK,@N-_14.2B))&CHR(9)&LEFT(FORMAT(PKK,@N-_14.2B))&CHR(9)&|
                       LEFT(FORMAT(PSK,@N-_14.2B))
            ADD(OUTFILEANSI)
            OUTA:LINE='BILANCE'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(BSK,@N-_14.2B))
            ADD(OUTFILEANSI)
        END
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

!-----------------------------------------------------------------------------------------------------------------------
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
!------------------
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Completed'
      DISPLAY()
    END
  END
!NEXT_RECORD ROUTINE                              !GET NEXT RECORD
!  LOOP UNTIL EOF(ggk)                            !  READ UNTIL END OF FILE
!    NEXT(ggk)                                    !    READ NEXT RECORD
!    SK#+=1
!!    SHOW(15,31,SK#,@N_6)
!    IF ~CYCLERST(GGK:RS) THEN CYCLE.
!    IF ~(ggk:DATUMS <= b_DAT) THEN BREAK.
!    IF ~(sub(GGK:bkk,1,1) > 5) THEN CYCLE.
!    EXIT                                         !    EXIT THE ROUTINE
!  .                                              !
!  DONE# = 1                                      !  ON EOF, SET DONE FLAG
B_OpeForm            PROCEDURE                    ! Declare Procedure
CG                   STRING(10)
BKK                  STRING(3)
D                    DECIMAL(12,2)
K                    DECIMAL(12,2)
D00                  DECIMAL(14,2)
D1                   DECIMAL(14,2)
D2                   DECIMAL(14,2)
D3                   DECIMAL(14,2)
D4                   DECIMAL(14,2)
D5                   DECIMAL(14,2)
D6                   DECIMAL(14,2)
D7                   DECIMAL(14,2)
D8                   DECIMAL(14,2)
D9                   DECIMAL(14,2)
D10                  DECIMAL(14,2)
D11                  DECIMAL(14,2)
D12                  DECIMAL(14,2)
D13                  DECIMAL(14,2)
D14                  DECIMAL(14,2)
D15                  DECIMAL(14,2)
D16                  DECIMAL(14,2)
D17                  DECIMAL(14,2)
D18                  DECIMAL(14,2)
D19                  DECIMAL(14,2)
D20                  DECIMAL(14,2)
D201                 DECIMAL(14,2)
D21                  DECIMAL(14,2)
D22                  DECIMAL(14,2)
D23                  DECIMAL(14,2)
D24                  DECIMAL(14,2)
K00                  DECIMAL(14,2)
K1                   DECIMAL(14,2)
K2                   DECIMAL(14,2)
K3                   DECIMAL(14,2)
K4                   DECIMAL(14,2)
K5                   DECIMAL(14,2)
K6                   DECIMAL(14,2)
K7                   DECIMAL(14,2)
K8                   DECIMAL(14,2)
K9                   DECIMAL(14,2)
K10                  DECIMAL(14,2)
K11                  DECIMAL(14,2)
K12                  DECIMAL(14,2)
K13                  DECIMAL(14,2)
K14                  DECIMAL(14,2)
K15                  DECIMAL(14,2)
K16                  DECIMAL(14,2)
K17                  DECIMAL(14,2)
K18                  DECIMAL(14,2)
K19                  DECIMAL(14,2)
K20                  DECIMAL(14,2)
K201                 DECIMAL(14,2)
K21                  DECIMAL(14,2)
K22                  DECIMAL(14,2)
K23                  DECIMAL(14,2)
K24                  DECIMAL(14,2)
S00                  DECIMAL(14,2)
S1                   DECIMAL(14,2)
S2                   DECIMAL(14,2)
S3                   DECIMAL(14,2)
S4                   DECIMAL(14,2)
S5                   DECIMAL(14,2)
S6                   DECIMAL(14,2)
S7                   DECIMAL(14,2)
S8                   DECIMAL(14,2)
S9                   DECIMAL(14,2)
S10                  DECIMAL(14,2)
S11                  DECIMAL(14,2)
S12                  DECIMAL(14,2)
S13                  DECIMAL(14,2)
S14                  DECIMAL(14,2)
S15                  DECIMAL(14,2)
S16                  DECIMAL(14,2)
S17                  DECIMAL(14,2)
S18                  DECIMAL(14,2)
S19                  DECIMAL(14,2)
S20                  DECIMAL(14,2)
S21                  DECIMAL(14,2)
S22                  DECIMAL(14,2)
S23                  DECIMAL(14,2)
S24                  DECIMAL(14,2)
S201                 DECIMAL(14,2)
KA                   DECIMAL(14,2)
KP                   DECIMAL(14,2)
FR                   DECIMAL(14,2)
DAT                  DATE
LAI                  TIME
LINEH                STRING(190)
NOS68                STRING(60)
NOS60                STRING(60)
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
PrintSkipDetails     BOOL,AUTO
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
report REPORT,AT(198,104,8000,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(-10,,8000,10323),USE(?unnamed)
         STRING(@N-_14.2B),AT(6615,9531),USE(FR),RIGHT
         STRING(@s45),AT(1458,156,4427,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('APGROZÎJUMS OPERÂCIJU KONTOS NO '),AT(469,521),USE(?String2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@D6),AT(3906,521),USE(S_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,870,7396,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(3646,885,0,8906),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4948,885,0,8906),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(6250,885,0,8906),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(7552,885,0,8906),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('AKTÎVS'),AT(1302,990,625,208),USE(?String6),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('DEBETS'),AT(4010,990,677,208),USE(?String6:2),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KREDÎTS'),AT(5260,990,781,208),USE(?String6:3),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('SALDO'),AT(6667,990,677,208),USE(?String6:4),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1250,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(3740,1573,1115,208),USE(D1),RIGHT
         STRING(@N-_14.2B),AT(5042,1573,1115,208),USE(K1),RIGHT
         STRING(@N-_14.2B),AT(6354,1573,1115,208),USE(S1),RIGHT
         STRING('71 Mater., izejv., preèu ieg.'),AT(260,1573,2760,208),USE(?String6:6),LEFT
         STRING('72 Personâla izmaksas'),AT(260,1771,2760,208),USE(?String6:7),LEFT
         STRING('73 Sociâlâs nodevas un izm.'),AT(260,1969,2760,208),USE(?String6:8),LEFT
         STRING('74 PL noliet., citu ieg. nor.'),AT(260,2177,2448,208),USE(?String6:9),LEFT
         STRING('SALDO'),AT(6667,5417,677,208),USE(?String6:25),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(3750,4688,1115,208),USE(D13),RIGHT
         STRING('IEÒÇMUMI NO SAIMNIECISKÂS DARBÎBAS'),AT(260,5781,3073,208),USE(?String6:26),LEFT
         STRING(@s45),AT(260,5990,2917,208),USE(NOS60),LEFT
         STRING(@N-_14.2B),AT(3750,5990,1115,208),USE(D00),RIGHT
         STRING(@N-_14.2B),AT(5052,5990,1115,208),USE(K00),RIGHT
         STRING(@N-_14.2B),AT(6406,5990,1115,208),USE(S00),RIGHT
         STRING(@N-_14.2B),AT(6354,5052,1115,208),USE(KA),RIGHT
         STRING(@N-_14.2B),AT(6375,6198,1115,208),USE(S14),RIGHT
         STRING(@N-_14.2B),AT(5042,6198,1115,208),USE(K14),RIGHT
         STRING(@N-_14.2B),AT(3750,6198,1115,208),USE(D14),RIGHT
         STRING('61 Ieòçmumi no pamatdarbîbas'),AT(260,6198,2448,208),USE(?String6:27),LEFT
         STRING('62 Ieòçmumi no pârd. (cit. apliek.)'),AT(260,6406,2448,208),USE(?String6:28),LEFT
         STRING('KOPÂ :'),AT(260,9323,990,208),USE(?String6:39),LEFT
         STRING('Finansu rezultâts :'),AT(260,9531,1563,208),USE(?String6:40),LEFT
         STRING(@N-_14.2B),AT(6375,8594,1115,208),USE(S23),RIGHT
         STRING(@N-_14.2B),AT(5042,8594,1115,208),USE(K23),RIGHT
         STRING(@N-_14.2B),AT(6375,7448,1115,208),USE(S20),RIGHT
         STRING(@s45),AT(260,7656,2917,208),USE(NOS68),LEFT
         STRING(@N-_14.2B),AT(3750,7656,1115,208),USE(D201),RIGHT
         STRING(@N-_14.2B),AT(5052,7656,1115,208),USE(K201),RIGHT
         STRING(@N-_14.2B),AT(6406,7656,1115,208),USE(S201),RIGHT
         STRING(@N-_14.2B),AT(3750,8594,1115,208),USE(D23),RIGHT
         STRING(@N-_14.2B),AT(5042,7448,1115,208),USE(K20),RIGHT
         STRING(@N-_14.2B),AT(6375,6615,1115,208),USE(S16),RIGHT
         STRING(@N-_14.2B),AT(6375,6406,1115,208),USE(S15),RIGHT
         LINE,AT(156,9792,7396,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6375,8958,1115,208),USE(S24),RIGHT
         STRING(@N-_14.2B),AT(5042,8958,1115,208),USE(K24),RIGHT
         STRING(@N-_14.2B),AT(6354,8385,1115,208),USE(S22),RIGHT
         STRING(@N-_14.2B),AT(3750,8958,1115,208),USE(D24),RIGHT
         STRING(@N-_14.2B),AT(5042,8385,1115,208),USE(K22),RIGHT
         STRING(@N-_14.2B),AT(6375,7240,1115,208),USE(S19),RIGHT
         STRING('Operators :'),AT(208,9896,729,208),USE(?String6:41),LEFT
         STRING(@s8),AT(938,9896,625,208),USE(ACC_kods)
         STRING('RS :'),AT(1667,9896,313,208),USE(?String6:42),LEFT
         STRING(@s1),AT(1979,9896,208,208),USE(rS),CENTER
         STRING('Sastâdîts :'),AT(5198,9896,833,208),USE(?String6:43),LEFT
         STRING(@d6),AT(6031,9896),USE(dat)
         STRING(@t4),AT(6979,9896),USE(lai)
         STRING(@N-_14.2B),AT(6406,9323,1115,208),USE(kp),RIGHT
         STRING('CITI IEÒÇMUMI'),AT(260,8125,1250,208),USE(?String6:35),LEFT
         STRING(@N-_14.2B),AT(6375,7031,1115,208),USE(S18),RIGHT
         STRING(@N-_14.2B),AT(5042,7031,1115,208),USE(K18),RIGHT
         STRING(@N-_14.2B),AT(3750,7031,1115,208),USE(D18),RIGHT
         STRING('81 Daþâdi ieòçmumi'),AT(260,8385,1927,208),USE(?String6:36),LEFT
         STRING(@N-_14.2B),AT(3750,7240,1115,208),USE(D19),RIGHT
         STRING('83 Ârkârtas ieòçmumi'),AT(260,8594,1927,208),USE(?String6:37),LEFT
         STRING(@N-_14.2B),AT(3750,7865,1115,208),USE(D21),RIGHT
         STRING(@N-_14.2B),AT(5042,6823,1115,208),USE(K17),RIGHT
         STRING(@N-_14.2B),AT(3750,7448,1115,208),USE(D20),RIGHT
         STRING(@N-_14.2B),AT(5042,6615,1115,208),USE(K16),RIGHT
         STRING(@N-_14.2B),AT(5042,6406,1115,208),USE(K15),RIGHT
         STRING('63 Komisijas, starpn. u.c. ieòçmumi'),AT(260,6615,2448,208),USE(?String6:29),LEFT
         STRING('64 Ieòçm. samazin. atlaides'),AT(260,6823,2448,208),USE(?String6:30),LEFT
         STRING('65 Pârçjie uzòçmuma ieòçmumi'),AT(260,7031,2448,208),USE(?String6:31),LEFT
         LINE,AT(156,8854,7396,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6375,7865,1115,208),USE(S21),RIGHT
         STRING(@N-_14.2B),AT(5042,7865,1115,208),USE(K21),RIGHT
         STRING(@N-_14.2B),AT(6354,6823,1115,208),USE(S17),RIGHT
         STRING('86 Peïòa vai zaudçjumi'),AT(260,8958,1927,208),USE(?String6:38),LEFT
         STRING(@N-_14.2B),AT(3750,8385,1115,208),USE(D22),RIGHT
         STRING(@N-_14.2B),AT(5042,7240,1115,208),USE(K19),RIGHT
         LINE,AT(156,9219,7396,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('66 Krâjumu vçrtîbas izmaiòas'),AT(260,7240,2448,208),USE(?String6:32),LEFT
         STRING(@N-_14.2B),AT(3750,6406,1115,208),USE(D15),RIGHT
         STRING('67 Citu p. ieò. (att. uz pârsk.)'),AT(260,7448,2448,208),USE(?String6:33),LEFT
         STRING('69 Soc. infr. iest. un pas. ieò.'),AT(260,7865,2448,208),USE(?String6:34),LEFT
         STRING(@N-_14.2B),AT(3750,6823,1115,208),USE(D17),RIGHT
         STRING(@N-_14.2B),AT(3750,6615,1115,208),USE(D16),RIGHT
         LINE,AT(156,5677,7396,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6354,4688,1115,208),USE(S13),RIGHT
         STRING(@N-_14.2B),AT(5042,4688,1115,208),USE(K13),RIGHT
         STRING('KREDÎTS'),AT(5260,5417,781,208),USE(?String6:24),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('DEBETS'),AT(4010,5417,677,208),USE(?String6:23),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,4948,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(6354,3958,1115,208),USE(S11),RIGHT
         STRING(@N-_14.2B),AT(5042,3958,1115,208),USE(K11),RIGHT
         STRING(@N-_14.2B),AT(6354,3021,1115,208),USE(S8),RIGHT
         STRING('75 Pârçjie saimn. darb. izdevumi'),AT(260,2365,2448,208),USE(?String6:10),LEFT
         STRING('76 Preèu pârdoðanas izdevumi'),AT(260,2583,2448,208),USE(?String6:11),LEFT
         STRING('CITI IZDEVUMI'),AT(260,3490,1302,208),USE(?String6:15),LEFT
         STRING(@N-_14.2B),AT(6354,2583,1115,208),USE(S6),RIGHT
         STRING(@N-_14.2B),AT(5042,2583),USE(K6),RIGHT
         STRING(@N-_14.2B),AT(6354,1771),USE(S2),RIGHT
         STRING(@N-_14.2B),AT(5042,2365),USE(K5),RIGHT
         STRING(@N-_14.2B),AT(3750,2583,1115,208),USE(D6),RIGHT
         STRING(@N-_14.2B),AT(5042,1771),USE(K2),RIGHT
         STRING('82 Daþâdi izdevumi'),AT(260,3750,2448,208),USE(?String6:16),LEFT
         STRING(@N-_14.2B),AT(3750,2792,1115,208),USE(D7),RIGHT
         STRING('84 Ârkârtas izdevumi'),AT(260,3958,2448,208),USE(?String6:17),LEFT
         STRING(@N-_14.2B),AT(3750,3021,1115,208),USE(D8),RIGHT
         STRING(@N-_14.2B),AT(5042,1969,1115,208),USE(K3),RIGHT
         STRING('ZAUDÇJUMI,  PEÏÒAS  IZLIETOJUMS'),AT(260,4219,2500,208),USE(?String6:18),LEFT
         STRING(@N-_14.2B),AT(6354,3750,1115,208),USE(S10),RIGHT
         STRING(@N-_14.2B),AT(6354,3229,1115,208),USE(S9),RIGHT
         STRING(@N-_14.2B),AT(5042,3750,1115,208),USE(K10),RIGHT
         STRING(@N-_14.2B),AT(6354,2792,1115,208),USE(S7),RIGHT
         STRING(@N-_14.2B),AT(5042,3229,1115,208),USE(K9),RIGHT
         STRING(@N-_14.2B),AT(6354,2365,1115,208),USE(S5),RIGHT
         STRING(@N-_14.2B),AT(3750,3229,1115,208),USE(D9),RIGHT
         STRING(@N-_14.2B),AT(5042,2177,1115,208),USE(K4),RIGHT
         STRING('87 Peïòas izlietojums'),AT(260,4479,2448,208),USE(?String6:19),LEFT
         STRING(@N-_14.2B),AT(3750,3750,1115,208),USE(D10),RIGHT
         STRING(@N-_14.2B),AT(5042,2792,1115,208),USE(K7),RIGHT
         STRING('88 Nodokïi no peïòas u.c.'),AT(260,4688,2448,208),USE(?String6:20),LEFT
         STRING(@N-_14.2B),AT(3750,3958,1115,208),USE(D11),RIGHT
         STRING(@N-_14.2B),AT(5042,3021,1115,208),USE(K8),RIGHT
         STRING(@N-_14.2B),AT(6354,2177,1115,208),USE(S4),RIGHT
         STRING(@N-_14.2B),AT(6354,1969,1115,208),USE(S3),RIGHT
         STRING('KOPÂ :'),AT(260,5052,990,208),USE(?String6:21),LEFT
         STRING(@N-_14.2B),AT(6354,4479,1115,208),USE(S12),RIGHT
         STRING(@N-_14.2B),AT(5042,4479,1115,208),USE(K12),RIGHT
         STRING(@N-_14.2B),AT(3750,4479,1115,208),USE(D12),RIGHT
         LINE,AT(156,5313,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('PASÎVS'),AT(1302,5417,625,208),USE(?String6:22),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('77 Administrâcijas izdevumi'),AT(260,2792,2448,208),USE(?String6:12),LEFT
         STRING(@N-_14.2B),AT(3750,1969,1115,208),USE(D3),RIGHT
         STRING(@N-_14.2B),AT(3750,1771,1115,208),USE(D2),RIGHT
         STRING('78 Pârsk. p. iekï. iepr. p. izd.'),AT(260,3021,2448,208),USE(?String6:13),LEFT
         STRING('79 Soc. infrastr. uztur. izd.'),AT(260,3229,2448,208),USE(?String6:14),LEFT
         STRING(@N-_14.2B),AT(3750,2365,1115,208),USE(D5),RIGHT
         STRING(@N-_14.2B),AT(3750,2177,1115,208),USE(D4),RIGHT
         STRING('SAIMNIECISKÂS DARBÎBAS IZDEVUMI'),AT(260,1354,2760,208),USE(?String6:5),LEFT
         LINE,AT(156,885,0,8906),USE(?Line2),COLOR(COLOR:Black)
         STRING(@D6),AT(5573,521),USE(B_DAT),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('LÎDZ '),AT(5000,521),USE(?String2:2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(1000,9000,6927,0)
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
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(KON_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  FilesOpened = True
  dat = today()
  LAI = CLOCK()
  RecordsToProcess = RECORDS(GGK:DAT_KEY)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Apgrozîjuma operâcijas kontos sagatavoðana'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
     CASE EVENT()
     OF Event:OpenWindow
        CLEAR(GGK:RECORD)
        GGK:DATUMS = S_DAT
        CG = 'K10'
!!        IF F:DBF='E'
!!           LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
!!              LINEH[I#]=CHR(151)
!!           .
!!        ELSE
!!           LOOP I#=1 TO 190
!!              LINEH[I#]='-'
!!           .
!!        .
        SET(GGK:DAT_key,GGK:DAT_KEY)
        Process:View{Prop:Filter} = '~CYCLEGGK(CG) AND INRANGE(GGK:BKK[1:2],60,88)'
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
        ELSE           !RTF
          IF ~OPENANSI('OPEFORM.TXT')
             POST(Event:CloseWindow)
             CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='APGROZÎJUMS OPERÂCIJU KONTOS NO '&FORMAT(S_DAT,@D06.)&' LÎDZ '&FORMAT(B_DAT,@D06.)
          ADD(OUTFILEANSI)
        .
     OF Event:Timer
        LOOP RecordsPerCycle TIMES
           nk#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           BKK=GGK:BKK[1:2]
           CASE GGK:D_K
           OF 'D'
             D = GGK:SUMMA
             K = 0
           OF 'K'
             K = GGK:SUMMA
             D = 0
           .
           case bkk
           OF '71'
             D1 += D
             K1 += K
           OF '72'
             D2 += D                                
             K2 += K                                
           OF '73'
             D3 += D                                
             K3 += K                                
           OF '74'
             D4 += D                                
             K4 += K                                
           OF '75'
             D5 += D                                
             K5 += K                                
           OF '76'
             D6 += D                                
             K6 += K                                
           OF '77'
             D7 += D                                
             K7 += K                                
           OF '78'
             D8 += D                                
             K8 += K                                
           OF '79'
             D9 += D                                
             K9 += K                                
           OF '82'
             D10 += D                               
             K10 += K                               
           OF '84'
             D11 += D                               
             K11 += K                               
           OF '87'
             D12 += D                               
             K12 += K                               
           OF '88'
             D13 += D                               
             K13 += K                               
           OF '60'
             D00 += D
             K00 += K
           OF '61'
             D14 += D                               
             K14 += K                               
           OF '62'
             D15 += D                               
             K15 += K                               
           OF '63'
             D16 += D                               
             K16 += K                               
           OF '64'
             D17 += D                               
             K17 += K                               
           OF '65'
             D18 += D                               
             K18 += K                               
           OF '66'
             D19 += D                               
             K19 += K                               
           OF '67'
             D20 += D                               
             K20 += K                               
           OF '68'
             D201 += D
             K201 += K
           OF '69'
             D21 += D                               
             K21 += K                               
           OF '81'
             D22 += D                               
             K22 += K                               
           OF '83'
             D23 += D                               
             K23 += K                               
           OF '86'
             D24 += D                               
             K24 += K                               
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
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     S1  =  D1 - K1
     S2  =  D2 - K2
     S3  =  D3 - K3
     S4  =  D4 - K4
     S5  =  D5 - K5
     S6  =  D6 - K6
     S7  =  D7 - K7
     S8  =  D8 - K8
     S9  =  D9 - K9
     S10 =  D10-  K10
     S11 =  D11-  K11
     S12 =  D12-  K12
     S13 =  D13-  K13

     S00 =  D00 -  K00
     S14 =  D14 -  K14
     S15 =  D15 -  K15
     S16 =  D16 -  K16
     S17 =  D17 -  K17
     S18 =  D18 -  K18
     S19 =  D19 -  K19
     S20 =  D20 -  K20
     S201=  D201-  K201
     S21 =  D21 -  K21
     S22 =  D22 -  K22
     S23 =  D23 -  K23
     S24 =  D24 -  K24

     KA= S1+ S2+ S3+ S4+ S5+ S6+ S7+S8+ S9+ S10+ S11+ S12+ S13
     KP= S00+S14+ S15+ S16+ S17+ S18+ S19+ S20 + S201 + S21+ S22+ S23+ S24
     FR= KA+ KP
     NOS60='60 '&GETKON_K('60',0,2)
     NOS68='68 '&GETKON_K('68',0,2)

     IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
        endpage(Report)
     ELSIF F:DBF='E'
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'AKTÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'SAIMNIECISKÂS DARBÎBAS IZDEVUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='71 Mater., izejv., preèu ieg.'&CHR(9)&LEFT(FORMAT(D1,@N-_14.2))&CHR(9)&LEFT(FORMAT(K1,@N-_14.2))&CHR(9)&LEFT(FORMAT(S1,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='72 Personâla izmaksas'&CHR(9)&LEFT(FORMAT(D2,@N-_14.2))&CHR(9)&LEFT(FORMAT(K2,@N-_14.2))&CHR(9)&LEFT(FORMAT(S2,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='73 Sociâlâs nodevas un izmaksas'&CHR(9)&LEFT(FORMAT(D3,@N-_14.2))&CHR(9)&LEFT(FORMAT(K3,@N-_14.2))&CHR(9)&LEFT(FORMAT(S3,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='74 PL nolietojums, citu ieg. nor.'&CHR(9)&LEFT(FORMAT(D4,@N-_14.2))&CHR(9)&LEFT(FORMAT(K4,@N-_14.2))&CHR(9)&LEFT(FORMAT(S4,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='75 Pârçjie saimn. darb. izdevumi'&CHR(9)&LEFT(FORMAT(D5,@N-_14.2))&CHR(9)&LEFT(FORMAT(K5,@N-_14.2))&CHR(9)&LEFT(FORMAT(S5,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='76 Preèu pârdoðanas izdevumi'&CHR(9)&LEFT(FORMAT(D6,@N-_14.2))&CHR(9)&LEFT(FORMAT(K6,@N-_14.2))&CHR(9)&LEFT(FORMAT(S6,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='77 Administrâcijas izdevumi'&CHR(9)&LEFT(FORMAT(D7,@N-_14.2))&CHR(9)&LEFT(FORMAT(K7,@N-_14.2))&CHR(9)&LEFT(FORMAT(S7,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='78 Pârsk.perioda iekï.iepr.p.izd.'&CHR(9)&LEFT(FORMAT(D8,@N-_14.2))&CHR(9)&LEFT(FORMAT(K8,@N-_14.2))&CHR(9)&LEFT(FORMAT(S8,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='79 Soc. infrastr. uztur. izd.'&CHR(9)&LEFT(FORMAT(D9,@N-_14.2))&CHR(9)&LEFT(FORMAT(K9,@N-_14.2))&CHR(9)&LEFT(FORMAT(S9,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'CITI IZDEVUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='82 Daþâdi izdevumi'&CHR(9)&LEFT(FORMAT(D10,@N-_14.2))&CHR(9)&LEFT(FORMAT(K10,@N-_14.2))&CHR(9)&LEFT(FORMAT(S10,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='84 Ârkârtas izdevumi'&CHR(9)&LEFT(FORMAT(D11,@N-_14.2))&CHR(9)&LEFT(FORMAT(K11,@N-_14.2))&CHR(9)&LEFT(FORMAT(S11,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'ZAUDÇJUMI, PEÏÒAS IZLIETOJUMS'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='87 Peïòas izlietojums'&CHR(9)&LEFT(FORMAT(D12,@N-_14.2))&CHR(9)&LEFT(FORMAT(K12,@N-_14.2))&CHR(9)&LEFT(FORMAT(S12,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='88 Nodokïi no peïòas u.c.'&CHR(9)&LEFT(FORMAT(D13,@N-_14.2))&CHR(9)&LEFT(FORMAT(K13,@N-_14.2))&CHR(9)&LEFT(FORMAT(S13,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KA,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'PASÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'IEÒÇMUMI NO SAIMNIECISKÂS DARBÎBAS'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='61 Ieòçmumi no pamatdarbîbas'&CHR(9)&LEFT(FORMAT(D14,@N-_14.2))&CHR(9)&LEFT(FORMAT(K14,@N-_14.2))&CHR(9)&LEFT(FORMAT(S14,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='62 Ieòçmumi no pârd.(cit.apliek.)'&CHR(9)&LEFT(FORMAT(D15,@N-_14.2))&CHR(9)&LEFT(FORMAT(K15,@N-_14.2))&CHR(9)&LEFT(FORMAT(S15,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='63 Komisijas, starpn. un citi cieòçmumi'&CHR(9)&LEFT(FORMAT(D16,@N-_14.2))&CHR(9)&LEFT(FORMAT(K16,@N-_14.2))&CHR(9)&LEFT(FORMAT(S16,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='64 Ieòçm. samazin. atlaides'&CHR(9)&LEFT(FORMAT(D17,@N-_14.2))&CHR(9)&LEFT(FORMAT(K17,@N-_14.2))&CHR(9)&LEFT(FORMAT(S17,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='65 Pârçjie uzòçmuma ieòçmumi'&CHR(9)&LEFT(FORMAT(D18,@N-_14.2))&CHR(9)&LEFT(FORMAT(K18,@N-_14.2))&CHR(9)&LEFT(FORMAT(S18,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='66 Krâjumu vçrtîbas izmaiòas'&CHR(9)&LEFT(FORMAT(D19,@N-_14.2))&CHR(9)&LEFT(FORMAT(K19,@N-_14.2))&CHR(9)&LEFT(FORMAT(S19,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='67 Citu p. ieò. (att. uz pârsk.)'&CHR(9)&LEFT(FORMAT(D20,@N-_14.2))&CHR(9)&LEFT(FORMAT(K20,@N-_14.2))&CHR(9)&LEFT(FORMAT(S20,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='68 Soc. infr. iest. un pas. ieò.'&CHR(9)&LEFT(FORMAT(D21,@N-_14.2))&CHR(9)&LEFT(FORMAT(K21,@N-_14.2))&CHR(9)&LEFT(FORMAT(S21,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'CITI IEÒÇMUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='81 Daþâdi ieòçmumi'&CHR(9)&LEFT(FORMAT(D22,@N-_14.2))&CHR(9)&LEFT(FORMAT(K22,@N-_14.2))&CHR(9)&LEFT(FORMAT(S22,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='83 Ârkârtas ieòçmumi'&CHR(9)&LEFT(FORMAT(D23,@N-_14.2))&CHR(9)&LEFT(FORMAT(K23,@N-_14.2))&CHR(9)&LEFT(FORMAT(S23,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='86 Peïòa vai zaudçjumi'&CHR(9)&LEFT(FORMAT(D24,@N-_14.2))&CHR(9)&LEFT(FORMAT(K24,@N-_14.2))&CHR(9)&LEFT(FORMAT(S24,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KP,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Finansu rezultâts'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(FR,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
      ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'AKTÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'SAIMNIECISKÂS DARBÎBAS IZDEVUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='71 Mater., izejv., preèu ieg.'&CHR(9)&LEFT(FORMAT(D1,@N-_14.2))&CHR(9)&LEFT(FORMAT(K1,@N-_14.2))&CHR(9)&LEFT(FORMAT(S1,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='72 Personâla izmaksas'&CHR(9)&LEFT(FORMAT(D2,@N-_14.2))&CHR(9)&LEFT(FORMAT(K2,@N-_14.2))&CHR(9)&LEFT(FORMAT(S2,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='73 Sociâlâs nodevas un izmaksas'&CHR(9)&LEFT(FORMAT(D3,@N-_14.2))&CHR(9)&LEFT(FORMAT(K3,@N-_14.2))&CHR(9)&LEFT(FORMAT(S3,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='74 PL nolietojums, citu ieg. nor.'&CHR(9)&LEFT(FORMAT(D4,@N-_14.2))&CHR(9)&LEFT(FORMAT(K4,@N-_14.2))&CHR(9)&LEFT(FORMAT(S4,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='75 Pârçjie saimn. darb. izdevumi'&CHR(9)&LEFT(FORMAT(D5,@N-_14.2))&CHR(9)&LEFT(FORMAT(K5,@N-_14.2))&CHR(9)&LEFT(FORMAT(S5,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='76 Preèu pârdoðanas izdevumi'&CHR(9)&LEFT(FORMAT(D6,@N-_14.2))&CHR(9)&LEFT(FORMAT(K6,@N-_14.2))&CHR(9)&LEFT(FORMAT(S6,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='77 Administrâcijas izdevumi'&CHR(9)&LEFT(FORMAT(D7,@N-_14.2))&CHR(9)&LEFT(FORMAT(K7,@N-_14.2))&CHR(9)&LEFT(FORMAT(S7,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='78 Pârsk.perioda iekï.iepr.p.izd.'&CHR(9)&LEFT(FORMAT(D8,@N-_14.2))&CHR(9)&LEFT(FORMAT(K8,@N-_14.2))&CHR(9)&LEFT(FORMAT(S8,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='79 Soc. infrastr. uztur. izd.'&CHR(9)&LEFT(FORMAT(D9,@N-_14.2))&CHR(9)&LEFT(FORMAT(K9,@N-_14.2))&CHR(9)&LEFT(FORMAT(S9,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'CITI IZDEVUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='82 Daþâdi izdevumi'&CHR(9)&LEFT(FORMAT(D10,@N-_14.2))&CHR(9)&LEFT(FORMAT(K10,@N-_14.2))&CHR(9)&LEFT(FORMAT(S10,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='84 Ârkârtas izdevumi'&CHR(9)&LEFT(FORMAT(D11,@N-_14.2))&CHR(9)&LEFT(FORMAT(K11,@N-_14.2))&CHR(9)&LEFT(FORMAT(S11,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'ZAUDÇJUMI, PEÏÒAS IZLIETOJUMS'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='87 Peïòas izlietojums'&CHR(9)&LEFT(FORMAT(D12,@N-_14.2))&CHR(9)&LEFT(FORMAT(K12,@N-_14.2))&CHR(9)&LEFT(FORMAT(S12,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='88 Nodokïi no peïòas u.c.'&CHR(9)&LEFT(FORMAT(D13,@N-_14.2))&CHR(9)&LEFT(FORMAT(K13,@N-_14.2))&CHR(9)&LEFT(FORMAT(S13,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KA,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'PASÎVS'&CHR(9)&'DEBETS'&CHR(9)&'KREDÎTS'&CHR(9)&'SALDO'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'IEÒÇMUMI NO SAIMNIECISKÂS DARBÎBAS'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='61 Ieòçmumi no pamatdarbîbas'&CHR(9)&LEFT(FORMAT(D14,@N-_14.2))&CHR(9)&LEFT(FORMAT(K14,@N-_14.2))&CHR(9)&LEFT(FORMAT(S14,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='62 Ieòçmumi no pârd.(cit.apliek.)'&CHR(9)&LEFT(FORMAT(D15,@N-_14.2))&CHR(9)&LEFT(FORMAT(K15,@N-_14.2))&CHR(9)&LEFT(FORMAT(S15,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='63 Komisijas, starpn. un citi cieòçmumi'&CHR(9)&LEFT(FORMAT(D16,@N-_14.2))&CHR(9)&LEFT(FORMAT(K16,@N-_14.2))&CHR(9)&LEFT(FORMAT(S16,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='64 Ieòçm. samazin. atlaides'&CHR(9)&LEFT(FORMAT(D17,@N-_14.2))&CHR(9)&LEFT(FORMAT(K17,@N-_14.2))&CHR(9)&LEFT(FORMAT(S17,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='65 Pârçjie uzòçmuma ieòçmumi'&CHR(9)&LEFT(FORMAT(D18,@N-_14.2))&CHR(9)&LEFT(FORMAT(K18,@N-_14.2))&CHR(9)&LEFT(FORMAT(S18,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='66 Krâjumu vçrtîbas izmaiòas'&CHR(9)&LEFT(FORMAT(D19,@N-_14.2))&CHR(9)&LEFT(FORMAT(K19,@N-_14.2))&CHR(9)&LEFT(FORMAT(S19,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='67 Citu p. ieò. (att. uz pârsk.)'&CHR(9)&LEFT(FORMAT(D20,@N-_14.2))&CHR(9)&LEFT(FORMAT(K20,@N-_14.2))&CHR(9)&LEFT(FORMAT(S20,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='68 Soc. infr. iest. un pas. ieò.'&CHR(9)&LEFT(FORMAT(D21,@N-_14.2))&CHR(9)&LEFT(FORMAT(K21,@N-_14.2))&CHR(9)&LEFT(FORMAT(S21,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'CITI IEÒÇMUMI'&CHR(9)&CHR(9)&CHR(9)
        ADD(OUTFILEANSI)
        OUTA:LINE='81 Daþâdi ieòçmumi'&CHR(9)&LEFT(FORMAT(D22,@N-_14.2))&CHR(9)&LEFT(FORMAT(K22,@N-_14.2))&CHR(9)&LEFT(FORMAT(S22,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='83 Ârkârtas ieòçmumi'&CHR(9)&LEFT(FORMAT(D23,@N-_14.2))&CHR(9)&LEFT(FORMAT(K23,@N-_14.2))&CHR(9)&LEFT(FORMAT(S23,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='86 Peïòa vai zaudçjumi'&CHR(9)&LEFT(FORMAT(D24,@N-_14.2))&CHR(9)&LEFT(FORMAT(K24,@N-_14.2))&CHR(9)&LEFT(FORMAT(S24,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(KP,@N-_14.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Finansu rezultâts'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(FR,@N-_14.2))
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
IZZFILTPVN PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
pvnsak               STRING(3)
pvnsub               STRING(2)
realsak              STRING(3)
realsub              STRING(2)
window               WINDOW('Filtrs atskaitçm'),AT(,,265,156),GRAY
                       STRING('Norâdiet PVN kontu :'),AT(54,13,73,10),USE(?StringNoradiet),HIDE,RIGHT
                       STRING(@s3),AT(126,13,,10),USE(pvnsak),HIDE,CENTER
                       ENTRY(@s2),AT(142,12,12,10),USE(pvnsub),HIDE
                       STRING('Norâdiet kontu, kur realizâcija bijusi bez PVN :'),AT(14,23),USE(?StringNoradiet6),HIDE
                       STRING(@s3),AT(166,23),USE(realsak),HIDE
                       ENTRY(@s2),AT(180,23,12,10),USE(realsub),HIDE
                       STRING('Norâdiet mazâko summu, kura jâiekïauj atskaitç :'),AT(14,49,,10),USE(?StringMINSUMMA),HIDE
                       ENTRY(@n-8.2),AT(184,46,34,10),USE(MINMAXSUMMA),HIDE
                       STRING(@s3),AT(221,49,16,10),USE(Val_uzsk),HIDE
                       STRING('Norâdiet lielâko summu (0-nav) :'),AT(14,58,,10),USE(?StringMINSUMMA:2),HIDE
                       ENTRY(@n-11.2),AT(184,57,34,10),USE(bilance),HIDE
                       OPTION('Izdrukas &Formâts'),AT(12,118,107,24),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(19,128,27,10),USE(?F:DBF:WMF),VALUE('W')
                         RADIO('Word'),AT(52,128,29,10),USE(?F:DBF:A),VALUE('A')
                         RADIO('Excel'),AT(83,128),USE(?F:DBF:Excel),VALUE('E')
                       END
                       BUTTON('Drukas parametri'),AT(166,118,88,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('Uzbûvçt XML'),AT(2,69,237,14),USE(?ButtonXML),HIDE
                       BUTTON('II,III daïu sâkt ar jaunu lapu'),AT(3,85,237,14),USE(?ButtonDTK),HIDE
                       IMAGE('CHECK3.ICO'),AT(241,83,14,17),USE(?ImageDTK),HIDE
                       BUTTON('Precizçtâ'),AT(151,102,89,14),USE(?ButtonIDP),HIDE
                       IMAGE('CHECK3.ICO'),AT(241,100,14,17),USE(?ImageIDP),HIDE
                       IMAGE('CHECK3.ICO'),AT(241,66,14,17),USE(?ImageXML),HIDE
                       BUTTON('&OK'),AT(166,134,49,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(218,134,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ~SYS:K_PVN THEN SYS:K_PVN='57210'.
  pvnsak     = sys:k_pvn[1:3]
  pvnsub     = sys:k_pvn[4:5]
  realsak    = '611'
  realsub    = '01'
  minMAXsumma= 0
  BILANCE    = 0
  F:XML      = ''
  IF ~(OPCIJA[3]>'1') THEN F:DBF='W'.
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 7
     IF ~INSTRING(OPCIJA[I#],' 0')
        EXECUTE I#
           BEGIN
              UNHIDE(?StringMINSUMMA)
              !UNHIDE(?StringLs)
              UNHIDE(?val_uzsk)
              UNHIDE(?MINMAXSUMMA)
              !Elya 10.02.2013
              IF OPCIJA[I#]='1' AND GADS > 2012 !PVN DEKLARÂCIJA
                 !16.02.2014 MINMAXSUMMA=1000  !no 01.01.2010.
                 MINMAXSUMMA=1430  !no !16.02.2014 .
                 UNHIDE(?StringMINSUMMA:2)
                 UNHIDE(?bilance)
  
!              IF OPCIJA[I#]='1'     !PVN DEKLARÂCIJA
              ELSIF OPCIJA[I#]='1'     !PVN DEKLARÂCIJA
                 ?StringMINSUMMA{PROP:TEXT}='Rezultâts darîjumiem par kokmateriâliem :'
              ELSIF OPCIJA[I#]='2'  !PVN PIELIKUMS
  !               MINMAXSUMMA=100
  !               MINMAXSUMMA=500  !no 19.09.07
                 !16.02.2014 MINMAXSUMMA=1000  !no 01.01.2010.
                 MINMAXSUMMA=1430  !no 16.02.2014
                 UNHIDE(?StringMINSUMMA:2)
                 UNHIDE(?bilance)
              .
           .
           BEGIN
              CASE OPCIJA[I#]
              OF '1'
                 UNHIDE(?StringNoradiet)
                 UNHIDE(?pvnsak)
                 UNHIDE(?pvnsub)
              OF '2'              !PVN DEKLARÂCIJA UN PVN1
                 UNHIDE(?StringNoradiet)
                 UNHIDE(?pvnsak)
                 UNHIDE(?pvnsub)
                 UNHIDE(?StringNoradiet6)
                 UNHIDE(?realsak)
                 UNHIDE(?realsub)
              .
           .
           BEGIN                         !  3
              CASE OPCIJA[I#]
              OF '1'              !WMF/WORD
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:Excel)
                 IF ~INSTRING(F:DBF,'WA') THEN F:DBF='W'.
              OF '2'              !WMF/EXCEL
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:A)
                 IF ~INSTRING(F:DBF,'WE') THEN F:DBF='W'.
              OF '3'              !WMF/WORD/EXCEL
                 UNHIDE(?F:DBF)
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              .
           .
           BEGIN                         !  4 XML
              UNHIDE(?BUTTONXML)
              !Elya 10.02.2013
              IF GADS > 2012 AND (OPCIJA[I#]='1' OR OPCIJA[I#]='4' OR OPCIJA[I#]='3')
                 HIDE(?BUTTONXML)
              .

              IF OPCIJA[I#]='1'          !  PVN PIELIKUMI
                 IF GADS>2009
                    ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN_PI.XML,PVN_PII.XML,PVN_PIII.XML'
                 ELSE
                    ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN_PI.DUF,PVN_PII.DUF'
                 .
              ELSIF OPCIJA[I#]='2'       !  PVN MÇNEÐA DEKLARÂCIJA
                 IF GADS>2008
                    ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN_D.XML'
                 ELSE
                    ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN_D.DUF'
                 .
              ELSIF OPCIJA[I#]='3'       !  PVN PIELIKUMS KOKMATERIÂLIEM
                 ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN_K_DAR_2007.DUF'
              ELSIF OPCIJA[I#]='4'       !  PVN2 PIELIKUMS
                 ?BUTTONXML{PROP:TEXT}='Uzbûvçt '&USERFOLDER&'\PVN2.XML'
              .
           .
           BEGIN                         !  5 DRUKÂT PIELIKUMU UZ ATSEVIÐÍÂM LAPÂM
              UNHIDE(?BUTTONDTK)
              F:DTK=''
           .
           BEGIN                         !  6 PRECIZÇTÂ PVN DEKLARÂCIJA
              UNHIDE(?BUTTONIDP)
              F:IDP=''
           .
           BEGIN                         !  7 KOKMATERIÂLU PVN
              ?StringNoradiet{PROP:TEXT}='Norâdiet kokmateriâlu PVN kontu :'
              PVNSUB='11'
           .
        .
     .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?StringNoradiet)
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
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?ButtonXML
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:XML
           F:XML = ''
           HIDE(?IMAGEXML)
        ELSE
           F:XML = '1'
           UNHIDE(?IMAGeXML)
        END
        DISPLAY
      END
    OF ?ButtonDTK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK = ''
           HIDE(?IMAGEDTK)
        ELSE
           F:DTK = '1'
           UNHIDE(?IMAGeDTK)
        END
        DISPLAY
      END
    OF ?ButtonIDP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:IDP
           F:IDP = ''
           HIDE(?IMAGEIDP)
        ELSE
           F:IDP = '1'
           UNHIDE(?IMAGeIDP)
        END
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        localresponse = requestcompleted
        IF OPCIJA[2] <> '0'    !PIEPASÎTI PVN KONTI
           kkk = pvnsak&pvnsub
           kkk1=realsak&realsub
        .
        break
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        localresponse = requestcancelled
        break
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
  END
  IF WindowOpened
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
