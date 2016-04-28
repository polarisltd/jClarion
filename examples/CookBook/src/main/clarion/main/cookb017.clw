

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB017.INC'),ONCE        !Local module procedure declarations
                     END


Updaterimap PROCEDURE                                 !Generated from procedure template - Window

CurrentTab           STRING(80)
ActionMessage        CSTRING(40)
History::RIM:Record  LIKE(RIM:RECORD),STATIC
QuickWindow          WINDOW('Update the rimap File'),AT(,,151,84),FONT('MS Sans Serif',8,,),IMM,HLP('Updaterimap'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,143,58),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('id:'),AT(8,20),USE(?RIM:id:Prompt)
                           ENTRY(@n-14),AT(68,20,64,10),USE(RIM:id),RIGHT(1)
                           PROMPT('recipe id:'),AT(8,34),USE(?RIM:recipe_id:Prompt)
                           ENTRY(@n-14),AT(68,34,64,10),USE(RIM:recipe_id),RIGHT(1)
                           PROMPT('ingrediant id:'),AT(8,48),USE(?RIM:ingrediant_id:Prompt)
                           ENTRY(@n-14),AT(68,48,64,10),USE(RIM:ingrediant_id),RIGHT(1)
                         END
                       END
                       BUTTON('OK'),AT(4,66,45,14),USE(?OK),DEFAULT
                       BUTTON('Cancel'),AT(53,66,45,14),USE(?Cancel)
                       BUTTON('Help'),AT(102,66,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a rimap Record'
  OF ChangeRecord
    ActionMessage = 'Changing a rimap Record'
  END
  QuickWindow{Prop:Text} = ActionMessage
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Updaterimap')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?RIM:id:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(RIM:Record,History::RIM:Record)
  SELF.AddHistoryField(?RIM:id,1)
  SELF.AddHistoryField(?RIM:recipe_id,2)
  SELF.AddHistoryField(?RIM:ingrediant_id,3)
  SELF.AddUpdateFile(Access:rimap)
  SELF.AddItem(?Cancel,RequestCancelled)
  Relate:rimap.Open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:rimap
  IF SELF.Request = ViewRecord
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = 0
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)
!  SELF.setICON()
  SELF.Opened=True
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)
  SELF.AddItem(Resizer)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:rimap.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord
        POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults

