#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#HELP('C55HELP.HLP')
#!
#!
#SYSTEM
  #TAB('&Embed Tree Options')
    #BOXED('&Options'),AT(12,,216)
      #PROMPT('Show &PROCEDURE Keyword',CHECK),%ShowPROCEDUREonEmbeds,DEFAULT(%True),AT(10,14)
      #PROMPT('Show &VIRTUAL Keyword',CHECK),%ShowVIRTUALonEmbeds,DEFAULT(%True),AT(10)
      #PROMPT('Show P&ROTECTED Keyword',CHECK),%ShowPROTECTEDonEmbeds,DEFAULT(%True),AT(10)
      #PROMPT('Show &Base Class',CHECK),%ShowBaseClassOnEmbeds,DEFAULT(%True),AT(10)
      #PROMPT('Show Object &Description',CHECK),%ShowDescriptionOnEmbeds,DEFAULT(%True),AT(10)
      #PROMPT('Show D&etails',CHECK),%ShowDetailsOnEmbeds,DEFAULT(%True),AT(10)
      #PROMPT('&Color Entries',CHECK),%ColorEntriesOnEmbeds,DEFAULT(%True),AT(10)
    #ENDBOXED
    #BOXED('&Colors'),AT(12,,216),WHERE(%ColorEntriesOnEmbeds)
      #PROMPT('&DATA Sections',COLOR),%ColorDataSection,DEFAULT(00000FFH)
      #PROMPT('&CODE Sections',COLOR),%ColorCodeSection,DEFAULT(0FF0000H)
      #PROMPT('&VIRTUAL Methods',COLOR),%ColorVirtualMethod,DEFAULT(0008000H)
      #PROMPT('&PROTECTED Methods',COLOR),%ColorProtectedMethod,DEFAULT(00000FFH)
      #PROMPT('&New Methods',COLOR),%ColorNewMethod,DEFAULT(0FF00FFH)
    #ENDBOXED
  #ENDTAB
#!
#CALL(%DeclareClassGlobals)
#!
#DECLARE (%SysActiveInvisible)               #!These variables store the 'system default values' of user configurable options
#DECLARE (%SysAllowUnfilled)
#DECLARE (%SysRetainRow)
#DECLARE (%SysResetOnGainFocus)
#DECLARE (%SysAutoToolbar)
#DECLARE (%SysAutoRefresh)
#!
#!
#!
#!
#APPLICATION('CW Default Application'),HLP('~TPLApplication')
#!------------------------------------------------------------------------------
#!                          Template Release 5.0
#!------------------------------------------------------------------------------
#! C55 Application Template
#!------------------------------------------------------------------------------
#!
#! These are the Clarion 5.5 Templates.  The #PROCEDURE templates
#! included in this template set are:
#!
#! ToDo     - A default "Under Construction" procedure
#! Window   - A general purpose window handling procedure
#!  Browse  - Window copied for Browse grouping
#!  Form    - Window copied for Form grouping
#!  Frame   - Window copied for Frame grouping
#!  Menu    - Window copied for Menu grouping
#! Process  - A general purpose sequential record handler
#!  Report  - A general purpose Report engine based upon sequential record handler
#! Source   - A generic source procedure - Embed points only
#!
#!------------------------------------------------------------------------------
#!
#! Global Prompts
#!
#!------------------------------------------------------------------------------
#!
#PREPARE
  #CALL(%ReadABCFiles)
  #CALL(%SetupGlobalObjects)
