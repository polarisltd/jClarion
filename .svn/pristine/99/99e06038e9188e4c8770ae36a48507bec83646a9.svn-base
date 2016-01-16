

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abpopup.inc'),ONCE
   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB013.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COOKB017.INC'),ONCE        !Req'd for module callout resolution
                     END


Updateingredients PROCEDURE                           !Generated from procedure template - Window

CurrentTab           STRING(80)
ActionMessage        CSTRING(40)
BRW2::View:Browse    VIEW(rimap)
                       PROJECT(RIM:id)
                       PROJECT(RIM:recipe_id)
                       PROJECT(RIM:ingrediant_id)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?Browse:2
RIM:id                 LIKE(RIM:id)                   !List box control field - type derived from field
RIM:recipe_id          LIKE(RIM:recipe_id)            !List box control field - type derived from field
RIM:ingrediant_id      LIKE(RIM:ingrediant_id)        !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::ING:Record  LIKE(ING:RECORD),STATIC
QuickWindow          WINDOW('Update the ingredients File'),AT(,,273,138),FONT('MS Sans Serif',8,,),IMM,HLP('Updateingredients'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,265,112),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('&id:'),AT(8,20),USE(?ING:id:Prompt)
                           STRING(@n11),AT(61,20,48,10),USE(ING:id),RIGHT(1)
                           PROMPT('&name:'),AT(8,34),USE(?ING:name:Prompt)
                           ENTRY(@s50),AT(61,34,204,10),USE(ING:name)
                           PROMPT('&shelflife:'),AT(8,48),USE(?ING:shelflife:Prompt)
                           ENTRY(@n6),AT(61,48,40,10),USE(ING:shelflife),RIGHT(1)
                           PROMPT('&cost:'),AT(8,62),USE(?ING:cost:Prompt)
                           ENTRY(@n10.2),AT(61,62,44,10),USE(ING:cost),DECIMAL(12)
                         END
                         TAB('rimap'),USE(?Tab:2)
                           LIST,AT(8,20,257,74),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('64R(2)|M~id~C(0)@n-14@64R(2)|M~recipe id~C(0)@n-14@64R(2)|M~ingrediant id~C(0)@n' &|
   '-14@'),FROM(Queue:Browse:2)
                           BUTTON('&Insert'),AT(122,98,45,14),USE(?Insert:3)
                           BUTTON('&Change'),AT(171,98,45,14),USE(?Change:3)
                           BUTTON('&Delete'),AT(220,98,45,14),USE(?Delete:3)
                         END
                       END
                       BUTTON('OK'),AT(126,120,45,14),USE(?OK),DEFAULT
                       BUTTON('Cancel'),AT(175,120,45,14),USE(?Cancel)
                       BUTTON('Help'),AT(224,120,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW2                 CLASS(BrowseClass)               !Browse using ?Browse:2
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW2::Sort0:Locator  StepLocatorClass                 !Default Locator
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
    ActionMessage = 'Adding a ingredients Record'
  OF ChangeRecord
    ActionMessage = 'Changing a ingredients Record'
  END
  QuickWindow{Prop:Text} = ActionMessage
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Updateingredients')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ING:id:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(ING:Record,History::ING:Record)
  SELF.AddHistoryField(?ING:id,1)
  SELF.AddHistoryField(?ING:name,2)
  SELF.AddHistoryField(?ING:shelflife,3)
  SELF.AddHistoryField(?ING:cost,4)
  SELF.AddUpdateFile(Access:ingredients)
  SELF.AddItem(?Cancel,RequestCancelled)
  Relate:ingredients.Open
  Relate:rimap.Open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ingredients
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
  BRW2.Init(?Browse:2,Queue:Browse:2.ViewPosition,BRW2::View:Browse,Queue:Browse:2,Relate:rimap,SELF)
  OPEN(QuickWindow)
!  SELF.setICON()
  SELF.Opened=True
  BRW2.Q &= Queue:Browse:2
  BRW2.RetainRow = 0
  BRW2.AddSortOrder(,RIM:ingrediantkey)
  BRW2.AddRange(RIM:ingrediant_id,Relate:rimap,Relate:ingredients)
  BRW2.AddLocator(BRW2::Sort0:Locator)
  BRW2::Sort0:Locator.Init(,RIM:id,1,BRW2)
  BRW2.AddField(RIM:id,BRW2.Q.RIM:id)
  BRW2.AddField(RIM:recipe_id,BRW2.Q.RIM:recipe_id)
  BRW2.AddField(RIM:ingrediant_id,BRW2.Q.RIM:ingrediant_id)
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)
  SELF.AddItem(Resizer)
  BRW2.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ingredients.Close
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


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  ELSE
    GlobalRequest = Request
    Updaterimap
    ReturnValue = GlobalResponse
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


BRW2.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults

