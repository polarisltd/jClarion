#TEMPLATE(CyberCash, 'CyberCash Credit Card Verification.'),FAMILY('ABC')
#HELP('ABCCASH.HLP')
#!
#!
#EXTENSION(CyberCashSettings,'Global CyberCash Settings.'),APPLICATION,HLP('~CyberCashSettings')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'CyberCashTI', 'CyberCashInt', %CyberCashClass)
  #DECLARE(%Currencies),MULTI
  #FREE(%Currencies)
  #EQUATE(%CurrencyFile,'Currency.inc')
  #OPEN(%CurrencyFile),READ
  #DECLARE(%ASCIIFileRecord)
  #LOOP
    #READ(%ASCIIFileRecord)
      #IF(SUB(%ASCIIFileRecord,1,1)<>' ' AND SUB(%ASCIIFileRecord,1,1)<>'#')
       #ADD(%Currencies,SUB(%ASCIIFileRecord,1,INSTRING(' ',%ASCIIFileRecord,1,1)))
      #ENDIF
      #IF(%ASCIIFileRecord = %EOF)
          #BREAK
      #ENDIF
  #ENDLOOP
  #CLOSE(%CurrencyFile),READ
#ENDPREPARE
  #BOXED('Default Addressbook prompts'),AT(0,0),WHERE(%False),HIDE
    #INSERT(%OOPHiddenPrompts(ABC))
  #ENDBOXED
  #SHEET,HSCROLL
   #TAB('&Settings')
    #BOXED('')
     #BOXED('')
      #IMAGE('cc_log.jpg')
      #BOXED(''),AT(50,30,125)
       #DISPLAY('CyberCash, CyberCoin, PayNow and')
       #DISPLAY(' the CyberCash logo are trademarks')
       #DISPLAY('             of CyberCash, Inc.')
       #DISPLAY('           1999 CyberCash, Inc.')
       #DISPLAY('             All rights reserved')
       #DISPLAY('')
       #DISPLAY('Legal Information:')
       #DISPLAY('Contact: info@cybercash.com.')
      #ENDBOXED
     #ENDBOXED
     #BOXED('Login Settings')
      #BUTTON('CyberCash Accounts'),MULTI(%CyberAccounts,'Account: ' & %ccCurrency),INLINE,HLP('~CyberCash_AcctSettings')
       #BOXED('Cybercash Account Setup')
        #PROMPT('Auto Mark?',CHECK),%ccMark,DEFAULT(1),AT(10)
        #PROMPT('Auto Settle?',CHECK),%ccSettle,DEFAULT(0),AT(70,13)
        #PROMPT('Emulate HostMode?',CHECK),%ccEmulateHostMode,DEFAULT(1),AT(10)
        #BOXED('')
         #DISPLAY('Host Mode essentially means when you authorise')
         #DISPLAY('a payment the same amount is automatically')
         #DISPLAY('Captured without having to use the Capture')
         #DISPLAY('button separately.')
        #ENDBOXED
       #ENDBOXED
       #PROMPT('Currency:',FROM(%Currencies)),%ccCurrency,REQ,DEFAULT('United_States')
       #PROMPT('Processor URL:',@s255),%ccProcessorURL,DEFAULT('http://cr.cybercash.com/cgi-bin/'),REQ
       #PROMPT('Proxy Host:',@s255),%ccProxyHost
       #ENABLE(%ccProxyHost)
        #PROMPT('Proxy Port:',@s255),%ccProxyPort
       #ENDENABLE
       #PROMPT('Timeout:',@n4),%ccTimeout,DEFAULT(60)
       #PROMPT('Login (CYBERCASH_ID):',@s255),%ccLogin,REQ,DEFAULT('hostauthcapture-50')
       #PROMPT('Password (HASH_SECRET):',@s255),%ccPassword,REQ,DEFAULT('5xf8cThEJTlCvButtRa9OiEmqUPKeH')
       #PROMPT('Key (MERCHANT_KEY):',@s255),%ccMerchantKey,REQ,DEFAULT('YSwLDyB6SuHuTs2UWYrUrPaxYdnNjt')
      #ENDBUTTON
     #ENDBOXED
    #ENDBOXED
   #ENDTAB
   #TAB('C&lasses'),HLP('~CyberCash_Classes'),AT(,,170)
    #BOXED('')
      #PROMPT('&CyberCash Class:',FROM(%pClassName)),%CyberCashClass,DEFAULT('CyberCash'),REQ
    #ENDBOXED
   #ENDTAB
   #BOXED('')
    #BUTTON('&CyberCash Class'),AT(,,170),HLP('~CyberCash_Class'),WHERE(%ProgramExtension<>'DLL')
      #WITH(%ClassItem,'CyberCashTI')
       #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
   #ENDBOXED
    #BUTTON('CyberCash Library Files'),AT(,,170)
      #BOXED('CyberCash Library Files')
        #INSERT(%AbcLibraryPrompts(ABC))
      #ENDBOXED
    #ENDBUTTON
  #ENDSHEET
#!-----------------------------------------------------------------------------------------
#! CLASS Related Template code below.
#!-----------------------------------------------------------------------------------------
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'CyberCashTI', 'CyberCashInt', %CyberCashClass)
  #EQUATE(%CyberCashObjectName, %ThisObjectName)
#ENDAT
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'CyberCashTI')
#ENDAT
#!
#AT (%BeforeGenerateApplication)
  #CALL(%AddCategory(ABC), 'CCASH')
  #CALL(%SetCategoryLocation(ABC), 'CCASH', 'CCash',)
#ENDAT
#!
#!
#AT(%CustomGlobalDeclarations)
 #IF(~%Target32)
  #ERROR('CyberCash integration is only available in 32bit!')
  #ABORT
 #ENDIF
 #DECLARE(%Accounts)
 #SET(%Accounts,%False)
 #FOR(%CyberAccounts)
  #SET(%Accounts,%True)
  #BREAK
 #ENDFOR
 #IF(~%Accounts)
  #ERROR('At least one CyberCash account is required!')
  #ABORT
 #ENDIF
#ENDAT
#!
#AT(%ProgramProcedures)
#IF(%ProgramExtension<>'DLL')
  #CALL(%GenerateVirtuals(ABC), 'CyberCashTI', 'Global Objects|Cyber Cash', '%CyberCashVirtuals(CyberCash)', %True)
#ENDIF
#!
#ENDAT
#!
#AT(%GlobalData)
#INSERT(%GenerateClass(ABC), 'CyberCashTI')
#ENDAT
#!
#! CyberCash Parent Calls.
#AT(%CyberCashMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!-----------------------------------------------------------------------------------------
#! CyberCash Template Code Below.
#!-----------------------------------------------------------------------------------------
#AT(%GlobaData)
#ENDAT
#AT(%ProgramSetup)
#IF(~%GlobalExternal)
%CyberCashObjectName.Init(CCashService, %ccTimeOut)
 #FOR(%CyberAccounts)
 #IF(~%ccProxyHost)
  #SET(%ccProxyPort,0)
 #ENDIF
%CyberCashObjectName.AddAccount(%ccCurrency, '%ccProcessorURL','%ccLogin','%ccPassword','%ccMerchantKey',%ccProxyPort,'%ccProxyHost',%ccMark,%ccSettle,%ccEmulateHostMode)
 #ENDFOR
#ENDIF
#ENDAT
#AT(%ProgramEnd)
#IF(~%GlobalExternal)
%CyberCashObjectName.Kill()
#ENDIF
#ENDAT
#!
#!
#!-----------------------------------------------------------------------------------------
#! GROUPS
#!-----------------------------------------------------------------------------------------
#GROUP(%CyberCashVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%CyberCashMethodDataSection,'CyberCash Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('CyberCashTI'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%CyberCashMethodCodeSection,'CyberCash Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('CyberCashTI'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%MethodEmbedPointValid, %MustBeVirtual = %True),AUTO
#DECLARE(%RVal)
#CALL(%MethodEmbedPointValid(ABC), %MustBeVirtual),%RVal
#RETURN(%RVal)
#!
#GROUP(%ParentCallValid),AUTO
#DECLARE(%RVal)
#CALL(%ParentCallValid(ABC)),%RVal
#RETURN(%RVal)
#!
#GROUP(%BaseClassToUse),AUTO
#DECLARE(%RVal)
#CALL(%BaseClassToUse(ABC)),%RVal
#RETURN(%RVal)
#!
#GROUP(%StripPling,%Incoming)
  #IF(SUB(%Incoming,1,1)='!')
    #RETURN(SUB(%Incoming,2))
  #ELSIF(SUB(%Incoming,1,1)='=')
    #RETURN('EVALUATE(' & %StripPling(SUB(%Incoming, 2)) & ')')
  #ELSE
    #RETURN( '''' & QUOTE(%Incoming) & '''' )
  #ENDIF
