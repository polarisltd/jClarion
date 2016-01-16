

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abpopup.inc'),ONCE
   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB009.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COOKB015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB016.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('COOKB017.INC'),ONCE        !Req'd for module callout resolution
                     END


Browserimap PROCEDURE                                 !Generated from procedure template - Window

CurrentTab           STRING(80)
BRW1::View:Browse    VIEW(rimap)
                       PROJECT(RIM:id)
                       PROJECT(RIM:recipe_id)
                       PROJECT(RIM:ingrediant_id)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
RIM:id                 LIKE(RIM:id)                   !List box control field - type derived from field
RIM:recipe_id          LIKE(RIM:recipe_id)            !List box control field - type derived from field
RIM:ingrediant_id      LIKE(RIM:ingrediant_id)        !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the rimap File'),AT(,,208,198),FONT('MS Sans Serif',8,,),IMM,HLP('Browserimap'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,30,192,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('64R(2)|M~id~C(0)@n-14@64R(2)|M~recipe id~C(0)@n-14@64R(2)|M~ingrediant id~C(0)@n' &|
   '-14@'),FROM(Queue:Browse:1)
                       BUTTON('&Insert'),AT(57,158,45,14),USE(?Insert:2)
                       BUTTON('&Change'),AT(106,158,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Delete'),AT(155,158,45,14),USE(?Delete:2)
                       SHEET,AT(4,4,200,172),USE(?CurrentTab)
                         TAB('RIM:primarykey'),USE(?Tab:2)
                         END
                         TAB('RIM:recipekey'),USE(?Tab:3)
                           BUTTON('recipe'),AT(8,158,45,14),USE(?Selectrecipe)
                         END
                         TAB('RIM:ingrediantkey'),USE(?Tab:4)
                           BUTTON('ingredients'),AT(8,158,45,14),USE(?Selectingredients)
                         END
                       END
                       BUTTON('Close'),AT(110,180,45,14),USE(?Close)
                       BUTTON('Help'),AT(159,180,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                 !Default Locator
BRW1::Sort1:Locator  StepLocatorClass                 !Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort2:Locator  StepLocatorClass                 !Conditional Locator - CHOICE(?CurrentTab) = 3
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Browserimap')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  Relate:ingredients.Open
  Relate:recipe.Open
  Relate:rimap.Open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:rimap,SELF)
  OPEN(QuickWindow)
!  SELF.setICON()
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,RIM:recipekey)
  BRW1.AddLocator(BRW1::Sort1:Locator)
  BRW1::Sort1:Locator.Init(,RIM:recipe_id,1,BRW1)
  BRW1.AddSortOrder(,RIM:ingrediantkey)
  BRW1.AddLocator(BRW1::Sort2:Locator)
  BRW1::Sort2:Locator.Init(,RIM:ingrediant_id,1,BRW1)
  BRW1.AddSortOrder(,RIM:primarykey)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,RIM:id,1,BRW1)
  BRW1.AddField(RIM:id,BRW1.Q.RIM:id)
  BRW1.AddField(RIM:recipe_id,BRW1.Q.RIM:recipe_id)
  BRW1.AddField(RIM:ingrediant_id,BRW1.Q.RIM:ingrediant_id)
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)
  SELF.AddItem(Resizer)
  BRW1.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ingredients.Close
    Relate:recipe.Close
    Relate:rimap.Close
  END
  GlobalErrors.SetProcedureName
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
    OF ?Selectrecipe
      ThisWindow.Update
      GlobalRequest = SelectRecord
      Selectrecipe
      ThisWindow.Reset
    OF ?Selectingredients
      ThisWindow.Update
      GlobalRequest = SelectRecord
      Selectingredients
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?CurrentTab) = 3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults

