#TEMPLATE(Web, 'Web Builder Templates v2.1'),FAMILY('ABC')
#HELP('WB.HLP')
#!
#!
#!
#EXTENSION (Web, 'Web Application Extension'),APPLICATION(WebProc(Web)),FIRST,SINGLE,HLP('~WebGlobalExt')
#!
#PREPARE
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetupGlobalObjects)
  #CALL(%InitControlTypes)
#END
#!
#INSERT(%OOPPrompts(ABC))
#BOXED, WHERE(%False), AT(,,0,0)
  #BUTTON ('Hidden controls'),AT(,,0,0)
    #PROMPT ('', @S255),%AppControlType,MULTI(''),UNIQUE
    #BUTTON (''), FROM(%AppControlType, '')
      #PROMPT ('',@s255),%AppControlTypeClassDefault
    #END
    #PROMPT ('', @s255),%AppClassQueue,MULTI(''),UNIQUE
  #END
#END
#SHEET, HSCROLL
  #TAB ('&Window')
    #BOXED ('Skeleton Selection')
      #PROMPT ('Theme:', @s255), %AppSkeletonStyle
      #PROMPT ('Window Skeleton to use:', @s255), %AppWinSkeletonName
      #ENABLE (NOT %AppWinSkeletonName)
        #PROMPT ('Extra capabilities:', @s255), %AppWinSkeletonCapabilities
      #END
    #END
    #BOXED, WHERE(%False), HIDE
      #BOXED ('Pa&ge')
        #PROMPT ('Center window on page', CHECK), %AppCenterWindow,DEFAULT(1),AT(10)
        #PROMPT ('Background color:', COLOR), %AppPageBackColor,DEFAULT(-1)
        #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppPageBackImage
      #END
      #BOXED ('Wi&ndow')
        #PROMPT ('Background color:', COLOR), %AppWindowBackColor,DEFAULT(-1)
        #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppWindowBackImage
        #PROMPT ('Window border width:', SPIN(@n3, 0, 999)), %AppWindowBorderWidth, DEFAULT(2)
      #END
    #END
    #BOXED ('Help'), WHERE(%False), HIDE
      #PROMPT ('Enable help for internet applications', CHECK), %AppHelpEnabled, AT(10)
      #ENABLE (%AppHelpEnabled)
        #PROMPT ('Help ids are links within a base document', CHECK), %AppHelpRelative,AT(10)
        #BOXED, SECTION
          #BOXED, WHERE(%AppHelpRelative), AT(,0)
            #PROMPT ('Help document:', @s255), %AppHelpDocument
          #END
          #BOXED, WHERE(NOT %AppHelpRelative), AT(,0)
            #PROMPT ('URL of help documents:', @s255), %AppHelpURL
          #END
        #END
        #PROMPT ('Help window style', @s255), %AppHelpStyle
      #END
    #END
    #BOXED, WHERE(%False), HIDE
    #BUTTON('Window Com&ponents...'), AT(,,180),HLP('~ICGlobalExt_WindowComponents')
      #SHEET
        #TAB('&Caption')
          #BOXED ('Ca&ption')
            #PROMPT ('Include caption', CHECK), %AppDisplayCaption, AT(10),DEFAULT(0)
            #ENABLE (%AppDisplayCaption)
              #PROMPT ('Background color:', COLOR), %AppCaptionBackColor, DEFAULT(800000H)
              #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppCaptionBackImage
              #PROMPT ('Alignment:', DROP('Left[PROP:left]|Center[PROP:center]|Right[PROP:right]')), %AppCaptionAlign, DEFAULT('PROP:center')
              #PROMPT ('Font family name:', @s255), %AppCaptionFontFace, DEFAULT('')
              #PROMPT ('Font size:', SPIN(@n3b, 0, 127)), %AppCaptionFontSize, DEFAULT(0)
              #PROMPT ('Font color:', COLOR), %AppCaptionFontColor, DEFAULT(0FFFFFFH)
            #END
          #END
        #END
        #TAB ('&Menu'),HLP('~ICGlobalExt_Menu')
          #BOXED ('M&enu')
            #PROMPT ('Background color:', COLOR), %AppMenuBackColor,DEFAULT(099CCCCH)
            #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppMenuBackImage
            #PROMPT ('Alignment:', DROP('Left of Window[PROP:left]|Above Toolbar[PROP:above]|Below Toolbar[PROP:below]')), %AppMenuAlign, DEFAULT('PROP:above')
          #END
        #END
        #TAB ('&Toolbar'),HLP('~ICGlobalExt_Toolbar')
          #BOXED ('&Toolbar')
            #PROMPT ('Background color:', COLOR), %AppToolbarBackColor,DEFAULT(-1)
            #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppToolbarBackImage
          #END
          #BOXED ('&Close button')
            #PROMPT ('Create extra close button', OPTION),%AppCreateExtraClose,DEFAULT('Always')
              #PROMPT ('Never', RADIO),AT(14),VALUE('Never')
              #PROMPT ('If window has system menu and no visible buttons', RADIO),AT(14),VALUE('SystemNoButton')
              #PROMPT ('If window has system menu', RADIO),AT(14),VALUE('IfSystem')
              #PROMPT ('Always', RADIO),AT(14),VALUE('Always')
            #ENABLE (%AppCreateExtraClose <> 'Never')
              #PROMPT ('Image for close:', OPENDIALOG('Select close Image', 'Icon Images (*.ico)|*.ico|All Files (*.*)|*.*')), %AppToolbarCloseImage, DEFAULT('exit.ico')
            #END
          #END
        #END
        #TAB ('Client &Area'),HLP('~ICGlobalExt_ClientArea')
          #BOXED ('Client Area')
            #PROMPT ('Background color:', COLOR), %AppClientAreaBackColor,DEFAULT(-1)
            #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %AppClientAreaBackImage
          #END
        #END
      #END
    #END
    #END
  #END
  #TAB ('&Control'),HLP('~ICGlobalExt_Control'),WHERE(%False)
    #BOXED ('General')
      #PROMPT ('If control disabled:', DROP('Hide control[Hide]|Hide if cannot disable[OptHide]|Show control[Show]')), %AppOnDisabled,DEFAULT('Hide')
    #END
    #BOXED ('Drop listboxes')
      #PROMPT ('Replace with Java non-drop list', CHECK), %AppJavaDropList,AT(10)
    #END
    #BOXED('Sheets')
      #PROMPT ('Border width:', SPIN(@n2,0,99)),%AppSheetBorderWidth,DEFAULT(2)
    #END
    #BOXED('Options')
      #PROMPT ('Border width (if boxed):', SPIN(@n2,0,99)),%AppOptionBorderWidth,DEFAULT(2)
    #END
    #BOXED('Group')
      #PROMPT ('Border width (if boxed):', SPIN(@n2,0,99)),%AppGroupBorderWidth,DEFAULT(2)
    #END
  #END
  #TAB ('&MDI'),HLP('~ICGlobalExt_MDI')
    #BOXED ('Frame Menu')
      #PROMPT ('Include On Child Windows:', DROP('All Menu Items[All]|No Menu Items[None]')),%AppMenuCopy,DEFAULT('None')
      #ENABLE (%AppMenuCopy = 'All')
        #PROMPT ('Ignore code in frame''s ACCEPT loop', CHECK),%AppMenuIgnoreCode,AT(10)
      #END
    #END
    #BOXED ('Frame Toolbar')
      #PROMPT ('Include On Child Windows:', DROP('All Toolbar Items[All]|Standard Toolbar Only[Standard]|No Toolbar Items[None]')),%AppToolCopy,DEFAULT('Standard')
      #ENABLE (%AppToolCopy = 'All')
        #PROMPT ('Ignore code in frame''s ACCEPT loop', CHECK),%AppToolIgnoreCode,AT(10)
      #END
    #END
    #BOXED ('')
      #DISPLAY ('For more options see the internet options on the frame procedure.  This will allow you to choose which controls from the frame are present onto child dialogs.  You can also select whether to re-use the code in the frame''s ACCEPT loop.'),AT(10,,170,40)
    #END
  #END
  #TAB ('Ad&vanced'),HLP('~ICGlobalExt_Advanced')
    #BOXED ('Formatting'),HIDE,WHERE(%False)
      #BOXED ('HTML scaling - Pixels Per Character')
        #PROMPT ('Horizontal:', SPIN(@n2,1,99)),%AppPixelsPerCharX,DEFAULT(6)
        #PROMPT ('Vertical:', SPIN(@n2,1,99)),%AppPixelsPerCharY,DEFAULT(13)
      #END
      #PROMPT ('Delta for grid snapping:', SPIN(@n2b, 0,99)),%AppGridSnapDeltaX,DEFAULT(2),AT(96,,40)
      #PROMPT ('', SPIN(@n2b, 0,99)),%AppGridSnapDeltaY,DEFAULT(2),AT(140,,40)
    #END
    #BOXED ('Application')
      #PROMPT ('Enable dual mode application', CHECK), %DualModeApplication, DEFAULT(0),AT(10)
      #PROMPT ('Page to return to on exit:', @s255), %AppPageToReturnTo
      #PROMPT ('Time out (seconds):', SPIN(@n5, 0, 9999)), %AppTimeOut,DEFAULT(600)
      #PROMPT ('Sub directory for pages:', @s255), %PublicSubdirectory
      #PROMPT ('Sub directory for skeletons:', @s255), %SkeletonSubdirectory,DEFAULT('Skeleton')
      #BOXED(''),WHERE(%False),HIDE
        #PROMPT ('Classes local to application broker', CHECK), %JavaLocalClass,DEFAULT('1'),AT(10,,180)
        #ENABLE (NOT %JavaLocalClass)
          #PROMPT ('Location of classes:', @s255),%JavaClassPath,DEFAULT('http://www.topspeed.com')
        #END
        #PROMPT ('Use &Long Filenames', CHECK), %UseLongFilenames,DEFAULT('1'),AT(10,,180)
      #END
      #PROMPT ('Use &Cookies Rather than INI File', CHECK),%UseCookies,DEFAULT('0'),AT(10,,180),WHENACCEPTED(%UseCookiesAccepted())
    #END
  #END
  #TAB('Global &Objects'),HLP('~WebGlobal_Objects')
    #BUTTON('Application &Broker'),AT(,,170)
      #WITH(%ClassItem, 'Broker')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #BUTTON('&HTML Manager'),AT(,,170)
      #WITH(%ClassItem, 'HTMLManager')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #!BUTTON('&Java Events Manager'),AT(,,170)
      #!WITH(%ClassItem, 'JavaEventsManager')
        #!INSERT(%GlobalClassPrompts(ABC))
      #!ENDWITH
    #!ENDBUTTON
    #BUTTON('Web &Files Manager'),AT(,,170)
      #WITH(%ClassItem, 'WebFilesManager')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #BUTTON('&Web Server'),AT(,,170)
      #WITH(%ClassItem, 'WebServer')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #BUTTON('&Shutdown Manager'),AT(,,170)
      #WITH(%ClassItem, 'ShutdownManager')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #BUTTON('Web File &Access'),AT(,,170)
      #WITH(%ClassItem, 'WebFileAccess')
        #INSERT(%GlobalClassPrompts(ABC))
      #ENDWITH
    #ENDBUTTON
    #ENABLE(%UseCookies)
      #BUTTON('&Cookie Manager'),AT(,,170)
        #WITH(%ClassItem, 'CookieManager')
          #INSERT(%GlobalClassPrompts(ABC))
        #ENDWITH
      #ENDBUTTON
    #ENDENABLE
  #ENDTAB
  #TAB('C&lasses'),HLP('~WebGlobal_Classes')
    #BUTTON('Global Web &Objects'),AT(,,170)
      #PROMPT('Application &Broker:', FROM(%pClassName)),%BrokerClass,DEFAULT('WbBrokerClass'),REQ
      #PROMPT('&HTML Manager:', FROM(%pClassName)),%HTMLManagerClass,DEFAULT('WbHtmlClass'),REQ
      #!PROMPT('&Java Events Manager:', FROM(%pClassName)),%JslEventsClass,DEFAULT('WbJslEventsClass'),REQ
      #PROMPT('Web &Files Manager:', FROM(%pClassName)),%WebFilesClass,DEFAULT('WbFilesClass'),REQ
      #PROMPT('Web &Server:', FROM(%pClassName)),%WebServerClass,DEFAULT('WbServerClass'),REQ
      #PROMPT('Sh&utdown Manager:', FROM(%pClassName)),%ShutdownClass,DEFAULT('WbShutDownClass'),REQ
      #PROMPT('&Cookie Manager', FROM(%pClassName)),%CookieClass,DEFAULT('WbCookieClass'),REQ
      #PROMPT('Web File &Access:', FROM(%pClassName)),%WebFileAccess,DEFAULT('WbFileProperties'),REQ
      #BUTTON('Web &Table Properties for each file'),AT(,,170),FROM(%File,'WebTableProperties:' & %File)
        #PROMPT('Web &Table Properties:' & %File, FROM(%pClassName)),%WbTablePropertyClass,DEFAULT('WbTableProperties'),REQ
      #ENDBUTTON
    #ENDBUTTON
    #BUTTON('&Procedure Web Objects'),AT(,,170)
      #PROMPT('Web F&rame Manager:', FROM(%pClassName)),%WebFrameClass,DEFAULT('WbFrameClass'),REQ
      #PROMPT('Web Wi&ndow Manager:', FROM(%pClassName)),%WebWindowManagerClass,DEFAULT('WbWindowManagerClass'),REQ
      #PROMPT('Web Wi&ndow:', FROM(%pClassName)),%WebWindowClass,DEFAULT('WbWindowClass'),REQ
      #PROMPT('Web Wi&ndow Property:', FROM(%pClassName)),%WebWindowPropertyClass,DEFAULT('WbWindowHtmlProperties'),REQ
    #ENDBUTTON
    #BUTTON('ABC Comple&x Control Managers'),AT(,,170)
      #PROMPT('&Html Grid Manager:', FROM(%pClassName)),%HTMLGridManager,DEFAULT('WbGridHtmlProperties'),REQ
    #ENDBUTTON
    #BUTTON ('Global &Control Class Overrides'), FROM(%AppControlType, %ICClassDisplayText()),HLP('~ICGlobalExt_ClassOverrides'),AT(,,170)
      #PROMPT ('Override Default Class for Control', CHECK), %AppSetControlTypeClass,AT(10)
      #ENABLE (%AppSetControlTypeClass)
        #PROMPT ('Class Name:', FROM(%pClassName)), %AppControlTypeClassName,REQ
      #END
    #ENDBUTTON
    #BUTTON('Web Library Files'),AT(,,170)
      #BOXED('Web Library Files')
        #INSERT(%AbcLibraryPrompts(ABC))
      #ENDBOXED
    #ENDBUTTON
  #ENDTAB
