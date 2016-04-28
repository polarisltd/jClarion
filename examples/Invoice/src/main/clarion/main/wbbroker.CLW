  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBBROKER.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

RPC:Secure              EQUATE(1)
RPC:NoMove              EQUATE(2)
RPC:AbsRedirect         EQUATE(4)

!- Module variables ----------------------------------------------------------

IE30                 WbBrowserManagerClass
IE40                 WbBrowserManagerClass
NetScape3x           WbBrowserManagerClass
Mozilla4             WbBrowserManagerClass
UnknownBrowser       WbBrowserManagerClass

!- Broker Class --------------------------------------------------------------

WbBrokerClass.SetClientBrowser         PROCEDURE

!IE5: User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; VNIE4 3.1.814)
!NS4.5: User-Agent: Mozilla/4.51 [en] (Win98; I)

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


WbBrokerClass.GetClient          PROCEDURE
  CODE
  SELF.SetClient
  RETURN SELF.CurClient


WbBrokerClass.SetClient          PROCEDURE
  CODE
  IF (SELF.CurClient &= NULL)
    SELF.CurClient &= NEW WbClientManagerClass
    SELF.CurClient.Init(SELF, UnknownBrowser)
  END
  IF (SELF.UseRPC)
    SELF.CurClient.SetIP
  END
  SELF.SetClientBrowser


WbBrokerClass.OpenChannel        PROCEDURE
  CODE
  IF (SELF.UseRPC)
    IC:ConnectToBroker
    RETURN TRUE
  END
  RETURN FALSE

WbBrokerClass.CloseChannel        PROCEDURE
  CODE
  IF (SELF.Channel)
    SELF.Channel = 0
  END


WbBrokerClass.GetAuthorizedInfo   PROCEDURE(STRING AreaName, *STRING User, *STRING Password)
  CODE
  IF  NOT SELF.Http &= NULL
    SELF.Http.SetProcName(AreaName)
    SELF.Http.GetAuthorizedInfo(User, Password)
  END


WbBrokerClass.GetEnabled          PROCEDURE
  CODE
  IF SELF.UseRPC
    RETURN TRUE
  END
  RETURN FALSE


WbBrokerClass.GetRequestArguments    PROCEDURE
  CODE
  RETURN CHOOSE (SELF.Http &= NULL, '', SELF.Http.GetArguments())



WbBrokerClass.Init             PROCEDURE(STRING ProgramName, WbFilesClass Files)

  CODE
  IE30.Init(BROWSER:IE30, TRUE, FALSE)

  IE40.Init(BROWSER:IE40, TRUE, FALSE)

  NetScape3x.Init(BROWSER:NetScape3, FALSE, TRUE)
  NetScape3x.SetNoCache = TRUE

  Mozilla4.Init(BROWSER:Mozilla4, FALSE, TRUE)
  Mozilla4.SetNoCache = TRUE

  UnknownBrowser.Init(BROWSER:Unknown, FALSE, FALSE)

  SELF.Files &= Files

  SELF.Http &= NEW WbHttpClass
  SELF.Http.Init(Files)
  SELF.Http.SetProgName(ProgramName)

  SELF.SetClient
  SELF.CurClient.IP = IC:GetCommandLineOption('/client=')
  SELF.UseRPC = IC:InitializeRPC(Files)


WbBrokerClass.Kill              PROCEDURE
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


WbBrokerClass.ProcessHttpHeader      PROCEDURE(STRING HeaderText)
  CODE
  IF  NOT SELF.Http &= NULL
    SELF.Http.ProcessHeader(HeaderText)
  END


WbBrokerClass.TakeBeforeBuildHeader       PROCEDURE
  CODE
  ! jcs - Modify / add extra header info. here
  !EMBED (%BeforeHTMLPageSent, 'Internet, Before Sending HTML Page')
  ! for instance calls to SELF.Http.AddCookie(Name, Value)

WbBrokerClass.TakeFile          PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove)

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


WbBrokerClass.TakeHtmlPage      PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove)
TargetFilename          CSTRING(File:MaxFilePath)
  CODE
  SELF.Http.PreparePageForBrowser(200, Filename)
  SELF.Http.SetServerProperty('Pragma', 'no-cache')
  SELF.TakeBeforeBuildHeader
  TargetFilename = SELF.Http.FinishPage()
  SELF.TakeFile(TargetFilename, Security, dontmove)


WbBrokerClass.TakeJslData      PROCEDURE(STRING Filename, SIGNED Security)
TargetFilename          CSTRING(File:MaxFilePath)
  CODE
  SELF.Http.PreparePageForJava(200, Filename)
  ! jcs - Modify / add extra header info. here
  ! any reasons to here?
  TargetFilename = SELF.Http.FinishPage()
  SELF.TakeFile(TargetFilename, Security, TRUE)


WbBrokerClass.TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security)
TargetFilename          CSTRING(File:MaxFilePath)
  CODE
  SELF.Http.PrepareUnauthorized(Filename)
  IF (SELF.CurClient.Browser.SetNoCache)
    SELF.Http.SetServerProperty('Pragma', 'no-cache')
  END
  TargetFilename = SELF.Http.FinishPage()
  SELF.TakeFile(TargetFilename, Security, TRUE)


