                     MEMBER('winlats.clw')        ! This is a MEMBER module
W_Telema             PROCEDURE                    ! Declare Procedure
TEX:DUF         STRING(100)
XMLFILENAME     CSTRING(200),STATIC
XMLDIRNAME     CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END
TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR                STRING(200)
                END
             END

!************** LOG FAILS *******************************
LOGNAME    STRING(100),STATIC
LOGFILE      FILE,NAME(LOGNAME),PRE(L),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR                STRING(256)
                END
             END

LocalResponse         LONG
Auto::Attempts        LONG,AUTO
!Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
darbiba               STRING(40)
FAILS                 CSTRING(20)
OrderDateStr          STRING(40)
OrderDate             DATE
ComitPos              LONG

CENA                 DECIMAL(16,5)
SUMMA_B              DECIMAL(16,4)
SUMMA_BS             STRING(15)
CENA_S               STRING(15)
TAXAMOUNT            DECIMAL(16,5)
TotalTaxAmount       DECIMAL(16,5)
PVN                  DECIMAL(12,2),DIM(10)  !5, 9, 10, 12, 18, 21, 22, 0 %, neapl
SUMMA                DECIMAL(12,2),DIM(10)

GOV_REG              STRING(40)
JUADRESE             STRING(47)
FADRESE              STRING(52)
VARDS                STRING(30)
EAN                  STRING(13)

PAR_NOS_P            STRING(54) !45+8+1
PAR_gov_reg          STRING(40)
PAR_JUADRESE         STRING(60)
PAR_PiegADRESE       STRING(60)
PAR_FADRESE          STRING(60)
PAR_ILN              STRING(60)
PAR_CODE             STRING(5)
PIEG_ILN             STRING(60)
PAR_BANKA            STRING(31)
PAR_BAN_NR           STRING(21)
PAR_BAN_KODS         STRING(11)

DOK_SK                USHORT
KONT_SK               USHORT

SAK_DAT               LONG
BEI_DAT               LONG
SAV_POSITION          STRING(260)
X                     LIKE(PAV:KEKSIS)

ToScreen WINDOW('Apmaiòas TELEMAS faila sagatavoðana'),AT(,,190,100),GRAY
       STRING(@s70),AT(3,3,179,10),USE(XMLFILENAME),LEFT
       STRING('Ierakstîti dokumenti ...'),AT(37,13),USE(?StringRakstu),HIDE,FONT(,9,,FONT:bold)
       STRING(@N_5B),AT(113,13),USE(DOK_SK),LEFT
       STRING('Kopçju uz ...'),AT(62,22),USE(?STRINGDISKETE),HIDE,CENTER !       END
       SPIN(@D6),AT(33,44,56,12),USE(SAK_DAT)
       SPIN(@D6),AT(113,44,56,12),USE(BEI_DAT)
       STRING('rakstus ,kam X='),AT(12,62),USE(?String4)
       ENTRY(@N1b),AT(73,61,13,12),USE(X) !       BUTTON('Tikai izvçlçto dokumentu'),AT(58,113,87,14),USE(?ButtonIzveleto)
       STRING('lîdz'),AT(96,45),USE(?String3)
       STRING('no'),AT(22,45),USE(?String2)
       BUTTON('&Atlikt'),AT(19,78,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(147,78,35,14),USE(?OkButton),DEFAULT
     END




!ToScreen1 WINDOW('Norâdiet, kur rakstît'),AT(,,185,86),GRAY
!       STRING('Rakstu ...'),AT(39,6,108,10),FONT(,9,,FONT:bold),USE(?StringRakstu),CENTER
!       OPTION,AT(9,19,173,46),USE(merkis),BOXED
!         RADIO('Tekoðâ direktorijâ'),AT(16,28,161,10),USE(?Merkis:Radio1)
!         RADIO('E:\'),AT(16,39),USE(?Merkis:Radio2)
!         RADIO('Privâtajâ folderî'),AT(16,50),USE(?Merkis:Radio3)
!       END
!       BUTTON('&Atlikt'),AT(109,67,36,14),USE(?CancelButton)
!       BUTTON('&OK'),AT(147,67,35,14),USE(?OkButton),DEFAULT
!     END
!
ReadScreen WINDOW('Rakstu apmaiòas failu'),AT(,,180,55),GRAY
       STRING(@s40),AT(24,20),USE(darbiba)
     END

  CODE                                            ! Begin processed code
!   SAK_dat=GG:datums
!   BEI_dat=GG:datums
   SAK_dat=TODAY()
   BEI_dat=TODAY()
   X=3
   OPEN(TOSCREEN)
   DISPLAY
   ACCEPT
      CASE FIELD()
      OF ?OkButton
         CASE EVENT()
         OF EVENT:Accepted
            LocalResponse = RequestCompleted
            BREAK
         END
      OF ?CancelButton
         CASE EVENT()
         OF EVENT:Accepted
            LocalResponse = RequestCancelled
            BREAK
         END
      END
   .
   IF LocalResponse = RequestCancelled
      CLOSE(TOSCREEN)
      DO PROCEDURERETURN
   .
   HIDE(1,?OkButton)
   UNHIDE(?CancelButton)
   UNHIDE(?STRINGRAKSTU)
   UNHIDE(?DOK_SK)
   UNHIDE(?XMLFILENAME)
   DISPLAY

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
   LOOP
      NEXT (TFILE_B)
      IF ERROR() THEN BREAK.
      IF B:STR[1:7] = 'telema=' then
         XMLDIRNAME = CLIP(B:STR[8:200])&'\'
         BREAK
      END

   END

   IF XMLDIRNAME=''
       !13/02/2015 STOP('Nav atrasts TELEMA katalogs')
       KLUDA(0,'Nav atrasts TELEMA katalogs')
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

!   IF PAV::USED=0
      CHECKOPEN(PAVAD,1)
!   .
!   PAV::USED+=1
!
   IF NOLIK::USED=0
      CHECKOPEN(NOLIK,1)
   END
   NOLIK::USED+=1
   IF NOM_K::USED=0
      CHECKOPEN(NOM_K,1)
   END
   NOM_K::USED+=1
   IF PAR_A::USED=0
      CHECKOPEN(PAR_A,1)
   END
   PAR_A::USED+=1

   CLEAR(PAV:RECORD)
   PAV:DATUMS=BEI_DAT
   SET(PAV:DAT_KEY,PAV:DAT_KEY)
   LOOP
      NEXT(PAVAD)
      IF ERRORCODE()
         stop(ERROR())
         DO PROCEDURERETURN
      .
      IF PAV:DATUMS < SAK_DAT
         DO PROCEDURERETURN
      .
      IF X AND ~(PAV:KEKSIS=X) THEN CYCLE.
      IF ~(PAV:D_K='K') THEN CYCLE.

      XMLFILENAME=''
      XMLFILENAME = XMLDIRNAME&'EXPORT\'&CLIP(PAV:DOK_SENR)&'.XML'
      DOK_SK+=1
      DISPLAY
      CLEAR(ADR:RECORD)
      ADR:PAR_NR=PAV:PAR_NR
      SET(ADR:NR_KEY,ADR:NR_KEY)
      IrPayer# = 0
      LOOP
         NEXT(PAR_A)
         IF ERROR() OR ~(ADR:PAR_NR=PAV:PAR_NR) THEN BREAK.
         !02/07/2013 IF ADR:TIPS='P'
         IF INSTRING(ADR:TIPS,'1347')
            IrPayer# =1
            BREAK
         END
      END
      IF IrPayer# =0
         L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
         L:STR = CLIP(L:STR)&' Kïûda meklçjot ILN klientam ar U_NR '&PAV:PAR_NR
         ADD(LOGFILE)
         KLUDA(0,'Kïûda meklçjot ILN klientam ar U_NR '&PAV:PAR_NR)
         CYCLE
      END
      CHECKOPEN(OUTFILEXML,1)
      CLOSE(OUTFILEXML)
      OPEN(OUTFILEXML,18)
      IF ERROR()
         KLUDA(1,XMLFILENAME)
         !DO PROCEDURERETURN
         CYCLE
      ELSE
         EMPTY(OUTFILEXML)
         JUADRESE=GL:ADRESE
         FADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
         GOV_REG=gl:reg_nr
         IF gl:VID_NR THEN GOV_REG=gl:VID_NR.
         IF ~GL:VID_NR THEN KLUDA(87,'Jûsu PVN maks. Nr').       !vienkârði kontrolei

         XML:LINE='<?xml version="1.0" encoding="Windows-1257" ?>'
         ADD(OUTFILEXML)
            XML:LINE=' E-Document>'
            ADD(OUTFILEXML)
               XML:LINE=' Header>'
               ADD(OUTFILEXML)
                  XML:LINE=' DateIssued>'&FORMAT(PAV:DATUMS,@D10-)&'T00:00:00'&'</DateIssued>' !2012-10-22  2012-01-11T06:12:54
                  ADD(OUTFILEXML)
                  XML:LINE=' Charset>utf-8</Charset>'
                  ADD(OUTFILEXML)
                  PAR:U_NR=GL:CLIENT_U_NR
                  GET(PAR_K,PAR:NR_KEY)
                  IF ERROR()
                     L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                     L:STR = CLIP(L:STR)&' Kïûda meklçjot rakstu PAR_K ar U_NR '&PAR:U_NR
                     ADD(LOGFILE)
                     KLUDA(0,'Kïûda meklçjot rakstu PAR_K ar U_NR '&PAR:U_NR)
                     !DO PROCEDURERETURN
                     CLOSE(OUTFILEXML)   !13/02/2015
                     REMOVE(OUTFILEXML)  !13/02/2015
                     CYCLE
                  END
                  !24/02/2015 <
                  IF CLIP(GETPAR_ADRESE(PAR:U_NR,254,0,1)) = ''
                     L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                     L:STR = CLIP(L:STR)&' Nav noradits mûsu GLN'
                     ADD(LOGFILE)
                     KLUDA(0,'Nav noradits mûsu GLN')
                     CLOSE(OUTFILEXML)   
                     REMOVE(OUTFILEXML)  
                     CYCLE
                  .
                  !24/02/2015 >
                  XML:LINE=' SenderGLN>'&CLIP(GETPAR_ADRESE(PAR:U_NR,254,0,1))&'</SenderGLN>'  ! !Mans ILN
                  ADD(OUTFILEXML)
                  CLEAR(PAR:RECORD)
                  PAR_gov_reg = GETPAR_K(PAV:PAR_NR,0,21)
                  PAR_JUADRESE= GETPAR_K(PAV:PAR_NR,0,24)
                  PAR_FADRESE = GETPAR_ADRESE(PAV:PAR_NR,255,0,0)
                  PAR_PiegADRESE = PAR_FADRESE !ja partneram nav piegades adresa, vinam jabut pasta/klienta adrese ka piegades adrese
                  ! Ja PAR_PiegADRESE ari pirceja adrese
                  !PAR_FADRESE = PAR_PiegADRESE
     !                    PAR_FADRESE = GETPAR_ADRESE(PAV:PAR_NR,'B',0,0) !!!!!!!GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0) 'B' - Buyer
                  PAR_ILN     = GETPAR_ADRESE(PAV:PAR_NR,254,0,1)
                  PAR_NOS_P   = GETPAR_K(PAV:PAR_NR,2,2)
                  PAR_CODE    = CLIP(LEFT(FORMAT(PAV:PAR_NR,@N_5)))
                  IF ~(PAV:PAR_ADR_NR=0)
                    PIEG_ILN   = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,6)
                    IF ~(GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5) = '')
                       PAR_PiegADRESE = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5)
                    end
                  ELSE
                     PIEG_ILN   = PAR_ILN
                  END
!                  XML:LINE=' ReceiverID>'&CLIP(PAR_ILN)&'</ReceiverID>'  ! !RIMI ILN
                  XML:LINE=' ReceiverGLN>'&CLIP(PIEG_ILN)&'</ReceiverGLN>'  ! !RIMI filiâla ILN
                  ADD(OUTFILEXML)
               XML:LINE='</Header>'
               ADD(OUTFILEXML)
               XML:LINE=' Document>'
               ADD(OUTFILEXML)
                  XML:LINE=' DocumentType>invoice</DocumentType>'
                  ADD(OUTFILEXML)



               XML:LINE=' DocumentParties>'
               ADD(OUTFILEXML)

                  XML:LINE=' BuyerParty context="partner">'
                  ADD(OUTFILEXML)
                     XML:LINE=' PartyCode>'&CLIP(PAR_CODE)&'</PartyCode>'
                     ADD(OUTFILEXML)
                     TEX:DUF=PAR_NOS_P
                     DO CONVERT_TEX:DUF_
                     XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'    !RIMI LATVIA SIA
                     ADD(OUTFILEXML)
                     XML:LINE=' RegNum>'&CLIP(PAR:NMR_KODS)&'</RegNum>'   !40003053029
                     ADD(OUTFILEXML)
                     XML:LINE=' VATRegNum>'&CLIP(PAR:PVN)&'</VATRegNum>'   !LV40003053029
                     ADD(OUTFILEXML)
                     XML:LINE=' GLN>'&CLIP(PAR_ILN)&'</GLN>'  ! !RIMI ILN
                     ADD(OUTFILEXML)
                     XML:LINE=' ContactData>'
                     ADD(OUTFILEXML)
                        XML:LINE=' ActualAddress>'
                        ADD(OUTFILEXML)
                           TEX:DUF=PAR_FADRESE
                           DO CONVERT_TEX:DUF_
                           XML:LINE=' Address1>'&CLIP(TEX:DUF)&'</Address1>'
                           ADD(OUTFILEXML)
!                           XML:LINE=' County>'&CLIP(PAR:V_KODS)&'</County>' !LV
!                           ADD(OUTFILEXML)
                        XML:LINE='</ActualAddress>'
                        ADD(OUTFILEXML)
                     XML:LINE='</ContactData>'
                     ADD(OUTFILEXML)
                     XML:LINE=' AccountInfo>'
                     ADD(OUTFILEXML)
                        XML:LINE=' AccountNum>'&CLIP(par:ban_nr)&'</AccountNum>'
                        ADD(OUTFILEXML)
                        XML:LINE=' IBAN>'&CLIP(par:ban_nr)&'</IBAN>'
                        ADD(OUTFILEXML)
                        XML:LINE=' BIC>'&CLIP(par:ban_kods)&'</BIC>'
                        ADD(OUTFILEXML)
                        XML:LINE=' BankName>'&CLIP(Getbankas_k(par:ban_kods,2,1))&'</BankName>'
                        ADD(OUTFILEXML)
                     XML:LINE='</AccountInfo>'
                     ADD(OUTFILEXML)
                  XML:LINE='</BuyerParty>'
                  ADD(OUTFILEXML)

