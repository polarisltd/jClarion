  MEMBER()

  MAP.


  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABBROWSE.INC'),ONCE

ComponentList QUEUE,TYPE
WC &WindowComponent
           END

ButtonList QUEUE,TYPE
Control SIGNED
Action  BYTE
           END

HistoryList QUEUE,TYPE
FRecord     &GROUP
SRecord     &GROUP
Control     SIGNED
FieldNo     SIGNED
            END

FileList QUEUE,TYPE
Manager &FileManager
Saved   USHORT
  END

WindowManager.AddHistoryFile PROCEDURE(*GROUP FB,*GROUP SB)
  CODE
  IF SELF.History &= NULL
    SELF.History &= NEW HistoryList
  END
  SELF.History.FRecord &= FB
  SELF.History.SRecord &= SB

WindowManager.AddHistoryField PROCEDURE(SIGNED Control,SIGNED Field)
  CODE
  SELF.History.Control = Control
  SELF.History.FieldNo   = Field
  ADD(SELF.History,SELF.History.Control)

WindowManager.AddItem        PROCEDURE(BrowseClass BC)
  CODE
    SELF.AddItem(BC.WindowComponent)
    IF SELF.Request = SelectRecord
      BC.Selecting = 1
    END

WindowManager.AddItem       PROCEDURE(TranslatorClass T)

  CODE
    SELF.Translator &= T


WindowManager.AddItem       PROCEDURE(ToolbarClass TC)
  CODE
    SELF.Toolbar &= TC
    TC.Init

WindowManager.AddItem       PROCEDURE(ToolbarUpdateClass TF)
  CODE
    ASSERT(~SELF.Toolbar&=NULL)
    IF SELF.HistoryKey
      TF.History = 1
    END
    TF.Request = SELF.OriginalRequest
    TF.DisplayButtons
    SELF.Toolbar.AddTarget(TF,-1)
    SELF.ToolBar.SetTarget(-1)

WindowManager.AddItem       PROCEDURE(WindowResizeClass RC)
  CODE
    SELF.Resize &= RC

WindowManager.AddItem       PROCEDURE(SIGNED Control, BYTE Action)
  CODE
  ASSERT(~SELF.Buttons&=NULL)
  SELF.Buttons.Control = Control
  SELF.Buttons.Action = Action
  ADD(SELF.Buttons)

WindowManager.AddItem PROCEDURE(WindowComponent WC)
  CODE
    ASSERT(~SELF.CL&=NULL)
    SELF.CL.WC &= WC
    ADD(SELF.CL)
    ASSERT(~ERRORCODE())

WindowManager.AddUpdateFile PROCEDURE(FileManager FM)
  CODE
  IF SELF.Files &= NULL
    SELF.Files   &= NEW FileList
  END
  CLEAR(SELF.Files)
  SELF.Files.Manager &= FM
  ADD(SELF.Files)

WindowManager.RemoveItem PROCEDURE(WindowComponent WC)

i UNSIGNED, AUTO

  CODE
  LOOP I = 1 TO RECORDS(SELF.CL)
    GET(SELF.CL, I)
    IF SELF.CL.WC &= WC
      DELETE(SELF.CL)
    END
  END

WindowManager.ResetBuffers PROCEDURE(BYTE Force)
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.CL)
      GET(SELF.CL,I)
      SELF.CL.WC.Reset(Force)
    END

WindowManager.Reset          PROCEDURE(BYTE Force)
I UNSIGNED,AUTO
  CODE
    IF 0{PROP:AcceptAll} THEN RETURN .
    Force += SELF.ForcedReset
    SELF.ForcedReset = 0
    SELF.ResetBuffers(Force)
    LOOP I = 1 TO RECORDS(SELF.CL)
      GET(SELF.CL,I)
      SELF.CL.WC.UpdateWindow()
    END
    DISPLAY()

WindowManager.Update         PROCEDURE
I USHORT,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.CL)
      GET(SELF.CL,I)
      SELF.CL.WC.Update
    END

WindowManager.Open           PROCEDURE
  CODE
    IF ~SELF.Translator&=NULL
      SELF.Translator.TranslateWindow
    END
    SELF.Reset
    SELF.Inited = BOR(SELF.Inited,1)

WindowManager.TakeWindowEvent      PROCEDURE
RVal BYTE(Level:Benign)
  CODE
  CASE EVENT()
  OF EVENT:OpenWindow
    IF ~BAND(SELF.Inited,1)
      SELF.Open
    END
    IF SELF.FirstField
      SELECT(SELF.FirstField)
    END
  OF EVENT:LoseFocus
    IF SELF.ResetOnGainFocus
      SELF.ForcedReset = 1
    END
  OF EVENT:GainFocus
    IF BAND(SELF.Inited,1)
      SELF.Reset
    ELSE
      SELF.Open
    END
  OF EVENT:Sized
    IF BAND(SELF.Inited,2)
      SELF.Reset
    ELSE
      SELF.Inited = BOR(SELF.Inited,2)
    END
  OF EVENT:Completed
    RVal = SELF.TakeCompleted()
  OF EVENT:CloseWindow OROF EVENT:CloseDown
    RVal = SELF.TakeCloseEvent()
  END
  RETURN RVal

WindowManager.TakeFieldEvent PROCEDURE
  CODE
  RETURN Level:Benign

WindowManager.TakeNewSelection PROCEDURE
  CODE
  IF ?{PROP:Type} = CREATE:Sheet
    SELF.Reset
    IF SELF.AutoToolbar AND ~SELF.Toolbar&=NULL
      SELF.Toolbar.SetTarget
    END
  END
  RETURN Level:Benign

WindowManager.TakeAccepted PROCEDURE
I LONG,AUTO
A SIGNED,AUTO
  CODE
  A = ACCEPTED()
  IF ~SELF.Toolbar &= NULL
    SELF.Toolbar.TakeEvent(SELF.VCRRequest,SELF)
    IF A = Toolbar:History
      SELF.RestoreField(FOCUS())
    END
  END
  LOOP I = 1 TO RECORDS(SELF.Buttons)
    GET(SELF.Buttons,I)
    IF SELF.Buttons.Control = A
      SELF.SetResponse(SELF.Buttons.Action)
      RETURN Level:Notify
    END
  END
  IF SELF.OkControl AND SELF.OkControl = A
    SELF.PostCompleted
  END
  RETURN Level:Benign

WindowManager.PostCompleted PROCEDURE
  CODE
    IF SELF.OriginalRequest = ChangeRecord OR SELF.OriginalRequest = InsertRecord
      SELECT()
    ELSE
      POST(EVENT:Completed)
    END

WindowManager.TakeSelected PROCEDURE
  CODE
    RETURN Level:Benign

WindowManager.TakeCloseEvent PROCEDURE
  CODE
  IF SELF.Response <> RequestCompleted AND ~SELF.Primary &= NULL
    IF SELF.CancelAction <> Cancel:Cancel AND ( SELF.Request = InsertRecord OR SELF.Request = ChangeRecord )
      IF ~SELF.Primary.Me.EqualBuffer(SELF.Saved)
        IF BAND(SELF.CancelAction,Cancel:Save)
          IF BAND(SELF.CancelAction,Cancel:Query)
            CASE SELF.Errors.Message(Msg:SaveRecord,Button:Yes+Button:No+Button:Cancel,Button:Cancel)
            OF Button:Yes
              POST(Event:Accepted,SELF.OKControl)
              RETURN Level:Notify
            OF BUTTON:Cancel
              SELECT(SELF.FirstField)
              RETURN Level:Notify
            END
          ELSE
            POST(Event:Accepted,SELF.OKControl)
            RETURN Level:Notify
          END
        ELSE
          IF SELF.Errors.Throw(Msg:ConfirmCancel) = Level:Cancel
            SELECT(SELF.FirstField)
            RETURN Level:Notify
          END
        END
      END
    END
    IF SELF.OriginalRequest = InsertRecord AND SELF.Response = RequestCancelled
      IF SELF.Primary.CancelAutoInc() THEN
        SELECT(SELF.FirstField)
        RETURN Level:Notify
      END
    END
    IF SELF.LastInsertedPosition
      SELF.Response = RequestCompleted
      SELF.Primary.Me.TryReget(SELF.LastInsertedPosition)
    END
  END
  RETURN Level:Benign


