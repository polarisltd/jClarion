                     MEMBER('winlats.clw')        ! This is a MEMBER module
R_TELEMA             PROCEDURE                    ! Declare Procedure
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordsProcessed     ULONG
RecordsToProcess     ULONG
PercentProgress      BYTE
RecordsPerCycle      BYTE
KODS_NOM             STRING(21)
SUMMA_A              DECIMAL(12,2)
zina                 STRING(40)
jauni                ULONG
mainiti              ULONG
kludaini             ULONG
FILTRS               STRING(14)
window WINDOW('Apmaiòas faila lasîðana...'),AT(,,190,60),CENTER,TIMER(1),GRAY,DOUBLE,MDI
       STRING(@s40),AT(3,4,178,10),USE(zina),CENTER
       STRING(@s59),AT(3,12,179,10),USE(XMLFILENAME),CENTER
       BUTTON('&OK'),AT(101,40,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(139,40,35,14),USE(?ButtonCancel)
     END

TXTAB       FILE,PRE(TX),DRIVER('ASCII'),NAME(FILENAME1),CREATE
RECORD             RECORD
LINE                 STRING(200)
                 . .

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

OPC            BYTE
DOSFILES    QUEUE,PRE(A)
NAME           STRING(FILE:MAXFILENAME)
SHORTNAME      STRING(13)
DATE           LONG
TIME           LONG
SIZE           LONG
ATTRIB         BYTE
            .

BAITS        BYTE
EAN_NR       DECIMAL(13)
NOM4         STRING(4)
NOM17        STRING(17)
VP_NOS       STRING(7)
KODS_S       STRING(13)
TXTFAILI     BYTE
VP_PAR_NR    ULONG
NOM_REALIZ   LIKE(NOM:REALIZ[1])
NOM_DG       LIKE(NOM:DG)
NOM_NOMENKLAT LIKE(NOM:NOMENKLAT)
IV2PZ        STRING(210)
IV2PZM       STRING(21),DIM(10),OVER(IV2PZ)
VELREIZ      BYTE
OTRAREIZE    BYTE
TEKOSA       BYTE
PAV_VAL      LIKE(PAV:VAL)
PAV_C_DATUMS LIKE(PAV:C_DATUMS)
DOK_SK       USHORT


XMLDIRNAME     CSTRING(200),STATIC

TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR                STRING(200)
                END
             END


myConfigQueue                           QUEUE,PRE()
InvoiceNumber                             STRING(20)
InvoiceDate                                 STRING(10)
SalesDate                                 STRING(10)
InvoiceCurrency                                      STRING(3)
InvoicePaymentDueDate                                  STRING(10)
DocumentFunctionCode                                    STRING(120)
Remarks                                    STRING(120)
                                        END
myHeaderQueue   QUEUE,PRE()
DateIssued         STRING(19)
SenderID           STRING(50)
                END
myDocInfoQueue   QUEUE,PRE()
DocumentNum         STRING(100)
                 END

myDateInfoQueue  QUEUE,PRE()
OrderDate             STRING(10)
DueDate               STRING(10)
DeliveryDateRequested STRING(10)
                 END

myBuyerQueue     QUEUE,PRE(BUY)
PartyCode      STRING(50)
Name           STRING(70)
GLN            STRING(14)
                 END

myDeliveryQueue  QUEUE,PRE(DEL)
PartyCode      STRING(50)
Name           STRING(70)
GLN            STRING(14)
                 END

mySumGroupQueue  QUEUE,PRE()
Currency       STRING(3)
DocumentSum    STRING(16) !.2
                 END
myItemQueue         QUEUE,PRE()
SellerItemCode   STRING(50)
GTIN             STRING(14)
ItemDescription  STRING(200)
BaseUnit         STRING(50)
AmountOrdered    STRING(16) !.5
ItemPrice        STRING(16) !.5
ItemSum          STRING(16) !.5
                    END

PAR_NR_          LIKE(PAV:PAR_NR)
PAR_ADR_NR       LIKE(PAV:PAR_ADR_NR)
PAR_ADR          LIKE(PAV:NOKA)
!- <DateInfo>
!  <OrderDate>2014-08-05</OrderDate> 
!  <DueDate /> 
!  <DeliveryDateRequested>2014-08-10</DeliveryDateRequested> 

recs                                    LONG
node                                    LONG
MusuCenas        BYTE    !05/03/2015


!NEWSCREEN WINDOW('Caption'),AT(,,226,78),GRAY
!       STRING(@s40),AT(42,10),USE(T:NOSAUKUMS)
!       ENTRY(@s4),AT(110,23),USE(nom4),REQ,UPR
!       ENTRY(@s17),AT(137,23),USE(nom17),UPR
!       STRING('Ievadiet grupu un apakðgrupu'),AT(10,24),USE(?String2)
!       ENTRY(@N2),AT(112,40),USE(NOM:PVN_PROC)
!       STRING('PVN %'),AT(85,42),USE(?String1)
!       BUTTON('OK'),AT(167,56,35,14),USE(?Ok),DEFAULT
!       STRING('Uzcenojuma % 5 cenai'),AT(36,57),USE(?String4)
!       ENTRY(@N3),AT(113,55),USE(NOM:PROC5)
!     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,141,57),CENTER,TIMER(1),GRAY,DOUBLE,MDI
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       STRING(@S21),AT(54,42),USE(KODS_NOM),CENTER
       BUTTON('Atlikt'),AT(1,42,50,15),USE(?Progress:Cancel),DISABLE,HIDE
     END

