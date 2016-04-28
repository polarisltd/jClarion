

   MEMBER('invoice.clw')                                   ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABQUERY.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('INVOI002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('INVOI001.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('INVOI003.INC'),ONCE        !Req'd for module callout resolution
                     END


PrintInvoiceFromBrowse PROCEDURE                           ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
ExtendPrice          DECIMAL(7,2)                          !
LOC:CCSZ             STRING(35)                            !
Progress:Thermometer BYTE                                  !
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
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,48,15),USE(?Progress:Cancel),FLAT,LEFT,TIP('Cancel printing'),ICON(ICON:NoPrint)
                     END

Report               REPORT,AT(500,4115,7500,5875),PRE(RPT),FONT('MS Sans Serif',10,COLOR:Black,FONT:regular),THOUS
                       HEADER,AT(500,500,7500,3583)
                         IMAGE('LANTHUR.GIF'),AT(5417,21,1875,1594),USE(?Image1)
                         LINE,AT(2948,354,1458,0),USE(?Line7),COLOR(COLOR:Black),LINEWIDTH(3)
                         IMAGE('RANTHUR.GIF'),AT(83,21,1875,1594),USE(?Image2)
                         STRING('INVOICE'),AT(1990,10,3375,302),USE(?String35),CENTER,FONT('MS Sans Serif',24,,FONT:bold)
                         STRING(@s20),AT(1990,448,3375,333),USE(COM:Name),CENTER,FONT('MS Sans Serif',18,,FONT:bold)
                         STRING(@s35),AT(1990,781,3375,250),USE(COM:Address),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         STRING(@s35),AT(1990,1031,3375,250),USE(LOC:CCSZ),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         STRING(@P(###) ###-####P),AT(1990,1260,3375,250),USE(COM:Phone),CENTER,FONT('MS Sans Serif',12,,FONT:bold)
                         BOX,AT(83,1906,7232,333),USE(?Box1),ROUND,COLOR(COLOR:Black),LINEWIDTH(4)
                         STRING('Product SKU'),AT(104,3333,917,198),USE(?String17),TRN
                         STRING('Product Description'),AT(1042,3333,2083,198),USE(?String18),TRN
                         STRING('Quantity'),AT(5521,3333,729,198),USE(?String20),TRN,RIGHT(50)
                         STRING('Extension'),AT(6500,3333,781,198),USE(?String21),TRN,RIGHT(50)
                         LINE,AT(83,3542,7232,0),USE(?Line2),COLOR(COLOR:Black),LINEWIDTH(3)
                         STRING('BackOrder'),AT(3729,3333,708,198),USE(?String36),TRN
                         STRING('Price'),AT(4896,3333,406,198),USE(?String19),TRN
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
                         LINE,AT(83,3281,7232,0),USE(?Line1),COLOR(COLOR:Black),LINEWIDTH(3)
                         STRING('Ship To:'),AT(4031,2313,750,198),USE(?String31),FONT(,,,FONT:bold)
                         BOX,AT(83,2531,3302,625),USE(?Box6),ROUND,COLOR(COLOR:Black),LINEWIDTH(2)
                         BOX,AT(4010,2531,3302,625),USE(?Box5),ROUND,COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Sold To:'),AT(115,2313,750,188),USE(?String32),FONT(,,,FONT:bold)
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
                         LINE,AT(83,10,7232,0),USE(?Line3),COLOR(COLOR:Black),LINEWIDTH(3)
                         STRING('Sub-total:'),AT(5594,52,813,198),USE(?String23),TRN,LEFT(50),FONT(,,,FONT:bold)
                         STRING(@n$10.2),AT(6417,240,844,167),SUM,USE(DTL:Discount,,?DTL:Discount:2),DECIMAL(250),TALLY(detail)
                         STRING(@n$10.2),AT(6417,52,844,198),SUM,USE(ExtendPrice,,?ExtendPrice:2),TRN,DECIMAL(250),TALLY(detail)
                         STRING('Discount:'),AT(5594,240,781,167),USE(?String24),LEFT(50)
                         STRING('NOTE: Product on Back-Order will be available in 4 days.'),AT(83,375,3750,240),USE(?NoteString),CENTER,FONT('MS Sans Serif',10,,)
                         STRING('Tax:'),AT(5594,406,760,167),USE(?String27),LEFT(50)
                         STRING(@n$10.2),AT(6417,406,844,167),SUM,USE(DTL:TaxPaid),DECIMAL(250),TALLY(detail)
                         LINE,AT(6350,625,962,0),USE(?Line4),COLOR(COLOR:Black),LINEWIDTH(3)
                         LINE,AT(6350,875,962,0),USE(?Line5),COLOR(COLOR:Black),LINEWIDTH(3)
                         LINE,AT(6350,917,962,0),USE(?Line6),COLOR(COLOR:Black),LINEWIDTH(3)
                         STRING('Total:'),AT(5594,677,583,198),USE(?String30),TRN,LEFT(50),FONT(,,,FONT:bold)
                         STRING(@n$14.2),AT(6208,677,1052,208),SUM,USE(DTL:TotalCost,,?DTL:TotalCost:2),TRN,DECIMAL(250),TALLY(detail)
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
TakeCloseEvent         PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Update                 PROCEDURE(),DERIVED                 ! Method added to host embed code
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
  GlobalErrors.SetProcedureName('PrintInvoiceFromBrowse')
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


ThisWindow.TakeCloseEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  !Print second Detail band
  PRINT(RPT:Detail1)
  ReturnValue = PARENT.TakeCloseEvent()
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
  ExtendPrice = DTL:Price * DTL:QuantityOrdered
  GLOT:CustName = CLIP(CUS:FirstName) & '   ' & CLIP(CUS:LastName)
  GLOT:CustAddress = CLIP(CUS:Address1) & '    ' & CLIP(CUS:Address2)
  GLOT:CusCSZ = CLIP(CUS:City) & ',  ' & CUS:State & '     ' & CLIP(CUS:ZipCode)
  GLOT:ShipName = CLIP(ORD:ShipToName)
  GLOT:ShipAddress = CLIP(ORD:ShipAddress1) & '    ' & CLIP(ORD:ShipAddress2)
  GLOT:ShipCSZ = CLIP(ORD:ShipCity) & ',  ' & ORD:ShipState & '    ' & CLIP(ORD:ShipZip)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue



BrowseOrders PROCEDURE                                     ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
LOC:Shipped          STRING(3)                             !
LOC:Backorder        STRING(3)                             !
TaxString            STRING(8)                             !
DiscountString       STRING(8)                             !
TotalTax             DECIMAL(7,2)                          !
TotalDiscount        DECIMAL(7,2)                          !
TotalCost            DECIMAL(7,2)                          !
BRW1::View:Browse    VIEW(Orders)
                       PROJECT(ORD:OrderNumber)
                       PROJECT(ORD:OrderDate)
                       PROJECT(ORD:OrderNote)
                       PROJECT(ORD:ShipToName)
                       PROJECT(ORD:ShipAddress1)
                       PROJECT(ORD:ShipAddress2)
                       PROJECT(ORD:ShipCity)
                       PROJECT(ORD:ShipState)
                       PROJECT(ORD:ShipZip)
                       PROJECT(ORD:InvoiceNumber)
                       PROJECT(ORD:CustNumber)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
ORD:OrderNumber        LIKE(ORD:OrderNumber)          !List box control field - type derived from field
ORD:OrderDate          LIKE(ORD:OrderDate)            !List box control field - type derived from field
LOC:Shipped            LIKE(LOC:Shipped)              !List box control field - type derived from local data
ORD:OrderNote          LIKE(ORD:OrderNote)            !List box control field - type derived from field
GLOT:ShipName          LIKE(GLOT:ShipName)            !Browse hot field - type derived from global data
ORD:ShipToName         LIKE(ORD:ShipToName)           !Browse hot field - type derived from field
ORD:ShipAddress1       LIKE(ORD:ShipAddress1)         !Browse hot field - type derived from field
ORD:ShipAddress2       LIKE(ORD:ShipAddress2)         !Browse hot field - type derived from field
ORD:ShipCity           LIKE(ORD:ShipCity)             !Browse hot field - type derived from field
ORD:ShipState          LIKE(ORD:ShipState)            !Browse hot field - type derived from field
ORD:ShipZip            LIKE(ORD:ShipZip)              !Browse hot field - type derived from field
GLOT:ShipCSZ           LIKE(GLOT:ShipCSZ)             !Browse hot field - type derived from global data
ORD:InvoiceNumber      LIKE(ORD:InvoiceNumber)        !Browse hot field - type derived from field
ORD:CustNumber         LIKE(ORD:CustNumber)           !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW5::View:Browse    VIEW(Detail)
                       PROJECT(DTL:QuantityOrdered)
                       PROJECT(DTL:Price)
                       PROJECT(DTL:TaxPaid)
                       PROJECT(DTL:Discount)
                       PROJECT(DTL:TotalCost)
                       PROJECT(DTL:TaxRate)
                       PROJECT(DTL:DiscountRate)
                       PROJECT(DTL:CustNumber)
                       PROJECT(DTL:OrderNumber)
                       PROJECT(DTL:LineNumber)
                       PROJECT(DTL:ProductNumber)
                       JOIN(PRO:KeyProductNumber,DTL:ProductNumber)
                         PROJECT(PRO:Description)
                         PROJECT(PRO:ProductNumber)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PRO:Description        LIKE(PRO:Description)          !List box control field - type derived from field
DTL:QuantityOrdered    LIKE(DTL:QuantityOrdered)      !List box control field - type derived from field
DTL:Price              LIKE(DTL:Price)                !List box control field - type derived from field
LOC:Backorder          LIKE(LOC:Backorder)            !List box control field - type derived from local data
DTL:TaxPaid            LIKE(DTL:TaxPaid)              !List box control field - type derived from field
DTL:Discount           LIKE(DTL:Discount)             !List box control field - type derived from field
DTL:TotalCost          LIKE(DTL:TotalCost)            !List box control field - type derived from field
DTL:TaxRate            LIKE(DTL:TaxRate)              !Browse hot field - type derived from field
DTL:DiscountRate       LIKE(DTL:DiscountRate)         !Browse hot field - type derived from field
DTL:CustNumber         LIKE(DTL:CustNumber)           !Primary key field - type derived from field
DTL:OrderNumber        LIKE(DTL:OrderNumber)          !Primary key field - type derived from field
DTL:LineNumber         LIKE(DTL:LineNumber)           !Primary key field - type derived from field
PRO:ProductNumber      LIKE(PRO:ProductNumber)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse Orders for a Customer'),AT(,,375,193),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('NOTE14.ICO'),HLP('~BrowseOrdersforaCustomer'),SYSTEM,GRAY,RESIZE,MDI
                       !SHEET,AT(2,18,250,89),USE(?CurrentTab),LEFT(80),FONT('Arial',,,),WIZARD,UP
                       ! Did not accepted UP %%%%%%%%%%%%%
                       SHEET,AT(2,18,250,89),USE(?CurrentTab),LEFT(80),FONT('Arial',,,),WIZARD
 
                         TAB('Tab 1'),USE(?Tab1)
                         END
                       END
                       LIST,AT(9,23,237,79),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('35L(1)|M~Order #~L(2)@n07@40R(4)|M~Order Date~L(2)@d1@31C(1)|M~Shipped~L@s3@320L' &|
   '(2)|M~Note~@s80@'),FROM(Queue:Browse:1)
                       LIST,AT(21,114,225,73),USE(?List),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('89L(2)|M~Description~L(1)@s35@36D(17)|M~Quantity~L(0)@n9.2B@33D(14)|M~Price~L(0)' &|
   '@n$10.2B@37C|M~Backorder~L(1)@s3@40D(19)|M~Tax Paid~L(0)@n$10.2B@40D(19)|M~Disco' &|
   'unt~L(0)@n$10.2B@56D(51)|M~Total~L(0)@n$14.2B@'),FROM(Queue:Browse)
                       STRING('Customer:'),AT(7,4,46,10),USE(?String9),TRN,FONT('MS Serif',10,,FONT:bold)
                       STRING(@s35),AT(53,5,115,10),USE(GLOT:CustName),FONT(,,COLOR:Red,FONT:bold)
                       STRING('Cust #:'),AT(172,4,33,10),USE(?String8),FONT('MS Serif',10,,FONT:bold)
                       STRING(@n07),AT(205,5,,10),USE(CUS:CustNumber),FONT(,,COLOR:Red,FONT:bold)
                       PANEL,AT(4,1,247,17),USE(?Panel1),BEVEL(2,-1)
                       GROUP,AT(255,2,119,72),USE(?Group1),BOXED,TRN,BEVEL(2,-1)
                         STRING('Invoice #:'),AT(258,6,61,14),USE(?String11),TRN,LEFT,FONT('MS Sans Serif',11,,FONT:bold+FONT:underline)
                         STRING(@n07),AT(323,9,41,10),USE(ORD:InvoiceNumber),CENTER,FONT(,,COLOR:Red,FONT:bold)
                         STRING('Ship To:'),AT(258,22,53,14),USE(?String1),TRN,FONT('MS Sans Serif',11,,FONT:bold+FONT:underline)
                         STRING(@s45),AT(258,36,113,9),USE(ORD:ShipToName)
                         STRING(@s35),AT(258,44,113,9),USE(ORD:ShipAddress1)
                         STRING(@s35),AT(258,52,113,9),USE(ORD:ShipAddress2)
                         STRING(@s40),AT(258,60,113,10),USE(GLOT:ShipCSZ)
                       END
                       BUTTON('&Insert'),AT(61,52,13,12),USE(?Insert:3),HIDE
                       BUTTON('&Change'),AT(42,53,13,12),USE(?Change:3),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(99,50,13,12),USE(?Delete:3),HIDE
                       SHEET,AT(3,108,249,84),USE(?Sheet2),WIZARD
                         TAB('Tab 2'),USE(?Tab2)
                         END
                       END
                       GROUP,AT(256,109,117,83),USE(?Group2),BOXED,BEVEL(2,-1)
                         STRING('Per Item'),AT(260,112,110,10),USE(?String13),LEFT(2),FONT('MS Sans Serif',8,,FONT:bold+FONT:underline)
                         STRING('%'),AT(340,123,21,10),USE(?String25)
                         STRING('Tax Rate:'),AT(260,123,43,10),USE(?String14),LEFT(2)
                         STRING(@n5.2),AT(314,123,26,10),USE(DTL:TaxRate),DECIMAL(16)
                         STRING('Discount Rate:'),AT(260,132,53,10),USE(?String15),LEFT(2)
                         LINE,AT(263,145,106,0),USE(?Line1),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Per Order'),AT(260,148,110,10),USE(?String18),LEFT(2),FONT('MS Sans Serif',8,,FONT:bold+FONT:underline)
                         STRING('Total Tax:'),AT(260,160,40,10),USE(?String19),LEFT(2)
                         STRING(@n$10.2),AT(314,160),USE(TotalTax),DECIMAL(15)
                         STRING('Total Discount:'),AT(260,169,54,10),USE(?String20),LEFT(2)
                         STRING(@n$10.2),AT(314,169),USE(TotalDiscount),DECIMAL(15)
                         STRING('Total Cost:'),AT(260,179,45,10),USE(?String21),LEFT(2),FONT(,,,FONT:bold)
                         STRING(@n$10.2B),AT(306,179),USE(TotalCost),DECIMAL(15),FONT(,,COLOR:Maroon,FONT:bold)
                         STRING(@n5.2),AT(314,132,26,10),USE(DTL:DiscountRate),DECIMAL(16)
                         STRING('%'),AT(340,132,23,10),USE(?String26),TRN
                       END
                       !STRING('Items per Order'),AT(0,112,19,73),USE(?String10),TRN,LEFT,FONT('Arial',11,,FONT:bold),ANGLE(900)
                       ! %%%%%%%%%%%%%%%%%  ANGLE() not recognized!!
                       STRING('Items per Order'),AT(0,112,19,73),USE(?String10),TRN,LEFT,FONT('Arial',11,,FONT:bold)

                       BUTTON,AT(49,142,28,14),USE(?Insert),FLAT,HIDE,FONT(,,COLOR:Green,FONT:bold),TIP('Insert a Detail record'),ICON('Insert.ico')
                       BUTTON,AT(99,140,33,14),USE(?Change),FLAT,HIDE,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Edit a Detail record'),ICON('Edit.ico')
                       BUTTON,AT(170,137,33,14),USE(?Delete),FLAT,HIDE,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Delete a Detail record'),ICON('Delete.ico')
                       BUTTON,AT(276,81,23,20),USE(?PInvButton),SKIP,FLAT,TIP('Print Selected Invoice'),ICON('PRINTER.ICO')
                       BUTTON,AT(132,60,15,15),USE(?Help),HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(330,81,23,20),USE(?Close),SKIP,FLAT,RIGHT,FONT('MS Serif',10,,FONT:bold),MSG('Close the browse'),TIP('Close the browse'),ICON('EXITS.ICO')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
OrdersBrowse         CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetQueue             PROCEDURE(BYTE ResetMode),DERIVED   ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
DetailBrowse         CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetFromView          PROCEDURE(),DERIVED                 ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('BrowseOrders')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('LOC:Shipped',LOC:Shipped)                          ! Added by: BrowseBox(ABC)
  BIND('GLOT:ShipName',GLOT:ShipName)                      ! Added by: BrowseBox(ABC)
  BIND('GLOT:ShipCSZ',GLOT:ShipCSZ)                        ! Added by: BrowseBox(ABC)
  BIND('LOC:Backorder',LOC:Backorder)                      ! Added by: BrowseBox(ABC)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  GLOT:CustName = CLIP(CUS:FirstName) & '   ' & CLIP(CUS:LastName)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  OrdersBrowse.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Orders,SELF) ! Initialize the browse manager
  DetailBrowse.Init(?List,Queue:Browse.ViewPosition,BRW5::View:Browse,Queue:Browse,Relate:Detail,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  ! Disable select on second list box
  ?List{PROP:NoBar} = TRUE
  ?Browse:1{Prop:LineHeight} = 0
  ?List{Prop:LineHeight} = 0
  Do DefineListboxStyle
  OrdersBrowse.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon ORD:OrderNumber for sort order 1
  OrdersBrowse.AddSortOrder(BRW1::Sort0:StepClass,ORD:KeyCustOrderNumber) ! Add the sort order for ORD:KeyCustOrderNumber for sort order 1
  OrdersBrowse.AddRange(ORD:CustNumber,Relate:Orders,Relate:Customers) ! Add file relationship range limit for sort order 1
  OrdersBrowse.AddLocator(BRW1::Sort0:Locator)             ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,ORD:OrderNumber,1,OrdersBrowse) ! Initialize the browse locator using  using key: ORD:KeyCustOrderNumber , ORD:OrderNumber
  OrdersBrowse.AddField(ORD:OrderNumber,OrdersBrowse.Q.ORD:OrderNumber) ! Field ORD:OrderNumber is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:OrderDate,OrdersBrowse.Q.ORD:OrderDate) ! Field ORD:OrderDate is a hot field or requires assignment from browse
  OrdersBrowse.AddField(LOC:Shipped,OrdersBrowse.Q.LOC:Shipped) ! Field LOC:Shipped is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:OrderNote,OrdersBrowse.Q.ORD:OrderNote) ! Field ORD:OrderNote is a hot field or requires assignment from browse
  OrdersBrowse.AddField(GLOT:ShipName,OrdersBrowse.Q.GLOT:ShipName) ! Field GLOT:ShipName is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipToName,OrdersBrowse.Q.ORD:ShipToName) ! Field ORD:ShipToName is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipAddress1,OrdersBrowse.Q.ORD:ShipAddress1) ! Field ORD:ShipAddress1 is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipAddress2,OrdersBrowse.Q.ORD:ShipAddress2) ! Field ORD:ShipAddress2 is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipCity,OrdersBrowse.Q.ORD:ShipCity) ! Field ORD:ShipCity is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipState,OrdersBrowse.Q.ORD:ShipState) ! Field ORD:ShipState is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:ShipZip,OrdersBrowse.Q.ORD:ShipZip) ! Field ORD:ShipZip is a hot field or requires assignment from browse
  OrdersBrowse.AddField(GLOT:ShipCSZ,OrdersBrowse.Q.GLOT:ShipCSZ) ! Field GLOT:ShipCSZ is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:InvoiceNumber,OrdersBrowse.Q.ORD:InvoiceNumber) ! Field ORD:InvoiceNumber is a hot field or requires assignment from browse
  OrdersBrowse.AddField(ORD:CustNumber,OrdersBrowse.Q.ORD:CustNumber) ! Field ORD:CustNumber is a hot field or requires assignment from browse
  DetailBrowse.Q &= Queue:Browse
  DetailBrowse.AddSortOrder(,DTL:KeyDetails)               ! Add the sort order for DTL:KeyDetails for sort order 1
  DetailBrowse.AddRange(DTL:OrderNumber,Relate:Detail,Relate:Orders) ! Add file relationship range limit for sort order 1
  DetailBrowse.AddLocator(BRW5::Sort0:Locator)             ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,DTL:LineNumber,1,DetailBrowse) ! Initialize the browse locator using  using key: DTL:KeyDetails , DTL:LineNumber
  DetailBrowse.AddField(PRO:Description,DetailBrowse.Q.PRO:Description) ! Field PRO:Description is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:QuantityOrdered,DetailBrowse.Q.DTL:QuantityOrdered) ! Field DTL:QuantityOrdered is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:Price,DetailBrowse.Q.DTL:Price) ! Field DTL:Price is a hot field or requires assignment from browse
  DetailBrowse.AddField(LOC:Backorder,DetailBrowse.Q.LOC:Backorder) ! Field LOC:Backorder is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:TaxPaid,DetailBrowse.Q.DTL:TaxPaid) ! Field DTL:TaxPaid is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:Discount,DetailBrowse.Q.DTL:Discount) ! Field DTL:Discount is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:TotalCost,DetailBrowse.Q.DTL:TotalCost) ! Field DTL:TotalCost is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:TaxRate,DetailBrowse.Q.DTL:TaxRate) ! Field DTL:TaxRate is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:DiscountRate,DetailBrowse.Q.DTL:DiscountRate) ! Field DTL:DiscountRate is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:CustNumber,DetailBrowse.Q.DTL:CustNumber) ! Field DTL:CustNumber is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:OrderNumber,DetailBrowse.Q.DTL:OrderNumber) ! Field DTL:OrderNumber is a hot field or requires assignment from browse
  DetailBrowse.AddField(DTL:LineNumber,DetailBrowse.Q.DTL:LineNumber) ! Field DTL:LineNumber is a hot field or requires assignment from browse
  DetailBrowse.AddField(PRO:ProductNumber,DetailBrowse.Q.PRO:ProductNumber) ! Field PRO:ProductNumber is a hot field or requires assignment from browse
  QuickWindow{PROP:MinWidth}=375                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=193                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  OrdersBrowse.AskProcedure = 1
  DetailBrowse.AskProcedure = 2
  OrdersBrowse.AddToolbarTarget(Toolbar)                   ! Browse accepts toolbar control
  OrdersBrowse.ToolbarItem.HelpButton = ?Help
  DetailBrowse.AddToolbarTarget(Toolbar)                   ! Browse accepts toolbar control
  DetailBrowse.ToolbarItem.HelpButton = ?Help
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


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      UpdateOrders
      UpdateDetail
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
    OF ?PInvButton
      ThisWindow.Update
      PrintInvoiceFromBrowse
      ThisWindow.Reset
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
    CASE FIELD()
    OF ?Browse:1
      Toolbar.SetTarget(?Browse:1) !BRW1
    OF ?List
      Toolbar.SetTarget(?Browse:1) !BRW1
    END
  ReturnValue = PARENT.TakeSelected()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


