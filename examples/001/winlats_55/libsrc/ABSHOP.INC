! Process server header module

!ABCIncludeFile(SHOP)

  OMIT('_EndOfInclude_',_ShopPresent_)
_ShopPresent_   EQUATE(1)
   INCLUDE('abfile.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE
ShopMaxIdLen   EQUATE(100)
ShopMaxItems   EQUATE(100)

StatsTracker CLASS,IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABSHOP.CLW'),LINK('ABSHOP.CLW',_ShopLinkMode_),DLL(_ShopDllMode_)
InvoiceId   ANY,PRIVATE
CustomerId  ANY,PRIVATE
Dte         ANY,PRIVATE
ProductId   ANY,PRIVATE
Quantity    ANY,PRIVATE
XFle        &FileManager,PRIVATE
XLeftId     ANY,PRIVATE
XRightId    ANY,PRIVATE
XQuantity   ANY,PRIVATE
XK          &KEY!,PRIVATE
IWoz        CSTRING(ShopMaxIdLen),PRIVATE   ! There is an argument for making this >> bigger or astrings
CWoz        CSTRING(ShopMaxIdLen),PRIVATE
PTrack      &ProductList,PRIVATE
CLst        CSTRING(ShopMaxIdLen),DIM(ShopMaxItems),PRIVATE
Cin         SIGNED,PRIVATE
DoneOne     BYTE,PRIVATE
AddProduct PROCEDURE(FileManager ProductStats, KEY K, *? Id, *? Quantity, LONG DateLow=0, LONG DateHigh=0) ! Track quantity sold between dates, K must be on Id field
Init       PROCEDURE   !,EXTENDS
Kill       PROCEDURE
! SetCross -requires- that records eventually appear in customer,invoice or invoice,customer order
SetCross   PROCEDURE(FileManager CrossStats, KEY K, *? LeftProductId, *? RightProductId, *? Quantity) ! K must be on LeftId,RightId
SetInvoice PROCEDURE(*? InvoiceId, *? ProductId, *? Quantity,<*? CustomerId>, <*? Dte>)
UpdateCrosses PROCEDURE,PRIVATE
  END

_EndOfInclude_
