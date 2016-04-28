  MEMBER

_ABHTML_AStrings_      EQUATE(1)

  INCLUDE('ABHTML.INC'),ONCE
  INCLUDE('ABDOCLAY.INC'),ONCE
  INCLUDE('ABHTMLEX.INC'),ONCE
  INCLUDE('IDOCFT.INC'),ONCE
  INCLUDE('DYNSTR.INC'),ONCE


FT_CellPadding          ASTRING
FT_Heading              ASTRING

GloDynStr               &IDynStr


HtmlEngine.Construct                PROCEDURE

  CODE
    FT_CellPadding = 'CELLPADDING'
    FT_Heading = 'H'
    GloDynStr &= NewDynStr()


HtmlEngine.Destruct                 PROCEDURE

  CODE


HtmlEngine.Kill                     PROCEDURE

  CODE
    PARENT.Kill
    DisposeDynStr(GloDynStr)


HtmlEngine.TagToID                  PROCEDURE(ASTRING TagText)

RetTokenID          ASTRING

  CODE
    RetTokenID = SELF.TagMap.GetLeftAssoc(TagText)
    RETURN RetTokenID


HtmlEngine.TagFromID                PROCEDURE(ASTRING TagID)

RetTokenText        ASTRING

  CODE
    RetTokenText = SELF.TagMap.GetRightAssoc(TagID)
    RETURN RetTokenText


!Replace On methods with an implementation of the create serial
HtmlEngine.OnDocInitFlush           PROCEDURE

  CODE
!    SELF.Layout
    SELF.WriteData('<<HTML><13><10>')


HtmlEngine.OnDocCompleteFlush       PROCEDURE

  CODE
    SELF.WriteData('<</HTML><13><10>')


HtmlEngine.OnStartComponentFlush    PROCEDURE(ComponentGroup ComponentInfo)

szStartToken            CSTRING(256)
szEndToken              CSTRING(256)

bWriteDataAfter         BYTE
bDynStrUsed             BYTE

  CODE
    GloDynStr.Kill
    bWriteDataAfter = true
    CASE ComponentInfo.strFormat        !Set Start Token text
    OF FT_NewLine
      szStartToken = '<13><10>'
    OF FT_GenericData
      szStartToken = ''
    ELSE                                !Generic case
      szStartToken = '<<' & CLIP(UPPER(SELF.TagFromID(ComponentInfo.strFormat)))
    END
    CASE ComponentInfo.strFormat        !Set End Token text
    OF   FT_NewLine
    OROF FT_DocFooter
      szEndToken = '>'
    OF FT_GenericData
      szEndToken = ''
    OF   FT_TableRow
    OROF FT_TableCell
    OROF FT_Title
    OROF FT_Heading
      szEndToken = '>'
    ELSE                                !Generic case
      szEndToken = '><13><10>'
    END
    CASE ComponentInfo.strFormat        !Set optional info
    OF FT_Link
      IF ~ComponentInfo.OptFormatValue &= NULL
        szStartToken = szStartToken & ' NAME="' & CLIP(ComponentInfo.OptFormatValue) & '"'
      END
    ELSE
      IF ~ComponentInfo.OptFormatValue &= NULL
        szStartToken = szStartToken & CLIP(ComponentInfo.OptFormatValue)
      END
    END
    SELF.WriteData(szStartToken)
    IF ~ComponentInfo.WrapFormats &= NULL
      SELF.FlushOptions(ComponentInfo.WrapFormats)
    END
    IF ~ComponentInfo.strData &= NULL
      IF bWriteDataAfter
        GloDynStr.Cat(szEndToken & CLIP(ComponentInfo.strData))
        bDynStrUsed = true
      ELSE
        GloDynStr.Cat(CLIP(ComponentInfo.strData & szEndToken))
        bDynStrUsed = true
      END
    END
    IF bDynStrUsed
      SELF.WriteData(GloDynStr.CStr())
      GloDynStr.Kill
    ELSE
      SELF.WriteData(szEndToken)
    END


HtmlEngine.OnEndComponentFlush      PROCEDURE(ComponentGroup ComponentInfo)

