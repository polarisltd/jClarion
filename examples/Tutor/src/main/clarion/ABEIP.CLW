! Edit-in-place classes
  MEMBER

  include('ABWINDOW.INC'),ONCE
  include('ABEIP.TRN'),ONCE

  MAP
GetColorText     PROCEDURE(LONG Color),STRING,PRIVATE
GetColorValue    PROCEDURE(STRING Str),LONG,PRIVATE
ConvertBase      PROCEDURE(STRING Value, *LONG Result, LONG Base=16),BYTE,PROC,PRIVATE
InitializeColors PROCEDURE,PRIVATE
  END

  INCLUDE('ABEIP.inc'),ONCE
  INCLUDE('EQUATES.CLW'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE

ItemQueue QUEUE,TYPE
Item        CSTRING(1024)
Mark        BYTE
          END

ColorQInitialized BYTE
ColorMap QUEUE
Color      LONG
Text       CSTRING(25)
TextKey    PSTRING(25)
         END

MultiWindow WINDOW('Choose items and order'),AT(,,300,200),FONT('MS Sans Serif',8,,FONT:regular),CENTER, |
         IMM,SYSTEM,GRAY,DOUBLE,AUTO
       PANEL,AT(5,5,290,176),USE(?Panel1)
       GROUP('&Available items'),AT(10,10,125,166),USE(?Group2),BOXED
         LIST,AT(15,20,115,151),USE(?Available),HVSCROLL,ALRT(MouseLeft2)
       END
       GROUP('&Selected items'),AT(165,10,125,166),USE(?Group3),BOXED
         LIST,AT(170,20,115,151),USE(?Selected),HVSCROLL,ALRT(MouseLeft2)
       END
       BUTTON('>'),AT(141,41,18,14),USE(?SelectSome)
       BUTTON('>>'),AT(141,55,18,14),USE(?SelectAll)
       BUTTON('<<'),AT(141,79,18,14),USE(?DeselectSome)
       BUTTON('<<<<'),AT(141,93,18,14),USE(?DeselectAll)
       BUTTON,AT(141,117,18,14),USE(?MoveUp),DISABLE,ICON('ABUPROW.ICO')
       BUTTON,AT(141,131,18,14),USE(?MoveDown),DISABLE,ICON('ABDNROW.ICO')
       BUTTON('&Ok'),AT(203,184,45,14),USE(?Ok),DEFAULT
       BUTTON('&Cancel'),AT(250,184,45,14),USE(?Cancel)
     END

MSWindowClass  CLASS(WindowManager),TYPE
MSEC             &EditMultiSelectClass

DeSelect         PROCEDURE(LONG Index)
Init             PROCEDURE(EditMultiSelectClass MSEC)
Select           PROCEDURE(LONG Index)
TakeAccepted     PROCEDURE(),BYTE,PROC,VIRTUAL
TakeFieldEvent   PROCEDURE,BYTE,PROC,VIRTUAL
TakeNewSelection PROCEDURE,VIRTUAL,BYTE,PROC
UpdateUD         PROCEDURE
               END

TxtWindow WINDOW('Caption'),AT(,,300,200),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),SYSTEM,GRAY, |
         DOUBLE
       TEXT,AT(5,5,290,176),USE(?Text),VSCROLL,FONT('Courier New',8,,FONT:regular,CHARSET:ANSI)
       BUTTON('&Ok'),AT(203,184,45,14),USE(?TxtOk),DEFAULT
       BUTTON('&Cancel'),AT(250,184,45,14),USE(?TxtCancel)
     END

!***********************************************************************
! Edit Class, implements the edit in place functionality for a simplistic
! entry control.
! Init & Kill are called upon entry and exit from the .Ask function
! In particular Kill -must- leave the object in an Initable state.
!***********************************************************************

EditClass.Init PROCEDURE(UNSIGNED FieldNo,UNSIGNED ListBox,*? UseVar)
  CODE

  SELF.ListBoxFeq = ListBox
  SELF.FieldNo    = FieldNo
  SELF.CreateControl()
  ASSERT(SELF.Feq)
  SELF.UseVar &= UseVar
  SELF.Feq{PROP:Text} = SELF.ListBoxFeq{PROPLIST:Picture,SELF.FieldNo}
  SELF.Feq{PROP:Use} = UseVar
  SELF.SetAlerts

EditClass.SetAlerts PROCEDURE
  CODE

  SELF.Feq{PROP:Alrt,1} = TabKey
  SELF.Feq{PROP:Alrt,2} = ShiftTab
  SELF.Feq{PROP:Alrt,3} = EnterKey
  SELF.Feq{PROP:Alrt,4} = EscKey
  SELF.Feq{PROP:Alrt,5} = DownKey
  SELF.Feq{PROP:Alrt,6} = UpKey

EditClass.CreateControl PROCEDURE
  CODE

  ASSERT(False)


EditClass.SetReadOnly PROCEDURE(BYTE State)
  CODE

  SELF.ReadOnly=State
  SELF.Feq{PROP:ReadOnly}=State


EditClass.Kill PROCEDURE
  CODE
  IF SELF.Feq
    DESTROY(SELF.Feq) 
    SELF.Feq = 0
  END
  SELF.UseVar &= NULL

