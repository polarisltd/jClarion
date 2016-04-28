                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETPAVADZ            FUNCTION (NR)                ! Declare Procedure
  CODE                                            ! Begin processed code
!
!  ATGRIEÞ LONG TRUE/FALSE
!

    IF PAVAD::USED=0
       CHECKOPEN(PAVAD,1)
    .
    PAVAD::USED+=1
    CLEAR(PAV:RECORD)
    PAV:U_NR=NR
    GET(PAVAD,PAV:NR_KEY)
    IF ERROR()
       RET#=1
       CLEAR(PAV:RECORD)
    .
    PAVAD::USED-=1
    IF PAVAD::USED=0
       CLOSE(PAVAD)
    .
    EXECUTE RET#+1
       RETURN(TRUE) !OK
       RETURN(FALSE)
    .
LOOKATL              FUNCTION (OPC)               ! Declare Procedure
ATLIK        decimal(12,3)
DATUMS       LONG
  CODE                                            ! Begin processed code
!
!  SARÇÍINA ATLIKUMUS UN K-PROJEKTUS(GL::SUMMA) TEKOÐÂ NOLIKTAVÂ
!  DRÎKST SAUKT TIKAI UZ POZICIONÇTA NOM_K
!
!  OPC : 1-PA VISU BÂZI
!        2-UZ KONKRÇTU DATUMU
!        3-UZ KONKRÇTU DATUMU kâ F(RST)
!
  SUMMA=0
  ATLIK=0
  CASE OPC
  OF 1
     DATUMS=999999
  OF 2
  OROF 3
     DATUMS=B_DAT
  ELSE
     STOP('OPC')
  .
  IF NOLIK::Used = 0        
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  CLEAR(NOL:RECORD)
  NOL:NOMENKLAT=NOM:NOMENKLAT
  SET(nol:NOM_key,nol:NOM_key)
  LOOP
     NEXT(NOLIK)
     IF ERROR() OR ~(NOL:NOMENKLAT=NOM:NOMENKLAT) OR ~(NOL:DATUMS<=DATUMS) THEN BREAK.
     IF OPC=3 AND ((RS='A' AND NOL:RS='1') OR (RS='N' AND NOL:RS='')) THEN CYCLE. ! NOL:RS=0- APSTIPRINÂTIE
     CASE NOL:D_K
     OF 'D'
        ATLIK += NOL:DAUDZUMS
     OF 'K'
        ATLIK -= NOL:DAUDZUMS
     OF 'P'
        SUMMA += NOL:DAUDZUMS
     .
  .
  NOLIK::Used -= 1
  IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  RETURN(ATLIK)
