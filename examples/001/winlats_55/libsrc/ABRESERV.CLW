  MEMBER

  INCLUDE('ABRESERV.INC'),ONCE
  INCLUDE('ABRESERV.TRN'),ONCE

  MAP
  END

XProdQueue QUEUE,TYPE
ProdID       CSTRING(MaxProdIDLen)
ItemNo       CSTRING(MaxItemNoLen)
DateLow      LONG
TimeLow      LONG
DateHigh     LONG
TimeHigh     LONG
Granularity  LONG
    END


ReservationClass.Init PROCEDURE(FileManager FMProd, FileManager FMReserv, KEY PFKey, *? PFProdID, *? PFCapacity, <*? PFRStatus>, <*? PFRAvail>, KEY RFKey, *? RFProdID, <*? RFEnum>, *? RFCustID, *? RFResNo, <ErrorClass ErrorHandler>)
  CODE
    SELF.FMP &= FMProd
    SELF.FMR &= FMREserv
    IF NOT OMITTED(14)
      SELF.Errors &= ErrorHandler
    ELSE
      SELF.Errors &= NEW ErrorClass
      SELF.Errors.Init
      SELF.ErrorsCreated = TRUE
    END
    SELF.Errors.AddErrors(ABReservErrors)
    SELF.PFKey &= PFKey
    SELF.PFProdID &= PFProdID                 !ProdID in Product file must be unique
    SELF.PFCapacity &= PFCapacity
    IF NOT OMITTED(7)
      SELF.PFRStatus &= PFRStatus
    END
    IF NOT OMITTED(8)
      SELF.PFRAvail &= PFRAvail
    END
    SELF.RFKey &= RFKey
    SELF.RFProdID &= RFProdID
    IF NOT OMITTED(11)
      SELF.RFEnum &= RFEnum
    END
    SELF.RFCustID &= RFCustID
    SELF.RFResNo &= RFResNo


ReservationClass.Kill PROCEDURE
  CODE
    IF SELF.ErrorsCreated
      SELF.Errors.Kill
      DISPOSE(SELF.Errors)
      SELF.ErrorsCreated = FALSE
    END


ReservationClass.HouseKeeping PROCEDURE
PQ          Queue
ProdID        CSTRING(MaxProdIDLen)
Capacity      LONG
Status        BYTE
            END
Delete      BYTE
CntReserv   LONG
CntPlaceH   LONG
SvProdID    CSTRING(MaxProdIDLen)
ret         BYTE,AUTO
  CODE
    SELF.Errors.LogErrors=TRUE
    SELF.Errors.Silent=TRUE
    ASSERT(SELF.FMP.UseFile(UseType:Uses)=Level:Benign)
    ASSERT(SELF.FMR.UseFile()=Level:Benign)
    DO BuildProdQ
    ret = SELF._BeginTransaction()
    IF ret <> Level:Benign THEN RETURN ret.
    SET(SELF.RFKey)
    LOOP WHILE SELF.FMR.NEXT() = Level:Benign
      IF SELF.RFProdID <> SvProdID
        IF ~Delete AND SvProdID THEN
          SvProdID = SELF.RFProdID
          DO ProcessPrevProdID
          SELF.RFProdID = SvProdID
        END
        COMMIT             !batch for one ProdID ends
        ret = SELF._BeginTransaction()
        IF ret <> Level:Benign THEN RETURN ret.
        SELF.FMR.ClearKey(SELF.RFKey,2)
        SET(SELF.RFKey,SELF.RFKey)
        IF SELF.FMR.NEXT()<>Level:Benign
          ROLLBACK
          RETURN Level:Notify
        END
        SvProDID = SELF.RFProdID
        PQ.ProdID = SELF.RFProdID
        GET(PQ,PQ.ProdID)
        IF ERRORCODE()
          Delete = TRUE
        ELSE
          DELETE(PQ)
          Delete = FALSE
        END
      END
      IF Delete
        DELETE(SELF.FMR.File)
        IF ERRORCODE() THEN
          ROLLBACK
          RETURN SELF.Errors.ThrowMessage(Msg:FileAccessError,'DELETE on file '&CLIP(SELF.FMR.GetName()))
        END
      ELSE
        IF SELF.RFCustID OR SELF.RFCustID<>'' THEN CntReserv += 1 ELSE CntPlaceH += 1 END
      END
    END
    IF ~Delete AND SvProdID THEN
      DO ProcessPrevProdID
    END
    COMMIT
    DO AddRemainingPlaceholders
    SELF.Errors.LogErrors=FALSE
    SELF.Errors.Silent=FALSE
    RETURN Level:Benign

BuildProdQ ROUTINE
  SET(SELF.PFKey)
  LOOP WHILE SELF.FMP.TryNEXT() = Level:Benign
    IF ~SELF.PFRStatus &= NULL AND SELF.PFRStatus AND SELF.PFCapacity
      PQ.ProdID = SELF.PFProdID
      PQ.Capacity = SELF.PFCapacity
      PQ.Status = SELF.PFRStatus
      ADD(PQ,PQ.ProdID)
    ELSE
      IF SELF._UpdateCurProd(0,0)<>Level:Benign THEN RETURN Level:Notify END
    END
  END
  CLEAR(PQ)

AddRemainingPlaceholders ROUTINE
  DATA
I USHORT,AUTO
  CODE
    IF RECORDS(PQ)
      ret = SELF._BeginTransaction()
      IF Level:Benign THEN RETURN ret.
      LOOP I=1 TO RECORDS(PQ)
        GET(PQ,I)
        ret = SELF._AddPlaceHolders(PQ.Capacity, PQ.ProdID, 1, 1)
        IF ret <> Level:Benign THEN RETURN ret .
        IF SELF._UpdateProd(PQ.ProdID,1,PQ.Capacity)<>Level:Benign THEN RETURN Level:Notify END
      END
      COMMIT
    END

ProcessPrevProdID ROUTINE
  DATA
CurTotal LONG,AUTO
  CODE
  CurTotal = CntReserv + CntPlaceH
  IF PQ.Capacity <> CurTotal
    IF PQ.Capacity < CntReserv
      SELF.Errors.ThrowMessage(Msg:CapacityTooLow, CntReserv-PQ.Capacity)
    ELSE
      IF PQ.Capacity > CurTotal
        ret = SELF._AddPlaceHolders(PQ.Capacity-CurTotal, PQ.ProdID, CurTotal+1, CurTotal+1)
        IF ret<>Level:Benign THEN RETURN ret .
      ELSIF PQ.Capacity < CurTotal AND PQ.Capacity > CntReserv         !delete CurTotal - PQ.Capacity placeholders from RF
        LOOP
          IF SELF.FMR.TRYPREVIOUS() <> Level:Benign
            ROLLBACK
            RETURN SELF.Errors.ThrowMessage(Msg:FileAccessError,'PREVIOUS on file '&CLIP(SELF.FMR.GetName()))
          END
          IF ~SELF.RFCustID OR SELF.RFCustID=''
            DELETE(SELF.FMR.File)
            IF ERRORCODE()
              ROLLBACK
              RETURN SELF.Errors.ThrowMessage(Msg:FileAccessError,'DELETE on file '&CLIP(SELF.FMR.GetName()))
            END
            CurTotal -= 1
          END
        UNTIL CurTotal = PQ.Capacity
        CntPlaceH = CurTotal-CntReserv
      END
    END
  END
  IF CntPlaceH AND PQ.Status=2 OR ~CntPlaceH AND PQ.Status=1
    IF SELF._UpdateProd(PQ.ProdID,CHOOSE(CntPlaceH>0,1,2),CntPlaceH)<>Level:Benign THEN RETURN Level:Notify END
  END
  CLEAR(CntReserv)
  CLEAR(CntPlaceH)


ReservationClass._UpdateProd PROCEDURE(ASTRING ProdID, BYTE Status, LONG Cnt, BYTE DoDelta)
  CODE
    IF ~SELF.PFRStatus &= NULL OR ~SELF.PFRAvail &= NULL
      SELF.FMP.ClearKey(SELF.PFKey,2)
      SELF.PFProdID=ProdID
      IF SELF.FMP.Fetch(SELF.PFKey)=Level:Benign
        IF ~DoDelta
          IF SELF._UpdateCurProd(Status, Cnt)<>Level:Benign THEN RETURN Level:Notify END
        ELSE
          IF SELF._UpdateCurProdAvail(ProdID, Cnt)<>Level:Benign THEN RETURN Level:Notify END
        END
      ELSE
        ROLLBACK
        RETURN Level:NOTIFY
      END
    END
    RETURN Level:Benign

ReservationClass._UpdateCurProd PROCEDURE(BYTE Status, LONG CntAvail)
Work BYTE
  CODE
    IF ~SELF.PFRStatus &= NULL AND SELF.PFRStatus <> Status
      SELF.PFRStatus = Status
      Work = TRUE
    END
    IF ~SELF.PFRAvail &= NULL AND SELF.PFRAvail <> CntAvail
      SELF.PFRAvail = CntAvail
      Work = TRUE
    END
    IF Work AND SELF.FMP.Update()<>Level:Benign
      ROLLBACK
      RETURN Level:Notify
    END
    RETURN Level:Benign


ReservationClass._UpdateCurProdAvail PROCEDURE(ASTRING ProdID, LONG Delta)
Work BYTE
  CODE
    IF ~SELF.PFRAvail &= NULL
      SELF.PFRAvail += Delta
      IF ~SELF.PFRStatus&=NULL
        SELF.PFRStatus=CHOOSE(~SELF.PFRAvail,2,1)
      END
      Work=TRUE
    ELSE
      IF ~SELF.PFRStatus&=NULL
        SELF.PFRStatus = SELF._ProdIsAvail(ProdID)
        Work=TRUE
      END
    END
    IF Work AND SELF.FMP.Update()<>Level:Benign
      ROLLBACK
      RETURN Level:Notify
    END
    RETURN Level:Benign


ReservationClass._ProdIsAvail PROCEDURE(ASTRING ProdID)
  CODE
    SELF.FMR.ClearKey(SELF.RFKey,2)
    SELF.RFProdID = ProdID
    SET(SELF.RFKey,SELF.RFKey)
    LOOP
      IF SELF.FMR.NEXT() <> Level:Benign OR SELF.RFProdID <> ProdID
        BREAK
      END
      IF ~SELF.RFCustID OR SELF.RFCustID=''
        RETURN 1
      END
    END
    RETURN 2


