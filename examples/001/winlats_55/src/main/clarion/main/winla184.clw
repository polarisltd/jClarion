                     MEMBER('winlats.clw')        ! This is a MEMBER module
SelftestNOL          PROCEDURE                    ! Declare Procedure
KOMENT               STRING(90)
DAT                  DATE
LAI                  TIME
NOL_U_NR             LIKE(NOL:U_NR)
KON_NOS              STRING(3)
CHECKPAVSUMMA        DECIMAL(12,2)
NOL_SUMMA            DECIMAL(12,2)
PAV_SUMMA_LS         DECIMAL(12,2)
PAV_SUMMA_VAL        DECIMAL(12,2)
PIEKTA               DECIMAL(12,3)
SAV_NOMENKLAT        LIKE(NOM:NOMENKLAT)
NOM_NOMENKLAT        LIKE(NOM:NOMENKLAT)
PROC5                LIKE(NOM:PROC5)
VAL5                 STRING(3)
MULTIVAL             BYTE
PAV_D_K              LIKE(PAV:D_K)
STRINGBYTE           STRING(8)
ADDTIPS              BYTE
PUTPAVAD             BYTE
PUTNOLIK             BYTE
LASTONE              BYTE
SAV_ATLIKUMS         LIKE(NOA:ATLIKUMS)
SAV_K_PROJEKTS       LIKE(NOA:K_PROJEKTS)
!----------------------------------------

K_TABLE         QUEUE,PRE(K)
NOMENKLAT            STRING(21)
D_PROJEKTS           DECIMAL(12,3)
ATLIKUMS             DECIMAL(12,3)
K_PROJEKTS           DECIMAL(12,3)
                .

P_TABLE         QUEUE,PRE(P)
NOMENKLAT            STRING(21)
VAL                  STRING(3)
DATUMS               LONG
PIC                  DECIMAL(11,3)
PIEKTA               DECIMAL(11,3)
                .
N_TABLE         QUEUE,PRE(N)
NOMENKLAT            STRING(21)
DAUDZUMS             LIKE(NOL:DAUDZUMS)
SUMMA                LIKE(NOL:SUMMA)
                .
CETURTA         DECIMAL(11,3)

!----------------------------------------
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
         STRING(@s45),AT(1177,104,5802,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('VS "WinLats"  paðtests  -  NOLIKTAVA :'),AT(1198,573),USE(?String2),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s15),AT(4656,573),USE(SYS:AVOTS),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@N_2),AT(4115,594),USE(LOC_NR),RIGHT(1),FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,885,7760,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@s90),AT(208,21,7344,156),USE(KOMENT),LEFT,FONT(,8,,,CHARSET:BALTIC)
       END