EditClass.TakeAccepted PROCEDURE(BYTE Action)
  CODE
  UPDATE(SELF.Feq)
  RETURN Action

EditClass.TakeEvent PROCEDURE(UNSIGNED E)
  CODE

  CASE E
  OF EVENT:AlertKey
    CASE KEYCODE()
    OF EnterKey
      RETURN EditAction:Complete
    OF EscKey
      RETURN EditAction:Cancel
    OF TabKey
      RETURN EditAction:Forward
    OF ShiftTab
      RETURN EditAction:Backward
    OF DownKey
      RETURN EditAction:Next
    OF UpKey
      RETURN EditAction:Previous
    END
  END
  RETURN EditAction:None


EditEntryClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0,CREATE:Entry)

TextWindowClass.Init PROCEDURE

ReadOnlyFlag BYTE, AUTO

  CODE
  PARENT.Init()
  SELF.SelS = self.EntryFEQ{PROP:SelStart}
  SELF.SelE = self.EntryFEQ{PROP:SelEnd}
  UPDATE(self.EntryFEQ)
  SELF.Txt = self.EntryFEQ{PROP:Use}
  ReadOnlyFlag = self.EntryFEQ{PROP:ReadOnly}
  OPEN(TxtWindow)
  TxtWindow{PROP:Text} = SELF.Title
  ?Text{PROP:Use} = SELF.Txt
  ?Text{PROP:Text}=SELF.Txt
  ?Text{PROP:SelStart} = SELF.SelS
  IF SELF.SelE
    ?Text{PROP:SelEnd} = SELF.SelE
  END
  DISPLAY(?Text)
  IF ReadOnlyFlag
    ?Text{PROP:ReadOnly} = True
  END
  RETURN LEVEL:Benign

TextWindowClass.Kill PROCEDURE

  CODE
  SELF.SelS = ?Text{PROP:SelStart}
  SELF.SelE = ?Text{PROP:SelEnd}
  SELF.Txt = ?Text{PROP:Use}
  CLOSE(TxtWindow)
  IF SELF.Response = RequestCompleted
    CHANGE(SELF.EntryFEQ, SELF.Txt)
    DISPLAY(SELF.EntryFeq)
    SELF.EntryFEQ{PROP:SelStart} = SELF.SelS
    IF SELF.SelE
      SELF.EntryFEQ{PROP:SelEnd} = SELF.SelE
    END
  END
  SELF.Txt &= NULL
  RETURN PARENT.Kill()

TextWindowClass.Init PROCEDURE(SIGNED EntryFEQ, STRING Title)

  CODE
  SELF.Title = Title
  SELF.EntryFEQ = EntryFEQ

TextWindowClass.TakeAccepted PROCEDURE
  CODE

  CASE FIELD()
  OF ?TxtOk
    SELF.SetResponse(RequestCompleted)
  OF ?TxtCancel
    SELF.SetResponse(RequestCancelled)
  END
  RETURN PARENT.TakeAccepted()

EditTextClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis


EditTextClass.TakeEvent PROCEDURE(UNSIGNED E)
TextWindow TextWindowClass
  CODE

  CASE E
  OF EVENT:DroppingDown
    IF NOT SELF.Title THEN
       SELF.Title = SELF.ListBoxFeq{PROPLIST:Header,SELF.FieldNo}
    END
    TextWindow.Init(self.FEQ, SELF.Title)
    TextWindow.Run()
    RETURN CHOOSE(TextWindow.Response=RequestCompleted, EditAction:Ignore, EditAction:None)
  ELSE
    RETURN PARENT.TakeEvent(E)
  END


EditCheckClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:Check)
EditCheckClass.Init PROCEDURE(UNSIGNED FieldNo,UNSIGNED ListBox,*? UseVar)
  CODE
  PARENT.Init(FieldNo,ListBox,UseVar)
  SELF.Feq{PROP:Text} = ListBox{PROPLIST:Header,FieldNo}


EditSpinClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:Spin)
  SELF.Feq{PROP:Step}=1
  SELF.Feq{PROP:RangeLow}=80000001h
  SELF.Feq{PROP:RangeHigh}=7FFFFFFFh


EditDropListClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:DropList)


EditDropListClass.SetReadOnly PROCEDURE(BYTE State)
  CODE

  PARENT.SetReadOnly(State)
  IF SELF.ReadOnly THEN SELF.Feq{PROP:Drop} = 0 .


EditDropListClass.SetAlerts PROCEDURE
  CODE

  SELF.Feq{PROP:Alrt,1} = TabKey
  SELF.Feq{PROP:Alrt,2} = ShiftTab
  SELF.Feq{PROP:Alrt,3} = EnterKey
  SELF.Feq{PROP:Alrt,4} = EscKey

EditDropListClass.TakeEvent PROCEDURE(UNSIGNED E)
  CODE
  CASE E
  OF EVENT:Accepted
    RETURN EditAction:Forward
  ELSE
    RETURN PARENT.TakeEvent(E)
  END


EditDropComboClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:DropCombo)


EditColorClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis


EditColorClass.TakeEvent PROCEDURE(UNSIGNED E)
Val    LONG,AUTO
  CODE

  CASE E
  OF EVENT:DroppingDown
    IF ~SELF.ReadOnly
      IF NOT SELF.Title THEN
         SELF.Title = SELF.ListBoxFeq{PROPLIST:Header,SELF.FieldNo}
      END
      UPDATE(SELF.FEQ)
      Val=GetColorValue(SELF.UseVar)
      IF COLORDIALOG(SELF.Title, Val)
        SELF.UseVar = GetColorText(Val)
        DISPLAY(SELF.Feq)
      END
      RETURN EditAction:Ignore
    END
  END
  RETURN PARENT.TakeEvent(E)


EditFileClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis


EditFileClass.TakeEvent PROCEDURE(UNSIGNED E)
Str CSTRING(FILE:MaxFilePath+1),AUTO
  CODE

  CASE E
  OF EVENT:DroppingDown
    IF ~SELF.ReadOnly
      IF NOT SELF.Title THEN
         SELF.Title = SELF.ListBoxFeq{PROPLIST:Header,SELF.FieldNo}
      END
      UPDATE(SELF.FEQ)
      Str=SELF.UseVar
      IF FILEDIALOG(SELF.Title, Str, SELF.FilePattern, SELF.FileMask)
        SELF.UseVar=Str
        DISPLAY(SELF.Feq)
      END
      RETURN EditAction:Ignore
    END
  END
  RETURN PARENT.TakeEvent(E)

EditLookupClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis

EditLookupClass.TakeEvent PROCEDURE(UNSIGNED E)
lEditAction BYTE
lParentEditAction BYTE
  CODE

  CASE E
  OF EVENT:DroppingDown
    IF ~SELF.ReadOnly
        UPDATE(SELF.FEQ)
        lEditAction=SELF.AskLookup(True)
        DISPLAY(SELF.Feq)
        RETURN lEditAction
    END
  END
  lParentEditAction=PARENT.TakeEvent(E)
  IF NOT(lParentEditAction = EditAction:Cancel OR lParentEditAction = EditAction:None OR lParentEditAction = EditAction:Ignore) THEN
     lEditAction=SELF.AskLookup(False)
     DISPLAY(SELF.Feq)
     IF lEditAction=EditAction:Ignore THEN
        RETURN lParentEditAction
     ELSE
        RETURN EditAction:None
     END
  ELSE
     RETURN lParentEditAction
  END



EditLookupClass.AskLookup PROCEDURE(BYTE pForce)
  CODE
  RETURN EditAction:Ignore
EditCalendarClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis

EditCalendarClass.SetCalendar      PROCEDURE(*CalendarBaseClass pCalendar)
  CODE
     SELF.Calendar &= pCalendar

EditCalendarClass.TakeEvent PROCEDURE(UNSIGNED E)
lDate       LONG
lCalendar   CalendarClass
lResponse   BYTE
  CODE
  CASE E
  OF EVENT:DroppingDown
    IF ~SELF.ReadOnly
      UPDATE(SELF.FEQ)
      lDate=SELF.UseVar
      IF SELF.Calendar &= NULL THEN
         lDate=lCalendar.Ask(SELF.Title,lDate)
         lResponse=lCalendar.Response
      ELSE
         lDate=SELF.Calendar.Ask(SELF.Title,lDate)
         lResponse=SELF.Calendar.Response
      END
      IF lResponse=RequestCompleted THEN
        SELF.UseVar = lDate
        DISPLAY(SELF.Feq)
      END
      RETURN EditAction:Ignore
    END
  END
  RETURN PARENT.TakeEvent(E)



EditFontClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis


EditFontClass.TakeEvent PROCEDURE(UNSIGNED E)
FontS CSTRING(256),AUTO
  CODE

  CASE E
  OF EVENT:DroppingDown
    IF ~SELF.ReadOnly
      IF NOT SELF.Title THEN
         SELF.Title = SELF.ListBoxFeq{PROPLIST:Header,SELF.FieldNo}
      END
      UPDATE(SELF.FEQ)
      FontS=SELF.UseVar
      IF FONTDIALOG(SELF.Title, FontS)
        SELF.UseVar = FontS
        DISPLAY(SELF.Feq)
      END
      RETURN EditAction:Ignore
    END
  END
  RETURN PARENT.TakeEvent(E)


MSWindowClass.Init PROCEDURE(EditMultiSelectClass MSEC)
  CODE

  SELF.MSEC &= MSEC


MSWindowClass.TakeFieldEvent PROCEDURE
RVal BYTE,AUTO
  CODE

  RVal = PARENT.TakeFieldEvent()
  IF RVal = Level:Benign
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft2
        CASE FIELD()
        OF ?Selected
          SELF.DeSelect(CHOICE(?Selected))
        OF ?Available
          SELF.Select(CHOICE(?Available))
        END
      END
    END
  END
  RETURN RVal


MSWindowClass.DeSelect PROCEDURE(LONG Index)
  CODE

  IF Index
    SELF.MSEC.TakeAction(MSAction:StartProcess)
    GET(SELF.MSEC.Selected, Index)
    ASSERT(~ERRORCODE())
    SELF.MSEC.Available.Item = SELF.MSEC.Selected.Item
    DELETE(SELF.MSEC.Selected)
    ASSERT(~ERRORCODE())
    ADD(SELF.MSEC.Available)
    DISPLAY
    SELF.MSEC.TakeAction(MSAction:Delete, SELF.MSEC.Selected.Item)
    SELF.MSEC.TakeAction(MSAction:EndProcess)
    SELF.UpdateUD
  END


