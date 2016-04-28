  omit('EndDefine',_COMDefinitions_)
_COMDefinitions_  equate(1)

!************************************************************************
!
!  Module:         svcomdef.inc
!
!
!************************************************************************/

!*
!* Includes
!*

  include('svapi.inc'),once

!OleAut  class,type,link('oleaut32.lib', _APILinkMode_).


!*
!* Defines
!*

!COM Support

BSTR                    equate(long)

_GUID                   group,type
Data1                     long
Data2                     short
Data3                     short
Data4                     byte,dim(8)
                        end

_GUIDL                  group,type
Data1                     long
Data2                     long
Data3                     long
Data4                     long
                        end

GUID                    group(_GUID),type.
_IID                    group(GUID),type.
_CLSID                  group(GUID),type.
REFCLSID                equate(long)                                !const CLSID &
REFIID                  equate(long)                                !const IID &

_COSERVERINFO           group,type
dwReserved1               long
pwszName                  long
pAuthInfo                 long
dwReserved2               long
                        end

COSERVERINFO            group(_COSERVERINFO),type.

COINIT                  itemize
COINIT_APARTMENTTHREADED  equate(02h)      ! Apartment model
COINIT_MULTITHREADED      equate(0h)       ! OLE calls objects on any thread.
COINIT_DISABLE_OLE1DDE    equate(04h)      ! Don't use DDE for Ole1 support.
COINIT_SPEED_OVER_MEMORY  equate(08h)      ! Trade memory for speed.
                        end

CLSCTX                  itemize
CLSCTX_INPROC_SERVER      equate(01h)
CLSCTX_INPROC_HANDLER     equate(02h)
CLSCTX_LOCAL_SERVER       equate(04h)
CLSCTX_INPROC_SERVER16    equate(08h)
CLSCTX_REMOTE_SERVER      equate(010h)
CLSCTX_INPROC_HANDLER16   equate(020h)
CLSCTX_INPROC_SERVERX86   equate(040h)
CLSCTX_INPROC_HANDLERX86  equate(080h)
CLSCTX_ESERVER_HANDLER    equate(0100h)
                        end

CLSCTX_INPROC           equate(CLSCTX_INPROC_SERVER + CLSCTX_INPROC_HANDLER)

! With DCOM, CLSCTX_REMOTE_SERVER should be included

CLSCTX_ALL_DCOM         equate(CLSCTX_INPROC_SERVER +   |
                               CLSCTX_INPROC_HANDLER +  |
                               CLSCTX_LOCAL_SERVER +    |
                               CLSCTX_REMOTE_SERVER)
CLSCTX_SERVER_DCOM      equate(CLSCTX_INPROC_SERVER +   |
                               CLSCTX_LOCAL_SERVER +    |
                               CLSCTX_REMOTE_SERVER)
CLSCTX_ALL              equate(CLSCTX_INPROC_SERVER +   |
                               CLSCTX_INPROC_HANDLER +  |
                               CLSCTX_LOCAL_SERVER)
CLSCTX_SERVER           equate(CLSCTX_INPROC_SERVER +   |
                               CLSCTX_LOCAL_SERVER)

IID_NULL                group
Data1                     long(0)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0><0><0><0><0><0><0><0>')
                        end

_IUnknown               group
Data1                     long(0)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end

IUnknown                Interface,com
QueryInterface            procedure(long riid, *long ppvObject),long
AddRef                    procedure,long
Release                   procedure,long,proc
                        end

_IClassFactory          group
Data1                     long(01h)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0c0h><0><0><0><0><0><0><046h>')
                        end

! Flags for IDispatch::Invoke

DISPATCH_METHOD         equate(01h)
DISPATCH_PROPERTYGET    equate(02h)
DISPATCH_PROPERTYPUT    equate(04h)
DISPATCH_PROPERTYPUTREF equate(08h)

_IDispatch              group
Data1                     long(020400h)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end

IDispatch               interface(IUnknown),com
GetTypeInfoCount          procedure(*long pctinfo),HRESULT
GetTypeInfo               procedure(long iTInfo, long lcid, long ppTInfo),HRESULT
GetIDsOfNames             procedure(long riid, long prgszNames, long cNames, long lcid, long prgDispId),HRESULT
Invoke                    procedure(long dispIdMember, long riid, long lcid, short wFlags, |
                                    long pDispParams, long pVarResult, long pExcepInfo, long puArgErr),HRESULT
                        end

_IConnectionPoint       group
Data1                     long(0B196B286h)
Data2                     short(0BAB4h)
Data3                     short(0101Ah)
Data4                     string('<0B6h><09Ch><0><0AAh><0><034h><01Dh><07h>')
                        end

IConnectionPoint        interface(IUnknown),com
GetConnectionInterface    procedure(*long IID),HRESULT
GetConnectionPointContainer procedure(*long pCPC),HRESULT
Advise                    procedure(long pUnkSink, *long dwCookie),HRESULT
Unadvise                  procedure(long dwCookie),HRESULT,proc
EnumConnections           procedure(*long ppEnum),HRESULT
                        end

_IConnectionPointContainer group
Data1                     long(0B196B284h)
Data2                     short(0BAB4h)
Data3                     short(0101Ah)
Data4                     string('<0B6h><09Ch><0><0AAh><0><034h><01Dh><07h>')
                        end

IConnectionPointContainer interface(IUnknown),com
EnumConnectionPoints      procedure(*long pEnum),HRESULT
FindConnectionPoint       procedure(long riid, *long pCP),HRESULT
                        end

_IDropTarget            group
Data1                     long(0122h)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end

IDropTarget             interface(IUnknown),com
DragEnter                 procedure(long pDataObj, long grfKeyState, long ppt, long pdwEffect),HRESULT
DragOver                  procedure(long grfKeyState, long ppt, long pdwEffect),HRESULT
DragLeave                 procedure,HRESULT
Drop                      procedure(long pDataObj, long grfKeyState, long ppt, long pdwEffect),HRESULT
                        end

_ISequentialStream      group
Data1                     long(0c733a30h)
Data2                     short(02a1ch)
Data3                     short(011ceh)
Data4                     string('<0adh><0e5h><0><0aah><0><044h><077h><03dh>')
                        end

ISequentialStream       interface(IUnknown),com
Read                      procedure(long pv, long cb, *long cbRead),HRESULT
Write                     procedure(long pv, long cb, *long cbWritten),HRESULT
                        end

STGTY                   itemize(1)
STGTY_STORAGE             equate
STGTY_STREAM              equate
STGTY_LOCKBYTES           equate
STGTY_PROPERTY            equate
                        end

! Storage instantiation modes

STGM_DIRECT             equate(00000000h)
STGM_TRANSACTED         equate(00010000h)
STGM_SIMPLE             equate(08000000h)

STGM_READ               equate(00000000h)
STGM_WRITE              equate(00000001h)
STGM_READWRITE          equate(00000002h)

STGM_SHARE_DENY_NONE    equate(00000040h)
STGM_SHARE_DENY_READ    equate(00000030h)
STGM_SHARE_DENY_WRITE   equate(00000020h)
STGM_SHARE_EXCLUSIVE    equate(00000010h)

STGM_PRIORITY           equate(00040000h)
STGM_DELETEONRELEASE    equate(04000000h)

!#if (WINVER >= 400)
STGM_NOSCRATCH          equate(00100000h)
!#endif /* WINVER */

STGM_CREATE             equate(00001000h)
STGM_CONVERT            equate(00020000h)
STGM_FAILIFTHERE        equate(00000000h)

STGM_NOSNAPSHOT         equate(00200000h)

! flags for internet asyncronous and layout docfile

ASYNC_MODE_COMPATIBILITY equate(00000001h)
ASYNC_MODE_DEFAULT      equate(00000000h)

STGTY_REPEAT            equate(00000100h)
STG_TOEND               equate(0FFFFFFFFh)

STG_LAYOUT_SEQUENTIAL   equate(00000000h)
STG_LAYOUT_INTERLEAVED  equate(00000001h)

STGFMT_STORAGE          equate(0)
STGFMT_NATIVE           equate(1)
STGFMT_FILE             equate(3)
STGFMT_ANY              equate(4)
STGFMT_DOCFILE          equate(5)

! This is a legacy define to allow old components to builds

STGFMT_DOCUMENT         equate(0)

TYMED                   itemize
TYMED_HGLOBAL             equate
TYMED_FILE                equate
TYMED_ISTREAM             equate(4)
TYMED_ISTORAGE            equate(8)
TYMED_GDI                 equate(16)
TYMED_MFPICT              equate(32)
TYMED_ENHMF               equate(64)
TYMED_NULL                equate(0)
                        end

STREAM_SEEK             itemize(0)
STREAM_SEEK_SET           equate
STREAM_SEEK_CUR           equate
STREAM_SEEK_END           equate
                        end

LOCKTYPE                itemize(1)
LOCK_WRITE                equate
LOCK_EXCLUSIVE            equate
LOCK_ONLYONCE             equate(4)
                        end

_IStream                group
Data1                     long(0ch)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end
  
IStream                 interface(ISequentialStream),com
Seek                      procedure(long dlibMove_High, long dlibMove_Low, long dwOrigin, |
                                    long plibNewPosition),HRESULT
SetSize                   procedure(long libNewSize_High, long libNewSize_Low),HRESULT
CopyTo                    procedure(long pstm, long cb_High, long cb_Low, long pcbRead, |
                                    long pcbWritten),HRESULT
Commit                    procedure(long grfCommitFlags),HRESULT
Revert                    procedure,HRESULT
LockRegion                procedure(long libOffset_High, long libOffset_Low, long cb_High, long cb_Low, |
                                    long dwLockType),HRESULT
UnlockRegion              procedure(long libOffset_High, long libOffset_Low, long cb_High, long cb_Low, |
                                    long dwLockType),HRESULT
Stat                      procedure(long pstatstg, long grfStatFlag),HRESULT
Clone                     procedure(*long pstm),HRESULT
                        end

RemSNB                  group,type
ulCntStr                  long
ulCntChar                 long
rgString                  short
                        end

_IStorage               group
Data1                     long(0bh)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end

IStorage                interface(IUnknown),com
CreateStream              procedure(long pwcsName, long grfMode, long reserved1, long reserved2, |
                                    *long pstm),HRESULT
OpenStream                procedure(long pwcsName, *long reserved1, long grfMode, long reserved2, |
                                    *long pstm),HRESULT
CreateStorage             procedure(long pwcsName, long grfMode, long reserved1, long reserved2, |
                                    *long pstg),HRESULT
OpenStorage               procedure(long pwcsName, *IStorage stgPriority, long grfMode, |
                                    long snbExclude, long reserved, *long pstg),HRESULT,raw
CopyTo                    procedure(long ciidExclude, long rgiidExclude, long snbExclude, |
                                    *IStorage stgDest),HRESULT,raw
MoveElementTo             procedure(long pwcsName, *IStorage stgDest, long pwcsNewName, |
                                    long grfFlags),HRESULT,raw
Commit                    procedure(long grfCommitFlags),HRESULT
Revert                    procedure,HRESULT
EnumElements              procedure(long reserved1, long reserved2, long reserved3, |
                                    *long penum),HRESULT
DestroyElement            procedure(long pwcsName),HRESULT
RenameElement             procedure(long pwcsOldName, long pwcsNewName),HRESULT
SetElementTimes           procedure(long pwcsName, long pctime, long patime, long pmtime),HRESULT
SetClass                  procedure(long rclsid),HRESULT
SetStateBits              procedure(long grfStateBits, long grfMask),HRESULT
Stat                      procedure(long pstatstg, long grfStatFlag),HRESULT
                        end

_ILockBytes             group
Data1                     long(0ah)
Data2                     short(0)
Data3                     short(0)
Data4                     string('<0C0h><0><0><0><0><0><0><046h>')
                        end

ILockBytes              interface(IUnknown),com
!        virtual /* [local] */ HRESULT STDMETHODCALLTYPE ReadAt( 
!            /* [in] */ ULARGE_INTEGER ulOffset,
!            /* [length_is][size_is][out] */ void __RPC_FAR *pv,
!            /* [in] */ ULONG cb,
!            /* [out] */ ULONG __RPC_FAR *pcbRead) = 0;
!        
!        virtual /* [local] */ HRESULT STDMETHODCALLTYPE WriteAt( 
!            /* [in] */ ULARGE_INTEGER ulOffset,
!            /* [size_is][in] */ const void __RPC_FAR *pv,
!            /* [in] */ ULONG cb,
!            /* [out] */ ULONG __RPC_FAR *pcbWritten) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE Flush( void) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE SetSize( 
!            /* [in] */ ULARGE_INTEGER cb) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE LockRegion( 
!            /* [in] */ ULARGE_INTEGER libOffset,
!            /* [in] */ ULARGE_INTEGER cb,
!            /* [in] */ DWORD dwLockType) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE UnlockRegion( 
!            /* [in] */ ULARGE_INTEGER libOffset,
!            /* [in] */ ULARGE_INTEGER cb,
!            /* [in] */ DWORD dwLockType) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE Stat( 
!            /* [out] */ STATSTG __RPC_FAR *pstatstg,
!            /* [in] */ DWORD grfStatFlag) = 0;
                        end

_IFillLockBytes         group
Data1                     long(099caf010h)
Data2                     short(0415eh)
Data3                     short(011cfh)
Data4                     string('<088h><014h><0><0aah><0><0b5h><069h><0f5h>')
                        end

IFillLockBytes          interface(IUnknown),com
FillAppend                procedure(long pv, long cb, *long cbWritten),HRESULT
FillAt                    procedure(I64 ulOffset, long pv, long cb, *long cbWritten),HRESULT
SetFillSize               procedure(I64 ulSize),HRESULT
Terminate                 procedure(short bCanceled),HRESULT
!        virtual /* [local] */ HRESULT STDMETHODCALLTYPE FillAppend( 
!            /* [size_is][in] */ const void __RPC_FAR *pv,
!            /* [in] */ ULONG cb,
!            /* [out] */ ULONG __RPC_FAR *pcbWritten) = 0;
!        
!        virtual /* [local] */ HRESULT STDMETHODCALLTYPE FillAt( 
!            /* [in] */ ULARGE_INTEGER ulOffset,
!            /* [size_is][in] */ const void __RPC_FAR *pv,
!            /* [in] */ ULONG cb,
!            /* [out] */ ULONG __RPC_FAR *pcbWritten) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE SetFillSize( 
!            /* [in] */ ULARGE_INTEGER ulSize) = 0;
!        
!        virtual HRESULT STDMETHODCALLTYPE Terminate( 
!            /* [in] */ BOOL bCanceled) = 0;
                        end

!*
!* HRESULT definitions
!*

COM_NOERROR             equate(0)

!*
!* Error definitions follow
!*

!*
!* Codes 0x4000-0x40ff are reserved for OLE
!*
!*
!* Error codes
!*

!** MessageId: E_UNEXPECTED
!**
!** MessageText:
!**
!**  Catastrophic failure

E_UNEXPECTED                equate(08000FFFFh)

!** MessageId: E_NOTIMPL
!**
!** MessageText:
!**
!**  Not implemented

E_NOTIMPL                   equate(080004001h)

!** MessageId: E_OUTOFMEMORY
!**
!** MessageText:
!**
!**  Ran out of memory

