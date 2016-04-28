                     MEMBER('winlats.clw')        ! This is a MEMBER module
P_PLsaraksts         PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAMAT)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:DATUMS)
                     END
!-----------------------------------------------------------------------------

SAV_AMO_NODALA      LIKE(AMO:NODALA)
VIRSRAKSTS          STRING(80)
FILTRS_TEXT         STRING(100)
CP                  STRING(10)

VERT_SAK            DECIMAL(11,2)
VERT_BEI            DECIMAL(11,2)
VERT_SAKK           DECIMAL(11,2)
VERT_BEIK           DECIMAL(11,2)
KOPA                STRING(30)

DAT                 LONG
LAI                 LONG


!-----------------------------------------------------------------------------
report REPORT,AT(300,1550,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(300,300,8000,1250),USE(?unnamed:2)
         STRING('Datums'),AT(3521,969,625,156),USE(?String13:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzskaites konti'),AT(4375,896,1198,156),USE(?String13:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(5656,969,729,156),USE(?String13:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1198,7083,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@s45),AT(1281,42,4375,219),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s90),AT(125,302,6458,156),USE(VIRSRAKSTS),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma PL:4'),AT(6510,375,677,156),USE(?String11),RIGHT
         STRING(@P<<<#. lapaP),AT(6615,521,573,156),PAGENO,USE(?PageCount),RIGHT
         STRING('Izslçgð.'),AT(6458,813,625,156),USE(?String13:9),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(104,521,6458,156),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,7083,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1198,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3490,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5625,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6406,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,896,313,156),USE(?String13:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1458,896,1823,156),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PL numurs'),AT(500,896,677,156),USE(?String13:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ'),AT(5656,813,729,156),USE(?String13:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes'),AT(3510,813,625,156),USE(?String13:8),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(6458,969,625,156),USE(?String13:6),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(104,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_6B),AT(677,10,417,156),USE(PAM:U_NR),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(469,-10,0,197),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@S35),AT(1229,10,2240,156),USE(PAM:NOS_P),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3490,-10,0,197),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@D06.),AT(3521,0,625,156),USE(PAM:DATUMS),CENTER
         LINE,AT(4167,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5677,10,677,156),USE(VERT_SAK),RIGHT
         STRING(@D06.B),AT(6490,10,625,156),USE(PAM:END_DATE),TRN,CENTER
         LINE,AT(6406,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@S5),AT(4281,0,320,156),USE(PAM:BKK),TRN,CENTER,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S5),AT(4740,0,320,156),USE(PAM:BKKN),TRN,CENTER,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S5),AT(5208,0,320,156),USE(PAM:OKK7),TRN,CENTER,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5625,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@n4B),AT(156,10,260,156),USE(RPT_NPK#),RIGHT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
KOPA   DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(104,-10,0,197),USE(?Line486:10),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line476:12),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5677,21,677,156),USE(VERT_SAKK),TRN,RIGHT
         STRING(@S30),AT(188,21,1979,156),USE(KOPA),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6406,-10,0,197),USE(?Line475:65),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,197),USE(?Line473:46),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0),USE(?unnamed)
         LINE,AT(104,0,7083,0),USE(?Line1:4L),COLOR(COLOR:Black)
       END
RepFoot DETAIL,AT(,,,260),USE(?unnamed:5)
         LINE,AT(104,-10,0,62),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(104,52,7083,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,83),USE(?String59),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(656,83,552,146),USE(acc_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6083,83,615,146),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6719,83,458,146),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(5625,-10,0,62),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(6406,-10,0,62),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,62),USE(?Line79),COLOR(COLOR:Black)
       END
       FOOTER,AT(300,11000,8000,52)
         LINE,AT(104,0,7083,0),USE(?Line1:4),COLOR(COLOR:Black)
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

  DAT = TODAY()
  LAI = CLOCK()
  CP='1'
!  IF YEAR(TODAY())>DB_GADS !ESAM IEPRIEKÐÇJÂ GADÂ
!     B_DAT=DATE(12,31,DB_GADS)
!  ELSE
!     B_DAT=TODAY()
!  .
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND('GADS',GADS)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pamatlîdzekïu saraksts'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Pamatlîdzekïu Saraksts uz '&FORMAT(B_DAT,@D06.)
      IF F:KAT_NR>'000' THEN FILTRS_TEXT='Kategorija: '&F:KAT_NR[1]&'-'&F:KAT_NR[2:3].
      IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Objekta(Pr.): '&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
!      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1))' !NAV NOÒEMTS IEPR.G-OS
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
      ELSE
          IF ~OPENANSI('P_PLsaraksts.TXT')
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
          OUTA:LINE='Nr'&CHR(9)&'N'&CHR(9)&'Pr'&CHR(9)&'Atbildîgais'&CHR(9)&'Izg.gads'&CHR(9)&'Ieg.dat.'&CHR(9)& |
          'Expl.dat.'&CHR(9)&'Dok.Nr.'&CHR(9)&'Nosaukums'&CHR(9)&'BKK'&CHR(9)&'Noliet.'&CHR(9)&'Izm.konts'&CHR(9)&|
          'Iep.v.'&CHR(9)&'Kap.v.'&CHR(9)&'Nol1994'&CHR(9)&'Sâkuma vçrt.'&CHR(9)&'Sk.'&CHR(9)&'Kat.'&CHR(9)&|
          'LIN nol.'&CHR(9)&'GD nol.'&CHR(9)&'Noòemts'
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        VERT_SAK =0
        VERT_BEI =0
        RPT_NPK#+=1
