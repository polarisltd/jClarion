  OMIT('_EndOfInclude_',_ICHttpBPresent_)
_ICHttpBPresent_ EQUATE(1)

WbHttpBaseClass      CLASS,MODULE('Abstract'),TYPE
GetBrowserProperty     PROCEDURE(STRING PropName),STRING,VIRTUAL
SetBrowserProperty     PROCEDURE(STRING PropName, STRING Value),PROTECTED,VIRTUAL
GetServerProperty      PROCEDURE(STRING PropName),STRING,VIRTUAL
SetServerProperty      PROCEDURE(STRING PropName, STRING Value, SIGNED Special=0, SIGNED Multiple=0),VIRTUAL
SendCookies            PROCEDURE,VIRTUAL

BrowserInfo            &HttpInfoQueue
ServerInfo             &HttpInfoQueue
Cookies                &CookiesQueue
                     END

  _EndOfInclude_