ReservationClass._AddPlaceHolders PROCEDURE(LONG Quantity, ASTRING ProdID, ASTRING EnumSeed, ASTRING ResNoSeed)
  CODE
    SELF.FMR.PrimeRecord()
    IF NOT SELF.RFEnum &= NULL THEN SELF.RFEnum = EnumSeed.
    SELF.RFResNo = ResNoSeed
    SELF.RFProdID = ProdID
    LOOP Quantity TIMES
      IF SELF.FMR.TryInsert() <> Level:Benign
        ROLLBACK
        RETURN SELF.Errors.ThrowMessage(Msg:FileAccessError,'INSERT on file '&CLIP(SELF.FMR.GetName()))
      END
      IF NOT SELF.RFEnum &= NULL THEN SELF.RFEnum += 1.
      SELF.RFResNo += 1
    END
    RETURN Level:Benign


ReservationClass._BeginTransaction PROCEDURE
  CODE
    LOOP 100 TIMES
      LOGOUT(1,SELF.FMR.File,SELF.FMP.File)
      CASE ERRORCODE()
      OF 32
        CYCLE
      OF 0
        RETURN Level:Benign
      ELSE
        BREAK
      END
    END
    RETURN SELF.Errors.ThrowMessage(Msg:LockError, ERRORCODE())


ReservationClass.IReservation.Reserve PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, *LONG ResNo, BYTE InSequence)
  CODE
    RETURN SELF.Reserve(CustID, ProdID,, Quantity, ResNo, InSequence)


ReservationClass.IReservation.Reserve PROCEDURE(ASTRING CustID, ASTRING ProdID, <ASTRING Enum>, LONG Quantity, *LONG ResNo, BYTE InSequence)
  CODE
    IF OMITTED(4)
      RETURN SELF.Reserve(CustID, ProdID,, Quantity, ResNo, InSequence)
    ELSE
      RETURN SELF.Reserve(CustID, ProdID, Enum, Quantity, ResNo, InSequence)
    END


ReservationClass.Reserve PROCEDURE(ASTRING CustID, ASTRING ProdID, <ASTRING Enum>, LONG Quantity, *LONG ResNo, BYTE InSequence)
ret BYTE,AUTO
  CODE
    IF SELF._BeginTransaction() <> Level:Benign THEN RETURN Level:Notify.
    IF OMITTED(4)
      ret = SELF._Check(CustID, ProdID, Quantity, ResNo, InSequence,, TRUE)
      IF ret = Level:Benign
        ret = SELF._Check(CustID, ProdID, Quantity, ResNo, InSequence,, FALSE)
      END
    ELSE
      ret = SELF._Check(CustID, ProdID, Quantity, ResNo, InSequence, Enum, TRUE)
      IF ret = Level:Benign
        ret = SELF._Check(CustID, ProdID, Quantity, ResNo, InSequence, Enum, FALSE)
      END
    END
    RETURN ret


ReservationClass._Check PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, *LONG ResNo, BYTE InSequence, <ASTRING Enum>, BYTE CheckOnly)
Processing BYTE
MyResNo    LONG,AUTO
svQ        LONG,AUTO
  CODE
    svQ=Quantity*-1
    SELF.FMR.ClearKey(SELF.RFKey,2)
    SELF.RFProdID = ProdID
    SET(SELF.RFKey,SELF.RFKey)
    LOOP
      IF SELF.FMR.NEXT() <> Level:Benign OR SELF.RFProdID <> ProdID
        ROLLBACK
        RETURN ReservErr:NotAvailable
      END
      IF ~SELF.RFCustID OR SELF.RFCustID=''
        IF ~Processing AND (OMITTED(7) OR Enum=SELF.RFEnum)
          Processing = TRUE  !on first reservation
          IF ~CheckOnly
            MyResNo = SELF.RFResNo
          END
        END
        IF Processing
          Quantity -= 1      !on every reservation
          IF ~CheckOnly
            SELF.RFCustID = CustID
            IF SELF.FMR.Update()<>Level:Benign
              ROLLBACK
              RETURN Level:Notify
            END
          END
          IF Quantity=0
            IF ~CheckOnly
              ResNo = MyResNo
              IF SELF._UpdateProd(ProdID, 0, svQ, TRUE) <> Level:Benign THEN RETURN Level:Notify END
            END
            COMMIT
            RETURN Level:Benign
          END
        END
      ELSE
        IF Processing AND InSequence
          ROLLBACK
          RETURN ReservErr:NotInSequence
        END
      END
    END


ReservationClass.IReservation.ProductReturn PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, LONG ResNo)
  CODE
    RETURN SELF.ProductReturn(CustID, ProdID, Quantity, ResNo)


