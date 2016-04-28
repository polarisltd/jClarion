
  member

!**********************************************************************
!
!   Module:         svcom.clw
!
!
!**********************************************************************

!*
!*  Includes
!*

  include('svcom.inc'),once

!*
!*  Equates
!*

!*
!*  Declarations
!*

!SupFnc      class,link('supfnc.a', _COMLinkMode_),dll(_COMDllMode_)
!            end

!*
!*  Function Prototypes
!*

  map
    include('svapifnc.inc'),once
    module('cw runtime')
      memcpy(long lpDest, long lpSource, long nCount),long,proc,name('_memcpy')
    end
  end


CWideStr.Construct procedure

  code


CWideStr.Destruct procedure

  code
    if self.bSelfCleaning and self.IsInitialised()
      self.Release()
    end


CWideStr.Init procedure(*cstring sz, byte bSelfCleaning)

dwWideChrs  long
dwbytes     long

  code
    self.bSelfCleaning = bSelfCleaning
    dwWideChrs = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, address(sz), -1, 0, 0)
    if (dwWideChrs)
      dwBytes = dwWideChrs * 2
!      self.pWideStr = VirtualAlloc(0, dwBytes, MEM_COMMIT, PAGE_READWRITE)
      self.pWideStr = HeapAlloc(GetProcessHeap(), 0, dwBytes)
      assert(self.pWideStr)
      if (self.pWideStr)
        dwWideChrs = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, address(sz), -1, |
                                         self.pWideStr, dwWideChrs)
        if dwWideChrs
          self.dwBytes = dwBytes
        else
!          assert(VirtualFree(self.pWideStr, self.dwBytes, MEM_DECOMMIT))
          assert(HeapFree(GetProcessHeap(), 0, self.pWideStr))
        end
      end
    end
    return self.dwBytes


CWideStr.Init procedure(*string str, byte bSelfCleaning)

sz          &cstring
dwBytes     long

  code
    sz &= new cstring(len(clip(str)))
?   assert(~sz &= null)
    if ~sz &= null
      dwBytes = self.Init(sz, bSelfCleaning)
      dispose(sz)
    end
    return dwBytes


CWideStr.Init procedure(long pWideStr)

bResult         bool

  code
    assert(~self.pWideStr)
    if (~self.pWideStr)
      assert(pWideStr)
      if (pWideStr)
        self.pWideStr = pWideStr
        self.bSelfCleaning = false
        bResult = true
      end
    end
    return bResult


CWideStr.IsInitialised procedure

  code
    if self.pWideStr
      return true
    else
      return false
    end


CWideStr.GetWideStr procedure

  code
    return self.pWideStr


CWideStr.Len procedure

  code
    return self.dwBytes


CWideStr.Release procedure

  code
    if self.pWideStr
!      assert(VirtualFree(self.pWideStr, self.dwBytes, MEM_DECOMMIT))
      assert(HeapFree(GetProcessHeap(), 0, self.pWideStr))
      self.dwBytes = 0
      self.pWideStr = 0
    end


CBStr.Construct procedure

  code


CBStr.Destruct procedure

  code
    if (self.bSelfCleaning and self.IsInitialised())
      self.Release().


CBStr.Init procedure(*cstring sz, byte bSelfCleaning)

dwBytes     long
WideStr     CWideStr

  code
    self.bSelfCleaning = bSelfCleaning
    if (WideStr.Init(sz))
      dwBytes = self.Init(WideStr, bSelfCleaning)
    end
    return dwBytes


CBStr.Init procedure(*string str, byte bSelfCleaning)

dwBytes     long
WideStr     CWideStr

  code
    self.bSelfCleaning = bSelfCleaning
    if (WideStr.Init(str))
      dwBytes = self.Init(WideStr, bSelfCleaning)
    end
    return dwBytes


CBStr.Init procedure(CWideStr WideStr, byte bSelfCleaning)

BStr        long
LocWideStr  long

  code
    self.bSelfCleaning = bSelfCleaning
    LocWideStr = WideStr.GetWideStr()
    BStr = SysAllocString(LocWideStr)
    if (BStr)
      self.BStr = BStr
      self.dwBytes = WideStr.Len()
    end
    return self.dwBytes


CBStr.IsInitialised procedure

  code
    return self.BStr


CBStr.GetBStr procedure

  code
    return self.BStr


