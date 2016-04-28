                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetVesture           FUNCTION (PAR_U_NR,DOK_NR,RET) ! Declare Procedure
  CODE                                            ! Begin processed code
!
! RET: 1    -ATGRIEÞ DATUMU, LÎDZ KURAM JÂSAMAKSÂ
!      2,3,4-ATGRIEÞ SATURU
!      5    -ATGRIEÞ DOKUMENTA DATUMU
!      6    -ATGRIEÞ DOKUMENTA SUMMU
!      7    -ATGRIEÞ APMAKSAS SUMMU
!

 IF ~INRANGE(RET,1,7)
    STOP('GETVESTURE RET='&RET)
    RETURN('')
 .
 IF SYS:D_PA='N' !NEMEKLÇT VÇSTURI
    EXECUTE RET
      RETURN(DB_S_DAT) !1
      RETURN('')
      RETURN('')
      RETURN('')
      RETURN(DB_S_DAT) !5
      RETURN(0)        !6
    .
 ELSE
    IF PAR_U_NR AND DOK_NR
       IF VESTURE::USED=0
          CHECKOPEN(VESTURE,1)
          IF RECORDS(VESTURE)=0
             KLUDA(0,'Pagâðgad nav bûvçta norçíinu Vçsture')
             RETURN('')
          .
       .
       VESTURE::USED+=1
       CLEAR(VES:RECORD)
       VES:PAR_NR=PAR_U_NR
       VES:DOK_SENR=DOK_NR
       GET(VESTURE,VES:REF_KEY)
       IF ERROR()
          KLUDA(0,CLIP(GETPAR_K(PAR_U_NR,0,1))&' Vçsturç nav atrodams dokuments Nr '&DOK_NR)
          RET=0
       .
       VESTURE::USED-=1
       IF VESTURE::USED=0
          CLOSE(VESTURE)
       .
    ELSE
       RET=0
    .
    EXECUTE RET+1
      RETURN('')
      RETURN(VES:APMDAT)    !1
      RETURN(VES:SATURS)    !2
      RETURN(VES:SATURS2)   !3
      RETURN(VES:SATURS3)   !4
      RETURN(VES:DOKDAT)    !5
      RETURN(VES:SUMMA)     !6
      RETURN(VES:SAMAKSATS) !7
    .
 .
N_IEN_SOBJ           PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------
NR                   DECIMAL(4)
OBJ_NOSAUKUMS        STRING(25)
OBJ_NR               DECIMAL(3)
SUMMA_B              DECIMAL(12,2)
SUMMA_BK             DECIMAL(12,2)
SUMMA_P              DECIMAL(12,2)
SUMMA_PK             DECIMAL(13,2)
SUMMA_PVN            DECIMAL(12,2)
SUMMA_PVNK           DECIMAL(12,2)
DAUDZUMSK            DECIMAL(14,3)
KOPA                 STRING(7)
ITOGO                DECIMAL(14,2)
!!MUIK                 DECIMAL(10,2)
!!AKCIZK               DECIMAL(10,2)
!!CITASK               DECIMAL(10,2)
ITOGOK               DECIMAL(14,2)
TRANSK               DECIMAL(10,2)
VALK                 STRING(3)
KOPAA                STRING(7)
BKK                  STRING(5)
SB                   DECIMAL(13,2)
NOS_P                STRING(11)
DAT                  LONG
LAI                  LONG
CN                   STRING(10)
CP                   STRING(3)
SECIBA               STRING(30)
N_TABLE              QUEUE,PRE(N)
KEY                     DECIMAL(3)
U_NR                    ULONG
DAUDZUMS                DECIMAL(14,3)
SUMMA_B                 DECIMAL(14,2)
SUMMA_PVN               DECIMAL(14,2)
SUMMA_P                 DECIMAL(14,2)
VAL                     STRING(3)
T_SUMMA                 DECIMAL(9,2)
                     .
NOM_NOSAUKUMS           STRING(50)
N_DATUMS                LONG
N_NOMENKLAT             LIKE(NOL:NOMENKLAT)
SAV_NOMENKLAT           LIKE(NOL:NOMENKLAT)
SAV_U_NR                LIKE(NOL:U_NR)
K_TABLE                 QUEUE,PRE(K)
VAL                      STRING(3)
SUMMA_P                  DECIMAL(12,2)
                        .
B_TABLE                 QUEUE,PRE(B)
BKK                      STRING(5)
SUMMA                    DECIMAL(12,2)
                        .
MER                     STRING(7)
PAR_TEX                 STRING(5)
VIRSRAKSTS              STRING(110)

