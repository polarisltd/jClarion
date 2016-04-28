    member()
    map
    end

    include('abqeip.inc'),once
    include('keycodes.clw'),once


QEIPManager.Init        procedure()

Rv  byte

    code

    if SELF.Req <> InsertRecord
      If ~choice(SELF.ListControl)
        get(SELF.Q,1)
      else
        get(SELF.Q,choice(SELF.ListControl))
      end
    end

    case SELF.Req

    of InsertRecord
      clear(SELF.Q)
      add(SELF.Q, pointer(SELF.Q) + 1)

    of DeleteRecord
      delete(SELF.Q)
      assert(~errorcode())
      SELF.Response = RequestCompleted
      return Level:Fatal

    of ChangeRecord
      if keycode() = MouseLeft2
        SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
      end

    else
      assert(0)
    end

    Rv = parent.Init()

    case SELF.Req

    OF InsertRecord
      display(SELF.ListControl)
      select(SELF.ListControl, pointer(SELF.Q))
      SELF.Column = 1

    OF DeleteRecord

    OF ChangeRecord
      SELF.Fields.AssignLeftToRight()
      IF KEYCODE() = MouseLeft2
        SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
      END

    ELSE
      ASSERT(0)
    END

    RETURN Rv


QEIPManager.ClearColumn     procedure()

  code

  if SELF.LastColumn
    update
    SELF.Fields.AssignRightToLeft()
    put(SELF.Q)
    assert(~errorcode())
  end
  parent.ClearColumn()


QEIPManager.TakeCompleted procedure(byte Force)

  code

  SELF.Again = 0
  SELF.ClearColumn()
  CASE Force
  OF Button:Cancel
    SELF.Again = 1
    get(SELF.Q,Pointer(SELF.Q))
  OF Button:No
    IF SELF.Req = InsertRecord
      DELETE(SELF.Q)
      SELF.Response = RequestCancelled
    END
  OF Button:Yes
    PUT(SELF.Q)
    SELF.Response = RequestCompleted
  END
  PARENT.TakeCompleted(Force)


QEIPManager.TakeNewSelection PROCEDURE

  code

  if field() = self.ListControl

    SELF.ClearColumn()

    return choose(pointer(SELF.Q) <> choice(SELF.ListControl), Level:Fatal, PARENT.TakeNewSelection())
  else
    return(level:notify)
  end

QEIPManager.SetRequest  procedure(byte Request)

    code
    self.Req = Request
