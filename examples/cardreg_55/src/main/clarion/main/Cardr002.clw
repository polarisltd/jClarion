

   MEMBER('Cardreg.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('CARDR002.INC'),ONCE        !Local module procedure declarations
                     END


PrintAccountTransactionHistory PROCEDURE              !Generated from procedure template - Report

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
                         STRING('History of Transactions'),AT(135,104,2719,208),TRN,LEFT,FONT('Arial',14,,FONT:bold)
                         LINE,AT(10,552,4,-531),USE(?Line2),COLOR(COLOR:Black),LINEWIDTH(4)
                         IMAGE('CRDTCRDS.WMF'),AT(4729,83,1010,970),USE(?Image1)
                         STRING('for'),AT(135,313),USE(?String11),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         BOX,AT(10,531,4510,521),COLOR(COLOR:Black),LINEWIDTH(4)
                         STRING(@s30),AT(135,604,2917,208),USE(ACC:CreditCardVendor),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         STRING(@s20),AT(135,813,1979,208),USE(ACC:AccountNumber),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                       END
break1                 BREAK(TRA:SysID)
detail                   DETAIL,AT(10,,6000,458),USE(?detail1)
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
  GlobalErrors.SetProcedureName('PrintAccountTransactionHistory')
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
  INIMgr.Fetch('PrintAccountTransactionHistory',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Transactions, ?Progress:PctText, Progress:Thermometer, 25)
  ThisReport.AddSortOrder(TRA:SysIDDateKey)
  ThisReport.SetFilter('TRA:ReconciledTransaction = 1 AND TRA:SysID = GLO:CurrentSysID AND TRA:DateofTransaction  >= GLO:LowDate AND TRA:DateofTransaction <<= GLO:HighDate')
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
    INIMgr.Update('PrintAccountTransactionHistory',ProgressWindow)
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

PrintOpenTransactions PROCEDURE                       !Generated from procedure template - Report

LocalRequest         LONG
FilesOpened          BYTE
LOC:TransactionType  STRING(7)
LOC:Prntr            STRING(40)
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
                         STRING('Open Transactions'),AT(135,104,1979,208),TRN,LEFT,FONT('Arial',14,,FONT:bold)
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
                         FOOTER,AT(0,0,,354)
                           STRING(@n$10.2-),AT(4813,83,938,208),SUM,USE(TRA:TransactionAmount,,?TRA:TransactionAmount:2),TRN,RIGHT,FONT('Arial',,,FONT:bold)
                           STRING('Total Open Transactions:'),AT(3083,83),USE(?String10),TRN,FONT('Arial',,,FONT:bold)
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
  GlobalErrors.SetProcedureName('PrintOpenTransactions')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  BIND('GLO:CurrentSysid',GLO:CurrentSysid)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Transactions.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
  SELF.Opened=True
  INIMgr.Fetch('PrintOpenTransactions',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Transactions, ?Progress:PctText, Progress:Thermometer, 25)
  ThisReport.AddSortOrder(TRA:SysIDDateKey)
  ThisReport.AddRange(TRA:SysID,GLO:CurrentSysid)
  ThisReport.SetFilter('TRA:ReconciledTransaction = 0')
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
    INIMgr.Update('PrintOpenTransactions',ProgressWindow)
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

PrintPaymentHistory PROCEDURE                         !Generated from procedure template - Report

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
                         STRING('History of Payments'),AT(135,104,2719,208),TRN,LEFT,FONT('Arial',14,,FONT:bold)
                         LINE,AT(10,552,4,-531),USE(?Line2),COLOR(COLOR:Black),LINEWIDTH(4)
                         IMAGE('CRDTCRDS.WMF'),AT(4729,83,1010,970),USE(?Image1)
                         STRING('for'),AT(135,313),USE(?String11),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         BOX,AT(10,531,4510,521),COLOR(COLOR:Black),LINEWIDTH(4)
                         STRING(@s30),AT(135,604,2917,208),USE(ACC:CreditCardVendor),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                         STRING(@s20),AT(135,813,1979,208),USE(ACC:AccountNumber),TRN,LEFT,FONT('Arial',11,,FONT:bold)
                       END
break1                 BREAK(TRA:SysID)
detail                   DETAIL,AT(-10,10,6000,458),USE(?detail1)
                           STRING(@d2),AT(52,135,1400,170),USE(TRA:DateofTransaction)
                           STRING(@s35),AT(917,135,2698,167),USE(TRA:TransactionDescription)
                           STRING(@s10),AT(3823,135,750,167),USE(GLO:TransactionTypeDescription)
                           STRING(@n$10.2-),AT(5063,135,698,167),USE(TRA:TransactionAmount),TRN,RIGHT
                           LINE,AT(50,460,5900,0),COLOR(COLOR:Black)
                         END
                         FOOTER,AT(0,0,,490)
                           BOX,AT(42,115,2333,313),USE(?Box2),COLOR(COLOR:Black)
                           STRING(@d2),AT(135,167,729,208),USE(GLO:LowDate,,?GLO:LowDate:2),TRN,RIGHT,FONT('Arial',10,,FONT:bold)
                           STRING('through'),AT(958,167),USE(?String13),TRN,CENTER,FONT('Arial',10,,FONT:bold)
                           STRING(@d2),AT(1563,167),USE(GLO:HighDate,,?GLO:HighDate:2),TRN,LEFT,FONT('Arial',10,,FONT:bold)
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
  GlobalErrors.SetProcedureName('PrintPaymentHistory')
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
  INIMgr.Fetch('PrintPaymentHistory',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Transactions, ?Progress:PctText, Progress:Thermometer, 25)
  ThisReport.AddSortOrder(TRA:SysIDDateKey)
  ThisReport.SetFilter('TRA:TransactionType = ''P'' AND TRA:SysID = GLO:CurrentSysID AND TRA:DateofTransaction  >= GLO:LowDate AND TRA:DateofTransaction <<= GLO:HighDate')
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
    INIMgr.Update('PrintPaymentHistory',ProgressWindow)
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

UpdateDates PROCEDURE                                 !Generated from procedure template - Window

LocalRequest         LONG
FilesOpened          BYTE
window               WINDOW('Date Ranges for Report'),AT(,,171,83),IMM,ICON('CREDCARD.ICO'),HLP('~DateRangesForm'),SYSTEM,GRAY
                       STRING('Input Range of Dates for Report Selected...'),AT(19,13),USE(?String1),FONT('Arial',9,,FONT:bold)
                       STRING('Start Date:'),AT(35,30),USE(?String2),FONT('Arial',9,,FONT:bold)
                       SPIN(@d2),AT(71,29,50,12),USE(GLO:LowDate),CENTER,RANGE(4,109211),STEP(1)
                       STRING('End Date:'),AT(38,47),USE(?String3),FONT('Arial',9,,FONT:bold)
                       SPIN(@d2),AT(71,46,50,12),USE(GLO:HighDate),RANGE(4,109211),STEP(1)
                       BUTTON('OK'),AT(46,63,30,15),USE(?OkButton),FONT('Arial',10,,FONT:bold),STD(STD:Close),DEFAULT
                       BUTTON('Cancel'),AT(79,63,30,15),USE(?CancelButton),FONT('Arial',10,,FONT:bold),STD(STD:Close)
                       BUTTON,AT(115,63,16,15),USE(?HelpButton),ICON(ICON:Help),STD(STD:Help)
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
  GlobalErrors.SetProcedureName('UpdateDates')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Accounts.Open
  Access:Transactions.UseFile
  SELF.FilesOpened = True
  OPEN(window)
  SELF.Opened=True
  INIMgr.Fetch('UpdateDates',window)
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
    INIMgr.Update('UpdateDates',window)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue

SplashScreen PROCEDURE                                !Generated from procedure template - Splash

LocalRequest         LONG
FilesOpened          BYTE
window               WINDOW,AT(,,261,149),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,NOFRAME,MDI
                       PANEL,AT(0,0,261,149),BEVEL(6)
                       PANEL,AT(7,7,246,135),BEVEL(-2,1)
                       STRING('Plastic Money'),AT(22,11,217,26),USE(?String3),TRN,FONT('Impact',30,,FONT:italic)
                       STRING('Manager'),AT(171,28,74,23),USE(?String3:2),TRN,FONT('Impact',20,,FONT:italic)
                       STRING('A Credit Card Registry & Transaction Log'),AT(41,49,182,10),USE(?String2),TRN,CENTER,FONT('Arial',9,,FONT:bold)
                       IMAGE('sv_small.jpg'),AT(69,62,126,75),USE(?Image1),CENTERED
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SplashScreen')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String3
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  OPEN(window)
  SELF.Opened=True
  TARGET{Prop:Timer} = 1000
  TARGET{Prop:Alrt,255} = MouseLeft
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
  LOOP
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
        POST(Event:CloseWindow)
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)
    OF Event:Timer
      POST(Event:CloseWindow)
    OF Event:AlertKey
      CASE KEYCODE()
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

