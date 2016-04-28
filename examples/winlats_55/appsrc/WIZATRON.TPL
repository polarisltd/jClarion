#TEMPLATE(Wizatrons,'Wizatron driver'),FAMILY('ABC')
#!
#UTILITY(WizardConfiguration,'Configure Wizatrons')
#EQUATE(%WCFName, FULLNAME('WIZARD.WCF', 2))
#CALL(%GenerateCfgWizatronWCF, %WCFName)
#CALL(%CallWizatron, %WCFName)
#!
#GROUP(%GenerateCfgWizatronWCF, %WCFName)
#CREATE(%WCFName)
[GENERAL]
DEFEDIT
#CLOSE(%WCFName)
#!
#!
#!
#!
#UTILITY(ApplicationWizatron,'Create New Application'),QUICK(Application(ABC))
#!
#INSERT(%QuickPrompts)
#PROMPT('&Clear Globals?',CHECK),%ClearApp,DEFAULT(%True)
#!
#EQUATE(%WCFName, FULLNAME('WIZARD.WCF', 2))
#EQUATE(%TXAPath,FULLNAME('TST.TXA',2))
#SET(%TXAPath,SLICE(%TXAPath,1,INSTRING('\TST.TXA',%TXAPath,1,1)))
#CALL(%WizatronGenerateTXD)
#CALL(%GenerateAppWizatronWCF, %WCFName, %TXAPath)
#CALL(%CallWizatron, %WCFName)
#CALL(%WizatronImportTXA,%TXAPath,%ClearApp)
#!
#GROUP(%GenerateAppWizatronWCF, %WCFName, %TXAPath)
#EQUATE(%GeneralSection, 'APPWIZARD(Application),NAME(TstApp),DESTPATH(' & %TXAPath & '),TXD(' & FULLNAME('WIZARD.TXD',1) & ')')
#EQUATE(%ApplicationSection, 'AppFilename(' & %Application & '),Dictionary(' & %DictionaryFile & ')')
#EQUATE(%ProcedureSection, '')
#INSERT(%SetQuickStartOptions, 'TOPSPEED:Application')
#CALL(%WriteWCF)
#!
#!
#!
#!
#UTILITY(BrowseWizatron, 'Create New Browse Procedure'),QUICK(Browse(ABC))
#!
#PROMPT('File to Browse:',FILE),%QuickPrimaryFile,REQ
#INSERT(%QuickPrompts)
#!
#EQUATE(%WCFName, FULLNAME('WIZARD.WCF', 2))
#EQUATE(%TXAPath,FULLNAME('TST.TXA',2))
#SET(%TXAPath,SLICE(%TXAPath,1,INSTRING('\TST.TXA',%TXAPath,1,1)))
#CALL(%WizatronGenerateTXD)
#CALL(%GenerateBrwWizatronWCF, %WCFName, %TXAPath)
#CALL(%CallWizatron, %WCFName)
#CALL(%WizatronImportTXA,%TXAPath)
#!
#GROUP(%GenerateBrwWizatronWCF, %WCFName, %TXAPath)
#EQUATE(%GeneralSection, 'APPWIZARD(Application),PROCWIZARD(Browse),NAME(TstApp),DESTPATH(' & %TXAPath & '),TXD(' & FULLNAME('WIZARD.TXD',1) & ')')
#EQUATE(%ApplicationSection, 'AppFilename(' & %Application & '),Dictionary(' & %DictionaryFile & ')')
#EQUATE(%ProcedureSection, 'PrimaryFile(' & %QuickPrimaryFile & ')')
#IF(%QuickProcedure)
  #SET(%ProcedureSection, %ProcedureSection & 'Output.ProcName(' & %QuickProcedure & ')')
