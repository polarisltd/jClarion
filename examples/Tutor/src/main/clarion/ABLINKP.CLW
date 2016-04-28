  MEMBER

  COMPILE ('=== DO LINK', _LinkPointLinkMode_)
    PRAGMA ('link (clearc.lib)')
! === DO LINK

  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABLINKP.INC'),ONCE

  MAP
   MODULE('clearc')
    tax_process(LONG),LONG,PASCAL,RAW,NAME('tax_process')
    shipping_process(LONG),LONG,PASCAL,RAW,NAME('shipping_process')
    order_process(LONG),LONG,PASCAL,RAW,NAME('order_process'),PROC

    req_alloc(*LONG),LONG,PASCAL,RAW,NAME('req_alloc'),PROC
    req_clear(LONG),LONG,PASCAL,RAW,NAME('req_clear'),PROC
    req_drop(LONG),LONG,PASCAL,RAW,NAME('req_drop'),PROC
    req_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('req_get')
    req_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('req_set'),PROC
    req_error(LONG),LONG,PASCAL,RAW,NAME('req_error')

    order_alloc(*LONG),LONG,PASCAL,RAW,NAME('order_alloc'),PROC
    order_drop(LONG),LONG,PASCAL,RAW,NAME('order_drop'),PROC
    order_clear(LONG),LONG,PASCAL,RAW,NAME('order_clear'),PROC
    order_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('order_get'),PROC
    order_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('order_set'),PROC
    order_additem(LONG, LONG),LONG,PASCAL,RAW,NAME('order_additem')
    order_setrequest(LONG, LONG),LONG,PASCAL,RAW,NAME('order_setrequest')
    order_error(LONG),LONG,PASCAL,RAW,NAME('order_error')

    shipping_alloc(*LONG),LONG,PASCAL,RAW,NAME('shipping_alloc'),PROC
    shipping_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('shipping_get'),PROC
    shipping_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('shipping_set'),PROC
    shipping_drop(LONG),LONG,PASCAL,RAW,NAME('shipping_drop'),PROC
    shipping_error(LONG),LONG,PASCAL,RAW,NAME('shipping_error')
    shipping_clear(LONG),LONG,PASCAL,RAW,NAME('shipping_clear'),PROC
    shipping_setrequest(LONG, LONG),LONG,PASCAL,RAW,NAME('shipping_setrequest'),PROC

    item_alloc(*LONG),LONG,PASCAL,RAW,NAME('item_alloc'),PROC
    item_clear(LONG),LONG,PASCAL,RAW,NAME('item_clear'),PROC
    item_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('item_get'),PROC
    item_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('item_set'),PROC
    item_drop(LONG),LONG,PASCAL,RAW,NAME('item_drop'),PROC
    item_addoption(LONG, LONG),LONG,PASCAL,RAW,NAME('item_addoption')
    item_error(LONG),LONG,PASCAL,RAW,NAME('item_error')

    option_alloc(*LONG),LONG,PASCAL,RAW,NAME('option_alloc'),PROC
    option_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('option_get'),PROC
    option_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('option_set'),PROC
    option_drop(LONG),LONG,PASCAL,RAW,NAME('option_drop'),PROC
    option_clear(LONG),LONG,PASCAL,RAW,NAME('option_clear'),PROC
    option_error(LONG),LONG,PASCAL,RAW,NAME('option_error')

    tax_alloc(*LONG),LONG,PASCAL,RAW,NAME('tax_alloc'),PROC
    tax_get(LONG, LONG, LONG, unsigned int),LONG,PASCAL,RAW,NAME('tax_get'),PROC
    tax_set(LONG, LONG, LONG),LONG,PASCAL,RAW,NAME('tax_set'),PROC
    tax_drop(LONG),LONG,PASCAL,RAW,NAME('tax_drop'),PROC
    tax_clear(LONG),LONG,PASCAL,RAW,NAME('tax_clear'),PROC
    tax_error(LONG),LONG,PASCAL,RAW,NAME('tax_error')
    tax_setrequest(LONG, LONG),LONG,PASCAL,RAW,NAME('tax_setrequest'),PROC

    util_errorstr(LONG, *CSTRING, ULONG),LONG,PASCAL,RAW,NAME('util_errorstr'),PROC
    util_version(),SREAL,PASCAL,NAME('util_version')
   END
  END


LinkPointClass.Init    PROCEDURE(ErrorClass Errors)

  CODE
  SELF.Items &= NEW(ItemQueue)
  SELF.Errors &= Errors

LinkPointClass.Kill    PROCEDURE()

  CODE
  FREE(SELF.Items)
  DISPOSE(SELF.Items)