SPZ_PavadD           PROCEDURE                    ! Declare Procedure
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
LBKURSS              DECIMAL(14,6)
LSSUMMA              DECIMAL(12,2)
AKCSUM               DECIMAL(9,2)
AKCSUM1              DECIMAL(9,2)
LIC_NR               STRING(13)
LIC_SERIJA           STRING(2)
LIC_DER              STRING(10)
PVN_reg              STRING(13)
PAR_IZ_V             STRING(60)
ATLAIDE              REAL
AN                   REAL
!!NOSAUKUMS            STRING(15)
RPT_NPK              DECIMAL(3)
RPT_GADS             STRING(4)
GADS1                STRING(1)
DATUMS               STRING(2)
gov_reg              STRING(40)
RPT_CLIENT           STRING(45)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
KEKSIS               STRING(1)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
NOS_P                STRING(45)
ADRESE1              STRING(60)
PAR_BANKA            STRING(31)
ATLAUJA              STRING(15)
CONS                 STRING(15)
CONS1                STRING(15)
NPK                  STRING(3)
NOMENK               STRING(21)
NOM_SER              STRING(21)
DAUDZUMS             DECIMAL(12,3)
DAUDZUMSK            DECIMAL(12,3)
DAUDZUMS_S           STRING(15)
DAUDZUMSK_S          STRING(15)
CENA                 DECIMAL(16,5)
CENA_S               STRING(15)
SUMMA_B              DECIMAL(16,4)
SUMMA_BS             STRING(15)
KOPA                 STRING(15)
IEPAK_DK             DECIMAL(3)
SUMK_B               DECIMAL(13,2)
SUMK_PVN             DECIMAL(13,2)
SUMK_APM             DECIMAL(13,2)
PAV_T_SUMMA          DECIMAL(12,2)
PAV_T_PVN            DECIMAL(12,2)
SVARS                DECIMAL(9,2)
SUMV                 STRING(112)
PLKST                TIME
PAV_AUTO             STRING(80)
RET                  BYTE
LINE                 STRING(132)
SYS_PARAKSTS         STRING(25)
MENESIS              STRING(10)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(146,398,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
DETAIL0 DETAIL,AT(,,,1000)
       END
PAGE_HEAD DETAIL,AT(,,,2708),USE(?unnamed)
         STRING(@d6b),AT(2552,2396,625,156),USE(pav:c_datums),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(6771,2448,833,208),USE(PVN_reg),HIDE,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Licence degvielas ieveðanai un vairumtirdzniecîbai :'),AT(365,938,2708,156),USE(?String1:18), |
             LEFT
         LINE,AT(7865,313,0,2031),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('08. Speciâlas atzîmes'),AT(4115,2396,1146,156),USE(?String1:17),LEFT
         STRING('Samaksas kârtîba'),AT(365,2552,938,156),USE(?String1:23),LEFT
         STRING(@s15),AT(1458,2552,990,156),USE(cons1),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(729,2135,208,156),USE(LIC_SERIJA),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Licence degvielas ieveðanai un vairumtirdzniecîbai :'),AT(365,1979,2708,156),USE(?String1:15), |
             LEFT
         STRING('Sçrija'),AT(365,2135,365,156),USE(?String1:20),LEFT
         STRING(@s50),AT(1458,625,3698,156),USE(adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2344,7760,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s60),AT(365,52,7552,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(5365,2135,781,208),USE(par_ban_kods),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Derîga lîdz'),AT(2344,2135,573,156),USE(?String1:22),LEFT
         STRING('Kods'),AT(4948,2135,313,208),USE(?String1:6),LEFT
         STRING(@s21),AT(5365,1875,1490,208),USE(par_ban_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(5313,1354,2552,208),USE(gov_reg),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Konts'),AT(4948,1875,313,208),USE(?String1:14),LEFT
         STRING('Konts'),AT(5313,729,313,208),USE(?String1:5),LEFT
         STRING(@s11),AT(5729,1042,781,208),USE(BKODS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1302,7760,0),USE(?Line5),COLOR(COLOR:Black)
         STRING('04. Preèu saòçmçjs'),AT(156,1354,1042,156),USE(?String1:10),LEFT
         STRING(@s21),AT(5729,729,1604,208),USE(REK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(5313,1042,313,208),USE(?String1:7),LEFT
         STRING(@s45),AT(1250,313,3490,156),USE(RPT_client),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(5313,417,313,208),USE(?String1:8),LEFT
         STRING(@s13),AT(6510,417,833,208),USE(fin_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegðanas vieta'),AT(365,625,1094,156),USE(?String1:3),LEFT
         STRING('03. Norçíinu rekvizîti'),AT(156,781,1094,156),USE(?String1:4),LEFT
         STRING(@s31),AT(1458,781,2344,156),USE(BANKA),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,313,2604,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(5260,313,0,2031),USE(?Line81),COLOR(COLOR:Black)
         STRING('07. Samaksas veids'),AT(156,2396,1094,156),USE(?String1:16),LEFT
         STRING(@s15),AT(1458,2396,990,156),USE(cons),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s31),AT(1250,1823,2344,156),USE(par_banka),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Serija'),AT(365,1094,365,156),USE(?String1:19),LEFT
         STRING(@s60),AT(1302,1510,3802,156),USE(adrese1),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(2969,2135,781,156),USE(lic_der),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(938,2135,208,156),USE(?String1:21),RIGHT
         STRING(@s60),AT(1302,1667,3802,156),USE(PAR_IZ_V),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(1198,2135,1094,156),USE(LIC_nr),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Izkrauðanas vieta'),AT(365,1667,938,156),USE(?String1:9),LEFT
         STRING(@s45),AT(729,1094,3333,156),USE(sys:atlauja),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1198,1354,3542,156),USE(nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,2344,0,365),USE(?Line8),COLOR(COLOR:Black)
         STRING('06. Norçíinu rekvizîti'),AT(156,1823,1094,156),USE(?String1:12),LEFT
         STRING('Kods'),AT(4948,1354,313,208),USE(?String1:13),LEFT
         STRING('05. Adrese'),AT(156,1510,625,156),USE(?String1:11),LEFT
         STRING(@s11),AT(5729,417,729,208),USE(reg_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s47),AT(1250,469,3490,156),USE(ju_adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('01. Preèu nosûtîtâjs'),AT(156,313,1094,156),USE(?String1),LEFT
         STRING('02. Juridiskâ adrese'),AT(156,469,1094,156),USE(?String1:2),LEFT
       END
TEKSTS DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(4010,-10,0,197),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@s60),AT(4115,10,3802,156),USE(TEXteksts),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
PAGE_HEAD1 DETAIL,AT(,,,354)
         LINE,AT(2344,52,0,313),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(4271,52,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(4740,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(5469,52,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(6354,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7500,52,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         STRING('09. Preèu nosaukums'),AT(417,104,1927,208),USE(?String38:2),CENTER
         STRING(@s21),AT(2396,104,1615,208),USE(nom_SER),CENTER
         STRING('Iep'),AT(4063,104,208,208),USE(?String38:4),CENTER
         STRING('10.Mçr.'),AT(4323,104,417,208),USE(?String38:5),CENTER
         STRING('11. Daudz.'),AT(4844,104,625,208),USE(?String38:6),CENTER
         STRING('12. Cena'),AT(5521,104,833,208),USE(?String38:7),CENTER
         STRING('13. Summa'),AT(6406,104,1094,208),USE(?String38:8),CENTER
         STRING('PVN'),AT(7552,104,313,208),USE(?String38:3),CENTER
         LINE,AT(4010,0,0,374),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(104,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(365,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,104,188,208),USE(?String38),CENTER
         LINE,AT(104,313,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,156)
         LINE,AT(2344,-10,0,176),USE(?Line8:30),COLOR(COLOR:Black)
         STRING(@s21),AT(2396,0,1615,156),USE(nomenk),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4010,-10,0,176),USE(?Line8:29),COLOR(COLOR:Black)
         STRING(@n_3.0b),AT(4063,0,156,156),USE(nol:iepak_d),RIGHT
         LINE,AT(4271,-10,0,176),USE(?Line8:12),COLOR(COLOR:Black)
         STRING(@s6),AT(4323,0,417,156),USE(nom:mervien),LEFT
         LINE,AT(4740,-10,0,176),USE(?Line8:25),COLOR(COLOR:Black)
         STRING(@S15),AT(4792,0,625,156),USE(daudzums_S),RIGHT
         LINE,AT(5469,-10,0,176),USE(?Line8:26),COLOR(COLOR:Black)
         STRING(@S15),AT(5521,0,781,156),USE(cena_S),RIGHT
         LINE,AT(6354,-10,0,176),USE(?Line8:27),COLOR(COLOR:Black)
         STRING(@S15),AT(6406,0,781,156),USE(summa_bS),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(nol:val),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line8:23),COLOR(COLOR:Black)
         STRING(@n2),AT(7552,0,156,156),USE(nol:pvn_proc),RIGHT
         STRING('%'),AT(7708,0,156,156),USE(?String38:9),LEFT
         LINE,AT(7865,-10,0,176),USE(?Line8:28),COLOR(COLOR:Black)
         STRING(@s30),AT(417,0,1927,156),USE(NOM:NOS_P),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s3),AT(156,0,208,156),USE(RPT_npk),RIGHT
       END
BLANK  DETAIL,AT(,-10,,156)
         LINE,AT(2344,0,0,176),USE(?Line8:130),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,176),USE(?Line8:39),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,176),USE(?Line8:38),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,176),USE(?Line8:37),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,176),USE(?Line8:36),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,176),USE(?Line8:35),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,176),USE(?Line8:33),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,176),USE(?Line8:34),COLOR(COLOR:Black)
         LINE,AT(365,0,0,176),USE(?Line8:131),COLOR(COLOR:Black)
         LINE,AT(104,0,0,176),USE(?Line8:132),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(104,0,0,104),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(365,0,0,104),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2344,0,0,104),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,104),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,104),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,104),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,104),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,104),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,104),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,104),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,156)
         LINE,AT(2344,-10,0,176),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(4010,-10,0,176),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@n3b),AT(4063,0,156,156),USE(iepak_dk),RIGHT
         LINE,AT(4271,-10,0,176),USE(?Line8:24),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,176),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5469,-10,0,176),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,176),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@n-_13.2),AT(6406,0,781,156),USE(sumk_b),RIGHT
         STRING(@s3),AT(7240,0,260,156),USE(PAV:val),LEFT
         LINE,AT(7500,-10,0,176),USE(?Line8:19),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,176),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@s15),AT(4792,0,625,156),USE(daudzumsK_s),RIGHT
         STRING(@s20),AT(417,0,1510,156),USE(kopa),LEFT
         LINE,AT(365,-10,0,176),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,176),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,406)
         STRING('nomaksâts budþetâ.'),AT(2240,156,1198,208),USE(?String38:12),CENTER
         LINE,AT(104,0,0,52),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2344,0,0,52),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,52),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,52),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,52),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:7),COLOR(COLOR:Black)
         STRING('15. Akcîzes nodoklis'),AT(156,156,1198,208),USE(?String38:10),CENTER
         STRING(@n_9.2),AT(1354,156,625,208),USE(AkcSum),RIGHT
         STRING('Ls'),AT(2031,156,208,208),USE(?String38:11),LEFT
       END
RPT_FOOT31 DETAIL,AT(,-10,,667)
         LINE,AT(104,0,0,52),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(365,0,0,52),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(2344,0,0,52),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,52),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,52),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,52),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(5469,0,0,52),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(6354,0,0,52),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,52),USE(?Line62),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:6),COLOR(COLOR:Black)
         STRING('Visas cenas uzrâdîtas, òemot vçrâ pieðíirto atlaidi par kopçjo summu'),AT(156,417,3542,208), |
             USE(?String62),LEFT,FONT(,8,,)
         STRING('nomaksâts budþetâ.'),AT(2240,156,1198,208),USE(?String38:15),CENTER
         STRING('Ls'),AT(2031,156,208,208),USE(?String38:14),LEFT
         STRING(@n_9.2),AT(1354,156,625,208),USE(AkcSum1),RIGHT
         STRING(@n-_10.2),AT(3750,417,625,208),USE(pav:summa_A),RIGHT
         STRING(@s3),AT(4427,417,260,208),USE(pav:val,,?pav:val:7),LEFT
         STRING('15. Akcîzes nodoklis'),AT(156,156,1198,208),USE(?String38:13),CENTER
       END
RPT_FOOT32 DETAIL,AT(,,,302)
         STRING('Preèu, taras svars :'),AT(156,52,1094,208),USE(?String62:2),LEFT
         STRING(@n_9.2),AT(1302,52,625,208),USE(svars),RIGHT
         STRING('kg.'),AT(1979,52,208,208),USE(?String62:3),LEFT
       END
