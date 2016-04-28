    MEMBER
INCLUDE('ABPRXML.INC'),ONCE
INCLUDE('ABERROR.INC'),ONCE
    PRAGMA('link(EXP_XML.ICO)')
    MAP
    END

XMLGenerator.CONSTRUCT               PROCEDURE()
 CODE
    SELF.QTag &= NEW(QueueTags)
    SELF.Output &= NEW(TargetGenerator)
    SELF.QHeaderAttribute &= NEW(QueueTagAttributes)

XMLGenerator.DESTRUCT                PROCEDURE()
 CODE
    FREE(SELF.QHeaderAttribute)
    DISPOSE(SELF.QHeaderAttribute)
    SELF.ChildDESTRUCT(SELF.QTag)
    DISPOSE(SELF.QTag)
    DISPOSE(SELF.Output)
    IF NOT SELF.ppScapedString &= NULL
       DISPOSE(SELF.ppScapedString)
    END


XMLGenerator.ChildDESTRUCT                PROCEDURE(QueueTags pQTag)
lIndex  LONG
 CODE
 LOOP lIndex=RECORDS(pQTag) TO 1 BY -1
      GET(pQTag,lIndex)
      IF NOT ERRORCODE() THEN
         IF NOT pQTag.Value &=NULL
            DISPOSE(pQTag.Value)
         END
         IF pQTag.TagType = TagType:Tag THEN
            SELF.ChildDESTRUCT(pQTag.Child)
            DISPOSE(pQTag.Child)
            FREE(pQTag.Attr)
            DISPOSE(pQTag.Attr)
         END
         DELETE(pQTag)
      END
 END

XMLGenerator.Init                    PROCEDURE(<STRING TargetFileName>)
 CODE
    SELF.PageOpen = False
    SELF.PageNo   = 0
    SELF.TotalPageNo   = 0
    IF OMITTED(2) THEN
       SELF.Output.Init()
    ELSE
       SELF.Output.Init(TargetFileName)
    END
    SELF.ChildDESTRUCT(SELF.QTag)
    SELF.SetPagesAsParentTag(False)
    SELF.SetPagesAsDifferentFile(False)
    SELF.SetForceXMLHeader(True)
    SELF.BasePageTagName = 'Page_'
    SELF.Encoding = ''
    FREE(SELF.QHeaderAttribute)
    SELF.Setup

XMLGenerator.SetFileName              PROCEDURE(STRING pFileName)
 CODE
    SELF.Output.SetOriginalFileName(pFileName)

XMLGenerator.SetUp                   PROCEDURE()
 CODE

XMLGenerator.SetRootTag              PROCEDURE(STRING pRootTag)
 CODE
    SELF.RootTag = SELF.MakeValidName(pRootTag)

XMLGenerator.OpenDocument            PROCEDURE(<STRING pDocumentName>)
 CODE
    SELF.PageNo = 0
    SELF.RootAdded = False
    SELF.RootAdded = False
    SELF.ChildDESTRUCT(SELF.Qtag)
    IF NOT OMITTED(2) THEN
       SELF.SetRootTag(pDocumentName)
    END
    IF SELF.PagesAsDifferentFile = False THEN
       SELF.Output.OpenFile()
    END

XMLGenerator.CloseDocument           PROCEDURE()
 CODE
    IF SELF.PagesAsDifferentFile = False THEN
       SELF.FlushPages()
       SELF.Output.CloseFile()
       SELF.Output.SetFileName('')
    END

XMLGenerator.StartPage               PROCEDURE()
lIndex  SHORT
 CODE
    SELF.PageNo+=1
    IF SELF.PagesAsDifferentFile = True THEN
       SELF.RootAdded = False
       SELF.ChildDESTRUCT(SELF.Qtag)
       !GENERATE FILE NAME
       SELF.Output.SetFileNameFromOriginal(SELF.PageNo,SELF.TotalPageNo)
       SELF.Output.OpenFile()
    ELSE
       IF SELF.PagesAsParentTag = True THEN
          SELF.AddTag(CLIP(SELF.BasePageTagName)&SELF.PageNo,'')
       END
    END
    SELF.PageOpen = True

XMLGenerator.EndPage                 PROCEDURE()
 CODE
    IF SELF.PagesAsDifferentFile = True THEN
       SELF.FlushPages()
       SELF.Output.CloseFile()
       SELF.Output.SetFileName('')
    END
    SELF.PageOpen = False
    
XMLGenerator.FlushPages              PROCEDURE()
lIndex  SHORT
 CODE
    IF NOT RECORDS(SELF.QTag) THEN
       RETURN
    END
    IF NOT CLIP(SELF.RootTag) THEN
       SELF.SetRootTag('Clarion_XML_Document')
    END
    SELF.RootAdded      = False
    SELF.XMLHeaderAdded = False
    SELF.PageTagAdded        = False
    SELF.FlushTags(1,SELF.QTag)
    IF SELF.PageTagAdded = True THEN
       SELF.PageTagAdded = False
       SELF.Output.WriteLine('</'&SELF.MakeValidName(CLIP(SELF.BasePageTagName)&SELF.PageNo)&'>')
    END
    IF SELF.RootAdded = True THEN
       SELF.RootAdded = False
       SELF.Output.WriteLine('</'&SELF.MakeValidName(CLIP(SELF.RootTag))&'>')
    END

XMLGenerator.MakeValidName           PROCEDURE(STRING pName)
lIndex  SHORT
 CODE
    LOOP lIndex=1 TO LEN(pName)
      CASE VAL(pName[lIndex])
      OF  VAL('.')
      OROF VAL('[')
      OROF VAL(']')
      OROF VAL(' ')
      OROF VAL('{{') 
      OROF VAL('}')
      OROF VAL('+')
      OROF VAL('=')
      OROF VAL('''') 
      OROF VAL('"')
      OROF VAL('!')
      OROF VAL('@')
      OROF VAL('#')
      OROF VAL('$')
      OROF VAL('%')
      OROF VAL('^')
      OROF VAL('&')
      OROF VAL('*')
      OROF VAL('(')
      OROF VAL(')')
      OROF VAL(';')
      OROF VAL(',')
      OROF VAL('<<')
      OROF VAL('>')
      OROF VAL('?')
      OROF VAL('/')
      OROF VAL('|')
      OROF VAL('\')
      OROF VAL('~')
      OROF VAL('`')
        pName[lIndex] = '_'
      OF VAL(':')
        IF NOT SELF.SupportNameSpaces
          pName[lIndex] = '_'
        END
      END
    END
    CASE VAL(pName[1])
    OF VAL(0) TO VAL(9)
      RETURN '_' & pName
     ELSE
        RETURN pName
     END

XMLGenerator.EscapeValues            PROCEDURE(STRING pValue)
CharToReplace   STRING(1)
ReplacedBy      STRING(10)
LenReplacedBy   SHORT
lIndex          SHORT
lLastIndex      SHORT

lSLen           SHORT
lOriginalSLen   SHORT
lReplaced       BYTE
SAux1           &STRING
SAux2           &STRING

 CODE

    SAux1 &= SELF.ppScapedString

    IF NOT SAux1 &= NULL
       DISPOSE(SAux1)
    END

    lSLen = LEN(pValue)
    lOriginalSLen = lSLen
    SAux1 &= NEW(STRING(lSLen+20))
    SAux1 = pValue

    CharToReplace= '&'
    ReplacedBy   = '&amp;'
    LenReplacedBy= 5
    Do ReplaceOneChar

    CharToReplace= '>'
    ReplacedBy   = '&gt;'
    LenReplacedBy= 4
    Do ReplaceOneChar

    CharToReplace= '<'
    ReplacedBy   = '&lt;'
    LenReplacedBy= 4
    Do ReplaceOneChar

    CharToReplace= ''''
    ReplacedBy   = '&apos;'
    LenReplacedBy= 6
    Do ReplaceOneChar

    CharToReplace= '"'
    ReplacedBy   = '&quot;'
    LenReplacedBy= 6
    Do ReplaceOneChar

    SELF.ppScapedString &= SAux1
    RETURN SAux1[1:lSLen]

ReplaceOneChar   ROUTINE
    lLastIndex = 1
    LOOP
       lIndex = INSTRING(CharToReplace,SAux1,1,lLastIndex)
       IF lIndex THEN
          lReplaced = True
          IF CharToReplace='&'
             IF lSLen-lIndex>=4
                IF SAux1[(lIndex):(lIndex+3)]='&gt;' OR SAux1[(lIndex):(lIndex+3)]='&lt;'
                   lReplaced = False
                   lLastIndex=lIndex+4
                END
             END
             IF lSLen-lIndex>=5
                IF SAux1[(lIndex):(lIndex+4)]='&amp;'
                   lReplaced = False
                   lLastIndex=lIndex+5
                END
             END
             IF lSLen-lIndex>=6
                IF SAux1[(lIndex):(lIndex+5)]='&apos;' OR SAux1[(lIndex):(lIndex+5)]='&quot;'
                   lReplaced = False
                   lLastIndex=lIndex+6
                END
             END
          END
          IF lReplaced
             IF (lSLen+LenReplacedBy)>(lOriginalSLen+20) THEN
                SAux2 &= NEW(STRING(lSLen+500))
                SAux2 = ''
                SAux2 = SAux1[1:lSLen]
                DISPOSE(SAux1)
                SAux1 = SAux2[1:lSLen]
                DISPOSE(SAux2)
             END
             SAux1 = SAux1[1:(lIndex-1)] & ReplacedBy[1:LenReplacedBy] & SAux1[(lIndex+1):(lSLen)]
             lSLen += LenReplacedBy
             lLastIndex=lIndex+LenReplacedBy
          END
       ELSE
          BREAK
       END
    END


XMLGenerator.FlushTags              PROCEDURE(SHORT pIndent,QueueTags pQTag)
lIndex  SHORT
lIndexAttr  SHORT
lIndexHAttr SHORT
lXMLVersionFound BYTE(0)
lXMLEncodingFound BYTE(0)
 CODE
    IF NOT RECORDS(pQTag) THEN
       RETURN
    END
    LOOP lIndex=1 to RECORDS(pQTag)
         GET(pQTag,lIndex)
         IF ERRORCODE() THEN BREAK.
         IF SELF.XMLHeaderAdded = False THEN
            SELF.XMLHeaderAdded = True
            IF NOT RECORDS(SELF.QHeaderAttribute) THEN
               IF SELF.ForceXMLHeader THEN
                  SELF.Output.WriteStr('<?xml version="'&CLIP(SELF.XMLVersion)&'"')
                  IF CLIP(SELF.Encoding)
                     SELF.Output.WriteStr(' encoding="'&CLIP(SELF.Encoding)&'"')
                  END
                  SELF.Output.WriteLine(' ?>')
               END
            ELSE
               SELF.Output.WriteStr('<?xml')
            END
            lXMLVersionFound = False
            lXMLEncodingFound = False
            !ADD XMLVersion
            LOOP lIndexHAttr = 1 to RECORDS(SELF.QHeaderAttribute)
                 GET(SELF.QHeaderAttribute,lIndexHAttr)
                 IF ERRORCODE() THEN BREAK.
                 IF CLIP(SELF.QHeaderAttribute.Name)='version' THEN
                    SELF.Output.WriteStr(' '&SELF.MakeValidName(CLIP(SELF.QHeaderAttribute.Name))&'="'&CLIP(SELF.QHeaderAttribute.Value)&'"')
                    lXMLVersionFound = True
                 END
                 IF CLIP(SELF.QHeaderAttribute.Name)='encoding' THEN
                    lXMLEncodingFound = True
                 END
            END
            IF RECORDS(SELF.QHeaderAttribute) THEN
               IF lXMLVersionFound = False THEN
                  SELF.Output.WriteStr(' '&'version="'&CLIP(SELF.XMLVersion)&'"')
               END
               IF lXMLEncodingFound = False AND CLIP(SELF.Encoding)
                  SELF.Output.WriteStr(' encoding="'&CLIP(SELF.Encoding)&'"')
               END
            END
            LOOP lIndexHAttr = 1 to RECORDS(SELF.QHeaderAttribute)
                 GET(SELF.QHeaderAttribute,lIndexHAttr)
                 IF ERRORCODE() THEN BREAK.
                 IF CLIP(SELF.QHeaderAttribute.Name)<>'version' THEN
                    SELF.Output.WriteStr(' '&SELF.MakeValidName(CLIP(SELF.QHeaderAttribute.Name))&'="'&CLIP(SELF.QHeaderAttribute.Value)&'"')
                 END
            END
            IF RECORDS(SELF.QHeaderAttribute) THEN
               SELF.Output.WriteLine(' ?>')
            END
            IF RECORDS(SELF.QHeaderAttribute) OR SELF.ForceXMLHeader THEN
               IF CLIP(SELF.XSL) OR SELF.UseXMLasXSLName
                  SELF.Output.WriteStr('<?xml-stylesheet type="text/xsl" href="')
                  IF SELF.UseXMLasXSLName
                     SELF.Output.WriteStr(SELF.Output.GetNameNoExt(SELF.Output.GetFileName())&'.XSL')
                  ELSE
                     SELF.Output.WriteStr(CLIP(SELF.XSL))
                  END
                  SELF.Output.WriteLine('" ?>')
               END
            END
         END
         IF SELF.RootAdded = False THEN
            SELF.RootAdded = True
            SELF.Output.WriteLine('<'&SELF.MakeValidName(CLIP(SELF.RootTag))&'>')
         END
         IF SELF.PagesAsDifferentFile = True THEN
            IF SELF.PagesAsParentTag = True THEN
               IF SELF.PageTagAdded = False THEN
                  SELF.PageTagAdded = True
                  SELF.Output.WriteLine('<'&SELF.MakeValidName(CLIP(SELF.BasePageTagName)&SELF.PageNo)&'>')
               END
            END
         END
         CASE pQTag.TagType
         OF TagType:Comment
            SELF.Output.WriteLine('<!-- '&CLIP(pQTag.Name)&' -->')
         OF TagType:Tag
                  SELF.Output.WriteStr(ALL(' ',pIndent)&'<'&SELF.MakeValidName(CLIP(pQTag.Name)))
                  LOOP lIndexAttr=1 TO RECORDS(pQTag.Attr)
                       GET(pQTag.Attr,lIndexAttr)
                       IF ERRORCODE() THEN BREAK.
                       SELF.Output.WriteStr(' '&SELF.MakeValidName(CLIP(pQTag.Attr.Name))&'="'&CLIP(pQTag.Attr.Value)&'"')
                  END
            IF RECORDS(pQTag.Child) OR CLIP(pQTag.Value) THEN
                  SELF.Output.WriteLine('>')
                  IF (CLIP(pQTag.Value)) THEN
                     IF pQTag.IsCData
                        SELF.Output.WriteStr('<![CDATA[')
                     END
                     IF pQTag.IsCData
                        SELF.Output.WriteStr(CLIP(pQTag.Value))
                     ELSE
                        SELF.Output.WriteLine(SELF.EscapeValues(CLIP(pQTag.Value)))
                     END
                     IF pQTag.IsCData
                        SELF.Output.WriteLine(']]>')
                     END
                  END
                  SELF.FlushTags(pIndent+1,pQTag.Child)
                  SELF.Output.WriteLine(ALL(' ',pIndent)&'</'&SELF.MakeValidName(CLIP(pQTag.Name))&'>')
            ELSE
                  SELF.Output.WriteLine('/>')
            END
         END
    END
    SELF.ChildDESTRUCT(pQtag)

XMLGenerator.SetSupportNameSpaces    PROCEDURE(BYTE pTrue=1)
 CODE
    SELF.SupportNameSpaces   = pTrue

XMLGenerator.SetForceXMLHeader       PROCEDURE(BYTE pTrue=1)
 CODE
    SELF.ForceXMLHeader   = pTrue

XMLGenerator.SetPagesAsParentTag     PROCEDURE(BYTE pTrue=1)
 CODE
    SELF.PagesAsParentTag = pTrue

XMLGenerator.SetPagesAsDifferentFile  PROCEDURE(BYTE pTrue=1)
 CODE
    SELF.PagesAsDifferentFile = pTrue

XMLGenerator.SetEncoding             PROCEDURE(STRING pEncoding)
 CODE
    SELF.Encoding = pEncoding

XMLGenerator.SetXSL                  PROCEDURE(STRING pXSLFileName)
 CODE
    SELF.XSL = pXSLFileName

XMLGenerator.SetUseXMLasXSLName          PROCEDURE(BYTE pValue)
 CODE
    SELF.UseXMLasXSLName = pValue

XMLGenerator.AddComment              PROCEDURE(STRING pComment)
 CODE
       SELF.QTag.Name     = pComment
       SELF.QTag.TagType  = TagType:Comment
       ADD(SELF.QTag)

XMLGenerator.AddXMLHeaderAttribute       PROCEDURE(STRING pName,STRING pValue)
lIndex  LONG
lFound  BYTE
 CODE
    lFound = False
    LOOP lIndex = 1 to RECORDS(SELF.QHeaderAttribute)
         GET(SELF.QHeaderAttribute,lIndex)
         IF ERRORCODE() THEN BREAK.
         IF SELF.QHeaderAttribute.Name = pName THEN
            lFound = True
            SELF.QHeaderAttribute.Value= pValue
            PUT(SELF.QHeaderAttribute)
         END
    END
    IF lFound = False
       SELF.QHeaderAttribute.Name = pName
       SELF.QHeaderAttribute.Value= pValue
       ADD(SELF.QHeaderAttribute)
    END

XMLGenerator.AddTag                  PROCEDURE(STRING pName,STRING pValue,BYTE pIsCData=0,<STRING pParent>)
lAdded  BYTE
 CODE
    IF OMITTED(5) OR CLIP(pParent)='' THEN
       IF SELF.PagesAsDifferentFile = False AND SELF.PagesAsParentTag = True THEN
          IF CLIP(pName)<>CLIP(CLIP(SELF.BasePageTagName)&SELF.PageNo) THEN
             SELF.AddTag(pName,pValue,pIsCData,CLIP(SELF.BasePageTagName)&SELF.PageNo)
          ELSE
             SELF.QTag.Name     = pName
             SELF.QTag.Value   &= NEW(STRING(LEN(pValue)))
             SELF.QTag.Value    = pValue
             SELF.QTag.IsCData  = pIsCData
             SELF.QTag.TagType  = TagType:Tag
             
             SELF.QTag.Attr    &= NEW(QueueTagAttributes)
             SELF.QTag.Child   &= NEW(QueueTags)
             ADD(SELF.QTag)
          END
       ELSE
          SELF.QTag.Name     = pName
          SELF.QTag.Value   &= NEW(STRING(LEN(pValue)))
          SELF.QTag.Value    = pValue
          SELF.QTag.IsCData  = pIsCData

          SELF.QTag.TagType  = TagType:Tag
          SELF.QTag.Attr    &= NEW(QueueTagAttributes)
          SELF.QTag.Child   &= NEW(QueueTags)
          ADD(SELF.QTag)
       END
    ELSE
       IF RECORDS(SELF.QTag) THEN
          lAdded = SELF.AddTagToParent(SELF.QTag,pName,pValue,pIsCData,pParent)
          ASSERT(lAdded,'Parent tag not found ParentTag('&pParent&') TagName('&pName&')')
       END
    END
XMLGenerator.AddTagToParent    PROCEDURE(QueueTags pQTag,STRING pName,STRING pValue,BYTE pIsCData=0,STRING pParent)
lIndex  LONG
lAdded  BYTE
 CODE
 lAdded = False
 LOOP lIndex=RECORDS(pQTag) TO 1 BY -1
      GET(pQTag,lIndex)
      IF NOT ERRORCODE() THEN
         IF pQTag.TagType = TagType:Tag THEN
            lAdded = SELF.AddTagToParent(pQTag.Child,pName,pValue,pIsCData,pParent)
            IF lAdded=True THEN
               BREAK
            ELSE
               IF CLIP(UPPER(pQTag.Name))=CLIP(UPPER(pParent))
                  lAdded = True
                  pQTag.Child.Name     = pName
                  pQTag.Child.Value    &= NEW(STRING(LEN(pValue)))
                  pQTag.Child.Value    = pValue
                  pQTag.Child.IsCData  = pIsCData
                  pQTag.Child.TagType  = TagType:Tag
                  pQTag.Child.Attr    &= NEW(QueueTagAttributes)
                  pQTag.Child.Child   &= NEW(QueueTags)
                  ADD(pQTag.Child)
                  BREAK
               END
            END
         END
      END
 END
 RETURN lAdded
XMLGenerator.SetTagValue             PROCEDURE(STRING pTagName,STRING pValue,BYTE pIsCData=0)
lAdded  BYTE
 CODE
     IF RECORDS(SELF.QTag) THEN
        lAdded = SELF.SetTagValueToParent(SELF.QTag,pTagName,pValue,pIsCData)
     END
XMLGenerator.SetTagValueToParent     PROCEDURE(QueueTags pQTag,STRING pTagName,STRING pValue,BYTE pIsCData=0)
lIndex  LONG
lAdded  BYTE
 CODE
 lAdded = False
 LOOP lIndex=RECORDS(pQTag) TO 1 BY -1
      GET(pQTag,lIndex)
      IF NOT ERRORCODE() THEN
         IF pQTag.TagType = TagType:Tag THEN
            lAdded = SELF.SetTagValueToParent(pQTag.Child,pTagName,pValue,pIsCData)
            IF lAdded=True THEN
               BREAK
            ELSE
               IF CLIP(UPPER(pQTag.Name))=CLIP(UPPER(pTagName))
                  lAdded = True
                  IF NOT pQTag.Value &= NULL THEN
                     DISPOSE(pQTag.Value)
                  END
                  pQTag.Value &= NEW(STRING(LEN(pValue)))
                  pQTag.Value  = pValue
                  pQTag.IsCData= pIsCData
                  PUT(pQTag)
                  BREAK
               END
            END
         END
      END
 END
 RETURN lAdded
XMLGenerator.AddAttribute            PROCEDURE(STRING pName,STRING pValue,STRING pTagName)
 CODE
     IF RECORDS(SELF.QTag) THEN
        SELF.AddAttributeToParent(SELF.QTag,pName,pValue,pTagName)
     END
XMLGenerator.AddAttributeToParent    PROCEDURE(QueueTags pQTag,STRING pName,STRING pValue,STRING pTagName)
lIndex  LONG
lAdded  BYTE
 CODE
 lAdded = False
 LOOP lIndex=RECORDS(pQTag) TO 1 BY -1
      GET(pQTag,lIndex)
      IF NOT ERRORCODE() THEN
         IF pQTag.TagType = TagType:Tag THEN
            lAdded = SELF.AddAttributeToParent(pQTag.Child,pName,pValue,pTagName)
            IF lAdded=True THEN
               BREAK
            ELSE
               IF CLIP(UPPER(pQTag.Name))=CLIP(UPPER(pTagName))
                  lAdded = True
                  pQTag.Attr.Name = pName
                  pQTag.Attr.Value= pValue
                  ADD(pQTag.Attr)
                  BREAK
               END
            END
         END
      END
 END
 RETURN lAdded

XMLReportGenerator.CONSTRUCT            PROCEDURE()
 CODE
    SELF.Attribute  &=NEW ReportAttributeManager
    SELF.ProcessedTag  &= NEW(QueueProcessedTags)
    SORT(SELF.ProcessedTag,SELF.ProcessedTag.FEQ)
    SELF.XMLVersion='1.0'

XMLReportGenerator.DESTRUCT                             PROCEDURE()
 CODE
    FREE(SELF.ProcessedTag)
    DISPOSE(SELF.ProcessedTag)
    DISPOSE(SELF.Attribute)

XMLReportGenerator.IReportGenerator.Init                PROCEDURE(<ErrorClass EC>)
  CODE
XMLReportGenerator.IReportGenerator.ProcessBand         PROCEDURE(STRING type, BYTE start)
  CODE
    !NOT SUPPORTED
XMLReportGenerator.IReportGenerator.OpenDocument        PROCEDURE(UNSIGNED TotalPages)
 CODE
     SELF.OpenDocument()
     SELF.TotalPageNo = TotalPages
     RETURN Level:Benign
XMLReportGenerator.IReportGenerator.CloseDocument       PROCEDURE()
 CODE
     IF SELF.PagesAsDifferentFile = False THEN
        IF NOT SELF.OutputFileQueue &= NULL THEN
           SELF.OutputFileQueue.FileName = SELF.Output.GetFileName()
           ADD(SELF.OutputFileQueue)
        END
     END
     SELF.CloseDocument()
     RETURN Level:Benign
XMLReportGenerator.IReportGenerator.OpenPage            PROCEDURE(SHORT pBoxLeft,SHORT pBoxTop,SHORT pBoxRight,SHORT pBoxBottom)
 CODE
     SELF.StartPage()
     RETURN Level:Benign
XMLReportGenerator.IReportGenerator.ClosePage           PROCEDURE()
 CODE
     IF SELF.PagesAsDifferentFile = True THEN
        IF NOT SELF.OutputFileQueue &= NULL THEN
           SELF.OutputFileQueue.FileName = SELF.Output.GetFileName()
           ADD(SELF.OutputFileQueue)
        END
     END
     SELF.EndPage()
     RETURN Level:Benign

XMLReportGenerator.IReportGenerator.AskProperties       PROCEDURE(BYTE Force=0)
ReturnValue BYTE
LOC:FileName    STRING(143)
 CODE
     ReturnValue = Level:Benign
     SELF.Init()
     IF NOT CLIP(SELF.Output.GetFileName()) OR Force THEN
        LOC:FileName = ''
        IF NOT FILEDIALOG('Save as XML File',LOC:FileName,'XML|*.XML|Text|*.TXT|All|*.*',FILE:LongName+FILE:Save+FILE:KeepDir) THEN
           ReturnValue = Level:Notify
        ELSE
           IF NOT INSTRING('.',LOC:FileName) THEN
              LOC:FileName=CLIP(LOC:FileName)&'.XML'
           END
           SELF.Output.SetOriginalFileName(LOC:FileName)
        END
     END
     RETURN ReturnValue
XMLReportGenerator.IReportGenerator.WhoAmI              PROCEDURE()
 CODE
     RETURN RepGen:XML

XMLReportGenerator.IReportGenerator.DisplayIcon         PROCEDURE()
 CODE
     RETURN '~EXP_XML.ICO'

XMLReportGenerator.IReportGenerator.DisplayName         PROCEDURE()
 CODE
     RETURN 'XML'

XMLReportGenerator.IReportGenerator.ProcessString         PROCEDURE(*StringFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lName    STRING(MaxXMLGeneratorNameLen)
lValue   STRING(MaxXMLGeneratorValueLen)
lParent  STRING(MaxXMLGeneratorNameLen)
lTagType BYTE
lFEQ     USHORT
lNameFromText  BYTE
lValueFromText BYTE
lIsCData       BYTE
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:XML,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    lFEQ = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagProcessOnce,pExtendControlAttr)

    IF lFEQ THEN
       SELF.ProcessedTag.FEQ = lFEQ
       GET(SELF.ProcessedTag,SELF.ProcessedTag.FEQ)
       IF NOT ERRORCODE() THEN
          IF SELF.ProcessedTag.FEQ = lFEQ THEN
             RETURN
          END
       ELSE
          SELF.ProcessedTag.FEQ = lFEQ
          ADD(SELF.ProcessedTag)
       END
    END
    
    lTagType       = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagType,pExtendControlAttr)
    lNameFromText  = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagNameFromText,pExtendControlAttr)
    lValueFromText = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagValueFromText,pExtendControlAttr)
    lIsCData       = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagIsCData,pExtendControlAttr)

    CASE lTagType
    OF TagType:Tag
       IF lNameFromText THEN
          lName = Text
       ELSE
          lName = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagName,pExtendControlAttr)
       END
       IF lValueFromText THEN
          lValue = Text
       ELSE
          lValue = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagValue,pExtendControlAttr)
       END
       lParent= SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagParentName,pExtendControlAttr)
       IF NOT CLIP(lValue)
          lIsCData = False
       END
       SELF.AddTag(CLIP(lName),CLIP(lValue),lIsCData,CLIP(lParent))
    OF TagType:TagValue
       lParent= SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagParentName,pExtendControlAttr)
       IF CLIP(lParent) THEN
          SELF.SetTagValue(CLIP(lParent),Text,lIsCData)
       END
    OF TagType:TagAttribute
       IF lNameFromText THEN
          lName = Text
       ELSE
          lName = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagName,pExtendControlAttr)
       END
       IF lValueFromText THEN
          lValue = Text
       ELSE
          lValue = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagValue,pExtendControlAttr)
       END
       lParent= SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagParentName,pExtendControlAttr)
       IF lParent THEN
          SELF.AddAttribute(CLIP(lName),CLIP(lValue),CLIP(lParent))
       END
    OF TagType:HeaderAttribute
       IF lNameFromText THEN
          lName = Text
       ELSE
          lName = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagName,pExtendControlAttr)
       END
       IF lValueFromText THEN
          lValue = Text
       ELSE
          lValue = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagValue,pExtendControlAttr)
       END
       SELF.AddXMLHeaderAttribute(lName,lValue)
    OF TagType:Comment
       IF lValueFromText THEN
          lValue = Text
       ELSE
          lValue = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagValue,pExtendControlAttr)
       END
       SELF.AddComment(lValue)
    ELSE
       !IS not a valid TagType
    END

