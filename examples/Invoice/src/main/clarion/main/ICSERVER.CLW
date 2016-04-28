  MEMBER()

BaseClassDllMode     EQUATE(0)


  INCLUDE('ICSERVER.INC')
  INCLUDE('ICEVENT.INC')
  INCLUDE('ICHTML.INC')
  INCLUDE('ICWINDOW.INC')
  INCLUDE('ICSTD.EQU')
  INCLUDE('ICSERVER.TRN')

  MAP
    INCLUDE('IcStd.inc')

    IC:ClearHooks
    IC:InitializeHooks

COMPILE('!End', _VER_C4)
    IC:ASSERT(UNSIGNED line, STRING filename)
    IC:COLORDIALOG(<STRING>,*?),SIGNED,PROC
    IC:FATALERROR(UNSIGNED line, STRING filename)
    IC:FILEDIALOG(<STRING>,*?,<STRING>,SIGNED=0),PROC,BOOL
    IC:FONTDIALOG(<STRING>,*?,<*?>,<*?>,<*?>,SIGNED = 0),BOOL,PROC
    IC:HALT(UNSIGNED=0,<STRING>)
    IC:MESSAGE(STRING,<STRING>,<STRING>,<STRING>,UNSIGNED=0,BOOL=FALSE),UNSIGNED,PROC
    IC:PRINTERDIALOG(<STRING>,BOOL=FALSE),BOOL,PROC
    IC:STOP(<STRING>)
!End
OMIT('!End', _VER_C4)
    IC:ASSERT(UNSIGNED line, STRING filename)
    IC:COLORDIALOG(<STRING>,*?),SIGNED,PROC
    IC:FATALERROR(UNSIGNED line, STRING filename)
    IC:FILEDIALOG(<STRING>,*?,<STRING>,SIGNED=0),PROC,BOOL
    IC:FONTDIALOG(<STRING>,*?,<*?>,<*?>,<*?>,SIGNED = 0),BOOL,PROC
    IC:HALT(UNSIGNED=0,<STRING>)
    IC:MESSAGE(STRING,<STRING>,<STRING>,UNSIGNED=0,UNSIGNED=0,BOOL=FALSE),UNSIGNED,PROC
    IC:PRINTERDIALOG(<STRING>,BOOL=FALSE),BOOL,PROC
    IC:STOP(<STRING>)
!End
  END

!- Module variables ----------------------------------------------------------

JavaEvents      JslEventsClass,EXTERNAL
GlobalServer    &WebServerClass
InAssert        BYTE


!- Server Class --------------------------------------------------------------

SubmitItemClass.Reset   PROCEDURE(Arguments)

StartPos             SIGNED
AssignPos            SIGNED
EndPos               SIGNED
EventNo              SIGNED
EventPos             SIGNED
ControlId            UNSIGNED

  CODE

  StartPos = 1
  EndPos = LEN(Arguments)+1
  AssignPos = INSTRING('=', Arguments, 1, StartPos)
  IF (AssignPos = 0)
    AssignPos = EndPos
  END

  ! Find the first non digit after the field equate number
  CASE (VAL(Arguments[StartPos]))
  OF VAL('0') TO VAL('9')
  ELSE
    StartPos += 1
  END

  EventPos = StartPos
  LOOP
    CASE (VAL(Arguments[EventPos]))
    OF VAL('0') TO VAL('9')
    ELSE
      BREAK
    END
    EventPos += 1
  WHILE (EventPos < EndPos)

  EventNo = EVENT:Accepted
  IF (EventPos < EndPos)
    EventNo = JavaEvents.GetEventNumber(Arguments[EventPos])
  END

  SELF.Event = EventNo
  ControlId = SUB(Arguments, StartPos, EventPos-StartPos)
  SELF.Name = Arguments[(1):(AssignPos-1)]
  SELF.Extra = SUB(Arguments, EventPos+1,  AssignPos - (EventPos+1))
  SELF.NewValue = SUB(Arguments, AssignPos+1, EndPos - (AssignPos+1))

  ! Special cases standard event processing
  CASE (ControlId)
  OF 9998
     SELF.Feq = 0
     ! Menu hotlink - implemented via a hidden control.
     IF (SELF.NewValue)
       SELF.Reset(IC:Html2Clarion(SELF.NewValue))
     ELSE
       SELF.Event = 0
     END
  OF 9999
     ! Close button - if present on toolbar
     SELF.Feq = 0
     SELF.Event = EVENT:CloseWindow
  OF 0
     SELF.Feq = FEQ:UNKNOWN
  ELSE
     SELF.Feq = IC:Id2Feq(ControlId)
  END


!- ShutDown Base Class ---------------------------------------------------------

!! This is an abstract interface - so there is no need to define the methods !!


!- Server Class --------------------------------------------------------------

WebServerClass.Init PROCEDURE(*BrokerClass Broker, *ShutDownClass ShutDownManager, <STRING PageToReturnTo>, SIGNED TimeOut, <STRING JavaLibraryPath>, WebFilesClass Files)

  CODE
  SELF.CurSubmit &= NEW SubmitItemClass
  SELF.Broker &= Broker
  SELF.ShutDownManager &= ShutDownManager
  SELF.Client &= Broker.GetClient()

  SELF.PageToReturnTo = PageToReturnTo
  SELF.TimeOut = TimeOut
  SELF.JavaLibraryPath = JavaLibraryPath
  SELF.LastRequest = CLOCK()
  SELF.Files &= Files

  GlobalServer &= SELF
  SELF.SetDialogPageBackground(COLOR:None)
  SELF.SetDialogWindowBackground(COLOR:None)

  IF (SELF.GetInternetEnabled())
    ! Setup the library to work in a special mode
    SYSTEM{PROP:threading} = 0
    SYSTEM{PROP:hide} = 1
    SYSTEM{PROP:printmode} = 1

    SELF.GotCommandLine = FALSE
    IC:RegisterServer(SELF)
  END


WebServerClass.Halt PROCEDURE
  CODE

  SELF.ShutDownManager.Close


WebServerClass.Kill PROCEDURE
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
  SELF.Active = FALSE
  DISPOSE (SELF.CurSubmit)

WebServerClass.Quit        PROCEDURE
  CODE
  SELF.Aborting = TRUE


WebServerClass.Connect             PROCEDURE
  CODE
  SELF.Active = SELF.Broker.OpenChannel()
  IF (SELF.Active)
    IC:InitializeHooks
  END


WebServerClass.GetInternetEnabled          PROCEDURE
  CODE
  IF (SELF.Broker.GetEnabled())
    RETURN TRUE
  END
  RETURN FALSE


WebServerClass.GetReadyForPage   PROCEDURE
  CODE
  IF (SELF.InRequest) AND (NOT SELF.Disabled) AND STATUS (TARGET) = WINDOW:Ok
    IF NOT 0{PROP:EventsWaiting}  AND  NOT 0{PROP:AcceptAll}
      RETURN TRUE
    END
  END
  RETURN FALSE


WebServerClass.TakeEvent           PROCEDURE

Header               EQUATE('Internet:')
CmdTerminate         EQUATE('Terminate')
CmdRequest           EQUATE('Request')

HttpStart            UNSIGNED
LenHeader            SIGNED
LenCmdTerminate      SIGNED
LenCmdRequest        SIGNED
LenCmd               SIGNED
Request              ANY
timenow              LONG

  CODE

  IF (SELF.Active)
    IF SELF.Aborting THEN RETURN Net:Terminate.

    CASE EVENT()
    OF EVENT:Terminate
      SELF.Quit
      RETURN Net:Terminate
    OF EVENT:Request
      IF SELF.RequestPending
        SELF.RequestPending = FALSE
        RETURN SELF.TakeRequest(IC:GetRequestText())
      END
    OF EVENT:Timer
      IF (SELF.LastRequest)
        timenow = CLOCK()
        IF (timenow < SELF.LastRequest)
          timenow += 24*60*60*100
        END
        IF (timenow - SELF.LastRequest > SELF.TimeOut * 100)
          SELF.Quit
        END
      END
    OF EVENT:OpenWindow
      IF SELF.RequestPending
        POST(EVENT:Request)
      END
      IF 0{PROP:timer}=0
        0{PROP:timer} = SELF.TimeOut * 10        ! i.e. 1/10 of the timeout
      END
    END
  END
  RETURN NET:Unknown


WebServerClass.TakeRequest              PROCEDURE(STRING RequestText)
  CODE
  SELF.InRequest = TRUE

  ! From Internet:Request(args) return args
  !JCS - Request .. will contain http header info on front..
  !JCS - http header will run from beginning of Request until \r\n

  SELF.Broker.ProcessHttpHeader(RequestText)

  IF (NOT SELF.GotCommandLine) ! first request will always contain any args.
    SELF.Arguments = ''
    SELF.GotCommandLine = TRUE
  ELSE
    SELF.Arguments = SELF.Broker.GetRequestArguments()
  END

  SELF.Client &= SELF.Broker.GetClient()

  SELF.LastRequest = CLOCK()
  SELF.RequestedWholePage = TRUE
  SELF.SendWholePage = TRUE

  IF (NOT SELF.Arguments) OR (SELF.IgnoreRequest)
    RETURN NET:Unknown
  END

  IF (SUB(SELF.Arguments, 1, 1) = '@')
    SELF.RequestedWholePage = FALSE
    SELF.SendWholePage = FALSE
    SELF.Arguments = SUB(SELF.Arguments, 2, -1)
  END

  IF (SELF.Arguments)
    SELF.Arguments = SELF.Arguments & '&'
  END
  SELF.ArgIndex = 1

  RETURN NET:Request


WebServerClass.TakeRequest              PROCEDURE
  CODE

  IF (NOT SELF.GotCommandLine) ! first request will always contain any args.
    SELF.Broker.ProcessHttpHeader(IC:GetRequestText())
    SELF.CommandLine = SELF.Broker.GetRequestArguments()
    SELF.Broker.SetClient
  END

  SELF.RequestPending = TRUE
  POST(EVENT:Request, 0 , 1);


WebServerClass.TakePageSent  PROCEDURE
  CODE
  SELF.InRequest = FALSE
  SELF.IgnoreRequest = FALSE

WebServerClass.SetNewPageDisable PROCEDURE(SIGNED DoDisable)

  CODE
  IF (DoDisable)
    SELF.Disabled += 1
  ELSE
    SELF.Disabled -= 1
  END


WebServerClass.GetSendWholePage  PROCEDURE

  CODE
  RETURN SELF.SendWholePage


WebServerClass.GetRequestedWholePage  PROCEDURE

  CODE
  RETURN SELF.RequestedWholePage


WebServerClass.SetSendWholePage  PROCEDURE(BYTE needed)

  CODE
  SELF.SendWholePage = needed

  ! If window open/closes indepenant of a browser request, any parameters
  ! passed by the browser will be ignored.  (Solves a problem with splash
  ! screens).
  SELF.IgnoreRequest = TRUE


WebServerClass.SetNextAction   PROCEDURE

AssignPos            SIGNED
EndPos               SIGNED
EventNo              SIGNED
EventPos             SIGNED
StartPos             SIGNED
NIL                  &SubmitItemClass

  CODE

  StartPos = SELF.ArgIndex

  EndPos = INSTRING('&', SELF.Arguments, 1, StartPos)
  IF (EndPos = 0)
    RETURN NIL
  END

  SELF.CurSubmit.Reset(SUB(SELF.Arguments, StartPos, EndPos-StartPos))

  SELF.ArgIndex = EndPos + 1
  RETURN SELF.CurSubmit


WebServerClass.SetDialogWindowBackground  PROCEDURE(LONG BackColor, <STRING Image>)
  CODE

  SELF.DialogWinBackColor = BackColor
  SELF.DialogWinImage = Image


WebServerClass.SetDialogPageBackground    PROCEDURE(LONG BackColor, <STRING Image>)
  CODE

  SELF.DialogPageBackColor = BackColor
  SELF.DialogPageImage = Image



COMPILE('!End', _VER_C4)
IC:MESSAGE    PROCEDURE(STRING text, <STRING caption>, <STRING icon>, <STRING buttonStr>, UNSIGNED default, BOOL style)
!End
OMIT('!End', _VER_C4)
IC:MESSAGE    PROCEDURE(STRING text, <STRING caption>, <STRING icon>, UNSIGNED buttonStr, UNSIGNED default, BOOL style)
!End

window  WINDOW
          BUTTON(MessageOkText),AT(40,80,,12),USE(?OK,BUTTON:OK),HIDE
          BUTTON(MessageYesText),AT(45,80,,12),USE(?YES,BUTTON:YES),HIDE
          BUTTON(MessageNoText),AT(60,80,,12),USE(?NO,BUTTON:NO),HIDE
          BUTTON(MessageAbortText),AT(40,80,,12),USE(?ABORT,BUTTON:ABORT),HIDE
          BUTTON(MessageRetryText),AT(60,80,,12),USE(?RETRY,BUTTON:RETRY),HIDE
          BUTTON(MessageIgnoreText),AT(80,80,,12),USE(?IGNORE,BUTTON:IGNORE),HIDE
          BUTTON(MessageCancelText),AT(100,80,,12),USE(?CANCEL,BUTTON:CANCEL),HIDE
          STRING('s'),AT(0,0,200,50),USE(?text)
        END

Buttons              SIGNED,AUTO
CurControl           &WebControlClass
Result               SIGNED(BUTTON:CANCEL)
HtmlTarget           HtmlClass
NextIndex            SIGNED,AUTO
StartIndex           SIGNED,AUTO
TargetText           ANY
WebWindow            WebWindowClass

  CODE

  Buttons = buttonStr
  IF buttons = 0 THEN buttons = BUTTON:OK.

  StartIndex = 1
  LOOP
    NextIndex = INSTRING('|', Text, 1, StartIndex)
    IF (NextIndex = 0)
      TargetText = TargetText & Text[StartIndex : LEN(Text)]
      BREAK
    END
    TargetText = TargetText & Text[StartIndex : NextIndex - 1] & '<13,10>'
    StartIndex = NextIndex + 1
  END

  OPEN(window)
  window{PROP:text} = caption
  ?text{PROP:text} = TargetText

  IF (BAND(buttons, BUTTON:OK))
    UNHIDE(?OK)
  END
  IF (BAND(buttons, BUTTON:YES))
    UNHIDE(?YES)
  END
  IF (BAND(buttons, BUTTON:NO))
    UNHIDE(?NO)
  END
  IF (BAND(buttons, BUTTON:ABORT))
    UNHIDE(?ABORT)
  END
  IF (BAND(buttons, BUTTON:RETRY))
    UNHIDE(?RETRY)
  END
  IF (BAND(buttons, BUTTON:IGNORE))
    UNHIDE(?IGNORE)
  END
  IF (BAND(buttons, BUTTON:CANCEL))
    UNHIDE(?CANCEL)
  END

  HtmlTarget.Init(GlobalServer.Files)
  WebWindow.Init(GlobalServer, HtmlTarget)
  WebWindow.SetFormatOptions(2, 2, 6, 13)
  WebWindow.CreateClose = CLOSE:Never
  IF (GlobalServer.DialogPageBackColor<>COLOR:None) OR (GlobalServer.DialogPageImage)
    WebWindow.SetPageBackground(GlobalServer.DialogPageBackColor, GlobalServer.DialogPageImage)
  END
  IF (GlobalServer.DialogWinBackColor<>COLOR:None) OR (GlobalServer.DialogWinImage)
    WebWindow.SetBackground(GlobalServer.DialogWinBackColor, GlobalServer.DialogWinImage)
  END
  CurControl &= WebWindow.AddControl(?text)
  CurControl.SetBreakable(TRUE)
  ACCEPT
    IF (ACCEPTED())
      Result = ACCEPTED()
      BREAK
    END
    IF WebWindow.TakeEvent()
      BREAK
    END
  END
  CLOSE(window)
  WebWindow.Kill
  HtmlTarget.Kill
  POST(EVENT:NewPage)                  ! Force an iteration of the accept loop
  RETURN Result


IC:HALT           PROCEDURE(UNSIGNED retcode, <STRING message>)

  CODE
  IF (message)
    IC:MESSAGE(message,'Halt',ICON:Clarion, BUTTON:OK)
  END
  SYSTEM{PROP:halthook} = 0
  GlobalServer.Halt
  HALT()


IC:COLORDIALOG       PROCEDURE(<STRING Title>,*? Result)
  CODE
  MESSAGE(ColorDialogText, UnsupportedHeader)
  RETURN FALSE


IC:FILEDIALOG        PROCEDURE(<STRING Title>,*? Filename,<STRING Filter>,SIGNED Mode)
  CODE
  MESSAGE(FileDialogText, UnsupportedHeader)
  RETURN FALSE


IC:FONTDIALOG        PROCEDURE(<STRING Title>,*? FontName,<*? Size>,<*? Color>,<*? Style>,SIGNED Mode)
  CODE
  MESSAGE(FontDialogText, UnsupportedHeader)
  RETURN FALSE


IC:PRINTERDIALOG     PROCEDURE(<STRING Title>,BOOL setup)
  CODE
  MESSAGE(PrinterDialogText, UnsupportedHeader)
  RETURN FALSE


IC:STOP              PROCEDURE(<STRING StopTitle>)

Result        SIGNED,AUTO
  CODE
  Result = IC:MESSAGE(StopTitle,'Stop',ICON:Clarion, BUTTON:Abort+BUTTON:Ignore, BUTTON:Abort)
  IF (BUTTON:Abort = Result)
    IC:HALT
  END


IC:ASSERT            PROCEDURE(UNSIGNED line, STRING filename)
Message              ANY
  CODE
  Message = AssertText1 & line & AssertText2 & filename & AssertText3

  IF (InAssert)
    IC:ClearHooks
    IC:HALT
  END
  InAssert = TRUE
  IC:MESSAGE(Message, AssertHeaderText)
  IC:HALT
  InAssert = FALSE


IC:FATALERROR        PROCEDURE(UNSIGNED ErrorNo, STRING ErrorText)
Message              ANY
  CODE
  IC:ClearHooks
  Message = ErrorText & '(' & ErrorNo & ')'
  IC:MESSAGE(Message, RunTimeHeaderText)
  IC:HALT


IC:InitializeHooks   PROCEDURE
  CODE
  SYSTEM{PROP:colordialoghook} = ADDRESS(IC:COLORDIALOG)
  SYSTEM{PROP:filedialoghook} = ADDRESS(IC:FILEDIALOG)
  SYSTEM{PROP:fontdialoghook} = ADDRESS(IC:FONTDIALOG)
  SYSTEM{PROP:printerdialoghook} = ADDRESS(IC:PRINTERDIALOG)
  SYSTEM{PROP:halthook} = ADDRESS(IC:HALT)
  SYSTEM{PROP:messagehook} = ADDRESS(IC:MESSAGE)
  SYSTEM{PROP:stophook} = ADDRESS(IC:STOP)
  SYSTEM{PROP:asserthook} = ADDRESS(IC:ASSERT)
  SYSTEM{PROP:fatalerrorhook} = ADDRESS(IC:FATALERROR)

IC:ClearHooks   PROCEDURE
  CODE
  SYSTEM{PROP:colordialoghook} = 0
  SYSTEM{PROP:filedialoghook} = 0
  SYSTEM{PROP:fontdialoghook} = 0
  SYSTEM{PROP:printerdialoghook} = 0
  SYSTEM{PROP:halthook} = 0
  SYSTEM{PROP:messagehook} = 0
  SYSTEM{PROP:stophook} = 0
  SYSTEM{PROP:asserthook} = 0
  SYSTEM{PROP:fatalerrorhook} = 0

