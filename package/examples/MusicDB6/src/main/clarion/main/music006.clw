

   MEMBER('musicdb6.clw')                                  ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('MUSIC006.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('MUSIC005.INC'),ONCE        !Req'd for module callout resolution
                     END


Updatealbumn PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::ALB:Record  LIKE(ALB:RECORD),THREAD
QuickWindow          WINDOW('Form albumn'),AT(,,233,98),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,HLP('Updatealbumn'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,225,72),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('name:'),AT(8,36),USE(?ALB:name:Prompt),TRN
                           ENTRY(@s40),AT(61,36,164,10),USE(ALB:name)
                           PROMPT('year:'),AT(8,50),USE(?ALB:year:Prompt),TRN
                           ENTRY(@n04),AT(61,50,40,10),USE(ALB:year),RIGHT(1)
                           STRING(@s40),AT(57,22),USE(MUS:name)
                           BUTTON('Lookup Musician'),AT(128,58,98,14),USE(?lookupmusician)
                           STRING('Musician:'),AT(9,22),USE(?String1)
                         END
                       END
                       BUTTON('&OK'),AT(17,80,70,14),USE(?OK),FLAT,LEFT,MSG('Accept data and close the window'),TIP('Accept data and close the window'),ICON('WAOK.ICO'),DEFAULT
                       BUTTON('&Cancel'),AT(88,80,70,14),USE(?Cancel),FLAT,LEFT,MSG('Cancel operation'),TIP('Cancel operation'),ICON('WACANCEL.ICO')
                       BUTTON('&Help'),AT(159,80,70,14),USE(?Help),FLAT,LEFT,MSG('See Help Window'),TIP('See Help Window'),ICON('WAHELP.ICO'),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
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
    ActionMessage = 'Record Will Be Added'
  OF ChangeRecord
    ActionMessage = 'Record Will Be Changed'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Updatealbumn')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ALB:name:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ALB:Record,History::ALB:Record)
  SELF.AddHistoryField(?ALB:name,2)
  SELF.AddHistoryField(?ALB:year,3)
  SELF.AddUpdateFile(Access:albumn)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:albumn.Open                                       ! File albumn used by this procedure, so make sure it's RelationManager is open
  Access:musician.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:albumn
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
      if ALB:musician_id<>0
          mus:id=alb:musician_id
          access:musician.fetch(MUS:primarykey)
      else
          clear(mus:record)
      .
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?ALB:name{PROP:ReadOnly} = True
    ?ALB:year{PROP:ReadOnly} = True
    DISABLE(?lookupmusician)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Updatealbumn',QuickWindow)                 ! Restore window settings from non-volatile store
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
    Relate:albumn.Close
  END
  IF SELF.Opened
    INIMgr.Update('Updatealbumn',QuickWindow)              ! Save window data to non-volatile store
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
    OF ?lookupmusician
      ThisWindow.Update
      GlobalRequest = SelectRecord
      Selectmusician
      ThisWindow.Reset
          if globalresponse=requestcompleted
              ALB:musician_id=MUS:id
          .
    OF ?OK
      ThisWindow.Update
          if alb:musician_id=0
              post(event:accepted,?lookupmusician)
              cycle
          .
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
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
    OF EVENT:OpenWindow
          if alb:musician_id=0
              post(event:accepted,?lookupmusician)
          .
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