MSWindowClass.Select PROCEDURE(LONG Index)
  CODE

  IF Index
    SELF.MSEC.TakeAction(MSAction:StartProcess)
    GET(SELF.MSEC.Available, Index)
    ASSERT(~ERRORCODE())
    SELF.MSEC.Selected.Item = SELF.MSEC.Available.Item
    DELETE(SELF.MSEC.Available)
    ASSERT(~ERRORCODE())
    ADD(SELF.MSEC.Selected)
    DISPLAY
    SELF.MSEC.TakeAction(MSAction:Add, SELF.MSEC.Selected.Item)
    SELF.MSEC.TakeAction(MSAction:EndProcess)
    SELF.UpdateUD
  END


MSWindowClass.TakeNewSelection PROCEDURE
  CODE

  IF FIELD()=?Selected THEN SELF.UpdateUD .
  RETURN Level:Benign


MSWindowClass.UpdateUD PROCEDURE
I        UNSIGNED,AUTO
Selected UNSIGNED
  CODE

  LOOP I=1 TO RECORDS(SELF.MSEC.Selected)
    GET(SELF.MSEC.Selected, I)
    IF SELF.MSEC.Selected.Mark THEN Selected += 1 .
    IF Selected>1 THEN BREAK .
  END
  IF Selected=1
    ENABLE(?MoveUp)
    ENABLE(?MoveDown)
  ELSE
    DISABLE(?MoveUp)
    DISABLE(?MoveDown)
  END


MSWindowClass.TakeAccepted PROCEDURE
a   LONG,AUTO
p   LONG,AUTO
I   LONG,AUTO
Rdy BYTE
  CODE

  CASE FIELD()
  OF ?SelectSome
    p = RECORDS(SELF.MSEC.Available)
    LOOP I=1 TO p
      GET(SELF.MSEC.Available, I)
      IF SELF.MSEC.Available.Mark THEN Rdy = True .
    END
    IF Rdy
      SELF.MSEC.TakeAction(MSAction:StartProcess)
      LOOP a=1 TO p
        GET(SELF.MSEC.Available, a)
        ASSERT(~ERRORCODE())
        IF ~SELF.MSEC.Available.Mark THEN CYCLE .
        SELF.MSEC.Selected.Item = SELF.MSEC.Available.Item
        DELETE(SELF.MSEC.Available)
        ASSERT(~ERRORCODE())
        a -= 1
        p -= 1

        ADD(SELF.MSEC.Selected)
        DISPLAY
        SELF.MSEC.TakeAction(MSAction:Add, SELF.MSEC.Selected.Item)
      END
      SELF.MSEC.TakeAction(MSAction:EndProcess)
      SELF.UpdateUD
    END
  OF ?SelectAll
    p = RECORDS(SELF.MSEC.Available)
    IF p THEN SELF.MSEC.TakeAction(MSAction:StartProcess) .
    LOOP a=1 TO p
      GET(SELF.MSEC.Available, 1)
      ASSERT(~ERRORCODE())

      SELF.MSEC.Selected.Item = SELF.MSEC.Available.Item
      DELETE(SELF.MSEC.Available)
      ASSERT(~ERRORCODE())

      ADD(SELF.MSEC.Selected)
      DISPLAY
      SELF.MSEC.TakeAction(MSAction:Add, SELF.MSEC.Selected.Item)
    END
    IF p
      SELF.MSEC.TakeAction(MSAction:EndProcess)
      SELF.UpdateUD
    END
  OF ?DeselectSome
    p = RECORDS(SELF.MSEC.Selected)
    LOOP I=1 TO p
      GET(SELF.MSEC.Selected, I)
      IF SELF.MSEC.Selected.Mark THEN Rdy = True .
    END
    IF Rdy
      SELF.MSEC.TakeAction(MSAction:StartProcess)
      LOOP a=1 TO p
        GET(SELF.MSEC.Selected, a)
        ASSERT(~ERRORCODE())
        IF ~SELF.MSEC.Selected.Mark THEN CYCLE .
        SELF.MSEC.Available.Item = SELF.MSEC.Selected.Item
        DELETE(SELF.MSEC.Selected)
        ASSERT(~ERRORCODE())
        a -= 1
        p -= 1

        ADD(SELF.MSEC.Available)
        DISPLAY
        SELF.MSEC.TakeAction(MSAction:Delete, SELF.MSEC.Selected.Item)
      END
      SELF.MSEC.TakeAction(MSAction:EndProcess)
      SELF.UpdateUD
    END
  OF ?DeselectAll
    p = RECORDS(SELF.MSEC.Selected)
    IF p THEN SELF.MSEC.TakeAction(MSAction:StartProcess) .
    LOOP a=1 TO p
      GET(SELF.MSEC.Selected, 1)
      ASSERT(~ERRORCODE())

      SELF.MSEC.Available.Item = SELF.MSEC.Selected.Item
      DELETE(SELF.MSEC.Selected)
      ASSERT(~ERRORCODE())

      ADD(SELF.MSEC.Available)
      DISPLAY
      SELF.MSEC.TakeAction(MSAction:Delete, SELF.MSEC.Selected.Item)
    END
    IF p
      SELF.MSEC.TakeAction(MSAction:EndProcess)
      SELF.UpdateUD
    END
  OF ?MoveUp
    a = CHOICE(?Selected)
    IF a>1
      GET(SELF.MSEC.Selected, a)
      ASSERT(~ERRORCODE())
      p = POINTER(SELF.MSEC.Selected)-1
      DELETE(SELF.MSEC.Selected)
      ADD(SELF.MSEC.Selected, p)
      ASSERT(~ERRORCODE())
      SELECT(?Selected, p)
      SELF.MSEC.TakeAction(MSAction:Move, SELF.MSEC.Selected.Item, p+1, p)
    END
  OF ?MoveDown
    a = CHOICE(?Selected)
    IF a AND a<RECORDS(SELF.MSEC.Selected)
      GET(SELF.MSEC.Selected, a)
      ASSERT(~ERRORCODE())
      p = POINTER(SELF.MSEC.Selected)+1
      DELETE(SELF.MSEC.Selected)
      ADD(SELF.MSEC.Selected, p)
      ASSERT(~ERRORCODE())
      SELECT(?Selected, p)
      SELF.MSEC.TakeAction(MSAction:Move, SELF.MSEC.Selected.Item, p-1, p)
    END
  OF ?Ok
    SELF.SetResponse(RequestCompleted)
  OF ?Cancel
    SELF.SetResponse(RequestCancelled)
  END
  RETURN PARENT.TakeAccepted()


EditMultiSelectClass.Init PROCEDURE(UNSIGNED FieldNo,UNSIGNED ListBox,*? UseVar)
  CODE

  PARENT.Init(FieldNo, ListBox, UseVar)
  SELF.Available &= NEW ItemQueue
  SELF.Selected &= NEW ItemQueue


EditMultiSelectClass.Kill PROCEDURE
  CODE

  PARENT.Kill
  DISPOSE(SELF.Available)
  DISPOSE(SELF.Selected)


EditMultiSelectClass.TakeAction PROCEDURE(BYTE Action, <STRING Item>, LONG Pos1=0, LONG Pos2=0)
  CODE


EditMultiSelectClass.AddValue PROCEDURE(STRING Value, BYTE Marked=0)
  CODE

  IF Marked
    SELF.Selected.Item = Value
    SELF.Selected.Mark = 0
    ADD(SELF.Selected)
  ELSE
    SELF.Available.Item = Value
    SELF.Available.Mark = 0
    ADD(SELF.Available)
  END


EditMultiSelectClass.Reset PROCEDURE
  CODE

  FREE(SELF.Selected)
  FREE(SELF.Available)


EditMultiSelectClass.CreateControl PROCEDURE
  CODE

  SELF.Feq = CREATE(0, CREATE:dropcombo)
  ASSERT(SELF.Feq)
  SELF.Feq{PROP:Drop} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis
  SELF.Feq{PROP:ReadOnly} = True
  SELF.Feq{PROP:Background} = SELF.ListBoxFeq{PROP:Background}


EditMultiSelectClass.TakeEvent PROCEDURE(UNSIGNED E)
MSWindow MSWindowClass
MSSelectedIndex LONG
  CODE

  CASE E
  OF EVENT:DroppingDown
    MSWindow.Init(SELF)
    OPEN(MultiWindow)
    0{PROP:Text} = SELF.Title
    ?Available{PROP:From} = SELF.Available.Item
    ?Available{PROP:Mark} = SELF.Available.Mark
    ?Selected{PROP:From} = SELF.Selected.Item
    ?Selected{PROP:Mark} = SELF.Selected.Mark

    IF SELF.ReadOnly
      DISABLE(?SelectSome)
      DISABLE(?SelectAll)
      DISABLE(?DeselectSome)
      DISABLE(?DeselectAll)
      DISABLE(?MoveUp)
      DISABLE(?MoveDown)
    END
    MSWindow.Run()

    CLOSE(MultiWindow)
    DISPLAY(SELF.Feq)
    IF MSWindow.Response=RequestCompleted THEN
       SELF.TakeCompletedInit(RECORDS(SELF.Selected))
       LOOP MSSelectedIndex=1 TO RECORDS(SELF.Selected)
            GET(SELF.Selected,MSSelectedIndex)
            SELF.TakeCompletedProcess(MSSelectedIndex,SELF.Selected.Item,SELF.Selected.Mark)
       END
    END
    RETURN CHOOSE(MSWindow.Response=RequestCompleted, EditAction:Ignore, EditAction:None)
  ELSE
    RETURN PARENT.TakeEvent(E)
  END

EditMultiSelectClass.TakeCompletedInit       PROCEDURE(LONG pSelectedRecords)
  CODE
EditMultiSelectClass.TakeCompletedProcess    PROCEDURE(LONG pSelectedRecord,STRING Value,BYTE Mark)
  CODE

