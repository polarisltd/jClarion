!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaFDBGPresent_)
_vsaFDBGPresent_ EQUATE(1)

DebugFilesClass  CLASS,TYPE,MODULE('VSA_FDBG.CLW'),LINK('VSA_FDBG.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
INIFilename             STRING(255),PRIVATE
Proc                    STRING(255),PRIVATE
Sect                    STRING(255),PRIVATE

Init                    PROCEDURE(STRING pINIFilename,STRING pProc)
SetSection              PROCEDURE(STRING pSect)
CheckFileState          PROCEDURE(FILE pFile)
Kill                    PROCEDURE
                  END

_EndOfInclude_