OrdersBrowse.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


OrdersBrowse.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


OrdersBrowse.ResetQueue PROCEDURE(BYTE ResetMode)

  CODE
  PARENT.ResetQueue(ResetMode)
  !Enable and Disable control
  DetailBrowse.InsertControl{PROP:DISABLE} = CHOOSE(RECORDS(SELF.ListQueue) <> 0,FALSE,TRUE)


OrdersBrowse.SetQueueRecord PROCEDURE

  CODE
  GLOT:ShipCSZ = CLIP(ORD:ShipCity) & ',  ' & ORD:ShipState & '   ' & CLIP(ORD:ShipZip)
  IF (ORD:OrderShipped)
    LOC:Shipped = 'Yes'
  ELSE
    LOC:Shipped = 'No'
  END
  PARENT.SetQueueRecord
  
  SELF.Q.LOC:Shipped = LOC:Shipped                         !Assign formula result to display queue


DetailBrowse.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


DetailBrowse.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


DetailBrowse.ResetFromView PROCEDURE

TotalTax:Sum         REAL                                  ! Sum variable for browse totals
TotalDiscount:Sum    REAL                                  ! Sum variable for browse totals
TotalCost:Sum        REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Detail.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    TotalTax:Sum += DTL:TaxPaid
    TotalDiscount:Sum += DTL:Discount
    TotalCost:Sum += DTL:TotalCost
  END
  TotalTax = TotalTax:Sum
  TotalDiscount = TotalDiscount:Sum
  TotalCost = TotalCost:Sum
  PARENT.ResetFromView
  Relate:Detail.SetQuickScan(0)
  SETCURSOR()