WindowManager.SaveHistory PROCEDURE
I   USHORT,AUTO
Rem &GROUP
  CODE
    IF ~SELF.History &= NULL
      LOOP I = 1 TO RECORDS(SELF.History)
        GET(SELF.History,I)
        IF ~SELF.History.FRecord &= Rem
          SELF.History.SRecord = SELF.History.FRecord
          Rem &= SELF.History.FRecord
        END
      END
    END

WindowManager.TakeCompleted PROCEDURE
  CODE
  SELF.SaveHistory
  CASE SELF.Request
  OF InsertRecord
    DO InsertAction
  OF ChangeRecord
    DO ChangeAction
  OF DeleteRecord
    DO DeleteAction
  END
  RETURN Level:Benign

InsertAction ROUTINE
  DATA
I USHORT,AUTO
  CODE
  IF SELF.Primary.Me.Insert() = Level:Benign
    CASE SELF.InsertAction
    OF Insert:Caller
      SELF.SetResponse(RequestCompleted)
      RETURN Level:Benign
    OF Insert:Query
      IF SELF.Errors.Throw(Msg:AddAnother) <> Level:Benign
        SELF.SetResponse(RequestCompleted)
        RETURN Level:Benign
      END
    OROF Insert:Batch
      SELF.LastInsertedPosition = SELF.Primary.Me.Position()
      IF ~SELF.Files&=NULL
        LOOP I = 1 TO RECORDS(SELF.Files)
          GET(SELF.Files,I)
          SELF.Files.Manager.RestoreBuffer(SELF.Files.Saved)
          SELF.Files.Saved = SELF.Files.Manager.SaveBuffer()
          PUT(SELF.Files)
        END
      END
      SELF.Primary.Me.RestoreBuffer(SELF.Saved)
      SELF.Primary.Me.UseFile(UseType:Returns)
      IF SELF.Primary.Me.PrimeAutoInc()
        POST(EVENT:CloseWindow)
      ELSE
        SELF.PrimeFields
        SELF.Response = RequestCancelled
      END
      SELF.Saved = SELF.Primary.Me.SaveBuffer()
      DISPLAY
      SELECT(SELF.FirstField)
      RETURN Level:Notify
    END
  ELSE
    SELECT(SELF.FirstField)
    RETURN Level:Notify
  END
ChangeAction ROUTINE
  DATA
UnChanged BYTE,AUTO
Error   BYTE,AUTO
  CODE
  LOOP
    SELF.Response = RequestCancelled
    SETCURSOR(Cursor:Wait)
    UnChanged = SELF.Primary.Me.EqualBuffer(SELF.Saved)
    IF UnChanged
      Error = 0
    ELSE
      Error = SELF.Primary.Update(CHOOSE(SELF.HistoryKey))
    END
    SETCURSOR()
    IF Error
      IF Error = Level:User
        CASE SELF.Errors.Message(Msg:RetrySave,Button:Yes+Button:No+Button:Cancel,Button:Cancel)
        OF Button:Yes
          CYCLE
        OF Button:No
          POST(Event:CloseWindow)
          BREAK
        END
      END
      DISPLAY
      SELECT(SELF.FirstField)
    ELSE
      IF ~UnChanged OR ~SELF.Toolbar &= NULL AND SELF.VCRRequest = VCR:None
        SELF.Response = RequestCompleted
      END
      POST(Event:CloseWindow)
    END
  UNTIL 1

DeleteAction ROUTINE
  LOOP
    SELF.Response = RequestCancelled
    SETCURSOR(Cursor:Wait)
    IF SELF.Primary.Delete(CHOOSE(SELF.DeleteAction=Delete:Warn))
      SETCURSOR()
      CASE SELF.Errors.Message(Msg:RetryDelete,Button:Yes+Button:No+Button:Cancel,Button:Cancel)
      OF Button:Yes
        CYCLE
      OF Button:No
        POST(Event:CloseWindow)
        BREAK
      OF Button:Cancel
        DISPLAY
        SELECT(SELF.FirstField)
        BREAK
      END
    ELSE
      SETCURSOR()
      SELF.SetResponse(RequestCompleted)
      BREAK
    END
  UNTIL 0

WindowManager.TakeRejected PROCEDURE
  CODE
    BEEP
    DISPLAY(?)
    SELECT(?)
    RETURN Level:Benign

WindowManager.TakeEvent PROCEDURE
RVal BYTE(Level:Benign)
I    USHORT,AUTO
  CODE
    IF ~FIELD()
      RVal = SELF.TakeWindowEvent()
      IF RVal THEN RETURN RVal.
    END
    CASE EVENT()
    OF EVENT:Accepted
      RVal = SELF.TakeAccepted()
    OF EVENT:Rejected
      RVal = SELF.TakeRejected()
    OF EVENT:Selected
      RVal = SELF.TakeSelected()
    OF EVENT:NewSelection
      RVal = SELF.TakeNewSelection()
    OF EVENT:AlertKey
      IF SELF.HistoryKey AND KEYCODE() = SELF.HistoryKey
        SELF.RestoreField(FOCUS())
      END
    END
    IF RVal THEN RETURN RVal.
    IF FIELD()
      RVal = SELF.TakeFieldEvent()
      IF RVal THEN RETURN RVal.
    END
    LOOP I = 1 TO RECORDS(SELF.CL)
      GET(SELF.CL,I)
      RVal = SELF.CL.WC.TakeEvent()
      IF RVal THEN RETURN RVal.
    END
    IF SELF.AutoRefresh
      LOOP I = 1 TO RECORDS(SELF.CL)
        GET(SELF.CL,I)
        IF SELF.CL.WC.ResetRequired()
          SELF.Reset
          BREAK                   ! One reset per cycle is quite enough...
        END
      END
    END
    RETURN RVal

WindowManager.Init PROCEDURE
  CODE
  SELF.OriginalRequest = SELF.Request
  SELF.CL &= NEW ComponentList     ! Kill method assumes this will always happen in init
  SELF.Buttons &= NEW ButtonList
  PUSHBIND(1)
  IF KEYCODE() = MouseRight OR KEYCODE() = MouseRightUp
    SETKEYCODE(0)
  END
  SELF.InsertAction = Insert:Caller
  SELF.DeleteAction = Delete:Warn
  SELF.ChangeAction = 1
  SELF.CancelAction = Cancel:Save+Cancel:Query
  SELF.AutoToolbar = 1
  SELF.AutoRefresh = 1
  RETURN Level:Benign

WindowManager.Ask PROCEDURE
  CODE
  IF SELF.Dead THEN RETURN .
  CLEAR(SELF.LastInsertedPosition)
  ACCEPT
    CASE SELF.TakeEvent()
    OF Level:Fatal
      BREAK
    OF Level:Notify
      CYCLE     ! Not as dopey at it looks, it is for 'short-stopping' certain events
    END
  END

WindowManager.Kill PROCEDURE
cur                     &WindowComponent,auto
I                       unsigned,AUTO
  CODE
    IF SELF.Dead OR SELF.Cl &= NULL THEN RETURN Level:Notify.

    ! Cope with elements being removed from the list when Kill is called...
    LOOP WHILE (RECORDS(SELF.Cl) <> 0)
      GET(SELF.Cl,1)
      cur &= SELF.Cl.WC
      DELETE(SELF.Cl)
      cur.Kill()
    END
    DISPOSE(SELF.CL)

    DISPOSE(SELF.Buttons)
    DISPOSE(SELF.History)
    IF ~SELF.Files&=NULL
      LOOP I = 1 TO RECORDS(SELF.Files)
        GET(SELF.Files,I)
        SELF.Files.Manager.RestoreBuffer(SELF.Files.Saved,0)
      END
    END
    DISPOSE(SELF.Files)
    IF ~SELF.Primary&=NULL
      SELF.Primary.Me.RestoreBuffer(SELF.Saved,0)
    END
    IF ~SELF.Toolbar&=NULL
      SELF.Toolbar.Kill
    END
    IF ~SELF.Resize&=NULL
      SELF.Resize.Kill
    END
    SELF.Dead = 1
    POPBIND
    RETURN Level:Benign

