                     MEMBER('winlats.clw')        ! This is a MEMBER module
GETDOKDATUMS         FUNCTION (DOK_DATUMS)        ! Declare Procedure
DOK_gads       DECIMAL(4)
DOK_DIENA      DECIMAL(2)
DOK_menesis    STRING(10)
  CODE                                            ! Begin processed code
 DOK_gads   =year(DOK_datums)
 DOK_DIENA  =day(DOK_datums)
 DOK_menesis=MENVAR(DOK_datums,2,2)
 RETURN(DOK_GADS&'.gada'&' "'&CLIP(DOK_DIENA)&'" '&DOK_MENESIS)
M_LielPPAtsk         PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAR_K)
                       PROJECT(NOS_S)
                       PROJECT(TIPS)
                       PROJECT(U_NR)
                       PROJECT(GRUPA)
                       PROJECT(PVN)
                       PROJECT(PASE)
                       PROJECT(ADRESE)
                       PROJECT(ATLAIDE)
                     END
!------------------------------------------------------------------------
NPK                     USHORT
NOS_P                   STRING(50) !PAR:NOS_P/DOK_SENR
DOK_SENR                STRING(50)
KOPA                    STRING(6)

P_TABLE              QUEUE,PRE(P)
VAL                     STRING(3)
SUMMA1                  DECIMAL(12,2)
SUMMA2                  DECIMAL(12,2)
SUMMA3                  DECIMAL(12,2)
                     .

AL                      STRING(195)
I_TABLE              QUEUE,PRE(I)
SUMMA_NO                DECIMAL(5)
SUMMA_LIDZ              DECIMAL(5)
LAPA                    DECIMAL(3)
                     .

SUMMA1                  DECIMAL(12,2)
SUMMA2                  DECIMAL(12,2)
SUMMA3                  DECIMAL(12,2)
SUMMA1P                 DECIMAL(12,2)
SUMMA2P                 DECIMAL(12,2)
SUMMA3P                 DECIMAL(12,2)
SUMMA1K                 DECIMAL(12,2)
SUMMA2K                 DECIMAL(12,2)
SUMMA3K                 DECIMAL(12,2)
DAT                     DATE
LAI                     TIME
NOLIKTAVA_TEXT          STRING(50)
VIRSRAKSTS              STRING(66)
FORMA                   STRING(10)
FILTRS_TEXT             STRING(100)
TAB_2_TEXT              STRING(15)
CP                      STRING(10)
CN                      STRING(10)
SAV_PAVADNAME           LIKE(PAVADNAME)
SAV_NOLIKNAME           LIKE(NOLIKNAME)
KOMATS                  STRING(1)

!-------------------------------------------------------------
report REPORT,AT(198,1750,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1552),USE(?unnamed:2)
         STRING(@s10),AT(6635,677,677,156),USE(FORMA),RIGHT(1),FONT(,8,,)
         STRING(@s100),AT(375,823,6354,208),USE(FILTRS_TEXT),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6688,844,625,156),PAGENO,USE(?PageCount),RIGHT(1),FONT(,8,,)
         LINE,AT(260,1042,6979,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(677,1042,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3750,1042,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('NPK'),AT(292,1198,365,208),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(979,1198,1823,208),USE(TAB_2_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu summa'),AT(3792,1094,938,208),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu summa'),AT(4781,1094,1250,208),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6042,1042,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4740,1042,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('t.s. Atlaide'),AT(6083,1188,1146,208),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7240,1042,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(260,1510,6979,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(260,1042,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1260,94,4583,198),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(1573,302,3990,167),USE(NOLIKTAVA_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(542,521,6042,167),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN'),AT(3792,1302,938,208),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN'),AT(4781,1302,1250,208),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(260,-10,0,198),USE(?Line8),COLOR(COLOR:Black)
         STRING(@N_4B),AT(313,10,313,156),USE(NPK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(677,-10,0,198),USE(?Line8:2),COLOR(COLOR:Black)
         STRING(@s50),AT(729,0,2969,156),USE(NOS_P,,?NOS_P:2),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(5729,0,260,156),USE(P:VAL),CENTER,FONT(,8,,,CHARSET:ANSI)
         LINE,AT(3750,-10,0,198),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6458,10,729,156),USE(P:SUMMA3),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,-10,0,198),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4854,10,781,156),USE(P:Summa2),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7240,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,198),USE(?Line8:11),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(3854,10,781,156),USE(P:Summa1),RIGHT,FONT(,8,,,CHARSET:BALTIC)
       END
