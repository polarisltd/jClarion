  MEMBER
COMPILE('__Test__',_WebAbcDllMode_)
ERROR: WebAbcDllMode set incorrectly
__Test__

  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('ABLWMAN.INC'),ONCE
  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

SPECIALNAME             EQUATE('__Special__')
WbSpecialSubmitItemClass  CLASS(WbSubmitItemClass)
Reset                     PROCEDURE(STRING Name, STRING Value),BOOL,DERIVED
                        END

!!-----------------------------------------------------------------------

WbSpecialSubmitItemClass.Reset    PROCEDURE(STRING Name, STRING Value)
AssignPos               SIGNED,AUTO
  CODE
    IF (Name = SPECIALNAME)
      IF NOT Value
        RETURN FALSE
      END
      AssignPos = INSTRING('=', Value, 1, 1)
      IF (AssignPos = 0)
        RETURN SELF.Reset(Value,'')
      ELSE
        RETURN SELF.Reset(SUB(Value, 1, AssignPos-1), SUB(Value, AssignPos+1, -1))
      END
    END
    RETURN PARENT.Reset(Name,Value)

!!-----------------------------------------------------------------------

!!!!!!!!!!!!!!!!!!!!! WbWindowManagerClass !!!!!!!!!!!!!!!!!!!!!

WbWindowManagerClass.CreateDummyHtmlPage        PROCEDURE(STRING HtmlFilename)
  CODE
  IC:OpenSkeleton('~WBDUMMY.HTM', SELF.Files.GetProgramRef())
  IC:WritePatched(HtmlFilename)


WbWindowManagerClass.CreateUnauthorizedPage   PROCEDURE(STRING HtmlFilename)
  CODE
  IC:OpenSkeleton('~WBUNAUTH.HTM', SELF.Files.GetProgramRef())
  IC:WritePatched(HtmlFilename)


WbWindowManagerClass.Init        PROCEDURE(*WbServerClass Server, IPageCreator PageCreator, IWebResponseProcessor ResponseProcessor, <STRING AuthorizeArea>)

  CODE
  SELF.Server &= Server
  SELF.PageCreator &= PageCreator
  SELF.Files &= Server.Files
  SELF.ResponseProcessor &= ResponseProcessor

  SELF.Authorize = FALSE
  SELF.AuthorizeArea = AuthorizeArea
  SELF.AuthorizeFailed = FALSE

  SELF.Server.SetSendWholePage(TRUE)
  REGISTEREVENT(-1, ADDRESS(SELF.TakeRegisteredEvent), ADDRESS(SELF))




WbWindowManagerClass.SetPassword PROCEDURE(<STRING Password>, BYTE CaseSensitive)
  CODE
  SELF.Authorize = TRUE
  SELF.Password = Password
  SELF.PasswordCaseSensitive = CaseSensitive


WbWindowManagerClass.Kill PROCEDURE
  CODE
  SELF.AuthorizeArea &= NULL
  IF (NOT SELF.Server &= NULL) AND (NOT SELF.AuthorizeFailed)
    SELF.Server.SetSendWholePage(TRUE)
  END


WbWindowManagerClass.GetTargetSecurity   PROCEDURE
  CODE
  IF (SELF.IsSecure) THEN RETURN Secure:Full.
  RETURN Secure:None


WbWindowManagerClass.TakeEvent           PROCEDURE
RetValue                BYTE(Level:Benign)
  CODE
  IF (SELF.Server.IsEnabled())
    RetValue = SELF.Server.TakeEvent()
  END
  RETURN RetValue


WbWindowManagerClass.TakeRegisteredEvent PROCEDURE

  CODE
  IF (SELF.Server.IsEnabled())
    CASE SELF.Server.TakeRegisteredEvent()
    OF NET:Request
      SELF.TakeRequest
    OF NET:Terminate
      RETURN Level:Fatal
    END
    CASE (EVENT())
    OF EVENT:NewPage
      IF (SELF.Server.GetReadyForPage())
        SELF.TakeCreatePage
      END
    END
    IF (SELF.Server.GetReadyForPage())
      POST(EVENT:NewPage)
    END
  END
  RETURN Level:Benign


WbWindowManagerClass.TakeCreatePage      PROCEDURE

Client               &WbClientManagerClass
Filename             CSTRING(FILE:MaxFilePath),AUTO

  CODE
  Client &= SELF.Server.Client

  SELF.Files.SelectTarget(SELF.GetTargetSecurity())
  IF (SELF.Server.GetSendWholePage() OR NOT SELF.SentHtml)
    IF (SELF.Authorize AND NOT SELF.GetAuthorized()) ! page/data is protected ..
      Filename = SELF.Files.GetFilename(Content:UnAuthorized)
      SELF.CreateUnauthorizedPage(Filename)
      Client.TakeUnauthorized(Filename, SELF.GetTargetSecurity())
      SELF.AuthorizeFailed = TRUE
      Post(EVENT:CloseWindow)
    ELSE
      Filename = SELF.Files.GetFilename(Content:Html)
      IF (SELF.Server.GetRequestedWholePage())
        Client.NextHtmlPage
        SELF.PageCreator.CreatePage(Filename)
        SELF.SentHtml = TRUE
      ELSE
        Filename = SELF.Files.GetPublicDirectory() & 'dummy.htm'
        SELF.CreateDummyHtmlPage(Filename)
      END
      Client.TakeHtmlPage(Filename, SELF.GetTargetSecurity(), FALSE)
    END
  ELSE
!    Client.Jsl.OpenChannel(SELF.GetTargetSecurity(), SELF.Files)
!    SELF.PageCreator.CreateJslData(Client.Jsl)
!    Client.Jsl.CloseChannel
  END
  SELF.Server.TakePageSent()


WbWindowManagerClass.TakeRequest         PROCEDURE
NextSubmit              WbSpecialSubmitItemClass
Partial                 BOOL,AUTO
  CODE
  Partial = CHOOSE(NOT SELF.Server.GetRequestedWholePage())
  SELF.ResponseProcessor.BeforeResponses(Partial)
  LOOP WHILE(SELF.Server.SetNextAction(NextSubmit.ISubmitItem))
    SELF.ResponseProcessor.TakeResponse(NextSubmit.Name, NextSubmit.NewValue)
  END
  SELF.ResponseProcessor.AfterResponses(Partial)


WbWindowManagerClass.GetAuthorized      PROCEDURE
Password            STRING(255)
UserName            STRING(255)
  CODE
  SELF.Server.Broker.GetAuthorizedInfo(SELF.AuthorizeArea, UserName, Password)
  RETURN SELF.ValidatePassword(UserName, Password)


WbWindowManagerClass.ValidatePassword   PROCEDURE(STRING UserName, STRING Password)
  CODE
  IF (NOT SELF.PasswordCaseSensitive)
    Password = UPPER(Password)
    SELF.Password = UPPER(SELF.Password)
  END

  IF (Password = SELF.Password)
    RETURN TRUE
  END
  RETURN FALSE


WbWindowManagerClass.WindowComponent.Kill PROCEDURE

  CODE
  SELF.Kill


WbWindowManagerClass.WindowComponent.Reset PROCEDURE(BYTE Force)

  CODE


WbWindowManagerClass.WindowComponent.ResetRequired PROCEDURE  ! 1 if reset of window required

  CODE
  RETURN False


WbWindowManagerClass.WindowComponent.SetAlerts PROCEDURE

  CODE


WbWindowManagerClass.WindowComponent.TakeEvent PROCEDURE

  CODE
  RETURN SELF.TakeEvent()


WbWindowManagerClass.WindowComponent.Update PROCEDURE        ! Everything but the window!

  CODE


WbWindowManagerClass.WindowComponent.UpdateWindow PROCEDURE

  CODE



