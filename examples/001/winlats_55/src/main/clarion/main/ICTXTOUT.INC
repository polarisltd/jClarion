OMIT('_EndOfInclude_',_ICTxtOutPresent_)
_ICTxtOutPresent_ EQUATE(1)

TextOutputClass      CLASS,TYPE,MODULE('ICTXTOUT.CLW'),LINK('ICTXTOUT',LinkBaseClasses),DLL(BaseClassDllMode)
Close                  PROCEDURE
Open                   PROCEDURE(STRING)
CreateOpen             PROCEDURE(STRING)
GetSize                PROCEDURE(STRING),ULONG
Write                  PROCEDURE(STRING)
Writeln                PROCEDURE(<STRING>)
                     END

_EndOfInclude_
