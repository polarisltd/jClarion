                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETPAR_ATZIME        FUNCTION (ATZ_NR,RET)        ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RET   1-ATGRIEÞ ATZÎMES TEKSTU
!       2-ATGRIEÞ WARLEVEL
!       3-ATGRIEÞ WARTEXT
!

  IF ~INRANGE(RET,1,3)
     KLUDA(0,'ATZÎMES: Pieprasîts atgriezt '&RET)
     RETURN('')
  .
  IF ATZ_NR=0
     return('')
  ELSE
     IF PAR_Z::USED=0
        CHECKOPEN(PAR_Z,1)
     .
     PAR_Z::used+=1
     CLEAR(ATZ:RECORD)
     ATZ:NR=ATZ_NR
     GET(PAR_Z,ATZ:NR_KEY)
     IF ERROR()
        RET=''
     .
     PAR_Z::USED-=1
     IF PAR_Z::USED=0
        CLOSE(PAR_Z)
     .
     EXECUTE RET+1
        return('')
        return(ATZ:TEKSTS)   !1
        return(ATZ:WARLEVEL) !2
        BEGIN                !3
           EXECUTE ATZ:WARLEVEL+1
              return('')
              return('jâbrîdina, sastâdot dokumentu')
              return('aizliegts izrakstît P/Z')
              return('aizliegts tiergot caur kasi')
              return('speciâli noteikumi')
           .
        .
     .
  .
K_RENV               PROCEDURE                    ! Declare Procedure
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

IEP_CENA             DECIMAL(14,4)
REAL_CENA            DECIMAL(14,4)
IEP_CENAV            DECIMAL(14,4)
REAL_CENAV           DECIMAL(14,4)
DAUDZUMS             DECIMAL(12,3)
UZC_PR               REAL
NET_PEL              DECIMAL(12,2)
DAUDZUMSK            DECIMAL(13,3)
D_DAUDZUMSK          DECIMAL(12,3)
UZC_PR_V             REAL
NET_PEL_K            DECIMAL(12,2)
D_SUMMAK             DECIMAL(12,2)
K_SUMMAK             DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
sav_nomenklat        STRING(15)

CN                   STRING(5)
CP                   STRING(3)

P_TABLE              QUEUE,PRE(P)
NR                      STRING(10) !DÇÏ PAR-GRUPÂM
DAUDZUMS                DECIMAL(13,3)
D_SUMMAK                DECIMAL(14,4)
SUMMA                   DECIMAL(14,4)
                     END

IZZINA_TEXT          STRING(70)
NOL_TEXT             STRING(70)
FILTRS_TEXT          STRING(100)
FORMA_TEXT           STRING(10)
NOM_NOS_TEXT         STRING(70)   !WMF-am
P_NR                 ULONG
NOS_P                STRING(50)

!---------------------------------------------------------------------------
Process:View         VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:KATALOGA_NR)
                       PROJECT(KOPS:U_NR)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:STATUSS)
                     END
!---------------------------------------------------------------------------
report REPORT,AT(110,1802,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(110,146,8000,1667),USE(?unnamed:3)
         STRING(@P<<<#. lapaP),AT(7302,750,573,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s45),AT(1646,208,4427,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(1083,729,5521,208),USE(NOL_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(135,938,7448,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(521,469,6667,260),USE(IZZINA_TEXT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(7198,573),USE(FORMA_TEXT),TRN,RIGHT
         LINE,AT(135,1146,7740,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(135,1146,0,521),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(3750,1146,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4583,1146,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5469,1146,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6323,1146,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7031,1146,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7865,1146,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(135,1646,7740,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Vid.iep.cena'),AT(3781,1198,781,208),USE(?VIDiepCENA),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vid.real.cena'),AT(4615,1188,833,208),USE(?Vidrealcena),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Realizçts'),AT(5500,1198,729,208),USE(?String9:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vidçjais'),AT(6365,1198,625,208),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto peïòa'),AT(7063,1198,781,208),USE(?String9:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s70),AT(177,1354,3500,208),USE(NOM_NOS_TEXT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(bez PVN)'),AT(3781,1406,781,208),USE(?StringBEZPVN),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(bez PVN)'),AT(4615,1396,833,208),USE(?StringBEZPVN1),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzcen. %'),AT(6333,1406,677,208),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(bez PVN)'),AT(7229,1406,625,208),USE(?StringLsBezPVN),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7042,1406,219,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(daudzums)'),AT(5500,1385,729,208),USE(?String40),FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail1 DETAIL,AT(,,,177),USE(?unnamed:7)
         STRING(@s17),AT(1604,10,833,156),USE(kops:kataloga_nr),LEFT(1)
         LINE,AT(2500,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         STRING(@s16),AT(2604,10,1094,156),USE(kops:nos_s)
         LINE,AT(3750,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(3833,10,729,156),USE(iep_cena,,?iep_cena:2),RIGHT
         LINE,AT(4583,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(4708,10,729,156),USE(real_cena),RIGHT
         LINE,AT(5469,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(5615,10,677,156),USE(daudzums),RIGHT
         LINE,AT(6323,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(6406,10,594,156),USE(uzc_pr),RIGHT
         LINE,AT(7031,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7115,10,729,156),USE(net_pel,,?net_pel:2),RIGHT
         LINE,AT(7865,-10,0,198),USE(?Line11:9),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         LINE,AT(135,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@s21),AT(177,10,1302,156),USE(kops:nomenklat)
       END
detail2 DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(3750,-10,0,198),USE(?Line11:17),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(3833,10,729,156),USE(iep_cena),RIGHT
         LINE,AT(4583,-10,0,198),USE(?Line111:5),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(4708,10,729,156),USE(real_cena,,?real_cena:2),RIGHT
         LINE,AT(5469,-10,0,198),USE(?Line111:6),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(5615,10,677,156),USE(daudzums,,?daudzums:2),RIGHT
         LINE,AT(6323,-10,0,198),USE(?Line111:7),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(6406,10,594,156),USE(uzc_pr,,?uzc_pr:2),RIGHT
         LINE,AT(7031,-10,0,198),USE(?Line111:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7115,10,729,156),USE(net_pel),RIGHT
         LINE,AT(7865,-10,0,198),USE(?Line111:9),COLOR(COLOR:Black)
         STRING(@N_8),AT(167,10,520,156),USE(P_NR),RIGHT(1)
         LINE,AT(708,-10,0,198),USE(?Line11:18),COLOR(COLOR:Black)
         LINE,AT(135,-10,0,198),USE(?Line111),COLOR(COLOR:Black)
         STRING(@s45),AT(740,10,3000,156),USE(nos_p)
       END
detail3 DETAIL,AT(,,,177),USE(?unnamed:5)
         LINE,AT(3750,-10,0,198),USE(?Line311:17),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(3833,10,729,156),USE(iep_cena,,?iep_cena:3),RIGHT
         LINE,AT(4583,-10,0,198),USE(?Line311:5),COLOR(COLOR:Black)
         STRING(@n-_12.4),AT(4708,10,729,156),USE(real_cena,,?real_cena:3),RIGHT
         LINE,AT(5469,-10,0,198),USE(?Line311:6),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(5615,10,677,156),USE(daudzums,,?daudzums:3),RIGHT
         LINE,AT(6323,-10,0,198),USE(?Line311:7),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(6406,10,594,156),USE(uzc_pr,,?uzc_pr:3),RIGHT
         LINE,AT(7031,-10,0,198),USE(?Line311:8),COLOR(COLOR:Black)
         STRING(@n-_12.2),AT(7115,10,729,156),USE(net_pel,,?net_pel:3),RIGHT
         LINE,AT(7865,-10,0,198),USE(?Line311:9),COLOR(COLOR:Black)
         LINE,AT(135,-10,0,198),USE(?Line311),COLOR(COLOR:Black)
         STRING(@s45),AT(177,10,3000,156),USE(nos_p,,?nos_p:3)
       END
RPT_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:6)
         LINE,AT(135,-10,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,115),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,115),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,115),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(6323,-10,0,115),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,115),USE(?Line29),COLOR(COLOR:Black)
         LINE,AT(135,0,7740,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(7031,-10,0,198),USE(?Line11:14),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(7042,10,802,156),USE(net_pel_k),RIGHT
         STRING(@n-_14.4),AT(4635,10,802,156),USE(real_cenaV),RIGHT
         STRING(@n-_14.4),AT(3760,10,800,156),USE(iep_cenaV),RIGHT
         LINE,AT(7865,-10,0,198),USE(?Line11:15),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,198),USE(?Line11:16),COLOR(COLOR:Black)
         LINE,AT(6323,-10,0,198),USE(?Line11:13),COLOR(COLOR:Black)
         STRING(@n-_8.2),AT(6427,0,573,156),USE(uzc_pr_v),RIGHT
         LINE,AT(4583,-10,0,198),USE(?Line11:12),COLOR(COLOR:Black)
         STRING(@n-_14.3b),AT(5490,10,802,156),USE(daudzumsK),RIGHT
         LINE,AT(3750,-10,0,198),USE(?Line11:11),COLOR(COLOR:Black)
         LINE,AT(135,-10,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(188,10,469,156),USE(?String30),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
RPT_FOOT3 DETAIL,AT(,,,427),USE(?unnamed)
         LINE,AT(135,-10,0,63),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,63),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(4583,-10,0,63),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(6323,0,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7031,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line42),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,63),USE(?Line40:2),COLOR(COLOR:Black)
         LINE,AT(135,52,7740,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(208,250,573,156),USE(?String34:3),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(781,250,625,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1417,250,260,156),USE(?String34:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1677,250,156,156),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6750,250,573,156),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7396,250,573,156),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING('Vid. iepirkuma cena tiek rçíinâta kâ iepirkuma(atlikuma) summas un daudzuma atti' &|
             'ecîba no finansu gada sâkuma lîdz perioda beigu datumam visâs noliktavâs'),AT(125,63,7833,156), |
             USE(?String34),TRN,LEFT,FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(146,11396,8000,63)
         LINE,AT(135,0,7740,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(46,41,50,15),USE(?Progress:Cancel)
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
  CP ='N11' !NOLIKTAVÂ,GRUPA,TIPS

  IF nol_kops::used=0
     CHECKOPEN(NOL_KOPS,1)
  .
  NOL_KOPS::USED+=1
  BIND(KOPS:RECORD)

  FilesOpened=TRUE
  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Rentabilitâtes Rçíins'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOL_KOPS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CASE OPCIJA_NR
      OF 1
         IZZINA_text ='Rentabilitâtes Rçíins (S-NOM) no '&FORMAT(s_DAT,@D06.)&' lîdz '&FORMAT(b_DAT,@D06.)
         NOM_NOS_TEXT='Nomenklatûra                  Kataloga Nr           Nosaukums'
         FORMA_TEXT  ='FORMA RE1'
      OF 2
         IZZINA_text ='Rentabilitâtes Rçíins (S-Pircçjiem) no '&FORMAT(s_DAT,@D06.)&' lîdz '&FORMAT(b_DAT,@D06.)
         NOM_NOS_TEXT='   U_Nr       Nosaukums'
         FORMA_TEXT  ='FORMA RE2'
      OF 3
         IZZINA_text ='Rentabilitâtes Rçíins (S-ParGrupâm) no '&FORMAT(s_DAT,@D06.)&' lîdz '&FORMAT(b_DAT,@D06.)
         NOM_NOS_TEXT=' Grupa'
         FORMA_TEXT  ='FORMA RE3'
      OF 4
         IZZINA_text ='Rentabilitâtes Rçíins (S-NOM 1P) no '&FORMAT(s_DAT,@D06.)&' lîdz '&FORMAT(b_DAT,@D06.)
         NOM_NOS_TEXT='Nomenklatûra                  Kataloga Nr           Nosaukums'
         FORMA_TEXT  ='FORMA RE4'
      .
      IF OPCIJA_NR>1
         IF PAR_NR=999999999
            FORMA_TEXT=CLIP(FORMA_TEXT)&'V'
            IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
            IF PAR_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParGrupa:'&PAR_GRUPA.
         ELSE
            FORMA_TEXT=CLIP(FORMA_TEXT)&'P'
            FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Partneris:'&GETPAR_K(PAR_NR,0,2)
         .
      .
      IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.
      NOL_TEXT='Analizçta realizâcija noliktavâs : '
      LOOP I#= 1 TO NOL_SK
        IF NOL_NR25[I#]=TRUE
           NOL_TEXT = CLIP(NOL_TEXT)&CLIP(I#)&','
        ELSE
        .
      .
      NOL_TEXT[LEN(CLIP(NOL_TEXT))]=' '

      CLEAR(KOPS:RECORD)
      KOPS:NOMENKLAT=NOMENKLAT
      SET(KOPS:NOM_KEY,KOPS:NOM_KEY) !
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
         IF ~OPENANSI('K_RENV.TXT')
            POST(Event:CloseWindow)
            CYCLE
         .
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         OUTA:LINE=CLIENT
         ADD(OUTFILEANSI)
         OUTA:LINE=IZZINA_TEXT
         ADD(OUTFILEANSI)
         OUTA:LINE=NOL_TEXT
         ADD(OUTFILEANSI)
         OUTA:LINE=FILTRS_TEXT
         ADD(OUTFILEANSI)
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         OUTA:LINE=''
         ADD(OUTFILEANSI)
         IF F:DBF='E'
           EXECUTE OPCIJA_NR
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep.cena'&CHR(9)&'Vid.real.cena'&CHR(9)&'Realizçts'&CHR(9)&'Vidçjais'&CHR(9)&'Neto peïòa'
             OUTA:LINE='U_Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep.cena'&CHR(9)&'Vid.real.cena'&CHR(9)&'Realizçts'&CHR(9)&'Vidçjais'&CHR(9)&'Neto peïòa'
             OUTA:LINE='Grupa'&CHR(9)&'Vid.iep.cena'&CHR(9)&'Vid.real.cena'&CHR(9)&'Realizçts'&CHR(9)&'Vidçjais'&CHR(9)&'Neto peïòa'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep.cena'&CHR(9)&'Vid.real.cena'&CHR(9)&'Realizçts'&CHR(9)&'Vidçjais'&CHR(9)&'Neto peïòa'
           .
           ADD(OUTFILEANSI)
           EXECUTE OPCIJA_NR
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&'Ls(bez PVN)'
!             OUTA:LINE=CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&'Ls(bez PVN)'
!             OUTA:LINE=CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&'Ls(bez PVN)'
!             OUTA:LINE=CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&'Ls(bez PVN)'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&val_uzsk&'(bez PVN)'
             OUTA:LINE=CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&val_uzsk&'(bez PVN)'
             OUTA:LINE=CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&val_uzsk&'(bez PVN)'
             OUTA:LINE=CHR(9)&CHR(9)&'(bez PVN)'&CHR(9)&'(bez PVN)'&CHR(9)&'(daudzums)'&CHR(9)&'uzcen. %'&CHR(9)&val_uzsk&'(bez PVN)'
           .
         ELSE !WORD
           EXECUTE OPCIJA_NR
!             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
!             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa Ls(bez PVN)'
!             OUTA:LINE='U_Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
!             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa Ls(bez PVN)'
!             OUTA:LINE='Grupa'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
!             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa Ls(bez PVN)'
!             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
!             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa Ls(bez PVN)'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa '&val_uzsk&'(bez PVN)'
             OUTA:LINE='U_Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa '&val_uzsk&'(bez PVN)'
             OUTA:LINE='Grupa'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa '&val_uzsk&'(bez PVN)'
             OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Vid.iep. cena (bez PVN)'&CHR(9)&|
             'Vid.real. cena (bez PVN)'&CHR(9)&'Realizçts (daudzums)'&CHR(9)&'Vidçjais uzcen.%'&CHR(9)&'Neto peïòa '&val_uzsk&'(bez PVN)'
           .
         .
         ADD(OUTFILEANSI)
         OUTA:LINE=''
         ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(KOPS:NOMENKLAT)
           NPK#+=1
           DAUDZUMS=0
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)
           CHECKKOPS('POZICIONÇTS',0,1)                                   !UZBÛVÇJAM KOPS::, [1]IR VISS,KAS <= B-12M
           IF INRANGE(MEN_NR,1,12) !REÂLAIS MEN_NR VAI 13-17,18 NO IZZFILTGMC
              MEN_NR#=MEN_NR+(12-MONTH(DB_B_DAT))                         !INDEKSS KOPS:: MASÎVÂ
              IF MEN_NR#>12 THEN MEN_NR#=12.  !TÂ NEVAJADZÇTU BÛT
           ELSE
              MEN_NR#=MEN_NR
           .
           IEP_CENA  = CALCKOPS(MEN_NR#,0,5)                              !VIDÇJÂ IEP CENA VISÂS NOL uz MEN_NR#
           IF ~IEP_CENA THEN IEP_CENA=GETNOM_K(KOPS:NOMENKLAT,0,7,6).     !PIC
           LOOP J#= 1 TO NOL_SK
              IF NOL_NR25[J#]=TRUE THEN DAUDZUMS += CALCKOPS(MEN_NR#,J#,3) !REAL NOL (RS=A)
              .
           .
           IF DAUDZUMS OR RS='V' !KAUT KAS IR PÂRDOTS VAI ANALIZÇT ARÎ NEAPSIPRRINÂTÂS
              CASE OPCIJA_NR
              OF 1  !S-NOM VISIEM PIRCÇJIEM
                 REAL_CENA = CALCKOPS(MEN_NR#,0,6) !VIDÇJÂ REAL CENA VISÂS NOL
                 UZC_PR = (REAL_CENA-IEP_CENA)/IEP_CENA*100
                 NET_PEL     = (REAL_CENA-IEP_CENA)*DAUDZUMS
                 IF F:DBF = 'W'
                    PRINT(RPT:DETAIL1)
                 ELSE
                    OUTA:LINE=KOPS:NOMENKLAT&CHR(9)&KOPS:KATALOGA_NR&CHR(9)&KOPS:NOS_S&CHR(9)&|
                    LEFT(FORMAT(IEP_CENA,@N-_12.4))&CHR(9)&LEFT(FORMAT(REAL_CENA,@N-_12.4))&CHR(9)&|
                    LEFT(FORMAT(DAUDZUMS,@N-_11.3))&CHR(9)&LEFT(FORMAT(UZC_PR,@N-_8.2))&CHR(9)&|
                    LEFT(FORMAT(NET_PEL,@N-_12.2))
                    ADD(OUTFILEANSI)
                 .
                 DAUDZUMSK  += DAUDZUMS
                 D_SUMMAK   += CALCKOPS(MEN_NR#,0,10) !DÇÏ UZC_PR KOPÂ
                 D_DAUDZUMSK+= CALCKOPS(MEN_NR#,0,11)
                 K_SUMMAK   += CALCKOPS(MEN_NR#,0,2)
                 NET_PEL_K  += (REAL_CENA-IEP_CENA)*DAUDZUMS
              OF 2   !S-PAR
              OROF 3 !S-PAR-GRUPÂM
                 DO BUILDP_TABLE
              OF 4  !S-NOM 1PIRCÇJAM
                 FREE(P_TABLE)
                 DO BUILDP_TABLE
                 IF RECORDS(P_TABLE) !ÐITAM KAUT KAS IR PÂRDOTS
                    GET(P_TABLE,1)
                    IEP_CENA = P:D_SUMMAK
                    real_cena= P:SUMMA
                    DAUDZUMS = P:DAUDZUMS
                    UZC_PR   = (REAL_CENA-IEP_CENA)/IEP_CENA*100
                    NET_PEL  = REAL_CENA-IEP_CENA
                    IF F:DBF = 'W'
                       PRINT(RPT:DETAIL1)
                    ELSE
                       OUTA:LINE=KOPS:NOMENKLAT&CHR(9)&KOPS:KATALOGA_NR&CHR(9)&KOPS:NOS_S&CHR(9)&|
                       LEFT(FORMAT(IEP_CENA,@N-_12.4))&CHR(9)&LEFT(FORMAT(REAL_CENA,@N-_12.4))&CHR(9)&|
                       LEFT(FORMAT(DAUDZUMS,@N-_11.3))&CHR(9)&LEFT(FORMAT(UZC_PR,@N-_8.2))&CHR(9)&|
                       LEFT(FORMAT(NET_PEL,@N-_12.2))
                       ADD(OUTFILEANSI)
                    .
                    IEP_CENAV += IEP_CENA   !REALIZÇTS IEP.CENÂS
                    REAL_CENAV+= REAL_CENA  !REALIZÇTS
                    DAUDZUMSK += DAUDZUMS
                    UZC_PR_V   = (REAL_CENAV-IEP_CENAV)/IEP_CENAV*100
                    NET_PEL_K += NET_PEL
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
  CASE OPCIJA_NR
  OF 1  !S-NOM
     IEP_CENAV=D_SUMMAK/D_DAUDZUMSK   !VID.IEP.CENA
     REAL_CENAV=K_SUMMAK/DAUDZUMSK    !VID.REAL.CENA
     UZC_PR_V =(REAL_CENAV-IEP_CENAV)/IEP_CENAV*100
  OF 2   !S-PAR
  OROF 3 !S-PAR-GRUPÂM
     GET(P_TABLE,0)
     LOOP N#=1 TO RECORDS(P_TABLE)
       GET(P_TABLE,N#)
       P_NR=P:NR[4:10]
       EXECUTE OPCIJA_NR-1
          BEGIN
             IF CL_NR=1033  !SAIMNIEKS-S
                NOS_P    =GETPAR_K(P_NR,0,1)  !S-PAR NOS_S
             ELSE
                NOS_P    =GETPAR_K(P_NR,0,2)  !S-PAR NOS_P
             .
          .
          NOS_P    =P:NR              !S-PARGR
       .
       IEP_CENA = P:D_SUMMAK
       real_cena= P:SUMMA
       DAUDZUMS = P:DAUDZUMS
       UZC_PR   = (REAL_CENA-IEP_CENA)/IEP_CENA*100
       NET_PEL  = REAL_CENA-IEP_CENA
       IF F:DBF = 'W'
          EXECUTE OPCIJA_NR-1
             PRINT(RPT:DETAIL2)
             PRINT(RPT:DETAIL3)
          .
       ELSE
         EXECUTE OPCIJA_NR-1
            OUTA:LINE=FORMAT(P_NR,@N_9)&CHR(9)&NOS_P&CHR(9)&LEFT(FORMAT(IEP_CENA,@N-_12.4))&CHR(9)&|
            LEFT(FORMAT(REAL_CENA,@N-_12.4))&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(FORMAT(UZC_PR,@N-_8.2))&|
            CHR(9)&LEFT(FORMAT(NET_PEL,@N-_12.2))
            OUTA:LINE=NOS_P&CHR(9)&LEFT(FORMAT(IEP_CENA,@N-_12.4))&CHR(9)&LEFT(FORMAT(REAL_CENA,@N-_12.4))&CHR(9)&|
            LEFT(FORMAT(DAUDZUMS,@N-_12.3))&CHR(9)&LEFT(FORMAT(UZC_PR,@N-_8.2))&CHR(9)&LEFT(FORMAT(NET_PEL,@N-_12.2))
         .
         ADD(OUTFILEANSI)
       END
       IEP_CENAV += IEP_CENA          !REALIZÇTS IEP.CENÂS
       REAL_CENAV+= REAL_CENA         !REALIZÇTS
       DAUDZUMSK += DAUDZUMS
       UZC_PR_V   = (REAL_CENAV-IEP_CENAV)/IEP_CENAV*100
       NET_PEL_K += NET_PEL
     .
  .
  IF F:DBF = 'W'
    PRINT(RPT:RPT_FOOT1)
    PRINT(RPT:RPT_FOOT2)
    PRINT(RPT:RPT_FOOT3)
  ELSE
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(IEP_CENAV,@N-_12.4))&CHR(9)&LEFT(FORMAT(REAL_CENAV,@N-_12.4))&|
    CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_12.3))&CHR(9)&LEFT(FORMAT(UZC_PR_V,@N-_8.2))&CHR(9)&LEFT(FORMAT(NET_PEL_K,@N-_12.2))
    ADD(OUTFILEANSI)
    OUTA:LINE=''
    ADD(OUTFILEANSI)
    OUTA:LINE=ACC_KODS&' '&FORMAT(DAT,@D06.)&' '&FORMAT(LAI,@T4)
    ADD(OUTFILEANSI)
    OUTA:LINE='Vid. iepirkuma cena tiek rçíinâta kâ iepirkuma(atlikuma) summas un daudzuma '&|
    'attiecîba no finansu gada sâkuma visâs noliktavâs '
    ADD(OUTFILEANSI)
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
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
  CLOSE(NOLIK)
  FREE(P_TABLE)
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
  IF ERRORCODE() OR (CYCLENOM(kops:NOMENKLAT)=2)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
BUILDP_TABLE ROUTINE
  LOOP J#= 1 TO NOL_SK
     IF NOL_NR25[J#]=TRUE
        CLOSE(NOLIK)
        NOLIKNAME='NOLIK'&FORMAT(j#,@N02)
        checkopen(nolik,1)
        CLEAR(NOL:RECORD)
        NOL:NOMENKLAT = KOPS:NOMENKLAT
        NOL:DATUMS    = S_DAT
        SET(NOL:NOM_KEY,NOL:NOM_KEY)
        LOOP
          NEXT(NOLIK)
          IF ERROR() OR ~(KOPS:NOMENKLAT=NOL:NOMENKLAT) OR ~(NOL:DATUMS<=B_DAT) THEN BREAK.
          IF INRANGE(NOL:PAR_NR,1,50) THEN CYCLE.
          IF RS='A' AND NOL:RS='1' THEN CYCLE.
          IF ~(PAR_NR=999999999 OR NOL:PAR_NR=PAR_NR) THEN CYCLE.
          IF CYCLEPAR_K(CP) THEN CYCLE.
            IF NOL:D_K='K'
              GET(P_TABLE,0)
              EXECUTE OPCIJA_NR-1
                 P:NR = SUB(GETPAR_K(NOL:PAR_NR,0,14),1,3)&FORMAT(NOL:PAR_NR,@N_07) !NOS_U&U_NR
                 P:NR = GETPAR_K(NOL:PAR_NR,0,15)    !GRUPA
                 P:NR = FORMAT(NOL:PAR_NR,@N_010)    !1P
              .
              GET(P_TABLE,P:NR)
              IF ERROR()
                P:DAUDZUMS = NOL:DAUDZUMS            !VISI K DAUDZUMI KOPÂ
                P:D_SUMMAK = IEP_CENA*NOL:DAUDZUMS   !PÂRDOTÂ SUMMA ÐIM PARTNERIM IEPIRKUMA CENÂS
                P:SUMMA = CALCSUM(15,3)              !K BEZ PVN Ls-A
                ADD(P_TABLE)
                SORT(P_TABLE,P:NR)
              ELSE
                P:DAUDZUMS += NOL:DAUDZUMS
                P:D_SUMMAK += IEP_CENA*NOL:DAUDZUMS
                P:SUMMA += CALCSUM(15,3)
                PUT(P_TABLE)
              END
            END
        .
     .
  .
NYcreator PROCEDURE


LocalRequest         LONG
Berni                BYTE
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
OPC                  BYTE,DIM(16)
GL_DB_GADS           DECIMAL(4)
ERR                  BYTE
ERRP                 BYTE
ERRK                 USHORT
TTAKA                CSTRING(60)
DB_SB_DAT            STRING(50)
GL_DB_SB_DAT         STRING(50)
GL_DB_S_DAT          LONG
GL_DB_B_DAT          LONG
PAR_AUTO_Nr          STRING(50)
kops_gads            SHORT
NOLLIST              STRING(45)
PA                   SHORT
NR                   DECIMAL(4)
NOSAUKUMS            STRING(29)
BKK                  STRING(5)
VID                  DECIMAL(11,4)
!REALIZETS            DECIMAL(13,3)
ATLIKUMS_N           DECIMAL(13,3),DIM(25)
!DAUDZUMS_N           DECIMAL(13,3),DIM(25)
!DAUDZUMS             DECIMAL(13,3)
!CTRL_I               DECIMAL(13,3)
!DAUDZUMS_nol         DECIMAL(13,3)
!SUMMA_K              DECIMAL(13,2)
!FMI_K                DECIMAL(13,2)
!FMI_TS               DECIMAL(13,2)
!REA_TS               DECIMAL(13,3)
!KOPA                 STRING(8)
!BKKK                 STRING(5)
DAUDZUMS             DECIMAL(13,3)
BILVERT              DECIMAL(14,2)
PAV_SUMMA            DECIMAL(14,2),DIM(25)
!BILVERT_NOL          DECIMAL(14,2)
!BILVERT_K            DECIMAL(14,2)
!DAT                  DATE
!LAI                  TIME
SAV_FILENAME1        LIKE(FILENAME1)
FILENAME_S           LIKE(FILENAME1)
FILENAME_D           LIKE(FILENAME1)

SAV_JOB_NR           LIKE(JOB_NR)
VS_FIFO              STRING(4)
RAKSTI               ULONG
BRIK                 ULONG

!KONKNAME            CSTRING(60),STATIC
!
!
!KON_K                   FILE,DRIVER('TOPSPEED'),RECLAIM,NAME(KONKNAME),PRE(KON),CREATE,BINDABLE,THREAD
!BKK_KEY                  KEY(KON:BKK),NOCASE,OPT
!GNET_KEY                 KEY(KON:GNET_FLAG),DUP,NOCASE,OPT
!Record                   RECORD,PRE()
!BKK                         STRING(5)
!ALT_BKK                     STRING(6)
!NOSAUKUMS                   STRING(95)
!NOSAUKUMSA                  STRING(95)
!VAL                         STRING(3)
!PVND                        USHORT,DIM(2)
!PVNK                        USHORT,DIM(2)
!PZB                         USHORT,DIM(4)
!NPP2                        USHORT,DIM(4)
!NPPF                        STRING(4)
!PKIP                        USHORT,DIM(3)
!PKIF                        STRING(3)
!ATLIKUMS                    DECIMAL(11,2),DIM(15)
!BAITS                       BYTE
!GNET_FLAG                   STRING(2)
!ACC_KODS                    STRING(8)
!ACC_DATUMS                  LONG
!                         END
!                       END
!KON_K::Used          LONG,THREAD


RejectRecord         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END

INIFILE          FILE,DRIVER('ASCII'),NAME('WINLATS.INI'),PRE(INI),CREATE,BINDABLE,THREAD
Record              RECORD,PRE()
LINE                  STRING(120)
                    END
                 END

PAR_START_U_NR   ULONG
PAR_END_U_NR     ULONG

PARAMETRI WINDOW('Parametri'),AT(,,293,89),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),GRAY
       STRING('Pçdçjais atrastais Partnera U_NR :'),AT(11,39),USE(?String91)
       STRING(@n_6),AT(126,39),USE(PAR:U_NR)
       ENTRY(@N_6),AT(121,49,42,14),USE(PAR_START_U_NR),REQ
       STRING('Iesakam autonumerâciju sâkt no '),AT(11,51),USE(?String21)
       STRING('0-turpinât no pçdçjâ ðajâ gadâ'),AT(167,51),USE(?String6)
       STRING('Iesakam  norâdît autonumerâcijas apgabalu, gadîjumam, ja ðajâ datu bâzç'),AT(11,17),USE(?String11)
       STRING('vçl tiks ievadîti jauni partneri, lai tos varçtu paòemt un atpazît jaunajâ'),AT(11,28), |
           USE(?String3)
       BUTTON('&OK'),AT(246,68,35,14),USE(?Ok:PARAMETRI),FONT(,,,FONT:bold,CHARSET:ANSI),DEFAULT
     END

DOSFILES    QUEUE,PRE(A)
NAME   STRING(13)
DATE   LONG
TIME   LONG
SIZE   LONG
ATTRIB BYTE
       .
window               WINDOW('Jaunas datu bâzes izveidoðana'),AT(,,442,364),FONT('MS Sans Serif',9,,FONT:bold),CENTER,GRAY,MAXIMIZE
                       STRING('Tekoðâ datu bâze :'),AT(37,7),USE(?String1:2)
                       STRING(@s60),AT(102,7,241,10),USE(TTAKA)
                       STRING(@n4),AT(343,7,20,10),USE(DB_GADS),RIGHT(1),FONT(,9,,FONT:bold)
                       STRING('. gads.'),AT(364,7),USE(?String7),FONT(,9,,)
                       STRING(@s50),AT(102,17),USE(DB_SB_DAT)
                       STRING('Jaunâs datu bâzes (jauna gada) vârds (taka) :'),AT(20,36),USE(?String1)
                       ENTRY(@s59),AT(173,33),USE(FILENAME1),REQ
                       STRING('Gads(vârds) :'),AT(342,36),USE(?String7:2),FONT(,9,,)
                       STRING(@N_4),AT(387,36,26,10),USE(GL_DB_GADS),CENTER,FONT(,9,,FONT:bold)
                       STRING(@s50),AT(247,49),USE(GL_DB_SB_DAT)
                       STRING('Atverot jaunu DB, Jums pirmajâ reizç jâatzîmç viss;  vçlâk Jûs izveidosiet (un p' &|
   'ârrakstîsiet) Saldo rakstus Bâzç un Noliktavâ'),AT(18,62,405,10),USE(?String9:4),FONT(,,COLOR:Green,,CHARSET:ANSI)
                       STRING('kâ arî Algas un Pamatlîdzekïus kaut 100 reizes. WinLata izsaukuma poga (shortcut' &|
   ' desktopâ) Jums jâizveido paðiem (visçrtâk: '),AT(18,72),USE(?String9),FONT(,,COLOR:Green,,CHARSET:ANSI)
                       STRING('Viena kreisâ pele uz tekoðâ gada pogas, Ctrl+C,Ctrl+V, labâ pele uz ikonas kopij' &|
   'as un properties nomainiet  Start in: '),AT(18,82),USE(?String9:2),FONT(,,COLOR:Green,,CHARSET:ANSI)
                       STRING('taku uz Jaunâs datu bâzes vârdu(taku).'),AT(18,93),USE(?String9:3),FONT(,,COLOR:Green,,CHARSET:ANSI)
                       CHECK('   Pârkopçt tikai rîkojumus ar bçrniem'),AT(219,136,131,10),USE(Berni),VALUE('1','')
                       OPTION('&Kopçjie faili'),AT(27,106,390,82),USE(?Option1),BOXED
                       END
                       CHECK('   Pârkopçt Reìistrâciju , INI-failu,Globâlos datus ,Sistçmas datus ,Paroles,Nod' &|
   'aïas,Projektus'),AT(38,117,316,10),USE(OPC[1]),VALUE('1','')
                       CHECK('   Pârkopçt Partnerus,Atzîmes,Fileâles,e-M,Lîgumus'),AT(38,127,178,10),USE(OPC[2]),VALUE('1','')
                       STRING(@s40),AT(219,127),USE(PAR_AUTO_Nr),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       CHECK('   Pârkopçt Kadrus un saistîtos failus'),AT(38,136),USE(OPC[3]),VALUE('1','')
                       CHECK('   Pârkopçt Kontu plânu un saistîtos failus'),AT(38,146),USE(OPC[4],,?opcija_4:2),VALUE('1','')
                       CHECK('   Pârkopçt Bankas, ârçjo maks. kodus'),AT(38,157),USE(OPC[5],,?opcija_5:2),VALUE('1','')
                       CHECK('   Pârkopçt Valûtas un Valstis'),AT(38,167),USE(OPC[6]),VALUE('1','')
                       CHECK('   Pârkopçt Valûtu kursus'),AT(38,175),USE(OPC[7],,?opcija_7:2),VALUE('1','')
                       OPTION('&Bâze'),AT(29,190,390,44),USE(?Option2),BOXED
                       END
                       CHECK('   Pârkopçt Tekstu plânu '),AT(38,199),USE(OPC[8],,?opcija_8:2),VALUE('1','')
                       CHECK('   Izveidot ( un pârrakstît ) Saldo rakstu no tekoðâ gada datiem'),AT(38,210),USE(OPC[9],,?opcija_9:4),VALUE('1','')
                       CHECK('   Pârkopçt norçíinu vçsturi un CRM'),AT(38,221),USE(OPC[10]),VALUE('1','')
                       OPTION('&Noliktava'),AT(29,237,391,53),USE(?Option3),BOXED
                       END
                       CHECK('   Pârkopçt Nomenklatûras,Grupas,Apakðgrupas,Sastâvdaïas,Atlikumus,Plauktus,Mekl' &|
   'çjumu vçsturi,Mçrvienibas'),AT(38,247),USE(OPC[11]),VALUE('1','')
                       CHECK('   Pârkopçt Atlaiþu lapas'),AT(38,258),USE(OPC[12]),VALUE('1','')
                       CHECK('   Pârkopçt statistiku, cenu vçsturi, auto, automarkas,plânotâju'),AT(38,269),USE(OPC[13],,?opcija_13:2),VALUE('1','')
                       CHECK('   Izveidot ( un pârrakstît ) Saldo rakstus (FIFO metode)'),AT(38,278),USE(OPC[14],,?opcija_14:2),VALUE('1','')
                       OPTION('&Algas'),AT(28,290,392,31),USE(?Option4),BOXED
                       END
                       CHECK('   Pârkopçt Algu sarakstus,Amatus,DL Kalendâru,Darba apmaksas un ieturçjumu veid' &|
   'us,Atvaïinâjumus un Slilapas'),AT(38,302,376,10),USE(OPC[15],,?opcija_15:2),VALUE('1','')
                       OPTION('&Pamatlîdzekïi'),AT(28,322,393,23),USE(?Option5),BOXED
                       END
                       CHECK('   Pârkopçt Pamatlîdzekïu sarakstu, Nolietojumu,GD Karti,Kategorijas'),AT(38,332),USE(OPC[16]),VALUE('1','')
                       BUTTON('At&zîmçt visu'),AT(277,347,58,14),USE(?ButtonAtzimetVisu)
                       BUTTON('&OK'),AT(343,347,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(384,347,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  TTAKA=LONGpath()
  I#=INSTRING('2009',TTAKA,1)
  IF I#
     IF I#+4<=LEN(TTAKA)
        FILENAME1=TTAKA[1:I#-1]&'2010'&TTAKA[I#+4:LEN(TTAKA)]
     ELSE
        FILENAME1=TTAKA[1:I#-1]&'2010'
     .
  ELSE
     FILENAME1=SUB(TTAKA,1,LEN(TTAKA)-1)&CHR(VAL(SUB(TTAKA,LEN(TTAKA),1))+1) !JAUNÂS DB TAKA
  .
  DB_SB_DAT=GETFING(1,DB_GADS,DB_S_DAT,DB_B_DAT)
  GL_DB_S_DAT=DATE(MONTH(DB_B_DAT)+1,1,YEAR(DB_B_DAT))
  GL_DB_B_DAT=DATE(MONTH(DB_B_DAT)+13,1,YEAR(DB_B_DAT))-1
  GL_DB_GADS=YEAR(GL_DB_B_DAT)  !JAUNÂS DB GADS(VÂRDS)
  GL_DB_SB_DAT=GETFING(1,GL_DB_GADS,GL_DB_S_DAT,GL_DB_B_DAT)
  
  CHECKOPEN(PAR_K,1)
  CLEAR(PAR:RECORD)
  SET(PAR:NR_KEY)
  PREVIOUS(PAR_K)
  IF ERROR() THEN STOP(ERROR()).
  PAR_START_U_NR=PAR:U_NR+100
  CLOSE(PAR_K)
  PAR_AUTO_NR='jaunajâ DB autonumerâcija PAR_K sâksies no '&PAR_START_U_NR
  
  !OPEN(PARAMETRI)
  !DISPLAY
  !ACCEPT
  !   CASE FIELD()
  !   OF ?Ok:PARAMETRI
  !      IF EVENT()=EVENT:ACCEPTED
  !         IF PAR_START_U_NR<=PAR:U_NR
  !            PAR_START_U_NR=0
  !         ELSE
  !            PAR_END_U_NR=PAR_START_U_NR+1000
  !         .
  !         BREAK
  !      .
  !   .
  !.
  !CLOSE(PARAMETRI)
  
  ACCEPT
!    IF OPC[2]=1
!       ENABLE(?BUTTONPARAMETRI)
!    ELSE
!       DISABLE(?BUTTONPARAMETRI)
!    .
!    DISPLAY
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String1:2)
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
    OF ?FILENAME1
      CASE EVENT()
      OF EVENT:Accepted
            IF FILENAME1=LONGPATH()
               KLUDA(27,'FOLDERIS:'&FILENAME1)
               select(?filename1)
            .
      END
    OF ?ButtonAtzimetVisu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LOOP I#=1 TO 16
          OPC[I#]=TRUE
        .
!        ENABLE(?BUTTONPARAMETRI)
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          SELECT(1)
          SELECT
          IF FILENAME1=LONGPATH()
             KLUDA(27,'FOLDERIS:'&FILENAME1)
             CYCLE
          .
          SECURITY_ATT.nLength=Len(SECURITY_ATT)
          SECURITY_ATT.lpSecurityDescriptor=0
          SECURITY_ATT.bInheritHandle=1
          I#=CreateDirectoryA(FILENAME1,SECURITY_ATT)
          IF DOS_CONT(FILENAME1&'\REG.KEY',2)
             KLUDA(0,'Folderî '&filename1&' jau ir WinLata dati !!!',9,1)  !OTRÂDI
             BRIK+=1
             IF KLU_DARBIBA THEN CYCLE.
          .
          LOOP X#=1 TO 16
             IF OPC[X#]
                EXECUTE X#
                   RAKSTI+=6 !1
                   RAKSTI+=3 !2
                   RAKSTI+=2 !3
                   RAKSTI+=2 !4
                   RAKSTI+=1 !5
                   RAKSTI+=1 !6
                   RAKSTI+=1 !7
                   RAKSTI+=1 !8
                   RAKSTI+=1 !9
                   RAKSTI+=1 !10
                   RAKSTI+=9 !11
                   RAKSTI+=2 !12
                   RAKSTI+=7 !13 +3*NOL_SK
                   RAKSTI+=1 !14
                   RAKSTI+=5 !15 +2*ALGU_SK
                   RAKSTI+=1 !16 +3*PAM_SK
                .
                EXECUTE X#
                   BEGIN                        !1
                      FILENAME_S='REG.KEY'
                      FILENAME_D=FILENAME1&'\REG.KEY'
                      IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
                         KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
                         ERRK+=1
                      .
                      CLOSE(GLOBAL)
                      COPY(GLOBAL,FILENAME1)
                      CLOSE(SYSTEM)
                      COPY(SYSTEM,FILENAME1)
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      IF ~ERROR()
                         CHECKOPEN(GLOBAL,1)
                         GL:DB_GADS=GL_DB_GADS
                         GL:DB_S_DAT=GL_DB_S_DAT
                         GL:DB_B_DAT=GL_DB_B_DAT
                         GL:MAU_NR =0
                         GL:KIE_NR =0
                         GL:KIZ_NR =0
                         GL:IESK_NR=0
                         GL:REK_NR =0
                         GL:PIL_NR =0
                         GL:INVOICE_NR=0
                         GL:GARANT_NR =0
                         GL:RIK_NR =0
                         !10/03/2015 GL:FREE_N =0
                         PUT(GLOBAL)
                         CLOSE(GLOBAL)
        
                         JOB_NR=1
                         CHECKOPEN(SYSTEM,1)
                         SYS:control_byte=0    !BILANCE,PZA,VÇSTURE
                         PUT(SYSTEM)
                         CLOSE(SYSTEM)
        
                         SETPATH(TTAKA")
                      .
                      CHECKOPEN(GLOBAL,1)
                      FILENAME_S='WINLATS.INI'
                      FILENAME_D=FILENAME1&'\WINLATS.INI'
                      IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
                         KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
                         ERRK+=1
                      .
                      COPY(PAROLES,FILENAME1)
                      COPY(NODALAS,FILENAME1)
                      COPY(PROJEKTI,FILENAME1)
                      FILENAME_S='USER.BMP'
                      FILENAME_D=FILENAME1&'\USER.BMP'
                      IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
                         KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
                         ERRK+=1
                      .
                      FILENAME_S='START.BMP'
                      FILENAME_D=FILENAME1&'\START.BMP'
                      IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
                         KLUDA(3,FILENAME_S&' uz '&FILENAME_D)
                         ERRK+=1
                      .
                   .
                   BEGIN                        !2
                      COPY(PAR_K,FILENAME1)
                      IF PAR_START_U_NR
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         IF ~ERROR()
        !                    CHECKOPEN(INIFILE,1)
        !                    SET(INIFILE)
                            CHECKOPEN(PAR_K,1)
                            SET(PAR_K)
                            CLEAR(PAR:RECORD)
                            PAR:U_NR=PAR_START_U_NR
                            PAR:NOS_P='1.JAUNAIS PARTNERIS '&GL_DB_GADS&'.g. NEDZÇST!'
                            PAR:NOS_S='1.J.P. '&GL_DB_GADS&'.G'
                            PAR:NOS_A='1.'&GL_DB_GADS
                            ADD(PAR_K)
                            CLOSE(PAR_K)
        !                    LOOP
        !                       NEXT(INIFILE)
        !                       IF ERROR() THEN BREAK.
        !                       IF INI:LINE[1:13]='PAR_END_U_NR='     !7 PAR_K AUTONUMERÂCIJAS APGABALS
        !                          INI:LINE[14:20]=LEFT(PAR_END_U_NR)
        !                          FOUND#=TRUE
        !                          PUT(INIFILE)
        !                          BREAK
        !                       .
        !                    .
        !                    IF FOUND#=FALSE
        !                       INI:LINE='PAR_END_U_NR='&LEFT(PAR_END_U_NR)
        !                       ADD(INIFILE)
        !                    .
        !                    CLOSE(INIFILE)
                            SETPATH(TTAKA")
                         .
                      .
                      !Elya 27/11/2013 <
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(PAR_K)
                      CHECKOPEN(PAR_K,1)
                      CLEAR(PAR:Record,0)
                      SET(PAR_K)
                      LOOP
                         NEXT(PAR_K)
                         IF ERROR() THEN BREAK.
                         IF (~(PAR:KRED_LIM = 0)) OR (~(PAR:L_SUMMA = 0)) OR (~(PAR:L_SUMMA1 = 0))
                            IF GL:DB_GADS = 2013
                                PAR:KRED_LIM = PAR:KRED_LIM/0.702804
                                PAR:L_SUMMA = PAR:L_SUMMA/0.702804  !11/03/2014
                                PAR:L_SUMMA1 = PAR:L_SUMMA1/0.702804 !11/03/2014
                            .
                            PUT(PAR_K)
                         .
                      .
                      close(PAR_K)
                      SETPATH(TTAKA")
                      !Elya 27/11/2013 >
        
                      COPY(PAR_A,FILENAME1)
                      COPY(PAR_E,FILENAME1)
                      COPY(PAR_L,FILENAME1)
                      COPY(PAR_Z,FILENAME1)
                   .
                   BEGIN                        !3
                      COPY(KADRI,FILENAME1)
                      !Elya 22/12/2013 <
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(KADRI)
                      CHECKOPEN(KADRI,1)
                      RecordsToProcess = RECORDS(KADRI)
                      RecordsProcessed = 0
                      PercentProgress = 0
                      OPEN(ProgressWindow)
                      Progress:Thermometer = 0
                      ?Progress:PctText{Prop:Text} = '0%'
                      ProgressWindow{Prop:Text} = 'Darbibnieku veidoðana'
                      ?Progress:UserString{Prop:Text}=''
                      DISPLAY
                      SEND(KADRI,'QUICKSCAN=on')
                      CLEAR(KAD:Record,0)
                      SET(KADRI)
                      LOOP
                         NEXT(KADRI)
                         IF ERROR() THEN BREAK.
                         DO Thermometer
                         IF GL:DB_GADS = 2013
                            KAD:AVANSS = KAD:AVANSS/0.702804
                            PUT(KADRI)
                         .
                      .
                      close(KADRI)
                      IF SEND(KADRI,'QUICKSCAN=off').
                      CLOSE(PROGRESSWINDOW)
                      SETPATH(TTAKA")
                      !Elya 22/12/2013 >
                      !Elya 05/03/2015 <
                      !COPY(KAD_RIK,FILENAME1)
                      IF Berni
                         COPY(KAD_RIK,FILENAME1)
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(KAD_RIK)
                         CHECKOPEN(KAD_RIK,1)
                         RecordsToProcess = RECORDS(KAD_RIK)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Rîkojumu veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(KAD_RIK,'QUICKSCAN=on')
                         CLEAR(RIK:Record,0)
                         SET(KAD_RIK)
                         LOOP
                            NEXT(KAD_RIK)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF RIK:TIPS = 'B'
                            ELSE
                               DELETE(KAD_RIK)
                            .
                         .
                         close(KAD_RIK)
                         IF SEND(KAD_RIK,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 05/03/2015 >
                      ELSE
                          COPY(KAD_RIK,FILENAME1)
                      .
                   !   LOOP I#=1 TO RECORDS(KADRI)
                   !      COPY('K'&CLIP(I#)&'.JPG',FILENAME1)
                   !      IF ERROR() THEN STOP(ERROR()).
                   !   .
        
                   .
                   BEGIN
                      COPY(KON_K,FILENAME1)     !4
                      COPY(KON_R,FILENAME1)
                      DO CREATEKONTUPLANU
                   .
                   BEGIN                        !5
                      COPY(BANKAS_K,FILENAME1)
                      COPY(ARM_K,FILENAME1)
                   .
                   COPY(VAL_K,FILENAME1)        !6
                   !Elya 04/12/2013 <
                   !COPY(KURSI_K,FILENAME1)      !7
                   BEGIN                         !7
                   COPY(KURSI_K,FILENAME1)      !7
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(KURSI_K)
                      CHECKOPEN(KURSI_K,1)
                      CLEAR(KUR:Record,0)
                      SET(KURSI_K)
                      LOOP
                         NEXT(KURSI_K)
                         IF ERROR() THEN BREAK.
                         IF ~(KUR:KURSS = 0)
                            IF GL:DB_GADS = 2013
                                KUR:KURSS = KUR:KURSS/0.702804
                            .
                            PUT(KURSI_K)
                            !10/03/2015 <
                            IF KUR:DATUMS = DATE(12,31,GL:DB_GADS)
                               KUR:DATUMS = DATE(1,1,GL:DB_GADS+1)
                               ADD(KURSI_K)
                            .
                            !10/03/2015 >
                         .
                      .
                      close(KURSI_K)
                      SETPATH(TTAKA")
                   .
                   !Elya 04/12/2013 >
           !-----------------------------------------
                   COPY(TEK_K,FILENAME1)        !8
                   BEGIN                        !9
                      SAV_FILENAME1=FILENAME1
                      DROPSALDO(GL_DB_S_DAT)    !BÛVÇJAM SALDO GG UZ GL_DB_S_DAT
                      ERRK+=F:X                 !ÐITÂ SKAITAM KÏÛDAS
                      FILENAME1=SAV_FILENAME1
                   .
                   BEGIN                         !10
                      JOB_NR=1
                      CHECKOPEN(SYSTEM,1)
                      IF ~BAND(SYS:control_byte,00000100b)  !~VÇSTURE 1BASÇ
                         KLUDA(0,'Nav bûvçta 231/531 Vçsture objektam BÂZE '&JOB_NR,,1)
                         BRIK+=1
                      .
                      COPY(VESTURE,FILENAME1)
                   .
           !-----------------------------------------
                   BEGIN                        !11
                      COPY(NOM_K,FILENAME1)
                      !Elya 15/12/2013 <
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(NOM_K)
                      CHECKOPEN(NOM_K,1)
                      RecordsToProcess = RECORDS(NOM_K)
                      RecordsProcessed = 0
                      PercentProgress = 0
                      OPEN(ProgressWindow)
                      Progress:Thermometer = 0
                      ?Progress:PctText{Prop:Text} = '0%'
                      ProgressWindow{Prop:Text} = 'Nomemklaturu raksta veidoðana Noliktavâs'
                      ?Progress:UserString{Prop:Text}=''
                      DISPLAY
                      SEND(NOM_K,'QUICKSCAN=on')
                      CLEAR(NOM:Record,0)
                      SET(NOM_K)
                      LOOP
                         NEXT(NOM_K)
                         IF ERROR() THEN BREAK.
                         DO Thermometer
                         IF GL:DB_GADS = 2013
                            LOOP I# = 1 TO 5
                                IF NOM:VAL[I#] = 'Ls' OR NOM:VAL[I#] = 'LVL' OR NOM:VAL[I#] = ''
                                    NOM:REALIZ[I#] = NOM:REALIZ[I#]/0.702804
                                    NOM:VAL[I#] = 'EUR'
                                .
                            .
                            NOM:PIC = NOM:PIC/0.702804
                            NOM:MINRC = NOM:MINRC/0.702804
                            PUT(NOM_K)
                         .
                      .
                      close(NOM_K)
                      IF SEND(NOM_K,'QUICKSCAN=off').
                      CLOSE(PROGRESSWINDOW)
                      SETPATH(TTAKA")
                      !Elya 15/12/2013 >
                      COPY(GRUPA1,FILENAME1)
                      COPY(GRUPA2,FILENAME1)
                      COPY(KOMPLEKT,FILENAME1) !SASTÂVDAÏAS
                      COPY(NOM_A,FILENAME1)
                      COPY(NOM_P,FILENAME1) !PLAUKTI
                      COPY(NOM_C,FILENAME1) !NOSAUKUMS CYRILIKA
                      COPY(NOM_N,FILENAME1) !MEKLEJUMI
                      COPY(MER_K,FILENAME1)
                   .
                   BEGIN                        !12
                      COPY(ATL_K,FILENAME1)
                      COPY(ATL_S,FILENAME1)
                   .
                   BEGIN                        !13
                      COPY(NOL_STAT,FILENAME1)
                      COPY(CENUVEST,FILENAME1)
                      COPY(AUTO,FILENAME1)
                      COPY(AUTOMARKAS,FILENAME1)
                      COPY(AUTOKRA,FILENAME1)
                      LOOP N# = 1 TO NOL_SK
                         RAKSTI+=3
                         ATEXNAME=FILENAME1&'\ATEX'&FORMAT(N#,@N02)  !Servisa teksti
                         COPY(AUTOTEX,FILENAME1)
                         AUBNAME=FILENAME1&'\AUBI'&FORMAT(N#,@N02)   !Plânotâjs
                         COPY(AU_BILDE,FILENAME1)
                         IF ERROR() THEN STOP(AUBNAME&ERROR()).
                         AUBTEXNAME=FILENAME1&'\AUTEX'&FORMAT(N#,@N02) !Plânotâja teksti
                         COPY(AU_TEX,FILENAME1)
                      .
                      COPY(TEK_SER,FILENAME1)
                      TEXNAME='TEX_NOL'
                      COPY(TEKSTI,FILENAME1)
                      FILENAME_S='CAR.BMP'
                      FILENAME_D=FILENAME1&'\CAR.BMP'
                      IF ~CopyFileA(FILENAME_S,FILENAME_D,0)
        !                 KLUDA(3,FILENAME_S&' uz '&FILENAME_D)  CAR.BMP VAR ARÎ NEBÛT...
                      .
                   .
                   DO CREATEPAVAD               !14 SALDO RAKSTS NOLIKTAVÂS
           !-----------------------------------------
                   BEGIN                        !15
                      LOOP N# = 1 TO ALGU_SK
                         RAKSTI+=2
                         ALGASNAME='ALGAS'&FORMAT(N#,@N02)
                         COPY(ALGAS,FILENAME1)
                         !Elya 22/12/2013 <
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(ALGAS)
                         CHECKOPEN(ALGAS,1)
                         RecordsToProcess = RECORDS(ALGAS)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Algas raksta veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(ALGAS,'QUICKSCAN=on')
                         CLEAR(ALG:Record,0)
                         SET(ALGAS)
                         LOOP
                            NEXT(ALGAS)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF GL:DB_GADS = 2013
                               ALG:PPF = ALG:PPF/0.702804
                               ALG:DZIVAP = ALG:DZIVAP/0.702804
                               ALG:IZDEV = ALG:IZDEV/0.702804
                               ALG:PARSKAITIT = ALG:PARSKAITIT/0.702804
                               ALG:IZMAKSAT = ALG:IZMAKSAT/0.702804
                               ALG:LMIA = ALG:LMIA/0.702804
                               ALG:LBER = ALG:LBER/0.702804
                               ALG:LINV = ALG:LINV/0.702804
                               LOOP I#=1 TO 20
                                  ALG:R[I#]     = ALG:R[I#]/0.702804
                               .
                               LOOP I#=1 TO 15
                                  ALG:C[I#]     = ALG:C[I#]/0.702804
                                  ALG:N[I#]     = ALG:N[I#]/0.702804
                               .
        
                               ALG:IIN = ALG:IIN/0.702804
                               PUT(ALGAS)
                            .
                         .
                         close(ALGAS)
                         IF SEND(ALGAS,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 22/12/2013 >
                         ALPANAME='ALGPA'&FORMAT(N#,@N02)
                         COPY(ALGPA,FILENAME1)
                         !Elya 22/12/2013 <
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(ALGPA)
                         CHECKOPEN(ALGPA,1)
                         RecordsToProcess = RECORDS(ALGPA)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Algas apr. raksta veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(ALGPA,'QUICKSCAN=on')
                         CLEAR(ALP:Record,0)
                         SET(ALGPA)
                         LOOP
                            NEXT(ALGPA)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF GL:DB_GADS = 2013
                               ALP:APRIIN = ALP:APRIIN/0.702804
                               ALP:IETIIN = ALP:IETIIN/0.702804
                               ALP:PARSKAITIT = ALP:PARSKAITIT/0.702804
                               ALP:IZMAKSAT = ALP:IZMAKSAT/0.702804
                               ALP:APGADSUM = ALP:APGADSUM/0.702804
                               ALP:AT_INV1 = ALP:AT_INV1/0.702804
                               ALP:AT_INV2 = ALP:AT_INV2/0.702804
                               ALP:AT_INV3 = ALP:AT_INV3/0.702804
                               ALP:AT_POLR = ALP:AT_POLR/0.702804
                               ALP:AT_POLRNP = ALP:AT_POLRNP/0.702804
                               ALP:MIA = ALP:MIA/0.702804
                               ALP:MINA = ALP:MINA/0.702804
                                PUT(ALGPA)
                            .
                         .
                         close(ALGPA)
                         IF SEND(ALGPA,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 22/12/2013 >
                      .
                      COPY(AMATI,FILENAME1)
                      COPY(CAL,FILENAME1)
                      COPY(DAIEV,FILENAME1)
                      !Elya 22/12/2013 <
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(DAIEV)
                      CHECKOPEN(DAIEV,1)
                      RecordsToProcess = RECORDS(DAIEV)
                      RecordsProcessed = 0
                      PercentProgress = 0
                      OPEN(ProgressWindow)
                      Progress:Thermometer = 0
                      ?Progress:PctText{Prop:Text} = '0%'
                      ProgressWindow{Prop:Text} = 'Algas apr. raksta veidoðana'
                      ?Progress:UserString{Prop:Text}=''
                      DISPLAY
                      SEND(DAIEV,'QUICKSCAN=on')
                      CLEAR(DAI:Record,0)
                      SET(DAIEV)
                      LOOP
                         NEXT(DAIEV)
                         IF ERROR() THEN BREAK.
                         DO Thermometer
                         IF GL:DB_GADS = 2013
                            IF ~(DAI:F = 'PIE')
                                DAI:TARL = DAI:TARL/0.702804
                            .
                            DAI:ALGA = DAI:ALGA/0.702804
                            PUT(DAIEV)
                         .
                      .
                      close(DAIEV)
                      IF SEND(DAIEV,'QUICKSCAN=off').
                      CLOSE(PROGRESSWINDOW)
                      SETPATH(TTAKA")
                      !Elya 22/12/2013 >
                      COPY(PERNOS,FILENAME1)
                      !Elya 22/12/2013 <
                      TTAKA"=LONGPATH()
                      SETPATH(FILENAME1)
                      close(PERNOS)
                      CHECKOPEN(PERNOS,1)
                      RecordsToProcess = RECORDS(PERNOS)
                      RecordsProcessed = 0
                      PercentProgress = 0
                      OPEN(ProgressWindow)
                      Progress:Thermometer = 0
                      ?Progress:PctText{Prop:Text} = '0%'
                      ProgressWindow{Prop:Text} = 'Vid. algas apr. raksta veidoðana'
                      ?Progress:UserString{Prop:Text}=''
                      DISPLAY
                      SEND(PERNOS,'QUICKSCAN=on')
                      CLEAR(PER:Record,0)
                      SET(PERNOS)
                      LOOP
                         NEXT(PERNOS)
                         IF ERROR() THEN BREAK.
                         DO Thermometer
                         IF GL:DB_GADS = 2013
                            PER:VSUMMA = PER:VSUMMA/0.702804
                            PER:VSUMMAS = PER:VSUMMAS/0.702804
                            PER:SUMMA = PER:SUMMA/0.702804
                            PER:SUMMA0 = PER:SUMMA0/0.702804
                            PER:SUMMA1 = PER:SUMMA1/0.702804
                            PER:SUMMA2 = PER:SUMMA2/0.702804
                            PER:SUMMAS = PER:SUMMAS/0.702804
                            PER:SUMMAX = PER:SUMMAX/0.702804
                            PUT(PERNOS)
                         .
                      .
                      close(PERNOS)
                      IF SEND(PERNOS,'QUICKSCAN=off').
                      CLOSE(PROGRESSWINDOW)
                      SETPATH(TTAKA")
                      !Elya 22/12/2013 >
                      COPY(GRAFIKS,FILENAME1)
                      DIRECTORY(DOSFILES,'*.JPG',FF_:NORMAL)
                      LOOP I#=1 TO RECORDS(DOSFILES)
                         GET(DOSFILES,I#)
                         ANSIFILENAME=A:NAME
                         COPY(OUTFILEANSI,FILENAME1)
                      .
                      FREE(DOSFILES)
                   .
           !-----------------------------------------
                   BEGIN                        !16
                      LOOP N# = 1 TO PAM_SK
                         RAKSTI+=3
                         PAMATNAME='PAMAT'&FORMAT(N#,@N02)
                         COPY(PAMAT,FILENAME1)
                         !Elya 22/12/2013 <
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(PAMAT)
                         CHECKOPEN(PAMAT,1)
                         RecordsToProcess = RECORDS(PAMAT)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Pamatlîdzekïu sarakstu veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(PAMAT,'QUICKSCAN=on')
                         CLEAR(PAM:Record,0)
                         SET(PAMAT)
                         LOOP
                            NEXT(PAMAT)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF GL:DB_GADS = 2013
                               PAM:IEP_V = PAM:IEP_V/0.702804
                               PAM:KAP_V = PAM:KAP_V/0.702804
                               PAM:NOL_V = PAM:NOL_V/0.702804
                               PAM:BIL_V = PAM:BIL_V/0.702804
                               LOOP I#=1 TO 15
                                  PAM:SAK_V_GD[I#]     = PAM:SAK_V_GD[I#]/0.702804
                                  PAM:NOL_GD[I#]     = PAM:NOL_GD[I#]/0.702804
                               .
                               PUT(PAMAT)
                            .
                         .
                         close(PAMAT)
                         IF SEND(PAMAT,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 22/12/2013 >
                         PAMKATNAME='PAMKAT'&FORMAT(N#,@N02)
                         COPY(PAMKAT,FILENAME1)
                         !Elya 22/12/2013 <
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(PAMKAT)
                         CHECKOPEN(PAMKAT,1)
                         RecordsToProcess = RECORDS(PAMKAT)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Pamatlîdzekïu kategoriju veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(PAMKAT,'QUICKSCAN=on')
                         CLEAR(PAK:Record,0)
                         SET(PAMKAT)
                         LOOP
                            NEXT(PAMKAT)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF GL:DB_GADS = 2013
                               LOOP I#=1 TO 15                                  !20
                                  LOOP K#=1 TO 6
                                     PAK:SAK_V[K#,I#] = PAK:SAK_V[K#,I#]/0.702804
                                     PAK:IEG_V[K#,I#] = PAK:IEG_V[K#,I#]/0.702804
                                     PAK:KAP_V[K#,I#] = PAK:KAP_V[K#,I#]/0.702804
                                     PAK:PAR_V[K#,I#] = PAK:PAR_V[K#,I#]/0.702804
                                     PAK:ATL_V[K#,I#] = PAK:ATL_V[K#,I#]/0.702804
                                     PAK:KOREKCIJA[K#,I#] = PAK:KOREKCIJA[K#,I#]/0.702804
                                     PAK:NOLIETOJUMS[K#,I#] = PAK:NOLIETOJUMS[K#,I#]/0.702804
                                     PAK:U_NOLIETOJUMS[K#,I#] = PAK:U_NOLIETOJUMS[K#,I#]/0.702804
                                  .
                               .
                               PUT(PAMKAT)
                            .
                         .
                         close(PAMKAT)
                         IF SEND(PAMKAT,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 22/12/2013 >
                         PAMAMNAME='PAMAM'&FORMAT(N#,@N02)
                         COPY(PAMAM,FILENAME1)
                         !Elya 22/12/2013 <
                         TTAKA"=LONGPATH()
                         SETPATH(FILENAME1)
                         close(PAMAM)
                         CHECKOPEN(PAMAM,1)
                         RecordsToProcess = RECORDS(PAMAM)
                         RecordsProcessed = 0
                         PercentProgress = 0
                         OPEN(ProgressWindow)
                         Progress:Thermometer = 0
                         ?Progress:PctText{Prop:Text} = '0%'
                         ProgressWindow{Prop:Text} = 'Pamatlîdzekïu raksta veidoðana'
                         ?Progress:UserString{Prop:Text}=''
                         DISPLAY
                         SEND(PAMAM,'QUICKSCAN=on')
                         CLEAR(AMO:Record,0)
                         SET(PAMAM)
                         LOOP
                            NEXT(PAMAM)
                            IF ERROR() THEN BREAK.
                            DO Thermometer
                            IF GL:DB_GADS = 2013
                               AMO:SAK_V_LI = AMO:SAK_V_LI/0.702804
                               AMO:NOL_G_LI = AMO:NOL_G_LI/0.702804
                               AMO:NOL_U_LI = AMO:NOL_U_LI/0.702804
                               AMO:NOL_LIN = AMO:NOL_LIN/0.702804
                               AMO:KAPREM = AMO:KAPREM/0.702804
                               AMO:PARCEN = AMO:PARCEN/0.702804
                               AMO:PARCENLI = AMO:PARCENLI/0.702804
                               AMO:IZSLEGTS = AMO:IZSLEGTS/0.702804
                               PUT(PAMAM)
                            .
                         .
                         close(PAMAM)
                         IF SEND(PAMAM,'QUICKSCAN=off').
                         CLOSE(PROGRESSWINDOW)
                         SETPATH(TTAKA")
                         !Elya 22/12/2013 >
                      .
                      COPY(KAT_K,FILENAME1)
                   .
                .
             END
          END
          IF RAKSTI
             KLUDA(0,'Faili='&clip(RAKSTI)&' Kïûdas='&CLIP(ERRK)&' Brîdinâjumi='&CLIP(BRIK)&' DB apstrâde veiksmîga',,1)
          ELSE
             KLUDA(0,'Faili='&clip(RAKSTI)&' DB NAV IZVEIDOTA')
          .
          BREAK
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('NYcreator','winlats.INI')
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
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
  END
  IF WindowOpened
    INISaveWindow('NYcreator','winlats.INI')
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
CREATEKONTUPLANU             ROUTINE
  !Elya 27/11/2013 <
  TTAKA"=LONGPATH()
  SETPATH(FILENAME1)
  close(KON_K)
  !KONKNAME=FILENAME1&'\KON_K'
  CHECKOPEN(KON_K,1)
  CLEAR(KON:Record,0)
  SET(KON:BKK_KEY)
  LOOP
     NEXT(KON_K)
     IF ERROR() THEN BREAK.
     IF (KON:VAL = 'Ls' OR KON:VAL = 'LVL') AND GL:DB_GADS >= 2013

        KON:VAL = 'EUR'
        PUT(KON_K)
     .
  .
  close(KON_K)
  SETPATH(TTAKA")
  !Elya 27/11/2013 >

CREATEPAVAD             ROUTINE
  kops_gads=gl_db_gads
  ERRP=0
  SAV_JOB_NR=JOB_NR
  CASE GL:FMI_TIPS
  OF 'VS'
     VS_FIFO='VS'
  ELSE
     VS_FIFO='FIFO'
  .
  close(pavad)
  close(NOLIK)
  LOOP N# = 1 TO NOL_SK
     PAVADNAME=FILENAME1&'\PAVAD'&FORMAT(N#,@N02)
     NOLIKNAME=FILENAME1&'\NOLIK'&FORMAT(N#,@N02)
!   stop(PAVADNAME)
     CHECKOPEN(PAVAD,1)
!   stop(NOLIKNAME)
     CHECKOPEN(NOLIK,1)
     CLEAR(PAV:Record,0)
     PAV:U_NR   =1
     GET(PAVAD,PAV:NR_KEY)
     IF ~ERROR()
!        IF RIDELETE:PAVAD()    !.neDRÎKST,JO RELÇTS SERVISS (filenames...)
        CLEAR(NOL:RECORD)
        NOL:U_NR=1
        SET(NOL:NR_KEY,NOL:NR_KEY)
        LOOP
           NEXT(NOLIK)
           IF ERROR() OR ~(NOL:U_NR=1) THEN BREAK.
           IF RIDELETE:NOLIK()
             KLUDA(26,'NOLIK-SALDO')
             ERRP+=1
             ERRK+=1
           .
        .
        PAV:DATUMS =GL_DB_S_DAT
        PAV:DOKDAT =PAV:DATUMS
        PAV:D_K ='D'
        !15/12/2013 PAV:VAL='Ls'
        IF GL:DB_GADS >= 2013
            PAV:VAL='EUR'
        ELSE
            PAV:VAL='Ls'
        .

        PAV:PAMAT='Atlikums uz '&format(pav:datums,@d06.)
        PUT(PAVAD)
     ELSE
        CLEAR(PAV:Record,0)
        PAV:U_NR   =1
        PAV:DATUMS =GL_DB_S_DAT
        PAV:DOKDAT =PAV:DATUMS
        PAV:D_K ='D'
        !15/12/2013 PAV:VAL='Ls'
        IF GL:DB_GADS >= 2013
            PAV:VAL='EUR'
        ELSE
            PAV:VAL='Ls'
        .
        PAV:PAMAT='Atlikums uz '&format(pav:datums,@d06.)
        add(pavad)
     .
     close(pavad)
     close(NOLIK)
     JOB_NR=N#+15
     CHECKOPEN(SYSTEM,1)
!     IF BAND(SYS:BAITS1,10000000B)          !ATGRIEZTU K Kontçt kâ ienâkoðo
!        SY_IS[N#]='I'
!     ELSE
!        SY_IS[N#]='S'
!     .
  .
  JOB_NR=SAV_JOB_NR
  CHECKOPEN(SYSTEM,1)

!  CHECKOPEN(NOL_FIFO,1)
!  NOL_FIFO::USED+=1
  CHECKOPEN(NOL_KOPS,1)
  NOL_KOPS::USED+=1

  RecordsToProcess = RECORDS(NOL_KOPS)
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Saldo raksta veidoðana Noliktavâs : '&CLIP(VS_FIFO)&' metode'
  ?Progress:UserString{Prop:Text}=''
  DISPLAY
  SEND(NOL_KOPS,'QUICKSCAN=on')
  CLEAR(KOPS:RECORD)
  SET(KOPS:NOM_KEY,KOPS:NOM_KEY)
  LOOP
     NEXT(NOL_KOPS)
     IF ERROR() THEN BREAK.
     DO Thermometer
     IF (BAND(REG_NOL_ACC,00010000b) AND GETNOM_K(KOPS:NOMENKLAT,0,16)='R') THEN CYCLE. !JA ATÏAUTA KOMPLEKTÂCIJA UN RAÞOJUMS
     !GETNOM_K(KOPS:NOMENKLAT,0,16)='V' AVANSS,DÂVANU KARTE JÂDOMÂ...

     ERR=GETBIL_FIFO(1,BILVERT,DAUDZUMS,ATLIKUMS_N) !SARÇÍINAM BIL-VERT UZ POZICIONÇTA NOL_KOPS
!     STOP(KOPS:NOMENKLAT&BILVERT&' '&ATLIKUMS_N[1])
     IF ERR=3  !NAV neSneD RAKSTU, LIETO PIC
        ERRP+=1
        BRIK+=1
     ELSIF ERR
        ERRP+=1
        ERRK+=1
     .
     IF (~ERR OR ERR=3) AND DAUDZUMS
        VID=BILVERT/DAUDZUMS
        LOOP N# = 1 TO NOL_SK
           IF ATLIKUMS_N[N#]
              NOLIKNAME=FILENAME1&'\NOLIK'&FORMAT(N#,@N02)
              CHECKOPEN(NOLIK,1)
              CLEAR(NOL:RECORD)
              NOL:U_NR=1
!              NOL:DATUMS =DATE(1,1,KOPS_gads+1)
              NOL:DATUMS =PAV:DATUMS
              NOL:NOMENKLAT=KOPS:NOMENKLAT
              NOL:D_K='D'
              NOL:DAUDZUMS=ATLIKUMS_N[N#]
              !15/12/2013 NOL:SUMMA=ROUND(VID*NOL:DAUDZUMS,.01)
              IF GL:DB_GADS = 2013
                  NOL:SUMMA=ROUND(VID*NOL:DAUDZUMS/0.702804,.01)
              ELSE
                  NOL:SUMMA=ROUND(VID*NOL:DAUDZUMS,.01)
              .

              NOL:SUMMAV=NOL:SUMMA
              !15/12/2013 NOL:VAL='Ls'
              IF GL:DB_GADS >= 2013
                  NOL:VAL='EUR'
              ELSE
                  NOL:VAL='Ls'
              .
              NOL:PVN_PROC=0
              NOL:ARBYTE=0
              ADD(NOLIK)
              RAKSTI+=1
              PAV_SUMMA[N#]+=NOL:SUMMA
              IF ERROR() THEN STOP('ADD NOLIK'&N#&' '&ERROR()).
              CLOSE(NOLIK)
           .
        .
     .
  .
  IF SEND(NOL_KOPS,'QUICKSCAN=off').
  LOOP N# = 1 TO NOL_SK
     IF PAV_SUMMA[N#] OR ERRP
        PAVADNAME=FILENAME1&'\PAVAD'&FORMAT(N#,@N02)
        CHECKOPEN(PAVAD,1)
        CLEAR(PAV:Record,0)
        PAV:U_NR =1
        GET(PAVAD,PAV:NR_KEY)
        IF ~ERROR()
           PAV:PAMAT='Saldo uz '&format(pav:datums,@d06.)&' '&VS_FIFO
!           PAV:PIELIK=CLIP(VS_FIFO)&' '&SY_IS
           PAV:PIELIK=CLIP(VS_FIFO)
           IF ERRP
              PAV:NOKA=CLIP(ERRP)&' kïûdas'
           ELSE
              PAV:NOKA=CLIP(ERRP)&' SALDO'
           .
           PAV:SUMMA=PAV_SUMMA[N#]
           PAV:SUMMA_B=PAV_SUMMA[N#]
           PAV:ACC_KODS=ACC_KODS
           PAV:ACC_DATUMS=TODAY()
           PUT(PAVAD)
        ELSE
           STOP('SALDO? NOL_NR='&N#)
        .
        close(pavad)
     .
  .
  CLOSE(PROGRESSWINDOW)
!  CLOSE(NOL_FIFO)
!  NOL_FIFO::USED=0
  CLOSE(NOL_KOPS)
  NOL_KOPS::USED=0

!-----------------------------------------------------------------------------
Thermometer ROUTINE
  RecordsProcessed += 1
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

