!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_WBHttpPresent_)
_WBHttpPresent_ EQUATE(1)

  INCLUDE('IBCBASE.INC'),ONCE
  INCLUDE('WBHTTP.INT'),ONCE
  INCLUDE('WBTXTOUT.INC'),ONCE
  INCLUDE('WBFILES.INC'),ONCE

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

  INCLUDE('WBHTTPB.INC')

WbHttpPageBaseClass    CLASS,MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
! convention members.
Init                   PROCEDURE(WbHttpBaseClass Http, SIGNED Status, STRING Page, STRING TempFilename)   !,EXTENDS
Kill                   PROCEDURE

! private utility members.
AppendFileTo           PROCEDURE(STRING SrcFile, STRING DestFile, BYTE DeleteSrc = 0),SIGNED,PROC,PRIVATE

! protected members - allow derived classes to add/change functionality
SetupHttpStatus        PROCEDURE(SIGNED status),PROTECTED
WritePageBody          PROCEDURE,VIRTUAL,PROTECTED
HandleStatusCode       PROCEDURE,VIRTUAL,PROTECTED
PreparePageBody        PROCEDURE,VIRTUAL,PROTECTED
AppendDefaultBody      PROCEDURE,VIRTUAL,PROTECTED

! public access function (for response processing + setting)
PreparePage            PROCEDURE,VIRTUAL
FinishPage             PROCEDURE,STRING,VIRTUAL

! protected member variable
PageFilename           CSTRING(FILE:MaxFileName),PROTECTED
HtmlFilename           CSTRING(FILE:MaxFileName),PROTECTED
FileLen                ULONG,PROTECTED
FileHandler            &WbTextOutputClass,PROTECTED
Status                 SIGNED,PROTECTED
GotHtmlBody            BYTE,PROTECTED
ExpireDateTime         STRING(100),PROTECTED
NowDateTime            STRING(100),PROTECTED
Http                   &WbHttpBaseClass,PROTECTED
                     END


WbHttpPageBrowserClass CLASS(WbHttpPageBaseClass),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
PreparePageBody        PROCEDURE,VIRTUAL,PROTECTED
HandleStatusCode       PROCEDURE,VIRTUAL,PROTECTED
FinishPage             PROCEDURE,STRING,DERIVED
                     END


WbHttpPageJavaClass    CLASS(WbHttpPageBaseClass),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
                     END


WbHttpClass            CLASS(WbHttpBaseClass),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
! convention members.
Init                   PROCEDURE(WbFilesClass Files)   !,EXTENDS
Kill                   PROCEDURE

! private utility members.
ClearUp                PROCEDURE,PRIVATE
ProcessInfoLine        PROCEDURE(STRING Line),PRIVATE

! protected members - allow derived classes to add functionality e.g SetCookie.
SetBrowserProperty     PROCEDURE(STRING PropName, STRING Value),PROTECTED,VIRTUAL
SetServerProperty      PROCEDURE(STRING PropName, STRING Value, SIGNED Special=0, SIGNED Multiple=0),VIRTUAL
PreparePage            PROCEDURE(WbHttpPageBaseClass HttpPage, SIGNED Status, <STRING Filename>),VIRTUAL,PROTECTED

! public access function (for request processing + retrieval)
ProcessHeader          PROCEDURE(STRING Page)
GetArguments           PROCEDURE(),STRING
CreateArgumentIterator PROCEDURE,*IWbArgumentIterator
SetArguments           PROCEDURE(STRING args)
GetBrowserProperty     PROCEDURE(STRING PropName),STRING,VIRTUAL
!DebugBrowserInfo       PROCEDURE

