! $Header: /0192-7/XMLSupport/src/GroupWrap.clw 18    5.08.03 11:55 Sergei $
!****************************************************************************
!  FILE..........: GroupWrap.CLW
!  AUTHOR........: 
!  DESCRIPTION...: Library for XML Export/Import
!  COPYRIGHT.....: Copyright 2003 SoftVelocity Inc. All rights reserved
!  HISTORY.......: DATE       COMMENT
!                  ---------- ------------------------------------------------
!                  2003-04-04 Created by Semenov Denis
!****************************************************************************

    MEMBER

    include('cpxml.inc'), once
    include('xmlclass.inc'), once

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.construct  PROCEDURE
    CODE
    self.GroupInfo &= NEW XMLGroupInfo
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.destruct  PROCEDURE
    CODE
    DISPOSE(self.GroupInfo)
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.getCapacity PROCEDURE
    CODE
    return 1

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.getNextRow PROCEDURE
retCode     byte
    CODE
    retCode = CPXMLErr:NoError

    if not self.groupData &= NULL then

        if (self.counter < 1)
            self.counter += 1
        else
            retCode = CPXMLErr:EOF
        end
     else
        retCode = CPXMLErr:IllegalFunctionCall
     end

    return retCode

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.clearBuffer PROCEDURE
    CODE
    if not self.groupData &= NULL then
        clear(self.groupData)
    end
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.Init PROCEDURE(*GROUP g, BYTE removePrefix = true)
field   unsigned(1)
typ     CLType, auto
sz      UNSIGNED, auto
prc     UNSIGNED, auto
    CODE
    if ADDRESS(g) <> 0
      if self.GroupInfo.init(g) = XIErr:NoError
        !clear
        self.kill()
        !store value
        self.groupData &= g
        self.ObjectInfo &= ADDRESS(self.GroupInfo)
        if self.ObjectInfo.startFieldsIterate() <> 0
          return CPXMLErr:InvalidArgument
        end
        !enumerate fields
        loop
          clear(self.Fields)
          self.Fields.use &= null
          !assign name of field
          self.Fields.label = self.fixPrefix(lower(who(g, field)), removePrefix)
          if not self.Fields.label
            break !finish the enumeration
          end
          if self.ObjectInfo.getNextField() <> XIErr:NoError
            break !finish the enumeration
          end
          if self.ObjectInfo.getFieldType(typ, sz, prc) <> XIErr:NoError
            break !finish the enumeration
          end
          self.Fields.use      &= what(g, field)!assign reference to the field
          self.Fields.index     = field
          self.Fields.fldType   = typ
          self.Fields.fldSize   = sz
          self.Fields.fldInfo   = prc
          add(self.Fields) !add new record to MappingQueue
          field += 1
        end
        return CPXMLErr:NoError
      end
    end
    return CPXMLErr:InvalidArgument

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.startIterate PROCEDURE
    code
    self.counter = 0

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
GroupWrapper.addRow PROCEDURE
    code
    return CPXMLErr:NoError