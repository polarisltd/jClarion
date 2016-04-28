                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetKon_k             FUNCTION (BKK,REQ,RET,<NORADE>) ! Declare Procedure
NULLES     STRING('00000')
  CODE                                            ! Begin processed code
 !
 !  BKK - PIEPRASÎTAIS KONTS
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD, JA NAV
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU
 !        3 IZSAUC KÏÛDU JA NAV IEKS GGK
 !  RET - 1 ATGRIEÞ BKK
 !        2 ATGRIEÞ KON:NOSAUKUMS
 !        3 ATGRIEÞ KONTA ATLIKUMU
 !        4 ATGRIEÞ KON:NOSAUKUMSA
 !        5 ATGRIEÞ KON:VAL
 !        6 ATGRIEÞ 1 JA IR DEFINÇTI RINDU KODI PVND
 !        7 ATGRIEÞ KON:NOSAUKUMS KONTU SHÇMAI
 !        8 ATGRIEÞ KON:VAL VAI VAL_LV VAI VAL_NOS
 !
 IF ~INRANGE(RET,1,8)
     STOP('GETKON_K:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN('')
 .
 IF BKK='00000' AND ~REQ   !SPEC
    RETURN('')
 ELSIF ~BKK AND REQ=3      !JABUT,BET NAV IEKS GGK
    KLUDA(87,'Konts U_NR: '&CLIP(GGK:U_NR)&' Datums: '&FORMAT(ggk:datums,@D6))
    RETURN('')
 ELSIF ~BKK AND REQ=1      !JABÛT PAREIZAM, VAR ARÎ NEBÛT
    RETURN('')
 ELSIF BKK OR REQ OR RET=7
     IF LEN(CLIP(BKK))<5 AND ~(RET=7)    !JÂPIELIEK TRÛKSTOÐÂS NULLES, JA LIETOTÂJS IR BIJIS PAR SLINKU IEVADÎT
       BKK=CLIP(BKK)&NULLES[1:5-LEN(CLIP(BKK))]
    .
    IF KON_K::USED=0
       CheckOpen(KON_K,1)
    .
    KON_K::Used += 1
    CLEAR(KON:RECORD)
    KON:BKK=BKK
    GET(KON_K,KON:BKK_KEY)
    IF ERROR()
       IF REQ = 2
          KLUDA(15,BKK&' '&NORADE)
          BKK=''
       ELSIF REQ=1
          KKK=BKK
          globalrequest=Selectrecord
          BROWSEKON_K
          IF GLOBALRESPONSE=REQUESTCOMPLETED
             BKK=KON:BKK
          ELSE
             CLEAR(KON:RECORD)
             KON:BKK='99999'
             GET(KON_K,KON:BKK_KEY)
             IF ERROR()
                KON:NOSAUKUMS='Nepareizi kontçjumi'
                ADD(KON_K)
             .
             BKK=KON:BKK
          .
       ELSE
          BKK=''
       .
    .
    KON_K::Used -= 1
    IF KON_K::Used = 0 THEN CLOSE(KON_K).
 ELSE
    RETURN('')
 .
 EXECUTE RET
    RETURN(BKK)                  !1
    RETURN(KON:NOSAUKUMS)        !2
    RETURN(KON:ATLIKUMS[LOC_NR]) !3 MAX 15
    RETURN(KON:NOSAUKUMSA)       !4
    RETURN(KON:VAL)              !5
    BEGIN                        !6 IR RINDU KODI PVND
       IF KON:PVND[1] OR KON:PVND[2]
          RETURN(1)
       ELSE
          RETURN('')
       .
    .
    RETURN(KON:NOSAUKUMS)        !7
    BEGIN                        !8
       IF KON:VAL AND ~(KON:VAL='Ls' OR KON:VAL='LVL')
          RETURN(KON:VAL)
       ELSIF ~KON:VAL OR KON:VAL='Ls' OR KON:VAL='LVL'
          !Elya 04/12/2013 RETURN (VAL_LV)
          RETURN(val_uzsk)
       ELSE
          RETURN(VAL_NOS)
       .
    .
 .
B_IzdOrd             PROCEDURE (OPC)              ! Declare Procedure
RPT_GADS             DECIMAL(4)
DATUMS               DECIMAL(2)
RPT_MENESIS          STRING(11)
SUMMA_TEXT           STRING(60)
SUMVAR1              STRING(100)
SUMVAR2              STRING(100)
NOKA                 STRING(60)
CG                   STRING(10)

pvn_text             STRING(12)
LB_TEXT              STRING(60)
SUMMA_BEZ_PVN        DECIMAL(12,2)
rpt_kor_SUMMA        DECIMAL(11,2)
rpt_kor_konts        STRING(5)
rpt_kor_VALUTA       STRING(3)
PVN_SUMMA            DECIMAL(12,2)
PVN_PASE             STRING(37)
PAR_ADRESE           STRING(60)
ORDERI               BYTE

report REPORT,AT(198,104,8000,11500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(,,8000,1656),USE(?unnamed)
         LINE,AT(5938,1354,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7448,1354,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(4271,1354,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1771,1354,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2969,1354,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         STRING(@s45),AT(1281,167,4625,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodokïu maks.  Reì. Nr  :'),AT(1094,469),USE(?String2),LEFT
         STRING(@s11),AT(2708,458,885,208),USE(GL:REG_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN maks.  Reì. Nr  :'),AT(3698,469),USE(?String2:2),LEFT
         STRING(@s13),AT(5104,458,1146,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KASES IZDEVUMU ORDERIS Nr'),AT(1875,729,2396,260),USE(?String6),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(4323,729,1302,208),USE(GG:DOK_SENR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(2271,1042,385,208),USE(rpt_gads),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('.  gada'),AT(2656,1042,469,208),USE(?String2:3),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('"'),AT(3177,1042,52,208),USE(?String10),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3229,1042,219,208),USE(datums),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('."'),AT(3490,1042,94,208),USE(?String10:2),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(3646,1042),USE(RPT_menesis),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,1354,6823,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Koresp. konts'),AT(677,1406,1094,208),USE(?String2:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Analit. uzsk. k.'),AT(3021,1406,1250,208),USE(?String2:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(1823,1406,1146,208),USE(?String2:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(4323,1406,1615,208),USE(?String2:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods mçría nol.'),AT(5990,1406,1458,208),USE(?String2:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,1615,6823,0),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(625,1354,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177)
         LINE,AT(2969,-10,0,197),USE(?Line9:3),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,197),USE(?Line9:4),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,197),USE(?Line9:5),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,197),USE(?Line9:6),COLOR(COLOR:Black)
         STRING(@s5),AT(3438,10,,156),USE(GGK:BKK),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N14.2),AT(4427,10,,156),USE(ggk:summav),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(5625,10,,156),USE(ggk:val),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(1771,-10,0,197),USE(?Line9:2),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line9),COLOR(COLOR:Black)
       END
detail2 DETAIL,AT(,,,146)
         LINE,AT(7448,-10,0,197),USE(?Line9:12),COLOR(COLOR:Black)
         STRING(@s5),AT(1042,10,,156),USE(RPT_KOR_KONTS),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_10.2),AT(1813,10,,156),USE(RPT_KOR_SUMMA),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(2656,0),USE(RPT_KOR_VALUTA)
         LINE,AT(5938,-10,0,197),USE(?Line9:11),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,197),USE(?Line9:10),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,197),USE(?Line9:9),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,197),USE(?Line9:8),COLOR(COLOR:Black)
         LINE,AT(625,-10,0,197),USE(?Line9:7),COLOR(COLOR:Black)
       END
detail3 DETAIL,AT(,,8021,1552),USE(?unnamed:2)
         STRING(@S37),AT(1823,521,2813,156),USE(PVN_PASE),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S45),AT(1823,833,4896,156),USE(gg:saturs),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pielikumâ'),AT(677,1000,1010,156),USE(?String2:12),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa vârdiem'),AT(677,1354,1010,156),USE(?String2:15),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S100),AT(1823,1323,5990,156),USE(sumvar1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(':'),AT(1719,1323,104,156),USE(?String2:24),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(':'),AT(1719,1146,104,156),USE(?String2:22),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(1823,1146,4896,156),USE(gg:saturs3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(':'),AT(1719,990,104,156),USE(?String2:23),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S45),AT(1823,990,4896,156),USE(gg:saturs2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(':'),AT(1719,833,104,156),USE(?String2:21),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(':'),AT(1719,365,104,208),USE(?String2:17),CENTER,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S55),AT(1823,365,4167,156),USE(NOKA),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S60),AT(1823,677,4490,156),USE(PAR_ADRESE),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(677,833,1010,156),USE(?String2:14),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegt'),AT(677,365,1010,156),USE(?String2:13),LEFT,FONT('Arial Baltic',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(677,156,4688,156),USE(SUMMA_TEXT),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,-10,0,62),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,62),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,62),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(625,52,6823,0),USE(?Line27),COLOR(COLOR:Black)
       END
detail4 DETAIL,AT(,,,177)
         STRING(@S100),AT(1823,10,5990,156),USE(sumvar2),LEFT
       END
