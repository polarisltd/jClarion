! $Header: /0192-7/XMLSupport/src/xmlclass.inc 68    6.08.03 17:27 Sergei $
!****************************************************************************
!  FILE..........: xmlclass.inc
!  DESCRIPTION...: 
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-01 Created by Semenov Denis
!******************************************************************************

!===========================================[ SPECIAL ]========================
  OMIT ('_EndOfInclude_', _XMLCLASS_)

!===========================================[ CONSTANTS ]======================
_XMLCLASS_      EQUATE (1)
INF_CAPACITY    EQUATE (-1)

!===========================================[ IMPORT DECLARATIONS ]============
    INCLUDE ('CPXML.INC'),ONCE

_XJoinLinkMode_     EQUATE(0)
_XJoinDLLMode_      EQUATE(1)
    INCLUDE('XMLTypeInfo.inc'),ONCE

!===========================================[ TYPES ]==========================
!   Internal structure used for representation Clarion complex types in the
!   wrapper classes
mapIndexesQueue           QUEUE
index                       UNSIGNED
clwLabel                    CSTRING(MAX_NAME_LEN)
xmlLabel                    CSTRING(MAX_NAME_LEN)
xmlFormat                   XMLFieldFormat
                          END

PropertySet               QUEUE, TYPE
Name                        CSTRING(MAX_NAME_LEN) !Name of a property
Value                       CSTRING(MAX_NAME_LEN) !Value of the property
                          END

PropertyList              QUEUE, TYPE
Label                       CSTRING(MAX_NAME_LEN) !Label of a property set
Set                         &PropertySet
Decl                        &PropertySet
                          END

!==============================[ StructWrapper CLASS DEFININITION]=============
StructWrapper       CLASS,TYPE,MODULE('WRAPPER.CLW'),LINK('WRAPPER.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)

ObjectInfo                &XMLObjectInfo, PROTECTED
nameMap                   &XMLNameMap,    PROTECTED
fields                    &MappingQueue,  PROTECTED
mapIndexes                &mapIndexesQueue
useMap                    BOOL,           PROTECTED
bFreeMap                  BOOL,           PROTECTED
counter                   UNSIGNED,       PROTECTED

construct                 PROCEDURE
destruct                  PROCEDURE, VIRTUAL
kill                      PROCEDURE


getFieldsCount            PROCEDURE, UNSIGNED, VIRTUAL   !returns number of fields in
                                                         ! the Clarion's structure

!
! Get/Set the value for the specified field
!
getFieldValueByIndex      PROCEDURE(UNSIGNED cou), STRING, VIRTUAL
setFieldValueByIndex      PROCEDURE(UNSIGNED cou, STRING value), UNSIGNED, VIRTUAL

getXMLFieldFormatByIndex  PROCEDURE(UNSIGNED cou, *XMLFieldFormat fldFormat), UNSIGNED, VIRTUAL

findFieldByName           PROCEDURE(STRING field), SIGNED, VIRTUAL
findFieldByXMLName        PROCEDURE(STRING field), SIGNED, VIRTUAL

getFieldValueByName       PROCEDURE(STRING field),STRING, VIRTUAL
setFieldValueByName       PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL

getFieldValueByXMLName    PROCEDURE(STRING field), STRING, VIRTUAL
setFieldValueByXMLName    PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL

getFieldLabel             PROCEDURE(UNSIGNED cou), STRING !return the label of the
                                                          ! specified field

getXMLFieldLabel          PROCEDURE(UNSIGNED cou), STRING !return the label of the
                                                          ! specified field

!The function is necessary to produce XML schema
!Get field's type information
getFieldType              PROCEDURE(UNSIGNED cou),CLType, VIRTUAL
!get size of the field (for strings, DECIMAL etc)
getFieldSize              PROCEDURE(UNSIGNED cou, *UNSIGNED size, *UNSIGNED precision), BYTE, VIRTUAL

!records' iteration functions
getCapacity               PROCEDURE, UNSIGNED,VIRTUAL     !return the maximum number of rows in
                                                    !the corresponding Clarion's structure.
                                                    ! For example, for Group it's 1.
startIterate              PROCEDURE,VIRTUAL       !set the inner current row counter to initial
                                            !state (begin of rows' sequence)
getNextRow                PROCEDURE, BYTE,VIRTUAL !get next row (record)
clearBuffer               PROCEDURE,VIRTUAL       !clear buffer of current wrapped object
addRow                    PROCEDURE, UNSIGNED,VIRTUAL !add the new row to the Clarion's to the end

fixPrefix                 PROCEDURE(string s, byte removeFlag = true),STRING, PROTECTED, VIRTUAL

! Name mapping functions

!These methods set name mapping structures that is used on export/import operations
setNameMap                PROCEDURE(*XMLNameMap map),BYTE
setNameMap                PROCEDURE(MapQueue map),BYTE

getNameMap                PROCEDURE(),*XMLNameMap

isMappingEnabled          PROCEDURE,BYTE              !check if the name mapping mode turned on
setMappingEnabled         PROCEDURE(BYTE flag=true)   ! Set the name mapping flag

! The following methods are necessary for support of hierarchical structures
! (such as VIEW for example. The result XML file will have tree-like structure).

getFirstChild             PROCEDURE,*StructWrapper,VIRTUAL !return the reference to the first child node
getParent                 PROCEDURE,*StructWrapper,VIRTUAL !return the reference to the parent node
getNextSibling            PROCEDURE,*StructWrapper ,VIRTUAL!return the reference to the next sibling node
updateRowPos              PROCEDURE,VIRTUAL        !store the position of current row
isRowPosChanged           PROCEDURE,BYTE,VIRTUAL   !test if row position was changed since last call of
                                             !updateRowPos methods

!The following methods are used by XMLSchema class to generate a Clarion's structure "on the fly"
!It isn't supported in the version and can be changed in the future
addField                  PROCEDURE(STRING label, CLType type, UNSIGNED size, UNSIGNED precision), BYTE
                                        ! Add the new field description
! The following methods are used to get/set type specific information in StructWrapper.
loadProperties            PROCEDURE, BYTE, VIRTUAL
                          ! Get the number of elements in the PropertySets collection
getPropertySetsCount      PROCEDURE, UNSIGNED, VIRTUAL
getPropertySet            PROCEDURE(UNSIGNED cou, *STRING label), *PropertySet, VIRTUAL
addPropertySet            PROCEDURE(STRING label, PropertySet propset), BYTE, VIRTUAL
removePropertySet         PROCEDURE(UNSIGNED cou), BYTE, VIRTUAL

getRowTagName             PROCEDURE(), string, virtual
getRootTagName            PROCEDURE(), string, virtual

build                     PROCEDURE, BYTE, VIRTUAL      ! Create a Clarion's structure and attaches
                                        ! it the StructWrapper object

getCurrentValue           PROCEDURE, string, PROTECTED
setCurrentValue           PROCEDURE(string val), PROTECTED
                    END

!==================================[ GroupWrapper CLASS DEFININITION]==========
GroupWrapper        CLASS(StructWrapper),TYPE,MODULE('GroupWrap.CLW'),LINK('GroupWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
! Member data (private access)
groupData                 &GROUP
label                     CSTRING(256), PRIVATE
GroupInfo                 &XMLGroupInfo, PRIVATE

construct                 PROCEDURE
destruct                  PROCEDURE, VIRTUAL
                          !return the maximum number of rows in
                          !the corresponding Clarion's structure. For example, for Group it's 1.
getCapacity               PROCEDURE, UNSIGNED, VIRTUAL
                          !get next row (record)
getNextRow                PROCEDURE, BYTE, VIRTUAL
                          !clear buffer of current wrapped object
clearBuffer               PROCEDURE, VIRTUAL
                          !set the inner current row counter to initial
startIterate              PROCEDURE, VIRTUAL
                          !add the new row to the Clarion's to the end
addRow                    PROCEDURE, UNSIGNED, VIRTUAL
! GroupWrapper specific methods
Init                      PROCEDURE(*GROUP g, BYTE removePrefix = true),byte
                    END

!==================================[ QueueWrapper CLASS DEFININITION]==========
QueueWrapper        CLASS(StructWrapper),TYPE,MODULE('QueueWrap.CLW'),LINK('QueueWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
! Member data (private access)
queueData                 &QUEUE
QueueInfo                 &XMLQueueInfo, PRIVATE

construct                 PROCEDURE
destruct                  PROCEDURE, VIRTUAL
!records' iteration functions
                          !return the maximum number of rows in
                          !the corresponding Clarion's structure. For example, for Group it's 1.
getCapacity               PROCEDURE, UNSIGNED,VIRTUAL
                          !get next row (record)
getNextRow                PROCEDURE, BYTE,VIRTUAL
                          !add the new row to the Clarion's to the end
addRow                    PROCEDURE, UNSIGNED, VIRTUAL
                          !clear buffer of current wrapped object
clearBuffer               PROCEDURE, VIRTUAL
                          !set the inner current row counter to initial
startIterate              PROCEDURE, VIRTUAL
! QueueWrapper specific methods
Init                      PROCEDURE(*QUEUE q, BYTE removePrefix = true),byte
                    END

!==================================[ FileWrapper CLASS DEFININITION]==========
FileWrapper        CLASS(StructWrapper),TYPE,MODULE('FileWrap.CLW'),LINK('FileWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
! Member data (private access)
fileData                  &FILE
label                     CSTRING(256), PRIVATE
FileInfo                  &XMLFileInfo, PRIVATE
Properties                &PropertyList, PRIVATE
removePrefix              BOOL, PRIVATE

construct                 PROCEDURE
destruct                  PROCEDURE, VIRTUAL
!records' iteration functions
                          !return the maximum number of rows in 
                          !the corresponding Clarion's structure. For example, for Group it's 1.
getCapacity               PROCEDURE, UNSIGNED, VIRTUAL
                          !get next row (record)
getNextRow                PROCEDURE, BYTE, VIRTUAL
                          !add the new row to the Clarion's to the end
addRow                    PROCEDURE, UNSIGNED, VIRTUAL
                          !clear buffer of current wrapped object
clearBuffer               PROCEDURE, VIRTUAL
                          !set the inner current row counter to initial
startIterate              PROCEDURE, VIRTUAL
! FileWrapper specific methods
Init                      PROCEDURE(*FILE q, BYTE removePrefix = true),byte
! The following methods are used to get/set type specific information in StructWrapper.
loadProperties            PROCEDURE, BYTE, VIRTUAL
                          ! Get the number of elements in the PropertySets collection
getPropertySetsCount      PROCEDURE, UNSIGNED, VIRTUAL
getPropertySet            PROCEDURE(UNSIGNED cou, *STRING label), *PropertySet, VIRTUAL
addPropertySet            PROCEDURE(STRING label, PropertySet propset), BYTE, VIRTUAL
removePropertySet         PROCEDURE(UNSIGNED cou), BYTE, VIRTUAL
                    END

!==================================[ ViewWrapper CLASS DEFININITION]==========
ViewWrapper         CLASS(StructWrapper),TYPE,MODULE('ViewWrap.CLW'),LINK('ViewWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
! Member data (private access)
viewData                  &VIEW
label                     CSTRING(256), PRIVATE
ViewInfo                  &XMLViewInfo,  PRIVATE

construct                 PROCEDURE
destruct                  PROCEDURE, VIRTUAL
!records' iteration functions
                          !return the maximum number of rows in
                          !the corresponding Clarion's structure. For example, for Group it's 1.
getCapacity               PROCEDURE, UNSIGNED, VIRTUAL
                          !get next row (record)
getNextRow                PROCEDURE, BYTE, VIRTUAL
                          !clear buffer of current wrapped object
clearBuffer               PROCEDURE, VIRTUAL
                          !set the inner current row counter to initial
startIterate              PROCEDURE, VIRTUAL
!Not supported methods
setFieldValueByIndex      PROCEDURE(UNSIGNED cou,STRING value), UNSIGNED, VIRTUAL
setFieldValueByName       PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL
setFieldValueByXMLName    PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL
! ViewWrapper specific methods
Init                      PROCEDURE(*VIEW v, BYTE removePrefix = true),byte

                    END

!================================[ XMLNameMap CLASS DEFININITION]==============
XMLNameMap          CLASS, MODULE('XMLNameMap.CLW'), LINK('XMLNameMap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)

! Member data (private access)
map                     &MapQueue, PRIVATE
! name of root tag of the XML file
rootTagName             CSTRING(MAX_NAME_LEN),PRIVATE ! empty - means default
! name of tag for a row
rowTagName              CSTRING(MAX_NAME_LEN),PRIVATE ! empty - means default
counter                 UNSIGNED, PROTECTED

construct               PROCEDURE
destruct                PROCEDURE, VIRTUAL
! set the inner current row counter to initial state (begin of rows' sequence)
startIterate            PROCEDURE
! get next row (record)
getNextRow              PROCEDURE, BYTE
getXMLName              PROCEDURE, STRING
getClarionName          PROCEDURE, STRING
getXmlFieldFormat       PROCEDURE, XMLFieldFormat
!Load methods provide loading mapping/formatting information
load                    PROCEDURE(MapQueue map),BYTE

! Loading mapping/formatting information from the file
open                    PROCEDURE(string path, <*MapQueue map>),byte

! Storing mapping/formatting information to the file
saveAs                  PROCEDURE(string path, <*CSTRING newLine>, UNSIGNED Format = 1),byte

! Returns: rows tag name specifyed by the in the structure (child attribute in name mapping XML file)
getRowTagName           PROCEDURE,string

! Returns: root tag name specifyed by the in the structure (root attribute in name mapping XML file)
getRootTagName          PROCEDURE,string

! Set rows tag name
setRowTagName           PROCEDURE(string name),byte

! Set root tag name
setRootTagName          PROCEDURE(string name),byte

!add a new record with name mapping/formatting information  
addRecord               PROCEDURE(STRING clarionName, STRING xmlName, <STRING picture>, <XMLFieldFormat fldFormat>),BYTE

!VIRTUAL method to customize formatting behaviour
formatValue             PROCEDURE(STRING fieldName, STRING value, BYTE toXML=true), STRING, VIRTUAL

!The following method are used by StructWrapper class to support name mapping/formatting
translateName           PROCEDURE(STRING name, BYTE toXML=true),*CSTRING

!Helper method to validate XML name
checkXMLName            PROCEDURE(STRING xmlName), BYTE
                    END

!===========================[ CLASS DEFININITION ]===========================
XMLHRElem           CLASS,TYPE,MODULE('XMLTreeJoin.clw'),LINK('XMLTreeJoin.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
sw                      &StructWrapper
nd                      &Element  !if null then closed
hrChild                 &XMLHRElem
hrNext                  &XMLHRElem
idx                     SIGNED(0)
construct               PROCEDURE
destruct                PROCEDURE
!Test if writing is opened
isOpened                PROCEDURE,byte
close                   PROCEDURE
!test if the corresponding row changed
isRowChanged            PROCEDURE,byte
!clear the change row flag
clearChangedFlg         PROCEDURE
getName                 PROCEDURE, *cstring
                    END
!List of XMLHRElem reference
hrQueue             QUEUE,TYPE
hrElem                  &XMLHRElem
                    END

!===========================[ CLASS DEFININITION ]===========================
!The class is used to support hierarchical View with nested JOIN and similar structures
XMLHRManager        CLASS,TYPE,MODULE('XMLTreeJoin.clw'),LINK('XMLTreeJoin.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
hrq                     &hrQueue
        !fill the queue with references of hrElem
construct               PROCEDURE
destruct                PROCEDURE
!init the structure with StructWrapper
!prev - pointer to the previous element (null if no previous)
!return pointer to the created element (null - if error)
init                    PROCEDURE(StructWrapper sw,*XMLHRElem prev),*XMLHRElem
!return the lowlest element's index with changed row
lowChangeIdx            PROCEDURE(),signed
!get element XMLHRElem by index
getElem                 PROCEDURE(signed idx),*XMLHRElem
!return the number of elements
elems                   PROCEDURE,signed
                    END

!synonim for DOMStyle
XMLStyle      EQUATE(UNSIGNED)

            ITEMIZE, PRE(XMLStyle)
ADO_26        EQUATE(0)
ADO_NET       EQUATE
            END

!Specify position for appending new node
XMLPos      EQUATE(UNSIGNED)

            ITEMIZE, PRE(XMLPos)
APPEND_CHILD  EQUATE
APPEND        EQUATE
            END

!Specify find mode - not used now
XMLFind      EQUATE(UNSIGNED)

            ITEMIZE, PRE(XMLFind)
FIND_FIRST    EQUATE
FIND_NEXT     EQUATE
FIND_LAST     EQUATE
            END

!flags for fromXML
FXMode        EQUATE(UNSIGNED)

            ITEMIZE, PRE(FXMode)
IgnoreSchema    EQUATE(8)
VerifyBySchema  EQUATE(16)  !can be with CHECK:<...> bits
!CreateStructure EQUATE(32) Not supported now
            END

!flags for SaveAs
SVMode      EQUATE(UNSIGNED)

            ITEMIZE, PRE(SVMode)
IgnoreSchema  EQUATE(1)
WithSchema    EQUATE(2)
            END

!===========================[ CLASS DEFININITION ]===========================
XMLExchange         CLASS,TYPE,MODULE('XMLExchange.clw'),LINK('XMLExchange.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
!class member declarations
style                   XMLStyle(XMLStyle:ADO_26),private !style of generated XML
maxRowCount             unsigned(0),private !max rows to retrieve; 0 - means - no restriction
rootTagName             cstring(MAX_NAME_LEN),private !name of root tag of the XML file
                          !empty - means default
rowTagName              cstring(MAX_NAME_LEN),private !name of tag for a row
                          !empty -means default 
namespaceSupported      byte
schemaSupported         byte
schema                  &XMLSchema
navigator               &XMLNavigator
lastPath                &CStringClass
!lastError               unsigned(0),private !last error code
specAttrOn              byte !if spec attributes presents
xmlDocument             &Document,private !pointer to the DOM Document
xmlCurrentNode          &Element,private !pointer to the current element node
xmlLastAddedNode        &Element,private
bCreateXml              BOOL, private

!Class methods declarations
construct               PROCEDURE
destruct                PROCEDURE
!Load DOM data from a XML file
open                    PROCEDURE(string path),byte
!Create DOM data with specified schema
createXML               PROCEDURE(<string schemaURL>),byte
! Close an access to XML DOM. After this method any operation with XML are not available 
close                   PROCEDURE

!Save content to a XML file with specified path 
saveAs                  PROCEDURE(string path),byte
saveAs                  PROCEDURE(string path,SVMode flag, <*CSTRING newLine>, UNSIGNED Format = 1),byte
!Load data from a Clarion's structure. If some data has been loaded before the method just 
!append new data to the existent one. You can select XML node (setNode method) and specify 
!positionFlag to point at position where the data should be loaded to
!positionFlag can be following: 
!XMLPos:APPEND_CHILD_ELEM (data will be appended as child node relatively to the current node
!The new node will have the name nodeName) or
!XMLPos:APPEND (data will be appended to the current node). In the latest case
!nodeName not used.
toXML                   PROCEDURE(StructWrapper sw, <string nodeName>,byte positionFlag=XMLPos:APPEND),byte


!Put the data from the DOM Document object to a Clarion's object. You can select necessary
!XML node for this operation with setNode method.
fromXML                 PROCEDURE(StructWrapper sw),byte
fromXML                 PROCEDURE(StructWrapper sw, FXMode flag),byte

!Select a XML node  
setNode                 PROCEDURE(*Element nd)
!return the current node
getNode                 PROCEDURE,*Element
!get XMLNavigator object  
getNavigator            PROCEDURE, *XMLNavigator
!Set specAttrOn flag
setSpecAttrOn           PROCEDURE(byte flag=true)
!Error function - return error code of the last operation
!getLastError        PROCEDURE, unsigned

! The following methods set several export/import parameters. Calls of these methods are 
! optional because default values provided for these parameters

!Set style (attribute-based or tag-based) that is used for import/export operations
!It can be XMLStyle:ADO_26 or XMLStyle:ADO_Net)
setStyle                PROCEDURE(XMLStyle style)
getStyle                PROCEDURE,XMLStyle !get style info from the current node
!the following method work with the current node
getTimeCreated          PROCEDURE, string
setTimeCreated          PROCEDURE(string dt)
getVersion              PROCEDURE, string

getUserInfo             PROCEDURE, string
!set userinfo attribute in the last added node
setUserInfo             PROCEDURE(string)

!Auxiliary methods
setRootTagName          PROCEDURE(string tagName), byte ! set the highest-level tag name
getRootTagName          PROCEDURE,string ! get the name of table tag
setRowTagName           PROCEDURE(string tagName), byte ! set the name of tag that used for a row of     data
getRowTagName           PROCEDURE,string !get the name of row tag
setMaxRowCount          PROCEDURE(unsigned maxCou),byte ! set the maximum number of rows to be retrieved
getDocument             PROCEDURE,*Document    !get pointer to the underlaing DOM document
detachDOM               PROCEDURE,*Document    !detach the underlaying document
attachDOM               PROCEDURE(*Document)       !attach the underlaying document
setRootAsCurrent        PROCEDURE,byte,proc    !set the root elem as current
!append the schema attributes to the current node
setSchema               PROCEDURE(string schemaURL),byte,proc
setNamespace            PROCEDURE
!set last added node as current node
setLastAddedAsCurrent   PROCEDURE,byte,proc

!private methods
!get full path to the schema
getSchemaPath           PROCEDURE,STRING      
!setLastError        PROCEDURE(unsigned),private
setVersion              PROCEDURE(<string ver>),private
!set attribute to the last added node 
setAttr                 PROCEDURE(string attr,string val)
!get attribute of the current node
getAttr                 PROCEDURE(string attr),string
!set Version,timestamp,XMLstyle atributes
setSpecAttr             PROCEDURE,private
!Assign values to the structure
assignCols              PROCEDURE(*Element RowENode,XMLStyle style, StructWrapper sw),byte,private
setLastAdded            PROCEDURE(*Element nd)
!inner method to export tree-like structure
!lvl - number of part (1-based)                              
toXMLTree               PROCEDURE(XMLHRManager hrm,signed lvl),signed,private
!create childs elems of XML
CreateChildElems        PROCEDURE(*XMLHRElem hrElem,*Element rowElem),byte,private
AddRow                  PROCEDURE(StructWrapper sw,*Element elem, *byte rc),*Element
                    END

!==================================[ StringClass CLASS DEFININITION]==========
!Auxiliary class to support dynamic string
StringClass         CLASS,TYPE,MODULE('TreeViewWrap.CLW'), LINK('TreeViewWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
s                       &STRING, protected

construct               PROCEDURE
destruct                PROCEDURE, virtual
str                     PROCEDURE(string s), STRING, proc
str                     PROCEDURE, STRING
cat                     PROCEDURE(string s)
                    END

!==================================[ TreeViewWrapper CLASS DEFININITION]==========
TreeViewWrapper     CLASS(StructWrapper),TYPE,MODULE('TreeViewWrap.CLW'),LINK('TreeViewWrap.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
    
! Member data (private access)
viewData                &VIEW
fileData                &FILE
label                   CSTRING(256), PRIVATE
!Navigation
_Parent                 &TreeViewWrapper
_Next                   &TreeViewWrapper
_Child                  &TreeViewWrapper
filePos                 &StringClass
                                                                            
construct               PROCEDURE

destruct                PROCEDURE, VIRTUAL

!records' iteration functions
getCapacity             PROCEDURE, UNSIGNED,VIRTUAL !return the maximum number of rows in !the corresponding Clarion's structure. For example, for Group it's 1.
getNextRow              PROCEDURE, BYTE,VIRTUAL !get next row (record)
clearBuffer             PROCEDURE,VIRTUAL       !clear buffer of current wrapped object
startIterate            PROCEDURE,VIRTUAL       !set the inner current row counter to initial

!Not supported methods
setFieldValueByIndex    PROCEDURE(UNSIGNED cou,STRING value), UNSIGNED, VIRTUAL
setFieldValueByName     PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL
setFieldValueByXMLName  PROCEDURE(STRING field, STRING value), UNSIGNED, VIRTUAL

! The following methods are necessary for support of hierarchical structures
! (such as VIEW for example. The result XML file will have tree-like structure).

getFirstChild           PROCEDURE,*StructWrapper,VIRTUAL !return the reference to the first child node
getParent               PROCEDURE,*StructWrapper,VIRTUAL !return the reference to the parent node
getNextSibling          PROCEDURE,*StructWrapper ,VIRTUAL!return the reference to the next sibling node
updateRowPos            PROCEDURE,VIRTUAL        !store the position of current row
isRowPosChanged         PROCEDURE,BYTE,VIRTUAL   !test if row position was changed since last call of
                                             !updateRowPos methods

! TreeViewWrapper specific methods
Init                    PROCEDURE(*VIEW v, BYTE removePrefix = true),BYTE
InitNode                PROCEDURE(*VIEW v,XMLJoinInfo xJI,BYTE removePrefix=true),BYTE
 
                    END

!Auxiliary XML navigation class
!QUEUE to store XML attributes information
AttrQueue   QUEUE, TYPE
AttrName        CSTRING(MAX_NAME_LEN)
AttrValue       CSTRING(MAX_NAME_LEN)
            END
!==================================[ XMLNavigator CLASS DEFININITION]==========
XMLNavigator        CLASS,TYPE,MODULE('XMLNavigator.CLW'),LINK('XMLNavigator.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)
currentNode             &Element
xExch                   &XMLExchange
construct               PROCEDURE
init                    PROCEDURE(*XMLExchange xExch)
!Get the current node of the XMLExchange object and set the current node of 
!XMLNavigator to the retrieved value
getXMLExchangeNode      PROCEDURE

!Set the current node of the XMLExchange object to the current node of 
!XMLNavigator 
setXMLExchangeNode      PROCEDURE

!Move the inner current node pointer to the root node of the DOM Document
goToRoot                PROCEDURE, BYTE

!Move the current node pointer to the parent node relatively to current node value
goToParent              PROCEDURE, BYTE

!Move the current node pointer to the first child node relatively to current node value
goToFirstChild          PROCEDURE, BYTE

!Move the current node pointer to the next sibling node relatively to current node value    
goToNextSibling         PROCEDURE, BYTE

!Returns:  The current node name
getNodeName             PROCEDURE, STRING

!Fill the QUEUE structure with attributes information in the form of pairs 
!<attribute_name,attribute_value>
getNodeAttributes       PROCEDURE(AttrQueue aq), BYTE

                    END

!     INCLUDE ('XMLSCHEMA.INC'),ONCE

TypesQueue    QUEUE,TYPE
typeID          BYTE
clarionType     STRING(MAX_NAME_LEN)
xmlType         STRING(MAX_NAME_LEN)
xmlTypeDp       STRING(MAX_NAME_LEN) !displaying form
xmlSize         STRING(MAX_NAME_LEN)
xmlSizeDp       STRING(MAX_NAME_LEN) !displaying form
xmlPrecision    STRING(MAX_NAME_LEN)
xmlPrecisionDp  STRING(MAX_NAME_LEN) !displaying form
            END

CHECK:FIELDS    EQUATE(1)
CHECK:TYPES     EQUATE(2)
CHECK:ALL       EQUATE(3) !TYPES & FIELDS
CHECK:MASK      EQUATE(3)

!===========================[ CLASS DEFININITION ]===========================
!Declaration of XMLSchema class to support XML Schema related operations
XMLSchema         CLASS,TYPE,MODULE('XMLSCHEMA.CLW'),LINK('XMLSCHEMA.CLW', _XMLLibLinkMode_),DLL(_XMLLibDllMode_)

style                 XMLStyle(XMLStyle:ADO_26),PRIVATE !style of generated XML
types                 &TypesQueue,PRIVATE 
xmlDoc                &Document,PRIVATE !document itself  
xmlAppInfo            &Element,PRIVATE  !appinfo node
xmlRoot               &Element,PRIVATE  !root element to add fields
xmlFields             &NodeList,PRIVATE
curField              &Element
fieldIdx              UNSIGNED,PRIVATE !index of current iterated field
rootTagName           CSTRING(MAX_NAME_LEN),PRIVATE !name of root tag of the XML file
                          !empty - means default
rowTagName            CSTRING(MAX_NAME_LEN),PRIVATE !name of tag for a row
                          !empty -means default 
xsdPrefix             CSTRING(MAX_NAME_LEN),PRIVATE ! XMLSchema namespace prefix  
cxPrefix              CSTRING(MAX_NAME_LEN),PRIVATE ! ClarionXML namespace prefix 

!Private methods
!Reading XML Schema data from DOM
startFieldsIterate    PROCEDURE,BYTE,PRIVATE
getNextField          PROCEDURE,BYTE,PRIVATE
getFieldType          PROCEDURE(*CLType type,*UNSIGNED size,*UNSIGNED precision),BYTE,PRIVATE 
getFieldLabel         PROCEDURE,STRING,PRIVATE
!generating DOM structure by specifying types of fields
createSkeleton        PROCEDURE, BYTE,PRIVATE
addField              PROCEDURE(STRING label,CLType type,UNSIGNED size,UNSIGNED precision),BYTE,PRIVATE
addPropertySet        PROCEDURE(STRING tag,*PropertySet ps),BYTE,PRIVATE
fillTypes             PROCEDURE,PRIVATE
setPositions          PROCEDURE,BYTE,PRIVATE !set xmlRoot,xmlAppInfo positions
setPrefixes           PROCEDURE,BYTE,PRIVATE ! set namespaces prefixes
!Public methods
!Constructor of the class
construct             PROCEDURE
!Destructor of the class
destruct              PROCEDURE
!Create the schema using type information from given StructWrapper object
createSchema          PROCEDURE(StructWrapper sw),BYTE
!Load schema from a XML file
open                  PROCEDURE(STRING path),BYTE
!The operation destroys the underlying XML DOM object.
close                 PROCEDURE
!Build Clarion's object according to the schema
buildObject           PROCEDURE(StructWrapper sw),BYTE 
!Checks if Clarion's object structure corresponds to the given schema 
checkConsistency      PROCEDURE(StructWrapper sw,UNSIGNED flags=CHECK:ALL),BYTE
!Save schema to a XML file
saveAs                PROCEDURE(STRING path, <*CSTRING newLine>, UNSIGNED Format = 1),BYTE
!Set style that is used for import/export operations.
setStyle              PROCEDURE(XMLStyle style) 
!Returns: XMLStyle:ADO_Net; XMLStyle:ADO_26 - otherwise
getStyle              PROCEDURE, XMLStyle      
!Set the root tag name
setRootTagName        PROCEDURE(STRING tagName), BYTE
! get the name of table tag
getRootTagName        PROCEDURE,STRING
!Set the name of tag that used for a row of data
setRowTagName         PROCEDURE(STRING tagName), BYTE 
!get the name of row tag
getRowTagName         PROCEDURE,STRING 
                  END

! _EndOfInclude_