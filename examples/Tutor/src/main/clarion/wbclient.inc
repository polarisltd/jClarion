!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICClientPresent_)
_ICClientPresent_ EQUATE(1)

  INCLUDE ('WBSINK.INC'),ONCE

ClarionComFeq        EQUATE(-29999)

                     ITEMIZE,PRE(BROWSER)
IE30                   EQUATE
IE40                   EQUATE
NetScape3              EQUATE
Mozilla4               EQUATE
Unknown                EQUATE
                     END

WbBrowserManagerClass  CLASS,MODULE('WBCLIENT.CLW'),LINK('WBCLIENT', _WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
Init                   PROCEDURE(BYTE Kind, BYTE _SSS, BYTE _SFJ),VIRTUAL

Kind                   BYTE
SetNoCache             BYTE
SupportsStyleSheets    BYTE
SubmitFromJava         BYTE
                     END


  INCLUDE('WBCLIENB.INC')

WbClientManagerClass CLASS(WbClientManagerInterface),MODULE('WBCLIENT.CLW'),LINK('WBCLIENT', _WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
Feq2Id                 PROCEDURE(SIGNED Feq),UNSIGNED,VIRTUAL
Init                   PROCEDURE(WbDataSinkClass Broker, WbBrowserManagerClass Browser)   !,EXTENDS
Kill                   PROCEDURE
NextHtmlPage           PROCEDURE
SetIP                  PROCEDURE
TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL

Browser                &WbBrowserManagerClass
IP                     CSTRING(255)             ! IP address of the client
Broker                 &WbDataSinkClass,PROTECTED
PageNumber             SIGNED,PRIVATE
                     END


  _EndOfInclude_
