 
  omit('EndDefine',_WINAPI_)
_WINAPI_  equate(1)

_ULARGE_INTEGER                 group,type
LowPart                           long
HighPart                          long
                                end

I64                             equate(long) ! where used, use the push functions for pushing the 64bit longlong

MAX_PATH                        equate(260)
HANDLE                          equate(long)
HWND                            equate(HANDLE)
HINSTANCE                       equate(HANDLE)
HMODULE                         equate(HANDLE)
HMENU                           equate(HANDLE)
HDC                             equate(HANDLE)
HICON                           equate(HANDLE)
HCURSOR                         equate(HANDLE)
HBRUSH                          equate(HANDLE)
HBITMAP                         equate(HANDLE)
HGDIOBJ                         equate(HANDLE)
HFONT                           equate(HANDLE)
HRGN                            equate(HANDLE)
HGLOBAL                         equate(HANDLE)
HPEN                            equate(HANDLE)
HRESULT                         equate(HANDLE)

COLORREF                        equate(long)
ATOM                            equate(long)

_RECT_                          group,type
left                              signed
top                               signed
right                             signed
bottom                            signed
                                end

POINT                           group,type
x                                 signed
y                                 signed
                                end

SIZE                            group,type
cx                                signed
cy                                signed
                                end

SIZEL                           group(SIZE),type
                                end

WNDCLASS                        group,type
style                             unsigned
lpfnWndProc                       long
cbClsExtra                        signed
cbWndExtra                        signed
hInst                             HINSTANCE
hIcon                             HICON
hCursor                           HCURSOR
hbrBackground                     HBRUSH
lpszMenuName                      long
lpszClassName                     long
                                end

WNDCLASSEX                      group,type
cbSize                            unsigned
                                  group(WNDCLASS).
hIconSm                           HICON
                                end

CURRENCY                        group,type ! lo + as dec bshift(hi, 32) / 10000
lo                                long
hi                                long
                                end

GENERIC_READ                    equate(80000000h)
GENERIC_WRITE                   equate(40000000h)
GENERIC_EXECUTE                 equate(20000000h)
GENERIC_ALL                     equate(10000000h)
FILE_SHARE_READ                 equate(00000001h)
FILE_SHARE_WRITE                equate(00000002h)
FILE_SHARE_DELETE               equate(00000004h)
FILE_ATTRIBUTE_READONLY         equate(00000001h)
FILE_ATTRIBUTE_HIDDEN           equate(00000002h)
FILE_ATTRIBUTE_SYSTEM           equate(00000004h)
FILE_ATTRIBUTE_DIRECTORY        equate(00000010h)
FILE_ATTRIBUTE_ARCHIVE          equate(00000020h)
FILE_ATTRIBUTE_NORMAL           equate(00000080h)
FILE_ATTRIBUTE_TEMPORARY        equate(00000100h)
FILE_ATTRIBUTE_COMPRESSED       equate(00000800h)
FILE_ATTRIBUTE_OFFLINE          equate(00001000h)
FILE_NOTIFY_CHANGE_FILE_NAME    equate(00000001h)
FILE_NOTIFY_CHANGE_DIR_NAME     equate(00000002h)
FILE_NOTIFY_CHANGE_ATTRIBUTES   equate(00000004h)
FILE_NOTIFY_CHANGE_SIZE         equate(00000008h)
FILE_NOTIFY_CHANGE_LAST_WRITE   equate(00000010h)
FILE_NOTIFY_CHANGE_LAST_ACCESS  equate(00000020h)
FILE_NOTIFY_CHANGE_CREATION     equate(00000040h)
FILE_NOTIFY_CHANGE_SECURITY     equate(00000100h)
FILE_ACTION_ADDED               equate(00000001h)
FILE_ACTION_REMOVED             equate(00000002h)
FILE_ACTION_MODIFIED            equate(00000003h)
FILE_ACTION_RENAMED_OLD_NAME    equate(00000004h)
FILE_ACTION_RENAMED_NEW_NAME    equate(00000005h)
FILE_CASE_SENSITIVE_SEARCH      equate(00000001h)
FILE_CASE_PRESERVED_NAMES       equate(00000002h)
FILE_UNICODE_ON_DISK            equate(00000004h)
FILE_PERSISTENT_ACLS            equate(00000008h)
FILE_FILE_COMPRESSION           equate(00000010h)
FILE_VOLUME_IS_COMPRESSED       equate(00008000h)
CREATE_NEW                      equate(1)
CREATE_ALWAYS                   equate(2)
OPEN_EXISTING                   equate(3)
OPEN_ALWAYS                     equate(4)
TRUNCATE_EXISTING               equate(5)
FILE_FLAG_WRITE_THROUGH         equate(80000000h)
FILE_FLAG_OVERLAPPED            equate(40000000h)
FILE_FLAG_NO_BUFFERING          equate(20000000h)
FILE_FLAG_RANDOM_ACCESS         equate(10000000h)
FILE_FLAG_SEQUENTIAL_SCAN       equate(08000000h)
FILE_FLAG_DELETE_ON_CLOSE       equate(04000000h)
FILE_FLAG_BACKUP_SEMANTICS      equate(02000000h)
FILE_FLAG_POSIX_SEMANTICS       equate(01000000h)

FILE_BEGIN                      equate(0)
FILE_CURRENT                    equate(1)
FILE_END                        equate(2)


PAGE_NOACCESS                   equate(01h)
PAGE_READONLY                   equate(02h)
PAGE_READWRITE                  equate(04h)
PAGE_WRITECOPY                  equate(08h)
PAGE_EXECUTE                    equate(10h)
PAGE_EXECUTE_READ               equate(20h)
PAGE_EXECUTE_READWRITE          equate(40h)
PAGE_EXECUTE_WRITECOPY          equate(80h)
PAGE_GUARD                      equate(100h)
PAGE_NOCACHE                    equate(200h)
MEM_COMMIT                      equate(1000h)
MEM_RESERVE                     equate(2000h)
MEM_DECOMMIT                    equate(4000h)
MEM_RELEASE                     equate(8000h)
MEM_FREE                        equate(10000h)
MEM_PRIVATE                     equate(20000h)
MEM_MAPPED                      equate(40000h)
MEM_RESET                       equate(80000h)
MEM_TOP_DOWN                    equate(100000h)
SEC_FILE                        equate(800000h)
SEC_IMAGE                       equate(1000000h)
SEC_RESERVE                     equate(4000000h)
SEC_COMMIT                      equate(8000000h)
SEC_NOCACHE                     equate(10000000h)

!  File System time stamps are represented with the following structure:

_FILETIME                       group,type
dwLowDateTime                     long
dwHighDateTime                    long
                                end

! System time is represented with the following structure:

_SYSTEMTIME                     group,type
wYear                             short
wMonth                            short
wDayOfWeek                        short
wDay                              short
wHour                             short
wMinute                           short
wSecond                           short
wMilliseconds                     short
                                end

!Standard Cursor IDs

IDC_ARROW                       equate(32512)
IDC_IBEAM                       equate(32513)
IDC_WAIT                        equate(32514)
IDC_CROSS                       equate(32515)
IDC_UPARROW                     equate(32516)
IDC_SIZE                        equate(32640)  !OBSOLETE: use IDC_SIZEALL
IDC_ICON                        equate(32641)  !OBSOLETE: use IDC_ARROW
IDC_SIZENWSE                    equate(32642)
IDC_SIZENESW                    equate(32643)
IDC_SIZEWE                      equate(32644)
IDC_SIZENS                      equate(32645)
IDC_SIZEALL                     equate(32646)
IDC_NO                          equate(32648)  !not in win3.1
IDC_APPSTARTING                 equate(32650)  !not in win3.1
IDC_HELP                        equate(32651)

PAINTSTRUCT                     group,type
hdc                               HDC
fErase                            bool
rcPaint                           group(_RECT_).
fRestore                          bool
fIncUpdate                        bool
rgbReserved                       string(32)
                                end

! Owner draw control types

ODT_MENU                        equate(1)
ODT_LISTBOX                     equate(2)
ODT_COMBOBOX                    equate(3)
ODT_BUTTON                      equate(4)

ODT_STATIC                      equate(5)

! Owner draw actions

ODA_DRAWENTIRE                  equate(00001h)
ODA_SELECT                      equate(00002h)
ODA_FOCUS                       equate(00004h)

! Owner draw state

ODS_SELECTED                    equate(00001h)
ODS_GRAYED                      equate(00002h)
ODS_DISABLED                    equate(00004h)
ODS_CHECKED                     equate(00008h)
ODS_FOCUS                       equate(00010h)

ODS_DEFAULT                     equate(00020h)
ODS_COMBOBOXEDIT                equate(01000h)

ODS_HOTLIGHT                    equate(00040h)
ODS_INACTIVE                    equate(00080h)

