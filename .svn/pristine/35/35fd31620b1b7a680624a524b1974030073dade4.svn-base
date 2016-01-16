
!ABCIncludeFile

OMIT('_EndOfInclude_',_SysSndKeyPresent_)
_SysSndKeyPresent_ EQUATE(1)

! Equates

eMaxStringLength   EQUATE(2048)

eKeyShift          EQUATE(0100h)
eKeyAlt            EQUATE(0400h)
eKeyCtrl           EQUATE(0200h)
eKeyWin            EQUATE(0800h)

              INCLUDE('VSA_KEY1.INC')

PressKeyClass                 CLASS,TYPE,MODULE('VSA_KEY.CLW'),LINK('VSA_KEY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
KeyQ                            &tKeyQ,PROTECTED              ! Queue of registered keys
TrnQ                            &tTrnQ,PROTECTED              ! Queue to hold all translated keys
DelimiterLeft                   STRING(1)
DelimiterRight                  STRING(1)
Delay                           LONG

Init                            PROCEDURE(STRING Delimiters)
Kill                            PROCEDURE
AddTrn                          PROCEDURE(KeyBlock KB)
TrnKeyName                      PROCEDURE(STRING pText),ULONG
TrnVirtKey                      PROCEDURE(ULONG pVirtKeycode),STRING
StringToQ                       PROCEDURE(STRING pText)
KeyToQ                          PROCEDURE(STRING pText)
PressQ                          PROCEDURE
! Externally usable methods
vsPress                         PROCEDURE(STRING pText)
PressEx                         PROCEDURE(STRING pText)
vsPressKey                      PROCEDURE(ULONG Scan)
vsPressKeyStr                   PROCEDURE(STRING pText)
SetMousePos                     PROCEDURE(LONG X,LONG Y)
GetMousePos                     PROCEDURE(*LONG X,*LONG Y)
MouseClick                      PROCEDURE(LONG Keycode)
SetDelay                        PROCEDURE(LONG Delay)
                              END

_EndOfInclude_
