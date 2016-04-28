  MEMBER


  MAP
  END

  INCLUDE('WBVISIT.INC'),ONCE


VisitorClass.InitVisitor PROCEDURE(FileManager FMVIS, KEY VISIdxKey, *? VISIdx, *? VISCusID)
  CODE
    SELF.FMVIS &= FMVIS
    SELF.VISIdxKey &= VISIdxKey
    SELF.VISIdx &= VISIdx
    SELF.VISCusID &= VISCusID
    SELF.FMVIS.LazyOpen=FALSE
    RETURN SELF.FMVIS.Open()


VisitorClass.InitCart PROCEDURE(FileManager FMCART, KEY CARTKey, *? CARTCusID)
  CODE
    SELF.FMCART &= FMCART
    SELF.CARTKey &= CARTKey
    SELF.CARTCusID &= CARTCusID
    SELF.FMCART.LazyOpen=FALSE
    RETURN SELF.FMCART.Open()


VisitorClass.InitInvoice PROCEDURE(FileManager FMINV, KEY INVKey, *? INVCusID)
  CODE
    SELF.FMINV &= FMINV
    SELF.INVKey &= INVKey
    SELF.INVCusID &= INVCusID
    SELF.FMINV.LazyOpen=FALSE
    RETURN SELF.FMINV.Open()


VisitorClass.NewVisitor PROCEDURE()
ret BYTE
  CODE
    IF SELF.GetCurrent() THEN RETURN Level:Benign END
?   ASSERT(~SELF.FMVIS &= NULL,'FileManager not initialized!')
    SET(SELF.VISIdxKey)
    SELF.FMVIS.PREVIOUS()
    ret = SELF.SetNewName('#'&SELF.VISIdx+1,'',TRUE)
    IF ~ret
      ret = SELF.FMVIS.PrimeRecord()
      IF ~ret
        SELF.VISCusID=SELF.GetCurrent()
        ret = SELF.FMVIS.Insert()
        SELF.Visitor=SELF.VISCusID
      END
    END
    RETURN ret

VisitorClass.ReservedLogonName PROCEDURE(ASTRING Name)
  CODE
    !ASTRING slicing still doesn't compile under 16 bit!
    !RETURN CHOOSE(Name[1]='#' AND NUMERIC(Name[2 : LEN(Name)]),Level:Notify,Level:Benign)
    RETURN CHOOSE(SUB(Name,1,1)='#' AND NUMERIC(SUB(Name,2,LEN(Name)-1)),Level:Notify,Level:Benign)


VisitorClass.Ask PROCEDURE
ret BYTE,AUTO
  CODE
    ret = PARENT.Ask()
    IF ret=Level:Benign
      SELF.TidyUp()
    END
    RETURN ret

VisitorClass.TidyUp PROCEDURE
NewCusID LONG,AUTO
  CODE
    IF SELF.Visitor
      NewCusID=SELF.GetCurrent()
      IF ~SELF.FMCART &= NULL
        SELF.FMCART.ClearKey(SELF.CARTKey,2)
        SELF.CARTCusID=SELF.Visitor
        SET(SELF.CARTKey,SELF.CARTKey)
        LOOP UNTIL SELF.FMCART.NEXT()<>Level:Benign OR SELF.CARTCusID<>SELF.Visitor
          SELF.CARTCusID=NewCusID
          ASSERT(SELF.FMCART.Update()=Level:Benign)
        END
      END
      IF ~SELF.FMINV &= NULL
        SELF.FMINV.ClearKey(SELF.INVKey,2)
        SELF.INVCusID=SELF.Visitor
        SET(SELF.INVKey,SELF.INVKey)
        LOOP UNTIL SELF.FMINV.NEXT()<>Level:Benign OR SELF.INVCusID<>SELF.Visitor
          SELF.INVCusID=NewCusID
          ASSERT(SELF.FMINV.Update()=Level:Benign)
        END
      END
      CLEAR(SELF.Visitor)
    END

VisitorClass.KillVisitor PROCEDURE
  CODE
    SELF.FMVIS.Close
    IF ~SELF.FMCART &= NULL
      SELF.FMCART.Close
    END
    IF ~SELF.FMINV &= NULL
      SELF.FMINV.CLOSE
    END
