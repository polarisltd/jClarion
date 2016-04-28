!ABCIncludeFile

  OMIT('_EndOfInclude_', _ReservationPresent_)
_ReservationPresent_  EQUATE(1)

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABRESERV.INT'),ONCE

  ITEMIZE(100),PRE(Msg)
LockError           EQUATE
FileAccessError     EQUATE
ReservationNotFound EQUATE
CapacityTooLow      EQUATE
  END

  ITEMIZE(10),PRE(ReservErr)
NotAvailable        EQUATE
NotInSequence       EQUATE
  END

  ITEMIZE(150),PRE(XMsg)
LockError           EQUATE
FileAccessError     EQUATE
ReservationNotFound EQUATE
InvalidReservation  EQUATE
  END
MaxProdIDLen    EQUATE(256)
MaxItemNoLen    EQUATE(256)

ReservationClass   CLASS,IMPLEMENTS(IReservation),TYPE,MODULE('ABReserv.CLW'),LINK('ABRESERV', _ShopLinkMode_),DLL(_ShopDllMode_)
Errors               &ErrorClass,PRIVATE
ErrorsCreated        BYTE,PRIVATE
FMP                  &FileManager,PRIVATE
FMR                  &FileManager,PRIVATE
PFCapacity           ANY,PRIVATE
PFKey                &KEY
PFProdID             ANY,PRIVATE
PFRStatus            ANY,PRIVATE  ! optional; 0: NonReservable, 1: Reservable, 2: AllReserved
PFRAvail             ANY,PRIVATE  ! optional
RFCustID             ANY,PRIVATE
RFEnum               ANY,PRIVATE
RFKey                &KEY  !key on product id
RFProdID             ANY,PRIVATE
RFResNo              ANY,PRIVATE

_AddPlaceHolders     PROCEDURE(LONG Quantity, ASTRING ProdID, ASTRING EnumSeed, ASTRING ResNoSeed),BYTE,PRIVATE
_Check               PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, *LONG ResNo, BYTE InSequence, <ASTRING StartFrom>, BYTE CheckOnly),BYTE,PRIVATE
_BeginTransaction    PROCEDURE,BYTE,PRIVATE
_ProdIsAvail         PROCEDURE(ASTRING ProdID),BYTE,PRIVATE
_UpdateCurProd       PROCEDURE(BYTE Status, LONG CntAvail),BYTE,PRIVATE
_UpdateCurProdAvail  PROCEDURE(ASTRING ProdID, LONG Delta),BYTE,PRIVATE
_UpdateProd          PROCEDURE(ASTRING ProdID,BYTE Status, LONG CntAvail, BYTE DoDelta=FALSE),BYTE,PRIVATE

HouseKeeping         PROCEDURE,BYTE,PROC
Init                 PROCEDURE(FileManager FMProd, FileManager FMReserv, KEY PFKey, *? PFProdID, *? PFCapacity, <*? PFRStatus>, <*? PFRAvail>, KEY RFKey, *? RFProdID, <*? RFEnum>, *? RFCustNo, *? RFResNo, <ErrorClass ErrorHandler>)  !,EXTENDS
Kill                 PROCEDURE
ProductReturn        PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, LONG ResNo),BYTE,PROC
!Reserve              PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, *LONG ResNo, BYTE InSequence=TRUE),BYTE
Reserve              PROCEDURE(ASTRING CustID, ASTRING ProdID, <ASTRING StartFrom>, LONG Quantity, *LONG ResNo, BYTE InSequence=TRUE),BYTE
                   END

FindItemQueue QUEUE,TYPE
ItemNo          STRING(MaxItemNoLen)
  END


FindQueue QUEUE,TYPE
ItemQ       &FindItemQueue
DateLow     LONG
TimeLow     LONG
  END


