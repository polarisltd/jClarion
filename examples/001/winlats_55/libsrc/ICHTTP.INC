OMIT('_EndOfInclude_',_ICHttpPresent_)
_ICHttpPresent_ EQUATE(1)

INCLUDE('ICTXTOUT.INC')
INCLUDE('ICFILES.INC')

NewLine              EQUATE('<13,10>')

HttpInfoQueue        QUEUE,TYPE
Name                   CSTRING(40)
Value                  CSTRING(255)
Special                SIGNED
                     END

CookiesQueue         QUEUE,TYPE
Name                   CSTRING(40)
Value                  CSTRING(255)
Path                   CSTRING(255)
ExpireDate             LONG
ExpireTime             LONG
Modified               BYTE
                     END

! To forward ref. real class HttpClass
HttpBaseClass        CLASS,MODULE('Abstract'),TYPE
GetBrowserProperty     PROCEDURE(STRING),STRING,VIRTUAL
SetBrowserProperty     PROCEDURE(STRING, STRING),PROTECTED,VIRTUAL
GetServerProperty      PROCEDURE(STRING),STRING,VIRTUAL
SetServerProperty      PROCEDURE(STRING, STRING, SIGNED=0, SIGNED=0),VIRTUAL
SendCookies            PROCEDURE,VIRTUAL

BrowserInfo            &HttpInfoQueue
ServerInfo             &HttpInfoQueue
Cookies                &CookiesQueue
                     END

HttpPageBaseClass    CLASS,MODULE('IcHttp.clw'),LINK('ICHTTP',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
! convention members.
Init                   PROCEDURE(*HttpBaseClass, SIGNED, STRING, STRING)
Kill                   PROCEDURE

! private utility members.
AppendFileTo           PROCEDURE(STRING, STRING, BYTE=0),SIGNED,PROC,PRIVATE

! protected members - allow derived classes to add/change functionality
SetupHttpStatus        PROCEDURE(SIGNED status),PROTECTED
WritePageBody          PROCEDURE,VIRTUAL,PROTECTED
HandleStatusCode       PROCEDURE,VIRTUAL,PROTECTED
PreparePageBody        PROCEDURE,VIRTUAL,PROTECTED
AppendDefaultBody      PROCEDURE,VIRTUAL,PROTECTED

! public access function (for response processing + setting)
PreparePage            PROCEDURE,VIRTUAL
FinishPage             PROCEDURE,VIRTUAL

! protected member variable
PageFilename           CSTRING(FILE:MaxFileName),PROTECTED
HtmlFilename           CSTRING(FILE:MaxFileName),PROTECTED
FileLen                ULONG,PROTECTED
FileHandler            &TextOutputClass,PROTECTED
Status                 SIGNED,PROTECTED
GotHtmlBody            BYTE,PROTECTED
ExpireDateTime         STRING(100),PROTECTED
NowDateTime            STRING(100),PROTECTED
Http                   &HttpBaseClass,PROTECTED
                     END


HttpPageBrowserClass CLASS(HttpPageBaseClass),MODULE('IcHttp.clw'),TYPE,DLL(BaseClassDllMode)
PreparePageBody        PROCEDURE,VIRTUAL,PROTECTED
HandleStatusCode       PROCEDURE,VIRTUAL,PROTECTED
FinishPage             PROCEDURE,VIRTUAL
                     END


HttpPageJavaClass    CLASS(HttpPageBaseClass),MODULE('IcHttp.clw'),TYPE,DLL(BaseClassDllMode)
                     END


HttpClass            CLASS(HttpBaseClass),MODULE('IcHttp.clw'),TYPE,DLL(BaseClassDllMode)
! convention members.
Init                   PROCEDURE(WebFilesClass)
Kill                   PROCEDURE

! private utility members.
ClearUp                PROCEDURE,PRIVATE
ProcessInfoLine        PROCEDURE(STRING),PRIVATE

! protected members - allow derived classes to add functionality e.g SetCookie.
SetBrowserProperty     PROCEDURE(STRING, STRING),PROTECTED,VIRTUAL
SetServerProperty      PROCEDURE(STRING, STRING, SIGNED=0, SIGNED=0),VIRTUAL
PreparePage            PROCEDURE(*HttpPageBaseClass, SIGNED, <STRING>),VIRTUAL,PROTECTED

! public access function (for request processing + retrieval)
ProcessHeader          PROCEDURE(STRING)
GetArguments           PROCEDURE(),STRING
GetBrowserProperty     PROCEDURE(STRING),STRING,VIRTUAL
!DebugBrowserInfo       PROCEDURE

! public access function (for response processing + setting)
FinishPage             PROCEDURE
GetAuthorizedInfo      PROCEDURE(*STRING, *STRING)
GetCookie              PROCEDURE(STRING),STRING
GetServerProperty      PROCEDURE(STRING),STRING,VIRTUAL
PreparePageForBrowser  PROCEDURE(SIGNED, <STRING>)
PreparePageForJava     PROCEDURE(SIGNED, <STRING>)
PrepareUnauthorized    PROCEDURE(<STRING>)
SendCookies            PROCEDURE,VIRTUAL
SetCookie              PROCEDURE(STRING, STRING, LONG=0, LONG=0, <STRING>)
SetCookieModified      PROCEDURE(BYTE, STRING, STRING, LONG=0, LONG=0, <STRING>),PRIVATE
SetProgName            PROCEDURE(STRING)
SetProcName            PROCEDURE(STRING)
StoreCookies           PROCEDURE(STRING),PRIVATE
StoreCookie            PROCEDURE(STRING),PRIVATE

! protected member variables
Arguments              ANY,PROTECTED
Files                  &WebFilesClass
ProgName               CSTRING(255),PROTECTED
ProcName               CSTRING(255),PROTECTED
HttpPage               &HttpPageBaseClass,PROTECTED
                     END
_EndOfInclude_