RPT_FOOT33 DETAIL,AT(,,,281)
         STRING('Transporta pakalpojumi :'),AT(156,52,1302,208),USE(?String62:4),LEFT
         STRING(@n-_12.2),AT(6406,52,781,208),USE(pav_T_summa),RIGHT
         STRING(@s3),AT(7240,52,260,208),USE(pav:val,,?pav:val:4),LEFT
       END
RPT_FOOT4 DETAIL,AT(,,,708)
         STRING('17. Pievienotâs vçrtîbas nodoklis '),AT(156,52,2031,208),USE(?String62:5),LEFT
         STRING('18. Pavisam apmaksai'),AT(156,260,2031,208),USE(?String62:6),LEFT
         STRING('(ar cipariem)'),AT(5625,260,677,208),USE(?String62:8),LEFT
         STRING(@n-_13.2),AT(6354,260,833,208),USE(sumk_APM),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7240,260,260,208),USE(pav:val,,?pav:val:3),LEFT
         STRING('(ar vârdiem)'),AT(156,469,677,208),USE(?String62:7),LEFT
         STRING(@s112),AT(833,469,7135,208),USE(sumV),LEFT,COLOR(0D3D3D3H)
         STRING(@n-_13.2),AT(6354,52,833,208),USE(sumk_PVN),RIGHT
         STRING(@s3),AT(7240,52,260,208),USE(pav:val,,?pav:val:2),LEFT
       END