!                  IF ~(PAV:PAR_ADR_NR=0)
!                    PIEG_ILN   = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,6)
!                    IF ~(GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5) = '')
!                       PAR_PiegADRESE = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5)
!                    end
!                  ELSE
!                     PIEG_ILN   = PAR_ILN
!                  END
                  XML:LINE=' DeliveryParty context="partner">'
                  ADD(OUTFILEXML)
!                     XML:LINE=' PartyCode>'&CLIP(PIEG_ILN)&'</PartyCode>' !4751008570618
!                     ADD(OUTFILEXML)
                     TEX:DUF=PAR_PiegADRESE
                     DO CONVERT_TEX:DUF_
                     XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'  !RIMI LATVIA SIA
                     ADD(OUTFILEXML)
                     XML:LINE=' GLN>'&CLIP(PIEG_ILN)&'</GLN>' !4751008570618
                     ADD(OUTFILEXML)
                     XML:LINE=' ContactData>'
                     ADD(OUTFILEXML)
                        XML:LINE=' ActualAddress>'
                        ADD(OUTFILEXML)
                           XML:LINE=' Address1>'&CLIP(TEX:DUF)&'</Address1>'
                           ADD(OUTFILEXML)
                        XML:LINE='</ActualAddress>'
                        ADD(OUTFILEXML)
                     XML:LINE='</ContactData>'
                     ADD(OUTFILEXML)
                  XML:LINE='</DeliveryParty>'
                  ADD(OUTFILEXML)

!                  IF (~PAV:MAK_NR=0) And ~(PAV:MAK_NR=PAV:PAR_NR)  !JÂPOZICIONÇ PAR_K
!                     CLEAR(PAR:RECORD)
!                     PAR_gov_reg = GETPAR_K(PAV:MAK_NR,0,21)
!                     PAR_JUADRESE= GETPAR_K(PAV:MAK_NR,0,24)
!                     PAR_FADRESE = GETPAR_ADRESE(PAV:MAK_NR,255,0,0)
!                     PAR_ILN   = GETPAR_ADRESE(PAV:MAK_NR,254,0,1)
!                     PAR_NOS_P   = GETPAR_K(PAV:MAK_NR,2,2)
!                     PAR_CODE    = CLIP(LEFT(FORMAT(PAV:MAK_NR,@N_5)))
!
!                  .
!
!                  XML:LINE=' Payer>'
!                  ADD(OUTFILEXML)
!                     XML:LINE=' ILN>'&CLIP(PAR_ILN)&'</ILN>'  ! !RIMI ILN
!                     ADD(OUTFILEXML)
!                     XML:LINE=' TaxID>'&CLIP(PAR:PVN)&'</TaxID>'   !LV40003053029
!                     ADD(OUTFILEXML)
!                     XML:LINE=' CodeBySeller>'&CLIP(PAR_CODE)&'</CodeBySeller>'
!                     ADD(OUTFILEXML)
!                     TEX:DUF=PAR_NOS_P
!                     DO CONVERT_TEX:DUF_
!                     XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'    !RIMI LATVIA SIA
!                     ADD(OUTFILEXML)
!                     TEX:DUF=PAR_FADRESE
!                     DO CONVERT_TEX:DUF_
!                     XML:LINE=' StreetAndNumber>'&CLIP(TEX:DUF)&'</StreetAndNumber>'
!                     ADD(OUTFILEXML)
!                  XML:LINE='</Payer>'
!                  ADD(OUTFILEXML)


                  CLEAR(PAR:RECORD)
                  PAR:U_NR=GL:CLIENT_U_NR
                  GET(PAR_K,PAR:NR_KEY)
                  IF ERROR()
                     L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                     L:STR = CLIP(L:STR)&' Kïûda meklçjot rakstu PAR_K ar U_NR '&PAR:U_NR
                     ADD(LOGFILE)
                     KLUDA(0,'Kïûda meklçjot rakstu PAR_K ar U_NR '&PAR:U_NR)
                     !DO PROCEDURERETURN
                     CLOSE(OUTFILEXML)   !13/02/2015
                     REMOVE(OUTFILEXML)  !13/02/2015
                     CYCLE
                  END

                  XML:LINE=' SellerParty context="self">'
                  ADD(OUTFILEXML)
                     XML:LINE=' PartyCode>'&CLIP(PAR:U_NR)&'</PartyCode>'
                     ADD(OUTFILEXML)
                     TEX:DUF=CLIENT
                     DO CONVERT_TEX:DUF_
                     XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'
                     ADD(OUTFILEXML)
                     XML:LINE=' RegNum>'&CLIP(gl:reg_nr)&'</RegNum>'   ! Mans PVN maks.kods LV40003326466
                     ADD(OUTFILEXML)
                     XML:LINE=' VATRegNum>'&CLIP(gl:VID_NR)&'</VATRegNum>'   !LV40003053029
                     ADD(OUTFILEXML)
                     XML:LINE=' GLN>'&CLIP(GETPAR_ADRESE(PAR:U_NR,254,0,1))&'</GLN>'  ! !Mans ILN
                     ADD(OUTFILEXML)
                     TEX:DUF=GETPAR_ADRESE(PAR:U_NR,254,0,0)
                     DO CONVERT_TEX:DUF_
                     XML:LINE=' ContactData>'
                     ADD(OUTFILEXML)
                        XML:LINE=' ActualAddress>'
                        ADD(OUTFILEXML)
                           XML:LINE=' Address1>'&CLIP(TEX:DUF)&'</Address1>' !Râmuïu iela 1a
                           ADD(OUTFILEXML)
