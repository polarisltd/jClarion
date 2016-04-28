!Resize method implementations

  MEMBER()

  INCLUDE('ABRESIZE.INC'),ONCE
  INCLUDE('ABERROR.INC'),ONCE

  MAP
RestoreControls   PROCEDURE(WindowResizeClass SELF),PRIVATE                   !resize all controls to design size/position
GetSizeInfo       PROCEDURE(SHORT ControlID,*PositionGroup),PRIVATE
SetSize           PROCEDURE(SHORT ControlID,*PositionGroup),PRIVATE
SetPriorities     PROCEDURE(WindowResizeClass SELF,*PositionGroup CurrentSize),PRIVATE
  END


WindowResizeClass.Init PROCEDURE(BYTE AppStrategy,BYTE SetWindowMinSize,BYTE SetWindowMaxSize)
  CODE
  SELF.ControlQueue &= NEW ControlQueue
  SELF.ResizeList &= NEW ResizeQueue
  SELF.AppStrategy=AppStrategy
  REGISTEREVENT(EVENT:Sized,ADDRESS(SELF.TakeResize),ADDRESS(SELF))
  0{PROP:IMM}=True
  SELF.Reset
  IF AppStrategy=AppStrategy:Surface THEN SELF.SetParentDefaults.
  IF SetWindowMinSize
    0{PROP:MinWidth}=SELF.OrigWin.Width
    0{PROP:MinHeight}=SELF.OrigWin.Height
  END
  IF SetWindowMaxSize
    0{PROP:MaxWidth}=SELF.OrigWin.Width
    0{PROP:MaxHeight}=SELF.OrigWin.Height
  END
  SELF.DeferMoves=True


WindowResizeClass.GetPositionStrategy PROCEDURE(SHORT ControlType,<BYTE AppStrategy>)

AppStrat  BYTE,AUTO
RVal      USHORT(Resize:Reposition)

  CODE
  AppStrat = CHOOSE (OMITTED(3)=True, SELF.AppStrategy, AppStrategy)
  CASE AppStrat
  OF AppStrategy:NoResize
    RVal = Resize:LockXPos + Resize:LockYPos
  OF AppStrategy:Spread
    CASE ControlType
    OF CREATE:Button
    OROF CREATE:Radio
    OROF CREATE:Check
      RVal = Resize:FixNearestX + Resize:FixNearestY
    END
  OF AppStrategy:Surface
    CASE ControlType
    OF CREATE:Button
    OROF CREATE:Radio
    OROF CREATE:Check
      RVal = Resize:FixNearestX + Resize:FixNearestY
    OF CREATE:Entry
    OROF CREATE:String
    OROF CREATE:SString
    OROF CREATE:Combo
    OROF CREATE:Spin
    OROF CREATE:DropCombo
    OROF CREATE:Prompt
      RVal = Resize:FixTop
    OF CREATE:List
    OROF CREATE:Sheet
    OROF CREATE:Panel
    OROF CREATE:Image
    OROF CREATE:Option
    OROF CREATE:Group
    OROF CREATE:Region
      RVal = Resize:FixLeft + Resize:FixTop
    END
  END
  RETURN RVal


WindowResizeClass.GetResizeStrategy PROCEDURE(SHORT ControlType,<BYTE AppStrategy>)

