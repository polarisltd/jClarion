! $Header: /0192-7(XML support)/XMLSupport/src/XMLExchange.clw 67    10/23/03 2:31p Mal $
!****************************************************************************
!  FILE..........: XMLExchange.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-01 Created by Anatoly Medyntsev
!                  YYYY-MM-DD description of changes
!                   ..........
!****************************************************************************
   member

   include('XMLClass.inc'), once
   !internal functions  
   map      
createSchemaPath    PROCEDURE(string path),string
getFileName PROCEDURE(string path),string
cutExtension    PROCEDURE(string path),string
getExtension    PROCEDURE(string path),string
getDirectory    PROCEDURE(string path),string
isAbsolutePath   PROCEDURE(string path),byte
   end
!Constant string to set schema attributes
cs:xsi      cstring('xmlns:xsi')
cs:xsival   cstring('http://www.w3.org/2000/10/XMLSchema-instance')
cs:schema   cstring('xsi:noNamespaceSchemaLocation')
!attributes
cs:Version  string('1.0')
cs:AttrVer  string('XMLExchangeVersion')
cs:AttrUI   string('UserInfo')
cs:AttrTime string('TimeCreated')
cs:AttrStyle    string('XMLStyle')
cs:ADO_26   string('Attr-based')
cs:ADO_Net  string('Tag-based')
!Path support functions
createSchemaPath    PROCEDURE(string path)!,string
cs  CStringClass

            CODE
            cs.str(cutExtension(path))
            cs.str(cs.str() & '.xsd')
            return cs.str()

getFileName     PROCEDURE(string path)!,string
pos SIGNED
pos1    SIGNED
res CStringClass
ln  SIGNED
            CODE
            ln=len(path)            
            pos=instring('/',path,-1,ln)
            pos1=instring('\',path,-1,ln)            
            if pos1 > pos
                pos=pos1
            end
            pos1=instring(':',path,-1,ln)            
            if pos1 > pos
                pos=pos1
            end
            IF pos=0
                return path
            END
                res.str(sub(path,pos+1,ln-pos))
            return res.str()

cutExtension        PROCEDURE(string path)!,string
pos SIGNED
res CStringClass
ln  SIGNED
            CODE
            ln=len(path)
            pos=instring('.',path,-1,ln)
            IF pos=0
                return path
            END
            res.str(sub(path,1,pos-1))
            return res.str()


getExtension        PROCEDURE(string path)!,string
pos SIGNED
res CStringClass
ln      SIGNED
            CODE
            ln=len(path)
            pos=instring('.',path,-1,ln)
            IF pos=0
                return ''
            END
                res.str(sub(path,pos+1,ln-pos))
            return res.str()

getDirectory        PROCEDURE(string path)!,string
pos SIGNED
pos1    SIGNED
res CStringClass
ln  SIGNED
            CODE
            ln=len(path)
            pos=instring('/',path,-1,ln)
            pos1=instring('\',path,-1,ln)
            if pos1 > pos
                pos=pos1
            end
            pos1=instring(':',path,-1,ln)
            if pos1 > pos
                pos=pos1
            end
            IF pos=0
                return ''
            END
                res.str(sub(path,1,pos))
            return res.str()
isAbsolutePath   PROCEDURE(string path)!,byte
        
cs  CStringClass
pos SIGNED
        CODE
        cs.str(clip(path))      
        pos=instring(':',cs.str(),1,1)
        if pos <> 0
            return true
        end
        pos=instring('/',cs.str(),1,1)
        if pos=1
            return true
        end
        pos=instring('\',cs.str(),1,1)
        if pos=1
            return true
        end
        return false
        
!Implementation of XMLExchange class
!Constructor
XMLExchange.construct   procedure
    code
    SELF.rootTagName        = ''
    SELF.rowTagName         = ''
    SELF.xmlDocument       &= null
    SELF.xmlCurrentNode    &= null
    SELF.xmlLastAddedNode  &= null 
    SELF.navigator         &= null
    SELF.specAttrOn         = false
    SELF.schemaSupported    = false
    SELF.namespaceSupported = FALSE
    SELF.schema            &= null
    SELF.lastPath          &= NEW CStringClass()
    SELF.bCreateXml         = FALSE
    SELF.setEncoding(XMLEnc:UTF8)
!Destructor
XMLExchange.destruct    procedure
    code
    SELF.close
    if(not SELF.navigator&=null)
       dispose(SELF.navigator)  
    end
    dispose(SELF.lastPath)
    
!Closing the document (CleanUp all) 
XMLExchange.close       procedure
    code    
    SELF.bCreateXml         = FALSE
    SELF.xmlCurrentNode    &= null !release not necessary    
    SELF.xmlLastAddedNode  &= null    
    if(not SELF.xmlDocument&=null)
       SELF.xmlDocument.release
       SELF.xmlDocument&=null
    end
    if(not SELF.schema&=null)
       dispose(SELF.schema)
       SELF.schema&=null
    end
    SELF.lastPath.str('')
    
!detach the underlaying document
XMLExchange.detachDOM   procedure
doc     &Document, auto
    code
    doc&=SELF.xmlDocument
    SELF.xmlDocument&=null
    SELF.close !close but Document is not cleared
    return doc      
!attach the underlaying document       
XMLExchange.attachDOM   procedure(*Document doc)
    code
    SELF.close
    SELF.xmlDocument&=doc
    SELF.setRootAsCurrent   
!open from file
XMLExchange.open    procedure(string path)
doc     &Document,auto
    code
    SELF.close !close the previous session
    doc&=XMLFileToDOM(path)
    if(doc&=null)
       return CPXMLGetLastError()
    end
    SELF.xmlDocument&=doc
    SELF.setRootAsCurrent
    SELF.schemaSupported=false
    SELF.namespaceSupported = FALSE
    SELF.lastPath.str(path)
    return CPXMLErr:NoError      
!Create DOM data with specified schema
XMLExchange.createXML    procedure(<string schemaURL>) 
!root  &Element,auto
cs    CStringClass
  code  
    SELF.close
    SELF.bCreateXml = TRUE
    if(not omitted(2))
       SELF.setSchema(schemaURL)
    end
    SELF.schemaSupported=true
    return CPXMlErr:NoError

XMLExchange.saveAs  procedure(string path)
doc &Document,auto
cc  byte 
    code
    doc&=SELF.xmlDocument
    if(doc&=null)
       return CPXMLErr:XMLWriteFail 
    end
    cc = DOMToXMLFile(doc, path,,,SELF.encoding)
    if(not cc)
       return CPXMLErr:XMLWriteFail  
    end         
    return CPXMLErr:NoError

XMLExchange.saveAs  PROCEDURE(string path,SVMode flag, <*CSTRING newLine>, UNSIGNED Format = 1)!,byte
scpath  CStringClass
scname  CStringClass
doc     &Document,auto
rc      BYTE    
            CODE
  IF flag=SVMode:IgnoreSchema
    doc&=SELF.xmlDocument
    if(doc&=null)
       return CPXMLErr:XMLWriteFail 
    end
    if not omitted(4)
      rc = DOMToXMLFile(doc, path, newLine, Format,SELF.encoding)
    else
      rc = DOMToXMLFile(doc, path, NEWLINE_DEFAULT, Format,SELF.encoding)
    end
    if(not rc)
       return CPXMLErr:XMLWriteFail  
    end         
    return CPXMLErr:NoError
  END
  !case with schema
  IF NOT (SELF.schemaSupported AND NOT SELF.schema&=null)
      RETURN CPXMLErr:SchemaNotSupported
  END
  !create schema path
  scpath.str(createSchemaPath(path))
  scname.str(getFileName(scpath.str()))
  SELF.schema.setEncoding(SELF.encoding)
  if not omitted(4)
    rc = SELF.schema.saveAs(scpath.str(), newLine, Format)
  else
    rc = SELF.schema.saveAs(scpath.str(), NEWLINE_DEFAULT, Format)
  end
  IF rc<>0 
      RETURN rc
  END
  SELF.setSchema(scname.str())
  doc&=SELF.xmlDocument
  if(doc&=null)
     return CPXMLErr:XMLWriteFail 
  end
  if not omitted(4)
    rc = DOMToXMLFile(doc, path, newLine, Format,SELF.encoding)
  else
    rc = DOMToXMLFile(doc, path, NEWLINE_DEFAULT, Format,SELF.encoding)
  end
  if(not rc)
     return CPXMLErr:XMLWriteFail  
  end         
  return CPXMLErr:NoError

XMLExchange.setRootAsCurrent    procedure
root    &Element,auto
    code
    if(SELF.xmlDocument&=null)
       return CPXMLErr:CommonError
    end
    root&=SELF.xmlDocument.getDocumentElement()
    !if(not SELF.xmlCurrentNode&=null) release not needed
    !   SELF.xmlCurrentNode.release      
    !end
    SELF.xmlCurrentNode&=root
    return CPXMLErr:NoError
XMLExchange.setSchema   procedure(string schemaURL)
elem    &Element,auto
cs      CStringClass
    code
        elem&=SELF.xmlCurrentNode
    if(elem&=null)
       return CPXMLErr:CommonError
    end
    !cs:xsi     string('xmlns:xsi')
    !cs:xsival  string('"http://www.w3.org/2000/10/XMLSchema-instance"')  
    !cs:schema  string('xsi:noNamespaceSchemaLocation')
    elem.setAttribute(cs:xsi,cs:xsival)
    elem.setAttribute(cs:schema,cs.str(schemaURL))
    self.namespaceSupported = TRUE
    return CPXMLErr:NoError 

XMLExchange.setNamespace  PROCEDURE
root  &Element, auto
  CODE
  if self.namespaceSupported <> TRUE
    root &= SELF.xmlDocument.getDocumentElement()
    if root &= null
       return
    end
    root.setAttribute(cs:xsi, cs:xsival)
    self.namespaceSupported = TRUE
  end
  return

! get the name of table tag 
XMLExchange.getRootTagName  procedure
    code
    if(len(SELF.rootTagName)>0)
        return clip(SELF.rootTagName)
    end
    return 'dataroot' !default root tag name 
! get the name of row tag           
XMLExchange.getRowTagName   procedure
    code
    if(len(SELF.rowTagName)>0)
        return clip(SELF.rowTagName)
    end
    return toDOM:getRowLabel(SELF.style)
! set the highest-level tag name
XMLExchange.setRootTagName    procedure(string tagName)   
rc  byte
cs  CStringClass
    code
    cs.str(CLIP(tagName))
    if len(cs.str()) <> 0
      rc = checkXMLName(cs.str())
      if(rc <> 0)
         return rc
      end
    end
    SELF.rootTagName = cs.str()
    return CPXMLErr:NoError
! set the name of tag that used for a row of     data
XMLExchange.setRowTagName    procedure(string tagName)
rc  byte
cs  CStringClass
    code
    cs.str(CLIP(tagName))
    if len(cs.str()) <> 0
      rc = checkXMLName(cs.str())
      if(rc <> 0)
         return rc
      end
    end
    SELF.rowTagName = cs.str()
    return CPXMLErr:NoError
!Error function
!XMLExchange.getLastError    procedure
!    code
!    return SELF.lastError
!XMLExchange.setLastError    procedure(unsigned code)
!    code
!    SELF.lastError=code
!set XML style
XMLExchange.setStyle    procedure(XMLStyle style)
    code
    SELF.style=style
!cs:Version string('1.0')
!cs:AttrVer string('Version')
!cs:AttrUI  string('UserInfo')
!cs:AttrTime    string('TimeCreated')
!cs:AttrStyle   string('XMLStyle')
!cs:ADO_26  string('Attr-based')
!cs:ADO_Net string('Tag-based')
XMLExchange.getStyle    procedure!,XMLStyle,private !get style info from the current node
    code
    if(SELF.getAttr(cs:AttrStyle)=cs:ADO_Net)
        return XMLStyle:ADO_Net
    end 
    return XMLStyle:ADO_26  
!Set encoding 
!It can be XMLEnc:UTF8, XMLEnc:UTF16, XMLEnc:ISO88591)
XMLExchange.setEncoding    procedure(XMLEnc enc)
            CODE
            SELF.encoding=enc
XMLExchange.getEncoding    procedure
            CODE
            return SELF.encoding
!the following method work with the current node
XMLExchange.getTimeCreated  procedure!, string
    code
    return SELF.getAttr(cs:AttrTime)
XMLExchange.setTimeCreated  procedure(string dt)
    code
    SELF.setAttr(cs:AttrTime,dt)
XMLExchange.getVersion  procedure!, string
    code
    return SELF.getAttr(cs:AttrVer)
XMLExchange.setVersion  procedure(<string ver>)!,private
    code
    if(omitted(2))
       SELF.setAttr(cs:AttrVer,cs:Version)
    else
       SELF.setAttr(cs:AttrVer,ver)
    end
XMLExchange.getUserInfo procedure!, string
    code
    return SELF.getAttr(cs:AttrUI)
XMLExchange.setUserInfo procedure(string ui)
    code
    SELF.setAttr(cs:AttrUI,ui)
!set an attribute to the last added node
XMLExchange.setAttr     procedure(string atr,string val)!,private
nd  &Element,auto
cs  CStringClass
cs1 CStringClass
    code
    nd&=SELF.xmlLastAddedNode
    if(nd&=null)
       return       
    end
    nd.setAttribute(cs.str(atr),cs1.str(val))
!get an attribute value
XMLExchange.getAttr     procedure(string atr)!,string,private
nd  &Element,auto
str &cstring,auto
cs  CStringClass
    code
    nd&=SELF.xmlCurrentNode
    if(nd&=null)
       return ''        
    end
    str&=nd.getAttribute(cs.str(atr))
    if(str&=null)
       return ''    
    end
    return str 
XMLExchange.setSpecAttr procedure!,private  
nowDate long
nowTime long
tmstamp cstring(30)
    code
    SELF.setVersion()
    !set style
    if(SELF.style=XMLStyle:ADO_26)
       SELF.setAttr(cs:AttrStyle,cs:ADO_26)
    else
       SELF.setAttr(cs:AttrStyle,cs:ADO_Net)
    end
    !set time stamp
    nowDate=today()
    nowTime=clock()
    tmstamp=format(nowDate,'@D10') & ' ' & format(nowTime,'@T4')
    SELF.setAttr(cs:AttrTime,tmstamp)

XMLExchange.setNode procedure(*Element nd)
    code
    !nd.AddRef() not necessary - the node is part of doc
    !if(not SELF.xmlCurrentNode&=null) release not necessary
    !   SELF.xmlCurrentNode.release
    !end
    SELF.xmlCurrentNode&=nd              
!get the pointer to the XMLNavigator object
XMLExchange.getNavigator     procedure!, *XMLNavigator
nv  &XMLNavigator, auto
    code
    if(SELF.navigator&=null)
       !Create new
       nv&=new(XMLNavigator)
       if(nv&=null)
          return null
       end
       nv.init(SELF)                
       SELF.navigator&=nv
    end
    SELF.navigator.getXMLExchangeNode()
    return SELF.navigator
        

!return the current node
XMLExchange.getNode procedure!,*Element
    code
    return SELF.xmlCurrentNode
!set specAttrOn flag
XMLExchange.setSpecAttrOn procedure(byte flag=true)
    code
    SELF.specAttrOn=flag
!Get pointer to the underlaying document
XMLExchange.getDocument  procedure!,*Document
    code
    return SELF.xmlDocument
! set the maximum number of rows to be retrieved
XMLExchange.setMaxRowCount  procedure(unsigned maxCou) 
    code
    if(maxCou<0)
       return CPXMLErr:IllegalParameter
    else
       SELF.maxRowCount=maxCou
       return CPXMLErr:NoError  
    end 

!Load data from a Clarion's structure. If some data has been loaded before the method just 
!append new data to the existent one. You can select XML node (setNode method) and specify 
!positionFlag to point at position where the data should be loaded to
!positionFlag can be following: 
!XMLPos:APPEND_CHILD (data will be appended as child node relatively !to the current node) or
!XMLPos:APPEND_SIBLING (data will be appended as next sibling node relatively 
!to the current node). The new node will have the name nodeName.
XMLExchange.toXML       procedure(StructWrapper sw, <string nodeName>,byte positionFlag=XMLPos:APPEND)
!col unsigned, auto
doc       &Document, auto
root      &Element, auto
rowE      &Element, auto
tableE    &Element, auto
labelStr  CStringClass
!cc       byte
cou       unsigned, auto
cs        CStringClass
hrm       XMLHRManager
hrElem    &XMLHRElem, auto
rc        signed
rcb       byte
schema    &XMLSchema
rt        CStringClass
rtreal    CStringClass
row       CStringClass
    code
    ! test if exist node name
    if omitted(3)
      rt.str(clip(sw.getRootTagName()))
      ! test if exist root tag name
      if len(rt.str()) = 0 then
        rt.str(self.getRootTagName())
      end
    else
      rt.str(nodeName)
    end
    if(positionFlag=XMLPos:APPEND)
       rtreal.str(rt.str())
    else
       rtreal.str(self.getRootTagName())
    end
    ! test if exist xml document
    if self.bCreateXml = TRUE then
      doc &= createDocumentFromXml(cs.str('<<' & rtreal.str() & '/>'))
      if doc &= null
        return CPXMLErr:CreateDOMFail               
      end 
      SELF.xmlDocument&=doc    
      SELF.setRootAsCurrent
      SELF.bCreateXml = FALSE
    else
      if(positionFlag=XMLPos:APPEND) 
         ! test current node name
         if self.xmlCurrentNode.getNodeName() <> rt.str()
            return CPXMLErr:InvalidNodeName
         end
      end
    end
    !assign label that is used for tag corresponding to data
    doc &= SELF.xmlDocument
    if doc &= null
        return CPXMLErr:CreateDOMFail
    end
    root &= SELF.xmlCurrentNode
    if(root&=null)
        return CPXMLErr:CreateDOMFail       
    end
    labelStr.str(rt.str())
    if(positionFlag=XMLPos:APPEND)
      !Append data to the root node
      !Schema related operations   
      if NOT SELF.schema&=null
        SELF.schemaSupported=false 
      end
      if SELF.schemaSupported
        schema&=NEW XMLSchema
        if schema&=null
          return CPXMLErr:InternalError
        end
        schema.setStyle(SELF.style)
        ! get row name
        row.str(clip(sw.getRowTagName()))
        if len(row.str()) = 0 then
          row.str(SELF.getRowTagName())
        end
        rc = schema.setRowTagName(row.str())
        if rc <> CPXMLErr:NoError
          return rc
        end
        rc = schema.setRootTagName(rt.str())
        if rc <> CPXMLErr:NoError
          return rc
        end
        rc = schema.createSchema(sw)
        if rc=0
          SELF.schema&=schema
        else
          dispose(schema)
          SELF.schemaSupported=false        
        end                      
      end  
      tableE&=root
      tableE.addRef()           
    else
       !APPEND_CHILD case   
       !Create root node for data and append it
       SELF.schemaSupported=false       
       rc=checkXMLName(CLIP(labelStr.str()))
       if(rc<>0)
          return rc
       end
       tableE &= doc.createElement(labelStr.str())
       if(tableE&=null)
          return CPXMLErr:CreateDOMFail          
       end    
       root.appendChild(tableE) !probably should use the returned value?
    end
    if(sw.getFirstChild()&=null)
       !simple case
        sw.startIterate()
        cou=0
        rc=sw.getNextRow()
        loop while(rc=0 and (SELF.maxRowCount=0 or cou<SELF.maxRowCount))
            rowE &= SELF.AddRow(sw,tableE,rcb)
            if(rowE&=null)
                tableE.release
                return CPXMLErr:CreateDOMFail                
            end
            rowE.release()
            if rcb <> 0
                tableE.release
                return rcb
            end
            cou=cou+1
            rc=sw.getNextRow()
        end
    if(rc<>0 and rc <> CPXMLErr:EOF)
       tableE.release
       return rc   
    end
    else
       SELF.schemaSupported=false   
       !hierarchical case
       sw.startIterate()
       rc=sw.getNextRow()
       if(rc<>0)
          tableE.release
          return CPXMLErr:CreateDOMFail          
       end
       hrElem&=null
       hrElem&=hrm.init(sw,hrElem)
       if(hrElem&=null)
          tableE.release
          return CPXMLErr:CreateDOMFail          
       end
       hrElem.nd&=tableE
       rcb=0    
       rc=SELF.toXMLTree(hrm,1,rcb)
       if(rc<0)
          tableE.release
          if(rcb=0)  
            return CPXMLErr:CreateDOMFail
          else  
            return rcb
          end
       end
    end
    SELF.setLastAdded(tableE)   
    tableE.release
    if(SELF.specAttrOn)
       SELF.setSpecAttr()
    end
    return CPXMLErr:NoError
    

!Put the data from the DOM Document object to a Clarion's object. You can select necessary
!XML node for this operation with setNode method.
XMLExchange.fromXML     procedure(StructWrapper sw)
root      &Element, auto
RowENode  &Element, auto
Rows      &NodeList, auto
row       unsigned, auto
numRows   unsigned, auto
cp        signed, auto
cs        CStringClass
labelStr  CStringClass
cc        byte
rc        signed
parentNd  &Node, auto

    code
    root&=SELF.xmlCurrentNode
    if(root&=null)
       return CPXMLErr:ImportFail         
    end  
    cs.str(clip(sw.getRowTagName()))
    ! test if exist row tag name
    if len(cs.str()) = 0 then
      cs.str(self.getRowTagName())
    end
    Rows &= root.getElementsByTagName(cs.str())!Get rows
    RowENode &= null
    if not Rows &= null
       numRows=Rows.getLength()-1
       cp=sw.getCapacity()
       if(cp <> -1 and cp <> 0)
          cp=cp-1                             
          numRows=choose(cp>numRows,numRows,cp) 
       end     
       loop row = 0 to numRows         
         RowENode &= address(Rows.item(row))
         parentNd&=RowENode.getParentNode()
         if(not parentNd&=root)
            cycle
         end     
         !assign data to a record
         sw.clearBuffer()                     
         cc=SELF.AssignCols(RowENode, SELF.style, sw)
         if(cc) 
            rc=sw.addRow()!add the record to the structure was cc= but it's procedure
            if(rc<>0)
               Rows.release()
               return rc
            end
         else
             Rows.release()
             return CPXMLErr:ImportFail
         end             
       end
       Rows.release()
    end
    return CPXMLErr:NoError

XMLExchange.fromXML PROCEDURE(StructWrapper sw, FXMode flag)!,byte
scpath      CStringClass
checkFlags  UNSIGNED    
rc      BYTE
schema      XMLSchema                   
            CODE
            IF BAND(flag,FXMode:IgnoreSchema)
                RETURN SELF.fromXML(sw)
            END            
            !VerifyBySchema case
            checkFlags=BAND(flag,CHECK:MASK)
            IF checkFlags=0
                checkFlags=CHECK:TYPES
            END
            scpath.str(SELF.getSchemaPath())            
            schema.setStyle(SELF.style)         
            rc=schema.open(scpath.str())
            IF rc <> 0 
                RETURN rc
            END
            rc=schema.checkConsistency(sw,checkFlags)
            IF rc <> 0 
                RETURN CPXMLErr:CheckFail
            END
            RETURN SELF.fromXML(sw) 
            

!Assign value to the structure
XMLExchange.AssignCols  procedure(*Element rowE,XMLStyle style, StructWrapper sw)
Cols &NodeList, auto
Attrs &NamedNodeMap, auto
col unsigned, auto
colE &Element, auto
colA &Attr, auto
TNode &Text, auto
rc    unsigned
!sName cstring(MAX_NAME_LEN)
!ListOfNames  queue     !List of field names already used (not used now)
!Name        cstring(MAX_NAME_LEN)
!            end
    code
    case style
    of XMLStyle:ADO_26
           !Attribute-based style
       Attrs &= rowE.getAttributes()
       if not Attrs &= null
          loop col = 0 to Attrs.getLength() - 1
             colA &= address(Attrs.item(col))        
             !Test for duplicate now not supported so far see fromDOM:AppendCols
             rc=sw.setFieldValueByXMLName(colA.getName(), colA.getValue())               
          end
          Attrs.release()
       end
    of DOMStyle:ADO_Net
       !Tag-based style
       Cols &= rowE.getChildNodes()
       if not Cols &= null
          loop col = 0 to Cols.getLength() - 1
            colE &= address(Cols.item(col))
            TNode &= address(colE.getFirstChild())
            if not TNode &= null          
              if colE.getAttribute(e:XsiType) = e:Base64 then
                rc=sw.setFieldValueByXMLName(colE.getTagName(), FromBase64(clip(TNode.GetData())))
              elsif TNode.getNodeType() = Node:CDATA_SECTION then
                rc=sw.setFieldValueByXMLName(colE.getTagName(), TNode.GetData())
              else
                !Test for duplicate not supported here see fromDOM:AppendCols
                rc=sw.setFieldValueByXMLName(colE.getTagName(), TNode.GetData())
              end
            end
          end
          Cols.release()
       end
    else
       assert(false, '<13,10>Unknown DOMStyle:  ' & style)
       return false
    end
    return true
!Set last added node pointer
XMLExchange.setLastAdded    procedure(*Element elem)
    code
    !if(not SELF.xmlLastAddedNode &=null) Release not needed: part of doc 
    !   SELF.xmlLastAddedNode.release       
    !end
    !elem.AddRef()
    SELF.xmlLastAddedNode&=elem
XMLExchange.setLastAddedAsCurrent procedure
    code
    if(SELF.xmlLastAddedNode &=null)
       return CPXMLErr:CommonError    
    end
    SELF.setNode(SELF.xmlLastAddedNode)
    return CPXMLErr:NoError
!inner method to export tree-like structure
!lvl - number of part
!elem - DOM element to export data to
XMLExchange.toXMLTree   procedure(XMLHRManager hrm,signed lvl,*BYTE brc)

rowElem     &Element, auto
curNode        &Element, auto
sw      &StructWrapper, auto
hrElem      &XMLHRElem, auto
maxLvl      signed
chaLvl      signed
rc      signed !return code
rcb     byte

    code    
    hrElem&=hrm.getElem(lvl)
    sw&=hrElem.sw
    curNode&=hrElem.nd
    maxLvl=hrm.elems()  
    rc=0 !here the row is gotten already            
    loop while(rc=0)
         !add new row of the level
         if(not curNode&=null)
            rowElem&=SELF.AddRow(sw,curNode,rcb)
            if(rowElem&=null)
                return -2! error
            end
            if rcb <> 0
                brc=rcb
                return -2!error
            end
         else
            !if the node isn't assigned just iterate through rows
            rowElem&=null
         end
         hrElem.clearChangedFlg() !update position
         if(maxLvl=lvl)
            if(not rowElem&=null)
               rowElem.release !not used here
            end
            rc=sw.getNextRow()
            if(rc=0)
               chaLvl=hrm.lowChangeIdx()
               if(chaLvl<lvl)
                  hrElem.close()            
                  return chaLvl             
               end
            end
         else
            !highest level
            if(not rowElem&=null)
               rc=SELF.CreateChildElems(hrElem,rowElem)
               rowElem.release
               if(rc<>0)
                  return -3! error
               end
            end
            chaLvl=SELF.toXMLTree(hrm,lvl+1,brc)
            if(chaLvl<lvl)
               hrElem.close()           
               return chaLvl !go up             
            end
            rc=0
         end        
    end
    return 0 !OK all finished (EOF) 
XMLExchange.CreateChildElems    procedure(*XMLHRElem hrElem,*Element rowElem)
!idx     signed
cou     signed
elemName    cstring(MAX_NAME_LEN)
curElem     &XMLHRElem, auto    
labelStr    CStringClass
tableE      &Element, auto
doc         &Document, auto
    code
    doc&=SELF.xmlDocument
    elemName=hrElem.getName()
    curElem&=hrElem.hrChild
    cou=1
    loop while(not curElem&=null)
       labelStr.str(elemName & '_' & cou)
       tableE &= doc.createElement(labelStr.str())
           if(tableE&=null)
              return CPXMLErr:CreateDOMFail              
           end    
           rowElem.appendChild(tableE) 
       curElem.close()
       curElem.nd&=tableE!reopen        
       curElem&=curElem.hrNext
       cou+=1          
    end
    return CPXMLErr:NoError
XMLExchange.AddRow  procedure(StructWrapper sw,*Element tableE, *byte rc)
rowE    &Element, auto
col     signed, auto
doc     &Document, auto
cs      CStringClass
row     CStringClass
      CODE
      doc&=SELF.xmlDocument
      row.str(clip(sw.getRowTagName()))
      if len(row.str()) = 0 then
        rowE &= doc.createElement(cs.str(SELF.getRowTagName()))
      else
        rowE &= doc.createElement(cs.str(row.str()))
      end
      if(rowE&=null)
        return null
      end
      tableE.appendChild(rowE)
      loop col = 1 to sw.getFieldsCount()
        !Append data for the column
        rc = toDom:AppendCol(self, doc, rowE, sw, col, SELF.style)
      end
      return rowE

!get full path to the schema
XMLExchange.getSchemaPath   PROCEDURE!,STRING
cs  CStringClass
path    CStringClass
                CODE        
                cs.str(SELF.getAttr(cs:schema))
        if isAbsolutePath(cs.str())
            return cs.str()
        end
                path.str(getDirectory(SELF.lastPath.str()))
                cs.str(path.str() & cs.str())
                return cs.str()
