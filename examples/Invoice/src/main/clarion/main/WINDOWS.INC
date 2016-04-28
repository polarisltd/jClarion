
  OMIT('EndDefine',_WINDOWS_)
_WINDOWS_  EQUATE(1)

HANDLE                  EQUATE(SIGNED)
HWND                    EQUATE(HANDLE)
HINSTANCE               EQUATE(HANDLE)
HMODULE                 EQUATE(HANDLE)
HMENU                   EQUATE(HANDLE)
HDC                     EQUATE(HANDLE)
HICON                   EQUATE(HANDLE)
HCURSOR                 EQUATE(HANDLE)
HBRUSH                  EQUATE(HANDLE)
HBITMAP                 EQUATE(HANDLE)
HGDIOBJ                 EQUATE(HANDLE)
HFONT                   EQUATE(HANDLE)
HRGN                    EQUATE(HANDLE)
HGLOBAL                 EQUATE(HANDLE)
HPEN                    EQUATE(HANDLE)
HRESULT                 EQUATE(LONG)
DWORD                   EQUATE(ULONG)
LPCSTR                  EQUATE(CSTRING)
LPSTR                   EQUATE(CSTRING)
LPVOID                  EQUATE(LONG)
LPCVOID                 EQUATE(LONG)
PLONG                   EQUATE(LONG)

PATINVERT               EQUATE(005A0049h)

SECURITY_ATTRIBUTES     GROUP,TYPE
nLength                   DWORD
lpSecurityDescriptor      LPVOID
bInheritHandle            BOOL
                        END

CRITICAL_SECTION        GROUP,TYPE
DebugInfo                 LONG       !Ptr to _RTL_CRITICAL_SECTION_DEBUG

    !
    !  The following three fields control entering and exiting the critical
    !  section for the resource
    !

LockCount                 LONG
RecursionCount            LONG
OwningThread              HANDLE        ! from the thread's ClientId->UniqueThread
LockSemaphore             HANDLE
Reserved                  LONG
                        END



  MAP
    MODULE('WinApi')
      OMIT('***',_WIDTH32_)
      GetPrivateProfileString(*LPCSTR,*LPCSTR,*LPCSTR, *LPCSTR, SIGNED,*LPCSTR),SIGNED,PASCAL,RAW
      LoadLibrary(*CSTRING szLibFileName),HINSTANCE,PASCAL,RAW
      SetWindowLong(HWND, SIGNED, LONG),LONG,PASCAL
      ShellExecute(HWND,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SIGNED),HINSTANCE,PASCAL,RAW,PROC,NAME('ShellExecute')
      ***

      COMPILE('***',_WIDTH32_)
      GetPrivateProfileString(*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,DWORD,*LPCSTR),DWORD,PASCAL,RAW,NAME('GetPrivateProfileStringA')
      LoadLibrary(*CSTRING szLibFileName),HINSTANCE,PASCAL,RAW,NAME('LoadLibraryA')
      SetWindowLong(HWND,SIGNED,LONG),LONG,PASCAL,NAME('SetWindowLongA')
      ShellExecute(HWND,*LPCSTR,*LPCSTR,*LPCSTR,*LPCSTR,SIGNED),HINSTANCE,PASCAL,RAW,PROC,NAME('ShellExecuteA')

      CreateSemaphore(<*SECURITY_ATTRIBUTES lpSemaphoreAttributes>, LONG lInitialCount, LONG lMaximumCount, *CSTRING lpName), LONG, RAW, PASCAL, NAME('CreateSemaphoreA')
      FindWindow(<*CSTRING lpClassName>, *CSTRING lpWindowName),UNSIGNED,PASCAL,RAW,NAME('FindWindowA')
      ***

      CloseHandle(HANDLE hObject),BOOL,PASCAL,PROC
      FreeLibrary(LONG hModule),BOOL,PASCAL,PROC
      GetDC(HWND),HDC,PASCAL,PROC,NAME('GetDC')
      GetDeviceCaps(HDC, SIGNED),SIGNED,PASCAL,NAME('GetDeviceCaps')
      GetLastError(),LONG,PASCAL
      GetOpenFileName(long),pascal,bool,proc,name('GetOpenFileNameA')
      GetProcAddress(LONG hModule, *CSTRING szProcName),LONG,PASCAL,RAW,NAME('GetProcAddress')
      GetSaveFileName(Long),pascal,bool,proc,name('GetSaveFileNameA')
      GetSystemMetrics(SIGNED),SIGNED,PASCAL,NAME('GetSystemMetrics')
      IsIconic(UNSIGNED),BOOL,PASCAL
      PatBlt(HDC, SIGNED, SIGNED, SIGNED, SIGNED, DWORD),BOOL,PASCAL
      ReleaseDC(HWND, HDC),SIGNED,PASCAL,PROC,NAME('ReleaseDC')
      SetForegroundWindow(UNSIGNED),BOOL,PASCAL
      ShowWindow(UNSIGNED, SIGNED nCmdShow),BOOL,PASCAL
      WaitForSingleObject(HANDLE hHandle, LONG dwMilliseconds),LONG,PASCAL

    END
  END


!  EndDefine