footer DETAIL
         LINE,AT(104,52,7760,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@t4),AT(7188,73),USE(lai),FONT(,7,,,CHARSET:ANSI)
         STRING('Sastâdîja :'),AT(156,73),USE(?String5),LEFT,FONT(,7,,,CHARSET:BALTIC)
         STRING(@s8),AT(635,73),USE(ACC_kods),LEFT,FONT(,7,,,CHARSET:ANSI)
         STRING(@d06.),AT(6573,73),USE(dat),FONT(,7,,,CHARSET:ANSI)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,314,66),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(9,27,300,12),RANGE(0,100)
       STRING(''),AT(9,14,141,10),USE(?Progress:UserString),CENTER
       STRING(@s90),AT(3,3,309,10),USE(koment,,?KOMENT:2)
       STRING(''),AT(7,43,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(257,44,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
          IF pavad::used=0
             CHECKOPEN(pavad,1)
          .
          pavad::used+=1
          IF NOLIK::used=0
             CHECKOPEN(nolik,1)
          .
          nolik::used+=1
          IF NOM_K::used=0
             CHECKOPEN(nom_K,1)
          .
          nom_k::used+=1
          IF NOM_A::used=0
             CHECKOPEN(nom_A,1)
          .
          nom_a::used+=1
          IF AUTOAPK::used=0
             CHECKOPEN(AUTOAPK,1)
          .
          AUTOAPK::used+=1
          IF AUTODARBI::used=0
             CHECKOPEN(AUTODARBI,1)
          .
          AUTODARBI::used+=1

          NOL_U_NR=0
          stringbyte=''
          VAL_NOS=''
          PAV_summa_val=0
          PAV_summa_Ls=0
          PUTPAVAD=FALSE
          PUTNOLIK=FALSE
          LASTONE=FALSE
          dat=today()
          lai=clock()
          FilesOpened = True
          RecordsPerCycle = 25
          RecordsProcessed = 0
          PercentProgress = 0
          OPEN(ProgressWindow)
          Progress:Thermometer = 0
          ?Progress:PctText{Prop:Text} = '0% Izpildîti'
          ProgressWindow{Prop:Text} = 'Selftest (Paðtests)'
          ?Progress:UserString{Prop:Text}='Analizçju DB: '
          DISPLAY()
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
          PRINT(rpt:header)

         OMIT('MARIS')
          IF CL_NR=1464 OR CL_NR=1102  !Île&ADRem
             IF  ~(LOC_NR=1)
                KLUDA(0,'Konvertieris jâlaiþ no 1.noliktavas')
                DO PROCEDURERETURN
             .
             TAKA"=LONGPATH()
             CLOSE(NOLI1)
             FILENAME2='NOLIK02'
             CHECKOPEN(noli1,1)
             CLOSE(AUTODARBI1)
             FILENAME1='ADARBI02'
             CHECKOPEN(AUTODARBI1,1)
        !     RecordsToProcess = RECORDS(NOM_K)+RECORDS(AUTODARBI)+RECORDS(AUTODARBI1)
             RecordsToProcess = RECORDS(NOM_K)
             CLEAR(NOM:RECORD)
             SET(NOM_K)
             LOOP
                NEXT(NOM_K)
                IF ERROR() THEN BREAK.
                DO COUNTER
        !        IF RAKSTI# > 10 THEN BREAK.
                !*********** NOM_K NOMENKLATÛRU MAIÒA ******
                IF NOM:TIPS='A' AND ~(NOM:NOMENKLAT[1:4]='PAKX')
                   SAV_NOMENKLAT=NOM:NOMENKLAT
                   NOM_NOMENKLAT=NOM:NOMENKLAT
                   CLEAR(SAV_ATLIKUMS)
                   CLEAR(SAV_K_PROJEKTS)
                   NOBIDE#=0
                   LEN#=LEN(CLIP(NOM:NOMENKLAT))
                   LOOP I#=2 TO LEN#
                      IF INSTRING(NOM:NOMENKLAT[I#],' .,;:*"/()',1)
                         IF INRANGE(I#,2,20)
                            IF I#<LEN#
                               NOM_NOMENKLAT=NOM_NOMENKLAT[1:I#-1-NOBIDE#]&NOM_NOMENKLAT[I#+1-NOBIDE#:21] !PA VIDU
                               NOBIDE#+=1
                            ELSE
                               NOM_NOMENKLAT[I#-NOBIDE#]='X' !BEIGÂS
                            .
                         .
                      .
                   .
                   IF (NOM:NOMENKLAT[1:4]='PAK ')
                      NOM:NOMENKLAT='PAKX'&NOM_NOMENKLAT[4:21]
                   ELSE
                      NOM:NOMENKLAT='PAKX'&NOM_NOMENKLAT
                   .
                   IF DUPLICATE(NOM:NOM_KEY)
                      J#=LEN(CLIP(NOM:NOMENKLAT))
                      LOOP I#=1 TO 99
                         NOM:NOMENKLAT=NOM:NOMENKLAT[1:J#-1]&CLIP(I#)
                         IF ~DUPLICATE(NOM:NOM_KEY) THEN BREAK.
                      .
                   .
                   IF RIUPDATE:NOM_K()
        !              KLUDA(24,'NOM_K '&CLIP(NOM:NOMENKLAT)&' no '&SAV_NOMENKLAT)
                      KOMENT='KLUDA RAKSTOT NOM_K '&CLIP(NOM:NOMENKLAT)&' no '&SAV_NOMENKLAT
                      DISPLAY
                      print(rpt:detail)
                   ELSE
                      KOMENT='NOM_K:Nomenklatûra '&SAV_NOMENKLAT&' mainîta uz '&NOM:NOMENKLAT
                      DISPLAY
                      print(rpt:detail)
                      !1.NOLIKTAVA
                      ProgressWindow{Prop:Text} = 'Konvertçjam NOLIKTAVAS'
                      ?Progress:UserString{Prop:Text}=''
                      CLEAR(NOL:RECORD)
                      NOL:NOMENKLAT=SAV_NOMENKLAT
                      SET(NOL:NOM_KEY,NOL:NOM_KEY)
                      LOOP
                         NEXT(NOLIK)
                         IF ERROR() OR ~(NOL:NOMENKLAT=SAV_NOMENKLAT) THEN BREAK.
                         NOL:NOMENKLAT=NOM:NOMENKLAT
                         IF RIUPDATE:NOLIK()
        !                    KLUDA(24,'RAKSTOT NOLI1:'&SAV_NOMENKLAT&' uz '&NO1:NOMENKLAT&ERROR())
                            KOMENT='KLUDA RAKSTOT NOLIK '&CLIP(NOL:NOMENKLAT)&' no '&SAV_NOMENKLAT
                            DISPLAY
                            print(rpt:detail)
                         ELSE
                            KOMENT='NOLIK01 Nomenklatûra '&SAV_NOMENKLAT&' mainîta uz '&NOL:NOMENKLAT
                            DISPLAY
                         .
        !                 SAV_ATLIKUMS[1]+=NOL:DAUDZUMS   !
                      .
        !              STOP(SAV_NOMENKLAT&' uz '&NOL:NOMENKLAT&'A='&NOL:DAUDZUMS&'K='&SAV_ATLIKUMS[1])!
        !              STOP(NO1:NOMENKLAT)!

                      !ATLIKUMI
                      CLEAR(NOA:RECORD)
                      NOA:NOMENKLAT=SAV_NOMENKLAT
                      GET(NOM_A,NOA:NOM_KEY)
                      IF ~ERROR()
                         SAV_ATLIKUMS :=: NOA:ATLIKUMS
                         SAV_K_PROJEKTS :=: NOA:K_PROJEKTS
                         DELETE(NOM_A)
                      .
                      CLEAR(NOA:RECORD)
                      NOA:NOMENKLAT=NOM:NOMENKLAT
                      GET(NOM_A,NOA:NOM_KEY)
                      NOA:ATLIKUMS :=: SAV_ATLIKUMS  !PIEÐÍIRAM UZREIZ VISU
                      NOA:K_PROJEKTS :=: SAV_K_PROJEKTS
                      IF ~ERROR()
                         IF RIUPDATE:NOM_A()
        !                    KLUDA(24,'NOM_A: '&SAV_NOMENKLAT&' -> '&NOM:NOMENKLAT)
                            KOMENT='KLUDA RAKSTOT NOM_A '&CLIP(NOA:NOMENKLAT)&' no '&SAV_NOMENKLAT
                            DISPLAY
                            print(rpt:detail)
                         .
                      ELSE
                         ADD(NOM_A)
                      .
                      !2.NOLIKTAVA
                      CLEAR(NO1:RECORD)
                      NO1:NOMENKLAT=SAV_NOMENKLAT
                      SET(NO1:NOM_KEY,NO1:NOM_KEY)
                      LOOP
                         NEXT(NOLI1)
                         IF ERROR() OR ~(NO1:NOMENKLAT=SAV_NOMENKLAT) THEN BREAK.
                         NO1:NOMENKLAT=NOM:NOMENKLAT
                         IF RIUPDATE:NOLI1()
        !                    KLUDA(24,'RAKSTOT NOLI1:'&SAV_NOMENKLAT&' uz '&NOM:NOMENKLAT&ERROR())
                            KOMENT='KLUDA RAKSTOT NOLIK02 '&CLIP(NOM:NOMENKLAT)&' no '&SAV_NOMENKLAT
                            DISPLAY
                            print(rpt:detail)
                         ELSE
                            KOMENT='NOLIK02 Nomenklatûra '&SAV_NOMENKLAT&' mainîta uz '&NOL:NOMENKLAT
                            DISPLAY
                         .
                      .
                   .
                ELSIF (NOM:NOMENKLAT[1:4]='PAKX')
                      !1.NOLIKTAVA
                      ProgressWindow{Prop:Text} = 'Konvertçjam NOLIKTAVAS'
                      ?Progress:UserString{Prop:Text}=''
                      CLEAR(NOL:RECORD)
                      SAV_NOMENKLAT=NOM:NOMENKLAT[5:21]
                      NOL:NOMENKLAT=SAV_NOMENKLAT
                      SET(NOL:NOM_KEY,NOL:NOM_KEY)
                      LOOP
                         NEXT(NOLIK)
                         IF ERROR() OR ~(NOL:NOMENKLAT=SAV_NOMENKLAT) THEN BREAK.
                         NOL:NOMENKLAT=NOM:NOMENKLAT
                         IF RIUPDATE:NOLIK()
        !                    KLUDA(24,'RAKSTOT NOLI1:'&SAV_NOMENKLAT&' uz '&NO1:NOMENKLAT&ERROR())
                            KOMENT='KLUDA RAKSTOT NOLIK01 '&CLIP(NOL:NOMENKLAT)&' no '&SAV_NOMENKLAT
                            DISPLAY
                            print(rpt:detail)
                         ELSE
                            KOMENT='NOLIK01 Nomenklatûra '&SAV_NOMENKLAT&' mainîta uz '&NOL:NOMENKLAT
                            DISPLAY
                         .
        !                 SAV_ATLIKUMS[1]+=NOL:DAUDZUMS   !
                      .
                .
             .!***BEIDZAS LOOP NOM_K
             !1.AUTODARBI
             ProgressWindow{Prop:Text} = 'Konvertçjam AUTODARBUS'
             ?Progress:UserString{Prop:Text}=''
        !     found#=0
             CLEAR(APD:RECORD)
             SET(AUTODARBI)
             LOOP
                NEXT(AUTODARBI)
                IF ERROR() THEN BREAK.
                DO COUNTER
                IF ~(APD:NOMENKLAT[1:4]='PAKX')

                   SAV_NOMENKLAT=APD:NOMENKLAT
                   NOM_NOMENKLAT=APD:NOMENKLAT
                   NOBIDE#=0
                   LEN#=LEN(CLIP(APD:NOMENKLAT))
                   LOOP I#=2 TO LEN#
                      IF INSTRING(APD:NOMENKLAT[I#],' .,;:*"/()',1)
                         IF INRANGE(I#,2,20)
                            IF I#<LEN#
                               NOM_NOMENKLAT=NOM_NOMENKLAT[1:I#-1-NOBIDE#]&NOM_NOMENKLAT[I#+1-NOBIDE#:21] !PA VIDU
                               NOBIDE#+=1
                            ELSE
                               NOM_NOMENKLAT[I#-NOBIDE#]='X' !BEIGÂS
                            .
                         .
                      .
                   .
                   IF (APD:NOMENKLAT[1:4]='PAK ')
                      APD:NOMENKLAT='PAKX'&NOM_NOMENKLAT[4:21]
                   ELSE
                      APD:NOMENKLAT='PAKX'&NOM_NOMENKLAT
                   .


                   IF RIUPDATE:AUTODARBI()
                      KLUDA(24,'RAKSTOT AUTODARBI:'&SAV_NOMENKLAT&' uz '&NOM:NOMENKLAT&ERROR())
                      KOMENT='KLUDA RAKSTOT AUTODARBI '&CLIP(NOM:NOMENKLAT)&' no '&SAV_NOMENKLAT
                      DISPLAY
                      print(rpt:detail)
                   .
                .
             .
             !2.AUTODARBI
             CLEAR(APD1:RECORD)
             SET(AUTODARBI1)
             LOOP
                NEXT(AUTODARBI1)
                IF ERROR() THEN BREAK.
                DO COUNTER
                IF ~(APD1:NOMENKLAT[1:4]='PAKX')

                   SAV_NOMENKLAT=APD1:NOMENKLAT
                   NOM_NOMENKLAT=APD1:NOMENKLAT
                   NOBIDE#=0
                   LEN#=LEN(CLIP(APD1:NOMENKLAT))
                   LOOP I#=2 TO LEN#
                      IF INSTRING(APD1:NOMENKLAT[I#],' .,;:*"/()',1)
                         IF INRANGE(I#,2,20)
                            IF I#<LEN#
                               NOM_NOMENKLAT=NOM_NOMENKLAT[1:I#-1-NOBIDE#]&NOM_NOMENKLAT[I#+1-NOBIDE#:21] !PA VIDU
                               NOBIDE#+=1
                            ELSE
                               NOM_NOMENKLAT[I#-NOBIDE#]='X' !BEIGÂS
                            .
                         .
                      .
                   .
                   IF (APD1:NOMENKLAT[1:4]='PAK ')
                      APD1:NOMENKLAT='PAKX'&NOM_NOMENKLAT[4:21]
                   ELSE
                      APD1:NOMENKLAT='PAKX'&NOM_NOMENKLAT
                   .


                   IF RIUPDATE:AUTODARBI1()
        !              KLUDA(24,'RAKSTOT AUTODARBI1:'&SAV_NOMENKLAT&' uz '&NOM:NOMENKLAT&ERROR())
                      KOMENT='KLUDA RAKSTOT AUTODARBI1 '&CLIP(NOM:NOMENKLAT)&' no '&SAV_NOMENKLAT
                      DISPLAY
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
             .
             CLOSE(NOLIK)
             CLOSE(NOLI1)
             NOLIKNAME='NOLIK'&FORMAT(LOC_NR,@N02)
             CHECKOPEN(NOLIK,1)
             CLOSE(AUTODARBI)
             CLOSE(AUTODARBI1)
             ADARBINAME='ADARBI'&FORMAT(LOC_NR,@N02)
             CHECKOPEN(AUTODARBI,1)
             CLOSE(report)
             FREE(PrintPreviewQueue)
             FREE(PrintPreviewQueue1)
             DO PROCEDURERETURN
          .
          STOP('END')
         MARIS
        !*******************************BEIDZAS ÎLES SPECv
        !***************************************************************************************

          IF RECORDS(NOM_A)=0
             RecordsToProcess = RECORDS(NOLIK)+RECORDS(NOM_A)+RECORDS(NOM_K)
             IF F:KRI THEN RecordsToProcess += RECORDS(PAVAD).   !TUKÐI RAKSTI
             CLOSE(NOM_A)
             OPEN(NOM_A,12h) !dçï BUILD
             CLEAR(NOM:RECORD)
             SET(NOM:NOM_KEY,NOM:NOM_KEY)
             NEXT(NOM_K)
             LOOP
                NEXT(NOM_K)
                IF ERROR() THEN BREAK.

        !      RAKSTI#+=1
        !      IF RAKSTI# > 10 THEN BREAK.

        !        NOM:ARPVNBYTE=31        !VISAS CENAS AR PVN
        !        PUT(NOM_K)              !
                DO COUNTER
                !*********** NOM_K UPPERCASE KONTROLE ******
                IF ~(NOM:NOMENKLAT=UPPER(NOM:NOMENKLAT))
                   KOMENT='Nomenklatûra '&NOM:NOMENKLAT&' mainîta uz '&UPPER(NOM:NOMENKLAT)
                   DISPLAY
                   print(rpt:detail)
                   NOM:NOMENKLAT=UPPER(NOM:NOMENKLAT)
                   IF RIUPDATE:NOM_K()
        !              KLUDA(24,'NOM_K '&NOM:NOMENKLAT)
                      KOMENT='KLUDA RAKSTOT NOM_K '&CLIP(NOM:NOMENKLAT)
                      DISPLAY
                      print(rpt:detail)
                   .
                .
                !*******************************************
                CLEAR(NOA:RECORD)
                NOA:NOMENKLAT=NOM:NOMENKLAT
                APPEND(NOM_A)
                KOMENT='NOM_A rakstu '&NOa:NOMENKLAT
                DISPLAY
             .
             ?Progress:UserString{Prop:Text}='Bûvçjam atslçgas Nom_A'
             DISPLAY()
             NOTPRINT_A#=TRUE
             BUILD(NOM_A)
             IF ERROR() THEN STOP(ERROR()).
          ELSE
             RecordsToProcess = RECORDS(NOLIK)
             IF F:ATL THEN RecordsToProcess += RECORDS(NOM_A).   !ATLIKUMI
             IF F:IDP THEN RecordsToProcess += RECORDS(NOM_K).   !PIC
             IF F:KRI THEN RecordsToProcess += RECORDS(PAVAD).   !TUKÐI RAKSTI
             IF F:PAK THEN RecordsToProcess += RECORDS(AUTOAPK)+RECORDS(AUTODARBI).   !AUTOSERVISS
          .
          ?Progress:UserString{Prop:Text}='Analizçju DB: '
          DISPLAY()
          CLEAR(NOL:RECORD)
          SET(NOL:NR_key)
          LOOP
             NEXT(NOLIK)
             IF ERROR()
                LASTONE=TRUE
                BREAK
             ELSE
                IF (CL_NR=1464 OR CL_NR=1102) AND F:DTK  !Île&ADRem
                   DO PAK2
                .
             .
             PUTNOLIK=FALSE
             DO COUNTER
             clear(PAV:record)
             PAV:U_NR=NOL:U_NR
             GET(PAVAD,PAV:NR_KEY)
             IF ERROR()
                IF RECORDS(NOM_K)>50000
                   KLU_DARBIBA=1 !DÇÏ AUTOÎLES
                ELSE
                   KLUDA(5,'PAVAD-NOLIK '&FORMAT(NOL:datums,@D06.)&' Nr:'&NOL:U_NR)
                .
                IF klu_darbiba
                   CLEAR(PAV:RECORD)
                   PAV:U_NR=NOL:U_NR
                   PAV:DATUMS=NOL:DATUMS
                   PAV:D_K=NOL:D_K
                   IF ~PAV:D_K THEN PAV:D_K='K'.
                   PAV:PAR_NR=NOL:PAR_NR
                   PAV:NOKA=GETPAR_K(NOL:PAR_NR,2,1)
                   PAV:PAMAT='?????????????????'
                   ADD(PAVAD)
                   IF ERROR()
                      KOMENT='Relâcijas kïûda PAVAD-NOLIK :'&FORMAT(NOL:datums,@D06.)&' Nr:'&CLIP(NOL:U_NR)&' Rakstu nav iespçjams atjaunot'
                      print(rpt:detail)
                   ELSE
                      KOMENT='Relâcijas kïûda PAVAD-NOLIK :'&FORMAT(NOL:datums,@D06.)&' Nr:'&CLIP(NOL:U_NR)&' Raksts ir atjaunots'
                      print(rpt:detail)
                   .
                ELSE
                   KOMENT='Relâcijas kïûda PAVAD-NOLIK :'&FORMAT(NOL:datums,@D06.)&' U_Nr:'&CLIP(NOL:U_NR)&' LIETOTÂJA ATTEIKUMS atjaunot'
                   print(rpt:detail)
                .
             ELSE
                !*********** PAV:DOK_SE KONTROLE ******
                 IF ~(PAV:DOK_SENR=INIGEN(PAV:DOK_SENR,14,1))
        !            STOP(PAV:DOK_SE)
                    PAV:DOK_SENR=INIGEN(PAV:DOK_SENR,14,1)
                    PUT(PAVAD)
                 .
                !*********** UPPERCASE KONTROLE ******
                IF ~(NOL:NOMENKLAT=UPPER(NOL:NOMENKLAT))
                   KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NOMENKLAT ir'&NOL:NOMENKLAT&' jâbût '&UPPER(NOL:NOMENKLAT)
                   DISPLAY
                   print(rpt:detail)
                   NOL:NOMENKLAT=UPPER(NOL:NOMENKLAT)
                   PUTNOLIK=TRUE
                .
                !*********** ATLIKUMU KONTROLE ***************
                IF F:ATL
                   GET(K_TABLE,0)
                   K:NOMENKLAT=NOL:NOMENKLAT
                   K:D_PROJEKTS=0
                   K:ATLIKUMS=0
                   K:K_PROJEKTS=0
                   GET(K_TABLE,K:NOMENKLAT)

        !           IF NOL:NOMENKLAT[1:8]='A.028407'
        !              STOP('BÛV.K: '&K:NOMENKLAT&NOL:DAUDZUMS&ERROR())
        !           .

                   IF ERROR()
                      ACTION#=1
                   ELSE
                      ACTION#=2
                   .
                   CASE NOL:D_K
                   OF '1'
                      K:D_PROJEKTS+=NOL:DAUDZUMS
                   OF 'D'
                      K:ATLIKUMS+=NOL:DAUDZUMS
                   OF 'K'
                      K:ATLIKUMS-=NOL:DAUDZUMS
                   OF 'P'
                      K:K_PROJEKTS+=NOL:DAUDZUMS
                   OF 'R'
        !              NEVAJAG PÂRÂK SAREÞÌÎT...K:K_RPROJEKTS+=NOL:DAUDZUMS
                   .
                   EXECUTE ACTION#
                      BEGIN
                          ADD(K_TABLE)
                          IF ERROR() THEN STOP(ERROR()).
                          SORT(K_TABLE,K:NOMENKLAT)
                      .
                      PUT(K_TABLE)
                   .
                .
                !*********** PIC UN PIEKTAS KONTROLE ***************
        !        IF F:IDP AND NOL:D_K='D' AND ~INRANGE(NOL:PAR_NR,1,50) AND ~(NOL:RS='1') AND ~(NOL:U_NR=1)
                IF F:IDP AND NOL:D_K='D' AND ~INRANGE(NOL:PAR_NR,1,50) AND ~(NOL:RS='1') AND NOL:DAUDZUMS>0
                   GET(P_TABLE,0)
                   P:NOMENKLAT=NOL:NOMENKLAT
                   GET(P_TABLE,P:NOMENKLAT)
                   IF ERROR()
                      P:DATUMS=NOL:DATUMS
                      P:VAL=NOL:VAL
                      P:PIEKTA=round(CALCSUM(3,3)/NOL:DAUDZUMS,.001) ! Pagaidâm valûtâ bez PVN, PÂRRÇÍINAM, GRIEÞOT P_TABLE
                      P:PIC=round(CALCSUM(15,3)/NOL:DAUDZUMS,.001)   ! Ls bez PVN -A
                      ADD(P_TABLE)
                      SORT(P_TABLE,P:NOMENKLAT)
                   ELSE
                      IF NOL:DATUMS > P:DATUMS
                         P:DATUMS=NOL:DATUMS
                         P:VAL=NOL:VAL
                         P:PIEKTA=round(CALCSUM(3,3)/NOL:DAUDZUMS,.001) ! Pagaidâm valûtâ bez PVN
                         P:PIC=round(CALCSUM(15,3)/NOL:DAUDZUMS,.001)   ! Ls bez PVN -A
                         PUT(P_TABLE)
                      .
                   .
                .
                !*********** D_K KONTROLE NOLIK******
                IF ~(NOL:D_K=PAV:D_K)
                   KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NOLIK D_K ir'&NOL:D_k&' jâbût '&PAV:D_K
                   print(rpt:detail)
                   NOL:D_K=PAV:D_K
                   PUTNOLIK=TRUE
                .
                !*********** DATUMU KONTROLE NOLIK******
                IF ~(PAV:DATUMS=NOL:DATUMS)
                   KOMENT='Rakstam Nr '&NOL:U_NR&' NOLIK Datums ir '&format(NOL:DATUMS,@D06.)&' jâbût '&format(PAV:DATUMS,@D06.)
                   print(rpt:detail)
                   NOL:DATUMS=PAV:DATUMS
                   PUTNOLIK=TRUE
                .
                !*********** PARTNERU KONTROLE NOLIK******
                IF PAV:PAR_NR AND ~(PAV:PAR_NR=NOL:PAR_NR)
                   KOMENT='Rakstam Nr '&NOL:U_NR&' NOLIK PAR_NR ir '&NOL:PAR_NR&' jâbût '&PAV:PAR_NR
                   print(rpt:detail)
                   NOL:PAR_NR=PAV:PAR_NR
                   PUTNOLIK=TRUE
                .
                !*********** PARÂDA NULLÇÐANA******
        !        IF INSTRING(PAV:APM_V,'14') AND NOL:KEKSIS>0
        !           KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NAV JÂBÛT PARÂDAM'
        !           print(rpt:detail)
        !           NOL:KEKSIS=0
        !           PUTNOLIK=TRUE
        !        .
                !*********** RS KONTROLE NOLIK******
                IF ~(PAV:RS=NOL:RS)
                   KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NOLIK RS ir '&NOL:RS&' jâbût '&PAV:RS
                   print(rpt:detail)
                   NOL:RS=PAV:RS
                   PUTNOLIK=TRUE
                .
                !*********** ARBYTE KONTROLE NOLIK******
                IF ~INRANGE(NOL:ARBYTE,0,1)
                   KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NOLIK ARBYTE ir '&NOL:ARBYTE&' liekam 0'
                   print(rpt:detail)
                   NOL:arbyte=0
                   PUTNOLIK=TRUE
                .
                !*********** NOMENKLATÛRU KONTROLE ******
                IF ~GETNOM_K(NOL:NOMENKLAT,0,1)
                   KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' Nomenklatûrâs nav atrasts : '&NOL:nomenklat
        !           stop(koment)
                   print(rpt:detail)
                   CLEAR(NOM:RECORD)
                   NOM:NOS_P='??????????'
                   NOM:TIPS='P'
                   NOM:NOMENKLAT=NOL:NOMENKLAT
                   ADD(nom_k)
                   IF ERROR()
        !              STOP('nom_K(ADD) '&NOM:NOMENKLAT&' '&ERROR())
                      KOMENT=CLIP(KOMENT)&' Kïûda atlabojot - '&error()
                   ELSE
                      KOMENT=CLIP(KOMENT)&' : ATLABOTS'
                   .
                   print(rpt:detail)
                ELSE
                   IF ~NOM:TIPS
                      NOM:TIPS='P'
                      PUT(NOM_K)
                   .
                   LOOP I#= 1 TO 5
                      IF ~NOM:VAL[I#]
                         NOM:VAL[I#]='Ls'
                         PUT(NOM_K)
                      .
                   .
                .
                !********DUP NOMENKLATÛRU KONTROLE SALDO******
                IF NOL:U_NR=1
                   N:NOMENKLAT=NOL:NOMENKLAT
                   GET(N_TABLE,N:NOMENKLAT)
                   IF ERROR()
                      N:DAUDZUMS=NOL:DAUDZUMS
                      N:SUMMA=NOL:SUMMA
                      ADD(N_TABLE)
        !          ELSE
        !             KOMENT='SALDO raksta Nomenklatûra : '&N:nomenklat&' Daudzums '&N:DAUDZUMS&' Summa '&N:SUMMA
        !             print(rpt:detail)
        !             KOMENT='               Atkârtojas : '&NOL:nomenklat&' Daudzums '&NOL:DAUDZUMS&' Summa '&NOL:SUMMA
        !             print(rpt:detail)
                   .
                .
                !***********SUMMU KONTROLE NOLIK *******
        !        NOL_SUMMA=ROUND(NOL:SUMMAV*BANKURS(NOL:VAL,NOL:DATUMS,format(NOL:DATUMS,@d06.)&' Nr='&NOL:U_NR),.01)
        !        IF ~INRANGE(NOL:SUMMA-NOL_SUMMA,-0.01,0.01)
        !           KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' NOLIK SUMMA ir '&NOL:SUMMA&' jâbût '&NOL_SUMMA
        !           print(rpt:detail)
        !           NOL:SUMMA=NOL_SUMMA
        !           PUTNOLIK=TRUE
        !        .
                !***********PROJEKTU kontrole**********
                IF ~NOL:OBJ_NR  !Lai saglabâtu CITUS PROJEKTUS
                   IF ~(NOL:OBJ_NR=PAV:OBJ_nr)
                      KOMENT=format(NOL:DATUMS,@D06.)&'Rakstam Nr '&NOL:U_NR&' projektam jâbût '&PAV:OBJ_nr
                      print(rpt:detail)
                      NOL:OBJ_NR=PAV:OBJ_nr
                      PUTNOLIK=TRUE
                   .
                .
                !***********RAKSTAM NOLIK*******
                IF PUTNOLIK=TRUE
                   IF RIUPDATE:NOLIK()
                      KOMENT=CLIP(KOMENT)&': Kïûda atlabojot '&error()
                   ELSE
                      KOMENT=CLIP(KOMENT)&': ATLABOTS'
                   .
                   print(rpt:detail)
                .
             .
          .!BEIDZAS LOOP NOLIK

        !  STOP(F:ATL&'-'&RECORDS(K_TABLE))
          IF F:ATL  !JÂPÂRBAUDA NOM_A ATLIKUMI
             CLEAR(NOA:RECORD)
             SET(NOM_A)
             !11/07/2012 LOOP
             LOOP UNTIL EOF(NOM_A) !11/07/2012
                NEXT(NOM_A)
                IF ERROR() THEN stop(error()&NOA:NOMENKLAT).
                IF ERROR() THEN BREAK.
                DO COUNTER
                GET(K_TABLE,0)
                K:NOMENKLAT=NOA:NOMENKLAT
                GET(K_TABLE,K:NOMENKLAT)
                IF ERROR()
                   IF ~(NOA:ATLIKUMS[LOC_NR]=0 AND|
                        NOA:D_PROJEKTS[LOC_NR]=0 AND|
                        NOA:K_PROJEKTS[LOC_NR]=0)
                      NOA:D_PROJEKTS[LOC_NR]=0
                      NOA:ATLIKUMS[LOC_NR]=0
                      NOA:K_PROJEKTS[LOC_NR]=0
                      KOMENT='Nom_A nepareizs atlikums: '&NOA:NOMENKLAT
                      DISPLAY
                      IF NOTPRINT_A#=FALSE
                         print(rpt:detail)
                      .
                      IF RIUPDATE:NOM_A()
                         KOMENT=CLIP(KOMENT)&': Kïûda atlabojot '&error()
                       ELSE
                         KOMENT=CLIP(KOMENT)&': ATLABOTS atlikums '&NOA:NOMENKLAT
                         I#=W_INET(1,NOA:NOMENKLAT)
                         IF GNET AND ATLAUTS[1]='1'  !BÛS JÂUZLIEK UZ GROSSA REÌ.NR.2X
                            IF ~(NOA:GNET_FLAG[1]=1) !SITUÂCIJA, KAD IEVADÎTA JAUNA NOMENKLATÛRA,MAINÎTS ATLIKUMS UN SERVERIS NOSPRÂDZIS
                               NOA:GNET_FLAG[1]=2
                            .
                            NOA:GNET_FLAG[2]=''
                            NOA:GNET_FLAG[3]=CHR(Loc_Nr) !ATCERAMIES,KURÂ NOLIKTAVÂ MAINÎTS
                         .
                      .
                      print(rpt:detail)
                   .
                ELSE
                   IF ~(NOA:ATLIKUMS[LOC_NR]=K:ATLIKUMS AND|
                          NOA:D_PROJEKTS[LOC_NR]=K:D_PROJEKTS AND|
                          NOA:K_PROJEKTS[LOC_NR]=K:K_PROJEKTS)
                      NOA:D_PROJEKTS[LOC_NR]=K:D_PROJEKTS
                      NOA:ATLIKUMS[LOC_NR]=K:ATLIKUMS
                      NOA:K_PROJEKTS[LOC_NR]=K:K_PROJEKTS
                      KOMENT='Nom_A nepareizs atlikums: '&NOA:NOMENKLAT
                      print(rpt:detail)
                      IF RIUPDATE:NOM_A()
                         KOMENT=CLIP(KOMENT)&': Kïûda atlabojot '&error()
                      ELSE
                         KOMENT=CLIP(KOMENT)&': ATLABOTS'
                         I#=W_INET(1,NOA:NOMENKLAT)
                         IF GNET AND ATLAUTS[1]='1'
                            IF ~(NOA:GNET_FLAG[1]=1) !SITUÂCIJA, KAD IEVADÎTA JAUNA NOMENKLATÛRA,MAINÎTS ATLIKUMS UN SERVERIS NOSPRÂDZIS
                               NOA:GNET_FLAG[1]=2
                            .
                            NOA:GNET_FLAG[2]=''
                            NOA:GNET_FLAG[3]=CHR(Loc_Nr) !ATCERAMIES,KURÂ NOLIKTAVÂ MAINÎTS
                         .
                      .
                      print(rpt:detail)
                   .
                .
             .
          .
          !*********** PIC un PIEKTA KONTROLE ***************

          IF F:IDP
             LOOP I#=1 TO RECORDS(P_TABLE)
                DO COUNTER
                GET(P_TABLE,I#)
                IF GETNOM_K(P:NOMENKLAT,0,1)
                   IF NOM:PROC5=999 !ALGORITMS
                      PROC5=0
                   ELSE
                      PROC5=NOM:PROC5
                   .
        !           IF NOM:VAL[5]='Ls' OR NOM:VAL[5]='LVL' !jâsaglabâ Latos, P:PIEKTA IR VAL bez PVN
        !              PIEKTA=P:PIEKTA*BANKURS(P:VAL,P:DATUMS)
        !              VAL5=NOM:VAL[5]
        !           ELSE
        !              PIEKTA=P:PIEKTA
        !              VAL5=P:VAL
        !           .
                   !14/07/2012  <
                   KOMENT=NOM:NOMENKLAT
        !           IF NOM:PIC_DATUMS<=P:DATUMS AND |
        !           (~(NOM:PIC=P:PIC) OR ~(NOM:REALIZ[5]=PIEKTA) OR ~(NOM:REALIZ[4]=CETURTA)) AND ~BAND(NOM:BAITS1,00000100b) !NAV LOCK5
                   IF ~(NOM:PIC=P:PIC)
                      NOM:PIC=P:PIC
                      NOM:PIC_DATUMS=P:DATUMS
                      PUTNOM_K#=TRUE
                      KOMENT=CLIP(KOMENT)&' Atlaboju PIC '
                   .
                   PIEKTA = P:PIC
                   !14/07/2012 >
                   CETURTA=NOM:REALIZ[4]
                   IF CL_NR=1316 AND NOL:PVN_PROC=5 !ELPA
                     IF PIEKTA<1
                        CETURTA=(PIEKTA*1.30)
                        PIEKTA=(PIEKTA*1.4+0.01)
                     ELSIF PIEKTA<2
                        CETURTA=(PIEKTA*1.25+0.05)
                        PIEKTA=(PIEKTA*1.35)
                     ELSIF PIEKTA<3
                        CETURTA=(PIEKTA*1.2+0.15)
                        PIEKTA=(PIEKTA*1.3)
                     ELSIF PIEKTA<5
                        CETURTA=(PIEKTA*1.17+0.30)
                        PIEKTA=(PIEKTA*1.25)
                     ELSIF PIEKTA<10
                        CETURTA=(PIEKTA*1.15+0.40)
                        PIEKTA=(PIEKTA*1.20)
                     ELSIF PIEKTA<15 AND NOL:NOMENKLAT[4]='K'
                        CETURTA=(PIEKTA*1.10+0.90)
                     ELSIF PIEKTA<20
                        CETURTA=(PIEKTA*1.07+1.35)
                        PIEKTA=(PIEKTA*1.15+0.60)
                     ELSE
                        CETURTA=(PIEKTA*1.05+1.75)
                        PIEKTA=(PIEKTA*1.10+1.50)
                     .
                     IF NOL:NOMENKLAT[4]='K'
                        PIEKTA=CETURTA
                        CETURTA=0
                     .
                   ELSIF CL_NR=1316 AND NOL:PVN_PROC=18 !ELPA
                     PIEKTA=(PIEKTA*1.25)
                   ELSIF NOM:PROC5=999 !ALGORITMS
                      IF PIEKTA<1
                         CETURTA=(PIEKTA*1.30)
                         PIEKTA=(PIEKTA*1.4+0.01)
                      ELSIF PIEKTA<2
                         CETURTA=(PIEKTA*1.25+0.05)
                         PIEKTA=(PIEKTA*1.35+0.06)
                      ELSIF PIEKTA<3
                         CETURTA=(PIEKTA*1.2+0.15)
                         PIEKTA=(PIEKTA*1.3+0.16)
                      ELSIF PIEKTA<5
                         CETURTA=(PIEKTA*1.17+0.30)
                         PIEKTA=(PIEKTA*1.25+0.31)
                      ELSIF PIEKTA<10
                         CETURTA=(PIEKTA*1.15+0.40)
                         PIEKTA=(PIEKTA*1.20+0.56)
                      ELSIF PIEKTA<15
                         CETURTA=(PIEKTA*1.10+0.90)
                         PIEKTA=(PIEKTA*1.15+1.06)
                      ELSIF PIEKTA<20
                         CETURTA=(PIEKTA*1.07+1.35)
                         PIEKTA=(PIEKTA*1.15+1.06)
                      ELSE
                         CETURTA=(PIEKTA*1.05+1.75)
                         PIEKTA=(PIEKTA*1.10+2.06)
                      .
                   .
                   IF BAND(NOM:ARPVNBYTE,'00010000b')  !Jâsaglabâ Ar PVN
                      PIEKTA=PIEKTA*(1+PROC5/100)*(1+NOM:PVN_PROC/100)
                      IF NOM:PROC5=999 !ALGORITMS
                         CETURTA=CETURTA*(1+NOM:PVN_PROC/100)
                      .
                   ELSE
                      PIEKTA=PIEKTA*(1+PROC5/100)
                   .
                   !14/07/2012 
!                   KOMENT=NOM:NOMENKLAT
!        !           IF NOM:PIC_DATUMS<=P:DATUMS AND |
!        !           (~(NOM:PIC=P:PIC) OR ~(NOM:REALIZ[5]=PIEKTA) OR ~(NOM:REALIZ[4]=CETURTA)) AND ~BAND(NOM:BAITS1,00000100b) !NAV LOCK5
!                   IF ~(NOM:PIC=P:PIC)
!                      NOM:PIC=P:PIC
!                      NOM:PIC_DATUMS=P:DATUMS
!                      PUTNOM_K#=TRUE
!                      KOMENT=CLIP(KOMENT)&' Atlaboju PIC '
!                   .
                   IF (~(NOM:REALIZ[5]=PIEKTA) OR ~(NOM:REALIZ[4]=CETURTA)) AND ~BAND(NOM:BAITS1,00000100b) !NAV LOCK5
                      NOM:REALIZ[5]=PIEKTA
                      NOM:REALIZ[4]=CETURTA
                      NOM:VAL[5]   =VAL5
                      PUTNOM_K#=TRUE
                      KOMENT=CLIP(KOMENT)&' Atlaboju 5C '
                   .
                   IF NOM:REDZAMIBA=2 !NÂKOTNES
                      NOM:REDZAMIBA=0 !AKTÎVA, JA JAU IR P_TABLÇ
                      PUTNOM_K#=TRUE
                      KOMENT=CLIP(KOMENT)&' Atlaboju REDZAMÎBU '
                   .
                   IF PUTNOM_K#=TRUE
                      IF RIUPDATE:NOM_K()
                         KOMENT='   STATUSS: Kïûda atlabojot 5C/PIC/R: '&NOM:NOMENKLAT&error()
                      .
                      print(rpt:detail)
                      PUTNOM_K#=FALSE
                   .
                .
             .
          .
          IF F:KRI   !JÂPÂRBAUDA "TUKÐI" IERAKSTI
             SET(pavad)
             LOOP
                NEXT(PAVAD)
                IF ERROR() THEN BREAK.
                DO COUNTER
                CLEAR(NOL:RECORD)
                NOL:U_NR=PAV:U_NR
                SET(NOL:NR_KEY,NOL:NR_KEY)
                NEXT(NOLIK)
                IF ~(NOL:U_NR=PAV:U_NR)
                   KOMENT='Rakstam '&format(PAV:DATUMS,@d06.)&' Nr='&PAV:U_NR&' nav satura'
                   print(rpt:detail)
                .
             .
          .
          IF F:PAK   !JÂPÂRBAUDA AUTOSERVISS IERAKSTI
             SET(AUTOAPK)
             LOOP
                NEXT(AUTOAPK)
                IF ERROR() THEN BREAK.
                DO COUNTER
                clear(PAV:record)
                PAV:U_NR=APK:PAV_NR
                GET(PAVAD,PAV:NR_KEY)
                IF ERROR()
                   KLUDA(5,'PAVAD-AUTOAPK '&FORMAT(APK:datums,@D06.))
                   IF klu_darbiba
                      CLEAR(PAV:RECORD)
                      PAV:U_NR=APK:PAV_NR
                      PAV:DATUMS=APK:DATUMS
                      PAV:D_K='K'
                      PAV:PAR_NR=APK:PAR_NR
                      PAV:NOKA=GETPAR_K(APK:PAR_NR,2,1)
                      PAV:PAMAT='?????????????????'
                      ADD(PAVAD)
                      IF ERROR()
                         KOMENT='Relâcijas kïûda PAVAD-AUTOAPK :'&FORMAT(APK:datums,@D06.)&' Rakstu nav iespçjams atjaunot'
                         print(rpt:detail)
                      ELSE
                         KOMENT='Relâcijas kïûda PAVAD-AUTOAPK :'&FORMAT(APK:datums,@D06.)&' Raksts ir atjaunots'
                         print(rpt:detail)
                      .
                   ELSE
                      KOMENT='Relâcijas kïûda PAVAD-AUTOAPK :'&FORMAT(APK:datums,@D06.)&' LIETOTÂJA ATTEIKUMS atjaunot'
                      print(rpt:detail)
                   .
                ELSE
                   IF ~(APK:DATUMS=PAV:DATUMS)
                      APK:DATUMS=PAV:DATUMS
                      IF RIUPDATE:AUTOAPK()
                         KOMENT='   STATUSS: Kïûda atlabojot AUTOAPK: '&FORMAT(PAV:datums,@D06.)&error()
                         print(rpt:detail)
                      ELSE
                         CLEAR(APD:RECORD)
                         APD:PAV_NR=APK:PAV_NR
                         SET(APD:NR_KEY,APD:NR_KEY)
                         LOOP
                            NEXT(AUTODARBI)
                            IF ERROR() OR ~(APD:PAV_NR=APK:PAV_NR) THEN BREAK.
                            IF ~(APK:DATUMS=APD:DATUMS)
                               APD:DATUMS=APK:DATUMS
                               IF RIUPDATE:AUTODARBI()
                                  KOMENT='   STATUSS: Kïûda atlabojot AUTODARBI: '&FORMAT(APK:datums,@D06.)&error()
                                  print(rpt:detail)
                               .
                            .
                         .
                      .
                   .
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
          FREE(K_TABLE)
          FREE(P_TABLE)
          FREE(N_TABLE)
          pavad::used-=1
          if pavad::used=0
             close(pavad)
          .
          nolik::used-=1
          if nolik::used=0
             CLOSE(nolik)
          .
          nom_k::used-=1
          if NOM_K::used=0
             CLOSE(nom_K)
          .
          nom_a::used-=1
          if NOM_A::used=0
             CLOSE(nom_A)
          .
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
               END
             END
             ?Progress:UserString{Prop:Text}='Analizçju DB: '& RecordsProcessed
             DISPLAY()


!----------------------------------------------------------------------------------------------------
PAK2       ROUTINE
          NOM_NOMENKLAT=''      !NOL:NOMENKLAT
          SAV_NOMENKLAT=NOL:NOMENKLAT
          LOOP I# = 1 TO 211    !UZ EKRÂNA 1 LAPÂ IR 42 RINDAS
             EXECUTE I#
                NOM_NOMENKLAT='FN FRA-C9766ECO'
                NOM_NOMENKLAT='FN FRA-CA10290'
                NOM_NOMENKLAT='FN FRA-G10146'
                NOM_NOMENKLAT='KR K305838'
                NOM_NOMENKLAT='KR R351885'
                NOM_NOMENKLAT='KR R90970500'
                NOM_NOMENKLAT='LAMPINU MAINA'
                NOM_NOMENKLAT='LAMPINU REMONTS'
                NOM_NOMENKLAT='LODBALSTA MAINA'
                NOM_NOMENKLAT='LOGA TIR.REMONTS'
                NOM_NOMENKLAT='LOGU PACELAJA DE'
                NOM_NOMENKLAT='LOGU PACELAJA DE'
                NOM_NOMENKLAT='LOGU PACELAJA REM'
                NOM_NOMENKLAT='LOGU PACELAJA REM'
                NOM_NOMENKLAT='LOGU SLOTINU MAINA'
                NOM_NOMENKLAT='LOGU TIR MEHANIS'
                NOM_NOMENKLAT='LOGU TIRITAJA MAIN'
                NOM_NOMENKLAT='LOGU TIRITAJA PARS'
                NOM_NOMENKLAT='LOGU TONESANA'
                NOM_NOMENKLAT='LUKT.AUGST.REGULES'
                NOM_NOMENKLAT='LUKT.MAZG.MONT.'
                NOM_NOMENKLAT='LUKTURA DEMMONT'
                NOM_NOMENKLAT='LUKTURA KOREKCIJA'
                NOM_NOMENKLAT='LUKTURA MAINA     .'
                NOM_NOMENKLAT='LUKTURA REGUL'
                NOM_NOMENKLAT='LUKTURA REMONTS'
                NOM_NOMENKLAT='LUKTURU REG,MAIANA'
                NOM_NOMENKLAT='MAF-0467'
                NOM_NOMENKLAT='MAZGASANA'
                NOM_NOMENKLAT='MEHANISMA REMONTS'
                NOM_NOMENKLAT='METINASANA'
                NOM_NOMENKLAT='MIGLAS LUKT.MAINA'
                NOM_NOMENKLAT='MIGLAS LUKT.UZST.'
                NOM_NOMENKLAT='MOLDINGA MAINA'
                NOM_NOMENKLAT='MOT. DIAGNOSTIKA'
                NOM_NOMENKLAT='MOTORA MAINA,PARTAISI'
                NOM_NOMENKLAT='MOTORA MAZG.'
                NOM_NOMENKLAT='MOTORINA PARBAUD'
                NOM_NOMENKLAT='NE B13750'
                NOM_NOMENKLAT='NOSEGA MAINA'
                NOM_NOMENKLAT='NR.APG.LUKT.MAINA'
                NOM_NOMENKLAT='NUM.APG.MAINA AGB'
                NOM_NOMENKLAT='NUM.APG.REMONTS'
                NOM_NOMENKLAT='NUM.MAINA'
                NOM_NOMENKLAT='NUMURA PALIKT.MONT'
                NOM_NOMENKLAT='OR 0000084001C 3H1'
                NOM_NOMENKLAT='OR 01K1084400B 084'
                NOM_NOMENKLAT='OR 96K9955345'
                NOM_NOMENKLAT='PAGRIEZIENA MAINA'
                NOM_NOMENKLAT='PAK 01040001'
                NOM_NOMENKLAT='PAK 01400000'
                NOM_NOMENKLAT='PAK 01500000'
                NOM_NOMENKLAT='PAK AUTO NOMA.'
                NOM_NOMENKLAT='PAKALPOJUMS   ""'
                NOM_NOMENKLAT='PAKALPOJUMS   ['
                NOM_NOMENKLAT='PAKALPOJUMS)'
                NOM_NOMENKLAT='PAKALPOJUMS,'
                NOM_NOMENKLAT='PAKALPOJUMS. .'
                NOM_NOMENKLAT='PAKX0899854943'
                NOM_NOMENKLAT='PAKX17140'
                NOM_NOMENKLAT='PAKX24702599.'
                NOM_NOMENKLAT='PAKX51767'
                NOM_NOMENKLAT='PAKX5284'
                NOM_NOMENKLAT='PAKX58650199.'
                NOM_NOMENKLAT='PAKX90252599.'
                NOM_NOMENKLAT='PANELA DEMONTAZA'
                NOM_NOMENKLAT='PANNAS UZLIKSANA'
                NOM_NOMENKLAT='PARKSENSORA MAINA'
                NOM_NOMENKLAT='PARSLEDZEJA MAINA'
                NOM_NOMENKLAT='PASPARNA DEM.,MONT'
                NOM_NOMENKLAT='PASPARNA REMONTS'
                NOM_NOMENKLAT='PIEPIPETAJA DEM.MON.'
                NOM_NOMENKLAT='PIRMSPARDOSANAS'
                NOM_NOMENKLAT='PLASTMASU MAINA'
                NOM_NOMENKLAT='PLASTMASU NOSTIPRI'
                NOM_NOMENKLAT='PLAUKTU DEMONTAZA'
                NOM_NOMENKLAT='PLEVJU NONEMSANA'
                NOM_NOMENKLAT='PRETESTIBAS MAINA'
                NOM_NOMENKLAT='PROGRAMESANA'
                NOM_NOMENKLAT='PULTS KODESNA'
                NOM_NOMENKLAT='PUT.GUM. MAINA'
                NOM_NOMENKLAT='RADIATORA MAINA'
                NOM_NOMENKLAT='RADIO DEMONT.MONT.'
                NOM_NOMENKLAT='RADIO MAINA'
                NOM_NOMENKLAT='REGISTRACIJA'
                NOM_NOMENKLAT='RELEJA MAINA'
                NOM_NOMENKLAT='REMKOMLEKTA MAINA'
                NOM_NOMENKLAT='REMONTS'
                NOM_NOMENKLAT='REMONTS!'
                NOM_NOMENKLAT='REMONTS.'
                NOM_NOMENKLAT='RESTES DEMONT.,MONT.'
                NOM_NOMENKLAT='REZERVES RIT. REM.'
                NOM_NOMENKLAT='RIEPAS MONTAZA'
                NOM_NOMENKLAT='RIEPAS REM.'
                NOM_NOMENKLAT='RIEPAS REMONTS'
                NOM_NOMENKLAT='RIEPU BALANSESAN'
                NOM_NOMENKLAT='RIEPU MAINA'
                NOM_NOMENKLAT='RIEPU MONTAZA,BALANSE'
                NOM_NOMENKLAT='RIEPU REMONTS'
                NOM_NOMENKLAT='RIEPU SPIEDIENA PA'
                NOM_NOMENKLAT='RIEVSIKSNAS DEM.MO'
                NOM_NOMENKLAT='RIEVSIKSNAS DEM.MO'
                NOM_NOMENKLAT='RIT.DALAS REM.'
                NOM_NOMENKLAT='RITENA DEM.,MONT.'
                NOM_NOMENKLAT='RITENU BALANSESANA'
                NOM_NOMENKLAT='RITENU MAINA'
                NOM_NOMENKLAT='RITENU SKALOSANA'
                NOM_NOMENKLAT='RITOSA PARBAUD'
                NOM_NOMENKLAT='RITOSAS DEFEKTACIJ'
                NOM_NOMENKLAT='ROKAS BREMZES REMO'
                NOM_NOMENKLAT='ROKAS BREMZES TROS'
                NOM_NOMENKLAT='ROKTURA'
                NOM_NOMENKLAT='ROKTURA NOST.'
                NOM_NOMENKLAT='RULLA MAINA'
                NOM_NOMENKLAT='SAGATAV.SKATEI'
                NOM_NOMENKLAT='SAJUGA ATGAISOSANA'
                NOM_NOMENKLAT='SAJUGA MAINA'
                NOM_NOMENKLAT='SAKABES AK MAINA'
                NOM_NOMENKLAT='SALONA FILTRA MA'
                NOM_NOMENKLAT='SALONA TIRISANA'
                NOM_NOMENKLAT='SARNIRA MAINA'
                NOM_NOMENKLAT='SAV.REGULESANA'
                NOM_NOMENKLAT='SAVERSUMA PARBAUDE'
                NOM_NOMENKLAT='SAVERSUMA PARBAUDE'
                NOM_NOMENKLAT='SAVERSUMA REG.'
                NOM_NOMENKLAT='SAVIRZE'
                NOM_NOMENKLAT='SAVIRZES'
                NOM_NOMENKLAT='SAVIRZES PARBAUD'
                NOM_NOMENKLAT='SIGN.UZSTADISANA'
                NOM_NOMENKLAT='SIGNALIZACIJA P'
                NOM_NOMENKLAT='SIGNALIZACIJA+'
                NOM_NOMENKLAT='SIGNALIZACIJAS U'
                NOM_NOMENKLAT='SIKSNAS MAINA'
                NOM_NOMENKLAT='SIKSNAS SPRIEGOS'
                NOM_NOMENKLAT='SILDITAJA DEM.MONT'
                NOM_NOMENKLAT='SISTEMAS ATS.UZPIL'
                NOM_NOMENKLAT='SKALOSANA'
                NOM_NOMENKLAT='SKALRUNA MAINA'
                NOM_NOMENKLAT='SLEDZA_MAINA'
                NOM_NOMENKLAT='SLEDZENES  MAINA'
                NOM_NOMENKLAT='SLEDZENES PROFIL'
                NOM_NOMENKLAT='SLIEKSNA   REMONTS'
                NOM_NOMENKLAT='SLOTINU MAINA'
                NOM_NOMENKLAT='SLOTINU MAINA'
                NOM_NOMENKLAT='SPARARATA MAINA'
                NOM_NOMENKLAT='SPIED.DEVEJA PARBAUDE'
                NOM_NOMENKLAT='SPIEDIENA DEV.MAIN'
                NOM_NOMENKLAT='SPOGULA KORP. MAIN'
                NOM_NOMENKLAT='SPOGULA KORPUSA MA'
                NOM_NOMENKLAT='SPOGULA KRASOSANA'
                NOM_NOMENKLAT='SPOLES DE.,MONT.'
                NOM_NOMENKLAT='SPOLES MAINA'
                NOM_NOMENKLAT='SPRAUSLAS MAINA'
                NOM_NOMENKLAT='SPRAUSLAS TIRISANA'
                NOM_NOMENKLAT='SPTRIEGOTAJA MAINA'
                NOM_NOMENKLAT='STAB.BUKSU MAINA'
                NOM_NOMENKLAT='STABILIZATORA STIE'
                NOM_NOMENKLAT='STATNES REMONTS'
                NOM_NOMENKLAT='STIKLA MAINA .'
                NOM_NOMENKLAT='STIKLU TIRISANA'
                NOM_NOMENKLAT='STRAVAS MERISANA'
                NOM_NOMENKLAT='STURES MEH MAINA'
                NOM_NOMENKLAT='STURES PASTIPRIN'
                NOM_NOMENKLAT='STURES PIRKSTA MAI'
                NOM_NOMENKLAT='STURES STIENA MAIN'
                NOM_NOMENKLAT='STURES UZGALA MA'
                NOM_NOMENKLAT='SUKNA MAINA'
                NOM_NOMENKLAT='SUPORTA MAINA'
                NOM_NOMENKLAT='SUPORTA REMONTS'
                NOM_NOMENKLAT='SVECU MAINA'
                NOM_NOMENKLAT='SVECU PARBAUDE'
                NOM_NOMENKLAT='SVIRAS MAINA'
                NOM_NOMENKLAT='TAURES MAINA'
                NOM_NOMENKLAT='TEMP.DEVEJA MAINA'
                NOM_NOMENKLAT='TONA JAUKSANA.'
                NOM_NOMENKLAT='TRANSPORTA PAKA'
                NOM_NOMENKLAT='TRANSPORTESANA'
                NOM_NOMENKLAT='TRUBAS MAINA'
                NOM_NOMENKLAT='TURBINAS MAINA'
                NOM_NOMENKLAT='TURBINAS PARBAUDE'
                NOM_NOMENKLAT='TURBINAS REMONTS'
                NOM_NOMENKLAT='TURBINES DIAGNOS'
                NOM_NOMENKLAT='UDENS SUKNA MAINA'
                NOM_NOMENKLAT='UZLIKAS DEMONT.MONT.'
                NOM_NOMENKLAT='UZLIKAS MAINA'
                NOM_NOMENKLAT='UUZLIMJU ATJAUNOSAN'
                NOM_NOMENKLAT='UZLIMJU ATJAUNOSAN'
                NOM_NOMENKLAT='UZLIMJU NONEMSANA'
                NOM_NOMENKLAT='VAD.BLOKA MAINA'
                NOM_NOMENKLAT='VADA MAINA'
                NOM_NOMENKLAT='VADIBAS BLOKA PROGR.'
                NOM_NOMENKLAT='VADIKLU REM.KOMPL.'
                NOM_NOMENKLAT='VADU KULA MAINA'
                NOM_NOMENKLAT='VADU PARBAUDE'
                NOM_NOMENKLAT='VADU REMONTS'
                NOM_NOMENKLAT='VAKA MONT.,DEMONT.'
                NOM_NOMENKLAT='VALODAS MAINA'
                NOM_NOMENKLAT='VARSTA MAINA'
                NOM_NOMENKLAT='VENTILA MAINA'
                NOM_NOMENKLAT='VVENTILATORA MAINA'
                NOM_NOMENKLAT='VENTILATORA MAINA .'
                NOM_NOMENKLAT='VIRSBUVES REMONTS'
                NOM_NOMENKLAT='ZOBS.MONT.,DEM.'
                NOM_NOMENKLAT='ZOBS.MONT.,DEM.'
                NOM_NOMENKLAT='ZOBSIKSNAS MAINA'
                NOM_NOMENKLAT='ZONDES MAINA 1'
             .
             IF NOL:NOMENKLAT=NOM_NOMENKLAT
                NOBIDE#=0
                LEN#=LEN(CLIP(NOL:NOMENKLAT))
                LOOP I#=2 TO LEN#
                   IF INSTRING(NOL:NOMENKLAT[I#],' .,;:*"/()',1)
                      IF INRANGE(I#,2,20)
                         IF I#<LEN#
                            NOM_NOMENKLAT=NOM_NOMENKLAT[1:I#-1-NOBIDE#]&NOM_NOMENKLAT[I#+1-NOBIDE#:21] !PA VIDU
                            NOBIDE#+=1
                         ELSE
                            NOM_NOMENKLAT[I#-NOBIDE#]='X' !BEIGÂS
                         .
                      .
                   .
                .
                IF (SAV_NOMENKLAT[1:4]='PAK ')
                   NOL:NOMENKLAT='PAKX'&NOM_NOMENKLAT[4:21]
                ELSE
                   NOL:NOMENKLAT='PAKX'&NOM_NOMENKLAT
                .
                IF RIUPDATE:NOLIK()
                   KOMENT='KLUDA RAKSTOT NOLIK '&CLIP(NOL:NOMENKLAT)&' no '&SAV_NOMENKLAT
                   DISPLAY
                   print(rpt:detail)
                ELSE
                   KOMENT='NOLIK Nomenklatûra '&SAV_NOMENKLAT&' mainîta uz '&NOL:NOMENKLAT
                   DISPLAY
                   print(rpt:detail)
                .
                BREAK
             .
          .
Sel_Nol_Nr25 PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
window               WINDOW('Noliktavu Izvçles logs'),AT(,,162,238),GRAY
                       CHECK('Noliktava Nr 1'),AT(11,5,62,10),USE(NOL_NR25[1]),HIDE
                       CHECK('Noliktava Nr 2'),AT(11,14,62,10),USE(NOL_NR25[2]),HIDE
                       CHECK('Noliktava Nr 3'),AT(11,23,62,10),USE(NOL_NR25[3]),HIDE
                       CHECK('Noliktava Nr 4'),AT(11,32,62,10),USE(NOL_NR25[4]),HIDE
                       CHECK('Noliktava Nr 5'),AT(11,41,62,10),USE(NOL_NR25[5]),HIDE
                       CHECK('Noliktava Nr 6'),AT(11,50,62,10),USE(NOL_NR25[6]),HIDE
                       CHECK('Noliktava Nr 7'),AT(11,59,62,10),USE(NOL_NR25[7]),HIDE
                       CHECK('Noliktava Nr 8'),AT(11,68,62,10),USE(NOL_NR25[8]),HIDE
                       CHECK('Noliktava Nr 9'),AT(11,77,62,10),USE(NOL_NR25[9]),HIDE
                       CHECK('Noliktava Nr 10'),AT(11,86,62,10),USE(NOL_NR25[10]),HIDE
                       CHECK('Noliktava Nr 11'),AT(11,95,62,10),USE(NOL_NR25[11]),HIDE
                       CHECK('Noliktava Nr 12'),AT(11,104,62,10),USE(NOL_NR25[12]),HIDE
                       CHECK('Noliktava Nr 13'),AT(11,113,62,10),USE(NOL_NR25[13]),HIDE
                       CHECK('Noliktava Nr 14'),AT(11,122,62,10),USE(NOL_NR25[14]),HIDE
                       CHECK('Noliktava Nr 15'),AT(11,131,62,10),USE(NOL_NR25[15]),HIDE
                       CHECK('Noliktava Nr 16'),AT(11,140,62,10),USE(NOL_NR25[16]),HIDE
                       CHECK('Noliktava Nr 17'),AT(11,149),USE(NOL_NR25[17]),HIDE
                       CHECK('Noliktava Nr 18'),AT(11,158,62,10),USE(NOL_NR25[18]),HIDE
                       CHECK('Noliktava Nr 19'),AT(11,167,62,10),USE(NOL_NR25[19]),HIDE
                       CHECK('Noliktava Nr 20'),AT(11,176,62,10),USE(NOL_NR25[20]),HIDE
                       CHECK('Noliktava Nr 21'),AT(11,185,62,10),USE(NOL_NR25[21]),HIDE
                       CHECK('Noliktava Nr 22'),AT(11,194,62,10),USE(NOL_NR25[22]),HIDE
                       CHECK('Noliktava Nr 23'),AT(11,203,62,10),USE(NOL_NR25[23]),HIDE
                       CHECK('Noliktava Nr 24'),AT(11,212,62,10),USE(NOL_NR25[24]),HIDE
                       CHECK('Noliktava Nr 25'),AT(11,220,62,10),USE(NOL_NR25[25]),HIDE
                       BUTTON('&Atzîmçt visas'),AT(83,7,60,14),USE(?Atzimetvisas)
                       BUTTON('Noòemt &visas'),AT(83,28,60,14),USE(?NonemtVisas)
                       BUTTON('&OK'),AT(97,216,31,14),USE(?OkButton),DEFAULT
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  LOOP I#=1 TO NOL_SK
     IF NOL_NR25[I#]=TRUE
        NOL_NR25#=TRUE
        BREAK
     .
  .
  IF ~NOL_NR25#
     LOOP I#=1 TO NOL_SK
        NOL_NR25[I#]=TRUE
     .
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  !!STOP('NOL_SK '&NOL_SK)
  LOOP I#=1 TO NOL_SK
      EXECUTE I#
          UNHIDE(?NOL_NR25_1)
          UNHIDE(?NOL_NR25_2)
          UNHIDE(?NOL_NR25_3)
          UNHIDE(?NOL_NR25_4)
          UNHIDE(?NOL_NR25_5)
          UNHIDE(?NOL_NR25_6)
          UNHIDE(?NOL_NR25_7)
          UNHIDE(?NOL_NR25_8)
          UNHIDE(?NOL_NR25_9)
          UNHIDE(?NOL_NR25_10)
          UNHIDE(?NOL_NR25_11)
          UNHIDE(?NOL_NR25_12)
          UNHIDE(?NOL_NR25_13)
          UNHIDE(?NOL_NR25_14)
          UNHIDE(?NOL_NR25_15)
          UNHIDE(?NOL_NR25_16)
          UNHIDE(?NOL_NR25_17)
          UNHIDE(?NOL_NR25_18)
          UNHIDE(?NOL_NR25_19)
          UNHIDE(?NOL_NR25_20)
          UNHIDE(?NOL_NR25_21)
          UNHIDE(?NOL_NR25_22)
          UNHIDE(?NOL_NR25_23)
          UNHIDE(?NOL_NR25_24)
          UNHIDE(?NOL_NR25_25)
      END
  END
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?NOL_NR25_1)
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
    OF ?Atzimetvisas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LOOP I#=1 TO NOL_SK
          NOL_NR25[I#]=TRUE
        END
        DISPLAY
      END
    OF ?NonemtVisas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LOOP I#=1 TO NOL_SK
            NOL_NR25[I#]=0
        END
        DISPLAY
      END
    OF ?OkButton
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
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
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('Sel_Nol_Nr25','winlats.INI')
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
    INISaveWindow('Sel_Nol_Nr25','winlats.INI')
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
N_REGZUR             PROCEDURE                    ! Declare Procedure
RPT_dk              string(11)
PS                  STRING(20)
rpt_NR              DECIMAL(4)
PAV_DEK_NR          STRING(15)
PAV_DATUMS          LONG
PAV_DATUMS1         LONG
PIEGAD              STRING(20)
MARKA               STRING(5)
SUMMA_B             DECIMAL(11,2)
SUMMA_A            DECIMAL(11,2)
SUMMA_PVN            DECIMAL(10,2)
SUMMA_P            DECIMAL(12,2)
DAT                 LONG
LAI                 LONG
CN                  STRING(10)
B_TABLE             QUEUE,PRE(B)
BKK                 STRING(5)
SUMMA               DECIMAL(12,2)
                    .
BKK                 STRING(5)
DAUDZUMS            DECIMAL(12,2)
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
Process:View         VIEW(PAVAD)
                       PROJECT(PAV:U_NR)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:PAR_NR)
                     END
!------------------------------------------------------------------------
report REPORT,AT(302,2146,10000,5802),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(302,500,10000,1646),USE(?unnamed:2)
         LINE,AT(1094,938,0,729),USE(?Line2:3),COLOR(COLOR:Black)
         STRING('datums'),AT(573,1198,521,208),USE(?String9:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Deklarâcijas'),AT(1146,1198,990,208),USE(?String9:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nr'),AT(1146,1406,990,208),USE(?String9:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('marka'),AT(4115,1406,938,208),USE(?String9:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(bez PVN)'),AT(5208,1406,729,208),USE(?String9:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1615,9583,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(8333,938,0,729),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(9688,938,0,729),USE(?Line2:23),COLOR(COLOR:Black)
         STRING('kopâ '),AT(7500,1198,833,208),USE(?String9:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(7500,1406,833,208),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Paraksts'),AT(8385,990,1302,208),USE(?String40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Summa'),AT(7500,990,833,208),USE(?String9:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,938,0,729),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('PVN'),AT(6771,990,677,208),USE(?String9:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6719,938,0,729),USE(?Line2:9),COLOR(COLOR:Black)
         STRING('nodoklis'),AT(5990,1198,729,208),USE(?String9:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Akcîzes'),AT(5990,990,729,208),USE(?String9:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5938,938,0,729),USE(?Line2:8),COLOR(COLOR:Black)
         STRING('vçrtîba'),AT(5208,1198,729,208),USE(?String9:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Degvielas'),AT(5208,990,729,208),USE(?String9:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,938,0,729),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('daudzums,'),AT(4115,1198,938,208),USE(?String9:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Degvielas'),AT(4115,990,938,208),USE(?String9:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4063,938,0,729),USE(?Line2:6),COLOR(COLOR:Black)
         STRING(@s20),AT(2760,990),USE(PS),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2708,938,0,729),USE(?Line2:5),COLOR(COLOR:Black)
         STRING('datums'),AT(2188,1198,521,208),USE(?String9:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('P/Z'),AT(2188,990,521,208),USE(?String9:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2135,938,0,729),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Pavadzîmes'),AT(1146,990,990,208),USE(?String9:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1823,104,4323,260),USE(client),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Noliktava :'),AT(2708,417),USE(?String2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@N2),AT(3542,417,219,208),USE(LOC_NR),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(8073,729),PAGENO,USE(?PageCount),RIGHT
         STRING(@s11),AT(1135,677,833,208),USE(RPT_DK),RIGHT(1),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING('degvielas P/Z reìistrâcijas þurnâls no'),AT(2000,677),USE(?String5),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(4531,677),USE(S_DAT),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('lîdz'),AT(5469,677),USE(?String5:2),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@D06.),AT(5781,677),USE(b_DAT),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,938,9583,0),USE(?Line1),COLOR(COLOR:Black)
         LINE,AT(521,938,0,729),USE(?Line2:2),COLOR(COLOR:Black)
         STRING('Npk'),AT(156,990,365,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Reìistr.'),AT(573,990,521,208),USE(?String9:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,938,0,729),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         LINE,AT(104,-10,0,198),USE(?Line2:12),COLOR(COLOR:Black)
         STRING(@N4B),AT(156,10,313,156),USE(rpt_NR),RIGHT
         LINE,AT(521,-10,0,198),USE(?Line2:13),COLOR(COLOR:Black)
         STRING(@D5B),AT(573,10,469,156),USE(PAV_DATUMS),RIGHT
         LINE,AT(1094,-10,0,198),USE(?Line2:14),COLOR(COLOR:Black)
         STRING(@S15),AT(1135,10,990,156),USE(PAV_DEK_NR),LEFT
         LINE,AT(2135,-10,0,198),USE(?Line2:15),COLOR(COLOR:Black)
         STRING(@D5B),AT(2188,10,469,156),USE(PAV_DATUMS1),RIGHT
         LINE,AT(2708,-10,0,198),USE(?Line2:16),COLOR(COLOR:Black)
         STRING(@s20),AT(2760,10,,156),USE(PIEGAD),LEFT
         LINE,AT(4063,-10,0,198),USE(?Line2:17),COLOR(COLOR:Black)
         STRING(@N_7B),AT(4115,10,469,156),USE(DAUDZUMS),RIGHT
         STRING(@S5),AT(4688,10,365,156),USE(MARKA),LEFT
         LINE,AT(5104,-10,0,198),USE(?Line2:18),COLOR(COLOR:Black)
         STRING(@N_11.2B),AT(5156,10,729,156),USE(SUMMA_B),RIGHT
         LINE,AT(5938,-10,0,198),USE(?Line2:19),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(5990,10,677,156),USE(SUMMA_A),RIGHT
         LINE,AT(6719,-10,0,198),USE(?Line2:20),COLOR(COLOR:Black)
         STRING(@N_10.2B),AT(6771,10,625,156),USE(SUMMA_PVN),RIGHT
         LINE,AT(7448,-10,0,198),USE(?Line2:21),COLOR(COLOR:Black)
         STRING(@N_12.2B),AT(7500,10,781,156),USE(SUMMA_P),RIGHT
         LINE,AT(8333,-10,0,198),USE(?Line2:22),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,198),USE(?Line2:24),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,177)
         LINE,AT(1094,-10,0,198),USE(?Line28:2),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,198),USE(?Line30),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,198),USE(?Line31),COLOR(COLOR:Black)
         LINE,AT(4063,-10,0,198),USE(?Line32),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,198),USE(?Line33),COLOR(COLOR:Black)
         LINE,AT(5938,-10,0,198),USE(?Line34),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,198),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,198),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,198),USE(?Line37),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,198),USE(?Line37:2),COLOR(COLOR:Black)
         LINE,AT(104,104,9583,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,198),USE(?Line2:25),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,198),USE(?Line28),COLOR(COLOR:Black)
       END
RPT_FOOT DETAIL,AT(,,,250),USE(?unnamed)
         LINE,AT(5938,-10,0,63),USE(?Line46:2),COLOR(COLOR:Black)
         LINE,AT(6719,-10,0,63),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(7448,-10,0,63),USE(?Line49),COLOR(COLOR:Black)
         LINE,AT(8333,-10,0,63),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(9688,-10,0,63),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(104,52,9583,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@d06.),AT(8635,73),USE(dat),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@t4),AT(9240,73),USE(lai),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(4063,-10,0,63),USE(?Line41:5),COLOR(COLOR:Black)
         LINE,AT(5104,-10,0,63),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(2708,-10,0,63),USE(?Line41:4),COLOR(COLOR:Black)
         LINE,AT(2135,-10,0,63),USE(?Line41:3),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,63),USE(?Line41:2),COLOR(COLOR:Black)
         LINE,AT(104,-10,0,63),USE(?Line40),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line41),COLOR(COLOR:Black)
       END
       FOOTER,AT(302,7850,10000,52)
         LINE,AT(104,0,9583,0),USE(?Line1:5),COLOR(COLOR:Black)
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
!  DEGVIELAS REÌISTRÂCIJAS ÞURNÂLS
!  PAR VISIEM PARTNERIEM
!
  PUSHBIND
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(PAVAD,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(NOM_K,1)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('D_K',D_K)
  BIND('CN',CN)
  BIND('CYCLENOL',CYCLENOL)

  I# = 0
  V#=0
  DONE# = 0                                      !TURN OFF DONE FLAG
  RPT_NR=0
  DAT = TODAY()
  LAI = CLOCK()
  IF D_K='D'
    rpt_DK='Ienâkoðâs'
    PS='Piegâdâtâjs'
  ELSE
    RPT_DK='Izejoðâs'
    PS='Saòçmâjs'
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  BIND(NOL:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(PAVAD)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Degvielas reìistrâcijas þurnâls'
  ?Progress:UserString{Prop:Text}=''
  SEND(PAVAD,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CN = 'P1001'
      CLEAR(PAV:RECORD)                              !MAKE SURE RECORD CLEARED
      PAV:DATUMS = S_DAT
      PAV:D_K    = D_K
      SET(PAV:DAT_KEY,PAV:DAT_KEY)                   !  POINT TO FIRST RECORD
      Process:View{Prop:Filter} ='~CYCLENOL(CN)'
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
        C# = GETPAR_K(PAV:PAR_NR,2,1)
        IF PAR:NOS_S
          PIEGAD=PAR:NOS_S
        ELSE
          PIEGAD=PAV:NOKA
        .
        NR#+=1
        RPT_NR = NR#
        PAV_DEK_NR=PAV:DOK_SENR
        PAV_DATUMS=PAV:DATUMS
        PAV_DATUMS1=PAV:DATUMS
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        SET(NOL:NR_KEY,NOL:NR_KEY)
        R#=0
        LOOP
          NEXT(NOLIK)
          IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
          R#+=1
!??          C#=GETNOM_K(NOL:NOMENKLAT,2,1)
          DAUDZUMS=NOL:DAUDZUMS
          MARKA=NOL:NOMENKLAT[1:5]
          SUMMA_A=NOM:REALIZ[4]*NOL:DAUDZUMS    ! AKCÎZE BEZ PVN
          SUMMA_B =CALCSUM(15,2)-SUMMA_A
          SUMMA_PVN=CALCSUM(17,2)
          SUMMA_P=CALCSUM(16,2)
          PRINT(RPT:DETAIL)
          RPT_NR=0
          IF R#=1
            PAV_DEK_NR=PAV:DEK_NR
          ELSE
            PAV_DEK_NR=''
          .
          PAV_DATUMS=0
          PAV_DATUMS1=0
          PIEGAD=''
        .
        IF R#=1 AND PAV:DEK_NR
          RPT_NR=0
          PAV_DATUMS=0
          PAV_DATUMS1=0
          PIEGAD=''
          PAV_DEK_NR=PAV:DEK_NR
          DAUDZUMS=0
          MARKA=''
          SUMMA_A=0
          SUMMA_B =0
          SUMMA_PVN=0
          SUMMA_P=0
          PRINT(RPT:DETAIL)
        .
        PRINT(RPT:DETAIL1)
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
  IF SEND(PAVAD,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:RPT_FOOT)
    ENDPAGE(report)
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
  IF FilesOpened
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
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
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
  PREVIOUS(Process:View)
  IF ERRORCODE() OR PAV:DATUMS>B_DAT
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% no DB analizçti'
      DISPLAY()
    END
  END