!        Y#=GADS-YEAR(PAM:EXPL_DATUMS)+1           !GADA INDEKSS KONKRÇTAM P/L
!        IF ~INRANGE(Y#,1,15) THEN Y#=1.           !JA EXPL NODOD NÂK. GADÂ VAI GADS>2009
!        IF ~PAM:KAT[Y#] THEN Y#=1.                !JA EXPL NODOD NÂK. GADÂ VAI NAV RÇÍINÂTS NOLIETOJUMS
        Y#=1
        IF ~CYCLEKAT(PAM:KAT[Y#]) AND ~CYCLENODALA(PAM:NODALA)AND ~(F:OBJ_NR AND ~(PAM:OBJ_NR=F:OBJ_NR)) AND|
        PAM:DATUMS <= B_DAT !KATEGORIJA VAR MAINÎTIES REIZI GADÂ,OBJ NEMAINÂS
           VERT_SAK=PAM:BIL_V
           IF F:DBF='W'
              PRINT(RPT:detail)
           ELSE
              OUTA:LINE=PAM:U_NR&CHR(9)&PAM:NODALA&CHR(9)&PAM:OBJ_NR&CHR(9)&PAM:ATB_NOS&CHR(9)&PAM:IZG_GAD&CHR(9)& |
              FORMAT(PAM:DATUMS,@D06.)&CHR(9)&FORMAT(PAM:EXPL_DATUMS,@D06.)&CHR(9)&PAM:DOK_SENR&CHR(9)&PAM:NOS_P&CHR(9)&|
              PAM:BKK&CHR(9)&PAM:BKKN&CHR(9)&PAM:OKK7&CHR(9)&LEFT(FORMAT(PAM:IEP_V,@N_11.2))&CHR(9)&|
              LEFT(FORMAT(PAM:KAP_V,@N_11.2))&CHR(9)&LEFT(FORMAT(PAM:NOL_V,@N_11.2))&CHR(9)&|
              LEFT(FORMAT(PAM:BIL_V,@N_11.2))&CHR(9)&PAM:SKAITS&CHR(9)&FORMAT(PAM:KAT[1],@P#-##P)&CHR(9)&|
              LEFT(FORMAT(PAM:LIN_G_PR,@N_6.3))&CHR(9)&PAM:GD_PR[1]&CHR(9)&FORMAT(PAM:END_DATE,@D06.B)
              ADD(OUTFILEANSI)
           .
           VERT_SAKK+=PAM:BIL_V
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:LINE)
    KOPA='KOPÂ:'
    IF F:DBF='W'
       PRINT(RPT:KOPA)
    ELSE
       OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&|
       LEFT(FORMAT(VERT_SAKK,@N_11.2)) !&CHR(9)&LEFT(FORMAT(VERT_BEIK,@N_11.2))
       ADD(OUTFILEANSI)
    .
    
    IF F:DBF='W'
        PRINT(RPT:REPFOOT)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    .
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF<>'W' THEN F:DBF='W'.
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

K                    FUNCTION (GGK_BKK,CTRL_BKK)  ! Declare Procedure
CTRLX_BKK       STRING(5)
  CODE                                            ! Begin processed code
 !
 ! IZMANTO, LAI PÂRBAUDÎTU, VAI KONTS SÂKAS AR PIEPRASÎTO
 ! BIJA DOMÂTS ATGRIEZT ALT_BKK...DRAÒÍA JELDWEN
 !
 LEN#=LEN(CLIP(CTRL_BKK))
 IF GGK_BKK[1:LEN#]=CTRL_BKK[1:LEN#]
    RETURN(TRUE)
 .
 RETURN(FALSE)
GetKon_R             FUNCTION (UGP,R_KODS,REQ,RET) ! Declare Procedure
NULLES     STRING('00000')
  CODE                                            ! Begin processed code
 !
 !  R_KODS - PIEPRASÎTAIS KODS
 !  RET    - 1 ATGRIEÞ KONR:NOSAUKUMS
 !           2 ATGRIEÞ KONR:NOSAUKUMSA
 !           3 ATGRIEÞ KONR:USER 0/1
 !

 IF ~INRANGE(RET,1,3)
     STOP('GETKON_R:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN('')
 .
 IF ~INSTRING(UGP,'BPNK') OR R_KODS=0
    RET=0
 ELSE
    IF KON_R::USED=0
       CheckOpen(KON_R,1)
    .
    KON_R::Used += 1
    CLEAR(KONR:RECORD)
    KONR:UGP=UGP
    KONR:KODS=R_KODS
    GET(KON_R,KONR:UGP_KEY)
    IF ERROR()
       IF REQ = 2
          KLUDA(15,UGP&' '&R_KODS)
          RET=0
       ELSIF REQ=1
!          globalrequest=Selectrecord
!          BROWSEKON_K
!          IF GLOBALRESPONSE=REQUESTCOMPLETED
!             BKK=KON:BKK
!          ELSE
!             CLEAR(KON:RECORD)
!             KON:BKK='99999'
!             GET(KON_K,KON:BKK_KEY)
!             IF ERROR()
!                KON:KOMENT='Nepareizi kontçjumi'
!                ADD(KON_K)
!             .
!             BKK=KON:BKK
!          .
          RET=0
       ELSE
          RET=0
       .
    .
    KON_R::Used -= 1
    IF KON_R::Used = 0 THEN CLOSE(KON_R).
 .
 EXECUTE RET+1
    RETURN('')                  !
    RETURN(konR:NOSAUKUMS)      !1
    RETURN(konR:NOSAUKUMSA)     !2
    RETURN(konR:USER)           !3
 .
