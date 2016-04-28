
  MEMBER

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABCCASH.INC'),ONCE

  MAP
    MODULE('CYBERCASH.LIB')
      PayGetNamedValue(SIGNED ServiceID, *CSTRING szName),LONG,C,RAW,NAME('PayGetNamedValue')
      PayLogin(*CSTRING szService, *CSTRING szURL, *CSTRING szHttpProxyHost, SIGNED HttpProxyPort, |
               SIGNED TimeOut, *CSTRING szLogin, *CSTRING szPassword, *CSTRING szKey, *SIGNED ServiceID), |
               LONG,C,RAW,NAME('PayLogin')
      PayAuthoriseCC(SIGNED ServiceID, BYTE bCapture, *CSTRING szOrderID, LONG lpMoney, *CSTRING |
               szCardNumber, LONG CardExpiry, *CSTRING szCardName, *CSTRING szCardAddress, |
               *CSTRING szCardCity, *CSTRING szCardZip, *CSTRING szCardState, *CSTRING szCardCountry), |
               LONG,C,RAW,NAME('PayAuthoriseCC')
      PayCaptureCC(SIGNED ServiceID, *CSTRING szOrderID, LONG lpMoney),LONG,C,RAW,NAME('PayCaptureCC')
      PayReturnCC(SIGNED ServiceID, *CSTRING szOrderID, LONG lpMoney),LONG,C,RAW,NAME('PayReturnCC')
      PaySubmitCC(SIGNED ServiceID, *CSTRING szOrderID, LONG lpMoney),LONG,C,RAW,NAME('PaySubmitCC')
      PayGetLastError(SIGNED ServiceID),LONG,C,NAME('PayGetLastError')
      COMPILE('***',DEBUG=1)
       PayDebug(*CSTRING szLogFileName),C,RAW,NAME('PayDebug')
      !***
    END
    MODULE('CLA.LIB')
      memcpy( long dest, long src, signed n ),long,proc,name('_memcpy')
      strcpy(*cstring,LONG),cstring,raw,name('_strcpy')
      strlen(LONG),ushort,raw,name('_strlen')
    END
  END

  PRAGMA ('link (CyberCash.lib)')


CyberCash.Construct                     PROCEDURE

  CODE


CyberCash.Destruct                      PROCEDURE

  CODE
    SELF.Kill


CyberCash.Init                          PROCEDURE(ASTRING Service, LONG Timeout)

  CODE
    SELF.Accounts &= NEW(AccountQueue)
    IF Service
      SELF.Service = Service.
    IF TimeOut
      SELF.TimeOut = TimeOut.
    SELF.Controls &= NEW(WindowControls)
    SELF.bInitialised = true


CyberCash.Kill                          PROCEDURE

  CODE
    FREE(SELF.Accounts)
    DISPOSE(SELF.Accounts)
    FREE(SELF.Controls)
    DISPOSE(SELF.Controls)
    SELF.bInitialised = false


CyberCash.IsInitialised                 PROCEDURE

  CODE
    RETURN SELF.bInitialised


CyberCash.AddAccount                 PROCEDURE(STRING Currency, STRING Url,STRING Login,STRING Password,STRING Key,LONG HttpProxyPort = 0,STRING HttpProxyHost, BYTE AutoMark=1, BYTE AutoSettle=0, BYTE EmulateHostMode=1)

  CODE
    ASSERT(~SELF.Accounts&=NULL,'CyberCash Class must be inited')
    SELF.Accounts.Currency = Currency
    GET(SELF.Accounts,SELF.Accounts.Currency)
    ASSERT(ERRORCODE(),'An Account for this Currency has already been Added')
    SELF.Accounts.Currency = Currency
    SELF.Accounts.ServiceID = 0 ! this will be set by the Login.
    SELF.Accounts.Url = URL
    SELF.Accounts.Login  = Login
    SELF.Accounts.Password  = Password
    SELF.Accounts.Key = Key
    SELF.Accounts.HttpProxyPort = HttpProxyPort
    SELF.Accounts.HttpProxyHost = HttpProxyHost
    SELF.Accounts.AutoMark = AutoMark
    SELF.Accounts.AutoSettle = AutoSettle
    SELF.Accounts.EmulateHostMode = EmulateHostMode
    ADD(SELF.Accounts)

