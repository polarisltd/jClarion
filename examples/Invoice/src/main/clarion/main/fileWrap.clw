! $Header: /0192-7/XMLSupport/src/fileWrap.clw 33    6/11/03 13:32 Sergei $
!****************************************************************************
!  FILE..........: FileWrap.CLW
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-02 Created by Semenov Denis
!****************************************************************************

    MEMBER

    include('cpxml.inc'), once
    include('xmlclass.inc'), once

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.construct  PROCEDURE
    CODE
    self.FileInfo     &= 0
    self.Properties   &= NEW PropertyList
    self.removePrefix  = FALSE
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.destruct  PROCEDURE
    CODE
    if ADDRESS(self.FileInfo) <> 0
      DISPOSE(self.FileInfo)
    end
    LOOP I# = 1 TO RECORDS(self.Properties) BY 1
      GET(self.Properties, I#)
      if errorcode() = 0
        if not self.Properties.Set &= null
          free(self.Properties.Set)
          DISPOSE(self.Properties.Set)
        end
        if not self.Properties.Decl &= null
          free(self.Properties.Decl)
          DISPOSE(self.Properties.Decl)
        end
      end
    END
    free(self.Properties)
    DISPOSE(self.Properties)
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.getCapacity PROCEDURE
    CODE
    return INF_CAPACITY

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.getNextRow PROCEDURE
retCode     byte
    CODE
    retCode = CPXMLErr:NoError

    if self.fileData &= NULL then
        return CPXMLErr:IllegalFunctionCall
    end

    next(self.fileData)

    if errorcode() then
        retCode = CPXMLErr:EOF
    end

    return retCode

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.addRow PROCEDURE
    CODE
    add(self.fileData)
    if errorcode() then
        return CPXMLErr:AddRecordFailed
    end
    return CPXMLErr:NoError

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.clearBuffer PROCEDURE
    CODE
    if not self.fileData &= NULL then
        clear(self.fileData)
    end
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.Init PROCEDURE(*FILE f, BYTE removePrefix = true)
record    &group, auto
typ       CLType, auto
sz        UNSIGNED, auto
prc       UNSIGNED, auto
field     UNSIGNED(1)
    CODE
    if ADDRESS(f) <> 0
      if ADDRESS(self.FileInfo) <> 0
        DISPOSE(self.FileInfo)
      end
      self.FileInfo &= NEW XMLFileInfo
      if self.FileInfo.init(f) = XIErr:NoError then
        self.label = f{prop:label}
        record &= f{prop:Record}
        !clear
        self.kill()
        !store value
        self.fileData &= f
        self.ObjectInfo &= ADDRESS(self.FileInfo)
        if self.ObjectInfo.startFieldsIterate() <> 0
          return CPXMLErr:InvalidArgument
        end
        self.removePrefix = removePrefix
        !enumerate fields
        loop
          clear(self.Fields)
          self.Fields.use &= null
          !assign filed's name
          self.Fields.label = self.fixPrefix(lower(who(record, field)), removePrefix)
          if not self.Fields.label
            break !finish the enumeration
          end
          if self.ObjectInfo.getNextField() <> XIErr:NoError
            break !finish the enumeration
          end
          if self.ObjectInfo.getFieldType(typ, sz, prc) <> XIErr:NoError
            break !finish the enumeration
          end
          self.Fields.use    &= what(record, field) !assign reference to the field
          self.Fields.index   = field
          self.Fields.fldType = typ
          self.Fields.fldSize = sz
          self.Fields.fldInfo = prc
          add(self.Fields) !add the new record to the MappingQueue
          field += 1
        end
        if self.loadProperties() = CPXMLErr:NoError
          return CPXMLErr:NoError
        end
      end
    end
    return CPXMLErr:InvalidArgument

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.startIterate PROCEDURE
    code
    self.counter = 0
    set(self.fileData)

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.loadProperties PROCEDURE
PropSet     &PropertySet
PropDecl    &PropertySet
cou         UNSIGNED
label       STRING(MAX_NAME_LEN)
name        STRING(MAX_NAME_LEN)
Decl        STRING(MAX_NAME_LEN)
Attrs       UNSIGNED
s           STRING(MAX_NAME_LEN)
field       STRING(MAX_NAME_LEN)
i           UNSIGNED
start       UNSIGNED
len         UNSIGNED
result      LONG
  CODE
  LOOP I# = 1 TO RECORDS(self.Properties) BY 1
    GET(self.Properties, I#)
    if errorcode() = 0
      if not self.Properties.Set &= null
        free(self.Properties.Set)
        DISPOSE(self.Properties.Set)
      end
      if not self.Properties.Decl &= null
        free(self.Properties.Decl)
        DISPOSE(self.Properties.Decl)
      end
    end
  END
  free(self.Properties)
  ! enum keys
  loop cou = 1 TO self.FileInfo.getKeysCount() BY 1
    if self.FileInfo.getKey(cou, label, name, Decl, Attrs) <> XIErr:NoError
      break !finish the enumeration
    end
    if BAND(Attrs, CLKEY:DYNINDEX) = 0
      PropDecl &= NEW PropertySet
      ! declaration
      s = clip(left(Decl))
      start = 1
      loop
        i = instring(',', s, 1, start)
        if i <> 0 then
          len = i - start
          field = clip(left(sub(s, start, len)))
        else
          len = len(field)
          field = clip(left(sub(s, start, len)))
        end
        if len(field) > 0
          if field[1] = '+' or field[1] = '-' then
            if field[1] = '+' then
              PropDecl.Name = '+'
            else
              PropDecl.Name = '-'
            end
            PropDecl.Value = self.fixPrefix(lower(sub(field, 2, len)), self.removePrefix)
          else
            PropDecl.Name = ''
            PropDecl.Value = self.fixPrefix(lower(field), self.removePrefix)
          end
          ADD(PropDecl)
        end
        if i = 0
          break
        end
        start = i + 1
      end
      s = ''
      result = 0
      loop I# = 1 TO RECORDS(PropDecl) BY 1
        GET(PropDecl, I#)
        if errorcode() = 0
          if self.isMappingEnabled() then
            self.mapIndexes.clwLabel = LOWER(PropDecl.Value)
            GET(self.mapIndexes, self.mapIndexes.clwLabel)
            result = errorcode()
            if result <> 0
              break
            end
            s = clip(s) & clip(PropDecl.Name) & clip(self.mapIndexes.xmlLabel)
          else
            s = clip(s) & clip(PropDecl.Name) & clip(PropDecl.Value)
          end
          if I# < RECORDS(PropDecl)
            s = clip(s) & ','
          end
        end
      end
      ! test result
      if result = 0 then
        ! create property set
        PropSet &= NEW PropertySet
        self.Properties.label = 'index'
        self.Properties.Set  &= PropSet
        self.Properties.Decl &= PropDecl
        ADD(self.Properties)
        ! label
        PropSet.Name  = 'KeyLabel'
        PropSet.Value = self.fixPrefix(lower(label), self.removePrefix)
        ADD(PropSet)
        ! name
        PropSet.Name  = 'KeyName'
        PropSet.Value = name
        ADD(PropSet)
        ! declaration
        PropSet.Name  = 'KeyFields'
        PropSet.Value = s
        ADD(PropSet)
        ! dup
        if not BAND(Attrs, CLKEY:INDEX)
          PropSet.Name  = 'dup'
          if BAND(Attrs, CLKEY:DUP) then
            PropSet.Value = 'yes'
          else
            PropSet.Value = 'no'
          end
          ADD(PropSet)
          ! primary
          PropSet.Name  = 'primary'
          if BAND(Attrs, CLKEY:PRIMARY) then
            PropSet.Value = 'yes'
          else
            PropSet.Value = 'no'
          end
          ADD(PropSet)
        end
        ! opt
        PropSet.Name  = 'opt'
        if BAND(Attrs, CLKEY:OPT) then
          PropSet.Value = 'yes'
        else
          PropSet.Value = 'no'
        end
        ADD(PropSet)
        ! nocase
        PropSet.Name  = 'nocase'
        if BAND(Attrs, CLKEY:NOCASE) then
          PropSet.Value = 'yes'
        else
          PropSet.Value = 'no'
        end
        ADD(PropSet)
        ! autoinc
        PropSet.Name  = 'autoinc'
        if BAND(Attrs, CLKEY:AUTOINC) then
          PropSet.Value = 'yes'
        else
          PropSet.Value = 'no'
        end
        ADD(PropSet)
        ! index
        PropSet.Name  = 'index'
        if BAND(Attrs, CLKEY:INDEX) then
          PropSet.Value = 'yes'
        else
          PropSet.Value = 'no'
        end
        ADD(PropSet)
      else
        DISPOSE(PropDecl)
      end
    end
  end
  return CPXMLErr:NoError

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.getPropertySetsCount PROCEDURE
  CODE
  RETURN RECORDS(self.Properties)

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.getPropertySet PROCEDURE(UNSIGNED cou, *STRING label)
  CODE
  if self.getPropertySetsCount() > cou OR self.getPropertySetsCount() = cou
    GET(self.Properties, cou)
    if errorcode() = 0
      label = self.Properties.Label
      return self.Properties.Set
    end
  end
  RETURN NULL

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.addPropertySet PROCEDURE(STRING label, PropertySet propset)
  CODE
  RETURN CPXMLErr:NotSuccessful

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
FileWrapper.removePropertySet PROCEDURE(UNSIGNED cou)
  CODE
  RETURN CPXMLErr:NotSuccessful