E_OUTOFMEMORY               equate(08007000Eh)

!** MessageId: E_INVALIDARG
!**
!** MessageText:
!**
!**  One or more arguments are invalid

E_INVALIDARG                equate(080070057h)

!** MessageId: E_NOINTERFACE
!**
!** MessageText:
!**
!**  No such interface supported

E_NOINTERFACE               equate(080004002h)

!** MessageId: E_POINTER
!**
!** MessageText:
!**
!**  Invalid pointer

E_POINTER                   equate(080004003h)

!** MessageId: E_HANDLE
!**
!** MessageText:
!**
!**  Invalid handle

E_HANDLE                    equate(080070006h)

!** MessageId: E_ABORT
!**
!** MessageText:
!**
!**  Operation aborted

E_ABORT                     equate(080004004h)

!** MessageId: E_FAIL
!**
!** MessageText:
!**
!**  Unspecified error

E_FAIL                      equate(080004005h)

!** MessageId: E_ACCESSDENIED
!**
!** MessageText:
!**
!**  General access denied error

E_ACCESSDENIED              equate(080070005h)

!** MessageId: E_PENDING
!**
!** MessageText:
!**
!**  The data necessary to complete this operation is not yet available.

E_PENDING                   equate(08000000Ah)

!** MessageId: CO_E_INIT_TLS
!**
!** MessageText:
!**
!**  Thread local storage failure

CO_E_INIT_TLS               equate(080004006h)

!** MessageId: CO_E_INIT_SHARED_ALLOCATOR
!**
!** MessageText:
!**
!**  Get shared memory allocator failure

CO_E_INIT_SHARED_ALLOCATOR  equate(080004007h)

!** MessageId: CO_E_INIT_MEMORY_ALLOCATOR
!**
!** MessageText:
!**
!**  Get memory allocator failure

CO_E_INIT_MEMORY_ALLOCATOR  equate(080004008h)

!** MessageId: CO_E_INIT_CLASS_CACHE
!**
!** MessageText:
!**
!**  Unable to initialize class cache

CO_E_INIT_CLASS_CACHE       equate(080004009h)

!** MessageId: CO_E_INIT_RPC_CHANNEL
!**
!** MessageText:
!**
!**  Unable to initialize RPC services

CO_E_INIT_RPC_CHANNEL       equate(08000400Ah)

!** MessageId: CO_E_INIT_TLS_SET_CHANNEL_CONTROL
!**
!** MessageText:
!**
!**  Cannot set thread local storage channel control

CO_E_INIT_TLS_SET_CHANNEL_CONTROL equate(08000400Bh)

!** MessageId: CO_E_INIT_TLS_CHANNEL_CONTROL
!**
!** MessageText:
!**
!**  Could not allocate thread local storage channel control

CO_E_INIT_TLS_CHANNEL_CONTROL equate(08000400Ch)

!** MessageId: CO_E_INIT_UNACCEPTED_USER_ALLOCATOR
!**
!** MessageText:
!**
!**  The user supplied memory allocator is unacceptable

CO_E_INIT_UNACCEPTED_USER_ALLOCATOR equate(08000400Dh)

!** MessageId: CO_E_INIT_SCM_MUTEX_EXISTS
!**
!** MessageText:
!**
!**  The OLE service mutex already exists

CO_E_INIT_SCM_MUTEX_EXISTS  equate(08000400Eh)

!** MessageId: CO_E_INIT_SCM_FILE_MAPPING_EXISTS
!**
!** MessageText:
!**
!**  The OLE service file mapping already exists

CO_E_INIT_SCM_FILE_MAPPING_EXISTS equate(08000400Fh)

!** MessageId: CO_E_INIT_SCM_MAP_VIEW_OF_FILE
!**
!** MessageText:
!**
!**  Unable to map view of file for OLE service

CO_E_INIT_SCM_MAP_VIEW_OF_FILE equate(080004010h)

!** MessageId: CO_E_INIT_SCM_EXEC_FAILURE
!**
!** MessageText:
!**
!**  Failure attempting to launch OLE service

CO_E_INIT_SCM_EXEC_FAILURE  equate(080004011h)

!** MessageId: CO_E_INIT_ONLY_SINGLE_THREADED
!**
!** MessageText:
!**
!**  There was an attempt to call CoInitialize a second time while single threaded

CO_E_INIT_ONLY_SINGLE_THREADED equate(080004012h)

!** MessageId: CO_E_CANT_REMOTE
!**
!** MessageText:
!**
!**  A Remote activation was necessary but was not allowed

CO_E_CANT_REMOTE            equate(080004013h)

!** MessageId: CO_E_BAD_SERVER_NAME
!**
!** MessageText:
!**
!**  A Remote activation was necessary but the server name provided was invalid

CO_E_BAD_SERVER_NAME        equate(080004014h)

!** MessageId: CO_E_WRONG_SERVER_IDENTITY
!**
!** MessageText:
!**
!**  The class is configured to run as a security id different from the caller

CO_E_WRONG_SERVER_IDENTITY  equate(080004015h)

!** MessageId: CO_E_OLE1DDE_DISABLED
!**
!** MessageText:
!**
!**  Use of Ole1 services requiring DDE windows is disabled

CO_E_OLE1DDE_DISABLED       equate(080004016h)

!** MessageId: CO_E_RUNAS_SYNTAX
!**
!** MessageText:
!**
!**  A RunAs specification must be <domain name>\<user name> or simply <user name>

CO_E_RUNAS_SYNTAX           equate(080004017h)

!** MessageId: CO_E_CREATEPROCESS_FAILURE
!**
!** MessageText:
!**
!**  The server process could not be started.  The pathname may be incorrect.

CO_E_CREATEPROCESS_FAILURE  equate(080004018h)

!** MessageId: CO_E_RUNAS_CREATEPROCESS_FAILURE
!**
!** MessageText:
!**
!**  The server process could not be started as the configured identity.  The pathname may be incorrect or unavailable.

CO_E_RUNAS_CREATEPROCESS_FAILURE equate(080004019h)

!** MessageId: CO_E_RUNAS_LOGON_FAILURE
!**
!** MessageText:
!**
!**  The server process could not be started because the configured identity is incorrect.  Check the username and password.

CO_E_RUNAS_LOGON_FAILURE    equate(08000401Ah)

!** MessageId: CO_E_LAUNCH_PERMSSION_DENIED
!**
!** MessageText:
!**
!**  The client is not allowed to launch this server.

CO_E_LAUNCH_PERMSSION_DENIED equate(08000401Bh)

!** MessageId: CO_E_START_SERVICE_FAILURE
!**
!** MessageText:
!**
!**  The service providing this server could not be started.

CO_E_START_SERVICE_FAILURE  equate(08000401Ch)

!** MessageId: CO_E_REMOTE_COMMUNICATION_FAILURE
!**
!** MessageText:
!**
!**  This computer was unable to communicate with the computer providing the server.

CO_E_REMOTE_COMMUNICATION_FAILURE equate(08000401Dh)

!** MessageId: CO_E_SERVER_START_TIMEOUT
!**
!** MessageText:
!**
!**  The server did not respond after being launched.

CO_E_SERVER_START_TIMEOUT   equate(08000401Eh)

!** MessageId: CO_E_CLSREG_INCONSISTENT
!**
!** MessageText:
!**
!**  The registration information for this server is inconsistent or incomplete.

CO_E_CLSREG_INCONSISTENT    equate(08000401Fh)

!** MessageId: CO_E_IIDREG_INCONSISTENT
!**
!** MessageText:
!**
!**  The registration information for this interface is inconsistent or incomplete.

CO_E_IIDREG_INCONSISTENT    equate(080004020h)

!** MessageId: CO_E_NOT_SUPPORTED
!**
!** MessageText:
!**
!**  The operation attempted is not supported.

