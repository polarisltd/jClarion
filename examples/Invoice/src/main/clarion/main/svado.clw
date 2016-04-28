
  member

!**********************************************************************
!
!   Module:         sv_ado.clw
!
!
!   Purpose:
!
!**********************************************************************
!**********************************************************************

!*
!*  Includes
!*

  include('svado.inc'),once

!*
!*  Equates
!*

!*
!*  Declarations
!*

!*
!*  Function Prototypes
!*

  map
    include('svapifnc.inc'),once
  end


ADOField.Construct procedure

  code
    self.Type = -1
    self.dwBlockSize = 8192


ADOField.Destruct procedure

  code
    if self.pBlob
      assert(VirtualFree(self.pBlob, self.dwBlobSize, MEM_DECOMMIT))
    end


ADOField.Attach procedure(long pUnk, byte fPreInstantiated, long bFetchProperties)

hr          HRESULT,auto

  code
    self.bFetchProperties = bFetchProperties
    hr = self.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      if self.bFetchProperties

      end
    end
    return hr


ADOField.GetValue procedure(*long pData, *gVariant vtValue, *long dwSize)

hr              HRESULT,auto
vtType          long,auto
dwActualSize    long,auto
bBlob           byte
dwTypeSize      long

  code
    dwSize = 0
!TC    hr = self.IFld20.get_Value(address(vtValue))
    hr = self.IFld20.get_Value(vtValue)
    if hr = S_OK
      if (band(vtValue.vt, VT_ARRAY) = VT_ARRAY)
        vtType = vtValue.vt - VT_ARRAY
        dwSize = self.ArrayTypeHandler(vtType)
        if dwSize <= 0
          hr = S_FALSE
        else
          bBlob = true
        end
      elsif (band(vtValue.vt, VT_BLOB) = VT_BLOB)
        bBlob = true
      end
      if bBlob
        hr = self.IFld20.get_ActualSize(dwActualSize)
        if hr = S_OK
          hr = self.ReadBlob(dwActualSize)
          if hr = S_OK
            pData = self.pBlob
            dwSize = dwActualSize
          end
        end
      end
    end
    return hr


ADOField.PutValue procedure(*gVariant vtValue, long dwSize)

hr              HRESULT,auto
vtType          long
dwElementSize   long
bBlob           bool

  code
    if (band(vtValue.vt, VT_ARRAY) = VT_ARRAY)
      vtType = vtValue.vt - VT_ARRAY
      dwElementSize = self.ArrayTypeHandler(vtType)
      if dwElementSize <= 0
        hr = S_FALSE
      else
        bBlob = true
      end
    elsif (band(vtValue.vt, VT_BLOB) = VT_BLOB)
      bBlob = true
    end
    if bBlob
      hr = self.PutBlob(vtValue.iVal, dwSize).
    return hr


ADOField._GetType procedure(*long dwDataType)

hr          HRESULT,auto

  code
    if self.Type ~= -1
      dwDataType = self.Type
      hr = S_OK
    else
      hr = self.IFld20.get_Type(dwDataType)
      if hr = S_OK
        self.Type = dwDataType.
    end
    return hr


ADOField.SetBlockReadSize procedure(long dwBlockSize)

bSuccess        byte

  code
    if dwBlockSize > 0
      self.dwBlockSize = dwBlockSize
    end
    return bSuccess


ADOField.GetBlockReadSize      procedure

  code
    return self.dwBlockSize


ADOField.ReadBlob procedure(long dwSize)

hr          HRESULT,auto
dwBlobOffs  long
vtChunk     like(tVariant)
dwBlockSize long
pvData      long
TestBlobData cstring(64)
sa          &_SAFEARRAY

  code
    dwBlockSize = self.dwBlockSize
    if self.pBlob
      assert(VirtualFree(self.pBlob, self.dwBlobSize, MEM_DECOMMIT))
      self.pBlob = 0
      self.dwBlobSize = 0
    end
    self.pBlob = VirtualAlloc(0, dwSize, MEM_COMMIT, PAGE_READWRITE)
    assert(self.pBlob)
    if (self.pBlob)
      loop
        if dwBlobOffs >= dwSize
          break.
        if (dwSize - dwBlobOffs) < self.dwBlockSize
          dwBlockSize  = (dwSize - dwBlobOffs).
        hr = self.IFld20.raw_GetChunk(dwBlockSize, address(vtChunk))
        if hr = S_OK
          sa &= (vtChunk.iVal)
          hr = SafeArrayAccessData(sa, pvData)
          if hr = S_OK
            MoveMemory(self.pBlob, pvData, dwBlockSize)
            SafeArrayUnaccessData(sa)
            SafeArrayDestroy(sa)
            sa &= null
            dwBlobOffs += dwBlockSize
          else
            break
          end
        else
          break
        end
      end
    end
    return hr


