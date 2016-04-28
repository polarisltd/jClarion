! $Header: /0192-7/XMLSupport/src/queueWrap.clw 20    6/03/03 18:08 Sergei $
!****************************************************************************
!  FILE..........: QueueWRAP.CLW
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
QueueWrapper.construct  PROCEDURE
    CODE
    self.QueueInfo &= NEW XMLQueueInfo
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.destruct  PROCEDURE
    CODE
    DISPOSE(self.QueueInfo)
    RETURN

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.getCapacity PROCEDURE
    CODE
    return INF_CAPACITY

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.getNextRow PROCEDURE
retCode     byte
    CODE
    retCode = CPXMLErr:NoError

    if (not self.queueData &= NULL)

        if (self.counter < records(self.queueData))
            self.counter += 1
            get(self.queueData, self.counter)
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
QueueWrapper.addRow PROCEDURE
    CODE
    add(self.queueData)
    if errorcode() then
        return CPXMLErr:InternalError
    end
    return CPXMLErr:NoError

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.clearBuffer PROCEDURE
    CODE
    if not self.queueData &= NULL then
        clear(self.queueData)
    end
    return

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.Init PROCEDURE(*QUEUE q, BYTE removePrefix = true)
field   unsigned(1)
typ     CLType, auto
sz      UNSIGNED, auto
prc     UNSIGNED, auto
    CODE
    if ADDRESS(q) <> 0
      if self.QueueInfo.init(q) = XIErr:NoError then
        !clear
        self.kill()
        !store value
        self.queueData &= q
        self.ObjectInfo &= ADDRESS(self.QueueInfo)
        if self.ObjectInfo.startFieldsIterate() <> 0
          return CPXMLErr:InvalidArgument
        end
        !enumerate fields
        loop
          clear(self.Fields)
          self.Fields.use &= null
          !assign the name of the fields
          self.Fields.label = self.fixPrefix(lower(who(q, field)), removePrefix)
          if not self.Fields.label
            break  !finish the enumeration
          end
          if self.ObjectInfo.getNextField() <> XIErr:NoError
            break !finish the enumeration
          end
          if self.ObjectInfo.getFieldType(typ, sz, prc) <> XIErr:NoError
            break !finish the enumeration
          end
          self.Fields.use    &= what(q, field) !assign reference to the field
          self.Fields.index   = field
          self.Fields.fldType = typ
          self.Fields.fldSize = sz
          self.Fields.fldInfo = prc
          add(self.Fields)! add record to MappingQueue
          field += 1
        end
        return CPXMLErr:NoError
      end
    end
    return CPXMLErr:InvalidArgument

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
QueueWrapper.startIterate PROCEDURE
    code
    self.counter = 0
