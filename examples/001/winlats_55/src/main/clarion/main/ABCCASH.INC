!ABCIncludeFile(CCASH)

  OMIT('EndOfInclude',_ABCYBERCASH_)
_ABCYBERCASH_  EQUATE(1)

Default_TimeOut         EQUATE(60)

!CyberCash Errors

PayNoError              EQUATE(0)
PayUnknownServiceError  EQUATE(1)
PayLoginError           EQUATE(2)
PayFailureError         EQUATE(3)
PayMoneyError           EQUATE(4)

!CyberCash Services Astrings

CCashService            ASTRING('CyberCash')

!Currency Astrings
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('CURRENCY.INC'),ONCE


PayMoney                GROUP,TYPE
szCurrency                CSTRING(16)
Amount                    REAL
szFormat                  CSTRING(32)
                        END

PayDate                 GROUP,TYPE
nYear                     SIGNED  ! i.e. 1999
nMonth                    SIGNED  ! i.e. 1 - 12
nDay                      SIGNED  ! i.e. 1 - 31 depending on month
nHour                     SIGNED  ! i.e. 1 - 24
nMins                     SIGNED  ! i.e. 1 - 60
nSecs                     SIGNED  ! i.e. 1 - 60
                        END


AccountQueue          QUEUE,TYPE
Currency                 ASTRING
ServiceID                LONG
Url                      ASTRING
Login                    ASTRING
Password                 ASTRING
Key                      ASTRING
HttpProxyPort            LONG
HttpProxyHost            ASTRING
AutoMark                 BYTE
AutoSettle               BYTE
EmulateHostMode          BYTE
                        END

WindowControls          QUEUE,TYPE
ID                       UNSIGNED ! Thread number.
AuthoriseButton          SIGNED
CaptureButton            SIGNED
SubmitButton             SIGNED
ReturnButton             SIGNED
CurrencyVariable         ANY
                        END

CyberCash               CLASS,TYPE,IMPLEMENTS(WindowComponent),MODULE('ABCCASH.CLW'),LINK('ABCCASH', _CCashLinkMode_),DLL(_CCashDllMode_)

Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(ASTRING Service,LONG Timeout = 0)   !,EXTENDS
Kill                      PROCEDURE
IsInitialised             PROCEDURE,BYTE

AddAccount                PROCEDURE(STRING Currency, STRING Url,STRING Login,STRING Password,STRING Key,LONG HttpProxyPort = 0,STRING HttpProxyHost, BYTE AutoMark=1, BYTE AutoSettle=0, BYTE EmulateHostMode=1)
AuthoriseCC               PROCEDURE(STRING Currency, STRING strOrderID,*? Money,STRING strCardNumber,STRING strCardExpiry,STRING strCardName,STRING strCardAddress,STRING strCardCity,STRING strCardZip,STRING strCardState,STRING strCardCountry),BYTE
CaptureCC                 PROCEDURE(STRING Currency, STRING OrderID, *? Money),BYTE
GetNamedValue             PROCEDURE(STRING strName),STRING
GetWindowControls         PROCEDURE(),BYTE,PRIVATE
PayGetNamedValue          PROCEDURE(*CSTRING szName),STRING
PayLogin                  PROCEDURE(*CSTRING szUrl,*CSTRING szLogin,*CSTRING szPassword,*CSTRING szKey,LONG HttpProxyPort = 0,*CSTRING szHttpProxyHost),BYTE
PayAuthoriseCC            PROCEDURE(BYTE Capture,*CSTRING szOrderID,PayMoney Money,*CSTRING szCardNumber,PayDate CardExpiry,*CSTRING szCardName,*CSTRING szCardAddress,*CSTRING szCardCity,*CSTRING szCardZip,*CSTRING szCardState,*CSTRING szCardCountry),BYTE
PayCaptureCC              PROCEDURE(*CSTRING szOrderID,PayMoney Money),BYTE
PayReturnCC               PROCEDURE(*CSTRING szOrderID,PayMoney Money),BYTE
PaySubmitCC               PROCEDURE(*CSTRING szOrderID,PayMoney Money),BYTE
ReturnCC                  PROCEDURE(STRING Currency, STRING strOrderID, *? Money),BYTE
SetCardDetails            PROCEDURE(BYTE Capture,*CSTRING szOrderID,PayMoney Money,*CSTRING szCardNumber,PayDate CardExpiry,*CSTRING szCardName,*CSTRING szCardAddress,*CSTRING szCardCity,*CSTRING szCardZip,*CSTRING szCardState,*CSTRING szCardCountry)
SetAccount                PROCEDURE(STRING Currency),BYTE
SetDebugLog               PROCEDURE(STRING LogFile)
SetWindowControls         PROCEDURE(SIGNED AuthoriseButton=0, SIGNED CaptureButton=0, SIGNED SubmitButton=0, SIGNED ReturnButton=0, <*? CurrencyVariable>)
SubmitCC                  PROCEDURE(STRING Currency, STRING OrderID, *? Money),BYTE

OnePassHostCapture        PROCEDURE(STRING Currency, STRING strOrderID,*? Money,STRING strCardNumber,STRING strCardExpiry,STRING strCardName,STRING strCardAddress,STRING strCardCity,STRING strCardZip,STRING strCardState,STRING strCardCountry),BYTE
PayGetLastError           PROCEDURE,STRING

Accounts                  &AccountQueue,PRIVATE
bInitialised              BYTE,PRIVATE
bDebug                    BYTE,PRIVATE
CaptureButton             SIGNED,PROTECTED
Controls                  &WindowControls,PRIVATE
CurrentServiceID          LONG,PRIVATE
Errorcode                 LONG,PRIVATE
ErrorText                 ASTRING,PRIVATE
Service                   ASTRING('CyberCash'),PRIVATE
ServiceID                 LONG,PRIVATE
SubmitButton              SIGNED,PROTECTED

TimeOut                   LONG(Default_TimeOut),PRIVATE

                        END


  EndOfInclude

