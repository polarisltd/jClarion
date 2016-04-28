                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetKadri             FUNCTION (IDE,REQ,RET,<DAV>) ! Declare Procedure
VAR      LIKE(KAD:VAR)
UZV      LIKE(KAD:UZV)
VECUMS   STRING(6)
  CODE                                            ! Begin processed code
 !
 !  ID  - PIEPRASÎTAIS KADRU ID
 !  REQ - 0 ATGRIEÞ TUKÐUMU UN NOTÎRA RECORD
 !        1 IZSAUC BROWSE
 !        2 IZSAUC KÏÛDU
 !  RET - 1-20
 !       .
 !       6-PPF_PROC
 !       .
 !       16-OBJ_NR
 !       17-BKODS1
 !       18-ADRESE
 !       19-SLODZE UZ KONKRÇTO DAV
 !       20-DZIVAP_PROC
 !  DAV - DARBA APMAKSAS VEIDS
 !

 IF ~INRANGE(RET,1,20)
    RETURN('')
 .
 IF IDE=0 AND ~REQ   !SPEC
    CLEAR(KAD:RECORD)
    RETURN('')
 .
 IF KADRI::Used = 0
   CheckOpen(KADRI,1)
 END
 KADRI::Used += 1
 CLEAR(KAD:RECORD)
 KAD:ID=IDE
 GET(KADRI,KAD:ID_KEY)
 IF ERROR()
    IF REQ = 2
       KLUDA(59,IDE)
       CLEAR(KAD:RECORD)
    ELSIF REQ = 0
       CLEAR(KAD:RECORD)
    ELSE
       globalrequest=Selectrecord
       BROWSEKADRI
       IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
          CLEAR(KAD:RECORD)
       .
    .
 .
 KADRI::Used -= 1
 IF KADRI::Used = 0 THEN CLOSE(KADRI).
 EXECUTE RET
    RETURN(clip(kad:var)&' '&clip(kad:uzv))   !VÂRDS,UZVÂRDS
    RETURN(KAD:ID)
    RETURN(clip(kad:uzv)&' '&clip(kad:var))   !UZVÂRDS,VÂRDS
    RETURN(KAD:REK_NR1)
    RETURN(KAD:NODALA)                        !5
    RETURN(KAD:PPF_PROC)                      !6
    RETURN(KAD:D_GR_END)                      !7
    RETURN(KAD:DZIM)                          !8
    RETURN(clip(kad:uzv))                     !9 UZVÂRDS
    RETURN(kad:V_KODS)                        !10
    RETURN(KAD:AMATS)                         !11
    RETURN(KAD:DARBA_GR)                      !12
    BEGIN                                     !13-KAM?
       IF KAD:DZIM='S'
          IF ~INRANGE(VAL(KAD:VAR[LEN(CLIP(KAD:VAR))]),97,122) !mazie angïu burti
             VAR=KAD:VAR
          ELSE
             VAR=KAD:VAR[1:LEN(CLIP(KAD:VAR))]&'i'
          .
          IF ~INRANGE(VAL(KAD:UZV[LEN(CLIP(KAD:UZV))]),97,122) !mazie angïu burti
             UZV=KAD:UZV
          ELSE
             UZV=KAD:UZV[1:LEN(CLIP(KAD:UZV))]&'i'
          .
          RETURN(CLIP(VAR)&' '&UZV)
       ELSE
          IF ~INRANGE(VAL(KAD:VAR[LEN(CLIP(KAD:VAR))]),97,122) !mazie angïu burti
             VAR=KAD:VAR
          ELSIF KAD:VAR[LEN(CLIP(KAD:VAR))-1:LEN(CLIP(KAD:VAR))]='is'
             VAR=KAD:VAR[1:LEN(CLIP(KAD:VAR))-1]&'m'
          ELSE
             VAR=KAD:VAR[1:LEN(CLIP(KAD:VAR))-1]&'am'
          .
          IF ~INRANGE(VAL(KAD:UZV[LEN(CLIP(KAD:UZV))]),97,122) !mazie angïu burti
             UZV=KAD:UZV
          ELSIF KAD:UZV[LEN(CLIP(KAD:UZV))-1:LEN(CLIP(KAD:UZV))]='is'
             UZV=KAD:UZV[1:LEN(CLIP(KAD:UZV))-1]&'m'
          ELSE
             UZV=KAD:UZV[1:LEN(CLIP(KAD:UZV))-1]&'am'
          .
          RETURN(CLIP(VAR)&' '&UZV)
       .
    .
    RETURN(KAD:PERSKOD) !######-#####          !14
    BEGIN                                      !15
       IF ~KAD:PERSKOD
          KLUDA(87,' personas kods '& CLIP(KAD:VAR)&' '&KAD:UZV)
          RETURN('30') !KAS CITS ATLIEK......
       .
       VECUMS=AGE(DATE(KAD:PERSKOD[3:4],KAD:PERSKOD[1:2],KAD:PERSKOD[5:6]),alg:YYYYMM)
       IF INSTRING('YRS',VECUMS,1)
!          STOP(KAD:UZV&VECUMS[1:2])
          RETURN(VECUMS[1:2])
       ELSE
          RETURN('')
       .
    .
    RETURN(KAD:OBJ_NR)                         !16
    RETURN(KAD:BKODS1)                         !17
    RETURN(KAD:PIERADR)                        !18
    BEGIN                                      !19 SLODZE
       LOOP I#=1 TO 20
!          STOP(KAD:ID&' '&KAD:PIESKLIST[I#]&' '&DAV)
          IF ~KAD:PIESKLIST[I#] THEN BREAK.
          IF KAD:PIESKLIST[I#]=DAV
             EXECUTE KAD:SLODZE[I#]+1
                RETURN('1')
                RETURN('0.5')
                RETURN('0.333333')
                RETURN('0.25')
             .
          .
       .
       RETURN('1')  !?
    .
    RETURN(KAD:DZIVAP_PROC)                    !20
 .
P_PamKar3P           PROCEDURE                    ! Declare Procedure
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

VERT_S               SREAL
uzsk_v               SREAL
KAT_NR               STRING(4)
LIKME                STRING(10)
DAT                  LONG
LAI                  LONG
!       Pçc ailes numura
S1                   LONG
S2                   decimal(12,2)
S3                   DECIMAL(11,2)
S4                   DECIMAL(11,2)
s5                   decimal(11,2)
S6                   DECIMAL(11,2)
s7                   decimal(11,2)
S8                   DECIMAL(11,2)
S9                   DECIMAL(11,2)
s10                  decimal(11,2)
S11                  DECIMAL(2)
S12                  string(20)
S13                  DECIMAL(12,2)
s14                  decimal(11,2)
s15                  decimal(11,2)
VIRSRAKSTS           STRING(100)

!---------------------------------------------------------------------------------------------
report REPORT,AT(200,2627,12000,5302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(200,398,12000,2229),USE(?unnamed)
         STRING('Nodokïiem'),AT(9979,125),USE(?String70:2),CENTER
         LINE,AT(10552,104,0,208),USE(?Line62:4),COLOR(COLOR:Black)
         LINE,AT(9896,313,656,0),USE(?Line62),COLOR(COLOR:Black)
         STRING(@s45),AT(2656,104,4740,208),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(9896,104,0,208),USE(?Line62:3),COLOR(COLOR:Black)
         LINE,AT(9896,104,656,0),USE(?Line62:2),COLOR(COLOR:Black)
         STRING(@s100),AT(250,417,9594,219),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('(EUR)'),AT(10052,469),USE(?String70:3)
         LINE,AT(208,729,0,1510),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(885,729,0,1510),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(1771,729,0,1510),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2604,729,0,1510),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3854,729,0,1510),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5729,729,0,1510),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6458,729,0,1510),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,1510),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7552,729,0,1510),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(9271,729,0,1510),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(9844,729,0,1510),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(10573,729,0,1510),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Finansu'),AT(240,781,625,260),USE(?String18:29),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('gads'),AT(240,1042,625,260),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes'),AT(917,781,833,260),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(917,1042,833,260),USE(?String18:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kapitâlâs'),AT(1802,781,781,260),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(1802,1042,781,260),USE(?String18:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrtçðana'),AT(2635,781,1198,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(3885,781,1823,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kategorijas'),AT(5760,781,677,156),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('koriìçtâ'),AT(5760,938,677,156),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2604,990,3125,0),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(3229,990,0,1250),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(4479,990,0,1250),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(5104,990,0,1250),USE(?Line2:14),COLOR(COLOR:Black)
         STRING('nolietojums'),AT(7583,990,1667,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Likme % (dubultotâ)'),AT(7219,781,313,1198),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Taksâcijas perioda'),AT(7573,792,1667,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkrâtais nolietojums'),AT(9302,781,260,1198),USE(?String18:51),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('nodokïiem'),AT(9563,781,260,1198),USE(?String18:52),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('Atlikusî'),AT(9875,781,677,156),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('"+"'),AT(2635,1042,573,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('"-"'),AT(3260,1042,573,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('sâkotnçjâ'),AT(3885,1042,260,938),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('vçrtîba'),AT(4219,1042,240,938),USE(?String18:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('uzkrâtais'),AT(4510,1042,260,938),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('nolietojums'),AT(4771,1042,313,938),USE(?String18:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('atlikusî'),AT(5135,1042,260,938),USE(?String18:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('vçrtîba (7. - 8.)'),AT(5448,1042,260,938),USE(?String18:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('vçrtîba'),AT(5760,1094,677,156),USE(?String18:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(5760,1250,677,156),USE(?String18:38),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikusî'),AT(6490,781,677,156),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(5760,1406,677,156),USE(?String18:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba,'),AT(6490,938,677,156),USE(?String18:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(5760,1563,677,156),USE(?String18:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('no kuras'),AT(6490,1094,677,156),USE(?String18:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7552,1198,1719,0),USE(?Line80:2),COLOR(COLOR:Black)
         LINE,AT(8594,1198,0,1042),USE(?Line2:13),COLOR(COLOR:Black)
         STRING('aprçíina'),AT(6490,1250,677,156),USE(?String18:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíins'),AT(7583,1250,990,208),USE(?String18:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(8625,1250,625,208),USE(?String18:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba pçc'),AT(9875,938,677,156),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(6490,1406,677,156),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas'),AT(9875,1094,677,156),USE(?String18:53),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(10.*11.:100)'),AT(7583,1458,990,208),USE(?String18:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(6490,1563,677,156),USE(?String18:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('perioda'),AT(9875,1250,677,156),USE(?String18:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nolietojumu'),AT(6490,1719,677,156),USE(?String18:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ðanas'),AT(9875,1719,677,156),USE(?String18:59),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1979,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(260,2031,573,156),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(917,2031,833,156),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1802,2031,781,156),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(2635,2031,573,156),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(3260,2031,573,156),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(3885,2031,573,156),USE(?String18:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(4510,2031,573,156),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(5135,2031,573,156),USE(?String18:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('9'),AT(5760,2031,677,156),USE(?String18:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('10'),AT(6490,2031,677,156),USE(?String18:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('11'),AT(7219,2031,313,156),USE(?String18:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('12'),AT(7583,2031,990,156),USE(?String18:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('13'),AT(8625,2031,625,156),USE(?String18:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('14'),AT(9302,2031,521,156),USE(?String18:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('15'),AT(9875,2031,677,156),USE(?String18:58),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2188,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('nolietojuma'),AT(9875,1406,677,156),USE(?String18:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atskaitî-'),AT(9875,1563,677,156),USE(?String18:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,729,10365,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         STRING(@N-_11.2B),AT(5135,10,573,156),USE(S8),RIGHT
         LINE,AT(5104,-10,0,197),USE(?Line32:8),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,197),USE(?Line32:0),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5760,10,677,156),USE(S9),RIGHT
         LINE,AT(6458,-10,0,197),USE(?Line32:9),COLOR(COLOR:Black)
         LINE,AT(8594,-10,0,197),USE(?Line32:1),COLOR(COLOR:Black)
         STRING(@N2),AT(7240,10,260,156),USE(S11),RIGHT
         LINE,AT(10573,-10,0,197),USE(?Line32:2),COLOR(COLOR:Black)
         STRING(@s20),AT(7583,10,990,156),USE(S12),CENTER
         STRING(@N_11.2B),AT(6490,10,677,156),USE(S10),RIGHT
         STRING(@N-_11.2B),AT(4510,10,573,156),USE(S7),RIGHT
         LINE,AT(9271,-10,0,197),USE(?Line32:3),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9302,10,521,156),USE(S14),RIGHT
         LINE,AT(9844,-10,0,197),USE(?Line32:13),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9875,10,677,156),USE(S15),RIGHT
         STRING(@N-_12.2B),AT(8625,10,625,156),USE(S13),RIGHT
         LINE,AT(4479,-10,0,197),USE(?Line32:7),COLOR(COLOR:Black)
         LINE,AT(1771,-10,0,197),USE(?Line32:6),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(1823,10,729,156),USE(S3),RIGHT
         LINE,AT(2604,-10,0,197),USE(?Line32:16),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(2635,10,573,156),USE(S4),RIGHT
         LINE,AT(3229,-10,0,197),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3260,10,573,156),USE(S5),RIGHT
         LINE,AT(5729,-10,0,197),USE(?Line32:18),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(3885,10,573,156),USE(S6),RIGHT
         LINE,AT(3854,-10,0,197),USE(?Line32:17),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line32:19),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,197),USE(?Line32:10),COLOR(COLOR:Black)
         STRING(@N_4),AT(417,10,,156),USE(S1),RIGHT
         LINE,AT(885,-10,0,197),USE(?Line32:11),COLOR(COLOR:Black)
         STRING(@n-_12.2b),AT(938,10,781,156),USE(S2),RIGHT
       END
RepFoot DETAIL,AT(,-10,,698),USE(?unnamed:3)
         LINE,AT(208,0,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(885,0,0,62),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,62),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(3229,0,0,62),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,62),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(7552,0,0,62),USE(?Line56:3),COLOR(COLOR:Black)
         LINE,AT(4479,0,0,62),USE(?Line56:4),COLOR(COLOR:Black)
         LINE,AT(2604,0,0,62),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,62),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(5729,0,0,62),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(6458,0,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(7188,0,0,62),USE(?Line57:3),COLOR(COLOR:Black)
         LINE,AT(8594,0,0,62),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(9271,0,0,62),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(9844,0,0,62),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(208,52,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@D06.),AT(9594,94),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@T1),AT(10219,94,313,146),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@s25),AT(365,208,1615,208),USE(SYS:AMATS1),RIGHT
         LINE,AT(1979,417,2240,0),USE(?Line61),COLOR(COLOR:Black)
         STRING(@s25),AT(2292,469,1615,208),USE(SYS:PARAKSTS1),CENTER
       END
Line   DETAIL,AT(,,,0),USE(?unnamed:4)
         LINE,AT(208,0,10365,0),USE(?Line32:5),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer    BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
!  CHECKOPEN(SYSTEM,1)
!  CHECKOPEN(GLOBAL,1)
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(PAMAT,1)
  CheckOpen(PAMKAT,1)
  CHECKOPEN(PAMAM,1)

  VIRSRAKSTS='PAMATLÎDZEKÏU  ANALÎTISKÂS  UZSKAITES  UN  NOLIETOJUMA  APRÇÍINA  KARTE '&F:KAT_NR[1]&' kategorijai'

  RecordsToProcess = 1
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Kopsavilkums '&F:KAT_NR[1]&' kategorijai'
  ?Progress:UserString{Prop:Text}=''
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAMKAT)
      NEXT(PAMKAT)
      IF ERROR()
        KLUDA(0,'Nav uzbûvçta P/L vçrtîbas aprçíina karte...')
        POST(Event:CloseWindow)
        CYCLE
      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('PAMKAR3P.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT&'                         NODOKÏIEM'
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Finansu gads'&CHR(9)&'IEGÂDES VÇRTÎBA'&CHR(9)&'KAPITÂLÂS IZMAKSAS'&CHR(9)&'PÂRVÇRTÇÐANA'&|
          CHR(9)&CHR(9)&'IZSLÇGÐANA'&CHR(9)&CHR(9)&CHR(9)&'KATEGORIJAS KORIÌÇTÂ'&CHR(9)&'ATLIKUSÎ VÇRTÎBA,'&CHR(9)&|
          'LIKME %'&CHR(9)&'TAKS.PER.NOLIETOJUMS'&CHR(9)&CHR(9)&'UZKRÂTAIS NOLIE-'&CHR(9)&'ATLIKUSÎ VÇRTÎBA'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&'+'&CHR(9)&'-'&CHR(9)&'SÂK.VÇRTÎBA'&CHR(9)&'UZKR.NOLIETOJUMS'&CHR(9)&|
          'ATL.VÇRTÎBA 7.-8.'&CHR(9)&'VÇRTÎBA TAKSÂCIJAS'&CHR(9)&'NO KURAS APRÇÍINA'&CHR(9)&'(DUBULTOTÂ)'&CHR(9)&|
          'APRÇÍINS(10.*11.:100)'&CHR(9)&'SUMMA'&CHR(9)&'TOJUMS NODOKLIEM'&CHR(9)&'PÇC TAKS.PER.NOLIE-'
          ADD(OUTFILEANSI)
          OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PERIODA BEIGÂS'&CHR(9)&'TAKS.PER.NOLIET.'&|
          CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'TOJUMA ATSKAITÎÐANAS'
          ADD(OUTFILEANSI)
          OUTA:LINE='1'&CHR(9)&'2'&CHR(9)&'3'&CHR(9)&'4'&CHR(9)&'5'&CHR(9)&'6'&CHR(9)&'7'&CHR(9)&'8'&CHR(9)&'9'&CHR(9)&|
          '10'&CHR(9)&'11'&CHR(9)&'12'&CHR(9)&'13'&CHR(9)&'14'&CHR(9)&'15'
          ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      .
    OF Event:Timer
        GADS=YEAR(B_DAT)
        IF ~INRANGE(GADS,1995,2006) THEN GADS=YEAR(TODAY()).
        I#=F:KAT_NR[1]
        LOOP Y#=1 TO GADS-1995+1    !GADA INDEKSS PAK: MASÎVÂ
           IF ~PAK:SAK_V[I#,Y#]
              KLUDA(0,'Nav definçta kategorijas sâkotnçjâ vçrt. P/L vçrtîbas aprçíina kartç...par '&Y#+1994&'.gadu')
           .
           IF ~PAK:SAK_V[I#,Y#] AND ~PAK:ATL_V[I#,Y#] AND ~PAK:KOREKCIJA[I#,Y#] AND |
           ~PAK:NOLIETOJUMS[I#,Y#] AND ~PAK:U_NOLIETOJUMS[I#,Y#]  THEN CYCLE.
           S1=Y#+1995-1
           S2=PAK:IEG_V[I#,Y#]
           S3=PAK:KAP_V[I#,Y#]
           IF PAK:PAR_V[I#,Y#]>0
              S4=PAK:PAR_V[I#,Y#]
           ELSE
              S5=ABS(PAK:PAR_V[I#,Y#])
           .
           S6=0
           S7=0
           S8=PAK:KOREKCIJA[I#,Y#]
           S9=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
           S10=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
           S11=PAK:GD_PR[I#,Y#]*2
           IF PAK:MEN_SKAITS[Y#]=12
              S12=CLIP(S10)&'X'&CLIP(S11/100)
           ELSE
              S12=CLIP(S10)&'X'&CLIP(S11/100)&'X'&CLIP(ROUND(PAK:MEN_SKAITS[Y#]/12,.001))
           .
           S13=PAK:NOLIETOJUMS[I#,Y#]
           S14=PAK:U_NOLIETOJUMS[I#,Y#]
           S15=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]-PAK:NOLIETOJUMS[I#,Y#]
           IF F:DBF='W'
             PRINT(RPT:DETAIL)
           ELSE
             OUTA:LINE=FORMAT(S1,@N_4)&CHR(9)&LEFT(FORMAT(S2,@N-_12.2B))&CHR(9)&LEFT(FORMAT(S3,@N_11.2B))&CHR(9)&|
             LEFT(FORMAT(S4,@N_11.2B))&CHR(9)&LEFT(FORMAT(S5,@N_11.2B))&CHR(9)&LEFT(FORMAT(S6,@N-_11.2B))&CHR(9)&|
             LEFT(FORMAT(S7,@N-_11.2B))&CHR(9)&LEFT(FORMAT(S8,@N-_11.2B))&CHR(9)&LEFT(FORMAT(S9,@N_11.2B))&CHR(9)&|
             LEFT(FORMAT(S10,@N_11.2B))&CHR(9)&LEFT(FORMAT(S11,@N2))&CHR(9)&LEFT(FORMAT(S12,@S20))&CHR(9)&|
             LEFT(FORMAT(S13,@N-_12.2B))&CHR(9)&LEFT(FORMAT(S14,@N-_12.2B))&CHR(9)&LEFT(FORMAT(S15,@N-_12.2B))
             ADD(OUTFILEANSI)
           .

           IF Y# < GADS-1995+1
              IF F:DBF='E'
                OUTA:LINE=''
                ADD(OUTFILEANSI)
              ELSE
                PRINT(RPT:LINE)
              END
           .
        .
        LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='E'
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE=SYS:AMATS1&CHR(9)&CHR(9)&CHR(9)&FORMAT(DAT,@D06.)&CHR(9)&FORMAT(LAI,@T4)
       ADD(OUTFILEANSI)
       OUTA:LINE=CHR(9)&CHR(9)&SYS:PARAKSTS1
       ADD(OUTFILEANSI)
    ELSE
       PRINT(RPT:RepFoot)
    END
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
  POPBIND
  RETURN
  IF ~F:DBF='W' THEN F:DBF='W'.
P_PamKar8P           PROCEDURE                    ! Declare Procedure
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
VERT_S               SREAL
uzsk_v               SREAL
KAT_NR               STRING(4)
LIKME                STRING(10)
S0                   decimal(4)
s1                   decimal(6)
S2                   DATE
S3                   DECIMAL(11,2)
S4                   long
s41                  long
s5                   string(20)
S6                   DECIMAL(11,2)
s7                   decimal(11,2)
S8                   DECIMAL(11,2)
S9                   DECIMAL(11,2)
S11                  DECIMAL(11,2)
S12                  DECIMAL(11,2)
S13                  DECIMAL(12,2)
RPT_GADS             DECIMAL(4)
A2                   DATE
A3                   DECIMAL(11,2)
A4                   DECIMAL(11,2)
A6                   DECIMAL(11,2)
A8                   DECIMAL(11,2)
A9                   DECIMAL(11,2)
A11                  DECIMAL(11,2)
A12                  DECIMAL(11,2)
A13                  DECIMAL(12,2)
B2                   DATE
B4                   DECIMAL(11,2)
B6                   DECIMAL(11,2)
B8                   DECIMAL(11,2)
B9                   DECIMAL(11,2)
B13                  DECIMAL(12,2)
Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_G_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:IZSLEGTS)
                       PROJECT(AMO:SKAITS)
                     END
report REPORT,AT(200,2125,12000,5000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(200,198,12000,1927)
         STRING('Nodokïiem'),AT(9719,156),USE(?String70:2) 
         STRING(@s45),AT(1771,156,3438,208),USE(client),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('NEMATERIÂLO  IEGULDÎJUMU  NOLIETOJUMA  UZSKAITES  UN  APRÇÍINA  KARTE'),AT(1563,521), |
             USE(?String2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nemateriâlo ieguldîjuma nosaukums'),AT(208,885),USE(?String92)
         STRING('Iegâdes datums'),AT(208,1094),USE(?String93)
         STRING('Norakstîðanas laiks (gados)'),AT(208,1302),USE(?String94)
         STRING('Izslçgðanas datums un pamatojums'),AT(208,1510),USE(?String95)
         STRING('Piezîmes'),AT(208,1719),USE(?String96)
         STRING('Uzòçmuma nosaukums :'),AT(208,156,1563,208),USE(?String7),LEFT,FONT(,10,,)
       END
Page_Head DETAIL,AT(,,,1229)
         STRING('(latos)'),AT(9896,52),USE(?String70:3) 
         LINE,AT(208,260,10365,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(208,260,0,990),USE(?Line2),COLOR(COLOR:Black)
         STRING('periods'),AT(260,521,885,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes'),AT(2865,313,990,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(2865,521,990,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Norakstîðanas'),AT(3906,313,1563,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saimieciskâ darîjuma'),AT(1198,313,1615,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkrâtais nolietojums'),AT(7865,313,1406,208),USE(?String18:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums gadâ'),AT(5521,313,2292,208),USE(?String18:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(3906,521,1563,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('apraksts,'),AT(1198,521,1615,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('taksâcijas perioda'),AT(9323,521,1250,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5469,521,2344,0),USE(?Line80:2),COLOR(COLOR:Black)
         LINE,AT(6979,521,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('dokumenta Nr. un datums'),AT(1198,729,1615,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('beigâs'),AT(9323,729,1250,208),USE(?String18:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('aprçíins'),AT(5521,573,1458,208),USE(?String18:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa'),AT(7031,573,781,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,938,10365,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('1'),AT(260,990,885,208),USE(?String18:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1198,990,1615,208),USE(?String18:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(2865,990,990,208),USE(?String18:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('4'),AT(3906,990,1563,208),USE(?String18:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('5'),AT(5521,990,1458,208),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('6'),AT(7031,990,781,208),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('7'),AT(7865,990,1406,208),USE(?String18:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('8'),AT(9323,990,1250,208),USE(?String18:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1198,10365,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(1146,260,0,990),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2813,260,0,990),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3854,260,0,990),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5469,260,0,990),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7813,260,0,990),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(9271,260,0,990),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(10573,260,0,990),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Atlikusî vçrtîba'),AT(9323,313,1250,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas'),AT(260,313,885,208),USE(?String18:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail0 DETAIL,AT(,,,250)
         STRING(@s20),AT(5625,10,1302,156),USE(S5),LEFT 
         LINE,AT(5469,-10,0,270),USE(?Line32:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7031,10,,156),USE(S6),RIGHT 
         LINE,AT(6979,-10,0,270),USE(?Line32:9),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8333,10,,156),USE(S7),RIGHT 
         LINE,AT(9271,-10,0,270),USE(?Line32:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(9427,10,,156),USE(S8),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line32:3),COLOR(COLOR:Black)
         LINE,AT(208,208,10365,0),USE(?Line32:5),COLOR(COLOR:Black)
         STRING(@N_6),AT(1406,10,,156),USE(S1),RIGHT 
         STRING(@D6),AT(2083,10,,156),USE(S2) 
         LINE,AT(2813,-10,0,270),USE(?Line32:7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(S3),RIGHT 
         STRING(@d6),AT(3906,10,,156),USE(S4),RIGHT 
         STRING('-'),AT(4583,10,104,156),USE(?String61),CENTER 
         STRING(@d6),AT(4740,10,,156),USE(S41),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line32:17),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,270),USE(?Line32:29),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line32:10),COLOR(COLOR:Black)
         STRING(@D6),AT(417,10,,156),USE(S0) 
         LINE,AT(1146,-10,0,270),USE(?Line32:11),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(AMO:IZSLEGTS),RIGHT 
         LINE,AT(5000,-10,0,270),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(A9),RIGHT 
         LINE,AT(6563,-10,0,270),USE(?Line3:10),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6875,10,,156),USE(A11),RIGHT 
         LINE,AT(8802,-10,0,270),USE(?Line3:3),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(7865,10,,156),USE(A12),RIGHT 
         LINE,AT(10573,-10,0,270),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9146,10,,156),USE(A13),RIGHT 
         STRING(@D16),AT(385,10,,156),USE(AMO:YYYYMM) 
         LINE,AT(208,208,10365,0),USE(?Line3:6),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(2031,10,,156),USE(A3),RIGHT 
         LINE,AT(2813,-10,0,270),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(AMO:KAPREM),RIGHT 
         STRING(@N-_11.2B),AT(4010,10,,156),USE(AMO:PARCEN),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line3:18),COLOR(COLOR:Black)
         LINE,AT(7344,-10,0,270),USE(?Line3:110),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(1146,-10,0,270),USE(?Line3:12),COLOR(COLOR:Black)
         STRING(@s10),AT(1229,10,729,156),USE(A2),CENTER 
       END
detailB DETAIL,AT(,,,250)
         STRING(@N-_11.2B),AT(4948,10,,156),USE(B8),RIGHT 
         LINE,AT(5000,-10,0,270),USE(?Line4:10),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5885,10,,156),USE(B9),RIGHT 
         LINE,AT(6563,-10,0,270),USE(?Line4:1),COLOR(COLOR:Black)
         LINE,AT(7344,-10,0,270),USE(?Line4:111),COLOR(COLOR:Black)
         LINE,AT(8802,-10,0,270),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(10573,-10,0,270),USE(?Line4:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(9146,10,,156),USE(B13),RIGHT 
         LINE,AT(208,208,10365,0),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(2813,-10,0,270),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3021,10,,156),USE(B4),RIGHT 
         STRING(@N-_11.2B),AT(4010,10,,156),USE(B6),RIGHT 
         LINE,AT(3854,-10,0,270),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,270),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(1146,-10,0,270),USE(?Line4:12),COLOR(COLOR:Black)
         STRING(@D6),AT(1250,10,,156),USE(B2) 
       END
RepFooT3 DETAIL,AT(,-10,,146)
         LINE,AT(208,0,0,62),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(1146,0,0,62),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(2813,0,0,62),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(3854,0,0,62),USE(?Line56:3),COLOR(COLOR:Black)
         LINE,AT(5000,0,0,62),USE(?Line56:2),COLOR(COLOR:Black)
         LINE,AT(6563,0,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(7344,0,0,62),USE(?Line57:3),COLOR(COLOR:Black)
         LINE,AT(8802,0,0,62),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(10573,0,0,62),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(208,52,10365,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(200,7700,12000,52)
         LINE,AT(208,0,10365,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer    BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(PAMAT,1)
  CHECKOPEN(KAT_K,1)
  CLEAR(KAT:RECORD)
!  KAT:NR=PAM:KAT_nr
!  GET(KAT_K,KAT:NR_KEY)
!  IF ERROR() THEN STOP('KATEGORIJAS').
!  IF SUB(PAM:KAT_NR,1,1)='1' ! ÇKAS
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' %'
!  ELSE
!     LIKME=FORMAT(PAM:LIN_G_PR,@N6.3)&' gadi'
!  .
!  DATUMS = DATE(12,31,GADS)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:U_NR',PAM:U_NR)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(AMO:RECORD)
      SET(AMO:NR_KEY,AMO:NR_KEY)
      Process:View{Prop:Filter} = 'AMO:U_NR=PAM:U_NR'
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
      s2=pam:datums
      s3=pam:iep_v
      s4=pam:kap_v
      s6=0
      s8=0
      uzsk_v=pam:bil_v+pam:nol_v
      s9=uzsk_v
      s11=0
      s12=pam:nol_v
      a12=pam:nol_v
      s13=pam:bil_v
      PRINT(RPT:DETAIL0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        LOOP
          PRINT(RPT:DETAIL)
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAILB)
    PRINT(RPT:REPFOOT3)
!    KOPA='Kopâ:'
    ENDPAGE(report)
    ReportPreview(PrintPreviewQueue)
    IF GlobalResponse = RequestCompleted
      report{PROP:FlushPreview} = True
    END
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
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
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
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
      StandardWarning(Warn:RecordFetchError,'PAMAM')
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
