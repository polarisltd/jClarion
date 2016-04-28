                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdatePERNOS PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
VUT                  STRING(30)
CAL_STUNDAS          STRING(1)
CAL_DIENAS           USHORT
D                    BYTE
DD                   BYTE
PER_DIENAS0C         BYTE
izmaksatNM           STRING(20)
DPK                  STRING(70)
RIKOJUMS             STRING(20)
A_SWINDOW WINDOW('Norâdiet dokumenta Tipu:'),AT(,,134,66),FONT('MS Sans Serif',10,,FONT:bold),CENTER, |
         IMM,HLP('UpdatePAVAD'),SYSTEM,GRAY,RESIZE,MDI
       OPTION,AT(6,3,116,54),FONT(,10,,FONT:bold),USE(PER:PAZIME),BOXED
         RADIO('&A-Atvaïinâjums'),AT(18,17),USE(?per:pazime:Radio1),VALUE('A')
         RADIO('&S-Slimîbas lapa'),AT(18,28,73,10),USE(?per:pazime:Radio2),VALUE('S')
       END
       BUTTON('&OK'),AT(82,38),USE(?OK1),DEFAULT
     END

SUMMA_VIDN_D   DECIMAL(7,3)
SUMMA_VIDK     DECIMAL(7,2)
SUMMA_VIDC_D   DECIMAL(7,3)
STUNDAS_CALK   USHORT
STUNDAS_NOSK   USHORT
DIENAS_CALK    USHORT
PER_SUMMA0     DECIMAL(7,3)
PER_SUMMA1     DECIMAL(7,3)
PER_SUMMA2     DECIMAL(7,3)
PER_SUMMAX     DECIMAL(7,3)
dienas_cal     BYTE
STUNDAS_CAL    BYTE
SUM_M          DECIMAL(7,2)
KO             DECIMAL(3,2),DIM(14)
K              DECIMAL(3,2)
PER_ID         LIKE(PER:ID)
PER_PAZIME     LIKE(PER:PAZIME)
PER_SAK_DAT    LIKE(PER:SAK_DAT)
PER_BEI_DAT    LIKE(PER:BEI_DAT)
PER_POSITION   STRING(260)
PER_RECORD     LIKE(PER:RECORD)
Update::Reloop  BYTE
Update::Error   BYTE
History::PER:Record LIKE(PER:Record),STATIC
SAV::PER:Record      LIKE(PER:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the PERNOS File'),AT(,,263,246),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('UpdatePERNOS'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(6,10,250,211),USE(?CurrentTab)
                         TAB('Atvaïinâjuma aprçíins'),USE(?Tab:1)
                           STRING(@n_6),AT(210,24),USE(PER:ID)
                           STRING('darbadienas'),AT(202,34,42,10),USE(?String4),LEFT(1)
                           PROMPT('&No'),AT(34,38),USE(?Prompt7)
                           SPIN(@D06.B),AT(50,37,53,12),USE(PER:SAK_DAT)
                           SPIN(@D06.B),AT(130,37,53,12),USE(PER:BEI_DAT)
                           STRING(@n3B),AT(186,34),USE(PER:DIENAS)
                           PROMPT('&lîdz'),AT(113,38,14,10),USE(?Prompt8)
                           STRING(@n3B),AT(186,42),USE(CAL_DIENAS)
                           STRING('kal.dienas'),AT(202,42,42,10),USE(?String4:2),LEFT(1)
                           PROMPT('&Izmaksât ar MM.YYYY'),AT(30,54,96,10),USE(?PER:YYYYMM:Prompt),RIGHT
                           ENTRY(@D014.B),AT(130,52,35,12),USE(PER:YYYYMM),REQ
                           STRING('algu sarakstu'),AT(170,54),USE(?String49)
                           BUTTON('Dienas vidçjâ'),AT(18,68,54,14),USE(?ButtonVid)
                           STRING('atvaïinâjumam'),AT(78,70),USE(?String20)
                           ENTRY(@n_8.3),AT(126,70,36,10),USE(PER:VSUMMA),LEFT(1)
                           STRING('svçtku d.'),AT(166,70),USE(?String20:2)
                           ENTRY(@n_8.3),AT(198,70,44,12),USE(PER:VSUMMAS),LEFT(1)
                           STRING('0-bezalgas atvaïinâjums'),AT(118,82),USE(?String59),FONT(,,COLOR:Gray,)
                           STRING(@s70),AT(14,93,235,10),USE(DPK   ),CENTER,FONT(,,COLOR:Red,,CHARSET:ANSI)
                           LINE,AT(234,105,-215,0),USE(?Line1),COLOR(COLOR:Black)
                           LINE,AT(20,105,0,87),USE(?Line3),COLOR(COLOR:Black)
                           LINE,AT(234,105,0,87),USE(?Line4),COLOR(COLOR:Black)
                           STRING('CAL'),AT(138,110),USE(?String45)
                           LINE,AT(234,122,-215,0),USE(?Line5),COLOR(COLOR:Black)
                           LINE,AT(154,105,0,87),USE(?Line6),COLOR(COLOR:Black)
                           LINE,AT(186,105,0,87),USE(?Line7),COLOR(COLOR:Black)
                           LINE,AT(234,192,-214,0),USE(?Line8),COLOR(COLOR:Black)
                           BUTTON('Rîk. U_Nr :'),AT(9,196,41,14),USE(?Button8)
                           ENTRY(@N_6B),AT(52,197,29,12),USE(PER:RIK_NR),RIGHT(1)
                           BUTTON('Pievienot rîkojumiem'),AT(83,197,78,14),USE(?ButtonRikojumi),HIDE
                           STRING(@s20),AT(162,200,91,10),USE(RIKOJUMS),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           STRING('Dienas'),AT(158,110),USE(?String9)
                           STRING('Summa'),AT(198,110),USE(?String10)
                           STRING('Izmaksât :'),AT(22,129),USE(?String36)
                           STRING(@D014.),AT(62,129),USE(PER:YYYYMM,,?PER:YYYYMM:3)
                           STRING(@n_8.2),AT(190,129),USE(PER:SUMMA)
                           STRING('Atvaïinâjums ðajâ mçnesî'),AT(22,139),USE(?StringG1)
                           STRING(@n_3B),AT(166,139),USE(PER:DIENAS0)
                           STRING(@n_8.2B),AT(190,139),USE(PER:SUMMA0)
                           STRING(@n3B),AT(134,139),USE(PER:DIENAS0C),CENTER
                           STRING('Atvaïinâjums nâkoðajâ mçnesî'),AT(22,150),USE(?StringG2)
                           STRING(@n3B),AT(134,150),USE(PER:DIENAS1C),CENTER
                           STRING(@n_3B),AT(166,150),USE(PER:DIENAS1)
                           STRING(@n_8.2B),AT(190,150),USE(PER:SUMMA1)
                           STRING('Atvaïinâjums aiznâkoðajâ mçnesî'),AT(22,160),USE(?StringG3)
                           STRING(@n3B),AT(134,160),USE(PER:DIENAS2C),CENTER
                           STRING(@n_3B),AT(166,160),USE(PER:DIENAS2)
                           STRING(@n_8.2B),AT(190,160),USE(PER:SUMMA2)
                           STRING('Piemaksa par svçtku dienâm'),AT(22,170),USE(?StringG3:2)
                           STRING(@n3B),AT(166,170),USE(PER:DIENASS)
                           STRING(@n_8.2B),AT(190,170),USE(PER:SUMMAS)
                           STRING('?'),AT(22,178),USE(?StringG3:3)
                           STRING(@n3B),AT(134,181),USE(PER:DIENASXC),CENTER
                           STRING(@n3B),AT(166,181),USE(PER:DIENASX)
                           STRING(@n_8.2B),AT(190,181),USE(PER:SUMMAX)
                         END
                         TAB('Slimîbas lapa'),USE(?Tab:2)
                           PROMPT('Slimîbas lapa &no'),AT(18,40,56,10),USE(?PER:SAK_DAT:Prompt:2)
                           ENTRY(@D06.B),AT(74,38,44,12),USE(PER:SAK_DAT,,?PER:SAK_DAT:2),RIGHT(1)
                           PROMPT('&lîdz'),AT(122,40),USE(?PER:BEI_DAT:Prompt:2)
                           ENTRY(@D06.B),AT(138,38,44,12),USE(PER:BEI_DAT,,?PER:BEI_DAT:2),RIGHT(1)
                           STRING(@n3B),AT(186,40),USE(PER:DIENAS,,?PER:DIENAS:2)
                           STRING('darba dienas'),AT(206,40),USE(?String28)
                           PROMPT('&Izmaksât MM.YY :'),AT(74,54),USE(?PER:YYYYMM:Prompt:2),LEFT
                           ENTRY(@D014.B),AT(138,52,35,12),USE(PER:YYYYMM,,?PER:YYYYMM:2),RIGHT(1)
                           BUTTON('Dienas vidçjâ'),AT(30,65,54,14),USE(?ButtonVid:2)
                           ENTRY(@n-10.3),AT(90,68,36,10),USE(PER:VSUMMA,,?PER:VSUMMA:2),LEFT(1)
                           PROMPT('A la&pu maksât:'),AT(134,68,53,10),USE(?PER:A_DIENAS:Prompt)
                           ENTRY(@n3),AT(190,65),USE(PER:A_DIENAS)
                           STRING('CAL dienas'),AT(214,68),USE(?String53)
                           STRING(@s70),AT(14,80,237,10),USE(DPK,,?DPK:2),CENTER,FONT(,,COLOR:Red,,CHARSET:ANSI)
                           LINE,AT(234,90,-205,0),USE(?Line9),COLOR(COLOR:Black)
                           STRING('CAL'),AT(138,94),USE(?String57)
                           STRING('Izmaksât :'),AT(30,112),USE(?String36:2)
                           STRING(@D014.),AT(70,112),USE(PER:YYYYMM,,?PER:YYYYMM:4)
                           ENTRY(@n_8.2),AT(194,109,35,12),USE(PER:SUMMA,,?PER:SUMMA:2),DISABLE,RIGHT(1)
                           STRING('Slimîbas lapa ðajâ mçnesi'),AT(30,125),USE(?StringG1:2)
                           ENTRY(@n-10.2),AT(194,122,35,12),USE(PER:SUMMA0,,?PER:SUMMA0:2),DISABLE,RIGHT(1)
                           ENTRY(@n2B),AT(158,122,24,12),USE(PER:DIENAS0,,?PER:DIENAS0:2),DISABLE,RIGHT(1)
                           STRING('Slimîbas lapa pagâjuðajâ mçnesî'),AT(30,138),USE(?StringG1:3)
                           ENTRY(@n3B),AT(158,137,24,12),USE(PER:DIENAS1,,?PER:DIENAS1:2),DISABLE,RIGHT(1)
                           ENTRY(@n-10.2),AT(194,136,35,12),USE(PER:SUMMA1,,?PER:SUMMA1:2),DISABLE,RIGHT(1)
                           STRING('(+) Slim. lapa pagâjuðajâ mçnesî'),AT(30,150),USE(?StringG1:4)
                           ENTRY(@n3B),AT(158,150,24,12),USE(PER:DIENASX,,?PER:DIENASX:2),DISABLE,RIGHT(1)
                           ENTRY(@n-10.2),AT(194,149,35,12),USE(PER:SUMMAX,,?PER:SUMMAX:2),DISABLE,RIGHT(1)
                           STRING('Slimîbas lapa nâkoðajâ mçnesî'),AT(34,162),USE(?StringG1:5)
                           STRING(@n3b),AT(136,162),USE(PER:DIENAS2C,,?PER:DIENAS2C:2)
                           ENTRY(@n3B),AT(158,162,24,12),USE(PER:DIENAS2,,?PER:DIENAS2:2),DISABLE,RIGHT(1)
                           ENTRY(@n-10.2),AT(194,162,35,12),USE(PER:SUMMA2,,?PER:SUMMA2:2),DISABLE,RIGHT(1)
                           IMAGE('CHECK3.ICO'),AT(238,174,15,21),USE(?Image:LOCK),HIDE
                           LINE,AT(234,90,0,88),USE(?Line15),COLOR(COLOR:Black)
                           STRING('Dienas'),AT(158,94),USE(?String9:2)
                           STRING('Summa'),AT(198,94),USE(?String10:2)
                           LINE,AT(186,90,0,88),USE(?Line14),COLOR(COLOR:Black)
                           LINE,AT(154,90,0,88),USE(?Line13),COLOR(COLOR:Black)
                           LINE,AT(26,90,0,88),USE(?Line12),COLOR(COLOR:Black)
                           LINE,AT(234,178,-206,0),USE(?Line11),COLOR(COLOR:Black)
                           BUTTON('Atvçrt grafiku'),AT(174,181,60,14),USE(?ButtonGrafiks)
                           LINE,AT(234,106,-206,0),USE(?Line10),COLOR(COLOR:Black)
                         END
                       END
                       BUTTON('Pârrçíinât (CAL)'),AT(90,225,63,14),USE(?ButtonParrekinat)
                       BUTTON('&OK'),AT(160,225,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(208,225,45,14),USE(?Cancel)
                       STRING(@s8),AT(-1,228),USE(PER:ACC_KODS),FONT(,,COLOR:Gray,)
                       STRING(@D06.),AT(37,228),USE(PER:ACC_DATUMS),FONT(,,COLOR:Gray,)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  LOOP I#=1 TO 14   !A-LAPA
    CASE I#
    OF 1
      KO[I#]=0
    OF 2
    OROF 3
      KO[I#]=0.75
    ELSE
      KO[I#]=0.8
    .
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  VUT=GETKADRI(PER:ID,2,1)
  CAL_DIENAS=PER:BEI_DAT-PER:SAK_DAT+1
!  PER_DIENAS0C=DATE(MONTH(PER:SAK_DAT)+1,1,YEAR(PER:SAK_DAT))-PER:SAK_DAT !PAGAIDÂM
!  IF PER_DIENAS0C>CAL_DIENAS THEN PER_DIENAS0C=CAL_DIENAS. !PAGAIDÂM
  ?Tab:1{PROP:TEXT}=VUT
  ?Tab:2{PROP:TEXT}=VUT
  IF PER:RIK_NR
     DISABLE(?PER:RIK_NR)
     RIKOJUMS=GETKAD_RIK(PER:RIK_NR,1)
     IF RIKOJUMS
        ?ButtonRikojumi{PROP:TEXT}='Mainît rîkojumu'
     .
  .
  IF PER:PAZIME='A'
     HIDE(?TAB:2)
     IF OPCIJA='R' !SAUC NO RÎKOJUMIEM
     !
     ELSE
        UNHIDE(?ButtonRikojumi)
     .
  ELSE
     HIDE(?TAB:1)
     IF PER:LOCK=1  !ATVÇRTS GRAFIKS
        ENABLE(?PER:SUMMA:2)
        ENABLE(?PER:SUMMA0:2)
        ENABLE(?PER:SUMMA1:2)
        ENABLE(?PER:SUMMAX:2)
        ENABLE(?PER:SUMMA2:2)
        ENABLE(?PER:DIENAS0:2)
        ENABLE(?PER:DIENAS1:2)
        ENABLE(?PER:DIENASX:2)
        ENABLE(?PER:DIENAS2:2)
        UNHIDE(?IMAGE:LOCK)
     .
  .
  
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?PER:ID)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::PER:Record = PER:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(PERNOS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?PER:ID)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PER:Record <> PER:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PERNOS(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?PER:ID)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          OF 2
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?PER:SAK_DAT
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:BEI_DAT
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:YYYYMM
      CASE EVENT()
      OF EVENT:Accepted
        !IF ~PER:VSUMMA  LAI VAR IELIKT 0 (BEZALGAS ATVAÏINÂJUMS)
        !   DO VID
        !.
        DO GRAFIKS
      END
    OF ?ButtonVid
      CASE EVENT()
      OF EVENT:Accepted
        CLEAR(ALG:RECORD)
        ALG:YYYYMM=DATE(MONTH(PER:YYYYMM)+11,1,YEAR(PER:YYYYMM)-1)
        ALG:ID=PER:ID
        DO SyncWindow
        GlobalRequest = SelectRecord
        VIDALGA 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PER:VSUMMA =REALMAS[1]     !VIDÇJÂ
           PER:VSUMMAS=REALMAS[2]     !VIDÇJÂ SVÇTKU D.
           IF REALMAS[3]<1
              DPK='Darbâ piedalîðanâs koeficients= '&FORMAT(REALMAS[3],@N5.2)&' jâmaina dienas vidçjâ uz '&|
              FORMAT(PER:VSUMMA*REALMAS[3],@N6.3)
           .
           DISPLAY
        .
        DO GRAFIKS
        SELECT(?OK)
      END
    OF ?PER:VSUMMA
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:VSUMMAS
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?Button8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ENABLE(?PER:RIK_NR)
        SELECT(?PER:RIK_NR)
      END
    OF ?ButtonRikojumi
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PER:SAK_DAT AND PER:BEI_DAT
           CLEAR(RIK:RECORD)
           GLOBALREQUEST=1
           IF PER:RIK_NR
              RIK:U_NR=PER:RIK_NR
              GET(KAD_RIK,RIK:NR_KEY)
              IF ~ERROR()
                 GLOBALREQUEST=2
              .
           .
        !   IF GLOBALREQUEST=1    NAV JÇGAS
        !      RIK:ID=PER:ID
        !      RIK:TIPS='A'
        !      RIK:DATUMS=TODAY() !JÂDOMÂ...
        !      RIK:DOK_NR=PERFORMGL(11)
        !      RIK:DATUMS1=PER:SAK_DAT
        !      RIK:DATUMS2=PER:BEI_DAT
        !      RIK:SATURS=''
        !      RIK:ACC_KODS=ACC_KODS
        !      RIK:ACC_DATUMS=TODAY()
        !   .
           OPCIJA='A' !LAI ZINÂTU, KA SAUC NO ATVAÏINÂJUMIEM
           ID=RIK:ID
           UPDATEKAD_RIK
           IF GLOBALRESPONSE=REQUESTCOMPLETED
              PER:RIK_NR=RIK:U_NR
              RIKOJUMS=GETKAD_RIK(PER:RIK_NR,1)
              ?ButtonRikojumi{PROP:TEXT}='Mainît rîkojumu'
              IF LOCALREQUEST=1
                 DISABLE(?Cancel)
              .
           .
           OPCIJA=''
           SELECT(?OK)
           DISPLAY
        ELSE
           KLUDA(0,'nav norâdîts atvaïinâjuma periods')
        .
      END
    OF ?PER:SAK_DAT:2
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:BEI_DAT:2
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:YYYYMM:2
      CASE EVENT()
      OF EVENT:Accepted
        IF ~PER:VSUMMA AND PER:PAZIME='S'
           DO VID
        .
        DO GRAFIKS
      END
    OF ?ButtonVid:2
      CASE EVENT()
      OF EVENT:Accepted
        CLEAR(ALG:RECORD)
        ALG:YYYYMM=DATE(MONTH(PER:YYYYMM)+11,1,YEAR(PER:YYYYMM)-1)
        ALG:ID=PER:ID
        DO SyncWindow
        GlobalRequest = SelectRecord
        VIDALGA 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PER:VSUMMA=REALMAS[1]
           IF REALMAS[3]<1
              DPK='Darbâ piedalîðanâs koeficients= '&FORMAT(REALMAS[3],@N5.2)&' jâmaina dienas vidçjâ uz '&|
              FORMAT(PER:VSUMMA*REALMAS[3],@N6.3)
           .
           DISPLAY
        .
        DO GRAFIKS
        SELECT(?OK)
        
      END
    OF ?PER:VSUMMA:2
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?PER:A_DIENAS
      CASE EVENT()
      OF EVENT:Accepted
        DO GRAFIKS
      END
    OF ?ButtonGrafiks
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        PER:LOCK=1
        ENABLE(?PER:SUMMA:2)
        ENABLE(?PER:SUMMA0:2)
        ENABLE(?PER:SUMMA1:2)
        ENABLE(?PER:SUMMAX:2)
        ENABLE(?PER:SUMMA2:2)
        ENABLE(?PER:DIENAS0:2)
        ENABLE(?PER:DIENAS1:2)
        ENABLE(?PER:DIENASX:2)
        ENABLE(?PER:DIENAS2:2)
        UNHIDE(?IMAGE:LOCK)
        DISPLAY
      END
    OF ?ButtonParrekinat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PER:PAZIME='S'
           PER:LOCK=0
           DISABLE(?PER:SUMMA:2)
           DISABLE(?PER:SUMMA0:2)
           DISABLE(?PER:SUMMA1:2)
           DISABLE(?PER:SUMMAX:2)
           DISABLE(?PER:SUMMA2:2)
           DISABLE(?PER:DIENAS0:2)
           DISABLE(?PER:DIENAS1:2)
           DISABLE(?PER:DIENASX:2)
           DISABLE(?PER:DIENAS2:2)
           HIDE(?IMAGE:LOCK)
        .
        DO grafiks
        SELECT(?OK)
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        IF PER:PAZIME='A'
           ZAPTE#=FALSE
           IF PER:DIENAS1C AND PER:SUMMA1 !IR APMAKSÂTS ATVAÏINÂJUMS NÂKOÐAJÂ MÇN.
              LOOP I#= DATE(MONTH(PER:YYYYMM)+1,1,YEAR(PER:YYYYMM)) TO DATE(MONTH(PER:YYYYMM)+2,1,YEAR(PER:YYYYMM))-1
                 IF ~INRANGE(I#,PER:SAK_DAT,PER:BEI_DAT) !ATVAÏINÂJUMS NEPÂRKLÂJ VISU NÂKOÐO MÇN.
                    IF INSTRING(GETCAL(I#),'012345678')  !NEPÂRKLÂJAS DARBADIENA
                       ZAPTE#=FALSE
                       BREAK                             !VISS BÛS OK.
                    ELSE
                       ZAPTE#=TRUE                       !VAR BÛT ZAPTE
                    .
                 .
              .
           .
           IF ZAPTE#=TRUE
              KLUDA(0,'Nâk.mçn.nebûs nevienas DarbaD.,bet atvaïinâjums nepârklâj visu KalendâroM.')
           .
           ZAPTE#=FALSE
           IF PER:DIENAS2C AND PER:SUMMA2 !IR APMAKSÂTS ATVAÏINÂJUMS AIZNÂKOÐAJÂ MÇN.
              LOOP I#= DATE(MONTH(PER:YYYYMM)+2,1,YEAR(PER:YYYYMM)) TO DATE(MONTH(PER:YYYYMM)+3,1,YEAR(PER:YYYYMM))-1
                 IF ~INRANGE(I#,PER:SAK_DAT,PER:BEI_DAT) !ATVAÏINÂJUMS NEPÂRKLÂJ VISU AIZNÂKOÐO MÇN.
                    IF INSTRING(GETCAL(I#),'012345678')  !NEPÂRKLÂJAS DARBADIENA
                       ZAPTE#=FALSE
                       BREAK                             !VISS BÛS OK.
                    ELSE
                       ZAPTE#=TRUE                       !VAR BÛT ZAPTE
                    .
                 .
              .
           .
           IF ZAPTE#=TRUE
              KLUDA(0,'AIZNâk.mçn.nebûs nevienas DarbaD.,bet atvaïinâjums nepârklâj visu KalendâroM.')
           .
        .
        
        PER_ID=PER:ID
        PER_PAZIME=PER:PAZIME
        PER_SAK_DAT=PER:SAK_DAT
        PER_BEI_DAT=PER:BEI_DAT
        PER_POSITION=POSITION(PERNOS)
        PER_RECORD=PER:RECORD
        KLUDA#=FALSE
        CLEAR(PER:RECORD)
        PER:ID=PER_ID
        SET(PER:ID_KEY,PER:ID_KEY)
        LOOP
           NEXT(PERNOS)
           IF ERROR() OR ~(PER:ID=PER_ID) THEN BREAK.
           IF PER_POSITION=POSITION(PERNOS) THEN CYCLE.
           IF INRANGE(PER:SAK_DAT,PER_SAK_DAT,PER_BEI_DAT) OR INRANGE(PER:BEI_DAT,PER_SAK_DAT,PER_BEI_DAT)
              KLUDA(0,'Tekoðais '&PER_PAZIME&' raksts pârklâjas ar '&PER:PAZIME&': '&FORMAT(PER:SAK_DAT,@D6)&'-'&FORMAT(PER:BEI_DAT,@D6))
              KLUDA#=TRUE
           .
        .
        RESET(PERNOS,PER_POSITION)
        NEXT(PERNOS)
        PER:RECORD=PER_RECORD
        IF KLUDA#=TRUE
           CYCLE
        .
        
        PER:ACC_KODS=ACC_kods
        PER:ACC_DATUMS=today()
        
        !DO SyncWindow
        !IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
        !   IF PER:PAZIME='A'  !SLILAPAI SELECT NEVAJAG
        !      SELECT()
        !   .
        !ELSE
        !   POST(EVENT:Completed)
        !END
        !OMIT('END')
        
        IF PER:PAZIME='S'  !SLILAPAI SELECT NEVAJAG
           DISABLE(?PER:SUMMA:2)
        .
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  BIND(RIK:RECORD)
  IF PERNOS::Used = 0
    CheckOpen(PERNOS,1)
  END
  PERNOS::Used += 1
  BIND(PER:RECORD)
  FilesOpened = True
  RISnap:PERNOS
  SAV::PER:Record = PER:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
   IF OPCIJA='R' !SAUC NO RÎKOJUMIEM
       PER:PAZIME='A'
!       I#=GETKADRI  !JÂBÛT POZICIONÇTAM
!       PER:SAK_DAT=RIK:DATUMS1
!       PER:BEI_DAT=RIK:DATUMS2
!       PER:YYYYMM=DATE(MONTH(RIK:DATUMS1),1,YEAR(RIK:DATUMS1))
   ELSE
       PER:PAZIME='A'
       OPEN(A_SWINDOW)
       DISPLAY
       accept
          case field()
          of (?OK1)
             if event()=EVENT:Accepted
                close(A_SWINDOW)
                BREAK
             .
          .
       .
       globalrequest=selectrecord
       BROWSEKADRI
       IF ~(GLOBALRESPONSE=REQUESTCOMPLETED)
          DO PROCEDURERETURN
       .
       PER:SAK_DAT=TODAY()
       IF PER:PAZIME='A'
          PER:BEI_DAT=PER:SAK_DAT+28-1 !4 NEDÇÏAS
       ELSE
          PER:A_DIENAS=10    !A_LAPU MAKSÂ 10 DIENAS 10.02.2009.
          PER:BEI_DAT=PER:SAK_DAT+PER:A_DIENAS-1
       .
       PER:YYYYMM=DATE(MONTH(TODAY()),1,YEAR(TODAY()))
    .
    PER:ID=KAD:ID
    PER:INI=KAD:INI
    DO GRAFIKS
    PER:ACC_KODS=ACC_kods
    PER:ACC_DATUMS=today()

    CHECKOPEN(ALGAS,1)
    CLEAR(ALG:RECORD)
    ALG:ID=PER:ID+1  !LAI VARAM IET CAURI TAM ID NO PÇDÇJÂ MÇNEÐA
    SET(ALG:ID_DAT,ALG:ID_DAT)
    PREVIOUS(ALGAS)  !PAÐU PÇDÇJO IZLAIÞAM
    LOOP
       PREVIOUS(ALGAS)
!       STOP(ALG:ID&' '&FORMAT(ALG:YYYYMM,@D06.))
       IF ERROR() THEN BREAK.
       IF ALG:ID=PER:ID
          L#+=1
          IF L#<=6
             IF BAND(ALG:BAITS,00000010B) !JAU IR
                CYCLE
             ELSE
                ALG:BAITS+=2
                PUT(ALGAS)
             .
          ELSE
             BREAK
          .
       ELSE
          BREAK
       .
    .

  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:PERNOS()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdatePERNOS','winlats.INI')
  WinResize.Resize
  ?PER:ID{PROP:Alrt,255} = 734
  ?PER:SAK_DAT{PROP:Alrt,255} = 734
  ?PER:BEI_DAT{PROP:Alrt,255} = 734
  ?PER:DIENAS{PROP:Alrt,255} = 734
  ?PER:YYYYMM{PROP:Alrt,255} = 734
  ?PER:VSUMMA{PROP:Alrt,255} = 734
  ?PER:VSUMMAS{PROP:Alrt,255} = 734
  ?PER:RIK_NR{PROP:Alrt,255} = 734
  ?PER:YYYYMM:3{PROP:Alrt,255} = 734
  ?PER:SUMMA{PROP:Alrt,255} = 734
  ?PER:DIENAS0{PROP:Alrt,255} = 734
  ?PER:SUMMA0{PROP:Alrt,255} = 734
  ?PER:DIENAS0C{PROP:Alrt,255} = 734
  ?PER:DIENAS1C{PROP:Alrt,255} = 734
  ?PER:DIENAS1{PROP:Alrt,255} = 734
  ?PER:SUMMA1{PROP:Alrt,255} = 734
  ?PER:DIENAS2C{PROP:Alrt,255} = 734
  ?PER:DIENAS2{PROP:Alrt,255} = 734
  ?PER:SUMMA2{PROP:Alrt,255} = 734
  ?PER:DIENASS{PROP:Alrt,255} = 734
  ?PER:SUMMAS{PROP:Alrt,255} = 734
  ?PER:DIENASXC{PROP:Alrt,255} = 734
  ?PER:DIENASX{PROP:Alrt,255} = 734
  ?PER:SUMMAX{PROP:Alrt,255} = 734
  ?PER:SAK_DAT:2{PROP:Alrt,255} = 734
  ?PER:BEI_DAT:2{PROP:Alrt,255} = 734
  ?PER:DIENAS:2{PROP:Alrt,255} = 734
  ?PER:YYYYMM:2{PROP:Alrt,255} = 734
  ?PER:VSUMMA:2{PROP:Alrt,255} = 734
  ?PER:A_DIENAS{PROP:Alrt,255} = 734
  ?PER:YYYYMM:4{PROP:Alrt,255} = 734
  ?PER:SUMMA:2{PROP:Alrt,255} = 734
  ?PER:SUMMA0:2{PROP:Alrt,255} = 734
  ?PER:DIENAS0:2{PROP:Alrt,255} = 734
  ?PER:DIENAS1:2{PROP:Alrt,255} = 734
  ?PER:SUMMA1:2{PROP:Alrt,255} = 734
  ?PER:DIENASX:2{PROP:Alrt,255} = 734
  ?PER:SUMMAX:2{PROP:Alrt,255} = 734
  ?PER:DIENAS2C:2{PROP:Alrt,255} = 734
  ?PER:DIENAS2:2{PROP:Alrt,255} = 734
  ?PER:SUMMA2:2{PROP:Alrt,255} = 734
  ?PER:ACC_KODS{PROP:Alrt,255} = 734
  ?PER:ACC_DATUMS{PROP:Alrt,255} = 734
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
    PERNOS::Used -= 1
    IF PERNOS::Used = 0 THEN CLOSE(PERNOS).
  END
  IF WindowOpened
    INISaveWindow('UpdatePERNOS','winlats.INI')
    CLOSE(QuickWindow)
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
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
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
!-----------------------------------------------------------------------------------------
GRAFIKS         ROUTINE
 IF ~PER:LOCK   !NAV ATVÇRTS GRAFIKS ( PAGAIDÂM TIKAI SLILAPA)
    PER:DIENAS0=0
    PER:DIENAS0C=0
    PER:DIENAS1=0
    PER:DIENAS1C=0
    PER:DIENAS2=0
    PER:DIENAS2C=0
    PER:DIENASS=0
    PER:DIENASX=0
    PER:DIENASXC=0
    CAL_DIENAS=0
    DD=0
    IF PER:PAZIME='A' !***********************ATVAÏINÂJUMS**************************
       IF PER:SAK_DAT AND PER:BEI_DAT
          LOOP I#=PER:SAK_DAT TO PER:BEI_DAT
             Cal_stundas=GETCAL(I#)
             D=0
             IF PER:SAK_DAT>=DATE(6,1,2002)
                IF INSTRING(CAL_STUNDAS,'012345678')
                   D=1 !TIKAI DARBA DIENAS
                ELSIF INSTRING(CAL_STUNDAS,'X') !SVÇTKU DIENAS darba dienâs
                   PER:DIENASS+=1
                .
             ELSE
                IF INSTRING(CAL_STUNDAS,'012345678S')
                   D=1 !DARBA DIENAS+SESTDIENAS
                .
             .
             IF MONTH(PER:YYYYMM)=MONTH(I#)
                PER:DIENAS0+=D
                PER:DIENAS0C+=1
             ELSIF MONTH(PER:YYYYMM)+1=MONTH(I#)
                PER:DIENAS1+=D
                PER:DIENAS1C+=1
             ELSIF MONTH(PER:YYYYMM)+2=MONTH(I#)
                PER:DIENAS2+=D
                PER:DIENAS2C+=1
             ELSE
                PER:DIENASX+=D
                PER:DIENASXC+=1
             .
             DD+=D               !SKAITAM DARBADIENAS
             CAL_DIENAS+=1       !SKAITAM KALENDÂRÂS DIENAS
          .
   !       PER:BEI_DAT=I#-1+PER:DIENASS  !SVÇTKU DIENAS ATVAÏINÂJUMAM JÂLIEK KLÂT
   !       PER:BEI_DAT=I#-1  !20 vai ciktur DIENAS+ svçtku dienas darba dienâs
          PER:DIENAS=DD
          PER:SUMMA0=PER:DIENAS0*PER:VSUMMA
          PER:SUMMA1=PER:DIENAS1*PER:VSUMMA
          PER:SUMMA2=PER:DIENAS2*PER:VSUMMA
          PER:SUMMAS=PER:DIENASS*PER:VSUMMAS
          PER:SUMMAX=PER:DIENASX*PER:VSUMMA
          PER:SUMMA =PER:DIENAS*PER:VSUMMA+PER:SUMMAS
       .
    ELSE  !*********************SLILAPA*******************************
       PER_SUMMA0=0
       PER_SUMMA1=0
       PER_SUMMA2=0
       PER_SUMMAX=0
       J#=0
       IF PER:SAK_DAT AND PER:BEI_DAT
   !       IF PER:SAK_DAT+14-1 > PER:BEI_DAT   !SLILAPU MAKSÂ 14 DIENAS
          IF PER:SAK_DAT+PER:A_DIENAS-1 > PER:BEI_DAT   !SLILAPU MAKSÂ 14 DIENAS
             END#=PER:BEI_DAT
          ELSE
   !          END#=PER:SAK_DAT+14-1
             END#=PER:SAK_DAT+PER:A_DIENAS-1
          .
          LOOP I#=PER:SAK_DAT TO END#
             Cal_stundas=GETCAL(I#)
             D=0
             K=0
             J#+=1
             IF INSTRING(CAL_STUNDAS,'012345678') THEN D=1. !TIKAI DARBA DIENAS
!             IF J# <=14 THEN K=KO[J#].   !KOEFICIENTS 1.DIENA=0  2,3=0.75 4-14=0.8
             IF J# <=PER:A_DIENAS THEN K=KO[J#].   !KOEFICIENTS 1.DIENA=0  2,3=0.75 4-14=0.8
             IF MONTH(PER:YYYYMM)=MONTH(I#)
                PER:DIENAS0+=D
                PER_SUMMA0+=PER:VSUMMA*K*D
             ELSIF MONTH(DATE(month(PER:YYYYMM)+11,1,YEAR(PER:YYYYMM)-1))=MONTH(I#) !PAGÂJUÐAIS MÇNESIS
                PER:DIENAS1+=D
                PER_SUMMA1+=PER:VSUMMA*K*D
             ELSIF MONTH(PER:YYYYMM)<MONTH(I#)                                      !NÂKOÐIE MÇNEÐI
                PER:DIENAS2+=D
                PER:DIENAS2C+=1                                                     !KALENDÂRÂS DIENAS PRIEKÐ NEA...
                PER_SUMMA2+=PER:VSUMMA*K*D
             ELSE                                                                   !AIZ...PAGÂJUÐIE MÇNEÐI
                PER:DIENASX+=D
                PER_SUMMAX+=PER:VSUMMA*K*D
             .
             DD+=D               !SKAITAM DARBADIENAS
             CAL_DIENAS+=1       !SKAITAM KALENDÂRÂS DIENAS
          .
          PER:SUMMA0=PER_SUMMA0
          PER:SUMMA1=PER_SUMMA1
          PER:SUMMA2=PER_SUMMA2
          PER:SUMMAX=PER_SUMMAX
          PER:SUMMA =PER:SUMMAX+PER:SUMMA0+PER:SUMMA1+PER:SUMMA2
       .
    .
    PER:DIENAS=DD       ! DARBADIENAS
!    STOP(CAL_DIENAS)
    DISPLAY
 .

!-----------------------------------------------------------------------------------------
VID         ROUTINE
 DIENAS_CALK =0
 STUNDAS_CALK=0
 STUNDAS_NOSK=0
 SUMMA_VIDK  =0
 CLEAR(ALG:RECORD)
 ALG:ID=PER:ID
 ALG:YYYYMM=DATE(MONTH(PER:YYYYMM)+6,1,YEAR(PER:YYYYMM)-1) !PÇDÇJIE 6 MÇNEÐI PIRMS yyyymm
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR ~(ALG:ID=PER:ID AND ALG:YYYYMM < PER:YYYYMM) THEN BREAK.
    SUM_M = 0
    LOOP I#= 1 TO 20
       IF ALG:K[I#]
          IF GETDAIEV(ALG:K[I#],2,1) AND DAI:VIDYN='Y'   !Pieòemam, ka vidçjo visur rçíina vienâdi
             SUM_M+=ALG:R[I#]
          .
       .
    .
    DIENAS_CAL=CALCSTUNDAS(ALG:YYYYMM,0,0,0,2)
    STUNDAS_CAL=CALCSTUNDAS(ALG:YYYYMM,0,0,0,1)
    DIENAS_CALK +=dienas_cal
    STUNDAS_CALK+=STUNDAS_CAL
    STUNDAS_NOSK+=ALG:N_STUNDAS
    SUMMA_VIDK  +=SUM_M
 .
 IF PER:PAZIME='A'
    PER:VSUMMAS=(SUMMA_VIDK/STUNDAS_NOSK)*8
    PER:VSUMMA =(SUMMA_VIDK/STUNDAS_CALK)*8
 ELSE
    PER:VSUMMA =(SUMMA_VIDK/STUNDAS_NOSK)*8
 .
 DISPLAY
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?PER:ID
      PER:ID = History::PER:Record.ID
    OF ?PER:SAK_DAT
      PER:SAK_DAT = History::PER:Record.SAK_DAT
    OF ?PER:BEI_DAT
      PER:BEI_DAT = History::PER:Record.BEI_DAT
    OF ?PER:DIENAS
      PER:DIENAS = History::PER:Record.DIENAS
    OF ?PER:YYYYMM
      PER:YYYYMM = History::PER:Record.YYYYMM
    OF ?PER:VSUMMA
      PER:VSUMMA = History::PER:Record.VSUMMA
    OF ?PER:VSUMMAS
      PER:VSUMMAS = History::PER:Record.VSUMMAS
    OF ?PER:RIK_NR
      PER:RIK_NR = History::PER:Record.RIK_NR
    OF ?PER:YYYYMM:3
      PER:YYYYMM = History::PER:Record.YYYYMM
    OF ?PER:SUMMA
      PER:SUMMA = History::PER:Record.SUMMA
    OF ?PER:DIENAS0
      PER:DIENAS0 = History::PER:Record.DIENAS0
    OF ?PER:SUMMA0
      PER:SUMMA0 = History::PER:Record.SUMMA0
    OF ?PER:DIENAS0C
      PER:DIENAS0C = History::PER:Record.DIENAS0C
    OF ?PER:DIENAS1C
      PER:DIENAS1C = History::PER:Record.DIENAS1C
    OF ?PER:DIENAS1
      PER:DIENAS1 = History::PER:Record.DIENAS1
    OF ?PER:SUMMA1
      PER:SUMMA1 = History::PER:Record.SUMMA1
    OF ?PER:DIENAS2C
      PER:DIENAS2C = History::PER:Record.DIENAS2C
    OF ?PER:DIENAS2
      PER:DIENAS2 = History::PER:Record.DIENAS2
    OF ?PER:SUMMA2
      PER:SUMMA2 = History::PER:Record.SUMMA2
    OF ?PER:DIENASS
      PER:DIENASS = History::PER:Record.DIENASS
    OF ?PER:SUMMAS
      PER:SUMMAS = History::PER:Record.SUMMAS
    OF ?PER:DIENASXC
      PER:DIENASXC = History::PER:Record.DIENASXC
    OF ?PER:DIENASX
      PER:DIENASX = History::PER:Record.DIENASX
    OF ?PER:SUMMAX
      PER:SUMMAX = History::PER:Record.SUMMAX
    OF ?PER:SAK_DAT:2
      PER:SAK_DAT = History::PER:Record.SAK_DAT
    OF ?PER:BEI_DAT:2
      PER:BEI_DAT = History::PER:Record.BEI_DAT
    OF ?PER:DIENAS:2
      PER:DIENAS = History::PER:Record.DIENAS
    OF ?PER:YYYYMM:2
      PER:YYYYMM = History::PER:Record.YYYYMM
    OF ?PER:VSUMMA:2
      PER:VSUMMA = History::PER:Record.VSUMMA
    OF ?PER:A_DIENAS
      PER:A_DIENAS = History::PER:Record.A_DIENAS
    OF ?PER:YYYYMM:4
      PER:YYYYMM = History::PER:Record.YYYYMM
    OF ?PER:SUMMA:2
      PER:SUMMA = History::PER:Record.SUMMA
    OF ?PER:SUMMA0:2
      PER:SUMMA0 = History::PER:Record.SUMMA0
    OF ?PER:DIENAS0:2
      PER:DIENAS0 = History::PER:Record.DIENAS0
    OF ?PER:DIENAS1:2
      PER:DIENAS1 = History::PER:Record.DIENAS1
    OF ?PER:SUMMA1:2
      PER:SUMMA1 = History::PER:Record.SUMMA1
    OF ?PER:DIENASX:2
      PER:DIENASX = History::PER:Record.DIENASX
    OF ?PER:SUMMAX:2
      PER:SUMMAX = History::PER:Record.SUMMAX
    OF ?PER:DIENAS2C:2
      PER:DIENAS2C = History::PER:Record.DIENAS2C
    OF ?PER:DIENAS2:2
      PER:DIENAS2 = History::PER:Record.DIENAS2
    OF ?PER:SUMMA2:2
      PER:SUMMA2 = History::PER:Record.SUMMA2
    OF ?PER:ACC_KODS
      PER:ACC_KODS = History::PER:Record.ACC_KODS
    OF ?PER:ACC_DATUMS
      PER:ACC_DATUMS = History::PER:Record.ACC_DATUMS
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  PER:Record = SAV::PER:Record
  SAV::PER:Record = PER:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

BrowsePERNOS PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
UINI                 STRING(25)
A                    STRING('A')
S                    STRING('S')

BRW1::View:Browse    VIEW(PERNOS)
                       PROJECT(PER:ID)
                       PROJECT(PER:PAZIME)
                       PROJECT(PER:SAK_DAT)
                       PROJECT(PER:BEI_DAT)
                       PROJECT(PER:YYYYMM)
                       PROJECT(PER:SUMMA)
                       PROJECT(PER:INI)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PER:ID           LIKE(PER:ID)               ! Queue Display field
BRW1::PER:PAZIME       LIKE(PER:PAZIME)           ! Queue Display field
BRW1::UINI             LIKE(UINI)                 ! Queue Display field
BRW1::PER:SAK_DAT      LIKE(PER:SAK_DAT)          ! Queue Display field
BRW1::PER:BEI_DAT      LIKE(PER:BEI_DAT)          ! Queue Display field
BRW1::PER:YYYYMM       LIKE(PER:YYYYMM)           ! Queue Display field
BRW1::PER:SUMMA        LIKE(PER:SUMMA)            ! Queue Display field
BRW1::PER:INI          LIKE(PER:INI)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:Reset:S  LIKE(S)
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(PER:INI),DIM(100)
BRW1::Sort2:LowValue LIKE(PER:INI)                ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(PER:INI)               ! Queue position of scroll thumb
BRW1::Sort3:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort3:KeyDistribution LIKE(PER:SAK_DAT),DIM(100)
BRW1::Sort3:LowValue LIKE(PER:SAK_DAT)            ! Queue position of scroll thumb
BRW1::Sort3:HighValue LIKE(PER:SAK_DAT)           ! Queue position of scroll thumb
BRW1::Sort3:Reset:A  LIKE(A)
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
WinResize            WindowResizeType
QuickWindow          WINDOW('Atvaïinâjumi un Slimîbas lapas'),AT(,,363,333),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowsePERNOS'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,342,268),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('20R(1)|M~ID~C(0)@n_5@10C|M~P~@s1@100L(1)|M~Vârds Uzvârds~C(0)@s25@53R(2)|M~Sâkum' &|
   's~C(0)@D06.@53R(2)|M~Beigas~C(0)@D06.@38L(2)|M~Izmaksât~@D014.@40R(1)|M~Summa~C(' &|
   '0)@n_8.2@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(262,312,45,14),USE(?Select:2),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(206,291,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(255,291,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dzçst'),AT(305,291,45,14),USE(?Delete:3)
                       BUTTON('Aprçíina izvçrsums'),AT(181,312,75,14),USE(?ButtonAPR)
                       SHEET,AT(6,4,350,305),USE(?CurrentTab)
                         TAB('&Atvaïinâjumi Datumu sec.'),USE(?Tab:1)
                           ENTRY(@D14),AT(18,291),USE(PER:SAK_DAT)
                           STRING('-atv.sâkuma MM.YYYY'),AT(63,293),USE(?String1)
                         END
                         TAB('&SliLapas Datumu sec.'),USE(?Tab:2)
                           ENTRY(@D14),AT(11,293),USE(PER:SAK_DAT,,?PER:SAK_DAT:2)
                           STRING('-slilapas sâkuma MM.YYYY'),AT(54,295),USE(?String2)
                         END
                         TAB('Atv. un SliLapas &Uzvârdu sec.'),USE(?Tab:3)
                           ENTRY(@s5),AT(12,293),USE(PER:INI )
                           STRING('-Uzvârds'),AT(46,294),USE(?String3)
                         END
                       END
                       BUTTON('&Beigt'),AT(312,312,45,14),USE(?Close)
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
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO SelectDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    CASE FIELD()
    OF ?Browse:1
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
    OF ?Select:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?ButtonAPR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='30'
        !       12
        IZZFILTF
        IF GlobalResponse=RequestCompleted
            START(A_APR_A,50000)
        .
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?PER:SAK_DAT
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PER:SAK_DAT)
        IF PER:SAK_DAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?PER:INI 
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?PER:INI )
        IF PER:INI
          CLEAR(PER:PAZIME)
          CLEAR(PER:YYYYMM,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = PER:INI
          BRW1::Sort2:LocatorLength = LEN(CLIP(PER:INI))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
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
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  IF PERNOS::Used = 0
    CheckOpen(PERNOS,1)
  END
  PERNOS::Used += 1
  BIND(PER:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePERNOS','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  BIND('A',A)
  BIND('S',S)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
  ?Browse:1{Prop:Alrt,255} = InsertKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    PERNOS::Used -= 1
    IF PERNOS::Used = 0 THEN CLOSE(PERNOS).
  END
  IF WindowOpened
    INISaveWindow('BrowsePERNOS','winlats.INI')
    CLOSE(QuickWindow)
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
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = PER:SAK_DAT
    CLEAR(PER:SAK_DAT)
  OF 2
    PER:INI = BRW1::Sort2:LocatorValue
  OF 3
    BRW1::Sort3:LocatorValue = PER:SAK_DAT
    CLEAR(PER:SAK_DAT)
  END
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

SelectDispatch ROUTINE
  IF ACCEPTED()=TBarBrwSelect THEN         !trap remote browse select control calls
    POST(EVENT:ACCEPTED,BrowseButtons.SelectButton)
  END

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
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSIF CHOICE(?CurrentTab) = 3
    BRW1::SortOrder = 2
  ELSE
    BRW1::SortOrder = 3
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:S <> S
        BRW1::Changed = True
      END
    OF 3
      IF BRW1::Sort3:Reset:A <> A
        BRW1::Changed = True
      END
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PER:INI = BRW1::Sort2:LocatorValue
    END
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:S = S
    OF 3
      BRW1::Sort3:Reset:A = A
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
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
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PERNOS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = PER:INI
  OF 3
    BRW1::Sort3:HighValue = PER:SAK_DAT
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PERNOS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = PER:INI
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  OF 3
    BRW1::Sort3:LowValue = PER:SAK_DAT
    SetupRealStops(BRW1::Sort3:LowValue,BRW1::Sort3:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort3:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PER:ID = BRW1::PER:ID
  PER:PAZIME = BRW1::PER:PAZIME
  UINI = BRW1::UINI
  PER:SAK_DAT = BRW1::PER:SAK_DAT
  PER:BEI_DAT = BRW1::PER:BEI_DAT
  PER:YYYYMM = BRW1::PER:YYYYMM
  PER:SUMMA = BRW1::PER:SUMMA
  PER:INI = BRW1::PER:INI
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
  UINI=GETKADRI(PER:ID,0,1)
  BRW1::PER:ID = PER:ID
  BRW1::PER:PAZIME = PER:PAZIME
  BRW1::UINI = UINI
  BRW1::PER:SAK_DAT = PER:SAK_DAT
  BRW1::PER:BEI_DAT = PER:BEI_DAT
  BRW1::PER:YYYYMM = PER:YYYYMM
  BRW1::PER:SUMMA = PER:SUMMA
  BRW1::PER:INI = PER:INI
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
    POST(Event:NewSelection,?Browse:1)
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
      IF LocalRequest = SelectRecord
        BRW1::PopupText = 'Iz&vçlçties'
      ELSE
        BRW1::PopupText = '~Iz&vçlçties'
      END
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      BRW1::PopupText = '~Iz&vçlçties'
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
      POST(Event:Accepted,?Select:2)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(PER:INI)
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 3
        LOOP BRW1::CurrentScroll = 100 TO 1 BY -1
          IF BRW1::Sort3:KeyDistribution[BRW1::CurrentScroll] => PER:SAK_DAT
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
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
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      PER:INI = BRW1::Sort2:LocatorValue
    END
  CASE BRW1::SortOrder
  OF 1
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
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
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
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
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
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
      IF LocalRequest = SelectRecord
        POST(Event:Accepted,?Select:2)
        EXIT
      END
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?PER:SAK_DAT)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            PER:INI = BRW1::Sort2:LocatorValue
            CLEAR(PER:PAZIME)
            CLEAR(PER:YYYYMM,1)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          PER:INI = BRW1::Sort2:LocatorValue
          CLEAR(PER:PAZIME)
          CLEAR(PER:YYYYMM,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          PER:INI = BRW1::Sort2:LocatorValue
          CLEAR(PER:PAZIME)
          CLEAR(PER:YYYYMM,1)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      OF 3
        IF CHR(KEYCHAR())
          SELECT(?PER:SAK_DAT)
          PRESS(CHR(KEYCHAR()))
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
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
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 2
      PER:INI = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 3
      PER:SAK_DAT = BRW1::Sort3:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
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
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
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
        StandardWarning(Warn:RecordFetchError,'PERNOS')
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
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
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
      BRW1::HighlightedPosition = POSITION(PER:DAT_KEY)
      RESET(PER:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      PER:PAZIME = S
      SET(PER:DAT_KEY,PER:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(PER:PAZIME) = UPPER(S) AND ( )'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PER:INI_KEY)
      RESET(PER:INI_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(PER:INI_KEY,PER:INI_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = ''
  OF 3
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PER:DAT_KEY)
      RESET(PER:DAT_KEY,BRW1::HighlightedPosition)
    ELSE
      PER:PAZIME = A
      SET(PER:DAT_KEY,PER:DAT_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(PER:PAZIME) = UPPER(A)'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
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
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
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
    CASE BRW1::SortOrder
    OF 1; ?PER:SAK_DAT{Prop:Disable} = 0
    OF 2; ?PER:INI {Prop:Disable} = 0
    OF 3; ?PER:SAK_DAT{Prop:Disable} = 0
    END
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(PER:Record)
    CASE BRW1::SortOrder
    OF 1; ?PER:SAK_DAT{Prop:Disable} = 1
    OF 2; ?PER:INI {Prop:Disable} = 1
    OF 3; ?PER:SAK_DAT{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
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
    PER:PAZIME = S
    SET(PER:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(PER:PAZIME) = UPPER(S) AND ( )'
  OF 2
    SET(PER:INI_KEY)
    BRW1::View:Browse{Prop:Filter} = ''
  OF 3
    PER:PAZIME = A
    SET(PER:DAT_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'UPPER(PER:PAZIME) = UPPER(A)'
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
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW1::SortOrder
  OF 1
    S = BRW1::Sort1:Reset:S
  OF 3
    A = BRW1::Sort3:Reset:A
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.SelectButton=?Select:2
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
    IF BrowseButtons.SelectButton THEN
      TBarBrwSelect{PROP:DISABLE}=BrowseButtons.SelectButton{PROP:DISABLE}
    END
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
  GET(PERNOS,0)
  CLEAR(PER:Record,0)
  CASE BRW1::SortOrder
  OF 1
    PER:PAZIME = BRW1::Sort1:Reset:S
  OF 3
    PER:PAZIME = BRW1::Sort3:Reset:A
  END
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
  SELECT(?Browse:1)
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
  SELECT(?Browse:1)
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
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
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
!| (UpdatePERNOS) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePERNOS
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
        GET(PERNOS,0)
        CLEAR(PER:Record,0)
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
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


A_MAKSPROT           PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
P1                   DECIMAL(9,2)
P2                   DECIMAL(9,2)
P4                   DECIMAL(9,2)
P5                   DECIMAL(9,2)
P6                   DECIMAL(9,2)
P7                   DECIMAL(9,2)
P10                  DECIMAL(9,2)
P11                  DECIMAL(9,2)
SLILAP               DECIMAL(9,2)
SLILAPN              DECIMAL(9,2)
ALKO                 DECIMAL(9,2)
ALPA                 DECIMAL(9,2)
ALSA                 DECIMAL(9,2)
ALGA_A               DECIMAL(9,2)
ALGA_S               DECIMAL(9,2)
DAVANAS              DECIMAL(9,2)
PIKO                 DECIMAL(9,2)
NEAPLIEKAMIE         DECIMAL(9,2)
P16                  DECIMAL(9,2)
P16N                 DECIMAL(9,2)
PNO                  DECIMAL(9,2)
P17                  DECIMAL(9,2)
P18                  DECIMAL(9,2)
P19                  DECIMAL(9,2)
P20                  DECIMAL(9,2)
p20KARTE             DECIMAL(9,2)
P21                  DECIMAL(9,2)
P22                  DECIMAL(9,2)
P23                  DECIMAL(9,2)
P26                  DECIMAL(9,2)
P24                  DECIMAL(9,2)
P25                  DECIMAL(9,2)
PNOPP                DECIMAL(9,2)
PNOP                 DECIMAL(9,2)
IEKO                 DECIMAL(9,2)
KAKO                 DECIMAL(9,2)
PAKO                 DECIMAL(9,2)

M0                   DECIMAL(9,2)
M1                   DECIMAL(9,2)
M2                   DECIMAL(9,2)
M3                   DECIMAL(9,2)
M4                   DECIMAL(9,2)
OBJEKTS              DECIMAL(9,2)
OBJSUM               DECIMAL(9,2)
!KOPASOCA             DECIMAL(9,2)
KOPASOC              DECIMAL(9,2)
!KOPA37A              DECIMAL(9,2)
KOPA37               DECIMAL(9,2)
!KOPA1A               DECIMAL(9,2)
KOPA1                DECIMAL(9,2)
!IZMSOCA              DECIMAL(9,2)
IZMSOC               DECIMAL(9,2)
!SOCPABA              DECIMAL(9,2)
SOCPAB               DECIMAL(9,2)
!KOPABUA              DECIMAL(9,2)
KOPABU               DECIMAL(9,2)
KC                   DECIMAL(3)

S_TABLE              QUEUE,PRE(S)
PR                     DECIMAL(4,2)
PR_G                   BYTE
SUMMA                  DECIMAL(8,2)
OBJEKTS                DECIMAL(8,2)
CILV                   DECIMAL(3)
                     .

IZMAKSAT             DECIMAL(9,2)
TPB_NO               STRING(6)
TPB_LIDZ             STRING(6)
FILTRS_TEXT          STRING(60)
DAT                  LONG
LAI                  LONG
VECUMS               STRING(2)
SAV_YYYYMM           LONG

!___________________________________________________________________________
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
Process:View         VIEW(ALGAS)
                       PROJECT(YYYYMM)
                       PROJECT(ID)
                       PROJECT(INI)
                       PROJECT(NODALA)
                       PROJECT(OBJ_NR)
                       PROJECT(STATUSS)
                       PROJECT(INV_P)
                       PROJECT(APGAD_SK)
                       PROJECT(PR37)
                       PROJECT(PR1)
                       PROJECT(IZMAKSAT)
                       PROJECT(N_Stundas)
                       PROJECT(SOC_V)
                       PROJECT(LMIA)
                       PROJECT(LBER)
                       PROJECT(LINV)
                       PROJECT(K)
                       PROJECT(L)
                       PROJECT(S)
                       PROJECT(D)
                       PROJECT(A)
                       PROJECT(R)
                       PROJECT(I)
                       PROJECT(J)
                       PROJECT(C)
                       PROJECT(N)
                       PROJECT(TERKOD)
                     END

!___________________________________________________________________________
report REPORT,AT(104,304,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,200,8000,104)
       END
RPT_HEAD1 DETAIL,AT(,,7969,7906),USE(?unnamed:2)
         STRING('Atvalinâjuma naudas'),AT(1042,2031,3490,156),USE(?String11:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1250,781,156),USE(p2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Atvalinâjumi nâkamajos mçneðos'),AT(1042,2188,3490,156),USE(?String11:8),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1563,781,156),USE(P5),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1406,781,156),USE(P4),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Slimîbas naudas'),AT(1042,2344,3490,156),USE(?String11:9),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1875,781,156),USE(P7),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1719,781,156),USE(P6),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,2656,2865,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7396,1042,0,6875),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Aprçíinâtâ alga KOPÂ'),AT(1052,2698,3490,156),USE(?String11:10),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,2698,938,156),USE(ALKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t. s. ar nodokïu grâmatiòu'),AT(1302,2865,1875,156),USE(?String11:11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2865,781,156),USE(alpa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. ar nodokïu karti'),AT(1302,3021,1875,156),USE(?String11:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3021,781,156),USE(alsa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. administrâcijai'),AT(1302,3177,1875,156),USE(?String11:13),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3177,781,156),USE(alga_a),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. strâdniekiem'),AT(1302,3333,1875,156),USE(?String11:14),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3333,781,156),USE(alga_s),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Dâvanas u.c. neapliekamie'),AT(1042,3490,2240,156),USE(?String11:15),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,4010,6563,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Darba òçmçja sociâlais nodoklis kopâ / nâk.mçneðos'),AT(1042,4063,3802,156),USE(?String11:17), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4063,781,156),USE(p16),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(6698,4063,677,156),USE(p16n),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodokïi ðaja mçnesî'),AT(1042,4219,2240,156),USE(?String11:18),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,3646,2865,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5885,3490,781,156),USE(davanas),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,3688,938,156),USE(piKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4219,781,156),USE(pno),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. pamatlikme'),AT(1302,4375,1875,156),USE(?String11:19),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4375,781,156),USE(p17),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. papildlikme'),AT(1302,4531,1875,156),USE(?String11:20),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4531,781,156),USE(p18),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Izpildraksts (alimenti)'),AT(1042,4688,2240,156),USE(?String11:21),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4688,781,156),USE(p19),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citi ieturçjumi'),AT(1042,4844,2240,156),USE(?String11:22),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4844,781,156),USE(p20),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Avanss'),AT(1042,5000,2240,156),USE(?String11:23),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,6406,2865,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Pârskaitîjums uz karti'),AT(1042,6458,1458,156),USE(?String11:58),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6438,781,156),USE(p20KARTE),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5000,781,156),USE(p21),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(6771,6604,281,156),USE(val_uzsk,,?val_uzsk:2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6604,938,156),USE(ieKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieturçjumi KOPÂ'),AT(1042,6604,3490,156),USE(?String11:32),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârkârtas izmaksas'),AT(1042,5156,2240,156),USE(?String11:24),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,6771,6563,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('IZMAKSAI'),AT(1042,6813,1042,156),USE(?String11:33),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6813,938,156),USE(KAKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('PARÂDI, pârcelti uz nâkoðo mçnesi'),AT(1042,6969,2500,156),USE(?String11:34),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6969,938,156),USE(pAKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5156,781,156),USE(p22),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pârâdi no iepriekðçjâ mçneða'),AT(1042,5313,2240,156),USE(?String11:25),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5313,781,156),USE(p23),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodokïa sadalîjums  :'),AT(1042,5938,2240,156),USE(?String11:29),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par pagâjuðajiem mçneðiem '),AT(1042,5469,3073,156),USE(?String11:26), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5469,781,156),USE(p26),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par nâkoðo mçnesi'),AT(1042,5625,3073,156),USE(?String11:27),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. paðvaldîbu budþetâ'),AT(1302,6094,1875,156),USE(?String11:30),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. sadales kontâ'),AT(1302,6250,1875,156),USE(?String11:31),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6250,781,156),USE(pnop),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5625,781,156),USE(p24),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par aiznâkoðo mçnesi'),AT(1042,5781,3073,156),USE(?String11:28),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5781,781,156),USE(p25),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6094,781,156),USE(pnopp),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieskaitîjumi KOPÂ'),AT(1042,3688,3490,156),USE(?String11:16),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2344,781,156),USE(SLILAP),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Slimîbas naudas nâkamajos mçneðos'),AT(1042,2490,3490,156),USE(?String11:57),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2500,781,156),USE(SLILAPN),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2188,781,156),USE(P11),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(6771,3698,281,156),USE(val_uzsk),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s. neapliekamie'),AT(1042,3854,3490,156),USE(?String11:56),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,3854,938,156),USE(neapliekamie),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2031,781,156),USE(P10),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('VSAOI'),AT(3333,7125,938,208),USE(?String6:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,7198,2500,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(4271,7198,3125,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING(@s3),AT(6771,6813,281,156),USE(val_uzsk,,?val_uzsk:3),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâjumi par valsts sociâlo apdroð.'),AT(1042,7438,2240,156),USE(?String11:37),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. darba devçja maksâjumi'),AT(1250,7698,2448,156),USE(?String11:38),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,7708,781,156),USE(kopa37),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(6771,6969,281,156),USE(val_uzsk,,?val_uzsk:4),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,7438,781,156),USE(kopasoc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s3),AT(6771,7438,281,156),USE(val_uzsk,,?val_uzsk:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(1969,52,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâjumu protokols'),AT(2813,365,1667,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d014.),AT(4531,365),USE(S_dat),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5156,365,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d014.),AT(5313,365),USE(B_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S60),AT(2281,677,4115,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,1042,2500,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(4115,1042,3281,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Laika darba alga'),AT(1042,1094,1094,156),USE(?String11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1094,781,156),USE(p1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Gabaldarba alga'),AT(1042,1250,1094,156),USE(?String11:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Prçmijas '),AT(1042,1406,1406,156),USE(?String11:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Piemaksas par brîvdienâm, naktsstundâm, virstundam'),AT(1042,1563,3490,156),USE(?String11:4), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citas piemaksas un pabalsti (1)'),AT(1042,1719,3490,156),USE(?String11:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citas piemaksas un pabalsti (2)'),AT(1042,1875,3490,156),USE(?String11:6),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,1042,0,6875),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Alga'),AT(3385,990,677,208),USE(?String6:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
rpt_head2 DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(833,0,0,156),USE(?Line12:6),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,156),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5885,0,781,156),USE(kopa1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3),AT(6823,0,260,156),USE(kc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('c.'),AT(7135,0,156,156),USE(?String11:40),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. darba òçmçja maksâjumi'),AT(1250,0,1823,156),USE(?String11:39),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
rpt_head3 DETAIL,USE(?unnamed:3)
         LINE,AT(833,0,0,781),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,781),USE(?Line12:2),COLOR(COLOR:Black)
         STRING(@s3),AT(6771,573,281,156),USE(val_uzsk,,?val_uzsk:7),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4531,156,2865,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5885,208,781,156),USE(izmsoc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. pabalsti no soc. lîdz.'),AT(1260,313,1875,156),USE(?String11:42),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,365,781,156),USE(socpab),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Budþetâ ieskaitâmâ soc. nodokïa summa'),AT(1042,552,2500,156),USE(?String11:43),LEFT, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4531,521,2865,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5885,573,781,156),USE(kopabu),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6771,208,281,156),USE(val_uzsk,,?val_uzsk:6),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,781,6563,0),USE(?Line16),COLOR(COLOR:Black)
         STRING(@T1),AT(7083,792,313,146),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6458,792),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING('Izmaksas no sociâliem lîdzekïiem'),AT(1042,156,2240,156),USE(?String11:41),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
SOCPRG DETAIL,AT(,,,177)
         LINE,AT(833,-10,0,197),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,197),USE(?Line12:4),COLOR(COLOR:Black)
         STRING('c.'),AT(6156,10,156,156),USE(?String11:48),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3),AT(5844,10,260,156),USE(s:cilv),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(3781,10,781,156),USE(s:OBJEKTS),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('='),AT(4615,10,208,156),USE(?String11:47),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(4927,10,781,156),USE(s:summa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N5.2),AT(2740,10,417,156),USE(S:PR),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('%'),AT(3208,10,208,156),USE(?String11:45),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no'),AT(3469,10,260,156),USE(?String11:46),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s.'),AT(2479,10,260,156),USE(?String11:44),LEFT,FONT(,9,,,CHARSET:BALTIC)
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

OMIT('MARIS')
!___________________________________________________________________________
report REPORT,AT(104,304,8000,9802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,200,8000,104)
       END
RPT_HEAD1 DETAIL,AT(,,7969,7906),USE(?unnamed:2)
         STRING('Atvalinâjuma naudas'),AT(1042,2031,3490,156),USE(?String11:7),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1250,781,156),USE(p2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Atvalinâjumi nâkamajos mçneðos'),AT(1042,2188,3490,156),USE(?String11:8),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1563,781,156),USE(P5),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1406,781,156),USE(P4),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Slimîbas naudas'),AT(1042,2344,3490,156),USE(?String11:9),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1875,781,156),USE(P7),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1719,781,156),USE(P6),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,2656,2865,0),USE(?Line1:4),COLOR(COLOR:Black)
         LINE,AT(7396,1042,0,6875),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Aprçíinâtâ alga KOPÂ'),AT(1052,2698,3490,156),USE(?String11:10),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,2698,938,156),USE(ALKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t. s. ar nodokïu grâmatiòu'),AT(1302,2865,1875,156),USE(?String11:11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2865,781,156),USE(alpa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. ar nodokïu karti'),AT(1302,3021,1875,156),USE(?String11:12),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3021,781,156),USE(alsa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. administrâcijai'),AT(1302,3177,1875,156),USE(?String11:13),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3177,781,156),USE(alga_a),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. strâdniekiem'),AT(1302,3333,1875,156),USE(?String11:14),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,3333,781,156),USE(alga_s),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Dâvanas u.c. neapliekamie'),AT(1042,3490,2240,156),USE(?String11:15),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,4010,6563,0),USE(?Line1:7),COLOR(COLOR:Black)
         STRING('Darba òçmçja sociâlais nodoklis kopâ / nâk.mçneðos'),AT(1042,4063,3802,156),USE(?String11:17), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4063,781,156),USE(p16),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(6698,4063,677,156),USE(p16n),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodokïi ðaja mçnesî'),AT(1042,4219,2240,156),USE(?String11:18),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,3646,2865,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(5885,3490,781,156),USE(davanas),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,3688,938,156),USE(piKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4219,781,156),USE(pno),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. pamatlikme'),AT(1302,4375,1875,156),USE(?String11:19),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4375,781,156),USE(p17),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. papildlikme'),AT(1302,4531,1875,156),USE(?String11:20),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4531,781,156),USE(p18),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Izpildraksts (alimenti)'),AT(1042,4688,2240,156),USE(?String11:21),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4688,781,156),USE(p19),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citi ieturçjumi'),AT(1042,4844,2240,156),USE(?String11:22),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,4844,781,156),USE(p20),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Avanss'),AT(1042,5000,2240,156),USE(?String11:23),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(4531,6406,2865,0),USE(?Line1:8),COLOR(COLOR:Black)
         STRING('Pârskaitîjums uz karti'),AT(1042,6458,1458,156),USE(?String11:58),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6438,781,156),USE(p20KARTE),TRN,RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5000,781,156),USE(p21),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ls'),AT(6771,6604,208,156),USE(?String11:50),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6604,938,156),USE(ieKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ieturçjumi KOPÂ'),AT(1042,6604,3490,156),USE(?String11:32),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ârkârtas izmaksas'),AT(1042,5156,2240,156),USE(?String11:24),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,6771,6563,0),USE(?Line1:9),COLOR(COLOR:Black)
         STRING('IZMAKSAI'),AT(1042,6813,1042,156),USE(?String11:33),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6813,938,156),USE(KAKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('PARÂDI, pârcelti uz nâkoðo mçnesi'),AT(1042,6969,2500,156),USE(?String11:34),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,6969,938,156),USE(pAKO),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5156,781,156),USE(p22),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pârâdi no iepriekðçjâ mçneða'),AT(1042,5313,2240,156),USE(?String11:25),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5313,781,156),USE(p23),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodokïa sadalîjums  :'),AT(1042,5938,2240,156),USE(?String11:29),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par pagâjuðajiem mçneðiem '),AT(1042,5469,3073,156),USE(?String11:26), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5469,781,156),USE(p26),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par nâkoðo mçnesi'),AT(1042,5625,3073,156),USE(?String11:27),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. paðvaldîbu budþetâ'),AT(1302,6094,1875,156),USE(?String11:30),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. sadales kontâ'),AT(1302,6250,1875,156),USE(?String11:31),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6250,781,156),USE(pnop),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5625,781,156),USE(p24),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ienâkuma nodoklis par aiznâkoðo mçnesi'),AT(1042,5781,3073,156),USE(?String11:28),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,5781,781,156),USE(p25),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,6094,781,156),USE(pnopp),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pieskaitîjumi KOPÂ'),AT(1042,3688,3490,156),USE(?String11:16),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2344,781,156),USE(SLILAP),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Slimîbas naudas nâkamajos mçneðos'),AT(1042,2490,3490,156),USE(?String11:57),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2500,781,156),USE(SLILAPN),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2188,781,156),USE(P11),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ls'),AT(6771,3698,208,156),USE(?String11:49),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s. neapliekamie'),AT(1042,3854,3490,156),USE(?String11:56),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5729,3854,938,156),USE(neapliekamie),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,2031,781,156),USE(P10),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Soc. apdroð.'),AT(3333,7125,938,208),USE(?String6:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,7198,2500,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(4271,7198,3125,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Pçc aprçíina'),AT(4750,7229,990,156),USE(?String11:35),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('Pçc izmaksas fakta'),AT(5729,7229,1354,156),USE(?String11:36),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING(' (nopelnîts+slilspas par Ð,PM+atv.par ÐM)'),AT(4063,7385),USE(?String119)
         STRING(' (pieskaitîjumi ÐM)'),AT(6146,7385),USE(?String119:2)
         STRING('Ls'),AT(6771,6813,208,156),USE(?String11:51),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâjumi par valsts sociâlo apdroð.'),AT(1042,7552,2240,156),USE(?String11:37),LEFT, |
             FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. darba devçja maksâjumi'),AT(1250,7698,2448,156),USE(?String11:38),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5052,7708,677,156),USE(kopa37a),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,7708,781,156),USE(kopa37),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ls'),AT(6771,6969,208,156),USE(?String11:52),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(4938,7552,781,156),USE(kopasoca),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,7552,781,156),USE(kopasoc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Ls'),AT(6771,7552,208,156),USE(?String11:53),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@s45),AT(1969,52,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâjumu protokols'),AT(2813,365,1667,260),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d014.),AT(4531,365),USE(S_dat),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('-'),AT(5156,365,156,260),USE(?String2:2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@d014.),AT(5313,365),USE(B_dat),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S60),AT(2281,677,4115,208),USE(FILTRS_TEXT),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(833,1042,2500,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(4115,1042,3281,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Laika darba alga'),AT(1042,1094,1094,156),USE(?String11),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,1094,781,156),USE(p1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Gabaldarba alga'),AT(1042,1250,1094,156),USE(?String11:2),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Prçmijas '),AT(1042,1406,1406,156),USE(?String11:3),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Piemaksas par brîvdienâm, naktsstundâm, virstundam'),AT(1042,1563,3490,156),USE(?String11:4), |
             LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citas piemaksas un pabalsti (1)'),AT(1042,1719,3490,156),USE(?String11:5),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Citas piemaksas un pabalsti (2)'),AT(1042,1875,3490,156),USE(?String11:6),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,1042,0,6875),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Alga'),AT(3385,990,677,208),USE(?String6:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
rpt_head2 DETAIL,AT(,,,177),USE(?unnamed)
         LINE,AT(833,0,0,156),USE(?Line12:6),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,156),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(4938,0,781,156),USE(kopa1a,,?kopa1a:2),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,0,781,156),USE(kopa1),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3),AT(6823,0,260,156),USE(kc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('c.'),AT(7135,0,156,156),USE(?String11:40),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. darba òçmçja maksâjumi'),AT(1250,0,1823,156),USE(?String11:39),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
rpt_head3 DETAIL,USE(?unnamed:3)
         LINE,AT(833,0,0,781),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(7396,0,0,781),USE(?Line12:2),COLOR(COLOR:Black)
         STRING('Ls'),AT(6771,573,208,156),USE(?String11:55),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4531,156,2865,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(4938,208,781,156),USE(izmsoca),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,208,781,156),USE(izmsoc),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s. pabalsti no soc. lîdz.'),AT(1260,313,1875,156),USE(?String11:42),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(4948,365,781,156),USE(socpaba),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,365,781,156),USE(socpab),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('Budþetâ ieskaitâmâ soc. nodokïa summa'),AT(1042,552,2500,156),USE(?String11:43),LEFT, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4531,521,2865,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING(@N-_11.2),AT(4906,573,781,156),USE(kopabua),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(5885,573,781,156),USE(kopabu),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Ls'),AT(6771,208,208,156),USE(?String11:54),LEFT,FONT(,9,,,CHARSET:BALTIC)
         LINE,AT(833,781,6563,0),USE(?Line16),COLOR(COLOR:Black)
         STRING(@T1),AT(7083,792,313,146),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6458,792),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING('Izmaksas no sociâliem lîdzekïiem'),AT(1042,156,2240,156),USE(?String11:41),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
SOCPRG DETAIL,AT(,,,177)
         LINE,AT(833,-10,0,197),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(7396,-10,0,197),USE(?Line12:4),COLOR(COLOR:Black)
         STRING('c.'),AT(6156,10,156,156),USE(?String11:48),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N3),AT(5844,10,260,156),USE(s:cilv),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(3781,10,781,156),USE(s:summaa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('='),AT(4615,10,208,156),USE(?String11:47),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N-_11.2),AT(4927,10,781,156),USE(s:summa),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING(@N5.2),AT(2740,10,417,156),USE(S:PR),RIGHT,FONT(,9,,,CHARSET:BALTIC)
         STRING('%'),AT(3208,10,208,156),USE(?String11:45),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('no'),AT(3469,10,260,156),USE(?String11:46),LEFT,FONT(,9,,,CHARSET:BALTIC)
         STRING('t. s.'),AT(2479,10,260,156),USE(?String11:44),LEFT,FONT(,9,,,CHARSET:BALTIC)
       END
     END
MARIS
  CODE                                            ! Begin processed code
  PUSHBIND
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF DAIEV::USED=0              !dçï sum (getdaiev)
     CHECKOPEN(DAIEV,1)
  .
  DAIEV::USED+=1
  IF KADRI::Used = 0            !DÇÏ GETKADRI
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGPA::USED=0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::USED+=1
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)

  TPB_NO  =SYS:NOKL_TE[1:6]
  TPB_LIDZ=SYS:NOKL_TE[7:12]
  DAT=TODAY()
  LAI=CLOCK()

  IF ID THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&GETKADRI(ID,0,1).
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  IF DAV_GRUPA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc DAIEV grupas: '&DAV_GRUPA.
!  IF F:OBJ_NR THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Projekts Nr: '&F:OBJ_NR&' '&GetProjekti(F:OBJ_NR,1).
!  VIRSRAKSTS=KKK&' : '&CLIP(GETKON_K(KKK,2,2))&' '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)

  FilesOpened = True
  RecordsToProcess = RECORDS(algas)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Maksâjumu protokols'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=S_DAT
      SET(ALG:ID_KEY,ALG:ID_KEY)
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
      ELSE           !RTF,EXCEL
        IF ~OPENANSI('MAKSPROT.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE='MAKSÂJUMU PROTOKOLS '&FORMAT(S_DAT,@D014.)&'-'&FORMAT(B_DAT,@D014.)
        ADD(OUTFILEANSI)
        OUTA:LINE=FILTRS_TEXT
        ADD(OUTFILEANSI)
         OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{10}ALGA-{10}'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NNR#+=1
        ?Progress:UserString{Prop:Text}=NNR#
        DISPLAY(?Progress:UserString)
        IF (ALG:NODALA=F:NODALA OR F:NODALA='') AND (ALG:ID=ID OR ID=0)
   !*************** PIESKAITÎJUMI
           p1     += SUM(12)         !LAIKA DARBS
           p2     += SUM(13)         !GABALDARBS
           p4     += SUM(14)         !PRÇMIJAS
           p5     += SUM(15)         !PIEMAKSA PAR BRÎVDIENÂM UN NAKTSSTUNDÂM
           p6     += SUM(16)         !CITAS (T=5)
           p7     += SUM(29)         !CITAS (T=6)
           davanas+= SUM(57)         !dâvanas u.c. neapliekamie
           slilap += sum(58)         !SLILAPAS ÐAJÂ MÇNESÎ
           slilapN+= sum(59)         !SLILAPAS NÂK. MÇNEÐOS
           p10    += SUM(30)         !ATVAÏINÂJUMS ÐAJÂ MÇNESÎ
           p11    += SUM(21)         !ATVAÏINÂJUMI NÂK. MÇNEÐOS
           alko   += SUM(19)+SUM(21)+sum(59)
           alpa   += SUM(17)+SUM(46)+sum(63)
           alsa   += SUM(18)+SUM(47)+sum(64)
           ALGA_A += SUM(31)+SUM(48)+sum(65)
           ALGA_S += SUM(32)+SUM(49)+sum(66)
           piko   += SUM(33)         !PIESKAITÎJUMI KOPÂ
           neapliekamie+=SUM(53)     !NEAPLIEKAMIE IEÒÇMUMI KOPÂ
   !*************** IETURÇJUMI
           p16    += SUM(6)
           p16N   += SUM(61)
           pno    += SUM(22)+sum(23)
           p17    += SUM(22)
           p18    += SUM(23)
           p19    += SUM(7)
           p20    += SUM(8)+SUM(55)
           p20KARTE += SUM(56)     !21.03.07.
           p21    += SUM(9)
           p22    += SUM(24)         !ÂRKÂRTAS IZMAKSAS; LIEKAS ,KA NEKUR NEPARÂDÂS 905(PÂRMAKSA/PARÂDS)
           p23    += SUM(25)
           p24    += SUM(26)
           p25    += SUM(27)
           p26    += SUM(42)
           ieko   += SUM(28)        !IETURÇJUMI KOPÂ
           izmaksat    = SUM(11)
           IF IZMAKSAT > 0
             kako += izmaksat
           ELSE
             PAKO += ABS(izmaksat)
           .
!!!!           I#=GETKADRI(ALG:ID,2,1)
           IF INRANGE(ALG:TERKOD,TPB_NO,TPB_LIDZ) !JÂPÂRSKAITA PAÐVALDÎBU BUDÞETÂ
             PNOPP += SUM(5)         !NODOKÏI ÐAJÂ NÂKAMAJOS UN PAGÂJUÐAJOS MÇNEÐOS
           ELSE
             pnoP += SUM(5)
           .
!           M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
!!JÂMAINA           M3=SUM(3)    ! SLIMÎBAS LAPAS, IZMAKSÂTAS ÐAJÂ MÇNESÎ
!           M3=SUM(58)   ! SLIMÎBAS LAPAS PAR ÐO,PAG.MÇN., IZMAKSÂTAS ÐAJÂ MÇNESÎ
!          M3P=SUM(62)  ! SLIMÎBAS LAPAS PAR ÐO MÇN., IZMAKSÂTAS PAG. MÇNESÎ
!           M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ
!           M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ
!           M4=SUM(40)   ! PIESKAITÎJUMI, NO KURIEM RÇÍINA SOCIÂLO

           M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
           M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
           M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
           M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
           M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
           OBJEKTS=M0+M1+M2+M3+M4
           IF SYS:PZ_NR                            !IR DEFINÇTS OBJEKTS (2007.g. Ls23800)
              DO SUMSOCOBJ                         !SASKAITAM OBLIGÂTO IEMAKSU OBJEKTU NO GADA SÂKUMA
              IF SYS:PZ_NR-(OBJSUM+OBJEKTS)<0      !MKN 193
                 KLUDA(0,'Ir sasniegts obligâto iemaksu objekta MAX apmçrs '&CLIP(GETKADRI(ALG:ID,0,1)),,1)
                 OBJEKTS=SYS:PZ_NR-OBJSUM
                 IF OBJEKTS<0 THEN OBJEKTS=0.
              .
              VECUMS=GETKADRI(ALG:ID,0,15)
              IF VECUMS<15
                 OBJEKTS=0  !TÂ ARÎ VAJAG-DATI
              .
           .
!           nodoklis   =  ROUND(objekts*alg:pr37/100,.01)+ROUND(objekts*alg:pr1/100,.01)
           kopa37 += round(OBJEKTS*ALG:PR37/100,.01)
           kopa1  += round(OBJEKTS*ALG:PR1/100,.01)

!           kopa37 += round(M4*ALG:PR37/100,.01)
!!           kopa37A+= round(OBJEKTS*ALG:PR37/100,.01)
!           kopa1  += sum(6) !903+910+911
!!           kopa1A += round(OBJEKTS*ALG:PR1/100,.01)
           kc     += 1
           socpab += sum(2)
!           socpabA+= sum(2)
           GET(S_TABLE,0)
           S:PR=ALG:PR37  !+-37%
           GET(S_TABLE,S:PR)
           IF ERROR()
             S:PR    =ALG:PR37
             S:PR_G  =37
             S:SUMMA =round(OBJEKTS*ALG:PR37/100,.01)
             S:OBJEKTS=OBJEKTS
             S:CILV  =1
             ADD(S_TABLE,S:PR)
             SORT(S_TABLE,S:PR)
           ELSE
             S:SUMMA +=round(OBJEKTS*ALG:PR37/100,.01)
             S:OBJEKTS+=OBJEKTS
             S:CILV  +=1
             PUT(S_TABLE)
           .
           GET(S_TABLE,0)
           S:PR=ALG:PR1   !+-1%
           GET(S_TABLE,S:PR)
           IF ERROR()
             S:PR    =ALG:PR1
             S:PR_G  =1
             S:SUMMA =round(OBJEKTS*ALG:PR1/100,.01)
             S:OBJEKTS=OBJEKTS
             S:CILV  =1
             ADD(S_TABLE,S:PR)
             SORT(S_TABLE,S:PR)
           ELSE
             S:SUMMA +=round(OBJEKTS*ALG:PR1/100,.01)
             S:OBJEKTS+=OBJEKTS
             S:CILV  +=1
             PUT(S_TABLE)
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
        ?Progress:UserString{Prop:Text}='Uzgaidiet...'
        DISPLAY(?Progress:UserString)
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
!   RPT:izmsoc  = RPT:socpab+rpt:slilap
    izmsoc  =  socpab
!    izmsocA =  socpab
    kopasoc =  KOPA37+ KOPA1
!    kopasocA=  KOPA37A+ KOPA1A
    kopabu  =  kopasoc -  izmsoc
!    kopabuA =  kopasocA-  izmsocA
    IF F:DBF = 'W'
        PRINT(RPT:RPT_HEAD1)
    ELSE
        OUTA:LINE='Laika darba alga'&CHR(9)&LEFT(FORMAT(P1,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Gabaldarba alga'&CHR(9)&LEFT(FORMAT(P2,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Prçmijas (pastâvîgâs)'&CHR(9)&LEFT(FORMAT(P4,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Piemaksas par brîvdienâm un naktsstundâm'&CHR(9)&LEFT(FORMAT(P5,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Citas piemaksas un pabalsti no uzòçmuma lîdzekïiem'&CHR(9)&LEFT(FORMAT(P6,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ârkârtas prçmijas'&CHR(9)&LEFT(FORMAT(P7,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Atvaïinâjuma naudas'&CHR(9)&LEFT(FORMAT(P10,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Atvaïinâjumi nâkamajos mçneðos'&CHR(9)&LEFT(FORMAT(P11,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Slimîbas naudas'&CHR(9)&LEFT(FORMAT(SLILAP,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Aprçíinâtâ alga KOPÂ'&CHR(9)&LEFT(FORMAT(ALKO,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. ar nodokïu grâmatiòu'&CHR(9)&LEFT(FORMAT(ALPA,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. ar nodokïu karti'&CHR(9)&LEFT(FORMAT(ALSA,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. administrâcijai'&CHR(9)&LEFT(FORMAT(ALGA_A,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. strâdniekiem'&CHR(9)&LEFT(FORMAT(ALGA_S,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Dâvanas u.c. neapliekamie'&CHR(9)&LEFT(FORMAT(DAVANAS,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Pieskaitîjumi KOPÂ'&CHR(9)&LEFT(FORMAT(PIKO,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Darba òçmçja sociâlais nodoklis'&CHR(9)&LEFT(FORMAT(P16,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodokïi ðaja mçnesî'&CHR(9)&LEFT(FORMAT(PNO,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. pamatlikme'&CHR(9)&LEFT(FORMAT(P17,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. papildlikme'&CHR(9)&LEFT(FORMAT(P18,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpildraksts (alimenti)'&CHR(9)&LEFT(FORMAT(P19,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Citi ieturçjumi'&CHR(9)&LEFT(FORMAT(P20,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Avanss'&CHR(9)&LEFT(FORMAT(P21,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ârkârtas izmaksas'&CHR(9)&LEFT(FORMAT(P22,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Parâdi no iepriekðçjâ mçneða'&CHR(9)&LEFT(FORMAT(P23,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodoklis par pagâjuðajiem mçneðiem'&CHR(9)&LEFT(FORMAT(P26,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodoklis par nâkoðo mçnesi'&CHR(9)&LEFT(FORMAT(P24,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodoklis par aiznâkoðo mçnesi'&CHR(9)&LEFT(FORMAT(P25,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodoklis paðvaldîbu budþetâ'&CHR(9)&LEFT(FORMAT(PNOPP,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ienâkuma nodoklis sadales kontâ'&CHR(9)&LEFT(FORMAT(PNOP,@N-_10.2))
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE='Pârskaitîjums uz karti'&CHR(9)&LEFT(FORMAT(P20KARTE,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='Ieturçjumi KOPÂ'&CHR(9)&LEFT(FORMAT(IEKO,@N-_10.2))
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE='IZMAKSAI'&CHR(9)&LEFT(FORMAT(KAKO,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE='PARÂDI, pârcelti uz nâkoðo mçnesi'&CHR(9)&LEFT(FORMAT(PAKO,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{10}VSAOI-{10}'
        ADD(OUTFILEANSI)
        OUTA:LINE='Maksâjumi par valsts sociâlo apdroðinâðanu'&CHR(9)&LEFT(FORMAT(KOPASOC,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. darba devçja maksâjumi'&CHR(9)&LEFT(FORMAT(KOPA37,@N-_10.2))
        ADD(OUTFILEANSI)
    END
    GET(S_TABLE,0)
    LOOP I# = 1 TO RECORDS(S_TABLE)
      GET(S_TABLE,I#)
      IF ~(S:PR_G=37) THEN CYCLE.
      IF F:DBF = 'W'
        PRINT(RPT:SOCPRG)     !T.S. SOC 37%
      ELSE
        OUTA:LINE=' t.s. '&S:PR&'% no '&LEFT(FORMAT(S:OBJEKTS,@N-_10.2))&CHR(9)&LEFT(FORMAT(S:SUMMA,@N-_10.2))&S:CILV&'c.'
        ADD(OUTFILEANSI)
      END
    .
    IF F:DBF = 'W'
        PRINT(RPT:RPT_HEAD2)  !1% KOPÂ
    ELSE
        OUTA:LINE=' t.s. darba òçmçja maksâjumi'&CHR(9)&LEFT(FORMAT(KOPA1,@N-_10.2))&' '&KC&'c.'
        ADD(OUTFILEANSI)
    .
    GET(S_TABLE,0)
    LOOP I# = 1 TO RECORDS(S_TABLE)
      GET(S_TABLE,I#)
      IF ~(S:PR_G=1) THEN CYCLE.
      IF F:DBF = 'W'
        PRINT(RPT:SOCPRG)     !T.S. 1%
      ELSE
        OUTA:LINE='   t.s. '&S:PR&'%'&CHR(9)&LEFT(FORMAT(S:SUMMA,@N-_10.2))&' '&S:CILV&'c.'
        ADD(OUTFILEANSI)
      END
    .
    IF F:DBF = 'W'
        PRINT(RPT:RPT_HEAD3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE='Izmaksas no sociâliem lîdzekïiem'&CHR(9)&LEFT(FORMAT(IZMSOC,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=' t.s. pabalsti no soc. lîdz.'&CHR(9)&LEFT(FORMAT(SOCPAB,@N-_10.2))
        ADD(OUTFILEANSI)
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
        OUTA:LINE='Budþetâ ieskaitâmâ soc. nodokïa summa'&CHR(9)&LEFT(FORMAT(KOPABU,@N-_10.2))
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    ALGPA::USED -= 1
    IF ALGPA::USED = 0 THEN CLOSE(ALGPA).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(S_TABLE)
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
  IF ERRORCODE() OR ALG:YYYYMM > B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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
SUMSOCOBJ  ROUTINE
! SAVE_RECORD=ALG:RECORD
! save_position=POsition(Process:View)
 SAV_YYYYMM=ALG:YYYYMM
 OBJSUM = 0
 ALG:YYYYMM=DATE(1,1,YEAR(ALG:YYYYMM)) ! NO GADA SÂKUMA
 SET(ALG:ID_DAT,ALG:ID_DAT)
 LOOP
    NEXT(ALGAS)
!    STOP(ALG:ID&'='&PER:ID&' '&FORMAT(ALG:YYYYMM,@D6)&' '&FORMAT(per:YYYYMM,@D6)&ERROR())
    IF ERROR() OR (ALG:YYYYMM = SAV_YYYYMM) THEN BREAK.
    M0=SUM(43)   ! NOPELNÎTS PAR ÐO MÇNESI
    M1=SUM(44)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS PAGÂJUÐAJÂ MÇNESÎ      NO DARBINIEKA IETURÇJÂM UZREIZ,
    M2=SUM(45)   ! ATVAÏINÂJ.PAR ÐO MÇNESI, IZMAKSÂTS AIZPAGÂJUÐAJÂ MÇNESÎ   VID DEKLARÇJAM PÇC FAKTA.......
    M3=SUM(58)   ! SLIMÎBAS LAPA PAR ÐO,PAG. MÇNESI
    M4=SUM(62)   ! SLIMÎBAS LAPA PAR PAR ÐO MÇNESI, IZMAKSÂTA PAGÂJUÐAJÂ MÇNESÎ
    OBJSUM+=M0+M1+M2+M3+M4
 .
 SET(ALG:ID_KEY,ALG:ID_KEY)
! RESET(Process:View,SAVE_POSITION)
 NEXT(ALGAS)
! ALG:RECORD=SAVE_RECORD

