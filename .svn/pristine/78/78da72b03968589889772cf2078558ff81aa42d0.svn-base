!ABCIncludeFile

OMIT('_EndOfInclude_',_SysTrayPresent_)
_SysTrayPresent_ EQUATE(1)

! Equates

!Level:Benign                 EQUATE(0)
!Level:User                   EQUATE(1)
!Level:Program                EQUATE(2)
!Level:Fatal                  EQUATE(3)
!Level:Cancel                 EQUATE(4)
!Level:Notify                 EQUATE(5)


Event:Tray               EQUATE(0440h)

! Events sent to main accept loop
              ITEMIZE(0440h),PRE(Event:Tray)
Base                     EQUATE
Left                     EQUATE                     ! Left mouse button
Right                    EQUATE                     ! Right mouse buttons
Left2                    EQUATE                     ! Left mouse double-click
Right2                   EQUATE                     ! Right mouse double-click
! Events used by templates
Restore                  EQUATE                     ! Ask class to restore window
Iconize                  EQUATE                     ! Ask class to iconize window
ExplorerRestart          EQUATE
              END
Event:ExplorerRestartMsg ULONG

NIM_ADD                  EQUATE(0)          ! Mode
NIM_MODIFY               EQUATE(1)
NIM_DELETE               EQUATE(2)

NIF_MESSAGE              EQUATE(1)          ! Information to update
NIF_ICON                 EQUATE(2)
NIF_TIP                  EQUATE(4)

TRAY_WM_MOUSEMOVE        EQUATE(200h)       ! Tray events
TRAY_WM_LBUTTONDOWN      EQUATE(201h)
TRAY_WM_LBUTTONUP        EQUATE(202h)
TRAY_WM_LBUTTONDBLCLK    EQUATE(203h)       ! Main tray event
TRAY_WM_RBUTTONDOWN      EQUATE(204h)
TRAY_WM_RBUTTONUP        EQUATE(205h)       ! Typically a popup
TRAY_WM_RBUTTONDBLCLK    EQUATE(206h)

! Types

tNotifyIconData GROUP,TYPE
cbSize             ULONG
hWnd               UNSIGNED
uID                UNSIGNED
uFlags             UNSIGNED
uCBmessage         UNSIGNED
hIcon              UNSIGNED
Tip                CSTRING(64)
                END


SysTrayClass                  CLASS,TYPE,MODULE('VSA_TRAY.CLW'),LINK('VSA_TRAY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Active                          BYTE                          ! Active
AlwaysRefresh                   BYTE
MinimizeToTaskbar               BYTE,PRIVATE                  ! Allow minimization
NoSubclassing                   BYTE,PRIVATE
!Suspended                      BYTE,PRIVATE
hWnd                            UNSIGNED,PRIVATE              ! Handle of subclassed window
hWndProc                        UNSIGNED,PRIVATE              ! Handle of subclassed window
NID                             LIKE(tNotifyIconData),PROTECTED
uID                             UNSIGNED,PRIVATE
Icon                            CSTRING(256),PRIVATE
Tip                             CSTRING(256),PRIVATE

! Methods
Init                            PROCEDURE(BYTE uID,STRING IconName,STRING Tip,BYTE MinimizeToTaskbar=0,BYTE NoSubclassing=0)
Kill                            PROCEDURE
Prime                           PROCEDURE
AllowMinimize                   PROCEDURE
DisallowMinimize                PROCEDURE

! Window handlers
TakeRestore                     PROCEDURE,BYTE,PRIVATE
TakeIconize                     PROCEDURE,BYTE,PRIVATE
TakeIconized                    PROCEDURE,BYTE,PRIVATE
Iconized                        PROCEDURE,VIRTUAL
!Suspend                        PROCEDURE
!Resume                         PROCEDURE
Hide                            PROCEDURE
Unhide                          PROCEDURE
Restore                         PROCEDURE,VIRTUAL

! Basic methods
AddIcon                         PROCEDURE(STRING IconName,STRING Tip),SIGNED,PROC
DeleteIcon                      PROCEDURE,SIGNED,PROC
ChangeIcon                      PROCEDURE(STRING IconName),SIGNED,PROC
ChangeTip                       PROCEDURE(STRING Tip),SIGNED,PROC
GetIcon                         PROCEDURE(),STRING
GetTip                          PROCEDURE(),STRING

! Virtual methods
TakeTrayLeftClick               PROCEDURE,VIRTUAL
TakeTrayLeftDoubleClick         PROCEDURE,VIRTUAL
TakeTrayRightClick              PROCEDURE,VIRTUAL

! Miscellaneous
ReplacePeriod                   PROCEDURE(STRING pIcon),STRING,PRIVATE
                              END

_EndOfInclude_
