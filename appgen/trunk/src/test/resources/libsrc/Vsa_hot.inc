
!ABCIncludeFile

OMIT('_EndOfInclude_',_SysHotKeyPresent_)
_SysHotKeyPresent_ EQUATE(1)

! Equates

eModAlt            EQUATE(0100h)            ! Alt/Shift are the reverse of what KEYBD_EVENT() requires
eModCtrl           EQUATE(0200h)
eModShift          EQUATE(0400h)
eModWin            EQUATE(0800h)

vsWM_HotKey        EQUATE(0312h)       ! WM_HotKey is 0312h, EVENT:User is 0400h
Event:wmHotKey     EQUATE(Event:User + 0312h)       ! WM_HotKey is 0312h, EVENT:User is 0400h

              INCLUDE('VSA_KEY1.INC')

tWMHotKey          GROUP,TYPE
Msg                   UNSIGNED
idHotKey              UNSIGNED
Modifiers             UNSIGNED
VirtKey               LONG
                   END



SysHotKeyClass                CLASS,TYPE,MODULE('VSA_HOT.CLW'),LINK('VSA_HOT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Active                          BYTE                          ! Active (Should hot keys be registered?)
KeysRegistered                  BYTE                          ! Active (Should hot keys be registered?)
hWndProc                        UNSIGNED
hWnd                            UNSIGNED

KeyQ                            &tKeyQ,PROTECTED              ! Queue of registered keys
FailedKeyQ                      &tKeyQ                        ! Queue of unregisterable keys
TrnQ                            &tTrnQ,PROTECTED              ! Queue to hold all translated keys
PressedKeyQ                     &tKeyQ                        ! Queue of registered key pressed

Init                            PROCEDURE
Kill                            PROCEDURE
Activate                        PROCEDURE
Unactivate                      PROCEDURE
AddTrn                          PROCEDURE(KeyBlock KB),VIRTUAL
AddKey                          PROCEDURE(STRING KeyName)
RemoveKey                       PROCEDURE(STRING KeyName)
TrnKeyName                      PROCEDURE(STRING pText),ULONG
TrnVirtKey                      PROCEDURE(ULONG pVirtKeycode),STRING

TakeKey                         PROCEDURE(UNSIGNED Id,STRING KeyName),VIRTUAL
TakeInvalidKey                  PROCEDURE(STRING KeyName),VIRTUAL
RegisterHotKeys                 PROCEDURE
UnregisterHotKeys               PROCEDURE
                              END

_EndOfInclude_