CBStr.Len procedure

  code
    return self.dwBytes


CBStr.Release procedure

  code
    if (self.BStr)
      SysFreeString(self.BStr)
      self.BStr = 0
      self.dwBytes = 0
    end


CStr.Construct procedure

  code


CStr.Destruct procedure

  code
    if (self.bSelfCleaning and self.IsInitialised())
      self.Release()
    end


CStr.Init procedure(*cstring sz, byte bSelfCleaning)

dwBytes     long

  code
    self.bSelfCleaning = bSelfCleaning
    !dwBytes = lstrlen(sz)
    dwBytes = len(sz)
    assert(dwBytes)
    if dwBytes
      self.CStr &= new cstring(dwBytes + 1)
      assert(~self.CStr &= null)
      if (~self.CStr &= null)
        if lstrcpy(address(self.CStr), address(sz))
          self.dwBytes = dwBytes
          self.bInitialised = true
        else
          dispose(self.CStr)
        end
      end
    end
    return self.dwBytes


CStr.Init procedure(CWideStr WideStr, byte bSelfCleaning)

  code
    return self.Init(WideStr.GetWideStr())


CStr.Init procedure(CBStr BStr, byte bSelfCleaning)

  code
    return self.Init(BStr.GetBStr(), true)


CStr.Init procedure(long pBStr, byte bSelfCleaning, long nChars, byte bFreeBStr)

dwBytes     long
lnChars     long
ReqLen      LONG
Written     LONG

  code
    self.bSelfCleaning = bSelfCleaning
    assert(pBStr)
    if pBStr
      if nChars
        lnChars = nChars
      else
        lnChars = -1
      end
      dwBytes = lstrlenw(pBStr)
      if dwBytes
        self.CStr &= new cstring(dwBytes + 1)
        Written = WideCharToMultiByte(0, 0, pBStr, dwBytes, address(self.CStr), dwBytes+1, 0, 0)
        assert(Written)
        if Written
          self.CStr[dwBytes + 1] = '<0>'
          self.dwBytes = dwBytes
          self.bInitialised = true
        else
          dispose(self.CStr)
        end
      end
      if bFreeBStr
        SysFreeString(pBStr).
    end
    return self.dwBytes



CStr.IsInitialised procedure

  code
    return self.bInitialised


CStr.GetCStr procedure

  code
    return self.CStr


CStr.Len procedure

  code
    return self.dwBytes


CStr.Release procedure

  code
    if (~self.CStr &= null)
      dispose(self.CStr)
      self.dwBytes = 0
      self.bInitialised = false
    end


CDecimal.Construct procedure

  code


CDecimal.Destruct procedure

  code


CDecimal.Init procedure(*ClaDecAccum ClaDecimal, byte bSelfCleaning)

  code
    return false


CDecimal.Init procedure(*_DECIMAL OLEDecimal, byte bSelfCleaning)

  code
    MoveMemory(address(self.OLEDecimal), address(OLEDecimal), size(_DECIMAL))
    self.bOLEDecValid = true
    return true


CDecimal.IsInitialised procedure

  code
    return self.bInitialised


CDecimal.GetOLEDecimal procedure(*_DECIMAL OLEDecimal)

bResult         byte

  code
    if self.IsInitialised()
    end
    return bResult


CDecimal.GetClaDecimal procedure(*decimal ClaDecimal)

bResult         byte

  code
    if ~self.bClaDecValid
      if self.bOLEDecValid
        bResult = self.OLEDecToCla()
      end
    end
    return bResult


CDecimal.Release procedure

  code


CDecimal.ClaDecToOLE procedure

bResult         byte

  code
    return bResult


CDecimal.OLEDecToCla procedure

bResult         byte
ClaDecimal      like(ClaDecAccum)
test            long
lCutOff         long
testdec         decimal(31, 31)
DecBits         long
DecBytes        long
Rem             long

  code
    ClaDecimal.sign = self.OLEDecimal.sign
    DecBits = int(3.3219280948873623478703194294894 * self.OLEDecimal.scale)
    DecBytes = DecBits / 8
    Rem = DecBits % 8
    if Rem
      DecBytes += round((Rem + 4) / 8, 1).
    ClaDecimal.low = UNIT - 1
    ClaDecimal.high = UNIT
    if DecBytes <= 16
      MoveMemory(((address(ClaDecimal.accum) + UNIT) + 1) - DecBytes, address(self.OLEDecimal.Lo64[1]), DecBytes)
    else
      MoveMemory(((address(ClaDecimal.accum) + UNIT) + 1) - DecBytes, address(self.OLEDecimal.Hi32), DecBytes)
    end
    MoveMemory(address(testdec), address(ClaDecimal), size(ClaDecAccum))
    return bResult


