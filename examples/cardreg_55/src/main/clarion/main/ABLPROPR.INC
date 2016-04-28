
  !ABCIncludeFile(ABL)

OMIT('_EndOfInclude_',_AbcHtmlPropertyRuntimePresent_)
_AbcHtmlPropertyRuntimePresent_ EQUATE(1)

  INCLUDE ('ABLPROP.INC'),ONCE


WbCoreRunHtmlProperties CLASS(WbCoreHtmlProperties),TYPE,MODULE('ABLPROPR.CLW'),DLL(_WebRunDllMode_),LINK('ABLPROPR.CLW',_WebRunLinkMode_)
GetName                   PROCEDURE,STRING,DERIVED
GetPosition               PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),DERIVED
Init                      PROCEDURE(SIGNED Feq, SIGNED Container)   !,EXTENDS

Feq                       WebControlId,PROTECTED
                        END

WbControlHtmlProperties CLASS(WbCoreRunHtmlProperties),TYPE,MODULE('ABLPROPR.CLW'),DLL(_WebRunDllMode_),LINK('ABLPROPR.CLW',_WebRunLinkMode_)
CanContain                PROCEDURE,BOOL,DERIVED
Destruct                  PROCEDURE,VIRTUAL
GetDefaultContainerIndex  PROCEDURE,SIGNED,DERIVED
GetEmbedText              PROCEDURE(ASTRING embed),STRING,VIRTUAL
GetInstanceName           PROCEDURE,STRING,VIRTUAL
GetName                   PROCEDURE,STRING,DERIVED
GetPosition               PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),DERIVED
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr           PROCEDURE(SIGNED whichAttr),STRING,DERIVED
GetTargetZone             PROCEDURE(),STRING,DERIVED
GetVisible                PROCEDURE(),BOOL,DERIVED
Init                      PROCEDURE(SIGNED Feq, SIGNED Container)   !,EXTENDS
IsDefaultButton           PROCEDURE,BOOL,DERIVED
IsFontNeeded              PROCEDURE,BOOL,DERIVED
IsHidden                  PROCEDURE(),BOOL,VIRTUAL
SetProperty               PROCEDURE(ASTRING name, STRING value),DERIVED

AfterResponse             PROCEDURE(),VIRTUAL
BeforeResponse            PROCEDURE(),VIRTUAL
TakeResponse              PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor),VIRTUAL

ChangeContents            PROCEDURE(STRING newValue, bool PostEvent=true),PROTECTED
GetHotKey                 PROCEDURE(),STRING,PROTECTED          !,FINAL
GetPixelHeight            PROCEDURE(),SIGNED,PROTECTED          !,FINAL
GetPixelWidth             PROCEDURE(),SIGNED,PROTECTED          !,FINAL
GetExtraProperty          PROCEDURE(ASTRING name),*IValue,PROTECTED!,FINAL
HasChildOfType            PROCEDURE(SIGNED type, BOOL Invert=FALSE),BOOL,PROTECTED!,FINAL
Post                      PROCEDURE(SIGNED EventNo),PROTECTED
PostEvent                 PROCEDURE(SIGNED EventNo),PROTECTED,VIRTUAL
SetExtraProperty          PROCEDURE(ASTRING name, IValue value),PROTECTED!,FINAL
SetExtraProperty          PROCEDURE(ASTRING name, STRING value, SIGNED type=WslPropType:string),PROTECTED!,FINAL

FieldName                 ASTRING
From                      &IMappedListContents,PROTECTED
Properties                &PropertyQueue
DelayPost                 CBOOL,private
HadResponse               CBOOL
HasUseVar                 CBOOL
EventProcessor            &IWbEventProcessor
SubmitOnChange            CBOOL
SuppressInsertion         CBOOL
WasVisible                CBOOL
                        END

WbQueryButtonHtmlProperties CLASS(WbControlHtmlProperties),TYPE,MODULE('ABLPROPR.CLW'),DLL(_WebRunDllMode_),LINK('ABLPROPR.CLW',_WebRunLinkMode_)
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr           PROCEDURE(SIGNED whichAttr),STRING,DERIVED
TakeResponse              PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor),DERIVED
                        END

WbWindowHtmlProperties  CLASS(WbControlHtmlProperties),TYPE,MODULE('ABLPROPR.CLW'),DLL(_WebRunDllMode_),LINK('ABLPROPR.CLW',_WebRunLinkMode_)
GetContainer              PROCEDURE,WebControlId,DERIVED
GetName                   PROCEDURE,STRING,DERIVED
GetPosition               PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),DERIVED
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=1, unsigned idx2=1),*IValue,DERIVED
GetSkeletonAttr           PROCEDURE(SIGNED whichAttr),STRING,DERIVED
Init                      PROCEDURE()   !,EXTENDS
SetTimeOut                PROCEDURE(SIGNED Delay)

TimeOutDelay              SIGNED,PROTECTED
                        END


OMIT('***', _DefineEmbedNames_)
A:EmbedAfterControl     ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBeforeControl    ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedAfterWindow      ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedInsideTitle      ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBeforeWindow     ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedMetaTags         ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBeforeHeadClose  ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBeforeBodyOpen   ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedTopOfForm        ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBottomOfForm     ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
A:EmbedBeforeHtmlClose  ASTRING,EXTERNAL,DLL(_WebRunDllMode_)
***
  MAP
    MODULE('ABLPROPR')
SetSkeletonTheme      PROCEDURE(STRING theme),NAME('_SetSkeletonTheme@F')
    END
  END


_EndOfInclude_
