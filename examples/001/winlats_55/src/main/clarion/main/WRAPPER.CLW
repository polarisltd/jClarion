! $Header: /0192-7(XML support)/XMLSupport/src/WRAPPER.CLW 40    10/21/03 1:28p Mal $
!****************************************************************************
!  FILE..........: wrapper.clw
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-01 Created by Semenov Denis
!****************************************************************************

    MEMBER

    include('cpxml.inc'), once
    include('xmlclass.inc'), once
    include('cpxml.inc'), once

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.construct  PROCEDURE
    CODE
    self.ObjectInfo &= 0
    self.nameMap    &= 0
    self.fields     &= new MappingQueue
    self.mapIndexes &= new mapIndexesQueue
    self.useMap      = FALSE
    self.bFreeMap    = FALSE
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.destruct  PROCEDURE
    CODE
    self.kill()
    dispose(self.fields)
    dispose(self.mapIndexes)
    if self.bFreeMap
      DISPOSE(self.nameMap)
      self.bFreeMap = FALSE
    end
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.kill PROCEDURE
row unsigned, auto

    CODE
    !Clean the Fields queue
    loop row = 1 to records(self.Fields)
        get(self.fields, row)
        self.fields.use &= null
        put(self.fields)
    end
    free(self.fields)
    free(self.mapIndexes)
    if self.bFreeMap
      DISPOSE(self.nameMap)
      self.bFreeMap = FALSE
    end
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setNameMap PROCEDURE(XMLNameMap map)
    CODE
    if self.bFreeMap
      DISPOSE(self.nameMap)
      self.bFreeMap = FALSE
    end
    self.nameMap &= map
    self.setMappingEnabled(true)
    return CPXMLErr:NoError

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setNameMap PROCEDURE(MapQueue map)
retval  long
    CODE
    self.nameMap &= NEW XMLNameMap
    self.bFreeMap = TRUE
    retval = self.nameMap.load(map)

    if (retval = CPXMLErr:NoError)
        self.setMappingEnabled(true)
    end
    return retval

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setMappingEnabled   PROCEDURE(BYTE flag=true)
    CODE

    if not self.nameMap &= null
        free(self.mapIndexes)
        clear(self.mapIndexes)

        if flag 
            self.useMap = false
            free(self.mapIndexes)
            self.nameMap.startIterate()
            loop
                clear(self.mapIndexes)
                if self.nameMap.getNextRow() <> CPXMLErr:NoError
                    break
                end
                self.mapIndexes.xmlLabel  = self.nameMap.getXMLName()
                self.mapIndexes.clwLabel  = self.nameMap.getClarionName()
                self.mapIndexes.xmlFormat = self.nameMap.getXmlFieldFormat()
                loop i#=1 to self.getFieldsCount()
                    if lower(self.mapIndexes.clwLabel) = lower(self.getFieldLabel(i#))
                        self.mapIndexes.index = i#
                        add(self.mapIndexes)
                        break;
                    end
                end
            end
        end
        self.useMap = flag

        if self.loadProperties() = CPXMLErr:NoError
        end
    end
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldsCount PROCEDURE
retVal UNSIGNED(0)
    CODE
    if self.isMappingEnabled()
        retVal = records(self.mapIndexes)
    else
        retVal = records(self.fields)
    end
    return retVal


!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getCurrentValue procedure
  CODE
  if self.isMappingEnabled()
    return self.nameMap.formatValue(self.fields.label, clip(self.fields.use), true)
  else
    if self.fields.picture
        return clip(format(clip(self.fields.use), self.fields.picture))
    end
  end
  return clip(self.fields.use)

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setCurrentValue procedure(string value)
  CODE
  if self.isMappingEnabled()
        self.fields.use = self.nameMap.formatValue(self.fields.label, value, false)
  else
    if (self.fields.picture AND (instring('@s',lower(clip(self.fields.picture)))=0))
        self.fields.use = deformat(value, self.fields.picture)
    else
        self.fields.use = value
    end
  end

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldValueByName PROCEDURE(STRING field)
  CODE
  self.Fields.label = lower(field)!labels are stored in lower case
  get(self.Fields, self.Fields.label)
  if not errorCODE()
    return self.getCurrentValue()
  end
  return ''

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setFieldValueByName PROCEDURE(STRING field, STRING value)
retVal UNSIGNED(CPXMLErr:NoError)
  CODE
  self.Fields.label = lower(field)!labels are stored in lower case
  get(self.Fields, self.Fields.label)
  if not errorCODE()
    self.setCurrentValue(value)
  else
    retVal = CPXMLErr:FieldNotFound
  end

  return retVal

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldValueByIndex PROCEDURE(UNSIGNED cou)
  CODE

  if( self.isMappingEnabled() )
    get(self.mapIndexes, cou)
    if not errorCODE()
        cou = self.mapIndexes.index
    end
  end

  get(self.Fields, cou)
  if not errorCODE()
    return self.getCurrentValue()
  end
  return ''

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setFieldValueByIndex PROCEDURE(UNSIGNED cou, STRING value)
retVal UNSIGNED(CPXMLErr:NoError)
  CODE

  if( self.isMappingEnabled() )
    get(self.mapIndexes, cou)
    if not errorCODE()
        cou = self.mapIndexes.index
    end
  end

  get(self.Fields, cou)
  if not errorCODE()
    self.setCurrentValue(value)
  else
    retVal = CPXMLErr:FieldNotFound
  end
  return retVal

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getXMLFieldFormatByIndex PROCEDURE(UNSIGNED cou, *XMLFieldFormat fldFormat)
  CODE
  if self.isMappingEnabled()
    get(self.mapIndexes, cou)
    if not errorCODE()
      fldFormat = self.mapIndexes.xmlFormat
      cou = self.mapIndexes.index
      get(self.Fields,cou)
      if(band(self.Fields.attr,CLMEMO:BINARY))
        fldFormat=XMLFieldFormat:Base64
      end    
      return CPXMLErr:NoError
    end
  else
      get(self.Fields,cou)
      if(self.Fields.fldType=CLTYPE:MEMO)
        if(band(self.Fields.attr,CLMEMO:BINARY))
            fldFormat=XMLFieldFormat:Base64
        else
            fldFormat=XMLFieldFormat:Text
        end    
        return CPXMLErr:NoError
      end
  end
  return CPXMLErr:FieldNotFound

!***Correct prefix to the XML-compatible form or just remove it
!***s - field name
!***removeFlag - if prefix should be removed
StructWrapper.fixPrefix PROCEDURE(string s, byte removeFlag = true)
pos unsigned, auto

  code
  pos = instring(':', s, 1, 1)
  if pos
    if removeFlag
      return s[pos + 1 : len(s)] !remove the prefix
    end
    s[pos] = '_' !replace ':' with '_'
  end
  return s

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.findFieldByName PROCEDURE(STRING field)
  CODE
    if (not self.nameMap &= null) and self.isMappingEnabled() then
      self.mapIndexes.clwLabel = LOWER(field)  ! labels are stored in lower case
      GET(self.mapIndexes, self.mapIndexes.clwLabel)
      if not ERRORCODE()
        return self.mapIndexes.index
      end
    else
      self.Fields.label = LOWER(field)  ! labels are stored in lower case
      GET(self.Fields, self.Fields.label)
      if not ERRORCODE()
        return self.Fields.index
      end
    end
  RETURN -1

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.findFieldByXMLName PROCEDURE(STRING field)
  CODE
    if (not self.nameMap &= null) and self.isMappingEnabled() then
      self.mapIndexes.xmlLabel = field
      GET(self.mapIndexes, self.mapIndexes.xmlLabel)
      if not ERRORCODE()
        return self.mapIndexes.index
      end
    else
      return self.findFieldByName(field)
    end
  RETURN -1

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldValueByXMLName PROCEDURE(STRING field)
mapField CSTRING(MAX_NAME_LEN)

    CODE
    mapField = ''
    if( (not self.nameMap &= null) and self.isMappingEnabled() )
        mapField = self.nameMap.translateName(field)
    end

    if( LEN(mapField) > 0 )
        return self.getFieldValueByName(lower(mapField))
    else
        return self.getFieldValueByName(lower(field))
    end

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.setFieldValueByXMLName    PROCEDURE(STRING field, STRING value)
mapField CSTRING(MAX_NAME_LEN)
    CODE
    mapField = ''
    if( (not self.nameMap &= null) and self.isMappingEnabled() )
        mapField = self.nameMap.translateName(field, false)
    end

    if( LEN(mapField) > 0 )
        return self.setFieldValueByName(lower(mapField), value)
    end

    return self.setFieldValueByName(lower(field), value)

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldLabel     PROCEDURE(UNSIGNED cou)
    CODE
    if self.isMappingEnabled()
        get(self.mapIndexes, cou)

        if not errorCODE()
            return self.mapIndexes.clwLabel
        end
    else
        get(self.Fields, cou)

        if not errorCODE()
            return self.fields.label
        end
    end
    return 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getXMLFieldLabel  PROCEDURE(UNSIGNED cou)
    CODE
    if self.isMappingEnabled()
        get(self.mapIndexes, cou)

        if not errorCODE()
            return self.mapIndexes.xmlLabel
        end
    else
        get(self.Fields, cou)

        if not errorCODE()
            !return self.nameMap.translateName(self.fields.label)
            return self.fields.label
        end
    end
    return 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldType PROCEDURE(UNSIGNED cou)
  CODE
  if self.isMappingEnabled()
    get(self.mapIndexes, cou)
    if not errorCODE()
      cou = self.mapIndexes.index
    end
  end
  get(self.Fields, cou)
  if not errorCODE()
    return self.Fields.fldType
  end
  return 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFieldSize PROCEDURE(UNSIGNED cou, *UNSIGNED fldSize, *UNSIGNED precision)
  CODE
  if self.isMappingEnabled()
    get(self.mapIndexes, cou)
    if not errorCODE()
      cou = self.mapIndexes.index
    end
  end
  get(self.Fields, cou)
  if not errorCODE()
    fldSize   = self.Fields.fldSize
    precision = self.Fields.fldInfo
    return CPXMLErr:NoError
  end
  return CPXMLErr:NotSuccessful

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getFirstChild       PROCEDURE
    CODE
    return NULL

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getParent           PROCEDURE
    CODE
    return NULL

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getNextSibling      PROCEDURE
    CODE
    return NULL

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.updateRowPos        PROCEDURE
    CODE

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.isRowPosChanged     PROCEDURE
    CODE
    return false


!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.addField PROCEDURE(STRING label,CLType type, UNSIGNED size, UNSIGNED precision)
  CODE
  RETURN CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.loadProperties PROCEDURE
  CODE
  RETURN CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getPropertySetsCount PROCEDURE
  CODE
  RETURN 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getPropertySet PROCEDURE(UNSIGNED cou, *STRING label)
  CODE
  RETURN NULL

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.addPropertySet PROCEDURE(STRING label, PropertySet propset)
  CODE
  RETURN CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.removePropertySet PROCEDURE(UNSIGNED cou)
  CODE
  RETURN CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getRowTagName PROCEDURE
                            CODE
  if not self.nameMap &= null
    return self.nameMap.getRowTagName()
  end
  RETURN ''

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getRootTagName PROCEDURE
                             CODE
  if not self.nameMap &= null
    return self.nameMap.getRootTagName()
  end
  RETURN ''

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.build PROCEDURE
    CODE
    return 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.addRow PROCEDURE
    CODE
    return CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.isMappingEnabled  PROCEDURE
    CODE
    return self.useMap

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getNameMap        PROCEDURE
    CODE
    return self.nameMap

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getNextRow        PROCEDURE
    CODE
    return 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.startIterate      PROCEDURE
    CODE
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.getCapacity       PROCEDURE
    CODE
    !default capacity is 1
    return 1

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
StructWrapper.clearBuffer         PROCEDURE
    CODE
    return

! ======================== EOF ================================================

