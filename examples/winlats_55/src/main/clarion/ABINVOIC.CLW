  MEMBER


  MAP
  END

  INCLUDE('ABINVOIC.INC'),ONCE
  INCLUDE('ABRESERV.INT'),ONCE


ChildQueue2 QUEUE,TYPE
M             &ModifierClass
InvokeAt      BYTE
            END

CDiscountQueue QUEUE,TYPE
ProductID       STRING(MaxProductID)
Cnt             LONG
DiscountGiven   DECIMAL(26,6)
               END

ProductQueue   QUEUE,TYPE
QuantityLow      LONG
QuantityHigh     LONG
PercentDiscount  DECIMAL(5,2)
DiscountedAmount DECIMAL(26,6)
               END

  ITEMIZE,PRE(Discount)
SIMPLE      EQUATE
STEPPED     EQUATE
UNITISATION EQUATE
          END


InvoiceGeneratorClass.InitCart PROCEDURE(ViewManager VMCL, *? CLCartId, *? CLLineID, *? CLProductID, <*? CLOptions>, *? CLUnitPrice, *? CLQuantity, <*? CLCustomerId>, <*? CLDte>, *? PName, <*? PDescription>)
  CODE
    SELF.VMCL &= VMCL
    SELF.CLCartID &= CLCartID
    IF NOT OMITTED(9)
      SELF.CLCustomerID &= CLCustomerId
    END
    IF NOT OMITTED(10)
      SELF.CLDte &= CLDte
    END
    SELF.CLLineID &= CLLineID
    SELF.CLProductID &= CLProductID
    IF NOT OMITTED(6)
      SELF.CLOptions &= CLOptions
    END
    SELF.CLUnitPrice &= CLUnitPrice
    SELF.CLQuantity &= CLQuantity
    SELF.PName &= PName
    IF NOT OMITTED(12)
      SELF.PDescription &= PDescription
    END


InvoiceGeneratorClass.InitReservation PROCEDURE(IReservation ResI, <*? PRStatus>, <*? PRAvail>, <ASTRING FailedText>, *? ILResNo)
  CODE
    SELF.ResI &= ResI
    IF NOT OMITTED(3)
      SELF.PRStatus &= PRStatus
    END
    IF NOT OMITTED(4)
      SELF.PRAvail &= PRAvail
    END
    IF NOT OMITTED(5)
      SELF.FailedText = FailedText
    END
    SELF.ILResNo &= ILResNo

InvoiceGeneratorClass.InitInvoice PROCEDURE(FileManager FMI, KEY ICartKey, *? IInvoiceId, *? ICartID, <*? ICustomerId>, *? ITotal, <*? IDte>, <*? IAccepted>)
  CODE
    SELF.NewLineQ &= NEW NewLineQueue
    SELF.NewBottomLineQ &= NEW NewLineQueue
    SELF.FMI &= FMI
    SELF.ICartKey &= ICartKey
    SELF.IInvoiceID &= IInvoiceID
    SELF.ICartID &= ICartID
    IF NOT OMITTED(6)
      SELF.ICustomerID &= ICustomerId
    END
    SELF.ITotal &= ITotal
    IF NOT OMITTED(8)
      SELF.IDte &= IDte
    END
    IF NOT OMITTED(9)
      SELF.IAccepted &= IAccepted
    END


InvoiceGeneratorClass.InitInvoiceLine PROCEDURE(FileManager FMIL, KEY ILKey, *? ILInvoiceId, *? ILLineID, *? ILProductID, <*? ILOptions>, *? ILUnitPrice, *? ILQuantity, <*? ILShippingCost>, *? ILDescription, *? ILProductCost, *? ILProductName)
  CODE
    SELF.FMIL &= FMIL
    SELF.ILKey &= ILKey
    SELF.ILInvoiceID &= ILInvoiceId
    SELF.ILLineID &= ILLineID
    SELF.ILProductID &= ILProductID
    IF NOT OMITTED(7)
      SELF.ILOptions &= ILOptions
    END
    SELF.ILUnitPrice &= ILUnitPrice
    SELF.ILQuantity &= ILQuantity
    IF NOT OMITTED(10)
      SELF.ILShippingCost &= ILShippingCost
    END
    SELF.ILDescription &= ILDescription
    SELF.ILProductCost &= ILProductCost
    SELF.ILProductName &= ILProductName

InvoiceGeneratorClass.Kill PROCEDURE
  CODE
    DISPOSE(SELF.NewLineQ)
    DISPOSE(SELF.NewBottomLineQ)


InvoiceGeneratorClass.RecordProcessor.TakeRecord PROCEDURE !take new record in cart file?
ret BYTE
I USHORT,AUTO
ResNo LONG
  CODE
?   ASSERT(~SELF.VMCL &= NULL, 'ViewManager is NULL!')
    Clear(SELF.NetLine)
    IF SELF.CurCartID <> SELF.CLCartID
      SELF._CloseInvoice()
      CLEAR(SELF.CurILLineID)
      SELF._CheckOldInvoices()
      ret = SELF.FMI.PrimeRecord()
      SELF.CurCartID = SELF.CLCartID
      SELF.ICartId = SELF.CLCartID         !copy cart record to invoice record
      SELF.ICustomerId = SELF.CLCustomerID
      SELF.IDte = SELF.CLDte
      ret = SELF.FMI.Insert()
      IF ret <> Level:Benign THEN RETURN ret END
    END
    ret = SELF._CheckReserved(ResNo)
    SELF.FMIL.PrimeRecord()
    SELF.ILInvoiceId = SELF.IInvoiceID
    SELF.CurILLineID += 1
    SELF.ILLineID = SELF.CurILLineID
    SELF.ILProductID = SELF.CLProductID
    SELF.ILProductName = SELF.PName
    SELF.ILDescription = SELF.PDescription
    SELF.ILOptions = SELF.CLOptions
    SELF.ILUnitPrice = SELF.CLUnitPrice
    SELF.ILQuantity = CHOOSE(ret=Level:Benign,SELF.CLQuantity,0)
    SELF.ILProductCost = CHOOSE(ret=Level:Benign,SELF.ILUnitPrice * SELF.ILQuantity,0)
    IF ret=Level:Benign !except unsuccessful reservation
      SELF.ILResNo = ResNo
      LOOP I=1 TO RECORDS(SELF.Children)
        GET(SELF.Children,I)
        ret = SELF.Children.M.TakeRecord()
        IF ret <> Level:Benign THEN RETURN ret END
      END
    ELSE
      SELF.ILDescription = CLIP(SELF.ILDescription)&' '&SELF.FailedText
    END
    ret = SELF.FMIL.Insert()
    IF ret <> Level:Benign THEN RETURN ret END
    ret = SELF._AddNewLines(SELF.NewLineQ)
    RETURN ret