PPR_TXT DETAIL,AT(,,,156)
         STRING(@s132),AT(156,0,7604,145),USE(LINE),LEFT
       END
RPT_FOOT5 DETAIL,AT(,,,1292)
         STRING('Z. V.'),AT(729,1094,521,208),USE(?String62:21),LEFT
         STRING('Z. V.'),AT(4427,1094,521,208),USE(?String62:22),LEFT
         LINE,AT(729,1042,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(4427,1042,2656,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s25),AT(1146,521,2552,208),USE(sys_paraksts),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,52,7760,0),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(3750,52,0,1250),USE(?Line76),COLOR(COLOR:Black)
         STRING('20. Pieòçma :'),AT(3906,104,781,208),USE(?String62:13),LEFT
         STRING('19. Preèu piegâdes vai pakalpojumu sniegðanas datums:'),AT(156,104,3542,208),USE(?String62:11), |
             LEFT
         STRING('Vârds, uzvârds'),AT(3906,313,885,208),USE(?String62:14),LEFT
         STRING('Vârds, uzvârds'),AT(208,521,885,208),USE(?String62:12),LEFT
         LINE,AT(4792,469,2188,0),USE(?Line77),COLOR(COLOR:Black)
         STRING(@s4),AT(292,313,313,208),USE(RPT_GADS),RIGHT
         STRING('. gada  "'),AT(604,313,417,208),USE(?String62:15),LEFT
         STRING(@n2),AT(1021,313,156,208),USE(datums),RIGHT
         STRING('"'),AT(1198,313,104,208),USE(?String62:16),LEFT
         STRING(@s10),AT(1333,313,677,208),USE(menesis),LEFT
         STRING('. gada  "'),AT(4271,573,417,208),USE(?String62:17),LEFT
         STRING('"'),AT(4948,573,104,208),USE(?String62:18),LEFT
         LINE,AT(3906,729,365,0),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(4688,729,260,0),USE(?Line78:2),COLOR(COLOR:Black)
         LINE,AT(5052,729,1615,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING('Paraksts'),AT(208,885,521,208),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(3906,885,521,208),USE(?String62:20),LEFT
       END
RPT_FOOT41 DETAIL,AT(,,,281)
         STRING('a/m, vadîtâjs'),AT(208,52,677,208),USE(?String62:9),LEFT
         STRING(@s80),AT(885,52,4531,208),USE(pav_auto),LEFT
         STRING('Pielikumâ :'),AT(5521,52,573,208),USE(?String62:10),LEFT
         STRING(@s21),AT(6094,52,1615,208),USE(pav:pielik),LEFT
       END
       FOOTER,AT(146,11400,8000,52)
         LINE,AT(104,0,7760,0),USE(?Line5:9),COLOR(COLOR:Black)
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
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CHECKOPEN(BANKAS_K,1)
  NPK=0
  rpt_gads=year(pav:datums)
  datums=day(pav:datums)
  menesis=MENVAR(pav:datums,2,2)
  plkst=clock()
  KESKA=' {120}'
  GETMYBANK('')
  CASE PAV:APM_V
  OF '1'
    CONS1='Priekðapmaksa'
  OF '2'
    CONS1='Pçcapmaksa'
  OF '3'
    CONS1='Konsignâcija'
  OF '4'
    CONS1='Apmaksa uzreiz'
  END
  CASE PAV:APM_K
  OF '1'
    CONS = 'Pârskaitîjums'
  OF '2'
    CONS = 'Skaidrâ naudâ'
  OF '3'
    CONS = 'Barters'
  END
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
  OF 'K'
    nom_ser='Kods'
    RET=4
  OF 'C'  
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .
  PAV_AUTO=GETAUTO(PAV:VED_NR,4)
! SAÒÇMÇJS
  PAR:NOS_P=GETPAR_K(PAV:PAR_NR,2,2)
  CASE PAV:D_K
  OF 'D'
    beep
    return
  .
  RPT_CLIENT=CLIENT
  JU_ADRESE=GL:ADRESE
  ADRESE=CLIP(SYS:ADRESE)&' t.'&clip(sys:tel)
  reg_nr=gl:reg_nr
  fin_nr=gl:VID_NR
  RPT_BANKA=BANKA
! RPT:BKODS=BKODS
  RPT_REK  =REK
! RPT:ATLAUJA =SYS:ATLAUJA
  NOS_P=PAR:NOS_P
  gov_reg=GETPAR_K(PAV:PAR_NR,0,21)
  PVN_reg=PAR:PVN
  par_iz_v = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
  LIC_SERIJA=SUB(PAV:PAMAT,1,2)
  LIC_NR    =SUB(PAV:PAMAT,3,13)
  LIC_DER   =SUB(PAV:PAMAT,16,10)
  ADRESE1=PAR:ADRESE
! RPT:NOLIKTAVA=SYS:AVOTS
  checkopen(bankas_k)
  clear(ban:record)
  IF F:PAK = '2'   !F:PAK NO SELPZ
     PAR_ban_kods=par:ban_kods2
     par_ban_nr=par:ban_nr2
  ELSE
     PAR_ban_kods=par:ban_kods
     par_ban_nr=par:ban_nr
  .
!  get(bankas_k,ban:kod_key)
!  par_BAN_kods=ban:kods
  par_banka=GETBANKAS_K(PAR_BAN_KODS,2,1)
  SYS_PARAKSTS=GETPARAKSTI(SYS_PARAKSTS_NR,1)

 LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND(PAV:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'pavadzîme'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR=PAV:U_NR'
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
      PRINT(RPT:DETAIL0)
      PRINT(RPT:PAGE_HEAD)
      LOOP I#=1 TO 3
         TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,I#)
         IF TEXTEKSTS
            PRINT(RPT:TEKSTS)
         .
      .
      PRINT(RPT:PAGE_HEAD1)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nomenk=GETNOM_K(NOL:NOMENKLAT,2,RET)
        SVARS+=GETNOM_K(NOL:NOMENKLAT,0,22)*nol:daudzums
        fillpvn(1)
        DAUDZUMS = ROUND(NOL:DAUDZUMS,.001)
        DAUDZUMS_S=CUT0(DAUDZUMS,3,0)
        IF NOL:DAUDZUMS=0
          cena = calcsum(3,5)
        ELSE
          cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)
        .
        IF ~NOL:ATLAIDE_PR AND INRANGE(GETNOM_K(NOL:NOMENKLAT,0,7)-CENA,-0.01,0.01)
           CENA=GETNOM_K(NOL:NOMENKLAT,0,7)
        .
        CENA_S=CUT0(CENA,5,2)
        SUMMA_B = calcsum(3,4)
        SUMMA_BS=CUT0(SUMMA_B,4,2)
        IF SUMMA_BS[15]='0'
            SUMMA_BS[15]=CHR(32)
            IF SUMMA_BS[14]='0'
                SUMMA_BS[14]=CHR(32)
            END
        END
        AKCSUM+= NOL:DAUDZUMS*NOM:REALIZ[4]
        iepak_DK  += nol:iepak_d
        DAUDZUMSK += DAUDZUMS
        NPK+=1
        IF NPK<99
          RPT_NPK=FORMAT(NPK,@N2)&'.'
        ELSE
          RPT_NPK=FORMAT(NPK,@N3)
        .
        PRINT(RPT:DETAIL)                            !  PRINT DETAIL LIS
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    AKCSUM1=akcsum
!************************* KOPÂ & T.S.********
    DAUDZUMSK_S=CUT0(DAUDZUMSK,3,0)
    PRINT(RPT:RPT_FOOT1)
    SUMK_B=ROUND(GETPVN(3),.01)
    kopa='Kopâ:'
    PRINT(RPT:RPT_FOOT2)
    IF GETPVN(20)  ! IR VAIRÂK PAR VIENU PREÈU TIPU
      IEPAK_DK=0
      DAUDZUMSK_S=''
      LOOP I#=4 TO 9
        SUMK_B=ROUND(GETPVN(I#),.01)
        IF SUMK_B <> 0
          EXECUTE I#-3
            kopa='t.s. prece'
            kopa='t.s. tara '
            kopa='t.s. pakalpojumi'
            kopa='t.s. kokmateriâli'
            kopa='t.s. raþojumi'
            kopa='t.s. citi'
          .
          PRINT(RPT:RPT_FOOT2)
        .
      .
    .
!************************* ATLAIDE ***********
    IF PAV:SUMMA_A <= 0
      PRINT(RPT:RPT_FOOT3)
    ELSE
      PRINT(RPT:RPT_FOOT31)
    .
!************************* SVARS ***********
    IF SVARS AND BAND(SYS:BAITS1,00010000B)
       PRINT(RPT:RPT_FOOT32)
    .
!************************* TRANSPORTS ***********
    IF pav:t_summa > 0
!      PAV_T_SUMMA=ROUND(pav:t_summa/(1+PAV:T_PVN/100),.01)                  !TRANSPORTS BEZ PVN
      PAV_T_SUMMA=PAV:T_SUMMA-ROUND(pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01) !10/03/03
      PRINT(RPT:RPT_FOOT33)
    .
!************************* PVN ***********
!   RPT:SUMK_PVN= ROUND(SUMK_AN-SUMK_BN+pav:t_summa*(1-1/(1+PAV:T_AN/100)),.01)
    SUMK_PVN = ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)
!************************* SUMMA VÂRDIEM ***********
!    IF ~INRANGE(PAV:SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)
    IF ~INRANGE(PAV:SUMMA-PAV:T_SUMMA-GETPVN(3)-GETPVN(1),-0.02,0.02)   !10/03/03
      STOP('Nesakrît Summas')
!     kluda(74,'')
!     print(rpt:rpt_err)
!     CLOSE(REPORT)
!     RETURN
    .
    SUMK_B=ROUND(GETPVN(3),.01)
    SUMK_APM=SUMK_B+SUMK_PVN+PAV_T_SUMMA
    SUMV=SUMVAR(SUMK_APM,PAV:VAL,0)
    PRINT(RPT:RPT_FOOT4)
    IF PAV_AUTO OR PAV:PIELIK
        PRINT(RPT:RPT_FOOT41)
    END
!***************************PPR_TXT********************
    IF F:DTK
        checkopen(OUTFILEANSI)
        SET(OUTFILEANSI)
        LOOP
           NEXT(OUTFILEANSI)
           IF ERROR() THEN BREAK.
           LINE=OUTA:LINE
           PRINT(RPT:PPR_TXT)
        .
    .
    close(OUTFILEANSI)
!***************************************************
    PRINT(RPT:RPT_FOOT5)
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
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
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
!*************************************************************************
!*************************************************************************
