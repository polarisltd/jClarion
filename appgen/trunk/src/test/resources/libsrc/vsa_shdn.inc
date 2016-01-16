
!ABCIncludeFile

OMIT('_EndOfInclude_',_SysShutdownPresent_)
_SysShutdownPresent_ EQUATE(1)

! Equates

WM_QUERYENDSESSION          EQUATE(0011H)
WM_ENDSESSION               EQUATE(0016H)
WM_DEVICECHANGE             EQUATE(0219H)
WM_POWERBROADCAST           EQUATE(0218H)


! Events sent to main accept loop
EVENT:SH:Query              EQUATE(Event:User*2 + WM_QUERYENDSESSION)
EVENT:SH:End                EQUATE(Event:User*2 + WM_ENDSESSION)
EVENT:SH:DeviceChange       EQUATE(Event:User*2 + WM_DEVICECHANGE)
EVENT:SH:Power              EQUATE(Event:User*2 + WM_POWERBROADCAST)
EVENT:SH:PowerQuerySuspend  EQUATE(Event:User*2 + WM_POWERBROADCAST - 1)
EVENT:SH:PowerQueryStandby  EQUATE(Event:User*2 + WM_POWERBROADCAST - 2)
EVENT:SH:PowerSuspend       EQUATE(Event:User*2 + WM_POWERBROADCAST - 3)
EVENT:SH:PowerStandby       EQUATE(Event:User*2 + WM_POWERBROADCAST - 4)
EVENT:SH:PowerBatteryLow    EQUATE(Event:User*2 + WM_POWERBROADCAST - 5)
EVENT:SH:PowerStatusChanged EQUATE(Event:User*2 + WM_POWERBROADCAST - 6)

SysShutdownClass              CLASS,TYPE,MODULE('VSA_SHDN.CLW'),LINK('VSA_SHDN.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
RetValQuery                     SIGNED
RetValEnd                       SIGNED
hWnd                            UNSIGNED,PRIVATE              ! Handle of subclassed window
hWndProc                        UNSIGNED,PRIVATE              ! Handle of subclassed window
Init                            PROCEDURE(SIGNED RetValQuery,SIGNED RetValEnd)
Kill                            PROCEDURE
                              END

_EndOfInclude_