!                           XML:LINE=' County>'&CLIP(PAR:V_KODS)&'</County>' !LV
!                           ADD(OUTFILEXML)
                        XML:LINE='</ActualAddress>'
                        ADD(OUTFILEXML)
                     XML:LINE='</ContactData>'
                     ADD(OUTFILEXML)
                  XML:LINE='</SellerParty>'
                  ADD(OUTFILEXML)
               XML:LINE='</DocumentParties>'
               ADD(OUTFILEXML)

               XML:LINE=' DocumentInfo>'
               ADD(OUTFILEXML)
                  XML:LINE=' DocumentSubType>DEB</DocumentSubType>'
                  ADD(OUTFILEXML)
                  XML:LINE=' DocumentNum>'&CLIP(PAV:DOK_SENR)&'</DocumentNum>'
                  ADD(OUTFILEXML)
                  XML:LINE=' DateInfo>'
                  ADD(OUTFILEXML)
                     XML:LINE=' InvoiceDate>'&FORMAT(PAV:DATUMS,@D10-)&'</InvoiceDate>' !2012-10-22
                     ADD(OUTFILEXML)
                     IF pav:c_datums
                        XML:LINE=' DueDate>'&FORMAT(pav:c_datums,@D10-)&'</DueDate>'  !2012-11-12
                        ADD(OUTFILEXML)
                     ELSE
                        L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                        L:STR = CLIP(L:STR)&' Nav noradits apmaksas datums'
                        ADD(LOGFILE)
                        !13/02/2015 STOP('Nav noradits apmaksas datums')
                        KLUDA(0,'Nav noradits apmaksas datums')
                        CLOSE(OUTFILEXML)   !13/02/2015
                        REMOVE(OUTFILEXML)  !13/02/2015
                        CYCLE
                     END
                     XML:LINE=' DeliveryDateActual>'&FORMAT(PAV:DATUMS,@D10-)&'</DeliveryDateActual>' !2012-10-22
                     ADD(OUTFILEXML)
                  XML:LINE='</DateInfo>'
                  ADD(OUTFILEXML)
                  XML:LINE=' RefInfo>'
                  ADD(OUTFILEXML)
                     XML:LINE=' SourceDocument type="order">'
                     ADD(OUTFILEXML)
                     ComitPos = INSTRING(';',PAV:PAMAT)
                     IF ~(ComitPos=0)
                           XML:LINE=' SourceDocumentNum>'&CLIP(PAV:PAMAT[1: ComitPos-1])&'</SourceDocumentNum>'
                           ADD(OUTFILEXML)
   !                        OrderDateStr = LEFT(CLIP(PAV:PAMAT[ComitPos+1 : LEN(PAV:PAMAT)]))
   !                        OrderDate = DATE(OrderDateStr[4:5], OrderDateStr[1:2], OrderDateStr[7:10])
   !                        IF ~(OrderDate=0)
   !                           XML:LINE=' BuyerOrderDate>'&FORMAT(OrderDate,@D10-)&'</BuyerOrderDate>' !2012-10-22
   !                           ADD(OUTFILEXML)
   !                        END
                     ELSE
                        L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                        L:STR = CLIP(L:STR)&' Nav noradits pas.numurs'
                        ADD(LOGFILE)
                        !13/02/2015 STOP('Nav noradits pas.numurs')
                        KLUDA(0,'Nav noradits pas.numurs')
                        CLOSE(OUTFILEXML)   !13/02/2015
                        REMOVE(OUTFILEXML)  !13/02/2015
                        CYCLE
                     END
                     XML:LINE='</SourceDocument>'
                     ADD(OUTFILEXML)
                  XML:LINE='</RefInfo>'
                  ADD(OUTFILEXML)
               XML:LINE='</DocumentInfo>'
               ADD(OUTFILEXML)

