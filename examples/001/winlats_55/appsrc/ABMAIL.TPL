#TEMPLATE(Messaging, 'Messaging Templates (eMail & News).'),FAMILY('ABC')
#HELP('Messaging.HLP')
#!
#!
#EXTENSION(GlobalDocumentHandling,'Global Document Handling, Addressbook and Transport Settings.'),APPLICATION,HLP('~GlobalDocumentHandling')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'GABook', 'GlobalAddresses', %AdrMgrClass)
  #CALL(%SetClassDefaults(ABC), 'ABookVisual', 'AddressBook', %AddressBookClass)
  #CALL(%SetClassDefaults(ABC), 'AVisualUpdate', 'AddressBookUpd', %ABookUpdClass)
  #CALL(%SetClassDefaults(ABC), 'SMTP', 'eMail', %SMTPClass)
  #CALL(%SetClassDefaults(ABC), 'NNTP', 'News', %NNTPClass)
  #CALL(%SetClassDefaults(ABC), 'Base64', 'Base64', %Base64Class)
  #CALL(%SetClassDefaults(ABC), 'QuotedPrintable', 'QuotedPrintable', %QuotedPrintableClass)
  #CALL(%SetClassDefaults(ABC), 'PlainEncoder', 'PlainEncoder', %NoneFMClass)
  #CALL(%SetClassDefaults(ABC), 'DbMessage', 'DbMessage', %DbMessageClass)
  #CALL(%SetClassDefaults(ABC), 'DbAddresses', 'DbAddresses', %DbAddressClass)
  #CALL(%SetClassDefaults(ABC), 'SilentErrors', 'SilentErrors', %SilentErrorsClass)
  #DECLARE(%TplInstance)
  #CALL(%FindGlobalTemplateInstance(ABC), 'DbAuditing(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%DbAuditingSupport,%True)
  #ELSE
    #SET(%DbAuditingSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'FileUserTags(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%FileUserTagsSupport,%True)
  #ELSE
    #SET(%FileUserTagsSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'GenericSkeletonClasses(Skeletons)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%GenericSkeletonsSupport,%True)
  #ELSE
    #SET(%GenericSkeletonsSupport,%False)
  #ENDIF
  #IF(%GenericSkeletonsSupport AND %FileUserTagsSupport)
    #SET(%DocumentMergingSupport,%True)
  #ELSE
    #SET(%DocumentMergingSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'WebGuard(Web)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%WebGuardSupport,%True)
  #ELSE
    #SET(%WebGuardSupport,%False)
  #ENDIF
  #CALL(%LoadComboValues)
#ENDPREPARE
  #BOXED('Default Addressbook prompts'),AT(0,0),WHERE(%False),HIDE
    #INSERT(%OOPHiddenPrompts(ABC))
  #ENDBOXED
  #SHEET,HSCROLL
    #TAB('SMTP Settings')
     #BOXED('')
      #BUTTON('Sender Settings'),AT(,,173)
       #PROMPT('Sender address:',@s255),%SMTPSender,REQ
       #PROMPT('From Header address:',@s255),%SMTPFrom
       #PROMPT('From Header Name:',@s255),%SMTPFromName
      #ENDBUTTON
      #PROMPT('Sender Domain:',@s255),%SMTPSenderDomain
      #PROMPT('Default SMTP Server:',@s255),%SMTPDefaultServer
      #PROMPT('Default SMTP Port:',@s255),%SMTPDefaultPort,Default('25')
      #BOXED('Reply To List')
       #BOXED('')
        #BUTTON('Reply To List'),MULTI(%SMTPReplyTo,'"' & %SMTPReplyToName & '" <' & %SMTPReplyToAddress & '>'),INLINE
         #BOXED('')
          #PROMPT('ReplyTo Address:',@s255),%SMTPReplyToAddress
          #PROMPT('ReplyTo Name:',@s255),%SMTPReplyToName
         #ENDBOXED
        #ENDBUTTON
       #ENDBOXED
      #ENDBOXED
     #BUTTON('User Defined Headers'),MULTI(%SMTPHeaders,'X-' & %SMTPHeader & ': ' & %SMTPHeaderValue),AT(,,173)
      #PROMPT('Header:',@s255),%SMTPHeader,REQ,DEFAULT('Mailer')
      #PROMPT('Value:',@s255),%SMTPHeaderValue,REQ
     #ENDBUTTON
     #ENDBOXED
    #ENDTAB
    #TAB('NNTP Settings')
     #BOXED('')
      #PROMPT('From Header address:',@s255),%NNTPFrom
      #PROMPT('From Header Name:',@s255),%NNTPFromName
      #PROMPT('Default NNTP Server:',@s255),%NNTPDefaultServer
      #PROMPT('Default NNTP Port:',@s255),%NNTPDefaultPort,Default('119')
      #PROMPT('Username:',@s30),%NNTPUser
      #PROMPT('Password:',@s30),%NNTPPassword
      #BUTTON('User Defined Headers'),MULTI(%NNTPHeaders,'X-' & %NNTPHeader & ': ' & %NNTPHeaderValue),AT(,,173)
       #PROMPT('Header:',@s255),%NNTPHeader,REQ,DEFAULT('Mailer')
       #PROMPT('Value:',@s255),%NNTPHeaderValue,REQ
      #ENDBUTTON
     #ENDBOXED
    #ENDTAB
    #TAB('Global &Address Settings')
     #BOXED('')
      #PROMPT('Procedure to load addressbook:',PROCEDURE),%AdrLoadProc
      #BOXED('')
       #DISPLAY('Typically a process procedure with the')
       #DISPLAY('LoadAddresses Procedure Extension populated')
      #ENDBOXED
      #PROMPT('Save and Restore?',CHECK),%AdrSaveRestore,DEFAULT(0)
      #BOXED('')
       #DISPLAY('To Save and Restore the global addressbook')
       #DISPLAY('to the program INI file.')
      #ENDBOXED
     #ENDBOXED
    #ENDTAB
    #TAB('Other Template Support Info')
     #BOXED('')
      #ENABLE(%False)
       #PROMPT('DbAuditing Support?',CHECK),%DbAuditingSupport,AT(10)
       #PROMPT('File UserTags Support?',CHECK),%FileUserTagsSupport,AT(10)
       #PROMPT('Generic Skeletons Support?',CHECK),%GenericSkeletonsSupport,AT(10)
       #PROMPT('Document Merging Support?',CHECK),%DocumentMergingSupport,AT(10)
       #PROMPT('Web Guard Support included?',CHECK),%WebGuardSupport,AT(10)
      #ENDENABLE
      #BOXED('Document Merging Support'),WHERE(~%DocumentMergingSupport)
       #DISPLAY('Document Merging Support within Messaging is only')
       #DISPLAY('supported when the Generic Skeleton Classes and')
       #DISPLAY('and FileUserTags global extensions are populated.')
      #ENDBOXED
     #ENDBOXED
    #ENDTAB
    #TAB('Web Guard Support')
     #BOXED(''),WHERE(%WebGuardSupport)
      #PROMPT('eMail Reminder on Invalid Logon Password?',CHECK),%SendInvalidPasswordMessage,AT(10)
      #ENABLE(%SendInvalidPasswordMessage)
        #PROMPT('Subject:',@s200),%GuardSubject,REQ
        #PROMPT('Message Body:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|')),%GuardBody
        #PROMPT('Content Type:',DROP('Html|Plain Text')),%GuardContent,DEFAULT('Html')
        #BUTTON('Recipients'),AT(,,160)
         #PROMPT('Address:',@s150),%GuardRecipientAddress,REQ
         #PROMPT('Name:',@s150),%GuardRecipientName
         #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%GuardRecipClass
        #ENDBUTTON
      #ENDENABLE
     #PROMPT('eMail Administrator on Invalid Logins?',CHECK),%SendInvalidLogonMessage,AT(10)
     #ENABLE(%SendInvalidLogonMessage)
       #PROMPT('Subject:',@s200),%LogonSubject,REQ
       #PROMPT('Message Body:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|')),%LogonBody
       #PROMPT('Content Type:',DROP('Html|Plain Text')),%LogonContent,DEFAULT('Html')
       #BUTTON('Administrator eMail Details'),AT(,,160)
        #PROMPT('Address:',@s150),%LogonRecipientAddress,REQ
        #PROMPT('Name:',@s150),%LogonRecipientName
        #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%LogonRecipClass
       #ENDBUTTON
     #ENDENABLE
     #ENDBOXED
     #BOXED(''),WHERE(~%WebGuardSupport),AT(,14)
      #DISPLAY('Web Guard support will only be enabled when the')
      #DISPLAY('Web and WebGuard global extensions are populated')
     #ENDBOXED
    #ENDTAB
    #TAB('C&lasses'),HLP('~DocumentHandlingGlobal_Classes'),AT(,,170)
     #BOXED('')
      #BUTTON('Global Document Handling &Object Names'),AT(,,170)
       #PROMPT('&Address Manager:',FROM(%pClassName)),%AdrMgrClass,DEFAULT('AdrMgr'),REQ
       #PROMPT('Address&Book Manager:',FROM(%pClassName)),%AddressBookClass,DEFAULT('AddressVisual'),REQ
       #PROMPT('Address &Update Manager:',FROM(%pClassName)),%ABookUpdClass,DEFAULT('AdrVisualUpdate'),REQ
       #PROMPT('SMTP Transport:',FROM(%pClassName)),%SMTPClass,DEFAULT('SMTPTransport'),REQ
       #PROMPT('NNTP Transport:',FROM(%pClassName)),%NNTPClass,DEFAULT('NNTPTransport'),REQ
       #PROMPT('Base64 Encoder:',FROM(%pClassName)),%Base64Class,DEFAULT('Base64FileMgr'),REQ
       #PROMPT('Quoted Prinatable Encoder:',FROM(%pClassName)),%QuotedPrintableClass,DEFAULT('QuotedPrintFM')
       #PROMPT('Plain Encoder:',FROM(%pClassName)),%NoneFMClass,DEFAULT('NoneFM'),REQ
       #PROMPT('&Document Manager:',FROM(%pClassName)),%DbMessageClass,DEFAULT('DocumentHandler'),REQ
       #PROMPT('&Address Manager:',FROM(%pClassName)),%DbAddressClass,DEFAULT('AdrMgr'),REQ
       #PROMPT('&Silent Error Manager:',FROM(%pClassName)),%SilentErrorsClass,DEFAULT('ErrorClass'),REQ
      #ENDBUTTON
     #ENDBOXED
     #BOXED('')
      #BUTTON('Global &AddressManager Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'GABook')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('Global &Addressbook Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'AVisualUpdate')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('Global &Addressbook Update Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'ABookVisual')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&SMTP Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'SMTP')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&NNTP Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'NNTP')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&Base64 Encoder Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'Base64')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&Quoted Printable Encoder Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'QuotedPrintable')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&Plain Encoder Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'PlainEncoder')
         #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
      #BUTTON('Db &Message Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'DbMessage')
         #INSERT(%GlobalClassPrompts(ABC))
        #END
      #ENDBUTTON
      #BUTTON('Db &Address Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'DbAddresses')
         #INSERT(%GlobalClassPrompts(ABC))
        #END
      #ENDBUTTON
      #BUTTON('&Silent Error Class'),AT(,,170),HLP('~TPLExtensionDocHandle_Class'),WHERE(%ProgramExtension<>'DLL')
        #WITH(%ClassItem,'SilentErrors')
         #INSERT(%GlobalClassPrompts(ABC))
        #END
      #ENDBUTTON
      #BUTTON('Mail/Document Library Files'),AT(,,170)
       #BOXED('Mail/Document Library Files')
        #INSERT(%AbcLibraryPrompts(ABC))
       #ENDBOXED
      #ENDBUTTON
     #ENDBOXED
    #ENDTAB
  #ENDSHEET
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'GABook', 'GlobalAddresses', %AdrMgrClass)
  #EQUATE(%GlobalAddressesObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'ABookVisual', 'AddressBook', %AddressBookClass)
  #EQUATE(%GlobalAddressBookObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'AVisualUpdate', 'AddressBookUpd', %ABookUpdClass)
  #EQUATE(%GlobalAddressUpdateObject, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'SMTP', 'eMail', %SMTPClass)
  #EQUATE(%SMTPObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'NNTP', 'News', %NNTPClass)
  #EQUATE(%NNTPObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'Base64', 'Base64', %Base64Class)
  #EQUATE(%Base64ObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'QuotedPrintable', 'QuotedPrintable', %QuotedPrintableClass)
  #EQUATE(%QuotedPrintableObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'PlainEncoder', 'PlainEncoder', %NoneFMClass)
  #EQUATE(%PlainEncoderObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'DbMessage', 'DbMessage', %DbMessageClass)
  #EQUATE(%DbMessageObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'DbAddresses', 'DbAddresses', %DbAddressClass)
  #EQUATE(%DbAddressesObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'SilentErrors', 'SilentErrors', %SilentErrorsClass)
  #EQUATE(%SilentErrorsObjectName, %ThisObjectName)
  #DECLARE(%ThisEncoder)
