   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE

   MAP
     MODULE('Windows API')
SystemParametersInfo PROCEDURE (LONG uAction, LONG uParam, *? lpvParam, LONG fuWinIni),LONG,RAW,PROC,PASCAL,DLL(TRUE),NAME('SystemParametersInfoA')
     END
     MODULE('TUTORBC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('TUTOR001.CLW')
Main                   PROCEDURE   !Wizard Application for C:\Clarion6\Tutorial\TUTOR.DCT
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

CUSTOMER             FILE,DRIVER('ODBC'),NAME('CUSTOMER'),PRE(CUS),CREATE,BINDABLE,THREAD
KEYCUSTNUMBER            KEY(CUS:CUSTNUMBER),NOCASE,OPT
KEYCOMPANY               KEY(CUS:COMPANY),DUP,NOCASE
KEYZIPCODE               KEY(CUS:ZIPCODE),DUP,NOCASE
Record                   RECORD,PRE()
CUSTNUMBER                  LONG
COMPANY                     STRING(20)
FIRSTNAME                   STRING(20)
LASTNAME                    STRING(20)
ADDRESS                     STRING(20)
CITY                        STRING(20)
STATE                       STRING(2)
ZIPCODE                     LONG
                         END
                     END                       

ORDERS               FILE,DRIVER('ODBC'),NAME('ORDERS'),PRE(ORD),CREATE,BINDABLE,THREAD
KEYORDERNUMBER           KEY(ORD:ORDERNUMBER),NOCASE,OPT,PRIMARY
KEYCUSTNUMBER            KEY(ORD:CUSTNUMBER),DUP,NOCASE,OPT
Record                   RECORD,PRE()
CUSTNUMBER                  LONG
ORDERNUMBER                 LONG
INVOICEAMOUNT               DECIMAL(7,2)
ORDERDATE                   DATE
ORDERNOTE                   STRING(80)
                         END
                     END                       

States               FILE,DRIVER('ODBC'),NAME('STATES'),PRE(STA),CREATE,BINDABLE,THREAD
KeyState                 KEY(STA:State),NOCASE,OPT
Record                   RECORD,PRE()
State                       STRING(2)
StateName                   STRING(30)
                         END
                     END                       



Access:CUSTOMER      &FileManager,THREAD                   ! FileManager for CUSTOMER
Relate:CUSTOMER      &RelationManager,THREAD               ! RelationManager for CUSTOMER
Access:ORDERS        &FileManager,THREAD                   ! FileManager for ORDERS
Relate:ORDERS        &RelationManager,THREAD               ! RelationManager for ORDERS
Access:States        &FileManager,THREAD                   ! FileManager for States
Relate:States        &RelationManager,THREAD               ! RelationManager for States

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
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
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('TUTOR.INI', NVD_INI)                        ! Configure INIManager to use INI file
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
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  DctInit()


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