!               XML:LINE=' Invoice-Header>'
!               ADD(OUTFILEXML)
!                  XML:LINE=' InvoiceNumber>'&CLIP(PAV:DOK_SENR)&'</InvoiceNumber>'
!                  ADD(OUTFILEXML)
!                  XML:LINE=' InvoiceDate>'&FORMAT(PAV:DATUMS,@D10-)&'</InvoiceDate>' !2012-10-22
!                  ADD(OUTFILEXML)
!                  XML:LINE=' SalesDate>'&FORMAT(PAV:DATUMS,@D10-)&'</SalesDate>' !2012-10-22
!                  ADD(OUTFILEXML)
!                  IF PAV:VAL='Ls'
!                    XML:LINE=' InvoiceCurrency>LVL</InvoiceCurrency>'
!                  ELSE
!                    XML:LINE=' InvoiceCurrency>'&PAV:VAL&'</InvoiceCurrency>'
!                  END
!                  ADD(OUTFILEXML)
!                  IF pav:c_datums
!                     XML:LINE=' InvoicePaymentDueDate>'&FORMAT(pav:c_datums,@D10-)&'</InvoicePaymentDueDate>'  !2012-11-12
!                     ADD(OUTFILEXML)
!                  ELSE
!                     STOP('Nav noradits apmaksas datums')
!                  END
!                  XML:LINE=' DocumentFunctionCode>O</DocumentFunctionCode>'
!                  ADD(OUTFILEXML)
!                  XML:LINE=' Remarks>Preèu piegâde (pârdoðana)</Remarks>'
!                  ADD(OUTFILEXML)
!                  ComitPos = INSTRING(';',PAV:PAMAT)
!                  IF ~(ComitPos=0)
!                     XML:LINE=' Order>'
!                     ADD(OUTFILEXML)
!                        XML:LINE=' BuyerOrderNumber>'&CLIP(PAV:PAMAT[1: ComitPos-1])&'</BuyerOrderNumber>'
!                        ADD(OUTFILEXML)
!                        OrderDateStr = LEFT(CLIP(PAV:PAMAT[ComitPos+1 : LEN(PAV:PAMAT)]))
!                        OrderDate = DATE(OrderDateStr[4:5], OrderDateStr[1:2], OrderDateStr[7:10])
!                        IF ~(OrderDate=0)
!                           XML:LINE=' BuyerOrderDate>'&FORMAT(OrderDate,@D10-)&'</BuyerOrderDate>' !2012-10-22
!                           ADD(OUTFILEXML)
!                        END
!
!                     XML:LINE='</Order>'
!                     ADD(OUTFILEXML)
!                  END
!               XML:LINE='</Invoice-Header>'
!               ADD(OUTFILEXML)

               XML:LINE=' DocumentItem>'
               ADD(OUTFILEXML)
               CLEAR(PVN)
               CLEAR(SUMMA)
               CLEAR(NOL:RECORD)
               NOL:U_NR=PAV:U_NR
               RPT_NPK# = 0
               SET(NOL:NR_KEY,NOL:NR_KEY)
               LOOP
                  NEXT(NOLIK)
                  RPT_NPK# +=1
                  IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
                     XML:LINE=' ItemEntry>'
                     ADD(OUTFILEXML)
!                        XML:LINE=' Line-Item>'
!                        ADD(OUTFILEXML)
                            XML:LINE=' LineItemNum>'&CLIP(RPT_NPK#)&'</LineItemNum>'
                            ADD(OUTFILEXML)
                            XML:LINE=' SellerItemCode>'&CLIP(NOL:NOMENKLAT)&'</SellerItemCode>'
                            ADD(OUTFILEXML)
                            EAN=GETNOM_K(NOL:NOMENKLAT,2,4)
                            XML:LINE=' GTIN>'&CLIP(EAN)&'</GTIN>'
                            ADD(OUTFILEXML)
                            TEX:DUF=NOM:NOS_P
                            DO CONVERT_TEX:DUF_
                            XML:LINE=' ItemDescription>'&CLIP(TEX:DUF)&'</ItemDescription>'
                            ADD(OUTFILEXML)
                            XML:LINE=' BaseUnit>'&CLIP(NOM:MERVIEN)&'</BaseUnit>'
                            ADD(OUTFILEXML)
                            XML:LINE=' AmountInvoiced>'&CLIP(LEFT(FORMAT(NOL:DAUDZUMS,@N_11.3)))&'</AmountInvoiced>'
                            ADD(OUTFILEXML)

                            IF NOL:DAUDZUMS=0
                              cena = calcsum(3,5) ! cena pec atlaides un bez PVN
                            ELSE
                              cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)   !REAL/
                            END
                            CENA_S     = CUT0(CENA,4,2)      !STRINGS UZ PPR
                            SUMMA_B = calcsum(3,4)
                            SUMMA_BS = CUT0(SUMMA_B,4,2)

                            XML:LINE=' ItemPrice>'&CLIP(LEFT(cena_S))&'</ItemPrice>'
                            ADD(OUTFILEXML)
         !                       XML:LINE='<InvoicedUnitPackSize>1</InvoicedUnitPackSize>'
         !                       ADD(OUTFILEXML)
                            XML:LINE=' ItemSum>'&CLIP(LEFT(FORMAT(SUMMA_BS)))&'</ItemSum>' !?
                            ADD(OUTFILEXML)
                            XML:LINE=' VAT vatID="TAX">' !PVN
                            ADD(OUTFILEXML)
                               XML:LINE=' SumBeforeVAT>'&CLIP(LEFT(FORMAT(SUMMA_BS)))&'</SumBeforeVAT>' !?
                               ADD(OUTFILEXML)
                               XML:LINE=' VATRate>'&NOL:PVN_PROC&'</VATRate>' !PVN%
                               ADD(OUTFILEXML)
                               TAXAMOUNT=Round(summa_bS*(NOL:PVN_PROC/100),.00001)
                               TotalTaxAmount+=TaxAmount
                               XML:LINE=' VATSum>'&CLIP(LEFT(FORMAT(TAXAMOUNT,@N_11.5)))&'</VATSum>' !PVN KNKRÇTAI POZÎCIJAI
                               ADD(OUTFILEXML)
                            XML:LINE='</VAT>' !PVN
                            ADD(OUTFILEXML)
