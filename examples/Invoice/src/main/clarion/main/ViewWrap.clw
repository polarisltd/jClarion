! $Header: /0192-7/XMLSupport/src/ViewWrap.clw 15    6/03/03 18:08 Sergei $
!****************************************************************************
!  FILE..........: ViewWrap.CLW
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-07 Created by Semenov Denis
!****************************************************************************

    MEMBER

    include('cpxml.inc'), once
    include('xmlclass.inc'), once

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.construct  PROCEDURE
    CODE
    self.ViewInfo &= NEW XMLViewInfo
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.destruct  PROCEDURE
    CODE
    DISPOSE(self.ViewInfo)
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.getCapacity PROCEDURE
    CODE
    return 1

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.getNextRow PROCEDURE
retCode     byte
    CODE
    retCode = CPXMLErr:NoError

    if self.viewData &= NULL then
        return CPXMLErr:IllegalFunctionCall
    end

    next(self.viewData)

    if errorcode() then
        retCode = CPXMLErr:EOF
    end

    return retCode

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.clearBuffer PROCEDURE
    CODE
        if not self.viewData &= NULL then
            clear(self.viewData)
        end
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.Init PROCEDURE(*VIEW v, BYTE removePrefix = true)
field   unsigned(1)
f       &file
record  &group, auto
typ     CLType, auto
sz      UNSIGNED, auto
prc     UNSIGNED, auto
    CODE
    if ADDRESS(v) <> 0
      if self.ViewInfo.init(v) = XIErr:NoError then
        !clear
        self.kill()
        !store value
        self.viewData &= v
        self.ObjectInfo &= ADDRESS(self.ViewInfo)
        if self.ObjectInfo.startFieldsIterate() <> 0
          return CPXMLErr:InvalidArgument
        end
        !enumerate fields
        loop field = 1 to v{prop:Fields}
          f &= v{prop:fieldsFile, field}
          record &= f{prop:Record}
          clear(self.Fields)
          self.Fields.use &= null
          !assign field's name
          self.Fields.label = self.fixPrefix(lower(who(record, v{prop:field, field})), removePrefix)
          if self.ObjectInfo.getNextField() <> XIErr:NoError
            break !finish the enumeration
          end
          if self.ObjectInfo.getFieldType(typ, sz, prc) <> XIErr:NoError
            break !finish the enumeration
          end
          self.Fields.use    &= what(record, v{prop:field, field}) !assign reference to the field
          self.Fields.index   = field
          self.Fields.fldType = typ
          self.Fields.fldSize = sz
          self.Fields.fldInfo = prc
          add(self.Fields)
        end
        return CPXMLErr:NoError
      end
    end
    return CPXMLErr:InvalidArgument

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.startIterate PROCEDURE
    code
    set(self.viewData)

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.setFieldValueByIndex    PROCEDURE(UNSIGNED cou,STRING value)
    code
    return CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.setFieldValueByName     PROCEDURE(STRING field, STRING value)
    code
    return CPXMLErr:NotSupported

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.setFieldValueByXMLName  PROCEDURE(STRING field, STRING value)
    code
    return CPXMLErr:NotSupported

