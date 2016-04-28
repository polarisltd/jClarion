
  !ABCIncludeFile(ABL)

OMIT('_EndOfInclude_',_AbcHtmlPropertyPresent_)
_AbcHtmlPropertyPresent_ EQUATE(1)

  INCLUDE ('LAYBUILD.INT'),ONCE
  INCLUDE ('IBCBASE.INC'),ONCE
  INCLUDE ('ABLPROP.INT'),ONCE
  INCLUDE ('LAYVALUE.INT'),ONCE
  INCLUDE ('WSLPROP.INT'),ONCE


FeqQueue                QUEUE,TYPE
cid                       WebControlId
index                     signed
                        END

WbPropertiesClass         CLASS(CInterface),IMPLEMENTS(IProperties),TYPE,MODULE('ABLPROP.CLW'),DLL(_WebCoreDllMode_),LINK('ABLPROP.CLW',_WebCoreLinkMode_)
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,VIRTUAL
SetProperty               PROCEDURE(ASTRING name, STRING value),VIRTUAL
                        END

WbCoreHtmlProperties      CLASS(CInterface),IMPLEMENTS(IHtmlElementProperties),IMPLEMENTS(IControlToHtml),TYPE,MODULE('ABLPROP.CLW'),DLL(_WebCoreDllMode_),LINK('ABLPROP.CLW',_WebCoreLinkMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
AddContents               PROCEDURE(WebControlId Child, SIGNED index)
AddToAllTabs              PROCEDURE(WebControlId Child),PRIVATE
CanContain                PROCEDURE,BOOL,VIRTUAL
GetContainer              PROCEDURE,WebControlId,VIRTUAL
GetDefaultContainerIndex  PROCEDURE,SIGNED,VIRTUAL
GetName                   PROCEDURE,STRING,VIRTUAL
GetPosition               PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),VIRTUAL
GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,VIRTUAL
GetSkeletonAttr           PROCEDURE(SIGNED whichAttr),STRING,VIRTUAL
GetTargetZone             PROCEDURE(),STRING,VIRTUAL
GetVisible                PROCEDURE(),BOOL,VIRTUAL
Init                      PROCEDURE(WebControlId cid)   !,EXTENDS
IsDefaultButton           PROCEDURE,BOOL,VIRTUAL
IsFontNeeded              PROCEDURE,BOOL,VIRTUAL
IsHidden                  PROCEDURE(),BOOL,VIRTUAL
SetProperty               PROCEDURE(ASTRING name, STRING value),VIRTUAL

AfterResponse             PROCEDURE(),VIRTUAL
BeforeResponse            PROCEDURE(),VIRTUAL
TakeResponse              PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor),VIRTUAL

GetIndexInContainer       PROCEDURE(),SIGNED,PROTECTED   !,FINAL

cid                       WebControlId,PROTECTED
Container                 WebControlId
Contents                  &FeqQueue
Map                       &IMapFeqToControl,PROTECTED
Type                      SIGNED,PROTECTED
                        END

  MAP; MODULE('ABLPROP.CLW')
CreateBoolValue           PROCEDURE(BOOL value),*IValue,NAME('ABLPROP$CreateBoolValue')
CreateIntegerValue        PROCEDURE(SIGNED value),*IValue,NAME('ABLPROP$CreateIntegerValue')
CreateStringValue         PROCEDURE(STRING value),*IValue,NAME('ABLPROP$CreateStringValue')
CreateReferenceValue      PROCEDURE(IProperties props),*IValue,NAME('ABLPROP$CREATEREFERENCEVALUE')
CreateCValue              PROCEDURE(SIGNED proptype, CONST * CSTRING value),*IValue,NAME('ABLPROP$CREATECVALUE')
CreateValue               PROCEDURE(SIGNED proptype, STRING value),*IValue,NAME('ABLPROP$CreateValue')
  END; END

_EndOfInclude_