CVariant.Construct procedure

  code


CVariant.Destruct procedure

  code
    if (self.bSelfCleaning and self.IsInitialised())
      self.Release()
    end


CVariant.Init procedure

  code
    if self.bInitialised
      self.Release()
      self.bInitialised = false
    end
    VariantInit(self.vtArg)
    self.bInitialised = true
    return self.bInitialised


CVariant.Init procedure(CVariant Arg)

vtArg           &tVariant

  code
?   assert(~Arg &= null)
    if ~Arg &= null
      if self.Init()
        self.bInitialised = false
        vtArg &= Arg.GetVariantPtr()
        if VariantCopy(self.vtArg, vtArg) = S_OK
          self.bInitialised = true.
      end
    end
    return self.bInitialised


CVariant.Init procedure(*tVariant vtArg)

  code
?   assert(address(vtArg))
    if address(vtArg)
      if self.Init()
        self.bInitialised = false
        if VariantCopy(self.vtArg, vtArg) = S_OK
          self.bInitialised = true.
      end
    end
    return self.bInitialised


CVariant.ClearVt procedure

  code
    return VariantClear(self.vtArg)


CVariant.GetVariantPtr procedure

  code
    return address(self.vtArg)


CVariant.GetType procedure

  code
    return self.vtArg.vt


CVariant.IsInitialised procedure

  code
    return self.bInitialised


CVariant.Release procedure

  code
    self.ClearVt


!CVariantArray.Construct procedure
!
!  code
!
!
!CVariantArray.Destruct procedure
!
!  code
!
!
!CVariantArray.Init procedure(VariantQueue VtQueue)
!
!hr          HRESULT(E_FAIL)
!
!  code
!    self.VtQueue &= new VariantQueue
!?   assert(~self.VtQueue &= null)
!    if ~self.VtQueue &= null
!      if self.CopyVariantQueue(self.VtQueue, VtQueue)
!        hr = S_OK.
!    end
!    return hr
!
!
!CVariantArray.Init procedure(CVariant Arg)
!
!  code
!    if band(Arg.GetType(), VT_ARRAY) or band(Arg.GetType(), VT_SAFEARRAY)
!      if band(Arg.GetType(), VT_VARIANT)
!        return parent.Init(Arg).
!    end
!    return false
!
!
!CVariantArray.Init procedure(*tVariant vtArg)
!
!  code
!    if band(vtArg.vt, VT_ARRAY) or band(vtArg.vt, VT_SAFEARRAY)
!      if band(vtArg.vt, VT_VARIANT)
!        return parent.Init(vtArg).
!    end
!    return false
!
!
!CVariantArray.EnumElements procedure(SACallbackWrapper SAEPObj, long lParam)
!
!SA              &_SAFEARRAY
!SAObj           CSafeArray
!hr              HRESULT
!
!  code
!    if SAObj.Init(self.vtArg, false)
!      SA &= SAObj.GetSafeArrayPtr()
!      hr = SAObj.EnumElements(SAEPObj, lParam, SA)
!    end
!    return hr
!
!
!CVariantArray.GetSafeArray procedure
!
!SAObj           &CSafeArray
!
!  code
!    if ~self.VtQueue &= null
!      SAObj &= new CSafeArray
!?     assert(~SAObj &= null)
!      if ~SAObj &= null
!        if ~SAObj.Init(self.VtQueue)
!          dispose(SAObj).
!      end
!    end
!    return SAObj
!
!
!CVariantArray.Release procedure
!
!  code
!    if ~self.VtQueue &= null
!      self.EmptyVariantQueue(self.VtQueue)
!      dispose(self.VtQueue)
!    end
!    parent.Release
!
!
!CVariantArray.CopyVariantQueue procedure(VariantQueue qDest, VariantQueue qSrc, long dwTargetCols)
!
!bResult         byte(true)
!recsQSrc        long,auto
!recsCols        long,auto
!i               long,auto
!j               long,auto
!
!  code
!    recsQSrc = records(qSrc)
!    loop i = 1 to recsQSrc
!      get(qSrc, i)
!      if ~errorcode()
!        if ~qSrc.VtRow &= null
!          if dwTargetCols
!            recsCols = dwTargetCols
!          else
!            recsCols = records(qSrc.VtRow)
!          end
!          loop j = 1 to recsCols
!            get(qSrc.VtRow, j)
!            if ~errorcode()
!              qDest.VtRow &= new VariantRow
!?             assert(~qDest.VtRow &= null)
!              if ~qDest.VtRow &= null
!                if VariantCopy(qDest.VtRow.vtCol, qSrc.VtRow.vtCol) = S_OK
!                  add(qDest.VtRow)
!                  add(qDest)
!                  bResult = true
!                end
!              end
!            end
!          end
!        end
!      else
!        self.EmptyVariantQueue(qDest)
!        bResult = false
!        break
!      end
!    end
!    return bResult
!
!
!CVariantArray.EmptyVariantQueue procedure(VariantQueue VtQueue)
!
!  code