#END
#!
#!
#ATSTART
  #CALL(%ReadABCFiles(ABC))
  #CALL(%SetupGlobalObjects)
  #DECLARE(%FrameControlInstance), UNIQUE
  #DECLARE(%FrameControlCopyCode, %FrameControlInstance)
  #EQUATE(%ICFileName, UPPER(CLIP(SUB(%Application,1,5))) & '_WB.CLW')
  #CALL(%InitControlTypes)
#END
#!
#AT(%GatherObjects),PRIORITY(100)
  #CALL(%AddObjectList(ABC), 'Broker')
  #CALL(%AddObjectList(ABC), 'HTMLManager')
  #CALL(%AddObjectList(ABC), 'WebServer')
  #CALL(%AddObjectList(ABC), 'WebFilesManager')
  #CALL(%AddObjectList(ABC), 'ShutdownManager')
#ENDAT
#!
#!
#AT (%BeforeGenerateApplication)
  #MESSAGE('Initialising Internet Template',1)
  #IF (NOT %Target32)
    #ERROR ('Internet templates only work in 32bit mode')
  #END
  #TYPEMAP('bool','long','short')
  #TYPEMAP('cbool','byte','byte')
  #TYPEMAP('WebControlId','long','long')
  #TYPEMAP('ResetType','long','short')
  #TYPEMAP('SOCKET','long')
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
  #CALL(%AddCategoryGlobal(ABC), 'Broker')
  #CALL(%AddCategoryGlobal(ABC), 'HTMLManager')
  #CALL(%AddCategoryGlobal(ABC), 'WebServer')
  #CALL(%AddCategoryGlobal(ABC), 'WebFilesManager')
  #CALL(%AddCategoryGlobal(ABC), 'ShutdownManager')
  #!
  #FIX (%Category, 'WEB')
  #EQUATE (%WebCategoryLinkMode, %CategoryLinkMode)