ReservationClass.ProductReturn PROCEDURE(ASTRING CustID, ASTRING ProdID, LONG Quantity, LONG ResNo)
Found BYTE
svQ   LONG,AUTO
  CODE
    svQ=Quantity
    IF SELF._BeginTransaction() <> Level:Benign THEN RETURN Level:Notify.
    SELF.FMR.ClearKey(SELF.RFKey,2)
    SELF.RFProdID = ProdID
    SET(SELF.RFKey,SELF.RFKey)
    LOOP
      IF SELF.FMR.NEXT() <> Level:Benign OR SELF.RFProdID <> ProdID
        ROLLBACK
        RETURN SELF.Errors.ThrowMessage(Msg:ReservationNotFound, Quantity)
      END
      IF CustID = SELF.RFCustID
        IF ResNo = SELF.RFResNo
          Found = TRUE
        END
        IF Found
          Quantity -= 1
          CLEAR(SELF.RFCustID)
          IF SELF.FMR.Update()<>Level:Benign
            ROLLBACK
            RETURN Level:Notify
          END
        END
      END
      IF ~Quantity THEN
        IF SELF._UpdateProd(ProdID, 0, svQ, TRUE) <> Level:Benign THEN RETURN Level:Notify END
        COMMIT
        RETURN Level:Benign
      END
    END

!-----------------------------------------------------------------------------------------------------------------------

ReservationExtraClass.Init PROCEDURE(FileManager FMProd, FileManager FMReserv, KEY PFKey, *? PFProdID, *? PFItemNo, *? PFDateLow, *? PFTimeLow, *? PFDateHigh, *? PFTimeHigh, <*? PFGranularity>, <*? PFAhead>, KEY RFProdKey, KEY RFItemKey, KEY RFReservKey, *? RFProdID, *? RFCustNo, *? RFResNo, *? RFItemNo, *? RFDateLow, *? RFTimeLow, *? RFDateHigh, *? RFTimeHigh, <*? RFGranularity>, *? RFStatus, <ErrorClass ErrorHandler>)
  CODE
    SELF.FMP &= FMProd
    SELF.FMR &= FMReserv
    IF NOT OMITTED(26)
      SELF.Errors &= ErrorHandler
    ELSE
      SELF.Errors &= NEW ErrorClass
      SELF.Errors.Init
      SELF.ErrorsCreated = TRUE
    END
    SELF.Errors.AddErrors(ABReservXErrors)
    SELF.PFKey &= PFKey
    SELF.PFProdID &= PFProdID
    SELF.PFItemNo &= PFItemNo
    SELF.PFDateLow &= PFDateLow
    SELF.PFDateHigh &= PFDateHigh
    SELF.PFTimeLow &= PFTimeLow
    SELF.PFTimeHigh &= PFTimeHigh
    IF NOT OMITTED(11)
      SELF.PFGranularity &= PFGranularity
    END
    IF NOT OMITTED(12)
      SELF.PFAhead &= PFAhead
    END
    SELF.RFPKey &= RFProdKey
    SELF.RFIKey &= RFItemKey
    SELF.RFRKey &= RFReservKey
    SELF.RFProdID &= RFProdID
    SELF.RFCustID &= RFCustNo
    SELF.RFResNo &= RFResNo
    SELF.RFItemNo &= RFItemNo
    SELF.RFDateLow &= RFDateLow
    SELF.RFTimeLow &= RFTimeLow
    SELF.RFDateHigh &= RFDateHigh
    SELF.RFTimeHigh &= RFTimeHigh
    IF NOT OMITTED(24)
      SELF.RFGranularity &= RFGranularity
    END
    SELF.RFStatus &= RFStatus
?   ASSERT(SELF.FMP.UseFile()=Level:Benign,'FileManager.UseFile() on Product File failed!')
?   ASSERT(SELF.FMR.UseFile()=Level:Benign,'FileManager.UseFile() on Reservation File failed!')


ReservationExtraClass.Kill PROCEDURE
  CODE
    IF SELF.ErrorsCreated
      DISPOSE(SELF.Errors)
      SELF.ErrorsCreated = FALSE
    END

ReservationExtraClass.Housekeeping PROCEDURE(BYTE AdjustDateLow)
PQ  XProdQueue
ret BYTE,AUTO
  CODE
    SELF.Errors.LogErrors=TRUE
    SELF.Errors.Silent=TRUE
    SELF._BuildProdQ(PQ, AdjustDateLow)
    ret = SELF._SyncRF(PQ)
    ret = CHOOSE(SELF._SyncPQ(PQ)=Level:Benign,ret,Level:Notify)
    RETURN ret

ReservationExtraClass._BuildProdQ PROCEDURE(XProdQueue PQ, BYTE AdjustDateLow)
  CODE
    SET(SELF.PFKey)
    LOOP WHILE SELF.FMP.TryNEXT() = Level:Benign
      PQ.ProdID = SELF.PFProdID
      PQ.ItemNo = SELF.PFItemNo
      PQ.DateLow = CHOOSE(AdjustDateLow AND SELF.PFDateLow<TODAY(),TODAY(),SELF.PFDateLow)
      PQ.TimeLow = CHOOSE(~SELF.PFTimeLow,1,SELF.PFTimeLow)
      PQ.DateHigh = CHOOSE(SELF.PFAhead&=NULL OR SELF.PFAhead=0 OR PQ.DateLow+SELF.PFAhead>SELF.PFDateHigh,SELF.PFDateHigh,PQ.DateLow+SELF.PFAhead)
      PQ.TimeHigh = CHOOSE(~SELF.PFTimeHigh,8640000,SELF.PFTimeHigh)
      PQ.Granularity = SELF.PFGranularity
      ADD(PQ,PQ.ProdID,PQ.ItemNo,PQ.DateLow,PQ.TimeLow)
    END

