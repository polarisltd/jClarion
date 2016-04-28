
  module('WinAPI')
  omit('EndAnsi', _Unicode_)
    MessageBox(HWND hWnd, long lpText, long lpCaption, long uType),long,pascal,name('MessageBoxA'),proc
  EndAnsi
  compile('EndUnicode', _Unicode_)
    MessageBox(HWND hWnd, long lpText, long lpCaption, long uType),long,pascal,name('MessageBoxW'),proc
  EndUnicode
    MessageBoxW(HWND hWnd, long lpText, long lpCaption, long uType),long,pascal,proc

    IsWindowEnabled(HWND hWnd),bool,pascal

    GetFileAttributes(*CString szFileName),long,pascal,raw,name('GetFileAttributesA')
    CreateDirectory(*CString szPathName, *SECURITY_ATTRIBUTES SecurityAttributes),bool,pascal,raw,name('CreateDirectoryA')

    DefWindowProc(HWND hWnd, unsigned nMsg, unsigned wParam, |
                  long lParam),long,pascal,name('DefWindowProcA')
    SetWindowLong(HWND hWnd, signed nIndex, long dwNewLong),long,pascal,proc,name('SetWindowLongA')
    GetWindowLong(HWND hWnd, signed nIndex),long,pascal,name('GetWindowLongA')
    CallWindowProc(long lpPrevWndProc, HWND hwnd, unsigned nMsg, unsigned wParam, |
                   long lParam),long,pascal,name('CallWindowProcA')

    RegisterClass(*WNDCLASS lpWndClass),ATOM,pascal,raw,name('RegisterClassA')
    RegisterClassEx(*WNDCLASSEX lpWndClassEx),ATOM,pascal,raw,name('RegisterClassExA')
    UnRegisterClass(*CString lpClassName, HINSTANCE hInstance),bool,raw,pascal,name('UnRegisterClassA')
    GetClassInfo(HINSTANCE hInst, *CString lpClassName, *WNDCLASS |
                 lpWndClass),bool,raw,pascal,name('GetClassInfoA')

    LoadCursor(HINSTANCE hInst, long lpCursorName),HCURSOR,pascal, |
               name('LoadCursorA')
    ShowCursor(bool bShow),long,pascal
    APISetCursor(long hCursor),long,name('SetCursor')
    SetCursorPos(signed x, signed y),bool,pascal,proc
    GetCursorPos(*POINT),bool,raw,pascal,proc

    CreateMenu(),HMENU,pascal
    DestroyMenu(HMENU hMenu),bool,pascal,proc

    CreateWindowEx(unsigned dwExStyle, *CString lpClassName, <*CString lpWindowName>, |
                   unsigned dwStyle, signed X, signed Y, signed nWidth, signed nHeight, |
                   HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, long lpParam), |
                   HWND,raw,pascal,name('CreateWindowExA')
    UpdateWindow(HWND hWnd),bool,pascal,proc
    RedrawWindow(HWND hWnd, long lprcUpdate, HRGN hrgnUpdate, unsigned flags),bool,raw,pascal
    BeginPaint(HWND hWnd, *PAINTSTRUCT lpPaint),HDC,raw,pascal
    EndPaint(HWND hWnd, *PAINTSTRUCT lpPaint),bool,raw,pascal,proc
    GetUpdateRect(HWND hWnd, *_RECT_ lpRect, bool bErase),bool,pascal,raw
    GetStockObject(signed),HGDIOBJ,pascal
    DestroyWindow(HWND hWnd),bool,pascal,proc
    PostMessage(HWND hWnd, unsigned nMsg, unsigned wParam, long lParam), |
                bool,pascal,proc,name('PostMessageA')
    SendMessage(HWND hWnd, long nMsg, long wParam, long lParam), |
                byte,pascal,proc,name('SendMessageA')
    PeekMessage(long lpMsg, HWND hWnd, long wMsgFilterMin, long wMsgFilterMax, long wRemoveMsg),bool,pascal,proc,name('PeekMessageA')
    SetWindowPos(HWND hWnd, HWND hWndInsertAfter, unsigned x, unsigned y, |
                 unsigned cx, unsigned cy, unsigned uFlags),bool,pascal,proc
    MoveWindow(HWND hWnd, unsigned x, unsigned y, unsigned cx, unsigned cy, bool bRedraw),bool,pascal,proc
    SetWindowText(HWND hWnd, *CString lpString),bool,raw,pascal,name('SetWindowTextA')
    ShowWindow(HWND hWnd, signed nCmdShow),bool,pascal,proc
    SetForegroundWindow(HWND hwnd),bool,pascal,proc
    GetLastActivePopup(HWND hwnd),HWND,pascal
    IsIconic(HWND hwnd),bool,pascal
    ScreenToClient(HWND hWnd, *POINT lpPOINT),bool,raw,pascal,proc
    ClientToScreen(HWND hWnd, *POINT lpPOINT),bool,raw,pascal,proc
    GetWindowRect(HWND hWnd, *_RECT_ lpRect),bool,raw,pascal,proc
    GetClientRect(HWND hWnd, *_RECT_ lpRect),bool,raw,pascal,proc
    DrawEdge(HDC hdc, *_RECT_ qrc, unsigned edge, unsigned grfFlags), |
             bool,raw,pascal,proc
    DrawText(HDC hdc, *CString lpszString, unsigned nCount, *_RECT_ lpRect, |
             unsigned uFormat),signed,raw,pascal,proc,name('DrawTextA')
    DrawState(HDC hdc, HBRUSH hbr, long lpOutputFunc, long lData, long wData, long x, |
              long y, long cx, long cy, long fuFlags),bool,pascal,name('DrawStateA'),proc
    Rectangle(HDC hdc, signed nLeftRect, signed nTopRect, signed nRightRect, |
              signed nBottomRect),bool,pascal,proc
    EqualRect(*_RECT_, *_RECT_),bool,raw,pascal
    RoundRect(HDC hdc, signed nLeftRect, signed nTopRect, signed nRightRect, |
              signed nBottomRect, signed nWidth, signed nHeight),bool,pascal
    CopyRect(*_RECT_ rcDst, *_RECT_ rcSrc),byte,raw,pascal,proc
    CopyRectRaw(long rcDst, long rcSrc),byte,pascal,proc,name('CopyRect')
    SetPolyFillMode(HDC hdc, long iPolyFillMode),long,pascal,proc
    Polygon(HDC hdc, long lpPt, long nCount),bool,proc,pascal
    SetBkMode(HDC hdc, signed iBkMode),signed,pascal,proc
    SetBkColor(HDC hdc, COLORREF crColor),bool,pascal,proc
    SetTextColor(HDC hdc, COLORREF crColor),COLORREF,pascal,proc
    GetTextExtentPoint(HDC hdc, *cstring lpString, long cbString, *SIZE lpSize),bool,raw,pascal,proc,name('GetTextExtentPointA')
    GetTextExtentExPoint(HDC hdc, *cstring szStr, long cchString, long nMaxExtent, |
                         *long nFit, <*long Dx>, *SIZE Size),bool,raw,pascal,name('GetTextExtentExPointA')
    GetTextExtentPoint32(HDC hdc, *cstring szString, long cbString, *SIZE lpSize),bool,raw,pascal,name('GetTextExtentPoint32A')
    CreateFont(signed nHeight, signed nWidth, signed nEscapement, |
               signed nOrientation, signed fnWeight, unsigned fdwItalic, |
               unsigned fdwUnderline, unsigned fdwStrikeOut, unsigned |
               fdwCharSet, unsigned fdwOutputPrecision, unsigned |
               fdwClipPrecision, unsigned fdwQuality, unsigned |
               fdwPitchAndFamily, *CString lpszFace),HFONT,pascal,raw, |
               name('CreateFontA')
    ExtTextOut(HDC hdc, long X, long Y, long fuOptions, *_RECT_ rc, <*cstring lpString>, long cbCount, long lpDx),bool,raw,pascal,name('ExtTextOutA'),proc
    DeleteObject(HGDIOBJ hgdiobj),bool,pascal,proc
    SelectObject(HDC hdc, HGDIOBJ hgdiobj),HGDIOBJ,pascal,proc
    CreateCompatibleDC(HDC hdc),HDC,pascal

    LoadBitmap(HINSTANCE hInst, long lpBitmapName),HBITMAP,pascal, |
               name('LoadBitmapA')
    LoadImage(HINSTANCE hinst, long lpszName, unsigned uType, signed cxDesired, |
              signed cyDesired, unsigned fuLoad),HANDLE,pascal,raw,name('LoadImageA')
    CreateBitmap(long nWidth, long nHeight, long cPlanes, long cBitsPerPel, long lpvBits),long,pascal
    CreateCompatibleBitmap(HDC hdc, signed nWiidth, signed nHeight),HBITMAP,pascal
    CreateDIBitmap(HDC hdc, *BITMAPINFOHEADER bmih, long fdwInit, long lpbInit, *BITMAPINFO bmi, long fuUsage),HBITMAP,raw,pascal
    GetBitmapDimensionEx(HBITMAP hBitmap, *SIZE lpDimension),bool,raw,pascal
    BitBlt(HDC hdcDest, signed nXDest, signed nYDest, signed nWidth, signed |
           nHeight, HDC hdcSrc, signed nXSrc, signed nYSrc, long dwRop),bool,pascal,proc
    GetDIBits(HDC hdc, HBITMAP hbmp, unsigned uStartScan, unsigned cScanLines, |
              long lpvBits, *BITMAPINFO lpbi, unsigned uUsage),signed,raw,pascal,proc
    GetBitmapBits(HBITMAP hbmp, long cbBuffer, long lpvBits),long,pascal,proc
 
    DeleteDC(HDC hdc),bool,pascal,proc
    ReleaseDC(HWND hwnd, HDC hdc),bool,pascal,proc
    CreateDC(*CString lpszDriver, <*CString lpszDevice>, <*CString lpszOutput>, |
             <long lpInitData>),HDC,raw,pascal,name('CreateDCA')
    GetDC(HWND hwnd),HDC,pascal
    GetObject(HGDIOBJ hgdiobj, signed cbBuffer, long lpVoid),signed,pascal,name('GetObjectA')
    CreatePolygonRgn(long lppt, unsigned cPoints, signed fnPolyFillMode),HRGN,pascal
    CreateRectRgn(signed nLeftRect, signed nTopRect, signed nRightRect, |
                  signed nBottomRect),HRGN,pascal
    PtInRegion(HRGN hrgn, signed x, signed y),bool,pascal
    PtInRect(*_RECT_, POINT),bool,raw,pascal
    GetRegionData(HRGN hrgn, long dwCount, long lpRgnData),long,pascal
    IntersectClipRect(HDC hdc, long nLeftRect, long nTopRect, long nRightRect, long nBottomRect),long,pascal,proc
    ExcludeClipRect(HDC hdc, long nLeftRect, long nTopRect, long nRightRect, long nBottomRect),long,pascal,proc
    SelectClipRgn(HDC DC, HRGN hRgn),long,pascal,proc
    DrawFocusRect(HDC hdc, *_RECT_ lprc),bool,raw,pascal
    DrawFrameControl(HDC hdc, *_RECT_ lprc, unsigned uType, unsigned uState),bool,raw,pascal
    InvalidateRect(HWND hwnd, *_RECT_ lpRect, bool bErase),bool,raw,pascal,proc
    ValidateRect(HWND hwnd, *_RECT_ lpRect),bool,raw,pascal,proc
    GetParent(HWND hwnd),HWND,pascal
    SetParent(HWND hWndChild, HWND hWndNewParent),long,pascal,proc
    FillRect(HDC hdc, *_RECT_ lprc, HBRUSH hbr),bool,raw,pascal
    CreateSolidBrush(COLORREF crColor),HBRUSH,pascal
    CreateHatchBrush(signed fnStyle, COLORREF clrref),HBRUSH,pascal
    GetSysColor(signed nIndex),long,pascal
    MoveToEx(HDC hdc, signed x, signed y, *POINT lpPoint),bool,raw,pascal,proc
    LineTo(HDC hdc, signed x, signed y),bool,pascal,proc
    SetCapture(HWND hwnd),HWND,pascal
    ReleaseCapture(),bool,pascal,proc
    GetCapture(),HWND,pascal
    IsWindow(HWND hwnd),bool,pascal
    AdjustWindowRectEx(*_RECT_ lpRect, long dwStyle, bool bMenu, long dwExStyle),bool,raw,pascal
    AdjustWindowRect(*_RECT_ lpRect, long dwStyle, bool bMenu),bool,raw,pascal,proc
    GetSysColorBrush(unsigned nIndex),HBRUSH,pascal,name('GetSysColorBrush')
    CreatePen(signed fnPenStyle, signed nWidth, COLORREF crColor),HPEN,pascal,name('CreatePen')
    GetSystemMetrics(signed nIndex),signed,pascal

    EnumResNameProc(HINSTANCE hInst, long lpszType, long lpszName, |
                    long lParam),bool,pascal,type
    EnumResTypeProc(HINSTANCE hInst, long lpszType, long lParam),bool,pascal,type
    EnumResourceNames(HINSTANCE hModule, long lpszType, EnumResNameProc |
                      lpEnumProc, long lParam),bool,pascal,name('EnumResourceNamesA')
    EnumResourceTypes(HINSTANCE hModule, EnumResTypeProc lpEnumProc, long |
                      lParam),bool,pascal,name('EnumResourceTypesA')

    LoadLibrary(*CString lpLibFileName),HINSTANCE,pascal,raw,name('LoadLibraryA')
    FreeLibrary(long hModule),bool,pascal,proc
    GetProcAddress(long hModule, *CString lpszProcName), long,pascal,raw,name('GetProcAddress')
    GetModuleHandle(*CString lpModuleName),HMODULE,pascal,raw,name('GetModuleHandleA')
    LoadLibraryEx32W(*CString lpszLibFile, long hFile, long dwFlags),long,raw,pascal
    FreeLibrary32W(long hInst),bool,pascal
    GetProcAddress32W(long hInst, *CString lpszProc),long,raw,pascal

    SetScrollInfo(HWND hwnd, signed fnBar, *SCROLLINFO lpsi, bool fRedraw),signed,raw,pascal,proc
    GetScrollInfo(HWND hwnd, signed fnBar, *SCROLLINFO lpsi),bool,raw,pascal
    SetScrollRange(HWND hWnd, signed nBar, signed nMinPos, signed nMaxPos, bool bRedraw),bool,pascal,proc
    ShowScrollBar(HWND hwnd, signed wBar, bool bShow),bool,pascal,proc
    ScrollWindowEx(HWND hWnd, signed dx, signed dy, <*_RECT_ rcScroll>, *_RECT_ rcClip, HRGN hrgnUpdate, <*_RECT_ rcUpdate>, unsigned flags),signed,raw,pascal,proc
    SetFocus(HWND hwnd),HWND,pascal,proc
    GetFocus(),HWND,pascal,proc
    GetLastError(),long,pascal

    CreateFile(*cstring szFileName, long dwDesiredAccess, long dwShareMode, long lpSecurityAttributes, |
               long dwCreationDisposition, long dwFlagsAndAttributes, HANDLE hTemplateFile),HANDLE, |
               name('CreateFileA'),pascal,raw
    DeleteFile(*cstring szFileName),bool,name('DeleteFileA'),raw,pascal
    ReplaceFile(*cstring szFileName, *cstring szReplacementFileName, long lpBackupFileName, long dwReplaceFlags, |
                long lpExclude = 0, long lpReserved = 0),bool,raw,pascal,name('ReplaceFileA')
    CopyFile(*cstring szFileName, *cstring szNewFileName, bool bFailIfExists),bool,raw,pascal,name('CopyFileA')
    SetFilePointer(HANDLE hFile, long lDistanceToMove, *long lDistanceToMoveHigh, long dwMoveMethod),long,raw,pascal,proc
    SetEndOfFile(HANDLE hFile),bool,pascal,proc
    ReadFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesRead, long lpOverlapped),bool,raw,pascal
    WriteFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesWritten, long lpOverlapped),bool,raw,pascal,proc
    GetFileSize(HANDLE hFile, *long FileSizeHigh),long,raw,pascal

    GetWindowsDirectory(*CString lpBuffer, unsigned uSize),unsigned,pascal,raw,proc,name('GetWindowsDirectoryA')
    GetCurrentDirectory(long nBufferLength, *CString lpBuffer),long,raw,pascal,proc,name('GetCurrentDirectoryA')
    GetModuleFileName(HMODULE hModule, *CString lpFilename, long nSize),long,pascal,raw,proc,name('GetModuleFileNameA')

    GetCurrentProcessID(),long,pascal,name('GetCurrentProcessId')
    GetCurrentThreadID(),long,pascal,name('GetCurrentThreadId')

    TimerProc(HWND hwnd, unsigned uMsg, unsigned idEvent, long dwTime),pascal,type
    SetTimer(HWND hWnd, unsigned nIDEvent, unsigned uElapse, long lpTimerFunc),unsigned,pascal,proc
    KillTimer(HWND hWnd, unsigned uIDEvent),bool,pascal,proc

    InitializeCriticalSection(CRITICAL_SECTION CriticalSection),raw,pascal
    EnterCriticalSection(CRITICAL_SECTION CriticalSection),raw,pascal
    LeaveCriticalSection(CRITICAL_SECTION CriticalSection),raw,pascal
    DeleteCriticalSection(CRITICAL_SECTION CriticalSection),raw,pascal

    GlobalAlloc(long uFlags, long dwBytes),long,pascal
    GlobalFree(HGLOBAL hMem),HGLOBAL,pascal,proc
    GlobalLock(HGLOBAL hMem),long,pascal,proc
    GlobalUnlock(HGLOBAL hMem),bool,pascal,proc
    VirtualAlloc(long lpAddress, long dwSize, long flAllocationType, long flProtect),long,pascal
    HeapAlloc(long hHeap, long dwFlags, long dwBytes),long,pascal
    VirtualFree(long lpAddress, long dwSize, long dwFreeType),bool,pascal
    HeapFree(long hHeap, long dwFlags, long lpMem),bool,pascal
    GetProcessHeap(),long,pascal

    CloseHandle(HANDLE),bool,raw,pascal,proc

    IsBadReadPtr(long SourcePtr,long dwLength),bool,raw,pascal
    IsBadWritePtr(long DestinationPtr,long dwLength),bool,raw,pascal

    MoveMemory(long DestinationPtr,long SourcePtr,long dwLength),bool,raw,proc,pascal,name('RtlMoveMemory')
    FillMemory(long DestinationPtr,long dwLength, long Value),pascal,name('RtlFillMemory')
    ZeroMemory(long DestinationPtr,long dwLength),raw,pascal,name('RtlZeroMemory')

    lstrcpy(long DestinationPtr, long SourcePtr),long,pascal
    lstrcat(long DestinationPtr, long SourcePtr),long,pascal
    lstrcmp(long DestinationPtr, long SourcePtr),long,pascal
    lstrlen(long SourcePtr),long,pascal
    lstrlenW(long lpWString),signed,proc,pascal

    wsprintf(long lpBuffer, long lpFormat, long Value),long,C,raw,name('wsprintfA')

    GetTickCount(),long,pascal

    GetMenu(HWND hWnd),HMENU,pascal
    GetSubMenu(HMENU hMenu, long nPos),HMENU,pascal
    GetMenuItemCount(HMENU hMenu),long,pascal
    GetMenuItemID(HMENU hMenu, long nPos),long,pascal
    GetMenuItemInfo(HMENU hMenu, long uItem, bool fByPosition, *MENUITEMINFO mii),bool,raw,pascal,name('GetMenuItemInfoA')
    SetMenuItemInfo(HMENU hMenu, long uItem, bool fByPosition, *MENUITEMINFO mii),bool,raw,pascal,name('SetMenuItemInfoA')

    BringWindowToTop(HWND hWnd),short,proc,pascal
    FindWindow(<*cstring lpszClassName>, <*cstring lpszWindowName>),HWND,raw,pascal,name('FindWindowA')
    GetForegroundWindow(),hwnd,pascal
    GetGUIThreadInfo(long idThread, *GUITHREADINFO lpgui),bool,raw,pascal
    WindowFromPoint(real PtByValue),HWND,pascal

    InterlockedIncrement(*long Var),long,pascal,proc
    InterlockedDecrement(*long Var),long,pascal,proc

    CoInitialize(long = 0),HRESULT,pascal
    CoUninitialize(),pascal
    OleInitialize(long pvReserved),long,pascal
    OleUninitialize(),pascal
    CoGetClassObject(REFCLSID rclsid, long dwClsContext, long pvReserved, |
                     REFIID riid, *long ppvObject),long,raw,pascal
    CoCreateInstance(REFCLSID rclsid, long pUnkOuter, long dwClsContext, |
                     REFIID riid, *long ppvObject),long,raw,pascal
    CoLockObjectExternal(long pUnk, bool fLock, bool fLastUnlockReleases),HRESULT,pascal
    RegisterDragDrop(HWND hwnd, long pDropTarget),long,pascal
    RevokeDragDrop(HWND hwnd),long,pascal
    DoDragDrop(long pDataObj, long pDropSource, long dwOKEffects, *long dwEffect),long,pascal
    GetRunningObjectTable(long reserved, long ppRot),HRESULT,pascal
    OleRun(long pIUnk),HRESULT,pascal
    GetActiveObject(REFCLSID rclsid, long pvReserved, *long pUnk),HRESULT,pascal

    WaitForSingleObject(HANDLE hHandle, long dwMilliSeconds),long,pascal
    MsgWaitForMultipleObjects(long nCount, long pHandles, bool bWaitAll, long dwMilliseconds, |
                              long dwWakeMask),long,pascal
    ResetEvent(HANDLE hEvent),bool,pascal,proc
    TranslateMessage(long lpMsg),long,pascal,proc,name('TranslateMessage')
    DispatchMessage(long lpMsg),long,pascal,proc,name('DispatchMessageA')
    WaitMessage(),bool,pascal
    GetMessage(long lpMsg, HWND hWnd, long wMsgFilterMin, long wMsgFilterMax),bool,pascal,name('GetMessageA')

    MultiByteToWideChar(long CodePage, long dwFlags, long lpMultiByteStr, long cbMultiByte, |
                        long lpWideCharStr, long cchWideCharStr),long,pascal
    WideCharToMultiByte(long CodePage, long dwFlags, long lpWideCharStr, long cchWideChar, |
                        long lpMultiByteStr, long cbMultiByte, long lpDefaultChar, |
                        long lpUsedDefaultChar),long,pascal
!WINOLEAUTAPI VarI4FromDate(DATE dateIn, LONG * plOut);
    VarI4FromDate(REAL dateIn, *LONG plOut),long,pascal
    VarBstrFromDate(REAL dateIn, LONG lcid, ULONG dwFlags, *LONG pbstrOut),long,pascal
    VarBstrFromDate(REAL dateIn, LONG lcid, ULONG dwFlags, *bstring pbstrOut),long,pascal
    VarDecFromR8(REAL dblIn, *DECIMAL pdecOut),long,pascal
    GetSystemTime(*_SYSTEMTIME),raw,pascal
    GetSystemTimeAsFileTime(*_FILETIME SystemTimeAsFileTime),raw,pascal

    GetThreadLocale(),long,pascal

  compile('Temp', _Temp_)

/*---------------------------------------------------------------------*/
/*                Vector <-> Bstr conversion APIs                      */
/*---------------------------------------------------------------------*/

WINOLEAUTAPI VectorFromBstr (BSTR bstr, SAFEARRAY ** ppsa);
WINOLEAUTAPI BstrFromVector (tSAFEARRAY *psa, BSTR *pbstr);


/*---------------------------------------------------------------------*/
/*                     VARTYPE Coercion API                            */
/*---------------------------------------------------------------------*/

/* Note: The routines that convert *from* a string are defined
 * to take a OLECHAR* rather than a BSTR because no allocation is
 * required, and this makes the routines a bit more generic.
 * They may of course still be passed a BSTR as the strIn param.
 */

/* Any of the coersion functions that converts either from or to a string
 * takes an additional lcid and dwFlags arguments. The lcid argument allows
 * locale specific parsing to occur.  The dwFlags allow additional function
 * specific condition to occur.  All function that accept the dwFlags argument
 * can include either 0 or LOCALE_NOUSEROVERRIDE flag. In addition, the
 * VarDateFromStr and VarBstrFromDate functions also accept the
 * VAR_TIMEVALUEONLY and VAR_DATEVALUEONLY flags
 */

#define VAR_TIMEVALUEONLY   ((DWORD)0x00000001)    /* return time value */
#define VAR_DATEVALUEONLY   ((DWORD)0x00000002)    /* return date value */

/* Booleans can optionally be accepted in localized form. Pass VAR_LOCALBOOL
 * into VarBoolFromStr and VarBstrFromBool to use localized boolean names
 */
#define VAR_LOCALBOOL       ((DWORD)0x00000010)

WINOLEAUTAPI VarUI1FromI2(SHORT sIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromI4(LONG lIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromR4(FLOAT fltIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromR8(DOUBLE dblIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromCy(CY cyIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromDate(DATE dateIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromDisp(IDispatch * pdispIn, LCID lcid, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromBool(VARIANT_BOOL boolIn, BYTE * pbOut);
WINOLEAUTAPI VarUI1FromI1(CHAR cIn, BYTE *pbOut);
WINOLEAUTAPI VarUI1FromUI2(USHORT uiIn, BYTE *pbOut);
WINOLEAUTAPI VarUI1FromUI4(ULONG ulIn, BYTE *pbOut);
WINOLEAUTAPI VarUI1FromDec(DECIMAL *pdecIn, BYTE *pbOut);

WINOLEAUTAPI VarI2FromUI1(BYTE bIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromI4(LONG lIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromR4(FLOAT fltIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromR8(DOUBLE dblIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromCy(CY cyIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromDate(DATE dateIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, SHORT * psOut);
WINOLEAUTAPI VarI2FromDisp(IDispatch * pdispIn, LCID lcid, SHORT * psOut);
WINOLEAUTAPI VarI2FromBool(VARIANT_BOOL boolIn, SHORT * psOut);
WINOLEAUTAPI VarI2FromI1(CHAR cIn, SHORT *psOut);
WINOLEAUTAPI VarI2FromUI2(USHORT uiIn, SHORT *psOut);
WINOLEAUTAPI VarI2FromUI4(ULONG ulIn, SHORT *psOut);
WINOLEAUTAPI VarI2FromDec(DECIMAL *pdecIn, SHORT *psOut);

WINOLEAUTAPI VarI4FromUI1(BYTE bIn, LONG * plOut);
WINOLEAUTAPI VarI4FromI2(SHORT sIn, LONG * plOut);
WINOLEAUTAPI VarI4FromR4(FLOAT fltIn, LONG * plOut);
WINOLEAUTAPI VarI4FromR8(DOUBLE dblIn, LONG * plOut);
WINOLEAUTAPI VarI4FromCy(CY cyIn, LONG * plOut);
WINOLEAUTAPI VarI4FromDate(DATE dateIn, LONG * plOut);
WINOLEAUTAPI VarI4FromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, LONG * plOut);
WINOLEAUTAPI VarI4FromDisp(IDispatch * pdispIn, LCID lcid, LONG * plOut);
WINOLEAUTAPI VarI4FromBool(VARIANT_BOOL boolIn, LONG * plOut);
WINOLEAUTAPI VarI4FromI1(CHAR cIn, LONG *plOut);
WINOLEAUTAPI VarI4FromUI2(USHORT uiIn, LONG *plOut);
WINOLEAUTAPI VarI4FromUI4(ULONG ulIn, LONG *plOut);
WINOLEAUTAPI VarI4FromDec(DECIMAL *pdecIn, LONG *plOut);
WINOLEAUTAPI VarI4FromInt(INT intIn, LONG *plOut);

WINOLEAUTAPI VarR4FromUI1(BYTE bIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromI2(SHORT sIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromI4(LONG lIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromR8(DOUBLE dblIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromCy(CY cyIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromDate(DATE dateIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, FLOAT *pfltOut);
WINOLEAUTAPI VarR4FromDisp(IDispatch * pdispIn, LCID lcid, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromBool(VARIANT_BOOL boolIn, FLOAT * pfltOut);
WINOLEAUTAPI VarR4FromI1(CHAR cIn, FLOAT *pfltOut);
WINOLEAUTAPI VarR4FromUI2(USHORT uiIn, FLOAT *pfltOut);
WINOLEAUTAPI VarR4FromUI4(ULONG ulIn, FLOAT *pfltOut);
WINOLEAUTAPI VarR4FromDec(DECIMAL *pdecIn, FLOAT *pfltOut);

WINOLEAUTAPI VarR8FromUI1(BYTE bIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromI2(SHORT sIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromI4(LONG lIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromR4(FLOAT fltIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromCy(CY cyIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromDate(DATE dateIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, DOUBLE *pdblOut);
WINOLEAUTAPI VarR8FromDisp(IDispatch * pdispIn, LCID lcid, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromBool(VARIANT_BOOL boolIn, DOUBLE * pdblOut);
WINOLEAUTAPI VarR8FromI1(CHAR cIn, DOUBLE *pdblOut);
WINOLEAUTAPI VarR8FromUI2(USHORT uiIn, DOUBLE *pdblOut);
WINOLEAUTAPI VarR8FromUI4(ULONG ulIn, DOUBLE *pdblOut);
WINOLEAUTAPI VarR8FromDec(DECIMAL *pdecIn, DOUBLE *pdblOut);

WINOLEAUTAPI VarDateFromUI1(BYTE bIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromI2(SHORT sIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromI4(LONG lIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromR4(FLOAT fltIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromR8(DOUBLE dblIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromCy(CY cyIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, DATE *pdateOut);
WINOLEAUTAPI VarDateFromDisp(IDispatch * pdispIn, LCID lcid, DATE * pdateOut);
WINOLEAUTAPI VarDateFromBool(VARIANT_BOOL boolIn, DATE * pdateOut);
WINOLEAUTAPI VarDateFromI1(CHAR cIn, DATE *pdateOut);
WINOLEAUTAPI VarDateFromUI2(USHORT uiIn, DATE *pdateOut);
WINOLEAUTAPI VarDateFromUI4(ULONG ulIn, DATE *pdateOut);
WINOLEAUTAPI VarDateFromDec(DECIMAL *pdecIn, DATE *pdateOut);

WINOLEAUTAPI VarCyFromUI1(BYTE bIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromI2(SHORT sIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromI4(LONG lIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromR4(FLOAT fltIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromR8(DOUBLE dblIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromDate(DATE dateIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, CY * pcyOut);
WINOLEAUTAPI VarCyFromDisp(IDispatch * pdispIn, LCID lcid, CY * pcyOut);
WINOLEAUTAPI VarCyFromBool(VARIANT_BOOL boolIn, CY * pcyOut);
WINOLEAUTAPI VarCyFromI1(CHAR cIn, CY *pcyOut);
WINOLEAUTAPI VarCyFromUI2(USHORT uiIn, CY *pcyOut);
WINOLEAUTAPI VarCyFromUI4(ULONG ulIn, CY *pcyOut);
WINOLEAUTAPI VarCyFromDec(DECIMAL *pdecIn, CY *pcyOut);

WINOLEAUTAPI VarBstrFromUI1(BYTE bVal, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromI2(SHORT iVal, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromI4(LONG lIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromR4(FLOAT fltIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromR8(DOUBLE dblIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromCy(CY cyIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromDate(DATE dateIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromDisp(IDispatch * pdispIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromBool(VARIANT_BOOL boolIn, LCID lcid, ULONG dwFlags, BSTR * pbstrOut);
WINOLEAUTAPI VarBstrFromI1(CHAR cIn, LCID lcid, ULONG dwFlags, BSTR *pbstrOut);
WINOLEAUTAPI VarBstrFromUI2(USHORT uiIn, LCID lcid, ULONG dwFlags, BSTR *pbstrOut);
WINOLEAUTAPI VarBstrFromUI4(ULONG ulIn, LCID lcid, ULONG dwFlags, BSTR *pbstrOut);
WINOLEAUTAPI VarBstrFromDec(DECIMAL *pdecIn, LCID lcid, ULONG dwFlags, BSTR *pbstrOut);

WINOLEAUTAPI VarBoolFromUI1(BYTE bIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromI2(SHORT sIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromI4(LONG lIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromR4(FLOAT fltIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromR8(DOUBLE dblIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromDate(DATE dateIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromCy(CY cyIn, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromDisp(IDispatch * pdispIn, LCID lcid, VARIANT_BOOL * pboolOut);
WINOLEAUTAPI VarBoolFromI1(CHAR cIn, VARIANT_BOOL *pboolOut);
WINOLEAUTAPI VarBoolFromUI2(USHORT uiIn, VARIANT_BOOL *pboolOut);
WINOLEAUTAPI VarBoolFromUI4(ULONG ulIn, VARIANT_BOOL *pboolOut);
WINOLEAUTAPI VarBoolFromDec(DECIMAL *pdecIn, VARIANT_BOOL *pboolOut);

WINOLEAUTAPI VarI1FromUI1(BYTE bIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromI2(SHORT uiIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromI4(LONG lIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromR4(FLOAT fltIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromR8(DOUBLE dblIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromDate(DATE dateIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromCy(CY cyIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, CHAR *pcOut);
WINOLEAUTAPI VarI1FromDisp(IDispatch *pdispIn, LCID lcid, CHAR *pcOut);
WINOLEAUTAPI VarI1FromBool(VARIANT_BOOL boolIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromUI2(USHORT uiIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromUI4(ULONG ulIn, CHAR *pcOut);
WINOLEAUTAPI VarI1FromDec(DECIMAL *pdecIn, CHAR *pcOut);

WINOLEAUTAPI VarUI2FromUI1(BYTE bIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromI2(SHORT uiIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromI4(LONG lIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromR4(FLOAT fltIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromR8(DOUBLE dblIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromDate(DATE dateIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromCy(CY cyIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromDisp(IDispatch *pdispIn, LCID lcid, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromBool(VARIANT_BOOL boolIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromI1(CHAR cIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromUI4(ULONG ulIn, USHORT *puiOut);
WINOLEAUTAPI VarUI2FromDec(DECIMAL *pdecIn, USHORT *puiOut);

WINOLEAUTAPI VarUI4FromUI1(BYTE bIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromI2(SHORT uiIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromI4(LONG lIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromR4(FLOAT fltIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromR8(DOUBLE dblIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromDate(DATE dateIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromCy(CY cyIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromDisp(IDispatch *pdispIn, LCID lcid, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromBool(VARIANT_BOOL boolIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromI1(CHAR cIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromUI2(USHORT uiIn, ULONG *pulOut);
WINOLEAUTAPI VarUI4FromDec(DECIMAL *pdecIn, ULONG *pulOut);

WINOLEAUTAPI VarDecFromUI1(BYTE bIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromI2(SHORT uiIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromI4(LONG lIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromR4(FLOAT fltIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromR8(DOUBLE dblIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromDate(DATE dateIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromCy(CY cyIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromStr(OLECHAR *strIn, LCID lcid, ULONG dwFlags, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromDisp(IDispatch *pdispIn, LCID lcid, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromBool(VARIANT_BOOL boolIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromI1(CHAR cIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromUI2(USHORT uiIn, DECIMAL *pdecOut);
WINOLEAUTAPI VarDecFromUI4(ULONG ulIn, DECIMAL *pdecOut);

#define VarUI4FromUI4(in, pOut) (*(pOut) = (in))
#define VarI4FromI4(in, pOut)   (*(pOut) = (in))

#define VarUI1FromInt       VarUI1FromI4
#define VarUI1FromUint      VarUI1FromUI4
#define VarI2FromInt        VarI2FromI4
#define VarI2FromUint       VarI2FromUI4
#define VarI4FromInt        VarI4FromI4
#define VarI4FromUint       VarI4FromUI4
#define VarR4FromInt        VarR4FromI4
#define VarR4FromUint       VarR4FromUI4
#define VarR8FromInt        VarR8FromI4
#define VarR8FromUint       VarR8FromUI4
#define VarDateFromInt      VarDateFromI4
#define VarDateFromUint     VarDateFromUI4
#define VarCyFromInt        VarCyFromI4
#define VarCyFromUint       VarCyFromUI4
#define VarBstrFromInt      VarBstrFromI4
#define VarBstrFromUint     VarBstrFromUI4
#define VarBoolFromInt      VarBoolFromI4
#define VarBoolFromUint     VarBoolFromUI4
#define VarI1FromInt        VarI1FromI4
#define VarI1FromUint       VarI1FromUI4
#define VarUI2FromInt       VarUI2FromI4
#define VarUI2FromUint      VarUI2FromUI4
#define VarUI4FromInt       VarUI4FromI4
#define VarUI4FromUint      VarUI4FromUI4
#define VarDecFromInt       VarDecFromI4
#define VarDecFromUint      VarDecFromUI4
#define VarIntFromUI1       VarI4FromUI1
#define VarIntFromI2        VarI4FromI2
#define VarIntFromI4        VarI4FromI4
#define VarIntFromR4        VarI4FromR4
#define VarIntFromR8        VarI4FromR8
#define VarIntFromDate      VarI4FromDate
#define VarIntFromCy        VarI4FromCy
#define VarIntFromStr       VarI4FromStr
#define VarIntFromDisp      VarI4FromDisp
#define VarIntFromBool      VarI4FromBool
#define VarIntFromI1        VarI4FromI1
#define VarIntFromUI2       VarI4FromUI2
#define VarIntFromUI4       VarI4FromUI4
#define VarIntFromDec       VarI4FromDec
#define VarIntFromUint      VarI4FromUI4
#define VarUintFromUI1      VarUI4FromUI1
#define VarUintFromI2       VarUI4FromI2
#define VarUintFromI4       VarUI4FromI4
#define VarUintFromR4       VarUI4FromR4
#define VarUintFromR8       VarUI4FromR8
#define VarUintFromDate     VarUI4FromDate
#define VarUintFromCy       VarUI4FromCy
#define VarUintFromStr      VarUI4FromStr
#define VarUintFromDisp     VarUI4FromDisp
#define VarUintFromBool     VarUI4FromBool
#define VarUintFromI1       VarUI4FromI1
#define VarUintFromUI2      VarUI4FromUI2
#define VarUintFromUI4      VarUI4FromUI4
#define VarUintFromDec      VarUI4FromDec
#define VarUintFromInt      VarUI4FromI4

/* Mac Note: On the Mac, the coersion functions support the
 * Symantec C++ calling convention for float/double. To support
 * float/double arguments compiled with the MPW C compiler,
 * use the following APIs to move MPW float/double values into
 * a VARIANT.
 */

/*---------------------------------------------------------------------*/
/*            New VARIANT <-> string parsing functions                 */
/*---------------------------------------------------------------------*/

typedef struct {
    INT   cDig;
    ULONG dwInFlags;
    ULONG dwOutFlags;
    INT   cchUsed;
    INT   nBaseShift;
    INT   nPwr10;
} NUMPARSE;

/* flags used by both dwInFlags and dwOutFlags:
 */
#define NUMPRS_LEADING_WHITE    0x0001
#define NUMPRS_TRAILING_WHITE   0x0002
#define NUMPRS_LEADING_PLUS     0x0004
#define NUMPRS_TRAILING_PLUS    0x0008
#define NUMPRS_LEADING_MINUS    0x0010
#define NUMPRS_TRAILING_MINUS   0x0020
#define NUMPRS_HEX_OCT          0x0040
#define NUMPRS_PARENS           0x0080
#define NUMPRS_DECIMAL          0x0100
#define NUMPRS_THOUSANDS        0x0200
#define NUMPRS_CURRENCY         0x0400
#define NUMPRS_EXPONENT         0x0800
#define NUMPRS_USE_ALL          0x1000
#define NUMPRS_STD              0x1FFF

/* flags used by dwOutFlags only:
 */
#define NUMPRS_NEG              0x10000
#define NUMPRS_INEXACT          0x20000

/* flags used by VarNumFromParseNum to indicate acceptable result types:
 */
#define VTBIT_I1        (1 << VT_I1)
#define VTBIT_UI1       (1 << VT_UI1)
#define VTBIT_I2        (1 << VT_I2)
#define VTBIT_UI2       (1 << VT_UI2)
#define VTBIT_I4        (1 << VT_I4)
#define VTBIT_UI4       (1 << VT_UI4)
#define VTBIT_R4        (1 << VT_R4)
#define VTBIT_R8        (1 << VT_R8)
#define VTBIT_CY        (1 << VT_CY)
#define VTBIT_DECIMAL   (1 << VT_DECIMAL)


WINOLEAUTAPI VarParseNumFromStr(OLECHAR * strIn, LCID lcid, ULONG dwFlags,
            NUMPARSE * pnumprs, BYTE * rgbDig);

WINOLEAUTAPI VarNumFromParseNum(NUMPARSE * pnumprs, BYTE * rgbDig,
            ULONG dwVtBits, VARIANT * pvar);

/*---------------------------------------------------------------------*/
/*                     VARTYPE Math API                                */
/*---------------------------------------------------------------------*/

STDAPI VarAdd(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarAnd(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarCat(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarDiv(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarEqv(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarIdiv(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarImp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarMod(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarMul(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarOr(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarPow(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarSub(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);
STDAPI VarXor(LPVARIANT pvarLeft, LPVARIANT pvarRight, LPVARIANT pvarResult);

STDAPI VarAbs(LPVARIANT pvarIn, LPVARIANT pvarResult);
STDAPI VarFix(LPVARIANT pvarIn, LPVARIANT pvarResult);
STDAPI VarInt(LPVARIANT pvarIn, LPVARIANT pvarResult);
STDAPI VarNeg(LPVARIANT pvarIn, LPVARIANT pvarResult);
STDAPI VarNot(LPVARIANT pvarIn, LPVARIANT pvarResult);

STDAPI VarRound(LPVARIANT pvarIn, int cDecimals, LPVARIANT pvarResult);

STDAPI VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid);

  Temp

    CreateEvent(long lpSecurityAttributes, bool bManualReset, bool bInitialState, long lpName),long,pascal,name('CreateEventA')
    SetEvent(HANDLE hEvent),bool,pascal,proc
    CreateThread(long lpSecurityAttributes, long Stacksize, long lpFunction, long lpParameter, |
                 long CreationFlags, *long ThreadID),long,raw,pascal
    TerminateThread(long hThread, long dwExitCode),bool,pascal,proc
    PostQuitMessage(long nExitCode),pascal

! Clipboard Manager Functions

    OpenClipboard(long hWndNewOwner),byte,pascal
    CloseClipboard(),byte,pascal
    GetClipboardSequenceNumber(),long,pascal
    GetClipboardOwner(),long,pascal
    SetClipboardViewer(long hWndNewViewer),long,pascal
    GetClipboardViewer(),long,pascal
    ChangeClipboardChain(long hWndRemove, long hWndNewNext),byte,pascal
    SetClipboardData(long uFormat, long hMem),long,pascal
    GetClipboardData(long uFormat),long,pascal
    CountClipboardFormats(),long,pascal
    EnumClipboardFormats(long lformat),long,pascal
  omit('EndAnsi', _Unicode_)
    RegisterClipboardFormat(long lpszFormat),long,pascal,name('RegisterClipboardFormatA')
    GetClipboardFormatName(long lformat, long lpszFormatName, long cchMaxCount),long,pascal,name('GetClipboardFormatNameA')
  EndAnsi
  compile('EndUnicode', _Unicode_)
    RegisterClipboardFormat(long lpszFormat),long,pascal,name('RegisterClipboardFormatW')
    GetClipboardFormatName(long lformat, long lpszFormatName, long cchMaxCount),long,pascal,name('GetClipboardFormatNameW')
  EndUnicode
    EmptyClipboard(),byte,pascal
    IsClipboardFormatAvailable(long lformat),byte,pascal
    GetPriorityClipboardFormat(*long aFormatPriorityList, long cFormats),long,pascal
    GetOpenClipboardWindow(),long,pascal

! Registry Functions

  omit('EndAnsi', _Unicode_)
    RegOpenKey(long hKey, long pszSubKey, *long phkResult),long,pascal,name('RegOpenKeyA')
    RegQueryValue(long hKey, long pszSubKey, long pszValue, *long cbValue),long,pascal,name('RegQueryValueA')
    RegQueryValueEx(long hKey, long pszValueName, long lpReserved, *long dwType, long lpData, *long cbData),long,pascal,name('RegQueryValueExA')
  EndAnsi
  compile('EndUnicode', _Unicode_)
    RegOpenKey(long hKey, long pwszSubKey, *long phkResult),long,pascal,name('RegOpenKeyW')
    RegQueryValue(long hKey, long pwszSubKey, long pwszValue, *long cbValue),long,pascal,name('RegQueryValueW')
    RegQueryValueEx(long hKey, long pwszValueName, long lpReserved, *long dwType, long lpData, *long cbData),long,pascal,name('RegQueryValueExW')
  EndUnicode
    RegCloseKey(long hKey),long,proc,pascal

  end