!                            IF NOL:ATLAIDE_PR
!                               XML:LINE=' Discount>'&NOL:ATLAIDE_PR&'</Discount>' !?
!                               ADD(OUTFILEXML)
!                            END
                            XML:LINE=' ItemTotal>'&CLIP(LEFT(FORMAT(SUMMA_BS+TAXAMOUNT,@N_11.2)))&'</ItemTotal>' !SUMMA AR PVN KNKRÇTAI POZÎCIJAI
                            ADD(OUTFILEXML)
                            CASE NOL:PVN_PROC
                            !5, 9, 10, 12, 18, 21, 22, 0 %, neapl
                            OF 5
                               PVN[1] = PVN[1] + Round(TAXAMOUNT,.01)
                               SUMMA[1] = SUMMA[1] + Round(SUMMA_B,.01)
                             OF 9
                               PVN[2] = PVN[2] + Round(TAXAMOUNT,.01)
                               SUMMA[2] = SUMMA[2] + Round(SUMMA_B,.01)
                            OF 10
                               PVN[3] = PVN[3] + Round(TAXAMOUNT,.01)
                               SUMMA[3] = SUMMA[3] + Round(SUMMA_B,.01)
                           OF 12
                               PVN[4] = PVN[4] + Round(TAXAMOUNT,.01)
                               SUMMA[4] = SUMMA[4] + Round(SUMMA_B,.01)
                            OF 18
                               PVN[5] = PVN[5] + Round(TAXAMOUNT,.01)
                               SUMMA[5] = SUMMA[5] + Round(SUMMA_B,.01)
                            OF 21
                               PVN[6] = PVN[6] + Round(TAXAMOUNT,.01)
                               SUMMA[6] = SUMMA[6] + Round(SUMMA_B,.01)
                            OF 22
                               PVN[7] = PVN[7] + Round(TAXAMOUNT,.01)
                               SUMMA[7] = SUMMA[7] + Round(SUMMA_B,.01)
                            OF 0
                               PVN[8] = PVN[8] + Round(TAXAMOUNT,.01)
                               SUMMA[8] = SUMMA[8] + Round(SUMMA_B,.01)
                           END
                     XML:LINE='</ItemEntry>'
                     ADD(OUTFILEXML)
               END
               XML:LINE='</DocumentItem>'
               ADD(OUTFILEXML)
               XML:LINE=' DocumentSumGroup>'
               ADD(OUTFILEXML)
                  XML:LINE=' DocumentSum>'&CLIP(LEFT(FORMAT(PAV:SUMMA_B,@N_9.2)))&'</DocumentSum>'
                  ADD(OUTFILEXML)
                  LOOP I# = 1 TO 10
                     IF PVN[I#] <> 0 OR SUMMA[I#] <> 0
!                        XML:LINE=' VAT vatID="TAX'&I#&'">'
                        XML:LINE=' VAT vatID="TAX">'
                        ADD(OUTFILEXML)
                           XML:LINE=' SumBeforeVAT>'&CLIP(LEFT(FORMAT(SUMMA[I#],@N_9.2)))&'</SumBeforeVAT>'
                           ADD(OUTFILEXML)
                            !5, 9, 10, 12, 18, 21, 22, 0 %, neapl
                           CASE I#
                           OF 1
                              XML:LINE=' VATRate>5</VATRate>'
                           OF 2
                              XML:LINE=' VATRate>9</VATRate>'
                           OF 3
                              XML:LINE=' VATRate>10</VATRate>'
                           OF 4
                              XML:LINE=' VATRate>12/</VATRate>'
                           OF 5
                              XML:LINE=' VATRate>18</VATRate>'
                           OF 6
                              XML:LINE=' VATRate>21</VATRate>'
                           OF 7
                              XML:LINE=' VATRate>22</VATRate>'
                           OF 8
                              XML:LINE=' VATRate>0</VATRate>'
                           OF 9 OROF 10
                              XML:LINE=' VATRate></VATRate>'
                           END
                           ADD(OUTFILEXML)
                           XML:LINE=' VATSum>'&CLIP(LEFT(FORMAT(PVN[I#],@N_9.2)))&'</VATSum>'
                           ADD(OUTFILEXML)
                        XML:LINE='</VAT>'
                        ADD(OUTFILEXML)
                     END
                  END
                  XML:LINE=' TotalVATSum>'&CLIP(LEFT(FORMAT(TotalTaxAmount,@N_9.2)))&'</TotalVATSum>'
                  ADD(OUTFILEXML)
                  XML:LINE=' TotalSum>'&CLIP(LEFT(FORMAT(PAV:SUMMA,@N_9.2)))&'</TotalSum>'
                  ADD(OUTFILEXML)
                  IF PAV:VAL='Ls'
                    XML:LINE=' Currency>LVL</Currency>'
                  ELSE
                    XML:LINE=' Currency>'&PAV:VAL&'</Currency>'
                  END
                  ADD(OUTFILEXML)
               XML:LINE='</DocumentSumGroup>'
               ADD(OUTFILEXML)
               XML:LINE='</Document>'
               ADD(OUTFILEXML)
               XML:LINE=' Footer>'
               ADD(OUTFILEXML)
                  XML:LINE=' TotalNumDocuments>'&CLIP(LEFT(FORMAT(DOK_SK,@N_9.0)))&'</TotalNumDocuments>'
                  ADD(OUTFILEXML)
               XML:LINE='</Footer>'
               ADD(OUTFILEXML)
            XML:LINE='</E-Document>'
           ADD(OUTFILEXML)

           SET(OUTFILEXML)
           LOOP
              NEXT(OUTFILEXML)
              IF ERROR()
                 L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                 L:STR = CLIP(L:STR)&' Pavadzîme nosutîta Telemâ (failâ '&XMLFILENAME&').'
                 ADD(LOGFILE)
                 KLUDA(0,'Pavadzîme nosutîta Telemâ (failâ '&XMLFILENAME&').',1,1)
                 !DO PROCEDURERETURN
                 PAVAD:KEKSIS=4  !STATUSS::NOEXPORTÇTS
                 IF RIUPDATE:PAVAD()
                    L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
                    L:STR = CLIP(L:STR)&' Nav ierakstîts PAVAD'
                    ADD(LOGFILE)
                    KLUDA(24,'PAVAD')
                 .
                 BREAK
              .
              IF ~XML:LINE[1]
                 XML:LINE[1]='<'
                 PUT(OUTFILEXML)
              .

           .
           CLOSE(OUTFILEXML)
           L:STR = ACC_KODS&' '&FORMAT(TODAY(),@D06.)&' '&FORMAT(CLOCK(),@T1)&' '
           L:STR = CLIP(L:STR)&' Kopija saglabâta failâ '&XMLDIRNAME&'EXPORT\ARHIV\'&CLIP(PAV:DOK_SENR)&'.XML'
           ADD(LOGFILE)
           COPY(OUTFILEXML,XMLDIRNAME&'EXPORT\ARHIV\'&CLIP(PAV:DOK_SENR)&'.XML')
           

      .
   .
 CLOSE(TOSCREEN)

 DO PROCEDURERETURN
!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  !CLOSE(PAVAD)
  NOLIK::USED-=1
  IF NOLIK::USED=0
     CLOSE(NOLIK)
  .
  NOM_K::USED-=1
  IF NOM_K::USED=0
     CLOSE(NOM_K)
  .
  PAR_A::USED-=1
  IF PAR_A::USED=0
     CLOSE(PAR_A)
  .
  CLOSE(TFILE_B)
  CLOSE(OUTFILEXML)
  CLOSE(LOGFILE)
  RETURN

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF_  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]= CHR(39)
!        stop('aaa'&TEX:DUF[J#])
!        stop('sss'&TEX:DUF[J#+1:J#+3]&' '&VAL(TEX:DUF[J#+1:J#+1])&' '&VAL(TEX:DUF[J#+2:J#+2]))
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<'
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='{'
!        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
!     ELSIF TEX:DUF[J#]='}'
!        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='['
        TEX:DUF=TEX:DUF[1:J#-1]&'('&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=']'
        TEX:DUF=TEX:DUF[1:J#-1]&')'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=';'
        TEX:DUF=TEX:DUF[1:J#-1]&','&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='='
        TEX:DUF=TEX:DUF[1:J#-1]&'-'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='%'
        TEX:DUF=TEX:DUF[1:J#-1]&' proc.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='?'
        TEX:DUF=TEX:DUF[1:J#-1]&'.'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='#'
        TEX:DUF=TEX:DUF[1:J#-1]&'Nr'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='/'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='\'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=':'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='*'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='_'
        TEX:DUF=TEX:DUF[1:J#-1]&''&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .

