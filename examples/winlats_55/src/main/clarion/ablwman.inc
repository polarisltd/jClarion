!ABCIncludeFile(ABL)

  OMIT('_EndOfInclude_',_WebWindowManagerPresent_)
_WebWindowManagerPresent_ EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('WBHTML.INC'),ONCE
  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('WBSERVER.INC'),ONCE
  INCLUDE('ABLWMAN.INT'),ONCE

WbWindowManagerClass CLASS,IMPLEMENTS(WindowComponent),TYPE,MODULE('ABLWMAN.CLW'),LINK('ABLWMAN',_WebAbcLinkMode_),DLL(_WebAbcDllMode_)
CreateDummyHtmlPage    PROCEDURE(STRING HtmlFilename),VIRTUAL
CreateUnauthorizedPage PROCEDURE(STRING HtmlFilename),VIRTUAL
GetAuthorized          PROCEDURE,BYTE
GetTargetSecurity      PROCEDURE,SIGNED
Init                   PROCEDURE(WbServerClass Server, IPageCreator creator, IWebResponseProcessor ResponseProcessor, <STRING AuthorizeArea>)  !,EXTENDS
Kill                   PROCEDURE,VIRTUAL
SetPassword            PROCEDURE(<STRING Password>, BYTE CaseSensitive=FALSE)
TakeCreatePage         PROCEDURE,VIRTUAL
TakeEvent              PROCEDURE,BYTE,PROC,VIRTUAL
TakeRegisteredEvent    PROCEDURE,BYTE,PRIVATE
TakeRequest            PROCEDURE,VIRTUAL
ValidatePassword       PROCEDURE(STRING UserName, STRING Password),BYTE,VIRTUAL

Authorize              BYTE
AuthorizeArea          ANY
AuthorizeFailed        BYTE,PRIVATE
Files                  &WbFilesClass
HtmlTarget             &WbHtmlClass
IsSecure               BYTE
PageCreator            &IPageCreator
Password               CSTRING(30),PRIVATE
PasswordCaseSensitive  BYTE,PRIVATE
ResponseProcessor      &IWebResponseProcessor
SentHtml               BYTE
Server                 &WbServerClass
                     END

  _EndOfInclude_