! public access function (for response processing + setting)
FinishPage             PROCEDURE,STRING
GetAuthorizedInfo      PROCEDURE(*STRING User, *STRING Pass)
GetCookie              PROCEDURE(STRING Name),STRING
GetServerProperty      PROCEDURE(STRING PropName),STRING,VIRTUAL
PreparePageForBrowser  PROCEDURE(SIGNED Status, <STRING Filename>)
PreparePageForJava     PROCEDURE(SIGNED Status, <STRING Filename>)
PrepareUnauthorized    PROCEDURE(<STRING Filename>)
SendCookies            PROCEDURE,VIRTUAL
SetCookie              PROCEDURE(STRING Name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>)
SetCookieModified      PROCEDURE(BYTE Modified, STRING Name, STRING Value, LONG ExpireDate=0, LONG ExpireTime=0, <STRING Path>),PRIVATE
SetProgName            PROCEDURE(STRING ProgName)
SetProcName            PROCEDURE(STRING ProcName)
StoreCookies           PROCEDURE(STRING Cookies),PRIVATE
StoreCookie            PROCEDURE(STRING Cookie),PRIVATE

! protected member variables
Arguments              &STRING,PROTECTED
Files                  &WbFilesClass
IsPost                 BOOL,PRIVATE
ProgName               CSTRING(255),PROTECTED
ProcName               CSTRING(255),PROTECTED
HttpPage               &WbHttpPageBaseClass,PROTECTED
                     END

WbArgumentIterator      CLASS(CInterface),IMPLEMENTS(IWbArgumentIterator),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
FirstArgument             PROCEDURE,CBOOL,PROC,PROTECTED,VIRTUAL
GetName                   PROCEDURE,STRING,PROTECTED,VIRTUAL
GetValue                  PROCEDURE,STRING,PROTECTED,VIRTUAL
Init                      PROCEDURE(* STRING Arguments)   !,EXTENDS
NextArgument              PROCEDURE,CBOOL,PROC,PROTECTED,VIRTUAL
Arguments                 &STRING,PROTECTED
CurIndex                  SIGNED,PROTECTED
EndIndex                  SIGNED,PROTECTED
Length                    SIGNED,PROTECTED
                        END

WbUrlEncodingIterator   CLASS(WbArgumentIterator),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
FirstArgument             PROCEDURE,CBOOL,PROTECTED,DERIVED
FindNext                  PROCEDURE(SIGNED StartIndex),CBOOL,PROTECTED
GetName                   PROCEDURE,STRING,PROTECTED,DERIVED
GetValue                  PROCEDURE,STRING,PROTECTED,DERIVED
Init                      PROCEDURE(* STRING Arguments)   !,EXTENDS
NextArgument              PROCEDURE,CBOOL,PROTECTED,DERIVED
AssignIndex               SIGNED,PROTECTED
                        END

WbMultiPartIterator     CLASS(WbArgumentIterator),MODULE('WBHTTP.CLW'),LINK('WBHTTP',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
ExtractArgument           PROCEDURE(STRING name, * SIGNED StartArg, * SIGNED EndArg),PROTECTED
FirstArgument             PROCEDURE,CBOOL,PROTECTED,DERIVED
FindNext                  PROCEDURE(SIGNED StartIndex),CBOOL,PROTECTED
GetName                   PROCEDURE,STRING,PROTECTED,DERIVED
GetValue                  PROCEDURE,STRING,PROTECTED,DERIVED
Init                      PROCEDURE(* STRING Arguments, STRING boundary)   !,EXTENDS
NextArgument              PROCEDURE,CBOOL,PROTECTED,DERIVED
NextLine                  PROCEDURE,BOOL,PROC,PROTECTED
ResetLine                 PROCEDURE(SIGNED startIndex),BOOL,PROC,PROTECTED
boundary                  CSTRING(80)
EndLen                    SIGNED,PROTECTED
EndOfFilename             SIGNED,PROTECTED
EndOfName                 SIGNED,PROTECTED
EndOfValue                SIGNED,PROTECTED
StartOfFilename           SIGNED,PROTECTED
StartOfName               SIGNED,PROTECTED
StartOfValue              SIGNED,PROTECTED
                        END

  _EndOfInclude_

