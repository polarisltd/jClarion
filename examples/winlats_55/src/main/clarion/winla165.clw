                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdatePamKat PROCEDURE


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
PAK_LOCK             STRING(6)
PAK_MEN_SK           BYTE
PAK_SAK_V            DECIMAL(10,2),DIM(6)
PAK_ATL_V            DECIMAL(10,2),DIM(6)
PAK_KOREKCIJA        DECIMAL(10,2),DIM(6)
PAK_GD_PR            BYTE,DIM(6)
SAK_VK               DECIMAL(10,2),DIM(6)
SAK_VKK              DECIMAL(10,2)
ATL_VK               DECIMAL(10,2),DIM(6)
ATL_VKK              DECIMAL(10,2)
NOLIETOJUMS          DECIMAL(10,2),DIM(6)
NOLIETOJUMSK         DECIMAL(10,2)
START_YYYY           DECIMAL(4)
END_YYYY             DECIMAL(4)
T_GADS               DECIMAL(4)
P_GADS               DECIMAL(4)
FING                 STRING(35)
Update::Reloop  BYTE
Update::Error   BYTE
History::PAK:Record LIKE(PAK:Record),STATIC
SAV::PAK:Record      LIKE(PAK:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
FormWindow           WINDOW('Nodokïu aprçíina karte'),AT(18,5,392,190),SYSTEM,GRAY,MDI
                       BUTTON('1995'),AT(3,3,26,12),USE(?Button1995),HIDE
                       BUTTON('1996'),AT(30,3,26,12),USE(?Button1996),HIDE
                       BUTTON('1997'),AT(57,3,26,12),USE(?Button1997),HIDE
                       BUTTON('1998'),AT(84,3,26,12),USE(?Button1998),HIDE
                       BUTTON('1999'),AT(111,3,26,12),USE(?Button1999),HIDE
                       BUTTON('2000'),AT(138,3,26,12),USE(?Button2000),HIDE
                       BUTTON('2001'),AT(165,3,26,12),USE(?Button2001),HIDE
                       BUTTON('2002'),AT(192,3,26,12),USE(?Button2002),HIDE
                       BUTTON('2003'),AT(219,3,26,12),USE(?Button2003),HIDE
                       BUTTON('2004'),AT(246,3,26,12),USE(?Button2004),HIDE
                       BUTTON('2005'),AT(273,3,26,12),USE(?Button2005),HIDE
                       BUTTON('2006'),AT(300,3,26,12),USE(?Button2006),HIDE
                       BUTTON('2007'),AT(327,3,26,12),USE(?Button2007),HIDE
                       BUTTON('2008'),AT(355,3,26,12),USE(?Button2008),HIDE
                       BUTTON('2009'),AT(2,17,26,12),USE(?Button2009),HIDE
                       BUTTON('2010'),AT(30,17,26,12),USE(?Button2010),HIDE
                       BUTTON('2011'),AT(57,17,26,12),USE(?Button2011),HIDE
                       BUTTON('2012'),AT(84,17,26,12),USE(?Button2012),HIDE
                       BUTTON('2013'),AT(111,17,26,12),USE(?Button2013),HIDE
                       BUTTON('2014'),AT(138,17,26,12),USE(?Button2014),HIDE
                       BUTTON('2015'),AT(165,17,26,12),USE(?Button2015),HIDE
                       BUTTON('2016'),AT(192,17,26,12),USE(?Button2016),HIDE
                       BUTTON('2017'),AT(219,17,26,12),USE(?Button2017),HIDE
                       BUTTON('2018'),AT(246,17,26,12),USE(?Button2018),HIDE
                       BUTTON('2019'),AT(273,17,26,12),USE(?Button2019),HIDE
                       BUTTON('2020'),AT(300,17,26,12),USE(?Button2020),HIDE
                       BUTTON('2021'),AT(327,17,26,12),USE(?Button2021),HIDE
                       BUTTON('2022'),AT(355,17,26,12),USE(?Button2022),HIDE
                       BUTTON('2023'),AT(2,31,26,12),USE(?Button2023),HIDE
                       BUTTON('2024'),AT(30,31,26,12),USE(?Button2024),HIDE
                       BUTTON('2025'),AT(57,31,26,12),USE(?Button2025),HIDE
                       BUTTON('2026'),AT(84,31,26,12),USE(?Button2026),HIDE
                       BUTTON('2027'),AT(111,31,26,12),USE(?Button2027),HIDE
                       BUTTON('2028'),AT(138,31,26,12),USE(?Button2028),HIDE
                       BUTTON('2029'),AT(165,31,26,12),USE(?Button2029),HIDE
                       BUTTON('2030'),AT(192,31,26,12),USE(?Button2030),HIDE
                       BUTTON('2031'),AT(219,31,26,12),USE(?Button2031),HIDE
                       BUTTON('2032'),AT(246,31,26,12),USE(?Button2032),HIDE
                       BUTTON('2033'),AT(273,31,26,12),USE(?Button2033),HIDE
                       BUTTON('2034'),AT(300,31,26,12),USE(?Button2034),HIDE
                       STRING(@n_4),AT(212,63),USE(T_GADS),FONT(,11,,FONT:bold,CHARSET:ANSI)
                       STRING(@s35),AT(235,63,147,10),USE(FING)
                       STRING('Mçneðu skaits atskaites periodâ'),AT(83,63),USE(?String23)
                       ENTRY(@n2),AT(192,63,15,10),USE(PAK_MEN_SK)
                       BUTTON('&OK'),AT(287,174,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('&Atlikt'),AT(332,174,40,12),USE(?Cancel)
                       STRING('Sâkotnçjâ vçrtîba'),AT(53,81),USE(?String2)
                       STRING('taks.per. beigâs'),AT(56,89),USE(?String2:2)
                       STRING('vçrtîba'),AT(120,89),USE(?String2:71)
                       STRING('(LIN atl.)'),AT(159,89),USE(?String2:9)
                       STRING('taks.per. beigâs'),AT(192,89),USE(?String2:6)
                       STRING('nodokïiem'),AT(251,89),USE(?String2:8)
                       STRING('Nolietojums'),AT(292,89),USE(?String2:10)
                       STRING('Izslçgðana'),AT(152,81),USE(?String2:4)
                       STRING('Atlikusî vçrt.'),AT(249,81),USE(?String2:7)
                       STRING('%'),AT(40,89),USE(?StringGD_PR)
                       STRING('Koriìçtâ vçrtîba'),AT(192,81),USE(?String2:5)
                       STRING('Atlikusî '),AT(120,81),USE(?String2:3)
                       PROMPT('&1'),AT(14,103),USE(?PAK:SAK_V:Prompt)
                       ENTRY(@n-14.2),AT(55,103,43,10),USE(PAK_SAK_V[1]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(101,103,43,10),USE(PAK_ATL_V[1]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(147,103,43,10),USE(PAK_KOREKCIJA[1]),DECIMAL(12)
                       STRING(@n-12.2),AT(193,103),USE(SAK_VK[1])
                       STRING(@n-12.2),AT(238,103),USE(ATL_VK[1])
                       BUTTON('Lock'),AT(335,102,26,12),USE(?ButtonLI)
                       IMAGE('CHECK1.ICO'),AT(362,101,12,13),USE(?ImageL1),HIDE,CENTERED
                       STRING(@n-14.2),AT(283,103),USE(NOLIETOJUMS[1])
                       ENTRY(@n3),AT(31,103,22,10),USE(PAK_GD_PR[1]),CENTER
                       STRING(@n-12.2),AT(238,115),USE(ATL_VK[2])
                       STRING(@n-14.2),AT(283,115),USE(NOLIETOJUMS[2])
                       BUTTON('Lock'),AT(335,114,26,12),USE(?ButtonLI:2)
                       IMAGE('CHECK1.ICO'),AT(362,114,12,12),USE(?ImageL2),HIDE,CENTERED
                       PROMPT('&2'),AT(14,115),USE(?PAK:SAK_V:Prompt:2)
                       ENTRY(@n2),AT(32,115,22,10),USE(PAK_GD_PR[2]),CENTER
                       ENTRY(@n-14.2),AT(55,115,43,10),USE(PAK_SAK_V[2]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(101,115,43,10),USE(PAK_ATL_V[2]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(147,115,43,10),USE(PAK_KOREKCIJA[2]),DECIMAL(12)
                       STRING(@n-12.2),AT(193,115),USE(SAK_VK[2])
                       PROMPT('&3'),AT(14,127),USE(?PAK:SAK_V:Prompt:3)
                       ENTRY(@n-14.2),AT(55,127,43,10),USE(PAK_SAK_V[3]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(101,127,43,10),USE(PAK_ATL_V[3]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(147,127,43,10),USE(PAK_KOREKCIJA[3]),DECIMAL(12)
                       STRING(@n-12.2),AT(193,127),USE(SAK_VK[3])
                       STRING(@n-12.2),AT(238,127),USE(ATL_VK[3])
                       STRING(@n-14.2),AT(283,127),USE(NOLIETOJUMS[3])
                       BUTTON('Lock'),AT(335,126,26,12),USE(?ButtonLI:3)
                       IMAGE('CHECK1.ICO'),AT(362,126,12,12),USE(?ImageL3),HIDE,CENTERED
                       ENTRY(@n2),AT(32,127,22,10),USE(PAK_GD_PR[3]),CENTER
                       PROMPT('&4'),AT(14,139),USE(?PAK:SAK_V:Prompt:4)
                       ENTRY(@n2),AT(32,139,22,10),USE(PAK_GD_PR[4]),CENTER
                       ENTRY(@n-14.2),AT(55,139,43,10),USE(PAK_SAK_V[4]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(101,139,43,10),USE(PAK_ATL_V[4]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(147,139,43,10),USE(PAK_KOREKCIJA[4]),DECIMAL(12)
                       STRING(@n-12.2),AT(193,139),USE(SAK_VK[4])
                       STRING(@n-12.2),AT(238,139),USE(ATL_VK[4])
                       STRING(@n-14.2),AT(283,139),USE(NOLIETOJUMS[4])
                       BUTTON('Lock'),AT(335,138,26,12),USE(?ButtonLI:4)
                       IMAGE('CHECK1.ICO'),AT(362,138,12,12),USE(?ImageL4),HIDE,CENTERED
                       PROMPT('&5'),AT(14,151),USE(?PAK:SAK_V:Prompt:5)
                       ENTRY(@n2),AT(32,151,22,10),USE(PAK_GD_PR[5]),CENTER
                       ENTRY(@n-14.2),AT(55,151,43,10),USE(PAK_SAK_V[5]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(101,151,43,10),USE(PAK_ATL_V[5]),DECIMAL(12)
                       ENTRY(@n-13.2),AT(147,151,43,10),USE(PAK_KOREKCIJA[5]),DECIMAL(12)
                       STRING(@n-12.2),AT(193,151),USE(SAK_VK[5])
                       STRING(@n-12.2),AT(238,151),USE(ATL_VK[5])
                       STRING(@n-14.2),AT(283,151),USE(NOLIETOJUMS[5])
                       BUTTON('Lock'),AT(335,150,26,12),USE(?ButtonLI:5)
                       IMAGE('CHECK1.ICO'),AT(362,150,12,12),USE(?ImageL5),HIDE,CENTERED
                       STRING(@n-12.2),AT(193,163,46,10),USE(SAK_VKK),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@n-12.2),AT(238,163),USE(ATL_VKK),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@n-14.2),AT(283,163),USE(NOLIETOJUMSK),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       BUTTON('&Pârrçíinât'),AT(218,174,64,12),USE(?CALC),DEFAULT,REQ
                     END
SHOWSCREEN WINDOW('Bûvçju sarakstu'),AT(,,122,42),CENTER,GRAY
       STRING(@N_4),AT(37,16),USE(T_GADS,,t_gads:1)
       STRING(@N_6),AT(59,16),USE(RAKSTI#)
     END

SKAITS      USHORT,DIM(6)
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(PAMAM,1)
  SET(AMO:YYYYMM_KEY)
  NEXT(PAMAM)
  START_YYYY=YEAR(AMO:YYYYMM)  ! pirmais iegâdâtais pamatlîdzeklis
  IF ~INRANGE(START_YYYY,1995,2009)
     START_YYYY=1995
  .
  END_YYYY=DB_GADS
  IF START_YYYY>END_YYYY THEN START_YYYY=END_YYYY. !JA NU...
  CHECKOPEN(PAMKAT,1)
  !CHECKOPEN(PAMAT,1)
  IF RECORDS(PAMKAT)=0
     KLUDA(0,'Tiks uzbûvçta P/L nolietojuma aprçíina kopsavilkuma karte no '&START_YYYY&'. lîdz '&END_YYYY&'. gadam')
     PAK:MEN_SKAITS :=: 12
     LOOP T_GADS=START_YYYY TO END_YYYY
         DO BUILD_T_GADS
     .
     ADD(PAMKAT)
  .
  SET(PAMKAT)
  NEXT(PAMKAT)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
    T_GADS=DB_GADS                      !DB_GADS NO GLOBAL
!    STOP(T_GADS)
    FING=GETFING(1,T_GADS)              !FINANSU GADA TEKSTS
    Y#=T_GADS-1995+1                    !GADA INDEKSS PAK:MASÎVÂ,PÇC ÐITÂ ARÎ SELECT
    PAK_MEN_SK=PAK:MEN_SKAITS[Y#]
    IF ~PAK_MEN_SK THEN PAK_MEN_SK=GETFING(4,T_GADS).
    LOOP I#=1 TO 5                      !AIZPILDAM EKRÂNA MAINÎGOS
      PAK_GD_PR[I#]=PAK:GD_PR[I#,Y#]
      PAK_SAK_V[I#]=PAK:SAK_V[I#,Y#]    !SÂK V BEZ KOREKCIJAS TEK.G.
      PAK_ATL_V[I#]=PAK:ATL_V[I#,Y#]    !ATL V BEZ KOREKCIJAS TEK.G.
      PAK_KOREKCIJA[I#]=PAK:KOREKCIJA[I#,Y#]
      SAK_VK[I#]=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
      ATL_VK[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
      NOLIETOJUMS[I#]=PAK:NOLIETOJUMS[I#,Y#]
    .
    PAK_LOCK=PAK:LOCK[Y#]
    LOOP I#=1 TO 5
       IF PAK_LOCK[I#]
          EXECUTE I#
             UNHIDE(?IMAGEL1)
             UNHIDE(?IMAGEL2)
             UNHIDE(?IMAGEL3)
             UNHIDE(?IMAGEL4)
             UNHIDE(?IMAGEL5)
          .
       .
    .
    LOOP I#=START_YYYY TO END_YYYY
       EXECUTE I#-1995+1
          UNHIDE(?BUTTON1995)
          UNHIDE(?BUTTON1996)
          UNHIDE(?BUTTON1997)
          UNHIDE(?BUTTON1998)
          UNHIDE(?BUTTON1999)
          UNHIDE(?BUTTON2000)
          UNHIDE(?BUTTON2001)
          UNHIDE(?BUTTON2002)
          UNHIDE(?BUTTON2003)
          UNHIDE(?BUTTON2004)
          UNHIDE(?BUTTON2005)
          UNHIDE(?BUTTON2006)
          UNHIDE(?BUTTON2007)
          UNHIDE(?BUTTON2008)
          UNHIDE(?BUTTON2009)
          UNHIDE(?BUTTON2010)
          UNHIDE(?BUTTON2011)
          UNHIDE(?BUTTON2012)
          UNHIDE(?BUTTON2013)
          UNHIDE(?BUTTON2014)
          UNHIDE(?BUTTON2015)
          !01/05/2015 <
          UNHIDE(?BUTTON2016)
          UNHIDE(?BUTTON2017)
          UNHIDE(?BUTTON2018)
          UNHIDE(?BUTTON2019)
          UNHIDE(?BUTTON2020)
          UNHIDE(?BUTTON2021)
          UNHIDE(?BUTTON2022)
          UNHIDE(?BUTTON2023)
          UNHIDE(?BUTTON2024)
          UNHIDE(?BUTTON2025)
          UNHIDE(?BUTTON2026)
          UNHIDE(?BUTTON2027)
          UNHIDE(?BUTTON2028)
          UNHIDE(?BUTTON2029)
          UNHIDE(?BUTTON2030)
          UNHIDE(?BUTTON2031)
          UNHIDE(?BUTTON2032)
          UNHIDE(?BUTTON2033)
          UNHIDE(?BUTTON2034)
          !01/05/2015 >
       .
    .
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  ENABLE(TBarBrwHistory)
  ACCEPT
    !01/05/2015 IF INRANGE(FIELD(),1,16) AND EVENT()=EVENT:ACCEPTED !MAINÂS GADS 1995-2010(max20=2014), AIZPILDAM NO FAILA
    IF INRANGE(FIELD(),1,40) AND EVENT()=EVENT:ACCEPTED !MAINÂS GADS 1995-2010(max20=2014), AIZPILDAM NO FAILA
      T_GADS=1995-1+FIELD()               !FIELD()=GADA POGAS
      Y#=T_GADS-1995+1                    !GADA INDEKSS PAK:MASÎVÂ
      FING=GETFING(1,T_GADS)              !FINANSU GADA TEKSTS
      PAK_MEN_SK=PAK:MEN_SKAITS[Y#]
      SAK_VKK=0
      ATL_VKK=0
      NOLIETOJUMSK=0
      LOOP I#=1 TO 5                      !AIZPILDAM EKRÂNA MAINÎGOS NO FAILA
        PAK_GD_PR[I#]=PAK:GD_PR[I#,Y#]
        PAK_SAK_V[I#]=PAK:SAK_V[I#,Y#]    !SÂK V BEZ KOREKCIJAS TEK.G
        PAK_ATL_V[I#]=PAK:ATL_V[I#,Y#]    !SÂK V BEZ KOREKCIJAS TEK.G.
        PAK_KOREKCIJA[I#]=PAK:KOREKCIJA[I#,Y#]
        SAK_VK[I#]=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
        ATL_VK[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
        NOLIETOJUMS[I#]=PAK:NOLIETOJUMS[I#,Y#]
        SAK_VKK+=SAK_VK[I#]
        ATL_VKK+=ATL_VK[I#]
        NOLIETOJUMSK+=NOLIETOJUMS[I#]
      .
      PAK_LOCK=PAK:LOCK[Y#]
      LOOP I#=1 TO 5
         IF PAK_LOCK[I#]
            EXECUTE I#
               UNHIDE(?IMAGEL1)
               UNHIDE(?IMAGEL2)
               UNHIDE(?IMAGEL3)
               UNHIDE(?IMAGEL4)
               UNHIDE(?IMAGEL5)
            .
         ELSE
            EXECUTE I#
               HIDE(?IMAGEL1)
               HIDE(?IMAGEL2)
               HIDE(?IMAGEL3)
               HIDE(?IMAGEL4)
               HIDE(?IMAGEL5)
            .
         .
      .
    .
    
    PAK:LOCK[Y#]=PAK_LOCK
    PAK:MEN_SKAITS[Y#]=PAK_MEN_SK
    LOOP I#=1 TO 5                      !AIZPILDAM FAILÂ EKRÂNA MAINÎGOS
      PAK:GD_PR[I#,Y#]=PAK_GD_PR[I#]
      PAK:SAK_V[I#,Y#]=PAK_SAK_V[I#]    !BEZ KOREKCIJAS TEK.G.
      PAK:ATL_V[I#,Y#]=PAK_ATL_V[I#]    !BEZ KOREKCIJAS TEK.G.
      PAK:KOREKCIJA[I#,Y#]=PAK_KOREKCIJA[I#]
    .
    DISPLAY
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
      SELECT(?Button1995)
      EXECUTE Y#
         SELECT(?Button1995)
         SELECT(?Button1996)
         SELECT(?Button1997)
         SELECT(?Button1998)
         SELECT(?Button1999)
         SELECT(?Button2000)
         SELECT(?Button2001)
         SELECT(?Button2002)
         SELECT(?Button2003)
         SELECT(?Button2004)
         SELECT(?Button2005)
         SELECT(?Button2006)
         SELECT(?Button2007)
         SELECT(?Button2008)
         SELECT(?Button2009)
         SELECT(?Button2010)
         !01/05/2015 <
         SELECT(?Button2011)
         SELECT(?Button2012)
         SELECT(?Button2013)
         SELECT(?Button2014)
         SELECT(?Button2015)
         SELECT(?Button2016)
         SELECT(?Button2017)
         SELECT(?Button2018)
         SELECT(?Button2019)
         SELECT(?Button2020)
         SELECT(?Button2021)
         SELECT(?Button2022)
         SELECT(?Button2023)
         SELECT(?Button2024)
         SELECT(?Button2025)
         SELECT(?Button2026)
         SELECT(?Button2027)
         SELECT(?Button2028)
         SELECT(?Button2029)
         SELECT(?Button2030)
         SELECT(?Button2031)
         SELECT(?Button2032)
         SELECT(?Button2033)
         SELECT(?Button2034)
         !01/05/2015 
      .
      DISPLAY
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
        History::PAK:Record = PAK:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(PAMKAT)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Button1995)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PAK:Record <> PAK:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAMKAT(1)
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
              SELECT(?Button1995)
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
    OF ?Button1995
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button1996
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button1997
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button1998
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button1999
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2000
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2001
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2002
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2003
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2004
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2005
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2006
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2007
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2008
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2009
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2010
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2011
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2012
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2013
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2014
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2015
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2016
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2017
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2018
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2019
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2020
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2021
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2022
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2023
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2024
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2025
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2026
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2027
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2028
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2029
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2030
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2031
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2032
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2033
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?Button2034
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?PAK_MEN_SK
      CASE EVENT()
      OF EVENT:Accepted
        IF ~INRANGE(PAK_MEN_SK,6,18)
           KLUDA(0, 'Mçneðu skaitam jâbût robeþâs no 6 lîdz 18')
           SELECT(?PAK_MEN_SK)
        .
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
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    OF ?ButtonLI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAK_LOCK[1]
           PAK_LOCK[1]=''
           HIDE(?IMAGEL1)
        ELSE
           PAK_LOCK[1]='1'
           UNHIDE(?IMAGEL1)
        .
      END
    OF ?ButtonLI:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAK_LOCK[2]
           PAK_LOCK[2]=''
           HIDE(?IMAGEL2)
        ELSE
           PAK_LOCK[2]='1'
           UNHIDE(?IMAGEL2)
        .
      END
    OF ?ButtonLI:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAK_LOCK[3]
           PAK_LOCK[3]=''
           HIDE(?IMAGEL3)
        ELSE
           PAK_LOCK[3]='1'
           UNHIDE(?IMAGEL3)
        .
      END
    OF ?ButtonLI:4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAK_LOCK[4]
           PAK_LOCK[4]=''
           HIDE(?IMAGEL4)
        ELSE
           PAK_LOCK[4]='1'
           UNHIDE(?IMAGEL4)
        .
      END
    OF ?ButtonLI:5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAK_LOCK[5]
           PAK_LOCK[5]=''
           HIDE(?IMAGEL5)
        ELSE
           PAK_LOCK[5]='1'
           UNHIDE(?IMAGEL5)
        .
      END
    OF ?CALC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          DO BUILD_T_GADS
          SAK_VKK=0
          ATL_VKK=0
          NOLIETOJUMSK=0
          LOOP I#=1 TO 5                           !AIZPILDAM EKRÂNA MAINÎGOS
            PAK_GD_PR[I#]=PAK:GD_PR[I#,Y#]
            PAK_SAK_V[I#]=PAK:SAK_V[I#,Y#]         !BEZ KOREKCIJAS TEK.G.
            PAK_ATL_V[I#]=PAK:ATL_V[I#,Y#]         !BEZ KOREKCIJAS TEK.G.
            PAK_KOREKCIJA[I#]=PAK:KOREKCIJA[I#,Y#]
            SAK_VK[I#]=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
            ATL_VK[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
            NOLIETOJUMS[I#]=PAK:NOLIETOJUMS[I#,Y#] !AR VISÂM KOREKCIJÂM
            SAK_VKK+=SAK_VK[I#]
            ATL_VKK+=ATL_VK[I#]
            NOLIETOJUMSK+=NOLIETOJUMS[I#]
          .
          DISPLAY
        
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAMKAT::Used = 0
    CheckOpen(PAMKAT,1)
  END
  PAMKAT::Used += 1
  BIND(PAK:RECORD)
  FilesOpened = True
  RISnap:PAMKAT
  SAV::PAK:Record = PAK:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:PAMKAT()
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
  INIRestoreWindow('UpdatePamKat','winlats.INI')
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
    PAMKAT::Used -= 1
    IF PAMKAT::Used = 0 THEN CLOSE(PAMKAT).
  END
  IF WindowOpened
    INISaveWindow('UpdatePamKat','winlats.INI')
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
BUILD_T_GADS  ROUTINE
 Y#=T_GADS-1995+1              !Y#-TEKOÐÂ GADA INDEKSS PAK:MASÎVÂ
 IF ~INRANGE(Y#,1,40)
    KLUDA(0,'GADA INDEKSS='&Y#)
    EXIT
 .
 LOOP I#=1 TO 6
    IF ~SUB(PAK:LOCK[Y#],I#,1)
       IF T_GADS>START_YYYY  !AIZPILDAM NO IEPRIEKÐÇJÂ GADA
          PAK:SAK_V[I#,Y#]=PAK:SAK_V[I#,Y#-1]-PAK:KOREKCIJA[I#,Y#-1]  !KORIÌÇTÂ SÂK.VÇRTÎBA IEPR.GADA BEIGÂS
          PAK:ATL_V[I#,Y#]=PAK:ATL_V[I#,Y#-1]-PAK:KOREKCIJA[I#,Y#-1]-PAK:NOLIETOJUMS[I#,Y#-1] !ATL.V. PÇC NOLIETOJUMA ATSKAITÎÐANAS
          PAK:GD_PR[I#,Y#]=PAK:GD_PR[I#,Y#-1]
       ELSE
          PAK:SAK_V[I#,Y#]=0
          PAK:ATL_V[I#,Y#]=0
       .
       PAK:IEG_V[I#,Y#]=0
       PAK:KAP_V[I#,Y#]=0
       PAK:PAR_V[I#,Y#]=0
       PAK:KOREKCIJA[I#,Y#]=0
    .
 .
! OPEN(SHOWSCREEN) ÐITAS VIÒU UZKARINA...
 RAKSTI#=0
 CLEAR(PAM:RECORD)
 SET(PAM:NR_KEY)
 LOOP
    NEXT(PAMAT)
    RAKSTI#+=1
!    DISPLAY
    IF ERROR() THEN BREAK.
    IF PAM:END_DATE AND YEAR(PAM:END_DATE)<T_GADS THEN CYCLE. !NOÒEMTS IEPRIEKÐÇJOS GADOS
    IF PAM:NERAZ THEN CYCLE.                                  !NEIZMANTO RAÞOÐANÂ (LIKUIN 66.p.)
    IF PAM:GD_PR[1]=0 THEN CYCLE.                             !0-es GD NOLIETOJUMS, VISDRÎZÂK ZEME (LIKUIN 13.p.)
    IF YEAR(PAM:EXPL_DATUMS)>T_GADS THEN CYCLE.               !VÇL NEKAS NETIEK RÇÍINÂTS

    IF PAM:EXPL_DATUMS>=DATE(1,1,1995)
       YP#   =T_GADS-YEAR(PAM:EXPL_DATUMS)+1                     !GADA INDEKSS PAM:MASÎVÂ
       P_GADS=YEAR(PAM:EXPL_DATUMS)
    ELSE
       YP#   =1
       P_GADS=1995
    .
    IF PAM:KAT[YP#] AND ~(SUB(PAM:KAT[YP#],1,1)=SUB(PAM:KAT[1],1,1))
       KLUDA(0,'Neatïauta kategorijas maiòa '&CLIP(PAM:NOS_P)&' '&YEAR(PAM:EXPL_DATUMS)+YP#-1&'.g.')
    .
    K#=SUB(PAM:KAT[YP#],1,1) !PAM:KAT DIM(20)
    SKAITS[K#]+=1
    IF ~INRANGE(K#,1,5) THEN K#=6.
    IF ~SUB(PAK:LOCK[Y#],K#,1) !~LOCKED
       IF P_GADS=T_GADS   !ÐOGAD JÂSÂK RÇÍINÂT LI UN GD
          PAK:IEG_V[K#,Y#]+=PAM:BIL_V
          PAK:SAK_V[K#,Y#]+=PAM:BIL_V
          PAK:ATL_V[K#,Y#]+=PAM:BIL_V
          PAK:GD_PR[K#,Y#]=PAM:GD_PR[1]  !?
       .
       CLEAR(AMO:RECORD)
       AMO:U_NR=PAM:U_NR
       AMO:YYYYMM=DATE(1,1,T_GADS)
       SET(AMO:NR_KEY,AMO:NR_KEY)
       LOOP
          NEXT(PAMAM)
          IF ERROR() THEN BREAK.
          IF ~(AMO:U_NR=PAM:U_NR AND AMO:YYYYMM<=DATE(12,1,T_GADS)) THEN BREAK.
          PAK:KAP_V[K#,Y#]+=AMO:KAPREM
          PAK:PAR_V[K#,Y#]+=AMO:PARCEN
          PAK:SAK_V[K#,Y#]+=AMO:KAPREM+AMO:PARCEN
          PAK:ATL_V[K#,Y#]+=AMO:KAPREM+AMO:PARCEN
!          IF INRANGE(PAM:END_DATE,DATE(1,1,T_GADS),DATE(12,31,T_GADS)) !NOÒEMTS ÐAJÂ GADÂ
          IF AMO:IZSLEGTS
             PAK:KOREKCIJA[K#,Y#]+=AMO:IZSLEGTS-AMO:NOL_U_LI-AMO:NOL_LIN
          .
       .
    .
 .
 LOOP I#=1 TO 6
    IF PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#] <0  !PAK:ATL_V IR ÒEMOT VÇRÂ IEPR,G.NOLIETOJUMU
       PAK:NOLIETOJUMS[I#,Y#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
    ELSE   !RÇÍINAM TEKOÐÂ GADA NOLIETOJUMU
       PAK:NOLIETOJUMS[I#,Y#]=ROUND((PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#])*PAK:GD_PR[I#,Y#]*2*(PAK:MEN_SKAITS[Y#]/12)/100,.01)
    .
    IF PAK:NOLIETOJUMS[I#,Y#] < 0
       KLUDA(0,'Par summu Ls '&ABS(PAK:NOLIETOJUMS[I#,Y#])&'  '&CLIP(I#)&'.kategorijai Jums bûs jâpalielina apliekamais ienâkums...')
    ELSIF PAK:ATL_V[I#,Y#] AND (SKAITS[I#]=0)
       KLUDA(0,CLIP(I#)&'.kategorijâ nav palicis neviens P/L,  izmaksâs liekam atlikuðo vçrtîbu....')
       PAK:NOLIETOJUMS[I#,Y#]=PAK:ATL_V[I#,Y#]
    ELSIF PAK:ATL_V[I#,Y#]<PAK:NOLIETOJUMS[I#,Y#]
       KLUDA(0,CLIP(I#)&'.kategorijas nolietojums ir lielâks par atlikuðo vçrtîbu, izmaksâs liekam atl.vçrt....')
       PAK:NOLIETOJUMS[I#,Y#]=PAK:ATL_V[I#,Y#]
    ELSIF PAK:ATL_V[I#,Y#] AND (PAK:ATL_V[I#,Y#]-PAK:NOLIETOJUMS[I#,Y#] <= 50)
       KLUDA(0,CLIP(I#)&'.kat. atlikusî vçrt. pçc nolietoj. atsk. ir Ls '&CLIP(PAK:ATL_V[I#,Y#]-PAK:NOLIETOJUMS[I#,Y#])&' ,visu liekam uz izmaksâm')
       PAK:NOLIETOJUMS[I#,Y#]=PAK:ATL_V[I#,Y#]
    .
    IF T_GADS=START_YYYY
       PAK:U_NOLIETOJUMS[I#,Y#]=PAK:NOLIETOJUMS[I#,Y#]  !UZKRÂTAIS NOLIETOJUMS GADA BEIGÂS
    ELSE
!       PAK:U_NOLIETOJUMS[I#,Y#]=PAK:U_NOLIETOJUMS[I#,Y#-1]+PAK:NOLIETOJUMS[I#,Y#] !JA TAS UZKRÂTAIS NOLIETOJUMS NOJÛK, VIÒU NEVAR IZLABOT
       PAK:U_NOLIETOJUMS[I#,Y#]=PAK:SAK_V[I#,Y#]-PAK:ATL_V[I#,Y#]+PAK:NOLIETOJUMS[I#,Y#]
!      STOP('I='&I#&' '&PAK:U_NOLIETOJUMS[I#,Y#]&'='&PAK:U_NOLIETOJUMS[I#,Y#-1]&'+'&PAK:NOLIETOJUMS[I#,Y#])
    .
 .

 PAK_MEN_SK=PAK:MEN_SKAITS[Y#]       !AIZPILDAM EKRÂNA MAINÎGOS NO FAILA
 PAK_LOCK=PAK:LOCK[Y#]
 SAK_VKK=0
 ATL_VKK=0
 NOLIETOJUMSK=0
 LOOP I#=1 TO 5
   PAK_GD_PR[I#]=PAK:GD_PR[I#,Y#]
   PAK_SAK_V[I#]=PAK:SAK_V[I#,Y#]    !SÂK V BEZ KOREKCIJAS TEK.G
   PAK_ATL_V[I#]=PAK:ATL_V[I#,Y#]    !SÂK V BEZ KOREKCIJAS TEK.G.
   PAK_KOREKCIJA[I#]=PAK:KOREKCIJA[I#,Y#]
   SAK_VK[I#]=PAK:SAK_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
   ATL_VK[I#]=PAK:ATL_V[I#,Y#]-PAK:KOREKCIJA[I#,Y#]
   NOLIETOJUMS[I#]=PAK:NOLIETOJUMS[I#,Y#]
   SAK_VKK+=SAK_VK[I#]
   ATL_VKK+=ATL_VK[I#]
   NOLIETOJUMSK+=NOLIETOJUMS[I#]
 .
! CLOSE(SHOWSCREEN)
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
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
  PAK:Record = SAV::PAK:Record
  SAV::PAK:Record = PAK:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    RecordChanged = False
    IF LocalRequest = InsertRecord OR LocalRequest = ChangeRecord
      IF SAV::PAK:Record <> PAK:Record
        RecordChanged = True
      END
    END
    IF RecordChanged
      CASE StandardWarning(Warn:SaveOnCancel)
      OF Button:Yes
        POST(Event:Accepted,?OK)
        Update::Reloop = 1
        EXIT
      OF Button:No
      OF BUTTON:Cancel
        SELECT(?Button1995)
        Update::Reloop = 1
        EXIT
      END
    END
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

P_KARGD              PROCEDURE                    ! Declare Procedure
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

DAT                  LONG
LAI                  LONG

G                    DECIMAL(4)
KAT_NR               STRING(3)
LIKME                BYTE
IEPVERT              DECIMAL(9,2)
KAPREM               DECIMAL(9,2)
PARVERT              DECIMAL(9,2)
GD_KOEF              DECIMAL(4,1)
SAKVERT              DECIMAL(9,2)
NOLIETOJUMS          DECIMAL(9,2)
ATLIKUMS             DECIMAL(9,2)
NONEMTS              DECIMAL(9,2)
!12/05/2014 KAPREM_M             DECIMAL(9,2),DIM(20)
!12/05/2014 PARVERT_M            DECIMAL(9,2),DIM(20)
KAPREM_M             DECIMAL(9,2),DIM(40)
PARVERT_M            DECIMAL(9,2),DIM(40)
pam_expl_gads        DECIMAL(4)
OLDPAM_TEXT          STRING(80)

Process:View         VIEW(PAMAM)
                       PROJECT(AMO:U_NR)
                       PROJECT(AMO:YYYYMM)
                       PROJECT(AMO:LIN_G_PR)
                       PROJECT(AMO:NODALA)
                       PROJECT(AMO:SAK_V_LI)
                       PROJECT(AMO:NOL_LIN)
                       PROJECT(AMO:NOL_G_LI)
                       PROJECT(AMO:NOL_U_LI)
                       PROJECT(AMO:KAPREM)
                       PROJECT(AMO:PARCEN)
                       PROJECT(AMO:PARCENLI)
                       PROJECT(AMO:IZSLEGTS)
                       PROJECT(AMO:SKAITS)
                     END

report REPORT,AT(500,2323,12000,5500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(500,250,12000,2073),USE(?unnamed:2)
         LINE,AT(5573,1563,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6406,1563,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7240,1563,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(2292,1563,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(3073,1563,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3906,1563,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@n4b),AT(1875,1094,417,208),USE(pam:izg_gad),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes datums, dok. Nr :'),AT(365,1302,1771,208),USE(?String7:4),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@d06.),AT(2135,1302,885,208),USE(pam:datums),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s14),AT(3125,1302,625,208),USE(pam:dok_SEnr),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(3802,1302,5313,208),USE(OLDPAM_TEXT),TRN,LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Likme'),AT(1542,1615,729,208),USE(?String7:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodaïa'),AT(2344,1615,729,208),USE(?String7:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,9583,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Periods'),AT(260,1615,521,208),USE(?String18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,1563,0,521),USE(?Line2:12),COLOR(COLOR:Black)
         STRING('vai raþ. pi.'),AT(3125,1823,781,208),USE(?String18:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('izmaksas'),AT(3958,1823,781,208),USE(?String18:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('+ / -'),AT(4792,1823,781,208),USE(?String18:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(6458,1823,781,208),USE(?String18:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba'),AT(8958,1823,781,208),USE(?String18:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('%'),AT(1542,1823,729,208),USE(?LIKMETEX),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2031,9583,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Atlikusî'),AT(8958,1615,781,208),USE(?String18:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8073,1563,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(8906,1563,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(9792,1563,0,521),USE(?Line2:11),COLOR(COLOR:Black)
         STRING('Nolietojums'),AT(8125,1719,781,208),USE(?String18:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('GD koeficients'),AT(7260,1719,802,208),USE(?String60),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ'),AT(6458,1615,781,208),USE(?String18:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izslçgðana'),AT(5625,1615,781,208),USE(?String18:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Pârvçrtçðana'),AT(4792,1615,781,208),USE(?String18:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4740,1563,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('Kapitâlâs'),AT(3958,1615,781,208),USE(?String18:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Iegâdes izm.'),AT(3125,1615,781,208),USE(?String18:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1563,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING('Izgatavoðanas gads :'),AT(365,1094,1510,208),USE(?String7:3),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING('Kategorija'),AT(833,1615,677,208),USE(?String7:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1510,1563,0,521),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@s45),AT(3729,104,4531,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('PAMATLÎDZEKÏA ANALÎTISKÂS UZSKAITES UN NOLIETOJUMA APRÇÍINA KARTE Nr'),AT(2854,365), |
             USE(?String2),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_6),AT(9167,365),USE(PAM:U_NR),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(3958,625),USE(?String4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(4167,625),USE(gads),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('. gadu   (ÌD metode, neòemot vçrâ korekcijas)'),AT(4625,615,3490,260),USE(?String4:2), |
             LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums :'),AT(365,885,1042,208),USE(?String7),LEFT,FONT(,11,,,CHARSET:BALTIC)
         STRING(@s35),AT(1406,885,3073,208),USE(pam:nos_p),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         STRING(@N-_11.2B),AT(5625,0,,156),USE(NONEMTS),RIGHT
         LINE,AT(6406,-10,0,198),USE(?Line3:1),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6458,0,,156),USE(SAKVERT),RIGHT
         LINE,AT(7240,-10,0,198),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(8125,0,,156),USE(NOLIETOJUMS),RIGHT
         LINE,AT(8073,-10,0,198),USE(?Line3:3),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,198),USE(?Line3:4),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(8958,0,,156),USE(ATLIKUMS),RIGHT
         STRING(@N3.1B),AT(7594,0,,156),USE(GD_KOEF),CENTER
         STRING(@N_2),AT(1823,0,208,156),USE(LIKME)
         STRING(@S2),AT(2552,0,208,156),USE(AMO:NODALA),CENTER
         STRING(@N4),AT(333,0,,156),USE(G)
         STRING(@p#-##p),AT(958,0,417,156),USE(kat_nr),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,-10,0,198),USE(?Line3:12),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,198),USE(?Line3:112),COLOR(COLOR:Black)
         LINE,AT(9792,-10,0,198),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(208,156,9583,0),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(3073,-10,0,198),USE(?Line3:7),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(3125,0,,156),USE(IEPVERT),RIGHT
         LINE,AT(3906,-10,0,198),USE(?Line3:8),COLOR(COLOR:Black)
         STRING(@N-_12.2B),AT(3938,0,,156),USE(KAPREM),RIGHT
         LINE,AT(4740,-10,0,198),USE(?Line3:9),COLOR(COLOR:Black)
         STRING(@N-_11.2B),AT(4792,0,,156),USE(PARVERT),RIGHT
         LINE,AT(5573,-10,0,198),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(208,-10,0,198),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,198),USE(?Line3:121),COLOR(COLOR:Black)
       END
RepFooT DETAIL,AT(,-10,,250),USE(?unnamed)
         LINE,AT(208,0,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(781,0,0,63),USE(?Line52:2),COLOR(COLOR:Black)
         LINE,AT(1510,0,0,63),USE(?Line52:3),COLOR(COLOR:Black)
         LINE,AT(2292,0,0,63),USE(?Line52),COLOR(COLOR:Black)
         LINE,AT(3073,0,0,63),USE(?Line53),COLOR(COLOR:Black)
         LINE,AT(3906,0,0,63),USE(?Line54),COLOR(COLOR:Black)
         LINE,AT(4740,0,0,63),USE(?Line55),COLOR(COLOR:Black)
         LINE,AT(5573,0,0,63),USE(?Line56),COLOR(COLOR:Black)
         LINE,AT(6406,0,0,63),USE(?Line57),COLOR(COLOR:Black)
         LINE,AT(7240,0,0,63),USE(?Line58),COLOR(COLOR:Black)
         LINE,AT(8073,0,0,63),USE(?Line59),COLOR(COLOR:Black)
         LINE,AT(8906,0,0,63),USE(?Line60),COLOR(COLOR:Black)
         LINE,AT(9792,0,0,63),USE(?Line61),COLOR(COLOR:Black)
         LINE,AT(208,52,9583,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@D06.),AT(8750,73),USE(DAT),TRN,FONT(,7,,,CHARSET:ANSI)
         STRING(@T1),AT(9396,73),USE(LAI),TRN,FONT(,7,,,CHARSET:ANSI)
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
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND(AMO:RECORD)
  BIND('GADS',GADS)
  BIND('PAM:U_NR',PAM:U_NR)

  IF YEAR(PAM:EXPL_DATUMS) < 1995 !PASAULES SÂKUMS 1995.G.
     pam_expl_gads=1995
     OLDPAM_TEXT=' Vçrtîbas izmaiòu un nolietojuma summa uz 01.01.1995 = '&CLIP(LEFT(FORMAT(PAM:KAP_V+PAM:NOL_V,@N10.2)))
  ELSE
     pam_expl_gads=YEAR(PAM:EXPL_DATUMS)
  .
  DAT=TODAY()
  LAI=CLOCK()

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAM)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P/L Karte (ÌD)'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAM,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(AMO:RECORD)
      SET(AMO:NR_KEY,AMO:NR_KEY) !LAI DABÛTU KAPREM UN PÂRCENOÐANU
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
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF YEAR(AMO:YYYYMM)>=1995 !VECIEM PL 1.(TUKÐAIS IR 1994.)
           I#=YEAR(AMO:YYYYMM)-pam_expl_gads+1
!           IF ~INRANGE(I#,1,15)
           !12/05/2015 IF ~INRANGE(I#,1,20)
           IF ~INRANGE(I#,1,40)
              KLUDA(0,'Gada indekss = '&I#)
           ELSE
              KAPREM_M[I#]+=AMO:KAPREM
              PARVERT_M[I#]+=AMO:PARCEN
              END_GADS#=YEAR(AMO:YYYYMM) !LAI ZINÂTU, CIK TÂLU IR SARÇÍINÂTS
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
  IF SEND(PAMAM,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=1 TO 20
       IF YEAR(PAM:DATUMS) < 1995 !PASAULES SÂKUMS 1995.G.
          G=1994+I#
       ELSE
          G=YEAR(PAM:DATUMS)-1+I#
       .
!       STOP(G&'>'&YEAR(PAM:END_DATE)&' '&G&'>'&END_GADS#)
       IF (PAM:END_DATE AND G>YEAR(PAM:END_DATE)) OR G>END_GADS# THEN BREAK.
       KAT_NR=PAM:KAT[I#]
       LIKME=PAM:GD_PR[I#]
       IF I#=1
          IEPVERT=PAM:IEP_V
       ELSE
          IEPVERT=0
       .
       KAPREM=KAPREM_M[I#]
       PARVERT=PARVERT_M[I#]
       GD_KOEF=PAM:GD_KOEF[I#]
       SAKVERT=PAM:SAK_V_GD[I#]
       NOLIETOJUMS=PAM:NOL_GD[I#]
       ATLIKUMS=SAKVERT-NOLIETOJUMS
       IF YEAR(PAM:END_DATE)=G
          NONEMTS=ATLIKUMS
          ATLIKUMS=0
       .
       PRINT(RPT:DETAIL)
    .
    PRINT(RPT:REPFOOT)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
!    IF F:DBF='W'
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
!    ELSE
!        CLOSE(OUTFILEANSI)
!        RUN('WORDPAD '&ANSIFILENAME)
!        IF RUNCODE()=-4
!            KLUDA(88,'Wordpad.exe')
!        .
!    .
  END
!  IF F:DBF='W'
      CLOSE(report)
      FREE(PrintPreviewQueue)
      FREE(PrintPreviewQueue1)
!  ELSE
!      ANSIFILENAME=''
!  END
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
P_NolAprM            PROCEDURE                    ! Declare Procedure
VERT_S               REAL
VERT_I               REAL
SAV_NOD              STRING(2)
SAV_NG               STRING(4)
SAK                  DECIMAL(10,2),DIM(14)
NOL                  DECIMAL(10,2),DIM(14)
UZK                  DECIMAL(10,2),DIM(14)
NOD                  STRING(2),DIM(14)
irnodala             byte
likme                sreal
B_TABLE              QUEUE,PRE(B)
BKK                  STRING(5)
verts1               DECIMAL(10,2)
verts2               DECIMAL(10,2)
verts3               DECIMAL(10,2)
verts4               DECIMAL(10,2)
verts5               DECIMAL(10,2)
verts6               DECIMAL(10,2)
verts7               DECIMAL(10,2)
verts8               DECIMAL(10,2)
verts9               DECIMAL(10,2)
verts10              DECIMAL(10,2)
verts11              DECIMAL(10,2)
verts12              DECIMAL(10,2)
verts13              DECIMAL(10,2)
verts14              DECIMAL(10,2)
vertN1               DECIMAL(10,2)
vertn2               DECIMAL(10,2)
vertn3               DECIMAL(10,2)
vertn4               DECIMAL(10,2)
vertn5               DECIMAL(10,2)
vertn6               DECIMAL(10,2)
vertn7               DECIMAL(10,2)
vertn8               DECIMAL(10,2)
vertn9               DECIMAL(10,2)
vertn10              DECIMAL(10,2)
vertn11              DECIMAL(10,2)
vertn12              DECIMAL(10,2)
vertn13              DECIMAL(10,2)
vertN14              DECIMAL(10,2)
vertB1               DECIMAL(10,2)
vertB2               DECIMAL(10,2)
vertB3               DECIMAL(10,2)
vertB4               DECIMAL(10,2)
vertB5               DECIMAL(10,2)
vertB6               DECIMAL(10,2)
vertB7               DECIMAL(10,2)
vertB8               DECIMAL(10,2)
vertB9               DECIMAL(10,2)
vertB10              DECIMAL(10,2)
vertB11              DECIMAL(10,2)
vertB12              DECIMAL(10,2)
vertB13              DECIMAL(10,2)
vertB14              DECIMAL(10,2)
                     .
BKK                  STRING(5)
verts1               DECIMAL(10,2)
verts2               DECIMAL(10,2)
verts3               DECIMAL(10,2)
verts4               DECIMAL(10,2)
verts5               DECIMAL(10,2)
verts6               DECIMAL(10,2)
verts7               DECIMAL(10,2)
verts8               DECIMAL(10,2)
verts9               DECIMAL(10,2)
verts10              DECIMAL(10,2)
verts11              DECIMAL(10,2)
verts12              DECIMAL(10,2)
verts13              DECIMAL(10,2)
verts14              DECIMAL(10,2)
vertN1               DECIMAL(10,2)
vertn2               DECIMAL(10,2)
vertn3               DECIMAL(10,2)
vertn4               DECIMAL(10,2)
vertn5               DECIMAL(10,2)
vertn6               DECIMAL(10,2)
vertn7               DECIMAL(10,2)
vertn8               DECIMAL(10,2)
vertn9               DECIMAL(10,2)
vertn10              DECIMAL(10,2)
vertn11              DECIMAL(10,2)
vertn12              DECIMAL(10,2)
vertn13              DECIMAL(10,2)
vertN14              DECIMAL(10,2)
vertB1               DECIMAL(10,2)
vertB2               DECIMAL(10,2)
vertB3               DECIMAL(10,2)
vertB4               DECIMAL(10,2)
vertB5               DECIMAL(10,2)
vertB6               DECIMAL(10,2)
vertB7               DECIMAL(10,2)
vertB8               DECIMAL(10,2)
vertB9               DECIMAL(10,2)
vertB10              DECIMAL(10,2)
vertB11              DECIMAL(10,2)
vertB12              DECIMAL(10,2)
vertB13              DECIMAL(10,2)
vertB14              DECIMAL(10,2)
verts1K              DECIMAL(10,2)
verts2K              DECIMAL(10,2)
verts3K              DECIMAL(10,2)
verts4K              DECIMAL(10,2)
verts5K              DECIMAL(10,2)
verts6K              DECIMAL(10,2)
verts7K              DECIMAL(10,2)
verts8K              DECIMAL(10,2)
verts9K              DECIMAL(10,2)
verts10K             DECIMAL(10,2)
verts11K             DECIMAL(10,2)
verts12K             DECIMAL(10,2)
verts13K             DECIMAL(10,2)
verts14K             DECIMAL(10,2)
vertN1K              DECIMAL(10,2)
vertn2K              DECIMAL(10,2)
vertn3K              DECIMAL(10,2)
vertn4K              DECIMAL(10,2)
vertn5K              DECIMAL(10,2)
vertn6K              DECIMAL(10,2)
vertn7K              DECIMAL(10,2)
vertn8K              DECIMAL(10,2)
vertn9K              DECIMAL(10,2)
vertn10K             DECIMAL(10,2)
vertn11K             DECIMAL(10,2)
vertn12K             DECIMAL(10,2)
vertn13K             DECIMAL(10,2)
vertN14K             DECIMAL(10,2)
vertB1K              DECIMAL(10,2)
vertB2K              DECIMAL(10,2)
vertB3K              DECIMAL(10,2)
vertB4K              DECIMAL(10,2)
vertB5K              DECIMAL(10,2)
vertB6K              DECIMAL(10,2)
vertB7K              DECIMAL(10,2)
vertB8K              DECIMAL(10,2)
vertB9K              DECIMAL(10,2)
vertB10K             DECIMAL(10,2)
vertB11K             DECIMAL(10,2)
vertB12K             DECIMAL(10,2)
vertB13K             DECIMAL(10,2)
vertB14K             DECIMAL(10,2)
verts1B              DECIMAL(10,2)
verts2B              DECIMAL(10,2)
verts3B              DECIMAL(10,2)
verts4B              DECIMAL(10,2)
verts5B              DECIMAL(10,2)
verts6B              DECIMAL(10,2)
verts7B              DECIMAL(10,2)
verts8B              DECIMAL(10,2)
verts9B              DECIMAL(10,2)
verts10B             DECIMAL(10,2)
verts11B             DECIMAL(10,2)
verts12B             DECIMAL(10,2)
verts13B             DECIMAL(10,2)
verts14B             DECIMAL(10,2)
vertN1B              DECIMAL(10,2)
vertn2B              DECIMAL(10,2)
vertn3B              DECIMAL(10,2)
vertn4B              DECIMAL(10,2)
vertn5B              DECIMAL(10,2)
vertn6B              DECIMAL(10,2)
vertn7B              DECIMAL(10,2)
vertn8B              DECIMAL(10,2)
vertn9B              DECIMAL(10,2)
vertn10B             DECIMAL(10,2)
vertn11B             DECIMAL(10,2)
vertn12B             DECIMAL(10,2)
vertn13B             DECIMAL(10,2)
vertN14B             DECIMAL(10,2)
vertB1B              DECIMAL(10,2)
vertB2B              DECIMAL(10,2)
vertB3B              DECIMAL(10,2)
vertB4B              DECIMAL(10,2)
vertB5B              DECIMAL(10,2)
vertB6B              DECIMAL(10,2)
vertB7B              DECIMAL(10,2)
vertB8B              DECIMAL(10,2)
vertB9B              DECIMAL(10,2)
vertB10B             DECIMAL(10,2)
vertB11B             DECIMAL(10,2)
vertB12B             DECIMAL(10,2)
vertB13B             DECIMAL(10,2)
vertB14B             DECIMAL(10,2)
NODALA               STRING(2)
KAT_NR               STRING(4)
ATL_DATUMS1          LONG
ATL_DATUMS2          LONG
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
                       PROJECT(PAM:BIL_V)
                       PROJECT(PAM:BKK)
                       PROJECT(PAM:BKKN)
                       PROJECT(PAM:DATUMS)
                       PROJECT(PAM:DOK_SENR)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:IEP_V)
                       PROJECT(PAM:IZG_GAD)
                       PROJECT(PAM:KAP_V)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:LIN_G_PR)
                       PROJECT(PAM:NODALA)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:NOS_A)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOS_S)
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:ATB_NR)
                       PROJECT(PAM:SKAITS)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(500,2146,10000,7000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),LANDSCAPE,THOUS
       HEADER,AT(500,104,10000,2021)
         STRING(@s45),AT(2344,156,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Pamatlîdzekïu nolietojuma aprçíins par'),AT(2708,469,2969,260),USE(?String2),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(5677,469,438,260),USE(gads),RIGHT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('. gadu'),AT(6146,469,573,260),USE(?String2:2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodaïa :'),AT(3646,729,625,260),USE(?String2:3),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s2),AT(4271,729,240,260),USE(nodala),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('(Lineârâ metode)'),AT(4583,729,1354,260),USE(?String2:4),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1094,9479,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(1094,1094,0,938),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Sâk. vçrt.'),AT(313,1146,781,208),USE(?String8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ vçrtîba uz mçneða 1. datumu'),AT(2813,1146,3177,208),USE(?String8:4),LEFT, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkr. nol.'),AT(313,1354,781,208),USE(?String8:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nolietojums par mçnesi'),AT(2813,1354,3177,208),USE(?String8:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atl. vçrt.'),AT(313,1563,781,208),USE(?String8:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikusî vçrtîba (sâkotnçjâ-uzkraitais nolietojums)'),AT(2813,1563,3177,208),USE(?String8:6), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(313,1771,781,208),USE(atl_datums1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Janvâris'),AT(1146,1771,625,208),USE(?String8:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Februâris'),AT(1771,1771,625,208),USE(?String8:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Marts'),AT(2396,1771,625,208),USE(?String8:9),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Aprîlis'),AT(3021,1771,625,208),USE(?String8:10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Maijs'),AT(3646,1771,625,208),USE(?String8:11),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Jûnijs'),AT(4271,1771,625,208),USE(?String8:12),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Jûlijs'),AT(4896,1771,625,208),USE(?String8:13),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Augusts'),AT(5521,1771,625,208),USE(?String8:14),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Septembris'),AT(6146,1771,729,208),USE(?String8:15),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Oktobris'),AT(6875,1771,625,208),USE(?String8:16),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Novembris'),AT(7500,1771,677,208),USE(?String8:17),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Decembris'),AT(8177,1771,729,208),USE(?String8:18),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(8958,1771,781,208),USE(atl_datums2),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1979,9479,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(9740,1094,0,938),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Atl. vçrt.'),AT(8958,1563,781,208),USE(?String8:21),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Uzkr. nol.'),AT(8958,1354,781,208),USE(?String8:20),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,1094,0,938),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Sâk. vçrt.'),AT(8958,1146,781,208),USE(?String8:19),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,1094,0,938),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,875)
         STRING(@N_9.2),AT(469,625),USE(VERTB1),RIGHT 
         STRING(@N_9.2),AT(1146,625),USE(VERTB2),RIGHT 
         STRING(@N_9.2),AT(1771,625),USE(VERTB3),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,625),USE(VERTB4),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,625),USE(VERTB5),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,625),USE(VERTB6),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,625),USE(VERTB7),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,625),USE(VERTB8),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,625),USE(VERTB9),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,625),USE(VERTB10),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,625),USE(VERTB11),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,625),USE(VERTB12),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,625),USE(VERTB13),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,625),USE(VERTB14),RIGHT,FONT(,8,,)
         LINE,AT(260,-10,0,905),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,905),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,905),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,905),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(260,833,9479,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@n_6),AT(2573,0,417,156),USE(pam:U_nr),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(3021,0,31,156),USE(?String164),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(3146,0,2240,156),USE(pam:nos_p),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@d6),AT(5438,0,625,156),USE(pam:datums),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@p#-##p),AT(6167,0,313,156),USE(kat_nr),RIGHT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,156,7813,0),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(469,208),USE(VERTS1),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,208),USE(VERTS2),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,208),USE(VERTS3),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,208),USE(VERTS4),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,208),USE(VERTS5),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,208),USE(VERTS6),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,208),USE(VERTS7),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,208),USE(VERTS8),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,208),USE(VERTS9),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,208),USE(VERTS10),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,208),USE(VERTS11),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,208),USE(VERTS12),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,208),USE(VERTS13),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,208),USE(VERTS14),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(469,417),USE(VERTN1),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,417),USE(VERTN2),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,417),USE(VERTN3),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,417),USE(VERTN4),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,417),USE(VERTN5),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,417),USE(VERTN6),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,417),USE(VERTN7),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,417),USE(VERTN8),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,417),USE(VERTN9),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,417),USE(VERTN10),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,417),USE(VERTN11),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,417),USE(VERTN12),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,417),USE(VERTN13),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,417),USE(VERTN14),RIGHT,FONT(,8,,)
       END
RptFoot DETAIL,AT(,,,875)
         STRING(@N_9.2),AT(469,625),USE(VERTB1K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,625),USE(VERTB2K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,625),USE(VERTB3K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,625),USE(VERTB4K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,625),USE(VERTB5K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,625),USE(VERTB6K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,625),USE(VERTB7K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,625),USE(VERTB8K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,625),USE(VERTB9K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,625),USE(VERTB10K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,625),USE(VERTB11K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,625),USE(VERTB12K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,625),USE(VERTB13K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,625),USE(VERTB14K),RIGHT,FONT(,8,,)
         LINE,AT(260,-10,0,905),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,905),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Kopâ pa nodaïu'),AT(1146,0,7760,156),USE(?String8:22),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,-10,0,905),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,905),USE(?Line2:12),COLOR(COLOR:Black)
         LINE,AT(1094,156,7813,0),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(469,208),USE(VERTS1K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,208),USE(VERTS2K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,208),USE(VERTS3K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,208),USE(VERTS4K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,208),USE(VERTS5K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,208),USE(VERTS6K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,208),USE(VERTS7K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,208),USE(VERTS8K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,208),USE(VERTS9K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,208),USE(VERTS10K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,208),USE(VERTS11K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,208),USE(VERTS12K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,208),USE(VERTS13K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,208),USE(VERTS14K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(469,417),USE(VERTN1K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,417),USE(VERTN2K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,417),USE(VERTN3K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,417),USE(VERTN4K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,417),USE(VERTN5K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,417),USE(VERTN6K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,417),USE(VERTN7K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,417),USE(VERTN8K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,417),USE(VERTN9K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,417),USE(VERTN10K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,417),USE(VERTN11K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,417),USE(VERTN12K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,417),USE(VERTN13K),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,417),USE(VERTN14K),RIGHT,FONT(,8,,)
       END
RptFootB DETAIL,AT(,,,875)
         STRING(@N_9.2),AT(469,625),USE(VERTB1B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,625),USE(VERTB2B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,625),USE(VERTB3B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,625),USE(VERTB4B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,625),USE(VERTB5B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,625),USE(VERTB6B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,625),USE(VERTB7B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,625),USE(VERTB8B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,625),USE(VERTB9B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,625),USE(VERTB10B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,625),USE(VERTB11B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,625),USE(VERTB12B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,625),USE(VERTB13B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,625),USE(VERTB14B),RIGHT,FONT(,8,,)
         LINE,AT(260,-10,0,905),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,905),USE(?Line2:113),COLOR(COLOR:Black)
         STRING('t.s. :'),AT(3073,0,260,156),USE(?String8:23),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S5),AT(3385,0,417,156),USE(BKK),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8906,-10,0,905),USE(?Line2:15),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,905),USE(?Line2:16),COLOR(COLOR:Black)
         LINE,AT(1094,156,7813,0),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N_9.2),AT(469,208),USE(VERTS1B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,208),USE(VERTS2B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,208),USE(VERTS3B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,208),USE(VERTS4B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,208),USE(VERTS5B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,208),USE(VERTS6B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,208),USE(VERTS7B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,208),USE(VERTS8B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,208),USE(VERTS9B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,208),USE(VERTS10B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,208),USE(VERTS11B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,208),USE(VERTS12B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,208),USE(VERTS13B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,208),USE(VERTS14B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(469,417),USE(VERTN1B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1146,417),USE(VERTN2B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(1771,417),USE(VERTN3B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(2396,417),USE(VERTN4B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3021,417),USE(VERTN5B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(3646,417),USE(VERTN6B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4271,417),USE(VERTN7B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(4896,417),USE(VERTN8B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(5521,417),USE(VERTN9B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6198,417),USE(VERTN10B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(6875,417),USE(VERTN11B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(7604,417),USE(VERTN12B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8281,417),USE(VERTN13B),RIGHT,FONT(,8,,)
         STRING(@N_9.2),AT(8958,417),USE(VERTN14B),RIGHT,FONT(,8,,)
       END
RptFootS DETAIL,AT(,,,125)
         LINE,AT(260,-10,0,62),USE(?Line24),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,62),USE(?Line25),COLOR(COLOR:Black)
         LINE,AT(8906,-10,0,62),USE(?Line26),COLOR(COLOR:Black)
         LINE,AT(9740,-10,0,62),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(260,52,9479,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
       FOOTER,AT(500,6500,10000,52)
         LINE,AT(260,0,9479,0),USE(?Line1:4),COLOR(COLOR:Black)
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
OMIT('MARIS')
  PUSHBIND
  CHECKOPEN(PAMAT)
  CHECKOPEN(KAT_K)
  BIND('KAT',KAT)
  BIND('GADS',GADS)
  IZZFILT17
  IF GlobalResponse = RequestCancelled
    DO ProcedureReturn
  END
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  BIND(PAM:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Nolietojuma aprçíins'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(PAM:NR_KEY)
      Process:View{Prop:Filter} = 'INSTRING(SUB(FORMAT(PAM:KAT_NR,@S3),1,1),KAT,1) AND ~(PAM:DATUMS > DATE(12,31,GADS)) AND ~(PAM:END_DATE AND ~(PAM:END_DATE>DATE(1,1,GADS)))'
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
      ATL_DATUMS1=DATE(1,1,GADS)
      ATL_DATUMS2=DATE(12,31,GADS)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        CLEAR(SAK)
        CLEAR(NOL)
        CLEAR(NOD)
        CLEAR(UZK)
        CLEAR(KAT:RECORD)
        KAT:NR=PAM:KAT_nr
        GET(KAT_K,KAT:NR_KEY)
        IF ERROR() THEN STOP('KATEGORIJAS').
!       N:NG=FORMAT(PAM:NODALA,@S2)&LEFT(KAT:GRUPA)
        DO VERIFY_NOD
        IF IRNODALA
          DO CLEARTABLE
          SAK[1]=INTVERT(GADS,1)    ! SÂK.V. UZ 1.MÇNEÐA 1.DATUMU
          SAK[14]=INTVERT(GADS+1,1) ! SÂK.V. UZ 31. decembri
          NOL_LI(GADS-1,12)
          UZK[1]= GD[5]
          IF ~(PAM:END_DATE AND PAM:END_DATE<DATE(1,1,1901+GADS))
            NOL_LI(GADS,12)
            UZK[14]= GD[5]
          .
          LOOP I#=1 TO 12
            IF ~(PAM:END_DATE AND PAM:END_DATE<DATE(I#,1,GADS))
              SAK[I#+1]=INTVERT(GADS,I#)
              NOL_LI(GADS,I#)
              NOL[I#+1]= GD[3]
              UZK[I#+1]= GD[5]
!             IF PAM:NR=15
!               STOP(SAK[I#]&'-'&I#&'-'&NOL[I#])
!             .
            .
          .
!         SAV_NG=FORMAT(NOD[1],@N02)&KAT:GRUPA
          LOOP I#= 1 TO 14
!           IF ~NOD[I#]=NODALA THEN CYCLE.
            IF ~NOD[I#]=NODALA
              SAK[I#]=0
              NOL[I#]=0
              UZK[I#]=0
            .
            EXECUTE I#
              VERTN1=UZK[I#]
              VERTN2=NOL[I#]
              VERTN3=NOL[I#]
              VERTN4=NOL[I#]
              VERTN5=NOL[I#]
              VERTN6=NOL[I#]
              VERTN7=NOL[I#]
              VERTN8=NOL[I#]
              VERTN9=NOL[I#]
              VERTN10=NOL[I#]
              VERTN11=NOL[I#]
              VERTN12=NOL[I#]
              VERTN13=NOL[I#]
              VERTN14=UZK[I#]
            .
            EXECUTE I#
              VERTS1=SAK[I#]
              VERTS2=SAK[I#]
              VERTS3=SAK[I#]
              VERTS4=SAK[I#]
              VERTS5=SAK[I#]
              VERTS6=SAK[I#]
              VERTS7=SAK[I#]
              VERTS8=SAK[I#]
              VERTS9=SAK[I#]
              VERTS10=SAK[I#]
              VERTS11=SAK[I#]
              VERTS12=SAK[I#]
              VERTS13=SAK[I#]
              VERTS14=SAK[I#]
            .
            EXECUTE I#
              VERTB1= SAK[I#]-UZK[I#]
              VERTB2= SAK[I#]-UZK[I#]
              VERTB3= SAK[I#]-UZK[I#]
              VERTB4= SAK[I#]-UZK[I#]
              VERTB5= SAK[I#]-UZK[I#]
              VERTB6= SAK[I#]-UZK[I#]
              VERTB7= SAK[I#]-UZK[I#]
              VERTB8= SAK[I#]-UZK[I#]
              VERTB9= SAK[I#]-UZK[I#]
              VERTB10=SAK[I#]-UZK[I#]
              VERTB11=SAK[I#]-UZK[I#]
              VERTB12=SAK[I#]-UZK[I#]
              VERTB13=SAK[I#]-UZK[I#]
              VERTB14=SAK[I#]-UZK[I#]
            .
            DO CLEARBTABLE
            GET(B_TABLE,0)
            B:BKK=PAM:BKK
            GET(B_TABLE,B:BKK)
            IF ERROR()
              EXECUTE I#
                B:VERTN1=UZK[I#]
                B:VERTN2=NOL[I#]
                B:VERTN3=NOL[I#]
                B:VERTN4=NOL[I#]
                B:VERTN5=NOL[I#]
                B:VERTN6=NOL[I#]
                B:VERTN7=NOL[I#]
                B:VERTN8=NOL[I#]
                B:VERTN9=NOL[I#]
                B:VERTN10=NOL[I#]
                B:VERTN11=NOL[I#]
                B:VERTN12=NOL[I#]
                B:VERTN13=NOL[I#]
                B:VERTN14=UZK[I#]
              .
              EXECUTE I#
                B:VERTS1=SAK[I#]
                B:VERTS2=SAK[I#]
                B:VERTS3=SAK[I#]
                B:VERTS4=SAK[I#]
                B:VERTS5=SAK[I#]
                B:VERTS6=SAK[I#]
                B:VERTS7=SAK[I#]
                B:VERTS8=SAK[I#]
                B:VERTS9=SAK[I#]
                B:VERTS10=SAK[I#]
                B:VERTS11=SAK[I#]
                B:VERTS12=SAK[I#]
                B:VERTS13=SAK[I#]
                B:VERTS14=SAK[I#]
              .
              EXECUTE I#
                B:VERTB1= SAK[I#]-UZK[I#]
                B:VERTB2= SAK[I#]-UZK[I#]
                B:VERTB3= SAK[I#]-UZK[I#]
                B:VERTB4= SAK[I#]-UZK[I#]
                B:VERTB5= SAK[I#]-UZK[I#]
                B:VERTB6= SAK[I#]-UZK[I#]
                B:VERTB7= SAK[I#]-UZK[I#]
                B:VERTB8= SAK[I#]-UZK[I#]
                B:VERTB9= SAK[I#]-UZK[I#]
                B:VERTB10=SAK[I#]-UZK[I#]
                B:VERTB11=SAK[I#]-UZK[I#]
                B:VERTB12=SAK[I#]-UZK[I#]
                B:VERTB13=SAK[I#]-UZK[I#]
                B:VERTB14=SAK[I#]-UZK[I#]
              .
              ADD(B_TABLE)
              SORT(B_TABLE,B:BKK)
            ELSE
              EXECUTE I#
                B:VERTN1+=UZK[I#]
                B:VERTN2+=NOL[I#]
                B:VERTN3+=NOL[I#]
                B:VERTN4+=NOL[I#]
                B:VERTN5+=NOL[I#]
                B:VERTN6+=NOL[I#]
                B:VERTN7+=NOL[I#]
                B:VERTN8+=NOL[I#]
                B:VERTN9+=NOL[I#]
                B:VERTN10+=NOL[I#]
                B:VERTN11+=NOL[I#]
                B:VERTN12+=NOL[I#]
                B:VERTN13+=NOL[I#]
                B:VERTN14+=UZK[I#]
              .
              EXECUTE I#
                B:VERTS1+=SAK[I#]
                B:VERTS2+=SAK[I#]
                B:VERTS3+=SAK[I#]
                B:VERTS4+=SAK[I#]
                B:VERTS5+=SAK[I#]
                B:VERTS6+=SAK[I#]
                B:VERTS7+=SAK[I#]
                B:VERTS8+=SAK[I#]
                B:VERTS9+=SAK[I#]
                B:VERTS10+=SAK[I#]
                B:VERTS11+=SAK[I#]
                B:VERTS12+=SAK[I#]
                B:VERTS13+=SAK[I#]
                B:VERTS14+=SAK[I#]
              .
              EXECUTE I#
                B:VERTB1+= SAK[I#]-UZK[I#]
                B:VERTB2+= SAK[I#]-UZK[I#]
                B:VERTB3+= SAK[I#]-UZK[I#]
                B:VERTB4+= SAK[I#]-UZK[I#]
                B:VERTB5+= SAK[I#]-UZK[I#]
                B:VERTB6+= SAK[I#]-UZK[I#]
                B:VERTB7+= SAK[I#]-UZK[I#]
                B:VERTB8+= SAK[I#]-UZK[I#]
                B:VERTB9+= SAK[I#]-UZK[I#]
                B:VERTB10+=SAK[I#]-UZK[I#]
                B:VERTB11+=SAK[I#]-UZK[I#]
                B:VERTB12+=SAK[I#]-UZK[I#]
                B:VERTB13+=SAK[I#]-UZK[I#]
                B:VERTB14+=SAK[I#]-UZK[I#]
              .
              PUT(B_TABLE)
            .
          .
          PRINT(RPT:DETAIL)
          VERTN1K+=  VERTN1
          VERTN2K+=  VERTN2
          VERTN3K+=  VERTN3
          VERTN4K+=  VERTN4
          VERTN5K+=  VERTN5
          VERTN6K+=  VERTN6
          VERTN7K+=  VERTN7
          VERTN8K+=  VERTN8
          VERTN9K+=  VERTN9
          VERTN10K+= VERTN10
          VERTN11K+= VERTN11
          VERTN12K+= VERTN12
          VERTN13K+= VERTN13
          VERTN14K+= VERTN14
          VERTS1K+=  VERTS1
          VERTS2K+=  VERTS2
          VERTS3K+=  VERTS3
          VERTS4K+=  VERTS4
          VERTS5K+=  VERTS5
          VERTS6K+=  VERTS6
          VERTS7K+=  VERTS7
          VERTS8K+=  VERTS8
          VERTS9K+=  VERTS9
          VERTS10K+= VERTS10
          VERTS11K+= VERTS11
          VERTS12K+= VERTS12
          VERTS13K+= VERTS13
          VERTS14K+= VERTS14
          VERTB1K+=  VERTB1
          VERTB2K+=  VERTB2
          VERTB3K+=  VERTB3
          VERTB4K+=  VERTB4
          VERTB5K+=  VERTB5
          VERTB6K+=  VERTB6
          VERTB7K+=  VERTB7
          VERTB8K+=  VERTB8
          VERTB9K+=  VERTB9
          VERTB10K+= VERTB10
          VERTB11K+= VERTB11
          VERTB12K+= VERTB12
          VERTB13K+= VERTB13
          VERTB14K+= VERTB14
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
    PRINT(RPT:RPTFOOT)
    LOOP I#=1 TO RECORDS(B_TABLE)
    GET(B_TABLE,I#)
      BKK    =   B:BKK
      VERTN1B=   B:VERTN1
      VERTN2B=   B:VERTN2
      VERTN3B=   B:VERTN3
      VERTN4B=   B:VERTN4
      VERTN5B=   B:VERTN5
      VERTN6B=   B:VERTN6
      VERTN7B=   B:VERTN7
      VERTN8B=   B:VERTN8
      VERTN9B=   B:VERTN9
      VERTN10B=  B:VERTN10
      VERTN11B=  B:VERTN11
      VERTN12B=  B:VERTN12
      VERTN13B=  B:VERTN13
      VERTN14B=  B:VERTN14
      VERTS1B=   B:VERTS1
      VERTS2B=   B:VERTS2
      VERTS3B=   B:VERTS3
      VERTS4B=   B:VERTS4
      VERTS5B=   B:VERTS5
      VERTS6B=   B:VERTS6
      VERTS7B=   B:VERTS7
      VERTS8B=   B:VERTS8
      VERTS9B=   B:VERTS9
      VERTS10B=  B:VERTS10
      VERTS11B=  B:VERTS11
      VERTS12B=  B:VERTS12
      VERTS13B=  B:VERTS13
      VERTS14B=  B:VERTS14
      VERTB1B=   B:VERTB1
      VERTB2B=   B:VERTB2
      VERTB3B=   B:VERTB3
      VERTB4B=   B:VERTB4
      VERTB5B=   B:VERTB5
      VERTB6B=   B:VERTB6
      VERTB7B=   B:VERTB7
      VERTB8B=   B:VERTB8
      VERTB9B=   B:VERTB9
      VERTB10B=  B:VERTB10
      VERTB11B=  B:VERTB11
      VERTB12B=  B:VERTB12
      VERTB13B=  B:VERTB13
      VERTB14B=  B:VERTB14
      PRINT(RPT:RPTFOOTB)
    .
    PRINT(RPT:RPTFOOTS)
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  FREE(B_TABLE)
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
      StandardWarning(Warn:RecordFetchError,'PAMAT')
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
VERIFY_NOD          ROUTINE
     IRNODALA=FALSE
     CLEAR(NOD)
     J#=0
     NOD[1]=pam:NODALA
     LOOP I#=1 TO 20
        IF PAM:PAR_TIPS[I#]=4    ! PÂRVIETOÐANA
          IF PAM:PAR_DAT[I#]<DATE(1,1,GADS)
             NOD[1]=pam:par_nod[I#]
!         ELSIF INRANGE(PAM:PAR_DAT[I#],DATE(1,1,GADS),DATE(12,31,GADS))
          ELSIF INRANGE(PAM:PAR_DAT[I#],DATE(1,1,GADS),DATE(11,30,GADS))
!            NOD[MONTH(PAM:PAR_DAT[I#])+1]=pam:par_nod[I#]
             NOD[MONTH(PAM:PAR_DAT[I#])+2]=pam:par_nod[I#]
          ELSE
             CYCLE
          .
        .
     .
     SAV_NOD=NOD[1]
     LOOP I#=1 TO 14
        IF ~NOD[I#]
           NOD[I#]=SAV_NOD
!          STOP(NOD[I#])
        ELSE
           SAV_NOD=NOD[I#]
        .
!       IF NOD[I#]=NODALA THEN IRNODALA=TRUE.
        IF (NOD[I#,1]=NODALA[1] OR NODALA[1]=' ') AND|
           (NOD[I#,2]=NODALA[2] OR NODALA[2]=' ') THEN IRNODALA=TRUE. !5/10/99
     .
cleartable          ROUTINE
               VERTN1=0
               VERTN2=0
               VERTN3=0
               VERTN4=0
               VERTN5=0
               VERTN6=0
               VERTN7=0
               VERTN8=0
               VERTN9=0
               VERTN10=0
               VERTN11=0
               VERTN12=0
               VERTN13=0
clearBtable         ROUTINE
               B:VERTN1= 0
               B:VERTN2= 0
               B:VERTN3= 0
               B:VERTN4= 0
               B:VERTN5= 0
               B:VERTN6= 0
               B:VERTN7= 0
               B:VERTN8= 0
               B:VERTN9= 0
               B:VERTN10=0
               B:VERTN11=0
               B:VERTN12=0
               B:VERTN13=0
               B:VERTN14=0
               B:VERTS1= 0
               B:VERTS2= 0
               B:VERTS3= 0
               B:VERTS4= 0
               B:VERTS5= 0
               B:VERTS6= 0
               B:VERTS7= 0
               B:VERTS8= 0
               B:VERTS9= 0
               B:VERTS10=0
               B:VERTS11=0
               B:VERTS12=0
               B:VERTS13=0
               B:VERTS14=0
               B:VERTB1= 0
               B:VERTB2= 0
               B:VERTB3= 0
               B:VERTB4= 0
               B:VERTB5= 0
               B:VERTB6= 0
               B:VERTB7= 0
               B:VERTB8= 0
               B:VERTB9= 0
               B:VERTB10=0
               B:VERTB11=0
               B:VERTB12=0
               B:VERTB13=0
               B:VERTB14=0
OMIT('DIANA')
NEXTRECORD          ROUTINE
  LOOP UNTIL EOF(PAMAT)
     NEXT(PAMAT)
     s#+=1
     show(12,37,s#)
!    IF ~(pam:NODALA='99' OR pam:NODALA='98') THEN CYCLE.
     IF ~INSTRING(SUB(FORMAT(PAM:KAT_NR,@S3),1,1),KAT,1) THEN CYCLE.
     IF PAM:END_DATE AND PAM:END_DATE<DATE(1,1,GADS) THEN CYCLE.
     IF PAM:DATUMS > DATE(12,31,GADS) THEN CYCLE.
     EXIT
  .
  DONE#=1
DIANA
MARIS