CyberCash.AuthoriseCC                   PROCEDURE(STRING Currency, STRING strOrderID,*? Money,STRING strCardNumber,STRING strCardExpiry,STRING strCardName,STRING strCardAddress,STRING strCardCity,STRING strCardZip,STRING strCardState,STRING strCardCountry)

szOrderID         &CSTRING
szCardNumber      &CSTRING
szCardExpiry      &CSTRING
szCardName        &CSTRING
szCardAddress     &CSTRING
szCardCity        &CSTRING
szCardZip         &CSTRING
szCardState       &CSTRING
szCardCountry     &CSTRING

Capture           BYTE

CardMoney         GROUP(PayMoney).
CardDate          GROUP(PayDate).

locDate           ASTRING
bsub              LONG,AUTO

RetVal            LONG,AUTO
RVal              BYTE,AUTO

  CODE
      IF SELF.SetAccount(Currency) THEN RETURN Level:Notify.

      CardMoney.szCurrency = SELF.Accounts.Currency
      CardMoney.Amount = Money
      CLEAR(CardDate)
      locDate = strCardExpiry
      bsub = INSTRING('/',locDate,1,1) ! This call will accept strings in the format of mmyyyy or mm/yyyy
      IF bsub
         IF LEN(CLIP(locDate)) > 6
            CardDate.nYear = locDate[4:7]
         END
      ELSE
         IF LEN(CLIP(locDate)) > 5
            CardDate.nYear = locDate[3:6]
         END
      END
      IF LEN(CLIP(locDate)) > 1
         CardDate.nMonth = locDate[1:2]
      END

      ! for the moment capture will always be false?
      IF SELF.Accounts.EmulateHostMode AND ~SELF.Accounts.AutoMark
         Capture = 1 
      ELSE
         Capture = 0 
      END

      szOrderID &= NEW(CSTRING(LEN(CLIP(strOrderID)) + 1))
      szCardNumber &= NEW(CSTRING(LEN(CLIP(strCardNumber)) + 1))
      szCardExpiry &= NEW(CSTRING(LEN(CLIP(strCardExpiry)) + 1))
      szCardName &= NEW(CSTRING(LEN(CLIP(strCardName)) + 1))
      szCardAddress &= NEW(CSTRING(LEN(CLIP(strCardAddress)) + 1))
      szCardCity &= NEW(CSTRING(LEN(CLIP(strCardCity)) + 1))
      szCardZip &= NEW(CSTRING(LEN(CLIP(strCardZip)) + 1))
      szCardState &= NEW(CSTRING(LEN(CLIP(strCardState)) + 1))
      szCardCountry &= NEW(CSTRING(LEN(CLIP(strCardCountry)) + 1))

      szOrderID = strOrderID
      szCardNumber =  strCardNumber

      szCardExpiry =  strCardExpiry
      szCardName =  strCardName
      szCardAddress =  strCardAddress
      szCardCity =  strCardCity
      szCardZip = strCardZip
      szCardState =  strCardState
      szCardCountry = strCardCountry
      IF SELF.PayAuthoriseCC(Capture, szOrderID, CardMoney, szCardNumber, CardDate, szCardName, |
                                   szCardAddress, szCardCity, szCardZip, szCardState, szCardCountry)
         SELF.ErrorCode = RetVal
         RVal = Level:Notify
      ELSE
         RVal = Level:Benign
      END

      DISPOSE(szOrderID)
      DISPOSE(szCardNumber)
      DISPOSE(szCardExpiry)
      DISPOSE(szCardName)
      DISPOSE(szCardAddress)
      DISPOSE(szCardCity)
      DISPOSE(szCardZip)
      DISPOSE(szCardState)
      DISPOSE(szCardCountry)
      RETURN RVal

CyberCash.CaptureCC                  PROCEDURE(STRING Currency, STRING strOrderID, *? Money)

szOrderID         &CSTRING
CardMoney         GROUP(PayMoney).
RVal              BYTE,AUTO

  CODE
    IF SELF.SetAccount(Currency) THEN RETURN Level:Notify.

    szOrderID &= NEW(CSTRING(LEN(CLIP(strOrderID)) + 1))
    szOrderID = strOrderId
    CardMoney.szCurrency = SELF.Accounts.Currency
    CardMoney.Amount = Money

    IF SELF.PayCaptureCC(szOrderID, CardMoney)
       RVal = Level:Notify
    ELSE
       RVal = Level:Benign
    END
    DISPOSE(szOrderID)
    RETURN RVal


CyberCash.GetNamedValue                 PROCEDURE(STRING strName)

szName           &CSTRING
Value            ASTRING
  CODE

    szName &= NEW(CSTRING(LEN(CLIP(strName)) + 1))
    szName = strName
    Value = SELF.PayGetNamedValue(szName)
    DISPOSE(szName)
    RETURN Value

CyberCash.GetWindowControls                       PROCEDURE
  CODE
    IF ~(SELF.Controls &= NULL)
       SELF.Controls.ID = THREAD()
       GET(SELF.Controls,SELF.Controls.ID)
       IF ~ERRORCODE() THEN RETURN Level:Benign.
    END
    RETURN Level:Notify

CyberCash.PayGetNamedValue              PROCEDURE(*CSTRING szName)

ValueAddress LONG
Value        &CSTRING
StrCpyLen    USHORT
RetStr       ASTRING
  CODE
    ValueAddress = PayGetNamedValue(SELF.ServiceID, szName)
    IF ValueAddress
       StrCpyLen = strlen(ValueAddress)
       IF StrCpyLen
          Value &= NEW(CSTRING(strLen(ValueAddress)+1))
          StrCpyLen = strcpy(Value,ValueAddress)
          RetStr = Value
          DISPOSE(Value)
       END
    END
    RETURN RetStr


CyberCash.PayLogin                      PROCEDURE(*CSTRING szUrl, *CSTRING szLogin, |
                                                  *CSTRING szPassword, *CSTRING szKey, |
                                                  LONG HttpProxyPort, *CSTRING szHttpProxyHost)

szService         &CSTRING
RetVal            LONG,AUTO
RVal              BYTE,AUTO
ServiceID         LONG

  CODE
    SELF.ServiceID = 0
    szService &= NEW(CSTRING(LEN(CLIP(SELF.Service)) + 1))
    szService = CCashService
    RetVal = PayLogin(szService, szUrl, szHttpProxyHost, HttpProxyPort, SELF.TimeOut, szLogin, |
                      szPassword, szKey, ServiceID)
    IF RetVal = PayNoError
      SELF.ServiceID = ServiceID
      RVal = Level:Benign
    ELSE
      SELF.ErrorCode = RetVal
      RVal = Level:Notify
    END
    DISPOSE(szService)
    RETURN RVal


CyberCash.PayAuthoriseCC                PROCEDURE(BYTE Capture, *CSTRING szOrderID, PayMoney Money, *CSTRING |
                                                  szCardNumber, PayDate CardExpiry, *CSTRING szCardName, |
                                                  *CSTRING szCardAddress, *CSTRING szCardCity, *CSTRING szCardZip, |
                                                  *CSTRING szCardState, *CSTRING szCardCountry)

RetVal            LONG
RVal              BYTE,AUTO
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    RetVal = PayAuthoriseCC(SELF.ServiceID, Capture, szOrderID, ADDRESS(Money), szCardNumber, |
                            Address(CardExpiry), szCardName, szCardAddress, szCardCity, szCardZip, |
                            szCardState, szCardCountry)
    IF RetVal = PayNoError
       RVal = Level:Benign
    ELSE
       SELF.ErrorCode = RetVal
       RVal = Level:Notify
    END
    RETURN RetVal


