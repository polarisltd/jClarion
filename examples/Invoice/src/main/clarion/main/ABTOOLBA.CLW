    MEMBER

    MAP
      SetTips(STRING)
    END

    INCLUDE('ABUTIL.INC'),ONCE
    INCLUDE('ABToolba.inc'),ONCE
    INCLUDE('ABToolba.trn'),ONCE
    INCLUDE('ABWINDOW.INC'),ONCE
    INCLUDE('ABFILE.INC'),ONCE
    INCLUDE('Keycodes.clw'),ONCE


Toolbar:Base            EQUATE(Toolbar:First-1)       ! NB: Clarion arrays are 1 based

ToolbarTargetQueue QUEUE,TYPE
Id   SIGNED
Item &ToolbarTarget
  END


SetTips PROCEDURE(STRING In)

Cnst   ConstantClass
Control USHORT,AUTO
Tip     STRING(255),AUTO

  CODE
    Cnst.Init(Term:Byte)
    Cnst.AddItem(ConstType:UShort,Control)
    Cnst.AddItem(ConstType:PString,Tip)
    Cnst.Set(In)
    LOOP WHILE Cnst.Next()=Level:Benign
      Control{PROP:ToolTip}=Tip
    END
    Cnst.Kill


ToolbarTarget.DisplayButtons PROCEDURE
  CODE
  IF ~SELF.SelectButton OR SELF.SelectButton{PROP:Disable}
    DISABLE(Toolbar:Select)
  ELSE
    ENABLE(Toolbar:Select)
  END
  IF ~SELF.DeleteButton OR SELF.DeleteButton{PROP:Disable}
    DISABLE(Toolbar:Delete)
  ELSE
    ENABLE(Toolbar:Delete)
  END
  IF ~SELF.ChangeButton OR SELF.ChangeButton{PROP:Disable}
    DISABLE(Toolbar:Change)
  ELSE
    ENABLE(Toolbar:Change)
  END
  IF ~SELF.InsertButton OR SELF.InsertButton{PROP:Disable}
    DISABLE(Toolbar:Insert)
  ELSE
    ENABLE(Toolbar:Insert)
  END
  IF ~SELF.HelpButton OR SELF.HelpButton{PROP:Disable}
    DISABLE(Toolbar:Help)
  ELSE
    ENABLE(Toolbar:Help)
  END
  IF ~SELF.LocateButton OR SELF.LocateButton{Prop:Disable}
    DISABLE(Toolbar:Locate)
  ELSE
    ENABLE(Toolbar:Locate)
  END

ToolbarTarget.TakeToolbar PROCEDURE
  CODE

ToolbarTarget.TryTakeToolbar PROCEDURE
  CODE
    RETURN 0

ToolbarTarget.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
    CASE ACCEPTED()
    OF Toolbar:Help
      PRESSKEY(F1Key)
    OF Toolbar:Insert
      POST(EVENT:ACCEPTED,SELF.InsertButton)
    OF Toolbar:Change
      POST(EVENT:ACCEPTED,SELF.ChangeButton)
    OF Toolbar:Delete
      POST(EVENT:ACCEPTED,SELF.DeleteButton)
    END

ToolbarListboxClass.DisplayButtons PROCEDURE
  CODE
    DISABLE(Toolbar:History)
    ENABLE(Toolbar:Bottom,Toolbar:Locate)
    PARENT.DisplayButtons

ToolbarListboxClass.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
    IF ACCEPTED() = Toolbar:Select
      WM.Update
      WM.Response=RequestCompleted
      POST(EVENT:CloseWindow)
      RETURN
    END
    EXECUTE(ACCEPTED()-Toolbar:Bottom+1)
      POST(EVENT:ScrollBottom,SELF.Control)
      POST(EVENT:ScrollTop,SELF.Control)
      POST(EVENT:PageDown,SELF.Control)
      POST(EVENT:PageUp,SELF.Control)
      POST(EVENT:ScrollDown,SELF.Control)
      POST(EVENT:ScrollUp,SELF.Control)
      POST(EVENT:Locate,SELF.Control)
    ELSE
      PARENT.TakeEvent(,WM)
    END

ToolbarListboxClass.TakeToolbar PROCEDURE
  CODE
    SetTips(ListBoxTips)
    SELF.DisplayButtons

ToolbarListBoxClass.TryTakeToolbar PROCEDURE
  CODE
    IF SELF.Browse.ILC.GetControl(){PROP:Visible} THEN
      SELF.TakeToolbar
      RETURN 1
    ELSE
      RETURN 0
    END

ToolbarFormVCRClass.DisplayButtons PROCEDURE
  CODE
    IF SELF.FormVCR.GetAction()=InsertRecord THEN
       ENABLE(Toolbar:History)
    ELSE
       DISABLE(Toolbar:History)
    END
    Toolbar:Bottom{PROP:DISABLE}    = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:ScrollBottom,0),False,True)
    Toolbar:Top{PROP:DISABLE}       = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:ScrollTop,0),False,True)
    Toolbar:PageDown{PROP:DISABLE}  = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:PageDown,0),False,True)
    Toolbar:PageUp{PROP:DISABLE}    = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:PageUp,0),False,True)
    Toolbar:Down{PROP:DISABLE}      = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:ScrollDown,0),False,True)
    Toolbar:Up{PROP:DISABLE}        = CHOOSE(SELF.FormVCR.GetActionAllowed(EVENT:ScrollUp,0),False,True)

    DISABLE(Toolbar:Locate)
    PARENT.DisplayButtons

ToolbarFormVCRClass.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
    CASE ACCEPTED()
    OF Toolbar:Help
      PRESSKEY(F1Key)
    OF Toolbar:Insert
      POST(EVENT:ACCEPTED,SELF.InsertButton)
    OF Toolbar:Change
      POST(EVENT:ACCEPTED,SELF.ChangeButton)
    OF Toolbar:Delete
      POST(EVENT:ACCEPTED,SELF.DeleteButton)
    OF Toolbar:Select
      POST(EVENT:ACCEPTED,SELF.SelectButton)
    END
    EXECUTE(ACCEPTED()-Toolbar:Bottom+1)
      POST(EVENT:ScrollBottom,SELF.Control)
      POST(EVENT:ScrollTop,SELF.Control)
      POST(EVENT:PageDown,SELF.Control)
      POST(EVENT:PageUp,SELF.Control)
      POST(EVENT:ScrollDown,SELF.Control)
      POST(EVENT:ScrollUp,SELF.Control)
      POST(EVENT:Locate,SELF.Control)
    ELSE
      PARENT.TakeEvent(,WM)
    END

ToolbarFormVCRClass.TakeToolbar PROCEDURE
  CODE
    SetTips(UpdateVCRTips)
    SELF.DisplayButtons

ToolbarFormVCRClass.TryTakeToolbar PROCEDURE
  CODE
    SELF.TakeToolbar
    RETURN 1

ToolbarReltreeClass.DisplayButtons PROCEDURE
  CODE
    DISABLE(Toolbar:History)
    ENABLE(Toolbar:Bottom,Toolbar:Up)
    PARENT.DisplayButtons

ToolbarReltreeClass.TakeToolbar PROCEDURE
  CODE
    SetTips(ReltreeBoxTips)
    SELF.DisplayButtons

ToolbarUpdateClass.TakeToolbar PROCEDURE
  CODE
    IF SELF.Request = InsertRecord
      SetTips(UpdateInsertTips)
    ELSIF SELF.Request = ChangeRecord
      SetTips(UpdateChangeTips)
    END
    SELF.DisplayButtons

ToolbarUpdateClass.TryTakeToolbar PROCEDURE
  CODE
    SELF.TakeToolbar
    RETURN 1

ToolbarUpdateClass.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
  CASE ACCEPTED()
  OF Toolbar:Bottom TO Toolbar:Up
  OROF Toolbar:Insert
    IF ~OMITTED(2)
      VCR = ACCEPTED()
    END
    WM.PostCompleted
  ELSE
    PARENT.TakeEvent(VCR,WM)
  END

ToolbarUpdateClass.DisplayButtons PROCEDURE
  CODE
    IF SELF.Request = InsertRecord
      ENABLE(Toolbar:Down)
      ENABLE(Toolbar:Insert)
      DISABLE(Toolbar:Change,Toolbar:PageUp)
      DISABLE(Toolbar:Up,Toolbar:Locate)
      DO SetHs
    ELSIF SELF.Request = ChangeRecord
      ENABLE(Toolbar:Bottom,Toolbar:Up)
      ENABLE(Toolbar:Insert)
      DISABLE(Toolbar:Change,Toolbar:Select)
      DO SetHs
    ELSE
      DISABLE(Toolbar:First,Toolbar:History)
    END
    DISPLAY(Toolbar:First,Toolbar:Last)

SetHs ROUTINE
  IF ~SELF.HelpButton OR SELF.HelpButton{PROP:Disable}
    DISABLE(Toolbar:Help)
  ELSE
    ENABLE(Toolbar:Help)
  END
  IF SELF.History
    ENABLE(Toolbar:History)
  ELSE
    DISABLE(Toolbar:History)
  END

ToolbarClass.Init PROCEDURE
  CODE
    SELF.List &= NEW ToolbarTargetQueue
    SELF.List.Id = 0

ToolbarClass.Kill PROCEDURE
  CODE
    DISPOSE(SELF.List)

ToolbarClass.AddTarget PROCEDURE(ToolbarTarget T,SIGNED Id)
  CODE
    ASSERT(~(SELF.List &= NULL))
    SELF.List.Id = Id
    SELF.List.Item &= T
    SELF.List.Item.Control = Id
    ADD(SELF.List,SELF.List.Id)

ToolbarClass.SetTarget PROCEDURE(SIGNED Id)
I USHORT,AUTO
Hit USHORT
  CODE
    ASSERT(~ (SELF.List &= NULL))
    IF Id
      SELF.List.Id = Id
      GET(SELF.List,SELF.List.Id)
      ASSERT (~ERRORCODE())
      SELF.List.Item.TakeToolbar
    ELSE
      LOOP I = 1 TO RECORDS(SELF.List)
        GET(SELF.List,I)
        IF SELF.List.Item.TryTakeToolbar() THEN Hit = I.
      END
      IF Hit THEN GET(SELF.List,Hit).
    END

ToolbarClass.DisplayButtons PROCEDURE
  CODE
    ASSERT(~(SELF.List &= NULL) AND SELF.List.Id)
    SELF.List.Item.DisplayButtons

ToolbarClass.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
    ASSERT(~SELF.List &= NULL)
    IF RECORDS(SELF.List)
      SELF.List.Item.TakeEvent(VCR,WM)
    END

!-----------------------------------------------------------------------------

BrowseToolBarClass.Init           PROCEDURE(WindowManager Window, BrowseClass Browse)
Index                   SIGNED,AUTO
  CODE
  SELF.Window &= Window
  SELF.Browse &= Browse
  LOOP Index = Toolbar:First TO Toolbar:Last
    SELF.Button[Index - Toolbar:Base] = 0
  END

BrowseToolBarClass.InitBrowse   PROCEDURE(SIGNED Insert, SIGNED Change, SIGNED Delete, SIGNED Select)
  CODE
  SELF.Button[Toolbar:Insert-Toolbar:Base] = Insert
  SELF.Button[Toolbar:Change-Toolbar:Base] = Change
  SELF.Button[Toolbar:Delete-Toolbar:Base] = Delete
  SELF.Button[Toolbar:Select-Toolbar:Base] = Select

BrowseToolBarClass.InitMisc     PROCEDURE(SIGNED History, SIGNED Help)
  CODE
  SELF.Button[Toolbar:History-Toolbar:Base] = History
  SELF.Button[Toolbar:Help-Toolbar:Base] = Help

BrowseToolBarClass.InitVCR      PROCEDURE(SIGNED Top, SIGNED Bottom, SIGNED PageUp, SIGNED PageDown, SIGNED Up, SIGNED Down, SIGNED Locate)
  CODE
  SELF.Button[Toolbar:Bottom-Toolbar:Base] = Bottom
  SELF.Button[Toolbar:Top-Toolbar:Base] = Top
  SELF.Button[Toolbar:Up-Toolbar:Base] = Up
  SELF.Button[Toolbar:Down-Toolbar:Base] = Down
  SELF.Button[Toolbar:PageUp-Toolbar:Base] = PageUp
  SELF.Button[Toolbar:PageDown-Toolbar:Base] = PageDown
  SELF.Button[Toolbar:Locate-Toolbar:Base] = Locate

