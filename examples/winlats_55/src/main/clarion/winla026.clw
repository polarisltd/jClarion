                     MEMBER('winlats.clw')        ! This is a MEMBER module
VestureBuilder PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RAKSTI               USHORT
window               WINDOW('231..,531.. vçstures bûvçðana'),AT(,,320,79),CENTER,GRAY
                       STRING('Tiks uzbûvçta tabula norçíiniem dokumentu lîmenî pa 231..,531..kontiem un pierak' &|
   'stîta'),AT(6,20,306,10),USE(?String1),CENTER
                       STRING('(pârrakstîta)  klât esoðajam Vçstures failam. Vçsturi ieteicams bûvçt, kad visi ' &|
   'tekoðâ gada'),AT(12,28),USE(?String2)
                       STRING('dokumenti ir pilnîgâ kârtîbâ un pçc tam pârkopçt (no Darba izvçles loga: 2-Servi' &|
   'ss,3-Jaunas'),AT(15,37),USE(?String3)
                       STRING('DB izveidoðana,atzîmçjam tikai Bâze:Pârkopçt norçíinu vçsturi, OK).'),AT(15,46),USE(?String3:2)
                       BUTTON('&OK'),AT(242,59,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(279,59,36,14),USE(?CancelButton)
                     END
SAV_POSITION         STRING(260)
SAV_PAR_NR           LIKE(PAR_NR)
izlaisti             USHORT
MAINITI              USHORT
JAUNI                USHORT
STRINGRAKSTI         STRING(40)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE

ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(@S35),AT(0,30,141,10),USE(STRINGRAKSTI),CENTER
       BUTTON('Pârtraukt'),AT(45,42,50,15),USE(?Progress:Cancel)
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
      SELECT(?String1)
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
        ! CLOSE(VESTURE)
        ! OPEN(VESTURE,22h)
        ! IF ERROR()
        !    KLUDA(1,'Vçsture')
        !    do procedurereturn
        ! .
        
         OPEN(ProgressWindow)
         Progress:Thermometer = 0
         ProgressWindow{Prop:Text} = 'Bûvçjam vçsturi 231..'
         ?Progress:UserString{Prop:Text}=''
         RecordsToProcess = RECORDS(GGK)
         RecordsPerCycle = 25
         RecordsProcessed = 0
         PercentProgress = 0
         DISPLAY()
        
         IZLAISTI=0
         MAINITI=0
         JAUNI=0
        
         clear(GGK:record)
         GGK:PAR_NR=51         !PIRMIE 50 MÛS NEINTERESÇ
         set(GGK:PAR_KEY,GGK:PAR_KEY)
         SEND(GGK,'QUICKSCAN=on')
         LOOP
            NEXT(GGK)
            IF ERROR() THEN BREAK.
            npk#+=1
            ?Progress:UserString{Prop:Text}=npk#
            RecordsProcessed += 1
            RecordsThisCycle += 1
            IF PercentProgress < 100
              PercentProgress = (RecordsProcessed / RecordsToProcess)*100
              IF PercentProgress > 100
                PercentProgress = 100
              END
              IF PercentProgress <> Progress:Thermometer THEN
                Progress:Thermometer = PercentProgress
              END
            END
            DISPLAY()
            IF ~(ggk:bkk[1:3]='231' AND ggk:d_k='D') THEN CYCLE.
            IF ~(SAV_PAR_NR=GGK:PAR_NR)  !MAINÎJIES PARTNERIS
               SAV_PAR_NR=GGK:PAR_NR
        !-------------------------------------------------------
               SAV_POSITION=POSITION(GGK:PAR_KEY)
               KKK='231'
               D_K='K'
               C#=PerfAtable(1,0,'','',GGK:PAR_NR,'',0,0,'',0)     ! Uzbûvç apmaksu A-table
               RESET(GGK:PAR_KEY,SAV_POSITION)
               NEXT(GGK)
        !-------------------------------------------------------
            .
            DO ADDVESTURE
            STRINGRAKSTI='Izl= '&CLIP(izlaisti)&' Mainîti= '&CLIP(MAINITI)&' Jauni= '&CLIP(JAUNI)
            DISPLAY(?STRINGRAKSTI)
         .
         Progress:Thermometer = 0
         ProgressWindow{Prop:Text} = 'Bûvçjam vçsturi 531..'
         ?Progress:UserString{Prop:Text}=''
         RecordsToProcess = RECORDS(GGK)
         RecordsPerCycle = 25
         RecordsProcessed = 0
         PercentProgress = 0
         DISPLAY()
        
         clear(GGK:record)
         GGK:PAR_NR=51         !PIRMIE 50 MÛS NEINTERESÇ
         set(GGK:PAR_KEY,GGK:PAR_KEY)
         LOOP
            NEXT(GGK)
            IF ERROR() THEN BREAK.
            npk#+=1
            ?Progress:UserString{Prop:Text}=npk#
            RecordsProcessed += 1
            RecordsThisCycle += 1
            IF PercentProgress < 100
              PercentProgress = (RecordsProcessed / RecordsToProcess)*100
              IF PercentProgress > 100
                PercentProgress = 100
              END
              IF PercentProgress <> Progress:Thermometer THEN
                Progress:Thermometer = PercentProgress
                DISPLAY()
              END
            END
            IF ~(ggk:bkk[1:3]='531' AND ggk:d_k='K') THEN CYCLE.
            IF ~(SAV_PAR_NR=GGK:PAR_NR)  !MAINÎJIES PARTNERIS
               SAV_PAR_NR=GGK:PAR_NR
        !-------------------------------------------------------
               SAV_POSITION=POSITION(GGK:PAR_KEY)
               KKK='531'
               D_K='D'
               C#=PerfAtable(1,0,'','',GGK:PAR_NR,'',0,0,'',0)     ! Uzbûvç apmaksu A-table
               RESET(GGK:PAR_KEY,SAV_POSITION)
               NEXT(GGK)
        !-------------------------------------------------------
            .
            DO ADDVESTURE
            STRINGRAKSTI='Izl= '&CLIP(izlaisti)&' Mainîti= '&CLIP(MAINITI)&' Jauni= '&CLIP(JAUNI)
            DISPLAY(?STRINGRAKSTI)
         .
        ! ?Progress:UserString{Prop:Text}='Bûvçju atslçgas'
        ! display()
        ! BUILD(VESTURE)
         CHECKOPEN(SYSTEM,1)
         IF ~BAND(SYS:CONTROL_BYTE,00000100B) !NAV BÛVÇTA VÇSTURE
            SYS:CONTROL_BYTE+=4
            PUT(SYSTEM)
         .
         CLOSE(ProgressWindow)
         BREAK
        
        
      END
    OF ?CancelButton
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
  IF GG::Used = 0
    CheckOpen(GG,1)
  END
  GG::Used += 1
  BIND(GG:RECORD)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  IF VESTURE::Used = 0
    CheckOpen(VESTURE,1)
  END
  VESTURE::Used += 1
  BIND(VES:RECORD)
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
    GG::Used -= 1
    IF GG::Used = 0 THEN CLOSE(GG).
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
    VESTURE::Used -= 1
    IF VESTURE::Used = 0 THEN CLOSE(VESTURE).
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
ADDVESTURE ROUTINE

! 23100/53100 Pieliek apmaksu, ja pats dokuments jau ir, vai
! uzbûvç visu, ja nav
!
    G#=GETGG(GGK:U_NR)

    CLEAR(VES:RECORD)
    VES:PAR_NR=GGK:PAR_NR
    VES:DOK_SENR=GG:DOK_SENR
    GET(VESTURE,VES:REF_KEY)   !KEY(VES:PAR_NR,VES:DOK_SENR)
    IF ~ERROR() AND (YEAR(VES:DATUMS)=YEAR(GG:DATUMS))   !VISDRÎZÂK, KA TÂDS RAKSTS JAU IR
       IF VES:DOK_SENR=GG:DOK_SENR AND|
          VES:RS=GG:RS AND|
          VES:APMDAT=GG:APMDAT AND|
          VES:DOKDAT=GG:DOKDAT AND|
          VES:DATUMS=GG:DATUMS AND|
          VES:PAR_NR=GGK:PAR_NR AND|
          VES:SUMMA=GGK:SUMMAV AND|
          VES:Atlaide=GG:ATLAIDE AND|
          VES:VAL=GGK:VAL AND|
          VES:D_K_KONTS=GGK:BKK AND|
          VES:Samaksats=PerfAtable(2,GG:DOK_SENR,'','',GGK:PAR_NR,'',0,0,'',0) AND|
          VES:Sam_VAL=VAL_NOS AND|
          VES:Sam_datums=PERIODS
          IZLAISTI+=1
       ELSE
!          VES:DOK_SENR=GG:DOK_SENR
          VES:RS=GG:RS
          VES:APMDAT=GG:APMDAT
          VES:DOKDAT=GG:DOKDAT
          VES:DATUMS=GG:DATUMS
!          VES:PAR_NR=GGK:PAR_NR
          IF ~VES:SATURS
             VES:SATURS =GG:SATURS
             VES:SATURS2=GG:SATURS2
             VES:SATURS3=GG:SATURS3
          .
          VES:SUMMA=GGK:SUMMAV
          VES:Atlaide=GG:ATLAIDE
          VES:VAL=GGK:VAL
          VES:D_K_KONTS=GGK:BKK
          VES:Samaksats=PerfAtable(2,GG:DOK_SENR,'','',GGK:PAR_NR,'',0,0,'',0)
          VES:Sam_VAL=VAL_NOS
          VES:Sam_datums=PERIODS
          VES:ACC_DATUMS=today()
          VES:ACC_KODS=ACC_kods
          IF RIUPDATE:vesture()
             KLUDA(24,'Vesture')
          .
          MAINITI+=1
       .
    ELSE
       CLEAR(VES:RECORD)
       VES:RS=GG:RS
       VES:DOK_SENR=GG:DOK_SENR
       VES:APMDAT=GG:APMDAT
       VES:DOKDAT=GG:DOKDAT
       VES:DATUMS=GG:DATUMS
       VES:PAR_NR=GGK:PAR_NR
       VES:SATURS=GG:SATURS
       VES:SATURS2=GG:SATURS2
       VES:SATURS3=GG:SATURS3
       VES:SUMMA=GGK:SUMMAV
       VES:Atlaide=GG:ATLAIDE
       VES:VAL=GGK:VAL
       VES:D_K_KONTS=GGK:BKK
       VES:Samaksats=PerfAtable(2,GG:DOK_SENR,'','',GGK:PAR_NR,'',0,0,'',0)
       VES:Sam_VAL=VAL_NOS
       VES:Sam_datums=PERIODS
       VES:ACC_DATUMS=today()
       VES:ACC_KODS=ACC_kods
       ADD(vesture)
       JAUNI+=1
    .
gl_cont PROCEDURE(OPC)


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
MOD_DAT              LONG
REG_DAT              LONG
LICENCES             STRING(40)
WL                   STRING(30)
HARD_CHECK    STRING(6)
CLIENT_CHECK  STRING(6)
REG_DRAZA     STRING(480)
REG_CL_SK     BYTE
DRAZA         STRING(6)
DS_DRAZA      STRING(6)
MODULIS       STRING(15)

soundfile     CSTRING(80)
R             USHORT,DIM(500)
N             STRING(3),DIM(500)
A             STRING(500)
!
REG_NR        USHORT
INI           STRING(80),DIM(10)
LINI          STRING(80),DIM(10)
CHECK_CLIENT  STRING(45)

INIINFO WINDOW(' '),AT(,,331,129),CENTER,GRAY
       STRING(@s80),AT(5,20,323,10),USE(INI[1])
       STRING(@s80),AT(5,29,323,10),USE(INI[2])
       STRING(@s80),AT(5,38,323,10),USE(INI[3])
       STRING(@s80),AT(5,47,323,10),USE(INI[4])
       STRING(@s80),AT(5,56,323,10),USE(INI[5])
       STRING(@s80),AT(5,65,323,10),USE(INI[6])
       STRING(@s80),AT(5,74,323,10),USE(INI[7])
       STRING(@s80),AT(5,83,323,10),USE(INI[8])
       BUTTON('OK'),AT(286,104,35,14),USE(?OkINI),DEFAULT
     END

LINIINFO WINDOW('C:\WINLATS\WinLatsC.ini'),AT(,,331,129),CENTER,GRAY
       STRING(@s80),AT(5,20,323,10),USE(LINI[1])
       STRING(@s80),AT(5,29,323,10),USE(LINI[2])
       STRING(@s80),AT(5,38,323,10),USE(LINI[3])
       STRING(@s80),AT(5,47,323,10),USE(LINI[4])
       STRING(@s80),AT(5,56,323,10),USE(LINI[5])
       STRING(@s80),AT(5,65,323,10),USE(LINI[6])
       STRING(@s80),AT(5,74,323,10),USE(LINI[7])
       STRING(@s80),AT(5,83,323,10),USE(LINI[8])
       BUTTON('OK'),AT(286,104,35,14),USE(?OkINIC),DEFAULT
     END


IMAGEWINDOW WINDOW('WINLATS (c)ASSAKO'),ICON('CLARION.ICO'),STATUS(-1,90,70),SYSTEM,GRAY,MAX,MAXIMIZE, |
         RESIZE
     END

REG                  FILE,DRIVER('TOPSPEED'),OWNER('VIJA'),ENCRYPT,NAME('REG.KEY'),PRE(REG),CREATE,BINDABLE,THREAD
Record                   RECORD,PRE()
CLIENT                      STRING(45)
KEY                         BYTE
REG_NR                      USHORT
REG_DATUMS                  LONG
GNET                        BYTE
CL_SK_B                     BYTE
BASE_SK                     BYTE
BASE_ACC_BYTE               BYTE
DRAZA_B                     STRING(480)
CL_SK_N                     BYTE
NOL_SK                      BYTE
NOL_ACC_BYTE                BYTE
DRAZA_N                     STRING(480)
CL_SK_FP                    BYTE
FP_SK                       BYTE
DRAZA_FP                    STRING(480)
CL_SK_A                     BYTE
ALGU_SK                     BYTE
DRAZA_A                     STRING(480)
CL_SK_P                     BYTE
PAM_SK                      BYTE
DRAZA_P                     STRING(480)
CL_SK_LM                    BYTE
LM_SK                       BYTE
DRAZA_LM                    STRING(480)
reg_v                       STRING(1)
BAITS1                      BYTE
BAITS2                      BYTE
                         END
                       END

window               WINDOW('Lietotâja identifikâcija'),AT(20,120,284,175),FONT('MS Sans Serif',11,,FONT:bold),COLOR(COLOR:White),ALRT(F12Key),GRAY
                       STRING(@s30),AT(81,12,117,10),USE(WL),TRN,CENTER,FONT(,,COLOR:Gray,)
                       IMAGE('start.jpg'),AT(-13,0,297,83),USE(?Image3)
                       STRING(@s45),AT(76,143,164,10),USE(CLIENT),LEFT(1),FONT(,12,COLOR:Navy,FONT:bold,CHARSET:ANSI)
                       STRING('Licences îpaðnieks :'),AT(4,143),USE(?String6),FONT(,12,COLOR:Navy,,CHARSET:ANSI)
                       STRING('Licences Nr :'),AT(4,158),USE(?String5),FONT(,12,COLOR:Navy,,CHARSET:ANSI)
                       STRING(@n4),AT(52,158),USE(CL_NR),FONT(,12,,,CHARSET:ANSI)
                       STRING(@s40),AT(76,158,100,10),USE(LICENCES),LEFT,FONT(,,COLOR:Gray,)
                       ENTRY(@s8),AT(5,97,106,12),USE(ACC_KODS),LEFT(3),OVR,UPR,PASSWORD
                       ENTRY(@s8),AT(114,97,43,12),USE(ACC_KODS,,?ACC_KODS:2),HIDE,LEFT(3),OVR,UPR
                       STRING('Versija : 3.03'),AT(163,85,65,10),USE(?StringVersija),FONT(,12,COLOR:Gray,FONT:bold)
                       STRING('Pçdçjâs izmaiòas :  '),AT(163,98,67,10),USE(?String8),FONT(,12,COLOR:Gray,)
                       STRING(@D06.),AT(232,98),USE(MOD_DAT ),FONT(,12,COLOR:Gray,)
                       STRING('Parole :'),AT(4,85,38,10),USE(?String2),LEFT,FONT(,12,COLOR:Navy,FONT:bold,CHARSET:ANSI)
                       BUTTON('&OK'),AT(5,114,51,14),USE(?OK),FONT(,12,COLOR:Navy,,CHARSET:ANSI),DEFAULT
                       BUTTON('Atlikt'),AT(60,114,51,14),USE(?ATLIKT),FONT(,12,COLOR:Navy,,CHARSET:ANSI)
                       STRING('(C) ASSAKO SMART'),AT(163,113,60,9),USE(?String7),FONT(,8,COLOR:Gray,)
                       BUTTON('Winlats.ini'),AT(180,154),USE(?ButtonIni),FONT(,12,COLOR:Navy,,CHARSET:ANSI)
                       BUTTON('WinlatsC.ini'),AT(230,154,49,16),USE(?ButtonIniC),FONT(,12,COLOR:Navy,,CHARSET:ANSI)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    EXECUTE OPCIJA_NR
       WL='WinLats.32 bitu versija'                   !PROGRAMMAS VÂRDS
       WL='WinLats.POS.32 bitu versija'               !PROGRAMMAS VÂRDS
       WL='WinLats.LM.32 bitu versija'                !PROGRAMMAS VÂRDS
    .
    EXECUTE OPCIJA_NR
       MOD_DAT=DOS_CONT('\WINLATS\BIN\WINLATS.EXE',1) !PROGRAMMAS DATUMS
       MOD_DAT=DOS_CONT('\WINLATS\BIN\FP.EXE',1)      !PROGRAMMAS DATUMS
       MOD_DAT=DOS_CONT('\WINLATS\BIN\AU.EXE',1)      !PROGRAMMAS DATUMS
    .
    CHECKOPEN(REG,1)  !%%%% ignoring
    SET(REG)          !%%%% ignoring
    NEXT(REG)         !%%%% ignoring
    if records(reg)=0 !%%%% ignoring
                      !%%%% notice that reg.key has been created in same directory as executable so admin can update
       kluda(80,' REG0 ' & LONGPATH())   !%%%% ignoring
       DO PROCEDURERETURN     !%%%% ignoring
    .                         !%%%% ignoring
    F:CEN=REG:REG_V
    OPC = false          !%%%% ignoring
    IF OPC
       IF ACC_KODS_N
  !*************** CHECK CLIENT WORKSTATION ACCESS *************************
          HARD_CHECK=format(DOS_CONT('C:\WINDOWS\REGEDIT.EXE',1),@d11) !ÐITÂ BIJA SLIKTA IDEJA !!!
          CLIENT_CHECK=client[5:10]
          LOOP I#=1 TO 6
             VALUE#=VAL(HARD_CHECK[I#])+VAL(CLIENT_CHECK[I#])
             IF VALUE# < 256
                DRAZA[I#]=CHR(VALUE#)
             ELSE
                DRAZA[I#]=HARD_CHECK[I#]
             .
          .
          IF ~(REG:KEY=3) !PIEÒEMAM, KA TÂDS CIPARS VÇSTURISKI NEVAR BÛT
             REG:DRAZA_B=''
             REG:DRAZA_N=''
             REG:DRAZA_FP=''
             REG:DRAZA_A=''
             REG:DRAZA_P=''
             REG:DRAZA_LM=''
             REG:KEY=3
          .
          EXECUTE OPC
             MODULIS='Bâze'
             MODULIS='Noliktava'
             MODULIS='Fiskâlâ druka'
             MODULIS='Alga'
             MODULIS='Pamatlîdzekïi'
             MODULIS='Laika maðîna'
          .
          EXECUTE OPC
             REG_DRAZA=REG:DRAZA_B
             REG_DRAZA=REG:DRAZA_N
             REG_DRAZA=REG:DRAZA_FP
             REG_DRAZA=REG:DRAZA_A
             REG_DRAZA=REG:DRAZA_P
             REG_DRAZA=REG:DRAZA_LM
          .
          EXECUTE OPC
             REG_CL_SK=REG:CL_SK_B
             REG_CL_SK=REG:CL_SK_N
             REG_CL_SK=REG:CL_SK_FP
             REG_CL_SK=REG:CL_SK_A
             REG_CL_SK=REG:CL_SK_P
             REG_CL_SK=REG:CL_SK_LM
          .
          LOOP I#= 1 TO REG_CL_SK
             DS_DRAZA=REG_DRAZA[(I#-1)*6+1:(I#-1)*6+6]
             IF DS_DRAZA = DRAZA
                BREAK
             ELSIF DS_DRAZA=''
                kluda(81,clip(i#)&' no '&clip(REG_cl_sk),,1)
                IF KLU_DARBIBA
                   EXECUTE OPC
                      REG:DRAZA_B[(I#-1)*6+1:(I#-1)*6+6] = DRAZA  !1
                      REG:DRAZA_N[(I#-1)*6+1:(I#-1)*6+6] = DRAZA  !2
                      REG:DRAZA_FP[(I#-1)*6+1:(I#-1)*6+6]= DRAZA  !3
                      REG:DRAZA_A[(I#-1)*6+1:(I#-1)*6+6] = DRAZA  !4
                      REG:DRAZA_P[(I#-1)*6+1:(I#-1)*6+6] = DRAZA  !5
                      REG:DRAZA_LM[(I#-1)*6+1:(I#-1)*6+6]= DRAZA  !6
                   .
                   PUT(REG)
                   BREAK
                ELSE
                   LOCALRESPONSE=REQUESTCANCELLED
                   DO PROCEDURERETURN
                .
             .
          .
          IF I#>REG_CL_SK            !NEREÌISTRÇTA DARBA STACIJA
              KLUDA(0,'Nereìistrçta darba stacija modulim '&clip(MODULIS)&' t.67518058,29234246,29412600')
!              LOCALRESPONSE=REQUESTCANCELLED  - LAI NEPAZAUDÇTU KLIENTUS VISPÂR.....
!              DO PROCEDURERETURN
          .
       .
       LOCALRESPONSE=REQUESTCOMPLETED
       DO PROCEDURERETURN
    ELSE
       OPEN(IMAGEWINDOW)
       display
       GETPOSITION(0,X#,Y#,W#,H#)
       IMAGE(X#,Y#,W#,H#,'START.BMP')
       SoundFile='\WINLATS\BIN\CAO.wav'
       sndPlaySoundA(SoundFile,1)
       CLEAR(GlobalRequest)
       CLEAR(GlobalResponse)
  
       CLIENT      = REG:CLIENT
       CL_NR       = REG:REG_NR
       GNET        = REG:GNET
       BASE_SK     = REG:BASE_SK
       NOL_SK      = REG:NOL_SK
       FP_SK       = REG:FP_SK
       ALGU_SK     = REG:ALGU_SK
       PAM_SK      = REG:PAM_SK
       LM_SK       = REG:LM_SK
       REG_NOL_ACC = REG:NOL_ACC_BYTE
       REG_BASE_ACC= REG:BASE_ACC_BYTE

     ! ÈEKOJAM ATVÇRTO LICENCI
     !  INCLUDE('REGSTR.REG') %%%%%% removing REGSTR
       LOOP I#=1 TO 500 !500 MAX ATÏAUTO KLIENTU SKAITS
          REG_NR=R[I#]
          IF REG_NR=0 THEN BREAK.
          IF REG:REG_NR=REG_NR AND A[I#]='A' AND ~(F:CEN=9) !AUDITORI & NAV NRD
             LICENCES='Atvçrtâ'
             BREAK
          .
       .
     ! LASAM INI FAILU
       LOOP I#=1 TO 10
          INI[I#]=GETINIFILE(I#,0)
          IF ~INI[I#] THEN BREAK.
       .
     ! LASAM LOKÂLO INI FAILU
       LOOP I#=1 TO 10
          LINI[I#]=GETINIFILE(I#,1)
          IF ~LINI[I#] THEN BREAK.
       .
    .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF GNET
    WINDOW{PROP:TEXT}='WINLATS:Global net Client'
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      !!IF KEYCODE()=F12KEY
         UNHIDE(?ACC_KODS:2)
         SELECT(?ACC_KODS:2)
         HIDE(?ACC_KODS)
         BEEP
         DISPLAY     !%%% commented
      !!.
      
             ACC_KODS='F12'  !%%% uncommented
             ACC_KODS_N=1    !%%% uncommented
             LOCALRESPONSE=REQUESTCOMPLETED   !%%% uncommented
             ATLAUTS='1'&'0{113}'   !%%% uncommented
             JOB_NR=1               !%%% uncommented
             DO CUTEATLAUTS         !%%% uncommented
             ATLAUTS[1] = '1'       !%%% 
             ATLAUTS[40] = '1'      !%%%  BASE
             ATLAUTS[55] = '1'      !%%%  NOLIKT
              ATLAUTS[80] = '1'      !%%% FP
             ATLAUTS[105] = '1'      !%%% ALGA
             ATLAUTS[120] = '1'      !%%% PAM
             ATLAUTS[135] = '1'      !%%% LM
      
             DO PROCEDURERETURN     !%%% uncommented
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?WL)
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
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF ~OPC !NETIEK PÂRBAUDÎTA NELICENZÇTA darba stacija
            IF ACC_KODS=' MAY'
        !**************** ASSAKO *************************
               ACC_KODS='LATS'
               ACC_KODS_N=0
               CLIENT='SIA "ASSAKO SMART"'
               LOCALRESPONSE=REQUESTCOMPLETED
               ATLAUTS='1'&'0{159}' !SUPERACC & PILNA PIEEJA VISUR
               JOB_NR=1
               DO CUTEATLAUTS
               DO PROCEDURERETURN
        
            ELSE
        !**************** REAL MODE *************************
               CHECKOPEN(PAROLES,1)
               CLEAR(SEC:RECORD)
               SEC:SECURE=ACC_KODS
               GET(PAROLES,SEC:SECURE_KEY)
               IF ~ERROR()
                  ACC_KODS=SEC:PUBLISH   !PIEÐÍIRAM PUBLISKO DAÏU PRIEKÐ UZSKAITES
                  ACC_KODS_N=SEC:U_NR    !ATCERAMIES ACCESS KODA NR
                  JOB_NR=SEC:START_NR
        !          IF SEC:DUP_ACC
        !             KLUDA(75,'')
        !          ELSE
        !             SEC:DUP_ACC=1
        !             PUT(PAROLES)
        !          .
                  LOCALRESPONSE=REQUESTCOMPLETED
               .
            .
            IF ~(LOCALRESPONSE=REQUESTCOMPLETED)
               soundfile='\WINLATS\BIN\Jungle Question.wav'
               sndPlaySoundA(soundfile,1)
               J#+=1
               IF J#<5
                 select(?ACC_kods)
                 CYCLE
               ELSE
                 LOCALRESPONSE=REQUESTCANCELLED
                 DO PROCEDURERETURN
               .
            ELSE
        !**************** CHECK DEMO AND ILLEGAL CLIENT *************************
               IF CLIENT='*DEMO*' AND TODAY()-mod_dat > 60
                   KLUDA(45,' Jûsu laiks beidzies')
                   LOCALRESPONSE=REQUESTCANCELLED
               ELSIF CLIENT='*DEMO*' AND TODAY()-mod_dat <= 60
                   KLUDA(45,' DEMO versija, atlikuðas '& 60-(TODAY()-mod_dat)&' dienas')
                   LOCALRESPONSE=REQUESTCOMPLETED
               ELSE
                   LOCALRESPONSE=REQUESTCOMPLETED  !%%% we will assume user is authentificated if password fits!
                   DO CUTEATLAUTS                  !%%%
                   DO PROCEDURERETURN              !%%%




                  LOCALRESPONSE=REQUESTCANCELLED
                  LOOP I#=1 TO 500 !500-MAX KLIENTU SKAITS
                     REG_NR=R[I#]
                     IF REG_NR=0
                        BREAK
                     .
                     CHECK_CLIENT=INIGEN(CLIENT,45,4)                                                 !NELATVIEÐU LIELIE
!                     IF REG:REG_NR=REG_NR
!                        STOP(N[I#]&' '&CHECK_CLIENT)
!                     .
                     IF (REG:REG_NR=REG_NR AND INSTRING(N[I#],CHECK_CLIENT,1,1)) OR|                  !N=NOS_S[1:3]
                     (REG_NR<202 AND REG:REG_NR=REG_NR+1000 AND INSTRING(N[I#],CHECK_CLIENT,1,1)) OR| !VECIE DOSA KLIENTI
                     (REG:REG_NR=REG_NR AND A[I#]='A') !AND ~(F:CEN=9))                                 !AUDITORI & NAV NRD
                        LOCALRESPONSE=REQUESTCOMPLETED
                        BREAK
                     .
                  .
                  IF LOCALRESPONSE=REQUESTCANCELLED
                     CLIENT='*DEMO*'
                     stop('!!!!!!!!!!!!')
                     KLUDA(2,' t.67518058,29234246,29412600')
        !             DO PROCEDURERETURN
                     LOCALRESPONSE=REQUESTCOMPLETED  !PAGAIDÂM
                  .
               .
        !**************** TYPE CLIENT ACCESS LEVEL_S*******************
               ATLAUTS=SEC:SUPER_ACC&SEC:FILES_ACC&SEC:SPEC_ACC&SEC:BASE_ACC&SEC:NOL_ACC&SEC:FP_ACC&SEC:ALGA_ACC&|
               SEC:PAM_ACC&SEC:LM_ACC
               DO CUTEATLAUTS
               DO PROCEDURERETURN
            .
         .
      END
    OF ?ATLIKT
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         LOCALRESPONSE=REQUESTCANCELLED
         DO PROCEDURERETURN
      END
    OF ?ButtonIni
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(IniINFO)
        INIINFO{PROP:TEXT}='WinLats.ini '&PATH()
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?OKINI
             IF EVENT()=EVENT:ACCEPTED
                BREAK
             .
          .
        .
        CLOSE(INIINFO)
      END
    OF ?ButtonIniC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        OPEN(LIniINFO)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF ?OKINIC
             IF EVENT()=EVENT:ACCEPTED
                BREAK
             .
          .
        .
        CLOSE(LINIINFO)
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
  IF PAROLES::Used = 0
    CheckOpen(PAROLES,1)
  END
  PAROLES::Used += 1
  BIND(SEC:RECORD)
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('gl_cont','winlats.INI')
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
    close(imagewindow)
    CLOSE(REG)
    IF LOCALRESPONSE=REQUESTCOMPLETED
       DO MYFP    !IZVEIDOJAM OBLIGÂTOS FOLDERUS
       DO MYINET
       DO MYDOCS
       DO MYFOLDER
    .
    GLOBAL::Used -= 1
    IF GLOBAL::Used = 0 THEN CLOSE(GLOBAL).
    PAROLES::Used -= 1
    IF PAROLES::Used = 0 THEN CLOSE(PAROLES).
  END
  IF WindowOpened
    INISaveWindow('gl_cont','winlats.INI')
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
CUTEATLAUTS ROUTINE

   LOOP I#=40 TO 159
                                !1-SUPER ACC
                                !2:9 8FILES
                                !10:39 30SPEC_ACC
      IF INRANGE(I#,40,54)      !BASE SÂKAS NO 40
         IF I#-39 > REG:BASE_SK
            ATLAUTS[I#]='N'
         .
      ELSIF INRANGE(I#,55,79)   !NOL
         IF I#-54 > REG:NOL_SK
            ATLAUTS[I#]='N'
         .
      ELSIF INRANGE(I#,80,104)  !FP
         IF I#-79 > REG:FP_SK
            ATLAUTS[I#]='N'
         .
      ELSIF INRANGE(I#,105,119) !ALGA
         IF I#-104 > REG:ALGU_SK
            ATLAUTS[I#]='N'
         .
      ELSIF INRANGE(I#,120,134) !PAM
         IF I#-119 > REG:PAM_SK
            ATLAUTS[I#]='N'
         .
      ELSIF INRANGE(I#,135,159) !LM
         IF I#-134 > REG:LM_SK
            ATLAUTS[I#]='N'
         .
      .
   .

MYFP  ROUTINE
     TTAKA"=PATH()
     USERFOLDER=CLIP(TTAKA")&'\FPDATA'
     SETPATH(USERFOLDER)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
     .
     SETPATH(TTAKA")

MYINET  ROUTINE
     TTAKA"=PATH()
     USERFOLDER=CLIP(TTAKA")&'\INET'
     SETPATH(USERFOLDER)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
     .
     SETPATH(TTAKA")

MYDOCS  ROUTINE
     TTAKA"=PATH()
     S#=INSTRING('"',CLIENT,1)
     IF S# THEN B#=INSTRING('"',CLIENT,1,S#+1).
     IF S# AND B#
        DOCFOLDER=TTAKA"[1:3]&'WINLATS\DOKUMENTI_'&CLIENT[S#+1:B#-1]
     ELSE
        DOCFOLDER=TTAKA"[1:3]&'WINLATS\DOKUMENTI_'&CLIENT[1:10]
     .
     DOCFOLDER=INIGEN(DOCFOLDER,LEN(DOCFOLDER),7)  !7-NELATVIEÐU UN SPECSIMBOLI
     SETPATH(DOCFOLDER)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       I#=CreateDirectoryA(DOCFOLDER,SECURITY_ATT)
     .
     DOCFOLDERK=DOCFOLDER&'\KADRI'
     SETPATH(DOCFOLDERK)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       I#=CreateDirectoryA(DOCFOLDERK,SECURITY_ATT)
     .
     DOCFOLDERP=DOCFOLDER&'\PARTNERI'
     SETPATH(DOCFOLDERP)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       I#=CreateDirectoryA(DOCFOLDERP,SECURITY_ATT)
     .
     SETPATH(TTAKA")

MYFOLDER  ROUTINE
     TTAKA"=PATH()
     USERFOLDER='C:\WINLATS\'&CLIP(ACC_KODS)
     SETPATH(USERFOLDER)
     IF ERROR()
       SECURITY_ATT.nLength=Len(SECURITY_ATT)
       SECURITY_ATT.lpSecurityDescriptor=0
       SECURITY_ATT.bInheritHandle=1
       USERFOLDER='C:\WINLATS'
       I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
       USERFOLDER='C:\WINLATS\'&CLIP(ACC_KODS)
       I#=CreateDirectoryA(USERFOLDER,SECURITY_ATT)
     .
     SETPATH(TTAKA")

          
B_Ieskaits           PROCEDURE                    ! Declare Procedure
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

RPT_NPK              STRING(3)
DATUMS               STRING(2)
MENVAR               STRING(10)
IzsnDatums           string(35)
PAR_NOS_P            STRING(80)
RPT_CLIENT           STRING(80)
KESKA                STRING(60)
KEKSIS               STRING(1)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)
ADRESE               STRING(60)
ADRESE1              STRING(60)
Iekr_vieta           STRING(60)
Izkr_vieta           STRING(60)
PAR_BANKA            STRING(80)
M_BANKA              STRING(80)
ATLAUJA              STRING(15)
C_DATUMS             LONG
KOPA                 STRING(15)
GG_VAL               LIKE(GG:VAL)
!PVN_PROC             DECIMAL(2)
SUMV                 STRING(112)
PLKST                TIME
PAV_SUMMA            DECIMAL(13,2)
PAV_SUMMAK           DECIMAL(13,2)
IESK_SUMMA_B         DECIMAL(13,2)
IESK_SUMMA_BK        DECIMAL(13,2)
IESK_PVN             DECIMAL(13,2)
IESK_PVNK            DECIMAL(13,2)
IESK_SUMMA           DECIMAL(13,2)
IESK_SUMMAK          DECIMAL(13,2)
SamaksasVeids        STRING(21)
SamaksasKartiba      STRING(21)
NOSAUKUMS            STRING(50)
PrecuNosaukums       string(50),dim(10)
Mervieniba           STRING(7)
Daudzums             decimal(3,1)
DAUDZUMS_S           STRING(15)
PrecuDaudzums        decimal(3,1),dim(10)
PrecuSumma           DECIMAL(12,2),dim(10)
PrecuPVN             DECIMAL(2),dim(10)
BAN_NOS_P            STRING(31)
PUZ                  STRING(1)
AKTS_TEXT            STRING(40)
IESKAITS_TEXT        STRING(50)
PAV_DATUMS           LONG
DOK_SENR             STRING(14)
PARVADATAJS          STRING(80)
SDA                  STRING(36)

D_TABLE     QUEUE,PRE(D)
SUMMA           DECIMAL(13,2)
DOK_SENR        STRING(14)
            .
K_TABLE     QUEUE,PRE(K)
SUMMA           DECIMAL(13,2)
DOK_SENR        STRING(14)
            .

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END


report REPORT,AT(100,300,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
DETAIL0 DETAIL,AT(,,,1240),USE(?DETAIL0)
         STRING(@s40),AT(2500,729,4792,260),USE(AKTS_TEXT),TRN,CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING(@s50),AT(3010,990,3802,208),USE(IESKAITS_TEXT),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
IESK_HEAD1 DETAIL,AT(,21,,1188),USE(?unnamed:8)
         STRING(@s50),AT(2125,52,3802,208),USE(KESKA),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(573,417,6052,208),USE(RPT_client),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Norçíinu rekvizîti:'),AT(844,802,938,156),USE(?String1:3),LEFT
         STRING(@s80),AT(1792,802,5365,156),USE(M_BANKA),LEFT
         STRING(@s60),AT(1375,646,3385,156),USE(adrese),LEFT
         STRING('Adrese: '),AT(844,646,469,156),USE(?String1:2),LEFT
         STRING('piegâdâtie materiâli (veiktie darbi) :'),AT(844,958,1875,156),USE(?String1:7),LEFT
       END
IESK_HEAD2 DETAIL,AT(,21,,792),USE(?unnamed)
         STRING('Norçíinu rekvizîti:'),AT(844,438,938,156),USE(?StringH1:3),LEFT
         STRING(@s80),AT(1823,438,5417,156),USE(par_banka),LEFT
         STRING(@s60),AT(1375,281,3365,156),USE(adrese1),LEFT
         STRING(@s80),AT(573,63,6052,208),USE(PAR_nos_p),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Adrese:'),AT(844,281,469,156),USE(?StringH1:2),LEFT
         STRING('piegâdâtie materiâli (veiktie darbi) :'),AT(844,594,1875,156),USE(?StringH1:7),LEFT
       END
DOK_HEAD DETAIL,AT(,,,354),USE(?unnamed:6)
         LINE,AT(5521,52,0,313),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(6354,52,0,313),USE(?Line8:18),COLOR(COLOR:Black)
         LINE,AT(7552,52,0,313),USE(?Line8:11),COLOR(COLOR:Black)
         LINE,AT(7865,52,0,313),USE(?Line8:20),COLOR(COLOR:Black)
         STRING('Dokumenta numurs'),AT(885,104,1042,208),USE(?String38:2),CENTER
         STRING('Ieskaita summa bez PVN'),AT(4198,104,1302,208),USE(?String38:6),CENTER
         STRING('PVN'),AT(5552,104,781,208),USE(?String38:4),CENTER
         STRING('Ieskaita summa kopâ'),AT(6396,104,1146,208),USE(?String38:7),CENTER
         STRING('Dok.Datums'),AT(2031,104,833,208),USE(?String38:8),TRN,CENTER
         STRING('Dok.Summa'),AT(3021,104,833,208),USE(?String38:9),TRN,CENTER
         STRING('PVN'),AT(7594,94,260,208),USE(?String38:3),LEFT
         LINE,AT(573,52,0,313),USE(?Line8:4),COLOR(COLOR:Black)
         LINE,AT(833,52,0,313),USE(?Line8:7),COLOR(COLOR:Black)
         LINE,AT(1979,52,0,313),USE(?Line8:14),COLOR(COLOR:Black)
         LINE,AT(2969,52,0,313),USE(?Line8:25),COLOR(COLOR:Black)
         LINE,AT(4167,52,0,313),USE(?Line8:3),COLOR(COLOR:Black)
         STRING('Npk'),AT(625,104,188,208),USE(?String38),CENTER
         LINE,AT(573,313,7292,0),USE(?Line5:4),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:7)
         STRING(@s3),AT(615,10,208,156),USE(RPT_npk),CENTER
         LINE,AT(4167,-10,0,198),USE(?Line8:12),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,198),USE(?Line8:15),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line8:9),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,198),USE(?Line8:19),COLOR(COLOR:Black)
         STRING(@s3),AT(7240,10,260,156),USE(GG_VAL),LEFT
         LINE,AT(7865,-10,0,198),USE(?Line8:21),COLOR(COLOR:Black)
         LINE,AT(2969,0,0,198),USE(?Line8:26),COLOR(COLOR:Black)
         LINE,AT(1979,0,0,198),USE(?LineD8:12),COLOR(COLOR:Black)
         STRING(@S3),AT(7625,10,200,156),USE(PVN_PROC),RIGHT
         STRING(@n_12.2B),AT(3229,10,781,156),USE(PAV_SUMMA),TRN,RIGHT
         STRING(@n_12.2),AT(4583,10,781,156),USE(IESK_SUMMA_B),TRN,RIGHT
         STRING(@n_12.2),AT(6417,10,781,156),USE(IESK_SUMMA),TRN,RIGHT
         STRING(@n_12.2),AT(5542,10,781,156),USE(IESK_PVN),TRN,RIGHT
         STRING(@d06.B),AT(2135,10,625,156),USE(PAV_DATUMS),TRN,LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s14),AT(938,10,938,156),USE(DOK_SENR,,?DOK_SENR:2),LEFT
         LINE,AT(833,-10,0,198),USE(?Line8:23),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line8:24),COLOR(COLOR:Black)
       END
DOK_FOOT1 DETAIL,AT(,,,94),USE(?unnamed:10)
         LINE,AT(573,-10,0,114),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,114),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,114),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,114),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,114),USE(?Line38),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,114),USE(?Line41),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,114),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,114),USE(?Line75),COLOR(COLOR:Black)
       END
DOK_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(2969,-10,0,198),USE(?Line8:16),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,198),USE(?Line8:13),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,198),USE(?Line8:10),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,198),USE(?Line8:17),COLOR(COLOR:Black)
         STRING(@n_12.2),AT(6396,10,781,156),USE(IESK_SUMMAK),RIGHT
         STRING(@s3),AT(7240,10,260,156),USE(GG:VAL,,?GG:VAL:3),LEFT
         STRING(@n_12.2),AT(5552,10,781,156),USE(IESK_PVNK),TRN,RIGHT
         LINE,AT(7552,-10,0,198),USE(?Line8:8),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,198),USE(?Line8:22),COLOR(COLOR:Black)
         STRING(@n_12.2B),AT(3229,10,781,156),USE(PAV_SUMMAK),TRN,RIGHT
         STRING(@n_12.2),AT(4583,10,781,156),USE(IESK_SUMMA_BK),TRN,RIGHT
         STRING('Kopâ :'),AT(1146,10,521,156),USE(?kopa),LEFT
         LINE,AT(833,-10,0,198),USE(?Line8:6),COLOR(COLOR:Black)
         LINE,AT(573,-10,0,198),USE(?Line8:5),COLOR(COLOR:Black)
       END
DOK_FOOT3 DETAIL,AT(,,,177),USE(?unnamed:4)
         LINE,AT(573,-10,0,62),USE(?Line53:2),COLOR(COLOR:Black)
         LINE,AT(833,-10,0,62),USE(?Line54:2),COLOR(COLOR:Black)
         LINE,AT(2969,-10,0,62),USE(?Line57:2),COLOR(COLOR:Black)
         LINE,AT(4167,-10,0,62),USE(?Line58:2),COLOR(COLOR:Black)
         LINE,AT(5521,-10,0,62),USE(?Line59:2),COLOR(COLOR:Black)
         LINE,AT(6354,-10,0,62),USE(?Line60:2),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,62),USE(?Line61:2),COLOR(COLOR:Black)
         LINE,AT(7865,-10,0,62),USE(?Line62:2),COLOR(COLOR:Black)
         LINE,AT(573,52,7292,0),USE(?Line5:6),COLOR(COLOR:Black)
       END
RPT_FOOT4 DETAIL,AT(,,,458),USE(?unnamed:9)
         STRING('Ieskaita summa kopâ (vârdiem)'),AT(583,21,2031,208),USE(?String62:6),LEFT
         STRING(@s112),AT(635,219,7135,208),USE(sumV),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC),COLOR(0D3D3D3H)
       END
RPT_FOOT5 DETAIL,WITHPRIOR(1),AT(,,,1281),USE(?unnamed:5)
         STRING('Z. V.'),AT(729,1067,521,208),USE(?String62:21),LEFT
         STRING('Z. V.'),AT(4427,1067,521,208),USE(?String62:22),LEFT
         LINE,AT(1198,1006,2656,0),USE(?Line77:3),COLOR(COLOR:Black)
         LINE,AT(4427,1006,2656,0),USE(?Line77:4),COLOR(COLOR:Black)
         STRING(@s16),AT(1563,63,1250,208),USE(sys:paraksts1),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(573,13,7292,0),USE(?Line5:7),COLOR(COLOR:Black)
         LINE,AT(4115,13,0,1250),USE(?Line76),COLOR(COLOR:Black)
         STRING('Vârds, uzvârds'),AT(4271,63,885,156),USE(?String62:14),LEFT
         STRING('Vârds, uzvârds'),AT(635,63,885,156),USE(?String62:12),LEFT
         LINE,AT(5188,271,2188,0),USE(?Line77),COLOR(COLOR:Black)
         STRING('. gada  "'),AT(4771,365,417,156),USE(?String62:17),LEFT
         STRING('"'),AT(5594,365,104,156),USE(?String62:18),LEFT
         STRING(@s35),AT(604,302,2271,177),USE(IzsnDatums),TRN
         LINE,AT(5208,542,365,0),USE(?Line78),COLOR(COLOR:Black)
         LINE,AT(4240,542,542,0),USE(?Line78:2),COLOR(COLOR:Black)
         LINE,AT(5719,542,1615,0),USE(?Line77:2),COLOR(COLOR:Black)
         STRING('Paraksts'),AT(646,646,521,156),USE(?String62:19),LEFT
         STRING('Paraksts'),AT(4271,646,521,156),USE(?String62:20),LEFT
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
  PUSHBIND

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF GGK::USED=0 THEN CHECKOPEN(GGK,1).
  GGK::USED+=1
  IF PAR_K::USED=0 THEN CHECKOPEN(PAR_K,1).
  PAR_K::USED+=1
  IF KON_K::USED=0 THEN CHECKOPEN(KON_K,1).
  KON_K::USED+=1
  IF BANKAS_K::USED=0 THEN CHECKOPEN(BANKAS_K,1).
  BANKAS_K::USED+=1
  BIND(GGK:RECORD)
  BIND(GG:RECORD)
  FilesOpened = True

  gads=year(gg:dokdat)
  datums=day(gg:dokdat)
  MENVAR=MENVAR(gg:dokdat,2,2)
  SAKUMS#=12
  KESKA=' {60}'
  KESKA[SAKUMS#:SAKUMS#+30]=GADS&'.  gada  '&clip(datums)&'.  '&menvar
  IzsnDatums = GADS&'. gada '&clip(datums)&'. '&clip(menvar)
  PAR_NOS_P=CLIP(GETPAR_K(GG:PAR_NR,2,2))&' '&GETPAR_K(GG:PAR_NR,0,21)
  RPT_CLIENT=CLIP(CLIENT)&' NMR '&clip(gl:reg_nr)&' PVN '&gl:VID_nr
  ADRESE=GL:ADRESE
  GETMYBANK('')
  M_BANKA=CLIP(REK)&' '&BANKA
  ADRESE1=PAR:ADRESE
  clear(ban:record)
  ban:kods=par:ban_kods
  get(bankas_k,ban:kod_key)
  par_banka=CLIP(par:ban_nr)&' '&ban:nos_p

  pvn_proc=0
  PAR_NR=GG:PAR_NR

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0

  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P/Z'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:U_NR=GG:U_NR
      SET(GGK:NR_KEY,GGK:NR_KEY)
      Process:View{Prop:Filter} = 'GGK:U_NR=GG:U_NR'
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
   OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GGK:D_K='K' !JÂDOMÂ, KA 231.. KREDÎTS
           K:SUMMA=GGK:SUMMA
           K:DOK_SENR=GGK:REFERENCE
           ADD(K_TABLE)
        ELSE
           D:SUMMA=GGK:SUMMA
           D:DOK_SENR=GGK:REFERENCE
           ADD(D_TABLE)
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
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    AKTS_TEXT='Ieskaita Akts N '&GG:DOK_SENR
    IESKAITS_TEXT='saskaòâ ar Ieskaita lîgumu N '&GETPAR_K(PAR:U_NR,0,23) !KÂ F:LT
    IF F:DBF='W'
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        SETTARGET(REPORT)
        IMAGE(188,281,2083,521,'USER.BMP')
        PRINT(RPT:DETAIL0)
        PRINT(RPT:IESK_HEAD1)
        PRINT(RPT:DOK_HEAD)
    ELSE !WORD.EXCEL
        IF ~OPENANSI('IESKAITS.TXT')
          DO PROCEDURERETURN
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=AKTS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=IESKAITS_TEXT
        ADD(OUTFILEANSI)
        OUTA:LINE=KESKA
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=RPT_CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=ADRESE
        ADD(OUTFILEANSI)
        OUTA:LINE=M_BANKA
        ADD(OUTFILEANSI)
        OUTA:LINE='piegâdâtie materiâli (veiktie darbi) :'
        ADD(OUTFILEANSI)
        OUTA:LINE='Npk'&CHR(9)&'Dokumenta Num.'&CHR(9)&'Datums'&CHR(9)&'Summa'&CHR(9)&'Ieskaita summa bez PVN'&|
        CHR(9)&' PVN'&CHR(9)&'Ieskaita summa kopâ'&CHR(9)&'PVN %'
        ADD(OUTFILEANSI)
    .
    LOOP I#=1 TO RECORDS(K_TABLE)   !VISI IESKAITA KREDÎTI
       GET(K_TABLE,I#)
       PAV_DATUMS=0
       PAV_SUMMA=0
       FOUND#=FALSE
       CLEAR(GGK:RECORD)
       GGK:PAR_NR=PAR_NR
       SET(GGK:PAR_KEY,GGK:PAR_KEY)
       LOOP
          NEXT(GGK)
          IF ERROR() OR ~(GGK:PAR_NR=PAR_NR) THEN BREAK.
          IF GGK:U_NR=1
             IF GGK:REFERENCE=K:DOK_SENR AND GGK:BKK[1:3]='231' THEN FOUND#=TRUE.
          ELSE
             C#=GETGG(GGK:U_NR)
             IF GG:DOK_SENR=K:DOK_SENR AND GGK:BKK[1:3]='231' THEN FOUND#=TRUE.
          .
          IF FOUND#=TRUE
             PAV_DATUMS=GGK:DATUMS
             PAV_SUMMA=GGK:SUMMA    !PILNA 231 SUMMA AR PVN
             PVN_PROC=GGK:PVN_PROC
             BREAK
          .
       .
       RPT_NPK+=1
       DOK_SENR=K:DOK_SENR
       IESK_SUMMA=K:SUMMA           !IESK.SUMMA AR PVN
       IESK_PVN=IESK_SUMMA-IESK_SUMMA/(1+PVN_PROC/100)
       IESK_SUMMA_B=IESK_SUMMA-IESK_PVN
       IF F:DBF='W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=RPT_NPK&CHR(9)&DOK_SENR&CHR(9)&FORMAT(PAV_DATUMS,@D06.B)&CHR(9)&LEFT(FORMAT(PAV_SUMMA,@N-_12.2B))&|
          CHR(9)&LEFT(FORMAT(IESK_SUMMA_B,@N-_12.2B))&CHR(9)&LEFT(FORMAT(IESK_PVN,@N-_12.2B))&|
          CHR(9)&LEFT(FORMAT(IESK_SUMMA,@N-_12.2B))&CHR(9)&PVN_PROC
          ADD(OUTFILEANSI)
       .
       PAV_SUMMAK+=PAV_SUMMA
       IESK_SUMMAK+=IESK_SUMMA
       IESK_PVNK+=IESK_PVN
       IESK_SUMMA_BK+=IESK_SUMMA_B
    .
    IF F:DBF='W'
       PRINT(RPT:DOK_FOOT1)
       PRINT(RPT:DOK_FOOT2)
       PRINT(RPT:DOK_FOOT3)
    ELSE
       OUTA:LINE='Kopâ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_SUMMAK,@N-_12.2B))&|
       CHR(9)&LEFT(FORMAT(IESK_SUMMA_BK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(IESK_PVNK,@N-_12.2B))&|
       CHR(9)&LEFT(FORMAT(IESK_SUMMAK,@N-_12.2B))
       ADD(OUTFILEANSI)
    .
!--------------------------531----------------------
    IF F:DBF='W'
       PRINT(RPT:IESK_HEAD2)
       PRINT(RPT:DOK_HEAD)
    ELSE !WORD.EXCEL
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE=PAR_NOS_P
       ADD(OUTFILEANSI)
       OUTA:LINE=ADRESE1
       ADD(OUTFILEANSI)
       OUTA:LINE=PAR_BANKA
       ADD(OUTFILEANSI)
       OUTA:LINE='piegâdâtie materiâli (veiktie darbi) :'
       ADD(OUTFILEANSI)
       OUTA:LINE='Npk'&CHR(9)&'Dokumenta Num.'&CHR(9)&'Datums'&CHR(9)&'Summa'&CHR(9)&'Ieskaita summa bez PVN'&|
       CHR(9)&' PVN'&CHR(9)&'Ieskaita summa kopâ'&CHR(9)&'PVN %'
       ADD(OUTFILEANSI)
    .
    RPT_NPK=0
    PAV_SUMMAK=0
    IESK_SUMMAK=0
    IESK_PVNK=0
    IESK_SUMMA_BK=0
    LOOP I#=1 TO RECORDS(D_TABLE)  !VISI IESKAITA DEBETI 531
       GET(D_TABLE,I#)
       PAV_DATUMS=0
       PAV_SUMMA=0
       FOUND#=FALSE
       CLEAR(GGK:RECORD)
       GGK:PAR_NR=PAR_NR
       SET(GGK:PAR_KEY,GGK:PAR_KEY)
       LOOP
          NEXT(GGK)
          IF ERROR() OR ~(GGK:PAR_NR=PAR_NR) THEN BREAK.
          IF GGK:U_NR=1
             IF GGK:REFERENCE=D:DOK_SENR AND GGK:BKK[1:3]='531' THEN FOUND#=TRUE.
          ELSE
             C#=GETGG(GGK:U_NR)
             IF GG:DOK_SENR=D:DOK_SENR AND GGK:BKK[1:3]='531' THEN FOUND#=TRUE.
          .
          IF FOUND#=TRUE
             PAV_DATUMS=GGK:DATUMS
             PAV_SUMMA=GGK:SUMMA         !PILNA 531 SUMMA AR PVN
             PVN_PROC=GGK:PVN_PROC
             BREAK
          .
       .
       RPT_NPK+=1
       DOK_SENR=D:DOK_SENR
       IESK_SUMMA=D:SUMMA
       IESK_PVN=IESK_SUMMA-IESK_SUMMA/(1+PVN_PROC/100)
       IESK_SUMMA_B=IESK_SUMMA-IESK_PVN
       IF F:DBF='W'
          PRINT(RPT:DETAIL)
       ELSE
          OUTA:LINE=RPT_NPK&CHR(9)&DOK_SENR&CHR(9)&FORMAT(PAV_DATUMS,@D06.B)&CHR(9)&LEFT(FORMAT(PAV_SUMMA,@N-_12.2B))&|
          CHR(9)&LEFT(FORMAT(IESK_SUMMA_B,@N-_12.2B))&CHR(9)&LEFT(FORMAT(IESK_PVN,@N-_12.2B))&|
          CHR(9)&LEFT(FORMAT(IESK_SUMMA,@N-_12.2B))&CHR(9)&PVN_PROC
          ADD(OUTFILEANSI)
       .
       PAV_SUMMAK+=PAV_SUMMA
       IESK_SUMMAK+=IESK_SUMMA
       IESK_PVNK+=IESK_PVN
       IESK_SUMMA_BK+=IESK_SUMMA_B
    .
    SUMV=SUMVAR(IESK_SUMMAK,GG:VAL,0)
    IF F:DBF = 'W'
       PRINT(RPT:DOK_FOOT1)
       PRINT(RPT:DOK_FOOT2)
       PRINT(RPT:DOK_FOOT3)
       PRINT(RPT:RPT_FOOT4)
       PRINT(RPT:RPT_FOOT5)
       ENDPAGE(report)
    ELSE
       OUTA:LINE='Kopâ'&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(PAV_SUMMAK,@N-_12.2B))&|
       CHR(9)&LEFT(FORMAT(IESK_SUMMA_BK,@N-_12.2B))&CHR(9)&LEFT(FORMAT(IESK_PVNK,@N-_12.2B))&|
       CHR(9)&LEFT(FORMAT(IESK_SUMMAK,@N-_12.2B))
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='Vârds, uzvârds: '&CLIP(SYS:PARAKSTS1)&' __________________________'
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE=''
       ADD(OUTFILEANSI)
       OUTA:LINE='Vârds, uzvârds:                         __________________________'
       ADD(OUTFILEANSI)
    .
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
    GGK::USED-=1
    IF GGK::USED=0 THEN CLOSE(GGK).
    PAR_K::USED-=1
    IF PAR_K::USED=0 THEN CLOSE(PAR_K).
    KON_K::USED-=1
    IF KON_K::USED=0 THEN CLOSE(KON_K).
    BANKAS_K::USED-=1
    IF BANKAS_K::USED=0 THEN CLOSE(BANKAS_K).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  FREE(D_TABLE)
  FREE(K_TABLE)
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% '
      DISPLAY()
    END
  END
