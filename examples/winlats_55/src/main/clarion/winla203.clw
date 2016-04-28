                     MEMBER('winlats.clw')        ! This is a MEMBER module
IZZFILTA PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
FILTRS               STRING(1)
SAV_FILTRS           STRING(1)
VUT                  STRING(20)
GADS1                DECIMAL(4)
GADS2                DECIMAL(4)
ButtonALAVTEXT       STRING(15)
ButtonALAVDITEXT     STRING(15)
List1:Queue          QUEUE,PRE()
avots1               STRING(20)
                     END
List2:Queue          QUEUE,PRE()
avots2               STRING(20)
                     END
RecordFiltered       LONG
MAKSAJUMA_TAKA       STRING(55)
QuickWindow          WINDOW('Filtrs izziòâm'),AT(,,300,133),GRAY,MDI
                       ENTRY(@n4),AT(12,9,28,12),USE(GADS1),HIDE,RIGHT(1)
                       STRING(' g.'),AT(152,10),USE(?StringG2),HIDE
                       LIST,AT(49,9,64,12),USE(avots1),HIDE,FORMAT('80L~avots 1~@s20@'),DROP(12),FROM(List1:Queue)
                       PROMPT('---'),AT(115,10),USE(?Prompt:lidz),HIDE
                       ENTRY(@n4),AT(123,9,28,12),USE(GADS2),HIDE,RIGHT(1)
                       STRING(' g.'),AT(40,10),USE(?StringG1),HIDE
                       LIST,AT(161,9,64,12),USE(avots2),HIDE,FORMAT('80L~avots 2~@s20@'),DROP(12),FROM(List2:Queue)
                       OPTION('Filtrs pçc &Kadru saraksta'),AT(3,35,168,53),USE(FILTRS),BOXED,HIDE
                         RADIO('Visi'),AT(9,45),USE(?FILTRS:Radio1)
                         RADIO('Nodaïa Nr'),AT(9,55,45,10),USE(?FILTRS:Radio2)
                         RADIO('Konkrçts darbinieks '),AT(9,66,76,10),USE(?FILTRS:Radio3)
                         RADIO('Visi, kam konts tekoðâ bankâ'),AT(9,77,159,10),USE(?FILTRS:Radio4),DISABLE,HIDE,VALUE('4')
                       END
                       ENTRY(@S2),AT(58,55,15,10),USE(F:NODALA),HIDE,RIGHT
                       PROMPT('&Grupa'),AT(250,10,22,10),USE(?Prompt:DAV_GRUPA),HIDE
                       ENTRY(@s4),AT(272,10,16,10),USE(DAV_GRUPA),HIDE
                       STRING('1234'),AT(272,22),USE(?String4),HIDE,FONT(,,COLOR:Gray,)
                       STRING(@s55),AT(50,24,222,10),USE(MAKSAJUMA_TAKA),RIGHT(1),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING(@s20),AT(87,67,82,10),USE(VUT),FONT(,8,,)
                       PROMPT('&No'),AT(191,69),USE(?PromptNo),HIDE
                       SPIN(@D06.B),AT(202,67,53,12),USE(S_DAT),HIDE
                       SPIN(@D06.B),AT(202,80,53,12),USE(B_DAT),HIDE
                       BUTTON('Uzbûvçt &XML failu'),AT(173,34,104,14),USE(?F:XML_BUTTON),HIDE
                       IMAGE('CHECK3.ICO'),AT(279,34,14,14),USE(?Image:F:XML),HIDE
                       BUTTON('&Ignorçt arhîvu'),AT(173,49,104,14),USE(?F:IDP_BUTTON),HIDE
                       IMAGE('CHECK3.ICO'),AT(279,49,14,14),USE(?Image:F:IDP),HIDE
                       OPTION('Izdrukas &Formâts'),AT(3,92,104,27),USE(F:DBF),BOXED,HIDE
                         RADIO('WMF'),AT(6,103,28,10),USE(?F:DBF:WMF),VALUE('W')
                         RADIO('WORD'),AT(35,103,33,10),USE(?F:DBF:WORD),VALUE('A')
                         RADIO('Excel'),AT(71,103,30,10),USE(?F:DBF:EXCEL),VALUE('E')
                       END
                       BUTTON('&8-DunN'),AT(112,104,35,14),USE(?ButtonDiena),DISABLE,HIDE
                       BUTTON('Alga'),AT(150,104,57,14),USE(?ButtonALAV),DISABLE,HIDE
                       BUTTON('D&rukas parametri'),AT(208,95,83,14),USE(?ButtonDruka),LEFT,ICON(ICON:Print1),STD(STD:PrintSetup)
                       PROMPT('&Lîdz'),AT(185,81),USE(?PromptLidz),HIDE
                       BUTTON('&OK'),AT(209,110,46,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(256,110,35,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  FILTRS = 'V'
  F:NODALA = ''
  ID=0
  SAV_FILTRS = FILTRS
  F:IDP = '1'
  F:DTK = ''
  F:NOA = ''
  F:XML = ''
  F:DIENA=''
  F:KRI='A' !ALGA
  IF ~F:DBF THEN F:DBF='W'.
  
  avots1='Janvâris'
  ADD(LIST1:QUEUE)
  avots1='Februâris'
  ADD(LIST1:QUEUE)
  avots1='Marts'
  ADD(LIST1:QUEUE)
  avots1='Aprîlis'
  ADD(LIST1:QUEUE)
  avots1='Maijs'
  ADD(LIST1:QUEUE)
  avots1='Jûnijs'
  ADD(LIST1:QUEUE)
  avots1='Jûlijs'
  ADD(LIST1:QUEUE)
  avots1='Augusts'
  ADD(LIST1:QUEUE)
  avots1='Septembris'
  ADD(LIST1:QUEUE)
  avots1='Oktobris'
  ADD(LIST1:QUEUE)
  avots1='Novembris'
  ADD(LIST1:QUEUE)
  avots1='Decembris'
  ADD(LIST1:QUEUE)
  
  avots2='Janvâris'
  ADD(LIST2:QUEUE)
  avots2='Februâris'
  ADD(LIST2:QUEUE)
  avots2='Marts'
  ADD(LIST2:QUEUE)
  avots2='Aprîlis'
  ADD(LIST2:QUEUE)
  avots2='Maijs'
  ADD(LIST2:QUEUE)
  avots2='Jûnijs'
  ADD(LIST2:QUEUE)
  avots2='Jûlijs'
  ADD(LIST2:QUEUE)
  avots2='Augusts'
  ADD(LIST2:QUEUE)
  avots2='Septembris'
  ADD(LIST2:QUEUE)
  avots2='Oktobris'
  ADD(LIST2:QUEUE)
  avots2='Novembris'
  ADD(LIST2:QUEUE)
  avots2='Decembris'
  ADD(LIST2:QUEUE)
  
  IF INRANGE(JOB_NR,1,40) !SAUCAM NO NOLIKTAVAS (SERVISA)/BÂZES
     GADS1=DB_GADS
     GADS2=DB_GADS
     GET(LIST1:QUEUE,month(TODAY()))
     GET(LIST2:QUEUE,month(TODAY()))
     PAV::U_NR=1
  ELSE                     !SAUCAM NO ALGÂM
     IF OPCIJA[2]='4'      !RÎKOJUMU IZZIÒA
        IF GL:FREE_N       !REÌISTRÂC.DAT.
           S_DAT=GL:FREE_N
        ELSE
           S_DAT=DB_S_DAT
        .
        B_DAT=TODAY()
     ELSE
        IF MEN_NR<=12         !?
           S_DAT=ALP:YYYYMM
           B_DAT=DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1
        ELSE
           S_DAT=DATE(1,1,YEAR(ALP:YYYYMM))
           B_DAT=DATE(12,1,YEAR(ALP:YYYYMM))
!        MEN_NR=MONTH(TODAY())   !?
           MEN_NR=12
        .
     .
     gads1=year(S_DAT)
     gads2=year(B_DAT)
     GET(LIST1:QUEUE,month(S_DAT))
     GET(LIST2:QUEUE,month(B_DAT))
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  GETMYBANK()
  LOOP I#=1 TO 9
     IF INSTRING(OPCIJA[I#],'12345')
        EXECUTE I#
           BEGIN
              IF OPCIJA[1]='1'          !  1-1 GADS,MÇNESIS-GADS,MÇNESIS
                 UNHIDE(?StringG1)
                 UNHIDE(?StringG2)
                 UNHIDE(?GADS1)
                 UNHIDE(?GADS2)
                 UNHIDE(?AVOTS1)
                 UNHIDE(?PROMPT:LIDZ)
                 UNHIDE(?AVOTS2)
              ELSE
                 UNHIDE(?PROMPTLIDZ)     !  1-2 S_DAT-B_DAT
                 UNHIDE(?PROMPTNO)
                 UNHIDE(?S_DAT)
                 UNHIDE(?B_DAT)
              .
           .
           BEGIN                         ! 2
              IF OPCIJA[I#]='1'
                 UNHIDE(?FILTRS)
              ELSIF OPCIJA[I#]='2'
                 UNHIDE(?FILTRS)
                 UNHIDE(?FILTRS:Radio4)
                 ENABLE(?FILTRS:Radio4)
                 ?FILTRS:Radio4{PROP:TEXT}='Visi, kam konts '&BANKA
              ELSIF OPCIJA[I#]='3'
                 UNHIDE(?FILTRS)         
                 HIDE(?FILTRS:Radio2)    !V,BEZ NODAÏAS,K
                 DISABLE(?FILTRS:Radio2) !V,BEZ NODAÏAS,K
              ELSIF OPCIJA[I#]='4'
                 UNHIDE(?FILTRS)
                 UNHIDE(?FILTRS:Radio4)
                 HIDE(?FILTRS:Radio2)    !V,BEZ NODAÏAS,K
                 DISABLE(?FILTRS:Radio2) !V,BEZ NODAÏAS,K
                 ENABLE(?FILTRS:Radio4)
                 ?FILTRS:Radio4{PROP:TEXT}='Nepersonalizçtie'
              .
           .
           BEGIN                         !  3
               UNHIDE(?Prompt:DAV_GRUPA)
               UNHIDE(?DAV_GRUPA)
               DAV_GRUPA = ''
           .
           BEGIN                         !  4  1,2,5-Uzbûvçt XML failu 3-Uzbûvçt APM.FAILU 4-Izmaks.=Aprçíin
              UNHIDE(?F:XML_BUTTON)
              IF OPCIJA[I#]='1'
                 IF GADS>2008
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt ZDN.XML'
                 ELSE
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt ZDN.DUF'
                 .
              ELSIF OPCIJA[I#]='2'
                 IF YEAR(ALP:YYYYMM)>2008
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt DDZ_P.XML'
                 ELSE
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt DDZ_P.DUF'
                 .
              ELSIF OPCIJA[I#]='3'      ! FAILS BANKAI
                 GETMYBANK()            ! MANA BANKA
                 IF BKODS[1:6]='TRELLV' ! VALSTS KASE
                    QUICKWINDOW{PROP:TEXT}=BANKA
                    HIDE(?F:XML_BUTTON)
                    DISABLE(?F:XML_BUTTON)
                 ELSE                   ! PÂRÇJÂS
                    QUICKWINDOW{PROP:TEXT}='Elektroniskâ norçíinu sistçma FiDAViSta. '&BANKA
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt '&CLIP(BKODS)&'_MP.XML'
                    MAKSAJUMA_TAKA=BAN:MAKSAJUMA_TAKA
                 .
              ELSIF OPCIJA[I#]='4'
                 ?F:XML_BUTTON{PROP:TEXT}='Izmaksâts=Aprçíinâts'
                 F:XML = '1'
              ELSIF OPCIJA[I#]='5'
                 IF YEAR(ALP:YYYYMM)>2008
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt PFPISK.XML'
                 ELSE
                    ?F:XML_BUTTON{PROP:TEXT}='Uzbûvçt IEIEN_PAZ.DUF'
                 .
              .
              IF F:XML
                 UNHIDE(?IMAGE:F:XML)
              .
           .
           BEGIN                         !5  1-Ignorçt arhîvu/2-TIKAI ATLAISTIE-tikai,kas nav atl./3-IEKÏ.0-es/4-Precizçtâ
              IF OPCIJA[I#]='2'          !                   
                 F:IDP=''
                 ?F:IDP_BUTTON{PROP:TEXT}='Tikai atlaistie'
              ELSIF OPCIJA[I#]='3'
                 F:IDP=''
                 ?F:IDP_BUTTON{PROP:TEXT}='Iekïaut sarakstâ arî 0-es'
              ELSIF OPCIJA[I#]='4'
                 F:IDP=''
                 ?F:IDP_BUTTON{PROP:TEXT}='Precizçtâ'
              .
              UNHIDE(?F:IDP_BUTTON)
              IF F:IDP
                 UNHIDE(?IMAGE:F:IDP)
              .
           .
           BEGIN                                   !6: WMF/Word/Excel
              UNHIDE(?F:DBF)
              CASE OPCIJA[I#]
              OF '1'                               !  WMF/WORD
                 HIDE(?F:DBF:EXCEL)
                 F:DBF='W'
                 IF F:DBF='E' THEN F:DBF='W'.
              OF '2'                               !  WMF/EXCEL
                 HIDE(?F:DBF:WORD)
                 IF F:DBF='A' THEN F:DBF='W'.
              OF '3'                               !  WMF/WORD/EXCEL
                 IF ~INSTRING(F:DBF,'WAE') THEN F:DBF='W'.
              ELSE
                 KLUDA(0,'WMF/WORD/EXCEL izsaukums: '&OPCIJA[I#])
              .
           .
           BEGIN                        !   7 S_DAT-B_DAT
              UNHIDE(?PROMPTLIDZ)
              UNHIDE(?PROMPTNO)
              UNHIDE(?S_DAT)
              UNHIDE(?B_DAT)
           .
           BEGIN                         !  8 DIENA/NAKTS
              UNHIDE(?BUTTONDIENA)
              ENABLE(?BUTTONDIENA)
           .
           BEGIN                         
              UNHIDE(?BUTTONALAV)
              ENABLE(?BUTTONALAV)
              CASE OPCIJA[I#]
              OF '1'                     !  ALGA/AVANSI
                 ButtonALAVTEXT='Avansi'
              OF '2'                     !  ALGA/DIVIDENDES
                 ButtonALAVTEXT='Dividendes'
              OF '3'                     !  Uzò.Lîgums
                 ButtonALAVTEXT='Dividendes'
                 ButtonALAVDITEXT='1008-UL'
              .
           .
        .
     .
  .
  ACCEPT
    IF ~(SAV_FILTRS=FILTRS)
        CASE FILTRS
        OF 'V'
            HIDE(?F:NODALA)
            F:NODALA = ''
            VUT=''
            ID = 0
            F:NOA    = ''
        OF 'N'
            UNHIDE(?F:NODALA)
            SELECT(?F:NODALA)
            ID = 0
            VUT=''
            F:NOA    = ''
        OF 'K'
            HIDE(?f:nodala)
            GlobalRequest = SelectRecord
            BROWSEKADRI
            PAV::U_NR=0 !DÇÏ SERVISA
            IF GLOBALResponse = RequestCompleted
              ID = KAD:ID
              VUT= GETKADRI(ID,0,1)
              F:NODALA = ''
              F:NOA    = ''
            END
            LocalResponse = RequestCancelled
        OF '4'
            F:NOA='1' !BÛS FILTRS PÇC KADRA BANKAS vai NEPERSONALIZÇTIE
        .
        SAV_FILTRS = FILTRS
    .
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?GADS1)
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
    OF ?F:XML_BUTTON
      CASE EVENT()
      OF EVENT:Accepted
        IF F:XML
           F:XML = ''
           HIDE(?IMAGE:F:XML)
        ELSE
           F:XML = '1'
           UNHIDE(?IMAGE:F:XML)
        END
        DISPLAY
        DO SyncWindow
      END
    OF ?F:IDP_BUTTON
      CASE EVENT()
      OF EVENT:Accepted
        IF OPCIJA[5]='2'
           IF F:IDP = '3'
               F:IDP = ''
               HIDE(?IMAGE:F:IDP)
               ?F:IDP_BUTTON{PROP:TEXT}='Tikai atlaistie'
           ELSIF F:IDP = ''
               F:IDP = '1'
               UNHIDE(?IMAGE:F:IDP)
               ?F:IDP_BUTTON{PROP:TEXT}='Tikai atlaistie'
           ELSIF F:IDP='1'
               F:IDP = '2'
               UNHIDE(?IMAGE:F:IDP)
               ?F:IDP_BUTTON{PROP:TEXT}='Kas nav atlaisti'
           ELSE
               F:IDP = '3'
               UNHIDE(?IMAGE:F:IDP)
               ?F:IDP_BUTTON{PROP:TEXT}='Tikai atlaistie ðajâ mçn.'
           .
        ELSE
           IF F:IDP = ''
               F:IDP = '1'
               UNHIDE(?IMAGE:F:IDP)
           ELSE
               F:IDP = ''
               HIDE(?IMAGE:F:IDP)
           .
        .
        DISPLAY
        DO SyncWindow
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
          ?ButtonDiena{PROP:TEXT}='&8-DunN'
        .
        DISPLAY
      END
    OF ?ButtonALAV
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:KRI='A' !ALGA
          F:KRI='V'
          ?ButtonALAV{PROP:TEXT}=ButtonALAVTEXT
        ELSIF F:KRI='V' !AVANSI/DIVIDENDES
          IF OPCIJA[9]='3'
             F:KRI='B'
             ?ButtonALAV{PROP:TEXT}=ButtonALAVDITEXT
          ELSE
             F:KRI='A'
             ?ButtonALAV{PROP:TEXT}='Alga'
          .
        ELSE !Uzò.Lîgums
          F:KRI='A'
          ?ButtonALAV{PROP:TEXT}='Alga'
        .
        DISPLAY
      END
    OF ?ButtonDruka
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OPCIJA[1]='1'
           SELECT(1)
           SELECT  ! ACCEPT ALL
           S_DAT=DATE(CHOICE(?AVOTS1),1,GADS1)
           B_DAT=DATE(CHOICE(?AVOTS2)+1,1,GADS2)-1
        .
        IF ROUND((B_DAT-S_DAT)/30,1)>12 AND ~(OPCIJA[2]='4') !&~RÎKOJUMU IZZIÒA
           KLUDA(0,'mçneðu vairâk kâ 12...',,1)
!           SELECT(?avots2)
           LocalResponse = RequestCompleted
           BREAK
        ELSE
           LocalResponse = RequestCompleted
           BREAK
        .
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
  IF GLOBAL::Used = 0
    CheckOpen(GLOBAL,1)
  END
  GLOBAL::Used += 1
  BIND(GL:RECORD)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  INIRestoreWindow('IZZFILTA','winlats.INI')
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF WindowOpened
    INISaveWindow('IZZFILTA','winlats.INI')
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
A_STAT               PROCEDURE                    ! Declare Procedure
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

SV                   STRING('N')
SV_TEXT              STRING(15)
MM                   DECIMAL(2)
S11                  DECIMAL(3),DIM(12)
S12                  DECIMAL(3),DIM(12)
S21                  DECIMAL(5),DIM(12)
S22                  DECIMAL(5),DIM(12)
S31                  DECIMAL(5),DIM(12)
S32                  DECIMAL(5),DIM(12)
S51                  DECIMAL(4),DIM(12)
S52                  DECIMAL(5),DIM(12)
NDD                  DECIMAL(4),DIM(12)
RS11                 DECIMAL(3)
RS12                 DECIMAL(3)
RS21                 DECIMAL(5)
RS22                 DECIMAL(5)
RS31                 DECIMAL(5)
RS32                 DECIMAL(5)
RS41                 DECIMAL(4)
RS42                 DECIMAL(4)
RS51                 DECIMAL(5)
RS52                 DECIMAL(5)
S21K                 DECIMAL(5)
S22K                 DECIMAL(5)
S31K                 DECIMAL(5)
S32K                 DECIMAL(5)
S41K                 DECIMAL(5)
S42K                 DECIMAL(5)
S51K                 DECIMAL(5)
S52K                 DECIMAL(5)
CNDD                 DECIMAL(4)
CNDDK                DECIMAL(4)
RPT_GADS             DECIMAL(4)
DAT                  DATE
LAI                  TIME
D1                   STRING(30)
D2                   STRING(30)
!-----------------------------------------------------------------------------
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_stundas)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:OBJ_NR)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END

!---------------------------------------------------------------------------
report REPORT,AT(104,1385,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,198,8000,1188),USE(?unnamed)
         LINE,AT(6250,885,0,313),USE(?Line10:17),COLOR(COLOR:Black)
         LINE,AT(5052,885,0,313),USE(?Line10:14),COLOR(COLOR:Black)
         LINE,AT(3854,885,0,313),USE(?Line10:11),COLOR(COLOR:Black)
         LINE,AT(781,885,6146,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(1302,885,0,313),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(2500,885,0,313),USE(?Line10:8),COLOR(COLOR:Black)
         STRING('GR'),AT(813,927,469,208),USE(?String6:7),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('KA'),AT(1344,917,469,208),USE(?String6:8),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('GR'),AT(1865,917,625,208),USE(?String6:9),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('KA'),AT(2531,927,625,208),USE(?String6:10),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('GR'),AT(3208,927,625,208),USE(?String6:11),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('KA'),AT(3885,927,625,208),USE(?String6:12),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('GR'),AT(4563,927,469,208),USE(?String6:13),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('KA'),AT(5083,927,469,208),USE(?String6:14),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('GR'),AT(5604,927,625,208),USE(?String6:15),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('KA'),AT(6281,927,625,208),USE(?String6:16),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('nepilnu DD'),AT(6958,906,729,208),USE(?String6:19),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,1146,7292,0),USE(?Line9),COLOR(COLOR:Black)
         STRING(@s45),AT(1375,104,4479,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('STATISTIKA'),AT(2604,365,1094,260),USE(?String2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@N4),AT(3698,365,438,260),USE(RPT_GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('. gads'),AT(4167,365,521,260),USE(?String4),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(5990,385),USE(SV_TEXT),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7104,438),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(417,625,7292,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(781,625,0,573),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1823,625,0,573),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3177,625,0,573),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4531,625,0,573),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5573,625,0,573),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6927,625,0,573),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(7708,625,0,573),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('mçn.'),AT(448,792,313,208),USE(?String6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Bruto d. sam.'),AT(1854,667,1302,208),USE(?String6:3),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Neto d. sam.'),AT(3208,667,1302,208),USE(?String6:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('C. dienas'),AT(4563,667,990,208),USE(?String6:5),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Cilv. stundas'),AT(5604,667,1302,208),USE(?String6:6),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Cilvçki'),AT(6990,698,677,208),USE(?String6:18),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('Cilv. sk.'),AT(813,667,990,208),USE(?String6:2),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(417,625,0,573),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(417,-10,0,198),USE(?Line10),COLOR(COLOR:Black)
         STRING(@N2),AT(469,10,,156),USE(MM),RIGHT
         LINE,AT(781,-10,0,198),USE(?Line10:2),COLOR(COLOR:Black)
         STRING(@N4),AT(833,10,,156),USE(RS11),RIGHT
         LINE,AT(1302,-10,0,198),USE(?Line10:4),COLOR(COLOR:Black)
         STRING(@N4),AT(1354,10,,156),USE(RS12),RIGHT
         LINE,AT(1823,-10,0,198),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@N_6),AT(1875,10,,156),USE(RS21),RIGHT
         LINE,AT(2500,-10,0,198),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N_6),AT(2552,10,,156),USE(RS22),RIGHT
         LINE,AT(3177,-10,0,198),USE(?Line10:7),COLOR(COLOR:Black)
         STRING(@N_6),AT(3229,10,,156),USE(RS31),RIGHT
         LINE,AT(3854,-10,0,198),USE(?Line10:9),COLOR(COLOR:Black)
         STRING(@N_6),AT(3906,10,,156),USE(RS32),RIGHT
         LINE,AT(4531,-10,0,198),USE(?Line10:10),COLOR(COLOR:Black)
         STRING(@N4),AT(4635,10,,156),USE(RS41),RIGHT
         LINE,AT(5052,-10,0,198),USE(?Line10:12),COLOR(COLOR:Black)
         STRING(@N4),AT(5167,10,,156),USE(RS42),RIGHT
         LINE,AT(5573,-10,0,198),USE(?Line10:13),COLOR(COLOR:Black)
         STRING(@N_6),AT(5677,10,,156),USE(RS51),RIGHT
         LINE,AT(6250,-10,0,198),USE(?Line10:15),COLOR(COLOR:Black)
         STRING(@N_6),AT(6354,10,,156),USE(RS52),RIGHT
         STRING(@N4),AT(7135,10,,156),USE(cndd),RIGHT
         LINE,AT(7708,0,0,198),USE(?Line10:31),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,198),USE(?Line10:16),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,458),USE(?unnamed:3)
         LINE,AT(417,-10,0,271),USE(?Line10:18),COLOR(COLOR:Black)
         LINE,AT(1823,-10,0,271),USE(?Line10:19),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,271),USE(?Line10:20),COLOR(COLOR:Black)
         LINE,AT(3177,-10,0,271),USE(?Line10:21),COLOR(COLOR:Black)
         LINE,AT(3854,-10,0,271),USE(?Line10:22),COLOR(COLOR:Black)
         LINE,AT(4531,-10,0,271),USE(?Line10:23),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,271),USE(?Line10:24),COLOR(COLOR:Black)
         LINE,AT(5573,-10,0,271),USE(?Line10:25),COLOR(COLOR:Black)
         LINE,AT(6250,-10,0,271),USE(?Line10:26),COLOR(COLOR:Black)
         LINE,AT(6927,-10,0,271),USE(?Line10:27),COLOR(COLOR:Black)
         LINE,AT(7708,0,0,271),USE(?Line10:32),COLOR(COLOR:Black)
         LINE,AT(781,-10,0,63),USE(?Line10:28),COLOR(COLOR:Black)
         LINE,AT(1302,-10,0,63),USE(?Line10:29),COLOR(COLOR:Black)
         LINE,AT(417,52,7292,0),USE(?Line10:30),COLOR(COLOR:Black)
         STRING(@N_8),AT(1875,104,,156),USE(S21K),RIGHT
         STRING(@N_8),AT(2552,104,,156),USE(S22K),RIGHT
         STRING(@N_6),AT(3229,104,,156),USE(S31K),RIGHT
         STRING(@N_6),AT(3906,104,,156),USE(S32K),RIGHT
         STRING(@N_5),AT(4583,104,,156),USE(S41K),RIGHT
         STRING(@N_5),AT(5104,104,,156),USE(S42K),RIGHT
         STRING(@N_6),AT(5677,104,,156),USE(S51K),RIGHT
         STRING(@N_6),AT(6354,104,,156),USE(S52K),RIGHT
         STRING(@d06.),AT(6667,292),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7281,292),USE(LAI),FONT(,7,,,CHARSET:ANSI)
         STRING(@N4),AT(7135,94,,156),USE(cnddk),RIGHT
         LINE,AT(417,260,7292,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Kopâ :'),AT(469,104,573,156),USE(?String6:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(104,10885,8000,0),USE(?unnamed:2)
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

SVSCREEN WINDOW('Caption'),AT(,,106,92),GRAY
       OPTION('Filtrs pçc dzimuma'),AT(16,14,77,48),USE(SV),BOXED
         RADIO('Nav'),AT(30,29),USE(?SV:Radio1),VALUE('N')
         RADIO('Siev.'),AT(30,37),USE(?SV:Radio2),VALUE('S')
         RADIO('Vîr.'),AT(30,45),USE(?SV:Radio3),VALUE('V')
       END
       BUTTON('&OK'),AT(22,69,35,14),USE(?OkButtonSV),DEFAULT
       BUTTON('&Atlikt'),AT(59,69,36,14),USE(?CancelButtonSV)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  BIND('ID',ID)
  BIND('F:NODALA',F:NODALA)

  OPEN(SVSCREEN)
  DISPLAY
  ACCEPT
     CASE FIELD()
     OF ?OKButtonSV
        CASE EVENT()
        OF EVENT:Accepted
           LocalResponse = RequestCompleted
           BREAK
        END
     OF ?CancelButtonSV
        CASE EVENT()
        OF EVENT:Accepted
           LocalResponse = RequestCancelled
           CLOSE(SVSCREEN)
           DO ProcedureReturn
        END
     END
  END
  CLOSE(SVSCREEN)
  CASE SV
  OF 'V'
    SV_TEXT='†ikai vîrieði'
  OF 's'
    SV_TEXT='†ikai sievietes'
  .

  RPT_GADS=YEAR(ALP:YYYYMM)
!  S_DAT=DATE(1,1,RPT_GADS) ...... TAGAD IZZFILTA
!  B_DAT=DATE(12,31,RPT_GADS)
  DAT=TODAY()
  LAI=CLOCK()

  CLEAR(S11)
  CLEAR(S12)
  CLEAR(S21)
  CLEAR(S22)
  CLEAR(S31)
  CLEAR(S32)
  CLEAR(S51)
  CLEAR(S52)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True

  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Statistika'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=S_DAT
      SET(ALG:ID_KEY,ALG:ID_KEY)
!      Process:View{Prop:Filter} = '(ALG:NODALA=F:NODALA OR F:NODALA=0) AND (ALG:ID=ID OR ID=0)'
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
        IF SV='N' OR SV=GETKADRI(ALG:ID,0,8)   !VÎR/SIEV
           MM=MONTH(ALG:YYYYMM)
           CASE ALG:STATUSS
           OF '1'
           OROF '3'                             !AR DA grâmatiòu
              S21[MM]+=SUM(17)+SUM(44)+SUM(45)  !ALGA D_GR+ATVAÏINÂJUMI
              S31[MM]+=SUM(36)+SUM(9)+SUM(56)   !IZMAKSÂT+AVANSS+KARTE
              S51[MM]+=ALG:N_STUNDAS
              S11[MM]+=1                        !CILVÇKU SKAITS
              IF SUM(17)+SUM(44)+SUM(45)=0 AND ALG:N_STUNDAS>0  OR |
                 SUM(17)+SUM(44)+SUM(45)>0 AND ALG:N_STUNDAS=0
                KLUDA(0,CLIP(GETKADRI(ALG:ID,0,1))&' '&FORMAT(ALG:YYYYMM,@D13)&' Nostr.stundas= '&CLIP(ALG:N_STUNDAS)&' Alga= '&SUM(17)+SUM(44)+SUM(45))
              .
           ELSE                                 !AR NOD. KARTI
              S22[MM]+=SUM(18)+SUM(44)+SUM(45)  !ALGA SAV+ATVAÏINÂJUMI DGR
              S32[MM]+=SUM(36)+SUM(9)+SUM(56)   !IZMAKSÂT+AVANSS+KARTE
              S52[MM]+=ALG:N_STUNDAS
              S12[MM]+=1
              IF SUM(18)+SUM(44)+SUM(45)=0 AND ALG:N_STUNDAS>0  OR |
                 SUM(18)+SUM(44)+SUM(45)>0 AND ALG:N_STUNDAS=0
                KLUDA(0,CLIP(GETKADRI(ALG:ID,0,1))&' '&FORMAT(ALG:YYYYMM,@D13)&' Nostr.stundas= '&CLIP(ALG:N_STUNDAS)&' Alga= '&SUM(18)+SUM(44)+SUM(45))
              .
           .
           IF INRANGE(ALG:N_STUNDAS,1,CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,0,1)-1) !1-ATGRIEÞ KALENDÂRU
              NDD[MM]+=1
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP I#=MONTH(S_DAT) TO MONTH(B_DAT)
      MM=i#
      rS11=S11[I#]
      rS21=S21[I#]
      rS31=S31[I#]
      rS41=S51[I#]/8 !DIENAS
      rS51=S51[I#]   !STUNDAS
      rS12=S12[I#]
      rS22=S22[I#]
      rS32=S32[I#]
      rS42=S52[I#]/8
      rS52=S52[I#]
      CNDD=NDD[I#]
      PRINT(RPT:DETAIL)
      S21k+=RS21
      S31k+=RS31
      S41k+=RS41
      S51k+=RS51
      S22k+=RS22
      S32k+=RS32
      S42k+=RS42
      S52k+=RS52
      CNDDK+=CNDD
    .
    PRINT(RPT:RPT_FOOT)
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    F:DBF='W'   ! .................... PAGAIDÂM TIKAI WMF
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
  ELSE           !RTF,EXCEL
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
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
  IF ERRORCODE() OR ALG:YYYYMM>B_DAT
    IF ERRORCODE() AND ERRORCODE()<> BadRecErr
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
BrowseALPA PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
APR                  DECIMAL(7,2)
SAM                  DECIMAL(7,2)
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO

BRW1::View:Browse    VIEW(ALGPA)
                       PROJECT(ALP:YYYYMM)
                       PROJECT(ALP:STATUSS)
                       PROJECT(ALP:MIA)
                       PROJECT(ALP:APRIIN)
                       PROJECT(ALP:IETIIN)
                       PROJECT(ALP:PARSKAITIT)
                       PROJECT(ALP:IZMAKSAT)
                       PROJECT(ALP:ACC_KODS)
                       PROJECT(ALP:ACC_DATUMS)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::ALP:YYYYMM       LIKE(ALP:YYYYMM)           ! Queue Display field
BRW1::ALP:YYYYMM:NormalFG LONG                    ! Normal Foreground
BRW1::ALP:YYYYMM:NormalBG LONG                    ! Normal Background
BRW1::ALP:YYYYMM:SelectedFG LONG                  ! Selected Foreground
BRW1::ALP:YYYYMM:SelectedBG LONG                  ! Selected Background
BRW1::ALP:STATUSS      LIKE(ALP:STATUSS)          ! Queue Display field
BRW1::ALP:STATUSS:NormalFG LONG                   ! Normal Foreground
BRW1::ALP:STATUSS:NormalBG LONG                   ! Normal Background
BRW1::ALP:STATUSS:SelectedFG LONG                 ! Selected Foreground
BRW1::ALP:STATUSS:SelectedBG LONG                 ! Selected Background
BRW1::ALP:MIA          LIKE(ALP:MIA)              ! Queue Display field
BRW1::ALP:MIA:NormalFG LONG                       ! Normal Foreground
BRW1::ALP:MIA:NormalBG LONG                       ! Normal Background
BRW1::ALP:MIA:SelectedFG LONG                     ! Selected Foreground
BRW1::ALP:MIA:SelectedBG LONG                     ! Selected Background
BRW1::ALP:APRIIN       LIKE(ALP:APRIIN)           ! Queue Display field
BRW1::ALP:APRIIN:NormalFG LONG                    ! Normal Foreground
BRW1::ALP:APRIIN:NormalBG LONG                    ! Normal Background
BRW1::ALP:APRIIN:SelectedFG LONG                  ! Selected Foreground
BRW1::ALP:APRIIN:SelectedBG LONG                  ! Selected Background
BRW1::ALP:IETIIN       LIKE(ALP:IETIIN)           ! Queue Display field
BRW1::ALP:IETIIN:NormalFG LONG                    ! Normal Foreground
BRW1::ALP:IETIIN:NormalBG LONG                    ! Normal Background
BRW1::ALP:IETIIN:SelectedFG LONG                  ! Selected Foreground
BRW1::ALP:IETIIN:SelectedBG LONG                  ! Selected Background
BRW1::ALP:PARSKAITIT   LIKE(ALP:PARSKAITIT)       ! Queue Display field
BRW1::ALP:PARSKAITIT:NormalFG LONG                ! Normal Foreground
BRW1::ALP:PARSKAITIT:NormalBG LONG                ! Normal Background
BRW1::ALP:PARSKAITIT:SelectedFG LONG              ! Selected Foreground
BRW1::ALP:PARSKAITIT:SelectedBG LONG              ! Selected Background
BRW1::ALP:IZMAKSAT     LIKE(ALP:IZMAKSAT)         ! Queue Display field
BRW1::ALP:IZMAKSAT:NormalFG LONG                  ! Normal Foreground
BRW1::ALP:IZMAKSAT:NormalBG LONG                  ! Normal Background
BRW1::ALP:IZMAKSAT:SelectedFG LONG                ! Selected Foreground
BRW1::ALP:IZMAKSAT:SelectedBG LONG                ! Selected Background
BRW1::ALP:ACC_KODS     LIKE(ALP:ACC_KODS)         ! Queue Display field
BRW1::ALP:ACC_KODS:NormalFG LONG                  ! Normal Foreground
BRW1::ALP:ACC_KODS:NormalBG LONG                  ! Normal Background
BRW1::ALP:ACC_KODS:SelectedFG LONG                ! Selected Foreground
BRW1::ALP:ACC_KODS:SelectedBG LONG                ! Selected Background
BRW1::ALP:ACC_DATUMS   LIKE(ALP:ACC_DATUMS)       ! Queue Display field
BRW1::ALP:ACC_DATUMS:NormalFG LONG                ! Normal Foreground
BRW1::ALP:ACC_DATUMS:NormalBG LONG                ! Normal Background
BRW1::ALP:ACC_DATUMS:SelectedFG LONG              ! Selected Foreground
BRW1::ALP:ACC_DATUMS:SelectedBG LONG              ! Selected Background
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
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
QuickWindow          WINDOW('ALGPA.TPS'),AT(-1,-1,374,313),FONT('MS Sans Serif',10,,FONT:bold),IMM,HLP('BrowsePARSK'),SYSTEM,GRAY,RESIZE,MDI
                       MENUBAR
                         MENU('&1-Seanss'),USE(?1Seanss)
                           ITEM,SEPARATOR
                           ITEM('&4-Darba þurnâls'),USE(?4Darbaþurnâls)
                         END
                         MENU('&2-Serviss'),USE(?Serviss)
                           ITEM,SEPARATOR
                           ITEM('&2-Selftests'),USE(?ServissSelftests)
                           ITEM('&3-Importa interfeiss'),USE(?ServissImportainterfeiss)
                         END
                         MENU('&3-Sistçmas dati'),USE(?system)
                           ITEM('&3-Lokâlie dati'),USE(?SystemLokalieDati)
                         END
                         MENU('&4-Faili'),USE(?Faili)
                           ITEM('&1-Partneru saraksts'),USE(?4Faili1Partnerusaraksts),FIRST
                           ITEM('&9-Darba apmaksas un Ieturçjumu veidi'),USE(?BrowseDAIEV)
                           ITEM('&A-Kadri'),USE(?BrowseKADRIKadtabf),MSG('Kadri')
                           ITEM('&B-Amati'),USE(?BrowseTEKSTI),MSG('Browse TEKSTI')
                           ITEM('&C-Darba laika kalendârs'),USE(?BrowseDarbalaikakalendârs)
                           ITEM('&D-Atvaïinâjumi  un Slimîbas lapas'),USE(?BrowsePERNOS),MSG('Browse PERNOS')
                           ITEM('&E-Darba laika grafiks'),USE(?4Faili9IzziòasnofailiemBDarbalaikagrafiks)
                           ITEM('&E-Rîkojumi un Dokumenti'),USE(?4FailiERD)
                           ITEM,SEPARATOR
                           MENU('&Z-Izziòas no failiem'),USE(?4Faili9Izziòasnofailiem)
                             ITEM('&8-Kadru saraksts'),USE(?IZZKadrusaraksts)
                             ITEM('&9-Rîkojumu saraksts'),USE(?4FailiZIzziòasnofailiemERîkojumusaraksts)
                             ITEM('&Atvaïinâjumu saraksts'),USE(?9IzziòasnoDBItem34)
                             ITEM('&B-Slimîbas lapu saraksts'),USE(?4Faili9IzziòasnofailiemBSlimîbaslapusaraksts)
                             ITEM('&C-Darba laika grafiku saraksts'),USE(?5IzziòasnoDB6Darbalaikagrafiks)
                             ITEM('&Darba apmaksas un ieturçjumu veidi'),USE(?IZZDarbaapmaksasunieturçjumuveidi)
                           END
                         END
                         MENU('&5-Izziòas no DB'),USE(?IzziòasnoDB)
                           ITEM('&1-Maksâjumu protokols'),USE(?IZZMaksâjumuprotokols)
                           ITEM('&2-Daiev (Visi Daiev, VISI/GR/1 d.)'),USE(?IZZDaiev1)
                           ITEM('&3-Daiev (1 Daiev, VISI/GR/1 d.)'),USE(?IZZDaiev2)
                           ITEM('&4-Statistika'),USE(?IZZStatistika)
                           ITEM('&5-Iemaksas Priv. Pensiju Fondos'),USE(?5IzziòasnoDB5IemaksasPrivPensijuFondos)
                           ITEM('&6-Izziòa par darba algu'),USE(?5IzziòasnoDB6Izziòapardarbaalgu)
                         END
                         MENU('&6-Atskaites'),USE(?Atskaites)
                           ITEM('&1-Lielais algu saraksts'),USE(?AtskLielaisalgusaraksts)
                           ITEM('&2-Mazais algu saraksts'),USE(?AtskMazaisalgusaraksts)
                           ITEM('&3-Saraksts bankai'),USE(?AtskSarakstskrâjkasei)
                           ITEM('&4-Algu lapiòas'),USE(?AtskAlgulapiòas)
                           ITEM('&5-Avansu saraksts'),USE(?AtskAvansusaraksts)
                           ITEM('&6-Personîgie konti'),USE(?AtskPersonîgiekonti)
                           ITEM('&8-Pârskats par izm. vietâ ieturçto un budþetâ iesk. IIN (6.pielikums)'),USE(?6AtskaitesPârskatsparizmaksasvietaieturçtounbudþetâieskaitîtoI)
                           ITEM('&9-Paziòojums par FP izmaksâtajâm summâm (1)'),USE(?AtskPaziòojumsparalgasnodokli)
                           ITEM('1&0-Paziòojums par FP izm. summâm(kopsavilkums), jânodod lîdz 31.01 vai atlaiþot'),USE(?AtskaitesDarbadçvçjapaziòojumsparalgasnodokli)
                           ITEM('&A-Tabele'),USE(?AtskaitesTabele)
                           ITEM('&C-Ziòojums par VSAOI  no DN ienâkumiem un IIN'),USE(?6AtskaitesCZinVSAOIunIIN)
                           ITEM('&D-Ziòas par darba òçmçjiem (MKN 942), jânodod 3 dienu laikâ'),USE(?AtskZiòaspardarbaòçmçjiem3X)
                           ITEM('&E-Darba òçm. valsts soc. apdr. obl. iem. uzsk. kart.'),USE(?AtskaitesDarbaòçmvalstssocapdrobliemuzskkart)
                           ITEM('&F-Pârskats par nerezidentu IIN'),USE(?AtskaitesPârskatsparnerezidentuIIN)
                           ITEM('&G-Informâcija par nodokïa grâmatinâm.'),USE(?6AtskaitesGInformâcijaparnodokïagrâmatinâm)
                         END
                         MENU('&8-Speciâlâs funkcijas'),USE(?8Speciâlâsfunkcijas)
                           ITEM('&1-Atvçrt(aizvçrt) datu bloku'),USE(?8Speciâlâsfunkcijas1Atvçrtaizvçrtdatubloku)
                         END
                       END
                       LIST,AT(5,20,365,227),USE(?Browse:1),IMM,MSG('Browsing Records'),FORMAT('33C|M*~Mçn.Gads~@D014.B@131L(2)|M*~Tekoðais algu aprçíina stâvoklis~@s40@33R(1)|' &|
   'M*~Neapl.min~C(0)@n_7.2@41R(1)|M*~Apr.IIN~C(0)@n-11.2@41R(1)|M*~Iet.IIN~C(0)@n-1' &|
   '1.2@45R(1)|M*~Pârskaitîjums~C(0)@n12.2@43R(1)|M*~Izmaksai~C(0)@n-12.2@32C|M*~Bûv' &|
   'çja~@s8@40R(1)|M*~Datums~C(0)@D06.B@'),FROM(Queue:Browse:1)
                       BUTTON('&Dzçst'),AT(272,254,36,12),USE(?Delete:3)
                       BUTTON('&Uzbûvçt sarakstu'),AT(4,254,71,12),USE(?UZBUVET)
                       BUTTON('&Mainît sâkuma nosacîjumus'),AT(78,254,89,12),USE(?CHANGE)
                       SHEET,AT(0,3,371,248),USE(?CurrentTab)
                         TAB('Algu rçíins'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Beigt'),AT(314,254,40,12),USE(?Close)
                       BUTTON('&V - kor.'),AT(219,254,45,12),USE(?VKOR)
                       BUTTON('&H - kor.'),AT(171,254,45,12),USE(?HKOR),DEFAULT
                     END
SAV_RECORD  LIKE(ALP:RECORD)
SS_DAT LONG !07.07.2013
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    CHECKOPEN(GLOBAL,1)
    CHECKOPEN(SYSTEM,1)
    gads=GL:DB_GADS
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
   IF ATLAUTS[10]='1' !AIZLIEGTA DATU APMAIÒA UN IMPINT
     DISABLE(?ServissImportaInterfeiss)
   .
   IF ATLAUTS[17]='1' !AIZLIEGTS SELFTESTS
     DISABLE(?ServissSelftests)
   .
  ACCEPT
    QUICKWINDOW{PROP:TEXT}='Algu aprçíins '&CLIP(RECORDS(ALGPA))&' raksti '&CLIP(LONGpath())&'\ALGA'&CLIP(LOC_NR)&' Atvçrts no '&format(sys:gil_show,@d014.B)
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
    CASE ACCEPTED()
    OF ?4Darbaþurnâls
      DO SyncWindow
      START(DarbaZurnals,25000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?ServissSelftests
      DO SyncWindow
      OPCIJA='0100'
      IZZFILTSF
      IF GlobalResponse=RequestCompleted
          START(SelftestAlga,50000)
      END
    OF ?ServissImportainterfeiss
      DO SyncWindow
      BROWSEGG1 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?SystemLokalieDati
      DO SyncWindow
      GlobalRequest = ChangeRecord
      UpdateSystem 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili1Partnerusaraksts
      DO SyncWindow
      BrowsePAR_K 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseDAIEV
      DO SyncWindow
      BrowseDAIEV 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseKADRIKadtabf
      DO SyncWindow
      BrowseKadri 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseTEKSTI
      DO SyncWindow
      BrowseAmati 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowseDarbalaikakalendârs
      DO SyncWindow
      CAL 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?BrowsePERNOS
      DO SyncWindow
      BrowsePERNOS 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4Faili9IzziòasnofailiemBDarbalaikagrafiks
      DO SyncWindow
      BrowseGrafiks 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?4FailiERD
      OPCIJA_NR=0
      DO SyncWindow
      BrowseKAD_RIK 
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?IZZKadrusaraksts
      DO SyncWindow
      OPCIJA='010013000'
      !       123456789
      IZZFILTA
      IF GlobalResponse=RequestCompleted
          START(F_KADRUSAR,50000)
      END
    OF ?4FailiZIzziòasnofailiemERîkojumusaraksts
      DO SyncWindow
        OPCIJA='240000000'
      !         123456789  6-3WEA
        IZZFILTA
        IF GlobalResponse = RequestCompleted
               START(A_RIKOJUMI,50000)
        .
        SELECT(?BROWSE:1)
    OF ?9IzziòasnoDBItem34
      DO SyncWindow
        OPCIJA='10000000'
      !         12345678
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           F:DTK='A'
           START(A_AtvalSar,50000)
        .
    OF ?4Faili9IzziòasnofailiemBSlimîbaslapusaraksts
      DO SyncWindow
        OPCIJA='10000000'
      !         12345678
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           F:DTK='S'
           START(A_AtvalSar,50000)
        .
    OF ?5IzziòasnoDB6Darbalaikagrafiks
      DO SyncWindow
        OPCIJA='110002'
        IZZFILTA
        IF GlobalResponse = RequestCompleted
          START(F_GRAFIKS,50000)
        END
    OF ?IZZDarbaapmaksasunieturçjumuveidi
      DO SyncWindow
      START(A_IzzDAIEV,50000)
      LocalRequest = OriginalRequest
      DO RefreshWindow
    OF ?IZZMaksâjumuprotokols
      DO SyncWindow
        OPCIJA='110003000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
          START(A_MAKSPROT,50000)
        END
    OF ?IZZDaiev1
      DO SyncWindow
       S_DAT=DATE(MEN_NR,1,GADS)
       OPCIJA='111003000'
      !        123456789
       IZZFILTA
       IF GlobalResponse = RequestCompleted
          START(A_DAIEVPROT,50000)
       .
    OF ?IZZDaiev2
      DO SyncWindow
       GlobalRequest = SelectRecord
       BROWSEDAIEV
       IF GlobalResponse = RequestCompleted
         DAIKODS=DAI:KODS
         S_DAT=DATE(MEN_NR,1,GADS)
         OPCIJA='110003000'
      !          123456789
         IZZFILTA
         IF GlobalResponse = RequestCompleted
            IF ID
               START(A_DAIEVPROT2D,5000)
            ELSE
               START(A_DAIEVPROT2,50000)
            .
         END
       END
    OF ?IZZStatistika
      DO SyncWindow
        OPCIJA='100000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
          START(A_STAT,50000)
        END
    OF ?5IzziòasnoDB5IemaksasPrivPensijuFondos
      DO SyncWindow
        S_DAT=DATE(MEN_NR,1,GADS)
        OPCIJA='111003000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_IemaksasPPF,50000)
        END
    OF ?5IzziòasnoDB6Izziòapardarbaalgu
      DO SyncWindow
        globalrequest=SELECTRECORD
        BROWSEKADRI
        IF GlobalResponse = RequestCompleted
           ID=KAD:ID
           START(A_IzzinaparDA,50000)
        END
    OF ?AtskLielaisalgusaraksts
      DO SyncWindow
        OPCIJA='010433000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_SARAKSTSL,50000)
           IF SUMMA
              ALP:IZMAKSAT=SUMMA
              IF RIUPDATE:ALGPA()
                 KLUDA(24,'ALGPA.TPS')
              .
           .
        .
    OF ?AtskMazaisalgusaraksts
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_SARAKSTSM,50000)
        END
    OF ?AtskSarakstskrâjkasei
      DO SyncWindow
        OPCIJA='020300001'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_SARAKSTSK,50000)
        END
    OF ?AtskAlgulapiòas
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_ALGULAPINAS,50000)
        END
    OF ?AtskAvansusaraksts
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_SARAKSTSA,50000)
        END
    OF ?AtskPersonîgiekonti
      DO SyncWindow
      !OPCIJA='010003000'
       MEN_NR=19 !VISS GADS
       OPCIJA='111003000'
      !         123456789
       IZZFILTA
       IF GlobalResponse = RequestCompleted
          START(A_PERSKONT,50000)
       END
      
      
    OF ?6AtskaitesPârskatsparizmaksasvietaieturçtounbudþetâieskaitîtoI
      DO SyncWindow
        OPCIJA='010003000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
          IF YEAR(ALP:YYYYMM)>2008
             kluda(0,'kopð 2009.g. vairs nav jânodod',,1)
          ELSE
             START(A_NODPARS6,50000)
          .
        END
    OF ?AtskPaziòojumsparalgasnodokli
      DO SyncWindow
        OPCIJA='010023000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           IF YEAR(ALP:YYYYMM)>2008
              START(A_PAZ_FP1,50000)
           ELSE
              START(A_PAZ_ALNOD,50000)
           .
        .
    OF ?AtskaitesDarbadçvçjapaziòojumsparalgasnodokli
      DO SyncWindow
        OPCIJA='010520003'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           IF YEAR(ALP:YYYYMM)>2008
      !        STOP(FORMAT(ALP:YYYYMM,@D06.))
              START(A_PAZ_FPK,50000)
           ELSE
              START(A_PAZ_ALNODK,50000)
           .
        .
    OF ?AtskaitesTabele
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_TABELE,50000)
        END
      
    OF ?6AtskaitesCZinVSAOIunIIN
      DO SyncWindow
        OPCIJA='010243000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           IF YEAR(ALP:YYYYMM)>2010
              START(A_VSAOIIN_2010,50000)
           ELSIF YEAR(ALP:YYYYMM)>2008
              START(A_VSAOIIN_2009,50000)
           ELSE
              START(A_ZINSAUNIIN_969,50000)
           .
        END
    OF ?AtskZiòaspardarbaòçmçjiem3X
      DO SyncWindow
        S_DAT=ALP:YYYYMM
        B_DAT=DATE(MONTH(ALP:YYYYMM)+1,1,YEAR(ALP:YYYYMM))-1
        OPCIJA='000103100'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
      !     OPCIJA='120'
      !     IZZFILTGMC
      !     IF GlobalResponse = RequestCompleted
              !07.07.2013 <
              SS_DAT=DATE(MEN_NR,1,GADS)
              IF S_DAT >= DATE(07,1,2013)
                 START(A_DNKUS_2013,50000)
              !IF GADS>2008
              ELSIF GADS>2008
              !07.07.2013 >
                 START(A_DNKUS_2009,50000)
              ELSE
                 START(A_DNKUS,50000)
              .
      !     .
        .
    OF ?AtskaitesDarbaòçmvalstssocapdrobliemuzskkart
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_DSAK98,50000)
        END
      
    OF ?AtskaitesPârskatsparnerezidentuIIN
      DO SyncWindow
        OPCIJA='010000000'
      !         123456789
        IZZFILTA
        IF GlobalResponse = RequestCompleted
           START(A_PARSKNEIIN,50000)
        END
    OF ?6AtskaitesGInformâcijaparnodokïagrâmatinâm
      OPCIJA='010013000'
      !       123456789
      IZZFILTA
      IF GlobalResponse=RequestCompleted
          START(F_KadruSarArApg,50000)
      END
      
      DO SyncWindow
    OF ?8Speciâlâsfunkcijas1Atvçrtaizvçrtdatubloku
      DO SyncWindow
      EnterGIL_Show 
      LocalRequest = OriginalRequest
      DO RefreshWindow
      if GLOBALRESPONSE=requestcompleted
         checkopen(system,1)
         DO BRW1::InitializeBrowse
         DO BRW1::RefreshPage
         QUICKWINDOW{PROP:TEXT}='Algu aprçíins '&CLIP(RECORDS(ALGPA))&' raksti '&CLIP(LONGpath())&'\ALGA'&CLIP(LOC_NR)&' Atvçrts no '&format(sys:gil_show,@d014.B)
         DISPLAY
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
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        !DO BRW1::GetRecord
        !GlobalRequest = DeleteRecord
        !UpdateALPA
        !DO BRW1::RefreshPage
        !!SELECT(?LIST)
        !SELECT(?)
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?UZBUVET
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPCIJA='1200'
        !       1234
        IZZFILTGMC
        IF GlobalResponse = RequestCompleted
           BUVETALGAS
           BRW1::LocateMode = LocateOnEdit
           DO BRW1::LocateRecord
           SELECT(?Browse:1)
           POST(Event:NewSelection)
        END
      END
    OF ?CHANGE
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::GetRecord
        IF ALP:YYYYMM < SYS:GIL_SHOW  ! SLÇGTS APGABALS
           GlobalRequest=0
        ELSE
           GlobalRequest = ChangeRecord
        .
        UpdateALPA
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
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
    OF ?VKOR
      CASE EVENT()
      OF EVENT:Accepted
        SAV_RECORD=ALP:RECORD
        DO SyncWindow
        !DO BRW1::GetRecord
        GlobalRequest = SelectRecord
        BROWSEDAIEV
        IF GlobalResponse = RequestCompleted
           DAIKODS = DAI:KODS
           DAIF = DAI:F
           BROWSEALGAS_V
           IF ~(SAV_RECORD=ALP:RECORD)
               PUT(ALGPA)
           .
        .
      END
    OF ?HKOR
      CASE EVENT()
      OF EVENT:Accepted
        SAV_RECORD=ALP:RECORD
        DO SyncWindow
        BrowseALGAS
        IF ~(SAV_RECORD=ALP:RECORD)
           PUT(ALGPA)
           BRW1::RefreshMode = RefreshOnQueue
           DO BRW1::RefreshPage
           DO BRW1::InitializeBrowse
           DO BRW1::PostNewSelection
           LocalRequest = OriginalRequest
           LocalResponse = RequestCancelled
           DO RefreshWindow
        .
        SELECT(?Browse:1)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF ALGPA::Used = 0
    CheckOpen(ALGPA,1)
  END
  ALGPA::Used += 1
  BIND(ALP:RECORD)
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseALPA','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,254} = DeleteKey
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
    ALGPA::Used -= 1
    IF ALGPA::Used = 0 THEN CLOSE(ALGPA).
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
    INISaveWindow('BrowseALPA','winlats.INI')
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
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  ALP:YYYYMM = BRW1::ALP:YYYYMM
  ALP:STATUSS = BRW1::ALP:STATUSS
  ALP:MIA = BRW1::ALP:MIA
  ALP:APRIIN = BRW1::ALP:APRIIN
  ALP:IETIIN = BRW1::ALP:IETIIN
  ALP:PARSKAITIT = BRW1::ALP:PARSKAITIT
  ALP:IZMAKSAT = BRW1::ALP:IZMAKSAT
  ALP:ACC_KODS = BRW1::ALP:ACC_KODS
  ALP:ACC_DATUMS = BRW1::ALP:ACC_DATUMS
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
!|    If the field is colorized, the colors are computed and applied.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  APR = 0
  SAM = 0
  BRW1::ALP:YYYYMM = ALP:YYYYMM
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:YYYYMM:NormalFG = 8421504
    BRW1::ALP:YYYYMM:NormalBG = -1
    BRW1::ALP:YYYYMM:SelectedFG = -1
    BRW1::ALP:YYYYMM:SelectedBG = -1
  ELSE
    BRW1::ALP:YYYYMM:NormalFG = -1
    BRW1::ALP:YYYYMM:NormalBG = -1
    BRW1::ALP:YYYYMM:SelectedFG = -1
    BRW1::ALP:YYYYMM:SelectedBG = -1
  END
  BRW1::ALP:STATUSS = ALP:STATUSS
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:STATUSS:NormalFG = 8421504
    BRW1::ALP:STATUSS:NormalBG = -1
    BRW1::ALP:STATUSS:SelectedFG = -1
    BRW1::ALP:STATUSS:SelectedBG = -1
  ELSE
    BRW1::ALP:STATUSS:NormalFG = -1
    BRW1::ALP:STATUSS:NormalBG = -1
    BRW1::ALP:STATUSS:SelectedFG = -1
    BRW1::ALP:STATUSS:SelectedBG = -1
  END
  BRW1::ALP:MIA = ALP:MIA
  IF (ALP:YYYYMM<SYS:GIL_SHOW OR ALP:STAT=3)
    BRW1::ALP:MIA:NormalFG = 8421504
    BRW1::ALP:MIA:NormalBG = -1
    BRW1::ALP:MIA:SelectedFG = -1
    BRW1::ALP:MIA:SelectedBG = 12632256
  ELSE
    BRW1::ALP:MIA:NormalFG = -1
    BRW1::ALP:MIA:NormalBG = -1
    BRW1::ALP:MIA:SelectedFG = -1
    BRW1::ALP:MIA:SelectedBG = -1
  END
  BRW1::ALP:APRIIN = ALP:APRIIN
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:APRIIN:NormalFG = 8421504
    BRW1::ALP:APRIIN:NormalBG = -1
    BRW1::ALP:APRIIN:SelectedFG = -1
    BRW1::ALP:APRIIN:SelectedBG = -1
  ELSE
    BRW1::ALP:APRIIN:NormalFG = -1
    BRW1::ALP:APRIIN:NormalBG = -1
    BRW1::ALP:APRIIN:SelectedFG = -1
    BRW1::ALP:APRIIN:SelectedBG = -1
  END
  BRW1::ALP:IETIIN = ALP:IETIIN
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:IETIIN:NormalFG = 8421504
    BRW1::ALP:IETIIN:NormalBG = -1
    BRW1::ALP:IETIIN:SelectedFG = -1
    BRW1::ALP:IETIIN:SelectedBG = -1
  ELSE
    BRW1::ALP:IETIIN:NormalFG = -1
    BRW1::ALP:IETIIN:NormalBG = -1
    BRW1::ALP:IETIIN:SelectedFG = -1
    BRW1::ALP:IETIIN:SelectedBG = -1
  END
  BRW1::ALP:PARSKAITIT = ALP:PARSKAITIT
  IF (ALP:YYYYMM<SYS:GIL_SHOW OR ALP:STAT=3)
    BRW1::ALP:PARSKAITIT:NormalFG = 8421504
    BRW1::ALP:PARSKAITIT:NormalBG = -1
    BRW1::ALP:PARSKAITIT:SelectedFG = -1
    BRW1::ALP:PARSKAITIT:SelectedBG = 12632256
  ELSE
    BRW1::ALP:PARSKAITIT:NormalFG = -1
    BRW1::ALP:PARSKAITIT:NormalBG = -1
    BRW1::ALP:PARSKAITIT:SelectedFG = -1
    BRW1::ALP:PARSKAITIT:SelectedBG = -1
  END
  BRW1::ALP:IZMAKSAT = ALP:IZMAKSAT
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:IZMAKSAT:NormalFG = 8421504
    BRW1::ALP:IZMAKSAT:NormalBG = -1
    BRW1::ALP:IZMAKSAT:SelectedFG = -1
    BRW1::ALP:IZMAKSAT:SelectedBG = -1
  ELSE
    BRW1::ALP:IZMAKSAT:NormalFG = -1
    BRW1::ALP:IZMAKSAT:NormalBG = -1
    BRW1::ALP:IZMAKSAT:SelectedFG = -1
    BRW1::ALP:IZMAKSAT:SelectedBG = -1
  END
  BRW1::ALP:ACC_KODS = ALP:ACC_KODS
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:ACC_KODS:NormalFG = 8421504
    BRW1::ALP:ACC_KODS:NormalBG = -1
    BRW1::ALP:ACC_KODS:SelectedFG = -1
    BRW1::ALP:ACC_KODS:SelectedBG = -1
  ELSE
    BRW1::ALP:ACC_KODS:NormalFG = -1
    BRW1::ALP:ACC_KODS:NormalBG = -1
    BRW1::ALP:ACC_KODS:SelectedFG = -1
    BRW1::ALP:ACC_KODS:SelectedBG = -1
  END
  BRW1::ALP:ACC_DATUMS = ALP:ACC_DATUMS
  IF (ALP:YYYYMM<SYS:GIL_SHOW)
    BRW1::ALP:ACC_DATUMS:NormalFG = 8421504
    BRW1::ALP:ACC_DATUMS:NormalBG = -1
    BRW1::ALP:ACC_DATUMS:SelectedFG = -1
    BRW1::ALP:ACC_DATUMS:SelectedBG = -1
  ELSE
    BRW1::ALP:ACC_DATUMS:NormalFG = -1
    BRW1::ALP:ACC_DATUMS:NormalBG = -1
    BRW1::ALP:ACC_DATUMS:SelectedFG = -1
    BRW1::ALP:ACC_DATUMS:SelectedBG = -1
  END
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
        BRW1::PopupText = '&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Delete:3)
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
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
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(ALP:YYYYMM,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(ALP:YYYYMM,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            ALP:YYYYMM = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
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
        StandardWarning(Warn:RecordFetchError,'ALGPA')
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
      BRW1::HighlightedPosition = POSITION(ALP:YYYYMM_KEY)
      RESET(ALP:YYYYMM_KEY,BRW1::HighlightedPosition)
    ELSE
      SET(ALP:YYYYMM_KEY,ALP:YYYYMM_KEY)
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
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(ALP:Record)
    BRW1::CurrentChoice = 0
      IF RECORDS(ALGPA)=0
         KLUDA(0,'Jâuzbûvç sâkuma nosacîjumi...')
         OPCIJA='12'
         IZZFILTGMC
         IF GlobalResponse = RequestCompleted
            BUVETALGAS
            DO BRW1::REFRESHPAGE
         .
      ELSE
         !AIZVÇRTS APGABALS
      .
      DISPLAY
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
    SET(ALP:YYYYMM_KEY)
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
  BrowseButtons.ChangeButton=0
  BrowseButtons.DeleteButton=?Delete:3
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
    WriteZurnals(1,0,'DZÇÐU ALGU SARAKSTU PAR '&FORMAT(ALP:YYYYMM,@D13))
  .
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
!| (UpdateALPA) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF ALP:YYYYMM < SYS:GIL_SHOW and (LOCALREQUEST=3 OR LOCALREQUEST=2) ! SLÇGTS APGABALS
     LOCALREQUEST=0
  .
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[JOB_NR+39]) !39+65=104-SÂKAS ALGA_ACC
     BEGIN
        GlobalResponse = RequestCancelled
        EXIT
     .
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateALPA
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
        GET(ALGPA,0)
        CLEAR(ALP:Record,0)
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