BrowseToolBarClass.ResetFromBrowse      PROCEDURE
  CODE
  SELF.ResetButton(Toolbar:Select, SELF.Browse.SelectControl)
  SELF.ResetButton(Toolbar:Insert, SELF.Browse.InsertControl)
  SELF.ResetButton(Toolbar:Change, SELF.Browse.ChangeControl)
  SELF.ResetButton(Toolbar:Delete, SELF.Browse.DeleteControl)
  SELF.ResetButton(Toolbar:History, 0) ! MORE
  SELF.ResetButton(Toolbar:Help,   0) ! SELF.Browse.HelpButton)
  SELF.ResetButton(Toolbar:Locate, SELF.Browse.QueryControl)

BrowseToolbarClass.ResetButton          PROCEDURE(SIGNED ToolButton, SIGNED BrowseButton)
ToolButtonFeq           SIGNED,AUTO
  CODE
  ToolButtonFeq = SELF.Button[ToolButton-Toolbar:Base]
  IF ToolButtonFeq
    IF ~BrowseButton OR BrowseButton{PROP:Disable}
      DISABLE(ToolButtonFeq)
    ELSE
      ENABLE(ToolButtonFeq)
    END
    IF ~BrowseButton OR BrowseButton{PROP:Hide}
      HIDE(ToolButtonFeq)
    ELSE
      UNHIDE(ToolButtonFeq)
    END
  END

BrowseToolBarClass.TakeEvent            PROCEDURE
BrowseFeq               SIGNED,auto
  CODE
  BrowseFeq = SELF.Browse.ILC.GetControl()

  CASE (ACCEPTED())
  OF 0
    ! Don't execute one of the following if they are 0...
  OF SELF.Button[Toolbar:Insert-Toolbar:Base]
    POST(EVENT:Accepted, SELF.Browse.InsertControl)
  OF SELF.Button[Toolbar:Change-Toolbar:Base]
    POST(EVENT:Accepted, SELF.Browse.ChangeControl)
  OF SELF.Button[Toolbar:Delete-Toolbar:Base]
    POST(EVENT:Accepted, SELF.Browse.DeleteControl)
  OF SELF.Button[Toolbar:Select-Toolbar:Base]
    POST(EVENT:Accepted, SELF.Browse.SelectControl)
  OF SELF.Button[Toolbar:Bottom-Toolbar:Base]
    POST(EVENT:ScrollBottom,BrowseFeq)
  OF SELF.Button[Toolbar:Top-Toolbar:Base]
    POST(EVENT:ScrollTop,BrowseFeq)
  OF SELF.Button[Toolbar:PageDown-Toolbar:Base]
    POST(EVENT:PageDown,BrowseFeq)
  OF SELF.Button[Toolbar:PageUp-Toolbar:Base]
    POST(EVENT:PageUp,BrowseFeq)
  OF SELF.Button[Toolbar:Down-Toolbar:Base]
    POST(EVENT:ScrollDown,BrowseFeq)
  OF SELF.Button[Toolbar:Up-Toolbar:Base]
    POST(EVENT:ScrollUp,BrowseFeq)
  OF SELF.Button[Toolbar:Locate-Toolbar:Base]
    POST(EVENT:Locate,BrowseFeq)
  OF SELF.Button[Toolbar:History-Toolbar:Base]
    !!MORE
  OF SELF.Button[Toolbar:Help-Toolbar:Base]
    PRESSKEY(F1Key)
  END

  IF (FIELD() = BrowseFeq) AND (EVENT() = EVENT:NewSelection)
    SELF.ResetFromBrowse()
  END

  RETURN Level:Benign

!-----------------------------------------------------------------------------
BrowseToolbarClass.WindowComponent.Kill PROCEDURE
  CODE

BrowseToolbarClass.WindowComponent.Reset PROCEDURE(BYTE Force)
  CODE
  SELF.ResetFromBrowse()

BrowseToolbarClass.WindowComponent.ResetRequired PROCEDURE
  CODE
  RETURN False


BrowseToolbarClass.WindowComponent.SetAlerts PROCEDURE
  CODE


BrowseToolbarClass.WindowComponent.TakeEvent PROCEDURE
  CODE
  RETURN SELF.TakeEvent()


BrowseToolbarClass.WindowComponent.Update PROCEDURE
  CODE

BrowseToolbarClass.WindowComponent.UpdateWindow PROCEDURE
  CODE
  SELF.ResetFromBrowse()