ADOField.PutBlob procedure(long pData, long dwSize)

hr          HRESULT,auto
dwBlockSize long,auto
dwBlobOffs  long
sabound     like(_SAFEARRAYBOUND)
rgsabound   long
vtBlob      like(gVariant)
pvtBlob     long
SA          &_SAFEARRAY
Offs        long
gIndices    long
pvData      long
pFunc       long
pFld        long

  code
    dwBlockSize = self.dwBlockSize
    if self.pBlob
      assert(VirtualFree(self.pBlob, self.dwBlobSize, MEM_DECOMMIT))
      self.pBlob = 0
      self.dwBlobSize = 0
    end
    assert(pData)
    if (pData)
      sabound.cElements = dwSize
      SA &= SafeArrayCreate(VT_UI1, 1, sabound)
      assert(~SA &= null)
      if ~SA &= null
        hr = SafeArrayAccessData(SA, pvData)
        if hr = S_OK
          MoveMemory(pvData, pData, dwSize)
          vtBlob.vt = bor(VT_ARRAY, VT_UI1)
          vtBlob.iVal = address(SA)
!          pvtBlob = address(vtBlob)
!          pFunc = address(self.IFld20.raw_AppendChunk)
!          pFld = address(self.IFld20)
!          Offs = PushVariant(Offs, pvtBlob)
!          Offs = PushLong(Offs, pFld)
!          hr = AdjustStackCallAndClean(Offs, pFunc)
          hr = self.IFld20.raw_AppendChunk( vtBlob )
          SafeArrayUnaccessData(SA)
        end
        SafeArrayDestroy(SA)
      end
    end
    return hr


ADOField.ArrayTypeHandler procedure(long dwType)

dwSize      long

  code
    case dwType
      of VT_I1
      orof VT_UI1
        dwSize = 1
      of VT_UI2
      of VT_I2
        dwSize = 2
      of VT_I4
      orof VT_UI4
      orof VT_INT
      orof VT_UINT
      orof VT_R4
        dwSize = 4
      of VT_R8
      orof VT_I8
      orof VT_UI8
      orof VT_I8
        dwSize = 8
    end
    return dwSize


ADOFields.GetField procedure(long dwIndex, *long hr, long bFetchProperties)

IFlds       &IFields
vtIndex     group(gVariant).
pvObject    long
ADOFld      &ADOField
Offs        long
pVt         long
pFunc       long
pFlds       long

  code
    IFlds &= address(self.IUnk)
    vtIndex.vt = VT_I4
    vtIndex.iVal = dwIndex
!    pVt = address(vtIndex)
!    pFunc = address(IFlds.get_Item)
!    pFlds = address(self.IUnk)
!    Offs = PushLong(Offs, address(pvObject))
!    Offs = PushVariant(Offs, pVt)
!    Offs = PushLong(Offs, pFlds)
!    hr = AdjustStackCallAndClean(Offs, pFunc)
    hr = IFlds.get_Item( vtIndex, pvObject )
    if hr = S_OK
      ADOFld &= new ADOField
      assert(~ADOFld &= null)
      if (~ADOFld &= null)
        if bFetchProperties
          hr = ADOFld.Attach(pvObject, false, true)
        else
          hr = ADOFld.Attach(pvObject, false, false)
        end
        if hr ~= S_OK
          dispose(ADOFld).
      end
    end
    return ADOFld


ADOBlob.Construct procedure

  code


ADOBlob.Destruct procedure

  code


ADOBlob.InsertBlob procedure(*ADOField ADOFld, *cstring szFileName)

  code
    return S_FALSE


ADOBlob.InsertBlob procedure(*ADOField ADOFld, long pBlob)

  code
    return S_FALSE


ADOBlob.InsertBlob procedure(*ADOResultset ADORst, *cstring szFieldName, *cstring szFileName)

  code
    return S_FALSE


ADOBlob.InsertBlob procedure(*ADOResultset ADORst, *cstring szFieldName, long pBlob)

  code
    return S_FALSE


ADOBlob.GetBlob procedure(*ADOField ADOFld, *cstring szOutFileName)

  code
    return S_FALSE


ADOBlob.GetBlob procedure(*ADOField ADOFld, *long pBlob)

  code
    return S_FALSE


ADOBlob.GetBlob procedure(*ADOResultset ADORst, *cstring szFieldName, *cstring szOutFileName)

  code
    return S_FALSE


ADOBlob.GetBlob procedure(*ADOResultset ADORst, *cstring szFieldName, *long szOutFileName)

  code
    return S_FALSE


ADOResultSet.SetCacheSettings procedure(long dwPageSize, long dwPages)