CSafeArray.Construct procedure

  code


CSafeArray.Destruct procedure

SA              &_SAFEARRAY

  code
    if self.pSA & self.bSelfCleaning
      SA &= (self.pSA)
      assert(SafeArrayDestroy(SA) = S_OK)
    end
    if ~self.VtQueue &= null
      self.ClearVariantQueue(self.VtQueue).


CSafeArray.Init procedure(*tVariant vtSA, byte bSelfCleaning)

bResult         byte
SA              &_SAFEARRAY
pvData          long

  code
?   assert(band(vtSA.vt, VT_ARRAY) or band(vtSA.vt, VT_SAFEARRAY))
    if band(vtSA.vt, VT_ARRAY) or band(vtSA.vt, VT_SAFEARRAY)
?     assert(vtSA.iVal)
      if vtSA.iVal
        if band(vtSA.vt, VT_BYREF)
          MoveMemory(address(pvData), vtSA.iVal, 4)
          SA &= (pvData)
        else
          SA &= (vtSA.iVal)
        end
        bResult = self.Init(SA, bSelfCleaning)
      end
    end
    return bResult


CSafeArray.Init procedure(*_SAFEARRAY SA, byte bSelfCleaning)

bResult         byte

  code
    self.bSelfCleaning = bSelfCleaning
    self.pSA = address(SA)
    if self.VtQueue &= null
      self.VtQueue &= new VariantQueue.
    if self.SafeArrayToVariantQueue(self.VtQueue, SA)
      bResult = true.
    bResult = true
    return bResult


CSafeArray.Init procedure(VariantQueue VtQueue, long vt, long nDims, byte bSelfCleaning)

bResult         byte
SA              &_SAFEARRAY
pSA             long
rgsabounds      like(_SAFEARRAYBOUND),dim(2)
rgsabound       &_SAFEARRAYBOUND
lvt             long
cDims           long,auto
cols            long,auto

  code
    get(VtQueue, 1)
    if ~errorcode()
      get(VtQueue.VtRow, 1)
      if ~errorcode()
        lvt = vt
        if vt = 0
          lvt = VT_VARIANT.
        rgsabounds[1].lLbound = 1
        if ~nDims
          cDims = 1
          cols = records(VtQueue.VtRow)
          if cols > 1
            cDims = 2.
        else
          cDims = nDims
        end
        rgsabounds[1].cElements = records(VtQueue)
        if cDims = 2
          rgsabounds[2].lLBound = 1
          rgsabounds[2].cElements = records(VtQueue)
        end
        rgsabound &= address(rgsabounds)
        pSA = SafeArrayCreate(lvt, cDims, rgsabound)
?       assert(pSA)
        if (pSA)
          SA &= (pSA)
          self.pSA = pSA
          bResult = self.VariantQueueToSafeArray(VtQueue, SA)
          if bResult
            self.bInitialised = true.
        end
      end
    end
    return bResult


CSafeArray.EnumElements procedure(SACallbackWrapper SAEPObj, long lParam, *_SAFEARRAY SA)

