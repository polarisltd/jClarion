
  member


!*
!*  Includes
!*

  include('svbase.inc'),once

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


CConnectionEvents.Construct procedure

  code
    self.IUnk &= address(self.IConnectionEventsVt)


CConnectionEvents.Destruct procedure

  code


CConnectionEvents.QueryInterface procedure(long riid, *long ppvObject)

  code
    return self.IConnectionEventsVt.QueryInterface(riid, ppvObject)


CConnectionEvents.InfoMessage procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.BeginTransComplete procedure(long TransactionLevel, *IError Error, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.CommitTransComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.RollbackTransComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.WillExecute procedure(*long bstrSource, *long CursorType, *long LockType, *long Options, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.ExecuteComplete procedure(long RecordsAffected, *IError Error, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.WillConnect procedure(*long bstrConnectionString, *long bstrUserID, *long bstrPassword, *long Options, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.ConnectComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.Disconnect procedure(*long adStatus, *_IConnection Connection)

  code
    adStatus = adStatusOK
    return S_OK


CConnectionEvents.IConnectionEventsVt.QueryInterface procedure(long riid, *long ppvObject)

  code
    ppvObject = 0
    if (self.IsEqualIID(riid, address(_IUnknown)) or self.IsEqualIID(riid, address(ConnectionEventsVt)))
      ppvObject = self.GetIUnknown().
    if (ppvObject = 0)
      return E_NOINTERFACE.
    self.AddRef()
    return COM_NOERROR


CConnectionEvents.IConnectionEventsVt.AddRef procedure

  code
    return self.AddRef()


CConnectionEvents.IConnectionEventsVt.Release procedure

  code
    return self.Release()


CConnectionEvents.IConnectionEventsVt.InfoMessage procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    return self.InfoMessage(Error, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.BeginTransComplete procedure(long TransactionLevel, *IError Error, *long adStatus, *_IConnection Connection)

  code
    return self.BeginTransComplete(TransactionLevel, Error, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.CommitTransComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    return self.CommitTransComplete(Error, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.RollbackTransComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    return self.RollbackTransComplete(Error, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.WillExecute procedure(*long bstrSource, *long CursorType, *long LockType, *long Options, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection)

  code
    return self.WillExecute(bstrSource, CursorType, LockType, Options, adStatus, Command, Recordset, Connection)


CConnectionEvents.IConnectionEventsVt.ExecuteComplete procedure(long RecordsAffected, *IError Error, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection)

  code
    return self.ExecuteComplete(RecordsAffected, Error, adStatus, Command, Recordset, Connection)


CConnectionEvents.IConnectionEventsVt.WillConnect procedure(*long bstrConnectionString, *long bstrUserID, *long bstrPassword, *long Options, *long adStatus, *_IConnection Connection)

  code
    return self.WillConnect(bstrConnectionString, bstrUserID, bstrPassword, Options, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.ConnectComplete procedure(*IError Error, *long adStatus, *_IConnection Connection)

  code
    return self.ConnectComplete(Error, adStatus, Connection)


CConnectionEvents.IConnectionEventsVt.Disconnect procedure(*long adStatus, *_IConnection Connection)

  code
    return self.Disconnect(adStatus, Connection)


CRecordsetEvents.Construct procedure

  code
    self.IUnk &= address(self.IRecordsetEventsVt)


CRecordsetEvents.Destruct procedure

  code


CRecordsetEvents.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    return self.IRecordsetEventsVt.QueryInterface(riid, ppvObject)


CRecordsetEvents.WillChangeField procedure(long dwFields, variant vtFields, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.FieldChangeComplete procedure(long dwFields, variant vtFields, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.WillChangeRecord procedure(long adReason, long dwRecords, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.RecordChangeComplete procedure(long adReason, long dwRecords, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.WillChangeRecordset procedure(long adReason, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.RecordsetChangeComplete procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.WillMove procedure(long adReason, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.MoveComplete procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.EndOfRecordset procedure(*long pfMoreData, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.FetchProgress procedure(long Progress, long MaxProgress, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.FetchComplete procedure(*IError Error, *long adStatus, *_IRecordset Recordset)

  code
    adStatus = adStatusOK
    return S_OK


CRecordsetEvents.IRecordsetEventsVt.QueryInterface procedure(REFIID riid, *long ppvObject)

  code
    ppvObject = 0
    if (self.IsEqualIID(riid, address(_IUnknown)) or self.IsEqualIID(riid, address(RecordsetEventsVt)))
      ppvObject = self.GetIUnknown().
    if (ppvObject = 0)
      return E_NOINTERFACE.
    self.AddRef()
    return COM_NOERROR


CRecordsetEvents.IRecordsetEventsVt.AddRef procedure

  code
    return self.AddRef()


CRecordsetEvents.IRecordsetEventsVt.Release procedure

  code
    return self.Release()


CRecordsetEvents.IRecordsetEventsVt.WillChangeField procedure(long dwFields, variant vtFields, *long adStatus, *_IRecordset Recordset)

  code
    return self.WillChangeField(dwFields, vtFields, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.FieldChangeComplete procedure(long dwFields, variant vtFields, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    return self.FieldChangeComplete(dwFields, vtFields, Error, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.WillChangeRecord procedure(long adReason, long dwRecords, *long adStatus, *_IRecordset Recordset)

  code
    return self.WillChangeRecord(adReason, dwRecords, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.RecordChangeComplete procedure(long adReason, long dwRecords, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    return self.RecordChangeComplete(adReason, dwRecords, Error, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.WillChangeRecordset procedure(long adReason, *long adStatus, *_IRecordset Recordset)

  code
    return self.WillChangeRecordset(adReason, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.RecordsetChangeComplete procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    return self.RecordsetChangeComplete(adReason, Error, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.WillMove procedure(long adReason, *long adStatus, *_IRecordset Recordset)

  code
    return self.WillMove(adReason, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.MoveComplete procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset)

  code
    return self.MoveComplete(adReason, Error, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.EndOfRecordset procedure(*long pfMoreData, *long adStatus, *_IRecordset Recordset)

  code
    return self.EndOfRecordset(pfMoreData, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.FetchProgress procedure(long Progress, long MaxProgress, *long adStatus, *_IRecordset Recordset)

  code
    return self.FetchProgress(Progress, MaxProgress, adStatus, Recordset)


CRecordsetEvents.IRecordsetEventsVt.FetchComplete procedure(*IError Error, *long adStatus, *_IRecordset Recordset)

  code
    return self.FetchComplete(Error, adStatus, Recordset)


CADO.Construct procedure

  code


CADO.Destruct procedure

  code


CADO.GetProperties procedure(*long hr)

pvObject    long
Properties  &CProperties

  code
    hr = self.IADOInt.get_Properties(pvObject)
    if hr = S_OK and pvObject
      Properties &= new CProperties
      assert(~Properties &= null)
      if (~Properties &= null)
        hr = Properties.Attach(pvObject)
        if hr ~= S_Ok
          dispose(Properties)
        end  
      end
    end
    return Properties
    
    
CADO.Attach procedure(long pUnk, byte fPreInstantiated)
  
hr     HRESULT, auto      

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IADOInt &= address(self.IUnk)
    end
    return hr

CCollection.Construct procedure

  code


CCollection.Destruct procedure

  code
  self.Release()


CCollection.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.ICol &= address(self.IUnk)
    end
    return hr


CCollection.GetCount procedure(*long Count)

  code
    return self.ICol.get_Count(Count)


CCollection.NewEnum procedure(*long pvObject)

  code
    return self.ICol.NewEnum(pvObject)


CCollection.Refresh procedure

  code
    return self.ICol.Refresh()


CDynaCollection.Construct procedure

  code


CDynaCollection.Destruct procedure

  code
  self.Release()

CDynaCollection.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IDynCol &= address(self.IUnk)
    end
    return hr


CDynaCollection._Append procedure(*IDispatch Object)

  code
    return self.IDynCol._Append(Object)


CDynaCollection.Delete procedure(gVariant vtIndex)

  code
    return self.IDynCol.Delete(vtIndex)


CError.Construct procedure

  code


CError.Destruct procedure

  code
  self.Release()

CError.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IErr &= address(self.IUnk)
    end
    return hr


CError.Number procedure(*long lErr)

  code
    return self.IErr.get_Number(lErr)


CError.Source procedure(*long hr)

pbstr       long
sz          &CStr

  code
    hr = self.IErr.get_Source(pbstr)
    if hr = S_OK
      sz &= new CStr
      assert(~sz &= null)
      if (~sz &= null)
        assert(sz.Init(pbstr, true)).
      SysFreeString(pbstr)
    end
    return sz


CError.Description procedure(*long hr)

pbstr       long
sz          &CStr

  code
    hr = self.IErr.get_Description(pbstr)
    if hr = S_OK
      sz &= new CStr
      assert(~sz &= null)
      if (~sz &= null)
        assert(sz.Init(pbstr, true)).
      SysFreeString(pbstr)
    end
    return sz


CError.HelpFile procedure(*long hr)

pbstr       long
sz          &CStr

  code
    hr = self.IErr.get_HelpFile(pbstr)
    if hr = S_OK
      sz &= new CStr
      assert(~sz &= null)
      if (~sz &= null)
        assert(sz.Init(pbstr, true)).
      SysFreeString(pbstr)
    end
    return sz


CError.HelpContext procedure(*long lHCtxt)

  code
    return self.IErr.get_HelpContext(lHCtxt)


CError.SQLState procedure(*string s)

bstrSQLState    bstring
hr      HRESULT

  code
    hr = self.IErr.get_SQLState(bstrSQLState)
    if hr = S_OK
      s = bstrSQLState
    end  
    return hr


CError.NativeError procedure(*long lErr)

  code
    return self.IErr.get_NativeError(lErr)


CErrors.Construct procedure

  code


CErrors.Destruct procedure

  code
  self.Release()

CErrors.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IErrs &= address(self.IUnk)
    end
    return hr


CErrors.Error procedure(long dwIndex, *long hr)

ADOErr          &CError
ppvObject       long
vtIndex         like(gVariant)

  code
    vtIndex.vt = VT_I4
    vtIndex.lVal = dwIndex
    hr = self.IErrs.get_Item(vtIndex, ppvObject)
    if (hr = S_OK and ppvObject)
      ADOErr &= new CError
      assert(~ADOErr &= null)
      if (~ADOErr &= null)
        hr = ADOErr.Attach(ppvObject)
        if (hr ~= S_OK)
          dispose(ADOErr)
          ADOErr &= null
        end
      end
    end
    return ADOErr


CErrors.ClearError procedure

  code
    return self.IErrs.raw_Clear()


CProperty.Construct procedure

  code


CProperty.Destruct procedure

  code
  self.Release()

CProperty.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IProp &= address(self.IUnk)
    end
    return hr

    
CProperty.GetValue procedure(*gVariant vtValue)

  code
    return self.IProp.get_Value(vtValue)


CProperty.PutValue procedure(gVariant vtValue)

  code
    return self.IProp.put_Value(vtValue)



CProperty.GetName procedure(*bstring pBstr)

  code
    return self.IProp.get_Name(pbstr)


CProperty.GetType procedure(*long ptype)

  code
    return self.IProp.get_Type(ptype)


CProperty.GetAttributes procedure(*long lAttributes)

  code
    return self.IProp.get_Attributes(lAttributes)


CProperty.PutAttributes procedure(long lAttributes)

  code
    return self.IProp.put_Attributes(lAttributes)


CProperties.Construct procedure

  code


CProperties.Destruct procedure

  code
  self.Release()


CProperties.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IProps &= address(self.IUnk)
    end
    return hr


CProperties.GetItem procedure(long dwIndex, *long hr)

Property        &CProperty
ppvObject       long
aVariant        like(gVariant)
tmpVariant      variant, over(aVariant)

  code
    tmpVariant = dwIndex
    hr = self.IProps.get_Item(aVariant, ppvObject)
    if hr = S_OK
      Property &= new CProperty
      hr = Property.Attach(ppvObject)
      if hr ~= S_OK
        dispose(Property).
    end
    return Property
    
    
CProperties.GetItem procedure(*cstring szName, *long hr)

Property        &CProperty
ppvObject       long
aVariant        like(gVariant)
tmpVariant      variant, over(aVariant)

  code
    tmpVariant = szName
    hr = self.IProps.get_Item(aVariant, ppvObject)
    if hr = S_OK
      Property &= new CProperty
      hr = Property.Attach(ppvObject)
      if hr ~= S_OK
        dispose(Property).
    end
    return Property
    
    
CProperties.GetItem procedure(*string sName, *long hr)

Property        &CProperty
ppvObject       long
aVariant        like(gVariant)
tmpVariant      variant, over(aVariant)

  code
    tmpVariant = sName
    hr = self.IProps.get_Item(aVariant, ppvObject)
    if hr = S_OK
      Property &= new CProperty
      hr = Property.Attach(ppvObject)
      if hr ~= S_OK
        dispose(Property).
    end
    return Property
    



CCommand15.Construct procedure

  code


CCommand15.Destruct procedure

  code


CCommand15.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Command), address(Command15))
    if (hr = S_OK)
      self.ICmd15 &= address(self.IUnk)
      if (hr = S_OK)
        self.bInitialised = true.
    end
    return hr


CCommand15.GetActiveConnection procedure(*long hr)

rConn       &CConnection
pvObject    long

  code
    rConn &= null
    hr = self.ICmd15.get_ActiveConnection(pvObject)
    if hr = S_OK and pvObject
      rConn &= new(CConnection)
      if ~(rConn &= null)
        hr = rConn.attach(pvObject)
        if hr <> S_OK
          dispose(rConn)
          rConn &= null
        end  
      end
    end  
    return rConn


CCommand15.PutRefActiveConnection procedure(*CConnection Conn)

tmpConn     &_IConnection
vtConn      LIKE(gVariant),AUTO
hr      HRESULT

  code
    tmpConn &= Conn.GetConnection()
    assert(~tmpConn &= null)
    if (~tmpConn &= null)
      hr = tmpConn.QueryInterface(address(_IUnknown), vtConn.lval)
      if hr = S_OK
        assert(vtConn.lVal)
        vtConn.vt = VT_DISPATCH
        hr = self.ICmd15.put_ActiveConnection(vtConn)
        tmpConn.Release()
      end
    end  
    return(hr)
   

CCommand15.PutActiveConnection procedure(*gVariant vtppvObject)

  code
    return self.ICmd15.put_ActiveConnection(vtppvObject)


CCommand15.GetCommandText procedure(*long hr)

bstrText   bstring

  code
    hr = self.ICmd15.get_CommandText(bstrText)
    return(bstrText)
    !return null


CCommand15.PutCommandText procedure(*cstring szCmdText)

!bstrCmd   &CBstr
bstrCmd    bstring
hr    HRESULT

  code
    !bstrCmd &= new(CBstr)
    bstrCmd = szCmdText
    !if ~bstrCmd &= null
    !  if bstrCmd.Init(szCmdText).
      !hr = self.ICmd15.put_CommandText(bstrCmd.GetBstr())
      hr = self.ICmd15.put_CommandText(bstrCmd)
    !  dispose(bstrCmd)
    !end
    return hr
    
CCommand15.PutCommandText procedure(string szCmdText)

!bstrCmd   &CBstr
bstrCmd    bstring
hr    HRESULT

  code
    !bstrCmd &= new(CBstr)
    bstrCmd = szCmdText
    !if ~bstrCmd &= null
    !  if bstrCmd.Init(szCmdText).
      !hr = self.ICmd15.put_CommandText(bstrCmd.GetBstr())
      hr = self.ICmd15.put_CommandText(bstrCmd)
    !  dispose(bstrCmd)
    !end
    return hr
    


CCommand15.GetCommandTimeout procedure(*long lTimeout)

  code
    return self.ICmd15.get_CommandTimeout(lTimeout)


CCommand15.PutCommandTimeout procedure(long lTimeout)

  code
    return self.ICmd15.put_CommandTimeout(lTimeout)


CCommand15.GetPrepared procedure(*short fPrepared)

  code
    return self.ICmd15.get_Prepared(fPrepared)


CCommand15.PutPrepared procedure(short fPrepared)

  code
    return self.ICmd15.put_Prepared(fPrepared)


CCommand15._Execute procedure(*long vtRecordsAffected, *gVariant vtParameters, long Options, *long hr)

gVarRec     like(gVariant)
VarRec      variant, over(gVarRec)
pvObject    long
rRst        &CRecordset

  code
    rRst &= null
    hr = self.ICmd15.raw_Execute(gVarRec, vtParameters, Options, pvObject)
    if hr = S_Ok and pvObject
      vtRecordsAffected = VarRec
      rRst &= new(CRecordset)
      if ~(rRst &= null)
        hr = rRst.Attach(pvObject)
        if hr <> S_OK
          dispose(rRst)
          rRst &= null
        end  
      end
    end
    return rRst
    
CCommand15._Execute procedure(<*long lRecordsAffected>, *long hr)

vMissing  like(gVariant)
pvObject  long

rRst      &CRecordset

gVarRec   like(gVariant)
VarRec    variant, over(gVarRec)

  code
  rRst &= null
  vMissing.vt = VT_ERROR
  vMissing.lVal = DISP_E_PARAMNOTFOUND
  hr = self.ICmd15.raw_Execute(gVarRec, vMissing, -1, pvObject)
  if ~omitted(2)
    if hr = S_OK
      lRecordsAffected = VarRec  
    end
  end  
  if hr = S_OK and pvObject
    rRSt &= new(CRecordset)
    if ~(rRst &= null)
      hr = rRst.Attach(pvObject)
      if hr <> S_OK
        dispose(rRst)
        rRst &= null
      end  
    end
  end
  return rRst


CCommand15.CreateParameter procedure(*cstring szName, long dwType, long dwDirection, long dwSize, gVariant vtValue, *long hr)

bstrName    bstring
ppvObject   long
Parameter   &CParameter

  code
    bstrName = szName
    hr = self.ICmd15.raw_CreateParameter(bstrName, dwType, dwDirection, dwSize, vtValue, ppvObject)
    if hr = S_OK and ppvObject
      Parameter &= new(CParameter)
      if ~(Parameter &= null)
        hr = Parameter.Attach(ppvObject)
        if hr <> S_OK
          dispose(Parameter)
        end
      end  
    end
    return Parameter


CCommand15.GetParameters procedure(*long hr)

CParams     &CParameters
ppvObject   long


  code
    hr = self.ICmd15.get_Parameters(ppvObject)
    if hr = S_OK and ppvObject
      CParams &= new(CParameters)
      if ~(Cparams &= null)
        hr = CParams.Attach(ppvobject)
        if hr <> S_OK
          dispose(CParams)
          CParams &= null
        end
      end
    end
    return CParams


CCommand15.PutCommandType procedure(long lCmdType)

  code
    return self.ICmd15.put_CommandType(lCmdType)


CCommand15.GetCommandType procedure(*long lCmdType)

  code
    return self.ICmd15.get_CommandType(lCmdType)


CCommand15.GetName procedure(*long hr)

bstrName    bstring

  code
    hr = self.ICmd15.get_Name(bstrName)
    return bstrName


CCommand15.PutName procedure(*cstring szName)

bstrName    bstring

  code
    bstrName = szName
    return self.ICmd15.put_Name(bstrName)


CCommand.Construct procedure

  code


CCommand.Destruct procedure

  code
  self.Release()


CCommand.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Command), address(_Command))
    if (hr = S_OK)
      self.ICmd15 &= address(self.IUnk)
      self.ICmd &= address(self.IUnk)
      if (hr = S_OK)
        self.bInitialised = true.
    end
    return hr


CCommand.GetState procedure(*long lObjState)

  code
    return self.ICmd.get_State(lObjState)


CCommand.Cancel procedure

  code
    return self.ICmd.raw_Cancel()


CField15.Construct procedure

  code


CField15.Destruct procedure

  code


CField15.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFld15 &= address(self.IUnk)
    end
    return hr
    
    
CField15.GetActualSize  procedure(*long pl)

  code
    return self.IFld15.get_ActualSize(pl)
    
    
CField15.GetAttributes  procedure(*long pl)

  code
    return self.IFld15.get_Attributes(pl)
    

CField15.GetDefinedSize procedure(*long pl)

  code
    return self.IFld15.get_DefinedSize(pl)
    
    
CField15.GetName    procedure(*cstring szName)

bstrName  bstring
hr    HRESULT

  code
    hr = self.IFld15.get_Name(bstrName)
    if hr = S_OK
      szName = bstrName
    end
    return(hr)
    

CField15.GetType    procedure(*long pDataType)

  code
    return self.IFld15.get_Type(pDataType)
!get_Value                     procedure(*long pvtVar),HRESULT,pascal
!put_Value                     procedure(variant pvar),HRESULT,pascal
!get_Precision                 procedure(*byte pbPrecision),HRESULT,pascal
!get_NumericScale              procedure(*byte pbNumericScale),HRESULT,pascal
!raw_AppendChunk               procedure(variant vtData),HRESULT,pascal
!raw_GetChunk                  procedure(long dwLength, *long pvtVar),HRESULT,pascal
!get_OriginalValue             procedure(*long pvtVar),HRESULT,pascal
!get_UnderlyingValue           procedure(*long pvtVar),HRESULT,pascal
    


CField20.Construct procedure

  code


CField20.Destruct procedure

  code


CField20.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFld20 &= address(self.IUnk)
    end
    return hr


CField20.GetActualSize procedure(*long l)

  code
    return self.IFld20.get_ActualSize(l)


CField20.GetAttributes procedure(*long l)

  code
    return self.IFld20.get_Attributes(l)


CField20.GetDefinedSize procedure(*long l)

  code
    return self.IFld20.get_DefinedSize(l)


CField20.GetName procedure(*long hr)

pbstr       long
bstr        bstring
sz          &CStr
szTemp      &cstring

  code
    hr = self.IFld20.get_Name(bstr)
    if hr = S_OK
      szTemp &= new(cstring(len(bstr) + 1))
      if ~szTemp &= null
        szTemp = bstr
      end  
      sz &= new CStr
      assert(~sz &= null)
      if (~sz &= null)
        assert(sz.Init(szTemp, true)).
        dispose(szTemp)
      !SysFreeString(pbstr)
    end
   return sz
    
CField20.GetName  procedure(*bstring bstrName)

  code
    return self.IFld20.get_name(bstrName)    


CField20.GetType procedure(*long DataType)

  code
    return self.IFld20.get_Type(DataType)


CField20.GetValue procedure(*gVariant vtVar)

  code
!TC    return self.IFld20.get_Value(address(vtVar))
    return self.IFld20.get_Value(vtVar)
    
!CField20.GetValue  procedure(long vVar)

!  code
    !return self.IFld20.get_Value(vVar)

CField20.PutValue procedure(gVariant vtVar)

hr          HRESULT

  code
    return self.IFld20.put_Value(vtVar)


CField20.GetPrecision procedure(*byte bPrecision)

  code
  return self.iFld20.get_Precision( bPrecision )


CField20.GetNumericScale procedure(*byte bNumericScale)

  code
  return self.iFld20.get_NumericScale( bNumericScale )


CField20.AppendChunk procedure(*gVariant vtData)
!hr          HRESULT
!Offs        long
!pFunc       long
!pFld        long
!pvtData     long

  code
!    pFunc = address(self.IFld20.raw_AppendChunk)
!    pFld = address(self.IFld20)
!    pvtData = address(vtData)
!    Offs = PushVariant(Offs, pvtData)
!    Offs = PushLong(Offs, pFld)
!    hr = AdjustStackCallAndClean(Offs, pFunc)
!    return hr
  return self.iFld20.raw_AppendChunk( vtData )


CField20.GetChunk procedure(long Length, *tVariant vtData)

  code
    return self.IFld20.raw_GetChunk(Length, address(vtData))


CField20.GetOriginalValue procedure(*gVariant vtVar)

  code
    return self.IFld20.get_OriginalValue(vtVar)


CField20.GetUnderlyingValue procedure(*gVariant vtVar)

  code
    return self.IFld20.get_UnderlyingValue(vtVar)


CField20.GetDataFormat procedure(*long ppiDF)

  code
    return self.IFld20.get_DataFormat(ppiDF)


CField20.PutRefDataFormat procedure(long ppiDF)

  code
    return self.IFld20.putref_DataFormat(ppiDF)


CField20.PutPrecision procedure(byte bPrecision)

  code
    return self.IFld20.put_Precision(bPrecision)


CField20.PutNumericScale procedure(byte bNumericScale)

  code
    return self.IFld20.put_NumericScale(bNumericScale)


CField20.PutType procedure(long DataType)

  code
    return self.IFld20.put_Type(DataType)


CField20.PutDefinedSize procedure(long l)

  code
    return self.IFld20.put_DefinedSize(l)


CField20.PutAttributes procedure(long l)

  code
    return self.IFld20.put_Attributes(l)


CField.Construct procedure

  code


CField.Destruct procedure

  code
  self.Release()

CField.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFld &= address(self.IUnk)
    end
    return hr


CField.GetStatus procedure(*long FStatus)

  code
    return self.IFld.get_Status(FStatus)


CFields15.Construct procedure

  code


CFields15.Destruct procedure

  code


CFields15.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFlds15 &= address(self.IUnk)
    end
    return hr


CFields15.GetItem procedure(gVariant vtIndex, *long hr)

rCField     &CField
pvObject    long

  code
    rCField &= null
    hr = self.IFlds15.get_Item(vtIndex, pvObject)
    if hr = S_OK and pvObject
      rCField &= new(CField)
      if ~(rCField &= null)
        hr = rCField.Attach(pvObject)
        if hr <> S_OK
          dispose(rCField)
          rCField &= null
        end
      end  
    end
    return rCField


CFields20.Construct procedure

  code


CFields20.Destruct procedure

  code


CFields20.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFlds20 &= address(self.IUnk)
    end
    return hr


CFields20._Append procedure(*cstring szName, long dwType, long DefinedSize, long Attrib)

bstrName    bstring
hr          HRESULT,auto

  code
    bstrName = szName
    hr = self.IFlds20.raw_Append( bstrName, dwType, DefinedSize, Attrib )
    return hr


CFields20.Delete procedure(gVariant vtIndex)

  code
    return self.IFlds20.raw_Delete(vtIndex)


CFields.Construct procedure

  code


CFields.Destruct procedure

  code
  self.Release()

CFields.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IFlds &= address(self.IUnk)
    end
    return hr


CFields.GetField procedure(long dwIndex, *long hr, long bFetchProperties)

IFlds       &IFields
vtIndex     group(gVariant).
pvObject    long
ADOFld      &CField

  code
    IFlds &= address(self.IUnk)
    vtIndex.vt = VT_I4
    vtIndex.lVal = dwIndex

    hr = IFlds.get_Item(vtIndex, pvobject)
    if hr = S_OK
      ADOFld &= new CField
      assert(~ADOFld &= null)
      if (~ADOFld &= null)
        hr = ADOFld.Attach(pvObject, true)
        if hr ~= S_OK
          dispose(ADOFld).
      end
    end
    return ADOFld

CFields.GetField procedure(*cstring pName, *long hr, long bFetchProperties)

IFlds       &IFields
vtIndex     group(gVariant).
pvObject    long
ADOFld      &CField
tmpVariant  variant, over(vtIndex)

  code

    IFlds &= address(self.IUnk)
    tmpVariant = pName
    hr = IFlds.get_Item(vtIndex, pvobject)
    if hr = S_OK
      ADOFld &= new CField
      assert(~ADOFld &= null)
      if (~ADOFld &= null)
        hr = ADOFld.Attach(pvObject, true)
        if hr ~= S_OK
          dispose(ADOFld).
      end
    end
    return ADOFld   
    
    
CFields.GetField procedure(*string pName, *long hr, long bFetchProperties)

IFlds       &IFields
szName      &cstring
vtIndex     group(gVariant).
pvObject    long
ADOFld      &CField
tmpVariant  variant, over(vtIndex)

  code
    szName &= new(cstring(len(clip(pName)) + 1))
    assert(~(szName &= null))
    if ~szName &= null
      szName = pName
    end
    IFlds &= address(self.IUnk)
    tmpVariant = szName
    hr = IFlds.get_Item(vtIndex, pvobject)
    if hr = S_OK
      ADOFld &= new CField
      assert(~ADOFld &= null)
      if (~ADOFld &= null)
        hr = ADOFld.Attach(pvObject, true)
        if hr ~= S_OK
          dispose(ADOFld).
      end
    end
    dispose(szName)
    return ADOFld     


CFields.AppendFld procedure(*cstring szName, long dwType, long DefinedSize, long Attrib, *gVariant vtFieldValue)

bstrName    bstring
pValue      long
Offs        long
IFlds       &IFields
hr          HRESULT,auto
pFunc       long
pFlds       long

  code
    IFlds &= address(self.IUnk)
    bstrName = szName
    hr = IFlds.raw_Append( bstrName, dwType, DefinedSize, Attrib, vtFieldValue )
    return hr


CFields.Update procedure

  code
    return self.IFlds.raw_Update()


CFields.Resync procedure(long ResyncValues)

  code
    return self.IFlds.raw_Resync(ResyncValues)


CFields.CancelUpdate procedure

  code
    return self.IFlds.raw_CancelUpdate()


CRecordSet15.Construct procedure

  code


CRecordSet15.Destruct procedure

hr          HRESULT(S_FALSE)

  code
    if (~self.EvtHndlr &= NULL)
      hr = self.UnAttachConnPoint(address(self.IUnk), address(RecordsetEventsVt), self.dwRstEvtCookie).


CRecordSet15.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Recordset), address(_Recordset15))
    if (hr = S_OK)
      self.IADOInt &= address(self.IUnk)
      self.IRst15 &= address(self.IUnk)
      self.bInitialised = true
    end
    return hr


CRecordSet15.Init procedure(CRecordsetEvents RstEvts)

hr          HRESULT,auto

  code
    hr = self.Init()
    if hr = S_OK
      self.bInitialised = false
      hr = self.AttachConnPoint(address(self.IUnk), address(RstEvts.IRecordsetEventsVt), address(_RecordsetEvents), self.dwRstEvtCookie)
      if (hr = S_OK)
        self.EvtHndlr &= RstEvts
        self.bInitialised = true
      end
    end
    return hr


CRecordSet15.Init procedure(CRecordsetEvents RstEvts, *cstring szSource, long LockType, long CursorType)

hr          HRESULT

  code
    hr = self.Init(RstEvts)
    if (hr = S_OK)
      hr = self.PutSource(szSource)
      assert(hr = S_OK)
      if (hr = S_OK)
        hr = self.PutLockType(LockType)
        assert(hr = S_OK)
        if (hr = S_OK)
          hr = self.PutCursorLocation(CursorType)
          assert(hr = S_OK)
        end
      end
    end
    return hr


CRecordSet15.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IRst15 &= address(self.IUnk)
    end
    return hr


CRecordSet15.Open procedure(long CursorType, long LockType, long Options)

vMissing    like(gVariant)

  code
    vMissing.vt = VT_ERROR
    vMissing.lVal = DISP_E_PARAMNOTFOUND
    return self.IRst15.raw_Open(vMissing, vMissing, CursorType, LockType, Options)



CRecordSet15.GetAbsolutePosition procedure(*long lPos)

  code
    return self.IRst15.get_AbsolutePosition(lPos)


CRecordSet15.PutAbsolutePosition procedure(long lPos)

  code
    return self.IRst15.put_AbsolutePosition(lPos)


CRecordSet15.PutRefActiveConn procedure(*IDispatch pConn)

  code
    return self.IRst15.putref_ActiveConnection(address(pConn))


CRecordSet15.PutActiveConnection procedure(*gVariant vtVar)

  code
    return self.IRst15.put_ActiveConnection(vtVar)


CRecordSet15.GetActiveConnection procedure(*gVariant vtVar)

  code
    return self.IRst15.get_ActiveConnection(vtVar)


CRecordSet15.GetBOF procedure(*short b)

  code
    return self.IRst15.get_BOF(b)


CRecordSet15.GetBookmark procedure(*gVariant vtBookmark)

  code
    return self.IRst15.get_Bookmark(vtBookmark)


CRecordSet15.PutBookmark procedure(*gVariant vtBookmark)

  code
    return self.IRst15.put_Bookmark(vtBookmark)


CRecordSet15.GetCacheSize procedure(*long l)

  code
    return self.IRst15.get_CacheSize(l)


CRecordSet15.PutCacheSize procedure(long l)

  code
    return self.IRst15.put_CacheSize(l)


CRecordSet15.GetCursorType procedure(*long lCursorType)

  code
    return self.IRst15.get_CursorType(lCursorType)


CRecordSet15.PutCursorType procedure(long lCursorType)

  code
    return self.IRst15.put_CursorType(lCursorType)


CRecordSet15.GetEOF procedure(*short b)

  code
    return self.IRst15.get_adoEOF(b)


CRecordSet15.GetFields procedure(*long hr)

pvObject        long
Flds            &CFields

  code
    hr = self.IRst15.get_Fields(pvObject)
    if hr = S_OK and pvObject
      Flds &= new CFields
      assert(~Flds &= null)
      if (~Flds &= null)
        hr = Flds.Attach(pvObject)
        if hr ~= S_OK
          dispose(Flds).
      end
    end
    return Flds


CRecordSet15.GetLockType procedure(*long lLockType)

  code
    return self.IRst15.get_LockType(lLockType)


CRecordSet15.PutLockType procedure(long lLockType)

  code
    return self.IRst15.put_LockType(lLockType)


CRecordSet15.GetMaxRecords procedure(*long lMaxRecords)

  code
    return SELF.IRst15.get_MaxRecords(lMaxRecords)


CRecordSet15.PutMaxRecords procedure(long lMaxRecords)

  code
    return SELF.IRst15.put_MaxRecords(lMaxRecords)


CRecordSet15.GetRecordCount procedure(*long lRecCount)

  code
    return self.IRst15.get_RecordCount(lRecCount)


CRecordSet15.PutRefSource procedure(*IDispatch pvSource)

  code
    return self.Irst15.putref_Source(pvSource)


CRecordSet15.PutSource procedure(*cstring szSource)

bstrSource      CBStr
hr              HRESULT,auto

  code
    assert(bstrSource.Init(szSource))
    hr = self.IRst15.put_Source(bstrSource.GetBStr())
    bstrSource.Release()
    return hr


CRecordSet15.GetSource procedure(*gVariant vtSource)

  code
    return self.IRst15.get_Source(vtSource)


CRecordSet15.AddNew procedure(*gVariant vtFieldlist, *gVariant vtValues)


  code
    return self.IRst15.raw_AddNew(vtFieldlist, vtValues)
    
    
CRecordSet15.AddNew procedure()

vMissing    like(gVariant)

  code
  vMissing.vt = VT_ERROR
  vMissing.lVal = DISP_E_PARAMNOTFOUND
  return self.AddNew(vMissing, vMissing)

CRecordSet15.CancelUpdate procedure

  code
    return self.IRst15.raw_CancelUpdate()


CRecordSet15.Close procedure

hr    HRESULT
  code
    hr = self.IRst15.raw_Close()
    IF hr = -2146824584  !! Recordset is already closed
      hr = S_OK
    END
    return hr


CRecordSet15.Delete procedure(long AffectRecords)

  code
    return self.IRst15.raw_Delete(AffectRecords)


CRecordSet15.GetRows procedure(long Rows, gVariant vtStart, gVariant vtFields, *gVariant vtVar)

  code
    return self.IRst15.raw_GetRows(Rows, vtStart, vtFields, vtVar)


CRecordSet15.Move procedure(long NumRecords, *gVariant vtStart)


  code
    return self.IRst15.raw_Move(Numrecords, vtStart)


CRecordSet15.MoveNext procedure

  code
    return self.IRst15.MoveNext()


CRecordSet15.MovePrevious procedure

  code
    return self.IRst15.MovePrevious()


CRecordSet15.MoveFirst procedure

  code
    return self.IRst15.MoveFirst()


CRecordSet15.MoveLast procedure

  code
    return self.IRst15.MoveLast()


CRecordSet15.Open procedure(*cstring szSource, CConnection Conn, long CursorType, long LockType, long Options)

hr          HRESULT,AUTO !(S_FALSE)
IConn       &_IConnection,AUTO
vtConn      LIKE(gVariant),AUTO
vtSource    LIKE(gVariant),AUTO
vSource     VARIANT,OVER( vtSource )

  code
  hr = S_FALSE
  IConn &= NULL
  CLEAR( vtConn )
  CLEAR( vtSource )

    if self.bInitialised
      IConn &= Conn.GetConnection()
      assert(~IConn &= null)
      if (~IConn &= null)
        hr = IConn.QueryInterface(address(_IDispatch), vtConn.lVal)
        if hr = S_OK
          assert(vtConn.lVal)
          vtConn.vt = VT_DISPATCH

          vSource = szSource

          hr = self.IRst15.raw_Open(vtSource, vtConn, CursorType, LockType, Options)
          CLEAR( vSource )
        end
        IConn &= NULL
      end
    end
    return hr
    
CRecordSet15.Open procedure(*cstring szSource, *cstring szConnectStr, long CursorType, long LockType, long Options)

hr          HRESULT,AUTO !(S_FALSE)
vtConnStr   LIKE(gVariant),AUTO
vConnStr    variant, over( vtConnStr )
vtSource    LIKE(gVariant),AUTO
vSource     VARIANT,OVER( vtSource )

  code
  hr = S_FALSE
  CLEAR( vtConnStr )
  CLEAR( vtSource )

    if self.bInitialised
      vConnStr = szConnectStr
      vSource = szSource
      hr = self.IRst15.raw_Open(vtSource, vtConnStr, CursorType, LockType, Options)
    end
    return hr
    


CRecordSet15.Requery procedure(long Options)

  code
    return self.IRst15.Requery(Options)


CRecordSet15.xResync procedure(long AffectRecords)

  code
    return self.IRst15.xResync(AffectRecords)


CRecordSet15.Update procedure(*gVariant vtFields, *gVariant vtValues)

  code
    return self.IRst15.raw_update(vtFields, vtValues)
    

CRecordSet15.Update procedure()

vMissing    like(gVariant)

  code
  vMissing.vt = VT_ERROR
  vMissing.lVal = DISP_E_PARAMNOTFOUND
  return self.Update(vMissing, vMissing)
  


CRecordSet15.GetAbsolutePage procedure(*long l)

  code
    return SELF.IRst15.get_AbsolutePage(l)


CRecordSet15.PutAbsolutePage procedure(long l)

  code
    return SELF.IRst15.put_AbsolutePage(l)


CRecordSet15.GetEditMode procedure(*long l)

  code
    return self.IRst15.get_EditMode(l)


CRecordSet15.GetFilter procedure(*gVariant vtCriteria)

  code
    return self.IRst15.get_Filter(vtCriteria)


CRecordSet15.PutFilter procedure(*gVariant vtCriteria)

  code
    return self.IRst15.put_Filter(vtCriteria)


CRecordSet15.GetPageCount procedure(*long l)

  code
    return self.IRst15.get_PageCount(l)


CRecordSet15.GetPageSize procedure(*long l)

  code
    return self.IRst15.get_PageSize(l)


CRecordSet15.PutPageSize procedure(long l)

  code
    return self.IRst15.put_PageSize(l)


CRecordSet15.GetSort procedure(*long hr)

szCriteria      &CStr
pbstrCriteria   long

  code
    hr = self.IRst15.get_Sort(pbstrCriteria)
    if hr = S_OK
      szCriteria &= new CStr
      assert(~szCriteria &= null)
      if (~szCriteria &= null)
        assert(szCriteria.Init(pbstrCriteria, true))
      end
    end
    return szCriteria


CRecordSet15.PutSort procedure(*cstring szCriteria)

bstrCriteria    CBStr
hr              HRESULT

  code
    assert(bstrCriteria.Init(szCriteria))
    return self.IRst15.put_Sort(bstrCriteria.GetBStr())


CRecordSet15.GetStatus procedure(*long l)

  code
    return self.Irst15.get_Status(l)


CRecordSet15.GetState procedure(*long lObjState)

  code
    return self.Irst15.get_State(lObjState)


CRecordSet15._xClone procedure(*long ppvObject)

  code
    return self.Irst15.raw__xClone(ppvObject)


CRecordSet15.UpdateBatch procedure(long AffectRecords)

  code
    return self.IRst15.raw_UpdateBatch(AffectRecords)
    
CRecordSet15.UpdateBatch  procedure()

  code
    return self.UpdateBatch(3)


CRecordSet15.CancelBatch procedure(long AffectRecords)

  code
    return self.IRst15.raw_CancelBatch(AffectRecords)


CRecordSet15.GetCursorLocation procedure(*long lCursorLoc)

  code
    return self.IRst15.get_CursorLocation(lCursorLoc)


CRecordSet15.PutCursorLocation procedure(long lCursorLoc)

  code
    return self.IRst15.put_CursorLocation(lCursorLoc)


CRecordSet15.NextRecordset procedure(*gVariant vtRecordsAffected, *long ppiRs)

  code
    return self.Irst15.raw_NextRecordset(vtRecordsAffected, ppiRs) 


CRecordSet15.Supports procedure(long CursorOptions, *short b)

  code
    return self.IRst15.raw_Supports(CursorOptions, b)


CRecordSet15.GetCollect procedure(*gVariant vtIndex, *gVariant vtVar)

  code
    return self.IRst15.get_Collect(vtIndex, vtVar)



CRecordSet15.PutCollect procedure(gVariant vtIndex, gVariant vtVar)

  code
    return self.Irst15.put_Collect(vtIndex, vtVar)


CRecordSet15.GetMarshalOptions procedure(*long eMarshal)

  code
    return self.IRst15.get_MarshalOptions(eMarshal)  


CRecordSet15.PutMarshalOptions procedure(long eMarshal)

  code
    return self.IRst15.put_MarshalOptions(eMarshal)  


CRecordSet15.Find procedure(*cstring szCriteria, long SkipRecords, long SearchDirection, *gVariant vtStart)

bstrName    CBStr

  code
    assert(bstrName.Init(szCriteria))
    return self.IRst15.raw_Find(bstrName.GetBStr(), SkipRecords, adSearchForward, vtStart)


CRecordset15.Find  procedure(string pStr)

vMissing        like(gVariant)

szCriteria      &cstring
hr              HRESULT
bstrCriteria    bstring
vBookmark       like(gVariant)

  code

  szCriteria &= new(cstring(len(pStr) + 1))
  szCriteria = pStr
  hr = self.GetBookmark(vBookmark)
  if hr = S_OK
  !hr = self.IRst15.raw_Find(address(bstrCriteria), 0, adSearchForward, vBookmark)
    hr = self.Find(szCriteria, 0, adSearchForward, vBookmark)
  else
    vMissing.vt = VT_ERROR
    vMissing.lVal = DISP_E_PARAMNOTFOUND
    hr = self.Find(szCriteria, 0, adSearchForward, vMissing)
  end
  dispose(szCriteria)
  return(hr)


CRecordSet20.Construct procedure

  code


CRecordSet20.Destruct procedure

  code


CRecordSet20.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Recordset), address(_Recordset20))
    if (hr = S_OK)
      self.IADOInt &= address(self.IUnk)
      self.IRst15 &= address(self.IUnk)
      self.IRst20 &= address(self.IUnk)
      self.bInitialised = true
    end
    return hr


CRecordSet20.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IRst20 &= address(self.IUnk)
    end
    return hr


CRecordSet20.Cancel procedure

  code
    return self.IRst20.raw_Cancel()


CRecordSet20.GetDataSource procedure(*long pUnkDataSource)

  code
    return self.IRst20.get_DataSource(pUnkDataSource)


CRecordSet20.PutRefDataSource procedure(*IUnknown unkDataSource)

  code
    return self.IRst20.putRef_DataSource(unkDataSource)


CRecordSet20._xSave procedure(*cstring szFileName, long PersistFormat)

bsFileName CBstr
  code
    assert(bsFileName.Init(szFileName))
    return SELF.IRst20.raw__xSave(bsFileName.GetBstr(), PersistFormat)


CRecordSet20.GetActiveCommand procedure(*long pCmd)

  code
    return self.IRst20.get_ActiveCommand(pCmd)



CRecordSet20.PutStayInSync procedure(long bStayInSync)

  code
    return self.IRst20.put_StayInSync(bStayInSync)


CRecordSet20.GetStayInSync procedure(*long bStayInSync)

  code
    return self.IRst20.get_StayInSync(bStayInSync)


CRecordSet20.Clone procedure(long LockType, *long ppvObject)

  code
    return self.IRst20.raw_Clone(LockType, ppvObject)


CRecordSet20.Resync procedure(long AffectRecords, long ResyncValues)

  code
    return self.IRst20.raw_Resync(AffectRecords, ResyncValues)
    
CRecordset20.GetString  procedure(long StringFormat, long NumRows, bstring bstrColumnDelimeter, bstring bstrRowDelimeter, bstring bstrNullExpr, *bstring bstrRetString)    

  code
    return self.IRst20.raw_GetString(StringFormat, NumRows, bstrColumnDelimeter, bstrRowDelimeter, bstrNullExpr, bstrRetString) 
    
Crecordset20.GetDataMember  procedure(*bstring bstrDataMember)

  code
    return self.IRst20.get_DataMember(bstrDataMember)
    
CRecordset20.PutDataMember  procedure(bstring bstrDataMember)

  code
    return self.IRst20.put_DataMember(bstrDataMember)
    
CRecordset20.CompareBookmarks   procedure(gVariant vtBookmark1, gVariant vtBookmark2, *long Compare)    

  code
    return self.IRst20.raw_CompareBookmarks(vtBookmark1, vtBookmark2, Compare)


CRecordSet21.Construct procedure

  code


CRecordSet21.Destruct procedure

  code


CRecordSet21.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Recordset), address(_Recordset21))
    if (hr = S_OK)
      self.IADOInt &= address(self.IUnk)
      self.IRst15 &= address(self.IUnk)
      self.IRst20 &= address(self.IUnk)
      self.IRst21 &= address(self.IUnk)
      self.bInitialised = true
    end
    return hr


CRecordSet21.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IRst21 &= address(self.IUnk)
    end
    return hr


CRecordSet21.Seek procedure(*gVariant vtKeyValues, long SeekOption)

  code
    return self.IRst21.raw_Seek(vtKeyValues, SeekOption)


CRecordSet21.PutIndex procedure(bstring bstrIndex)

  code
    return self.IRst21.put_Index(bstrIndex)


CRecordSet21.GetIndex procedure(*bstring bstrIndex)

  code
    return self.IRst21.get_Index(bstrIndex)


CRecordSet.Construct procedure

  code


CRecordSet.Destruct procedure

  code
  x# = SELF.iRst15.raw_Close()
  SELF.Release()


CRecordset.Init procedure

hr          HRESULT

  code
    hr = self.CreateInstance(address(__Recordset), address(_Recordset))
    if (hr = S_OK)
      self.IADOInt &= address(self.IUnk)
      self.IRst15 &= address(self.IUnk)
      self.IRst20 &= address(self.IUnk)
      self.IRst21 &= address(self.IUnk)
      self.IRst &= address(self.IUnk)
      self.bInitialised = true
    end
    return hr
    
CRecordSet.Attach procedure(long pUnk, byte fPreInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.IRst &= address(self.IUnk)
    end
    return hr    


CRecordSet.Save procedure(gVariant vtDestination, long PersistFormat)

  code
    return self.IRst.raw_Save(vtDestination, PersistFormat)


CConnection.Construct procedure

  code


CConnection.Destruct procedure

hr          HRESULT,auto

  code
    if (self.bConnected)
      self.Disconnect().
    if (~self.EvtHndlr &= NULL)
      hr = self.UnAttachConnPoint(address(self.IUnk), address(ConnectionEventsVt), self.dwConnEvtCookie).


CConnection.Init procedure

hr          HRESULT,auto

  code
    hr = self.CreateInstance(address(__Connection), address(_Connection))
    if (hr = S_OK)
      self.pConn &= address(self.IUnk)
      self.bInitialised = true
    end
    return hr


CConnection.Init procedure(CConnectionEvents ConnEvts)

hr          HRESULT,auto

  code
    hr = self.Init()
    if hr = S_OK
      self.bInitialised = false
      hr = self.AttachConnPoint(address(self.IUnk), address(ConnEvts.IConnectionEventsVt), address(ConnectionEventsVt), self.dwConnEvtCookie)
      if (hr = S_OK)
        self.EvtHndlr &= ConnEvts
        self.bInitialised = true
      end
    end
    return hr
    
CConnection.Attach      procedure(long pUnk, byte fPreInstantiated)
  
hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPreInstantiated)
    if hr = S_OK
      self.pConn &= address(self.IUnk)
    end
    return hr  


CConnection.Connect procedure(*cstring szConnectStr, *cstring szUID, *cstring szPWD)

hr          HRESULT,auto
SaveHr      HRESULT,auto

bstrConnect bstring
bstrUID     bstring
bstrPWD     bstring

  code
    bstrConnect = szConnectStr
    bstrUID = szUID
    bstrPWD = szPWD
    hr = self.pConn.Open(bstrConnect, bstrUID, bstrPWD, -1)
    if (hr = S_OK)
      self.bConnected = true
    else
      SaveHr = hr
      hr = SaveHr
    end
    return hr

CConnection.Connect procedure(*cstring szConnectStr)

hr          HRESULT,auto
SaveHr      HRESULT,auto

!ConnectStr  CBStr

bstrConnect bstring
bstrUID     bstring
bstrPWD     bstring

  code
    !assert(ConnectStr.Init(szConnectStr))
    !hr = self.pConn.Open(ConnectStr.GetBStr(), 0, 0, -1)
    bstrConnect = szConnectStr
    clear(bstrUID)
    bstrUID = ''
    clear(bstrPWD)
    bstrPWD = ''
    hr = self.pConn.Open(bstrConnect, bstrUID, bstrPWD, -1)
    if (hr = S_OK)
      self.bConnected = true
    else
      SaveHr = hr
      hr = SaveHr
    end
    return hr 
    
    
CConnection.Connect procedure(string sConnectStr)

hr          HRESULT, auto
szConnectStr    &cstring

  code
    hr = S_FALSE
    szConnectStr &= new(cstring(len(sConnectStr) + 1))
    if ~szConnectStr &= null
      szConnectStr = sConnectStr
      hr = self.Connect(szConnectStr)
      dispose(szConnectStr)
    end
    return hr
    


CConnection.Disconnect procedure

hr          HRESULT,auto

  code
    if (self.bConnected)
      hr = self.pConn.Close()
      self.bConnected = false
    end
    return hr


CConnection.Query procedure(*cstring szCommandText, *long dwRecordsAffected, long Options, *long hrOut)

pIRst           long
Rst             &CRecordset
bstrCmdText     CBStr
vRA             like(gVariant)
vCommandStr     like(gVariant)
tmpCommand      variant, over(vCommandStr)

vRecAff         like(gVariant)
varRec          variant, over(vRecAff)

cmdStr          CBStr

bstrCommand     bstring

  code
!    tmpCommand = szCommandText
!    assert(bstrCmdText.Init(szCommandText))
!    vRA.vt = VT_INT
!    vRA.lVal = 0
!    hrOut = self.pConn.raw_Execute(vCommandStr, vRA, Options, pIRst)
!    message(pIRst)
!    if (hrOut = S_OK)
!      if (pIRst)
!        Rst &= new CRecordset
!        assert(~Rst &= null)
!        if (~Rst &= null)
!          Rst.Attach(pIRst)
!        end
!      end
!    else
!      stop( 'Con Query HR: ' & hrOut )
!    end
!    return Rst
    
    

    bstrCommand = szCommandText
    assert(cmdStr.Init(szCommandText))
    hrOut = self.pConn.raw_Execute(bstrCommand, vRecAff, Options, pIRst)
    if (hrOut = S_OK)
!      TRACE( 'Recs: ' & dwRecordsAffected )
      if (pIRst)
        Rst &= new CRecordset
        assert(~Rst &= null)
        if (~Rst &= null)
          Rst.Attach(pIRst)
        end
      end
    else
      stop( 'Con Query HR: ' & hrOut )
    end
    dwRecordsAffected =  varRec
    return Rst
    


CConnection.GetConnection procedure

  code
    return self.pConn
    
    

CConnection.IsolationLevel      PROCEDURE(<LONG lIsolationLevel>)
bGet      BYTE
pLevel    LONG
hr        HRESULT

  CODE
  bGet = OMITTED(2)
  pLevel = 0
  IF bGet
    hr = SELF.pConn.get_IsolationLevel( pLevel )
  ELSE
    hr = SELF.pConn.put_IsolationLevel( lIsolationLevel )
  END
  IF hr <> S_OK
!If HR is an error, there should probably be an error raised here, at least when compiled in
! debug mode.
    RETURN hr
  ELSE
    RETURN pLevel
  END


CConnection.CreateEventHandler procedure(*long pUnk)

hr              HRESULT,auto

  code
    self.EvtHndlr &= new(CConnectionEvents)
    assert(~self.EvtHndlr &= NULL)
    if (~self.EvtHndlr &= NULL)
      hr = self.EvtHndlr.QueryInterface(address(_IUnknown), pUnk).
    return hr


CConnection.Version procedure(*long hr)

bstrVersion     long
Version         CStr
szVersion       &cstring

  code
    hr = E_FAIL
    if self.bInitialised
      hr = self.pConn.get_Version(bstrVersion)
      if hr = S_OK
        if Version.Init(bstrVersion, false, 0, true)
          szVersion &= Version.GetCStr()
        else
          hr = E_FAIL
        end
      end
    end
    return szVersion


CConnection.BeginTrans procedure(long pTransactionLevel)

  code
    return self.pConn.BeginTrans(pTransactionLevel)


CConnection.CommitTrans procedure

  code
    return self.pConn.CommitTrans()


CConnection.RollbackTrans procedure

  code
    return self.pConn.RollbackTrans()


CConnection.Errors procedure(*long hr)

ppvObject   long
ADOErrs     &CErrors

  code
    hr = self.pConn.get_Errors(ppvObject)
    if (hr = S_OK and ppvObject)
      ADOErrs &= new CErrors
      assert(~ADOErrs &= null)
      if (~ADOErrs &= null)
        hr = ADOErrs.Attach(ppvObject)
        if (hr ~= S_OK)
          dispose(ADOErrs)
          ADOErrs &= null
        end
      end
    end
    return ADOErrs


CConnection.Properties procedure(*long hr)

ppvObject   long
ADOProps    &CProperties

  code
    hr = self.pConn.get_Properties(ppvObject)
    if (hr = S_OK and ppvObject)
      ADOProps &= new CProperties
      assert(~ADOProps &= null)
      if (~ADOProps &= null)
        hr = ADOProps.Attach(ppvObject)
        if (hr ~= S_OK)
          dispose(ADOProps)
          ADOProps &= null
        end
      end
    end
    return ADOProps


CConnection.Close procedure

hr          HRESULT,auto

  code
    if (self.bConnected)
      hr = self.pConn.Close()
      self.bConnected = false
    end
    return hr


CConnection._Execute procedure(*cstring szCommandText, *long RecordsAffected, long Options, *long hr)

pIRst           long
Rst             &CRecordset

bsCommandStr    bstring

vRecAffected    like(gVariant)
varRecAffected  variant, over(vRecAffected)

  code
    bsCommandStr = szCommandText
    hr = self.pConn.raw_Execute(bsCommandStr, vRecAffected, Options, pIRst)
    if (hr = S_OK)
      if (pIRst)
        Rst &= new CRecordset
        assert(~Rst &= null)
        if (~Rst &= null)
          Rst.Attach(pIRst)
        end
      end
    end
    RecordsAffected = varRecAffected
    return Rst
    
CConnection._Execute    procedure(string sCommandtext, *long RecordsAffected, long Options, *long hr)

pIRst           long
Rst             &CRecordset
bsCommandStr    bstring
vRecAffected    like(gVariant)
varRecAffected  variant, over(vRecAffected)


  code
    bsCommandStr = sCommandText
    hr = self.pConn.raw_Execute(bsCommandStr, vRecAffected, Options, pIRst)
    if (hr = S_OK)
      if (pIRst)
        Rst &= new CRecordset
        assert(~Rst &= null)
        if (~Rst &= null)
          Rst.Attach(pIRst)
        end
      end
    end
    RecordsAffected = varRecAffected
    return Rst


CConnection.Open procedure(<*cstring szConnectStr>, <*cstring szUserID>, <*cstring szPassword>, <long Options>)

hr          HRESULT,auto
ConnectStr   bstring
UID          bstring
PWD          bstring
lOpt         long

  code
    if self.bInitialised
      if omitted(2)
        ConnectStr = ''
      else
        ConnectStr = szConnectStr
      end
    
      if omitted(3)
        UID = ''
      else
        UID = szUSerID
      end
    
      if omitted(4)
        PWD = ''
      else
        PWD = szPassword
      end
    
      if omitted(5)
        lOpt = adConnectUnspecified
      else
        lOpt = Options
      end
    
      hr = self.pConn.Open(ConnectStr, UID, PWD, lOpt)
      if (hr = S_OK)
        self.bConnected = true
      end
    end
    
    return hr


CConnection.State procedure(*long lObjState)

  code
    return self.pConn.get_State(lObjState)


CConnection.GetCursorLocation   procedure(*long pCursorLocation)

  code
    return self.pConn.get_CursorLocation(pCursorLocation)
    
CConnection.PutCursorLocation   procedure(long pCursorLocation)

  code
    return self.pConn.put_CursorLocation(pCursorLocation)
    
CConnection.PutConnectionTimeOut procedure(long pTimeOut)

  code
    return self.pConn.put_ConnectionTimeout(pTimeOut)
    
CConnection.PutCommandTimeOut    procedure(long pTimeOut)

  code
    return self.pConn.put_CommandTimeOut(pTimeout)
    
CConnection.OpenSchema  procedure(long Schema, *long hr)

CRst        &CRecordset
pvobject    long
vMissing    like(gVariant)

  code
    CRst &= null
    vMissing.vt = VT_ERROR
    vMissing.lVal = DISP_E_PARAMNOTFOUND  
    hr = self.pConn.OpenSchema(Schema, vMissing, vMissing, pvObject)
    if hr = S_OK and pvObject
      CRst &= new(CRecordset)
      if ~Crst &= null
        CRst.Attach(pvObject)
        if hr <> S_OK
          dispose(CRst)
          CRst &= null
        end
      end
    end
    return CRst
      
CConnection.OpenSchema  procedure(long Schema, *gVariant gCriteria, *long hr)

CRst        &CRecordset
pvobject    long
vMissing    like(gVariant)

  code
    CRst &= null
    vMissing.vt = VT_ERROR
    vMissing.lVal = DISP_E_PARAMNOTFOUND  
    hr = self.pConn.OpenSchema(Schema, gCriteria, vMissing, pvObject)
    if hr = S_OK and pvObject
      CRst &= new(CRecordset)
      if ~Crst &= null
        CRst.Attach(pvObject)
        if hr <> S_OK
          dispose(CRst)
          CRst &= null
        end
      end
    end
    return CRst      




CParameter.Construct    procedure

  code

CParameter.Destruct     procedure

  code

CParameter.Attach       procedure(long pUnk, byte fPresInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPresInstantiated)
    if hr = S_OK
      self.IParam &= address(self.IUnk)
    end
    return hr

CParameter.Init         procedure

hr          HRESULT,auto

  code
    hr = self.CreateInstance(address(_Parameter), address(_Parameter))
    if (hr = S_OK)
      self.IParam &= address(self.IUnk)
    end
    return hr


CParameter.GetName      procedure(*long hr)

bstrName    bstring
szName      cstring(128)

  code
  hr = self.IParam.get_Name(bstrName)
  szName = bstrName
  return szName
  

CParameter.PutName      procedure(*cstring pName)

bstrName    bstring     

  code
    bstrName = pName
    return self.IParam.put_Name(bstrName)
    
    
CParameter.GetValue procedure(*gVariant pvVar)

  code
    return self.IParam.get_Value(pvVar)
    
    
CParameter.PutValue procedure(gVariant pvtVar)

  code
    return self.IParam.put_Value(pvtVar)
    
    
CParameter.GetType  procedure(*long pType)

  code
    return self.IParam.get_Type(pType)
    
    
CParameter.PutType  procedure(long pType)

  code
    return self.IParam.put_Type(pType)
    
    
CParameter.PutDirection procedure(long lParamDirection)

  code
    return self.IParam.put_Direction(lParamDirection)
    
    
CParameter.GetDirection procedure(*long lParamDirection)

  code
    return self.IParam.get_Direction(lParamDirection)
    
    
CParameter.PutPrecision procedure(long bPrecision)

  code
    return self.IParam.put_Precision(bPrecision)
    
    
CParameter.GetPrecision procedure(*long bPrecision)

  code
    return self.IParam.get_Precision(bPrecision)
    
    
CParameter.PutNumericScale  procedure(long bScale)    

  code
    return self.IParam.put_NumericScale(bScale)
    
    
CParameter.GetNumericScale  procedure(*long pbScale)

  code
    return self.IParam.get_NumericScale(pbScale)
    
    
CParameter.PutSize      procedure(long lSize)

  code
    return self.IParam.put_Size(lSize)
    
    
CParameter.GetSize      procedure(*long plSize)

  code
    return self.IParam.get_Size(plSize)
    
    
CParameter.AppendChunk      procedure(gVariant vtVal)

  code 
    return self.IParam.raw_AppendChunk(vtVal)
    
    
CParameter.GetAttributes    procedure(*long plParmAttribs)

  code
    return self.IParam.get_Attributes(plParmAttribs)
    
    
CParameter.PutAttributes    procedure(long lParmAttribs)

  code
    return self.IParam.put_Attributes(lParmAttribs)
    




    
    
CParameters.construct   procedure

   code
   
   
CParameters.Destruct    procedure

  code
  
  
CParameters.Attach      procedure(long pUnk, byte fPresInstantiated)

hr          HRESULT,auto

  code
    hr = parent.Attach(pUnk, fPresInstantiated)
    if hr = S_OK
      self.IParams &= address(self.IUnk)
    end
    return hr


CParameters.GetItem procedure(gVariant vIndex, *long hr)

CParam      &CParameter
pvObject    long

  code
    CParam &= null
    hr = self.IParams.get_Item(vIndex, pvObject)
    if hr = S_Ok and pvObject
      CParam &= new(CParameter)
      if ~(CParam &= null)
        hr = CParam.Attach(pvObject)
        if hr <> S_Ok
          dispose(CParam)
        end  
      end
    end
    return CParam