hr          HRESULT,auto

  code
    hr = self.IRst.put_CacheSize(dwPages * dwPageSize)
    if hr = S_OK
      hr = self.IRst.put_PageSize(dwPageSize)
      if hr = S_OK
        self.dwPages = dwPages
        self.dwPageSize = dwPageSize
      end
    end
    return hr


ADOResultSet.GetCacheSettings procedure(*long dwPageSize, *long dwPages)

hr          HRESULT,auto
dwCacheSize long

  code
    if self.dwPages
      dwPages = self.dwPages
      dwPageSize = self.dwPageSize
      hr = S_OK
    else
      hr = self.IRst.get_CacheSize(dwCacheSize)
      if hr = S_OK
        hr = self.IRst.get_PageSize(dwPageSize)
        if hr = S_OK
          dwPages = dwCacheSize / dwPageSize
          self.dwPages = dwPages
          self.dwPageSize = dwPageSize
        end
      end
    end
    return hr


ADOResultSet.Bof procedure(*short bBof)

  code
    return self.IRst.get_BOF(bBof)


ADOResultSet.Eof procedure(*short bEof)

  code
    return self.IRst.get_adoEOF(bEof)


ADOResultSet.GetFields procedure(*long hr)

pvObject        long
ADOFlds         &ADOFields

  code
    hr = self.IRst.get_Fields(pvObject)
    if hr = S_OK and pvObject
      ADOFlds &= new ADOFields
      assert(~ADOFlds &= null)
      if (~ADOFlds &= null)
        hr = ADOFlds.Attach(pvObject)
        if hr ~= S_OK
          dispose(ADOFlds).
      end
    end
    return ADOFlds


ADOResultSet.Collect procedure(long FieldOrdinal, *gVariant vtOutValue)

hr          HRESULT
Offs        long
vtIndex     group(gVariant).
pFunc       long
pRst        long

  code
    vtIndex.vt = VT_INT
    vtIndex.iVal = FieldOrdinal
!    pFunc = address(self.IRst15.get_Collect)
!    pRst = address(self.IRst15)
!    Offs = PushLong(Offs, address(vtOutValue))
!    Offs = PushVariant(Offs, address(vtIndex))
!    Offs = PushLong(Offs, pRst)
!    hr = AdjustStackCallAndClean(Offs, pFunc)
!    return hr
  return self.iRst15.get_Collect( vtIndex, vtOutValue )


ADOResultSet.Collect procedure(*cstring szFieldName, *gVariant vtOutValue)

hr          HRESULT
bstrIndex   CBStr
Offs        long
vtIndex     group(gVariant).
pFunc       long
pRst        long

  code
    assert(bstrIndex.Init(szFieldName))
    vtIndex.vt = VT_BSTR
    vtIndex.iVal = bstrIndex.GetBStr()
!    pFunc = address(self.IRst15.get_Collect)
!    pRst = address(self.IRst15)
!    Offs = PushLong(Offs, address(vtOutValue))
!    Offs = PushVariant(Offs, address(vtIndex))
!    Offs = PushLong(Offs, pRst)
!    hr = AdjustStackCallAndClean(Offs, pFunc)
    hr = self.iRst15.get_Collect( vtIndex, vtOutValue )
    bstrIndex.Release()
    return hr


ADOResultSet.NextResultset procedure(*long dwRecordsAffected, *long hr)

vtRecordsAffected   like(gVariant)
ADORecords          &CRecordSet
pvRst               long

  code
    hr = self.IRst15.raw_NextRecordset(vtRecordsAffected, pvRst)
    if hr = S_OK and pvRst
      ADORecords &= new CRecordSet
      assert(~ADORecords &= null)
      if (~ADORecords &= null)
        hr = ADORecords.Attach(pvRst)
        if hr ~= S_OK
          dispose(ADORecords).
      end
    else
      message(vtRecordsAffected.iVal)
    end
    return ADORecords


ADOResultSet.InsertRow procedure

Offs        long
pFunc       long
pRst        long

  code
!    pFunc = address(self.IRst15.raw_AddNew)
!    pRst = address(self.IRst15)
!    Offs = PushVariant(Offs, address(vtMissing))
!    Offs = PushVariant(Offs, address(vtMissing))
!    Offs = PushLong(Offs, pRst)
!    return AdjustStackCallAndClean(Offs, pFunc)
  return self.iRst15.raw_AddNew( vtMissing, vtMissing )


ADOManager.Construct procedure

  code
    self.bInitialised = true


ADOManager.Destruct procedure

  code


ADOManager.Connect procedure(*cstring szConnectStr, *cstring szUID, *cstring szPWD, *HRESULT hr)

Conn        &ADOConnection

  code
    if (self.bInitialised)
      Conn &= new ADOConnection
      if (~Conn &= NULL)
        hr = Conn.Init()
        if (hr ~= S_OK)
          dispose(Conn)
          Conn &= NULL
        else
          hr = Conn.Connect(szConnectStr, szUID, szPWD)
          if hr ~= S_OK
            dispose(Conn)
            Conn &= null
          end
        end
      end
    end
    return Conn


