!Resize method implementations

  MEMBER()

  INCLUDE('ResDef.Clw')
  INCLUDE('TplEqu.Clw')

  MAP
  END


WindowResizeType.Initialize PROCEDURE(UNSIGNED AppStrategy)

FieldCounter        SIGNED,AUTO

  CODE
  SELF.ControlQueue&=NEW(ControlQueueType)
  GETPOSITION(0,SELF.OrigWin.XPos,SELF.OrigWin.YPos,SELF.OrigWin.Width,SELF.OrigWin.Height)
  SELF.PreviousWin = SELF.OrigWin
  LOOP FieldCounter=FIRSTFIELD() TO LASTFIELD()
    SELF.ControlQueue.Type=FieldCounter{PROP:Type}
    IF SELF.ControlQueue.Type AND ~(SELF.ControlQueue.Type=CREATE:Menu OR SELF.ControlQueue.Type=CREATE:Item) THEN
      SELF.ControlQueue.ID=FieldCounter
      GETPOSITION(FieldCounter,SELF.ControlQueue.Pos.XPos,SELF.ControlQueue.Pos.YPos,SELF.ControlQueue.Pos.Width,SELF.ControlQueue.Pos.Height)
      CASE AppStrategy
      OF 1
        DO ResizeStrategy
      OF 2
        DO SpreadStrategy
      ELSE
        SELF.ControlQueue.PositionalStrategy=0
        SELF.ControlQueue.ResizeStrategy=0
      END
      ADD(SELF.ControlQueue)
    END
  END
  SORT(SELF.ControlQueue,SELF.ControlQueue.ID)


ResizeStrategy      ROUTINE
  SELF.ControlQueue.PositionalStrategy=0
  SELF.ControlQueue.ResizeStrategy=0


SpreadStrategy      ROUTINE
  CASE SELF.ControlQueue.Type
  OF CREATE:Button
    SELF.ControlQueue.PositionalStrategy=Resize:FixNearestX+Resize:FixNearestY
    SELF.ControlQueue.ResizeStrategy=Resize:LockWidth+Resize:LockHeight
  OF CREATE:Radio
  OROF CREATE:Check
    SELF.ControlQueue.PositionalStrategy=0
    SELF.ControlQueue.ResizeStrategy=Resize:LockWidth+Resize:LockHeight
  OF CREATE:Entry
  OROF CREATE:Combo
  OROF CREATE:Spin
  OROF CREATE:DropCombo
    SELF.ControlQueue.PositionalStrategy=0
    SELF.ControlQueue.ResizeStrategy=Resize:LockHeight
  ELSE
    SELF.ControlQueue.PositionalStrategy=0
    SELF.ControlQueue.ResizeStrategy=0
  END


WindowResizeType.Resize PROCEDURE

HiMask              EQUATE(1111111100000000b)
LoMask              EQUATE(0000000011111111b)

CurrentSize         LIKE(ControlPosType),AUTO
NewSize             LIKE(ControlPosType),AUTO
xScale              DECIMAL(6,4),AUTO
yScale              DECIMAL(6,4),AUTO
FieldCounter        UNSIGNED,AUTO
Delta               SIGNED,AUTO
SaveDeferMove       SIGNED,AUTO
xPositional         USHORT,AUTO
yPositional         USHORT,AUTO

  CODE
  SaveDeferMove=SYSTEM{PROP:DeferMove}
  GETPOSITION(0,CurrentSize.XPos,CurrentSize.YPos,CurrentSize.Width,CurrentSize.Height)
  IF CurrentSize.Width = SELF.PreviousWin.Width AND CurrentSize.Height = SELF.PreviousWin.Height THEN
    RETURN
  ELSE
    SELF.PreviousWin = CurrentSize
  END
  xScale=CurrentSize.Width/SELF.OrigWin.Width
  yScale=CurrentSize.Height/SELF.OrigWin.Height

  SYSTEM{PROP:DeferMove}=RECORDS(SELF.ControlQueue)

  LOOP FieldCounter=1 TO RECORDS(SELF.ControlQueue)
    GET(SELF.ControlQueue,FieldCounter)

    NewSize.XPos=SELF.ControlQueue.Pos.XPos*xScale
    NewSize.YPos=SELF.ControlQueue.Pos.YPos*yScale
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockWidth) THEN
      NewSize.Width=SELF.ControlQueue.Pos.Width
    ELSE
      NewSize.Width=SELF.ControlQueue.Pos.Width*xScale
    END
    IF BAND(SELF.ControLQueue.ResizeStrategy,Resize:LockHeight) THEN
      NewSize.Height=SELF.ControlQueue.Pos.Height
    ELSE
      NewSize.Height=SELF.ControlQueue.Pos.Height*yScale
    END

    xPositional=BAND(SELF.ControlQueue.PositionalStrategy,LoMask)
    yPositional=BAND(SELF.ControlQueue.PositionalStrategy,HiMask)

    DO DeriveStrategy

    IF xScale <> 1 THEN
      DO CalcXPos
    END
    IF ySCale <> 1 THEN
      DO CalcYPos
    END

    IF SELF.ControlQueue.Type=CREATE:Sstring AND SELF.ControlQueue.Pos.Width=1 THEN
      SETPOSITION(SELF.ControlQueue.ID,NewSize.XPos,NewSize.YPos,,NewSize.Height)
    ELSE
      SETPOSITION(SELF.ControlQueue.ID,NewSize.XPos,NewSize.YPos,NewSize.Width,NewSize.Height)
    END
  END
  IF SaveDeferMove<0 THEN
    SYSTEM{PROP:DeferMove}=SaveDeferMove
  END


DeriveStrategy      ROUTINE
  IF xPositional=Resize:FixNearestX THEN
    xPositional=CHOOSE(SELF.ControlQueue.Pos.XPos<=SELF.OrigWin.Width-SELF.ControlQueue.Pos.XPos-SELF.ControlQueue.Pos.Width,Resize:FixLeft,Resize:FixRight)
  END
  IF yPositional=Resize:FixNearestY THEN
    yPositional=CHOOSE(SELF.ControlQueue.Pos.YPos<=SELF.OrigWin.Height-Self.ControlQueue.Pos.YPos-SELF.ControlQueue.Pos.Height,Resize:FixTop,Resize:FixBottom)
  END


CalcXPos            ROUTINE
  CASE xPositional
  OF Resize:LockXPos
    NewSize.XPos=SELF.ControlQueue.Pos.XPos
  OF Resize:FixRight
    Delta=SELF.OrigWin.Width-SELF.ControlQueue.Pos.XPos
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockWidth) THEN
      NewSize.XPos=CurrentSize.Width-Delta
    ELSE
      NewSize.XPos=CurrentSize.Width-Delta*xScale
    END
  OF Resize:FixLeft
    Delta=SELF.ControlQueue.Pos.XPos
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockWidth) THEN
      NewSize.XPos=Delta
    ELSE
      NewSize.XPos=Delta*xScale
    END
  OF Resize:FixXCentre
    Delta=SELF.ControlQueue.Pos.XPos-(SELF.OrigWin.Width/2)
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockWidth) THEN
      NewSize.XPos=CurrentSize.Width/2+Delta
    ELSE
      NewSize.XPos=CurrentSize.Width/2+Delta*xScale
    END
  END


CalcYPos            ROUTINE
  CASE yPositional
  OF Resize:LockYPos
    NewSize.YPos=SELF.ControlQueue.Pos.YPos
  OF Resize:FixBottom
    Delta=SELF.OrigWin.Height-SELF.ControlQueue.Pos.YPos
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockHeight) THEN
      NewSize.YPos=CurrentSize.Height-Delta
    ELSE
      NewSize.YPos=CurrentSize.Height-Delta*yScale
    END
  OF Resize:FixTop
    Delta=SELF.ControlQueue.Pos.YPos
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockHeight) THEN
      NewSize.YPos=Delta
    ELSE
      NewSize.YPos=Delta*yScale
    END
  OF Resize:FixYCentre
    Delta=SELF.ControlQueue.Pos.YPos-SELF.OrigWin.Height/2
    IF BAND(SELF.ControlQueue.ResizeStrategy,Resize:LockHeight) THEN
      NewSize.YPos=CurrentSize.Height/2+Delta
    ELSE
      NewSize.YPos=CurrentSize.Height/2+Delta*yScale
    END
  END



WindowResizeType.Destroy PROCEDURE

  CODE
  IF NOT SELF.ControlQueue &= NULL
    DISPOSE (SELF.ControlQueue)
    SELF.ControlQueue &= NULL
  END
  RETURN


WindowResizeType.SetControlStrategy PROCEDURE(SIGNED ControlID, USHORT PositionalStrategy, USHORT ResizeStrategy)

FieldCounter        SIGNED,AUTO

  CODE
  IF ~ControlID THEN
    LOOP FieldCounter=1 TO RECORDS(SELF.ControlQueue)
      GET(SELF.ControlQueue,FieldCounter)
      DO SetStrategy
    END
  ELSE
    SELF.ControlQueue.ID=ControlID
    GET(SELF.ControlQueue,SELF.ControlQueue.ID)
    IF ~ERRORCODE() THEN
      DO SetStrategy
    END
  END


SetStrategy         ROUTINE
  SELF.ControlQueue.PositionalStrategy=PositionalStrategy
  SELF.ControlQueue.ResizeStrategy=ResizeStrategy
  PUT(SELF.ControlQueue)
