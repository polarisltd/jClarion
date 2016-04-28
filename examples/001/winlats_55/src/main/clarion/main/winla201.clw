                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpPiesk PROCEDURE


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
DAIEVTEX             STRING(35),DIM(10)
BRIDINAJUMS          STRING(40)
Queue:IV             QUEUE,PRE()
IV                   STRING(88)
                     END
CURR_IV              STRING(4)
Update::Reloop  BYTE
Update::Error   BYTE
History::DAI:Record LIKE(DAI:Record),STATIC
SAV::DAI:Record      LIKE(DAI:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Pieskaitîjumi'),AT(,,458,296),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateDAIEV'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,453,273),USE(?CurrentTab)
                         TAB('Pieskaitîjumi'),USE(?Tab:1)
                           STRING('Kods:'),AT(16,23),USE(?String9)
                           ENTRY(@n03b),AT(44,23,23,10),USE(DAI:KODS),RIGHT(1)
                           PROMPT('&Grupa:'),AT(16,36,23,10),USE(?Prompt10)
                           ENTRY(@s4),AT(44,36,23,10),USE(DAI:G),MSG('GRUPA?')
                           PROMPT('&Nosaukums :'),AT(74,23,41,10),USE(?DAI:NOSAUKUMS:Prompt)
                           ENTRY(@s35),AT(119,23,144,10),USE(DAI:NOSAUKUMS),REQ
                           LIST,AT(119,36,306,10),USE(IV),VSCROLL,FORMAT('240L(2)|M~IV~@s88@'),DROP(15),FROM(Queue:IV)
                           PROMPT('Ienâk.veids:'),AT(74,36),USE(?Ienak_veids:Prompt)
                           OPTION('&Funkcija'),AT(10,49,445,60),USE(DAI:F),BOXED
                             RADIO('NAV (nav funkcija)'),AT(17,57),USE(?dai:F:Radio1)
                             RADIO('CAL (ir funkcija no darba laika kalendâra)'),AT(17,65),USE(?DAI:F:Radio2)
                             RADIO('ARG (ir f() no papildus iev. skaitïa)'),AT(17,76),USE(?DAI:F:Radio3)
                             RADIO('GRA (ir funkcija no darba grafika)'),AT(17,96),USE(?DAI:F:Radio9)
                             RADIO('CIP (ir funkcija no citu DAV ievadâmâ skaitïa)'),AT(17,87),USE(?DAI:F:Radio4)
                             RADIO('REZ (ir funkcija no piesk. rezultâta)'),AT(225,57),USE(?dai:F:Radio5)
                             RADIO('UZR (nav funkcija, izmaksât "uz rokas")'),AT(225,65),USE(?dai:F:Radio6)
                             RADIO('NOS (stundas vçrtîba*koeficients*pap. iev. stundas)'),AT(225,76),USE(?DAI:F:Radio7)
                             RADIO('SYS (bûvç sistçma)'),AT(225,87),USE(?dai:F:Radio8)
                           END
                           ENTRY(@s10),AT(148,76,55,9),USE(DAI:ARG_NOS),HIDE
                           PROMPT('Tarifa &likme (koeficients) :'),AT(14,112,87,10),USE(?DAI:TARL:Prompt)
                           ENTRY(@n_10.4),AT(105,112,56,10),USE(DAI:TARL),DECIMAL(20)
                           PROMPT('vai &% :'),AT(168,112,25,10),USE(?DAI:PROC:Prompt)
                           ENTRY(@n2),AT(194,112,19,10),USE(DAI:PROC),DECIMAL(8)
                           PROMPT('&Summa :'),AT(224,112,49,10),USE(?DAI:ALGA:Prompt),RIGHT
                           ENTRY(@n_8.2),AT(276,112,48,10),USE(DAI:ALGA),DECIMAL(12)
                           OPTION('&Tips'),AT(344,114,110,118),USE(DAI:T),BOXED,MSG('TIPS')
                             RADIO('1 Gabaldarbs'),AT(351,122,81,10),USE(?dai:T:Radio1)
                             RADIO('2 Laika darbs'),AT(351,133,81,10),USE(?dai:T:Radio2)
                             RADIO('3 Prçmijas'),AT(351,144,81,10),USE(?dai:T:Radio3)
                             RADIO('4 Piem. par Br/Ns'),AT(351,154,81,10),USE(?dai:T:Radio4)
                             RADIO('5 Citas piemaksas (1)'),AT(351,165,81,10),USE(?dai:T:Radio5)
                             RADIO('6 Citas piemaksas (2)'),AT(351,176,81,10),USE(?DAI:T:Radio6)
                             RADIO('7 Atvaïinâjumi'),AT(351,187,81,10),USE(?DAI:T:Radio7)
                             RADIO('8 Slimîbas lapas'),AT(351,198,81,10),USE(?DAI:T:Radio8)
                             RADIO('9 Dâvanas u.c. neapliekamie'),AT(351,207,103,10),USE(?DAI:T:Radio9)
                             RADIO('D Dividendes'),AT(351,217,103,10),USE(?DAI:T:Radio9:2),DISABLE
                           END
                           STRING(@s40),AT(104,123),USE(BRIDINAJUMS),FONT(,,COLOR:Green,,CHARSET:ANSI)
                           STRING('Saistoðie DAV : (999 - VISI, kam Kods mazâks par tekoðo)'),AT(13,134),USE(?String1)
                           ENTRY(@n3),AT(13,144,23,10),USE(DAI:F_DAIEREZ[1]),RIGHT(1)
                           ENTRY(@s35),AT(42,144,148,10),USE(DAIEVTEX[1])
                           ENTRY(@n3),AT(13,155,23,10),USE(DAI:F_DAIEREZ[2]),RIGHT(1)
                           ENTRY(@s35),AT(42,155,148,10),USE(DAIEVTEX[2])
                           ENTRY(@n3),AT(13,168,23,10),USE(DAI:F_DAIEREZ[3]),RIGHT(1)
                           ENTRY(@s35),AT(42,168,148,10),USE(DAIEVTEX[3])
                           ENTRY(@n3),AT(13,179,23,10),USE(DAI:F_DAIEREZ[4]),RIGHT(1)
                           ENTRY(@s35),AT(42,179,148,10),USE(DAIEVTEX[4])
                           ENTRY(@n3),AT(13,192,23,10),USE(DAI:F_DAIEREZ[5]),RIGHT(1)
                           ENTRY(@s35),AT(42,192,148,10),USE(DAIEVTEX[5])
                           ENTRY(@n3),AT(13,203,23,10),USE(DAI:F_DAIEREZ[6]),RIGHT(1)
                           ENTRY(@s35),AT(42,203,148,10),USE(DAIEVTEX[6])
                           ENTRY(@n3),AT(13,216,23,10),USE(DAI:F_DAIEREZ[7]),RIGHT(1)
                           ENTRY(@s35),AT(42,216,148,10),USE(DAIEVTEX[7])
                           ENTRY(@n3),AT(13,227,23,10),USE(DAI:F_DAIEREZ[8]),RIGHT(1)
                           ENTRY(@s35),AT(42,227,148,10),USE(DAIEVTEX[8])
                           ENTRY(@n3),AT(13,240,23,10),USE(DAI:F_DAIEREZ[9]),RIGHT(1)
                           ENTRY(@s35),AT(42,240,148,10),USE(DAIEVTEX[9])
                           GROUP('Importa interfeiss :'),AT(196,233,259,41),USE(?Group1),BOXED
                             STRING('citâm definîcijâm)'),AT(395,260),USE(?String10:3),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           END
                           ENTRY(@n3),AT(13,251,23,10),USE(DAI:F_DAIEREZ[10]),RIGHT(1)
                           ENTRY(@s35),AT(42,251,148,10),USE(DAIEVTEX[10])
                           STRING('ietur sociâlo nodokli'),AT(196,143),USE(?String4),LEFT
                           OPTION,AT(286,138,55,18),USE(DAI:SOCYN),BOXED
                             RADIO('Y'),AT(290,145),USE(?dai:p1:Radio1)
                             RADIO('N'),AT(316,145),USE(?dai:p1:Radio2)
                           END
                           STRING('ietur ienâkuma nodokli'),AT(196,162),USE(?StringDAI:IENYN),LEFT
                           OPTION,AT(286,156,55,18),USE(DAI:IENYN),BOXED
                             RADIO('Y'),AT(290,161),USE(?dai:p2:Radio1)
                             RADIO('N'),AT(316,161),USE(?dai:p2:Radio2)
                           END
                           STRING('izmanto, rçí. Slimîbas Lapu'),AT(196,180),USE(?String4:3),DISABLE,LEFT
                           OPTION,AT(286,175,55,18),USE(DAI:SLIYN),DISABLE,BOXED
                             RADIO('Y'),AT(290,180),USE(?DAI:SLIYN:Y)
                             RADIO('N'),AT(316,180),USE(?DAI:SLIYN:N)
                           END
                           STRING('izmanto, rçí. Atvaïinâjumu'),AT(196,202),USE(?String4:4),DISABLE,LEFT
                           OPTION,AT(286,196,55,18),USE(DAI:ATVYN),DISABLE,BOXED
                             RADIO('Y'),AT(290,201)
                             RADIO('N'),AT(316,201)
                           END
                           STRING('izmanto, rçí. Vidçjo algu'),AT(196,220),USE(?String4:5),LEFT
                           OPTION,AT(286,212,55,18),USE(DAI:VIDYN),BOXED
                             RADIO('Y'),AT(290,218)
                             RADIO('N'),AT(316,218)
                           END
                           STRING('Autokontçjums :'),AT(197,241),USE(?String3)
                           PROMPT('&D - konts'),AT(253,241,34,10),USE(?Prompt8)
                           ENTRY(@s5),AT(289,241,40,10),USE(DAI:DKK)
                           ENTRY(@s2),AT(378,241,19,10),USE(DAI:NODALA),CENTER
                           PROMPT('K - konts'),AT(253,252,34,10),USE(?Prompt9)
                           ENTRY(@s5),AT(289,252,40,10),USE(DAI:KKK)
                           STRING('(jâaizpilda, ja neapmierina noklusçtie kontçjumi)'),AT(198,263),USE(?String10:2),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           STRING('(ja definçta, izdalîs neatkarîgi no'),AT(345,252),USE(?String10),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           PROMPT('&Nodaïa :'),AT(346,241,30,10),USE(?PromptNodala)
                         END
                       END
                       BUTTON('&OK'),AT(360,277,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(410,277,45,14),USE(?Cancel)
                     END
SAV_F_DAIEREZ       DECIMAL(30),DIM(10)
CONTFIELD           DECIMAL(3)
SAV:SAVERECORD      LIKE(DAI:RECORD)
SAV_POSITION        STRING(256)
FOUND_F_D           BYTE
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    IV='1001-Darba alga'
    ADD(Queue:IV)           !16
    IV='1003-Ienâkumi no intelektuâlâ îpaðuma'
    ADD(Queue:IV)
    IV='1004-Metâllûþòu pârdoðanas ienâkumi'
    ADD(Queue:IV)
    IV='1006-Ienâkumi no nekustamâ îpðuma izmantoðanas'
    ADD(Queue:IV)
    IV='1007-Ienâkumi no citas saimnieciskâs darbîbas'
    ADD(Queue:IV)
    IV='1008-Ienâkumi no uzòçmuma lîguma'
    ADD(Queue:IV)
    IV='1009-Ienâkumi no kustamâ îpðuma izmantoðanas'
    ADD(Queue:IV)
    IV='1010-Ienâkumi no kokmateriâlu un augoða meþa atsavinâðanas'
    ADD(Queue:IV)
    IV='1011-Dividendes'
    ADD(Queue:IV)
    IV='1012-Mantojuma rezultâtâ gûtais ienâkums'
    ADD(Queue:IV)
    IV='1013-Preèu pârdoðana (likuma "Par IIN" 9.panta I d.19.p.a-apakðpunkts)'
    ADD(Queue:IV)
    IV='1014-No juridiskâs personas saòemtais dâvinâjums'
    ADD(Queue:IV)
    IV='1016-Stipendijas'
    ADD(Queue:IV)
    IV='1017-Apdroðinâðanas atlîdzîba'
    ADD(Queue:IV)
    IV='1018-Ienâkumi no pienâkumu pildîðanas padomç vai valdç'
    ADD(Queue:IV)
    IV='1019-Procenti'
    ADD(Queue:IV)
    IV='1020-Citi ar nodokli apliekamie ienâkumi, no kuriem nodokli ietur izmaksas vietâ'
    ADD(Queue:IV)
    IV='1026-Papildpensijas kapitâls, as veidojas no DD veiktajâm iemaksâm PPF'
    ADD(Queue:IV)
    IV='1029-Izloþu un azartspçïu laimesti, kuri pârsniedz 500 Ls (izòemot preèu un pak. laim.)'
    ADD(Queue:IV)
    IV='1032-Atlîdzîba, kuru izmaksâ sagâdes u.c. organiz. par medîjumiem u.c. savvaïas produkc.'
    ADD(Queue:IV)
    IV='1033-Slimîbas pabalsti (B-daïa)'
    ADD(Queue:IV)
    IV='1034-Vecuma pensija'
    ADD(Queue:IV)
    IV='1035-Invaliditâtes pensija'
    ADD(Queue:IV)
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
    IF ~INRANGE(DAI:IENAK_VEIDS,1001,1035) THEN DAI:IENAK_VEIDS=1001.   !VISU UZSKATAM PAR DA
    CURR_IV=FORMAT(DAI:IENAK_VEIDS,@S4)
    LOOP I#=1 TO RECORDS(Queue:IV)
       GET(Queue:IV,I#)
       IF CURR_IV=IV[1:4]
          BREAK
       .
    .
  
    IF INRANGE(DAI:KODS,840,845)     !ATVAÏINÂJUMI
       DAI:T='7'
       IF INRANGE(DAI:KODS,840,842) THEN DAI:F='SYS'.
       IF DAI:KODS=840 THEN DAI:NOSAUKUMS='Atvaïinâjums tekoðajâ mçnesî'.
       IF DAI:KODS=841 THEN DAI:NOSAUKUMS='Atvaïinâjums nâkoðajâ mçnesî'.
       IF DAI:KODS=842 THEN DAI:NOSAUKUMS='Atvaïinâjums aiznâkoðajâ mçnesî'.
       DISABLE(3,?OK-1)
  !     ENABLE(?DAI:SLIYN)    ÐITO VAIRÂK NAV, JO RÇÍINA PÇC VIDÇJÂS
  !     ENABLE(?DAI:ATVYN)
       ENABLE(?DAI:VIDYN)
       ENABLE(?DAI:DKK)
       ENABLE(?DAI:KKK)
    ELSIF INRANGE(DAI:KODS,850,859)  !SLILAPAS
       DAI:T='8'
       IF INRANGE(DAI:KODS,850,852) THEN DAI:F='SYS'.
       IF DAI:KODS=850 THEN DAI:NOSAUKUMS='Slimîbas lapa ðajâ mçnesî'.
       IF DAI:KODS=851 THEN DAI:NOSAUKUMS='Slimîbas lapa pagâjuðajâ mçnesî'.
       IF DAI:KODS=852 THEN DAI:NOSAUKUMS='Slimîbas lapa nâkoðajâ mçnesî'.
       DISABLE(3,?OK-1)
  !     ENABLE(?DAI:SLIYN)    ÐITO VAIRÂK NAV, JO RÇÍINA PÇC VIDÇJÂS
  !     ENABLE(?DAI:ATVYN)
       ENABLE(?DAI:VIDYN)
       ENABLE(?DAI:DKK)
       ENABLE(?DAI:KKK)
    ELSIF DAI:KODS=860               !SOCIÂLIE (VÇSTURE VAI NEZINÂMA NÂKOTNE)
       DAI:T='9'
       DISABLE(3,?OK-1)
       ENABLE(?DAI:DKK)
       ENABLE(?DAI:KKK)
    ELSIF DAI:KODS=879               !DIVIDENDES 02.05.2011
  !     DAI:T='D'
  !     DAI:F='SYS'
  !     DAI:IENAK_VEIDS=1011
       DISABLE(3,?OK-1)
    END
    IF INRANGE(DAI:KODS,843,845) OR INRANGE(DAI:KODS,853,859) OR DAI:KODS=860
       ENABLE(?DAI:NOSAUKUMS)
       ENABLE(?DAI:NODALA)
    ELSE
       IF ~(LocalRequest=DeleteRecord)
          DISABLE(DAI:F_DAIEREZ[1])
          DISABLE(DAI:F_DAIEREZ[2])
          DISABLE(DAI:F_DAIEREZ[3])
          DISABLE(DAI:F_DAIEREZ[4])
          DISABLE(DAI:F_DAIEREZ[5])
          DISABLE(DAI:F_DAIEREZ[6])
          DISABLE(DAI:F_DAIEREZ[7])
          DISABLE(DAI:F_DAIEREZ[8])
          DISABLE(DAI:F_DAIEREZ[9])
          DISABLE(DAI:F_DAIEREZ[10])
          case DAI:F
          OF 'REZ'
          OROF 'CIP'
             ENABLE(DAI:F_DAIEREZ[1])
             ENABLE(DAI:F_DAIEREZ[2])
             ENABLE(DAI:F_DAIEREZ[3])
             ENABLE(DAI:F_DAIEREZ[4])
             ENABLE(DAI:F_DAIEREZ[5])
             ENABLE(DAI:F_DAIEREZ[6])
             ENABLE(DAI:F_DAIEREZ[7])
             ENABLE(DAI:F_DAIEREZ[8])
             ENABLE(DAI:F_DAIEREZ[9])
             ENABLE(DAI:F_DAIEREZ[10])
             DISABLE(?DAI:ALGA)
             ENABLE(?DAI:TARL)
             ENABLE(?DAI:PROC)
          OF 'CAL'
          OROF 'GRA' !30/08/2015
          OROF 'NAV'
          OROF 'UZR'
             ENABLE(?DAI:ALGA)
             IF DAI:KODS=880 THEN ?DAI:ALGA:Prompt{PROP:TEXT}='1-rçíinât 0-nç'.
             IF DAI:F='CAL' AND DAI:TARL THEN BRIDINAJUMS='Aprçíins=CAL stundas*tarifa likme'.
             IF DAI:F='GRA' AND DAI:TARL THEN BRIDINAJUMS='Aprçíins=GRAF stundas*tarifa likme'. !30/08/2015
             DISABLE(?DAI:TARL)
             IF DAI:F='GRA' THEN ENABLE(?DAI:TARL). !02/09/2015
             DISABLE(?DAI:PROC)
          OF 'ARG'
             DISABLE(?DAI:ALGA)
             ENABLE(?DAI:TARL)
             ENABLE(?DAI:PROC)
             UNHIDE(?DAI:ARG_NOS)
          OF 'NOS'
             ENABLE(?DAI:ALGA)
             ENABLE(?DAI:TARL)
          .
       .
    .
    SAV:SAVERECORD=DAI:RECORD
    SAV_POSITION=POSITION(DAIEV)
    FOUND_F_D=FALSE
    loop I#=1 TO 10
       SAV_F_DAIEREZ[I#]=DAI:F_DAIEREZ[I#]
    .
    loop I#=1 TO 10
      IF ~(SAV_F_DAIEREZ[I#]=0)
         CLEAR(DAI:RECORD)
         DAI:KODS=SAV_F_DAIEREZ[I#]
         GET(DAIEV,DAI:KOD_KEY)
         DAIEVTEX[I#]=DAI:NOSAUKUMS
         FOUND_F_D=TRUE
      .
    .
    IF FOUND_F_D=TRUE
       RESET(DAIEV,SAV_POSITION)
       NEXT(DAIEV)
       DAI:RECORD=SAV:SAVERECORD
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
      SELECT(?String9)
      SELECT(?DAI:NOSAUKUMS)
      IF DAI:KODS=879
         ?StringDAI:IENYN{PROP:TEXT}='ietur 10% IIN'
      .
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
        History::DAI:Record = DAI:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(DAIEV)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(DAI:KOD_KEY)
              IF StandardWarning(Warn:DuplicateKey,'DAI:KOD_KEY')
                SELECT(?String9)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?String9)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::DAI:Record <> DAI:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:DAIEV(1)
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
              SELECT(?String9)
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
    OF ?DAI:KODS
      CASE EVENT()
      OF EVENT:Accepted
                IF ~INRANGE(DAI:KODS,1,899)
                   BEEP
                   SELECT(?DAI:KODS)
                .
                IF INRANGE(DAI:KODS,840,845)      !atvaïinâjumi
                   DAI:T='7'
                   DISABLE(?DAI:T)
                ELSIF INRANGE(DAI:KODS,850,859)   !slilapas
                   DAI:T='8'
                   DISABLE(?DAI:T)
                ELSIF INRANGE(DAI:KODS,860,878)   !sociâlie
                   DAI:T='9'
                   DISABLE(?DAI:T)
                ELSIF DAI:KODS=879                !DIVIDENDES
                   DAI:T='D'
                   DISABLE(?DAI:T)
                ELSE
                   ENABLE(?DAI:T)
                .
                DISPLAY
      END
    OF ?IV
      CASE EVENT()
      OF EVENT:Accepted
  CURR_IV=IV[1:4]
  IF CURR_IV='1011' AND ~(DAI:KODS=879)
     KLUDA(0,'Neatïauts Ienâkuma veids '&DAI:KODS&'.pieskaitîjumam')
     SELECT(?IV)
     DISPLAY
  ELSE
     DAI:IENAK_VEIDS=DEFORMAT(CURR_IV)
  .
! STOP(DAI:IENAK_VEIDS&' '&CURR_IV)
      END
    OF ?DAI:F
      CASE EVENT()
      OF EVENT:Accepted
                 DISABLE(DAI:F_DAIEREZ[1])
                 DISABLE(DAI:F_DAIEREZ[2])
                 DISABLE(DAI:F_DAIEREZ[3])
                 DISABLE(DAI:F_DAIEREZ[4])
                 DISABLE(DAI:F_DAIEREZ[5])
                 DISABLE(DAI:F_DAIEREZ[6])
                 DISABLE(DAI:F_DAIEREZ[7])
                 DISABLE(DAI:F_DAIEREZ[8])
                 DISABLE(DAI:F_DAIEREZ[9])
                 DISABLE(DAI:F_DAIEREZ[10])
                 HIDE(?DAI:ARG_NOS)
                 BRIDINAJUMS=''
                 case DAI:F
                 OF 'REZ'
                 OROF 'CIP'
                    ENABLE(DAI:F_DAIEREZ[1])
                    ENABLE(DAI:F_DAIEREZ[2])
                    ENABLE(DAI:F_DAIEREZ[3])
                    ENABLE(DAI:F_DAIEREZ[4])
                    ENABLE(DAI:F_DAIEREZ[5])
                    ENABLE(DAI:F_DAIEREZ[6])
                    ENABLE(DAI:F_DAIEREZ[7])
                    ENABLE(DAI:F_DAIEREZ[8])
                    ENABLE(DAI:F_DAIEREZ[9])
                    ENABLE(DAI:F_DAIEREZ[10])
                    DISABLE(?DAI:ALGA)
                    ENABLE(?DAI:TARL)
                    ENABLE(?DAI:PROC)
                 OF 'CAL'
                 OROF 'GRA' !28/08/2015
                 OROF 'NAV'
                 OROF 'UZR'
                    ENABLE(?DAI:ALGA)
                    DISABLE(?DAI:TARL)
                    DISABLE(?DAI:PROC)
                    IF DAI:F='CAL' AND DAI:TARL THEN BRIDINAJUMS='Aprçíins=CAL stundas*tarifa likme'.
                    IF DAI:F='GRA' AND DAI:TARL THEN BRIDINAJUMS='Aprçíins=GRAF stundas*tarifa likme'.  !30/08/2015
                    IF DAI:F='GRA' THEN ENABLE(?DAI:TARL). !02/09/2015
                 OF 'ARG'
                    DISABLE(?DAI:ALGA)
                    ENABLE(?DAI:TARL)
                    ENABLE(?DAI:PROC)
                    UNHIDE(?DAI:ARG_NOS)
                 OF 'NOS'
                    ENABLE(?DAI:ALGA)
                    ENABLE(?DAI:TARL)
                    IF ~DAI:TARL THEN DAI:TARL=1.
                 .
      END
    OF ?DAI:F_DAIEREZ_1
      CASE EVENT()
      OF EVENT:Accepted
                I#=1
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_2
      CASE EVENT()
      OF EVENT:Accepted
                I#=2
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_3
      CASE EVENT()
      OF EVENT:Accepted
                I#=3
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_4
      CASE EVENT()
      OF EVENT:Accepted
                I#=4
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_5
      CASE EVENT()
      OF EVENT:Accepted
                I#=5
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_6
      CASE EVENT()
      OF EVENT:Accepted
                I#=6
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_7
      CASE EVENT()
      OF EVENT:Accepted
                I#=7
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_8
      CASE EVENT()
      OF EVENT:Accepted
                I#=8
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_9
      CASE EVENT()
      OF EVENT:Accepted
                I#=9
                DO FILLDAIEVTEX
      END
    OF ?DAI:F_DAIEREZ_10
      CASE EVENT()
      OF EVENT:Accepted
                I#=10
                DO FILLDAIEVTEX
      END
    OF ?DAI:DKK
      CASE EVENT()
      OF EVENT:Accepted
        IF DAI:DKK
           KKK=DAI:DKK
           DAI:DKK=GETKON_K(DAI:DKK,1,1)
           DISPLAY
        .
      END
    OF ?DAI:KKK
      CASE EVENT()
      OF EVENT:Accepted
        IF DAI:KKK
           KKK=DAI:KKK
           DAI:KKK=GETKON_K(DAI:KKK,1,1)
           DISPLAY
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
        ! IV#=DEFORMAT(IV[3:4],@N02)
        ! DAI:IENAK_VEIDS=IV#
        ! STOP(IV[3:4]&' '&IV#&' '&DAI:IENAK_VEIDS)
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
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  FilesOpened = True
  RISnap:DAIEV
  SAV::DAI:Record = DAI:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    IF DAI:KODS=879               !DIVIDENDES 02.05.2011
      DAI:NOSAUKUMS='Dividendes'
      DAI:T='D'
      DAI:F='SYS'
      DAI:IENAK_VEIDS=1011
      DAI:IENYN = 'Y'
    ELSE
      DAI:SOCYN = 'Y'
      DAI:IENYN = 'Y'
    !  DAI:SLIYN = 'Y' ÐITO VAIRÂK NAV, JO RÇÍINA PÇC VIDÇJÂS
    !  DAI:ATVYN = 'Y'
      DAI:VIDYN = 'Y'
      DAI:F='NAV'
      DAI:T='1'
      DAI:IENAK_VEIDS=1001
    .
      
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:DAIEV()
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
  INIRestoreWindow('UpPiesk','winlats.INI')
  WinResize.Resize
  ?DAI:KODS{PROP:Alrt,255} = 734
  ?DAI:G{PROP:Alrt,255} = 734
  ?DAI:NOSAUKUMS{PROP:Alrt,255} = 734
  ?DAI:F{PROP:Alrt,255} = 734
  ?DAI:ARG_NOS{PROP:Alrt,255} = 734
  ?DAI:TARL{PROP:Alrt,255} = 734
  ?DAI:PROC{PROP:Alrt,255} = 734
  ?DAI:ALGA{PROP:Alrt,255} = 734
  ?DAI:T{PROP:Alrt,255} = 734
  ?DAI:SOCYN{PROP:Alrt,255} = 734
  ?DAI:IENYN{PROP:Alrt,255} = 734
  ?DAI:SLIYN{PROP:Alrt,255} = 734
  ?DAI:ATVYN{PROP:Alrt,255} = 734
  ?DAI:VIDYN{PROP:Alrt,255} = 734
  ?DAI:DKK{PROP:Alrt,255} = 734
  ?DAI:NODALA{PROP:Alrt,255} = 734
  ?DAI:KKK{PROP:Alrt,255} = 734
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
  END
  IF WindowOpened
    INISaveWindow('UpPiesk','winlats.INI')
    CLOSE(QuickWindow)
  END
  FREE(Queue:IV)
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
FILLDAIEVTEX       ROUTINE
 CONTFIELD=CONTENTS(FIELD())
 IF CONTFIELD=0
    DAIEVTEX[I#]=''
 ELSIF CONTFIELD=999
    DAIEVTEX[I#]='Visi no 1 lîdz '&DAI:KODS-1
 ELSE
    IF CONTFIELD > 899
       CONTFIELD=0
    .
    IF ~(CONTFIELD < DAI:KODS)
       KLUDA(62,'')
       select(?)
    ELSE
       SAV:SAVERECORD=DAI:RECORD
       SAV_POSITION=POSITION(DAIEV)
       CLEAR(DAI:RECORD)
       DAI:KODS=CONTFIELD
       GET(DAIEV,DAI:KOD_KEY)
       IF ERROR()
          GLOBALREQUEST=SELECTRECORD
          F:IDP='P'
          BROWSEDAIEV
          F:IDP=''
          CONTFIELD=DAI:KODS
       .
       DAIEVTEX[I#]=DAI:NOSAUKUMS
       RESET(DAIEV,SAV_POSITION)
       NEXT(DAIEV)
       DAI:RECORD=SAV:SAVERECORD
       DAI:F_DAIEREZ[I#]=CONTFIELD
    .
 .
 DISPLAY()
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?DAI:KODS
      DAI:KODS = History::DAI:Record.KODS
    OF ?DAI:G
      DAI:G = History::DAI:Record.G
    OF ?DAI:NOSAUKUMS
      DAI:NOSAUKUMS = History::DAI:Record.NOSAUKUMS
    OF ?DAI:F
      DAI:F = History::DAI:Record.F
    OF ?DAI:ARG_NOS
      DAI:ARG_NOS = History::DAI:Record.ARG_NOS
    OF ?DAI:TARL
      DAI:TARL = History::DAI:Record.TARL
    OF ?DAI:PROC
      DAI:PROC = History::DAI:Record.PROC
    OF ?DAI:ALGA
      DAI:ALGA = History::DAI:Record.ALGA
    OF ?DAI:T
      DAI:T = History::DAI:Record.T
    OF ?DAI:SOCYN
      DAI:SOCYN = History::DAI:Record.SOCYN
    OF ?DAI:IENYN
      DAI:IENYN = History::DAI:Record.IENYN
    OF ?DAI:SLIYN
      DAI:SLIYN = History::DAI:Record.SLIYN
    OF ?DAI:ATVYN
      DAI:ATVYN = History::DAI:Record.ATVYN
    OF ?DAI:VIDYN
      DAI:VIDYN = History::DAI:Record.VIDYN
    OF ?DAI:DKK
      DAI:DKK = History::DAI:Record.DKK
    OF ?DAI:NODALA
      DAI:NODALA = History::DAI:Record.NODALA
    OF ?DAI:KKK
      DAI:KKK = History::DAI:Record.KKK
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
  DAI:Record = SAV::DAI:Record
  SAV::DAI:Record = DAI:Record
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

BrowseDAIEV PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
KODS_OLD             DECIMAL(7,2)
KODS_NEW             DECIMAL(7,2)

BRW1::View:Browse    VIEW(DAIEV)
                       PROJECT(DAI:KODS)
                       PROJECT(DAI:NOSAUKUMS)
                       PROJECT(DAI:NODALA)
                       PROJECT(DAI:F)
                       PROJECT(DAI:ARG_NOS)
                       PROJECT(DAI:TARL)
                       PROJECT(DAI:ALGA)
                       PROJECT(DAI:PROC)
                       PROJECT(DAI:T)
                       PROJECT(DAI:IENAK_VEIDS)
                       PROJECT(DAI:DKK)
                       PROJECT(DAI:KKK)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::DAI:KODS         LIKE(DAI:KODS)             ! Queue Display field
BRW1::DAI:NOSAUKUMS    LIKE(DAI:NOSAUKUMS)        ! Queue Display field
BRW1::DAI:NODALA       LIKE(DAI:NODALA)           ! Queue Display field
BRW1::DAI:F            LIKE(DAI:F)                ! Queue Display field
BRW1::DAI:ARG_NOS      LIKE(DAI:ARG_NOS)          ! Queue Display field
BRW1::DAI:TARL         LIKE(DAI:TARL)             ! Queue Display field
BRW1::DAI:ALGA         LIKE(DAI:ALGA)             ! Queue Display field
BRW1::DAI:PROC         LIKE(DAI:PROC)             ! Queue Display field
BRW1::DAI:T            LIKE(DAI:T)                ! Queue Display field
BRW1::DAI:IENAK_VEIDS  LIKE(DAI:IENAK_VEIDS)      ! Queue Display field
BRW1::DAI:DKK          LIKE(DAI:DKK)              ! Queue Display field
BRW1::DAI:KKK          LIKE(DAI:KKK)              ! Queue Display field
BRW1::F:IDP            LIKE(F:IDP)                ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(DAI:KODS),DIM(100)
BRW1::Sort1:LowValue LIKE(DAI:KODS)               ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(DAI:KODS)              ! Queue position of scroll thumb
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
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
QuickWindow          WINDOW('Pieskaitîjumi/Ieturçjumi'),AT(,,425,254),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('PieskTable'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,410,191),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('24R(2)|M~KODS~C(0)@n03@141L(2)|M~NOSAUKUMS~@s35@10C|M~N~@s2@14C|M~F~@s3@40R(2)|M' &|
   '~ARG_NOS~C(0)@s10@37R(2)|M~Tarifa/L(K)~C(0)@n_8.2@36R(2)|M~Summa~C(0)@n_8.2@11R(' &|
   '1)|M~%~C(0)@n2@8C|M~T~@s1@19C|M~IVK~@n_4B@24L(2)|M~DKK~@s5@20L(2)|M~KKK~@s5@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&vçlçties'),AT(328,238,45,14),USE(?Select ),FONT(,,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('&Ievadît'),AT(229,215,45,14),USE(?Insert:3)
                       BUTTON('&Mainît'),AT(280,215,45,14),USE(?Change ),DEFAULT
                       BUTTON('&Dzçst'),AT(330,215,45,14),USE(?Delete:3)
                       BUTTON('Mainît &Kodu DB'),AT(253,238,69,14),USE(?ButtonMKDB)
                       SHEET,AT(4,5,421,230),USE(?CurrentTab)
                         TAB('Kodu secîba'),USE(?Tab:2)
                           ENTRY(@n03),AT(14,218,22,11),USE(DAI:KODS)
                           PROMPT('- âtrâ &meklçðana'),AT(42,219,61,10),USE(?Prompt1)
                         END
                       END
                       BUTTON('&Beigt'),AT(379,238,45,14),USE(?Close)
                     END
screen1 WINDOW('Nomainît kodu'),AT(,,185,73),GRAY
       STRING('Nomainît visai Datu Bâzei'),AT(50,14),USE(?String1)
       STRING('kodu'),AT(46,29),USE(?String2)
       ENTRY(@p###p),AT(67,28,25,12),USE(kods_old)
       STRING('uz'),AT(99,29),USE(?String3)
       ENTRY(@p###p),AT(116,28,25,12),USE(kods_new),REQ
       BUTTON('&OK'),AT(105,50,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(145,50,36,14),USE(?CancelButton)
     END

screen2 WINDOW('Ievadiet kodu'),AT(,,185,64),GRAY
       STRING('Ievadiet Pieskaitîjumu/Ieturçjumu kodu :'),AT(12,21),USE(?String11)
       ENTRY(@p###p),AT(153,19,25,12),USE(kods_new,,?KODS_NEW:1),REQ
       BUTTON('&OK'),AT(105,41,35,14),USE(?OkButton2),DEFAULT
       BUTTON('&Atlikt'),AT(145,41,36,14),USE(?CancelButton2)
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
  IF LOCALREQUEST=SELECTRECORD
     ?Change{PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
  ELSE
     DAI:KODS=879
     GET(DAIEV,DAI:KOD_KEY)
     IF ERROR()
        DAI:NOSAUKUMS='Dividendes'
        DAI:F='SYS'
        DAI:T='D'
        DAI:IENAK_VEIDS=1011
        DAI:SOCYN='N'
        DAI:IENYN='Y'
        DAI:SLIYN='N'
        DAI:ATVYN='N'
        DAI:VIDYN='N'
        ADD(DAIEV)
     ELSIF ~(DAI:F='SYS' AND DAI:T='D' AND DAI:IENAK_VEIDS=1011)
        KLUDA(0,'879.KODS ir SYS rezervçts dividendçm, nomainiet uz citu')
     .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
       IF F:IDP='P'
          QUICKWINDOW{PROP:TEXT}='Pieskaitîjumi'
       ELSIF F:IDP='I'
          QUICKWINDOW{PROP:TEXT}='Ieturçjumi'
       .
       IF LOCALREQUEST=SELECTRECORD
          DISABLE(?ButtonMKDB)
       .
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
    OF ?Select 
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
    OF ?Change 
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
    OF ?ButtonMKDB
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
              OPEN(SCREEN1)
              DISPLAY
              ACCEPT
                CASE FIELD()
                OF ?OkButton
                  CASE EVENT()
                  OF EVENT:Accepted
                    IF INRANGE(KODS_OLD,901,912) OR INRANGE(KODS_NEW,901,912)
                       KLUDA(27,'DAIV kods')
                       BREAK
                    .
                    CLEAR(DAI:RECORD)
                    DAI:KODS=KODS_OLD
                    GET(DAIEV,DAI:KOD_KEY)
                    IF ERROR()
                      KLUDA(60,kods_old)
                      BREAK
                    ELSE
                      DAI:KODS=KODS_NEW
                      PUT(DAIEV)
                    .
                    CHECKOPEN(KADRI)
                    CLEAR(KAD:RECORD)
                    SET(KADRI)
                    LOOP
                      NEXT(KADRI)
                      IF ERROR() THEN BREAK.
                      PUT#=FALSE
                      loop i#=1 to 20
                        IF KAD:PIESKLIST[I#]=KODS_OLD
                          KAD:PIESKLIST[I#]=KODS_NEW
                          PUT#=TRUE
                        .
                      .
                      loop i#=1 to 15
                        IF KAD:IETLIST[I#]=KODS_OLD
                          KAD:IETLIST[I#]=KODS_NEW
                          PUT#=TRUE
                        .
                      .
                      IF PUT#=TRUE
                         PUT(KADRI)
                      .
                    .
                    CHECKOPEN(ALGAS)
                    CLEAR(ALG:RECORD)
                    SET(ALGAS)
                    LOOP
                      NEXT(ALGAS)
                      IF ERROR() THEN BREAK.
                      PUT#=FALSE
                      loop i#=1 to 20
                        IF ALG:K[I#]=KODS_OLD
                          ALG:K[I#]=KODS_NEW
                          PUT#=TRUE
                        .
                      .
                      loop i#=1 to 15
                        IF ALG:I[I#]=KODS_OLD
                          ALG:I[I#]=KODS_NEW
                          PUT#=TRUE
                        .
                      .
                      IF PUT#=TRUE
                          PUT(ALGAS)
                      .
                    .
                    BREAK
                  .
                OF ?CancelButton
                  BREAK
                .
              .
              CLOSE(SCREEN1)
              DO BRW1::InitializeBrowse
              DO BRW1::RefreshPage
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
    OF ?DAI:KODS
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?DAI:KODS)
        IF DAI:KODS
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = DAI:KODS
          BRW1::Sort1:LocatorLength = LEN(CLIP(DAI:KODS))
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
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseDAIEV','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select {Prop:Hide} = True
    DISABLE(?Select )
  ELSE
  END
  BIND('F:IDP',F:IDP)
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
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
  END
  IF WindowOpened
    INISaveWindow('BrowseDAIEV','winlats.INI')
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
    DAI:KODS = BRW1::Sort1:LocatorValue
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
      DAI:KODS = BRW1::Sort1:LocatorValue
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
  IF SEND(DAIEV,'QUICKSCAN=on').
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'DAIEV')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = DAI:KODS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'DAIEV')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = DAI:KODS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
  IF SEND(DAIEV,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  DAI:KODS = BRW1::DAI:KODS
  DAI:NOSAUKUMS = BRW1::DAI:NOSAUKUMS
  DAI:NODALA = BRW1::DAI:NODALA
  DAI:F = BRW1::DAI:F
  DAI:ARG_NOS = BRW1::DAI:ARG_NOS
  DAI:TARL = BRW1::DAI:TARL
  DAI:ALGA = BRW1::DAI:ALGA
  DAI:PROC = BRW1::DAI:PROC
  DAI:T = BRW1::DAI:T
  DAI:IENAK_VEIDS = BRW1::DAI:IENAK_VEIDS
  DAI:DKK = BRW1::DAI:DKK
  DAI:KKK = BRW1::DAI:KKK
  F:IDP = BRW1::F:IDP
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
  BRW1::DAI:KODS = DAI:KODS
  BRW1::DAI:NOSAUKUMS = DAI:NOSAUKUMS
  BRW1::DAI:NODALA = DAI:NODALA
  BRW1::DAI:F = DAI:F
  BRW1::DAI:ARG_NOS = DAI:ARG_NOS
  BRW1::DAI:TARL = DAI:TARL
  BRW1::DAI:ALGA = DAI:ALGA
  BRW1::DAI:PROC = DAI:PROC
  BRW1::DAI:T = DAI:T
  BRW1::DAI:IENAK_VEIDS = DAI:IENAK_VEIDS
  BRW1::DAI:DKK = DAI:DKK
  BRW1::DAI:KKK = DAI:KKK
  BRW1::F:IDP = F:IDP
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
      POST(Event:Accepted,?Change )
      POST(Event:Accepted,?Delete:3)
      POST(Event:Accepted,?Select )
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => DAI:KODS
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
    OF 1
      BRW1::Sort1:LocatorValue = ''
      BRW1::Sort1:LocatorLength = 0
      DAI:KODS = BRW1::Sort1:LocatorValue
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
        POST(Event:Accepted,?Select )
        EXIT
      END
      POST(Event:Accepted,?Change )
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change )
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            DAI:KODS = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          DAI:KODS = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          DAI:KODS = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
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
    OF 1
      DAI:KODS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
  IF BRW1::ItemsToFill > 1
    IF SEND(DAIEV,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
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
        StandardWarning(Warn:RecordFetchError,'DAIEV')
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
  IF BRW1::QuickScan
    IF SEND(DAIEV,'QUICKSCAN=off').
    BRW1::QuickScan = False
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
      BRW1::HighlightedPosition = POSITION(DAI:KOD_KEY)
      RESET(DAI:KOD_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(DAI:KOD_KEY,DAI:KOD_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    '(~(F:IDP=''P'' AND DAI:KODS>900)  AND ~(F:IDP=''I'' AND DAI:KODS<<=900) )'
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
    OF 1; ?DAI:KODS{Prop:Disable} = 0
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
    ?Change {Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(DAI:Record)
    CASE BRW1::SortOrder
    OF 1; ?DAI:KODS{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change {Prop:Disable} = 1
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
    SET(DAI:KOD_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    '(~(F:IDP=''P'' AND DAI:KODS>900)  AND ~(F:IDP=''I'' AND DAI:KODS<<=900) )'
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
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.SelectButton=?Select 
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change 
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
  GET(DAIEV,0)
  CLEAR(DAI:Record,0)
  LocalRequest = InsertRecord
     OPEN(SCREEN2)
     DISPLAY
     ACCEPT
       CASE FIELD()
       OF ?OkButton2
         CASE EVENT()
         OF EVENT:Accepted
           IF KODS_NEW>0
              DAI:KODS=KODS_NEW
              IF DUPLICATE(DAI:KOD_KEY)
                 KLUDA(0,'Atkârtojas DAIEV kods:'&KODS_NEW)
              ELSE
                 BREAK
              .
           .
           SELECT(?KODS_NEW)
         .
       OF ?CancelButton2
         CASE EVENT()
         OF EVENT:Accepted
           KODS_NEW=0
           BREAK
         .
       .
     .
     CLOSE(SCREEN2)
     IF KODS_NEW=0
        EXIT
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
!| (UpPiesk) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
    CLOSE(BRW1::View:Browse)
    LOOP
      GlobalRequest = LocalRequest
      VCRRequest = VCRNone
      IF DAI:KODS <= 900
         UPPIESK
      ELSE
         UPIET
      .
      OMIT('UpPiesk')
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpPiesk
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
        GET(DAIEV,0)
        CLEAR(DAI:Record,0)
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


VIDALGA PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
SAK_YYMM             STRING(4)
BEI_YYMM             STRING(4)
SUM_M                DECIMAL(6,2)
SUM_A                DECIMAL(7,2)
MENESIEM             DECIMAL(1)
DIENAS_CAL           DECIMAL(2)
DIENAS_GRA           DECIMAL(2)
stundas_cal          BYTE
keksis               STRING(1)
SUMMAVID             DECIMAL(7,3)
SUMMAATV             DECIMAL(7,3)
DIENAS_N             BYTE
BR_S_DAT             LONG
BR_B_DAT             LONG
SUMMA_VIDN_D   DECIMAL(7,3)
SUMMA_VIDK     DECIMAL(7,2)
SUMMA_VIDC_D   DECIMAL(7,3)
STUNDAS_CALK   USHORT
STUNDAS_NOSK   USHORT
DIENAS_CALK    USHORT
DIENAS_GRAK    USHORT
SLODZE         DECIMAL(4,2)

BRW1::View:Browse    VIEW(ALGAS)
                       PROJECT(ALG:YYYYMM)
                       PROJECT(ALG:N_Stundas)
                       PROJECT(ALG:ID)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::keksis           LIKE(keksis)               ! Queue Display field
BRW1::ALG:YYYYMM       LIKE(ALG:YYYYMM)           ! Queue Display field
BRW1::SUM_A            LIKE(SUM_A)                ! Queue Display field
BRW1::SUM_M            LIKE(SUM_M)                ! Queue Display field
BRW1::DIENAS_CAL       LIKE(DIENAS_CAL)           ! Queue Display field
BRW1::stundas_cal      LIKE(stundas_cal)          ! Queue Display field
BRW1::ALG:N_Stundas    LIKE(ALG:N_Stundas)        ! Queue Display field
BRW1::DIENAS_GRA       LIKE(DIENAS_GRA)           ! Queue Display field
BRW1::BR_S_DAT         LIKE(BR_S_DAT)             ! Queue Display field
BRW1::BR_B_DAT         LIKE(BR_B_DAT)             ! Queue Display field
BRW1::PER:ID           LIKE(PER:ID)               ! Queue Display field
BRW1::ALG:ID           LIKE(ALG:ID)               ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(ALG:YYYYMM),DIM(100)
BRW1::Sort1:LowValue LIKE(ALG:YYYYMM)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(ALG:YYYYMM)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PER:ID LIKE(PER:ID)
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
QuickWindow          WINDOW('VIDALGA'),AT(,,267,280),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('VIDALGA'),SYSTEM,GRAY,MDI
                       LIST,AT(8,20,251,209),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('10C|M~X~@S1@35L(2)|M~Men.Gads~@D014.@32L(2)|M~Apr.Alga~@n8.2@38L(2)|M~Apr.VID~@n' &|
   '8.2@25R(1)|M~Cal.d.~C(0)@n3.0@23R(1)|M~Cal.st.~C(0)@n3@36R(1)|M~Nostr.st.~C(0)@n' &|
   '3B@12D(1)|M~Nostr.d. pçc 5d.~L(0)@n-3.0@'),FROM(Queue:Browse:1)
                       BUTTON('&X-atzîmçt/noòemt rçíinam'),AT(6,256,99,14),USE(?X)
                       SHEET,AT(2,4,261,250),USE(?CurrentTab)
                         TAB('ALG:ID_DAT'),USE(?Tab:2)
                           STRING('Vidçjâ alga:'),AT(10,233,185,9),USE(?StringVIDN),RIGHT
                           STRING(@n7.3),AT(197,232,33,10),USE(summa_VIDN_D)
                           STRING('Vidçjâ  atvaïinâjumam:'),AT(10,242,185,9),USE(?StringVIDC),RIGHT
                           STRING(@n7.3),AT(197,241,33,10),USE(summa_VIDC_D)
                         END
                       END
                       BUTTON('Iz&vçlçties'),AT(120,257,45,14),USE(?Select:2)
                       BUTTON('&Atlikt'),AT(170,257,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SUMMA=0
  FIRST#=TRUE
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF PER:YYYYMM
     BR_S_DAT=DATE(MONTH(PER:YYYYMM),1,YEAR(PER:YYYYMM)-1)
     BR_B_DAT=PER:YYYYMM
  ELSE
     BR_S_DAT=DATE(MONTH(TODAY()),1,YEAR(TODAY())-1)
     BR_B_DAT=TODAY()
  .
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
    OF ?X
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        FIRST#=FALSE
!        I#=INSTRING(FORMAT(ALG:YYYYMM,@N_5),KESKA,5)
        !STOP(I#&'='&FORMAT(ALG:YYYYMM,@N_5)&'='&KESKA)
!        IF I# !NOÒEMAM ATZÎMI
        IF BAND(ALG:BAITS,00000010B) !NOÒEMAM ATZÎMI
           ALG:BAITS-=2
!           P#=(I#-1)*5+1
!           KESKA[P#]=''
!           KESKA[P#+1]=''
!           KESKA[P#+2]=''
!           KESKA[P#+3]=''
!           KESKA[P#+4]=''
           KEKSIS=0
           DIENAS_CALK -=dienas_cal
           STUNDAS_CALK-=STUNDAS_CAL
           STUNDAS_NOSK-=ALG:N_STUNDAS
           SUMMA_VIDK  -=SUM_M
           SUMMA_VIDN_D=(SUMMA_VIDK/STUNDAS_NOSK)*8
           SUMMA_VIDC_D=(SUMMA_VIDK/STUNDAS_CALK)*8
           ?STRINGVIDN{PROP:TEXT}='Vidçjâ alga(NOSTR.LAIKS):'&SUMMA_VIDK&'/'&STUNDAS_NOSK/8&'='
           !23.09.2015 <
           DIENAS_GRAK -= DIENAS_GRA
           IF ~(DIENAS_GRAK=0)
              SUMMA_VIDN_D=SUMMA_VIDK/DIENAS_GRAK
              ?STRINGVIDN{PROP:TEXT}='Vidçjâ alga(NOSTR.DIENAS PÇC 5 d.):'&SUMMA_VIDK&'/'&DIENAS_GRAK&'='
           .
           !23.09.2015 >
           ?STRINGVIDC{PROP:TEXT}='Vidçjâ alga(KALENDÂRS):'&SUMMA_VIDK&'/'&STUNDAS_CALK/8&'='
           SLODZE=STUNDAS_NOSK/STUNDAS_CALK
        !   stop(SLODZE&' '&STUNDAS_NOSK&' '&STUNDAS_CALK)
        ELSE  !UZLIEKAM ATZÎMI
           ALG:BAITS+=2
!           KESKA=KESKA&FORMAT(ALG:YYYYMM,@N_5)
           KEKSIS=1
            DIENAS_CALK +=dienas_cal
           STUNDAS_CALK+=STUNDAS_CAL
           STUNDAS_NOSK+=ALG:N_STUNDAS
           SUMMA_VIDK  +=SUM_M
           SUMMA_VIDN_D=(SUMMA_VIDK/STUNDAS_NOSK)*8
           SUMMA_VIDC_D=(SUMMA_VIDK/STUNDAS_CALK)*8
           ?STRINGVIDN{PROP:TEXT}='Vidçjâ alga(NOSTR.LAIKS):'&SUMMA_VIDK&'/'&STUNDAS_NOSK/8&'='
           !23.09.2015 <
           DIENAS_GRAK += DIENAS_GRA
           IF ~(DIENAS_GRAK=0)
              SUMMA_VIDN_D=SUMMA_VIDK/DIENAS_GRAK
              ?STRINGVIDN{PROP:TEXT}='Vidçjâ alga(NOSTR.DIENAS PÇC 5 d.):'&SUMMA_VIDK&'/'&DIENAS_GRAK&'='
           .
           !23.09.2015 >
           ?STRINGVIDC{PROP:TEXT}='Vidçjâ alga(KALENDÂRS):'&SUMMA_VIDK&'/'&STUNDAS_CALK/8&'='
           SLODZE=STUNDAS_NOSK/STUNDAS_CALK
        .
        PUT(ALGAS)
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
        POST(Event:NewSelection)
        DISPLAY
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
    OF ?Select:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        IF PER:PAZIME='A'
        !   REALMAS[1] = SUMMA_VIDC_D   !KÂDREIZ TÂ BIJA
           REALMAS[1] = SUMMA_VIDN_D
           REALMAS[2] = SUMMA_VIDN_D
           REALMAS[3] = SLODZE
        ELSE
           REALMAS[1] = SUMMA_VIDN_D
           REALMAS[3] = SLODZE
        .
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        SUMMA = 0
        BILANCE = 0
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
  IF CAL::Used = 0
    CheckOpen(CAL,1)
  END
  CAL::Used += 1
  BIND(CAL:RECORD)
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
  INIRestoreWindow('VIDALGA','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  BIND('BR_S_DAT',BR_S_DAT)
  BIND('BR_B_DAT',BR_B_DAT)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    CAL::Used -= 1
    IF CAL::Used = 0 THEN CLOSE(CAL).
    PERNOS::Used -= 1
    IF PERNOS::Used = 0 THEN CLOSE(PERNOS).
  END
  IF WindowOpened
    INISaveWindow('VIDALGA','winlats.INI')
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
BRW1::ValidateRecord ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  BRW1::RecordStatus = Record:OutOfRange
  BRW1::RecordStatus = Record:Filtered
  !    SUM_M = 0
  !    LOOP I#= 1 TO 20
  !       IF ALG:K[I#]
  !          IF GETDAIEV(ALG:K[I#],2,1) AND DAI:ATVYN='Y'
  !             SUM_M+=ALG:R[I#]
  !          .
  !       .
  !    .
  !    SUM_K+=SUM_M
  !    DIENAS_CAL=CALCSTUNDAS(ALG:YYYYMM,0,0,0,2)
  !    dienas_calk+=dienas_cal
  BRW1::RecordStatus = Record:OK
  EXIT
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
    OF 1
      IF BRW1::Sort1:Reset:PER:ID <> PER:ID
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PER:ID = PER:ID
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
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  dienas_calk  =0
  STUNDAS_CALK =0
  STUNDAS_NOSK =0
  SUMMA_VIDK   =0
  DIENAS_GRAK =0  !23/09/2015
  
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ALGAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::ValidateRecord
    EXECUTE(BRW1::RecordStatus)
      BREAK
      CYCLE
    END
    DO BRW1::FillQueue
    !IF INSTRING(FORMAT(ALG:YYYYMM,@N_5),KESKA,5)
    IF BAND(ALG:BAITS,00000010B) !ÍEKSIS
       DIENAS_CALK +=dienas_cal
       STUNDAS_CALK+=STUNDAS_CAL
       STUNDAS_NOSK+=ALG:N_STUNDAS
       SUMMA_VIDK  +=SUM_M
       !23.09.2015 <
       DIENAS_GRAK += DIENAS_GRA
       !23.09.2015 >
    
    .
  END
  SUMMA_VIDN_D=(SUMMA_VIDK/STUNDAS_NOSK)*8
  SUMMA_VIDC_D=(SUMMA_VIDK/STUNDAS_CALK)*8
  SLODZE=STUNDAS_NOSK/STUNDAS_CALK
  IF SUMMA_VIDK
     ?STRINGVIDN{PROP:TEXT}='Dienas vidçjâ (Alga/NOSTR.LAIKS):'&SUMMA_VIDK&'/'&STUNDAS_NOSK/8&'='
     !23.09.2015 <
     IF ~(DIENAS_GRAK=0)
        SUMMA_VIDN_D=SUMMA_VIDK/DIENAS_GRAK
        ?STRINGVIDN{PROP:TEXT}='Dienas vidçjâ (Alga/NOSTR.DIENAS PÇC 5 d.):'&SUMMA_VIDK&'/'&DIENAS_GRAK&'='
     .
     !23.09.2015 >
     ?STRINGVIDC{PROP:TEXT}='Dienas vidçjâ (Alga/KALENDÂRS):'&SUMMA_VIDK&'/'&STUNDAS_CALK/8&'='
     DISPLAY
  .
  SETCURSOR()
  DO BRW1::Reset
  LOOP
    PREVIOUS(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ALGAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::ValidateRecord
    EXECUTE(BRW1::RecordStatus)
      BREAK
      CYCLE
    END
    BREAK
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = ALG:YYYYMM
  END
  DO BRW1::Reset
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ALGAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::ValidateRecord
    EXECUTE(BRW1::RecordStatus)
      BREAK
      CYCLE
    END
    BREAK
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = ALG:YYYYMM
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  keksis = BRW1::keksis
  ALG:YYYYMM = BRW1::ALG:YYYYMM
  SUM_A = BRW1::SUM_A
  SUM_M = BRW1::SUM_M
  DIENAS_CAL = BRW1::DIENAS_CAL
  stundas_cal = BRW1::stundas_cal
  ALG:N_Stundas = BRW1::ALG:N_Stundas
  DIENAS_GRA = BRW1::DIENAS_GRA
  BR_S_DAT = BRW1::BR_S_DAT
  BR_B_DAT = BRW1::BR_B_DAT
  PER:ID = BRW1::PER:ID
  ALG:ID = BRW1::ALG:ID
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
    SUM_M = 0
    SUM_A = 0
    DIENAS_GRA = 0 !24/09/2015
    LOOP I#= 1 TO 20
       IF ALG:K[I#]
  !        IF ~JAUBRIDINATS#  NOSPRÂGST.....
  !           IF ~GETDAIEV(ALG:K[I#],2,1)
  !              JAUBRIDINATS#=TRUE
  !           .
  !        .
          IF GETDAIEV(ALG:K[I#],0,7)='Y'   !Pieòemam, ka vidçjo visur rçíina vienâdi
             SUM_M+=ALG:R[I#]
          .
          SUM_A+=ALG:R[I#]
          !24/09/2015 <
          IF ~INRANGE(ALG:K[I#],840,842) AND ~INRANGE(ALG:K[I#],850,852) ! ~ATVAÏINÂJUMS UN ~SLILAPA
             DIENAS_GRA+=ALG:D[I#]
          .
          !24/09/2015 >
       .
    .
    DIENAS_CAL=CALCSTUNDAS(ALG:YYYYMM,0,0,0,2)
    STUNDAS_CAL=CALCSTUNDAS(ALG:YYYYMM,0,0,0,1)
    IF FIRST# !UZ JAUNU ATV/SLILAPU JÂSARAKSTA ALG:FAILÂ
  !    ALG:YYYYMM=DATE(MONTH(PER:YYYYMM)+6,1,YEAR(PER:YYYYMM)-1) !PÇDÇJIE 6 MÇNEÐI PIRMS yyyymm
      IF INRANGE(ALG:YYYYMM,DATE(MONTH(PER:YYYYMM)+6,1,YEAR(PER:YYYYMM)-1),DATE(MONTH(PER:YYYYMM),1,YEAR(PER:YYYYMM))-1)
      !PÇDÇJIE 6 MÇNEÐI PIRMS ATVAÏINÂJUMA IZMAKSÂÐANAS, +6 DÇÏ MONTH()
  !       IF ~INSTRING(FORMAT(ALG:YYYYMM,@N_5),KESKA,5)
  !          KESKA=KESKA&FORMAT(ALG:YYYYMM,@N_5)
  !       .
      .
    .
  !  IF INSTRING(FORMAT(ALG:YYYYMM,@N_5),KESKA,5)
    IF BAND(ALG:BAITS,00000010B)
       KEKSIS='X'
    ELSE
       KEKSIS=''
    .
  BRW1::keksis = keksis
  BRW1::ALG:YYYYMM = ALG:YYYYMM
  BRW1::SUM_A = SUM_A
  BRW1::SUM_M = SUM_M
  BRW1::DIENAS_CAL = DIENAS_CAL
  BRW1::stundas_cal = stundas_cal
  BRW1::ALG:N_Stundas = ALG:N_Stundas
  BRW1::DIENAS_GRA = DIENAS_GRA
  BRW1::BR_S_DAT = BR_S_DAT
  BRW1::BR_B_DAT = BR_B_DAT
  BRW1::PER:ID = PER:ID
  BRW1::ALG:ID = ALG:ID
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
    ELSE
      BRW1::PopupText = '~Iz&vçlçties'
    END
    EXECUTE(POPUP(BRW1::PopupText))
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
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => ALG:YYYYMM
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
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
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
    OF 1
      ALG:YYYYMM = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'ALGAS')
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
    DO BRW1::ValidateRecord
    EXECUTE(BRW1::RecordStatus)
      BEGIN
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        END
        DO BRW1::FillBuffer
        BREAK
      END
      CYCLE
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
      BRW1::HighlightedPosition = POSITION(ALG:ID_DAT)
      RESET(ALG:ID_DAT,BRW1::HighlightedPosition)
    ELSE
      ALG:ID = PER:ID
      SET(ALG:ID_DAT,ALG:ID_DAT)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:ID = PER:ID AND (INRANGE(ALG:YYYYMM,BR_S_DAT,BR_B_DAT))'
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
  ELSE
    CLEAR(ALG:Record)
    BRW1::CurrentChoice = 0
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
    ALG:ID = PER:ID
    SET(ALG:ID_DAT)
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:ID = PER:ID AND (INRANGE(ALG:YYYYMM,BR_S_DAT,BR_B_DAT))'
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
    PER:ID = BRW1::Sort1:Reset:PER:ID
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.SelectButton=?Select:2
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
    IF BrowseButtons.SelectButton THEN
      TBarBrwSelect{PROP:DISABLE}=BrowseButtons.SelectButton{PROP:DISABLE}
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

