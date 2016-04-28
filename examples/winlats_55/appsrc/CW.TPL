#TEMPLATE(Clarion,'Clarion Release Templates')
#HELP('CW2TPL.HLP')
#!
#APPLICATION('CW Default Application'),HLP('~TPLApplication')
#!
#!------------------------------------------------------------------------------
#!                          Template Release  1
#!------------------------------------------------------------------------------
#! CW Application Template
#!------------------------------------------------------------------------------
#!
#! These are the Clarion for Windows Templates.  The #PROCEDURE templates
#! included in this template set are:
#!
#! ToDo     - A default "Under Construction" procedure
#! Window   - A general purpose window handling procedure
#!  Browse  - Window copied for Browse grouping
#!  Form    - Window copied for Form grouping
#!  Frame   - Window copied for Frame grouping
#!  Menu    - Window copied for Menu grouping
#! Process  - A general purpose sequential record handler
#! Source   - A generic source procedure - Embed points only
#!
#!------------------------------------------------------------------------------
#!
#! Global Prompts - (Appear on 'Global Settings' screen-moved from #PROGRAM).
#!
#!------------------------------------------------------------------------------
#!
#SHEET
  #TAB('&General'),HLP('~TPLApplication_General')
    #PROMPT('Program &Author:',@s40),%ProgramAuthor
    #PROMPT('&Use field description as MSG() when MSG() is blank',CHECK),%MessageDescription,DEFAULT(%True),AT(10,,180)
    #PROMPT('&Generate template global data as EXTERNAL',CHECK),%GlobalExternal,AT(10,,180)
    #PROMPT('G&enerate EMBED Comments',CHECK),%GenerateEmbedComments,AT(10,,180)
    #BOXED('.INI File Settings'),AT(10,,180)
      #PROMPT('&Use .INI file to save and restore program settings',CHECK),%INIActive,AT(10,,180)
      #ENABLE(%INIActive)
        #PROMPT('.&INI File to use:',DROP('Program Name.INI|Other')),%INIFile
        #ENABLE(%INIFile='Other')
          #PROMPT('&Other File Name:',@S255),%ININame
        #ENDENABLE
      #ENDENABLE
    #ENDBOXED
    #PROMPT('Enable Window Frame Dragging',CHECK),%WindowFrameDragging,DEFAULT(1),AT(10)
  #ENDTAB
  #TAB('&File Control Flags'),HLP('~TPLApplication_FileControlFlags')
    #PROMPT('&Generate all file declarations',CHECK),%DefaultGenerate,AT(10,,180)
    #PROMPT('&When done with a File:',DROP('Close the File|Keep the File Open')),%DefaultCloseFile,DEFAULT('Close the File')
    #PROMPT('&Enclose RI code in transaction frame',CHECK),%DefaultRILogout,DEFAULT(1),AT(10,,180)
    #ENABLE(%DefaultRILogout)
      #PROMPT('&Issue template warning if LOGOUT() not allowed',CHECK),%WarnOnLogoutError,DEFAULT(%True),AT(10,,180)
    #ENDENABLE
    #PROMPT('&Seconds for RECOVER:',SPIN(@N3,1,120,1)),%LockRecoverTime,DEFAULT(10)
    #BOXED('File Attributes')
      #PROMPT('&Threaded:',DROP('Use File Setting|All Threaded|None Threaded')),%DefaultThreaded,DEFAULT('Use File Setting')
      #PROMPT('&Create:',DROP('Use File Setting|Create All|Create None')),%DefaultCreate,DEFAULT('Use File Setting')
      #PROMPT('E&xternal:',DROP('All External|None External')),%DefaultExternal,DEFAULT('None External')
      #BOXED('External Files'),WHERE(%DefaultExternal = 'All External'),AT(,116)
        #PROMPT('Dec&laring Module:',@S255),%DefaultExternalSource
        #PROMPT('All &files are declared in another .APP',CHECK),%DefaultExternalAPP,AT(15,,156)
      #ENDBOXED
      #BOXED('Export Files'),WHERE(%DefaultExternal = 'None External' AND %ProgramExtension='DLL'),AT(,116)
        #PROMPT('Ex&port all file declarations',CHECK),%DefaultExport,AT(25,,156)
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
    #ENDBOXED
  #ENDTAB
  #TAB('&Individual File Overrides'),HLP('~TPLApplication_IndividualFileOverrides')
    #BUTTON('Individual File Overrides'),FROM(%File,%File & ' - ' & %FileDescription),AT(10,,180),HLP('~TPLApplication'),INLINE,HLP('~TPLApplication_IndividualFileOverrides')
      #PROMPT('&Generate file declaration',CHECK),%OverrideGenerate,AT(10,,180)
      #PROMPT('&When Done with the File:',DROP('Use Default|Close the File|Keep the File Open')),%OverrideCloseFile,DEFAULT('Use Default')
      #PROMPT('Us&e RI transaction frame',DROP('Use Default|Yes|No')),%OverrideRILogout,DEFAULT('Use Default')
      #BOXED('File Attributes')
        #PROMPT('&Threaded:',DROP('Use Default|Use File Setting|Threaded|Not Threaded')),%OverrideThreaded,DEFAULT('Use Default')
        #PROMPT('&Create:',DROP('Use Default|Use File Setting|Create File|Do Not Create File')),%OverrideCreate,DEFAULT('Use Default')
        #PROMPT('E&xternal:',DROP('Use Default|External|Not External')),%OverrideExternal,DEFAULT('Use Default')
        #BOXED('External File'),WHERE(%OverrideExternal = 'External'),AT(,80)
          #PROMPT('Dec&laring Module:',@S255),%OverrideExternalSource
          #PROMPT('The &file is declared in another .APP',CHECK),%OverrideExternalAPP,AT(15,,140)
        #ENDBOXED
        #BOXED('Export File'),WHERE(%OverrideExternal = 'Not External'  AND %ProgramExtension='DLL'),AT(,80)
          #PROMPT('Ex&port file declaration',CHECK),%OverrideExport,AT(20,,110)
        #ENDBOXED
      #ENDBOXED
      #BOXED('File Access')
        #PROMPT('File Open &Mode:',DROP('Use Default|Share|Open|Other')),%OverrideOpenMode,DEFAULT('Use Default')
        #ENABLE(%OverRideOpenMode = 'Other')
          #BOXED('Other Open Mode')
            #PROMPT('&User Access:',DROP('Use Default|Read/Write|Read Only|Write Only')),%OverrideUserAccess,DEFAULT('Use Default')
            #PROMPT('Ot&her Access:',DROP('Use Default|Deny None|Deny Read|Deny Write|Deny All|Any Access')),%OverrideOtherAccess,DEFAULT('Use Default')
          #ENDBOXED
        #ENDENABLE
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
#DECLARE(%CWTemplateVersion)
#SET(%CWTemplateVersion,'v2.003')
#DECLARE(%UsedFile),UNIQUE                        #! Label of every file used
#DECLARE(%ProcFilesUsed),UNIQUE                        #! Label of every file used
#DECLARE(%UsedDriverDLLs),UNIQUE
#DECLARE(%PrintPreviewUsed)
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
#DECLARE(%CustomGlobalProcedureIncludes),UNIQUE
#!
#DECLARE(%CustomFlags),UNIQUE                     #! Allows third party developers to create
#DECLARE(%CustomFlagSetting,%CustomFlags)         #! Their own "symbols"
#!
#DECLARE(%AccessMode)                             #! File open mode equate
#DECLARE(%BuildFile)                              #! Construction filename
#DECLARE(%ExportFile)                             #! File for Export list
#DECLARE(%ValueConstruct)                         #! Construct various strings
#DECLARE(%HoldConstruct)                          #! Construct various strings
#DECLARE(%RegenerateGlobalModule)                 #! Will we regen the global module?
#DECLARE(%ClipName)
#DECLARE(%RIDelFileName)
#DECLARE(%RIUpdFileName)
#DECLARE(%SFFileName)                            #! Standard Functions
#SET(%ClipName,SUB(%Application,1,5))
#SET(%RIDelFileName,%ClipName & '_RD.CLW')
#PROJECT(%RIDelFileName)                            #! Referential Integrity
#SET(%RIUpdFileName,%ClipName & '_RU.CLW')
#PROJECT(%RIUpdFileName)                            #! Referential Integrity
#SET(%SFFileName,%ClipName & '_SF.CLW')
#PROJECT(%SFFileName)                            #! Standard Functions
#DECLARE(%UpdateRelationPrimary),UNIQUE
#DECLARE(%UpdateRelationSecondary,%UpdateRelationPrimary),UNIQUE
#DECLARE(%UpdateAttachedFile,%UsedFile),UNIQUE
#DECLARE(%DeleteRelationPrimary),UNIQUE
#DECLARE(%DeleteRelationSecondary,%DeleteRelationPrimary),UNIQUE
#DECLARE(%DeleteAttachedFile,%UsedFile),UNIQUE
#DECLARE(%AllFile),UNIQUE
#DECLARE (%ResizeGlobalDefsPlaced, LONG)
#DECLARE(%BRWList),UNIQUE
#!
#!------------------------------------------------------------------------------
#!
#! Initialization Code for Global User-defined Symbols.
#!
#!------------------------------------------------------------------------------
#!
#SET (%ResizeGlobalDefsPlaced, %False)
#IF(%INIFile = 'Program Name.INI')                #! IF using program.ini
  #SET(%INIFileName, %Application & '.INI')       #! SET the file name
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
#DECLARE(%GlobalRegenerate)                       #! Flag that controls generation
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
#IF(~%ConditionalGenerate OR %DictionaryChanged OR %RegistryChanged)
  #SET(%GlobalRegenerate,%True)                   #! Generate Everything
  #FOR(%Module)
    #SET(%GenerationCompleted,%False)
  #ENDFOR
#ELSE                                             #! ELSE (If no global change)
  #SET(%GlobalRegenerate,%False)                  #! Generate changed modules only
#ENDIF                                            #! END (IF Global Change)
#EMBED(%BeforeGenerateApplication,'Before Generating Application'),HIDE
#SET(%BuildFile,(%Application & '.B1$'))          #! Make temp program filename
#FOR(%Module), WHERE (%Module <> %Program)        #! For all member modules
  #MESSAGE('Generating Module:    ' & %Module, 1) #! Post generation message
  #SET(%GenerateModule,%True)
  #IF(%ModuleExternal)
    #SET(%GenerateModule,%False)
  #ELSIF(%ModuleChanged)
  #ELSIF(%GlobalRegenerate)
  #ELSIF(NOT %GenerationCompleted)
  #ELSIF(NOT FILEEXISTS(%Module))
  #ELSE
    #SET(%GenerateModule,%False)
  #ENDIF
  #IF(%GenerateModule)                            #! IF module to be generated
    #SET(%GenerationCompleted,%False)
    #SET(%RegenerateGlobalModule,%True)           #! Flag to regen the main module
    #CREATE(%BuildFile)                           #! Create temp module file
    #GENERATE(%Module)
    #FOR(%ModuleProcedure)                        #! FOR all procs in module
      #FIX(%Procedure,%ModuleProcedure)           #! Fix current procedure
      #MESSAGE('Generating Procedure: ' & %Procedure, 2) #! Post generation message
      #FREE(%ProcFilesUsed)                       #! Clear file accumulator
      #GENERATE(%Procedure)                       #! Generate procedure code
    #ENDFOR                                       #! END (For all procs in module)
    #CLOSE(%BuildFile)                            #! Close last temp file
    #REPLACE(%Module,%BuildFile)                  #! Replace the existing file
    #SET(%GenerationCompleted,%True)
  #ENDIF                                          #! END (If module to be...)
