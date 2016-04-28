  MEMBER
  MAP
    IncSparse(FileManager FM, KEY K, *? Value, LONG Amount)
  .

  INCLUDE('ABSHOP.INC'),ONCE

ProductList QUEUE,TYPE
Fle      &FileManager
K        &Key
Id       ANY
Quantity ANY
DLow  LONG
DHigh LONG
  END


! Note that this is designed to automatically store -statistics-
! Whilst -reasonable- care is taken to ensure integrity the final response to
! not being able to store a value is simply to give up

StatsTracker.AddProduct PROCEDURE(FileManager ProductStats, KEY K, *? Id, *? Quantity, LONG DateLow=0, LONG DateHigh=0) ! Track quantity sold between dates
  CODE
  ASSERT(~SELF.Ptrack &= NULL,'Object not initialized')
  CLEAR(SELF.Ptrack)
  SELF.PTrack.Fle &= ProductStats
  SELF.PTrack.Id &= Id
  SELF.PTrack.K &= K
  SELF.PTrack.Quantity &= Quantity
  SELF.PTrack.DLow = DateLow
  SELF.PTrack.DHigh = DateHigh
  ADD(SELF.PTrack)

StatsTracker.Init       PROCEDURE
  CODE
  SELF.Kill
  SELF.Ptrack &= NEW ProductList

StatsTracker.Kill       PROCEDURE
I SIGNED,AUTO
  CODE
  IF SELF.Ptrack &= NULL THEN RETURN .
  LOOP I = 1 TO RECORDS(SELF.PTrack)
    GET(SELF.PTrack,I)
    SELF.PTrack.Id &= NULL
    SELF.PTrack.Quantity &= NULL
  END
  DISPOSE(SELF.PTrack)

StatsTracker.SetCross   PROCEDURE(FileManager CrossStats, KEY K, *? LeftId, *? RightId,*? Quantity)
  CODE
  SELF.XFle &= CrossStats
  SELF.XLeftId &= LeftId
  SELF.XRightId &= RightId
  SELF.XQuantity &= Quantity
  SELF.XK &= K

StatsTracker.SetInvoice PROCEDURE(*? InvoiceId, *? ProductId, *? Quantity,<*? CustomerId>, <*? Dte>)
  CODE
  SELF.InvoiceId &= InvoiceId
  SELF.CustomerId &= CustomerId
  SELF.ProductId &= ProductId
  SELF.Quantity &= Quantity
  SELF.Dte &= Dte    ! I wonder if cloning a null works?

StatsTracker.UpdateCrosses PROCEDURE
I SIGNED,AUTO
J SIGNED,AUTO
  CODE
  LOOP I = 1 TO SELF.Cin
    LOOP J = 1 TO SELF.Cin   ! Produce full-width cross-product
      IF I = J THEN CYCLE .
      SELF.XLeftId = SELF.CLst[I]
      SELF.XRightId = SELF.CLst[J]
      IncSparse(SELF.XFle,SELF.XK,SELF.XQuantity,1)
    END
  END
  SELF.Cin = 0


StatsTracker.RecordProcessor.TakeRecord          PROCEDURE
I SIGNED,AUTO
  CODE
  LOOP I = 1 TO RECORDS(SELF.PTrack)
    GET(SELF.PTrack,I)
    IF ~SELF.PTrack.DLow AND ~SELF.PTrack.DHigh OR ~SELF.Dte &= NULL AND SELF.PTrack.DLow <= SELF.Dte AND SELF.PTrack.DHigh >= SELF.Dte
      IF ~SELF.DoneOne
        ASSERT(~SELF.PTrack.Fle.Open())
        ASSERT(~SELF.PTrack.Fle.UseFile())
      END
      SELF.PTrack.Id = SELF.ProductId
      IncSparse(SELF.PTrack.Fle,SELF.PTrack.K,SELF.PTrack.Quantity,SELF.Quantity)
    END
  END
  IF ~SELF.XFle &= NULL
    IF SELF.IWoz <> SELF.InvoiceId OR ~SELF.CustomerId &= NULL AND SELF.CWoz <> SELF.CustomerId
      IF SELF.DoneOne
        SELF.UpdateCrosses
      ELSE
        ASSERT(~SELF.XFle.Open())
        ASSERT(~SELF.XFle.UseFile())
      END
      SELF.IWoz = SELF.InvoiceId
      IF ~SELF.CustomerId &= NULL
        SELF.CWoz = SELF.CustomerId
      END
    END
    SELF.Cin += 1
    SELF.CLst[SELF.Cin] = SELF.ProductId
  END
  SELF.DoneOne = 1
  RETURN Level:Benign

StatsTracker.RecordProcessor.TakeClose           PROCEDURE
I SIGNED,AUTO
  CODE
  IF SELF.DoneOne
    SELF.UpdateCrosses
    LOOP I = 1 TO RECORDS(SELF.PTrack)
      GET(SELF.PTrack,I)
      ASSERT(~SELF.PTrack.Fle.Close())
    END
    IF ~SELF.XFle &= NULL
      ASSERT(~SELF.XFle.Close())
    END
  END
  RETURN Level:Benign

IncSparse PROCEDURE(FileManager FM, KEY K, *? Value, LONG Amount)
  CODE
    WATCH(FM.File)
    IF FM.TryFetch(K)
      LOOP 5 TIMES
        Value = Amount
      WHILE FM.TryInsert()
    ELSE
      LOOP 5 TIMES
        Value += Amount
      WHILE FM.TryUpdate() ! Record-locked updates buffer
    END
