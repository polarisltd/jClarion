
  !ABCIncludeFile(DOC)


  OMIT('_EndOfInclude_', _ABHtmlPresent_)
_ABHtmlPresent_  EQUATE(1)


  INCLUDE('ABDOC.INC'),ONCE
  INCLUDE('IDOC.INC'),ONCE


  MAP
  END


    OMIT('_ABHTML_AStrings_', _ABHTML_AStrings_)
FT_CellPadding          ASTRING,EXTERNAL,DLL(_DocDllMode_)
FT_Heading              ASTRING,EXTERNAL,DLL(_DocDllMode_)
    _ABHTML_AStrings_


HtmlEngine         CLASS(DocumentEngine),TYPE,MODULE('ABHTML.CLW'),LINK('ABHTML', _DocLinkMode_),DLL(_DocDllMode_)

Construct            PROCEDURE
Destruct             PROCEDURE,VIRTUAL

Kill                 PROCEDURE,DERIVED,VIRTUAL
Layout               PROCEDURE,PROTECTED
TagToID              PROCEDURE(ASTRING TagText),ASTRING,DERIVED,VIRTUAL
TagFromID            PROCEDURE(ASTRING TagID),ASTRING,DERIVED,VIRTUAL

OnDocInitFlush       PROCEDURE,DERIVED,PROTECTED
OnDocCompleteFlush   PROCEDURE,DERIVED,PROTECTED
OnStartComponentFlush PROCEDURE(ComponentGroup ComponentInfo),DERIVED,VIRTUAL,PROTECTED
OnEndComponentFlush  PROCEDURE(ComponentGroup ComponentInfo),DERIVED,VIRTUAL,PROTECTED
OnFlushOption        PROCEDURE(ASTRING strOptionName, *STRING OptionValue),DERIVED,VIRTUAL,PROTECTED

                   END


HtmlDocumentClass  CLASS(AsciiDocumentClass),TYPE,MODULE('ABHTML.CLW'),LINK('ABHTML', _DocLinkMode_),DLL(_DocDllMode_),IMPLEMENTS(IDocumentConstraint),IMPLEMENTS(IDocumentCreate),IMPLEMENTS(IDocumentCreateSerial),IMPLEMENTS(IDocumentRead),IMPLEMENTS(IDocumentPosition),IMPLEMENTS(IDocumentCreateSerialToFile),IMPLEMENTS(IDocumentReadSerial)

Construct            PROCEDURE
Destruct             PROCEDURE,VIRTUAL

Init                 PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct = false),DERIVED,VIRTUAL   !,EXTENDS
Kill                 PROCEDURE,DERIVED,VIRTUAL
InitTags             PROCEDURE,DERIVED,VIRTUAL

CloseFormat          PROCEDURE
SetAutoLineBreak     PROCEDURE(BYTE bAutoLineBreak)

LayoutEngine         &LayoutClass,PROTECTED
SWOpenFormatStack    &Stack,PROTECTED
bTagStarted          BYTE,PROTECTED
szPrevEndToken       CSTRING(8),PROTECTED

                   END

  _EndOfInclude_