DetailBrowse.SetQueueRecord PROCEDURE

  CODE
  IF (DTL:BackOrdered)
    LOC:Backorder = 'Yes'
  ELSE
    LOC:Backorder = 'No'
  END
  PARENT.SetQueueRecord
  
  SELF.Q.LOC:Backorder = LOC:Backorder                     !Assign formula result to display queue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window


BrowseCustomers PROCEDURE                                  ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
LOC:NameLetter       STRING(1)                             !
LOC:CompanyLetter    STRING(1)                             !
LOC:ZipNum           STRING(2)                             !
LOC:State            STRING(2)                             !
LOC:FilterString     STRING(255)                           !
BRW1::View:Browse    VIEW(Customers)
                       PROJECT(CUS:FirstName)
                       PROJECT(CUS:MI)
                       PROJECT(CUS:LastName)
                       PROJECT(CUS:Company)
                       PROJECT(CUS:State)
                       PROJECT(CUS:ZipCode)
                       PROJECT(CUS:Address1)
                       PROJECT(CUS:Address2)
                       PROJECT(CUS:City)
                       PROJECT(CUS:PhoneNumber)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
CUS:FirstName          LIKE(CUS:FirstName)            !List box control field - type derived from field
CUS:MI                 LIKE(CUS:MI)                   !List box control field - type derived from field
CUS:LastName           LIKE(CUS:LastName)             !List box control field - type derived from field
CUS:Company            LIKE(CUS:Company)              !List box control field - type derived from field
CUS:State              LIKE(CUS:State)                !List box control field - type derived from field
CUS:ZipCode            LIKE(CUS:ZipCode)              !List box control field - type derived from field
CUS:Address1           LIKE(CUS:Address1)             !Browse hot field - type derived from field
CUS:Address2           LIKE(CUS:Address2)             !Browse hot field - type derived from field
CUS:City               LIKE(CUS:City)                 !Browse hot field - type derived from field
GLOT:CusCSZ            LIKE(GLOT:CusCSZ)              !Browse hot field - type derived from global data
CUS:PhoneNumber        LIKE(CUS:PhoneNumber)          !Browse hot field - type derived from field
LOC:FilterString       LIKE(LOC:FilterString)         !Browse hot field - type derived from local data
LOC:CompanyLetter      LIKE(LOC:CompanyLetter)        !Browse hot field - type derived from local data
LOC:ZipNum             LIKE(LOC:ZipNum)               !Browse hot field - type derived from local data
LOC:State              LIKE(LOC:State)                !Browse hot field - type derived from local data
LOC:NameLetter         LIKE(LOC:NameLetter)           !Browse hot field - type derived from local data
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse Customers'),AT(,,322,227),FONT('MS Sans Serif',8,COLOR:Black,),CENTER,IMM,ICON('CUSTOMER.ICO'),HLP('~BrowseCustomers'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(3,1,318,223),USE(?CurrentTab)
                         TAB('FullName'),USE(?Tab:2)
                           STRING('Locator: Lastname'),AT(11,20,77,10),USE(?String7),FONT('MS Sans Serif',8,,FONT:bold)
                           STRING(@s25),AT(92,20,104,10),USE(CUS:LastName),TRN,FONT(,,COLOR:Red,FONT:bold)
                         END
                         TAB('Company'),USE(?Tab:3)
                           STRING('Locator: Company'),AT(13,20,73,10),USE(?String12),FONT(,,,FONT:bold)
                           STRING(@s20),AT(90,20,83,10),USE(CUS:Company),TRN,FONT(,,COLOR:Red,FONT:bold)
                         END
                         TAB('ZipCode'),USE(?Tab:4)
                           STRING('Locator:  Zipcode'),AT(11,20,71,10),USE(?String13),FONT(,,,FONT:bold)
                           STRING(@K#####|-####KB),AT(87,20,51,10),USE(CUS:ZipCode),TRN,FONT(,,COLOR:Red,FONT:bold)
                         END
                         TAB('State'),USE(?Tab:5)
                           STRING(@s2),AT(73,20,26,10),USE(CUS:State),TRN,CENTER,FONT(,,COLOR:Red,FONT:bold)
                           STRING('Locator: State'),AT(12,20,62,10),USE(?String14),FONT(,,,FONT:bold)
                         END
                       END
                       LIST,AT(12,33,301,124),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('63L(2)|M~First Name~@s20@14C|M~MI~L(1)@s1@63L(2)|M~Last Name~@s25@71L(2)|M~Compa' &|
   'ny~@s20@22C|M~State~L(1)@s2@80L(1)|M~Zip Code~L(2)@K#####|-####KB@'),FROM(Queue:Browse:1)
                       BUTTON('&Select'),AT(193,113,28,14),USE(?Select:2),HIDE
                       BUTTON('&Insert'),AT(159,113,27,14),USE(?Insert:3),HIDE
                       BUTTON('&Change'),AT(93,114,25,14),USE(?Change:3),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(253,113,30,14),USE(?Delete:3),HIDE
                       BUTTON,AT(132,112,15,14),USE(?Help),HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       GROUP,AT(6,167,177,52),USE(?Group1),BOXED,BEVEL(2,-1)
                         STRING('Customer''s Address'),AT(10,169,150,10),USE(?String1),LEFT(2),FONT('MS Sans Serif',10,COLOR:Navy,FONT:bold+FONT:underline)
                         STRING(@s35),AT(10,180,169,9),USE(CUS:Address1),FONT(,,COLOR:Teal,FONT:bold)
                         STRING(@s35),AT(10,188,167,9),USE(CUS:Address2),FONT(,,COLOR:Teal,FONT:bold)
                         STRING(@s40),AT(10,196,169,11),USE(GLOT:CusCSZ),FONT(,,COLOR:Teal,FONT:bold)
                         STRING('Phone Number:'),AT(10,206,64,10),USE(?PString),FONT(,,COLOR:Navy,FONT:bold)
                         STRING(@P(###) ###-####PB),AT(73,206,72,10),USE(CUS:PhoneNumber),CENTER,FONT(,,COLOR:Teal,FONT:bold)
                       END
                       BUTTON('&Print'),AT(187,168,42,14),USE(?Print),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Print selected customer info')
                       BUTTON('&Query'),AT(187,186,42,14),USE(?Query),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Query by example')
                       BUTTON('Orders'),AT(239,175,36,39),USE(?BOButton),SKIP,FLAT,FONT('MS Sans Serif',8,COLOR:Navy,FONT:bold),MSG('Browse the selected Customer''s Orders'),TIP('Browse the selected Customer''s Orders'),ICON('NOTE14.ICO')
                       BUTTON('Close'),AT(281,175,36,39),USE(?Close),SKIP,FLAT,FONT('MS Sans Serif',8,COLOR:Navy,FONT:bold),TIP('Exit browse'),ICON('EXITS.ICO')
                       BUTTON('&Toolbox'),AT(187,204),USE(?Toolbox),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Floating toolbox')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass
QBE6                 QueryFormClass                        ! QBE List Class. 
QBV6                 QueryFormVisual                       ! QBE Visual Class
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
SetQueueRecord         PROCEDURE(),DERIVED                 ! Method added to host embed code
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
BRW1::Sort1:Locator  FilterLocatorClass                    ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort2:Locator  FilterLocatorClass                    ! Conditional Locator - CHOICE(?CurrentTab) = 3
BRW1::Sort3:Locator  FilterLocatorClass                    ! Conditional Locator - CHOICE(?CurrentTab) = 4
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
BRW1::Sort1:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
BRW1::Sort2:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 3
BRW1::Sort3:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 4
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
  GlobalErrors.SetProcedureName('BrowseCustomers')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String7
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLOT:CusCSZ',GLOT:CusCSZ)                          ! Added by: BrowseBox(ABC)
  BIND('LOC:FilterString',LOC:FilterString)                ! Added by: BrowseBox(ABC)
  BIND('LOC:CompanyLetter',LOC:CompanyLetter)              ! Added by: BrowseBox(ABC)
  BIND('LOC:ZipNum',LOC:ZipNum)                            ! Added by: BrowseBox(ABC)
  BIND('LOC:State',LOC:State)                              ! Added by: BrowseBox(ABC)
  BIND('LOC:NameLetter',LOC:NameLetter)                    ! Added by: BrowseBox(ABC)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)                    ! Add the close control to the window amanger
  Relate:Customers.Open                                    ! File Customers used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Customers,SELF) ! Initialize the browse manager
  OPEN(QuickWindow)                                        ! Open window
  SELF.Opened=True
  ?Browse:1{Prop:LineHeight} = 0
  Do DefineListboxStyle
  QBE6.Init(QBV6, INIMgr,'BrowseCustomers', GlobalErrors)
  QBE6.QkSupport = True
  QBE6.QkMenuIcon = 'QkQBE.ico'
  QBE6.QkIcon = 'QkLoad.ico'
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CUS:Company for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,CUS:KeyCompany)  ! Add the sort order for CUS:KeyCompany for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?CUS:Company,CUS:Company,1,BRW1) ! Initialize the browse locator using ?CUS:Company using key: CUS:KeyCompany , CUS:Company
  BRW1::Sort2:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CUS:ZipCode for sort order 2
  BRW1.AddSortOrder(BRW1::Sort2:StepClass,CUS:KeyZipCode)  ! Add the sort order for CUS:KeyZipCode for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(?CUS:ZipCode,CUS:ZipCode,1,BRW1) ! Initialize the browse locator using ?CUS:ZipCode using key: CUS:KeyZipCode , CUS:ZipCode
  BRW1::Sort3:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CUS:State for sort order 3
  BRW1.AddSortOrder(BRW1::Sort3:StepClass,CUS:StateKey)    ! Add the sort order for CUS:StateKey for sort order 3
  BRW1.AddLocator(BRW1::Sort3:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort3:Locator.Init(?CUS:State,CUS:State,1,BRW1)    ! Initialize the browse locator using ?CUS:State using key: CUS:StateKey , CUS:State
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon CUS:LastName for sort order 4
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,CUS:KeyFullName) ! Add the sort order for CUS:KeyFullName for sort order 4
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 4
  BRW1::Sort0:Locator.Init(?CUS:LastName,CUS:LastName,1,BRW1) ! Initialize the browse locator using ?CUS:LastName using key: CUS:KeyFullName , CUS:LastName
  BRW1.AddField(CUS:FirstName,BRW1.Q.CUS:FirstName)        ! Field CUS:FirstName is a hot field or requires assignment from browse
  BRW1.AddField(CUS:MI,BRW1.Q.CUS:MI)                      ! Field CUS:MI is a hot field or requires assignment from browse
  BRW1.AddField(CUS:LastName,BRW1.Q.CUS:LastName)          ! Field CUS:LastName is a hot field or requires assignment from browse
  BRW1.AddField(CUS:Company,BRW1.Q.CUS:Company)            ! Field CUS:Company is a hot field or requires assignment from browse
  BRW1.AddField(CUS:State,BRW1.Q.CUS:State)                ! Field CUS:State is a hot field or requires assignment from browse
  BRW1.AddField(CUS:ZipCode,BRW1.Q.CUS:ZipCode)            ! Field CUS:ZipCode is a hot field or requires assignment from browse
  BRW1.AddField(CUS:Address1,BRW1.Q.CUS:Address1)          ! Field CUS:Address1 is a hot field or requires assignment from browse
  BRW1.AddField(CUS:Address2,BRW1.Q.CUS:Address2)          ! Field CUS:Address2 is a hot field or requires assignment from browse
  BRW1.AddField(CUS:City,BRW1.Q.CUS:City)                  ! Field CUS:City is a hot field or requires assignment from browse
  BRW1.AddField(GLOT:CusCSZ,BRW1.Q.GLOT:CusCSZ)            ! Field GLOT:CusCSZ is a hot field or requires assignment from browse
  BRW1.AddField(CUS:PhoneNumber,BRW1.Q.CUS:PhoneNumber)    ! Field CUS:PhoneNumber is a hot field or requires assignment from browse
  BRW1.AddField(LOC:FilterString,BRW1.Q.LOC:FilterString)  ! Field LOC:FilterString is a hot field or requires assignment from browse
  BRW1.AddField(LOC:CompanyLetter,BRW1.Q.LOC:CompanyLetter) ! Field LOC:CompanyLetter is a hot field or requires assignment from browse
  BRW1.AddField(LOC:ZipNum,BRW1.Q.LOC:ZipNum)              ! Field LOC:ZipNum is a hot field or requires assignment from browse
  BRW1.AddField(LOC:State,BRW1.Q.LOC:State)                ! Field LOC:State is a hot field or requires assignment from browse
  BRW1.AddField(LOC:NameLetter,BRW1.Q.LOC:NameLetter)      ! Field LOC:NameLetter is a hot field or requires assignment from browse
  QuickWindow{PROP:MinWidth}=315                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=209                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.QueryControl = ?Query
  BRW1.Query &= QBE6
  QBE6.AddItem('UPPER(CUS:FirstName)','FirstName','@s20',1)
  QBE6.AddItem('UPPER(CUS:LastName)','LastName','@s25',1)
  QBE6.AddItem('UPPER(CUS:Company)','Company','@s25',1)
  QBE6.AddItem('UPPER(CUS:ZipCode)','Zipcode','@s10',1)
  QBE6.AddItem('CUS:State','State','@s2',1)
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
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


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      UpdateCustomers
      PrintSelectedCustomer
    END
    ReturnValue = GlobalResponse
  END
  IF Number = 2
    ThisWindow.Reset(TRUE)
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
    OF ?BOButton
      ThisWindow.Update
      BrowseOrders
      ThisWindow.Reset
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
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ToolControl = ?Toolbox


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?CurrentTab) = 3
    RETURN SELF.SetSort(2,Force)
  ELSIF CHOICE(?CurrentTab) = 4
    RETURN SELF.SetSort(3,Force)
  ELSE
    RETURN SELF.SetSort(4,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  GLOT:CusCSZ = CLIP(CUS:City) & ',  ' & CUS:State & '   ' & CLIP(CUS:ZipCode)
  PARENT.SetQueueRecord
  


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

CityStateZip         PROCEDURE  (LOC:City,LOC:State,LOC:Zip) ! Declare Procedure
  CODE
 !Format City, State, and Zip
  IF OMITTED(1) OR LOC:City = ''
    RETURN(LOC:State &'  '& LOC:Zip)
  ELSIF OMITTED(2) OR LOC:State = ''
    RETURN(CLIP(LOC:City) &',  '& LOC:Zip)
  ELSIF OMITTED(3) OR LOC:Zip = ''
    RETURN(CLIP(LOC:City) &',  '& LOC:State)
  ELSE
    RETURN(CLIP(LOC:City) &', '& LOC:State &'  '& LOC:Zip)
  END

PrintSelectedCustomer PROCEDURE                            ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
Progress:Thermometer BYTE                                  !
LOC:CSZ              STRING(45)                            !
LOC:Address          STRING(45)                            !
Process:View         VIEW(Customers)
                       PROJECT(CUS:Address1)
                       PROJECT(CUS:Address2)
                       PROJECT(CUS:City)
                       PROJECT(CUS:Company)
                       PROJECT(CUS:Extension)
                       PROJECT(CUS:FirstName)
                       PROJECT(CUS:LastName)
                       PROJECT(CUS:MI)
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

report               REPORT,AT(1000,1167,6500,9104),PRE(RPT),FONT('MS Serif',8,,FONT:regular),THOUS
                       HEADER,AT(1000,500,6500,760)
                         STRING('Customer Information'),AT(21,10,6448,354),USE(?String16),CENTER,FONT('MS Serif',18,,FONT:bold+FONT:underline)
                       END
detail                 DETAIL,AT(10,,6500,1500),USE(?detail)
                         STRING('Name:'),AT(1146,94,1844,167),TRN,FONT('MS Serif',10,COLOR:Black,FONT:regular)
                         STRING(@s35),AT(3083,94,2604,167),USE(GLOT:CustName)
                         STRING('Company:'),AT(1146,354,1844,167),TRN,FONT('MS Serif',10,COLOR:Black,FONT:regular)
                         STRING(@P<<<#PB),AT(3948,1135,333,167),USE(CUS:Extension),RIGHT
                         STRING(@s20),AT(3083,354,1719,167),USE(CUS:Company)
                         STRING('Address:'),AT(1146,615,1844,167),USE(?String12),TRN
                         STRING(@s45),AT(3083,615,2667,167),USE(LOC:Address)
                         STRING('City/State/Zip:'),AT(1146,875,1844,167),USE(?String11),TRN,FONT('MS Serif',10,COLOR:Black,FONT:regular)
                         STRING(@s45),AT(3083,875,2552,167),USE(LOC:CSZ)
                         STRING(@P(###) ###-####PB),AT(3083,1135,865,167),USE(CUS:PhoneNumber)
                         STRING('Phone#/Extension:'),AT(1146,1135,1844,167),USE(?String13),TRN,FONT('MS Serif',10,COLOR:Black,FONT:regular)
                       END
                       FOOTER,AT(1000,10260,6500,271)
                         STRING(@pPage <<<#p),AT(5229,31,729,188),PAGENO,USE(?PageCount),FONT('MS Serif',10,COLOR:Black,FONT:regular)
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
  GlobalErrors.SetProcedureName('PrintSelectedCustomer')
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
  ThisReport.Init(Process:View, Relate:Customers, ?Progress:PctText, Progress:Thermometer, ProgressMgr, CUS:LastName)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(CUS:KeyFullName)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Customers.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  SELF.DeferWindow = 0
  SELF.WaitCursor = 1
  IF SELF.OriginalRequest = ProcessRecord
    CLEAR(SELF.DeferWindow,1)
    ThisReport.AddRange(CUS:MI)        ! Overrides any previous range
  END
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
  IF (CUS:Address2 = '')
    LOC:Address = CUS:Address1
  ELSE
    LOC:Address = CLIP(CUS:Address1) & ',  ' & CUS:Address2
  END
  LOC:CSZ = CityStateZip(CUS:City,CUS:State,CUS:ZipCode)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

PrintSelectedProduct PROCEDURE                             ! Generated from procedure template - Report

LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
Progress:Thermometer BYTE                                  !
Process:View         VIEW(Products)
                       PROJECT(PRO:Cost)
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

report               REPORT,AT(1000,896,6500,9125),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1000,458,6500,427)
                         STRING(' Product Information'),AT(21,10,6458,240),CENTER,FONT('MS Serif',14,,FONT:bold+FONT:underline)
                       END
detail                 DETAIL,AT(,,7500,1792),USE(?detail)
                         STRING('Product SKU:'),AT(219,10,896,188),TRN
                         IMAGE,AT(4417,10,1885,1771),USE(?Image1)
                         STRING(@s10),AT(1542,10,896,167),USE(PRO:ProductSKU)
                         STRING(@s35),AT(1542,313,2375,167),USE(PRO:Description)
                         STRING('Quantity In Stock:'),AT(219,615,1135,188),TRN
                         STRING('Re-order Quantity:'),AT(219,917,1188,188),USE(?String12),TRN
                         STRING('Unit Price:'),AT(219,1219,698,188),TRN
                         STRING(@n$10.2B),AT(1542,1208,771,208),USE(PRO:Price)
                         STRING('Unit Cost:'),AT(219,1542),USE(?String14),TRN
                         STRING(@n$10.2B),AT(1542,1542),USE(PRO:Cost)
                         STRING('Description:'),AT(219,313,802,188),TRN
                         STRING(@n6),AT(1542,917,563,167),USE(PRO:ReorderQuantity),RIGHT
                         STRING(@n-7),AT(1542,615,573,167),USE(PRO:QuantityInStock),RIGHT
                       END
                       FOOTER,AT(1000,10042,6500,240)
                         STRING(@pPage <<<#p),AT(5542,10,865,208),PAGENO,USE(?PageCount),FONT('Arial',10,COLOR:Black,)
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
  GlobalErrors.SetProcedureName('PrintSelectedProduct')
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
  SELF.DeferWindow = 0
  SELF.WaitCursor = 1
  IF SELF.OriginalRequest = ProcessRecord
    CLEAR(SELF.DeferWindow,1)
    ThisReport.AddRange(PRO:ProductSKU)        ! Overrides any previous range
  END
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
  Report$?Image1{PROP:TEXT} = PRO:PictureFile
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue


BrowseProducts PROCEDURE                                   ! Generated from procedure template - Window

CurrentTab           STRING(80)                            !
LocalRequest         LONG                                  !
FilesOpened          BYTE                                  !
BRW1::View:Browse    VIEW(Products)
                       PROJECT(PRO:Description)
                       PROJECT(PRO:ProductSKU)
                       PROJECT(PRO:Price)
                       PROJECT(PRO:QuantityInStock)
                       PROJECT(PRO:PictureFile)
                       PROJECT(PRO:ProductNumber)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
PRO:Description        LIKE(PRO:Description)          !List box control field - type derived from field
PRO:ProductSKU         LIKE(PRO:ProductSKU)           !List box control field - type derived from field
PRO:Price              LIKE(PRO:Price)                !List box control field - type derived from field
PRO:QuantityInStock    LIKE(PRO:QuantityInStock)      !List box control field - type derived from field
PRO:PictureFile        LIKE(PRO:PictureFile)          !Browse hot field - type derived from field
PRO:ProductNumber      LIKE(PRO:ProductNumber)        !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
!QuickWindow          WINDOW('Browse Products '),AT(,,403,180),FONT('MS Sans Serif',8,,),CENTER,IMM,HVSCROLL,ICON('FLOW04.ICO'),HLP('~BrowseProducts'),PALETTE(254),SYSTEM,GRAY,RESIZE,MDI
!                             PALETTE() not recognized! %%%%%%%%%% 
QuickWindow          WINDOW('Browse Products '),AT(,,403,180),FONT('MS Sans Serif',8,,),CENTER,IMM,HVSCROLL,ICON('FLOW04.ICO'),HLP('~BrowseProducts'),SYSTEM,GRAY,RESIZE,MDI

                       SHEET,AT(4,0,395,177),USE(?CurrentTab)
                         TAB('Description')
                           STRING('Filter Locator: Description'),AT(9,15,103,11),USE(?String1),FONT('MS Sans Serif',8,COLOR:Black,FONT:bold)
                           STRING(@s35),AT(119,15,113,10),USE(PRO:Description),TRN,FONT(,,COLOR:Maroon,FONT:bold)
                         END
                         TAB('ProductSKU')
                           STRING('Incremental Locator: Product SKU'),AT(11,15,137,10),USE(?String4),FONT(,,,FONT:bold)
                           STRING(@s10),AT(149,15,49,10),USE(PRO:ProductSKU),FONT(,,COLOR:Maroon,FONT:bold)
                         END
                       END
                       LIST,AT(10,26,250,132),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('93L(2)|M~Description~@s35@45L(3)|M~Product SKU~L(1)@s10@37D(16)|M~Price~L(2)@n$1' &|
   '0.2B@58D(30)|M~Quantity In Stock~L(1)@n-10.2B@'),FROM(Queue:Browse:1)
                       BUTTON('&Print'),AT(9,161,39,12),USE(?Print),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Print selected product information')
                       BUTTON('&Query'),AT(119,161,39,12),USE(?Query),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Query by example')
                       BUTTON('&Toolbox'),AT(221,161,39,12),USE(?Toolbox),SKIP,FLAT,FONT(,,COLOR:Navy,FONT:bold),TIP('Floating toolbox')
                       STRING('Double-Click:- Edit-In-Place (Price & Quantity); Toolbar buttons:- Update form.'),AT(95,0,303,12),USE(?String3),CENTER,FONT(,,COLOR:Maroon,FONT:bold)
                       IMAGE,AT(267,26,123,134),USE(?Image1)
                       BUTTON('&Insert'),AT(145,125,28,12),USE(?Insert),HIDE
                       BUTTON('&Change'),AT(187,125,28,12),USE(?Change),HIDE
                       BUTTON('&Delete'),AT(21,118,28,12),USE(?Delete),HIDE
                       BUTTON,AT(229,124,13,12),USE(?Help),HIDE,TIP('Get Help'),ICON(ICON:Help),STD(STD:Help)
                       BUTTON,AT(371,161,20,12),USE(?Close),SKIP,FLAT,MSG('Exit Browse'),TIP('Exit Browse'),ICON('EXITS.ICO')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Reset                  PROCEDURE(BYTE Force=0),DERIVED     ! Method added to host embed code
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
                     END

Toolbar              ToolbarClass
QBE6                 QueryFormClass                        ! QBE List Class. 
QBV6                 QueryFormVisual                       ! QBE Visual Class
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Ask                    PROCEDURE(BYTE Request),BYTE,PROC,DERIVED ! Method added to host embed code
Fetch                  PROCEDURE(BYTE Direction),DERIVED   ! Method added to host embed code
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM) ! Method added to host embed code
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED ! Method added to host embed code
TakeKey                PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator
BRW1::Sort1:Locator  IncrementalLocatorClass               ! Conditional Locator - CHOICE(?CurrentTab) = 2
BRW1::Sort0:StepClass StepStringClass                      ! Default Step Manager
BRW1::Sort1:StepClass StepStringClass                      ! Conditional Step Manager - CHOICE(?CurrentTab) = 2
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
  GlobalErrors.SetProcedureName('BrowseProducts')
  !Set default update action
   BRW1.AskProcedure = 1
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String1
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
  QBE6.Init(QBV6, INIMgr,'BrowseProducts', GlobalErrors)
  QBE6.QkSupport = True
  QBE6.QkMenuIcon = 'QkQBE.ico'
  QBE6.QkIcon = 'QkLoad.ico'
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort1:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon PRO:ProductSKU for sort order 1
  BRW1.AddSortOrder(BRW1::Sort1:StepClass,PRO:KeyProductSKU) ! Add the sort order for PRO:KeyProductSKU for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?PRO:ProductSKU,PRO:ProductSKU,1,BRW1) ! Initialize the browse locator using ?PRO:ProductSKU using key: PRO:KeyProductSKU , PRO:ProductSKU
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime) ! Moveable thumb based upon PRO:Description for sort order 2
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,PRO:KeyDescription) ! Add the sort order for PRO:KeyDescription for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(?PRO:Description,PRO:Description,1,BRW1) ! Initialize the browse locator using ?PRO:Description using key: PRO:KeyDescription , PRO:Description
  BRW1.AddField(PRO:Description,BRW1.Q.PRO:Description)    ! Field PRO:Description is a hot field or requires assignment from browse
  BRW1.AddField(PRO:ProductSKU,BRW1.Q.PRO:ProductSKU)      ! Field PRO:ProductSKU is a hot field or requires assignment from browse
  BRW1.AddField(PRO:Price,BRW1.Q.PRO:Price)                ! Field PRO:Price is a hot field or requires assignment from browse
  BRW1.AddField(PRO:QuantityInStock,BRW1.Q.PRO:QuantityInStock) ! Field PRO:QuantityInStock is a hot field or requires assignment from browse
  BRW1.AddField(PRO:PictureFile,BRW1.Q.PRO:PictureFile)    ! Field PRO:PictureFile is a hot field or requires assignment from browse
  BRW1.AddField(PRO:ProductNumber,BRW1.Q.PRO:ProductNumber) ! Field PRO:ProductNumber is a hot field or requires assignment from browse
  QuickWindow{PROP:MinWidth}=403                           ! Restrict the minimum window width
  QuickWindow{PROP:MinHeight}=180                          ! Restrict the minimum window height
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.QueryControl = ?Query
  BRW1.UpdateQuery(QBE6,1)
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
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


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  !Display image
  ?Image1{PROP:TEXT} = Products.Record.PictureFile
  ResizeImage(?Image1,267,19,123,134)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      UpdateProducts
      PrintSelectedProduct
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Ask PROCEDURE(BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Ask(Request)
  !Set action back after edit-in-place
  BRW1.AskProcedure = 1
  RETURN ReturnValue


BRW1.Fetch PROCEDURE(BYTE Direction)

GreenBarIndex   LONG
  CODE
  PARENT.Fetch(Direction)


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(,2) ! PRO:ProductSKU Disable
  SELF.AddEditControl(,1) ! PRO:Description Disable
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END
  SELF.ToolControl = ?Toolbox


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


BRW1.TakeKey PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  !Set update action for edit-in-place
  IF RECORDS(SELF.ListQueue) AND KEYCODE() = MouseLeft2
    BRW1.AskProcedure = 0
  END
  ReturnValue = PARENT.TakeKey()
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.DeferMoves=False
  SELF.SetParentDefaults                                   ! Calculate default control parent-child relationships based upon their positions on the window