DRAWITEMSTRUCT                  group,type
CtlType                           long
CtlID                             long
itemID                            long
itemAction                        long
itemState                         long
hwndItem                          HWnd
hDC                               HDC
rcItem                            like(_RECT_)
itemData                          long
                                end

!Bitmap Header Definition

BITMAP                          group,type
bmType                            long
bmWidth                           long
bmHeight                          long
bmWidthBytes                      long
bmPlanes                          unsigned
bmBitsPixel                       unsigned
bmBits                            long
                                end

BITMAPINFOHEADER                group,type
biSize                            long
biWidth                           long
biHeight                          long
biPlanes                          short
biBitCount                        short
biCompression                     long
biSizeImage                       long
biXPelsPerMeter                   long
biYPelsPerMeter                   long
biClrUsed                         long
biClrImportant                    long
                                end

RGBQUAD                         group,type
rgbBlue                           byte
rgbGreen                          byte
rgbRed                            byte
rgbReserved                       byte
                                end

BITMAPINFO                      group,type
                                  group(BITMAPINFOHEADER).
bmiColors                         group(RGBQUAD),dim(1).
                                end

BITMAPINFOCLASS                 class,type
BitmapData                        group(BITMAP).
                                end

! constants for CreateDIBitmap

CBM_INIT                        equate(04h)     ! initialize bitmap

!Pen Styles

PS_SOLID                        equate(0)
PS_DASH                         equate(1)       ! -------
PS_DOT                          equate(2)       ! .......
PS_DASHDOT                      equate(3)       ! _._._._
PS_DASHDOTDOT                   equate(4)       ! _.._.._
PS_NULL                         equate(5)
PS_INSIDEFRAME                  equate(6)
PS_USERSTYLE                    equate(7)
PS_ALTERNATE                    equate(8)
PS_STYLE_MASK                   equate(0000000Fh)
PS_ENDCAP_ROUND                 equate(00000000h)
PS_ENDCAP_SQUARE                equate(00000100h)
PS_ENDCAP_FLAT                  equate(00000200h)
PS_ENDCAP_MASK                  equate(00000F00h)
PS_JOIN_ROUND                   equate(00000000h)
PS_JOIN_BEVEL                   equate(00001000h)
PS_JOIN_MITER                   equate(00002000h)
PS_JOIN_MASK                    equate(0000F000h)
PS_COSMETIC                     equate(00000000h)
PS_GEOMETRIC                    equate(00010000h)
PS_TYPE_MASK                    equate(000F0000h)

!DIB color table identifiers

DIB_RGB_COLORS                  equate(0) !color table in RGBs
DIB_PAL_COLORS                  equate(1) !color table in palette indices

!Standard Windows Messages

WM_NULL                         equate(00H)
WM_CREATE                       equate(01H)
WM_DESTROY                      equate(02H)
WM_MOVE                         equate(03H)
WM_SIZE                         equate(05H)
WM_ACTIVATE                     equate(06H)
WM_SETFOCUS                     equate(07H)
WM_KILLFOCUS                    equate(08H)
WM_ENABLE                       equate(0AH)
WM_SETREDRAW                    equate(0BH)
WM_SETTEXT                      equate(0CH)
WM_GETTEXT                      equate(0DH)
WM_GETTEXTLENGTH                equate(0EH)
WM_PAINT                        equate(0FH)
WM_CLOSE                        equate(010H)
WM_QUERYENDSESSION              equate(011H)
WM_QUIT                         equate(012H)
WM_QUERYOPEN                    equate(013H)
WM_ERASEBKGND                   equate(014H)
WM_SYSCOLORCHANGE               equate(015H)
WM_ENDSESSION                   equate(016H)
WM_SHOWWINDOW                   equate(018H)
WM_CTLCOLOR                     equate(019H)
WM_WININICHANGE                 equate(01AH)
WM_DEVMODECHANGE                equate(01BH)
WM_ACTIVATEAPP                  equate(01CH)
WM_FONTCHANGE                   equate(01DH)
WM_TIMECHANGE                   equate(01EH)
WM_CANCELMODE                   equate(01FH)
WM_SETCURSOR                    equate(020H)
WM_MOUSEACTIVATE                equate(021H)
!WM_DESTROY                     equate(022H)
WM_QUEUESYNC                    equate(023H)
WM_GETMINMAXINFO                equate(024H)
WM_PAINTICON                    equate(026H)
WM_ICONERASEBKGND               equate(027H)
WM_NEXTDLGCTL                   equate(028H)
WM_SPOOLERSTATUS                equate(02AH)
WM_DRAWITEM                     equate(02BH)
WM_MEASUREITEM                  equate(02CH)
WM_DELETEITEM                   equate(02DH)
WM_VKEYTOITEM                   equate(02EH)
WM_CHARTOITEM                   equate(02FH)
WM_SETFONT                      equate(030H)
WM_GETFONT                      equate(031H)
WM_QUERYDRAGICON                equate(037H)
WM_COMPAREITEM                  equate(039H)
WM_COMPACTING                   equate(041H)
WM_WINDOWPOSCHANGING            equate(0046H)
WM_WINDOWPOSCHANGED             equate(0047H)
WM_CONTEXTMENU                  equate(07Bh)
WM_STYLECHANGING                equate(07Ch)
WM_STYLECHANGED                 equate(07Dh)
WM_DISPLAYCHANGE                equate(07Eh)
WM_GETICON                      equate(07Fh)
WM_SETICON                      equate(080h)
WM_NCCREATE                     equate(081H)
WM_NCDESTROY                    equate(082H)
WM_NCCALCSIZE                   equate(083H)
WM_NCHITTEST                    equate(084H)
WM_NCPAINT                      equate(085H)
WM_NCACTIVATE                   equate(086H)
WM_GETDLGCODE                   equate(087H)
WM_NCMOUSEMOVE                  equate(0A0H)
WM_NCLBUTTONDOWN                equate(0A1H)
WM_NCLBUTTONUP                  equate(0A2H)
WM_NCLBUTTONDBLCLK              equate(0A3H)
WM_NCRBUTTONDOWN                equate(0A4H)
WM_NCRBUTTONUP                  equate(0A5H)
WM_NCRBUTTONDBLCLK              equate(0A6H)
WM_NCMBUTTONDOWN                equate(0A7H)
WM_NCMBUTTONUP                  equate(0A8H)
WM_NCMBUTTONDBLCLK              equate(0A9H)
WM_KEYFIRST                     equate(0100H)
WM_KEYDOWN                      equate(0100H)
WM_KEYUP                        equate(0101H)
WM_CHAR                         equate(0102H)
WM_DEADCHAR                     equate(0103H)
WM_SYSKEYDOWN                   equate(0104H)
WM_SYSKEYUP                     equate(0105H)
WM_SYSCHAR                      equate(0106H)
WM_SYSDEADCHAR                  equate(0107H)
WM_KEYLAST                      equate(0108H)
WM_INITDIALOG                   equate(0110H)
WM_COMMAND                      equate(0111H)
WM_SYSCOMMAND                   equate(0112H)
WM_TIMER                        equate(0113H)
WM_HSCROLL                      equate(0114H)
WM_VSCROLL                      equate(0115H)
WM_INITMENU                     equate(0116H)
WM_INITMENUPOPUP                equate(0117H)
WM_MENUSELECT                   equate(011FH)
WM_MENUCHAR                     equate(0120H)
WM_ENTERIDLE                    equate(0121H)
WM_MOUSEFIRST                   equate(0200H)
WM_MOUSEMOVE                    equate(0200H)
WM_LBUTTONDOWN                  equate(0201H)
WM_LBUTTONUP                    equate(0202H)
WM_LBUTTONDBLCLK                equate(0203H)
WM_RBUTTONDOWN                  equate(0204H)
WM_RBUTTONUP                    equate(0205H)
WM_RBUTTONDBLCLK                equate(0206H)
WM_MBUTTONDOWN                  equate(0207H)
WM_MBUTTONUP                    equate(0208H)
WM_MBUTTONDBLCLK                equate(0209H)
WM_MOUSELAST                    equate(0209H)
WM_PARENTNOTIFY                 equate(0210H)
WM_MDICREATE                    equate(0220H)
WM_MDIDESTROY                   equate(0221H)
WM_MDIACTIVATE                  equate(0222H)
WM_MDIRESTORE                   equate(0223H)
WM_MDINEXT                      equate(0224H)
WM_MDIMAXIMIZE                  equate(0225H)
WM_MDITILE                      equate(0226H)
WM_MDICASCADE                   equate(0227H)
WM_MDIICONARRANGE               equate(0228H)
WM_MDIGETACTIVE                 equate(0229H)
WM_MDISETMENU                   equate(0230H)
WM_CUT                          equate(0300H)
WM_COPY                         equate(0301H)
WM_PASTE                        equate(0302H)
WM_CLEAR                        equate(0303H)
WM_UNDO                         equate(0304H)
WM_RENDERFORMAT                 equate(0305H)
WM_RENDERALLFORMATS             equate(0306H)
WM_DESTROYCLIPBOARD             equate(0307H)
WM_DRAWCLIPBOARD                equate(0308H)
WM_PAINTCLIPBOARD               equate(0309H)
WM_VSCROLLCLIPBOARD             equate(030AH)
WM_SIZECLIPBOARD                equate(030BH)
WM_ASKCBFORMATNAME              equate(030CH)
WM_CHANGECBCHAIN                equate(030DH)
WM_HSCROLLCLIPBOARD             equate(030EH)
WM_QUERYNEWPALETTE              equate(030FH)
WM_PALETTEISCHANGING            equate(0310H)
WM_PALETTECHANGED               equate(0311H)
WM_USER                         equate(0400H)