!------------------------------------------------------------------------
report REPORT,AT(146,1625,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(146,500,8000,1125),USE(?unnamed)
         STRING(@s45),AT(1635,73,4583,188),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6990,458,677,156),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,625,7500,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(156,1094,7500,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(4375,625,0,521),USE(?Line8:2),COLOR(COLOR:Black)
         LINE,AT(2760,625,0,521),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(521,1146,0,-521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,781,313,208),USE(?String16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Objekts'),AT(573,781,521,208),USE(?String16:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Objekta nosaukums'),AT(1146,781,1615,208),USE(?String16:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,1146,0,-521),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('Daudzums'),AT(2813,781,781,208),USE(?String16:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Bilances'),AT(3646,677,729,208),USE(?String16:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(4427,677,542,208),USE(?String16:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4427,885,542,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Transp.'),AT(6146,677,521,208),USE(?String16:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6094,625,0,521),USE(?Line18:2),COLOR(COLOR:Black)
         LINE,AT(5052,625,0,521),USE(?Line81:2),COLOR(COLOR:Black)
         STRING('Vçrtîba'),AT(5104,677,990,208),USE(?String16:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ,'),AT(6719,677,938,208),USE(?String16:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7656,625,0,521),USE(?Line10:3),COLOR(COLOR:Black)
         STRING(@s3),AT(6719,885,938,208),USE(val_uzsk,,?val_uzsk:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6667,625,0,521),USE(?Line38:2),COLOR(COLOR:Black)
         STRING('vçrtîba, '),AT(3615,885,448,208),USE(?String16:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4052,885,323,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('pçc P/Z, '),AT(5094,885,667,208),USE(?String16:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5781,885,313,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6188,885,469,208),USE(val_uzsk,,?val_uzsk:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3594,625,0,521),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(156,1146,0,-521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s110),AT(177,292,7531,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(156,-10,0,198),USE(?Line12),COLOR(COLOR:Black)
         STRING(@N4),AT(208,10,260,156),USE(NR),RIGHT
         STRING(@N3),AT(677,10,260,156),USE(OBJ_NR),RIGHT
         LINE,AT(1094,-10,0,198),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(2760,-10,0,198),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,198),USE(?Line12:5),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(2813,10,729,156),USE(N:DAUDZUMS),RIGHT
         STRING(@N-_12.2),AT(3646,10,677,156),USE(N:SUMMA_B),RIGHT
         LINE,AT(6667,-10,0,198),USE(?Line12:10),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,198),USE(?Line12:6),COLOR(COLOR:Black)
         STRING(@N-_10.2),AT(4427,10,573,156),USE(N:SUMMA_PVN),RIGHT
         LINE,AT(5052,-10,0,198),USE(?Line12:7),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,198),USE(?Line12:9),COLOR(COLOR:Black)
         STRING(@N-_12.2),AT(5333,10,677,156),USE(N:SUMMA_P),RIGHT
         STRING(@N_10.2),AT(6146,10,521,156),USE(N:T_SUMMA),RIGHT
         STRING(@N-_14.2),AT(6719,10,885,156),USE(itogo),RIGHT
         STRING(@s25),AT(1146,10,1615,156),USE(OBJ_NOSAUKUMS),LEFT,FONT(,,,,CHARSET:BALTIC)
         LINE,AT(7656,-10,0,198),USE(?Line12:8),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),USE(?Line12:2),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(156,0,0,115),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(521,0,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(2760,0,0,63),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(3594,0,0,115),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,115),USE(?Line119:11),COLOR(COLOR:Black)
         LINE,AT(5052,0,0,115),USE(?Line19:14),COLOR(COLOR:Black)
         LINE,AT(6094,0,0,115),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(6667,0,0,115),USE(?Line19:15),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,115),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(156,52,7500,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177)
         LINE,AT(156,-10,0,198),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,198),USE(?Line19:11),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,198),USE(?Line19:19),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line19:6),COLOR(COLOR:Black)
         STRING(@s7),AT(365,10,469,156),USE(KOPA),LEFT
         LINE,AT(6094,-10,0,198),USE(?Line19:23),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,198),USE(?Line19:20),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line19:7),COLOR(COLOR:Black)
         STRING(@N-_14.3B),AT(2708,10,833,156),USE(DAUDZUMSk),RIGHT
         STRING(@N-_13.2B),AT(3646,10,677,156),USE(Summa_BK),RIGHT
         STRING(@N-_10.2B),AT(4427,10,573,156),USE(SUMMA_PVNk),RIGHT
         STRING(@N-_13.2),AT(5333,10,677,156),USE(Summa_PK),RIGHT
         STRING(@N_10.2B),AT(6146,10,521,156),USE(TRANSk),RIGHT
         STRING(@N-_14.2B),AT(6719,10,885,156),USE(itogok),RIGHT
       END
