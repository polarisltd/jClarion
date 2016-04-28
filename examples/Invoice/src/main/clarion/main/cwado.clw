    member
    map
    end

    include('cwado.inc'), once

!
cCWAdo.AddRowInfoQ                      procedure

hr      HRESULT

    code

    if self.SupportGrp.adApproxPosition
      hr = SELF.RS.GetAbsolutePage(self.AbsolutePage)
      if hr = S_OK
        hr = self.RS.GetAbsolutePosition(self.AbsolutePos)
        if hr <> S_OK
          if self.Errors()
            self.ReportErrors()
          end
        end
      else
        if self.Errors()
          self.ReportErrors()
        end
      end
    else
      self.AbsolutePage = 0
      self.AbsolutePos = 0
    end

    if self.SupportGrp.adBookmark
      hr = SELF.RS.GetBookmark(SELF.vBookmark)
      if hr <> S_OK
        if self.Errors()
          self.ReportErrors()
        end
      end
    else
      clear(self.vBookmark)
    end

    self.FieldPair.AssignRightToLeft()



cCWADo.InitDataInfo                     procedure(*TRowInfoGrp gInfoGrp)

    code
    self.FieldPair.AddFields(gInfoGrp.AbsolutePage, self.AbsolutePage)
    self.FieldPair.AddFields(gInfoGrp.AbsolutePos, self.AbsolutePos)
    self.FieldPair.AddFields(gInfoGrp.Bookmark, self.vBookmark)


! --------------------------------------------------------------------------------------------------------------
cCWAdo.Close                            procedure
! --------------------------------------------------------------------------------------------------------------

    code

    if SELF.IsOpen()
      SELF.RS.Close()
      SELF.bOpen = false
      dispose(SELF.Rs)
    end

! --------------------------------------------------------------------------------------------------------------
cCWAdo.Construct                        procedure
! --------------------------------------------------------------------------------------------------------------

    code

    SELF.Mapper &= new TableMapper
    self.FieldPair &= new(cFieldPair)
    self.ErrorQ &= new(TErrorQ)
    self.DataGrp &= null
    self.DataQueue &= null

    ! Give default value for some of the CRecordset open parameters
    SELF.CursorLocation = adUseClient
    SELF.Cursortype = adOpenStatic
    SELF.LockType = adLockOptimistic
    SELF.Options = adCmdText
    SELF.CacheSize = 1
    self.ExecOptions = 0

! --------------------------------------------------------------------------------------------------------------
cCWAdo.Destruct                         procedure
! --------------------------------------------------------------------------------------------------------------

    code

    dispose(SELF.Mapper)
    dispose(self.FieldPair)
    if records(self.ErrorQ)
      free(self.ErrorQ)
    end
    dispose(self.ErrorQ)
    IF ~SELF.DataGrp &= NULL
      SELF.DataGrp &= NULL
    END
    IF ~SELF.DataQueue &= NULL
      SELF.DataQueue &= NULL
    END
    IF ~SELF.RS &= NULL
      DISPOSE( SELF.RS )
    END    
!    SELF.Close()

! --------------------------------------------------------------------------------------------------------------
cCWADo.ExecuteQuery                     procedure(string sQuery)      ! procedure(string sQuery), bool, virtual
! --------------------------------------------------------------------------------------------------------------

    code

    return(SELF.ADO_SQL.ExecuteQuery(sQuery))

! --------------------------------------------------------------------------------------------------------------
cCWAdo.GetMaxRecords                    procedure                     ! procedure(), long, virtual
! --------------------------------------------------------------------------------------------------------------

hr      HRESULT
NbrRec  long

    code

    hr = SELF.RS.GetMaxRecords(NbrRec)
    if hr = S_OK
      return NbrRec
    end

! --------------------------------------------------------------------------------------------------------------
cCWAdo.GetPage                          procedure
! --------------------------------------------------------------------------------------------------------------

hr      HRESULT
lPage   long

    code
    hr = SELF.RS.GetAbsolutePage(lPage)
    if hr ~= S_OK
    end
    return(lPage)



! --------------------------------------------------------------------------------------------------------------
cCWAdo.GetPosition                      procedure
! --------------------------------------------------------------------------------------------------------------

hr      HRESULT
lPos    long

    code
    hr = self.RS.GetAbsolutePosition(lPos)
    if hr ~= S_OK
      lPos = 0
    end
    return lPos




! --------------------------------------------------------------------------------------------------------------
cCWAdo.IsOpen                           procedure                      ! procedure(), bool, virtual
! --------------------------------------------------------------------------------------------------------------

    code

    return SELF.bOpen

! --------------------------------------------------------------------------------------------------------------
cCWAdo.Next                             procedure                      ! procedure(), byte, virtual
! --------------------------------------------------------------------------------------------------------------

    code

    return(SELF.ADO_SQL.Next())


!---------------------------------------------------------------------------------------------------------------
cCWAdo.Persist                          procedure(string sFileName)
! --------------------------------------------------------------------------------------------------------------

    code

    SELF.ADO_SQL.Persist(sFileName)


! --------------------------------------------------------------------------------------------------------------
cCWAdo.PersistXML                       procedure(string sXMLFileName)
! --------------------------------------------------------------------------------------------------------------

    code

    SELF.ADO_SQL.PersistXML(sXMLFileName)

! --------------------------------------------------------------------------------------------------------------
cCWAdo.Previous                         procedure                      ! procedure(), byte, virtual
! --------------------------------------------------------------------------------------------------------------

    code

    return(SELF.ADO_SQL.Previous())

! --------------------------------------------------------------------------------------------------------------
cCWAdo.SetCacheSize                     procedure(long pCacheSize)
! --------------------------------------------------------------------------------------------------------------

    code

    SELF.CacheSize = pCacheSize

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetConnection                    procedure(*CConnection pConn)
! -------------------------------------------------------------------------------------------------------------

    code

    SELF.Conn &= pConn

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetConnection                    procedure(*cstring szConnectStr)
! -------------------------------------------------------------------------------------------------------------

    code

    if ~self.szConnectStr &= null
      dispose(self.szConnectStr)
    end

    self.szConnectStr &= new( cstring(len(szConnectStr) + 1) )
    if ~self.szConnectStr &= null
      self.szConnectStr = szConnectStr
    end


! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetCursorLocation                procedure(long pCursorLocation)
! -------------------------------------------------------------------------------------------------------------

    code

    SELF.CursorLocation = pCursorLocation

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetCursorType                    procedure(long pCursorType)
! -------------------------------------------------------------------------------------------------------------

    code
    SELF.CursorType = pCursorType

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetDataGroup                     procedure(*group pGrp)
! -------------------------------------------------------------------------------------------------------------

    code

    SELF.DataGrp &= pGrp

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetDataGroup                     procedure(*QUEUE pQueue)
! -------------------------------------------------------------------------------------------------------------

    code

    SELF.DataQueue &= pQueue

cCWADO.SetExecOptions                   procedure(long pExecOptions)

    code
    self.ExecOptions = pExecOptions

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetLockType                      procedure(long pLockType)
! -------------------------------------------------------------------------------------------------------------

    code
    SELF.LockType = pLockType

!--------------------------------------------------------------------------------------------------------------
cCWADO.SetMaxRecords                    procedure(long pMaxRecords)
! -------------------------------------------------------------------------------------------------------------

hr      HRESULT
bValue  bool

    code
    if pMaxRecords > 1
      SELF.MaxRecords = pMaxRecords
    end

! -------------------------------------------------------------------------------------------------------------
cCWAdo.SetOptions                       procedure(long pOptions)
! -------------------------------------------------------------------------------------------------------------

    code
    SELF.Options = pOptions


cCWAdo.SetOrderBy                       procedure(string sOrderBy)

    code
    SELF.szOrderByStr = sOrderBy


cCWAdo.SetPageSize                      procedure(long pPageSize)

    code
    SELF.PageSize = pPageSize

!--------------------------------------------------------------------------------------------------------------
cCWAdo.Errors                   procedure()
!--------------------------------------------------------------------------------------------------------------

RetValue        long
Errors          &CErrors
ErrorCount      long
ErrorObj        &CError
szError         &Cstr
NativeErr       long
hr              HRESULT
ndx             long

    code
    free(self.ErrorQ)
    RetValue = false
    Errors &= self.Conn.Errors(hr)
    if hr = S_OK
      hr = Errors.GetCount(ErrorCount)
      if hr = S_OK
        if ErrorCount
          RetValue = true
          loop ndx = 0 to (ErrorCount - 1)
            ErrorObj &= Errors.Error(ndx, hr)
            if hr = S_OK
              szError &= ErrorObj.Description(hr)
              if hr = S_OK
                self.ErrorQ.Description = szError.GetCStr()
              end
              hr = ErrorObj.NativeError(NativeErr)
              if hr = S_OK
                self.ErrorQ.NativeError = NativeErr
              end
              add(self.ErrorQ)
            end
          end
        end
      else
        self.ErrorQ.NativeError = hr
        self.ErrorQ.Description = 'ADO_SQL.Errors calling hr = Errors.GetCount(ErrorCount)'
        add(self.ErrorQ)
      end
    end
    return(RetValue)



! -------------------------------------------------------------------------------------------------------------
cCWAdo.ReportErrors         procedure(<STRING sQuery>)
! -------------------------------------------------------------------------------------------------------------

Text1       STRING(2048)

Window WINDOW('Error Log'),AT(,,491,196),FONT('Tahoma',,,FONT:regular,CHARSET:ANSI),CENTER,GRAY,DOUBLE
       TEXT,AT(7,4,477,43),USE(Text1),SKIP,SCROLL,VSCROLL,READONLY
       LIST,AT(7,51,477,116),USE(?List1),FORMAT('61R(2)|M~Native Error~@n-_10@120L(2)|M~Description~@s120@'), |
           FROM(SELF.ErrorQ)
       BUTTON('Ok'),AT(437,172,45,14),USE(?btnOk)
     END


    code
    IF ~OMITTED( 2 )
      Text1 = sQuery
    END
    IF RECORDS( SELF.ErrorQ ) = 0
      IF SELF.Errors() = 0
        RETURN
      END
    END
    open(Window)
    accept
      case field()
      of ?btnOk
        post(EVENT:CloseWindow)
      end
    end
    close( window )
    return

cCWADO.GetRow              procedure

hr      HRESULT
bFlag   short

    code

    self.FieldPair.AssignLeftToRight()

    ! More code is needed here in order to locate the row in the recordset.
    ! One of the way is to look if bookmarks are supported. If they are, the class hold an internal queue
    ! for each bookmark that movefirst and movenext did read.
    if self.SupportGrp.adBookmark <> false
      hr = self.RS.PutBookmark(self.vBookmark)
      if hr = S_OK
        !self.Mapper.MapRSToGroup(self.RS)
        self.Map()
        return true
      else
        return false
      end
    end
    
    
cCWAdo.Map                 procedure

  code
  if ~(self.DataGrp &= null) or ~(self.DataQueue &= null)
    self.Mapper.MapRSToGroup(self.RS)
  else
    self.Mapper.Map(self.RS)
  end  

    
cCWAdo.EOF                 procedure

bEof            short
hr              HRESULT

    code
    hr = SELF.RS.GetEOF(bEof)
    if hr = S_OK
      return bEof
    else
      return -99
    end

cCWAdo.BOF                 procedure

bBof            short
hr              HRESULT

    code
    hr = SELF.RS.GetBOF(bBof)
    if hr = S_OK
      return bBof
    else
      return -99
    end

cCWAdo.MoveFirst                 procedure

bEof            short
hr              HRESULT
ReturnValue     byte

    code
    hr = SELF.RS.MoveFirst()
    if hr = S_OK
      hr = SELF.RS.GetEOF(bEof)
      if hr = S_OK
        if bEof <> false  ! Got RS Eof
          ReturnValue = false
        else
          !SELF.Mapper.MapRSToGroup(SELF.RS)
          self.Map()
          ReturnValue =  true
        end
      else
        ! Something went wrong with call to RS.GetEOF(bEof)
        ReturnValue = false
      end
    else
      ! Something went wrong with RS.MoveNext()
      ReturnValue = false
    end
    return ReturnValue

cCWAdo.MoveLast                 procedure

bEof            short
hr              HRESULT
ReturnValue     byte

    code
    hr = SELF.RS.MoveLast()
    if hr = S_OK
      hr = SELF.RS.GetEOF(bEof)
      if hr = S_OK
        if bEof <> false  ! Got RS Eof
          ReturnValue = false
        else
          !SELF.Mapper.MapRSToGroup(SELF.RS)
          self.Map()
          ReturnValue =  true
        end
      else
        ! Something went wrong with call to RS.GetEOF(bEof)
        ReturnValue = false
      end
    else
      ! Something went wrong with RS.MoveNext()
      ReturnValue = false
    end
    return ReturnValue



cCWAdo.UpdateSupportGrp        procedure

hr              HRESULT

    code
    hr = self.RS.Supports(adAddNew, self.SupportGrp.adAddNew)
    hr = self.RS.Supports(adApproxPosition, self.SupportGrp.adApproxPosition)
    hr = self.RS.Supports(adBookmark, self.SupportGrp.adBookmark)
    hr = self.RS.Supports(adDelete, self.SupportGrp.adDelete)
    hr = self.RS.Supports(adFind, self.SupportGrp.adFind)
    hr = self.RS.Supports(adHoldRecords, self.SupportGrp.adHoldRecords)
    hr = self.RS.Supports(adIndex, self.SupportGrp.adIndex)
    hr = self.RS.Supports(adMovePrevious, self.SupportGrp.adMovePrevious)
    hr = self.RS.Supports(adNotify, self.SupportGrp.adNotify)
    hr = self.RS.Supports(adResync, self.SupportGrp.adResync)
    hr = self.RS.Supports(adSeek, self.SupportGrp.adSeek)
    hr = self.RS.Supports(adUpdate, self.SupportGrp.adUpdate)
    hr = self.RS.Supports(adUpdateBatch, self.SupportGrp.adUpdateBatch)
    

cCWAdo.MapRSToGroup            procedure

    code
    IF ~SELF.DataGrp &= NULL
      SELF.Mapper.MapRSToGroup(SELF.RS, SELF.DataGrp)
    ELSE
      SELF.Mapper.MapRSToGroup(SELF.RS, SELF.DataQueue)
    END


cCWAdo.SetUniqueTable          procedure

szUnique        cstring('Unique Table')

