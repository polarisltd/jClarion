

   MEMBER('musicdb6.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MUSIC003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('MUSIC005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('MUSIC006.INC'),ONCE        !Req'd for module callout resolution
                     END



Browsealbumn PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
SelMusician          LONG                                  !
BRW1::View:Browse    VIEW(albumn)
                       PROJECT(ALB:name)
                       PROJECT(ALB:year)
                       PROJECT(ALB:musician_id)
                       PROJECT(ALB:id)
                       JOIN(MUS:primarykey,ALB:musician_id)
                         PROJECT(MUS:name)
                         PROJECT(MUS:id)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
ALB:name               LIKE(ALB:name)                 !List box control field - type derived from field
ALB:year               LIKE(ALB:year)                 !List box control field - type derived from field
MUS:name               LIKE(MUS:name)                 !List box control field - type derived from field
ALB:musician_id        LIKE(ALB:musician_id)          !Browse hot field - type derived from field
ALB:id                 LIKE(ALB:id)                   !Primary key field - type derived from field
MUS:id                 LIKE(MUS:id)                   !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the albumn file'),AT(,,277,198),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,HLP('Browsealbumn'),SYSTEM,GRAY,RESIZE,MDI
                       LIST,AT(8,30,261,124),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing the albumn file'),FORMAT('126L(2)|M~Name~@s40@20R(2)|M~year~C(0)@n04@160L(2)|M~Musician~C(0)@s40@'),FROM(Queue:Browse:1)
                       BUTTON('&View'),AT(7,158,65,14),USE(?View:2),FLAT,LEFT,MSG('View Record'),TIP('View Record'),ICON('WAVIEW.ICO')
                       BUTTON('&Insert'),AT(72,158,65,14),USE(?Insert:3),FLAT,LEFT,MSG('Insert a Record'),TIP('Insert a Record'),ICON('WAINSERT.ICO')
                       BUTTON('&Change'),AT(136,158,70,14),USE(?Change:3),FLAT,LEFT,MSG('Change the Record'),TIP('Change the Record'),ICON('WACHANGE.ICO'),DEFAULT
                       BUTTON('&Delete'),AT(205,158,65,14),USE(?Delete:3),FLAT,LEFT,MSG('Delete the Record'),TIP('Delete the Record'),ICON('WADELETE.ICO')
                       SHEET,AT(4,4,269,172),USE(?CurrentTab)
                         TAB('&1) namekey'),USE(?Tab:3)
                         END
                         TAB('&2) musiciankey'),USE(?Tab:4)
                           BUTTON('Select Musician'),AT(4,180,86,14),USE(?Button7)
                         END
                       END
                       BUTTON('&Close'),AT(136,180,65,14),USE(?Close),FLAT,LEFT,MSG('Close Window'),TIP('Close Window'),ICON('WACLOSE.ICO')
                       BUTTON('&Help'),AT(205,180,65,14),USE(?Help),FLAT,LEFT,MSG('See Help Window'),TIP('See Help Window'),ICON('WAHELP.ICO'),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort2:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 2
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
  GlobalErrors.SetProcedureName('Browsealbumn')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('ALB:musician_id',ALB:musician_id)                  ! Added by: BrowseBox(ABC)
  BIND('SelMusician',SelMusician)                          ! Added by: BrowseBox(ABC)
  BIND('ALB:name',ALB:name)                                ! Added by: BrowseBox(ABC)
  BIND('ALB:year',ALB:year)                                ! Added by: BrowseBox(ABC)
  BIND('MUS:name',MUS:name)                                ! Added by: BrowseBox(ABC)
  BIND('ALB:id',ALB:id)                                    ! Added by: BrowseBox(ABC)
  BIND('MUS:id',MUS:id)                                    ! Added by: BrowseBox(ABC)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:albumn.Open                                       ! File albumn used by this procedure, so make sure it's RelationManager is open
  Access:musician.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:albumn,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,ALB:musiciankey)                      ! Add the sort order for ALB:musiciankey for sort order 1
  BRW1.AddRange(ALB:musician_id,SelMusician)               ! Add single value range limit for sort order 1
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort2:Locator.Init(,ALB:year,1,BRW1)               ! Initialize the browse locator using  using key: ALB:musiciankey , ALB:year
  BRW1.SetFilter('(ALB:musician_id=SelMusician)')          ! Apply filter expression to browse
  BRW1.AddSortOrder(,ALB:namekey)                          ! Add the sort order for ALB:namekey for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(,ALB:name,1,BRW1)               ! Initialize the browse locator using  using key: ALB:namekey , ALB:name
  BRW1.AddResetField(SelMusician)                          ! Apply the reset field
  BRW1.AddField(ALB:name,BRW1.Q.ALB:name)                  ! Field ALB:name is a hot field or requires assignment from browse
  BRW1.AddField(ALB:year,BRW1.Q.ALB:year)                  ! Field ALB:year is a hot field or requires assignment from browse
  BRW1.AddField(MUS:name,BRW1.Q.MUS:name)                  ! Field MUS:name is a hot field or requires assignment from browse
  BRW1.AddField(ALB:musician_id,BRW1.Q.ALB:musician_id)    ! Field ALB:musician_id is a hot field or requires assignment from browse
  BRW1.AddField(ALB:id,BRW1.Q.ALB:id)                      ! Field ALB:id is a hot field or requires assignment from browse
  BRW1.AddField(MUS:id,BRW1.Q.MUS:id)                      ! Field MUS:id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Browsealbumn',QuickWindow)                 ! Restore window settings from non-volatile store
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
    Relate:albumn.Close
  END
  IF SELF.Opened
    INIMgr.Update('Browsealbumn',QuickWindow)              ! Save window data to non-volatile store
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
    Updatealbumn
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
    OF ?Button7
      ThisWindow.Update
          GlobalRequest=SelectRecord
          selecTMusician
          if globalresponse=requestcompleted
              selMusician=mus:id
              ThisWindow.Reset
          .
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

