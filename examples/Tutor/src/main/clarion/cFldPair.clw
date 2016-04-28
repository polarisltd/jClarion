    member
    map
    end

    include('cFldPair.inc'), once

cFieldPair.construct             procedure

    code
    self.FieldsPairQ &= new(TFieldsPairQ)
?   assert(self.FieldsPairQ)

cFieldPair.destruct              procedure

    code
    if self.FieldsPairQ
      free(self.FieldsPairQ)
      dispose(self.FieldsPairQ)
    end


cFieldPair.AddFields             procedure(*? pLeft, *? pRight)

    code
    clear(SELF.FieldsPairQ)
    SELF.FieldsPairQ.LeftField &= null
    SELF.FieldsPairQ.RightField &= null
    SELF.FieldsPairQ.LeftField &= pLeft
    SELF.FieldsPairQ.RightField &= pRight
    add(SELF.FieldsPairQ)

cFieldPair.AssignLeftToRight     procedure

ndx     long

    code
    loop ndx = 1 to records(SELF.FieldsPairQ)
      get(SELF.FieldsPairQ, ndx)
      SELF.FieldsPairQ.RightField = SELF.FieldsPairQ.LeftField
    end

cFieldPair.AssignRightToLeft     procedure

ndx     long

    code
    loop ndx = 1 to records(SELF.FieldsPairQ)
      get(SELF.FieldsPairQ, ndx)
      SELF.FieldsPairQ.LeftField = SELF.FieldsPairQ.RightField
    end


cFieldPair.Equal                 procedure

ndx     long
RetVal  byte

    code
    RetVal = true
    loop ndx = 1 to records(SELF.FieldsPairQ)
      get(SELF.FieldsPairQ, ndx)
      if SELF.FieldsPairQ.LeftField <> SELF.FieldsPairQ.RightField
        RetVal = false
        break
      end
    end
    return(RetVal)