CO_E_NOT_SUPPORTED          equate(080004021h)

!** MessageId: CO_E_RELOAD_DLL
!**
!** MessageText:
!**
!**  A dll must be loaded.

CO_E_RELOAD_DLL             equate(080004022h)

!** MessageId: CO_E_MSI_ERROR
!**
!** MessageText:
!**
!**  A Microsoft Software Installer error was encountered.

CO_E_MSI_ERROR              equate(080004023h)

!** MessageId: CO_E_ATTEMPT_TO_CREATE_OUTSIDE_CLIENT_CONTEXT
!**
!** MessageText:
!**
!**  The specified activation could not occur in the client context as specified.

CO_E_ATTEMPT_TO_CREATE_OUTSIDE_CLIENT_CONTEXT equate(080004024h)


! ******************
! FACILITY_DISPATCH
! ******************
!
! MessageId: DISP_E_UNKNOWNINTERFACE
!
! MessageText:
!
!  Unknown interface.

DISP_E_UNKNOWNINTERFACE     equate(080020001h)

!
! MessageId: DISP_E_MEMBERNOTFOUND
!
! MessageText:
!
!  Member not found.

DISP_E_MEMBERNOTFOUND       equate(080020003h)

!
! MessageId: DISP_E_PARAMNOTFOUND
!
! MessageText:
!
!  Parameter not found.

DISP_E_PARAMNOTFOUND        equate(080020004h)

!
! MessageId: DISP_E_TYPEMISMATCH
!
! MessageText:
!
!  Type mismatch.

DISP_E_TYPEMISMATCH         equate(080020005h)

!
! MessageId: DISP_E_UNKNOWNNAME
!
! MessageText:
!
!  Unknown name.

DISP_E_UNKNOWNNAME          equate(080020006h)

!
! MessageId: DISP_E_NONAMEDARGS
!
! MessageText:
!
!  No named arguments.

DISP_E_NONAMEDARGS          equate(080020007h)

!
! MessageId: DISP_E_BADVARTYPE
!
! MessageText:
!
!  Bad variable type.

DISP_E_BADVARTYPE           equate(080020008h)

!
! MessageId: DISP_E_EXCEPTION
!
! MessageText:
!
!  Exception occurred.

DISP_E_EXCEPTION            equate(080020009h)

!
! MessageId: DISP_E_OVERFLOW
!
! MessageText:
!
!  Out of present range.

DISP_E_OVERFLOW             equate(08002000Ah)

!
! MessageId: DISP_E_BADINDEX
!
! MessageText:
!
!  Invalid index.

DISP_E_BADINDEX             equate(08002000Bh)

!
! MessageId: DISP_E_UNKNOWNLCID
!
! MessageText:
!
!  Unknown language.

DISP_E_UNKNOWNLCID          equate(08002000Ch)

!
! MessageId: DISP_E_ARRAYISLOCKED
!
! MessageText:
!
!  Memory is locked.

DISP_E_ARRAYISLOCKED        equate(08002000Dh)

!
! MessageId: DISP_E_BADPARAMCOUNT
!
! MessageText:
!
!  Invalid number of parameters.

DISP_E_BADPARAMCOUNT        equate(08002000Eh)

!
! MessageId: DISP_E_PARAMNOTOPTIONAL
!
! MessageText:
!
!  Parameter not optional.

DISP_E_PARAMNOTOPTIONAL     equate(08002000Fh)

!
! MessageId: DISP_E_BADCALLEE
!
! MessageText:
!
!  Invalid callee.

DISP_E_BADCALLEE            equate(080020010h)

!
! MessageId: DISP_E_NOTACOLLECTION
!
! MessageText:
!
!  Does not support a collection.

DISP_E_NOTACOLLECTION       equate(080020011h)

!
! MessageId: DISP_E_DIVBYZERO
!
! MessageText:
!
!  Division by zero.

DISP_E_DIVBYZERO            equate(080020012h)

!
! MessageId: DISP_E_BUFFERTOOSMALL
!
! MessageText:
!
!  Buffer too small

ISP_E_BUFFERTOOSMALL        equate(080020013h)

!
! MessageId: TYPE_E_BUFFERTOOSMALL
!
! MessageText:
!
!  Buffer too small.

TYPE_E_BUFFERTOOSMALL       equate(080028016h)

!
! MessageId: TYPE_E_FIELDNOTFOUND
!
! MessageText:
!
!  Field name not defined in the record.

TYPE_E_FIELDNOTFOUND        equate(080028017h)

!
! MessageId: TYPE_E_INVDATAREAD
!
! MessageText:
!
!  Old format or invalid type library.

TYPE_E_INVDATAREAD          equate(080028018h)

!
! MessageId: TYPE_E_UNSUPFORMAT
!
! MessageText:
!
!  Old format or invalid type library.

TYPE_E_UNSUPFORMAT          equate(080028019h)

!
! MessageId: TYPE_E_REGISTRYACCESS
!
! MessageText:
!
!  Error accessing the OLE registry.

TYPE_E_REGISTRYACCESS       equate(08002801Ch)

!
! MessageId: TYPE_E_LIBNOTREGISTERED
!
! MessageText:
!
!  Library not registered.

TYPE_E_LIBNOTREGISTERED     equate(08002801Dh)

!
! MessageId: TYPE_E_UNDEFINEDTYPE
!
! MessageText:
!
!  Bound to unknown type.

TYPE_E_UNDEFINEDTYPE        equate(080028027h)

!
! MessageId: TYPE_E_QUALIFIEDNAMEDISALLOWED
!
! MessageText:
!
!  Qualified name disallowed.

TYPE_E_QUALIFIEDNAMEDISALLOWED equate(080028028h)

!
! MessageId: TYPE_E_INVALIDSTATE
!
! MessageText:
!
!  Invalid forward reference, or reference to uncompiled type.

TYPE_E_INVALIDSTATE         equate(080028029h)

!
! MessageId: TYPE_E_WRONGTYPEKIND
!
! MessageText:
!
!  Type mismatch.

TYPE_E_WRONGTYPEKIND        equate(08002802Ah)

!
! MessageId: TYPE_E_ELEMENTNOTFOUND
!
! MessageText:
!
!  Element not found.

TYPE_E_ELEMENTNOTFOUND      equate(08002802Bh)

!
! MessageId: TYPE_E_AMBIGUOUSNAME
!
! MessageText:
!
!  Ambiguous name.

TYPE_E_AMBIGUOUSNAME        equate(08002802Ch)

!
! MessageId: TYPE_E_NAMECONFLICT
!
! MessageText:
!
!  Name already exists in the library.

TYPE_E_NAMECONFLICT         equate(08002802Dh)

!
! MessageId: TYPE_E_UNKNOWNLCID
!
! MessageText:
!
!  Unknown LCID.

TYPE_E_UNKNOWNLCID          equate(08002802Eh)

!
! MessageId: TYPE_E_DLLFUNCTIONNOTFOUND
!
! MessageText:
!
! Function not defined in specified DLL.

TYPE_E_DLLFUNCTIONNOTFOUND  equate(080022802Fh)

!
! MessageId: TYPE_E_BADMODULEKIND
!
! MessageText:
!
!  Wrong module kind for the operation.

TYPE_E_BADMODULEKIND        equate(0800288BDh)

!
! MessageId: TYPE_E_SIZETOOBIG
!
! MessageText:
!
!  Size may not exceed 64K.

TYPE_E_SIZETOOBIG           equate(0800288C5h)

!
! MessageId: TYPE_E_DUPLICATEID
!
! MessageText:
!
!  Duplicate ID in inheritance hierarchy.

TYPE_E_DUPLICATEID          equate(0800288C6h)

!
! MessageId: TYPE_E_INVALIDID
!
! MessageText:
!
!  Incorrect inheritance depth in standard OLE hmember.

TYPE_E_INVALIDID            equate(0800288CFh)

!
! MessageId: TYPE_E_TYPEMISMATCH
!
! MessageText:
!
!  Type mismatch.

TYPE_E_TYPEMISMATCH         equate(080028CA0h)

!
! MessageId: TYPE_E_OUTOFBOUNDS
!
! MessageText:
!
!  Invalid number of arguments.

TYPE_E_OUTOFBOUNDS          equate(080028CA1h)

!
! MessageId: TYPE_E_IOERROR
!
! MessageText:
!
!  I/O Error.

TYPE_E_IOERROR              equate(080028CA2h)

!
! MessageId: TYPE_E_CANTCREATETMPFILE
!
! MessageText:
!
!  Error creating unique tmp file.

TYPE_E_CANTCREATETMPFILE    equate(080028CA3h)

!
! MessageId: TYPE_E_CANTLOADLIBRARY
!
! MessageText:
!
!  Error loading type library/DLL.

TYPE_E_CANTLOADLIBRARY      equate(080029C4Ah)

!
! MessageId: TYPE_E_INCONSISTENTPROPFUNCS
!
! MessageText:
!
!  Inconsistent property functions.

TYPE_E_INCONSISTENTPROPFUNCS equate(080029C83h)

!
! MessageId: TYPE_E_CIRCULARTYPE
!
! MessageText:
!
!  Circular dependency between types/modules.

TYPE_E_CIRCULARTYPE         equate(080029C84h)


_SAFEARRAYBOUND                 group,type
cElements                         long
lLbound                           long
                                end


!typedef struct tagSAFEARRAYBOUND __RPC_FAR *LPSAFEARRAYBOUND;
!
!/* the following is what MIDL knows how to remote */
!typedef /* [unique] */ struct _wireVARIANT __RPC_FAR *wireVARIANT;
!
!typedef /* [unique] */ struct _wireBRECORD __RPC_FAR *wireBRECORD;
!
!typedef struct  _wireSAFEARR_BSTR
!    {
!    ULONG Size;
!    /* [ref][size_is] */ wireBSTR __RPC_FAR *aBstr;
!    }    SAFEARR_BSTR;
!
!typedef struct  _wireSAFEARR_UNKNOWN
!    {
!    ULONG Size;
!    /* [ref][size_is] */ IUnknown __RPC_FAR *__RPC_FAR *apUnknown;
!    }    SAFEARR_UNKNOWN;
!
!typedef struct  _wireSAFEARR_DISPATCH
!    {
!    ULONG Size;
!    /* [ref][size_is] */ IDispatch __RPC_FAR *__RPC_FAR *apDispatch;
!    }    SAFEARR_DISPATCH;
!
!typedef struct  _wireSAFEARR_VARIANT
!    {
!    ULONG Size;
!    /* [ref][size_is] */ wireVARIANT __RPC_FAR *aVariant;
!    }    SAFEARR_VARIANT;
!
!typedef struct  _wireSAFEARR_BRECORD
!    {
!    ULONG Size;
!    /* [ref][size_is] */ wireBRECORD __RPC_FAR *aRecord;
!    }    SAFEARR_BRECORD;
!
!typedef struct  _wireSAFEARR_HAVEIID
!    {
!    ULONG Size;
!    /* [ref][size_is] */ IUnknown __RPC_FAR *__RPC_FAR *apUnknown;
!    IID iid;
!    }    SAFEARR_HAVEIID;
!
!typedef /* [v1_enum] */ 
!enum tagSF_TYPE
!    {    SF_ERROR    = VT_ERROR,
!    SF_I1    = VT_I1,
!    SF_I2    = VT_I2,
!    SF_I4    = VT_I4,
!    SF_I8    = VT_I8,
!    SF_BSTR    = VT_BSTR,
!    SF_UNKNOWN    = VT_UNKNOWN,
!    SF_DISPATCH    = VT_DISPATCH,
!    SF_VARIANT    = VT_VARIANT,
!    SF_RECORD    = VT_RECORD,
!    SF_HAVEIID    = VT_UNKNOWN | VT_RESERVED
!    }    SF_TYPE;
!
!typedef struct  _wireSAFEARRAY_UNION
!    {
!    ULONG sfType;
!    /* [switch_is] */ /* [switch_type] */ union __MIDL_IOleAutomationTypes_0001
!        {
!        /* [case()] */ SAFEARR_BSTR BstrStr;
!        /* [case()] */ SAFEARR_UNKNOWN UnknownStr;
!        /* [case()] */ SAFEARR_DISPATCH DispatchStr;
!        /* [case()] */ SAFEARR_VARIANT VariantStr;
!        /* [case()] */ SAFEARR_BRECORD RecordStr;
!        /* [case()] */ SAFEARR_HAVEIID HaveIidStr;
!        /* [case()] */ BYTE_SIZEDARR ByteStr;
!        /* [case()] */ WORD_SIZEDARR WordStr;
!        /* [case()] */ DWORD_SIZEDARR LongStr;
!        /* [case()] */ HYPER_SIZEDARR HyperStr;
!        }    u;
!    }    SAFEARRAYUNION;
!
!typedef /* [unique] */ struct  _wireSAFEARRAY
!    {
!    USHORT cDims;
!    USHORT fFeatures;
!    ULONG cbElements;
!    ULONG cLocks;
!    SAFEARRAYUNION uArrayStructs;
!    /* [size_is] */ SAFEARRAYBOUND rgsabound[ 1 ];
!    }    __RPC_FAR *wireSAFEARRAY;
!

_SAFEARRAY                       group,type
cDims                             short
fFeatures                         short
cbElements                        long
cLocks                            long
pvData                            long
rgsabound                         like(_SAFEARRAYBOUND)
                                end


!*
!* Success codes
!*

S_OK                        equate(0)
S_FALSE                     equate(1)

VARTYPE                     equate(short)

!*
!* VARENUM usage key,
!*
!* * [V] - may appear in a VARIANT
!* * [T] - may appear in a TYPEDESC
!* * [P] - may appear in an OLE property set
!* * [S] - may appear in a Safe Array
!*
!*
!*  VT_EMPTY            [V]   [P]     nothing
!*  VT_NULL             [V]   [P]     SQL style Null
!*  VT_I2               [V][T][P][S]  2 byte signed int
!*  VT_I4               [V][T][P][S]  4 byte signed int
!*  VT_R4               [V][T][P][S]  4 byte real
!*  VT_R8               [V][T][P][S]  8 byte real
!*  VT_CY               [V][T][P][S]  currency
!*  VT_DATE             [V][T][P][S]  date
!*  VT_BSTR             [V][T][P][S]  OLE Automation string
!*  VT_DISPATCH         [V][T]   [S]  IDispatch *
!*  VT_ERROR            [V][T][P][S]  SCODE
!*  VT_BOOL             [V][T][P][S]  True=-1, False=0
!*  VT_VARIANT          [V][T][P][S]  VARIANT *
!*  VT_UNKNOWN          [V][T]   [S]  IUnknown *
!*  VT_DECIMAL          [V][T]   [S]  16 byte fixed point
!*  VT_RECORD           [V]   [P][S]  user defined type
!*  VT_I1               [V][T][P][s]  signed char
!*  VT_UI1              [V][T][P][S]  unsigned char
!*  VT_UI2              [V][T][P][S]  unsigned short
!*  VT_UI4              [V][T][P][S]  unsigned long
!*  VT_I8                  [T][P]     signed 64-bit int
!*  VT_UI8                 [T][P]     unsigned 64-bit int
!*  VT_INT              [V][T][P][S]  signed machine int
!*  VT_UINT             [V][T]   [S]  unsigned machine int
!*  VT_VOID                [T]        C style void
!*  VT_HRESULT             [T]        Standard return type
!*  VT_PTR                 [T]        pointer type
!*  VT_SAFEARRAY           [T]        (use VT_ARRAY in VARIANT)
!*  VT_CARRAY              [T]        C style array
!*  VT_USERDEFINED         [T]        user defined type
!*  VT_LPSTR               [T][P]     null terminated string
!*  VT_LPWSTR              [T][P]     wide null terminated string
!*  VT_FILETIME               [P]     FILETIME
!*  VT_BLOB                   [P]     Length prefixed bytes
!*  VT_STREAM                 [P]     Name of the stream follows
!*  VT_STORAGE                [P]     Name of the storage follows
!*  VT_STREAMED_OBJECT        [P]     Stream contains an object
!*  VT_STORED_OBJECT          [P]     Storage contains an object
!*  VT_VERSIONED_STREAM       [P]     Stream with a GUID version
!*  VT_BLOB_OBJECT            [P]     Blob contains an object
!*  VT_CF                     [P]     Clipboard format
!*  VT_CLSID                  [P]     A Class ID
!*  VT_VECTOR                 [P]     simple counted array
!*  VT_ARRAY            [V]           SAFEARRAY*
!*  VT_BYREF            [V]           void* for local use
!*  VT_BSTR_BLOB                      Reserved for system use

!struct tagVARIANT {
!    VARTYPE vt;
!    WORD wReserved1;
!    WORD wReserved2;
!    WORD wReserved3;
!    union {
!    //  C++ Type      Union Name   Type Tag                Basic Type
!    //  --------      ----------   --------                ----------
!        long          lVal;        // VT_I4                ByVal Long
!        unsigned char bVal;        // VT_UI1               ByVal Byte
!        short         iVal;        // VT_I2                ByVal Integer
!        float         fltVal;      // VT_R4                ByVal Single
!        double        dblVal;      // VT_R8                ByVal Double
!        VARIANT_BOOL  boolVal;     // VT_BOOL              ByVal Boolean
!        SCODE         scode;       // VT_ERROR
!        CY            cyVal;       // VT_CY                ByVal Currency 
!        DATE          date;        // VT_DATE              ByVal Date
!        BSTR          bstrVal;     // VT_BSTR              ByVal String
!        IUnknown      *punkVal;    // VT_UNKNOWN 
!        IDispatch     *pdispVal;   // VT_DISPATCH          ByVal Object
!        SAFEARRAY     *parray;     // VT_ARRAY|*           ByVal array
!        // A bunch of other types that don't matter here...
!        VARIANT       *pvarVal;    // VT_BYREF|VT_VARIANT  ByRef Variant
!        void          * byref;     // Generic ByRef        
!    };
!};



!*/

VARENUM                 itemize(0)
VT_EMPTY                  equate
VT_NULL                   equate
VT_I2                     equate
VT_I4                     equate
VT_R4                     equate
VT_R8                     equate
VT_CY                     equate
VT_DATE                   equate
VT_BSTR                   equate
VT_DISPATCH               equate
VT_ERROR                  equate
VT_BOOL                   equate
VT_VARIANT                equate
VT_UNKNOWN                equate
VT_DECIMAL                equate
VT_I1                     equate(16)
VT_UI1                    equate
VT_UI2                    equate
VT_UI4                    equate
VT_I8                     equate
VT_UI8                    equate
VT_INT                    equate
VT_UINT                   equate
VT_VOID                   equate
VT_HRESULT                equate
VT_PTR                    equate
VT_SAFEARRAY              equate
VT_CARRAY                 equate
VT_USERDEFINED            equate
VT_LPSTR                  equate
VT_LPWSTR                 equate
VT_RECORD                 equate(36)
VT_FILETIME               equate(64)
VT_BLOB                   equate
VT_STREAM                 equate
VT_STORAGE                equate
VT_STREAMED_OBJECT        equate
VT_STORED_OBJECT          equate
VT_BLOB_OBJECT            equate
VT_CF                     equate
VT_CLSID                  equate
VT_VERSIONED_STREAM       equate
VT_BSTR_BLOB              equate(0fffh)
VT_VECTOR                 equate(01000h)
VT_ARRAY                  equate(02000h)
VT_BYREF                  equate(04000h)
VT_RESERVED               equate(08000h)
VT_ILLEGAL                equate(0ffffh)
VT_ILLEGALMASKED          equate(0fffh)
VT_TYPEMASK               equate(0fffh)
                        end

tVariant                group,type
vt                        short
wReserved1                short
wReserved2                short
wReserved3                short
iVal                      long
iVal2                     long
srVal                     sreal,over(iVal)
                        end

tVariantr               group,type
vt                        short
wReserved1                short
wReserved2                short
wReserved3                short
rVal                      real
                        end

CY             GROUP,TYPE
Lo               ULONG
Hi               LONG
               END
                        
gVARIANT       GROUP,TYPE
vt               USHORT
wReserved1       USHORT !WORD
wReserved2       USHORT !WORD
wReserved3       USHORT !WORD

dblVal           REAL
lVal             LONG,OVER(dblVal)
bVal             BYTE,OVER(dblVal)
iVal             SHORT,OVER(dblVal)
fltVal           SREAL,OVER(dblVal)
boolVal          SHORT,OVER(dblVal)
scode            LONG,OVER(dblVal)
cyVal            GROUP(CY),OVER(dblVal).
date             REAL,OVER(dblVal)
                 GROUP,OVER(dblVal)
bstrVal            &BSTRING
                 END
                 GROUP,OVER(dblVal)
punkVal            &IUnknown
                 END
                 GROUP,OVER(dblVal)
pdispVal           &IDispatch
                 END
!                GROUP,OVER(dblVal)
!parray            &tSAFEARRAY,RAW    !<<< for future
!                END
                 GROUP,OVER(dblVal)
pbVal              &BYTE
                 END
                 GROUP,OVER(dblVal)
piVal              &SHORT
                 END
                 GROUP,OVER(dblVal)
plVal              &LONG
                 END
                 GROUP,OVER(dblVal)
pfltVal            &SREAL
                 END
                 GROUP,OVER(dblVal)
pdblVal            &REAL
                 END               
                 GROUP,OVER(dblVal)
pboolVal           &SHORT
                 END
                 GROUP,OVER(dblVal)
pscode             &LONG
                 END
!                GROUP,OVER(dblVal)
!pcyVal            &CY,RAW <<< for future
!                END
                 GROUP,OVER(dblVal)
pdate              &REAL
                 END
! next fields require canes in the compiler to support reference to reference types
                 GROUP,OVER(dblVal)
byref              &BYTE
                 END
               END
                        

vtMissing               group(gVariant)
vt                        short(VT_ERROR)
wReserved1                short
wReserved2                short
wReserved3                short
lVal                      long(DISP_E_PARAMNOTFOUND)
pad                       long
                        end

_DECIMAL                group,type
wReserved                 short
scale                     byte
sign                      byte
Hi32                      long
Lo64                      long,dim(2)
                        end

_NUMERIC        GROUP,type
precision                 BYTE
scale                     BYTE
sign                      BYTE
val                       BYTE,DIM(16)
                        END
UNIT                    equate(32)
MAX_DIGIT               equate(63)

ClaDecAccum             group,type
accum                     byte,dim(MAX_DIGIT + 1)
sign                      byte                  ! 1 => negative 0 => positive
low                       byte                  ! accum[low] is low byte
high                      byte                  ! kept computed accum[high] is high byte
                        end

! Integer part of value occupies accum items from UNIT to MAX_DIGIT+1,
! digits of fractional part - from 0 to UNIT-1. So, value 1.5 is presented
! as follows:

!  x->low = UNIT - 1
!  x->high = UNIT
!  x->accum[UNIT-1] = 5
!  x->accum[UNIT] = 1
 
!You can consider that you have a function that returns a pointer to Accum
!structure already pushed to the top of the decimal stack.
 

!  Standard dispatch ID constants

DISPID_AUTOSIZE                 equate(-500)
DISPID_BACKCOLOR                equate(-501)
DISPID_BACKSTYLE                equate(-502)
DISPID_BORDERCOLOR              equate(-503)
DISPID_BORDERSTYLE              equate(-504)
DISPID_BORDERWIDTH              equate(-505)
DISPID_DRAWMODE                 equate(-507)
DISPID_DRAWSTYLE                equate(-508)
DISPID_DRAWWIDTH                equate(-509)
DISPID_FILLCOLOR                equate(-510)
DISPID_FILLSTYLE                equate(-511)
DISPID_FONT                     equate(-512)
DISPID_FORECOLOR                equate(-513)
DISPID_ENABLED                  equate(-514)
DISPID_HWND                     equate(-515)
DISPID_TABSTOP                  equate(-516)
DISPID_TEXT                     equate(-517)
DISPID_CAPTION                  equate(-518)
DISPID_BORDERVISIBLE            equate(-519)
DISPID_APPEARANCE               equate(-520)
DISPID_MOUSEPOINTER             equate(-521)
DISPID_MOUSEICON                equate(-522)
DISPID_PICTURE                  equate(-523)
DISPID_VALID                    equate(-524)
DISPID_READYSTATE               equate(-525)
DISPID_LISTINDEX                equate(-526)
DISPID_SELECTED                 equate(-527)
DISPID_LIST                     equate(-528)
DISPID_COLUMN                   equate(-529)
DISPID_LISTCOUNT                equate(-531)
DISPID_MULTISELECT              equate(-532)
DISPID_MAXLENGTH                equate(-533)
DISPID_PASSWORDCHAR             equate(-534)
DISPID_SCROLLBARS               equate(-535)
DISPID_WORDWRAP                 equate(-536)
DISPID_MULTILINE                equate(-537)
DISPID_NUMBEROFROWS             equate(-538)
DISPID_NUMBEROFCOLUMNS          equate(-539)
DISPID_DISPLAYSTYLE             equate(-540)
DISPID_GROUPNAME                equate(-541)
DISPID_IMEMODE                  equate(-542)
DISPID_ACCELERATOR              equate(-543)
DISPID_ENTERKEYBEHAVIOR         equate(-544)
DISPID_TABKEYBEHAVIOR           equate(-545)
DISPID_SELTEXT                  equate(-546)
DISPID_SELSTART                 equate(-547)
DISPID_SELLENGTH                equate(-548)

DISPID_REFRESH                  equate(-550)
DISPID_DOCLICK                  equate(-551)
DISPID_ABOUTBOX                 equate(-552)
DISPID_ADDITEM                  equate(-553)
DISPID_CLEAR                    equate(-554)
DISPID_REMOVEITEM               equate(-555)

DISPID_CLICK                    equate(-600)
DISPID_DBLCLICK                 equate(-601)
DISPID_KEYDOWN                  equate(-602)
DISPID_KEYPRESS                 equate(-603)
DISPID_KEYUP                    equate(-604)
DISPID_MOUSEDOWN                equate(-605)
DISPID_MOUSEMOVE                equate(-606)
DISPID_MOUSEUP                  equate(-607)
DISPID_ERROREVENT               equate(-608)
DISPID_READYSTATECHANGE         equate(-609)
DISPID_CLICK_VALUE              equate(-610)
DISPID_RIGHTTOLEFT              equate(-611)
DISPID_TOPTOBOTTOM              equate(-612)
DISPID_THIS                     equate(-613)

DISPID_AMBIENT_BACKCOLOR        equate(-701)
DISPID_AMBIENT_DISPLAYNAME      equate(-702)
DISPID_AMBIENT_FONT             equate(-703)
DISPID_AMBIENT_FORECOLOR        equate(-704)
DISPID_AMBIENT_LOCALEID         equate(-705)
DISPID_AMBIENT_MESSAGEREFLECT   equate(-706)
DISPID_AMBIENT_SCALEUNITS       equate(-707)
DISPID_AMBIENT_TEXTALIGN        equate(-708)
DISPID_AMBIENT_USERMODE         equate(-709)
DISPID_AMBIENT_UIDEAD           equate(-710)
DISPID_AMBIENT_SHOWGRABHANDLES  equate(-711)
DISPID_AMBIENT_SHOWHATCHING     equate(-712)
DISPID_AMBIENT_DISPLAYASDEFAULT equate(-713)
DISPID_AMBIENT_SUPPORTSMNEMONICS equate(-714)
DISPID_AMBIENT_AUTOCLIP         equate(-715)
DISPID_AMBIENT_APPEARANCE       equate(-716)

DISPID_AMBIENT_CODEPAGE         equate(-725)
DISPID_AMBIENT_PALETTE          equate(-726)
DISPID_AMBIENT_CHARSET          equate(-727)
DISPID_AMBIENT_TRANSFERPRIORITY equate(-728)

DISPID_AMBIENT_RIGHTTOLEFT      equate(-732)
DISPID_AMBIENT_TOPTOBOTTOM      equate(-733)

DISPID_Name                     equate(-800)
DISPID_Delete                   equate(-801)
DISPID_Object                   equate(-802)
DISPID_Parent                   equate(-803)


DISPID_AMBIENT_OFFLINEIFNOTCONNECTED equate(-5501)
DISPID_AMBIENT_SILENT           equate(-5502)

! Dispatch ID constants for font and picture types

DISPID_FONT_NAME                equate(0)
DISPID_FONT_SIZE                equate(2)
DISPID_FONT_BOLD                equate(3)
DISPID_FONT_ITALIC              equate(4)
DISPID_FONT_UNDER               equate(5)
DISPID_FONT_STRIKE              equate(6)
DISPID_FONT_WEIGHT              equate(7)
DISPID_FONT_CHARSET             equate(8)
DISPID_FONT_CHANGED             equate(9)

DISPID_PICT_HANDLE              equate(0)
DISPID_PICT_HPAL                equate(2)
DISPID_PICT_TYPE                equate(3)
DISPID_PICT_WIDTH               equate(4)
DISPID_PICT_HEIGHT              equate(5)
DISPID_PICT_RENDER              equate(6)

! Flags for VariantChangeType/VariantChangeTypeEx

VARIANT_NOVALUEPROP             equate(01h)
VARIANT_ALPHABOOL               equate(02h) ! For VT_BOOL to VT_BSTR conversions,
                                            ! convert to "True"/"False" instead of
                                            ! "-1"/"0"
VARIANT_NOUSEROVERRIDE          equate(04h) ! For conversions to/from VT_BSTR,
                                            ! passes LOCALE_NOUSEROVERRIDE
                                            ! to core coercion routines
VARIANT_LOCALBOOL               equate(08h) ! For VT_BOOL to VT_BSTR and back,
                                            ! convert to local language rather than
                                            ! English




  map
    module('WinAPI')

      SystemTimeToVariantTime(*_SYSTEMTIME SystemTime, long pvtime),HRESULT,raw,pascal
      VariantTimeToSystemTime(real vtime, *_SYSTEMTIME SystemTime),long,raw,pascal

!*---------------------------------------------------------------------*
!*                            BSTR API                                 *
!*---------------------------------------------------------------------*

      SysAllocString(long),BSTR,pascal
      SysReAllocString(*long bstr, long),long,pascal
      SysAllocStringLen(long, long),BSTR,pascal
      SysReAllocStringLen(*long bstr, long, long),long,pascal
      SysFreeString(long bstr),pascal
      SysStringLen(long bstr),long,pascal
      SysStringByteLen(long bstr),long,pascal
      SysAllocStringByteLen(*cstring sz, long len),BSTR,raw,pascal

