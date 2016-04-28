!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICServerPresent_)
_ICServerPresent_ EQUATE(1)

  INCLUDE ('WBHTTP.INT'),ONCE
  INCLUDE ('WBCLIENT.INC'),ONCE
  INCLUDE ('WBBROKER.INC'),ONCE
  INCLUDE ('WBFILES.INC'),ONCE

! Internet classes and types

NET:Unknown          EQUATE(0)
NET:Terminate        EQUATE(1)
NET:Request          EQUATE(2)

ISubmitItem          INTERFACE
Reset                  PROCEDURE(STRING Name, STRING Value),BOOL
                     END


WbSubmitItemClass      CLASS,IMPLEMENTS(ISubmitItem),MODULE('WBSERVER.CLW'),LINK('WBSERVER',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
Destruct               PROCEDURE
Reset                  PROCEDURE(STRING Name, STRING Value),BOOL,VIRTUAL
Name                   ANY
NewValue               ANY
                     END

WbShutDownClass        CLASS,MODULE('WBSERVER.CLW'),LINK('WBSERVER',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
Close                  PROCEDURE,VIRTUAL
                     END


WbServerClass       CLASS,MODULE('WBSERVER.CLW'),LINK('WBSERVER',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
Connect                PROCEDURE
IsEnabled              PROCEDURE,BYTE
GetReadyForPage        PROCEDURE,BYTE
GetRequestedWholePage  PROCEDURE,BYTE
GetSendWholePage       PROCEDURE,BYTE
Halt                   PROCEDURE
Init                   PROCEDURE(WbBrokerClass TheBroker, WbShutDownClass TheShutDownManager, <STRING PageToReturnTo>, SIGNED TimeOut, <STRING JavaLibraryPath>, WbFilesClass TheFiles)   !,EXTENDS
Kill                   PROCEDURE
ProcessRequest         PROCEDURE(),SIGNED,PRIVATE
Quit                   PROCEDURE,VIRTUAL
SetDialogPageBackground    PROCEDURE(LONG BackColor=COLOR:None, <STRING Image>)
SetDialogWindowBackground  PROCEDURE(LONG BackColor=COLOR:None, <STRING Image>)
SetSendWholePage       PROCEDURE(BYTE Needed)
SetNewPageDisable      PROCEDURE(SIGNED DoDisable)        ! Call to disable sending a new page, until an external event has occured.
SetNextAction          PROCEDURE(ISubmitItem next),BOOL
TakeEvent              PROCEDURE,BYTE,VIRTUAL
TakeRegisteredEvent    PROCEDURE,BYTE,VIRTUAL
TakeRequest            PROCEDURE,PRIVATE,NAME('WebServer$TakeRequest')  ! called from RPC
TakePageSent           PROCEDURE

Aborting               BYTE,PRIVATE
IsActive               SIGNED(FALSE)            ! Was this program started via the Application Broker?
Arguments              &IWbArgumentIterator,PRIVATE
Broker                 &WbBrokerClass
Client                 &WbClientManagerClass
CommandLine            ANY                      ! Program options e.g. /../myprog.exe.0/?args
DialogPageBackColor    LONG
DialogPageImage        CSTRING(FILE:MaxFileName)
DialogWinBackColor     LONG
DialogWinImage         CSTRING(FILE:MaxFileName)
Disabled               BYTE,PRIVATE
Files                  &WbFilesClass
GotCommandLine         BYTE
IgnoreRequest          BYTE,PRIVATE
InRequest              BYTE,PRIVATE
JavaLibraryPath        CSTRING(FILE:MaxFileName)
LastRequest            LONG,PRIVATE
PageToReturnTo         CSTRING(FILE:MaxFileName)
RequestPending         BYTE,PRIVATE
RequestedWholePage     BYTE,PRIVATE
SendWholePage          BYTE,PRIVATE
ShutDownManager        &WbShutDownClass,PRIVATE
TimeOut                SIGNED
WindowOpened           BYTE
                     END

  MAP
    MODULE('WBSERVER')
WbServerClass::Get  PROCEDURE(),*WbServerClass,NAME('_12WbServerClass__Get@F')
    END
  END

  _EndOfInclude_