RPT_FOOT1 DETAIL,AT(,,,94)
         LINE,AT(260,-10,0,115),USE(?Line13),COLOR(COLOR:Black)
         LINE,AT(677,-10,0,63),USE(?Line14),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,115),USE(?Line15),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,115),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,115),USE(?Line17:486),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,115),USE(?Line171),COLOR(COLOR:Black)
         LINE,AT(260,52,6979,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(7240,-10,0,198),USE(?Line48:13),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,198),USE(?Line8:8),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(3823,10,,156),USE(SUMMA1K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(260,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         STRING(@s6),AT(521,10,521,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4740,-10,0,198),USE(?Line8:10),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(4854,10,781,156),USE(Summa2K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6042,-10,0,198),USE(?Line8:14),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6354,10,813,156),USE(SUMMA3K),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s3),AT(5729,0,260,156),USE(val_uzsk),TRN,CENTER,FONT(,8,,,CHARSET:ANSI)
       END
RPT_FOOT3 DETAIL,AT(,,,260),USE(?unnamed)
         LINE,AT(260,-10,0,63),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,63),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(7240,-10,0,63),USE(?Line291),COLOR(COLOR:Black)
         LINE,AT(4740,-10,0,63),USE(?Line929:3),COLOR(COLOR:Black)
         LINE,AT(6042,-10,0,63),USE(?Line929:386),COLOR(COLOR:Black)
         LINE,AT(260,52,6979,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(260,83,479,156),USE(?String32),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(833,83,500,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1927,83,208,156),USE(?String34),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(2135,83,208,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(6083,83,625,156),USE(dat),RIGHT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@t4),AT(6667,83,521,156),USE(lai),RIGHT,FONT(,7,,,CHARSET:BALTIC)
       END
       FOOTER,AT(198,11050,8000,63)
         LINE,AT(260,0,6979,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!** Pircçju/Piegâdâtâju atskaite par visiem & visâm noliktavâm

  PUSHBIND
  BIND('PAR_NR',PAR_NR)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CP',CP)
  KOPA='Kopâ '
  SAV_PAVADNAME=PAVADNAME
  SAV_NOLIKNAME=NOLIKNAME

  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  CheckOpen(PAVAD,1)
  BIND(PAR:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAR_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = FORMA
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      NOLIKTAVA_TEXT='Noliktavas: '
      LOOP N#=1 TO NOL_SK
         NOLIKTAVA_TEXT=CLIP(NOLIKTAVA_TEXT)&KOMATS&N#
         KOMATS=','
      .
      IF D_K='K'
         VIRSRAKSTS='Atskaite par lielâkajiem preèu saòçmçjiem '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
         FORMA='FORMA IZ8'
         TAB_2_TEXT='Saòçmçjs'
      ELSE
         VIRSRAKSTS='Atskaite par lielâkajiem preèu piegâdâtâjiem '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
         FORMA='FORMA IE7'
         TAB_2_TEXT='Piegâdâtâjs'
      .
      IF F:LIELMAZ='M' !NORÂDIET MAZÂKO S, KAS....
         FILTRS_TEXT = 'Summas, kas >= '&val_uzsk&' '&CLIP(MINMAXSUMMA)
      ELSE
         IF F:IEKLAUTPK
!            FILTRS_TEXT = 'Summas, kas <= Ls '&CLIP(MINMAXSUMMA)&' arî,kas nav Noliktavâ'
            FILTRS_TEXT = 'Summas, kas <= '&val_uzsk&' '&CLIP(MINMAXSUMMA)&' arî,kas nav Noliktavâ'
         ELSE
!            FILTRS_TEXT = 'Summas, kas <= Ls '&CLIP(MINMAXSUMMA)&' tikai,kas ir Noliktavâ'
            FILTRS_TEXT = 'Summas, kas <= '&val_uzsk&' '&CLIP(MINMAXSUMMA)&' tikai,kas ir Noliktavâ'
         .
      .
      IF PAR_NR = 999999999 !VISI
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' '&GETFILTRS_TEXT('111100000') !1-OBJ,2-NOD,3-PAR_T,4-PAR_G,5-NOM,6-NOM_T,7-DN,
!                                                          123456789   !8-(1:parâdi),9-ID
      ELSE                  !KONKRÇTS
         FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Partneris: '&CLIP(GETPAR_K(PAR_NR,2,2))&' '&GETPAR_K(PAR_NR,0,24)
         TAB_2_TEXT='Pamatojums'
      .
      IF F:DTK
         AL=GETINIFILE('AL',0)
!     STOP('AL='&AL)
         LOOP
            I#+=1
            I1#=(I#-1)*13+1
            I2#=(I#-1)*13+5
            I:SUMMA_NO=AL[I1#:I2#]
            I1#=(I#-1)*13+6
            I2#=(I#-1)*13+10
            I:SUMMA_LIDZ=AL[I1#:I2#]
            I1#=(I#-1)*13+11
            I2#=(I#-1)*13+13
            I:LAPA=AL[I1#:I2#]
!           STOP(I:SUMMA_LIDZ)
            IF ~I:SUMMA_LIDZ THEN BREAK.
            ADD(I_TABLE)
         .
      .

      CP ='R11'    !PAR_K-GRUPA-TIPS
!          123
      CN ='N1001110' !PAV-RS-DvK-INRANGE(SB)-=D_K-OBJEKTS-NODAÏA-ADR_NR
!          12345678

      CLEAR(PAR:RECORD)
      SET(PAR:NOS_KEY,PAR:NOS_KEY)
      Process:View{Prop:Filter} = '~CYCLEPAR_K(CP)'
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
      ELSE !WORD/EXCEL
        IF ~OPENANSI('M_PIRAT.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=NOLIKTAVA_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=VIRSRAKSTS
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:dbf='E'
           OUTA:LINE='NPK'&CHR(9)&TAB_2_TEXT&CHR(9)&'Preèu summa'&CHR(9)&'Preèu summa'&CHR(9)&CHR(9)&'t.s. Atlaide'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&CHR(9)&'bez PVN'&CHR(9)&'ar PVN'
           ADD(OUTFILEANSI)
        ELSE   !WORD
           OUTA:LINE='NPK'&CHR(9)&TAB_2_TEXT&CHR(9)&'Preèu summa bez PVN'&CHR(9)&'Preèu summa ar PVN'&CHR(9)&CHR(9)&|
           't.s. Atlaide'
           ADD(OUTFILEANSI)
        .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        FOUND#=FALSE
        SUMMA1P=0
        SUMMA2P=0
        SUMMA3P=0
        REC#+=1
        ?Progress:UserString{Prop:Text}=REC#
        DISPLAY(?Progress:UserString)
        LOOP N#=1 TO NOL_SK               !BRAUCAM CAURI VISÂM NOLIKTAVÂM
           CLOSE(PAVAD)
           PAVADNAME='PAVAD'&FORMAT(N#,@N02)
           CHECKOPEN(PAVAD,1)
           CLOSE(NOLIK)
           NOLIKNAME='NOLIK'&FORMAT(N#,@N02)
           CHECKOPEN(NOLIK,1)
           CLEAR(NOL:RECORD)
           IF F:LIELMAZ='M'   !?
              NOL:DATUMS=S_DAT
           .
           NOL:PAR_NR=PAR:U_NR
           SET(NOL:PAR_KEY,NOL:PAR_KEY)
           LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:PAR_NR=PAR:U_NR AND NOL:DATUMS<=B_DAT) THEN BREAK.
             IF NOL:U_NR=1 THEN CYCLE.    !SALDO IGNORÇJAM
             IF CYCLENOL(CN) THEN CYCLE.
             FOUND#=TRUE
             SUMMA1 =0
             SUMMA2 =0
             SUMMA3 =0
             IF INRANGE(NOL:DATUMS,S_DAT,B_DAT)
                IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.
                SUMMA1=CALCSUM(3,2)
                SUMMA2=CALCSUM(4,2)
                SUMMA3=CALCSUM(8,2)
                SUMMA1P+=CALCSUM(15,2) !Ls
                SUMMA2P+=CALCSUM(16,2) !Ls
                SUMMA3P+=CALCSUM(7,2)  !Ls
                GET(P_TABLE,0)
                P:VAL=NOL:VAL
                GET(P_TABLE,P:VAL)
                IF ERROR()
                   P:VAL=NOL:VAL
                   P:SUMMA1=SUMMA1  !BEZ PVN
                   P:SUMMA2=SUMMA2  !AR  PVN
                   P:SUMMA3=SUMMA3  !ATLAIDE
                   ADD(P_TABLE)
                   SORT(P_TABLE,P:VAL)
                ELSE
                   P:SUMMA1+=SUMMA1
                   P:SUMMA2+=SUMMA2
                   P:SUMMA3+=SUMMA3
                   PUT(P_TABLE)
                .
             .
           .
        .
        DO WRDETAIL
!        IF F:DTK !JÂMAINA PAR_K PÇC WINLATS.INI ALGORITMA
!           IF SUMMA2P AND ~PAR:SUMMA2 AND S_DAT=DATE(1,1,2008) AND B_DAT=DATE(12,31,2008)
!              PAR:LIGUMS2='Uzkrâjums 2008.g. :'
!              PAR:SUMMA2=SUMMA2P !SAGLABÂJAM PIE 2.LÎGUMA SUMMAS
!              IF RIUPDATE:PAR_K()
!                 KLUDA(24,'PAR_K')
!              .
!              JB#+=1
!           ELSE
!              LOOP I#=1 TO RECORDS(I_TABLE) !A-LAPU ALGORITMS
!                 GET(I_TABLE,I#)
!   !              STOP(ROUND(SUMMA2P,1)&' '&I:SUMMA_NO&' '&I:SUMMA_LIDZ&' '&I:LAPA)
!                 IF INRANGE(ROUND(PAR:SUMMA2+SUMMA2P,1),I:SUMMA_NO,I:SUMMA_LIDZ)
!                    PAR:ATLAIDE=I:LAPA
!                    IF RIUPDATE:PAR_K()
!                       KLUDA(24,'PAR_K')
!                    .
!                    JB#+=1
!                    BREAK
!                 .
!              .
!           .
!        .
        FREE(P_TABLE)
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
  IF JB#
     KLUDA(0,'Mainîti '&CLIP(JB#)&' PAR_K ieraksti',,1)
  .
  IF SEND(PAR_K,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    END
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA1K,@N-_13.2))&CHR(9)&LEFT(FORMAT(SUMMA2K,@N-_13.2))&CHR(9)&|
!        'Ls'&CHR(9)&LEFT(FORMAT(SUMMA3K,@N-_13.2))
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&LEFT(FORMAT(SUMMA1K,@N-_13.2))&CHR(9)&LEFT(FORMAT(SUMMA2K,@N-_13.2))&CHR(9)&|
        val_uzsk&CHR(9)&LEFT(FORMAT(SUMMA3K,@N-_13.2))
        ADD(OUTFILEANSI)
    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
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

  PAVADNAME=SAV_PAVADNAME
  CLOSE(PAVAD)
  CHECKOPEN(PAVAD,1)
  NOLIKNAME=SAV_NOLIKNAME
  CLOSE(NOLIK)
  CHECKOPEN(NOLIK,1)
  IF FilesOpened
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(I_TABLE)
!  IF F:DBF='E' THEN F:DBF='W'. !PAGAIDÂM
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
      StandardWarning(Warn:RecordFetchError,'PAR_K')
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
WRDETAIL    ROUTINE
  PRINT#=FALSE
  IF F:LIELMAZ='M'
     IF SUMMA2P>=MINMAXSUMMA AND FOUND#=TRUE THEN PRINT#=TRUE.
  ELSE
     IF SUMMA2P<=MINMAXSUMMA AND (FOUND#=TRUE OR F:IEKLAUTPK) THEN PRINT#=TRUE.
  .
  IF PRINT#=TRUE
     NPK#+=1
     NPK=NPK#
!     IF PAR_NR = 999999999 !VISI
        NOS_P=PAR:NOS_P
!     ELSE
!        NOS_P=DOK_SENR
!     .
     IF RECORDS(P_TABLE) !VAR BÛT ARÎ DAÞÂDAS VALÛTAS 1 PARTNERIM
        LOOP I#=1 TO RECORDS(P_TABLE)
           GET(P_TABLE,I#)
           IF I#>1
              NPK=0
              NOS_P=''
           .
           DO PRDETAIL
        .
     ELSE
        P:VAL=''
        P:SUMMA1=0
        P:SUMMA2=0
        P:SUMMA3=0
        DO PRDETAIL
     .
     SUMMA1K+=SUMMA1P
     SUMMA2K+=SUMMA2P
     SUMMA3K+=SUMMA3P

  .

!-----------------------------------------------------------------------------
PRDETAIL    ROUTINE

   IF F:DBF='W'  !WMF
       PRINT(RPT:DETAIL)
   ELSE          !WORD/EXCEL
       OUTA:LINE=LEFT(FORMAT(NPK,@N_4B))&CHR(9)&NOS_P&CHR(9)&LEFT(format(P:SUMMA1,@N-_13.2))&CHR(9)&LEFT(format(P:SUMMA2,@N-_13.2))&|
       CHR(9)&P:VAL&CHR(9)&LEFT(format(P:SUMMA3,@N-_13.2))
       ADD(OUTFILEANSI)
   .
BrowseAU_TEX PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
RecordFiltered       LONG

BRW1::View:Browse    VIEW(AU_TEX)
                       PROJECT(AUX:AUT_TEXT)
                       PROJECT(AUX:DATUMS)
                       PROJECT(AUX:PAR_AUT0)
                     END

Queue:Browse         QUEUE,PRE()                  ! Browsing Queue
BRW1::AUX:AUT_TEXT     LIKE(AUX:AUT_TEXT)         ! Queue Display field
BRW1::AUX:DATUMS       LIKE(AUX:DATUMS)           ! Queue Display field
BRW1::AUX:PAR_AUT0     LIKE(AUX:PAR_AUT0)         ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
BrowseWindow         WINDOW('Browse Records'),AT(0,0,240,245),FONT('MS Sans Serif',9,,FONT:bold,CHARSET:BALTIC),SYSTEM,GRAY,MDI
                       LIST,AT(5,5,235,222),USE(?List),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('40L(2)|M~AUT TEXT~@s10@40R(2)|M~Datums:~L@D06.@120R(2)|M~AUT0~L@s30@'),FROM(Queue:Browse)
                       BUTTON('&Ievadît'),AT(5,230,40,12),USE(?Insert),KEY(InsertKey)
                       BUTTON('&Mainît'),AT(50,230,40,12),USE(?Change),KEY(CtrlEnter),DEFAULT
                       BUTTON('&Dzçst'),AT(95,230,40,12),USE(?Delete),KEY(DeleteKey)
                       BUTTON('&Beigt'),AT(200,230,40,12),USE(?Close)
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
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?List)
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
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE FIELD()
    OF ?List
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?Insert
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AU_TEX::Used = 0
    CheckOpen(AU_TEX,1)
  END
  AU_TEX::Used += 1
  BIND(AUX:RECORD)
  FilesOpened = True
  OPEN(BrowseWindow)
  WindowOpened=True
  INIRestoreWindow('BrowseAU_TEX','winlats.INI')
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?List{Prop:Alrt,252} = MouseLeft2
  ?List{Prop:Alrt,255} = InsertKey
  ?List{Prop:Alrt,254} = DeleteKey
  ?List{Prop:Alrt,253} = CtrlEnter
  ?List{Prop:Alrt,252} = MouseLeft2
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
    AU_TEX::Used -= 1
    IF AU_TEX::Used = 0 THEN CLOSE(AU_TEX).
  END
  IF WindowOpened
    INISaveWindow('BrowseAU_TEX','winlats.INI')
    CLOSE(BrowseWindow)
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
  IF BrowseWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?List{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  AUX:AUT_TEXT = BRW1::AUX:AUT_TEXT
  AUX:DATUMS = BRW1::AUX:DATUMS
  AUX:PAR_AUT0 = BRW1::AUX:PAR_AUT0
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  BRW1::AUX:AUT_TEXT = AUX:AUT_TEXT
  BRW1::AUX:DATUMS = AUX:DATUMS
  BRW1::AUX:PAR_AUT0 = AUX:PAR_AUT0
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?List)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert)
      POST(Event:Accepted,?Change)
      POST(Event:Accepted,?Delete)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?List{Prop:Items}
      IF ?List{Prop:VScroll} = False
        ?List{Prop:VScroll} = True
      END
    ELSE
      IF ?List{Prop:VScroll} = True
        ?List{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?List{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  CASE BRW1::SortOrder
  OF 1
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?List{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
  END
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?List{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?List{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert)
    OF DeleteKey
      POST(Event:Accepted,?Delete)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert)
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?List{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?List)
  ELSIF ?List{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?List)
  ELSE
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse,BRW1::RecordCount)         ! Get the first queue item
    ELSE
      GET(Queue:Browse,1)                         ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'AU_TEX')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?List{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse,1)                     ! Get the first queue item
        ELSE
          GET(Queue:Browse,BRW1::RecordCount)     ! Get the first queue item
        END
        DELETE(Queue:Browse)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse)
      ELSE
        ADD(Queue:Browse,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(AU_TEX)
      RESET(AU_TEX,BRW1::HighlightedPosition)
      BRW1::HighlightedPosition = ''
    ELSE
      IF POSITION(AU_TEX)
        RESET(AU_TEX,POSITION(AU_TEX))
      ELSE
        SET(AU_TEX)
      END
    END
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse)
    GET(Queue:Browse,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse,RECORDS(Queue:Browse))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?List{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?List{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change{Prop:Disable} = 0
    ?Delete{Prop:Disable} = 0
  ELSE
    CLEAR(AUX:Record)
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
    ?Delete{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    SET(AU_TEX)
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?List
  BrowseButtons.InsertButton=?Insert
  BrowseButtons.ChangeButton=?Change
  BrowseButtons.DeleteButton=?Delete
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(AU_TEX,0)
  CLEAR(AUX:Record,0)
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?List)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?List)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?List)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| () is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(AU_TEX,0)
        CLEAR(AUX:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?List{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