!*---------------------------------------------------------------------*
!*                          SafeArray API                              *
!*---------------------------------------------------------------------*

      SafeArrayAllocDescriptor(long cDims, *long psaOut),HRESULT,pascal
      SafeArrayAllocDescriptorEx(VARTYPE vt, long cDims, *long psaOut),HRESULT,pascal
      SafeArrayAllocData(*_SAFEARRAY sa),HRESULT,raw,pascal
      SafeArrayCreate(VARTYPE vt, long cDims, *_SAFEARRAYBOUND rgsabound),long,raw,pascal
      SafeArrayCreateEx(VARTYPE vt, long cDims, *_SAFEARRAYBOUND rgsabound, long pvExtra),long,raw,pascal
      SafeArrayCopyData(*_SAFEARRAY saSource, *_SAFEARRAY saTarget),HRESULT,raw,pascal
      SafeArrayDestroyDescriptor(*_SAFEARRAY sa),HRESULT,raw,pascal
      SafeArrayDestroyData(*_SAFEARRAY sa),HRESULT,raw,pascal
      SafeArrayDestroy(*_SAFEARRAY sa),HRESULT,raw,pascal,proc
      SafeArrayRedim(*_SAFEARRAY sa, *_SAFEARRAYBOUND saboundNew),HRESULT,raw,pascal
      SafeArrayGetDim(*_SAFEARRAY sa),long,raw,pascal
      SafeArrayGetElemsize(*_SAFEARRAY sa),long,raw,pascal
      SafeArrayGetUBound(*_SAFEARRAY sa, long nDim, *long lUbound),HRESULT,raw,pascal
      SafeArrayGetLBound(*_SAFEARRAY sa, long nDim, *long lLbound),HRESULT,raw,pascal
      SafeArrayLock(*_SAFEARRAY sa),HRESULT,raw,pascal
      SafeArrayUnlock(*_SAFEARRAY sa),HRESULT,raw,pascal
      SafeArrayAccessData(*_SAFEARRAY sa, *long pvData),HRESULT,raw,pascal
      SafeArrayUnaccessData(*_SAFEARRAY sa),HRESULT,raw,pascal,proc
      SafeArrayGetElement(*_SAFEARRAY sa, long prgIndices, *tVariant vt),HRESULT,raw,pascal
      SafeArrayPutElement(*_SAFEARRAY sa, long prgIndices, *tVariant vt),HRESULT,raw,pascal
      SafeArrayPutElement(*_SAFEARRAY sa, long prgIndices, *gVariant vt),HRESULT,raw,pascal
      SafeArrayCopy(*_SAFEARRAY sa, *long psaOut),HRESULT,raw,pascal
      SafeArrayPtrOfIndex(*_SAFEARRAY sa, long prgIndices, *long pvData),HRESULT,raw,pascal
      SafeArraySetRecordInfo(*_SAFEARRAY sa, *IRecordInfo rinfo),HRESULT,raw,pascal
      SafeArrayGetRecordInfo(*_SAFEARRAY sa, *long prinfo),HRESULT,raw,pascal
      SafeArraySetIID(*_SAFEARRAY sa, REFGUID guid),HRESULT,raw,pascal
      SafeArrayGetIID(*_SAFEARRAY sa, *GUID guid),HRESULT,raw,pascal
      SafeArrayGetVartype(*_SAFEARRAY sa, *VARTYPE vt),HRESULT,raw,pascal
      SafeArrayCreateVector(VARTYPE vt, long lLbound, long cElements),long,pascal
      SafeArrayCreateVectorEx(VARTYPE vt, long lLbound, long cElements, long pvExtra),long,pascal

!*---------------------------------------------------------------------*
!*                           VARIANT API                               *
!*---------------------------------------------------------------------*

      VariantInit(*tVariant vtArg),raw,pascal
      VariantClear(*tVariant vtArg),HRESULT,raw,pascal,proc
      VariantCopy(*tVariant vargDest, *tVariant vargSrc),HRESULT,raw,pascal
      VariantCopyInd(*tVariant varDest, *tVariant vargSrc),HRESULT,raw,pascal
      VariantChangeType(*tVariant vargDest, *tVariant varSrc, short wFlags, VARTYPE vt),HRESULT,raw,pascal
      VariantChangeTypeEx(*tVariant vargDest, *tVariant varSrc, LCID lcid, short wFlags, VARTYPE vt),HRESULT,raw,pascal

!*---------------------------------------------------------------------*
!*                             DV API                                  *
!*---------------------------------------------------------------------*

      CreateDataAdviseHolder(*long ppDAHolder),HRESULT,pascal
      CreateDataCache(*IUnknown pUnkOuter, REFCLSID rclsid, REFIID iid, *long ppv),HRESULT,raw,pascal

!*---------------------------------------------------------------------*
!*                          STORAGE API                                *
!*---------------------------------------------------------------------*

      StgCreateDocfile(long pwcsName, long grfMode, long reserved, *long ppstgOpen),HRESULT,pascal
      StgCreateDocfileOnILockBytes(*ILockBytes plkbyt, long grfMode, long reserved, *long ppstgOpen),HRESULT,raw,pascal
      StgOpenStorage(long pwcsName, *IStorage pstgPriority, long grfMode, RemSNB snbExclude, long reserved, *long ppstgOpen),HRESULT,raw,pascal
      StgOpenStorageOnILockBytes(*ILockBytes plkbyt, *IStorage pstgPriority, long grfMode, RemSNB snbExclude, long reserved, *long ppstgOpen),HRESULT,raw,pascal
      StgIsStorageFile(long pwcsName),HRESULT,pascal
      StgIsStorageILockBytes(*ILockBytes plkbyt),HRESULT,raw,pascal
      StgSetTimes(long lpszName, *FILETIME ctime, *FILETIME atime, *FILETIME mtime),HRESULT,raw,pascal
      StgOpenAsyncDocfileOnIFillLockBytes(*IFillLockBytes pflb, long grfMode, long asyncFlags, *long ppstgOpen),HRESULT,raw,pascal
      StgGetIFillLockBytesOnILockBytes(*ILockBytes pilb, *long ppflb),HRESULT,raw,pascal
      StgGetIFillLockBytesOnFile(long pwcsName, *long ppflb),HRESULT,pascal
      StgOpenLayoutDocfile(long pwcsDfName, long grfMode, long reserved, *long ppstgOpen),HRESULT,pascal
      StgCreateStorageEx(long pwcsName, long grfMode, long stgfmt, long grfAttrs, long reserved1, long reserved2, REFIID riid, *long ppObjectOpen),HRESULT,pascal
      StgOpenStorageEx(long pwcsName, long grfMode, long stgfmt, long grfAttrs, long reserved1, long reserved2, REFIID riid, *long ppObjectOpen),HRESULT,pascal

!*---------------------------------------------------------------------*
!*                              MISC                                   *
!*---------------------------------------------------------------------*

      CLSIDFromProgID(long lpwcsProgID, long pclsid),HRESULT,pascal
      ProgIDFromCLSID(REFCLSID rclsid, *long lpwcsProgID),HRESULT,pascal
      StringFromCLSID(REFCLSID rclsid, *long ppsz),HRESULT,pascal
      CLSIDFromString(long lpsz, long pclsid),HRESULT,pascal

      CoTaskMemAlloc(long cb),long,pascal
      CoTaskMemFree(long pv),pascal
      CoGetMalloc(long dwMemContext, *long ppMalloc),HRESULT,pascal
      CoTaskMemRealloc(long pv, long cb),long,pascal
 
    end
  end

  EndDefine