#ENDPREPARE
#INSERT(%OOPPrompts)
#SHEET,HSCROLL
  #TAB('&General'),HLP('~TPLApplication_General')
    #PROMPT('Program &Author:',@s40),%ProgramAuthor,AT(,15),PROMPTAT(,15)
    #PROMPT('&Use field description as MSG() when MSG() is blank',CHECK),%MessageDescription,DEFAULT(%True),AT(10,,180)
    #PROMPT('&Generate template globals and ABC''s as EXTERNAL',CHECK),%GlobalExternal,AT(10,,180)
    #ENABLE(%GlobalExternal)
      #PROMPT('E&xternal Globals and ABC''s Source Module',OPTION),%ExternalSource,AT(,,180),DEFAULT('Dynamic Link Library (DLL)')
      #PROMPT('&Dynamic Link Library (DLL)',RADIO)
      #PROMPT('&Statically Linked Library (LIB)',RADIO)
    #ENDENABLE
    #PROMPT('Generate EMBED &Comments',CHECK),%GenerateEmbedComments,AT(10,,180)
    #BOXED('.INI File Settings'),AT(10,,180)
      #PROMPT('&Use .INI file to save and restore program settings',CHECK),%INIActive,AT(10,,170)
      #ENABLE(%INIActive)
        #PROMPT('.&INI File to use:',DROP('Program Name.INI|Other')),%INIFile
        #ENABLE(%INIFile='Other')
          #PROMPT('&Other File Name:',@S255),%ININame
        #ENDENABLE
        #BUTTON('&Preserve'),MULTI(%PreserveVars,'Preserve - '&%PreserveVar)
          #PROMPT('Variable :',FROM(%GlobalData)),%PreserveVar
        #ENDBUTTON
      #ENDENABLE
    #ENDBOXED
    #PROMPT('Enable Run-Time &Translation',CHECK),%EnableRunTimeTranslator,AT(10)
    #PROMPT('Enable &Fuzzy Matching', CHECK),%FuzzyMatchingEnabled,DEFAULT(%True),AT(10)
    #BOXED('Fuzzy Matching Options'),WHERE(%FuzzyMatchingEnabled)
      #PROMPT('Ignore &Case', CHECK),%IgnoreCase,DEFAULT(%True),AT(10)
      #PROMPT('&Word Only', CHECK),%WordOnly,DEFAULT(%False),AT(10)
    #ENDBOXED
    #PROMPT('Enable Window Frame Dragging',CHECK),%WindowFrameDragging,DEFAULT(1),AT(10)
  #ENDTAB
  #TAB('&File Control'),HLP('~TPLApplication_FileControlFlags')
    #PROMPT('&Generate all file declarations',CHECK),%DefaultGenerate,AT(10,15,180),PROMPTAT(,15)
    #PROMPT('&Enclose RI code in transaction frame',CHECK),%DefaultRILogout,DEFAULT(1),AT(10,,180)
    #PROMPT('&Seconds for RECOVER:',SPIN(@N3,1,120,1)),%LockRecoverTime,DEFAULT(10)
    #BOXED('File Attributes')
      #PROMPT('&Threaded:',DROP('Use File Setting|All Threaded|None Threaded')),%DefaultThreaded,DEFAULT('Use File Setting')
      #PROMPT('&Create:',DROP('Use File Setting|Create All|Create None')),%DefaultCreate,DEFAULT('Use File Setting')
      #PROMPT('E&xternal:',DROP('All External|None External')),%DefaultExternal,DEFAULT('None External')
      #BOXED,SECTION
        #BOXED('External Files'),WHERE(%DefaultExternal = 'All External'),AT(,0)
          #PROMPT('Dec&laring Module:',@S255),%DefaultExternalSource
          #PROMPT('All &files are declared in another .APP',CHECK),%DefaultExternalAPP,AT(15,,156)
        #ENDBOXED
        #BOXED('Export Files'),WHERE(%DefaultExternal = 'None External' AND %ProgramExtension='DLL'),AT(,0)
          #PROMPT('Ex&port all file declarations',CHECK),%DefaultExport,AT(25,,156)
        #ENDBOXED
      #ENDBOXED
    #ENDBOXED
    #BOXED('File Access')
      #PROMPT('File Open &Mode:',DROP('Share|Open|Other')),%DefaultOpenMode,DEFAULT('Share')
      #ENABLE(%DefaultOpenMode='Other')
        #BOXED('Other Open Mode')
          #PROMPT('&User Access:',DROP('Read/Write|Read Only|Write Only')),%DefaultUserAccess,DEFAULT('Read/Write')
          #PROMPT('Ot&her Access:',DROP('Deny None|Deny Read|Deny Write|Deny All|Any Access')),%DefaultOtherAccess,DEFAULT('Deny None')
        #ENDBOXED
      #ENDENABLE
      #PROMPT('&Defer opening files until accessed',CHECK),%DefaultLazyOpen,DEFAULT(%True),AT(10)
    #ENDBOXED
  #ENDTAB
  #TAB('&Individual File Overrides'),HLP('~TPLApplication_IndividualFileOverrides')
    #BUTTON('Individual File Overrides for '&%File&' file'),FROM(%File,%File & ' - ' & %FileDescription),AT(10,15,180),HLP('~TPLApplication'),INLINE,SORT,HLP('~TPLApplication_IndividualFileOverrides')
      #PROMPT('&Generate file declaration',CHECK),%OverrideGenerate,AT(10,,180)
      #PROMPT('Us&e RI transaction frame',DROP('Use Default|Yes|No')),%OverrideRILogout,DEFAULT('Use Default')
      #BUTTON('&File Manager Options for ' & %File),AT(,,180)
        #WITH(%ClassItem, 'FileManager:' & %File)
          #INSERT(%GlobalClassPrompts)
        #ENDWITH
      #ENDBUTTON
      #BUTTON('&Relation Manager Options for ' & %File),AT(,,180)
        #WITH(%ClassItem, 'RelationManager:' & %File)
          #INSERT(%GlobalClassPrompts)
        #ENDWITH
      #ENDBUTTON
      #BOXED('File Attributes')
        #PROMPT('&Threaded:',DROP('Use Default|Use File Setting|Threaded|Not Threaded')),%OverrideThreaded,DEFAULT('Use Default')
        #PROMPT('&Create:',DROP('Use Default|Use File Setting|Create File|Do Not Create File')),%OverrideCreate,DEFAULT('Use Default')
        #PROMPT('E&xternal:',DROP('Use Default|External|Not External')),%OverrideExternal,DEFAULT('Use Default')
        #BOXED,SECTION
          #BOXED('External File'),WHERE(%OverrideExternal = 'External'),AT(,0)
            #PROMPT('Dec&laring Module:',@S255),%OverrideExternalSource
            #PROMPT('The &file is declared in another .APP',CHECK),%OverrideExternalAPP,AT(15,,156)
          #ENDBOXED
          #BOXED('Export File'),WHERE((%OverrideExternal='Not External' OR (%OverrideExternal='Use Default' AND %DefaultExternal='None External')) AND %ProgramExtension='DLL'),AT(,0)
            #PROMPT('Ex&port file declaration',CHECK),%OverrideExport,AT(25,,156)
          #ENDBOXED
        #ENDBOXED
      #ENDBOXED
      #PROMPT('File De&claration Mode:', DROP('Use User Options|As FILE|As GROUP|As QUEUE')),%FileDeclarationMode,DEFAULT('Use User Options')
      #BOXED,SECTION
        #BOXED('File Declaration A&ttributes'),WHERE(%GetFileDeclareMode() <> 'FILE'),AT(,0)
          #ENABLE(%FileDeclarationType = %False),CLEAR
            #PROMPT('THREAD', CHECK),%FileDeclarationThread,DEFAULT(%GetFileThreaded())
            #PROMPT('BINDABLE', CHECK),%FileDeclarationBindable,DEFAULT(%True)
            #PROMPT('NAME',@S255),%FileDeclarationName
            #ENABLE(%GetFileDeclareMode() = 'GROUP'),CLEAR
              #PROMPT('OVER',@S255),%FileDeclarationOver
            #ENDENABLE
          #ENDENABLE
          #ENABLE(%FileDeclarationThread = %False AND %FileDeclarationBindable = %False AND %FileDeclarationName = ''),CLEAR
            #PROMPT('TYPE',CHECK),%FileDeclarationType,DEFAULT(%False)
          #ENDENABLE
        #ENDBOXED
        #BOXED('File Access'),WHERE(%GetFileDeclareMode() = 'FILE'),AT(,0)
          #PROMPT('File Open &Mode:',DROP('Use Default|Share|Open|Other')),%OverrideOpenMode,DEFAULT('Use Default')
          #ENABLE(%OverRideOpenMode = 'Other')
            #BOXED('Other Open Mode')
              #PROMPT('&User Access:',DROP('Use Default|Read/Write|Read Only|Write Only')),%OverrideUserAccess,DEFAULT('Use Default')
              #PROMPT('Ot&her Access:',DROP('Use Default|Deny None|Deny Read|Deny Write|Deny All|Any Access')),%OverrideOtherAccess,DEFAULT('Use Default')
            #ENDBOXED
          #ENDENABLE
          #PROMPT('&Defer Opening File:',DROP('Use Default[Use Default]|Yes[Yes]|No[No]')),%OverrideLazyOpen,DEFAULT('Use Default')
        #ENDBOXED
      #ENDBOXED
    #ENDBUTTON
  #ENDTAB
  #TAB('External &Module Options'),WHERE(%AppContainsExternalLibs()),HLP('~TPLApplication_External')
    #BUTTON('External Module Options'),FROM(%Module,%Module&'  ( '&%ModuleTemplate&' )'),INLINE,WHERE(%ModuleTemplate='ExternalLIB(ABC)' OR %ModuleTemplate='ExternalDLL(ABC)')
      #PROMPT('Standard Clarion 5 LIB/DLL?',CHECK),%StandardExternalModule,DEFAULT(%True),AT(10)
    #ENDBUTTON
  #ENDTAB
  #TAB('Global &Objects')
    #PROMPT('Don''t generate globals', CHECK),%NoGenerateGlobals,AT(10)
    #BUTTON('&Error Manager'),AT(,,170)
      #WITH(%ClassItem, 'ErrorManager')
        #INSERT(%GlobalClassPrompts)
      #ENDWITH
    #ENDBUTTON
    #BUTTON('&INI File Manager'),AT(,,170)
      #WITH(%ClassItem, 'INIManager')
        #INSERT(%GlobalClassPrompts)
      #ENDWITH
    #ENDBUTTON
    #ENABLE(%EnableRuntimeTranslator)
      #BUTTON('&Run-time Translator'),AT(,,170)
        #WITH(%ClassItem, 'Translator')
          #INSERT(%GlobalClassPrompts)
        #ENDWITH
      #ENDBUTTON
    #ENDENABLE
    #ENABLE(%FuzzyMatchingEnabled)
      #BUTTON('Fu&zzy Matcher'),AT(,,170)
        #WITH(%ClassItem, 'FuzzyMatcher')
          #INSERT(%GlobalClassPrompts)
        #ENDWITH
      #ENDBUTTON
    #ENDENABLE
  #ENDTAB
  #TAB('&Classes'),HLP('~TPLApplication_Classes')
    #BUTTON('&Refresh Application Builder Class Information'),WHENACCEPTED(%ForceReadABCFiles()),AT(,,170)
    #ENDBUTTON
    #BUTTON('Application Builder Class &Viewer'),WHENACCEPTED(%ViewABCs()),AT(,,170)
    #ENDBUTTON
    #BUTTON('&General'),HLP('~TPLApplication_Classes_General')
      #PROMPT('Window Manager:', FROM(%pClassName)),%WindowManagerType,DEFAULT('WindowManager'),REQ
      #BUTTON('&Configure'),AT(100,,90),HLP('~TPLApplication_Classes_General_Configure1')
        #PROMPT('&Reset On Gain Focus',CHECK),%ResetOnGainFocus,DEFAULT(%False)
        #PROMPT('&Auto Tool Bar',CHECK),%AutoToolbar,DEFAULT(%True)
        #PROMPT('&Auto Refresh',CHECK),%AutoRefresh,DEFAULT(%True)
      #ENDBUTTON
      #PROMPT('Image Manager:', FROM(%pClassName)),%ImageClass,DEFAULT('ImageManager'),REQ
      #PROMPT('Error Manager:', FROM(%pClassName)),%ErrorManagerType,DEFAULT('ErrorClass'),REQ
      #BUTTON('&Configure'),AT(100,,90),HLP('~TPLApplication_ConfigureErrorManager')
        #PROMPT('&Default Error Category:', @S255),%DefaultErrorCategory,DEFAULT('ABC')
        #PROMPT('Store Error &History', CHECK),%StoreErrorHistory,DEFAULT(%False)
        #ENABLE(%StoreErrorHistory = %True)
          #PROMPT('&Limit Stored History', CHECK),%LimitStoredHistory,DEFAULT(%False)
          #ENABLE(%LimitStoredHistory = %True)
            #PROMPT('History &Threshold Limit:', SPIN(@N4, 50, 9999, 1)),%ErrorHistoryThreshold,DEFAULT(300),REQ
          #ENDENABLE
          #PROMPT('&View Trigger Level:', DROP('Level:Benign|Level:Cancel|Level:Notify|Level:User|Level:Program|Level:Fatal')),%HistoryViewTrigger,DEFAULT('Level:Fatal')
        #ENDENABLE
      #ENDBUTTON
      #PROMPT('Popup Manager:', FROM(%pClassName)),%PopupClass,DEFAULT('PopupClass'),REQ
      #PROMPT('DOS File Lookup:', FROM(%pClassName)),%SelectFileClass,DEFAULT('SelectFileClass'),REQ
      #PROMPT('Resizer:', FROM(%pClassName)),%ResizerType,DEFAULT('WindowResizeClass'),REQ
      #BUTTON('&Configure'),AT(100,,90),HLP('~TPLApplication_Classes_General_Configure2')
        #BOXED('Resizer Default Behavior')
          #PROMPT(' Automatically find &Parent Controls? ',CHECK),%ResizerDeFaultFindParents,DEFAULT(%True),AT(35)
          #PROMPT(' Optimize &Moves? ',CHECK),%ResizerDefaultOptimizeMoves,DEFAULT(%True),AT(35)
          #PROMPT(' Optimize &Redraws? ',CHECK),%ResizerDefaultOptimizeRedraws,DEFAULT(%True),AT(35)
        #ENDBOXED
      #ENDBUTTON
      #PROMPT('INI Manager:', FROM(%pClassName)),%INIClass,DEFAULT('INIClass'),REQ
      #PROMPT('Run-Time Translator:', FROM(%pClassName)),%RunTimeTranslatorType,DEFAULT('TranslatorClass'),REQ
      #BUTTON('&Configure'),AT(100,,90),HLP('~TPLApplication_Classes_General_Configure3')
        #ENABLE(%EnableRuntimeTranslator)
          #BOXED('Translator Text Extraction Options')
            #PROMPT('Extract &Filename:',SAVEDIALOG('Choose Extraction File','All Files|*.*')),%ExtractionFilename
          #ENDBOXED
          #BUTTON('Additional Translation &Groups'),MULTI(%TranslationGroups,%TranslationFile&' - '&%TranslationGroup),AT(,,180)
            #PROMPT('&Source File:',OPENDIALOG('Choose Translation Files','Translation Files|*.TRN')),%TranslationFile,REQ
            #PROMPT('&Group Label:',@S80),%TranslationGroup,REQ
          #ENDBUTTON
        #ENDENABLE
      #ENDBUTTON
      #PROMPT('Fuzzy &Matcher:', FROM(%pClassName)),%FuzzyMatcherClass,DEFAULT('FuzzyClass'),REQ
    #ENDBUTTON
    #BUTTON('&File Management'),HLP('~TPLApplication_Classes_File')
      #PROMPT('File Manager:', FROM(%pClassName)),%FileManagerType,DEFAULT('FileManager'),REQ
      #PROMPT('View Manager:', FROM(%pClassName)),%ViewManagerType,DEFAULT('ViewManager'),REQ
      #PROMPT('Relation Manager:', FROM(%pClassName)),%RelationManagerType,DEFAULT('RelationManager'),REQ
    #ENDBUTTON
    #BUTTON('&Browser'),HLP('~TPLApplication_Classes_Browser')
      #PROMPT('Browser:', FROM(%pClassName)),%BrowserType,DEFAULT('BrowseClass'),REQ
      #BUTTON('&Configure'),AT(100,,90),HLP('~TPLApplication_Classes_Browser_Configure')
        #BOXED('Database Optimizations')
          #PROMPT('&Active Invisible',CHECK),%ActiveInvisible,DEFAULT(%False)
          #PROMPT('Allow &Unfilled',CHECK),%AllowUnfilled,DEFAULT(%False)
          #PROMPT('&Retain Row',CHECK),%RetainRow,DEFAULT(%True)
          #BOXED('Restore Defaults')
            #BUTTON('&ISAM'),AT(10,,50),WHENACCEPTED(%BRWISAMDefaults())
            #ENDBUTTON
            #BUTTON('&SQL'),AT(68,,50),WHENACCEPTED(%BRWSQLDefaults())
            #ENDBUTTON
            #BUTTON('Sys&tem'),AT(126,,50),WHENACCEPTED(%BRWSystemDefaults())
            #ENDBUTTON
          #ENDBOXED
        #ENDBOXED
      #ENDBUTTON
      #PROMPT('Browse EIP &Manager:', FROM(%pClassName)),%BrowseEIPManagerType,DEFAULT('BrowseEIPManager'),REQ
      #PROMPT('&Edit-in-Place Class:', FROM(%pClassName)),%EditInPlaceType,DEFAULT('EditEntryClass'),REQ
      #PROMPT('&Grid Manager:', FROM(%pClassName)),%GridClass,DEFAULT('GridClass'),REQ
      #PROMPT('&Sidebar Manager:', FROM(%pClassName)),%SidebarClass,DEFAULT('SidebarClass'),REQ
      #BOXED('Step Managers')
        #PROMPT('Abstract Step Base Class:', FROM(%pClassName)),%StepManagerType,DEFAULT('StepClass'),REQ
        #PROMPT('Long:', FROM(%pClassName)),%StepManagerLongType,DEFAULT('StepLongClass'),REQ
        #PROMPT('Real:', FROM(%pClassName)),%StepManagerRealType,DEFAULT('StepRealClass'),REQ
        #PROMPT('String:', FROM(%pClassName)),%StepManagerStringType,DEFAULT('StepStringClass'),REQ
        #PROMPT('Custom:', FROM(%pClassName)),%StepManagerCustomType,DEFAULT('StepCustomClass'),REQ
      #ENDBOXED
      #BOXED('Locator Managers')
        #PROMPT('&Step:', FROM(%pClassName)),%StepLocatorType,DEFAULT('StepLocatorClass'),REQ
        #PROMPT('&Entry:', FROM(%pClassName)),%EntryLocatorType,DEFAULT('EntryLocatorClass'),REQ
        #PROMPT('&Incremental:', FROM(%pClassName)),%IncrementalLocatorType,DEFAULT('IncrementalLocatorClass'),REQ
        #PROMPT('&Filtered:', FROM(%pClassName)),%FilteredLocatorType,DEFAULT('FilterLocatorClass'),REQ
      #ENDBOXED
      #PROMPT('File &Loaded Drop Mgr:', FROM(%pClassName)),%FileDropManagerType,DEFAULT('FileDropClass'),REQ
      #PROMPT('File Loaded &Combo Mgr:', FROM(%pClassName)),%FileDropComboManagerType,DEFAULT('FileDropComboClass'),REQ
      #PROMPT('&Query Form:', FROM(%pClassName)),%QBEFormType,DEFAULT('QueryFormClass'),REQ
      #PROMPT('Query Form &Visual:', FROM(%pClassName)),%QBEFormVisualType,DEFAULT('QueryFormVisual'),REQ
      #PROMPT('Query &List:', FROM(%pClassName)),%QBEListType,DEFAULT('QueryListClass'),REQ
      #PROMPT('Query List Vis&ual:', FROM(%pClassName)),%QBEListVisualType,DEFAULT('QueryListVisual'),REQ
    #ENDBUTTON
    #BUTTON('&Process && Reports'),HLP('~TPLApplication_Classes_Process')
      #PROMPT('Process:', FROM(%pClassName)),%ProcessType,DEFAULT('ProcessClass'),REQ
      #PROMPT('Print Previewer:', FROM(%pClassName)),%PrintPreviewType,DEFAULT('PrintPreviewClass'),REQ
      #PROMPT('Report Manager:', FROM(%pClassName)),%ReportManagerType,DEFAULT('ReportManager'),REQ
    #ENDBUTTON
    #BUTTON('&Ascii Viewer'),HLP('~TPLApplication_Classes_Ascii')
      #PROMPT('Ascii Viewer:', FROM(%pClassName)),%AsciiViewerClass,DEFAULT('AsciiViewerClass'),REQ
      #PROMPT('Ascii Searcher:', FROM(%pClassName)),%AsciiSearchClass,DEFAULT('AsciiSearchClass'),REQ
      #PROMPT('Ascii Printer:', FROM(%pClassName)),%AsciiPrintClass,DEFAULT('AsciiPrintClass'),REQ
      #PROMPT('ASCII File Manager:', FROM(%pClassName)),%AsciiFileManagerType,DEFAULT('AsciiFileClass'),REQ
    #ENDBUTTON
    #BUTTON('&Toolbar Managers'),HLP('~TPLApplication_Classes_Toolbar')
      #PROMPT('Toolbar Manager:', FROM(%pClassName)),%ToolbarClass,DEFAULT('ToolbarClass'),REQ
      #PROMPT('Toolbar List Box Manager:', FROM(%pClassName)),%ToolbarListBoxType,DEFAULT('ToolbarListboxClass'),REQ
      #PROMPT('Toolbar Relation Tree Manger:', FROM(%pClassName)),%ToolbarRelTreeType,DEFAULT('ToolbarReltreeClass'),REQ
      #PROMPT('Toolbar Update Manager:', FROM(%pClassName)),%ToolbarUpdateClassType,DEFAULT('ToolbarUpdateClass'),REQ
    #ENDBUTTON
    #BUTTON('ABC Library Files'),AT(,,170)
      #BOXED('ABC Library Files')
        #INSERT(%AbcLibraryPrompts)
      #ENDBOXED
    #ENDBUTTON
  #ENDTAB
#ENDSHEET
#!------------------------------------------------------------------------------
#!
#! Global Template Declarations.
#!
#!------------------------------------------------------------------------------
#!
#MESSAGE('Generating ' & %Application,0)          #! Open the Message Box
#EQUATE(%CWTemplateVersion,'v5.5')
#EQUATE(%ABCVersion,'5500')
#DECLARE(%IsExternal,LONG)                        #! Flag to determin if item is external
#DECLARE(%SaveCreateLocalMap),SAVE                #! Last Local Map status
#DECLARE(%GlobalIncludeList),UNIQUE               #! List of global include statements
#DECLARE(%ModuleIncludeList),UNIQUE               #! List of module include statements
#DECLARE(%CalloutModules),UNIQUE
#DECLARE(%ClassDeclarations),MULTI                #! List of module class declaration code statements
#DECLARE(%OOPConstruct)                           #! Used to construct OOP & general purpose declaration statements
#DECLARE(%ByteCount,LONG)                         #! Used to test for filled EMBED points
#DECLARE(%IncludePrototype,LONG)                  #! Used to test for prototype requirements in class declarations
#DECLARE(%UsedFile),UNIQUE                        #! Label of every file used
#DECLARE(%ProcFilesUsed),UNIQUE                   #! Label of every file used
#DECLARE(%UsedDriverDLLs),UNIQUE
#DECLARE(%FileExternalFlag)
#DECLARE(%FileThreadedFlag)
#DECLARE(%IniFileName)                            #! Used to construct INI file
#DECLARE(%GenerationCompleted,%Module),SAVE
#DECLARE(%GenerateModule)
#DECLARE(%VBXList),UNIQUE
#DECLARE(%OLENeeded)
#DECLARE(%OCXList),UNIQUE
#DECLARE(%LastTarget32),SAVE
#DECLARE(%LastProgramExtension),SAVE
#DECLARE(%LastApplicationDebug),SAVE
#DECLARE(%LastApplicationLocalLibrary),SAVE
#!
#DECLARE(%CustomGlobalMapModule),UNIQUE
#DECLARE(%CustomGlobalMapProcedure,%CustomGlobalMapModule),MULTI
#DECLARE(%CustomGlobalMapProcedurePrototype,%CustomGlobalMapProcedure)
#DECLARE(%CustomGlobalData),UNIQUE
#DECLARE(%CustomGlobalDataDeclaration,%CustomGlobalData)
#DECLARE(%CustomGlobalDataBeforeFiles,%CustomGlobalData)
#DECLARE(%CustomGlobalDataComponent,%CustomGlobalData),MULTI
#DECLARE(%CustomGlobalDataComponentIndent,%CustomGlobalDataComponent)
#DECLARE(%CustomGlobalDataComponentDeclaration,%CustomGlobalDataComponent)
#!
#DECLARE(%CustomModuleMapModule),UNIQUE
#DECLARE(%CustomModuleMapProcedure,%CustomModuleMapModule),MULTI
#DECLARE(%CustomModuleMapProcedurePrototype,%CustomModuleMapProcedure)
#DECLARE(%CustomModuleData),UNIQUE
#DECLARE(%CustomModuleDataDeclaration,%CustomModuleData)
#DECLARE(%CustomModuleDataComponent,%CustomModuleData),MULTI
#DECLARE(%CustomModuleDataComponentIndent,%CustomModuleDataComponent)
#DECLARE(%CustomModuleDataComponentDeclaration,%CustomModuleDataComponent)
#DECLARE(%CustomGlobalMapIncludes),UNIQUE
#DECLARE(%CustomGlobalDeclarationIncludes),UNIQUE
#!
#DECLARE(%CacheFileManager,%File)
#DECLARE(%CacheRelationManager,%File)
#DECLARE(%CacheFileUsed, %File)
#DECLARE(%CacheFileExternal,%File)
#DECLARE(%CacheBCModulesNeeded)
#!
#DECLARE(%CustomFlags),UNIQUE                     #! Allows third party developers to create
#DECLARE(%CustomFlagSetting,%CustomFlags)         #! Their own "symbols"
#!
#DECLARE(%AccessMode)                             #! File open mode equate
#DECLARE(%BuildFile)                              #! Construction filenames
#DECLARE(%BuildHeader)
#DECLARE(%BuildInclude)
#DECLARE(%ExportFile)                             #! File for Export list
#DECLARE(%ValueConstruct)                         #! Construct various strings
#DECLARE(%HoldConstruct)                          #! Construct various strings
#DECLARE(%RegenerateGlobalModule)                 #! Will we regen the global module?
#DECLARE(%AllFile),UNIQUE
#DECLARE(%GlobalRegenerate)                       #! Flag that controls generation
#EQUATE(%FilesPerBCModule,20)                     #! No of file definitions per BC module
#EQUATE(%RelatesPerRoutine,10)                    #! No of AddRelation/AddRelationLink calls per routine in bc module(s)
#!
#DECLARE (%Category),UNIQUE
#DECLARE (%CategoryDllInit,%Category)
#DECLARE (%CategoryDllKill,%Category)
#DECLARE (%CategoryLibName, %Category)
#DECLARE (%CategoryDllMode, %Category)
#DECLARE (%CategoryLinkMode, %Category)
#DECLARE (%CategoryDllModePrefix, %Category)
#DECLARE (%CategoryGlobal,%Category),MULTI
#DECLARE (%CategoryGlobalType,%CategoryGlobal)
#DECLARE (%CategoryDllInitParam,%CategoryGlobal)
#!
#!
#!
#!
#CALL(%SetupGlobalObjects)
#!
#COMMENT(55)                                      #!Set comment alignment to column 55
#!
#!
#!------------------------------------------------------------------------------
#!
#! Initialization Code for Global User-defined Symbols.
#!
#!------------------------------------------------------------------------------
#!
#EMBED(%BeforeGenerateApplication),HIDE
#!
#IF(%INIFile = 'Program Name.INI')                #! IF using program.ini
  #SET(%INIFileName,%Application & '.INI')        #! SET the file name