CyberCash.PayCaptureCC                  PROCEDURE(*CSTRING szOrderID, PayMoney Money)

RetVal        LONG,AUTO
RVal          BYTE,AUTO
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    RetVal = PayCaptureCC(SELF.ServiceID, szOrderID, ADDRESS(Money))
    IF RetVal = PayNoError
       RVal = Level:Benign
    ELSE
       SELF.ErrorCode = RetVal
       RVal = Level:Notify
    END
    RETURN RVal


CyberCash.PayReturnCC                   PROCEDURE(*CSTRING szOrderID, PayMoney Money)

RetVal        LONG,AUTO
RVal          BYTE,AUTO
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    RetVal = PayReturnCC(SELF.ServiceID, szOrderID, ADDRESS(Money))
    IF RetVal = PayNoError
       RVal = Level:Benign
    ELSE
       SELF.ErrorCode = RetVal
       RVal = Level:Notify
    END
    RETURN RVal


CyberCash.PaySubmitCC                   PROCEDURE(*CSTRING szOrderID, PayMoney Money)

RetVal        LONG,AUTO
RVal          BYTE,AUTO
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    RetVal = PaySubmitCC(SELF.ServiceID, szOrderID, ADDRESS(Money))
    IF RetVal = PayNoError
       RVal = Level:Benign
    ELSE
       SELF.ErrorCode = RetVal
       RVal = Level:Notify
    END
    RETURN RVal

CyberCash.ReturnCC                   PROCEDURE(STRING Currency, STRING strOrderID, *? Money)

RetVal            LONG,AUTO
RVal              BYTE,AUTO
szOrderID         &CSTRING
CardMoney         GROUP(PayMoney).
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    IF SELF.SetAccount(Currency) THEN RETURN Level:Notify.

    szOrderID &= NEW(CSTRING(LEN(CLIP(strOrderID)) + 1))
    szOrderID = strOrderId
    CardMoney.szCurrency = SELF.Accounts.Currency
    CardMoney.Amount = Money

    IF SELF.PayReturnCC(szOrderID, CardMoney)
       RVal = Level:Notify
    ELSE
       RVal = Level:Benign
    END
    DISPOSE(szOrderID)
    RETURN RVal

CyberCash.SetCardDetails                PROCEDURE(BYTE Capture, *CSTRING szOrderID, |
                                                  PayMoney Money, *CSTRING szCardNumber, |
                                                  PayDate CardExpiry, *CSTRING szCardName, |
                                                  *CSTRING szCardAddress, *CSTRING szCardCity, |
                                                  *CSTRING szCardZip, *CSTRING szCardState, |
                                                  *CSTRING szCardCountry)

  CODE


CyberCash.SetAccount                    PROCEDURE(STRING Currency)

szURL             &CSTRING
szLogin           &CSTRING
szPassword        &CSTRING
szKey             &CSTRING
szHttpProxyHost   &CSTRING
RetVal            LONG,AUTO
RVal              BYTE,AUTO

  CODE
    RVal = Level:Benign
    IF NOT Currency ! DEFAULT to the first Registered Currency (should only be one).
       GET(SELF.Accounts,1)
       ASSERT(~ERRORCODE(),'No CyberCash accounts registered?')
    ELSE
       SELF.Accounts.Currency = CLIP(Currency)
       GET(SELF.Accounts,SELF.Accounts.Currency)
       ASSERT(~ERRORCODE(),'No Account for this currency?')
    END

    IF NOT SELF.CurrentServiceID <> SELF.Accounts.ServiceID
       szUrl &= NEW(CSTRING(LEN(CLIP(SELF.Accounts.Url)) + 1))
       szLogin &= NEW(CSTRING(LEN(CLIP(SELF.Accounts.Login)) + 1))
       szPassword &= NEW(CSTRING(LEN(CLIP(SELF.Accounts.Password)) + 1))
       szKey &= NEW(CSTRING(LEN(CLIP(SELF.Accounts.Key)) + 1))
       szHttpProxyHost &= NEW(CSTRING(LEN(CLIP(SELF.Accounts.HttpProxyHost)) + 1))

       szUrl = SELF.Accounts.Url ; szLogin = SELF.Accounts.Login
       szPassword = SELF.Accounts.Password ; szKey = SELF.Accounts.Key
       szHttpProxyHost = SELF.Accounts.HttpProxyHost
       IF SELF.PayLogin(szUrl, szLogin, szPassword, szKey, SELF.Accounts.HttpProxyPort, szHttpProxyHost)
          RVal = Level:Notify
       ELSE
          RVal = Level:Benign
          SELF.CurrentServiceID = SELF.ServiceID
          SELF.Accounts.ServiceID = SELF.ServiceID
          PUT(SELF.Accounts)
       END
       DISPOSE(szUrl)
       DISPOSE(szLogin)
       DISPOSE(szPassword)
       DISPOSE(szKey)
       DISPOSE(szHttpProxyHost)
    END
    RETURN RVal

CyberCash.SetDebugLog                PROCEDURE(STRING LogFile)

szLogFileName &CSTRING

  CODE
    szLogFileName &= NEW(CSTRING(LEN(CLIP(LogFile)) + 1))
    szLogFileName = CLIP(LogFile)
    COMPILE('***',DEBUG=1)
    PayDebug(szLogFileName)
    !***
    DISPOSE(szLogFileName)

CyberCash.SetWindowControls                    PROCEDURE(SIGNED AuthoriseButton=0, SIGNED CaptureButton=0, SIGNED SubmitButton=0, SIGNED ReturnButton=0, <*? CurrencyVariable>)

  CODE
  SELF.Controls.ID = THREAD()
  GET(SELF.Controls,SELF.Controls.ID)
  CLEAR(SELF.Controls)
  SELF.Controls.ID = THREAD()
  SELF.Controls.AuthoriseButton = AuthoriseButton
  SELF.Controls.CaptureButton = CaptureButton
  SELF.Controls.SubmitButton  = SubmitButton
  SELF.Controls.ReturnButton = ReturnButton
  IF NOT OMITTED(4)
     SELF.Controls.CurrencyVariable &= CurrencyVariable
  END
  IF ERRORCODE()
     ADD(SELF.Controls)
  ELSE
     PUT(SELF.Controls)
  END

CyberCash.SubmitCC                   PROCEDURE(STRING Currency, STRING strOrderID, *? Money)

szOrderID         &CSTRING
CardMoney         GROUP(PayMoney).
RVal              BYTE,AUTO
  CODE
    ASSERT(~RECORDS(SELF.Accounts)=0,'No Accounts Registered for CyberCash')
    IF SELF.SetAccount(Currency) THEN RETURN Level:Notify.

    szOrderID &= NEW(CSTRING(LEN(CLIP(strOrderID)) + 1))
    szOrderID = strOrderId
    CardMoney.szCurrency = SELF.Accounts.Currency
    CardMoney.Amount = Money

    IF SELF.PaySubmitCC(szOrderID, CardMoney)
       RVal = Level:Notify
    ELSE
       RVal = Level:Benign
    END
    DISPOSE(szOrderID)
    RETURN RVal

CyberCash.OnePassHostCapture            PROCEDURE(STRING Currency, STRING strOrderID,*? Money,STRING strCardNumber, |
                                                  STRING strCardExpiry,STRING strCardName,STRING strCardAddress,|
                                                  STRING strCardCity,STRING strCardZip,STRING strCardState,|
                                                  STRING strCardCountry)
RVal BYTE,AUTO
  CODE
    RVal = Level:Benign
    IF ~SELF.GetWindowControls()
     IF SELF.Controls &= NULL OR SELF.Controls.CurrencyVariable &= NULL
        GET(SELF.Accounts,1) ! Get the default account. (there should only be one).
     ELSE
        IF NOT SELF.Controls.CurrencyVariable
           GET(SELF.Accounts,1)
        ELSE
          SELF.Accounts.Currency = SELF.Controls.CurrencyVariable
          GET(SELF.Accounts,SELF.Accounts.Currency)
          IF ERRORCODE() ! Disable all CyberCash functionality
             GET(SELF.Accounts,1)
             RETURN Level:Notify
          END
       END
     END
    ELSE
     GET(SELF.Accounts,1)
    END
    SETCURSOR(CURSOR:Wait)
    IF SELF.AuthoriseCC(Currency, strOrderID, Money, strCardNumber, strCardExpiry, strCardName, strCardAddress, |
                        strCardCity, strCardZip, strCardState, strCardCountry)
       RETURN Level:Notify
    END
    SETCURSOR()
    IF ~(SELF.Accounts.AutoMark OR SELF.Accounts.EmulateHostMode)
      IF SELF.CaptureCC(Currency, strOrderID, Money)
         RETURN Level:Notify
      END
    END
    IF NOT SELF.Accounts.AutoSettle
      IF SELF.SubmitCC(Currency, strOrderID, Money)
         RETURN Level:Notify
      END
    END
    RETURN RVal


CyberCash.PayGetLastError               PROCEDURE
Value        &CSTRING
ValueAddress ULONG
StrCpyLen    USHORT
RetStr       ASTRING

  CODE
    ValueAddress = PayGetLastError(SELF.ServiceID)

    IF ValueAddress
       StrCpyLen = strLen(ValueAddress)
       IF StrCpyLen
        Value &= NEW(CSTRING(strLen(ValueAddress)+1))
        StrCpyLen = strcpy(Value,ValueAddress)
        RetStr = Value
        DISPOSE(Value)
       END
    END
    RETURN RetStr


CyberCash.WindowComponent.Kill         PROCEDURE
  CODE

CyberCash.WindowComponent.Reset        PROCEDURE(BYTE Force)
  CODE

CyberCash.WindowComponent.ResetRequired PROCEDURE
RVal BYTE
  CODE
    RETURN RVal

CyberCash.WindowComponent.SetAlerts    PROCEDURE
  CODE
CyberCash.WindowComponent.TakeEvent    PROCEDURE
RVal BYTE
  CODE
    RETURN RVal

CyberCash.WindowComponent.Update       PROCEDURE            ! Everything but the window!
  CODE

CyberCash.WindowComponent.UpdateWindow PROCEDURE
  CODE
  IF ~SELF.GetWindowControls()
     IF SELF.Controls.AuthoriseButton
        ENABLE(SELF.Controls.AuthoriseButton)
     END
     IF SELF.Controls.ReturnButton
        ENABLE(SELF.Controls.ReturnButton)
     END
     IF SELF.Controls.CurrencyVariable &= NULL
        GET(SELF.Accounts,1) ! Get the default account. (there should only be one).
     ELSE
        IF NOT SELF.Controls.CurrencyVariable
           GET(SELF.Accounts,1)
        ELSE
           SELF.Accounts.Currency = SELF.Controls.CurrencyVariable
           GET(SELF.Accounts,SELF.Accounts.Currency)
           IF ERRORCODE() ! Disable all CyberCash functionality
              GET(SELF.Accounts,1)
              IF SELF.Controls.AuthoriseButton
                 DISABLE(SELF.Controls.AuthoriseButton)
              END
              IF SELF.Controls.CaptureButton
                 DISABLE(SELF.Controls.CaptureButton)
              END
              IF SELF.Controls.SubmitButton
                 DISABLE(SELF.Controls.SubmitButton)
              END
              IF SELF.Controls.ReturnButton
                 DISABLE(SELF.Controls.ReturnButton)
              END
           END
        END
     END
     IF SELF.Controls.CaptureButton
        IF SELF.Accounts.AutoMark or SELF.Accounts.EmulateHostMode
           DISABLE(SELF.Controls.CaptureButton)
        ELSE
           ENABLE(SELF.Controls.CaptureButton)
        END
     END
     IF SELF.Controls.SubmitButton
        IF SELF.Accounts.AutoSettle
           DISABLE(SELF.Controls.SubmitButton)
        ELSE
           ENABLE(SELF.Controls.SubmitButton)
        END
     END
  END