RPT_FOOT2A DETAIL,AT(,,,177)
         STRING(@s5),AT(3021,10,365,156),USE(BKK),LEFT
         LINE,AT(6094,-10,0,198),USE(?Line19:13),COLOR(COLOR:Black)
         STRING(@N-_13.2),AT(3646,10,677,156),USE(SB),RIGHT
         LINE,AT(6667,-10,0,198),USE(?Line19:9),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line19:10),COLOR(COLOR:Black)
         STRING(@s7),AT(365,10,469,156),USE(KOPAA),LEFT
         LINE,AT(4375,-10,0,198),USE(?Line193:24),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line139:24),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,198),USE(?Line19:12),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,198),USE(?Line19:8),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,229),USE(?unnamed:2)
         LINE,AT(156,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(3594,-10,0,63),USE(?Line35:5),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,63),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line35:4),COLOR(COLOR:Black)
         LINE,AT(6094,-10,0,63),USE(?Line35:3),COLOR(COLOR:Black)
         LINE,AT(6667,-10,0,63),USE(?Line135),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(146,52,7500,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(146,83,490,146),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(677,83,458,146),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1344,83,260,146),USE(?String54),FONT(,7,,,CHARSET:ANSI)
         STRING(@s1),AT(1656,83,156,146),USE(RS),CENTER,FONT(,7,,,CHARSET:ANSI)
         STRING(@D06.),AT(6594,83),USE(DAT),FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7208,83),USE(LAI),FONT(,7,,,CHARSET:ANSI)
       END
       FOOTER,AT(146,10500,8000,63)
         LINE,AT(156,0,7500,0),USE(?Line1:5),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Apturçt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  NR=0
  DAT = TODAY()
  LAI = CLOCK()
  DAUDZUMSK=0
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0        !DÇÏ GETPAVAD
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          
  IF NOM_K::Used = 0        !DÇÏ GETNOM_K
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1          
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::Used += 1
  IF NOLIK::Used = 0        !DÇÏ VIEWA
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  BIND('CN',CN)
!!  BIND('CP',CP)
!!  BIND('CYCLEPAR_K',CYCLEPAR_K)
!!  BIND('CYCLENOM',CYCLENOM)
  BIND('CYCLENOL',CYCLENOL)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Ienâkuðâs preces, S_Obj(Proj)'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      VIRSRAKSTS='Izziòa par ienâkuðajâm ('&D_K&') precçm (S_Objektiem) no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
      CN='N10111'
!         123456
!      CP='N11'
!         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!                                     123456789

      CLEAR(nol:RECORD)
      NOL:DATUMS=S_DAT
      SET(nol:DAT_KEY,nol:DAT_KEY)
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
          IF ~OPENANSI('IENOBJ.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Npk'&CHR(9)&'OBJ'&CHR(9)&'Objekta Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&|
!             'PVN,Ls'&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk'&CHR(9)&'OBJ'&CHR(9)&'Objekta Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances'&CHR(9)&|
             'PVN,'&val_uzsk&CHR(9)&'Vçrtîba'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba,Ls'&CHR(9)&CHR(9)&'ar PVN'&CHR(9)&CHR(9)&'(P/Z)'
             OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'vçrtîba,'&val_uzsk&CHR(9)&CHR(9)&'ar PVN'&CHR(9)&CHR(9)&'(P/Z)'
             ADD(OUTFILEANSI)
          ELSE
!             OUTA:LINE='Npk'&CHR(9)&'OBJ'&CHR(9)&'Objekta Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba,Ls'&CHR(9)&|
!             'PVN,Ls'&CHR(9)&'Vçrtîba ar PVN'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, Ls'
             OUTA:LINE='Npk'&CHR(9)&'OBJ'&CHR(9)&'Objekta Nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Bilances vçrtîba,'&val_uzsk&CHR(9)&|
             'PVN,'&val_uzsk&CHR(9)&'Vçrtîba ar PVN'&CHR(9)&CHR(9)&'Transports'&CHR(9)&'Kopâ, '&val_uzsk
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN)
!           C#=GETPAVADZ(NOL:U_NR)
           GET(N_TABLE,0)
           N:KEY=NOL:OBJ_NR
           GET(N_TABLE,N:KEY)
           IF ERROR()
               N:KEY      =NOL:OBJ_NR
               N:DAUDZUMS =NOL:DAUDZUMS
               N:SUMMA_B  =calcsum(15,2)        ! Ls
               N:SUMMA_P  =CALCSUM(16,2)        ! Ls
               N:SUMMA_PVN=CALCSUM(17,2)        ! Ls
               N:T_SUMMA  =NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
               ADD(N_TABLE)
               SORT(N_TABLE,N:KEY)
           ELSE
               N:DAUDZUMS +=NOL:DAUDZUMS
               N:SUMMA_B  +=calcsum(15,2)        ! Ls
               N:SUMMA_P  +=CALCSUM(16,2)        ! Ls
               N:SUMMA_PVN+=CALCSUM(17,2)        ! Ls
               N:T_SUMMA  +=NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
               PUT(N_TABLE)
           END
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    SORT(N_TABLE,N:KEY)
    LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        nr+=1
        OBJ_NR = N:KEY
