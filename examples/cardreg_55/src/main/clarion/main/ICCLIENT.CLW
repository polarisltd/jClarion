  MEMBER()

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')
  INCLUDE('ICCLIENT.INC')

  MAP
    INCLUDE('IcStd.inc')
  END

!- Different types of browsers -----------------------------------------------

BrowserManagerClass.Init                       PROCEDURE(BYTE Kind, BYTE _SSS, BYTE _SFJ)

  CODE
  SELF.Kind = Kind
  SELF.SupportsStyleSheets = _SSS
  SELF.SubmitFromJava = _SFJ


!- Client Manager Class ------------------------------------------------------

WebClientManagerClass.Feq2Id            PROCEDURE(SIGNED Feq)
  CODE
  RETURN IC:Feq2Id(Feq, SELF.PageNumber)


WebClientManagerClass.SetIP             PROCEDURE
  CODE
  SELF.IP = IC:GetRequestClient()

WebClientManagerClass.Init              PROCEDURE(*WebDataSinkClass Broker, *BrowserManagerClass Browser)
  CODE
  SELF.Jsl &= NEW JslManagerClass
  SELF.Jsl.Init(SELF)
  SELF.Broker &= Broker
  SELF.Browser &= Browser


WebClientManagerClass.Kill                   PROCEDURE
  CODE
  IF (NOT SELF.Jsl &= NULL)
    SELF.Jsl.Kill
    DISPOSE(SELF.Jsl)
  END

WebClientManagerClass.NextHtmlPage           PROCEDURE
  CODE
  IF (SELF.PageNumber < MAXPAGENUMBER)
    SELF.PageNumber += 1
  ELSE
    SELF.PageNumber = 0
  END

WebClientManagerClass.TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove=FALSE)
  CODE
  SELF.Broker.TakeFile(Filename, Security, dontmove)


WebClientManagerClass.TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove=FALSE)
  CODE
  SELF.Broker.TakeHtmlPage(Filename, Security, dontmove)


WebClientManagerClass.TakeJslData            PROCEDURE(STRING Filename, SIGNED Security)
  CODE
  SELF.Broker.TakeJslData(Filename, Security)


WebClientManagerClass.TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security)
  CODE
  SELF.Broker.TakeUnauthorized(Filename, Security)