WindowManager.SetResponse PROCEDURE(BYTE Response)
  CODE
    SELF.Response = Response
    POST(EVENT:CloseWindow)
    IF Response = RequestCancelled AND ~SELF.Toolbar &= NULL
      SELF.VCRRequest = VCR:None
    END

WindowManager.SetAlerts PROCEDURE
I SIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Cl)
      GET(SELF.CL,I)
      SELF.CL.WC.SetAlerts
    END
    IF ~SELF.History &= NULL
      LOOP I = 1 TO RECORDS(SELF.History)
        GET(SELF.History,I)
        SELF.History.Control{PROP:Alrt,255} = SELF.HistoryKey
      END
    END

WindowManager.RestoreField PROCEDURE(SIGNED Control)
Left ANY
  CODE
    IF ~SELF.History &= NULL
      SELF.History.Control = Control
      GET(SELF.History,SELF.History.Control)
      IF ~ERRORCODE()
        Left &= WHAT(SELF.History.FRecord,SELF.History.FieldNo)
        Left = WHAT(SELF.History.SRecord,SELF.History.FieldNo)
        DISPLAY(SELF.History.Control)
      END
    END

WindowManager.PrimeUpdate PROCEDURE
I USHORT,AUTO
RVal BYTE(Level:Benign)
  CODE
  ASSERT(~SELF.Primary&=NULL)
  SELF.Primary.Me.UseFile(UseType:Returns)
  SELF.Primary.Save
  IF ~SELF.Files&=NULL
    LOOP I = 1 TO RECORDS(SELF.Files)
      GET(SELF.Files,I)
      SELF.Files.Saved = SELF.Files.Manager.SaveBuffer()
      PUT(SELF.Files)
    END
  END
  CASE SELF.Request
  OF InsertRecord
    IF SELF.InsertAction
      SELF.Response = RequestCompleted
      SELF.PrimeFields
      IF SELF.Response = RequestCancelled
        RVal = Level:Fatal
      ELSE
        SELF.Response = RequestCancelled
      END
    END
  OF DeleteRecord
    CASE SELF.DeleteAction
    OF Delete:Warn OROF Delete:Auto
      SELF.Response = SELF.Primary.Delete(CHOOSE(SELF.DeleteAction=Delete:Warn))
      SELF.Response = CHOOSE(SELF.Response=Level:Benign,RequestCompleted,RequestCancelled)
      RVal = Level:Fatal
    END
  END
  SELF.Saved = SELF.Primary.Me.SaveBuffer()
  RETURN RVal

WindowManager.PrimeFields PROCEDURE
  CODE

WindowManager.Run PROCEDURE
  CODE
  IF ~SELF.Init()
    SELF.Ask
  END
  SELF.Kill
  RETURN CHOOSE(SELF.Response=0,RequestCancelled,SELF.Response)

WindowManager.Run PROCEDURE(USHORT Number,BYTE Request)
  CODE
    RETURN RequestCancelled

ImageManager.AddItem PROCEDURE(SIGNED Ctrl, *? Fld)
  CODE
  SELF.Control = Ctrl
  SELF.Fld &= Fld

ImageManager.AddItem PROCEDURE(SIGNED Ctrl, BLOB Fld)
  CODE
  SELF.Control = Ctrl
  SELF.Blb &= Fld

ImageManager.RecordProcessor.TakeRecord PROCEDURE
  CODE
  IF SELF.Blb &= NULL
    SELF.Control{PROP:Text} = SELF.Fld
  ELSE
    SELF.Control{PROP:ImageBits} = SELF.Blb{PROP:Handle}
  END
  RETURN Level:Benign

ImageManager.RecordProcessor.TakeClose PROCEDURE
  CODE
  RETURN Level:Benign
