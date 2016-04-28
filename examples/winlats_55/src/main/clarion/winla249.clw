                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_ObjKops            PROCEDURE                    ! Declare Procedure
P_TABLE           QUEUE,PRE(P)
OBJ_NR               ULONG
PAR_NR               ULONG
DOK_SENR             STRING(14)
U_NR                 ULONG
DATUMS               LONG
SUMMA                DECIMAL(12,2)
BKK                  STRING(5)
                  .
NPK                  DECIMAL(4)
NOS_P                STRING(25)
NOS_PN               STRING(60)
DAT                  LONG
LAI                  TIME
FILTRS_TEXT          STRING(60)
SAV_OBJ_NR           ULONG
PROJ_K_SUMMA         DECIMAL(12,2)
PROJ_K_SUMMA_IE      DECIMAL(12,2)
PROJ_K_SUMMA_IZ      DECIMAL(12,2)
PROJ_SUMMA           DECIMAL(12,2)
PROJ_SUMMA_IE        DECIMAL(12,2)
PROJ_SUMMA_IZ        DECIMAL(12,2)
CG                   STRING(10)
CP                   STRING(3)
LINEH                STRING(190)
PAMATOJUMS           STRING(60)
VIRSRAKSTS           STRING(100)

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
report REPORT,AT(198,1583,8000,9396),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1385),USE(?unnamed)
         LINE,AT(5104,885,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(5677,885,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6667,885,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(7083,885,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(365,885,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(52,1354,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Nr.'),AT(6698,1146,365,208),USE(?String8:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7115,1146,677,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:ANSI)
         STRING('Konta'),AT(6698,938,365,208),USE(?String8:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7813,885,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Dokum.'),AT(5135,938,521,208),USE(?String8:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(7115,938,677,208),USE(?String8:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(5708,1146,938,208),USE(?String8:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(5135,1146,521,208),USE(?String8:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokumenta'),AT(5708,938,938,208),USE(?String8:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1813,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(250,417,7604,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1500,635,5104,208),USE(FILTRS_TEXT),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7083,677,,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(52,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Npk'),AT(104,1042),USE(?String8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Saòçmçjs (Pârdevçjs)'),AT(396,1042,1458,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatojums'),AT(1906,1042,3177,208),USE(?String9:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1875,885,0,521),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(52,885,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:3)
         STRING(@S25),AT(396,10,1458,156),USE(NOS_P),LEFT
         STRING(@S14),AT(5719,10,885,156),USE(P:DOK_SENR),RIGHT
         STRING(@D05.B),AT(5146,10,469,156),USE(P:DATUMS)
         STRING(@N-_11.2B),AT(7125,10,625,156),USE(P:SUMMA),RIGHT
         LINE,AT(1875,-10,0,197),USE(?Line5:3),COLOR(COLOR:Black)
         LINE,AT(365,-10,0,197),USE(?Line5:2),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,197),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(5677,-10,0,197),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,197),USE(?Line5:9),COLOR(COLOR:Black)
         STRING(@s5),AT(6708,10,365,156),USE(P:BKK),LEFT,FONT(,8,,,CHARSET:ANSI)
         LINE,AT(7083,-10,0,197),USE(?Line5:8),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,197),USE(?Line5:20),COLOR(COLOR:Black)
         STRING(@S50),AT(1917,10,3177,156),USE(PAMATOJUMS),LEFT
         LINE,AT(52,-10,0,197),USE(?Line5),COLOR(COLOR:Black)
         STRING(@n4B),AT(94,10,260,156),USE(npk),LEFT
       END
detailP DETAIL,AT(,-10,,271),USE(?unnamed:2)
         STRING(@S60),AT(406,104,3802,156),USE(NOS_PN),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,260,7760,0),USE(?Line143:3),COLOR(COLOR:Black)
         LINE,AT(365,0,0,260),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(7083,0,0,260),USE(?Line55:8),COLOR(COLOR:Black)
         LINE,AT(7813,0,0,260),USE(?Line55:20),COLOR(COLOR:Black)
         LINE,AT(1875,0,0,62),USE(?Line159:2),COLOR(COLOR:Black)
         LINE,AT(52,0,0,260),USE(?Line55),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(7135,104,625,156),USE(PROJ_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6438,104,625,156),USE(PROJ_SUMMA_IZ),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksas'),AT(5656,104,781,156),USE(?String9:4),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(4906,104,625,156),USE(PROJ_SUMMA_IE),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòçmumi'),AT(4146,104,781,156),USE(?String9:3),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,52,7760,0),USE(?Line143:2),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,62),USE(?Line159:7),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,62),USE(?Line159:6),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,62),USE(?Line159:5),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0),USE(?unnamed:5)
         LINE,AT(52,0,7760,0),USE(?Line143:4),COLOR(COLOR:Black)
       END
