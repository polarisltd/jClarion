! $Header: /0192-7(XML support)/XMLSupport/src/cpxml.clw 51    10/21/03 1:28p Mal $
!****************************************************************************
!  FILE..........: cpxml.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-03-07 Modifyed by Anatoly Medyntsev
!                  YYYY-MM-DD description of changes
!                   ..........
!****************************************************************************
  member

  include('XMLClass.inc'), once

  map
fixCRLF               PROCEDURE(string xml), string
fromDOM:AppendCols    PROCEDURE(*Element rowE, DOMStyle style, *ReflectionClass gr,<MapQueue nameMap>),byte
!toDOM:getTableLabel   PROCEDURE(DOMStyle style), *cstring
!toDOM:getRowLabel     PROCEDURE(DOMStyle style), *cstring
toDOM:CreateEmptyDOM  PROCEDURE(DOMStyle style), *Document
Take24                PROCEDURE(byte h,byte m,byte l,*string Into)
Take32                PROCEDURE(*byte h,*byte m,*byte l,*string SFrom),proc,byte
TranslateName         PROCEDURE(string sFrom,<MapQueue nameMap>,byte bToXML=true),string
IsCorrectName         PROCEDURE(string sName),byte
PrepareMapQueue       PROCEDURE(MapQueue que),byte
WrapperToDOM          PROCEDURE(StructWrapper sw, *string root, *string label, DOMStyle style = DOMStyle:ADO_26,*MapQueue nameMap,unsigned maxRow=0),*Document
DOMToWrapper          PROCEDURE(*Document doc, StructWrapper sw, *string root, *string label, DOMStyle style=DOMStyle:ADO_26,*MapQueue nameMap),byte
  end

  include('abWindow.inc'), once
  include('abResize.inc'), once
  include('DynStr.inc'), once

cs:NewDataSet cstring('NewDataSet')
cs:Table cstring('Table')
cs:RSData cstring('data') ![MAL] was rs:data
cs:ZRow cstring('row')    ![MAL] was rs:row
Encode STRING('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=')
CPXMLLastErrorCode      long,thread
!===  VLBWindowManager  ========
VLBWindowManager        class(WindowManager), type
VLBProc                   procedure(long row, short col), string, virtual, proc
                        end

VLBWindowManager.VLBProc procedure(long row, short col)

  code
  return ''
!==== Error support functions
CPXMLGetLastError                procedure
    code
    return CPXMLLastErrorCode
CPXMLSetLastError                procedure(long errno)
    code
    CPXMLLastErrorCode=errno
!===  XMLString  ========
XMLStringToDOM procedure(string xml)

cs CStringClass

  code
  return CreateDocumentFromXML(cs.str(xml))

DOMToXMLString procedure(*Document doc, <*CSTRING newLine>, unsigned Format = Format:AS_IS)

domW &DOMWriter, auto
xml any

  code
  assert(not doc &= null)
  domW &= CreateDOMWriter()
  if omitted(2)
    domW.setNewline(NEWLINE_DEFAULT)
  else
    domW.setNewline(newLine)
  end
  domW.setFormat(Format)
  xml = domW.writeNode(doc)
  DestroyDOMWriter(domW)
  return xml
!===  TranslateName =====
!Translation function
!Translate sFrom according to nameMap;if bToXML=true - from XML otherwise to XML
TranslateName procedure(string sFrom,<MapQueue nameMap>,byte bToXML=true)
err long      
   code
   if(omitted(2))
      return lower(sFrom)
   end
   if(bToXML)
      nameMap.ClarionName=lower(sFrom)
      get(nameMap,nameMap.ClarionName)
      err=errorcode()
      if(err <> 0)
        return lower(sFrom)
      end
      return nameMap.XMLName
   else
      nameMap.XMLName=sFrom
      get(nameMap,nameMap.XMLName)
      err=errorcode()
      if(err <> 0 AND err <> 43) !if 43 then record already held
     return lower(sFrom)
      end
      return nameMap.ClarionName
   end
!=====IsCorrectName=====
!Test a name for XML-correctness
!return false if not correct
IsCorrectName   procedure(string sName)
pos     signed
        code
        pos=instring(' ',clip(sName))
        if(pos>0)
           return false
        end
        return true
checkXMLName PROCEDURE(STRING xmlName)
bRet    BYTE(CPXMLErr:IllegalParameter)
ln      UNSIGNED
c       STRING(1)
delim   BYTE

    CODE
    ln = LEN(xmlName);
    if (ln = 0)
        return bRet
    END

    LOOP I# = 1 TO ln
        c = xmlName[I#]
        if (I# = 1)
            if (match(c, '[A-Z]', Match:Regular) = false AND match(c, '[a-z]', Match:Regular) = false)
                return bRet
            END
            delim  = false;
        END

        if (I# = ln)
            if (match(c, '[A-Z]', Match:Regular) = false AND match(c, '[a-z]', Match:Regular) = false AND match(c, '[0-9]', Match:Regular) = false AND c <> '_')
                return bRet
            END
        END

        if (I# > 1 AND I# < ln)
            if (delim = false)
                delim = match(c, '[-.:]', Match:Regular)
            ELSIF (match(c, '[-.:]', Match:Regular) = true)
                return bRet
            ELSE
                delim = false;
            END

            if (delim = false)
                if (match(c, '[A-Z]', Match:Regular) = false AND match(c, '[a-z]', Match:Regular) = false AND match(c, '[0-9]', Match:Regular) = false AND c <> '_')
                    return bRet
                END
            END
        END
    END

    RETURN CPXMLErr:NoError
!---Remove trailing nulls
clipNull     PROCEDURE(STRING str)!, STRING
i      LONG           
             CODE
             LOOP i= LEN(str) TO 1 BY -1
                IF str[i] ~= CHR(0)
                    BREAK
                END
             END
             RETURN sub(str,1,i)
!get child element for the specified node
getFirstChildElem   PROCEDURE(*Node nd)
child   &Node
tp      LONG
                    CODE
                    child&=nd.getFirstChild()
                    IF(child&=null)
                        RETURN null
                    END
                    tp=child.getNodeType()
                    IF(tp = Node:ELEMENT)
                        RETURN child
                    END
                    RETURN getNextSiblingElem(child)

!get sibling element for the specified node                    
getNextSiblingElem  PROCEDURE(*Node nd)
sibl    &Node
tp      LONG
                    CODE
                    sibl&=nd.getNextSibling()
                    IF(sibl&=null)
                        RETURN null
                    END
                    tp=sibl.getNodeType()
                    IF(tp = Node:ELEMENT)
                        RETURN sibl
                    END
                    RETURN getNextSiblingElem(sibl)
!=====PrepareMapQueue====
!***Convert ClarionName to lowercase
!**Test if no duplicate
!**Test XML name for correctness
!**return: true if successful; false- otherwise
PrepareMapQueue    procedure(MapQueue que)
sPrevEntry         cstring(MAX_NAME_LEN)
row                long
cc                 byte
    code
    sPrevEntry=''
    sort(que,que.ClarionName)
    !**Test for duplicate
    loop row = 1 to records(que)
        get(que, row)
        if clip(que.ClarionName)=clip(sPrevEntry)
       !if duplicate name found 
           CPXMLSetLastError(CPXMLErr:DuplicateName)
           return false
        end
        cc=IsCorrectName(que.XMLName)!test the XML name for correctness
        if(not cc)
          CPXMLSetLastError(CPXMLErr:IllegalName)
          return false
        end
        sPrevEntry=que.ClarionName
    end
    sort(que,que.XMLName)
    loop row = 1 to records(que)
        get(que, row)
        if clip(que.XMLName)=clip(sPrevEntry)
       !if duplicate name found 
           CPXMLSetLastError(CPXMLErr:DuplicateName)
           return false
        end
        que.ClarionName=lower(que.ClarionName) !ClarionName to lower case
        put(que)
        sPrevEntry=que.XMLName
    end
    CPXMLSetLastError(CPXMLErr:NoError)
    return true
!===  XMLFILE  ========
XMLFileToDOM procedure(string path)

cs CStringClass
doc &Document,auto
  code
  doc&=CreateDocumentFromFile(cs.str(path))
  if(doc&=null)
     CPXMLSetLastError(CPXMLErr:XMLReadFail)
     return null
  else
     CPXMLSetLastError(CPXMLErr:NoError)
     return doc
  end
DOMToXMLFile procedure(*Document doc, string path, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS)
ret         BYTE
            CODE
            IF omitted(3)
                ret=DOMToXMLFile(doc,path,,Format,XMLEnc:UTF8)
            ELSE
                ret=DOMToXMLFile(doc,path,newLine,Format,XMLEnc:UTF8)
            END
            RETURN ret
DOMToXMLFile procedure(*Document doc, string path, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS, XMLEnc enc)

domW &DOMWriter, auto
cs CStringClass
cc byte

  code
  domW &= CreateDOMWriter()
  if omitted(3)
    domW.setNewline(NEWLINE_DEFAULT)
  else
    domW.setNewline(newLine)
  end
  domW.setFormat(Format)
  domW.setEncoding(cs.str(enc))
  cc=domW.writeNode(cs.str(path), doc)
  DestroyDOMWriter(domW)
  if(cc)
    CPXMLSetLastError(CPXMLErr:NoError)
  else
    CPXMLSetLastError(CPXMLErr:XMLWriteFail)
  end
  return cc

!===  for any wrapper
WrapperToDOM  PROCEDURE(StructWrapper sw, *string root, *string label, DOMStyle style = DOMStyle:ADO_26,*MapQueue nameMap,unsigned maxRow=0)
xmlEx   XMLExchange
doc     &Document, auto
rc      signed
rt      &string
lbl     &string
              CODE
  if(not nameMap &= null)
    rc = sw.setNameMap(nameMap)
    if(rc<>0)
      CPXMLSetLastError(rc)
      return null
    end
  end
  xmlEx.setStyle(style)
  lbl &= label
  if(not lbl &= null)
    if (xmlEx.setRowTagName(label) <> 0)
      return null
    end
  end
  rt &= root
  if(not rt &= null)
    if (xmlEx.setRootTagName(rt) <> 0)
      return null
    end
  end
  if (xmlEx.setMaxRowCount(maxRow) <> 0)
    return null
  end
  rc = xmlEx.createXML()
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null
  end
  rc = xmlEx.toXML(sw)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null
  end
  doc &= xmlEx.detachDOM()
  return doc

DOMToWrapper  PROCEDURE(*Document doc, StructWrapper sw, *string root,*string label, DOMStyle style=DOMStyle:ADO_26,*MapQueue nameMap)
xmlEx   XMLExchange
rc      signed
rt      &string
lbl     &string
dc      &Document
              CODE
  if(not nameMap &= null)
    rc = sw.setNameMap(nameMap)
    if(rc<>0)
      CPXMLSetLastError(rc)
      return false
    end
  end
  xmlEx.attachDOM(doc)
  xmlEx.setStyle(style)
  lbl &= label
  if(not lbl &= null)
    rc = xmlEx.setRowTagName(label)
    if(rc<>0)
      CPXMLSetLastError(rc)
      dc &= xmlEx.detachDOM()
      return false
    end
  end
  rt &= root
  if(not rt &= null)
    rc = xmlEx.setRootTagName(rt)
    if(rc<>0)
      CPXMLSetLastError(rc)
      dc &= xmlEx.detachDOM()
      return false
    end
  end
  rc = xmlEx.fromXML(sw)
  if(rc<>0)
    CPXMLSetLastError(rc)
    dc &= xmlEx.detachDOM()
    return false
  end
  CPXMLSetLastError(CPXMLErr:NoError)
  dc &= xmlEx.detachDOM()
  return true

!===  QUEUE  ========
QueueToDOM  PROCEDURE(*queue q, <string root>,<string label>, DOMStyle style = DOMStyle:ADO_26, byte removePrefix = true,<MapQueue nameMap>)
qw    QueueWrapper
doc   &Document, auto
rc    signed
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = qw.init(q,removePrefix)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(3))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(2))
    rt &= root
  else
    rt &= null
  end
  doc &= WrapperToDom(qw,rt,lbl,style,map)
  return doc

DOMToQueue  PROCEDURE(*Document doc, *queue q, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26,<MapQueue nameMap>)
qw    QueueWrapper
rc    signed
cc    byte
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = qw.init(q)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return false        
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null    
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null    
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToWrapper(doc,qw,rt,lbl,style,map)
  return cc

!===  FILE  ========
FileToDOM   PROCEDURE(*file f, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26, byte removePrefix = true,<MapQueue nameMap>)
fw    FileWrapper
doc   &Document, auto
rc    signed
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = fw.init(f,removePrefix)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null        
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(3))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(2))
    rt &= root
  else
    rt &= null
  end
  doc &= WrapperToDom(fw,rt,lbl,style,map)
  return doc  

DOMToFile PROCEDURE(*Document doc, *file f, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26,<MapQueue nameMap>)
fw    FileWrapper
rc    signed
cc    byte
map   &MapQueue
rt    &string
lbl   &string
          CODE
  rc = fw.init(f)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return false        
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToWrapper(doc,fw,rt,lbl,style,map)
  return cc

!===  VIEW  ========
ViewToDOM   PROCEDURE(*view v, <string root>,<string label>, DOMStyle style=DOMStyle:ADO_26, byte removePrefix = true,<MapQueue nameMap>,unsigned maxRowCount = 0)
vw    ViewWrapper
doc   &Document, auto
rc    signed
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = vw.init(v,removePrefix)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(3))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(2))
    rt &= root
  else
    rt &= null
  end
  doc &= WrapperToDom(vw,rt,lbl,style,map,maxRowCount)
  return doc

