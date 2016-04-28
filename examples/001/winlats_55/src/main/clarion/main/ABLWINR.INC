                                             !ABCIncludeFile(ABL)

OMIT('_EndOfInclude_',_AbcHtmlWindowRuntimePresent_)
_AbcHtmlWindowRuntimePresent_ EQUATE(1)

  INCLUDE ('IBARRAY.INC'),ONCE
  INCLUDE ('ABLWIN.INC'),ONCE

WbWindowClass          CLASS(WbWindowBaseClass),IMPLEMENTS(IWebResponseProcessor),IMPLEMENTS(IWbEventProcessor),TYPE,MODULE('ABLWINR.CLW'),DLL(_WebRunDllMode_),LINK('ABLWINR.CLW',_WebRunLinkMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE
Init                      PROCEDURE                   !,EXTENDS
ResetFromWindow           PROCEDURE,DERIVED
TakeUnknownResponse       PROCEDURE(STRING name, STRING value),VIRTUAL

CreateDefault             PROCEDURE(SIGNED Feq),*IControlToHtml,PROTECTED,PROC
CreateDefaultWindow       PROCEDURE(),PROTECTED
ResetFromControl          PROCEDURE(WebControlId id),*IControlToHtml,PROTECTED,PROC

DefaultButton             SIGNED
DefaultButtonNeeded       BYTE
Delayed                   &Array
                        END

_EndOfInclude_