#ENDFOR                                           #! END (For all member modules)
#FIX(%Module,%Program)                            #! FIX to program module
#MESSAGE('Generating Module:    ' & %Module, 1)   #! Post generation message
#SET(%GenerateModule,%True)
#IF(%ModuleExternal)
  #SET(%GenerateModule,%False)
#ELSIF(%RegenerateGlobalModule)
#ELSIF(%ModuleChanged)
#ELSIF(%GlobalRegenerate)
#ELSIF(NOT %GenerationCompleted)
#ELSIF(NOT FILEEXISTS(%Module))
#ELSIF(%LastTarget32<>%Target32)
#ELSIF(%LastProgramExtension<>%ProgramExtension)
#ELSIF(%LastApplicationDebug<>%ApplicationDebug)
#ELSIF(%LastApplicationLocalLibrary<>%ApplicationLocalLibrary)
#ELSE
  #SET(%GenerateModule,%False)
#ENDIF
#SET(%LastTarget32,%Target32)
#SET(%LastProgramExtension,%ProgramExtension)
#SET(%LastApplicationDebug,%ApplicationDebug)
#SET(%LastApplicationLocalLibrary,%ApplicationLocalLibrary)
#FREE(%UsedDriverDLLs)
#EMBED(%CustomGlobalDeclarations,'Compile Global Declarations'),HIDE
#FOR(%File)
  #IF(%DefaultGenerate OR %OverrideGenerate)
    #ADD(%UsedFile,%File)
  #ENDIF
