

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abpopup.inc'),ONCE
   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB014.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COOKB017.INC'),ONCE        !Req'd for module callout resolution
                     END


Updaterecipe PROCEDURE                                !Generated from procedure template - Window

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
History::REC:Record  LIKE(REC:RECORD),STATIC
QuickWindow          WINDOW('Update the recipe File'),AT(,,358,140),FONT('MS Sans Serif',8,,),IMM,HLP('Updaterecipe'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,350,114),USE(?CurrentTab)
                         TAB('General'),USE(?Tab:1)
                           PROMPT('&id:'),AT(8,20),USE(?REC:id:Prompt)
                           STRING(@n11),AT(64,20,48,10),USE(REC:id),RIGHT(1)
                           PROMPT('&name:'),AT(8,34),USE(?REC:name:Prompt)
                           ENTRY(@s50),AT(64,34,204,10),USE(REC:name)
                           PROMPT('&type:'),AT(8,48),USE(?REC:type:Prompt)
                           ENTRY(@s30),AT(64,48,124,10),USE(REC:type)
                           PROMPT('&preparation:'),AT(8,62),USE(?REC:preparation:Prompt)
                           ENTRY(@s255),AT(64,62,286,10),USE(REC:preparation)
                           PROMPT('&cooking:'),AT(8,76),USE(?REC:cooking:Prompt)
                           ENTRY(@s255),AT(64,76,286,10),USE(REC:cooking)
                           PROMPT('&cooktime:'),AT(8,90),USE(?REC:cooktime:Prompt)
                           ENTRY(@n4),AT(64,90,40,10),USE(REC:cooktime),RIGHT(1)
                           PROMPT('&preptime:'),AT(8,104),USE(?REC:preptime:Prompt)
                           ENTRY(@n4),AT(64,104,40,10),USE(REC:preptime),RIGHT(1)
                         END
                         TAB('rimap'),USE(?Tab:2)
                           LIST,AT(8,20,342,76),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('64R(2)|M~id~C(0)@n-14@64R(2)|M~recipe id~C(0)@n-14@64R(2)|M~ingrediant id~C(0)@n' &|
   '-14@'),FROM(Queue:Browse:2)
                           BUTTON('&Insert'),AT(207,100,45,14),USE(?Insert:3)
                           BUTTON('&Change'),AT(256,100,45,14),USE(?Change:3)
                           BUTTON('&Delete'),AT(305,100,45,14),USE(?Delete:3)
                         END
                       END
                       BUTTON('OK'),AT(211,122,45,14),USE(?OK),DEFAULT
                       BUTTON('Cancel'),AT(260,122,45,14),USE(?Cancel)
                       BUTTON('Help'),AT(309,122,45,14),USE(?Help),STD(STD:Help)
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
    ActionMessage = 'Adding a recipe Record'
  OF ChangeRecord
    ActionMessage = 'Changing a recipe Record'
  END
  QuickWindow{Prop:Text} = ActionMessage
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Updaterecipe')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?REC:id:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(REC:Record,History::REC:Record)
  SELF.AddHistoryField(?REC:id,1)
  SELF.AddHistoryField(?REC:name,2)
  SELF.AddHistoryField(?REC:type,3)
  SELF.AddHistoryField(?REC:preparation,4)
  SELF.AddHistoryField(?REC:cooking,5)
  SELF.AddHistoryField(?REC:cooktime,6)
  SELF.AddHistoryField(?REC:preptime,7)
  SELF.AddUpdateFile(Access:recipe)
  SELF.AddItem(?Cancel,RequestCancelled)
  Relate:recipe.Open
  Relate:rimap.Open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:recipe
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
  BRW2.AddSortOrder(,RIM:recipekey)
  BRW2.AddRange(RIM:recipe_id,Relate:rimap,Relate:recipe)
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
    Relate:recipe.Close
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

