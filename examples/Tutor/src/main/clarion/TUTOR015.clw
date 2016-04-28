

   MEMBER('TUTOR.clw')                                     ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('TUTOR015.INC'),ONCE        !Local module procedure declarations
                     END



SelectStates PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(States)
                       PROJECT(STA:State)
                       PROJECT(STA:StateName)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
STA:State              LIKE(STA:State)                !List box control field - type derived from field
STA:StateName          LIKE(STA:StateName)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Select a States Record'),AT(,,158,198),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,HLP('SelectStates'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,30,142,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing the States file'),FORMAT('24L(2)|M~State~L(2)@S2@80L(2)|M~State Name~L(2)@s30@'),FROM(Queue:Browse:1)
                       BUTTON('&Select'),AT(101,158,49,14),USE(?Select:2),FLAT,LEFT,MSG('Select the Record'),TIP('Select the Record'),ICON('WASELECT.ICO')
                       SHEET,AT(4,4,150,172),USE(?CurrentTab)
                         TAB('&1) KeyState'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Close'),AT(52,180,49,14),USE(?Close),FLAT,LEFT,MSG('Close Window'),TIP('Close Window'),ICON('WACLOSE.ICO')
                       BUTTON('&Help'),AT(105,180,49,14),USE(?Help),FLAT,LEFT,MSG('See Help Window'),TIP('See Help Window'),ICON('WAHELP.ICO'),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SelectStates')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:States.Open                                       ! File States used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:States,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon STA:State for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,STA:KeyState)    ! Add the sort order for STA:KeyState for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,STA:State,1,BRW1)              ! Initialize the browse locator using  using key: STA:KeyState , STA:State
  BRW1.AddField(STA:State,BRW1.Q.STA:State)                ! Field STA:State is a hot field or requires assignment from browse
  BRW1.AddField(STA:StateName,BRW1.Q.STA:StateName)        ! Field STA:StateName is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectStates',QuickWindow)                 ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  Resizer.Reset
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:States.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectStates',QuickWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

