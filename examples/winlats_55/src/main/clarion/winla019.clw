                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateTEK_K PROCEDURE


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
par_nos_s            STRING(15)
DK_KKK               STRING(3),DIM(2)
NodText              STRING(25)
ProText              STRING(25)
LIST:ATT_DOK         QUEUE,PRE()
ATT_DOK              STRING(23)
                     END
CTRL                 DECIMAL(7,3)
Update::Reloop  BYTE
Update::Error   BYTE
History::TEK:Record LIKE(TEK:Record),STATIC
SAV::TEK:Record      LIKE(TEK:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the TEK File'),AT(,,378,315),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateTEK'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(7,5,371,289),USE(?CurrentTab)
                         TAB('Autokontçjuma sagatave'),USE(?Tab:1)
                           PROMPT('&Teksts:'),AT(33,24),USE(?TEK:TEKSTS:Prompt)
                           ENTRY(@s47),AT(60,24,165,10),USE(TEK:TEKSTS),REQ,OVR
                           ENTRY(@s47),AT(60,35,165,10),USE(TEK:TEKSTS2),OVR
                           ENTRY(@s47),AT(60,46,165,10),USE(TEK:TEKSTS3),OVR
                           OPTION('Reference uz agrâk ievadîtu dokumentu'),AT(232,21,139,36),USE(TEK:ref_obj),DISABLE,BOXED
                             RADIO('nav'),AT(240,30),USE(?TEK:ref_obj:Radio0),VALUE('0')
                             RADIO('Rçíinu vai P/Z tekoðajâ bâzç'),AT(240,40),USE(?TEK:ref_obj:Radio1),VALUE('1')
                           END
                           OPTION('&Kontçjuma tips'),AT(16,59,99,48),USE(TEK:TIPS),BOXED
                             RADIO('Autokontçjums'),AT(19,70),USE(?TEK:TIPS:Radio1)
                             RADIO('Manuâls'),AT(19,80),USE(?TEK:TIPS:Radio2)
                             RADIO('Dubultais autokontçjums'),AT(19,91,93,10),USE(?TEK:TIPS:Radio3)
                           END
                           BUTTON('&Nodaïa'),AT(121,59,75,14),USE(?Nodala)
                           STRING(@s2),AT(211,61,9,10),USE(TEK:NODALA),RIGHT
                           STRING(@s25),AT(223,61),USE(NodText),LEFT
                           BUTTON('&Projekts (Objekts)'),AT(121,75,75,14),USE(?Projekts)
                           STRING(@s25),AT(223,76),USE(ProText),LEFT
                           PROMPT('Attaisnojuma dokuments :'),AT(136,92),USE(?PromptATTDOK)
                           LIST,AT(223,90,107,12),USE(ATT_DOK),FORMAT('56L@s23@'),DROP(10),FROM(List:ATT_DOK)
                           STRING(@n_5b),AT(198,76,22,10),USE(TEK:OBJ_NR),RIGHT
                           BUTTON('&Partneris'),AT(18,109,45,14),USE(?Partneris)
                           STRING(@n_7B),AT(66,112),USE(TEK:PAR_NR)
                           STRING(@s15),AT(100,112),USE(TEK:PAR_NOS)
                           BUTTON('&Avansieris'),AT(18,127,45,14),USE(?Avansieris),DISABLE
                           STRING(@n_7B),AT(66,128),USE(TEK:AVA_NR),DISABLE
                           STRING(@s15),AT(100,128),USE(TEK:AVA_NOS),DISABLE
                           OPTION('PVN_TIPS'),AT(215,105,156,186),USE(TEK:PVN_TIPS),BOXED
                             RADIO('0-Iekðzemç un ES saòemtais(samaks.)'),AT(221,114),USE(?TEK:PVN_TIPS:Radio1)
                             RADIO('1-norçíini ar budþetu'),AT(221,123),USE(?TEK:PVN_TIPS:Radio2)
                             RADIO('2-par importa ~ES preèu piegâdçm'),AT(221,131),USE(?TEK:PVN_TIPS:Radio3)
                             RADIO('3-kokmat.iegâde (vairumtirdzniecîba)'),AT(221,140),USE(?TEK:PVN_TIPS:Radio4)
                             RADIO('4-kokmat.iegâde (mazumtirdzniecîba)'),AT(221,150),USE(?TEK:PVN_TIPS:Radio5)
                             RADIO('5-kokmat.realiz. (vairumtirdzniecîba)'),AT(221,162),USE(?TEK:PVN_TIPS:Radio6)
                             RADIO('6-kokmat.realiz.(mazumtirdzniecîba)'),AT(221,170),USE(?TEK:PVN_TIPS:Radio7)
                             RADIO('7-PVN pârkontçðana'),AT(221,180),USE(?TEK:PVN_TIPS:Radio7:2)
                             RADIO('8-kokmateriâlu pakalpojumu iegâde'),AT(221,188),USE(?TEK:PVN_TIPS:Radio9)
                             RADIO('9-kokmateriâlu pakalpojumu realizâcija'),AT(221,198),USE(?TEK:PVN_TIPS:Radio10)
                             RADIO('N-iekðzemç nesamaksâtais PVN'),AT(221,207),USE(?TEK:PVN_TIPS:Radio11)
                             RADIO('I-par importa arî ES pakalpojumiem'),AT(221,217,136,10),USE(?TEK:PVN_TIPS:Radio12 )
                             RADIO('A-atgriezta prece'),AT(221,227),USE(?TEK:PVN_TIPS:Radio13)
                             RADIO('Z-zaudçts parâds'),AT(221,236),USE(?TEK:PVN_TIPS:Radio14),VALUE('Z')
                             RADIO('R1-darîjumi ar kokmateriâliem'),AT(221,245,130,10),USE(?TEK:PVN_TIPS:Radio15),VALUE('K')
                             RADIO('R2-darîjumi ar metâllûþòiem'),AT(221,253,130,10),USE(?TEK:PVN_TIPS:Radio16),VALUE('M')
                             RADIO('R3-bûvniecîbas pakalpojumi'),AT(221,261,130,10),USE(?TEK:PVN_TIPS:Radio17),VALUE('B')
                             RADIO('E- Neapliekâmai realizâcijai'),AT(221,270,130,10),USE(?TEK:PVN_TIPS:Radio17:2),VALUE('E')
                             RADIO('R- Proporcijas aprçíinam'),AT(221,279,130,10),USE(?TEK:PVN_TIPS:Radio17:3),VALUE('R')
                           END
                           STRING(' D/K   Konta kods '),AT(61,148,61,10),USE(?String1)
                           BUTTON('PVN  %'),AT(123,144,41,14),USE(?ButtonPVN)
                           STRING(' Svars'),AT(169,148),USE(?String10)
                           PROMPT('&1:'),AT(49,160),USE(?TEK:D_1:Prompt)
                           ENTRY(@s1),AT(63,160,14,10),USE(TEK:D_K1),CENTER,UPR
                           ENTRY(@s5),AT(81,160,40,10),USE(TEK:BKK_1)
                           ENTRY(@n2B),AT(129,160,21,10),USE(TEK:PVN_1),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,160,40,10),USE(TEK:K_1),RIGHT(1)
                           PROMPT('&2:'),AT(49,172),USE(?TEK:D_2:Prompt)
                           ENTRY(@s1),AT(63,172,14,10),USE(TEK:D_K2),CENTER,UPR
                           ENTRY(@s5),AT(81,172,40,10),USE(TEK:BKK_2)
                           ENTRY(@n2B),AT(129,172,21,10),USE(TEK:PVN_2),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,172,40,10),USE(TEK:K_2),RIGHT(1)
                           PROMPT('&3:'),AT(49,185),USE(?TEK:D_3:Prompt)
                           ENTRY(@s1),AT(63,185,14,10),USE(TEK:D_K3),CENTER,UPR
                           ENTRY(@s5),AT(81,185,40,10),USE(TEK:BKK_3)
                           ENTRY(@n2B),AT(129,185,21,10),USE(TEK:PVN_3),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,185,40,10),USE(TEK:K_3),RIGHT(1)
                           PROMPT('&4:'),AT(49,198),USE(?TEK:D_4:Prompt)
                           ENTRY(@s1),AT(63,198,14,10),USE(TEK:D_K4),CENTER,UPR
                           ENTRY(@s5),AT(81,198,40,10),USE(TEK:BKK_4)
                           ENTRY(@n2B),AT(129,198,21,10),USE(TEK:PVN_4),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,198,40,10),USE(TEK:K_4),RIGHT(1)
                           PROMPT('&5:'),AT(49,210),USE(?TEK:D_5:Prompt)
                           ENTRY(@s1),AT(63,210,14,10),USE(TEK:D_K5),CENTER,UPR
                           ENTRY(@s5),AT(81,210,40,10),USE(TEK:BKK_5)
                           ENTRY(@n2B),AT(129,210,21,10),USE(TEK:PVN_5),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,210,40,10),USE(TEK:K_5),RIGHT(1)
                           PROMPT('&6:'),AT(49,223),USE(?TEK:D_6:Prompt)
                           ENTRY(@s1),AT(63,223,14,10),USE(TEK:D_K6),CENTER,UPR
                           ENTRY(@s5),AT(81,223,40,10),USE(TEK:BKK_6)
                           ENTRY(@n2B),AT(129,223,21,10),USE(TEK:PVN_6),RIGHT(1)
                           ENTRY(@n7.3B),AT(159,223,40,10),USE(TEK:K_6),RIGHT(1)
                         END
                       END
                       BUTTON('&OK'),AT(278,298,45,16),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(326,298,45,16),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    IF LOCALREQUEST=2
      par_nos_s=GETpar_k(tek:par_nr,0,1)
    .
!    IF YEAR(DB_S_DAT)>2009
    IF DB_GADS>2009
       ATT_DOK=' ' !NAV
       ADD(LIST:ATT_DOK)
       ATT_DOK='1-nodokïa rçíins'
       ADD(LIST:ATT_DOK)
       ATT_DOK='2-kases èeks vai kvîts'
       ADD(LIST:ATT_DOK)
       ATT_DOK='3-bezskaidras naudas MD'
       ADD(LIST:ATT_DOK)
       ATT_DOK='4-kredîtrçíins'
       ADD(LIST:ATT_DOK)
       ATT_DOK='5-cits'
       ADD(LIST:ATT_DOK)
       ATT_DOK='6-muitas deklarâcija'
       ADD(LIST:ATT_DOK)
       ATT_DOK='X-atseviðíi neuzrâdâmie'
       ADD(LIST:ATT_DOK)
       NR#=TEK:ATT_DOK
    ELSE
       ATT_DOK=' ' !NAV
       ADD(LIST:ATT_DOK)
       ATT_DOK='1-Cits'
       ADD(LIST:ATT_DOK)
       ATT_DOK='2-PPR'
       ADD(LIST:ATT_DOK)
       ATT_DOK='3-Maks.dok'
       ADD(LIST:ATT_DOK)
       ATT_DOK='4-EKA èeks'
       ADD(LIST:ATT_DOK)
       ATT_DOK='5-Lîgums'
       ADD(LIST:ATT_DOK)
       ATT_DOK='6-Faktûrrçíins'
       ADD(LIST:ATT_DOK)
       ATT_DOK='7-Kredîtrçíins'
       ADD(LIST:ATT_DOK)
       ATT_DOK='8-Akts'
       ADD(LIST:ATT_DOK)
       ATT_DOK='9-Protokols'
       ADD(LIST:ATT_DOK)
       ATT_DOK='0-Muitas dekl.'
       ADD(LIST:ATT_DOK)
       IF TEK:ATT_DOK='0'
          NR#=TEK:ATT_DOK+10
       ELSE
          NR#=TEK:ATT_DOK
       .
    .
    GET(LIST:ATT_DOK,NR#+1) !STRINGU NEÒEM
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !getpar_k(tek:par_nr)
  !disable(?TEK:ref_obj)
  !disable(?TEK:PVN_TIPS)
  IF DB_GADS >= 2003
     DISABLE(?TEK:PVN_TIPS:Radio11)
  .
  ProText=GETPROJEKTI(TEK:OBJ_NR,1)
  NodText=GETNODALAS(TEK:NODALA,1)
  IF BAND(TEK:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
     ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
  .
  !*******USER LEVEL ACCESS CONTROL********
  IF BAND(REG_BASE_ACC,00000010b) ! Budþets
     ?Projekts{PROP:TEXT}='Klasifikâcijas kods'
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
    !BKK KONTROLE
    !   TEK:BKK_1=GETKON_K(TEK:BKK_1,0,1)
    !   TEK:BKK_2=GETKON_K(TEK:BKK_2,0,1)
    !   TEK:BKK_3=GETKON_K(TEK:BKK_3,0,1)
    !   TEK:BKK_4=GETKON_K(TEK:BKK_4,0,1)
    !   TEK:BKK_5=GETKON_K(TEK:BKK_5,0,1)
    !   TEK:BKK_6=GETKON_K(TEK:BKK_6,0,1)
    !D/K KONTI
       DK_KKK[1]='231'    !Saòemts no pircçjiem (pçcapmaksa)
       DK_KKK[2]='531'    !Samaksâts PIEGÂDÂTÂJAM (pçcapmaksa)
       J#=0
       LOOP I#=1 TO 2
          J#=INSTRING(DK_KKK[I#],TEK:BKK_1[1:3]&TEK:BKK_2[1:3]&TEK:BKK_3[1:3]&TEK:BKK_4[1:3]&TEK:BKK_5[1:3]&TEK:BKK_6[1:3],3,1)
          IF J# THEN BREAK.
       .
       execute j#
          d_k=TEK:D_K1
          d_k=TEK:D_K2
          d_k=TEK:D_K3
          d_k=TEK:D_K4
          d_k=TEK:D_K5
          d_k=TEK:D_K6
       .
       IF I#=1 AND D_K='K' OR|
          I#=2 AND D_K='D'
          ENABLE(?TEK:ref_obj)
       ELSE
          TEK:ref_obj=0
          DISABLE(?TEK:ref_obj)
       .
    !PVN KONTS
       IF INSTRING('572',TEK:BKK_1[1:3]&TEK:BKK_2[1:3]&TEK:BKK_3[1:3]&TEK:BKK_4[1:3]&TEK:BKK_5[1:3]&TEK:BKK_6[1:3],3,1)
          ENABLE(?TEK:PVN_TIPS)
!       ELSIF (TEK:PVN_1 =0 AND INRANGE(TEK:BKK_1[1:2],'59','99') AND TEK:D_K1 = 'K') OR|
!            (TEK:PVN_2 =0 AND INRANGE(TEK:BKK_2[1:2],'59','99') AND TEK:D_K2 = 'K') OR|
!            (TEK:PVN_3 =0 AND INRANGE(TEK:BKK_3[1:2],'59','99') AND TEK:D_K3 = 'K') OR|
!            (TEK:PVN_4 =0 AND INRANGE(TEK:BKK_4[1:2],'59','99') AND TEK:D_K4 = 'K') OR|
!            (TEK:PVN_5 =0 AND INRANGE(TEK:BKK_5[1:2],'59','99') AND TEK:D_K5 = 'K') OR|
!            (TEK:PVN_6 =0 AND INRANGE(TEK:BKK_6[1:2],'59','99') AND TEK:D_K6 = 'K')
!          ENABLE(?TEK:PVN_TIPS)
       ELSE
          TEK:PVN_TIPS=0
          DISABLE(?TEK:PVN_TIPS)
       .
    !AVANSIERU KONTS
       IF INSTRING('238',TEK:BKK_1[1:3]&TEK:BKK_2[1:3]&TEK:BKK_3[1:3]&TEK:BKK_4[1:3]&TEK:BKK_5[1:3]&TEK:BKK_6[1:3],3,1)
          ENABLE(?AVANSIERIS)
          ENABLE(?TEK:AVA_NR)
          ENABLE(?TEK:AVA_NOS)
       ELSE
          TEK:AVA_NR=0
          DISABLE(?AVANSIERIS)
          DISABLE(?TEK:AVA_NR)
          DISABLE(?TEK:AVA_NOS)
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
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?TEK:TEKSTS:Prompt)
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
        History::TEK:Record = TEK:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(TEK_K)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?TEK:TEKSTS:Prompt)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::TEK:Record <> TEK:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:TEK_K(1)
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
              SELECT(?TEK:TEKSTS:Prompt)
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
          OF 3
          OF 4
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?TEK:TEKSTS
      CASE EVENT()
      OF EVENT:Accepted
        tek:ini=inigen(TEK:TEKSTS,15,1)
      END
    OF ?Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GlobalResponse = RequestCompleted
            TEK:NODALA = NOD:U_NR
            NodText = NOD:NOS_P
        END
      END
    OF ?Projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GlobalResponse = RequestCompleted
            TEK:OBJ_NR = PRO:U_NR
            ProText = PRO:NOS_P
        END
      END
    OF ?ATT_DOK
      CASE EVENT()
      OF EVENT:Accepted
        TEK:ATT_DOK=ATT_DOK[1]
      END
    OF ?Partneris
      CASE EVENT()
      OF EVENT:Accepted
        PAR:U_NR=TEK:PAR_NR
        PAR_TIPS='EFCNIR'
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           tek:PAR_NR=PAR:U_NR
           IF PAR:U_NR
              TEK:par_nos=PAR:NOS_S
           ELSE
              TEK:par_nos=''
           .
           DISPLAY
        .
      END
    OF ?Avansieris
      CASE EVENT()
      OF EVENT:Accepted
        par_nr=TEK:AVA_NR
        PAR_TIPS='F'
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           tek:AVA_NR=PAR:U_NR
           IF PAR:U_NR
              tek:AVA_nos=PAR:NOS_S
           ELSE
              tek:AVA_nos=''
           .
           DISPLAY
        .
      END
    OF ?ButtonPVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(TEK:BAITS,00000010b)    !AR PVN NEAPLIEKAMS
           TEK:BAITS-=2
           ?BUTTONPVN{PROP:TEXT}='PVN  %'
        ELSE
           TEK:BAITS+=2
           TEK:PVN_1=0
           TEK:PVN_2=0
           TEK:PVN_3=0
           TEK:PVN_4=0
           TEK:PVN_5=0
           TEK:PVN_6=0
           ?BUTTONPVN{PROP:TEXT}='PVN neapl.'
        .
        DISPLAY
      END
    OF ?TEK:BKK_1
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_1
           KKK=TEK:BKK_1
           TEK:BKK_1=GETKON_K(TEK:BKK_1,1,1)
           DISPLAY
        .
      END
    OF ?TEK:BKK_2
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_2
           KKK=TEK:BKK_2
           TEK:BKK_2=GETKON_K(TEK:BKK_2,1,1)
           DISPLAY
        .
      END
    OF ?TEK:BKK_3
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_3
           KKK=TEK:BKK_3
           TEK:BKK_3=GETKON_K(TEK:BKK_3,1,1)
           DISPLAY
        .
      END
    OF ?TEK:BKK_4
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_4
           KKK=TEK:BKK_4
           TEK:BKK_4=GETKON_K(TEK:BKK_4,1,1)
           DISPLAY
        .
      END
    OF ?TEK:BKK_5
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_5
           KKK=TEK:BKK_5
           TEK:BKK_5=GETKON_K(TEK:BKK_5,1,1)
           DISPLAY
        .
      END
    OF ?TEK:BKK_6
      CASE EVENT()
      OF EVENT:Accepted
        IF TEK:BKK_6
           KKK=TEK:BKK_6
           TEK:BKK_6=GETKON_K(TEK:BKK_6,1,1)
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
        !LOÌIKAS KONTROLE
         CTRL=0
         IF TEK:D_K1='D'
            CTRL+=TEK:K_1
         ELSE
            CTRL-=TEK:K_1
         .
         IF TEK:D_K2='D'
            CTRL+=TEK:K_2
         ELSE
            CTRL-=TEK:K_2
         .
         IF TEK:D_K3='D'
            CTRL+=TEK:K_3
         ELSE
            CTRL-=TEK:K_3
         .
         IF TEK:D_K4='D'
            CTRL+=TEK:K_4
         ELSE
            CTRL-=TEK:K_4
         .
         IF TEK:D_K5='D'
            CTRL+=TEK:K_5
         ELSE
            CTRL-=TEK:K_5
         .
         IF TEK:D_K6='D'
            CTRL+=TEK:K_6
         ELSE
            CTRL-=TEK:K_6
         .
         IF CTRL
            KLUDA(28,CTRL)
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
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF TEK_K::Used = 0
    CheckOpen(TEK_K,1)
  END
  TEK_K::Used += 1
  BIND(TEK:RECORD)
  FilesOpened = True
  RISnap:TEK_K
  SAV::TEK:Record = TEK:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
    IF ~COPYREQUEST
       TEK:PVN_1=SYS:NOKL_PVN
       TEK:PVN_2=SYS:NOKL_PVN
       TEK:PVN_3=SYS:NOKL_PVN
       TEK:PVN_4=SYS:NOKL_PVN
       TEK:PVN_5=SYS:NOKL_PVN
       TEK:PVN_6=SYS:NOKL_PVN
       TEK:TIPS='A'
       TEK:PVN_TIPS='0'
    .
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:TEK_K()
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
  INIRestoreWindow('UpdateTEK_K','winlats.INI')
  WinResize.Resize
  ?TEK:TEKSTS{PROP:Alrt,255} = 734
  ?TEK:TEKSTS2{PROP:Alrt,255} = 734
  ?TEK:TEKSTS3{PROP:Alrt,255} = 734
  ?TEK:ref_obj{PROP:Alrt,255} = 734
  ?TEK:TIPS{PROP:Alrt,255} = 734
  ?TEK:NODALA{PROP:Alrt,255} = 734
  ?TEK:OBJ_NR{PROP:Alrt,255} = 734
  ?TEK:PAR_NR{PROP:Alrt,255} = 734
  ?TEK:PAR_NOS{PROP:Alrt,255} = 734
  ?TEK:AVA_NR{PROP:Alrt,255} = 734
  ?TEK:AVA_NOS{PROP:Alrt,255} = 734
  ?TEK:PVN_TIPS{PROP:Alrt,255} = 734
  ?TEK:D_K1{PROP:Alrt,255} = 734
  ?TEK:BKK_1{PROP:Alrt,255} = 734
  ?TEK:PVN_1{PROP:Alrt,255} = 734
  ?TEK:K_1{PROP:Alrt,255} = 734
  ?TEK:D_K2{PROP:Alrt,255} = 734
  ?TEK:BKK_2{PROP:Alrt,255} = 734
  ?TEK:PVN_2{PROP:Alrt,255} = 734
  ?TEK:K_2{PROP:Alrt,255} = 734
  ?TEK:D_K3{PROP:Alrt,255} = 734
  ?TEK:BKK_3{PROP:Alrt,255} = 734
  ?TEK:PVN_3{PROP:Alrt,255} = 734
  ?TEK:K_3{PROP:Alrt,255} = 734
  ?TEK:D_K4{PROP:Alrt,255} = 734
  ?TEK:BKK_4{PROP:Alrt,255} = 734
  ?TEK:PVN_4{PROP:Alrt,255} = 734
  ?TEK:K_4{PROP:Alrt,255} = 734
  ?TEK:D_K5{PROP:Alrt,255} = 734
  ?TEK:BKK_5{PROP:Alrt,255} = 734
  ?TEK:PVN_5{PROP:Alrt,255} = 734
  ?TEK:K_5{PROP:Alrt,255} = 734
  ?TEK:D_K6{PROP:Alrt,255} = 734
  ?TEK:BKK_6{PROP:Alrt,255} = 734
  ?TEK:PVN_6{PROP:Alrt,255} = 734
  ?TEK:K_6{PROP:Alrt,255} = 734
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
    TEK_K::Used -= 1
    IF TEK_K::Used = 0 THEN CLOSE(TEK_K).
  END
  IF WindowOpened
    INISaveWindow('UpdateTEK_K','winlats.INI')
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
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?TEK:TEKSTS
      TEK:TEKSTS = History::TEK:Record.TEKSTS
    OF ?TEK:TEKSTS2
      TEK:TEKSTS2 = History::TEK:Record.TEKSTS2
    OF ?TEK:TEKSTS3
      TEK:TEKSTS3 = History::TEK:Record.TEKSTS3
    OF ?TEK:ref_obj
      TEK:ref_obj = History::TEK:Record.ref_obj
    OF ?TEK:TIPS
      TEK:TIPS = History::TEK:Record.TIPS
    OF ?TEK:NODALA
      TEK:NODALA = History::TEK:Record.NODALA
    OF ?TEK:OBJ_NR
      TEK:OBJ_NR = History::TEK:Record.OBJ_NR
    OF ?TEK:PAR_NR
      TEK:PAR_NR = History::TEK:Record.PAR_NR
    OF ?TEK:PAR_NOS
      TEK:PAR_NOS = History::TEK:Record.PAR_NOS
    OF ?TEK:AVA_NR
      TEK:AVA_NR = History::TEK:Record.AVA_NR
    OF ?TEK:AVA_NOS
      TEK:AVA_NOS = History::TEK:Record.AVA_NOS
    OF ?TEK:PVN_TIPS
      TEK:PVN_TIPS = History::TEK:Record.PVN_TIPS
    OF ?TEK:D_K1
      TEK:D_K1 = History::TEK:Record.D_K1
    OF ?TEK:BKK_1
      TEK:BKK_1 = History::TEK:Record.BKK_1
    OF ?TEK:PVN_1
      TEK:PVN_1 = History::TEK:Record.PVN_1
    OF ?TEK:K_1
      TEK:K_1 = History::TEK:Record.K_1
    OF ?TEK:D_K2
      TEK:D_K2 = History::TEK:Record.D_K2
    OF ?TEK:BKK_2
      TEK:BKK_2 = History::TEK:Record.BKK_2
    OF ?TEK:PVN_2
      TEK:PVN_2 = History::TEK:Record.PVN_2
    OF ?TEK:K_2
      TEK:K_2 = History::TEK:Record.K_2
    OF ?TEK:D_K3
      TEK:D_K3 = History::TEK:Record.D_K3
    OF ?TEK:BKK_3
      TEK:BKK_3 = History::TEK:Record.BKK_3
    OF ?TEK:PVN_3
      TEK:PVN_3 = History::TEK:Record.PVN_3
    OF ?TEK:K_3
      TEK:K_3 = History::TEK:Record.K_3
    OF ?TEK:D_K4
      TEK:D_K4 = History::TEK:Record.D_K4
    OF ?TEK:BKK_4
      TEK:BKK_4 = History::TEK:Record.BKK_4
    OF ?TEK:PVN_4
      TEK:PVN_4 = History::TEK:Record.PVN_4
    OF ?TEK:K_4
      TEK:K_4 = History::TEK:Record.K_4
    OF ?TEK:D_K5
      TEK:D_K5 = History::TEK:Record.D_K5
    OF ?TEK:BKK_5
      TEK:BKK_5 = History::TEK:Record.BKK_5
    OF ?TEK:PVN_5
      TEK:PVN_5 = History::TEK:Record.PVN_5
    OF ?TEK:K_5
      TEK:K_5 = History::TEK:Record.K_5
    OF ?TEK:D_K6
      TEK:D_K6 = History::TEK:Record.D_K6
    OF ?TEK:BKK_6
      TEK:BKK_6 = History::TEK:Record.BKK_6
    OF ?TEK:PVN_6
      TEK:PVN_6 = History::TEK:Record.PVN_6
    OF ?TEK:K_6
      TEK:K_6 = History::TEK:Record.K_6
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
  TEK:Record = SAV::TEK:Record
  SAV::TEK:Record = TEK:Record
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