InvoiceGeneratorClass._CheckReserved PROCEDURE(*LONG ResNo)
ret BYTE(Level:Benign)
  CODE
    IF ~SELF.ResI&=NULL AND ~SELF.PRStatus&=NULL AND SELF.PRStatus>0
?     ASSERT(~SELF.CLCustomerID&= NULL, 'Customer ID field is required for reservation system!')
?     ASSERT(~SELF.ILResNo&=NULL, 'Invoice Line Reservation field is required for reservation system!')
      RETURN SELF.ResI.Reserve(SELF.CLCustomerID,SELF.CLProductID,SELF.CLQuantity,ResNo,FALSE)
    END
    RETURN ret


InvoiceGeneratorClass._CheckOldInvoices PROCEDURE
  CODE
    SELF.ICartID = SELF.CLCartID
    SELF.FMI.ClearKey(SELF.ICartKey,2)
    SET(SELF.ICartKey, SELF.ICartKey)
    LOOP UNTIL SELF.FMI.TryNext() <> Level:Benign OR SELF.ICartID <> SELF.CLCartID
      !delete invoices that have not yet been accepted
      IF SELF.IAccepted&=NULL OR ~SELF.IAccepted
        SELF.ILInvoiceID = SELF.IInvoiceID
        SELF.FMIL.ClearKey(SELF.ILKey,2)
        SET(SELF.ILKey, SELF.ILKey)
        LOOP UNTIL SELF.FMIL.TryNext() <> Level:Benign OR SELF.ILInvoiceID <> SELF.IInvoiceID
          IF ~SELF.ResI&=NULL AND ~SELF.ILResNo&=NULL AND SELF.ILResNo<>''
            ASSERT(SELF.ResI.ProductReturn(SELF.ICustomerID,SELF.ILProductID,SELF.ILQuantity,SELF.ILResNo)=Level:Benign)
          END
          DELETE(SELF.FMIL.File)
?         ASSERT(~ERRORCODE(), 'File error deleting invoice line record!')
        END
        DELETE(SELF.FMI.File)
?       ASSERT(~ERRORCODE(), 'File error deleting invoice record!')
      END
    END


InvoiceGeneratorClass._AddNewLines PROCEDURE(NewLineQueue Q)
ret BYTE
  CODE
    LOOP
      GET(Q,1)
      IF ERRORCODE() THEN BREAK END
      DELETE(Q)
      ret = SELF.FMIL.PrimeRecord()
?     ASSERT(ret = Level:Benign,'PrimeRecord problems with Invoice Line File')
      IF ret <> Level:Benign THEN RETURN ret END
      SELF.CurILLineID += 1
      SELF.ILLineID = SELF.CurILLineID
      SELF.ILInvoiceID = SELF.IInvoiceID
      SELF.ILDescription = Q.Description
      IF ~SELF.ILShippingCost &= NULL
        SELF.ILSHippingCost = Q.Shipping
        SELF.ILProductCost = Q.Total
      ELSE
        SELF.ILProductCost = Q.Total + Q.Shipping
      END
      ret = SELF.FMIL.Insert()
      IF ret <> Level:Benign THEN RETURN ret END
    END
    RETURN ret


InvoiceGeneratorClass._CloseInvoice PROCEDURE
I USHORT,AUTO
  CODE
    IF SELF.CurCartID
?     ASSERT(~SELF.NewBottomLineQ&=NULL,'Queue not created')
      IF ~SELF.Children &= NULL
        LOOP I=1 TO RECORDS(SELF.Children)
          GET(SELF.Children,I)
          SELF.Children.M.CloseInvoice()
        END
      END
?     ASSERT(SELF._AddNewLines(SELF.NewBottomLineQ)=Level:Benign, 'Problems when trying to add line to Invoice Line File')
      SELF.ITotal = SELF.RunningTotal
      SELF.FMI.Update()
      CLEAR(SELF.RunningTotal)
      CLEAR(SELF.RunningShipping)
    END


InvoiceGeneratorClass.AddItem PROCEDURE(ModifierClass M, BYTE InvokeAt)
  CODE
    IF SELF.Children &= NULL
      SELF.Children &= NEW ChildQueue2
    END
    SELF.Children.M &= M
    SELF.Children.InvokeAt = InvokeAt
    ADD(SELF.Children, SELF.Children.InvokeAt)
    M.AddItem('InvoiceLineProductID',SELF.ILProductID)
    M.AddItem('InvoiceLineUnitPrice',SELF.ILUnitPrice)
    M.AddItem('InvoiceLineQuantity',SELF.ILQuantity)
    M.AddItem('InvoiceLineProductCost',SELF.ILProductCost)
    IF NOT SELF.ILShippingCost &= NULL
      M.AddItem('InvoiceLineShippingCost',SELF.ILShippingCost)
    END
    M._AddItem('NewLineQueue',SELF.NewLineQ)
    M._AddItem('NewBottomLineQueue',SELF.NewBottomLineQ)
    M._AddItem('RunningTotal',,SELF.RunningTotal)
    M._AddItem('NetLine',,SELF.NetLine)
    M._AddItem('RunningShipping',,SELF.RunningShipping)
    M._AddItem('StopDiscount',,,SELF.StopDiscount)
    RETURN RECORDS(SELF.Children)


InvoiceGeneratorClass.RecordProcessor.TakeClose PROCEDURE
  CODE
    SELF._CloseInvoice()
    IF ~SELF.Children &= NULL
      DISPOSE(SELF.Children)
    END
    RETURN Level:Benign


ModifierClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


ModifierClass.TakeRecord PROCEDURE
  CODE
    IF ~SELF.NetLine
      SELF.NetLine = SELF.ILProductCost
      SELF.RunningTotal += SELF.ILProductCost
    END
    RETURN Level:Benign


ModifierClass.RecordProcessor.TakeClose PROCEDURE
  CODE
  RETURN Level:Benign


ModifierClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'InvoiceLineProductID','InvoiceLineUnitPrice','InvoiceLineQuantity','InvoiceLineProductCost','InvoiceDate','InvoiceLineOptions','InvoiceLineShippingCost','Description')
      SELF.ILProductID &= Item
      SELF.ILUnitPrice &= Item
      SELF.ILQuantity &= Item
      SELF.ILProductCost &= Item
      SELF.IDte &= Item
      SELF.ILOptions &= Item
      SELF.ILShippingCost &= Item
      SELF.Text = Value
    ELSE
      message('Cannot find '&WhatItem)
    END

ModifierClass._AddItem PROCEDURE(ASTRING WhatItem, <NewLineQueue Q>, <*DECIMAL DecimalItem>, <*? Item>)
  CODE
    EXECUTE InList(WhatItem,'NewLineQueue','NewBottomLineQueue','RunningTotal', |
                  'RunningShipping','NetLine','StopDiscount')
      SELF.NewLineQ &= Q
      SELF.NewBottomLineQ &= Q
      SELF.RunningTotal &= DecimalItem
      SELF.RunningShipping &= DecimalItem
      SELF.NetLine &= DecimalItem
      SELF.StopDiscount &= Item
    ELSE
      message('Cannot find '&WhatItem)
    END


ModifierClass.AddNewIL PROCEDURE(ASTRING Description, <ASTRING TotalAmount>, <ASTRING Shipping>, BYTE BottomLine)
Q &NewLineQueue
  CODE
    IF BottomLine
      Q &= SELF.NewBottomLineQ
    ELSE
      Q &= SELF.NewLineQ
    END
    CLEAR(Q)
    Q.Description = Description
    IF NOT OMITTED(3)
      Q.Total = TotalAmount
    END
    IF NOT OMITTED(4)
      Q.Shipping = Shipping
    END
    ADD(Q)


ModifierClass.CloseInvoice PROCEDURE
  CODE


ModifierClass._Substitute PROCEDURE(ASTRING Text, ASTRING PlaceHolder, ASTRING Value)
pos1 USHORT
  CODE
    pos1 = INSTRING(UPPER(PlaceHolder),UPPER(Text),1,1)
    RETURN CHOOSE(Pos1>0,CHOOSE(pos1=1,'',Text[1 : Pos1-1]) & Value & CHOOSE(pos1-1+LEN(PlaceHolder)=LEN(Text),'',Text[pos1+LEN(PlaceHolder):LEN(Text)]),Text)


SalesTaxClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


SalesTaxClass.TakeRecord PROCEDURE
TaxAmount DECIMAL(26,6),AUTO
TaxRate   DECIMAL(26,6),AUTO
  CODE
    PARENT.TakeRecord()
    IF SELF.CLTaxable &= NULL OR ~SELF.CLTaxable &= NULL AND SELF.CLTaxable
      TaxRate = CHOOSE(SELF.TaxRate<>0 OR SELF.FMTC &= NULL,SELF.TaxRate,CHOOSE(SELF._FetchTaxRate()<>Level:Benign,0,SELF.TCTaxRate))
      TaxAmount = SELF.NetLine * TaxRate * .01
      IF TaxAmount>0
        SELF.NetLine += TaxAmount
        IF ~SELF.ILTaxAmount &= NULL
          SELF.ILTaxAmount = TaxAmount
        ELSE
          SELF.ILProductCost += TaxAmount
        END
        SELF.RunningTotal += TaxAmount
      END
    END
    RETURN Level:Benign


SalesTaxClass.RecordProcessor.TakeClose PROCEDURE
  CODE
  RETURN Level:Benign


SalesTaxClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'TaxRate','TaxableField','TaxAmountField','TaxCodeFileManager','TaxCodeFileKey','TaxCodeField','TaxRateField','TaxCodeExpression','SpecialTaxCode','ProductTaxCodeField')
      SELF.TaxRate = Value
      SELF.CLTaxable &= Item
      SELF.ILTaxAmount &= Item
      SELF.FMTC &= FM
      SELF.TCKey &= FileKey
      SELF.TCTaxCode &= Item
      SELF.TCTaxRate &= Item
      SELF.TaxCodeExpr = Value
      SELF.SpecialTaxCode = Value
      SELF.PTaxCode &= Item
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END


SalesTaxClass._FetchTaxRate PROCEDURE
  CODE
    IF ~SELF.ILProductID &= NULL AND ~SELF.FMTC &= NULL AND ~SELF.TCKey &= NULL AND ~SELF.TCTaxCode &= NULL AND ~SELF.TCTaxRate&= NULL
      SELF.FMTC.ClearKey(SELF.TCKey)
      IF SELF.PTaxCode=SELF.SpecialTaxCode
        SELF.TCTaxCode = EVALUATE(SELF.TaxCodeExpr)
      ELSE
        SELF.TCTaxCode = SELF.PTaxCode
      END
      RETURN SELF.FMTC.TryFetch(SELF.TCKey)
    ELSE
?     ASSERT(0,'TaxFile Details not provided!')
      RETURN Level:Benign
    END


QuantityDiscountClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


QuantityDiscountClass.TakeRecord PROCEDURE
Discount DECIMAL(26,6)
MyText   CSTRING(1024),AUTO
  CODE
    PARENT.TakeRecord()
    IF ~SELF.StopDiscount
      IF SELF._FillProdDiscountQ() <> Level:Benign
        RETURN Level:Benign !no discounts for this product found
      END
      IF SELF.Q &= NULL
        SELF.Q &= NEW CDiscountQueue
      END
      SELF.Q.ProductID = SELF.ILProductID
      GET(SELF.Q,SELF.Q.ProductID)
      IF NOT ERRORCODE()
        SELF.Q.Cnt += SELF.ILQuantity
        SELF._GetDiscount(SELF.Q.Cnt,Discount)
        SELF.Q.DiscountGiven = CHOOSE(Discount>SELF.Q.DiscountGiven,Discount-SELF.Q.DiscountGiven,0) !0 is quite unlikely
        PUT(SELF.Q)
      ELSE
        CLEAR(SELF.Q.DiscountGiven)
        SELF.Q.Cnt = SELF.ILQuantity
        SELF._GetDiscount(SELF.Q.Cnt,SELF.Q.DiscountGiven)
        ADD(SELF.Q,SELF.Q.ProductID)
      END
      IF SELF.NewInvoiceLine
        MyText = SELF._Substitute(SELF.Text, '#DiscountType#', CHOOSE(SELF.CurType,'Simple Discount','Stepped Discount','Unitisation','Other Discount'))
        MyText = SELF._Substitute(MyText, '#Discount#', SELF.DiscountText)
        MyText = SELF._Substitute(MyText, '#SpentOver#', '')
        SELF.AddNewIL(MyText,SELF.Q.DiscountGiven*-1)
      ELSE
        SELF.ILProductCost -= SELF.Q.DiscountGiven
      END
      SELF.NetLine -= SELF.Q.DiscountGiven
      SELF.RunningTotal -= SELF.Q.DiscountGiven
    END
    RETURN Level:Benign


QuantityDiscountClass._GetDiscount PROCEDURE(LONG Quantity, *DECIMAL Discount)
Cnt LONG
Pack LONG(1)
I USHORT,AUTO
N USHORT,AUTO
  CODE
    CLEAR(SELF.DiscountText)
    N = RECORDS(SELF.PQ)
    LOOP I=N TO 1 BY -1
      GET(SELF.PQ,I)
      IF I=N AND SELF.CurType<>Discount:Unitisation AND SELF.PQ.QuantityHigh AND Quantity>SELF.PQ.QuantityHigh
        Quantity = SELF.PQ.QuantityHigh !no discounts for quantities higher than maximum specified
      END
      IF SELF.CurType = Discount:Unitisation
        Pack = CHOOSE(~SELF.PQ.QuantityHigh,SELF.PQ.QuantityLow, SELF.PQ.QuantityHigh)
        Cnt = Quantity / Pack
        IF ~Cnt THEN CYCLE END
        Quantity = Quantity % Pack
        DO Calculate
      ELSIF (~SELF.PQ.QuantityHigh OR SELF.PQ.QuantityHigh>=Quantity) AND SELF.PQ.QuantityLow<=Quantity
        IF SELF.CurType = Discount:Stepped
          Cnt = Quantity-SELF.PQ.QuantityLow+1
          Quantity = Quantity-Cnt
        ELSE
          Cnt = Quantity
          Quantity = 0
        END
        DO Calculate
      END
      IF ~Quantity THEN BREAK END
    END

Calculate ROUTINE
  IF SELF.PQ.PercentDiscount
    Discount += Cnt*Pack*SELF.ILUnitPrice*SELF.PQ.PercentDiscount*.01
    IF SELF.NewInvoiceLine THEN SELF.DiscountText=CHOOSE(~SELF.DiscountText,'',SELF.DiscountText&', ')&Cnt&CHOOSE(SELF.CurType<>Discount:Unitisation,'','x'&Pack&'units')&' -'&SELF.PQ.PercentDiscount&'%' END
  ELSIF SELF.PQ.DiscountedAmount
    Discount += Cnt*SELF.PQ.DiscountedAmount
    IF SELF.NewInvoiceLine THEN SELF.DiscountText=CHOOSE(~SELF.DiscountText,'',SELF.DiscountText&', ')&Cnt&CHOOSE(SELF.CurType<>Discount:Unitisation,'','x'&Pack&'units')&'@'&FORMAT(SELF.PQ.DiscountedAmount,@N-12.2) END
  END


QuantityDiscountClass._FillProdDiscountQ PROCEDURE
Done BYTE
CartDate DATE,AUTO
  CODE
    IF SELF.CurProductID <> SELF.ILProductID
      SELF.CurProductID = SELF.ILProductID
      SELF.DProductID = SELF.ILProductID
      SELF.FMD.ClearKey(SELF.DKey,2)
      SET(SELF.DKey, SELF.DKey)
      LOOP UNTIL SELF.FMD.TryNext() <> Level:Benign OR SELF.DProductID <> SELF.ILProductID
        CartDate = CHOOSE(SELF.IDte&=NULL,TODAY(),SELF.IDte)
        IF ~SELF.DDateLow &= NULL AND SELF.DDateLow AND CartDate < SELF.DDateLow OR |
           ~SELF.DDateHigh &= NULL AND SELF.DDateHigh AND CartDate > SELF.DDateHigh
          CYCLE
        END
        IF ~Done
          IF ~SELF.PQ &= NULL
            DISPOSE(SELF.PQ)
          END
          SELF.PQ &= NEW ProductQueue
          IF ~SELF.DDiscountType &= NULL
            SELF.CurType = InList(SELF.DDiscountType,'Simple Discount','Stepped Discount','Unitisation')
          ELSE
?           ASSERT(SELF.DefaultType,'No default discount type provided')
            SELF.CurType = InList(SELF.DefaultType,'Simple Discount','Stepped Discount','Unitisation')
          END
          Done=TRUE
        END
        CLEAR(SELF.PQ)
        IF ~SELF.DDiscountType &= NULL
?         ASSERT(SELF.CurType>0 AND SELF.CurType=InList(SELF.DDiscountType,'Simple Discount','Stepped Discount','Unitisation'),'Invalid discount type!')
        END
        IF ~SELF.DQuantityLow &= NULL THEN SELF.PQ.QuantityLow=SELF.DQuantityLow END
        IF ~SELF.DQuantityHigh &= NULL THEN SELF.PQ.QuantityHigh=SELF.DQuantityHigh END
        IF ~SELF.DPercentDiscount &= NULL THEN SELF.PQ.PercentDiscount = SELF.DPercentDiscount END
        IF ~SELF.DDiscountedAmount &= NULL THEN SELF.PQ.DiscountedAmount = SELF.DDiscountedAmount END
        IF SELF.CurType = Discount:Unitisation AND ~SELF.PQ.QuantityLow
          ADD(SELF.PQ, SELF.PQ.QuantityHigh)
        ELSE
          ADD(SELF.PQ, SELF.PQ.QuantityLow)
        END
      END
    END
    RETURN CHOOSE(Done,Level:Benign,Level:Notify)


QuantityDiscountClass.RecordProcessor.TakeClose PROCEDURE
  CODE
    DISPOSE(SELF.Q)
    DISPOSE(SELF.PQ)
    RETURN Level:Benign


QuantityDiscountClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'FileManager','FileKey','ProductID','QuantityLow','QuantityHigh','PercentDiscount','DiscountAmount','ExtraLine','DateLow','DateHigh','DiscountType','DefaultType','MinSpent')
      SELF.FMD &= FM
      SELF.DKey &= FileKey
      SELF.DProductID &= Item
      SELF.DQuantityLow &= Item
      SELF.DQuantityHigh &= Item
      SELF.DPercentDiscount &= Item
      SELF.DDiscountedAmount &= Item
      SELF.NewInvoiceLine = TRUE
      SELF.DDateLow &= Item
      SELF.DDateHigh &= Item
      SELF.DDiscountType &= Item
      SELF.DefaultType = Value
      SELF.DSpent &= Item
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END


QuantityDiscountClass.CloseInvoice PROCEDURE
  CODE
    IF ~SELF.Q &= NULL
      LOOP
        GET(SELF.Q,1)
        IF ERRORCODE() THEN BREAK END
        DELETE(SELF.Q)
      END
    END
    SELF._DiscountOnTotal()


QuantityDiscountClass._DiscountOnTotal PROCEDURE
FixedDiscount DECIMAL(26,6)
PercentDiscount DECIMAL(26,6)
Spent DECIMAL(26,6)
CartDate DATE,AUTO
Tmp DECIMAL(26,6),AUTO
MyText CSTRING(1024)
  CODE
    IF ~SELF.DSpent &= NULL
      Tmp = SELF.RunningTotal-SELF.RunningShipping
      SET(SELF.FMD.File)
      LOOP UNTIL SELF.FMD.TryNext() <> Level:Benign
        CartDate = CHOOSE(SELF.IDte&=NULL,TODAY(),SELF.IDte)
        IF ~SELF.DDateLow &= NULL AND SELF.DDateLow AND CartDate < SELF.DDateLow OR |
           ~SELF.DDateHigh &= NULL AND SELF.DDateHigh AND CartDate > SELF.DDateHigh
          CYCLE
        END
        IF SELF.DSpent>Spent AND SELF.DSpent <= Tmp
          Spent = SELF.DSpent
          FixedDiscount = Spent - SELF.DDiscountedAmount
          PercentDiscount = SELF.DPercentDiscount
        END
      END
      Tmp = CHOOSE(PercentDiscount>0,Tmp*PercentDiscount*.01,FixedDiscount)
      IF Tmp
        SELF.RunningTotal -= Tmp
        IF SELF.NewInvoiceLine
          MyText = SELF._Substitute(SELF.Text, '#DiscountType#', 'Spent Discount')
          MyText = SELF._Substitute(MyText, '#SpentOver#', FORMAT(Spent,@N-12.2))
          MyText = SELF._Substitute(MyText, '#Discount#', CHOOSE(PercentDiscount>0,PercentDiscount&'%',FORMAT(FixedDiscount,@N-12.2)))
          SELF.AddNewIL(MyText,Tmp*-1,,TRUE)
        END
      END
    END

ShippingClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


ShippingClass.TakeRecord PROCEDURE
  CODE
    PARENT.TakeRecord()
    RETURN Level:Benign


ShippingClass.RecordProcessor.TakeClose PROCEDURE
  CODE
  CLEAR(SELF.ValueSet)
  RETURN Level:Benign


ShippingClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'PWeightField','SWFileManager','SWKey','SWMinWeightField', |
                  'SWFixedWeightShippingField','SWDestinationCodeField','SWProductIDField', |
                  'SCFileManager','SCKey', 'SCMinQuantityField','SCMinSpentField','SCShippingField', |
                  'SCIsPercentageField','SCDestinationCodeField','SCProductIDField', |
                  'PFixedWeightShippingField','FixedWeightShipping', |
                  'PerItemFixedShipping','PerItemPercentageShipping','DestinationExpression', |
                  'EndResult','UseGenericProdID')
      SELF.PWeight &= Item
      SELF.FMSW &= FM
      SELF.SWKey &= FileKey
      SELF.SWMinWeight &= Item
      SELF.SWFixedShipping &= Item
      SELF.SWDest &= Item
      SELF.SWProductID &= Item
      SELF.FMSC &= FM
      SELF.SCKey &= FileKey
      SELF.SCMinQuantity &= Item
      SELF.SCMinSpent &= Item
      SELF.SCShipping &= Item
      SELF.SCIsPercentage &= Item
      SELF.SCDest &= Item
      SELF.SCProductID &= Item
      SELF.PFixedWeightShipping &= Item
      BEGIN
        SELF.FixedWeightShipping = Value
        SELF.ValueSet+=1 !need to remember value was set in case value is 0
      END
      BEGIN
        SELF.QFixedShipping = Value
        SELF.ValueSet += 2
      END
      BEGIN
        SELF.QPercentShipping = Value
        SELF.ValueSet += 4
      END
      SELF.DestExpr = Value
      SELF.EndResult = Value
      SELF.UseGenericProdID = Value
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END


ShippingClass.GetWeightShipping PROCEDURE(*DECIMAL Weight, *DECIMAL Cost, *DECIMAL FixedShipping)
Dest ASTRING
MinWeight DECIMAL(26,6)
TestProduct CSTRING(MaxProductID),AUTO
I USHORT,AUTO
ret BYTE
  CODE
?   ASSERT(~SELF.PWeight&=NULL,'Product Weight Field not provided')
    IF ~SELF.PFixedWeightShipping&=NULL AND SELF.PFixedWeightShipping
      FixedShipping = SELF.PFixedWeightShipping*Weight
      ret = 1
    END
    IF ~ret AND ~SELF.FMSW &= NULL
      IF ~SELF.SWKey&=NULL
        SELF.FMSW.ClearKey(SELF.SWKey)
      END
      LOOP I=1 TO 4
        IF ~SELF.SWKey&=NULL
          SELF.FMSW.ClearKey(SELF.SWKey)
        END
        IF SELF.SWProductID &= NULL AND SELF.SWDest &= NULL
          SET(SELF.FMSW.File)
          I=4
        ELSE
          IF ~SELF.SWProductID &= NULL AND I <= 2
            SELF.SWProductID = SELF.ILProductID
            TestProduct = SELF.ILProductID
          ELSE
            I=CHOOSE(I<3,3,I)
            IF ~SELF.SWProductID &= NULL AND ~SELF.UseGenericProdID
              BREAK
            END
            CLEAR(TestProduct)
          END
          IF ~SELF.SWDest &= NULL
            IF Dest
              Dest = ''
            ELSE
              Dest = EVALUATE(SELF.DestExpr)
            END
            SELF.SWDest = Dest
          ELSE
            I = CHOOSE(I,2,2,4,4)
          END
          SET(SELF.SWKey, SELF.SWKey)
        END
        LOOP UNTIL SELF.FMSW.TryNext() <> Level:Benign OR (~SELF.SWProductID &= NULL AND SELF.SWProductID <> TestProduct) |
             OR (~SELF.SWDest &= NULL AND SELF.SWDest <> Dest)
          IF ~SELF.SWMinWeight &= NULL AND SELF.SWMinWeight <= Weight AND MinWeight <= SELF.SWMinWeight
            MinWeight = SELF.SWMinWeight
            IF ~SELF.SWFixedShipping &= NULL THEN
              FixedShipping = SELF.SWFixedShipping*Weight
              ret = 1
            END
          END
        END
        IF ret THEN BREAK END
      END
    END
    IF ~ret
      IF SELF.FixedWeightShipping THEN
        FixedShipping = SELF.FixedWeightShipping*Weight
        ret = 1
      END
    END
    RETURN ret

ShippingClass.GetShipping PROCEDURE(LONG Quantity, *DECIMAL Cost, *DECIMAL QFixedShipping, *DECIMAL QPercentShipping, *DECIMAL SpentFixedShipping, *DECIMAL SpentPercentShipping)
Dest ASTRING
PMinQ LONG
FMinQ LONG
PMinSpent DECIMAL(26,6)
FMinSpent DECIMAL(26,6)
TestProduct CSTRING(MaxProductID),AUTO
I USHORT,AUTO
ret BYTE
  CODE
    IF ~SELF.FMSC &= NULL
