

   MEMBER('Cardreg.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('CARDR001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('CARDR002.INC'),ONCE        !Req'd for module callout resolution
                     END


AuthorInformation PROCEDURE                           !Generated from procedure template - Window

LocalRequest         LONG
FilesOpened          BYTE
window               WINDOW('About the Author...'),AT(,,232,88),CENTER,ICON('CREDCARD.ICO'),GRAY,DOUBLE,MDI,IMM  ! PALETTE(256), %%%%%%%%%%%%%%%%
                       PANEL,AT(6,7,61,77),USE(?Panel1),BEVEL(-1,2)
                       STRING('Barbara Klepeisz,'),AT(73,8),USE(?String1),TRN
                       IMAGE('BARBARA.JPG'),AT(12,13,50,65),USE(?Image1)
                       PANEL,AT(73,28,150,56),USE(?Panel2),BEVEL(-1,2)
                       STRING('Barbara has a life'),AT(122,34),USE(?String3),CENTER,FONT('Arial',9,,FONT:bold+FONT:italic)
                       STRING('which also runs at top speed.  She has two'),AT(88,43),USE(?String4),CENTER,FONT('Arial',9,,FONT:bold+FONT:italic)
                       STRING('daughters who have assisted her in testing this'),AT(81,52),USE(?String5),CENTER,FONT('Arial',9,,FONT:bold+FONT:italic)
                       STRING('application by encouraging frequent credit card '),AT(80,61),USE(?String6),CENTER,FONT('Arial',9,,FONT:bold+FONT:italic)
                       STRING('purchases at the mall.'),AT(117,70),USE(?String6:2),CENTER,FONT('Arial',9,,FONT:bold+FONT:italic)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AuthorInformation')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  OPEN(window)
  SELF.Opened=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue

Main PROCEDURE                                        !Generated from procedure template - Frame

LocalRequest         LONG
FilesOpened          BYTE
CurrentTab           STRING(80)
SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Credit Card Registry & Transaction Log'),AT(,,400,246),FONT('MS Sans Serif',8,,),ICON('CREDCARD.ICO'),HLP('~CardRegMainWindow'),STATUS(-1,80,120,45),TILED,SYSTEM,MAX,RESIZE,IMM
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
                           ITEM('Browse the &Accounts file'),USE(?BrowseAccounts),MSG('Browse Accounts')     ! ,KEY(CtrlA) %%%%%%%%%%%%%%%
                         END
                         MENU('&Reports'),USE(?ReportMenu),MSG('Report data')
                           ITEM('Print All Credit Card Account &Information'),USE(?PrintACC:CreditCardVendorKey),MSG('Print Credit Card Vendors and Information')  ! ,KEY(CtrlI) %%%%%%%%%%%%%%
                         END
                         MENU('&Window'),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Help'),MSG('Windows Help')
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                           ITEM('&About Credit Card Registry...'),USE(?AboutAuthor),MSG('About the Author')
                         END
                       END
                       TOOLBAR,AT(0,0,399,18)
                         BUTTON,AT(28,2,16,14),USE(?Button1),RIGHT,FONT(,,,FONT:bold),TIP('Browse All Credit Card Accounts'),ICON('$.ICO'),FLAT
                         BUTTON,AT(173,2,16,14),USE(?Toolbar:Top,Toolbar:Top),DISABLE,TIP('Go to the First Page'),ICON('VCRFIRST.ICO'),FLAT
                         BUTTON,AT(189,2,16,14),USE(?Toolbar:PageUp,Toolbar:PageUp),DISABLE,TIP('Go to the Prior Page'),ICON('VCRPRIOR.ICO'),FLAT
                         BUTTON,AT(205,2,16,14),USE(?Toolbar:Up,Toolbar:Up),DISABLE,TIP('Go to the Prior Record'),ICON('VCRUP.ICO'),FLAT
                         BUTTON,AT(221,2,16,14),USE(?Toolbar:Locate,Toolbar:Locate),DISABLE,TIP('Locate record'),ICON('FIND.ICO'),FLAT
                         BUTTON,AT(237,2,16,14),USE(?Toolbar:Down,Toolbar:Down),DISABLE,TIP('Go to the Next Record'),ICON('VCRDOWN.ICO'),FLAT
                         BUTTON,AT(253,2,16,14),USE(?Toolbar:PageDown,Toolbar:PageDown),DISABLE,TIP('Go to the Next Page'),ICON('VCRNEXT.ICO'),FLAT
                         BUTTON,AT(269,2,16,14),USE(?Toolbar:Bottom,Toolbar:Bottom),DISABLE,TIP('Go to the Last Page'),ICON('VCRLAST.ICO'),FLAT
                         BUTTON,AT(289,2,16,14),USE(?Toolbar:Select,Toolbar:Select),DISABLE,TIP('Select This Record'),ICON('MARK.ICO'),FLAT
                         BUTTON,AT(305,2,16,14),USE(?Toolbar:Insert,Toolbar:Insert),DISABLE,TIP('Insert a New Record'),ICON('INSERT.ICO'),FLAT
                         BUTTON,AT(321,2,16,14),USE(?Toolbar:Change,Toolbar:Change),DISABLE,TIP('Edit This Record'),ICON('EDIT.ICO'),FLAT
                         BUTTON,AT(337,2,16,14),USE(?Toolbar:Delete,Toolbar:Delete),DISABLE,TIP('Delete This Record'),ICON('DELETE.ICO'),FLAT
                         BUTTON,AT(357,2,16,14),USE(?Toolbar:History,Toolbar:History),DISABLE,TIP('Previous value'),ICON('DITTO.ICO'),FLAT
                         BUTTON,AT(383,2,16,14),USE(?Toolbar:Help,Toolbar:Help),DISABLE,TIP('Get Help'),ICON('HELP.ICO'),FLAT
                         BUTTON,AT(107,2,16,14),USE(?ButtonPay),TIP('Record a Payment for Selected Account'),ICON('PAYCHK2.ICO'),FLAT
                         BUTTON,AT(125,2,16,14),USE(?ButtonHistory),TIP('Browse/Update Transaction History for Selected Account'),ICON('HISTORY.ICO'),FLAT
                         BUTTON,AT(90,2,16,14),USE(?ButtonCurrent),TIP('Browse/Update Current Transactions for Selected Account'),ICON('BOOKS.ICO'),FLAT
                         BUTTON,AT(146,2,16,14),USE(?Button17),TIP('Calculator'),ICON('CALC.ICO'),FLAT
                         BUTTON,AT(69,2,16,14),USE(?ButtonPrint),TIP('Select a Report to Print'),ICON(ICON:Print),FLAT
                         BUTTON,AT(51,2,16,14),USE(?Button16),TIP('Print Listing of All Credit Card Accounts'),ICON('PAPR.ICO'),FLAT
                         BUTTON,AT(4,2,16,14),USE(?Button2),TIP('Exit Credit Card Registry'),ICON('EXITS.ICO'),STD(STD:Close),FLAT
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()

Menu::ReportMenu ROUTINE                              !Code for menu items on ?ReportMenu
  CASE ACCEPTED()
  OF ?PrintACC:CreditCardVendorKey
    START(PrintCreditCardRegistry, 050000)
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
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
   !Set Global date variables
   GLO:TodaysDate = TODAY()
   GLO:LowDate = Today() - 30
   GLO:HighDate = Today()
   !Global reference assignment
   AppWindowRef &= AppFrame
   GLO:Button1 = ?ButtonPrint    !Print button on Toolbar
   GLO:Button2 = ?ButtonCurrent  !Current trans button on Toolbar
   GLO:Button3 = ?ButtonHistory  !History button on Toolbar
   GLO:Button4 = ?ButtonPay      !Log payment button on Toolbar
  OPEN(AppFrame)
  SELF.Opened=True
  INIMgr.Fetch('Main',AppFrame)
  !Set system icon
  System{PROP:Icon} = '~credcard.ico'
  !Global reference - disabling buttons on toolbar
  AppWindowRef $ GLO:Button1 {PROP:Disable} = True   !Enable toolbar print button
  AppWindowRef $ GLO:Button2 {PROP:Disable} = True   !Enable toolbar current trans button
  AppWindowRef $ GLO:Button3 {PROP:Disable} = True   !Enable toolbar history button
  AppWindowRef $ GLO:Button4 {PROP:Disable} = True   !Enable toolbar payment button
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?ButtonPay
      !Set Global Flag to Make Payment if Payment button is selected
      GLO:MakePayment = 1
      !Insert a record in the Transaction file
      PRESSKEY(InsertKey)
    OF ?Toolbar:Top
    OROF ?Toolbar:PageUp
    OROF ?Toolbar:Up
    OROF ?Toolbar:Locate
    OROF ?Toolbar:Down
    OROF ?Toolbar:PageDown
    OROF ?Toolbar:Bottom
    OROF ?Toolbar:Select
    OROF ?Toolbar:Insert
    OROF ?Toolbar:Change
    OROF ?Toolbar:Delete
    OROF ?Toolbar:History
    OROF ?Toolbar:Help
      IF SYSTEM{PROP:Active} <> THREAD()
        POST(EVENT:Accepted,ACCEPTED(),SYSTEM{Prop:Active} )
        CYCLE
      END
    ELSE
      DO Menu::ReportMenu                             !Process menu items on ?ReportMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BrowseAccounts
      START(BrowseAccounts, 050000)
    OF ?AboutAuthor
      START(AuthorInformation, 25000)
    OF ?Button1
      START(BrowseAccounts, 25000)
    OF ?ButtonPay
       ! Refresh Window
       ThisWindow.ForcedReset = True
       ThisWindow.Reset
    OF ?ButtonHistory
      START(BrowseTransactionHistory, 25000)
    OF ?ButtonCurrent
      START(BrowseCurrentTransactions, 25000)
!    OF ?Button17
!      RUN('calc.exe ')   %%%%%%%%%%%%%%
!      ThisWindow.Reset(1)
    OF ?ButtonPrint
      START(PickaReport, 25000)
    OF ?Button16
      PrintCreditCardRegistry
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  RETURN 0    ! %%%%%%%%%%%%%% ignore splash screen

UpdateAccounts PROCEDURE                              !Generated from procedure template - Window

CurrentTab           STRING(80)
LocalRequest         LONG
FilesOpened          BYTE
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
QuickWindow          WINDOW('Update the Accounts File'),AT(0,20,409,207),FONT('MS Sans Serif',8,,),IMM,ICON('CREDCARD.ICO'),HLP('~UpdateAccounts'),SYSTEM,GRAY,MDI
                       SHEET,AT(7,4,393,183),USE(?CurrentTab)! ,ABOVE(96) %%%%%%%%%%%%%%%%%%%
                         TAB('Credit Card Information'),FONT(,,,FONT:bold)
                           PROMPT('Credit Card Vendor:'),AT(25,24),USE(?ACC:CreditCardVendor:Prompt),FONT(,,,FONT:bold)
                           ENTRY(@s30),AT(105,24),USE(ACC:CreditCardVendor),LEFT,FONT(,,,FONT:regular),MSG('Name of Credit Card Vendor - (Payee)'),REQ,CAP
                           GROUP('Payment Address'),AT(11,36,245,69),USE(?Group1),BOXED,FONT(,,,FONT:bold)
                           END
                           PROMPT('Address 1:'),AT(28,49),USE(?Prompt11),FONT(,,,FONT:regular)
                           ENTRY(@s35),AT(67,48),USE(ACC:VendorAddr1),FONT(,,,FONT:regular),MSG('First line of Vendor Address')
                           PROMPT('Address 2:'),AT(28,68),USE(?ACC:VendorAddr2:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@s35),AT(67,67),USE(ACC:VendorAddr2),FONT(,,,FONT:regular),MSG('Optional second line of Vendor Address')
                           PROMPT('City/State/Zip:'),AT(14,87,47,12),USE(?ACC:VendorCity:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@s25),AT(67,86),USE(ACC:VendorCity),FONT(,,,FONT:regular),MSG('Vendor Address City')
                           ENTRY(@K^^KB),AT(179,86),USE(ACC:VendorState),FONT(,,,FONT:regular),MSG('Vendor Address State'),UPR
                           ENTRY(@k#####|-####k),AT(199,86),USE(ACC:VendorZip),FONT(,,,FONT:regular),MSG('Vendor address zip code') ! ,OVR  %%%%%%%%%%%%%%%%%%
                           OPTION('Card Type'),AT(263,36,122,69),USE(ACC:CardType),BOXED,FONT(,,,FONT:bold)
                             RADIO('Visa'),AT(267,47),USE(?ACC:CardType:Radio1),FONT(,,,FONT:regular)
                             RADIO('Master Card'),AT(267,61),USE(?ACC:CardType:Radio2),FONT(,,,FONT:regular)
                             RADIO('Discover'),AT(267,75),USE(?ACC:CardType:Radio4),FONT(,,,FONT:regular)
                             RADIO('American Express'),AT(268,89),USE(?ACC:CardType:Radio3),FONT(,,,FONT:regular)
                             RADIO('Store'),AT(337,47),USE(?ACC:CardType:Radio5),FONT(,,,FONT:regular)
                             RADIO('Gasoline'),AT(337,61),USE(?ACC:CardType:Radio6),FONT(,,,FONT:regular)
                             RADIO('Other'),AT(337,75),USE(?ACC:CardType:Radio7),FONT(,,,FONT:regular)
                           END
                           GROUP('Account Information'),AT(12,113,244,70),USE(?Group2),BOXED,FONT(,,,FONT:bold)
                             STRING('$'),AT(65,146,13,12),USE(?String1),TRN,FONT('Arial',10,,FONT:bold)
                             STRING('$'),AT(189,146,13,12),USE(?String1:2),TRN,FONT('Arial',10,,FONT:bold)
                             STRING('%'),AT(104,164),USE(?String3),TRN,FONT('Arial',10,,FONT:bold)
                           END
                           PROMPT('Account Number:'),AT(15,128),USE(?ACC:AccountNumber:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@s20),AT(73,127),USE(ACC:AccountNumber),FONT(,,,FONT:regular),MSG('Credit Card Account Number'),REQ
                           PROMPT('Exp Date:'),AT(163,128),USE(?ACC:ExpirationDate:Prompt),TRN,FONT(,,,FONT:regular)
                           ENTRY(@d1),AT(196,127,49,12),USE(ACC:ExpirationDate)
                           PROMPT('Credit Limit:'),AT(26,146),USE(?ACC:CreditLimit:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@n10.2B),AT(73,145),USE(ACC:CreditLimit),FONT(,,,FONT:regular)
                           PROMPT('Current Balance:'),AT(135,146,54,12),USE(?ACC:AccountBalance:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@n12.2B),AT(196,145),USE(ACC:AccountBalance),FONT(,,,FONT:regular),MSG('Current outstanding balance on this account') ! @n$(12.2)B $$$$$$$$$$$$
                           PROMPT('Interest Rate:'),AT(27,165),USE(?ACC:InterestRate:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@N5.1),AT(73,163),USE(ACC:InterestRate),FONT(,,,FONT:regular),MSG('Current interest rate on account')!    ,OVR %%%%%%%%%%%%
                           PROMPT('Billing Day:'),AT(157,167),USE(?ACC:BillingDay:Prompt),FONT(,,,FONT:regular)
                           SPIN(@k<#k),AT(196,164,27,12),USE(ACC:BillingDay),FONT(,,,FONT:regular),MSG('Day of the month that Vendor generates statement'),RANGE(1,28),STEP(1)   ! OVR, %%%%%%%
                           GROUP('Phones'),AT(263,113,127,54),USE(?Group3),BOXED,FONT(,,,FONT:bold)
                           END
                           PROMPT('Balance Info: '),AT(271,128),USE(?ACC:BalanceInfoPhone:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@p(###) ###-####p),AT(319,127),USE(ACC:BalanceInfoPhone),FONT(,,,FONT:regular)
                           PROMPT('Lost Card:'),AT(283,146),USE(?ACC:LostCardPhone:Prompt),FONT(,,,FONT:regular)
                           ENTRY(@p(###) ###-####p),AT(319,145),USE(ACC:LostCardPhone),FONT(,,,FONT:regular)
                         END
                       END
                       BUTTON('OK'),AT(93,190,45,14),USE(?OK),DEFAULT
                       BUTTON('Cancel'),AT(142,190,45,14),USE(?Cancel)
                       BUTTON('Help'),AT(191,190,45,14),USE(?Help),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass               !Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a Credit Card Account Record'
  OF ChangeRecord
    ActionMessage = 'Changing a Credit Card Account Record'
  END
  QuickWindow{Prop:Text} = ActionMessage
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateAccounts')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ACC:CreditCardVendor:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddUpdateFile(Access:Accounts)
  SELF.AddItem(?Cancel,RequestCancelled)
  Relate:Accounts.Open
  Access:Transactions.UseFile
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Accounts
  IF SELF.Request = ViewRecord
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = 0
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)
  SELF.Opened=True
  INIMgr.Fetch('UpdateAccounts',QuickWindow)
  !Disable Account Balance entry field if changing account record.
  IF SELF.Request = ChangeRecord THEN ?ACC:AccountBalance{PROP:Disable} = True.
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
  ! Write a Transaction record for a new account to start account balance.
    IF SELF.Request = InsertRecord
     TRA:SysID = ACC:SysID
     TRA:DateofTransaction = TODAY()
     TRA:TransactionDescription = 'Initial Account Balance'
     TRA:TransactionType = 'B'
     TRA:TransactionAmount = ACC:AccountBalance
     TRA:ReconciledTransaction = 0
     Access:Transactions.Insert()
    END
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateAccounts',QuickWindow)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?ACC:BillingDay
      IF Access:Accounts.TryValidateField(15)
        SELECT(?ACC:BillingDay)
        QuickWindow{Prop:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?ACC:BillingDay
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ~ERRORCODE()
          ?ACC:BillingDay{Prop:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord
        POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

BrowseAccounts PROCEDURE                              !Generated from procedure template - Window

CurrentTab           STRING(80)
LocalRequest         LONG
FilesOpened          BYTE
LOC:CityStateZip     STRING(40)
LOC:OrdinalExtension STRING('''st''')
LOC:CardTypeDescription STRING(16)
LOC:TotalOutstandingDebt DECIMAL(8,2)
BRW1::View:Browse    VIEW(Accounts)
                       PROJECT(ACC:CreditCardVendor)
                       PROJECT(ACC:AccountNumber)
                       PROJECT(ACC:VendorAddr1)
                       PROJECT(ACC:VendorAddr2)
                       PROJECT(ACC:VendorCity)
                       PROJECT(ACC:VendorState)
                       PROJECT(ACC:VendorZip)
                       PROJECT(ACC:InterestRate)
                       PROJECT(ACC:BillingDay)
                       PROJECT(ACC:AccountBalance)
                       PROJECT(ACC:BalanceInfoPhone)
                       PROJECT(ACC:LostCardPhone)
                       PROJECT(ACC:CreditLimit)
                       PROJECT(ACC:ExpirationDate)
                       PROJECT(ACC:SysID)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
ACC:CreditCardVendor   LIKE(ACC:CreditCardVendor)     !List box control field - type derived from field
ACC:AccountNumber      LIKE(ACC:AccountNumber)        !Browse hot field - type derived from field
ACC:VendorAddr1        LIKE(ACC:VendorAddr1)          !Browse hot field - type derived from field
ACC:VendorAddr2        LIKE(ACC:VendorAddr2)          !Browse hot field - type derived from field
ACC:VendorCity         LIKE(ACC:VendorCity)           !Browse hot field - type derived from field
ACC:VendorState        LIKE(ACC:VendorState)          !Browse hot field - type derived from field
ACC:VendorZip          LIKE(ACC:VendorZip)            !Browse hot field - type derived from field
ACC:InterestRate       LIKE(ACC:InterestRate)         !Browse hot field - type derived from field
ACC:BillingDay         LIKE(ACC:BillingDay)           !Browse hot field - type derived from field
ACC:AccountBalance     LIKE(ACC:AccountBalance)       !Browse hot field - type derived from field
ACC:BalanceInfoPhone   LIKE(ACC:BalanceInfoPhone)     !Browse hot field - type derived from field
ACC:LostCardPhone      LIKE(ACC:LostCardPhone)        !Browse hot field - type derived from field
LOC:CityStateZip       LIKE(LOC:CityStateZip)         !Browse hot field - type derived from local data
LOC:OrdinalExtension   LIKE(LOC:OrdinalExtension)     !Browse hot field - type derived from local data
LOC:CardTypeDescription LIKE(LOC:CardTypeDescription) !Browse hot field - type derived from local data
GLO:CardTypeDescription LIKE(GLO:CardTypeDescription) !Browse hot field - type derived from global data
ACC:CreditLimit        LIKE(ACC:CreditLimit)          !Browse hot field - type derived from field
ACC:ExpirationDate     LIKE(ACC:ExpirationDate)       !Browse hot field - type derived from field
ACC:SysID              LIKE(ACC:SysID)                !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse Credit Card Account Information'),AT(0,0,258,209),FONT('MS Sans Serif',8,,),IMM,ICON('CREDCARD.ICO'),HLP('~BrowseCreditCardAccounts'),SYSTEM,GRAY,MDI
                       LIST,AT(89,42,131,65),USE(?Browse:1),IMM,VSCROLL,FONT(,,,FONT:bold),COLOR(,COLOR:HIGHLIGHTTEXT,COLOR:HIGHLIGHT),MSG('Browsing Records'),FORMAT('[126L|M~Credit Card Vendor~C@s30@]'),FROM(Queue:Browse:1)
                       BUTTON('&Insert'),AT(13,60,41,13),USE(?Insert:2),HIDE
                       BUTTON('&Change'),AT(14,75,41,13),USE(?Change:2),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(13,90,41,13),USE(?Delete:2),HIDE
                       BOX,AT(18,183,218,17),USE(?Box1),ROUND,COLOR(COLOR:Black),LINEWIDTH(2)
                       STRING(@N$11.2),AT(178,185,53,12),USE(LOC:TotalOutstandingDebt),LEFT,FONT('Arial',9,,FONT:bold)
                       STRING('Total Outstanding Debt (All Accounts):'),AT(27,184,144,12),USE(?String25),FONT('Arial',9,,FONT:bold)
                       SHEET,AT(7,1,243,183),USE(?CurrentTab)    !  ,ABOVE(80) %%%%%%%%%%%%%
                         TAB('Credit Card Vendors'),MSG('Browse by Credit Card Vendor'),FONT('MS Sans Serif',8,,FONT:bold)
                           STRING('Vendor Locator:'),AT(14,18),USE(?String28),FONT(,,COLOR:Blue,)
                           STRING(@s30),AT(77,18),USE(ACC:CreditCardVendor),FONT(,,COLOR:Red,)
                           PANEL,AT(9,15,222,17),USE(?Panel10),BEVEL(2)
                           BUTTON('Close'),AT(13,104,41,13),USE(?Close),HIDE,FONT(,,,FONT:bold)
                           IMAGE('CCARDS.ICO'),AT(63,39,21,20),USE(?Image4)
                           PANEL,AT(113,116,81,29),USE(?Panel9),FILL(COLOR:Silver),BEVEL(-1,2)
                           STRING(@s16),AT(65,103,24,81),USE(GLO:CardTypeDescription),TRN,CENTER,FONT('Arial Rounded MT Bold',9,,FONT:bold) !,ANGLE(900) %%%%%%%%%%
                           STRING(@s20),AT(105,158),USE(ACC:AccountNumber),TRN,CENTER,FONT(,,,FONT:bold)
                           STRING('Exp Date:'),AT(115,169),USE(?String26),TRN,RIGHT,FONT(,,,FONT:bold)
                           STRING(@d1),AT(155,169),USE(ACC:ExpirationDate),TRN,LEFT,FONT(,,,FONT:bold)
                           STRING('Current Balance'),AT(121,119,65,10),USE(?String7),TRN,CENTER,FONT(,,,FONT:bold)
                           STRING(@N12.2),AT(127,130),USE(ACC:AccountBalance),TRN,LEFT,FONT(,,,FONT:bold)  ! STRING(@N$(12.2)), %%%%%%%%%%%
                           BUTTON('Help'),AT(13,119,39,14),USE(?Help),HIDE,STD(STD:Help)
                           PANEL,AT(91,108,131,73),USE(?Panel3),BEVEL(-1,2)
                           STRING('Account Number'),AT(123,145),USE(?String2),TRN,FONT(,,,FONT:bold)
                           PANEL,AT(105,156,103,12),USE(?Panel5),FILL(COLOR:Silver),BEVEL(-1,2)
                         END
                         TAB('Billing Information'),USE(?Tab2),FONT(,,,FONT:bold)
                           IMAGE('MAIL7.ICO'),AT(63,39,21,20),USE(?Image5)
                           PANEL,AT(27,134,57,15),USE(?Panel6),BEVEL(-1,2)
                           STRING('Credit Limit'),AT(33,110),USE(?String22),TRN,FONT('Arial',8,,FONT:bold)
                           STRING(@n$10.2),AT(33,121),USE(ACC:CreditLimit),TRN,FONT('Arial',8,,FONT:bold)
                           PANEL,AT(27,152,57,29),USE(?Panel4),BEVEL(-1,2)
                           STRING('Billing Date'),AT(35,154),USE(?String10),TRN,CENTER,FONT('Arial',8,,FONT:bold)
                           STRING(@s2),AT(59,162,15,10),USE(LOC:OrdinalExtension),TRN,FONT('Arial',8,,FONT:bold)
                           STRING('each month'),AT(35,169),USE(?String14),TRN,FONT('Arial',8,,FONT:bold)
                           STRING('Rate'),AT(33,137),USE(?String11),TRN,CENTER,FONT('Arial',8,,FONT:bold)
                           STRING(@n5.1),AT(55,137),USE(ACC:InterestRate),TRN,FONT('Arial',8,,FONT:bold)
                           STRING('%'),AT(75,137),USE(?String15),TRN,FONT(,,,FONT:bold)
                           STRING('Mail payments to:'),AT(89,111),USE(?String9)
                           STRING(@n2),AT(47,162),USE(ACC:BillingDay),TRN,FONT('Arial',8,,FONT:bold)
                           PANEL,AT(87,109,147,72),USE(?Panel2),BEVEL(-1,2)
                           IMAGE('MAIL18.ICO'),AT(209,114,21,20),USE(?Image2)
                           STRING(@s35),AT(96,141,130,10),USE(ACC:VendorAddr1),FONT(,,,FONT:bold)
                           PANEL,AT(28,110,57,23),USE(?Panel8),BEVEL(-1,2)
                           STRING(@s35),AT(96,154,129,10),USE(ACC:VendorAddr2),FONT(,,,FONT:bold)
                           STRING(@s40),AT(96,165,129,10),USE(LOC:CityStateZip),FONT(,,,FONT:bold)
                         END
                         TAB('Phones'),USE(?Tab3),FONT(,,,FONT:bold)
                           PANEL,AT(79,125,131,52),USE(?Panel7),BEVEL(-1,2)
                           STRING('Balance Information:'),AT(105,130),USE(?String16),CENTER,FONT(,,,FONT:bold)
                           STRING(@p(###) ###-####p),AT(109,138),USE(ACC:BalanceInfoPhone),CENTER,FONT(,,,FONT:bold)
                           IMAGE('PHONE07.ICO'),AT(65,106,21,18),USE(?Image3)
                           STRING('Telephone Numbers'),AT(88,114),USE(?String18),CENTER,FONT(,,,FONT:bold)
                           STRING('Lost Card:'),AT(125,154),USE(?String17),CENTER,FONT(,,,FONT:bold)
                           STRING(@p(###) ###-####p),AT(109,162),USE(ACC:LostCardPhone),CENTER,FONT(,,,FONT:bold)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  FilterLocatorClass               !Default Locator
BRW1::Sort0:StepClass StepStringClass                 !Default Step Manager

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseAccounts')
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
  Relate:Accounts.Open
  SELF.FilesOpened = True
  !Global reference - enable buttons on toolbar
    AppWindowRef $ GLO:Button1 {PROP:Disable} = False   !Enable toolbar print button
    AppWindowRef $ GLO:Button2 {PROP:Disable} = False   !Enable toolbar current trans button
    AppWindowRef $ GLO:Button3 {PROP:Disable} = False   !Enable toolbar history button
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Accounts,SELF)
  OPEN(QuickWindow)
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha,ScrollBy:Runtime)
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,ACC:CreditCardVendorKey)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(?ACC:CreditCardVendor,ACC:CreditCardVendor,1,BRW1)
  BIND('LOC:CityStateZip',LOC:CityStateZip)
  BIND('LOC:OrdinalExtension',LOC:OrdinalExtension)
  BIND('LOC:CardTypeDescription',LOC:CardTypeDescription)
  BIND('GLO:CardTypeDescription',GLO:CardTypeDescription)
  BRW1.AddField(ACC:CreditCardVendor,BRW1.Q.ACC:CreditCardVendor)
  BRW1.AddField(ACC:AccountNumber,BRW1.Q.ACC:AccountNumber)
  BRW1.AddField(ACC:VendorAddr1,BRW1.Q.ACC:VendorAddr1)
  BRW1.AddField(ACC:VendorAddr2,BRW1.Q.ACC:VendorAddr2)
  BRW1.AddField(ACC:VendorCity,BRW1.Q.ACC:VendorCity)
  BRW1.AddField(ACC:VendorState,BRW1.Q.ACC:VendorState)
  BRW1.AddField(ACC:VendorZip,BRW1.Q.ACC:VendorZip)
  BRW1.AddField(ACC:InterestRate,BRW1.Q.ACC:InterestRate)
  BRW1.AddField(ACC:BillingDay,BRW1.Q.ACC:BillingDay)
  BRW1.AddField(ACC:AccountBalance,BRW1.Q.ACC:AccountBalance)
  BRW1.AddField(ACC:BalanceInfoPhone,BRW1.Q.ACC:BalanceInfoPhone)
  BRW1.AddField(ACC:LostCardPhone,BRW1.Q.ACC:LostCardPhone)
  BRW1.AddField(LOC:CityStateZip,BRW1.Q.LOC:CityStateZip)
  BRW1.AddField(LOC:OrdinalExtension,BRW1.Q.LOC:OrdinalExtension)
  BRW1.AddField(LOC:CardTypeDescription,BRW1.Q.LOC:CardTypeDescription)
  BRW1.AddField(GLO:CardTypeDescription,BRW1.Q.GLO:CardTypeDescription)
  BRW1.AddField(ACC:CreditLimit,BRW1.Q.ACC:CreditLimit)
  BRW1.AddField(ACC:ExpirationDate,BRW1.Q.ACC:ExpirationDate)
  BRW1.AddField(ACC:SysID,BRW1.Q.ACC:SysID)
  INIMgr.Fetch('BrowseAccounts',QuickWindow)
  !Set Title for Window
  QuickWindow{PROP:Text} = 'Browse Credit Card Accounts'
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseAccounts',QuickWindow)
  END
   !Global reference - disable buttons on toolbar
    AppWindowRef $ GLO:Button1 {PROP:Disable} = True   !Disable toolbar print button
    AppWindowRef $ GLO:Button2 {PROP:Disable} = True   !Disable toolbar current trans button
    AppWindowRef $ GLO:Button3 {PROP:Disable} = True   !Disable toolbar history button
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  !Assign system id of Account file to global variable
  GLO:CurrentSysid = ACC:SysID
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  ELSE
    GlobalRequest = Request
    UpdateAccounts
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


BRW1.ResetFromView PROCEDURE

LOC:TotalOutstandingDebt:Sum REAL
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Accounts.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      RETURN
    END
    SELF.SetQueueRecord
    LOC:TotalOutstandingDebt:Sum += ACC:AccountBalance
  END
  LOC:TotalOutstandingDebt = LOC:TotalOutstandingDebt:Sum
  PARENT.ResetFromView
  Relate:Accounts.SetQuickScan(0)
  SETCURSOR()


BRW1.SetQueueRecord PROCEDURE

  CODE
  LOC:CityStateZip = (CLIP(ACC:VendorCity) & ', ' & ACC:VendorState & ' ' & ACC:VendorZip)
  CASE (ACC:CardType)
  OF 'M'
    GLO:CardTypeDescription = 'MASTER CARD'
  OF 'V'
    GLO:CardTypeDescription = 'VISA CARD'
  OF 'D'
    GLO:CardTypeDescription = 'DISCOVER CARD'
  OF 'A'
    GLO:CardTypeDescription = 'AMERICAN EXPRESS'
  OF 'S'
    GLO:CardTypeDescription = 'STORE CARD'
  OF 'G'
    GLO:CardTypeDescription = 'GASOLINE CARD'
  ELSE
    GLO:CardTypeDescription = 'CHARGE CARD'
  END
  CASE (ACC:BillingDay)
  OF 1
    LOC:OrdinalExtension = 'st'
  OF 2
    LOC:OrdinalExtension = 'nd'
  OF 3
    LOC:OrdinalExtension = 'rd'
  OF 21
    LOC:OrdinalExtension = 'st'
  OF 22
    LOC:OrdinalExtension = 'nd'
  OF 23
    LOC:OrdinalExtension = 'rd'
  ELSE
    LOC:OrdinalExtension = 'th'
  END
  PARENT.SetQueueRecord
  SELF.Q.LOC:CityStateZip = LOC:CityStateZip          !Assign formula result to display queue
  SELF.Q.LOC:OrdinalExtension = LOC:OrdinalExtension  !Assign formula result to display queue

PrintCreditCardRegistry PROCEDURE                     !Generated from procedure template - Report

LocalRequest         LONG
FilesOpened          BYTE
LOC:CardType         STRING(20),AUTO
LOC:OrdinalExtension STRING(2)
LOC:CityStateZip     STRING(35)
LOC:AvailableFunds   DECIMAL(7,2)
Progress:Thermometer BYTE
Process:View         VIEW(Accounts)
                       PROJECT(ACC:AccountBalance)
                       PROJECT(ACC:AccountNumber)
                       PROJECT(ACC:BalanceInfoPhone)
                       PROJECT(ACC:BillingDay)
                       PROJECT(ACC:CardType)
                       PROJECT(ACC:CreditCardVendor)
                       PROJECT(ACC:CreditLimit)
                       PROJECT(ACC:InterestRate)
                       PROJECT(ACC:LostCardPhone)
                       PROJECT(ACC:VendorAddr1)
                       PROJECT(ACC:VendorAddr2)
                       PROJECT(ACC:VendorCity)
                       PROJECT(ACC:VendorState)
                       PROJECT(ACC:VendorZip)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(990,1365,6500,7635),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1000,1000,6000,333)
                         STRING('Personal Credit Card Account Information'),AT(1323,73,3833,167),CENTER,FONT(,12,,FONT:bold)
                       END
detail                 DETAIL,AT(10,10,6490,2427),USE(?detail)
                         STRING(@s20),AT(729,271,2177,208),USE(LOC:CardType),FONT('Arial',11,,FONT:bold+FONT:italic+FONT:underline)
                         STRING(@s30),AT(740,583,3167,167),USE(ACC:CreditCardVendor)
                         STRING('Billing Day:'),AT(4438,1969,719,208),USE(?String19),RIGHT,FONT('Arial',9,,)
                         STRING(@s20),AT(4219,490,1740,167),USE(ACC:AccountNumber),CENTER,FONT(,,,FONT:bold)
                         STRING('Account Number'),AT(4417,271,1344,208),USE(?String22),CENTER,FONT(,,,FONT:bold+FONT:underline)
                         STRING(@s35),AT(729,781,3198,167),USE(ACC:VendorAddr1)
                         STRING(@s35),AT(729,979,3146,167),USE(ACC:VendorAddr2)
                         STRING('%'),AT(5552,1719,198,208),USE(?String21),TRN,FONT('Arial',9,,)
                         STRING(@s35),AT(729,1177,2615,167),USE(LOC:CityStateZip)
                         STRING('Credit Limit:'),AT(4396,1240,771,208),USE(?String25),RIGHT,FONT('Arial',9,,)
                         STRING(@n$10.2B),AT(5208,1250),USE(ACC:CreditLimit),LEFT,FONT('Arial',9,,)
                         STRING(@n10.2),AT(5229,1490),USE(LOC:AvailableFunds),TRN,FONT('Arial',9,,)  ! STRING(@n$(10.2)), %%%%%%%%%%%
                         STRING('Funds Available:'),AT(4229,1479,1010,208),USE(?String26),FONT('Arial',9,,)
                         BOX,AT(4167,740,1792,1552),USE(?Box2),COLOR(COLOR:Black),LINEWIDTH(3)
                         STRING('Phones:'),AT(729,1552),USE(?String23),TRN,FONT(,,,FONT:bold)
                         STRING(@p(###) ###-####p),AT(2063,1771,990,167),USE(ACC:BalanceInfoPhone)
                         STRING('Current Balance:'),AT(4448,792,1198,208),USE(?String18),TRN,CENTER,FONT(,,,FONT:bold)
                         STRING('Balance Information:'),AT(708,1750,1292,208),USE(?String29),RIGHT
                         STRING(@n5.1),AT(5208,1729),USE(ACC:InterestRate),TRN,FONT('Arial',9,,)
                         STRING(@p(###) ###-####p),AT(2063,2031,990,167),USE(ACC:LostCardPhone)
                         STRING('Lost Card:'),AT(1302,2010,698,208),USE(?String30),TRN,RIGHT
                         STRING('Interest Rate:'),AT(4333,1719,823,208),USE(?String20),TRN,RIGHT,FONT('Arial',9,,)
                         STRING(@n2),AT(5125,1969,229,208),USE(ACC:BillingDay),TRN,RIGHT,FONT('Arial',9,,)
                         STRING(@s2),AT(5354,1969,208,208),USE(LOC:OrdinalExtension),TRN,LEFT,FONT('Arial',9,,)
                         LINE,AT(625,94,5490,1),USE(?Line1),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING(@N$_12..2),AT(4594,1000,906,167),USE(ACC:AccountBalance),TRN,CENTER,FONT(,,,FONT:bold) ! STRING(@N$(_12..2)),  %%%%%%%%%%%%
                       END
                       FOOTER,AT(1000,9000,6000,219)
                         STRING(@pPage <<<#p),AT(5250,30,700,135),PAGENO,USE(?PageCount),FONT('Arial',8,,FONT:regular)
                         STRING(@d2),AT(4344,31,740,135),USE(GLO:TodaysDate),FONT('Arial',8,,FONT:regular)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)              !Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepStringClass                  !Progress Manager
Previewer            PrintPreviewClass                !Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PrintCreditCardRegistry')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Accounts.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
  SELF.Opened=True
  INIMgr.Fetch('PrintCreditCardRegistry',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:Accounts, ?Progress:PctText, Progress:Thermometer, ProgressMgr, ACC:CreditCardVendor)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(ACC:CreditCardVendorKey)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Accounts.SetQuickScan(1,Propagate:OneMany)
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('PrintCreditCardRegistry',ProgressWindow)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  CASE (ACC:CardType)
  OF 'V'
    LOC:CardType = 'Visa Account'
  OF 'M'
    LOC:CardType = 'Master Card Account'
  OF 'D'
    LOC:CardType = 'Discover Card Account'
  OF 'A'
    LOC:CardType = 'American Express Account'
  OF 'S'
    LOC:CardType = 'Store Account'
  OF 'G'
    LOC:CardType = 'Gasoline Account'
  ELSE
    LOC:CardType = 'Other Account'
  END
  CASE (ACC:BillingDay)
  OF '1'
    LOC:OrdinalExtension = 'st'
  OF '2'
    LOC:OrdinalExtension = 'nd'
  OF '3'
    LOC:OrdinalExtension = 'rd'
  OF '21'
    LOC:OrdinalExtension = 'st'
  OF '22'
    LOC:OrdinalExtension = 'nd'
  OF '23'
    LOC:OrdinalExtension = 'rd'
  ELSE
    LOC:OrdinalExtension = 'th'
  END
  LOC:CityStateZip = CLIP(ACC:VendorCity) & ', ' & ACC:VendorState & '   ' & ACC:VendorZip
  LOC:AvailableFunds = ACC:CreditLimit - ACC:AccountBalance
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

UpdateTransactions PROCEDURE                          !Generated from procedure template - Window

CurrentTab           STRING(80)
LocalRequest         LONG
FilesOpened          BYTE
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
QuickWindow          WINDOW('Update the Transactions File'),AT(,,286,172),FONT('MS Sans Serif',8,,),IMM,HLP('~UpdateTransactions'),SYSTEM,GRAY,MDI
                       PANEL,AT(101,3,163,15),USE(?Panel1),BEVEL(1,-2)
                       STRING(@s30),AT(110,6),USE(ACC:CreditCardVendor),TRN,CENTER,FONT(,9,,FONT:bold)
                       SHEET,AT(5,9,271,134),USE(?CurrentTab) !,ABOVE(68) %%%%%%%%%%%%
                         TAB('Transaction Log'),FONT(,9,,FONT:bold)
                           OPTION('Transaction Type'),AT(13,30,81,108),USE(TRA:TransactionType),BOXED,FONT(,9,,FONT:bold)
                             RADIO('Charge'),AT(17,45),USE(?TRA:TransactionType:Radio1),FONT(,9,,FONT:bold)
                             RADIO('Payment/Credit'),AT(17,60),USE(?TRA:TransactionType:Radio2),FONT(,9,,FONT:bold)
                             RADIO('Interest'),AT(17,76),USE(?TRA:TransactionType:Radio3),FONT(,9,,FONT:bold)
                             RADIO('Fee'),AT(17,92),USE(?TRA:TransactionType:Radio4),FONT(,9,,FONT:bold)
                             RADIO('Cash  Advance'),AT(17,108),USE(?TRA:TransactionType:Radio5),FONT(,9,,FONT:bold),VALUE('A')
                             RADIO('Balance Due'),AT(17,124),USE(?TRA:TransactionType:Radio6),FONT(,9,,FONT:bold),VALUE('B')
                           END
                           PROMPT('Transaction Date:'),AT(103,30),USE(?TRA:DateofTransaction:Prompt),FONT(,9,,FONT:bold)
                           SPIN(@d2),AT(103,44,70,16),USE(TRA:DateofTransaction),FONT(,11,,FONT:bold),MSG('Date of transaction.'),RANGE(4,109211),STEP(1)    ! ,REQ %%%%%%%%%%%%
                           PROMPT('Transaction Amount:'),AT(185,30),USE(?TRA:TransactionAmount:Prompt),FONT(,9,,FONT:bold)
                           STRING('$'),AT(185,44,13,12),USE(?String1),TRN,FONT('Arial',12,,FONT:bold)
                           ENTRY(@n10.2-),AT(193,44,71,16),USE(TRA:TransactionAmount),FONT(,11,,FONT:bold),MSG('Dollar amount of transaction'),REQ  ! ,OVR %%%%%%%%%%%%
                           PROMPT('Description:'),AT(103,70),USE(?TRA:TransactionDescription:Prompt),FONT(,9,,FONT:bold)
                           ENTRY(@s35),AT(103,81,162,16),USE(TRA:TransactionDescription),FONT(,11,,FONT:bold)   ! SCROLL, %%%%%%%%%%%
                           CHECK('Reconcile this transaction'),AT(103,113),USE(TRA:ReconciledTransaction),FONT(,,,FONT:bold)
                         END
                       END
                       BUTTON('OK'),AT(71,150,45,14),USE(?OK),DEFAULT
                       BUTTON('Cancel'),AT(121,150,45,14),USE(?Cancel)
                       BUTTON('Help'),AT(169,150,45,14),USE(?Help),KEY(EscKey),STD(STD:Help)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass               !Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Ask PROCEDURE

  CODE
  IF GLO:MakePayment = 0 THEN GLO:CurrentSysid = ACC:Sysid.    !If not making a payment, then set the global sysid to the account sysid.
  IF GLO:MakePayment = 1               !Initialize transaction fields for payment
    TRA:SysID = GLO:CurrentSysid
    TRA:DateofTransaction = TODAY()
    TRA:TransactionType = 'P'
    TRA:TransactionDescription = 'Payment - Check number xxx'
    TRA:TransactionAmount = 0
    TRA:ReconciledTransaction = 0
    GLO:MakePayment = 0
  END
  GLO:HoldTransactionAmount = 0   !Retain transaction amount for record change
  IF ThisWindow.Request = ChangeRecord
    GLO:HoldTransactionAmount = TRA:TransactionAmount
  END
  CASE SELF.Request
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a Transaction Record'
  OF ChangeRecord
    ActionMessage = 'Changing a Transaction Record'
  END
  QuickWindow{Prop:Text} = ActionMessage
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateTransactions')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddUpdateFile(Access:Transactions)
  SELF.AddItem(?Cancel,RequestCancelled)
  !Global reference  - disable payment button on toolbar
  AppWindowRef $ GLO:Button4 {PROP:Disable} = True
  Relate:Accounts.Open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Transactions
  IF SELF.Request = ViewRecord
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = 0
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  OPEN(QuickWindow)
  SELF.Opened=True
  INIMgr.Fetch('UpdateTransactions',QuickWindow)
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
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateTransactions',QuickWindow)
  END
  !Global reference  - enable payment button on toolbar
  AppWindowRef $ GLO:Button4 {PROP:Disable} = False
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
  !srestre
  PARENT.PrimeFields


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      !Assign the global sysid to the account sysid to get the account record.
      ACC:SysID = GLO:CurrentSysid
      Access:Accounts.Fetch(ACC:SysIDKey)
      !Negate transaction amount if payment or credit
      IF TRA:TransactionType = 'P' AND SELF.Request = InsertRecord THEN TRA:TransactionAmount *= -1.
      !Calculate the account balance
      CASE SELF.Request
      OF InsertRecord
        ACC:AccountBalance = ACC:AccountBalance + TRA:TransactionAmount
      OF ChangeRecord
        ACC:AccountBalance = ACC:AccountBalance - GLO:HoldTransactionAmount + TRA:TransactionAmount
      OF DeleteRecord
        ACC:AccountBalance = ACC:AccountBalance - GLO:HoldTransactionAmount
      END
      Access:Accounts.Update()
      IF SELF.Request = ViewRecord
        POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

BrowseCurrentTransactions PROCEDURE                   !Generated from procedure template - Window

CurrentTab           STRING(80)
LocalRequest         LONG
FilesOpened          BYTE
LOC:TotalOpenTransactions DECIMAL(7,2,0)
LOC:AvgTran          DECIMAL(7,2)
LOC:AvailableFunds   DECIMAL(9,2)
BRW1::View:Browse    VIEW(Transactions)
                       PROJECT(TRA:DateofTransaction)
                       PROJECT(TRA:TransactionDescription)
                       PROJECT(TRA:TransactionAmount)
                       PROJECT(TRA:ReconciledTransaction)
                       PROJECT(TRA:SysID)
                       PROJECT(TRA:TransactionType)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
TRA:DateofTransaction  LIKE(TRA:DateofTransaction)    !List box control field - type derived from field
TRA:TransactionDescription LIKE(TRA:TransactionDescription) !List box control field - type derived from field
GLO:TransactionTypeDescription LIKE(GLO:TransactionTypeDescription) !List box control field - type derived from global data
TRA:TransactionAmount  LIKE(TRA:TransactionAmount)    !List box control field - type derived from field
TRA:TransactionAmount_NormalFG LONG                   !Normal forground color
TRA:TransactionAmount_NormalBG LONG                   !Normal background color
TRA:TransactionAmount_SelectedFG LONG                 !Selected forground color
TRA:TransactionAmount_SelectedBG LONG                 !Selected background color
TRA:ReconciledTransaction LIKE(TRA:ReconciledTransaction) !Browse hot field - type derived from field
ACC:CreditLimit        LIKE(ACC:CreditLimit)          !Browse hot field - type derived from field
LOC:AvailableFunds     LIKE(LOC:AvailableFunds)       !Browse hot field - type derived from local data
ACC:AccountBalance     LIKE(ACC:AccountBalance)       !Browse hot field - type derived from field
TRA:SysID              LIKE(TRA:SysID)                !Browse hot field - type derived from field
TRA:TransactionType    LIKE(TRA:TransactionType)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
QuickWindow          WINDOW('Browse Open Transactions/Balances'),AT(0,10,347,184),FONT('MS Sans Serif',8,,),IMM,ICON('CREDCARD.ICO'),HLP('~BrowseCurrentTransactions'),SYSTEM,GRAY,MDI
                       LIST,AT(8,22,302,105),USE(?Browse:1),IMM,HVSCROLL,FONT(,9,,FONT:bold),MSG('Browsing Records'),FORMAT('[51C|M~Date~@d2@145L(2)|M~Description~C(0)@s35@45C|M~Type~@s10@57R(10)|M*~Amount' &|
   '~C(0)@n$(10.2)@]|M~Transaction~'),FROM(Queue:Browse:1)
                       BUTTON('&Insert'),AT(227,2,21,12),USE(?Insert:2),HIDE
                       BUTTON('&Change'),AT(252,2,21,12),USE(?Change:2),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(277,2,21,12),USE(?Delete:2),HIDE
                       BUTTON('Close'),AT(301,2,19,12),USE(?Close),HIDE
                       BOX,AT(19,136,287,31),USE(?Box1),ROUND,COLOR(COLOR:Black),LINEWIDTH(2)
                       PROMPT('Open Transactions:'),AT(178,140),TRN,CENTER,FONT('Arial',8,,FONT:bold)
                       BUTTON,AT(322,39,16,14),USE(?ReconcileButton),FONT('Arial',8,,FONT:bold),TIP('Reconcile the Selected Transaction'),ICON('CHECK.ICO')
                       STRING(@N$_12.2),AT(251,140),USE(LOC:TotalOpenTransactions),TRN,RIGHT,FONT('Arial',8,,FONT:bold)   ! STRING(@N$(_12.2)), %%%%%%%%%%%%%%%%
                       BUTTON('Help'),AT(321,127,23,14),USE(?Button6),HIDE,STD(STD:Help)
                       STRING('Average Charge:'),AT(188,152),USE(?String2),TRN,CENTER,FONT('Arial',8,,FONT:bold),COLOR(COLOR:Black)
                       STRING('Account Balance:'),AT(31,140),USE(?String5),TRN,FONT('Arial',8,,FONT:bold)
                       STRING(@n$12.2),AT(97,140),USE(ACC:AccountBalance),TRN,RIGHT,FONT('Arial',8,,FONT:bold)   ! STRING(@n$(12.2)),  %%%%%%%%%%%
                       STRING(@N$10..2),AT(259,152),USE(LOC:AvgTran),TRN,RIGHT,FONT('Arial',8,,FONT:bold)  !  STRING(@N$(10..2)),  %%%%%%%%%%
                       STRING(@n$12.2),AT(97,152),USE(LOC:AvailableFunds),TRN,RIGHT,FONT('Arial',8,,FONT:bold)   ! STRING(@n$(12.2))
                       STRING('Available Funds:'),AT(34,152),USE(?String8),TRN,FONT('Arial',8,,FONT:bold)
                       SHEET,AT(1,7,317,169),USE(?CurrentTab) ! ,ABOVE(108) %%%%%%%%%%%%%%%%%
                         TAB('Open Transactions by Date'),TIP('Browse Transactions by Date'),FONT('Arial',9,,FONT:bold)
                         END
                         TAB('Open Transactions by Type'),USE(?Tab2),FONT('Arial',9,,FONT:bold)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                 !Default Locator
BRW1::Sort1:Locator  StepLocatorClass                 !Conditional Locator - Choice(?CurrentTab) = 2

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(QuickWindow{Prop:Timer},1,100)
    QuickWindow{Prop:Timer} = 100
  END
    QuickWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
    QuickWindow{Prop:StatusText,2} = FORMAT(CLOCK(),@T3)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseCurrentTransactions')
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
  Relate:Accounts.Open
  SELF.FilesOpened = True
  !Global reference  - enable payment button on toolbar
  AppWindowRef $ GLO:Button4 {PROP:Disable} = False
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Transactions,SELF)
  OPEN(QuickWindow)
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1.AddSortOrder(,TRA:SysIDTypeKey)
  BRW1.AddRange(TRA:SysID,Relate:Transactions,Relate:Accounts)
  BRW1.AddLocator(BRW1::Sort1:Locator)
  BRW1::Sort1:Locator.Init(,TRA:TransactionType,1,BRW1)
  BRW1.SetFilter('(TRA:ReconciledTransaction = 0)')
  BRW1.AddResetField(ACC:AccountBalance)
  BRW1.AddResetField(LOC:AvailableFunds)
  BRW1.AddResetField(LOC:AvgTran)
  BRW1.AddResetField(LOC:TotalOpenTransactions)
  BRW1.AddSortOrder(,TRA:SysIDDateKey)
  BRW1.AddRange(TRA:SysID,Relate:Transactions,Relate:Accounts)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,TRA:DateofTransaction,1,BRW1)
  BRW1.SetFilter('(TRA:ReconciledTransaction = 0)')
  BRW1.AddResetField(ACC:AccountBalance)
  BRW1.AddResetField(LOC:AvailableFunds)
  BRW1.AddResetField(LOC:TotalOpenTransactions)
  BRW1.AddResetField(TRA:ReconciledTransaction)
  BIND('GLO:TransactionTypeDescription',GLO:TransactionTypeDescription)
  BIND('LOC:AvailableFunds',LOC:AvailableFunds)
  BRW1.AddField(TRA:DateofTransaction,BRW1.Q.TRA:DateofTransaction)
  BRW1.AddField(TRA:TransactionDescription,BRW1.Q.TRA:TransactionDescription)
  BRW1.AddField(GLO:TransactionTypeDescription,BRW1.Q.GLO:TransactionTypeDescription)
  BRW1.AddField(TRA:TransactionAmount,BRW1.Q.TRA:TransactionAmount)
  BRW1.AddField(TRA:ReconciledTransaction,BRW1.Q.TRA:ReconciledTransaction)
  BRW1.AddField(ACC:CreditLimit,BRW1.Q.ACC:CreditLimit)
  BRW1.AddField(LOC:AvailableFunds,BRW1.Q.LOC:AvailableFunds)
  BRW1.AddField(ACC:AccountBalance,BRW1.Q.ACC:AccountBalance)
  BRW1.AddField(TRA:SysID,BRW1.Q.TRA:SysID)
  BRW1.AddField(TRA:TransactionType,BRW1.Q.TRA:TransactionType)
  INIMgr.Fetch('BrowseCurrentTransactions',QuickWindow)
  !Set Title for Window
  ACC:Sysid = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysidKey)
  QuickWindow{PROP:Text} = 'Current Transactions for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)
  BRW1.ToolbarItem.HelpButton = ?Button6
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseCurrentTransactions',QuickWindow)
  END
   !Global reference  - disable payment button on toolbar
   AppWindowRef $ GLO:Button4 {PROP:Disable} = True
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  !Set Title for Window
  ACC:Sysid = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysidKey)
  QuickWindow{PROP:Text} = 'Current Transactions for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  !Recalculate Available Funds
  LOC:AvailableFunds = ACC:CreditLimit - ACC:AccountBalance
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  !Adjust Account Balance if Delete a Transaction Record
  GLO:HoldTransactionAmount = TRA:TransactionAmount
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  ELSE
    GlobalRequest = Request
    UpdateTransactions
    ReturnValue = GlobalResponse
  END
  !Readjust Account Balance on Accounts record
  IF GlobalRequest = DeleteRecord AND GlobalResponse = RequestCompleted
    ACC:SysID = GLO:CurrentSysid
    Access:Accounts.Fetch(ACC:SysIDKey)
    ACC:AccountBalance = ACC:AccountBalance - GLO:HoldTransactionAmount
    Access:Accounts.Update()
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?ReconcileButton
      ThisWindow.Update
      !Confirm reconciliation
       CASE MESSAGE('Do you want to reconcile this transaction?||Record will be moved to Transaction History','Confirm Reconciliation',Icon:Question,Button:Yes+Button:No,Button:No,1)
       OF Button:Yes
          ! Reconcile a transaction record
         TRA:ReconciledTransaction = 1
         Access:Transactions.Update()
         ThisWindow.ForcedReset = True
         ThisWindow.Reset
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
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:LoseFocus
      !Global reference  - disable payment button on toolbar
       AppWindowRef $ GLO:Button4 {PROP:Disable} = True
    OF EVENT:GainFocus
      !Global reference  - enable payment button on toolbar
        AppWindowRef $ GLO:Button4 {PROP:Disable} = False
    OF EVENT:Timer
        QuickWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
        QuickWindow{Prop:StatusText,2} = FORMAT(CLOCK(),@T3)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW1.ResetFromView PROCEDURE

LOC:TotalOpenTransactions:Sum REAL
LOC:AvgTran:Cnt      LONG
LOC:AvgTran:Sum      REAL
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Transactions.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      RETURN
    END
    SELF.SetQueueRecord
    LOC:TotalOpenTransactions:Sum += TRA:TransactionAmount
    IF (TRA:TransactionType <> 'P')
      LOC:AvgTran:Cnt += 1
      LOC:AvgTran:Sum += TRA:TransactionAmount
    END
  END
  LOC:TotalOpenTransactions = LOC:TotalOpenTransactions:Sum
  LOC:AvgTran = LOC:AvgTran:Sum/LOC:AvgTran:Cnt
  PARENT.ResetFromView
  Relate:Transactions.SetQuickScan(0)
  SETCURSOR()


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF Choice(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  CASE (TRA:TransactionType)
  OF 'P'
    GLO:TransactionTypeDescription = 'Pmt/Credit'
  OF 'C'
    GLO:TransactionTypeDescription = 'Charge'
  OF 'F'
    GLO:TransactionTypeDescription = 'Fee'
  OF 'I'
    GLO:TransactionTypeDescription = 'Interest'
  OF 'B'
    GLO:TransactionTypeDescription = 'Balance'
  ELSE
    GLO:TransactionTypeDescription = 'Advance'
  END
  PARENT.SetQueueRecord
  IF (TRA:TransactionAmount < 0)
    SELF.Q.TRA:TransactionAmount_NormalFG = 255
    SELF.Q.TRA:TransactionAmount_NormalBG = -1
    SELF.Q.TRA:TransactionAmount_SelectedFG = -1
    SELF.Q.TRA:TransactionAmount_SelectedBG = -1
  ELSE
    SELF.Q.TRA:TransactionAmount_NormalFG = -1
    SELF.Q.TRA:TransactionAmount_NormalBG = -1
    SELF.Q.TRA:TransactionAmount_SelectedFG = -1
    SELF.Q.TRA:TransactionAmount_SelectedBG = -1
  END

BrowseTransactionHistory PROCEDURE                    !Generated from procedure template - Window

CurrentTab           STRING(80)
LocalRequest         LONG
FilesOpened          BYTE
LOC:TotalOpenTransactions DECIMAL(7,2,0)
LOC:AvgTran          DECIMAL(7,2)
LOC:AvailableFunds   DECIMAL(7,2)
BRW1::View:Browse    VIEW(Transactions)
                       PROJECT(TRA:DateofTransaction)
                       PROJECT(TRA:TransactionDescription)
                       PROJECT(TRA:TransactionAmount)
                       PROJECT(TRA:ReconciledTransaction)
                       PROJECT(TRA:SysID)
                       PROJECT(TRA:TransactionType)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
TRA:DateofTransaction  LIKE(TRA:DateofTransaction)    !List box control field - type derived from field
TRA:TransactionDescription LIKE(TRA:TransactionDescription) !List box control field - type derived from field
GLO:TransactionTypeDescription LIKE(GLO:TransactionTypeDescription) !List box control field - type derived from global data
TRA:TransactionAmount  LIKE(TRA:TransactionAmount)    !List box control field - type derived from field
TRA:TransactionAmount_NormalFG LONG                   !Normal forground color
TRA:TransactionAmount_NormalBG LONG                   !Normal background color
TRA:TransactionAmount_SelectedFG LONG                 !Selected forground color
TRA:TransactionAmount_SelectedBG LONG                 !Selected background color
TRA:ReconciledTransaction LIKE(TRA:ReconciledTransaction) !Browse hot field - type derived from field
ACC:CreditLimit        LIKE(ACC:CreditLimit)          !Browse hot field - type derived from field
LOC:AvailableFunds     LIKE(LOC:AvailableFunds)       !Browse hot field - type derived from local data
ACC:AccountBalance     LIKE(ACC:AccountBalance)       !Browse hot field - type derived from field
TRA:SysID              LIKE(TRA:SysID)                !Browse hot field - type derived from field
TRA:TransactionType    LIKE(TRA:TransactionType)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
QuickWindow          WINDOW('Browse Transaction History'),AT(0,10,338,171),FONT('MS Sans Serif',8,,),IMM,ICON('CREDCARD.ICO'),HLP('~BrowseTransactions'),SYSTEM,GRAY,MDI
                       LIST,AT(13,26,295,103),USE(?Browse:1),IMM,HVSCROLL,FONT(,9,,FONT:bold),MSG('Browsing Records'),FORMAT('[53C|M~Date~@d2@145L(2)|M~Description~C(0)@s35@45C|M~Type~@s10@57R(10)|M*~Amount' &|
   '~C(0)@n$(10.2)@]|M~Transaction~'),FROM(Queue:Browse:1)
                       BUTTON('Help'),AT(319,112,13,17),USE(?Button5),HIDE,STD(STD:Help)
                       BUTTON('&Insert'),AT(233,2,21,12),USE(?Insert:2),HIDE
                       BUTTON('&Change'),AT(257,2,21,12),USE(?Change:2),HIDE,DEFAULT
                       BUTTON('&Delete'),AT(283,2,21,12),USE(?Delete:2),HIDE
                       BUTTON('Close'),AT(307,2,19,12),USE(?Close),HIDE
                       BOX,AT(13,136,287,18),USE(?Box1),ROUND,COLOR(COLOR:Black),LINEWIDTH(2)
                       STRING('Available Funds:'),AT(183,139),USE(?String3),TRN,FONT('Arial',8,,FONT:bold)
                       STRING(@n$_10.2),AT(249,139),USE(LOC:AvailableFunds),TRN,RIGHT,FONT('Arial',8,,FONT:bold)  ! STRING(@n$(_10.2)), %%%%%%%%%%
                       STRING(@n$12.2B),AT(94,139),USE(ACC:AccountBalance),TRN,RIGHT,FONT('Arial',8,,FONT:bold) ! STRING(@n$(12.2)B) %%%%%%%%%%
                       STRING('Account Balance:'),AT(25,139),USE(?String5),TRN,FONT('Arial',8,,FONT:bold)
                       SHEET,AT(7,8,313,155),USE(?CurrentTab)    ! ,ABOVE(108) %%%%%%%%%%%%%
                         TAB('Transactions by Date'),TIP('Browse Transactions by Date'),FONT('Arial',9,,FONT:bold)
                         END
                         TAB('Transactions by Type'),USE(?Tab2),FONT('Arial',9,,FONT:bold)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
Update                 PROCEDURE(),DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                 !Default Locator
BRW1::Sort1:Locator  StepLocatorClass                 !Conditional Locator - Choice(?CurrentTab) = 2

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(QuickWindow{Prop:Timer},1,100)
    QuickWindow{Prop:Timer} = 100
  END
    QuickWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
    QuickWindow{Prop:StatusText,2} = FORMAT(CLOCK(),@T3)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseTransactionHistory')
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
  Relate:Accounts.Open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Transactions,SELF)
  OPEN(QuickWindow)
  SELF.Opened=True
  BRW1.Q &= Queue:Browse:1
  BRW1.AddSortOrder(,TRA:SysIDTypeKey)
  BRW1.AddRange(TRA:SysID,Relate:Transactions,Relate:Accounts)
  BRW1.AddLocator(BRW1::Sort1:Locator)
  BRW1::Sort1:Locator.Init(,TRA:TransactionType,1,BRW1)
  BRW1.SetFilter('(TRA:ReconciledTransaction = 1)')
  BRW1.AddSortOrder(,TRA:SysIDDateKey)
  BRW1.AddRange(TRA:SysID,Relate:Transactions,Relate:Accounts)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,TRA:DateofTransaction,1,BRW1)
  BRW1.SetFilter('(TRA:ReconciledTransaction = 1)')
  BRW1.AddResetField(LOC:TotalOpenTransactions)
  BRW1.AddResetField(TRA:ReconciledTransaction)
  BIND('GLO:TransactionTypeDescription',GLO:TransactionTypeDescription)
  BIND('LOC:AvailableFunds',LOC:AvailableFunds)
  BRW1.AddField(TRA:DateofTransaction,BRW1.Q.TRA:DateofTransaction)
  BRW1.AddField(TRA:TransactionDescription,BRW1.Q.TRA:TransactionDescription)
  BRW1.AddField(GLO:TransactionTypeDescription,BRW1.Q.GLO:TransactionTypeDescription)
  BRW1.AddField(TRA:TransactionAmount,BRW1.Q.TRA:TransactionAmount)
  BRW1.AddField(TRA:ReconciledTransaction,BRW1.Q.TRA:ReconciledTransaction)
  BRW1.AddField(ACC:CreditLimit,BRW1.Q.ACC:CreditLimit)
  BRW1.AddField(LOC:AvailableFunds,BRW1.Q.LOC:AvailableFunds)
  BRW1.AddField(ACC:AccountBalance,BRW1.Q.ACC:AccountBalance)
  BRW1.AddField(TRA:SysID,BRW1.Q.TRA:SysID)
  BRW1.AddField(TRA:TransactionType,BRW1.Q.TRA:TransactionType)
  INIMgr.Fetch('BrowseTransactionHistory',QuickWindow)
  !Set Title for Window
  ACC:Sysid = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysidKey)
  QuickWindow{PROP:Text} = 'Transaction History for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)
  BRW1.ToolbarItem.HelpButton = ?Button5
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseTransactionHistory',QuickWindow)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  LOC:AvailableFunds = ACC:CreditLimit - ACC:AccountBalance
  !Set Title for Window
  ACC:Sysid = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysidKey)
  QuickWindow{PROP:Text} = 'Transaction History for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  !Readjust Account Balance on Accounts record
  ACC:SysID = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysIDKey)
  ACC:AccountBalance = ACC:AccountBalance - GLO:HoldTransactionAmount
  Access:Accounts.Update()
  GLO:HoldTransactionAmount = 0
  ReturnValue = PARENT.Run(Number,Request)
  ! Adjust Account Balance if Delete a Transaction Record
  GLO:HoldTransactionAmount = TRA:TransactionAmount
  !Readjust Account Balance on Accounts record
  IF GlobalRequest = DeleteRecord AND GlobalResponse = RequestCompleted
    ACC:SysID = GLO:CurrentSysid
    Access:Accounts.Fetch(ACC:SysIDKey)
    ACC:AccountBalance = ACC:AccountBalance - GLO:HoldTransactionAmount
    Access:Accounts.Update()
  END
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled
  ELSE
    GlobalRequest = Request
    UpdateTransactions
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
        QuickWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
        QuickWindow{Prop:StatusText,2} = FORMAT(CLOCK(),@T3)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.Update PROCEDURE

  CODE
  PARENT.Update
  LOC:AvailableFunds = ACC:CreditLimit - ACC:AccountBalance


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
  IF Choice(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW1.SetQueueRecord PROCEDURE

  CODE
  CASE (TRA:TransactionType)
  OF 'P'
    GLO:TransactionTypeDescription = 'Pmt/Credit'
  OF 'C'
    GLO:TransactionTypeDescription = 'Charge'
  OF 'F'
    GLO:TransactionTypeDescription = 'Fee'
  OF 'I'
    GLO:TransactionTypeDescription = 'Interest'
  OF 'B'
    GLO:TransactionTypeDescription = 'Balance'
  ELSE
    GLO:TransactionTypeDescription = 'Advance'
  END
  PARENT.SetQueueRecord
  IF (TRA:TransactionAmount < 0)
    SELF.Q.TRA:TransactionAmount_NormalFG = 255
    SELF.Q.TRA:TransactionAmount_NormalBG = -1
    SELF.Q.TRA:TransactionAmount_SelectedFG = -1
    SELF.Q.TRA:TransactionAmount_SelectedBG = -1
  ELSE
    SELF.Q.TRA:TransactionAmount_NormalFG = -1
    SELF.Q.TRA:TransactionAmount_NormalBG = -1
    SELF.Q.TRA:TransactionAmount_SelectedFG = -1
    SELF.Q.TRA:TransactionAmount_SelectedBG = -1
  END

PrintAccountPurchases PROCEDURE                       !Generated from procedure template - Report

LocalRequest         LONG
FilesOpened          BYTE
LOC:TransactionType  STRING(7)
Progress:Thermometer BYTE
Process:View         VIEW(Transactions)
                       PROJECT(TRA:DateofTransaction)
                       PROJECT(TRA:ReconciledTransaction)
                       PROJECT(TRA:SysID)
                       PROJECT(TRA:TransactionAmount)
                       PROJECT(TRA:TransactionDescription)
                       PROJECT(TRA:TransactionType)
                       JOIN(ACC:SysIDKey,TRA:SysID)
                         PROJECT(ACC:AccountNumber)
                         PROJECT(ACC:CreditCardVendor)
                         PROJECT(ACC:SysID)
                       END
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(1000,2083,6000,6917),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1010,1000,6000,1083)
                         LINE,AT(5927,1063,4,-1021),USE(?Line3),COLOR(COLOR:Black),LINEWIDTH(4)
                         STRING('History of Purchases'),AT(135,104,2719,208),TRN,LEFT,FONT('Arial',14,,FONT:bold)
                         LINE,AT(10,552,4,-531),USE(?Line2),COLOR(COLOR:Black),LINEWIDTH(4)
                         IMAGE('CRDTCRDS.WMF'),AT(4729,83,1010,970),USE(?Image1)
                         STRING('for'),AT(135,313),USE(?String11),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         BOX,AT(10,531,4510,521),COLOR(COLOR:Black),LINEWIDTH(4)
                         STRING(@s30),AT(135,604,2917,208),USE(ACC:CreditCardVendor),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         STRING(@s20),AT(135,813,1979,208),USE(ACC:AccountNumber),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                       END
break1                 BREAK(TRA:SysID)
detail                   DETAIL,AT(-10,10,6000,458),USE(?detail1)
                           STRING(@d2),AT(52,146,1400,170),USE(TRA:DateofTransaction)
                           STRING(@s35),AT(917,146,2698,167),USE(TRA:TransactionDescription)
                           STRING(@s10),AT(3823,146,750,167),USE(GLO:TransactionTypeDescription)
                           STRING(@n$10.2-),AT(5063,146,698,167),USE(TRA:TransactionAmount),TRN,RIGHT
                           LINE,AT(50,460,5900,0),COLOR(COLOR:Black)
                         END
                         FOOTER,AT(0,0,,490)
                           BOX,AT(42,115,2333,313),USE(?Box2),COLOR(COLOR:Black)
                           STRING(@d2),AT(135,167,729,208),USE(GLO:LowDate),TRN,RIGHT,FONT('Arial',10,,FONT:bold)
                           STRING('through'),AT(958,167),USE(?String13),TRN,CENTER,FONT('Arial',10,,FONT:bold)
                           STRING(@d2),AT(1563,167),USE(GLO:HighDate),TRN,LEFT,FONT('Arial',10,,FONT:bold)
                           STRING(@n$10.2-),AT(4813,167,938,208),SUM,USE(TRA:TransactionAmount,,?TRA:TransactionAmount:2),TRN,RIGHT,FONT('Arial',,,FONT:bold)
                           STRING('Total for this date range:'),AT(3313,167),USE(?String10),TRN,RIGHT,FONT('Arial',,,FONT:bold)
                         END
                       END
                       FOOTER,AT(1000,9000,6000,219)
                         STRING(@pPage <<<#p),AT(5250,30,700,135),PAGENO,USE(?PageCount),FONT('Arial',8,,FONT:regular)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Update                 PROCEDURE(),DERIVED
                     END

ThisReport           CLASS(ProcessClass)              !Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                    !Progress Manager
Previewer            PrintPreviewClass                !Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PrintAccountPurchases')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  BIND('GLO:CurrentSysid',GLO:CurrentSysid)
  BIND('GLO:HighDate',GLO:HighDate)
  BIND('GLO:LowDate',GLO:LowDate)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Transactions.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
  SELF.Opened=True
  INIMgr.Fetch('PrintAccountPurchases',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Transactions, ?Progress:PctText, Progress:Thermometer, 25)
  ThisReport.AddSortOrder(TRA:SysIDDateKey)
  ThisReport.SetFilter('TRA:TransactionType = ''C'' AND TRA:SysID = GLO:CurrentSysID AND TRA:DateofTransaction  >= GLO:LowDate AND TRA:DateofTransaction <<= GLO:HighDate')
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Transactions.SetQuickScan(1,Propagate:OneMany)
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Transactions.Close
  END
  IF SELF.Opened
    INIMgr.Update('PrintAccountPurchases',ProgressWindow)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF ProgressWindow{Prop:AcceptAll} THEN RETURN.
  ACC:SysID = TRA:SysID                               ! Assign linking field value
  Access:Accounts.Fetch(ACC:SysIDKey)
  PARENT.Reset(Force)


ThisWindow.Update PROCEDURE

  CODE
  PARENT.Update
  ACC:SysID = TRA:SysID                               ! Assign linking field value
  Access:Accounts.Fetch(ACC:SysIDKey)


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  CASE (TRA:TransactionType)
  OF 'P'
    GLO:TransactionTypeDescription = 'Pmt/Credit'
  OF 'C'
    GLO:TransactionTypeDescription = 'Charge'
  OF 'F'
    GLO:TransactionTypeDescription = 'Fee'
  OF 'I'
    GLO:TransactionTypeDescription = 'Interest'
  ELSE
    GLO:TransactionTypeDescription = 'Cash Adv'
  END
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

PickaReport PROCEDURE                                 !Generated from procedure template - Window

LocalRequest         LONG
FilesOpened          BYTE
LOC:ReportChoice     STRING(10)
window               WINDOW('Select a Report for '),AT(,,205,100),IMM,ICON('CREDCARD.ICO'),HLP('~PickAReport'),SYSTEM,GRAY,MDI
                       BUTTON,AT(174,15,16,16),USE(?OkButton),RIGHT,TIP('Print this Report'),ICON(ICON:Print),DEFAULT
                       BUTTON,AT(174,35,16,16),USE(?CancelButton),RIGHT,TIP('Cancel - Do Not Print'),ICON(ICON:NoPrint),STD(STD:Close)
                       BUTTON,AT(174,66,16,16),USE(?Button3),ICON(ICON:Help),STD(STD:Help)
                       OPTION('Pick a Report '),AT(25,10,141,74),USE(LOC:ReportChoice),BOXED,FONT('Arial',9,,FONT:bold)
                         RADIO('Open Transactions for this Account'),AT(38,21),USE(?LOC:ReportChoice:Radio1),VALUE('Open')
                         RADIO('Transaction History on this Account'),AT(38,36),USE(?LOC:ReportChoice:Radio2),FONT('Arial',9,,FONT:bold),VALUE('History')
                         RADIO('Purchases Made on this Account'),AT(38,51),USE(?LOC:ReportChoice:Radio3),FONT('Arial',9,,FONT:bold),VALUE('Purchases')
                         RADIO('Payment History on this Account'),AT(38,66),USE(?LOC:ReportChoice:Radio4),FONT('Arial',9,,FONT:bold),VALUE('Payments')
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PickaReport')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OkButton
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Accounts.Open
  SELF.FilesOpened = True
  OPEN(window)
  SELF.Opened=True
  INIMgr.Fetch('PickaReport',window)
    !Assign global sysid variable to account sysid for reading Accounts file
   ACC:Sysid = GLO:CurrentSysid
   Access:Accounts.Fetch(ACC:SysIDKey)
    !Assign title bar text
   Window{PROP:Text} = 'Report Transactions for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Accounts.Close
  END
  IF SELF.Opened
    INIMgr.Update('PickaReport',window)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF window{Prop:AcceptAll} THEN RETURN.
     !Assign global sysid to account sysid for reading Accounts file.
  ACC:Sysid = GLO:CurrentSysid
  Access:Accounts.Fetch(ACC:SysIDKey)
  !Assign text for title bar
  Window{PROP:Text} = 'Report Transactions for ' & CLIP(ACC:CreditCardVendor) & ' ( ' & CLIP(GLO:CardTypeDescription) & ' )'
  PARENT.Reset(Force)


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?OkButton
      !Determine report choice and run appropriate procedures
      CASE LOC:ReportChoice
      OF 'Open'
        PrintOpenTransactions
      OF 'History'
        UpdateDates
        PrintAccountTransactionHistory
      OF 'Purchases'
        UpdateDates
        PrintAccountPurchases
      OF 'Payments'
        UpdateDates
        PrintPaymentHistory
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