strToken            CSTRING(256)
strBreakToken       CSTRING(7)

  CODE
    IF SELF.bAutoLineBreak
      strBreakToken = '<BR><13><10>'
    END
    CASE ComponentInfo.strFormat
    OF FT_DocHeader
      strToken = '<</HEAD><13><10>'
    OF FT_DocBody
      strToken = '<</BODY><13><10>'
    OF FT_Title
      strToken = '<</TITLE><13><10>'
    OF FT_Font
      strToken = '<</FONT><13><10>'
    OF FT_Table
      strToken = '<</TABLE><13><10>'
    OF FT_TableRow
      strToken = '<</TR><13><10>'
    OF FT_TableCell
      strToken = '<</TD>'
    OF FT_Heading
      strToken = '<</H'
      IF ~ComponentInfo.OptFormatValue &= NULL
        strToken = strToken & CLIP(ComponentInfo.OptFormatValue)
      END
      strToken = strToken & '>' & strBreakToken
    OF FT_GenericData
      strToken = strBreakToken
    OF FT_Link
      strToken = '<</A>' & strBreakToken & '<13><10>'
    END
    SELF.WriteData(strToken)


HtmlEngine.OnFlushOption            PROCEDURE(ASTRING strOptionName, *STRING OptionValue)

strToken            CSTRING(256)

  CODE
    strToken = ' ' & strOptionName & '="' & CLIP(OptionValue) & '"'
    CASE strOptionName          !Only specific ones need go in here now.
    OF FT_TableBGColour
      strToken = ' BGCOLOR="' & CLIP(OptionValue) & '"'
    OF FT_TableBorderWidth
      strToken = ' BORDER="' & CLIP(OptionValue) & '"'
    OF FT_LinkName
      strToken = ' NAME="' & CLIP(OptionValue) & '"'
    OF FT_LinkTarget
      strToken = ' HREF="' & CLIP(OptionValue) & '"'
    END
    SELF.WriteData(strToken)


HtmlEngine.Layout PROCEDURE
LayoutEngine LayoutClass
PosStart IDocIdType
x        LONG
y        LONG
dx       LONG
dy       LONG
WF       &WrapFormatOptQueue,AUTO
  CODE

  !JCSMORE>ANDY The whole this engine should be talking to the
  !             IDocumentRead interface

  GET(SELF.DocComponentsQueue, 1)
  LOOP WHILE ~ERRORCODE()
    WF &= SELF.DocComponentsQueue.ComponentInfo.WrapFormats
    IF ~(WF &= NULL)
      WF.strOptionName = 'XPOS'
      GET(WF, WF.strOptionName)
      IF ERRORCODE()
        IF PosStart
          LayoutEngine.Layout(PosStart)
          PosStart=0
        END
      ELSE
        x=WF.OptionValue
        PosStart=SELF.DocComponentsQueue.ComponentInfo.dwID
        WF.strOptionName = 'YPOS'
        GET(WF, WF.strOptionName)
        y=CHOOSE(ERRORCODE()=True, 0, WF.OptionValue)
        WF.strOptionName = 'WIDTH'
        GET(WF, WF.strOptionName)
        dx=CHOOSE(ERRORCODE()=True, 0, WF.OptionValue)
        WF.strOptionName = 'HEIGHT'
        GET(WF, WF.strOptionName)
        dy=CHOOSE(ERRORCODE()=True, 0, WF.OptionValue)
        LayoutEngine.Insert(SELF.DocComponentsQueue.ComponentInfo.dwID, x, y, dx, dy)
      END
    END

    SELF.OnStartComponentFlush(SELF.DocComponentsQueue.ComponentInfo)
    GET(SELF.DocComponentsQueue, POINTER(SELF.DocComponentsQueue)+1)
  END
  IF PosStart THEN LayoutEngine.Layout(PosStart) .


HtmlDocumentClass.Construct                      PROCEDURE

  CODE
    SELF.DocEngine &= NEW(HtmlEngine)
    SELF.LayoutEngine &= NEW LayoutClass


HtmlDocumentClass.Destruct                       PROCEDURE

  CODE
    SELF.Kill
    DISPOSE(SELF.DocEngine)
    DISPOSE(SELF.LayoutEngine)


HtmlDocumentClass.Init                           PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct)

  CODE
    PARENT.Init(ErrorHandler, bAutoFlushOnDestruct)
    SELF.DocEngine.Init(ErrorHandler, bAutoFlushOnDestruct)
    SELF.LayoutEngine.Init(SELF.IDocumentCreate)


