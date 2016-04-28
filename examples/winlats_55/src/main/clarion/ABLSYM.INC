  !ABCIncludeFile(ABL)

OMIT('_EndOfInclude_',_AblSymPresent_)
_AblSymPresent_ EQUATE(1)

       INCLUDE('ABLPROP.INC'),ONCE

WbBrowserPropertiesClass CLASS(WbPropertiesClass),TYPE,MODULE('ABLSYM.CLW'),DLL(_WebCoreDllMode_),LINK('ABLSYM.CLW',_WebCoreLinkMode_)
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,DERIVED
Init                      PROCEDURE(WbBrokerClass Broker)   !,EXTENDS

Broker                    &WbBrokerClass
                        END

WbBrowserProperties     WbBrowserPropertiesClass,DLL(_WebCoreDllMode_)

_EndOfInclude_
