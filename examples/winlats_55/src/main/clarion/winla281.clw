                     MEMBER('winlats.clw')        ! This is a MEMBER module
W_Pav_EDI            PROCEDURE                    ! Declare Procedure
TEX:DUF         STRING(100)
XMLFILENAME     CSTRING(200),STATIC

OUTFILEXML   FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record          RECORD,PRE()
LINE               STRING(256)
                END
             END
TNAME_B    STRING(70),STATIC
TFILE_B      FILE,NAME(TNAME_B),PRE(B),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR           STRING(200)
                END
             END


LocalResponse         LONG
Auto::Attempts        LONG,AUTO
Auto::Save:PAV:U_NR   LIKE(PAV:U_NR)
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

ToScreen WINDOW('Norâdiet, kur rakstît'),AT(,,185,86),GRAY
       STRING('Rakstu ...'),AT(39,6,108,10),FONT(,9,,FONT:bold),USE(?StringRakstu),CENTER
       OPTION,AT(9,19,173,46),USE(merkis),BOXED
         RADIO('Tekoðâ direktorijâ'),AT(16,28,161,10),USE(?Merkis:Radio1)
         RADIO('E:\'),AT(16,39),USE(?Merkis:Radio2)
         RADIO('Privâtajâ folderî'),AT(16,50),USE(?Merkis:Radio3)
       END
       BUTTON('&Atlikt'),AT(109,67,36,14),USE(?CancelButton)
       BUTTON('&OK'),AT(147,67,35,14),USE(?OkButton),DEFAULT
     END

ReadScreen WINDOW('Rakstu apmaiòas failu'),AT(,,180,55),GRAY
       STRING(@s40),AT(24,20),USE(darbiba)
     END

  CODE                                            ! Begin processed code
 CHECKOPEN(NOLIK,1)
 NOLIK::USED+=1
 CHECKOPEN(NOM_K,1)
 NOM_K::USED+=1
 IF PAR_A::USED=0
    CHECKOPEN(PAR_A,1)
 .
 PAR_A::USED+=1
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
    .
 .
 IF IrPayer# =0
    DO PROCEDURERETURN
 end
 TNAME_B='C:\Winlats\WINLATSC.INI'
 CHECKOPEN(TFILE_B,1)
 CLOSE(TFILE_B)
 OPEN(TFILE_B)
 IF ERROR()
    KLUDA(0,'Kïûda atverot '&CLIP(TNAME_B)&' '&ERROR())
    DO PROCEDURERETURN
 END
 XMLFILENAME=''
 SET(TFILE_B)
 LOOP
    NEXT (TFILE_B)
    IF ERROR() THEN BREAK.
    IF B:STR[1:8] = 'edisoft=' then
       XMLFILENAME = CLIP(B:STR[9:200])&'\'&CLIP(PAV:DOK_SENR)&'.XML'
       BREAK
    END

 END

 IF XMLFILENAME=''
    XMLFILENAME=USERFOLDER&'\'&CLIP(PAV:DOK_SENR)&'.XML'
    STOP('Nav atrasts Edisofta katalogs, izmantojam datu bazes katalogu')
 END
 CHECKOPEN(OUTFILEXML,1)
 CLOSE(OUTFILEXML)
 OPEN(OUTFILEXML,18)
 IF ERROR()
    KLUDA(1,XMLFILENAME)
    DO PROCEDURERETURN
 ELSE
    EMPTY(OUTFILEXML)

    JUADRESE=GL:ADRESE
    FADRESE=CLIP(SYS:ADRESE)&' '&clip(sys:tel)
    GOV_REG=gl:reg_nr
    IF gl:VID_NR THEN GOV_REG=gl:VID_NR.
    IF ~GL:VID_NR THEN KLUDA(87,'Jûsu PVN maks. Nr').       !vienkârði kontrolei

    XML:LINE='<?xml version="1.0" encoding="Windows-1257" ?>'
    ADD(OUTFILEXML)
       XML:LINE=' Document-Invoice>'
       ADD(OUTFILEXML)
          XML:LINE=' Invoice-Header>'
          ADD(OUTFILEXML)
             XML:LINE=' InvoiceNumber>'&CLIP(PAV:DOK_SENR)&'</InvoiceNumber>'
             ADD(OUTFILEXML)
             XML:LINE=' InvoiceDate>'&FORMAT(PAV:DATUMS,@D10-)&'</InvoiceDate>' !2012-10-22
             ADD(OUTFILEXML)
             XML:LINE=' SalesDate>'&FORMAT(PAV:DATUMS,@D10-)&'</SalesDate>' !2012-10-22
             ADD(OUTFILEXML)
             IF PAV:VAL='Ls'
               XML:LINE=' InvoiceCurrency>LVL</InvoiceCurrency>'
             ELSE
               XML:LINE=' InvoiceCurrency>'&PAV:VAL&'</InvoiceCurrency>'
             .
             ADD(OUTFILEXML)
             IF pav:c_datums
                XML:LINE=' InvoicePaymentDueDate>'&FORMAT(pav:c_datums,@D10-)&'</InvoicePaymentDueDate>'  !2012-11-12
                ADD(OUTFILEXML)
             ELSE
                STOP('Nav noradits apmaksas datums')
             .
             XML:LINE=' DocumentFunctionCode>O</DocumentFunctionCode>'
             ADD(OUTFILEXML)
             XML:LINE=' Remarks>Preèu piegâde (pârdoðana)</Remarks>'
             ADD(OUTFILEXML)
             ComitPos = INSTRING(';',PAV:PAMAT)
             IF ~(ComitPos=0)
                XML:LINE=' Order>'
                ADD(OUTFILEXML)
                   XML:LINE=' BuyerOrderNumber>'&CLIP(PAV:PAMAT[1: ComitPos-1])&'</BuyerOrderNumber>'
                   ADD(OUTFILEXML)
                   OrderDateStr = LEFT(CLIP(PAV:PAMAT[ComitPos+1 : LEN(PAV:PAMAT)]))
                   OrderDate = DATE(OrderDateStr[4:5], OrderDateStr[1:2], OrderDateStr[7:10])
                   IF ~(OrderDate=0)
                      XML:LINE=' BuyerOrderDate>'&FORMAT(OrderDate,@D10-)&'</BuyerOrderDate>' !2012-10-22
                      ADD(OUTFILEXML)
                   .

                XML:LINE='</Order>'
                ADD(OUTFILEXML)
             .
          XML:LINE='</Invoice-Header>'
          ADD(OUTFILEXML)
          XML:LINE=' Invoice-Parties>'
          ADD(OUTFILEXML)

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

             XML:LINE=' Buyer>'
             ADD(OUTFILEXML)
                XML:LINE=' ILN>'&CLIP(PAR_ILN)&'</ILN>'  ! !RIMI ILN
                ADD(OUTFILEXML)
                XML:LINE=' TaxID>'&CLIP(PAR:PVN)&'</TaxID>'   !LV40003053029
                ADD(OUTFILEXML)
                XML:LINE=' CodeBySeller>'&CLIP(PAR_CODE)&'</CodeBySeller>'
                ADD(OUTFILEXML)
                TEX:DUF=PAR_NOS_P
                DO CONVERT_TEX:DUF_
                XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'    !RIMI LATVIA SIA
                ADD(OUTFILEXML)
                TEX:DUF=PAR_FADRESE
                DO CONVERT_TEX:DUF_
                XML:LINE=' StreetAndNumber>'&CLIP(TEX:DUF)&'</StreetAndNumber>'
                ADD(OUTFILEXML)
             XML:LINE='</Buyer>'
             ADD(OUTFILEXML)

             IF ~(PAV:PAR_ADR_NR=0)
               PIEG_ILN   = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,6)
               IF ~(GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5) = '')
                  PAR_PiegADRESE = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,5)
               end
             END


             IF (~PAV:MAK_NR=0) And ~(PAV:MAK_NR=PAV:PAR_NR)  !JÂPOZICIONÇ PAR_K
                CLEAR(PAR:RECORD)
                PAR_gov_reg = GETPAR_K(PAV:MAK_NR,0,21)
                PAR_JUADRESE= GETPAR_K(PAV:MAK_NR,0,24)
                PAR_FADRESE = GETPAR_ADRESE(PAV:MAK_NR,255,0,0)
                PAR_ILN   = GETPAR_ADRESE(PAV:MAK_NR,254,0,1)
                PAR_NOS_P   = GETPAR_K(PAV:MAK_NR,2,2)
                PAR_CODE    = CLIP(LEFT(FORMAT(PAV:MAK_NR,@N_5)))

             .

             XML:LINE=' Payer>'
             ADD(OUTFILEXML)
                XML:LINE=' ILN>'&CLIP(PAR_ILN)&'</ILN>'  ! !RIMI ILN
                ADD(OUTFILEXML)
                XML:LINE=' TaxID>'&CLIP(PAR:PVN)&'</TaxID>'   !LV40003053029
                ADD(OUTFILEXML)
                XML:LINE=' CodeBySeller>'&CLIP(PAR_CODE)&'</CodeBySeller>'
                ADD(OUTFILEXML)
                TEX:DUF=PAR_NOS_P
                DO CONVERT_TEX:DUF_
                XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'    !RIMI LATVIA SIA
                ADD(OUTFILEXML)
                TEX:DUF=PAR_FADRESE
                DO CONVERT_TEX:DUF_
                XML:LINE=' StreetAndNumber>'&CLIP(TEX:DUF)&'</StreetAndNumber>'
                ADD(OUTFILEXML)
             XML:LINE='</Payer>'
             ADD(OUTFILEXML)


             CLEAR(PAR:RECORD)
             PAR:U_NR=GL:CLIENT_U_NR
             GET(PAR_K,PAR:NR_KEY)
             IF ERROR()
                KLUDA(0,'Kïûda meklçjot rakstu PAR_K ar U_NR '&PAR:U_NR)
                DO PROCEDURERETURN
             .

             XML:LINE=' Seller>'
             ADD(OUTFILEXML)
                XML:LINE=' ILN>'&CLIP(GETPAR_ADRESE(PAR:U_NR,254,0,1))&'</ILN>'  ! !Mans ILN
                ADD(OUTFILEXML)
                XML:LINE=' TaxID>'&CLIP(GOV_REG)&'</TaxID>'   ! Mans PVN maks.kods LV40003326466
                ADD(OUTFILEXML)
                XML:LINE=' CodeBySeller>'&CLIP(LEFT(FORMAT(PAR:U_NR,@N_5)))&'</CodeBySeller>'
                ADD(OUTFILEXML)
                TEX:DUF=CLIENT
                DO CONVERT_TEX:DUF_
                XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'
                ADD(OUTFILEXML)
                TEX:DUF=GETPAR_ADRESE(PAR:U_NR,254,0,0)
                DO CONVERT_TEX:DUF_
                XML:LINE=' StreetAndNumber>'&CLIP(TEX:DUF)&'</StreetAndNumber>' !Râmuïu iela 1a
                ADD(OUTFILEXML)
             XML:LINE='</Seller>'
             ADD(OUTFILEXML)
          XML:LINE='</Invoice-Parties>'
          ADD(OUTFILEXML)

          XML:LINE=' Invoice-Lines>'
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
                XML:LINE=' Line>'
                ADD(OUTFILEXML)
                   XML:LINE=' Line-Item>'
                   ADD(OUTFILEXML)
                       XML:LINE=' LineNumber>'&CLIP(RPT_NPK#)&'</LineNumber>'
                       ADD(OUTFILEXML)
                       EAN=GETNOM_K(NOL:NOMENKLAT,2,4)
                       XML:LINE=' EAN>'&CLIP(EAN)&'</EAN>'
                       ADD(OUTFILEXML)
                       XML:LINE=' SupplierItemCode>'&CLIP(NOL:NOMENKLAT)&'</SupplierItemCode>'
                       ADD(OUTFILEXML)
                       TEX:DUF=NOM:NOS_P
                       DO CONVERT_TEX:DUF_
                       XML:LINE=' ItemDescription>'&CLIP(TEX:DUF)&'</ItemDescription>'
                       ADD(OUTFILEXML)
                       XML:LINE=' InvoiceQuantity>'&CLIP(LEFT(FORMAT(NOL:DAUDZUMS,@N_9.2)))&'</InvoiceQuantity>'
                       ADD(OUTFILEXML)

                       IF NOL:DAUDZUMS=0
                         cena = calcsum(3,5) ! cena pec atlaides un bez PVN
                       ELSE
                         cena = ROUND(calcsum(3,1)/nol:daudzums,.00001)   !REAL/
                       .
                       CENA_S     = CUT0(CENA,4,2)      !STRINGS UZ PPR
                       SUMMA_B = calcsum(3,4)
                       SUMMA_BS = CUT0(SUMMA_B,4,2)

                       XML:LINE=' InvoiceUnitNetPrice>'&CLIP(LEFT(cena_S))&'</InvoiceUnitNetPrice>'
                       ADD(OUTFILEXML)
                       XML:LINE=' UnitOfMeasure>'&CLIP(NOM:MERVIEN)&'</UnitOfMeasure>'
                       ADD(OUTFILEXML)
    !                       XML:LINE='<InvoicedUnitPackSize>1</InvoicedUnitPackSize>'
    !                       ADD(OUTFILEXML)
                       XML:LINE=' TaxRate>'&NOL:PVN_PROC&'</TaxRate>' !PVN%
                       ADD(OUTFILEXML)
                       XML:LINE=' TaxCategoryCode>S</TaxCategoryCode>' !STANDART
                       ADD(OUTFILEXML)
                       TAXAMOUNT=Round(summa_bS*(NOL:PVN_PROC/100),.01)
                       TotalTaxAmount+=TaxAmount
                       XML:LINE=' TaxAmount>'&CLIP(LEFT(FORMAT(TAXAMOUNT,@N_9.2)))&'</TaxAmount>' !PVN KNKRÇTAI POZÎCIJAI
                       ADD(OUTFILEXML)
                       XML:LINE=' NetAmount>'&CLIP(LEFT(FORMAT(SUMMA_BS)))&'</NetAmount>' !?
                       ADD(OUTFILEXML)
                       IF NOL:ATLAIDE_PR
                          XML:LINE=' Discount>'&NOL:ATLAIDE_PR&'</Discount>' !?
                          ADD(OUTFILEXML)
                       END
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
                   XML:LINE='</Line-Item>'
                   ADD(OUTFILEXML)
                   XML:LINE=' Line-Delivery>'
                   ADD(OUTFILEXML)
                      XML:LINE=' DeliveryLocationNumber>'&CLIP(PIEG_ILN)&'</DeliveryLocationNumber>' !4751008570618
                      ADD(OUTFILEXML)
                      TEX:DUF=PAR_PiegADRESE
                      DO CONVERT_TEX:DUF_
                      XML:LINE=' Name>'&CLIP(TEX:DUF)&'</Name>'  !RIMI LATVIA SIA
                      ADD(OUTFILEXML)
                      XML:LINE=' DeliveryDate>'&FORMAT(PAV:DATUMS,@D10-)&'</DeliveryDate>' !2012-10-22
                      ADD(OUTFILEXML)
                      XML:LINE=' DespatchNumber>'&CLIP(PAV:DOK_SENR)&'</DespatchNumber>'!SNA478884
                      ADD(OUTFILEXML)

                   XML:LINE='</Line-Delivery>'
                   ADD(OUTFILEXML)
                XML:LINE='</Line>'
                ADD(OUTFILEXML)
          END
          XML:LINE='</Invoice-Lines>'
          ADD(OUTFILEXML)
          XML:LINE=' Invoice-Summary>'
          ADD(OUTFILEXML)
             XML:LINE=' TotalLines>'&CLIP(RPT_NPK#)&'</TotalLines>'
             ADD(OUTFILEXML)
             XML:LINE=' TotalNetAmount>'&CLIP(LEFT(FORMAT(PAV:SUMMA_B,@N_9.2)))&'</TotalNetAmount>'
             ADD(OUTFILEXML)
             XML:LINE=' TotalTaxAmount>'&CLIP(LEFT(FORMAT(TotalTaxAmount,@N_9.2)))&'</TotalTaxAmount>'
             ADD(OUTFILEXML)
             XML:LINE=' TotalGrossAmount>'&CLIP(LEFT(FORMAT(PAV:SUMMA,@N_9.2)))&'</TotalGrossAmount>'
             ADD(OUTFILEXML)
             XML:LINE=' Tax-Summary>'
             ADD(OUTFILEXML)
                LOOP I# = 1 TO 10
                   IF PVN[I#] <> 0 OR SUMMA[I#] <> 0
                      XML:LINE=' Tax-Summary-Line>'
                      ADD(OUTFILEXML)
                       !5, 9, 10, 12, 18, 21, 22, 0 %, neapl
                      CASE I#
                      OF 1
                         XML:LINE=' TaxRate>5</TaxRate>'
                      OF 2
                         XML:LINE=' TaxRate>9</TaxRate>'
                      OF 3
                         XML:LINE=' TaxRate>10</TaxRate>'
                      OF 4
                         XML:LINE=' TaxRate>12/</TaxRate>'
                      OF 5
                         XML:LINE=' TaxRate>18</TaxRate>'
                      OF 6
                         XML:LINE=' TaxRate>21</TaxRate>'
                      OF 7
                         XML:LINE=' TaxRate>22</TaxRate>'
                      OF 8
                         XML:LINE=' TaxRate>0</TaxRate>'
                      OF 9 OROF 10
                         XML:LINE=' TaxRate></TaxRate>'
                      END
                      ADD(OUTFILEXML)
                      XML:LINE=' TaxCategoryCode>S</TaxCategoryCode>'
                      ADD(OUTFILEXML)
                      XML:LINE=' TaxAmount>'&CLIP(LEFT(FORMAT(PVN[I#],@N_9.2)))&'</TaxAmount>'
                      ADD(OUTFILEXML)
                      XML:LINE=' TaxableAmount>'&CLIP(LEFT(FORMAT(SUMMA[I#],@N_9.2)))&'</TaxableAmount>'
                      ADD(OUTFILEXML)
                      XML:LINE='</Tax-Summary-Line>'
                      ADD(OUTFILEXML)
                   END
                END
             XML:LINE='</Tax-Summary>'
             ADD(OUTFILEXML)
          XML:LINE='</Invoice-Summary>'
          ADD(OUTFILEXML)
      XML:LINE='</Document-Invoice>'
      ADD(OUTFILEXML)

       SET(OUTFILEXML)
       LOOP
          NEXT(OUTFILEXML)
          IF ERROR()
             KLUDA(0,'Pavadzîme nosutîta Edisoftâ (failâ '&XMLFILENAME&').',1,1)
             DO PROCEDURERETURN
          .
          IF ~XML:LINE[1]
             XML:LINE[1]='<'
             PUT(OUTFILEXML)
          .
       .
   .
 DO PROCEDURERETURN
!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
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