#ELSE                                             #! ELSE (IF NOT using Program.ini)
  #SET(%INIFileName,%ININame)                     #! SET the file name
#ENDIF                                            #! END (IF using program.ini)
#!
#!------------------------------------------------------------------------------
#!
#! Main Source Code Generation Loop.
#!
#!------------------------------------------------------------------------------
#!
#!
#!  Global Regenerate Test
#!
#IF(~%ConditionalGenerate OR %DictionaryChanged OR %RegistryChanged OR %SaveCreateLocalMap NOT=%CreateLocalMap OR %LastTarget32 NOT=%Target32 OR %LastProgramExtension NOT=%ProgramExtension OR %LastApplicationLocalLibrary NOT=%ApplicationLocalLibrary OR %LastApplicationDebug NOT=%ApplicationDebug OR ~FILEEXISTS(%Program))
  #SET(%GlobalRegenerate,%True)
  #SET(%LastTarget32,%Target32)
  #SET(%LastProgramExtension,%ProgramExtension)
  #SET(%LastApplicationLocalLibrary,%ApplicationLocalLibrary)
  #SET(%LastApplicationDebug,%ApplicationDebug)
  #SET(%SaveCreateLocalMap,%CreateLocalMap)
#ELSE
  #SET(%GlobalRegenerate,%False)
#ENDIF
#!
#!
#CALL(%ReadABCFiles)
#ADD(%GlobalIncludeList,'EQUATES.CLW')
#ADD(%GlobalIncludeList,'ERRORS.CLW')
#ADD(%GlobalIncludeList,'KEYCODES.CLW')
#!
#!
#FIX(%Driver,'ASCII')                           #!ASCII driver required by ABError.CLW
#IF(%Driver <> 'ASCII')
  #ERROR('Ascii file driver MUST be registered, used by Global Error Manager')
  #ABORT
#END
#PROJECT(%DriverLIB)
#!
#IF(ITEMS(%File))
  #CALL(%AddModuleIncludeFile,%FileManagerType,1)
  #CALL(%AddModuleIncludeFile,%ViewManagerType,1)
  #CALL(%AddModuleIncludeFile,%RelationManagerType,1)
#ENDIF
#IF(~%GlobalExternal)
  #IF(%ProgramExtension='DLL')                    #! Include all TopSpeed's base classes in non-external DLL
    #FIX(%Driver,'ASCII')                         #! Required for ASCIIViewer etc...
    #PROJECT(%DriverLib)
  #ENDIF
#ENDIF
#!
#CALL(%AddCategory, 'ABC','Init','Kill')
#CALL(%SetCategoryLocationFromPrompts, 'ABC', 'ABC', 'ABC')
#CALL(%AddCategoryGlobal, 'ErrorManager')
#CALL(%AddCategoryGlobal, 'INIManager')
#!
#IF(%ProgramExtension<>'EXE')
  #FOR(%pClassName)
    #FIX (%Category, %pClassCategory)
    #IF (%Category AND %CategoryLinkMode)
      #ADD(%GlobalIncludeList,%RemovePath(%pClassIncFile))
    #ENDIF
  #ENDFOR
#ENDIF
#!
#IF(%GlobalRegenerate)
  #FOR(%Module)
    #SET(%GenerationCompleted,%False)
  #ENDFOR
#ENDIF                                            #! END (IF Global Change)
#!
#SET(%BuildFile,UPPER(%Application&'.B1$'))
#SET(%BuildHeader,UPPER(%Application&'.H1$'))
#SET(%BuildInclude,UPPER(%Application&'.I1$'))
#IF (%EditProcedure)                              #! Special case for editing embedded source in context
  #CREATE(%EditFilename)
  #FIND(%ModuleProcedure,%EditProcedure)
  #FIX(%Procedure,%ModuleProcedure)           #! Fix current procedure
  #MESSAGE('Generating Module:    ' & %Module,1) #! Post generation message
  #MESSAGE('Generating Procedure: ' & %Procedure,2) #! Post generation message
  #GENERATE(%Procedure)                       #! Generate procedure code
  #CLOSE
  #ABORT
#ENDIF
#FOR(%Module),WHERE (%Module <> %Program)        #! For all member modules
  #MESSAGE('Generating Module:    '&UPPER(%Module),1) #! Post generation message
  #IF(%GlobalRegenerate OR %ModuleChanged OR ~%GenerationCompleted OR ~FILEEXISTS(%Module))
    #SET(%GenerateModule,%True)
  #ELSE
    #SET(%GenerateModule,%False)
  #ENDIF
  #IF(%GenerateModule)                            #! IF module to be generated
    #GENERATE(%Module)
  #ENDIF                                          #! END (If module to be...)
#ENDFOR                                           #! END (For all member modules)
#!
#!
#FIX(%Module,%Program)                            #! FIX to program module
#MESSAGE('Generating Module:    ' & %Module,1)   #! Post generation message
#IF(%GlobalRegenerate OR %RegenerateGlobalModule OR %ModuleChanged OR ~%GenerationCompleted OR ~FILEEXISTS(%Module))
  #SET(%GenerateModule,%True)
#ELSE
  #SET(%GenerateModule,%False)
#ENDIF
#FREE(%UsedDriverDLLs)
#EMBED(%CustomGlobalDeclarations,'Compile Global Declarations'),HIDE
#FOR(%File)
  #IF(%DefaultGenerate OR %OverrideGenerate OR %DefaultExport OR %OverrideExport)
    #ADD(%UsedFile,%File)
  #ENDIF
#ENDFOR
#!
#!Ensure that Aliased files are included in %UsedFile to force generation of aliased file
#!
#FOR(%File),WHERE(%AliasFile AND INLIST(%File,%UsedFile))
  #ADD(%UsedFile,%AliasFile)
#ENDFOR
#FOR(%UsedFile)
  #FIX(%File,%UsedFile)
  #FOR(%Field),WHERE(%FieldLookup)
    #ADD(%UsedFile,%FieldLookup)
  #ENDFOR
#ENDFOR
#CALL (%InitFileManagerCache)
#IF(%GenerateModule)
  #SET(%GenerationCompleted,%False)
  #CREATE(%BuildFile)                             #! Create temp module file
  #MESSAGE('Generating Program Code',2)           #! Post generation message
  #GENERATE(%Program)
  #FOR(%ModuleProcedure)                          #! For all procs in module
    #FIX(%Procedure,%ModuleProcedure)             #! Fix current procedure
    #MESSAGE('Generating Procedure: ' & %Procedure,2) #! Post generation message
    #GENERATE(%Procedure)                         #! Generate procedure code
  #ENDFOR                                         #! EndFor all procs in module
  #CLOSE()                                        #! Close last temp file
  #REPLACE(%Program,%BuildFile)                   #! Replace if changed
  #!INSERT(%WriteBaseMethods)
  #FOR(%UsedFile)                                   #! FOR all files used
    #FIX(%File,%UsedFile)                           #! FIX to that file
    #FIX(%Driver,%FileDriver)                       #! FIX to file's driver
    #ADD(%UsedDriverDLLs,%DriverDLL)
    #IF(~%GlobalExternal)
      #PROJECT(%DriverLIB)                          #! ADD driver LIB to project
    #ENDIF
  #ENDFOR                                           #! END (FOR all files used)
  #INSERT(%ConstructShipList)
  #EMBED(%AfterGenerateProgram),HIDE
#ELSE
  #FOR(%UsedFile)                                   #! FOR all files used
    #FIX(%File,%UsedFile)                           #! FIX to that file
    #FIX(%Driver,%FileDriver)                       #! FIX to file's driver
    #ADD(%UsedDriverDLLs,%DriverDLL)
    #IF(~%GlobalExternal)
      #PROJECT(%DriverLIB)                          #! ADD driver LIB to project
    #ENDIF
  #ENDFOR                                           #! END (FOR all files used)
#ENDIF
#REMOVE(%BuildFile)                               #! Remove the temp file
#!
#IF(~%GlobalExternal AND ~%NoGenerateGlobals)
  #DECLARE (%BCProjectCount)
  #LOOP,FOR(%BCProjectCount,1,%CacheBCModulesNeeded)
    #PROJECT(%MakeBCFilename(%BCProjectCount))
  #ENDLOOP
  #PROJECT(%MakeMainBCFilename())
#ENDIF
#!
#INSERT(%ConstructExportFile)
#!
#SET(%GenerationCompleted,%True)
#!
#!
#AT(%GatherObjects),PRIORITY(1)
  #CALL(%AddObjectList, 'ErrorManager')
  #CALL(%AddObjectList, 'INIManager')
  #IF(%EnableRunTimeTranslator)
    #CALL(%AddObjectList, 'Translator')
  #ENDIF
  #IF(%FuzzyMatchingEnabled)
    #CALL(%AddObjectList, 'FuzzyMatcher')
  #ENDIF
  #IF (0)
  #! This needs more thought - %FileIsUsed is not set up here
  #FOR(%File),WHERE(%FileIsUsed() AND ~(%FileIsExternal() OR %GlobalExternal))
    #CALL(%AddObjectListDirect, 'Access:' & %File, %GetBaseClassType('FileManager:' & %File))
    #CALL(%AddObjectListDirect, 'Relate:' & %File, %GetBaseClassType('RelationManager:' & %File))
  #ENDFOR
  #ENDIF
#ENDAT
#!
#!------------------------------------------------------------------------------
#!
#! End of C55 #APPLICATION Template
#!
#!------------------------------------------------------------------------------
#!
#!
#PROCEDURE(External,'External Procedure','External'),HLP('~TPLProcExternal')
#AT(%CustomGlobalDeclarations)
  #INSERT(%FileControlSetFlags)
