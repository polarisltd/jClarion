                     MEMBER('winlats.clw')        ! This is a MEMBER module
IntMaker2 PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
nokl_c               BYTE
NOLASITS             USHORT
SKAITS          DECIMAL(10,3)
CENA            DECIMAL(10,3)
P               DECIMAL(3),DIM(25)    !PRIORITÂTE
NOAA            DECIMAL(10,3),DIM(25) !ATLIKUMS
OBLMIN          DECIMAL(10,3),DIM(25) !OBLIGÂTAIS MIN
PARV            DECIMAL(10,3),DIM(25) !PÂRVIETOÐANA
REQ_N           DECIMAL(10,3),DIM(25) !TRÛKST ÐAJÂ NOLIKTAVÂ
CTRL            DECIMAL(10,3)
SAV_NOL_NR      BYTE
PRIORITY        STRING(100)

N_TABLE         QUEUE,PRE(N)
NOL_NR             BYTE
NOMENKLAT          STRING(21)
SKAITS             DECIMAL(10,3)
CENA               DECIMAL(10,3)
PVN_PROC           BYTE
ARBYTE             BYTE
                .

R_TABLE         QUEUE,PRE(R)
I                  BYTE
REQ_N              DECIMAL(10,3)
                .


!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------

Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)

PROCESSCREEN WINDOW('Sagatavojam apmaiòas tabulas'),AT(,,250,281),CENTER,GRAY
       STRING(@s21),AT(2,3),USE(nom:nomenklat)
       STRING(@s50),AT(2,12,208,10),USE(NOM:NOS_P)
       LINE,AT(0,23,250,0),USE(?LineP1),COLOR(COLOR:Black)
       LINE,AT(17,23,0,237),USE(?LineP27),COLOR(COLOR:Black)
       LINE,AT(74,23,0,237),USE(?LineP28),COLOR(COLOR:Black)
       LINE,AT(131,23,0,237),USE(?LineP29),COLOR(COLOR:Black)
       LINE,AT(189,23,0,237),USE(?LineP30),COLOR(COLOR:Black)
       PROMPT('Prioritâte'),AT(32,24,35,10),USE(?Prompt1),CENTER
       PROMPT('Pieejams'),AT(89,24,35,10),USE(?Prompt2),CENTER
       PROMPT('Obligâtais Min'),AT(133,24,55,10),USE(?Prompt3),CENTER
       PROMPT('Pârvietoðana'),AT(194,24,53,10),USE(?Prompt5),CENTER
       LINE,AT(0,35,250,0),USE(?LineQ1),COLOR(COLOR:Black)
       STRING('1'),AT(4,36,9,8),USE(?StringP1:1),RIGHT
       STRING(@S13),AT(18,36,54,8),USE(P[1]),RIGHT
       STRING(@S13),AT(75,36,54,8),USE(NOAA[1]),RIGHT
       STRING(@S13),AT(133,36,54,8),USE(OBLMIN[1]),RIGHT
       ENTRY(@N-_7.2),AT(191,36,54,8),USE(PARV[1]),RIGHT
       LINE,AT(0,44,250,0),USE(?LineQ2),COLOR(COLOR:Black)
       STRING('2'),AT(4,45,9,8),USE(?StringP22),RIGHT
       STRING(@S13),AT(18,45,54,8),USE(P[2]),RIGHT
       STRING(@S13),AT(75,45,54,8),USE(NOAA[2]),RIGHT
       STRING(@S13),AT(133,45,54,8),USE(OBLMIN[2]),RIGHT
       ENTRY(@N-_7.2),AT(191,45,54,8),USE(PARV[2]),RIGHT
       LINE,AT(0,53,250,0),USE(?LineQ3),COLOR(COLOR:Black)
       STRING('3'),AT(4,54,9,8),USE(?StringP30),RIGHT
       STRING(@S13),AT(18,54,54,8),USE(P[3]),RIGHT
       STRING(@S13),AT(75,54,54,8),USE(NOAA[3]),RIGHT
       STRING(@S13),AT(133,54,54,8),USE(OBLMIN[3]),RIGHT
       ENTRY(@N-_7.2),AT(191,54,54,8),USE(PARV[3]),RIGHT
       LINE,AT(0,62,250,0),USE(?LineQ4),COLOR(COLOR:Black)
       STRING('4'),AT(4,63,9,8),USE(?StringP44),RIGHT
       STRING(@S13),AT(18,63,54,8),USE(P[4]),RIGHT
       STRING(@S13),AT(75,63,54,8),USE(NOAA[4]),RIGHT
       STRING(@S13),AT(133,63,54,8),USE(OBLMIN[4]),RIGHT
       ENTRY(@N-_7.2),AT(191,63,54,8),USE(PARV[4]),RIGHT
       LINE,AT(0,71,250,0),USE(?LineQ5),COLOR(COLOR:Black)
       STRING('5'),AT(4,72,9,8),USE(?StringP5),RIGHT
       STRING(@S13),AT(18,72,54,8),USE(P[5]),RIGHT
       STRING(@S13),AT(75,72,54,8),USE(NOAA[5]),RIGHT
       STRING(@S13),AT(133,72,54,8),USE(OBLMIN[5]),RIGHT
       ENTRY(@N-_7.2),AT(191,72,54,8),USE(PARV[5]),RIGHT
       LINE,AT(0,80,250,0),USE(?LineQ6),COLOR(COLOR:Black)
       STRING('6'),AT(4,81,9,8),USE(?StringP6),RIGHT
       STRING(@S13),AT(18,81,54,8),USE(P[6]),RIGHT
       STRING(@S13),AT(75,81,54,8),USE(NOAA[6]),RIGHT
       STRING(@S13),AT(133,81,54,8),USE(OBLMIN[6]),RIGHT
       ENTRY(@N-_7.2),AT(191,81,54,8),USE(PARV[6]),RIGHT
       LINE,AT(0,89,250,0),USE(?LineQ7),COLOR(COLOR:Black)
       STRING('7'),AT(4,90,9,8),USE(?StringP7),RIGHT
       STRING(@S13),AT(18,90,54,8),USE(P[7]),RIGHT
       STRING(@S13),AT(75,90,54,8),USE(NOAA[7]),RIGHT
       STRING(@S13),AT(133,90,54,8),USE(OBLMIN[7]),RIGHT
       ENTRY(@N-_7.2),AT(191,90,54,8),USE(PARV[7]),RIGHT
       LINE,AT(0,98,250,0),USE(?LineQ8),COLOR(COLOR:Black)
       STRING('8'),AT(4,99,9,8),USE(?StringP8),RIGHT
       STRING(@S13),AT(18,99,54,8),USE(P[8]),RIGHT
       STRING(@S13),AT(75,99,54,8),USE(NOAA[8]),RIGHT
       STRING(@S13),AT(133,99,54,8),USE(OBLMIN[8]),RIGHT
       ENTRY(@N-_7.2),AT(191,99,54,8),USE(PARV[8]),RIGHT
       LINE,AT(0,107,250,0),USE(?LineQ9),COLOR(COLOR:Black)
       STRING('9'),AT(4,108,9,8),USE(?StringP9),RIGHT
       STRING(@S13),AT(18,108,54,8),USE(P[9]),RIGHT
       STRING(@S13),AT(75,108,54,8),USE(NOAA[9]),RIGHT
       STRING(@S13),AT(133,108,54,8),USE(OBLMIN[9]),RIGHT
       ENTRY(@N-_7.2),AT(191,108,54,8),USE(PARV[9]),RIGHT
       LINE,AT(0,116,250,0),USE(?LineQ10),COLOR(COLOR:Black)
       STRING('10'),AT(4,117,9,8),USE(?StringP10),RIGHT
       STRING(@S13),AT(18,117,54,8),USE(P[10]),RIGHT
       STRING(@S13),AT(75,117,54,8),USE(NOAA[10]),RIGHT
       STRING(@S13),AT(133,117,54,8),USE(OBLMIN[10]),RIGHT
       ENTRY(@N-_7.2),AT(191,117,54,8),USE(PARV[10]),RIGHT
       LINE,AT(0,125,250,0),USE(?LineQ11),COLOR(COLOR:Black)
       STRING('11'),AT(4,126,9,8),USE(?StringP11),RIGHT
       STRING(@S13),AT(18,126,54,8),USE(P[11]),RIGHT
       STRING(@S13),AT(75,126,54,8),USE(NOAA[11]),RIGHT
       STRING(@S13),AT(133,126,54,8),USE(OBLMIN[11]),RIGHT
       ENTRY(@N-_7.2),AT(191,126,54,8),USE(PARV[11]),RIGHT
       LINE,AT(0,134,250,0),USE(?LineQ12),COLOR(COLOR:Black)
       STRING('12'),AT(4,135,9,8),USE(?StringP12),RIGHT
       STRING(@S13),AT(18,135,54,8),USE(P[12]),RIGHT
       STRING(@S13),AT(75,135,54,8),USE(NOAA[12]),RIGHT
       STRING(@S13),AT(133,135,54,8),USE(OBLMIN[12]),RIGHT
       ENTRY(@N-_7.2),AT(191,135,54,8),USE(PARV[12]),RIGHT
       LINE,AT(0,143,250,0),USE(?LineQ13),COLOR(COLOR:Black)
       STRING('13'),AT(4,144,9,8),USE(?StringP13),RIGHT
       STRING(@S13),AT(18,144,54,8),USE(P[13]),RIGHT
       STRING(@S13),AT(75,144,54,8),USE(NOAA[13]),RIGHT
       STRING(@S13),AT(133,144,54,8),USE(OBLMIN[13]),RIGHT
       ENTRY(@N-_7.2),AT(191,144,54,8),USE(PARV[13]),RIGHT
       LINE,AT(0,152,250,0),USE(?LineQ14),COLOR(COLOR:Black)
       STRING('14'),AT(4,153,9,8),USE(?StringP14),RIGHT
       STRING(@S13),AT(18,153,54,8),USE(P[14]),RIGHT
       STRING(@S13),AT(75,153,54,8),USE(NOAA[14]),RIGHT
       STRING(@S13),AT(133,153,54,8),USE(OBLMIN[14]),RIGHT
       ENTRY(@N-_7.2),AT(191,153,54,8),USE(PARV[14]),RIGHT
       LINE,AT(0,161,250,0),USE(?LineQ15),COLOR(COLOR:Black)
       STRING('15'),AT(4,162,9,8),USE(?StringP15),RIGHT
       STRING(@S13),AT(18,162,54,8),USE(P[15]),RIGHT
       STRING(@S13),AT(75,162,54,8),USE(NOAA[15]),RIGHT
       STRING(@S13),AT(133,162,54,8),USE(OBLMIN[15]),RIGHT
       ENTRY(@N-_7.2),AT(191,162,54,8),USE(PARV[15]),RIGHT
       LINE,AT(0,170,250,0),USE(?LineQ16),COLOR(COLOR:Black)
       STRING('16'),AT(4,171,9,8),USE(?StringP16),RIGHT
       STRING(@S13),AT(18,171,54,8),USE(P[16]),RIGHT
       STRING(@S13),AT(75,171,54,8),USE(NOAA[16]),RIGHT
       STRING(@S13),AT(133,171,54,8),USE(OBLMIN[16]),RIGHT
       ENTRY(@N-_7.2),AT(191,171,54,8),USE(PARV[16]),RIGHT
       LINE,AT(0,179,250,0),USE(?LineQ17),COLOR(COLOR:Black)
       STRING('17'),AT(4,180,9,8),USE(?StringP17),RIGHT
       STRING(@S13),AT(18,180,54,8),USE(P[17]),RIGHT
       STRING(@S13),AT(75,180,54,8),USE(NOAA[17]),RIGHT
       STRING(@S13),AT(133,180,54,8),USE(OBLMIN[17]),RIGHT
       ENTRY(@N-_7.2),AT(191,180,54,8),USE(PARV[17]),RIGHT
       LINE,AT(0,188,250,0),USE(?LineQ18),COLOR(COLOR:Black)
       STRING('18'),AT(4,189,9,8),USE(?StringP18),RIGHT
       STRING(@S13),AT(18,189,54,8),USE(P[18]),RIGHT
       STRING(@S13),AT(75,189,54,8),USE(NOAA[18]),RIGHT
       STRING(@S13),AT(133,189,54,8),USE(OBLMIN[18]),RIGHT
       ENTRY(@N-_7.2),AT(191,189,54,8),USE(PARV[18]),RIGHT
       LINE,AT(0,197,250,0),USE(?LineQ19),COLOR(COLOR:Black)
       STRING('19'),AT(4,198,9,8),USE(?StringP19),RIGHT
       STRING(@S13),AT(18,198,54,8),USE(P[19]),RIGHT
       STRING(@S13),AT(75,198,54,8),USE(NOAA[19]),RIGHT
       STRING(@S13),AT(133,198,54,8),USE(OBLMIN[19]),RIGHT
       ENTRY(@N-_7.2),AT(191,198,54,8),USE(PARV[19]),RIGHT
       LINE,AT(0,206,250,0),USE(?LineQ20),COLOR(COLOR:Black)
       STRING('20'),AT(4,207,9,8),USE(?StringP20),RIGHT
       STRING(@S13),AT(18,207,54,8),USE(P[20]),RIGHT
       STRING(@S13),AT(75,207,54,8),USE(NOAA[20]),RIGHT
       STRING(@S13),AT(133,207,54,8),USE(OBLMIN[20]),RIGHT
       ENTRY(@N-_7.2),AT(191,207,54,8),USE(PARV[20]),RIGHT
       LINE,AT(0,215,250,0),USE(?LineQ21),COLOR(COLOR:Black)
       STRING('21'),AT(4,216,9,8),USE(?StringP21),RIGHT
       STRING(@S13),AT(18,216,54,8),USE(P[21]),RIGHT
       STRING(@S13),AT(75,216,54,8),USE(NOAA[21]),RIGHT
       STRING(@S13),AT(133,216,54,8),USE(OBLMIN[21]),RIGHT
       ENTRY(@N-_7.2),AT(191,216,54,8),USE(PARV[21]),RIGHT
       LINE,AT(0,224,250,0),USE(?LineQ22),COLOR(COLOR:Black)
       STRING('22'),AT(4,225,9,8),USE(?StringP26),RIGHT
       STRING(@S13),AT(18,225,54,8),USE(P[22]),RIGHT
       STRING(@S13),AT(75,225,54,8),USE(NOAA[22]),RIGHT
       STRING(@S13),AT(133,225,54,8),USE(OBLMIN[22]),RIGHT
       ENTRY(@N-_7.2),AT(191,225,54,8),USE(PARV[22]),RIGHT
       LINE,AT(0,233,250,0),USE(?LineQ23),COLOR(COLOR:Black)
       STRING('23'),AT(4,234,9,8),USE(?StringP23),RIGHT
       STRING(@S13),AT(18,234,54,8),USE(P[23]),RIGHT
       STRING(@S13),AT(75,234,54,8),USE(NOAA[23]),RIGHT
       STRING(@S13),AT(133,234,54,8),USE(OBLMIN[23]),RIGHT
       ENTRY(@N-_7.2),AT(191,234,54,8),USE(PARV[23]),RIGHT
       LINE,AT(0,242,250,0),USE(?LineQ24),COLOR(COLOR:Black)
       STRING('24'),AT(4,243,9,8),USE(?StringP24),RIGHT
       STRING(@S13),AT(18,243,54,8),USE(P[24]),RIGHT
       STRING(@S13),AT(75,243,54,8),USE(NOAA[24]),RIGHT
       STRING(@S13),AT(133,243,54,8),USE(OBLMIN[24]),RIGHT
       ENTRY(@N-_7.2),AT(191,243,54,8),USE(PARV[24]),RIGHT
       LINE,AT(0,251,250,0),USE(?LineQ25),COLOR(COLOR:Black)
       STRING('25'),AT(4,252,9,8),USE(?StringP25),RIGHT
       STRING(@S13),AT(18,252,54,8),USE(P[25]),RIGHT
       STRING(@S13),AT(75,252,54,8),USE(NOAA[25]),RIGHT
       STRING(@S13),AT(133,252,54,8),USE(OBLMIN[25]),RIGHT
       ENTRY(@N-_7.2),AT(191,252,54,8),USE(PARV[25]),RIGHT
       LINE,AT(0,260,250,0),USE(?LineQ26),COLOR(COLOR:Black)
       STRING(@s8),AT(6,264),USE(ACC_KODS)
       BUTTON('&OK'),AT(118,264,36,14),USE(?OkPROCESS),DEFAULT
       BUTTON('&Izlaist'),AT(155,264,40,14),USE(?SKIPPROCESS)
       BUTTON('&Pârtraukt'),AT(196,264,42,14),USE(?CANCELPROCESS)
     END
