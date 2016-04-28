  MEMBER

  INCLUDE('WBSERVER.INC'),ONCE
  INCLUDE('WBHTML.INC'),ONCE
  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBHOOK.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE

!- Module variables ----------------------------------------------------------

GlobalServer    &WbServerClass
InAssert        BYTE


!- Server Class --------------------------------------------------------------

WbSubmitItemClass.Destruct  PROCEDURE
  CODE
  SELF.Name &= NULL
  SELF.NewValue &= NULL

WbSubmitItemClass.Reset   PROCEDURE(STRING Name, STRING value)
  CODE
  SELF.Name = Name
  SELF.NewValue = value
  RETURN TRUE

WbSubmitItemClass.ISubmitItem.Reset   PROCEDURE(STRING Name, STRING value)
  CODE
  RETURN SELF.Reset(Name, Value)


!- ShutDown Base Class ---------------------------------------------------------

WbShutDownClass.Close PROCEDURE

  CODE


!- Server Class --------------------------------------------------------------

WbServerClass.Init PROCEDURE(*WbBrokerClass Broker, *WbShutDownClass ShutDownManager, <STRING PageToReturnTo>, SIGNED TimeOut, <STRING JavaLibraryPath>, WbFilesClass Files)

  CODE
  SELF.Broker &= Broker
  SELF.ShutDownManager &= ShutDownManager
!  SELF.Client &= Broker.GetClient()

  SELF.PageToReturnTo = PageToReturnTo
  SELF.TimeOut = TimeOut
  SELF.JavaLibraryPath = JavaLibraryPath
  SELF.LastRequest = CLOCK()
  SELF.Files &= Files

  GlobalServer &= SELF
  SELF.SetDialogPageBackground(COLOR:None)
  SELF.SetDialogWindowBackground(COLOR:None)

  IF (SELF.IsEnabled())
    ! Setup the library to work in a special mode
    SYSTEM{PROP:threading} = 0
    SYSTEM{PROP:hide} = 1
    SYSTEM{PROP:printmode} = 1

    SELF.GotCommandLine = FALSE
    IC:RegisterServer(SELF)
    IC:InitializeHooks
    SELF.Connect()
  END


WbServerClass.Halt PROCEDURE
  CODE

  SELF.ShutDownManager.Close


WbServerClass.Kill PROCEDURE
  CODE
  SELF.Files.RemoveAll
  IF (SELF.InRequest)
    IF (SELF.PageToReturnTo)
      IF (IC:IsAbsoluteURL(SELF.PageToReturnTo))
        SELF.Broker.TakeFile(SELF.PageToReturnTo, Secure:Default, FALSE)
      ELSE
        SELF.Broker.TakeFile(SELF.Files.GetAlias(SELF.PageToReturnTo), Secure:Default, FALSE)
      END
    ELSE
      ! Force a request to myself - next time the broker tries to satisfy the
      ! request the program will have exited - so it will display the
      ! standard dead page.
      SELF.Broker.TakeFile(SELF.Files.GetProgramRef(), Secure:Default, FALSE)
    END
    YIELD()
  END
  SELF.Broker.CloseChannel
  SELF.IsActive = FALSE
  SELF.CommandLine &= NULL
  IF NOT SELF.Arguments &= NULL
    SELF.Arguments.Release()
    SELF.Arguments &= NULL
  END


WbServerClass.Quit        PROCEDURE
  CODE
  SELF.Aborting = TRUE
  POST(Event:CloseWindow)


WbServerClass.Connect             PROCEDURE
  CODE
  SELF.IsActive = SELF.Broker.OpenChannel()


WbServerClass.IsEnabled          PROCEDURE
  CODE
  IF (SELF.Broker.GetEnabled())
    RETURN TRUE
  END
  RETURN FALSE


WbServerClass.GetReadyForPage   PROCEDURE

  CODE

  IF (SELF.InRequest) AND (NOT SELF.Disabled) AND (0{PROP:eventswaiting} = 0)
     RETURN TRUE
  END
  RETURN FALSE


WbServerClass.TakeEvent           PROCEDURE
  CODE
  IF SELF.IsActive AND SELF.Aborting
    RETURN Level:Fatal
  END
  RETURN Level:Benign


WbServerClass.TakeRegisteredEvent      PROCEDURE

timenow              LONG

  CODE

  IF (SELF.IsActive)
    CASE EVENT()
    OF EVENT:Terminate
      SELF.Quit
      RETURN Net:Terminate
    OF EVENT:Request
      IF SELF.RequestPending
        SELF.RequestPending = FALSE
        RETURN SELF.ProcessRequest()
      END
    OF EVENT:Timer
      IF SELF.LastRequest AND NOT IC:IsExeRunningInBrowser()
        timenow = CLOCK()
        IF (timenow < SELF.LastRequest)
          timenow += 24*60*60*100
          ASSERT(timenow >= SELF.LastRequest)
        END
        IF (timenow - SELF.LastRequest > SELF.TimeOut * 100)
          SELF.Quit
          RETURN Net:Terminate
        END
      END
    OF EVENT:OpenWindow
      SELF.WindowOpened = TRUE
      IF SELF.RequestPending
        POST(EVENT:Request)
      END
      IF 0{PROP:timer}=0 AND NOT IC:IsExeRunningInBrowser()
        0{PROP:timer} = SELF.TimeOut * 10        ! i.e. 1/10 of the timeout
      END
    END
  ELSE
    CASE EVENT()
    OF EVENT:OpenWindow
      SELF.WindowOpened = TRUE
      IF (SELF.IsEnabled()) THEN SELF.Connect.
    END
  END
  RETURN NET:Unknown


WbServerClass.ProcessRequest              PROCEDURE
  CODE
  SELF.InRequest = TRUE

  SELF.LastRequest = CLOCK()
  SELF.RequestedWholePage = TRUE
  SELF.SendWholePage = TRUE

  IF (SELF.Arguments &= NULL) OR (SELF.IgnoreRequest)
    RETURN NET:Unknown
  END

  RETURN NET:Request


WbServerClass.TakeRequest              PROCEDURE
  CODE
  SELF.Broker.ProcessHttpHeader(IC:GetRequestText())
  SELF.Broker.SetClient
  SELF.Client &= SELF.Broker.GetClient()

  IF (NOT SELF.GotCommandLine) ! first request will always contain any args.
    SELF.CommandLine = SELF.Broker.GetRequestArguments()
    SELF.Arguments &= NULL
    SELF.GotCommandLine = TRUE
  ELSE
    SELF.Arguments &= SELF.Broker.Http.CreateArgumentIterator()
    SELF.Arguments.First()
  END

  SELF.RequestPending = TRUE
  IF (SELF.WindowOpened)
    POST(EVENT:Request, 0 , 1);
  END


WbServerClass.TakePageSent  PROCEDURE
  CODE
  SELF.InRequest = FALSE
  SELF.IgnoreRequest = FALSE

WbServerClass.SetNewPageDisable PROCEDURE(SIGNED DoDisable)

  CODE
  IF (DoDisable)
    SELF.Disabled += 1
  ELSE
    SELF.Disabled -= 1
  END


WbServerClass.GetSendWholePage  PROCEDURE

  CODE
  RETURN SELF.SendWholePage


WbServerClass.GetRequestedWholePage  PROCEDURE

  CODE
  RETURN SELF.RequestedWholePage


WbServerClass.SetSendWholePage  PROCEDURE(BYTE needed)

  CODE
  SELF.SendWholePage = needed

  ! If window open/closes indepenant of a browser request, any parameters
  ! passed by the browser will be ignored.  (Solves a problem with splash
  ! screens).
  SELF.IgnoreRequest = TRUE


WbServerClass.SetNextAction   PROCEDURE(ISubmitAction next)
Ok                   SIGNED,AUTO
  CODE

  IF (SELF.Arguments &= NULL)
    RETURN FALSE
  END

  LOOP
    IF NOT SELF.Arguments.IsValid()
      SELF.Arguments.Release()
      SELF.Arguments &= NULL
      RETURN FALSE
    END

    ok = next.Reset(SELF.Arguments.GetName(), SELF.Arguments.GetValue())
    SELF.Arguments.Next()
  UNTIL (ok)
  RETURN TRUE


WbServerClass.SetDialogWindowBackground  PROCEDURE(LONG BackColor, <STRING Image>)
  CODE

  SELF.DialogWinBackColor = BackColor
  SELF.DialogWinImage = Image


WbServerClass.SetDialogPageBackground    PROCEDURE(LONG BackColor, <STRING Image>)
  CODE

  SELF.DialogPageBackColor = BackColor
  SELF.DialogPageImage = Image



WbServerClass::Get  PROCEDURE()
  CODE
    RETURN GlobalServer