detailLB DETAIL,AT(,,,177)
         STRING(@s80),AT(1823,10,3438,156),USE(LB_TEXT),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detail5 DETAIL,AT(,,,1604),USE(?unnamed:3)
         STRING(@s25),AT(677,63),USE(sys:amats1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòçmçja paraksts :'),AT(4010,1000),USE(?String2:9),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5677,260,1792,0),USE(?Line30:2),COLOR(COLOR:Black)
         LINE,AT(1875,1552,1802,0),USE(?Line30:3),COLOR(COLOR:Black)
         LINE,AT(2240,260,1802,0),USE(?Line30),COLOR(COLOR:Black)
         STRING('" ____ " _{15}'),AT(2385,990,1615,208),USE(?String50),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(5281,1104,1802,0),USE(?Line30:4),COLOR(COLOR:Black)
         STRING(@n4),AT(1583,990,385,208),USE(rpt_gads,,?RPT:GADS:1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('.gada'),AT(2000,990),USE(?String52)
         STRING(@s25),AT(2208,313),USE(sys:paraksts1),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(4479,63),USE(sys:amats2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(5646,313),USE(sys:paraksts2),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('Izsniedza kasieris  :'),AT(677,1354),USE(?String2:10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(3750,1354),USE(sys:paraksts3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Saòçmu :'),AT(677,521,760,198),USE(?StringSANEMU),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S100),AT(1823,521,5990,156),USE(sumvar1,,sumvar1:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@S100),AT(1823,698,5990,156),USE(sumvar2,,?sumvar2:2),LEFT
       END
PAGEBREAK DETAIL,PAGEAFTER(-1),AT(,,,0),USE(?PAGEBREAK)
       END
SPACE  DETAIL,AT(,,,552),USE(?PAGEBREAK:1)
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

  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(BANKAS_K,1)

  IF OPC=1 !DRUKÂT N0-LÎDZ
     CHECKOPEN(GGK,1)
     CLEAR(GGK:RECORD)
     GGK:DATUMS=S_DAT
     GGK:BKK=KKK
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
  .

  CG='K113001'

  OPEN(ProgressWindow)
  open(report)
  report{Prop:Preview} = PrintPreviewImage
  LOOP
    IF OPC=1 !DRUKÂT N0-LÎDZ
       NEXT(GGK)
       if ERROR() OR cyclebkk(ggk:bkk,kkk)=2 then break.
       if ggk:U_NR=1 then cycle.
       if ggk:datums>b_dat THEN cycle.
       if cyclebkk(ggk:bkk,kkk) then cycle.
       IF CYCLEGGK(CG) THEN CYCLE.
       IF ~GETGG(GGK:U_NR)
          KLUDA(0,'Nav atrasts GG raksts N '&ggk:u_nr)
          CYCLE
       .
    .
    datums = DAY(GG:DOKDAT)
    rpt_MENESIS= MENVAR(GG:DOKDAT,2,2)
    rpt_GADS   = YEAR(GG:DOKDAT)
    NOKA=GETPAR_K(GG:PAR_NR,0,2)
    IF PAR:TIPS='F'
       NOKA=CLIP(NOKA)&' PK '&PAR:NMR_KODS
       PVN_PASE=PAR:pase
    ELSE
       PVN_PASE=GETPAR_K(GG:PAR_NR,0,9)
    .
    PAR_ADRESE=GETPAR_K(GG:PAR_NR,0,24)
    teksts=SUMVAR(ggk:summav,ggk:val,0)
    FORMAT_TEKSTS(140,'Arial',10,'')
    SUMVAR1 =F_TEKSTS[1]
    SUMVAR2 =F_TEKSTS[2]
    pvn_SUMMA=0
    PRINT(RPT:DETAIL)
    PRINT(RPT:DETAIL1)
    IF OPC=1 !KO STREAMs
       BUILDKORMAS(2,0,1,0,1)
    ELSE
       BUILDKORMAS(3,0,1,0,1)
    .
    LOOP I#=1 TO 20
       RPT_KOR_KONTS=KOR_KONTS[I#]
       IF ~RPT_KOR_KONTS THEN BREAK.
       RPT_KOR_SUMMA=KOR_SUMMA[I#]
       RPT_KOR_VALUTA=KOR_VAL[I#]
       IF RPT_KOR_KONTS[1:4]='5721' THEN PVN_SUMMA=RPT_KOR_SUMMA. !ÒEMAM NO KONTÇJUMA
       PRINT(RPT:DETAIL2)
    .
    IF ~PVN_SUMMA
!    STOP(GGK:U_NR&' '&GGK:SUMMAV)
       pvn_SUMMA=GGK:SUMMAV-GGK:SUMMAV/(1+GGK:PVN_PROC/100)
    .
    pvn_text=CLIP(LEFT(FORMAT(pvn_summa,@N12.2)))&' '&GGK:VAL
  !  summa_bez_pvn=GGK:SUMMAV/(1+GGK:PVN_PROC/100)
    summa_bez_pvn=GGK:SUMMAV-PVN_SUMMA
    IF BAND(ggk:BAITS,00000010b)
       SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(Summa_bez_PVN,@N_12.2)))&' ar PVN neapliekams'
    ELSE
       SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(Summa_bez_PVN,@N_12.2)))&'  PVN '&ggk:pvn_proc&'%= '&PVN_TEXT
    .
    PRINT(RPT:DETAIL3)
    IF SUMVAR2
       PRINT(RPT:DETAIL4)
    .
    !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
    IF ~(GGK:VAL=val_uzsk)
       LB_TEXT='Pçc LB kursa '&CLIP(BANKURS(ggk:VAL,ggk:DATUMS,1))&' tas sastâda '&val_uzsk&' '&ggk:summa
       PRINT(RPT:DETAILLB)
    .
    PRINT(RPT:DETAIL5)
    IF OPC=1 !DRUKÂT N0-LÎDZ
       ORDERI+=1
       IF ORDERI=1 AND F:NOA !KATRU UZ SAVAS LAPAS
          ORDERI=0
          PRINT(RPT:PAGEBREAK)
       ELSIF ORDERI=2
          ORDERI=0
          PRINT(RPT:PAGEBREAK)
       ELSE
          PRINT(RPT:SPACE)
       .
    ELSE
       BREAK
    .
  .
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
! POST(EVENT:CLOSEWINDOW)    !KAM ðitais bija domâts, nezinu
!  GG_POSITION=POSITION(GG)  !JA PIEPRASA PÂRBÛVÇT BROWSI,ÐITO NEVAJAG
!  RESET(GG,GG_POSITION)
!  NEXT(GG)
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  popbind
B_Ienord             PROCEDURE (STREAM)           ! Declare Procedure
NOKA                 STRING(45)
REG_NR               STRING(37)
RPT_GADS             DECIMAL(4)
DATUMS               DECIMAL(2)
RPT_MENESIS          STRING(10)
PAR_KODS             STRING(12)
rpt_NOKA             STRING(45)
PVN_PASE             STRING(37)
PVN_text             STRING(12)
SUMMA_TEXT           STRING(60)
LB_TEXT              STRING(60)
CG                   STRING(10)

PVN_SUMMA            DECIMAL(11,2),DIM(8)
K_SUMMA              DECIMAL(11,2),DIM(8)

rpt_kor_SUMMA        DECIMAL(11,2)
rpt_kor_konts        STRING(5)
rpt_kor_VAL          STRING(3)

PAM10                STRING(80)
PAM20                STRING(80)
PAM30                STRING(80)
PAM300               STRING(80)
PAM11                STRING(80)
PAM21                STRING(80)
SUMVAR1              STRING(60)
SUMVAR2              STRING(60)
SUMVAR3              STRING(60)
ORDERI               BYTE
CHECKSUMMA           DECIMAL(11,2)
AMATS_PARAKSTS2      STRING(50)
LAST_EXTRA_LINES     BYTE
EXTRA_LINES          BYTE
FORCED_PAGEBREAKS    BYTE
SAV_PVN_PROC         STRING(2)
ZATSK                STRING(7)

report REPORT,AT(1000,200,8000,11198),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(,,8000,2438),USE(?unnamed:2)
         STRING(@s45),AT(21,198,3604,260),USE(CLIENT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(3729,208,3677,260),USE(CLIENT,,?CLIENT:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(698,458,885,208),USE(gl:reg_nr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN:'),AT(1635,458),USE(?String3:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(1979,469,1146,208),USE(GL:VID_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(4396,458,885,208),USE(gl:reg_nr,,?gl:reg_nr:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN:'),AT(5333,458),USE(?String3:4),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(5667,458,1146,208),USE(GL:VID_NR,,?GL:VID_NR:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KASES IEÒÇMUMU ORDERIS Nr'),AT(198,833),USE(?String11),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(2656,833,938,229),USE(GG:DOK_SENR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('KVÎTS'),AT(4844,833,677,260),USE(?String11:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(906,1094),USE(RPT_GADS),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(1302,1094,469,208),USE(?String67:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(1771,1094,219,208),USE(DATUMS),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Kases ieòçmumu orderim   Nr'),AT(3906,1146),USE(?String11:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(6146,1146,1250,260),USE(GG:DOK_SENR,,?GG:DOK_SENR:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(2031,1094,42,208),USE(?String80),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2083,1094,792,208),USE(RPT_MENESIS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1771,3438,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('Kor. konts'),AT(135,1906,677,208),USE(?String3:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums :'),AT(4010,1958,,156),USE(?String3:6),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(4875,1969,2552,156),USE(PAM10,,?PAM10:2),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3542,1771,0,677),USE(?Line7:5),COLOR(COLOR:Black)
         LINE,AT(2813,1771,0,677),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(1615,1771,0,677),USE(?Line7:3),COLOR(COLOR:Black)
         LINE,AT(833,1771,0,677),USE(?Line7:2),COLOR(COLOR:Black)
         LINE,AT(104,1771,0,677),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(104,2240,3438,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s80),AT(4021,2271,3438,156),USE(PAM300),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kods'),AT(2844,1823,677,156),USE(?String3:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mçría nol.'),AT(2844,2031,677,156),USE(?String3:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(1646,1906,1146,208),USE(?String3:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzsk. konts'),AT(865,2031,729,156),USE(?String3:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Analît. '),AT(885,1823,729,156),USE(?String3:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(2552,2292,260,156),USE(GGK:VAL),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s7),AT(177,2292,615,156),USE(ZATSK),TRN,CENTER,FONT(,9,,,CHARSET:ANSI)
         STRING(@s80),AT(4010,2115,3438,156),USE(PAM20,,?PAM20:2),TRN,LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_12.2),AT(1667,2292,833,156),USE(GGK:SUMMAV,,?GGK:SUMMAV:3),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s5),AT(1042,2292,417,156),USE(GGK:BKK),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3698,146,0,2302),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(3646,146,0,2302),USE(?Line3),COLOR(COLOR:Black)
       END
detail1S DETAIL,AT(,,,146),USE(?unnamed:5)
         LINE,AT(104,-10,0,197),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,197),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,197),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,197),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,197),USE(?Line16),COLOR(COLOR:Black)
         STRING(@s5),AT(302,10,417,156),USE(rpt_kor_konts),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_12.2),AT(1667,0,833,156),USE(rpt_kor_summa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(2542,0,260,156),USE(rpt_kor_VAL),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3698,-10,0,197),USE(?Line16:3),COLOR(COLOR:Black)
         LINE,AT(3646,-10,0,197),USE(?Line16:2),COLOR(COLOR:Black)
       END
detail2S DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,62),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,62),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,62),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,62),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,62),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(3646,-10,0,197),USE(?Line16:4),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,197),USE(?Line16:5),COLOR(COLOR:Black)
         LINE,AT(104,52,3438,0),USE(?Line24),COLOR(COLOR:Black)
         STRING('Summa kopâ  :'),AT(4010,10,,156),USE(?String35),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_12.2),AT(5052,0,1250,156),USE(GGK:SUMMAV,,?GGK:SUMMAV:2),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
       END
