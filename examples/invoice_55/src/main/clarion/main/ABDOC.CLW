
  MEMBER

  INCLUDE('ABDOC.INC'),ONCE
  INCLUDE('ABHTMLEX.INC'),ONCE


  MAP
    MODULE('C55RUN')
      TIEAS(ASTRING,LONG=0,ASTRING),LONG,NAME('Cla$TIE')
      TIEDAS(ASTRING,LONG),ASTRING,NAME('Cla$TIED')
    END
  END

!**********************************
!        Format Identifiers
!**********************************

! Simple Format Types

FT_NewLine              ASTRING
FT_LineBreak            ASTRING

! Containment Format Types

FT_GenericData          ASTRING

FT_Bold                 ASTRING
FT_Italic               ASTRING
FT_StrikeThrough        ASTRING

FT_DocStart             ASTRING
FT_DocHeader            ASTRING
FT_DocBody              ASTRING
FT_DocFooter            ASTRING
FT_Table                ASTRING
FT_Comment              ASTRING

! Sub Components

FT_TableRow             ASTRING
FT_TableCell            ASTRING

! Containment Format Types

FT_Title                ASTRING
FT_Font                 ASTRING
FT_Link                 ASTRING
FT_Tag                  ASTRING

! Containment Option Types

FT_TableBorderWidth     ASTRING
FT_TableBGColour        ASTRING

FT_FontColour           ASTRING
FT_FontFace             ASTRING
FT_FontSize             ASTRING
FT_FontStyle            ASTRING

FT_LinkName             ASTRING
FT_LinkTarget           ASTRING


szGloDocFileName        CSTRING(256)
DosFile                 FILE,DRIVER('DOS'),CREATE,NAME(szGloDocFileName)
Record                    RECORD
strEntry                    STRING(8192)
                          END
                        END


  MAP
    ReturnForReference(LONG lpVoid),LONG
  END


DocumentFileMgr.Init                  PROCEDURE(ErrorClass ErrorHandler)

  CODE
    SELF.Init(DosFile, ErrorHandler)
    SELF.FileNameValue = 'DosFile'
    SELF.Buffer &= DosFile:Record


DocumentEngine.Construct                 PROCEDURE

  CODE
    SELF.TagMap &= NEW(MapAStringToAString)
    FT_NewLine = '<13><10>'
    FT_LineBreak = 'LINEBREAK'
    FT_GenericData = 'DATA'
    FT_Bold = 'BOLD'
    FT_Italic = 'ITALIC'
    FT_StrikeThrough = 'STRIKET'
    FT_DocStart = 'DOCSTART'
    FT_DocHeader = 'DOCHEADER'
    FT_DocBody = 'DOCBODY'
    FT_DocFooter = 'DOCFOOTER'
    FT_Table = 'TABLE'
    FT_TableRow = 'TABLEROW'
    FT_TableCell = 'TABLECELL'
    FT_Title = 'TITLE'
    FT_Font = 'FONT'
    FT_Link = 'LINK'
    FT_Tag = 'TAG'
    FT_TableBorderWidth = 'TABLEBORDERW'
    FT_TableBGColour = 'TABLEBGCOLOUR'
    FT_FontColour = 'FONTCOLOUR'
    FT_FontFace = 'FONTFACE'
    FT_FontSize = 'FONTSIZE'
    FT_FontStyle = 'FONTSTYLE'
    FT_LinkName = 'LINKNAME'
    FT_LinkTarget = 'LINKTARGET'


DocumentEngine.Destruct                  PROCEDURE

  CODE
    SELF.Kill
    DISPOSE(SELF.TagMap)


DocumentEngine.Init                      PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct)

  CODE
    IF SELF.bInitialised
      SELF.Kill().

    SELF.bAutoFlushOnDestruct = bAutoFlushOnDestruct
    SELF.ErrorHandler &= ErrorHandler
    SELF.FileHandler &= NEW(DocumentFileMgr)
    SELF.FileHandler.Init(ErrorHandler)
    SELF.DocComponentsQueue &= NEW(ComponentQueue)
    SELF.bInitialised = TRUE


DocumentEngine.Kill                      PROCEDURE

  CODE
    IF SELF.bInitialised
      IF SELF.bAutoFlushOnDestruct AND ~SELF.bFlushed
        SELF.WriteDocument()
      END
      SELF.DisposeComponentQueue()
      SELF.FileHandler.Kill()
      DISPOSE(SELF.FileHandler)
      SELF.bInitialised = false
      SELF.dwLastID = 0
      SELF.dwLastOpenFormat = 0
      SELF.dwLastQueueID = 0
      SELF.dwFirstChildPosition = 0
      SELF.dwLastChildPosition = 0
      IF ~SELF.OpenParentStack &= NULL
        DISPOSE(SELF.OpenParentStack)
      END
    END


DocumentEngine.TagToID                   PROCEDURE(ASTRING TagText)

  CODE
    RETURN 0


DocumentEngine.TagFromID                 PROCEDURE(ASTRING TagID)

  CODE
    RETURN 0


DocumentEngine.SetFileName               PROCEDURE(STRING strFileName, BYTE bCreateFile)

nErr            LONG

  CODE
    SELF.bFileSet = false
?   ASSERT(SELF.bInitialised, '<13><10>SetFile : This Document Engine has not been Initialised.')
    IF SELF.bInitialised
      szGloDocFileName = strFileName
      SELF.szDocFileName = strFileName
      IF bCreateFile
        CREATE(DosFile)
        nErr = ERRORCODE()
        IF ~nErr
          SELF.bFileSet = true
        ELSE
?         ASSERT(0, '<13><10>SetFile : Invalid Filename or File Access Error on Create. Err : ' & nErr)
        END
      ELSIF SELF.FileHandler.Open() = Level:Benign
        SELF.FileHandler.Close
        SELF.bFileSet = true
      ELSE
?       ASSERT(0, '<13><10>SetFile : File access error on Open.')
      END
    END
    RETURN SELF.bFileSet


DocumentEngine.GetFileName               PROCEDURE(*CSTRING szDocFileName)

  CODE
    szDocFileName = SELF.szDocFileName
    RETURN SELF.bFileSet


DocumentEngine.WriteDocument             PROCEDURE(BYTE bFlush)

bResult       BYTE
ErrorMgr      &ErrorClass
bAutoFlush    BYTE

  CODE
    IF ~SELF.bFileSet
?     ASSERT(0, '<13><10>WriteDocument : File not Initialised.')
    ELSE
?     ASSERT(SELF.bInitialised, '<13><10>WriteDocument : Document not Initialised.')
      IF SELF.bInitialised
        bResult = SELF.FileHandler.Open()
        IF bResult
?         ASSERT(FALSE, '<13><10>WriteDocument : Cannot Open File. Error ' & ERROR())
        ELSE
          SELF.OnDocInitFlush
          SELF.FlushComponentQueue(1)
          SELF.OnDocCompleteFlush
          SELF.FlushBuffer()
          SELF.FileHandler.Close
          IF bFlush
            SELF.bFlushed = true
            ErrorMgr &= SELF.ErrorHandler
            bAutoFlush = SELF.bAutoFlushOnDestruct
            SELF.Kill
            SELF.Init(ErrorMgr, bAutoFlush)
            SELF.bFlushed = false
          END
        END
      END
    END


DocumentEngine.IsInitialised            PROCEDURE

  CODE
    RETURN SELF.bInitialised


DocumentEngine.FlushComponentQueue     PROCEDURE(LONG dwParentPointer)

iCnt          LONG,AUTO
nErr          LONG
bFound        BYTE
dwID          LONG
dwParentID    LONG
bChildren     BYTE
LocComponentInfo GROUP(ComponentGroup).

  CODE
    GET(SELF.DocComponentsQueue, dwParentPointer)
    IF ERRORCODE()
      !Throw Error
    ELSE
      iCnt = dwParentPointer
      dwParentID = SELF.DocComponentsQueue.ComponentInfo.dwParentID
      LOOP
        bChildren = false
        dwID = SELF.DocComponentsQueue.ComponentInfo.dwID
        SELF.OnStartComponentFlush(SELF.DocComponentsQueue.ComponentInfo)
        LocComponentInfo :=: SELF.DocComponentsQueue.ComponentInfo
        iCnt += 1
        GET(SELF.DocComponentsQueue, iCnt)
        nErr = ERRORCODE()
        IF ~nErr
          IF SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwID
            iCnt = SELF.FlushComponentQueue(iCnt)
          END
        END
        SELF.OnEndComponentFlush(LocComponentInfo)
        IF nErr
          BREAK
        END
        bFound = false
        IF SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwParentID
          bFound = true
        END
        nErr = ERRORCODE()
        IF nErr OR ~bFound
          BREAK
        END
      END
    END
    RETURN iCnt


DocumentEngine.FlushOptions              PROCEDURE(WrapFormatOptQueue WrapFormats)

iCnt            LONG,AUTO

  CODE
    iCnt = 1
    LOOP
      GET(WrapFormats, iCnt)
      IF ERRORCODE()
        BREAK
      END
      SELF.OnFlushOption(WrapFormats.strOptionName, WrapFormats.OptionValue)
      iCnt += 1
    END


DocumentEngine.FetchData                 PROCEDURE(LONG dwFilePos, LONG dwBytes, *STRING strBuffer)

nErr              LONG

  CODE
    OPEN(DosFile)
    GET(DosFile, dwFilePos, dwBytes)
    nErr = ERRORCODE()
?   ASSERT(~nErr, '<13><10>Could not read ' & dwBytes & ' bytes from the File. Error : ' & nErr)
    IF ~nErr
      strBuffer = DosFile.strEntry
    END


DocumentEngine.WriteData                 PROCEDURE(*CSTRING szDataBuffer)

  CODE
    IF LEN(CLIP(DosFile:strEntry)) + LEN(szDataBuffer) < SIZE(DosFile:strEntry)
      DosFile:strEntry = CLIP(DosFile:strEntry) & szDataBuffer
    ELSE
      SELF.FileHandler.Insert()
      DosFile:strEntry = szDataBuffer
    END


DocumentEngine.WriteData                 PROCEDURE(STRING strDataBuffer)

szDataBuffer      CSTRING(SIZE(DosFile:strEntry) + 1)

  CODE
    szDataBuffer = strDataBuffer
    SELF.WriteData(szDataBuffer)


DocumentEngine.IsFileSet                 PROCEDURE

  CODE
    RETURN SELF.bFileSet


DocumentEngine.FlushBuffer               PROCEDURE

  CODE
    IF LEN(CLIP(DosFile:strEntry)) > 0
      SELF.FileHandler.Insert()
      DosFile:strEntry = ''
    END


DocumentEngine.GetLastID                 PROCEDURE

  CODE
    RETURN SELF.dwLastID


DocumentEngine.FindLastChild             PROCEDURE(LONG dwID)

iCnt                LONG
dwPreviousID        LONG

  CODE
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ERRORCODE()
      !Throw Error
      iCnt = 0
    ELSE
      iCnt = POINTER(SELF.DocComponentsQueue)
      LOOP
        iCnt += 1
        dwPreviousID = SELF.DocComponentsQueue.ComponentInfo.dwID
        GET(SELF.DocComponentsQueue, iCnt)
        IF ERRORCODE()
          BREAK
        ELSE
          IF SELF.DocComponentsQueue.ComponentInfo.dwParentID ~= dwID AND |
             SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwPreviousID
            iCnt = SELF.FindLastChild(dwPreviousID)
          END
          IF ERRORCODE()
            BREAK
          END
        END
      END
    END
    RETURN iCnt


DocumentEngine.PutFormat                 PROCEDURE(ASTRING strFormat, LONG RelID, IDocMoveType nMoveTo)

  CODE
    RETURN SELF.PutFormat(strFormat, '', RelID, nMoveTo, '')


DocumentEngine.PutFormat                 PROCEDURE(ASTRING strFormat, STRING FormatValue, LONG RelID, |
                                                IDocMoveType nMoveTo, STRING strData)

OldPointer              LONG
NewPointer              LONG
dwParentID              LONG
LocdwID                 LONG
LocComponentInfo        GROUP(ComponentGroup).

  CODE
    IF SELF.bInitialised
      IF RelID
        IF nMoveTo = 0 OR nMoveTo > MV_AFTER
          nMoveTo = MV_AFTER
        END
        SELF.DocComponentsQueue.ComponentInfo.dwID = RelID
        GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
        IF ERRORCODE()
          !Throw Error
          RETURN 0
        ELSE
          dwParentID = SELF.DocComponentsQueue.ComponentInfo.dwID
          LocComponentInfo :=: SELF.DocComponentsQueue.ComponentInfo
          NewPointer = POINTER(SELF.DocComponentsQueue)
          IF nMoveTo = MV_AFTER
            LOOP
              NewPointer += 1
              GET(SELF.DocComponentsQueue, NewPointer)
              IF ERRORCODE() = 30 OR SELF.DocComponentsQueue.ComponentInfo.dwParentID ~= dwParentID
                BREAK
              END
            END
            dwParentID = LocComponentInfo.dwParentID
          ELSIF nMoveTo = MV_BEFORE
            dwParentID = LocComponentInfo.dwParentID
          ELSIF nMoveTo = MV_CHILD
            OldPointer = NewPointer
            NewPointer = SELF.FindLastChild(LocComponentInfo.dwID)
            IF ~NewPointer
              NewPointer = OldPointer + 1
            END
          END
          CLEAR(SELF.DocComponentsQueue.ComponentInfo)
          SELF.InitStructure(strFormat, FormatValue, strData)
          SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwParentID
          LocdwID = SELF.DocComponentsQueue.ComponentInfo.dwID
          ADD(SELF.DocComponentsQueue, NewPointer)
        END
      ELSE
        SELF.InitStructure(strFormat, FormatValue, strData)
        LocdwID = SELF.DocComponentsQueue.ComponentInfo.dwID
        ADD(SELF.DocComponentsQueue)
      END
    END
    RETURN LocdwID


DocumentEngine.BeginFormat               PROCEDURE(ASTRING strFormat, <STRING strFormatValue>)

RelID           LONG
nMoveTo         IDocMoveType
OFI             &OpenFormatInfo

  CODE
    IF strFormat ~= FT_DocStart
      IF SELF.OpenParentStack &= NULL
        SELF.OpenParentStack &= NEW(OpenFormatStack)
        RelID = 0
        SELF.dwLastOpenFormat = 0
      ELSE
        RelID = SELF.dwLastOpenFormat
      END
      OFI &= NEW(OpenFormatInfo)
      OFI.dwParentID = SELF.dwLastOpenFormat
      OFI.strFormat = strFormat
      IF ~OMITTED(3)
        !OFI.OptFormatValue
      END
      IF SELF.dwLastOpenFormat
        nMoveTo = MV_CHILD
      ELSE
        nMoveTo = 0
      END
      IF ~OMITTED(3)
        SELF.dwLastOpenFormat = SELF.PutFormat(strFormat, strFormatValue, RelID, nMoveTo, '')
      ELSE
        SELF.dwLastOpenFormat = SELF.PutFormat(strFormat, '', RelID, nMoveTo, '')
      END
      SELF.OpenParentStack.Push(ADDRESS(OFI))
    END


DocumentEngine.EndFormat                 PROCEDURE(ASTRING strFormat)

OFI             &OpenFormatInfo

  CODE
    IF ~SELF.OpenParentStack &= NULL
      OFI &= SELF.OpenParentStack.Pop()
?     ASSERT(~OFI &= NULL, '<13><10>DocumentEngine.EndFormat : Stack Error in Parent Format Stack, Element is NULL.')
      SELF.dwLastOpenFormat = OFI.dwParentID
      IF ~SELF.OpenParentStack.Elements()
        DISPOSE(SELF.OpenParentStack)
        SELF.OpenParentStack &= NULL
      END
      DISPOSE(OFI)
    END


DocumentEngine.PutDataSerial             PROCEDURE(*STRING strData)

  CODE
    SELF.PutFormat(FT_GenericData, '', SELF.dwLastOpenFormat, MV_CHILD, strData)


DocumentEngine.InitStructure             PROCEDURE(ASTRING strFormat, STRING FormatValue, STRING strData)

dwLen           LONG

  CODE
    SELF.DocComponentsQueue.ComponentInfo.strFormat = strFormat
    SELF.DocComponentsQueue.ComponentInfo.dwID = SELF.GetNextID()
    SELF.DocComponentsQueue.ComponentInfo.dwParentID = 0
    SELF.DocComponentsQueue.ComponentInfo.WrapFormats &= NULL
    dwLen = LEN(CLIP(FormatValue))
    IF dwLen
      SELF.DocComponentsQueue.ComponentInfo.OptFormatValue &= NEW(STRING(dwLen))
      SELF.DocComponentsQueue.ComponentInfo.OptFormatValue = FormatValue
    ELSE
      SELF.DocComponentsQueue.ComponentInfo.OptFormatValue &= NULL
    END
    dwLen = LEN(CLIP(strData))
    IF dwLen
      SELF.DocComponentsQueue.ComponentInfo.strData &= NEW(STRING(dwLen))
      SELF.DocComponentsQueue.ComponentInfo.strData = strData
    ELSE
      SELF.DocComponentsQueue.ComponentInfo.strData &= NULL
    END


DocumentEngine.PutData                   PROCEDURE(STRING strData)

  CODE
    RETURN SELF.PutFormat(FT_GenericData, '', 0, 0, strData)


DocumentEngine.AddData                   PROCEDURE(*STRING strData, LONG dwID)

dwLen       LONG

  CODE
    CLEAR(SELF.DocComponentsQueue.ComponentInfo)
    IF ~dwID
      SELF.DocComponentsQueue.ComponentInfo.dwID = SELF.dwLastID
    ELSE
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
    END
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ERRORCODE()
      !Throw Error
    ELSE
      dwLen = LEN(CLIP(strData))
      SELF.DocComponentsQueue.ComponentInfo.strData &= NEW(STRING(dwLen))
      SELF.DocComponentsQueue.ComponentInfo.strData = strData
      PUT(SELF.DocComponentsQueue)
    END
    RETURN SELF.DocComponentsQueue.ComponentInfo.dwID


DocumentEngine.PutCell                   PROCEDURE(LONG dwRow, LONG dwColumn, *STRING strData)

  CODE
    RETURN 0


DocumentEngine.PutOption                 PROCEDURE(ASTRING strOptionName, *STRING OptionValue, LONG dwComponentID)

LocdwID         LONG

  CODE
    CLEAR(SELF.DocComponentsQueue.ComponentInfo)
    SELF.DocComponentsQueue.ComponentInfo.dwID = dwComponentID
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ERRORCODE()
      !Throw Error
    ELSE
      IF SELF.DocComponentsQueue.ComponentInfo.WrapFormats &= NULL
        SELF.DocComponentsQueue.ComponentInfo.WrapFormats &= NEW(WrapFormatOptQueue)
      END
      SELF.DocComponentsQueue.ComponentInfo.WrapFormats.strOptionName = strOptionName
      SELF.DocComponentsQueue.ComponentInfo.WrapFormats.OptionValue = OptionValue
      ADD(SELF.DocComponentsQueue.ComponentInfo.WrapFormats, |
          SELF.DocComponentsQueue.ComponentInfo.WrapFormats.strOptionName)
      LocdwID = SELF.DocComponentsQueue.ComponentInfo.dwID
      PUT(SELF.DocComponentsQueue)
    END
    RETURN LocdwID


DocumentEngine.GetOption                 PROCEDURE(LONG dwID, ASTRING strOptionName)

  CODE
    SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ERRORCODE()
      !Throw Error
      RETURN ''
    ELSE
      IF SELF.DocComponentsQueue.ComponentInfo.WrapFormats &= NULL
        RETURN ''
      ELSE
        SELF.DocComponentsQueue.ComponentInfo.WrapFormats.strOptionName = strOptionName
        GET(SELF.DocComponentsQueue.ComponentInfo.WrapFormats, |
            SELF.DocComponentsQueue.ComponentInfo.WrapFormats.strOptionName)
        IF ERRORCODE()
          RETURN ''
        END
      END
    END
    RETURN SELF.DocComponentsQueue.ComponentInfo.WrapFormats.OptionValue


DocumentEngine.MoveComponent             PROCEDURE(LONG dwID, LONG RelID, IDocMoveType nMoveTo)

NewPointer          LONG
bResult             BYTE
bChild              BYTE
LocComponentInfo    LIKE(ComponentGroup)
dwNewParentID       LONG

  CODE
    IF RelID AND (RelID ~= dwID)
      IF nMoveTo = 0 OR nMoveTo > MV_AFTER
        nMoveTo = MV_AFTER
      END
      SELF.DocComponentsQueue.ComponentInfo.dwID = RelID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
      IF ERRORCODE()
        !Throw Error
      ELSE
        SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
        GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
        IF ERRORCODE()
          !Throw Error
        ELSE
          LocComponentInfo :=: SELF.DocComponentsQueue.ComponentInfo
          DELETE(SELF.DocComponentsQueue)
          SELF.DocComponentsQueue.ComponentInfo.dwID = RelID
          GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
          NewPointer = POINTER(SELF.DocComponentsQueue)
          dwNewParentID = SELF.DocComponentsQueue.ComponentInfo.dwParentID
          IF nMoveTo = MV_AFTER
            NewPointer += 1
          ELSIF nMoveTo = MV_CHILD
            dwNewParentID = SELF.DocComponentsQueue.ComponentInfo.dwID
            NewPointer += 1
            bChild = true
          END
          SELF.DocComponentsQueue.ComponentInfo :=: LocComponentInfo
          SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwNewParentID
          ADD(SELF.DocComponentsQueue, NewPointer)
          IF ERRORCODE()
            !Throw Error
          ELSE
            bResult = SELF.MoveChildren(dwID)
          END
        END
      END
    END
    GET(SELF.DocComponentsQueue, 0)
    RETURN bResult


DocumentEngine.MoveChildren              PROCEDURE(LONG dwID)

dwNewPointer    LONG
bResult         BYTE
iCnt            LONG

TempChildrenQueue &ComponentQueue

! **ANDY** Add support for childrens children - Make recursive

  CODE
    TempChildrenQueue &= NEW(ComponentQueue)
    LOOP
      SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwParentID)
      IF ERRORCODE()
        BREAK
      ELSE
        iCnt += 1
        TempChildrenQueue.ComponentInfo :=: SELF.DocComponentsQueue.ComponentInfo
        ADD(TempChildrenQueue)
        DELETE(SELF.DocComponentsQueue)
      END
    END
    IF ~iCnt
      bResult = true
    END
    IF ~bResult
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
      IF ERRORCODE()
        !Throw Error
      ELSE
        dwNewPointer = POINTER(SELF.DocComponentsQueue)
        iCnt = 0
        LOOP
          GET(TempChildrenQueue, 1)
          IF ERRORCODE()
            BREAK
          ELSE
            iCnt += 1
            SELF.DocComponentsQueue.ComponentInfo :=: TempChildrenQueue.ComponentInfo
            dwNewPointer += 1
            ADD(SELF.DocComponentsQueue, dwNewPointer)
            DELETE(TempChildrenQueue)
          END
        END
        IF iCnt
          bResult = true
        END
      END
    END
    DISPOSE(TempChildrenQueue)
    RETURN bResult


DocumentEngine.GetNextFormat             PROCEDURE(LONG dwLastID)

dwID        LONG
LocPointer  LONG

  CODE
    IF dwLastID = 0
      dwLastID = 1
    END

    SELF.DocComponentsQueue.ComponentInfo.dwID = dwLastID
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ~ERRORCODE()
      LocPointer = POINTER(SELF.DocComponentsQueue)
      LocPointer += 1
      GET(SELF.DocComponentsQueue, LocPointer)
      IF ~ERRORCODE()
        dwID = SELF.DocComponentsQueue.ComponentInfo.dwID
      END
    END
    RETURN dwID


DocumentEngine.GetNextChildFormat        PROCEDURE(LONG dwParentID, LONG dwLastID)

dwID            LONG
LocPointer      LONG

  CODE
?   ASSERT(dwParentID, '<13><10>Error : No Parent ID was specified.')
    IF dwLastID
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwLastID
    ELSE
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwParentID
    END
    GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
    IF ~ERRORCODE()
      LocPointer = POINTER(SELF.DocComponentsQueue)
      LocPointer += 1
      GET(SELF.DocComponentsQueue, LocPointer)
      IF ~ERRORCODE()
        IF SELF.DocComponentsQueue.ComponentInfo.dwParentID = dwParentID
          dwID = SELF.DocComponentsQueue.ComponentInfo.dwID
        END
      END
    END
    RETURN dwID


DocumentEngine.GetFormatInfo             PROCEDURE(LONG dwID, ComponentGroup ComponentInfo)

bSuccess        BYTE

  CODE
?   ASSERT(dwID, '<13><10>Error : No Element ID was specified')
    IF dwID
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
      IF ~ERRORCODE()
        ComponentInfo :=: SELF.DocComponentsQueue.ComponentInfo
        bSuccess = true
      END
    END
    RETURN bSuccess


!DocumentEngine.GetOption                 PROCEDURE(LONG dwID, ASTRING strOptionName)

!  CODE


DocumentEngine.HasChildren               PROCEDURE(LONG dwID)

bChildren       BYTE
LocPointer      LONG

  CODE
?   ASSERT(dwID, '<13><10>Warning : No Element ID was specified')
    IF dwID
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
      IF ~ERRORCODE()
        LocPointer = POINTER(SELF.DocComponentsQueue)
        LocPointer += 1
        GET(SELF.DocComponentsQueue, LocPointer)
        IF ~ERRORCODE()
          bChildren = true
        END
      END
    END
    RETURN bChildren


DocumentEngine.HasData                   PROCEDURE(LONG dwID)

bHasData        BYTE

  CODE
?   ASSERT(dwID, '<13><10>Warning : No Element ID was specified')
    IF dwID
      SELF.DocComponentsQueue.ComponentInfo.dwID = dwID
      GET(SELF.DocComponentsQueue, SELF.DocComponentsQueue.ComponentInfo.dwID)
      IF ~ERRORCODE() AND ~SELF.DocComponentsQueue.ComponentInfo.strData &= NULL
        bHasData = true
      END
    END
    RETURN bHasData


DocumentEngine.DisposeComponentQueue     PROCEDURE

  CODE
    LOOP
      GET(SELF.DocComponentsQueue, 1)
      IF ERRORCODE()
        BREAK.
      IF ~SELF.DocComponentsQueue.ComponentInfo.WrapFormats &= NULL
        FREE(SELF.DocComponentsQueue.ComponentInfo.WrapFormats)
        DISPOSE(SELF.DocComponentsQueue.ComponentInfo.WrapFormats)
      END
      IF ~SELF.DocComponentsQueue.ComponentInfo.OptFormatValue &= NULL
        DISPOSE(SELF.DocComponentsQueue.ComponentInfo.OptFormatValue)
      END
      IF ~SELF.DocComponentsQueue.ComponentInfo.strData &= NULL
        DISPOSE(SELF.DocComponentsQueue.ComponentInfo.strData)
      END
      DELETE(SELF.DocComponentsQueue)
    END
    DISPOSE(SELF.DocComponentsQueue)


DocumentEngine.GetNextID                 PROCEDURE

  CODE
    SELF.dwLastID += 1
    RETURN SELF.dwLastID


DocumentEngine.OnDocInitFlush            PROCEDURE

  CODE


DocumentEngine.OnDocCompleteFlush        PROCEDURE

  CODE


DocumentEngine.OnStartComponentFlush     PROCEDURE(ComponentGroup ComponentInfo)

  CODE


DocumentEngine.OnEndComponentFlush       PROCEDURE(ComponentGroup ComponentInfo)

  CODE


DocumentEngine.OnFlushOption             PROCEDURE(ASTRING strOptionName, *STRING OptionValue)

  CODE


DocumentEngine.OnReadComponent           PROCEDURE(ComponentGroup ComponentInfo)

  CODE


DocumentEngine.OnReadOption              PROCEDURE(LONG dwOption, *STRING OptionValue)

  CODE


DocumentEngine.IsInputSourceOpen         PROCEDURE

  CODE
    IF ~SELF.bInputSourceOpen
      SELF.bInputSourceOpen = SELF.FileHandler.Open()
?     ASSERT(SELF.bInputSourceOpen)
    END
    RETURN SELF.bInputSourceOpen


OpenFormatStack.OnKillElement         PROCEDURE(LONG lpObject)

OFI         &OpenFormatInfo

  CODE
    OFI &= ReturnForReference(lpObject)
    DISPOSE(OFI)


MapAStringToAString.Destruct          PROCEDURE

  CODE


MapAStringToAString.AddAssoc          PROCEDURE(ASTRING LeftAssoc, ASTRING RightAssoc)

  CODE
    SELF.MapIndex = TIEAS(UPPER(LeftAssoc), SELF.MapIndex, UPPER(RightAssoc))
    SELF.MapIndex = TIEAS(UPPER(RightAssoc), SELF.MapIndex, UPPER(LeftAssoc))


MapAStringToAString.GetLeftAssoc      PROCEDURE(ASTRING RightAssoc)

  CODE
    RETURN TIEDAS(UPPER(RightAssoc), SELF.MapIndex)


MapAStringToAString.GetRightAssoc     PROCEDURE(ASTRING LeftAssoc)

  CODE
    RETURN TIEDAS(UPPER(LeftAssoc), SELF.MapIndex)


MapAStringToAString.Exists            PROCEDURE(ASTRING Element)

  CODE        
    RETURN TIED(UPPER(Element), SELF.MapIndex)


ReturnForReference                    PROCEDURE(LONG lpVoid)

  CODE
    RETURN lpVoid


DocumentClass.Construct               PROCEDURE

  CODE


DocumentClass.Destruct                PROCEDURE

  CODE


DocumentClass.Init                    PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct)

  CODE
    SELF.InitTags


DocumentClass.Kill                    PROCEDURE

  CODE


DocumentClass.InitTags                PROCEDURE

  CODE


DocumentClass.TagToID                 PROCEDURE(ASTRING TagText)

  CODE
    RETURN SELF.DocEngine.TagToID(TagText)


DocumentClass.TagFromID               PROCEDURE(ASTRING TagID)

  CODE
    RETURN SELF.DocEngine.TagFromID(TagID)


DocumentEngine.FetchLastComponentRead PROCEDURE

  CODE
    RETURN SELF.dwLastComponentRead


DocumentEngine.FetchNextComponent     PROCEDURE

bResult         BYTE
dwID            LONG

  CODE
    dwID = SELF.GetNextFormat(SELF.dwLastComponentRead)
    SELF.dwLastComponentRead += 1
    IF dwID
      bResult = true
    END
    RETURN bResult

DocumentEngine.FetchComponentType     PROCEDURE

  CODE
    RETURN 0


DocumentEngine.FetchComponentValue    PROCEDURE

  CODE
    RETURN ''

DocumentEngine.FetchComponentLabel    PROCEDURE

  CODE
    RETURN ''

