                     MEMBER('winlats.clw')        ! This is a MEMBER module
GRAPH PROCEDURE(OPC,VIRSRAKSTS)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
X4                   DECIMAL(9,2)
X3                   DECIMAL(9,2)
X2                   DECIMAL(9,2)
X1                   DECIMAL(9,2)
X0                   DECIMAL(9,2)
MAXVALUE             DECIMAL(9,2)
MINVALUE             DECIMAL(9,2)
XTEXT                STRING(120)
YTEXT                STRING(40)
window               WINDOW('Peïòas / zaudçjumu analîze  '),AT(,,437,265),FONT('MS Sans Serif',8,,FONT:bold),CENTER,GRAY
                       STRING(@s100),AT(33,5,375,10),USE(VIRSRAKSTS),CENTER
                       STRING(@s25),AT(2,18),USE(YTEXT),CENTER
                       LINE,AT(48,137,5,0),USE(?Line4),COLOR(COLOR:Black)
                       LINE,AT(47,236,5,0),USE(?Line7),COLOR(COLOR:Black)
                       STRING(@n-12.2),AT(2,182,46,8),USE(X1),RIGHT(1)
                       LINE,AT(48,186,5,0),USE(?Line6),COLOR(COLOR:Black)
                       STRING(@n-12.2),AT(2,231,46,8),USE(X0),RIGHT(1)
                       STRING(@n-12.2),AT(2,31,46,8),USE(X4),RIGHT(1),FONT(,8,,)
                       LINE,AT(48,36,5,0),USE(?Line3),COLOR(COLOR:Black)
                       STRING(@n-12.2),AT(2,82,46,8),USE(X3),RIGHT(1)
                       LINE,AT(48,87,5,0),USE(?Line5),COLOR(COLOR:Black)
                       STRING(@n-12.2),AT(2,132,46,8),USE(X2),RIGHT(1)
                       LINE,AT(50,236,0,-210),USE(?Line2),COLOR(COLOR:Black)
                       STRING(@s120),AT(51,239,376,10),USE(XTEXT)
                       LINE,AT(50,236,380,0),USE(?LineX),COLOR(COLOR:Black)
                       BUTTON('OK'),AT(397,249,35,14),USE(?OkButton),DEFAULT
                       STRING('0.00'),AT(33,250,14,8),USE(?NULLX),HIDE
                     END
corners    LONG,DIM(8)
STARTX     SHORT
STARTY     SHORT
SOLISX     SHORT
SOLISY     DECIMAL(9,2)
PROPORCIJA REAL
YPOSITION  SHORT
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
  !
  !                                 2--3
  !     STARTPOINT: X=50  J=223     |  |
  !        (WINDOW)                 1--4
  !
  !     12 MÇN VÇRT. TIEK SAÒEMTAS NO PVNMAS
  !
     STARTX    = 50
     SOLISX    = 30
     YPOSITION = 236            !Y ASS Y KOORDINÂTE UZ EKRÂNA
     FGK#=12-MONTH(DB_B_DAT)    !FINANSU GADA KOREKSIJA
     LOOP I#=1 TO 12
        M#=I#-FGK#
        IF M#<=0
           M#+=12
        .
        XTEXT[(I#-1)*10+1:(I#-1)*10+9]=MENVAR(M#,1,1)
     .
  !   XTEXT='Janvâris Februâris   Marts    Aprîlis      Maijs     Jûnijs     Jûlijs   Augusts Septembris Oktobris Novembris Decembris'
     YTEXT='Netto peïòa, Ls'
     LOOP I#=1 TO 12
  !      STOP(PVNMAS[I#,1])
        IF PVNMAS[I#,1] > MAXVALUE
           MAXVALUE = PVNMAS[I#,1]
        ELSIF PVNMAS[I#,1] < MINVALUE
           MINVALUE = PVNMAS[I#,1]
        .
     .
     PROPORCIJA= 200/(MAXVALUE-MINVALUE)   !200 PUNKTI - MAX BAR AUGSTUMS
     SOLISY   = (MAXVALUE-MINVALUE)/4      !SOLIS STARP REÂLAJÂM VÇRTÎBÂM
  !   STARTY   = 223 + MINVALUE*PROPORCIJA  !0-ES PUNKTS UZ EKRÂNA
     STARTY   = YPOSITION + MINVALUE*PROPORCIJA  !0-ES PUNKTS UZ EKRÂNA
     ?LINEX{PROP:AT,2}=STARTY
     IF MINVALUE < 0
        LOOP I#=1 TO 5
           IF INRANGE(YPOSITION-50*(I#-1),STARTY-7,STARTY+7) !VAI 0.00 NEPÂRKLÂJAS AR KÂDU NO CHECKPOINTIEM
              NOTNULL#=TRUE
              BREAK
           .
        .
        IF ~NOTNULL#
           UNHIDE(?NULLX)
           ?NULLX{PROP:AT,2}=STARTY-5      !-5 LAI SMUKÂK
        .
     .
     X0 = MINVALUE
     X1 = MINVALUE+SOLISY
     X2 = MINVALUE+SOLISY*2
     X3 = MINVALUE+SOLISY*3
     X4 = MAXVALUE
  LOOP I#=1 TO 12
     CORNERS[1] = STARTX+SOLISX*(I#-1)
     CORNERS[2] = STARTY
     CORNERS[3] = STARTX+SOLISX*(I#-1)
     CORNERS[4] = STARTY-PVNMAS[I#,1]*PROPORCIJA
     CORNERS[5] = STARTX+SOLISX*I#
     CORNERS[6] = STARTY-PVNMAS[I#,1]*PROPORCIJA
     CORNERS[7] = STARTX+SOLISX*I#
     CORNERS[8] = STARTY
     POLYGON(CORNERS,COLOR:GRAY)
  !   POLYGON(CORNERS,000000FFh)
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?VIRSRAKSTS)
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
  INIRestoreWindow('GRAPH','winlats.INI')
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
    INISaveWindow('GRAPH','winlats.INI')
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
G_PELNA              PROCEDURE                    ! Declare Procedure
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

CG                   STRING(10)
PELNA                DECIMAL(13,2),DIM(12)
IZLAISTAS_S          DECIMAL(13,2)   ! 6,7,8 bez rindu kodiem
FILTRS_TEXT          STRING(100)
RK_OK                BYTE

R_TABLE     QUEUE,PRE(R)
KODS            USHORT
            .

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:OBJ_NR)
                    END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END

  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CheckOpen(KON_R,1)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1

  B_DAT=DB_B_DAT
  S_DAT=DATE(MONTH(DB_B_DAT)+1,1,YEAR(DB_B_DAT)-1)  !TIKAI 12 MÇN.
  FGK#=12-MONTH(DB_B_DAT)                           !FIN GADA KOREKCIJA

  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).

  IF RECORDS(KON_R)=0
     KLUDA(0,'Nav atrodams fails KON_R...')
     DO PROCEDURERETURN
  .
  CLEAR(KONR:RECORD)
  KONR:UGP='P'
  SET(KONR:UGP_KEY,KONR:UGP_KEY)
  LOOP
     NEXT(KON_R)
     IF ERROR() OR ~(KONR:UGP='P') THEN BREAK.
     R:KODS=KONR:KODS
     ADD(R_TABLE)
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

!****************************** 1. SOLIS ********************************
  BIND(GGK:RECORD)
  BIND(KON:RECORD)
  bind('b_dat',b_dat)
  bind('s_dat',s_dat)
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
  ProgressWindow{Prop:Text} = 'Peïòas/Zaudçjumu analîze'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
   CASE EVENT()
   OF Event:OpenWindow
     CLEAR(ggk:RECORD)
     GGK:BKK='6'
     CG = 'K120011'
     SET(GGK:BKK_DAT,GGK:BKK_DAT)
!     Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
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
   OF Event:Timer
     LOOP RecordsPerCycle TIMES
       IF ~CYCLEGGK(CG) AND ~(GGK:U_NR=1) !~SALDO
          IF ~GETKON_K(ggk:BKK,2,1,FORMAT(GGK:DATUMS,@D6.)&' U_Nr='&GGK:U_NR)
             DO PROCEDURERETURN
          .
          IF INSTRING(KON:BKK[1],'678',1) AND ~(GGK:BKK[1:3]='861') !IR OPERÂCIJU KONTS UN NAV PEÏÒA/ZAUDÇJUMI
             nk#+=1
             ?Progress:UserString{Prop:Text}=NK#
             DISPLAY(?Progress:UserString)
             RK_OK=FALSE
             LOOP J# = 1 TO 3  !TIKAI PÂRLIECINAMIES, VAI RINDAS VISPÂR NORÂDÎTAS
                IF kon:PZB[J#]
                   R:KODS=kon:PZB[J#]
                   GET(R_TABLE,R:KODS)
                   IF ERROR()
                      KLUDA(71,'WWW.VID.GOV.LV PZA2 :'&kon:PZB[J#]&' kontam '&KON:BKK)
                      IF ~(GGK:BKK[1:3]='861')    !IZLAISTAS SUMMAS
                          IZLAISTAS_S+= GGK:SUMMA
                      .
                   ELSE
                      RK_OK=TRUE
                      M#=month(ggk:datums)+FGK#
                      IF INRANGE(M#,1,12)
                         IF GGK:D_K='D'
                            PELNA[M#] -= GGK:SUMMA
                         ELSE
                            PELNA[M#] += GGK:SUMMA
                         .
                      .
                   .
                   BREAK
                .
             .
             IF RK_OK=FALSE
                 IZLAISTAS_S+= GGK:SUMMA
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

!****************************** 2. SOLIS ********************************
  IF IZLAISTAS_S
     KLUDA(0,'Kïûda kontu plânâ : izlaistas summas par Ls '&IZLAISTAS_S)
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=1 TO 12
      PVNMAS[I#,1] = PELNA[I#]
    .
    CLOSE(ProgressWindow)
    GRAPH(1,FORMAT(S_DAT,@D06.)&' - '&FORMAT(B_DAT,@D06.)&' '&FILTRS_TEXT)
  END
  DO ProcedureReturn

!------------------------------------------------------------------------
ProcedureReturn ROUTINE
  FREE(R_TABLE)
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

!------------------------------------------------------------------------
ValidateRecord       ROUTINE
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!------------------------------------------------------------------------
GetNextRecord ROUTINE
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
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
PAS_Izzina           PROCEDURE                    ! Declare Procedure
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
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(146,1396,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC),THOUS
       HEADER,AT(146,198,8000,1208)
         STRING(@s45),AT(1875,52,4479,208),USE(Client),CENTER,FONT(,12,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîjuma Nr:'),AT(417,521,1250,208),USE(?String38),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@N_8),AT(1667,521,833,208),USE(PAS:dok_nr),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîjuma datums:'),AT(417,729,1458,208),USE(?String38:3),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@D6),AT(1823,729,917,208),USE(PAS:DATUMS),FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Piegâdâtâjs:'),AT(417,938,1042,208),USE(?String38:2),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         STRING(@S35),AT(1510,948,3385,208),USE(PAS:NOKA),LEFT,FONT(,10,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,1198,7813,0),USE(?Line5),COLOR(COLOR:Black)
       END
detail0 DETAIL,AT(,,,302)
         LINE,AT(104,0,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(521,0,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(3365,0,0,313),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,313),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(4917,0,0,313),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(7500,0,0,313),USE(?Line8:31),COLOR(COLOR:Black)
         LINE,AT(7917,0,0,313),USE(?Line8:32),COLOR(COLOR:Black)
         LINE,AT(104,0,7813,0),USE(?Line5:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,52,365,208),USE(?String11),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nomenklatûra'),AT(573,52,1458,208),USE(?String12),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(2083,52,1208,208),USE(?String13),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Daudzums'),AT(3385,52,781,208),USE(?String14),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Cena'),AT(4188,52,729,208),USE(?String15),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('Pasûtîtâjs, tâlruòa Nr'),AT(5156,52,2344,208),USE(?String16),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         STRING('PS'),AT(7531,42,365,208),USE(?String11:2),CENTER,FONT(,8,,FONT:BOLD,CHARSET:BALTIC)
         LINE,AT(104,260,7813,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line8:35),COLOR(COLOR:Black)
         STRING(@s21),AT(625,10,1354,156),USE(NOS:nomenklat),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(2031,-10,0,198),USE(?Line8:37),COLOR(COLOR:Black)
         STRING(@s20),AT(2063,10,1302,156),USE(NOS:nos_s),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3365,-10,0,198),USE(?Line8:36),COLOR(COLOR:Black)
         STRING(@n-_11.3),AT(3396,10,729,156),USE(NOS:daudzums),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4167,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@n_11.2),AT(4198,10,677,156),USE(NOS:LIGUMCENA),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4917,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         STRING(@s45),AT(4958,10,2542,156),USE(NOS_pasutitajs),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7500,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(7917,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
         STRING(@S1),AT(7563,10,313,156),USE(NOS:KEKSIS),CENTER,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n_4),AT(156,10,313,156),USE(RPT_npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line8:937),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,-10,,177)
         LINE,AT(104,0,0,52),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2031,0,0,52),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(3365,0,0,52),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(4167,0,0,52),USE(?Line62:12),COLOR(COLOR:Black)
         LINE,AT(4917,0,0,52),USE(?Line62:21),COLOR(COLOR:Black)
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
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)

  F:DBF='W'

!  OPEN(IZDRUKA)
!  IF ~F:DBF THEN F:DBF='W'.
!  DISPLAY
!  ACCEPT
!    CASE FIELD()
!    OF ?OKButton
!        BREAK
!    OF ?CancelButton
!        BREAK
!    END
!  END
!  CLOSE(IZDRUKA)
!  RPT_gads=year(pas:datums)
!  datums=day(pas:datums)
!  menesis=MENVAR(pas:datums,2,2)
!  plkst=clock()
!  KESKA = RPT_GADS&'. gada '&datums&'. '&menesis
!  GETMYBANK('')
!  PAR:NOS_P=GETPAR_K(PAS:PAR_NR,2,2)
!  FAX='FAX: '&PAR:TELFAX
!  RPT_CLIENT=CLIENT
!  JU_ADRESE=GL:ADRESE
!  ADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
!  reg_nr=gl:reg_nr
!  fin_nr=gl:VID_NR
!  RPT_BANKA=BANKA
!!         RPT:BKODS=BKODS
!  RPT_REK  =REK
!!  ATLAUJA =SYS:ATLAUJA
!  NOS_P=GETPAR_K(PAS:PAR_NR,2,2)
!  gov_reg=GETPAR_K(PAS:PAR_NR,0,9)
!  ADRESE1=PAR:ADRESE

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

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
  ProgressWindow{Prop:Text} = 'Pasûtîjums'
  ?Progress:UserString{Prop:Text}='Uzgaidiet...'
  SEND(NOLPAS,'QUICKSCAN=on')

! STOP(FORMAT(PAS:DATUMS,@D6))

  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(NOS:RECORD)                              !MAKE SURE RECORD CLEARED
      NOS:PAR_NR=PAS:PAR_NR
      NOS:DOK_NR=PAS:DOK_NR
      SET(NOS:PAR_KEY,NOS:PAR_KEY)                     !SET TO FIRST SELECTED RECORD
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
        IF NOS:U_NR=PAS:U_NR
           NK#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           DAUDZUMSK += NOS:DAUDZUMS
           NPK+=1
!          NOS_CENA = GETNOM_K(NOS:NOMENKLAT,2,7)
           NOS_PASUTITAJS =GETAUTO(NOS:AUT_NR,9)
           NOS_PASUTITAJS =CLIP(NOS_PASUTITAJS)&' '&CLIP(NOS:SAN_NOS)&' '&GETPAR_K(NOS:SAN_NR,0,17) ! TELEFONS
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
           SAV_NOMEN = NOS:NOMENKLAT
!           ELSE
!                SUMM = NOS:DAUDZUMS
!                OUTA:LINE=RPT_NPK&CHR(9)&NOS:KATALOGA_NR&CHR(9)&SUMM
!                ADD(OUTFILEANSI)
!           END
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
  IF ERRORCODE() OR ~(NOS:PAR_NR=PAS:PAR_NR AND NOS:DOK_NR=PAS:DOK_NR)
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