!!        IF ~(SAV_U_NR=N:U_NR)
!!           G#=GETPAVADZ(N:U_NR)                        !POZICIONÇ PAVADZÎMES
!!           SAV_U_NR=N:U_NR
!!        .
!!        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)                !POZICIONÇ NOM_K
!!           NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,2)
!!           NOM_KAT = NOM:KATALOGA_NR
!!           SAV_NOMENKLAT=N_NOMENKLAT
!!        .
        OBJ_NOSAUKUMS = GETPROJEKTI(N:KEY,1)
        ITOGO = N:SUMMA_B + N:SUMMA_PVN + N:T_SUMMA  !LS
        DAUDZUMSK   += N:DAUDZUMS           ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B            ! BEZ PVN LS-A
        SUMMA_PVNK  += N:SUMMA_PVN          ! PVN LS-A
        SUMMA_PK    += N:SUMMA_P            ! AR PVN -A Ls
        TRANSK      += N:T_SUMMA            ! Ls
        ITOGOK      += ITOGO                ! Ls
        IF ~F:DTK
          IF F:DBF='W'
            PRINT(RPT:DETAIL)
          ELSE
            OUTA:LINE=NR&CHR(9)&OBJ_NR&CHR(9)&OBJ_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_14.3))&CHR(9)&|
            LEFT(FORMAT(N:SUMMA_B,@N_12.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_PVN,@N_11.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_P,@N_12.2))&|
            CHR(9)&N:VAL&CHR(9)&LEFT(FORMAT(N:T_SUMMA,@N_9.2))&CHR(9)&LEFT(FORMAT(ITOGO,@N_14.2))
            ADD(OUTFILEANSI)
          .
        .
!*************************SADALAM PÇC BKK*******************
        IF NOM:BKK=''
          IF NOM:TIPS='P' OR NOM:TIPS=''
            BKK=SYS:D_PR
          ELSE
            BKK=SYS:D_TA
          .
        ELSE
          BKK=NOM:BKK
        .
        FOUND#=0
        LOOP J#=1 TO RECORDS(B_TABLE)
          GET(B_TABLE,J#)
          IF B:BKK=BKK
            B:SUMMA+=CALCSUM(15,2)
            PUT(B_TABLE)
            FOUND#=1
            BREAK
          .
        .
        IF ~FOUND#
          B:BKK=BKK
          B:SUMMA =CALCSUM(15,2)
          ADD(B_TABLE)
        .
    END
    FREE(N_TABLE)
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    .
!****************************DRUKÂJAM PÇC valûtâm **************
    KOPA='Kopâ:'
!    VALK = 'Ls'
    VALK = val_uzsk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT2)
    ELSE
        OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N_12.2))&|
        CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N_11.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N_12.2))&CHR(9)&VALK&CHR(9)&|
        LEFT(FORMAT(TRANSK,@N_9.2))&CHR(9)&LEFT(FORMAT(ITOGOK,@N_14.2))
        ADD(OUTFILEANSI)
    .
!!    DAUDZUMSK  = 0
!!    SUMMA_BK   = 0
!!    SUMMA_PVNK = 0
!!    SUMMA_PK   = 0
!!    TRANSK     = 0
!!    ITOGOK     = 0
!!    KOPA = 't.s.'
!!    GET(K_TABLE,0)
!!    LOOP J# = 1 TO RECORDS(K_TABLE)
!!      GET(K_TABLE,J#)
!!      IF K:SUMMA_P>0
!!        SUMMA_PK = K:SUMMA_P
!!        VALK     = K:VAL
!!        IF F:DBF='W'
!!            PRINT(RPT:RPT_FOOT2)
!!        ELSE
!!            OUTA:LINE=FORMAT(KOPA,@S6)&CHR(9)&'   '&CHR(9)&' {19}'&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N11.2)&CHR(9)&FORMAT(SUMMA_PK,@N12.2)&CHR(9)&VALK&CHR(9)&FORMAT(TRANSK,@N9.2)&CHR(9)&FORMAT(ITOGOK,@N14.2)
!!            ADD(OUTFILEANSI)
!!        END
!!        kopa=''
!!      .
!!    .
!****************************DRUKÂJAM PÇC BKK*******************
!!    KOPAa='t.s.'
!!    GET(B_TABLE,0)
!!    LOOP J# = 1 TO RECORDS(B_TABLE)
!!      GET(B_TABLE,J#)
!!      IF B:SUMMA <> 0
!!        SB  =B:SUMMA
!!        BKK =B:BKK
!!        IF F:DBF='W'
!!            PRINT(RPT:RPT_FOOT2A)
!!        ELSE
!!            OUTA:LINE=KOPAA&CHR(9)&format(BKK,@S5)&CHR(9)&' {100}'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&FORMAT(SB,@N12.2)
!!            ADD(OUTFILEANSI)
!!        END
!!        KOPAA=''
!!        SB=0
!!      .
!!    .
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT3)
        ENDPAGE(report)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  IF F:DBF='E' THEN F:DBF='W'.
  POPBIND
  FREE(K_TABLE)
  FREE(B_TABLE)
  FREE(N_TABLE)
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
!!  IF NOMENKLAT[1]            !TIEK GRIEZTS NOMENKLATÛRU SECÎBÂ
!!    IF ERRORCODE() OR CYCLENOM(NOL:NOMENKLAT)=2 THEN VISS#=TRUE.
!!  ELSE
    IF ERRORCODE() OR NOL:DATUMS>B_DAT THEN VISS#=TRUE.
!!  .
  IF VISS#=TRUE
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
N_Izg_SOBJ           PROCEDURE                    ! Declare Procedure
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
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END
!------------------------------------------------------------------------
SUMMA_B                 DECIMAL(12,2)
SUMMA_BK                DECIMAL(12,2)
SUMMA_PVN               DECIMAL(12,2)
SUMMA_PVNK              DECIMAL(12,2)
SUMMA_P                 DECIMAL(14,2)
SUMMA_PK                DECIMAL(14,2)
!ITOGO                   DECIMAL(14,2)
!ITOGOK                  DECIMAL(14,2)
!TRANSK                  DECIMAL(10,2)
NPK                     DECIMAL(4)
DAUDZUMSK               DECIMAL(14,3)
KOPA                    STRING(5)
VALK                    STRING(3)
PARKOP                  DECIMAL(12,2)
DAT                     LONG
LAI                     LONG
CN                      STRING(10)
CP                      STRING(3)
SECIBA                  STRING(30)

!K_TABLE                 QUEUE,PRE(K)
!VAL                        STRING(3)
!SUMMA_P                    DECIMAL(14,2)
!                        .

N_TABLE              QUEUE,PRE(N)
OBJ_NR                  ULONG
DAUDZUMS                DECIMAL(12,3)
SUMMA_B                 DECIMAL(12,2)
SUMMA_PVN               DECIMAL(11,2)
SUMMA_P                 DECIMAL(14,2)
!VAL                     STRING(3)
!T_SUMMA                 DECIMAL(9,2)
                     .
N_DATUMS                LONG
N_NOMENKLAT             LIKE(NOL:NOMENKLAT)
SAV_NOMENKLAT           LIKE(NOL:NOMENKLAT)
!SAV_U_NR                LIKE(NOL:U_NR)
!MER                     STRING(7)
OBJ_NOSAUKUMS           STRING(35)

VIRSRAKSTS              STRING(100)

!--------------------------------------------------------------------------
report REPORT,AT(198,1719,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,500,8000,1219),USE(?unnamed:4)
         STRING(@P<<<#. lapaP),AT(7083,521,573,156),PAGENO,USE(?PageCount),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,729,7500,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,729,0,521),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('NPK'),AT(208,885,313,208),USE(?String17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Objekts'),AT(573,885,469,208),USE(?String17:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(2760,885,781,208),USE(?String17:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('PVN, '),AT(4427,792,625,208),USE(?String17:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4406,1000,625,208),USE(val_uzsk,,?val_uzsk:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Kopâ'),AT(5198,781,802,208),USE(?String17:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(3594,781,781,208),USE(?String17:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2708,729,0,521),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Objekta nosaukums'),AT(1094,885,1615,208),USE(?String17:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('bez PVN, '),AT(3563,990,542,208),USE(?String17:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(4052,990,323,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('ar PVN, '),AT(5125,990,646,208),USE(?String17:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(5771,990,302,208),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,1198,7500,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(1042,729,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(3542,729,0,521),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(4375,729,0,521),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(5052,729,0,521),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6146,729,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         LINE,AT(6823,729,0,521),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(7656,729,0,521),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(156,729,0,521),USE(?Line2),COLOR(COLOR:Black)
         STRING(@s45),AT(1469,52,4271,219),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(177,302,7490,208),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
       END
detail DETAIL,AT(,,,177),USE(?unnamed:2)
         LINE,AT(156,-10,0,198),USE(?Line11),COLOR(COLOR:Black)
         STRING(@n_4),AT(208,10,260,156),USE(npk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(521,-10,0,198),USE(?Line11:2),COLOR(COLOR:Black)
         STRING(@N_7),AT(552,0,469,156),USE(N:OBJ_NR),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(6823,-10,0,198),USE(?Line11:8),COLOR(COLOR:Black)
         STRING(@n-_10.2),AT(4427,10,573,156),USE(N:SUMMA_Pvn),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(1042,-10,0,198),USE(?Line11:3),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,198),USE(?Line11:10),COLOR(COLOR:Black)
         STRING(@n-_12.3),AT(2760,10,729,156),USE(N:DAUDZUMS),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(4375,-10,0,198),USE(?Line11:5),COLOR(COLOR:Black)
         LINE,AT(6146,-10,0,198),USE(?Line11:7),COLOR(COLOR:Black)
         STRING(@s35),AT(1073,10,1615,156),USE(OBJ_NOSAUKUMS),LEFT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_12.2),AT(3594,10,729,156),USE(N:SUMMA_B),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3542,-10,0,198),USE(?Line11:4),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line11:6),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5323,10,729,156),USE(N:SUMMA_P),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(7656,-10,0,198),USE(?Line11:9),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,94)
         LINE,AT(156,0,0,115),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(156,52,7500,0),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(3542,0,0,115),USE(?Line28:3),COLOR(COLOR:Black)
         LINE,AT(5052,0,0,115),USE(?Line28:4),COLOR(COLOR:Black)
         LINE,AT(6146,0,0,115),USE(?Line28:6),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,115),USE(?Line28:5),COLOR(COLOR:Black)
         LINE,AT(7656,0,0,115),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(4375,0,0,115),USE(?Line28),COLOR(COLOR:Black)
         LINE,AT(1042,0,0,63),USE(?Line27),COLOR(COLOR:Black)
         LINE,AT(2708,0,0,63),USE(?Line27:2),COLOR(COLOR:Black)
         LINE,AT(521,0,0,63),USE(?Line23),COLOR(COLOR:Black)
       END
