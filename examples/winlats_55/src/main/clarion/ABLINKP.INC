!ABCIncludeFile(LINKP)

OMIT('_EndOfInclude_',_LinkPoint_)
_LinkPoint_ EQUATE(1)

!* Errorcodes.

Succeed      EQUATE(1)
Fail         EQUATE(0)
Unused       EQUATE(0)
BaseErr      EQUATE(1000)

  ITEMIZE(1),PRE(Msg)
OrderProcess     EQUATE
AddItem          EQUATE
Shipping         EQUATE
Tax              EQUATE
Option           EQUATE
  END

LinkPointErrors GROUP
Number USHORT(5)
       USHORT(Msg:OrderProcess)
       BYTE(Level:Notify)
       PSTRING('LinkPoint Order Processing Error')
       PSTRING('%Message')
       USHORT(Msg:AddItem)
       BYTE(Level:Notify)
       PSTRING('LinkPoint AddItem Error')
       PSTRING('%Message')
       USHORT(Msg:Shipping)
       BYTE(Level:Notify)
       PSTRING('LinkPoint Shipping Error')
       PSTRING('%Message')
       USHORT(Msg:Tax)
       BYTE(Level:Notify)
       PSTRING('LinkPoint Tax Error')
       PSTRING('%Message')
       USHORT(Msg:Option)
       BYTE(Level:Notify)
       PSTRING('LinkPoint Item Option Error')
       PSTRING('%Message')
              END



!* Request types possible for OrderField_Chargetype
Chargetype_Auth     EQUATE(0)
Chargetype_Sale     EQUATE(0)
Chargetype_Preauth  EQUATE(1)
Chargetype_Postauth EQUATE(2)
Chargetype_Credit   EQUATE(3)
Chargetype_Error    EQUATE(0)

!* Result types possilbe for OrderField_Result
Result_Live         EQUATE(0)
Result_Good         EQUATE(1)
Result_Duplicate    EQUATE(2)
Result_Decline      EQUATE(3)

!* ESD types for ItemField_Esdtype
Esdtype_None        EQUATE(0)
Esdtype_Softgood    EQUATE(1)
Esdtype_Key         EQUATE(2)

MAX_OPTIONS  EQUATE(10)
MAX_ITEMS    EQUATE(25)

ReqField_t  ITEMIZE(0)
ReqField_Configfile EQUATE
ReqField_Keyfile    EQUATE
ReqField_Appname    EQUATE
ReqField_Host       EQUATE
ReqField_Port       EQUATE
            END

ItemField_t ITEMIZE(0)
ItemField_Itemid      EQUATE
ItemField_Description EQUATE
ItemField_Price       EQUATE
ItemField_Quantity    EQUATE
ItemField_Softfile    EQUATE
ItemField_Esdtype     EQUATE
ItemField_Serial      EQUATE
ItemField_MaxOptions  EQUATE
            END

ShippingField_t ITEMIZE(0)
ShippingField_Country EQUATE
ShippingField_State   EQUATE
ShippingField_Total   EQUATE
ShippingField_Items   EQUATE
ShippingField_Weight  EQUATE
ShippingField_Carrier EQUATE

  ! Responses
ShippingField_R_Total EQUATE
                END

TaxField_t ITEMIZE(0)
TaxField_State        EQUATE
TaxField_Zip          EQUATE
TaxField_Total        EQUATE

  ! Responses
TaxField_R_Total      EQUATE
           END

OptionField_t ITEMIZE(0)
OptionField_Option    EQUATE
OptionField_Choice    EQUATE
              END

OrderField_t ITEMIZE(0)
OrderField_Oid        EQUATE
OrderField_Userid     EQUATE
OrderField_Bcompany   EQUATE
OrderField_Bcountry   EQUATE
OrderField_Bname      EQUATE
OrderField_Baddr1     EQUATE
OrderField_Baddr2     EQUATE
OrderField_Bcity      EQUATE
OrderField_Bstate     EQUATE
OrderField_Bzip       EQUATE
OrderField_Sname      EQUATE
OrderField_Saddr1     EQUATE
OrderField_Saddr2     EQUATE
OrderField_Scity      EQUATE
OrderField_Sstate     EQUATE
OrderField_Szip       EQUATE
OrderField_Scountry   EQUATE
OrderField_Phone      EQUATE
OrderField_Fax        EQUATE
OrderField_Refer      EQUATE
OrderField_Shiptype   EQUATE
OrderField_Shipping   EQUATE
OrderField_Tax        EQUATE
OrderField_Subtotal   EQUATE
OrderField_Vattax     EQUATE
OrderField_Comments   EQUATE
OrderField_MaxItems   EQUATE
OrderField_Email      EQUATE
OrderField_Cardnumber EQUATE
OrderField_Expmonth   EQUATE
OrderField_Expyear    EQUATE
OrderField_Chargetype EQUATE
OrderField_Chargetotal EQUATE
OrderField_Referencenumber EQUATE
OrderField_Result     EQUATE
OrderField_Addrnum    EQUATE
OrderField_Ip         EQUATE

  ! Responses
OrderField_R_Time     EQUATE
OrderField_R_Ref      EQUATE
OrderField_R_Approved EQUATE
OrderField_R_Code     EQUATE
OrderField_R_Ordernum EQUATE
OrderField_R_Error    EQUATE
OrderField_R_FraudCode EQUATE
    END

Reqgp    GROUP,TYPE
ConfigFile CSTRING(40)   ! Config File to use, same as Merchant config file without the .config extension.
KeyField   CSTRING(1024) ! Full Path and Filename of the Private Key.
Host       CSTRING(40)   ! Name of the server that ssl is running on.
Port       LONG          ! Port the ssl server is listening on defaults to 1139
          END

optiongp  GROUP,TYPE
option     CSTRING(254) 
choice     CSTRING(254) 
          END

itemgp    GROUP,TYPE
itemnum     LONG
itemid      CSTRING(254) 
description CSTRING(254) 
price       SREAL 
quantity    LONG 
softfile    CSTRING(254) 
esdtype     LONG 
serial      CSTRING(80) 
option      GROUP(optiongp),DIM(MAX_OPTIONS).
noptions    ULONG 
          END

itemqueue QUEUE,TYPE
itemid      CSTRING(254) 
description CSTRING(254) 
price       SREAL 
quantity    LONG 
softfile    CSTRING(254) 
esdtype     LONG 
serial      CSTRING(80) 
option      GROUP(optiongp),DIM(MAX_OPTIONS).
noptions    ULONG 
          END

Ordergp  GROUP,TYPE
oid         CSTRING(100)
ip          CSTRING(20)
userid      CSTRING(254)
bname       CSTRING(254)
bcompany    CSTRING(254)
baddr1      CSTRING(254)
baddr2      CSTRING(254)
bcity       CSTRING(254)
bstate      CSTRING(254)
bzip        CSTRING(254)
bcountry    CSTRING(5)
sname       CSTRING(254)
saddr1      CSTRING(254)
saddr2      CSTRING(254)
scity       CSTRING(254)
sstate      CSTRING(254)
szip        CSTRING(254)
scountry    CSTRING(5)
phone       CSTRING(254)
fax         CSTRING(254)
refer       CSTRING(254)
shiptype    CSTRING(50)
total       SREAL
shipping    SREAL
tax         SREAL
subtotal    SREAL
vattax      SREAL
comments    CSTRING(254)
cardnumber  CSTRING(24)
expmonth    CSTRING(3)
expyear     CSTRING(3)
email       CSTRING(80)
chargetotal SREAL
addrnum     CSTRING(10) ! required if using AVS.
item        GROUP(itemgp),DIM(MAX_ITEMS).
nitems      ULONG
          END

taxgp     GROUP,TYPE
State      CSTRING(3)
Zip        CSTRING(6)
Total      SREAL
Merchant   CSTRING(40)
          END

Shippinggp GROUP,TYPE
country     CSTRING(3)
State       CSTRING(3)
Total       SREAL
Items       LONG
Weight      SREAL
Carrier     LONG
Merchant    CSTRING(40)
           END


LinkPointClass CLASS,TYPE,MODULE('ABLINKP.CLW'),LINK('ABLINKP.CLW',_LinkPointLinkMode_),DLL(_LinkPointDllMode_)
ReqCtx     LONG,PRIVATE
OrderCtx   LONG,PRIVATE
OptionCtx  LONG,PRIVATE
ShippingCtx LONG,PRIVATE
ItemCtx    LONG,PRIVATE
TaxCtx     LONG,PRIVATE
ChargeType LONG
Errors     &ErrorClass,PROTECTED
Result     LONG
Req        GROUP(Reqgp).
Order      GROUP(ordergp).
Item       GROUP(Itemgp).
Option     GROUP(Optiongp).
Tax        GROUP(Taxgp).
Shipping   GROUP(Shippinggp).
Items      &ItemQueue,PRIVATE

AddItems             PROCEDURE,BYTE,PRIVATE
AddItem              PROCEDURE(STRING itemid, STRING description, ? price, ? quantity)
AddItemOptions       PROCEDURE(STRING option, STRING choice)
AddSoftgood          PROCEDURE(STRING itemid, STRING description, ? price, ? quantity, STRING softfile)
AddDownloadSoftgood  PROCEDURE(STRING itemid, STRING description, ? price, ? quantity, STRING softfile, STRING serial)
AddOptions           PROCEDURE(),BYTE,PRIVATE
Allocate             PROCEDURE(),PRIVATE
CalculateShipping    PROCEDURE(STRING Country, STRING State, ? Total, ? Items, ? Weight, LONG Carrier, *? ShippingTotal),BYTE
Free                 PROCEDURE(),PRIVATE
FreeItems            PROCEDURE()
Init                 PROCEDURE(ErrorClass Errors),VIRTUAL
Kill                 PROCEDURE,VIRTUAL
ProcessOrder         PROCEDURE,BYTE
ProcessShipping      PROCEDURE(STRING Country, STRING State, SREAL Total, SREAL Items, SREAL Weight, LONG Carrier, LONG ShippingCtx, *? ShippingTotal),BYTE,PRIVATE
ProcessTax           PROCEDURE,BYTE,PRIVATE
               END

_EndOfInclude_