hr              HRESULT(E_FAIL)
hrSave          HRESULT,auto
bhr             byte
pvData          long

  code
    pvData = 0
    hr = SafeArrayLock(SA)
    if hr = S_OK
      hr = self.ProcessArray(SAEPObj, SA, lParam)
      if hr ~= S_OK
        hrSave = hr
        bhr = true
      end
      hr = SafeArrayUnlock(SA)
      if bhr
        hr = hrSave.
    end
    return hr


CSafeArray.GetElement procedure(long x, long y, *tVariant vtElement)

hr          HRESULT(E_FAIL)
ai          long,dim(2),auto
SA          &_SAFEARRAY

  code
    if self.pSA
      ai[1] = y
      ai[2] = x
      SA &= (self.pSA)
      hr = SafeArrayGetElement(SA, address(ai), vtElement)
    end
    return hr


CSafeArray.SetElement procedure(long x, long y, *tVariant vtElement)

hr          HRESULT(E_FAIL)
ai          long,dim(2),auto
SA          &_SAFEARRAY

  code
    if self.pSA
      ai[1] = y
      ai[2] = x
      SA &= (self.pSA)
      hr = SafeArrayPutElement(SA, address(ai), vtElement)
    end
    return hr


CSafeArray.GetSafeArrayPtr procedure

  code
    return self.pSA


CSafeArray.GetVariantQueue procedure

  code
    return self.VtQueue


CSafeArray.SafeArrayToVariantQueue procedure(VariantQueue VtQueue, *_SAFEARRAY SA)

bResult         byte
VtQueueTrans    VtQueueTransport
SAEPObj         SACallbackWrapper

  code
    self.bNoHandler = true
    VtQueueTrans.VtQueue &= VtQueue
    if self.EnumElements(SAEPObj, address(VtQueueTrans), SA) = S_OK
      bResult = true.
    self.bNoHandler = false
    return bResult


CSafeArray.VariantQueueToSafeArray procedure(VariantQueue VtQueue, *_SAFEARRAY SA)

i               long,auto
j               long,auto
rows            long,auto
cols            long,auto
bResult         byte(true)
ai              long,dim(2),auto
hr              HRESULT

  code
    get(VtQueue, 1)
    if ~errorcode()
      cols = records(VtQueue.VtRow)
      rows = records(VtQueue)
      loop j = 1 to rows
        get(VtQueue, j)
        if ~errorcode()
          loop i = 1 to cols
            get(VtQueue.VtRow, i)
            if ~errorcode()
              ai[1] = i; ai[2] = j
              hr = SafeArrayPutElement(SA, address(ai), VtQueue.VtRow.vtCol)
              if hr ~= S_OK
                bResult = false
                break
              end
            else
              bResult = false
              break
            end
          end
          if ~bResult
            break.
        else
          bResult = false
          break
        end
      end
    end
    return bResult


CSafeArray.ClearVariantQueue procedure(VariantQueue VtQueue)

rows            long,auto
cols            long,auto
i               long,auto
j               long,auto

  code
    rows = records(VtQueue)
    if rows
      loop i = 1 to rows
        get(VtQueue, 1)
        if errorcode()
          break.
        if ~VtQueue.vtRow &= null
          cols = records(VtQueue.VtRow)
          loop j = 1 to cols
            get(VtQueue.VtRow, 1)
            if errorcode()
              break.
            VariantClear(VtQueue.VtRow.vtCol)
            delete(VtQueue.VtRow)
          end
          dispose(VtQueue.VtRow)
        end
        delete(VtQueue)
      end
    end


CSafeArray.ProcessArray procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam)

hr              HRESULT(E_FAIL)

  code
    if SA.cDims = 1
      hr = self.EnumSingleDimArray(SAEPObj, SA, lParam)
    elsif SA.cDims = 2
      hr = self.EnumTwoDimArray(SAEPObj, SA, lParam)
    end
    return hr


CSafeArray.EnumSingleDimArray procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam)

hr              HRESULT(E_FAIL)
SABRow          &_SAFEARRAYBOUND
ai              long,dim(2),auto
pvData          long
vtElement       &tVariant
Element         CVariant
bCancel         byte
i               long,auto

  code
    SABRow &= SA.rgsabound
    ai[1] = 0
    loop i = SABRow.lLbound to (SABRow.lLbound + SABRow.cElements) - 1
      ai[2] = i
      hr = SafeArrayPtrOfIndex(SA, address(ai), pvData)
      if hr = S_OK
        vtElement &= (pvData)
        if ~self.bNoHandler
          bCancel = self.OnEnumElements(vtElement, ai[1], ai[2], true, lParam).
        if address(SAEPObj) and ~bCancel
          bCancel = SAEPObj.SAEnumProc(vtElement, ai[1], ai[2], true, lParam).
      else
        break
      end
      if bCancel
        break.
    end
    return hr


