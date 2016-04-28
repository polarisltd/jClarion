   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   !C6RW library
   INCLUDE('RWPRLIB.INC')

   MAP
     MODULE('Windows API')
SystemParametersInfo PROCEDURE (LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni),LONG,RAW,PROC,PASCAL,DLL(TRUE),NAME('SystemParametersInfoA')
     END
     MODULE('INVOIBC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('INVOI001.CLW')
Main                   PROCEDURE   !Clarion for Windows Wizard Application - with Wallpaper
     END
     MODULE('INVOI003.CLW')
UpdateCompany          PROCEDURE   !Update the Company File
     END
     INCLUDE('CWUtil.INC')
   END

GLOT:CustName      STRING(35),THREAD
GLOT:ShipName      STRING(35),THREAD
GLOT:CustAddress   STRING(45),THREAD
GLOT:ShipAddress   STRING(45),THREAD
GLOT:CusCSZ        STRING(40),THREAD
GLOT:ShipCSZ       STRING(40),THREAD
GLO:Pathname       STRING(50)
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

States               FILE,DRIVER('ODBC'),NAME('States'),PRE(STA),CREATE,BINDABLE,THREAD
StateCodeKey              KEY(STA:StateCode),NOCASE,OPT,PRIMARY
Record                   RECORD,PRE()
StateCode                   STRING(2)
Name                        STRING(25)
                         END
                     END                       

Company              FILE,DRIVER('ODBC'),NAME('Company'),PRE(COM),CREATE,BINDABLE,THREAD
KeyId              			KEY(COM:CompanyNumber),NOCASE,PRIMARY
Record                   RECORD,PRE()
CompanyNumber	LONG
Name                        STRING(20)
Address                     STRING(35)
City                        STRING(25)
State                       STRING(2)
Zipcode                     STRING(10)
Phone                       STRING(10)
                         END
                     END                       

Products             FILE,DRIVER('ODBC'),NAME('Products'),PRE(PRO),CREATE,BINDABLE,THREAD
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

InvHist              FILE,DRIVER('ODBC'),NAME('InvHist'),PRE(INV),CREATE,BINDABLE,THREAD
KeyId              KEY(INV:Id),PRIMARY
KeyProductNumberDate     KEY(INV:ProductNumber,INV:VendorNumber,INV:Date),DUP,NOCASE,OPT
KeyProdNumberDate        KEY(INV:ProductNumber,INV:Date),DUP,NOCASE,OPT
KeyVendorNumberDate      KEY(INV:VendorNumber,INV:Date),DUP,NOCASE,OPT
Record                   RECORD,PRE()
Id                        LONG
Date                        LONG
TransType                   STRING(7)
ProductNumber               LONG
Quantity                    DECIMAL(7,2)
VendorNumber                LONG
Cost                        DECIMAL(7,2)
Notes                       STRING(50)
                         END
                     END                       

Detail               FILE,DRIVER('ODBC'),NAME('Detail'),PRE(DTL),CREATE,BINDABLE,THREAD
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

Orders               FILE,DRIVER('ODBC'),NAME('Orders'),PRE(ORD),CREATE,BINDABLE,THREAD
KeyCustOrderNumber       KEY(ORD:CustNumber,ORD:OrderNumber),DUP,NOCASE,OPT
InvoiceNumberKey         KEY(ORD:InvoiceNumber),NOCASE,OPT
KeyOrderNumber            KEY(CUS:OrderNumber),PRIMARY
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

Customers            FILE,NAME('Customers'),DRIVER('ODBC'),PRE(CUS),CREATE,BINDABLE,THREAD
KeyCustNumber            KEY(CUS:CustNumber),PRIMARY
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



RE          ReportEngine
Access:States        &FileManager,THREAD                   ! FileManager for States
Relate:States        &RelationManager,THREAD               ! RelationManager for States
Access:Company       &FileManager,THREAD                   ! FileManager for Company
Relate:Company       &RelationManager,THREAD               ! RelationManager for Company
Access:Products      &FileManager,THREAD                   ! FileManager for Products
Relate:Products      &RelationManager,THREAD               ! RelationManager for Products
Access:InvHist       &FileManager,THREAD                   ! FileManager for InvHist
Relate:InvHist       &RelationManager,THREAD               ! RelationManager for InvHist
Access:Detail        &FileManager,THREAD                   ! FileManager for Detail
Relate:Detail        &RelationManager,THREAD               ! RelationManager for Detail
Access:Orders        &FileManager,THREAD                   ! FileManager for Orders
Relate:Orders        &RelationManager,THREAD               ! RelationManager for Orders
Access:Customers     &FileManager,THREAD                   ! FileManager for Customers
Relate:Customers     &RelationManager,THREAD               ! RelationManager for Customers

GlobalErrors         ErrorClass,THREAD                     ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

lCurrentFDSetting    LONG                                  ! Used by window frame dragging
lAdjFDSetting        LONG                                  ! ditto

  CODE
  HELP('INVOICE.HLP')                                      ! Open the applications help file
  INIMgr.Init('.\invoice.INI', NVD_INI)                    ! Configure INIManager to use INI file
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
  SystemParametersInfo (38, 0, lCurrentFDSetting, 0)       ! Configure frame dragging
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 0, lAdjFDSetting, 3)
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo (37, 1, lAdjFDSetting, 3)
  END
  INIMgr.Kill                                              ! Destroy INI manager


Dictionary.Construct PROCEDURE

  CODE
  DctInit()


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

