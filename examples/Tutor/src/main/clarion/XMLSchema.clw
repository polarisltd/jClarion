!  $Header: /0192-7/XMLSupport/src/XMLSchema.clw 16    8/05/03 12:50p Mal $
!****************************************************************************
!  FILE..........: XMLSchema.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for schema support for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-05-28 Created by Anatoly Medyntsev
!                  YYYY-MM-DD description of changes
!                   ..........
!****************************************************************************
   member

   include('XMLClass.inc'), once

cs:xsd      CSTRING('xmlns:xsd')
cs:xsdNS    CSTRING('http://www.w3.org/2001/XMLSchema')
cs:cx       CSTRING('xmlns:cx')
cs:cxNS     CSTRING('http://www.softvelocity.com/ClarionXML')
cs:cxPrefix CSTRING('cx')


                    
!XMLSchema class implementation
!Reading XML Schema data from DOM
!start iteration through fields
XMLSchema.startFieldsIterate    PROCEDURE!,BYTE
root     &Element,AUTO
flds    &NodeList,AUTO
tag     CStringClass

        CODE
        root&=SELF.xmlRoot    
        IF root&=null
            RETURN CPXMLErr:InternalError
        END
        IF SELF.xmlFields&=null
            IF SELF.getStyle()=XMLStyle:ADO_Net
                tag.str(SELF.xsdPrefix & ':element')
            ELSE
                tag.str(SELF.xsdPrefix & ':attribute')
            END
            flds&=root.getElementsByTagName(tag.str())!If null no error?     
            SELF.xmlFields&=flds
        ELSE                    
            flds&=SELF.xmlFields
        END
        SELF.fieldIdx=0
        RETURN  CPXMLErr:NoError

XMLSchema.getNextField      PROCEDURE!,BYTE
flds    &NodeList,AUTO
sz  UNSIGNED
field   &Element,AUTO
                CODE
                IF SELF.xmlFields&=null
                    RETURN CPXMLErr:InternalError !or EOS?
                END
                flds&=SELF.xmlFields
                sz=flds.getLength()             
                IF SELF.fieldIdx >= sz
                    RETURN CPXMLErr:EOS
                END
                field&=address(flds.item(SELF.fieldIdx))
                IF field&=null
                    RETURN CPXMLErr:InternalError
                END
                SELF.curField&=field
                SELF.fieldIdx+=1
                RETURN CPXMLErr:NoError     

!read the type information for the current field of the schema
XMLSchema.getFieldType  PROCEDURE(*CLType type,*UNSIGNED size,*UNSIGNED precision)!,BYTE 
            
strtp       STRING(MAX_NAME_LEN)
sztag       CSTRING(MAX_NAME_LEN)
prctag      CSTRING(MAX_NAME_LEN)
list        &NodeList,AUTO
elem        &Element,AUTO
sz      UNSIGNED
str     &CSTRING
tag     CStringClass
            CODE                
            IF SELF.curField&=null
                RETURN CPXMLErr:InternalError
            END
            !str&=SELF.curField.getAttribute(tag.str(SELF.cxPrefix & ':type'))
            str&=SELF.curField.getAttributeNS(cs:cxNS,tag.str('type'))
            IF str&=null
                RETURN CPXMLErr:IllegalType
            END
            strtp=lower(str)
            IF SELF.types&=null
                RETURN CPXMLErr:InternalError       
            END
            SELF.types.clarionType=strtp
            get(SELF.types,SELF.types.clarionType)
            IF errorcode() <> 0
                RETURN CPXMLErr:IllegalType
            END
            type=SELF.types.typeID
            sztag=clip(SELF.types.xmlSizeDp)
            prctag=clip(SELF.types.xmlPrecisionDp)
            size=0
            precision=0
            IF len(sztag)>0
                list&=SELF.curField.getElementsByTagName(sztag)
                IF NOT list&=null
                    sz=list.getLength()
                    IF sz>0 
                        elem&=address(list.item(0))
                        IF NOT elem&=null
                            str&=elem.getAttribute(tag.str('value'))
                            IF NOT str&=null
                                size=str
                            END             
                        END
                    END         
                END
            END
            IF len(prctag)>0
                list&=SELF.curField.getElementsByTagName(prctag)
                IF NOT list&=null
                    sz=list.getLength()
                    IF sz>0 
                        elem&=address(list.item(0))
                        IF NOT elem&=null
                            str&=elem.getAttribute(tag.str('value'))
                            IF NOT str&=null
                                precision=str
                            END             
                        END
                    END         
                END
            END
            RETURN CPXMLErr:NoError
 
XMLSchema.getFieldLabel PROCEDURE!,STRING
str &CSTRING
tag CStringClass
            CODE
            IF SELF.curField&=null
                RETURN ''
            END
            str&=SELF.curField.getAttribute(tag.str('name'))
            IF str&=null
                RETURN ''
            END
            RETURN str
!generating DOM structure by specifying types of fields
XMLSchema.createSkeleton    PROCEDURE!, BYTE
doc   &Document,auto
root  &Element,auto
cs    CStringClass
cseq  CStringClass  
rowtag CStringClass
tag    CStringClass
                CODE  
                    SELF.close
                cseq.str('')
                IF SELF.getStyle()=XMLStyle:ADO_Net
                    cseq.str('<xsd:sequence/>')  
                END
                rowtag.str(SELF.getRowTagName())
                cs.str('<<xsd:schema ' & cs:xsd & '="' & cs:xsdNS & '">')
                cs.str(cs.str() & '<xsd:element name="'& SELF.getRootTagName() & '">')
                cs.str(cs.str() & '<xsd:complexType>')
                cs.str(cs.str() & '<xsd:choice maxOccurs="unbounded">')
                cs.str(cs.str() & '<xsd:element ref="' & rowtag.str() & '"/>')
                cs.str(cs.str() & '</xsd:choice>')
                cs.str(cs.str() & '</xsd:complexType>')
                cs.str(cs.str() & '</xsd:element>')
                    cs.str(cs.str() & '<xsd:element name="' & rowtag.str() & '">')
                    cs.str(cs.str() & '<xsd:annotation><xsd:appinfo/></xsd:annotation>')
                    cs.str(cs.str() & '<xsd:complexType>' & cseq.str() & '</xsd:complexType>')
                    cs.str(cs.str() & '</xsd:element></xsd:schema>')
                    !message(cs.str())
                    doc&=createDocumentFromXml(cs.str())
                IF(doc&=null)
                    RETURN CPXMLErr:CreateDOMFail               
                END
                root&=doc.getDocumentElement()
                !xmlns:cx="http://www.softvelocity.com/ClarionXML" workaround problems with CenterPoint
                root.setAttribute(cs:cx,cs:cxNS)
                !DOMToXMLFile(doc,'D:\qqq.xml')
                SELF.xmlDoc&=doc
                RETURN CPXMLErr:NoError    

