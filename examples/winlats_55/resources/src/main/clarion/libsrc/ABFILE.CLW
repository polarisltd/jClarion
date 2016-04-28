  MEMBER

TraceFiles EQUATE(0)

FileIDType        EQUATE(LONG)                  !Data type for unique reference to file

    MAP
ConcatGetComponents   PROCEDURE(KeyFieldQueue,*CSTRING,BYTE HowMany),PRIVATE
DupString             PROCEDURE(STRING),*STRING
CasedValue            PROCEDURE(STRING FieldName,*? Field,? FieldValue),STRING
LocalAction           PROCEDURE(BYTE Mode),BYTE,PRIVATE
CleanUp               PROCEDURE(FileManager)
OpCodeCanBeDone       PROCEDURE(SIGNED opCode),BYTE
    END

    INCLUDE('ABFILE.INC'),ONCE
    INCLUDE('ABUTIL.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE

FileMapping                   QUEUE              ! This queue maps file labels <-> filemanagers
FileLabel                       FileIDType
FileManager                     &FileManager
                              END

RelationQueue                 QUEUE,TYPE              ! List of all related files
File                            &RelationManager      ! Related file
Fields                          &BufferedPairsClass   ! List of linking fields
HisKey                          &KEY                  ! Only filled in for 1:MANY relationships
UpdateMode                      BYTE                  ! Action on Update RI flag
DeleteMode                      BYTE                  ! Action on Delete RI flag
                              END

FileThreadQueue               QUEUE,TYPE         ! QUEUE of status of all file buffers
Id                              SIGNED           ! Thread number
Used                            BYTE             ! Set True when file is -actually- opened
Opened                          USHORT           ! File opened counter
AtEOF                           BYTE             ! End of File flag
AutoIncDone                     BYTE             ! Auto-increment done or not flag
LastError                       BYTE             ! Last error identifier
                              END

KeyFieldQueue                 QUEUE,TYPE         ! QUEUE of all key components
Field                           ANY              ! Key component
FieldName                       &STRING          ! This should contain the UPPER for a case insensitive field
Ascend                          BYTE             ! Ascending/descending flag
                              END

FileKeyQueue                  QUEUE,TYPE         ! QUEUE of all keys in a file
Key                             &KEY             ! Reference to a KEY
Description                     STRING(80)       ! Key description text (from Data dictionary)
Fields                          &KeyFieldQueue   ! Reference to key components queue
AutoInc                         BYTE             ! Auto-increment flag (from Data dictionary)
Dups                            BYTE             ! Duplicates allowed flag (from Data dictionary)
NoCase                          BYTE             ! Case sensitive flag (from Data dictionary)
                              END


FieldsList                    QUEUE,TYPE
Tag                             ASTRING
Fld                             ANY
fType                           ASTRING
fPicture                        ASTRING
                              END


SaveQueue                     QUEUE,TYPE
Buffer                          USHORT
Id                              USHORT
AutoIncDone                     BYTE
State                           LONG
Pos                             STRING(1024)
                              END

Epoc LONG(1)

  COMPILE('***',TraceFiles)
Trace FILE,DRIVER('ASCII'),CREATE
R RECORD
B STRING(1000)
  END
  END
  ***

StatusQ QUEUE
Thread  LONG
Proc    ASTRING
ID      FileIDType
UStat   BYTE
Hold    USHORT
ScopeLevel USHORT
NestedOpen USHORT
  END

FilesManager CLASS
Errs              &ErrorClass
AddFileMapping    PROCEDURE(FileManager FM),PRIVATE
Construct         PROCEDURE
Destruct          PROCEDURE
FindRecord        PROCEDURE(FileManager FM),BYTE
GetFileID         PROCEDURE(File ThisFile),FileIDType
GetFileMapping    PROCEDURE(FileIDType FileLabel)
NoteClose         PROCEDURE(FileManager FM)
NoteOpen          PROCEDURE(FileManager FM)
NoteUsage         PROCEDURE(FileManager FM,BYTE Level)
RemoveFileMapping PROCEDURE(FileIdType FileLabel)
RemoveFileMapping PROCEDURE(FileManager FM)
Trace             PROCEDURE(STRING S)
  END

! DbAudit Data
szDbTextLog     CSTRING(FILE:MaxFilePath+1)


FilesManager.NoteUsage PROCEDURE(FileManager FM,BYTE Level)
  CODE
  IF SELF.FindRecord(FM)
    StatusQ.ScopeLevel = 0
    DO AddQ
  ELSIF StatusQ.Proc = SELF.Errs.GetProcedureName()
    IF Level > StatusQ.Ustat
      StatusQ.Ustat = Level
    COMPILE('***',TraceFiles)
      SELF.Trace('New Level :'&StatusQ.Proc&'('&StatusQ.ScopeLevel&'):'&StatusQ.Ustat)
    ***
      PUT(StatusQ)
    END
  ELSE
    DO AddQ
!   IF Level <> UseType:Returns AND ~StatusQ.Hold
    IF Level < UseType:Returns AND ~StatusQ.Hold
    COMPILE('***',TraceFiles)
      SELF.Trace('**Record getting clobbered')
    ***
      StatusQ.Hold = FM.SaveFile()
      PUT(StatusQ)
    END
  END

AddQ ROUTINE
    StatusQ.Proc = SELF.Errs.GetProcedureName()
    StatusQ.Ustat = Level
    StatusQ.ScopeLevel += 1
    StatusQ.Hold = 0
    StatusQ.NestedOpen = 0
    COMPILE('***',TraceFiles)
      SELF.Trace('New Scope :'&CLIP(FM.GetName())&'('&StatusQ.ScopeLevel&'):'&StatusQ.Ustat)
    ***
    ADD(StatusQ)

FilesManager.NoteOpen  PROCEDURE(FileManager FM)
  CODE
  IF ~SELF.FindRecord(FM) AND StatusQ.Proc=SELF.Errs.GetProcedureName()
    StatusQ.NestedOpen += 1
    COMPILE('***',TraceFiles)
      SELF.Trace('Nested Open:'&CLIP(FM.GetName())&':'&StatusQ.NestedOpen)
    ***
    PUT(StatusQ)
  END

FilesManager.NoteClose PROCEDURE(FileManager FM)
  CODE
  IF ~SELF.FindRecord(FM) AND StatusQ.Proc=SELF.Errs.GetProcedureName()
    IF StatusQ.NestedOpen
      StatusQ.NestedOpen -= 1
      PUT(StatusQ)
    COMPILE('***',TraceFiles)
      SELF.Trace('Un-nesting Open:'&CLIP(FM.GetName())&':'&StatusQ.NestedOpen)
    ***
    ELSE
    COMPILE('***',TraceFiles)
      SELF.Trace('Cleanup:'&CLIP(FM.GetName())&'('&StatusQ.ScopeLevel&'):'&StatusQ.Ustat)
    ***
      IF StatusQ.Hold
      COMPILE('***',TraceFiles)
        IF StatusQ.Ustat < UseType:Returns
          SELF.Trace('**Restoring:'&CLIP(FM.GetName()))
        ELSE
          SELF.Trace('**Discarding:'&CLIP(FM.GetName()))
        END
      ***
        FM.RestoreFile(StatusQ.Hold,CHOOSE(StatusQ.Ustat < UseType:Returns))
      END
      DELETE(StatusQ)
    END
  END

FilesManager.FindRecord PROCEDURE(FileManager FM)
FID LONG,AUTO
Th  LONG,AUTO
  CODE
  SORT(StatusQ,StatusQ.Thread,StatusQ.Id,StatusQ.ScopeLevel)
  Fid = SELF.GetFileID(FM.File)
  StatusQ.Id = Fid
  Th = THREAD()
  StatusQ.Thread = Th
  StatusQ.ScopeLevel = 1
  GET(StatusQ,StatusQ.Thread,StatusQ.Id,StatusQ.ScopeLevel)
  IF ERRORCODE() THEN RETURN Level:Notify.
  LOOP WHILE StatusQ.Thread = Th AND StatusQ.Id = Fid
    GET(StatusQ,POINTER(StatusQ)+1)
    IF ERRORCODE()
      GET(StatusQ,POINTER(StatusQ))
      RETURN Level:Benign
    END
  END
  GET(StatusQ,POINTER(StatusQ)-1)
  RETURN Level:Benign

FilesManager.Trace PROCEDURE(STRING S)
  CODE
  COMPILE('***',TraceFiles)
  Trace.R.B = SELF.Errs.GetProcedureName() &'(' & THREAD() & '):' & CLIP(S)
  ADD(Trace)
  ***

FilesManager.Construct PROCEDURE
  CODE
  COMPILE('***',TraceFiles)
  CREATE(Trace)
? ASSERT(~ERRORCODE(),'Unable to create trace file')
  OPEN(Trace)
? ASSERT(~ERRORCODE(),'Unable to open trace file')
  ***

FilesManager.Destruct PROCEDURE
  CODE
  COMPILE('***',TraceFiles)
  CLOSE(Trace)
  ***

FilesManager.AddFileMapping PROCEDURE(FileManager FM)

  CODE
    SELF.Errs &= FM.Errors                  ! more -- only assign once?
    FileMapping.FileLabel=SELF.GetFileID(FM.File)
    GET(FileMapping,FileMapping.FileLabel)
?   ASSERT(ERRORCODE(),'Mapping for file already exists')
    FileMapping.FileLabel=SELF.GetFileID(FM.File)
    FileMapping.FileManager &= FM
    ADD(FileMapping,FileMapping.FileLabel)
?   ASSERT(~ERRORCODE(),'Error appending to ordered queue')


FilesManager.RemoveFileMapping PROCEDURE(FileManager FM)

  CODE
    SELF.RemoveFileMapping(FilesManager.GetFileID(FM.File))


FilesManager.RemoveFileMapping PROCEDURE(FileIDType FileLabel)

  CODE
    SELF.GetFileMapping(FileLabel)
    DELETE(FileMapping)
?   ASSERT(~ERRORCODE(),'Delete failed on queue')


FilesManager.GetFileMapping PROCEDURE(FileIDType FileLabel)

  CODE
    FileMapping.FileLabel=FileLabel
    GET(FileMapping,FileMapping.FileLabel)
?   ASSERT(~ERRORCODE(),'File mapping not found')


!The following procedure returns a unique, application global, file ID

FilesManager.GetFileID PROCEDURE(FILE ThisFile)

MyGrp   GROUP                                         !DABMORE - the word HACK springs to mind FILE{PROP:Label} would be better
Fr        &FILE
        END
MyHash  LONG,OVER(MyGrp)

  CODE
  MyGrp.Fr &= ThisFile
  RETURN MyHash

OpCodeCanBeDone  PROCEDURE (opCode)
  CODE
    CASE opCode
    OF   DriverOp:DESTROY
    OROF DriverOp:Close
    OROF DriverOp:GetNulls
    OROF DriverOp:SetNulls
      RETURN TRUE
    ELSE
      RETURN FALSE
    END

FileManager.FileCallBackInterface.FunctionCalled PROCEDURE(SIGNED opCode, *Params Parameters, *CSTRING ErrCode, *CSTRING ErrMsg)
  CODE
    IF opCode = DriverOp:Close AND SELF.InRestore AND SELF.Info.Opened
      ! File is being closed by a call to RESTORESTATE().
      ! Need to make filemanager aware of the close.
      SELF.Info.Opened = 0
      SELF.Info.Used=False
      PUT(SELF.Info)
?     ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
      SELF.Close()
?   ELSIF opCode = DriverOp:Close AND ~SELF.InClose AND ~SELF.InRestore AND SELF.Info.Opened
?     SELF.InCallBack += 1
?     ASSERT(FALSE, 'You are calling CLOSE(' & NAME(SELF.File) & ') instead of FileManager.Close()')
?     SELF.InCallBack -= 1
    END
    IF opCode = DriverOp:Destroy
      SELF.InCallBack += 1
      IF ~Parameters.Index
        ! File destructor being called.  Make sure associated file manager killed first
        SELF.Cleanup()
      ELSIF SELF.Info.Used
?       ASSERT(FALSE, 'You have not called FileManager.Close() for ' & NAME(SELF.File))
      END
      SELF.InCallBack -= 1
    END
?   SELF.InRestore = CHOOSE(opCode = DriverOp:RestoreState)
    RETURN TRUE

FileManager.FileCallBackInterface.FunctionDone   PROCEDURE(SIGNED opCode, *Params Parameters, *CSTRING ErrCode, *CSTRING ErrMsg)
  CODE
?    IF ERRORCODE() = NotOpenErr AND NOT OpCodeCanBeDone(opCode) AND SELF.LazyOpen AND ~SELF.Info.Used AND ~SELF.InUseFile AND ~SELF.InCallBack
?      SELF.InCallBack += 1
?      ASSERT(FALSE, 'You have not called FileManager.UseFile() for ' & NAME(SELF.File))
?      SELF.InCallBack -= 1
?    END
?    IF opCode = DriverOp:RestoreState
?      SELF.InRestore = FALSE
?    END
    RETURN TRUE

FileManager.Destruct PROCEDURE
  CODE
    SELF.Kill()

! Add a record to a file. Make sure record is valid and perform any
! required autoincrement operations.
! This function must handle errors itself to get the job done
FileManager.Insert PROCEDURE
  CODE
    RETURN SELF.InsertServer(1)

FileManager.AddKey PROCEDURE(KEY k,STRING Desc,BYTE AutoInc)
CF  UNSIGNED,AUTO
FB  CSTRING(1000),AUTO
I   BYTE,AUTO
  CODE
    SELF.Keys.Key &= k
    SELF.Keys.Description = Desc
    SELF.Keys.Fields &= NEW KeyFieldQueue
    SELF.Keys.AutoInc = AutoInc
    IF AutoInc
      SELF.HasAutoInc = 1
    END
    SELF.Keys.Dups = k{PROP:Dup}
    SELF.Keys.NoCase = k{PROP:NoCase}
    ADD(SELF.Keys)
    IF k{PROP:Primary}
      SELF.PrimaryKey = RECORDS(SELF.Keys)
    END
    LOOP I = 1 TO K{PROP:Components}
      CLEAR(SELF.Keys.Fields)
      SELF.Keys.Fields.Ascend = K{PROP:Ascending,I}
      CF = K{PROP:Field,I}
      SELF.Keys.Fields.Field &= WHAT(SELF.Buffer,CF)
      FB = SELF.File{PROP:Label,CF}
      SELF.Keys.Fields.FieldName &= DupString(CHOOSE(SELF.Keys.NoCase AND IsString(SELF.Keys.Fields.Field),'UPPER('&FB&')',FB))
      ADD(SELF.Keys.Fields)
    END

! Add a record to a file. Make sure record is valid and perform any
! required autoincrement operations.
! This function will return upon an error setting lasterror
FileManager.TryInsert PROCEDURE
  CODE
    RETURN SELF.InsertServer(0)

! Add a record to a file. Make sure record is valid and perform any
! required autoincrement operations.
! HandleError state hinges on a parameter
FileManager.InsertServer PROCEDURE(BYTE HandleError)
I SIGNED,AUTO
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
    IF SELF.ValidateRecord()
      RETURN Level:Notify
    END
    IF SELF.HasAutoInc
      IF SELF.Info.AutoIncDone
        PUT(SELF.File)
      ELSE
        IF HandleError AND SELF.PrimeAutoInc() OR ~HandleError AND SELF.TryPrimeAutoInc()
          RETURN Level:Notify
        END
      END
    ELSE
      ADD(SELF.File)
    END
    CASE ERRORCODE()
    OF NoError
      SELF.Info.AutoIncDone = 0
      PUT(Self.Info)
?     ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
      RETURN Level:Benign
    OF DupKeyErr
      IF HandleError
        IF ~SELF.HasAutoInc
          GET(SELF.File,0)      ! Flag for DUPLICATE function
        END
        LOOP I = 1 TO RECORDS(SELF.Keys)
          GET(SELF.Keys,I)
          IF DUPLICATE(SELF.Keys.Key)
            SELF.ThrowMessage(Msg:DuplicateKey,SELF.Keys.Description)
            RETURN Level:Notify
          END
        END
      ELSE
        SELF.SetError(Msg:DuplicateKey)
      END
    ELSE
      SELF.SetError(Msg:AddFailed)
      IF HandleError
        RETURN SELF.Throw()
      END
    END
    RETURN Level:Notify


! Cancel an autoincrement operation if there was one
FileManager.CancelAutoInc PROCEDURE(<RelationManager R>)
RetVal BYTE(Level:Benign)
  CODE
    IF ~SELF.UseFile()
      IF SELF.HasAutoInc AND SELF.Info.AutoIncDone
        IF R &= NULL
          DELETE(SELF.File)
        ELSE
          RetVal = R.Delete(0)
        END
        IF ~RetVal
          SELF.Info.AutoIncDone = 0
          PUT(SELF.Info)
?         ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
        END
      END
    END
    RETURN RetVal

! This routine primes the auto increment fields of a record
! A key part of the specification is that fields values
! (other than autoincrement ones) are -not- corrupted.
FileManager.PrimeAutoIncServer PROCEDURE(BYTE HandleError)
I SHORT,AUTO
SaveKeys CSTRING(2000),AUTO
NewKeys  CSTRING(2000),AUTO
SaveRec  USHORT,AUTO
AutoVal  ANY
AutoIncField ANY
Attempts BYTE(0)
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
    IF ~SELF.HasAutoInc OR SELF.Info.AutoIncDone
      RETURN Level:Benign
    END
    LOOP
      LOOP I = 1 TO RECORDS(SELF.Keys)
        GET(SELF.Keys,I)
        IF SELF.Keys.AutoInc
! For each key with autoincrement try to find a valid new component value
          SaveRec = SELF.SaveBuffer()
          NOMEMO(SELF.File)
          IF RECORDS(SELF.Keys.Fields) = 1
            GET(SELF.Keys.Fields,1)
            AutoIncField &= SELF.Keys.Fields.Field
            SET(SELF.Keys.Key)
            IF SELF.Keys.Fields.Ascend
              PREVIOUS(SELF.File)
            ELSE
              NEXT(SELF.File)
            END
            CASE ERRORCODE()
            OF NoError
              AutoVal = AutoIncField + 1
            OF BadRecErr
              AutoVal = 1
            ELSE
              SELF.SetError(Msg:AbortReading)
              IF HandleError
                RETURN SELF.Throw()
              ELSE
                RETURN Level:Notify
              END
            END
          ELSE
            ConcatGetComponents(SELF.Keys.Fields,SaveKeys,SELF.Keys.AutoInc-1)
            GET(SELF.Keys.Fields,SELF.Keys.AutoInc)
            AutoIncField &= SELF.Keys.Fields.Field
            CLEAR(AutoIncField,1)
            SET(SELF.Keys.Key,SELF.Keys.Key)
            IF SELF.Keys.Fields.Ascend
              PREVIOUS(SELF.File)
            ELSE
              NEXT(SELF.File)
            END
            CASE ERRORCODE()
            OF NoError
              ConcatGetComponents(SELF.Keys.Fields,NewKeys,SELF.Keys.AutoInc-1)
              IF SaveKeys = NewKeys
                AutoVal = AutoIncField + 1
              ELSE
                AutoVal = 1
              END
            OF BadRecErr
              AutoVal = 1
            ELSE
              SELF.SetError(Msg:AbortReading)
              IF HandleError
                RETURN SELF.Throw()
              ELSE
                RETURN Level:Notify
              END
            END
          END
          SELF.RestoreBuffer(SaveRec)
          AutoIncField = AutoVal
        END
      END
      ADD(SELF.File)
      IF ERRORCODE()
        Attempts += 1
      ! This probably means someone else got there first
      ! In a 'heavy' usage network a number > 3 might be useful
      ! although the machine will go 'dead' for longer
        IF Attempts = 3
          SELF.SetError(Msg:RetryAutoInc)
          IF HandleError
            IF ~Self.Throw()
              Attempts = 0
              CYCLE
            END
          END
          RETURN Level:Notify
        END
      ELSE
        SELF.Info.AutoIncDone = 1
        PUT(SELF.Info)
        RETURN Level:Benign
      END
    END
?   ASSERT(0,'Coding error, this point should not be reachable')

FileManager.PrimeAutoInc PROCEDURE
  CODE
    RETURN SELF.PrimeAutoIncServer(1)

FileManager.TryPrimeAutoInc PROCEDURE
  CODE
    RETURN SELF.PrimeAutoIncServer(0)

FileManager.BindFields PROCEDURE
  CODE
    BIND(SELF.Buffer)

FileManager.ClearKey     PROCEDURE(KEY K,BYTE LowComp,BYTE HighComp,BYTE High)
I BYTE,AUTO
  CODE
    SELF.SetKey(K)
    LOOP I = LowComp TO HighComp
      GET(SELF.Keys.Fields,I)
      IF ERRORCODE()
        RETURN
      END
      IF SELF.Keys.Fields.Ascend XOR High
        CLEAR(SELF.Keys.Fields.Field,-1)
      ELSE
        CLEAR(SELF.Keys.Fields.Field,1)
      END
    END

! Close errors are considered unimportant so this routine simply
! glosses over them
FileManager.Close PROCEDURE

  CODE
    SELF.InClose += 1
    SELF.SetThread
    FilesManager.NoteClose(SELF)
    IF SELF.Info.Opened
      SELF.Info.Opened -= 1
      IF ~SELF.Info.Opened
        CLOSE(SELF.File)
        SELF.Info.Used=False
      END
      PUT(SELF.Info)
?     ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
    END
    SELF.InClose -= 1
    RETURN Level:Benign

FileManager.GetComponents PROCEDURE(KEY K)
  CODE
    SELF.SetKey(K)
    RETURN RECORDS(SELF.Keys.Fields)

FileManager.GetError PROCEDURE
  CODE
    SELF.SetThread
    RETURN SELF.Info.LastError

! Scan through list of key information and select information for given key
FileManager.SetKey PROCEDURE(KEY K)
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Keys)
      GET(SELF.Keys,I)
    UNTIL SELF.Keys.Key &= K
?   ASSERT(SELF.Keys.Key &= K,'Key does not exist in this file')

FileManager.GetField PROCEDURE(KEY K,BYTE B)
  CODE
    SELF.SetKey(K)
    GET(SELF.Keys.Fields,B)
?   ASSERT(~ERRORCODE(),'Key does not have component of this number :'&B)
    RETURN SELF.Keys.Fields.Field

FileManager.GetFieldName PROCEDURE(KEY K,BYTE B)
  CODE
    SELF.SetKey(K)
    GET(SELF.Keys.Fields,B)
?   ASSERT(~ERRORCODE(),'Key does not have component of this number :'&B)
    RETURN SELF.Keys.Fields.FieldName

FileManager.GetFieldName PROCEDURE(*? Fld)
FNum LONG,AUTO
  CODE
    FNum = WHERE(SELF.Buffer,Fld)
    RETURN WHO(SELF.Buffer,FNum)

! The semantic for a failed get is simply to clear down the buffer
FileManager.Fetch PROCEDURE(KEY Key)
ReturnCode BYTE,AUTO
  CODE
    ReturnCode = SELF.TryFetch(Key)
    IF ReturnCode
      CLEAR(SELF.File)
    END
    RETURN ReturnCode

FileManager.TryFetch PROCEDURE(KEY Key)
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
?   SELF.SetKey(Key)        ! Simply an assert if the key is not in the file
    GET(SELF.File,Key)
    IF ERRORCODE()
      RETURN Level:Notify
    ELSE
      RETURN Level:Benign
    END

FileManager.GetName PROCEDURE
  CODE
    IF SELF.FileName &= NULL
      RETURN SELF.FileNameValue
    ELSE
      RETURN SELF.FileName
    END

FileManager.GetEOF PROCEDURE
  CODE
    SELF.SetThread
    RETURN SELF.Info.AtEOF

