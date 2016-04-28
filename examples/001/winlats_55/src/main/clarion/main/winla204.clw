                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateGrafiks PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
GRAF                 STRING(96),DIM(31)
GRAF_S               STRING(96)
GRAF_D               BYTE,DIM(31)
GRAF_L               BYTE,DIM(48)
L_SELECTED           LONG
D_SELECTED           LONG
VUT                  STRING(50)
STUNDAS              STRING(50)
Update::Reloop  BYTE
Update::Error   BYTE
History::GRA:Record LIKE(GRA:Record),STATIC
SAV::GRA:Record      LIKE(GRA:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
FormWindow           WINDOW('Darba laika grafiks'),AT(,,590,379),FONT('Arial',7,,,CHARSET:BALTIC),CENTER,SYSTEM,GRAY,RESIZE,MDI
                       PROMPT('YYYYMM'),AT(4,9),USE(?Prompt1),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       ENTRY(@D16),AT(47,7,44,13),USE(GRA:YYYYMM),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       BUTTON('Kadru ID'),AT(93,5,48,17),USE(?ButtonID),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       ENTRY(@n6),AT(142,7,38,13),USE(GRA:ID),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       BUTTON('Uzbûvçt no kalendâra'),AT(470,6,110,15),USE(?ButtonUzbK),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       STRING(@s50),AT(183,9,188,11),USE(VUT),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       BUTTON,AT(5,23,31,22),USE(?ButtonA ),FONT('Courier',,,,CHARSET:BALTIC),TIP('Notîrît atzîmes'),ICON(ICON:Cross)
                       BUTTON('0'),AT(39,26,10,19),USE(?L1),TIP('00:00-00:30')
                       BUTTON,AT(51,26,10,19),USE(?L2),TIP('00:30-01:00')
                       BUTTON('1'),AT(62,26,10,19),USE(?L3),TIP('01:00-01:30'),REQ
                       BUTTON,AT(74,26,10,19),USE(?L4),TIP('01:30-02:00')
                       BUTTON('2'),AT(85,26,10,19),USE(?L5),TIP('02:00-02:30'),REQ
                       BUTTON,AT(96,26,10,19),USE(?L6),TIP('02:30-03:00')
                       BUTTON('3'),AT(107,26,10,19),USE(?L7),TIP('03:00-03:30'),REQ
                       BUTTON,AT(118,26,10,19),USE(?L8),TIP('03:30-04:00')
                       BUTTON('4'),AT(129,26,10,19),USE(?L9),TIP('04:00-04:30'),REQ
                       BUTTON,AT(140,26,10,19),USE(?L10),TIP('04:30-05:00')
                       BUTTON('5'),AT(151,26,10,19),USE(?L11),TIP('05:00-05:30'),REQ
                       BUTTON,AT(163,26,10,19),USE(?L12),TIP('05:30-06:00')
                       BUTTON('6'),AT(174,26,10,19),USE(?L13),TIP('06:00-06:30'),REQ
                       BUTTON,AT(185,26,10,19),USE(?L14),TIP('06:30-07:00')
                       BUTTON('7'),AT(196,26,10,19),USE(?L15),TIP('07:00-07:30'),REQ
                       BUTTON,AT(207,26,10,19),USE(?L16),TIP('07:30-08:00')
                       BUTTON('8'),AT(219,26,10,19),USE(?L17),TIP('08:00-08:30'),REQ
                       BUTTON,AT(231,26,10,19),USE(?L18),TIP('08:30-09:00')
                       BUTTON('9'),AT(242,26,10,19),USE(?L19),TIP('09:00-09:30'),REQ
                       BUTTON,AT(253,26,10,19),USE(?L20),TIP('09:30-10:00')
                       BUTTON('10'),AT(264,26,10,19),USE(?L21),TIP('10:00-10:30'),REQ
                       BUTTON,AT(275,26,10,19),USE(?L22),TIP('10:30-11:00')
                       BUTTON('11'),AT(287,26,10,19),USE(?L23),TIP('11:00-11:30'),REQ
                       BUTTON,AT(298,26,10,19),USE(?L24),TIP('11:30-12:00')
                       BUTTON('12'),AT(309,26,10,19),USE(?L25),TIP('12:00-12:30'),REQ
                       BUTTON,AT(320,26,10,19),USE(?L26),TIP('12:30-13:00')
                       BUTTON('13'),AT(331,26,10,19),USE(?L27),TIP('13:00-13:30'),REQ
                       BUTTON,AT(342,26,10,19),USE(?L28),TIP('13:30-14:00')
                       BUTTON('14'),AT(353,26,10,19),USE(?L29),TIP('14:00-14:30'),REQ
                       BUTTON,AT(365,26,10,19),USE(?L30),TIP('14:30-15:00')
                       BUTTON('15'),AT(376,26,10,19),USE(?L31),TIP('15:00-15:30'),REQ
                       BUTTON,AT(387,26,10,19),USE(?L32),TIP('15:30-16:00')
                       BUTTON('16'),AT(398,26,10,19),USE(?L33),TIP('16:00-16:30'),REQ
                       BUTTON,AT(409,26,10,19),USE(?L34),TIP('16:30-17:00')
                       BUTTON('17'),AT(420,26,10,19),USE(?L35),TIP('17:00-17:30'),REQ
                       BUTTON,AT(431,26,10,19),USE(?L36),TIP('17:30-18:00')
                       BUTTON('18'),AT(442,26,10,19),USE(?L37),TIP('18:00-18:30'),REQ
                       BUTTON,AT(454,26,10,19),USE(?L38),TIP('18:30-19:00')
                       BUTTON('19'),AT(466,26,10,19),USE(?L39),TIP('19:00-19:30'),REQ
                       BUTTON,AT(477,26,10,19),USE(?L40),TIP('19:30-20:00')
                       BUTTON('20'),AT(488,26,10,19),USE(?L41),TIP('20:00-20:30'),REQ
                       BUTTON,AT(499,26,10,19),USE(?L42),TIP('20:30-21:00')
                       BUTTON('21'),AT(510,26,10,19),USE(?L43),TIP('21:00-21:30'),REQ
                       BUTTON,AT(521,26,10,19),USE(?L44),TIP('21:30-22:00')
                       BUTTON('22'),AT(532,26,10,19),USE(?L45),TIP('22:00-22:30'),REQ
                       BUTTON,AT(543,26,10,19),USE(?L46),TIP('22:30-23:00')
                       BUTTON('23'),AT(555,26,10,19),USE(?L47),TIP('23:00-23:30'),REQ
                       BUTTON,AT(566,26,10,19),USE(?L48),TIP('23:30-24:00')
                       BUTTON('1'),AT(7,46,28,10),USE(?Button1)
                       STRING(@s96),AT(42,46,545,10),USE(GRAF[1],,?GRAF1),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('2'),AT(7,56,28,10),USE(?Button2)
                       STRING(@s96),AT(42,56,545,10),USE(GRAF[2],,?GRAF2),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('3'),AT(7,66,28,10),USE(?Button3)
                       STRING(@s96),AT(42,66,545,10),USE(GRAF[3],,?GRAF3),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('4'),AT(7,76,28,10),USE(?Button4)
                       STRING(@s96),AT(42,76,545,10),USE(GRAF[4],,?GRAF4),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('5'),AT(7,86,28,10),USE(?Button5)
                       STRING(@s96),AT(42,86,545,10),USE(GRAF[5],,?GRAF5),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('6'),AT(7,96,28,10),USE(?Button6)
                       STRING(@s96),AT(42,96,545,10),USE(GRAF[6],,?GRAF6),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('7'),AT(7,106,28,10),USE(?Button7)
                       STRING(@s96),AT(42,106,545,10),USE(GRAF[7],,?GRAF7),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('8'),AT(7,116,28,10),USE(?Button8)
                       STRING(@s96),AT(42,116,545,10),USE(GRAF[8],,?GRAF8),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('9'),AT(7,126,28,10),USE(?Button9)
                       STRING(@s96),AT(42,126,545,10),USE(GRAF[9],,?GRAF9),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('10'),AT(7,136,28,10),USE(?Button10)
                       STRING(@s96),AT(42,136,545,10),USE(GRAF[10],,?GRAF10),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('11'),AT(7,146,28,10),USE(?Button11)
                       STRING(@s96),AT(42,146,545,10),USE(GRAF[11],,?GRAF11),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('12'),AT(7,156,28,10),USE(?Button12)
                       STRING(@s96),AT(42,156,545,10),USE(GRAF[12],,?GRAF12),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('13'),AT(7,166,28,10),USE(?Button13)
                       STRING(@s96),AT(42,166,545,10),USE(GRAF[13],,?GRAF13),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('14'),AT(7,176,28,10),USE(?Button14)
                       STRING(@s96),AT(42,176,545,10),USE(GRAF[14],,?GRAF14),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('15'),AT(7,186,28,10),USE(?Button15)
                       STRING(@s96),AT(42,186,545,10),USE(GRAF[15],,?GRAF15),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('16'),AT(7,196,28,10),USE(?Button16)
                       STRING(@s96),AT(42,196,545,10),USE(GRAF[16],,?GRAF16),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('17'),AT(7,206,28,10),USE(?Button17)
                       STRING(@s96),AT(42,206,545,10),USE(GRAF[17],,?GRAF17),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('18'),AT(7,216,28,10),USE(?Button18)
                       STRING(@s96),AT(42,216,545,10),USE(GRAF[18],,?GRAF18),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('19'),AT(7,226,28,10),USE(?Button19)
                       STRING(@s96),AT(42,226,545,10),USE(GRAF[19],,?GRAF19),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('20'),AT(7,236,28,10),USE(?Button20)
                       STRING(@s96),AT(42,236,545,10),USE(GRAF[20],,?GRAF20),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('21'),AT(7,246,28,10),USE(?Button21)
                       STRING(@s96),AT(42,246,545,10),USE(GRAF[21],,?GRAF21),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('22'),AT(7,256,28,10),USE(?Button22)
                       STRING(@s96),AT(42,256,545,10),USE(GRAF[22],,?GRAF22),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('23'),AT(7,266,28,10),USE(?Button23)
                       STRING(@s96),AT(42,266,545,10),USE(GRAF[23],,?GRAF23),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('24'),AT(7,276,28,10),USE(?Button24)
                       STRING(@s96),AT(42,276,545,10),USE(GRAF[24],,?GRAF24),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('25'),AT(7,286,28,10),USE(?Button25)
                       STRING(@s96),AT(42,286,545,10),USE(GRAF[25],,?GRAF25),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('26'),AT(7,296,28,10),USE(?Button26)
                       STRING(@s96),AT(42,296,545,10),USE(GRAF[26],,?GRAF26),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('27'),AT(7,306,28,10),USE(?Button27)
                       STRING(@s96),AT(42,306,545,10),USE(GRAF[27],,?GRAF27),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('28'),AT(7,316,28,10),USE(?Button28)
                       STRING(@s96),AT(42,316,545,10),USE(GRAF[28],,?GRAF28),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('29'),AT(7,326,28,10),USE(?Button29)
                       STRING(@s96),AT(42,326,545,10),USE(GRAF[29],,?GRAF29),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       BUTTON('30'),AT(7,336,28,10),USE(?Button30)
                       STRING(@s96),AT(42,336,545,10),USE(GRAF[30],,?GRAF30),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC),COLOR(COLOR:Silver)
                       BUTTON('31'),AT(7,346,28,10),USE(?Button31)
                       STRING(@s96),AT(42,346,545,10),USE(GRAF[31],,?GRAF31),LEFT,FONT('Courier New',9,,,CHARSET:BALTIC)
                       STRING('Atzîmçt Vienu: KreisâPele; Atzîmçt vçl vienu: Alt+KrPele; Apgabalu:Shift+KrPele'),AT(2,360,350,10),USE(?String80),FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
                       BUTTON('&OK'),AT(518,360,33,15),USE(?OK),FONT(,8,,FONT:bold,CHARSET:ANSI),DEFAULT,REQ
                       BUTTON('&Atlikt'),AT(552,360,33,15),USE(?Cancel),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       STRING(@s50),AT(8,369,255,11),USE(STUNDAS),FONT('Arial',8,,FONT:bold,CHARSET:BALTIC)
                       BUTTON('&Notîrît brivd.'),AT(384,360,56,15),USE(?ButtonNotîrît:3),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       BUTTON('&Notîrît'),AT(352,360,30,15),USE(?ButtonNotîrît:2),FONT(,8,,FONT:bold,CHARSET:ANSI)
                       BUTTON('&Notîrît Atzîmçto'),AT(441,360,76,15),USE(?ButtonNotîrît),FONT(,8,,FONT:bold,CHARSET:ANSI)
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
  LOOP I#=1 TO 31
     LOOP J#=1 TO 48
        GRAF_S[J#*2-1]=GRA:G[I#,J#]
        GRAF_S[J#*2]='|'
     .
     GRAF[I#]=GRAF_S
  .
  VUT=GETKADRI(GRA:ID,0,3)
  M#=MONTH(GRA:YYYYMM)
  LOOP I#=1 TO 31
     IF INSTRING(GETCAL(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM))),' SX',1,1)
        COLOR#=0E9ECFEH
  !   ELSIF I#/2-INT(I#/2)>0
     ELSE
        COLOR#=COLOR:NONE
  !   ELSE
  !      COLOR#=COLOR:SILVER
     .
     EXECUTE I#
        ?GRAF1{PROP:COLOR,1}=COLOR#
        ?GRAF2{PROP:COLOR,1}=COLOR#
        ?GRAF3{PROP:COLOR,1}=COLOR#
        ?GRAF4{PROP:COLOR,1}=COLOR#
        ?GRAF5{PROP:COLOR,1}=COLOR#
        ?GRAF6{PROP:COLOR,1}=COLOR#
        ?GRAF7{PROP:COLOR,1}=COLOR#
        ?GRAF8{PROP:COLOR,1}=COLOR#
        ?GRAF9{PROP:COLOR,1}=COLOR#
        ?GRAF10{PROP:COLOR,1}=COLOR#
        ?GRAF11{PROP:COLOR,1}=COLOR#
        ?GRAF12{PROP:COLOR,1}=COLOR#
        ?GRAF13{PROP:COLOR,1}=COLOR#
        ?GRAF14{PROP:COLOR,1}=COLOR#
        ?GRAF15{PROP:COLOR,1}=COLOR#
        ?GRAF16{PROP:COLOR,1}=COLOR#
        ?GRAF17{PROP:COLOR,1}=COLOR#
        ?GRAF18{PROP:COLOR,1}=COLOR#
        ?GRAF19{PROP:COLOR,1}=COLOR#
        ?GRAF20{PROP:COLOR,1}=COLOR#
        ?GRAF21{PROP:COLOR,1}=COLOR#
        ?GRAF22{PROP:COLOR,1}=COLOR#
        ?GRAF23{PROP:COLOR,1}=COLOR#
        ?GRAF24{PROP:COLOR,1}=COLOR#
        ?GRAF25{PROP:COLOR,1}=COLOR#
        ?GRAF26{PROP:COLOR,1}=COLOR#
        ?GRAF27{PROP:COLOR,1}=COLOR#
        ?GRAF28{PROP:COLOR,1}=COLOR#
        ?GRAF29{PROP:COLOR,1}=COLOR#
        ?GRAF30{PROP:COLOR,1}=COLOR#
        ?GRAF31{PROP:COLOR,1}=COLOR#
     .
     IF INRANGE(I#,28,31)
        IF ~(MONTH(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM)))=M#)
           EXECUTE I#-27
              HIDE(?BUTTON28)
              HIDE(?BUTTON29)
              HIDE(?BUTTON30)
              HIDE(?BUTTON31)
           .
        ELSE
           EXECUTE I#-27
              UNHIDE(?BUTTON28)
              UNHIDE(?BUTTON29)
              UNHIDE(?BUTTON30)
              UNHIDE(?BUTTON31)
           .
        .
     .
  .
  STUNDAS='Diena: '&CLIP(GRA:DIENA)&'  Nakts: '&CLIP(GRA:NAKTS)&'  Kopâ: '&CLIP(GRA:DIENA+GRA:NAKTS)
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
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
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Prompt1)
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
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::GRA:Record = GRA:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(GRAFIKS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Prompt1)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::GRA:Record <> GRA:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:GRAFIKS(1)
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
              SELECT(?Prompt1)
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
    IF INRANGE(FIELD(),56,116) AND EVENT()=EVENT:SELECTED
       J#=(FIELD()-56)/2+1
       IF KEYCODE()=SHIFTMOUSELEFT
          STEP#=1
          IF ~D_SELECTED THEN D_SELECTED=FIELD().
          I#=(D_SELECTED-56)/2+1
          IF I#>J# THEN STEP#=-1.
          COLOR#=COLOR:RED
          LOOP D#=I# TO J# BY STEP#
             DO FILL_D
             GRAF_D[D#]=1
          .
       ELSIF KEYCODE()=ALTMOUSELEFT
          D#=J#
          IF ~GRAF_D[D#]
             COLOR#=COLOR:RED
             DO FILL_D
             GRAF_D[D#]=1
          .
       ELSE
          COLOR#=COLOR:SILVER
          LOOP D#=1 TO 31
             DO FILL_D
             GRAF_D[D#]=0
          .
          COLOR#=COLOR:RED
          D#=J#
          DO FILL_D
          GRAF_D[D#]=1
       .
       D_SELECTED=FIELD()
       DO FILL_GRAF
       DO FILL_STUNDAS
    
    .
    IF INRANGE(FIELD(),8,55) AND EVENT()=EVENT:SELECTED
       J#=FIELD()-7
       IF KEYCODE()=SHIFTMOUSELEFT
          STEP#=1
          IF ~L_SELECTED THEN L_SELECTED=FIELD().
          I#=L_SELECTED-7
          IF I#>J# THEN STEP#=-1.
          COLOR#=COLOR:RED
          LOOP L#=I# TO J# BY STEP#
             DO FILL_L
             GRAF_L[L#]=1
          .
       ELSIF KEYCODE()=ALTMOUSELEFT
          L#=J#
          IF ~GRAF_L[L#]
             COLOR#=COLOR:RED
             DO FILL_L
             GRAF_L[L#]=1
          .
       ELSE
          COLOR#=COLOR:SILVER
          LOOP L#=1 TO 48
             DO FILL_L
             GRAF_L[L#]=0
          .
          COLOR#=COLOR:RED
          L#=J#
          DO FILL_L
          GRAF_L[L#]=1
       .
       L_SELECTED=FIELD()
       DO FILL_GRAF
       DO FILL_STUNDAS
    .
    CASE FIELD()
    OF ?GRA:YYYYMM
      CASE EVENT()
      OF EVENT:Accepted
        M#=MONTH(GRA:YYYYMM)
        LOOP I#=1 TO 31
           IF INSTRING(GETCAL(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM))),' SX',1,1)
              COLOR#=0E9ECFEH
        !   ELSIF I#/2-INT(I#/2)>0
           ELSE
              COLOR#=COLOR:NONE
        !   ELSE
        !      COLOR#=COLOR:SILVER
           .
           EXECUTE I#
              ?GRAF1{PROP:COLOR,1}=COLOR#
              ?GRAF2{PROP:COLOR,1}=COLOR#
              ?GRAF3{PROP:COLOR,1}=COLOR#
              ?GRAF4{PROP:COLOR,1}=COLOR#
              ?GRAF5{PROP:COLOR,1}=COLOR#
              ?GRAF6{PROP:COLOR,1}=COLOR#
              ?GRAF7{PROP:COLOR,1}=COLOR#
              ?GRAF8{PROP:COLOR,1}=COLOR#
              ?GRAF9{PROP:COLOR,1}=COLOR#
              ?GRAF10{PROP:COLOR,1}=COLOR#
              ?GRAF11{PROP:COLOR,1}=COLOR#
              ?GRAF12{PROP:COLOR,1}=COLOR#
              ?GRAF13{PROP:COLOR,1}=COLOR#
              ?GRAF14{PROP:COLOR,1}=COLOR#
              ?GRAF15{PROP:COLOR,1}=COLOR#
              ?GRAF16{PROP:COLOR,1}=COLOR#
              ?GRAF17{PROP:COLOR,1}=COLOR#
              ?GRAF18{PROP:COLOR,1}=COLOR#
              ?GRAF19{PROP:COLOR,1}=COLOR#
              ?GRAF20{PROP:COLOR,1}=COLOR#
              ?GRAF21{PROP:COLOR,1}=COLOR#
              ?GRAF22{PROP:COLOR,1}=COLOR#
              ?GRAF23{PROP:COLOR,1}=COLOR#
              ?GRAF24{PROP:COLOR,1}=COLOR#
              ?GRAF25{PROP:COLOR,1}=COLOR#
              ?GRAF26{PROP:COLOR,1}=COLOR#
              ?GRAF27{PROP:COLOR,1}=COLOR#
              ?GRAF28{PROP:COLOR,1}=COLOR#
              ?GRAF29{PROP:COLOR,1}=COLOR#
              ?GRAF30{PROP:COLOR,1}=COLOR#
              ?GRAF31{PROP:COLOR,1}=COLOR#
           .
           IF INRANGE(I#,28,31)
              IF ~(MONTH(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM)))=M#)
                 EXECUTE I#-27
                    HIDE(?BUTTON28)
                    HIDE(?BUTTON29)
                    HIDE(?BUTTON30)
                    HIDE(?BUTTON31)
                 .
              ELSE
                 EXECUTE I#-27
                    UNHIDE(?BUTTON28)
                    UNHIDE(?BUTTON29)
                    UNHIDE(?BUTTON30)
                    UNHIDE(?BUTTON31)
                 .
              .
           .
        .
      END
    OF ?ButtonID
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseKadri 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           GRA:ID=KAD:ID
           GRA:INI=KAD:INI
           VUT=GETKADRI(GRA:ID,0,3)
           DISPLAY
        .
      END
    OF ?ButtonUzbK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        M#=MONTH(GRA:YYYYMM)
        LOOP I#=1 TO 31
           IF ~INSTRING(GETCAL(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM))),' SX',1,1) AND|
              MONTH(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM)))=M#
              GRAF_S=GRAF[I#]
              LOOP L#=19 TO 36           ! 9:00-18:00
                 IF ~INRANGE(L#,27,28)   !13:00-14:00
                    GRAF_S[L#*2-1]='*'
                 .
              .
              GRAF[I#]=GRAF_S
           .
        .
        DO FILL_STUNDAS
      END
    OF ?ButtonA 
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        COLOR#=COLOR:SILVER
        LOOP I#=1 TO 48
           IF INRANGE(I#,1,31)
              GRAF_D[I#]=0
              EXECUTE I#
                 ?Button1{PROP:COLOR,1}=COLOR#
                 ?Button2{PROP:COLOR,1}=COLOR#
                 ?Button3{PROP:COLOR,1}=COLOR#
                 ?Button4{PROP:COLOR,1}=COLOR#
                 ?Button5{PROP:COLOR,1}=COLOR#
                 ?Button6{PROP:COLOR,1}=COLOR#
                 ?Button7{PROP:COLOR,1}=COLOR#
                 ?Button8{PROP:COLOR,1}=COLOR#
                 ?Button9{PROP:COLOR,1}=COLOR#
                 ?Button10{PROP:COLOR,1}=COLOR#
                 ?Button11{PROP:COLOR,1}=COLOR#
                 ?Button12{PROP:COLOR,1}=COLOR#
                 ?Button13{PROP:COLOR,1}=COLOR#
                 ?Button14{PROP:COLOR,1}=COLOR#
                 ?Button15{PROP:COLOR,1}=COLOR#
                 ?Button16{PROP:COLOR,1}=COLOR#
                 ?Button17{PROP:COLOR,1}=COLOR#
                 ?Button18{PROP:COLOR,1}=COLOR#
                 ?Button19{PROP:COLOR,1}=COLOR#
                 ?Button20{PROP:COLOR,1}=COLOR#
                 ?Button21{PROP:COLOR,1}=COLOR#
                 ?Button22{PROP:COLOR,1}=COLOR#
                 ?Button23{PROP:COLOR,1}=COLOR#
                 ?Button24{PROP:COLOR,1}=COLOR#
                 ?Button25{PROP:COLOR,1}=COLOR#
                 ?Button26{PROP:COLOR,1}=COLOR#
                 ?Button27{PROP:COLOR,1}=COLOR#
                 ?Button28{PROP:COLOR,1}=COLOR#
                 ?Button29{PROP:COLOR,1}=COLOR#
                 ?Button30{PROP:COLOR,1}=COLOR#
                 ?Button31{PROP:COLOR,1}=COLOR#
              .
           .
           GRAF_L[I#]=0
           EXECUTE I#
              ?L1{PROP:COLOR,1}=COLOR#
              ?L2{PROP:COLOR,1}=COLOR#
              ?L3{PROP:COLOR,1}=COLOR#
              ?L4{PROP:COLOR,1}=COLOR#
              ?L5{PROP:COLOR,1}=COLOR#
              ?L6{PROP:COLOR,1}=COLOR#
              ?L7{PROP:COLOR,1}=COLOR#
              ?L8{PROP:COLOR,1}=COLOR#
              ?L9{PROP:COLOR,1}=COLOR#
              ?L10{PROP:COLOR,1}=COLOR#
              ?L11{PROP:COLOR,1}=COLOR#
              ?L12{PROP:COLOR,1}=COLOR#
              ?L13{PROP:COLOR,1}=COLOR#
              ?L14{PROP:COLOR,1}=COLOR#
              ?L15{PROP:COLOR,1}=COLOR#
              ?L16{PROP:COLOR,1}=COLOR#
              ?L17{PROP:COLOR,1}=COLOR#
              ?L18{PROP:COLOR,1}=COLOR#
              ?L19{PROP:COLOR,1}=COLOR#
              ?L20{PROP:COLOR,1}=COLOR#
              ?L21{PROP:COLOR,1}=COLOR#
              ?L22{PROP:COLOR,1}=COLOR#
              ?L23{PROP:COLOR,1}=COLOR#
              ?L24{PROP:COLOR,1}=COLOR#
              ?L25{PROP:COLOR,1}=COLOR#
              ?L26{PROP:COLOR,1}=COLOR#
              ?L27{PROP:COLOR,1}=COLOR#
              ?L28{PROP:COLOR,1}=COLOR#
              ?L29{PROP:COLOR,1}=COLOR#
              ?L30{PROP:COLOR,1}=COLOR#
              ?L31{PROP:COLOR,1}=COLOR#
              ?L32{PROP:COLOR,1}=COLOR#
              ?L33{PROP:COLOR,1}=COLOR#
              ?L34{PROP:COLOR,1}=COLOR#
              ?L35{PROP:COLOR,1}=COLOR#
              ?L36{PROP:COLOR,1}=COLOR#
              ?L37{PROP:COLOR,1}=COLOR#
              ?L38{PROP:COLOR,1}=COLOR#
              ?L39{PROP:COLOR,1}=COLOR#
              ?L40{PROP:COLOR,1}=COLOR#
              ?L41{PROP:COLOR,1}=COLOR#
              ?L42{PROP:COLOR,1}=COLOR#
              ?L43{PROP:COLOR,1}=COLOR#
              ?L44{PROP:COLOR,1}=COLOR#
              ?L45{PROP:COLOR,1}=COLOR#
              ?L46{PROP:COLOR,1}=COLOR#
              ?L47{PROP:COLOR,1}=COLOR#
              ?L48{PROP:COLOR,1}=COLOR#
           .
        .
        DISPLAY
      END
    OF ?L1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !STOP(FIELD())
      END
    OF ?L2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L21
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L23
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L24
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L26
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L27
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L28
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L29
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L30
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L31
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L32
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L33
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L34
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L35
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L36
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L37
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L38
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L39
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L40
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L41
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L42
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L43
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L44
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L45
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L46
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L47
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?L48
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !STOP(FIELD())
      END
    OF ?Button1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !STOP(FIELD())
      END
    OF ?Button2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button21
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button23
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button24
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button26
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button27
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button28
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button29
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button30
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button31
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !STOP(FIELD())
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        LOOP I#=1 TO 31
           GRAF_S=GRAF[I#]
           LOOP J#=1 TO 48
              GRA:G[I#,J#]=GRAF_S[J#*2-1]
           .
        .
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    OF ?ButtonNotîrît:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         
        DO KILL_Brivdienas
        DISPLAY
        
      END
    OF ?ButtonNotîrît:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO KILL_ALL_GRAF
        DO FILL_STUNDAS
        DISPLAY
        
      END
    OF ?ButtonNotîrît
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO KILL_GRAF
        DO FILL_STUNDAS
        DISPLAY
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GRAFIKS::Used = 0
    CheckOpen(GRAFIKS,1)
  END
  GRAFIKS::Used += 1
  BIND(GRA:RECORD)
  FilesOpened = True
  RISnap:GRAFIKS
  SAV::GRA:Record = GRA:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    GRA:YYYYMM=DATE(MONTH(TODAY()),1,YEAR(TODAY()))
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:GRAFIKS()
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
  OPEN(FormWindow)
  WindowOpened=True
  INIRestoreWindow('UpdateGrafiks','winlats.INI')
  ?GRA:YYYYMM{PROP:Alrt,255} = 734
  ?GRA:ID{PROP:Alrt,255} = 734
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
    GRAFIKS::Used -= 1
    IF GRAFIKS::Used = 0 THEN CLOSE(GRAFIKS).
  END
  IF WindowOpened
    INISaveWindow('UpdateGrafiks','winlats.INI')
    CLOSE(FormWindow)
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
  IF FormWindow{Prop:AcceptAll} THEN EXIT.
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
FILL_D   ROUTINE
   EXECUTE D#
      ?BUTTON1{PROP:COLOR,1}=COLOR#
      ?BUTTON2{PROP:COLOR,1}=COLOR#
      ?BUTTON3{PROP:COLOR,1}=COLOR#
      ?BUTTON4{PROP:COLOR,1}=COLOR#
      ?BUTTON5{PROP:COLOR,1}=COLOR#
      ?BUTTON6{PROP:COLOR,1}=COLOR#
      ?BUTTON7{PROP:COLOR,1}=COLOR#
      ?BUTTON8{PROP:COLOR,1}=COLOR#
      ?BUTTON9{PROP:COLOR,1}=COLOR#
      ?BUTTON10{PROP:COLOR,1}=COLOR#
      ?BUTTON11{PROP:COLOR,1}=COLOR#
      ?BUTTON12{PROP:COLOR,1}=COLOR#
      ?BUTTON13{PROP:COLOR,1}=COLOR#
      ?BUTTON14{PROP:COLOR,1}=COLOR#
      ?BUTTON15{PROP:COLOR,1}=COLOR#
      ?BUTTON16{PROP:COLOR,1}=COLOR#
      ?BUTTON17{PROP:COLOR,1}=COLOR#
      ?BUTTON18{PROP:COLOR,1}=COLOR#
      ?BUTTON19{PROP:COLOR,1}=COLOR#
      ?BUTTON20{PROP:COLOR,1}=COLOR#
      ?BUTTON21{PROP:COLOR,1}=COLOR#
      ?BUTTON22{PROP:COLOR,1}=COLOR#
      ?BUTTON23{PROP:COLOR,1}=COLOR#
      ?BUTTON24{PROP:COLOR,1}=COLOR#
      ?BUTTON25{PROP:COLOR,1}=COLOR#
      ?BUTTON26{PROP:COLOR,1}=COLOR#
      ?BUTTON27{PROP:COLOR,1}=COLOR#
      ?BUTTON28{PROP:COLOR,1}=COLOR#
      ?BUTTON29{PROP:COLOR,1}=COLOR#
      ?BUTTON30{PROP:COLOR,1}=COLOR#
      ?BUTTON31{PROP:COLOR,1}=COLOR#
   .
FILL_L   ROUTINE
   EXECUTE L#
      ?L1{PROP:COLOR,1}=COLOR#
      ?L2{PROP:COLOR,1}=COLOR#
      ?L3{PROP:COLOR,1}=COLOR#
      ?L4{PROP:COLOR,1}=COLOR#
      ?L5{PROP:COLOR,1}=COLOR#
      ?L6{PROP:COLOR,1}=COLOR#
      ?L7{PROP:COLOR,1}=COLOR#
      ?L8{PROP:COLOR,1}=COLOR#
      ?L9{PROP:COLOR,1}=COLOR#
      ?L10{PROP:COLOR,1}=COLOR#
      ?L11{PROP:COLOR,1}=COLOR#
      ?L12{PROP:COLOR,1}=COLOR#
      ?L13{PROP:COLOR,1}=COLOR#
      ?L14{PROP:COLOR,1}=COLOR#
      ?L15{PROP:COLOR,1}=COLOR#
      ?L16{PROP:COLOR,1}=COLOR#
      ?L17{PROP:COLOR,1}=COLOR#
      ?L18{PROP:COLOR,1}=COLOR#
      ?L19{PROP:COLOR,1}=COLOR#
      ?L20{PROP:COLOR,1}=COLOR#
      ?L21{PROP:COLOR,1}=COLOR#
      ?L22{PROP:COLOR,1}=COLOR#
      ?L23{PROP:COLOR,1}=COLOR#
      ?L24{PROP:COLOR,1}=COLOR#
      ?L25{PROP:COLOR,1}=COLOR#
      ?L26{PROP:COLOR,1}=COLOR#
      ?L27{PROP:COLOR,1}=COLOR#
      ?L28{PROP:COLOR,1}=COLOR#
      ?L29{PROP:COLOR,1}=COLOR#
      ?L30{PROP:COLOR,1}=COLOR#
      ?L31{PROP:COLOR,1}=COLOR#
      ?L32{PROP:COLOR,1}=COLOR#
      ?L33{PROP:COLOR,1}=COLOR#
      ?L34{PROP:COLOR,1}=COLOR#
      ?L35{PROP:COLOR,1}=COLOR#
      ?L36{PROP:COLOR,1}=COLOR#
      ?L37{PROP:COLOR,1}=COLOR#
      ?L38{PROP:COLOR,1}=COLOR#
      ?L39{PROP:COLOR,1}=COLOR#
      ?L40{PROP:COLOR,1}=COLOR#
      ?L41{PROP:COLOR,1}=COLOR#
      ?L42{PROP:COLOR,1}=COLOR#
      ?L43{PROP:COLOR,1}=COLOR#
      ?L44{PROP:COLOR,1}=COLOR#
      ?L45{PROP:COLOR,1}=COLOR#
      ?L46{PROP:COLOR,1}=COLOR#
      ?L47{PROP:COLOR,1}=COLOR#
      ?L48{PROP:COLOR,1}=COLOR#
   .

FILL_GRAF ROUTINE
   LOOP D#=1 TO 31
      IF GRAF_D[D#]
         GRAF_S=GRAF[D#]
         LOOP L#=1 TO 48
            IF GRAF_L[L#]
                GRAF_S[L#*2-1]='*'
            .
         .
         GRAF[D#]=GRAF_S
      .
   .

FILL_STUNDAS ROUTINE
   GRA:DIENA=0
   GRA:NAKTS=0
   LOOP D#=1 TO 31
      GRAF_S=GRAF[D#]
      LOOP L#=1 TO 48
         IF GRAF_S[L#*2-1]='*'
            IF INRANGE(L#,13,44) !DIENA 6:00-20:00
               GRA:DIENA+=0.5
            ELSE
               GRA:NAKTS+=0.5
            .
         .
      .
   .
   STUNDAS='Diena: '&CLIP(GRA:DIENA)&'  Nakts: '&CLIP(GRA:NAKTS)&'  Kopâ: '&CLIP(GRA:DIENA+GRA:NAKTS)

KILL_GRAF ROUTINE
   LOOP D#=1 TO 31
      IF GRAF_D[D#]
         GRAF_S=GRAF[D#]
         LOOP L#=1 TO 48
            IF GRAF_L[L#]
               GRAF_S[L#*2-1]=''
            .
         .
         GRAF[D#]=GRAF_S
      .
   .
!13.07.2015
KILL_All_GRAF ROUTINE
   LOOP D#=1 TO 31
      LOOP L#=1 TO 48
            GRAF_S[L#*2-1]=''
      .
      GRAF[D#]=GRAF_S
   .

!16.07.2015
KILL_Brivdienas ROUTINE
  LOOP I#=1 TO 31
     IF INSTRING(GETCAL(DATE(MONTH(GRA:YYYYMM),I#,YEAR(GRA:YYYYMM))),' SX',1,1)
        LOOP L#=1 TO 48
              GRAF_S[L#*2-1]=''
        .
        GRAF[I#]=GRAF_S
     .
  .

!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?GRA:YYYYMM
      GRA:YYYYMM = History::GRA:Record.YYYYMM
    OF ?GRA:ID
      GRA:ID = History::GRA:Record.ID
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
  GRA:Record = SAV::GRA:Record
  SAV::GRA:Record = GRA:Record
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

BrowseGrafiks PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
RecordFiltered       LONG
VUT                  STRING(30)

BRW1::View:Browse    VIEW(GRAFIKS)
                       PROJECT(GRA:YYYYMM)
                       PROJECT(GRA:ID)
                       PROJECT(GRA:INI)
                     END

Queue:Browse         QUEUE,PRE()                  ! Browsing Queue
BRW1::GRA:YYYYMM       LIKE(GRA:YYYYMM)           ! Queue Display field
BRW1::GRA:ID           LIKE(GRA:ID)               ! Queue Display field
BRW1::VUT              LIKE(VUT)                  ! Queue Display field
BRW1::GRA:INI          LIKE(GRA:INI)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
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
BrowseWindow         WINDOW('Browse Records'),AT(,,320,265),CENTER,SYSTEM,GRAY,MDI
                       SHEET,AT(4,2,312,248),USE(?Sheet1)
                         TAB('Uzvârdu secîba'),USE(?Tab1)
                           LIST,AT(7,16,305,229),USE(?List),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('36C|M~YYYYMM~@D16@24R|M~ID~L(2)@n6@120L(2)|M~Vârds, Uzvârds~L(1)@s30@'),FROM(Queue:Browse)
                           ENTRY(@s15),AT(12,252,60,10),USE(GRA:INI)
                         END
                       END
                       BUTTON('&Ievadît'),AT(76,251,40,12),USE(?Insert),KEY(InsertKey)
                       BUTTON('&Mainît'),AT(118,251,40,12),USE(?Change),KEY(CtrlEnter),DEFAULT
                       BUTTON('&Dzçst'),AT(201,251,40,12),USE(?Delete),KEY(DeleteKey)
                       BUTTON('&Beigt'),AT(276,251,40,12),USE(?Close)
                       BUTTON('&Kopçt'),AT(160,251,40,12),USE(?Change:2),KEY(CtrlEnter),DEFAULT
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
    OF ?Sheet1
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
    OF ?GRA:INI
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?GRA:INI)
        IF GRA:INI
          CLEAR(GRA:YYYYMM)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = GRA:INI
          BRW1::Sort1:LocatorLength = LEN(CLIP(GRA:INI))
          SELECT(?List)
          DO BRW1::PostNewSelection
        END
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
    OF ?Change:2
      CASE EVENT()
      OF EVENT:Accepted
         COPYREQUEST=1
         DO BRW1::ButtonInsert
        
        DO SyncWindow
        
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GRAFIKS::Used = 0
    CheckOpen(GRAFIKS,1)
  END
  GRAFIKS::Used += 1
  BIND(GRA:RECORD)
  FilesOpened = True
  OPEN(BrowseWindow)
  WindowOpened=True
  INIRestoreWindow('BrowseGrafiks','winlats.INI')
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?List{Prop:Alrt,252} = MouseLeft2
  ?List{Prop:Alrt,250} = BSKey
  ?List{Prop:Alrt,250} = SpaceKey
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
    GRAFIKS::Used -= 1
    IF GRAFIKS::Used = 0 THEN CLOSE(GRAFIKS).
  END
  IF WindowOpened
    INISaveWindow('BrowseGrafiks','winlats.INI')
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
  CASE BRW1::SortOrder
  OF 1
    GRA:INI = BRW1::Sort1:LocatorValue
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
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    END
  ELSE
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      GRA:INI = BRW1::Sort1:LocatorValue
    END
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
  GRA:YYYYMM = BRW1::GRA:YYYYMM
  GRA:ID = BRW1::GRA:ID
  VUT = BRW1::VUT
  GRA:INI = BRW1::GRA:INI
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
  VUT=GETKADRI(GRA:ID,0,3)
  BRW1::GRA:YYYYMM = GRA:YYYYMM
  BRW1::GRA:ID = GRA:ID
  BRW1::VUT = VUT
  BRW1::GRA:INI = GRA:INI
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
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      GRA:INI = BRW1::Sort1:LocatorValue
    END
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
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            GRA:INI = BRW1::Sort1:LocatorValue
            CLEAR(GRA:YYYYMM)
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          GRA:INI = BRW1::Sort1:LocatorValue
          CLEAR(GRA:YYYYMM)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          GRA:INI = BRW1::Sort1:LocatorValue
          CLEAR(GRA:YYYYMM)
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      END
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
        StandardWarning(Warn:RecordFetchError,'GRAFIKS')
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
      BRW1::HighlightedPosition = POSITION(GRA:INI_KEY)
      RESET(GRA:INI_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(GRA:INI_KEY,GRA:INI_KEY)
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
    CASE BRW1::SortOrder
    OF 1; ?GRA:INI{Prop:Disable} = 0
    END
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
    CLEAR(GRA:Record)
    CASE BRW1::SortOrder
    OF 1; ?GRA:INI{Prop:Disable} = 1
    END
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
    SET(GRA:INI_KEY)
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
  GET(GRAFIKS,0)
  CLEAR(GRA:Record,0)
  LocalRequest = InsertRecord
   IF COPYREQUEST=1
       DO SYNCWINDOW
       GRA:YYYYMM = GRA:YYYYMM
       GRA:ID = GRA:ID
       GRA:INI = GRA:INI
  
   .
  
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
!| (UpdateGrafiks) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateGrafiks
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
        GET(GRAFIKS,0)
        CLEAR(GRA:Record,0)
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


CAL PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
DAYS                 BYTE,DIM(37)
KESKA                STRING(12)
KESKAS               STRING(11)
KESKAV               STRING(11)
MENESIS              STRING(10)
CAL_STUNDAS          BYTE
window               WINDOW('Darba laika kalendârs'),AT(,,309,162),IMM,SYSTEM,GRAY
                       BUTTON('&Iepriekðçjais mçnesis'),AT(40,5,82,15),USE(?ButtonPrior)
                       STRING(@n4),AT(123,8),USE(GADS),RIGHT(1)
                       STRING('.gada'),AT(143,8),USE(?String46)
                       STRING(@s11),AT(163,8),USE(MENESIS)
                       BUTTON('&Nâkoðais mçnesis'),AT(214,5,82,15),USE(?ButtonNext)
                       STRING(@n3B),AT(10,8),USE(CAL_STUNDAS)
                       STRING('pirmdiena'),AT(8,26),USE(?String1),CENTER
                       STRING('otrdiena'),AT(55,26),USE(?String2),CENTER
                       STRING('treðdiena'),AT(96,26),USE(?String3),CENTER
                       STRING('ceturdiena'),AT(135,26),USE(?String4),CENTER
                       STRING('piektdiena'),AT(178,26),USE(?String5),CENTER
                       STRING('sestdiena'),AT(219,26),USE(?String6),CENTER
                       STRING('svçtdiena'),AT(263,26),USE(?String7),CENTER,FONT(,,COLOR:Red,)
                       STRING(@n2B),AT(10,43),USE(DAYS[1])
                       BUTTON(' '),AT(25,42,13,11),USE(?Button1)
                       STRING(@n2B),AT(54,43),USE(DAYS[2])
                       BUTTON,AT(68,42,13,11),USE(?Button2)
                       STRING(@n2B),AT(96,43),USE(DAYS[3])
                       BUTTON,AT(110,42,13,11),USE(?Button3)
                       STRING(@n2B),AT(137,43),USE(DAYS[4])
                       BUTTON,AT(152,42,13,11),USE(?Button4)
                       STRING(@n2B),AT(180,43),USE(DAYS[5])
                       BUTTON,AT(196,42,13,11),USE(?Button5)
                       STRING(@n2B),AT(220,43),USE(DAYS[6])
                       BUTTON,AT(236,42,13,11),USE(?Button6)
                       STRING(@n2),AT(263,43),USE(DAYS[7]),FONT(,,COLOR:Red,)
                       BUTTON,AT(277,42,13,11),USE(?Button7)
                       STRING(@n2),AT(11,58),USE(DAYS[8])
                       BUTTON,AT(25,57,13,11),USE(?Button8)
                       STRING(@n2),AT(54,58),USE(DAYS[9])
                       BUTTON,AT(68,57,13,11),USE(?Button9)
                       STRING(@n2),AT(96,58),USE(DAYS[10])
                       BUTTON,AT(110,57,13,11),USE(?Button10)
                       STRING(@n2),AT(137,58),USE(DAYS[11])
                       BUTTON,AT(152,57,13,11),USE(?Button11)
                       STRING(@n2),AT(180,58),USE(DAYS[12])
                       BUTTON,AT(196,57,13,11),USE(?Button12)
                       STRING(@n2),AT(220,58),USE(DAYS[13])
                       BUTTON,AT(236,57,13,11),USE(?Button13)
                       STRING(@n2),AT(263,58),USE(DAYS[14]),FONT(,,COLOR:Red,)
                       BUTTON,AT(277,57,13,11),USE(?Button14)
                       STRING(@n2),AT(11,73),USE(DAYS[15])
                       BUTTON,AT(25,72,13,11),USE(?Button15)
                       STRING(@n2),AT(54,73),USE(DAYS[16])
                       BUTTON,AT(68,72,13,11),USE(?Button16)
                       STRING(@n2),AT(96,73),USE(DAYS[17])
                       BUTTON,AT(110,72,13,11),USE(?Button17)
                       STRING(@n2),AT(137,73),USE(DAYS[18])
                       BUTTON,AT(152,72,13,11),USE(?Button18)
                       STRING(@n2),AT(180,73),USE(DAYS[19])
                       BUTTON,AT(196,72,13,11),USE(?Button19)
                       STRING(@n2),AT(220,73),USE(DAYS[20])
                       BUTTON,AT(236,72,13,11),USE(?Button20)
                       STRING(@n2),AT(263,73),USE(DAYS[21]),FONT(,,COLOR:Red,)
                       BUTTON,AT(277,72,13,11),USE(?Button21)
                       STRING(@n2),AT(11,88),USE(DAYS[22])
                       BUTTON,AT(25,87,13,11),USE(?Button22)
                       STRING(@n2),AT(54,88),USE(DAYS[23])
                       BUTTON,AT(68,87,13,11),USE(?Button23)
                       STRING(@n2),AT(96,88),USE(DAYS[24])
                       BUTTON,AT(110,87,13,11),USE(?Button24)
                       STRING(@n2),AT(137,88),USE(DAYS[25])
                       BUTTON,AT(152,87,13,11),USE(?Button25)
                       STRING(@n2),AT(180,88),USE(DAYS[26])
                       BUTTON,AT(196,87,13,11),USE(?Button26)
                       STRING(@n2),AT(220,88),USE(DAYS[27])
                       BUTTON,AT(236,87,13,11),USE(?Button27)
                       STRING(@n2),AT(263,88),USE(DAYS[28]),FONT(,,COLOR:Red,)
                       BUTTON,AT(277,87,13,11),USE(?Button28)
                       STRING(@n2B),AT(11,103),USE(DAYS[29])
                       BUTTON,AT(25,102,13,11),USE(?Button29)
                       STRING(@n2B),AT(54,103),USE(DAYS[30])
                       BUTTON,AT(68,102,13,11),USE(?Button30)
                       STRING(@n2B),AT(96,103),USE(DAYS[31])
                       BUTTON,AT(110,102,13,11),USE(?Button31)
                       STRING(@n2B),AT(137,103),USE(DAYS[32])
                       BUTTON,AT(152,102,13,11),USE(?Button32)
                       STRING(@n2B),AT(180,103),USE(DAYS[33])
                       BUTTON,AT(196,102,13,11),USE(?Button33)
                       STRING(@n2B),AT(220,103),USE(DAYS[34])
                       BUTTON,AT(236,102,13,11),USE(?Button34)
                       STRING(@n2B),AT(263,103),USE(DAYS[35]),FONT(,,COLOR:Red,)
                       BUTTON,AT(277,102,13,11),USE(?Button35)
                       STRING(@n2B),AT(11,118),USE(DAYS[36])
                       BUTTON,AT(25,117,13,11),USE(?Button36)
                       STRING(@n2B),AT(54,118),USE(DAYS[37])
                       BUTTON,AT(68,117,13,11),USE(?Button37)
                       LINE,AT(4,132,294,0),USE(?Line9),COLOR(COLOR:Black)
                       LINE,AT(4,37,294,0),USE(?Line11),COLOR(COLOR:Black)
                       LINE,AT(256,23,0,109),USE(?Line7),COLOR(COLOR:Black)
                       LINE,AT(214,23,0,109),USE(?Line6),COLOR(COLOR:Black)
                       LINE,AT(172,23,0,109),USE(?Line5),COLOR(COLOR:Black)
                       LINE,AT(130,23,0,109),USE(?Line4),COLOR(COLOR:Black)
                       LINE,AT(88,23,0,109),USE(?Line3),COLOR(COLOR:Black)
                       LINE,AT(46,23,0,109),USE(?Line2),COLOR(COLOR:Black)
                       BUTTON('&OK'),AT(263,139,36,14),USE(?OkButton),DEFAULT
                       LINE,AT(4,23,0,109),USE(?Line1),COLOR(COLOR:Black)
                       STRING('Darba dienas: no 0 lîdz 8; Sestdienas: S; Svçtdienas: _; Svçtku dienas: X vai Y'),AT(15,136,222,10),USE(?String48),FONT('Arial',9,,FONT:bold,CHARSET:BALTIC)
                       LINE,AT(4,23,294,0),USE(?Line10),COLOR(COLOR:Black)
                       LINE,AT(298,23,0,109),USE(?Line8),COLOR(COLOR:Black)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  KESKA ='012345678XS '
  KESKAS='012345678YS'
  KESKAV='012345678Y '
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   S#=DATE(MONTH(TODAY()),1,GADS)
   IF S#%7 = 0
      I#=7
   ELSE
      I#=S#%7
   .
   B#=DATE(MONTH(TODAY())+1,1,GADS)-1
   MENESIS=MENVAR(TODAY(),2,1)
   DO PerformScreen
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ButtonPrior)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    END
    CASE FIELD()
    OMIT('MARIS')
    OF 16
    OROF 18
    OROF 20
    OROF 22
       CASE EVENT()
       OF EVENT:Accepted
         DO SyncWindow
         I#= (FIELD()-15)-(FIELD()-16)/2
         CAL:DATUMS=DATE(MONTH(S#),CONTENTS(FIELD()-1),YEAR(S#))
         STOP(I#&' '&FORMAT(CAL:DATUMS,@D6))
    !       GET(CAL
      .
      MARIS
    OF ?ButtonPrior
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         S#-=15    ! Jebkurâ gadîjumâ iepriekðçjais mçnesis
         S#=DATE(MONTH(S#),1,YEAR(S#))
        ! STOP(FORMAT(S#,@D6))
         IF S#%7 = 0
            I#=7
         ELSE
            I#=S#%7
         .
         B#=DATE(MONTH(S#)+1,1,YEAR(S#))-1
         MENESIS=MENVAR(MONTH(S#),1,1)
         GADS=YEAR(S#)
         DO PerformScreen
      END
    OF ?ButtonNext
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         S#=DATE(MONTH(S#)+1,1,YEAR(S#))
        ! STOP(FORMAT(S#,@D6))
         IF S#%7 = 0
            I#=7
         ELSE
            I#=S#%7
         .
         B#=DATE(MONTH(S#)+1,1,YEAR(S#))-1
         MENESIS=MENVAR(MONTH(S#),1,1)
         GADS=YEAR(S#)
         DO PerformScreen
      END
    OF ?Button1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[1],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button1{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[2],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button2{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[3],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button3{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[4],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button4{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[5],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button5{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[6],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAS)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAS[I#]
        PUT(CAL)
        ?Button6{Prop:Text}=KESKAS[I#]
        DISPLAY
      END
    OF ?Button7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[7],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAV)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAV[I#]
        PUT(CAL)
        ?Button7{Prop:Text}=KESKAV[I#]
        DISPLAY
      END
    OF ?Button8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[8],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button8{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[9],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button9{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[10],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button10{Prop:Text}=KESKA[I#]
        DISPLAY
         
      END
    OF ?Button11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[11],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button11{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[12],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button12{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[13],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAS)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAS[I#]
        PUT(CAL)
        ?Button13{Prop:Text}=KESKAS[I#]
        DISPLAY
      END
    OF ?Button14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[14],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAV)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAV[I#]
        PUT(CAL)
        ?Button14{Prop:Text}=KESKAV[I#]
        DISPLAY
      END
    OF ?Button15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[15],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button15{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[16],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button16{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[17],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button17{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[18],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button18{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[19],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button19{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[20],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAS)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAS[I#]
        PUT(CAL)
        ?Button20{Prop:Text}=KESKAS[I#]
        DISPLAY
      END
    OF ?Button21
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[21],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAV)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAV[I#]
        PUT(CAL)
        ?Button21{Prop:Text}=KESKAV[I#]
        DISPLAY
      END
    OF ?Button22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[22],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button22{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button23
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[23],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button23{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button24
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[24],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button24{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[25],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button25{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button26
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[26],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button26{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button27
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[27],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAS)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAS[I#]
        PUT(CAL)
        ?Button27{Prop:Text}=KESKAS[I#]
        DISPLAY
      END
    OF ?Button28
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[28],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAV)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAV[I#]
        PUT(CAL)
        ?Button28{Prop:Text}=KESKAV[I#]
        DISPLAY
        
      END
    OF ?Button29
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[29],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button29{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button30
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[30],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button30{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button31
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[31],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button31{Prop:Text}=KESKA[I#]
        DISPLAY
           
      END
    OF ?Button32
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[32],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button32{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button33
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[33],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button33{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button34
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[34],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAS)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAS[I#]
        PUT(CAL)
        ?Button34{Prop:Text}=KESKAS[I#]
        DISPLAY
      END
    OF ?Button35
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[35],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKAV)
        IF I#=11
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKAV[I#]
        PUT(CAL)
        ?Button35{Prop:Text}=KESKAV[I#]
        DISPLAY
      END
    OF ?Button36
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[36],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button36{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?Button37
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        C#=GETCAL(DATE(MONTH(S#),DAYS[37],YEAR(S#)))
        I#=INSTRING(CAL:STUNDAS,KESKA)
        IF I#=12
            I#=1
        ELSE
            I#+=1
        END
        CAL:STUNDAS=KESKA[I#]
        PUT(CAL)
        ?Button37{Prop:Text}=KESKA[I#]
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF CAL::Used = 0
    CheckOpen(CAL,1)
  END
  CAL::Used += 1
  BIND(CAL:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('CAL','winlats.INI')
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
    CAL::Used -= 1
    IF CAL::Used = 0 THEN CLOSE(CAL).
  END
  IF WindowOpened
    INISaveWindow('CAL','winlats.INI')
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
PerformScreen    ROUTINE
 CLEAR(DAYS)
 LOOP K#= 1 TO 37
    IF INRANGE(K#,I#,DAY(B#)+I#-1)
       EXECUTE(K#)
          UNHIDE(?Button1)
          UNHIDE(?Button2)
          UNHIDE(?Button3)
          UNHIDE(?Button4)
          UNHIDE(?Button5)
          UNHIDE(?Button6)
          UNHIDE(?Button7)
          UNHIDE(?Button8)
          UNHIDE(?Button9)
          UNHIDE(?Button10)
          UNHIDE(?Button11)
          UNHIDE(?Button12)
          UNHIDE(?Button13)
          UNHIDE(?Button14)
          UNHIDE(?Button15)
          UNHIDE(?Button16)
          UNHIDE(?Button17)
          UNHIDE(?Button18)
          UNHIDE(?Button19)
          UNHIDE(?Button20)
          UNHIDE(?Button21)
          UNHIDE(?Button22)
          UNHIDE(?Button23)
          UNHIDE(?Button24)
          UNHIDE(?Button25)
          UNHIDE(?Button26)
          UNHIDE(?Button27)
          UNHIDE(?Button28)
          UNHIDE(?Button29)
          UNHIDE(?Button30)
          UNHIDE(?Button31)
          UNHIDE(?Button32)
          UNHIDE(?Button33)
          UNHIDE(?Button34)
          UNHIDE(?Button35)
          UNHIDE(?Button36)
          UNHIDE(?Button37)
       .
    ELSE
       EXECUTE(K#)
          HIDE(?Button1)
          HIDE(?Button2)
          HIDE(?Button3)
          HIDE(?Button4)
          HIDE(?Button5)
          HIDE(?Button6)
          HIDE(?Button7)
          HIDE(?Button8)
          HIDE(?Button9)
          HIDE(?Button10)
          HIDE(?Button11)
          HIDE(?Button12)
          HIDE(?Button13)
          HIDE(?Button14)
          HIDE(?Button15)
          HIDE(?Button16)
          HIDE(?Button17)
          HIDE(?Button18)
          HIDE(?Button19)
          HIDE(?Button20)
          HIDE(?Button21)
          HIDE(?Button22)
          HIDE(?Button23)
          HIDE(?Button24)
          HIDE(?Button25)
          HIDE(?Button26)
          HIDE(?Button27)
          HIDE(?Button28)
          HIDE(?Button29)
          HIDE(?Button30)
          HIDE(?Button31)
          HIDE(?Button32)
          HIDE(?Button33)
          HIDE(?Button34)
          HIDE(?Button35)
          HIDE(?Button36)
          HIDE(?Button37)
       .
    .
 .
 CAL_STUNDAS=0
 LOOP D# = S# TO B#
    C#=GETCAL(D#)
    IF INRANGE(CAL:STUNDAS,1,8) THEN CAL_STUNDAS+=CAL:STUNDAS.
    DAYS[DAY(D#)+I#-1]=DAY(D#)   !AIZPILDAM DATUMUS
    EXECUTE DAY(D#)+I#-1         !AIZPILDAM STUNDAS
        ?Button1{PROP:TEXT}=CAL:STUNDAS
        ?Button2{PROP:TEXT}=CAL:STUNDAS
        ?Button3{PROP:TEXT}=CAL:STUNDAS
        ?Button4{PROP:TEXT}=CAL:STUNDAS
        ?Button5{PROP:TEXT}=CAL:STUNDAS
        ?Button6{PROP:TEXT}=CAL:STUNDAS
        ?Button7{PROP:TEXT}=CAL:STUNDAS
        ?Button8{PROP:TEXT}=CAL:STUNDAS
        ?Button9{PROP:TEXT}=CAL:STUNDAS
        ?Button10{PROP:TEXT}=CAL:STUNDAS
        ?Button11{PROP:TEXT}=CAL:STUNDAS
        ?Button12{PROP:TEXT}=CAL:STUNDAS
        ?Button13{PROP:TEXT}=CAL:STUNDAS
        ?Button14{PROP:TEXT}=CAL:STUNDAS
        ?Button15{PROP:TEXT}=CAL:STUNDAS
        ?Button16{PROP:TEXT}=CAL:STUNDAS
        ?Button17{PROP:TEXT}=CAL:STUNDAS
        ?Button18{PROP:TEXT}=CAL:STUNDAS
        ?Button19{PROP:TEXT}=CAL:STUNDAS
        ?Button20{PROP:TEXT}=CAL:STUNDAS
        ?Button21{PROP:TEXT}=CAL:STUNDAS
        ?Button22{PROP:TEXT}=CAL:STUNDAS
        ?Button23{PROP:TEXT}=CAL:STUNDAS
        ?Button24{PROP:TEXT}=CAL:STUNDAS
        ?Button25{PROP:TEXT}=CAL:STUNDAS
        ?Button26{PROP:TEXT}=CAL:STUNDAS
        ?Button27{PROP:TEXT}=CAL:STUNDAS
        ?Button28{PROP:TEXT}=CAL:STUNDAS
        ?Button29{PROP:TEXT}=CAL:STUNDAS
        ?Button30{PROP:TEXT}=CAL:STUNDAS
        ?Button31{PROP:TEXT}=CAL:STUNDAS
        ?Button32{PROP:TEXT}=CAL:STUNDAS
        ?Button33{PROP:TEXT}=CAL:STUNDAS
        ?Button34{PROP:TEXT}=CAL:STUNDAS
        ?Button35{PROP:TEXT}=CAL:STUNDAS
        ?Button36{PROP:TEXT}=CAL:STUNDAS
        ?Button37{PROP:TEXT}=CAL:STUNDAS
     .
 .