#ENDAT
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'GABook')
  #CALL(%AddObjectList(ABC), 'ABookVisual')
  #CALL(%AddObjectList(ABC), 'AVisualUpdate')
  #CALL(%AddObjectList(ABC), 'SMTP')
  #CALL(%AddObjectList(ABC), 'NNTP')
  #CALL(%AddObjectList(ABC), 'Base64')
  #CALL(%AddObjectList(ABC), 'QuotedPrintable')
  #CALL(%AddObjectList(ABC), 'PlainEncoder')
  #CALL(%AddObjectList(ABC), 'DbMessage')
  #CALL(%AddObjectList(ABC), 'DbAddresses')
  #CALL(%AddObjectList(ABC), 'SilentErrors')
#ENDAT
#!
#AT(%CustomGlobalDeclarations)
 #IF(~%Target32)
  #ERROR('Winsock Messaging and Document Handling is only available in 32bit!')
  #ABORT
 #ENDIF
 #FIX(%Driver,'DOS')
 #PROJECT(%DriverLib)
#ENDAT
#!
#AT (%BeforeGenerateApplication)
  #TYPEMAP('SOCKET','long')
  #!
  #CALL(%AddCategory(ABC), 'MAI')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'MAI', 'MAI', 'MAI')
  #!
  #CALL(%AddCategory(ABC), 'API')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'API', 'API','')
  #!
  #CALL(%AddCategory(ABC), 'WinSock')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'Winsock', 'Winsock','')
#END
#!
#!
#AT(%ProgramProcedures)
#IF(%ProgramExtension<>'DLL' AND ~%GlobalExternal)
  #CALL(%GenerateVirtuals(ABC), 'GABook', 'Global Objects|Messaging Objects|Address Book', '%GABookVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'ABookVisual', 'Global Objects|Messaging Objects|Address Book Visual', '%ABookVisualVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'AVisualUpdate', 'Global Objects|Messaging Objects|Address Book Visual Update', '%ABookVisualUpdateVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'SMTP', 'Global Objects|Messaging Objects|SMTP Transport', '%SMTPVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'NNTP', 'Global Objects|Messaging Objects|NNTP Transport', '%NNTPVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'Base64', 'Global Objects|Messaging Objects|Base64 Encoder', '%Base64Virtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'QuotedPrintable', 'Global Objects|Messaging Objects|Quoted Printable Encoder', '%QuotedPrintableVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'PlainEncoder', 'Global Objects|Messaging Objects|Plain Encoder', '%Base64Virtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'DbMessage', 'Global Objects|Messaging Objects|MIME Encoder', '%DbMessageVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'DbAddresses', 'Global Objects|Messaging Objects|Addresses', '%DbAddressesVirtuals(Messaging)', %True)
  #CALL(%GenerateVirtuals(ABC), 'SilentErrors', 'Global Objects|Messaging Objects|SilentError Manager', '%SilentErrorsVirtuals(Messaging)', %True)
#ENDIF
#ENDAT
#!
#AT(%GlobalData)
#IF(~%GlobalExternal)
#INSERT(%GenerateClass(ABC), 'GABook')
#INSERT(%GenerateClass(ABC), 'ABookVisual')
#INSERT(%GenerateClass(ABC), 'AVisualUpdate')
#INSERT(%GenerateClass(ABC), 'SMTP')
#INSERT(%GenerateClass(ABC), 'NNTP')
#INSERT(%GenerateClass(ABC), 'Base64')
#INSERT(%GenerateClass(ABC), 'PlainEncoder')
#INSERT(%GenerateClass(ABC), 'QuotedPrintable')
#INSERT(%GenerateClass(ABC), 'DbMessage')
#INSERT(%GenerateClass(ABC), 'DbAddresses')
#INSERT(%GenerateClass(ABC), 'SilentErrors')
#ELSE
#INSERT(%ExternalObjectDecl, 'GABook')
#INSERT(%ExternalObjectDecl, 'ABookVisual')
#INSERT(%ExternalObjectDecl, 'AVisualUpdate')
#INSERT(%ExternalObjectDecl, 'SMTP')
#INSERT(%ExternalObjectDecl, 'NNTP')
#INSERT(%ExternalObjectDecl, 'Base64')
#INSERT(%ExternalObjectDecl, 'PlainEncoder')
#INSERT(%ExternalObjectDecl, 'QuotedPrintable')
#INSERT(%ExternalObjectDecl, 'DbMessage')
#INSERT(%ExternalObjectDecl, 'DbAddresses')
#INSERT(%ExternalObjectDecl, 'SilentErrors')
#ENDIF
#ENDAT
#!
#AT(%BeginningExports)
  #IF(~%GlobalExternal)
    #IF(~%NoGenerateGlobals)
#INSERT(%AddExpItem,'GABook')
#INSERT(%AddExpItem,'ABookVisual')
#INSERT(%AddExpItem,'AVisualUpdate')
#INSERT(%AddExpItem,'SMTP')
#INSERT(%AddExpItem,'NNTP')
#INSERT(%AddExpItem,'Base64')
#INSERT(%AddExpItem,'PlainEncoder')
#INSERT(%AddExpItem,'QuotedPrintable')
#INSERT(%AddExpItem,'DbMessage')
#INSERT(%AddExpItem,'DbAddresses')
#INSERT(%AddExpItem,'SilentErrors')
    #ENDIF
  #ENDIF
#ENDAT
#! Global AddressManager Parent Calls.
#AT(%GABookMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Global Addressbook Parent Calls.
#AT(%AddressBookMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Global Address Update Parent Calls.
#AT(%AVisualUpdMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! SMTP Parent Calls.
#AT(%SMTPMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! NNTP Parent Calls.
#AT(%NNTPMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Base64 Parent Calls.
#AT(%Base64MethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Plain Encoder Parent Calls.
#AT(%PlainEncoderMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Quoted Printable Parent Calls.
#AT(%QuotedPrintableMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Global DbMessage Parent Calls.
#AT(%DbMessageMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#! Global DbAddresses Parent Calls.
#AT(%DbAddressesMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Global Silent Error Parent Calls.
#AT(%SilentErrorsMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#AT(%ProgramSetup)
#IF(~%GlobalExternal)
%SilentErrorsObjectName.Init()
%GlobalAddressesObjectName.Init(INIMgr, 'Global')
 #IF(%AdrSaveRestore)
%GlobalAddressesObjectName.Restore()
 #ENDIF
%GlobalAddressBookObjectName.Init(%GlobalAddressUpdateObject, INIMgr, GlobalErrors)
%Base64ObjectName.Init(GlobalErrors)
%QuotedPrintableObjectName.Init(GlobalErrors)
%PlainEncoderObjectName.Init(GlobalErrors)
%SMTPObjectName.Init(%GlobalAddressesObjectName.GetIABook(), %SilentErrorsObjectName)
%SMTPObjectName.DefaultServer = %(%StripPling(%SMTPDefaultServer))
%SMTPObjectName.DefaultPort = %(%StripPling(%SMTPDefaultPort))
%SMTPObjectName.Sender = %(%StripPling(%SMTPSender))
#IF(%SMTPFrom)
%SMTPObjectName.From = %(%StripPling(%SMTPFromName)) & ' <<' & %(%StripPling(%SMTPFrom)) & '>'
#ENDIF
%SMTPObjectName.SenderDomain = %(%StripPling(%SMTPSenderDomain))
#FOR(%SMTPHeaders)
%SMTPObjectName.SetHeader('X-' & %(%StripPling(%SMTPHeader)),%(%StripPling(%SMTPHeaderValue)))
#ENDFOR
%NNTPObjectName.Init(%GlobalAddressesObjectName.GetIABook(), %SilentErrorsObjectName)
%NNTPObjectName.DefaultServer = %(%StripPling(%NNTPDefaultServer))
%NNTPObjectName.DefaultPort = %(%StripPling(%NNTPDefaultPort))
%NNTPObjectName.User = %(%StripPling(%NNTPUser))
%NNTPObjectName.Password = %(%StripPling(%NNTPPassword))
#IF(%NNTPFrom)
%NNTPObjectName.From = %(%StripPling(%NNTPFromName)) & ' <<' & %(%StripPling(%NNTPFrom)) & '>'
#ENDIF
#FOR(%NNTPHeaders)
%NNTPObjectName.SetHeader('X-' & %(%StripPling(%NNTPHeader)),%(%StripPling(%NNTPHeaderValue)))
#ENDFOR
 #FOR(%SMTPReplyTo)
%SMTPObjectName.AddReplyTo(%(%StripPling(%SMTPReplyToAddress)),%(%StripPling(%SMTPReplyToName)))
 #ENDFOR
 #IF(%AdrLoadProc)
%AdrLoadProc ! Load Global Addresses.
 #ENDIF
%DbMessageObjectName.Init(%SilentErrorsObjectName)
%DbMessageObjectName.AddDST(%SMTPObjectName.IDST,SMTP)
%DbMessageObjectName.AddDST(%NNTPObjectName.IDST,NNTP)
%DbAddressesObjectName.Init(INIMgr, 'DbAddresses')
#ENDIF
#ENDAT
#AT(%ProgramEnd)
#IF(~%GlobalExternal)
  #IF(%AdrSaveRestore)
%GlobalAddressesObjectName.Save()
  #ENDIF
%SMTPObjectName.Kill()
%NNTPObjectName.Kill()
%Base64ObjectName.Kill()
%QuotedPrintableObjectName.Kill()
%PlainEncoderObjectName.Kill()
%GlobalAddressesObjectName.Kill()
%DbMessageObjectName.Kill()
%DbAddressesObjectName.Kill()
%SilentErrorsObjectName.Kill()
#ENDIF
#ENDAT
#!
#AT(%SilentErrorsMethodCodeSection,'Init','()'),LAST
SELF.HistoryThreshold = 1000
SELF.HistoryViewLevel = Level:Notify
SELF.HistoryResetOnView = True
SELF.Silent = True
#ENDAT
#!
#AT(%SilentErrorsMethodCodeSection,'ViewHistory','()'),LAST
IF SELF.HistoryResetOnView
 FREE(SELF.History)
END
#ENDAT
#!
#AT(%GuardMethodCodeSection,'TakeInvalidPassword'),PRIORITY(9980),WHERE(%WebGuardSupport AND %SendInvalidPasswordMessage)
IF PasswordReminder
#INSERT(%SendDocGrp,%GuardSubject,%GuardRecipientAddress,%GuardRecipientName,%GuardRecipClass,%GuardBody,%GuardContent)
END
#INSERT(%SendDocGrp,%LogonSubject,%LogonRecipientAddress,%LogonRecipientName,%LogonRecipClass,%LogonBody,%LogonContent)
#ENDAT
#!
#AT(%GuardMethodCodeSection,'TakeInvalidUser'),PRIORITY(9980),WHERE(%WebGuardSupport AND %SendInvalidLogonMessage)
#INSERT(%SendDocGrp,%LogonSubject,%LogonRecipientAddress,%LogonRecipientName,%LogonRecipClass,%LogonBody,%LogonContent)
#ENDAT
#!
#AT(%AVisualUpdMethodCodeSection,'Init','(),BYTE'),PRIORITY(5001)
 %GlobalAddressUpdateObject.AddItem(%SMTPObjectName.IDST, 'SMTP')
 %GlobalAddressUpdateObject.AddItem(%NNTPObjectName.IDST, 'NNTP')
#ENDAT
#!
#AT(%DbAuditMethodDataSection,'OnFieldChange')
SendDocument BYTE
#ENDAT
#!
#AT(%DbAuditMethodDataSection,'OnChange')
SendDocument BYTE
#ENDAT
#!
#AT(%DbAuditMethodDataSection,'OnDelete')
SendDocument BYTE
#ENDAT
#AT(%DbAuditMethodCodeSection,'OnDelete'),PRIORITY(7000)
#INSERT(%DBSend)
#ENDAT
#!
#AT(%DbAuditMethodDataSection,'OnInsert')
SendDocument BYTE
#ENDAT
#AT(%DbAuditMethodCodeSection,'OnInsert'),PRIORITY(7000)
#INSERT(%DBSend)
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
#GROUP(%GABookVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%GABookMethodDataSection,'Global Addresses Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('GABook'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%GABookMethodCodeSection,'Global Addresses Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('GABook'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%ABookVisualVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%AddressBookMethodDataSection,'AddressBook Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('ABookVisual'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%AddressBookMethodCodeSection,'AddressBook Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('ABookVisual'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%ABookVisualUpdateVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%AVisualUpdateMethodDataSection,'AddressBook Update Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('AVisualUpdate'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%AVisualUpdMethodCodeSection,'AddressBook Update Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('AVisualUpdate'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%SMTPVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%SMTPMethodDataSection,'SMTP Transport Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('SMTP'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%SMTPMethodCodeSection,'SMTP Transport Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('SMTP'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%NNTPVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%NNTPMethodDataSection,'NNTP Transport Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('SMTP'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%NNTPMethodCodeSection,'NNTP Transport Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('SMTP'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%Base64Virtuals, %TreeText, %DataText, %CodeText)
#EMBED(%Base64MethodDataSection,'Base64 Encoder Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('Base64'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%Base64MethodCodeSection,'Base64 Encoder Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('Base64'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%PlainEncoderVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%PlainEncoderMethodDataSection,'Plain Encoder Encoder Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('Plain Encoder'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%PlainEncoderMethodCodeSection,'Plain Encoder Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('Plain Encoder'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%QuotedPrintableVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%QuotedPrintableMethodDataSection,'Quoted Printable Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('QuotedPrintable'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%QuotedPrintableMethodCodeSection,'Quoted Printable Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('QuotedPrintable'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%DbMessageVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%DbMessageMethodDataSection,'Global Addresses Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('DbMessage'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%DbMessageMethodCodeSection,'Global Addresses Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('DbMessage'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%DbAddressesVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%DbAddressesMethodDataSection,'Global Addresses Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('DbAddresses'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%DbAddressesMethodCodeSection,'Global Addresses Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('DbAddresses'))),TREE(%TreeText & %CodeText)
#!
#GROUP(%SilentErrorsVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%SilentErrorsMethodDataSection,'SilentErrors Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('SilentErrors'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%SilentErrorsMethodCodeSection,'SilentErrors Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('SilentErrors'))),TREE(%TreeText & %CodeText)
#!
#!--------------------------------------------------------------------------------------
#EXTENSION(DocumentSend,'Document Send Extension'),PROCEDURE,REQ(GlobalDocumentHandling),HLP('~DocumentSend')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'DocHandler', 'Message', 'DocumentHandler')
  #CALL(%SetClassDefaults(ABC), 'ABook', 'Addresses', 'AdrMgr')
  #CALL(%SetClassDefaults(ABC), 'RecipControl', 'RecipList', 'RecipientControl')
  #FOR(%SendControls)
   #FIX(%Control,%SendControl)
   #IF(~%Control)
    #DELETE(%SendControls)
   #ENDIF
  #ENDFOR
  #DECLARE(%DocTypes),UNIQUE
  #DECLARE(%DocSubtypes),MULTI
  #CALL(%LoadContentTypes)
  #CALL(%LoadContentSubTypes,'application')
  #CALL(%LoadComboValues)
