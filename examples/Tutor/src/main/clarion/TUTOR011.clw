

   MEMBER('TUTOR.clw')                                     ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('TUTOR011.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('TUTOR013.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('TUTOR015.INC'),ONCE        !Req'd for module callout resolution
                     END



UpdateCUSTOMER PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
BRW2::View:Browse    VIEW(ORDERS)
                       PROJECT(ORD:CUSTNUMBER)
                       PROJECT(ORD:ORDERNUMBER)
                       PROJECT(ORD:INVOICEAMOUNT)
                       PROJECT(ORD:ORDERDATE)
                       PROJECT(ORD:ORDERNOTE)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?Browse:2
ORD:CUSTNUMBER         LIKE(ORD:CUSTNUMBER)           !List box control field - type derived from field
ORD:ORDERNUMBER        LIKE(ORD:ORDERNUMBER)          !List box control field - type derived from field
ORD:INVOICEAMOUNT      LIKE(ORD:INVOICEAMOUNT)        !List box control field - type derived from field
ORD:ORDERDATE          LIKE(ORD:ORDERDATE)            !List box control field - type derived from field
ORD:ORDERNOTE          LIKE(ORD:ORDERNOTE)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::CUS:Record  LIKE(CUS:RECORD),THREAD
QuickWindow          WINDOW('Form CUSTOMER'),AT(,,171,154),FONT('MS Sans Serif',8,,FONT:regular),CENTER,IMM,HLP('UpdateCUSTOMER'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(4,4,163,128),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('CUSTNUMBER:'),AT(8,20),USE(?CUS:CUSTNUMBER:Prompt),TRN
                           STRING(@n-14),AT(61,20,64,10),USE(CUS:CUSTNUMBER),TRN,RIGHT(1)
                           PROMPT('COMPANY:'),AT(8,34),USE(?CUS:COMPANY:Prompt),TRN
                           ENTRY(@s20),AT(61,34,84,10),USE(CUS:COMPANY)
                           PROMPT('FIRSTNAME:'),AT(8,48),USE(?CUS:FIRSTNAME:Prompt),TRN
                           ENTRY(@s20),AT(61,48,84,10),USE(CUS:FIRSTNAME)
                           PROMPT('LASTNAME:'),AT(8,62),USE(?CUS:LASTNAME:Prompt),TRN
                           ENTRY(@s20),AT(61,62,84,10),USE(CUS:LASTNAME)
                           PROMPT('ADDRESS:'),AT(8,76),USE(?CUS:ADDRESS:Prompt),TRN
                           ENTRY(@s20),AT(61,76,84,10),USE(CUS:ADDRESS)
                           PROMPT('CITY:'),AT(8,90),USE(?CUS:CITY:Prompt),TRN
                           ENTRY(@s20),AT(61,90,84,10),USE(CUS:CITY)
                           PROMPT('STATE:'),AT(8,104),USE(?CUS:STATE:Prompt),TRN
                           ENTRY(@s2),AT(61,104,40,10),USE(CUS:STATE)
                           PROMPT('ZIPCODE:'),AT(8,118),USE(?CUS:ZIPCODE:Prompt),TRN
                           ENTRY(@P#####P),AT(61,118,40,10),USE(CUS:ZIPCODE),RIGHT(1)
                         END
                         TAB('&2) ORDERS'),USE(?Tab:2)
                           LIST,AT(8,20,155,90),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing the ORDERS file'),FORMAT('64R(2)|M~CUSTNUMBER~C(0)@n-14@64R(2)|M~ORDERNUMBER~C(0)@n-14@56D(12)|M~INVOICEAM' &|
   'OUNT~C(0)@n-10.2@80R(2)|M~ORDERDATE~C(0)@D2@80L(2)|M~ORDERNOTE~L(2)@s80@'),FROM(Queue:Browse:2)
                           BUTTON('&Insert'),AT(8,114,49,14),USE(?Insert:3),FLAT,LEFT,MSG('Insert a Record'),TIP('Insert a Record'),ICON('WAINSERT.ICO')
                           BUTTON('&Change'),AT(61,114,49,14),USE(?Change:3),FLAT,LEFT,MSG('Change the Record'),TIP('Change the Record'),ICON('WACHANGE.ICO')
                           BUTTON('&Delete'),AT(114,114,49,14),USE(?Delete:3),FLAT,LEFT,MSG('Delete the Record'),TIP('Delete the Record'),ICON('WADELETE.ICO')
                         END
                       END
                       BUTTON('&OK'),AT(12,136,49,14),USE(?OK),FLAT,LEFT,MSG('Accept data and close the window'),TIP('Accept data and close the window'),ICON('WAOK.ICO'),DEFAULT
                       BUTTON('&Cancel'),AT(65,136,49,14),USE(?Cancel),FLAT,LEFT,MSG('Cancel operation'),TIP('Cancel operation'),ICON('WACANCEL.ICO')
                       BUTTON('&Help'),AT(118,136,49,14),USE(?Help),FLAT,LEFT,MSG('See Help Window'),TIP('See Help Window'),ICON('WAHELP.ICO'),STD(STD:Help)
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
BRW2                 CLASS(BrowseClass)                    ! Browse using ?Browse:2
Q                      &Queue:Browse:2                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
                     END

BRW2::Sort0:StepClass StepLongClass                        ! Default Step Manager
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
    ActionMessage = 'Adding a CUSTOMER Record'
  OF ChangeRecord
    ActionMessage = 'Changing a CUSTOMER Record'
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateCUSTOMER')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?CUS:CUSTNUMBER:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(CUS:Record,History::CUS:Record)
  SELF.AddHistoryField(?CUS:CUSTNUMBER,1)
  SELF.AddHistoryField(?CUS:COMPANY,2)
  SELF.AddHistoryField(?CUS:FIRSTNAME,3)
  SELF.AddHistoryField(?CUS:LASTNAME,4)
  SELF.AddHistoryField(?CUS:ADDRESS,5)
  SELF.AddHistoryField(?CUS:CITY,6)
  SELF.AddHistoryField(?CUS:STATE,7)
  SELF.AddHistoryField(?CUS:ZIPCODE,8)
  SELF.AddUpdateFile(Access:CUSTOMER)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:CUSTOMER.Open                                     ! File CUSTOMER used by this procedure, so make sure it's RelationManager is open
  Relate:States.Open                                       ! File States used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:CUSTOMER
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
  BRW2.Init(?Browse:2,Queue:Browse:2.ViewPosition,BRW2::View:Browse,Queue:Browse:2,Relate:ORDERS,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?CUS:COMPANY{PROP:ReadOnly} = True
    ?CUS:FIRSTNAME{PROP:ReadOnly} = True
    ?CUS:LASTNAME{PROP:ReadOnly} = True
    ?CUS:ADDRESS{PROP:ReadOnly} = True
    ?CUS:CITY{PROP:ReadOnly} = True
    ?CUS:STATE{PROP:ReadOnly} = True
    ?CUS:ZIPCODE{PROP:ReadOnly} = True
    DISABLE(?Insert:3)
    DISABLE(?Change:3)
    DISABLE(?Delete:3)
  END
  BRW2.Q &= Queue:Browse:2
  BRW2::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon ORD:CUSTNUMBER for sort order 1
  BRW2.AddSortOrder(BRW2::Sort0:StepClass,ORD:KEYCUSTNUMBER) ! Add the sort order for ORD:KEYCUSTNUMBER for sort order 1
  BRW2.AddRange(ORD:CUSTNUMBER,Relate:ORDERS,Relate:CUSTOMER) ! Add file relationship range limit for sort order 1
  BRW2.AddField(ORD:CUSTNUMBER,BRW2.Q.ORD:CUSTNUMBER)      ! Field ORD:CUSTNUMBER is a hot field or requires assignment from browse
  BRW2.AddField(ORD:ORDERNUMBER,BRW2.Q.ORD:ORDERNUMBER)    ! Field ORD:ORDERNUMBER is a hot field or requires assignment from browse
  BRW2.AddField(ORD:INVOICEAMOUNT,BRW2.Q.ORD:INVOICEAMOUNT) ! Field ORD:INVOICEAMOUNT is a hot field or requires assignment from browse
  BRW2.AddField(ORD:ORDERDATE,BRW2.Q.ORD:ORDERDATE)        ! Field ORD:ORDERDATE is a hot field or requires assignment from browse
  BRW2.AddField(ORD:ORDERNOTE,BRW2.Q.ORD:ORDERNOTE)        ! Field ORD:ORDERNOTE is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateCUSTOMER',QuickWindow)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  Resizer.Reset
  BRW2.AskProcedure = 2
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:CUSTOMER.Close
    Relate:States.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateCUSTOMER',QuickWindow)            ! Save window data to non-volatile store
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
    EXECUTE Number
      SelectStates
      UpdateORDERS
    END
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
    OF ?CUS:STATE
      STA:State = CUS:STATE
      IF Access:States.TryFetch(STA:KeyState)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          CUS:STATE = STA:State
        ELSE
          SELECT(?CUS:STATE)
          CYCLE
        END
      END
      ThisWindow.Reset(0)
      IF Access:CUSTOMER.TryValidateField(7)               ! Attempt to validate CUS:STATE in CUSTOMER
        SELECT(?CUS:STATE)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?CUS:STATE
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?CUS:STATE{Prop:FontColor} = FieldColorQueue.OldColor
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


BRW2.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW2.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

