!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICTxtOutPresent_)
_ICTxtOutPresent_ EQUATE(1)

WbTextOutputClass      CLASS,TYPE,MODULE('WBTXTOUT.CLW'),LINK('WBTXTOUT', _WebAbcLinkMode_),DLL(_WebAbcDllMode_)
Close                  PROCEDURE
Open                   PROCEDURE(STRING Filename)
CreateOpen             PROCEDURE(STRING Filename)
GetSize                PROCEDURE(STRING Filename),ULONG
Write                  PROCEDURE(STRING Text)
Writeln                PROCEDURE(<STRING Text>)
                     END

  _EndOfInclude_