GetColorText PROCEDURE(LONG Color)
Red    BYTE,AUTO
Green  BYTE,AUTO
Blue   BYTE,AUTO
  CODE

  IF ~BAND(Color, 080000000H) AND ((Color>0ffffffH) OR (Color<-1)) THEN Color = 0 .

  IF ~ColorQInitialized
    ColorQInitialized = True
    InitializeColors
  END

  ColorMap.Color = Color
  GET(ColorMap, +ColorMap.Color)
  IF ERRORCODE()
    Red = BAND(Color, 0ffH)
    Green = BSHIFT(BAND(Color, 0ff00H), -8)
    Blue = BSHIFT(BAND(Color, 0ff0000H), -16)

    RETURN 'R:'&Red&', G:'&Green&', B:'&Blue
  ELSE
    RETURN ColorMap.Text
  END


GetColorValue PROCEDURE(STRING Str)
I      LONG,AUTO
Base   LONG,AUTO
BaseC  STRING(1),AUTO
C      STRING(1),AUTO
RGB    LONG,DIM(3)
Pos    LONG
Result LONG,AUTO
  CODE

  IF ~ColorQInitialized
    ColorQInitialized = True
    InitializeColors
  END

  ColorMap.TextKey = UPPER(str)
  GET(ColorMap, +ColorMap.TextKey)
  IF ~ERRORCODE() THEN RETURN ColorMap.Color .

  LOOP I=1 TO LEN(Str)
    C = UPPER(Str[I])
    CASE C
    OF 'R'
      Pos = 1
    OF 'G'
      Pos = 2
    OF 'B'
      Pos = 3
    OF ','
      Pos += 1
    OF ':'
    OROF '='
    OROF ' '
    ELSE
      IF NUMERIC(C)
        IF Pos<1 OR Pos>3 THEN RETURN INVALID_COLOR .
        RGB[Pos] = RGB[Pos]*10+C
        IF RGB[Pos]>255 THEN RGB[Pos] = 255 .
      ELSE
        BaseC = Str[1:(LEN(Str))]
        CASE BaseC
        OF 'H'
          Base = 16
        OF 'O'
          Base = 8
        OF 'B'
          Base = 2
        ELSE
          IF ~NUMERIC(BaseC) THEN RETURN INVALID_COLOR .
          Base = 10
        END
        IF Base<>10 THEN Str = Str[1:(LEN(Str)-1)] .

        IF ConvertBase(Str, Result, Base)
          RETURN Result
        ELSE
          RETURN INVALID_COLOR
        END
      END
    END
  END

  RETURN BOR(BOR(RGB[1], BSHIFT(RGB[2], 8)), BSHIFT(RGB[3], 16))


ConvertBase PROCEDURE(STRING Value, *LONG Result, LONG Base=16)
B      LONG,AUTO
Digit  STRING(1),AUTO
Index  LONG,AUTO
Val    LONG,AUTO
Top    LONG,AUTO
Neg    BYTE
L      LONG,AUTO
ValA   LONG(0),STATIC

  CODE
  IF ~ValA THEN ValA = VAL('A').
  IF ~INRANGE(Base, 1, 36)
    RETURN False
  ELSIF Base<10
    Top = VAL('0')+Base-1
  ELSE
    Top = ValA+Base-11
  END

  B = 0
  Result = 0

  L = LEN(Value)
  IF ~L THEN RETURN False .

  IF Value[1]='-' THEN Neg = True .
  LOOP Index=LEN(Value) TO 1 BY -1
    Digit = UPPER(Value[Index])
    IF VAL(Digit)>Top THEN RETURN False .
    Val = CHOOSE(NUMERIC(Digit) = True, Digit, VAL(Digit)-ValA+10)
    Result += Val * Base^B
    B += 1
  END

  IF Neg THEN Result = -Result .

  RETURN True


InitializeColors PROCEDURE
Cnst ConstantClass
  CODE

  Cnst.Init(Term:EndGroup)
  Cnst.AddItem(ConstType:Long, ColorMap.Color)
  Cnst.AddItem(ConstType:PString, ColorMap.Text)
  Cnst.Set(ColorMapGroup)
  LOOP WHILE Cnst.Next()=Level:Benign
    ColorMap.TextKey = UPPER(ColorMap.Text)
    ADD(ColorMap, +ColorMap.Color)
  END
  Cnst.Kill


!**********************************************************************
! EIP Manager Class
! This is the engine for the Edit in place functionality
! Fullfills most of old BrowseClass.AskRecord functionality
! Functions as (and can be overridden as) window manager
!**********************************************************************
EIPManager.AddControl PROCEDURE(<EditClass EC>,UNSIGNED Id,BYTE Free)
  CODE
    SELF.EQ.Control &= EC
    SELF.EQ.Field = Id
    SELF.EQ.FreeUp = Free
    ADD(SELF.EQ, +SELF.EQ.Field)
    ASSERT(~ERRORCODE())

EIPManager.Kill PROCEDURE
I UNSIGNED,AUTO
  CODE
  LOOP I = 1 TO RECORDS(SELF.EQ)
    GET(SELF.EQ,I)
    IF SELF.EQ.Control &= NULL
      SELF.ListControl{PROPLIST:textcolor,SELF.EQ.Field} = COLOR:None
    ELSE
      SELF.EQ.Control.Kill
    END
  END
  SELF.ListControl{PROP:Alrt,MouseLeft2Index} = MouseLeft2
  IF SELF.MouseLeftIndex
     SELF.ListControl{PROP:Alrt,SELF.MouseLeftIndex} = MouseLeft
  END
  IF SELF.Repost
    POST(SELF.Repost,SELF.RepostField)
    SELF.Repost = 0
  END
  RETURN PARENT.Kill()

