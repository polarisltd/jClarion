
  OMIT('_EndOfInclude_',_ICSinkPresent_)
_ICSinkPresent_ EQUATE(1)

WbDataSinkClass     CLASS,MODULE('ABSTRACT'),TYPE
TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL
                     END

  _EndOfInclude_