AppStrat  BYTE,AUTO
RVal      USHORT(Resize:Resize)

  CODE
  AppStrat = CHOOSE(OMITTED(3)=True, SELF.AppStrategy, AppStrategy)
  CASE AppStrat
  OF AppStrategy:NoResize
    RVal = Resize:LockWidth + Resize:LockHeight
  OF AppStrategy:Spread
    CASE SELF.ControlQueue.Type
    OF CREATE:Button
    OROF CREATE:Radio
    OROF CREATE:Check
      RVal = Resize:LockWidth + Resize:LockHeight
    OF CREATE:Entry
    OROF CREATE:Combo
    OROF CREATE:Spin
    OROF CREATE:DropCombo
      RVal = Resize:LockHeight
    END
  OF AppStrategy:Surface
    CASE SELF.ControlQueue.Type
    OF CREATE:Button
    OROF CREATE:Radio
    OROF CREATE:Check
      RVal = Resize:LockWidth + Resize:LockHeight
    OF CREATE:Entry
    OROF CREATE:String
    OROF CREATE:SString
    OROF CREATE:Combo
    OROF CREATE:Spin
    OROF CREATE:DropCombo
    OROF CREATE:Prompt
      RVal = Resize:LockHeight
    OF CREATE:List
    OROF CREATE:Sheet
    OROF CREATE:Panel
    OROF CREATE:Image
    OROF CREATE:Option
    OROF CREATE:Group
    OROF CREATE:Region
      RVal = Resize:ConstantRight + Resize:ConstantBottom
    END
  END
  RETURN RVal


WindowResizeClass.Reset PROCEDURE

FieldCounter  SIGNED(0)

  CODE
  GetSizeInfo(0,SELF.OrigWin)
  SELF.OrigWin.Maximized=0{PROP:Maximize}
  SELF.OrigWin.Iconized=0{PROP:Iconize}
  SELF.PreviousWin = SELF.OrigWin
  LOOP
    FieldCounter=0{PROP:NextField,FieldCounter}
    IF ~FieldCounter THEN BREAK.
    SELF.ControlQueue.ID=FieldCounter
    GET(SELF.ControlQueue,SELF.ControlQueue.ID)
    IF ERRORCODE()
      SELF.ControlQueue.Type=FieldCounter{PROP:Type}
      SELF.ControlQueue.HasChildren=False
      IF ~FieldCounter{PROP:InToolbar} AND INRANGE(SELF.ControlQueue.Type,1,CREATE:Toolbar-1) AND ~(INLIST(SELF.ControlQueue.Type,CREATE:Menu,CREATE:Item,CREATE:Tab))
        SELF.ControlQueue.ID=FieldCounter
        GetSizeInfo(FieldCounter,SELF.ControlQueue.Pos)
        IF SELF.ControlQueue.Type=CREATE:List AND SELF.ControlQueue.ID{PROP:Drop}     !List boxes with drop attribute are treated like entry fields
          SELF.ControlQueue.Type=CREATE:Entry
        END
        SELF.ControlQueue.PositionalStrategy=SELF.GetPositionStrategy(SELF.ControlQueue.Type)
        SELF.ControlQueue.ResizeStrategy=SELF.GetResizeStrategy(SELF.ControlQueue.Type)
        SELF.ControlQueue.ParentID=0
        ADD(SELF.ControlQueue,SELF.ControlQueue.ID)
        ASSERT(~ERRORCODE())
      END
    ELSE
      GetSizeInfo(FieldCounter,SELF.ControlQueue.Pos)
      PUT(SELF.ControlQueue,SELF.ControlQueue.ID)
      ASSERT(~ERRORCODE())
    END
  END
  SELF.ResizeCalled=False


WindowResizeClass.RestoreWindow PROCEDURE           !reset whole window back to init size/position

   CODE
   0{PROP:Maximize}=SELF.OrigWin.Maximized
   0{PROP:Iconize}=SELF.OrigWin.Iconized
   SETPOSITION(0,,,SELF.OrigWin.Width,SELF.OrigWin.Height)
   RestoreControls(SELF)


WindowResizeClass.TakeResize PROCEDURE

  CODE
  RETURN SELF.Resize()


WindowResizeClass.Resize PROCEDURE

  CODE
  RETURN SELF.Resize(0)


WindowResizeClass.Resize PROCEDURE(SIGNED Control)

CurrentSize    LIKE(PositionGroup),AUTO
i              USHORT,AUTO
SaveDefer      SIGNED,AUTO
WinPos         LIKE(PositionGroup),AUTO
WinCurrentPos  LIKE(PositionGroup),AUTO

  CODE
  FREE(SELF.ResizeList)
  GetSizeInfo(Control,CurrentSize)
  IF LASTFIELD() AND ~(CurrentSize.Width=SELF.PreviousWin.Width AND CurrentSize.Height=SELF.PreviousWin.Height)   !resize required
    IF SELF.DeferMoves THEN
      SaveDefer=SYSTEM{PROP:DeferMove}
      SYSTEM{PROP:DeferMove}=RECORDS(SELF.ControlQueue)
    END
    IF CurrentSize.Width=SELF.OrigWin.Width AND CurrentSize.Height=SELF.OrigWin.Height     !window reset to design size
      RestoreControls(SELF)
    ELSE
      IF Control = 0
        WinPos=SELF.OrigWin
        WinPos.XPos=0
        WinPos.YPos=0
        WinCurrentPos=CurrentSize
        WinCurrentPos.XPos=0
        WinCurrentPos.YPos=0
      ELSE
        SELF.GetOrigPos(Control,WinPos)
        SELF.GetCurrentPos(Control,WinCurrentPos)
      END
      SELF.ResizeChildren(Control,WinPos,WinCurrentPos)
      IF ~SELF.DeferMoves
        SetPriorities(SELF,CurrentSize)
        IF (SELF.PreviousWin.Width^2)+(SELF.PreviousWin.Height^2)>(CurrentSize.Width^2)+(CurrentSize.Height^2)
          SORT(SELF.ResizeList,SELF.ResizeList.Priority)    !Contraction
        ELSE
          SORT(SELF.ResizeList,-SELF.ResizeList.Priority)   !Expansion
        END
      END
      LOOP i=1 TO RECORDS(SELF.ResizeList)
        GET(SELF.ResizeList,i)
        IF SELF.ResizeList.Before <> SELF.ResizeList.After
          SetSize(SELF.ResizeList.ControlID,SELF.ResizeList.After)
        END
      END
    END
    IF SELF.DeferMoves THEN SYSTEM{PROP:DeferMove}=CHOOSE(SaveDefer<0,SaveDefer,0).
    SELF.ResizeCalled=True
    SELF.PreviousWin = CurrentSize
  END
  RETURN Level:Benign


WindowResizeClass.Kill PROCEDURE

  CODE
  UNREGISTEREVENT(EVENT:Sized,ADDRESS(SELF.TakeResize),ADDRESS(SELF))
  DISPOSE(SELF.ControlQueue)
  DISPOSE(SELF.ResizeList)


WindowResizeClass.SetStrategy PROCEDURE(SIGNED ControlID,USHORT PositionalStrategy,USHORT ResizeStrategy)

FieldCounter        SIGNED,AUTO

  CODE
  IF ~ControlID
    LOOP FieldCounter=1 TO RECORDS(SELF.ControlQueue)
      GET(SELF.ControlQueue,FieldCounter)
      ASSERT(~ERRORCODE())
      DO AddStrategy
    END
  ELSE
    SELF.ControlQueue.ID=ControlID
    GET(SELF.ControlQueue,SELF.ControlQueue.ID)
    IF ERRORCODE()                                                !New control, so add it
      ASSERT(~ControlID{PROP:InToolbar})                          !Cannot resize controls in toolbars
      ASSERT(INRANGE(ControlID{PROP:Type},1,CREATE:Toolbar-1))    !Known control types
      ASSERT(SELF.ControlQueue.Type NOT=CREATE:Menu)              !No resize for menus
      ASSERT(SELF.ControlQueue.Type NOT=CREATE:Item)              !No resize for menu items
      SELF.ControlQueue.ID=ControlID
      SELF.ControlQueue.Type=ControlID{PROP:Type}
      SELF.ControlQueue.HasChildren=False
      GetSizeInfo(ControlID,SELF.ControlQueue.Pos)
      ADD(SELF.ControlQueue,SELF.ControlQueue.ID)
      ASSERT(~ERRORCODE())
    END
    DO AddStrategy
  END

AddStrategy ROUTINE
  SELF.ControlQueue.PositionalStrategy=PositionalStrategy
  SELF.ControlQueue.ResizeStrategy=ResizeStrategy
  PUT(SELF.ControlQueue)
  ASSERT(~ERRORCODE())


WindowResizeClass.SetStrategy PROCEDURE(SIGNED SrcCtrl,SIGNED DestCtrl)

PosStrat  USHORT,AUTO
ResStrat  USHORT,AUTO

  CODE
  SELF.ControlQueue.ID=SrcCtrl
  GET(SELF.ControlQueue,SELF.ControlQueue.ID)
  IF ~ERRORCODE()
    PosStrat=SELF.ControlQueue.PositionalStrategy
    ResStrat=SELF.ControlQueue.ResizeStrategy
    SELF.SetStrategy(DestCtrl,PosStrat,ResStrat)
  END


!This function removes a control from the resizer, disabling any resizing

WindowResizeClass.RemoveControl PROCEDURE(SIGNED Control)

DelPrnt SIGNED,AUTO

  CODE
  SELF.ControlQueue.ID = Control
  GET(SELF.ControlQueue, SELF.ControlQueue.ID)
  IF ~ERRORCODE()
    DelPrnt = SELF.ControlQueue.ParentID
    DELETE(SELF.ControlQueue)
    IF ~ERRORCODE()
      GET(SELF.ControlQueue, 1)                 !Fix up controls that had the deleted control as a parent
      LOOP WHILE ~ERRORCODE()
        IF SELF.ControlQueue.ParentID = Control
          SELF.ControlQueue.ParentID = DelPrnt
          PUT(SELF.ControlQueue)
?         ASSERT(~ERRORCODE())
        END
        GET(SELF.ControlQueue, POINTER(SELF.ControlQueue) + 1)
      END
    END
  END


WindowResizeClass.SetParentControl PROCEDURE(SIGNED ControlID,SIGNED ParentID)

   CODE
   IF ControlID NOT=ParentID
     SELF.ControlQueue.ID=ControlID
     GET(SELF.ControlQueue,SELF.ControlQueue.ID)
     IF ~ERRORCODE()
       SELF.ControlQueue.ParentID=ParentID
       PUT(SELF.ControLQueue)
       ASSERT(~ERRORCODE())
     END
     IF ParentID
       SELF.ControlQueue.ID=ParentID
       GET(SELF.ControlQueue,SELF.ControlQueue.ID)
       ASSERT(~ERRORCODE())
       IF ~SELF.ControlQueue.HasChildren
         SELF.ControlQueue.HasChildren=True
         PUT(SELF.ControlQueue)
         ASSERT(~ERRORCODE())
       END
     END
   END


WindowResizeClass.SetParentDefaults PROCEDURE

iPnt        USHORT,AUTO
iSize       LIKE(PositionGroup),AUTO
pPnt        USHORT,AUTO
ThisControl LIKE(ControlQueue.ID),AUTO
ThisControlParent LIKE(ControlQueue.ParentID),AUTO

   CODE
   ASSERT(SELF.ResizeCalled=False)                 !should only be called before any resizes take place
   LOOP iPnt=1 TO RECORDS(SELF.ControlQueue)
     GET(SELF.ControlQueue,iPnt)
     ASSERT(~ERRORCODE())
     ASSERT(SELF.ControlQueue.Type NOT=CREATE:Tab)
     ThisControl=SELF.ControlQueue.ID
     ThisControlParent=SELF.ControlQueue.ParentID
     IF ThisControl{PROP:Parent}<>0
       LOOP WHILE (ThisControl{PROP:Parent}){PROP:Type}=CREATE:Tab
         ThisControl=ThisControl{PROP:Parent}
       END
       SELF.SetParentControl(ThisControl,ThisControl{PROP:Parent})
     ELSE
       iSize=SELF.ControlQueue.Pos
       LOOP pPnt=1 TO RECORDS(SELF.ControlQueue)
         GET(SELF.ControlQueue,pPnt)
         ASSERT(~ERRORCODE())
         IF SELF.ControlQueue.ID NOT=ThisControl AND INRANGE(SELF.ControlQueue.Pos.XPos,iSize.XPos,iSize.XPos+iSize.Width-1) AND INRANGE(SELF.ControlQueue.Pos.YPos,iSize.YPos,iSize.YPos+iSize.Height-1)
            IF (ThisControlParent AND ThisControlParent NOT= SELF.ControlQueue.ID) OR NOT ThisControlParent
               SELF.SetParentControl(SELF.ControlQueue.ID,ThisControl)
            END
         END
       END
     END
   END