detail1 DETAIL,AT(,,,177)
         LINE,AT(3646,-10,0,197),USE(?Line16:6),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,197),USE(?Line16:7),COLOR(COLOR:Black)
         STRING(@s80),AT(156,10,3438,156),USE(SUMMA_TEXT),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(4010,10,3281,156),USE(SUMMA_TEXT,,?SUMMA_TEXT:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detailLB DETAIL,AT(,,,177)
         LINE,AT(3646,-10,0,197),USE(?Line146:6),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,197),USE(?Line136:7),COLOR(COLOR:Black)
         STRING(@s80),AT(156,10,3438,156),USE(LB_TEXT),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(4010,10,3281,156),USE(LB_TEXT,,?LB_TEXT:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detail2 DETAIL,AT(,,,1656),USE(?unnamed)
         STRING(@s40),AT(1052,698,2552,156),USE(PAM10),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s80),AT(156,854,3438,156),USE(PAM20),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s80),AT(156,1010,3438,156),USE(PAM30),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N4),AT(4688,1396,385,208),USE(RPT_GADS,,?RPT_GADS:2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(5104,1396,469,208),USE(?String67),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(5573,1396,219,208),USE(DATUMS,,?DATUMS:2),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(5833,1396),USE(?String69),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(5885,1396,792,208),USE(RPT_MENESIS,,?RPT_MENESIS:2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa vârdiem  :'),AT(156,1198,,156),USE(?String59),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(4010,1000,2760,156),USE(SUMVAR2,,?SUMVAR2:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(156,1354,3438,156),USE(SUMVAR1),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3698,-10,0,1676),USE(?Line29:2),COLOR(COLOR:Black)
         STRING(@s60),AT(156,1510,3438,156),USE(SUMVAR2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Z. v.'),AT(4010,1406),USE(?String72)
         STRING(@s60),AT(4010,1156,2760,156),USE(SUMVAR3,,?SUMVAR3:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieòemts no  :'),AT(156,52,,156),USE(?String49),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(1042,52,,156),USE(PAR_KODS),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieòemts  no  :'),AT(4010,63,,156),USE(?String3:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(4927,63,990,156),USE(PAR_kods,,?PAR_kods:2),LEFT,FONT(,9,,)
         STRING(@s45),AT(156,208,3448,156),USE(NOKA,,?NOKA),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(4010,219,3073,156),USE(rpt_NOKA),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Summa vârdiem  :'),AT(4010,688,,156),USE(?String59:2),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(156,365,3490,156),USE(PVN_PASE,,?PVN_PASE:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s37),AT(4010,375,2813,156),USE(PVN_PASE),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(4010,844,2760,156),USE(SUMVAR1,,?SUMVAR1:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(3646,-10,0,1676),USE(?Line29),COLOR(COLOR:Black)
         STRING(@s60),AT(156,521,3438,156),USE(PAR:ADRESE),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pamatojums  :'),AT(156,698,,156),USE(?String49:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
detail3 DETAIL,AT(,,,177)
         LINE,AT(3698,-10,0,197),USE(?Line31:2),COLOR(COLOR:Black)
         STRING(@s60),AT(156,10,3438,156),USE(SUMVAR3),LEFT,FONT(,9,,)
         LINE,AT(3646,-10,0,197),USE(?Line31),COLOR(COLOR:Black)
       END
detail4 DETAIL,AT(,,,458),USE(?unnamed:4)
         LINE,AT(3646,-10,0,478),USE(?Line31:3),COLOR(COLOR:Black)
         LINE,AT(3698,-10,0,478),USE(?Line31:4),COLOR(COLOR:Black)
         STRING(@s50),AT(94,52,3542,208),USE(AMATS_PARAKSTS2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s50),AT(3802,52,3698,208),USE(AMATS_PARAKSTS2,,?AMATS_PARAKSTS2:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Saòçma kasieris'),AT(156,260,1510,208),USE(?String73:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kasieris'),AT(4010,260,729,208),USE(?String73:4),LEFT
         STRING(@s25),AT(4552,271),USE(SYS:PARAKSTS3),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(1188,271),USE(SYS:PARAKSTS3,,?SYS:PARAKSTS3:2),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
       END
detail_ DETAIL,AT(,10,8000,2438),USE(?unnamed:22)
         STRING(@s45),AT(21,198,3604,260),USE(CLIENT,,?CLIENT:12),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(698,458,885,208),USE(gl:reg_nr,,?gl:reg_nr:4),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN:'),AT(1635,458),USE(?String3:286),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(1979,469,1146,208),USE(GL:VID_NR,,?GL:VID_NR:4),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('KASES IEÒÇMUMU ORDERIS Nr'),AT(260,833),USE(?String111),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(2760,833,833,260),USE(GG:DOK_SENR,,?GG:DOK_SENR:4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(906,1094),USE(RPT_GADS,,?RPT_GADS:12),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('. gada'),AT(1302,1094,469,208),USE(?String67:286),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(1771,1094,219,208),USE(DATUMS,,?DATUMS:12),RIGHT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(2031,1094,42,208),USE(?String808),FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2083,1094,792,208),USE(RPT_MENESIS,,?RPT_MENESIS:12),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1771,3438,0),USE(?Line586),COLOR(COLOR:Black)
         STRING('Kor. konts'),AT(135,1906,677,208),USE(?String3:138),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3542,1771,0,677),USE(?Line7:51),COLOR(COLOR:Black)
         LINE,AT(2813,1771,0,677),USE(?Line7:41),COLOR(COLOR:Black)
         LINE,AT(1615,1771,0,677),USE(?Line7:31),COLOR(COLOR:Black)
         LINE,AT(833,1771,0,677),USE(?Line7:21),COLOR(COLOR:Black)
         LINE,AT(104,1771,0,677),USE(?Line71),COLOR(COLOR:Black)
         LINE,AT(104,2240,3438,0),USE(?Line5:286),COLOR(COLOR:Black)
         STRING(@s7),AT(198,2281,604,156),USE(ZATSK,,?ZATSK:2),TRN,CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('Kods'),AT(2844,1823,677,208),USE(?String3:734),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('mçría nol.'),AT(2844,2010,677,208),USE(?String3:171),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(1646,1906,1146,208),USE(?String3:109),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzsk. konts'),AT(865,2010,729,208),USE(?String3:909),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Analît. '),AT(865,1823,729,208),USE(?String3:808),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(2552,2292,260,156),USE(GGK:VAL,,?GGK:VAL:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_12.2),AT(1667,2292,833,156),USE(GGK:SUMMAV,,?GGK:SUMMAV:9),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s5),AT(1042,2292,417,156),USE(GGK:BKK,,?GGK:BKK:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detail1S_ DETAIL,AT(,,,146)
         LINE,AT(104,-10,0,197),USE(?Line12:12),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,197),USE(?Line13:13),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,197),USE(?Line14:14),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,197),USE(?Line15:15),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,197),USE(?Line16:16),COLOR(COLOR:Black)
         STRING(@s5),AT(260,10,417,156),USE(rpt_kor_konts,,?rpt_kor_konts:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N_12.2),AT(1667,0,833,156),USE(rpt_kor_summa,,?rpt_kor_summa:2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(2542,0,260,156),USE(rpt_kor_VAL,,?rpt_kor_VAL:2),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
       END
detail2S_ DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,62),USE(?Line19:29),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,62),USE(?Line20:20),COLOR(COLOR:Black)
         LINE,AT(1615,-10,0,62),USE(?Line21:21),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,62),USE(?Line22:22),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,62),USE(?Line23:23),COLOR(COLOR:Black)
         LINE,AT(104,52,3438,0),USE(?Line24:24),COLOR(COLOR:Black)
       END
detail1_ DETAIL,AT(,,,177)
         STRING(@s80),AT(156,10,3438,156),USE(SUMMA_TEXT,,?SUMMA_TEXT:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detailLB_ DETAIL,AT(,,,177)
         STRING(@s80),AT(156,10,3438,156),USE(LB_TEXT,,?LB_TEXT:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
detail2_ DETAIL,AT(,,,1656),USE(?unnamed:3)
         STRING(@s40),AT(1052,698,2552,156),USE(PAM10,,?PAM10:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s80),AT(156,854,3438,156),USE(PAM20,,?PAM20:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s80),AT(156,1010,3438,156),USE(PAM30,,?PAM30:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Summa vârdiem  :'),AT(156,1198,,156),USE(?String59:59),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(156,1354,3438,156),USE(SUMVAR1,,?SUMVAR1:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(156,1510,3438,156),USE(SUMVAR2,,?SUMVAR2:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieòemts no  :'),AT(156,52,,156),USE(?String49:49),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(1042,52,,156),USE(PAR_KODS,,?PAR_KODS:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(156,208,3448,156),USE(NOKA,,?NOKA:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(156,365,3490,156),USE(PVN_PASE,,?PVN_PASE:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s60),AT(156,521,3438,156),USE(PAR:ADRESE,,?PAR:ADRESE:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pamatojums  :'),AT(156,698,,156),USE(?String49:249),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
       END
detail3_ DETAIL,AT(,,,177)
         STRING(@s60),AT(156,10,3438,156),USE(SUMVAR3,,?SUMVAR3:3),LEFT,FONT(,9,,)
       END
detail4_ DETAIL,AT(,,,458)
         STRING(@s50),AT(156,52,3698,208),USE(AMATS_PARAKSTS2,,?AMATS_PARAKSTS2:3),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
         STRING('Saòçma kasieris'),AT(156,260,1510,208),USE(?String73:273),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s25),AT(1188,271),USE(SYS:PARAKSTS3,,?SYS:PARAKSTS3:3),LEFT(1),FONT(,9,,,CHARSET:BALTIC)
       END
PAGEBREAK DETAIL,PAGEAFTER(-1),AT(,,,0),USE(?PAGEBREAK)
       END
SPACE  DETAIL,AT(,,,302),USE(?PAGE:S)
       END
HALF_SPACE DETAIL,AT(,,,146),USE(?PAGE:HS)
       END
NO_SPACE DETAIL,AT(,,,10),USE(?PAGE:NS)
       END
     END

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       STRING(''),AT(0,19,141,10),USE(?Progress:UserString),CENTER
     END

  CODE                                            ! Begin processed code
!
! STREAM 1-NO/LÎDZ
! F:DTK  1-DRUKÂT PASAKÒUS
!
  PUSHBIND
  CHECKOPEN(system,1)
  CHECKOPEN(global,1)
  CHECKOPEN(PAR_K,1)
  IF STREAM=1 !DRUKÂT N0-LÎDZ
     CHECKOPEN(GGK,1)
     CLEAR(GGK:RECORD)
     GGK:DATUMS=S_DAT
     GGK:BKK=KKK
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
  .

  CG='K113001'
  PERIODS=0 !BUILDKORMAS AR ÐITO ATGRIEÞ 23800 PAR_NR

  OPEN(ProgressWindow)
  open(report)
  report{Prop:Preview} = PrintPreviewImage
!  STOP(REPORT{PROPPRINT:context})
  LOOP
    IF STREAM=1 !DRUKÂT N0-LÎDZ
       NEXT(GGK)
       if ERROR() OR cyclebkk(ggk:bkk,kkk)=2 then break.
       if ggk:U_NR=1 then cycle.
       if ggk:datums>b_dat THEN cycle.
       if cyclebkk(ggk:bkk,kkk) then cycle.
       IF CYCLEGGK(CG) THEN CYCLE.
       IF ~GETGG(GGK:U_NR)
          KLUDA(0,'Nav atrasts GG raksts N '&ggk:u_nr)
          CYCLE
       .
    .
    DATUMS  =DAY(GG:DOKDAT)
    RPT_MENESIS =MENVAR(GG:DOKDAT,2,2)
    RPT_GADS    =YEAR(GG:DOKDAT)
    CLEAR(PAR:RECORD)   !nauda nâkusi no GG-partnera
    PAR:U_NR=GG:PAR_NR
    GET(PAR_K,PAR:NR_KEY)
    IF ERROR() OR PAR:U_NR=0
       CLEAR(PAR:RECORD)
       NOKA=GG:NOKA
       REG_NR=''
       PAR_KODS=''
    ELSE
       NOKA=PAR:NOS_P
       IF PAR:TIPS='F'
          IF LEN(CLIP(NOKA))>40-13
             PAR_KODS=CLIP(PAR:NMR_KODS)
           ELSE
             NOKA=CLIP(NOKA)&' '&CLIP(PAR:NMR_KODS)
             PAR_KODS=''
          .
          REG_NR=PAR:pase
       else
          REG_NR=GETPAR_K(GG:PAR_NR,0,9)
       .
    .
    RPT_NOKA   = NOKA
    PVN_PASE=REG_NR
    teksts=clip(GG:SATURS)&' '&clip(GG:SATURS2)&' '&clip(GG:SATURS3)
    FORMAT_TEKSTS(60,'Arial',9,'',85,85)
    PAM10 =F_TEKSTS[1]
    PAM20 =F_TEKSTS[2]
    PAM30 =F_TEKSTS[3]
    PAM300=F_TEKSTS[3]
    teksts=SUMVAR(GGK:SUMMAV,GGK:VAL,0)
    format_teksts(85,'Arial',10,'')
    SUMVAR1 =F_teksts[1]
    SUMVAR2 =F_teksts[2]
    SUMVAR3 =F_teksts[3]
    AMATS_PARAKSTS2=clip(SYS:AMATS2)&' '&SYS:PARAKSTS2

    ?Progress:UserString{PROP:TEXT}='Orderis Nr '&GG:DOK_SENR
    DISPLAY
    IF STREAM=1 !DRUKÂT NO-LÎDZ
       BUILDKORMAS(2,0,1,0,0)  !,,,,NEMEKLÇT TIEÐI TÂDU PVN_PROC
    ELSE
       BUILDKORMAS(3,0,1,0,0)
    .
    CLEAR(pvn_summa)
    CLEAR(K_summa)
    EXTRA_LINES=0
    KLUDA#=FALSE
    LOOP I#=1 TO 20
       IF KOR_SUMMA[I#]<0 ! VISTICAMÂK,IR VEL KÂDS D KONTS...
          KLUDA (0,'Nekorekti nokontçts dokuments...(lieki D konti,KK ?)')
          KLUDA#=TRUE
          EXTRA_LINES=0
          BREAK
       ELSIF KOR_KONTS[I#] 
          EXTRA_LINES+=1
          IF I#=1 THEN SAV_PVN_PROC=KOR_PVN_PROC[I#].
          IF ~(SAV_PVN_PROC=KOR_PVN_PROC[I#])
             EXTRA_LINES+=1 !BÛS VAIRÂK PAR 1 SUMMAS&PVN RINDU
          .
       .
    .
    !El IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL') THEN EXTRA_LINES+=1.
    IF ~(GGK:VAL=val_uzsk) THEN EXTRA_LINES+=1.
    IF ORDERI=1              !JAU IZDRUKÂTS 1.ORDERIS UZ LAPAS
       IF LAST_EXTRA_LINES+EXTRA_LINES=6 !2KONTI+1PVN%+2KONTI+1PAPILDUS
          PRINT(RPT:HALF_SPACE)
       ELSIF LAST_EXTRA_LINES+EXTRA_LINES=7 !2KONTI+1PVN%+1PAPILDUS+2KONTI+1PAPILDUS
          PRINT(RPT:NO_SPACE)
       ELSIF LAST_EXTRA_LINES+EXTRA_LINES>7 !2KONTI+1PVN%+2 KONTI+VAIRÂK KÂ 2PAPILDUS
          PRINT(RPT:PAGEBREAK)
          ORDERI=0
          FORCED_PAGEBREAKS+=1
       ELSE
          PRINT(RPT:SPACE)
       .
    .
    LAST_EXTRA_LINES=0
    IF F:X=2 THEN ZATSK='Z-atsk.'.
    IF F:DTK  !DRUKÂT PASAKNI
       PRINT(RPT:DETAIL)
    ELSE
       PRINT(RPT:DETAIL_)
    .
    IF KLUDA#=FALSE !ÐÍÎBUS KONTÇJUMUS NEDRUKÂSIM...
       LOOP I#=1 TO 20
          RPT_KOR_KONTS=KOR_KONTS[I#]
          IF ~RPT_KOR_KONTS THEN BREAK.
          RPT_KOR_SUMMA=KOR_SUMMA[I#]
          rpt_kor_VAL  =KOR_VAL[I#]
          IF RPT_KOR_KONTS[1:4]='2380' AND PERIODS !nauda nâkusi no avansiera(inkasenta)
             CLEAR(PAR:RECORD)
             PAR:U_NR=PERIODS                      !CAUR ÐITO BUILDKORMAS NODOD 2380 GGK:PAR_NR
             GET(PAR_K,PAR:NR_KEY)
             IF ERROR() OR PAR:U_NR=0
                CLEAR(PAR:RECORD)
                NOKA=GG:NOKA
                REG_NR=''
                PAR_KODS=''
             ELSE
                NOKA=PAR:NOS_P
                IF PAR:TIPS='F'
                   IF LEN(CLIP(NOKA))>40-13
                      PAR_KODS=CLIP(PAR:NMR_KODS)
                    ELSE
                      NOKA=CLIP(NOKA)&' '&CLIP(PAR:NMR_KODS)
                      PAR_KODS=''
                   .
                   REG_NR=PAR:pase
                else
                   REG_NR=GETPAR_K(GG:PAR_NR,0,9)
                .
             .
             RPT_NOKA   = NOKA
             PVN_PASE   = REG_NR
          .
          IF RPT_KOR_KONTS[1:4]='5721'
              IF KOR_PVN_PROC[I#]='18' THEN PVN_SUMMA[1]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='5'  THEN PVN_SUMMA[2]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='0'  THEN PVN_SUMMA[3]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]=''   THEN PVN_SUMMA[4]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='21' THEN PVN_SUMMA[5]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='10' THEN PVN_SUMMA[6]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='22' THEN PVN_SUMMA[7]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='12' THEN PVN_SUMMA[8]+=RPT_KOR_SUMMA.
          ELSE
              IF KOR_PVN_PROC[I#]='18' THEN K_SUMMA[1]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='5'  THEN K_SUMMA[2]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='0'  THEN K_SUMMA[3]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]=''   THEN K_SUMMA[4]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='21' THEN K_SUMMA[5]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='10' THEN K_SUMMA[6]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='22' THEN K_SUMMA[7]+=RPT_KOR_SUMMA.
              IF KOR_PVN_PROC[I#]='12' THEN K_SUMMA[8]+=RPT_KOR_SUMMA.
          .
          IF ~(F:X=2) !NO BUILDKORMAS
             IF F:DTK   !DRUKÂT PASAKNI
                PRINT(RPT:DETAIL1S)
             ELSE
                PRINT(RPT:DETAIL1S_)
             .
          .
          LAST_EXTRA_LINES+=1 !LAI NÂKOÐAJAM ORDERIM ZINÂTU, VAI PIETIKS VIETAS
          PAM300=''
       .
    .
    IF F:DTK   !DRUKÂT PASAKNI
       PRINT(RPT:DETAIL2S)
    ELSE
       PRINT(RPT:DETAIL2S_)
    .
    IF ~(PVN_SUMMA[1]+PVN_SUMMA[2]+PVN_SUMMA[3]+K_SUMMA[4]+PVN_SUMMA[5]+PVN_SUMMA[6]+PVN_SUMMA[7]+PVN_SUMMA[8]) !NO 261 KONTA,JA KONTÇJUMÂ 5721* NAV
       CLEAR(K_SUMMA)
       I#=3 !PROTECT GPF
       IF ggk:pvn_proc=18 THEN I#=1.
       IF ggk:pvn_proc=5  THEN I#=2.
       IF ggk:pvn_proc=0
          IF BAND(ggk:BAITS,00000010b)
             I#=4 !NEAPLIEKAMS
          ELSE
             I#=3
          .
       .
       IF ggk:pvn_proc=21 THEN I#=5.
       IF ggk:pvn_proc=10  THEN I#=6.
       IF ggk:pvn_proc=22 THEN I#=7.
       IF ggk:pvn_proc=12  THEN I#=8.
       pvn_summa[I#] =GGK:SUMMAV-GGK:SUMMAV/(1+GGK:PVN_PROC/100)  !ANALÎTISKI
       K_SUMMA[I#]=GGK:SUMMAV-pvn_summa[I#]
    .
    LOOP I#=1 TO 8
       IF K_SUMMA[I#]
          pvn_text =CLIP(LEFT(FORMAT(pvn_summa[I#],@N_12.2)))&' '&ggk:val
          EXECUTE I#
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[1],@N_12.2)))&' PVN 18% = '&PVN_TEXT
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[2],@N_12.2)))&' PVN 5% = '&PVN_TEXT
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[3],@N_12.2)))&' PVN 0% = '&PVN_TEXT
             SUMMA_TEXT='Summa '&CLIP(LEFT(FORMAT(K_SUMMA[4],@N_12.2)))&' '&ggk:val&' ar PVN neapliekama'
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[5],@N_12.2)))&' PVN 21% = '&PVN_TEXT   !5
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[6],@N_12.2)))&' PVN 10% = '&PVN_TEXT   !6
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[7],@N_12.2)))&' PVN 22% = '&PVN_TEXT   !7
             SUMMA_TEXT='Summa = '&CLIP(LEFT(FORMAT(K_SUMMA[8],@N_12.2)))&' PVN 12% = '&PVN_TEXT   !8
          .
          IF ~(F:X=2)
             IF F:DTK !DRUKÂT PASAKNI
                PRINT(RPT:DETAIL1)
             ELSE
                PRINT(RPT:DETAIL1_)
             .
             LAST_EXTRA_LINES+=1
          .
       .
    .
    !IF ~(GGK:VAL='Ls' OR GGK:VAL='LVL')
    IF ~(GGK:VAL=val_uzsk)
       !El LB_TEXT='Pçc LB kursa '&CLIP(BANKURS(ggk:VAL,ggk:DATUMS,1))&' tas sastâda Ls '&ggk:summa
       LB_TEXT='Pçc LB kursa '&CLIP(BANKURS(ggk:VAL,ggk:DATUMS,1))&' tas sastâda '&val_uzsk&' '&ggk:summa
       IF F:DTK   !DRUKÂT PASAKNI
          PRINT(RPT:DETAILLB)
       ELSE
          PRINT(RPT:DETAILLB_)
       .
       LAST_EXTRA_LINES+=1
    .
    IF F:DTK   !DRUKÂT PASAKNI
       PRINT(RPT:DETAIL2)
       IF SUMVAR3
          PRINT(RPT:DETAIL3)
       .
    ELSE
       PRINT(RPT:DETAIL2_)
       IF SUMVAR3
          PRINT(RPT:DETAIL3_)
       .
    .
    IF F:DTK   !DRUKÂT PASAKNI
       PRINT(RPT:DETAIL4)
    ELSE
       PRINT(RPT:DETAIL4_)
    .
    IF STREAM=1 !DRUKÂT N0-LÎDZ
       ORDERI+=1
       IF ORDERI=1 AND F:NOA !KATRU UZ SAVAS LAPAS
          ORDERI=0
          PRINT(RPT:PAGEBREAK)
          LAST_EXTRA_LINES=0
       ELSIF ORDERI=2
          ORDERI=0
          PRINT(RPT:PAGEBREAK)
          LAST_EXTRA_LINES=0
       .
    ELSE
       BREAK
    .
  .
  ENDPAGE(report)
  CLOSE(ProgressWindow)
  IF FORCED_PAGEBREAKS
     KLUDA(0,CLIP(FORCED_PAGEBREAKS)&' orderi tika drukâti katrs uz savas lapas',,1)
  .
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
  .
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  popbind