#END
#!
#!
#AT (%CustomGlobalDeclarations)
  #FIX(%Driver,'DOS')
  #ADD(%UsedDriverDLLs, %DriverDLL)
  #FIX(%Driver,'ASCII')
  #ADD(%UsedDriverDLLs, %DriverDLL)
#END
#!
#!
#AT (%BeforeGlobalIncludes)
   INCLUDE('WBFILE.INC'),ONCE
#END
#!
#!
#AT (%CustomGlobalDeclarations)
  #IF (NOT %GlobalExternal AND ~%NoGenerateGlobals)
    #IF (%GenerateModule)
      #CALL (%WriteBaseMethods)
    #END
    #PROJECT(%ICFilename)
  #END
  #FIX (%Category, 'WEB')
  #IF (%WebCategoryLinkMode)
    #PROJECT ('C%V%HTM%X%.LIB')
    #PROJECT ('WBSTD.CLW')
    #PROJECT ('WBSTD2.CLW')
    #FIX(%Driver,'DOS')
    #PROJECT(%DriverLIB)
  #ENDIF
  #PROJECT ('WBUNAUTH.HTM')
  #PROJECT ('WBDUMMY.HTM')
  #!ADD (%CustomGlobalMapIncludes, 'DDE.CLW')
#ENDAT
#!
#!
#AT (%BeginningExports)
  #IF (%ProgramExtension='DLL')
    #IF (%WebCategoryLinkMode)
      #CALL(%AddExpItem(ABC),'$WBBROWSERPROPERTIES')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBEFOREWINDOW')
      #CALL(%AddExpItem(ABC),'$A:EMBEDAFTERWINDOW')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBEFORECONTROL')
      #CALL(%AddExpItem(ABC),'$A:EMBEDAFTERCONTROL')
      #CALL(%AddExpItem(ABC),'$A:EMBEDINSIDETITLE')
      #CALL(%AddExpItem(ABC),'$A:EMBEDMETATAGS')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBEFOREHEADCLOSE')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBEFOREBODYOPEN')
      #CALL(%AddExpItem(ABC),'$A:EMBEDTOPOFFORM')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBOTTOMOFFORM')
      #CALL(%AddExpItem(ABC),'$A:EMBEDBEFOREHTMLCLOSE')
    #END
  #ENDIF
#ENDAT
#!
#!
#AT (%AfterGlobalIncludes)
   INCLUDE('LAYHTML.INT'),ONCE
   INCLUDE('LAYBUILD.INT'),ONCE
#INSERT (%OutputClassInclude)
#ENDAT
#!
#!
#AT(%GlobalData)
  #IF (~%NoGenerateGlobals)
    #IF (%ProgramExtension='EXE')
      #CALL(%GenerateClass(ABC), 'Broker', 'Application broker')
      #CALL(%GenerateClass(ABC), 'HTMLManager')
      #CALL(%GenerateClass(ABC), 'WebServer')
      #CALL(%GenerateClass(ABC), 'WebFilesManager')
      #CALL(%GenerateClass(ABC), 'ShutdownManager')
      #CALL(%GenerateClass(ABC), 'WebFileAccess')
    #ELSE
      #CALL(%GenerateClassRef(ABC), 'Broker', 'Application broker')
      #CALL(%GenerateClassRef(ABC), 'HTMLManager')
      #CALL(%GenerateClassRef(ABC), 'WebServer')
      #CALL(%GenerateClassRef(ABC), 'WebFilesManager')
      #CALL(%GenerateClassRef(ABC), 'ShutdownManager')
      #CALL(%GenerateClassRef(ABC), 'WebFileAccess')
    #END
  #ENDIF
#ENDAT
#!
#!
#AT (%GlobalMap)
#CALL(%AddModuleIncludeFile(ABC), %WebFrameClass)
#CALL(%AddModuleIncludeFile(ABC), 'WbBrowserPropertiesClass')
#ADD(%GlobalIncludeList, 'WBSTD.EQU')
#ADD(%GlobalIncludeList, 'WBSTD.INC')
  #IF (%ProgramExtension<>'DLL')
Web:Initialise()
  #ENDIF
#END
#!
#AT(%FileObjectDeclarations)
 #CALL(%GenerateDeclr(ABC),22,'WebTableProperties:' & %File,'WbTableProperties')
#ENDAT
#!
#AT (%ProgramSetup)
  #IF (%ProgramExtension<>'DLL')
Web:Initialise
  #ENDIF
#ENDAT
#!
#!
#AT (%ProgramEnd),WHERE(%ProgramExtension<>'DLL')
WebServer.Halt
#END
#!
#!
#AT (%ProgramProcedures), WHERE(%ProgramExtension<>'DLL')
Web:Initialise          PROCEDURE
  CODE
  SetWebActiveFrame
    #IF (NOT %DualModeApplication)
  IC:LoadBroker()
    #ENDIF
  WebFilesManager.Init(%UseLongFilenames, '%'PublicSubdirectory')
  WbFilesClass::Set(WebFilesManager)
  Broker.Init('%'Application', WebFilesManager)
  SetSkeletonTheme('%'AppSkeletonStyle')
  IF (Broker.GetEnabled())
    IF (IC:GetEnvironmentVariable('WEBPLATE'))
      AddSkeletonDirectory(IC:GetEnvironmentVariable('WEBPLATE'))
    END
#IF (%SkeletonSubdirectory)
    AddSkeletonDirectory('%'SkeletonSubdirectory\%'Application')
    AddSkeletonDirectory('%'SkeletonSubdirectory')
#ENDIF
  END
  WbBrowserProperties.Init(Broker)
  RegisterGlobalProperties('Browser',WbBrowserProperties.IProperties)
  HtmlManager.Init(WebFilesManager)
  WebServer.Init(Broker, ShutDownManager, '%'AppPageToReturnTo', %AppTimeOut, %|
    #IF (%JavaLocalClass)
''%|
    #ELSE
'%'JavaClassPath/'%|
    #ENDIF
, WebFilesManager)
    #IF ((%AppPageBackColor <> -1) OR %AppPageBackImage)
  WebServer.SetDialogPageBackground(%AppPageBackColor, '%'AppPageBackImage')
    #ENDIF
    #IF ((%AppWindowBackColor <> -1) OR %AppWindowBackImage)
  WebServer.SetDialogWindowBackground(%AppWindowBackColor, '%'AppWindowBackImage')
    #ENDIF
    #IF(%UseCookies)
  INIMgr.SetWeb(Broker, WebServer)
    #ENDIF
#ENDAT
#!
#!
#AT(%ShutdownManagerMethodCodeSection, 'Close', '()'),PRIORITY(6000)
WebServer.Kill
HtmlManager.Kill
Broker.Kill
WebFilesManager.Kill
IC:UnloadBroker()
#ENDAT
#!
#!
#AT(%BrokerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%HTMLManagerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%JavaEventsManagerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%WebServerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%WebFilesManagerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%ShutDownManagerMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%WebFileAccessMethodCodeSection),PRIORITY(5000),DESCRIPTION('Parent Call'),WHERE(%ParentCallValid())
  #CALL(%GenerateParentCall(ABC))
#ENDAT
#!
#!
#AT(%ProgramProcedures),WHERE(%ProgramExtension='EXE')
  #CALL(%GenerateVirtuals(ABC), 'Broker', 'Global Objects|Web Objects|Broker', '%BrokerVirtuals(Web)', %True)
  #CALL(%GenerateVirtuals(ABC), 'HTMLManager', 'Global Objects|Web Objects|HTML Manager', '%HtmlManagerVirtuals(Web)', %True)
  #CALL(%GenerateVirtuals(ABC), 'WebServer', 'Global Objects|Web Objects|Web Server', '%WebServerVirtuals(Web)', %True)
  #CALL(%GenerateVirtuals(ABC), 'WebFilesManager', 'Global Objects|Web Objects|Web Files Manager', '%WebFilesVirtuals(Web)', %True)
  #CALL(%GenerateVirtuals(ABC), 'ShutdownManager', 'Global Objects|Web Objects|Shutdown Manager', '%ShutdownVirtuals(Web)', %True)
  #CALL(%GenerateVirtuals(ABC), 'WebFileAccess', 'Global Objects|Web Objects|File Access', '%WebFileAccessVirtuals(Web)', %True)
#ENDAT
#!
#!
#AT(%InsideIsSkelActive)
ReturnValue = WebServer.IsEnabled()
#ENDAT
#!
#AT(%AfterSettingFileTags),PRIORITY(9000)
WebTableProperties:%File.Init('%File', '')
SetTableProperties(WebTableProperties:%File, '%File')
#ENDAT
#!
#AT(%FileManagerCodeSection,,'Kill','()'),PRIORITY(1000)
WebTableProperties:%File.Kill
#ENDAT
#!
#GROUP (%BrokerVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%BrokerMethodDataSection,'Application Broker Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,PREPARE(,%FixClassName(%FixBaseClassToUse('Broker'))),TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%BrokerMethodCodeSection,'Application Broker Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,PREPARE(,%FixClassName(%FixBaseClassToUse('Broker'))),TREE(%TreeText & %CodeText)
#!
#GROUP (%HtmlManagerVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%HTMLManagerMethodDataSection,'HTML Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%HTMLManagerMethodCodeSection,'HTML Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#GROUP (%JavaEventsVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%JavaEventsManagerMethodDataSection,'Java Events Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%JavaEventsManagerMethodCodeSection,'Java Events Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#GROUP (%WebServerVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%WebServerMethodDataSection,'Web Server Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%WebServerMethodCodeSection,'Web Server Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#GROUP (%WebFilesVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%WebFilesManagerMethodDataSection,'Web Files Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%WebFilesManagerMethodCodeSection,'Web Files Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#GROUP (%ShutdownVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%ShutdownManagerMethodDataSection,'Shutdown Manager Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%ShutdownManagerMethodCodeSection,'Shutdown Manager Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#GROUP (%WebFileAccessVirtuals, %TreeText, %DataText, %CodeText)
#EMBED(%WebFileAccessMethodDataSection,'Web File Access Method Data Section'),%pClassMethod,%pClassMethodPrototype,LABEL,DATA,TREE(%TreeText & %DataText)
  #?CODE
  #EMBED(%WebFileAccessMethodCodeSection,'Web File Access Method Executable Code Section'),%pClassMethod,%pClassMethodPrototype,TREE(%TreeText & %CodeText)
#!
#!
#GROUP(%UseCookiesAccepted),AUTO
  #ALIAS(%GlobalClassItem, %ClassItem, 0),APPLICATION
  #ALIAS(%GlobalUseABCBaseClass, %UseABCBaseClass, 0),APPLICATION
  #ALIAS(%GlobalUseDefaultABCBaseClass, %UseDefaultABCBaseClass, 0),APPLICATION
  #ALIAS(%GlobalABCBaseClass, %ABCBaseClass, 0),APPLICATION
  #ALIAS(%GlobalActualBaseClassType, %ActualDefaultBaseClassType, 0),APPLICATION
  #ALIAS(%GlobalExtBaseClass, %ExtBaseClass, 0),APPLICATION
  #CALL(%NoCaseFix(ABC), %GlobalClassItem, 'INIManager')
  #IF(%UseCookies)
    #SET(%GlobalUseDefaultABCBaseClass, %False)
    #SET(%GlobalABCBaseClass, %CookieClass)
  #ELSE
    #SET(%GlobalUseDefaultABCBaseClass, %True)
    #SET(%GlobalABCBaseClass, %INIClass)
  #ENDIF
  #SET(%GlobalUseABCBaseClass, %True)
  #CLEAR(%GlobalActualBaseClassType)
  #CLEAR(%GlobalExtBaseClass)
#!
#!
#INCLUDE('WBGRP.TPW')
#INCLUDE('WBPROC.TPW')
#INCLUDE('WBCODE.TPW')
#INCLUDE('WBGUARD.TPW')
#INCLUDE('WBHITS.TPW')
#INCLUDE('WBREPORT.TPW')
#INCLUDE('WBSUBMIT.TPW')
#INCLUDE('WBSHTML.TPW')
#!
#!-------------------------------------------------------
#GROUP (%ModuleBaseRemovePath),AUTO
#DECLARE (%Temp)
#CALL (%ModuleBaseRemovePath(ABC)),%Temp
#RETURN %Temp
#!
#!