#ENDFOR
#IF(%GenerateModule)
  #SET(%GenerationCompleted,%False)
  #EMBED (%BeforeGenerateProgram, 'Before Generating Program'), HIDE
  #CREATE(%BuildFile)                             #! Create temp module file
  #MESSAGE('Generating Program Code',2)           #! Post generation message
  #GENERATE(%Program)
  #FOR(%ModuleProcedure)                          #! For all procs in module
    #FIX(%Procedure,%ModuleProcedure)             #! Fix current procedure
    #MESSAGE('Generating Procedure: ' & %Procedure, 2) #! Post generation message
    #GENERATE(%Procedure)                         #! Generate procedure code
  #ENDFOR                                         #! EndFor all procs in module
  #CLOSE()                                        #! Close last temp file
  #REPLACE(%Program,%BuildFile)                   #! Replace if changed
  #INSERT(%GenerateStandardFunctions)
  #INSERT(%GenerateRICode)
  #INSERT(%ConstructExportFile)
  #FOR(%UsedFile)                                   #! FOR all files used
    #FIX(%File,%UsedFile)                           #! FIX to that file
    #FIX(%Driver,%FileDriver)                       #! FIX to file's driver
    #ADD(%UsedDriverDLLs,%DriverDLL)
    #PROJECT(%DriverLIB)                            #! ADD driver LIB to project
  #ENDFOR                                           #! END (FOR all files used)
  #INSERT(%ConstructShipList)
#ELSE
  #FOR(%UsedFile)                                   #! FOR all files used
    #FIX(%File,%UsedFile)                           #! FIX to that file
    #FIX(%Driver,%FileDriver)                       #! FIX to file's driver
    #ADD(%UsedDriverDLLs,%DriverDLL)
    #PROJECT(%DriverLIB)                            #! ADD driver LIB to project
  #ENDFOR                                           #! END (FOR all files used)
#ENDIF
#REMOVE(%BuildFile)                               #! Remove the temp file
#SET(%GenerationCompleted,%True)
#!
#!------------------------------------------------------------------------------
#!
#! End of CW #APPLICATION Template
#!
#!------------------------------------------------------------------------------
#!
#PROCEDURE(External,'External Procedure','External'),HLP('~TPLProcExternal')
#AT(%CustomGlobalDeclarations)
  #INSERT(%FileControlSetFlags)
#ENDAT
#PROCEDURE(Source,'Source Procedure'),HLP('~TPLProcSource')#! Source procedure
#PROMPT('Parameters', @s255), %Parameters          #! Retrieve parameters used
#IF(%Parameters)                                  #! IF Parameters used
%[20]Procedure %ProcedureType %Parameters         #<! Declare Procedure
#ELSE                                             #! ELSE (IF parameters not used)
%[20]Procedure %ProcedureType                     #<! Declare Procedure
#ENDIF                                            #! END (IF parameters used)
#INSERT(%FileControlInitialize)
#AT(%CustomGlobalDeclarations)
  #INSERT(%FileControlSetFlags)
#ENDAT
#FOR(%LocalData)
%[20]LocalData %LocalDataStatement
#ENDFOR
#EMBED(%DataSection,'Data Section'),DATA          #! Embedded Source Code
  CODE                                            #<! Begin processed code
#EMBED(%ProcessedCode,'Processed Code')           #! Embedded Source Code
#!
#INCLUDE('Program.TPW')                           #! The CW program template
#INCLUDE('Window.TPW')                            #! G/P window handler
#INCLUDE('Browse.TPW')                            #! Browse records from a file
#INCLUDE('Form.TPW')                              #! View / Edit a file record
#INCLUDE('Frame.TPW')                             #! MDI Frame
#INCLUDE('Menu.TPW')                              #! Non-MDI menu procedure
#INCLUDE('Viewer.TPW')                            #! ASCII file viewer
#INCLUDE('Process.TPW')                           #! Record Processing Proc
#INCLUDE('Report.TPW')                            #! Record reporting proc
#INCLUDE('Splash.TPW')                            #! Splash Window proc
#INCLUDE('ToDo.TPW')                              #! Under Construction proc
#INCLUDE('Relation.TPW')                          #! Relational Integrity Code
#INCLUDE('Standard.TPW')                          #! Standard Group code
#INCLUDE('FileCtrl.TPW')                          #! Standard File Control code
#INCLUDE('Code.TPW')                              #! Code Templates
#INCLUDE('CtlBrow.TPW')                           #! Browse control template(s)
#INCLUDE('CtlView.TPW')                           #! ASCII viewer control template
#INCLUDE('CtlOLE.TPW')                            #! OLE Controls
#INCLUDE('CtlHTML.TPW')                           #! HTML Control
#INCLUDE('RelTree.TPW')
#INCLUDE('Control.TPW')                           #! Control Templates
#INCLUDE('Extens.TPW')                            #! Extension Templates
#INCLUDE('Field.TPW')                             #! Generic Field Handling
#INCLUDE('Module.TPW')
#INCLUDE('StdFunc.TPW')
#INCLUDE('BuildExp.TPW')
#INCLUDE('BuildShp.TPW')
#INCLUDE('TplError.TPW')
#INCLUDE('cwRTF.TPW')                             #! RTF Template
#INCLUDE('cwHH.TPW')                              #! HTML Help Template
