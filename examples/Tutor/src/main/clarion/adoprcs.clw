    MEMBER
 INCLUDE('ADOPrcs.INC'),ONCE
 INCLUDE('ABERROR.INC'),ONCE
    MAP
    END
!***************************************************************************
ADOProcessManagerClass.Init                PROCEDURE(*CRecordSet pRecordSet)
 CODE
    SELF.RecordSet &= pRecordSet
    SELF.Init()

ADOProcessManagerClass.Init                PROCEDURE(*TableMapper pMapper)
 CODE
    SELF.Mapper &= pMapper
    SELF.Init()

ADOProcessManagerClass.Init                PROCEDURE(*CRecordSet pRecordSet,*TableMapper pMapper)
 CODE
    SELF.RecordSet &= pRecordSet
    SELF.Mapper &= pMapper
    SELF.Init()

ADOProcessManagerClass.Init                PROCEDURE()
 CODE
    IF SELF.Mapper &= NULL THEN
       SELF.Mapper &= NEW(TableMapper)
       SELF.MPCreated = True
    ELSE
       SELF.MPCreated = False
    END
    IF SELF.RecordSet &= NULL THEN
       SELF.RecordSet &= NEW(CRecordSet)
       SELF.RSCreated = True
    ELSE
       SELF.RSCreated = False
    END
    PARENT.Init()
    SELF.HR = SELF.Recordset.Init()

ADOProcessManagerClass.Kill                PROCEDURE()
 CODE
    IF SELF.RSCreated THEN
       DISPOSE(SELF.Mapper)
    END
    IF SELF.MPCreated THEN
       DISPOSE(SELF.RecordSet)
    END

ADOProcessManagerClass.SetQuery            PROCEDURE(STRING pQuery)
 CODE
    SELF.Query = pQuery

ADOProcessManagerClass.AddFieldsInfo       PROCEDURE(STRING pTableName, STRING pColName, *? pTargetVar, SHORT pDateTimeID)
 CODE
    ASSERT(NOT SELF.Mapper &= NULL)
    SELF.Mapper.AddFieldsInfo(pTableName, pColName, pTargetVar, pDateTimeID)

ADOProcessManagerClass.AddFieldsInfo       PROCEDURE(STRING pTableName, *GROUP pFileRecord)
 CODE
    ASSERT(NOT SELF.Mapper &= NULL)
    SELF.Mapper.AddFieldsInfo(pTableName, pFileRecord)

ADOProcessManagerClass.GetEOF              PROCEDURE()
LOCRecordset_Eof    SHORT
 CODE
    SELF.HR = SELF.Recordset.GetEOF(LOCRecordset_Eof)
    RETURN LOCRecordset_Eof

ADOProcessManagerClass.Open                PROCEDURE(*CConnection Conn, LONG CursorType, LONG LockType, LONG Options)
LOCRecordset_Eof    SHORT
LOCRecordset_Bof    SHORT
 CODE
    SELF.Open()
    ASSERT(NOT SELF.Recordset &= NULL)
    IF SELF.HR = S_OK THEN
       SELF.HR = SELF.Recordset.Open(SELF.Query, Conn, CursorType, LockType, Options)
       IF SELF.HR = S_OK THEN
          SELF.HR = SELF.Recordset.GetBOF(LOCRecordset_Bof)
          SELF.HR = SELF.Recordset.GetEOF(LOCRecordset_Eof)
          IF LOCRecordset_Bof <> False AND LOCRecordset_Eof <> False THEN
             RETURN False
          ELSE
?            assert(NOT SELF.Mapper &= NULL)
            SELF.Mapper.Map(SELF.Recordset)
            self.FirstRecordProc = false
          END
          SELF.RSConnection &= Conn
       END
    END
    RETURN True

ADOProcessManagerClass.Next                PROCEDURE()
LOCRecordset_Eof    SHORT
 CODE
    if self.FirstRecordProc = false
      self.FirstRecordProc = true
      return true
    else
      SELF.HR = SELF.Recordset.MoveNext()
      SELF.HR = SELF.Recordset.GetEOF(LOCRecordset_Eof)
      if LOCRecordset_Eof = False
        ASSERT(NOT SELF.Mapper &= NULL)
        SELF.Mapper.Map(SELF.Recordset)
        IF SELF.HR = S_OK THEN
          RETURN True
        ELSE
          RETURN False
        END
      else
        return false
      end
    end

ADOProcessManagerClass.GetRecordsToProcess PROCEDURE()

LOCRecordset_Count        LONG
lFromIndex                LONG
lComaIndex                LONG

RSCount                   &CRecordset
szCountStr                &cstring
szSize                    long

MapperGrp                 group
RecCount                    long
                          end
                          
CountMapper               TableMapper           

 CODE
    SELF.HR = SELF.Recordset.GetRecordCount(LOCRecordset_Count)
    if self.HR = S_OK
      if locRecordset_Count < 0   ! GetRecordCount is not supported
        RSCount &= new(CRecordset)
        self.HR = RSCount.Init()
        if self.HR = S_OK
          ASSERT(~SELF.RSConnection &= NULL)
          lFromIndex = INSTRING(' FROM ',UPPER(SELF.Query), 1, 1)
          szSize = len('SELECT ' & ' COUNT(*) as RecCount' & ' ' & SELF.Query[lFromIndex : (LEN(SELF.Query))]) + 1
          szCountStr &= new(cstring(szSize))
          szCountStr = 'SELECT ' & ' COUNT(*) as RecCount' & ' ' & SELF.Query[lFromIndex : (LEN(SELF.Query))]
          self.HR = RSCount.Open(szCountStr, self.RSConnection, adOpenForwardOnly, adLockOptimistic, adCmdText)
          if self.HR = S_OK
            CountMapper.MapRsToGroup(RSCount, MapperGrp)
            LOCRecordset_Count = MapperGrp.RecCount
            RSCount.Close()
            dispose(RSCount)
            dispose(szCountStr)
          end  
        end
      end
    else
    end
!    IF SELF.HR is error THEN
!       ASSERT(~SELF.RSConnection &= NULL)
!       lFromIndex = INSTRING(' FROM ',UPPER(SELF.Query))
!       IF NOT lFromIndex THEN
!          RETURN 0
!       ELSE
!          !EXECUTE_QUERY METHOD MISSING
!          'SELECT '&' COUNT(*)'&' '&SELF.Query[lFromIndex:(LEN(SELF.Query))]
!          lComaIndex = INSTRING(',',UPPER(SELF.Query),1,1)
!          IF lComaIndex>lFromIndex OR lComaIndex=0 THEN
!              'SELECT '&' COUNT('&SELF.Query[7:(lFromIndex-1)]&')'&' '&SELF.Query[lFromIndex:(LEN(SELF.Query))]
!          ELSE
!              'SELECT '&' COUNT('&SELF.Query[7:(lComaIndex-1)]&')'&' '&SELF.Query[lFromIndex:(LEN(SELF.Query))]
!          END
!       END
!
!    END

    RETURN LOCRecordset_Count

!***************************************************************************
