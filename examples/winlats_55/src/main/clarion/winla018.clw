                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTN PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
par_filtrs           STRING(1)
SAV_PAR_FILTRS       STRING(1)
PAR_TEX              STRING(5)
ATL_TEX              STRING(15)
ADRESEF              STRING(40)
window               WINDOW('Filtrs '),AT(,,305,255),GRAY,MDI
                       OPTION('&Debets (D-projekts)'),AT(3,8,72,36),USE(d_k),BOXED,HIDE
                         RADIO('D (Ienâcis)'),AT(5,18,59,10),USE(?DK:Radio1)
                         RADIO('1 (Pasûtîjumi)'),AT(5,27,61,10),USE(?DK:Radio2)
                       END
                       OPTION('&Kredîts (K-projekts)'),AT(84,7,76,38),USE(D_K1),BOXED,HIDE
                         RADIO('K (Izgâjis)'),AT(86,16,46,10),USE(?D_K1:Radio1)
                         RADIO('P (Pasûtîjumi)'),AT(86,25,57,10),USE(?D_K1:Radio2)
                         RADIO('R (pre-Pasûtîjumi)'),AT(86,34,70,10),USE(?D_K1:Radio3)
                       END
                       OPTION('&Raksta statuss'),AT(224,5,69,40),USE(RS),BOXED,HIDE
                         RADIO('Apstiprinâtie'),AT(227,13),USE(?RC:Radio1)
                         RADIO('Visi'),AT(227,22,23,10),USE(?RC:Radio2)
                         RADIO('Neapstiprinâtie'),AT(227,32,58,8),USE(?RC:Radio3)
                       END
                       STRING('Sastâdît izziòu'),AT(7,132,49,10),USE(?SastIzzinu1),HIDE
                       PROMPT('&No'),AT(59,132,9,10),USE(?Prompt:NO),HIDE
                       SPIN(@D06.B),AT(76,130,49,12),USE(S_DAT),HIDE
                       STRING('Sastâdît izziòu'),AT(7,145),USE(?SastIzzinu2),HIDE
                       PROMPT('&Lîdz'),AT(59,145,15,10),USE(?Prompt:LIDZ),HIDE
                       SPIN(@D06.B),AT(76,144,49,12),USE(B_DAT),HIDE
                       BUTTON('&Nomenklatûras Tips'),AT(7,88,79,16),USE(?SelNOMTips),HIDE
                       STRING(@s7),AT(91,91,31,9),USE(NOM_TIPS7),HIDE
                       OPTION('Filtrs pçc darîjuma &partnera'),AT(129,45,168,46),USE(par_filtrs),BOXED,HIDE
                         RADIO('Visi'),AT(133,56,23,9),USE(?PAR_FI:Radio1),VALUE('V')
                         RADIO('Konkrçts'),AT(133,68,38,9),USE(?PAR_FI:Radio2),VALUE('K')
                       END
                       STRING('tips:'),AT(157,55),USE(?PromptTips),HIDE
                       STRING(@s6),AT(173,56,,9),USE(PAR_TIPS),HIDE
                       BUTTON('&Mainît'),AT(201,54,33,12),USE(?SelParTips),HIDE
                       STRING('grupa:'),AT(236,55),USE(?PromptGrupa),HIDE
                       STRING('1234567'),AT(261,65,34,10),USE(?STRING1234567),HIDE,FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                       ENTRY(@s7),AT(259,54,34,10),USE(PAR_GRUPA),HIDE,FONT('Fixedsys',,,,CHARSET:BALTIC),OVR,UPR
                       STRING(@s15),AT(173,69,62,9),USE(PAR:NOS_S),HIDE
                       BUTTON('Adrese'),AT(132,77,34,12),USE(?Adrese),HIDE
                       ENTRY(@s21),AT(10,68,90,10),USE(NOMENKLAT),HIDE,FONT('Fixedsys',9,,FONT:regular),UPR
                       STRING('123456789012345678901'),AT(12,79,86,10),USE(?NOM_FILTRS),HIDE,FONT('Fixedsys',9,COLOR:Gray,FONT:regular)
                       STRING(@s35),AT(168,79,128,9),USE(ADRESEF),HIDE
                       BUTTON('&Grupa'),AT(7,54,28,11),USE(?Bgrupa),HIDE
                       BUTTON('Apakðgr&upa'),AT(37,54,44,11),USE(?BAgrupa),HIDE
                       BUTTON('Raþotâ&js'),AT(82,54,38,11),USE(?Braz),HIDE
                       PROMPT('&Cena (1-6 Prece/Pakalp.) :'),AT(7,105,83,9),USE(?Prompt:NOKL_CP),HIDE,RIGHT
                       ENTRY(@n1),AT(92,105,14,9),USE(NOKL_CP),HIDE,REQ
                       ENTRY(@n1),AT(108,105,14,9),USE(NOKL_CA),HIDE,REQ
                       PROMPT('pret PIC'),AT(7,116,79,9),USE(?Prompt:NOKL_CP1),HIDE,RIGHT
                       ENTRY(@n1),AT(92,116,14,9),USE(NOKL_C1),HIDE,REQ
                       OPTION('F:&Secîba'),AT(144,91,131,37),USE(F:SECIBA),BOXED,HIDE
                         RADIO('Nomenklatûru'),AT(154,99,57,10),USE(?F:seciba:Radio1)
                         RADIO('Datumu'),AT(213,99),USE(?F:seciba:Radio4),DISABLE
                         RADIO('Kodu'),AT(154,108),USE(?F:seciba:Radio2)
                         RADIO('Ievadîðanas'),AT(213,109),USE(?F:seciba:Radio5),DISABLE,VALUE('I')
                         RADIO('Alfabçta'),AT(154,117),USE(?F:SECIBA:Radio3)
                       END
                       OPTION('Nomenkla&tûra'),AT(4,45,121,82),USE(?Nomen),BOXED,HIDE
                       END
                       BUTTON('&1-Drukât tikai kopsummas'),AT(5,178,128,16),USE(?F:DTK),HIDE,LEFT
                       IMAGE('CHECK3.ICO'),AT(135,178,16,16),USE(?IMAGE:DTK),HIDE
                       BUTTON('&2-Mainît F pçc atlikumiem'),AT(5,195,101,16),USE(?F:ATL),HIDE,LEFT
                       STRING(@s15),AT(107,198,66,10),USE(ATL_TEX),LEFT(1)
                       BUTTON('&7-Projekts (Objekts)'),AT(154,165,94,16),USE(?Projekts),HIDE,LEFT
                       BUTTON('&3-Tikai, kam cena ir > 0'),AT(5,212,101,16),USE(?F:CEN),HIDE,LEFT
                       IMAGE('CHECK3.ICO'),AT(108,212,16,16),USE(?IMAGE:CEN),HIDE
                       BUTTON('&8-Nodaïa'),AT(155,182,94,16),USE(?Nodala),HIDE,LEFT
                       ENTRY(@S2),AT(252,184,16,11),USE(F:NODALA),HIDE
                       BUTTON('&9-DunN'),AT(176,199,31,16),USE(?ButtonDiena),HIDE
                       BUTTON('D&rukas parametri'),AT(209,209,85,16),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       ENTRY(@n_6b),AT(252,168,35,11),USE(F:OBJ_NR),HIDE
                       BUTTON('&4-Tikai, kam ir reâli atlikumi'),AT(5,230,101,16),USE(?F:KRI),HIDE
                       IMAGE('CHECK3.ICO'),AT(108,230,16,16),USE(?IMAGE:KRI),HIDE
                       OPTION('Izdrukas &Formâts'),AT(10,157,115,19),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(15,165,29,10),USE(?F:DBF:Radio1),VALUE('W')
                         RADIO('Word'),AT(50,165,30,10),USE(?F:DBF:Radio2),VALUE('A')
                         RADIO('Excel'),AT(86,165),USE(?F:DBF:Radio3),VALUE('E')
                       END
                       BUTTON('&5-Iekïaut pakalpojumus'),AT(154,131,114,16),USE(?F:PAK),HIDE,LEFT
                       IMAGE('CHECK3.ICO'),AT(270,131,16,16),USE(?IMAGE:PAK),HIDE
                       BUTTON('&6-Tikai, kas jâsûta uz KA'),AT(154,148,114,16),USE(?F:IDP),HIDE,LEFT
                       IMAGE('CHECK3.ICO'),AT(270,148,16,16),USE(?IMAGE:IDP),HIDE
                       BUTTON('&OK'),AT(209,227,46,13),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(257,227,36,13),USE(?CancelButton)
                     END
