                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetKat_k             FUNCTION (Kat_nr,REQ,RET,NORADE) ! Declare Procedure
  CODE                                            ! Begin processed code
!
!  RET 1-2
!

 IF ~INRANGE(RET,1,2)
    RETURN('')
 .
 IF KAT_NR=''
    RETURN('')
 .
 IF KAT_K::Used = 0
    CheckOpen(KAT_K,1)
 END
 KAT_K::Used += 1
 CLEAR(KAT:RECORD)
 KAT:KAT=KAT_NR
 GET(KAT_K,KAT:NR_KEY)
 IF ERROR()
    IF REQ=1
       GlobalRequest=SelectRecord
       BrowseKat_k
       IF GLOBALRESPONSE=REQUESTCANCELLED
          RET=0
       .
    ELSIF REQ=2
       KLUDA(16,'P/L kategorija:'&FORMAT(KAT_NR,@P#-##P)&' '&NORADE)
       RET=0
    ELSE
       RET=0
    .
  .
 KAT_K::Used -= 1
 IF KAT_K::Used = 0 THEN CLOSE(KAT_K).
 EXECUTE RET+1
    RETURN('')
    RETURN(KAT:IIV)
    RETURN(KAT:KAT)
 .
ATRSUNR PROCEDURE


LocalResponse        LONG
LocalRequest         LONG
OriginalRequest      LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
SU_NR                STRING(1)
PAVNR                STRING(7)
window               WINDOW('Filtrs izziòâm'),AT(,,136,79),GRAY
                       ENTRY(@n-_10.2),AT(60,25,53,10),USE(summa)
                       OPTION('Ievadiet meklçjamo'),AT(10,14,119,41),USE(SU_NR),BOXED
                         RADIO('Summu'),AT(15,26,36,10),USE(?Su_Nr:Radio1)
                         RADIO('P/Z Nr'),AT(15,39,36,10),USE(?Su_Nr:Radio2)
                       END
                       STRING('Ls'),AT(118,26),USE(?String2)
                       ENTRY(@s7),AT(60,39,53,10),USE(PAVNR),LEFT
                       BUTTON('&OK'),AT(92,59,35,14),USE(?OkButton),DEFAULT
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
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?summa)
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
    OF ?SU_NR
      CASE EVENT()
      OF EVENT:Accepted
        !CASE FIELD()
        !OF ?SU_NR
          CHOICE# = CHOICE(?SU_NR)
          CASE CHOICE#
          OF 1
            HIDE(?PAVNR)
            UNHIDE(?SUMMA)
            UNHIDE(?STRING2)
            SELECT(?SUMMA)
          OF 2
            UNHIDE(?PAVNR)
            HIDE(?SUMMA)
            HIDE(?STRING2)
            SELECT(?PAVNR)
        !  OF ?OKButton
        !    BREAK
          END
        !END
        IF SUMMA OR PAVNR
          LOOP UNTIL EOF(PAVAD)
            CASE CHOICE#
            OF 1
              IF PAV:SUMMA = SUMMA
                LocalResponse = RequestCompleted
                BREAK
              .
              IF EOF(PAVAD)
        !!!      KLUDA(34,'')
                STOP('KLUDA(34)')
                BREAK
              .
            OF 2
              IF PAV:U_NR = PAVNR
                LocalResponse = RequestCompleted
                BREAK
              .
              IF EOF(PAVAD)
        !!!      KLUDA(73,'')
                STOP('KLUDA(73)')
                BREAK
              .
            .
          .
        .
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('ATRSUNR','winlats.INI')
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
    INISaveWindow('ATRSUNR','winlats.INI')
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
selpz PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
CurrentTab           STRING(80)
PZTIPS               STRING(1)
MB                   BYTE
PB                   BYTE
BAN_NOS_P            STRING(31)
MenuWindow           WINDOW('Pavadzîmes'),AT(,,380,272),CENTER,IMM,GRAY,MDI
                       OPTION('&Mûsu Banka'),AT(6,0,365,54),USE(MB),BOXED
                         RADIO('1'),AT(11,10,156,10),USE(?MB:Radio1),HIDE,VALUE('1')
                         RADIO('2'),AT(11,18,156,10),USE(?MB:Radio2),HIDE,VALUE('2')
                         RADIO('3'),AT(11,26,156,10),USE(?MB:Radio3),HIDE,VALUE('3')
                         RADIO('4'),AT(11,34,156,10),USE(?MB:Radio4),HIDE,VALUE('4')
                         RADIO('5'),AT(11,42,156,10),USE(?MB:Radio5),HIDE,VALUE('5')
                         RADIO('6'),AT(175,10,149,10),USE(?MB:Radio6),HIDE,VALUE('6')
                         RADIO('7'),AT(175,18,149,10),USE(?MB:Radio7),HIDE,VALUE('7')
                         RADIO('8'),AT(175,26,149,10),USE(?MB:Radio8),HIDE,VALUE('8')
                         RADIO('9'),AT(175,34,149,10),USE(?MB:Radio9),HIDE,VALUE('9')
                         RADIO('10'),AT(175,42,149,10),USE(?MB:Radio10),HIDE,VALUE('10')
                       END
                       OPTION('&Partnera Banka'),AT(6,54,366,21),USE(PB),BOXED
                         RADIO('1'),AT(11,63,156,10),USE(?PB:Radio1),HIDE,VALUE('1')
                         RADIO('2'),AT(175,63,149,10),USE(?PB:Radio2),HIDE,VALUE('2')
                       END
                       OPTION('I&zdrukas formas izvçle'),AT(6,74,366,139),USE(PZTIPS),BOXED
                         RADIO('&1-Numurçtâ Pavadzîme'),AT(10,82),USE(?PZTIPS:Radio1),FONT(,10,,)
                         RADIO('&2-Numurçtâ P/Z 2 rindas'),AT(10,91),USE(?PZTIPS:Radio2),FONT(,10,,)
                         RADIO('&3-Numurçtâ P/Z (cena ar PVN)'),AT(10,100),USE(?PZTIPS:Radio3),FONT(,10,,)
                         RADIO('&4-Numurçtâ P/Z ar garo nosaukumu'),AT(10,110),USE(?PZTIPS:Radio4),FONT(,10,,)
                         RADIO('&5-Numurçtâ P/Z ar atlaides %'),AT(10,120),USE(?PZTIPS:Radio5:2)
                         RADIO('&6-Numurçtâ P/Z ar atlaides % 2 rindas'),AT(10,129),USE(?PZTIPS:Radio6),DISABLE,FONT(,10,,)
                         RADIO('&7-Iekðçjâ Pavadzîme'),AT(10,138),USE(?PZTIPS:Radio7:2),FONT(,10,,)
                         RADIO('&8-Iekðçjâ Pavadzîme 2 rindas'),AT(10,148),USE(?PZTIPS:Radio8:2),FONT(,10,,)
                         RADIO('&9-Numurçtâ P/Z (MATRIX)'),AT(10,157),USE(?PZTIPS:Radio9:2),FONT(,10,,)
                         RADIO('&0-Iekðçjâ P/Z (MATRIX)'),AT(10,166),USE(?PZTIPS:Radio0),FONT(,10,,)
                         RADIO('&A-Alkohola Pavadzîme'),AT(10,175),USE(?PZTIPS:RadioA)
                         RADIO('&C-Kokmateriâlu transporta P/Z'),AT(10,184),USE(?PZTIPS:RadioC:2)
                         RADIO('&D-Kokmateriâlu transporta P/Z vairumtirgotâjiem'),AT(9,194,166,10),USE(?PZTIPS:RadioD:2)
                         RADIO('&E-Degvielas P/Z'),AT(178,79),USE(?PZTIPS:RadioE:2)
                         RADIO('&F-Norakstîðanas Akts'),AT(178,89),USE(?PZTIPS:RadioF:2)
                         RADIO('&G-Invoice'),AT(178,98),USE(?PZTIPS:RadioG)
                         RADIO('&H-Pilnvara'),AT(178,108),USE(?PZTIPS:RadioH)
                         RADIO('&I-Packing List'),AT(178,117),USE(?PZTIPS:RadioI)
                         RADIO('&J-Rçíins kokmateriâliem vairumâ'),AT(178,126),USE(?PZTIPS:RadioJ)
                         RADIO('&K-Rçíins-faktûra'),AT(178,136),USE(?PZTIPS:RadioK),FONT(,10,,)
                         RADIO('&L-K/O'),AT(178,146),USE(?PZTIPS:RadioL),FONT(,10,,)
                         RADIO('&V-Servisa Pieòemðanas Akts(+teksts no SEVISS1.TXT)'),AT(178,155),USE(?PZTIPS:RadioV)
                         RADIO('&W-Servisa Nodoðanas Akts (+teksts no SERVISS.TXT)'),AT(178,165,192,10),USE(?PZTIPS:RadioW)
                         RADIO('&M-Servisa Defektâcijas Akts'),AT(178,174),USE(?PZTIPS:RadioM),FONT(,10,,)
                         RADIO('&N-Debeta Projekta izvçrsums'),AT(178,183),USE(?PZTIPS:RadioN)
                         RADIO('&X-Atbilstîbas deklarâcija'),AT(178,193),USE(?PZTIPS:RadioX)
                         RADIO('&P-Numurçtâ Pavadzîme (cenas pçc noklusçjuma)'),AT(9,202,168,10),USE(?PZTIPS:RadioP),FONT(,10,,)
                         RADIO('&6'),AT(349,202),USE(?PZTIPS:HIDE2),DISABLE,HIDE,FONT(,10,,)
                       END
                       OPTION('&Kontçjumu'),AT(6,213,57,21),USE(F:KONTI),BOXED
                         RADIO('Drukât'),AT(8,221,31,10),USE(?F:KONTI:Radio1)
                         RADIO('Nç'),AT(41,221,20,10),USE(?F:KONTI:Radio2)
                       END
                       OPTION('&Noapaïot cenu'),AT(7,234,55,36),USE(F:NOA),BOXED
                         RADIO('Nç'),AT(10,242,25,10),USE(?F:NOA:N),VALUE('N')
                         RADIO('Jâ (2 zîmes)'),AT(10,250,48,10),USE(?F:NOA:Y),VALUE('J')
                         RADIO('Jâ (3 zîmes)'),AT(10,259,48,10),USE(?F:NOA:Y:2),VALUE('3')
                       END
                       OPTION('P&Z drukât kâ'),AT(65,213,55,21),USE(F:IDP),BOXED
                         RADIO('SUP'),AT(68,221,25,10),USE(?F:IDP:1),VALUE('S')
                         RADIO('A4'),AT(93,221,20,10),USE(?F:IDP:2),VALUE('A')
                       END
                       OPTION('&Paraksts'),AT(124,213,48,56),USE(SYS_PARAKSTS_NR),BOXED
                         RADIO('Tukðs'),AT(127,221,32,10),USE(?SYS_PARAKSTS_NR:RADIO:1),VALUE('0')
                         RADIO('1.Paraksts'),AT(127,230,44,10),USE(?SYS_PARAKSTS_NR:RADIO:2),VALUE('1')
                         RADIO('2.Paraksts'),AT(127,239,44,10),USE(?SYS_PARAKSTS_NR:RADIO:3),VALUE('2')
                         RADIO('3.Paraksts'),AT(127,249,44,10),USE(?SYS_PARAKSTS_NR:RADIO:4),VALUE('3')
                         RADIO('Login'),AT(127,258,44,10),USE(?SYS_PARAKSTS_NR:RADIO:5),VALUE('4')
                       END
                       BUTTON('Mainît (izveidot)  PPR*.TXT'),AT(175,215,123,14),USE(?ButtonCtxt)
                       BUTTON('Nedrukât PPR.TXT'),AT(175,229,123,14),USE(?ButtonPtxt)
                       BUTTON('D&rukas parametri'),AT(300,233,78,14),USE(?ButtonDRUKA),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       BUTTON('EUR pârrçíins'),AT(175,244,94,14),USE(?ButtonEUR)
                       IMAGE('CHECK2.ICO'),AT(272,243,15,18),USE(?Image_EUR_P),HIDE
                       BUTTON('&OK'),AT(300,253,38,14),USE(?OK),DEFAULT
                       BUTTON('&Beigt'),AT(339,253,39,14),USE(?CancelButton)
                     END
KON_VAL         STRING(5)
EXTENSION       CSTRING(30)

DOSFILES     QUEUE,PRE(A)
NAME            STRING(13)
DATE            LONG
TIME            LONG
SIZE            LONG
ATTRIB          BYTE
             .
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
  PZTIPS = '1-Numurçtâ Pavadzîme'
  F:KONTI='D'  !DRUKÂT KONTÇJUMU
  IF ~BAND(SYS:BAITS1,00001000B)
     F:IDP='S' !DRUKÂT SUP
  ELSE
     F:IDP='A' !A4
  .
  IF BAND(SYS:BAITS1,00100000B)
     F:NOA='J' !NOAPAÏOT CENU 2 ZÎMES
  ELSIF BAND(SYS:BAITS1,01000000B)
     F:NOA='3' !NOAPAÏOT CENU 3 ZÎMES
  ELSE
     F:NOA='N'
  .
  MB=SYS:NOKL_B
  PB=SYS:NOKL_PB
  F:DTK=''
  !Elya 28.08.2013 <
  IF PAV:DATUMS >= date(10,01,2013) AND PAV:DATUMS < date(07,01,2014)
     EUR_P = 1
  .
  !Elya 28.08.2013 >
  IF EUR_P  !PÂRRÇÍINS uz EUR
     UNHIDE(?IMAGE_EUR_P)
  .
  !Elya 27.08.2013 <
  IF PAV:DATUMS >= date(01,01,2014)
     IF ~PAV:VAL='EUR'    ! VALÛTAS P/Z PARÂDAM Ls
        ?ButtonEUR{Prop:Text}='EUR pârrçíins'
     ELSE
        ?ButtonEUR{Prop:Text}='LVL pârrçíins'
     .
  ELSE
     IF ~(PAV:VAL='Ls' OR PAV:VAL='LVL')     ! VALÛTAS P/Z PARÂDAM Ls
        ?ButtonEUR{Prop:Text}='LVL pârrçíins'
     ELSE
        ?ButtonEUR{Prop:Text}='EUR pârrçíins'
     .
  .
  !Elya 27.08.2013 >
  
  IF AU_BILDE::USED         !TIEK SAUKTS NO PLÂNOTÂJA
     HIDE(?MB,?PB)
     HIDE(?PZTIPS:RADIO1,?PZTIPS:RadioL)
     HIDE(?PZTIPS:RadioM,?PZTIPS:RadioX)
     HIDE(?F:KONTI,?F:IDP)
     HIDE(?ButtonCtxt,?ButtonPtxt)
     PZTIPS='V'
  ELSE                      !NO BROWSEPAVAD
     LOOP I#=1 TO 10
        IF GL:BKODS[I#]
           BAN_NOS_P=GETBANKAS_K(GL:BKODS[I#],0,1)
           KON_VAL=GETKON_K(GL:BKK[I#],0,5)
           IF KON_VAL THEN KON_VAL=CLIP(KON_VAL)&': '.
           EXECUTE I#
             ?MB:Radio1{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio2{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio3{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio4{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio5{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio6{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio7{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio8{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio9{Prop:Text}=KON_VAL&BAN_NOS_P
             ?MB:Radio10{Prop:Text}=KON_VAL&BAN_NOS_P
           .
           EXECUTE I#
              UNHIDE(?MB:Radio1)
              UNHIDE(?MB:Radio2)
              UNHIDE(?MB:Radio3)
              UNHIDE(?MB:Radio4)
              UNHIDE(?MB:Radio5)
              UNHIDE(?MB:Radio6)
              UNHIDE(?MB:Radio7)
              UNHIDE(?MB:Radio8)
              UNHIDE(?MB:Radio9)
              UNHIDE(?MB:Radio10)
           END
        .
     .
     C#=GETPAR_K(PAV:PAR_NR,2,12)
     IF PAR:BAN_KODS
        ?PB:Radio1{Prop:Text}=Getbankas_k(PAR:BAN_KODS,0,1)
        UNHIDE(?PB:Radio1)
     .
     IF PAR:BAN_KODS2
        ?PB:Radio2{Prop:Text}=Getbankas_k(PAR:BAN_KODS2,0,1)
        UNHIDE(?PB:Radio2)
     .
  .
  
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?MB:Radio1)
      SELECT(?PZTIPS)
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
    OF ?ButtonCtxt
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
              DIRECTORY(DOSFILES,'PPR*.TXT',FF_:NORMAL)
              IF RECORDS(DOSFILES)= 0
                 RUN('WORDPAD')
                 IF RUNCODE()=-4
                    KLUDA(88,'prog-a WordPad.exe')
                 .
              ELSE
                 TTAKA"=PATH()
                 ANSIFILENAME=''
                 EXTENSION='TXT|PPR*.TXT'
                 IF ~FILEDIALOG('...TIKAI PPR*.TXT FAILI !!!',ANSIFILENAME,EXTENSION,2)  !2-NEDRÎKST MAINÎT FOLDERI
                    RUN('WORDPAD')
                    IF RUNCODE()=-4
                       KLUDA(88,'prog-a WordPad.exe')
                    .
                 ELSE
                    RUN('WORDPAD '&CLIP(ANSIFILENAME))
                    IF RUNCODE()=-4
                       KLUDA(88,'prog-a WordPad.exe')
                    .
                 .
                 SETPATH(TTAKA")
              .
              FREE(DOSFILES)
      END
    OF ?ButtonPtxt
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK=''
           ?ButtonPtxt{PROP:TEXT}='Nedrukât PPR.TXT'
        ELSE
           CALLWORDPAD#=FALSE
           LOOP
              DIRECTORY(DOSFILES,'PPR*.TXT',FF_:NORMAL)
              IF RECORDS(DOSFILES)= 0
                 IF CALLWORDPAD#=FALSE
                    KLUDA(120,'Neviens PPR*.txt fails',8,1)
                    IF KLU_DARBIBA
        !               ANSIFILENAME='PPR1.TXT'
        !               CHECKOPEN(OUTFILEANSI,1)
        !               CLOSE(OUTFILEANSI)
                       CALLWORDPAD#=TRUE
                       RUN('WORDPAD')
                       IF RUNCODE()=-4
                          KLUDA(88,'prog-a WordPad.exe')
                       ELSE
                          CYCLE
                       .
                    .
                 .
                 F:DTK=''
                 ?ButtonPtxt{PROP:TEXT}='Nedrukât PPR.TXT'
              ELSIF RECORDS(DOSFILES)= 1
                 F:DTK='1'
                 ANSIFILENAME=A:NAME
                 ?ButtonPtxt{PROP:TEXT}=CLIP(ANSIFILENAME)
              ELSE
                 TTAKA"=PATH()
                 ANSIFILENAME=''
                 EXTENSION='TXT|PPR*.TXT'
                 IF ~FILEDIALOG('...TIKAI PPR*.TXT FAILI !!!',ANSIFILENAME,EXTENSION,2)  !2-NEDRÎKST MAINÎT FOLDERI
                    F:DTK=''
                    ?ButtonPtxt{PROP:TEXT}='Nedrukât PPR.TXT'
                 ELSE
                    F:DTK='1'
                    ?ButtonPtxt{PROP:TEXT}=CLIP(ANSIFILENAME)
                 .
                 SETPATH(TTAKA")
              .
              FREE(DOSFILES)
              BREAK
           .
        .
        DISPLAY
      END
    OF ?ButtonDRUKA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?ButtonEUR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF EUR_P
           EUR_P=0
           HIDE(?IMAGE_EUR_P)
        ELSE
           EUR_P=1
           UNHIDE(?IMAGE_EUR_P)
        .
        DISPLAY
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          NOKL_B=MB  !SAGLABÂJAM MÛSU IZVÇLÇTO BANKU TÂLÂKIEM RÇÍINIEM
          F:PAK =PB  !SAGLABÂJAM PARTNERA BANKU NÂKOÐAI P/Z
          CASE PZTIPS
          OF '1' !-Numurçtâ Pavadzîme'
            OPCIJA_NR=1
            SPZ_PAVAD
          OF 'P' !-Numurçtâ Pavadzîme'
            OPCIJA_NR=12
            !STOP('12')
            SPZ_PAVAD
          OF '2' !-Numurçtâ P/Z 2 rindas'
            OPCIJA_NR=3
            SPZ_PAVAD
          OF '3' !-Numurçtâ P/Z (cena ar PVN)'
            OPCIJA_NR=4
            SPZ_PAVAD
          OF '4' !-Numurçtâ P/Z ar garo nosaukumu'
            OPCIJA_NR=5
            SPZ_PAVAD
          OF '5' !-Numurçtâ P/Z ar atlaides %'
            OPCIJA_NR=2
            SPZ_PAVAD
          OF '6' !-Numurçtâ P/Z ar atlaides % 2 RINDAS'
        !    OPCIJA_NR=7
        !    SPZ_PAVAD
          OF '7' !-Iekðçjâ Pavadzîme'
        !    SPZ_PAVADI
            OPCIJA_NR=10
            SPZ_PAVAD
          OF '8' !-Iekðçjâ Pavadzîme 2 rindas'
        !    SPZ_PAVADI2
            OPCIJA_NR=11
            SPZ_PAVAD
          OF '9' !-Numurçtâ P/Z (ANSI:TXT)'
            SPZ_PAVAD_OEM
          OF '0' !-Iekðçjâ P/Z (ANSI:TXT)'
            SPZ_PAVADI_OEM
          OF 'A' !-Alkohola Pavadzîme'
            SPZ_PAVADA
          OF 'C' !-Kokmateriâlu transporta P/Z'
        !    SPZ_PAVADK
            OPCIJA_NR=7
            SPZ_PAVAD
          OF 'D' !-Kokmateriâlu transporta P/Z vairumtirgotâjiem'
        !    SPZ_PAVADKV
            OPCIJA_NR=8
            SPZ_PAVAD
          OF 'E' !-Degvielas P/Z'
            SPZ_PAVADD
          OF 'F' !-Norakstîðanas Akts'
            SPZ_AKTS
          OF 'G' !-Invoice'
            SPZ_INVOICE
          OF 'H' !-Pilnvara'
            SPZ_PILNVARA
          OF 'I' !-Packing List'
            OPCIJA='000000040000004000000'
           !        123456789012345678901
            IZZFILTN
            IF GlobalResponse = RequestCompleted
               PAV::U_NR=PAV:U_NR          !PÇC START( JÂREPOZICIONÇ PAVAD
               START(SPZ_PACKLISTS1,50000) !START DÇÏ excel
            .
          OF 'J' !-Rçíins-faktûra KOKMATERIÂLIEM VAIRUMÂ'
            IF ~PAV:REK_NR
               PAV:REK_NR=PERFORMGL(5)   !PIEÐÍIRAM RÇÍINA NR
               IF RIUPDATE:PAVAD()
                  KLUDA(24,'PAVAD')
               .
            .
            OPCIJA_NR=9
            SPZ_PAVAD
          OF 'K' !-Rçíins-faktûra'
            IF ~PAV:REK_NR
               PAV:REK_NR=PERFORMGL(5)   !PIEÐÍIRAM RÇÍINA NR
               IF RIUPDATE:PAVAD()
                  KLUDA(24,'PAVAD')
               .
            .
        !    SPZ_Rekins
            OPCIJA_NR=6
            SPZ_PAVAD
          OF 'L' !-K/O'
            BEGIN
              IF PAV:D_K='K'
                 IF ~PAV:KIE_NR
                    PAV:KIE_NR=PERFORMGL(2)   !PIEÐÍIRAM IEN ORD NR
                 .
              ELSIF PAV:D_K='D'
                 IF ~PAV:KIE_NR
                    PAV:KIE_NR=PERFORMGL(3)   !PIEÐÍIRAM IZD ORD NR
                 .
              ELSE
                 KLUDA(104,' D vai K')
              .
              SPZ_KO                          !RIUPDATE IR ÐEIT
            .
          OF 'V' !-Servisa Pieòemðanas Akts'
            SPZ_ServApgLapa('001')
          OF 'W' !-Servisa Nodoðanas Akts'
            SPZ_ServApgLapa('101')
          OF 'M' !-Servisa Defektâcijas Akts'
            SPZ_DefektacijasAkts('')
          OF 'N' !-Debeta Projekta izvçrsums'
            SPZ_DProjIzv
          OF 'X' !-Atbilstîbas deklarâcija
            SPZ_AtbDekl
          ELSE
            stop('?:'&PZTIPS)
          END
          DO ProcedureReturn
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        break
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
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(MenuWindow)
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    CLOSE(MenuWindow)
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
  IF MenuWindow{Prop:AcceptAll} THEN EXIT.
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