#ENDPREPARE
  #BOXED('Default OOP prompts'),AT(0,0),WHERE(%False),HIDE
    #INSERT(%OOPHiddenPrompts(ABC))
  #ENDBOXED
 #SHEET,HSCROLL
    #TAB('&Controls')
     #BUTTON('Send Message Settings'),AT(,,175)
      #BOXED('')
       #BOXED('Send on Control Event')
        #BUTTON('Send Controls'),MULTI(%SendControls,%SendControl & '-> ' & %SendControlEvent),INLINE
         #PROMPT('Control:',CONTROL),%SendControl
         #PROMPT('Event:',FROM(%ControlEvent)),%SendControlEvent,DEFAULT('Accepted')
        #ENDBUTTON
       #ENDBOXED
       #PROMPT('Send on Window Event?',CHECK),%SendOnWindowEvent
       #ENABLE(%SendOnWindowEvent)
        #PROMPT('Send on Window Event:',FROM(%WindowEvent)),%SendWindowEvent,DEFAULT('CloseWindow')
       #ENDENABLE
       #PROMPT('Send on Method Call?',CHECK),%SendOnMethodCall
       #ENABLE(%SendOnMethodCall)
        #PROMPT('Send on Method:',DROP('Window Completed|Process a Record|After IReport Creation')),%SendMethod
       #ENDENABLE
      #ENDBOXED
     #ENDBUTTON
     #BOXED('Addressbook Settings')
       #PROMPT('Recipient Listbox:',CONTROL),%RecipientListBox
       #PROMPT('Use Global Addresses?',CHECK),%AddressUseGlobal,DEFAULT(1)
       #ENABLE(~%AddressUseGlobal)
       #BOXED('')
        #PROMPT('Save and Restore?',CHECK),%AddressSaveRestore
        #ENABLE(%AddressSaveRestore)
         #PROMPT('Family:',@s80),%AddressFamily,DEFAULT(%Procedure)
        #ENDENABLE
       #ENDBOXED
       #ENDENABLE
       #BUTTON('&Address Button'),AT(,,175)
       #BOXED('')
        #PROMPT('Address Book Trigger:',DROP('Control Event|Window Event|Other|None')),%AddressTrigger,DEFAULT('None')
        #ENABLE(%AddressTrigger='Control Event')
        #BOXED('Call Addressbook on Control Event')
         #PROMPT('Control:',CONTROL),%AddressControl
         #PROMPT('Event:',FROM(%ControlEvent)),%AddressControlEvent,DEFAULT('Accepted')
        #ENDBOXED
        #ENDENABLE
        #ENABLE(%AddressTrigger='Window Event')
         #PROMPT('Addressbook Window Event:',FROM(%WindowEvent)),%AddressWindowEvent,DEFAULT('CloseWindow')
        #ENDENABLE
        #ENABLE(%AddressTrigger='Other')
         #PROMPT('Addressbook on Method:',DROP('Window Completed|Process a Record')),%AddressMethod
        #ENDENABLE
       #ENDBOXED
       #ENDBUTTON
       #BOXED,WHERE(UPPER(%ProcedureTemplate)='PROCESS')
        #PROMPT('Load addresses:',DROP('Once|Once per valid record')),%LoadAddress
       #ENDBOXED
     #ENDBOXED
    #ENDTAB
    #TAB('&Message Settings')
     #BOXED('&General')
      #PROMPT('Subject:',@s255),%DocSubject,AT(40,,145)
      #PROMPT('Priority:',COMBO(%cPriority)),%DocPriority,DEFAULT('Normal')
      #PROMPT('Text Only (No MIME Headers)',CHECK),%DocTextOnly,AT(10)
      #BOXED(''),WHERE(%DocTextOnly)
       #DISPLAY('Only unencoded plain text parts will be output.')
      #ENDBOXED
     #ENDBOXED
     #BOXED('C&ontent')
      #BOXED('Body')
       #PROMPT('Message Body Source:',DROP('Field|File|None')),%BodySource
       #ENABLE(%BodySource='File')
        #BOXED('')
         #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%BodySourceFile
         #PROMPT('File is a Skeleton?',CHECK),%BodyFileIsASkeleton
        #ENDBOXED
       #ENDENABLE
       #ENABLE(%BodySource='Field')
        #BOXED('')
         #PROMPT('Field:',FIELD),%BodyField,REQ
        #ENDBOXED
       #ENDENABLE
       #PROMPT('Content Type:',DROP('Plain Text|Html')),%BodyContent,DEFAULT('Plain Text')
       #PROMPT('Encoder:',DROP('Quoted Printable|Base64|None')),%BodyEncoder,DEFAULT('Quoted Printable')
      #ENDBOXED
      #ENABLE(%BodyContent='Plain Text')
      #BOXED('Alternative Html Formatted Message Body')
       #PROMPT('Message Body Source:',DROP('None|Field|File')),%AlternateSource,DEFAULT('None')
       #BOXED,WHERE(%AlternateSource<>'None')
        #ENABLE(%AlternateSource='File')
         #BOXED('')
          #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm')),%AlternateSourceFile
         #ENDBOXED
        #ENDENABLE
        #ENABLE(%AlternateSource='Field')
         #BOXED('')
          #PROMPT('Field:',FIELD),%AlternateField,REQ
         #ENDBOXED
        #ENDENABLE
        #PROMPT('Encoder:',DROP('Quoted Printable|Base64|None')),%AlternateEncoder,DEFAULT('Quoted Printable')
       #ENDBOXED
      #ENDBOXED
      #ENDENABLE
     #ENDBOXED
    #ENDTAB
    #TAB('A&ttachments')
      #BOXED('')
       #BUTTON('Attachments'),MULTI(%Content,%AttachmentDescription()),INLINE
        #BOXED('')
         #PROMPT('Attachment Source:',DROP('Field|File')),%ContentSource,DEFAULT('File')
         #ENABLE(%ContentSource='File')
          #BOXED('')
           #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%ContentSourceFile
          #ENDBOXED
         #ENDENABLE
         #ENABLE(%ContentSource='Field')
          #BOXED('')
           #PROMPT('Field:',FIELD),%ContentField,REQ
          #ENDBOXED
         #ENDENABLE
         #PROMPT('Filename:',@s80),%DocFileName
         #PROMPT('Content Type:',DROP('Html|Plain Text|Binary|Other')),%DocSimpleContent,DEFAULT('Binary'),WHENACCEPTED(CALL(%DocSimpleContentAccepted))
         #ENABLE(%DocSimpleContent='Other')
          #PROMPT('Content Type:',FROM(%DocTypes)),%DocContentType,WHENACCEPTED(CALL(%ContentTypeAccepted))
          #PROMPT('Content SubType:',FROM(%DocSubtypes)),%DocContentSubType #! Load from Equates
         #ENDENABLE
         #ENABLE(%DocContentType='Text')
          #PROMPT('Encoder:',DROP('Quoted Printable|Base64|None')),%DocEncoder,DEFAULT('Base64')
         #ENDENABLE
         #PROMPT('Embedded?',CHECK),%DocEmbedded
        #ENDBOXED
       #ENDBUTTON
      #ENDBOXED
    #ENDTAB
    #TAB('Static &Addressing')
     #BOXED('&Address Settings')
       #BUTTON('Recipients'),MULTI(%Recipients,%RecipClass & ': "' & %RecipName & '" <' & %RecipAddress & '>'),INLINE
       #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%RecipClass,DEFAULT('SendTo')
       #PROMPT('Recipient Address:',@s255),%RecipAddress,Req
       #PROMPT('Recipient Name:',@s255),%RecipName
       #PROMPT('Transport to use:',COMBO(%cTransports)),%RecipTransport,DEFAULT('SMTP')
       #ENDBUTTON
     #ENDBOXED
    #ENDTAB
    #TAB('&Classes'),HLP('~TPLExtensionDocSend_Class')
     #BUTTON('&Document Handler Class')
       #WITH(%ClassItem,'DocHandler')
        #INSERT(%ClassPrompts(ABC))
       #END
     #ENDBUTTON
     #BUTTON('&Address Book Class')
       #WITH(%ClassItem,'ABook')
        #INSERT(%ClassPrompts(ABC))
       #END
     #ENDBUTTON
     #BUTTON('&Recipient List Class')
       #WITH(%ClassItem,'RecipControl')
        #INSERT(%ClassPrompts(ABC))
       #END
     #ENDBUTTON
    #ENDTAB
 #ENDSHEET