SAV_NOKL_CP LIKE(NOKL_CP)
SAV_NOKL_CA LIKE(NOKL_CA)
PAR_NOS_S   like(PAR:NOS_S)

A_window WINDOW('Filtrs pçc atlikumiem'),AT(,,133,67),GRAY
       CHECK('Iekïaut tos, kam ir atlikumi (irA)'),AT(13,12),USE(F:ATL[1]),VALUE('1','0')
       CHECK('Iekïaut 0_es atlikumus (0A)'),AT(13,22),USE(F:ATL[2]),VALUE('1','0')
       CHECK('Iekïaut negatîvus atlikumus (-A)'),AT(13,32),USE(F:ATL[3]),VALUE('1','0')
       BUTTON('OK'),AT(3,51,35,14),USE(?OkA),DEFAULT
       BUTTON('Atstât noklusçto vçrtîbu'),AT(42,51,88,14),USE(?CancelA)
     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  RS        ='Apstiprinâtie'
  D_K1      =''
  IF ~PAR_TIPS  THEN PAR_TIPS  ='EFCNIR'.
  !PAR_GRUPA = ''
  IF ~NOM_TIPS7 THEN NOM_TIPS7 ='PTAKRIV'.
  F:SECIBA  ='Nomenklatûru'
  F:OBJ_NR  =0
  F:NODALA  =''
  F:DTK     =''
  F:CEN     =''
  F:DIENA   =''
  IF ~F:ATL THEN F:ATL='111'.
  IF ~F:DBF THEN F:DBF='W'.
  IF ~NOKL_CP THEN NOKL_CP=1.
  IF ~NOKL_CA THEN NOKL_CA=1.
  SAV_NOKL_CP=NOKL_CP
  SAV_NOKL_CA=NOKL_CA
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  LOOP I#=1 TO 22       !MAX=30
     IF INSTRING(OPCIJA[I#],'123456789')
        EXECUTE I#
           BEGIN
              UNHIDE(?D_K)               !  1
              IF ~INSTRING(D_K,'1D')
                 D_K='D'
              .
              IF OPCIJA[I#]='2'
                 ?D_K{PROP:TEXT}=' P/Z'
                 ?DK:Radio1{PROP:TEXT}='D (Ienâkoðâ)'
                 ?DK:Radio2{PROP:TEXT}='K (Izejoðâ)'
              .
           .
           BEGIN
              UNHIDE(?D_K1)              !  2
              IF ~INSTRING(D_K,'KP')
                 D_K1='K'
              ELSE
                 D_K1=D_K
              .
           .
           BEGIN                         !  3
              UNHIDE(?S_DAT)
              UNHIDE(?PROMPT:NO)
              IF OPCIJA[I#]='1'
                 UNHIDE(?SASTIZZINU1)
              .
           .
           BEGIN
              UNHIDE(?B_DAT)             !  4
              UNHIDE(?PROMPT:LIDZ)
              IF OPCIJA[I#-1]='0'
                 UNHIDE(?SASTIZZINU2)
              .
              IF OPCIJA[I#]='2'
                 ?Prompt:LIDZ{PROP:TEXT}='&Uz'
              .
              IF OPCIJA[I#]='3'
                 ?SASTIZZINU2{PROP:TEXT}='Sastâdît P/Z'
                 ?Prompt:LIDZ{PROP:TEXT}='&Uz'
              .
           .
           BEGIN
              UNHIDE(?PAR_FILTRS)       !  5
              UNHIDE(?PromptTips)
              UNHIDE(?PAR_TIPS)
              UNHIDE(?PromptGrupa)
              UNHIDE(?PAR_GRUPA)
              UNHIDE(?STRING1234567)
              UNHIDE(?SelParTips)
              IF OPCIJA[I#]='2'         ! KONKRÇTS
                 PAR_FILTRS='K'
                 HIDE(?PAR_GRUPA)
                 HIDE(?STRING1234567)
                 HIDE(?PAR_FI:RADIO1)
                 HIDE(?PromptTips)
                 HIDE(?PAR_TIPS)
                 HIDE(?PromptGrupa)
                 HIDE(?SelParTips)
              ELSIF OPCIJA[I#]='3'      ! VISI VAI KONKRÇTS
                 PAR_FILTRS='V'
                 PAR_NR=999999999
                 HIDE(?PAR_GRUPA)
                 HIDE(?STRING1234567)
                 HIDE(?PromptTips)
                 HIDE(?PAR_TIPS)
                 HIDE(?PromptGrupa)
                 HIDE(?SelParTips)
              ELSIF PAR_NR AND ~(PAR_NR=999999999)
                 IF GETPAR_K(PAR_NR,0,1)
                    UNHIDE(?PAR:NOS_S)
                    PAR_FILTRS='K'
                    SAV_PAR_FILTRS=PAR_FILTRS
                    IF OPCIJA[20]='1'
                       UNHIDE(?ADRESE)
                       UNHIDE(?ADRESEF)
                    .
                 ELSE
                    PAR_NR=999999999
                    PAR_FILTRS = 'V'
                    SAV_PAR_FILTRS=PAR_FILTRS
                 .
              ELSE
                 PAR_NR=999999999
                 PAR_FILTRS = 'V'
                 SAV_PAR_FILTRS=PAR_FILTRS
              .
           END
           BEGIN                         !  6
              IF OPCIJA[I#]='1'          !
                 UNHIDE(?NOMEN)
                 UNHIDE(?NOMENKLAT)
                 UNHIDE(?NOM_FILTRS)
                 UNHIDE(?BGRUPA)
                 UNHIDE(?BAGRUPA)
                 UNHIDE(?BRAZ)
              ELSIF OPCIJA[I#]='2'        ! TIKAI F:PTAKRI
                 UNHIDE(?SelNOMTips)
                 UNHIDE(?NOM_Tips7)
              .
           .
           BEGIN                         !  7
  !            OMITED...
           .
           BEGIN                         !  8  
              IF OPCIJA[I#]='2'          ! WMF/WORD
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:RADIO3)
                 DISABLE(?F:DBF:RADIO3)
              ELSIF OPCIJA[I#]='3'       ! WMF/WORD/EXCEL
                 UNHIDE(?F:DBF)
              ELSIF OPCIJA[I#]='4'       ! WMF/EXCEL
                 UNHIDE(?F:DBF)
                 HIDE(?F:DBF:RADIO2)
                 DISABLE(?F:DBF:RADIO2)
              .
           .
           BEGIN                         !  9  Drukât tikai kopsummas/uzbûvçt P/Z/Bûvçt ar 0-es PVN/Drukât IP/SASP Ls/KAM IR KRIT/DKP
              UNHIDE(?F:DTK)
              IF F:DTK
                 UNHIDE(?IMAGE:DTK)
              .
              CASE OPCIJA[I#]
              OF '2'
                ?F:DTK{PROP:TEXT}='&Uzbûvçt P/Z' !?????????
              OF '3'
                ?F:DTK{PROP:TEXT}='&Bûvçt ar 0-es PVN'
              OF '4'
                ?F:DTK{PROP:TEXT}='&Drukât arî iekð. pârv.'
              OF '5'
                ?F:DTK{PROP:TEXT}='&Pârrçí. un Saspiest Ls'
              OF '6'
                ?F:DTK{PROP:TEXT}='&Tikai,kam kritiskais>0'
              OF '7'
                ?F:DTK{PROP:TEXT}='&Iekïaut arî projektus'
              OF '8'
                ?F:DTK{PROP:TEXT}='&Meklçt K PPR lîdz '&format(TODAY(),@d06.)
              OF '9'
                ?F:DTK{PROP:TEXT}='&Mainît Par_Atlaide sask.ar Winlats.ini'
              .
           .
           BEGIN                         !  10 Iekïaut +A 0A -A, pie opcijas[10]=4-CHECKBOX
              UNHIDE(?F:ATL)
              F:ATL='100'
              ATL_TEX='ir Atlikumi'
              IF OPCIJA[I#]='2'
                 ?F:ATL{PROP:TEXT}='&Mainît F pçc parâdiem'
                 ATL_TEX='ir Parâds'
              ELSIF OPCIJA[I#]='3'
                 ?F:ATL{PROP:TEXT}='&Mainît F pçc realizâc.'
                 ATL_TEX='ir Realizâc.'
              ELSIF OPCIJA[I#]='5'
                 F:ATL='010'
                 ATL_TEX='nav Atlikumu'
              .
           .
           BEGIN                         !  11 Tikai, kam cena > 0
              UNHIDE(?F:CEN)
              IF OPCIJA[I#]='2'
                 ?F:CEN{PROP:TEXT}='&Nedrukât iepirkuma cenu'
              ELSIF OPCIJA[I#]='3'
                 ?F:CEN{PROP:TEXT}='&Pârrçíinât un pârrakstît'
              .
           .
           BEGIN                         !  12 Iekïaut sarakstâ pakalpojumus/ANALIZÇT ARÎ K-Projektus
              UNHIDE(?F:PAK)
              IF F:PAK
                  UNHIDE(?IMAGE:PAK)
              .
              IF OPCIJA[I#]='2'
                 ?F:PAK{PROP:TEXT}='&5-analizçt arî K-Projektus'
              .
           .
           BEGIN                         !  13 Tikai, kam ir reâli atlikumi/APGROZÎJUMS/JÂPASÛTA
              UNHIDE(?F:KRI)
              IF F:KRI
                  UNHIDE(?IMAGE:KRI)
              .
              IF OPCIJA[I#]='2'
                 ?F:KRI{PROP:TEXT}='&Tikai, kam ir apgrozîjums'
              ELSIF OPCIJA[I#]='3'
                 ?F:KRI{PROP:TEXT}='&Tikai, kas ir jâpasûta'
              .
           .
           BEGIN                         !  14  Kas jâsûta uz KA
              UNHIDE(?F:IDP)
              F:IDP=''
              IF F:IDP
                  UNHIDE(?IMAGE:IDP)
              .
              IF OPCIJA[I#]='2'
                  ?F:IDP{Prop:Text}='&6-Uzbûvçt failu'      !
              ELSIF OPCIJA[I#]='3'
                  ?F:IDP{Prop:Text}='&6-Drukât tikai kïûdas'! Kopsavilkumi
              ELSIF OPCIJA[I#]='4'
                   ?F:IDP{Prop:Text}='&6-Uzbûvçt D-projektu'! Kritiskie atlikumi
              ELSIF OPCIJA[I#]='5'
                  ?F:IDP{Prop:Text}='&6-Uzbûvçt failu '&'I'&CLIP(LOC_NR)&FORMAT(TODAY(),@D11)&'.TPS' ! Inventarizâcijas aktam
                                               !INVNAME='I'&NOL&FORMAT(B_DAT,@D11)&'.TPS'
              .
           .
           BEGIN                         !  15  SECÎBA   Tikai pçc izvçlçtâs P/Z'
              UNHIDE(?F:SECIBA)          !  ATVÇRTI:Nom,Kodu,Alfab  DIS:Dat,Iev
              IF OPCIJA[I#]='2'
                 DISABLE(?F:seciba:Radio2)  !Kodu
                 DISABLE(?F:seciba:Radio3)  !Alfabçta
                 ENABLE(?F:seciba:Radio4)   !Datumu
              ELSIF OPCIJA[I#]='3'
                 DISABLE(?F:seciba:Radio2)  !Kodu
                 DISABLE(?F:seciba:Radio3)  !Alfabçta
                 ENABLE(?F:seciba:Radio5)   !Ievadîðanas
              ELSIF OPCIJA[I#]='4'
                 DISABLE(?F:seciba:Radio2)  !Kodu
              .
           .
           BEGIN                         !  16  Noklusçtâ cena(REALIZÂCIJA)/PIC
              UNHIDE(?NOKL_CP)
              UNHIDE(?NOKL_CA)
              UNHIDE(?PROMPT:NOKL_CP)
              IF OPCIJA[I#]='2'
                  NOKL_CP=0
                  NOKL_CA=0
                  ?Prompt:NOKL_CP{Prop:Text}='&Cena (0-6 Prece/Tara) :'  !0-P/Z kopsavilkumam
              ELSIF OPCIJA[I#]='3'       !REALIZÂCIJA/PIC(Y)
                  HIDE(?NOKL_CP)
                  HIDE(?NOKL_CA)
                  UNHIDE(?NOKL_C1)
                  NOKL_C1=6
                  UNHIDE(?PROMPT:NOKL_CP1)
                  ?Prompt:NOKL_CP{Prop:Text}='&Realizâcija'
                  ?Prompt:NOKL_CP1{Prop:Text}='pret PIC vai(1-6) :'
              ELSIF OPCIJA[I#]='4'            !X cena/PIC(Y) REALIZ.ANALÎZEI
                  UNHIDE(?PROMPT:NOKL_CP1)
                  ?Prompt:NOKL_CP1{Prop:Text}='pret PIC vai(1-6) :'
                  UNHIDE(?NOKL_C1)
                  NOKL_C1=6
              ELSIF OPCIJA[I#]='5'
                  HIDE(?NOKL_CA)
                  DISABLE(?NOKL_CA)
                  NOKL_CP=6
                  ?Prompt:NOKL_CP{Prop:Text}='&Cena (1-6 Prece) :'  !KRIT.ATL-TIKAI PRECE
              .
           .
           BEGIN                         !  17  Filtrs pçc Projekta
              UNHIDE(?Projekts)
              UNHIDE(?F:OBJ_NR)
           .
           BEGIN                         !  18  Filtrs pçc DIENA/NAKTS
              UNHIDE(?BUTTONDIENA)
           .
           BEGIN                         !  19  Filtrs NOM:TIPS
              UNHIDE(?SelNOMTips)
              UNHIDE(?NOM_Tips7)
           .
           BEGIN                         !  20  Filtrs ADR:ADRESE
              ADR_NR=999999999
           .
           BEGIN                         !  21  Filtrs pçc NODAÏAS
              UNHIDE(?NODALA)
              UNHIDE(?F:NODALA)
           .
           BEGIN                         !  22  1- VAR BÛT arî NEAPSTIPRINÂTIE
              IF (ATLAUTS[1]='1' OR ~(ATLAUTS[18]='1'))
                 UNHIDE(?RS)
              .
           .
        .
     .
  .
  ACCEPT
    IF ~(SAV_PAR_FILTRS=PAR_FILTRS)
       CASE PAR_FILTRS
       OF 'V'
           PAR_NR = 999999999
           HIDE(?PAR:NOS_S)
           HIDE(?ADRESE)
           HIDE(?ADRESEF)
           IF ~(OPCIJA[5]='3')
              UNHIDE(?SelParTipS)
              UNHIDE(?PAR_GRUPA)
              SELECT(?PAR_GRUPA)
           .
       OF 'K'
           UNHIDE(?PAR:NOS_S)
           HIDE(?PAR_GRUPA)
           HIDE(?SelParTipS)
           PAR_grupa=''
           PAR_TIPS=''
           GlobalRequest = SelectRecord
           BrowsePAR_K
           IF GlobalResponse = RequestCompleted
             PAR_NR=PAR:U_NR
             PAR_NOS_S=PAR:NOS_S
             IF OPCIJA[20]='1'
                UNHIDE(?ADRESE)
                UNHIDE(?ADRESEF)
             .
           ELSE
             PAR_NR=999999999
             PAR_NOS_S=''
           .
       .
       SAV_PAR_FILTRS = PAR_FILTRS
    .
    IF OPCIJA[11]='3' !PÂRRÇÍINÂT & PÂRRAKSTÎT NOM_A
       IF ~(B_DAT=TODAY() OR B_DAT=DB_B_DAT)
          HIDE(?F:CEN)
       ELSE
          UNHIDE(?F:CEN)
       .
    .
    
    
     
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?DK:Radio1)
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
    OF ?SelNOMTips
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SEL_NOM_TIPS
         DISPLAY(?NOM_TIPS7)
      END
    OF ?SelParTips
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SEL_PAR_TIPS5
         DISPLAY(?PAR_TIPS)
      END
    OF ?Adrese
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ADR_NR=999999999
        ADRESEF=GETPAR_ADRESE(PAR_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
        IF ADR_NR=999999999
           ADRESEF=''
        .
      END
    OF ?Bgrupa
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         GlobalRequest = SelectRecord             ! Set Action for Lookup
         BrowseGrupas                             ! Call the Lookup Procedure
         LocalResponse = GlobalResponse           ! Save Action for evaluation
         GlobalResponse = RequestCancelled        ! Clear Action
         IF LocalResponse = RequestCompleted      ! IF Lookup completed
           NOMENKLAT[1:3]=GR1:GRUPA1;DISPLAY      ! Source on Completion
         END                                      ! END (IF Lookup completed)
         LocalResponse = RequestCancelled
      END
    OF ?BAgrupa
      CASE EVENT()
      OF EVENT:Accepted
        IF ~getgrupa(NOMENKLAT[1:3],1,1)  !pozicionç grupas
           CYCLE
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        UpdateGrupa1 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOMENKLAT[4]=GR2:GRUPA2
        .
        DISPLAY
      END
    OF ?Braz
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           NOMENKLAT[19:21]=PAR:NOS_U
           DISPLAY
        .
      END
    OF ?F:DTK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK = ''
           HIDE(?IMAGE:DTK)
        ELSE
           F:DTK = '1'
           UNHIDE(?IMAGE:DTK)
        .
        DISPLAY           
      END
    OF ?F:ATL
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        !
        ! F:ATL:  1.BAITS - IEKLAUT,KAM IR +ATLIKUMI
        !         2.BAITS - IEKLAUT,KAM IR 0-ES ATLIKUMI
        !         3.BAITS - IEKLAUT,KAM IR -ATLIKUMI
        !
        
        IF OPCIJA[10]='4'  !preèu atlikumi noliktavâ
           OPEN(A_WINDOW)
           DISPLAY
           ACCEPT
              CASE FIELD()
              OF ?OKA
                 CASE EVENT()
                 OF EVENT:Accepted
                    IF F:ATL='000'
                       BEEP
                       CYCLE
                    ELSE
                       BREAK
                    .
                 .
              OF ?CANCELA
                 CASE EVENT()
                 OF EVENT:Accepted
                    F:ATL='100'
                    BREAK
                 .
              .
           .
           CLOSE(A_WINDOW)
           ATL_TEX=''
           LOOP A# = 1 TO 3
              IF F:ATL[A#]='1'
                 CASE A#
                 OF 1
                    ATL_TEX='+Atl'
                 OF 2
                    ATL_TEX=CLIP(ATL_TEX)&' 0Atl'
                 OF 3
                    ATL_TEX=CLIP(ATL_TEX)&' -Atl'
                 .
              .
           .
        ELSIF OPCIJA[10]='1'    !FILTRS 0-es ATLIKUMIEM
           IF F:ATL[2]='0'
              F:ATL[2]='1'
              ATL_TEX='ir A,0 Atl.'
           ELSE
              F:ATL[2]='0'
              ATL_TEX='ir Atlikumi'
           .
        ELSIF OPCIJA[10]='5'    !FILTRS 0-es ATLIKUMIEM
           IF F:ATL[1]='0' AND F:ATL[2]='1'
              F:ATL[1]='1'
              ATL_TEX='ir A,0 Atl.'
           ELSIF F:ATL[1]='1' AND F:ATL[2]='1'
              F:ATL[2]='0'
              ATL_TEX='ir Atlikumi'
           ELSE
              F:ATL[1]='0'
              F:ATL[2]='1'
              ATL_TEX='nav Atlikumu'
           .
        ELSIF OPCIJA[10]='2'    !FILTRS PÇC PARÂDU ATLIKUMIEM: 4-AS PÇCAPM/KONS FORMAS
           IF F:ATL[2]='0'
              F:ATL[2]='1'
              ATL_TEX='irP,0 Parâds'
           ELSE
              F:ATL[2]='0'
              ATL_TEX='ir Parâds'
           .
        ELSIF OPCIJA[10]='3'    !FILTRS PÇC REALIZÂCIJAS  ?????
           IF F:ATL[2]='0'
              F:ATL[2]='1'
              ATL_TEX='irR,0 Realiz'
           ELSE
              F:ATL[2]='0'
              ATL_TEX='ir Realizâc.'
           .
        .
        DISPLAY
      END
    OF ?Projekts
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if GlobalResponse=RequestCompleted
           F:OBJ_NR = PRO:U_NR
        .
        display
      END
    OF ?F:CEN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:CEN
           F:CEN = ''
           HIDE(?IMAGE:CEN)
        ELSE
           F:CEN = '1'
           UNHIDE(?IMAGE:CEN)
        END
        DISPLAY
      END
    OF ?Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if GlobalResponse=RequestCompleted
           F:NODALA = NOD:U_NR
        .
        display
      END
    OF ?ButtonDiena
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~F:DIENA
          F:DIENA='D'
          ?ButtonDiena{PROP:TEXT}='&8-Diena'
        ELSIF F:DIENA='D'
          F:DIENA='N'
          ?ButtonDiena{PROP:TEXT}='&8-Nakts'
        ELSE
          F:DIENA=''
          ?ButtonDiena{PROP:TEXT}='&8-Diena un Nakts'
        .
        DISPLAY
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?F:KRI
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:KRI
           F:KRI = ''
           HIDE(?IMAGE:KRI)
        ELSE
           F:KRI = '1'
           UNHIDE(?IMAGE:KRI)
        END
        DISPLAY
      END
    OF ?F:PAK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:PAK
           F:PAK = ''
           HIDE(?IMAGE:PAK)
        ELSE
           F:PAK = '1'
           UNHIDE(?IMAGE:PAK)
        END
        DISPLAY
      END
    OF ?F:IDP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:IDP
           F:IDP = ''
           HIDE(?IMAGE:IDP)
        ELSE
           F:IDP = '1'
           UNHIDE(?IMAGE:IDP)
        END
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        IF D_K1 THEN D_K=D_K1.
        IF OPCIJA[16]=2 !P/Z kopsavilkumam, CITUR PAGAIDÂM NOMAITÂ
           NOKL_C1=NOKL_CP
           NOKL_C2=NOKL_CA
           NOKL_CP=SAV_NOKL_CP
           NOKL_CA=SAV_NOKL_CA
        .
        SELECT(1)
        SELECT
        LocalResponse = RequestCompleted
        BREAK
        DO SyncWindow
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        BREAK
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IZZFILTN','winlats.INI')
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
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('IZZFILTN','winlats.INI')
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
BuildRekini          PROCEDURE                    ! Declare Procedure
DAT                 LONG
LAI                 LONG
VIRSRAKSTS          STRING(50)
STATUSS             STRING(1)
R_SUMMA             DECIMAL(7,2)
R_ATLAIDE           DECIMAL(7,2)
R_SATLAIDE          STRING(4)
ATZ_TEKSTS          STRING(70)
R_SUMMAK            DECIMAL(9,2)
R_ATLAIDEK          DECIMAL(7,2)
SAV_MENESU_SKAITS   BYTE
B_GADS              LONG
CET_NR              BYTE
PAR_L_SUMMA1        LIKE(PAR:L_SUMMA1)

R_TABLE         QUEUE,PRE(R)
DOK_SENR            STRING(14)
DATUMS              LONG
                .
!-----------------------------------------------------------------------------
Process:View         VIEW(PAR_K)
                       PROJECT(U_NR)
                       PROJECT(KARTE)
                       PROJECT(LIGUMS)
                       PROJECT(L_SUMMA)
                       PROJECT(ATZIME1)
                       PROJECT(ATZIME2)
                     END
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
Auto::Attempts       LONG
Auto::Save:GG:U_NR   LIKE(GG:U_NR)

!-----------------------------------------------------------------------------
report REPORT,AT(0,1235,8000,10000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(0,200,8000,1031),USE(?unnamed),FONT(,,,FONT:bold,CHARSET:ANSI)
         STRING(@s45),AT(1688,104,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7083,469),PAGENO,USE(?PageCount),RIGHT
         STRING(@s50),AT(1490,396,4760,229),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,729,7708,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(604,729,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(823,729,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(7865,729,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(1854,729,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(2542,729,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Karte'),AT(177,802,417,177),USE(?String4:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Klients'),AT(917,802,823,177),USE(?String4:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(1875,802,646,177),USE(?Summa),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3365,729,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Komentârs'),AT(3438,802,854,177),USE(?String4:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('t.s. atlaide'),AT(2563,802,792,177),USE(?Atlaide),TRN,CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('S'),AT(688,802,94,177),USE(?String17),TRN
         LINE,AT(156,1030,7708,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(156,729,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,146),USE(?unnamed:4)
         LINE,AT(156,0,0,167),USE(?Line8),COLOR(COLOR:Black)
         STRING(@N_4B),AT(250,10,292,146),USE(PAR:KARTE),RIGHT
         STRING(@S4),AT(2563,0,302,146),USE(R_SATLAIDE),TRN,RIGHT
         STRING(@N-7.2B),AT(2885,0,427,146),USE(R_ATLAIDE),TRN,RIGHT
         STRING(@s1),AT(635,0,156,146),USE(STATUSS),TRN,CENTER,FONT(,,,FONT:bold,CHARSET:ANSI)
         LINE,AT(604,0,0,167),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(823,0,0,167),USE(?Line8:3),COLOR(COLOR:Black)
         STRING(@s15),AT(854,0,958,146),USE(PAR:NOS_S),LEFT
         LINE,AT(1854,0,0,167),USE(?Line8:4),COLOR(COLOR:Black)
         STRING(@N-8.2B),AT(1948,0,542,146),USE(R_SUMMA),TRN,RIGHT
         LINE,AT(2542,0,0,167),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(3365,0,0,167),USE(?Line8:6),COLOR(COLOR:Black)
         STRING(@s70),AT(3396,0,4458,146),USE(ATZ_TEKSTS),LEFT
         LINE,AT(7865,0,0,167),USE(?Line8:5),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,385),USE(?unnamed:3)
         LINE,AT(156,0,7708,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(156,10,0,167),USE(?Line8:7),COLOR(COLOR:Black)
         STRING(@s80),AT(260,10,6365,146),USE(OUTA:LINE),TRN,LEFT
         LINE,AT(7865,10,0,167),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(156,177,7708,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(167,229),USE(?String18),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(625,229),USE(acc_kods),FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6854,229),USE(DAT,,?DATUMS:2),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7448,229),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(0,11200,8000,0)
         LINE,AT(156,,7708,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,62),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO

!window WINDOW('Papildus Filtrs'),AT(,,155,105),GRAY
!       OPTION('Sadaïa:'),AT(15,9,130,69),USE(F:SADALA),BOXED
!         RADIO('Visas'),AT(26,19,111,10),USE(?F:SADALA:Radio1),VALUE(' ')
!         RADIO('Bilance'),AT(26,29,111,10),USE(?F:SADALA:Radio2),VALUE('B')
!         RADIO('Peïòas/zaudçjumu aprçíins'),AT(26,39,111,10),USE(?F:SADALA:Radio3),VALUE('P')
!         RADIO('Naudas plûsmas pârskats'),AT(26,49,111,10),USE(?F:SADALA:Radio4),VALUE('N')
!         RADIO('Paðu kapitâla izmaiòu pârskats'),AT(26,59,111,10),USE(?F:SADALA:Radio5),VALUE('K')
!       END
!       BUTTON('&OK'),AT(70,81,35,14),USE(?OkButton),DEFAULT
!       BUTTON('&Atlikt'),AT(109,81,36,14),USE(?CancelButton)
!     END
  CODE                                            ! Begin processed code
  PUSHBIND
  SAV_MENESU_SKAITS=MENESU_SKAITS
!  MEN_NR=1-19
  MEN_NR=MONTH(S_DAT)
  UZBUVETI#=0
  IZLAISTI#=0
  VIRSRAKSTS='Pçcgarantijas rçíini '&MENESISunG
  dat=today()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CheckOpen(PAR_K,1)
  PAR_K::Used += 1
  IF RECORDS(PAR_K)=0
     KLUDA(0,'Nav atrodams(tukðs) fails '&CLIP(LONGPATH())&'\PAR_K')
     DO PROCEDURERETURN
  .
  CHECKOPEN(GG,1)
  GG::Used += 1
  CHECKOPEN(GGK,1)
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  FilesOpened = True

  B_GADS=YEAR(B_DAT)
  CLEAR(GGK:RECORD)
  GGK:BKK='23100'
  SET(GGK:BKK_DAT,GGK:BKK_DAT)
  LOOP
     NEXT(GGK)
     IF ERROR() OR ~(GGK:BKK='23100') THEN BREAK.
     IF ~(GGK:D_K='D') OR (GGK:U_NR=1) THEN CYCLE.
     IF GETGG(GGK:U_NR)
        R:DOK_SENR=GG:DOK_SENR
        R:DATUMS=GG:DATUMS
        ADD(R_TABLE)
     .
  .
  SORT(R_TABLE,R:DOK_SENR)

  RecordsToProcess = RECORDS(PAR:KARTE_KEY)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Bûvçju rçíinus'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAR_K,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAR:RECORD)
      SET(PAR:KARTE_KEY)
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
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('REKINI.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
       .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF F:NOA='1' AND ~(PAR:REDZAMIBA='A') AND ~(PAR:NOS_S='REZERVÇTS') AND ~(PAR:NOS_S='ASSAKO')
            npk#+=1
            SUMMA=0
            ?Progress:UserString{Prop:Text}=NPK#
            DISPLAY(?Progress:UserString)
            STATUSS=''
            ATZ_TEKSTS=''
            MEN_NR=MONTH(S_DAT)  !SÂKUMA MÇNESIS
            MENESU_SKAITS=SAV_MENESU_SKAITS
            A1#=GETPAR_ATZIME(PAR:ATZIME1,2)
            A2#=GETPAR_ATZIME(PAR:ATZIME2,2)
            IF A1#=2 OR A1#=4 !AIZLIEGTSvSPEC.NOT.
               STATUSS='A'
               ATZ_TEKSTS=PAR:ATZIME1&' '&GETPAR_ATZIME(PAR:ATZIME1,1)
            ELSIF A2#=2 OR A2#=4 !AIZLIEGTSvSPEC.NOT.
               STATUSS='A'
               ATZ_TEKSTS=PAR:ATZIME2&' '&GETPAR_ATZIME(PAR:ATZIME2,1)
            ELSIF ~PAR:L_SUMMA1
               STATUSS='A'
               ATZ_TEKSTS='Nulles summa'
            ELSIF PAR:L_CDATUMS > S_DAT
               KOR#=0
               PAR_L_SUMMA1=GETPAR_LIGUMI(PAR:U_NR,1,0,4)    !MEKLÇJAM IEPRIEKÐÇJO
               LOOP MN# = MEN_NR TO MEN_NR+(MENESU_SKAITS-1)
                  KOR#+=1
                  IF PAR:L_CDATUMS <= DATE(MN#+1,1,YEAR(S_DAT))
!                STOP(FORMAT(PAR:L_CDATUMS,@D06.)&'<='&FORMAT(DATE(MN#+1,1,YEAR(S_DAT)),@D06.))
                     IF ~PAR_L_SUMMA1
                        MENESU_SKAITS-=KOR#
                        ATZ_TEKSTS=MENESU_SKAITS&' mçneði'
                        MEN_NR+=KOR#
                        SUMMA=PAR:L_SUMMA1*MENESU_SKAITS
                     ELSE
                        SUMMA=PAR_L_SUMMA1*KOR# + PAR:L_SUMMA1*(MENESU_SKAITS-KOR#)
                     .
                     BREAK
                  .
               .
               IF ~SUMMA
                  IF PAR_L_SUMMA1 ! SPÇKÂ TIKAI IEPRIEKÐÇJAIS
                     SUMMA=PAR_L_SUMMA1*MENESU_SKAITS
                  ELSE
!                     KLUDA(0,'Jâmaksâ tikai no '&FORMAT(PAR:L_CDATUMS,@D06.))
                     STATUSS='A'
                     ATZ_TEKSTS='Jâmaksâ tikai no '&FORMAT(PAR:L_CDATUMS,@D06.)
                  .
               .
            ELSE
               SUMMA=PAR:L_SUMMA1*MENESU_SKAITS
            .
            IF ~STATUSS !~IZLAISTS
               CET_NR=INT((MEN_NR-1)/3)+1   !MEN_NR-SÂKUMA MÇNESIS
               GET(R_TABLE,0)
               R:DOK_SENR=CLIP(PAR:KARTE)&'-'&CET_NR&B_GADS

               GET(R_TABLE,R:DOK_SENR)
               IF ~ERROR()
                   STATUSS='A'
                   ATZ_TEKSTS='Rçíins '&CLIP(R:DOK_SENR)&' jau izrakstîts '&FORMAT(R:DATUMS,@D06.)
               .
            .
            IF STATUSS !IZLAISTS
               R_SUMMA=0
               R_ATLAIDE=0
               R_SATLAIDE=''
               IF F:DBF = 'W'
                  PRINT(RPT:DETAIL)
               ELSE
                  OUTA:LINE=PAR:KARTE&CHR(9)&STATUSS&CHR(9)&PAR:NOS_S&CHR(9)&LEFT(FORMAT(R_SUMMA,@N-7.2))&CHR(9)&|
                  R_SATLAIDE&CHR(9)&LEFT(FORMAT(R_ATLAIDE,@N-7.2))&CHR(9)&ATZ_TEKSTS
                  ADD(OUTFILEANSI)
               .
               IZLAISTI#+=1
            ELSE
               DO AUTONUMBER
               UZBUVETI#+=1
               GG:DOKDAT=TODAY()
               GG:NOKA=PAR:NOS_S
               GG:PAR_NR=PAR:U_NR
               PAR_NR=PAR:U_NR
!               STOP(PAR:NOS_S&MENESU_SKAITS)
               PerformASSAKO1
               MENESU_SKAITS=SAV_MENESU_SKAITS
               GG:SUMMA=SUMMA !TAGAD AR PVN
               GG:SECIBA=CLOCK()
               IF RIUPDATE:GG()
                  KLUDA(24,'GG.tps')
               ELSE
                  R_SUMMA=GG:SUMMA
                  R_SATLAIDE=GG:ATLAIDE&'%='
                  R_ATLAIDE=GG:SUMMA/(1-GG:ATLAIDE/100)-GG:SUMMA
                  ATZ_TEKSTS=CLIP(ATZ_TEKSTS)&' '&FORMAT(PAR:ATZIME1,@N3B)&' '&GETPAR_ATZIME(PAR:ATZIME1,1)
                  ATZ_TEKSTS=CLIP(ATZ_TEKSTS)&' '&FORMAT(PAR:ATZIME2,@N3B)&' '&GETPAR_ATZIME(PAR:ATZIME2,1)
                  IF F:DBF = 'W'
                     PRINT(RPT:DETAIL)
                  ELSE
                     OUTA:LINE=PAR:KARTE&CHR(9)&STATUSS&CHR(9)&PAR:NOS_S&CHR(9)&LEFT(FORMAT(R_SUMMA,@N-7.2))&CHR(9)&|
                     R_SATLAIDE&CHR(9)&LEFT(FORMAT(R_ATLAIDE,@N-7.2))&CHR(9)&ATZ_TEKSTS
                     ADD(OUTFILEANSI)
                  .
                  R_SUMMAK+=R_SUMMA
                  R_ATLAIDEK+=R_ATLAIDE
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
  IF SEND(PAR_K,'QUICKSCAN=off').                                                           
  IF LocalResponse = RequestCompleted
    OUTA:LINE=' Izlaisti: '&IZLAISTI#&' Uzbûvçti: '&UZBUVETI#&' Kopâ: '&FORMAT(R_SUMMAK,@N-9.2)&|
    ' t.s. atlaide '&FORMAT(R_ATLAIDEK,@N-9.2)
    IF F:DBF='W'   !WMF
       PRINT(RPT:RPT_FOOT)
       ENDPAGE(report)
    ELSE !WORD,EXCEL
       ADD(OUTFILEANSI)
    .
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
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE
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
    IF PAR_K::Used  = 0 THEN CLOSE(PAR_K).
    GG::Used -= 1
    IF GG::Used  = 0 THEN CLOSE(GG).
  END
  FREE(R_TABLE)
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
!  IF ERRORCODE() OR PAR:KARTE>1240
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAR_K')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  .
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
AUTONUMBER ROUTINE
  Auto::Attempts = 0
  LOOP
    SET(GG:NR_KEY)
    PREVIOUS(GG)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GG')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:GG:U_NR = 1
    ELSE
      Auto::Save:GG:U_NR = GG:U_NR + 1
    END
    CLEAR(GG:RECORD)
    GG:U_NR = Auto::Save:GG:U_NR
    GG:DATUMS = TODAY()
    ADD(GG)
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
EnterGIL_Show PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
window               WINDOW('DB atvçrtais apgabals bûs no ... lîdz gada beigâm'),AT(,,167,54),CENTER,GRAY
                       SPIN(@D06.B),AT(4,10,55,15),USE(SYS:GIL_SHOW),FONT(,9,,FONT:bold)
                       BUTTON('=GADA SÂK.'),AT(61,11,50,14),USE(?ButtonEQUGS)
                       BUTTON('=MÇN.SÂK.'),AT(113,11,50,14),USE(?ButtonEQUMS)
                       BUTTON('Atvçrt visu'),AT(36,31,50,14),USE(?ButtonEQU0)
                       BUTTON('OK'),AT(91,31,35,14),USE(?OkButton),DEFAULT
                       BUTTON('Atlikt'),AT(128,31,36,14),USE(?CancelButton)
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
   IF SYS:GIL_SHOW < date(1,1,gads)
      SYS:GIL_SHOW=date(1,1,gads)
   .
   ?BUTTONEQUGS{PROP:TEXT}='no '&FORMAT(date(1,1,gads),@D06.)
   ?BUTTONEQUMS{PROP:TEXT}='no '&FORMAT(date(MONTH(TODAY()),1,gads),@D06.)
  
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?SYS:GIL_SHOW)
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
    OF ?ButtonEQUGS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SYS:GIL_SHOW=DATE(1,1,GADS)
        DISPLAY
      END
    OF ?ButtonEQUMS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SYS:GIL_SHOW=date(MONTH(TODAY()),1,gads)
        DISPLAY
      END
    OF ?ButtonEQU0
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SYS:GIL_SHOW=0
        localresponse=requestcompleted
        IF RIUPDATE:SYSTEM()
           KLUDA(24,'SYSTEM')
           localresponse=requestcancelled
        .
        break
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        localresponse=requestcompleted
        IF RIUPDATE:SYSTEM()
           KLUDA(24,'SYSTEM')
           localresponse=requestcancelled
        .
        break
      END
    OF ?CancelButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        localresponse=requestcancelled
        break
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('EnterGIL_Show','winlats.INI')
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('EnterGIL_Show','winlats.INI')
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