!set xmlRoot,xmlAppInfo positions
XMLSchema.setPositions      PROCEDURE!,BYTE 
rc  BYTE
doc &Document,AUTO
elem    &Element,AUTO
appinfo &Node,AUTO
!root    &Node,AUTO
nd  &Node,AUTO
annot   &Node,AUTO
tp  UNSIGNED
cs  CStringClass
                CODE
                rc=SELF.setPrefixes()
                IF rc<>0
                    RETURN rc
                END
                doc&=SELF.xmlDoc
                IF doc&=null
                    RETURN CPXMLErr:InternalError
                END
                elem&=doc.getDocumentElement()      
                IF elem&=null
                    RETURN CPXMLErr:InternalError
                END
                nd&=getFirstChildElem(elem)
                    IF(nd&=null)
                       return CPXMLErr:InternalError
                END
                nd&=getNextSiblingElem(nd)
                IF(nd&=null)
                       RETURN CPXMLErr:IllegalFormat
                END
                !Now nd contain main node of structure description
                cs.str(SELF.xsdPrefix & ':element')
                IF NOT cs.str()=lower(nd.getNodeName())
                    RETURN CPXMLErr:IllegalFormat
                END
                annot&=getFirstChildElem(nd)
                IF(annot&=null)
                       return CPXMLErr:IllegalFormat
                END
                SELF.xmlAppInfo&=null
                cs.str(SELF.xsdPrefix & ':annotation') 
                IF cs.str()=lower(annot.getNodeName()) 
                    appinfo&=getFirstChildElem(annot)
                    IF NOT appinfo&=null
                        cs.str(SELF.xsdPrefix & ':appinfo')
                        IF cs.str()=lower(appinfo.getNodeName()) 
                            tp=appinfo.getNodeType()
                                IF(tp <> Node:ELEMENT)
                                    RETURN CPXMLErr:IllegalFormat
                            END
                            SELF.xmlAppInfo&=address(appinfo)
                        END
                    END
                    nd&=getNextSiblingElem(annot)
                    IF nd&=null
                        RETURN CPXMLErr:IllegalFormat
                    END
                ELSE
                    !no annotation
                    SELF.xmlAppInfo&=null
                    nd&=annot ! we think it's root elem
                END
                !now we point to complexType elem
                IF SELF.getStyle()=XMLStyle:ADO_Net
                    !go to sequence
                    nd&=getFirstChildElem(nd) ! point to sequence
                    IF nd&=null
                        RETURN CPXMLErr:IllegalFormat
                    END
                    cs.str(SELF.xsdPrefix & ':sequence')
                ELSE
                    cs.str(SELF.xsdPrefix & ':complextype')
                END
                IF NOT cs.str()=lower(nd.getNodeName())
                    RETURN CPXMLErr:IllegalFormat
                END             
                    tp=nd.getNodeType()
                    IF(tp <> Node:ELEMENT)
                        RETURN CPXMLErr:IllegalFormat
                END
                    elem&=address(nd)
                SELF.xmlRoot&=elem
                RETURN CPXMLErr:NoError
                    
!set namespaces prefixes;
!after open cxPrefix may be incorrect!!!
XMLSchema.setPrefixes       PROCEDURE!,BYTE 
Atr     &Attr
Attrs &NamedNodeMap, AUTO
root        &Element,AUTO
doc     &Document,AUTO
cou         SIGNED
ln          SIGNED
cxStr       CSTRING(MAX_NAME_LEN)
xsdStr      CSTRING(MAX_NAME_LEN)
pos         SIGNED
                CODE
        doc&=SELF.xmlDoc
        IF doc&=null
            RETURN CPXMLErr:InternalError
        END 
        root&=doc.getDocumentElement()
        IF root&=null
            RETURN CPXMLErr:InternalError
        END
        xsdStr=root.getNodeName()
        pos=instring(':',xsdStr,1,1)
        IF pos = 0
            xsdStr=''
        ELSE
           xsdStr=sub(xsdStr,1,pos-1)
        END

        Attrs &= root.getAttributes()
        IF NOT Attrs &= null
                cxStr='cx' ! just default
                ln=Attrs.getLength() - 1
                !in general namespace declaration isn't attribute,
                !but after createSchema - it's attribute
                LOOP cou = 0 TO ln
                    Atr &= address(Attrs.item(cou))
                    IF CLIP(Atr.getValue())=cs:cxNS
                        cxStr=CLIP(Atr.getName())
                    END
                END
                !cut xmlns:
                cxStr=SUB(cxStr,7,len(cxStr)-6)
                SELF.xsdPrefix=xsdStr
                SELF.cxPrefix=cxStr
                Attrs.release()
        ELSE
                SELF.xsdPrefix=xsdStr
                SELF.cxPrefix='cx'
        END
        RETURN CPXMLErr:NoError
!Add the field information to the XML Schema
XMLSchema.addField  PROCEDURE(STRING label,CLType type,UNSIGNED size,UNSIGNED precision)!,BYTE
doc     &Document,AUTO
elemType    &Element,AUTO
elemRestrict    &Element,AUTO
elem        &Element,AUTO
tag         CStringClass
cs          CStringClass
root        &Element,AUTO
            CODE
            doc&=SELF.xmlDoc
            IF doc&=null
                RETURN CPXMLErr:InternalError
            END
            IF SELF.getStyle()=XMLStyle:ADO_Net
                tag.str(SELF.xsdPrefix & ':element')
            ELSE
                tag.str(SELF.xsdPrefix & ':attribute')
            END
            elemType&=doc.createElement(tag.str())
            IF elemType&=null
                RETURN CPXMLErr:InternalError   
            END
            root&=SELF.xmlRoot
            IF elemType&=null
                RETURN CPXMLErr:InternalError   
            END
            root.appendChild(elemType)
            elemType.release()  
            SELF.types.typeID=type
            get(SELF.types,SELF.types.typeID)
            IF errorcode() <> 0
                !type not found 
                RETURN CPXMLErr:IllegalType
            END
            !Name
            elemType.setAttribute(tag.str('name'),cs.str(CLIP(label)))
            !Clarion specific type
            elemType.setAttribute(tag.str(SELF.cxPrefix & ':type'),cs.str(CLIP(SELF.types.clarionType)))
            tag.str(SELF.xsdPrefix & ':simpleType')
            elem&=doc.createElement(tag.str())
            IF elem&=null
                RETURN CPXMLErr:InternalError   
            END
            elemType.appendChild(elem)
            elem.release()
            tag.str(SELF.xsdPrefix & ':restriction')
            elemRestrict&=doc.createElement(tag.str())
            IF elemRestrict&=null
                RETURN CPXMLErr:InternalError   
            END
            elem.appendChild(elemRestrict)  
            elemRestrict.release()
            tag.str('base')
            cs.str(SELF.xsdPrefix & ':' & CLIP(SELF.types.xmlTypeDp))
            elemRestrict.setAttribute(tag.str(),cs.str())
            cs.str(CLIP(SELF.types.xmlSizeDp))
            IF len(cs.str()) > 0
                !add size   
                tag.str(SELF.xsdPrefix & ':' & cs.str())
                elem&=doc.createElement(tag.str())
                IF elem&=null
                    RETURN CPXMLErr:InternalError   
                END
                elemRestrict.appendChild(elem)
                elem.release()              
                cs.str(size)
                elem.setAttribute(tag.str('value'),cs.str())
            END
            cs.str(CLIP(SELF.types.xmlPrecisionDp))
            IF len(cs.str()) > 0
                !add precision
                tag.str(SELF.xsdPrefix & ':' & cs.str())
                elem&=doc.createElement(tag.str())
                IF elem&=null
                    RETURN CPXMLErr:InternalError   
                END
                elemRestrict.appendChild(elem)
                elem.release()              
                cs.str(precision)
                elem.setAttribute(tag.str('value'),cs.str())
            END         
            RETURN CPXMLErr:NoError
!Add property set information to the XML
XMLSchema.addPropertySet    PROCEDURE(STRING tag,*PropertySet ps)!,BYTE,PRIVATE
appInfo     &Element,AUTO
doc         &Document
cs      CStringClass
tg     CStringClass
elem        &Element,AUTO
recs        SIGNED
cou     SIGNED
        CODE
        doc&=SELF.xmlDoc
        IF doc&=null
           RETURN CPXMLErr:InternalError
        END
        appInfo&=SELF.xmlAppInfo
        IF appInfo&=null
            RETURN CPXMLErr:InternalError
        END
        tg.str(cs:cxPrefix & ':' & CLIP(tag))
        elem&=doc.createElement(tg.str())
        IF elem&=null
           RETURN CPXMLErr:InternalError   
        END
        appInfo.appendChild(elem)
        elem.release()
        recs=records(ps)
        LOOP cou=1 TO recs
            get(ps,cou) 
            IF errorcode() 
                RETURN CPXMLErr:InternalError
            END
            tg.str(lower(CLIP(ps.Name)))
            cs.str(lower(CLIP(ps.Value)))
            IF (len(cs.str())>0)        
        !only not empty values are set
                elem.setAttribute(tg.str(),cs.str())
            END
        END
        RETURN CPXMLErr:NoError                 
            
!Public methods
!Constructor of the class
XMLSchema.construct PROCEDURE
            CODE
            SELF.types&=null    
            SELF.xmlDoc&=null       
            SELF.xmlAppInfo&=null   
            SELF.xmlRoot&=null
            SELF.rootTagName=''
            SELF.rowTagName=''
            SELF.xmlFields&=null
            SELF.curField&=null
            SELF.fillTypes()

!fill the queue with type information       
XMLSchema.fillTypes PROCEDURE
tq  &TypesQueue     
cou     UNSIGNED
recs    UNSIGNED
            CODE
            tq&=NEW TypesQueue()
            SELF.types&=tq
            !filling with type information
            clear(tq)
            tq.typeID=1
            tq.clarionType='byte'           
            tq.xmlTypeDp='unsignedByte'
            add(tq)
            clear(tq)
            tq.typeID=2
            tq.clarionType='short'
            tq.xmlTypeDp='short'
            add(tq)
            clear(tq)
            tq.typeID=3
            tq.clarionType='ushort'
            tq.xmlTypeDp='unsignedShort'
            add(tq)
            clear(tq)
            tq.typeID=4
            tq.clarionType='date'
            tq.xmlTypeDp='date'
            add(tq)
            clear(tq)
            tq.typeID=5
            tq.clarionType='time'
            tq.xmlTypeDp='time'
            add(tq) 
            clear(tq)
            tq.typeID=6
            tq.clarionType='long'
            tq.xmlTypeDp='long'
            add(tq) 
            clear(tq)
            tq.typeID=7
            tq.clarionType='ulong'
            tq.xmlTypeDp='unsignedLong'
            add(tq) 
                        clear(tq)
            tq.typeID=8
            tq.clarionType='sreal'
            tq.xmlTypeDp='float'
            add(tq) 
                        clear(tq)
            tq.typeID=9
            tq.clarionType='real'
            tq.xmlTypeDp='double'   
            add(tq) 
            clear(tq)
            tq.typeID=10
            tq.clarionType='decimal'
            tq.xmlTypeDp='decimal'
            tq.xmlSizeDp='totalDigits'
            tq.xmlPrecisionDp='fractionDigits'
            add(tq) 
            clear(tq)
            tq.typeID=11
            tq.clarionType='pdecimal'
            tq.xmlTypeDp='decimal'
            tq.xmlSizeDp='totalDigits'
            tq.xmlPrecisionDp='fractionDigits'
            add(tq) 
            clear(tq)
            tq.typeID=13
            tq.clarionType='bfloat4'
            tq.xmlTypeDp='float'                
            add(tq)
            clear(tq)
            tq.typeID=14
            tq.clarionType='bfloat8'
            tq.xmlTypeDp='double'
            add(tq)                     
            !clear(tq)
            !tq.typeID=15
            !tq.clarionType='ufo'
            !add(tq) 
            clear(tq)
            tq.typeID=18
            tq.clarionType='string'
            tq.xmlTypeDp='string'
            tq.xmlSizeDp='maxLength'
            add(tq) 
            clear(tq)
            tq.typeID=19
            tq.clarionType='cstring'
            tq.xmlTypeDp='string'
            tq.xmlSizeDp='maxLength'
            add(tq)                                     
            clear(tq)
            tq.typeID=20
            tq.clarionType='pstring'
            tq.xmlTypeDp='string'
            tq.xmlSizeDp='maxLength'
            add(tq) 
            !clear(tq)
            !tq.typeID=21
            !tq.clarionType='memo'
            !add(tq) 
            !clear(tq)
            !tq.typeID=22
            !tq.clarionType='group'
            !add(tq) 
            !clear(tq)
            !tq.typeID=23
            !tq.clarionType='class'
            !add(tq) 
            !clear(tq)
            !tq.typeID=26
            !tq.clarionType='queue'
            !add(tq)
            recs=records(tq)
            !make lower case 
            LOOP cou=1 TO recs      
                get(tq,cou)
                tq.xmlType=lower(tq.xmlTypeDp)
                tq.xmlSize=lower(tq.xmlSizeDp)
                tq.xmlPrecision=lower(tq.xmlPrecisionDp)
                put(tq)
            END     
    
!Destructor of the class
XMLSchema.destruct  PROCEDURE
            CODE
            SELF.close()
            IF NOT SELF.types&=null
                FREE(SELF.types)
                DISPOSE(SELF.types)
            END
!Create the schema using type information from given StructWrapper object
XMLSchema.createSchema  PROCEDURE(StructWrapper sw)!,BYTE
rc  BYTE
cou UNSIGNED    
flds    UNSIGNED
tp  BYTE
sz  UNSIGNED
prc UNSIGNED
pscou  UNSIGNED
ps     &PropertySet,AUTO    
lbl STRING(MAX_NAME_LEN)

            CODE
            rc=SELF.createSkeleton();
            IF rc<>0
                RETURN rc
            END
            rc=SELF.setPositions()
            IF rc<>0
                RETURN rc
            END
            flds=sw.getFieldsCount()
            LOOP cou=1 TO flds
                tp=sw.getFieldType(cou)
                rc=sw.getFieldSize(cou,sz,prc)
                rc=SELF.AddField(sw.getXMLFieldLabel(cou),tp,sz,prc)
                IF rc<>0
                    RETURN rc
                END             
            END
            pscou=sw.getPropertySetsCount()
            LOOP cou=1 TO pscou
               ps&=sw.getPropertySet(cou,lbl)
               IF ps&=null
                   RETURN CPXMLErr:InternalError 
               END
               rc=SELF.addPropertySet(lbl,ps)
               IF rc<>0
                    RETURN rc
               END                                          
            END
            RETURN CPXMLErr:NoError         

!Load schema from a XML file
XMLSchema.open      PROCEDURE(STRING path)!,BYTE
doc     &Document,auto
rc  BYTE
            CODE
            SELF.close   
            doc&=XMLFileToDOM(path)
            IF(doc&=null)
                return getLastError()
            END
            SELF.xmlDoc&=doc
            rc=SELF.setPositions()
            RETURN rc
!The operation destroys the underlying XML DOM object.
XMLSchema.close     PROCEDURE
            CODE            
            IF NOT SELF.xmlFields&=null
                SELF.xmlFields.release()
                SELF.xmlFields&=null
            END
            IF NOT SELF.xmlDoc&=null
                SELF.xmlDoc.release()
                SELF.xmlDoc&=null
            END
!Build Clarion's object according to the schema
XMLSchema.buildObject   PROCEDURE(StructWrapper sw)!,BYTE 
            CODE
            RETURN CPXMLErr:NotSupported
!Checks if Clarion's object structure corresponds to the given schema 
XMLSchema.checkConsistency  PROCEDURE(StructWrapper sw,UNSIGNED flags)!,BYTE
rc  BYTE
cou SIGNED
tp  CLType
tpsw    CLtype
sz  UNSIGNED
szsw    UNSIGNED
prc     UNSIGNED
prcsw   UNSIGNED
                CODE
                rc=SELF.startFieldsIterate()
                IF rc <> 0
                    RETURN rc
                END
                rc=SELF.getNextField()
                LOOP WHILE(rc = 0)
                    cou=sw.findFieldByXMLName(SELF.getFieldLabel())
                    IF cou = -1
                        IF BAND(flags,CHECK:FIELDS)
                            RETURN CPXMLErr:NoSuchField
                        END
                    ELSE
                        rc=SELF.GetFieldType(tp,sz,prc)
                        IF rc <> 0
                            RETURN rc
                        END
                        IF BAND(flags,CHECK:TYPES)
                            tpsw=sw.getFieldType(cou)
                            IF tp <> tpsw
                                RETURN CPXMLErr:IllegalType
                            END
                            IF sz > 0 !temporary
                                    rc=sw.getFieldSize(cou,szsw,prcsw)
                                IF(sz <> szsw OR prc <> prcsw)
                                    RETURN CPXMLErr:IllegalSize
                                END                 
                            END
                        END
                    END                         
                    rc=SELF.getNextField()  
                END
                IF rc <> CPXMLErr:EOS
                    RETURN rc
                END
                RETURN CPXMLErr:NoError
!Save schema to a XML file
XMLSchema.saveAs    PROCEDURE(STRING path, <*CSTRING newLine>, UNSIGNED Format = 1)!,BYTE
doc &Document,auto
cc  BYTE 
            CODE
  doc&=SELF.xmlDoc
  IF(doc&=null)
    RETURN CPXMLErr:XMLWriteFail 
  END
  if(omitted(3))
    cc = DOMToXMLFile(doc, path,, Format)
  else
    cc = DOMToXMLFile(doc, path, newLine, Format)
  end
  IF(not cc)
    RETURN CPXMLErr:XMLWriteFail  
  END         
  RETURN CPXMLErr:NoError

!Set style that is used for import/export operations.
XMLSchema.setStyle  PROCEDURE(XMLStyle style)
            CODE
                SELF.style=style    
!Returns: XMLStyle:ADO_Net; XMLStyle:ADO_26 - otherwise
XMLSchema.getStyle  PROCEDURE!, XMLStyle
            CODE
            RETURN SELF.style

!Set the root tag name
XMLSchema.setRootTagName  PROCEDURE(STRING tagName)!, BYTE
rc  BYTE
cs  CStringClass
                          CODE
  cs.str(CLIP(tagName))
  if len(cs.str()) <> 0
    rc = checkXMLName(cs.str())
    IF(rc <> 0)
      RETURN rc
    END
  end
  SELF.rootTagName = cs.str()
  RETURN CPXMLErr:NoError

! get the name of table tag
XMLSchema.getRootTagName    PROCEDURE!,STRING
                CODE
                IF(len(SELF.rootTagName)>0)
                    RETURN clip(SELF.rootTagName)
                END
                RETURN 'dataroot' !default root tag name 

!Set the name of tag that used for a row of data
XMLSchema.setRowTagName   PROCEDURE(STRING tagName)!, BYTE 
rc  BYTE
cs  CStringClass
                          CODE
  cs.str(CLIP(tagName))
  if len(cs.str()) <> 0
    rc = checkXMLName(cs.str())
    IF(rc <> 0)
      RETURN rc
    END
  end
  SELF.rowTagName = cs.str()
  RETURN CPXMLErr:NoError

!get the name of row tag
XMLSchema.getRowTagName     PROCEDURE!,STRING 
cs  CStringClass
                CODE
                IF(len(SELF.rowTagName)>0)
                        RETURN clip(SELF.rowTagName)
                END
                cs.str(toDOM:getRowLabel(SELF.style))
        RETURN cs.str()    


!=====================================EOF======================================