EIPManager.Run PROCEDURE(BYTE Req)
I BYTE,AUTO
  CODE
  SELF.MouseLeftIndex = 0
  LOOP I=1 to 254
       IF SELF.ListControl{PROP:Alrt,I} = MouseLeft
          SELF.MouseLeftIndex = I
          SELF.ListControl{PROP:Alrt,I} = 0
          BREAK
       END
  END
  SELF.Req = Req
  RETURN SELF.Run()

EIPManager.Init PROCEDURE
  CODE
  IF SELF.Column = 0 THEN SELF.Column = 1.
  SELF.LastColumn = 0
  SELF.Repost = 0
  SELF.RepostField = 0
  ASSERT(~SELF.EQ &= NULL)
  SELF.EQ.Field = 1

  SELF.InitControls
  SELF.ResetColumn
  RETURN Level:Benign

EIPManager.InitControls PROCEDURE
  CODE
  ASSERT(~SELF.Fields &= NULL)
  LOOP WHILE SELF.ListControl{PROPLIST:Exists,SELF.EQ.Field}
    GET(SELF.EQ,SELF.EQ.Field)
    IF ERRORCODE()
      SELF.EQ.Control &= NEW EditEntryClass
      SELF.AddControl(SELF.EQ.Control,SELF.EQ.Field,1)
    END
    GET(SELF.Fields.List,SELF.EQ.Field)
    ASSERT(~ERRORCODE())
    IF ~SELF.EQ.Control &= NULL
      SELF.EQ.Control.Init(SELF.EQ.Field,SELF.ListControl,SELF.Fields.List.Right)
    ELSE
      SELF.ListControl{PROPLIST:textcolor,SELF.EQ.Field} = COLOR:GRAYTEXT
    END
    SELF.EQ.Field += 1
  END

EIPManager.ResetColumn PROCEDURE
  CODE
  SETKEYCODE(0)
  SELF.Next
  IF SELF.Column <> SELF.LastColumn
    SELF.ListControl{PROP:Edit,SELF.EQ.Field} = SELF.EQ.Control.Feq
    SELECT(SELF.EQ.Control.Feq)
    SELF.LastColumn = SELF.Column
  END

EIPManager.Next PROCEDURE
Scanned BYTE
LastCol UNSIGNED,AUTO
  CODE

  GET(SELF.EQ,RECORDS(SELF.EQ))
? ASSERT(~ERRORCODE())
  LastCol=SELF.EQ.Field

  LOOP
    CLEAR(SELF.EQ)
    SELF.EQ.Field = SELF.Column
    GET(SELF.EQ,SELF.EQ.Field)
    IF ~ERRORCODE() AND SELF.GetEdit()
      BREAK
    END
    IF SELF.SeekForward
      IF SELF.Column >= LastCol
        ASSERT(~Scanned)
        SELF.SeekForward = 0
        Scanned = 1
      ELSE
        SELF.Column += 1
      END
    ELSE
      IF SELF.Column <= 1
        SELF.SeekForward = 1
        ASSERT(~Scanned)
        Scanned = 1
      ELSE
        SELF.Column -= 1
      END
    END
  END
  SELF.SeekForward = 0

EIPManager.GetEdit PROCEDURE

  CODE
  IF SELF.EQ.Control &= NULL OR SELF.ListControl{PROPLIST:Width,SELF.Column}=0
     RETURN False
  ELSE
     RETURN True
  END

EIPManager.TakeEvent PROCEDURE
RV BYTE,AUTO
  CODE
  CASE EVENT()                    ! A window specific event
  OF EVENT:Size OROF EVENT:Iconize OROF EVENT:Maximize
    RETURN Level:Notify
  OF EVENT:CloseDown OROF EVENT:CloseWindow OROF EVENT:Sized
    SELF.TakeFocusLoss
    SELF.Repost = EVENT()
    RETURN Level:Fatal
  ELSE
    SELF.Again = 1
    RV = PARENT.TakeEvent()
    RETURN CHOOSE(RV=Level:Benign,CHOOSE(SELF.Again<>0,Level:Benign,Level:Fatal),RV)
  END

EIPManager.TakeFieldEvent        PROCEDURE
I UNSIGNED(1)
  CODE
  IF FIELD() = SELF.ListControl THEN RETURN Level:Benign .
  LOOP I = 1 TO RECORDS(SELF.EQ)+1
   ! Optimised to pick up subsequent events from same field
    IF ~SELF.EQ.Control &= NULL AND SELF.EQ.Control.Feq = FIELD()
      SELF.TakeAction(SELF.EQ.Control.TakeEvent(EVENT()))
      RETURN Level:Benign
    END
    GET(SELF.EQ,I)
  END
  ! Not a known field
  IF ?{PROP:Type} <> CREATE:Button OR EVENT() <> EVENT:Selected ! Wait to post accepted for button
    SELF.Repost = EVENT()
    SELF.RepostField = FIELD()
    SELF.TakeFocusLoss
  END
  RETURN Level:Benign

EIPManager.TakeNewSelection PROCEDURE   ! Must be overridden to handle out-of-row clicks
  CODE
  IF FIELD() = SELF.ListControl AND KEYCODE() = MouseLeft       ! An in-row mouse click
    SELF.ClearColumn
    SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
    SELF.ResetColumn
  END
  RETURN Level:Benign

EIPManager.TakeFocusLoss PROCEDURE
  CODE
  CASE CHOOSE(SELF.FocusLoss &=NULL,EIPAction:Default,BAND(SELF.FocusLoss,EIPAction:Save))
  OF EIPAction:Always OROF EIPAction:Default
    SELF.TakeCompleted(Button:Yes)
  OF EIPAction:Never
    SELF.TakeCompleted(Button:No)
  ELSE
    SELF.TakeCompleted(0)
  END

EIPManager.TakeAcceptAll         PROCEDURE()
I   UNSIGNED,AUTO
  CODE
  I = 1
  LOOP WHILE SELF.ListControl{PROPLIST:Exists,I}
       GET(SELF.EQ,I)
       IF NOT ERRORCODE()
          GET(SELF.Fields.List,I)
          IF NOT SELF.EQ.Control &= NULL
             UPDATE(SELF.EQ.Control.FEQ)
             IF SELF.EQ.Control.Req
                IF NOT SELF.Fields.List.Right
                   SELF.ClearColumn
                   SELF.Column=I
                   SELF.Again=1
                   SELF.ResetColumn
                   RETURN False
                END
             END
             IF SELF.EQ.Control.TakeAccepted(EditAction:Forward)=EditAction:Cancel
                SELF.ClearColumn
                SELF.Column=I
                SELF.Again=1
                SELF.ResetColumn
                RETURN False
             END
          END
       END
       I += 1
  END
  RETURN True

EIPManager.TakeCompleted PROCEDURE(BYTE Force)
  CODE
  IF (Force = Button:Yes OR Force = 0)
     IF NOT SELF.TakeAcceptAll()
        RETURN
     END
  END
  SELF.Column = 1
  IF SELF.Again
     SELF.ResetColumn
  END

EIPManager.ClearColumn PROCEDURE
  CODE
  IF SELF.LastColumn
    SELF.ListControl{PROP:Edit,SELF.Column} = 0
    SELF.LastColumn = 0
  END

EIPManager.TakeAction PROCEDURE(UNSIGNED Action)
Rem UNSIGNED,AUTO
SaveCol UNSIGNED,AUTO
  CODE                                   
  IF Action AND Action<>EditAction:Cancel
     Action = SELF.EQ.Control.TakeAccepted(Action)
  END
  CASE Action
  OF EditAction:Forward
    SELF.ClearColumn
    Rem = SELF.Column
    SELF.Column += 1
    SELF.SeekForward = 1
    SELF.Next
    IF Rem <> SELF.Column
      SELF.ResetColumn
    ELSE
      CASE CHOOSE(SELF.Tab &= NULL,EIPAction:Always,BAND(SELF.Tab,EIPAction:Save))
      OF EIPAction:Always
        SELF.TakeCompleted(BUTTON:Yes)
      OF EIPAction:Never
        SELF.TakeCompleted(BUTTON:No)
      ELSE
        SELF.TakeCompleted(0)
      END
      IF ~SELF.Tab &= NULL AND BAND(SELF.Tab,EIPAction:Remain) AND ~SELF.Again
        SELF.VCRRequest = VCR:Forward
      END
    END
  OF EditAction:Backward
    IF SELF.Column > 1
      SELF.ClearColumn
      Rem = SELF.Column
      SELF.Column -= 1
      SELF.ResetColumn
    END
  OF EditAction:Next OROF EditAction:Previous
    SaveCol = SELF.Column
    CASE CHOOSE(SELF.Arrow &= NULL,EIPAction:Default,BAND(SELF.Arrow,EIPAction:Save))
    OF EIPAction:Always OROF EIPAction:Default
      SELF.TakeCompleted(BUTTON:Yes)
    OF EIPAction:Never
      SELF.TakeCompleted(BUTTON:No)
    ELSE
      SELF.TakeCompleted(0)
    END
    IF ~SELF.Arrow &= NULL AND BAND(SELF.Arrow,EIPAction:Remain) AND ~SELF.Again
      SELF.VCRRequest = CHOOSE(Action = EditAction:Next,VCR:Forward,VCR:Backward)
    END
    IF ~SELF.Arrow &= NULL AND BAND(SELF.Arrow,EIPAction:RetainColumn) AND ~SELF.Again
      SELF.Column = SaveCol
    END
  OF EditAction:Complete
    CASE CHOOSE(SELF.Enter &= NULL, EIPAction:Default,BAND(SELF.Enter,EIPAction:Save))
    OF EIPAction:Always OROF EIPAction:Default
      SELF.TakeCompleted(BUTTON:Yes)
    OF EIPAction:Never
      SELF.TakeCompleted(BUTTON:No)
    ELSE
      SELF.TakeCompleted(0)
    END
    IF ~SELF.Enter &= NULL AND BAND(SELF.Enter,EIPAction:Remain) AND ~SELF.Again
      SELF.VCRRequest = VCR:Forward
    END
  OF EditAction:Cancel
    SELF.TakeCompleted(Button:No)
  END