BrowseTEK_K PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
PR                   BYTE

BRW1::View:Browse    VIEW(TEK_K)
                       PROJECT(TEK:TEKSTS)
                       PROJECT(TEK:TIPS)
                       PROJECT(TEK:ref_obj)
                       PROJECT(TEK:ATT_DOK)
                       PROJECT(TEK:PAR_NOS)
                       PROJECT(TEK:AVA_NOS)
                       PROJECT(TEK:PVN_1)
                       PROJECT(TEK:D_K1)
                       PROJECT(TEK:BKK_1)
                       PROJECT(TEK:D_K2)
                       PROJECT(TEK:BKK_2)
                       PROJECT(TEK:D_K3)
                       PROJECT(TEK:BKK_3)
                       PROJECT(TEK:D_K4)
                       PROJECT(TEK:BKK_4)
                       PROJECT(TEK:D_K5)
                       PROJECT(TEK:BKK_5)
                       PROJECT(TEK:D_K6)
                       PROJECT(TEK:BKK_6)
                       PROJECT(TEK:INI)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::TEK:TEKSTS       LIKE(TEK:TEKSTS)           ! Queue Display field
BRW1::TEK:TIPS         LIKE(TEK:TIPS)             ! Queue Display field
BRW1::TEK:ref_obj      LIKE(TEK:ref_obj)          ! Queue Display field
BRW1::TEK:ATT_DOK      LIKE(TEK:ATT_DOK)          ! Queue Display field
BRW1::TEK:PAR_NOS      LIKE(TEK:PAR_NOS)          ! Queue Display field
BRW1::TEK:AVA_NOS      LIKE(TEK:AVA_NOS)          ! Queue Display field
BRW1::TEK:PVN_1        LIKE(TEK:PVN_1)            ! Queue Display field
BRW1::TEK:D_K1         LIKE(TEK:D_K1)             ! Queue Display field
BRW1::TEK:BKK_1        LIKE(TEK:BKK_1)            ! Queue Display field
BRW1::TEK:D_K2         LIKE(TEK:D_K2)             ! Queue Display field
BRW1::TEK:BKK_2        LIKE(TEK:BKK_2)            ! Queue Display field
BRW1::TEK:D_K3         LIKE(TEK:D_K3)             ! Queue Display field
BRW1::TEK:BKK_3        LIKE(TEK:BKK_3)            ! Queue Display field
BRW1::TEK:D_K4         LIKE(TEK:D_K4)             ! Queue Display field
BRW1::TEK:BKK_4        LIKE(TEK:BKK_4)            ! Queue Display field
BRW1::TEK:D_K5         LIKE(TEK:D_K5)             ! Queue Display field
BRW1::TEK:BKK_5        LIKE(TEK:BKK_5)            ! Queue Display field
BRW1::TEK:D_K6         LIKE(TEK:D_K6)             ! Queue Display field
BRW1::TEK:BKK_6        LIKE(TEK:BKK_6)            ! Queue Display field
BRW1::TEK:INI          LIKE(TEK:INI)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(TEK:INI),DIM(100)
BRW1::Sort1:LowValue LIKE(TEK:INI)                ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(TEK:INI)               ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Tekstu plâns'),AT(0,0,539,284),FONT('MS Sans Serif',8,,FONT:regular),IMM,HLP('BrowseTEK'),SYSTEM,GRAY,MAX,RESIZE,MDI
                       MENUBAR
                         MENU('&5-Speciâlâs funkcijas'),USE(?5Speciâlâsfunkcijas)
                           ITEM('&1-Mainît PVN% un svaru'),USE(?5Speciâlâsfunkcijas1MainîtPVN)
                         END
                       END
                       LIST,AT(6,19,527,239),USE(?Browse:1),IMM,HVSCROLL,FONT(,9,,FONT:bold),MSG('Browsing Records'),FORMAT('162L(2)|M~Teksts~@s47@10C|M~T~@s1@12R(2)|M~R~C(0)@n2b@10C|M~A~@s1@61L(1)|M~Partn' &|
   'eris~C(0)@s15@60L(1)|M~Avansieris~C(0)@s15@12R(1)M~%~C(0)@n2B@10R(1)M@s1@25C|M~K' &|
   'onts~@s5@10R(1)M@s1@23C|M~Konts~@s5@10R(1)M@s1@23C|M~Konts~@s5@10R(1)M@s1@24C|M~' &|
   'Konts~L(2)@s5@10R(1)M@s1@26C|M~Konts~L(2)@s5@10R(1)M@s1@20C|M~Konts~@s5@'),FROM(Queue:Browse:1)
                       SHEET,AT(-1,0,541,283),USE(?CurrentTab),FONT(,8,,FONT:bold)
                         TAB('Nosaukumu secîba'),USE(?Tab:2)
                           ENTRY(@s10),AT(56,263),USE(TEK:INI),IMM,OVR
                           BUTTON('&C-Kopçt'),AT(206,262,47,14),USE(?Kopet),FONT(,,,FONT:bold)
                           BUTTON('Iz&vçlçties'),AT(258,262),USE(?Select),FONT(,9,COLOR:Navy,FONT:bold),KEY(EnterKey)
                           BUTTON('&Ievadît'),AT(323,262,45,14),USE(?Insert:2)
                           BUTTON('&Mainît'),AT(371,262,45,14),USE(?Change),DEFAULT
                           BUTTON('&Dzçst'),AT(421,262,45,14),USE(?Delete:2)
                           BUTTON('&Beigt'),AT(468,262,45,14),USE(?Close)
                         END
                       END
                     END
