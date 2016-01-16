
!ABCIncludeFile

OMIT('_EndOfInclude_',_MouseWheelPresent_)
_MouseWheelPresent_ EQUATE(1)

! Equates

vsWM_MouseWheel         EQUATE(020Ah)               ! WM_MouseWheel: 020Ah, EVENT:User is 0400h
Event:wmMouseWheelUp    EQUATE(Event:User + 020Ah)  !
Event:wmMouseWheelDown  EQUATE(Event:User + 020Bh)  !
MWDelta                 EQUATE(7864320)

tTargetQ           QUEUE,TYPE
FEQ                  LONG
                   END

vsMouseWheelClass             CLASS,TYPE,MODULE('VSA_MWHL.CLW'),LINK('VSA_MWHL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Active                          BYTE                          ! Active
hWndProc                        UNSIGNED
hWnd                            UNSIGNED

Turns                           LONG

TargetQ                         &tTargetQ,PROTECTED           ! Queue of registered keys

Init                            PROCEDURE
Kill                            PROCEDURE
WheelUp                         PROCEDURE,VIRTUAL
WheelDown                       PROCEDURE,VIRTUAL
FindTarget                      PROCEDURE,LONG,PRIVATE
                              END

_EndOfInclude_