hr              HRESULT
gVar            like(gVariant)
AVar            variant, over(gVar)

Properties      &CProperties
Property        &CProperty

    code
    Properties &= self.RS.GetProperties(hr)
    if hr = S_OK
      Property &= Properties.Getitem(szUnique, hr)
      if hr = S_OK
        aVar = self.szUniqueTable
        hr = Property.PutValue(gVar)
        if hr <> S_OK
          !message('PutValue returned hr = ' & hr)
        end
      end
      dispose(Property)
    end
    dispose(Properties)


cCWADo.SetResyncCmd     procedure

szResync        cstring('Resync Command')

hr              HRESULT
gVar            like(gVariant)
AVar            variant, over(gVar)

Properties      &CProperties
Property        &CProperty

    code
    Properties &= self.RS.GetProperties(hr)
    if hr = S_OK
      Property &= Properties.Getitem(szResync, hr)
      if hr = S_OK
        aVar = self.szResyncCmd
        hr = Property.PutValue(gVar)
        if hr <> S_OK
          !message('PutValue returned hr = ' & hr)
        end
      end
      dispose(Property)
    end
    dispose(Properties)



! -------------------------------------------------------------------------------------------------------------
! ADO_SQL Implementation section
! -------------------------------------------------------------------------------------------------------------

! -------------------------------------------------------------------------------------------------------------
cCWADO.ADO_SQL.DeleteRow                procedure(string sDelete)
! -------------------------------------------------------------------------------------------------------------

    code

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL._Execute                 procedure(string sStatement)
! -------------------------------------------------------------------------------------------------------------

    code

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.ExecuteQuery             procedure(string sQuery)
! -------------------------------------------------------------------------------------------------------------
!
! This procedure will simply open the ADO Recordset object with the query and return true if there is record to process.
! The ADO MoveFirst method is called if there are rows to process.
!

!szQuery             &cstring
hr                  HRESULT
dwRecordsAffected   long
bEof                short
bBof                short
ReturnValue         byte
Options             long

CursorType          long
CursorLoc           long

    code
    if ~self.szQuery &= null
      dispose(self.szQuery)
    end
    self.szQuery &= NEW( CSTRING( LEN( CLIP( sQuery ) ) + 2 ) )
    self.szQuery = sQuery
!?   assert(~SELF.Conn &= null)
!    if (~SELF.Conn &= null)  ! Is there a connection object set in the class?
      !szQuery = sQuery

      if ~SELF.RS &= null    ! Is the CRecordset object still living from a previous query ?
        if self.IsOpen()
          self.RS.Close()
        end  
        dispose(SELF.RS)     ! Yes, kill it
        SELF.RS &= null      ! And make sure it's null
      end

      SELF.Rs &= new CRecordset  ! Create an ADO CRecordset object

?     assert(~SELF.RS &= null)   ! Assume at this point that RS is not null
      if ~SELF.Rs &= null
        hr = SELF.RS.Init()  ! Call the Init method, this method will create the COM object
        if hr = S_OK

          ! Look if there is a number of maximum rows set in the class to apply on the CRecordset. If so, apply it before opening RS
          if SELF.MaxRecords > 1
            hr = SELF.RS.PutMaxRecords(SELF.MaxRecords)
            if hr ~= S_OK
              message('MaxRecords call failed')
            end
          end
          hr = SELF.RS.PutCacheSize(SELF.CacheSize)
          if hr ~= S_OK
            message('PutCacheSize failed')
          end
          hr = SELF.RS.PutCursorType(SELF.CursorType)
          if hr ~= S_OK
            message('PutCursorType failed: ' & hr)
          end

          if SELF.PageSize
            hr = SELF.RS.PutPageSize(SELF.PageSize)
          end
          hr = self.RS.PutCursorLocation(self.CursorLocation)
          Options = bor(self.Options, self.ExecOptions)

          if self.Conn &= null and self.szConnectStr &= null
            message('Connection settings not defined')
          else

            ! Open the CRecordset object and check for Bof and EOf to see if the recordset has some rows
            if ~self.Conn &= null
              hr = SELF.Rs.Open(self.szQuery, SELF.Conn, SELF.CursorType, SELF.LockType, SELF.Options + self.ExecOptions)
            else
              hr = SELF.Rs.Open(self.szQuery, SELF.szConnectStr, SELF.CursorType, SELF.LockType, SELF.Options + self.ExecOptions)
            end
            if hr = S_OK
!              hr = self.RS.GetCursortype(CursorType)
!              if hr = S_OK
!                if CursorType <> self.Cursortype
!                  message('Provider changed cursor type to: ' & Cursortype)
!                end
!              end

              hr = self.RS.GetPageCount(self.PageCount)

              hr = self.RS.GetCursorLocation(CursorLoc)
              if hr = S_OK
                if self.CursorLocation <> CursorLoc
                  message('Cursor Location = ' & CursorLoc)
                end
              end
              self.UpdateSupportGrp()
              if self.szUniqueTable
                self.SetUniqueTable()
              end
              if self.szResyncCmd
                self.SetResyncCmd()
              end

!              if self.szSortStr and self.CursorLocation = adUseClient
!                hr = self.RS.PutSort(self.szSortStr)
!                if hr <> S_OK
!                  message('Sort failed')
!                end
!              end

              hr = SELF.RS.GetBOF(bBof)
              if hr = S_OK
                hr = SELF.RS.GetEOF(bEof)
                if hr = S_OK
                  if bBof <> false and bEof <> false
                    ! At this point, there is no rows in the record set. So, we close and dispose the RS object
                    SELF.bOpen = false
                    SELF.RS.Close()
                    dispose(SELF.RS)
                    ReturnValue = false
                  else
                    ! There is at least one row, move the cursor to the first row
                    SELF.bOpen = true
                    hr = SELF.RS.MoveFirst()
                    IF SELF.DataGrp &= NULL AND SELF.DataQueue &= NULL
                      !ReturnValue = false
                      self.Mapper.Map(Self.RS)
                    ELSIF ~SELF.DataGrp &= NULL
                      SELF.Mapper.MapRSToGroup(SELF.RS, SELF.DataGrp)
                    ELSE
                      SELF.Mapper.MapRSToGroup(SELF.RS, SELF.DataQueue)
                    END
                    SELF.AddRowInfoQ()
                    ReturnValue =  true
                  end
                end
              end
            else
              if self.Errors()
                Self.ReportErrors(self.szQuery)
              end
            end
          end
        end
      else
        ! Problem with the creation of the CRecordset object, return false
        ReturnValue = false
      end
!    else
!      ReturnValue = false   ! No valid connection object, return false
!    end
    !dispose(szQuery)
    return ReturnValue


! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.ExecuteUpdate            procedure(string sUpdate)
! -------------------------------------------------------------------------------------------------------------

    code


! -------------------------------------------------------------------------------------------------------------
cCWADo.ADO_SQL.InsertRow                procedure(string sInsert)
! -------------------------------------------------------------------------------------------------------------

    code

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.Move                     procedure(long pNumRec)
! -------------------------------------------------------------------------------------------------------------

bEof        short
bBof        short
hr          HRESULT
AVariant    VARIANT
Avar        like(gVariant), over(AVariant)

    code
    ! First, get the EOF and BOF status of the recordset. The move method needs a valid cursor position to work with.
    ! If the EOF return true anf BOF return true, we have an empty recordset.
    ! If EOF is true, we will position the cursor on the last row and on the first row if BOF is true
    hr = self.RS.GetEof(bEof)
    if hr = S_OK
      hr = self.RS.GetBOF(bBof)
      if hr <> S_OK
        if self.Errors()
          self.ReportErrors()
        end
      end
    else
      if self.Errors()
        self.ReportErrors()
      end
    end

    if bEof <> false and bBof <> false   ! Empty result set
      return                             ! Just return and do nothing else
    else
      if bEof <> false                   ! At EOF,
        hr = self.RS.MoveLast()          ! position the cursor at last row
        if hr = S_OK
          !self.Mapper.MapRSToGroup(self.RS)     ! and map the data
          self.Map()
        end
      elsif bBof <> false                ! At BOF,
        hr = self.RS.MoveFirst()         ! position the cursor at first row
        if hr = S_OK
          !self.Mapper.MapRSToGroup(self.RS)     ! and map the data
          self.Map()
        end
      end
    end


    AVariant = adBookmarkCurrent
    hr = self.RS.Move(pNumRec, AVar)
    if hr = S_OK
      !self.Mapper.MapRSToGroup(self.RS)
      self.Map()
    else
      if self.Errors()
        self.ReportErrors()
      end
    end


! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.Next                     procedure
! -------------------------------------------------------------------------------------------------------------

bEof            short
hr              HRESULT
ReturnValue     byte

    code
    hr = SELF.RS.MoveNext()
    if hr = S_OK
      hr = SELF.RS.GetEOF(bEof)
      if hr = S_OK
        if bEof <> false  ! Got RS Eof
          ReturnValue = false
        else
          !SELF.Mapper.MapRSToGroup(SELF.RS)
          self.Map()
          ReturnValue =  true
          SELF.AddRowInfoQ()
        end
      else
        ! Something went wrong with call to RS.GetEOF(bEof)
        ReturnValue = false
      end
    else
      ! Something went wrong with RS.MoveNext()
      ReturnValue = false
    end
    return ReturnValue


! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.Persist                  procedure(string sFilename)
! -------------------------------------------------------------------------------------------------------------

hr              HRESULT

ASCIIFile       file, driver('ASCII'), create
record            record
Line                string(2048)
                  end
                end

    code

    if SELF.IsOpen()
      do CreateFile
      do WriteHeader
      do WriteData
      close(ASCIIFile)
    end

!----------------------------
CreateFile      routine

    data

    code
    ASCIIFile{prop:Name} = sFileName
    create(ASCIIFile)
    if errorcode()
      message('Create failed: ' & errorcode())
    else
      open(ASCIIFile)
    end


!----------------------------
Writeheader     routine

    data

ndx         long
FieldName   cstring(128)
Header      cstring(1024)
oFields     &CFields
oField      &CField
!hr          HRESULT
lCount      long
bstrName    bstring

    code
    ! Get the Fields collection object in order to loop trough all individuals Field object
    oFields &= self.RS.GetFields(hr)
    if hr = S_OK and ~(oFields &= null)
      hr = oFields.GetCount(lCount)             ! How many Field object?
      if hr = S_OK
        loop ndx = 0 to lCount - 1              ! First item in a collection is numbered 0
          oField &= oFields.GetField(ndx, hr)   ! Get the corresponding field object
          if hr = S_OK and ~(oField &= null)
            hr = oField.GetName(bstrName)       ! Get that object field name
            if hr = S_OK
              if ~Header                        ! And update the header
                Header = '"' & bstrName & '"'
              else
                Header = clip(Header) & ',"' & clip(bstrName) & '"'
              end
            end
          end
          if ~(oField &= null)   ! memory cleanup
            dispose(oField)
          end
        end
      end
    end
    if ~(oFields &= null)   ! Memory cleanup
      dispose(oFields)
    end 
    
    ASCIIFile.Line = clip(Header)
    add(ASCIIFile)


! ---------------------------
WriteData       routine

    data
    
oFields     &CFields
oField      &CField
!hr          HRESULT
lCount      long

gVar        like(gVariant)
aVar        variant, over(gVar)
    

    code
    hr = SELF.RS.MoveFirst()
    !SELF.Mapper.MapRSToGroup(SELF.RS, SELF.DataGrp)
    do WriteRecord
    if hr = S_OK
      loop
        if ~SELF.Next()
          break
        else
          do WriteRecord
        end
      end
    end

! ---------------------------
WriteRecord     routine

    data

aField      any
ndx         long
ALine       string(1024)

oFields     &CFields
oField      &CField
lCount      long
lType       long

gVar        like(gVariant)
aVar        variant, over(gVar)

    code
    oFields &= self.RS.GetFields(hr)
    if hr = S_OK and ~(oFields &= null)
      hr = oFields.GetCount(lCount)
      if hr = S_OK
        loop ndx = 0 to lCount - 1
          oField &= oFields.GetField(ndx, hr)
          if hr = S_OK and ~(oField &= null)
            hr = oField.GetValue(gVar)
            if hr = S_OK
              hr = oField.GetType(lType)
              if hr = S_OK
                case lType
                of adBSTR
                orof adChar
                orof adVarChar
                orof adLongVarChar
                orof adWChar
                orof adVarWChar
                orof adLongVarWChar
                orof adDate
                orof adDBDate
                orof adDBTime
                orof adDBTimeStamp
                  if ~ALine
                    Aline = '"' & aVar & '"' 
                  else
                    ALine = clip(Aline) & ',"' & aVar & '"'
                  end
                else
                  if ~ALine
                    ALine = aVar
                  else
                    ALine = clip(Aline) & ',' & aVar
                  end  
                end
              end
            end
          end
        end
      end
    end
    ASCIIFile.Line = ALine
    add(ASCIIFile)

! -------------------------------------------------------------------------------------------------------------
cCWADo.ADO_SQL.PersistXML               procedure(string sXMLFileName)
! -------------------------------------------------------------------------------------------------------------

szXMLFile   cstring(128)

    code

    szXMLFile = sXMLFileName
    if SELF.Rs._xSave(szXMLFile, adPersistXML).

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.Previous                 procedure
! -------------------------------------------------------------------------------------------------------------

bBof            short
hr              HRESULT
ReturnValue     byte

    code

    if self.SupportGrp.adMovePrevious <> false
      hr = SELF.RS.MovePrevious()
      if hr = S_OK
        hr = SELF.RS.GetBOF(bBof)
        if hr = S_OK
          if bBof <> false
            ReturnValue = false
          else
            !SELF.Mapper.MapRSToGroup(SELF.RS)
            self.Map()
            ReturnValue =  true
            SELF.AddRowInfoQ()
          end
        else
          ReturnValue = false
        end
      else
        ReturnValue = false
      end
    else
      ReturnValue = false
    end
    return ReturnValue

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetFirstPage                 procedure()
! -------------------------------------------------------------------------------------------------------------

rValue          byte
hr              hresult

    code
    rValue = true
    if self.PageCount
      hr = self.rs.PutAbsolutePage(1)
      if hr <> s_ok
        rValue = false
        if self.Errors()
          self.reportErrors()
        end
      else
        self.Map()
        rValue =  true
        SELF.AddRowInfoQ()
      end
    end
    return(rValue)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetLastPage                  procedure()
! -------------------------------------------------------------------------------------------------------------

rValue          byte
hr              hresult

    code
    rValue = true
    if self.PageCount
      hr = self.rs.PutAbsolutePage(self.PageCount)
      if hr <> s_ok
        rValue = false
        if self.Errors()
          self.reportErrors()
        end
      else
        self.Map()
        rValue =  true
        SELF.AddRowInfoQ()
      end
    end
    return(rValue)


! -------------------------------------------------------------------------------------------------------------
cCWado.ADO_SQL.GetPageSize                  procedure()
! -------------------------------------------------------------------------------------------------------------

    code
    return(self.PageSize)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetPageCount                 procedure
! -------------------------------------------------------------------------------------------------------------

    code
    return(self.PageCount)



! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetRowCount                  procedure
! -------------------------------------------------------------------------------------------------------------

hr          hresult
RowCount    long

    code
    hr = self.RS.GetRecordCount(RowCount)
    if hr = S_OK
      if RowCount < 0   ! Feature not supported
      end
    end
    return RowCount


! -------------------------------------------------------------------------------------------------------------
cCWADo.ADO_SQL.GotoPos                      procedure(long pPos)
! -------------------------------------------------------------------------------------------------------------

hr              HRESULT
rValue          byte

    code
    hr = self.RS.PutAbsolutePosition(pPos)
    if hr = S_OK
      self.Map()
      rValue =  true
      SELF.AddRowInfoQ()
    else
    end
    return(rValue)


! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetNextPage                  procedure()
! -------------------------------------------------------------------------------------------------------------

ActualPage      long
hr              hresult
rValue          byte

    code
    rValue = true
    if self.PageCount
      hr = self.RS.GetAbsolutePage(ActualPage)
      if hr = S_OK
        hr = self.rs.PutAbsolutePage(ActualPage + 1)
        if hr <> s_ok
          if self.Errors()
            self.ReportErrors()
          end
        end
      else
        if self.Errors()
          self.ReportErrors()
        end
      end
    end
    return(rValue)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GotoPage                     procedure(long pPageNbr)
! -------------------------------------------------------------------------------------------------------------

hr          hresult
rValue      long

    code
    rValue = true
    hr = self.RS.PutAbsolutePage(pPageNbr)
    if hr <> S_OK
      rValue = false
    else
      self.Map()
      rValue =  true
      SELF.AddRowInfoQ()
    end
    return(rValue)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetEOF                   procedure()
! -------------------------------------------------------------------------------------------------------------

hr          hresult
sEOF        short

    code
    hr = self.RS.GetEOF(sEOF)
    return(sEOF)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.GetBOF                   procedure()
! -------------------------------------------------------------------------------------------------------------

hr          hresult
sBOF        short

    code
    hr = self.RS.GetBOF(sBOF)
    return(sBOF)


cCWAdo.ADO_SQL.SetToPos                 procedure()


hr      HRESULT

    code
    self.FieldPair.AssignLeftToRight()
    hr = self.RS.PutAbsolutePosition(self.AbsolutePos)
    if hr = S_OK
      self.Map()
      return true
    else
      return false
    end


! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.SetCursorAtRow           procedure()
! -------------------------------------------------------------------------------------------------------------

hr      HRESULT
bFlag   short



    code
    ! More code is needed here in order to locate the row in the recordset.
    ! One of the way is to look if bookmarks are supported. If they are, the class hold an internal queue
    ! for each bookmark that movefirst and movenext did read.
    !hr = SELF.RS.Supports(adBookmark, bFlag)
    if self.SupportGrp.adBookmark
      self.FieldPair.AssignLeftToRight()
      hr = self.RS.PutBookmark(self.vBookmark)
      if hr = S_OK
        !self.Mapper.MapRSToGroup(self.RS)
        self.Map()
        return true
      else
        return false
      end
    else
      if self.SupportGrp.adApproxPosition
        self.FieldPair.AssignLeftToRight()
        hr = self.RS.PutAbsolutePosition(self.AbsolutePos)
        if hr = S_OK
          !self.Mapper.MapRSToGroup(self.RS)
          self.Map()
          return true
        else
          return false
        end
      end
    end

! -------------------------------------------------------------------------------------------------------------
cCWADo.ADO_SQL.SetSort                          procedure(*cstring szSort)
! -------------------------------------------------------------------------------------------------------------

    code
    self.szSortStr = szSort


! -------------------------------------------------------------------------------------------------------------
cCWADO.ADO_SQL.SetFilter                        procedure(*cstring szFilter)
! -------------------------------------------------------------------------------------------------------------

    code
    self.szFilterStr = szFilter


!--------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.UpdateRow                procedure(TUpdateQ pQ)
! -------------------------------------------------------------------------------------------------------------

ndx         long
cCFields    &CFields
cCField     &CField
hr          HRESULT
szValue     &cstring
NewValue    like(gVariant)
aVariant    variant, over(NewValue)
RetValue    byte
lDataType   long

    code

    if ~records(pQ)      ! If no value to update
      RetValue =  false
    else
      cCFields &= SELF.RS.GetFields(hr)                                  ! Get the Fields collection object
      if hr = S_Ok
        loop ndx = 1 to records(pQ)                                      ! loop through all cols that need updating
          get(pQ, ndx)
          cCField &= cCFields.GetField(pQ.ColName_SQL, hr)               ! Get the field object corresponding to the column name
          if hr = S_OK                                                   ! if There is a corresponding Field object
            hr = cCField.GetType(lDataType)
            if hr = S_OK
              case lDataType
              of adChar
                szValue &= new(cstring(len(clip(pQ.ColValue)) + 1))
                szValue = pQ.ColValue
                aVariant = szValue
                dispose(szValue)                                      
              else
                aVariant = pQ.ColValue
              end
              hr = cCField.PutValue(NewValue)                              ! And update the value of the Field object
              if hr ~= S_OK                                                ! Check if something went wrong
                RetValue = false
              end
            end
          end
        end
        hr = SELF.RS.UpdateBatch()                                       ! Call the update process of the recordset
        if hr = S_Ok                                                     ! if everything is fine
          RetValue = true                                                ! return true to the caller
        end
      else
        RetValue = false
      end
    end

    return(RetValue)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.DeleteRow            procedure()
! -------------------------------------------------------------------------------------------------------------

hr          HRESULT
RetValue    byte

    code
    if self.SupportGrp.adDelete <> false   ! Is delete allowed? Yes,...
      RetValue = false
      hr = self.RS.Delete(adAffectCurrent)
      if hr = S_Ok
        hr = self.RS.UpdateBatch()
        if hr = S_Ok
          RetValue = true
        end
      end
    else
      RetValue = false ! Delete not allowed
    end
    return(RetValue)

! -------------------------------------------------------------------------------------------------------------
cCWAdo.ADO_SQL.Find             procedure(*cstring szCriteria)
! -------------------------------------------------------------------------------------------------------------

hr          HRESULT
RetValue    byte
vBookmark   like(gVariant)


    code
    hr = self.RS.MoveFirst()
    if hr = S_OK
      hr = Self.RS.GetBookmark(vBookmark)
      if hr = S_OK
        hr = self.RS.Find(szCriteria, 0, adSearchForward, vBookmark)
        if hr = S_OK
          RetValue = true
        else
          RetValue = false
        end
      end
    end
    return(RetValue)

! -------------------------------------------------------------------------------------------------------------
cCWADO.ADO_SQL._Sort        procedure(*cstring szSort)
! -------------------------------------------------------------------------------------------------------------

hr          HRESULT
RetValue    byte
Pos         long
szTemp      &cstring
LenNeeded   long

    code

    RetValue = false
    if self.CursorLocation = adUseClient    ! The sort property in ADO works only with Client side cursor.
      self.szSortStr = left(szSort)
      hr = self.RS.PutSort(szSort)
      if hr = S_OK
        hr = self.RS.MoveFirst()
        if hr = S_Ok
          RetValue = true
        end
      end
    else
      ! Sort property cannot be used, will try to contruct an ORDER BY and generate a new Recordset
      ! First check if the query has already an ORDER BY clause
      Pos = instring('ORDER BY', upper(self.szQuery), 1, 1)
      if Pos
        LenNeeded = Pos + len('ORDER BY ') + len(szSort)  ! Calculate the len needed for the string in order to apply the new ORDER BY
        szTemp &= new (cstring(LenNeeded + 1))
        if ~szTemp &= null
          szTemp = self.szQuery[1 : Pos - 1] & 'ORDER BY ' & szSort
          dispose(self.szQuery)
          self.szQuery &= new(cstring(LenNeeded + 1))
          self.szQuery = szTemp
          dispose(szTemp)
        end
      else
        LenNeeded = len(self.szQuery) & len(' ORDER BY ') & len(szSort)
        szTemp &= new (cstring(LenNeeded + 1))
        if ~szTemp &= null
          szTemp = clip(self.szQuery) & ' ORDER BY ' & szSort
          dispose(self.szQuery)
          self.szQuery &= new(cstring(LenNeeded + 1))
          self.szQuery = szTemp
          dispose(szTemp)
        end
      end
      if self.ADO_SQL.ExecuteQuery(self.szQuery).
    end
    return(RetValue)
    
    
cCWADO.AddFieldsInfo         procedure(string pTableName, string pColName, *? pTargetVar, short pDateTimeID)
 CODE
    SELF.Mapper.AddFieldsInfo(pTableName, pColName,pTargetVar, pDateTimeID)
    
    
cCWADO.AddFieldsInfo         procedure(string pTableName, *group pFileRecord)
 CODE
    SELF.Mapper.AddFieldsInfo(pTableName,pFileRecord)
