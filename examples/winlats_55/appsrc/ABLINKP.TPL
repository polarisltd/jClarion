#TEMPLATE(LinkPoint, 'LinkPoint Templates (Credit Card Processing).'),FAMILY('ABC')
#HELP('ABLinkP.HLP')
#!
#!
#EXTENSION(LinkPointGlobal,'Global LinkPoint Prototypes and settings.'),APPLICATION,HLP('~LinkPointGlobal')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'LinkPoint', 'LinkPoint', %LinkPointClass)
  #CALL(%SetClassDefaults(ABC), 'LPErrors', 'LPErrors', %LPErrorsClass)
#ENDPREPARE
  #BOXED('Default LinkPoint prompts'),AT(0,0),WHERE(%False),HIDE
    #INSERT(%OOPHiddenPrompts(ABC))
  #ENDBOXED
  #SHEET,HSCROLL
    #TAB('LinkPoint Settings')
     #BOXED('© 2000, ClearCommerce Corp. All rights reserved'),AT(,,,72)
      #IMAGE('clearc.jpg'),AT(50,35)
     #ENDBOXED
     #BOXED(''),AT(,89)
      #PROMPT('Config File:',@s255),%LPConfigFile,REQ
      #PROMPT('Host:',@s255),%LPHost,REQ
      #PROMPT('Port:',@s255),%LPPort,DEFAULT('1139')
      #PROMPT('Key:',@s255),%LPKey,REQ
      #PROMPT('Mode:',DROP('Test|Live')),%LPMode,DEFAULT('Test')
     #ENDBOXED
    #ENDTAB
    #TAB('C&lasses'),HLP('~DocumentHandlingGlobal_Classes'),AT(,,170)
     #BOXED('')
      #BUTTON('Global Document Handling &Object Names'),AT(,,170)
       #PROMPT('&Address Manager:',FROM(%pClassName)),%LinkPointClass,DEFAULT('LinkPointClass'),REQ
       #PROMPT('&LinkPoint Error Manager:',FROM(%pClassName)),%LPErrorsClass,DEFAULT('ErrorClass'),REQ
      #ENDBUTTON
     #ENDBOXED
     #BOXED('')
      #BUTTON('Global &LinkPoint Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'LinkPoint')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
     #ENDBOXED
     #BOXED('')
      #BUTTON('&LinkPoint Error Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'LPErrors')
         #INSERT(%GlobalClassPrompts(ABC))
        #END
      #ENDBUTTON
     #ENDBOXED
    #ENDTAB
  #ENDSHEET
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'LinkPoint', 'LinkPoint', %LinkPointClass)
  #EQUATE(%LinkPointObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'LPErrors', 'LPErrors', %LPErrorsClass)
  #EQUATE(%LPErrorsObjectName, %ThisObjectName)
#ENDAT
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'LinkPoint')
  #CALL(%AddObjectList(ABC), 'LPErrors')
#ENDAT
#!
#AT(%CustomGlobalDeclarations)
 #IF(~%Target32)
  #ERROR('LinkPoint Card Processing is only available in 32bit!')
  #ABORT
 #ENDIF
#ENDAT
#!
#AT (%BeforeGenerateApplication)
  #CALL(%AddCategory(ABC), 'LinkPoint')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'LinkPoint', 'LinkPoint', '')
  #!
#END
#!
#!
#AT(%ProgramProcedures)
#IF(%ProgramExtension<>'DLL')
  #CALL(%GenerateVirtuals(ABC), 'LinkPoint', 'Global Objects|LinkPoint Objects|LinkPoint', '%LinkPointVirtuals(LinkPoint)', %True)
  #CALL(%GenerateVirtuals(ABC), 'LPErrors', 'Global Objects|LinkPoint Objects|Error Manager', '%LPErrorsVirtuals(LinkPoint)', %True)
#ENDIF
#ENDAT
#!
#AT(%GlobalData)
#INSERT(%GenerateClass(ABC), 'LinkPoint')
#INSERT(%GenerateClass(ABC), 'LPErrors')
#ENDAT
#!
#! Global LinkPoint Parent Calls.
#AT(%LinkPointMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Global LinkPoint Error Parent Calls.
#AT(%LPErrorsMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#AT(%ProgramSetup)
#IF(~%GlobalExternal)
%LPErrorsObjectName.Init()
%LinkPointObjectName.Init(%LPErrorsObjectName)
%LinkPointObjectName.Req.ConfigFile = %(%StripPling(%LPConfigFile))
%LinkPointObjectName.Req.Host = %(%StripPling(%LPHost))
%LinkPointObjectName.Req.Port = %LPPort
%LinkPointObjectName.Req.KeyField = %(%StripPling(%LPKey))
 #IF(%LPMode='Test')
%LinkPointObjectName.Result = Result_Good
 #ENDIF
 #IF(%LPMode='Live')
%LinkPointObjectName.Result = Result_Live
 #ENDIF
