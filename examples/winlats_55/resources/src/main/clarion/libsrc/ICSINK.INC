OMIT('_EndOfInclude_',_ICSinkPresent_)
_ICSinkPresent_ EQUATE(1)

WebDataSinkClass     CLASS,MODULE('ABSTRACT'),TYPE
TakeFile               PROCEDURE(STRING Filename, SIGNED, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING, SIGNED),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED),VIRTUAL
                     END

_EndOfInclude_