CSafeArray.EnumTwoDimArray procedure(SACallbackWrapper SAEPObj, *_SAFEARRAY SA, long lParam)

hr              HRESULT(E_FAIL)
SABCol          &_SAFEARRAYBOUND
SABRow          &_SAFEARRAYBOUND
pvData          long
ai              long,dim(2),auto
vtElement       &tVariant
Element         CVariant
bCancel         byte
i               long,auto
j               long,auto
bEndOfRow       byte

  code
    SABCol &= SA.rgsabound
    SABRow &= (address(SA.rgsabound) + size(_SAFEARRAYBOUND))
    loop i = 1 to SABRow.cElements
      loop j = 1 to SABCol.cElements
        ai[1] = j; ai[2] = i
        hr = SafeArrayPtrOfIndex(SA, address(ai), pvData)
        if hr = S_OK
          vtElement &= (pvData)
          if j = SABCol.cElements
            bEndOfRow = true.
          bCancel = self.OnEnumElements(vtElement, ai[1], ai[2], bEndOfRow, lParam)
          if address(SAEPObj)
            bCancel = SAEPObj.SAEnumProc(vtElement, ai[1], ai[2], bEndOfRow, lParam).
        else
          break
        end
        if bCancel
          break.
      end
    end
    return hr


CSafeArray.OnEnumElements procedure(*tVariant vtValue, long x, long y, byte bEndOfRow, long lParam)

  code
    return false


SACallbackWrapper.SAEnumProc procedure(*tVariant vtValue, long x, long y, byte bEndOfRow, long lParam)

VtQueueTrans    &VtQueueTransport
VtQueue         &VariantQueue
fAddCol         short

  code
?   assert(lParam)
    if lParam
      VtQueueTrans &= (lParam)
      VtQueue &= VtQueueTrans.VtQueue
?     assert(~VtQueue &= null)
      if ~VtQueue &= null
        get(VtQueue, y)
        if errorcode()
          clear(VtQueue)
          add(VtQueue)
          get(VtQueue, y)
          VtQueue.VtRow &= new VariantRow
        end
        get(VtQueue.VtRow, x)
        if errorcode()
          fAddCol = true.
        VariantInit(VtQueue.VtRow.vtCol)
        if VariantCopy(VtQueue.VtRow.vtCol, vtValue) = S_OK
          if fAddCol
            add(VtQueue.VtRow)
          else
            put(VtQueue.VtRow)
          end
        end
        put(VtQueue)
      end
    end
    return false


BuildWideStr procedure(long pWideStr)

WideStr         &CWideStr

  code
    assert(pWideStr)
    if pWideStr
      WideStr &= new CWideStr
      if ~WideStr.Init(pWideStr)
        dispose(WideStr).
    end
    return WideStr


CCOMIniter.Construct procedure

  code
    self.hr = CoInitialize()
    if self.hr = S_FALSE
      self.fAlreadyInitialised = true
      self.hr = S_OK
    end
    if self.hr = S_OK
      if ~self.fAlreadyInitialised
        self.fInitialised = true.
    end


CCOMIniter.Destruct procedure

  code
    if self.fInitialised
      if ~self.fAlreadyInitialised
        CoUninitialize().
      self.fInitialised = false
    end


CCOMIniter.IsInitialised procedure

fResult         short

  code
    if self.fInitialised or self.fAlreadyInitialised
      fResult = true.
    return fResult


CCOMObject.Construct procedure

  code
    self.IUnk &= null


CCOMObject.Destruct procedure

  code
    if ~self.fPreInstantiated
      self.Release()
    end


CCOMObject.CreateInstance procedure(REFCLSID rclsid, REFIID riid, long dwClsContext = CLSCTX_ALL)

