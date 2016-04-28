    MEMBER
    
 INCLUDE('ADOProcC.INC'),ONCE
 !INCLUDE('cwado.inc'),ONCE
 include('svbase.inc'), once
 
    MAP
    END

ADOProcCommCaller.Init                                PROCEDURE(*GROUP pFieldsGroup,*CRecordset pRecordset)

 CODE
    SELF.FieldsGroup   &= pFieldsGroup
    SELF.RecordSet     &= pRecordset
    SELF.RequestAction =  0
    SELF.Response      =  0!RequestCanceled
    SELF.ChildPresent  =  0
    SELF.DateTimeQ     &= new(TDateTimeQ)
    SELF.ColNameQ      &= new(TColNameQ)

    
ADOProcCommCaller.Kill                                PROCEDURE()

 CODE
    IF SELF.ChildPresent THEN
       SELF.Child.SetNoParent()
       SELF.ChildPresent  =  0
    END
    if ~(self.DateTimeQ &= null)
      free(self.DateTimeQ)
      dispose(self.DateTimeQ)
    end
    if ~(self.ColNameQ)
      free(self.ColNameQ)
      dispose(self.ColNameQ)
    end
    
    
ADOProcCommCaller.SetRequest                          PROCEDURE(BYTE pRequestAction)

 CODE
    SELF.RequestAction = pRequestAction
    TempADOProcCommObject &= SELF
    
    
ADOProcCommCaller.GetRequest                          PROCEDURE()!InsertRecord DeleteRecord ChangeRecord ViewRecord

 CODE
    RETURN SELF.RequestAction
    
    
ADOProcCommCaller.GetResponse                         PROCEDURE()! RequestCompleted RequestCanceled

 CODE
    RETURN SELF.Response
    
    
ADOProcCommCaller.SetFields                           PROCEDURE(*GROUP pFieldsGroup)

 CODE
    SELF.FieldsGroup   &= pFieldsGroup
    
    
ADOProcCommCaller.SetRecordSet                        PROCEDURE(*CRecordset pRecordset)

 CODE
    SELF.RecordSet     &= pRecordset
    
    
ADOProcCommCaller.GetFieldsStatement                  PROCEDURE()

LOC:Index       SHORT
LOC:Statement   STRING(ADOMaxStatementSize)
loc:Any         any

DateGroup       group
grpDate           date
grpTime           time
                end



 CODE
   LOC:Statement=''
   LOC:Index=1
   LOOP
      IF UPPER(WHO(SELF.FieldsGroup, LOC:Index))
         self.ColNameQ.LocGrpName = UPPER(WHO(SELF.FieldsGroup, LOC:Index))
         get(self.ColNameQ, self.ColNameQ.LocGrpName)
         if errorcode()
           self.ColNameQ.ColName = choose(self.UsePrefix = true,  WHO(SELF.FieldsGroup, LOC:Index), self.RemovePrefix(WHO(SELF.FieldsGroup, LOC:Index)) )
         end
         loc:Any &= what(SELF.FieldsGroup, LOC:Index)
         SELF.DateTimeQ.ColName = upper(clip(WHO(SELF.FieldsGroup, LOC:Index)))
         ! Lookup in the DateTimeQ to know if the column is a date or time column
         get(self.DateTimeQ, self.DateTimeQ.ColName)
         if errorcode()  ! Column is not a date or time column
           LOC:Statement = CLIP(LOC:Statement) & ' ' &|
                           clip(self.ColNameQ.ColName) &|
           ' = ' &|
           CHOOSE(ISSTRING(loc:Any),'''', '') &|
           CHOOSE(ISSTRING(loc:Any), Quote(loc:Any, 1), clip(Loc:Any)) &|
           CHOOSE(ISSTRING(loc:Any),'''', '') & ' AND'

         else
           if upper(self.DateTimeQ.DateTimeID) = 'G'  ! We are dealing with the string(8) rather then group members
                     DateGroup = loc:Any
                     LOC:Statement = CLIP(LOC:Statement) & ' ' &|
                                     clip(self.ColNameQ.ColName) & ' = ''' &|
                                     format(DateGroup.grpDate, @d10) & ' ' & format(DateGroup.grpTime, @t04) & '''' & ' AND'
           else
           ! Column is a date or time type, look at the DateTimeID   (DateTimeID be a 'D' or a 'T')
             LOC:Statement = CLIP(LOC:Statement) & ' ' &|
                             clip(self.ColNameQ.ColName) &|
                             ' = ''' &|
                             CHOOSE(upper(self.DateTimeQ.DateTimeID) = 'D', format(loc:Any, @d2), format(loc:Any, @t4)) &|
                             ''' AND'
           end
         end
         loc:Any &= null
         LOC:Index += 1
      ELSE
        BREAK   ! No more field in the group
      END
   END
   IF CLIP(LOC:Statement)
      RETURN CLIP(LOC:Statement[1:(LEN(CLIP(LOC:Statement))-4)])
   ELSE
      RETURN ''
   END
   
   
ADOProcCommCaller.UpdateFields                        PROCEDURE(FILE pFile,KEY parKey)

LOC:IndexK      SHORT
LOC:IndexG      SHORT
LOC:ANYField    ANY
LOC:Group       &GROUP
LOC:Pos         long

 CODE
   free(self.ColNameQ)
   LOC:Group &= pFile{PROP:Record}
   LOOP LOC:IndexK = 1 TO parKey{PROP:Components}
        LOC:IndexG=1
        LOOP
           IF UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
              IF UPPER(pFile{PROP:Label,parKey{PROP:Field,LOC:IndexK}}) = UPPER(WHO(SELF.FieldsGroup, LOC:IndexG)) THEN
                 LOC:ANYField &= WHAT(SELF.FieldsGroup, LOC:IndexG)
                 LOC:ANYField = WHAT(LOC:Group, parKey{PROP:Field,LOC:IndexK})
                 self.ColNameQ.LocGrpName = UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
                 self.ColNameQ.ColName = self.RemovePrefix(who(LOC:Group, parKey{PROP:Field,LOC:IndexK}))
                 loc:Pos = instring('|', self.ColNameQ.ColName, 1, 1)
                 if loc:Pos
                   self.ColNameQ.ColName = self.ColNameQ.ColName[1 : Loc:Pos - 1]
                 end
                 add(self.ColNameQ, self.ColNameQ.LocGrpName)
              END
              LOC:IndexG += 1
           ELSE
             BREAK   ! No more field in the group
           END
        END
   END
   
   
ADOProcCommCaller.GetFieldsStatement                  PROCEDURE(FILE pFile,KEY parKey)

LOC:IndexK      SHORT
LOC:IndexG      SHORT
LOC:Statement   STRING(ADOMaxStatementSize)
loc:Any         any
loc:tmpFldName  string(128)

DateGroup       group
grpDate           date
grpTime           time
                end


 CODE
   LOC:Statement=''
   LOOP LOC:IndexK = 1 TO parKey{PROP:Components}
        LOC:IndexG=1
        LOOP
           IF UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
              IF UPPER(pFile{PROP:Label,parKey{PROP:Field,LOC:IndexK}}) = UPPER(WHO(SELF.FieldsGroup, LOC:IndexG)) THEN
                 self.ColNameQ.LocGrpName = UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
                 get(self.ColNameQ, self.ColNameQ.LocGrpName)
                 if errorcode()
                   self.ColNameQ.ColName = UPPER(pFile{PROP:Label,parKey{PROP:Field,LOC:IndexK}})
                 end
                 loc:Any &= WHAT(SELF.FieldsGroup, LOC:IndexG)
                 loc:TmpFldName = choose(self.UsePrefix = true, WHO(SELF.FieldsGroup, LOC:IndexG), self.RemovePrefix(WHO(SELF.FieldsGroup, LOC:IndexG)))
                 self.DateTimeQ.ColName = upper(clip(loc:TmpFldName))
                 get(self.DateTimeQ, self.DateTimeQ.ColName)
                 if errorcode()

                   if isstring(loc:Any)
                     LOC:Statement=CLIP(LOC:Statement) & ' ' &|
                                   clip(self.ColNameQ.ColName) & ' = ''' &|
                                   Quote(loc:Any, 1) & '''' & ' AND'
                   else
                     LOC:Statement=CLIP(LOC:Statement) & ' ' & clip(self.ColNameQ.ColName) & ' = ' & loc:Any & ' AND'
                   end
                 else
                   if upper(self.DateTimeQ.DateTimeID) = 'G'  ! We are dealing with the string(8) rather then group members
                     DateGroup = loc:Any
                     LOC:Statement = CLIP(LOC:Statement) & ' ' &|
                                     clip(self.ColNameQ.ColName) & ' = ''' &|
                                     format(DateGroup.grpDate, @d10) & ' ' & format(DateGroup.grpTime, @t04) & '''' & ' AND'
                   else
                   LOC:Statement = CLIP(LOC:Statement) & ' ' &|
                                   clip(self.ColNameQ.ColName) & ' = ''' &|
                                   choose(upper(self.DateTimeQ.DateTimeID) = 'D', format(loc:Any, @d10), format(loc:Any, @t4) ) & '''' & ' AND'
                   end
                 end
                 loc:Any &= null
              END
              LOC:IndexG += 1
           ELSE
             BREAK   ! No more field in the group
           END
        END
   END
   IF CLIP(LOC:Statement)
      RETURN CLIP(LOC:Statement[1:(LEN(CLIP(LOC:Statement))-4)])
   ELSE
      RETURN ''
   END
   
   
ADOProcCommCaller.GetFieldsStatement                  PROCEDURE(STRING p1,<STRING p2>,<STRING p3>,<STRING p4>,<STRING p5>,<STRING p6>,<STRING p7>,<STRING p8>,<STRING p9>,<STRING p10>,<STRING p11>,<STRING p12>,<STRING p13>,<STRING p14>,<STRING p15>)

LOC:IndexK      SHORT
LOC:IndexG      SHORT
LOC:Statement   STRING(ADOMaxStatementSize)
loc:Any         any
loc:TmpFldName  string(128)

 CODE
   LOC:Statement=''
   LOC:IndexG=1
   LOOP
      IF UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
         IF UPPER(p1)=UPPER(WHO(SELF.FieldsGroup, LOC:IndexG)) THEN
            loc:Any &= WHAT(SELF.FieldsGroup, LOC:IndexG)
            loc:TmpFldName = choose(self.UsePrefix = true, WHO(SELF.FieldsGroup, LOC:IndexG), self.RemovePrefix(WHO(SELF.FieldsGroup, LOC:IndexG)))
            self.DateTimeQ.ColName = upper(clip(loc:TmpFldName))
            get(self.DateTimeQ, self.DateTimeQ.ColName)
            if errorcode()
              if isstring(loc:Any)
                LOC:Statement = CLIP(LOC:Statement) & ' ' & WHO(SELF.FieldsGroup, LOC:IndexG) & ' = ''' & Quote(Loc:Any, 1) & '''' & ' AND'
              else
                LOC:Statement = CLIP(LOC:Statement) & ' ' & WHO(SELF.FieldsGroup, LOC:IndexG) & ' = ' & loc:Any & ' AND'
              end
            else
              LOC:Statement = CLIP(LOC:Statement) & ' ' & WHO(SELF.FieldsGroup, LOC:IndexG) & ' = ''' & choose(upper(self.DateTimeQ.DateTimeID) = 'D', format(Loc:Any, @d10), format(loc:Any, @t4) ) & '''' & ' AND'
            end
            loc:Any &= null
         END
         LOC:IndexG += 1
      ELSE
        BREAK   ! No more field in the group
      END
   END
   LOOP LOC:IndexK = 4 TO 17
        IF NOT OMITTED(LOC:IndexK)
           LOC:IndexG=1
           LOOP
              IF UPPER(WHO(SELF.FieldsGroup, LOC:IndexG))
                 IF UPPER(CHOOSE(LOC:IndexK-3,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15)) = UPPER(WHO(SELF.FieldsGroup, LOC:IndexG)) THEN
                    loc:Any &= what(SELF.FieldsGroup, LOC:IndexG)
                    loc:TmpFldName = choose(self.UsePrefix = true, WHO(SELF.FieldsGroup, LOC:IndexG), self.RemovePrefix(WHO(SELF.FieldsGroup, LOC:IndexG)))
                    self.DateTimeQ.ColName = upper(clip(loc:TmpFldName))
                    get(self.DateTimeQ, self.DateTimeQ.ColName)
                    if errorcode()
                      if isstring(loc:Any)
                        LOC:Statement = CLIP(LOC:Statement) & ' ' & clip(loc:tmpFldName) & ' = ''' & clip(Quote(loc:Any, 1)) & '''' & ' AND'
                      else
                        LOC:Statement = CLIP(LOC:Statement) & ' ' & clip(loc:tmpFldName) & ' = ' & loc:Any & ' AND'
                      end
                    else
                      LOC:Statement = CLIP(LOC:Statement) & ' ' & WHO(SELF.FieldsGroup, LOC:IndexG) & ' = ''' & choose(upper(self.DateTimeQ.DateTimeID) = 'D', format(Loc:Any, @d10), format(loc:Any, @t4) ) & '''' & ' AND'
                    end
                    loc:Any &= null
                 END
                 LOC:IndexG += 1
              ELSE
                BREAK   ! No more field in the group
              END
           END
        END
   END
   IF CLIP(LOC:Statement)
      RETURN CLIP(LOC:Statement[1:(LEN(CLIP(LOC:Statement))-4)])
   ELSE
      RETURN ''
   END


ADOProcCommCaller.GetStatement                        PROCEDURE(*GROUP pFieldsGroup)

LOC:Index       SHORT
LOC:Statement   STRING(ADOMaxStatementSize)
LOC:Any         any

 CODE
     LOC:Index = 1
     LOOP
        IF WHO(pFieldsGroup, LOC:Index)
           self.ColNameQ.locGrpName = upper(WHO(pFieldsGroup, LOC:Index))
           get(self.ColnameQ, self.ColNameQ.LocGrpName)
           if errorcode()
             self.ColNameQ.ColName = upper(WHO(pFieldsGroup, LOC:Index))
           end
           LOC:Any &= what(pFieldsGroup, LOC:Index)
           self.DateTimeQ.ColName = upper(clip(WHO(pFieldsGroup, LOC:Index)))
           get(self.DateTimeQ, self.DateTimeQ.ColName)
           if errorcode()
             LOC:Statement = CLIP(LOC:Statement) & ' ' & clip(self.ColNameQ.ColName) & ' = ' &|
                             CHOOSE(ISSTRING(WHAT(pFieldsGroup, LOC:Index)),'''', '') &|
                             choose(isstring(loc:Any), clip(Quote(LOC:Any, 1)), clip(loc:Any)) &|
                             CHOOSE(ISSTRING(WHAT(pFieldsGroup, LOC:Index)),'''', '') & ' AND'
           else
             LOC:Statement = CLIP(LOC:Statement) & ' ' & clip(self.ColNameQ.ColName) & ' = ''' &|
                             choose( upper(self.DateTimeQ.DateTimeID) = 'D', format(LOC:Any, @d10), format(loc:Any, @t4) ) & ''' AND'
           end
           LOC:Index += 1
           loc:ANy &= null
        ELSE
           BREAK
        END
     END
     IF CLIP(LOC:Statement)
        RETURN CLIP(LOC:Statement[1:(LEN(CLIP(LOC:Statement))-4)])
     ELSE
        RETURN ''
     END
     
     
ADOProcCommCaller.GetStatementAndKey                  PROCEDURE(*GROUP pFieldsGroup)

LOC:Index       SHORT
LOC:IndexG      SHORT
LOC:Statement   STRING(ADOMaxStatementSize)
LOC:Found       BYTE
loc:Any         any

 CODE
     LOC:Statement = SELF.GetFieldsStatement() & ' AND'
     
     LOC:Index = 1
     LOOP
        IF WHO(pFieldsGroup, LOC:Index)
           !IF FIELD IS NOT INTO THE KEY GROUP IT ADDED
           LOC:Found = False
           LOC:IndexG=1
           ! try to find if the field is currently in the inernal SELF.FieldsGroup
           LOOP
             if upper(WHO(SELF.FieldsGroup, LOC:IndexG))
               IF UPPER(WHO(SELF.FieldsGroup, LOC:IndexG)) = UPPER(WHO(pFieldsGroup, LOC:Index)) THEN
                  LOC:Found = True
                  BREAK
               else
                 loc:IndexG += 1
               end
             else
               break
             end
           END
           IF LOC:Found = False THEN

              loc:Any &= WHAT(pFieldsGroup, LOC:Index)
              self.DateTimeQ.ColName = upper(clip(WHO(pFieldsGroup, LOC:Index)))
              get(self.DateTimeQ, self.DateTimeQ.ColName)
              if errorcode()
                loc:Statement =  CLIP(LOC:Statement) & ' ' & WHO(pFieldsGroup, LOC:Index) & ' = ' & CHOOSE(ISSTRING(LOC:Any),'''', '')

                if isstring(loc:Any)
                  loc:Statement = clip(loc:Statement) & clip(Quote(loc:Any, 1))
                else
                  loc:Statement = clip(loc:Statement) & loc:Any
                end

                loc:Statement = clip(loc:Statement) & CHOOSE(ISSTRING(LOC:Any),'''', '') & ' AND'
              else
                loc:Statement = CLIP(LOC:Statement) & ' ' & WHO(pFieldsGroup, LOC:Index) & ' = '''
                loc:Statement = clip(loc:Statement) & choose(upper(self.DateTimeQ.DateTimeID) = 'D', format(loc:Any, @d10), format(loc:Any, @t4))
                loc:Statement = clip(loc:Statement) & ''' AND'
              end

              loc:Any &= null
           END
           LOC:Index += 1
        ELSE
           BREAK
        END
     END

     IF CLIP(LOC:Statement)
        RETURN CLIP(LOC:Statement[1:(LEN(CLIP(LOC:Statement))-4)])
     ELSE
        RETURN ''
     END


ADOProcCommCaller.SetNoChild                          PROCEDURE()

 CODE
     SELF.Child       &= NULL
     SELF.ChildPresent = 0
     
     
ADOProcCommCaller.SetChild                            PROCEDURE(*ADOProcCommCalled pChild)

 CODE
     SELF.Child       &= pChild
     SELF.ChildPresent = 1
     SELF.Response     = 0!RequestCanceled
     
     
ADOProcCommCaller.RemovePrefix                        procedure(string pStr)

Pos    long

  code
    Pos = instring(':', clip(pStr))
    if Pos
      return(pStr[Pos + 1 : len(clip(pStr))])
    else
      return(pStr)
    end  
     
     
!**********************************************************************************

ADOProcCommCalled.Init                                PROCEDURE()

 CODE
   IF NOT(TempADOProcCommObject &= NULL) THEN
      SELF.Caller &= TempADOProcCommObject
      TempADOProcCommObject &= NULL
      SELF.ParentPresent=1
      SELF.Caller.SetChild(SELF)
   ELSE
      SELF.Caller &= NULL
      SELF.ParentPresent=0
      ASSERT(False)
   END
   self.DateTimeQ &= new(TDateTimeQ)
   
   
ADOProcCommCalled.Kill                                PROCEDURE()

 CODE
   IF SELF.ParentPresent THEN
      SELF.Caller.SetNoChild()
   END
   free(self.DateTimeQ)
   dispose(self.DateTimeQ)
   
   
ADOProcCommCalled.SetNoParent                         PROCEDURE()

 CODE
      SELF.ParentPresent = 0
      SELF.Caller &= NULL
      
      
ADOProcCommCalled.SetResponse                         PROCEDURE(BYTE pResponse)! RequestCompleted RequestCanceled

 CODE
   IF SELF.ParentPresent THEN
      SELF.Caller.Response = pResponse
   ELSE
      ASSERT(False)
   END
   
   
ADOProcCommCalled.GetRequest                          PROCEDURE()

 CODE
   IF SELF.ParentPresent THEN
      RETURN SELF.Caller.RequestAction
   ELSE
      ASSERT(False)
      RETURN 0
   END
   
   
ADOProcCommCalled.GetFields                           PROCEDURE(*GROUP pFieldsGroup)

 CODE
   IF SELF.ParentPresent THEN
      pFieldsGroup = SELF.Caller.FieldsGroup
   ELSE
      ASSERT(False)
   END
   
   
ADOProcCommCalled.GetRecordSet                        PROCEDURE()

 CODE
   IF SELF.ParentPresent THEN
      RETURN SELF.Caller.RecordSet
   ELSE
      ASSERT(False)
      RETURN 0
   END


ADOProcCommCalled.GetStatement                        PROCEDURE(*GROUP pFieldsGroup)

 CODE
   IF SELF.ParentPresent THEN
      RETURN(SELF.Caller.GetStatement(pFieldsGroup))
   ELSE
      ASSERT(False)
      RETURN('')
   END
   
   
ADOProcCommCalled.GetFieldsStatement                  PROCEDURE()

 CODE
   IF SELF.ParentPresent THEN
      RETURN(SELF.Caller.GetFieldsStatement())
   ELSE
      ASSERT(False)
      RETURN('')
   END
   
   
ADOProcCommCalled.GetFieldsStatement                  PROCEDURE(FILE pFile,KEY parKey)

 CODE
   IF SELF.ParentPresent THEN
      RETURN(SELF.Caller.GetFieldsStatement(pFile,parKey))
   ELSE
      ASSERT(False)
      RETURN('')
   END


ADOProcCommCalled.GetFieldsStatement                  PROCEDURE(STRING p1,<STRING p2>,<STRING p3>,<STRING p4>,<STRING p5>,<STRING p6>,<STRING p7>,<STRING p8>,<STRING p9>,<STRING p10>,<STRING p11>,<STRING p12>,<STRING p13>,<STRING p14>,<STRING p15>)

 CODE
   IF SELF.ParentPresent THEN
      RETURN(SELF.Caller.GetFieldsStatement(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15))
   ELSE
      ASSERT(False)
      RETURN('')
   END
   
   
ADOProcCommCalled.GetStatementAndKey                  PROCEDURE(*GROUP pFieldsGroup)

 CODE
   IF SELF.ParentPresent THEN
      RETURN(SELF.Caller.GetStatementAndKey(pFieldsGroup))
   ELSE
      ASSERT(False)
      RETURN('')
   END
