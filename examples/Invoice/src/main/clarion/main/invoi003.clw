

   MEMBER('invoice.clw')                                   ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('INVOI003.INC'),ONCE        !Local module procedure declarations
                     END


UpdateProducts PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
RecordChanged        BYTE,AUTO                             !
DOSDialogHeader      CSTRING(40)                           !
DOSExtParameter      CSTRING(250)                          !
DOSTargetVariable    CSTRING(80)                           !
LOC:FileName         STRING(85)                            !
History::PRO:Record  LIKE(PRO:RECORD),THREAD
! QuickWindow          WINDOW('Update Products'),AT(,,288,130),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('FLOW04.ICO'),HLP('~UpdateProducts'),PALETTE(256),SYSTEM,GRAY,DOUBLE,MDI
! is it PALETTE() wrong? %%%%%%%%%%%%%%%%%%%%
QuickWindow          WINDOW('Update Products'),AT(,,288,130),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('FLOW04.ICO'),HLP('~UpdateProducts'),SYSTEM,GRAY,DOUBLE,MDI

                       SHEET,AT(3,0,282,128),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                         END
                       END
                       PROMPT('Product SKU:'),AT(7,9),USE(?PRO:ProductSKU:Prompt)
                       ENTRY(@s10),AT(70,9,44,10),USE(PRO:ProductSKU),LEFT(1),MSG('User defined Product Number'),REQ,UPR
                       PROMPT('Description:'),AT(7,25),USE(?PRO:Description:Prompt)
                       ENTRY(@s35),AT(70,25,101,10),USE(PRO:Description),LEFT(1),MSG('Enter Product''s Description'),REQ,CAP
                       PROMPT('Price:'),AT(7,41,29,10),USE(?PRO:Price:Prompt)
                       ENTRY(@n$10.2B),AT(70,41,35,10),USE(PRO:Price),DECIMAL(12),MSG('Enter Product''s Price')
                       PROMPT('Cost:'),AT(7,57,23,10),USE(?PRO:Cost:Prompt)
                       ENTRY(@n$10.2B),AT(70,57,35,10),USE(PRO:Cost),DECIMAL(12),MSG('Enter product''s cost')
                       ENTRY(@n-10.2),AT(70,73,35,10),USE(PRO:QuantityInStock),DECIMAL(12),MSG('Enter quantity of product in stock')
                       PROMPT('Quantity In Stock:'),AT(7,73,60,10),USE(?PRO:QuantityInStock:Prompt)
                       PROMPT('Reorder Quantity:'),AT(7,89,59,10),USE(?PRO:ReorderQuantity:Prompt)
                       ENTRY(@n9.2),AT(70,89,35,10),USE(PRO:ReorderQuantity),DECIMAL(12),MSG('Enter product''s quantity for re-order')
                       PROMPT('Picture File:'),AT(7,105),USE(?PRO:PictureFile:Prompt)
                       ENTRY(@s64),AT(70,105,101,10),USE(PRO:PictureFile),DISABLE,LEFT(1),MSG('Path of graphic file')
                       BUTTON('Select Image'),AT(110,87,65,14),USE(?LookupFile),FONT(,,COLOR:Navy,FONT:bold),TIP('Insert or Change Image'),ICON(ICON:None)
                       GROUP,AT(181,5,97,94),USE(?Group1),BOXED,BEVEL(-2,2)
                         IMAGE,AT(185,9,89,87),USE(?Image1)
                       END
                       BUTTON,AT(195,105,22,20),USE(?OK),FLAT,TIP('Save record and exit '),ICON('DISK12.ICO'),DEFAULT
                       BUTTON,AT(225,110,13,12),USE(?Help),FLAT,HIDE,ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(244,105,22,20),USE(?Cancel),FLAT,TIP('Cancel changes and exit'),ICON(ICON:Cross)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False) ! Method added to host embed code
                     END

FileLookup5          SelectFileClass
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
  CASE SELF.Request
  OF ChangeRecord OROF DeleteRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (' & CLIP(PRO:Description) & ')' ! Append status message to window title text
  OF InsertRecord
    QuickWindow{Prop:Text} = QuickWindow{Prop:Text} & '  (New)'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateProducts')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PRO:ProductSKU:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(PRO:Record,History::PRO:Record)
  SELF.AddHistoryField(?PRO:ProductSKU,2)
  SELF.AddHistoryField(?PRO:Description,3)
  SELF.AddHistoryField(?PRO:Price,4)
  SELF.AddHistoryField(?PRO:Cost,7)
  SELF.AddHistoryField(?PRO:QuantityInStock,5)
  SELF.AddHistoryField(?PRO:ReorderQuantity,6)
  SELF.AddHistoryField(?PRO:PictureFile,8)
  SELF.AddUpdateFile(Access:Products)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Products.Open                                     ! File Products used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Products
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
  QuickWindow{PROP:MinWidth}=281                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=127                          ! Restrict the minimum window height
  QuickWindow{PROP:MaxWidth}=281                           ! Restrict the maximum window width
  QuickWindow{PROP:MaxHeight}=127                          ! Restrict the maximum window height
  Resizer.Init(AppStrategy:NoResize)                       ! Don't change the windows controls when window resized
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  IF SELF.Request = ChangeRecord OR SELF.Request = DeleteRecord
    ?Image1{PROP:TEXT} = Products.Record.PictureFile
  END
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FileLookup5.Init
  FileLookup5.SetMask('JPEG Images','*.JPG')               ! Set the file mask
  FileLookup5.AddMask('BMP Images','*.BMP')                ! Add additional masks
  FileLookup5.AddMask('GIF Files','*.GIF')                 ! Add additional masks
  FileLookup5.WindowTitle='Locate and Select Product Image File'
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
    OF ?LookupFile
      ThisWindow.Update
      LOC:FileName = FileLookup5.Ask(1)
      DISPLAY
      IF LOC:FileName
         ?Image1{PROP:TEXT} = CLIP(LOC:FileName)
         ResizeImage(?Image1,185,9,89,87)
         UNHIDE(?Image1)
      END
      !Display filename only and not the path.
      IF LOC:FileName <> ''
        LX# = LEN(CLIP(LOC:FileName))
        LOOP X# = LX# TO 1 BY -1
          IF LOC:FileName[X#] = '\'
            BREAK
          END
        END
        ! bellow is giving .......... %%%%%%%%%%%%%%%%%%%%%%%%
        ! seems PATH() is undefined! %%%%%%%%%%%%%%%%%%%%%%
        ! IF LOC:FileName[1 : (X#-1)] = LONGPATH(PATH())
        IF LOC:FileName[1 : (X#-1)] = ''  ! LONGPATH('')
          PRO:PictureFile = UPPER(LOC:FileName[(X#+1) : LX#])
          DISPLAY
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

PrintCUS:StateKey PROCEDURE                                ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
Progress:Thermometer BYTE                                  !
Process:View         VIEW(Customers)
                       PROJECT(CUS:City)
                       PROJECT(CUS:Company)
                       PROJECT(CUS:Extension)
                       PROJECT(CUS:FirstName)
                       PROJECT(CUS:LastName)
                       PROJECT(CUS:PhoneNumber)
                       PROJECT(CUS:State)
                       PROJECT(CUS:ZipCode)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,46,15),USE(?Progress:Cancel),FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Cancel Printing'),ICON(ICON:NoPrint)
                     END

report               REPORT,AT(490,1167,7510,9104),PRE(RPT),FONT('MS Serif',8,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(500,500,7490,667)
                         STRING('Customers By State'),AT(21,10,7458,354),USE(?String16),CENTER,FONT('MS Serif',18,,FONT:bold)
                         BOX,AT(10,385,7490,292),USE(?Box1),ROUND,COLOR(COLOR:Black)
                         STRING('Name'),AT(42,458,1813,167),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING('Company'),AT(2052,458,1021,167),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING('City'),AT(3271,458,1240,167),USE(?String11),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING('Zipcode'),AT(4771,458,615,167),USE(?String15),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING('Phone#'),AT(5729,458,729,167),USE(?String13),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING('Extension'),AT(6688,458,698,167),USE(?String14),TRN,FONT('MS Serif',10,,)
                       END
break1                 BREAK(CUS:State)
                         HEADER,AT(0,0,7510,354)
                           STRING(@s2),AT(63,73,594,240),USE(CUS:State),FONT('MS Serif',14,,FONT:bold+FONT:underline)
                         END
detail                   DETAIL,AT(10,10,7510,250),USE(?detail)
                           STRING(@K#####|-####KB),AT(4771,63),USE(CUS:ZipCode)
                           STRING(@s35),AT(42,63,1917,167),USE(GLOT:CustName)
                           STRING(@P<<<#PB),AT(6688,63,438,167),USE(CUS:Extension),RIGHT
                           STRING(@s25),AT(3271,63,1375,167),USE(CUS:City)
                           STRING(@s20),AT(2052,63,1115,167),USE(CUS:Company)
                           STRING(@P(###) ###-####PB),AT(5729,63,906,167),USE(CUS:PhoneNumber)
                         END
                       END
                       FOOTER,AT(469,10260,7521,271)
                         STRING(@pPage <<<#p),AT(6688,42,729,188),PAGENO,USE(?PageCount),FONT('MS Serif',10,,FONT:regular)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

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
  GlobalErrors.SetProcedureName('PrintCUS:StateKey')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)                                     ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:Customers, ?Progress:PctText, Progress:Thermometer, ProgressMgr, CUS:State)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(CUS:StateKey)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Customers.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
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
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  GLOT:CustName = CLIP(CUS:FirstName) & '   ' & CLIP(CUS:LastName)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

PrintPRO:KeyProductSKU PROCEDURE                           ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
Progress:Thermometer BYTE                                  !
Process:View         VIEW(Products)
                       PROJECT(PRO:Description)
                       PROJECT(PRO:Price)
                       PROJECT(PRO:ProductSKU)
                       PROJECT(PRO:QuantityInStock)
                       PROJECT(PRO:ReorderQuantity)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,46,15),USE(?Progress:Cancel),FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Cancel Printing'),ICON(ICON:NoPrint)
                     END

report               REPORT,AT(500,1010,7500,9010),PRE(RPT),FONT('Arial',10,COLOR:Black,),THOUS
                       HEADER,AT(500,458,7500,563)
                         STRING(' Products List'),AT(31,10,7458,240),CENTER,FONT('MS Serif',14,,FONT:bold)
                         BOX,AT(10,271,7479,281),ROUND,COLOR(COLOR:Black)
                         LINE,AT(1000,271,0,281),COLOR(COLOR:Black)
                         LINE,AT(3510,271,0,281),COLOR(COLOR:Black)
                         LINE,AT(4896,271,0,281),COLOR(COLOR:Black)
                         LINE,AT(6385,271,0,281),COLOR(COLOR:Black)
                         STRING('Product SKU'),AT(52,323,896,188),TRN
                         STRING('Description'),AT(1042,323,2438,188),TRN
                         STRING('Quantity In Stock'),AT(3552,323,1313,188),TRN,CENTER
                         STRING('Unit Price'),AT(6438,323,1010,188),TRN,CENTER
                         STRING('Re-order Quantity'),AT(4938,323,1417,188),USE(?String12),TRN,CENTER
                       END
detail                 DETAIL,AT(,,7500,281),USE(?detail)
                         LINE,AT(1000,0,0,281),COLOR(COLOR:Black)
                         LINE,AT(3510,0,0,281),COLOR(COLOR:Black)
                         LINE,AT(6385,0,0,281),COLOR(COLOR:Black)
                         STRING(@s10),AT(52,52,896,167),USE(PRO:ProductSKU)
                         STRING(@s35),AT(1063,52,2375,167),USE(PRO:Description)
                         STRING(@n$10.2B),AT(6427,52,1031,167),USE(PRO:Price),DECIMAL(500)
                         STRING(@n6),AT(4948,52,802,167),USE(PRO:ReorderQuantity),RIGHT
                         LINE,AT(4896,0,0,281),COLOR(COLOR:Black)
                         STRING(@n-7),AT(3531,52,750,167),USE(PRO:QuantityInStock),RIGHT
                         LINE,AT(10,281,7490,0),COLOR(COLOR:Black)
                       END
                       FOOTER,AT(490,10042,7500,240)
                         STRING(@pPage <<<#p),AT(6479,10,865,208),PAGENO,USE(?PageCount),FONT('Arial',10,,)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

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
  GlobalErrors.SetProcedureName('PrintPRO:KeyProductSKU')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Products.Open                                     ! File Products used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)                                     ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:Products, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PRO:ProductSKU)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(PRO:KeyProductSKU)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Products.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
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
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

PrintInvoice PROCEDURE                                     ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ExtendPrice          DECIMAL(7,2)                          !
LOC:CCSZ             STRING(35)                            !
Progress:Thermometer BYTE                                  !
Queue:FileDrop       QUEUE                            !Queue declaration for browse/combo box using ORD:InvoiceNumber:2
ORD:InvoiceNumber      LIKE(ORD:InvoiceNumber)        !List box control field - type derived from field
ORD:OrderDate          LIKE(ORD:OrderDate)            !List box control field - type derived from field
ORD:ShipToName         LIKE(ORD:ShipToName)           !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Process:View         VIEW(Detail)
                       PROJECT(DTL:BackOrdered)
                       PROJECT(DTL:CustNumber)
                       PROJECT(DTL:Discount)
                       PROJECT(DTL:LineNumber)
                       PROJECT(DTL:OrderNumber)
                       PROJECT(DTL:Price)
                       PROJECT(DTL:QuantityOrdered)
                       PROJECT(DTL:TaxPaid)
                       PROJECT(DTL:TotalCost)
                       PROJECT(DTL:ProductNumber)
                       JOIN(PRO:KeyProductNumber,DTL:ProductNumber)
                         PROJECT(PRO:Description)
                         PROJECT(PRO:Price)
                         PROJECT(PRO:ProductSKU)
                       END
                     END
FDB2::View:FileDrop  VIEW(Orders)
                       PROJECT(ORD:InvoiceNumber)
                       PROJECT(ORD:OrderDate)
                       PROJECT(ORD:ShipToName)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,168,94),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(24,15,111,12),RANGE(0,100)
                       STRING(''),AT(3,3,162,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(3,30,162,10),USE(?Progress:PctText),CENTER
                       STRING('Select An Invoice And Press Go To Preview'),AT(2,44,164,10),USE(?String3),CENTER,FONT(,,COLOR:Maroon,FONT:bold)
                       LIST,AT(9,60,150,12),USE(ORD:InvoiceNumber,,ORD:InvoiceNumber:2),VSCROLL,FORMAT('33L(3)|~Invoice #~L(2)@n07@41L(3)|~Order Date~L(2)@d1@180L(2)|~Ship To~@s45@'),DROP(5),FROM(Queue:FileDrop),MSG('Invoice number for each order')
                       BUTTON('Exit'),AT(115,77,44,13),USE(?Progress:Cancel),LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Exit window or cancel printing'),ICON(ICON:NoPrint)
                       BUTTON('Pause'),AT(9,77,44,13),USE(?Pause),LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Preview Invoice to Print'),ICON(ICON:Print1)
                     END

Report               REPORT,AT(500,4115,7500,5875),PRE(RPT),FONT('MS Sans Serif',10,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(500,500,7500,3583)
                         IMAGE('LANTHUR.GIF'),AT(5396,21,1875,1594),USE(?Image1)
                         LINE,AT(2927,344,1458,0),USE(?Line1),COLOR(COLOR:Black),LINEWIDTH(2)
                         IMAGE('RANTHUR.GIF'),AT(92,25,1875,1594),USE(?Image2)
                         STRING('INVOICE'),AT(1979,10,3375,323),USE(?String35),CENTER,FONT('MS Sans Serif',24,,FONT:bold)
                         STRING(@s20),AT(1979,448,3375,333),USE(COM:Name),CENTER,FONT('MS Sans Serif',18,,FONT:bold)
                         STRING(@s35),AT(1979,781,3396,219),USE(COM:Address),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         STRING(@s35),AT(1979,1031,3396,219),USE(LOC:CCSZ),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         STRING(@P(###) ###-####P),AT(1979,1250,3396,219),USE(COM:Phone),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         BOX,AT(73,1927,7232,333),USE(?Box1),ROUND,LINEWIDTH(2)
                         STRING('Product SKU'),AT(104,3354,917,198),USE(?String17),TRN
                         STRING('Product Description'),AT(1063,3354,2083,198),USE(?String18),TRN
                         STRING('Quantity'),AT(5521,3354,729,198),USE(?String20),TRN,RIGHT(50)
                         STRING('Extension'),AT(6500,3354,781,198),USE(?String21),TRN,RIGHT(50)
                         LINE,AT(83,3563,7232,0),USE(?Line3),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('BackOrder'),AT(3729,3354,708,198),USE(?String36),TRN
                         STRING('Price'),AT(4896,3354,406,198),USE(?String19),TRN
                         STRING('Invoice #'),AT(177,1969,927,240),USE(?String15),TRN,FONT('MS Sans Serif',14,,FONT:bold)
                         STRING('Order Date:'),AT(3625,2010,917,177),USE(?String33),TRN,FONT(,,,FONT:bold)
                         STRING(@d1),AT(4531,2010,729,177),USE(ORD:OrderDate),TRN,CENTER
                         STRING(@n07),AT(1125,2021,729,177),USE(ORD:InvoiceNumber),TRN,CENTER
                         GROUP,AT(4083,2563,3250,573),USE(?Group2),FONT('MS Sans Serif',10,,)
                           STRING(@s35),AT(4146,2604,2948,167),USE(GLOT:ShipName)
                           STRING(@s45),AT(4146,2771,3125,167),USE(GLOT:ShipAddress)
                           STRING(@s40),AT(4146,2927,3125,167),USE(GLOT:ShipCSZ)
                         END
                         GROUP,AT(146,2573,3250,573),USE(?Group1),FONT('MS Sans Serif',10,,)
                           STRING(@s35),AT(208,2604,3083,167),USE(GLOT:CustName)
                           STRING(@s45),AT(208,2771,3125,167),USE(GLOT:CustAddress)
                           STRING(@s40),AT(208,2927,3000,167),USE(GLOT:CusCSZ)
                         END
                         LINE,AT(83,3302,7232,0),USE(?Line2),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Ship To:'),AT(4031,2302,750,198),USE(?String31),FONT(,,,FONT:bold)
                         BOX,AT(83,2531,3302,625),USE(?Box6),ROUND,LINEWIDTH(2)
                         BOX,AT(4010,2531,3302,625),USE(?Box5),ROUND,LINEWIDTH(2)
                         STRING('Sold To:'),AT(167,2313,750,188),USE(?String32),FONT(,,,FONT:bold)
                       END
detail                 DETAIL,AT(,,,242),USE(?detail)
                         STRING(@n$14.2B),AT(5406,21,83,52),USE(DTL:TotalCost),TRN,HIDE
                         STRING(@n$10.2B),AT(5500,10,135,52),USE(DTL:Discount),TRN,HIDE
                         STRING(@s10),AT(115,42,896,167),USE(PRO:ProductSKU)
                         STRING(@s35),AT(1083,42,2677,167),USE(PRO:Description)
                         CHECK,AT(3969,42,250,177),USE(DTL:BackOrdered)
                         STRING(@n7),AT(5635,42,635,167),USE(DTL:QuantityOrdered),RIGHT(100)
                         STRING(@n$10.2),AT(6458,42,823,167),USE(ExtendPrice),DECIMAL(250)
                         STRING(@n$10.2),AT(4552,42,771,167),USE(PRO:Price),DECIMAL(250)
                         STRING(@n$10.2B),AT(5635,10,63,52),USE(DTL:TaxPaid,,?DTL:TaxPaid:2),TRN,HIDE
                       END
detail1                DETAIL,AT(,,,967),USE(?detail1)
                         LINE,AT(83,10,7232,0),USE(?Line4),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Sub-total:'),AT(5594,52,813,198),USE(?String23),TRN,LEFT(50),FONT(,,,FONT:bold)
                         STRING(@n$10.2),AT(6458,250,844,167),SUM,USE(DTL:Discount,,?DTL:Discount:2),DECIMAL(250),TALLY(detail)
                         STRING(@n$10.2),AT(6448,52,844,198),SUM,USE(ExtendPrice,,?ExtendPrice:2),TRN,DECIMAL(250),TALLY(detail)
                         STRING('Discount:'),AT(5604,250,781,167),USE(?String24),LEFT(50)
                         STRING('NOTE: Product on Back-Order will be available in 4 days.'),AT(83,396,3750,240),USE(?NoteString),CENTER,FONT('MS Sans Serif',10,,)
                         STRING('Tax:'),AT(5604,417,760,167),USE(?String27),LEFT(50)
                         STRING(@n$10.2),AT(6458,417,844,167),SUM,USE(DTL:TaxPaid),DECIMAL(250),TALLY(detail)
                         LINE,AT(6350,615,962,0),USE(?Line5),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Total:'),AT(5594,667,583,198),USE(?String30),TRN,LEFT(50),FONT(,,,FONT:bold)
                         LINE,AT(6354,875,962,0),USE(?Line6),COLOR(COLOR:Black),LINEWIDTH(2)
                         LINE,AT(6354,906,962,0),USE(?Line7),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING(@n$14.2),AT(6240,656,1052,208),SUM,USE(DTL:TotalCost,,?DTL:TotalCost:2),TRN,DECIMAL(250),TALLY(detail)
                       END
                       FOOTER,AT(500,10021,7500,275)
                         STRING('Thank You For Your Order, Please Call Again.'),AT(21,10,7438,208),USE(?String22),CENTER,FONT('MS Sans Serif',10,,FONT:bold)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Next                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Paused                 BYTE
Timer                  LONG
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeCloseEvent         PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Cancelled              BYTE
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Update                 PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer
FDB2                 CLASS(FileDropClass)                  ! File drop manager
Q                      &Queue:FileDrop                !Reference to display queue
ResetQueue             PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED ! Method added to host embed code
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
  GlobalErrors.SetProcedureName('PrintInvoice')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLOT:CustName',GLOT:CustName)                      ! Added by: Report
  BIND('GLOT:CustAddress',GLOT:CustAddress)                ! Added by: Report
  BIND('GLOT:CusCSZ',GLOT:CusCSZ)                          ! Added by: Report
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Company.Open                                      ! File Company used by this procedure, so make sure it's RelationManager is open
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  Access:Orders.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  OPEN(ProgressWindow)                                     ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Detail, ?Progress:PctText, Progress:Thermometer, ProgressMgr, DTL:CustNumber)
  ThisReport.AddSortOrder(DTL:KeyDetails)
  ThisReport.SetFilter('DTL:CustNumber=ORD:CustNumber AND DTL:OrderNumber=ORD:OrderNumber')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Detail.SetQuickScan(1,Propagate:OneMany)
  ! next is getting Expected ')' near line:717 (invoi003.clw) %%%%%%%%%% this can cause
  ! I will skip FBD2 completely!
  ! FDB2.Init(ORD:InvoiceNumber:2,Queue:FileDrop.ViewPosition,FDB2::View:FileDrop,Queue:FileDrop,Relate:Orders,ThisWindow)
  !FDB2.Init(ORD:InvoiceNumber:2,0,0,Queue:FileDrop,Relate:Orders,ThisWindow)

  !FDB2.Q &= Queue:FileDrop
  !FDB2.AddSortOrder(ORD:InvoiceNumberKey)
  !FDB2.AddField(ORD:InvoiceNumber,FDB2.Q.ORD:InvoiceNumber)
  !FDB2.AddField(ORD:OrderDate,FDB2.Q.ORD:OrderDate)
  !FDB2.AddField(ORD:ShipToName,FDB2.Q.ORD:ShipToName)
  !ThisWindow.AddItem(FDB2.WindowComponent)
  !FDB2.DefaultFill = 0
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  ASSERT(~SELF.DeferWindow) ! A hidden Go button is not smart ...
  SELF.DeferOpenReport = 1
  SELF.Timer = TARGET{PROP:Timer}
  TARGET{PROP:Timer} = 0
  ?Pause{PROP:Text} = 'Go'
  SELF.Paused = 1
  ?Progress:Cancel{PROP:Key} = EscKey
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Company.Close
    Relate:Customers.Close
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Next PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
   !Process company record
   SET(Company)
   Access:Company.Next()
   LOC:CCSZ = CLIP(Company.Record.City) & ', ' & Company.Record.State|
                & '  ' & CLIP(Company.Record.Zipcode)
  ReturnValue = PARENT.Next()
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF ProgressWindow{Prop:AcceptAll} THEN RETURN.
  PRO:ProductNumber = DTL:ProductNumber                    ! Assign linking field value
  Access:Products.Fetch(PRO:KeyProductNumber)
  PARENT.Reset(Force)


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
    OF ?Pause
      IF SELF.Paused
        TARGET{PROP:Timer} = SELF.Timer
        ?Pause{PROP:Text} = 'Pause'
      ELSE
        SELF.Timer = TARGET{PROP:Timer}
        TARGET{PROP:Timer} = 0
        ?Pause{PROP:Text} = 'Restart'
      END
      SELF.Paused = 1 - SELF.Paused
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Progress:Cancel
      ThisWindow.Update
      SELF.Cancelled = 1
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeCloseEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  !Print second Detail band
  PRINT(RPT:Detail1)
  ReturnValue = PARENT.TakeCloseEvent()
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
    CASE EVENT()
    OF EVENT:CloseWindow
      SELF.KeepVisible = 1
    OF EVENT:Timer
      IF SELF.Paused THEN RETURN Level:Benign .
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:CloseWindow
      IF ~SELF.Cancelled
        Progress:Thermometer = 0
        ?Progress:PctText{PROP:Text} = '0% Completed'
        SELF.DeferOpenReport = 1
        TARGET{PROP:Timer} = 0
        ?Pause{PROP:Text} = 'Go'
        SELF.Paused = 1
        SELF.Process.Close
        SELF.Response = RequestCancelled
        DISPLAY
        RETURN Level:Notify
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.Update PROCEDURE

  CODE
  PARENT.Update
  PRO:ProductNumber = DTL:ProductNumber                    ! Assign linking field value
  Access:Products.Fetch(PRO:KeyProductNumber)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  !Get Customer records
  CUS:CustNumber=ORD:CustNumber
  Access:Customers.Fetch(CUS:KeyCustNumber)
  ExtendPrice = DTL:Price * DTL:QuantityOrdered
  GLOT:CustName = CLIP(CUS:FirstName) & '   ' & CLIP(CUS:LastName)
  GLOT:CustAddress = CLIP(CUS:Address1) & '    ' & CLIP(CUS:Address2)
  GLOT:CusCSZ = CLIP(CUS:City) & ',   ' & CUS:State & '    ' & CLIP(CUS:ZipCode)
  GLOT:ShipName = CLIP(ORD:ShipToName)
  GLOT:ShipAddress = CLIP(ORD:ShipAddress1) & '   ' & CLIP(ORD:ShipAddress2)
  GLOT:ShipCSZ = CLIP(ORD:ShipCity) & ',  ' & ORD:ShipState & '    ' & CLIP(ORD:ShipZip)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue


FDB2.ResetQueue PROCEDURE(BYTE Force=0)

ReturnValue          LONG,AUTO

GreenBarIndex   LONG
  CODE
  ReturnValue = PARENT.ResetQueue(Force)
  RETURN ReturnValue

PrintMailingLabels PROCEDURE                               ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
Progress:Thermometer BYTE                                  !
Process:View         VIEW(Orders)
                       PROJECT(ORD:CustNumber)
                       PROJECT(ORD:OrderNumber)
                       PROJECT(ORD:ShipAddress1)
                       PROJECT(ORD:ShipAddress2)
                       PROJECT(ORD:ShipCity)
                       PROJECT(ORD:ShipState)
                       PROJECT(ORD:ShipToName)
                       PROJECT(ORD:ShipZip)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,48,15),USE(?Progress:Cancel),FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Cancel Printing'),ICON(ICON:NoPrint)
                     END

Report               REPORT,AT(250,448,8198,10500),PRE(RPT),FONT('MS Serif',10,COLOR:Black,FONT:regular),THOUS
detail                 DETAIL,AT(31,10,2656,979),USE(?detail)
                         STRING(@s45),AT(115,156,2542,167),USE(ORD:ShipToName)
                         STRING(@s45),AT(115,323,2521,167),USE(GLOT:ShipAddress)
                         STRING(@s40),AT(115,490,2531,167),USE(GLOT:ShipCSZ)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

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
  GlobalErrors.SetProcedureName('PrintMailingLabels')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Orders.Open                                       ! File Orders used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)                                     ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Orders, ?Progress:PctText, Progress:Thermometer, ProgressMgr, ORD:CustNumber)
  ThisReport.AddSortOrder(ORD:KeyCustOrderNumber)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Orders.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Orders.Close
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  GLOT:ShipAddress = CLIP(ORD:ShipAddress1) & '    ' & CLIP(ORD:ShipAddress2)
  GLOT:ShipCSZ = CLIP(ORD:ShipCity) & ',  ' & ORD:ShipState & '    ' & CLIP(ORD:ShipZip)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

UpdateCompany PROCEDURE                                    ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ActionMessage        CSTRING(40)                           !
RecordChanged        BYTE,AUTO                             !
History::COM:Record  LIKE(COM:RECORD),THREAD
QuickWindow          WINDOW('Update Company'),AT(,,199,121),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,HLP('~UpdateCompany'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,2,191,117),USE(?CurrentTab),WIZARD
                         TAB('Tab 1'),USE(?Tab1)
                         END
                       END
                       PROMPT('Name:'),AT(8,7),USE(?COM:Name:Prompt)
                       ENTRY(@s20),AT(49,7,84,10),USE(COM:Name),MSG('Company name'),CAP
                       PROMPT('Address:'),AT(8,20),USE(?COM:Address:Prompt)
                       ENTRY(@s35),AT(49,20,137,10),USE(COM:Address),MSG('First line of company''s address'),CAP
                       PROMPT('City:'),AT(8,34,17,10),USE(?COM:City:Prompt)
                       ENTRY(@s25),AT(49,34,104,10),USE(COM:City),MSG('Company''s city'),CAP
                       PROMPT('State:'),AT(8,47),USE(?COM:State:Prompt)
                       ENTRY(@s2),AT(49,47,25,10),USE(COM:State),MSG('Company''s state'),UPR
                       PROMPT('Zipcode:'),AT(8,61),USE(?COM:Zipcode:Prompt)
                       ENTRY(@K#####|-####K),AT(49,61,64,10),USE(COM:Zipcode),MSG('Company''s zipcode')
                       PROMPT('Phone:'),AT(8,74),USE(?COM:Phone:Prompt)
                       ENTRY(@P(###) ###-####P),AT(49,74,64,10),USE(COM:Phone),MSG('Company''s phone number')
                       BUTTON,AT(52,92,21,18),USE(?OK),FLAT,TIP('Save changes and exit'),ICON('DISK12.ICO'),DEFAULT
                       BUTTON,AT(88,92,21,18),USE(?Help),FLAT,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(124,92,21,18),USE(?Cancel),FLAT,TIP('Cancel changes and exit '),ICON(ICON:Cross)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED                 ! Method added to host embed code
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
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
    ActionMessage = 'Enter  your Company''''s Information'
  OF ChangeRecord
    ActionMessage = 'Change your Company''''s Information'
  OF DeleteRecord
    GlobalErrors.Throw(Msg:DeleteIllegal)
    RETURN
  END
  QuickWindow{Prop:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateCompany')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?COM:Name:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = 734
  SELF.AddHistoryFile(COM:Record,History::COM:Record)
  SELF.AddHistoryField(?COM:Name,1)
  SELF.AddHistoryField(?COM:Address,2)
  SELF.AddHistoryField(?COM:City,3)
  SELF.AddHistoryField(?COM:State,4)
  SELF.AddHistoryField(?COM:Zipcode,5)
  SELF.AddHistoryField(?COM:Phone,6)
  SELF.AddUpdateFile(Access:Company)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Company.Open                                      ! File Company used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Company
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.DeleteAction = Delete:None                        ! Deletes not allowed
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  QuickWindow{PROP:MinWidth}=199                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=111                          ! Restrict the minimum window height
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
    Relate:Company.Close
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

SplashScreen PROCEDURE                                     ! Generated from procedure template - Splash

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
!window               WINDOW,AT(,,306,147),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),COLOR(080FFFFH),CENTER,CURSOR('GLOVE.CUR'),PALETTE(256),GRAY,NOFRAME,MDI
! Both PALETTE() and CURSOR() has not been accepted %%%%%%%%%%%%%%%%%%%%
window               WINDOW,AT(,,306,147),FONT('MS Sans Serif',8,COLOR:Black,FONT:regular),COLOR(080FFFFH),CENTER,GRAY,NOFRAME,MDI

                       PANEL,AT(0,0,306,147),BEVEL(3)
                       PANEL,AT(7,6,292,134),BEVEL(-2,1)
                       STRING('ORDER ENTRY '),AT(114,19,178,20),USE(?String2),TRN,CENTER,FONT('Courier New',22,,FONT:bold)
                       STRING('&'),AT(114,50,178,20),USE(?String4),TRN,CENTER,FONT('Courier New',22,,FONT:bold)
                       STRING('INVOICE SYSTEM'),AT(114,82,178,20),USE(?String3),TRN,CENTER,FONT('Courier New',22,,FONT:bold)
                       IMAGE('Alstroemeria.jpg'),AT(12,11,101,102),USE(?Image1)
                       PANEL,AT(17,111,273,10),BEVEL(-1,1,09H)
                       STRING('Revised using Clarion 6'),AT(11,124,284,12),USE(?String1),TRN,CENTER,FONT('MS Sans Serif',10,,)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SplashScreen')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  OPEN(window)                                             ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  TARGET{Prop:Timer} = 1000                                ! Close window on timer event, so configure timer
  TARGET{Prop:Alrt,255} = MouseLeft                        ! Alert mouse clicks that will close window
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
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
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)                            ! Splash window will close on mouse click
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)                            ! Splash window will close when focus is lost
    OF Event:Timer
      POST(Event:CloseWindow)                              ! Splash window will close on event timer
    OF Event:AlertKey
      CASE KEYCODE()                                       ! Splash window will close on mouse click
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