?     ASSERT(~SELF.SCShipping&=NULL,'Shipping Field in Shipping Cost File not provided!')
      LOOP I=1 TO 4
        DO SetShippingCostFile
        IF ret=Level:Notify
          CLEAR(ret)
          BREAK
        END
        DO RetrieveShippingCostFile
        IF ret THEN BREAK END
      END
    END
    IF ~ret
      IF BAND(SELF.ValueSet,2) THEN
        QFixedShipping = SELF.QFixedShipping*Quantity
        ret = BOR(ret,2)
      END
      IF BAND(SELF.ValueSet,4) THEN
        QPercentShipping = SELF.QPercentShipping*.01*Cost
        ret = BOR(ret,4)
      END
    END
    RETURN ret

SetShippingCostFile ROUTINE
  IF ~SELF.SCKey&=NULL
    SELF.FMSC.ClearKey(SELF.SCKey)
  END
  IF SELF.SCProductID &= NULL AND SELF.SCDest &= NULL
    SET(SELF.FMSC.File)
    I=4
  ELSE
    IF ~SELF.SCProductID &= NULL AND I <= 2
      SELF.SCProductID = SELF.ILProductID
      TestProduct = SELF.ILProductID
    ELSE
      I=CHOOSE(I<3,3,I)
      IF ~SELF.SCProductID &= NULL THEN
        IF ~SELF.UseGenericProdID
          ret = Level:Notify
          EXIT
        END
      END
      CLEAR(TestProduct)
    END
    IF ~SELF.SCDest &= NULL
      IF Dest
        Dest = ''
      ELSE
        Dest = EVALUATE(SELF.DestExpr)
      END
      SELF.SCDest = Dest
    ELSE
      I = CHOOSE(I,2,2,4,4)
    END
    SET(SELF.SCKey, SELF.SCKey)
  END

RetrieveShippingCostFile ROUTINE
  LOOP UNTIL SELF.FMSC.TryNext() <> Level:Benign OR (~SELF.SCProductID &= NULL AND SELF.SCProductID <> TestProduct) |
       OR (~SELF.SCDest &= NULL AND SELF.SCDest <> Dest)
    IF ~SELF.SCMinSpent &= NULL AND (~SELF.SCMinQuantity &= NULL AND ~SELF.SCMinQuantity OR SELF.SCMinQuantity&=NULL) AND SELF.SCMinSpent <= Cost
      IF ~SELF.SCIsPercentage&= NULL AND SELF.SCIsPercentage
        IF PMinSpent <= SELF.SCMinSpent
          PMinSpent = SELF.SCMinSpent
          SpentPercentShipping = SELF.SCShipping*.01*Cost
          ret = BOR(ret,16)
        END
      ELSE
        IF FMinSpent <= SELF.SCMinSpent
          FMinSpent = SELF.SCMinSpent
          SpentFixedShipping = SELF.SCShipping
          ret = BOR(ret,8)
        END
      END
    ELSIF ~SELF.SCMinQuantity &= NULL AND SELF.SCMinQuantity AND SELF.SCMinQuantity <= Quantity
      IF ~SELF.SCIsPercentage&= NULL AND SELF.SCIsPercentage
        IF PMinQ <= SELF.SCMinQuantity
          PMinQ = SELF.SCMinQuantity
          QPercentShipping = SELF.SCShipping*.01*Cost
          ret = BOR(ret,4)
        END
      ELSE
        IF FMinQ <= SELF.SCMinQuantity
          FMinQ = SELF.SCMinQuantity
          QFixedShipping = SELF.SCShipping*Quantity
          ret = BOR(ret,2)
        END
      END
    END
  END


ShippingOnInvoiceLine.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


ShippingOnInvoiceLine.TakeRecord PROCEDURE
WFixedShipping DECIMAL(26,6)
QFixedShipping DECIMAL(26,6)
QPercentShipping DECIMAL(26,6)
SpentFixedShipping DECIMAL(26,6)
SpentPercentShipping DECIMAL(26,6)
ret BYTE
Tmp DECIMAL(26,6),AUTO
Cost DECIMAL(26,6),AUTO
Which BYTE
MyText CSTRING(1024),AUTO
  CODE
    PARENT.TakeRecord()
    IF ~SELF.PWeight &= NULL AND SELF.PWeight
      Tmp = SELF.PWeight*SELF.ILQuantity
      Cost = CHOOSE(SELF.NetLine>0,SELF.NetLine,0)
      ret = SELF.GetWeightShipping(tmp, Cost, WFixedShipping)
    END
    ret = BOR(ret,SELF.GetShipping(SELF.ILQuantity, Cost, QFixedShipping, QPercentShipping, SpentFixedShipping, SpentPercentShipping))
    CASE SELF.EndResult
    OF 'Total'
      Tmp = WFixedShipping + QFixedShipping + QPercentShipping + SpentFixedShipping + SpentPercentShipping
    OF 'Minimum'
      IF ~ret THEN
        Tmp = 0
      ELSE
        CLEAR(Tmp,1)
        IF BAND(ret,1) AND WFixedShipping < Tmp THEN
          Tmp = WFixedShipping
          Which = 1
        END
        IF BAND(ret,2) AND QFixedShipping < Tmp THEN
          Tmp = QFixedShipping
          Which = 2
        END
        IF BAND(ret,4) AND QPercentShipping < Tmp THEN
          Tmp = QPercentShipping
          Which = 3
        END
        IF BAND(ret,8) AND SpentFixedShipping < Tmp THEN
          Tmp = SpentFixedShipping
          Which = 4
        END
        IF BAND(ret,16) AND SpentPercentShipping < Tmp THEN
          Tmp = SpentPercentShipping
          Which = 5
        END
      END
    OF 'Maximum'
      Tmp = WFixedShipping
      IF WFixedShipping THEN Which = 1 END
      IF QFixedShipping > Tmp THEN
        Tmp = QFixedShipping
        Which = 2
      END
      IF QPercentShipping > Tmp THEN
        Tmp = QPercentShipping
        Which = 3
      END
      IF SpentFixedShipping > Tmp THEN
        Tmp = SpentFixedShipping
        Which = 4
      END
      IF SpentPercentShipping > Tmp THEN
        Tmp = SpentPercentShipping
        Which = 5
      END
    END
    IF ret
      IF ~SELF.ILShippingCost &= NULL
        SELF.ILShippingCost = Tmp
      ELSE
        DO BuildText
        SELF.AddNewIL(MyText,,Tmp)
      END
      SELF.RunningTotal += Tmp
      SELF.RunningShipping += Tmp
    END
    RETURN Level:Benign

BuildText ROUTINE
  MyText = SELF._Substitute(SELF.Text,'#WeightShipping#',CHOOSE(SELF.EndResult='Total' OR Which=1,FORMAT(WFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#QuantityFixedShipping#',CHOOSE(SELF.EndResult='Total' OR Which=2,FORMAT(QFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#QuantityPercentageShipping#',CHOOSE(SELF.EndResult='Total' OR Which=3,FORMAT(QPercentShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#SpentFixedShipping#',CHOOSE(SELF.EndResult='Total' OR Which=4,FORMAT(SpentFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#SpentPercentageShipping#',CHOOSE(SELF.EndResult='Total' OR Which=5,FORMAT(SpentPercentShipping,@N-12.2),''))


ShippingOnInvoiceLine.RecordProcessor.TakeClose PROCEDURE
  CODE
  RETURN Level:Benign


ShippingOnInvoice.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


ShippingOnInvoice.TakeRecord PROCEDURE
  CODE
    PARENT.TakeRecord()
    SELF._IncreasePerIL()
    RETURN Level:Benign


ShippingOnInvoice._IncreasePerIL PROCEDURE
  CODE
    IF ~SELF.PWeight &= NULL
      SELF.RunningWeight += SELF.PWeight * SELF.ILQuantity
    END
    SELF.RunningQuantity += SELF.ILQuantity


ShippingOnInvoice.RecordProcessor.TakeClose PROCEDURE
  CODE
    RETURN Level:Benign


ShippingOnInvoice.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'OneOffFixedShipping','OverRide','OverRideDescription')
      SELF.OneOffFixedShipping = Value
      SELF.OverRide = Value
      SELF.OverRideText = Value
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSIF NOT OMITTED(5)
        PARENT.AddItem(WhatItem,,,FM)
      ELSIF NOT OMITTED(6)
        PARENT.AddItem(WhatItem,,,,FileKey)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END


ShippingOnInvoice.CloseInvoice PROCEDURE
WFixedShipping DECIMAL(26,6)
QFixedShipping DECIMAL(26,6)
QPercentShipping DECIMAL(26,6)
SpentFixedShipping DECIMAL(26,6)
SpentPercentShipping DECIMAL(26,6)
ret BYTE
Tmp DECIMAL(26,6),AUTO
MyText CSTRING(1024),AUTO
Which BYTE
  CODE
    Tmp = CHOOSE(SELF.RunningTotal-SELF.RunningShipping>0,SELF.RunningTotal-SELF.RunningShipping,0)
    IF SELF.RunningWeight
      ret = SELF.GetWeightShipping(SELF.RunningWeight, Tmp, WFixedShipping)
    END
    IF SELF.RunningQuantity
      ret = BOR(ret,SELF.GetShipping(SELF.RunningQuantity, Tmp, QFixedShipping, QPercentShipping, SpentFixedShipping, SpentPercentShipping))
    END
    CASE SELF.EndResult
    OF 'Total'
      Tmp = SELF.OneOffFixedShipping + WFixedShipping + QFixedShipping + QPercentShipping + SpentFixedShipping + SpentPercentShipping
    OF 'Minimum'
      IF ~ret THEN
        Tmp = 0
      ELSE
        CLEAR(Tmp,1)
        IF BAND(ret,1) AND WFixedShipping < Tmp THEN
          Tmp = WFixedShipping
          Which = 1
        END
        IF BAND(ret,2) AND QFixedShipping < Tmp THEN
          Tmp = QFixedShipping
          Which = 2
        END
        IF BAND(ret,4) AND QPercentShipping < Tmp THEN
          Tmp = QPercentShipping
          Which = 3
        END
        IF BAND(ret,8) AND SpentFixedShipping < Tmp THEN
          Tmp = SpentFixedShipping
          Which = 4
        END
        IF BAND(ret,16) AND SpentPercentShipping < Tmp THEN
          Tmp = SpentPercentShipping
          Which = 5
        END
        IF BAND(ret,32) AND SELF.OneOffFixedShipping < Tmp THEN
          Tmp = SELF.OneOffFixedShipping
          Which = 6
        END
      END
    OF 'Maximum'
      Tmp = SELF.OneOffFixedShipping
      IF SELF.OneOffFixedShipping THEN Which = 6 END
      IF WFixedShipping > Tmp THEN
        Tmp = WFixedShipping
        Which = 1
      END
      IF QFixedShipping > Tmp THEN
        Tmp = QFixedShipping
        Which = 2
      END
      IF QPercentShipping > Tmp THEN
        Tmp = QPercentShipping
        Which = 3
      END
      IF SpentFixedShipping > Tmp THEN
        Tmp = SpentFixedShipping
        Which = 4
      END
      IF SpentPercentShipping > Tmp THEN
        Tmp = SpentPercentShipping
        Which = 5
      END
    END
    IF ret
      DO BuildText
      IF SELF.OverRide
        SELF.AddNewIL(SELF.OverRideText, , SELF.RunningShipping*-1, TRUE)
        SELF.AddNewIL(MyText, , Tmp, TRUE)
        SELF.RunningTotal -= SELF.RunningShipping-Tmp
      ELSE
        SELF.AddNewIL(MyText,,Tmp,TRUE)
        SELF.RunningTotal += Tmp
      END
    END
    CLEAR(SELF.RunningWeight)
    CLEAR(SELF.RunningQuantity)

BuildText ROUTINE
  MyText = SELF._Substitute(SELF.Text,'#WeightShipping#',CHOOSE(SELF.EndResult='Total' OR Which=1,FORMAT(WFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#QuantityFixedShipping#',CHOOSE(SELF.EndResult='Total' OR Which=2,FORMAT(QFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#QuantityPercentageShipping#',CHOOSE(SELF.EndResult='Total' OR Which=3,FORMAT(QPercentShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#SpentFixedShipping#',CHOOSE(SELF.EndResult='Total' OR Which=4,FORMAT(SpentFixedShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#SpentPercentageShipping#',CHOOSE(SELF.EndResult='Total' OR Which=5,FORMAT(SpentPercentShipping,@N-12.2),''))
  MyText = SELF._Substitute(MyText,'#One-OffShipping#',CHOOSE(SELF.EndResult='Total' OR Which=6,FORMAT(SELF.OneOffFixedShipping,@N-12.2),''))


CategoryDiscountClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'FileManagerProdCat','ProdCatKey','PCProductID', |
                  'PCCategory','FileManagerCat','CatKey','CatCategory', |
                  'CatDateLow','CatDateHigh','CatDiscountRate','CatSupersedes', |
                  'ExtraLine','Description','CatCategoryName')
      SELF.FMPC &= FM
      SELF.PCKey &= FileKey
      SELF.PCProductID &= Item
      SELF.PCCategory &= Item
      SELF.FMCat &= FM
      SELF.CatKey &= FileKey
      SELF.CatCategory &= Item
      SELF.CatDateLow &= Item
      SELF.CatDateHigh &= Item
      SELF.CatDiscount &= Item
      SELF.CatSupersedes &= Item
      SELF.NewIL = Value
      SELF.Text = Value
      SELF.CatCategoryName &= Item
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END

CategoryDiscountClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


CategoryDiscountClass.TakeRecord PROCEDURE
SuperDiscount DECIMAL(26,6)
Discount      DECIMAL(26,6)
Tmp           DECIMAL(26,6),AUTO
CartDate      DATE,AUTO
BuildText     BYTE,AUTO
MyText        CSTRING(1024)
  CODE
    BuildText=SELF.NewIL
    PARENT.TakeRecord()
    SELF.StopDiscount=FALSE
    DO InitialCheck
    CartDate = CHOOSE(SELF.IDte&=NULL,TODAY(),SELF.IDte)
    SELF.PCProductID = SELF.ILProductID
    SELF.FMPC.ClearKey(SELF.PCKey,2)
    SET(SELF.PCKey,SELF.PCKey)
    LOOP UNTIL SELF.FMPC.TryNext() <> Level:Benign OR SELF.PCProductID <> SELF.ILProductID
      SELF.FMCat.ClearKey(SELF.CatKey)
      SELF.CatCategory = SELF.PCCategory
?     ASSERT(SELF.FMCat.Fetch(SELF.CatKey)=Level:Benign,'Category not found!')
      IF ~SELF.CatDateLow&=NULL AND SELF.CatDateLow AND SELF.CatDateLow>CartDate |
         OR ~SELF.CatDateHigh&=NULL AND SELF.CatDateHigh AND SELF.CatDateHigh<CartDate
        CYCLE
      END
      tmp = SELF.ILQuantity*SELF.ILUnitPrice*SELF.CatDiscount*.01
      IF ~SELF.CatSupersedes&=NULL AND SELF.CatSupersedes
        IF tmp > SuperDiscount THEN SuperDiscount = tmp END
        SELF.StopDiscount = TRUE
        IF SELF.NewIL
          BuildText = FALSE
          DO BuildText
        END
      ELSE
        IF BuildText THEN DO BuildText END
        Discount += Tmp
      END
    END
    tmp = CHOOSE(SELF.StopDiscount,SuperDiscount,Discount)
    IF tmp
      IF SELF.NewIL
        SELF.AddNewIL(SELF._Substitute(SELF.Text, '#Discount#',MyText),tmp*-1)
      ELSE
        SELF.ILProductCost -= tmp
      END
      SELF.NetLine -= tmp
      SELF.RunningTotal -= tmp
    END
    RETURN Level:Benign

BuildText ROUTINE
  MyText=CHOOSE(BuildText AND Mytext,MyText&', ','')&CHOOSE(~SELF.CatCategoryName&=Null AND SELF.CatCategoryName,CLIP(SELF.CatCategoryName)&' ','')&SELF.CatDiscount&'%'

InitialCheck ROUTINE
  IF NOT SELF.CheckDone
    SELF.CheckDone = TRUE
?   ASSERT(~SELF.FMPC&=NULL AND ~SELF.FMCat&=NULL,'Category File information missing!')
?   ASSERT(~SELF.PCKey&=NULL AND ~SELF.CatKey&=NULL,'Category Key information missing!')
?   ASSERT(SELF.FMPC.UseFile()=Level:Benign,'File error on Product Category file')
?   ASSERT(SELF.FMCat.UseFile()=Level:Benign,'File error on Category file')
  END

CategoryDiscountClass.RecordProcessor.TakeClose PROCEDURE
  CODE
    RETURN Level:Benign


OptionsClass.AddItem PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>)
  CODE
    EXECUTE InList(WhatItem,'CartLineOptionID','FileManager','FileKey','OptionID','ProductID', |
                  'Description','Cost','IsPercentage','UseGenericProdID','ExtraLine')
      SELF.CLOptionID &= Item
      SELF.FMO &= FM
      SELF.OKey &= FileKey
      SELF.OID &= Item
      SELF.OProductID &= Item
      SELF.ODescription &= Item
      SELF.OCost &= Item
      SELF.OIsPercentage &= Item
      SELF.UseGenericProdID = Value
      SELF.NewIL = TRUE
    ELSE
      IF NOT OMITTED(3)
        PARENT.AddItem(WhatItem,Item)
      ELSIF NOT OMITTED(4)
        PARENT.AddItem(WhatItem,,Value)
      ELSE
?       ASSERT(0,'Cannot find '&WhatItem)
      END
    END


OptionsClass.RecordProcessor.TakeRecord PROCEDURE
  CODE
    RETURN SELF.TakeRecord()


OptionsClass.TakeRecord PROCEDURE
Cost DECIMAL(26,6),AUTO
ret  BYTE,AUTO
  CODE
    PARENT.TakeRecord()
    DO InitialCheck
    IF ~SELF.OProductID&=NULL
      ret = SELF._GetOptionCost(SELF.ILProductID)
      IF ret<>Level:Benign AND SELF.UseGenericProdID
        ret = SELF._GetOptionCost('')
      END
    ELSE
      ret = SELF._GetOptionCost()
    END
    IF ret = Level:Benign
      IF SELF.OIsPercentage
        Cost = SELF.ILQuantity*SELF.ILUnitPrice*SELF.OCost*.01
      ELSE
        Cost = SELF.ILQuantity*SELF.OCost
      END
      IF Cost
        IF SELF.NewIL
          SELF.AddNewIL(SELF._Substitute(SELF.ODescription,'#Cost#',CHOOSE(~SELF.OIsPercentage,FORMAT(SELF.OCost,@N-12.2),SELF.OCost+'%')),Cost)
        ELSE
          SELF.ILProductCost += Cost
        END
        SELF.NetLine += Cost
        SELF.RunningTotal += Cost
      END
    END
    RETURN Level:Benign

InitialCheck ROUTINE
  IF NOT SELF.CheckDone
    SELF.CheckDone = TRUE
?   ASSERT(~SELF.FMO&=NULL AND ~SELF.OKey&=NULL,'Options file or key information missing!')
?   ASSERT(~SELF.OID&=NULL AND ~SELF.OCost&=NULL,'Options ID field or options cost field information missing!')
?   ASSERT(~SELF.CLOptionID&=NULL,'Cart line option ID field information missing!')
  END


OptionsClass._GetOptionCost PROCEDURE(<ASTRING ProductID>)
  CODE
    SELF.FMO.ClearKey(SELF.OKey)
    SELF.OID = SELF.CLOptionID
    IF ~OMITTED(2)
      SELF.OProductID = ProductID
    END
    RETURN SELF.FMO.TryFetch(SELF.OKey)


OptionsClass.RecordProcessor.TakeClose PROCEDURE
  CODE
    RETURN Level:Benign