WindowResizeClass.GetParentControl PROCEDURE(SIGNED ControlID)

  CODE
  SELF.ControlQueue.ID=ControlID
  GET(SELF.ControlQueue,SELF.ControlQueue.ID)
  ASSERT(~ERRORCODE())
  RETURN SELF.ControlQueue.ParentID


WindowResizeClass.SetPosition PROCEDURE(SIGNED ControlID,*PositionGroup ParentOrigPos,*PositionGroup ParentCurrentPos,*PositionGroup OrigPos,*PositionGroup NewPos)

ConstBottom    BYTE,AUTO
ConstRight     BYTE,AUTO
ConstBottomCnt BYTE,AUTO
ConstRightCnt  BYTE,AUTO
Delta          SIGNED,AUTO
HeightLocked   BYTE,AUTO
OrigLogicalX   SIGNED,AUTO
OrigLogicalY   SIGNED,AUTO
WidthLocked    BYTE,AUTO
xPositional    USHORT,AUTO
xScale         DECIMAL(6,4),AUTO
yPositional    USHORT,AUTO
yScale         DECIMAL(6,4),AUTO

  CODE
  xScale=ParentCurrentPos.Width/ParentOrigPos.Width
  yScale=ParentCurrentPos.Height/ParentOrigPos.Height
  ASSERT(SELF.ControlQueue.ID=ControlID)
  WidthLocked=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockWidth))
  HeightLocked=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockHeight))
  ConstRight=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:ConstantRight))
  ConstBottom=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:ConstantBottom))
  ConstRightCnt=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:ConstantRightCenter))
  ConstBottomCnt=CHOOSE(BAND(SELF.ControlQueue.ResizeStrategy,Resize:ConstantBottomCenter))
  xPositional=BAND(SELF.ControlQueue.PositionalStrategy,000FFh)
  yPositional=BAND(SELF.ControlQueue.PositionalStrategy,0FF00h)

  OrigLogicalX=OrigPos.XPos-ParentOrigPos.XPos
  OrigLogicalY=OrigPos.YPos-ParentOrigPos.YPos

  IF ~ConstRight AND ~ConstRightCnt THEN NewPos.Width=CHOOSE(WidthLocked=True,OrigPos.Width,OrigPos.Width*xScale).
  IF ~ConstBottom AND ~ConstBottomCnt THEN NewPos.Height=CHOOSE(HeightLocked=True,OrigPos.Height,OrigPos.Height*yScale).

  IF xPositional=Resize:FixNearestX
    xPositional=CHOOSE(OrigLogicalX<ParentOrigPos.Width-OrigLogicalX-OrigPos.Width,Resize:FixLeft,Resize:FixRight)
  END
  IF yPositional=Resize:FixNearestY
    yPositional=CHOOSE(OrigLogicalY<ParentOrigPos.Height-OrigLogicalY-OrigPos.Height,Resize:FixTop,Resize:FixBottom)
  END

  CASE xPositional
  OF Resize:LockXPos
    NewPos.XPos=OrigPos.XPos
  OF Resize:FixRight
    Delta=ParentOrigPos.Width-OrigLogicalX
    NewPos.XPos=ParentCurrentPos.XPos+(ParentCurrentPos.Width-CHOOSE(WidthLocked=True,Delta,Delta*xScale))
  OF Resize:FixLeft
    NewPos.XPos=ParentCurrentPos.XPos+OrigLogicalX
  OF Resize:FixXCenter
    Delta=OrigLogicalX-(ParentOrigPos.Width/2)
    NewPos.XPos=ParentCurrentPos.XPos+(ParentCurrentPos.Width/2+CHOOSE(WidthLocked=True,Delta,Delta*xScale))
  ELSE
    NewPos.XPos=(ParentCurrentPos.XPos+OrigLogicalX)*xScale
  END

  CASE yPositional
  OF Resize:LockYPos
    NewPos.YPos=OrigPos.YPos
  OF Resize:FixBottom
    Delta=ParentOrigPos.Height-OrigLogicalY
    NewPos.YPos=ParentCurrentPos.YPos+(ParentCurrentPos.Height-CHOOSE(HeightLocked=True,Delta,Delta*yScale))
  OF Resize:FixTop
    NewPos.YPos=ParentCurrentPos.YPos+OrigLogicalY
  OF Resize:FixYCenter
    Delta=OrigLogicalY-(ParentOrigPos.Height/2)
    NewPos.YPos=ParentCurrentPos.YPos+(ParentCurrentPos.Height/2+CHOOSE(HeightLocked=True,Delta,Delta*yScale))
  ELSE
    NewPos.YPos=(ParentCurrentPos.YPos+OrigLogicalY)*yScale
  END

  IF ConstRight
    NewPos.Width=ParentCurrentPos.XPos+ParentCurrentPos.Width-(ParentOrigPos.Width-OrigLogicalX-OrigPos.Width)-NewPos.XPos
  ELSIF ConstRightCnt
    NewPos.Width=OrigPos.Width+(ParentCurrentPos.XPos+ParentCurrentPos.Width-(ParentOrigPos.Width-OrigLogicalX)-NewPos.XPos)/2
  END
  IF ConstBottom
    NewPos.Height=ParentCurrentPos.YPos+ParentCurrentPos.Height-(ParentOrigPos.Height-OrigLogicalY-OrigPos.Height)-NewPos.YPos
  ELSIF ConstBottomCnt
    NewPos.Height=OrigPos.Height+(ParentCurrentPos.YPos+ParentCurrentPos.Height-(ParentOrigPos.Height-OrigLogicalY)-NewPos.YPos)/2
  END


