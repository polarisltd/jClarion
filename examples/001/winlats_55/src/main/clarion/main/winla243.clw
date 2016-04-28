                     MEMBER('winlats.clw')        ! This is a MEMBER module
S_LAPAS              PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
V_NUM               STRING(12)
NOS_P               STRING(30)
RP                  DECIMAL(12,2)
RPK                 DECIMAL(12,2)
LAPA                STRING(10)
NOSKREJIENS         ULONG
S_LAI               ULONG
B_LAI               ULONG

!-----------------------------------------------------------------------------
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
Process:View         VIEW(AUTOAPK)
                       PROJECT(APK:PAV_NR)
                       PROJECT(APK:PAR_NR)
                       PROJECT(APK:AUT_NR)
                       PROJECT(APK:DATUMS)
                       PROJECT(APK:Nobraukums)
                       PROJECT(APK:CTRL_DATUMS)
                       PROJECT(APK:TEKSTS)
                       PROJECT(APK:SAVIRZE_P)
                       PROJECT(APK:SAVIRZE_A)
                       PROJECT(APK:AMORT_P)
                       PROJECT(APK:AMORT_A)
                       PROJECT(APK:BREMZES_P)
                       PROJECT(APK:BREMZES_A)
                       PROJECT(APK:KAROGI)
                       PROJECT(APK:ACC_KODS)
                       PROJECT(APK:ACC_DATUMS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(500,1469,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(500,198,8000,1271)
         STRING(@P<<<#. lapaP),AT(5833,729,698,156),PAGENO,USE(?PageCount),RIGHT,FONT('Arial Baltic',8,,,CHARSET:BALTIC)
         LINE,AT(625,1250,6250,0),COLOR(COLOR:Black)
         STRING(@D06.),AT(2500,677),USE(S_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Servisa Lapas'),AT(1823,365,4323,260),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,990,0,313),COLOR(COLOR:Black)
         STRING('Npk'),AT(698,1042),USE(?String26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts Numurs'),AT(1021,1042,885,208),USE(?String26:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Serv.Lapas Nr'),AT(1958,1042,1042,208),USE(?String26:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5729,990,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         STRING('Summa pçc P/Z'),AT(5760,1042,1094,208),USE(?String26:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6875,990,0,313),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(3021,990,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(1927,990,0,313),USE(?Line8),COLOR(COLOR:Black)
         STRING(@s45),AT(1823,52,4323,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Îpaðnieks'),AT(3052,1042,2656,208),USE(?String26:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,990,6250,0),COLOR(COLOR:Black)
         LINE,AT(990,990,0,313),COLOR(COLOR:Black)
         STRING('-'),AT(3281,677,208,208),USE(?String24),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(3490,677),USE(B_DAT),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@T1),AT(4427,677),USE(S_LAI,,?S_LAI:1),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(4844,677,208,208),USE(?String24:2),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@T1),AT(5052,677),USE(B_LAI,,?B_LAI:1),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,7688,177),USE(?unnamed:2)
         LINE,AT(625,-10,0,198),COLOR(COLOR:Black)
         LINE,AT(990,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(1927,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(5729,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(6875,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
         LINE,AT(3021,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@n3),AT(677,10,,156),CNT,USE(?Count),RIGHT
         STRING(@N-_12.2B),AT(5833,10,,156),USE(RP),RIGHT
         STRING(@S40),AT(3125,10,2604,156),USE(NOS_P),LEFT
         STRING(@S12),AT(1083,10,781,156),USE(V_NUM),LEFT
         STRING(@S10),AT(2156,10,708,156),USE(LAPA),RIGHT(1)
       END
LINE   DETAIL,AT(,,7729,10)
         LINE,AT(625,0,6250,0),USE(?Line16),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,344),USE(?unnamed)
         LINE,AT(5729,0,0,156),USE(?Line17:2),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(5833,0,,156),USE(RPK),RIGHT
         LINE,AT(6875,0,0,156),USE(?Line17:3),COLOR(COLOR:Black)
         LINE,AT(625,156,6250,0),USE(?Line23),COLOR(COLOR:Black)
         STRING(@D06.),AT(5792,177),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(6385,177),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING('Kopâ :'),AT(1094,0,677,156),USE(?String26:6),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(625,0,0,156),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(1927,0,0,156),USE(?Line17:5),COLOR(COLOR:Black)
         LINE,AT(3021,0,0,156),USE(?Line17:7),COLOR(COLOR:Black)
         LINE,AT(990,0,0,156),USE(?Line17:6),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,9000,8000,63),USE(?unnamed:3)
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

Laiki WINDOW('Laiks'),AT(,,114,57),CENTER,GRAY
       ENTRY(@T1),AT(20,14,26,12),USE(S_LAI),LEFT
       ENTRY(@T1),AT(62,14),USE(B_LAI),LEFT
       STRING('-'),AT(48,14,11,12),FONT(,12,,FONT:bold,CHARSET:BALTIC),USE(?String1),CENTER
       BUTTON('&OK'),AT(32,34,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(71,34,35,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  S_LAI=1
  B_LAI=1

  OPEN(Laiki)
  DISPLAY
  ACCEPT
    CASE FIELD()
    OF ?OKButton
        CASE EVENT()
        OF EVENT:Accepted
            BREAK
        .
    OF ?CancelButton
        CASE EVENT()
        OF EVENT:Accepted
            close(Laiki)
            do ProcedureReturn
        .
    END
  END
  CLOSE(Laiki)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  DAT = TODAY()
  LAI = CLOCK()
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(AUTOAPK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Servisa lapas'
  ?Progress:UserString{Prop:Text}=''
  SEND(AUTOAPK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      clear(APK:RECORD)
      APK:DATUMS=S_DAT
      SET(APK:DAT_Key,APK:DAT_KEY)
      Process:View{Prop:Filter} = ''
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF INRANGE(APK:PLKST,S_LAI,B_LAI) OR S_LAI=B_LAI
    !        DATUMS     =APK:DATUMS
            V_NUM = GETAUTO(APK:AUT_NR,9)
            NOSKREJIENS=APK:NOBRAUKUMS
            I#=GETPAVADZ(APK:PAV_NR)
            LAPA   = PAV:REK_NR
            NOS_P  = PAV:NOKA
    !        CLEAR(NOL:RECORD)
    !        NOL:U_NR=APK:PAV_NR
    !        SET(NOL:NR_KEY,NOL:NR_KEY)
    !        LOOP
    !           NEXT(NOLIK)
    !           IF ERROR() OR ~(NOL:U_NR=APK:PAV_NR) THEN BREAK.
    !           DARBI  = NOL:NOMENKLAT
               RP     = PAV:SUMMA
               RPK   += RP
               PRINT(RPT:detail)
    !           DATUMS=''
    !           LAPA=0
    !           NOSKREJIENS=0
    !        END
            PRINT(RPT:line)
        END
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
  IF SEND(AUTOAPK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAIL1)
    ENDPAGE(report)
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
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
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
  IF ERRORCODE() OR APK:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'AUTOAPK')
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
PAS_IzzinaKlientam   PROCEDURE                    ! Declare Procedure
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

RPT_NPK              DECIMAL(3)
NOS_CENA             DECIMAL(11,2)
NOS_PASUTITAJS       STRING(45)
SAV_NOMEN            STRING(21)
NOS_P                STRING(35)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
gov_reg              STRING(37)
RPT_CLIENT           STRING(35)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(18)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
NPK                  STRING(3)
NOMENK               STRING(21)
DAUDZUMSK            DECIMAL(15,3)
KOPA                 STRING(15)
PLKST                TIME
ADRESEF              STRING(60)
PAV_AUTO             STRING(80)
FAX                  STRING(31)
SUMM                 STRING(15)
NOS_KATALOGA_NR      STRING(21)
Komentars            STRING(40)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLPAS)
                       PROJECT(NOS:DATUMS)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:NOMENKLAT)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:VAL)
                       PROJECT(NOS:PAR_NR)
                       PROJECT(NOS:U_NR)
                       PROJECT(NOS:KEKSIS)
                       PROJECT(NOS:KOMENTARS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(146,1396,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
       HEADER,AT(146,198,8000,1208)
         STRING(@s45),AT(1875,52,4375,208),USE(Client),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Izziòa par veiktajiem pasûtîjumiem'),AT(2667,375,2656,208),USE(?String38:4),CENTER,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîjumu datumi no'),AT(417,729,1458,208),USE(?String138:4),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(3188,729,917,208),USE(B_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(1979,729,917,208),USE(S_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('lîdz'),AT(2906,729,292,208),USE(?String38:3),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîtâjs'),AT(417,938,1042,208),USE(?String38:2),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@S35),AT(1510,938,3385,208),USE(PAR:NOS_P),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,1198,7813,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,302)
         LINE,AT(104,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,313),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(4323,0,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,313),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line8:32),COLOR(COLOR:Black)
         LINE,AT(104,0,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,42,365,208),USE(?String11:2),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(552,42,1458,208),USE(?String12),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2063,42,1406,208),USE(?String13),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Daudzums'),AT(3521,42,781,208),USE(?String14),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Cena'),AT(4354,42,729,208),USE(?String15),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Komentârs'),AT(5135,42,2344,208),USE(?String16),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('PS'),AT(7521,42,365,208),USE(?String11),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,260,7813,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line8:35),COLOR(COLOR:Black)
         STRING(@s21),AT(625,10,1354,156),USE(NOS:nomenklat),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,198),USE(?Line8:37),COLOR(COLOR:Black)
         STRING(@s20),AT(2135,10,1302,156),USE(NOS:nos_s),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3490,-10,0,198),USE(?Line8:36),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(3542,10,729,156),USE(NOS:daudzums),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4323,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@n_11.2),AT(4375,10,677,156),USE(NOS:LIGUMCENA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5104,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         STRING(@s40),AT(5146,10,2333,156),USE(KOMENTARS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(7552,10,313,156),USE(NOS:KEKSIS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7500,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
         STRING(@n_4),AT(156,10,313,156),USE(RPT_npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line8:937),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(3490,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(4323,0,0,52),USE(?Line62:12),COLOR(COLOR:Black)
         LINE,AT(5104,0,0,52),USE(?Line62:21),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,52),USE(?Line62:23),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,52),USE(?Line62:32),COLOR(COLOR:Black)
         LINE,AT(104,52,7813,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line58:992),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11200,8000,52)
         LINE,AT(104,0,7813,0),USE(?Line5:5),COLOR(COLOR:Black)
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

IZDRUKA WINDOW('Izdrukas formâts'),AT(,,185,70),GRAY
       OPTION('Izdrukas &formâts'),AT(6,11,173,27),USE(F:DBF),BOXED
         RADIO('WMF'),AT(8,22),USE(?F:DBF:Radio1)
         RADIO('WMF (pçc nomenklatûtâm)'),AT(38,22),USE(?F:DBF:Radio2),VALUE('N')
         RADIO('ANSI:TXT'),AT(135,22),USE(?F:DBF:Radio3)
       END
       BUTTON('&OK'),AT(45,47,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(107,47,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  F:DBF='W'

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  CheckOpen(NOLPAS,1)
  BIND(NOS:RECORD)
  BIND(PAS:RECORD)

  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Klienta pasûtîjumi'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLPAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOS:RECORD)
      NOS:SAN_NR=PAR_NR
      NOS:DATUMS=S_DAT
      SET(NOS:SAN_KEY,NOS:SAN_KEY)
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
!          SETTARGET(REPORT)
!          IMAGE(156,156,2448,677,'USER.BMP')
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
          PRINT(RPT:DETAIL0)
!      ELSE
!         IF ~OPENANSI('INVOICE.TXT')
!           POST(Event:CloseWindow)
!           CYCLE
!         .
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF NOS:SAN_NR=PAR:NR
           NK#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           DAUDZUMSK += NOS:DAUDZUMS
           NPK+=1
           IF NPK<99
             RPT_NPK=FORMAT(NPK,@N2)&'.'
           ELSE
             RPT_NPK=FORMAT(NPK,@N3)
           .
           KOMENTARS=CLIP(NOS:DOK_NR)&' '&CLIP(GETAUTO(NOS:AUT_NR,9))&' '&NOS:KOMENTARS
!          IF F:DBF='N'
!             NOS_KATALOGA_NR=NOS:NOMENKLAT
!          ELSE
!             NOS_KATALOGA_NR=NOS:KATALOGA_NR
!           .
!           IF F:DBF = 'W' OR F:DBF='N'
           PRINT(RPT:DETAIL)
!           SAV_NOMEN = NOS:NOMENKLAT
!           ELSE
!                SUMM = NOS:DAUDZUMS
!                OUTA:LINE=RPT_NPK&CHR(9)&NOS:KATALOGA_NR&CHR(9)&SUMM
!                ADD(OUTFILEANSI)
!           END
!        .
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
        Close(ProgressWindow)
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
  IF SEND(NOLPAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    kopa='Total:'
!    IF F:DBF = 'W' OR F:DBF='N'
        PRINT(RPT:RPT_FOOT3)                        !PRINT GRAND TOTALS
!    ELSE
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!        SUMM = DAUDZUMSK
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&SUMM
!        ADD(OUTFILEANSI)
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!    END
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
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Wordpad.exe')
        .
    .
  END
  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
  ELSE
      ANSIFILENAME=''
  END
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
  IF ERRORCODE() OR ~(NOS:SAN_NR=PAR_NR AND NOS:DATUMS<=B_DAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
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
PAS_IzzinaAuto       PROCEDURE                    ! Declare Procedure
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

RPT_NPK              DECIMAL(3)
NOS_CENA             DECIMAL(11,2)
NOS_PASUTITAJS       STRING(45)
SAV_NOMEN            STRING(21)
NOS_P                STRING(35)
RPT_GADS             STRING(4)
DATUMS               STRING(2)
gov_reg              STRING(37)
RPT_CLIENT           STRING(35)
RPT_BANKA            STRING(31)
RPT_REK              STRING(18)
KESKA                STRING(60)
REG_NR               STRING(11)
FIN_NR               STRING(13)
PAR_BAN_NR           STRING(18)
PAR_BAN_KODS         STRING(11)
JU_ADRESE            STRING(47)
ADRESE               STRING(52)
TEXTEKSTS            STRING(60)
ADRESE1              STRING(40)
PAR_BANKA            STRING(31)
NPK                  STRING(3)
NOMENK               STRING(21)
DAUDZUMSK            DECIMAL(15,3)
KOPA                 STRING(15)
PLKST                TIME
ADRESEF              STRING(60)
PAV_AUTO             STRING(80)
FAX                  STRING(31)
SUMM                 STRING(15)
NOS_KATALOGA_NR      STRING(21)
AUTO_TEXT            STRING(45)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLPAS)
                       PROJECT(NOS:DATUMS)
                       PROJECT(NOS:DAUDZUMS)
                       PROJECT(NOS:NOMENKLAT)
                       PROJECT(NOS:KATALOGA_NR)
                       PROJECT(NOS:VAL)
                       PROJECT(NOS:PAR_NR)
                       PROJECT(NOS:U_NR)
                       PROJECT(NOS:KEKSIS)
                       PROJECT(NOS:KOMENTARS)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(146,1396,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
       HEADER,AT(146,198,8000,1208)
         STRING(@s45),AT(1823,52,4427,208),USE(Client),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Izziòa par veiktajiem pasûtîjumiem'),AT(2667,375,2656,208),USE(?String38:4),CENTER,FONT(,11,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîjumu datumi no'),AT(417,729,1458,208),USE(?String138:4),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(3188,729,917,208),USE(B_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(1979,729,917,208),USE(S_DAT),CENTER,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('lîdz'),AT(2906,729,292,208),USE(?String38:3),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Automaðîna'),AT(417,938,1042,208),USE(?String38:2),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@S45),AT(1510,938,3385,208),USE(AUTO_TEXT),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,1198,7813,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,302)
         LINE,AT(104,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(4063,0,0,313),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,313),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,313),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line8:32),COLOR(COLOR:Black)
         LINE,AT(104,0,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,42,365,208),USE(?String11:2),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pas.Num.'),AT(573,52,625,208),USE(?String11:3),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(1198,0,0,313),USE(?Line808:7),COLOR(COLOR:Black)
         STRING('Nomenklatûra'),AT(1250,52,1406,208),USE(?String12),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2708,52,1354,208),USE(?String13),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Daudzums'),AT(4115,52,781,208),USE(?String14),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Cena'),AT(4948,52,729,208),USE(?String15),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Komentârs'),AT(5729,52,1927,208),USE(?String16),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('PS'),AT(7708,52,208,208),USE(?String11),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,260,7813,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line8:35),COLOR(COLOR:Black)
         STRING(@s21),AT(1302,10,1354,156),USE(NOS:nomenklat),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2656,-10,0,198),USE(?Line8:37),COLOR(COLOR:Black)
         STRING(@s20),AT(2760,10,1302,156),USE(NOS:nos_s),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4063,-10,0,198),USE(?Line8:36),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(4115,10,729,156),USE(NOS:daudzums),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4896,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@n_11.2),AT(4948,10,677,156),USE(NOS:LIGUMCENA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(5677,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         STRING(@s30),AT(5729,10,1927,156),USE(NOS:KOMENTARS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@S1),AT(7708,10,208,156),USE(NOS:KEKSIS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7656,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
         STRING(@N_10B),AT(573,10,573,156),USE(NOS:DOK_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1198,-10,0,198),USE(?Line8:937),COLOR(COLOR:Black)
         STRING(@n_4),AT(156,10,313,156),USE(RPT_npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line808:937),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2656,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(4063,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(4896,0,0,52),USE(?Line62:12),COLOR(COLOR:Black)
         LINE,AT(5677,0,0,52),USE(?Line62:21),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,52),USE(?Line62:23),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,52),USE(?Line62:32),COLOR(COLOR:Black)
         LINE,AT(104,52,7813,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(1198,0,0,52),USE(?Line808:2),COLOR(COLOR:Black)
         LINE,AT(521,0,0,52),USE(?Line58:992),COLOR(COLOR:Black)
       END
       FOOTER,AT(146,11200,8000,52)
         LINE,AT(104,0,7813,0),USE(?Line5:5),COLOR(COLOR:Black)
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
IZDRUKA WINDOW('Izdrukas formâts'),AT(,,185,70),GRAY
       OPTION('Izdrukas &formâts'),AT(6,11,173,27),USE(F:DBF),BOXED
         RADIO('WMF'),AT(8,22),USE(?F:DBF:Radio1)
         RADIO('WMF (pçc nomenklatûtâm)'),AT(38,22),USE(?F:DBF:Radio2),VALUE('N')
         RADIO('ANSI:TXT'),AT(135,22),USE(?F:DBF:Radio3)
       END
       BUTTON('&OK'),AT(45,47,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(107,47,36,14),USE(?CancelButton)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  AUTO_TEXT=GETAUTO(AUT_NR,5)
  F:DBF='W'

  IF NOLPAS::Used = 0
    CheckOpen(NOLPAS,1)
  END
  NOLPAS::Used += 1
  BIND(NOS:RECORD)
  BIND(PAS:RECORD)

  FilesOpened = True
  RecordsToProcess = 10
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'Pasûtîjumi Automaðînai'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLPAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOS:RECORD)
      NOS:AUT_NR=AUT_NR
      NOS:DATUMS=S_DAT
      SET(NOS:AUT_KEY,NOS:AUT_KEY)
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
!      IF F:DBF='W'
!          SETTARGET(REPORT)
!          IMAGE(156,156,2448,677,'USER.BMP')
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
          PRINT(RPT:DETAIL0)
!      ELSE
!         IF ~OPENANSI('INVOICE.TXT')
!           POST(Event:CloseWindow)
!           CYCLE
!         .
!      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
!        IF NOS:SAN_NR=PAR:NR
           NK#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           DAUDZUMSK += NOS:DAUDZUMS
           NPK+=1
           IF NPK<99
             RPT_NPK=FORMAT(NPK,@N2)&'.'
           ELSE
             RPT_NPK=FORMAT(NPK,@N3)
           .
!          IF F:DBF='N'
!             NOS_KATALOGA_NR=NOS:NOMENKLAT
!          ELSE
!             NOS_KATALOGA_NR=NOS:KATALOGA_NR
!           .
!           IF F:DBF = 'W' OR F:DBF='N'
           PRINT(RPT:DETAIL)
!           SAV_NOMEN = NOS:NOMENKLAT
!           ELSE
!                SUMM = NOS:DAUDZUMS
!                OUTA:LINE=RPT_NPK&CHR(9)&NOS:KATALOGA_NR&CHR(9)&SUMM
!                ADD(OUTFILEANSI)
!           END
!        .
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
        Close(ProgressWindow)
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
  IF SEND(NOLPAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!************************* KOPÂ & T.S.********
    kopa='Total:'
!    IF F:DBF = 'W' OR F:DBF='N'
        PRINT(RPT:RPT_FOOT3)                        !PRINT GRAND TOTALS
!    ELSE
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!        SUMM = DAUDZUMSK
!        OUTA:LINE=KOPA&CHR(9)&CHR(9)&SUMM
!        ADD(OUTFILEANSI)
!        OUTA:LINE='-{130}'
!        ADD(OUTFILEANSI)
!    END
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
        CLOSE(OUTFILEANSI)
        RUN('WORDPAD '&ANSIFILENAME)
        IF RUNCODE()=-4
            KLUDA(88,'Wordpad.exe')
        .
    .
  END
  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
  ELSE
      ANSIFILENAME=''
  END
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
    NOLPAS::Used -= 1
    IF NOLPAS::Used = 0 THEN CLOSE(NOLPAS).
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
  IF ERRORCODE() OR ~(NOS:AUT_NR=AUT_NR AND NOS:DATUMS<=B_DAT)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLPAS')
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