hr              HRESULT
ppvObject       long

  code
    if (self.IUnk &= null)
      hr = CoCreateInstance(rclsid, 0, dwClsContext, riid, ppvObject)
      if (hr = S_OK)
        hr = OleRun(ppvObject)
        if (hr = S_OK)
          self.IUnk &= (ppvObject).
      end
    else
      hr = S_FALSE
    end
    return hr


CCOMObject.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    return self.IUnk.QueryInterface(riid, ppvObject)


CCOMObject.AddRef procedure

  code
    return self.IUnk.AddRef()


CCOMObject.Release procedure

nCnt            long

  code
    if (~self.IUnk &= null)
      nCnt = self.IUnk.Release()
      if nCnt = 0
        self.IUnk &= null.
    else
      nCnt = 0
    end
    return nCnt


CCOMObject.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = S_FALSE
    assert(pUnk)
    if (pUnk)
      assert(self.IUnk &= null)
      if (self.IUnk &= null)
        self.IUnk &= (pUnk)
        if fPreInstantiated = true
          self.fPreInstantiated = true.
        hr = S_OK
      end
    end
    return hr


CCOMObject.MsgWaitMsgPump procedure(long pHandles, long dwCount, long dwBreakEvtPos, long dwMilliseconds)

nRetVal         long
Handle          long
Mesg            like(MSG)

  code
    loop
      nRetVal = MsgWaitForMultipleObjects(dwCount, pHandles, false, dwMilliseconds, QS_ALLINPUT)
      if (nRetVal < (WAIT_OBJECT_0 + dwCount))
        peek(pHandles + nRetVal, Handle)
        ResetEvent(Handle)
        self.ProcessEvent(Handle)
        if (nRetVal = dwBreakEvtPos)
          break.
      elsif (nRetVal = WAIT_OBJECT_0 + dwCount)
        loop while(PeekMessage(address(Mesg), 0, 0, 0, PM_REMOVE))
          DispatchMessage(address(Mesg)).
      end
    end


CCOMObject.WaitMsgMsgPump procedure

bResult     bool
dwErr       long
Mesg        like(MSG)

  code
    loop
      bResult = WaitMessage()
      if (bResult)
        if (GetMessage(address(Mesg), 0, 0, 0))
          DispatchMessage(address(Mesg))
        else
          break
        end
      else
        dwErr = GetLastError()
        break
      end
    end


CCOMObject.AttachConnPoint procedure(long pInterface, long pInterfaceToConnect, REFIID riid, *long dwCookie)

hr          HRESULT,auto

IUnk        &IUnknown
pCPC        long
ICPC        &IConnectionPointContainer
pCP         long
ICP         &IConnectionPoint
ppvObject   long

  code
    IUnk &= (pInterface)
    hr = IUnk.QueryInterface(address(_IConnectionPointContainer), pCPC)
    if (hr = S_OK)
      ICPC &= (pCPC)
      assert(~ICPC &= NULL)
      if (~ICPC &= NULL)
        hr = ICPC.FindConnectionPoint(riid, pCP)
        if (hr = S_OK)
          ICP &= (pCP)
          assert(~ICP &= NULL)
          if (~ICP &= NULL)
            hr = ICP.Advise(pInterfaceToConnect, dwCookie)
            ICP.Release()
          end
        end
        ICPC.Release()
      end
    end
    return hr


CCOMObject.UnattachConnPoint procedure(long pInterface, REFIID riid, long dwCookie)

hr          HRESULT,auto

IUnk        &IUnknown
pCPC        long
ICPC        &IConnectionPointContainer
pCP         long
ICP         &IConnectionPoint
ppvObject   long

  code
    IUnk &= (pInterface)
    hr = IUnk.QueryInterface(address(_IConnectionPointContainer), pCPC)
    if (hr = S_OK)
      ICPC &= (pCPC)
      assert(~ICPC &= NULL)
      if (~ICPC &= NULL)
        hr = ICPC.FindConnectionPoint(riid, pCP)
        if (hr = S_OK)
          ICP &= (pCP)
          assert(~ICP &= NULL)
          if (~ICP &= NULL)
            hr = ICP.Unadvise(dwCookie)
            ICP.Release()
          end
        end
        ICPC.Release()
      end
    end
    return hr


CCOMObject.IsEqualIID procedure(REFIID riid1, REFIID riid2)

