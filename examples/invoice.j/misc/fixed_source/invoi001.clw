

   MEMBER('invoice.clw')                                   ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABQUERY.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
                     MAP
                       INCLUDE('INVOI001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('INVOI002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('INVOI003.INC'),ONCE        !Req'd for module callout resolution
                     END



SelectStates PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(States)
                       PROJECT(STA:StateCode)
                       PROJECT(STA:Name)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
STA:StateCode          LIKE(STA:StateCode)            !List box control field - type derived from field
STA:Name               LIKE(STA:Name)                 !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Select a State'),AT(,,173,203),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('USA1.ICO'),HLP('~SelectaState'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,1,165,199),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                           STRING(@s2),AT(69,185,18,10),USE(STA:StateCode),FONT(,,COLOR:Red,FONT:bold)
                         END
                       END
                       LIST,AT(10,7,151,171),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('39C|M~State Code~L(2)@s2@80L(1)|M~State Name~@s25@'),FROM(Queue:Browse:1)
                       BUTTON('&Select'),AT(74,96,19,14),USE(?Select:2),HIDE
                       BUTTON('&Insert'),AT(57,130,19,14),USE(?Insert:3),HIDE
                       BUTTON('&Change'),AT(106,130,19,14),USE(?Change:3),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(42,90,19,14),USE(?Delete:3),HIDE
                       STRING('Locator: Code'),AT(9,185,57,10),USE(?String1),FONT('MS Sans Serif',8,,FONT:bold)
                       BUTTON,AT(125,157,13,12),USE(?Help),HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(145,181,19,16),USE(?Close),FLAT,TIP('Cancel selection and exit browse'),ICON('EXITS.ICO')
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

BRW1::Sort0:Locator  IncrementalLocatorClass               ! Default Locator
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?Browse:1
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
  SELF.FirstField = ?STA:StateCode
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
  ?Browse:1{Prop:LineHeight} = 0
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon STA:StateCode for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,STA:StateCodeKey) ! Add the sort order for STA:StateCodeKey for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?STA:StateCode,STA:StateCode,1,BRW1) ! Initialize the browse locator using ?STA:StateCode using key: STA:StateCodeKey , STA:StateCode
  BRW1.AddField(STA:StateCode,BRW1.Q.STA:StateCode)        ! Field STA:StateCode is a hot field or requires assignment from browse
  BRW1.AddField(STA:Name,BRW1.Q.STA:Name)                  ! Field STA:Name is a hot field or requires assignment from browse
  QuickWindow{PROP:MinWidth}=173                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=203                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
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
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

UpdateCustomers PROCEDURE                                  ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
RecordChanged        BYTE,AUTO                             !
History::CUS:Record  LIKE(CUS:RECORD),THREAD
QuickWindow          WINDOW('Update Customers'),AT(,,214,191),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('CUSTOMER.ICO'),HLP('~UpdateCustomers'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,2,211,188),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                         END
                       END
                       PROMPT('&Company:'),AT(8,9),USE(?CUS:Company:Prompt)
                       ENTRY(@s20),AT(64,9,84,10),USE(CUS:Company),MSG('Enter the customer''s company'),CAP
                       PROMPT('&First Name:'),AT(8,23),USE(?CUS:FirstName:Prompt)
                       ENTRY(@s20),AT(64,23,84,10),USE(CUS:FirstName),MSG('Enter the first name of customer'),REQ,CAP
                       PROMPT('MI:'),AT(8,37,23,10),USE(?CUS:MI:Prompt)
                       ENTRY(@s1),AT(64,37,21,10),USE(CUS:MI),MSG('Enter the middle initial of customer'),UPR
                       PROMPT('&Last Name:'),AT(8,51),USE(?CUS:LastName:Prompt)
                       ENTRY(@s25),AT(64,51,104,10),USE(CUS:LastName),MSG('Enter the last name of customer'),REQ,CAP
                       PROMPT('&Address1:'),AT(8,65),USE(?CUS:Address1:Prompt)
                       ENTRY(@s35),AT(64,65,139,10),USE(CUS:Address1),MSG('Enter the first line address of customer'),CAP
                       PROMPT('Address2:'),AT(8,79),USE(?CUS:Address2:Prompt)
                       ENTRY(@s35),AT(64,79,139,10),USE(CUS:Address2),MSG('Enter the second line address of customer if any'),CAP
                       PROMPT('&City:'),AT(8,93),USE(?CUS:City:Prompt)
                       ENTRY(@s25),AT(64,93,104,10),USE(CUS:City),MSG('Enter  city of customer'),CAP
                       PROMPT('&State:'),AT(8,108),USE(?CUS:State:Prompt)
                       ENTRY(@s2),AT(64,108,22,10),USE(CUS:State),MSG('Enter state of customer'),UPR
                       PROMPT('&Zip Code:'),AT(8,122),USE(?CUS:ZipCode:Prompt)
                       ENTRY(@K#####|-####KB),AT(64,122,69,10),USE(CUS:ZipCode),MSG('Enter zipcode of customer'),TIP('Enter zipcode of customer')
                       PROMPT('Phone Number:'),AT(8,136),USE(?CUS:PhoneNumber:Prompt)
                       ENTRY(@P(###) ###-####PB),AT(64,136,68,10),USE(CUS:PhoneNumber),MSG('Customer''s phone number')
                       PROMPT('Extension:'),AT(8,150),USE(?CUS:Extension:Prompt)
                       ENTRY(@P<<<#PB),AT(64,150,24,10),USE(CUS:Extension),MSG('Enter customer''s phone extension')
                       PROMPT('Phone Type:'),AT(109,150,43,10),USE(?CUS:PhoneType:Prompt)
                       LIST,AT(158,150,44,10),USE(CUS:PhoneType),MSG('Enter customer''s phone type'),DROP(5),FROM('Home|Work|Cellular|Pager|Fax|Other')
                       ! BUTTON,AT(70,167,21,20),USE(?OK),FLAT,MSG('Save recod and Exit'),TIP('Save recod and Exit'),CURSOR(CURSOR:None),ICON('DISK12.ICO'),DEFAULT %%%%%
                       ! it not accept CURSOR(CURSOR:None) is it because CURSOR is not implemented, as include of EQUATES didnt help %%%%%%%%%%%%%%%
                       BUTTON,AT(70,167,21,20),USE(?OK),FLAT,MSG('Save recod and Exit'),TIP('Save recod and Exit'),ICON('DISK12.ICO'),DEFAULT

                       BUTTON,AT(103,171,13,12),USE(?Help),FLAT,HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(125,167,21,20),USE(?Cancel),FLAT,MSG('Cancels change and Exit'),TIP('Cancels change and Exit'),ICON(ICON:Cross)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a Customers Record'
  OF ChangeRecord
    ActionMessage = 'Changing a Customers Record'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateCustomers')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?CUS:Company:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(CUS:Record,History::CUS:Record)
  SELF.AddHistoryField(?CUS:Company,2)
  SELF.AddHistoryField(?CUS:FirstName,3)
  SELF.AddHistoryField(?CUS:MI,4)
  SELF.AddHistoryField(?CUS:LastName,5)
  SELF.AddHistoryField(?CUS:Address1,6)
  SELF.AddHistoryField(?CUS:Address2,7)
  SELF.AddHistoryField(?CUS:City,8)
  SELF.AddHistoryField(?CUS:State,9)
  SELF.AddHistoryField(?CUS:ZipCode,10)
  SELF.AddHistoryField(?CUS:PhoneNumber,11)
  SELF.AddHistoryField(?CUS:Extension,12)
  SELF.AddHistoryField(?CUS:PhoneType,13)
  SELF.AddUpdateFile(Access:Customers)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  Relate:States.Open                                       ! File States used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Customers
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:Query
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  QuickWindow{PROP:MinWidth}=214                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=188                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Customers.Close
    Relate:States.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SelectStates
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?CUS:State
      STA:StateCode = CUS:State
      IF Access:States.TryFetch(STA:StateCodeKey)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          CUS:State = STA:StateCode
        ELSE
          SELECT(?CUS:State)
          CYCLE
        END
      END
      ThisWindow.Reset(0)
      IF Access:Customers.TryValidateField(9)              ! Attempt to validate CUS:State in Customers
        SELECT(?CUS:State)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?CUS:State
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?CUS:State{Prop:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
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
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

BrowseAllOrders PROCEDURE                                  ! Generated from procedure template - Window

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
DisplayString        STRING(255)                           !
REL1::Toolbar        CLASS(ToolbarReltreeClass)
TakeEvent            PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
  END
REL1::SaveLevel      BYTE,AUTO
REL1::Action         LONG,AUTO
Queue:RelTree        QUEUE,PRE()                           ! Browsing Queue
REL1::Display        STRING(200)                           ! Queue display string
REL1::NormalFG       LONG
REL1::NormalBG       LONG
REL1::SelectedFG     LONG
REL1::SelectedBG     LONG
REL1::Icon           SHORT
REL1::Level          LONG                                  ! Record level in the tree
REL1::Loaded         SHORT                                 ! Inferior level is loaded
REL1::Position       STRING(1024)                          ! Record POSITION in VIEW
                END
REL1::LoadedQueue    QUEUE,PRE()                           ! Status Queue
REL1::LoadedLevel    LONG                                  ! Record level
REL1::LoadedPosition STRING(1024)                          ! Record POSITION in VIEW
               END
REL1::CurrentLevel   LONG                                  ! Current loaded level
REL1::CurrentChoice  LONG                                  ! Current record
REL1::NewItemLevel   LONG                                  ! Level for a new item
REL1::NewItemPosition STRING(1024)                         ! POSITION of a new record
REL1::LoadAll        LONG
! window               WINDOW('Browse Customers Orders In Tree View'),AT(,,312,193),FONT('MS Sans Serif',8,COLOR:Black,FONT:bold),CENTER,IMM,ICON('NOTE14.ICO'),HLP('~BrowseCustomersOrdersInTreeView'),PALETTE(256),SYSTEM,GRAY,RESIZE,MDI
! %%%%%%%%%%%% did keyworf PALETTE cause problem
window               WINDOW('Browse Customers Orders In Tree View'),AT(,,312,193),FONT('MS Sans Serif',8,COLOR:Black,FONT:bold),CENTER,IMM,ICON('NOTE14.ICO'),HLP('~BrowseCustomersOrdersInTreeView'),SYSTEM,GRAY,RESIZE,MDI

                       LIST,AT(3,17,305,156),USE(?RelTree),VSCROLL,FONT('Times New Roman',10,,FONT:bold),COLOR(,COLOR:White,COLOR:Blue),MSG('Ctrl+-> Expand branch,  Ctrl+<<- Contract branch'),FORMAT('800L*ITS(70)@s200@'),FROM(Queue:RelTree)
                       BUTTON('Insert'),AT(4,177,48,15),USE(?Insert),SKIP,FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Insert a record'),ICON('Insert.ico')
                       BUTTON('Change'),AT(55,177,48,15),USE(?Change),SKIP,FLAT,LEFT,FONT(,8,COLOR:Green,FONT:bold),TIP('Edit a record'),ICON('Edit.ico')
                       BUTTON('Delete'),AT(106,177,48,15),USE(?Delete),SKIP,FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Delete a record'),ICON('Delete.ico')
                       STRING('Backordered Item'),AT(104,2,89,12),USE(?String1),CENTER,FONT('MS Sans Serif',10,COLOR:Red,FONT:bold)
                       BUTTON('&Expand All'),AT(161,177,55,15),USE(?Expand),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Expand All Branches'),ICON(ICON:None)
                       BUTTON('Co&ntract All'),AT(218,177,55,15),USE(?Contract),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Contract All Branches'),ICON(ICON:None)
                       BUTTON,AT(274,143,11,12),USE(?Help),HIDE,TIP('Get help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(290,177,19,15),USE(?Close),SKIP,FLAT,TIP('Exits Browse'),ICON('EXITS.ICO')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
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
REL1::NextParent ROUTINE
  GET(Queue:RelTree,CHOICE(?RelTree))
  IF ABS(REL1::Level) > 1
    REL1::SaveLevel = ABS(REL1::Level)-1
    DO REL1::NextSavedLevel
  END

REL1::PreviousParent ROUTINE
  GET(Queue:RelTree,CHOICE(?RelTree))
  IF ABS(REL1::Level) > 1
    REL1::SaveLevel = ABS(REL1::Level)-1
    DO REL1::PreviousSavedLevel
  END

REL1::NextLevel ROUTINE
  GET(Queue:RelTree,CHOICE(?RelTree))
  REL1::SaveLevel = ABS(REL1::Level)
  DO REL1::NextSavedLevel

REL1::NextSavedLevel ROUTINE
  DATA
SavePointer LONG,AUTO
  CODE
  LOOP
    LOOP
      GET(Queue:RelTree,POINTER(Queue:RelTree)+1)
      IF ERRORCODE()
        EXIT                ! Unable to find another record on similar level
      END
    WHILE ABS(REL1::Level) > REL1::SaveLevel
    IF ABS(REL1::Level) = REL1::SaveLevel
      SELECT(?RelTree,POINTER(Queue:RelTree))
      EXIT
    END
    SavePointer = POINTER(Queue:RelTree)
    ?RelTree{PROPLIST:MouseDownRow} = SavePointer
    DO REL1::LoadLevel
    GET(Queue:RelTree,SavePointer)
  END

REL1::PreviousSavedLevel ROUTINE
  DATA
SaveRecords LONG,AUTO
SavePointer LONG,AUTO
  CODE
  LOOP
    LOOP
      GET(Queue:RelTree,POINTER(Queue:RelTree)-1)
      IF ERRORCODE()
        EXIT                ! Unable to find another record on similar level
      END
    WHILE ABS(REL1::Level) > REL1::SaveLevel
    IF ABS(REL1::Level) = REL1::SaveLevel
      SELECT(?RelTree,POINTER(Queue:RelTree))
      EXIT
    END
    SavePointer = POINTER(Queue:RelTree)
    SaveRecords = RECORDS(Queue:RelTree)
    ?RelTree{PROPLIST:MouseDownRow} = SavePointer
    DO REL1::LoadLevel
    IF RECORDS(Queue:RelTree) <> SaveRecords
      SavePointer += 1 + RECORDS(Queue:RelTree) - SaveRecords
    END
    GET(Queue:RelTree,SavePointer)
  END

REL1::PreviousLevel ROUTINE
  GET(Queue:RelTree,CHOICE(?RelTree))
  REL1::SaveLevel = ABS(REL1::Level)
  DO REL1::PreviousSavedLevel

REL1::NextRecord ROUTINE
  DO REL1::LoadLevel
  IF CHOICE(?RelTree) < RECORDS(Queue:RelTree)
    SELECT(?RelTree,CHOICE(?RelTree)+1)
  END

REL1::PreviousRecord ROUTINE
  DATA
SaveRecords LONG,AUTO
SavePointer LONG,AUTO
  CODE
  SavePointer = CHOICE(?RelTree)-1
  LOOP
    SaveRecords = RECORDS(Queue:RelTree)
    ?RelTree{PROPLIST:MouseDownRow} = SavePointer
    DO REL1::LoadLevel
    IF RECORDS(Queue:RelTree) = SaveRecords
      BREAK
    END
    SavePointer += RECORDS(Queue:RelTree) - SaveRecords
  END
  SELECT(?RelTree,SavePointer)

REL1::AssignButtons ROUTINE
  REL1::Toolbar.DeleteButton = ?Delete
  REL1::Toolbar.InsertButton = ?Insert
  REL1::Toolbar.ChangeButton = ?Change
  REL1::Toolbar.HelpButton = ?Help
  Toolbar.SetTarget(?RelTree)

!---------------------------------------------------------------------------
REL1::Load:Customers ROUTINE
!|
!| This routine is used to load the base level of the RelationTree.
!|
!| First, the Title line is added.
!|
!| Next, each record of the file Customers is read. If the record is not filtered,
!| then the following happens:
!|
!|   First, the queue REL1::LoadedQueue is searched, to see if the tree branch
!|   corresponding to the record is "loaded", that is, if the branch is currently opened.
!|
!|   If the branch is open, then the records for that branch are read from the file
!|   Orders. This is done in the routine REL1::Load:Orders.
!|
!|   If the branch is not open, then the RelationTree looks for a single record from
!|   Orders, to see if any child records are available. If they are, the
!|   branch can be expanded, so REL1::Level gets a -1. This
!|   value is used by the list box to display a "closed" box next to the entry.
!|
!|   Finally, the queue record that corresponds to the Customers record read is
!|   formatted and added to the queue Queue:RelTree. This is done in the routine
!|   REL1::Format:Customers.
!|
  REL1::Display = 'CUSTOMERS'''' ORDERS'
  REL1::Loaded = 0
  REL1::Position = ''
  REL1::Level = 0
  REL1::Icon = 1
  REL1::NormalFG = -1
  REL1::NormalBG = -1
  REL1::SelectedFG = -1
  REL1::SelectedBG = -1
  ADD(Queue:RelTree)
  Access:Customers.UseFile
  SET(CUS:KeyFullName)
  LOOP
    IF Access:Customers.Next() NOT= Level:Benign
      IF Access:Customers.GetEOF()
        BREAK
      ELSE
        POST(EVENT:CloseWindow)
        EXIT
      END
    END
    REL1::Loaded = 0
    REL1::Position = POSITION(CUS:KeyFullName)
    REL1::Level = 1
    REL1::LoadedLevel = ABS(REL1::Level)
    REL1::LoadedPosition = REL1::Position
    GET(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
    IF ERRORCODE() AND REL1::LoadAll = False
      ORD:CustNumber = CUS:CustNumber
      CLEAR(ORD:OrderNumber,0)
      Access:Orders.UseFile
      SET(ORD:KeyCustOrderNumber,ORD:KeyCustOrderNumber)
      LOOP
        IF Access:Orders.Next()
          IF Access:Orders.GetEOF()
            BREAK
          ELSE
            POST(EVENT:CloseWindow)
            EXIT
          END
        END
        IF UPPER(ORD:CustNumber) <> UPPER(CUS:CustNumber) THEN BREAK.
        REL1::Level = -1
        BREAK
      END
      DO REL1::Format:Customers
      ADD(Queue:RelTree,POINTER(Queue:RelTree)+1)
    ELSE
      IF REL1::LoadAll
        ADD(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
      END
      REL1::Level = 1
      REL1::Loaded = True
      DO REL1::Format:Customers
      ADD(Queue:RelTree,POINTER(Queue:RelTree)+1)
      DO REL1::Load:Orders
    END
  END

!---------------------------------------------------------------------------
REL1::Format:Customers ROUTINE
!|
!| This routine formats a line of the display queue Queue:RelTree to display the
!| contents of a record of Customers.
!|
!| First, the variable DisplayString is assigned the formatted value.
!|
!| Next, the queue variable REL1::Display is assigned the value in
!| DisplayString. It is possible for the display string to be reformatted in
!| the EMBED point "Relation Tree, Before Setting Display on Primary File".
!|
!| Next, any coloring done to the line is performed.
!|
!| Next, any icon assigments are made.
!|
  DisplayString = CLIP(CUS:FirstName) & ' ' & CLIP(CUS:LastName) &'  '& FORMAT(CUS:CustNumber,@P(#######)P)
  REL1::Display = DisplayString
  REL1::NormalFG = 128
  REL1::NormalBG = -1
  REL1::SelectedFG = -1
  REL1::SelectedBG = -1
  REL1::Icon = 2

!---------------------------------------------------------------------------
REL1::LoadLevel ROUTINE
!|
!| This routine is used to load a single level of the RelationTree.
!|
!| First, we see where the load comes from. Since the alert-key handling sets
!| ?RelTree{PropList:MouseDownRow} to CHOICE, we can rely on this property
!| containing the correct selection.
!|
!| Next, we retrieve the Queue:RelTree record that corresponds to the requested
!| load row. If the requested load row is already loaded, we don't have to do
!| anything. If the requested row is not loaded...
!|
!|   First, we set REL1::Level to a positive value for the selected
!|   row and put that record back into the queue Queue:RelTree. The presence of
!|   records with a greater Level below this record in the queue tells the
!|   listbox that the level is opened.
!|
!|   Next, we add a record the the queue REL1::LoadedQueue. This queue
!|   is used to rebuild the display when necessary.
!|
!|   Next, we retrieve the file record that corresponds to the requested load row.
!|
!|   Finally, we reformat the Queue:RelTree entry. This allows for any changes in icon
!|   and colors based on conditional usage.
!|
  REL1::CurrentChoice = ?RelTree{PropList:MouseDownRow}
  GET(Queue:RelTree,REL1::CurrentChoice)
  IF NOT REL1::Loaded
    REL1::Level = ABS(REL1::Level)
    PUT(Queue:RelTree)
    REL1::Loaded = True
    REL1::LoadedLevel = ABS(REL1::Level)
    REL1::LoadedPosition = REL1::Position
    ADD(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
    EXECUTE(ABS(REL1::Level))
      BEGIN
        REGET(CUS:KeyFullName,REL1::Position)
        DO REL1::Format:Customers
      END
      BEGIN
        REGET(Orders,REL1::Position)
        DO REL1::Format:Orders
      END
      BEGIN
        REGET(Detail,REL1::Position)
        DO REL1::Format:Detail
      END
    END
    PUT(Queue:RelTree)
    EXECUTE(ABS(REL1::Level))
      DO REL1::Load:Orders
      DO REL1::Load:Detail
    END
  END
!---------------------------------------------------------------------------
REL1::UnloadLevel ROUTINE
!|
!| This routine is used to unload a level of the RelationTree.
!|
!| First, we see where the unload comes from. Since the alert-key handling sets
!| ?RelTree{PropList:MouseDownRow} to CHOICE, we can rely on this property
!| containing the correct selection.
!|
!| Next, we retrieve the Queue:RelTree record that corresponds to the requested
!| unload row. If the requested load row isn't loaded, we don't have to do
!| anything. If the requested row is loaded...
!|
!|   First, we set REL1::Level to a negative value for the selected
!|   row and put that record back into the queue Queue:RelTree. Since there
!|   won't be any records at lower levels, we use the negative value to signal
!|   the listbox that the level is closed, but children exist.
!|
!|   Next, we retrieve the record the the queue REL1::LoadedQueue that
!|   corresponds to the unloaded level. This queue record is then deleted.
!|
!|   Next, we retrieve the file record that corresponds to the requested load row.
!|
!|   Next, we reformat the Queue:RelTree entry. This allows for any changes in icon
!|   and colors based on conditional usage.
!|
!|   Finally, we run through all of the Queue:RelTree entries for branches below the
!|   unloaded level, and delete these entries.
!|
  REL1::CurrentChoice = ?RelTree{PropList:MouseDownRow}
  GET(Queue:RelTree,REL1::CurrentChoice)
  IF REL1::Loaded
    REL1::Level = -ABS(REL1::Level)
    PUT(Queue:RelTree)
    REL1::Loaded = False
    REL1::LoadedLevel = ABS(REL1::Level)
    REL1::LoadedPosition = REL1::Position
    GET(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
    IF NOT ERRORCODE()
      DELETE(REL1::LoadedQueue)
    END
    EXECUTE(ABS(REL1::Level))
      BEGIN
        REGET(CUS:KeyFullName,REL1::Position)
        DO REL1::Format:Customers
      END
      BEGIN
        REGET(Orders,REL1::Position)
        DO REL1::Format:Orders
      END
      BEGIN
        REGET(Detail,REL1::Position)
        DO REL1::Format:Detail
      END
    END
    PUT(Queue:RelTree)
    REL1::CurrentLevel = ABS(REL1::Level)
    REL1::CurrentChoice += 1
    LOOP
      GET(Queue:RelTree,REL1::CurrentChoice)
      IF ERRORCODE() THEN BREAK.
      IF ABS(REL1::Level) <= REL1::CurrentLevel THEN BREAK.
      DELETE(Queue:RelTree)
    END
  END
!---------------------------------------------------------------------------
REL1::Load:Orders ROUTINE
!|
!| This routine is used to load the base level of the RelationTree.
!|
!| For each record of the file Orders is read. If the record is not filtered,
!| then the following happens:
!|
!|   First, the queue REL1::LoadedQueue is searched, to see if the tree branch
!|   corresponding to the record is "loaded", that is, if the branch is currently opened.
!|
!|   If the branch is open, then the records for that branch are read from the file
!|   Detail. This is done in the routine REL1::Load:Detail.
!|
!|   If the branch is not open, then the RelationTree looks for a single record from
!|   Detail, to see if any child records are available. If they are, the
!|   branch can be expanded, so REL1::Level gets a -2. This
!|   value is used by the list box to display a "closed" box next to the entry.
!|
!|   Finally, the queue record that corresponds to the Orders record read is
!|   formatted and added to the queue Queue:RelTree. This is done in the routine
!|   REL1::Format:Orders.
!|
  ORD:CustNumber = CUS:CustNumber
  CLEAR(ORD:OrderNumber)
  Access:Orders.UseFile
  SET(ORD:KeyCustOrderNumber,ORD:KeyCustOrderNumber)
  LOOP
    IF Access:Orders.Next()
      IF Access:Orders.GetEOF()
        BREAK
      ELSE
        POST(EVENT:CloseWindow)
        EXIT
      END
    END
    IF ORD:CustNumber <> CUS:CustNumber THEN BREAK.
    REL1::Loaded = 0
    REL1::Position = POSITION(Orders)
    REL1::Level = 2
    REL1::LoadedLevel = ABS(REL1::Level)
    REL1::LoadedPosition = REL1::Position
    GET(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
    IF ERRORCODE() AND REL1::LoadAll = False
      DTL:CustNumber = ORD:CustNumber
      DTL:OrderNumber = ORD:OrderNumber
      CLEAR(DTL:LineNumber,0)
      Access:Detail.UseFile
      SET(DTL:KeyDetails,DTL:KeyDetails)
      LOOP
        IF Access:Detail.Next()
          IF Access:Detail.GetEOF()
            BREAK
          ELSE
            POST(EVENT:CloseWindow)
            EXIT
          END
        END
        IF UPPER(DTL:CustNumber) <> UPPER(ORD:CustNumber) THEN BREAK.
        IF UPPER(DTL:OrderNumber) <> UPPER(ORD:OrderNumber) THEN BREAK.
        REL1::Level = -2
        BREAK
      END
      DO REL1::Format:Orders
      ADD(Queue:RelTree,POINTER(Queue:RelTree)+1)
    ELSE
      IF REL1::LoadAll
        ADD(REL1::LoadedQueue,REL1::LoadedLevel,REL1::LoadedPosition)
      END
      REL1::Level = 2
      REL1::Loaded = True
      DO REL1::Format:Orders
      ADD(Queue:RelTree,POINTER(Queue:RelTree)+1)
      DO REL1::Load:Detail
    END
  END

!-------------------------------------------------------
REL1::Format:Orders ROUTINE
!|
!| This routine formats a line of the display queue Queue:RelTree to display the
!| contents of a record of Orders.
!|
!| First, the variable DisplayString is assigned the formatted value.
!|
!| Next, the queue variable REL1::Display is assigned the value in
!| DisplayString. It is possible for the display string to be reformatted in
!| the EMBED point "Relation Tree, Before Setting Display on Primary File".
!|
!| Next, any coloring done to the line is performed.
!|
!| Next, any icon assigments are made.
!|
  DisplayString = 'Invoice# ' & FORMAT(ORD:InvoiceNumber,@P######P) &', Order# ' & FORMAT(ORD:OrderNumber,@P#######P) & ', (' & LEFT(FORMAT(ORD:OrderDate,@D1)) & ')'
  REL1::Display = DisplayString
  REL1::NormalFG = 8388608
  REL1::NormalBG = -1
  REL1::SelectedFG = -1
  REL1::SelectedBG = -1
  REL1::Icon = 3
!---------------------------------------------------------------------------
REL1::Load:Detail ROUTINE
!|
!| This routine is used to load the base level of the RelationTree.
!|
!| Next, each record of the file Detail is read. If the record is not filtered,
!| the queue record that corresponds to this record is formatted and added to the queue
!| Queue:RelTree. This is done in the routine REL1::Format:Detail.
!|
  DTL:CustNumber = ORD:CustNumber
  DTL:OrderNumber = ORD:OrderNumber
  CLEAR(DTL:LineNumber)
  Access:Detail.UseFile
  SET(DTL:KeyDetails,DTL:KeyDetails)
  LOOP
    IF Access:Detail.Next()
      IF Access:Detail.GetEOF()
        BREAK
      ELSE
        POST(EVENT:CloseWindow)
        EXIT
      END
    END
    IF DTL:CustNumber <> ORD:CustNumber THEN BREAK.
    IF DTL:OrderNumber <> ORD:OrderNumber THEN BREAK.
    REL1::Loaded = 0
    REL1::Position = POSITION(Detail)
    REL1::Level = 3
    DO REL1::Format:Detail
    ADD(Queue:RelTree,POINTER(Queue:RelTree)+1)
  END

!-------------------------------------------------------
REL1::Format:Detail ROUTINE
!|
!| This routine formats a line of the display queue Queue:RelTree to display the
!| contents of a record of Detail.
!|
!| First, the variable DisplayString is assigned the formatted value.
!|
!| Next, the queue variable REL1::Display is assigned the value in
!| DisplayString. It is possible for the display string to be reformatted in
!| the EMBED point "Relation Tree, Before Setting Display on Primary File".
!|
!| Next, any coloring done to the line is performed.
!|
!| Next, any icon assigments are made.
!|
  CLEAR(DisplayString)
   PRO:ProductNumber = DTL:ProductNumber                   ! Move value for lookup
   Access:Products.Fetch(PRO:KeyProductNumber)             ! Get value from file
  !Format DisplayString
  DisplayString = CLIP(PRO:Description) & ' ('|
                  & CLIP(LEFT(FORMAT(DTL:QuantityOrdered,@N5))) & ' @ '|
                  & CLIP(LEFT(FORMAT(DTL:Price,@N$10.2))) & '), Tax = '|
                  & CLIP(LEFT(FORMAT(DTL:TaxPaid,@N$10.2))) & ', Discount = '|
                  & CLIP(LEFT(FORMAT(DTL:Discount,@N$10.2))) & ', ' & |
                  'Total Cost = '& LEFT(FORMAT(DTL:TotalCost,@N$14.2))
  REL1::Display = DisplayString
  IF DTL:BackOrdered = TRUE
    REL1::NormalFG = 255
    REL1::NormalBG = -1
    REL1::SelectedFG = -1
    REL1::SelectedBG = -1
  ELSE
    REL1::NormalFG = 32768
    REL1::NormalBG = -1
    REL1::SelectedFG = -1
    REL1::SelectedBG = -1
  END
  REL1::Icon = 4

REL1::AddEntry ROUTINE
  REL1::Action = InsertRecord
  DO REL1::UpdateLoop

REL1::EditEntry ROUTINE
  REL1::Action = ChangeRecord
  DO REL1::UpdateLoop

REL1::RemoveEntry ROUTINE
  REL1::Action = DeleteRecord
  DO REL1::UpdateLoop

REL1::UpdateLoop ROUTINE
  LOOP
    VCRRequest = VCR:None
    ?RelTree{PROPLIST:MouseDownRow} = CHOICE(?RelTree)
    CASE REL1::Action
      OF InsertRecord
        DO REL1::AddEntryServer
      OF DeleteRecord
        DO REL1::RemoveEntryServer
      OF ChangeRecord
        DO REL1::EditEntryServer
    END
    CASE VCRRequest
      OF VCR:Forward
        DO REL1::NextRecord
      OF VCR:Backward
        DO REL1::PreviousRecord
      OF VCR:PageForward
        DO REL1::NextLevel
      OF VCR:PageBackward
        DO REL1::PreviousLevel
      OF VCR:First
        DO REL1::PreviousParent
      OF VCR:Last
        DO REL1::NextParent
      OF VCR:Insert
        DO REL1::PreviousParent
        REL1::Action = InsertRecord
      OF VCR:None
        BREAK
    END
  END
!---------------------------------------------------------------------------
REL1::AddEntryServer ROUTINE
!|
!| This routine calls the RelationTree's update procedure to insert a new record.
!|
!| First, we see where the insert request comes from. Since no alert-key handling
!| is present for editing, ?RelTree{PropList:MouseDownRow} is all that is
!| necessary for editing, and we can rely on this property containing the
!| correct selection.
!|
!| Next, we retrieve the Queue:RelTree record that corresponds to the requested
!| insert row. The new record will be added to the RelationTree level BELOW
!| the requested insert row. To add a first-level record, the RelationTree
!| header must be selected for the insert.
!|
!| Next, the record is cleared, and any related values are primed.
!|
!| Next, GlobalRequest is set to InsertRecord, and the appropriate update procedure
!| is called.
!|
!| Finally, if the insert is successful (GlobalRequest = RequestCompleted) then the
!| RelationTree is refreshed, and the newly inserted record highlighted.
!|
  IF ?Insert{Prop:Disable}
    EXIT
  END
  REL1::CurrentChoice = ?RelTree{PropList:MouseDownRow}
  GET(Queue:RelTree,REL1::CurrentChoice)
  CASE ABS(REL1::Level)
  OF 0
    Access:Customers.PrimeRecord
    GlobalRequest = InsertRecord
    UpdateCustomers
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 1
      REL1::NewItemPosition = POSITION(Detail)
      DO REL1::RefreshTree
    END
  OF 1
    REGET(Customers,REL1::Position)
    GET(Orders,0)
    CLEAR(Orders)
    ORD:CustNumber = CUS:CustNumber
    Access:Orders.PrimeRecord(1)
    GlobalRequest = InsertRecord
    UpdateOrders
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 2
      REL1::NewItemPosition = POSITION(Orders)
      DO REL1::RefreshTree
    END
  OF 2
  OROF 3
    LOOP WHILE ABS(REL1::Level) = 3
      REL1::CurrentChoice -= 1
      GET(Queue:RelTree,REL1::CurrentChoice)
    UNTIL ERRORCODE()
    REGET(Orders,REL1::Position)
    GET(Detail,0)
    CLEAR(Detail)
    DTL:CustNumber = ORD:CustNumber
    DTL:OrderNumber = ORD:OrderNumber
    Access:Detail.PrimeRecord(1)
    GlobalRequest = InsertRecord
    UpdateDetail
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 3
      REL1::NewItemPosition = POSITION(Detail)
      DO REL1::RefreshTree
    END
  END
!---------------------------------------------------------------------------
REL1::EditEntryServer ROUTINE
!|
!| This routine calls the RelationTree's update procedure to change a record.
!|
!| First, we see where the change request comes from. Since no alert-key handling
!| is present for editing, ?RelTree{PropList:MouseDownRow} is all that is
!| necessary for editing, and we can rely on this property containing the
!| correct selection.
!|
!| Next, we retrieve the Queue:RelTree record that corresponds to the requested
!| change row. and retrieve the appropriate record from disk.
!|
!| Next, GlobalRequest is set to ChangeRecord, and the appropriate update procedure
!| is called.
!|
!| Finally, if the change is successful (GlobalRequest = RequestCompleted) then the
!| RelationTree is refreshed, and the newly changed record highlighted.
!|
  IF ?Change{Prop:Disable}
    EXIT
  END
  REL1::CurrentChoice = ?RelTree{PropList:MouseDownRow}
  GET(Queue:RelTree,REL1::CurrentChoice)
  CASE ABS(REL1::Level)
  OF 1
    WATCH(Customers)
    REGET(Customers,REL1::Position)
    GlobalRequest = ChangeRecord
    UpdateCustomers
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 1
      REL1::NewItemPosition = POSITION(Customers)
      DO REL1::RefreshTree
    END
  OF 2
    WATCH(Orders)
    REGET(Orders,REL1::Position)
    GlobalRequest = ChangeRecord
    UpdateOrders
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 1
      REL1::NewItemPosition = POSITION(Orders)
      DO REL1::RefreshTree
    END
  OF 3
    WATCH(Detail)
    REGET(Detail,REL1::Position)
    GlobalRequest = ChangeRecord
    UpdateDetail
    IF GlobalResponse = RequestCompleted
      REL1::NewItemLevel = 1
      REL1::NewItemPosition = POSITION(Detail)
      DO REL1::RefreshTree
    END
  END
!---------------------------------------------------------------------------
REL1::RemoveEntryServer ROUTINE
!|
!| This routine calls the RelationTree's update procedure to delete a record.
!|
!| First, we see where the delete request comes from. Since no alert-key handling
!| is present for editing, ?RelTree{PropList:MouseDownRow} is all that is
!| necessary for editing, and we can rely on this property containing the
!| correct selection.
!|
!| Next, we retrieve the Queue:RelTree record that corresponds to the requested
!| delete row. and retrieve the appropriate record from disk.
!|
!| Next, GlobalRequest is set to DeleteRecord, and the appropriate update procedure
!| is called.
!|
!| Finally, if the change is successful (GlobalRequest = RequestCompleted) then the
!| RelationTree is refreshed, and the record below the deleted record is highlighted.
!|
  IF ?Delete{Prop:Disable}
    EXIT
  END
  REL1::CurrentChoice = ?RelTree{PropList:MouseDownRow}
  GET(Queue:RelTree,REL1::CurrentChoice)
  CASE ABS(REL1::Level)
  OF 1
    REGET(Customers,REL1::Position)
    GlobalRequest = DeleteRecord
    UpdateCustomers
    IF GlobalResponse = RequestCompleted
      DO REL1::RefreshTree
    END
  OF 2
    REGET(Orders,REL1::Position)
    GlobalRequest = DeleteRecord
    UpdateOrders
    IF GlobalResponse = RequestCompleted
      DO REL1::RefreshTree
    END
  OF 3
    REGET(Detail,REL1::Position)
    GlobalRequest = DeleteRecord
    UpdateDetail
    IF GlobalResponse = RequestCompleted
      DO REL1::RefreshTree
    END
  END
!---------------------------------------------------------------------------
REL1::RefreshTree ROUTINE
!|
!| This routine is used to refresh the RelationTree.
!|
!| First, the queue Queue:RelTree is FREEd. The display is always completely rebuilt.
!|
!| Next, the routine REL1::Load:Customers is called. This routine will
!| call any other routines necessary to rebuild the display.
!|
!| Finally, if a new item has been added (via REL1::AddEntry), then the
!| queue is searched for that entry, and the record is highlighted.
!|
  FREE(Queue:RelTree)
  DO REL1::Load:Customers
  IF REL1::NewItemLevel
    REL1::CurrentChoice = 0
    LOOP
      REL1::CurrentChoice += 1
      GET(Queue:RelTree,REL1::CurrentChoice)
      IF ERRORCODE() THEN BREAK.
      IF ABS(REL1::Level) <> ABS(REL1::NewItemLevel) THEN CYCLE.
      IF REL1::Position <> REL1::NewItemPosition THEN CYCLE.
      SELECT(?RelTree,REL1::CurrentChoice)
      BREAK
    END
  END
!---------------------------------------------------------------------------
REL1::ContractAll ROUTINE
!|
!| This routine re-initializes the RelationTree.
!|
!| The two queues used by the RelationTree (Queue:RelTree and REL1::LoadedQueue)
!| are FREEd, and the routine REL1::Load:Customers is called, which loads
!| the first level of the RelationTree.
!|
  FREE(Queue:RelTree)
  FREE(REL1::LoadedQueue)
  DO REL1::Load:Customers
!---------------------------------------------------------------------------
REL1::ExpandAll ROUTINE
!|
!| This routine expands every branch of the RelationTree.
!|
!| First, The two queues used by the RelationTree (Queue:RelTree and REL1::LoadedQueue)
!| are FREEd.
!|
!| Next, the variable REL1::LoadAll is set to true, and the routine REL1::Load:Customers
!| is called. Since REL1::LoadAll is True, all branches are completely loaded.
!|
  FREE(Queue:RelTree)
  FREE(REL1::LoadedQueue)
  REL1::LoadAll = True
  DO REL1::Load:Customers
  REL1::LoadAll = False

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseAllOrders')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?RelTree
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  DO REL1::ContractAll
  OPEN(window)                                             ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  window{PROP:MinWidth}=295                                ! Restrict the minimum window width
  window{PROP:MinHeight}=193                               ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  Toolbar.AddTarget(REL1::Toolbar, ?RelTree)
  DO REL1::AssignButtons
  ?RelTree{Prop:IconList,1} = '~File.ico'
  ?RelTree{Prop:IconList,2} = '~Folder.ico'
  ?RelTree{Prop:IconList,3} = '~Invoice.ico'
  ?RelTree{Prop:IconList,4} = '~star1.ico'
  ?RelTree{Prop:Selected} = 1
  ?RelTree{Prop:Alrt,255} = CtrlRight
  ?RelTree{Prop:Alrt,254} = CtrlLeft
  ?RelTree{Prop:Alrt,253} = MouseLeft2
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Customers.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Insert
      ThisWindow.Update
      ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
      DO REL1::AddEntry
    OF ?Change
      ThisWindow.Update
      ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
      DO REL1::EditEntry
    OF ?Delete
      ThisWindow.Update
      ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
      DO REL1::RemoveEntry
    OF ?Expand
      ThisWindow.Update
      ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
      DO REL1::ExpandAll
    OF ?Contract
      ThisWindow.Update
      ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
      DO REL1::ContractAll
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  CASE FIELD()
  OF ?RelTree
    CASE EVENT()                                                  
    ELSE
      CASE EVENT()
      OF Event:AlertKey
        CASE KEYCODE()
        OF CtrlRight
          ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
          POST(Event:Expanded,?RelTree)
        OF CtrlLeft
          ?RelTree{PropList:MouseDownRow} = CHOICE(?RelTree)
          POST(Event:Contracted,?RelTree)
        OF MouseLeft2
          DO REL1::EditEntry
        END
      END
    END
  END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?RelTree
    CASE EVENT()
    OF EVENT:Expanded
      DO REL1::LoadLevel
    OF EVENT:Contracted
      DO REL1::UnloadLevel
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNewSelection PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?RelTree
      IF KEYCODE() = MouseRight
        EXECUTE(POPUP('Insert|Change|Delete|-|&Expand All|Co&ntract All'))
          DO REL1::AddEntry
          DO REL1::EditEntry
          DO REL1::RemoveEntry
          DO REL1::ExpandAll
          DO REL1::ContractAll
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:GainFocus
      REL1::CurrentChoice = CHOICE(?RelTree)
      GET(Queue:RelTree,REL1::CurrentChoice)
      REL1::NewItemLevel = REL1::Level
      REL1::NewItemPosition = REL1::Position
      DO REL1::RefreshTree
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

REL1::Toolbar.TakeEvent PROCEDURE(<*LONG VCR>,WindowManager WM)
  CODE
  CASE ACCEPTED()
  OF Toolbar:Bottom TO Toolbar:Up
    SELF.Control{PROPLIST:MouseDownRow} = CHOICE(SELF.Control) !! Server routines assume this
    EXECUTE(ACCEPTED()-Toolbar:Bottom+1)
      DO REL1::NextParent
      DO REL1::PreviousParent
      DO REL1::NextLevel
      DO REL1::PreviousLevel
      DO REL1::NextRecord
      DO REL1::PreviousRecord
    END
  OF Toolbar:Insert TO Toolbar:Delete
    SELF.Control{PROPLIST:MouseDownRow} = CHOICE(SELF.Control) !! Server routines assume this
    EXECUTE(ACCEPTED()-Toolbar:Insert+1)
      DO REL1::AddEntry
      DO REL1::EditEntry
      DO REL1::RemoveEntry
    END
  ELSE
    PARENT.TakeEvent(VCR,ThisWindow)
  END

Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window


SelectProducts PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(Products)
                       PROJECT(PRO:Description)
                       PROJECT(PRO:ProductSKU)
                       PROJECT(PRO:Price)
                       PROJECT(PRO:QuantityInStock)
                       PROJECT(PRO:ProductNumber)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
PRO:Description        LIKE(PRO:Description)          !List box control field - type derived from field
PRO:ProductSKU         LIKE(PRO:ProductSKU)           !List box control field - type derived from field
PRO:Price              LIKE(PRO:Price)                !List box control field - type derived from field
PRO:QuantityInStock    LIKE(PRO:QuantityInStock)      !List box control field - type derived from field
PRO:ProductNumber      LIKE(PRO:ProductNumber)        !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Select a Product'),AT(,,236,134),FONT('MS Sans Serif',8,,),CENTER,IMM,ICON('ORCHID.ICO'),HLP('~SelectaProduct'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(2,0,231,132),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                           STRING(@s35),AT(46,116,76,10),USE(PRO:Description),FONT(,,COLOR:Red,FONT:bold)
                         END
                       END
                       LIST,AT(6,6,221,102),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('80L(1)|M~Description~@s35@48L(2)|M~Product SKU~L(0)@s10@32D(16)|M~Price~L(2)@n$1' &|
   '0.2B@59D(20)|M~Quantity In Stock~L(2)@n-10.2B@'),FROM(Queue:Browse:1)
                       BUTTON('&Select'),AT(41,19,25,13),USE(?Select:2),HIDE,FONT('MS Serif',8,COLOR:Black,),MSG('Select a Product from list'),TIP('Select a Product from list')
                       STRING('Locator:'),AT(7,114,39,12),USE(?String1),TRN,FONT('MS Serif',10,COLOR:Black,FONT:bold)
                       BUTTON,AT(45,43,13,13),USE(?Help),HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON('&Query'),AT(149,111,38,18),USE(?Query),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Query-By-Example')
                       BUTTON,AT(201,111,23,18),USE(?Close),SKIP,FLAT,MSG('Exit Browse'),TIP('Exit Browse and cancel selection'),ICON('EXITS.ICO')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
QBE5                 QueryFormClass                        ! QBE List Class. 
QBV5                 QueryFormVisual                       ! QBE Visual Class
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
                     END

BRW1::Sort0:Locator  IncrementalLocatorClass               ! Default Locator
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
  GlobalErrors.SetProcedureName('SelectProducts')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PRO:Description
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:Products.Open                                     ! File Products used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Products,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  ?Browse:1{Prop:LineHeight} = 0
  Do DefineListboxStyle
  QBE5.Init(QBV5, INIMgr,'SelectProducts', GlobalErrors)
  QBE5.QkSupport = True
  QBE5.QkMenuIcon = 'QkQBE.ico'
  QBE5.QkIcon = 'QkLoad.ico'
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon PRO:Description for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,PRO:KeyDescription) ! Add the sort order for PRO:KeyDescription for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?PRO:Description,PRO:Description,1,BRW1) ! Initialize the browse locator using ?PRO:Description using key: PRO:KeyDescription , PRO:Description
  BRW1.AddField(PRO:Description,BRW1.Q.PRO:Description)    ! Field PRO:Description is a hot field or requires assignment from browse
  BRW1.AddField(PRO:ProductSKU,BRW1.Q.PRO:ProductSKU)      ! Field PRO:ProductSKU is a hot field or requires assignment from browse
  BRW1.AddField(PRO:Price,BRW1.Q.PRO:Price)                ! Field PRO:Price is a hot field or requires assignment from browse
  BRW1.AddField(PRO:QuantityInStock,BRW1.Q.PRO:QuantityInStock) ! Field PRO:QuantityInStock is a hot field or requires assignment from browse
  BRW1.AddField(PRO:ProductNumber,BRW1.Q.PRO:ProductNumber) ! Field PRO:ProductNumber is a hot field or requires assignment from browse
  QuickWindow{PROP:MinWidth}=236                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=139                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.QueryControl = ?Query
  BRW1.Query &= QBE5
  QBE5.AddItem('UPPER(PRO:Description)','Product Description','@s30',1)
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Products.Close
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
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

UpdateDetail PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
CheckFlag            BYTE                                  !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
RecordChanged        BYTE,AUTO                             !
LOC:RegTotalPrice    DECIMAL(9,2)                          !
LOC:DiscTotalPrice   DECIMAL(9,2)                          !
LOC:QuantityAvailable DECIMAL(7,2)                         !Quantity available for sale
SAV:Quantity         DECIMAL(7,2)                          !
NEW:Quantity         DECIMAL(7,2)                          !
SAV:BackOrder        BYTE                                  !
ProductDescription   STRING(35)                            !
History::DTL:Record  LIKE(DTL:RECORD),THREAD
QuickWindow          WINDOW('Update Detail'),AT(,,193,119),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('NOTE14.ICO'),HLP('~UpdateDetail'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(3,2,187,116),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                           PROMPT('Product Number:'),AT(7,21),USE(?DTL:ProductNumber:Prompt)
                           ENTRY(@n07),AT(66,21,33,10),USE(DTL:ProductNumber),MSG('Product Identification Number')
                           PROMPT('Description:'),AT(7,35),USE(?ProductDescription:Prompt)
                           STRING(@s35),AT(66,35,119,10),USE(ProductDescription)
                         END
                       END
                       PROMPT('Line Number:'),AT(7,7),USE(?DTL:LineNumber:Prompt)
                       STRING(@n04),AT(66,7,29,10),USE(DTL:LineNumber)
                       BUTTON('Select Product'),AT(112,17,68,14),USE(?CallLookup),IMM,FONT('MS Serif',8,COLOR:Navy,FONT:bold),ICON(ICON:None)
                       PROMPT('Quantity Ordered:'),AT(7,48),USE(?DTL:QuantityOrdered:Prompt)
                       SPIN(@n9.2B),AT(65,48,33,10),USE(DTL:QuantityOrdered),MSG('Quantity of product ordered'),RANGE(1,99999)
                       PROMPT('Price:'),AT(117,48,19,10),USE(?DTL:Price:Prompt)
                       STRING(@n$10.2B),AT(136,48,41,10),USE(DTL:Price)
                       PROMPT('Tax Rate:'),AT(7,62),USE(?DTL:TaxRate:Prompt)
                       ENTRY(@n7.4B),AT(65,62,33,10),USE(DTL:TaxRate),MSG('Enter Consumer''s Tax rate')
                       STRING('%'),AT(99,61,13,10),USE(?String3),FONT('MS Sans Serif',11,,FONT:bold)
                       PROMPT('Discount Rate:'),AT(7,77),USE(?DTL:DiscountRate:Prompt)
                       ENTRY(@n7.4B),AT(65,77,33,10),USE(DTL:DiscountRate),MSG('Enter discount rate')
                       STRING('%'),AT(99,77,13,10),USE(?String4),FONT('MS Sans Serif',11,,FONT:bold)
                       CHECK('Back Ordered'),AT(117,62),USE(DTL:BackOrdered),DISABLE,COLOR(COLOR:Silver),MSG('Product is on back order')
                       BUTTON,AT(53,95,22,20),USE(?OK),FLAT,TIP('Save record and Exit'),ICON('DISK12.ICO'),DEFAULT
                       BUTTON,AT(86,100,13,12),USE(?Help),FLAT,HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(110,95,22,20),USE(?Cancel),FLAT,MSG('Cancel changes and Exit'),TIP('Cancel changes and Exit'),ICON(ICON:Cross)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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
!Calculate taxes, discounts, and total cost
!----------------------------------------------------------------------
CalcValues  ROUTINE
  IF DTL:TaxRate = 0 THEN
    IF DTL:DiscountRate = 0 THEN
      DTL:TotalCost = DTL:Price * |
                                             DTL:QuantityOrdered
    ELSE
      LOC:RegTotalPrice = DTL:Price * DTL:QuantityOrdered
      DTL:Discount = LOC:RegTotalPrice * |
                                             DTL:DiscountRate / 100
      DTL:TotalCost = LOC:RegTotalPrice - DTL:Discount
      DTL:Savings = LOC:RegTotalPrice - DTL:TotalCost
    END
  ELSE
    IF DTL:DiscountRate = 0 THEN
      LOC:RegTotalPrice = DTL:Price * DTL:QuantityOrdered
      DTL:TaxPaid = LOC:RegTotalPrice * DTL:TaxRate / 100
      DTL:TotalCost = LOC:RegTotalPrice + DTL:TaxPaid
    ELSE
      LOC:RegTotalPrice = DTL:Price * DTL:QuantityOrdered
      DTL:Discount = LOC:RegTotalPrice * |
                                             DTL:DiscountRate / 100
      LOC:DiscTotalPrice = LOC:RegTotalPrice - DTL:Discount
      DTL:TaxPaid = LOC:DiscTotalPrice * DTL:TaxRate / 100
      DTL:TotalCost = LOC:DiscTotalPrice + DTL:TaxPaid
      DTL:Savings = LOC:RegTotalPrice - DTL:TotalCost
    END
  END
!Update InvHist and Products files
!-----------------------------------------------------------------------
UpdateOtherFiles ROUTINE

 PRO:ProductNumber = DTL:ProductNumber
 Access:Products.TryFetch(PRO:KeyProductNumber)
 CASE ThisWindow.Request
 OF InsertRecord
   IF DTL:BackOrdered = FALSE
     PRO:QuantityInStock -= DTL:QuantityOrdered
     IF Access:Products.Update() <> Level:Benign
       STOP(ERROR())
     END !end if
     INV:Date = TODAY()
     INV:ProductNumber = DTL:ProductNumber
     INV:TransType = 'Sale'
     INV:Quantity =- DTL:QuantityOrdered
     INV:Cost = PRO:Cost
     INV:Notes = 'New purchase'
     IF Access:InvHist.Insert() <> Level:Benign
       STOP(ERROR())
     END !end if
   END !end if
 OF ChangeRecord
   IF SAV:BackOrder = FALSE
     PRO:QuantityInStock += SAV:Quantity
     PRO:QuantityInStock -= NEW:Quantity
     IF Access:Products.Update() <> Level:Benign
       STOP(ERROR())
     END
     InvHist.Date = TODAY()
     INV:ProductNumber = DTL:ProductNumber
     INV:TransType = 'Adj.'
     INV:Quantity = (SAV:Quantity - NEW:Quantity)
     INV:Notes = 'Change in quantity purchased'
     IF Access:InvHist.Insert() <> Level:Benign
       STOP(ERROR())
     END !end if
   ELSIF SAV:BackOrder = TRUE AND DTL:BackOrdered = FALSE
     PRO:QuantityInStock -= DTL:QuantityOrdered
     IF Access:Products.Update() <> Level:Benign
       STOP(ERROR())
     END !end if
     INV:Date = TODAY()
     INV:ProductNumber = DTL:ProductNumber
     INV:TransType = 'Sale'
     INV:Quantity =- DTL:QuantityOrdered
     INV:Cost = PRO:Cost
     INV:Notes = 'New purchase'
     IF Access:InvHist.Insert() <> Level:Benign
       STOP(ERROR())
     END !end if
   END ! end if elsif
 OF DeleteRecord
   IF SAV:BackOrder = FALSE
     PRO:QuantityInStock += DTL:QuantityOrdered
     IF Access:Products.Update() <> Level:Benign
       STOP(ERROR())
     END
     INV:Date = TODAY()
     INV:ProductNumber = DTL:ProductNumber
     INV:TransType = 'Adj.'
     INV:Quantity =+ DTL:QuantityOrdered
     INV:Notes = 'Cancelled Order'
     IF Access:InvHist.Insert() <> Level:Benign
       STOP(ERROR())
     END  !End if
   END !End if
 END !End case

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a Detail Record'
  OF ChangeRecord
    ActionMessage = 'Changing a Detail Record'
  OF DeleteRecord
    ActionMessage = 'Deleting a Detail Record'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateDetail')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?DTL:ProductNumber:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  !Initializing a variable
  SAV:Quantity = DTL:QuantityOrdered
  SAV:BackOrder = DTL:BackOrdered
  CheckFlag = False
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(DTL:Record,History::DTL:Record)
  SELF.AddHistoryField(?DTL:ProductNumber,4)
  SELF.AddHistoryField(?DTL:LineNumber,3)
  SELF.AddHistoryField(?DTL:QuantityOrdered,5)
  SELF.AddHistoryField(?DTL:Price,7)
  SELF.AddHistoryField(?DTL:TaxRate,8)
  SELF.AddHistoryField(?DTL:DiscountRate,10)
  SELF.AddHistoryField(?DTL:BackOrdered,6)
  SELF.AddUpdateFile(Access:Detail)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Detail.Open                                       ! File Detail used by this procedure, so make sure it's RelationManager is open
  Relate:InvHist.Open                                      ! File InvHist used by this procedure, so make sure it's RelationManager is open
  Relate:Products.Open                                     ! File Products used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Detail
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:Query
    SELF.DeleteAction = Delete:Form                        ! Display form on delete
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  IF ThisWindow.Request = ChangeRecord OR ThisWindow.Request = DeleteRecord
    PRO:ProductNumber = DTL:ProductNumber
    Access:Products.TryFetch(PRO:KeyProductNumber)
    ProductDescription = PRO:Description
  END
  Do DefineListboxStyle
  QuickWindow{PROP:MinWidth}=191                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=112                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Detail.Close
    Relate:InvHist.Close
    Relate:Products.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SelectProducts
    ReturnValue = GlobalResponse
  END
  ! After lookup and out of stock message
  IF GlobalResponse = RequestCompleted
    DTL:ProductNumber = PRO:ProductNumber
    ProductDescription = PRO:Description
    DTL:Price = PRO:Price
    LOC:QuantityAvailable = PRO:QuantityInStock
    DISPLAY
    IF LOC:QuantityAvailable <= 0
      CASE MESSAGE('Yes for BACKORDER or No for CANCEL',|
                   'OUT OF STOCK: Select Order Options',ICON:Question,|
                      BUTTON:Yes+BUTTON:No,BUTTON:Yes,1)
      OF BUTTON:Yes
        DTL:BackOrdered = TRUE
        DISPLAY
        SELECT(?DTL:QuantityOrdered)
      OF BUTTON:No
        IF ThisWindow.Request = InsertRecord
          ThisWindow.Response = RequestCancelled
          Access:Detail.CancelAutoInc
          POST(EVENT:CloseWindow)
        END !If
      END !end case
    END !end if
    IF ThisWindow.Request = ChangeRecord
      IF DTL:QuantityOrdered < LOC:QuantityAvailable
        DTL:BackOrdered = FALSE
        DISPLAY
      ELSE
        DTL:BackOrdered = TRUE
        DISPLAY
      END !end if
    END !end if
    IF ProductDescription = ''
      CLEAR(DTL:Price)
      SELECT(?CallLookup)
    END
    SELECT(?DTL:QuantityOrdered)
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?DTL:ProductNumber
      IF Access:Detail.TryValidateField(4)                 ! Attempt to validate DTL:ProductNumber in Detail
        SELECT(?DTL:ProductNumber)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?DTL:ProductNumber
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?DTL:ProductNumber{Prop:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?CallLookup
      ThisWindow.Update
      PRO:ProductNumber = DTL:ProductNumber
      IF SELF.Run(1,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        DTL:ProductNumber = PRO:ProductNumber
      END
      ThisWindow.Reset(1)
    OF ?DTL:QuantityOrdered
      IF Access:Detail.TryValidateField(5)                 ! Attempt to validate DTL:QuantityOrdered in Detail
        SELECT(?DTL:QuantityOrdered)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?DTL:QuantityOrdered
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?DTL:QuantityOrdered{Prop:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
      !Initializing a variable
      NEW:Quantity = DTL:QuantityOrdered
       !Low stock message
      IF CheckFlag = FALSE
        IF LOC:QuantityAvailable > 0
          IF DTL:QuantityOrdered > LOC:QuantityAvailable
            CASE MESSAGE('Yes for BACKORDER or No for CANCEL',|
                           'LOW STOCK: Select Order Options',ICON:Question,|
                             BUTTON:Yes+BUTTON:No,BUTTON:Yes,1)
            OF BUTTON:Yes
              DTL:BackOrdered = TRUE
              DISPLAY
            OF BUTTON:No
              IF ThisWindow.Request = InsertRecord
                ThisWindow.Response = RequestCancelled
                Access:Detail.CancelAutoInc
                POST(EVENT:CloseWindow)
              END !
            END !end case
          ELSE
            DTL:BackOrdered = FALSE
            DISPLAY
          END !end if Detail
        END !End if LOC:
        IF ThisWindow.Request = ChangeRecord
          IF DTL:QuantityOrdered <= LOC:QuantityAvailable
            DTL:BackOrdered = FALSE
            DISPLAY
          ELSE
            DTL:BackOrdered = TRUE
            DISPLAY
          END !end if
        END !end if
        CheckFlag = TRUE
      END !end if
    OF ?OK
      ThisWindow.Update
      !Calculate all totals
      DO CalcValues
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeCompleted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
   !Updating other files
    DO UpdateOtherFiles
  ReturnValue = PARENT.TakeCompleted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?DTL:ProductNumber
      PRO:ProductNumber = DTL:ProductNumber
      IF Access:Products.TryFetch(PRO:KeyProductNumber)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          DTL:ProductNumber = PRO:ProductNumber
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

UpdateOrders PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
RecordChanged        BYTE,AUTO                             !
LOC:BackOrdered      STRING(3)                             !
LOC:TotalPrice       DECIMAL(9,2)                          !
History::ORD:Record  LIKE(ORD:RECORD),THREAD
QuickWindow          WINDOW('Update Order'),AT(,,275,163),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('NOTE14.ICO'),HLP('~UpdateOrder'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(3,2,269,159),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                         END
                       END
                       PROMPT('Order Date:'),AT(8,7),USE(?ORD:OrderDate:Prompt)
                       STRING(@d1),AT(63,7,41,10),USE(ORD:OrderDate)
                       PROMPT('Invoice Number:'),AT(131,7,57,10),USE(?ORD:InvoiceNumber:Prompt)
                       STRING(@n07),AT(197,7),USE(ORD:InvoiceNumber)
                       CHECK('Same Name As Customer''s'),AT(63,18,113,10),USE(ORD:SameName),MSG('ShipTo name same as Customer''s')
                       PROMPT('Ship To Name:'),AT(8,31),USE(?ORD:ShipToName:Prompt)
                       ENTRY(@s45),AT(63,31,176,10),USE(ORD:ShipToName),MSG('Customer the order is shipped to'),CAP
                       CHECK('Same  Address As Customer''s'),AT(63,44,113,10),USE(ORD:SameAdd),MSG('Ship to address same as customer''s')
                       PROMPT('Ship Address 1:'),AT(8,58),USE(?ORD:ShipAddress1:Prompt)
                       ENTRY(@s35),AT(63,58,144,10),USE(ORD:ShipAddress1),MSG('1st Line of ship address'),CAP
                       PROMPT('Ship Address 2:'),AT(8,71),USE(?ORD:ShipAddress2:Prompt)
                       ENTRY(@s35),AT(63,73,144,10),USE(ORD:ShipAddress2),MSG('2nd line of ship address'),CAP
                       PROMPT('Ship City:'),AT(8,87),USE(?ORD:ShipCity:Prompt)
                       ENTRY(@s25),AT(63,87,104,10),USE(ORD:ShipCity),MSG('City of Ship address'),CAP
                       PROMPT('Ship State:'),AT(8,103),USE(?ORD:ShipState:Prompt)
                       ENTRY(@s2),AT(63,103,25,10),USE(ORD:ShipState),MSG('State to ship to'),UPR
                       PROMPT('Ship Zip:'),AT(96,103,33,10),USE(?ORD:ShipZip:Prompt)
                       ENTRY(@K#####|-####KB),AT(131,103,60,10),USE(ORD:ShipZip),MSG('ZipCode of ship city')
                       CHECK('Order Shipped'),AT(205,103,59,10),USE(ORD:OrderShipped),MSG('Checked if order is shipped')
                       PROMPT('Order Note:'),AT(8,119),USE(?ORD:OrderNote:Prompt)
                       ! ENTRY(@s80),AT(63,119,204,10),USE(ORD:OrderNote),SCROLL,MSG('Additional Information about order') %%%%%%%%%%%
                       ! unknown SCROLL %%%%%%%%%%%%%
                       ENTRY(@s80),AT(63,119,204,10),USE(ORD:OrderNote),MSG('Additional Information about order') ! %%%%%%%%%%%

                       BUTTON,AT(99,137,20,19),USE(?OK),FLAT,LEFT,MSG('Save  record and Exit'),TIP('Save  record and Exit'),ICON('DISK12.ICO'),DEFAULT
                       BUTTON,AT(133,139,13,14),USE(?Help),FLAT,HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(159,137,20,19),USE(?Cancel),FLAT,MSG('Cancel changes and Exit'),TIP('Cancel changes and Exit'),ICON(ICON:Cross)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
PrimeFields            PROCEDURE(),PROC,DERIVED            ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a Orders Record'
  OF ChangeRecord
    ActionMessage = 'Changing a Orders Record'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateOrders')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ORD:OrderDate:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(ORD:Record,History::ORD:Record)
  SELF.AddHistoryField(?ORD:OrderDate,4)
  SELF.AddHistoryField(?ORD:InvoiceNumber,3)
  SELF.AddHistoryField(?ORD:SameName,5)
  SELF.AddHistoryField(?ORD:ShipToName,6)
  SELF.AddHistoryField(?ORD:SameAdd,7)
  SELF.AddHistoryField(?ORD:ShipAddress1,8)
  SELF.AddHistoryField(?ORD:ShipAddress2,9)
  SELF.AddHistoryField(?ORD:ShipCity,10)
  SELF.AddHistoryField(?ORD:ShipState,11)
  SELF.AddHistoryField(?ORD:ShipZip,12)
  SELF.AddHistoryField(?ORD:OrderShipped,13)
  SELF.AddHistoryField(?ORD:OrderNote,14)
  SELF.AddUpdateFile(Access:Orders)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:InvHist.Open                                      ! File InvHist used by this procedure, so make sure it's RelationManager is open
  Relate:Orders.Open                                       ! File Orders used by this procedure, so make sure it's RelationManager is open
  Relate:States.Open                                       ! File States used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Orders
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  QuickWindow{PROP:MinWidth}=275                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=157                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:InvHist.Close
    Relate:Orders.Close
    Relate:States.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
    ORD:ShipToName = CLIP(CUS:FirstName)&' '&CLIP(CUS:LastName)
    ORD:ShipAddress1 = CUS:Address1
    ORD:ShipAddress2 = CUS:Address2
    ORD:ShipCity = CUS:City
    ORD:ShipState = CUS:State
    ORD:ShipZip = CUS:ZipCode
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  CUS:CustNumber = ORD:CustNumber                          ! Assign linking field value
  Access:Customers.Fetch(CUS:KeyCustNumber)
  STA:StateCode = ORD:ShipState                            ! Assign linking field value
  Access:States.Fetch(STA:StateCodeKey)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    SelectStates
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?ORD:SameName
      !Actions on Update record
      IF Orders.Record.SameName = TRUE
        CUS:CustNumber=ORD:CustNumber
        Access:Customers.Fetch(CUS:KeyCustNumber)
        ORD:ShipToName = CLIP(CUS:FirstName)&' '&CLIP(CUS:LastName)
        DISPLAY
        DISABLE(?ORD:ShipToName)
        SELECT(?ORD:SameAdd)
      ELSE
        ENABLE(?ORD:ShipToName)
        SELECT(?ORD:ShipToName)
      END
    OF ?ORD:SameAdd
      !Actions on Update Record
      IF Orders.Record.SameAdd = TRUE
        DISABLE(?ORD:ShipAddress1)
        DISABLE(?ORD:ShipAddress2)
        DISABLE(?ORD:ShipCity)
        DISABLE(?ORD:ShipState)
        DISABLE(?ORD:ShipZip)
        SELECT(?ORD:OrderShipped)
      ELSE
        ENABLE(?ORD:ShipAddress1)
        ENABLE(?ORD:ShipAddress2)
        ENABLE(?ORD:ShipCity)
        ENABLE(?ORD:ShipState)
        ENABLE(?ORD:ShipZip)
        SELECT(?ORD:ShipAddress1)
      END
    OF ?ORD:ShipState
      STA:StateCode = ORD:ShipState
      IF Access:States.TryFetch(STA:StateCodeKey)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          ORD:ShipState = STA:StateCode
        ELSE
          SELECT(?ORD:ShipState)
          CYCLE
        END
      END
      ThisWindow.Reset(0)
      IF Access:Orders.TryValidateField(11)                ! Attempt to validate ORD:ShipState in Orders
        SELECT(?ORD:ShipState)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?ORD:ShipState
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?ORD:ShipState{Prop:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?ORD:SameName
      !Actions on Change record
      IF SELF.Request = ChangeRecord
        IF ORD:SameName = FALSE
          DISABLE(?ORD:SameName)
          SELECT(?ORD:ShipToName)
        ELSE
          ENABLE(?ORD:SameName)
          SELECT(?ORD:SameName)
        END
      END
    OF ?ORD:SameAdd
      !Actions on change record
      IF SELF.Request = ChangeRecord
        IF ORD:SameAdd = FALSE
          DISABLE(?ORD:SameAdd)
          SELECT(?ORD:ShipAddress1)
        ELSE
          ENABLE(?ORD:SameAdd)
          SELECT(?ORD:SameAdd)
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

Main PROCEDURE                                             ! Generated from procedure template - Frame

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
CurrentTab           STRING(80)                            !
SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
!AppFrame             APPLICATION('Order Entry & Invoice Manager'),AT(,,437,327),FONT('MS Sans Serif',8,,),CENTER,ICON('ORDER.ICO'),HLP('~MainToolBar'),ALRT(F3Key),ALRT(F4Key),ALRT(F5Key),STATUS(-1,80,120,45),WALLPAPER('Invoice.bmp'),TILED,SYSTEM,MAX,RESIZE,IMM
! %%%%%%%%%%%%%%  Not recognized WALLPAPER('Invoice.bmp'), removed!
AppFrame             APPLICATION('Order Entry & Invoice Manager'),AT(,,437,327),FONT('MS Sans Serif',8,,),CENTER,ICON('ORDER.ICO'),HLP('~MainToolBar'),ALRT(F3Key),ALRT(F4Key),ALRT(F5Key),STATUS(-1,80,120,45),TILED,SYSTEM,MAX,RESIZE,IMM

                       MENUBAR
                         MENU('&File')
                           ITEM('&Print Setup ...'),USE(?PrintSetup),MSG('Setup printer'),STD(STD:PrintSetup)
                           ITEM,SEPARATOR
                           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Edit')
                           ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('&Browse')
                           !%%%% Do not know how to rewrite:key near line:2525, did not recognize KEY(), removed!
                           ! ITEM('Customer''s Information'),USE(?BrowseCustomers),MSG('Browse Customer''s Information'),KEY(F3Key)  %%%%%%%%%
                           ITEM('Customer''s Information'),USE(?BrowseCustomers),MSG('Browse Customer''s Information')
                           ! ITEM('All Customer''s Orders'),USE(?BrowseAllOrders),MSG('Browse All Orders'),KEY(F4Key) %%%%%%%
                           ITEM('All Customer''s Orders'),USE(?BrowseAllOrders),MSG('Browse All Orders')
                           !  ITEM('Product''s Information'),USE(?BrowseProducts),MSG('Browse Product''s Information'),KEY(F5Key) %%%%%%%
                           ITEM('Product''s Information'),USE(?BrowseProducts),MSG('Browse Product''s Information')
                         END
                         MENU('&Reports'),USE(?ReportMenu),MSG('Report data')
                           ITEM('Print Invoice'),USE(?ReportsPrintInvoice),MSG('Print Customer''s Invoice')
                           ITEM('Print Mailing Labels'),USE(?ReportsPrintMailingLabels),MSG('Print mailing labels for customer''s')
                           ITEM,SEPARATOR
                           ITEM('Select CWRW Report'),USE(?ReportsSelectCWRWReport)
                           ITEM,SEPARATOR
                           ITEM('Print Products Information'),USE(?PrintPRO:KeyProductSKU),MSG('Print ordered by the PRO:KeyProductSKU key')
                           ITEM('Print Customer''s Information'),USE(?PrintCUS:StateKey),MSG('Print ordered by the CUS:Statekey')
                         END
                         MENU('&Maintenance'),USE(?Maintenance)
                           ITEM('&Update Company File'),USE(?UpdateCompanyFile)
                         END
                         MENU('&Window'),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Help'),MSG('Windows Help')
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                       END
                       TOOLBAR,AT(0,0,400,19)
                         BUTTON,AT(279,2,16,14),USE(?Exit:2),FLAT,TIP('Exit Application'),ICON('EXITS.ICO'),STD(STD:Close)
                         BUTTON,AT(19,2,16,14),USE(?OrdButton),FLAT,TIP('Browse All Customer''s Orders'),ICON('BOOKS.ICO')
                         BUTTON,AT(35,2,16,14),USE(?ProButton),FLAT,TIP('Browse Products Information'),ICON('FLOW04.ICO')
                         BUTTON,AT(3,2,16,14),USE(?CusButton),FLAT,MSG('Browse Customer Information'),TIP('Browse Customer Information'),ICON('CUSTOMER.ICO')
                         BUTTON,AT(256,2,16,14),USE(?Toolbar:Help,Toolbar:Help),DISABLE,FLAT,TIP('Get Help'),ICON('HELP.ICO')
                         BUTTON,AT(240,2,16,14),USE(?Toolbar:History,Toolbar:History),DISABLE,FLAT,TIP('Previous value'),ICON('DITTO.ICO')
                         BUTTON,AT(220,2,16,14),USE(?Toolbar:Delete,Toolbar:Delete),DISABLE,FLAT,TIP('Delete This Record'),ICON('DELETE.ICO')
                         BUTTON,AT(204,2,16,14),USE(?Toolbar:Change,Toolbar:Change),DISABLE,FLAT,TIP('Edit This Record'),ICON('EDIT.ICO')
                         BUTTON,AT(188,2,16,14),USE(?Toolbar:Insert,Toolbar:Insert),DISABLE,FLAT,TIP('Insert a New Record'),ICON('INSERT.ICO')
                         BUTTON,AT(172,2,16,14),USE(?Toolbar:Select,Toolbar:Select),DISABLE,FLAT,TIP('Select This Record'),ICON('MARK.ICO')
                         BUTTON,AT(152,2,16,14),USE(?Toolbar:Bottom,Toolbar:Bottom),DISABLE,FLAT,TIP('Go to the Last Page'),ICON('VCRLAST.ICO')
                         BUTTON,AT(136,2,16,14),USE(?Toolbar:PageDown,Toolbar:PageDown),DISABLE,FLAT,TIP('Go to the Next Page'),ICON('VCRNEXT.ICO')
                         BUTTON,AT(120,2,16,14),USE(?Toolbar:Down,Toolbar:Down),DISABLE,FLAT,TIP('Go to the Next Record'),ICON('VCRDOWN.ICO')
                         BUTTON,AT(104,2,16,14),USE(?Toolbar:Locate,Toolbar:Locate),DISABLE,FLAT,TIP('Locate record'),ICON('FIND.ICO')
                         BUTTON,AT(88,2,16,14),USE(?Toolbar:Up,Toolbar:Up),DISABLE,FLAT,TIP('Go to the Prior Record'),ICON('VCRUP.ICO')
                         BUTTON,AT(72,2,16,14),USE(?Toolbar:PageUp,Toolbar:PageUp),DISABLE,FLAT,TIP('Go to the Prior Page'),ICON('VCRPRIOR.ICO')
                         BUTTON,AT(56,2,16,14),USE(?Toolbar:Top,Toolbar:Top),DISABLE,FLAT,TIP('Go to the First Page'),ICON('VCRFIRST.ICO')
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------
Menu::ReportMenu ROUTINE                                   ! Code for menu items on ?ReportMenu
  CASE ACCEPTED()
  OF ?ReportsPrintInvoice
    START(PrintInvoice, 50000)
  OF ?ReportsPrintMailingLabels
    START(PrintMailingLabels, 50000)
  OF ?ReportsSelectCWRWReport
    !
    IF RE.LoadReportLibrary('Invoice.txr') then   ! load report library
      RE.SetPreview()                             ! preview all pages
      RE.PrintReport(0)                           ! select report to preview/print
      RE.UnloadReportLibrary
    END
  OF ?PrintPRO:KeyProductSKU
    START(PrintPRO:KeyProductSKU, 050000)
  OF ?PrintCUS:StateKey
    START(PrintCUS:StateKey, 050000)
  END
Menu::Maintenance ROUTINE                                  ! Code for menu items on ?Maintenance
  CASE ACCEPTED()
  OF ?UpdateCompanyFile
    GlobalRequest = ChangeRecord
    UpdateCompany
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{Prop:Timer},1,100)
    AppFrame{Prop:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
    AppFrame{Prop:StatusText,4} = FORMAT(CLOCK(),@T3)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  OPEN(AppFrame)                                           ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  System{Prop:Icon}='~Order.ico'
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?Toolbar:Help
    OROF ?Toolbar:History
    OROF ?Toolbar:Delete
    OROF ?Toolbar:Change
    OROF ?Toolbar:Insert
    OROF ?Toolbar:Select
    OROF ?Toolbar:Bottom
    OROF ?Toolbar:PageDown
    OROF ?Toolbar:Down
    OROF ?Toolbar:Locate
    OROF ?Toolbar:Up
    OROF ?Toolbar:PageUp
    OROF ?Toolbar:Top
      IF SYSTEM{PROP:Active} <> THREAD()
        POST(EVENT:Accepted,ACCEPTED(),SYSTEM{Prop:Active} )
        CYCLE
      END
    ELSE
      DO Menu::ReportMenu                                  ! Process menu items on ?ReportMenu menu
      DO Menu::Maintenance                                 ! Process menu items on ?Maintenance menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BrowseCustomers
      START(BrowseCustomers, 050000)
    OF ?BrowseAllOrders
      START(BrowseAllOrders, 50000)
    OF ?BrowseProducts
      START(BrowseProducts, 50000)
    OF ?OrdButton
      START(BrowseAllOrders, 50000)
    OF ?ProButton
      START(BrowseProducts, 50000)
    OF ?CusButton
      START(BrowseCustomers, 50000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      ! Why it didnt like this? START() ? but we would like to keep SplashScreen defined in INVOIC003.CLW %%%%%%%%%%%%%
      ! Seems 5.5 START() not supposed to return anything, so lets get rid of that! %%%%%%%%%% 
      ! SplashProcedureThread = START(SplashScreen)          ! Run the splash window procedure
      START(SplashScreen)          ! Run the splash window procedure
    OF Event:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
      AppFrame{Prop:StatusText,4} = FORMAT(CLOCK(),@T3)
    ELSE
     ! we just comment out as having no SplashProcedureThread variable to check %%%%%%%%%%%%%
     ! IF SplashProcedureThread
     !   IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
     !   END
    ! END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