FileManager.Init PROCEDURE(File File,ErrorClass E)

  CODE
    SELF.Errors &= E
    SELF.File &= File
    SELF.Info &= NEW FileThreadQueue
    SELF.Keys &= NEW FileKeyQueue
    SELF.Buffers &= NEW BufferQueue
    SELF.Saved &= NEW SaveQueue
    SELF.Fields &= NEW FieldsList
    SELF.SkipHeldRecords = 0
    SELF.OpenMode = 42h
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.PrimaryKey = 0
    SELF.LazyOpen=True                              !Default behaviour is Lazy Open enabled
    SELF.FileNameValue = SELF.File{PROP:Name}
    FilesManager.AddFileMapping(SELF)
    SELF.CleanedUp = FALSE;
    CALLBACK(File, SELF.FileCallBackInterface)

FileManager.AddField PROCEDURE(ASTRING Tag, *? Fld, ASTRING fType, <ASTRING fPicture>)

  CODE
  IF SELF.FindField(Tag) THEN RETURN Level:Notify.  !Field with this tag already exists
  CLEAR(SELF.Fields)
  SELF.Fields.Tag = UPPER(Tag)
  SELF.Fields.Fld &= Fld
  SELF.Fields.fType = fType
  SELF.Fields.fPicture = CHOOSE(OMITTED(5) = True, '', fPicture)
  ADD(SELF.Fields, SELF.Fields.Tag)
  RETURN CHOOSE(ERRORCODE() = 0, Level:Benign, Level:Notify)


FileManager.FindField PROCEDURE(ASTRING Tag)

  CODE
  SELF.Fields.Tag = UPPER(Tag)
  GET(SELF.Fields, SELF.Fields.Tag)
  RETURN CHOOSE(ERRORCODE() = 0, True, False)


FileManager.GetField PROCEDURE(ASTRING Tag)

RVal    ANY,AUTO

  CODE
  IF SELF.FindField(Tag)
    RVal &= SELF.Fields.Fld
  ELSE
    RVal &= NULL
  END
  RETURN RVal


FileManager.GetFields PROCEDURE

  CODE
  RETURN RECORDS(SELF.Fields)


FileManager.GetField PROCEDURE(LONG Idx, *ASTRING Tag, *? Fld)

RVal  BYTE(Level:Notify)

  CODE
  IF INRANGE(Idx, 1, RECORDS(SELF.Fields))
    GET(SELF.Fields, Idx)
    IF ~ERRORCODE()
      Tag = SELF.Fields.Tag
      Fld &= SELF.Fields.Fld
      RVal = Level:Benign
    END
  END
  RETURN RVal


FileManager.GetFieldType PROCEDURE(ASTRING Tag)

  CODE
  RETURN CHOOSE(SELF.FindField(Tag) = True, SELF.Fields.fType, '')


FileManager.GetFieldPicture PROCEDURE(ASTRING Tag)

  CODE
  RETURN CHOOSE(SELF.FindField(Tag) = True, SELF.Fields.fPicture, '')


FileManager.KeyToOrder PROCEDURE(KEY K,BYTE B)
I BYTE,AUTO
RetVal CSTRING(512)
  CODE
    IF NOT K &= NULL
      IF ~B
        B = 1
      END
      SELF.SetKey(K)
      LOOP I = B TO RECORDS(SELF.Keys.Fields)
        GET(SELF.Keys.Fields,I)
        RetVal = RetVal & CHOOSE(RetVal = '','',',') & CHOOSE(SELF.Keys.Fields.Ascend <> 0,'','-') & SELF.Keys.Fields.FieldName
      END
    END
    RETURN RetVal

FileManager.CleanUp PROCEDURE
I SIGNED,AUTO
J SIGNED,AUTO
  CODE
    IF SELF.CleanedUp THEN RETURN.
    SELF.CleanedUp = TRUE;
    FilesManager.RemoveFileMapping(SELF)
    DISPOSE(SELF.Info)
    IF ~SELF.Keys &= NULL
      LOOP I = 1 TO RECORDS(SELF.Keys)
        GET(SELF.Keys,I)
        LOOP J = 1 TO RECORDS(SELF.Keys.Fields)
          GET(SELF.Keys.Fields,J)
          DISPOSE(SELF.Keys.Fields.FieldName)
          SELF.Keys.Fields.Field &= NULL
        END
        DISPOSE(SELF.Keys.Fields)
      END
      DISPOSE(SELF.Keys)
    END
    IF ~SELF.Buffers &= NULL
      LOOP I = 1 TO RECORDS(SELF.Buffers)
        GET(SELF.Buffers,I)
        DISPOSE(SELF.Buffers.Buffer)
      END
      DISPOSE(SELF.Buffers)
    END
    LOOP I = 1 TO RECORDS(SELF.Saved)
      GET(SELF.Saved, I)
      FREESTATE(SELF.File, SELF.Saved.State)
    END
    DISPOSE(SELF.Saved)
    IF ~SELF.Fields &= NULL
      LOOP I = 1 TO RECORDS(SELF.Fields)
        GET(SELF.Fields,I)
        SELF.Fields.Fld &= NULL
      END
      DISPOSE(SELF.Fields)
    END

    SELF.FileName &= NULL

FileManager.Kill PROCEDURE
  CODE
    SELF.CleanUp()
    IF NOT SELF.File &= NULL
      CALLBACK(SELF.File, SELF.FileCallBackInterface,TRUE)
    END

FileManager.NextServer PROCEDURE(BYTE HandleError,BYTE Prev)
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
    LOOP
      SELF.Info.AtEOF = 0
      PUT(SELF.Info)
?     ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
      IF Prev
        PREVIOUS(SELF.File)
      ELSE
        NEXT(SELF.File)
      END
      CASE ERRORCODE()
      OF BadRecErr
        SELF.Info.AtEOF = 1
        PUT(SELF.Info)
?       ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
        RETURN Level:Notify
      OF NoError
        RETURN Level:Benign
      OF IsHeldErr
        IF SELF.SkipHeldRecords
          CYCLE
        ELSE
          SELF.SetError(Msg:RecordHeld)
          IF HandleError
            RETURN SELF.Throw()
          ELSE
            RETURN Level:Notify
          END
        END
      ELSE
        SELF.SetError(Msg:AbortReading)
        IF HandleError
          RETURN SELF.Throw()
        ELSE
          RETURN Level:Fatal
        END
      END
    END

FileManager.Next PROCEDURE
  CODE
    RETURN SELF.NextServer(1)

FileManager.TryNext PROCEDURE
  CODE
    RETURN SELF.NextServer(0)

! This function 'clears' a record and performs auto-inc function where
! applicable.
FileManager.PrimeRecord PROCEDURE(BYTE SC)
BufferHandle  USHORT,AUTO
BH2           USHORT,AUTO
Result        BYTE,AUTO
  CODE
    IF SELF.AliasedFile&=NULL                             !
      IF ~SC
        CLEAR(SELF.File)
      END
      SELF.PrimeFields
      IF Self.HasAutoInc
        SELF.Info.AutoIncDone = 0
        PUT(SELF.Info)
        Result = SELF.PrimeAutoInc()
      ELSE
        Result = Level:Benign
      END
    ELSE
      SELF.AliasedFile.Open()
      BufferHandle=SELF.AliasedFile.SaveFile()
      IF SC
        BH2 = SELF.SaveBuffer()
        SELF.AliasedFile.RestoreBuffer(BH2,SELF)          ! Prime 'junk' into new record
      END
      Result=SELF.AliasedFile.PrimeRecord(SC)
      IF ~Result                                          !~Result == Level:Benign
        BH2 = SELF.AliasedFile.SaveFile()
        SELF.RestoreFile(BH2,SELF.AliasedFile)      ! Aliased file has 'full' primary characteristics restored
      END
      SELF.AliasedFile.RestoreFile(BufferHandle)
      SELF.AliasedFile.Close()
    END
    RETURN Result

FileManager.PrimeFields PROCEDURE
  CODE

FileManager.OpenServer PROCEDURE(BYTE HandleError,BYTE ForceOpen)
RVal BYTE,AUTO
  CODE
    SELF.SetThread
    FilesManager.NoteOpen(SELF)
    COMPILE('***',TraceFiles)
    IF TraceFiles
      FilesManager.Trace('Open'&CHOOSE(HandleError=1,'(Errors):',':')&SELF.GetName())
    END
    ***
    SELF.BindFields
    IF ForceOpen OR ~SELF.LazyOpen AND ~SELF.Info.Opened
      RVal = SELF.OpenFile(HandleError)
      IF RVal
        RETURN RVal
      END
    END
    SELF.Info.Opened += 1
    PUT(SELF.Info)
?   ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
    RETURN Level:Benign

! Create and Open mode are public fields of the file manager class
! which should be 'defaulted' in derived classes
! In the handled-error case the function will create or build a file
! in an attempt to get things working
FileManager.OpenFile PROCEDURE(BYTE HandleError)
  CODE
    COMPILE('***',TraceFiles)
    FilesManager.Trace('Open File:'&SELF.GetName())
    ***
    LOOP 2 TIMES  ! Allow 1 create or build cycle
      OPEN(SELF.File,SELF.OpenMode)
      IF ERRORCODE() = NoAccessErr
        SEND(SELF.File,'Recover='& SELF.LockRecover)
        OPEN(SELF.File,SELF.OpenMode)
      END
      CASE ERRORCODE()
      OF NoError OROF IsOpenErr
        SELF.Info.Used=True
        SELF.Info.AtEOF = 0
        SELF.Info.AutoIncDone = 0
        PUT(SELF.Info)
?       ASSERT(~ERRORCODE(),'Unable to store thread specific file information.')
        RETURN Level:Benign
      OF RecordLimitErr
        IF BAND(SELF.OpenMode,3)
          SELF.OpenMode = BAND(SELF.OpenMode,0F0H)
          SELF.Throw(Msg:RecordLimit)
          CYCLE
        END
      OF NoAccessErr
        IF BAND(SELF.OpenMode,3)
          SELF.OpenMode = BAND(SELF.OpenMode,0F0H)
          SELF.Throw(Msg:AccessDenied)
          CYCLE
        END
      OF NoFileErr
        IF SELF.Create
          CREATE(SELF.File)
          IF ERRORCODE()
            SELF.SetError(Msg:CreateFailed)
            DO AnError
          ELSE
            CYCLE
          END
        END
      OF BadKeyErr
        SELF.SetError(Msg:RebuildKey)
        IF HandleError
          SELF.Throw
          BUILD(SELF.File)
          IF ERRORCODE()
            RETURN SELF.Throw(Msg:RebuildFailed)
          ELSE
            CYCLE
          END
        ELSE
          RETURN Level:Notify
        END
      END
    UNTIL 1
    DO HardError

HardError ROUTINE
    SELF.SetError(Msg:OpenFailed)
    DO AnError

AnError ROUTINE
    IF HandleError
      RETURN SELF.Throw()
    END
    RETURN Level:Notify

FileManager.TryOpen PROCEDURE()
  CODE
    RETURN SELF.OpenServer(0)

FileManager.Open PROCEDURE()
  CODE
    RETURN SELF.OpenServer(1)

!This procedure forces the file open if it has already be 'opened' as a LazyFile
FileManager.UseFile PROCEDURE(BYTE Usage)
i       BYTE(Level:Benign)
SaveID  USHORT,AUTO
  CODE
    SELF.InUseFile = TRUE
    SELF.SetThread
    IF Usage <> UseType:Benign
      FilesManager.NoteUsage(SELF,Usage)
    END
    IF SELF.LazyOpen
      IF ~SELF.Info.Used
        IF SELF.Info.Opened<1                 !File not previously OPENed with explicit .Open or .TryOpen call
          SELF.InUseFile = FALSE
          RETURN SELF.Throw(Msg:UseClosedFile)
        END
        SaveID=SELF.SaveBuffer()              !File buffer saved so that SET(,key) etc work ok after real open
        i=SELF.OpenFile(1)              !if driver corrupts buffer when OPENed
        SELF.RestoreBuffer(SaveID,1)
      END
    END
    SELF.InUseFile = FALSE
    RETURN i

FileManager.Position PROCEDURE
  CODE
    IF SELF.UseFile() THEN RETURN ''.
    IF SELF.PrimaryKey
      GET(SELF.Keys,SELF.PrimaryKey)
      RETURN POSITION(SELF.Keys.Key)
    ELSE
      RETURN POSITION(SELF.File)
    END


FileManager.Previous PROCEDURE
  CODE
    RETURN SELF.NextServer(1,1)


FileManager.TryPrevious PROCEDURE
  CODE
    RETURN SELF.NextServer(0,1)

FileManager.Update PROCEDURE
  CODE
    RETURN SELF.UpdateServer(1)


FileManager.TryUpdate PROCEDURE
  CODE
    RETURN SELF.UpdateServer(0)


! In the handled-error case the buffer is re-freshed if PUT encounters
! a WATCH violation
FileManager.UpdateServer PROCEDURE(BYTE HandleError)
Hold  STRING(1024),AUTO
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
    IF SELF.ValidateRecord()
      RETURN Level:User
    END
    Hold = SELF.Position()
    PUT(SELF.File)
    CASE ERRORCODE()
    OF NoError
      RETURN Level:Benign
    OF RecordChangedErr
      SELF.SetError(CHOOSE(HandleError = 2,Msg:ConcurrencyFailedFromForm,Msg:ConcurrencyFailed))
      IF HandleError
        SELF.Throw
      END
      WATCH(SELF.File)
      SELF.TryReget(Hold)
    ELSE
      SELF.SetError(Msg:PutFailed)
      IF HandleError
        RETURN SELF.Throw()
      END
    END
    RETURN Level:Notify


FileManager.TryReget PROCEDURE(STRING P)
  CODE
    IF SELF.UseFile() THEN RETURN Level:Fatal.
    IF SELF.PrimaryKey
      GET(SELF.Keys,SELF.PrimaryKey)
      REGET(SELF.Keys.Key,P)
    ELSE
      REGET(SELF.File,P)
    END
    RETURN CHOOSE(ERRORCODE() = 0,Level:Benign,Level:Notify)

! Regresses a buffer (and memos) to the value from handle Id.
! The handle is invalidated by this option
FileManager.RestoreBuffer PROCEDURE(*USHORT Id,BYTE DoRestore)
  CODE
    SELF.RestoreBuffer(Id,SELF,DoRestore)

FileManager.RestoreBuffer PROCEDURE(*USHORT Id,FileManager Frm, BYTE DoRestore)
i SHORT,AUTO
Memos UNSIGNED,AUTO
  CODE
    IF ~Id AND ~DoRestore THEN RETURN .       ! Effectively DISPOSE(Null)
    Frm.Buffers.Id = Id
    GET(Frm.Buffers,Frm.Buffers.Id)
?   ASSERT(~ERRORCODE(),'Restore handle is invalid')
    IF DoRestore
      SELF.Buffer = Frm.Buffers.Buffer
    END
    DO KillBuffer
    Memos = SELF.File{PROP:Memos}
    LOOP I = 1 TO Memos
      Frm.Buffers.Id = Id + I
      GET(Frm.Buffers,Frm.Buffers.Id)
?     ASSERT(~ERRORCODE(),'Restore handle is invalid (memo does not appear to have been stored)')
      IF DoRestore
        SELF.File{PROP:Value,-I} = Frm.Buffers.Buffer
      END
      DO KillBuffer
    END
    Frm.Buffers.Id = Id + Memos + 1
    GET(Frm.Buffers,Frm.Buffers.Id)
?   ASSERT(~ERRORCODE(),'Restore handle is invalid (nullity information not appear to have been stored)')
    SETNULLS(SELF.File,Frm.Buffers.Buffer)
    DO KillBuffer
    Id = 0

KillBuffer ROUTINE
    DISPOSE(Frm.Buffers.Buffer)
    DELETE(Frm.Buffers)

FileManager.EqualBuffer PROCEDURE(*USHORT Id)
I SHORT,AUTO
  CODE
    IF SELF.UseFile() THEN RETURN 0.  ! Is this needed? Should a buffer compare require an open file?
    SELF.Buffers.Id = Id
    GET(SELF.Buffers,SELF.Buffers.Id)
?   ASSERT(~ERRORCODE(),'Restore handle is invalid')
    IF SELF.Buffer <> SELF.Buffers.Buffer THEN RETURN 0.
    LOOP I = 1 TO SELF.File{PROP:Memos}
      SELF.Buffers.Id = Id + I
      GET(SELF.Buffers,SELF.Buffers.Id)
?     ASSERT(~ERRORCODE(),'Restore handle is invalid (memo does not appear to have been stored)')
      IF SELF.File{PROP:Value,-I} <> SELF.Buffers.Buffer THEN RETURN 0.
    END
    RETURN 1


FileManager.RestoreFile PROCEDURE(*USHORT Id,BYTE DoRestore)
  CODE
    SELF.RestoreFile(Id,SELF,DoRestore)

FileManager.RestoreFile PROCEDURE(*USHORT Id,FileManager Frm,BYTE DoRestore)
K &KEY
  CODE
    IF ~SELF.UseFile()
      Frm.Saved.Id = Id
      GET(Frm.Saved,Frm.Saved.Id)
?     ASSERT(~ERRORCODE(),'Restore handle is invalid')
      IF DoRestore
        IF SELF.AliasedFile &= NULL
        RESTORESTATE(SELF.File,Frm.Saved.State)
        ELSE
          IF SELF.PrimaryKey
            GET(SELF.Keys,Frm.PrimaryKey)
            RESET(SELF.Keys.Key,Frm.Saved.Pos)
          ELSE
            RESET(SELF.File,Frm.Saved.Pos)
          END
          NEXT(SELF.File)
        END
      END
      SELF.RestoreBuffer(Frm.Saved.Buffer,Frm,DoRestore)
      IF DoRestore
        SELF.Info.AutoIncDone = Frm.Saved.AutoIncDone
        PUT(SELF.Info)
      END
      FREESTATE(SELF.File, Frm.Saved.State)
      DELETE(Frm.Saved)
      Id = 0
    END

FileManager.SetError PROCEDURE(USHORT Err)
  CODE
    SELF.Errors.SetErrors
    SELF.Info.LastError = Err
    PUT(SELF.Info)

FileManager.SetName PROCEDURE(STRING st)
  CODE
?   ASSERT(~ (SELF.FileName &= NULL),'Cannot perform SetName unless filename is a variable')
    SELF.FileName = st

FileManager.SetThread PROCEDURE
ThisThread SIGNED(1)
  CODE
    IF SELF.File{PROP:Thread}
      ThisThread = THREAD()
    END
?   ASSERT(~(SELF.Info &= NULL),'FileManager has not been correctly initialized')
    SELF.Info.Id = ThisThread
    GET(SELF.Info,SELF.Info.Id)
    IF ERRORCODE()
      CLEAR(SELF.Info)
      SELF.Info.Id = ThisThread
      ADD(SELF.Info,SELF.Info.Id)
?     ASSERT(~ERRORCODE(),'Unable to add thread specific file information')
    END
?   ASSERT(NOT SELF.File &= NULL,'FileManager has not been correctly initialized (missing file reference)')
    SELF.Errors.SetFile(SELF.GetName())

FileManager.SaveBuffer PROCEDURE
Id LONG,AUTO
I  BYTE,AUTO
Memos UNSIGNED,AUTO
  CODE
    Id = RECORDS(SELF.Buffers)
    IF Id
      GET(SELF.Buffers,Id)
?     ASSERT(~ERRORCODE(),'Saved buffer storage corrupt')
      Id = SELF.Buffers.Id + 1
    ELSE
      Id = 1
    END
    SELF.Buffers.Id = Id
    SELF.Buffers.Buffer &= DupString(SELF.Buffer)
    ADD(SELF.Buffers,SELF.Buffers.Id)
?   ASSERT(~ERRORCODE(),'Unable to save new buffer contents')
    Memos = SELF.File{PROP:Memos}
    LOOP I = 1 TO Memos
      SELF.Buffers.Id = Id + I
      SELF.Buffers.Buffer &= DupString(SELF.File{PROP:Value,-I})
      ADD(SELF.Buffers,SELF.Buffers.Id)
?     ASSERT(~ERRORCODE(),'Unable to save new buffer contents of memo')
    END
    SELF.Buffers.Id = Id + Memos + 1
    SELF.Buffers.Buffer &= DupString(GETNULLS(SELF.File)) ! Unsupported case handled with null string
    ADD(SELF.Buffers,SELF.Buffers.Id)
    RETURN Id

FileManager.SaveFile PROCEDURE
Id LONG,AUTO
  CODE
    Id = RECORDS(SELF.Saved)
    IF Id
      GET(SELF.Saved,Id)
?     ASSERT(~ERRORCODE(),'Saved file storage corrupt')
      Id = SELF.Saved.Id + 1
    ELSE
      Id = 1
    END
    SELF.Saved.Id = Id
    SELF.Saved.Buffer = SELF.SaveBuffer()
    SELF.Saved.State = GETSTATE(SELF.File)
    IF SELF.PrimaryKey
      GET(SELF.Keys,SELF.PrimaryKey)
      SELF.Saved.Pos = POSITION(SELF.Keys.Key)
    ELSE
      SELF.Saved.Pos = POSITION(SELF.File)
    END
    SELF.Saved.AutoIncDone = SELF.Info.AutoIncDone
    ADD(SELF.Saved)
    RETURN Id

FileManager.Throw PROCEDURE
  CODE
    RETURN SELF.Errors.TakeError(SELF.Info.LastError)

FileManager.Throw PROCEDURE(USHORT ErrNum)
  CODE
    SELF.SetError(ErrNum)
    RETURN SELF.Throw()

FileManager.ThrowMessage PROCEDURE(USHORT ErrNum,STRING Me)
  CODE
    RETURN SELF.Errors.ThrowMessage(ErrNum,Me)


FileManager.TryValidateField PROCEDURE(UNSIGNED Field)
  CODE
    RETURN SELF.ValidateFieldServer(Field, 0)


FileManager.ValidateField PROCEDURE(UNSIGNED Field)
  CODE
    RETURN SELF.ValidateFieldServer(Field, 1)


FileManager.ValidateFieldServer PROCEDURE(UNSIGNED Field,BYTE HandleErrors)
BufferHandle  USHORT,AUTO
RVal          BYTE(Level:Benign)
  CODE
    IF ~SELF.AliasedFile&=NULL
?     ASSERT(SELF.AliasedFile.AliasedFile&=NULL,'Cannot have alias based upon an alias')
      BufferHandle=SELF.AliasedFile.SaveBuffer()
      SELF.AliasedFile.Buffer=SELF.Buffer
      RVal=SELF.AliasedFile.ValidateField(Field)
      SELF.AliasedFile.RestoreBuffer(BufferHandle)
    END
    RETURN RVal


FileManager.ValidateFields PROCEDURE(UNSIGNED Low,UNSIGNED High,<*UNSIGNED U>)
BufferHandle  USHORT,AUTO
I             UNSIGNED,AUTO
RetVal        BYTE(Level:Benign)
  CODE
    IF SELF.AliasedFile&=NULL
      LOOP I = Low TO High
        RetVal = SELF.ValidateField(I)
        IF RetVal
          IF ~OMITTED(4)
            U = I
          END
          BREAK
        END
      END
    ELSE
?     ASSERT(SELF.AliasedFile.AliasedFile&=NULL,'Cannot have alias based upon an alias')
      BufferHandle=SELF.AliasedFile.SaveBuffer()
      SELF.AliasedFile.Buffer=SELF.Buffer
      RetVal=SELF.AliasedFile.ValidateFields(Low,High,U)
      SELF.AliasedFile.RestoreBuffer(BufferHandle)
    END
    RETURN RetVal


FileManager.ValidateRecord PROCEDURE(<*UNSIGNED U>)
BufferHandle  USHORT,AUTO
Result        BYTE,AUTO
  CODE
    IF SELF.AliasedFile&=NULL
      Result=SELF.ValidateFields(1,SELF.File{PROP:Fields},U)
    ELSE
?     ASSERT(SELF.AliasedFile.AliasedFile&=NULL,'Cannot have alias based upon an alias')
      BufferHandle=SELF.AliasedFile.SaveBuffer()
      SELF.AliasedFile.Buffer=SELF.Buffer
      Result=SELF.AliasedFile.ValidateRecord(U)
      SELF.AliasedFile.RestoreBuffer(BufferHandle)
    END
    RETURN Result

!! NEW METHODS
FileManager.DeleteRecord PROCEDURE(BYTE Query)
  CODE
  DELETE(SELF.File)
  RETURN(Level:Benign)

FileManager.Deleted PROCEDURE
  CODE
  RETURN(Level:Benign)
!! END NEW METHODS

ConcatGetComponents PROCEDURE(KeyFieldInfo Fields,*CSTRING Into,BYTE HowMany)
I BYTE,AUTO
  CODE
    Into = ''
    LOOP I = 1 TO HowMany
      GET(Fields,I)
      IF ERRORCODE()
        BREAK
      END
      Into = Into & Fields.Field & '|'
    END

! Choose the buffer size for a given string
! Must be at least one byte but other than that may clip
! Then allocate string and copy in value
DupString PROCEDURE(STRING St)
SizeIs SIGNED,AUTO
NS &STRING,AUTO
  CODE
    SizeIs = LEN(CLIP(St))
    NS &= NEW STRING (CHOOSE(SizeIs = 0,1,SizeIs))
    NS = St
    RETURN NS

! Dictionary definitions should not contain circular references as they
! cannot be guaranteed to work for all usages of a file scheme.
! Of course they _do_ contain circular references so we need to spot
! when we are cascading a call and get out when a cycle is hit ...
! We actually use this mechanism to side-step the 'proper' cycle of 'parent<->>child'

! Relation manager class
RelationManager.AddRelation PROCEDURE(RelationManager F)
  CODE
?   ASSERT(NOT SELF.Relations &= NULL,'Relation manager incorrectly initialized')
    CLEAR(SELF.Relations)
    SELF.Relations.File &= F
    ADD(SELF.Relations)

RelationManager.AddRelation PROCEDURE(RelationManager F,BYTE Update,BYTE Delete,KEY His)
  CODE
    SELF.AddRelation(F)
    SELF.Relations.Fields &= NEW BufferedPairsClass
    SELF.Relations.Fields.Init
    SELF.Relations.UpdateMode = Update
    SELF.Relations.DeleteMode = Delete
    SELF.Relations.HisKey &= His
    PUT(SELF.Relations)

RelationManager.AddRelationLink PROCEDURE(*? left,*? right)
  CODE
?   ASSERT(NOT SELF.Relations &= NULL AND NOT SELF.Relations.Fields &= NULL,'Relation manager incorrectly initialized')
    SELF.Relations.Fields.AddPair(left,right)

RelationManager.AddRelationLink PROCEDURE(*string left,*string right)
  CODE
?   ASSERT(NOT SELF.Relations &= NULL AND NOT SELF.Relations.Fields &= NULL,'Relation manager incorrectly initialized')
    SELF.Relations.Fields.AddPair(left,right)

RelationManager.AddRelationLink PROCEDURE(*long left,*long right)
  CODE
?   ASSERT(NOT SELF.Relations &= NULL AND NOT SELF.Relations.Fields &= NULL,'Relation manager incorrectly initialized')
    SELF.Relations.Fields.AddPair(left,right)

RelationManager.CancelAutoInc PROCEDURE
  CODE
    RETURN SELF.Me.CancelAutoInc(SELF)

RelationManager.Update PROCEDURE(BYTE FromForm)
RetVal BYTE(Level:Benign)
I LONG,AUTO
  CODE
    RetVal = SELF.Open()
    DO CheckError
    IF SELF.UseLogout
      RetVal = SELF.LogoutUpdate()
      DO CheckError
      LOGOUT(2)
      IF ERRORCODE()
        SELF.Me.Throw(Msg:LogoutFailed)
        RetVal = Level:Notify
        DO CheckError
      END
    END
    RetVal = SELF.Me.TryUpdate()
    IF RetVal
      IF SELF.UseLogout
        ROLLBACK
      END
      IF FromForm AND SELF.Me.Info.LastError = Msg:ConcurrencyFailed
        SELF.Me.Info.LastError = Msg:ConcurrencyFailedFromForm
      END
      IF RetVal = Level:Notify
        SELF.Me.Throw
      END
      IF SELF.Me.Info.LastError = Msg:ConcurrencyFailed OR SELF.Me.Info.LastError = Msg:ConcurrencyFailedFromForm
        RetVal = Level:Notify
      ELSE
        RetVal = Level:User
      END
      DO CheckError
    END
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF LocalAction(SELF.Relations.UpdateMode) AND NOT SELF.Relations.Fields.EqualLeftBuffer()
        RetVal = SELF.Relations.File.UpdateSecondary(SELF.Relations.HisKey,SELF.Relations.Fields,SELF.Relations.UpdateMode)
        IF RetVal
          SELF.Relations.Fields.AssignRightToLeft
          DO CheckError
        END
      END
    END
    IF SELF.UseLogout
      COMMIT
?     ASSERT(~ERRORCODE(),'Unable to commit transaction')
    END
    SELF.Close
    RETURN RetVal

CheckError ROUTINE
  IF RetVal
    SELF.Close
    RETURN RetVal
  END

RelationManager.UpdateSecondary PROCEDURE(KEY MyKey,BufferedPairsClass Fields,BYTE Mode)
RetVal BYTE(Level:Benign)
Preserve USHORT,AUTO
  CODE
    SELF.Me.UseFile()
    Preserve = SELF.Me.SaveFile()
    CLEAR(SELF.Me.File)
    Fields.AssignBufferToRight
    SELF.Me.ClearKey(MyKey,RECORDS(Fields.List)+1)
    SET(MyKey,MyKey)
    LOOP
      IF SELF.Me.TryNext()=Level:Fatal
        IF SELF.UseLogout
          ROLLBACK  ! ROLLBACK in case LOGOUT issued in parent
        END
        SELF.Me.Throw()
        RetVal = Level:Notify
        DO Ret
      END
      IF SELF.Me.GetEOF() OR NOT Fields.EqualRightBuffer()
        DO Ret
      END
      SELF.Save
      CASE Mode
      OF RI:Restrict
        SELF.Me.SetError(Msg:RestrictUpdate)
        IF SELF.UseLogout
          ROLLBACK
        END
        SELF.Me.Throw
        Fields.AssignBufferToLeft
        RetVal = Level:Notify
        DO Ret
      OF RI:Clear
        Fields.ClearRight
      OF RI:Cascade
        Fields.AssignLeftToRight
      ELSE
?       ASSERT(0,'Invalid RI mode specified')
        DO Ret
      END
      IF SELF.CascadeUpdates()
        RetVal = Level:Notify
        DO Ret
      END
    END
?   ASSERT(0,'Coding error, this point should not have been reached')

Ret ROUTINE
  SELF.Me.RestoreFile(Preserve)
  RETURN RetVal

RelationManager.Close PROCEDURE(BYTE Cascading)
  CODE
  RETURN SELF.OpenCloseServer(Cascading,0)

RelationManager.Delete PROCEDURE(BYTE Query)
Current:Position STRING(1024)
RetVal BYTE,AUTO
I      LONG,AUTO
  CODE
    IF Query AND SELF.Me.Throw(Msg:ConfirmDelete) <> Level:Benign
      RETURN Level:Notify
    END
    LOOP
      SETCURSOR(Cursor:Wait)
      RetVal = Level:Benign
      Current:Position = SELF.Me.Position()
      RetVal = SELF.Open()
      DO CheckError
      IF SELF.UseLogout
        RetVal = SELF.LogoutDelete()
        DO CheckError
        LOGOUT(2)
        IF ERRORCODE()
          SELF.Me.Throw(Msg:LogoutFailed)
          RetVal = Level:Notify
          DO CheckError
        END
      END
      SELF.Me.TryReget(Current:Position)
      LOOP I = 1 TO RECORDS(SELF.Relations)
        GET(SELF.Relations,I)
        IF LocalAction(SELF.Relations.DeleteMode)
          RetVal = SELF.Relations.File.DeleteSecondary(SELF.Relations.HisKey,SELF.Relations.Fields,SELF.Relations.DeleteMode)
          DO CheckError
        END
      END
!     DELETE(SELF.Me.File)
      SELF.Me.DeleteRecord(Query)
      IF ERRORCODE()
        SELF.Me.SetError(Msg:DeleteFailed)
        IF SELF.UseLogout
          ROLLBACK
        END
        SELF.Me.Throw
        RetVal = Level:Notify
      ELSE
        IF SELF.UseLogout
          COMMIT
        END
      END
      DO CloseDown
    WHILE RetVal AND SELF.Me.Throw(Msg:RetryDelete) = Level:Benign
    RETURN RetVal

CheckError ROUTINE
  IF RetVal
    DO CloseDown
    RETURN RetVal
  END

CloseDown ROUTINE
  SETCURSOR()
  SELF.Close

RelationManager.DeleteSecondary PROCEDURE(KEY MyKey,BufferedPairsClass Fields,BYTE Mode)
RetVal BYTE(Level:Benign)
I LONG,AUTO
Preserve USHORT,AUTO
  CODE
    SELF.Me.UseFile()
    Preserve = SELF.Me.SaveFile()
    CLEAR(SELF.Me.File)
    Fields.AssignLeftToRight
    SELF.Me.ClearKey(MyKey,RECORDS(Fields.List)+1)
    SET(MyKey,MyKey)
    LOOP
      IF SELF.Me.TryNext()=Level:Fatal
        IF SELF.UseLogout
          ROLLBACK
        END
        SELF.Me.Throw()
        RetVal = Level:Notify
        DO Ret
      END
      IF SELF.Me.GetEOF() OR NOT Fields.EqualLeftRight()
        DO Ret
      END
      IF SELF.Me.Deleted() THEN CYCLE.
      CASE Mode
      OF RI:Restrict
        SELF.Me.SetError(Msg:RestrictDelete)
        IF SELF.UseLogout
          ROLLBACK
        END
        SELF.Me.Throw
        RetVal = Level:Notify
        DO Ret
      OF RI:Clear
        SELF.Save
        Fields.ClearRight
        IF SELF.CascadeUpdates()
          RetVal = Level:Notify
          DO Ret
        END
      OF RI:Cascade
        LOOP I = 1 TO RECORDS(SELF.Relations)
          GET(SELF.Relations,I)
          IF LocalAction(SELF.Relations.DeleteMode)
            RetVal = SELF.Relations.File.DeleteSecondary(SELF.Relations.HisKey,SELF.Relations.Fields,SELF.Relations.DeleteMode)
            IF RetVal
              DO Ret
            END
          END
        END
        SELF.Me.DeleteRecord(1)
!        DELETE(SELF.Me.File)
        IF ERRORCODE()
          SELF.Me.SetError(Msg:DeleteFailed)
          IF SELF.UseLogout
            ROLLBACK
          END
          SELF.Me.Throw
          RetVal = Level:Notify
          DO Ret
        END
      ELSE
?       ASSERT(0,'Invalid RI mode')
        DO Ret
      END
    END
?   ASSERT(0,'Coding error, this point should not have been reached.')

Ret ROUTINE
  SELF.Me.RestoreFile(Preserve)
  RETURN RetVal

RelationManager.CascadeUpdates PROCEDURE
I BYTE,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF LocalAction(SELF.Relations.UpdateMode) AND NOT SELF.Relations.Fields.EqualLeftBuffer()
        IF SELF.Relations.File.UpdateSecondary(SELF.Relations.HisKey,SELF.Relations.Fields,SELF.Relations.UpdateMode)
          SELF.Relations.Fields.AssignRightToLeft
          RETURN Level:Notify
        END
      END
    END
    IF SELF.Me.TryUpdate()
      IF SELF.UseLogout
        ROLLBACK
      END
      RETURN SELF.Me.Throw()
    ELSE
      RETURN Level:Benign
    END

RelationManager.Init PROCEDURE(FileManager F,BYTE Log)
  CODE
    SELF.Me &= F
    SELF.Relations &= NEW RelationQueue
    SELF.UseLogout = Log

RelationManager.Kill PROCEDURE
I UNSIGNED,AUTO
  CODE
    IF NOT SELF.Relations &= NULL
      LOOP I = 1 TO RECORDS(SELF.Relations)
        GET(SELF.Relations,I)
        IF NOT SELF.Relations.Fields &= NULL
          SELF.Relations.Fields.Kill
          DISPOSE(SELF.Relations.Fields)
        END
      END
      DISPOSE(SELF.Relations)
    END

RelationManager.SetAlias PROCEDURE(RelationManager R)
  CODE
    SELF.AliasFile &= R

RelationManager.ListLinkingFields PROCEDURE(RelationManager Him,FieldPairsClass Trgt,BYTE RightFirst)
I UNSIGNED,AUTO
J BYTE,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF SELF.Relations.File &= Him
        IF SELF.Relations.Fields &= NULL
?         ASSERT(~RightFirst,'Coding error, linking fields not found, recursing indefinately.')
          Him.ListLinkingFields(SELF,Trgt,1)
          RETURN
        END
?       ASSERT(~SELF.Relations.Fields.List &= NULL,'Relation must have at least on linking field')
        LOOP J = 1 TO RECORDS(SELF.Relations.Fields.List)
          GET(SELF.Relations.Fields.List,J)
          IF RightFirst
            Trgt.AddPair(SELF.Relations.Fields.List.Left,SELF.Relations.Fields.List.Right)
          ELSE
            Trgt.AddPair(SELF.Relations.Fields.List.Right,SELF.Relations.Fields.List.Left)
          END
        END
        RETURN
      END
    END

RelationManager.LogoutPrime PROCEDURE
  CODE
    SELF.Me.UseFile()
    IF SELF.UseLogout
      SELF.Me.File{PROP:Logout} = 1
      CASE ERRORCODE()
      OF 0
      OF 80
        SELF.UseLogout = 0
?       ASSERT(0,'Driver does not support transaction framing.')
      ELSE
        SELF.Me.Throw(Msg:LogoutFailed)
        RETURN Level:Notify
      END
    END
    RETURN Level:Benign

RelationManager.LogoutDelete PROCEDURE
RetVal BYTE,AUTO
I LONG,AUTO
  CODE
  RetVal = SELF.LogoutPrime()
  IF ~RetVal
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF SELF.Relations.DeleteMode = RI:Cascade
        RetVal = SELF.Relations.File.LogoutDelete()
      ELSIF SELF.Relations.DeleteMode = RI:Clear
        RetVal = SELF.Relations.File.LogoutUpdate()
      END
    UNTIL RetVal
  END
  RETURN RetVal

RelationManager.LogoutUpdate PROCEDURE
RetVal BYTE,AUTO
I LONG,AUTO
  CODE
  RetVal = SELF.LogoutPrime()
  IF ~RetVal
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF SELF.Relations.UpdateMode = RI:Cascade OR SELF.Relations.UpdateMode = RI:Clear
        RetVal = SELF.Relations.File.LogoutUpdate()
      END
    UNTIL RetVal
  END
  RETURN RetVal

RelationManager.OpenCloseServer PROCEDURE(BYTE Cascading,BYTE Opening)
I   BYTE(1)
Res BYTE,AUTO
  CODE
    IF Cascading
      IF SELF.LastTouched = Epoc
        RETURN  Level:Benign
      END
    ELSE
      Epoc += 1
    END
    SELF.LastTouched = Epoc
?    ASSERT(NOT SELF.Relations &= NULL,'Relation manager incorrectly initialized.')
    IF Opening
      Res = SELF.Me.Open()
      IF ~Cascading THEN Res=SELF.Me.UseFile().
    ELSE
      Res = SELF.Me.Close()
    END
    LOOP UNTIL Res
      GET(SELF.Relations,I)
      IF ERRORCODE()
        BREAK
      END
      IF Opening
        Res = SELF.Relations.File.Open(1) ! Go through 'public' interface to pick up VIRTUAL ness
      ELSE
        Res = SELF.Relations.File.Close(1)
      END
      I += 1
    END
    RETURN Res

RelationManager.Open PROCEDURE(BYTE Cascading)
  CODE
  RETURN SELF.OpenCloseServer(Cascading,1)

RelationManager.SetQuickScan PROCEDURE(BYTE On,BYTE Propagate)
I UNSIGNED,AUTO
  CODE
    SEND(SELF.Me.File,'QUICKSCAN=' & CHOOSE(On = 1,'on','off'))
    IF Propagate
      IF BAND(Propagate,080H)
        IF SELF.LastTouched = Epoc
          RETURN
        END
      ELSE
        Epoc += 1
        Propagate = Propagate + 80H
      END
      SELF.LastTouched = Epoc
      LOOP I = 1 TO RECORDS(SELF.Relations)
        GET(SELF.Relations,I)
        CASE BAND(Propagate,07FH)
        OF Propagate:OneMany
          IF ~SELF.Relations.HisKey&=NULL THEN CYCLE .
        OF Propagate:ManyOne
          IF SELF.Relations.HisKey&=NULL THEN CYCLE .
        END
        SELF.Relations.File.SetQuickScan(On,Propagate)
      END
    END

RelationManager.Save  PROCEDURE
I LONG,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Relations)
      GET(SELF.Relations,I)
      IF NOT SELF.Relations.Fields &= NULL
        SELF.Relations.Fields.AssignLeftToBuffer
      END
    END

RelationManager.GetNbRelations PROCEDURE ! returns the number of relations defined for the primary file
  CODE
  RETURN Records(self.relations)

RelationManager.GetNbFiles PROCEDURE(RelationManager parent) ! returns the number of children files in this relation
i       LONG
nbFiles LONG
  CODE
  nbFiles = 1
  LOOP i = 1 to RECORDS(SELF.Relations)
    GET(SELF.Relations, i)
    IF not (SELF.Relations.File &= parent)
      nbFiles += SELF.Relations.File.GetNbFiles(SELF)
    END
  END
  RETURN nbFiles

RelationManager.getRelation PROCEDURE(LONG relPos) ! returns the relation number relPos in the list of relations
  CODE
  IF (relPos < 1) THEN RETURN NULL.
  IF (relPos > RECORDS(SELF.relations)) THEN RETURN NULL.
  Get(SELF.relations, relPos)
  RETURN self.relations.File

RelationManager.getRelation PROCEDURE(FILE f) ! returns the relation manager for the file f
i       LONG
  CODE
  IF (f &= null) then RETURN NULL.
  LOOP i = 1 to RECORDS(SELF.Relations)
    GET(SELF.Relations,I)
    IF (SELF.Relations.File.Me.File &= f)
      RETURN SELF.Relations.File
    END
  END
  RETURN NULL

RelationManager.getRelationType PROCEDURE(LONG relPos) !returns the type of the relation i (-1 = pb, 1 : 1:many relation, 0 : other relation)
  CODE
  IF (relPos < 1) THEN RETURN -1.
  IF (relPos > RECORDS(SELF.relations)) THEN RETURN -1.
  GET(SELF.relations, relPos)
  IF (SELF.relations.HisKey &= NULL) THEN RETURN 0.
  RETURN 1

! View manager class, handles filters, range limits and order clauses for a view

! Specify a 'current value' range limit
ViewManager.AddRange PROCEDURE(*? Field)
  CODE
    SELF.Order.LimitType = Limit:Current
    SELF.LimitMajorComponents(Field)
    SELF.Order.RangeList.AddItem(Field)
    SELF.SetFreeElement

! Single value range limit
ViewManager.AddRange PROCEDURE(*? Field,*? Value)
  CODE
    SELF.Order.LimitType = Limit:Single
    SELF.LimitMajorComponents(Field)
    SELF.Order.RangeList.AddItem(Value)
    SELF.SetFreeElement

! Pair of values range limit
ViewManager.AddRange PROCEDURE(*? Field,*? Low,*? High)
  CODE
    SELF.Order.LimitType = Limit:Pair
    SELF.LimitMajorComponents(Field)
    SELF.Order.RangeList.AddItem(Low)
    SELF.Order.RangeList.AddItem(High)
    SELF.SetFreeElement

! File base range limit
ViewManager.AddRange PROCEDURE(*? Field,RelationManager MyFile,RelationManager HisFile)
  CODE
    SELF.Order.LimitType = Limit:File
    HisFile.ListLinkingFields(MyFile,SELF.Order.RangeList)
?   ASSERT(RECORDS(SELF.Order.RangeList.List),'File based range limit requires linking fields.')
    SELF.SetFreeElement

ViewManager.AddSortOrder PROCEDURE(<Key K>)
  CODE
    CLEAR(SELF.Order)
    SELF.Order.MainKey &= K
    SELF.Order.RangeList &= NEW BufferedPairsClass
    SELF.Order.RangeList.Init
    IF ~SELF.Order.MainKey &= NULL AND SELF.Primary.Me.GetComponents(K)
      SELF.Order.FreeElement &= SELF.Primary.Me.GetField(K,1)
    END
    ADD(SELF.Order)
?   ASSERT(~ERRORCODE(),'Unable to add new sort order.')
    SELF.SetOrder(SELF.Primary.Me.KeyToOrder(SELF.Order.MainKey,1))
    RETURN RECORDS(SELF.Order)

ViewManager.AppendOrder PROCEDURE(STRING F)
  CODE
    IF SELF.Order.Order &= NULL
      SELF.SetOrder(F)
    ELSIF F AND F[1] = '*'
      SELF.SetOrder(F[2:LEN(F)])
    ELSE
      SELF.SetOrder(SELF.Order.Order & ',' & F)
    END

ViewManager.ApplyFilter PROCEDURE
RangeFilter CSTRING(5000)
FieldName   CSTRING(500),AUTO
I           BYTE,AUTO
RRL         BYTE,AUTO
  CODE
    RRL = RECORDS(SELF.Order.RangeList.List)
    CASE SELF.Order.LimitType
    OF Limit:Current OROF Limit:Single OROF Limit:File
      LOOP I = 1 TO RRL
        GET(SELF.Order.RangeList.List,I)
        FieldName = SELF.Primary.Me.GetFieldName(SELF.Order.MainKey,I)
        RangeFilter = RangeFilter & CHOOSE(I = 1,'',' AND ') & FieldName & ' = ' & CasedValue(FieldName,SELF.Order.RangeList.List.Left,SELF.Order.RangeList.List.Right)
      END
    OF Limit:Pair
      LOOP I = 1 TO RRL-1
        GET(SELF.Order.RangeList.List,I)
        FieldName = SELF.Primary.Me.GetFieldName(SELF.Order.MainKey,I)
        CASE I
        OF RRL-1
          RangeFilter = RangeFilter & CHOOSE(RangeFilter = '','',' AND ') & FieldName & ' >= ' & CasedValue(FieldName,SELF.Order.RangeList.List.Left,SELF.Order.RangeList.List.Right)
        ELSE
          RangeFilter = RangeFilter & CHOOSE(I = 1,'',' AND ') & FieldName & ' = ' & CasedValue(FieldName,SELF.Order.RangeList.List.Left,SELF.Order.RangeList.List.Right)
        END
      END
      GET(SELF.Order.RangeList.List,RRL)
      RangeFilter = RangeFilter & ' AND ' & FieldName & ' <<= ' & CasedValue(FieldName,SELF.Order.RangeList.List.Left,SELF.Order.RangeList.List.Right)
    END
    IF ~(SELF.Order.Filter &= NULL)
      LOOP I = 1 TO RECORDS(SELF.Order.Filter)
        GET(SELF.Order.Filter,I)
        RangeFilter = RangeFilter & CHOOSE(RangeFilter = '','(',' AND (') & SELF.Order.Filter.Filter & ')'
      END
    END
    SELF.View{PROP:Filter} = RangeFilter
    IF ERRORCODE()
      SELF.Primary.Me.Throw(Msg:ViewOpenFailed)
    END

ViewManager.ApplyOrder PROCEDURE
  CODE
    SELF.View{PROP:Order} = SELF.Order.Order
    IF ERRORCODE()
      SELF.Primary.Me.Throw(Msg:ViewOpenFailed)
    END

ViewManager.ApplyRange PROCEDURE
  CODE
    CASE SELF.Order.LimitType
    OF Limit:Pair
      GET(SELF.Order.RangeList.List,RECORDS(SELF.Order.RangeList.List)-1)
      IF SELF.Order.RangeList.List.Left <> SELF.Order.RangeList.List.Right
        SELF.Order.RangeList.List.Right = SELF.Order.RangeList.List.Left
        PUT(SELF.Order.RangeList.List)
        GET(SELF.Order.RangeList.List,RECORDS(SELF.Order.RangeList.List))
        SELF.Order.RangeList.List.Right = SELF.Order.RangeList.List.Left
        PUT(SELF.Order.RangeList.List)
        SELF.ApplyFilter
        RETURN 1
      END
    OROF Limit:Single
      GET(SELF.Order.RangeList.List,RECORDS(SELF.Order.RangeList.List))
      IF SELF.Order.RangeList.List.Left <> SELF.Order.RangeList.List.Right
        SELF.Order.RangeList.List.Right = SELF.Order.RangeList.List.Left
        PUT(SELF.Order.RangeList.List)
        SELF.ApplyFilter
        RETURN 1
      END
    OF Limit:File
      IF ~SELF.Order.RangeList.EqualRightBuffer()
        SELF.Order.RangeList.AssignRightToBuffer()
        SELF.ApplyFilter
        RETURN 1
      END
    END
    RETURN 0

ViewManager.Close PROCEDURE
  CODE
    IF SELF.Opened
      CLOSE(SELF.View)
    END
    SELF.Opened = 0

ViewManager.Init PROCEDURE(VIEW V,RelationManager F,<SortOrder S>)
  CODE
    SELF.View &= V
    SELF.Primary &= F
    IF OMITTED(4)
      SELF.Order &= NEW SortOrder
      SELF.DisposeOrder = 1
    ELSE
      SELF.Order &= S
      SELF.DisposeOrder = 0
    END
    SELF.PageSize = 20
    SELF.PagesBehind = 2
    SELF.PagesAhead = 0
    SELF.TimeOut = 60
    SELF.UseView

ViewManager.Kill PROCEDURE
I LONG,AUTO
J SIGNED,AUTO
  CODE
    IF SELF.Order &= NULL
      RETURN
    END
    LOOP I = 1 TO RECORDS(SELF.Order)
      GET(SELF.Order,I)
      SELF.Order.RangeList.Kill
      DISPOSE(SELF.Order.RangeList)
      IF ~SELF.Order.Filter &= NULL
        LOOP J = 1 TO RECORDS(SELF.Order.Filter)
          GET(SELF.Order.Filter,J)
          DISPOSE(SELF.Order.Filter.Filter)
        END
      END
      DISPOSE(SELF.Order.Filter)
      DISPOSE(SELF.Order.Order)
      SELF.Order.FreeElement &= NULL
      PUT(SELF.Order)
    END
    IF SELF.DisposeOrder
      DISPOSE(SELF.Order)
    END

ViewManager.LimitMajorComponents PROCEDURE(*? Field)
F ANY
I BYTE,AUTO
  CODE
    SELF.Order.RangeList.Init
    LOOP I = 1 TO SELF.Primary.Me.GetComponents(SELF.Order.MainKey)
      F &= SELF.Primary.Me.GetField(SELF.Order.MainKey,I)
      IF F &= Field THEN BREAK .
      SELF.Order.RangeList.AddItem(F)
    END

ViewManager.UseView PROCEDURE
i   LONG,AUTO
Fr  &File
  CODE
? ASSERT(~SELF.View&=NULL,'View manager has not been assigned a view')
  LOOP i=1 TO SELF.View{PROP:Files}
    Fr &= SELF.View{PROP:File,i}
?   ASSERT(~Fr&=NULL,'View driver failed to return consituent file.')
    FilesManager.GetFileMapping(FilesManager.GetFileID(Fr))
    IF FileMapping.FileManager.UseFile() THEN RETURN.
  END


ViewManager.Open PROCEDURE
  CODE
    IF ~SELF.Opened
?     ASSERT(RECORDS(SELF.Order),'At least 1 view order must be specified')
      OPEN(SELF.View)
      IF ERRORCODE()
        SELF.Primary.Me.Throw(Msg:ViewOpenFailed)
      END
      BUFFER(SELF.View,SELF.PageSize,SELF.PagesBehind,SELF.PagesAhead,SELF.TimeOut)
      SELF.Opened = 1
    END
    SELF.ApplyOrder
    SELF.ApplyFilter

ViewManager.Reset PROCEDURE
  CODE
    SELF.Reset(0)

ViewManager.Reset PROCEDURE(BYTE LocatePos)
  CODE
    SELF.Open
    SET(SELF.View,LocatePos)
    IF ERRORCODE()
      SELF.Primary.Me.Throw(Msg:ViewOpenFailed)
    END

ViewManager.SetFilter PROCEDURE(STRING F)
  CODE
    SELF.SetFilter(F,'5 Standard')

ViewManager.SetFilter PROCEDURE(STRING F,STRING Id)
  CODE
    IF SELF.Order.Filter &= NULL
      SELF.Order.Filter &= NEW FilterQueue
      PUT(SELF.Order)
    END
    SELF.Order.Filter.Id = Id
    GET(SELF.Order.Filter,-SELF.Order.Filter.Id)
    IF ~ERRORCODE()
      DISPOSE(SELF.Order.Filter.Filter)
    ELSE
      ADD(SELF.Order.Filter,-SELF.Order.Filter.Id)
    END
    IF F
      SELF.Order.Filter.Filter &= DupString(F)
      PUT(SELF.Order.Filter)
    ELSE
      DELETE(SELF.Order.Filter)
    END

ViewManager.GetFreeElementName PROCEDURE
FEP BYTE,AUTO
  CODE
    FEP = SELF.GetFreeElementPosition()
    IF FEP
      RETURN SELF.Primary.Me.GetFieldName(SELF.Order.MainKey,FEP)
    END
    RETURN ''

ViewManager.GetFreeElementPosition PROCEDURE
FEP BYTE,AUTO
  CODE
    FEP = RECORDS(SELF.Order.RangeList.List)
    IF SELF.Order.LimitType <> Limit:Pair THEN
      FEP += 1
    END
    RETURN CHOOSE(~SELF.Order.MainKey &= NULL AND FEP <= SELF.Primary.Me.GetComponents(SELF.Order.MainKey),FEP,0)

ViewManager.SetFreeElement PROCEDURE
FEP BYTE,AUTO
  CODE
    FEP = SELF.GetFreeElementPosition()
    IF FEP
      SELF.Order.FreeElement &= SELF.Primary.Me.GetField(SELF.Order.MainKey,FEP)
    END
    SELF.SetOrder(SELF.Primary.Me.KeyToOrder(SELF.Order.MainKey,1))
    PUT(SELF.Order)


ViewManager.SetOrder PROCEDURE(STRING F)
  CODE
?   ASSERT(~SELF.Order &= NULL,'View does not have any sort orders defined')
    DISPOSE(SELF.Order.Order)
    IF F
      SELF.Order.Order &= DupString(F)
    END
    PUT(SELF.Order)

ViewManager.ValidateRecord PROCEDURE
  CODE
    RETURN Record:OK  ! Cannot validate primary record because of project implications

ViewManager.Next PROCEDURE
  CODE
    LOOP
      NEXT(SELF.View)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN Level:Notify
        ELSE
          SELF.Primary.Me.Throw(Msg:AbortReading)
          RETURN Level:Fatal
        END
      ELSE
        CASE SELF.ValidateRecord()
        OF Record:OK
          RETURN Level:Benign
        OF Record:OutOfRange
          RETURN Level:Notify
        END
      END
    END


! This function calls the underlying file manager to prime a record
! for insertion. It then uses range-limit information to fill in other
! fields if it can.
ViewManager.PrimeRecord PROCEDURE(BYTE SC)
F ANY
I BYTE,AUTO
Delta SHORT
FR &FILE
  CODE
    IF ~SC
      LOOP i=1 TO SELF.View{PROP:Files}
        Fr &= SELF.View{PROP:File,i}
        CLEAR(FR)
      END
    END
    CASE SELF.Order.LimitType
    OF Limit:Pair
      Delta = -2
    OROF Limit:Current OROF Limit:Single OROF Limit:File
      LOOP I = 1 TO RECORDS(SELF.Order.RangeList.List) + Delta
        GET(SELF.Order.RangeList.List,I)
        F &= SELF.Primary.Me.GetField(SELF.Order.MainKey,I)
        F = SELF.Order.RangeList.List.Right
      END
    END
    RETURN SELF.Primary.Me.PrimeRecord(1)

ViewManager.Previous  PROCEDURE
  CODE
    LOOP
      PREVIOUS(SELF.View)
      IF ERRORCODE()
        IF ERRORCODE() = BadRecErr
          RETURN Level:Notify
        ELSE
          SELF.Primary.Me.Throw(Msg:AbortReading)
          RETURN Level:Fatal
        END
      ELSE
        CASE SELF.ValidateRecord()
        OF Record:OK
          RETURN Level:Benign
        OF Record:OutOfRange
          RETURN Level:Notify
        END
      END
    END

ViewManager.SetSort PROCEDURE(BYTE B)
  CODE
    IF B = 0
      B = 1
    END
    IF B = POINTER(SELF.Order)
      RETURN 0
    ELSE
      GET(SELF.Order,B)
?     ASSERT(~ERRORCODE(),'Sort order does not exist:'&B)
      RETURN 1
    END

CasedValue PROCEDURE(STRING FieldName,*? Field,? FieldValue)
TValue CSTRING(2000),AUTO
Value CSTRING(2000),AUTO
I     UNSIGNED,AUTO
J     UNSIGNED(2)
  CODE
    IF IsString(Field)
      TValue = FieldValue
      Value[1] = ''''
      LOOP I = 1 TO LEN(TValue)
        Value[J] = TValue[I]
        J += 1
        IF TValue[I] = ''''        ! Double up for parsing purposes
          Value[J] = TValue[I]
          J += 1
        END
      END
      Value[J :J+1] = '''<0>'
      RETURN CHOOSE(INSTRING('UPPER(',FieldName,1,1) <> 0,'UPPER('&Value&')',Value)
    ELSE
      RETURN FieldValue
    END

LocalAction PROCEDURE(BYTE Mode)
  CODE
  RETURN CHOOSE(Mode=RI:Restrict OR Mode=RI:Cascade OR Mode=RI:Clear)



GetFileManager PROCEDURE(ASTRING Tag)

RVal  &FileManager,AUTO

  CODE
  RVal &= (TIED(Tag, AS:AddrFileManager))
  RETURN RVal


SetFileManager PROCEDURE(FileManager FM, ASTRING Tag)

  CODE
  TIE(Tag, AS:AddrFileManager, ADDRESS(FM))


GetFileField PROCEDURE(ASTRING FMTag, ASTRING FldTag)

FM    &FileManager,AUTO
RVal  ANY,AUTO

  CODE
  FM &= GetFileManager(FMTag)
  IF FM &= NULL
    RVal &= NULL
  ELSE
    RVal &= FM.GetField(FldTag)
  END
  RETURN RVal


GetFieldValue PROCEDURE(ASTRING FMTag, ASTRING FldTag)

FM    &FileManager,AUTO
Fld   ANY,AUTO

  CODE
  FM &= GetFileManager(FMTag)
  Fld &= GetFileField(FMTag, FldTag)
  RETURN CHOOSE(FM &= NULL OR Fld &= NULL, '', FORMAT(Fld, FM.GetFieldPicture(FldTag)))


!* DbTrigger Classes.

DbLogFileManager.Init              PROCEDURE(ErrorClass EC, STRING LogFileName)

DbTextLogFile       FILE,DRIVER('ASCII'),NAME(szDbTextLog),CREATE
Record                RECORD
strEntry                STRING(1000)
                      END
                    END
 CODE
 PARENT.Init(DbTextLogFile, EC)
 SELF.FileName &= szDbTextLog
 SELF.FileNameValue = CLIP(LogFileName)
 SELF.Buffer &= DbTextLogFile.Record
 SELF.LazyOpen = False
 SELF.LockRecover = 10

DbChangeManager.AddItem                      PROCEDURE(*? Left, STRING Name, STRING FileName)
 CODE
   IF SELF.SetThread(FileName)
    SELF.TriggerQueue.BFP.AddItem(Left)
    SELF.NameQueue.FileName = FileName
    SELF.NameQueue.FieldName = Name
    GET(SELF.NameQueue,+SELf.NameQueue.FileName,+SELF.NameQueue.FieldName)
    IF ERRORCODE()
       SELF.NameQueue.Ptr = RECORDS(SELF.TriggerQueue.BFP.List)
       ADD(SELF.NameQueue)
    END
   END

DbChangeManager.Equal                        PROCEDURE(STRING FileName)
 CODE
   IF SELF.SetThread(FileName)
      RETURN SELF.TriggerQueue.BFP.Equal()
   ELSE
      RETURN True
   END

DbChangeManager.CheckChanges                 PROCEDURE(STRING FileName, FILE File)
I USHORT,AUTO
 CODE
   SELF.DbChangeAudit.BeforeChange(FileName, SELF.TriggerQueue.BFP)
   IF SELF.SetThread(FileName)
    LOOP I = 1 TO RECORDS(SELF.TriggerQueue.BFP.List)
     GET(SELF.TriggerQueue.BFP.List,I)
     SELF.CheckPair(SELF.TriggerQueue.BFP)
    END
   END
   SELF.DbChangeAudit.OnChange(FileName, File)

DbChangeManager.CheckPair                    PROCEDURE(FieldPairsClass FP)
 CODE
   IF FP.List.Left <> FP.List.Right
      SELF.NameQueue.Ptr = POINTER(SELF.TriggerQueue.BFP.List)
      GET(SELF.NameQueue,SELF.NameQueue.Ptr)
      SELF.DbChangeAudit.ChangeField(FP.List.Left, FP.List.Right, SELF.NameQueue.FieldName, SELF.NameQueue.FileName)
   END

DbChangeManager.Update                       PROCEDURE(STRING FileName)
 CODE
   IF SELF.SetThread(FileName)
      SELF.TriggerQueue.BFP.AssignLeftToRight()
   END

DbChangeManager.SetThread                    PROCEDURE(STRING FileName)
 CODE
?  ASSERT(~SELF.TriggerQueue&=NULL,'DbTriggers not inited.')
   SELF.TriggerQueue.ID = THREAD()
   SELF.TriggerQueue.FileName = FileName
   GET(SELF.TriggerQueue, +SELF.TriggerQueue.ID, +SELF.TriggerQueue.FileName)
   IF ERRORCODE()
      RETURN False
   ELSE
      RETURN True
   END

DbChangeManager.AddThread                    PROCEDURE(STRING FileName)
   CODE
   SELF.TriggerQueue.ID = THREAD()
   SELF.TriggerQueue.BFP &= NEW(BufferedPairsClass)
   SELF.TriggerQueue.BFP.Init()
   ADD(SELF.TriggerQueue)

DbChangeManager.Init                         PROCEDURE(*IDbChangeAudit IDbC)
 CODE
   SELF.DbChangeAudit &= IDbC
   SELF.TriggerQueue &= NEW(DbTriggerQueue)
   SELF.NameQueue &= NEW(DbNameQueue)

DbChangeManager.Kill                         PROCEDURE
 CODE
   LOOP
    GET(SELF.TriggerQueue,1)
    IF ERRORCODE() THEN BREAK.
    SELF.TriggerQueue.BFP.Kill()
    DISPOSE(SELF.TriggerQueue.BFP)
    DELETE(SELF.TriggerQueue)
   END
   DISPOSE(SELF.TriggerQueue)
   FREE(SELF.NameQueue)
   DISPOSE(SELF.NameQueue)

DbAuditManager.AddLogFile      PROCEDURE(STRING FileName, STRING LogFileName)
 CODE
   SELF.LogFiles.FileName = FileName
   SELF.LogFiles.LogFileName = LogFileName
   GET(SELF.LogFiles,+SELF.LogFiles.FileName)
   IF ERRORCODE()
      CLEAR(SELF.Logfiles)
      SELF.LogFiles.FileName = FileName
      SELF.LogFiles.LogFileName = LogFileName
      ADD(SELF.LogFiles)
      SELF.AddItem(FileName,'Action',SELF.Action,'Action','@s20') ! Add the Action Column for this file.
   END

DbAuditManager.AddItem         PROCEDURE(STRING FileName, STRING FieldName, *? Field, STRING FieldHeader, STRING FieldPicture)
 CODE
   IF NOT SELF.SetFM(FileName) THEN RETURN.

   SELF.ColumnInfo.FileName = FileName
   SELF.ColumnInfo.FieldName = FieldName
   GET(SELF.ColumnInfo,+SELF.ColumnInfo.FileName,+SELF.ColumnInfo.FieldName)
   IF ERRORCODE()
      CLEAR(SELF.ColumnInfo)
      SELF.ColumnInfo.FileName = FileName
      SELF.ColumnInfo.FieldName = FieldName
      SELF.ColumnInfo.Field &= Field
      SELF.ColumnInfo.FieldHeader = FieldHeader
      SELF.ColumnInfo.FieldPicture = FieldPicture
      SELF.ColumnInfo.Length = LEN(FORMAT(Field,FieldPicture))
      IF LEN(CLIP(SELF.ColumnInfo.FieldHeader)) > SELF.ColumnInfo.Length
         SELF.ColumnInfo.Length = LEN(CLIP(SELF.ColumnInfo.FieldHeader))
      END
      ADD(SELF.ColumnInfo)
   END

DbAuditManager.AppendLog                      PROCEDURE(STRING FileName)
I USHORT,AUTO
HeaderPic ASTRING
 CODE
   IF NOT SELF.SetFM(FileName) THEN RETURN.
   SELF.OpenLogFile(FileName)
   CLEAR(SELF.LFM.Buffer)
   SELF.LFM.Buffer = '|' & FORMAT(Today(),@D17) & '|' & FORMAT(Clock(),@T7) & '|'
   SORT(SELF.ColumnInfo,+SELF.ColumnInfo.FileName)
   LOOP I = 1 TO RECORDS(SELF.ColumnInfo)
    GET(SELF.ColumnInfo,I)
    IF SELF.ColumnInfo.FileName < FileName THEN CYCLE.
    IF SELF.ColumnInfo.FileName > FileName THEN BREAK.
    HeaderPic = '@s' & SELF.ColumnInfo.Length
    SELF.LFM.Buffer = CLIP(SELF.LFM.Buffer) & FORMAT(FORMAT(SELF.ColumnInfo.Field,SELF.ColumnInfo.FieldPicture),HeaderPic) & '|'
   END
   SELF.LFM.Insert()

DbAuditManager.CreateHeader                   PROCEDURE(STRING FileName, DbLogFileManager LFM)
I USHORT,AUTO
lHeader USHORT,AUTO
SaveBuffer ASTRING
 CODE
 LFM.Create = True
 CLEAR(LFM.Buffer)
 LFM.Buffer = '| Date' & ALL(' ',LEN(FORMAT(Today(),@D17))-5) & '| Time' & ALL(' ',LEN(FORMAT(Clock(),@T7))-5) & '|'
 SORT(SELF.ColumnInfo,+SELF.ColumnInfo.FileName)
 LOOP I = 1 TO RECORDS(SELF.ColumnInfo)
   GET(SELF.ColumnInfo,I)
   IF SELF.ColumnInfo.FileName < FileName THEN CYCLE.
   IF SELF.ColumnInfo.FileName > FileName THEN BREAK.
   lHeader = LEN(CLIP(SELF.ColumnInfo.FieldHeader))
   IF lHeader < SELF.ColumnInfo.Length
      LFM.Buffer = CLIP(LFM.Buffer) & SELF.ColumnInfo.FieldHeader & ALL(' ',SELF.ColumnInfo.Length-lHeader) & '|'
   ELSE
      LFM.Buffer = CLIP(LFM.Buffer) & SELF.ColumnInfo.FieldHeader & '|'
   END
 END
 SaveBuffer = LFM.Buffer
 LFM.Buffer = ALL('-',LEN(CLIP(SaveBuffer)))
 LFM.Insert()
 LFM.Buffer = SaveBuffer
 LFM.Insert()
 LFM.Buffer = ALL('-',LEN(CLIP(SaveBuffer)))
 LFM.Insert()

DbAuditManager.Init                           PROCEDURE(ErrorClass ErrorHandler)
 CODE
   SELF.Errors &= ErrorHandler
   SELF.ColumnInfo &= NEW (DbColumnQueue)
   SELF.LogFiles &= NEW (LogFileQueue)
   SELF.LFM &= NEW (DbLogFileManager)

DbAuditManager.Kill                           PROCEDURE()
 CODE
   LOOP UNTIL RECORDS(SELF.ColumnInfo) < 1
    GET(SELF.ColumnInfo,1)
    SELF.ColumnInfo.Field &= NULL
    DELETE(SELF.ColumnInfo)
   END
   FREE(SELF.ColumnInfo)
   DISPOSE(SELF.ColumnInfo)
   FREE(SELF.LogFiles)
   DISPOSE(SELF.LogFiles)
   IF SELF.LFM.Opened
      SELF.LFM.Close()
      SELF.LFM.Kill()
   END
   DISPOSE(SELF.LFM)

DbAuditManager.SetFM                          PROCEDURE(STRING FileName)
 CODE
   SELF.LogFiles.FileName = FileName
   GET(SELF.LogFiles,SELF.LogFiles.FileName)
   IF ERRORCODE()
      RETURN False
   ELSE
      RETURN True
   END

DbAuditManager.OnDelete                       PROCEDURE(STRING FileName, FILE File)
 CODE
   SELF.Action = 'On Delete'
   SELF.AppendLog(FileName)

DbAuditManager.OnFieldChange     PROCEDURE(*? Left, *? Right, STRING FieldName, STRING FileName)
 CODE

DbAuditManager.OnInsert                       PROCEDURE(STRING FileName, FILE File)
 CODE
   SELF.Action = 'On Insert'
   SELF.AppendLog(FileName)

DbAuditManager.OnChange                       PROCEDURE(STRING FileName, FILE File)
 CODE
   SELF.Action = 'After Change'
   SELF.AppendLog(FileName)

DbAuditManager.BeforeChange                   PROCEDURE(STRING FileName, BufferedPairsClass BFP)
 CODE
   SELF.Action = 'Before Change'
   BFP.AssignLeftToBuffer()
   BFP.AssignRightToLeft
   SELF.AppendLog(FileName)
   BFP.AssignBufferToLeft()


DbAuditManager.IDbChangeAudit.ChangeField     PROCEDURE(*? Left, *? Right, STRING FieldName, STRING FileName)
 CODE
   SELF.OnFieldChange(Left, Right, FieldName, FileName)

DbAuditManager.IDbChangeAudit.OnChange        PROCEDURE(STRING FileName, FILE File)
 CODE
   SELF.OnChange(FileName, File)

DbAuditManager.IDbChangeAudit.BeforeChange    PROCEDURE(STRING FileName, BufferedPairsClass BFP)
 CODE
   SELF.BeforeChange(FileName, BFP)

DbAuditManager.OpenLogFile                    PROCEDURE(STRING FileName)
CreateHeader BYTE
 CODE

   SELF.LogFiles.FileName = FileName
   GET(SELF.LogFiles,SELF.LogFiles.FileName)
   IF NOT ERRORCODE()
      IF SELF.LFM.Opened
         SELF.LFM.Close()
         SELF.LFM.Kill()
         SELF.LFM.Opened = False
      END
      szDbTextLog = CLIP(SELF.LogFiles.LogFileName)
      SELF.LFM.Init(SELF.Errors, SELF.LogFiles.LogFileName)
      CreateHeader = Exists(szDbTextLog)
      IF SELF.LFM.Open()
      ELSE
         IF NOT CreateHeader
            SELF.CreateHeader(FileName, SELF.LFM)
         END
      END
   END
   SELF.LFM.Opened = True
