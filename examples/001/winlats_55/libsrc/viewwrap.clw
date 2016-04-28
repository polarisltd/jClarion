! $Header: /0192-7(XML support)/XMLSupport/src/ViewWrap.clw 18    10/21/03 2:21p Mal $
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
fld     LONG
memoIdx LONG
blobIdx LONG
atr    LONG
rc      BYTE
    CODE
    if ADDRESS(v) <> 0
      if self.ViewInfo.init(v) = XIErr:NoError then
        !clear
        self.kill()
        !store value
        self.viewData &= v
        self.ObjectInfo &= ADDRESS(self.ViewInfo)
        if self.ObjectInfo.startFieldsIterate(ITER:ALL) <> 0
          return CPXMLErr:InvalidArgument
        end
        !enumerate fields
        loop field = 1 to v{prop:Fields}
          f &= v{prop:fieldsFile, field}
          fld=v{prop:field, field}  
          clear(self.Fields)                   
          self.Fields.use &= null  
          
          
          if self.ObjectInfo.getNextField() <> XIErr:NoError
            break !finish the enumeration
          end
          if self.ObjectInfo.getFieldType(typ, sz, prc) <> XIErr:NoError
            break !finish the enumeration
          end
          IF(NOT typ=CLType:MEMO)  
            record &= f{prop:Record}
            !assign field's name
            self.Fields.label = self.fixPrefix(lower(who(record,fld)), removePrefix)          
            self.Fields.use    &= what(record, v{prop:field, field}) !assign reference to the field
          ELSE
            !memo/blob case
            rc=self.ObjectInfo.getFieldInfo(blobIdx,memoIdx,atr)
            self.Fields.label = self.fixPrefix(lower(self.ObjectInfo.getFieldLabel()), removePrefix)          
            self.Fields.blobMemoIdx=blobIdx
            self.Fields.memoIdx=memoIdx
            self.Fields.attr=atr
          END    
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

!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------

ViewWrapper.getCurrentValue           PROCEDURE!, string, PROTECTED,VIRTUAL 
blobIdx        UNSIGNED
memoIdx        UNSIGNED
fld            LONG
fl             &FILE
sz             UNSIGNED
_              GROUP
FCB              &FILE
Num              USHORT
               END
G              GROUP
Ref              &BLOB
               END

        CODE
        IF(NOT self.Fields.fldType=CLType:MEMO)
            RETURN PARENT.getCurrentValue()
        END
        !BLOB/MEMO case
        blobIdx=self.Fields.blobMemoIdx
        memoIdx=self.Fields.memoIdx
        fld=self.Fields.index
        fl&=self.viewData{PROP:FieldsFile,fld}
        IF(self.Fields.fldSize=-1)
            !BLOB case
            
            _.FCB&=fl
            _.Num=blobIdx
            G=_
            
            sz=G.Ref{PROP:Size}
            IF(sz=0)
                RETURN ''
            ELSE
                RETURN G.Ref[0:sz-1]
            END
        ELSE
            !MEMO case
            IF BAND(CLMEMO:BINARY,self.Fields.attr)
                RETURN clipNull(fl{PROP:TEXT,-memoIdx})
            ELSE
                RETURN clip(fl{PROP:TEXT,-memoIdx})
            END
        END                                        
!------------------------------------------------------------------------------
!
!------------------------------------------------------------------------------
ViewWrapper.setCurrentValue           PROCEDURE(string val)!, PROTECTED,VIRTUAL
            code
            return 
 
