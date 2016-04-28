OMIT('_EndOfInclude_',_ICClientPresent_)
_ICClientPresent_ EQUATE(1)

INCLUDE ('ICSINK.INC')
INCLUDE ('ICJSL.INC')

ClarionComFeq        EQUATE(-29999)

                     ITEMIZE,PRE(BROWSER)
IE30                   EQUATE
IE40                   EQUATE
NetScape3              EQUATE
Mozilla4               EQUATE
Unknown                EQUATE
                     END

BrowserManagerClass  CLASS,MODULE('ICCLIENT.CLW'),LINK('ICCLIENT',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
Init                   PROCEDURE(BYTE, BYTE, BYTE),VIRTUAL

Kind                   BYTE
SetNoCache             BYTE
SupportsStyleSheets    BYTE
SubmitFromJava         BYTE
                     END


WebClientManagerInterface CLASS(WebDataSinkClass),MODULE('ABSTRACT'),TYPE,DLL(BaseClassDllMode)
Feq2Id                 PROCEDURE(SIGNED Feq),UNSIGNED,VIRTUAL
                     END


WebClientManagerClass CLASS(WebClientManagerInterface),MODULE('ICCLIENT.CLW'),TYPE,DLL(BaseClassDllMode)
Feq2Id                 PROCEDURE(SIGNED Feq),UNSIGNED,VIRTUAL
Init                   PROCEDURE(*WebDataSinkClass, *BrowserManagerClass)
Kill                   PROCEDURE
NextHtmlPage           PROCEDURE
SetIP                  PROCEDURE
TakeFile               PROCEDURE(STRING Filename, SIGNED, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING, SIGNED),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED),VIRTUAL

Browser                &BrowserManagerClass
IP                     CSTRING(255)             ! IP address of the client
Jsl                    &JslManagerClass
Broker                 &WebDataSinkClass,PROTECTED
PageNumber             SIGNED,PRIVATE
                     END


_EndOfInclude_
