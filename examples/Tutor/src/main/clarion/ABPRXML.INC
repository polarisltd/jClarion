!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_XMLReportGeneratorPresent_)
_XMLReportGeneratorPresent_ EQUATE(1)

 INCLUDE('ABPRTARG.INC'),ONCE   ! TargetClass
 INCLUDE('ABRPATMG.INC'),ONCE   ! Attr Manager
 INCLUDE('ABRPTGEN.INT'),ONCE   ! IReportGenerator Interface
 INCLUDE('ABERROR.INC'),ONCE
MaxXMLGeneratorNameLen  EQUATE(500)
MaxXMLGeneratorValueLen EQUATE(500)
QueueTagAttributes   QUEUE,TYPE
Name                    STRING(MaxXMLGeneratorNameLen)
Value                   STRING(MaxXMLGeneratorValueLen)
                     END

TagType:Tag             EQUATE(1)  !<   />  OR <   >  </   >
TagType:HeaderAttribute EQUATE(2)  !<?  ?>
TagType:Comment         EQUATE(3)  !<!--   -->
TagType:TagAttribute    EQUATE(4)  !INTERNAL USE
TagType:TagValue        EQUATE(5)  !INTERNAL USE

QueueXMLComments     QUEUE,TYPE
Value                   STRING(MaxXMLGeneratorValueLen)
                     END
QueueTags            QUEUE,TYPE
Name                    STRING(MaxXMLGeneratorNameLen)
Value                   &STRING !STRING(MaxXMLGeneratorValueLen)
TagType                 BYTE !TagType:Tag , TagType:HtmlComment OR TagType:XMLComment
Attr                    &QueueTagAttributes
Child                   &QueueTags
IsCData                 BYTE
                     END
QueueProcessedTags   QUEUE,TYPE
FEQ                     USHORT
                     END
XMLGenerator    CLASS(),MODULE('ABPRXML.CLW'),TYPE,LINK('ABPRXML.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Output                  &TargetGenerator
QTag                    &QueueTags
QHeaderAttribute        &QueueTagAttributes
RootTag                 STRING(MaxXMLGeneratorNameLen)
Encoding                STRING(MaxXMLGeneratorValueLen)
XSL                     STRING(MaxXMLGeneratorValueLen)
PagesAsDifferentFile    BYTE,PRIVATE
PagesAsParentTag        BYTE,PRIVATE
SupportNameSpaces       BYTE,PRIVATE
ForceXMLHeader          BYTE,PRIVATE
BasePageTagName         STRING(15)
PageNo                  SHORT(0),PROTECTED
TotalPageNo             SHORT(0),PROTECTED
PageOpen                BYTE,PRIVATE
RootAdded               BYTE,PRIVATE
XMLHeaderAdded          BYTE,PRIVATE
XMLVersion              STRING(5)
PageTagAdded            BYTE,PROTECTED
ppScapedString          &STRING
UseXMLasXSLName         BYTE,PROTECTED
Init                    PROCEDURE(<STRING TargetFileName>),VIRTUAL
Setup                   PROCEDURE(),VIRTUAL
SetFileName             PROCEDURE(STRING pFileName)
SetPagesAsParentTag     PROCEDURE(BYTE pTrue=1)
SetPagesAsDifferentFile PROCEDURE(BYTE pTrue=1)
SetForceXMLHeader       PROCEDURE(BYTE pTrue=1)
SetSupportNameSpaces    PROCEDURE(BYTE pTrue=1)
SetRootTag              PROCEDURE(STRING pRootTag)
SetEncoding             PROCEDURE(STRING pEncoding)
SetXSL                  PROCEDURE(STRING pXSLFileName)
SetUseXMLasXSLName      PROCEDURE(BYTE pValue)
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
ChildDESTRUCT           PROCEDURE(QueueTags pQTag)
AddXMLHeaderAttribute   PROCEDURE(STRING pName,STRING pValue)
AddComment              PROCEDURE(STRING pComment)
AddTag                  PROCEDURE(STRING pName,STRING pValue,BYTE pIsCData=0,<STRING pParent>)
SetTagValue             PROCEDURE(STRING pTagName,STRING pValue,BYTE pIsCData=0)
SetTagValueToParent     PROCEDURE(QueueTags pQTag,STRING pTagName,STRING pValue,BYTE pIsCData=0),BYTE,PRIVATE
AddTagToParent          PROCEDURE(QueueTags pQTag,STRING pName,STRING pValue,BYTE pIsCData=0,STRING pParent),BYTE,PRIVATE
AddAttribute            PROCEDURE(STRING pName,STRING pValue,STRING pTagName)
AddAttributeToParent    PROCEDURE(QueueTags pQTag,STRING pName,STRING pValue,STRING pTagName),BYTE,PROC,PRIVATE
OpenDocument            PROCEDURE(<STRING pDocumentName>)
CloseDocument           PROCEDURE()
StartPage               PROCEDURE()
EndPage                 PROCEDURE()
FlushPages              PROCEDURE(),PROTECTED
FlushTags               PROCEDURE(SHORT pIndent,QueueTags pQTag),PROTECTED
MakeValidName           PROCEDURE(STRING pName),STRING,PRIVATE
EscapeValues            PROCEDURE(STRING pValue),STRING,PRIVATE
                      END

XMLReportGenerator    CLASS(XMLGenerator),IMPLEMENTS(IReportGenerator),MODULE('ABPRXML.CLW'),TYPE,LINK('ABPRXML.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ProcessedTag            &QueueProcessedTags,PROTECTED
OutputFileQueue         &OutputFileQueue,PROTECTED
Attribute               &ReportAttributeManager,PROTECTED
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
                      END

 _EndOfInclude_