#ENDIF
#ENDAT
#!
#AT(%ProgramEnd)
#IF(~%GlobalExternal)
%LinkPointObjectName.Kill()
%LPErrorsObjectName.Kill()
#ENDIF
#ENDAT
#!
#AT(%LPErrorsMethodCodeSection,'Init','()'),LAST
SELF.AddErrors(LinkPointErrors)
SELF.HistoryThreshold = 1000
SELF.HistoryViewLevel = Level:Notify
SELF.HistoryResetOnView = True
SELF.Silent = True
#ENDAT
#!
#AT(%LPErrorsMethodCodeSection,'ViewHistory','()'),LAST
IF SELF.HistoryResetOnView
 FREE(SELF.History)
END
#ENDAT
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
#GROUP(%StripPling,%Incoming),AUTO
#DECLARE(%RVal)
#CALL(%StripPling(ABC), %Incoming),%Rval
#RETURN(%RVal)
#!
#!
#GROUP(%LinkPointVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%LinkPointMethodDataSection,'LinkPoint Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('LinkPoint'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%LinkPointMethodCodeSection,'LinkPoint Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('LinkPoint'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%LPErrorsVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%LPErrorsMethodDataSection,'LinkPoint Errors Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('LPErrors'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%LPErrorsMethodCodeSection,'LinkPoint Errors Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('LPErrors'))),TREE(%TreeText & %CodeText)
#!
#!
#EXTENSION(ProcessOrder,'Order Process Extension'),PROCEDURE,REQ(LinkPointGlobal),HLP('~ProcessOrder')
 #RESTRICT
  #IF(UPPER(%ProcedureTemplate)<>'PROCESS')
   #REJECT
  #ENDIF
  #ACCEPT
 #ENDRESTRICT
 #PREPARE
  #DECLARE(%cChargeType),MULTI
  #ADD(%cChargeType,'Chargetype_Sale')
  #ADD(%cChargeType,'Chargetype_Preauth')
  #ADD(%cChargeType,'Chargetype_Postauth')
  #ADD(%cChargeType,'Chargetype_Credit')
 #ENDPREPARE
 #BOXED('Processing Settings')
  #BOXED('Configuration Settings')
   #BUTTON('Override Global Settings?'),AT(,,165)
    #PROMPT('Configuration File:',@s255),%LPLocalConfigFile
    #PROMPT('Host:',@S255),%LPLocalHost
    #PROMPT('Port:',@s255),%LPLocalPort
    #PROMPT('Key:',@s255),%LPLocalKey
   #ENDBUTTON
  #ENDBOXED
  #SHEET,HSCROLL,AT(10,,180)
  #TAB('Order Settings'),HLP('~OrderSettings')
   #BOXED('')
    #PROMPT('IP Address:',FIELD),%LPIpAddress
    #PROMPT('Unique Order ID:',FIELD),%LPOrderID,REQ
    #PROMPT('Charge Type:',COMBO(%cChargeType)),%LPChargeType,DEFAULT('Chargetype_Sale')
    #PROMPT('UserID:',FIELD),%LPUserID
    #PROMPT('Cardnumber:',FIELD),%LPCardNumber,REQ
    #PROMPT('Expiry month:',FIELD),%LPExpMonth,REQ
    #PROMPT('Expiry year:',FIELD),%LPExpYear,REQ
    #PROMPT('Address number:',FIELD),%LPAddrNum
    #PROMPT('eMail address:',FIELD),%LPeMail
    #PROMPT('Order Total:',FIELD),%LPOrderTotal,REQ
    #PROMPT('Phone:',FIELD),%LPPhone
    #PROMPT('Fax:',FIELD),%LPFax
    #BOXED('Comments')
     #PROMPT('Comments',TEXT),%LPComments
    #ENDBOXED
   #ENDBOXED
  #ENDTAB
  #TAB('Billing Details'),HLP('~BillingDetails')
    #BOXED('')
     #PROMPT('Name:',FIELD),%LPBName
     #PROMPT('Company:',FIELD),%LPBCompany
     #PROMPT('Address:',FIELD),%LPBAddress
     #PROMPT('City:',FIELD),%LPBCity
     #PROMPT('State:',FIELD),%LPBState
     #PROMPT('Zip:',FIELD),%LPBZip
     #PROMPT('Country:',FIELD),%LPBCountry
    #ENDBOXED
  #ENDTAB
  #TAB('Item Details'),HLP('~ItemDetails')
   #BOXED('')
    #PROMPT('Item ID:',FIELD),%LPItemID
    #PROMPT('Description:',FIELD),%LPItemDescription
    #PROMPT('Price:',FIELD),%LPItemPrice
    #PROMPT('Quantity:',FIELD),%LPItemQuantity
   #ENDBOXED
  #ENDTAB
  #TAB('Tax Details'),HLP('~TaxDetails')
   #BOXED('')
    #PROMPT('State:',FIELD),%LPTaxState
    #PROMPT('Zip:',FIELD),%LPTaxZip
   #ENDBOXED
  #ENDTAB
  #ENDSHEET
 #ENDBOXED