!This method gets the origonal position of the control. This is the position of the control when the
!last Reset was called. Returns False if the CtrlId is not recognised

WindowResizeClass.GetOrigPos PROCEDURE(SIGNED CtrlId,*PositionGroup PG)

  CODE
  SELF.ControlQueue.ID = CtrlId
  GET(SELF.ControlQueue,SELF.ControlQueue.Id)
  IF ERRORCODE() THEN RETURN False.
  PG = SELF.ControlQueue.Pos
  RETURN True


!Thsi method gets the current position of a control. Will return False if the resizer cannot find the control

WindowResizeClass.GetCurrentPos PROCEDURE(SIGNED CtrlId,*PositionGroup PG)

  CODE
  SELF.ControlQueue.ID = CtrlId
  GET(SELF.ControlQueue,SELF.ControlQueue.Id)
  IF ERRORCODE() THEN RETURN False.
  GetSizeInfo(CtrlId,PG)
  RETURN True


WindowResizeClass.ResizeChildren PROCEDURE(SIGNED ParentID,*PositionGroup ParentOrigPos,*PositionGroup ParentCurrentPos)

FieldCounter   UNSIGNED,AUTO
ResizeList     &ResizeQueue,AUTO
POrigPos       LIKE(PositionGroup),AUTO
PNewPos        LIKE(PositionGroup),AUTO

  CODE
  ResizeList &= SELF.ResizeList
  LOOP FieldCounter=1 TO RECORDS(SELF.ControlQueue)
    GET(SELF.ControlQueue,FieldCounter)
    ASSERT(~ERRORCODE())
    IF SELF.ControlQueue.ParentID=ParentID
      CLEAR(ResizeList)
      ResizeList.ControlID=SELF.ControlQueue.ID
      ResizeList.Type=SELF.ControlQueue.Type
      GetSizeInfo(SELF.ControlQueue.ID,ResizeList.Before)
      SELF.SetPosition(ResizeList.ControlID,ParentOrigPos,ParentCurrentPos,SELF.ControlQueue.Pos,ResizeList.After)
      POrigPos = SELF.ControlQueue.Pos
      PNewPos = ResizeList.After
      ADD(ResizeList)
      ASSERT(~ERRORCODE())
      IF ResizeList.Before NOT=ResizeList.After AND SELF.ControlQueue.HasChildren
        SELF.ResizeChildren(SELF.ControlQueue.ID,POrigPos,PNewPos)
      END
    END
  END


RestoreControls PROCEDURE(WindowResizeClass SELF)

i  UNSIGNED,AUTO

   CODE
   LOOP i=1 TO RECORDS(SELF.ControlQueue)
     GET(SELF.ControlQueue,i)
     ASSERT(~ERRORCODE())
     SetSize(SELF.ControlQueue.ID,SELF.ControlQueue.Pos)
   END


GetSizeInfo PROCEDURE(SHORT ControlID,*PositionGroup s)

   CODE
   GETPOSITION(ControlID,s.XPos,s.YPos,s.Width,s.Height)
   IF ~ControlId
    s.Width = 0{PROP:ClientWidth}
    s.Height = 0{PROP:ClientHeight}
   END


SetSize PROCEDURE(SHORT ControlID,*PositionGroup s)

c LIKE(PositionGroup),AUTO

   CODE
   GetSizeInfo(ControlID,c)
   IF c<>s
    IF ControlID{PROP:NoWidth}
      SETPOSITION(ControlID,s.XPos,s.Ypos,,s.Height)
    ELSE
      SETPOSITION(ControlID,s.XPos,s.Ypos,s.Width,s.Height)
    END
  END


SetPriorities PROCEDURE(WindowResizeClass SELF,*PositionGroup CurrentSize)

i USHORT,AUTO

  CODE
  IF CurrentSize.Width<>SELF.PreviousWin.Width AND CurrentSize.Height<>SELF.PreviousWin.Height
    DO FullResize
  ELSIF CurrentSize.Width=SELF.PreviousWin.Width
    DO VerticalResize
  ELSE
    DO HorizontalResize
  END

VerticalResize ROUTINE
  LOOP i=1 TO RECORDS(SELF.ResizeList)
    GET(SELF.ResizeList,i)
    ASSERT(~ERRORCODE())
    SELF.ResizeList.Priority=SELF.ResizeList.After.YPos
    PUT(SELF.ResizeList)
    ASSERT(~ERRORCODE())
  END

HorizontalResize ROUTINE
  LOOP i=1 TO RECORDS(SELF.ResizeList)
    GET(SELF.ResizeList,i)
    ASSERT(~ERRORCODE())
    SELF.ResizeList.Priority=SELF.ResizeList.After.XPos
    PUT(SELF.ResizeList)
    ASSERT(~ERRORCODE())
  END

FullResize ROUTINE
  LOOP i=1 TO RECORDS(SELF.ResizeList)
    GET(SELF.ResizeList,i)
    ASSERT(~ERRORCODE())
    SELF.ResizeList.Priority=(SELF.ResizeList.After.XPos^2)+(SELF.ResizeList.After.YPos^2)
    PUT(SELF.ResizeList)
    ASSERT(~ERRORCODE())
  END