SAV_POSITION    STRING(260)
PVN             BYTE
PVNJ            BYTE
PVNSCREEN WINDOW('PVN % maiòa'),AT(,,163,100),GRAY
       STRING(@N6B),AT(66,7),USE(JB#)
       STRING('Mainît PVN %  no'),AT(30,26),USE(?String2)
       ENTRY(@N2),AT(92,25,16,12),USE(PVN)
       STRING('uz'),AT(114,26),USE(?String3)
       ENTRY(@N2),AT(128,25,16,12),USE(PVNJ)
       BUTTON('Pârrçíinât proporciju'),AT(23,42,97,14),USE(?Button:PR)
       IMAGE('CHECK3.ICO'),AT(122,40,17,18),USE(?Image:PR)
       STRING('Pârrçíinât proporciju nozîmç aizvietot'),AT(11,59),USE(?String4),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       STRING('svaru,piemçram,121 ar 122, 21 ar 22 utt.'),AT(11,68),USE(?String4:1),FONT(,,COLOR:Green,,CHARSET:BALTIC)
       BUTTON('&OK'),AT(73,80,35,14),USE(?Ok:P),DEFAULT
       BUTTON('&Atlikt'),AT(112,80,36,14),USE(?Cancel:P)
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
     ?Change {PROP:DEFAULT}=''
     ?Select{PROP:DEFAULT}='1'
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
      IF TEK_INI
         CLEAR(TEK:RECORD)
         TEK:INI=TEK_INI
         SET(TEK:NR_KEY,TEK:NR_KEY)
         NEXT(TEK_K)
         BRW1::LocateMode = LocateOnedit
         DO BRW1::LocateRecord
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         DO RefreshWindow
         ?Browse:1{PROPLIST:HEADER,1}='Teksts' !Lai piespiestu pârlasît ekrânu
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
    CASE ACCEPTED()
    OF ?5Speciâlâsfunkcijas1MainîtPVN
      DO SyncWindow
      PVN=21
      PVNJ=22
      PR=1
      OPEN(PVNSCREEN)
      JB#=0
      SAV_POSITION=POSITION(TEK_K)
      DISPLAY
      ACCEPT
         case field()
         OF ?BUTTON:PR
            case event()
            of event:accepted
               IF PR
                  PR = 0
                  HIDE(?IMAGE:PR)
               ELSE
                  PR = 1
                  UNHIDE(?IMAGE:PR)
               .
               DISPLAY
            .
         OF ?OK:P
            case event()
            of event:accepted
!Elya 20/06/2012
!               IF PR AND ~((PVN=18 AND PVNJ=21) OR (PVN=5 AND PVNJ=10) OR (PVN=21 AND PVNJ=22) OR (PVN=10 AND PVNJ=12))
!                  PR=FALSE
!               .
               CLEAR(TEK:RECORD)
               SET(TEK:NR_KEY)
               LOOP
                  NEXT(TEK_K)
                  IF ERROR() THEN BREAK.
                  IF TEK:PVN_1=PVN OR TEK:PVN_2=PVN OR TEK:PVN_3=PVN OR TEK:PVN_4=PVN OR TEK:PVN_5=PVN OR TEK:PVN_6=PVN
                     JB#+=1
                     DISPLAY(?JB#)
                     IF TEK:PVN_1=PVN
                        TEK:PVN_1=PVNJ
                        IF PR
                           IF TEK:K_1=100+PVN THEN TEK:K_1=100+PVNJ.
                           IF TEK:K_1=PVN THEN TEK:K_1=PVNJ.
!                           IF TEK:K_1=121 THEN TEK:K_1=122.
!                           IF TEK:K_1=118 THEN TEK:K_1=121.
!                           IF TEK:K_1=21 THEN TEK:K_1=22.
!                           IF TEK:K_1=18 THEN TEK:K_1=21.
!                           IF TEK:K_1=110 THEN TEK:K_1=112.
!                           IF TEK:K_1=105 THEN TEK:K_1=110.
!                           IF TEK:K_1=10 THEN TEK:K_1=12.
!                           IF TEK:K_1=5 THEN TEK:K_1=10.
                        .
                     .
                     IF TEK:PVN_2=PVN 
                        TEK:PVN_2=PVNJ
                        IF PR
                           IF TEK:K_2=100+PVN THEN TEK:K_2=100+PVNJ.
                           IF TEK:K_2=PVN THEN TEK:K_2=PVNJ.
!                           IF TEK:K_2=121 THEN TEK:K_2=122.
!                           IF TEK:K_2=118 THEN TEK:K_2=121.
!                           IF TEK:K_2=21 THEN TEK:K_2=22.
!                           IF TEK:K_2=18 THEN TEK:K_2=21.
!                           IF TEK:K_2=110 THEN TEK:K_2=112.
!                           IF TEK:K_2=105 THEN TEK:K_2=110.
!                           IF TEK:K_2=10 THEN TEK:K_2=12.
!                           IF TEK:K_2=5 THEN TEK:K_2=10.
                        .
                     .
                     IF TEK:PVN_3=PVN
                        TEK:PVN_3=PVNJ
                        IF PR
                           IF TEK:K_3=100+PVN THEN TEK:K_3=100+PVNJ.
                           IF TEK:K_3=PVN THEN TEK:K_3=PVNJ.
!                           IF TEK:K_3=121 THEN TEK:K_3=122.
!                           IF TEK:K_3=118 THEN TEK:K_3=121.
!                           IF TEK:K_3=21 THEN TEK:K_3=22.
!                           IF TEK:K_3=18 THEN TEK:K_3=21.
!                           IF TEK:K_3=110 THEN TEK:K_3=112.
!                           IF TEK:K_3=105 THEN TEK:K_3=110.
!                           IF TEK:K_3=10 THEN TEK:K_3=12.
!                           IF TEK:K_3=5 THEN TEK:K_3=10.
                        .
                     .
                     IF TEK:PVN_4=PVN
                        TEK:PVN_4=PVNJ
                        IF PR
                           IF TEK:K_4=100+PVN THEN TEK:K_4=100+PVNJ.
                           IF TEK:K_4=PVN THEN TEK:K_4=PVNJ.
!                           IF TEK:K_4=121 THEN TEK:K_4=122.
!                           IF TEK:K_4=118 THEN TEK:K_4=121.
!                           IF TEK:K_4=21 THEN TEK:K_4=22.
!                           IF TEK:K_4=18 THEN TEK:K_4=21.
!                           IF TEK:K_4=110 THEN TEK:K_4=112.
!                           IF TEK:K_4=105 THEN TEK:K_4=110.
!                           IF TEK:K_4=10 THEN TEK:K_4=12.
!                           IF TEK:K_4=5 THEN TEK:K_4=10.
                        .
                     .
                     IF TEK:PVN_5=PVN
                        TEK:PVN_5=PVNJ
                        IF PR
                           IF TEK:K_5=100+PVN THEN TEK:K_5=100+PVNJ.
                           IF TEK:K_5=PVN THEN TEK:K_5=PVNJ.
!                           IF TEK:K_5=121 THEN TEK:K_5=122.
!                           IF TEK:K_5=118 THEN TEK:K_5=121.
!                           IF TEK:K_5=21 THEN TEK:K_5=22.
!                           IF TEK:K_5=18 THEN TEK:K_5=21.
!                           IF TEK:K_5=110 THEN TEK:K_5=112.
!                           IF TEK:K_5=105 THEN TEK:K_5=110.
!                           IF TEK:K_5=10 THEN TEK:K_5=12.
!                           IF TEK:K_5=5 THEN TEK:K_5=10.
                        .
                     .
                     IF TEK:PVN_6=PVN
                        TEK:PVN_6=PVNJ
                        IF PR
                           IF TEK:K_6=100+PVN THEN TEK:K_6=100+PVNJ.
                           IF TEK:K_6=PVN THEN TEK:K_6=PVNJ.
!                           IF TEK:K_6=121 THEN TEK:K_6=122.
!                           IF TEK:K_6=118 THEN TEK:K_6=121.
!                           IF TEK:K_6=21 THEN TEK:K_6=22.
!                           IF TEK:K_6=18 THEN TEK:K_6=21.
!                           IF TEK:K_6=110 THEN TEK:K_6=112.
!                           IF TEK:K_6=105 THEN TEK:K_6=110.
!                           IF TEK:K_6=10 THEN TEK:K_6=12.
!                           IF TEK:K_6=5 THEN TEK:K_6=10.
                        .
                     .
                     IF RIUPDATE:TEK_K()
                        KLUDA(24,'TEK_K')
                     .
                  .
               .
               BREAK
            .
         OF ?CANCEL:P
            case event()
            of event:accepted
               BREAK
            .
         .
      .
      RESET(TEK_K,SAV_POSITION)
      NEXT(TEK_K)
      close(PVNSCREEN)
      IF JB#
         BRW1::LocateMode = LocateOnEdit
         DO BRW1::LocateRecord
         DO BRW1::RefreshPage
         DO BRW1::InitializeBrowse
         DO BRW1::PostNewSelection
         SELECT(?Browse:1)
         LocalRequest = OriginalRequest
         LocalResponse = RequestCancelled
         DO RefreshWindow
      .
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
    OF ?TEK:INI
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?TEK:INI)
        IF TEK:INI
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = TEK:INI
          BRW1::Sort1:LocatorLength = LEN(CLIP(TEK:INI))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Kopet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        copyrequest=1
        DO BRW1::ButtonInsert
      END
    OF ?Select
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        IF TEK:PAR_NR THEN PAR_NR=TEK:PAR_NR.
        
      END
    OF ?Insert:2
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
    OF ?Delete:2
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
  IF TEK_K::Used = 0
    CheckOpen(TEK_K,1)
  END
  TEK_K::Used += 1
  BIND(TEK:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowseTEK_K','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select{Prop:Hide} = True
    DISABLE(?Select)
  ELSE
  END
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
    TEK_K::Used -= 1
    IF TEK_K::Used = 0 THEN CLOSE(TEK_K).
  END
  IF WindowOpened
    INISaveWindow('BrowseTEK_K','winlats.INI')
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
    TEK:INI = BRW1::Sort1:LocatorValue
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
      TEK:INI = BRW1::Sort1:LocatorValue
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
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'TEK_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = TEK:INI
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'TEK_K')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = TEK:INI
    SetupStringStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue,SIZE(BRW1::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  TEK:TEKSTS = BRW1::TEK:TEKSTS
  TEK:TIPS = BRW1::TEK:TIPS
  TEK:ref_obj = BRW1::TEK:ref_obj
  TEK:ATT_DOK = BRW1::TEK:ATT_DOK
  TEK:PAR_NOS = BRW1::TEK:PAR_NOS
  TEK:AVA_NOS = BRW1::TEK:AVA_NOS
  TEK:PVN_1 = BRW1::TEK:PVN_1
  TEK:D_K1 = BRW1::TEK:D_K1
  TEK:BKK_1 = BRW1::TEK:BKK_1
  TEK:D_K2 = BRW1::TEK:D_K2
  TEK:BKK_2 = BRW1::TEK:BKK_2
  TEK:D_K3 = BRW1::TEK:D_K3
  TEK:BKK_3 = BRW1::TEK:BKK_3
  TEK:D_K4 = BRW1::TEK:D_K4
  TEK:BKK_4 = BRW1::TEK:BKK_4
  TEK:D_K5 = BRW1::TEK:D_K5
  TEK:BKK_5 = BRW1::TEK:BKK_5
  TEK:D_K6 = BRW1::TEK:D_K6
  TEK:BKK_6 = BRW1::TEK:BKK_6
  TEK:INI = BRW1::TEK:INI
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
  BRW1::TEK:TEKSTS = TEK:TEKSTS
  BRW1::TEK:TIPS = TEK:TIPS
  BRW1::TEK:ref_obj = TEK:ref_obj
  BRW1::TEK:ATT_DOK = TEK:ATT_DOK
  BRW1::TEK:PAR_NOS = TEK:PAR_NOS
  BRW1::TEK:AVA_NOS = TEK:AVA_NOS
  BRW1::TEK:PVN_1 = TEK:PVN_1
  BRW1::TEK:D_K1 = TEK:D_K1
  BRW1::TEK:BKK_1 = TEK:BKK_1
  BRW1::TEK:D_K2 = TEK:D_K2
  BRW1::TEK:BKK_2 = TEK:BKK_2
  BRW1::TEK:D_K3 = TEK:D_K3
  BRW1::TEK:BKK_3 = TEK:BKK_3
  BRW1::TEK:D_K4 = TEK:D_K4
  BRW1::TEK:BKK_4 = TEK:BKK_4
  BRW1::TEK:D_K5 = TEK:D_K5
  BRW1::TEK:BKK_5 = TEK:BKK_5
  BRW1::TEK:D_K6 = TEK:D_K6
  BRW1::TEK:BKK_6 = TEK:BKK_6
  BRW1::TEK:INI = TEK:INI
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
      POST(Event:Accepted,?Insert:2)
      POST(Event:Accepted,?Change)
      POST(Event:Accepted,?Delete:2)
      POST(Event:Accepted,?Select)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(TEK:INI)
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
      TEK:INI = BRW1::Sort1:LocatorValue
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
        POST(Event:Accepted,?Select)
        EXIT
      END
      POST(Event:Accepted,?Change)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            TEK:INI = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          TEK:INI = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          TEK:INI = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:2)
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
      TEK:INI = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'TEK_K')
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
      BRW1::HighlightedPosition = POSITION(TEK:NR_KEY)
      RESET(TEK:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(TEK:NR_KEY,TEK:NR_KEY)
    END
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
    OF 1; ?TEK:INI{Prop:Disable} = 0
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
    ?Change{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(TEK:Record)
    CASE BRW1::SortOrder
    OF 1; ?TEK:INI{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change{Prop:Disable} = 1
    ?Delete:2{Prop:Disable} = 1
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
    SET(TEK:NR_KEY)
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
  BrowseButtons.InsertButton=?Insert:2
  BrowseButtons.ChangeButton=?Change
  BrowseButtons.DeleteButton=?Delete:2
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
  GET(TEK_K,0)
  CLEAR(TEK:Record,0)
  LocalRequest = InsertRecord
  if copyrequest=1
     DO SYNCWINDOW
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
!| (UpdateTEK_K) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[6])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateTEK_K
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
        GET(TEK_K,0)
        CLEAR(TEK:Record,0)
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
  CopyRequest=0

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


PerformShortcut      PROCEDURE                    ! Declare Procedure
I_D_K                STRING(1)
SAV_PAR_NR    ULONG
GGK_SUMMAV    DECIMAL(12,2)
SVARS         SREAL
TEKSTS1       LIKE(TEKSTS)
DK_KKKS       STRING(12)
DK_KKK        STRING(3),DIM(4),OVER(DK_KKKS)

A_NODALA      LIKE(A:NODALA)
A_OBJ_NR      LIKE(A:OBJ_NR)

B_TABLE  QUEUE,PRE(B)
KEY        STRING(8)
NODALA     LIKE(GGK:NODALA)
OBJ_NR     LIKE(GGK:OBJ_NR)
PROPORCIJA LIKE(GGK:SUMMAV)
         .
B_SUMMAV       LIKE(GGK:SUMMAV)
SAV_GGK_RECORD LIKE(GGK:RECORD)

  CODE                                            ! Begin processed code
!***************** BÛS VIÒU VAI MÛSU APMAKSA *****************
   CHECKOPEN(GLOBAL,1)
   IF GG:PAR_NR=0
      KLUDA(87,'Partneris sastâdâmajâ dokumentâ')
      DO PROCEDURERETURN
   .

   IF D_K='D'          !D_K NÂK NO IZSAUKUMA POGAS
      I_D_K='K'
   ELSE
      I_D_K='D'
   .
   PAR_NR=GG:PAR_NR
   ReferFixGG          !REFERENCES UZ PREÈU(PAKALPOJUMU) DOKUMENTIEM
   IF GLOBALRESPONSE=REQUESTCOMPLETED
      IF KKK[1:3]='231'
         TEKSTS='Saòemts pçc Rçí.Nr'
      ELSIF KKK[1:3]='531'
         TEKSTS='Apmaksa Rçí.Nr'
      ELSE
         STOP(KKK)
      .
!      TEKSTS1=TEKSTS
      SUMMA=0
      RAKSTI#=0
      LOOP I#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,I#)
         IF A:SUMMAV_T
            SUMMA+=A:SUMMAV_T
            VAL_NOS=A:VAL_T
!            RAKSTI#+=1
            TEKSTS =CLIP(TEKSTS)&' '&A:REFERENCE
!            TEKSTS1=CLIP(TEKSTS1)&' '&A:REFERENCE !Mçs maksâjam
         .
      .
      IF SUMMA
         IF KKK[1:3]='531' !MÇS MAKSÂJAM
            TEKSTS=CLIP(TEKSTS)&' '&GETPAR_K(GG:PAR_NR,2,23) !LÎGUMA/KLIENTA Nr (PAR:LIGUMS1vPAR:LIGUMS2,JA PAR:LT=1v2)
         .
!         IF RAKSTI# > 5  !CITÂDI NELIEN IEKÐÂ
!            TEKSTS=TEKSTS1
!         .
         FORMAT_TEKSTS(45,'WINDOW',0,'',)
         gg:saturs =F_TEKSTS[1]
         gg:saturs2=F_TEKSTS[2]
         gg:saturs3=F_TEKSTS[3]
         GG:ATT_DOK='3'
      ELSE
         KLUDA(0,'NULLES SUMMA ...')
         DO PROCEDURERETURN
      .
      CHECKOPEN(GGK,1)
      CLEAR(GGK:RECORD)
      CHECKOPEN(KON_K,1)
      IF ~val_nos THEN VAL_NOS='Ls'.
      GGK:val=val_nos
      GG:val=val_nos
      GGK:U_NR=GG:U_NR
      ggk:rs=gg:rs
      GGK:DATUMS=GG:DATUMS
      GGK:REFERENCE=''
      GGK:PAR_NR=GG:PAR_NR
      GGK:SUMMAV= Summa  !PIEÐÍIRI VAJAG VÇLÂK

      ggk:D_K=D_K
      ggk:bkk=KKK
      GGK:SUMMAV=0 !MEKLÇSIM A-TABULÂ
      DO PERFORMADD

      IF CL_NR=1033   !ÍÎPSALA
         ggk:bkk='26220'
      ELSE
         ggk:bkk=GL:BKK[SYS:NOKL_B]
      .
      IF ~GGK:BKK THEN GGK:bkk='26200'.
      ggk:D_K=I_D_K
      IF BAND(REG_BASE_ACC,00000010b) ! Budþets
         DO PERFORMADDB
      ELSE
         DO PERFORMADD !FIX BANKA=26200
      .
   .
   DO PROCEDURERETURN


PERFORMADD   ROUTINE
   IF GGK:BKK[1:3]=KKK[1:3]  !JÂMEKLÇ SADALÎJUMS TABULÂ- D/K KONTS
      LOOP J#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,J#)
         IF A:SUMMAV_T                   !FIX SAM.TAGAD
            GGK:BKK=A:BKK
            GGK:SUMMAV=A:SUMMAV_T
            ggk:REFERENCE=A:REFERENCE
            GGK:NODALA=A:NODALA
            GGK:OBJ_NR=A:OBJ_NR
            GGK:PVN_PROC=A:PVN_PROC                           !15.12.2008
            IF ~GGK:PVN_PROC THEN GGK:PVN_PROC=SYS:NOKL_PVN.   !15.12.2008
            DO ADDGGK
         .
      .
   ELSE
      ggk:REFERENCE=''
      GGK:SUMMAV=SUMMA  !24.12.2008
      DO ADDGGK
   .

PERFORMADDB   ROUTINE                    !JÂMEKLÇ 6,7-TÂS GRUPAS KONTI, LAI DABÛTU STRUKTÛRVIENÎBAS UN KLAS.KODUS
      SAV_GGK_RECORD=GGK:RECORD
      LOOP J#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,J#)
         IF A:SUMMAV_T                   !FIX SAM.TAGAD
            A_NODALA=A:NODALA
            A_OBJ_NR=A:OBJ_NR
            CLEAR(GGK:RECORD)
            GGK:U_NR=A:U_NR
            SET(GGK:NR_KEY,GGK:NR_KEY)
            LOOP
               NEXT(GGK)
               IF ERROR() OR ~(GGK:U_NR=A:U_NR) THEN BREAK.
               IF INSTRING(GGK:BKK[1],'678')
                  B:KEY=GGK:NODALA&GGK:OBJ_NR
                  GET(B_TABLE,B:KEY)
                  IF ERROR()
                     B:NODALA=GGK:NODALA
                     B:OBJ_NR=GGK:OBJ_NR
                     B:PROPORCIJA=GGK:SUMMAV
                     ADD(B_TABLE)
                  ELSE
                     B:PROPORCIJA+=GGK:SUMMAV
                     PUT(B_TABLE)
                  .
                  B_SUMMAV+=GGK:SUMMAV
               .
            .
         .
      .
      IF RECORDS(B_TABLE)
         LOOP J#=1 TO RECORDS(B_TABLE)
            GET(B_TABLE,J#)
            GGK:RECORD=SAV_GGK_RECORD
            GGK:SUMMAV=ROUND(SUMMA/B_SUMMAV*B:PROPORCIJA,.01)
            GGK:NODALA=B:NODALA
            GGK:OBJ_NR=B:OBJ_NR
            DO ADDGGK
         .
      ELSE
         GGK:RECORD=SAV_GGK_RECORD
         GGK:NODALA=A_NODALA
         GGK:OBJ_NR=A_OBJ_NR
         DO ADDGGK
      .

ADDGGK    ROUTINE
        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
!        STOP(GGK:U_NR&' '&GGK:BKK&' '&GGK:SUMMA)
        ADD(GGK)
        IF ~ERROR()
           CASE GGK:D_K
           OF 'D'
              CONTROL$+=GGK:SUMMA
           OF 'K'
              CONTROL$-=GGK:SUMMA
           .
           ATLIKUMIB(GGK:D_K,GGK:BKK,GGK:SUMMA,GGK:D_K,GGK:BKK,0)
        ELSE
           STOP('Rakstot ggk:'&ERROR())
        .

PROCEDURERETURN    ROUTINE
       FREE(A_TABLE)
       FREE(B_TABLE)
       RETURN
