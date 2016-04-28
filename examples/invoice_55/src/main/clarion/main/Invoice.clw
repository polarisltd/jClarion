   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('EQUATES.CLW'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE

   MAP
     MODULE('INVOIBC.CLW')
DctInit     PROCEDURE
DctKill     PROCEDURE
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('INVOI001.CLW')
Main                   PROCEDURE   !Clarion for Windows Wizard Application - with Wallpaper
     END
     MODULE('INVOI002.CLW')
UpdateCompany          PROCEDURE   !Update the Company File
     END
   END

GLOT:CustName      STRING(35),THREAD
GLOT:ShipName      STRING(35),THREAD
GLOT:CustAddress   STRING(45),THREAD
GLOT:ShipAddress   STRING(45),THREAD
GLOT:CusCSZ        STRING(40),THREAD
GLOT:ShipCSZ       STRING(40),THREAD
GLO:Pathname       STRING(50)
SilentRunning        BYTE(0)                         !Set true when application is running in silent mode

States               FILE,DRIVER('ODBC'),PRE(STA),CREATE,BINDABLE,THREAD,NAME('states')
StateCodeKey             KEY(STA:StateCode),NOCASE,OPT
Record                   RECORD,PRE()
StateCode                   STRING(2)
Name                        STRING(25)
                         END
                     END                       

Company              FILE,DRIVER('ODBC'),PRE(COM),CREATE,BINDABLE,THREAD,NAME('company')
Record                   RECORD,PRE()
Name                        STRING(20)
Address                     STRING(35)
City                        STRING(25)
State                       STRING(2)
Zipcode                     STRING(10)
Phone                       STRING(10)
                         END
                     END                       

Products             FILE,DRIVER('ODBC'),PRE(PRO),CREATE,BINDABLE,THREAD,NAME('products')
KeyProductNumber         KEY(PRO:ProductNumber),NOCASE,OPT,PRIMARY
KeyProductSKU            KEY(PRO:ProductSKU),NOCASE,OPT
KeyDescription           KEY(PRO:Description),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ProductNumber               LONG
ProductSKU                  STRING(10)
Description                 STRING(35)
Price                       DECIMAL(7,2)
QuantityInStock             DECIMAL(7,2)
ReorderQuantity             DECIMAL(7,2)
Cost                        DECIMAL(7,2)
PictureFile                 STRING(64)
                         END
                     END                       

InvHist              FILE,DRIVER('ODBC'),PRE(INV),CREATE,BINDABLE,THREAD,NAME('invhist')
KeyProductNumberDate     KEY(INV:ProductNumber,INV:VendorNumber,INV:Date),DUP,NOCASE,OPT
KeyProdNumberDate        KEY(INV:ProductNumber,INV:Date),DUP,NOCASE,OPT
KeyVendorNumberDate      KEY(INV:VendorNumber,INV:Date),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Date                        LONG
TransType                   STRING(7)
ProductNumber               LONG
Quantity                    DECIMAL(7,2)
VendorNumber                LONG
Cost                        DECIMAL(7,2)
Notes                       STRING(50)
                         END
                     END                       

Detail               FILE,DRIVER('ODBC'),PRE(DTL),CREATE,BINDABLE,THREAD,NAME('detail')
KeyDetails               KEY(DTL:CustNumber,DTL:OrderNumber,DTL:LineNumber),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
CustNumber                  LONG
OrderNumber                 LONG
LineNumber                  SHORT
ProductNumber               LONG
QuantityOrdered             DECIMAL(7,2)
BackOrdered                 BYTE
Price                       DECIMAL(7,2)
TaxRate                     DECIMAL(6,4)
TaxPaid                     DECIMAL(7,2)
DiscountRate                DECIMAL(6,4)
Discount                    DECIMAL(7,2)
Savings                     DECIMAL(7,2)
TotalCost                   DECIMAL(10,2)
                         END
                     END                       

Orders               FILE,DRIVER('ODBC'),NAME('Orders.tps'),PRE(ORD),CREATE,BINDABLE,THREAD,NAME('orders')
KeyCustOrderNumber       KEY(ORD:CustNumber,ORD:OrderNumber),DUP,NOCASE,OPT
InvoiceNumberKey         KEY(ORD:InvoiceNumber),NOCASE,OPT
Record                   RECORD,PRE()
CustNumber                  LONG
OrderNumber                 LONG
InvoiceNumber               LONG
OrderDate                   LONG
SameName                    BYTE
ShipToName                  STRING(45)
SameAdd                     BYTE
ShipAddress1                STRING(35)
ShipAddress2                STRING(35)
ShipCity                    STRING(25)
ShipState                   STRING(2)
ShipZip                     STRING(10)
OrderShipped                BYTE
OrderNote                   STRING(80)
                         END
                     END                       

Customers            FILE,DRIVER('ODBC'),PRE(CUS),CREATE,BINDABLE,THREAD,NAME('customers')
KeyCustNumber            KEY(CUS:CustNumber),NOCASE,OPT
KeyFullName              KEY(CUS:LastName,CUS:FirstName,CUS:MI),DUP,NOCASE,OPT
KeyCompany               KEY(CUS:Company),DUP,NOCASE
KeyZipCode               KEY(CUS:ZipCode),DUP,NOCASE
StateKey                 KEY(CUS:State),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CustNumber                  LONG
Company                     STRING(20)
FirstName                   STRING(20)
MI                          STRING(1)
LastName                    STRING(25)
Address1                    STRING(35)
Address2                    STRING(35)
City                        STRING(25)
State                       STRING(2)
ZipCode                     STRING(10)
PhoneNumber                 STRING(10)
Extension                   STRING(4)
PhoneType                   STRING(8)
                         END
                     END                       



!C5W library
 INCLUDE('RWPRLIB.INC')

RE   ReportEngine
Access:States        &FileManager
Relate:States        &RelationManager
Access:Company       &FileManager
Relate:Company       &RelationManager
Access:Products      &FileManager
Relate:Products      &RelationManager
Access:InvHist       &FileManager
Relate:InvHist       &RelationManager
Access:Detail        &FileManager
Relate:Detail        &RelationManager
Access:Orders        &FileManager
Relate:Orders        &RelationManager
Access:Customers     &FileManager
Relate:Customers     &RelationManager
FuzzyMatcher         FuzzyClass
GlobalErrors         ErrorClass
INIMgr               INIClass
GlobalRequest        BYTE(0),THREAD
GlobalResponse       BYTE(0),THREAD
VCRRequest           LONG(0),THREAD
lCurrentFDSetting    LONG
lAdjFDSetting        LONG

  CODE
  HELP('INVOICE.HLP')
  GlobalErrors.Init
  DctInit
  FuzzyMatcher.Init
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)
  INIMgr.Init('.\Invoice.ini')
  OPEN(Company)
  IF ERRORCODE() = 2                  !File not found
    CREATE(Company)                   !Create file
    OPEN(Company)
    GlobalRequest = InsertRecord      !Insert mode for form
    UpdateCompany
  END
  Access:Company.Close()  !Clse file
  Relate:Company.Open
  SET(Company)
  Access:Company.Next()
  Main
  INIMgr.Update
  FuzzyMatcher.Kill
  DctKill
  GlobalErrors.Kill