XMLReportGenerator.IReportGenerator.ProcessLine        PROCEDURE(*LineFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED
XMLReportGenerator.IReportGenerator.ProcessEllipse     PROCEDURE(*EllipseFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessArc      PROCEDURE(*ArcFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessChord      PROCEDURE(*ChordFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessRectangle   PROCEDURE(*RectFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessImage       PROCEDURE(*ImageFormatGrp pFormatGrp, STRING iName, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessCheck       PROCEDURE(*CheckFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
 CODE
    SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, Text,pExtendControlAttr)

XMLReportGenerator.IReportGenerator.ProcessRadio       PROCEDURE(*RadioFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED
XMLReportGenerator.IReportGenerator.ProcessPie          PROCEDURE(SliceFormatQueue pSliceFormatQueue, *PosGrp pPosGroup, STRING pExtendControlAttr)
 CODE
    !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessPolygon  PROCEDURE(PointQueue pPointQueue, *StyleGrp pStyleGrp, STRING pExtendControlAttr)
  CODE
  !NOT SUPPORTED

XMLReportGenerator.IReportGenerator.ProcessGroup        PROCEDURE(*GroupFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
 CODE
    SELF.IReportGenerator.ProcessString(pFormatGrp.header, Text,pExtendControlAttr)

XMLReportGenerator.IReportGenerator.ProcessText     PROCEDURE(TextFormatQueue TextFormatQ, STRING pExtendControlAttr)
lIndex      USHORT
lName       STRING(MaxXMLGeneratorNameLen)
lValue      &STRING 
lParent     STRING(MaxXMLGeneratorNameLen)
lTagType    BYTE
  CODE
    IF NOT RECORDS(TextFormatQ)
?      ASSERT(False,'The text control has no text. '&pExtendControlAttr)
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:XML,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    lValue&=NEW(STRING(SIZE(TextFormatQ.Text)*RECORDS(TextFormatQ)))
    lValue = ''

    lTagType = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagType,pExtendControlAttr)
    CASE lTagType
    OF TagType:Tag          
       lName = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagName,pExtendControlAttr)
       IF NOT CLIP(lName) THEN
          RETURN
       END
       lParent= SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagParentName,pExtendControlAttr)
       LOOP lIndex = 1 TO RECORDS(TextFormatQ)
         GET(TextFormatQ, lIndex)
         lValue = CLIP(lValue)&CLIP(TextFormatQ.Text)&'<13,10>'
       END
       SELF.AddTag(CLIP(lName),CLIP(lValue),True,CLIP(lParent))
    OF TagType:TagAttribute
       LOOP lIndex = 1 TO RECORDS(TextFormatQ)
         GET(TextFormatQ, lIndex)
         lValue = CLIP(lValue)&CLIP(TextFormatQ.Text)
       END
       lName = SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagName,pExtendControlAttr)
       IF NOT CLIP(lName) THEN
          RETURN
       END
       lParent= SELF.Attribute.Extract(RepGen:XML,TargetAttr:TagParentName,pExtendControlAttr)
       IF lParent THEN
          SELF.AddAttribute(CLIP(lName),CLIP(lValue),CLIP(lParent))
       END
    OF TagType:Comment
       LOOP lIndex = 1 TO RECORDS(TextFormatQ)
         GET(TextFormatQ, lIndex)
         SELF.AddComment(TextFormatQ.Text)
       END  
    ELSE
       !IS not a valid TagType
?      ASSERT(False,'Not a valid tag type on the Text control. '&pExtendControlAttr)
    END
    DISPOSE(lValue)

XMLReportGenerator.IReportGenerator.SetResultQueue      PROCEDURE(OutputFileQueue pOutputFile)
 CODE
    SELF.OutputFileQueue &= pOutputFile
    FREE(SELF.OutputFileQueue)

XMLReportGenerator.IReportGenerator.SupportResultQueue  PROCEDURE()
 CODE
 RETURN True