window               WINDOW(' '),AT(,,389,116),FONT('MS Sans Serif',9,,FONT:bold),CENTER,GRAY
                       STRING('Rakstu:'),AT(172,7),USE(?StringRakstu),HIDE
                       STRING(@n6B),AT(201,7),USE(NOLASITS)
                       STRING('Tiks izveidota D (ienâkoðâ-iekðçjâ pârvietoðana) P/Z tekoðajâ'),AT(49,21),USE(?String1)
                       STRING(@n3),AT(254,21),USE(LOC_NR),RIGHT(1)
                       STRING('. noliktavâ '),AT(269,21),USE(?String3)
                       STRING('pçc atlikuma fakta un prioritâtes'),AT(128,34),USE(?String9)
                       STRING('un atbilstoðâs K (izejoðâs) P/Z "avota" noliktavâs'),AT(96,48),USE(?String6)
                       STRING('cenas.'),AT(226,66),USE(?String7)
                       PROMPT('&Nomenklatûra:'),AT(103,81),USE(?Promptnom)
                       ENTRY(@s21),AT(155,80,99,13),USE(NOMENKLAT),FONT('Fixedsys',9,,FONT:regular,CHARSET:BALTIC),UPR
                       STRING(' Iekðçjo pârvietoðanu veikt pçc'),AT(98,66),USE(?String10)
                       ENTRY(@n1),AT(206,65),USE(nokl_c)
                       STRING('123456789012345678901'),AT(156,95),USE(?String8),DISABLE,FONT('Fixedsys',9,,FONT:regular,CHARSET:BALTIC)
                       BUTTON('&OK'),AT(286,86,35,14),USE(?OkButton),DEFAULT
                       BUTTON('&Atlikt'),AT(326,86,36,14),USE(?CancelButton)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  nokl_c=6
  NOMENKLAT=''
  
  PRIORITY=GETINIFILE('PRIORITY',0)
  IF PRIORITY=''
     KLUDA(0,'ini failâ nav definçtas Noliktavu prioritâtes')
     DO PROCEDURERETURN
  ELSE
     LOOP I#=1 TO NOL_SK*4 BY 4
        J#+=1
        IF NUMERIC(PRIORITY[I#:I#+2])
           P[J#]=PRIORITY[I#:I#+2]
        .
     .
  .
  
  !kopa
  !P[1]=30
  !P[2]=20
  !P[3]=50
  !P[4]=70
  !P[5]=60
  !P[6]=0
  !P[7]=100
  !P[8]=20
  !P[9]=40
  !P[10]=60
  !P[11]=50
  !P[12]=90
  !P[13]=0
  !P[14]=30
  
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
      SELECT(?StringRakstu)
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
         CHECKOPEN(NOM_K,1)
         CLEAR(NOM:RECORD)
         NOM:NOMENKLAT=NOMENKLAT
         SET(NOM:NOM_KEY,NOM:NOM_KEY)
         NEXT(NOM_K)
         IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2
            KLUDA(88,'neviena nomenklatûra ar filtru: '&nomenklat)
         ELSE
            OPEN(PROCESSCREEN)
            DISABLE(1+13+NOL_SK*6+1,?ACC_KODS)
            DISABLE(1+13+LOC_NR*6-1)
            EXECUTE LOC_NR
               ?PARV_1{PROP:COLOR}=000000FFh
               ?PARV_2{PROP:COLOR}=000000FFh
               ?PARV_3{PROP:COLOR}=000000FFh
               ?PARV_4{PROP:COLOR}=000000FFh
               ?PARV_5{PROP:COLOR}=000000FFh
               ?PARV_6{PROP:COLOR}=000000FFh
               ?PARV_7{PROP:COLOR}=000000FFh
               ?PARV_8{PROP:COLOR}=000000FFh
               ?PARV_9{PROP:COLOR}=000000FFh
               ?PARV_10{PROP:COLOR}=000000FFh
               ?PARV_11{PROP:COLOR}=000000FFh
               ?PARV_12{PROP:COLOR}=000000FFh
               ?PARV_13{PROP:COLOR}=000000FFh
               ?PARV_14{PROP:COLOR}=000000FFh
               ?PARV_15{PROP:COLOR}=000000FFh
               ?PARV_16{PROP:COLOR}=000000FFh
               ?PARV_17{PROP:COLOR}=000000FFh
               ?PARV_18{PROP:COLOR}=000000FFh
               ?PARV_19{PROP:COLOR}=000000FFh
               ?PARV_20{PROP:COLOR}=000000FFh
               ?PARV_21{PROP:COLOR}=000000FFh
               ?PARV_22{PROP:COLOR}=000000FFh
               ?PARV_23{PROP:COLOR}=000000FFh
               ?PARV_24{PROP:COLOR}=000000FFh
               ?PARV_25{PROP:COLOR}=000000FFh
            .
            DO FILLDIM
            display
            accept
               CTRL=0
               LOOP I#= 1 TO NOL_SK
                  IF ~(I#=LOC_NR)
                     IF PARV[I#]>0 THEN PARV[I#]=-PARV[I#].
                     CTRL+=ABS(PARV[I#])
                  .
               .
               PARV[LOC_NR]=CTRL
               DISPLAY
               case field()
               of ?OKPROCESS
                  if event()=Event:Accepted
                     DO FILLNTABLE
                     LOOP
                        NEXT(NOM_K)
                        IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2
                           ENDPROCESS#=TRUE
                           BREAK
                        .
                        IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.
                        DO FILLDIM
                        DISPLAY
                        BREAK
                     .
                     IF ENDPROCESS#=TRUE
                        BREAK
                     .
                  .
               of ?SKIPPROCESS
                  if event()=Event:Accepted
                     LOOP
                        NEXT(NOM_K)
                        IF ERROR() OR CYCLENOM(NOM:NOMENKLAT)=2
                           ENDPROCESS#=TRUE
                           BREAK
                        .
                        IF CYCLENOM(NOM:NOMENKLAT) THEN CYCLE.
                        DO FILLDIM
                        DISPLAY
                        BREAK
                     .
                     IF ENDPROCESS#=TRUE
                        BREAK
                     .
                  .
               of ?CANCELPROCESS
                  if event()=Event:Accepted
                     CANCELPROCESS#=TRUE
                     BREAK
                  .
               .
            .
            CLOSE(PROCESSCREEN)
            IF CANCELPROCESS#=FALSE
               KLUDA(99,clip(RECORDS(N_TABLE))&' Nomenklatûras, ko pârvietot')
               IF KLU_DARBIBA=1
                  DISABLE(?String1,?CancelButton)
                  UNHIDE(?StringRakstu)
                  DISPLAY
                  CHECKOPEN(NOLIK,1)
                  DO MAKEPZ
                  FREE(N_TABLE)
                  CLOSE(PAVA1)
                  CLOSE(NOLI1)
               .
            .
            BREAK
         .
        
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
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('IntMaker2','winlats.INI')
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
    INISaveWindow('IntMaker2','winlats.INI')
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
!-------------------------------------------------------------------------------------------
FILLDIM   ROUTINE
    CLEAR(NOAA)
    CLEAR(OBLMIN)
    CLEAR(REQ_N)
    CLEAR(PARV)
    I#=GETNOM_A(NOM:NOMENKLAT,9,0) !POZICIONÇJAM
    LOOP I#=1 TO NOL_SK
       NOAA[I#]=NOA:ATLIKUMS[I#]-NOA:K_PROJEKTS[I#]
       OBLMIN[I#]=ROUND(NOM:KRIT_DAU[I#]*P[I#]/100,1)
       REQ_N[I#]=ROUND(OBLMIN[I#]-NOAA[I#],1)
       IF ~(I#=LOC_NR)
          R:I=I#
          R:REQ_N=REQ_N[I#]
          ADD(R_TABLE)
          IF ERROR() THEN STOP('R_TABLE '&ERROR()).
       .
    .
    IF REQ_N[LOC_NR] > 0       !TRÛKST TEKOÐAJÂ NOLIKTAVÂ
       SORT(R_TABLE,-R:REQ_N)
       LOOP R#=1 TO RECORDS(R_TABLE)
          GET(R_TABLE,R#)
          IF REQ_N[R:I] < 0 !PÂRPALIKUMS ÐAJÂ NOLIKTAVÂ
             IF REQ_N[LOC_NR]+REQ_N[R:I] > 0 !NESPÇJ AIZPILDÎT VISU
                PARV[R:I]=REQ_N[R:I]
                PARV[LOC_NR]+=ABS(REQ_N[R:I])
                REQ_N[LOC_NR]+=REQ_N[R:I]
             ELSE
                PARV[R:I]=-REQ_N[LOC_NR]
                PARV[LOC_NR]+=REQ_N[LOC_NR]
                REQ_N[LOC_NR]=0
                BREAK
             .
          .
       .
    .
    FREE(R_TABLE)

!-------------------------------------------------------------------------------------------
FILLNTABLE ROUTINE
  LOOP NOL_NR#= 1 TO NOL_SK
     IF PARV[NOL_NR#]<0  !RAKSTAM TIKAI KREDÎTUS
        N:NOL_NR=NOL_NR#
        N:NOMENKLAT=NOM:NOMENKLAT
        N:SKAITS=PARV[NOL_NR#]
        CENA=GETNOM_K('POZICIONÇTS',2,7,NOKL_C)
        N:CENA=CENA
        N:PVN_PROC=NOM:PVN_PROC
        N:ARBYTE=0            !bez pvn
        IF GETNOM_K('POZICIONÇTS',0,10,NOKL_C)
           N:ARBYTE=1
        .
        ADD(N_TABLE)
     .
  .
 
!-----BÛVÇJAM VISAS P/Z--------------------------------------------------

MAKEPZ   ROUTINE
  IF RECORDS(N_TABLE)
     SORT(N_TABLE,N:NOL_NR)
     SAV_NOL_NR=0
     GET(N_TABLE,0)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        NOLASITS+=1
        DISPLAY
        IF ~(SAV_NOL_NR=N:NOL_NR)
           SAV_NOL_NR=N:NOL_NR
           !D TEKOÐAJÂ NOLIKTAVÂ
              IF I#>1 THEN PUT(PAVAD). !FIX SUMMU
              DO AUTONUMBER
              PAV:D_K='1'
              PAV:DOKDAT=TODAY()
              PAV:DATUMS=TODAY()
              PAV:NOKA='NOL '&CLIP(N:NOL_NR)
              PAV:PAR_NR=N:NOL_NR
              PAV:PAMAT='Iekðçjâ pârvietoðana'
              PAV:VAL='Ls'
              PAV:NODALA=SYS:NODALA
              PAV:ACC_KODS=ACC_KODS
              PAV:ACC_DATUMS=TODAY()
              PUT(PAVAD)              !DROÐÎBAS PÇC
              IF ERROR() THEN STOP(ERROR()).
           !K AVOTA NOLIKTAVÂ
              IF I#>1 THEN PUT(PAVA1). !FIX SUMMU
              CLOSE(PAVA1)
              CLOSE(NOLI1)
              FILENAME1='PAVAD'&FORMAT(N:NOL_NR,@N02)
              FILENAME2='NOLIK'&FORMAT(N:NOL_NR,@N02)
              CHECKOPEN(PAVA1,1)
              CHECKOPEN(NOLI1,1)
              DO AUTONUMBER_AVOTS
              PA1:D_K='P'
              PA1:DOKDAT=TODAY()
              PA1:DATUMS=TODAY()
              PA1:NOKA='NOL '&CLIP(LOC_NR)
              PA1:PAR_NR=LOC_NR
              PA1:PAMAT='Iekðçjâ pârvietoðana'
              PA1:VAL='Ls'
              PA1:NODALA=SYS:NODALA
              PA1:ACC_KODS=ACC_KODS
              PAV:ACC_DATUMS=TODAY()
              PUT(PAVA1)
              IF ERROR() THEN STOP(ERROR()).
           !
        .
        !D TEKOÐAJÂ NOLIKTAVÂ
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           NOL:DATUMS=PAV:DATUMS
           NOL:NOMENKLAT=N:NOMENKLAT
           NOL:PAR_NR=PAV:PAR_NR
           NOL:D_K=PAV:D_K
           NOL:DAUDZUMS=ABS(N:SKAITS)
           AtlikumiN(PAV:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0,LOC_NR)
           KopsN(NOL:NOMENKLAT,NOL:DATUMS,PAV:D_K)
           NOL:SUMMA=N:CENA*NOL:DAUDZUMS
           NOL:SUMMAV=N:CENA*NOL:DAUDZUMS
           NOL:ARBYTE=N:ARBYTE
           NOL:PVN_PROC=N:PVN_PROC
           NOL:VAL='Ls'
           ADD(NOLIK)
           IF ERROR()
              STOP('KÏÛDA RAKSTOT D-P/Z:'&N:NOMENKLAT&' NOLIKTAVÂ:'&LOC_NR&':'&ERROR())
           .
           IF N:ARBYTE=0
             PAV:SUMMA+=NOL:SUMMA*(1+N:PVN_PROC/100)
           ELSE
             PAV:SUMMA+=NOL:SUMMA
           .
        !K AVOTA NOLIKTAVÂ
           CLEAR(NO1:RECORD)
           NO1:U_NR=PA1:U_NR
           NO1:DATUMS=PA1:DATUMS
           NO1:NOMENKLAT=N:NOMENKLAT
           NO1:PAR_NR=PA1:PAR_NR
           NO1:D_K=PA1:D_K
           NO1:DAUDZUMS=ABS(N:SKAITS)
           AtlikumiN(PA1:D_K,NO1:NOMENKLAT,NO1:DAUDZUMS,'','',0,N:NOL_NR)
           KopsN(NO1:NOMENKLAT,NO1:DATUMS,PAV:D_K)
           NO1:SUMMA=N:CENA*NO1:DAUDZUMS
           NO1:SUMMAV=N:CENA*NO1:DAUDZUMS
           NO1:ARBYTE=N:ARBYTE
           NO1:PVN_PROC=N:PVN_PROC
           NO1:VAL='Ls'
           ADD(NOLI1)
           IF ERROR()
              STOP('KÏÛDA RAKSTOT K-P/Z:'&N:NOMENKLAT&' NOLIKTAVÂ:'&N:NOL_NR&':'&ERROR())
           .
           IF N:ARBYTE=0
             PA1:SUMMA+=NO1:SUMMA*(1+N:PVN_PROC/100)
           ELSE
             PA1:SUMMA+=NO1:SUMMA
           .
        !
     .
     PUT(PAVAd)
     PUT(PAVA1)
  .

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    clear(PAV:Record)
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVAD)
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

!---------------------------------------------------------------------------------------------
Autonumber_AVOTS ROUTINE    ! LASOT UZ AVOTA PAVAD
  Auto::Attempts = 0
  LOOP
    SET(PA1:NR_KEY)
    PREVIOUS(PAVA1)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVA1')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PA1:U_NR + 1
    END
    clear(PA1:Record)
    PA1:DATUMS=TODAY()
    PA1:U_NR = Auto::Save:PAV:U_NR
    ADD(PAVA1)
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

!***************************************************************************************************
 OMIT('MARIS')

!-----Lasam tekoðo noliktavu------------------------------------------------------------------

SCROLLFILE  ROUTINE
  CLEAR(NOL:RECORD)
  NOL:D_K='K'
  NOL:DATUMS=SAK_DAT
  SET(NOL:DAT_KEY,NOL:DAT_KEY)
  LOOP
    NEXT(NOLIK)
    IF ERROR() OR ~(INRANGE(NOL:DATUMS,SAK_DAT,BEI_DAT)) THEN BREAK.
    IF ~(NOL:D_K='K') THEN CYCLE.
!    G#=GETPAVADZ(NOL:U_NR)
!    IF PAV:RS THEN CYCLE.  !TIKAI APSTIPRINÂTÂS
    IF NOL:RS THEN CYCLE.  !TIKAI APSTIPRINÂTÂS
    NOLASITS+=1
    NOMENKLAT=NOL:NOMENKLAT
    DISPLAY
    CENA=GETNOM_K(NOL:NOMENKLAT,2,7,NOKL_C)
    IF NOM:TIPS='A' THEN CYCLE.
    IF NOKL_C=6
      ARBYTE=0
    ELSE
      ARBYTE=1
    .
    SKAITS=NOL:DAUDZUMS
    DO FILLNTABLE
  .

!-------------------------------------------------------------------------------------------

MAKEKPZ   ROUTINE
  IF RECORDS(N_TABLE)
     DO AUTONUMBER_AVOTS
     PA1:D_K='K'
     PA1:DATUMS=BEI_DAT
     PA1:NOKA='NOL'&CLIP(LOC_NR)
     PA1:PAR_NR=LOC_NR
     PA1:PAMAT='Iekðçjâ.pârv. '&day(sak_dat)&'-'&format(bei_dat,@d6)
     PA1:VAL='Ls'
     PA1:NODALA=SYS:NODALA
     PA1:ACC_KODS=ACC_KODS
     PAV:ACC_DATUMS=TODAY()
     PUT(PAVA1)
     IF ERROR() THEN STOP(ERROR()).
     GET(N_TABLE,0)
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        NOLASITS+=1
        NOMENKLAT=N:NOMENKLAT
        DISPLAY
        CLEAR(NO1:RECORD)
        NO1:U_NR=PA1:U_NR
        NO1:DATUMS=PA1:DATUMS
        NO1:NOMENKLAT=N:NOMENKLAT
        NO1:PAR_NR=PA1:PAR_NR
        NO1:D_K=PA1:D_K
        NO1:DAUDZUMS=N:SKAITS
        AtlikumiN('K',NO1:NOMENKLAT,NO1:DAUDZUMS,'','',0,avota_nr)
        KopsN(NO1:NOMENKLAT,NO1:DATUMS,'K')
        NO1:SUMMA=N:CENA*NO1:DAUDZUMS
        NO1:SUMMAV=N:CENA*NO1:DAUDZUMS
        NO1:ARBYTE=ARBYTE
        NO1:PVN_PROC=NOM:PVN_PROC
        NO1:VAL='Ls'
        ADD(NOLI1)
        IF ERROR()
           STOP('KÏÛDADA RAKSTOT K-P/Z:'&N:NOMENKLAT&' NOLIKTAVÂ:'&AVOTA_NR&':'&ERROR())
        .
        IF ARBYTE=0
          PA1:SUMMA+=NO1:SUMMA*(1+18/100) !>????????????????????????????/
        ELSE
          PA1:SUMMA+=NO1:SUMMA
        .
     .
     PUT(PAVA1)
  .

 MARIS
P_PLkustiba          PROCEDURE                    ! Declare Procedure
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
                       PROJECT(PAM:U_NR)
                       PROJECT(PAM:NOS_P)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:END_DATE)
                       PROJECT(PAM:KAT)
                       PROJECT(PAM:NOL_V)
                       PROJECT(PAM:DATUMS)
                     END
!-----------------------------------------------------------------------------

SAV_AMO_NODALA      LIKE(AMO:NODALA)
FILTRS_TEXT         STRING(80)

DAR_VEIDS           STRING(22)
DAR_DAT             STRING(10)
VERT_SAK            DECIMAL(11,2)
VERT_BEI            DECIMAL(11,2)
VERT_SAKK           DECIMAL(11,2)
VERT_BEIK           DECIMAL(11,2)
PAM_U_NR            LIKE(PAM:U_NR)
PAM_NOS_P           LIKE(PAM:NOS_P)
KOPA                STRING(30)

DAT                 LONG
LAI                 LONG

B_TABLE           QUEUE,PRE(B)
KEY                  STRING(6)
TIPS                 STRING(1)
BKK                  STRING(5)
SUMMA1               DECIMAL(12,2)
SUMMA2               DECIMAL(12,2)
                  .

VERT_IEGK            DECIMAL(12,2)
VERT_KAPK            DECIMAL(12,2)
VERT_IZNSK           DECIMAL(12,2)
VERT_IZNBK           DECIMAL(12,2)
BKK                  STRING(5)
KUS_PERIODS          STRING(50)
B_TIPS               STRING(1)

!-----------------------------------------------------------------------------
report REPORT,AT(300,1550,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(300,300,8000,1250),USE(?unnamed:2)
         STRING('Datums'),AT(3521,896,625,156),USE(?String13:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba(LIN)'),AT(5656,990,729,208),USE(?String13:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1198,7083,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Paskaidrojums'),AT(4198,896,1406,156),USE(?String13:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1240,83,4375,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Forma PL:3'),AT(6458,313,677,156),USE(?String11)
         STRING(@s50),AT(1448,313,4063,208),USE(KUS_PERIODS),TRN,CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6615,521,573,156),PAGENO,USE(?PageCount),RIGHT(20)
         STRING(@s100),AT(104,521,6458,156),USE(FILTRS_TEXT),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,7083,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(469,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1198,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(3490,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(4167,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5625,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6406,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7188,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('Npk'),AT(135,896,313,156),USE(?String13:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(1229,896,2240,156),USE(?String13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PL numurs'),AT(500,896,677,156),USE(?String13:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Sâkotnçjâ'),AT(5656,781,729,208),USE(?String13:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('vçrtîba(LIN)'),AT(6438,990,729,208),USE(?String13:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Atlikusî'),AT(6438,781,729,208),USE(?String13:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,729,0,521),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:6)
         LINE,AT(104,-10,0,197),USE(?Line2:10),COLOR(COLOR:Black)
         STRING(@N_6B),AT(677,10,417,156),USE(PAM_U_NR),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(469,-10,0,197),USE(?Line3:11),COLOR(COLOR:Black)
         STRING(@S35),AT(1229,10,2240,156),USE(PAM_NOS_P),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(3490,-10,0,197),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,197),USE(?Line53),COLOR(COLOR:Black)
         STRING(@S10),AT(3521,0,625,156),USE(DAR_DAT),CENTER
         LINE,AT(4167,-10,0,197),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5677,10,677,156),USE(VERT_SAK),RIGHT
         LINE,AT(6406,-10,0,197),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(6458,10,677,156),USE(VERT_BEI,,?VERT_BEI:2),RIGHT
         LINE,AT(5625,-10,0,197),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@S22),AT(4219,10,1406,156),USE(DAR_VEIDS),LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@n4B),AT(156,10,260,156),USE(RPT_NPK#),RIGHT(1),FONT(,8,,FONT:regular,CHARSET:BALTIC)
       END
KOPA   DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(104,-10,0,197),USE(?Line486:10),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,197),USE(?Line476:12),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5677,0,677,156),USE(VERT_SAKK),TRN,RIGHT
         STRING(@N_11.2B),AT(6469,0,677,156),USE(VERT_BEIK),TRN,RIGHT
         STRING(@S30),AT(3010,10,1979,156),USE(KOPA),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         STRING(@S5),AT(5042,10,417,156),USE(BKK),TRN,LEFT,FONT(,8,,FONT:regular,CHARSET:BALTIC)
         LINE,AT(6406,-10,0,197),USE(?Line475:65),COLOR(COLOR:Black)
         LINE,AT(5625,-10,0,197),USE(?Line473:46),COLOR(COLOR:Black)
       END
LINE   DETAIL,AT(,,,0),USE(?unnamed)
         LINE,AT(104,0,7083,0),USE(?Line1:4L),COLOR(COLOR:Black)
       END
RepFoot DETAIL,AT(,,,198),USE(?unnamed:5)
         LINE,AT(104,-10,0,62),USE(?Line2:19),COLOR(COLOR:Black)
         LINE,AT(104,52,7083,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(115,73),USE(?String59),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(583,73),USE(acc_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@d06.),AT(6135,73),USE(dat),FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(6740,73),USE(lai),FONT(,7,,,CHARSET:ANSI)
         LINE,AT(5625,-10,0,62),USE(?Line83),COLOR(COLOR:Black)
         LINE,AT(6406,-10,0,62),USE(?Line80),COLOR(COLOR:Black)
         LINE,AT(7188,-10,0,62),USE(?Line79),COLOR(COLOR:Black)
       END
       FOOTER,AT(300,11000,8000,52)
         LINE,AT(104,0,7083,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND

  DAT = TODAY()
  LAI = CLOCK()
  IF F:KAT_NR>'000' THEN FILTRS_TEXT='Kategorija: '&F:KAT_NR[1]&'-'&F:KAT_NR[2:3].
  IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
  KUS_PERIODS='Pamatlîdzekïu kustîba '&MENVAR(MEN_NR,1,1)&' '&GADS

  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAMAT::Used = 0
    CheckOpen(PAMAT,1)
  END
  PAMAT::Used += 1
  IF PAMAM::Used = 0
    CheckOpen(PAMAM,1)
  END
  PAMAM::Used += 1
  BIND('GADS',GADS)
  BIND('PAM:END_DATE',PAM:END_DATE)

  FilesOpened = True
  RecordsToProcess = RECORDS(PAMAT)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pamatlîdzekïu kustîba'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAMAT,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(PAM:RECORD)
      SET(PAM:NR_KEY,PAM:NR_KEY)
      Process:View{Prop:Filter} = '~INRANGE(PAM:END_DATE,DATE(1,1,1900),DATE(12,31,GADS-1))' !NAV NOÒEMTS IEPR.G-OS
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
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('P_PLkustiba.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=KUS_PERIODS
          ADD(OUTFILEANSI)
          OUTA:LINE=FILTRS_TEXT
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
         IF F:DBF='E'
             OUTA:LINE='Npk'&CHR(9)&'PL'&CHR(9)&'Nosaukums'&CHR(9)&'Datums'&CHR(9)&'Darîjuma'&CHR(9)&|
             'Sâkotnçjâ'&CHR(9)&'Atlikusî'
             ADD(OUTFILEANSI)
             OUTA:LINE=CHR(9)&'Nr.'&CHR(9)&CHR(9)&CHR(9)&'veids'&CHR(9)&|
             'vçrtîba'&CHR(9)&'vçrtîba'
          ELSE
             OUTA:LINE='Npk'&CHR(9)&'PL Nr'&CHR(9)&'Nosaukums'&CHR(9)&'Datums'&CHR(9)&'Darîjuma veids'&CHR(9)&|
             'Sâkotnçjâ vçrtîba'&CHR(9)&'Atlikusî vçrtîba'
          .
          ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        VERT_SAK =0
        VERT_BEI =0
        Y#=GADS-YEAR(PAM:EXPL_DATUMS)+1           !GADA INDEKSS KONKRÇTAM P/L
        IF ~INRANGE(Y#,1,15) THEN Y#=1.           !JA EXPL NODOD NÂK. GADÂ VAI GADS>2009
        IF ~PAM:KAT[Y#] THEN Y#=1.                !JA EXPL NODOD NÂK. GADÂ VAI NAV RÇÍINÂTS NOLIETOJUMS
        IF ~CYCLEKAT(PAM:KAT[Y#])                 !KATEGORIJA VAR MAINÎTIES REIZI GADÂ
            FIRST_PAM#=TRUE
            PAM_U_NR=PAM:U_NR
            PAM_NOS_P=PAM:NOS_P
!            STOP(FORMAT(S_DAT,@D06.)&FORMAT(B_DAT,@D06.))
            IF INRANGE(PAM:DATUMS,S_DAT,B_DAT) AND ~CYCLENODALA(PAM:NODALA)
                DAR_VEIDS='Iegâdâts (N='&PAM:NODALA&')'
                DAR_DAT=FORMAT(PAM:DATUMS,@D06.)
                VERT_SAK=PAM:BIL_V
                VERT_BEI=0
                DO PRINT_RPT_DETAIL
                VERT_IEGK+=VERT_SAK
                B_TIPS='I'
                DO MAKE_B_TABLE
            .
            CLEAR(AMO:RECORD)
            AMO:yyyymm=DATE(MONTH(S_DAT)-1,1,YEAR(S_DAT)) !IEPRIEKÐÇJAIS IERAKSTS
            AMO:U_NR=PAM:U_NR
            GET(PAMAM,AMO:NR_KEY)
            IF ~ERROR()
               SAV_AMO_NODALA=AMO:NODALA
            ELSE
               SAV_AMO_NODALA=PAM:NODALA
            .
            AMO:yyyymm=S_DAT
            AMO:U_NR=PAM:U_NR
            SET(AMO:NR_KEY,AMO:NR_KEY)
            LOOP
               NEXT(PAMAM)
               IF ERROR() OR ~(AMO:U_NR=PAM:U_NR) OR AMO:YYYYMM>B_DAT THEN BREAK.
               IF ~(SAV_AMO_NODALA=AMO:NODALA) AND (~CYCLENODALA(AMO:NODALA) OR ~CYCLENODALA(SAV_AMO_NODALA))
                  DAR_VEIDS='Pârvietots no '&CLIP(SAV_AMO_NODALA)&' uz '&CLIP(AMO:NODALA)
                  DAR_DAT=FORMAT(AMO:YYYYMM,@D06.)
                  DO PRINT_RPT_DETAIL
                  SAV_AMO_NODALA=AMO:NODALA
               .
               IF AMO:KAPREM AND ~CYCLENODALA(AMO:NODALA)
                   DAR_VEIDS='Kapitâlâs izmaksas'
                   DAR_DAT=FORMAT(AMO:YYYYMM,@D06.)
                   VERT_SAK=AMO:KAPREM
                   VERT_BEI=0
                   DO PRINT_RPT_DETAIL
                   VERT_KAPK+=VERT_SAK
                   B_TIPS='K'
                   DO MAKE_B_TABLE
               .
               VERT_SAK=AMO:SAK_V_LI
!                 VERT_BEI=VERT_SAK-AMO:NOL_U_LI
               IF AMO:yyyymm=S_DAT THEN VERT_BEI=VERT_SAK-AMO:NOL_U_LI.
               VERT_BEI-=AMO:NOL_LIN
               IF ~VERT_SAK !NAV SÂKOTNÇJÂS VÇRTÎBAS APRÇÍINIEM
                  VERT_SAK=PAM:BIL_V
                  VERT_BEI=VERT_SAK
               .
            .
            IF INRANGE(PAM:END_DATE,S_DAT,B_DAT) AND ~CYCLENODALA(SAV_AMO_NODALA)
                DAR_VEIDS='Noòemts'
                DAR_DAT=FORMAT(PAM:END_DATE,@D06.)
                DO PRINT_RPT_DETAIL
                VERT_IZNSK+=VERT_SAK
                VERT_IZNBK+=VERT_BEI
                B_TIPS='N'
                DO MAKE_B_TABLE
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
  IF SEND(PAMAT,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP J#= 1 TO 3
       CASE J#
       OF 1
          KOPA='Iegâdâts kopâ :'
          VERT_SAKK=VERT_IEGK
          VERT_BEIK=0
          B_TIPS='I'
       OF 2
          KOPA='Kapitâlâs izmaksas :'
          VERT_SAKK=VERT_KAPK
          VERT_BEIK=0
          B_TIPS='K'
       OF 3
          KOPA='Noòemts kopâ :'
          VERT_SAKK=VERT_IZNSK
          VERT_BEIK=VERT_IZNBK
          B_TIPS='N'
       .
       IF VERT_SAKK
          BKK=''
          IF F:DBF='W'
             PRINT(RPT:LINE)
             PRINT(RPT:KOPA)
          ELSE
             OUTA:LINE=CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(VERT_SAKK,@N_11.2))&CHR(9)&|
             LEFT(FORMAT(VERT_BEIK,@N_11.2))
             ADD(OUTFILEANSI)
          END
          KOPA=' t.s.'
          GET(B_TABLE,0)
          LOOP I#= 1 TO RECORDS(B_TABLE)
             GET(B_TABLE,I#)
             IF B:TIPS   =B_TIPS
                BKK      =B:BKK
                VERT_SAKK=B:SUMMA1
                VERT_BEIK=B:SUMMA2
                IF F:DBF='W'
                   PRINT(RPT:KOPA)
                ELSE
                   OUTA:LINE=CHR(9)&KOPA&CHR(9)&CHR(9)&CHR(9)&BKK&CHR(9)&LEFT(FORMAT(VERT_SAKK,@N_11.2))&CHR(9)&|
                   LEFT(FORMAT(VERT_BEIK,@N_11.2))
                   ADD(OUTFILEANSI)
                END
                KOPA=''
             .
          .
       .
    .
    IF F:DBF='W'
        PRINT(RPT:REPFOOT)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    ENDPAGE(REPORT)
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
    PAMAT::Used -= 1
    IF PAMAT::Used = 0 THEN CLOSE(PAMAT).
    PAMAM::Used -= 1
    IF PAMAM::Used = 0 THEN CLOSE(PAMAM).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF<>'W' THEN F:DBF='W'.
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

!-----------------------------------------------------------------------------
PRINT_RPT_DETAIL  ROUTINE
  IF FIRST_PAM#=TRUE
     NPK#+=1
     RPT_NPK#=NPK#
  .
  IF F:DBF='W'
     PRINT(RPT:DETAIL)
  ELSE
     OUTA:LINE=NPK#&CHR(9)&PAM_U_NR&CHR(9)&PAM_NOS_P&CHR(9)&DAR_DAT&CHR(9)&|
     DAR_VEIDS&CHR(9)&LEFT(FORMAT(VERT_SAK,@N_11.2))&CHR(9)&LEFT(FORMAT(VERT_BEI,@N_11.2))
     ADD(OUTFILEANSI)
  END
  FIRST_PAM#=FALSE
  RPT_NPK#=0
  PAM_U_NR=0
  PAM_NOS_P=''

!-----------------------------------------------------------------------------
MAKE_B_TABLE ROUTINE
  B:KEY=B_TIPS&PAM:BKK
  GET(B_TABLE,B:KEY)
  IF ERROR()
    B:TIPS  =B_TIPS
    B:BKK   =PAM:BKK
    B:SUMMA1=VERT_SAK
    B:SUMMA2=VERT_BEI
    ADD(B_TABLE)
    SORT(B_TABLE,B:KEY)
  ELSE
    B:SUMMA1+=VERT_SAK
    B:SUMMA2+=VERT_BEI
    PUT(B_TABLE)
  .
GETGRUPA2            FUNCTION (NOM_G1G2,REQ,RET)  ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RET=1-NOSAUKUMS
!

  IF ~INRANGE(RET,1,1)
     RETURN('')
  .
  IF ~(GR2:GRUPA1=NOM_G1G2[1:3] AND GR2:GRUPA2=NOM_G1G2[4])
     CHECKOPEN(GRUPA2,1)
     GRUPA2::USED+=1
     CLEAR(GR2:RECORD)
     GR2:GRUPA1=NOM_G1G2[1:3]
     GR2:GRUPA2=NOM_G1G2[4]
     GET(GRUPA2,GR2:GR1_KEY)
     IF ERROR()
        IF REQ
           KLUDA(16,'GRUPA un ApakðGrupa: '&NOM_G1g2)
        .
        CLEAR(GR2:RECORD)
        GLOBALRESPONSE=REQUESTCANCELLED
        RET=0
     .
     GRUPA2::USED-=1
     IF GRUPA2::USED=0
        CLOSE(GRUPA2)
     .
  .
  GLOBALRESPONSE=REQUESTCOMPLETED
  EXECUTE RET+1
     RETURN('')
     RETURN(GR2:NOSAUKUMS)
  .
