
!ABCIncludeFile

OMIT('_EndOfInclude_',_SystemErrorPresent_)
_SystemErrorPresent_ EQUATE(1)

tSysErrQ    QUEUE,TYPE
seValue        LONG
seText         &STRING
            END

vSystemErrorClass             CLASS,TYPE,MODULE('VSA_AERR.CLW'),LINK('VSA_AERR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)

SysErrQ                         &tSysErrQ

Init                            PROCEDURE()
Kill                            PROCEDURE()
GetErrorCode                    PROCEDURE(),LONG
GetError                        PROCEDURE(),STRING
GetError                        PROCEDURE(LONG pErrorCode),STRING
                              END

_EndOfInclude_
