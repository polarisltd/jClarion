                     MEMBER('winlats.clw')        ! This is a MEMBER module
R_EMAKS_             PROCEDURE                    ! Declare Procedure
LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:G1:U_NR    LIKE(GG:U_NR)
DISKS                 CSTRING(60)

PAR_NR_               ULONG
DISKETE               BYTE
MERKIS                STRING(1)
darbiba               STRING(30)
FAILS                 CSTRING(20)
DOK_SK                USHORT
KONT_SK               USHORT
DATUMS                LONG
SDATUMS               STRING(8)
SCLIENT               STRING(12) !+1 05.12.08
SREFERENCE            STRING(13)
PAR_FILEALE           STRING(1)
PAR_REG_NR            STRING(12) !D/S+1 05.12.08
PR_DEBET              STRING(5)
PR_KREDIT             STRING(5)
NODALA                STRING(2)
PR_NODALA             STRING(2)
KKK_Deb               STRING(5)
KKK_Kred              STRING(5)
ATT_DOK               LIKE(GG:ATT_DOK)
Dok_SENR              LIKE(GG:Dok_SENR)
GK1_KK                BYTE
PR_DUS                STRING(2)

XMLDIRNAME     CSTRING(200),STATIC

TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR                STRING(200)
                END
             END


zina       string(40)

RejectRecord         LONG
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
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(65,42,50,15),USE(?Progress:Cancel)
     END



window WINDOW('Apmaiòas faila lasîðana...'),AT(,,190,109),CENTER,TIMER(1),GRAY,DOUBLE,MDI
       BUTTON('&Izvçlçties'),AT(78,72,50,14),USE(?IzveletPartnieru)
       STRING('Bankas komisija pçc'),AT(8,29,70,10),USE(?KomisijaPec)
       BUTTON('&Kontu PLÂNA'),AT(78,27,50,14),USE(?KontuPlans)
       ENTRY(@s5),AT(134,29,27,10),USE(KKK),CENTER,OVR
       STRING('Debetori pçc'),AT(8,44,70,10),USE(?DebetoriPec)
       BUTTON('&Kontu PLÂNA'),AT(78,42,50,14),USE(?KontuPlansDeb)
       ENTRY(@s5),AT(134,44,27,10),USE(KKK_Deb),CENTER,OVR
       STRING('Kreditori pçc'),AT(8,59,70,10),USE(?KreditoriPec)
       BUTTON('&Kontu PLÂNA'),AT(78,57,50,14),USE(?KontuPlansKred)
       ENTRY(@s5),AT(134,59,27,10),USE(KKK_Kred),CENTER,OVR
       STRING('Partneris komisijai'),AT(8,74,70,10),USE(?PartnerisKomisijai)
       ENTRY(@n_7.0),AT(134,73,27,10),USE(Par_Nr_),CENTER,OVR
       STRING(@s40),AT(3,4,178,10),USE(zina),CENTER
       STRING(@s59),AT(3,12,179,10),USE(XMLFILENAME),CENTER
       BUTTON('&OK'),AT(101,92,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(139,92,35,14),USE(?ButtonCancel)
     END

!************** LOG FAILS *******************************
LOGNAME    STRING(100),STATIC
LOGFILE      FILE,NAME(LOGNAME),PRE(L),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR                STRING(256)
                END
             END


OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END

FidavistaFILE        CSTRING(200),STATIC
SAVBANKAS_K  LIKE(BANKAS_K:RECORD),PRE(B)
MAKSAJUMA_TAKA       STRING(55)
recs                 LONG
node                 LONG
D_K                  STRING(1)


MusuAccNo       STRING(34)
GrKonts         STRING(5)
MusuAccCcy      STRING(3)
GG_DOKDAT    STRING(10)
GG_SATURS    STRING(204)
GG_PAR_NR    LIKE(GG:PAR_NR)
GG_DOK_SENR  LIKE(GG:DOK_SENR)
GGK_SUMMA    STRING(11)
GG_VAL       LIKE(GG:VAL)
GG_NOKA      STRING(25) !15+ SUBSTITÛCIJAS
PAR_NOKA     STRING(25) !15+ SUBSTITÛCIJAS



State       SHORT
AccountSetQueue QUEUE,PRE(ACC)
AccNo       STRING(34)
                END

CcySetQueue QUEUE,PRE(CCY)
Ccy       STRING(3)
                END

TrxSetQueue     QUEUE,PRE(TRS)
TypeCode    STRING(4)
TypeName    STRING(70)
BookDate    STRING(10)
BankRef     STRING(25)
ExtID       STRING(10)
CorD        STRING(1)
AccAmt      STRING(12)
PmtInfo     STRING(200)
AccNo       STRING(34)
Name        STRING(140)
LegalID     STRING(35)
Ccy         STRING(3)
Amt         STRING(12)

                END

  CODE                                            ! Begin processed code
   FILENAME1=CLIP(LONGPATH())&'\GGBANKA.TPS'
   FILENAME2=CLIP(LONGPATH())&'\GGKBANKA.TPS'

   CHECKOPEN(G1,1)
   CLOSE(G1)
   OPEN(G1,18)
   EMPTY(G1)
   CHECKOPEN(GK1,1)
   CLOSE(GK1)
   OPEN(GK1,18)
   EMPTY(GK1)

   IF PAR_K::USED=0
      CHECKOPEN(PAR_K,1)
   .
   PAR_K::USED+=1

   LOGNAME=CLIP(LONGPATH())&'\'&'LOG.TXT'
   CHECKOPEN(LOGFILE,1)
   CLOSE(LOGFILE)
   OPEN(LOGFILE)
   IF ERROR()
      KLUDA(0,'Kïûda atverot '&CLIP(LOGNAME)&' '&ERROR())
      DO PROCEDURERETURN
   END
   CLEAR(L:RECORD)

   GETMYBANK()          ! MANA BANKA
   SAVbankas_k=BAN:RECORD
   MAKSAJUMA_TAKA=BAN:MAKSAJUMA_TAKA !MAN-C:\AKMENS\
   IF ~MAKSAJUMA_TAKA
      MAKSAJUMA_TAKA='C:\WINLATS\IMPEXP' !KLIENTIEM-NOKLUSÇTAIS
   .

   !26.09.2015 <
   TNAME_B='C:\Winlats\WINLATSC.INI'
   CHECKOPEN(TFILE_B,1)
   CLOSE(TFILE_B)
   OPEN(TFILE_B)
   IF ERROR()
      KLUDA(0,'Kïûda atverot '&CLIP(TNAME_B)&' '&ERROR())
      DO PROCEDURERETURN
   END
   FidavistaFILE=''
   SET(TFILE_B)
   LOOP
      NEXT (TFILE_B)
      IF ERROR() THEN BREAK.
      !STOP(B:STR[1:32] & 'I'&'fidavista '&CLIP(GL:REK[SYS:NOKL_B])&'=')
      IF B:STR[1:32] = 'fidavista '&CLIP(GL:REK[SYS:NOKL_B])&'=' then
         
         FidavistaFILE = CLIP(B:STR[33:200])
         BREAK
      END

   END

   !stop(CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(FidavistaFILE))

   IF FidavistaFILE=''
       KLUDA(0,'Nav atrasts fails kontam '&CLIP(GL:REK[SYS:NOKL_B])&'.Izmantots '&CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'B.XML')
       XMLFILENAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(BKODS)&'B.XML'
   ELSE
       XMLFILENAME=CLIP(MAKSAJUMA_TAKA)&'\'&CLIP(FidavistaFILE) ! XMLno bankas
   END
   !26.09.2015 >

   L:STR = GL:REK[SYS:NOKL_B]&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
   L:STR = CLIP(L:STR)&' Ielâde no faila '&clip(XMLFILENAME)
   ADD(LOGFILE)


   OPEN(WINDOW)
   ACCEPT
     CASE FIELD()
     OF ?ButtonCancel
        CASE EVENT()
        OF EVENT:Accepted
           DO PROCEDURERETURN
        .
     OF ?OKBUTTON
        CASE EVENT()
        OF EVENT:Accepted
!          CHECKOPEN(NOM_K,1)
!          CHECKOPEN(TEKSTI,1)
          BREAK
        .
     OF ?KontuPlans
         CASE EVENT()
         OF EVENT:Accepted
            !DO SyncWindow
            GlobalRequest = SelectRecord
            BrowseKON_K
            !LocalRequest = OriginalRequest
            !DO RefreshWindow
           if globalresponse=requestcompleted
              kkk=kon:bkk
           .
           display

         .
     OF ?KontuPlansDeb
         CASE EVENT()
         OF EVENT:Accepted
            !DO SyncWindow
            GlobalRequest = SelectRecord
            BrowseKON_K
            !LocalRequest = OriginalRequest
            !DO RefreshWindow
            if globalresponse=requestcompleted
               kkk_Deb=kon:bkk
            .
            display

         .
     OF ?KontuPlansKred
         CASE EVENT()
         OF EVENT:Accepted
            !DO SyncWindow
            GlobalRequest = SelectRecord
            BrowseKON_K
            !LocalRequest = OriginalRequest
            !DO RefreshWindow
            if globalresponse=requestcompleted
               kkk_Kred=kon:bkk
            .
            display

         .

    OF ?IzveletPartnieru
         CASE EVENT()
         OF EVENT:Accepted
            !DO SyncWindow
            GlobalRequest = SelectRecord
            BrowsePAR_K
            !LocalRequest = OriginalRequest
            !DO RefreshWindow
            if globalresponse=requestcompleted
               PAR_NR_ = par:U_NR
               PAR_NOKA = par:NOS_S
            .
            display

         .

     .
   .

   CLOSE(WINDOW)


    OPEN(OUTFILEXML)
    IF ERROR()
       L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
       L:STR = CLIP(L:STR)&' Nav atrodams fails: '&clip(XMLFILENAME)
       ADD(LOGFILE)
       KLUDA(0,'Nav atrodams fails: '&XMLFILENAME)
       CLOSE(OUTFILEXML)
       DO PROCEDURERETURN
    ELSE
       CLOSE(OUTFILEXML)
    .

    KONT_SK=0
    DOK_SK=0


    If ~xml:LoadFromFile(XMLFILENAME)
       If ~xml:FindNextNode('Statement','AccountSet')
          Loop
             Clear(AccountSetQueue);free(AccountSetQueue)
             Clear(CcySetQueue);free(CcySetQueue)
             Clear(TrxSetQueue);free(TrxSetQueue)
             Recs = Xml:loadQueue(AccountSetQueue,True,False)
             GET(AccountSetQueue,1) !pirmajs ieraksts
             MusuAccNo = ACC:AccNo

             AtrastsKonts# = 0
             GrKonts = ''
             LOOP L#=1 TO 10
                IF CLIP(GL:REK[L#]) = CLIP(MusuAccNo)
                    AtrastsKonts# = 1
                    GrKonts = GL:BKK[L#]
                    break
                .
             .
             If AtrastsKonts# = 0
                Message('Nav atrasts gr.konts bankas kontiem '&CLIP(MusuAccNo)&'.Tiek izmantots konts 2610.','Error',icon:hand)
             .

             State = Xml:SaveState() !saglabajam sito ierakstu numuru
             node = xml:FindNextNode('CcyStmt')
             Recs = Xml:loadQueue(CcySetQueue,True,False)
             GET(CcySetQueue,1) !pirmajs ieraksts
             MusuAccCcy = CCY:Ccy
             
             If ~xml:FindNextNode('TrxSet')
                Recs = Xml:loadQueue(TrxSetQueue,True,true)  ! visi ieraksti

                RecordsToProcess = RECORDS(TrxSetQueue)
                RecordsProcessed = 0
                PercentProgress = 0
                OPEN(ProgressWindow)
                Progress:Thermometer = 0
                ?Progress:PctText{Prop:Text} = '0%'
                ProgressWindow{Prop:Text} = 'Izraksts kontiem '&CLIP(MusuAccNo)
                ?Progress:UserString{Prop:Text}=''
                DISPLAY


                LOOP I#= 1 TO RECORDS(TrxSetQueue)
                   DO Thermometer
                   GET(TrxSetQueue,I#)
!                   if ~(TRS:TypeCode = 'INP') AND ~(TRS:TypeCode = 'MEMD') AND ~(TRS:TypeCode = 'CHOU') AND ~(TRS:TypeCode = 'OUTP')
!                      cycle
!                   .
                   DO AUTONUMBER

                   GG_DOKDAT = TRS:BookDate
                   GG_DOKDAT#=DEFORMAT(GG_DOKDAT,@D10-)
                   GG_DOK_SENR = TRS:BankRef
                   D_K = TRS:CorD

                   GG_SATURS = CLIP(TRS:TypeName)
                   GG_SATURS = INIGEN(GG_SATURS,,9)  !UTF-8
                   G1:Saturs2               =  GG_SATURS

                   GG_SATURS = CLIP(TRS:PmtInfo)
                   GG_SATURS = INIGEN(GG_SATURS,,9)  !UTF-8
                   G1:Saturs               =  GG_SATURS

                   KOMISIJA# = FALSE
                   GG_SATURS = UPPER(CLIP(TRS:TypeName))
                   !STOP('BKODS'&LEFT(BKODS,8)&'!!!')
                   IF ~(GG_SATURS = '')
                      IF LEFT(BKODS,8) = 'PARXLV22' OR LEFT(BKODS,8) = 'UNLALV2X'
                         !STOP('GG_SATURS '&GG_SATURS)
                         IF INSTRING('KOMISIJA',GG_SATURS,1)
                            KOMISIJA# = TRUE
                         .
                      ELSIF LEFT(BKODS,8) = 'HABALV22' AND LEFT(GG_SATURS,3) ='KOM'
                            KOMISIJA# = TRUE
                      .
                   .
                   GG_SATURS = UPPER(CLIP(TRS:PmtInfo))
                   IF ~(GG_SATURS = '')
                      IF LEFT(BKODS,8) = 'NDEALV2X' AND INSTRING('MAKSAJUMA KOMISIJA',GG_SATURS,1)
                            KOMISIJA# = TRUE
                      .
                   .
                   !STOP('KOMISIJA '&KOMISIJA#)
                   !GGK_SUMMA = TRS:AccAmt
                   GG_VAL = TRS:Ccy
                   GG_NOKA = TRS:Name
                   GG_NOKA=INIGEN(GG_NOKA,,9)  !UTF-8

                   G1:ATT_DOK='3'
                   G1:APMdat               = GG_DOKDAT#
                   G1:Dokdat               = GG_DOKDAT#
                   G1:Datums               = GG_DOKDAT#
                   G1:DOK_SENR             = GG_DOK_SENR
                   CLEAR(PAR:RECORD)
                   PAR:NMR_KODS=CLIP(TRS:LegalId)
                   PAR:NMR_PLUS=''
                   GET(PAR_K,PAR:NMR_KEY)
                   IF ~ERROR()
                      G1:Noka              =  PAR:NOS_S
                      G1:Par_nr            =  PAR:U_NR
                   ELSE
                      G1:Noka              =  GG_NOKA
                      G1:PAR_NR            =  0
                      IF G1:PAR_NR = 0 AND KOMISIJA# = TRUE AND ~(Par_NR_ = 0)
                         G1:PAR_NR = PAR_NR_
                         G1:Noka   = PAR_NOKA
                      .
                      KLUDA(0,'Nav atrasts reì.numurs klientam '&GG_NOKA)

                   .
                   If ~(TRS:Amt = '')
                       G1:Val                  = TRS:Ccy
                       G1:Summa                = TRS:Amt
                   else
                       G1:Val                  = MusuAccCcy
                       G1:Summa                = TRS:AccAmt
                   .
                   G1:ACC_KODS             = TRS:AccNo
                   G1:ACC_DATUMS           = TODAY()
                   G1:U_NR=Auto::Save:G1:U_NR

                   DO WRITEGGK

                 !   G1:IMP_NR=CON_NR
                   IF RIUPDATE:G1()
                      KLUDA(24,'G1')
                   .
                   DOK_SK+=1

!                   stop('PmtInfo '&TRS:PmtInfo)
                END
                CLOSE(PROGRESSWINDOW)
                If xml:RestoreState(State)
                    Message('Error Occurred!','Error',icon:hand)
                End

!                XML:DebugMyQueue(AccountSetQueue,'MyQueue Contents')
!                XML:DebugMyQueue(TrxSetQueue,'MyQueue Contents')

             END
             XML:Freestate(State)
             If Xml:GotoSibling() then break.
          End
          XML:Free()
       End
    .


   KLUDA(0,'KOPÂ: '&clip(DOK_SK)&' dokumenti '&clip(kont_sk)&' kontçjumi',,1)
   BROWSEGG1_MU

   DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
Autonumber ROUTINE    ! LASOT UZ REÂLO GG
  Auto::Attempts = 0
  LOOP
    SET(G1:NR_KEY)
    PREVIOUS(G1)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'G1')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:G1:U_NR = 2
    ELSE
      Auto::Save:G1:U_NR = G1:U_NR + 1
    END
    clear(G1:Record)
    G1:DATUMS=TODAY()
    G1:U_NR = Auto::Save:G1:U_NR
    ADD(G1)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          DO PROCEDURERETURN
        END
      END
      CYCLE
    END
    BREAK
  END

!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  CLOSE(GK1)
  CLOSE(G1)
  PAR_K::USED-=1
  IF PAR_K::USED=0
     CLOSE(PAR_K)
  .
  RETURN

!---------------------------------------------------------------------------------------------
WRITEGGK ROUTINE

  CLEAR(GK1:RECORD)
  GK1:U_nr      = G1:U_NR
  GK1:Rs        = ''
  GK1:Datums    = G1:datums
  GK1:Par_nr    = G1:par_nr
  IF ~GrKonts
     GK1:Bkk      = '26200'
  ELSE
     GK1:Bkk      = GrKonts
  .
  IF D_K = 'C'
     GK1:D_K       ='D'
  ELSE
     GK1:D_K       ='K'
  .
  GK1:Pvn_proc  = 21
  GK1:Pvn_tips  = '0'
  !GK1:KK     = 2^(B#-1)
  GK1:KK        =0
  GK1:SummaV    = G1:Summa
  GK1:Val       = G1:VAL
  GK1:Reference = ''
  GK1:Summa     = GK1:SummaV*BANKURS(GK1:VAL,GK1:DATUMS,' Dokuments:'&G1:DOK_SENR)
  GK1:BAITS     = 0 ! IEZAKS
  GK1:OBJ_NR    = 0

  ADD(GK1)
  IF ERROR()
     STOP(ERROR())
  ELSE
     KONT_SK+=1
  .

  CLEAR(GK1:RECORD)
  GK1:U_nr      = G1:U_NR
  GK1:Rs        = ''
  GK1:Datums    = G1:datums
  GK1:Par_nr    = G1:par_nr
  IF D_K = 'C'
     GK1:D_K       ='K'
     IF KOMISIJA# = TRUE
        IF kkk = ''
           GK1:Bkk       = '77200'
        ELSE
           GK1:Bkk       = kkk
        .
     ELSE
        if ~(TRS:TypeCode = 'INP') AND ~(TRS:TypeCode = 'OUTP') AND ~(TRS:TypeCode = '')
           GK1:Bkk       = '99999'
        else
           IF kkk_Deb = ''
              GK1:Bkk       = '23100'
           ELSE
              GK1:Bkk       = kkk_Deb
           .
        .
     .
  ELSE
     GK1:D_K       ='D'
     IF KOMISIJA# = TRUE
        IF kkk = ''
           GK1:Bkk       = '77200'
        ELSE
           GK1:Bkk       = kkk
        .
     ELSE
        if ~(TRS:TypeCode = 'INP') AND ~(TRS:TypeCode = 'OUTP') AND ~(TRS:TypeCode = '')
           GK1:Bkk       = '99999'
        else
           IF kkk_Kred = ''
              GK1:Bkk       = '53100'
           ELSE
              GK1:Bkk       = kkk_Kred
           .
        .
     .
  .
  GK1:Pvn_proc  = 21
  GK1:Pvn_tips  = '0'
  !GK1:KK     = 2^(B#-1)
  GK1:KK        =0
  GK1:SummaV    = G1:Summa
  GK1:Val       = G1:VAL
  GK1:Reference = ''
  GK1:Summa     = GK1:SummaV*BANKURS(GK1:VAL,GK1:DATUMS,' Dokuments:'&G1:DOK_SENR)
  GK1:BAITS     = 0 ! IEZAKS
  GK1:OBJ_NR    = 0

  G1:SUMMA      = GK1:SUMMA

  ADD(GK1)
  IF ERROR()
     STOP(ERROR())
  ELSE
     KONT_SK+=1
  .
!-----------------------------------------------------------------------------
Thermometer ROUTINE
  RecordsProcessed += 1
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

