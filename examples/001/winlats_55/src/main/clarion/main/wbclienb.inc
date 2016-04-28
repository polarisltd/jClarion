
  OMIT('_EndOfInclude_',_ICClientBPresent_)
_ICClientBPresent_ EQUATE(1)

WbClientManagerInterface CLASS(WbDataSinkClass),MODULE('ABSTRACT'),TYPE,DLL(BaseClassDllMode)
Feq2Id                 PROCEDURE(SIGNED Feq),UNSIGNED,VIRTUAL
                     END

  _EndOfInclude_