REP_FOOT DETAIL,AT(,,,458),USE(?unnamed:4)
         LINE,AT(365,-10,0,280),USE(?Line133:15),COLOR(COLOR:Black)
         LINE,AT(7083,-10,0,280),USE(?Line133:132),COLOR(COLOR:Black)
         LINE,AT(7813,-10,0,280),USE(?Line133:14),COLOR(COLOR:Black)
         STRING('Pavisam:'),AT(469,104,,156),USE(?String36:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieòçmumi'),AT(4146,104,781,156),USE(?String9:5),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksas'),AT(5656,104,781,156),USE(?String9:6),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(7135,104,625,156),USE(PROJ_K_SUMMA),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(6438,104,625,156),USE(PROJ_K_SUMMA_IZ),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2B),AT(4906,104,625,156),USE(PROJ_K_SUMMA_IE),TRN,RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(52,260,7760,0),USE(?Line43:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(94,292),USE(?String46),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(552,292),USE(ACC_kods),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING('RS:'),AT(1240,292),USE(?String96),FONT(,7,,,CHARSET:ANSI)
         STRING(@S1),AT(1427,292),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6760,292),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(7344,292),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(52,-10,0,280),USE(?Line133:16),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11000,8000,52)
         LINE,AT(52,0,7760,0),USE(?Line43:3),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1

  VIRSRAKSTS='6,7,81600,82600,81900,82900 grupas PROJEKTU (OBJ.) kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)

  BIND(GGK:RECORD)
  BIND('CG',CG)
  BIND('KKK',KKK)
  BIND('CP',CP)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CYCLEPAR_K',CYCLEPAR_K)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
   ProgressWindow{Prop:Text} = '6,7,81600,82600,81900,82900 grupas projektu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ggk:RECORD)
      GGK:BKK='6'
      SET(GGK:BKK_DAT)
      CG='K120011'
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
      IF F:NODALA THEN FILTRS_TEXT='F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
      IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Projekta: '&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('OBJKOPS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(VIRSRAKSTS)
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(FILTRS_TEXT)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
             OUTA:LINE='Npk'&CHR(9)&'Saòçmçjs'&CHR(9)&'Pamatojums'&CHR(9)&'Dokumenta'&CHR(9)&|
             'Dokumenta'&CHR(9)&'Konts'&CHR(9)&'Summa'
             ADD(OUTFILEANSI)
             OUTA:LINE='Npk'&CHR(9)&'(Pârdevçjs)'&CHR(9)&'Pamatojums'&CHR(9)&'datums'&CHR(9)&|
             'numurs'&CHR(9)&CHR(9)&' Ls'
          ELSE !WORD
             OUTA:LINE='Npk'&CHR(9)&'Saòçmçjs (Pârdevçjs)'&CHR(9)&'Pamatojums'&CHR(9)&'Dokumenta datums'&CHR(9)&|
            'Dokumenta numurs'&CHR(9)&'Konts'&CHR(9)&'Summa Ls'
          .
          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        nk#+=1
        ?Progress:UserString{Prop:Text}=NK#
        DISPLAY(?Progress:UserString)
        IF ((GGK:BKK[1]='6' AND GGK:D_K='K') OR (GGK:BKK[1]='7' AND GGK:D_K='D') OR |
          (GGK:BKK='81600' AND GGK:D_K='K') OR (GGK:BKK='82600' AND GGK:D_K='D') OR |
          (GGK:BKK='81900' AND GGK:D_K='K') OR (GGK:BKK='82900' AND GGK:D_K='D')) AND ~CYCLEGGK(CG) AND GGK:OBJ_NR
            IF ~GETGG(GGK:U_NR)
               KLUDA(5,'GGK:U_NR:'&GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
            .
            P:OBJ_NR=GGK:OBJ_NR
            P:PAR_NR=GGK:PAR_NR
            P:DATUMS=GGK:DATUMS
            P:BKK   =GGK:BKK
            P:U_NR  =GGK:U_NR
            IF GGK:D_K='K'
               P:SUMMA=GGK:SUMMA
            ELSE
               P:SUMMA=-GGK:SUMMA
            .
            P:DOK_SENR=GG:DOK_SENR
            ADD(P_TABLE)
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

!---------P_TABLÇ TAGAD IR VISAS P/Z OBJEKTIEM 6/7 KONTIEM-----------------
  SORT(P_TABLE,P:OBJ_NR)
  SAV_OBJ_NR=0
  GET(P_TABLE,0)
  LOOP P#= 1 TO RECORDS(P_TABLE)
     GET(P_TABLE,P#)
     IF P#=1
        SAV_OBJ_NR=P:OBJ_NR
     .
     IF ~(P:OBJ_NR=SAV_OBJ_NR)     !MAINÎJIES PROJEKTS
        NOS_PN= 'Kopâ: '&clip(SAV_OBJ_NR)&' '&GETPROJEKTI(SAV_OBJ_NR,1)
        IF F:DBF='W'
            PRINT(RPT:DETAILP)
        ELSE
            OUTA:LINE=CHR(9)&CLIP(NOS_PN)&CHR(9)&'Ieòemumi:'&CHR(9)&LEFT(FORMAT(PROJ_SUMMA_IE,@N-_11.2B))&CHR(9)&|
            'Izmaksas:'&CHR(9)&LEFT(FORMAT(PROJ_SUMMA_IZ,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PROJ_SUMMA,@N-_11.2B))
            ADD(OUTFILEANSI)
        END
        PROJ_summa=0
        SAV_OBJ_NR=P:OBJ_NR
        PROJ_SUMMA_IE = 0
        PROJ_SUMMA_IZ = 0
     .
     NPK+=1
     NOS_P=GETPAR_K(P:PAR_NR,0,1)
     G#=GETGG(P:U_NR)
     TEKSTS = clip(GG:SATURS)&' '&clip(GG:SATURS2)&' '&clip(GG:SATURS3)
     FORMAT_TEKSTS(81,'Arial',8,'')
     PAMATOJUMS = F_TEKSTS[1]
     IF F:DBF='W'
         PRINT(RPT:DETAIL)
     ELSE
        OUTA:LINE=FORMAT(NPK,@N4B)&CHR(9)&CLIP(NOS_P)&CHR(9)&CLIP(PAMATOJUMS)&CHR(9)&FORMAT(P:DATUMS,@D06.)&CHR(9)&|
        CLIP(P:DOK_SENR)&CHR(9)&P:BKK&CHR(9)&LEFT(FORMAT(P:SUMMA,@N-_11.2))
        ADD(OUTFILEANSI)
     END
     PROJ_SUMMA      += P:SUMMA
     PROJ_K_SUMMA    += P:SUMMA
     IF P:SUMMA>0
        PROJ_K_SUMMA_IE += P:SUMMA
        PROJ_SUMMA_IE   += P:SUMMA
     ELSE
        PROJ_K_SUMMA_IZ += P:SUMMA
        PROJ_SUMMA_IZ   += P:SUMMA
     .
  .
  IF ~F:OBJ_NR
     NOS_PN= 'Kopâ: '&clip(SAV_OBJ_NR)&' '&GETPROJEKTI(SAV_OBJ_NR,1)
     IF F:DBF='W'
       PRINT(RPT:DETAILP)
     ELSE
       OUTA:LINE=CHR(9)&CLIP(NOS_PN)&CHR(9)&'Ieòemumi:'&CHR(9)&LEFT(FORMAT(PROJ_SUMMA_IE,@N-_11.2B))&CHR(9)&|
       'Izmaksas:'&CHR(9)&LEFT(FORMAT(PROJ_SUMMA_IZ,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PROJ_SUMMA,@N-_11.2B))
       ADD(OUTFILEANSI)
     END
  ELSE
     IF F:DBF='W'
       PRINT(RPT:LINE)
     .
  .
  dat = today()
  lai = clock()
  IF F:DBF='W'
      PRINT(RPT:REP_FOOT)
  ELSE
       OUTA:LINE=CHR(9)&'Pavisam:'&CHR(9)&'Ieòemumi:'&CHR(9)&LEFT(FORMAT(PROJ_K_SUMMA_IE,@N-_11.2B))&CHR(9)&|
       'Izmaksas:'&CHR(9)&LEFT(FORMAT(PROJ_K_SUMMA_IZ,@N-_11.2B))&CHR(9)&LEFT(FORMAT(PROJ_K_SUMMA,@N-_11.2B))
       ADD(OUTFILEANSI)
  END
  IF SEND(GGK,'QUICKSCAN=off').
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
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(A_TABLE)
  FREE(P_TABLE)
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
  IF ERRORCODE() OR GGK:BKK>'82900'
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
      ?Progress:PctText{Prop:Text} = 'Analizçti '&FORMAT(PercentProgress,@N3) & '% DB'
      DISPLAY()
    END
  END
Sel_NOM_Tips PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
NOM_tips11   string(1)
NOM_tips12   string(1)
NOM_tips13   string(1)
NOM_tips14   string(1)
NOM_tips15   string(1)
NOM_tips16   string(1)
NOM_tips17   string(1)
window               WINDOW('Nomenklatûras tips'),AT(,,103,101),GRAY
                       CHECK('Prece'),AT(6,6),USE(NOM_TIPS11),VALUE('P','')
                       CHECK('Tara'),AT(6,18),USE(NOM_TIPS12),VALUE('T','')
                       CHECK('A-Pakalpojumi'),AT(6,30),USE(NOM_TIPS13),VALUE('A','')
                       CHECK('Raþojums'),AT(6,53),USE(NOM_TIPS15),VALUE('R','')
                       CHECK('Iepakojums'),AT(6,65),USE(NOM_TIPS16),VALUE('I','')
                       CHECK('Virtuâla'),AT(6,78),USE(NOM_TIPS17),VALUE('V','')
                       CHECK('Kokmateriâli'),AT(6,41),USE(NOM_TIPS14),VALUE('K','')
                       BUTTON('&OK'),AT(61,84,37,14),USE(?OkButton),DEFAULT
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  NOM_tips11 = NOM_tips7[1]
  NOM_tips12 = NOM_tips7[2]
  NOM_tips13 = NOM_tips7[3]
  NOM_tips14 = NOM_tips7[4]
  NOM_tips15 = NOM_tips7[5]
  NOM_tips16 = NOM_tips7[6]
  NOM_tips17 = NOM_tips7[7]
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?NOM_TIPS11)
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
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOM_tips7[1] = NOM_tips11
        NOM_tips7[2] = NOM_tips12
        NOM_tips7[3] = NOM_tips13
        NOM_tips7[4] = NOM_tips14
        NOM_tips7[5] = NOM_tips15
        NOM_tips7[6] = NOM_tips16
        NOM_tips7[7] = NOM_tips17
        LocalResponse = RequestCompleted
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('Sel_NOM_Tips','winlats.INI')
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
    INISaveWindow('Sel_NOM_Tips','winlats.INI')
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
F_GRAFIKS            PROCEDURE                    ! Declare Procedure
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

DIENA               BYTE
GRAF                STRING(1),DIM(48)
VUT                 STRING(50)
!-----------------------------------------------------------------------------
Process:View         VIEW(GRAFIKS)
                       PROJECT(GRA:ID)
                       PROJECT(GRA:INI)
                     END
!-----------------------------------------------------------------------------
Report REPORT,AT(150,846,8000,10500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(150,200,8000,646),USE(?unnamed:2)
         STRING(@s45),AT(1771,104,4531,208),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('DARBA LAIKA GRAFIKS'),AT(3021,365,2031,260),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
       END
Page_Header DETAIL,AT(,,,1125),USE(?unnamed:3)
         STRING('Darbinieks:'),AT(156,52,781,208),USE(?String3),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(938,52,3750,208),USE(VUT),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Mçnesis:'),AT(4792,52,625,208),USE(?String5),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D16),AT(5417,52,521,208),USE(GRA:YYYYMM),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,260,7760,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,260,0,885),USE(?Line3),COLOR(COLOR:Black)
         STRING('00:00 - 00:30'),AT(260,313,260,729),USE(?String7),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(365,260,0,885),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('00:30 - 01:00'),AT(417,313,260,729),USE(?String7:9),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('01:00 - 01:30'),AT(573,313,260,729),USE(?String7:37),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(833,260,0,885),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('01:30 - 02:00'),AT(729,313,260,729),USE(?String7:39),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('02:00 - 02:30'),AT(885,313,260,729),USE(?String7:41),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(1146,260,0,885),USE(?Line3:5),COLOR(COLOR:Black)
         STRING('02:30 - 03:00'),AT(1042,313,260,729),USE(?String7:43),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(1302,260,0,885),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('03:00 - 03:30'),AT(1198,313,260,729),USE(?String7:44),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(1458,260,0,885),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(1615,260,0,885),USE(?Line3:8),COLOR(COLOR:Black)
         STRING('03:30 - 04:00'),AT(1354,313,260,729),USE(?String7:45),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('04:00 - 04:30'),AT(1510,313,260,729),USE(?String7:46),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(1771,260,0,885),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(1927,260,0,885),USE(?Line3:10),COLOR(COLOR:Black)
         STRING('04:30 - 05:00'),AT(1667,313,260,729),USE(?String7:50),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(2083,260,0,885),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(2240,260,0,885),USE(?Line3:12),COLOR(COLOR:Black)
         STRING('23:30 - 24:00'),AT(7604,313,260,729),USE(?String7:23),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(7865,260,0,885),USE(?Line3:47),COLOR(COLOR:Black)
         STRING('Datums'),AT(52,313,260,729),USE(?String7:10),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(2396,260,0,885),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(2552,260,0,885),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(2708,260,0,885),USE(?Line3:15),COLOR(COLOR:Black)
         STRING('07:00 - 07:30'),AT(2448,313,260,729),USE(?String7:55),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('07:30 - 08:00'),AT(2604,313,260,729),USE(?String7:56),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('09:00 - 09:30'),AT(3073,313,260,729),USE(?String7:33),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3333,260,0,885),USE(?Line3:19),COLOR(COLOR:Black)
         STRING('21:00 - 21:30'),AT(6823,313,260,729),USE(?String7:11),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('21:30 - 22:00'),AT(6979,313,260,729),USE(?String7:13),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('13:00 - 13:30'),AT(4323,313,260,729),USE(?String7:6),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(4583,260,0,885),USE(?Line3:27),COLOR(COLOR:Black)
         STRING('10:30 - 11:00'),AT(3542,313,260,729),USE(?String7:7),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3802,260,0,885),USE(?Line3:22),COLOR(COLOR:Black)
         STRING('11:00 - 11:30'),AT(3698,313,260,729),USE(?String7:5),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3958,260,0,885),USE(?Line3:23),COLOR(COLOR:Black)
         STRING('08:00 - 08:30'),AT(2760,313,260,729),USE(?String7:3),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('14:00 - 14:30'),AT(4635,313,260,729),USE(?String7:17),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(4896,260,0,885),USE(?Line3:29),COLOR(COLOR:Black)
         STRING('14:30 - 15:00'),AT(4792,313,260,729),USE(?String7:19),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5052,260,0,885),USE(?Line3:30),COLOR(COLOR:Black)
         LINE,AT(5208,260,0,885),USE(?Line3:31),COLOR(COLOR:Black)
         STRING('19:30 - 20:00'),AT(6354,313,260,729),USE(?String7:62),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(6615,260,0,885),USE(?Line3:40),COLOR(COLOR:Black)
         STRING('16:00 - 16:30'),AT(5260,313,260,729),USE(?String7:59),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5521,260,0,885),USE(?Line3:33),COLOR(COLOR:Black)
         STRING('16:30 - 17:00'),AT(5417,313,260,729),USE(?String7:60),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5677,260,0,885),USE(?Line3:34),COLOR(COLOR:Black)
         STRING('07:00'),AT(9948,313,313,156),USE(?String7:30),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
         STRING('07:30'),AT(10260,313,313,156),USE(?String7:28),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3021,260,0,885),USE(?Line3:17),COLOR(COLOR:Black)
         LINE,AT(2865,260,0,885),USE(?Line3:16),COLOR(COLOR:Black)
         LINE,AT(990,260,0,885),USE(?Line3:4),COLOR(COLOR:Black)
         LINE,AT(677,260,0,885),USE(?Line3:2),COLOR(COLOR:Black)
         STRING('22:30 - 23:00'),AT(7292,313,260,729),USE(?String7:42),TRN,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(7552,260,0,885),USE(?Line3:45),COLOR(COLOR:Black)
         STRING('23:00 - 23:30'),AT(7448,313,260,729),USE(?String7:47),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(7708,260,0,885),USE(?Line3:46),COLOR(COLOR:Black)
         STRING('12:30 - 13:00'),AT(4167,313,260,729),USE(?String7:48),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('09:30 - 10:00'),AT(3229,313,260,729),USE(?String7:58),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3490,260,0,885),USE(?Line3:20),COLOR(COLOR:Black)
         STRING('10:00 - 10:30'),AT(3385,313,260,729),USE(?String7:49),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3646,260,0,885),USE(?Line3:21),COLOR(COLOR:Black)
         STRING('05:00 - 05:30'),AT(1823,313,260,729),USE(?String7:51),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('05:30 - 06:00'),AT(1979,313,260,729),USE(?String7:52),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('06:00 - 06:30'),AT(2135,313,260,729),USE(?String7:53),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('06:30 - 07:00'),AT(2292,313,260,729),USE(?String7:54),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('17:30 - 18:00'),AT(5729,313,260,729),USE(?String7:61),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5990,260,0,885),USE(?Line3:36),COLOR(COLOR:Black)
         STRING('18:00 - 18:30'),AT(5885,313,260,729),USE(?String7:57),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(6146,260,0,885),USE(?Line3:37),COLOR(COLOR:Black)
         LINE,AT(6302,260,0,885),USE(?Line3:38),COLOR(COLOR:Black)
         STRING('08:30 - 09:00'),AT(2917,313,260,729),USE(?String7:34),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(3177,260,0,885),USE(?Line3:18),COLOR(COLOR:Black)
         STRING('22:00 - 22:30'),AT(7135,313,260,729),USE(?String7:4),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(7396,260,0,885),USE(?Line3:44),COLOR(COLOR:Black)
         STRING('13:30 - 14:00'),AT(4479,313,260,729),USE(?String7:14),TRN,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(4740,260,0,885),USE(?Line3:28),COLOR(COLOR:Black)
         STRING('11:30 - 12:00'),AT(3854,313,260,729),USE(?String7:15),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(4115,260,0,885),USE(?Line3:24),COLOR(COLOR:Black)
         STRING('12:00 - 12:30'),AT(4010,313,260,729),USE(?String7:2),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(4271,260,0,885),USE(?Line3:25),COLOR(COLOR:Black)
         LINE,AT(4427,260,0,885),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('20:00 - 20:30'),AT(6510,313,260,729),USE(?String7:16),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(6771,260,0,885),USE(?Line3:41),COLOR(COLOR:Black)
         STRING('20:30 - 21:00'),AT(6667,313,260,729),USE(?String7:18),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(7083,260,0,885),USE(?Line3:48),COLOR(COLOR:Black)
         LINE,AT(6927,260,0,885),USE(?Line3:42),COLOR(COLOR:Black)
         LINE,AT(7240,260,0,885),USE(?Line3:43),COLOR(COLOR:Black)
         STRING('15:00 - 15:30'),AT(4948,313,260,729),USE(?String7:20),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('15:30 - 16:00'),AT(5104,313,260,729),USE(?String7:22),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5365,260,0,885),USE(?Line3:32),COLOR(COLOR:Black)
         STRING('19:00 - 19:30'),AT(6198,313,260,729),USE(?String7:24),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(6458,260,0,885),USE(?Line3:39),COLOR(COLOR:Black)
         STRING('18:30 - 19:00'),AT(6042,313,260,729),USE(?String7:26),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         STRING('17:00 - 17:30'),AT(5573,313,260,729),USE(?String7:8),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC), |
             ANGLE(900)
         LINE,AT(5833,260,0,885),USE(?Line3:35),COLOR(COLOR:Black)
         STRING('07:30'),AT(9948,469,313,156),USE(?String7:29),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
         STRING('08:00'),AT(10260,469,313,156),USE(?String7:27),TRN,CENTER,FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1094,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(104,260,0,885),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,-10,,156),USE(?unnamed:4)
         STRING(@s1),AT(417,10,104,156),USE(GRAF[1]),CENTER,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(521,0,0,177),USE(?Line52:5),COLOR(COLOR:Black)
         STRING(@s1),AT(573,10,104,156),USE(GRAF[2]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(677,0,0,177),USE(?Line52:49),COLOR(COLOR:Black)
         STRING(@s1),AT(729,10,104,156),USE(GRAF[3]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(833,0,0,177),USE(?Line52:48),COLOR(COLOR:Black)
         STRING(@s1),AT(885,10,104,156),USE(GRAF[4]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(990,0,0,177),USE(?Line52:47),COLOR(COLOR:Black)
         STRING(@s1),AT(1042,10,104,156),USE(GRAF[5]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1146,0,0,177),USE(?Line52:4),COLOR(COLOR:Black)
         STRING(@s1),AT(1198,10,104,156),USE(GRAF[6]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1302,0,0,177),USE(?Line52:3),COLOR(COLOR:Black)
         STRING(@s1),AT(1354,10,104,156),USE(GRAF[7]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1458,0,0,177),USE(?Line52:46),COLOR(COLOR:Black)
         STRING(@s1),AT(1510,10,104,156),USE(GRAF[8]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1615,0,0,177),USE(?Line52:45),COLOR(COLOR:Black)
         STRING(@s1),AT(1667,10,104,156),USE(GRAF[9]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1771,0,0,177),USE(?Line52:44),COLOR(COLOR:Black)
         STRING(@s1),AT(1823,10,104,156),USE(GRAF[10]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(1927,0,0,177),USE(?Line52:43),COLOR(COLOR:Black)
         STRING(@s1),AT(1979,10,104,156),USE(GRAF[11]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         STRING(@s1),AT(2135,10,104,156),USE(GRAF[12]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(2240,0,0,177),USE(?Line52:41),COLOR(COLOR:Black)
         STRING(@s1),AT(2292,10,104,156),USE(GRAF[13]),CENTER,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(2396,0,0,177),USE(?Line52:40),COLOR(COLOR:Black)
         STRING(@s1),AT(2448,10,104,156),USE(GRAF[14]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(2552,0,0,177),USE(?Line52:39),COLOR(COLOR:Black)
         STRING(@s1),AT(2604,10,104,156),USE(GRAF[15]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(2708,0,0,177),USE(?Line52:38),COLOR(COLOR:Black)
         STRING(@s1),AT(2760,10,104,156),USE(GRAF[16]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(2865,0,0,177),USE(?Line52:37),COLOR(COLOR:Black)
         STRING(@s1),AT(2917,10,104,156),USE(GRAF[17]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3021,0,0,177),USE(?Line52:36),COLOR(COLOR:Black)
         STRING(@s1),AT(3073,10,104,156),USE(GRAF[18]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3177,0,0,177),USE(?Line52:35),COLOR(COLOR:Black)
         STRING(@s1),AT(3229,10,104,156),USE(GRAF[19]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3333,0,0,177),USE(?Line52:34),COLOR(COLOR:Black)
         STRING(@s1),AT(3385,10,104,156),USE(GRAF[20]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3490,0,0,177),USE(?Line52:33),COLOR(COLOR:Black)
         STRING(@s1),AT(3542,10,104,156),USE(GRAF[21]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3646,0,0,177),USE(?Line52:32),COLOR(COLOR:Black)
         STRING(@s1),AT(3698,10,104,156),USE(GRAF[22]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3802,0,0,177),USE(?Line52:31),COLOR(COLOR:Black)
         STRING(@s1),AT(3854,10,104,156),USE(GRAF[23]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3958,0,0,177),USE(?Line52:30),COLOR(COLOR:Black)
         STRING(@s1),AT(4010,10,104,156),USE(GRAF[24]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4115,0,0,177),USE(?Line52:29),COLOR(COLOR:Black)
         STRING(@s1),AT(4167,10,104,156),USE(GRAF[25]),CENTER,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(4271,0,0,177),USE(?Line52:28),COLOR(COLOR:Black)
         STRING(@s1),AT(4323,10,104,156),USE(GRAF[26]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4427,0,0,177),USE(?Line52:27),COLOR(COLOR:Black)
         STRING(@s1),AT(4479,10,104,156),USE(GRAF[27]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4583,0,0,177),USE(?Line52:26),COLOR(COLOR:Black)
         STRING(@s1),AT(4635,10,104,156),USE(GRAF[28]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4740,0,0,177),USE(?Line52:25),COLOR(COLOR:Black)
         STRING(@s1),AT(4792,10,104,156),USE(GRAF[29]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(4896,0,0,177),USE(?Line52:24),COLOR(COLOR:Black)
         STRING(@s1),AT(4948,10,104,156),USE(GRAF[30]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5052,0,0,177),USE(?Line52:23),COLOR(COLOR:Black)
         STRING(@s1),AT(5104,10,104,156),USE(GRAF[31]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5208,0,0,177),USE(?Line52:22),COLOR(COLOR:Black)
         STRING(@s1),AT(5260,10,104,156),USE(GRAF[32]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5365,0,0,177),USE(?Line52:21),COLOR(COLOR:Black)
         STRING(@s1),AT(5417,10,104,156),USE(GRAF[33]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5521,0,0,177),USE(?Line52:20),COLOR(COLOR:Black)
         STRING(@s1),AT(5573,10,104,156),USE(GRAF[34]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         STRING(@s1),AT(5729,10,104,156),USE(GRAF[35]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5833,0,0,177),USE(?Line52:18),COLOR(COLOR:Black)
         STRING(@s1),AT(5885,10,104,156),USE(GRAF[36]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(5990,0,0,177),USE(?Line52:17),COLOR(COLOR:Black)
         STRING(@s1),AT(6042,10,104,156),USE(GRAF[37]),CENTER,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(6146,0,0,177),USE(?Line52:16),COLOR(COLOR:Black)
         STRING(@s1),AT(6198,10,104,156),USE(GRAF[38]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6302,0,0,177),USE(?Line52:15),COLOR(COLOR:Black)
         STRING(@s1),AT(6354,10,104,156),USE(GRAF[39]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6458,0,0,177),USE(?Line52:14),COLOR(COLOR:Black)
         STRING(@s1),AT(6510,10,104,156),USE(GRAF[40]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6615,0,0,177),USE(?Line52:13),COLOR(COLOR:Black)
         STRING(@s1),AT(6667,10,104,156),USE(GRAF[41]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6771,0,0,177),USE(?Line52:12),COLOR(COLOR:Black)
         STRING(@s1),AT(6823,10,104,156),USE(GRAF[42]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6927,0,0,177),USE(?Line52:11),COLOR(COLOR:Black)
         STRING(@s1),AT(6979,10,104,156),USE(GRAF[43]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7083,0,0,177),USE(?Line52:10),COLOR(COLOR:Black)
         STRING(@s1),AT(7135,10,104,156),USE(GRAF[44]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7240,0,0,177),USE(?Line52:9),COLOR(COLOR:Black)
         STRING(@s1),AT(7292,10,104,156),USE(GRAF[45]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7396,0,0,177),USE(?Line52:8),COLOR(COLOR:Black)
         STRING(@s1),AT(7448,10,104,156),USE(GRAF[46]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7552,0,0,177),USE(?Line52:7),COLOR(COLOR:Black)
         STRING(@s1),AT(7604,10,104,156),USE(GRAF[47]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7708,0,0,177),USE(?Line52:6),COLOR(COLOR:Black)
         STRING(@s1),AT(7760,10,104,156),USE(GRAF[48]),CENTER,FONT('Arial',8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(7865,0,0,177),USE(?Line52:2),COLOR(COLOR:Black)
         LINE,AT(104,167,7760,0),USE(?Line101),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,177),USE(?Line52:19),COLOR(COLOR:Black)
         LINE,AT(2083,0,0,177),USE(?Line52:42),COLOR(COLOR:Black)
         LINE,AT(104,0,0,177),USE(?Line52),COLOR(COLOR:Black)
         STRING(@n2),AT(156,11,156,156),USE(Diena),RIGHT,FONT('Arial',8,,,CHARSET:BALTIC)
         LINE,AT(365,0,0,177),USE(?Line52:50),COLOR(COLOR:Black)
       END
PageAfter DETAIL,PAGEAFTER(-1),AT(,,,52),USE(?unnamed:6)
       END
       FOOTER,AT(150,9000,8000,52),USE(?unnamed)
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GRAFIKS::Used = 0
    CheckOpen(GRAFIKS,1)
  END
  GRAFIKS::Used += 1
  BIND(GRA:RECORD)
  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)

  FilesOpened = True
  RecordsToProcess = BYTES(GRAFIKS)
  RecordsPerCycle = 1000
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Darba laika grafiks'
  ?Progress:UserString{Prop:Text}=''
  SEND(GRAFIKS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GRA:RECORD)
      GRA:YYYYMM=S_DAT
      SET(GRA:YYYYMM_KEY,GRA:YYYYMM_KEY)
      Process:View{Prop:Filter} = '~(ID AND ~(GRA:ID=ID))'
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
      OPEN(Report)
      Report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         VUT = GETKADRI(GRA:ID,0,3)
         IF ~(F:NODALA AND ~(KAD:NODALA=F:NODALA))
            PRINT(RPT:Page_Header)
            DIENA=0
            M#=MONTH(GRA:YYYYMM)
            LOOP I#=1 TO 31
               IF MONTH(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM)))=M#
                  DIENA+=1
                  LOOP J#=1 TO 48
                     GRAF[J#]=GRA:G[I#,J#]
                  END
                  PRINT(RPT:detail)
               ELSE
                  PRINT(RPT:PageAfter)
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
  IF SEND(GRAFIKS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
    IF F:DBF='W'   !WMF
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
  IF FilesOpened
    ! Start of "End of Procedure, Before Closing Files"
    ! [Priority 5000]

    ! End of "End of Procedure, Before Closing Files"
    GRAFIKS::Used -= 1
    IF GRAFIKS::Used = 0 THEN CLOSE(GRAFIKS).
    ! Start of "End of Procedure, After Closing Files"
    ! [Priority 5000]

    ! End of "End of Procedure, After Closing Files"
  END
  ! Start of "End of Procedure"
  ! [Priority 5000]

  ! End of "End of Procedure"
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
  ! Start of "Validate Record: Range Checking"
  ! [Priority 5000]

  ! End of "Validate Record: Range Checking"
  RecordStatus = Record:Filtered
    ! Start of "Validate Record: Filter Checking"
    ! [Priority 5000]

    ! End of "Validate Record: Filter Checking"
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
  ! Start of "Top of GetNextRecord ROUTINE"
  ! [Priority 5000]

  ! End of "Top of GetNextRecord ROUTINE"
  NEXT(Process:View)
  ! Start of "GetNextRecord ROUTINE, after NEXT"
  ! [Priority 5000]

  ! End of "GetNextRecord ROUTINE, after NEXT"
  IF ERRORCODE() OR ~(GRA:YYYYMM <= B_DAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GRAFIKS')
    END
    LocalResponse = RequestCancelled
    ! Start of "GetNextRecord ROUTINE, NEXT failed"
    ! [Priority 5000]

    ! End of "GetNextRecord ROUTINE, NEXT failed"
    EXIT
  ELSE
    LocalResponse = RequestCompleted
    ! Start of "GetNextRecord ROUTINE, NEXT succeeds"
    ! [Priority 5000]

    ! End of "GetNextRecord ROUTINE, NEXT succeeds"
  END
  RecordsProcessed += BYTES(GRAFIKS)
  RecordsThisCycle += BYTES(GRAFIKS)
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

! Start of "Procedure Routines"
! [Priority 5000]

! End of "Procedure Routines"
