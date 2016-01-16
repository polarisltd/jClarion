!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaAutoLookupPresent_)
_vsaAutoLookupPresent_ EQUATE(1)

AutoLookupQ         QUEUE,TYPE
FEQ                   LONG
ButtonFEQ             LONG
                    END

AutoLookupClass  CLASS,TYPE,MODULE('VSA_AKEY.CLW'),LINK('VSA_AKEY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Q                       &AutoLookupQ,PRIVATE
AlertKey                LONG,PRIVATE
Init                    PROCEDURE(LONG AlertKey,BYTE SetSkip=0)
AddPair                 PROCEDURE(LONG PreviousField,LONG ThisField,BYTE SetSkip=0)
TakeAlertKey            PROCEDURE
Kill                    PROCEDURE
                  END

_EndOfInclude_

