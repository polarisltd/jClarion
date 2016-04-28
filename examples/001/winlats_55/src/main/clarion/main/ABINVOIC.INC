!ABCIncludeFile(SHOP)

  OMIT('_EndOfInclude_', _InvoicePresent_)
_InvoicePresent_  EQUATE(1)

   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('ABRESERV.INT'),ONCE

CartMaxIdLen   EQUATE(100)
MaxDescLen     EQUATE(500)
MaxProductID   EQUATE(100)

NewLineQueue QUEUE,TYPE
Description    CSTRING(MaxDescLen)
Total          DECIMAL(26,6)
Shipping       DECIMAL(26,6)
             END



InvoiceGeneratorClass CLASS,IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
FMI                &FileManager,PRIVATE
ICartKey           &KEY                 !key on cart id
IInvoiceId         ANY,PRIVATE
ICartId            ANY,PRIVATE
ICustomerId        ANY,PRIVATE          !optional
ITotal             ANY,PRIVATE
IDte               ANY,PRIVATE          !optional
IAccepted          ANY,PRIVATE          !optional - if omitted assume IAccepted=FALSE
FMIL               &FileManager,PRIVATE
ILKey              &KEY                 !key on invoice id and invoice line id
ILInvoiceId        ANY,PRIVATE
ILLineID           ANY,PRIVATE
ILProductID        ANY,PRIVATE
ILProductName      ANY,PRIVATE
ILOptions          ANY,PRIVATE          !optional
ILUnitPrice        ANY,PRIVATE
ILQuantity         ANY,PRIVATE
ILShippingCost     ANY,PRIVATE          !optional
ILDescription      ANY,PRIVATE
ILProductCost      ANY,PRIVATE
ILResNo            ANY,PRIVATE          !optional - required for reservation
VMCL               &ViewManager,PRIVATE
CLCartId           ANY,PRIVATE
CLLineID           ANY,PRIVATE
CLProductID        ANY,PRIVATE
CLOptions          ANY,PRIVATE          !optional
CLUnitPrice        ANY,PRIVATE
CLQuantity         ANY,PRIVATE
CLCustomerId       ANY,PRIVATE          !optional
CLDte              ANY,PRIVATE          !optional
PName              ANY,PRIVATE
PDescription       ANY,PRIVATE          !optional
PRStatus           ANY,PRIVATE          !optional
PRAvail            ANY,PRIVATE          !optional
ResI               &IReservation    !optional - required for reservation
FailedText         ASTRING,PRIVATE      !optional

Children           &ChildQueue2,PRIVATE
CurCartID          STRING(CartMaxIDLen),PRIVATE
CurILLineID        LONG,PRIVATE
NewLineQ           &NewLineQueue,PRIVATE
NewBottomLineQ     &NewLineQueue,PRIVATE
Opened             BYTE,PRIVATE
NetLine            DECIMAL(26,6),PRIVATE
RunningTotal       DECIMAL(26,6),PRIVATE
RunningShipping    DECIMAL(26,6),PRIVATE
StopDiscount       BYTE,PRIVATE

_AddNewLines       PROCEDURE(NewLineQueue Q),BYTE,PRIVATE
_CheckOldInvoices  PROCEDURE,PRIVATE
_CheckReserved     PROCEDURE(*LONG ResNo),BYTE,PRIVATE
_CloseInvoice      PROCEDURE,PRIVATE

AddItem            PROCEDURE(ModifierClass M, BYTE InvokeAt),USHORT,PROC
InitCart           PROCEDURE(ViewManager FMCL, *? CLCartId, *? CLLineID,*? CLProductID, <*? CLOptions>, *? CLUnitPrice,*? CLQuantity, <*? CLCustomerId>, <*? CLDte>,*? PName, <*? PDescription>)
InitInvoice        PROCEDURE(FileManager FMI, KEY ICartKey, *? IInvoiceId, *? ICartID, <*? ICustomerId>, *? ITotal, <*? IDte>, <*? IAccepted>)
InitInvoiceLine    PROCEDURE(FileManager FMIL, KEY ILKey, *? ILInvoiceId, *? ILLineID, *? ILProductID, <*? ILOptions>, *? ILUnitPrice, *? ILQuantity, <*? ILShippingCost>, *? ILDescription, *? ILProductCost, *? ILProductName)
InitReservation    PROCEDURE(IReservation ResI, <*? PRStatus>, <*? PRAvail>, <ASTRING FailedText>, *? ILResNo)
Kill               PROCEDURE
  END