#!
#!
#ATSTART
  #FIX(%Control,%RecipientListBox)
  #IF(~%Control)
   #SET(%RecipientListBox,'')
  #ENDIF
  #FIX(%Control,%AddressControl)
  #IF(~%Control)
   #SET(%AddressControl,'')
  #ENDIF
  #FOR(%SendControls)
   #FIX(%Control,%SendControl)
   #IF(~%Control)
    #DELETE(%SendControls)
   #ENDIF
  #ENDFOR
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'DocHandler', 'Message', 'DocumentHandler')
  #EQUATE(%MessageObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'ABook', 'Addresses', 'AdrMgr')
  #EQUATE(%AddressesObjectName, %ThisObjectName)
  #CALL(%SetClassDefaults(ABC), 'RecipControl', 'RecipList', 'RecipientControl')
  #EQUATE(%RecipListObjectName, %ThisObjectName)
  #DECLARE(%ThisEncoder)
#ENDAT
#!
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'DocHandler')
  #CALL(%AddObjectList(ABC), 'ABook')
  #CALL(%AddObjectList(ABC), 'RecipControl')
#ENDAT
#!
#AT(%DataSection)
#INSERT(%GenerateClass(ABC), 'DocHandler')
#INSERT(%GenerateClass(ABC), 'ABook')
#INSERT(%GenerateClass(ABC), 'RecipControl')
#IF(%SendMethod='Process a Record')
DocErrors BYTE
#ENDIF
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(6000)
#INSERT(%DocInits)
 #IF(%RecipientListBox)
%RecipListObjectName.Init(%RecipientListBox,%AddressesObjectName.IABook)
SELF.AddItem(%RecipListObjectName.WindowComponent)
#IF(%SendMethod='Process a Record')
DocErrors = False
#ENDIF
 #ENDIF
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Kill','(),BYTE')
#IF(%SendMethod='Process a Record')
IF DocErrors
   %SilentErrorsObjectName.ViewHistory()
END
#ENDIF
%MessageObjectName.Kill()
#IF(%AddressSaveRestore)
%AddressesObjectName.Save()
#ENDIF
%SMTPObjectName.RemoveIAB() ! Removes the thread's addressbook from the DST.
%NNTPObjectName.RemoveIAB() ! Removes the thread's addressbook from the DST.
%AddressesObjectName.Kill()
#ENDAT
#!
#AT(%ControlEventHandling,%GetSendControl(),%GetSendControlEvent())
#INSERT(%DocSendInits)
#PRIORITY(7500)
#INSERT(%DocSend)
POST(EVENT:CloseWindow)
#ENDAT
#!
#AT(%WindowEventHandling,%SendWindowEvent)
#IF(%SendOnWindowEvent)
#INSERT(%DocSendInits)
#INSERT(%DocSend)
#ENDIF
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'TakeCompleted','(),BYTE')
#IF(%SendOnMethodCall)
 #IF(%SendMethod='Window Completed')
#INSERT(%DocSendInits)
 #ENDIF
#ENDIF
#PRIORITY(7500)
#IF(%SendOnMethodCall)
 #IF(%SendMethod='Window Completed')
#INSERT(%DocSend)
 #ENDIF
#ENDIF
#ENDAT
#!
#AT(%ProcessManagerMethodCodeSection,'TakeRecord','(),BYTE')
#IF(%LoadAddress='Once per valid record')
 #INSERT(%LoadAddresses)
#ENDIF
#IF(%SendOnMethodCall)
 #IF(%SendMethod='Process a Record')
#INSERT(%DocSendInits)
 #ENDIF
#ENDIF
#PRIORITY(7500)
#IF(%SendOnMethodCall)
 #IF(%SendMethod='Process a Record')
#INSERT(%DocSend)
 #ENDIF
#ENDIF
#ENDAT
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(9530)
#IF(%SendOnMethodCall)
 #IF(%SendMethod='After IReport Creation')
#INSERT(%DocSendInits)
#INSERT(%DocSend)
 #ENDIF
#ENDIF
#PRIORITY(7800)
 #IF(%LoadAddress='Once')
  #FOR(%Recipients)
IF %(%StripPling(%RecipAddress))
   %AddressesObjectName.AddRecipient(%(%StripPling(%RecipAddress)), %(%StripPling(%RecipName)), %RecipClass, %RecipTransport,)
END
  #ENDFOR
 #ENDIF
#ENDAT
#!
#AT(%ControlEventHandling,%AddressControl,%AddressControlEvent)
#IF(%AddressTrigger='Control Event')
 %GlobalAddressBookObjectName.Ask(%AddressesObjectName.IABook.GetRecipients(),%GlobalAddressesObjectName.IABook.GetRecipients())
#ENDIF
#ENDAT
#!
#AT(%WindowEventHandling,%AddressWindowEvent)
#IF(%AddressTrigger='Window Event')
 %GlobalAddressBookObjectName.Ask(%AddressesObjectName.IABook.GetRecipients(),%GlobalAddressesObjectName.IABook.GetRecipients())
#ENDIF
#ENDAT
#!
#AT(%LocalProcedures)
  #CALL(%GenerateVirtuals(ABC), 'DocHandler', 'Local Objects|Messaging Objects|Document Handler', '%DocHandlerVirtuals(Messaging)')
  #CALL(%GenerateVirtuals(ABC), 'ABook', 'Local Objects|Messaging Objects|Address Book', '%ABookVirtuals(Messaging)')
  #CALL(%GenerateVirtuals(ABC), 'RecipControl', 'Local Objects|Messaging Objects|Receipt Control', '%RecipControlVirtuals(Messaging)')
#!
#ENDAT
#! Addressbook Parent Calls.
#AT(%AddressManagerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Document Handler Parent Calls.
#AT(%DocumentHandlerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#! Recipient Control Parent Calls.
#AT(%RecipControlMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#GROUP(%DocHandlerVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%DocumentHandlerMethodDataSection,'Document Handler Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('DocHandler'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%DocumentHandlerMethodCodeSection,'Document Handler Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('DocHandler'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%ABookVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%AddressManagerMethodDataSection,'AddressBook Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('ABook'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%AddressManagerMethodCodeSection,'AddressBook Handler Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('ABook'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%RecipControlVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%RecipControlMethodDataSection,'AddressBook Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('RecipControl'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%RecipControlMethodCodeSection,'AddressBook Handler Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('RecipControl'))),TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%LoadAddresses)
 #FOR(%Recipients)
IF %(%StripPling(%RecipAddress))
   %AddressesObjectName.AddRecipient(%(%StripPling(%RecipAddress)), %(%StripPling(%RecipName)), %RecipClass, %RecipTransport,)
END
 #ENDFOR
#!
#GROUP(%DocInits)
%MessageObjectName.Init(%SilentErrorsObjectName)
%AddressesObjectName.Init(INIMgr, '%AddressFamily')
%SMTPObjectName.SetIAB(%AddressesObjectName.IABook)
%MessageObjectName.AddDST(%SMTPObjectName.IDST,SMTP)
%NNTPObjectName.SetIAB(%AddressesObjectName.IABook)
%MessageObjectName.AddDST(%NNTPObjectName.IDST,NNTP)
 #IF(%AddressUseGlobal)
%AddressesObjectName.AddRecipients(%GlobalAddressesObjectName.IABook)
 #ELSE
  #IF(%AddressSaveRestore AND %LoadAddress='Once')
%AddressesObjectName.Restore()
  #ENDIF
 #ENDIF
#IF(%DocPriority <> 'None' OR %DocPriority = 'Normal')
#IF(~SUB(%DocPriority,1,1)='!' AND %DocPriority='High')
%SMTPObjectName.SetHeader('X-Priority','1 (Highest)')
#ENDIF
#IF(~SUB(%DocPriority,1,1)='!' AND %DocPriority='Low')
%SMTPObjectName.SetHeader('X-Priority','5 (Lowest)')
#ENDIF
#ENDIF
#!
#GROUP(%DocSendInits)
%MessageObjectName.Description = %(%StripPling(%DocSubject))
#IF(%DocTextOnly)
%MessageObjectName.TextOnly = True
#ENDIF
#IF(SUB(%DocPriority,1,1)='!')
CASE(%(%StripPling(%DocPriority)))
OF 'High'
  %SMTPObjectName.SetHeader('X-Priority','1 (Highest)')
OF 'Low'
  %SMTPObjectName.SetHeader('X-Priority','5 (Lowest)')
ELSE
  %SMTPObjectName.SetHeader('X-Priority',%(%StripPling(%DocPriority)))
END
#ENDIF
 #SET(%ThisEncoder,%PlainEncoderObjectName & '.IEncoder')
 #IF(%BodyEncoder='Quoted Printable')
   #SET(%ThisEncoder,%QuotedPrintableObjectName & '.IEncoder')
 #ENDIF
 #IF(%BodyEncoder='Base64')
   #SET(%ThisEncoder,%Base64ObjectName & '.IEncoder')
 #ENDIF
 #IF(%BodySource='Field')
  #IF(%BodyContent='Plain Text')
%MessageObjectName.AddBody(%BodyField,Content:text,SubType:plain, %ThisEncoder)
  #ELSE
%MessageObjectName.AddBody(%BodyField,Content:text,SubType:html, %ThisEncoder)
  #ENDIF
 #ENDIF
 #IF(%BodySource='File')
  #IF(%BodyFileIsASkeleton)
   #INSERT(%MergeAndGenerate(Skeletons),%BodySourceFile,%BodySourceFile, '')
  #ENDIF
  #IF(%BodyContent='Plain Text')
%MessageObjectName.AddBodyFromFile(%(%StripPling(%BodySourceFile)),Content:text,SubType:plain, %ThisEncoder)
  #ELSE