Guid1       like(_GUIDL)
Guid2       like(_GUIDL)

  code
    memcpy(address(Guid1), riid1, size(_GUID))
    memcpy(address(Guid2), riid2, size(_GUID))
    if (Guid1.Data1 = Guid2.Data1)
      if (Guid1.Data2 = Guid2.Data2)
        if (Guid1.Data3 = Guid2.Data3)
          if (Guid1.Data4 = Guid2.Data4)
            return true
          end
        end
      end
    end
    return false


CCOMObject.IsEqualIID procedure(REFIID riid1, *group IIDCompare)

pUnk            long

  code
    pUnk = address(IIDCompare)
    return self.IsEqualIID(riid1, pUnk)


CCOMObject.ProcessEvent procedure(long hEvent)

  code


CCOMObject.AssignPtr procedure(long ptr)

  code
    return ptr


CCOMObject.GetIUnknown procedure

  code
    return address(self.IUnk)


CCOMObject.AssignMethodAddr procedure(long pInterface, long nMthd, long newptr)

  code


CCOMUserObject.Construct procedure

  code
    self.IUnk &= address(self.IUnknown)
    self.AddRef()


CCOMUserObject.Destruct procedure

  code


CCOMUserObject.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    return self.IUnknown.QueryInterface(riid, ppvObject)


CCOMUserObject.AddRef procedure

  code
    return InterlockedIncrement(self.cRef)


CCOMUserObject.Release procedure

UserObj     &CCOMUserObject

  code
    if InterlockedDecrement(self.cRef)
      return self.cRef.
    UserObj &= self
    dispose(UserObj)
    return 0


CCOMUserObject.IUnknown.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    ppvObject = 0
    if (self.IsEqualIID(riid, address(_IUnknown)))
      ppvObject = self.GetIUnknown().
    if (ppvObject = 0)
      return E_NOINTERFACE.
    self.AddRef()
    return COM_NOERROR


CCOMUserObject.IUnknown.AddRef procedure

  code
    return self.AddRef()


CCOMUserObject.IUnknown.Release procedure

  code
    return self.Release()


CStorage.Construct procedure

  code


CStorage.Destruct procedure

  code


CStorage.Init procedure(long grfMode)

hr          HRESULT
ppstgOpen   long

  code
    hr = E_FAIL
    if grfMode = 0
      grfMode = bor(STGM_CREATE, bor(STGM_READWRITE, bor(STGM_SHARE_EXCLUSIVE, bor(STGM_DELETEONRELEASE, STGM_DIRECT)))).
    hr = StgCreateDocfile(0, grfMode, 0, ppstgOpen)
    if hr = S_OK
      self.IStg &= (ppstgOpen)
      self.IUnk &= (ppstgOpen)
      self.bInitialised = true
    end
    return hr


CStorage.Release procedure

  code
    if self.bInitialised
      return self.IStg.Release()
    else
      return 0
    end


CStorage.GetStorage procedure

  code
    return self.IStg


CDropTarget.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    ppvObject = 0
    if (self.IsEqualIID(riid, address(_IDropTarget)))
      ppvObject = address(self.IDropTarget)
      if (ppvObject = 0)
        return E_NOINTERFACE.
      self.AddRef()
      return COM_NOERROR
    else
      return parent.QueryInterface(riid, ppvObject)
    end


CDropTarget.Register procedure(HWND hWnd)

  code
    return RegisterDragDrop(hWnd, address(self.IDropTarget))


CDropTarget.IDropTarget.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    return self.QueryInterface(riid, ppvObject)


CDropTarget.IDropTarget.AddRef procedure

  code
    return self.AddRef()


CDropTarget.IDropTarget.Release procedure

  code
    return self.Release()


CDropTarget.IDropTarget.DragEnter procedure(long pDataObj, long grfKeyState, long ppt, long pdwEffect)

  code
    return 0


CDropTarget.IDropTarget.DragOver procedure(long grfKeyState, long ppt, long pdwEffect)

  code
    return 0


CDropTarget.IDropTarget.DragLeave procedure

  code
    return 0


CDropTarget.IDropTarget.Drop procedure(long pDataObj, long grfKeyState, long ppt, long pdwEffect)

  code
    return 0


QueryInterface procedure(*IUnknown IUnk, *IUnknown pInterface, *long pvObject)

pIUnk           long

  code
    pIUnk = address(pInterface)
    return IUnk.QueryInterface(pIUnk, pvObject)