!----FOR AUTONUMBER ROUTINE------------------------------------------------------------------
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
Auto::Save:TEX:NR     LIKE(TEX:NR)
  CODE                                            ! Begin processed code
 TXTFAILI=1

 IF PAR_A::USED=0
    !STOP('PAR_A_OPEN'&PAR_A::USED)
    CHECKOPEN(PAR_A,1)
 END
 PAR_A::USED+=1


   TNAME_B='C:\Winlats\WINLATSC.INI'
   CHECKOPEN(TFILE_B,1)
   CLOSE(TFILE_B)
   OPEN(TFILE_B)
   IF ERROR()
      KLUDA(0,'Kïûda atverot '&CLIP(TNAME_B)&' '&ERROR())
      DO PROCEDURERETURN
   END

   XMLDIRNAME=''
   SET(TFILE_B)
   MusuCenas = 0  !05/03/2015
   LOOP
      NEXT (TFILE_B)
      IF ERROR() THEN BREAK.
      IF B:STR[1:7] = 'telema=' then
         XMLDIRNAME = CLIP(B:STR[8:200])&'\'
      !05/03/2015 <
      !   BREAK
      ELSIF B:STR[1:16] = 'telemaMusuCenas=' then
         MusuCenas = CLIP(B:STR[17:200])
      !05/03/2015 >
      END

   END

   IF XMLDIRNAME=''
       STOP('Nav atrasts TELEMA katalogs')
       DO PROCEDURERETURN
   END

   LOGNAME=XMLDIRNAME&'IMPORT\LOG.TXT'
   CHECKOPEN(LOGFILE,1)
   CLOSE(LOGFILE)
   OPEN(LOGFILE)
   IF ERROR()
      KLUDA(0,'Kïûda atverot '&CLIP(LOGNAME)&' '&ERROR())
      DO PROCEDURERETURN
   END
   CLEAR(L:RECORD)


    DIRECTORY(DOSFILES,XMLDIRNAME&'IMPORT\*.XML',FF_:NORMAL)
    IF RECORDS(DOSFILES)= 0
       L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
       L:STR = CLIP(L:STR)&' Nav atrodamas neviens XML fails folderî '&XMLDIRNAME&'IMPORT\'
       ADD(LOGFILE)
       KLUDA(120,'neviens XML fails folderî '&XMLDIRNAME&'IMPORT\')
       DO PROCEDURERETURN
    ELSE
       SORT(DOSFILES,-A:DATE)
       TXTFAILI=RECORDS(DOSFILES)
       XMLFILENAME='Atrasti '&clip(txtfaili)&' *.xml faili folderî \IMPORT'

       L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
       L:STR = CLIP(L:STR)&' Atrasti '&clip(txtfaili)&' *.xml faili folderî \IMPORT'
       ADD(LOGFILE)
    .

!    FILENAME1='C:\C55\IMPORT\K 000001.XML'
!    if ~Xml:LoadFromFile(FILENAME1)
!       STOP('!!!')
!       xml:FindNextNode('Document-Invoice','Invoice-Header')
!       recs = xml:loadQueue(MyConfigQueue,true,true)
!       stop(recs)
!       LOOP I#= 1 TO RECORDS(MyConfigQueue)
!       GET(MyConfigQueue,I#)
!
!       stop(InvoiceNumber)
!       stop(InvoiceDate)
!       .
!
!       XML:Free()
!    else
!       STOP('+++')
!       KLUDA(0,'Nevaru nolasît no faila: '&XMLFILENAME)
!       XML:Free() 
!    end


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
        !  ATRODAMIES TEKOÐÂ DIREKTORIJÂ
        !
        !  INET: TEKOÐÂ FOLDERA APAKÐFOLDERIS\INET FAILS IYYMMDDPPPPPPNNNN.TXT
        !        LAUKU ATDALÎTÂJS TAB VAI ','
        !        PÇC VEIKSMÎGAS NOLASÎÐANAS DZÇÐ
        !
!        HIDE(?OkButton)
!        HIDE(?ButtonCANCEL)
!        DISPLAY
        CHECKOPEN(NOM_K,1)
        CHECKOPEN(TEKSTI,1)
        BREAK
      .
   .
 .
 CLOSE(WINDOW)

 LOOP R#=1 TO TXTFAILI !TIKAI I-NET BÛS VAIRÂK KÂ 1.

    FREE(myHeaderQueue)
    FREE(myDocInfoQueue)
    FREE(myDateInfoQueue)
    FREE(myBuyerQueue)
    FREE(myDeliveryQueue)
    FREE(mySumGroupQueue)
    FREE(myItemQueue)

    PAR_NR_ = 0
    PAR_ADR_NR = 0
    PAR_ADR =''

    GET(DOSFILES,R#)
    XMLFILENAME=XMLDIRNAME&'IMPORT\'&A:NAME
!    STOP(XMLFILENAME&'ZZ')
    L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
    L:STR = CLIP(L:STR)&' Ielâde no faila '&clip(XMLFILENAME)
    ADD(LOGFILE)

    SUMMA_A=0
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
           if ~Xml:LoadFromFile(CLIP(XMLFILENAME))
!              STOP('XMLFILENAME'&CLIP(XMLFILENAME))
!             node = xml:FindNextNode('E-Document','Header')
!             recs = xml:loadQueue(MyHeaderQueue,true,true)
!             stop('recs'&recs)
!!             LOOP I#= 1 TO RECORDS(MyHeaderQueue)
!             GET(MyHeaderQueue,1)
!             stop('DateIssued'&DateIssued)
!!             stop(InvoiceNumber)
!!             .
!
             node = xml:FindNextNode('E-Document','Document','DocumentParties','BuyerParty')
             recs = xml:loadQueue(MyBuyerQueue,true,true)
             GET(MyBuyerQueue,1) !pirmajs ieraksts
!             STOP('BUY:GLN'&BUY:GLN)
!             STOP('BUY:PartyCode'&BUY:PartyCode)
             PAR_NR_=0
             PAR_ADR=''
             IF BUY:GLN
                CLEAR(ADR:RECORD)
                SET(PAR_A)
                LOOP
                    NEXT(PAR_A)
!                    STOP(ADR:DARBALAIKS)
                    IF ERROR() THEN BREAK.
                    IF ~(CLIP(ADR:DARBALAIKS)=CLIP(BUY:GLN))
                       CYCLE
                    ELSE
                       PAR_NR_=ADR:PAR_NR
                       PAR_ADR=ADR:ADRESE
                       BREAK
                    .
                END
             ELSE
                IF BUY:PartyCode
                   CLEAR(ADR:RECORD)
                   SET(PAR_A)
                   LOOP
                       NEXT(PAR_A)
                       IF ERROR() THEN BREAK.
                       IF ~(CLIP(ADR:DARBALAIKS)=CLIP(BUY:PartyCode))
                          CYCLE
                       ELSE
                          PAR_NR_=ADR:PAR_NR
                          PAR_ADR=ADR:ADRESE
                          BREAK
                       .
                   END
                END
             END
             IF ~PAR_NR_
!                STOP('1')
                L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                L:STR = CLIP(L:STR)&' Nav atrasts pircçjs ar ID/GLN: '&CLIP(BUY:PartyCode)&'/'&CLIP(BUY:GLN)&' ('&CLIP(BUY:Name)&')'
                ADD(LOGFILE)
                KLUDA(0,'Nav atrasts pircçjs ar ID/GLN: '&CLIP(BUY:PartyCode)&'/'&CLIP(BUY:GLN)&' ('&CLIP(BUY:Name)&')')
                CLOSE(OUTFILEXML)
                DO PROCEDURECYCLE
                CYCLE
             END

             xml:GotoTop()
             node = xml:FindNextNode('E-Document','Document','DocumentParties','DeliveryParty')
             recs = xml:loadQueue(MyDeliveryQueue,true,true)
             GET(MyDeliveryQueue,1) !pirmajs ieraksts
!             STOP('DEL:GLN'&DEL:GLN)
!             STOP('DEL:PartyCode'&DEL:PartyCode)
             PAR_ADR_NR=0
             CLEAR(ADR:RECORD)
             IF DEL:GLN
                SET(PAR_A)
                LOOP
                    NEXT(PAR_A)
                    IF ERROR() THEN BREAK.
                    IF ~(CLIP(ADR:DARBALAIKS)=CLIP(DEL:GLN))
                       CYCLE
                    ELSE
                       PAR_ADR_NR=ADR:ADR_NR
                       PAR_ADR=ADR:ADRESE
                       !13/11/2015 <
                       IF CL_NR=1471   !ANDO BALTIJA
                          PAR_NR_=ADR:PAR_NR
                       .
                       !13/11/2015 >
                       BREAK
                    .
                END
             ELSE
                IF DEL:PartyCode
                   GET(PAR_A,0)
                   LOOP
                       NEXT(PAR_A)
                       IF ERROR() THEN BREAK.
                       IF ~(CLIP(ADR:DARBALAIKS)=CLIP(DEL:PartyCode))
                          CYCLE
                       ELSE
                          PAR_ADR_NR=ADR:ADR_NR
                          PAR_ADR=ADR:ADRESE
                          !13/11/2015 <
                          IF CL_NR=1471  !ANDO BALTIJA
                             PAR_NR_=ADR:PAR_NR
                          .
                          !13/11/2015 >
                          BREAK
                       .
                   END
                END
             END
!             STOP('PAR_ADR_NR'&PAR_ADR_NR)
             IF ~PAR_ADR_NR
!                STOP('2')
                L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                L:STR = CLIP(L:STR)&' Nav atrasts piegâdes adrese ar ID/GLN: '&CLIP(DEL:PartyCode)&'/'&CLIP(DEL:GLN)&' ('&CLIP(BUY:Name)&'-'&CLIP(DEL:Name)&')'
                ADD(LOGFILE)
                KLUDA(0,'Nav atrasts piegâdes adrese ar ID/GLN: '&CLIP(DEL:PartyCode)&'/'&CLIP(DEL:GLN)&' ('&CLIP(BUY:Name)&'-'&CLIP(DEL:Name)&')')
                CLOSE(OUTFILEXML)
                DO PROCEDURECYCLE
                CYCLE
             END


             DO AUTONUMBER
             PAV_VAL=val_uzsk !01/01/2014


             xml:GotoTop()
             node = xml:FindNextNode('E-Document','Document','DocumentInfo')
             recs = xml:loadQueue(MyDocInfoQueue,true,true)
!             stop('node'&node)
!             stop('recs'&recs)
             GET(MyDocInfoQueue,1) !pirmajs ieraksts
             IF DocumentNum
                PAV:DOK_SENR = CLIP(DocumentNum)   !yyyy-mm-dd
!                stop('DocumentNum'&DocumentNum)
             END

!             xml:GotoTop()

             node = XML:GotoChild()    !'DateInfo'
!             node = xml:FindNextNode('E-Document','Document','DocumentInfo','DateInfo')
             recs = xml:loadQueue(MyDateInfoQueue,true,true)
             GET(MyDateInfoQueue,1) !pirmajs ieraksts


             PAV:D_K='P'
             PAV_VAL=val_uzsk !01/01/2014
             PAV:DOKDAT=DEFORMAT(OrderDate[1:10],@D10-)   !yyyy-mm-dd
             PAV:DATUMS=DEFORMAT(OrderDate[1:10],@D10-)   !yyyy-mm-dd
             PAV:PAR_NR = PAR_NR_
             PAV:PAR_ADR_NR = PAR_ADR_NR
!             stop('OrderDate'&OrderDate)
             PAV:PAMAT = CLIP(DocumentNum)&';'&OrderDate[9:10]&'-'&OrderDate[6:7]&'-'&OrderDate[1:4]&';'&'IMPORTS NO TELEMA'

!             STOP('PAV:PAMAT '&PAV:PAMAT)
             IF DueDate
                pav:c_datums = DEFORMAT(DueDate[1:10],@D10-)   !yyyy-mm-dd
!                stop('DueDate'&DueDate)
             END
             IF DeliveryDateRequested
                !13.02.2015 PAV:DATUMS = DEFORMAT(DeliveryDateRequested[1:10],@D10-)   !yyyy-mm-dd     ????????
                !13.02.2015 PAV:PAMAT = PAV:PAMAT&';'&'piegâde lîdz '&DeliveryDateRequested
                PAV:PIELIK = 'pieg. lîdz '&DeliveryDateRequested !13.02.2015
!                stop('DeliveryDateRequested'&DeliveryDateRequested)
             END

             CLEAR(PAR:RECORD)
             PAR:U_NR=PAV:PAR_NR
             GET(PAR_K,PAR:NR_KEY)

             PAV:NOKA=PAR:NOS_S
             IF INRANGE(PAV:PAR_NR,1,50)
                PAV:APM_V='5'  !APMAKSA NAV PAREDZÇTA
                PAV:C_DATUMS=0
             ELSIF PAR:NOKL_DC OR SYS:NOKL_DC
                PAV:APM_V='2' !PÇCAPMAKSA
                DO C_DATUMS
                PAV:C_DATUMS=PAV_C_DATUMS
             ELSE
                PAV:APM_V='1'  !PRIEKÐAPMAKSA
                PAV:C_DATUMS=PAV_C_DATUMS
             .
             !05/03/2015 NOKL_CP#=PAR:GRUPA[3]
             NOKL_CP#=PAR:NOKL_CP !05/03/2015 
             IF ~INRANGE(NOKL_CP#,1,5)
!                KLUDA(0,'Nepareizi/Nav norâdîta cenu grupa '&CLIP(VP_NOS))
                NOKL_CP#=1
             .

             xml:GotoTop()
             node = xml:FindNextNode('E-Document','Document','DocumentSumGroup')
             recs = xml:loadQueue(mySumGroupQueue,true,true)
             GET(mySumGroupQueue,1) !pirmajs ieraksts
             IF Currency
 !               stop('Currency'&Currency)
                PAV_VAL=Currency
             END

             xml:GotoTop()


!example - the same
!             node = xml:FindNextNode('E-Document','Document','DocumentItem','ItemEntry')
!             LOOP
!                recs = xml:loadQueue(MyItemQueue,true,false) ! viens ieraksts
!                ! do ...
!
!                FREE(MyItemQueue)
!                if not xml:GotoSibling() then break.
!             END

             node = xml:FindNextNode('E-Document','Document','DocumentItem','ItemEntry')
             recs = xml:loadQueue(MyItemQueue,true,true)  ! visi ieraksti
!             stop('Items'& RECORDS(MyItemQueue))
             LOOP I#= 1 TO RECORDS(MyItemQueue)

                GET(MyItemQueue,I#)
!*************************************** TAISAM NOM_K....

                CLEAR(NOM:RECORD)
                IF ~GTIN AND ~SellerItemCode
                   L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                   L:STR = CLIP(L:STR)&' Nav atrasts EAN-KODS: '&' '&' '&ItemDescription
                   ADD(LOGFILE)
                   KLUDA(17,'EAN-KODS: '&' '&' '&ItemDescription)
!               !!!!!!!!!!!!!!!!!!!!!
                END

                GET(NOM_K,0)
                IF GTIN
                   NOM:KODS=CLIP(GTIN)
                   GET(NOM_K,NOM:KOD_KEY)
                ELSIF SellerItemCode
                   NOM:NOMENKLAT=CLIP(SellerItemCode)
                   GET(NOM_K,NOM:NOM_KEY)
                END
!                IF OPC=3 OR OPC=6
!                   NOM:NOMENKLAT=KODS_NOM
!                   GET(NOM_K,NOM:NOM_KEY)
!                ELSIF OPC=4 OR OPC=5 OR OPC=7
!                   NOM:KATALOGA_NR=KODS_NOM
!                   GET(NOM_K,NOM:KAT_KEY)
!                ELSE
!                   NOM:KODS=KODS_NOM
!                   GET(NOM_K,NOM:KOD_KEY)
!                .
                IF ERROR() !JAUNA NOMENKLATÛRA(KODS)
                   L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                   L:STR = CLIP(L:STR)&' Nav atrasta nomenklâtura ar ID/GTIN '&CLIP(SellerItemCode)&'/'&CLIP(GTIN)&' ('&CLIP(ItemDescription)&'-'&CLIP(BaseUnit)&')'
                   ADD(LOGFILE)
                   KLUDA(0,'Nav atrasta nomenklâtura ar ID/GTIN '&CLIP(SellerItemCode)&'/'&CLIP(GTIN)&' ('&CLIP(ItemDescription)&'-'&CLIP(BaseUnit)&')')

!                   NOM:mervien  ='gab.'
!                   NOM:TIPS='P'
!                   NOM:PVN_PROC=SYS:NOKL_PVN
!                   NOM:STATUSS='0{25}'
!                   NOM17=T:SERIJA
!                   NOM:NOS_P=T:NOSAUKUMS
!                   NOM:DER_TERM=DEFORMAT(T:DER_TER,@D6.)
!                   NOM:ARPVNBYTE=31 !VISAS AR PVN
!                   NOM:PIC=ROUND(T:SUMMA/T:DAUDZUMS,.0001)
!                   NOM:PIC_DATUMS=TODAY()
!                   NOM:ARPVNBYTE=31     !PIRMÂS 5 AR PVN
!                      IF ~NOM:PVN_PROC THEN NOM:PVN_PROC=21.
!                      NOM:REALIZ[1]=ROUND(W:CENA/100*(1+NOM:PVN_PROC/100),.01) !AR PVN
!                      NOM:REALIZ[1]=ROUND(DEFORMAT(W:CENA,@N10.2)*(1+NOM:PVN_PROC/100)*BANKURS('EUR',TODAY()),.01) !AR PVN
!                      NOM:KATALOGA_NR=A:KATALOGA_NR
!                      NOM:PIC=A:CENA*BANKURS(PAV_VAL,PAV:DATUMS)
!                      NOM:REALIZ[5]=NOM:PIC*(1+SYS:NOKL_PVN/100)
!                      NOM:PIC_DATUMS=TODAY()
!                   NOM:ACC_KODS=ACC_KODS
!                   NOM:ACC_DATUMS=TODAY()
!                   ADD(NOM_K)
!                   IF ERROR()
!                      STOP('ADD NOM_K '&ERROR())
!                   .
                ELSE   !NOMENKLATÛRA(kods) IR ATRASTA
                .
!***************************** TAISAM NOLIK....
                CLEAR(NOL:RECORD)
                NOL:U_NR=PAV:U_NR
                NOL:DATUMS=PAV:DATUMS
                NOL:VAL=PAV_VAL
                KODNAV#=0
                KODNUL#=0
                NOMNAV#=0
                NOL:NOMENKLAT=NOM:NOMENKLAT
                NOL:DAUDZUMS=ROUND(CLIP(AmountOrdered),.001)
                !11/02/2015 <
                !Stop('PAR:Atlaide '&PAR:Atlaide)
                !Stop('NOL:NOMENKLAT'&NOL:NOMENKLAT)
                NOL:ATLAIDE_PR=GETPAR_ATLAIDE(PAR:Atlaide,NOL:NOMENKLAT)
                IF (BAND(NOM:NEATL,00000001b) AND NOL:ATLAIDE_PR>0) OR| !NEDRÎKST DOT ATLAIDI
                BAND(NOM:NEATL,00000010b)                               !AKCIJAS PRECE
                   NOL:ATLAIDE_PR=0
                .
                !Stop('NOL:ATLAIDE_PR '&NOL:ATLAIDE_PR)
                !11/02/2015 >
                !05/03/2015 <
                IF MusuCenas = 1
                   NOL:SUMMAV=0
                   NOL:SUMMAV=NOM:REALIZ[NOKL_CP#]*NOL:DAUDZUMS
                !IF ItemSum
                ElSIF ItemSum
                !05/03/2015 >
                   NOL:SUMMAV=ROUND(CLIP(ItemSum),.01)
                ELSIF ItemPrice
                   NOL:SUMMAV=ROUND(CLIP(ItemPrice)*CLIP(AmountOrdered),.01)
                ELSE
                   NOL:SUMMAV=0
                   NOL:SUMMAV=NOM:REALIZ[NOKL_CP#]*NOL:DAUDZUMS
                END
                NOL:SUMMA=NOL:SUMMAV
!                   NOL:ATLAIDE_PR=0
                NOL:ARBYTE=1 !AR PVN
                NOL:D_K='P'
                NOL:PAR_NR=PAV:PAR_NR
                NOL:PVN_PROC=NOM:PVN_PROC
                ADD(NOLIK)
                IF ERROR()
                   STOP('Rakstot nolik :'&ERROR())
                   L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                   L:STR = CLIP(L:STR)&' Rakstot nolik :'&ERROR()
                   ADD(LOGFILE)
                .
                FILLPVN(1)
          !     pav:summa+=nol:summav*(1-NOL:ATLAIDE_PR/100)
                summa_A+=CALCSUM(8,1) !ATLAIDE  !11/02/2015
                AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)
                KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)

             END

!***************************************DARAKSTAM P/Z...
             DISPLAY
             pav:summa=GETPVN(2)
             PAV:SUMMA_A=ROUND(summa_A,.01)  !11/02/2015

!             PAV:APM_V='2'
             PAV:APM_K='1'
             PAV:VAL=PAV_VAL
             PAV:ACC_KODS=ACC_KODS
             PAV:ACC_DATUMS=TODAY()
             IF DUPLICATE(PAV:SENR_KEY)
                L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                L:STR = CLIP(L:STR)&' Veidojas dubultas atslçgas ar dokumenta Nr '&CLIP(PAV:DOK_SENR)&' ...nullçju'
                ADD(LOGFILE)
                KLUDA(0,'Veidojas dubultas atslçgas ar dokumenta Nr '&CLIP(PAV:DOK_SENR)&' ...nullçju')
                PAV:DOK_SENR=''

             .
             FILLPVN(0)
             IF RIUPDATE:PAVAD()
                L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                L:STR = CLIP(L:STR)&' Nevaru ierakstît PAVAD'
                ADD(LOGFILE)
                KLUDA(24,'Nevaru ierakstît PAVAD')
                 CLOSE(OUTFILEXML)
                 DO PROCEDURECYCLE
                 CYCLE
             ELSE
                L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                L:STR = CLIP(L:STR)&' Ielâdets pasutîjums no faila: '&CLIP(XMLFILENAME)
                ADD(LOGFILE)
                PAV:KEKSIS=4
                KLUDA(0,'Ielâdets pasutîjums no faila: '&XMLFILENAME,1,1)
                DOK_SK +=1
             .
             CLOSE(OUTFILEXML)
             L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
             L:STR = CLIP(L:STR)&' Kopija saglabâta failâ '&XMLDIRNAME&'IMPORT\ARHIV\'&A:NAME
             ADD(LOGFILE)
             COPY(OUTFILEXML,XMLDIRNAME&'IMPORT\ARHIV\')
             REMOVE(OUTFILEXML)

             XML:Free()
           else
              L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
              L:STR = CLIP(L:STR)&' Nevaru nolasît no faila: '&CLIP(XMLFILENAME)
              ADD(LOGFILE)
              KLUDA(0,'Nevaru nolasît no faila: '&CLIP(XMLFILENAME))
              CLOSE(OUTFILEXML)
              DO PROCEDURECYCLE
              CYCLE
           end

!    if opc = 8
!              KLUDA(0,'Nor enought: '&XMLFILENAME)
!              CLOSE(OUTFILEXML)
              DO PROCEDURECYCLE
!              cycle ! !TXT FAILI LOOPS
!              DO PROCEDURERETURN

!    .
 . !TXT FAILI LOOPS
 FREE(DOSFILES)
 KLUDA(0,'Ielâdeti pasutîjumi - '&DOK_SK&' dok.',1,1)

 DO PROCEDURERETURN
        
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
    PAV:DOKDAT=TODAY()
    PAV:DATUMS=TODAY()
    PAV:U_NR = Auto::Save:PAV:U_NR
    PAV:ACC_KODS=ACC_kods
    PAV:ACC_DATUMS=today()
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

C_DATUMS  ROUTINE
 IF PAR:NOKL_DC_TIPS='1' !Bankas dienas
    SKAITITAJS#=0  !CIK BANKAS DIENÂM JÂSANÂK
    PAV_C_DATUMS=PAV:DATUMS
    LOOP
       IF SKAITITAJS#=PAR:NOKL_DC THEN BREAK.
       PAV_C_DATUMS+=1
       IF ~(PAV_C_DATUMS%7=0 OR PAV_C_DATUMS%7=6)
          SKAITITAJS#+=1
       .
    .
 ELSIF PAR:NOKL_DC_TIPS='2' !Nenorâdît apmaksas termiòu
    PAV_C_DATUMS=0
 ELSIF PAR:NOKL_DC
    PAV_C_DATUMS=PAV:DATUMS+PAR:NOKL_DC
 ELSE
    PAV_C_DATUMS=PAV:DATUMS+SYS:NOKL_DC
 .

!---------------------------------------------------------------------------------------------
PROCEDURECYCLE ROUTINE
  XML:Free()
  CLOSE(TFILE_B)

  CLOSE(TEKSTI)

!---------------------------------------------------------------------------------------------
PROCEDURERETURN ROUTINE
  XML:Free()
  PAR_A::USED-=1
  IF PAR_A::USED=0
     CLOSE(PAR_A)
     !STOP('PAR_A_CLOSE'&PAR_A::USED)
  .
  CLOSE(TFILE_B)

  CLOSE(TEKSTI)
  CLOSE(LOGFILE)
  RETURN
