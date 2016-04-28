

   MEMBER('TUTOR.clw')                                     ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('TUTOR002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('TUTOR011.INC'),ONCE        !Req'd for module callout resolution
                     END



BrowseCUSTOMER PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(CUSTOMER)
                       PROJECT(CUS:CUSTNUMBER)
                       PROJECT(CUS:COMPANY)
                       PROJECT(CUS:FIRSTNAME)
                       PROJECT(CUS:LASTNAME)
                       PROJECT(CUS:ADDRESS)
                       PROJECT(CUS:CITY)
                       PROJECT(CUS:STATE)
                       PROJECT(CUS:ZIPCODE)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
CUS:CUSTNUMBER         LIKE(CUS:CUSTNUMBER)           !List box control field - type derived from field
CUS:COMPANY            LIKE(CUS:COMPANY)              !List box control field - type derived from field
CUS:FIRSTNAME          LIKE(CUS:FIRSTNAME)            !List box control field - type derived from field
CUS:LASTNAME           LIKE(CUS:LASTNAME)             !List box control field - type derived from field
CUS:ADDRESS            LIKE(CUS:ADDRESS)              !List box control field - type derived from field
CUS:CITY               LIKE(CUS:CITY)                 !List box control field - type derived from field
CUS:STATE              LIKE(CUS:STATE)                !List box control field - type derived from field
CUS:ZIPCODE            LIKE(CUS:ZIPCODE)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the CUSTOMER file'),AT(,,358,198),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,HLP('BrowseCUSTOMER'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,30,342,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing the CUSTOMER file'),FORMAT('64R(2)|M~CUSTNUMBER~C(0)@n-14@80L(2)|M~COMPANY~L(2)@s20@80L(2)|M~FIRSTNAME~L(2)@' &|
   's20@80L(2)|M~LASTNAME~L(2)@s20@80L(2)|M~ADDRESS~L(2)@s20@80L(2)|M~CITY~L(2)@s20@' &|
   '24L(2)|M~STATE~L(2)@s2@32L(2)|M~ZIPCODE~L(2)@P#####P@'),FROM(Queue:Browse:1)
                       BUTTON('&View'),AT(142,158,49,14),USE(?View:2),FLAT,LEFT,MSG('View Record'),TIP('View Record'),ICON('WAVIEW.ICO')
                       BUTTON('&Insert'),AT(195,158,49,14),USE(?Insert:3),FLAT,LEFT,MSG('Insert a Record'),TIP('Insert a Record'),ICON('WAINSERT.ICO')
                       BUTTON('&Change'),AT(248,158,49,14),USE(?Change:3),FLAT,LEFT,MSG('Change the Record'),TIP('Change the Record'),ICON('WACHANGE.ICO'),DEFAULT
                       BUTTON('&Delete'),AT(301,158,49,14),USE(?Delete:3),FLAT,LEFT,MSG('Delete the Record'),TIP('Delete the Record'),ICON('WADELETE.ICO')
                       SHEET,AT(4,4,350,172),USE(?CurrentTab)
                         TAB('&1) KEYCUSTNUMBER'),USE(?Tab:2)
                         END
                         TAB('&2) KEYCOMPANY'),USE(?Tab:3)
                         END
                         TAB('&3) KEYZIPCODE'),USE(?Tab:4)
                         END
                       END
                       BUTTON('&Close'),AT(252,180,49,14),USE(?Close),FLAT,LEFT,MSG('Close Window'),TIP('Close Window'),ICON('WACLOSE.ICO')
                       BUTTON('&Help'),AT(305,180,49,14),USE(?Help),FLAT,LEFT,MSG('See Help Window'),TIP('See Help Window'),ICON('WAHELP.ICO'),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort1:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort2:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 3
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
BRW1::Sort1:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepLongClass                        ! Conditional Step Manager - CHOICE(?CurrentTab) = 3
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
  GlobalErrors.SetProcedureName('BrowseCUSTOMER')
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
  Relate:CUSTOMER.Open                                     ! File CUSTOMER used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:CUSTOMER,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CUS:COMPANY for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,CUS:KEYCOMPANY)  ! Add the sort order for CUS:KEYCOMPANY for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(,CUS:COMPANY,1,BRW1)            ! Initialize the browse locator using  using key: CUS:KEYCOMPANY , CUS:COMPANY
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon CUS:ZIPCODE for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,CUS:KEYZIPCODE)  ! Add the sort order for CUS:KEYZIPCODE for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(,CUS:ZIPCODE,1,BRW1)            ! Initialize the browse locator using  using key: CUS:KEYZIPCODE , CUS:ZIPCODE
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon CUS:CUSTNUMBER for sort order 3
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,CUS:KEYCUSTNUMBER) ! Add the sort order for CUS:KEYCUSTNUMBER for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(,CUS:CUSTNUMBER,1,BRW1)         ! Initialize the browse locator using  using key: CUS:KEYCUSTNUMBER , CUS:CUSTNUMBER
  BRW1.AddField(CUS:CUSTNUMBER,BRW1.Q.CUS:CUSTNUMBER)      ! Field CUS:CUSTNUMBER is a hot field or requires assignment from browse
  BRW1.AddField(CUS:COMPANY,BRW1.Q.CUS:COMPANY)            ! Field CUS:COMPANY is a hot field or requires assignment from browse
  BRW1.AddField(CUS:FIRSTNAME,BRW1.Q.CUS:FIRSTNAME)        ! Field CUS:FIRSTNAME is a hot field or requires assignment from browse
  BRW1.AddField(CUS:LASTNAME,BRW1.Q.CUS:LASTNAME)          ! Field CUS:LASTNAME is a hot field or requires assignment from browse
  BRW1.AddField(CUS:ADDRESS,BRW1.Q.CUS:ADDRESS)            ! Field CUS:ADDRESS is a hot field or requires assignment from browse
  BRW1.AddField(CUS:CITY,BRW1.Q.CUS:CITY)                  ! Field CUS:CITY is a hot field or requires assignment from browse
  BRW1.AddField(CUS:STATE,BRW1.Q.CUS:STATE)                ! Field CUS:STATE is a hot field or requires assignment from browse
  BRW1.AddField(CUS:ZIPCODE,BRW1.Q.CUS:ZIPCODE)            ! Field CUS:ZIPCODE is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseCUSTOMER',QuickWindow)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  Resizer.Reset
  BRW1.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:CUSTOMER.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseCUSTOMER',QuickWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateCUSTOMER
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


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
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

