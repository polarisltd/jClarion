#TEMPLATE(Skeletons, 'Generic Skeleton Templates.'),FAMILY('ABC')
#HELP('ABSKEL.HLP')
#!
#!
#EXTENSION(GenericSkeletonClasses,'Global Generic Skeleton Classes.'),APPLICATION,HLP('~GenericSkeletonClasses')
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'MergeElementTI', 'ME', %MergeElementClass)
  #DECLARE(%TplInstance)
  #CALL(%FindGlobalTemplateInstance(ABC), 'Web(Web)'),%TplInstance
  #IF(%TplInstance > 0)
    #SET(%WebTemplatesInUse,%True)
  #ELSE
    #SET(%WebTemplatesInUse,%False)
  #ENDIF
#ENDPREPARE
  #BOXED('Default Addressbook prompts'),AT(0,0),WHERE(%False),HIDE
    #INSERT(%OOPHiddenPrompts(ABC))
  #ENDBOXED
  #SHEET,HSCROLL
   #TAB('&Settings')
    #ENABLE(%False)
     #PROMPT('Are the Web Templates in use in this application.',CHECK),%WebTemplatesInUse,AT(10)
    #ENDENABLE
    #BOXED('Merge Skeleton Directories')
      #PROMPT ('Sub directory for skeletons:', @s255), %MergeSkeletonSubdirectory,DEFAULT('Skeleton')
    #ENDBOXED
   #ENDTAB
   #TAB('C&lasses'),HLP('~CyberCash_Classes'),AT(,,170)
    #BOXED('')
      #PROMPT('MergeElement Class:',FROM(%pClassName)),%MergeElementClass,DEFAULT('MergeElement'),REQ
    #ENDBOXED
   #ENDTAB
   #BOXED('')
    #BUTTON('&MergeElement Class'),AT(,,170),HLP('~MergeElement_Class'),WHERE(%ProgramExtension<>'DLL')
      #WITH(%ClassItem,'MergeElementTI')
       #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
   #ENDBOXED
    #BUTTON('Skeleton Library Files'),AT(,,170)
      #BOXED('Skeleton Library Files')
        #INSERT(%AbcLibraryPrompts(ABC))
      #ENDBOXED
    #ENDBUTTON
  #ENDSHEET
#!-----------------------------------------------------------------------------------------
#! CLASS Related Template code below.
#!-----------------------------------------------------------------------------------------
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'MergeElementTI', 'ME', %MergeElementClass)
  #EQUATE(%MergeElementObjectName, %ThisObjectName)
#ENDAT
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'MergeElementTI')
#ENDAT
#!
#AT (%BeforeGlobalIncludes)
   INCLUDE('WBFILES.INC'),ONCE
#END
#!
#AT(%GlobalData)
#IF(~%WebTemplatesInUse)
WebFilesManager      WbFilesClass
WebFileAccess        WbFileProperties
#ENDIF
#ENDAT
#!
#AT (%AfterGlobalIncludes)
   INCLUDE('LAYHTML.INT'),ONCE
   INCLUDE('LAYBUILD.INT'),ONCE
   INCLUDE('ABSKEL.INC'),ONCE
#ENDAT
#!
#AT(%ProgramProcedures)
#IF(%ProgramExtension<>'DLL')
  #CALL(%GenerateVirtuals(ABC), 'MergeElementTI', 'Global Objects|Skeleton MergeElement', '%MergeElementVirtuals(Skeletons)', %True)
#ENDIF
#!
#ENDAT
#!
#AT (%CustomGlobalDeclarations)
  #PROJECT ('C%V%HTM%X%.LIB')
  #PROJECT ('WBSTD.CLW')
  #PROJECT ('WBSTD2.CLW')
#ENDAT
#!
#AT(%GlobalData)
#INSERT(%GenerateClass(ABC), 'MergeElementTI')
#ENDAT
#!
#! MergeElement Parent Calls.
#AT(%MergeElementMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#AT (%BeforeGenerateApplication)
  #MESSAGE('Initialising Skeleton Template',1)
  #IF (NOT %Target32)
    #ERROR ('Skeleton templates only work in 32bit mode')
  #END
  #!
  #CALL(%AddCategory(ABC), 'IBC')
  #CALL(%SetCategoryLocation(ABC), 'IBC', 'Ibc', %False, %True, 'C%V%IBC%X%')
  #!
  #CALL(%AddCategory(ABC), 'LAY')
  #CALL(%SetCategoryLocation(ABC), 'LAY', '', %False, %True, 'C%V%LAY%X%')
  #!
  #CALL(%AddCategory(ABC), 'ABL')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'ABL', 'WebCore', '')
  #!
  #CALL(%AddCategory(ABC), 'ABLRUN')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'ABLRUN', 'WebRun', '')
  #!
  #CALL(%AddCategory(ABC), 'WEB', 'InitWeb', 'KillWeb')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'WEB', 'WebAbc', 'WEB')
  #!
  #CALL(%AddCategory(ABC), 'SKELS')
  #CALL(%SetCategoryLocationFromPrompts(ABC), 'SKELS', 'Skels', 'Skels')
#END
#!
#!
#AT(%FileObjectDeclarations)
#IF(~%WebTemplatesInUse)
  #CALL(%GenerateDeclr(ABC), 22, 'WebTableProperties:' & %File, 'WbTableProperties')