LinkPointClass.Allocate PROCEDURE()

  CODE
  order_alloc(SELF.orderctx)
  item_alloc(SELF.itemctx)
  option_alloc(SELF.optionctx)
  req_alloc(SELF.reqctx)
  shipping_alloc(SELF.shippingctx)
  tax_alloc(SELF.taxctx)

LinkPointClass.CalculateShipping    PROCEDURE(STRING Country, STRING State, ? Total, ? Items, ? Weight, LONG Carrier, *? ShippingTotal)
Lp:country     CSTRING(3)
Lp:State       CSTRING(3)
Lp:Total       SREAL
Lp:Items       LONG
Lp:Weight      SREAL
Lp:Carrier     LONG

Lp:ReqCtx      LONG
Lp:ShippingCtx LONG

Lp:ShippingTotal SREAL

  CODE
  lp:Country = Country
  lp:State   = State
  lp:Total   = Total
  lp:Items   = Items
  lp:Weight  = Weight
  lp:Carrier = Carrier

  IF SELF.ProcessShipping(LP:Country, LP:State, LP:Total, LP:Items, LP:Weight, LP:Carrier, LP:ShippingCtx, Lp:ShippingTotal)
     RETURN Level:Notify
  END

  RETURN Level:Benign

LinkPointClass.Free     PROCEDURE()

  CODE
  order_drop(SELF.orderctx)
  item_drop(SELF.itemctx)
  option_drop(SELF.optionctx)
  req_drop(SELF.reqctx)
  shipping_drop(SELF.shippingctx)
  tax_drop(SELF.taxctx)

LinkPointClass.ProcessOrder PROCEDURE
ErrorString CSTRING(200)
RVal        BYTE
ValAddr     LONG

MyHost      CSTRING(41)

  CODE
  RVal = Level:Benign
  SELF.Allocate()
  req_set(SELF.reqctx, ReqField_Configfile, ADDRESS(SELF.Req.ConfigFile))
  req_set(SELF.reqctx, ReqField_Keyfile, ADDRESS(SELF.Req.KeyField))
  req_set(SELF.reqctx, ReqField_Host, ADDRESS(SELF.Req.Host))
  req_set(SELF.reqctx, ReqField_Port, ADDRESS(SELF.Req.Port))

  IF order_Setrequest(SELF.Orderctx, SELF.Reqctx) <> Succeed
     RVal = Level:Notify
     util_errorstr(order_error(SELF.orderctx), ErrorString, SIZE(ErrorString)) 
     SELF.Errors.ThrowMessage(Msg:OrderProcess, 'Setting request unsuccessful: ' & SELF.Order.oid & ' Error:' & ErrorString)
     SELF.Free()
     RETURN Level:Notify
  END

  Tax_setrequest(SELF.Taxctx, SELF.Reqctx)
  Shipping_setrequest(SELF.Shippingctx, SELF.Reqctx)

  order_set(SELF.orderctx, OrderField_OID, ADDRESS(SELF.Order.OID))
  order_set(SELF.orderctx, OrderField_Ip, ADDRESS(SELF.Order.Ip))
  order_set(SELF.orderctx, OrderField_Userid, ADDRESS(SELF.Order.Userid))
  order_set(SELF.orderctx, OrderField_Bname, ADDRESS(SELF.Order.Bname))
  order_set(SELF.orderctx, OrderField_Bcompany, ADDRESS(SELF.Order.Bcompany))
  order_set(SELF.orderctx, OrderField_Baddr1, ADDRESS(SELF.Order.Baddr1))
  order_set(SELF.orderctx, OrderField_Bcity, ADDRESS(SELF.Order.BCity))
  order_set(SELF.orderctx, OrderField_Bstate, ADDRESS(SELF.Order.Bstate))
  order_set(SELF.orderctx, OrderField_Bzip, ADDRESS(SELF.Order.Bzip))
  order_set(SELF.orderctx, OrderField_Bcountry, ADDRESS(SELF.Order.Bcountry))
  order_set(SELF.orderctx, OrderField_Sname, ADDRESS(SELF.Order.Sname))
  order_set(SELF.orderctx, OrderField_Saddr1, ADDRESS(SELF.Order.Saddr1))
  order_set(SELF.orderctx, OrderField_Scity, ADDRESS(SELF.Order.SCity))
  order_set(SELF.orderctx, OrderField_Sstate, ADDRESS(SELF.Order.Sstate))
  order_set(SELF.orderctx, OrderField_Szip, ADDRESS(SELF.Order.Szip))
  order_set(SELF.orderctx, OrderField_Scountry, ADDRESS(SELF.Order.Scountry))
  order_set(SELF.orderctx, OrderField_Phone, ADDRESS(SELF.Order.Phone))
  order_set(SELF.orderctx, OrderField_Fax, ADDRESS(SELF.Order.Fax))
  order_set(SELF.orderctx, OrderField_Comments, ADDRESS(SELF.Order.Comments))
  order_set(SELF.orderctx, OrderField_Cardnumber, ADDRESS(SELF.Order.Cardnumber))
  order_set(SELF.orderctx, OrderField_Chargetype, ADDRESS(SELF.ChargeType))
  order_set(SELF.orderctx, OrderField_Expmonth, ADDRESS(SELF.Order.Expmonth))
  order_set(SELF.orderctx, OrderField_Expyear, ADDRESS(SELF.Order.Expyear))
  order_set(SELF.orderctx, OrderField_Email, ADDRESS(SELF.Order.eMail))
  order_set(SELF.orderctx, OrderField_Result, ADDRESS(SELF.Result))
  order_set(SELF.orderctx, OrderField_addrnum, ADDRESS(SELF.Order.Addrnum))

  IF SELF.AddItems()
     SELF.Free()
     RETURN Level:Notify
  END
  ! Shipping processing omitted till we find a tester who has shipping configuration files.

  IF SELF.ProcessTax()
     SELF.Free()
     RETURN Level:Notify
  ELSE
     order_set(SELF.OrderCtx, OrderField_Tax, ADDRESS(SELF.Order.Tax))
     SELF.Order.ChargeTotal += SELF.Order.Tax
  END


  order_set(SELF.orderctx, OrderField_Chargetotal, ADDRESS(SELF.Order.ChargeTotal))

  IF order_process(SELF.orderctx) <> Succeed
     util_errorstr(order_error(SELF.orderctx), ErrorString, SIZE(ErrorString))
     SELF.Errors.ThrowMessage(Msg:OrderProcess, 'Error Processing Order: ' & SELF.Order.oid & ' Error:' & ErrorString)
     SELF.Free()
     RETURN Level:Notify
  END
  SELF.Free()
  RETURN Level:Benign


LinkPointClass.AddItem              PROCEDURE(STRING itemid, STRING description, ? price, ? quantity)
  CODE
  
  ASSERT(~SELF.Items&=NULL,'LinkPoint not inited.')
  CLEAR(SELF.Items)
  SELF.Items.itemid = itemid
  SELF.Items.description = description
  SELF.Items.price       = price
  SELF.Items.quantity    = quantity
  SELF.Items.esdtype     = Esdtype_None
  ADD(SELF.Items)

LinkPointClass.AddItemOptions       PROCEDURE(STRING option, STRING choice)
  CODE
  ASSERT(RECORDS(SELF.Items),'No Items have been added?')
  SELF.Items.nOptions += 1
  SELF.Items.Option.Option[SELF.Items.nOptions] = option
  SELF.Items.Option.Choice[SELF.Items.nOptions] = choice
  PUT(SELF.Items)

LinkPointClass.AddSoftgood          PROCEDURE(STRING itemid, STRING description, ? price, ? quantity, STRING softfile)
  CODE
  CLEAR(SELF.Items)
  SELF.Items.itemid = itemid
  SELF.Items.description = description
  SELF.Items.price       = price
  SELF.Items.quantity    = quantity
  SELF.Items.softfile    = softfile
  SELF.Items.esdtype     = Esdtype_Softgood
  SELF.Items.noptions    = 0
  ADD(SELF.Items)

LinkPointClass.AddDownloadSoftgood  PROCEDURE(STRING itemid, STRING description, ? price, ? quantity, STRING softfile, STRING serial)
  CODE
  CLEAR(SELF.Items)
  SELF.Items.itemid = itemid
  SELF.Items.description = description
  SELF.Items.price       = price
  SELF.Items.quantity    = quantity
  SELF.Items.softfile    = softfile
  SELF.Items.esdtype     = Esdtype_Key
  SELF.Items.serial      = serial
  SELF.Items.noptions    = 0
  ADD(SELF.Items)

LinkPointClass.FreeItems            PROCEDURE()
  CODE
  FREE(SELF.Items)

LinkPointClass.AddItems     PROCEDURE
ErrorString CSTRING(200)
nitem       LONG,AUTO
  CODE
  LOOP nItem=1 TO RECORDS(SELF.Items)
    GET(SELF.Items,nItem)
    item_clear(SELF.Itemctx)
    item_set(SELF.itemctx, ItemField_Itemid, ADDRESS(SELF.Items.ItemId))
    item_set(SELF.itemctx, ItemField_Description, ADDRESS(SELF.Items.Description))
    item_set(SELF.itemctx, ItemField_Softfile, ADDRESS(SELF.Items.Softfile))
    item_set(SELF.itemctx, ItemField_Serial, ADDRESS(SELF.Items.Serial))
    item_set(SELF.itemctx, ItemField_Esdtype, ADDRESS(SELF.Items.Esdtype))
    item_set(SELF.itemctx, ItemField_Price, ADDRESS(SELF.Items.Price))
    item_set(SELF.itemctx, ItemField_Quantity, ADDRESS(SELF.Items.Quantity))
    IF SELF.AddOptions()
       RETURN Level:Notify
    END
    IF order_additem(SELF.orderctx, SELF.itemctx) <> Succeed
     util_errorstr(order_error(SELF.orderctx), ErrorString, SIZE(ErrorString)) 
     SELF.Errors.ThrowMessage(Msg:AddItem, 'Order:' & SELF.Order.oid & ' - Error Adding Item: ' & ErrorString)
     RETURN Level:Notify
    END
  END

LinkPointClass.ProcessShipping PROCEDURE(STRING Country, STRING State, SREAL Total, SREAL Items, SREAL Weight, LONG Carrier, LONG ShippingCtx, *? ShippingTotal)
ErrorString CSTRING(200)
  CODE
  IF Total ! If shipping needs to be calculated.
     shipping_set(SELF.shippingctx, ShippingField_Country, ADDRESS(Country))
     shipping_set(SELF.shippingctx, ShippingField_State, ADDRESS(State))
     shipping_set(SELF.shippingctx, ShippingField_Total, ADDRESS(Total))
     shipping_set(SELF.shippingctx, ShippingField_Items, ADDRESS(Items))
     shipping_set(SELF.shippingctx, ShippingField_Weight, ADDRESS(Weight))
     shipping_set(SELF.shippingctx, ShippingField_Carrier, ADDRESS(Carrier))
     IF shipping_process(shippingctx) <> Succeed
        util_errorstr(Shipping_error(Shippingctx), ErrorString, SIZE(ErrorString)) 
        SELF.Errors.ThrowMessage(Msg:Shipping, 'Order:' & SELF.Order.oid & ' - Shipping Process Error: ' & ErrorString)
        RETURN Level:Notify
     ELSE
        shipping_get(ShippingCtx, ShippingField_R_Total, ADDRESS(ShippingTotal), 0)
     END
  ELSE
     ShippingTotal = 0
  END
  RETURN Level:Benign


LinkPointClass.ProcessTax      PROCEDURE
ErrorString CSTRING(200)
  CODE
  IF SELF.Tax.State AND SELF.Tax.Zip
     tax_set(SELF.TaxCtx, TaxField_State, ADDRESS(SELF.Tax.State))
     tax_set(SELF.TaxCtx, TaxField_Zip, ADDRESS(SELF.Tax.Zip))
     tax_set(SELF.TaxCtx, TaxField_Total, ADDRESS(SELF.Order.ChargeTotal))

     IF Tax_Process(SELF.TaxCtx) <> Succeed
        util_errorstr(tax_error(SELF.TaxCtx), ErrorString, Size(ErrorString))
        SELF.Errors.ThrowMessage(Msg:Tax, 'Order:' & SELF.Order.oid & ' - Tax Process Error: ' & ErrorString)
        RETURN Level:Notify
     END

     tax_get(SELF.TaxCtx, TaxField_R_Total, ADDRESS(SELF.Order.Tax), 0)
  END
  RETURN Level:Benign



LinkPointClass.AddOptions      PROCEDURE
ErrorString CSTRING(200)
noption     LONG,AUTO
  CODE
  LOOP noption=1 TO SELF.Items.noptions
   option_clear(SELF.OptionCtx)
   option_set(SELF.optionctx, OptionField_Option, ADDRESS(SELF.Items.Option.Option[noption]))
   option_set(SELF.optionctx, OptionField_Choice, ADDRESS(SELF.Items.Option.Choice[noption]))
   IF item_addoption(SELF.itemctx, SELF.optionctx) <> Succeed
     util_errorstr(option_error(SELF.Optionctx), ErrorString, SIZE(ErrorString))
     SELF.Errors.ThrowMessage(Msg:Option, 'Order:' & SELF.Order.oid & ' - Option Error: ' & ErrorString & ' ' & SELF.Items.Option.Option[noption])
      RETURN Level:Notify
   END
  END
  RETURN Level:Benign