ReservationExtraClass._SyncRF PROCEDURE(XProdQueue PQ)
ret         BYTE
Skip        BYTE
SvProdID    CSTRING(MaxProdIDLen)
SvItemNo    CSTRING(MaxItemNoLen)
CheckRes    BYTE,AUTO
  CODE
    SET(SELF.RFIKey)
    LOOP WHILE SELF.FMR.NEXT() = Level:Benign
      IF SELF.RFProdID <> SvProdID
        Skip=FALSE
        COMMIT             !batch for one ProdID, ItemID ends
        IF SELF._BeginTransaction()<>Level:Benign
          RETURN Level:Notify
        END
        SELF.FMR.ClearKey(SELF.RFIKey,3)
        SET(SELF.RFIKey,SELF.RFIKey)
        IF SELF.FMR.NEXT()<>Level:Benign
          ROLLBACK
          RETURN Level:Notify
        END
        SvProDID = SELF.RFProdID
        SvItemNo = SELF.RFItemNo
      END
      IF ~Skip
        CheckRes = SELF._CheckRecord(PQ,SELF.RFProdID,SELF.RFItemNo,SELF.RFDateLow,CHOOSE(SELF.RFTimeLow=0,1,SELF.RFTimeLow),SELF.RFDateHigh, SELF.RFTimeHigh, SELF.RFResNo)
        CASE CheckRes
        OF 1 TO 3
        OROF 5 TO 6
          IF ~SELF.RFResNo
            DELETE(SELF.FMR.File)
            IF ERRORCODE()
              ROLLBACK
              ret = SELF.Errors.ThrowMessage(XMsg:FileAccessError,'DELETE on file '&CLIP(SELF.FMR.GetName()))
              Skip=TRUE
            END
          ELSE
            SELF.RFStatus=CHOOSE(CheckRes=6 OR CheckRes=2,2,1)
            DO UpdateFile
            ret = SELF.Errors.ThrowMessage(XMsg:InvalidReservation, SELF.RFStatus)
          END
        OF 0
        OROF 4
          IF SELF.RFStatus
            CLEAR(SELF.RFStatus)  !make valid
            DO UpdateFile
          END
        END
      END
    END
    COMMIT
    RETURN ret


UpdateFile ROUTINE
  IF SELF.FMR.Update()<>Level:Benign
    ret=Level:Notify
    ROLLBACK
    Skip=TRUE
  END


ReservationExtraClass._CheckRecord PROCEDURE(XProdQueue PQ, ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, ASTRING ResNo)
I ULONG,AUTO
  CODE
    PQ.ProdID=SELF.RFProdID
    PQ.ItemNo=SELF.RFItemNo
    GET(PQ,PQ.ProdID,PQ.ItemNo)
    IF ~ERRORCODE()
      LOOP I=POINTER(PQ) TO RECORDS(PQ)
        GET(PQ,I)
        ASSERT(~ERRORCODE())
        IF PQ.ProdID<>ProdID OR PQ.ItemNo<>ItemNo
          RETURN 1 ! Date/Time too high
        ELSIF PQ.DateLow>DateHigh OR PQ.DateLow=DateHigh AND PQ.TimeLow>TimeHigh
          RETURN 6 ! Date/Time too low - invalid or historic record
        ELSIF DateLow>PQ.DateHigh OR DateLow=PQ.DateHigh AND TimeLow>PQ.TimeHigh
          CYCLE
        ELSIF DateLow<PQ.DateLow OR DateLow=PQ.DateLow AND TimeLow<PQ.TimeLow
          IF DateHigh>PQ.DateHigh OR DateHigh=PQ.DateHigh AND TimeHigh>PQ.TimeHigh
            IF ResNo
              DELETE(PQ)
            END
            RETURN 5 !both Date/Times out of range
          ELSE
            IF ResNo
              IF DateHigh=PQ.DateHigh AND TimeHigh=PQ.TimeHigh
                DELETE(PQ)
              ELSE
                PQ.DateLow=DateHigh
                PQ.TimeLow=TimeHigh
                PUT(PQ)
              END
            END
            RETURN 2 !lower Date/Time out of range, high Date/Time within range or exact
          END
        ELSE  !lower Date/Time exact or within range
          IF DateHigh=PQ.DateHigh AND TimeHigh=PQ.TimeHigh AND DateLow=PQ.DateLow AND TimeLow=PQ.TimeLow
            DELETE(PQ)
            RETURN 0 !exact match
          ELSIF DateHigh>PQ.DateHigh OR DateHigh=PQ.DateHigh AND TimeHigh>PQ.TimeHigh
            IF ResNo
              PQ.DateHigh=DateLow
              PQ.TimeHigh=TimeLow
              PUT(PQ)
            END
            RETURN 3 !higher Date/Time out of range
          ELSE
            DO SplitEntry
            RETURN 4 !higher Date/Time exact or within range
          END
        END
      END
      ASSERT(0)
    ELSE
      RETURN 1 ! ProdID/ItemNo not found in Q
    END

SplitEntry ROUTINE
  DATA
D LONG,AUTO
T LONG,AUTO
  CODE
    D=PQ.DateHigh
    T=PQ.TimeHigh
    IF DateLow<>PQ.DateLow OR TimeLow<>PQ.TimeLow
      IF TimeLow=1
        PQ.DateHigh=DateLow-1
        PQ.TimeHigh=8640000
      ELSE
        PQ.DateHigh=DateLow
        PQ.TimeHigh=TimeLow-1
      END
      PUT(PQ)
    ELSE
      DELETE(PQ)
    END
    IF DateHigh<>D OR TimeHigh<>T
      IF TimeHigh=8640000
        PQ.DateLow=DateHigh+1
        PQ.TimeLow=1
      ELSE
        PQ.DateLow=DateHigh
        PQ.TimeLow=TimeHigh+1
      END
      PQ.DateHigh=D
      PQ.TimeHigh=T
      ADD(PQ,PQ.ProdID,PQ.ItemNo,PQ.DateLow,PQ.TimeLow)
    END



ReservationExtraClass._SyncPQ  PROCEDURE(XProdQueue PQ)
I ULONG,AUTO
  CODE
    LOOP I=1 TO RECORDS(PQ)
      GET(PQ,I)
      SELF.FMR.PrimeRecord()
      SELF.RFProdID = PQ.ProdID
      SELF.RFItemNo = PQ.ItemNo
      SELF.RFDateLow = PQ.DateLow
      SELF.RFTimeLow = PQ.TimeLow
      SELF.RFDateHigh = PQ.DateHigh
      SELF.RFTimeHigh = PQ.TimeHigh
      IF ~SELF.RFGranularity&=NULL
        SELF.RFGranularity = PQ.Granularity
      END
      IF SELF.FMR.Insert() <> Level:Benign
        ROLLBACK
        RETURN Level:Notify
      END
    END
    RETURN Level:Benign



ReservationExtraClass._BeginTransaction PROCEDURE
  CODE
    LOOP 100 TIMES
      LOGOUT(1,SELF.FMR.File)
      CASE ERRORCODE()
      OF 32
        CYCLE
      OF 0
        RETURN Level:Benign
      ELSE
        BREAK
      END
    END
    RETURN SELF.Errors.ThrowMessage(XMsg:LockError, ERRORCODE())


ReservationExtraClass.Find PROCEDURE(ASTRING ProdID, FindQueue Q1, USHORT Quantity, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG DurationMinutes, BYTE MaxSuggestions)
DL LONG,AUTO
DH LONG,AUTO
TL LONG,AUTO
TH LONG,AUTO
DHL LONG,AUTO
THL LONG,AUTO
Found BYTE
Diff LONG,AUTO
  CODE
    IF ~TimeLow THEN TimeLow=1 END
    IF ~TimeHigh THEN TimeHigh=8640000 END
    SELF.FMR.ClearKey(SELF.RFPKey)
    SELF.RFProdID = ProdID
    SET(SELF.RFPKey,SELF.RFPKey)
    LOOP
      IF SELF.FMR.NEXT()<>Level:Benign OR SELF.RFProdID <> ProdID
        BREAK
      END
      IF SELF.RFResNo OR SELF.RFStatus OR DurationMinutes % SELF.RFGranularity <> 0
        CYCLE
      END
      DO CalculateHighLimit
      IF DateLow>DHL OR DateLow=DHL AND TimeLow>THL
        CYCLE
      END
      DL=CHOOSE(DateLow>SELF.RFDateLow,DateLow,SELF.RFDateLow)
      TL=CHOOSE(TimeLow>SELF.RFTimeLow,TimeLow,SELF.RFTimeLow)
      Diff = SELF._GetTimeDifference(SELF.RFDateLow,CHOOSE(~SELF.RFTimeLow,1,SELF.RFTimeLow),DL,TL)%(SELF.RFGranularity*6000)
      IF Diff
        SELF._CalculateNewDateTime(DL,TL,SELF.RFGranularity*6000-Diff,DL,TL)
      END
      LOOP
        SELF._CalculateNewDateTime(DL,TL,DurationMinutes*6000,DH,TH,1)
        IF DH>DHL OR DH=DHL AND TH>THL
          BREAK
        END
        Found += SELF._AddFoundItem(Q1,SELF.RFItemNo,DL,TL,Quantity)
        IF Found=MaxSuggestions
          DO CleanUp
          RETURN Level:Benign
        END
        IF TH=8640000
          DL=DH+1
          TL=1
        ELSE
          DL=DH
          TL=TH+1
        END
      END
    END
    DO CleanUp
    RETURN CHOOSE(RECORDS(Q1)>0,Level:Benign,Level:Notify)



CleanUp ROUTINE
  DATA
I USHORT,AUTO
  CODE
    IF Quantity>1
      LOOP I=RECORDS(Q1) TO 1 by -1
        GET(Q1,I)
        IF RECORDS(Q1.ItemQ)<Quantity
          DISPOSE(Q1.ItemQ)
          DELETE(Q1)
        END
      END
    END

CalculateHighLimit ROUTINE
  DHL=CHOOSE(DateHigh<SELF.RFDateHigh,DateHigh,SELF.RFDateHigh)
  THL=CHOOSE(TimeHigh<SELF.RFTimeHigh,TimeHigh,SELF.RFTimeHigh)


ReservationExtraClass._AddFoundItem PROCEDURE(FindQueue Q1, ASTRING ItemNo, LONG DL, LONG TL, USHORT Quantity)
  CODE
    Q1.DateLow = DL
    Q1.TimeLow = TL
    Get(Q1,Q1.DateLow,Q1.TimeLow)
    IF ERRORCODE()
      Q1.ItemQ &= New(FindItemQueue)
      Q1.ItemQ.ItemNo = ItemNo
      ADD(Q1.ItemQ, Q1.ItemQ.ItemNo)
      ADD(Q1,Q1.DateLow,Q1.TimeLow)
    ELSE
      IF RECORDS(Q1.ItemQ)=Quantity THEN RETURN 0 END
      Q1.ItemQ.ItemNo=ItemNo
      GET(Q1.ItemQ,Q1.ItemQ.ItemNo)
      IF ERRORCODE()
        ADD(Q1.ItemQ,Q1.ItemQ.ItemNo)
      ELSE
?       ASSERT(0,'ItemNo twice in reservation file for same date/time periode!')
        RETURN 0
      END
    END
    RETURN CHOOSE(Quantity=RECORDS(Q1.ItemQ),1,0)


ReservationExtraClass._CalculateNewDateTime PROCEDURE(LONG DateLow, LONG TimeLow, REAL Duration, *LONG DateHigh, *LONG TimeHigh, BYTE Adjustment)
Modulo LONG,AUTO
  CODE
    Modulo = (TimeLow+Duration-Adjustment)%8640000
    TimeHigh = CHOOSE(Modulo=0,8640000,Modulo)  !Time should not be 0
    DateHigh = DateLow+(TimeLow+Duration-Adjustment)/8640000
    IF Modulo=0 THEN DateHigh-=1 END

ReservationExtraClass._GetTimeDifference PROCEDURE(LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh)
  CODE
    RETURN (DateHigh-DateLow)*8640000-TimeLow+TimeHigh

ReservationExtraClass.Reserve PROCEDURE(ASTRING ProdID, ASTRING CustID, FindItemQueue Q, LONG DateLow, LONG TimeLow, LONG DurationMinutes, *LONG ResNo)
DH LONG,AUTO
TH LONG,AUTO
NDL LONG,AUTO
NTL LONG,AUTO
NDH LONG,AUTO
NTH LONG,AUTO
I USHORT,AUTO
  CODE
    IF SELF._BeginTransaction()<>Level:Benign
      RETURN Level:Notify
    END
    SELF.FMR.ClearKey(SELF.RFRKey,,,1) !clear to highest value
    SET(SELF.RFRKey,SELF.RFRKey)
    ResNo = CHOOSE(SELF.FMR.PREVIOUS()<>Level:Benign,1,SELF.RFResNo+1)
    SELF._CalculateNewDateTime(DateLow,TimeLow,DurationMinutes*6000,DH,TH,1)
    LOOP I=1 TO RECORDS(Q)
      GET(Q,I)
      SELF.FMR.ClearKey(SELF.RFIKey)
      SELF.RFProdID=ProdID
      SELF.RFItemNo=Q.ItemNo
      SELF.RFDateLow=DateLow
      SELF.RFTimeLow=TimeLow
      SET(SELF.RFIKey,SELF.RFIKey)
      IF SELF.FMR.PREVIOUS()<>Level:Benign OR SELF.RFResNo OR |
         SELF.RFProdID<>ProdID OR SELF.RFItemNo<>Q.ItemNo OR |
         DateLow<SELF.RFDateLow OR DateLow=SELF.RFDateLow AND TimeLow<SELF.RFTimeLow OR |
         DH>SELF.RFDateHigh OR DH=SELF.RFDateHigh AND TH>SELF.RFTimeHigh
        ROLLBACK
        RETURN Level:Notify
      END
      NDL=SELF.RFDateLow
      NTL=SELF.RFTimeLow
      NDH=SELF.RFDateHigh
      NTH=SELF.RFTimeHigh
      DO Reservation
      IF DateLow<>NDL OR TimeLow<>NTL
        IF SELF._AddRecord(ProdID,Q.ItemNo,NDL,NTL,CHOOSE(TimeLow=1,DateLow-1,DateLow),CHOOSE(TimeLow=1,8640000,Timelow-1),SELF.RFGranularity,0)<>Level:Benign
          ROLLBACK
          RETURN Level:Notify
        END
      END
      IF DH<>NDH OR TH<>NTH
        IF SELF._AddRecord(ProdID,Q.ItemNo,CHOOSE(TH=8640000,DH+1,DH),CHOOSE(TH=8640000,1,TH+1),NDH,NTH,SELF.RFGranularity,0)<>Level:Benign
          ROLLBACK
          RETURN Level:Notify
        END
      END
    END
    COMMIT
    RETURN Level:Benign

Reservation ROUTINE
  SELF.RFDateLow=DateLow
  SELF.RFTimeLow=TimeLow
  SELF.RFDateHigh=DH
  SELF.RFTimeHigh=TH
  SELF.RFResNo=ResNo
  SELF.RFCustID=CustID
  IF SELF.FMR.Update()<>Level:Benign
    ROLLBACK
    RETURN Level:Notify
  END

