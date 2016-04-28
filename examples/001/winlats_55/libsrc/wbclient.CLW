  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

!- Different types of browsers -----------------------------------------------

WbBrowserManagerClass.Init                       PROCEDURE(BYTE Kind, BYTE _SSS, BYTE _SFJ)

  CODE
  SELF.Kind = Kind
  SELF.SupportsStyleSheets = _SSS
  SELF.SubmitFromJava = _SFJ


!- Client Manager Class ------------------------------------------------------

WbClientManagerClass.Feq2Id            PROCEDURE(SIGNED Feq)
  CODE
  RETURN IC:Feq2Id(Feq, SELF.PageNumber)


WbClientManagerClass.SetIP             PROCEDURE
  CODE
  SELF.IP = IC:GetRequestClient()

WbClientManagerClass.Init              PROCEDURE(*WbDataSinkClass Broker, *WbBrowserManagerClass Browser)
  CODE
  SELF.Broker &= Broker
  SELF.Browser &= Browser


WbClientManagerClass.Kill                   PROCEDURE
  CODE

WbClientManagerClass.NextHtmlPage           PROCEDURE
  CODE
  IF (SELF.PageNumber < MAXPAGENUMBER)
    SELF.PageNumber += 1
  ELSE
    SELF.PageNumber = 0
  END

WbClientManagerClass.TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove=FALSE)
  CODE
  SELF.Broker.TakeFile(Filename, Security, dontmove)


WbClientManagerClass.TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove=FALSE)
  CODE
  SELF.Broker.TakeHtmlPage(Filename, Security, dontmove)


WbClientManagerClass.TakeJslData            PROCEDURE(STRING Filename, SIGNED Security)
  CODE
  SELF.Broker.TakeJslData(Filename, Security)


WbClientManagerClass.TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security)
  CODE
  SELF.Broker.TakeUnauthorized(Filename, Security)
