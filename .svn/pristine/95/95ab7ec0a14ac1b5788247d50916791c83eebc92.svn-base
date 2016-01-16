

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abpopup.inc'),ONCE
   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB016.INC'),ONCE        !Local module procedure declarations
                     END


Selectingredients PROCEDURE                           !Generated from procedure template - Window

CurrentTab           STRING(80)
BRW1::View:Browse    VIEW(ingredients)
                       PROJECT(ING:id)
                       PROJECT(ING:name)
                       PROJECT(ING:shelflife)
                       PROJECT(ING:cost)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
ING:id                 LIKE(ING:id)                   !List box control field - type derived from field
ING:name               LIKE(ING:name)                 !List box control field - type derived from field
ING:shelflife          LIKE(ING:shelflife)            !List box control field - type derived from field
ING:cost               LIKE(ING:cost)                 !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Select a ingredients Record'),AT(,,220,188),FONT('MS Sans Serif',8,,),IMM,HLP('Selectingredients'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,204,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('48R(2)|M~id~C(0)@n11@80L(2)|M~name~L(2)@s50@40R(2)|M~shelflife~C(0)@n6@44D(20)|M' &|
   '~cost~C(0)@n10.2@'),FROM(Queue:Browse:1)
                       BUTTON('&Select'),AT(167,148,45,14),USE(?Select:2)
                       SHEET,AT(4,4,212,162),USE(?CurrentTab)
                         TAB('ING:Keyid'),USE(?Tab:2)
                         END
                         TAB('ING:Keyname'),USE(?Tab:3)
                         END
                       END
                       BUTTON('Close'),AT(122,170,45,14),USE(?Close)
                       BUTTON('Help'),AT(171,170,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                 !Default Locator
BRW1::Sort1:Locator  StepLocatorClass                 !Conditional Locator - CHOICE(?CurrentTab) = 2
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Selectingredients')
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
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:ingredients,SELF)
  OPEN(QuickWindow)
!  SELF.setICON()
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,ING:Keyname)
  BRW1.AddLocator(BRW1::Sort1:Locator)
  BRW1::Sort1:Locator.Init(,ING:name,1,BRW1)
  BRW1.AddSortOrder(,ING:Keyid)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,ING:id,1,BRW1)
  BRW1.AddField(ING:id,BRW1.Q.ING:id)
  BRW1.AddField(ING:name,BRW1.Q.ING:name)
  BRW1.AddField(ING:shelflife,BRW1.Q.ING:shelflife)
  BRW1.AddField(ING:cost,BRW1.Q.ING:cost)
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
    Relate:ingredients.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults

