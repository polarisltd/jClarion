

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abpopup.inc'),ONCE
   INCLUDE('abresize.inc'),ONCE
   INCLUDE('abtoolba.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE

                     MAP
                       INCLUDE('COOKB005.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('COOKB014.INC'),ONCE        !Req'd for module callout resolution
                     END


Browserecipe PROCEDURE                                !Generated from procedure template - Window

CurrentTab           STRING(80)
BRW1::View:Browse    VIEW(recipe)
                       PROJECT(REC:id)
                       PROJECT(REC:name)
                       PROJECT(REC:type)
                       PROJECT(REC:preparation)
                       PROJECT(REC:cooking)
                       PROJECT(REC:cooktime)
                       PROJECT(REC:preptime)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
REC:id                 LIKE(REC:id)                   !List box control field - type derived from field
REC:name               LIKE(REC:name)                 !List box control field - type derived from field
REC:type               LIKE(REC:type)                 !List box control field - type derived from field
REC:preparation        LIKE(REC:preparation)          !List box control field - type derived from field
REC:cooking            LIKE(REC:cooking)              !List box control field - type derived from field
REC:cooktime           LIKE(REC:cooktime)             !List box control field - type derived from field
REC:preptime           LIKE(REC:preptime)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the recipe File'),AT(,,358,188),FONT('MS Sans Serif',8,,),IMM,HLP('Browserecipe'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,20,342,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('48R(2)|M~id~C(0)@n11@80L(2)|M~name~L(2)@s50@80L(2)|M~type~L(2)@s30@80L(2)|M~prep' &|
   'aration~L(2)@s255@80L(2)|M~cooking~L(2)@s255@36R(2)|M~cooktime~C(0)@n4@36R(2)|M~' &|
   'preptime~C(0)@n4@'),FROM(Queue:Browse:1)
                       BUTTON('&Insert'),AT(207,148,45,14),USE(?Insert:2)
                       BUTTON('&Change'),AT(256,148,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Delete'),AT(305,148,45,14),USE(?Delete:2)
                       SHEET,AT(4,4,350,162),USE(?CurrentTab)
                         TAB('REC:Keyid'),USE(?Tab:2)
                         END
                         TAB('REC:Keyname'),USE(?Tab:3)
                         END
                         TAB('REC:Keytype'),USE(?Tab:4)
                         END
                       END
                       BUTTON('Close'),AT(260,170,45,14),USE(?Close)
                       BUTTON('Help'),AT(309,170,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
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
BRW1::Sort0:StepClass StepLongClass                   !Default Step Manager
BRW1::Sort1:StepClass StepStringClass                 !Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepStringClass                 !Conditional Step Manager - CHOICE(?CurrentTab) = 3
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Browserecipe')
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
  Relate:recipe.Open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:recipe,SELF)
  OPEN(QuickWindow)
!  SELF.setICON()
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime)
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,REC:Keyname)
  BRW1.AddLocator(BRW1::Sort1:Locator)
  BRW1::Sort1:Locator.Init(,REC:name,1,BRW1)
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime)
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,REC:Keytype)
  BRW1.AddLocator(BRW1::Sort2:Locator)
  BRW1::Sort2:Locator.Init(,REC:type,1,BRW1)
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,REC:Keyid)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,REC:id,1,BRW1)
  BRW1.AddField(REC:id,BRW1.Q.REC:id)
  BRW1.AddField(REC:name,BRW1.Q.REC:name)
  BRW1.AddField(REC:type,BRW1.Q.REC:type)
  BRW1.AddField(REC:preparation,BRW1.Q.REC:preparation)
  BRW1.AddField(REC:cooking,BRW1.Q.REC:cooking)
  BRW1.AddField(REC:cooktime,BRW1.Q.REC:cooktime)
  BRW1.AddField(REC:preptime,BRW1.Q.REC:preptime)
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
    Relate:recipe.Close
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
    Updaterecipe
    ReturnValue = GlobalResponse
  END
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