HtmlDocumentClass.InitTags                       PROCEDURE

  CODE
    PARENT.InitTags
    SELF.DocEngine.TagMap.AddAssoc(FT_NewLine, '<13><10>')
    SELF.DocEngine.TagMap.AddAssoc(FT_LineBreak, 'BR')
    SELF.DocEngine.TagMap.AddAssoc(FT_DocStart, 'HTML')
    SELF.DocEngine.TagMap.AddAssoc(FT_DocHeader, 'HEAD')
    SELF.DocEngine.TagMap.AddAssoc(FT_DocBody, 'BODY')
    SELF.DocEngine.TagMap.AddAssoc(FT_Table, 'TABLE')
    SELF.DocEngine.TagMap.AddAssoc(FT_TableRow, 'TR')
    SELF.DocEngine.TagMap.AddAssoc(FT_TableCell, 'TD')
    SELF.DocEngine.TagMap.AddAssoc(FT_Title, 'TITLE')
    SELF.DocEngine.TagMap.AddAssoc(FT_Font, 'FONT')
    SELF.DocEngine.TagMap.AddAssoc(FT_Link, 'A')
    SELF.DocEngine.TagMap.AddAssoc(FT_TableBorderWidth, 'BORDER')
    SELF.DocEngine.TagMap.AddAssoc(FT_TableBGColour, 'BGCOLOR')
    SELF.DocEngine.TagMap.AddAssoc(FT_LinkName, 'NAME')
    SELF.DocEngine.TagMap.AddAssoc(FT_LinkTarget, 'HREF')
    SELF.DocEngine.TagMap.AddAssoc(FT_Comment, '!--')


HtmlDocumentClass.Kill                           PROCEDURE

  CODE
    PARENT.Kill
    SELF.LayoutEngine.Kill


HtmlDocumentClass.SetAutoLineBreak               PROCEDURE(BYTE bAutoLineBreak)

  CODE
    SELF.DocEngine.bAutoLineBreak = bAutoLineBreak



HtmlDocumentClass.IDocumentConstraint.GetConstraints       PROCEDURE

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentConstraint.GetConstraint        PROCEDURE(LONG Constraint, *LONG ConstraintValue)

  CODE
    RETURN false


HtmlDocumentClass.IDocumentConstraint.GetCreateInterface   PROCEDURE

  CODE
    RETURN SELF.IDocumentCreate


HtmlDocumentClass.IDocumentConstraint.GetCreateSerialInterface PROCEDURE

  CODE
    RETURN SELF.IDocumentCreateSerial


HtmlDocumentClass.IDocumentConstraint.GetSerializeInterface PROCEDURE

  CODE
    RETURN NULL


HtmlDocumentClass.IDocumentConstraint.GetReadInterface     PROCEDURE

  CODE
    RETURN SELF.IDocumentRead


HtmlDocumentClass.IDocumentConstraint.GetSearchInterface   PROCEDURE

  CODE
    RETURN NULL


HtmlDocumentClass.IDocumentConstraint.GetPositionInterface PROCEDURE

  CODE
    RETURN SELF.IDocumentPosition


HtmlDocumentClass.IDocumentCreate.PutFormat                PROCEDURE(ASTRING strFormat, LONG RelID, IDocMoveType nMoveTo)

  CODE
    RETURN SELF.DocEngine.PutFormat(strFormat, RelID, nMoveTo)


HtmlDocumentClass.IDocumentCreate.PutFormat                PROCEDURE(ASTRING strFormat, STRING strData, <STRING FormatValue>, LONG RelID, LONG nMoveTo)

dwID            LONG

  CODE
    IF OMITTED(4)
      dwID = SELF.DocEngine.PutFormat(strFormat, '', RelID, nMoveTo, strData)
    ELSE
      dwID = SELF.DocEngine.PutFormat(strFormat, FormatValue, RelID, nMoveTo, strData)
    END
    RETURN dwID


HtmlDocumentClass.IDocumentCreate.PutCell                  PROCEDURE(LONG dwRow, LONG dwColumn, STRING strData)

  CODE
    RETURN SELF.DocEngine.PutCell(dwRow, dwColumn, strData)


HtmlDocumentClass.IDocumentCreate.PutOption                PROCEDURE(ASTRING strOptionName, STRING OptionValue, |
                                                          LONG dwComponentID)

dwResult        LONG

  CODE
    IF dwComponentID = 0
      dwComponentID = SELF.DocEngine.GetLastID()
    END
    dwResult = SELF.DocEngine.PutOption(strOptionName, OptionValue, dwComponentID)
    RETURN dwResult


HtmlDocumentClass.IDocumentCreate.PutData                  PROCEDURE(STRING strData)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreate.PutData                  PROCEDURE(IBlobRead InBlob)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreate.PutData                  PROCEDURE(ASTRING strFormat, IBlobRead InBlob, <STRING FormatValue>, LONG RelID, LONG nMoveTo)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreate.PutTag                   PROCEDURE(ASTRING strName, LONG RelID, IDocMoveType nMoveTo)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreate.UseTag                   PROCEDURE(ASTRING strName, STRING strTagData, LONG RelID, IDocMoveType nMoveTo)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreate.MoveComponent            PROCEDURE(LONG dwID, LONG RelID, IDocMoveType nMoveTo)

  CODE
    RETURN SELF.DocEngine.MoveComponent(dwID, RelID, nMoveTo)


HtmlDocumentClass.IDocumentCreate.WriteDocument            PROCEDURE

  CODE
    SELF.DocEngine.WriteDocument()


HtmlDocumentClass.IDocumentCreate.FlushDocument            PROCEDURE

  CODE
    SELF.DocEngine.WriteDocument(true)


HtmlDocumentClass.IDocumentCreate.SetFile                  PROCEDURE(STRING strFileName)

  CODE
    RETURN SELF.DocEngine.SetFileName(strFileName, true)


HtmlDocumentClass.IDocumentCreateSerial.BeginFormat        PROCEDURE(ASTRING strFormat, <STRING FormatValue>)

  CODE
    SELF.DocEngine.BeginFormat(strFormat, FormatValue)


HtmlDocumentClass.IDocumentCreateSerial.EndFormat          PROCEDURE(BYTE Missing)

  CODE
    SELF.DocEngine.EndFormat(Missing)


HtmlDocumentClass.IDocumentCreateSerial.PutOption          PROCEDURE(ASTRING strOptionName, STRING OptionValue)

  CODE


HtmlDocumentClass.IDocumentCreateSerial.PutData            PROCEDURE(STRING strData)

  CODE
    SELF.DocEngine.PutDataSerial(strData)


HtmlDocumentClass.IDocumentCreateSerial.Release            PROCEDURE

  CODE


HtmlDocumentClass.CloseFormat                              PROCEDURE

  CODE
    IF SELF.szPrevEndToken
      SELF.DocEngine.WriteData(SELF.szPrevEndToken)
      SELF.szPrevEndToken = ''
    END


HtmlDocumentClass.IDocumentCreateSerialToFile.SetFile      PROCEDURE(STRING strFileName)

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentCreateSerialToFile.BeginFormat  PROCEDURE(ASTRING strFormat, <STRING FormatValue>)

szStartToken            CSTRING(256)        !DynStr
OFI                     &OpenFormatInfo

  CODE
    szStartToken = '<<' & CLIP(UPPER(SELF.TagFromID(strFormat)))
    SELF.szPrevEndToken = '>'
    SELF.DocEngine.WriteData(szStartToken)
    IF SELF.SWOpenFormatStack &= NULL
      SELF.SWOpenFormatStack &= NEW(OpenFormatStack)
    END
    OFI &= NEW(OpenFormatInfo)
    OFI.dwParentID = 0
    OFI.strFormat = strFormat
    SELF.SWOpenFormatStack.Push(ADDRESS(OFI))


HtmlDocumentClass.IDocumentCreateSerialToFile.EndFormat    PROCEDURE(BYTE Missing)

OFI             &OpenFormatInfo
AS              ASTRING

  CODE
    IF ~SELF.SWOpenFormatStack &= NULL
      OFI &= SELF.SWOpenFormatStack.Pop()
?     ASSERT(~OFI &= NULL, '<13><10>DocumentEngine.EndFormat : Stack Error in Parent Format Stack, Element is NULL.')
      IF ~SELF.SWOpenFormatStack.Elements()
        DISPOSE(SELF.SWOpenFormatStack)
        SELF.SWOpenFormatStack &= NULL
      END
      AS = SELF.TagFromID(OFI.strFormat)
      SELF.DocEngine.WriteData('<</' & AS & '>')
      DISPOSE(OFI)
    END


HtmlDocumentClass.IDocumentCreateSerialToFile.PutOption    PROCEDURE(ASTRING strOptionName, STRING OptionValue)

AS      ASTRING

  CODE
    SELF.CloseFormat
    AS = SELF.TagFromID(strOptionName)
    IF AS
      SELF.DocEngine.WriteData(AS)
    ELSE
      SELF.DocEngine.WriteData(strOptionName)
    END
    IF LEN(OptionValue)
      SELF.DocEngine.WriteData(' = ' & OptionValue)
    END


HtmlDocumentClass.IDocumentCreateSerialToFile.PutData      PROCEDURE(STRING strData, BYTE bCRLF)

  CODE
    SELF.CloseFormat
    SELF.DocEngine.WriteData(strData)
    IF bCRLF
      SELF.DocEngine.WriteData('<13><10>')
    END


HtmlDocumentClass.IDocumentCreateSerialToFile.Release      PROCEDURE

  CODE


HtmlDocumentClass.IDocumentRead.ReadDocument               PROCEDURE

Reader          HtmlReader
szTagFName      CSTRING('Tags')
szDocFileName   CSTRING(256)

  CODE
    IF SELF.DocEngine.GetFileName(szDocFileName)
      Reader.Init(szTagFName, szDocFileName, SELF)
      Reader.Read
    ELSE
?     ASSERT(0, '<13><10>Cannot Read until Initialised. Call to ABDocEngine.Init Required.')
    END


HtmlDocumentClass.IDocumentRead.SetFile                    PROCEDURE(STRING strFileName)

  CODE
    RETURN SELF.DocEngine.SetFileName(strFileName)


HtmlDocumentClass.IDocumentRead.GetNextFormat              PROCEDURE(LONG dwLastID)

  CODE
    RETURN SELF.DocEngine.GetNextFormat(dwLastID)


HtmlDocumentClass.IDocumentRead.GetNextChildFormat         PROCEDURE(LONG dwParentID, LONG dwLastID)

  CODE
    RETURN SELF.DocEngine.GetNextChildFormat(dwParentID, dwLastID)


HtmlDocumentClass.IDocumentRead.GetFormatInfo              PROCEDURE(LONG dwID, ComponentGroup ComponentInfo)

  CODE
    RETURN SELF.DocEngine.GetFormatInfo(dwID, ComponentInfo)


HtmlDocumentClass.IDocumentRead.HasChildren                PROCEDURE(LONG dwID)

  CODE
    RETURN SELF.DocEngine.HasChildren(dwID)


!HtmlDocumentClass.IDocumentRead.GetOption             PROCEDURE(LONG dwID, ASTRING strOptionName)

!  CODE
!    RETURN SELF.DocEngine.GetOption(dwID, strOptionName)


HtmlDocumentClass.IDocumentRead.GetAttachment              PROCEDURE

  CODE
    RETURN 0


HtmlDocumentClass.IDocumentReadSerial.NextComponent        PROCEDURE

  CODE
    RETURN SELF.DocEngine.FetchNextComponent()


HtmlDocumentClass.IDocumentReadSerial.FetchComponentType   PROCEDURE

  CODE
    RETURN SELF.DocEngine.FetchComponentType()


HtmlDocumentClass.IDocumentReadSerial.FetchComponentLabel  PROCEDURE

  CODE
    RETURN SELF.DocEngine.FetchComponentLabel()


HtmlDocumentClass.IDocumentReadSerial.FetchComponentValue  PROCEDURE

  CODE
    RETURN SELF.DocEngine.FetchComponentValue()


HtmlDocumentClass.IDocumentReadSerial.Release              PROCEDURE

  CODE


! HtmlDocumentClass.IDocumentPosition impl.
! ==============================

HtmlDocumentClass.IDocumentPosition.SetSnap PROCEDURE(LONG SnapX, LONG SnapY)
  CODE

  SELF.LayoutEngine.SetSnap(SnapX, SnapY)


HtmlDocumentClass.IDocumentPosition.SetPos PROCEDURE(IDocIdType Id, LONG X, LONG Y, LONG W, LONG H)
  CODE

  SELF.IDocumentCreate.PutOption(Id, 'XPOS', X)
  SELF.IDocumentCreate.PutOption(Id, 'YPOS', Y)
  SELF.IDocumentCreate.PutOption(Id, 'WIDTH', W)
  SELF.IDocumentCreate.PutOption(Id, 'HEIGHT', H)


HtmlDocumentClass.IDocumentPosition.GetPos PROCEDURE(IDocIdType Id, *LONG X, *LONG Y, *LONG W, *LONG H)
  CODE

!  X=SELF.IDocumentRead.GetOption(Id, 'XPOS')
!  Y=SELF.IDocumentRead.GetOption(Id, 'YPOS')
!  W=SELF.IDocumentRead.GetOption(Id, 'WIDTH')
!  H=SELF.IDocumentRead.GetOption(Id, 'HEIGHT')

  RETURN True



