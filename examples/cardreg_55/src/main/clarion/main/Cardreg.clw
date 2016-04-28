   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('EQUATES.CLW'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE

   MAP
     MODULE('CARDRBC.CLW')
DctInit     PROCEDURE
DctKill     PROCEDURE
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('CARDR001.CLW')
Main                   PROCEDURE   !Clarion for Windows Wizard Application 
     END
   END

GLO:CardTypeDescription STRING(16)
GLO:TodaysDate     LONG
GLO:CurrentSysid   LONG
GLO:LowDate        LONG
GLO:HighDate       LONG
GLO:SysID          LONG
GLO:TransactionTypeDescription STRING(10)
GLO:RunTranHistRpt BYTE(0)
GLO:RunPurchasesRpt STRING('0 {19}')
GLO:MakePayment    BYTE(0)
GLO:HoldTransactionAmount DECIMAL(7,2)
AppWindowRef       &WINDOW
GLO:Button1        LONG
GLO:Button2        LONG
GLO:Button3        LONG
GLO:Button4        LONG
GLO:TOTAL          REAL
SilentRunning        BYTE(0)                         !Set true when application is running in silent mode

! Accounts             FILE,DRIVER('TOPSPEED'),PRE(ACC),BINDABLE,CREATE,THREAD  ! %%%%%%%%%%%%
Accounts             FILE,DRIVER('ODBC'),NAME('Accounts'),PRE(ACC),BINDABLE,CREATE,THREAD ! %%%%%%%%%%%%%%%%%%%

SysIDKey                 KEY(ACC:SysID),NOCASE,OPT,PRIMARY
CreditCardVendorKey      KEY(ACC:CreditCardVendor),DUP,NOCASE,OPT
AccountNumberKey         KEY(ACC:AccountNumber),DUP,NOCASE,OPT
Record                   RECORD,PRE()
SysID                       LONG
CreditCardVendor            STRING(30)
CardType                    STRING(1)
AccountNumber               STRING(20)
ExpirationDate              LONG
VendorAddr1                 STRING(35)
VendorAddr2                 STRING(35)
VendorCity                  STRING(25)
VendorState                 STRING(2)
VendorZip                   STRING(10)
BalanceInfoPhone            DECIMAL(10)
LostCardPhone               DECIMAL(10)
InterestRate                DECIMAL(5,2)
CreditLimit                 DECIMAL(7,2)
BillingDay                  SHORT
AccountBalance              DECIMAL(7,2)
                         END
                     END                       

Transactions         FILE,DRIVER('ODBC'),NAME('Transactions'),PRE(TRA),BINDABLE,CREATE,THREAD ! replace driver to ODBC and NAME added %%%%%%%%%%%%%%
SysIDKey                 KEY(TRA:SysID),DUP,NOCASE,OPT
SysIDTypeKey             KEY(TRA:SysID,TRA:TransactionType),DUP,NOCASE,OPT
SysIDDateKey             KEY(TRA:SysID,TRA:DateofTransaction),DUP,NOCASE,OPT
DateKey                  KEY(-TRA:DateofTransaction),DUP,NOCASE,OPT
TypeKey                  KEY(TRA:TransactionType),DUP,NOCASE,OPT
Record                   RECORD,PRE()
SysID                       LONG
DateofTransaction           LONG
TransactionDescription      STRING(35)
TransactionType             STRING(1)
TransactionAmount           DECIMAL(7,2)
ReconciledTransaction       BYTE
                         END
                     END                       



Access:Accounts      &FileManager
Relate:Accounts      &RelationManager
Access:Transactions  &FileManager
Relate:Transactions  &RelationManager
FuzzyMatcher         FuzzyClass
GlobalErrors         ErrorClass
INIMgr               INIClass
GlobalRequest        BYTE(0),THREAD
GlobalResponse       BYTE(0),THREAD
VCRRequest           LONG(0),THREAD
lCurrentFDSetting    LONG
lAdjFDSetting        LONG

  CODE
  HELP('CARDREG.HLP')
  GlobalErrors.Init
  DctInit
  FuzzyMatcher.Init
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)
  INIMgr.Init('.cardreg.ini')
  SystemParametersInfo( 38, 0, lCurrentFDSetting, 0 )
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 0, lAdjFDSetting, 3 )
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 1, lAdjFDSetting, 3 )
  END
  INIMgr.Kill
  FuzzyMatcher.Kill
  DctKill
  GlobalErrors.Kill


