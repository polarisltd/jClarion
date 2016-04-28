                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETPAR_eMAIL         FUNCTION (PARNR,ADRNR,BROWSE,RET) ! Declare Procedure
FAILS     BYTE
PAR_EMAIL STRING(37)
  CODE                                            ! Begin processed code
!
!
!  JÂBÛT POZICIONÇTAM PAR_K......
!
! PARNR:  PARTNERA U_NR
! ADRNR:  1-254-e-ADRESES U_NR
! BROWSE: e-ADRESES IZVÇLES LOGS
! RET:    0-PAR:EMAIL
!         1-EMA:EMAIL
!         2-AMATS
!         3-KONTAKTPERSONA
!
  IF ~INRANGE(RET,0,3)
     KLUDA(0,'e-ADRESES: Pieprasîts atgriezt '&RET)
     RETURN('')
  .
  IF ~PARNR
     RETURN('')
  .
  IF PAR_E::USED=0
     CHECKOPEN(PAR_E,1)
  .
  PAR_E::USED+=1
  IF BROWSE
     CLEAR(EMA:RECORD)
     EMA:PAR_NR=PARNR
     SET(EMA:NR_KEY,EMA:NR_KEY)
     NEXT(PAR_E)
     IF ~ERROR() AND EMA:PAR_NR=PARNR
        GlobalRequest=SelectRecord
        BrowsePAR_E
        IF GlobalResponse=RequestCompleted
           EXECUTE F:X
              RET=1  !CITA e-ADRESE
              RET=0  !NORÇÍINU
              RET=2  !ABAS
           .
        ELSE
           RET=0
        .
     .
  ELSIF INRANGE(ADRNR,1,254)
     CLEAR(EMA:RECORD)
     GET(PAR_E,0)
     EMA:PAR_NR=PARNR
     EMA:EMA_NR=ADRNR
     GET(PAR_E,EMA:NR_KEY)
     IF ERROR()
        RET=0
     .
  ELSE
     RET=0
  .
  PAR_E::USED-=1
  IF PAR_E::USED=0
     CLOSE(PAR_E)
  .

  IF LEN(CLIP(PAR:EMAIL))=30
     PAR_EMAIL=CLIP(PAR:EMAIL)&PAR:PASE[31:37]
  ELSE
     PAR_EMAIL=PAR:EMAIL
  .

  EXECUTE(RET+1)