%MessageObjectName.AddBodyFromFile(%(%StripPling(%BodySourceFile)),Content:text,SubType:html, %ThisEncoder)
  #ENDIF
 #ENDIF
 #IF(%BodyContent='Plain Text' AND %AlternateSource<>'None')
  #SET(%ThisEncoder,%PlainEncoderObjectName & '.IEncoder')
  #IF(%AlternateEncoder='Quoted Printable')
    #SET(%ThisEncoder,%QuotedPrintableObjectName& '.IEncoder')
  #ENDIF
  #IF(%AlternateEncoder='Base64')
    #SET(%ThisEncoder,%Base64ObjectName & '.IEncoder')
  #ENDIF
  #IF(%AlternateSource='Field')
%MessageObjectName.AddBody(%AlternateField,Content:text,SubType:html, %ThisEncoder)
  #ELSE
%MessageObjectName.AddBodyFromFile(%(%StripPling(%AlternateSourceFile)),Content:text,SubType:html, %ThisEncoder)
  #ENDIF
 #ENDIF
 #!
 #FOR(%Content)
   #SET(%ThisEncoder,%PlainEncoderObjectName & '.IEncoder')
   #IF(%DocEncoder='Quoted Printable')
    #SET(%ThisEncoder,%QuotedPrintableObjectName & '.IEncoder')
   #ENDIF
   #IF(%DocEncoder='Base64')
    #SET(%ThisEncoder,%Base64ObjectName & '.IEncoder')
   #ENDIF
   #IF(%ContentSource='File') #! Field only loaded before send to allow for user entry.
%MessageObjectName.AddAttachment(%(%StripPling(%ContentSourceFile)),%(%StripPling(%DocFileName)),Content:%DocContentType,SubType:%DocContentSubType, %ThisEncoder, %DocEmbedded) 
   #ENDIF
   #IF(%ContentSource='Field')
%MessageObjectName.AddAttachmentFromText(%ContentField,%(%StripPling(%DocFileName)),Content:%DocContentType,SubType:%DocContentSubType, %ThisEncoder, %DocEmbedded) 
   #ENDIF
 #ENDFOR
#!
#GROUP(%DocSend)
 IF %MessageObjectName.Send()
    #IF(%SendMethod<>'Process a Record')
    %SilentErrorsObjectName.ViewHistory()
    #ELSE
    DocErrors = True
    #ENDIF
 END
 %MessageObjectName.FreeAttachments()
#IF(%LoadAddress='Once per valid record' AND %SendMethod='Process a Record')
%AddressesObjectName.FreeRecipients()
#ENDIF
#!
#GROUP(%DocSimpleContentAccepted)
 #CASE(%DocSimpleContent)
 #OF('Html')
  #SET(%DocContentType,'Text')
  #CALL(%LoadContentSubTypes,%DocContentType)
  #SET(%DocContentSubType,'html')
 #OF('Plain Text')
  #SET(%DocContentType,'Text')
  #CALL(%LoadContentSubTypes,%DocContentType)
  #SET(%DocContentSubType,'plain')
 #OF('Binary')
  #SET(%DocContentType,'Application')
  #CALL(%LoadContentSubTypes,%DocContentType)
  #SET(%DocContentSubType,'octetstream')
  #SET(%DocEncoder,'Base64')
 #ENDCASE
#!
#GROUP(%ContentTypeAccepted)
 #CALL(%LoadContentSubTypes,%DocContentType)
 #SET(%DocContentSubType,%DocSubtypes)
#!
#GROUP(%LoadContentTypes)
 #ADD (%DocTypes, 'Text')
 #ADD (%DocTypes, 'Image')
 #ADD (%DocTypes, 'Audio')
 #ADD (%DocTypes, 'Video')
 #ADD (%DocTypes, 'Multipart')
 #ADD (%DocTypes, 'Message')
 #ADD (%DocTypes, 'Application')
 #ADD (%DocTypes, 'MIME')
#!
#GROUP(%LoadContentSubTypes,%ContentType)
#FREE(%DocSubtypes)
  #ADD (%DocSubTypes, 'plain')
  #ADD (%DocSubTypes, 'html')
  #ADD (%DocSubTypes, 'mixed')
  #ADD (%DocSubTypes, 'alternative')
  #ADD (%DocSubTypes, 'related')
  #ADD (%DocSubTypes, 'digest')
  #ADD (%DocSubTypes, 'parallel')
  #ADD (%DocSubTypes, 'RFC822')
  #ADD (%DocSubTypes, 'partial')
  #ADD (%DocSubTypes, 'externalbody')
  #ADD (%DocSubTypes, 'octetstream')
  #ADD (%DocSubTypes, 'msword')
  #ADD (%DocSubTypes, 'jpeg')
  #ADD (%DocSubTypes, 'gif')
#!
#GROUP(%AttachmentDescription)
 #DECLARE(%ContentDesc)
 #IF(%ContentSource='File')
  #SET(%ContentDesc,%ContentSource & ': ' & %ContentSourceFile & ' Type: ' & %DocSimpleContent & ' (' & %DocEncoder & ')')
 #ELSE
  #SET(%ContentDesc,%ContentSource & ': ' & %ContentField & ' Type: ' & %DocSimpleContent & ' (' & %DocEncoder & ')')
 #ENDIF
 #RETURN(%ContentDesc)
#!
#GROUP(%GetSendControl)
 #FOR(%SendControls)
  #IF(%SendControl=%Control)
   #RETURN(%SendControl)
  #ENDIF
 #ENDFOR
 #RETURN('')
#!
#GROUP(%GetSendControlEvent)
 #FOR(%SendControls)
  #IF(%SendControl=%Control)
   #RETURN(%SendControlEvent)
  #ENDIF
 #ENDFOR
 #RETURN('')
#!
#!-------------------------------------------------------------------------------------
#EXTENSION(LoadAddresses,'Load Addresses from File'),PROCEDURE,REQ(GlobalDocumentHandling),HLP('~LoadAddresses')
 #PREPARE
  #CALL(%LoadComboValues)
 #ENDPREPARE
 #RESTRICT
  #IF(UPPER(%ProcedureTemplate)='PROCESS')
   #ACCEPT
  #ELSE
   #REJECT
  #ENDIF
 #ENDRESTRICT
 #BOXED('')
  #PROMPT('Address Field:',FIELD),%AdrField,REQ
  #PROMPT('Name Field:',FIELD),%AdrName
  #PROMPT('Default Class:',COMBO(%cRecipClass)),%AdrClass
  #PROMPT('Transport Type:',@s30),%AdrTransport,DEFAULT('SMTP'),REQ
 #ENDBOXED
#AT(%ProcessManagerMethodCodeSection,'TakeRecord','(),BYTE')
 IF %AdrField
    IF NOT %AdrName
       %AdrName = %AdrField
    END
    %GlobalAddressesObjectName.AddRecipient(%AdrField, %AdrName,  %AdrClass, %(%StripPling(%AdrTransport)),)
 END
#ENDAT
#!-------------------------------------------------------------------------------------
#EXTENSION(FileTriggers,'Trigger messages.'),APPLICATION,MULTI,REQ(GlobalDocumentHandling),HLP('~FileTriggers')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #DECLARE(%TplInstance)
  #CALL(%FindGlobalTemplateInstance(ABC), 'DbAuditing(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%DbAuditingSupport,%True)
  #ELSE
    #SET(%DbAuditingSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'FileUserTags(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%FileUserTagsSupport,%True)
  #ELSE
    #SET(%FileUserTagsSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'GenericSkeletonClasses(Skeletons)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%GenericSkeletonsSupport,%True)
  #ELSE
    #SET(%GenericSkeletonsSupport,%False)
  #ENDIF
  #IF(%GenericSkeletonsSupport AND %FileUserTagsSupport)
    #SET(%DocumentMergingSupport,%True)
  #ELSE
    #SET(%DocumentMergingSupport,%False)
  #ENDIF
#ENDPREPARE
#!
   #BOXED('Trigger Settings'),WHERE(%DbAuditingSupport)
    #BUTTON('Trigger Files'),FROM(%File,%GetTriggerDescription()),INLINE
     #BOXED('Triggers')
      #PROMPT('Changes?',CHECK),%ChangeTrigger,AT(30,14)
      #PROMPT('Inserts?',CHECK),%InsertTrigger,AT(80,14)
      #PROMPT('Deletes?',CHECK),%DeleteTrigger,AT(120,14)
     #ENDBOXED
     #SHEET
     #TAB('Change Trigger'),WHERE(%ChangeTrigger)
      #PROMPT('Send Trigger:',DROP('Per Row Change|Per Column Change')),%Trigger
      #PROMPT('Subject:',@s200),%TriggerSubject,REQ
      #PROMPT('Content Type:',DROP('Html|Plain Text')),%TriggerContent,DEFAULT('Html')
      #PROMPT('Message Body Source:',DROP('Field|File')),%TriggerSource,DEFAULT('File')
      #ENABLE(%TriggerSource='File')
       #BOXED('')
        #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%TriggerSourceFile
        #ENABLE(%DocumentMergingSupport)
         #PROMPT('Use skeleton to Merge document?',CHECK),%MergeDocument,AT(10)
        #ENDENABLE
       #ENDBOXED
      #ENDENABLE
      #ENABLE(%TriggerSource='Field')
       #BOXED('')
        #PROMPT('Field:',FIELD),%TriggerSourceField,REQ
       #ENDBOXED
      #ENDENABLE
      #BUTTON('Recipients'),MULTI(%TriggerRecipient,%TriggerRecipientAddress),AT(,,180)
       #PROMPT('Address:',@s150),%TriggerRecipientAddress,REQ
       #PROMPT('Name:',@s150),%TriggerRecipientName
       #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%TriggerRecipClass
      #ENDBUTTON
      #BOXED('Fields to watch')
       #BOXED,WHERE(%Trigger='Per Column Change')
        #BUTTON('Fields'),MULTI(%TriggerFields,%TriggerFieldName),INLINE
         #PROMPT('Fieldname:',FIELD(%File)),%TriggerFieldName,REQ
         #ENABLE(%Trigger='Per Column Change')
          #PROMPT('Subject:',@s200),%TriggerColumnDocSubject,REQ,DEFAULT(%TriggerSubject)
          #PROMPT('Content Type:',DROP('Html|Plain Text')),%TriggerColumnContent,DEFAULT(%TriggerContent)
          #PROMPT('Message Body Source:',DROP('Field|File')),%TriggerColumnSource,DEFAULT(%TriggerSource)
          #ENABLE(%TriggerColumnSource='File')
           #BOXED('')
            #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%TriggerColumnSourceFile,DEFAULT(%TriggerSourceFile)
            #ENABLE(%DocumentMergingSupport)
             #PROMPT('Use skeleton to Merge document?',CHECK),%MergeColumnDocument,AT(10),DEFAULT(%MergeDocument)
            #ENDENABLE
           #ENDBOXED
          #ENDENABLE
          #ENABLE(%TriggerColumnSource='Field')
           #BOXED('')
            #PROMPT('Field:',FIELD),%TriggerColumnSourceField,REQ,DEFAULT(%TriggerSourceField)
           #ENDBOXED
          #ENDENABLE
         #ENDENABLE
        #ENDBUTTON
       #ENDBOXED
      #ENDBOXED
     #ENDTAB
     #TAB('Insert Trigger'),WHERE(%InsertTrigger)
      #PROMPT('Subject:',@s200),%InsertTriggerSubject,REQ
      #PROMPT('Content Type:',DROP('Html|Plain Text')),%InsertTriggerContent,DEFAULT('Html')
      #PROMPT('Message Body Source:',DROP('Field|File')),%InsertTriggerSource,DEFAULT('File')
      #ENABLE(%InsertTriggerSource='File')
       #BOXED('')
        #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%InsertTriggerSourceFile
        #ENABLE(%DocumentMergingSupport)
         #PROMPT('Use skeleton to Merge document?',CHECK),%MergeInsertDocument,AT(10)
        #ENDENABLE
       #ENDBOXED
      #ENDENABLE
      #ENABLE(%InsertTriggerSource='Field')
       #BOXED('')
        #PROMPT('Field:',FIELD),%InsertTriggerSourceField,REQ
       #ENDBOXED
      #ENDENABLE
      #BUTTON('Recipients'),MULTI(%InsertTriggerRecipient,%InsertTriggerRecipientAddress),AT(,,180)
       #PROMPT('Address:',@s150),%InsertTriggerRecipientAddress,REQ
       #PROMPT('Name:',@s150),%InsertTriggerRecipientName
       #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%InsertTriggerRecipClass
      #ENDBUTTON
     #ENDTAB
     #TAB('Delete Trigger'),WHERE(%DeleteTrigger)
      #PROMPT('Subject:',@s200),%DeleteTriggerSubject,REQ
      #PROMPT('Content Type:',DROP('Html|Plain Text')),%DeleteTriggerContent,DEFAULT('Html')
      #PROMPT('Message Body Source:',DROP('Field|File')),%DeleteTriggerSource,DEFAULT('File')
      #ENABLE(%DeleteTriggerSource='File')
       #BOXED('')
        #PROMPT('File:',OPENDIALOG('Select content file', 'Html File (*.htm)|*.htm|Text Files (*.txt)|*.txt|All Files (*.*)|*.*')),%DeleteTriggerSourceFile
        #ENABLE(%DocumentMergingSupport)
         #PROMPT('Use skeleton to Merge document?',CHECK),%MergeDeleteDocument,AT(10)
        #ENDENABLE
       #ENDBOXED
      #ENDENABLE
      #ENABLE(%DeleteTriggerSource='Field')
       #BOXED('')
        #PROMPT('Field:',FIELD),%DeleteTriggerSourceField,REQ
       #ENDBOXED
      #ENDENABLE
      #BUTTON('Recipients'),MULTI(%DeleteTriggerRecipient,%DeleteTriggerRecipientAddress),AT(,,180)
       #PROMPT('Address:',@s150),%DeleteTriggerRecipientAddress,REQ
       #PROMPT('Name:',@s150),%DeleteTriggerRecipientName
       #PROMPT('Recipient Class:',COMBO(%cRecipClass)),%DeleteTriggerRecipClass
      #ENDBUTTON
     #ENDTAB
     #TAB('Information'),WHERE(~%ChangeTrigger AND ~%InsertTrigger AND ~%DeleteTrigger)
      #BOXED('')
       #DISPLAY('No triggers have been specified for this file.')
       #DISPLAY('Check the actions that you''d like messages to trigger on.')
      #ENDBOXED
     #ENDTAB
     #ENDSHEET
    #ENDBUTTON
   #ENDBOXED
   #BOXED('Missing Global Template'),WHERE(~%DbAuditingSupport),AT(10,10)
    #DISPLAY('File Trigger are only enabled if the DbAuditing')
    #DISPLAY('global extension is added.')
   #ENDBOXED
#!
#ATSTART
  #DECLARE(%TplInstance)
  #CALL(%FindGlobalTemplateInstance(ABC), 'DbAuditing(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%DbAuditingSupport,%True)
  #ELSE
    #SET(%DbAuditingSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'FileUserTags(ABC)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%FileUserTagsSupport,%True)
  #ELSE
    #SET(%FileUserTagsSupport,%False)
  #ENDIF
  #CALL(%FindGlobalTemplateInstance(ABC), 'GenericSkeletonClasses(Skeletons)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%GenericSkeletonsSupport,%True)
  #ELSE
    #SET(%GenericSkeletonsSupport,%False)
  #ENDIF
  #IF(%GenericSkeletonsSupport AND %FileUserTagsSupport)
    #SET(%DocumentMergingSupport,%True)
  #ELSE
    #SET(%DocumentMergingSupport,%False)
  #ENDIF
