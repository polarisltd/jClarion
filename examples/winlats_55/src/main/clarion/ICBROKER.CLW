  MEMBER()

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')
  INCLUDE('ICBROKER.INC')

  MAP
    INCLUDE('ICSTD.INC')
  END

RPC:Secure              EQUATE(1)
RPC:NoMove              EQUATE(2)
RPC:AbsRedirect         EQUATE(4)

!- Module variables ----------------------------------------------------------

IE30                 BrowserManagerClass
IE40                 BrowserManagerClass
NetScape3x           BrowserManagerClass
Mozilla4             BrowserManagerClass
UnknownBrowser       BrowserManagerClass

!- Broker Class --------------------------------------------------------------

BrokerClass.SetClientBrowser         PROCEDURE

BrowserType          STRING(100)
P  LONG,AUTO
P2 LONG,AUTO
V  Real,AUTO
  CODE
  BrowserType = SELF.Http.GetBrowserProperty('User-Agent')
  P=INSTRING('MSIE', BrowserType, 1, 1)
  IF P
    P += 5
    P2=INSTRING(' ', BrowserType, 1, P)
    IF P2
      V=LEFT(SUB(BrowserType, P, P2-P))
      IF V>=4
        SELF.CurClient.Browser &= IE40
        RETURN
      ELSIF V>=3
        SELF.CurClient.Browser &= IE30
        RETURN
      END
    END
  END
  IF (INSTRING('Mozilla/4.', BrowserType, 1, 1))
    SELF.CurClient.Browser &= Mozilla4
  ELSIF (INSTRING('Mozilla/3.', BrowserType, 1, 1))
    SELF.CurClient.Browser &= NetScape3x
  ELSE
    ! probably be here because User-Agent is java something
    ! in which case the Browser is mostly irrelavant..
  END


BrokerClass.GetClient          PROCEDURE
  CODE
  SELF.SetClient
  RETURN SELF.CurClient


BrokerClass.SetClient          PROCEDURE
  CODE
  IF (SELF.CurClient &= NULL)
    SELF.CurClient &= NEW WebClientManagerClass
    SELF.CurClient.Init(SELF, UnknownBrowser)
  END
  IF (SELF.UseRPC)
    SELF.CurClient.SetIP
  END
  SELF.SetClientBrowser


BrokerClass.OpenChannel        PROCEDURE
  CODE
  IF (SELF.UseRPC)
    IC:ConnectToBroker
    RETURN TRUE
  END
  RETURN FALSE

BrokerClass.CloseChannel        PROCEDURE
  CODE
  IF (SELF.Channel)
    SELF.Channel = 0
  END


BrokerClass.GetAuthorizedInfo   PROCEDURE(STRING AreaName, *STRING User, *STRING Password)
  CODE
  SELF.Http.SetProcName(AreaName)
  SELF.Http.GetAuthorizedInfo(User, Password)


BrokerClass.GetEnabled          PROCEDURE
  CODE
  IF SELF.UseRPC OR SELF.ServerName
    RETURN TRUE
  END
  RETURN FALSE


BrokerClass.GetRequestArguments    PROCEDURE
  CODE
  RETURN SELF.Http.GetArguments()


BrokerClass.Init             PROCEDURE(STRING ProgramName, WebFilesClass Files)

  CODE
  IE30.Init(BROWSER:IE30, TRUE, FALSE)

  IE40.Init(BROWSER:IE40, TRUE, FALSE)

  NetScape3x.Init(BROWSER:NetScape3, FALSE, TRUE)
  NetScape3x.SetNoCache = TRUE

  Mozilla4.Init(BROWSER:Mozilla4, FALSE, TRUE)
  Mozilla4.SetNoCache = TRUE

  UnknownBrowser.Init(BROWSER:Unknown, FALSE, FALSE)

  SELF.ServerName = IC:GetCommandLineOption('/inet=')

  SELF.Files &= Files

  SELF.Http &= NEW HttpClass
  SELF.Http.Init(Files)
  SELF.Http.SetProgName(ProgramName)

  SELF.SetClient
  SELF.CurClient.IP = IC:GetCommandLineOption('/client=')
  SELF.UseRPC = IC:InitializeRPC(Files)


BrokerClass.Kill              PROCEDURE
  CODE
  SELF.CloseChannel
  IF (NOT (SELF.Http &= NULL))
    SELF.Http.Kill
    DISPOSE(SELF.Http)
  END
  IF (NOT SELF.CurClient &= NULL)
    SELF.CurClient.Kill
    DISPOSE(SELF.CurClient)
  END
  IF (SELF.UseRPC)
    IC:TerminateRPC
  END


BrokerClass.ProcessHttpHeader      PROCEDURE(STRING HeaderText)
  CODE
  SELF.Http.ProcessHeader(HeaderText)


BrokerClass.TakeBeforeBuildHeader       PROCEDURE
  CODE

BrokerClass.TakeFile          PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove)

Command          CSTRING(FILE:MaxFilePath)
IsAbsolute       BYTE
Flags            SIGNED(0)

  CODE

  IsAbsolute = IC:IsAbsoluteURL(Filename)
  IF IsAbsolute
    Command = Filename
  ELSE
    Command = SELF.Files.GetRelativeFilename(Filename)
    IF NOT DontMove
      Command = IC:TranslateFilename(Command)
    END
  END

  IF (SELF.UseRPC)
    IF IsAbsolute
      Flags += RPC:AbsRedirect
    ELSIF (dontmove)
      Flags += RPC:NoMove
    END

    IF (Security = Secure:Full)
      Flags += RPC:Secure
    END

    IC:SendPage(Command, Flags)
  END


BrokerClass.TakeHtmlPage      PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove)

  CODE
  SELF.Http.PreparePageForBrowser(200, Filename)
  SELF.Http.SetServerProperty('Pragma', 'no-cache')
  SELF.TakeBeforeBuildHeader
  ! jcs - Modify / add extra header info. here
  !EMBED (%BeforeHTMLPageSent, 'Internet, Before Sending HTML Page')
  ! for instance calls to SELF.Http.AddCookie(Name, Value)
  SELF.Http.FinishPage()
  SELF.TakeFile(Filename, Security, dontmove)


BrokerClass.TakeJslData      PROCEDURE(STRING Filename, SIGNED Security)

  CODE
  SELF.Http.PreparePageForJava(200, Filename)
  ! jcs - Modify / add extra header info. here
  ! any reasons to here?
  SELF.Http.FinishPage()
  SELF.TakeFile(Filename, Security, TRUE)


BrokerClass.TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security)

  CODE
  SELF.Http.PrepareUnauthorized(Filename)
  IF (SELF.CurClient.Browser.SetNoCache)
    SELF.Http.SetServerProperty('Pragma', 'no-cache')
  END
  SELF.Http.FinishPage()
  SELF.TakeFile(Filename, Security, TRUE)


