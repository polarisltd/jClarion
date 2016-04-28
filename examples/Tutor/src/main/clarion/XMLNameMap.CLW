! $Header: /0192-7/XMLSupport/src/XMLNameMap.CLW 36    9/02/03 12:52p Mal $
!***************************************************************************
!  FILE..........: XmlNameMap.clw
!  AUTHOR........: Valeri Lobachev
!  DESCRIPTION...: Implementation of XmlNameMap class
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!****************************************************************************

!===========================================[ PUBLIC DECLARATIONS ]========
!===========================================[ PRIVATE DECLARATIONS ]=======
!===========================================[ PUBLIC CLASS METHODS ]=======
!****************************************************************************
    MEMBER

    include('cpxml.inc'), once
    include('xmlclass.inc'), once

XMLNameMap.Construct    PROCEDURE
    CODE
    SELF.map &= new MapQueue
 
XMLNameMap.Destruct     PROCEDURE
    CODE
    DISPOSE(SELF.map)

XMLNameMap.load         PROCEDURE(MapQueue m)
    CODE
    FREE(SELF.map)
    LOOP I# = 1 TO RECORDS(m)
        GET(m, I#)
        if (SELF.addRecord(m.ClarionName, m.XmlName, m.Picture, m.Format) <> CPXMLErr:NoError)
            RETURN CPXMLErr:IllegalParameter
        END
    END
    RETURN CPXMLErr:NoError

XMLNameMap.open PROCEDURE(string path, <*MapQueue map>)
rc      SIGNED
qw      QueueWrapper
xExch   XMLExchange
mapq    &MapQueue
clrName CSTRING(MAX_NAME_LEN)
                CODE
  if omitted(3) then
    mapq &= self.map
  else
    mapq &= map
  end
  rc = qw.init(mapq, TRUE)
  if rc <> 0
    return CPXMLErr:InternalError
  end
  rc = xExch.setRootTagName('namemap')
  if rc <> CPXMlErr:NoError
    return rc
  end
  rc = xExch.open(path)
  if rc <> 0
    return rc
  end
  rc = xExch.fromXML(qw)
  if rc <> CPXMlErr:NoError
    return rc
  end
  loop I# = 1 to records(mapq)
    get(mapq, I#)
    rc=SELF.checkXMLName(mapq.XMLName)
    if rc <> CPXMlErr:NoError
       return rc
    end
    clrName = lower(mapq.ClarionName)
    mapq.ClarionName = clrName
    put(mapq)
  end
  rc = xExch.setRootAsCurrent()
  if rc <> CPXMlErr:NoError
    return rc
  end
  xExch.setLastAdded(xExch.getNode())
  rc = self.setRootTagName(xExch.getAttr('root'))
  if rc <> CPXMlErr:NoError
    return rc
  end
  rc = self.setRowTagName(xExch.getAttr('child'))
  if rc <> CPXMlErr:NoError
    return rc
  end
  xExch.close()
  return CPXMlErr:NoError

XMLNameMap.saveAs PROCEDURE(string path, <*CSTRING newLine>, UNSIGNED Format = 1)
rc      SIGNED
qw      QueueWrapper
xExch   XMLExchange
                  CODE
  rc = qw.init(self.map, TRUE)
  if rc <> 0
    return CPXMLErr:InternalError
  end
  rc = xExch.setRootTagName('namemap')
  if rc <> CPXMlErr:NoError
    return rc
  end
  rc = xExch.createXML()
  if rc <> CPXMlErr:NoError
    return rc
  end
  rc = xExch.toXML(qw)
  if rc <> CPXMlErr:NoError
    return rc
  end
  rc = xExch.setRootAsCurrent()
  if rc <> CPXMlErr:NoError
    return rc
  end
  xExch.setLastAdded(xExch.getNode())
  xExch.setAttr('root', self.getRootTagName())
  xExch.setAttr('child', self.getRowTagName())
  if(omitted(3))
    rc = xExch.saveAs(path, SVMode:IgnoreSchema, NEWLINE_DEFAULT, Format)
  else
    rc = xExch.saveAs(path, SVMode:IgnoreSchema, newLine, Format)
  end
  if rc <> CPXMlErr:NoError
    return rc
  end
  xExch.close()
  return CPXMlErr:NoError

XMLNameMap.startIterate PROCEDURE
                        CODE
  self.counter = 0
  return

XMLNameMap.getNextRow PROCEDURE
                      CODE
  if self.map &= NULL then
    return CPXMLErr:FieldNotFound
  end
  self.counter += 1
  get(self.map, self.counter)
  if errorcode() > 0
    return CPXMLErr:InternalError
  end
  return CPXMLErr:NoError

XMLNameMap.getXMLName PROCEDURE
                      CODE
  return self.map.XMLName

XMLNameMap.getClarionName PROCEDURE
                          CODE
  return self.map.ClarionName

XMLNameMap.getXmlFieldFormat PROCEDURE
                             CODE
  return self.map.Format

XMLNameMap.getRowTagName  PROCEDURE
                          CODE
  if(len(SELF.rowTagName) > 0)
    return clip(SELF.rowTagName)
  end
  return ''

XMLNameMap.getRootTagName PROCEDURE
                          CODE
  if(len(SELF.rootTagName) > 0)
    return clip(SELF.rootTagName)
  end
  return ''

XMLNameMap.setRowTagName  PROCEDURE(string tagName)
rc  byte
cs  CStringClass
                          CODE
  cs.str(CLIP(tagName))
  if len(cs.str()) <> 0
    rc = checkXMLName(cs.str())
    if(rc <> 0)
      return CPXMLErr:InvalidArgument
    end
  end
  SELF.rowTagName = cs.str()
  return CPXMLErr:NoError

XMLNameMap.setRootTagName PROCEDURE(string tagName)
rc  byte
cs  CStringClass
                          CODE
  cs.str(CLIP(tagName))
  if len(cs.str()) <> 0
    rc = checkXMLName(cs.str())
    if(rc <> 0)
      return CPXMLErr:InvalidArgument
    end
  end
  SELF.rootTagName = cs.str()
  return CPXMLErr:NoError

XMLNameMap.addRecord          PROCEDURE(STRING clarionName, STRING xmlName, <STRING picture>, <XMLFieldFormat fldFormat>)
bRet    BYTE(CPXMLErr:IllegalParameter)
    CODE
    if(omitted(4))
      picture = ''
    end
    if(omitted(5))
      fldFormat = XMLFieldFormat:Text
    end

    if (SELF.checkXMLName(xmlname) = CPXMLErr:NoError)
        SELF.map.ClarionName = lower(clarionName)
        get(SELF.map, SELF.map.ClarionName)
        if errorCODE()
            SELF.map.XmlName = xmlName
            get(SELF.map, SELF.map.XmlName)
            if errorCODE()
                SELF.map.ClarionName = lower(clarionName)
                SELF.map.XmlName     = xmlName
                SELF.map.Picture     = picture
                SELF.map.Format      = fldFormat
                ADD(SELF.map)
                bRet = CPXMLErr:NoError
            END
        END
    END    
    RETURN bRet

!virtual method to customize formatting behaviour
XMLNameMap.formatValue               PROCEDURE(STRING fieldName, STRING value, BYTE toXml)
    CODE
    SELF.map.ClarionName = lower(fieldName)
    get(SELF.map, SELF.map.ClarionName)
    IF errorCode() = false
        IF LEN(SELF.map.Picture) = 0
            RETURN value
        ELSIF toXml = true
            return FORMAT(value, SELF.map.Picture)
        ELSE
          IF (instring('@s',lower(clip(SELF.map.Picture)))=0)
            return DEFORMAT(value, SELF.map.Picture)
          ELSE
            return value
          END
        END
    END
    RETURN ''

! The following methods are used by StructWrapper based classed to support
! name mapping/formatting
XMLNameMap.translateName    PROCEDURE(STRING nm, BYTE toXML=true)
temp    &CSTRING
    CODE
    temp &= NULL;

    IF toXML = true
        SELF.map.ClarionName = lower(nm)
        get(SELF.map, SELF.map.ClarionName)
        IF errorCode() = 0
            temp &= SELF.map.XmlName
        END
    ELSE
        SELF.map.XmlName = nm
        get(SELF.map, SELF.map.XmlName)
        IF errorCode() = 0
            temp &= SELF.map.ClarionName
        END
    END

    RETURN temp

XMLNameMap.checkXMLName PROCEDURE(STRING xmlName)
    CODE
    RETURN checkXMLName(xmlName)

!****************************************************************************
!===========================================[ PRIVATE CLASS METHODS ]======
!===========================================[ PUBLIC  FUNCTIONS ]==========
!===========================================[ PRIVATE FUNCTIONS ]==========
!** (END OF FILE  : XmlNameMap.clw) *****************************************