WM_NOTIFY                       equate(0004Eh)
WM_INPUTLANGCHANGEREQUEST       equate(00050h)
WM_INPUTLANGCHANGE              equate(00051h)
WM_TCARD                        equate(00052h)
WM_HELP                         equate(00053h)
WM_USERCHANGED                  equate(00054h)
WM_NOTIFYFORMAT                 equate(00055h)

NFR_ANSI                        equate(1)
NFR_UNICODE                     equate(2)
NF_QUERY                        equate(3)
NF_REQUERY                      equate(4)

!Key State Masks for Mouse Messages

MK_LBUTTON                      equate(0001h)
MK_RBUTTON                      equate(0002h)
MK_SHIFT                        equate(0004h)
MK_CONTROL                      equate(0008h)
MK_MBUTTON                      equate(0010h)

NM_FIRST                        equate(0)
NM_CLICK                        equate(NM_FIRST - 2)
NM_DBLCLK                       equate(NM_FIRST - 3)
NM_HOVER                        equate(NM_FIRST - 13)
NM_KILLFOCUS                    equate(NM_FIRST - 8)
NM_RCLICK                       equate(NM_FIRST - 5)
NM_RDBLCLK                      equate(NM_FIRST - 6)
NM_RETURN                       equate(NM_FIRST - 4)
NM_SETFOCUS                     equate(NM_FIRST - 7)

NMHDR                           group,type
hwndFrom                          long
idFrom                            long
code                              long
                                end

!Window Styles

WS_OVERLAPPED                   equate(00000000h)
WS_POPUP                        equate(80000000h)
WS_CHILD                        equate(40000000h)
WS_MINIMIZE                     equate(20000000h)
WS_VISIBLE                      equate(10000000h)
WS_DISABLED                     equate(08000000h)
WS_CLIPSIBLINGS                 equate(04000000h)
WS_CLIPCHILDREN                 equate(02000000h)
WS_MAXIMIZE                     equate(01000000h)
WS_CAPTION                      equate(00C00000h)  !WS_BORDER | WS_DLGFRAME
WS_BORDER                       equate(00800000h)
WS_DLGFRAME                     equate(00400000h)
WS_VSCROLL                      equate(00200000h)
WS_HSCROLL                      equate(00100000h)
WS_SYSMENU                      equate(00080000h)
WS_THICKFRAME                   equate(00040000h)
WS_GROUP                        equate(00020000h)
WS_TABSTOP                      equate(00010000h)

WS_MINIMIZEBOX                  equate(00020000h)
WS_MAXIMIZEBOX                  equate(00010000h)

!Common Window Styles

WS_OVERLAPPEDWINDOW             equate(WS_OVERLAPPED     + |
                                       WS_CAPTION        + |
                                       WS_SYSMENU        + |
                                       WS_THICKFRAME     + |
                                       WS_MINIMIZEBOX    + |
                                       WS_MAXIMIZEBOX)

WS_POPUPWINDOW                  equate(WS_POPUP          + |
                                       WS_BORDER         + |
                                       WS_SYSMENU)

WS_CHILDWINDOW                  equate(WS_CHILD)

WS_TILED                        equate(WS_OVERLAPPED)
WS_ICONIC                       equate(WS_MINIMIZE)
WS_SIZEBOX                      equate(WS_THICKFRAME)
WS_TILEDWINDOW                  equate(WS_OVERLAPPEDWINDOW)

!Extended Window Styles

WS_EX_DLGMODALFRAME             equate(00000001h)
WS_EX_NOPARENTNOTIFY            equate(00000004h)
WS_EX_TOPMOST                   equate(00000008h)
WS_EX_ACCEPTFILES               equate(00000010h)
WS_EX_TRANSPARENT               equate(00000020h)
WS_EX_MDICHILD                  equate(00000040h)
WS_EX_TOOLWINDOW                equate(00000080h)
WS_EX_WINDOWEDGE                equate(00000100h)
WS_EX_CLIENTEDGE                equate(00000200h)
WS_EX_CONTEXTHELP               equate(00000400h)
WS_EX_RIGHT                     equate(00001000h)
WS_EX_LEFT                      equate(00000000h)
WS_EX_RTLREADING                equate(00002000h)
WS_EX_LTRREADING                equate(00000000h)
WS_EX_LEFTSCROLLBAR             equate(00004000h)
WS_EX_RIGHTSCROLLBAR            equate(00000000h)
WS_EX_CONTROLPARENT             equate(00010000h)
WS_EX_STATICEDGE                equate(00020000h)
WS_EX_APPWINDOW                 equate(00040000h)
WS_EX_OVERLAPPEDWINDOW          equate(WS_EX_WINDOWEDGE + WS_EX_CLIENTEDGE)
WS_EX_PALETTEWINDOW             equate(WS_EX_WINDOWEDGE + WS_EX_TOOLWINDOW + WS_EX_TOPMOST)

!Button Control Styles

BS_PUSHBUTTON                   equate(00000000h)
BS_DEFPUSHBUTTON                equate(00000001h)
BS_CHECKBOX                     equate(00000002h)
BS_AUTOCHECKBOX                 equate(00000003h)
BS_RADIOBUTTON                  equate(00000004h)
BS_3STATE                       equate(00000005h)
BS_AUTO3STATE                   equate(00000006h)
BS_GROUPBOX                     equate(00000007h)
BS_USERBUTTON                   equate(00000008h)
BS_AUTORADIOBUTTON              equate(00000009h)
BS_OWNERDRAW                    equate(0000000Bh)
BS_LEFTTEXT                     equate(00000020h)
BS_TEXT                         equate(00000000h)
BS_ICON                         equate(00000040h)
BS_BITMAP                       equate(00000080h)
BS_LEFT                         equate(00000100h)
BS_RIGHT                        equate(00000200h)
BS_CENTER                       equate(00000300h)
BS_TOP                          equate(00000400h)
BS_BOTTOM                       equate(00000800h)
BS_VCENTER                      equate(00000C00h)
BS_PUSHLIKE                     equate(00001000h)
BS_MULTILINE                    equate(00002000h)
BS_NOTIFY                       equate(00004000h)
BS_FLAT                         equate(00008000h)
BS_RIGHTBUTTON                  equate(BS_LEFTTEXT)


SW_SCROLLCHILDREN               equate(0001h)  ! Scroll children within *lprcScroll.
SW_INVALIDATE                   equate(0002h)  ! Invalidate after scrolling
SW_ERASE                        equate(0004h)  ! If SW_INVALIDATE, don't send WM_ERASEBACKGROUND

SW_SMOOTHSCROLL                 equate(0010h)  ! Use smooth scrolling

!Stock Logical Objects

WHITE_BRUSH                     equate(0)
LTGRAY_BRUSH                    equate(1)
GRAY_BRUSH                      equate(2)
DKGRAY_BRUSH                    equate(3)
BLACK_BRUSH                     equate(4)
NULL_BRUSH                      equate(5)
HOLLOW_BRUSH                    equate(NULL_BRUSH)
WHITE_PEN                       equate(7)
NULL_PEN                        equate(8)
OEM_FIXED_FONT                  equate(10)
ANSI_FIXED_FONT                 equate(11)
ANSI_VAR_FONT                   equate(12)
SYSTEM_FONT                     equate(13)
DEVICE_DEFAULT_FONT             equate(14)
DEFAULT_PALETTE                 equate(15)
SYSTEM_FIXED_FONT               equate(16)
DEFAULT_GUI_FONT                equate(17)

!Class styles

CS_VREDRAW                      equate(0001h)
CS_HREDRAW                      equate(0002h)
CS_KEYCVTWINDOW                 equate(0004h)
CS_DBLCLKS                      equate(0008h)
CS_OWNDC                        equate(0020h)
CS_CLASSDC                      equate(0040h)
CS_PARENTDC                     equate(0080h)
CS_NOKEYCVT                     equate(0100h)
CS_NOCLOSE                      equate(0200h)
CS_SAVEBITS                     equate(0800h)
CS_BYTEALIGNCLIENT              equate(1000h)
CS_BYTEALIGNWINDOW              equate(2000h)
CS_GLOBALCLASS                  equate(4000h)
CS_IME                          equate(00010000h)

!SetWindowPos Flags

SWP_NOSIZE                      equate(0001h)
SWP_NOMOVE                      equate(0002h)
SWP_NOZORDER                    equate(0004h)
SWP_NOREDRAW                    equate(0008h)
SWP_NOACTIVATE                  equate(0010h)
SWP_FRAMECHANGED                equate(0020h)  !The frame changed: send WM_NCCALCSIZE
SWP_SHOWWINDOW                  equate(0040h)
SWP_HIDEWINDOW                  equate(0080h)
SWP_NOCOPYBITS                  equate(0100h)
SWP_NOOWNERZORDER               equate(0200h)  !Don't do owner Z ordering
SWP_NOSENDCHANGING              equate(0400h)  !Don't send WM_WINDOWPOSCHANGING

SWP_DRAWFRAME                   equate(SWP_FRAMECHANGED)
SWP_NOREPOSITION                equate(SWP_NOOWNERZORDER)

SWP_DEFERERASE                  equate(2000h)
SWP_ASYNCWINDOWPOS              equate(4000h)

HWND_TOP                        equate(0)
HWND_BOTTOM                     equate(1)
HWND_TOPMOST                    equate(-1)
HWND_NOTOPMOST                  equate(-2)

!3D border styles

BDR_RAISEDOUTER                 equate(0001h)
BDR_SUNKENOUTER                 equate(0002h)
BDR_RAISEDINNER                 equate(0004h)
BDR_SUNKENINNER                 equate(0008h)
BDR_OUTER                       equate(0003h)
BDR_INNER                       equate(000ch)
BDR_RAISED                      equate(0005h)
BDR_SUNKEN                      equate(000ah)

EDGE_RAISED                     equate(BDR_RAISEDOUTER + BDR_RAISEDINNER)
EDGE_SUNKEN                     equate(BDR_SUNKENOUTER + BDR_SUNKENINNER)
EDGE_ETCHED                     equate(BDR_SUNKENOUTER + BDR_RAISEDINNER)
EDGE_BUMP                       equate(BDR_RAISEDOUTER + BDR_SUNKENINNER)

!Border flags

BF_LEFT                         equate(0001h)
BF_TOP                          equate(0002h)
BF_RIGHT                        equate(0004h)
BF_BOTTOM                       equate(0008h)

BF_TOPLEFT                      equate(BF_TOP + BF_LEFT)
BF_TOPRIGHT                     equate(BF_TOP + BF_RIGHT)
BF_BOTTOMLEFT                   equate(BF_BOTTOM + BF_LEFT)
BF_BOTTOMRIGHT                  equate(BF_BOTTOM + BF_RIGHT)
BF_RECT                         equate(BF_LEFT + BF_TOP + BF_RIGHT + BF_BOTTOM)
BF_DIAGONAL                     equate(0010h)

BF_DIAGONAL_ENDTOPRIGHT         equate(BF_DIAGONAL + BF_TOP + BF_RIGHT)
BF_DIAGONAL_ENDTOPLEFT          equate(BF_DIAGONAL + BF_TOP + BF_LEFT)
BF_DIAGONAL_ENDBOTTOMLEFT       equate(BF_DIAGONAL + BF_BOTTOM + BF_LEFT)
BF_DIAGONAL_ENDBOTTOMRIGHT      equate(BF_DIAGONAL + BF_BOTTOM + BF_RIGHT)

BF_MIDDLE                       equate(0800h)  !Fill in the middle
BF_SOFT                         equate(1000h)  !For softer buttons
BF_ADJUST                       equate(2000h)  !Calculate the space left over
BF_FLAT                         equate(4000h)  !For flat rather than 3D borders
BF_MONO                         equate(8000h)  !For monochrome borders

!DrawText() Format Flags

DT_TOP                          equate(00000000h)
DT_LEFT                         equate(00000000h)
DT_CENTER                       equate(00000001h)
DT_RIGHT                        equate(00000002h)
DT_VCENTER                      equate(00000004h)
DT_BOTTOM                       equate(00000008h)
DT_WORDBREAK                    equate(00000010h)
DT_SINGLELINE                   equate(00000020h)
DT_EXPANDTABS                   equate(00000040h)
DT_TABSTOP                      equate(00000080h)
DT_NOCLIP                       equate(00000100h)
DT_EXTERNALLEADING              equate(00000200h)
DT_CALCRECT                     equate(00000400h)
DT_NOPREFIX                     equate(00000800h)
DT_INTERNAL                     equate(00001000h)
DT_EDITCONTROL                  equate(00002000h)
DT_PATH_ELLIPSIS                equate(00004000h)
DT_END_ELLIPSIS                 equate(00008000h)
DT_MODIFYSTRING                 equate(00010000h)
DT_RTLREADING                   equate(00020000h)
DT_WORD_ELLIPSIS                equate(00040000h)

!Background Modes

TRANSPARENT                     equate(1)
OPAQUE                          equate(2)
BKMODE_LAST                     equate(2)

!Font Weights

FW_DONTCARE                     equate(0)
FW_THIN                         equate(100)
FW_EXTRALIGHT                   equate(200)
FW_LIGHT                        equate(300)
FW_NORMAL                       equate(400)
FW_MEDIUM                       equate(500)
FW_SEMIBOLD                     equate(600)
FW_BOLD                         equate(700)
FW_EXTRABOLD                    equate(800)
FW_HEAVY                        equate(900)

FW_ULTRALIGHT                   equate(FW_EXTRALIGHT)
FW_REGULAR                      equate(FW_NORMAL)
FW_DEMIBOLD                     equate(FW_SEMIBOLD)
FW_ULTRABOLD                    equate(FW_EXTRABOLD)
FW_BLACK                        equate(FW_HEAVY)

PANOSE_COUNT                    equate(10)
PAN_FAMILYTYPE_INDEX            equate(0)
PAN_SERIFSTYLE_INDEX            equate(1)
PAN_WEIGHT_INDEX                equate(2)
PAN_PROPORTION_INDEX            equate(3)
PAN_CONTRAST_INDEX              equate(4)
PAN_STROKEVARIATION_INDEX       equate(5)
PAN_ARMSTYLE_INDEX              equate(6)
PAN_LETTERFORM_INDEX            equate(7)
PAN_MIDLINE_INDEX               equate(8)
PAN_XHEIGHT_INDEX               equate(9)

PAN_CULTURE_LATIN               equate(0)

ANSI_CHARSET                    equate(0)
DEFAULT_CHARSET                 equate(1)
SYMBOL_CHARSET                  equate(2)
SHIFTJIS_CHARSET                equate(128)
HANGEUL_CHARSET                 equate(129)
GB2312_CHARSET                  equate(134)
CHINESEBIG5_CHARSET             equate(136)
OEM_CHARSET                     equate(255)
JOHAB_CHARSET                   equate(130)
HEBREW_CHARSET                  equate(177)
ARABIC_CHARSET                  equate(178)
GREEK_CHARSET                   equate(161)
TURKISH_CHARSET                 equate(162)
VIETNAMESE_CHARSET              equate(163)
THAI_CHARSET                    equate(222)
EASTEUROPE_CHARSET              equate(238)
RUSSIAN_CHARSET                 equate(204)

MAC_CHARSET                     equate(77)
BALTIC_CHARSET                  equate(186)

FS_LATIN1                       equate(00000001h)
FS_LATIN2                       equate(00000002h)
FS_CYRILLIC                     equate(00000004h)
FS_GREEK                        equate(00000008h)
FS_TURKISH                      equate(00000010h)
FS_HEBREW                       equate(00000020h)
FS_ARABIC                       equate(00000040h)
FS_BALTIC                       equate(00000080h)
FS_VIETNAMESE                   equate(00000100h)
FS_THAI                         equate(00010000h)
FS_JISJAPAN                     equate(00020000h)
FS_CHINESESIMP                  equate(00040000h)
FS_WANSUNG                      equate(00080000h)
FS_CHINESETRAD                  equate(00100000h)
FS_JOHAB                        equate(00200000h)
FS_SYMBOL                       equate(80000000h)

OUT_DEFAULT_PRECIS              equate(0)
OUT_STRING_PRECIS               equate(1)
OUT_CHARACTER_PRECIS            equate(2)
OUT_STROKE_PRECIS               equate(3)
OUT_TT_PRECIS                   equate(4)
OUT_DEVICE_PRECIS               equate(5)
OUT_RASTER_PRECIS               equate(6)
OUT_TT_ONLY_PRECIS              equate(7)
OUT_OUTLINE_PRECIS              equate(8)
OUT_SCREEN_OUTLINE_PRECIS       equate(9)

CLIP_DEFAULT_PRECIS             equate(0)
CLIP_CHARACTER_PRECIS           equate(1)
CLIP_STROKE_PRECIS              equate(2)
CLIP_MASK                       equate(0fh)
CLIP_LH_ANGLES                  equate(8)
CLIP_TT_ALWAYS                  equate(32)
CLIP_EMBEDDED                   equate(128)

DEFAULT_QUALITY                 equate(0)
DRAFT_QUALITY                   equate(1)
PROOF_QUALITY                   equate(2)
NONANTIALIASED_QUALITY          equate(3)
ANTIALIASED_QUALITY             equate(4)

!Font Families

FF_DONTCARE                     equate(0)  !Don't care or don't know.
FF_ROMAN                        equate(8)  !Variable stroke width, serifed.
                                           !   Times Roman, Century Schoolbook, etc.
FF_SWISS                        equate(32) !Variable stroke width, sans-serifed.
                                           !   Helvetica, Swiss, etc.
FF_MODERN                       equate(48) !Constant stroke width, serifed or sans-serifed.
                                           !   Pica, Elite, Courier, etc.
FF_SCRIPT                       equate(64) !Cursive, etc.
FF_DECORATIVE                   equate(80) !Old English, etc.

!Predefined Resource Types

RT_CURSOR                       equate(1)
RT_BITMAP                       equate(2)
RT_ICON                         equate(3)
RT_MENU                         equate(4)
RT_DIALOG                       equate(5)
RT_STRING                       equate(6)
RT_FONTDIR                      equate(7)
RT_FONT                         equate(8)
RT_ACCELERATOR                  equate(9)
RT_RCDATA                       equate(10)
RT_MESSAGETABLE                 equate(11)

DIFFERENCE                      equate(11)
RT_GROUP_CURSOR                 equate(RT_CURSOR + DIFFERENCE)
RT_GROUP_ICON                   equate(RT_ICON + DIFFERENCE)
RT_VERSION                      equate(16)
RT_DLGINCLUDE                   equate(17)
RT_PLUGPLAY                     equate(19)
RT_VXD                          equate(20)
RT_ANICURSOR                    equate(21)
RT_ANIICON                      equate(22)

!ernary raster operations

SRCCOPY                         equate(00CC0020h) ! dest = source
SRCPAINT                        equate(00EE0086h) ! dest = source OR dest
SRCAND                          equate(008800C6h) ! dest = source AND dest
SRCINVERT                       equate(00660046h) ! dest = source XOR dest
SRCERASE                        equate(00440328h) ! dest = source AND (NOT dest )
NOTSRCCOPY                      equate(00330008h) ! dest = (NOT source)
NOTSRCERASE                     equate(001100A6h) ! dest = (NOT src) AND (NOT dest)
MERGECOPY                       equate(00C000CAh) ! dest = (source AND pattern)
MERGEPAINT                      equate(00BB0226h) ! dest = (NOT source) OR dest
PATCOPY                         equate(00F00021h) ! dest = pattern
PATPAINT                        equate(00FB0A09h) ! dest = DPSnoo
PATINVERT                       equate(005A0049h) ! dest = pattern XOR dest
DSTINVERT                       equate(00550009h) ! dest = (NOT dest)
BLACKNESS                       equate(00000042h) ! dest = BLACK
WHITENESS                       equate(00FF0062h) ! dest = WHITE

!PolyFill() Modes

ALTERNATE                       equate(1)
WINDING                         equate(2)
POLYFILL_LAST                   equate(2)

IMAGE_BITMAP                    equate(0)
IMAGE_ICON                      equate(1)
IMAGE_CURSOR                    equate(2)
IMAGE_ENHMETAFILE               equate(3)

LR_DEFAULTCOLOR                 equate(0000h)
LR_MONOCHROME                   equate(0001h)
LR_COLOR                        equate(0002h)
LR_COPYRETURNORG                equate(0004h)
LR_COPYDELETEORG                equate(0008h)
LR_LOADFROMFILE                 equate(0010h)
LR_LOADTRANSPARENT              equate(0020h)
LR_DEFAULTSIZE                  equate(0040h)
LR_VGACOLOR                     equate(0080h)
LR_LOADMAP3DCOLORS              equate(1000h)
LR_CREATEDIBSECTION             equate(2000h)
LR_COPYFROMRESOURCE             equate(4000h)
LR_SHARED                       equate(8000h)

!RedrawWindow() flags

RDW_INVALIDATE                  equate(0001h)
RDW_INTERNALPAINT               equate(0002h)
RDW_ERASE                       equate(0004h)
RDW_VALIDATE                    equate(0008h)
RDW_NOINTERNALPAINT             equate(0010h)
RDW_NOERASE                     equate(0020h)
RDW_NOCHILDREN                  equate(0040h)
RDW_ALLCHILDREN                 equate(0080h)
RDW_UPDATENOW                   equate(0100h)
RDW_ERASENOW                    equate(0200h)
RDW_FRAME                       equate(0400h)
RDW_NOFRAME                     equate(0800h)

!flags for DrawFrameControl

DFC_CAPTION                     equate(1)
DFC_MENU                        equate(2)
DFC_SCROLL                      equate(3)
DFC_BUTTON                      equate(4)

DFCS_CAPTIONCLOSE               equate(0000h)
DFCS_CAPTIONMIN                 equate(0001h)
DFCS_CAPTIONMAX                 equate(0002h)
DFCS_CAPTIONRESTORE             equate(0003h)
DFCS_CAPTIONHELP                equate(0004h)
DFCS_MENUARROW                  equate(0000h)
DFCS_MENUCHECK                  equate(0001h)
DFCS_MENUBULLET                 equate(0002h)
DFCS_MENUARROWRIGHT             equate(0004h)
DFCS_SCROLLUP                   equate(0000h)
DFCS_SCROLLDOWN                 equate(0001h)
DFCS_SCROLLLEFT                 equate(0002h)
DFCS_SCROLLRIGHT                equate(0003h)
DFCS_SCROLLCOMBOBOX             equate(0005h)
DFCS_SCROLLSIZEGRIP             equate(0008h)
DFCS_SCROLLSIZEGRIPRIGHT        equate(0010h)
DFCS_BUTTONCHECK                equate(0000h)
DFCS_BUTTONRADIOIMAGE           equate(0001h)
DFCS_BUTTONRADIOMASK            equate(0002h)
DFCS_BUTTONRADIO                equate(0004h)
DFCS_BUTTON3STATE               equate(0008h)
DFCS_BUTTONPUSH                 equate(0010h)
DFCS_INACTIVE                   equate(0100h)
DFCS_PUSHED                     equate(0200h)
DFCS_CHECKED                    equate(0400h)
DFCS_ADJUSTRECT                 equate(2000h)
DFCS_FLAT                       equate(4000h)
DFCS_MONO                       equate(8000h)

ETO_OPAQUE                      equate(00002h)
ETO_CLIPPED                     equate(00004h)
!#if(WINVER >= 0x0400)
ETO_GLYPH_INDEX                 equate(00010h)
ETO_RTLREADING                  equate(00080h)
ETO_NUMERICSLOCAL               equate(00400h)
ETO_NUMERICSLATIN               equate(00800h)
ETO_IGNORELANGUAGE              equate(01000h)
!#endif /* WINVER >= 0x0400 */
!#if (_WIN32_WINNT >= 0x0500)
ETO_PDY                         equate(02000h)
!#endif // (_WIN32_WINNT >= 0x0500)

RGNDATAHEADER                   group,type
dwSize                            long
iType                             long
nCount                            long
nRgnSize                          long
rcBound                           group(_RECT_).
                                end

RGNDATA                         group,type
rdh                               group(RGNDATAHEADER).
Buffer                            &string
                                end

COLOR_SCROLLBAR                 equate(0)
COLOR_BACKGROUND                equate(1)
COLOR_ACTIVECAPTION             equate(2)
COLOR_INACTIVECAPTION           equate(3)
COLOR_MENU                      equate(4)
COLOR_WINDOW                    equate(5)
COLOR_WINDOWFRAME               equate(6)
COLOR_MENUTEXT                  equate(7)
COLOR_WINDOWTEXT                equate(8)
COLOR_CAPTIONTEXT               equate(9)
COLOR_ACTIVEBORDER              equate(10)
COLOR_INACTIVEBORDER            equate(11)
COLOR_APPWORKSPACE              equate(12)
COLOR_HIGHLIGHT                 equate(13)
COLOR_HIGHLIGHTTEXT             equate(14)
COLOR_BTNFACE                   equate(15)
COLOR_BTNSHADOW                 equate(16)
COLOR_GRAYTEXT                  equate(17)
COLOR_BTNTEXT                   equate(18)
COLOR_INACTIVECAPTIONTEXT       equate(19)
COLOR_BTNHIGHLIGHT              equate(20)
COLOR_3DDKSHADOW                equate(21)
COLOR_3DLIGHT                   equate(22)
COLOR_INFOTEXT                  equate(23)
COLOR_INFOBK                    equate(24)
COLOR_DESKTOP                   equate(COLOR_BACKGROUND)
COLOR_3DFACE                    equate(COLOR_BTNFACE)
COLOR_3DSHADOW                  equate(COLOR_BTNSHADOW)
COLOR_3DHIGHLIGHT               equate(COLOR_BTNHIGHLIGHT)
COLOR_3DHILIGHT                 equate(COLOR_BTNHIGHLIGHT)
COLOR_BTNHILIGHT                equate(COLOR_BTNHIGHLIGHT)

!Hatch Styles

HS_HORIZONTAL                   equate(0)       ! -----
HS_VERTICAL                     equate(1)       ! |||||
HS_FDIAGONAL                    equate(2)       ! \\\\\
HS_BDIAGONAL                    equate(3)       ! /////
HS_CROSS                        equate(4)       ! +++++
HS_DIAGCROSS                    equate(5)       ! xxxxx

!Window field offsets for GetWindowLong() / SetWindowLong()

GWL_WNDPROC                     equate(-4)
GWL_HINSTANCE                   equate(-6)
GWL_HWNDPARENT                  equate(-8)
GWL_STYLE                       equate(-16)
GWL_EXSTYLE                     equate(-20)
GWL_USERDATA                    equate(-21)
GWL_ID                          equate(-12)

!ShowWindow() Commands

SW_HIDE                         equate(0)
SW_SHOWNORMAL                   equate(1)
SW_NORMAL                       equate(1)
SW_SHOWMINIMIZED                equate(2)
SW_SHOWMAXIMIZED                equate(3)
SW_MAXIMIZE                     equate(3)
SW_SHOWNOACTIVATE               equate(4)
SW_SHOW                         equate(5)
SW_MINIMIZE                     equate(6)
SW_SHOWMINNOACTIVE              equate(7)
SW_SHOWNA                       equate(8)
SW_RESTORE                      equate(9)
SW_SHOWDEFAULT                  equate(10)
SW_MAX                          equate(10)

!Old ShowWindow() Commands

HIDE_WINDOW                     equate(0)
SHOW_OPENWINDOW                 equate(1)
SHOW_ICONWINDOW                 equate(2)
SHOW_FULLSCREEN                 equate(3)
SHOW_OPENNOACTIVATE             equate(4)

!Identifiers for the WM_SHOWWINDOW message

SW_PARENTCLOSING                equate(1)
SW_OTHERZOOM                    equate(2)
SW_PARENTOPENING                equate(3)
SW_OTHERUNZOOM                  equate(4)

!User Button Notification Codes

BN_CLICKED                      equate(0)
BN_PAINT                        equate(1)
BN_HILITE                       equate(2)
BN_UNHILITE                     equate(3)
BN_DISABLE                      equate(4)
BN_DOUBLECLICKED                equate(5)
BN_PUSHED                       equate(BN_HILITE)
BN_UNPUSHED                     equate(BN_UNHILITE)
BN_DBLCLK                       equate(BN_DOUBLECLICKED)
BN_SETFOCUS                     equate(6)
BN_KILLFOCUS                    equate(7)

!Button Control Messages

BM_GETCHECK                     equate(00F0h)
BM_SETCHECK                     equate(00F1h)
BM_GETSTATE                     equate(00F2h)
BM_SETSTATE                     equate(00F3h)
BM_SETSTYLE                     equate(00F4h)
BM_CLICK                        equate(00F5h)
BM_GETIMAGE                     equate(00F6h)
BM_SETIMAGE                     equate(00F7h)

BST_UNCHECKED                   equate(0000h)
BST_CHECKED                     equate(0001h)
BST_INDETERMINATE               equate(0002h)
BST_PUSHED                      equate(0004h)
BST_FOCUS                       equate(0008h)

!MessageBox() Flags

MB_OK                           equate(00000000h)
MB_OKCANCEL                     equate(00000001h)
MB_ABORTRETRYIGNORE             equate(00000002h)
MB_YESNOCANCEL                  equate(00000003h)
MB_YESNO                        equate(00000004h)
MB_RETRYCANCEL                  equate(00000005h)

MB_ICONHAND                     equate(00000010h)
MB_ICONQUESTION                 equate(00000020h)
MB_ICONEXCLAMATION              equate(00000030h)
MB_ICONASTERISK                 equate(00000040h)

MB_USERICON                     equate(00000080h)
MB_ICONWARNING                  equate(MB_ICONEXCLAMATION)
MB_ICONERROR                    equate(MB_ICONHAND)

MB_ICONINFORMATION              equate(MB_ICONASTERISK)
MB_ICONSTOP                     equate(MB_ICONHAND)

MB_DEFBUTTON1                   equate(00000000h)
MB_DEFBUTTON2                   equate(00000100h)
MB_DEFBUTTON3                   equate(00000200h)

MB_DEFBUTTON4                   equate(00000300h)

MB_APPLMODAL                    equate(00000000h)
MB_SYSTEMMODAL                  equate(00001000h)
MB_TASKMODAL                    equate(00002000h)

MB_HELP                         equate(00004000h) ! Help Button

MB_NOFOCUS                      equate(00008000h)
MB_SETFOREGROUND                equate(00010000h)
MB_DEFAULT_DESKTOP_ONLY         equate(00020000h)

MB_TOPMOST                      equate(00040000h)
MB_RIGHT                        equate(00080000h)
MB_RTLREADING                   equate(00100000h)

MB_TYPEMASK                     equate(0000000Fh)
MB_ICONMASK                     equate(000000F0h)
MB_DEFMASK                      equate(00000F00h)
MB_MODEMASK                     equate(00003000h)
MB_MISCMASK                     equate(0000C000h)

!Global Memory Flags

GMEM_FIXED                      equate(0000h)
GMEM_MOVEABLE                   equate(0002h)
GMEM_NOCOMPACT                  equate(0010h)
GMEM_NODISCARD                  equate(0020h)
GMEM_ZEROINIT                   equate(0040h)
GMEM_MODIFY                     equate(0080h)
GMEM_DISCARDABLE                equate(0100h)
GMEM_NOT_BANKED                 equate(1000h)
GMEM_SHARE                      equate(2000h)
GMEM_DDESHARE                   equate(2000h)
GMEM_NOTIFY                     equate(4000h)
GMEM_LOWER                      equate(GMEM_NOT_BANKED)
GMEM_VALID_FLAGS                equate(7F72h)
GMEM_INVALID_HANDLE             equate(8000h)

GHND                            equate(GMEM_MOVEABLE + GMEM_ZEROINIT)
GPTR                            equate(GMEM_FIXED + GMEM_ZEROINIT)

!Flags returned by GlobalFlags (in addition to GMEM_DISCARDABLE)

GMEM_DISCARDED                  equate(4000h)
GMEM_LOCKCOUNT                  equate(00FFh)

! GetSystemMetrics() codes

SM_CXSCREEN                     equate(0)
SM_CYSCREEN                     equate(1)
SM_CXVSCROLL                    equate(2)
SM_CYHSCROLL                    equate(3)
SM_CYCAPTION                    equate(4)
SM_CXBORDER                     equate(5)
SM_CYBORDER                     equate(6)
SM_CXDLGFRAME                   equate(7)
SM_CYDLGFRAME                   equate(8)
SM_CYVTHUMB                     equate(9)
SM_CXHTHUMB                     equate(10)
SM_CXICON                       equate(11)
SM_CYICON                       equate(12)
SM_CXCURSOR                     equate(13)
SM_CYCURSOR                     equate(14)
SM_CYMENU                       equate(15)
SM_CXFULLSCREEN                 equate(16)
SM_CYFULLSCREEN                 equate(17)
SM_CYKANJIWINDOW                equate(18)
SM_MOUSEPRESENT                 equate(19)
SM_CYVSCROLL                    equate(20)
SM_CXHSCROLL                    equate(21)
SM_DEBUG                        equate(22)
SM_SWAPBUTTON                   equate(23)
SM_RESERVED1                    equate(24)
SM_RESERVED2                    equate(25)
SM_RESERVED3                    equate(26)
SM_RESERVED4                    equate(27)
SM_CXMIN                        equate(28)
SM_CYMIN                        equate(29)
SM_CXSIZE                       equate(30)
SM_CYSIZE                       equate(31)
SM_CXFRAME                      equate(32)
SM_CYFRAME                      equate(33)
SM_CXMINTRACK                   equate(34)
SM_CYMINTRACK                   equate(35)
SM_CXDOUBLECLK                  equate(36)
SM_CYDOUBLECLK                  equate(37)
SM_CXICONSPACING                equate(38)
SM_CYICONSPACING                equate(39)
SM_MENUDROPALIGNMENT            equate(40)
SM_PENWINDOWS                   equate(41)
SM_DBCSENABLED                  equate(42)
SM_CMOUSEBUTTONS                equate(43)

SM_CXFIXEDFRAME                 equate(SM_CXDLGFRAME)  ! ;win40 name change
SM_CYFIXEDFRAME                 equate(SM_CYDLGFRAME)  ! ;win40 name change
SM_CXSIZEFRAME                  equate(SM_CXFRAME)     ! ;win40 name change
SM_CYSIZEFRAME                  equate(SM_CYFRAME)     ! ;win40 name change

SM_SECURE                       equate(44)
SM_CXEDGE                       equate(45)
SM_CYEDGE                       equate(46)
SM_CXMINSPACING                 equate(47)
SM_CYMINSPACING                 equate(48)
SM_CXSMICON                     equate(49)
SM_CYSMICON                     equate(50)
SM_CYSMCAPTION                  equate(51)
SM_CXSMSIZE                     equate(52)
SM_CYSMSIZE                     equate(53)
SM_CXMENUSIZE                   equate(54)
SM_CYMENUSIZE                   equate(55)
SM_ARRANGE                      equate(56)
SM_CXMINIMIZED                  equate(57)
SM_CYMINIMIZED                  equate(58)
SM_CXMAXTRACK                   equate(59)
SM_CYMAXTRACK                   equate(60)
SM_CXMAXIMIZED                  equate(61)
SM_CYMAXIMIZED                  equate(62)
SM_NETWORK                      equate(63)
SM_CLEANBOOT                    equate(67)
SM_CXDRAG                       equate(68)
SM_CYDRAG                       equate(69)
SM_SHOWSOUNDS                   equate(70)
SM_CXMENUCHECK                  equate(71)   ! Use instead of GetMenuCheckMarkDimensions()!
SM_CYMENUCHECK                  equate(72)
SM_SLOWMACHINE                  equate(73)
SM_MIDEASTENABLED               equate(74)
SM_CMETRICS                     equate(75)

! Scroll Bar Styles

SBS_HORZ                        equate(0000)
SBS_VERT                        equate(0001)
SBS_TOPALIGN                    equate(0002)
SBS_LEFTALIGN                   equate(0002)
SBS_BOTTOMALIGN                 equate(0004)
SBS_RIGHTALIGN                  equate(0004)
SBS_SIZEBOXTOPLEFTALIGN         equate(0002)
SBS_SIZEBOXBOTTOMRIGHTALIGN     equate(0004)
SBS_SIZEBOX                     equate(0008)
SBS_SIZEGRIP                    equate(0010)

! Scroll bar messages

SBM_SETPOS                      equate(00E0h) !not in win3.1
SBM_GETPOS                      equate(00E1h) !not in win3.1
SBM_SETRANGE                    equate(00E2h) !not in win3.1
SBM_SETRANGEREDRAW              equate(00E6h) !not in win3.1
SBM_GETRANGE                    equate(00E3h) !not in win3.1
SBM_ENABLE_ARROWS               equate(00E4h) !not in win3.1
SBM_SETSCROLLINFO               equate(00E9h)
SBM_GETSCROLLINFO               equate(00EAh)

SIF_RANGE                       equate(0001)
SIF_PAGE                        equate(0002)
SIF_POS                         equate(0004)
SIF_DISABLENOSCROLL             equate(0008)
SIF_TRACKPOS                    equate(0010)
SIF_ALL                         equate(SIF_RANGE + SIF_POS + SIF_TRACKPOS)

SCROLLINFO                      group,type
cbSize                            unsigned
fMask                             unsigned
nMin                              signed
nMax                              signed
nPage                             unsigned
nPos                              signed
nTrackPos                         signed
                                end

! Scroll Bar Constants

SB_HORZ                         equate(0)
SB_VERT                         equate(1)
SB_CTL                          equate(2)
SB_BOTH                         equate(3)

! Scroll Bar Commands

SB_LINEUP                       equate(0)
SB_LINELEFT                     equate(0)
SB_LINEDOWN                     equate(1)
SB_LINERIGHT                    equate(1)
SB_PAGEUP                       equate(2)
SB_PAGELEFT                     equate(2)
SB_PAGEDOWN                     equate(3)
SB_PAGERIGHT                    equate(3)
SB_THUMBPOSITION                equate(4)
SB_THUMBTRACK                   equate(5)
SB_TOP                          equate(6)
SB_LEFT                         equate(6)
SB_BOTTOM                       equate(7)
SB_RIGHT                        equate(7)
SB_ENDSCROLL                    equate(8)

GUITHREADINFO                   group,type
cbSize                            long
flags                             long
hwndActive                        HWND
hwndFocus                         HWND
hwndCapture                       HWND
hwndMenuOwner                     HWND
hwndMoveSize                      HWND
hwndCaret                         HWND
rcCaret                           like(_RECT_)
                                end

! Menu Equates

MENUINFO                        group,type
cbSize                            long
fMask                             long
dwStyle                           long
cyMax                             long
hbrBack                           HBRUSH
dwContextHelpID                   long
dwMenuData                        long
                                end

MENUITEMINFO                    group,type
cbSize                            long
fMask                             long
fType                             long
fState                            long
wID                               long
hSubMenu                          HMENU
hbmpChecked                       HBITMAP
hbmpUnchecked                     HBITMAP
dwItemData                        long
dwTypeData                        long
cch                               long
hbmpItem                          HBITMAP
                                end

!#if(WINVER >= 0400h)
MIIM_STATE                      equate(00000001h)
MIIM_ID                         equate(00000002h)
MIIM_SUBMENU                    equate(00000004h)
MIIM_CHECKMARKS                 equate(00000008h)
MIIM_TYPE                       equate(00000010h)
MIIM_DATA                       equate(00000020h)
!#endif ! WINVER >= 0400h

!#if(WINVER >= 0500h)
MIIM_STRING                     equate(00000040h)
MIIM_BITMAP                     equate(00000080h)
MIIM_FTYPE                      equate(00000100h)

HBMMENU_CALLBACK                equate(-1)
HBMMENU_SYSTEM                  equate(1)
HBMMENU_MBAR_RESTORE            equate(2)
HBMMENU_MBAR_MINIMIZE           equate(3)
HBMMENU_MBAR_CLOSE              equate(5)
HBMMENU_MBAR_CLOSE_D            equate(6)
HBMMENU_MBAR_MINIMIZE_D         equate(7)
HBMMENU_POPUP_CLOSE             equate(8)
HBMMENU_POPUP_RESTORE           equate(9)
HBMMENU_POPUP_MAXIMIZE          equate(10)
HBMMENU_POPUP_MINIMIZE          equate(11)
!#endif ! WINVER >= 0500h

SECURITY_ATTRIBUTES             group,type
nLength                           long
lpSecurityDescriptor              long
bInheritHandle                    bool
                                end

CRITICAL_SECTION                group,type
DebugInfo                         long       !Ptr to _RTL_CRITICAL_SECTION_DEBUG

    !
    !  The following three fields control entering and exiting the critical
    !  section for the resource
    !

LockCount                         long
RecursionCount                    long
OwningThread                      HANDLE        ! from the thread's ClientId->UniqueThread
LockSemaphore                     HANDLE
Reserved                          long
                                end

HEAP_NO_SERIALIZE               equate(00000001h)
HEAP_GROWABLE                   equate(00000002h)
HEAP_GENERATE_EXCEPTIONS        equate(00000004h)
HEAP_ZERO_MEMORY                equate(00000008h)
HEAP_REALLOC_IN_PLACE_ONLY      equate(00000010h)
HEAP_TAIL_CHECKING_ENABLED      equate(00000020h)
HEAP_FREE_CHECKING_ENABLED      equate(00000040h)
HEAP_DISABLE_COALESCE_ON_FREE   equate(00000080h)
HEAP_CREATE_ALIGN_16            equate(00010000h)
HEAP_CREATE_ENABLE_TRACING      equate(00020000h)
HEAP_MAXIMUM_TAG                equate(0FFFh)
HEAP_PSEUDO_TAG_FLAG            equate(08000h)
HEAP_TAG_SHIFT                  equate(18)

DST_COMPLEX                     equate(00000h)
DST_TEXT                        equate(00001h)
DST_PREFIXTEXT                  equate(00002h)
DST_ICON                        equate(00003h)
DST_BITMAP                      equate(00004h)

! State type

DSS_NORMAL                      equate(00000h)
DSS_UNION                       equate(00010h)  ! Gray string appearance
DSS_DISABLED                    equate(00020h)
DSS_MONO                        equate(00080h)
DSS_RIGHT                       equate(08000h)

FLAG_ICC_FORCE_CONNECTION       equate(01h)

!*
!* Queue status flags for GetQueueStatus() and MsgWaitForMultipleObjects()
!*

QS_KEY                          equate(0001h)
QS_MOUSEMOVE                    equate(0002h)
QS_MOUSEBUTTON                  equate(0004h)
QS_POSTMESSAGE                  equate(0008h)
QS_TIMER                        equate(0010h)
QS_PAINT                        equate(0020h)
QS_SENDMESSAGE                  equate(0040h)
QS_HOTKEY                       equate(0080h)
QS_ALLPOSTMESSAGE               equate(0100h)

QS_MOUSE                        equate(QS_MOUSEMOVE + QS_MOUSEBUTTON)
QS_INPUT                        equate(QS_MOUSE + QS_KEY)
QS_ALLEVENTS                    equate(QS_INPUT +       |
                                       QS_POSTMESSAGE + |
                                       QS_TIMER +       |
                                       QS_PAINT +       |
                                       QS_HOTKEY)
QS_ALLINPUT                     equate(QS_INPUT +       |
                                       QS_POSTMESSAGE + |
                                       QS_TIMER +       |
                                       QS_PAINT +       |
                                       QS_HOTKEY +      |
                                       QS_SENDMESSAGE)

STATUS_WAIT_0                   equate(000000000h)
STATUS_ABANDONED_WAIT_0         equate(000000080h)
STATUS_USER_APC                 equate(0000000C0h)
STATUS_TIMEOUT                  equate(000000102h)
STATUS_PENDING                  equate(000000103h)
STATUS_SEGMENT_NOTIFICATION     equate(040000005h)
STATUS_GUARD_PAGE_VIOLATION     equate(080000001h)
STATUS_DATATYPE_MISALIGNMENT    equate(080000002h)
STATUS_BREAKPOINT               equate(080000003h)
STATUS_SINGLE_STEP              equate(080000004h)
STATUS_ACCESS_VIOLATION         equate(0C0000005h)
STATUS_IN_PAGE_ERROR            equate(0C0000006h)
STATUS_INVALID_HANDLE           equate(0C0000008h)
STATUS_NO_MEMORY                equate(0C0000017h)
STATUS_ILLEGAL_INSTRUCTION      equate(0C000001Dh)
STATUS_NONCONTINUABLE_EXCEPTION equate(0C0000025h)
STATUS_INVALID_DISPOSITION      equate(0C0000026h)
STATUS_ARRAY_BOUNDS_EXCEEDED    equate(0C000008Ch)
STATUS_FLOAT_DENORMAL_OPERAND   equate(0C000008Dh)
STATUS_FLOAT_DIVIDE_BY_ZERO     equate(0C000008Eh)
STATUS_FLOAT_INEXACT_RESULT     equate(0C000008Fh)
STATUS_FLOAT_INVALID_OPERATION  equate(0C0000090h)
STATUS_FLOAT_OVERFLOW           equate(0C0000091h)
STATUS_FLOAT_STACK_CHECK        equate(0C0000092h)
STATUS_FLOAT_UNDERFLOW          equate(0C0000093h)
STATUS_INTEGER_DIVIDE_BY_ZERO   equate(0C0000094h)
STATUS_INTEGER_OVERFLOW         equate(0C0000095h)
STATUS_PRIVILEGED_INSTRUCTION   equate(0C0000096h)
STATUS_STACK_OVERFLOW           equate(0C00000FDh)
STATUS_CONTROL_C_EXIT           equate(0C000013Ah)
STATUS_FLOAT_MULTIPLE_FAULTS    equate(0C00002B4h)
STATUS_FLOAT_MULTIPLE_TRAPS     equate(0C00002B5h)
STATUS_ILLEGAL_VLM_REFERENCE    equate(0C00002C0h)

MAXIMUM_WAIT_OBJECTS            equate(64)     ! Maximum number of wait objects

WAIT_FAILED                     equate(0FFFFFFFFh)
WAIT_OBJECT_0                   equate((STATUS_WAIT_0) + 0)
WAIT_ABANDONED                  equate((STATUS_ABANDONED_WAIT_0) + 0)
WAIT_ABANDONED_0                equate((STATUS_ABANDONED_WAIT_0) + 0)
WAIT_TIMEOUT                    equate(STATUS_TIMEOUT)
WAIT_IO_COMPLETION              equate(STATUS_USER_APC)
STILL_ACTIVE                    equate(STATUS_PENDING)

MSG                             group,type
hwnd                              HWND
message                           long
wParam                            unsigned
lParam                            long
time                              long
pt                                like(POINT)
                                end

!*
!* PeekMessage() Options
!*

PM_NOREMOVE                     equate(00000h)
PM_REMOVE                       equate(00001h)
PM_NOYIELD                      equate(00002h)

!*
!*  Code Page Default Values.
!*

CP_ACP                          equate(0)           ! default to ANSI code page
CP_OEMCP                        equate(1)           ! default to OEM  code page
CP_MACCP                        equate(2)           ! default to MAC  code page
CP_THREAD_ACP                   equate(3)           ! current thread's ANSI code page
CP_SYMBOL                       equate(42)          ! SYMBOL translations

CP_UTF7                         equate(65000)       ! UTF-7 translation
CP_UTF8                         equate(65001)       ! UTF-8 translation

!
!  String Length Maximums.
!

MAX_LEADBYTES                   equate(12)         ! 5 ranges, 2 bytes ea., 0 term.
MAX_DEFAULTCHAR                 equate(2)          ! single or double byte


!
!  MBCS and Unicode Translation Flags.
!

MB_PRECOMPOSED                  equate(00000001h)  ! use precomposed chars
MB_COMPOSITE                    equate(00000002h)  ! use composite chars
MB_USEGLYPHCHARS                equate(00000004h)  ! use glyph chars, not ctrl chars
MB_ERR_INVALID_CHARS            equate(00000008h)  ! error for invalid chars

WC_COMPOSITECHECK               equate(00000200h)  ! convert composite to precomposed
WC_DISCARDNS                    equate(00000010h)  ! discard non-spacing chars
WC_SEPCHARS                     equate(00000020h)  ! generate separate chars
WC_DEFAULTCHAR                  equate(00000040h)  ! replace w/ default char

WC_NO_BEST_FIT_CHARS            equate(00000400h)  ! do not use best fit chars


INFINITE                        equate(0FFFFFFFFh) ! Infinite timeout

!*
!* Predefined Clipboard Formats
!*

CF_TEXT                         equate(1)
CF_BITMAP                       equate(2)
CF_METAFILEPICT                 equate(3)
CF_SYLK                         equate(4)
CF_DIF                          equate(5)
CF_TIFF                         equate(6)
CF_OEMTEXT                      equate(7)
CF_DIB                          equate(8)
CF_PALETTE                      equate(9)
CF_PENDATA                      equate(10)
CF_RIFF                         equate(11)
CF_WAVE                         equate(12)
CF_UNICODETEXT                  equate(13)
CF_ENHMETAFILE                  equate(14)

!#if(WINVER >= 0x0400)

CF_HDROP                        equate(15)
CF_LOCALE                       equate(16)
CF_MAX                          equate(17)

!#endif /* WINVER >= 0x0400 */

CF_OWNERDISPLAY                 equate(0080h)
CF_DSPTEXT                      equate(0081h)
CF_DSPBITMAP                    equate(0082h)
CF_DSPMETAFILEPICT              equate(0083h)
CF_DSPENHMETAFILE               equate(008Eh)

!*
!* "Private" formats don't get GlobalFree()'d
!*

CF_PRIVATEFIRST                 equate(0200h)
CF_PRIVATELAST                  equate(02FFh)

!*
!* "GDIOBJ" formats do get DeleteObject()'d
!*

CF_GDIOBJFIRST                  equate(0300h)
CF_GDIOBJLAST                   equate(03FFh)

!*
!* Reserved Key Handles.
!*

HKEY_CLASSES_ROOT               equate(080000000h)
HKEY_CURRENT_USER               equate(080000001h)
HKEY_LOCAL_MACHINE              equate(080000002h)
HKEY_USERS                      equate(080000003h)
HKEY_PERFORMANCE_DATA           equate(080000004h)

!#if(WINVER >= 0x0400)

HKEY_CURRENT_CONFIG             equate(080000005h)
HKEY_DYN_DATA                   equate(080000006h)

!#endif /* WINVER >= 0x0400 */

  include('winerr.inc'),once

  EndDefine

