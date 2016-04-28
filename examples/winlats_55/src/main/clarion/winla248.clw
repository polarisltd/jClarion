                     MEMBER('winlats.clw')        ! This is a MEMBER module
SPZ_AtbDekl          PROCEDURE                    ! Declare Procedure
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

NOM_NOS_P            STRING(40)
STANDARTS            STRING(42)
DER_TERM             STRING(8)

PIEGDAT              LONG
IZSNDAT              LONG
NOS_P                STRING(45) !saòçmçjs
RPT_CLIENT           STRING(35)
KESKA                STRING(60)
!TexTeksts            STRING(60)
KEKSIS               STRING(1)
REG_NR               STRING(11)
FIN_NR               STRING(13)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
!TEKTEKSTS            STRING(60)
ADRESEF              STRING(40)
PAV_NR               STRING(14)
PLKST                TIME
TELFAX               STRING(30)
DEKLARACIJA          STRING(100)
SYS_PARAKSTS         STRING(25)


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

report REPORT,AT(146,500,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
PAGE_HEAD DETAIL,AT(,,,1625),USE(?unnamed)
         STRING('Saskaòâ ar LVS-EN ISO/IEC 17050-1'),AT(2781,1094,2500,208),USE(?String1:5),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s52),AT(4552,354,3281,156),USE(GL:adrese),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(448,1385,7188,208),USE(DEKLARACIJA),CENTER(1),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(260,833,7552,208),USE(KESKA),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(4552,198,833,156),USE(fin_nr),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese:'),AT(4042,365,469,156),USE(?String1:3),RIGHT(1)
         STRING('tel/fakss:'),AT(3885,521,625,156),USE(?String1:4),TRN,RIGHT(1)
         STRING(@s30),AT(4552,521,1927,156),USE(TELFAX),TRN,LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4552,52,2969,156),USE(CLIENT),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Reì.Nr.:'),AT(4042,198,469,156),USE(?String1:386),RIGHT
         STRING('Piegâdâtâjs:'),AT(3885,42,625,156),USE(?String1:2),RIGHT(1)
       END
PAGE_HEAD1 DETAIL,AT(,,,313),USE(?unnamed:3)
         LINE,AT(2656,52,0,313),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(5365,52,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(6063,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:21),COLOR(COLOR:Black)
         STRING('Deklarâcijas objekts'),AT(417,104,2083,208),USE(?String38:2),CENTER
         STRING('Standarts-Dok.Nr-Nosaukums'),AT(2708,104,1823,208),USE(?String38:4),CENTER
         STRING('Izd.publ. dat.'),AT(5417,104,625,208),USE(?String38:5),TRN,CENTER
         STRING('Deklarâcija izsniegta pamat. uz'),AT(6094,104,1771,208),USE(?String38:3),LEFT(1)
         LINE,AT(104,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(104,313,7760,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(2656,0,0,177),USE(?Line8:30),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,177),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,177),USE(?Line8:27),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,177),USE(?Line8:28),COLOR(COLOR:Black)
         LINE,AT(104,0,0,177),USE(?Line8:32),COLOR(COLOR:Black)
         STRING(@s40),AT(146,10,2500,156),USE(NOM_NOS_P),LEFT
         STRING(@S42),AT(2698,10,2656,156),USE(STANDARTS),LEFT(1)
         STRING(@S8),AT(5396,10,625,156),USE(DER_TERM),CENTER
         STRING(@S21),AT(6094,10,2969,156),USE(nom:cits_tekstsPZ),TRN,LEFT(1)
       END
DETAIL1 DETAIL,AT(,,,63),USE(?unnamed:8)
         LINE,AT(104,0,0,60),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,60),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,60),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,60),USE(?Line39),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,60),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(104,31,7760,0),USE(?Line5:5),COLOR(COLOR:Black)
       END