#ENDIF
#ENDAT
#!
#AT(%AfterSettingFileTags),PRIORITY(9000)
#IF(~%WebTemplatesInUse)
WebTableProperties:%File.Init('%File', '')
SetTableProperties(WebTableProperties:%File, '%File')
#ENDIF
#ENDAT
#!
#AT(%FileManagerCodeSection,,'Kill','()'),PRIORITY(1000)
#IF(~%WebTemplatesInUse)
WebTableProperties:%File.Kill
#ENDIF
#ENDAT
#!
#AT(%ProgramSetup)
#IF(%MergeSkeletonSubdirectory)
AddSkeletonDirectory('%'MergeSkeletonSubdirectory')
#ENDIF
#ENDAT
#!-----------------------------------------------------------------------------------------
#! GROUPS
#!-----------------------------------------------------------------------------------------
#GROUP(%MergeElementVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%MergeElementMethodDataSection,'MergeElement Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('MergeElementTI'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%MergeElementMethodCodeSection,'MergeElement Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('MergeElementTI'))),TREE(%TreeText & %CodeText)
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
#!
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
#!
#GROUP(%GetMergeElementObjectName)
 #RETURN(%MergeElementObjectName)
#!
#GROUP(%MergeAndGenerate,%SkeletonDoc,%OutputDoc, %MergeElementObject)
#DECLARE(%MEObjectName)
 #IF(%MergeElementObject)
  #SET(%MEObjectName,%MergeElementObject)
 #ELSE
  #SET(%MEObjectName,%MergeElementObjectName)
 #END
#?  %MEObjectName.Init(%(%StripPling(%SkeletonDoc)),WebFileAccess)
#?  %MEObjectName.GenerateDocument(%(%StripPling(%OutputDoc)))
#?  %MEObjectName.Kill()
#!
#!-----------------------------------------------------------------------------------------
#CODE(MergeSkeletonDocument,'Code to Merge a Skeleton with Data')
#!-----------------------------------------------------------------------------------------
 #BOXED('')
  #PROMPT('Skeleton Document Name:',@s255),%SkeletonDoc
  #PROMPT('Merged Document Name:',@S255),%OutputDoc
 #ENDBOXED
 #INSERT(%MergeAndGenerate,%SkeletonDoc,%OutputDoc, '')
#!-----------------------------------------------------------------------------------------
#EXTENSION(ProcessReport, 'Application ProcessReport Extension'),SINGLE,HLP('~ProcessReportExt')
#!-----------------------------------------------------------------------------------------
#RESTRICT
 #IF(UPPER(%ProcedureTemplate)='PROCESS')
  #ACCEPT
 #ELSE
  #REJECT
 #ENDIF
#ENDRESTRICT
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'ReportElementTI', 'RE', %ReportElementClass)
#ENDPREPARE
#!
#!
#BOXED(''),AT(0,0),WHERE(%False),HIDE
  #INSERT(%OOPHiddenPrompts(ABC))
#ENDBOXED
#SHEET,HSCROLL
  #TAB('&Report Settings')
    #PROMPT('Report Skeleton:',@s40),%ReportSkeletonName,DEFAULT('detail.htm'),REQ
    #PROMPT('Hide Window:',CHECK),%HideReportWindow,DEFAULT(1)
  #ENDTAB
  #TAB('C&lasses'),HLP('~ReportElement_Classes'),AT(,,170)
    #BOXED('')
      #PROMPT('&Detail Class:',FROM(%pClassName)),%ReportElementClass,DEFAULT('ReportElement'),REQ
    #ENDBOXED
  #ENDTAB
  #BUTTON('&Report Element Class'),AT(,,170),HLP('~ReportElementClass')
    #WITH(%ClassItem,'ReportElementTI')
      #INSERT(%ClassPrompts(ABC))
    #ENDWITH
  #ENDBUTTON
#ENDSHEET
#!
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetClassDefaults(ABC), 'ReportElementTI', 'ReportElement', %ReportElementClass)
  #EQUATE(%ReportElementObjectName, %ThisObjectName)
#ENDAT
#!
#AT(%GatherObjects)
  #CALL(%AddObjectList(ABC), 'ReportElementTI')
#ENDAT
#!
#!
#AT(%LocalDataClasses)
#INSERT(%GenerateClass(ABC), 'ReportElementTI')
#ENDAT
#!
#AT(%DataSection)
ReportFile CSTRING(FILE:MaxFilePath)
#ENDAT
#!
#AT(%LocalProcedures)
  #!ADD(%GlobalIncludeList, 'WBREPORT.INC')            #! Needed because code embeded into filemanager objects in _BC modules
  #CALL(%GenerateVirtuals(ABC), 'ReportElementTI', 'Local Objects|ReportElement', '%ReportElementVirtuals(Skeletons)')
#ENDAT
#!
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'),PRIORITY(9500)
%ReportElementObjectName.Init(ThisProcess, '%ReportSkeletonName', WebFileAccess)
%Window{PROP:timer} = 0
#IF(%HideReportWindow)
%Window{PROP:Hide} = True
#ENDIF
%PctTextControl{Prop:Hide} = true
ReportFile = 'IReport.htm' ! need to change this to be dynamic.
#INSERT(%MergeAndGenerate,%ReportSkeletonName,%ReportSkeletonName, %ReportElementObjectName)
#PRIORITY(9530)
RETURN Level:Notify
#ENDAT
#!
#!
#GROUP(%ReportElementVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%ReportElementMethodDataSection,'Report Element Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('ReportElementTI'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%ReportElementMethodCodeSection,'Report Element Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('ReportElementTI'))),TREE(%TreeText & %CodeText)
#!