ADOManager.Disconnect procedure(*ADOConnection ADOConn, bool bDispose)

hr          HRESULT,auto
locADOConn  &ADOConnection

  code
    hr = ADOConn.Disconnect()
    if (bDispose)
      locADOConn &= ADOConn
      dispose(locADOConn)
    end
    return hr
    
    
CWRecordset.Construct procedure

  code
    self.Grp &= null
    self.Q &= null
    self.Mapper &= new(TableMapper)
    assert(~self.Mapper &= null)
    
    
CWRecordset.Destruct  procedure

  code
    if ~(self.Mapper &= null)
      dispose(self.Mapper)
    end  
    
    
CWRecordset.Attach    procedure(long pUnk, *group pGrp, byte fPreInstantiated = false)

hr      HRESULT

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.Grp &= pGrp
      self.Mapper.MapRSToGroup(self, self.Grp)
    end
    return(hr)
    
    
CWRecordset.Attach    procedure(long pUnk, *queue pQ, byte fPreInstantiated = false)    

hr      HRESULT

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.Q &= pQ
      self.Mapper.MapRSToGroup(self, self.Q)
    end
    return(hr)
    
    
CWRecordset.Find      procedure(*cstring szCriteria, long SkipRecords, long SearchDirection, *gVariant vtStart)

hr      HRESULT

  code
    hr = parent.Find(szCriteria, SkipRecords, SearchDirection, vtStart)
    if hr = S_OK
      self.Map()
    end
    return(hr)
       
    
CWRecordset.Init      procedure(*group pGrp)

hr          HRESULT

  code
    self.grp &= pGrp
    hr = self.Init()
    return(hr)
    
CWRecordset.Init      procedure(*queue pQ)

hr          HRESULT

  code
    self.Q &= pQ
    hr = self.Init()
    return(hr)
    
    
CWRecordset.Open      procedure(*cstring szSource, *CConnection Conn, long CursorType, long LockType, long Options)

hr    HRESULT

  code
    if self.Grp &= null and self.Q &= null
      hr = S_FALSE
    else  
      hr = parent.Open(szSource, Conn, CursorType, lockType, Options)
      if hr = S_OK
        if ~self.Grp &= null
          self.Mapper.MapRSToGroup(self, self.Grp)
        else
          self.Mapper.MapRSToGroup(self, self.Q)
        end
      end
    end
    return(hr)    


CWRecordset.Open      procedure(*cstring szSource, *cstring szConnection, long CursorType, long LockType, long Options)

hr    HRESULT

  code
    if self.Grp &= null and self.Q &= null
      hr = S_FALSE
    else  
      hr = parent.Open(szSource, szConnection, CursorType, lockType, Options)
      if hr = S_OK
        if ~self.Grp &= null
          self.Mapper.MapRSToGroup(self, self.Grp)
        else
          self.Mapper.MapRSToGroup(self, self.Q)
        end
      end
    end
    return(hr)
    
    
CWRecordset.Map     procedure()

  code
    self.Mapper.MapRSToGroup(self)      
    
    
CWRecordset.Move    procedure(long NumRecords, *gVariant vtStart)

hr    HRESULT

  code
    hr = parent.Move(NumRecords, vtStart)
    if hr = S_OK
      self.Map()  
    end
    return(hr)
    
CWRecordset.MoveNext  procedure()

hr    HRESULT     

  code
    hr = parent.MoveNext()
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
CWRecordset.MovePrevious  procedure()

hr      HRESULT

  code
    hr = parent.MovePrevious()
    if hr = S_Ok
      self.Map()
    end
    return(hr)
    
    
CWRecordset.MoveFirst   procedure()

hr      HRESULT

  code
    hr = parent.MoveFirst()
    if hr = S_OK
      self.Map()
    end
    return(hr)


CWRecordset.MoveLast    procedure()

hr      HRESULT

  code
    hr = parent.MoveLast()
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
CWRecordset.PutAbsolutePosition   procedure(long lPos)

hr      HRESULT

  code
    hr = parent.PutAbsolutePosition(lPos)
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
CWRecordset.PutBookmark           procedure(*gVariant vtBookmark)

hr      HRESULT

  code
    hr = parent.PutBookmark(vtBookmark)
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
CWRecordset.PutFilter             procedure(*gVariant vtCriteria)

hr      HRESULT

  code
    hr = parent.PutFilter(vtCriteria)
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
CWRecordset.PutSort            procedure(*cstring szCriteria)

hr      HRESULT

  code
    hr = parent.PutSort(szCriteria)
    if hr = S_OK
      self.Map()
    end
    return(hr)
    
    