RPT_FOOT2 DETAIL,AT(,,,177),USE(?unnamed:3)
         LINE,AT(4375,-10,0,198),USE(?Line21:3),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,198),USE(?Line21:4),COLOR(COLOR:Black)
         STRING(@n-_14.3b),AT(2656,10,833,156),USE(DAUDZUMSk),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_12.2B),AT(3594,10,729,156),USE(SUMMA_BK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@n-_10.2B),AT(4427,10,573,156),USE(SUMMA_PvnK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(3542,-10,0,198),USE(?Line21:8),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,198),USE(?Line21:6),COLOR(COLOR:Black)
         LINE,AT(6146,-10,0,198),USE(?Line21:7),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,198),USE(?Line21:5),COLOR(COLOR:Black)
         STRING(@n-_14.2),AT(5333,10,729,156),USE(SUMMA_PK),RIGHT,FONT(,8,,,CHARSET:BALTIC)
         STRING(@s5),AT(521,10,365,156),USE(KOPA),LEFT,FONT(,8,,,CHARSET:BALTIC)
         LINE,AT(156,-10,0,198),USE(?Line21:2),COLOR(COLOR:Black)
       END
RPT_FOOT3 DETAIL,AT(,,,240),USE(?unnamed)
         LINE,AT(156,-10,0,63),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(4375,-10,0,63),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7656,-10,0,63),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(3542,-10,0,63),USE(?Line35:2),COLOR(COLOR:Black)
         LINE,AT(156,52,7500,0),USE(?Line22:2),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(177,73,573,156),USE(?String50),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(750,73,458,156),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING('RS :'),AT(1427,73,260,156),USE(?String52),FONT(,7,,,CHARSET:BALTIC)
         STRING(@s1),AT(1688,73,125,156),USE(RS),CENTER,FONT(,7,,,CHARSET:BALTIC)
         STRING(@D06.),AT(6729,73,521,156),USE(dat),FONT(,7,,,CHARSET:BALTIC)
         STRING(@T4),AT(7281,73,417,156),USE(LAI),FONT(,7,,,CHARSET:BALTIC)
         LINE,AT(6146,-10,0,63),USE(?Line235),COLOR(COLOR:Black)
         LINE,AT(6823,-10,0,63),USE(?Line335),COLOR(COLOR:Black)
         LINE,AT(5052,-10,0,63),USE(?Line535),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,10500,8000,63)
         LINE,AT(156,0,7500,0),USE(?Line22:3),COLOR(COLOR:Black)
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
!
!****************REALIZÇTS VISIEM PARTNERIEM
!
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  BIND('CN',CN)
  BIND('CP',CP)
  BIND('CYCLEPAR_K',CYCLEPAR_K)
  BIND('CYCLENOL',CYCLENOL)

  KOPA='t.s.  '
  DAT = TODAY()
  LAI = CLOCK()
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF PAVAD::Used = 0        !DÇÏ GETPAVAD
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1          
  IF NOM_K::Used = 0        !DÇÏ GETNOM_K
    CheckOpen(NOM_K,1)
  END
  NOM_K::Used += 1          
  IF PAR_K::Used = 0        !DÇÏ CYCLEPAR_K
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  IF VAL_K::Used = 0        !DÇÏ BANKURS
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  IF KURSI_K::Used = 0      !DÇÏ BANKURS
    CheckOpen(KURSI_K,1)
  END
  KURSI_K::Used += 1
  IF NOLIK::Used = 0        !DÇÏ VIEWA
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1

  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Izgâjuðâs preces, S_Obj(Proj)'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow

      VIRSRAKSTS='Izziòa par izgâjuðajâm ('&D_K&') precçm (S_Objektiem) no '&format(S_DAT,@d06.)&' lîdz '&|
      format(B_DAT,@d06.)&' Noliktava: '&clip(loc_nr)&' '&SYS:AVOTS
