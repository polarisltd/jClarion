                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdateNOL_KOPS PROCEDURE


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
D_DAUDZUMS           DECIMAL(11,3),DIM(18)
D_DAUDZUMSK          DECIMAL(11,3)
D_SUMMA              DECIMAL(11,2),DIM(18)
D_SUMMAK             DECIMAL(11,2)
DI_DAUDZUMS          DECIMAL(11,3),DIM(18)
DI_DAUDZUMSK         DECIMAL(11,3)
K_DAUDZUMS           DECIMAL(11,3),DIM(18)
K_DAUDZUMSK          DECIMAL(11,3)
K_SUMMA              DECIMAL(11,2),DIM(18)
K_SUMMAK             DECIMAL(11,2)
KI_DAUDZUMS          DECIMAL(11,3),DIM(18)
KI_DAUDZUMSK         DECIMAL(11,3)
A_DAUDZUMS           DECIMAL(11,2),DIM(18)
A_DAUDZUMS0          DECIMAL(11,2)
A_SUMMA0             DECIMAL(11,3)
STATUSS              BYTE,DIM(12)
NOL_NR               BYTE
RecordFiltered       LONG
FING                 STRING(35)
M       STRING(15),DIM(12)
Update::Reloop  BYTE
Update::Error   BYTE
History::KOPS:Record LIKE(KOPS:Record),STATIC
SAV::KOPS:Record     LIKE(KOPS:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:KOPS:U_NR    LIKE(KOPS:U_NR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType

BRW5::View:Browse    VIEW(NOL_FIFO)
                       PROJECT(FIFO:U_NR)
                       PROJECT(FIFO:D_K)
                       PROJECT(FIFO:DATUMS)
                       PROJECT(FIFO:NOL_NR)
                       PROJECT(FIFO:DAUDZUMS)
                       PROJECT(FIFO:SUMMA)
                     END

Queue:Browse         QUEUE,PRE()                  ! Browsing Queue
BRW5::FIFO:U_NR        LIKE(FIFO:U_NR)            ! Queue Display field
BRW5::FIFO:D_K         LIKE(FIFO:D_K)             ! Queue Display field
BRW5::FIFO:DATUMS      LIKE(FIFO:DATUMS)          ! Queue Display field
BRW5::FIFO:NOL_NR      LIKE(FIFO:NOL_NR)          ! Queue Display field
BRW5::FIFO:DAUDZUMS    LIKE(FIFO:DAUDZUMS)        ! Queue Display field
BRW5::FIFO:SUMMA       LIKE(FIFO:SUMMA)           ! Queue Display field
BRW5::Mark             BYTE                       ! Queue POSITION information
BRW5::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW5::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW5::Sort1:Reset:KOPS:U_NR LIKE(KOPS:U_NR)
BRW5::CurrentEvent   LONG                         !
BRW5::CurrentChoice  LONG                         !
BRW5::RecordCount    LONG                         !
BRW5::SortOrder      BYTE                         !
BRW5::LocateMode     BYTE                         !
BRW5::RefreshMode    BYTE                         !
BRW5::LastSortOrder  BYTE                         !
BRW5::FillDirection  BYTE                         !
BRW5::AddQueue       BYTE                         !
BRW5::Changed        BYTE                         !
BRW5::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW5::ItemsToFill    LONG                         ! Controls records retrieved
BRW5::MaxItemsInList LONG                         ! Retrieved after window opened
BRW5::HighlightedPosition STRING(512)             ! POSITION of located record
BRW5::NewSelectPosted BYTE                        ! Queue position of located record
BRW5::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
QuickWindow          WINDOW('Update the NOL_KOPS File'),AT(,,460,300),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateNOL_KOPS'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(1,4,456,271),USE(?CurrentTab)
                         TAB('Apgrozîjums pa &mçneðiem'),USE(?Tab:1)
                           STRING(@n13),AT(399,4),USE(KOPS:U_NR)
                           PROMPT('&Nomenklatûra:'),AT(74,20),USE(?Prompt2),LEFT
                           STRING(@s21),AT(122,20,96,10),USE(KOPS:NOMENKLAT),LEFT
                           STRING(@s35),AT(227,20),USE(FING)
                           LINE,AT(442,71,0,199),USE(?Line23),COLOR(COLOR:Black)
                           BUTTON('1'),AT(23,34,29,14),USE(?Button1),HIDE
                           BUTTON('2'),AT(55,34,29,14),USE(?Button2),HIDE
                           BUTTON('3'),AT(87,34,29,14),USE(?Button3),HIDE
                           BUTTON('4'),AT(119,34,29,14),USE(?Button4),HIDE
                           BUTTON('5'),AT(151,34,29,14),USE(?Button5),HIDE
                           BUTTON('6'),AT(183,34,29,14),USE(?Button6),HIDE
                           BUTTON('7'),AT(215,34,29,14),USE(?Button7),HIDE
                           BUTTON('8'),AT(247,34,29,14),USE(?Button8),HIDE
                           BUTTON('9'),AT(279,34,29,14),USE(?Button9),HIDE
                           BUTTON('10'),AT(311,34,29,14),USE(?Button10),HIDE
                           BUTTON('11'),AT(343,34,29,14),USE(?Button11),HIDE
                           BUTTON('12'),AT(375,34,29,14),USE(?Button12),HIDE
                           BUTTON('13'),AT(407,34,29,14),USE(?Button13),HIDE
                           BUTTON('14'),AT(23,51,29,14),USE(?Button14),HIDE
                           BUTTON('15'),AT(55,51,29,14),USE(?Button15),HIDE
                           BUTTON('16'),AT(87,51,29,14),USE(?Button16),HIDE
                           BUTTON('17'),AT(119,51,29,14),USE(?Button17),HIDE
                           BUTTON('18'),AT(151,51,29,14),USE(?Button18),HIDE
                           BUTTON('19'),AT(183,51,29,14),USE(?Button19),HIDE
                           BUTTON('20'),AT(215,51,29,14),USE(?Button20),HIDE
                           BUTTON('21'),AT(247,51,29,14),USE(?Button21),HIDE
                           BUTTON('22'),AT(279,51,29,14),USE(?Button22),HIDE
                           BUTTON('23'),AT(311,51,29,14),USE(?Button23),HIDE
                           BUTTON('24'),AT(343,51,29,14),USE(?Button24),HIDE
                           BUTTON('25'),AT(375,51,29,14),USE(?Button25),HIDE
                           BUTTON('&KOPÂ'),AT(407,51,29,14),USE(?Button25:2)
                           REGION,AT(7,71,445,199),USE(?Region1),COLOR(COLOR:Black)
                           STRING('Debets'),AT(131,74,34,8),USE(?String4),CENTER,FONT(,9,,)
                           STRING('Kredîts'),AT(291,73,34,8),USE(?String4:2),CENTER,FONT(,9,,)
                           STRING('Atlikums'),AT(395,74,39,8),USE(?String4:3),CENTER,FONT(,9,,)
                           STRING('S'),AT(445,79),USE(?String136),CENTER
                           LINE,AT(67,83,320,0),USE(?Line6),COLOR(COLOR:Black)
                           STRING('daudz.(arî R)'),AT(74,84),USE(?String7),CENTER
                           STRING('summa (arî R)'),AT(179,84),USE(?String7:2),CENTER
                           STRING('iekð. pârv.'),AT(133,84),USE(?String7:3),CENTER
                           STRING('daudz. (arî R)'),AT(231,84),USE(?String7:6),CENTER
                           STRING('summa (arî R)'),AT(338,84),USE(?String7:5),CENTER
                           STRING('iekð. pârv.'),AT(289,84),USE(?String7:4),CENTER
                           STRING('daudzums'),AT(395,84,39,8),USE(?String7:7),CENTER
                           STRING('SALDO'),AT(12,96,34,9),USE(?String14),LEFT
                           LINE,AT(7,94,445,0),USE(?Line7),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,96,51,9),USE(A_DAUDZUMS0),RIGHT
                           STRING('---'),AT(141,96,19,9),USE(?String119:3),CENTER
                           STRING('---'),AT(246,96,19,9),USE(?String119:4),CENTER
                           STRING('---'),AT(352,96,19,9),USE(?String119:5),CENTER
                           LINE,AT(7,106,445,0),USE(?Line8),COLOR(COLOR:Black)
                           STRING('---'),AT(298,96,19,9),USE(?String119:6),CENTER
                           STRING(@n-_12.2B),AT(176,96,49,9),USE(A_SUMMA0),RIGHT
                           STRING('Janvâris'),AT(12,108,54,9),USE(?String1M),LEFT
                           STRING(@n-_12.3B),AT(68,108,51,9),USE(D_DAUDZUMS[1]),RIGHT
                           STRING(@n-_12.2B),AT(175,108,50,9),USE(D_SUMMA[1]),RIGHT
                           STRING(@n-_12.3B),AT(121,108,51,9),USE(DI_DAUDZUMS[1]),RIGHT
                           STRING(@n-_12.3B),AT(228,108,51,9),USE(K_DAUDZUMS[1]),RIGHT
                           STRING(@n-_12.2B),AT(335,108,50,9),USE(K_SUMMA[1]),RIGHT
                           STRING(@n-_12.3B),AT(282,108,51,9),USE(KI_DAUDZUMS[1]),RIGHT
                           STRING(@n-_12.2B),AT(389,108,50,9),USE(A_DAUDZUMS[1]),RIGHT
                           STRING(@n1),AT(443,108,8,9),USE(STATUSS[1]),CENTER
                           LINE,AT(7,118,445,0),USE(?Line9),COLOR(COLOR:Black)
                           STRING('Februâris'),AT(12,120,54,9),USE(?String2M),LEFT
                           STRING(@n-_12.3B),AT(68,120,51,9),USE(D_DAUDZUMS[2]),RIGHT
                           STRING(@n-_12.2B),AT(175,120,50,9),USE(D_SUMMA[2]),RIGHT
                           STRING(@n-_12.3B),AT(121,120,51,9),USE(DI_DAUDZUMS[2]),RIGHT
                           STRING(@n-_12.3B),AT(228,120,51,9),USE(K_DAUDZUMS[2]),RIGHT
                           STRING(@n-_12.2B),AT(335,120,50,9),USE(K_SUMMA[2]),RIGHT
                           STRING(@n-_12.3B),AT(282,120,51,9),USE(KI_DAUDZUMS[2]),RIGHT
                           STRING(@n-_12.2B),AT(389,120,50,9),USE(A_DAUDZUMS[2]),RIGHT
                           STRING(@n1),AT(443,120,8,9),USE(STATUSS[2]),CENTER
                           LINE,AT(7,130,445,0),USE(?Line10),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,132,51,9),USE(D_DAUDZUMS[3]),RIGHT
                           STRING(@n-_12.2B),AT(175,132,50,9),USE(D_SUMMA[3]),RIGHT
                           STRING(@n-_12.3B),AT(121,132,51,9),USE(DI_DAUDZUMS[3]),RIGHT
                           STRING(@n-_12.3B),AT(228,132,51,9),USE(K_DAUDZUMS[3]),RIGHT
                           STRING(@n-_12.2B),AT(335,132,50,9),USE(K_SUMMA[3]),RIGHT
                           STRING(@n-_12.3B),AT(282,132,51,9),USE(KI_DAUDZUMS[3]),RIGHT
                           STRING(@n-_12.2B),AT(389,132,50,9),USE(A_DAUDZUMS[3]),RIGHT
                           STRING('Marts'),AT(12,132,54,9),USE(?String3M),LEFT
                           STRING(@n1),AT(443,132,8,9),USE(STATUSS[3]),CENTER
                           LINE,AT(7,142,445,0),USE(?Line11),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,144,51,9),USE(D_DAUDZUMS[4]),RIGHT
                           STRING(@n-_12.2B),AT(175,144,50,9),USE(D_SUMMA[4]),RIGHT
                           STRING(@n-_12.3B),AT(121,144,51,9),USE(DI_DAUDZUMS[4]),RIGHT
                           STRING(@n-_12.3B),AT(228,144,51,9),USE(K_DAUDZUMS[4]),RIGHT
                           STRING(@n-_12.2B),AT(335,144,50,9),USE(K_SUMMA[4]),RIGHT
                           STRING(@n-_12.3B),AT(282,144,51,9),USE(KI_DAUDZUMS[4]),RIGHT
                           STRING(@n-_12.2B),AT(389,144,50,9),USE(A_DAUDZUMS[4]),RIGHT
                           STRING('Aprîlis'),AT(12,144,54,9),USE(?String4M),LEFT
                           STRING(@n1),AT(443,144,8,9),USE(STATUSS[4]),CENTER
                           LINE,AT(7,154,445,0),USE(?Line12),COLOR(COLOR:Black)
                           STRING('Maijs'),AT(12,156,54,9),USE(?String5M),LEFT
                           STRING(@n-_12.3B),AT(68,156,51,9),USE(D_DAUDZUMS[5]),RIGHT
                           STRING(@n-_12.2B),AT(175,156,50,9),USE(D_SUMMA[5]),RIGHT
                           STRING(@n-_12.3B),AT(121,156,51,9),USE(DI_DAUDZUMS[5]),RIGHT
                           STRING(@n-_12.3B),AT(228,156,51,9),USE(K_DAUDZUMS[5]),RIGHT
                           STRING(@n-_12.2B),AT(335,156,50,9),USE(K_SUMMA[5]),RIGHT
                           STRING(@n-_12.3B),AT(282,156,51,9),USE(KI_DAUDZUMS[5]),RIGHT
                           STRING(@n-_12.2B),AT(389,156,50,9),USE(A_DAUDZUMS[5]),RIGHT
                           STRING(@n1),AT(443,156,8,9),USE(STATUSS[5]),CENTER
                           LINE,AT(7,166,445,0),USE(?Line13),COLOR(COLOR:Black)
                           LINE,AT(66,71,0,199),USE(?Line1),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(228,168,51,9),USE(K_DAUDZUMS[6]),RIGHT
                           STRING(@n-_12.2B),AT(335,168,50,9),USE(K_SUMMA[6]),RIGHT
                           STRING(@n-_12.3B),AT(282,168,51,9),USE(KI_DAUDZUMS[6]),RIGHT
                           STRING(@n-_12.2B),AT(389,168,50,9),USE(A_DAUDZUMS[6]),RIGHT
                           STRING(@n-_12.2B),AT(175,168,50,9),USE(D_SUMMA[6]),RIGHT
                           STRING(@n-_12.3B),AT(121,168,51,9),USE(DI_DAUDZUMS[6]),RIGHT
                           STRING(@n-_12.3B),AT(68,168,51,9),USE(D_DAUDZUMS[6]),RIGHT
                           STRING('Jûnijs'),AT(12,168,54,9),USE(?String6M),LEFT
                           STRING(@n1),AT(443,168,8,9),USE(STATUSS[6]),CENTER
                           LINE,AT(7,178,445,0),USE(?Line14),COLOR(COLOR:Black)
                           STRING(@n-_12.2B),AT(175,180,50,9),USE(D_SUMMA[7]),RIGHT
                           STRING(@n-_12.3B),AT(121,180,51,9),USE(DI_DAUDZUMS[7]),RIGHT
                           STRING(@n-_12.3B),AT(228,180,51,9),USE(K_DAUDZUMS[7]),RIGHT
                           STRING(@n-_12.2B),AT(335,180,50,9),USE(K_SUMMA[7]),RIGHT
                           STRING(@n-_12.3B),AT(282,180,51,9),USE(KI_DAUDZUMS[7]),RIGHT
                           STRING(@n-_12.2B),AT(389,180,50,9),USE(A_DAUDZUMS[7]),RIGHT
                           STRING(@n-_12.3B),AT(68,180,51,9),USE(D_DAUDZUMS[7]),RIGHT
                           STRING('Jûlijs'),AT(12,180,54,9),USE(?String7M),LEFT
                           STRING(@n1),AT(443,180,8,9),USE(STATUSS[7]),CENTER
                           LINE,AT(7,190,445,0),USE(?Line15),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(228,192,51,9),USE(K_DAUDZUMS[8]),RIGHT
                           STRING(@n-_12.2B),AT(335,192,50,9),USE(K_SUMMA[8]),RIGHT
                           STRING(@n-_12.3B),AT(282,192,51,9),USE(KI_DAUDZUMS[8]),RIGHT
                           STRING(@n-_12.2B),AT(389,192,50,9),USE(A_DAUDZUMS[8]),RIGHT
                           STRING(@n-_12.2B),AT(175,192,50,9),USE(D_SUMMA[8]),RIGHT
                           STRING(@n-_12.3B),AT(121,192,51,9),USE(DI_DAUDZUMS[8]),RIGHT
                           STRING(@n-_12.3B),AT(68,192,51,9),USE(D_DAUDZUMS[8]),RIGHT
                           STRING('Augusts'),AT(12,192,54,9),USE(?String8M),LEFT
                           STRING(@n1),AT(443,192,8,9),USE(STATUSS[8]),CENTER
                           LINE,AT(7,202,445,0),USE(?Line16),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,204,51,9),USE(D_DAUDZUMS[9]),RIGHT
                           STRING(@n-_12.2B),AT(175,204,50,9),USE(D_SUMMA[9]),RIGHT
                           STRING(@n-_12.3B),AT(121,204,51,9),USE(DI_DAUDZUMS[9]),RIGHT
                           STRING(@n-_12.3B),AT(228,204,51,9),USE(K_DAUDZUMS[9]),RIGHT
                           STRING(@n-_12.2B),AT(335,204,50,9),USE(K_SUMMA[9]),RIGHT
                           STRING(@n-_12.3B),AT(282,204,51,9),USE(KI_DAUDZUMS[9]),RIGHT
                           STRING(@n-_12.2B),AT(389,204,50,9),USE(A_DAUDZUMS[9]),RIGHT
                           STRING('Septembris'),AT(12,204,54,9),USE(?String9M),LEFT
                           STRING(@n1),AT(443,204,8,9),USE(STATUSS[9]),CENTER
                           LINE,AT(7,214,445,0),USE(?Line17),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,216,51,9),USE(D_DAUDZUMS[10]),RIGHT
                           STRING(@n-_12.2B),AT(175,216,50,9),USE(D_SUMMA[10]),RIGHT
                           STRING(@n-_12.3B),AT(121,216,51,9),USE(DI_DAUDZUMS[10]),RIGHT
                           STRING(@n-_12.3B),AT(228,216,51,9),USE(K_DAUDZUMS[10]),RIGHT
                           STRING(@n-_12.2B),AT(335,216,50,9),USE(K_SUMMA[10]),RIGHT
                           STRING(@n-_12.3B),AT(282,216,51,9),USE(KI_DAUDZUMS[10]),RIGHT
                           STRING(@n-_12.2B),AT(389,216,50,9),USE(A_DAUDZUMS[10]),RIGHT
                           STRING('Oktobris'),AT(12,216,54,9),USE(?String10M),LEFT
                           STRING(@n1),AT(443,216,8,9),USE(STATUSS[10]),CENTER
                           LINE,AT(7,226,445,0),USE(?Line18),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(68,228,51,9),USE(D_DAUDZUMS[11]),RIGHT
                           STRING(@n-_12.2B),AT(175,228,50,9),USE(D_SUMMA[11]),RIGHT
                           STRING(@n-_12.3B),AT(121,228,51,9),USE(DI_DAUDZUMS[11]),RIGHT
                           STRING(@n-_12.3B),AT(228,228,51,9),USE(K_DAUDZUMS[11]),RIGHT
                           STRING(@n-_12.2B),AT(335,228,50,9),USE(K_SUMMA[11]),RIGHT
                           STRING(@n-_12.3B),AT(282,228,51,9),USE(KI_DAUDZUMS[11]),RIGHT
                           STRING(@n-_12.2B),AT(389,228,50,9),USE(A_DAUDZUMS[11]),RIGHT
                           STRING('Novembris'),AT(12,228,54,9),USE(?String11M),LEFT
                           STRING(@n-_12.3B),AT(68,240,51,9),USE(D_DAUDZUMS[12]),RIGHT
                           STRING(@n-_12.2B),AT(175,240,50,9),USE(D_SUMMA[12]),RIGHT
                           STRING(@n1),AT(443,228,8,9),USE(STATUSS[11]),CENTER
                           LINE,AT(7,238,445,0),USE(?Line19),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(121,240,51,9),USE(DI_DAUDZUMS[12]),RIGHT
                           STRING(@n-_12.3B),AT(228,240,51,9),USE(K_DAUDZUMS[12]),RIGHT
                           STRING(@n-_12.2B),AT(335,240,50,9),USE(K_SUMMA[12]),RIGHT
                           STRING(@n-_12.3B),AT(282,240,51,9),USE(KI_DAUDZUMS[12]),RIGHT
                           STRING(@n-_12.2B),AT(389,240,50,9),USE(A_DAUDZUMS[12]),RIGHT
                           STRING('Decembris'),AT(12,240,54,9),USE(?String12M),LEFT
                           STRING(@n1),AT(443,240,8,9),USE(STATUSS[12]),CENTER
                           LINE,AT(7,250,445,0),USE(?Line20),COLOR(COLOR:Black)
                           STRING('KOPÂ'),AT(12,255,40,10),USE(?String14:13),LEFT
                           STRING(@n-_12.3B),AT(67,255),USE(D_DAUDZUMSK),RIGHT
                           STRING(@n-_12.2B),AT(175,255),USE(D_SUMMAK),RIGHT
                           STRING(@n-_12.3B),AT(121,255),USE(DI_DAUDZUMSK),RIGHT
                           STRING(@n-_12.3B),AT(229,255,49,10),USE(K_DAUDZUMSK),RIGHT
                           STRING(@n-_12.2B),AT(335,255),USE(K_SUMMAK),RIGHT
                           LINE,AT(334,83,0,186),USE(?Line22),COLOR(COLOR:Black)
                           LINE,AT(280,83,0,186),USE(?Line21),COLOR(COLOR:Black)
                           LINE,AT(120,83,0,186),USE(?Line2),COLOR(COLOR:Black)
                           LINE,AT(173,83,0,186),USE(?Line3),COLOR(COLOR:Black)
                           LINE,AT(227,71,0,199),USE(?Line4),COLOR(COLOR:Black)
                           LINE,AT(387,71,0,199),USE(?Line5),COLOR(COLOR:Black)
                           STRING(@n-_12.3B),AT(281,255),USE(KI_DAUDZUMSK),RIGHT
                         END
                         TAB('&Tabulas'),USE(?Tab2)
                           LIST,AT(25,23,268,242),USE(?List),IMM,FONT(,,,FONT:bold),MSG('Browsing Records'),FORMAT('49L(1)|~U_Nr~@N_7@15L(1)|~D K~@s2@49L(1)|~Datums~C(0)@d06.@21R(1)|~N Nr~C(0)@n3@' &|
   '60R(1)|~Daudzums~C(0)@n-15.3@60R(1)~Summa~C(0)@n-15.2@'),FROM(Queue:Browse)
                         END
                       END
                       BUTTON('&OK'),AT(351,279,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(401,279,45,14),USE(?Cancel)
                       BUTTON('&Pârrçíinât'),AT(281,279,62,14),USE(?parrekinat)
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
  UNHIDE(?Button1,?Button1+NOL_SK-1)
  NOL_NR=1
  S_DAT=GETFING(5,DB_GADS)              !5:MAX -12 MÇN. PERIODA SÂKUMS
  B_DAT=DB_B_DAT
  CHECKKOPS('POZICIONÇTS',0,1) !AIZPILDA KOPS:: (NOMENKLAT,GADS,MEN_NR,REQ)
  DO FILLDATI !EKRÂNA MAINÎGIE
  FING=GETFING(1)
  M#=MONTH(DB_B_DAT)
  Y#=YEAR(DB_B_DAT)
  LOOP J# =12 TO 1 BY -1   !MAX DIM=12
     M[J#]=MENVAR(M#,1,1)&' '&Y#
     M#-=1
     IF M#<=0
        M#+=12
        Y#-=1
     .
     IF DATE(M#,1,Y#)<DB_S_DAT THEN BREAK.
  .
  IF DB_S_DAT<S_DAT  !S_DAT-PERIODA SÂKUMS DB_GADSâ, parasti 01.01.YYYY
     ?String1M{PROP:TEXT}=FORMAT(DB_S_DAT,@D14.)&'-'&FORMAT(S_DAT,@D14.)
  ELSE
     ?String1M{PROP:TEXT}=M[1]
  .
  ?String2M{PROP:TEXT}=M[2]
  ?String3M{PROP:TEXT}=M[3]
  ?String4M{PROP:TEXT}=M[4]
  ?String5M{PROP:TEXT}=M[5]
  ?String6M{PROP:TEXT}=M[6]
  ?String7M{PROP:TEXT}=M[7]
  ?String8M{PROP:TEXT}=M[8]
  ?String9M{PROP:TEXT}=M[9]
  ?String10M{PROP:TEXT}=M[10]
  ?String11M{PROP:TEXT}=M[11]
  ?String12M{PROP:TEXT}=M[12]
  
  
  
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
      DO BRW5::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?KOPS:U_NR)
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
        History::KOPS:Record = KOPS:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(NOL_KOPS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(KOPS:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'KOPS:NR_KEY')
                SELECT(?KOPS:U_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?KOPS:U_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::KOPS:Record <> KOPS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:NOL_KOPS(1)
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
              SELECT(?KOPS:U_NR)
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
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
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
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?Button1
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=1
        DO FILLDATI
        DISPLAY
      END
    OF ?Button2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=2
        DO FILLDATI
        DISPLAY
      END
    OF ?Button3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=3
        DO FILLDATI
        DISPLAY
      END
    OF ?Button4
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=4
        DO FILLDATI
        DISPLAY
      END
    OF ?Button5
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=5
        DO FILLDATI
        DISPLAY
      END
    OF ?Button6
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=6
        DO FILLDATI
        DISPLAY
      END
    OF ?Button7
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=7
        DO FILLDATI
        DISPLAY
      END
    OF ?Button8
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=8
        DO FILLDATI
        DISPLAY
      END
    OF ?Button9
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=9
        DO FILLDATI
        DISPLAY
      END
    OF ?Button10
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=10
        DO FILLDATI
        DISPLAY
      END
    OF ?Button11
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=11
        DO FILLDATI
        DISPLAY
      END
    OF ?Button12
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=12
        DO FILLDATI
        DISPLAY
      END
    OF ?Button13
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=13
        DO FILLDATI
        DISPLAY
      END
    OF ?Button14
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=14
        DO FILLDATI
        DISPLAY
      END
    OF ?Button15
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=15
        DO FILLDATI
        DISPLAY
      END
    OF ?Button16
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=16
        DO FILLDATI
        DISPLAY
      END
    OF ?Button17
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=17
        DO FILLDATI
        DISPLAY
      END
    OF ?Button18
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=18
        DO FILLDATI
        DISPLAY
      END
    OF ?Button19
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=19
        DO FILLDATI
        DISPLAY
      END
    OF ?Button20
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=20
        DO FILLDATI
        DISPLAY
      END
    OF ?Button21
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=21
        DO FILLDATI
        DISPLAY
      END
    OF ?Button22
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=22
        DO FILLDATI
        DISPLAY
      END
    OF ?Button23
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=23
        DO FILLDATI
        DISPLAY
      END
    OF ?Button24
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=24
        DO FILLDATI
        DISPLAY
      END
    OF ?Button25
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=25
        DO FILLDATI
        DISPLAY
      END
    OF ?Button25:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        NOL_NR=26
        DO FILLDATI
        DISPLAY
      END
    OF ?List
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW5::NewSelection
      OF EVENT:ScrollUp
        DO BRW5::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW5::ProcessScroll
      OF EVENT:PageUp
        DO BRW5::ProcessScroll
      OF EVENT:PageDown
        DO BRW5::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW5::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW5::ProcessScroll
      OF EVENT:AlertKey
        DO BRW5::AlertKey
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
    OF ?parrekinat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          CHECKKOPS('POZICIONÇTS',2,1)   !Piespiedu pârrçíins NO GADA SÂKUMA
          DO FILLDATI
          DO BRW5::InitializeBrowse
          DO BRW5::RefreshPage
          select(?ok)
          DISPLAY
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOL_FIFO::Used = 0
    CheckOpen(NOL_FIFO,1)
  END
  NOL_FIFO::Used += 1
  BIND(FIFO:RECORD)
  IF NOL_KOPS::Used = 0
    CheckOpen(NOL_KOPS,1)
  END
  NOL_KOPS::Used += 1
  BIND(KOPS:RECORD)
  FilesOpened = True
  RISnap:NOL_KOPS
  SAV::KOPS:Record = KOPS:Record
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
        IF RIDelete:NOL_KOPS()
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
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateNOL_KOPS','winlats.INI')
  WinResize.Resize
  BRW5::AddQueue = True
  BRW5::RecordCount = 0
  BIND('BRW5::Sort1:Reset:KOPS:U_NR',BRW5::Sort1:Reset:KOPS:U_NR)
  ?KOPS:U_NR{PROP:Alrt,255} = 734
  ?KOPS:NOMENKLAT{PROP:Alrt,255} = 734
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
    NOL_FIFO::Used -= 1
    IF NOL_FIFO::Used = 0 THEN CLOSE(NOL_FIFO).
    NOL_KOPS::Used -= 1
    IF NOL_KOPS::Used = 0 THEN CLOSE(NOL_KOPS).
  END
  IF WindowOpened
    INISaveWindow('UpdateNOL_KOPS','winlats.INI')
    CLOSE(QuickWindow)
  END
  CLOSE(BRW5::View:Browse)
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
  DO BRW5::SelectSort
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW5::GetRecord
!---------------------------------------------------------------------------
FILLDATI     ROUTINE
   A_DAUDZUMS0          = 0
   A_SUMMA0             = 0
   D_DAUDZUMSK          = 0
   D_SUMMAK             = 0
   DI_DAUDZUMSK         = 0
   K_DAUDZUMSK          = 0
   K_SUMMAK             = 0
   KI_DAUDZUMSK         = 0
   CLEAR(A_DAUDZUMS)
   CLEAR(D_DAUDZUMS)
   CLEAR(D_SUMMA)
   CLEAR(DI_DAUDZUMS)
   CLEAR(K_DAUDZUMS)
   CLEAR(K_SUMMA)
   CLEAR(KI_DAUDZUMS)
   IF INRANGE(NOL_NR,1,25)
      A_DAUDZUMS0          = KOPS::A_DAUDZUMS[NOL_NR]
      A_summa0             = KOPS::A_Summa[NOL_NR]
      LOOP I#=1 TO 12
         STATUSS[I#] = 9
         DO FILLVAR
         A_DAUDZUMS[I#] = A_DAUDZUMS0+D_DAUDZUMSK+DI_DAUDZUMSK-K_DAUDZUMSK-KI_DAUDZUMSK
      END
   ELSIF NOL_NR=26   !KOPÂ
      LOOP NOL_NR=1 TO NOL_SK
         A_DAUDZUMS0       += KOPS::A_DAUDZUMS[NOL_NR]
         A_summa0          += KOPS::A_Summa[NOL_NR]
      .
      LOOP I#=1 TO 12
         LOOP NOL_NR=1 TO NOL_SK
            STATUSS[I#] = 9 ! LAI KOPSAVILKUMOS PARÂDÎTU MAZÂKO STATUSU
            DO FILLVAR
         END
         A_DAUDZUMS[I#] = A_DAUDZUMS0+D_DAUDZUMSK+DI_DAUDZUMSK-K_DAUDZUMSK-KI_DAUDZUMSK
      END
   ELSE
      STOP('NOL_NR: '&NOL_NR)
   END

FILLVAR ROUTINE
         D_DAUDZUMS[I#] += KOPS::D_DAUDZUMS[I#,NOL_NR]
         D_SUMMA[I#]    += KOPS::D_SUMMA[I#,NOL_NR]
         DI_DAUDZUMS[I#]+= KOPS::DI_DAUDZUMS[I#,NOL_NR]
         K_DAUDZUMS[I#] += KOPS::K_DAUDZUMS[I#,NOL_NR]+KOPS::KR_DAUDZUMS[I#,NOL_NR]
         K_SUMMA[I#]    += KOPS::K_SUMMA[I#,NOL_NR]+KOPS::KR_SUMMA[I#,NOL_NR]
         KI_DAUDZUMS[I#]+= KOPS::KI_DAUDZUMS[I#,NOL_NR]
         IF STATUSS[I#] > KOPS:STATUSS[I#,NOL_NR]
            STATUSS[I#]  = KOPS:STATUSS[I#,NOL_NR]
         .
         D_DAUDZUMSK    += KOPS::D_DAUDZUMS[I#,NOL_NR]
         D_SUMMAK       += KOPS::D_SUMMA[I#,NOL_NR]
         DI_DAUDZUMSK   += KOPS::DI_DAUDZUMS[I#,NOL_NR]
         K_DAUDZUMSK    += KOPS::K_DAUDZUMS[I#,NOL_NR]+KOPS::KR_DAUDZUMS[I#,NOL_NR]
         K_SUMMAK       += KOPS::K_SUMMA[I#,NOL_NR]+KOPS::KR_SUMMA[I#,NOL_NR]
         KI_DAUDZUMSK   += KOPS::KI_DAUDZUMS[I#,NOL_NR]
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?KOPS:U_NR
      KOPS:U_NR = History::KOPS:Record.U_NR
    OF ?KOPS:NOMENKLAT
      KOPS:NOMENKLAT = History::KOPS:Record.NOMENKLAT
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
  KOPS:Record = SAV::KOPS:Record
  SAV::KOPS:Record = KOPS:Record
  Auto::Attempts = 0
  LOOP
    SET(KOPS:NR_KEY)
    PREVIOUS(NOL_KOPS)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:KOPS:U_NR = 1
    ELSE
      Auto::Save:KOPS:U_NR = KOPS:U_NR + 1
    END
    KOPS:Record = SAV::KOPS:Record
    KOPS:U_NR = Auto::Save:KOPS:U_NR
    SAV::KOPS:Record = KOPS:Record
    ADD(NOL_KOPS)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
    IF OriginalRequest = InsertRecord
      IF LocalResponse = RequestCancelled
        DELETE(NOL_KOPS)
      END
    END
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

!----------------------------------------------------------------------
BRW5::SelectSort ROUTINE
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
!|    f. The BrowseBox is reinitialized (BRW5::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW5::LastSortOrder = BRW5::SortOrder
  BRW5::Changed = False
  IF BRW5::SortOrder = 0
    BRW5::SortOrder = 1
  END
  IF BRW5::SortOrder = BRW5::LastSortOrder
    CASE BRW5::SortOrder
    OF 1
      IF BRW5::Sort1:Reset:KOPS:U_NR <> KOPS:U_NR
        BRW5::Changed = True
      END
    END
  ELSE
  END
  IF BRW5::SortOrder <> BRW5::LastSortOrder OR BRW5::Changed OR ForceRefresh
    CASE BRW5::SortOrder
    OF 1
      BRW5::Sort1:Reset:KOPS:U_NR = KOPS:U_NR
    END
    DO BRW5::GetRecord
    DO BRW5::Reset
    IF BRW5::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW5::LocateMode = LocateOnValue
        DO BRW5::LocateRecord
      ELSE
        FREE(Queue:Browse)
        BRW5::RefreshMode = RefreshOnTop
        DO BRW5::RefreshPage
        DO BRW5::PostNewSelection
      END
    ELSE
      IF BRW5::Changed
        FREE(Queue:Browse)
        BRW5::RefreshMode = RefreshOnTop
        DO BRW5::RefreshPage
        DO BRW5::PostNewSelection
      ELSE
        BRW5::LocateMode = LocateOnValue
        DO BRW5::LocateRecord
      END
    END
    IF BRW5::RecordCount
      GET(Queue:Browse,BRW5::CurrentChoice)
      DO BRW5::FillBuffer
    END
    DO BRW5::InitializeBrowse
  ELSE
    IF BRW5::RecordCount
      GET(Queue:Browse,BRW5::CurrentChoice)
      DO BRW5::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW5::InitializeBrowse ROUTINE
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
BRW5::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  FIFO:U_NR = BRW5::FIFO:U_NR
  FIFO:D_K = BRW5::FIFO:D_K
  FIFO:DATUMS = BRW5::FIFO:DATUMS
  FIFO:NOL_NR = BRW5::FIFO:NOL_NR
  FIFO:DAUDZUMS = BRW5::FIFO:DAUDZUMS
  FIFO:SUMMA = BRW5::FIFO:SUMMA
!----------------------------------------------------------------------
BRW5::FillQueue ROUTINE
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
  BRW5::FIFO:U_NR = FIFO:U_NR
  BRW5::FIFO:D_K = FIFO:D_K
  BRW5::FIFO:DATUMS = FIFO:DATUMS
  BRW5::FIFO:NOL_NR = FIFO:NOL_NR
  BRW5::FIFO:DAUDZUMS = FIFO:DAUDZUMS
  BRW5::FIFO:SUMMA = FIFO:SUMMA
  BRW5::Position = POSITION(BRW5::View:Browse)
!----------------------------------------------------------------------
BRW5::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW5::NewSelectPosted
    BRW5::NewSelectPosted = True
    POST(Event:NewSelection,?List)
  END
!----------------------------------------------------------------------
BRW5::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW5::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW5::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW5::PopupText = ''
    IF BRW5::RecordCount
    ELSE
    END
    EXECUTE(POPUP(BRW5::PopupText))
    END
  ELSIF BRW5::RecordCount
    BRW5::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW5::CurrentChoice)
    DO BRW5::FillBuffer
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW5::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW5::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW5::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW5::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW5::RecordCount
    BRW5::CurrentEvent = EVENT()
    CASE BRW5::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW5::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW5::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW5::ScrollEnd
    END
    ?List{Prop:SelStart} = BRW5::CurrentChoice
    DO BRW5::PostNewSelection
  END
!----------------------------------------------------------------------
BRW5::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW5::FillRecord to retrieve one record in the direction required.
!|
  IF BRW5::CurrentEvent = Event:ScrollUp AND BRW5::CurrentChoice > 1
    BRW5::CurrentChoice -= 1
    EXIT
  ELSIF BRW5::CurrentEvent = Event:ScrollDown AND BRW5::CurrentChoice < BRW5::RecordCount
    BRW5::CurrentChoice += 1
    EXIT
  END
  BRW5::ItemsToFill = 1
  BRW5::FillDirection = BRW5::CurrentEvent - 2
  DO BRW5::FillRecord
!----------------------------------------------------------------------
BRW5::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW5::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW5::FillRecord doesn't fill a page (BRW5::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW5::ItemsToFill = ?List{Prop:Items}
  BRW5::FillDirection = BRW5::CurrentEvent - 4
  DO BRW5::FillRecord                           ! Fill with next read(s)
  IF BRW5::ItemsToFill
    IF BRW5::CurrentEvent = Event:PageUp
      BRW5::CurrentChoice -= BRW5::ItemsToFill
      IF BRW5::CurrentChoice < 1
        BRW5::CurrentChoice = 1
      END
    ELSE
      BRW5::CurrentChoice += BRW5::ItemsToFill
      IF BRW5::CurrentChoice > BRW5::RecordCount
        BRW5::CurrentChoice = BRW5::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW5::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW5::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse)
  BRW5::RecordCount = 0
  DO BRW5::Reset
  BRW5::ItemsToFill = ?List{Prop:Items}
  IF BRW5::CurrentEvent = Event:ScrollTop
    BRW5::FillDirection = FillForward
  ELSE
    BRW5::FillDirection = FillBackward
  END
  DO BRW5::FillRecord                           ! Fill with next read(s)
  IF BRW5::CurrentEvent = Event:ScrollTop
    BRW5::CurrentChoice = 1
  ELSE
    BRW5::CurrentChoice = BRW5::RecordCount
  END
!----------------------------------------------------------------------
BRW5::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW5::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW5::LocateRecord.
!|
  IF BRW5::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    END
  END
  DO BRW5::PostNewSelection
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW5::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW5::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW5::ItemsToFill records. Normally, this will
!| result in BRW5::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW5::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW5::AddQueue is true, the queue is filled using the BRW5::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW5::AddQueue is false is when the BRW5::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW5::RecordCount
    IF BRW5::FillDirection = FillForward
      GET(Queue:Browse,BRW5::RecordCount)         ! Get the first queue item
    ELSE
      GET(Queue:Browse,1)                         ! Get the first queue item
    END
    RESET(BRW5::View:Browse,BRW5::Position)       ! Reset for sequential processing
    BRW5::SkipFirst = TRUE
  ELSE
    BRW5::SkipFirst = FALSE
  END
  LOOP WHILE BRW5::ItemsToFill
    IF BRW5::FillDirection = FillForward
      NEXT(BRW5::View:Browse)
    ELSE
      PREVIOUS(BRW5::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW5::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOL_FIFO')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW5::SkipFirst
       BRW5::SkipFirst = FALSE
       IF POSITION(BRW5::View:Browse)=BRW5::Position
          CYCLE
       END
    END
    IF BRW5::AddQueue
      IF BRW5::RecordCount = ?List{Prop:Items}
        IF BRW5::FillDirection = FillForward
          GET(Queue:Browse,1)                     ! Get the first queue item
        ELSE
          GET(Queue:Browse,BRW5::RecordCount)     ! Get the first queue item
        END
        DELETE(Queue:Browse)
        BRW5::RecordCount -= 1
      END
      DO BRW5::FillQueue
      IF BRW5::FillDirection = FillForward
        ADD(Queue:Browse)
      ELSE
        ADD(Queue:Browse,1)
      END
      BRW5::RecordCount += 1
    END
    BRW5::ItemsToFill -= 1
  END
  BRW5::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW5::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW5::LocateMode. These modes are...
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
!| If an appropriate record has been located, the BRW5::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW5::LocateMode = LocateOnPosition
    BRW5::LocateMode = LocateOnEdit
  END
  CLOSE(BRW5::View:Browse)
  CASE BRW5::SortOrder
  OF 1
    IF BRW5::LocateMode = LocateOnEdit
      BRW5::HighlightedPosition = POSITION(FIFO:NR_KEY)
      RESET(FIFO:NR_KEY,BRW5::HighlightedPosition)
    ELSE
      FIFO:U_NR = KOPS:U_NR
      SET(FIFO:NR_KEY,FIFO:NR_KEY)
    END
    BRW5::View:Browse{Prop:Filter} = |
    'FIFO:U_NR = BRW5::Sort1:Reset:KOPS:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW5::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse)
  BRW5::RecordCount = 0
  BRW5::ItemsToFill = 1
  BRW5::FillDirection = FillForward               ! Fill with next read(s)
  BRW5::AddQueue = False
  DO BRW5::FillRecord                             ! Fill with next read(s)
  BRW5::AddQueue = True
  IF BRW5::ItemsToFill
    BRW5::RefreshMode = RefreshOnBottom
    DO BRW5::RefreshPage
  ELSE
    BRW5::RefreshMode = RefreshOnPosition
    DO BRW5::RefreshPage
  END
  DO BRW5::PostNewSelection
  BRW5::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW5::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW5::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW5::RefreshMode = RefreshOnPosition
    BRW5::HighlightedPosition = POSITION(BRW5::View:Browse)
    RESET(BRW5::View:Browse,BRW5::HighlightedPosition)
    BRW5::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse)
    GET(Queue:Browse,BRW5::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse,RECORDS(Queue:Browse))
    END
    BRW5::HighlightedPosition = BRW5::Position
    GET(Queue:Browse,1)
    RESET(BRW5::View:Browse,BRW5::Position)
    BRW5::RefreshMode = RefreshOnCurrent
  ELSE
    BRW5::HighlightedPosition = ''
    DO BRW5::Reset
  END
  FREE(Queue:Browse)
  BRW5::RecordCount = 0
  BRW5::ItemsToFill = ?List{Prop:Items}
  IF BRW5::RefreshMode = RefreshOnBottom
    BRW5::FillDirection = FillBackward
  ELSE
    BRW5::FillDirection = FillForward
  END
  DO BRW5::FillRecord                             ! Fill with next read(s)
  IF BRW5::HighlightedPosition
    IF BRW5::ItemsToFill
      IF NOT BRW5::RecordCount
        DO BRW5::Reset
      END
      IF BRW5::RefreshMode = RefreshOnBottom
        BRW5::FillDirection = FillForward
      ELSE
        BRW5::FillDirection = FillBackward
      END
      DO BRW5::FillRecord
    END
  END
  IF BRW5::RecordCount
    IF BRW5::HighlightedPosition
      LOOP BRW5::CurrentChoice = 1 TO BRW5::RecordCount
        GET(Queue:Browse,BRW5::CurrentChoice)
        IF BRW5::Position = BRW5::HighlightedPosition THEN BREAK.
      END
      IF BRW5::CurrentChoice > BRW5::RecordCount
        BRW5::CurrentChoice = BRW5::RecordCount
      END
    ELSE
      IF BRW5::RefreshMode = RefreshOnBottom
        BRW5::CurrentChoice = RECORDS(Queue:Browse)
      ELSE
        BRW5::CurrentChoice = 1
      END
    END
    ?List{Prop:Selected} = BRW5::CurrentChoice
    DO BRW5::FillBuffer
  ELSE
    CLEAR(FIFO:Record)
    BRW5::CurrentChoice = 0
  END
  SETCURSOR()
  BRW5::RefreshMode = 0
  EXIT
BRW5::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW5::View:Browse)
  CASE BRW5::SortOrder
  OF 1
    FIFO:U_NR = KOPS:U_NR
    SET(FIFO:NR_KEY)
    BRW5::View:Browse{Prop:Filter} = |
    'FIFO:U_NR = BRW5::Sort1:Reset:KOPS:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW5::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW5::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW5::RecordCount
    BRW5::CurrentChoice = CHOICE(?List)
    GET(Queue:Browse,BRW5::CurrentChoice)
    WATCH(BRW5::View:Browse)
    REGET(BRW5::View:Browse,BRW5::Position)
  END
!----------------------------------------------------------------------
BRW5::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW5::SortOrder
  OF 1
    KOPS:U_NR = BRW5::Sort1:Reset:KOPS:U_NR
  END
BRW5::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?List
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
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
  IF FOCUS() <> BrowseButtons.ListBox THEN  ! List box must have focus when on update form
    EXIT
  END
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
BrowseNOL_KOPS PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
STATUSS              BYTE,DIM(12)
CLOCK_S              LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,154,55),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(20,15,111,12),RANGE(0,100)
       STRING(''),AT(3,3,148,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(50,40,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

BRW1::View:Browse    VIEW(NOL_KOPS)
                       PROJECT(KOPS:NOMENKLAT)
                       PROJECT(KOPS:NOS_S)
                       PROJECT(KOPS:KATALOGA_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::KOPS:NOMENKLAT   LIKE(KOPS:NOMENKLAT)       ! Queue Display field
BRW1::KOPS:NOS_S       LIKE(KOPS:NOS_S)           ! Queue Display field
BRW1::KOPS:KATALOGA_NR LIKE(KOPS:KATALOGA_NR)     ! Queue Display field
BRW1::STATUSS_1_       LIKE(STATUSS[1])           ! Queue Display field
BRW1::STATUSS_2_       LIKE(STATUSS[2])           ! Queue Display field
BRW1::STATUSS_3_       LIKE(STATUSS[3])           ! Queue Display field
BRW1::STATUSS_4_       LIKE(STATUSS[4])           ! Queue Display field
BRW1::STATUSS_5_       LIKE(STATUSS[5])           ! Queue Display field
BRW1::STATUSS_6_       LIKE(STATUSS[6])           ! Queue Display field
BRW1::STATUSS_7_       LIKE(STATUSS[7])           ! Queue Display field
BRW1::STATUSS_8_       LIKE(STATUSS[8])           ! Queue Display field
BRW1::STATUSS_9_       LIKE(STATUSS[9])           ! Queue Display field
BRW1::STATUSS_10_      LIKE(STATUSS[10])          ! Queue Display field
BRW1::STATUSS_11_      LIKE(STATUSS[11])          ! Queue Display field
BRW1::STATUSS_12_      LIKE(STATUSS[12])          ! Queue Display field
BRW1::GADS             LIKE(GADS)                 ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(KOPS:NOMENKLAT),DIM(100)
BRW1::Sort1:LowValue LIKE(KOPS:NOMENKLAT)         ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(KOPS:NOMENKLAT)        ! Queue position of scroll thumb
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
QuickWindow          WINDOW('Browse the NOL_KOPS File'),AT(-1,-1,361,251),FONT('MS Sans Serif',10,,FONT:bold),IMM,HLP('BrowseNOL_KOPS'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM('&2-Pârrçíinât mainîtos kopsavilkumus'),USE(?ServissPârrçíinâat0)
                           ITEM('&3-Nodzçst un Pârrçíinât visus kopsavilkumus'),USE(?ServissPârrçíinâtvisuskopsavilkumus)
                         END
                         MENU('&5-Multinoliktavu atskaites'),USE(?Multinoliktavuatskaites)
                           ITEM('&1-Rentabilitâte (S - NOM)'),USE(?MultinoliktavuatskaitesRentabilitâte)
                           ITEM('&2-Rentabilitâte (S - Pircçjiem)'),USE(?MultinoliktavuatskaitesRentabilitâtepapartneriem)
                           ITEM('&3-Rentabilitâte (S - PAR-grupâm)'),USE(?MultinoliktavuatskaitesRentabilitâtepapartnerugrupâm)
                           ITEM('&4-Rentabilitâte (S - NOM 1Pircçjam)'),USE(?MultinoliktavuatskaitesPartnerarentabilitâtesanalîze)
                           ITEM('&5-Rentabilitâtes un krâjumu analîze'),USE(?MultinoliktavuatskaitesRentabilitâtesunkrâjumuanalîze)
                           ITEM('&6-Preèu uzskaites kartiòa'),USE(?5MultinoliktavuatskaitesPUK)
                           MENU('&7-Intrastat atskaites'),USE(?5Multinoliktavuatskaites7Intrastatatskaites)
                             ITEM('Ievedums-&1A'),USE(?5MultinoliktavuatskaitesINTRASTAT1A)
                             ITEM('Ievedums-&1B'),USE(?5Multinoliktavuatskaites7Intrastatatskaites1B)
                             ITEM('Izvedums-&2A'),USE(?5Multinoliktavuatskaites7Intrastatatskaites2A)
                             ITEM('Izvedums-&2B'),USE(?5Multinoliktavuatskaites7Intrastatatskaites2B)
                           END
                           ITEM,SEPARATOR
                           ITEM('Ie&nâkuðo preèu kopsavilkums'),USE(?MultinoliktavuatskaitesIenâkuðopreèukopsavilkums)
                           ITEM('&Realizâcijas kopsavilkums'),USE(?MultinoliktavuatskaitesRealizâcijaskopsavilkums)
                           ITEM('I&ekðçjas pârvietoðanas analîze'),USE(?MultinoliktavuatskaitesIekðçjaspârvietoðanasanalîze)
                           ITEM('Preèu &iekð. kustîba starp noliktavâm'),USE(?MultinoliktavuatskaitesPreèuiekðkustîbastarpnoliktavâm)
                           ITEM('Izziòa par precçm &bez kustîbas un atlikuma'),USE(?5MultinoliktavuatskaitesIzziòaparprecçmbezkustîbasunatlikuma)
                         END
                         MENU('&6-Bilances atskaites'),USE(?Bilancesatskaites)
                           ITEM('P&reèu atlikumi '),USE(?BilancesatskaitesPrecuatlikumi)
                           ITEM('Preèu &apgrozîjums'),USE(?BilancesatskaitesPrecuapgrozijums)
                           ITEM('&Paðizmaksa'),USE(?BilancesatskaitesPasizmaksa)
                         END
                         MENU('&7-Vadîbas atskaites'),USE(?7Vadîbasatskaites)
                           ITEM('&Paðizmaksa'),USE(?VadibasatskaitesPasizmaksa)
                         END
                         MENU('&8-Datu apmaiòa'),USE(?Datuapmaiòa)
                           ITEM('Datu imports no citas DB'),USE(?DatuimportsnocitasDB),DISABLE
                         END
                       END
                       LIST,AT(5,20,354,197),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('80L(2)|M~Nomenklatûra~@s21@68L(2)|M~Nosaukums~@s16@68L(2)|M~Kataloga Nr~@s17@10C' &|
   '|M~1~@n1@10C|M~2~@n1@10C|M~3~@n1@10C|M~4~@n1@10C|M~5~@n1@10C|M~6~@n1@10C|M~7~@n1' &|
   '@10C|M~8~@n1@10C|M~9~@n1@10C|M~10~@n1@10C|M~11~@n1@10L(2)|M~12~L(1)@n1@'),FROM(Queue:Browse:1)
                       ENTRY(@s21),AT(3,226,83,12),USE(KOPS:NOMENKLAT),UPR
                       BUTTON('&Apskatît'),AT(264,225,45,14),USE(?Change:3),DEFAULT
                       SHEET,AT(2,3,361,219),USE(?CurrentTab)
                         TAB('Ðis gads'),USE(?Tab:2)
                           STRING('Ticamîbas statusa baiti (2-OK,1-jâpârrçíina,0-nav rçíinâts)'),AT(179,4),USE(?String2)
                         END
                       END
                       BUTTON('&Beigt'),AT(311,225,45,14),USE(?Close)
                       STRING('-pçc nomenklatûras '),AT(89,227),USE(?String1)
                       BUTTON('&Dzçst'),AT(216,225,45,14),USE(?Delete:3)
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
  CHECKOPEN(GLOBAL,1)
  ACCEPT
    ?TAB:2{PROP:TEXT}=GADS&'.gads'
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
        DO ListBoxDispatch
      END
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
    END
    QUICKWINDOW{PROP:TEXT}='Kopsavilkumi '&CLIP(RECORDS(nol_kops))&' raksti '&CLIP(path())
    CASE GL:FMI_TIPS
    OF 'VS'
       ?BilancesatskaitesPrecuapgrozijums{PROP:TEXT}='Preèu &apgrozîjums (VS)'
       ?BilancesatskaitesPasizmaksa{PROP:TEXT}='&Paðizmaksa (VS)'
       ?BilancesatskaitesPrecuatlikumi{PROP:TEXT}='P&reèu atlikumi (VS)'
       ?VadibasatskaitesPasizmaksa{PROP:TEXT}='&Paðizmaksa (VS)'
    ELSE
       ?BilancesatskaitesPrecuapgrozijums{PROP:TEXT}='Preèu &apgrozîjums (FIFO)'
       ?BilancesatskaitesPasizmaksa{PROP:TEXT}='&Paðizmaksa (FIFO)'
       ?BilancesatskaitesPrecuatlikumi{PROP:TEXT}='P&reèu atlikumi (FIFO)'
       ?VadibasatskaitesPasizmaksa{PROP:TEXT}='&Paðizmaksa (FIFO)'
    .
    CASE ACCEPTED()
    OF ?ServissPârrçíinâat0
      DO SyncWindow
      REQ#=1
      DO PARREKKOPS
    OF ?ServissPârrçíinâtvisuskopsavilkumus
      DO SyncWindow
      REQ#=2
      DO PARREKKOPS
    OF ?MultinoliktavuatskaitesRentabilitâte
      DO SyncWindow
      OPCIJA='0100'
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
      OPCIJA='100300'
      !       123456 2:PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               OPCIJA_NR=1
               START(K_RENV,50000)
            .
         .
      END
    OF ?MultinoliktavuatskaitesRentabilitâtepapartneriem
      DO SyncWindow
      OPCIJA='0100'
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
      OPCIJA='110300'
      !       123456 2:1=VISI PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               OPCIJA_NR=2
               !START(K_RENV1,50000)
               START(K_RENV,50000)
            .
         .
      END
    OF ?MultinoliktavuatskaitesRentabilitâtepapartnerugrupâm
      DO SyncWindow
      OPCIJA='0100'
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
      OPCIJA='110300'
      !       123456 2:1=VISI PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               OPCIJA_NR=3
               !START(K_RENVPG,50000)
               START(K_RENV,50000)
            .
         .
      END
    OF ?MultinoliktavuatskaitesPartnerarentabilitâtesanalîze
      DO SyncWindow
      OPCIJA='0100'
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            OPCIJA='120300'
      !             123456 2:2=TIKAI 1 PARTNERIS
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               OPCIJA_NR=4
               !START(K_RENVKP,50000)
               START(K_RENV,50000)
            .
         .
      .
    OF ?MultinoliktavuatskaitesRentabilitâtesunkrâjumuanalîze
      DO SyncWindow
      OPCIJA='1110020'
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         IZZFILTK
         IF GlobalResponse = RequestCompleted
            START(K_RENTKRAJ,50000)
         .
      END
    OF ?5MultinoliktavuatskaitesPUK
      DO SyncWindow
      GlobalRequest = SelectRecord
      NOMENKLAT = KOPS:NOMENKLAT
      !IZZFILTN('00110002000000000')
      !IZZFILTGMCK('1111120')
      !IF GlobalResponse=RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
           START(K_KARTDRU,50000)
         .
      !END
      !IZZFILTGMCK('1111120')
      !IF GlobalResponse = RequestCompleted
      !   SEL_NOL_NR25
      !   IF GlobalResponse = RequestCompleted
      !       START(K_RENVPG,50000)
      !   .
      !END
    OF ?5MultinoliktavuatskaitesINTRASTAT1A
      DO SyncWindow
      OPCIJA='1200' !TIKAI MÇNEÐI
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            OPCIJA='100301'
      !             123456 2:PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               K_INTRASTAT(1) !PAR_TIPS='C'
            .
         .
      .
      
    OF ?5Multinoliktavuatskaites7Intrastatatskaites1B
      DO SyncWindow
      
      OPCIJA='1200' !TIKAI MÇNEÐI
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            OPCIJA='100301'
      !             123456 2:PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               K_INTRASTAT(2) !PAR_TIPS='C'
            .
         .
      .
    OF ?5Multinoliktavuatskaites7Intrastatatskaites2A
      DO SyncWindow
      OPCIJA='1200' !TIKAI MÇNEÐI
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            OPCIJA='100301'
      !             123456 2:PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               K_INTRASTAT(3) !PAR_TIPS='C'
            .
         .
      .
    OF ?5Multinoliktavuatskaites7Intrastatatskaites2B
      DO SyncWindow
      
      OPCIJA='1200' !TIKAI MÇNEÐI
      !       1234
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            OPCIJA='100301'
      !             123456 2:PARTNERU FILTRI
            IZZFILTK
            IF GlobalResponse = RequestCompleted
               K_INTRASTAT(4) !PAR_TIPS='C'
            .
         .
      .
    OF ?MultinoliktavuatskaitesIenâkuðopreèukopsavilkums
      DO SyncWindow
      !OPCIJA='100'
      !IZZFILTGMC
      !IF GlobalResponse = RequestCompleted
         OPCIJA='11'
         IZZFILTNK
         IF GlobalResponse = RequestCompleted
            START(K_IENMAT,50000)
         .
      !END
    OF ?MultinoliktavuatskaitesRealizâcijaskopsavilkums
      DO SyncWindow
      !OPCIJA='100'
      !IZZFILTGMC
      !IF GlobalResponse = RequestCompleted
         OPCIJA='11'
         IZZFILTNK
         IF GlobalResponse = RequestCompleted
            START(K_REALIZ,50000)
         .
      !END
    OF ?MultinoliktavuatskaitesIekðçjaspârvietoðanasanalîze
      DO SyncWindow
      OPCIJA='111'
      IZZFILTGMC
      IF GlobalResponse = RequestCompleted
         SEL_NOL_NR25
         IF GlobalResponse = RequestCompleted
            START(K_PrIeKusA,50000)
         .
      END
    OF ?MultinoliktavuatskaitesPreèuiekðkustîbastarpnoliktavâm
      DO SyncWindow
      OPCIJA='121'
      IZZFILTGMC
      IF Globalresponse = RequestCompleted
          START(K_PrIeKusN,50000)
      END
    OF ?5MultinoliktavuatskaitesIzziòaparprecçmbezkustîbasunatlikuma
      DO SyncWindow
        MEN_NR=17
        OPCIJA='010'
      !         123
        IZZFILTGMC
        IF GlobalResponse=RequestCOMPLETED
           OPCIJA='0000010205000001000001'
      !            1234567890123456789012
           IZZFILTN
           IF GlobalResponse=RequestCOMPLETED
              START(K_PRECES,50000)
           .
        .
    OF ?BilancesatskaitesPrecuatlikumi
      DO SyncWindow
      OPCIJA='1400'
      !       1234
      IZZFILTGMC
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         OPCIJA='0000010300000300000001'
      !          1234567890123456789012
         IZZFILTN
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            START(K_A_FIFO,50000)
         .
      .
    OF ?BilancesatskaitesPrecuapgrozijums
      DO SyncWindow
      OPCIJA='110'
      IZZFILTGMC
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         OPCIJA='0000010300000300000001'
      !          1234567890123456789012
         IZZFILTN
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            START(K_B_FIFO,50000)
         .
      .
    OF ?BilancesatskaitesPasizmaksa
      DO SyncWindow
      OPCIJA='110'
      IZZFILTGMC
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         OPCIJA='0000010300000000000001'
      !          1234567890123456789012
         IZZFILTN
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            DAIKODS=0 ! ~VADÎBAS ATSKAITE
            START(K_P_FIFO,50000)
         .
      .
    OF ?VadibasatskaitesPasizmaksa
      DO SyncWindow
      OPCIJA='110'
      IZZFILTGMC
      IF GLOBALRESPONSE=REQUESTCOMPLETED
         OPCIJA='00000103030000000000'
      !          12345678901234567890
         IZZFILTN
         IF GLOBALRESPONSE=REQUESTCOMPLETED
            DAIKODS=1 !PÇC ÐITÂ ATÐÍIR, VAI VADÎBAS, VAI BILANCES
            START(K_P_FIFO,50000)
         .
      .
                        
    OF ?DatuimportsnocitasDB
      DO SyncWindow
      !  browsenol_kop1
        LocalRequest = OriginalRequest
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        DO BRW1::InitializeBrowse
        DO BRW1::PostNewSelection
        DO BRW1::RefreshPage
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
    OF ?KOPS:NOMENKLAT
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?KOPS:NOMENKLAT)
        IF KOPS:NOMENKLAT
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort1:LocatorValue = KOPS:NOMENKLAT
          BRW1::Sort1:LocatorLength = LEN(CLIP(KOPS:NOMENKLAT))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
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
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        UpdateNOL_KOPS 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOL_FIFO::Used = 0
    CheckOpen(NOL_FIFO,1)
  END
  NOL_FIFO::Used += 1
  BIND(FIFO:RECORD)
  IF NOL_KOPS::Used = 0
    CheckOpen(NOL_KOPS,1)
  END
  NOL_KOPS::Used += 1
  BIND(KOPS:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseNOL_KOPS','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('GADS',GADS)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
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
    NOL_FIFO::Used -= 1
    IF NOL_FIFO::Used = 0 THEN CLOSE(NOL_FIFO).
    NOL_KOPS::Used -= 1
    IF NOL_KOPS::Used = 0 THEN CLOSE(NOL_KOPS).
  END
  IF WindowOpened
    INISaveWindow('BrowseNOL_KOPS','winlats.INI')
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
    KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
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
!-----------------------------------------------------------------------------------------------
!REQ#=1 PÂRRÇÍINAM MAINÎTOS
!REQ#=2 NODZÇST UN PÂRRÇÍINÂT VISU
!
PARREKKOPS      ROUTINE
  CLOSE(BRW1::View:Browse)   ! VIEWS SAGRÂBJ HAILAITÇTO IERAKSTU UN NEÏAUJ DZÇST
  IF REQ#=2  !NODZÇST UN PÂRRÇÍINÂT VISU
     CLOSE(NOL_KOPS)
     REMOVE(NOL_KOPS)
     IF ERROR() THEN STOP('DZÇÐOT NOL_KOPS: '&ERROR()).
     CHECKOPEN(NOL_KOPS,1)
     CLOSE(NOL_FIFO)
     REMOVE(NOL_FIFO)
     IF ERROR() THEN STOP('DZÇÐOT NOL_FIFO: '&ERROR()).
     CHECKOPEN(NOL_FIFO,1)
  .
  CHECKOPEN(GLOBAL,1)
  IF NOM_K::USED=0
     CHECKOPEN(NOM_K,1)
  .
  NOM_K::USED+=1

  NPK#=0
  BUVEJAM#=0
  RecordsToProcess = RECORDS(NOM_K)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  CLOCK_S=CLOCK()
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% '&FORMAT(CLOCK_S,@T4)
  EXECUTE REQ#
     ProgressWindow{Prop:Text} = 'Mainîto Kopsavilkumu pârrçíins. '&clip(GL:DB_GADS)&'.gads'
     ProgressWindow{Prop:Text} = 'Kopsavilkumu pilns pârrçíins. '&clip(GL:DB_GADS)&'.gads'
  .
  ?Progress:UserString{Prop:Text}=''
  DISPLAY()
  SET(NOM:NOM_KEY)
  SEND(NOM_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
         NEXT(NOM_K)
         NPK#+=1
         IF ERROR()
            POST(Event:CloseWindow)
            break
         .
         ?Progress:UserString{Prop:Text}='NPK='&NPK#&' NOM='&NOM:NOMENKLAT
         RecordsProcessed += 1
         RecordsThisCycle += 1
         IF PercentProgress < 100
           PercentProgress = (RecordsProcessed / RecordsToProcess)*100
           IF PercentProgress > 100
             PercentProgress = 100
           END
           IF PercentProgress <> Progress:Thermometer THEN
             Progress:Thermometer = PercentProgress
             ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'&FORMAT(CLOCK()-CLOCK_S,@T4)
           END
         END
         DISPLAY()
         IF NOM:TIPS='T' THEN CYCLE.    !Taru izlaiþam
         IF NOM:TIPS='A' THEN CYCLE.    !A-Pakalpojumus izlaiþam
         IF NOM:TIPS='I' THEN CYCLE.    !Iepakojumus izlaiþam
         IF NOM:TIPS='V' THEN CYCLE.    !Virtuâlos (Avanss,Dâvanu kartes) izlaiþam  !!!PAGAIDÂM
         IF NOM:REDZAMIBA=2 THEN CYCLE. !NÂKOTNES IZLAIÞAM
         IF REQ#=1                      !PÂRRÇÍINÂT, JA KAS MAINÎTS
            CLEAR(KOPS:RECORD)
            KOPS:NOMENKLAT=NOM:NOMENKLAT
            GET(NOL_KOPS,KOPS:NOM_KEY)
            IF ~ERROR()
               IRMAINITS#=FALSE
               LOOP I#= 1 TO NOL_SK
                  LOOP M#= 1 TO 12
                     IF KOPS:STATUSS[M#,I#]<2 !NAV OK. ÐAJÂ NOLIKTAVÂ
                        IRMAINITS#=TRUE
                        BREAK
                     .
                  .
                  IF IRMAINITS#=TRUE THEN BREAK.
                  IF I#=NOL_SK THEN BREAK.
               .
               IF IRMAINITS#=FALSE THEN CYCLE.
            .
         .
         BUVEJAM#+=1
         CheckkopS(NOM:NOMENKLAT,REQ#,0)
!         CheckkopS(NOM:NOMENKLAT,2,0)
         IF GLOBALRESPONSE=REQUESTCANCELLED
            POST(Event:CloseWindow)
            break
         .
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
  ACCEPT
    EXECUTE REQ#
       ?Progress:UserString{Prop:Text}= 'Analizçtas '&clip(NPK#)&',Pârbûvçtas '&clip(BUVEJAM#)&' nomenklatûras'
       ?Progress:UserString{Prop:Text}= 'Analizçtas '&clip(NPK#)&',Uzbûvçtas '&clip(BUVEJAM#)&' nomenklatûras'
    .
    ?Progress:PctText{Prop:Text} = FORMAT(CLOCK()-CLOCK_S,@T4)
    ?Progress:Cancel{PROP:TEXT}='OK'
    DISPLAY()
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        BREAK
      END
    END
  .
  CLOSE(ProgressWindow)
  IF SEND(NOM_K,'QUICKSCAN=off').
  NOM_K::USED-=1
  IF NOM_K::USED=0 THEN CLOSE(NOM_K).
!  OPEN(BRW1::View:Browse)
   DO BRW1::InitializeBrowse
   DO BRW1::RefreshPage
   DISPLAY
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
      KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
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
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = KOPS:NOMENKLAT
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = KOPS:NOMENKLAT
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
  KOPS:NOMENKLAT = BRW1::KOPS:NOMENKLAT
  KOPS:NOS_S = BRW1::KOPS:NOS_S
  KOPS:KATALOGA_NR = BRW1::KOPS:KATALOGA_NR
  STATUSS[1] = BRW1::STATUSS_1_
  STATUSS[2] = BRW1::STATUSS_2_
  STATUSS[3] = BRW1::STATUSS_3_
  STATUSS[4] = BRW1::STATUSS_4_
  STATUSS[5] = BRW1::STATUSS_5_
  STATUSS[6] = BRW1::STATUSS_6_
  STATUSS[7] = BRW1::STATUSS_7_
  STATUSS[8] = BRW1::STATUSS_8_
  STATUSS[9] = BRW1::STATUSS_9_
  STATUSS[10] = BRW1::STATUSS_10_
  STATUSS[11] = BRW1::STATUSS_11_
  STATUSS[12] = BRW1::STATUSS_12_
  GADS = BRW1::GADS
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
  LOOP J#=1 TO 12
     STATUSS[J#]=2
     LOOP I#=1 TO NOL_SK
        IF STATUSS[J#] > KOPS:STATUSS[J#,I#]  !PARÂDAM MAZÂKO STATUSU
           STATUSS[J#] = KOPS:STATUSS[J#,I#]
        .
     .
  .
  BRW1::KOPS:NOMENKLAT = KOPS:NOMENKLAT
  BRW1::KOPS:NOS_S = KOPS:NOS_S
  BRW1::KOPS:KATALOGA_NR = KOPS:KATALOGA_NR
  BRW1::STATUSS_1_ = STATUSS[1]
  BRW1::STATUSS_2_ = STATUSS[2]
  BRW1::STATUSS_3_ = STATUSS[3]
  BRW1::STATUSS_4_ = STATUSS[4]
  BRW1::STATUSS_5_ = STATUSS[5]
  BRW1::STATUSS_6_ = STATUSS[6]
  BRW1::STATUSS_7_ = STATUSS[7]
  BRW1::STATUSS_8_ = STATUSS[8]
  BRW1::STATUSS_9_ = STATUSS[9]
  BRW1::STATUSS_10_ = STATUSS[10]
  BRW1::STATUSS_11_ = STATUSS[11]
  BRW1::STATUSS_12_ = STATUSS[12]
  BRW1::GADS = GADS
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
      IF BRW1::PopupText
        BRW1::PopupText = '&Apskatît|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Apskatît'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '~&Apskatît|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '~&Apskatît'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Change:3)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => UPPER(KOPS:NOMENKLAT)
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
      KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
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
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF KEYCODE() = BSKey
          IF BRW1::Sort1:LocatorLength
            BRW1::Sort1:LocatorLength -= 1
            BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength)
            KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & ' '
          BRW1::Sort1:LocatorLength += 1
          KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort1:LocatorValue = SUB(BRW1::Sort1:LocatorValue,1,BRW1::Sort1:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort1:LocatorLength += 1
          KOPS:NOMENKLAT = BRW1::Sort1:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
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
      KOPS:NOMENKLAT = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'NOL_KOPS')
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
      BRW1::HighlightedPosition = POSITION(KOPS:NOM_key)
      RESET(KOPS:NOM_key,BRW1::HighlightedPosition)
    ELSE
      SET(KOPS:NOM_key,KOPS:NOM_key)
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
    OF 1; ?KOPS:NOMENKLAT{Prop:Disable} = 0
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
  ELSE
    CLEAR(KOPS:Record)
    CASE BRW1::SortOrder
    OF 1; ?KOPS:NOMENKLAT{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
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
    SET(KOPS:NOM_key)
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
  BrowseButtons.InsertButton=0
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=0
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
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateNOL_KOPS) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNOL_KOPS
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
        GET(NOL_KOPS,0)
        CLEAR(KOPS:Record,0)
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


SELECTJOB PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
DisplayString        STRING(255)
menulines   byte
window               WINDOW('Norâdiet datu bâzi'),AT(,,383,199),CENTER,SYSTEM,GRAY,MDI
                       MENUBAR
                         MENU('&2-Serviss'),USE(?Serviss),KEY(CtrlE)
                           ITEM,SEPARATOR
                           ITEM('&2-Arhivçt DB'),USE(?SeanssArhivçtDB)
                           ITEM('&3-Jaunas DB (gada) izveidoðana'),USE(?SeanssJDB)
                           ITEM('&4-DB avârijas atjaunoðana'),USE(?ServissDBAA),DISABLE
                           ITEM('&5-Noliktavu iekðçjâs kustîbas kontrole'),USE(?ServissNoliktavasiekðçjâskustîbaskontrole)
                         END
                         MENU('&4-Faili'),USE(?Failis)
                           ITEM('&1-Partneru saraksts'),USE(?2Serviss4Faili1Partnerusaraksts),FIRST
                         END
                       END
                       GROUP('B-Grâmatvedîba'),AT(14,22,60,149),USE(?Group1),BOXED
                       END
                       GROUP('N-Noliktavas'),AT(80,22,166,149),USE(?Group1:2),BOXED
                         BUTTON('&Kopsavilkumi'),AT(181,124,52,14),USE(?ButtonNolKops),DISABLE
                         BUTTON('&Statistika'),AT(181,139,52,14),USE(?ButtonNolStat),DISABLE
                       END
                       GROUP('A-Algas'),AT(248,22,49,149),USE(?Group1:4),BOXED
                       END
                       GROUP('P-Pamatlîdzekïi'),AT(300,22,77,149),USE(?Group1:5),BOXED
                       END
                       OPTION('Darba izvçles logs'),AT(10,6,372,170),USE(JOB_NR),BOXED
                         RADIO('&Bâze01'),AT(25,35),USE(?Job:Radio1)
                         RADIO('Bâze02'),AT(25,43,37,10),USE(?Job:Radio2)
                         RADIO('Bâze03'),AT(25,51,37,10),USE(?Job:Radio3)
                         RADIO('Bâze04'),AT(25,59,37,10),USE(?Job:Radio4)
                         RADIO('Bâze05'),AT(25,67,37,10),USE(?Job:Radio5)
                         RADIO('Bâze06'),AT(25,75,37,10),USE(?Job:Radio6)
                         RADIO('Bâze07'),AT(25,83,37,10),USE(?Job:Radio7)
                         RADIO('Bâze08'),AT(25,91,37,10),USE(?Job:Radio8)
                         RADIO('Bâze09'),AT(25,99,37,10),USE(?Job:Radio9)
                         RADIO('Bâze10'),AT(25,107,37,10),USE(?Job:Radio10)
                         RADIO('Bâze11'),AT(25,115,37,10),USE(?Job:Radio11)
                         RADIO('Bâze12'),AT(25,123,37,10),USE(?Job:Radio12)
                         RADIO('Bâze13'),AT(25,131,37,10),USE(?Job:Radio13)
                         RADIO('Bâze14'),AT(25,139,37,10),USE(?Job:Radio14)
                         RADIO('Bâze15'),AT(25,147,37,10),USE(?Job:Radio15)
                         RADIO('&Noliktava01'),AT(88,35,75,10),USE(?Job:Radio16)
                         RADIO('Noliktava02'),AT(88,43,75,10),USE(?Job:Radio17)
                         RADIO('Noliktava03'),AT(88,51,75,10),USE(?Job:Radio18)
                         RADIO('Noliktava04'),AT(88,59,75,10),USE(?Job:Radio19)
                         RADIO('Noliktava05'),AT(88,67,75,10),USE(?Job:Radio20)
                         RADIO('Noliktava06'),AT(88,75,75,10),USE(?Job:Radio21)
                         RADIO('Noliktava07'),AT(88,83,75,10),USE(?Job:Radio22)
                         RADIO('Noliktava08'),AT(88,91,75,10),USE(?Job:Radio23)
                         RADIO('Noliktava09'),AT(88,99,75,10),USE(?Job:Radio24)
                         RADIO('Noliktava10'),AT(88,107,75,10),USE(?Job:Radio25)
                         RADIO('Noliktava11'),AT(88,115,75,10),USE(?Job:Radio26)
                         RADIO('Noliktava12'),AT(88,123,75,10),USE(?Job:Radio27)
                         RADIO('Noliktava13'),AT(88,131,75,10),USE(?Job:Radio28)
                         RADIO('Noliktava14'),AT(88,139,75,10),USE(?Job:Radio29)
                         RADIO('Noliktava15'),AT(88,147,75,10),USE(?Job:Radio30)
                         RADIO('Noliktava16'),AT(164,35,75,10),USE(?Job:Radio31)
                         RADIO('Noliktava17'),AT(164,43,75,10),USE(?Job:Radio32)
                         RADIO('Noliktava18'),AT(164,51,75,10),USE(?Job:Radio33)
                         RADIO('Noliktava19'),AT(164,59,75,10),USE(?Job:Radio34)
                         RADIO('Noliktava20'),AT(164,67,75,10),USE(?Job:Radio35)
                         RADIO('Noliktava21'),AT(164,75,75,10),USE(?Job:Radio36)
                         RADIO('Noliktava22'),AT(164,83,75,10),USE(?Job:Radio37)
                         RADIO('Noliktava23'),AT(164,91,75,10),USE(?Job:Radio38)
                         RADIO('Noliktava24'),AT(164,99,75,10),USE(?Job:Radio39)
                         RADIO('Noliktava25'),AT(164,107,75,10),USE(?Job:Radio40)
                         RADIO('&Alga 01'),AT(253,35),USE(?Job:Radio66),VALUE('66')
                         RADIO('Alga 02'),AT(253,43),USE(?Job:Radio67),VALUE('67')
                         RADIO('Alga 03'),AT(253,51),USE(?Job:Radio68),VALUE('68')
                         RADIO('Alga 04'),AT(253,59),USE(?Job:Radio69),VALUE('69')
                         RADIO('Alga 05'),AT(253,67),USE(?Job:Radio70),VALUE('70')
                         RADIO('Alga 06'),AT(253,75),USE(?Job:Radio71),VALUE('71')
                         RADIO('Alga 07'),AT(253,83),USE(?Job:Radio72),VALUE('72')
                         RADIO('Alga 08'),AT(253,91),USE(?Job:Radio73),VALUE('73')
                         RADIO('Alga 09'),AT(253,99),USE(?Job:Radio74),VALUE('74')
                         RADIO('Alga 10'),AT(253,107),USE(?Job:Radio75),VALUE('75')
                         RADIO('Alga 11'),AT(253,115),USE(?Job:Radio76),VALUE('76')
                         RADIO('Alga 12'),AT(253,123),USE(?Job:Radio77),VALUE('77')
                         RADIO('Alga 13'),AT(253,131),USE(?Job:Radio78),VALUE('78')
                         RADIO('Alga 14'),AT(253,139),USE(?Job:Radio79),VALUE('79')
                         RADIO('Alga 15'),AT(253,147),USE(?Job:Radio80),VALUE('80')
                         RADIO('&PAM 01'),AT(312,35),USE(?Job:Radio81),VALUE('81')
                         RADIO('PAM 02'),AT(312,43),USE(?Job:Radio82),VALUE('82')
                         RADIO('PAM 03'),AT(312,51),USE(?Job:Radio83),VALUE('83')
                         RADIO('PAM 04'),AT(312,59),USE(?Job:Radio84),VALUE('84')
                         RADIO('PAM 05'),AT(312,67),USE(?Job:Radio85),VALUE('85')
                         RADIO('PAM 06'),AT(312,75),USE(?Job:Radio86),VALUE('86')
                         RADIO('PAM 07'),AT(312,83),USE(?Job:Radio87),VALUE('87')
                         RADIO('PAM 08'),AT(312,91),USE(?Job:Radio88),VALUE('88')
                         RADIO('PAM 09'),AT(312,99),USE(?Job:Radio89),VALUE('89')
                         RADIO('PAM 10'),AT(312,107),USE(?Job:Radio90),VALUE('90')
                         RADIO('PAM 11'),AT(312,115),USE(?Job:Radio91),VALUE('91')
                         RADIO('PAM 12'),AT(312,123),USE(?Job:Radio92),VALUE('92')
                         RADIO('PAM 13'),AT(312,131),USE(?Job:Radio93),VALUE('93')
                         RADIO('PAM 14'),AT(312,139),USE(?Job:Radio94),VALUE('94')
                         RADIO('PAM 15'),AT(312,147),USE(?Job:Radio95),VALUE('95')
                       END
                       BUTTON('&OK'),AT(325,177,54,14),USE(?ok),DEFAULT
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    CONVERTFILE(1) !27/01/2015
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF ATLAUTS[1]='1' !SUPERACC
     ENABLE(?ServissDBAA)
  .
  
  MAINIT231531=FALSE !AIZLIEGTS MAINÎT GG&GGK RAKSTUS CAUR PAR_K N231 N531
  DZNAME='DZ00'  !DARBA ÞURNÂLS,LAI TAS MUÏKIS NELAMÂJAS
  menulines=10+6-3 ! ÐÎ LOGA MENU&ITEM skaita,Seperatorus neskaita=10-3 + ekrâna stringi=6
  FP#=0
  LOOP I#= 40 TO 134     !40-SÂKAS BASE_ACC 134-beidzas P/L
     IF INRANGE(I#,80,104) !POS
        FP#=25
        CYCLE
     .
     IF ATLAUTS[I#]='N'
        DISABLE(I#-39+1+menulines-FP#)
        IF I#-39=JOB_NR
           JOB_NR=0
        .
     ELSIF INRANGE(I#,55,79)     !ATÏAUTA KÂDA NOLIKTAVA
        SAV_JOB_NR#=JOB_NR
        JOB_NR=I#-39             !Pieðíiram noliktavas vârdu
        CHECKOPEN(SYSTEM,1)
        EXECUTE JOB_NR-15
           ?Job:Radio16{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio17{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio18{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio19{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio20{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio21{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio22{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio23{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio24{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio25{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio26{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio27{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio28{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio29{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio30{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio31{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio32{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio33{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio34{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio35{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio36{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio37{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio38{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio39{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
           ?Job:Radio40{PROP:TEXT}='N'&CLIP(JOB_NR-15)&':'&SYS:AVOTS
        .
        JOB_NR=SAV_JOB_NR#
        IF ~(ATLAUTS[13]='1')    !1+8+4
           ENABLE(?ButtonNolKops)
        .
        IF ~(ATLAUTS[12]='1')    !1+8+3
           ENABLE(?ButtonNolStat)
        .
     .
  .
  !!SELECT(JOB_NR-19+1+menulines)
  !SELECT(JOB_NR+1+menulines)
  ACCEPT
    WINDOW{PROP:TEXT}='Taka: '&CLIP(LONGpath())
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?ButtonNolKops)
      SELECT(JOB_NR+1+menulines)
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
    CASE ACCEPTED()
    OF ?SeanssArhivçtDB
      DO SyncWindow
        CLOSE(GLOBAL)  !JÂBÛT CIET
        CLOSE(SYSTEM)  !DÇÏ VÂRDA IR VAÏÂ
     IF ARJ
        FILENAME1='WL'&FORMAT(TODAY(),@D11)
        IF INSTRING('RAR.',UPPER(ARJ),1)
           RUN(ARJ&' A -dh -agYYMMDD WL *.tps *.txt reg.key dz*',1)
        ELSIF INSTRING('7Z',UPPER(ARJ),1)  !VAR BÛT 7z.exe 03.02.2015
           RUN(ARJ&' a -tzip -ssw -mx7 '&CLIP(FILENAME1)&'.zip *.tps *.txt reg.key dz*',1)
        ELSIF INSTRING('ZIP',UPPER(ARJ),1)  !VAR BÛT WINZIP32.EXE
           RUN(ARJ&' -a '&CLIP(FILENAME1)&'.zip *.tps *.txt reg.key dz*',1)
        ELSIF INSTRING('ARJ.',UPPER(ARJ),1)
           RUN(ARJ&' A '&CLIP(FILENAME1)&'.arj *.tps *.txt reg.key dz*',1)
        ELSE
           KLUDA(0,'Definçts neatïauts Arhivators '&ARJ)
        .
        IF RUNCODE()=-4
           KLUDA(88,'prog-a '&ARJ)
        .
        FILENAME1=''
     ELSE
        KLUDA(0,'Nav definçta Arhivatora izsaukðana C:\WINLATS\WinLatsC.ini')
     .
!        ForceRefresh = True
!        LocalRequest = OriginalRequest
!        DO RefreshWindow
        CHECKOPEN(GLOBAL,1)
        CHECKOPEN(SYSTEM,1)

    OF ?SeanssJDB
      DO SyncWindow
      NYcreator 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?ServissDBAA
      DO SyncWindow
      TPSfix 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?ServissNoliktavasiekðçjâskustîbaskontrole
      DO SyncWindow
      SelftestNoliekK 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?2Serviss4Faili1Partnerusaraksts
      DO SyncWindow
      BrowsePAR_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    END
    CASE FIELD()
    OF ?ButtonNolKops
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        BrowseNOL_KOPS 
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?ButtonNolStat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        START(BrowseNol_Stat,25000)
        LocalRequest = OriginalRequest
        DO RefreshWindow
      END
    OF ?Job:Radio1
      CASE EVENT()
      OF EVENT:Selected
        job_nr=1
        display
      END
    OF ?Job:Radio16
      CASE EVENT()
      OF EVENT:Selected
        job_nr=16
        display
      END
    OF ?Job:Radio66
      CASE EVENT()
      OF EVENT:Selected
        job_nr=66
        display
      END
    OF ?Job:Radio81
      CASE EVENT()
      OF EVENT:Selected
        job_nr=81
        display
      END
    OF ?ok
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !**************** SÂKUMA VÂRDS *************************
           DZNAME ='DZ'&FORMAT(JOB_NR,@N02) !DARBA ÞURNÂLS
           DZFNAME='DZFILES'                !DARBA ÞURNÂLS FAILIEM GAN DEFINÇTS JAU AGRÂK
           CHECKOPEN(ZURNALS,1)
           CHECKOPEN(ZURFILE,1)
           CHECKOPEN(SYSTEM,1)  !15.06.06
           IF YEAR(TODAY()) > DB_GADS
              S_DAT=DATE(1,1,DB_GADS)
              B_DAT=DATE(12,31,DB_GADS)
           ELSIF ~INRANGE(S_DAT,DATE(1,1,YEAR(TODAY())),TODAY()) OR  ~INRANGE(B_DAT,DATE(1,1,YEAR(TODAY())),TODAY())
              S_DAT=DATE(MONTH(TODAY()),1,YEAR(TODAY()))
              B_DAT=TODAY()
           .
           SYS_PARAKSTS_NR=SYS:PARAKSTS_NR !PARAKSTA NR
           VAL_NOS=VAL_LV
           Apskatit231531=TRUE  !APSKATÎT N231,N531 PAR_K
           IF JOB_NR>40  !ALGA,PAM
        !      JOB_NR+=25 !DÇÏ IZRAUTÂ FP - IELIKU VALUE
           .
           IF INRANGE(JOB_NR,1,15)        !BASE
              GL_CONT(1)
              IF GLOBALRESPONSE=REQUESTCOMPLETED
                 CLOSE(GG)
                 CLOSE(GGK)
                 CLOSE(TEKSTI)
                 LOC_NR=JOB_NR
                 GGNAME='GG'&FORMAT(JOB_NR,@N02)
                 GGKNAME='GGK'&FORMAT(JOB_NR,@N02)
                 TEXNAME='TEX_VES'                    !TEKSTI VÇSTUREI
                 IF GADS>=2008
                    KONRNAME='KON_2008'
                 ELSE
                    KONRNAME='KON_R'
                 .
                 BROWSEGG
                 LOC_NR=0
              .
           ELSIF INRANGE(JOB_NR,16,40)    !NOLIKTAVA
              GL_CONT(2)
              IF GLOBALRESPONSE=REQUESTCOMPLETED
                 CLOSE(PAVAD)
                 CLOSE(NOLIK)
                 CLOSE(TEKSTI)
                 LOC_NR=JOB_NR-15
                 PAVADNAME='PAVAD'&FORMAT(LOC_NR,@N02)
                 NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)
                 AAPKNAME='AAPK'&FORMAT(LOC_NR,@N02)
                 ADARBINAME='ADARBI'&FORMAT(LOC_NR,@N02)
                 AUBNAME='AUBI'&FORMAT(LOC_NR,@N02)
                 AUBTEXNAME='AUTEX'&FORMAT(LOC_NR,@N02)
                 AUDNAME='AUDA'&FORMAT(LOC_NR,@N02)
                 ATEXNAME='ATEX'&FORMAT(LOC_NR,@N02)  !SERVISA TEKSTI
                 TEXNAME='TEX_NOL'                    !TEKSTI
                 CLOSE(GG)
                 CLOSE(GGK)
                 GGNAME='GG01'
                 GGKNAME='GGK01'
           !      START(BROWSEPAVAD,50000)
                 BROWSEPAVAD
                 LOC_NR=0
              .
           ELSIF INRANGE(JOB_NR,41,65)    !POS
        !      CLOSE(FPPAVAD)
        !      CLOSE(FPNOLIK)
        !      LOC_NR=JOB_NR-40
        !      FPPAVADNAME='FPPAV'&FORMAT(LOC_NR,@N02)
        !      FPNOLIKNAME='FPNOL'&FORMAT(LOC_NR,@N02)
        !      ANSIFILENAME='CEKS'&FORMAT(LOC_NR,@N02)&'.FP'
        !      ASCIIFILENAME='ERROR.FP'
        !      CLOSE(GG)
        !      CLOSE(GGK)
        !      GGNAME='GG01'
        !      GGKNAME='GGK01'
        !      BROWSEFPPAVAD
        !      LOC_NR=0
           ELSIF INRANGE(JOB_NR,66,80)    !ALGA
              GL_CONT(4)
              IF GLOBALRESPONSE=REQUESTCOMPLETED
                 CLOSE(ALGAS)
                 CLOSE(ALGPA)
                 LOC_NR=JOB_NR-65
                 ALGASNAME='ALGAS'&FORMAT(LOC_NR,@N02)
                 ALPANAME='ALGPA'&FORMAT(LOC_NR,@N02)
                 TEXNAME='TEX_RIK'                    !TEKSTI RÎKOJUMIEM
                 CLOSE(GG)
                 CLOSE(GGK)
                 GGNAME='GG01'
                 GGKNAME='GGK01'
                 BROWSEALPA
                 LOC_NR=0
        !         JOB_NR-=25
              .
           ELSIF INRANGE(JOB_NR,81,95)    !PAM
              GL_CONT(5)
              IF GLOBALRESPONSE=REQUESTCOMPLETED
                 CLOSE(PAMAT)
                 CLOSE(PAMAM)
                 LOC_NR=JOB_NR-80
                 PAMATNAME='PAMAT'&FORMAT(LOC_NR,@N02)
                 PAMKATNAME='PAMKAT'&FORMAT(LOC_NR,@N02)
                 PAMAMNAME='PAMAM'&FORMAT(LOC_NR,@N02)
                 TEXNAME='TEX_PAM'
                 CLOSE(GG)
                 CLOSE(GGK)
                 GGNAME='GG01'
                 GGKNAME='GGK01'
                 BROWSEPAMAT
                 LOC_NR=0
        !         JOB_NR-=25
              .
           ELSE
              STOP('JOB_NR='&JOB_NR)
           .
           MAINIT231531=FALSE !AIZLIEGTS MAINÎT GG&GGK RAKSTUS CAUR PAR_K N231 N531
           CLOSE(ZURNALS)
           CLOSE(ZURFILE)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
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
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
  END
  IF WindowOpened
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