#AT(%LocalDataAfterClasses)
#FIX(%Field,%LPOrderID)
LinkP:%FieldID %FieldType
LinkP:ProcessOrder BYTE
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE')
#FIND(%Field,%LPOrderID)
CLEAR(LinkP:%FieldID)
#ENDAT
#!
#AT(%ProcessManagerMethodCodeSection,'TakeRecord','(),BYTE')
#FIND(%Field,%LPOrderID)
IF %LPOrderTotal ! Don't bill zero total orders. Preferably make sure the Process excludes them.
 IF LinkP:%FieldID <> %Field ! Initialise order settings.
    IF LinkP:ProcessOrder
       Do LinkPointProcess
    END
    Do InitLinkPoint
    LinkP:%FieldID = %Field
 END
  #IF(%LPItemID OR %LPItemDescription)
 %LinkPointObjectName.AddItem(%LPItemID,%LPItemDescription,%LPItemPrice,%LPItemQuantity)
 #ENDIF
 LinkP:ProcessOrder = True
END
#ENDAT
#AT(%ProcessManagerMethodCodeSection,'Kill','()')
#FIND(%FIELD,%LPOrderID)
IF LinkP:ProcessOrder
   Do LinkPointProcess
END
%LPErrorsObjectName.ViewHistory
#ENDAT
#AT(%ProcedureRoutines)
#FIND(%FIELD,%LPOrderID)
LinkPointProcess ROUTINE ! Process Order Routine (Credit Card Processing).
  IF %LinkPointObjectName.ProcessOrder().
  LinkP:ProcessOrder = False
  EXIT

InitLinkPoint ROUTINE    ! Initialise LinkPoint Order Settings
    #IF(%LPLocalConfigFile)
  %LinkPointObjectName.Req.ConfigFile = %(%StripPling(%LPLocalConfigFile))
    #ELSE
  %LinkPointObjectName.Req.ConfigFile = %(%StripPling(%LPConfigFile))
    #ENDIF
    #IF(%LPLocalHost)
  %LinkPointObjectName.Req.Host = %(%StripPling(%LPLocalHost))
    #ELSE
  %LinkPointObjectName.Req.Host = %(%StripPling(%LPHost))
    #ENDIF
    #IF(%LPLocalPort)
  %LinkPointObjectName.Req.Port = %(%StripPling(%LPLocalPort))
    #ELSE
  %LinkPointObjectName.Req.Port = %(%StripPling(%LPPort))
    #ENDIF
    #IF(%LPLocalKey)
  %LinkPointObjectName.Req.KeyField = %(%StripPling(%LPLocalKey))
    #ELSE
  %LinkPointObjectName.Req.KeyField = %(%StripPling(%LPKey))
    #ENDIF
  %LinkPointObjectName.ChargeType = %(%StripPling(%LPChargeType))
  %LinkPointObjectName.Order.oid = %LPOrderID
    #IF(%LPUserID)
  %LinkPointObjectName.Order.Userid = %LPUserID
    #END
    #IF(%LPIpAddress)
  %LinkPointObjectName.Order.Ip = %LPIpAddress
    #END
    #IF(%LPBName)
  %LinkPointObjectName.Order.Bname = %LPBName
    #ENDIF
    #IF(%LPBCompany)
  %LinkPointObjectName.Order.Bcompany = %LPBCompany
    #ENDIF
    #IF(%LPBAddress)
  %LinkPointObjectName.Order.Baddr1 = %LPBAddress
    #ENDIF
    #IF(%LPBCity)
  %LinkPointObjectName.Order.Bcity = %LPBCity
    #ENDIF
    #IF(%LPBState)
  %LinkPointObjectName.Order.Bstate = %LPBState
    #ENDIF
    #IF(%LPBZip)
  %LinkPointObjectName.Order.Bzip = %LPBZip
    #ENDIF
    #IF(%LPBCountry)
  %LinkPointObjectName.Order.Bcountry = %LPBCountry
    #ENDIF
    #IF(%LPPhone)
  %LinkPointObjectName.Order.Phone = %LPPhone
    #ENDIF
    #IF(%LPFax)
  %LinkPointObjectName.Order.Fax = %LPFax
    #ENDIF
    #IF(%LPComments)
  %LinkPointObjectName.Order.Comments = %(%StripPling(%LPComments))
    #ENDIF
    #IF(%LPCardNumber)
  %LinkPointObjectName.Order.Cardnumber = %LPCardNumber
    #ENDIF
    #IF(%LPExpMonth)
  %LinkPointObjectName.Order.Expmonth = %LPExpMonth
    #ENDIF
    #IF(%LPExpYear)
  %LinkPointObjectName.Order.Expyear = %LPExpYear
    #ENDIF
    #IF(%LPAddrNum)
  %LinkPointObjectName.Order.Addrnum = %LPAddrNum
    #ENDIF
    #IF(%LPEMail)
  %LinkPointObjectName.Order.Email = %LPEMail
    #ENDIF
    #IF(%LPTaxState)
  %LinkPointObjectName.Tax.State = %LPTaxState
    #ENDIF
    #IF(%LPTaxZip)
  %LinkPointObjectName.Tax.Zip = %LPTaxZip
    #ENDIF
  %LinkPointObjectName.Order.ChargeTotal = %LPOrderTotal
  EXIT
#ENDAT