ModifierClass   CLASS,IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
IDte               ANY,PROTECTED          !optional
ILProductID        ANY,PROTECTED
ILOptions          ANY,PROTECTED          !optional
ILUnitPrice        ANY,PROTECTED
ILQuantity         ANY,PROTECTED
ILShippingCost     ANY,PROTECTED          !optional
ILProductCost      ANY,PROTECTED
NetLine            &DECIMAL,PROTECTED  !includes ProductCost, Discounts, SalesTax but no Shipping
NewLineQ           &NewLineQueue,PRIVATE
NewBottomLineQ     &NewLineQueue,PRIVATE
RunningTotal       &DECIMAL,PRIVATE
RunningShipping    &DECIMAL,PRIVATE
Text               ASTRING,PROTECTED
StopDiscount       ANY,PRIVATE

_AddItem           PROCEDURE(ASTRING WhatItem, <NewLineQueue Q>, <*DECIMAL DecimalItem>, <*? Item>),PRIVATE
_Substitute        PROCEDURE(ASTRING Text, ASTRING PlaceHolder, ASTRING Value),ASTRING,PRIVATE
AddItem            PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),VIRTUAL
AddNewIL           PROCEDURE(ASTRING Description, <ASTRING TotalAmount>, <ASTRING Shipping>, BYTE BottomLine=FALSE)
CloseInvoice       PROCEDURE,VIRTUAL
TakeRecord         PROCEDURE,BYTE,VIRTUAL,PROC
  END

!call after discounts, before shipping
SalesTaxClass    CLASS(ModifierClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
TaxRate            DECIMAL(26,6),PRIVATE   !simple version
FMTC               &FileManager,PRIVATE    !complex version with Tax Code file
TCKey              &KEY                    !Key on TCTaxCode
TCTaxCode          ANY,PRIVATE
TCTaxRate          ANY,PRIVATE
TaxCodeExpr        ASTRING,PRIVATE
SpecialTaxCode     ASTRING,PRIVATE
CLTaxable          ANY,PRIVATE             !optional
ILTaxAmount        ANY,PRIVATE             !optional
ILProductID        ANY,PRIVATE
PTaxCode           ANY,PRIVATE
AreaDefault        ASTRING,PRIVATE

_FetchTaxRate      PROCEDURE(),BYTE,PRIVATE

AddItem            PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
TakeRecord         PROCEDURE,BYTE,DERIVED,PROC
  END

!call before tax if taxed at same as product; call after tax if not taxed
QuantityDiscountClass CLASS(ModifierClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
FMD                &FileManager,PRIVATE
DKey               &KEY
DProductID         ANY,PRIVATE
DQuantityLow       ANY,PRIVATE  !optional  at least one, low or high must be specified
DQuantityHigh      ANY,PRIVATE  !optional  at least one, low or high must be specified
DDiscountType      ANY,PRIVATE  !optional SimpleDisount, SteppedDiscount, Unitisation
DPercentDiscount   ANY,PRIVATE  !optional  at least one, percent discount or discounted amount must be specified
DDiscountedAmount  ANY,PRIVATE  !optional  at least one, percent discount or discounted amount must be specified
DDatelow           ANY,PRIVATE  !optional
DDateHigh          ANY,PRIVATE  !optional
DSpent             ANY,PRIVATE  !optional
DefaultType        ASTRING,PRIVATE
CurType            BYTE,PRIVATE
CurProductID       STRING(MaxProductID),PRIVATE
Q                  &CDiscountQueue
PQ                 &ProductQueue
NewInvoiceLine     BYTE
DiscountText       CSTRING(1024)

_GetDiscount       PROCEDURE(LONG Quantity,*DECIMAL Discount)
_FillProdDiscountQ PROCEDURE,BYTE,PRIVATE
_DiscountOnTotal   PROCEDURE,PRIVATE

AddItem            PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
CloseInvoice       PROCEDURE,DERIVED
TakeRecord         PROCEDURE,BYTE,DERIVED,PROC
  END

ShippingClass    CLASS(ModifierClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
PWeight                ANY,PROTECTED
FMSW                   &FileManager,PROTECTED
SWKey                  &KEY
SWMinWeight            ANY,PROTECTED
SWFixedShipping        ANY,PROTECTED
SWDest                 ANY,PROTECTED
SWProductID            ANY,PROTECTED
FMSC                   &FileManager,PROTECTED
SCKey                  &KEY
SCMinQuantity          ANY,PROTECTED  !optional - either SCMinQuantity or SCMinSpent must exist
SCMinSpent             ANY,PROTECTED  !optional - either SCMinQuantity or SCMinSpent must exist
SCShipping             ANY,PROTECTED
SCIsPercentage         ANY,PROTECTED  !optional - IF NULL SCShipping is fixed
SCDest                 ANY,PROTECTED  !optional
SCProductID            ANY,PROTECTED  !optional
PFixedWeightShipping   ANY,PROTECTED
FixedWeightShipping    ASTRING,PROTECTED
QFixedShipping         ASTRING,PROTECTED
QPercentShipping       ASTRING,PROTECTED
DestExpr               ASTRING,PROTECTED
EndResult              STRING(10),PROTECTED  ! Total, Maximum, Minimum
ValueSet               BYTE,PROTECTED
ValueFound             BYTE,PROTECTED
UseGenericProdID       BYTE,PRIVATE

AddItem                PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
GetShipping            PROCEDURE(LONG Quantity, *DECIMAL Cost, *DECIMAL QuantityFixedShipping, *DECIMAL QuantityPercentShipping, *DECIMAL SpentFixedShipping, *DECIMAL SpentPercentShipping),BYTE,PROTECTED
GetWeightShipping      PROCEDURE(*DECIMAL Weight, *DECIMAL Cost, *DECIMAL FixedShipping),BYTE,PROTECTED
TakeRecord             PROCEDURE,BYTE,DERIVED,PROC
  END

!needs to be called after SalesTax
ShippingOnInvoiceLine  CLASS(ShippingClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)

TakeRecord             PROCEDURE,BYTE,DERIVED,PROC
  END

!needs to be called after ShippingOnInvoiceLine
ShippingOnInvoice   CLASS(ShippingClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
OneOffFixedShipping    ASTRING,PRIVATE
RunningWeight          DECIMAL(31,10),PRIVATE
RunningQuantity        LONG,PRIVATE
OverRide               BYTE,PRIVATE
OverRideText           ASTRING,PRIVATE

_IncreasePerIL         PROCEDURE,PRIVATE

AddItem                PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
CloseInvoice           PROCEDURE,DERIVED
TakeRecord             PROCEDURE,BYTE,DERIVED,PROC
  END

!to be called before QuantityDiscount
CategoryDiscountClass CLASS(ModifierClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
FMPC                   &FileManager,PRIVATE
PCKey                  &KEY         !key on ProductID
PCProductID            ANY,PRIVATE
PCCategory             ANY,PRIVATE
FMCat                  &FileManager,PRIVATE
CatKey                 &KEY         !key on Category
CatCategory            ANY,PRIVATE
CatCategoryName        ANY,PRIVATE
CatDateLow             ANY,PRIVATE  !optional
CatDateHigh            ANY,PRIVATE  !optional
CatDiscount            ANY,PRIVATE
CatSupersedes          ANY,PRIVATE  !optional
NewIL                  BYTE,PRIVATE
CheckDone              BYTE,PRIVATE

AddItem                PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
TakeRecord             PROCEDURE,BYTE,DERIVED,PROC
  END


!to be called before sales tax
OptionsClass CLASS(ModifierClass),IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABINVOIC.CLW'),LINK('ABINVOIC.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
FMO                    &FileManager,PRIVATE
OKey                   &KEY         !key on ID and possibly ProductID
OID                    ANY,PRIVATE
OProductID             ANY,PRIVATE  !optional
ODescription           ANY,PRIVATE  !optional
OCost                  ANY,PRIVATE
OIsPercentage          ANY,PRIVATE  !optional
CLOptionID             ANY,PRIVATE
UseGenericProdID       BYTE,PRIVATE
NewIL                  BYTE,PRIVATE
CheckDone              BYTE,PRIVATE

_GetOptionCost         PROCEDURE(<ASTRING ProductID>),BYTE,PRIVATE

AddItem                PROCEDURE(ASTRING WhatItem, <*? Item>, <ASTRING Value>, <FileManager FM>, <KEY FileKey>),DERIVED
TakeRecord             PROCEDURE,BYTE,DERIVED,PROC
  END

  _EndOfInclude_