#GROUP(%GetEmbedTreeDesc,%EmbedType,%ProcedureSection,%AdditionalLevels=''),AUTO
  #DECLARE(%RVal)
  #CALL(%GetEmbedTreeDesc(ABC), %EmbedType, %ProcedureSection, %AdditionalLevels),%RVal
  #RETURN(%RVal)
#GROUP(%CheckStringVar,%Incoming)
  #IF(~%Incoming)
   #RETURN('''''')
  #ELSE
   #RETURN(%Incoming)
  #ENDIF
#!------------------------------------------------------------------------------------------------------
#EXTENSION(CapturePayment,'Authorise and capture payment.'),PROCEDURE,REQ(CyberCashSettings),HLP('~CapturePayment')
#!------------------------------------------------------------------------------------------------------
 #SHEET,HSCROLL
 #TAB('&Event Settings'),WHERE(UPPER(%ProcedureTemplate)<>'PROCESS')
  #BOXED('')
   #BOXED('Authorise')
    #PROMPT('Control:',CONTROL),%ccAuthoriseControl
   #ENDBOXED
   #ENABLE(~%ccEmulateHostMode)
    #BOXED('Capture')
      #PROMPT('Control:',CONTROL),%ccCaptureControl
    #ENDBOXED
   #ENDENABLE
   #BOXED('Submit')
     #PROMPT('Control:',CONTROL),%ccSubmitControl
   #ENDBOXED
   #BOXED('Return')
     #PROMPT('Control:',CONTROL),%ccReturnControl
   #ENDBOXED
  #ENDBOXED
 #ENDTAB
 #TAB('&Card Settings'),HLP('~CardSettings')
  #BOXED('Card Settings')
   #PROMPT('Currency:',FIELD),%ccCurrencyVariable
   #PROMPT('Card Number:',FIELD),%CardNumber
   #PROMPT('Expiry Date:',FIELD),%CardExpiryDate
   #PROMPT('Card Name:',FIELD),%CardName
   #PROMPT('Card Address:',FIELD),%CardAddress
   #PROMPT('Card City:',FIELD),%CardCity
   #PROMPT('Card Zip:',FIELD),%CardZip
   #PROMPT('Card State:',FIELD),%CardState
   #PROMPT('Card Country:',FIELD),%CardCountry
  #ENDBOXED
 #ENDTAB
 #TAB('&Authorisation Settings'),HLP('~AuthorisationSettings')
  #BOXED('')
   #PROMPT('Transaction Name:',@S255),%ccTransactionName,REQ
   #PROMPT('Authorisation Amount:',FIELD),%ccAuthorisationAmount,REQ
   #PROMPT('Invoice Number:',FIELD),%ccInvoiceNumber,REQ
   #PROMPT('Capture Amount:',FIELD),%ccCaptureAmount,REQ
   #PROMPT('Captured Total:',FIELD),%ccCapturedTotal,REQ
   #PROMPT('Authorisation Field:',FIELD),%ccAuthorisation,REQ
   #PROMPT('Processing Error Field:',FIELD),%ccErrorField
   #PROMPT('Date Billed Field:',FIELD),%ccDateBilled
  #ENDBOXED
  #BOXED('Debug')
   #PROMPT('Debug LogFile:',SAVEDIALOG('Pick Log File','Log Files|*.log')),%ccLogFile
  #ENDBOXED
 #ENDTAB
 #ENDSHEET
#AT(%ControlEventHandling,%ccAuthoriseControl,'Accepted')
 #IF(%ccLogFile)
 %CyberCashObjectName.SetDebugLog('%ccLogFile')
 #END
 IF %CyberCashObjectName.AuthoriseCC(%(%CheckStringVar(%ccCurrencyVariable)), '%ccTransactionName' & %ccInvoiceNumber,%ccAuthorisationAmount, |
                                     %CardNumber, %CardExpiryDate,%CardName,%CardAddress,%CardCity,%CardZip,%CardState,   |
                                     %CardCountry)
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.PayGetLastError()
    DISPLAY(%ccErrorField)
 ELSE
    %ccErrorField = %CyberCashObjectName.GetNamedValue('aux-msg')
    DISPLAY(%ccErrorField)
  #ENDIF
 END
 #!
#ENDAT
#AT(%ControlEventHandling,%ccCaptureControl,'Accepted')
 #IF(%ccLogFile)
 %CyberCashObjectName.SetDebugLog('%ccLogFile')
 #END
 IF %CyberCashObjectName.CaptureCC(%(%CheckStringVar(%ccCurrencyVariable)), '%ccTransactionName' & %ccInvoiceNumber, %ccCaptureAmount)
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.PayGetLastError()
    DISPLAY(%ccErrorField)
  #ENDIF
 ELSE
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.GetNamedValue('aux-msg')
    DISPLAY(%ccErrorField)
  #ENDIF
    %ccCapturedTotal += %ccCaptureAmount
    DISPLAY()
 END
#ENDAT
#AT(%ControlEventHandling,%ccSubmitControl,'Accepted')
 #IF(%ccLogFile)
 %CyberCashObjectName.SetDebugLog('%ccLogFile')
 #END
 IF %CyberCashObjectName.SubmitCC(%(%CheckStringVar(%ccCurrencyVariable)), '%ccTransactionName' & %ccInvoiceNumber, %ccCaptureAmount)
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.PayGetLastError()
    DISPLAY(%ccErrorField)
  #ENDIF
 ELSE
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.GetNamedValue('aux-msg')
  #ENDIF
    %ccCapturedTotal += %ccCaptureAmount
    DISPLAY()
 END
#ENDAT
#AT(%ControlEventHandling,%ccReturnControl,'Accepted')
 #IF(%ccLogFile)
 %CyberCashObjectName.SetDebugLog('%ccLogFile')
 #END
 IF %CyberCashObjectName.SubmitCC(%(%CheckStringVar(%ccCurrencyVariable)), '%ccTransactionName' & %ccInvoiceNumber, %ccCapturedTotal)
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.PayGetLastError()
    DISPLAY(%ccErrorField)
 ELSE
    %ccErrorField = %CyberCashObjectName.GetNamedValue('aux-msg')
    DISPLAY(%ccErrorField)
  #ENDIF
 END
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(6000)
#IF(UPPER(%ProcedureTemplate)<>'PROCESS')
%CyberCashObjectName.SetWindowControls(%ccAuthoriseControl, %ccCaptureControl,%ccSubmitControl, %ccReturnControl, %ccCurrencyVariable)
#ENDIF
SELF.AddItem(%CyberCashObjectName.WindowComponent)
#ENDAT
#!
#AT(%ProcessManagerMethodCodeSection,'TakeRecord','(),BYTE'),WHERE(UPPER(%ProcedureTemplate)='PROCESS'),PRIORITY(4500)
 IF %CyberCashObjectName.OnePassHostCapture(%(%CheckStringVar(%ccCurrencyVariable)), '%ccTransactionName' & %ccInvoiceNumber,%ccAuthorisationAmount, |
                                     %CardNumber, %CardExpiryDate,%CardName,%CardAddress,%CardCity,%CardZip,%CardState,   |
                                     %CardCountry)
  #IF(%ccErrorField)
    %ccErrorField = %CyberCashObjectName.PayGetLastError()
    DISPLAY(%ccErrorField)
 ELSE
    %ccErrorField = %CyberCashObjectName.GetNamedValue('aux-msg')
    %ccCapturedTotal += %ccCaptureAmount
    %ccDateBilled = TODAY()
    DISPLAY(%ccErrorField)
  #ENDIF
 END
#ENDAT
#!
