!ABCIncludeFile(SV)

  omit('EndDefine',_COMSupport_)
_COMSupport_  equate(1)

!************************************************************************
!
!  Module:         svcom.inc
!
!
!  Description:
!
!************************************************************************


!*
!* Includes
!*

  include('svcomdef.inc'),once

!*
!* Defines
!*

VariantRow          queue,type
vtCol                 group(tVariant).
vtColr                group(tVariantr),over(vtCol).
                    end

VariantQueue        queue,type
VtRow                 &VariantRow
                    end

VtQueueTransport    class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)
VtQueue               &VariantQueue
                    end

!*
!* Func Proto
!*

  map
    module('svcom.clw')
      BuildWideStr(long pWideStr),*CWideStr
      QueryInterface(*IUnknown IUnk, *IUnknown pInterface, *long pvObject),HRESULT,pascal
    end
  end

!*
!* Declarations
!*

SACallbackWrapper   class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

SAEnumProc            procedure(*tVariant vtValue, long x, long y, byte bEndOfRow, long lParam),byte,virtual

                    end

CWideStr            class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure(*cstring sz, byte bSelfCleaning = true),long
Init                  procedure(*string str, byte bSelfCleaning = true),long
Init                  procedure(long pWideStr),byte
IsInitialised         procedure,byte
GetWideStr            procedure,long
Len                   procedure,long
Release               procedure

! Protected

bSelfCleaning         bool,protected

! Private

pWideStr              long,private
dwBytes               long,private

                    end


CBStr               class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure(*cstring sz, byte bSelfCleaning = true),long
Init                  procedure(*string sz, byte bSelfCleaning = true),long
Init                  procedure(CWideStr WideStr, byte bSelfCleaning = true),long
IsInitialised         procedure,byte
GetBStr               procedure,long
Len                   procedure,long
Release               procedure

! Protected

bSelfCleaning         bool,protected

! Private

BStr                  long,private
dwBytes               long,private

                    end


CStr                class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure

Init                  procedure(*cstring sz, byte bSelfCleaning = true),byte
Init                  procedure(CWideStr WideStr, byte bSelfCleaning = true),byte
Init                  procedure(CBStr BStr, byte bSelfCleaning = true),byte
Init                  procedure(long pBStr, byte bSelfCleaning = true, long nChars = 0, byte bFreeBStr = false),byte
IsInitialised         procedure,byte
GetCStr               procedure,*cstring
Len                   procedure,long
Release               procedure

! Protected

bSelfCleaning         byte,protected
bInitialised          byte,protected

! Private

CStr                  &cstring,private
dwBytes               long,private

                    end



CDecimal            class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure(*ClaDecAccum ClaDecimal, byte bSelfCleaning = true),byte
Init                  procedure(*_DECIMAL OLEDecimal, byte bSelfCleaning = true),byte
IsInitialised         procedure,byte
GetOLEDecimal         procedure(*_DECIMAL OLEDecimal),byte
GetClaDecimal         procedure(*decimal ClaDecimal),byte
Release               procedure

! Protected

ClaDecToOLE           procedure,byte,protected
OLEDecToCla           procedure,byte,protected

bSelfCleaning         byte,protected
bInitialised          byte,protected
bClaDecValid          byte,protected
bOLEDecValid          byte,protected

! Private

OLEDecimal            like(_DECIMAL),private
ClaDecimal            decimal(31),private

                    end


CVariant            class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,byte,virtual
Init                  procedure(*CVariant Arg),byte,virtual
Init                  procedure(*tVariant vtArg),byte,virtual
ClearVt               procedure,HRESULT,proc
GetVariantPtr         procedure,long
GetType               procedure,VARTYPE
IsInitialised         procedure,byte
Release               procedure,virtual

! Protected

bSelfCleaning         byte,protected
bInitialised          byte,protected
vtArg                 like(tVariant),protected

                    end


CSafeArray          class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure(*tVariant vtSA, byte bSelfCleaning = true),byte
Init                  procedure(*_SAFEARRAY SA, byte bSelfCleaning = true),byte
Init                  procedure(VariantQueue VtQueue, long vt = 0, long nDims = 0, byte bSelfCleaning = true),byte
EnumElements          procedure(SACallbackWrapper SAEPObj, long lParam, *_SAFEARRAY SA),HRESULT
GetElement            procedure(long x, long y, *tVariant vtElement),HRESULT
SetElement            procedure(long x, long y, *tVariant vtElement),HRESULT
GetSafeArrayPtr       procedure,long
GetVariantQueue       procedure,*VariantQueue

VariantQueueToSafeArray procedure(VariantQueue VtQueue, *_SAFEARRAY SA),byte
SafeArrayToVariantQueue procedure(VariantQueue VtQueue, *_SAFEARRAY SA),byte
ClearVariantQueue     procedure(VariantQueue VtQueue)

! Protected

ProcessArray          procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam),HRESULT,protected
EnumSingleDimArray    procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam),HRESULT,protected
EnumTwoDimArray       procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam),HRESULT,protected
OnEnumElements        procedure(*tVariant vtValue, long x, long y, byte bEndOfRow, long lParam),byte,protected,virtual

pSA                   long,protected
VtQueue               &VariantQueue,protected
bInitialised          byte,protected
bSelfCleaning         byte,protected
bNoHandler            byte,protected

                    end


CCOMIniter          class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

IsInitialised         procedure,short

! Protected

hr                    HRESULT,protected
fInitialised          bool,protected
fAlreadyInitialised   bool,protected

                    end


CCOMError           class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)
                    end


CCOMObject          class,type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

CreateInstance        procedure(long rclsid, long riid, long dwClsContext = CLSCTX_ALL),HRESULT,virtual
QueryInterface        procedure(long riid, *long ppvObject),HRESULT,virtual
AddRef                procedure(),long,virtual,proc
Release               procedure(),long,virtual,proc
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,virtual

MsgWaitMsgPump        procedure(long pHandles, long dwCount, long dwBreakEvtPos, long dwMilliseconds)
WaitMsgMsgPump        procedure
AttachConnPoint       procedure(long pInterface, long pInterfaceToConnect, long riid, *long dwCookie),HRESULT
UnattachConnPoint     procedure(long pInterface, long riid, long dwCookie),HRESULT
IsEqualIID            procedure(long riid1, long riid2),byte
IsEqualIID            procedure(long riid1, *group IIDCompare),byte

AssignPtr             procedure(long ptr),long
GetIUnknown           procedure(),long

! Protected

ProcessEvent          procedure(long hEvent),protected,virtual
AssignMethodAddr      procedure(long pInterface, long nMthd, long newptr),protected

IUnk                  &IUnknown,protected
fPreInstantiated      byte,protected

                    end


CCOMUserObject      class(CCOMObject),implements(IUnknown),type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,replace,virtual

QueryInterface        procedure(long riid, *long ppvObject),HRESULT,derived
AddRef                procedure(),long,derived,proc
Release               procedure(),long,derived,proc

! Private

cRef                  long,private

                    end


CStorage            class(CCOMObject),type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure(long grfMode = 0),HRESULT
Release               procedure(),long,derived,proc

GetStorage            procedure,*IStorage

! Protected

IStg                  &IStorage,protected
bInitialised          byte,protected

                    end


CDropTarget         class(CCOMUserObject),implements(IDropTarget),type,module('svcom.clw'),link('svcom.clw', _svLinkMode_),dll(_svDllMode_)

QueryInterface        procedure(long riid, *long ppvObject),HRESULT,derived
Register              procedure(long hWnd),HRESULT

                    end


  EndDefine