!         FILTRS_TEXT=GETFILTRS_TEXT('100000000') !1-OBJ,2-NOD,3-PART,4-PARG,5-NOM,6-NOMT,7-DN,8-(1:parâdi),9-ID
!!                                    123456789
!!      CP = 'N11'
      CN = 'N10111'
!           123456

      CLEAR(nol:RECORD)
      NOL:DATUMS=S_DAT
      SET(nol:DAT_KEY,nol:DAT_KEY)
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
          IF ~OPENANSI('IZGOBJ.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          IF F:DBF='E'
!             OUTA:LINE='Npk'&CHR(9)&'Objekta'&CHR(9)&'Objekta'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Kopâ'
             OUTA:LINE='Npk'&CHR(9)&'Objekta'&CHR(9)&'Objekta'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez'&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Kopâ'
             ADD(OUTFILEANSI)
!             OUTA:LINE=CHR(9)&'Nr'&CHR(9)&'nosaukums'&CHR(9)&CHR(9)&'PVN, Ls'&CHR(9)&CHR(9)&'ar PVN, Ls'
             OUTA:LINE=CHR(9)&'Nr'&CHR(9)&'nosaukums'&CHR(9)&CHR(9)&'PVN, '&val_uzsk&CHR(9)&CHR(9)&'ar PVN, '&val_uzsk
             ADD(OUTFILEANSI)
           ELSE !WORD
!             OUTA:LINE='Npk'&CHR(9)&'Objekta Nr'&CHR(9)&'Objekta nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN, Ls'&CHR(9)&|
!             'PVN, Ls'&CHR(9)&'Kopâ ar PVN, Ls'
             OUTA:LINE='Npk'&CHR(9)&'Objekta Nr'&CHR(9)&'Objekta nosaukums'&CHR(9)&'Daudzums'&CHR(9)&'Summa bez PVN, '&val_uzsk&CHR(9)&|
             'PVN, '&val_uzsk&CHR(9)&'Kopâ ar PVN, '&val_uzsk
             ADD(OUTFILEANSI)
          .
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        IF ~CYCLENOL(CN) !!AND ~CYCLEPAR_K(CP)
!           C#=GETPAVADZ(NOL:U_NR)
           GET(N_TABLE,0)
!           N:OBJ_NR=PAV:OBJ_NR
           N:OBJ_NR=NOL:OBJ_NR
           GET(N_TABLE,N:OBJ_NR)
           IF ERROR()
!               N:OBJ_NR      = PAV:OBJ_NR
               N:OBJ_NR      = NOL:OBJ_NR
               N:DAUDZUMS =NOL:DAUDZUMS
               N:SUMMA_B  =calcsum(15,2)        ! Ls
               N:SUMMA_P  =CALCSUM(16,2)        ! Ls
               N:SUMMA_PVN=CALCSUM(17,2)        ! Ls
!               N:VAL      =NOL:VAL
!               N:T_SUMMA  =NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS)
               ADD(N_TABLE)
               SORT(N_TABLE,N:OBJ_NR)
           ELSE
               N:DAUDZUMS +=NOL:DAUDZUMS
               N:SUMMA_B  +=calcsum(15,2)        ! Ls
               N:SUMMA_P  +=CALCSUM(16,2)        ! Ls
               N:SUMMA_PVN+=CALCSUM(17,2)        ! Ls
!               N:T_SUMMA  +=NOL:T_SUMMA*BANKURS(NOL:VAL,NOL:DATUMS) K NEVAR BÛT....
               PUT(N_TABLE)
           END
        END
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     LOOP I#=1 TO RECORDS(N_TABLE)
        GET(N_TABLE,I#)
        npk+=1
!!        IF F:SECIBA='N'              !NOMENKLATÛRU SECÎBA
!!           N_NOMENKLAT=N:KEY[1:21]
!!           N_DATUMS   =N:KEY[22:26]
!!        ELSE
!!           N_NOMENKLAT=N:KEY[6:26]
!!           N_DATUMS   =N:KEY[1:5]
!!        .
!!        IF ~(SAV_U_NR=N:U_NR)
!!           G#=GETPAVADZ(N:U_NR)                        !POZICIONÇ PAVADZÎMES
!!           SAV_U_NR=N:U_NR
!!        .
!!        IF ~(SAV_NOMENKLAT=N_NOMENKLAT)
!!           NOM_NOSAUKUMS=GETNOM_K(N_NOMENKLAT,2,2)
!!           NOM_KAT = NOM:KATALOGA_NR
!!           SAV_NOMENKLAT=N_NOMENKLAT
!!        .
        OBJ_NOSAUKUMS = GETPROJEKTI(N:OBJ_NR,1)
!        ITOGO = N:SUMMA_B + N:SUMMA_PVN      !LS
        DAUDZUMSK   += N:DAUDZUMS            ! SKAITA KOPÂ DAUDZUMUS, ANYWAY
        SUMMA_BK    += N:SUMMA_B             ! BEZ PVN LS
        SUMMA_PVNK  += N:SUMMA_PVN           ! PVN LS
        SUMMA_PK    += N:SUMMA_B+N:SUMMA_PVN ! AR PVN LS
!        TRANSK      += N:T_SUMMA             ! Ls
!        ITOGOK      += ITOGO                 ! Ls
        IF ~F:DTK
          IF F:DBF='W'
             PRINT(RPT:DETAIL)
          ELSE
             OUTA:LINE=Npk&CHR(9)&N:OBJ_NR&CHR(9)&OBJ_NOSAUKUMS&CHR(9)&LEFT(FORMAT(N:DAUDZUMS,@N-_14.3))&CHR(9)&|
             LEFT(FORMAT(N:SUMMA_B,@N-_12.2))&CHR(9)&LEFT(FORMAT(N:SUMMA_PVN,@N-_10.2))&CHR(9)&|
             LEFT(FORMAT(N:SUMMA_P,@N-_14.2))
             ADD(OUTFILEANSI)
          .
        .
     .
     FREE(N_TABLE)
     IF F:DBF='W'
         PRINT(RPT:RPT_FOOT1)
     .
!!****************************DRUKÂJAM KopÂ **************
     KOPA='Kopâ:'
!     VALK = 'Ls'
     VALK = val_uzsk
     IF F:DBF='W'
         PRINT(RPT:RPT_FOOT2)
     ELSE
         OUTA:LINE=KOPA&CHR(9)&CHR(9)&CHR(9)&LEFT(FORMAT(DAUDZUMSK,@N-_14.3))&CHR(9)&LEFT(FORMAT(SUMMA_BK,@N-_12.2))&|
         CHR(9)&LEFT(FORMAT(SUMMA_PVNK,@N-_10.2))&CHR(9)&LEFT(FORMAT(SUMMA_PK,@N-_14.2))
         ADD(OUTFILEANSI)
     .
!!     DAUDZUMSK  = 0
!!     SUMMA_BK   = 0
!!     SUMMA_PVNK = 0
!!     SUMMA_PK   = 0
!!     TRANSK     = 0
!!     ITOGOK     = 0
!!     KOPA='t.s.'
!!     LOOP J# = 1 TO RECORDS(K_TABLE)
!!       GET(K_TABLE,J#)
 !     IF RECORDS(K_TABLE)=1 AND K:NOS='Ls' THEN BREAK.
!!       IF K:SUMMA_P
!!         SUMMA_PK = K:SUMMA_P
!!         VALK     = K:VAL
!!         IF F:DBF='W'
!!             PRINT(RPT:RPT_FOOT2)
!!         ELSE
!!             OUTA:LINE=FORMAT(KOPA,@s6)&CHR(9)&'   '&CHR(9)&' {19}'&CHR(9)&FORMAT(DAUDZUMSK,@N-_14.3)&CHR(9)&FORMAT(SUMMA_BK,@N-_12.2)&CHR(9)&FORMAT(SUMMA_PVNK,@N-_10.2)&CHR(9)&FORMAT(SUMMA_PK,@N-_14.2)&CHR(9)&VALK&CHR(9)&FORMAT(TRANSK,@N-_10.2)&CHR(9)&FORMAT(ITOGOK,@N-_14.2)
!!             ADD(OUTFILEANSI)
!!         END
!!         KOPA=''
!!       .
!!     .
     IF F:DBF='W'
         PRINT(RPT:RPT_FOOT3)
         ENDPAGE(report)
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
    NOM_K::Used -= 1
    IF NOM_K::Used = 0 THEN CLOSE(NOM_K).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
    KURSI_K::Used -= 1
    IF KURSI_K::Used = 0 THEN CLOSE(KURSI_K).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
!  FREE(K_TABLE)
  FREE(N_TABLE)
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
!  IF NOMENKLAT[1]                        !TIEK GRIEZTS NOMENKLATÛRU SECÎBÂ
!    IF ERRORCODE() OR CYCLENOM(NOL:NOMENKLAT)=2 THEN VISS#=TRUE.
!  ELSE
    IF ERRORCODE() OR NOL:DATUMS>B_DAT THEN VISS#=TRUE.
!  .
  IF VISS#=TRUE
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