!     BEGIN                       !0
!        IF LEN(CLIP(PAR:EMAIL))=30
!           I#=INSTRING('*',PAR:FAX,1,1)
!           IF I#
!              RETURN(PAR:EMAIL&PAR:FAX[1:I#-1])
!           ELSE
!              RETURN(PAR:EMAIL)
!           .
!        ELSE
!           RETURN(PAR:EMAIL)
!        .
!     .
     RETURN(PAR_EMAIL)        !0
     RETURN(EMA:EMAIL)        !1
!     RETURN(CLIP(PAR:EMAIL)&';'&EMA:EMAIL) !2
     RETURN(CLIP(PAR_EMAIL)&';'&EMA:EMAIL) !2
     RETURN(EMA:AMATS)        !3  ÐITIE PAGAIDÂM NEIET....
     RETURN(EMA:KONTAKTS)     !4
  .
  STOP('KLUDA GETPAR_EMA()')
M_MatNolBK           PROCEDURE                    ! Declare Procedure
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

DAT                  DATE
LAI                  TIME
DAUDZUMS             DECIMAL(15,3)
DAUDZUMSN            DECIMAL(15,3)
K_PROJEKTS           DECIMAL(15,3)
K_PROJEKTSN          DECIMAL(15,3)
CENA                 DECIMAL(15,4)
CENAarPVN            DECIMAL(15,4)
DAUDZUMSK            DECIMAL(15,3)
K_PROJEKTSK          DECIMAL(15,3)
NOM_VAL              STRING(3)
VALK                 STRING(3)
KOPA                 STRING(10)
MER                  STRING(7)
SUMMA_K              DECIMAL(12,2)
PLAUKTS              STRING(30)
NOLIKTAVA            STRING(50)
FORMAPN1             STRING(10)
Stringplaukts        STRING(10)

K_TABLE              QUEUE,PRE(K)
VAL                   STRING(3)
SUMMA                 DECIMAL(14,2)
                     .

VIRSRAKSTS           STRING(80)
FILTRS_TEXT          STRING(100)
SAV_NOLIKNAME        LIKE(NOLIKNAME)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOM_K)
                       PROJECT(NOM:NOMENKLAT)
                       PROJECT(NOM:EAN)
                       PROJECT(NOM:KODS)
                       PROJECT(NOM:BKK)
                       PROJECT(NOM:NOS_P)
                       PROJECT(NOM:NOS_S)
                       PROJECT(NOM:NOS_A)
                       PROJECT(NOM:PVN_PROC)
                       PROJECT(NOM:SVARSKG)
                       PROJECT(NOM:SKAITS_I)
                       PROJECT(NOM:TIPS)
                       PROJECT(NOM:KRIT_DAU)
                       PROJECT(NOM:MERVIEN)
                     END


report REPORT,AT(400,1375,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(400,198,12000,1177),USE(?unnamed)
         STRING(@s45),AT(3354,52,4323,156),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(3438,260,4177,156),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(9302,469,833,156),USE(FORMAPN1),CENTER
         STRING(@P<<<#. lapaP),AT(10188,469,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s100),AT(2177,469,6667,156),USE(FILTRS_TEXT),TRN,CENTER,FONT(,9,,,CHARSET:ANSI)
         LINE,AT(104,677,10677,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1771,677,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(135,729,1615,208),USE(?String4:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kods'),AT(1802,823,833,208),USE(?String4:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2708,823,1667,208),USE(?String4:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikums'),AT(6021,823,885,208),USE(?String4:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(8073,729,365,208),USE(?String4:4),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Vçrtîba'),AT(9688,729,1094,208),USE(?String4:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s21),AT(135,938,1615,208),USE(nomenklat),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(7917,938,833,208),USE(?String34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(9688,938,1094,208),USE(?String4:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(8802,938,833,208),USE(?String34:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1146,10677,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@S1),AT(8438,729,156,208),USE(nokl_cp),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Cena'),AT(8958,729,365,208),USE(?String4:11),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(9323,729,156,208),USE(nokl_cp,,?nokl_cp:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('K - Projekts'),AT(6979,833,885,208),USE(?String4:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(5031,833,938,208),USE(Stringplaukts),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8750,677,0,521),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(9635,677,0,521),USE(?Line2:17),COLOR(COLOR:Black)
         LINE,AT(2656,677,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(5990,677,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(6927,677,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7865,677,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(10781,677,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(104,677,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,12000,146),USE(?unnamed:5)
         LINE,AT(1771,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(2656,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_14.4),AT(7896,10,833,156),USE(CENA),RIGHT
         STRING(@N-_14.4),AT(8781,0,833,156),USE(CENAarPVN),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(9635,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@s21),AT(135,10,1615,156),USE(NOM:NOMENKLAT),FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_13),AT(1792,10,833,156),USE(NOM:KODS),RIGHT
         STRING(@s50),AT(2708,10,2292,156),USE(NOM:NOS_P),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@N-_14.3),AT(6042,10,833,156),USE(DAUDZUMS),RIGHT
         STRING(@N-_14.2),AT(9688,10,781,156),USE(SUMMA),RIGHT
         STRING(@s3),AT(10521,10,260,156),USE(NOM_VAL),LEFT
         STRING(@s15),AT(5031,10,938,156),USE(PLAUKTS),LEFT(1)
         LINE,AT(10781,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N-_14.3),AT(6979,10,833,156),USE(K_PROJEKTS),RIGHT
       END
detailN DETAIL,AT(,,12000,146),USE(?unnamed:2)
         LINE,AT(1771,-10,0,198),USE(?Line22:9),COLOR(COLOR:Black)
         LINE,AT(2656,-10,0,198),USE(?Line22:10),COLOR(COLOR:Black)
         LINE,AT(5990,-10,0,198),USE(?Line22:11),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,198),USE(?Line22:12),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line22:13),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,198),USE(?Line22:16),COLOR(COLOR:Black)
         LINE,AT(9635,-10,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line22:8),COLOR(COLOR:Black)
         STRING(@s15),AT(5031,10,938,156),USE(NOLIKTAVA),LEFT
         STRING(@N-_14.3),AT(6042,10,833,156),USE(DAUDZUMSN),RIGHT
         LINE,AT(10781,-10,0,198),USE(?Line22:18),COLOR(COLOR:Black)
         STRING(@N-_14.3),AT(6979,0,833,156),USE(K_PROJEKTSN),RIGHT
       END
RPT_FOOT1 DETAIL,AT(,-10,12000,94)
         LINE,AT(104,0,0,115),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(1771,0,0,63),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5990,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(6927,0,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,115),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(8750,0,0,115),USE(?Line22:2),COLOR(COLOR:Black)
         LINE,AT(104,52,10677,0),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(9635,0,0,115),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(10781,0,0,115),USE(?Line23:2),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,12000,177),USE(?unnamed:3)
         LINE,AT(6927,-10,0,198),USE(?Line25:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line25:3),COLOR(COLOR:Black)
         STRING(@N-_15.3),AT(6979,10,833,156),USE(K_PROJEKTSK),RIGHT
         LINE,AT(8750,-10,0,198),USE(?Line25:5),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(9688,10,781,156),USE(SUMMA_K),RIGHT
         LINE,AT(9635,-10,0,198),USE(?Line25:4),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line25),COLOR(COLOR:Black)
         STRING(@s10),AT(156,10,677,156),USE(KOPA),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_15.3B),AT(5990,10,885,156),USE(DAUDZUMSK),RIGHT
         STRING(@s3),AT(10500,10,260,156),USE(VALK),LEFT
         LINE,AT(10781,-10,0,198),USE(?Line25:6),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,12000,271),USE(?unnamed:4)
         LINE,AT(104,52,10677,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(156,83),USE(?String30),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1667,83),USE(?String30:2),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1927,83),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(9625,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10354,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@s8),AT(688,83),USE(ACC_KODS),LEFT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(9635,-10,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(10781,-10,0,63),USE(?Line33:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(8750,-10,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,63),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,63),USE(?Line30),COLOR(COLOR:Black)
       END
       FOOTER,AT(400,7850,12000,63)
         LINE,AT(104,0,10677,0),USE(?Line1:4),COLOR(COLOR:Black)
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
! TIEK SAUKTS NO N_IZZIÒÂM UN FAILIEM UN MultiN_IZZIÒÂM
!
  PUSHBIND

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  IF NOLIK::Used = 0        
    CheckOpen(NOLIK,1)
  END
  NOLIK::USED+=1
  CHECKOPEN(SYSTEM,1)
  IF NOM_K::USED=0
     CheckOpen(NOM_K,1)
  .
  NOM_K::Used += 1
  BIND(NOM:RECORD)

  dat = today()
  lai = clock()
  S_DAT=DB_S_DAT
  IF TODAY()>DB_B_DAT
     B_DAT=DB_B_DAT
  ELSE
     B_DAT=TODAY()
  .
  SAV_NOLIKNAME=NOLIKNAME

  FilesOpened = True
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ded stock'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      Stringplaukts='Noliktava'
      VIRSRAKSTS='Preces bez kustîbas '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)&' visas noliktavas'
      FILTRS_TEXT=GETFILTRS_TEXT('000011000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                 123456789
      CLEAR(nom:RECORD)
      NOM:nomenklat=nomenklat
      SET(nom:NOM_key,nom:nom_key)
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('PRBKUS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF='E'
           OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'K-Projekts'&CHR(9)&'Cena('&nokl_cp&')'&CHR(9)&'Cena('&nokl_cp&')'&CHR(9)&'Vçrtîba ar PVN'&CHR(9)&|
           CHR(9)&'Plaukts'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'bez PVN'&CHR(9)&'ar PVN'
           ADD(OUTFILEANSI)
        ELSE   !WORD
           OUTA:LINE='Nomenklatûra'&CHR(9)&'Kataloga Numurs'&CHR(9)&'Kods'&CHR(9)&'Nosaukums'&CHR(9)&'Atlikums'&CHR(9)&|
           'K-Projekts'&CHR(9)&'Cena('&nokl_cp&') bez PVN'&CHR(9)&'Cena('&nokl_cp&') bez PVN'&CHR(9)&'Vçrtîba ar PVN'&|
           CHR(9)&CHR(9)&'Plaukts'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~CYCLENOM(NOM:NOMENKLAT) AND INSTRING(NOM:TIPS,NOM_TIPS7) 
           npk#+=1
           ?Progress:UserString{Prop:Text}=NPK#
           DISPLAY(?Progress:UserString)

           DAUDZUMS=GETNOM_A(NOM:NOMENKLAT,5,0)     !ATLIKUMS PA VISÂM
           K_PROJEKTS=GETNOM_A(NOM:NOMENKLAT,8,0)   !K-Projekts
!           DAUDZUMS=LOOKATL(3) !KÂ F-JA NO RST
!           K_PROJEKTS=SUMMA

           IF ~(NOM:REDZAMIBA=1 AND DAUDZUMS=0) !~ARHÎVS AR ATLIKUMU
              IF DAUDZUMS>0

                LOOP N#=1 TO NOL_SK
                  CLOSE(NOLIK)
                  NOLIKNAME='NOLIK'&FORMAT(N#,@N02)
!                  STOP(NOLIKNAME)
                  CHECKOPEN(NOLIK,1)
!                  STOP('OPENED')
                  CLEAR(NOL:RECORD)
                  NOL:NOMENKLAT=NOM:NOMENKLAT
                  NOL:DATUMS=S_DAT
                  K#=FALSE
                  SET(nol:NOM_key,nol:NOM_key)
                  LOOP
                     NEXT(NOLIK)
                     IF ERROR() OR ~(NOL:NOMENKLAT=NOM:NOMENKLAT) THEN BREAK.
                     IF NOL:D_K='K' AND NOL:DAUDZUMS>0
                        K#=TRUE
                        BREAK
                     .
                  .
                  IF K#=TRUE THEN BREAK.
                .
                CLOSE(NOLIK)
                NOLIKNAME=SAV_NOLIKNAME
                CHECKOPEN(NOLIK,1)
!                STOP(NOM:NOMENKLAT&' '&K#)
                IF K#=FALSE

                  EXECUTE NOKL_CP
                     CP#=00000001B
                     CP#=00000010B
                     CP#=00000100B
                     CP#=00001000B
                     CP#=00010000B
                  .
                  IF BAND(NOM:ARPVNBYTE,CP#) ! AR PVN
                     CenaArPvn = GETNOM_K(NOM:NOMENKLAT,0,7)
                     CENA = CenaArPVN/(1+NOM:PVN_PROC/100)
                  ELSE                       ! BEZ PVN
                     CENA = GETNOM_K(NOM:NOMENKLAT,0,7)
                     CenaArPVN = CENA*(1+NOM:PVN_PROC/100)
                  .
  !                PLAUKTS=GETNOM_ADRESE(NOM:NOMENKLAT,0)
  !                IF CL_NR=1671 THEN PLAUKTS=GETNOM_K(NOM:NOMENKLAT,0,25). !RINDA2PZ   Colour LATLADA
                  NOM_VAL= GETNOM_K(NOM:NOMENKLAT,0,13)
                  SUMMA = DAUDZUMS*CENAarPVN
                  GET(K_TABLE,0)
                  K:VAL=NOM_VAL
                  GET(K_TABLE,K:VAL)
                  IF ERROR()
                    K:VAL=NOM_VAL
                    K:SUMMA=SUMMA
                    ADD(K_TABLE)
                    IF ERROR()
                      kluda(29,'Valûtas-'&k:VAL)
                      FREE(K_TABLE)
                      RETURN
                    .
                    SORT(K_TABLE,K:VAL)
                  ELSE
                    K:SUMMA+=SUMMA
                    PUT(K_TABLE)
                  .
                  DAUDZUMSK += DAUDZUMS
                  K_PROJEKTSK += K_PROJEKTS
                  SUMMA_K+=SUMMA*BANKURS(NOM_VAL,B_DAT,' Nomenklatûrai:'&NOM:NOMENKLAT)
                  IF ~F:DTK
                     IF F:DBF='W'              !tikai WMF t.s. noliktavas
  !                      IF F:NOA               !VISAS NOLIKTAVAS
                           VAIRAK_KA_1#=0
                           LOOP N#= 1 TO NOL_SK
                               IF GETNOM_A('POZICIONÇTS',1,0,N#)
                                  VAIRAK_KA_1#+=1
                                  FOUND#=N#
                               .
                           .
                           IF VAIRAK_KA_1#>1
                              PLAUKTS=''
                              PRINT(RPT:DETAIL)
                              LOOP N#= 1 TO NOL_SK
                                  DAUDZUMSN=GETNOM_A(NOM:NOMENKLAT,1,0,N#)
                                  IF DAUDZUMSN
                                     K_PROJEKTSN=GETNOM_A(NOM:NOMENKLAT,4,0,N#)
                                     NOLIKTAVA='t.s.  N '&CLIP(N#)
                                     PRINT(RPT:DETAILN)
                                  .
                              .
                           ELSE
                              PLAUKTS='N '&CLIP(FOUND#)
                              PRINT(RPT:DETAIL)
                           .
  !                      ELSE
  !                         PRINT(RPT:DETAIL)
  !                      .
                     ELSE                      !W,EXCEL NE+NN
                        OUTA:LINE=NOM:NOMENKLAT&CHR(9)&NOM:KATALOGA_NR&CHR(9)&LEFT(FORMAT(NOM:KODS,@N_13B)&'=')&CHR(9)&|
                        NOM:NOS_P&CHR(9)&LEFT(FORMAT(DAUDZUMS,@N-_15.3))&CHR(9)&LEFT(FORMAT(K_PROJEKTS,@N-_15.3))&CHR(9)&|
                        LEFT(FORMAT(CENA,@N_13.2))&CHR(9)&LEFT(FORMAT(CENAARPVN,@N_13.2))&CHR(9)&LEFT(FORMAT(SUMMA,@N-_14.2))&|
                        CHR(9)&NOM_VAL&CHR(9)&PLAUKTS
                        ADD(OUTFILEANSI)
                     .
                  .
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
      .
    .
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      .
    .
  .
  IF SEND(NOM_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT1)
    .
    KOPA='Kopâ :'
    !VALK='Ls'
    VALK=val_uzsk
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT2)
    ELSE
       OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_15.3))&CHR(9)&|
       LEFT(FORMAT(K_PROJEKTSK,@N-_15.3))&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_14.2))&CHR(9)&VALK
       ADD(OUTFILEANSI)
    .
    KOPA=' t.s.'
    DAUDZUMSK   = 0
    K_PROJEKTSK = 0
    !IF ~(RECORDS(K_TABLE)=1 AND K:VAL='Ls')
    IF ~(RECORDS(K_TABLE)=1 AND (((K:VAL='Ls' OR K:VAL='LVL') AND GL:DB_GADS <= 2013) OR (GL:DB_GADS > 2013 AND K:VAL=val_uzsk)))
      GET(K_TABLE,0)
      LOOP J# = 1 TO RECORDS(K_TABLE)
        GET(K_TABLE,J#)
        IF ~(K:SUMMA = 0)
          SUMMA_K = K:SUMMA
          VALK    = K:VAL
          IF F:DBF='W'   !WMF
             PRINT(RPT:RPT_FOOT2)
          ELSE
            OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA_K,@N-_14.2))&|
            CHR(9)&VALK
            ADD(OUTFILEANSI)
          .
        .
      .
    .
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT3)
       ENDPAGE(report)
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
  free(k_table)
  IF FilesOpened
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    NOLIK::USED-=1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
  IF ERRORCODE() OR CYCLENOM(NOM:NOMENKLAT)=2
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOM_K')
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
B_PVN_03_2009        PROCEDURE                    ! Declare Procedure
RejectRecord LONG
EOF          BYTE
CG           STRING(10)
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)

DEKLARETS    DECIMAL(12,2)
APREKarKOR   DECIMAL(12,2)
MAKSPVN      DECIMAL(12,2)
ATMAKSPVN    DECIMAL(12,2)
M            STRING(14),DIM(16)


DATUMS       DATE
G            STRING(4)
rmenesiem    string(8)
SUM1         STRING(11)
VK_NR        ULONG
NOT1         STRING(45)
NOT2         STRING(45)
NOT3         STRING(45)
PRECIZETA    string(10)
E            STRING(1)
EE           STRING(15)
XMLFILENAME         CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

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


report REPORT,AT(300,396,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
detail DETAIL,AT(10,10,8000,7698),USE(?unnamed)
         STRING('Pielikums'),AT(6302,52,885,156),USE(?String92:5),TRN
         STRING('Ministru kabineta'),AT(6302,208,885,156),USE(?String92:2)
         STRING(@s10),AT(635,240,1302,208),USE(PRECIZETA),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('2006.gada 10.janvâra'),AT(6302,365,1250,156),USE(?String92:3)
         STRING('Valsts ieòçmumu dienests'),AT(2656,573),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('noteikumiem Nr. 42'),AT(6302,521,1042,156),USE(?String92:4)
         STRING('Pievienotâs vçrtîbas nodokïa deklarâcija'),AT(2104,885),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN4'),AT(6375,958),USE(?String45),TRN,FONT(,14,,FONT:bold,CHARSET:ANSI)
         STRING('par taksâcijas gadu'),AT(2927,1146),USE(?String2:2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas gads'),AT(6458,1563),USE(?String3),CENTER,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(208,1510,0,1042),USE(?Line3),COLOR(COLOR:Black)
         STRING(@S1),AT(6458,1823,188,208),USE(G[1]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6719,1823,188,208),USE(G[2]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6979,1823,188,208),USE(G[3]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(7240,1823,188,208),USE(G[4]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Apliekamâs personas nosaukums'),AT(260,1563),USE(?String8),LEFT,FONT(,10,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6302,1510,0,1042),USE(?Line44:3),COLOR(COLOR:Black)
         STRING('Juridiskâ adrese'),AT(260,1823,1042,208),USE(?String10),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s50),AT(1406,1823,4219,208),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1771,6094,0),USE(?Line1:53),COLOR(COLOR:Black)
         LINE,AT(208,1510,6094,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Apliekamâs personas reìistrâcijas Nr. LV'),AT(260,2083,2604,208),USE(?String12),LEFT, |
             FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s13),AT(2385,2063,1146,208),USE(GL:REG_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2292,6094,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('Tâlrunis'),AT(260,2344,573,208),USE(?String10:2),LEFT,FONT(,,,FONT:regular,CHARSET:BALTIC)
         STRING(@s15),AT(885,2344,1302,208),USE(SYS:TEL,,?SYS:TEL:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,2969,0,469),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2448,1563,3854,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,3438,0,-469),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Taksâcijas gadâ aprçíinâtais nodoklis,'),AT(521,3594),USE(?String16),LEFT
         STRING(@N-_12.2),AT(5938,3698),USE(APREKarKOR),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('No budþeta atmaksâjamais nodoklis'),AT(521,4531,2292,208),USE(?String15),LEFT
         LINE,AT(6406,2031,1042,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(6406,1510,1042,0),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(7188,1771,0,260),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(6406,1771,1042,0),USE(?Line1:55),COLOR(COLOR:Black)
         LINE,AT(208,2552,6094,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(5104,2969,2344,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(6927,1771,0,260),USE(?Line1:58),COLOR(COLOR:Black)
         STRING('Taksâcijas gadâ iesniegtajâs'),AT(521,3021,2292,208),USE(?String31),LEFT
         STRING('deklarâcijâs aprçíinâtâ nodokïa summa'),AT(521,3229,2396,208),USE(?String34),LEFT
         STRING(@N-_12.2),AT(5938,3135),USE(DEKLARETS),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,3438,2344,0),USE(?Line1:12),COLOR(COLOR:Black)
         LINE,AT(5104,3542,2344,0),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(5104,4479,0,260),USE(?Line1:15),COLOR(COLOR:Black)
         LINE,AT(5104,4115,2344,0),USE(?Line1:26),COLOR(COLOR:Black)
         LINE,AT(5104,4375,2344,0),USE(?Line1:14),COLOR(COLOR:Black)
         STRING('Budþetâ maksâjamais nodoklis'),AT(521,4167,2292,208),USE(?String15:2),LEFT
         STRING('-'),AT(5156,4531,365,208),USE(?String41:2),CENTER
         LINE,AT(5521,4479,0,260),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(5104,4740,2344,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(208,4948,7240,0),USE(?Line66),COLOR(COLOR:Black)
         STRING('Apstiprinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegtâ informâcija ir p' &|
             'ilnîga un patiesa.'),AT(417,5104),USE(?String39),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,4479,2344,0),USE(?Line1:17),COLOR(COLOR:Black)
         LINE,AT(7448,4479,0,260),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5938,4521),USE(ATMAKSPVN),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(385,5573),USE(sys:amats1),RIGHT(1)
         LINE,AT(1615,7292,3542,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@S1),AT(990,7448),USE(RS)
         LINE,AT(2292,5729,2552,0),USE(?Line1:24),COLOR(COLOR:Black)
         LINE,AT(208,4948,0,1458),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(208,6406,7240,0),USE(?Line35),COLOR(COLOR:Black)
         STRING('R : '),AT(729,7448),USE(?String99)
         LINE,AT(7448,4948,0,1458),USE(?Line1:22),COLOR(COLOR:Black)
         STRING(@s25),AT(2750,5781,,135),USE(SYS:PARAKSTS1),CENTER,FONT(,8,,FONT:regular+FONT:italic,CHARSET:BALTIC)
         STRING('Saòemðanas datums'),AT(260,7135),USE(?String73),LEFT
         STRING('atbildîgâ amatpersona'),AT(260,6719),USE(?String72:2)
         LINE,AT(1615,6875,5833,0),USE(?Line73),COLOR(COLOR:Black)
         STRING(@s5),AT(260,7448),USE(KKK)
         STRING('Datums :'),AT(781,6094),USE(?String68),LEFT
         LINE,AT(1354,6302,1719,0),USE(?Line67),COLOR(COLOR:Black)
         STRING('(paraksts un tâ atðifrçjums)'),AT(3750,6927,,135),USE(?String46),FONT(,8,,FONT:regular+FONT:italic,CHARSET:BALTIC)
         STRING('Valsts ieòçmumu dienesta'),AT(260,6510),USE(?String72)
         STRING(@d06.),AT(1823,6094),USE(DATUMS),LEFT
         LINE,AT(7448,4115,0,260),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(5521,4115,0,260),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(7448,3542,0,469),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(5104,4010,2344,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('ievçrojot veiktâs korekcijas'),AT(521,3802),USE(?String16:2),LEFT
         STRING('+'),AT(5156,4167,365,208),USE(?String41),CENTER
         STRING(@N-_12.2),AT(5938,4177),USE(MAKSPVN),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6667,1771,0,260),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5104,3542,0,469),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(208,2031,6094,0),USE(?Line11:9),COLOR(COLOR:Black)
         LINE,AT(6406,1510,0,521),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7448,1510,0,521),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(5104,4115,0,260),USE(?Line3:4),COLOR(COLOR:Black)
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
! VIÒÐ IR TAISÎTS NO PVN DEKL. KOPSAV.- VAIRS NAV 25.06.2011

  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  BIND('MEN_NR',MEN_NR)
  BIND('kkk',kkk)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
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
  ProgressWindow{Prop:Text} = 'PVN gada atskaite'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      G=FORMAT(GADS,@N4)
      CG = 'K1000'
      SET(GGK:DAT_key,GGK:DAT_KEY)
      IF F:IDP THEN PRECIZETA='Precizçtâ'.
!      IF F:XML
!         E='E'
!         EE='(PVN_D.XML)'
!      .
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
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
      NOT1='Ministru kabineta'
      NOT2='2006.gada 10.janvâra'
      NOT3='noteikumiem Nr.42'
      IF F:DBF='W'    !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSIF F:DBF='E' !EXCEL
        IF ~OPENANSI('PVNDKLRG.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {45}VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {35}PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJA'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {45}PAR TAKSÂCIJAS GADU'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Apliekamâs personas nosaukums '&CLIENT&CHR(9)&'Taksâcijas gads '
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Juridiskâ adrese '&GL:ADRESE&CHR(9)&GADS
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Apliekamâs personas reìistrâcijas Nr. LV'&GL:REG_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Tâlrunis '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=' '
        ADD(OUTFILEANSI)  
      ELSE            !WORD
        IF ~OPENANSI('PVNDKLRG.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {15}PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJA'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {25}PAR TAKSÂCIJAS GADU'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas nosaukums '&CLIENT&CHR(9)&'Taksâcijas gads '
        ADD(OUTFILEANSI)
        OUTA:LINE='Juridiskâ adrese '&GL:ADRESE&CHR(9)&GADS
        ADD(OUTFILEANSI)
        OUTA:LINE='Apliekamâs personas reìistrâcijas Nr. LV'&GL:REG_NR
        ADD(OUTFILEANSI)
        OUTA:LINE='Tâlrunis '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=' '
        ADD(OUTFILEANSI)  
      .
      IF F:XML !EDS - tas apraksts tâds aizdomîga...
        XMLFILENAME=USERFOLDER&'\PVN_G.XML'
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           Y#=YEAR(GGK:DATUMS)
           M#=MONTH(GGK:DATUMS)
!           IF GGK:PVN_TIPS='0' AND ~(GGK:U_NR=1)
           IF INSTRING(GGK:PVN_TIPS,'0A') AND ~(GGK:U_NR=1) !02.07.2010
              IF GGK:D_K='K'                      !SAÒEMTAIS PVN
                 APREKarKOR+=GGK:SUMMA
              M[M#]=FORMAT(DATE(M#,1,Y#),@D014.B) !DOKUMANTA Nr VÇSTUREI
              ELSE                                !PRIEKÐNODOKLIS
                 APREKarKOR-=GGK:SUMMA
              .
           ELSIF GGK:PVN_TIPS='1' AND GGK:D_K='D' !MAKS.BUDÞETAM
              VK_NR=GGK:PAR_NR
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
  IF TODAY() > DATE(4,30,YEAR(B_DAT)+1)
     DATUMS=DATE(4,30,YEAR(B_DAT)+1)
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF ~VK_NR
       KLUDA(0,'Nav atrasts neviens PVN maksâjums budþetam')
    .

!    LOOP J# = 1 TO 16                       TIK SAREÞÌÎTI NEVAJAG- VID
!       DEKLARETS+=GETVESTURE(VK_NR,M[J#],6)
!    .
!    IF APREKarKOR > DEKLARETS
!      MAKSPVN = APREKarKOR-DEKLARETS
!    ELSE
!      ATMAKSPVN = DEKLARETS-APREKarKOR
!    .
    DEKLARETS = APREKarKOR
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)
    ELSE ! WORD,EXCEL
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=GADS&'. gadâ iesniegtajâs deklarâcijâs aprçíinâtâ nodokïa summa'&CHR(9)&LEFT(FORMAT(DEKLARETS,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Aprçíinâtais nodoklis '&GADS&'.g., ievçrojot veiktâs korekcijas'&CHR(9)&LEFT(FORMAT(APREKarKOR,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Budþetâ maksâjamais nodoklis'&CHR(9)&LEFT(FORMAT(MAKSPVN,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='No budþeta atmaksâjamais nodoklis'&CHR(9)&LEFT(FORMAT(ATMAKSPVN,@N_12.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Apstirpinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegta informâcija ir pilnîga un patiesa'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}'&SYS:AMATS1
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}'&CLIP(SYS:PARAKSTS1)&'_{30}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Datums: '&format(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Valsts ieòçmuma dienesta atbildîgâ amatpersona'&'_{20}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Saòemðanas datums'&'_{20}'
        ADD(OUTFILEANSI)
    END
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
  ELSE           !W,EXCEL
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



