  MEMBER
  MAP
  .

  INCLUDE('ABGRID.INC'),ONCE
  INCLUDE('LAYVALUE.INT'),ONCE
  INCLUDE('ABLWINR.INC'),ONCE

  INCLUDE('WBHTMLC.INC'),ONCE

A:Rows          ASTRING('Rows')
A:Columns       ASTRING('Columns')
A:NextRecord    ASTRING('NextRecord')
A:Reset         ASTRING('Reset')
A:ResetSelected ASTRING('ResetSelected')
A:MoreRecords   ASTRING('MoreRecords')
A:Record        ASTRING('Record')
A:ViewOnly      ASTRING('ViewOnly')
A:Selected      ASTRING('Selected')
A:Selectable    ASTRING('Selectable')


! WbGridHtmlProperties Impl.
! ========================

WbGridHtmlProperties.Construct PROCEDURE
  CODE
  SELF.ResponseQ &= NEW ResponseQType


WbGridHtmlProperties.Destruct PROCEDURE
  CODE
  SELF.ClearResponseQ
  DISPOSE(SELF.ResponseQ)


WbGridHtmlProperties.ClearResponseQ PROCEDURE
  CODE
  LOOP I#=1 TO RECORDS(SELF.ResponseQ)
    GET(SELF.ResponseQ, I#)
    DISPOSE(SELF.ResponseQ.Control)
    DISPOSE(SELF.ResponseQ.Value)
  END
  FREE(SELF.ResponseQ)


WbGridHtmlProperties.Init PROCEDURE(WbWindowClass WebWindow, GridClass Grid, SIGNED Feq, SIGNED Container)
  CODE
  SELF.Grid &= Grid
  PARENT.Init(Feq, Container)
  SELF.SubmitOnChange = true
  SELF.ViewOnly = false
  SELF.WebWindow &= WebWindow

WbGridHtmlProperties.GetProperty PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
  CODE
  IF A:Rows = name
    RETURN CreateIntegerValue(SELF.Grid.GetDown())
  ELSIF A:Columns = name
    RETURN CreateIntegerValue(SELF.Grid.GetAcross())
  ELSIF A:Record = name
    RETURN CreateIntegerValue(SELF.Record)
  ELSIF A:MoreRecords = name
    RETURN CreateBoolValue(CHOOSE(SELF.Record<=SELF.Grid.Records()))
  ELSIF A:Selected = name
    RETURN CreateIntegerValue(SELF.Grid.ILC.Choice())
  ELSIF A:Selectable = name
    RETURN CreateBoolValue(SELF.Grid.Selectable)
  ELSIF A:ViewOnly = name
    RETURN CreateBoolValue(SELF.ViewOnly)
  ELSE
    RETURN PARENT.GetProperty(name, idx1, idx2)
  END

WbGridHtmlProperties.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)
  CODE
  CASE whichAttr
  OF SkeletonAttr:Control
    RETURN 'grid'
  ELSE
    RETURN PARENT.GetSkeletonAttr(whichAttr)
  END

WbGridHtmlProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
GridFeq                 SIGNED,auto
  CODE
  GridFeq = SELF.Grid.IListControl.GetControl()
  GETPOSITION(GridFeq, x, y, w, h)
  IF (~OMITTED(6)) THEN noWidth = GridFeq{PROP:nowidth} .
  IF (~OMITTED(7)) THEN noHeight = GridFeq{PROP:noheight} .


WbGridHtmlProperties.SetProperty PROCEDURE(ASTRING name, STRING value)
  CODE
  IF A:Reset = name  ! value ignored
    SELF.Record=1
    SELF.Grid.FetchRecord(SELF.Record)
    SELF.Grid.SyncGroup(SELF.Record)
    DISPLAY
  ELSIF A:ResetSelected = name ! value ignored
    IF SELF.Grid.ILC.Choice()
      SELF.Record=SELF.Grid.ILC.Choice()
      SELF.Grid.FetchRecord(SELF.Record)
    END
  ELSIF A:NextRecord = name ! value ignored
    SELF.Record += 1
    SELF.Grid.FetchRecord(SELF.Record)
    SELF.Grid.SyncGroup(SELF.Record)
    DISPLAY
  ELSE
    PARENT.SetProperty(name, value)
  END


WbGridHtmlProperties.TakeResponse PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor)
NewChoice SIGNED
Sep       SIGNED,AUTO
  CODE
  Sep = INSTRING('$',subControl,1,1)
  IF Sep
    SELF.ResponseQ.Record = subControl[1:(Sep-1)]
    SELF.ResponseQ.Control &= NEW CSTRING(LEN(subControl)-Sep+1)
    SELF.ResponseQ.Control = subControl[(Sep+1):(LEN(subControl))]
    SELF.ResponseQ.Value &= NEW CSTRING(LEN(value)+1)
    SELF.ResponseQ.Value = value
    SELF.ResponseQ.type = type
    SELF.ResponseQ.EP &= EventProcessor
    ADD(SELF.ResponseQ)
  ELSE
    IF subControl
      NewChoice = subControl
    ELSIF (value)
      NewChoice = value
    END
    IF (NewChoice)
      SELF.Select(NewChoice)
      IF SELF.Grid.GetClickPress()
        POST(EVENT:Accepted,SELF.Grid.GetClickPress())
      END
    END
  END


WbGridHtmlProperties.Select PROCEDURE(SIGNED Choice)
  CODE
  SELF.Grid.ILC.SetChoice(Choice)
  SELF.Grid.TakeNewSelection


WbGridHtmlProperties.AfterResponse PROCEDURE
Control &IControlToHtml,AUTO
Record  SIGNED
  CODE
  LOOP I#=1 TO RECORDS(SELF.ResponseQ)
    GET(SELF.ResponseQ, I#)

    Control &= SELF.WebWindow.GetControl(SELF.ResponseQ.Control)
    ASSERT(NOT(Control&=NULL))
    IF UPPER(SELF.GetControlType(Control))='BUTTON'
      Record = SELF.ResponseQ.Record
    END
  END
  IF Record<>0
    SELF.Grid.ILC.SetChoice(Record)
    SELF.Grid.UpdateViewRecord
    LOOP I#=1 TO RECORDS(SELF.ResponseQ)
      GET(SELF.ResponseQ, I#)
      IF SELF.ResponseQ.Record = Record
        Control &= SELF.WebWindow.GetControl(SELF.ResponseQ.Control)
        ASSERT(NOT(Control&=NULL))
        Control.TakeResponse('', SELF.ResponseQ.Value, SELF.ResponseQ.Type, SELF.ResponseQ.EP)
      END
    END
  END
  SELF.ClearResponseQ

  PARENT.AfterResponse


WbGridHtmlProperties.GetControlType PROCEDURE(IControlToHtml Control)
Props &IHtmlElementProperties,AUTO
IV    &IValue,AUTO
temp  &IStringVal,AUTO
Str   STRING(20)
  CODE
  Props &= Control.QueryProperties()
  IV &= Props.GetProperty('Type')
  temp &= MakeStringVal()
  Str = IV.toString(temp)
  temp.Release()
  IV.Release()
  RETURN Str