ReservationExtraClass   CLASS,TYPE,MODULE('ABReserv.CLW'),LINK('ABRESERV', _ShopLinkMode_),DLL(_ShopDllMode_)
Errors               &ErrorClass,PRIVATE
ErrorsCreated        BYTE,PRIVATE
FMP                  &FileManager,PRIVATE
FMR                  &FileManager,PRIVATE
PFKey                &KEY         !key on ProdID, ItemNo
PFProdID             ANY,PRIVATE
PFItemNo             ANY,PRIVATE
PFDateLow            ANY,PRIVATE
PFDateHigh           ANY,PRIVATE
PFTimeLow            ANY,PRIVATE
PFTimeHigh           ANY,PRIVATE
PFGranularity        ANY,PRIVATE  !optional
PFAhead              ANY,PRIVATE  !optional
RFPKey               &KEY         !key on ProdID, DateLow, TimeLow, and possibly ItemNo
RFIKey               &KEY         !key on ProdID, ItemNo, DateLow, TimeLow
RFRKey               &KEY         !key on ResNo, ProdID, ItemNo, DateLow, TimeLow
RFProdID             ANY,PRIVATE
RFCustID             ANY,PRIVATE
RFResNo              ANY,PRIVATE
RFItemNo             ANY,PRIVATE
RFDateLow            ANY,PRIVATE
RFTimeLow            ANY,PRIVATE
RFDateHigh           ANY,PRIVATE
RFTimeHigh           ANY,PRIVATE
RFGranularity        ANY,PRIVATE  !optional
RFStatus             ANY,PRIVATE  ! 1=Invalid, 2=invalid or historic

_AddFoundItem        PROCEDURE(FindQueue Q1, ASTRING ItemNo, LONG DL, LONG TL, USHORT Quantity),BYTE,PRIVATE
_AddRecord           PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG Granularity, LONG ResNo),BYTE,PRIVATE
_BeginTransaction    PROCEDURE,BYTE,PRIVATE
_BuildProdQ          PROCEDURE(XProdQueue PQ, BYTE AdjustDateLow),PRIVATE
_CalculateNewDateTime PROCEDURE(LONG DateLow, LONG TimeLow, REAL Duration, *LONG DateHigh, *LONG TimeHigh, BYTE Adjustment=0),PRIVATE
_CheckRecord         PROCEDURE(XProdQueue PQ, ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, ASTRING ResNo),BYTE,PRIVATE
!_GetNextPrevTime     PROCEDURE(*LONG D, *LONG T, BYTE Prev)
_GetTimeDifference   PROCEDURE(LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh),REAL,PRIVATE
_Merge               PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG Granularity, BYTE Prev),BYTE,PRIVATE
_MergeRecords        PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG Granularity),BYTE,PRIVATE
_Return              PROCEDURE(LONG ResNo),BYTE,PRIVATE
_SyncRF              PROCEDURE(XProdQueue PQ),BYTE,PRIVATE
_SyncPQ              PROCEDURE(XProdQueue PQ),BYTE,PRIVATE


Find                 PROCEDURE(ASTRING ProdID, FindQueue Q1, USHORT Quantity, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG DurationMinutes=60, BYTE MaxSuggestions=10),BYTE,PROC
Housekeeping         PROCEDURE(BYTE AdjustDateLow=TRUE),BYTE,PROC
Init                 PROCEDURE(FileManager FMProd, FileManager FMReserv, KEY PFKey, *? PFProdID, *? PFItemNo, *? PFDateLow, *? PFTimeLow, *? PFDateHigh, *? PFTimeHigh, <*? PFGranularity>, <*? PFAhead>, KEY RFProdKey, KEY RFItemKey, KEY RFReservKey, *? RFProdID, *? RFCustNo, *? RFResNo, *? RFItemNo, *? RFDateLow, *? RFTimeLow, *? RFDateHigh, *? RFTimeHigh, <*? RFGranularity>, *? RFStatus, <ErrorClass ErrorHandler>)
Kill                 PROCEDURE
ProductReturn        PROCEDURE(LONG ResNo),BYTE
Reserve              PROCEDURE(ASTRING ProdID, ASTRING CustID, FindItemQueue Q, LONG DateLow, LONG TimeLow, LONG DurationMinutes, *LONG ResNo),BYTE
                   END


  _EndOfInclude_