DETAILEND DETAIL,AT(,,,63),USE(?unnamed:7)
         LINE,AT(104,0,0,60),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,60),USE(?Line55:2),COLOR(COLOR:Black)
         LINE,AT(5365,0,0,60),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6063,0,0,60),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7865,0,0,60),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(104,52,7760,0),USE(?Line5:7),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,WITHPRIOR(3),AT(,,,2052),USE(?unnamed:2)
         STRING('Papildus informâcija:'),AT(156,52,1302,208),USE(?String62:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Preèu Pavadzîme-Rçíins Nr.:'),AT(156,260,1510,208),USE(?String62:6),LEFT
         STRING('Preèu saòçmçjs:'),AT(156,677,938,208),USE(?String62:8),LEFT
         STRING(@S45),AT(1740,677,3125,208),USE(NOS_P),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdes datums:'),AT(156,469,938,208),USE(?String62:7),LEFT
         STRING(@D06.),AT(1740,469,677,208),USE(PAV:DATUMS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Piegâdes adrese:'),AT(156,885,938,208),USE(?String62:19),LEFT
         STRING(@s45),AT(1740,885,3333,208),USE(ADRESEF),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegðanas vieta:'),AT(156,1198,1146,208),USE(?String62:13),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s45),AT(1740,1198,3333,208),USE(ADRESE),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniegðanas datums:'),AT(156,1406,1250,208),USE(?String612:13),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@D06.),AT(1740,1406,625,208),USE(PAV:DATUMS,,?PAV:DATUMS:2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deklarâciju izsniedza:'),AT(156,1615,1302,208),USE(?String62:11),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s25),AT(1771,1875,1771,156),USE(SYS_PARAKSTS),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1458,1823,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         STRING(@s14),AT(1740,260,938,208),USE(PAV_NR),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
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
 CHECKOPEN(PAR_K,1)
 CHECKOPEN(PAVAD,1)
 CHECKOPEN(TEK_K,1)
 CHECKOPEN(BANKAS_K,1)

  PLKST = CLOCK()
  KESKA = 'ATBILSTÎBAS DEKLARÂCIJA Nr '&GETDOK_SENR(2,PAV:DOK_SENR,,'2')
! TEXTEKSTS=GETTEX(PAV:TEKSTS_NR,1)
  NOS_P=GETPAR_K(PAV:PAR_NR,2,3)
  ADRESEF = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
  RPT_CLIENT=CLIENT !?
  DEKLARACIJA=CLIP(CLIENT)&' deklarç, ka zemâk norâdîtâ produkcija atbilst sekojoðu dokumentu prasîbâm:'
  ADRESE=CLIP(SYS:ADRESE)
  TELFAX=clip(sys:tel)&','&CLIP(SYS:FAX)
  PAV_NR=PAV:DOK_SENR
  reg_nr=gl:reg_nr
  fin_nr=gl:VID_NR
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
  BIND(NOM:RECORD)
  BIND(PAR:RECORD)
  BIND(PAV:RECORD)
  BIND(TEK:RECORD)
  BIND(BAN:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Atbilstîbas deklarâcija'
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
      SETTARGET(REPORT)
      IMAGE(188,181,2083,521,'USER.BMP')
      PRINT(RPT:PAGE_HEAD)
      PRINT(RPT:PAGE_HEAD1)
      fillpvn(0)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        IF NPK#>1 THEN PRINT(RPT:DETAIL1).
        NOM_NOS_P=GETNOM_K(NOL:NOMENKLAT,0,2)
        STANDARTS=NOM:RINDA2PZ[1:42]
        DER_TERM =NOM:RINDA2PZ[43:50]
        PRINT(RPT:DETAIL)                           
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
    PRINT(RPT:DETAILEND)
    PRINT(RPT:RPT_FOOT)
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
B_PavReg             PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(gg)
                       PROJECT(GG:U_NR)
                       PROJECT(GG:RS)
                       PROJECT(GG:DOK_SENR)
                       PROJECT(GG:ATT_DOK)
                       PROJECT(GG:DOKDAT)
                       PROJECT(GG:DATUMS)
                       PROJECT(GG:PAR_NR)
                     END
!------------------------------------------------------------------------

CLIENT_RN            STRING(50)
NOS_P                STRING(25)
NOS_PP               STRING(25)
DOK_SE_NR            STRING(12)
RPT_NPK              DECIMAL(4)
PAR_PVN_PASE         STRING(13)
DAR_APR              STRING(25)
DAR_APRP             STRING(25)
STRINGVIRSRAKSTS     STRING(80)
SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(12,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
VALK                 STRING(3)
PRECE                DECIMAL(12,2)
TARA                 DECIMAL(12,2)
PAKALPOJUMI          DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)
ITOGO                DECIMAL(14,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
MUIK                 DECIMAL(10,2)
AKCIZE_DRN           DECIMAL(10,2)
AKCIZE_DRNK          DECIMAL(10,2)
CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
TRANSK               DECIMAL(10,2)
DIVI                 BYTE
PROJEKTS             STRING(50)
FORMA_TEXT           STRING(12)

!-------------------------------------------------------------------------
report REPORT,AT(198,1385,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,1188),USE(?unnamed)
         STRING('tîba (bez PVN)'),AT(6865,990,833,156),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un akcîzes'),AT(7750,833,885,156),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaides'),AT(8688,938,677,156),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr vai PVN maks.Nr'),AT(2531,938,1094,156),USE(?String10:22),TRN,CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darîjuma partneris'),AT(1135,938,1354,156),USE(?String10:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(4479,885,677,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darîjuma vçr-'),AT(6865,833,833,156),USE(?String10:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodokïi'),AT(7750,990,885,156),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,625,0,573),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s60),AT(2427,63,6146,260),USE(CLIENT_RN),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(2094,323,6823,260),USE(StringVirsraksts),TRN,CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s12),AT(10250,208,781,156),USE(FORMA_TEXT),RIGHT
         STRING(@P<<<#. lapaP),AT(10458,417,,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(104,625,10938,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(135,781,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(500,781,573,156),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR norâdîtais'),AT(1135,781,1354,156),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR nor.dar.par.Reì.'),AT(2531,781,1094,156),USE(?String10:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2500,625,0,573),USE(?Line2:23),COLOR(COLOR:Black)
         STRING('PR'),AT(3802,667,1302,156),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma apraksts'),AT(5354,781,1406,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR norâdîtâ'),AT(6865,677,833,156),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN summa'),AT(9406,781,677,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pieðíirtâs'),AT(8688,781,677,156),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dabas resursu'),AT(7750,677,885,156),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopçjâ summa'),AT(10135,781,885,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10104,625,0,573),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(11042,625,0,573),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(9375,625,0,573),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(8646,625,0,573),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(7708,625,0,573),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(3646,833,1615,0),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,625,0,573),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(104,1146,10938,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(500,938,573,156),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(3688,885,573,208),USE(?String10:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,625,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3646,625,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4271,833,0,365),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5260,625,0,573),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(104,625,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(469,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(500,10,573,156),USE(GG:DOKDAT)
         STRING(@S25),AT(5313,10,1458,156),USE(DAR_APR),LEFT
         LINE,AT(1094,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@S25),AT(1125,10,1354,156),USE(NOS_P),LEFT
         LINE,AT(2500,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S20),AT(2542,10,1075,156),USE(PAR_PVN_PASE),LEFT
         STRING(@S14),AT(4302,10,938,156),USE(GG:DOK_SENR),LEFT(1)
         LINE,AT(3646,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@D06.),AT(3677,10,573,156),USE(GG:DATUMS)
         LINE,AT(4271,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6865,10,781,156),USE(SUMMA_B),RIGHT
         LINE,AT(5260,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(9417,10,625,156),USE(summa_pvn),RIGHT
         LINE,AT(6823,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7958,10,625,156),USE(AKCIZE_DRN),RIGHT
         LINE,AT(9375,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(10104,-10,0,198),USE(?Line2:26),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(10146,10,833,156),USE(SUMMA_P),RIGHT
         LINE,AT(11042,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(135,10,313,156),USE(RPT_NPK),RIGHT
       END
detailP DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(469,-10,0,198),USE(?Line2P:6),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2P:8),COLOR(COLOR:Black)
         STRING(@S25),AT(1125,10,1354,156),USE(NOS_PP),LEFT
         STRING(@S25),AT(5323,10,1458,156),USE(DAR_APRP),TRN,LEFT
         LINE,AT(2500,-10,0,198),USE(?Line2P:9),COLOR(COLOR:Black)
         LINE,AT(3646,-10,0,198),USE(?Line2P:10),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2P:33),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line2P:17),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2P:21),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2P:11),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line2P:24),COLOR(COLOR:Black)
         LINE,AT(9375,-10,0,198),USE(?Line2P:25),COLOR(COLOR:Black)
         LINE,AT(10104,-10,0,198),USE(?Line2P:26),COLOR(COLOR:Black)
         LINE,AT(11042,-10,0,198),USE(?Line2P:27),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2P:5),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(11042,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7958,10,625,156),USE(AKCIZE_DRNK),RIGHT
         LINE,AT(9375,-10,0,198),USE(?Line21:14),COLOR(COLOR:Black)
         LINE,AT(10104,-10,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,198),USE(?Line2:129),COLOR(COLOR:Black)
         LINE,AT(3646,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6865,10,781,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_11.2B),AT(9417,10,625,156),USE(summa_pvnk),RIGHT
         STRING(@N-_14.2B),AT(10146,10,833,156),USE(SUMMA_PK),RIGHT
         STRING('Kopâ'),AT(260,10,573,156),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,0,10938,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,302),USE(?unnamed:2)
         STRING('Sastâdîja :'),AT(135,73,521,146),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,73,552,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1385,73,208,146),USE(?String38),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1583,73),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(9979,83),USE(DAT),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(10594,83),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(104,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4271,0,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,63),USE(?Line132:2),COLOR(COLOR:Black)
         LINE,AT(2500,0,0,63),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(3646,0,0,63),USE(?Line132:21),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,63),USE(?Line312),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,63),USE(?Line321),COLOR(COLOR:Black)
         LINE,AT(9375,0,0,63),USE(?Line232),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(10104,0,0,63),USE(?Line322),COLOR(COLOR:Black)
         LINE,AT(104,52,10938,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line323),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7844,12000,63)
         LINE,AT(104,0,10938,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  BIND('DIVI',DIVI)
!  BIND('CP',CP)
!  BIND('CYCLEPAR_K',CYCLEPAR_K)
!  BIND('CYCLENOL',CYCLENOL)
!  KOPA='Kopâ :'
  DAT = TODAY()
  LAI = CLOCK()
  CLIENT_RN=CLIP(CLIENT)&' '&GL:VID_NR
  IF D_K='D' !D7,D21... D57210
     STRINGVIRSRAKSTS='Saòemto pavadzîmju reìistrs no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
     FORMA_TEXT='FORMA S_REG'
  ELSE       !K6 K57210
     STRINGVIRSRAKSTS='Izrakstîto pavadzîmju reìistrs no '&FORMAT(S_DAT,@D06.)&' lîdz '&FORMAT(B_DAT,@D06.)
     FORMA_TEXT='FORMA I_REG'
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::USED += 1
  BIND(GG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(GG)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P/Z reìistrs'
  ?Progress:UserString{Prop:Text}=''
  SEND(GG,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
!      CN = 'P10011'
!      CP = 'P11'
      DIVI=1
      CLEAR(GG:RECORD)
      GG:DATUMS=S_DAT
      SET(GG:DAT_KEY,GG:DAT_KEY)
      Process:View{Prop:Filter} ='GG:ATT_DOK=DIVI'
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
!      IF F:OBJ_NR
!         PRSTR"=GetProjekti(F:OBJ_NR)
!         PROJEKTS='Projekts (Objekts) Nr: '&F:OBJ_NR&' - '&PRSTR"
!      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IENPZR.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(CLIENT_RN)
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(StringVirsraksts)
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
              OUTA:LINE='Npk'&CHR(9)&'Dokumenta'&CHR(9)&'P/Z norâdîtais'&CHR(9)&'P/Z nor.dar.'&CHR(9)&'P/Z datums'&CHR(9)&'P/Z numurs'&CHR(9)&'Darîjuma apraksts'&CHR(9)&'P/Z norâdîtâ darîjuma'&CHR(9)&'Dabas resursu un'&CHR(9)&'Pieðíirtâs atlaides'&CHR(9)&'PVN summa'&CHR(9)&'Kopçjâ summa'
              ADD(OUTFILEANSI)
              OUTA:LINE=        CHR(9)&'Datums'&CHR(9)&'darîjuma partneris'&CHR(9)&'par.reì.nr'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba bez PVN'&CHR(9)&'akcîzes nodokïi'
              ADD(OUTFILEANSI)
          ELSE
              OUTA:LINE='Npk'&CHR(9)&'Dokumenta Datums'&CHR(9)&'P/Z norâdîtais darîjuma partneris'&CHR(9)&'P/Z nor.dar.par.reì.nr'&CHR(9)&'P/Z datums'&CHR(9)&'P/Z numurs'&CHR(9)&'Darîjuma apraksts'&CHR(9)&'P/Z norâdîtâ darîjuma vçrtîba bez PVN'&CHR(9)&'Dabas resursu un akcîzes nodokïi'&CHR(9)&'Pieðíirtâs atlaides'&CHR(9)&'PVN summa'&CHR(9)&'Kopçjâ summa'
              ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!         IF ~(GG:U_NR=1) AND GG:PAR_NR>50 !SALDO un NR IGNORÇJAM
!         IF ~(GG:U_NR=1) !SALDO IGNORÇJAM
         IF ~(GG:U_NR=1) AND GG:RS='' !SALDO un ~A IGNORÇJAM
           FOUND#=FALSE
           SUMMA_B=0
           SUMMA_PVN=0
           CLEAR(GGK:RECORD)
           GGK:U_NR=GG:U_NR
           SET(GGK:NR_KEY,GGK:NR_KEY)
           LOOP
              NEXT(GGK)
              IF ERROR() OR ~(GGK:U_NR=GG:U_NR) THEN BREAK.
!              IF K(GGK:BKK,'231') OR |  !IZEJOÐÂ P/Z    --konstatçjam, ka ir P/Z
!                 K(GGK:BKK,'561') OR |  !IZEJOÐÂ P/Z UZ ALGU
!                 K(GGK:BKK,'261') OR |  !IZEJOÐÂ P/Z UZ KASI ULDIS-22/10/05
!                 K(GGK:BKK,'262') OR |  !IZEJOÐÂ P/Z UZ BANKU ULDIS-22/10/05
!                 K(GGK:BKK,'238') OR |  !IZEJOÐÂ P/Z UZ AVANSIERI
!                 K(GGK:BKK,'531')       !IENÂKOÐÂ P/Z
!                 IF GGK:D_K=D_K
!                    FOUND#=TRUE
!                 .
!               STOP(GGK:BKK&D_K)
              IF GGK:D_K=D_K             !APGRIEÞAM OTRÂDI 15/05/06 ANALIZÇJAM SUMMAS BEZ PVN
                 IF K(GGK:BKK,'61') OR | !K-IZEJOÐÂ P/Z
                    K(GGK:BKK,'6')  OR | !K-ULDIS-22/10/05
                    K(GGK:BKK,'11') OR | !D-IENÂKOÐÂ NEMAT.IEG.
                    K(GGK:BKK,'12') OR | !D-IENÂKOÐÂ P/L
                   (K(GGK:BKK,'21') AND ~(GGK:BKK[1:3]='219')) OR | !D-21-KRÂJUMI 219-MÛSU AVANSA MAKSÂJUMI AR PVN
                    K(GGK:BKK,'24') OR | !D-IENÂKOÐÂ NÂKAMO PER.IZD.
                    K(GGK:BKK,'71') OR | !D-IENÂKOÐÂ
                    K(GGK:BKK,'7')       !D-ULDIS-22/10/05
                    SUMMA_B += GGK:SUMMA
                    FOUND#=TRUE
                 ELSIF K(GGK:BKK,'572') OR K(GGK:BKK,'2399') !PVN
                    SUMMA_PVN += GGK:SUMMA
                 .
              .
           .
           IF FOUND#=TRUE
              RPT_NPK+=1
              ?Progress:UserString{Prop:Text}=RPT_NPK
              DISPLAY(  ?Progress:UserString)
              SUMMA_P   = SUMMA_B+SUMMA_PVN
              AKCIZE_DRN= 0
              PAR_PVN_PASE=GETPAR_K(GG:PAR_NR,0,8)
              TEKSTS = GETPAR_K(GG:PAR_NR,0,2)  !2-NOS_P
              FORMAT_TEKSTS(33,'Arial',8,'')
              NOS_P = F_TEKSTS[1]
              IF INRANGE(GG:PAR_NR,1,50)
                 DAR_APR='Iekðçjâ preèu pârvietoðana'
              ELSE
                 DAR_APR=GG:SATURS[1:25]
                 DAR_APRP=GG:SATURS[26:45]
              .
              IF ~F:DTK
                IF F:DBF='W'
                  PRINT(RPT:DETAIL)
                ELSE
                  OUTA:LINE=FORMAT(RPT_NPK,@N_5)&CHR(9)&FORMAT(GG:DOKDAT,@D06.)&CHR(9)&CLIP(NOS_P)&CHR(9)&CLIP(PAR_PVN_PASE)&CHR(9)&FORMAT(GG:DATUMS,@D06.)&CHR(9)&CLIP(GG:DOK_SENR)&CHR(9)&CLIP(DAR_APR)&CHR(9)&LEFT(FORMAT(SUMMA_B,@N-_13.2))&CHR(9)&LEFT(FORMAT(AKCIZE_DRN,@N-_10.2))&CHR(9)&CHR(9)&LEFT(FORMAT(summa_pvn,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_P,@N-_14.2))
                  ADD(OUTFILEANSI)
                END
                IF F_TEKSTS[2]
                   NOS_PP=F_TEKSTS[2]
                   IF F:DBF='W'
                        PRINT(RPT:DETAILP)
                   ELSE
                        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CLIP(NOS_PP)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(DAR_APRP)
                        ADD(OUTFILEANSI)
                   END
                .
                IF F_TEKSTS[3]
                   NOS_PP=F_TEKSTS[3]
                   IF F:DBF='W'
                        PRINT(RPT:DETAILP)
                   ELSE
                        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CLIP(NOS_PP)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(DAR_APRP)
                        ADD(OUTFILEANSI)
                   END
                .
              END
              SUMMA_BK   += SUMMA_B
              AKCIZE_DRNK+= AKCIZE_DRN
              SUMMA_PVNK += SUMMA_PVN
              SUMMA_PK   += SUMMA_P
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
  IF SEND(GG,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
        PRINT(RPT:RPT_FOOT3)
    ELSE
        OUTA:LINE=CHR(9)&'Kopâ: '&CHR(9)&CLIP(NOS_PP)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CLIP(DAR_APRP)&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_13.2))&CHR(9)&LEFT(FORMAT(AKCIZE_DRNK,@N-_10.2))&CHR(9)&CHR(9)&LEFT(FORMAT(summa_pvnK,@N-_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))
        ADD(OUTFILEANSI)
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR GG:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
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
N_IenIzgPavReg       PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------

RPT_CLIENT           STRING(49) !35+1+13
NOLIKTAVA_TEXT       STRING(30)
FILTRS_TEXT          STRING(100)
NOS_P                STRING(25)
DOK_SE_NR            STRING(14)
RPT_NPK              DECIMAL(4)
PAR_PVN_PASE         STRING(13)
DAR_APR              STRING(26)
STRINGVIRSRAKSTS     STRING(65)

SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(12,2)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
VALK                 STRING(3)
PRECE                DECIMAL(12,2)
TARA                 DECIMAL(12,2)
PAKALPOJUMI          DECIMAL(12,2)
DAT                  DATE
LAI                  TIME
CN                   STRING(10)
CP                   STRING(3)
ITOGO                DECIMAL(14,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
MUIK                 DECIMAL(10,2)
AKCIZE_DRN           DECIMAL(10,2)
AKCIZE_DRNK          DECIMAL(10,2)
CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
TRANSK               DECIMAL(10,2)
BANKURSS             REAL
PROJEKTS             STRING(50)

!-------------------------------------------------------------------------
report REPORT,AT(198,1385,12000,6500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(198,198,12000,1188),USE(?unnamed)
         STRING('tîba (bez PVN)'),AT(6875,990,833,156),USE(?String10:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('un akcîzes'),AT(7760,833,885,156),USE(?String10:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('atlaides'),AT(8698,938,677,156),USE(?String10:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr vai PVN maks.Nr.'),AT(2552,938,1198,156),USE(?String10:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darîjuma partneris'),AT(1146,938,1354,156),USE(?String10:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Numurs'),AT(4490,885,677,208),USE(?String10:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('darîjuma vçr-'),AT(6875,833,833,156),USE(?String10:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodokli'),AT(7760,990,885,156),USE(?String10:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,625,0,573),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s59),AT(1406,52,5729,260),USE(RPT_CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s30),AT(7188,52,2552,260),USE(NOLIKTAVA_TEXT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s65),AT(2302,313,5625,260),USE(StringVirsraksts),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('FORMA IEPR'),AT(9844,208,781,156),USE(?String7),RIGHT
         STRING(@P<<<#. lapaP),AT(10052,417,,156),PAGENO,USE(?PageCount),RIGHT
         STRING(@s21),AT(313,406),USE(NOMENKLAT),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,625,10938,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('NPK'),AT(156,781,313,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dokum.'),AT(500,781,573,156),USE(?String10:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR norâdîtajs'),AT(1146,781,1354,156),USE(?String10:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR nor. dar. par. Reì.'),AT(2552,781,1198,156),USE(?String10:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2500,625,0,573),USE(?Line2:23),COLOR(COLOR:Black)
         STRING('PR'),AT(3802,677,1302,156),USE(?String10:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Darîjuma apraksts'),AT(5396,781,1406,208),USE(?String10:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PR norâdîtâ'),AT(6875,677,833,156),USE(?String10:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN summa'),AT(9427,781,677,208),USE(?String10:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pieðíirtâs'),AT(8698,781,677,156),USE(?String10:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Dabas resursu'),AT(7760,677,885,156),USE(?String10:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopçjâ summa'),AT(10156,781,885,208),USE(?String10:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(10104,625,0,573),USE(?Line10:4),COLOR(COLOR:Black)
         LINE,AT(11042,625,0,573),USE(?Line10:5),COLOR(COLOR:Black)
         LINE,AT(9375,625,0,573),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(8646,625,0,573),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(7708,625,0,573),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(3750,833,1510,0),USE(?Line2:18),COLOR(COLOR:Black)
         LINE,AT(6823,625,0,573),USE(?Line2:20),COLOR(COLOR:Black)
         LINE,AT(104,1146,10938,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Datums'),AT(500,938,573,156),USE(?String10:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums'),AT(3802,885,573,208),USE(?String10:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,625,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3750,625,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4375,833,0,365),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(5260,625,0,573),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(104,625,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(469,-10,0,198),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@D06.),AT(510,10,573,156),USE(PAV:DOKDAT)
         STRING(@S26),AT(5292,0,1510,156),USE(DAR_APR),LEFT
         LINE,AT(1094,-10,0,198),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@S21),AT(1135,10,1354,156),USE(NOS_P),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(2500,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@S20),AT(2531,10,1210,156),USE(PAR_PVN_PASE),LEFT,FONT(,,,,CHARSET:BALTIC)
         STRING(@S14),AT(4417,10,833,156),USE(DOK_SE_NR),LEFT(1)
         LINE,AT(3750,-10,0,198),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@D6),AT(3781,10,573,156),USE(PAV:DATUMS)
         LINE,AT(4375,-10,0,198),USE(?Line2:33),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(6875,10,781,156),USE(SUMMA_B),RIGHT
         LINE,AT(5260,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(9427,10,625,156),USE(summa_pvn),RIGHT
         LINE,AT(6823,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7969,10,625,156),USE(AKCIZE_DRN),RIGHT
         LINE,AT(9375,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(10104,-10,0,198),USE(?Line2:26),COLOR(COLOR:Black)
         STRING(@N-_14.2),AT(10156,10,833,156),USE(SUMMA_P),RIGHT
         LINE,AT(11042,-10,0,198),USE(?Line2:27),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N_5),AT(146,10,313,156),USE(RPT_NPK),RIGHT
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(11042,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(7708,-10,0,198),USE(?Line2:28),COLOR(COLOR:Black)
         LINE,AT(8646,-10,0,198),USE(?Line12:14),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(7969,21,625,156),USE(AKCIZE_DRNK),RIGHT
         LINE,AT(9375,-10,0,198),USE(?Line21:14),COLOR(COLOR:Black)
         LINE,AT(10104,-10,0,198),USE(?Line22:14),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,198),USE(?Line2:29),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2:35),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,198),USE(?Line2:129),COLOR(COLOR:Black)
         LINE,AT(3750,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N-_13.2B),AT(6875,21,781,156),USE(SUMMA_BK),RIGHT
         STRING(@N-_11.2B),AT(9427,21,625,156),USE(summa_pvnk),RIGHT
         STRING(@N-_14.2B),AT(10156,21,833,156),USE(SUMMA_PK),RIGHT
         STRING('Kopâ'),AT(260,21,573,156),USE(?String10:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,10,10938,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,417)
         STRING('Sastâdîja :'),AT(115,83,521,146),USE(?String36),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(656,83,552,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING('RS :'),AT(1333,83,177,146),USE(?String38),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1542,83,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(9938,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(10583,83,458,146),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(104,0,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,63),USE(?Line32:2),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,63),USE(?Line132:2),COLOR(COLOR:Black)
         LINE,AT(2500,0,0,63),USE(?Line132),COLOR(COLOR:Black)
         LINE,AT(5260,0,0,63),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(3750,0,0,63),USE(?Line132:21),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,63),USE(?Line312),COLOR(COLOR:Black)
         LINE,AT(8646,0,0,63),USE(?Line321),COLOR(COLOR:Black)
         LINE,AT(9375,0,0,63),USE(?Line232),COLOR(COLOR:Black)
         LINE,AT(11042,0,0,63),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(10104,0,0,63),USE(?Line322),COLOR(COLOR:Black)
         LINE,AT(104,52,10938,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,63),USE(?Line323),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,7844,12000,63)
         LINE,AT(104,0,10938,0),USE(?Line1:4),COLOR(COLOR:Black)
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
  IF NOMENKLAT
     KLUDA(0,'Ir filtrs pçc nomenklatûras, akcîzi un DRN ignorçju')
  .
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
!  BIND('CN',CN)
!  BIND('CP',CP)
!  BIND('CYCLEPAR_K',CYCLEPAR_K)
!  BIND('CYCLENOL',CYCLENOL)
!  KOPA='Kopâ :'
  DAT = TODAY()
  LAI = CLOCK()
  RPT_CLIENT=CLIP(CLIENT)&' '&GL:VID_NR
  NOLIKTAVA_TEXT='Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
  FILTRS_TEXT='' !NAV VAJADZÎGS
  IF D_K='D'
     STRINGVIRSRAKSTS='SAÒEMTO PAVADZÎMJU REÌISTRS '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  ELSE
     STRINGVIRSRAKSTS='IZRAKSTÎTO PAVADZÎMJU REÌISTRS '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::USED += 1
  IF NOLIK::Used = 0        !DÇÏ DRN VAI NOMENKLAT FILTRA
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  IF PAVAD::Used = 0        !DÇÏ VIEWA
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          
  BIND(PAV:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'PPR R1eìistrs'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
!      CN = 'P10011'
!      CP = 'P11'
!      IF F:DBF='E'
!         LOOP I#=1 TO 65    !OPTIMÂLAIS GARUMS LANDSKEIPAM ARIAL10
!            LINEH[I#]=CHR(151)
!         .
!      ELSE
!         LOOP I#=1 TO 190
!            LINEH[I#]='-'
!         .
!      .
      CLEAR(PAV:RECORD)
      PAV:DATUMS=S_DAT
      PAV:D_K=D_K
      SET(PAV:DAT_KEY,PAV:DAT_KEY)
!      Process:View{Prop:Filter} ='~CYCLENOL(CN) AND ~CYCLEPAR_K(CP)'
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
!      IF F:OBJ_NR
!         PRSTR"=GetProjekti(F:OBJ_NR)
!         PROJEKTS='Projekts (Objekts) Nr: '&F:OBJ_NR&' - '&PRSTR"
!      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('IENPZR.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(RPT_CLIENT)&' '&NOLIKTAVA_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIP(NOMENKLAT)&' '&StringVirsraksts
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='  Npk'&CHR(9)&'Dokumenta '&CHR(9)&'PR norâdîtâjs        '&CHR(9)&'PR nor.dar. par. Reì.'&CHR(9)&'PR  datums'&CHR(9)&'PR      numurs'&CHR(9)&'Darîjuma apraksts {8}'&CHR(9)&'PR nor. darîjuma'&CHR(9)&'Dabas resursu un'&CHR(9)&'Pieðíirtâs'&CHR(9)&'PVN   summa'&CHR(9)&'Kopçjâ summa'
          ADD(OUTFILEANSI)
          OUTA:LINE='     '&CHR(9)&'Datums    '&CHR(9)&'darîjuma partneris   '&CHR(9)&'Nr vai PVN maks. Nr. '&CHR(9)&'          '&CHR(9)&'              '&CHR(9)&'                  {8}'&CHR(9)&'vçrtîba(bez PVN)'&CHR(9)&'akcîzes nodokli '&CHR(9)&'atlaides  '
          ADD(OUTFILEANSI)
!          OUTA:LINE=LINEH
!          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         IF ~(PAV:U_NR=1) AND PAV:D_K=D_K AND (PAV:PAR_NR>50 OR (F:DTK AND INRANGE(PAV:PAR_NR,1,25))) !SALDO un 1P IGNORÇJAM
           RPT_NPK+=1
           ?Progress:UserString{Prop:Text}=RPT_NPK
           DISPLAY(  ?Progress:UserString)
           SUMMA_B   = 0
           SUMMA_P   = 0
           AKCIZE_DRN= 0
           NOS_P=GETPAR_K(PAV:PAR_NR,0,3)
           DOK_SE_NR=PAV:DOK_SENR
           PAR_PVN_PASE=GETPAR_K(PAV:PAR_NR,0,8)
!           IF INRANGE(PAV:PAR_NR,1,25)
!              DAR_APR='Iekðçjâ pârvietoðana'
!           ELSE
!              EXECUTE PAV:APM_K
!                 DAR_APR='Pârskaitîjums'
!                 DAR_APR='Skaidrâ naudâ'
!                 DAR_APR='Barters'
!                 DAR_APR='Garantija'
!                 DAR_APR='Rûpnîcas garantija'
!              .
!           .
  !         IF INRANGE(PAV:PAR_NR,1,50)
  !            DAR_APR='Iekðçjâ pârvietoðana'
  !         ELSIF PAV:D_K='D' AND PAV:VED_NR
  !            DAR_APR='Iegâde'
  !         ELSIF PAV:D_K='D'
  !            DAR_APR='Saòemðana'
  !         ELSIF PAV:D_K='K' AND PAV:VED_NR
  !            DAR_APR='Piegâde'
  !         ELSE
  !            DAR_APR='Izsniegðana'
  !         .
           IF INRANGE(PAV:PAR_NR,1,50)          !V26
              DAR_APR='Iekðçjâ preèu pârvietoðana'
           ELSIF INSTRING(PAV:APM_V,'35')
              DAR_APR='Izsniegðana citam NM'
           ELSE
              DAR_APR='Preèu piegâde (pârdoðana)'
           .
           BANKURSS=BANKURS(PAV:VAL,PAV:DATUMS)
           IF ~NOMENKLAT !NAV NOMENKLATÛRAS FILTRA
              AKCIZE_DRN= PAV:AKCIZE
           .
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           SET(NOL:NR_KEY,NOL:NR_KEY)
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
              IF NOMENKLAT !IR FILTRS PÇC NOMENKLATÛRAS, AKCÎZI UN DRN IGNORÇJAM
                 IF CYCLENOM(NOL:NOMENKLAT) THEN CYCLE.
                 SUMMA_B+=CALCSUM(15,2) !SUMMA BEZ PVN LS -A
                 SUMMA_P +=CALCSUM(16,2) !SUMMA AR  PVN LS -A
              ELSE !NORMÂLA IZDRUKA
                 IF ~(NOL:NOMENKLAT[1:4]='IEP*') THEN CYCLE.
                 I#=GETNOM_K(NOL:NOMENKLAT,0,1)
                 AKCIZE_DRN+= nol:DAUDZUMS*NOM:REALIZ[1]*(1-NOM:REALIZ[2]/100)
              .
           .
           IF ~NOMENKLAT !JA IR FILTRS PÇC NOMENKLATÛRAS, JAU SASKAITÎJÂM
              SUMMA_B   = PAV:SUMMA_B*BANKURSS
              SUMMA_P   = PAV:SUMMA*BANKURSS+AKCIZE_DRN
           .
           SUMMA_PVN = SUMMA_P-SUMMA_B-AKCIZE_DRN
!           ITOGO = (SUMMA_P+PAV:T_SUMMA)*BANKURSS+PAV:MUITA+PAV:AKCIZE+PAV:CITAS
           SUMMA_BK   += SUMMA_B
           AKCIZE_DRNK+= AKCIZE_DRN
           SUMMA_PVNK += SUMMA_PVN
           SUMMA_PK   += SUMMA_P
!           TRANSK     += PAV:T_SUMMA*BANKURSS
!           MUIK       += PAV:MUITA
!           AKCIZK     += PAV:AKCIZE
!           CITASK     += PAV:CITAS
!           ITOGOK     += ITOGO
           IF F:DBF='W'
              PRINT(RPT:DETAIL)
           ELSE
              OUTA:LINE=FORMAT(RPT_NPK,@N_5)&CHR(9)&FORMAT(PAV:DOKDAT,@D06.)&CHR(9)&NOS_P&CHR(9)&PAR_PVN_PASE&CHR(9)&FORMAT(PAV:DATUMS,@D06.)&CHR(9)&DOK_SE_NR&CHR(9)&DAR_APR&CHR(9)&FORMAT(SUMMA_B,@N-_13.2)&CHR(9)&FORMAT(AKCIZE_DRN,@N_10.2)&CHR(9)&CHR(9)&FORMAT(SUMMA_PVN,@N-_11.2)&CHR(9)&FORMAT(SUMMA_P,@N-_14.2)
              ADD(OUTFILEANSI)
           END
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
!        OUTA:LINE=LINEH
!        ADD(OUTFILEANSI)
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SUMMA_BK,@N-_13.2)&CHR(9)&FORMAT(AKCIZE_DRNK,@N_10.2)&CHR(9)&' {10}'&CHR(9)&FORMAT(SUMMA_PVNK,@N-_11.2)&CHR(9)&FORMAT(SUMMA_PK,@N-_14.2)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  IF F:DBF='E' THEN F:DBF='W'.
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
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