#ENDAT
#!
#!
#INCLUDE('ABWINDOW.TPW')                          #! G/P window handler
#INCLUDE('ABASCII.TPW')                           #! Ascii Viewer Code/Extension/Procedure
#INCLUDE('ABBLDEXP.TPW')
#INCLUDE('ABBLDSHP.TPW')
#INCLUDE('ABBLDWSE.TPW')
#INCLUDE('ABBROWSE.TPW')                          #! Browse template(s)
#INCLUDE('ABCODE.TPW')                            #! Code Templates
#INCLUDE('ABCONTRL.TPW')                          #! Control Templates
#INCLUDE('ABDROPS.TPW')                           #! File loaded Drop List and Drop Combo box comtols
#INCLUDE('ABFILE.TPW')                            #! Generates the File/Relation Manager BC module
#INCLUDE('ABGROUP.TPW')                           #! Generic groups used by OOP extensions
#INCLUDE('ABMODULE.TPW')
#INCLUDE('ABPROCS.TPW')                           #! Clarion procedures that are not based on an ABC class
#INCLUDE('ABPOPUP.TPW')                           #! Popup manager templates
#INCLUDE('ABOLE.TPW')
#INCLUDE('ABPROGRM.TPW')                          #! The Clarion program template
#INCLUDE('ABRELTRE.TPW')
#INCLUDE('ABREPORT.TPW')                          #! Record reporting proc
#INCLUDE('ABUPDATE.TPW')                          #! Update form
#INCLUDE('ABFUZZY.TPW')                           #! Fuzzy Matching Templates
#INCLUDE('ABUTIL.TPW')                            #! Miscellaneous Extensions
#INCLUDE('cwRTF.TPW')                             #! RTF Template
#INCLUDE('cwHHABC.TPW')                           #! HTML Help Template
#INCLUDE('c55Util.tpw')                           #! Utility Template
#!
#!
#GROUP(%MakeModuleIncludeFile),PRESERVE              #!Makes an include file for the current %module
#MESSAGE('Local Maps: Generating Include File: '&UPPER(%ModuleBase)&'.INC',2)
#MESSAGE('',3)
#CREATE(%BuildInclude)
  MODULE('%(UPPER(%Module))')
#FOR(%ModuleProcedure)
  #FIX(%Procedure,%ModuleProcedure)
  #IF(%ProgramExtension='DLL')
    #IF(~(%ProcedureIsGlobal OR %ProcedureExported OR %Procedure=%FirstProcedure))
      #INSERT(%MakeDeclr,24,%OOPConstruct,%Procedure,%ProcedureType&%prototype)
      #IF(%ProcedureDescription)
        #INSERT(%Makedeclr,55,%OOPConstruct,%OOPConstruct,'!DLL local procedure - '&%ProcedureDescription)
      #ENDIF
%OOPConstruct
    #ENDIF
  #ELSE
    #IF(~(%ProcedureIsGlobal OR %Procedure=%FirstProcedure))
      #INSERT(%MakeDeclr,24,%OOPConstruct,%Procedure,%ProcedureType&%Prototype)
      #IF(%ProcedureDescription)
        #INSERT(%Makedeclr,55,%OOPConstruct,%OOPConstruct,'!'&%ProcedureDescription)
      #ENDIF
%OOPConstruct
    #ENDIF
  #ENDIF
#ENDFOR
  END
#CLOSE(%BuildInclude)
#REPLACE(UPPER(%ModuleBase)&'.INC',%BuildInclude)
#REMOVE(%BuildInclude)
#!
#GROUP(%ForceReadABCFiles)
#PURGE (%pClassName)
#PURGE(%pClassCategory)
#PURGE(%pClassIncFile)
#PURGE(%pClassImplements)
#PURGE(%pClassMethod)
#PURGE(%pClassMethodPrototype)
#PURGE(%pClassMethodFinal)
#PURGE(%pClassMethodPrivate)
#PURGE(%pClassMethodVirtual)
#PURGE(%pClassMethodProtected)
#PURGE(%pClassMethodProcAttribute)
#PURGE(%pClassMethodInherited)
#PURGE(%pClassMethodDefined)
#PURGE(%pClassMethodReturnType)
#PURGE(%pClassMethodParentCall)
#PURGE(%pClassMethodDll)
#PURGE(%pClassMethodExtName)
#PURGE(%pClassMethodCallConv)
#PURGE(%pClassProperty)
#PURGE(%pClassPropertyPrototype)
#PURGE(%pClassPropertyPrivate)
#PURGE(%pClassPropertyProtected)
#PURGE(%pClassPropertyInherited)
#PURGE(%pClassPropertyDefined)
#!
#PURGE(%pInterface)
#PURGE(%pInterfaceCategory)
#PURGE(%pInterfaceIncFile)
#PURGE(%pInterfaceMethod)
#PURGE(%pInterfaceMethodPrototype)
#PURGE(%pInterfaceMethodInherited)
#PURGE(%pInterfaceMethodDefined)
#PURGE(%pInterfaceMethodReturnType)
#PURGE(%pInterfaceMethodDll)
#PURGE(%pInterfaceMethodExtName)
#PURGE(%pInterfaceMethodCallConv)
#!
#PURGE(%pProcedure)
#PURGE(%pProcedureCategory)
#PURGE(%pProcedureIncFile)
#PURGE(%pProcedurePrototype)
#PURGE(%pProcedureDll)
#PURGE(%pProcedureExtName)
#PURGE(%pProcedureCallConv)
#!
#IF (VAREXISTS(%Host32) AND %Host32)
 #SERVICE('C55TPLSX.DLL','GenReadABCFiles')
#ELSE
 #SERVICE('C55TPLS.DLL','GenReadABCFiles')
#ENDIF
#!
#GROUP(%ReadABCFiles)
#IF(VAREXISTS(%pClassName) AND ~ITEMS(%pClassName))
  #CALL(%ForceReadABCFiles)
  #SET(%SysActiveInvisible,%False)                  #!Setup system default values
  #SET(%SysAllowUnfilled,%False)
  #SET(%SysRetainRow,%True)
  #SET(%SysResetOnGainFocus,%False)
  #SET(%SysAutoToolbar,%True)
  #SET(%SysAutoRefresh,%True)
#ENDIF
#!
#GROUP(%ViewABCs)
#IF (VAREXISTS(%Host32) AND %Host32)
  #SERVICE('C55TPLSX.DLL','GenViewABCClasses'),RETAIN
#ELSE
  #SERVICE('C55TPLS.DLL','GenViewABCClasses'),RETAIN
#ENDIF
#!
#!
#!UTILITY(RefreshABCClasses,'Refresh Application Builder Class Information')
#!CALL (%ForceReadABCFiles)
#UTILITY(ViewABCClasses,'Application Builder Class Viewer')
#CALL (%ViewABCs)
#!