ReservationExtraClass._AddRecord PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG Granularity, LONG ResNo)
  CODE
    SELF.FMR.PrimeRecord()
    SELF.RFProdID=ProdID
    SELF.RFItemNo=ItemNo
    SELF.RFDateLow=DateLow
    SELF.RFDateHigh=DateHigh
    SELF.RFTimeLow=TimeLow
    SELF.RFTimeHigh=TimeHigh
    SELF.RFGranularity=Granularity
    RETURN SELF.FMR.Insert()


OMIT('---')
ReservationExtraClass._GetNextPrevTime PROCEDURE(*LONG D, *LONG T, BYTE Prev)
  CODE
    IF Prev
      D=CHOOSE(T=1,D-1,D)
      T=CHOOSE(T=1,8640000,T-1)
    ELSE
      D=CHOOSE(T=8640000,D+1,D)
      T=CHOOSE(T=8640000,1,T+1)
    END
---

ReservationExtraClass.ProductReturn PROCEDURE(LONG ResNo)
ret BYTE,AUTO
  CODE
    ret = SELF._BeginTransaction()
    IF ret<>Level:Benign THEN RETURN ret END
    ret = SELF._Return(ResNo)
    IF ret<>Level:Benign
      ROLLBACK
    ELSE
      COMMIT
    END
    RETURN ret


ReservationExtraClass._Return PROCEDURE(LONG ResNo)
ret BYTE
  CODE
    SELF.FMR.ClearKey(SELF.RFRKey)
    SELF.RFResNo=ResNo
    SET(SELF.RFRKey,SELF.RFRKey)
    LOOP WHILE SELF.FMR.NEXT() = Level:Benign AND SELF.RFResNo=ResNo
      CLEAR(SELF.RFResNo)
      CLEAR(SELF.RFCustID)
      IF SELF.FMR.Update()<>Level:Benign
        RETURN Level:Notify
      END
      IF ~SELF.RFStatus
        ret = SELF._MergeRecords(SELF.RFProdID, SELF.RFItemNo, SELF.RFDateLow, SELF.RFTimeLow, SELF.RFDateHigh, SELF.RFTimeHigh, SELF.RFGranularity)
        IF ret THEN RETURN ret END
      END
      SELF.RFResNo=ResNo
      SET(SELF.RFRKey,SELF.RFRKey)
    END
    RETURN ret

ReservationExtraClass._MergeRecords PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG DateHigh, LONG TimeHigh, LONG Granularity)
ret BYTE
  CODE
    ret = SELF._Merge(ProdID, ItemNo, CHOOSE(TimeLow=1,DateLow-1,DateLow),CHOOSE(TimeLow=1,8640000,Timelow-1),Granularity,TRUE)
    IF ret=Level:Benign
      ret = SELF._Merge(ProdID, ItemNo, CHOOSE(TimeHigh=8640000,DateHigh+1,DateHigh),CHOOSE(TimeHigh=8640000,1,TimeHigh+1),Granularity,FALSE)
    END
    RETURN ret


ReservationExtraClass._Merge PROCEDURE(ASTRING ProdID, ASTRING ItemNo, LONG DateLow, LONG TimeLow, LONG Granularity, BYTE Prev)
ret BYTE,AUTO
D   LONG,AUTO
T   LONG,AUTO
Merge BYTE
  CODE
    SELF.FMR.ClearKey(SELF.RFIKey,5)
    SELF.RFProdID=ProdID
    SELF.RFItemNo=ItemNo
    SELF.RFDateLow=DateLow
    SELF.RFTimeLow=TimeLow
    SET(SELF.RFIKey,SELF.RFIKey)
    IF Prev
      ret=SELF.FMR.PREVIOUS()
    ELSE
      ret=SELF.FMR.Next()
    END
    IF ret<>Level:Benign OR ProdID<>SELF.RFProdID OR ItemNo<>SELF.RFItemNo OR |
       SELF.RFResNo OR SELF.RFStatus OR SELF.RFGranularity<>Granularity
      RETURN Level:Benign
    END
    IF Prev AND DateLow=SELF.RFDateHigh AND TimeLow=CHOOSE(SELF.RFTimeHigh=0,1,SELF.RFTimeHigh)
      D=SELF.RFDateLow
      T=SELF.RFTimeLow
      Merge=TRUE
    ELSIF ~Prev AND DateLow=SELF.RFDateLow AND TimeLow=CHOOSE(SELF.RFTimeLow=0,1,SELF.RFTimeLow)
      D=SELF.RFDateHigh
      T=SELF.RFTimeHigh
      Merge=TRUE
    END
    IF Merge
      DELETE(SELF.FMR.File)
      IF ERRORCODE() THEN
        RETURN SELF.Errors.ThrowMessage(XMsg:FileAccessError,'DELETE on file '&CLIP(SELF.FMR.GetName()))
      END
      IF Prev
        IF SELF.FMR.Next()<>Level:Benign THEN RETURN Level:Notify END
        SELF.RFDateLow=D
        SELF.RFTimeLow=T
      ELSE
        IF SELF.FMR.Previous()<>Level:Benign THEN RETURN Level:Notify END
        SELF.RFDateHigh=D
        SELF.RFTimeHigh=T
      END
      IF SELF.FMR.Update()<>Level:Benign
        RETURN Level:Notify
      END
    END
    RETURN Level:Benign

