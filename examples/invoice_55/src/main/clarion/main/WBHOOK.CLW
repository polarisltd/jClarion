  MEMBER

  INCLUDE('WBSERVER.INC'),ONCE
  INCLUDE('WBHTML.INC'),ONCE
  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBHOOK.INC'),ONCE
  INCLUDE('WBHOOK.TRN'),ONCE

  INCLUDE('ABLWINR.INC'),ONCE
  INCLUDE('ABLWMAN.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

  MAP
  COMPILE('!End', _VER_C4)
IC:ASSERT           PROCEDURE(UNSIGNED line, STRING filename)
IC:ASSERT2          PROCEDURE(UNSIGNED line, STRING filename, STRING message)
IC:COLORDIALOG      PROCEDURE(<STRING>,*?),SIGNED,PROC
IC:FATALERROR       PROCEDURE(UNSIGNED line, STRING filename)
IC:FILEDIALOG       PROCEDURE(<STRING>,*?,<STRING>,SIGNED=0),PROC,BOOL
IC:FONTDIALOG       PROCEDURE(<STRING>,*?,<*?>,<*?>,<*?>,SIGNED = 0),BOOL,PROC
IC:HALT             PROCEDURE(UNSIGNED=0,<STRING>)
IC:MESSAGE          PROCEDURE(STRING,<STRING>,<STRING>,<STRING>,UNSIGNED=0,BOOL=FALSE),UNSIGNED,PROC
IC:PRINTERDIALOG    PROCEDURE(<STRING>,BOOL=FALSE),BOOL,PROC
IC:STOP             PROCEDURE(<STRING>)
  !End
  OMIT('!End', _VER_C4)
IC:ASSERT           PROCEDURE(UNSIGNED line, STRING filename)
IC:ASSERT2          PROCEDURE(UNSIGNED line, STRING filename, STRING message)
IC:COLORDIALOG      PROCEDURE(<STRING>,*?),SIGNED,PROC
IC:FATALERROR       PROCEDURE(UNSIGNED line, STRING filename)
IC:FILEDIALOG       PROCEDURE(<STRING>,*?,<STRING>,SIGNED=0),PROC,BOOL
IC:FONTDIALOG       PROCEDURE(<STRING>,*?,<*?>,<*?>,<*?>,SIGNED = 0),BOOL,PROC
IC:HALT             PROCEDURE(UNSIGNED=0,<STRING>)
IC:MESSAGE          PROCEDURE(STRING,<STRING>,<STRING>,UNSIGNED=0,UNSIGNED=0,BOOL=FALSE),UNSIGNED,PROC
IC:PRINTERDIALOG    PROCEDURE(<STRING>,BOOL=FALSE),BOOL,PROC
IC:STOP             PROCEDURE(<STRING>)
  !End
  END

InAssert        BYTE

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
Result               SIGNED(BUTTON:CANCEL)
NextIndex            SIGNED,AUTO
StartIndex           SIGNED,AUTO
TargetText           ANY

GlobalServer         &WbServerClass

WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
                     END
  CODE
  Buttons = buttonStr
  IF buttons = 0 THEN buttons = BUTTON:OK.

  StartIndex = 1
  LOOP
    NextIndex = INSTRING('|', Text, 1, StartIndex)
    IF (NextIndex = 0)
      TargetText = TargetText & SUB(Text, StartIndex, -1)
      BREAK
    END
    TargetText = TargetText & Text[StartIndex : NextIndex - 1] & '<13,10>'
    StartIndex = NextIndex + 1
  END

  GlobalServer &= WbServerClass::Get()
  OPEN(window)
  WebWindow.Init()
  WebWindowManager.Init(GlobalServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (Main)')
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

  ACCEPT
    if (WebWindow.WindowComponent.TakeEvent() OR |
        WebWindowManager.WindowComponent.TakeEvent())
      BREAK
    END
    IF (ACCEPTED())
      Result = ACCEPTED()
      BREAK
    END
  END
  CLOSE(window)
  WebWindow.Kill()
  WebWindowManager.Kill()
  POST(EVENT:NewPage)                  ! Force an iteration of the accept loop
  RETURN Result

WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  SELF.SetFormatOptions(2, 2, 6, 13)

IC:HALT           PROCEDURE(UNSIGNED retcode, <STRING message>)

GlobalServer         &WbServerClass
  CODE
  IF (message)
    IC:MESSAGE(message,'Halt',ICON:Clarion, BUTTON:OK)
  END
  SYSTEM{PROP:halthook} = 0
  GlobalServer &= WbServerClass::Get()
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
  CODE
  IC:ASSERT2(line, filename,'')


IC:ASSERT2           PROCEDURE(UNSIGNED line, STRING filename, STRING extra)
Message              ANY
AllowContinue        BOOL(TRUE)
Chosen               SIGNED(Button:No)
  CODE
  Message = AssertText1 & line & AssertText2 & filename & AssertText3
  IF (extra)
    Message = Message & '<10>' & extra
  END

  IF (InAssert)
    IC:ClearHooks
?   MESSAGE('Assert called recursively (?failure in html generation).<10> [' & message & ']','Internal error')
    IC:HALT
  END

  InAssert = TRUE
  IF (AllowContinue)
    Chosen = IC:MESSAGE(Message & AssertContinueText, AssertHeaderText, ICON:Question, BUTTON:Yes+BUTTON:No)
  ELSE
    IC:MESSAGE(Message, AssertHeaderText)
  END

  IF (Chosen <> BUTTON:Yes)
    IC:HALT
  END
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
  SYSTEM{PROP:asserthook2} = ADDRESS(IC:ASSERT2)
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
  SYSTEM{PROP:asserthook2} = 0
  SYSTEM{PROP:fatalerrorhook} = 0