#ENDAT
#!
#AT(%DbAuditMethodCodeSection,'OnFieldChange'),PRIORITY(6500)
#SUSPEND
#?CASE FileName
#FOR(%File),WHERE(%ChangeTrigger)
#INSERT(%DbChange,'Field')
#?END
#ENDFOR
#PRIORITY(7000)
#INSERT(%DBSend)
#RESUME
#ENDAT
#!
#AT(%DbAuditMethodCodeSection,'OnChange'),PRIORITY(6500)
#SUSPEND
#?CASE FileName
#FOR(%File),WHERE(%ChangeTrigger)
#INSERT(%DbChange,'File')
#ENDFOR
#?END
#PRIORITY(7000)
#INSERT(%DBSend)
#RESUME
#ENDAT
#!
#AT(%DbAuditMethodCodeSection,'OnDelete'),PRIORITY(6500)
#SUSPEND
#?CASE FileName
#FOR(%File),WHERE(%DeleteTrigger)
OF '%File'
  %DbMessageObjectName.Description = %(%StripPling(%DeleteTriggerSubject))
  #FOR(%DeleteTriggerRecipient)
  IF %(%StripPling(%DeleteTriggerRecipientAddress))
    %DbAddressesObjectName.AddRecipient(%(%StripPling(%DeleteTriggerRecipientAddress)), %(%StripPling(%DeleteTriggerRecipientName)), %DeleteTriggerRecipClass, SMTP,)
  END
  #ENDFOR
  #IF(%DeleteTriggerSource='File')
   #IF(%DeleteTriggerSourceFile)
    #IF(UPPER(%DeleteTriggerContent)='HTML')
  %DbMessageObjectName.AddBodyFromFile('%DeleteTriggerSourceFile',Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
    #ELSE
  %DbMessageObjectName.AddBodyFromFile('%DeleteTriggerSourceFile',Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
    #ENDIF
   #ENDIF
  #ELSE
   #IF(%DeleteTriggerSourceField)
    #IF(UPPER(%InsertTriggerContent)='HTML')
  %DbMessageObjectName.AddBody(%DeleteTriggerSourceField,Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
    #ELSE
  %DbMessageObjectName.AddBody(%DeleteTriggerSourceField,Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
    #ENDIF
   #ENDIF
  #ENDIF
  #IF(%DeleteTriggerSourceFile AND %DeleteTriggerSource='File' AND %MergeDeleteDocument AND %DocumentMergingSupport)
   #INSERT(%MergeAndGenerate(Skeletons),%DeleteTriggerSourceFile,%DeleteTriggerSourceFile, '')
  #ENDIF
  SendDocument = True
#ENDFOR
#?END
#RESUME
#ENDAT
#!
#AT(%DbAuditMethodCodeSection,'OnInsert'),PRIORITY(6500)
#SUSPEND
#?CASE FileName
#FOR(%File),WHERE(%InsertTrigger)
OF '%File'
  %DbMessageObjectName.Description = %(%StripPling(%InsertTriggerSubject))
  #FOR(%InsertTriggerRecipient)
  IF %(%StripPling(%InsertTriggerRecipientAddress))
    %DbAddressesObjectName.AddRecipient(%(%StripPling(%InsertTriggerRecipientAddress)), %(%StripPling(%InsertTriggerRecipientName)), %InsertTriggerRecipClass, SMTP,)
  END
  #ENDFOR
  #IF(%InsertTriggerSource='File')
   #IF(%InsertTriggerSourceFile)
    #IF(UPPER(%InsertTriggerContent)='HTML')
  %DbMessageObjectName.AddBodyFromFile('%InsertTriggerSourceFile',Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
    #ELSE
  %DbMessageObjectName.AddBodyFromFile('%InsertTriggerSourceFile',Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
    #ENDIF
   #ENDIF
  #ELSE
   #IF(%InsertTriggerSourceField)
    #IF(UPPER(%InsertTriggerContent)='HTML')
  %DbMessageObjectName.AddBody(%InsertTriggerSourceField,Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
    #ELSE
  %DbMessageObjectName.AddBody(%InsertTriggerSourceField,Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
    #ENDIF
   #ENDIF
  #ENDIF
  #IF(%InsertTriggerSourceFile AND %InsertTriggerSource='File' AND %MergeInsertDocument AND %DocumentMergingSupport)
   #INSERT(%MergeAndGenerate(Skeletons),%InsertTriggerSourceFile,%InsertTriggerSourceFile, '')
  #ENDIF
  SendDocument = True
#ENDFOR
#?END
#RESUME
#ENDAT
#!
#GROUP(%DbChange,%ChangeType)
#SUSPEND
#?OF '%File'
  #IF(%Trigger='Per Row Change' AND %ChangeType='File')
   #FOR(%TriggerRecipient)
  #?IF %(%StripPling(%TriggerRecipientAddress))
    #?%DbAddressesObjectName.AddRecipient(%(%StripPling(%TriggerRecipientAddress)), %(%StripPling(%TriggerRecipientName)), %TriggerRecipClass, SMTP,)
  #?END
   #ENDFOR
  #?%DbMessageObjectName.Description = %(%StripPling(%TriggerSubject))
   #IF(%TriggerSource='File')
    #IF(%TriggerSourceFile)
     #IF(UPPER(%TriggerContent)='HTML')
  %DbMessageObjectName.AddBodyFromFile('%TriggerSourceFile',Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
     #ELSE
  %DbMessageObjectName.AddBodyFromFile('%TriggerSourceFile',Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
     #ENDIF
    #ENDIF
   #ELSE
    #IF(%TriggerSourceField)
     #IF(UPPER(%TriggerContent)='HTML')
  %DbMessageObjectName.AddBody(%TriggerSourceField,Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
     #ELSE
  %DbMessageObjectName.AddBody(%TriggerSourceField,Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
     #ENDIF
    #ENDIF
   #ENDIF
   #IF(%TriggerSourceFile AND %TriggerSource='File' AND %MergeDocument AND %DocumentMergingSupport)
  #INSERT(%MergeAndGenerate(Skeletons),%TriggerSourceFile,%TriggerSourceFile, '')
   #ENDIF
  #?  SendDocument = True
  #ENDIF
   #IF(%Trigger='Per Column Change' AND %ChangeType='Field')
#?  CASE FieldName
   #FOR(%TriggerFields)
    #IF(%TriggerColumnDocSubject)
    OF UPPER('%TriggerFieldName')
     %DbMessageObjectName.Description = %(%StripPling(%TriggerColumnDocSubject))
    #ENDIF
    #IF(%TriggerColumnSource='File')
     #IF(%TriggerColumnSourceFile)
      #IF(UPPER(%TriggerColumnContent)='HTML')
     %DbMessageObjectName.AddBodyFromFile('%TriggerColumnSourceFile',Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
      #ELSE
     %DbMessageObjectName.AddBodyFromFile('%TriggerColumnSourceFile',Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
      #ENDIF
     #ENDIF
    #ELSE
     #IF(%TriggerColumnSourceField)
      #IF(UPPER(%InsertTriggerContent)='HTML')
     %DbMessageObjectName.AddBody(%TriggerColumnSourceField,Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
      #ELSE
     %DbMessageObjectName.AddBody(%TriggerColumnSourceField,Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
      #ENDIF
     #ENDIF
    #ENDIF
    #IF(%TriggerColumnSourceFile AND %TriggerColumnSource='File' AND %MergeColumnDocument AND %DocumentMergingSupport)
     #INSERT(%MergeAndGenerate(Skeletons),%TriggerColumnSourceFile,%TriggerColumnSourceFile, '')
    #ENDIF
     #?SendDocument = True
   #ENDFOR
#?  END
  #?IF SendDocument
  #FOR(%TriggerRecipient)
    #?IF %(%StripPling(%TriggerRecipientAddress))
      #?%DbAddressesObjectName.AddRecipient(%(%StripPling(%TriggerRecipientAddress)), %(%StripPling(%TriggerRecipientName)), %TriggerRecipClass, SMTP,)
    #?END
  #ENDFOR
  #?END
  #ENDIF
#RESUME
#!
#GROUP(%GetEmbedTreeDesc,%EmbedType,%ProcedureSection,%AdditionalLevels=''),AUTO
  #DECLARE(%RVal)
  #CALL(%GetEmbedTreeDesc(ABC), %EmbedType, %ProcedureSection, %AdditionalLevels),%RVal
  #RETURN(%RVal)
#!
#!
#GROUP(%MethodEmbedPointValid, %MustBeVirtual = %True),AUTO
  #DECLARE(%RVal)
  #CALL(%MethodEmbedPointValid(ABC), %MustBeVirtual),%RVal
  #RETURN(%RVal)
#!
#!------GROUPS
#GROUP(%DBSend)
#?IF SendDocument
  #? %SMTPObjectName.SetIAB(%DbAddressesObjectName.IABook)
  #? %DbMessageObjectName.Send()
  #? %DbAddressesObjectName.FreeRecipients()
  #? %DbMessageObjectName.FreeAttachments()
  #? SendDocument = False
#?END
#!
#GROUP(%SendDocGrp,%gSubject,%gRecipientAddress,%gRecipientName,%gRecipClass,%gBody,%gContent)
  %DbMessageObjectName.Description = %(%StripPling(%gSubject))
  IF %(%StripPling(%gRecipientAddress))
    %DbAddressesObjectName.AddRecipient(%(%StripPling(%gRecipientAddress)), %(%StripPling(%gRecipientName)), %gRecipClass, SMTP,)
  END
  #IF(%gBody)
   #IF(UPPER(%gContent)='HTML')
  %DbMessageObjectName.AddBodyFromFile('%gBody',Content:text,SubType:html, %QuotedPrintableObjectName.IEncoder)
   #ELSE
  %DbMessageObjectName.AddBodyFromFile('%gBody',Content:text,SubType:plain, %QuotedPrintableObjectName.IEncoder)
   #ENDIF
  #ENDIF
  %SMTPObjectName.SetIAB(%DbAddressesObjectName.IABook)
  %DbMessageObjectName.Send()
  %DbAddressesObjectName.FreeRecipients()
  %DbMessageObjectName.FreeAttachments()
#!
#GROUP(%GetTriggerDescription)
#DECLARE(%TriggerDescription)
 #SET(%TriggerDescription,'')
 #IF(%ChangeTrigger OR %InsertTrigger OR %DeleteTrigger)
  #SET(%TriggerDescription,'Trigger -> ' & %File)
 #ELSE
  #SET(%TriggerDescription,'    No Triggers(' & %File & ')')
 #END
 #RETURN %TriggerDescription
#!
#GROUP(%LoadComboValues)
  #DECLARE(%cRecipClass),MULTI
  #DECLARE(%cTransports),MULTI
  #DECLARE(%cPriority),MULTI
  #FREE(%cRecipClass)
  #ADD(%cRecipClass,'SendTo')
  #ADD(%cRecipClass,'CC')
  #ADD(%cRecipClass,'BCC')
  #FREE(%cTransports)
  #ADD(%cTransports,'SMTP')
  #ADD(%cTransports,'NNTP')
  #FREE(%cPriority)
  #ADD(%cPriority,'High')
  #ADD(%cPriority,'Normal')
  #ADD(%cPriority,'Low')
#!
#GROUP(%ExternalObjectDecl,%Tag)
 #DECLARE(%ThisClassToUse)
 #CALL(%SetClassItem(ABC), %Tag)
 #SET(%ThisClassToUse,%BaseClassToUse())
 #CALL(%AddModuleIncludeFile(ABC), %BaseClassToUse())
 #IF(%ExternalSource='Dynamic Link Library (DLL)')
%[20]ThisObjectName &%ThisClassToUse,EXTERNAL
 #ELSE
%[20]ThisObjectName &%ThisClassToUse,EXTERNAL!,DLL(dll_mode)
 #ENDIF
#!
#GROUP(%AddExpItem,%Tag)
 #CALL(%SetClassItem(ABC), %Tag)
#INSERT(%AddExpItem(ABC),'$' & %ThisObjectName)