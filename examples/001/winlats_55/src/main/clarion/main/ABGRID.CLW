  MEMBER
  MAP
  .
  INCLUDE('ABGRID.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE


! Slight hack, we really need a 'known' virtual in the window manager just after the open window
GridClass.AddLocator PROCEDURE(LocatorClass LC)
  CODE
  SELF.CheckChildren
  PARENT.AddLocator(LC)

GridClass.CheckChildren PROCEDURE
  CODE

  IF SELF.ControlNumber THEN RETURN .
? ASSERT(~SELF.FileLoaded,'Grid-browse has to operate in page-loaded mode')
  SELF.ControlBase = 10000
  SELF.ControlNumber = 1
  LOOP
    CLEAR(SELF.Children)
    SELF.Children.Feq = SELF.GroupControl{PROP:Child,SELF.ControlNumber}

    IF SELF.Children.Feq
      SELF.ControlNumber += 1
      SELF.Children.Use &= SELF.Children.Feq{PROP:UseAddress}
      SELF.Children.XD = SELF.Children.Feq{PROP:XPos} - SELF.GroupControl{PROP:XPos}
      SELF.Children.YD = SELF.Children.Feq{PROP:YPos} - SELF.GroupControl{PROP:YPos}
      SELF.Children.He = SELF.Children.Feq{PROP:Height}
      SELF.Children.Wi = SELF.Children.Feq{PROP:Width}
      ADD(SELF.Children)
      IF ~SELF.IsSkelActive() THEN HIDE(SELF.Children.Feq) .
    ELSE
      BREAK
    END
  END
  IF SELF.IsSkelActive()
    UNHIDE(SELF.GroupControl)
    SELF.GroupColor = SELF.GroupControl{PROP:Color}
  ELSE
    HIDE(SELF.GroupControl)
  END

  IF SELF.Selectable
    SELF.ControlNumber += 1
  END

GridClass.CreateControls PROCEDURE
XP SIGNED,AUTO
YP SIGNED,AUTO
Ins SIGNED,AUTO
Feq SIGNED,AUTO
TTime SIGNED,AUTO
Kids SIGNED,AUTO
  CODE
  SELF.GetDimensions
  TTime = SELF.Across * SELF.Down
  IF SELF.HWM > TTime
    HIDE(SELF.ControlBase+TTime * SELF.ControlNumber,SELF.ControlBase+SELF.HWM * SELF.ControlNumber)
  END
  SYSTEM{PROP:DeferMove} = 1
  LOOP Ins = 1 TO TTime
    Feq = (Ins-1) * SELF.ControlNumber + SELF.ControlBase
    IF Ins <= SELF.ListQueue.Records()
      SELF.GetPosition(Ins, XP, YP)
      IF Ins > SELF.HWM
        SELF.HWM = Ins
        CLONE(Feq,SELF.GroupControl, SELF.IListControl.GetControl(){PROP:Parent})
        SETPOSITION(Feq,xp,yp,SELF.GroupControl{PROP:Width},SELF.GroupControl{PROP:Height})
        LOOP Kids = 1 TO RECORDS(SELF.Children)
          GET(SELF.Children,Kids)
          CLONE(Feq+Kids,SELF.Children.Feq,Feq)
          SETPOSITION(Feq+Kids,SELF.Children.XD + xp,SELF.Children.YD + yp,SELF.Children.Wi,SELF.Children.He)
          (Feq+Kids){PROP:UseAddress} = -1
          PUT(SELF.Children)
        END
        IF SELF.Selectable
          Feq += RECORDS(SELF.Children)+1
          CREATE(Feq,Create:Region,SELF.IListControl.GetControl(){PROP:Parent})
          SETPOSITION(Feq,xp,yp,SELF.GroupControl{PROP:Width},SELF.GroupControl{PROP:Height})
          Feq{PROP:Imm} = 1
          Feq -= RECORDS(SELF.Children)+1
        END
      ELSE
        Feq{PROP:At,1} = xp
        Feq{PROP:At,2} = yp
        IF SELF.Selectable
          (Feq+RECORDS(SELF.Children)+1){PROP:At,1} = xp
          (Feq+RECORDS(SELF.Children)+1){PROP:At,2} = yp
        END
        LOOP Kids = 1 TO RECORDS(SELF.Children)
          GET(SELF.Children,Kids)
          (Feq+Kids){PROP:At,1} = SELF.Children.XD + xp
          (Feq+Kids){PROP:At,2} = SELF.Children.YD + yp
        END
      END
      UNHIDE(Feq,Feq+SELF.ControlNumber-1)
    ELSE
      HIDE(Feq,Feq+SELF.ControlNumber-1)
    END
  END

GridClass.GetDimensions PROCEDURE
  CODE
  SELF.Across = SELF.IListControl.GetControl(){PROP:Width} / SELF.GroupControl{PROP:Width}
? ASSERT( SELF.Across AND SELF.Across < 100, 'List & Group control widths not compatible:'&SELF.IListControl.GetControl(){PROP:Width}&':'&SELF.GroupControl{PROP:Width})
  SELF.Down = SELF.IListControl.GetControl(){PROP:Height} / SELF.GroupControl{PROP:Height}
? ASSERT( SELF.Down AND SELF.Down < 100, 'List & Group control heights not compatible'&SELF.IListControl.GetControl(){PROP:Height}&':'&SELF.GroupControl{PROP:Height})

GridClass.GetPosition PROCEDURE(SIGNED Instance, *SIGNED XPos, *SIGNED Ypos)
  CODE
  XPos = (Instance-1) % SELF.Across
  YPos = (Instance-1) / SELF.Across
  XPos = XPos * SELF.IListControl.GetControl(){PROP:Width} / SELF.Across + SELF.IListControl.GetControl(){PROP:XPos}
  YPos = YPos * SELF.IListControl.GetControl(){PROP:Height} / SELF.Down + SELF.IListControl.GetControl(){PROP:YPos}

GridClass.Init  PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager F,WindowManager WM)
  CODE
  SELF.Chosen = 1
  SELF.MyBehavior &= NEW StandardBehavior
  SELF.Children    &= NEW ChildQueue
  SELF.ListControl = ListBox
  SELF.MyBehavior.Init(Q,Posit,ListBox)
  SELF.Init(SELF.IListControl, V, SELF.MyBehavior.BrowseQueue, F, WM)

GridClass.Kill PROCEDURE
I SIGNED,AUTO
  CODE
  PARENT.Kill
  DISPOSE(SELF.MyBehavior)
  LOOP I = 1 TO RECORDS(SELF.Children)
    GET(SELF.Children,I)
    SELF.Children.Use &= NULL
  END
  DISPOSE(SELF.Children)

GridClass.SetAlerts PROCEDURE
  CODE

  SELF.CheckChildren
  IF ~SELF.IsSkelActive()
    SELF.CreateControls
  END
  IF ~SELF.Window &= NULL AND ~SELF.Window.Resize &= NULL
    SELF.Window.Resize.RemoveControl(SELF.GroupControl)
  END
  HIDE(SELF.IListControl.GetControl())


GridClass.TakeEvent PROCEDURE
Fld SIGNED,AUTO
Evt SIGNED,AUTO
  CODE
  Fld = FIELD()
  Evt = EVENT()
  IF EVENT() = EVENT:User AND Fld = SELF.GroupControl
    SELF.UpdateWindow
  ELSIF SELF.UpdateControl AND ACCEPTED() = SELF.UpdateControl
    IF ~SELF.IsSkelActive()
      IF SELF.CurrentChoice
        SELF.UpdateControls(SELF.CurrentChoice)
      END
    END
    SELF.UpdateRecord(SELF.CurrentChoice)
  ELSIF SELF.IfGroupField(Fld)
    SELF.Chosen = 1+(Fld-SELF.ControlBase)/SELF.ControlNumber
    IF ACCEPTED()
      IF SELF.CurrentChoice<>SELF.Chosen
        SELF.TakeNewSelection
        SELF.UpdateViewRecord
      END
      CASE KEYCODE()
      OF MouseLeft2
        IF SELF.ClickPress
          POST(EVENT:Accepted,SELF.ClickPress)
        END
      END
    END
    GET(SELF.Children, (Fld-SELF.ControlBase)%SELF.ControlNumber)
    IF ~ERRORCODE()
      POST(EVENT(),SELF.Children.Feq)
    END
  ELSE
    PARENT.TakeEvent()
  END

GridClass.UpdateRecord PROCEDURE(SIGNED Record)

  CODE
  IF Record > 0
    SELF.ILC.SetChoice(Record)
    SELF.Primary.Update()
    SELF.ResetFromBuffer
    SELF.UpdateViewRecord
  END

GridClass.UpdateWindow PROCEDURE
Ins SIGNED,AUTO
Feq SIGNED,AUTO
Kids SIGNED,AUTO
  CODE
  PARENT.UpdateWindow

  IF ~SELF.IsSkelActive()
    IF SYSTEM{PROP:Modal} <> 0
      POST(EVENT:User,SELF.GroupControl)
      RETURN
    END
    IF SELF.IListControl.GetVisible()
      SYSTEM{PROP:LazyDisplay} = 1
      SELF.CreateControls   ! Potentially more, try to trap specific events that can cause control moving
      LOOP Ins = 1 TO SELF.Across * SELF.Down
        SELF.ListQueue.Fetch(Ins)
        SELF.Fields.AssignRightToLeft()
        Feq = (Ins-1) * SELF.ControlNumber + SELF.ControlBase
        IF SELF.GroupTitle
          Feq{PROP:Text} = EVALUATE(SELF.GroupTitle)
          Feq{PROP:Boxed} = 1
        END
        IF SELF.SelColor
          Feq{PROP:Color} = CHOOSE(Ins = SELF.Chosen,SELF.SelColor,SELF.GroupControl{PROP:Color})
        END
        LOOP Kids = 1 TO RECORDS(SELF.Children)
          GET(SELF.Children,Kids)
          CASE SELF.Children.Feq{PROP:Type}
          OF Create:PROMPT
          OROF Create:STRING
          OROF Create:BUTTON
            (Feq+Kids){PROP:Text} = SELF.Children.Feq{PROP:Text}
          OF Create:IMAGE
            SELF.Children.Feq{PROP:Target} = Feq+Kids
          ELSE
            CHANGE(Feq+Kids,self.children.use)
          END
     !    SELF.Children.Feq{PROP:Target} = Feq+Kids
        END
        LOOP Kids = 1 TO RECORDS(SELF.Processors)
          GET(SELF.Processors,Kids)
          SELF.Processors.P.TakeRecord()
        END
        LOOP Kids = 1 TO RECORDS(SELF.Children)
          GET(SELF.Children,Kids)
          SELF.Children.Feq{PROP:Target} = 0
        END
      END
      SELF.UpdateBuffer
      SYSTEM{PROP:LazyDisplay} = 0
    END
  END


GridClass.UpdateControls PROCEDURE(LONG Record)
Feq  SIGNED,AUTO
Kids SIGNED,AUTO
Str  STRING(1000)
  CODE
  Feq = (Record-1) * SELF.ControlNumber + SELF.ControlBase
  LOOP Kids = 1 TO RECORDS(SELF.Children)
    GET(SELF.Children,Kids)
    CASE SELF.Children.Feq{PROP:Type}
    OF Create:ENTRY
    OROF Create:COMBO
    OROF Create:CHECK
    OROF Create:SPIN
      SELF.Children.Use = (Feq+Kids){PROP:ScreenText}
    END
  END


GridClass.FetchRecord PROCEDURE(LONG Record)
Kids SIGNED,AUTO
  CODE
  IF SELF.ListQueue.Records()
    SELF.ListQueue.Fetch(Record)
    SELF.Fields.AssignRightToLeft()
    LOOP Kids = 1 TO RECORDS(SELF.Processors)
      GET(SELF.Processors,Kids)
      SELF.Processors.P.TakeRecord()
    END
  END


GridClass.SyncGroup PROCEDURE(LONG Record)
  CODE

  IF SELF.GroupTitle
    SELF.GroupControl{PROP:Text} = EVALUATE(SELF.GroupTitle)
    SELF.GroupControl{PROP:Boxed} = 1
  END
  IF SELF.SelColor
    SELF.GroupControl{PROP:Color} = CHOOSE(Record = SELF.Chosen,SELF.SelColor,SELF.GroupColor)
  END


GridClass.GetAcross PROCEDURE
  CODE
  RETURN SELF.Across

GridClass.GetDown PROCEDURE
  CODE
  RETURN SELF.Down

GridClass.GetClickPress PROCEDURE
  CODE
  RETURN SELF.ClickPress

GridClass.IfGroupField PROCEDURE(SIGNED Fld)

  CODE
  IF Fld >= SELF.ControlBase AND Fld <= SELF.ControlBase + SELF.HWM * SELF.ControlNumber
    RETURN True
  ELSE
    RETURN False
  END

GridClass.IListControl.GetItems PROCEDURE
  CODE
  SELF.GetDimensions
  RETURN SELF.Across * SELF.Down

GridClass.IListControl.GetVisible PROCEDURE
  CODE
  RETURN True

GridClass.IListControl.GetControl PROCEDURE
  CODE
  RETURN SELF.ListControl

GridClass.IListControl.SetControl PROCEDURE(SIGNED NewControl)
  CODE
  SELF.ListControl = NewControl

GridClass.IListControl.Choice PROCEDURE
  CODE
  RETURN SELF.Chosen

GridClass.IListControl.SetChoice PROCEDURE(SIGNED NC)
  CODE
  SELF.Chosen = NC

GridClass.IsSkelActive PROCEDURE
  CODE

  RETURN False