!====GROUP==========
!Translation from Group to DOM
GroupToDOM  PROCEDURE(*group gr, <string root>,<string label>,DOMStyle style=DOMStyle:ADO_26,byte removePrefix = true, <MapQueue nameMap>)
gw    GroupWrapper
doc   &Document, auto
rc    signed
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = gw.init(gr,removePrefix)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return null        
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(3))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(2))
    rt &= root
  else
    rt &= null
  end
  doc &= WrapperToDom(gw,rt,lbl,style,map)
  return doc

DOMToGroup  PROCEDURE(*Document doc, *group gr, <string root>,<string label>,DOMStyle style=DOMStyle:ADO_26, <MapQueue nameMap>)
gw    GroupWrapper
rc    signed
cc    byte
map   &MapQueue
rt    &string
lbl   &string
            CODE
  rc = gw.init(gr)
  if(rc<>0)
    CPXMLSetLastError(rc)
    return false        
  end
  if(not omitted(6))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToWrapper(doc,gw,rt,lbl,style,map)
  return cc

!====Wrapper functions======[MAL]
!=====ToXMLFile======
!Translation FILE, QUEUE, VIEW, GROUP to XML file
ToXMLFile   PROCEDURE(*file fl, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  fileDoc &= FileToDOM(fl,rt,lbl,style,true,map)
  if(fileDoc &= null)
     return false
  end
  !write data to the specifyed file
  if(omitted(7))
    cc = DOMToXMLFile(fileDoc, path,, Format)
  else
    cc = DOMToXMLFile(fileDoc, path, newLine, Format)
  end 
  fileDoc.release()
  return cc

ToXMLFile   PROCEDURE(*queue que, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  fileDoc &= QueueToDOM(que,rt,lbl,style,true,map)
  if(fileDoc &= null)
    return false
  end
  !write data to the file
  if(omitted(7))
    cc = DOMToXMLFile(fileDoc, path,, Format)
  else
    cc = DOMToXMLFile(fileDoc, path, newLine, Format)
  end 
  fileDoc.release()
  return cc

ToXMLFile   PROCEDURE(*view vw, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  fileDoc &= ViewToDOM(vw,rt,lbl,style,true,map)
  if(fileDoc &= null)
     return false
  end
  !write data to the file
  if(omitted(7))
    cc = DOMToXMLFile(fileDoc, path,, Format)
  else
    cc = DOMToXMLFile(fileDoc, path, newLine, Format)
  end 
  fileDoc.release()
  return cc

ToXMLFile   PROCEDURE(*group gr, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26, <*CSTRING newLine>, UNSIGNED Format = Format:AS_IS)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  fileDoc &= GroupToDOM(gr,rt,lbl,style,true,map)
  if(fileDoc &= null)
     return false
  end
  !write data to the file
  if(omitted(7))
    cc = DOMToXMLFile(fileDoc, path,, Format)
  else
    cc = DOMToXMLFile(fileDoc, path, newLine, Format)
  end 
  fileDoc.release()
  return cc

MapQueueToXMLFile PROCEDURE(*MapQueue map, string path, string root, string label, <*CSTRING newLine>, UNSIGNED Format = 1)
rc      byte
xmlnm   XMLNameMap
                  CODE
  rc = xmlnm.load(map)
  if rc <> 0
    return rc
  end
  rc = xmlnm.setRootTagName(root)
  if rc <> 0
    return rc
  end
  rc = xmlnm.setRowTagName(label)
  if rc <> 0
    return rc
  end
  if(omitted(5))
    rc = xmlnm.saveAs(path,, Format)
  else
    rc = xmlnm.saveAs(path, newLine, Format)
  end
  if rc <> 0
    return rc
  end
  return CPXMLErr:NoError

!=====FromXMLFile======
!Translation from XML file to FILE, QUEUE, VIEW, GROUP 
FromXMLFile PROCEDURE(*file fl, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  fileDoc &= XMLFileToDOM(path)!read data from the file
  if(fileDoc &= null)
    return false
  end
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToFile(fileDoc,fl,rt,lbl,style,map)
  fileDoc.release()
  return cc

FromXMLFile PROCEDURE(*queue que, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  fileDoc &= XMLFileToDOM(path)!read data from the file
  if(fileDoc &= null)
    return false
  end
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToQueue(fileDoc,que,rt,lbl,style,map)
  fileDoc.release()
  return cc

FromXMLFile PROCEDURE(*group gr, string path,<string root>,<string label>,<MapQueue nameMap>,DOMStyle style=DOMStyle:ADO_26)
fileDoc &Document, auto
cc      byte
map     &MapQueue
rt      &string
lbl     &string
            CODE
  fileDoc &= XMLFileToDOM(path)!read data from the file
  if(fileDoc &= null)
    return false
  end
  if(not omitted(5))
    map &= nameMap
  else
    map &= null
  end 
  if(not omitted(4))
    lbl &= label
  else
    lbl &= null
  end
  if(not omitted(3))
    rt &= root
  else
    rt &= null
  end
  cc = DOMToGroup(fileDoc,gr,rt,lbl,style,map)
  fileDoc.release()
  return cc

XMLFileToMapQueue PROCEDURE(string path, *MapQueue map, *string root, *string label)
rc      byte
xmlnm   XMLNameMap
                  CODE
  rc = xmlnm.open(path, map)
  if rc <> 0
    return rc
  end
  root  = xmlnm.getRootTagName()
  label = xmlnm.getRowTagName()
  return CPXMLErr:NoError

!===  ====  ========
FillDOMQueue  PROCEDURE(*Node n, *DOMQueue q, unsigned level=1)
nl &NodeList, auto
childIndex unsigned, auto
              CODE
  assert(not n &= null)
  assert(not q &= null)
  q.node &= n
  q.level = level
  add(q)
  nl &= n.getChildNodes()
  assert(not nl &= null)
  loop childIndex = 0 to nl.getLength() - 1
    FillDOMQueue(nl.item(childIndex), q, level + 1)
  end
  nl.release()

!===  ====  ========
ViewXml PROCEDURE(string xml)
doc &Document, auto
        CODE
  doc &= XMLStringToDOM(xml)
  if not doc &= null
    viewXML(doc)
    doc.release()
  end

ViewXml procedure(*Node root)

ListXML                 queue(DOMQueue)
                        end

Window WINDOW('XML'),AT(,,530,350),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM, |
         GRAY,MAX,RESIZE
       SHEET,AT(2,2,526,346),USE(?Sheet)
         TAB('XML REFORMATTED'),USE(?TabReformatted)
           TEXT,AT(4,17,522,329),USE(?TextReformatted),HVSCROLL
         END
         TAB('DOM Tree'),USE(?TabDom)
           LIST,AT(4,17,522,329),USE(?List),HVSCROLL,FORMAT('100L(2)|MT~Type~@s16@100L(2)|M~Name~@s255@100L(2)|M~Value~@s255@100L(2)~Attribut' &|
               'es~@s255@')
         END
         TAB('XML AS_IS'),USE(?TabAsIs)
           TEXT,AT(4,17,522,329),USE(?TextAsIs),HVSCROLL
         END
         TAB('XML CANONICAL'),USE(?TabCanonical)
           TEXT,AT(4,17,522,329),USE(?TextCanonical),HVSCROLL
         END
       END
     END

MyWindow                class(VLBWindowManager)
changes                   unsigned
VLBProc                   procedure(long row, short col), string, derived, proc
                        end

Resizer                 WindowResizeClass

domW &DOMWriter, auto

  code
  assert(not root &= null)
  FillDOMQueue(root, ListXML)
  MyWindow.init()
  open(Window)

  domW &= CreateDOMWriter()
  domW.setNewline(NEWLINE_DEFAULT)
  domW.setFormat(Format:As_Is)
  ?TextAsIs{prop:text} = FixCRLF(domW.writeNode(root))
  domW.setFormat(Format:Canonical)
  ?TextCanonical{prop:text} = FixCRLF(domW.writeNode(root))
  domW.setFormat(Format:Reformatted)
  ?TextReformatted{prop:text} = FixCRLF(domW.writeNode(root))
  DestroyDOMWriter(domW)

  Window $ ?List{PROP:VLBVal} = address(MyWindow)
  Window $ ?List{PROP:VLBProc} = address(VLBProc)
  Resizer.init(AppStrategy:Surface)
  Resizer.setStrategy(?List, ?TextAsIs)
  Resizer.setStrategy(?List, ?TextCanonical)
  Resizer.setStrategy(?List, ?TextReformatted)
  MyWindow.ask()
  close(Window)
  Resizer.kill()
  MyWindow.kill()

MyWindow.VLBProc procedure(long row, short col)

AttrIndex unsigned, auto
AttrString any
nnm &NamedNodeMap, auto
n &node, auto

  code
  case row
  of -1
    return records(ListXML)
  of -2
    return 4
  of -3
    if self.changes <> changes(ListXML)
      self.changes = changes(ListXML)
      return true
    end
    return false
  else
    get(ListXML, row)
    if not errorcode()
      case col
      of 1
        case ListXML.node.getNodeType()
        of Node:ELEMENT              
          return '[ELEMENT]'
        of Node:ATTRIBUTE
          return '[ATTRIBUTE]'
        of Node:TEXT
          return '[TEXT]'
        of Node:CDATA_SECTION
          return '[CDATA]'
        of Node:ENTITY_REFERENCE
          return '[ENTITY_REFERENCE]'
        of Node:ENTITY
          return '[ENTITY]'
        of Node:PROCESSING_INSTRUCTION
          return '[PROCESSING_INSTRUCTION]'
        of Node:COMMENT
          return '[COMMENT]'
        of Node:DOCUMENT
          return '[DOCUMENT]'
        of Node:DOCUMENT_TYPE
          return '[DOCUMENT_TYPE]'
        of Node:DOCUMENT_FRAGMENT
          return '[DOCUMENT_FRAGMENT]'
        of Node:NOTATION
          return '[NOTATION]'
        end
      of 2
        return ListXML.level
      of 3
        return ListXML.node.getNodeName()
      of 4
        return ListXML.node.getNodeValue()
      of 5
        nnm &= ListXML.node.getAttributes()
        if not nnm &= null
          loop AttrIndex = 0 to nnm.getLength() - 1
            n &= nnm.item(AttrIndex)
            AttrString = clip(AttrString) & choose(AttrIndex = 0, '', ' ') & n.getNodeName() & '=' & n.getNodeValue()
          end
        end
        return AttrString
      end
    end
  end
  return ''
!===  CStringClass  ========
CStringClass.construct procedure

  code
  self.cs &= new cstring(1)

CStringClass.destruct procedure

  code
  dispose(self.cs)

CStringClass.str procedure(string s)

  code
  dispose(self.cs)
  self.cs &= new cstring(len(s) + 1)
  self.cs = s
  return self.cs

CStringClass.str procedure

  code
  return self.cs

CStringClass.cat procedure(string s)

  code
  self.str(self.str() & s)
!===  ReflectionClass  ========
ReflectionClass.construct procedure

  code
  self.label = cs:Table
  self.prefix = ''
  self.Fields &= new MappingQueue

ReflectionClass.destruct procedure

  code
  self.kill()
  dispose(self.Fields)

ReflectionClass.kill procedure

row unsigned, auto

  code
  !Clean the Fields queue
  loop row = 1 to records(self.Fields)
    get(self.Fields, row)
    self.Fields.use &= null
    put(self.Fields)
  end
  free(self.Fields)

ReflectionClass.getLabel procedure

  code
  return self.label

ReflectionClass.getPrefix procedure()

  code
  return self.prefix

ReflectionClass.getFieldCount procedure

  code
  return records(self.fields)

ReflectionClass.getFieldLabel procedure(unsigned row)

  code
  get(self.Fields, row)
  if not errorcode()
    return self.Fields.label
  end
  return ''

ReflectionClass.setFieldValue procedure(unsigned row, string value)

  code
  get(self.Fields, row)
  if not errorcode()
    self.setCurrentValue(value)
  end

ReflectionClass.getFieldValue procedure(unsigned row)

  code
  get(self.Fields, row)
  if not errorcode()
    return self.getCurrentValue()
  end
  return ''

ReflectionClass.setFieldColumnLabel procedure(unsigned row, string ColumnLabel)

  code
  get(self.Fields, row)
  if not errorcode()
    self.fields.column = ColumnLabel
    put(self.fields)
  end

ReflectionClass.getFieldColumnLabel procedure(unsigned row)

  code
  get(self.Fields, row)
  if not errorcode()
    return self.fields.column
  end
  return ''
!***not used now
ReflectionClass.setFieldPicture procedure(unsigned row, string picture)

  code
  get(self.Fields, row)
  if not errorcode()
    self.fields.picture = picture
    put(self.fields)
  end
!***not used now
ReflectionClass.getFieldPicture procedure(unsigned row)

  code
  get(self.Fields, row)
  if not errorcode()
    return self.fields.picture
  end
  return ''

ReflectionClass.setValue procedure(string field, string value)

  code
  self.Fields.label = lower(field)!labels are stored in lower case
  get(self.Fields, self.Fields.label)
  if not errorcode()
    self.setCurrentValue(value)
  end

ReflectionClass.getValue procedure(string field)

  code
  self.Fields.label = lower(field)!labels are stored in lower case
  get(self.Fields, self.Fields.label)
  if not errorcode()
    return self.getCurrentValue()
  end
  return ''

ReflectionClass.setColumnLabel procedure(string field, string ColumnLabel)

  code
  self.Fields.label = lower(field)
  get(self.Fields, self.Fields.label)
  if not errorcode()
    self.Fields.column = ColumnLabel
    put(self.fields)
  end

ReflectionClass.getColumnLabel procedure(string field)

  code
  self.Fields.label = lower(field)
  get(self.Fields, self.Fields.label)
  if not errorcode()
    return self.Fields.column
  end
  return ''
!***not used now - for the future use
ReflectionClass.setPicture procedure(string field, string picture)

  code
  self.Fields.label = lower(field)
  get(self.Fields, self.Fields.label)
  if not errorcode()
    self.Fields.picture = picture
    put(self.fields)
  end
!***not used now - for the future use
ReflectionClass.getPicture procedure(string field)

  code
  self.Fields.label = lower(field)
  get(self.Fields, self.Fields.label)
  if not errorcode()
    return self.Fields.picture
  end
  return ''

!***Test for duplicated name for export
!***nameMap - queue with mapping name pairs <ClarionName,XMLName>
!***return: if there is duplicate name problem then return false; otherwise true

ReflectionClass.testForDuplicate procedure(MapQueue nameMap)
ListOfNames queue       !list of names already used
Name        cstring(MAX_NAME_LEN)
            end
mpQ         &MappingQueue
sName       cstring(MAX_NAME_LEN)
row         long
            code
            mpQ&=self.Fields
            loop row = 1 to records(mpQ)
              get(mpQ,row)!get the record from MappingQueue
              sName=TranslateName(mpQ.label,nameMap)!translate the name with nameMap
              ListOfNames.Name=sName
              get(ListOfNames,ListOfNames.Name)!look if the name already used
              if(errorcode()<>0)
                !if not used then add the name to the list
                add(ListOfNames)
              else
                !a duplicate name found - return false
                return false
              end
            end
        !no duplicate name found - true 
            return true
!***not used now
ReflectionClass.serialize procedure

  omit('***')
<?xml version="1.0" encoding="utf-16"?>
<xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="NewDataSet">
    <xs:complexType>
      <xs:choice maxOccurs="unbounded">
        <xs:element name="Table">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="PostOfficeID" type="xs:decimal" minOccurs="0" />
              <xs:element name="CompanyID" type="xs:decimal" minOccurs="0" />
              <xs:element name="UserID" type="xs:decimal" minOccurs="0" />
              <xs:element name="Type" type="xs:int" minOccurs="0" />
              <xs:element name="Status" type="xs:unsignedByte" minOccurs="0" />
              <xs:element name="ModifyDate" type="xs:dateTime" minOccurs="0" />
              <xs:element name="Path" type="xs:string" minOccurs="0" />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:choice>
    </xs:complexType>
  </xs:element>
</xs:schema>
  !***

row unsigned, auto
doc &Document, auto
firstE &Element, auto
secondE &Element, auto
root &Node, auto
gr QueueReflectionClass
cs1 CStringClass
cs2 CStringClass
labelStr CStringClass

stub cstring('<<xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema">' & |
               '<<xs:element name="NewDataSet">' &|
                 '<<xs:complexType>' & |
                   '<<xs:choice maxOccurs="unbounded">' & |
                     '<<xs:element name="Tablexxx">' & |
                       '<<xs:complexType>' &|
                         '<<xs:sequence/>' &|
                       '<</xs:complexType>' &|
                     '<</xs:element>' & |
                   '<</xs:choice>' & |
                 '<</xs:complexType>' & |
               '<</xs:element>' &|
             '<</xs:schema>')

fieldRoot &Element, auto

  code
  doc &= createDocumentFromXml(stub)
  if doc &= null
    return ''
  end
  firstE &= getFirstElementByTagName(doc.getFirstChild(), 'xs:element')
  assert(not firstE &= null)
  secondE &= getFirstElementByTagName(firstE.getFirstChild(), 'xs:element')
  assert(not firstE &= null)
  secondE.setAttribute(cs1.str('name'), cs2.str(self.getLabel()))

  fieldRoot &= GetFirstElementByTagName(doc, 'xs:sequence')
  if fieldRoot &= null
    return ''
  end

  gr.init(self.fields, true)
  root &= doc.getDocumentElement()
  loop row = 1 to records(self.fields)
    get(self.fields, row)
    AppendElementAndAttribute(doc, fieldRoot, 'xs:element', 'name', self.fields.label)
  end
  cs1.str(DOMToXMLString(doc))
  doc.release()
  return cs1.str()
!***Correct prefix to the XML-compatible form or just remove it
!***s - field name
!***removeFlag - if prefix should be removed
ReflectionClass.fixPrefix procedure(string s, byte removeFlag = true)

pos unsigned, auto

  code
  pos = instring(':', s, 1, 1)
  if pos
    if self.prefix = ''
      self.prefix = s[1 : pos - 1]
    end
    if removeFlag
      return s[pos + 1 : len(s)] !remove the prefix
    end
    s[pos] = '_'!replace ':' with '_'
  end
  return s

ReflectionClass.getCurrentValue procedure

  code
  if self.fields.picture
    return clip(format(clip(self.fields.use), self.fields.picture))
  end
  return clip(self.fields.use)

ReflectionClass.setCurrentValue procedure(string value)

  code
  if self.fields.picture
    self.fields.use = deformat(value, self.fields.picture)
  else
    self.fields.use = value
  end

GroupReflectionClass.init procedure(*group g, byte removePrefix = true)

field unsigned(1)

  code
  !enumerate fields
  loop
    clear(self.Fields)
    self.Fields.use &= null
    !assign name of field
    self.Fields.label = self.fixPrefix(lower(who(g, field)), removePrefix)
    if not self.Fields.label
      break !finish the enumeration
    end
    self.Fields.use &= what(g, field)!assign reference to the field
    add(self.Fields) !add new record to MappingQueue
    field += 1
  end

QueueReflectionClass.init procedure(*queue q, byte removePrefix = true)

field unsigned(1)

  code
  !enumerate fields
  loop
    clear(self.Fields)
    self.Fields.use &= null
    !assign the name of the fields
    self.Fields.label = self.fixPrefix(lower(who(q, field)), removePrefix)
    if not self.Fields.label
      break  !finish the enumeration
    end
    self.Fields.use &= what(q, field) !assign reference to the field
    add(self.Fields)! add record to MappingQueue
    field += 1
  end
!***not used now
KeyReflectionClass.init procedure(*file f, *key k, byte removePrefix = true)

record &group, auto
field unsigned, auto

  code
  self.label = k{prop:label}
  record &= f{prop:Record}
  loop field = 1 to k{prop:components}
    clear(self.Fields)
    self.Fields.use &= null
    self.Fields.label = self.fixPrefix(lower(f{prop:label, k{prop:field, field}}), removePrefix)
    if not self.Fields.label
      break
    end
    self.Fields.use &= what(record, k{prop:field, field})
    add(self.Fields)
    field += 1
  end

FileReflectionClass.construct procedure

  code

FileReflectionClass.destruct procedure

  code

FileReflectionClass.init procedure(*file f, byte removePrefix = true)

record &group, auto
field unsigned(1)

  code
  self.label = f{prop:label}
  record &= f{prop:Record}
  !enumerate fields
  loop
    clear(self.Fields)
    self.Fields.use &= null
    !assign filed's name
    self.Fields.label = self.fixPrefix(lower(who(record, field)), removePrefix)
    if not self.Fields.label
      break !finish the enumeration
    end
    self.Fields.use &= what(record, field) !assign reference to the field
    add(self.Fields) !add the new record to the MappingQueue
    field += 1
  end

ViewReflectionClass.construct procedure

  code

ViewReflectionClass.destruct procedure

  code

ViewReflectionClass.init procedure(*view v, byte removePrefix = true)

field unsigned, auto
f &file
record &group, auto

  code
  !enumerate fields
  loop field = 1 to v{prop:Fields}
    f &= v{prop:fieldsFile, field}
    record &= f{prop:Record}
    clear(self.Fields)
    self.Fields.use &= null
    !assign field's name
    self.Fields.label = self.fixPrefix(lower(who(record, v{prop:field, field})), removePrefix)
    self.Fields.use &= what(record, v{prop:field, field}) !assign reference to the field
    add(self.Fields)
  end

!===  ====  ========
FixCRLF procedure(string xml)

pos unsigned, auto
fixedPos unsigned(1)
fixed &string
fixedReturn any

  code
  fixed &= new string(len(xml) * 2)
  loop pos = 1 to len(xml)
    if xml[pos] = '<13>'
      fixed[fixedPos] = '<13>';fixedPos += 1
      fixed[fixedPos] = '<10>';fixedPos += 1
      if pos < len(xml) and xml[pos + 1] = '<10>'
        pos += 1
      end
      cycle
    elsif xml[pos] = '<10>'
      fixed[fixedPos] = '<13>';fixedPos += 1
      fixed[fixedPos] = '<10>';fixedPos += 1
      cycle
    end
    fixed[fixedPos] = xml[pos];fixedPos += 1
  end
  fixedReturn = fixed
  dispose(fixed)
  return fixedReturn
!===  ====  ========
!***doc - pointer to XML DOM Document object
!***rowE - DOM's element corresponding to row
!***tag - name of tag/attribute for the column
!***val - value
!***style - can be DOMStyle:ADO_26 (attribute-based style) 
!********or DOMStyle:ADO_Net (tag-based style) 
toDOM:AppendCol procedure(*XMLExchange exch, *Document doc, *Element rowE, StructWrapper sw, signed col, DOMStyle style)

colE      &Element, auto
colA      &Attr, auto
cs        CStringClass
value     CStringClass
fldFormat XMLFieldFormat
tp        UNSIGNED  
  code
  tp=sw.getFieldType(col)
  if style = DOMStyle:ADO_26 then
    !Attribute-based style    
    !Add attribute to the DOM
    if sw.getXMLFieldFormatByIndex(col, fldFormat) = CPXMLErr:NoError then
      if fldFormat = XMLFieldFormat:CData
        return CPXMLErr:CDataNotSupported
      elsif fldFormat = XMLFieldFormat:Base64 
        return CPXMLErr:Base64NotSupported
      end
    end
    colA &= doc.createAttribute(cs.str(sw.getXMLFieldLabel(col)))  !was lower(tag) [MAL]
    rowE.setAttributeNode(colA)
    colA.setValue(cs.str(clip(sw.getFieldValueByIndex(col))))
    colA.release()
  elsif style = DOMStyle:ADO_Net then
    !tag-based style
    !Add new element to the DOM corresponding to column
    colE &= doc.createElement(cs.str(sw.getXMLFieldLabel(col))) !was lower(tag) [MAL]
    rowE.appendChild(colE)
    if sw.getXMLFieldFormatByIndex(col, fldFormat) <> CPXMLErr:NoError then      
        colE.appendChild(doc.createTextNode(cs.str(clip(sw.getFieldValueByIndex(col)))))      
    else
      ! test field format
      if fldFormat = XMLFieldFormat:CData then
        colE.appendChild(doc.createCDATASection(cs.str(clip(sw.getFieldValueByIndex(col)))))
      elsif fldFormat = XMLFieldFormat:Base64 then
        exch.setNamespace()
        colE.setAttribute(e:XsiType, e:Base64)
        value.str(clip(sw.getFieldValueByIndex(col)))
        cs.str(tobase64(value.str()))
        colE.appendChild(doc.createTextNode(cs.str()))
      else        
        !usual case 
        colE.appendChild(doc.createTextNode(cs.str(clip(sw.getFieldValueByIndex(col)))))        
      end
    end
    colE.release()
  else
    assert(false, '<13,10>Unknown DOMStyle:  ' & style)
  end
  return 0

!===  ====  ========
!***rowE - DOM's element corresponding to row
!***style - can be DOMStyle:ADO_26 (attribute-based style) 
!********or DOMStyle:ADO_Net (tag-based style) 
!***gr - pointer to ReflectionClass instance
!***nameMap - Queue with "mapping name" pairs <ClarionName,XMLName>
!***return: true if successful; false - otherwise
fromDOM:AppendCols procedure(*Element rowE, DOMStyle style, *ReflectionClass gr,<MapQueue nameMap>)

Cols &NodeList, auto
Attrs &NamedNodeMap, auto
col unsigned, auto
colE &Element, auto
colA &Attr, auto
TNode &Text, auto
sName cstring(MAX_NAME_LEN)
ListOfNames  queue      !List of field names already used
Name        cstring(MAX_NAME_LEN)
            end
!colA &Attr, auto
!cs CStringClass

  code
  case style
  of DOMStyle:ADO_26
    !Attribute-based style
    Attrs &= rowE.getAttributes()
    if not Attrs &= null
      loop col = 0 to Attrs.getLength() - 1
        colA &= address(Attrs.item(col))
        !Name mapping support  
        if(omitted(4))
           !If no nameMap
           sName=TranslateName(colA.getName(),,false)
        else
           sName=TranslateName(colA.getName(),nameMap,false)
        end
        !Test for duplicate
        ListOfNames.Name=sName
        get(ListOfNames,ListOfNames.Name)!search for sName
        if(errorcode()<>0)
           !if not found then set value and add the name to list
           gr.setValue(sName, colA.getValue())
           add(ListOfNames)
        else
           !name found then error - duplicate name
           CPXMLSetLastError(CPXMLErr:DuplicateName)
           Attrs.release()
           return false
        end
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
          !Name translation ("name mapping")
          if(omitted(4))
            !if no nameMap presents
            sName=TranslateName(colE.getTagName(),,false)
          else
            sName=TranslateName(colE.getTagName(),nameMap,false)
          end
          !Test for duplicate
          ListOfNames.Name=sName
          get(ListOfNames,ListOfNames.Name)
          if(errorcode()<>0)
            !if the name not found - set value and add it to the list
            gr.setValue(sName, TNode.GetData())
            add(ListOfNames)
          else
            !if the name found then error - duplicate name
            CPXMLSetLastError(CPXMLErr:DuplicateName)
            Cols.release()
            return false
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
!===  ====  ========
!***style - can be DOMStyle:ADO_26 or DOMStyle:ADO_Net
!***return root tag for the XML
toDOM:getTableLabel procedure(DOMStyle style)

retVal cstring('row')

  code
  case style
  of DOMStyle:ADO_26
    return cs:RSData
  of DOMStyle:ADO_NET
    return cs:NewDataSet
  end
  return retVal
!===  ====  ========
!***style - can be DOMStyle:ADO_26 or DOMStyle:ADO_Net
!***return - pointer to the created DOM Document or NULL on failure
toDOM:CreateEmptyDOM     procedure(DOMStyle style)
doc   &Document,auto
lbl   string(20)
cs    CStringClass
  code
  case style
  of DOMStyle:ADO_26
    !Attribute-based style
    lbl=toDom:getTableLabel(style)
    ! was cs.str('<<' & CLIP(lbl) & ' xmlns:rs="www.softvelocity.com/rs" xmlns:z="www.softvelocity.com/z"> </' & CLIP(lbl) & '>'
    doc&=createDocumentFromXml(cs.str('<<' & CLIP(lbl) & '> </' & CLIP(lbl) & '>'))
  of DOMStyle:ADO_NET
    !Tag-based style
    doc&=createDocumentFromXml(cs.str('<<' & toDom:getTableLabel(style) & '/>'))
  end
  return doc
!===  ====  ========
!***style - can be DOMStyle:ADO_26 or DOMStyle:ADO_Net
!***return XML tag name corresponding to a row
toDOM:getRowLabel procedure(DOMStyle style)

!retVal cstring('row')

  code
  case style
  of DOMStyle:ADO_26 !attribute-based style
    return cs:ZRow
  of DOMStyle:ADO_NET !tag-based style
    return cs:Table
  end
  return 'row'
!===  ====  ========
AppendElement procedure(*Document doc, *Node parentNode, string ELabel)

E &Element, auto
cs CStringClass

  code
  E &= doc.CreateElement(cs.str(ELabel))
  if not E &= null
    parentNode.AppendChild(E)
    E.release()
  end
  return E
!===  ====  ========
AppendElementAndText procedure(*Document doc, *Node parentNode, string ELabel, string TData, byte base64=false)

E &Element, auto
T &Text, auto
TDataCString CStringClass
cs CStringClass

  code
  E &= AppendElement(doc, parentNode, ELabel)
  if not E &= null
    if base64
      e.setAttribute(e:XsiType, e:Base64)
      cs.str(tobase64(TData[1 : len(TData)]))
    else
      cs.str(TDataCString.str(TData))
    end
    T &= Doc.CreateTextNode(cs.str())
    if not T &= null
      E.AppendChild(T)
      T.release()
    end
  end
  return E
!===  ====  ========
AppendElementAndAttribute procedure(*Document doc, *Node parentNode, string ELabel, string attribute, string value)

E &Element, auto
csAttr CStringClass
csVal CStringClass

  code
  E &= AppendElement(doc, parentNode, ELabel)
  if not E &= null
    E.SetAttribute(csAttr.str(attribute), csVal.str(value))
  end
  return E
!===  ====  ========
GetElementText procedure(*Element e, byte asis=false)

t &Node, auto

  code
  e.Normalize()
  t &= e.getFirstChild()
  if (not t &= null)
    if not asis and e.getAttribute(e:XsiType) = e:Base64
      return fromBase64(t.getNodeValue())
    end
    return t.getNodeValue()
  end
  return ''

SetElementText procedure(*Element e, string txt, byte asis=false)

t &Node, auto
doc &Document, auto
newText &Text, auto
cs CStringClass

  code
  assert(not e &= null)
  e.Normalize()
  t &= e.getFirstChild()
  if (not t &= null)
    e.removeChild(t)
  end
  doc &= e.getOwnerDocument()
  assert(not doc &= null)
  newText &= doc.createTextNode(cs.str(txt))
  assert(not newText &= null)
  e.appendChild(newText)
  return

GetFirstElementByTagName procedure(*Node root, string name)

n &Node, auto
foundElement &Element, auto

  code
  n &= root
  loop
    if n &= null
      break
    elsif n.getNodeType() = Node:Element and n.GetNodeName() = name
      return address(n)
    end
    foundElement &= GetFirstElementByTagName(n.getFirstChild(), name)
    if not foundElement &= null
      return foundElement
    end
    n &= n.getNextSibling()
  end
  return null
!===  ====  ========
ToBase64 procedure(string inv)

i signed,auto
bLK signed,auto
outv &string, auto
base64String any
sz  UNSIGNED
  code
  sz=LEN(inv)
  IF(sz=0)
    RETURN ''
  END
  outv &= new string(size(inv) * 3)
  blk = len(inv)/3
  loop i = 1 to blk
    Take24(val(inv[I*3-2]),val(inv[I*3-1]),val(inv[I*3]),outv[I*4-3:I*4])
  end
  if blk * 3 < len(inv)
    if blk *3 + 1 = len(inv)
      Take24(val(inv[len(inv)]),0,0,outv[blk*4+1:blk*4+4])
      outv[blk*4+3] = '='
      outv[blk*4+4] = '='
    else
      Take24(val(inv[len(inv)-1]),val(inv[len(inv)]),0,outv[blk*4+1:blk*4+4])
      outv[Blk*4+4] = '='
    end
    base64String = outv[1 : blk * 4 + 4]
  else
    base64String = outv[1 : blk * 4]
  end
  dispose(outv)
  return base64String
 
FromBase64 procedure(string inv)

f signed(1)
store string(4)
sh byte(0)
outf signed(1)
b  byte,dim(3)
n  byte,auto
outv &string, auto
base64String any

  code
  outv &= new string(size(inv) * 3)
  loop while f <= len(inv)
    if instring(inv[f],encode)
      sh += 1
      store[sh] = inv[f]
      if sh = 4
        n = Take32(b[1],b[2],b[3],store)
        outv[outf] = chr(b[1])
        outf += 1
        if n = 1 then break .
        outv[outf] = chr(b[2])
        outf += 1
        if n = 2 then break .
        outv[outf] = chr(b[3])
        outf += 1
        sh = 0
      end
    end
    f += 1
  end
  base64String = outv[1 : outf - 1]
  dispose(outv)
  return base64String

Take24 procedurE(byte h, byte m, byte l, *string into)
b6 byte,auto
   code
   ! First 6 bits? What does the 'high bit is counted first' expression mean?
   ! I'm assuming top 6 bits of h
   b6 = bshift(h,-2)
   into[1] = encode[B6+1]
   ! Second 6 bits become bottom 2 of h (up 4) and top 4 of m (down 4)
   b6 = bor(band(bshift(h,4),030H),bshift(m,-4))
   into[2] = encode[B6+1]
   ! Third 6 bits are bottom 4 of m (up two) and top 2 of l (down 6)
   b6 = bor(band(bshift(m,2),03CH),bshift(l,-6))
   into[3] = encode[B6+1]
   ! Last 6 come from bottom 6 of l
   into[4] = encode[band(l,03FH)+1]
 
Take32 procedure(*byte h, *byte m, *byte l, *string sfrom)
buff byte,dim(4),auto
i byte,auto
  code
  loop I = 1 to 4
    buff[I] = instring(sfrom[I],encode)
?   assert(buff[I])
    buff[I] -= 1
  end
? assert(bufF[1]<>64)
? assert(buff[2]<>64)
  ! Whole of first 6 bits up two and first two of second (down 4)
  h = bor(bshift(buff[1],2),bshift(buff[2],-4))
  if buff[3] = 64 then return 1 .
  ! Middle is bottom 4 bits of second (up 4) and top 4 bits of third (down 2)
  m = bor(bshift(buff[2],4),bshift(buff[3],-2))
  if buff[4] = 64 then return 2 .
  ! Bottom is bottom two bits of third (up 6) and whole of fourth
  l = bor(bshift(buff[3],6),buff[4])
  return 3

SaxParserClass.ParseXMLString                         procedure(string xml)

cs CStringClass

  code
  return XMLStringToSAX(cs.str(xml), self.ISAXCallback)

SaxParserClass.ParseXMLFile                           procedure(string path)

cs CStringClass

  code
  return XMLFileToSAX(cs.str(path), self.ISAXCallback)

SaxParserClass.SetDocumentLocator                     procedure(string PublicID, string SystemID)

  code
  return

SaxParserClass.NotationDecl                           procedure(string name, string publicId, string systemId)

  code
  return

SaxParserClass.UnparsedEntityDecl                     procedure(string name, string publicId, string systemId, string notationName)

  code
  return

SaxParserClass.StartDocument                          procedure

  code
  return

SaxParserClass.EndDocument                            procedure

  code
  return

SaxParserClass.StartElement                           procedure(string name)

  code
  return

SaxParserClass.Attribute                              procedure(string name, string type, string value)

  code
  return

SaxParserClass.EndElement                             procedure(string name)

  code
  return

SaxParserClass.Characters                             procedure(string chars)

  code
  return

SaxParserClass.IgnorableWhitespace                    procedure(string chars)

  code
  return

SaxParserClass.ProcessingInstruction2                 procedure(string target, string data)

  code
  return

SaxParserClass.Warning                                procedure(string warning)

  code
  return

SaxParserClass.Error                                  procedure(string error)

  code
  return

SaxParserClass.FatalError                             procedure(string fatalError)

  code
  return

SaxParserClass.StartDTD                               procedure(string name, string publicId, string systemId)

  code
  return

SaxParserClass.EndDTD                                 procedure

  code
  return

SaxParserClass.StartEntity                            procedure(string name)

  code
  return

SaxParserClass.EndEntity                              procedure(string name)

  code
  return

SaxParserClass.StartCDATA                             procedure

  code
  return

SaxParserClass.EndCDATA                               procedure

  code
  return

SaxParserClass.Comment                                procedure(string commentText)

  code
  return

SaxParserClass.StartNamespaceDeclScope                procedure(string prefix, string uri)

  code
  return

SaxParserClass.EndNamespaceDeclScope                  procedure(string prefix)

  code
  return

SaxParserClass.ISaxCallback.SetDocumentLocator        procedure(const *cstring PublicID, const *cstring SystemID)

  code
  self.SetDocumentLocator(PublicID, SystemID)
  return

SaxParserClass.ISaxCallback.NotationDecl              procedure(const *cstring name, const *cstring publicId, const *cstring systemId)

  code
  self.NotationDecl(name, publicId, systemId)
  return

SaxParserClass.ISaxCallback.UnparsedEntityDecl        procedure(const *cstring name, const *cstring publicId, const *cstring systemId, const *cstring notationName)

  code
  self.UnparsedEntityDecl(name, publicId, systemId, notationName)
  return

SaxParserClass.ISaxCallback.StartDocument             procedure

  code
  self.StartDocument()
  return

SaxParserClass.ISaxCallback.EndDocument               procedure

  code
  self.EndDocument()
  return

SaxParserClass.ISaxCallback.StartElement              procedure(const *cstring name)

  code
  self.StartElement(name)
  return

SaxParserClass.ISaxCallback.Attribute                 procedure(const *cstring name, const *cstring type, const *cstring value)

  code
  self.Attribute(name, type, value)
  return

SaxParserClass.ISaxCallback.EndElement                procedure(const *cstring name)

  code
  self.EndElement(name)
  return

SaxParserClass.ISaxCallback.Characters                procedure(const *cstring chars)

  code
  self.Characters(chars)
  return

SaxParserClass.ISaxCallback.IgnorableWhitespace       procedure(const *cstring chars)

  code
  self.IgnorableWhitespace(chars)
  return

SaxParserClass.ISaxCallback.ProcessingInstruction2    procedure(const *cstring target, const *cstring data)

  code
  self.ProcessingInstruction2(target, data)
  return

SaxParserClass.ISaxCallback.Warning                   procedure(const *cstring warning)

  code
  self.Warning(warning)
  return

SaxParserClass.ISaxCallback.Error                     procedure(const *cstring error)

  code
  self.Error(error)
  return

SaxParserClass.ISaxCallback.FatalError                procedure(const *cstring fatalError)

  code
  self.FatalError(fatalError)
  return

SaxParserClass.ISaxCallback.StartDTD                  procedure(const *cstring name, const *cstring publicId, const *cstring systemId)

  code
  self.StartDTD(name, publicId, systemId)
  return

SaxParserClass.ISaxCallback.EndDTD                    procedure

  code
  self.EndDTD()
  return

SaxParserClass.ISaxCallback.StartEntity               procedure(const *cstring name)

  code
  self.StartEntity(name)
  return

SaxParserClass.ISaxCallback.EndEntity                 procedure(const *cstring name)

  code
  self.EndEntity(name)
  return

SaxParserClass.ISaxCallback.StartCDATA                procedure

  code
  self.StartCDATA()
  return

SaxParserClass.ISaxCallback.EndCDATA                  procedure

  code
  self.EndCDATA()
  return

SaxParserClass.ISaxCallback.Comment                   procedure(const *cstring commentText)

  code
  self.Comment(commentText)
  return

SaxParserClass.ISaxCallback.StartNamespaceDeclScope   procedure(const *cstring prefix, const *cstring uri)

  code
  self.StartNamespaceDeclScope(prefix, uri)
  return

SaxParserClass.ISaxCallback.EndNamespaceDeclScope     procedure(const *cstring prefix)

  code
  self.EndNamespaceDeclScope(prefix)
  return