#ENDIF
#INSERT(%SetQuickStartOptions, 'TOPSPEED:Browse')
#CALL(%WriteWCF)
#!
#!
#!
#!
#UTILITY(FormWizatron, 'Create New Form Update Procedure'),QUICK(Form(ABC))
#!
#PROMPT('File to Update:',FILE),%QuickPrimaryFile,REQ
#INSERT(%QuickPrompts)
#!
#EQUATE(%WCFName, FULLNAME('WIZARD.WCF', 2))
#EQUATE(%TXAPath,FULLNAME('TST.TXA',2))
#SET(%TXAPath,SLICE(%TXAPath,1,INSTRING('\TST.TXA',%TXAPath,1,1)))
#CALL(%WizatronGenerateTXD)
#CALL(%GenerateFrmWizatronWCF, %WCFName, %TXAPath)
#CALL(%CallWizatron, %WCFName)
#CALL(%WizatronImportTXA,%TXAPath)
#!
#GROUP(%GenerateFrmWizatronWCF, %WCFName, %TXAPath)
#EQUATE(%GeneralSection, 'APPWIZARD(Application),PROCWIZARD(Form),NAME(TstApp),DESTPATH(' & %TXAPath & '),TXD(' & FULLNAME('WIZARD.TXD',1) & ')')
#EQUATE(%ApplicationSection, 'AppFilename(' & %Application & '),Dictionary(' & %DictionaryFile & ')')
#EQUATE(%ProcedureSection, 'PrimaryFile('  & %QuickPrimaryFile & ')')
#IF(%QuickProcedure)
  #SET(%ProcedureSection, %ProcedureSection & 'Output.ProcName(' & %QuickProcedure & ')')
#ENDIF
#INSERT(%SetQuickStartOptions, 'TOPSPEED:Form')
#CALL(%WriteWCF)
#!
#!
#!
#!
#GROUP(%WizatronGenerateTXD)
#CREATE('WIZARD.TXD')
#EXPORT(%DictionaryFile)
#CLOSE('WIZARD.TXD')
#!
#!
#GROUP(%WizatronImportTXA,%TXAPath,%ClearApp = %False)
#IF(FILEEXISTS(%TXAPath&'WIZARD01.TXA'))
  #IF(%ClearApp)
    #IMPORT(%TXAPath & 'WIZARD01.TXA'),REPLACE,APPLICATION
  #ELSE
    #IMPORT(%TXAPath & 'WIZARD01.TXA'),REPLACE
  #ENDIF
#ENDIF
#!
#!
#GROUP(%CallWizatron, %WCFName)
#EQUATE (%SkeletonPath, FULLNAME('window.htm', 1))
#EQUATE (%SkeletonSlash, INSTRING('\',%SkeletonPath,-1,LEN(%SkeletonPath)))
#SET (%SkeletonPath, SUB(%SkeletonPath, 1, %SkeletonSlash))
#EQUATE (%TargetPath, FULLNAME('*.htm', 2))
#EQUATE (%TargetSlash, INSTRING('\',%TargetPath,-1,LEN(%TargetPath)))
#SET (%TargetPath, SUB(%TargetPath, 1, %TargetSlash))
#RUN('WIZARDX.EXE "' & %WCFName & '" "' & %SkeletonPath & '" "' & %TargetPath & '"'),WAIT
#REMOVE(%WCFName)
#!
#!
#GROUP(%QuickPrompts)
#PROMPT('Create a QuickStart View?', CHECK),%QuickStart,DEFAULT(%True)
#ENABLE(%QuickStart = %True)
  #PROMPT('&Quick Start Set:', @S255),%QuickStartSet,DEFAULT('TOPSPEED:Default'),REQ
  #PROMPT('&Generate After QuickStart', CHECK),%QuickFinish,DEFAULT(%False)
#ENDENABLE
#!
#!
#GROUP(%SetQuickStartOptions, %QS)
#IF(%QuickStart)
  #SET(%GeneralSection, %GeneralSection & ',QUICKSTART(' & %QS & ',' & %QuickStartSet & CHOOSE(%QuickFinish = %True, ',FINISH)', ')'))
#ENDIF
#!
#!
#GROUP(%WriteWCF)
#CREATE(%WCFName)
[GENERAL]
%GeneralSection
[APPLICATION]
%ApplicationSection
[PROCEDURE]
%ProcedureSection
#CLOSE(%WCFName)
#!
#!
