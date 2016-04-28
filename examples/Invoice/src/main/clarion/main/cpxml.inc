! $Header: /0192-7/XMLSupport/src/cpxml.inc 48    8/05/03 12:50p Mal $
!****************************************************************************
!  FILE..........: cpxml.inc
!  DESCRIPTION...: 
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-03-07 Modifyed by Anatoly Medyntsev [MAL]
!                  YYYY-MM-DD Description of changes
!****************************************************************************
  OMIT('_EndOfInclude_',_cpXMLPresent_)
_cpXMLPresent_   EQUATE(1)
  PRAGMA('link(C%V%cpxml.lib)')
!****Types declarations 
cint                    EQUATE(SIGNED)
cbool                   EQUATE(BYTE)
DOMQueue                QUEUE, TYPE
node                      &Node
level                     SIGNED
                        end
!****Max length of mapped names
MAX_NAME_LEN            EQUATE(256)
MAX_FORMAT_LEN          EQUATE(65) 

!****symbol definitions have been moved from .prj
!_XMLLibLinkMode_    EQUATE(true)
!_XMLLibDllMode_     EQUATE(false)
!Styles of generated DOM Document object
DOMStyle                EQUATE(UNSIGNED)
                        itemize, pre(DOMStyle)
ADO_26                    EQUATE(0)
ADO_NET                   EQUATE
                        end

!****Error codes returned by GetLastError function
                itemize,pre(CPXMLErr)
NoError             EQUATE(0)
XMLReadFail         EQUATE
XMLWriteFail        EQUATE
DuplicateName       EQUATE
IllegalName         EQUATE
CreateDOMFail       EQUATE
EOF                 EQUATE
InvalidArgument     EQUATE
IllegalFunctionCall EQUATE
NotSupported        EQUATE
InternalError       EQUATE
FieldNotFound       EQUATE
CommonError         EQUATE
IllegalParameter    EQUATE
ImportFail          EQUATE
NotSuccessful       EQUATE
IllegalFormat       EQUATE
IllegalType         EQUATE
IllegalSize         EQUATE
NoSuchField         EQUATE
EOS                 EQUATE
SchemaNotSupported  EQUATE
InconsistentSchema  EQUATE
CheckFail           EQUATE
AddRecordFailed     EQUATE
InvalidNodeName     EQUATE
NoCurrentNode       EQUATE
CDataNotSupported   EQUATE
Base64NotSupported  EQUATE
                end

XMLFieldFormat      EQUATE(UNSIGNED)
                  ITEMIZE, PRE(XMLFieldFormat)
Text                EQUATE(0)
Base64              EQUATE
CData               EQUATE
                  END

!===QUEUE to provide mapping name information
MapQueue        QUEUE,TYPE
ClarionName     CSTRING(MAX_NAME_LEN) !Name of Clarion's field           
XMLName         CSTRING(MAX_NAME_LEN) !Name of the corresponding XML tag/attribute
Picture         CSTRING(MAX_FORMAT_LEN)           
Format          XMLFieldFormat
            end

MappingQueue    QUEUE,TYPE
label           CSTRING(256)
use             ANY
column          CSTRING(256)
picture         CSTRING(256)
index           UNSIGNED
fldType         UNSIGNED
fldSize         UNSIGNED
fldInfo         UNSIGNED
                END

!== dummy group to pass any group as parameter
!****not used now
GroupType       GROUP,TYPE
                end
  map
    module('')
!===  DOM  ======
CreateDOMImplementation     PROCEDURE, *DOMImplementation, name('_CreateDOMImplementation@0'), pascal, raw
DestroyDOMImplementation    PROCEDURE(*DOMImplementation pDOMImplementation), name('_DestroyDOMImplementation@4'), pascal, raw
CreateDocumentFromFile      PROCEDURE(const *CSTRING uri), *Document, name('_CreateDocument@4'), pascal, raw
CreateDocumentFromXML       PROCEDURE(const *CSTRING xml), *Document, name('_CreateDocument2@4'), pascal, raw
CreateDOMWriter             PROCEDURE, *DOMWriter, name('_CreateDOMWriter@0'), pascal, raw
DestroyDOMWriter            PROCEDURE(*DOMWriter pDOMWriter), name('_DestroyDOMWriter@4'), pascal, raw
!===  SAX  ======
XMLStringToSAX              PROCEDURE(const *CSTRING xml, *ISAXCallback saxcallback), BYTE, proc, name('_XMLStringToSAX@8'), pascal, raw
XMLFileToSAX                PROCEDURE(const *CSTRING path, *ISAXCallback saxcallback), BYTE, proc, name('_XMLFileToSAX@8'), pascal, raw
    end
    module('cpXML.clw')
!for inner use
toDOM:AppendCol procedure(*XMLExchange exch, *Document doc, *Element rowE, StructWrapper sw, signed col, DOMStyle style),byte
toDOM:getTableLabel procedure(DOMStyle style), *cstring
toDOM:getRowLabel procedure(DOMStyle style), *cstring
checkXMLName PROCEDURE(STRING xmlName), byte         
getFirstChildElem   PROCEDURE(*Node nd),*Node
getNextSiblingElem  PROCEDURE(*Node nd),*Node   
!===  Translations  ======
!***Translation from XML string to XML DOM Document object
!***Parameters:
!xml - string with XML content
!return: pointer to XML DOM Document object
XMLStringToDOM              PROCEDURE(string xml), *Document, dll(_XMLLibDllMode_)
!***Translation from XML DOM Document object to XML string
!**doc - pointer to XML DOM Document object
!**Format - can be AS_IS, CANONICAL, REFOMATTED
!**return - string with XML content
DOMToXMLString              PROCEDURE(*Document doc, <*CSTRING newLine>, UNSIGNED Format = 1), string, dll(_XMLLibDllMode_)
!***Translate an XML file to XML DOM Document object
!**path - path to a XML file
!**return: pointer to XML DOM Document object
XMLFileToDOM                PROCEDURE(string path), *Document, dll(_XMLLibDllMode_)
!***Translate a XML DOM Document object to a XML file
!**doc - pointer to XML DOM Document object
!**path - path to a file to store result
!**return: true - if successful; false - otherwise
DOMToXMLFile                PROCEDURE(*Document doc, string path, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE, dll(_XMLLibDllMode_)
!====Translation functions for different structure
!***XXXToDom******
!***q,f,v or gr parameter - pointer to the structure (QUEUE, FILE, VIEW or GROUP)
!****** to translate
!**label - specify tag name that is used for a row of data
!**style - specify tag-based (DOMStyle:ADO_NET) or attribute-based (DOMStyle:ADO_26)
!****style is used
!**maxRowCount - maximum number of rows to be exported
!**removePrefix - specify if field name prefix should be removed
!**nameMap - QUEUE with pairs <ClarionName,XMLName> to substitute field name 
!*** in export operation
!**return: pointer to XML DOM Document object

!***DomToXXX******
!**doc - pointer to XML DOM Document object
!***q,f,v or gr parameter - pointer to the structure (QUEUE, FILE, VIEW or GROUP)
!****** to translate
!**label - specify tag name that is used for a row of data
!**style - specify tag-based (DOMStyle:ADO_NET) or attribute-based (DOMStyle:ADO_26)
!****style is used
!**nameMap - QUEUE with pairs <ClarionName,XMLName> to substitute field name 
!*** in import operation
!**return: true - if successful; false - otherwise

!***Translate QUEUE structure to XML DOM Document object
QueueToDOM                  PROCEDURE(*QUEUE q, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26, BYTE removePrefix = true,<MapQueue nameMap>), *Document, dll(_XMLLibDllMode_)
!***Translate XML DOM Document object to QUEUE structure
DOMToQueue                  PROCEDURE(*Document doc, *QUEUE q, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26,<MapQueue nameMap>),BYTE, dll(_XMLLibDllMode_)
!***Translate FILE structure to DOM Document
FileToDOM                   PROCEDURE(*file f, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26, BYTE removePrefix = true,<MapQueue nameMap>), *Document, dll(_XMLLibDllMode_)
!***Translate DOM Document to FILE structure
DOMToFile                   PROCEDURE(*Document doc, *file f, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26,<MapQueue nameMap>),BYTE, dll(_XMLLibDllMode_)
!***Translate VIEW structure to DOM Document
ViewToDOM                   PROCEDURE(*VIEW v, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26, BYTE removePrefix = true,<MapQueue nameMap>,UNSIGNED maxRowCount = 0), *Document, dll(_XMLLibDllMode_)
!==Group support
!***Translate GROUP structure to DOM Doument
GroupToDOM             PROCEDURE(*GROUP gr, <string root>,<string label>,DOMStyle style=DOMStyle:ADO_26,BYTE removePrefix = true, <MapQueue nameMap>), *Document, dll(_XMLLibDllMode_)
!***Translate DOM Document to GROUP structure
DOMToGroup             PROCEDURE(*Document doc, *GROUP gr, <string root>,<string label>,DOMStyle style=DOMStyle:ADO_26, <MapQueue nameMap>),BYTE, dll(_XMLLibDllMode_)

!****Wrapper functions
!***Translate QUEUE,FILE,VIEW,GROUP structures to XML file
!***que,fl,vw or gr parameter - pointer to the structure (QUEUE, FILE, VIEW or GROUP)
!****** to translate
!***path - path of a file
!**nameMap - QUEUE with pairs <ClarionName,XMLName> to substitute field name 
!**style - specify tag-based (DOMStyle:ADO_NET) or attribute-based (DOMStyle:ADO_26)
!****style is used
!***return: true - if successful; false - otherwise
ToXMLFile             PROCEDURE(*file fl, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE, dll(_XMLLibDllMode_)
ToXMLFile             PROCEDURE(*QUEUE que, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE, dll(_XMLLibDllMode_)
ToXMLFile             PROCEDURE(*VIEW vw, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE, dll(_XMLLibDllMode_)
ToXMLFile             PROCEDURE(*GROUP gr, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE, dll(_XMLLibDllMode_)

MapQueueToXMLFile     PROCEDURE(*MapQueue map, string path, string root, string label, <*CSTRING newLine>, UNSIGNED Format = 1),byte

!****Translate XML file to QUEUE,FILE or GROUP structures
!***que,fl or gr parameter - pointer to the structure (QUEUE, FILE or GROUP)
!****** to import
!***path - path of a file
!**nameMap - QUEUE with pairs <ClarionName,XMLName> to substitute field name 
!**style - specify tag-based (DOMStyle:ADO_NET) or attribute-based (DOMStyle:ADO_26)
!****style is used
!***return: true - if successful; false - otherwise

FromXMLFile           PROCEDURE(*file fl, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26),BYTE, dll(_XMLLibDllMode_)
FromXMLFile           PROCEDURE(*QUEUE que, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26),BYTE, dll(_XMLLibDllMode_)
FromXMLFile           PROCEDURE(*GROUP gr, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26),BYTE, dll(_XMLLibDllMode_)

XMLFileToMapQueue     PROCEDURE(string path, *MapQueue map, *string root, *string label),byte

!===  Editing  ======
AppendElement               PROCEDURE(*Document doc, *Node parent, string ELabel), *Element, proc
AppendElementAndText        PROCEDURE(*Document doc, *Node parent, string ELabel, string TData, BYTE base64=false), *Element, proc
AppendElementAndAttribute   PROCEDURE(*Document doc, *Node parent, string ELabel, string attribute, string value), *Element, proc
!===  Helpers  ======
GetElementText              PROCEDURE(*Element e, BYTE asis=false), string, dll(_XMLLibDllMode_)
SetElementText              PROCEDURE(*Element e, string text, BYTE asis=false), dll(_XMLLibDllMode_)
GetFirstElementByTagName    PROCEDURE(*Node root, string name), *Element, dll(_XMLLibDllMode_)
FillDOMQueue                PROCEDURE(*Node root, DOMQueue q, UNSIGNED startLevel=1), dll(_XMLLibDllMode_)
!===  Debug  ======
ViewXML                     PROCEDURE(*Node n), dll(_XMLLibDllMode_)
ViewXML                     PROCEDURE(string xml), dll(_XMLLibDllMode_)
!===  Misc  ======
ToBase64                    PROCEDURE(string in), string
FromBase64                  PROCEDURE(string in), string
!***Error global variable accessing functions
GetLastError                PROCEDURE ,long
SetLastError                PROCEDURE(long errno)
    end
  end

e:XsiType CSTRING('xsi:TYPE'), static
e:Base64 CSTRING('SOAP-ENC:base64'), static

!===  LINK  ========
!LinkCpXML               class, link('cpXML.lib', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
!                        end
!===  CString  ========
CStringClass            class, module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
cs                        &CSTRING, protected

construct                 PROCEDURE
destruct                  PROCEDURE, virtual
str                       PROCEDURE(string s), *CSTRING, proc
str                       PROCEDURE, *CSTRING
cat                       PROCEDURE(string s)
                        end
!===  ReflectionClass  ========
!***The base class is used for import/export operation 
ReflectionClass         class, module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
label                     CSTRING(256), protected
prefix                    CSTRING(256), protected
!Fields - contains fields names and reference to the fields
Fields                    &MappingQueue, protected  

construct                 PROCEDURE
destruct                  PROCEDURE, virtual
kill                      PROCEDURE
getPrefix                 PROCEDURE, string
getLabel                  PROCEDURE, string
getFieldCount             PROCEDURE, UNSIGNED

getFieldLabel             PROCEDURE(UNSIGNED row), string
setFieldValue             PROCEDURE(UNSIGNED row, string value)
getFieldValue             PROCEDURE(UNSIGNED row), string
setFieldColumnLabel       PROCEDURE(UNSIGNED row, string ColumnLabel)
getFieldColumnLabel       PROCEDURE(UNSIGNED row), string
setFieldPicture           PROCEDURE(UNSIGNED row, string ColumnLabel)
getFieldPicture           PROCEDURE(UNSIGNED row), string
!***Set a field value
setValue                  PROCEDURE(string field, string value)
!***Get a field value
getValue                  PROCEDURE(string field), string
setColumnLabel            PROCEDURE(string field, string ColumnLabel)
getColumnLabel            PROCEDURE(string field), string
setPicture                PROCEDURE(string field, string ColumnLabel)
getPicture                PROCEDURE(string field), string

serialize                 PROCEDURE, string, virtual
!Convert label's prefix to XML-compatible form
fixPrefix                 PROCEDURE(string s, BYTE removeFlag=true), string, protected
getCurrentValue           PROCEDURE, string, protected
setCurrentValue           PROCEDURE(string value), protected
!***Test if no duplicate names present
!***nameMap - QUEUE with mapping name pairs <ClarionName, XMLName>
testForDuplicate          PROCEDURE(MapQueue nameMap),BYTE
                        end
!****ReflectionClass for GROUP structure
GroupReflectionClass    class(ReflectionClass), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
init                      PROCEDURE(*GROUP g, BYTE removePrefix = true)
                        end
!****ReflectionClass for QUEUE structure
QueueReflectionClass    class(ReflectionClass), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
init                      PROCEDURE(*QUEUE q, BYTE removePrefix = true)
                        end
!***not used now
KeyReflectionClass      class(ReflectionClass), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
init                      PROCEDURE(*file f, *key k, BYTE removePrefix = true)
                        end
!***ReflectionClass for FILE structure
FileReflectionClass     class(ReflectionClass), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
construct                 PROCEDURE
destruct                  PROCEDURE, derived
init                      PROCEDURE(*file f, BYTE removePrefix = true)
                        end
!***ReflectionClass for VIEW structure
ViewReflectionClass     class(ReflectionClass), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
construct                 PROCEDURE
destruct                  PROCEDURE, derived
init                      PROCEDURE(*VIEW v, BYTE removePrefix = true)
                        end

!===  DOM  ========
!****Styles of XML string
                        itemize, pre(Format)
AS_IS                     EQUATE(1)
CANONICAL                 EQUATE(2)
REFORMATTED               EQUATE(4)
                        end

NEWLINE_DEFAULT         CSTRING('')
NEWLINE_CR              CSTRING('CR')
NEWLINE_CRLF            CSTRING('CR-LF')
NEWLINE_LF              CSTRING('LF')
!****Interface to access to a DOMWriter object
DOMWriter               interface                                                                                                                       .;map;module('DOMWriter')
setEncoding               PROCEDURE(*DOMWriter, const *CSTRING encoding)                                                                                , name('_setEncoding@8'), pascal, raw
setEncoding               PROCEDURE(*DOMWriter, const *CSTRING encoding, bool assumeISO88591)                                                           , name('_setEncoding@12'), pascal, raw
getEncoding               PROCEDURE(*DOMWriter), *CSTRING                                                                                               , name('_getEncoding@4'), pascal, raw
getLastEncoding           PROCEDURE(*DOMWriter), *CSTRING                                                                                               , name('_getLastEncoding@4'), pascal, raw
setFormat                 PROCEDURE(*DOMWriter, UNSIGNED format)                                                                                        , name('_setFormat@8'), pascal, raw
getFormat                 PROCEDURE(*DOMWriter), UNSIGNED                                                                                               , name('_getFormat@4'), pascal, raw
setNewLine                PROCEDURE(*DOMWriter, const *CSTRING newLine)                                                                                 , name('_setNewLine@8'), pascal, raw
getNewLine                PROCEDURE(*DOMWriter), *CSTRING                                                                                               , name('_getNewLine@4'), pascal, raw
writeNode                 PROCEDURE(*DOMWriter, *Node pNode), *CSTRING                                                                                  , name('_writeNode@8'), pascal, raw
writeNode                 PROCEDURE(*DOMWriter, const *CSTRING systemId, *Node pNode),cbool                                                                   , name('_writeNode2@12'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a DOMImplementation object                        
DOMImplementation       interface                                                                                                                       .;map;module('DOMImplementation')
hasFeature                PROCEDURE(*DOMImplementation, const *CSTRING feature, const *CSTRING version), cbool                                          , name('_hasFeature@12'), pascal, raw
! DOM Level 2      
createDocumentType        PROCEDURE(*DOMImplementation, const *CSTRING qualifiedName, const *CSTRING publicId, const *CSTRING systemId), *DocumentType  , name('_createDocumentType@16'), pascal, raw
createDocument            PROCEDURE(*DOMImplementation, const *CSTRING namespaceURI, const *CSTRING qualifiedName, *DocumentType doctype), *Document    , name('_createDocument@16'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a DOMObject object
DOMObject               interface                                                                                                                       .;map;module('DOMObject');
addRef                    PROCEDURE(*DOMObject)                                                                                                         , name('_addRef@4'), pascal, raw
duplicate                 PROCEDURE(*DOMObject)                                                                                                         , name('_duplicate@4'), pascal, raw
release                   PROCEDURE(*DOMObject)                                                                                                         , name('_release@4'), pascal, raw
countReferences           PROCEDURE(*DOMObject), cint                                                                                                   , name('_countReferences@4'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a NodeList object
NodeList                interface(DOMObject)                                                                                                            .;map;module('NodeList')
item                      PROCEDURE(*NodeList, UNSIGNED index), *Node                                                                                   , name('_item@8'), pascal, raw
getLength                 PROCEDURE(*NodeList), UNSIGNED                                                                                                , name('_getLength2@4'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a NamedNodeMap
NamedNodeMap            interface(DOMObject)                                                                                                            .;map;module('NamedNodeMap')
getNamedItem              PROCEDURE(*NamedNodeMap, const *CSTRING name), *Node                                                                          , name('_getNamedItem@8'), pascal, raw
setNamedItem              PROCEDURE(*NamedNodeMap, *Node arg), *Node                                                                                    , name('_setNamedItem@8'), pascal, raw
removeNamedItem           PROCEDURE(*NamedNodeMap, const *CSTRING name), *Node                                                                          , name('_removeNamedItem@8'), pascal, raw
item                      PROCEDURE(*NamedNodeMap, UNSIGNED index), *Node                                                                               , name('_item2@8'), pascal, raw
getLength                 PROCEDURE(*NamedNodeMap), UNSIGNED                                                                                            , name('_getLength3@4'), pascal, raw
! DOM Level 2
getNamedItemNS            PROCEDURE(*NamedNodeMap, const *CSTRING namespaceURI, const *CSTRING localName), *Node                                        , name('_getNamedItemNS@12'), pascal, raw
setNamedItemNS            PROCEDURE(*NamedNodeMap, *Node arg), *Node                                                                                    , name('_setNamedItemNS@8'), pascal, raw
removeNamedItemNS         PROCEDURE(*NamedNodeMap, const *CSTRING namespaceURI, const *CSTRING localName), *Node                                        , name('_removeNamedItemNS@12'), pascal, raw
                        end                                                                                                                             ;end

                        itemize(1), pre(Node)
ELEMENT                   EQUATE
ATTRIBUTE                 EQUATE
TEXT                      EQUATE
CDATA_SECTION             EQUATE
ENTITY_REFERENCE          EQUATE
ENTITY                    EQUATE
PROCESSING_INSTRUCTION    EQUATE
COMMENT                   EQUATE
DOCUMENT                  EQUATE
DOCUMENT_TYPE             EQUATE
DOCUMENT_FRAGMENT         EQUATE
NOTATION                  EQUATE
                        end
!****Interface to access to a Node object
Node                    interface(DOMObject)                                                                                                            ;end;map;module('Node')
getNodeName               PROCEDURE(*Node), *CSTRING                                                                                                    , name('_getNodeName@4'), pascal, raw
getNodeValue              PROCEDURE(*Node), *CSTRING                                                                                                    , name('_getNodeValue@4'), pascal, raw
setNodeValue              PROCEDURE(*Node, const *CSTRING value)                                                                                        , name('_setNodeValue@8'), pascal, raw
getNodeType               PROCEDURE(*Node), UNSIGNED                                                                                                    , name('_getNodeType@4'), pascal, raw
getParentNode             PROCEDURE(*Node), *Node                                                                                                       , name('_getParentNode@4'), pascal, raw
getChildNodes             PROCEDURE(*Node), *NodeList                                                                                                   , name('_getChildNodes@4'), pascal, raw
getFirstChild             PROCEDURE(*Node), *Node                                                                                                       , name('_getFirstChild@4'), pascal, raw
getLastChild              PROCEDURE(*Node), *Node                                                                                                       , name('_getLastChild@4'), pascal, raw
getPreviousSibling        PROCEDURE(*Node), *Node                                                                                                       , name('_getPreviousSibling@4'), pascal, raw
getNextSibling            PROCEDURE(*Node), *Node                                                                                                       , name('_getNextSibling@4'), pascal, raw
getAttributes             PROCEDURE(*Node), *NamedNodeMap                                                                                               , name('_getAttributes@4'), pascal, raw
getOwnerDocument          PROCEDURE(*Node), *Document                                                                                                   , name('_getOwnerDocument@4'), pascal, raw
insertBefore              PROCEDURE(*Node, *Node newChild, *Node refChild), *Node, proc                                                                 , name('_insertBefore@12'), pascal, raw
replaceChild              PROCEDURE(*Node, *Node newChild, *Node oldChild), *Node                                                                       , name('_replaceChild@12'), pascal, raw
removeChild               PROCEDURE(*Node, *Node oldChild), *Node, proc                                                                                 , name('_removeChild@8'), pascal, raw
appendChild               PROCEDURE(*Node, *Node newChild), *Node                                                                                       , name('_appendChild@8'), pascal, raw, proc
hasChildNodes             PROCEDURE(*Node), cbool                                                                                                       , name('_hasChildNodes@4'), pascal, raw
cloneNode                 PROCEDURE(*Node, cbool deep), *Node                                                                                           , name('_cloneNode@8'), pascal, raw
! DOM Level 2
normalize                 PROCEDURE(*Node)                                                                                                              , name('_normalize@4'), pascal, raw
isSupported               PROCEDURE(*Node, const *CSTRING feature, const *CSTRING version), cbool                                                       , name('_isSupported@12'), pascal, raw
getNamespaceURI           PROCEDURE(*Node), *CSTRING                                                                                                    , name('_getNamespaceURI@4'), pascal, raw
getPrefix                 PROCEDURE(*Node), *CSTRING                                                                                                    , name('_getPrefix@4'), pascal, raw
getLocalName              PROCEDURE(*Node), *CSTRING                                                                                                    , name('_getLocalName@4'), pascal, raw
hasAttributes             PROCEDURE(*Node), cbool                                                                                                       , name('_hasAttributes@4'), pascal, raw
                        end                                                                                                                             ; end
!****Interface to access to an Attr object
Attr                    interface(Node)                                                                                                                 .;map;module('Attr')
getName                   PROCEDURE(*Attr), *CSTRING                                                                                                    , name('_getName@4'), pascal, raw
getSpecified              PROCEDURE(*Attr), cbool                                                                                                       , name('_getSpecified@4'), pascal, raw
getValue                  PROCEDURE(*Attr), *CSTRING                                                                                                    , name('_getValue@4'), pascal, raw
setValue                  PROCEDURE(*Attr, const *CSTRING value)                                                                                        , name('_setValue@8'), pascal, raw
getOwnerElement           PROCEDURE(*Attr), *Element                                                                                                    , name('_getOwnerElement@4'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a CharacterData object
CharacterData           interface(Node)                                                                                                                 .;map;module('CharacterData')
getData                   PROCEDURE(*CharacterData), *CSTRING                                                                                           , name('_getData@4'), pascal, raw
setData                   PROCEDURE(*CharacterData, const *CSTRING data)                                                                                , name('_setData@8'), pascal, raw
getLength                 PROCEDURE(*CharacterData), UNSIGNED                                                                                           , name('_getLength@4'), pascal, raw
substringData             PROCEDURE(*CharacterData, UNSIGNED offset, UNSIGNED count), *CSTRING                                                          , name('_substringData@12'), pascal, raw
appendData                PROCEDURE(*CharacterData, const *CSTRING arg)                                                                                 , name('_appendData@8'), pascal, raw
insertData                PROCEDURE(*CharacterData, UNSIGNED offset, const *CSTRING arg)                                                                , name('_insertData@12'), pascal, raw
deleteData                PROCEDURE(*CharacterData, UNSIGNED offset, UNSIGNED count)                                                                    , name('_deleteData@12'), pascal, raw
replaceData               PROCEDURE(*CharacterData, UNSIGNED offset, UNSIGNED count, const *CSTRING arg)                                                , name('_replaceData@16'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a Notation object
Notation                interface(Node)                                                                                                                 .;map;module('Notation')
getPublicId               PROCEDURE, *CSTRING                                                                                                           , name('_getPublicID@4'), pascal, raw
getSystemId               PROCEDURE, *CSTRING                                                                                                           , name('_getSystemID@4'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a Text object
Text                    interface(CharacterData)                                                                                                        .;map;module('Text')
splitText                 PROCEDURE(*Text, UNSIGNED offset), *Text                                                                                      , name('_splitText@8'), pascal, raw
                        end                                                                                                                             ;end

Comment                 interface(CharacterData)
                        end

CDATASection            interface(Text)
                        end

EntityReference         interface(Node)                                                                                                                 .;map;module('EntityReference')
                        end                                                                                                                             ;end

Entity                  interface(Node)                                                                                                                 .;map;module('Entity')
getPublicId               PROCEDURE(*Entity), *CSTRING                                                                                                  , name('_getPublicId3@4'), pascal, raw
getSystemId               PROCEDURE(*Entity), *CSTRING                                                                                                  , name('_getSystemId3@4'), pascal, raw
getNotationName           PROCEDURE(*Entity), *CSTRING                                                                                                  , name('_getNotationName@4'), pascal, raw
                        end                                                                                                                             ;end

ProcessingInstruction   interface(Node)                                                                                                                 .;map;module('ProcessingInstruction')
getTarget                 PROCEDURE(*ProcessingInstruction), *CSTRING                                                                                   , name('_getTarget@4'), pascal, raw
getData                   PROCEDURE(*ProcessingInstruction), *CSTRING                                                                                   , name('_getData2@4'), pascal, raw
setData                   PROCEDURE(*ProcessingInstruction, const *CSTRING data)                                                                        , name('_setData@8'), pascal, raw
                        end                                                                                                                             ;end

DocumentType            interface(Node)                                                                                                                 .;map;module('DocumentType')
getName                   PROCEDURE(*DocumentType), *CSTRING                                                                                            , name('_getName2@4'), pascal, raw
getEntities               PROCEDURE(*DocumentType), *NamedNodeMap                                                                                       , name('_getEntities@4'), pascal, raw
getNotations              PROCEDURE(*DocumentType), *NamedNodeMap                                                                                       , name('_getNotations@4'), pascal, raw
! DOM Level 2
getPublicId               PROCEDURE(*DocumentType), *CSTRING                                                                                            , name('_getPublicId2@4'), pascal, raw
getSystemId               PROCEDURE(*DocumentType), *CSTRING                                                                                            , name('_getSystemId2@4'), pascal, raw
getInternalSubset         PROCEDURE(*DocumentType), *CSTRING                                                                                            , name('_getInternalSubset@4'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a Element object
Element                 interface(Node)                                                                                                                 .;map;module('Element')
getTagName                PROCEDURE(*Element), *CSTRING                                                                                                 , name('_getTagName@4'), pascal, raw
getAttribute              PROCEDURE(*Element, const *CSTRING name), *CSTRING                                                                            , name('_getAttribute@8'), pascal, raw
setAttribute              PROCEDURE(*Element, const *CSTRING name, const *CSTRING value)                                                                , name('_setAttribute@12'), pascal, raw, proc
removeAttribute           PROCEDURE(*Element, const *CSTRING name)                                                                                      , name('_removeAttribute@8'), pascal, raw
getAttributeNode          PROCEDURE(*Element, const *CSTRING name), *Attr                                                                               , name('_getAttributeNode@8'), pascal, raw
setAttributeNode          PROCEDURE(*Element, *Attr newAttr), *Attr                                                                                     , name('_setAttributeNode@8'), pascal, raw, proc
removeAttributeNode       PROCEDURE(*Element, *Attr oldAttr), *Attr                                                                                     , name('_removeAttributeNode@8'), pascal, raw
getElementsByTagName      PROCEDURE(*Element, const *CSTRING name), *NodeList                                                                           , name('_getElementsByTagName@8'), pascal, raw
! DOM Level 2
getAttributeNS            PROCEDURE(*Element, const *CSTRING namespaceURI, const *CSTRING localName), *CSTRING                                          , name('_getAttributeNS@12'), pascal, raw
setAttributeNS            PROCEDURE(*Element, const *CSTRING namespaceURI, const *CSTRING qualifiedName, const *CSTRING value)                          , name('_setAttributeNS@16'), pascal, raw
removeAttributeNS         PROCEDURE(*Element, const *CSTRING namespaceURI, const *CSTRING localName)                                                    , name('_removeAttributeNS@12'), pascal, raw
getAttributeNodeNS        PROCEDURE(*Element, const *CSTRING namespaceURI, const *CSTRING localName), *Attr                                             , name('_getAttributeNodeNS@12'), pascal, raw
setAttributeNodeNS        PROCEDURE(*Element, *Attr newAttr), *Attr                                                                                     , name('_setAttributeNodeNS@8')                                                      , pascal, raw
hasAttribute              PROCEDURE(*Element, const *CSTRING name), cbool                                                                               , name('_hasAttribute@8'), pascal, raw
hasAttributeNS            PROCEDURE(*Element, const *CSTRING namespaceURI, const *CSTRING localName), cbool                                             , name('_hasAttributeNS@12'), pascal, raw
                        end                                                                                                                             ;end
!****Interface to access to a Document object
Document                interface(Node)                                                                                                                 .;map;module('Document')
getDoctype                PROCEDURE, *DocumentType                                                                                                      , name('_getDocumentType@4'), pascal, raw
getImplementation         PROCEDURE, *DOMImplementation                                                                                                 , name('_getImplementation@4'), pascal, raw
getDocumentElement        PROCEDURE(*Document), *Element                                                                                                , name('_getDocumentElement@4'), pascal, raw
createElement             PROCEDURE(*Document, const *CSTRING tagName), *Element                                                                        , name('_createElement@8'), pascal, raw
createDocumentFragment    PROCEDURE(*Document), *DocumentFragment                                                                                       , name('_createDocumentFragment@4'), pascal, raw
createTextNode            PROCEDURE(*Document, const *CSTRING data), *Text                                                                              , name('_createTextNode@8'), pascal, raw
createComment             PROCEDURE(*Document, const *CSTRING data), *Comment                                                                           , name('_createComment@8'), pascal, raw
createCDATASection        PROCEDURE(*Document, const *CSTRING data), *CDATASection                                                                      , name('_createCDATASection@8'), pascal, raw
createProcessingInstruction PROCEDURE(*Document, const *CSTRING target, const *CSTRING data), *ProcessingInstruction                                    , name('_createProcessingInstruction@12'), pascal, raw
createAttribute           PROCEDURE(*Document, const *CSTRING name), *Attr                                                                              , name('_createAttribute@8'), pascal, raw
createEntityReference     PROCEDURE(*Document, const *CSTRING name), *EntityReference                                                                   , name('_createEntityReference@8'), pascal, raw
getElementsByTagName      PROCEDURE(*Document, const *CSTRING name), *NodeList                                                                          , name('_getElementsByTagName2@8'), pascal, raw
importNode                PROCEDURE(*Document, *Node importedNode, cbool deep), *Node                                                                   , name('_importNode@12'), pascal, raw
createElementNS           PROCEDURE(*Document, const *CSTRING namespaceURI, const *CSTRING qualifiedName), *Element                                     , name('_createElementNS@12'), pascal, raw
createAttributeNS         PROCEDURE(*Document, const *CSTRING namespaceURI, const *CSTRING qualifiedName), *Attr                                        , name('_createAttributeNS@12'), pascal, raw
getElementsByTagNameNS    PROCEDURE(*Document, const *CSTRING namespaceURI, const *CSTRING localName), *NodeList                                        , name('_getElementsByTagNameNS@12'), pascal, raw
getElementById            PROCEDURE(*Document, const *CSTRING elementId), *Element                                                                      , name('_getElementById@8'), pascal, raw
                        end                                                                                                                             ;end

DocumentFragment        interface(Node)
                        end
!****Interfaces to access to SAX Parser
!===  SAX  ========
ISAXCallback            interface, com
SetDocumentLocator        PROCEDURE(const *CSTRING PublicID, const *CSTRING SystemID)
NotationDecl              PROCEDURE(const *CSTRING name, const *CSTRING publicId, const *CSTRING systemId)
UnparsedEntityDecl        PROCEDURE(const *CSTRING name, const *CSTRING publicId, const *CSTRING systemId, const *CSTRING notationName)
StartDocument             PROCEDURE
EndDocument               PROCEDURE
StartElement              PROCEDURE(const *CSTRING name)
Attribute                 PROCEDURE(const *CSTRING name, const *CSTRING TYPE, const *CSTRING value)
EndElement                PROCEDURE(const *CSTRING name)
Characters                PROCEDURE(const *CSTRING chars)
IgnorableWhitespace       PROCEDURE(const *CSTRING chars)
ProcessingInstruction2    PROCEDURE(const *CSTRING target, const *CSTRING data)
Warning                   PROCEDURE(const *CSTRING warning)
Error                     PROCEDURE(const *CSTRING error)
FatalError                PROCEDURE(const *CSTRING fatalError)
StartDTD                  PROCEDURE(const *CSTRING name, const *CSTRING publicId, const *CSTRING systemId)
EndDTD                    PROCEDURE
StartEntity               PROCEDURE(const *CSTRING name)
EndEntity                 PROCEDURE(const *CSTRING name)
StartCDATA                PROCEDURE
EndCDATA                  PROCEDURE
Comment                   PROCEDURE(const *CSTRING commentText)
StartNamespaceDeclScope   PROCEDURE(const *CSTRING prefix, const *CSTRING uri)
EndNamespaceDeclScope     PROCEDURE(const *CSTRING prefix)
                        end

SAXParserClass          class, implements(ISaxCallback), module('cpXML.clw'), link('cpXML.clw', _XMLLibLinkMode_), dll(_XMLLibDllMode_), TYPE
ParseXMLString            PROCEDURE(string xml), BYTE, proc, virtual
ParseXMLFile              PROCEDURE(string path), BYTE, proc, virtual
SetDocumentLocator        PROCEDURE(string PublicID, string SystemID), virtual
NotationDecl              PROCEDURE(string name, string publicId, string systemId), virtual
UnparsedEntityDecl        PROCEDURE(string name, string publicId, string systemId, string notationName), virtual
StartDocument             PROCEDURE, virtual
EndDocument               PROCEDURE, virtual
StartElement              PROCEDURE(string name), virtual
Attribute                 PROCEDURE(string name, string TYPE, string value), virtual
EndElement                PROCEDURE(string name), virtual
Characters                PROCEDURE(string chars), virtual
IgnorableWhitespace       PROCEDURE(string chars), virtual
ProcessingInstruction2    PROCEDURE(string target, string data), virtual
Warning                   PROCEDURE(string warning), virtual
Error                     PROCEDURE(string error), virtual
FatalError                PROCEDURE(string fatalError), virtual
StartDTD                  PROCEDURE(string name, string publicId, string systemId), virtual
EndDTD                    PROCEDURE, virtual
StartEntity               PROCEDURE(string name), virtual
EndEntity                 PROCEDURE(string name), virtual
StartCDATA                PROCEDURE, virtual
EndCDATA                  PROCEDURE, virtual
Comment                   PROCEDURE(string commentText), virtual
StartNamespaceDeclScope   PROCEDURE(string prefix, string uri), virtual
EndNamespaceDeclScope     PROCEDURE(string prefix), virtual
                        end

  _EndOfInclude_
