                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetAutoApk           FUNCTION (PAV_NR,RET)        ! Declare Procedure
AUT_PERSKODS   STRING(12)
  CODE                                            ! Begin processed code
  IF ~INRANGE(RET,1,3)
     KLUDA(0,'KÏÛDA IZSAUCOT F-ju GETAUTOAPK:'&RET)
     RETURN('')
  .
  IF PAV_NR=0
     return('')
  ELSE
     IF AUTOAPK::USED=0
        CHECKOPEN(AUTOAPK,1)
     .
     AUTOAPK::USED+=1
     CLEAR(APK:RECORD)
     APK:PAV_NR=PAV_NR
     GET(AUTOAPK,APK:PAV_KEY)
     IF ERROR()
        RET=0
     .
  .
  AUTOAPK::USED-=1
  IF AUTOAPK::USED=0
     CLOSE(AUTOAPK)
  .
  EXECUTE RET+1
     return('')
     return('Nobraukums '&APK:Nobraukums&' km.') !1
     return(APK:Nobraukums&' km.')               !2
     return(APK:Nobraukums)                      !3
  .
SelftestAlga         PROCEDURE                    ! Declare Procedure
KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME

PUTALGAS             BYTE
PUTKADRI             BYTE
PUTPERNOS            BYTE
LASTONE              BYTE
ALP_APRIIN           LIKE(ALP:APRIIN)

LocalRequest         LONG
LocalResponse        LONG
rakstsggk            byte
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO

!----------------------------------------
report REPORT,AT(200,105,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',10,,,CHARSET:BALTIC), |
         THOUS
header DETAIL,AT(,,,948)
         STRING(@s45),AT(1458,104,5521,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('VS "WinLats"  paðtests  - ALGAS:'),AT(1583,573),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4688,573),USE(SYS:AVOTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_2),AT(4115,594),USE(LOC_NR),RIGHT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s90),AT(208,21,7344,156),USE(KOMENT),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
footer DETAIL,AT(,,,229),USE(?unnamed)
         LINE,AT(104,52,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@t4),AT(7229,83),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(156,83),USE(?String5),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,83),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6667,83),USE(dat),FONT(,7,,,CHARSET:ANSI)
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
  CHECKOPEN(ALGPA,1)
  ALGPA::used+=1
  CHECKOPEN(ALGAS,1)
  ALGAS::used+=1
  CHECKOPEN(PERNOS,1)
  PERNOS::used+=1
  CHECKOPEN(KADRI,1)
  KADRI::used+=1
  CHECKOPEN(DAIEV,1)
  DAIEV::used+=1

  CLEAR(ALP:RECORD)
  PUTALGAS=FALSE
  PUTPERNOS=FALSE
  LASTONE=FALSE
  dat=today()
  lai=clock()
  FilesOpened = True

  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Selftest (Paðtests)'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  IF F:ATL   !JÂPÂRBAUDA ATVAÏINÂJUMI UN SLIMÎBAS LAPAS
     RecordsToProcess = RECORDS(ALGAS)+RECORDS(PERNOS)
  ELSE
     RecordsToProcess = RECORDS(ALGAS)
  .
  DISPLAY()
  OPEN(report)
  report{Prop:Preview} = PrintPreviewImage
  PRINT(rpt:header)
  SET(ALG:ID_key)
  LOOP
     NEXT(ALGAS)
     IF ERROR()
        LASTONE=TRUE
        BREAK
     .
     PUTALGAS=FALSE
     PUTKADRI=FALSE
     DO COUNTER
     IF ~(ALP:YYYYMM=ALG:YYYYMM)
        IF ALP:YYYYMM
           DO CHECKALPA
        .
        clear(ALP:record)
        ALP:YYYYMM=ALG:YYYYMM
        GET(ALGPA,ALP:YYYYMM_KEY)
        IF ERROR()
           KLUDA(5,'ALGAS-ALGPA'&FORMAT(ALG:YYYYMM,@D6))
           IF klu_darbiba
              CLEAR(ALP:RECORD)
              ALP:YYYYMM=ALG:YYYYMM
              ALP:STATUSS='Algu saraksts'
              ADD(ALGPA)
              IF ERROR()
                 KOMENT='Relâcijas kïûda ALGAS-ALGPA :'&FORMAT(ALG:YYYYMM,@D6)&' Rakstu nav iespçjams atjaunot'
                 print(rpt:detail)
                 CYCLE
              ELSE
                 KOMENT='Relâcijas kïûda ALGAS-ALGPA :'&FORMAT(ALG:YYYYMM,@D6)&' Raksts ir atjaunots'
                 print(rpt:detail)
              .
           ELSE
              KOMENT='Relâcijas kïûda ALGAS-ALGPA :'&FORMAT(ALG:YYYYMM,@D6)&' LIETOTÂJA ATTEIKUMS atjaunot'
              print(rpt:detail)
              CYCLE
           .
        .
     .
!  !*********** STATUSA ATLABOÐANA ******  !!!!!!!!!PAGAIDÂM
!  EXECUTE ALG:STATUSS+1
!     ALG:STATUSS='1'
!     ALG:STATUSS='3'
!     ALG:STATUSS='4'
!     ALG:STATUSS='7'
!     ALG:STATUSS='2'
!  .
!  PUTALGAS=TRUE
  !*********** SOC_V KONTROLE ******
     IF ~ALG:SOC_V
        IF ALG:PR37+ALG:PR1=33.09  !12.02.2008
           ALG:SOC_V='1'
        ELSE
           ALG:SOC_V='2'
        .
        KOMENT='Nepareizs SOC_V,mçnesis='&format(alg:yyyymm,@D14.B)&' ID='&alg:id
        print(rpt:detail)
        PUTALGAS=TRUE
     ELSIF ALG:SOC_V='5' AND ALG:YYYYMM >= DATE(11,1,2008) AND DB_GADS=2009
        ALG:SOC_V='3'
        KOMENT='Neatïauts SOC_V=5, mainu uz 3, mçnesis='&format(alg:yyyymm,@D14.B)&' ID='&alg:id
        print(rpt:detail)
        PUTALGAS=TRUE
     .
  !*********** APRÇÍINÂTÂ IIN ******
     ALP_APRIIN+=SUM(5)
  !*********** KADRU ID un SOC_V KONTROLE ******
     IF ~GETKADRI(ALG:ID,0,2)
        KOMENT=format(ALG:YYYYMM,@D6)&'ALGAS:Nav atrasts Kadros ID : '&ALG:ID
        print(rpt:detail)
        KAD:UZV=ALG:INI
        KAD:ID=ALG:ID
        ADD(KADRI)
        IF ERROR()
           KOMENT='   STATUSS: Kïûda atlabojot '&error()
        ELSE
           KOMENT='   STATUSS: ATLABOTS'
        .
        print(rpt:detail)
      ELSE
!        IF ~ALG:TERKOD
!           IF ~KAD:TERKOD
!              KOMENT='KADRI:Nav definçts Ter.kods ID='&KAD:id
!              print(rpt:detail)
!           ELSE
!              ALG:TERKOD=KAD:TERKOD
!              KOMENT='Nav definçts Ter.kods '&format(alg:yyyymm,@d6)&' ID='&alg:id
!              print(rpt:detail)
!              PUTALGAS=TRUE
!           .
!        .
        IF KAD:SOC_V='5' AND DB_GADS=2009
           KAD:SOC_V='3'
           PUTKADRI=TRUE
        .
     .
     !***********RAKSTAM ALGAS*******
     IF PUTALGAS=TRUE
        IF RIUPDATE:ALGAS()
           KOMENT='   STATUSS: Kïûda atlabojot '&error()
        ELSE
           KOMENT='   STATUSS: ATLABOTS'
        .
        print(rpt:detail)
     .
     !***********RAKSTAM KADRUS*******
     IF PUTKADRI=TRUE
        KOMENT='Kadros neatïauts SOC_V=5, mainu uz 3 ID='&KAD:id
        print(rpt:detail)
        IF RIUPDATE:KADRI()
           KOMENT='   STATUSS: Kïûda atlabojot KADRUS '&error()
        ELSE
           KOMENT='   STATUSS: ATLABOTS SOC_V'
        .
        print(rpt:detail)
     .
  .
!--------------------------------------------------------------------------------------------------------------
  IF F:ATL   !JÂPÂRBAUDA ATVAÏINÂJUMI UN SLIMÎBAS LAPAS
     CLEAR(PER:RECORD)
     SET(PER:ID_KEY)
     LOOP
        NEXT(PERNOS)
        PUTPERNOS=FALSE
        IF ERROR() THEN BREAK.
        DO COUNTER
        !*********** KADRU ID KONTROLE ******
        IF ~GETKADRI(PER:ID,0,2)
           KOMENT=format(PER:YYYYMM,@D6)&'PERNOS:Nav atrasts Kadros ID : '&PER:ID
           print(rpt:detail)
           KAD:UZV=PER:INI
           KAD:ID=PER:ID
           ADD(KADRI)
           IF ERROR()
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
        ELSE
           !*********** PERNOS KONTROLE ******
           IF ~PER:INI
              PER:INI=KAD:INI
              KOMENT='Aizpildu PER:INI'&format(per:yyyymm,@d06.)&' '&per:id&' '&per:ini
              print(rpt:detail)
              PUTpernos=TRUE
           .
           IF ~PER:YYYYMM !tukðs raksts
              KOMENT='Dzçðu tukðu rakstu PER:INI'&format(per:yyyymm,@d06.)&' '&per:id&' '&per:ini
              print(rpt:detail)
              DELETE(PERNOS)
           ELSIF ~(DAY(PER:YYYYMM)=1)
              PER:YYYYMM=DATE(MONTH(PER:YYYYMM),1,YEAR(PER:YYYYMM))
              KOMENT='Mainu izmaksas datumu PER:INI'&format(per:yyyymm,@d06.)&' '&per:id&' '&per:ini
              print(rpt:detail)
              PUTpernos=TRUE
           .
        .
        !***********RAKSTAM PERNOS*******
        IF PUTPERNOS=TRUE
           IF RIUPDATE:PERNOS()
              KOMENT='   STATUSS: Kïûda atlabojot '&error()
           ELSE
              KOMENT='   STATUSS: ATLABOTS'
           .
           print(rpt:detail)
        .
     .
  .
  PRINT(RPT:footer)
  ENDPAGE(report)
  pr:skaits=1
  CLOSE(ProgressWindow)
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
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO PROCEDURERETURN

!--------------------------------------------------------------------------------------------------------
PROCEDURERETURN        ROUTINE
  close(ProgressWindow)
  ALGPA::used-=1
  if ALGPA::used=0 THEN close(ALGPA).
  ALGAS::used-=1
  if ALGAS::used=0 THEN close(ALGAS).
  KADRI::used-=1
  if KADRI::used=0 THEN close(KADRI).
  PERNOS::used-=1
  if PERNOS::used=0 THEN close(PERNOS).
  DAIEV::used-=1
  if DAIEV::used=0 THEN close(DAIEV).
  RETURN

!--------------------------------------------------------------------------------------------------------
COUNTER        ROUTINE
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
      DISPLAY()
    END
  END

!--------------------------------------------------------------------------------------------------------
CHECKALPA      ROUTINE
  IF ~(ALP:APRIIN=ALP_APRIIN)
     ALP:APRIIN=ALP_APRIIN
     IF RIUPDATE:ALGPA()
        KOMENT='   STATUSS: Kïûda atlabojot IIN ALGPA'&error()
     ELSE
        KOMENT='   STATUSS: ATLABOTS IIN ALGPA'
     .
     print(rpt:detail)
  .
  ALP_APRIIN=0
CHECKACCESS          FUNCTION (LOCREQUEST,ACCESS) ! Declare Procedure
  CODE                                            ! Begin processed code
 IF ACCESS='N'
    KLUDA(45,'Jebkuras darbîbas aizliegtas, Jûsu pieejas lîmenis='&ACCESS)
    RETURN(1)
 ELSIF LOCREQUEST=DELETERECORD
    IF INSTRING(ACCESS,'123')
       KLUDA(45,'Dzçst aizliegts, Jûsu pieejas lîmenis='&ACCESS)
       RETURN(1)
    ELSE
       KLUDA(0,'Jûs esat izvçlçjies dzçst izgaismoto ierakstu, apdomâjiet, pirms apstipriniet')
       return(3)
    .
 ELSIF LOCREQUEST=CHANGERECORD AND INSTRING(ACCESS,'23')
    KLUDA(45,'Mainît aizliegts, Jûsu pieejas lîmenis='&ACCESS)
    RETURN(2)
 ELSIF LOCREQUEST=INSERTRECORD AND INSTRING(ACCESS,'3')
    KLUDA(45,'Ievadît aizliegts, Jûsu pieejas lîmenis='&ACCESS)
    RETURN(1)
 ELSIF LOCREQUEST=0
    RETURN(2)
 .
 RETURN(3)
