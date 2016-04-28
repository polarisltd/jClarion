#TEMPLATE (Internet, 'Internet Deployment Templates v1.5'),FAMILY('ABC'),FAMILY('CW20')
#HELP('IC55.HLP')
#!
#EXTENSION (Internet, 'Internet Application Extension'),APPLICATION(InterProc(Internet)),FIRST,SINGLE,HLP('~ICGlobalExt')
#!
#PREPARE
  #CALL (%InitControlTypes)
#END
#!
#BOXED, WHERE(%False), AT(,,0,0)
  #BUTTON ('Hidden controls'),AT(,,0,0)
    #PROMPT ('', @S255),%AppControlType,MULTI(''),UNIQUE
    #BUTTON (''), FROM(%AppControlType, '')
      #PROMPT ('',@s255),%AppControlTypeClassDefault
    #END
    #PROMPT ('', @s255),%AppClassQueue,MULTI(''),UNIQUE
    #PROMPT ('', @s255),%AppPseudoControl,MULTI(''),UNIQUE
  #END
#END
#SHEET, HSCROLL
  #TAB ('&Window')
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
    #BOXED ('Help')
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
    #BUTTON('Window Com&ponents...'), AT(,,180),HLP('~ICGlobalExt_WindowComponents')
      #SHEET
        #TAB('&Caption')
          #BOXED ('Ca&ption')
            #PROMPT ('Include caption', CHECK), %AppDisplayCaption, AT(10),DEFAULT(1)
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
  #TAB ('&Control'),HLP('~ICGlobalExt_Control')
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
    #BOXED ('Formatting')
      #BOXED ('HTML scaling - Pixels Per Character')
        #PROMPT ('Horizontal:', SPIN(@n2,1,99)),%AppPixelsPerCharX,DEFAULT(6)
        #PROMPT ('Vertical:', SPIN(@n2,1,99)),%AppPixelsPerCharY,DEFAULT(13)
      #END
      #PROMPT ('Delta for grid snapping:', SPIN(@n2b, 0,99)),%AppGridSnapDeltaX,DEFAULT(2),AT(96,,40)
      #PROMPT ('', SPIN(@n2b, 0,99)),%AppGridSnapDeltaY,DEFAULT(2),AT(140,,40)
    #END
    #BOXED ('Application')
      #PROMPT ('Page to return to on exit:', @s255), %AppPageToReturnTo
      #PROMPT ('Time out (seconds):', SPIN(@n5, 0, 9999)), %AppTimeOut,DEFAULT(600)
      #PROMPT ('Sub directory for pages:', @s255), %PublicSubdirectory
      #PROMPT ('Classes local to application broker', CHECK), %JavaLocalClass,DEFAULT('1'),AT(10,,180)
      #ENABLE (NOT %JavaLocalClass)
        #PROMPT ('Location of classes:', @s255),%JavaClassPath,DEFAULT('http://www.topspeed.com')
      #END
      #PROMPT ('Use long filenames', CHECK), %UseLongFilenames,DEFAULT('1'),AT(10,,180)
    #END
  #END
  #TAB ('C&lasses'),HLP('~ICGlobalExt_Classes')
    #BUTTON ('Class overrides'), FROM(%AppControlType, %ICClassDisplayText()), INLINE,AT(,,,200),HLP('~ICGlobalExt_ClassOverrides')
      #PROMPT ('Override default class', CHECK), %AppSetControlTypeClass,AT(10)
      #ENABLE (%AppSetControlTypeClass)
        #PROMPT ('Class Name:', @S255), %AppControlTypeClassName
        #PROMPT ('Header file:', OPENDIALOG('Select Header File', 'INC files (*.inc)|*.inc|All Files (*.*)|*.*')), %AppControlTypeClassHeader
        #PROMPT ('Implementation file:', OPENDIALOG('Select Implementation File', 'INC files (*.clw)|*.clw|All Files (*.*)|*.*')), %AppControlTypeClassCode
      #END
    #END
  #END
#END
#!
#ATSTART
  #DECLARE(%FrameControlInstance), UNIQUE
  #DECLARE(%FrameControlCopyCode, %FrameControlInstance)
  #EQUATE(%ICFileName, UPPER(SUB(%Application,1,5)) & '_IC.CLW')
  #!
  #CALL (%InitControlTypes)
  #CALL (%InitPseudoControl)
#END
#!
#!
#AT (%BeforeGenerateApplication)
  #MESSAGE('Initialising Internet Template',1)
  #!
  #IF (NOT %Target32)
    #ERROR ('Internet templates only work in 32bit mode')
  #END
#END
#AT (%CustomGlobalDeclarations)
  #FIX(%Driver,'DOS')
  #ADD(%UsedDriverDLLs, %DriverDLL)
  #FIX(%Driver,'ASCII')
  #ADD(%UsedDriverDLLs, %DriverDLL)
#END
#!
#!
#AT (%CustomGlobalDeclarations)
  #IF (NOT %GlobalExternal)
    #PROJECT ('ICSTD.CLW')
    #PROJECT(%ICFilename)
    #IF (%CWversion >= '2100')
      #PROJECT ('C%V%HTM%X%.LIB')
    #ELSE
      #PROJECT ('CW2HTM%S%.LIB')
    #END
    #FIX(%Driver,'ASCII')
    #PROJECT(%DriverLIB)
    #FIX(%Driver,'DOS')
    #PROJECT(%DriverLIB)
    #IF (%GenerateModule)
      #CALL (%WriteBaseMethods)
    #END
  #END
  #PROJECT ('ICUNAUTH.HTM')
  #ADD (%CustomGlobalMapIncludes, 'dde.clw')
#ENDAT
#!
#!
#AT (%BeforeGlobalIncludes)
  #IF (NOT %GlobalExternal)
LinkBaseClasses      EQUATE(1)
BaseClassDllMode     EQUATE(0)
  #ELSE
LinkBaseClasses      EQUATE(0)
BaseClassDllMode     EQUATE(1)
  #END
#END
#!
#!
#AT (%AfterGlobalIncludes)
   INCLUDE('ICTXTOUT.INC')
   INCLUDE('ICBROKER.INC')
   INCLUDE('ICWINDOW.INC')
   INCLUDE('ICCNTRLS.INC')
   INCLUDE('ICCLIENT.INC')
   INCLUDE('ICREPORT.INC')
   INCLUDE('ICSTD.EQU')
   #INSERT (%OutputClassInclude)
#ENDAT
#!
#!
#AT(%GlobalData)
  #DECLARE (%IsExternal)
  #DECLARE (%IsDll)
  #IF (%GlobalExternal)
    #SET (%IsDll,      ',DLL(dll_mode)')
    #SET (%IsExternal, ',EXTERNAL,DLL(dll_mode)')
  #END
Broker               BrokerClass%IsExternal
HtmlManager          HtmlClass%IsExternal
JavaEvents           JslEventsClass%IsExternal
WebServer            WebServerClass%IsExternal
WebFilesManager      WebFilesClass%IsExternal
  #IF (%GlobalExternal)
ShutDownManager      ShutDownClass%IsExternal
  #ELSE
ShutDownManager      CLASS(ShutDownClass)
Close                  PROCEDURE,VIRTUAL
                     END
  #END
ICServerWin          WINDOW,AT(-100,-100,0,0)
                     END
#END
#AT (%ProgramProcedures),WHERE(NOT %GlobalExternal)
ShutDownManager.Close    PROCEDURE
  CODE

  WebServer.Kill
  HtmlManager.Kill
  Broker.Kill()
  JavaEvents.Kill
  WebFilesManager.Kill
#ENDAT
#!
#!
#!
#AT (%GlobalMap)
MODULE('')
  WebControlFactory(SIGNED),*WebControlClass
  GetWebActiveFrame(),*WebFrameClass
  SetWebActiveFrame(<*WebFrameClass>)
END
INCLUDE('ICSTD.INC')
#END
#!
#!
#AT (%ProgramSetup)
#IF (%ProgramExtension<>'DLL')
SetWebActiveFrame
WebFilesManager.Init(%UseLongFilenames, '%'PublicSubdirectory')
JavaEvents.Init
Broker.Init('%'Application', WebFilesManager)
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
#END
#IF ((%AppWindowBackColor <> -1) OR %AppWindowBackImage)
WebServer.SetDialogWindowBackground(%AppWindowBackColor, '%'AppWindowBackImage')
#END
IF (WebServer.GetInternetEnabled())
  WebServer.Connect
END
#ENDIF
#END
#!
#!
#AT (%ProgramEnd),WHERE(%ProgramExtension<>'DLL')
WebServer.Halt
#END
#!
#AT (%DLLExportList)
  #IF (NOT %GlobalExternal AND (%ProgramExtension='DLL'))
    #CALL (%DeclareClassVariables)
    #CALL (%ReadIncludeFile, 'ICBROKER.INC')
    #CALL (%ReadIncludeFile, 'ICCLIENT.INC')
    #CALL (%ReadIncludeFile, 'ICFILES.INC')
    #CALL (%ReadIncludeFile, 'ICHTML.INC')
    #CALL (%ReadIncludeFile, 'ICHTTP.INC')
    #CALL (%ReadIncludeFile, 'ICEVENT.INC')
    #CALL (%ReadIncludeFile, 'ICJSL.INC')
    #CALL (%ReadIncludeFile, 'ICLAYOUT.INC')
    #CALL (%ReadIncludeFile, 'ICREPORT.INC')
    #CALL (%ReadIncludeFile, 'ICSERVER.INC')
    #CALL (%ReadIncludeFile, 'ICSINK.INC')
    #CALL (%ReadIncludeFile, 'ICTXTOUT.INC')
    #CALL (%ReadIncludeFile, 'ICWINDOW.INC')
    #CALL (%ReadIncludeFile, 'ICCNTRLS.INC')
    #!
    #! Read include files for any global over-rides...
    #!
    #FOR (%AppControlType), WHERE(%AppSetControlTypeClass AND %AppControlTypeClassHeader)
      #CALL (%ReadIncludeFile, %AppControlTypeClassHeader)
    #END
    #!
#!;Start of TopSpeed Base class library exports
    #FOR(%ClassName),WHERE(%ClassModule<>'ABSTRACT')
  #INSERT(%AddExpItem,'VMT$'&CLIP(%ClassName))
  #INSERT(%AddExpItem,'TYPE$'&CLIP(%ClassName))
      #FOR(%ClassMethod),WHERE(~%ClassMethodPrivate)
        #FOR (%ClassMethodPrototype)
  %[55]ClassMethodLinkName @?
        #ENDFOR
      #ENDFOR
    #ENDFOR
  #INSERT(%AddExpItem,'$Broker')
  #INSERT(%AddExpItem,'$HtmlManager')
  #INSERT(%AddExpItem,'$JavaEvents')
  #INSERT(%AddExpItem,'$ShutdownManager')
  #INSERT(%AddExpItem,'$WebServer')
  #INSERT(%AddExpItem,'$WebFilesManager')
  #INSERT(%AddExpPrototype, 'WebControlFactory(SIGNED),*WebControlClass')
  #INSERT(%AddExpPrototype, 'GetWebActiveFrame(),*WebFrameClass')
  #INSERT(%AddExpPrototype, 'SetWebActiveFrame(<<*WebFrameClass>)')
#!;End of TopSpeed Base class library exports
  #ENDIF
#ENDAT
#!
#!--------------------------- Print Preview Hook --------------------------
#!
#AT( %DataOfReportPreview ),WHERE(%CWTemplateVersion < 'v3')
#INSERT(%HtmlPreviewHookData)
#ENDAT
#AT( %DataSection ),WHERE((NOT(%CWTemplateVersion < 'v3')) AND (%ProcedureTemplate='Report'))
#INSERT(%HtmlPreviewHookData)
#ENDAT
#!
#AT( %StartOfReportPreview ),WHERE(%CWTemplateVersion < 'v3')
#INSERT(%HtmlPreviewHookStart)
#ENDAT
#AT( %BeforePrintPreview ),WHERE(NOT(%CWTemplateVersion < 'v3') AND (%ProcedureTemplate='Report'))
#INSERT(%HtmlPreviewHookStart)
#ENDAT
#!
#AT( %EndOfReportPreview ),WHERE(%CWTemplateVersion < 'v3')
#INSERT(%HtmlPreviewHookEnd)
#ENDAT
#AT( %BeforeClosingReport ),WHERE(NOT(%CWTemplateVersion < 'v3') AND (%ProcedureTemplate='Report'))
#INSERT(%HtmlPreviewHookEnd)
#ENDAT
#!
#!
#!--------------------------- Extension added to each procedure -------------------------
#!
#EXTENSION (InterProc, 'Internet Procedure Extension'),PROCEDURE,SHOW,FIRST,SINGLE,HLP('~ICProcedureExt')
#PREPARE
  #CALL (%InitFrameControls)
  #CALL (%CascadeGlobalOption)
  #CALL (%InitPseudoControl)
  #CALL (%WinProgressTimerSet)
#END
#BOXED, WHERE(%False), AT(,,0,0)
  #BUTTON ('Hidden controls'),AT(,,0,0)
    #PROMPT ('', @s20), %FrameMenu, MULTI(''),UNIQUE
    #PROMPT ('', @s20), %FrameTool, MULTI(''),UNIQUE
  #END
#END
#BUTTON ('&Internet Options...'),AT(,,180)
  #SHEET, HSCROLL
    #TAB ('&Window')
      #BOXED, WHERE(%Window), HIDE
        #BOXED ('Pa&ge')
          #PROMPT ('Override global settings', CHECK), %WinOverridePage, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
          #ENABLE (%WinOverridePage)
            #PROMPT ('Center window on page', CHECK), %WinCenterWindow,AT(10)
            #PROMPT ('Background color:', COLOR), %WinPageBackColor,DEFAULT(-1)
            #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinPageBackImage
          #END
        #END
        #BOXED ('Win&dow')
          #PROMPT ('Override global settings', CHECK), %WinOverrideWindow, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
          #ENABLE (%WinOverrideWindow)
            #PROMPT ('Background color:', COLOR), %WinWindowBackColor,DEFAULT(-1)
            #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinWindowBackImage
            #PROMPT ('Window border width:', SPIN(@n3, 0, 999)), %WinWindowBorderWidth,DEFAULT(2)
          #END
        #END
        #ENABLE (%AppHelpEnabled)
          #BOXED ('Help')
            #PROMPT ('Override global settings', CHECK), %WinOverrideHelp, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
            #ENABLE (%WinOverrideHelp)
              #PROMPT ('Help ids are links within a base document', CHECK), %WinHelpRelative,AT(10)
              #BOXED, SECTION
                #BOXED, WHERE(%WinHelpRelative), AT(,0)
                  #PROMPT ('Help document:', @s255), %WinHelpDocument
                #END
                #BOXED, WHERE(NOT %WinHelpRelative), AT(,0)
                  #PROMPT ('URL of help documents:', @s255), %WinHelpURL
                #END
              #END
              #PROMPT ('Help window style', @s255), %WinHelpStyle
            #END
          #END
        #END
        #BUTTON('Window Com&ponents...'), AT(,,172),HLP('~ICProcedureExt_WindowComponents')
          #SHEET
            #TAB('&Caption')
              #BOXED ('Ca&ption')
                #PROMPT ('Override global settings', CHECK), %WinOverrideCaption, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
                #ENABLE (%WinOverrideCaption)
                  #PROMPT ('Include caption', CHECK), %WinDisplayCaption, AT(10),DEFAULT(1)
                  #ENABLE (%WinDisplayCaption)
                    #PROMPT ('Background color:', COLOR), %WinCaptionBackColor, DEFAULT(800000H)
                    #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinCaptionBackImage
                    #PROMPT ('Alignment:', DROP('Left[PROP:left]|Center[PROP:center]|Right[PROP:right]')), %WinCaptionAlign, DEFAULT('PROP:center')
                    #PROMPT ('Font family name:', @s255), %WinCaptionFontFace, DEFAULT('')
                    #PROMPT ('Font size:', SPIN(@n3b, 0, 127)), %WinCaptionFontSize, DEFAULT(0)
                    #PROMPT ('Font color:', COLOR), %WinCaptionFontColor, DEFAULT(-1)
                  #END
                #END
              #END
            #END
            #TAB ('&Menu'),HLP('~ICGlobalExt_WindowComponents_Menu')
              #BOXED ('M&enu')
                #PROMPT ('Override global settings', CHECK), %WinOverrideMenu, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
                #ENABLE (%WinOverrideMenu)
                  #PROMPT ('Background color:', COLOR), %WinMenuBackColor,DEFAULT(099CCCCH)
                  #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinMenuBackImage
                  #PROMPT ('Alignment:', DROP('Left of Window[PROP:left]|Above Toolbar[PROP:above]')), %WinMenuAlign, DEFAULT('PROP:above')
                #END
              #END
            #END
            #TAB('&Toolbar'),HLP('~ICGlobalExt_WindowComponents_Toolbar')
              #BOXED ('Tool&bar')
                #PROMPT ('Override global settings', CHECK), %WinOverrideToolbar, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
                #ENABLE (%WinOverrideToolbar)
                  #PROMPT ('Background color:', COLOR), %WinToolbarBackColor,DEFAULT(-1)
                  #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinToolbarBackImage
                #END
              #END
              #BOXED ('C&lose button')
                #PROMPT ('Override global settings', CHECK), %WinOverrideClose, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
                #ENABLE (%WinOverrideClose)
                  #PROMPT ('Create extra close button', CHECK),%WinCreateExtraClose,AT(10)
                  #ENABLE (%WinCreateExtraClose)
                    #PROMPT ('Image for close:', OPENDIALOG('Select close Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinToolbarCloseImage, DEFAULT('exit.ico')
                  #END
                #END
              #END
            #END
            #TAB ('Client &Area'),HLP('~ICGlobalExt_WindowComponents_ClientArea')
              #BOXED ('Win&dow')
                #PROMPT ('Override global settings', CHECK), %WinOverrideClientArea, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
                #ENABLE (%WinOverrideClientArea)
                  #PROMPT ('Background color:', COLOR), %WinClientAreaBackColor,DEFAULT(-1)
                  #PROMPT ('Background image:', OPENDIALOG('Select background Image', 'GIF Images (*.gif)|*.gif|JPEG Images (*.jpg;*.jpeg)|*.jpg;*.jpeg|All Files (*.*)|*.*')), %WinClientAreaBackImage
                #END
              #END
            #END
          #END
        #END
      #END
      #BOXED ('General')
        #PROMPT ('Return if launched from browser', CHECK), %WinDisableFromBrowser,AT(10)
      #END
    #END
    #TAB ('&Report'),WHERE(%False)
      #BOXED ('Pa&ges')
        #PROMPT ('Display All Pages', CHECK), %RptDisplayAllPages, AT(10)
        #ENABLE (NOT %RptDisplayAllPages)
          #PROMPT ('Pages on display', SPIN(@n5, 1, 9999)), %RptPagesOnDisplay
        #END
      #END
    #END
    #TAB ('&Controls'),HLP('~ICProcedureExt_Controls'),WHERE(%Window)
      #BOXED ('General')
        #PROMPT ('', CHECK), %WinSetOnDisabled,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetOnDisabled)
          #PROMPT ('If control disabled:', DROP('Hide control[Hide]|Hide if cannot disable[OptHide]|Show control[Show]')), %WinOnDisabled,DEFAULT('Hide'),PROMPTAT(20,,77),AT(97,,87)
        #END
      #END
      #BOXED ('Drop listboxes')
        #PROMPT ('', CHECK), %WinSetJavaDropList,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetJavaDropList)
          #PROMPT ('Replace with Java non-drop list', CHECK), %WinJavaDropList,AT(20)
        #END
      #END
      #BOXED('Sheets')
        #PROMPT ('', CHECK), %WinSetSheetBorderWidth,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetSheetBorderWidth)
          #PROMPT ('Border width:', SPIN(@n2,0,99)),%WinSheetBorderWidth,PROMPTAT(20,,77),AT(97,,87)
        #END
      #END
      #BOXED('Options')
        #PROMPT ('', CHECK), %WinSetOptionBorderWidth,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetOptionBorderWidth)
          #PROMPT ('Border width (if boxed):', SPIN(@n2,0,99)),%WinOptionBorderWidth,PROMPTAT(20,,77),AT(97,,87)
        #END
      #END
      #BOXED('Groups')
        #PROMPT ('', CHECK), %WinSetGroupBorderWidth,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetGroupBorderWidth)
          #PROMPT ('Border width (if boxed):', SPIN(@n2,0,99)),%WinGroupBorderWidth,PROMPTAT(20,,77),AT(97,,87)
        #END
      #END
      #BOXED ('Individual control options')
        #BUTTON ('Individual Override for ' & %Control), FROM(%Control, %Control), WHERE(%Control), INLINE,AT(,,,80)
          #INSERT (%IndividualControlPrompts)
        #END
      #END
    #END
    #TAB('&MDI'),WHERE(EXTRACT(%WindowStatement,'APPLICATION')),HLP('~ICProcedureExt_MDIFrame')
      #BOXED ('Application Menu')
        #PROMPT ('Override global settings', CHECK), %WinSetAppMenubar, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetAppMenubar)
          #PROMPT ('Include On Child Windows:', DROP('Global Setting[Default]|All Menu Items[All]|No Menu Items[None]|Selected Menu Items[Some]')),%MenuCopy,DEFAULT('Default')
          #ENABLE (%MenuCopy = 'All')
            #PROMPT ('Ignore Frame Code', CHECK),%MenuIgnoreCode,AT(10)
          #END
          #ENABLE (%MenuCopy = 'Some')
            #BUTTON ('Individual Action'), FROM(%FrameMenu, 'Actions for ' & %FrameMenu), INLINE,AT(,,,60)
              #PROMPT ('Remove from child', CHECK), %MenuControlIgnore
              #ENABLE (NOT %MenuControlIgnore)
                #PROMPT ('Ignore Frame Code', CHECK), %MenuControlIgnoreCode
              #END
            #END
          #END
        #END
      #END
      #BOXED ('Application Toolbar')
        #PROMPT ('Override global settings', CHECK), %WinSetAppToolbar, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinSetAppToolbar)
          #PROMPT ('Include On Child Windows:', DROP('Global Setting[Default]|All Toolbar Items[All]|Standard Toolbar Only[Standard]|No Toolbar Items[None]|Selected Toolbar Items[Some]')),%ToolCopy,DEFAULT('Default')
          #ENABLE (%ToolCopy = 'All')
            #PROMPT ('Ignore Frame Code', CHECK),%ToolIgnoreCode,AT(10)
          #END
          #ENABLE (%ToolCopy = 'Some')
            #BUTTON ('Individual Action'), FROM(%FrameTool, 'Actions for ' & %FrameTool), INLINE,AT(,,,60)
              #PROMPT ('Remove from child', CHECK), %ToolControlIgnore
              #ENABLE (NOT %ToolControlIgnore)
                #PROMPT ('Ignore Frame Code', CHECK), %ToolControlIgnoreCode
              #END
            #END
          #END
        #END
      #END
    #END
    #TAB('&MDI'),WHERE(EXTRACT(%WindowStatement,'MDI')),HLP('~ICProcedureExt_MDIUse')
      #BOXED ('Merging Options')
        #PROMPT ('Merge frame menu', CHECK), %WinMergeMenu, AT(10), DEFAULT(1)
        #PROMPT ('Merge frame toolbar', CHECK), %WinMergeTool, AT(10), DEFAULT(1)
      #END
    #END
    #TAB ('Advanced'),HLP('~ICProcedureExt_Advanced')
      #BOXED ('Formatting')
        #PROMPT ('Override global settings', CHECK), %WinOverrideFormat, AT(10),DEFAULT(0),WHENACCEPTED(%CascadeWindowOption())
        #ENABLE (%WinOverrideFormat)
          #BOXED ('HTML scaling - Pixels Per Character')
            #PROMPT ('Horizontal:', SPIN(@n2,1,99)),%WinPixelsPerCharX,DEFAULT(6)
            #PROMPT ('Vertical:', SPIN(@n2,1,99)),%WinPixelsPerCharY,DEFAULT(13)
          #END
          #PROMPT ('Delta for grid snapping:', SPIN(@n2b, 0,99)),%WinGridSnapDeltaX,DEFAULT(2),AT(96,,40)
          #PROMPT ('', SPIN(@n2b, 0,99)),%WinGridSnapDeltaY,DEFAULT(2),AT(140,,40)
        #END
      #END
      #BOXED ('Security')
        #PROMPT ('Transfer over a secure connection', CHECK), %WinSecure, AT(10)
        #PROMPT ('Restrict access to this procedure', CHECK), %WinAuthorize, AT(10)
        #ENABLE (%WinAuthorize)
          #DISPLAY ('Override the password validation - or use the following')
          #PROMPT ('Password:', OPTFIELD), %WinAuthorizePassword
          #PROMPT ('Case sensitive', CHECK), %WinAuthorizeCaseSensitive,DEFAULT(0),AT(10)
        #END
      #END
      #BOXED ('Window refresh')
        #ENABLE(%ProcedureTemplate='Report' OR %ProcedureTemplate='Process')
          #BOXED, WHERE(%Window), HIDE
            #ENABLE(NOT %WinProgressTimerSet())
              #PROMPT ('Show progress window', CHECK), %WinProgressTimer, AT(10)
            #END
            #ENABLE (%WinProgressTimer)
              #PROMPT ('Time between refresh:', @n5), %WinProgressTimerDelay, DEFAULT(2)
              #PROMPT ('Action on timer:', DROP('Partial page refresh[Partial]|Submit page[Full]|Complete refresh Page[Refresh]')), %WinProgressTimerAction, DEFAULT('Partial')
            #END
          #END
        #END
        #ENABLE (NOT %WinProgressTimer)
          #PROMPT ('Enable window refresh on timer', CHECK), %WinTimer, AT(10)
          #ENABLE (%WinTimer)
            #PROMPT ('Time between refresh:', @n5), %WinTimerDelay, DEFAULT(10)
            #PROMPT ('Action on timer:', DROP('Partial page refresh[Partial]|Submit page[Full]|Complete refresh Page[Refresh]')), %WinTimerAction, DEFAULT('Partial')
          #END
        #END
      #END
    #END
  #END
#END
#!
#ATSTART
  #DECLARE (%IsFrame)
  #DECLARE (%CreatedLocalProcedures)
  #DECLARE (%ControlIsDerived, %Control)
  #DECLARE (%PseudoControlIsDerived, %AppPseudoControl)
  #DECLARE (%DeriveWindowTitleContents)
  #DECLARE (%DeriveWindowBodyHeader)
  #DECLARE (%DeriveWindowBodyFooter)
  #DECLARE (%DeriveWindowCreateHtmlPage)
  #DECLARE (%DeriveWindowValidatePassword)
  #DECLARE (%DeriveWindowTakeUnknownSubmit)
  #!

  #EQUATE (%FrameManagerName, %GetFrameManagerName())
  #IF (EXTRACT(%WindowStatement, 'APPLICATION'))
    #SET (%IsFrame, %True)
  #END
  #CALL (%CascadeGlobalOption)
  #!
  #CALL (%WinProgressTimerSet)
  #CALL (%CheckQBEList)
#END
#!
#!
#AT (%CustomModuleDeclarations),AUTO
  #DECLARE (%IncludeFile), UNIQUE
  #FOR (%Control), WHERE(%CtlSetClass AND %CtlClassHeader)
    #ADD (%IncludeFile, %CtlClassHeader)
  #END
  #FOR (%IncludeFile)
   INCLUDE('%'IncludeFile')
  #END
#END
#!
#!
#AT (%DataSectionBeforeWindow),WHERE(%ProcedureHasWebWindow())
  #IF (%IsFrame())
    #CALL(%CalculateFrameControls)
  #END
  #SET (%CreatedLocalProcedures, %True)
  #SECTION
  #CREATE ('ICLOCAL.$$$')
  #CALL (%GenerateLocalProcedures)
  #CLOSE
  #ENDSECTION
#END
#!
#!
#AT (%DataSectionAfterWindow),WHERE(%ProcedureHasWebWindow() AND (%CWversion >= '5000') AND %FindControlTemplate('BrowseQBEButton(ABC)'))
#INSERT(%WebWindowDeclare,'QBEWebWindow')
#END
#AT (%DataSectionAfterWindow),WHERE(%ProcedureHasWebWindow())
  #IF (%IsFrame())
%[20](%Procedure & 'Frame') CLASS(WebFrameClass),MODULE('%Module')
CopyControlsToWindow   PROCEDURE(*WebWindowClass,BYTE,BYTE),VIRTUAL
TakeEvent              PROCEDURE,SIGNED,VIRTUAL
FrameWindow            &WINDOW
                     END
  #END
#INSERT(%WebWindowDeclare)
IC:CurControl        &WebControlClass      #<! Temporary control pointer
IC:CurFrame          &WebFrameClass
#END
#!
#!
#AT (%QBEVisualMethodCodeSection,,'Init','(),BYTE'),WHERE(%ProcedureHasWebWindow() AND (%CWversion >= '5000')),AUTO
#INSERT(%WebWindowInit, 'QBEWebWindow')
#ENDAT
#AT (%AfterWindowOpening),WHERE(%ProcedureHasWebWindow()),AUTO
#INSERT(%WebWindowInit)
#END
#!
#!
#AT (%QBEVisualMethodCodeSection,,'Kill','(),BYTE'),WHERE(%ProcedureHasWebWindow() AND %CWversion >= '5000'),PRIORITY(9000)
#INSERT(%WebWindowKill, 'QBEWebWindow')
#ENDAT
#AT (%AfterWindowClosing),WHERE(%ProcedureHasWebWindow())
#INSERT(%WebWindowKill)
#END
#!
#!
#AT (%ProcedureSetup)
  #IF (%WinDisableFromBrowser)
IF (WebServer.Active)
  POPBIND
  RETURN
END
  #END
  #IF (%IsFrame)
%FrameManagerName.FrameWindow &= %Window
  #END
  #IF (%Report)
WebFilesManager.SelectTarget(Secure:%(CHOOSE(%WinSecure,'Full','None')))
  #END
#END
#!
#!
#AT (%ControlOtherEventHandling)
  #IF (%ControlInstance)
    #FIND (%ActiveTemplateInstance, %ControlInstance, %ActiveTemplate)
    #IF (%ActiveTemplate = 'BrowseBox(Clarion)')
IF (EVENT() = EVENT:RefreshPage)
  DO BRW%ActiveTemplateInstance::RefreshPage
END
    #END
  #END
#END
#!
#!
#AT (%QBEVisualMethodCodeSection,,'TakeEvent','(),BYTE'),WHERE(%ProcedureHasWebWindow() AND %CWversion >= '5000'),PRIORITY(4100)
IF QBEWebWindow.TakeEvent()
  RETURN Level:Fatal
END
#ENDAT
#AT(%WindowManagerMethodCodeSection,'TakeEvent','(),BYTE'),WHERE(%ProcedureHasWebWindow()),PRIORITY(4100)
  #INSERT(%WebWindowTakeEvent)
#END
#AT(%AcceptLoopBeforeEventHandling),WHERE(%ProcedureHasWebWindow()),PRIORITY(4050)
  #IF (%CWTemplateVersion < 'v3')
#INSERT(%WebWindowTakeEvent)
  #END
#END
#!
#!
#AT (%DataSection),PRIORITY(5050)
#INSERT(%LocalClassDefs)
#END
#AT (%LocalClassDefinition)
  #IF (%CWTemplateVersion < 'v3')
#INSERT(%LocalClassDefs)
  #END
#END
#!
#!
#AT (%AfterAPPENDStatement)
  #IF (%CreatedLocalProcedures)
    #APPEND('ICLOCAL.$$$'),SECTION
    #REMOVE('ICLOCAL.$$$')
  #END
#END
#AT (%LocalProcedures)
  #IF (%CWTemplateVersion < 'v3')
    #IF (%CreatedLocalProcedures)
      #APPEND('ICLOCAL.$$$'),SECTION
      #REMOVE('ICLOCAL.$$$')
    #END
  #END
#END
#!
#!
#AT (%EndScrollUp)
IC:CurControl &= WebWindow.GetControlInfo(%ListControl)
IC:CurControl.ResetFromQueue(ACTION:Scroll, +1)
#END
#!
#!
#AT (%EndScrollDown)
IC:CurControl &= WebWindow.GetControlInfo(%ListControl)
IC:CurControl.ResetFromQueue(ACTION:Scroll, -1)
#END
#!
#!
#AT (%StartOfBrowseFormFilter)
IF (WebServer.Active)
  IF NOT BrowseButtons.ListBox{PROP:visible} THEN  ! List box must be visible
    EXIT
  END
ELSE
#END
#!
#!
#AT (%EndOfBrowseFormFilter)
END
#END
#!
#!
#CODE (GetCookie, 'Read the value of a cookie'),DESCRIPTION(%CookieTarget & ' = GetCookie(''' & %CookieName & ''')'),HLP('~ICCodeGetCookie')
#BOXED ('Get Cookie')
  #DISPLAY ('This code template retrieves the value of a cookie from the client computer.  The cookie can only be got after a request from the broker has been processed.'), AT(,,180)
  #PROMPT ('Cookie name:', @s255),%CookieName
  #PROMPT ('Variable to set:', FIELD),%CookieTarget
#END
%CookieTarget = Broker.Http.GetCookie('%'CookieName')
#!
#!
#CODE (SetCookie, 'Read the value of a cookie'), DESCRIPTION('SetCookie(''' & %CookieName & ''',' & %CookieSource & ')'),HLP('~ICCodeSetCookie')
#BOXED ('Set Cookie')
  #DISPLAY ('This code template stores a cookie onto the client computer that can be retrieved at a later date.  Note, the cookie is not sent until a new page has been requested by the user.'),AT(,,180)
  #PROMPT ('Cookie name:', @s255),%CookieName
  #PROMPT ('New value:', EXPR),%CookieSource
#END
Broker.Http.SetCookie('%'CookieName', %CookieSource)
#!
#!
#CODE (GetServerProperty, 'Read the value of a HTTP header field'), DESCRIPTION('GetServerProperty(''' & %ServerPropName & ''')'),HLP('~ICCodeGetServerProperty')
#BOXED ('Get Server Property')
  #DISPLAY ('This code template retrieves a HTTP field from the header passed to the browser with each page.'),AT(,,180)
  #PROMPT ('Property name:', @s255),%ServerPropertyName
  #PROMPT ('Variable to set:', FIELD),%ServerPropertyTarget
#END
%ServerPropertyTarget = Broker.Http.GetServerProperty('%'ServerPropertyName')
#!
#!
#CODE (AddServerProperty, 'Add or change a HTTP header field'), DESCRIPTION('AddServerProperty(''' & %ServerPropName & ''',' & %ServerPropSource & ')'),HLP('~ICCodeAddServerProperty')
#BOXED ('Add Server Property')
  #DISPLAY ('This code template adds or changes a HTTP field in the header passed to the browser with each page.'),AT(,,180)
  #PROMPT ('Property name:', @s255),%ServerPropertyName
  #PROMPT ('Property value:', EXPR),%ServerPropertySource
#END
Broker.Http.SetServerProperty('%'ServerPropertyName', %ServerPropertySource)
#!
#!
#CODE (DynamicHTML, 'Insert Dynamic HTML'),DESCRIPTION('Dynamic HTML: ' & %DynamicText),HLP('~ICCodeDynamicHTML')
#RESTRICT
  #CALL(%ValidateHtmlEmbedPoint)
#END
#DISPLAY ('This template allows you to add dynamic HTML statements into the HTML file.'),AT(,,180)
#PROMPT ('Dynamic Text:', EXPR), %DynamicText
Target.Writeln(%DynamicText)
#!
#!
#CODE (StaticHTML, 'Insert static HTML'),DESCRIPTION('Static HTML: ' & %FirstLine(%StaticHTMLText)),HLP('~ICCodeStaticHTML')
#RESTRICT
  #CALL(%ValidateHtmlEmbedPoint)
#END
#BOXED ('HTML to insert')
  #PROMPT ('', TEXT), %StaticHTMLText,AT(,,,200)
#END
#INSERT (%GenerateLiteralHtml, %StaticHTMLText)
#!
#!--------------------------- Group Definitions ------------------------------
#!
#GROUP (%LocalClassDefs)
#FOR (%Control),WHERE(%Control)
  #IF (%ControlIsDerived)
%[20](%GetControlInstanceName()) CLASS(%(%GetClassName(%ControlType, %Control)))
CreateHtml             PROCEDURE(*HtmlClass Target),VIRTUAL
                       END
  #ELSIF (%NeedControl())
%[20](%GetControlInstanceName()) %(%GetClassName(%ControlType, %Control))
  #END
#END
#FOR (%AppPseudoControl),WHERE(%NeedPseudoControl())
%[20]('Web' & %AppPseudoControl) CLASS(%(%GetClassName(%AppPseudoControl)))%|
  #IF (%PseudoControlIsDerived)

CreateHtml             PROCEDURE(*HtmlClass Target),VIRTUAL
                       END
  #ELSE
.
  #END
#END
#GROUP (%Quote, %Text)
#IF (SUB(%Text, 1, 1) = '!')
  #RETURN (SUB(%Text, 2))
#END
#RETURN '''' & QUOTE(%Text) & ''''
#!
#!
#GROUP (%HasGoodStdAttr), AUTO
#EQUATE (%StdAttr, UPPER(EXTRACT(%ControlUnsplitStatement, 'STD', 1)))
#IF ((%StdAttr='') OR (%StdAttr='STD:CLOSE'))
  #RETURN %True
#END
#RETURN %False
#!
#!
#GROUP (%IsFrame)
#IF (EXTRACT(%WindowStatement, 'APPLICATION'))
  #RETURN (%True)
#END
#RETURN (%False)
#!
#!
#GROUP (%GetFrameManagerName)
#RETURN (%Procedure & 'Frame')
#!
#!
#GROUP (%NeedMenubar)
#IF ((%WinMenuBackColor<>099CCCCH) OR (%WinMenuBackImage))
  #RETURN %True
#END
#RETURN %False
#!
#GROUP (%NeedToolbar)
#RETURN (%WinToolbarBackColor<>-1 OR %WinToolbarBackImage)
#!
#GROUP (%NeedClient)
#RETURN (%WinClientAreaBackColor<>-1 OR %WinClientAreaBackImage)
#!
#!
#GROUP (%NeedCaption)
#RETURN (%WinDisplayCaption AND (%NeedCaptionBack() OR %NeedCaptionAlign() OR %NeedCaptionFont()))
#!
#!
#GROUP (%NeedCaptionBack)
#RETURN ((%WinCaptionBackColor <> 800000H) OR %WinCaptionBackImage)
#GROUP (%NeedCaptionAlign)
#RETURN (%WinCaptionAlign <> 'PROP:center')
#GROUP (%NeedCaptionFont)
#RETURN (%WinCaptionFontFace OR (%WinCaptionFontSize <> 0) OR (%WinCaptionFontColor <> 0FFFFFFH))
#!
#!
#GROUP (%NeedControl)
#IF (%CtlSetClass OR %CtlStringDynamic OR %CtlStringAutoSpot OR %CtlSetJavaDropList OR %ControlIsDerived OR %CtlDynamicUpdateImage)
  #RETURN (%True)
#END
#CASE (%ControlType)
#OF ('BUTTON')
  #FOR (%ControlEvent)
    #IF (%CtlSetEventAction)
      #RETURN %True
    #END
  #END
#END
#RETURN %False
#!
#!
#GROUP (%NeedPseudoControl)
#IF (%PseudoControlIsDerived)
  #RETURN (%True)
#END
#CASE (%AppPseudoControl)
#OF ('Menubar') #RETURN %NeedMenubar()
#OF ('Toolbar') #RETURN %NeedToolbar()
#OF ('ClientArea') #RETURN %NeedClient()
#OF ('Caption') #RETURN %NeedCaption()
#END
#!
#!
#GROUP (%GetUsesToolbar)
#IF (VAREXISTS(%GenerateBRWInstance))
  #IF (%GenerateBRWInstance OR %GenerateSelectInstance OR %GenerateUpdateInstance OR %GenerateReltreeInstance)
    #RETURN (%True)
  #END
  #IF (INLIST('FormVCRControls(Clarion)', %ActiveTemplate))
    #RETURN (1)
  #END
#END
#RETURN (%False)
#!
#!
#GROUP (%GetClassName, %WhichType, %WhichControl='')
#IF (%WhichControl)
  #FIX (%Control, %WhichControl)
  #IF (%CtlSetClass)
    #RETURN %CtlClassName
  #END
  #IF (%CtlStringDynamic OR %CtlStringAutoSpot)
    #RETURN 'WebJavaStringClass'
  #END
  #IF (%CtlSetJavaDropList)
    #RETURN 'WebJavaListClass'
  #END
  #IF (%CtlDynamicUpdateImage)
    #RETURN 'WebJavaImageClass'
  #END
  #CASE (%ControlType)
  #OF ('STRING')
    #IF (SUB(%ControlParameter,1,1)='@')
      #RETURN 'WebJavaStringClass'
    #END
  #OF ('BUTTON')
    #IF (%CtlSetEventAction)
      #RETURN 'WebJavaButtonClass'
    #END
  #END
#END
#FIX (%AppControlType, %WhichType)
#IF (%AppControlType)
  #IF (%AppSetControlTypeClass)
    #RETURN %AppControlTypeClassName
  #END
  #RETURN %AppControlTypeClassDefault
#END
#SET (%WhichType, UPPER(%WhichType))
#FOR (%AppControlType), WHERE(UPPER(%AppControlType) = %WhichType)
  #IF (%AppSetControlTypeClass)
    #RETURN %AppControlTypeClassName
  #END
  #RETURN %AppControlTypeClassDefault
#END
#!
#!
#GROUP (%GetControlInstanceName)
#RETURN 'Web:' & SUB(%ControlFeq(), 2)
#!
#!
#GROUP (%GetIsStandardToolbarButton)
#IF (%CWTemplateVersion < 'v3')
#RETURN (SUB(UPPER(%Control), 1, 8)='?TBARBRW')
#ELSE
#RETURN (SUB(UPPER(%Control), 1, 8)='?TOOLBAR')
#END
#!
#!
#GROUP (%ControlFeq)
#IF (%Control)
  #RETURN (%Control)
#END
#RETURN ('?Anon:' & INSTANCE(%Control))
#!
#!
#GROUP (%ControlFieldFeq)
#IF (%Control)
  #RETURN ('IC' & SUB(%Control,2))
#END
#RETURN ('ICAnon:' & INSTANCE(%Control))
#!
#!
#GROUP (%OutputClassInclude)
#FOR (%AppControlType), WHERE(%AppSetControlTypeClass)
  #IF (%AppControlTypeClassHeader)
INCLUDE('%'AppControlTypeClassHeader')
  #END
#END
#!
#! Calculate which controls from the frame should appear on the child windows
#! and whether the code for them should be copied across into the hook
#! procedure.
#!
#GROUP (%CalculateFrameControls),AUTO
#PURGE (%FrameControlInstance)
#PURGE (%FrameControlCopyCode)
#!
#EQUATE (%DoMenuCopy, %MenuCopy)
#EQUATE (%DoMenuCopyCode, NOT %MenuIgnoreCode)
#IF (%DoMenuCopy = 'Default')
  #SET (%DoMenuCopy, %AppMenuCopy)
  #SET (%DoMenuCopyCode, NOT %AppMenuIgnoreCode)
#END
#IF (%DoMenuCopy <> 'None')
  #FOR (%Control), WHERE(%ControlMenu)
    #IF (%HasGoodStdAttr() AND NOT EXTRACT(%ControlUnsplitStatement, 'SEPARATOR'))
      #IF (%DoMenuCopy = 'Some')
        #FIX (%FrameMenu, %Control)
        #IF (%MenuControlIgnore)
          #CYCLE
        #END
        #ADD (%FrameControlInstance, INSTANCE(%Control))
        #SET (%FrameControlCopyCode, NOT %MenuControlIgnoreCode)
      #ELSE
        #ADD (%FrameControlInstance, INSTANCE(%Control))
        #SET (%FrameControlCopyCode, %DoMenuCopyCode)
      #END
    #END
  #END
#END
#!
#!
#EQUATE (%DoToolCopy, %ToolCopy)
#EQUATE (%DoToolCopyCode, NOT %ToolIgnoreCode)
#IF (%DoToolCopy = 'Default')
  #SET (%DoToolCopy, %AppToolCopy)
  #SET (%DoToolCopyCode, NOT %AppToolIgnoreCode)
#END
#IF (%DoToolCopy <> 'None')
  #FOR (%Control), WHERE(%ControlTool AND (%ControlType='BUTTON'))
    #IF (%HasGoodStdAttr())
      #CASE (UPPER(%Control))
      #OF ('?TBARBRWHISTORY')
      #OF ('?TOOLBAR:HISTORY')
      #ELSE
        #IF (%DoToolCopy = 'Standard')
          #IF (%GetIsStandardToolbarButton())
            #ADD (%FrameControlInstance, INSTANCE(%Control))
          #END
        #ELSIF (%DoToolCopy = 'Some')
          #FIX (%FrameTool, %Control)
          #IF (%ToolControlIgnore)
            #CYCLE
          #END
          #ADD (%FrameControlInstance, INSTANCE(%Control))
          #SET (%FrameControlCopyCode, NOT %ToolControlIgnoreCode)
        #ELSE
          #ADD (%FrameControlInstance, INSTANCE(%Control))
          #SET (%FrameControlCopyCode, %DoToolCopyCode)
        #END
      #END
    #END
  #END
#END
#!
#!
#GROUP (%GenerateLocalProcedures)
  #IF (%IsFrame)
%FrameManagerName.CopyControlsToWindow PROCEDURE(*WebWindowClass OwnerWindow, BYTE MergeMenu, BYTE MergeTool)
  CODE
    #SUSPEND
  #?IF MergeMenu
    #FOR (%FrameControlInstance)
      #SELECT(%Control, %FrameControlInstance)
      #IF (%ControlMenu)
    SELF.CopyControlToWindow(OwnerWindow, %(%ControlFeq()))
      #END
    #END
  #?END
    #RESUME
    #SUSPEND
  #?IF MergeTool
    #FOR (%FrameControlInstance)
      #SELECT(%Control, %FrameControlInstance)
      #IF (%ControlTool)
    SELF.CopyControlToWindow(OwnerWindow, %(%ControlFeq()))
      #END
    #END
  #?END
    #RESUME


%FrameManagerName.TakeEvent     PROCEDURE

FirstIteration       SIGNED(1)

  CODE
  LOOP
    #SUSPEND
    #?IF (NOT FirstIteration)
      #?RETURN REPLY:CYCLE
    #?END
    #?FirstIteration = FALSE
    #?CASE FIELD()
    #FOR (%FrameControlInstance)
      #SELECT(%Control, %FrameControlInstance)
      #IF (%Control AND %FrameControlCopyCode)
    #INSERT (%SingleControlHandling)
      #END
    #END
    #?END
    #RESUME
    RETURN REPLY:NONE
  END
  RETURN REPLY:BREAK
  #END
  #IF (%GetUsesToolbar())
WebWindow.GetToolbarMode         PROCEDURE
  CODE
  RETURN ToolbarMode
  #END

  #CALL (%WebWindowVirtualTitleContents), %DeriveWindowTitleContents
  #CALL (%WebWindowVirtualBodyHeader), %DeriveWindowBodyHeader
  #CALL (%WebWindowVirtualBodyFooter), %DeriveWindowBodyFooter
  #CALL (%WebWindowVirtualCreateHtmlPage), %DeriveWindowCreateHtmlPage
  #CALL (%WebWindowVirtualValidatePassword), %DeriveWindowValidatePassword
  #CALL (%WebWindowVirtualTakeUnknownSubmit), %DeriveWindowTakeUnknownSubmit
  #FOR (%Control), WHERE(%Control)
    #CALL (%WebControlVirtualCreateHtml), %ControlIsDerived
  #END
  #FOR (%AppPseudoControl)
    #CALL (%WebPseudoControlVirtualCreateHtml), %PseudoControlIsDerived
  #END
#!
#!--------------------------- General processing groups -----------------------
#!
#GROUP (%SingleControlHandling)
  #SUSPEND
#?OF %(%ControlFeq())
  #EMBED(%ControlPreEventCaseHandling,'Control Handling, before event handling'),%Control
  #?CASE EVENT()
    #FOR(%ControlEvent)
      #SUSPEND
  #?OF EVENT:%ControlEvent
    #EMBED(%ControlPreEventHandling,'Control Event Handling, before generated code'),%Control,%ControlEvent
    #INSERT(%FieldTemplateStandardHandling(Clarion))
    #EMBED(%ControlEventHandling,'Internal Control Event Handling'),%Control,%ControlEvent,HIDE
    #EMBED(%ControlPostEventHandling,'Control Event Handling, after generated code'),%Control,%ControlEvent
      #IF (UPPER(EXTRACT(%ControlUnsplitStatement, 'STD', 1))= 'STD:CLOSE')
    WebServer.Quit
      #END
      #RESUME
    #ENDFOR
    #SUSPEND
  #?ELSE
    #EMBED(%ControlOtherEventHandling,'Other Control Event Handling'),%Control
    #RESUME
  #?END
  #EMBED(%ControlPostEventCaseHandling,'Control Handling, after event handling'),%Control
  #RESUME
#!
#!
#GROUP (%SplitTextIntoLines, %Text, *%Target)
#EQUATE (%Index, 1)
#DECLARE (%Next)
#LOOP
  #SET (%Next, INSTRING('<13><10>', %Text, 1, %Index))
  #IF (%Next = 0)
    #BREAK
  #END
  #ADD(%Target, SUB(%Text, %Index, %Next-%Index))
  #SET (%Index, %Next + 2)
#END
#IF (%Index < LEN(%Text))
  #ADD(%Target, SUB(%Text, %Index))
#END
#!
#!
#GROUP (%GenerateLiteralHtml, %Text)
#DECLARE (%Lines), MULTI
#CALL (%SplitTextIntoLines, %Text, %Lines)
#FOR (%Lines)
Target.Writeln('%'Lines')
#END
#!
#!!!!!!!!! Window virtuals !!!!!!!!!!
#!
#GROUP (%WebWindowVirtualTitleContents,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'TitleContents', 'PROCEDURE(*HtmlClass Target)')
  #?CODE
  #EMBED (%WebTitleContentsVirtual, 'Internet, inside the Title for the page'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebWindowVirtualBodyHeader,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'BodyHeader', 'PROCEDURE(*HtmlClass Target)')
  #?CODE
  #EMBED (%WebBodyHeaderVirtual, 'Internet, after the opening <<BODY> tag'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebWindowVirtualBodyFooter,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'BodyFooter', 'PROCEDURE(*HtmlClass Target)')
  #?CODE
  #EMBED (%WebBodyFooterVirtual, 'Internet, before the closing <</BODY> tag'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebWindowVirtualCreateHtmlPage,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'CreateHtmlPage', 'PROCEDURE(*HtmlClass Target, STRING HtmlFilename)')
  #?CODE
  #EMBED (%WebCodeSectionBeforeCreateHtmlPage, 'Internet, before generating HTML page'),WHERE(%ProcedureHasWebWindow())
  #?PARENT.CreateHtmlPage(Target, HtmlFilename)
  #EMBED (%WebCodeSectionAfterCreateHtmlPage, 'Internet, after generating HTML page'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebWindowVirtualValidatePassword,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'ValidatePassword', 'PROCEDURE(STRING UserName, STRING Password)')
#EMBED (%WebDataSectionValidatePasswordVirtual, 'Internet, password validation - data section'),LABEL,WHERE(%ProcedureHasWebWindow())
  #?CODE
  #EMBED (%WebCodeSectionValidatePasswordVirtual, 'Internet, password validation - code section'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebWindowVirtualTakeUnknownSubmit,%WebWindowName='WebWindow'),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %WebWindowName, 'TakeUnknownSubmit', 'PROCEDURE(STRING ControlName, STRING ControlValue)')
  #?CODE
  #EMBED (%WebCodeSectionTakeUnknownSubmitVirtual, 'Internet, process user html control values - code section'),WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!

%WebWindowNameClass.ValidatePassword   PROCEDURE(STRING UserName, STRING Password)
  CODE
  IF (NOT SELF.PasswordCaseSensitive)
    Password = UPPER(Password)
    SELF.Password = UPPER(SELF.Password)
  END

  IF (Password = SELF.Password)
    RETURN TRUE
  END
  RETURN FALSE


#!
#!!!!!!!!!! Control virtuals !!!!!!!!!!
#!
#GROUP (%WebControlVirtualCreateHtml),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, %GetControlInstanceName(), 'CreateHtml', 'PROCEDURE(*HtmlClass Target)')
  #?CODE
#IF (%CtlHtmlHeader)
  #INSERT (%GenerateLiteralHtml, %CtlHtmlHeader)
#END
  #EMBED (%WebBeforeControl, 'Internet, before generating HTML for control'), %Control,WHERE(%ProcedureHasWebWindow())
  #IF (NOT %CtlSupressHtml)
  #?PARENT.CreateHtml(Target)
  #END
  #EMBED (%WebAfterControl, 'Internet, after generating HTML for control'), %Control,WHERE(%ProcedureHasWebWindow())
#IF (%CtlHtmlFooter)
  #INSERT (%GenerateLiteralHtml, %CtlHtmlFooter)
#END
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%WebPseudoControlVirtualCreateHtml),AUTO
#EQUATE (%InitialOffset, %BytesOutput)
#CALL (%GenerateVirtualHeader, 'Web' & %AppPseudoControl, 'CreateHtml', 'PROCEDURE(*HtmlClass Target)')
  #?CODE
  #EMBED (%WebBeforePseudoControl, 'Internet, before generating HTML for component'), %AppPseudoControl,WHERE(%ProcedureHasWebWindow())
  #?PARENT.CreateHtml(Target)
  #EMBED (%WebAfterPseudoControl, 'Internet, after generating HTML for component'), %AppPseudoControl,WHERE(%ProcedureHasWebWindow())
#CALL (%GenerateVirtualFooter)
#RETURN (%BytesOutput <> %InitialOffset)
#!
#!
#GROUP (%GenerateVirtualHeader, %ClassName, %Method, %ThisProto)
#SUSPEND
#?%ClassName.%Method              %ThisProto
#!
#!
#GROUP (%GenerateVirtualFooter)
#?
#RESUME
#!
#!
#GROUP (%DeclareVirtual, %IsDerived, %MethodName, %MethodProto)
#IF (%IsDerived)
%[22]MethodName %MethodProto,VIRTUAL
#END
#!
#!
#GROUP (%GetBoolText, %Expr)
#IF (%Expr)
  #RETURN 'TRUE'
#END
#RETURN 'FALSE'
#!
#!--------------------------- General processing groups -----------------------
#!
#GROUP(%WriteBaseMethods),AUTO
#MESSAGE('Generating Module:    ' & %ICFileName, 1)
  #CREATE(%BuildFile)
  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICWINDOW.INC')
  INCLUDE('ICCNTRLS.INC')
  INCLUDE('ICSTD.EQU')
  #INSERT (%OutputClassInclude)

  MAP
    WebControlFactory(SIGNED Feq),*WebControlClass
  END

WebControlFactory PROCEDURE(SIGNED Type)

NewControl      &WebControlClass           ! Initialised to NULL

  CODE

  CASE (Type)
  OF 0
  OROF 23
#FOR (%AppControlType)
  OF CREATE:%AppControlType
  #IF (%AppSetControlTypeClass)
    NewControl &= NEW %AppControlTypeClassName
  #ELSE
    NewControl &= NEW %AppControlTypeClassDefault
  #END
#END
  END
  IF (~NewControl &= NULL)
    NewControl.IsDynamic = TRUE
  END
  RETURN NewControl

  #CLOSE(%BuildFile)
  #REPLACE(%ICFileName,%BuildFile)



#!
#!--------------------------- Prompt Groups ------------------------------
#!
#GROUP (%IndividualControlPrompts)
#SHEET
  #TAB ('&Display'),HLP('~ICProcedureExt_ControlDisplay'),WHERE(%InitClassQueue())
    #BOXED ('General')
      #PROMPT ('', CHECK), %CtlSetOnDisabled,DEFAULT(0),AT(10,,10),WHENACCEPTED(%CascadeControlOption())
      #ENABLE (%CtlSetOnDisabled)
        #PROMPT ('If control disabled:', DROP('Hide control[Hide]|Hide if cannot disable[OptHide]|Show control[Show]')), %CtlOnDisabled,DEFAULT('Hide'),PROMPTAT(20,,77),AT(97,,87)
      #END
      #PROMPT ('Hide if launched from browser', CHECK), %CtlDisableFromBrowser,AT(10)
    #END
    #BOXED('Image'), WHERE(%ControlType = 'IMAGE'), HIDE
      #PROMPT ('Update image dynamically', CHECK), %CtlDynamicUpdateImage,AT(10)
      #ENABLE (NOT %CtlDynamicUpdateImage)
        #PROMPT ('Alternative text:', @s255), %CtlAltText
      #END
    #END
    #BOXED('Strings'), WHERE(%ControlType = 'STRING'),HIDE
      #PROMPT ('Allow dynamic update', CHECK), %CtlStringDynamic,AT(10,,180)
      #PROMPT ('Autospot hyperlinks', CHECK), %CtlStringAutoSpot,AT(10,,180)
    #END
    #BOXED('Listboxes'), WHERE(%ControlType = 'LIST'),HIDE
      #PROMPT ('Autospot hyperlinks', CHECK), %CtlListAutoSpot,AT(10)
      #ENABLE (EXTRACT(%ControlStatement, 'DROP')), HIDE
        #PROMPT ('', CHECK), %CtlSetJavaDropList,DEFAULT(0),AT(10,,10)
        #ENABLE (%CtlSetJavaDropList)
          #PROMPT ('Replace with Java non-drop list', CHECK), %CtlJavaDropList,AT(20)
        #END
      #END
    #END
    #BOXED('Sheet'), WHERE(%ControlType = 'SHEET'), HIDE
      #PROMPT ('', CHECK), %CtlSetBorderWidth,DEFAULT(0),AT(10,,10)
      #ENABLE (%CtlSetBorderWidth)
        #PROMPT ('Border width:', SPIN(@n2,0,99)),%CtlBorderWidth,PROMPTAT(20,,77),AT(97,,87)
      #END
    #END
  #END
  #TAB ('Html'),HLP('~ICProcedureExt_ControlHtml')
    #BOXED ('HTML before control')
      #PROMPT ('', TEXT), %CtlHtmlHeader,AT(,,,100)
    #END
    #BOXED ('HTML after control')
      #PROMPT ('', TEXT), %CtlHtmlFooter,AT(,,,100)
    #END
    #PROMPT ('Remove default HTML generation', CHECK),%CtlSupressHtml,AT(10)
  #END
  #TAB ('Events'), WHERE(ITEMS(%ControlEvent)),HLP('~ICProcedureExt_ControlEvents')
    #BUTTON ('Events'), FROM(%ControlEvent, %ICEventDisplayText()),INLINE,HLP('~ICProcedureExt_ControlEventOverride')
      #PROMPT ('Override default action', CHECK), %CtlSetEventAction,AT(10),WHENACCEPTED(%CascadeControlOption())
      #ENABLE (%CtlSetEventAction)
        #PROMPT ('Action on event:', DROP('Process On Browser[OnBrowser]|Partial page refresh[Partial]|Complete page refresh[Full]')), %CtlEventAction
      #END
    #END
  #END
  #TAB('C&lasses'),HLP('~ICProcedureExt_ControlClasses')
    #BOXED ('Classes')
      #PROMPT ('Override default class', CHECK), %CtlSetClass,AT(10)
      #ENABLE (%CtlSetClass)
        #PROMPT ('Class Name:', COMBO(%AppClassQueue)), %CtlClassName
        #PROMPT ('Header file:', OPENDIALOG('Select Header File', 'INC files (*.inc)|*.inc|All Files (*.*)|*.*')), %CtlClassHeader
        #PROMPT ('Implementation file:', OPENDIALOG('Select Implementation File', 'INC files (*.clw)|*.clw|All Files (*.*)|*.*')), %CtlClassCode
      #END
    #END
  #END
#END
#!
#!--------------------------- Prompt Initialisation --------------------------
#!
#GROUP (%InitControlTypes)
#CALL (%InitControl, 'Prompt', 'WebHtmlPromptClass')
#CALL (%InitControl, 'String', 'WebHtmlStringClass')
#CALL (%InitControl, 'SString', 'WebJavaStringClass')
#CALL (%InitControl, 'Entry',  'WebHtmlEntryClass')
#CALL (%InitControl, 'Combo',  'WebHtmlEntryClass')
#CALL (%InitControl, 'Spin',   'WebHtmlEntryClass')
#CALL (%InitControl, 'Text',   'WebHtmlTextClass')
#CALL (%InitControl, 'Check',  'WebHtmlCheckClass')
#CALL (%InitControl, 'Option', 'WebHtmlOptionClass')
#CALL (%InitControl, 'Radio',  'WebHtmlRadioClass')
#CALL (%InitControl, 'List',   'WebJavaListClass')
#CALL (%InitControl, 'DropList','WebHtmlListClass')
#CALL (%InitControl, 'Sheet',  'WebHtmlSheetClass')
#CALL (%InitControl, 'Tab',    'WebHtmlTabClass')
#CALL (%InitControl, 'Button', 'WebJavaButtonClass')
#CALL (%InitControl, 'Menu',   'WebHtmlMenuClass')
#CALL (%InitControl, 'Item',   'WebHtmlItemClass')
#CALL (%InitControl, 'Image',  'WebHtmlImageClass')
#CALL (%InitControl, 'Group',  'WebHtmlGroupClass')
#CALL (%InitControl, 'Region', 'WebHtmlRegionClass')
#CALL (%InitControl, 'TextButton', 'WebHtmlButtonClass')
#CALL (%InitControl, 'ToolButton', 'WebJavaToolButtonClass')
#!
#CALL (%InitControl, 'Caption', 'WebCaptionClass')
#CALL (%InitControl, 'Toolbar', 'WebToolbarClass')
#CALL (%InitControl, 'Menubar', 'WebMenubarClass')
#CALL (%InitControl, 'ClientArea',  'WebClientAreaClass')
#CALL (%InitControl, 'Close',  'WebCloseButtonClass')
#!
#GROUP (%InitClassQueue)
#FREE (%AppClassQueue)
#CASE (%ControlType)
#OF ('PROMPT')
  #ADD (%AppClassQueue, 'WebHtmlPromptClass')
#OF ('STRING')
  #ADD (%AppClassQueue, 'WebHtmlStringClass')
  #ADD (%AppClassQueue, 'WebJavaStringClass')
#OF ('ENTRY')
#OROF ('COMBO')
#OROF ('SPIN')
#OROF ('TEXT')
  #ADD (%AppClassQueue, 'WebHtmlEntryClass')
  #ADD (%AppClassQueue, 'WebHtmlTextClass')
  #ADD (%AppClassQueue, 'WebJavaStringClass')
#OF ('CHECK')
  #ADD (%AppClassQueue, 'WebHtmlCheckClass')
#OF ('OPTION')
  #ADD (%AppClassQueue, 'WebHtmlOptionClass')
#OF ('RADIO')
  #ADD (%AppClassQueue, 'WebHtmlRadioClass')
#OF ('LIST')
#OROF ('DROPLIST')
  #ADD (%AppClassQueue, 'WebJavaListClass')
  #ADD (%AppClassQueue, 'WebHtmlListClass')
#OF ('SHEET')
  #ADD (%AppClassQueue, 'WebHtmlSheetClass')
#OF ('TAB')
  #ADD (%AppClassQueue, 'WebHtmlTabClass')
#OF ('BUTTON')
#OROF ('TEXTBUTTON')
  #ADD (%AppClassQueue, 'WebJavaButtonClass')
  #ADD (%AppClassQueue, 'WebHtmlButtonClass')
#OF ('MENU')
  #ADD (%AppClassQueue, 'WebHtmlMenuClass')
#OF ('ITEM')
  #ADD (%AppClassQueue, 'WebHtmlItemClass')
#OF ('IMAGE')
  #ADD (%AppClassQueue, 'WebHtmlImageClass')
  #ADD (%AppClassQueue, 'WebJavaImageClass')
#OF ('GROUP')
  #ADD (%AppClassQueue, 'WebHtmlGroupClass')
#OF ('REGION')
  #ADD (%AppClassQueue, 'WebHtmlRegionClass')
#END
#RETURN (%True)
#!
#!
#GROUP (%InitControl, %Type, %Class)
#ADD (%AppControlType, %Type)
#SET (%AppControlTypeClassDefault, %Class)
#IF (NOT %AppSetControlTypeClass)
 #SET (%AppControlTypeClassName, %AppControlTypeClassDefault)
#END
#!
#!
#GROUP (%InitPseudoControl)
#FREE (%AppPseudoControl)
#ADD (%AppPseudoControl, 'Caption')
#ADD (%AppPseudoControl, 'Toolbar')
#ADD (%AppPseudoControl, 'Menubar')
#ADD (%AppPseudoControl, 'ClientArea')
#!
#!
#GROUP (%InitFrameControls),AUTO,PRESERVE
#IF (EXTRACT(%WindowStatement, 'APPLICATION'))
  #!
  #! Need to be careful when building the list of frame controls that we don't
  #! delete existing entries - otherwise dependant prompts will be freed
  #!
  #FOR (%Control), WHERE((%ControlType = 'ITEM') AND NOT EXTRACT(%ControlUnsplitStatement, 'SEPARATOR'))
    #IF (%HasGoodStdAttr())
      #ADD (%FrameMenu, %Control)
    #END
  #END
  #FOR (%Control), WHERE(%ControlType = 'BUTTON')
    #IF (%HasGoodStdAttr())
      #ADD (%FrameTool, %Control)
    #END
  #END
  #FOR (%FrameMenu), WHERE(NOT INLIST(%FrameMenu, %Control))
    #DELETE (%FrameMenu)
  #END
  #FOR (%FrameTool), WHERE(NOT INLIST(%FrameTool, %Control))
    #DELETE (%FrameTool)
  #END
#ELSE
  #FREE (%FrameMenu)
  #FREE (%FrameTool)
#END
#!
#!
#GROUP (%CascadeGlobalOption)
#CALL (%CascadeWindowOption)
#FOR (%Control),WHERE(%Control)
  #CALL (%CascadeControlOption)
#END
#!
#!
#GROUP (%CascadeWindowOption)
#IF (NOT %WinOverridePage)
  #SET (%WinCenterWindow, %AppCenterWindow)
  #SET (%WinPageBackColor, %AppPageBackColor)
  #SET (%WinPageBackImage, %AppPageBackImage)
#END
#IF (NOT %WinOverrideWindow)
  #SET (%WinWindowBackColor, %AppWindowBackColor)
  #SET (%WinWindowBackImage, %AppWindowBackImage)
  #SET (%WinWindowBorderWidth, %AppWindowBorderWidth)
#END
#IF (NOT %WinOverrideHelp)
  #SET (%WinHelpRelative, %AppHelpRelative)
  #SET (%WinHelpDocument, %AppHelpDocument)
  #SET (%WinHelpURL, %AppHelpURL)
  #SET (%WinHelpStyle, %AppHelpStyle)
#END
#IF (NOT %WinOverrideCaption)
  #SET (%WinDisplayCaption, %AppDisplayCaption)
  #SET (%WinCaptionBackColor, %AppCaptionBackColor)
  #SET (%WinCaptionBackImage, %AppCaptionBackImage)
  #SET (%WinCaptionAlign, %AppCaptionAlign)
  #SET (%WinCaptionFontFace, %AppCaptionFontFace)
  #SET (%WinCaptionFontSize, %AppCaptionFontSize)
  #SET (%WinCaptionFontColor, %AppCaptionFontColor)
#END
#IF (NOT %WinOverrideMenu)
  #SET (%WinMenuBackColor, %AppMenuBackColor)
  #SET (%WinMenuBackImage, %AppMenuBackImage)
  #SET (%WinMenuAlign, %AppMenuAlign)
#END
#IF (NOT %WinOverrideToolbar)
  #SET (%WinToolbarBackColor, %AppToolbarBackColor)
  #SET (%WinToolbarBackImage, %AppToolbarBackImage)
#END
#IF (NOT %WinOverrideClose)
  #SET (%WinToolbarCloseImage, %AppToolbarCloseImage)
#END
#IF (NOT %WinOverrideClientArea)
  #SET (%WinClientAreaBackColor, %AppClientAreaBackColor)
  #SET (%WinClientAreaBackImage, %AppClientAreaBackImage)
#END
#IF (NOT %WinSetAppMenubar)
  #SET (%MenuCopy, %AppMenuCopy)
  #SET (%MenuIgnoreCode, %AppMenuIgnoreCode)
#END
#IF (NOT %WinSetAppToolbar)
  #SET (%ToolCopy, %AppToolCopy)
  #SET (%ToolIgnoreCode, %AppToolIgnoreCode)
#END
#IF (NOT %WinSetOnDisabled)
  #SET (%WinOnDisabled, %AppOnDisabled)
#END
#IF (NOT %WinSetJavaDropList)
  #SET (%WinJavaDropList, %AppJavaDropList)
#END
#IF (NOT %WinSetSheetBorderWidth)
  #SET (%WinSheetBorderWidth, %AppSheetBorderWidth)
#END
#IF (NOT %WinSetOptionBorderWidth)
  #SET (%WinOptionBorderWidth, %AppOptionBorderWidth)
#END
#IF (NOT %WinSetGroupBorderWidth)
  #SET (%WinGroupBorderWidth, %AppGroupBorderWidth)
#END
#IF (NOT %WinOverrideFormat)
  #SET (%WinPixelsPerCharX, %AppPixelsPerCharX)
  #SET (%WinPixelsPerCharY, %AppPixelsPerCharY)
  #SET (%WinGridSnapDeltaX, %AppGridSnapDeltaX)
  #SET (%WinGridSnapDeltaY, %AppGridSnapDeltaY)
#END
#!
#!
#GROUP (%CascadeControlOption)
#IF (NOT %CtlSetOnDisabled)
  #SET (%CtlOnDisabled, %WinOnDisabled)
#END
#IF (NOT %CtlSetJavaDropList)
  #SET (%CtlJavaDropList, %WinJavaDropList)
#END
#IF (NOT %CtlSetBorderWidth)
  #CASE (%ControlType)
  #OF ('SHEET')
     #SET (%CtlBorderWidth, %WinSheetBorderWidth)
  #OF ('OPTION')
     #SET (%CtlBorderWidth, %WinOptionBorderWidth)
  #OF ('GROUP')
     #SET (%CtlBorderWidth, %WinGroupBorderWidth)
  #END
#END
#!
#!--------------------------- Prompt Display ----------------------------------
#!
#GROUP (%ICClassDisplayText)
#IF (%AppSetControlTypeClass)
  #RETURN %AppControlType & ' - ' & %AppControlTypeClassName
#END
#RETURN %AppControlType & ' - Default (' & %AppControlTypeClassDefault & ')'
#!
#!
#GROUP (%ICEventDisplayText)
#IF (%CtlSetEventAction)
  #RETURN (%ControlEvent & ' - Update:' & %CtlEventAction)
#END
#RETURN (%ControlEvent)
#!
#!
#GROUP (%OnCaptionChange)
#CASE (%WinDisplayCaption3)
#OF ('Default')
 #SET (%WinDisplayCaption, %DisplayCaption)
#OF ('Yes')
 #SET (%WinDisplayCaption, %True)
#ELSE
 #SET (%WinDisplayCaption, %False)
#END
#RETURN (%False)
#!
#!
#GROUP (%FirstLine, %Text)
#DECLARE (%Next)
#SET (%Next, INSTRING('<13><10>', %Text, 1, 1))
#IF (%Next = 0)
  #RETURN %Text
#END
#RETURN (SUB(%Text, 1, %Next-1) & '...')
#!
#!
#INCLUDE ('ICGROUP.TPW')
#!
#GROUP (%ValidateHtmlEmbedPoint)
#WHERE (%WebBeforeControl, %WebAfterControl)
#WHERE (%WebTitleContentsVirtual, %WebBodyHeaderVirtual, %WebBodyFooterVirtual)
#WHERE (%WebBeforePseudoControl, %WebAfterPseudoControl)
#REJECT
#!
#GROUP(%HtmlPreviewHookData)
HtmlPreview          WebReportClass
#!
#!
#GROUP(%HtmlPreviewHookStart)
IF WebServer.Active
#IF (%CWTemplateVersion < 'v3')
    HtmlPreview.Init( WebServer, HtmlManager, PrintPreviewQueue )
#ELSE
  IF ~SELF.Preview &= NULL AND SELF.Response = RequestCompleted
    ENDPAGE(SELF.Report)
    HtmlPreview.Init( WebServer, HtmlManager, SELF.PreviewQueue )
#END
    HtmlPreview.Preview
    HtmlPreview.Kill
#IF (NOT (%CWTemplateVersion < 'v3'))
    FREE(SELF.PreviewQueue)
  END
#ELSE
  FREE(PrintPreviewQueue)
#END
ELSE
  #INDENT(2)
#!
#!
#GROUP(%HtmlPreviewHookEnd)
END
  #INDENT(-2)
#!
#GROUP(%ProcedureHasWebWindow)
  #IF (%WinProgressTimerSet() OR (%ProcedureTemplate <> 'Report') OR %WinProgressTimer)
    #RETURN %True
  #ELSE
    #RETURN %False
  #END
#!
#GROUP(%WinProgressTimerSet)
  #IF ((%ProcedureTemplate='Process') OR ((%ProcedureTemplate='Report') AND (INLIST('PauseButton(ABC)', %ActiveTemplate))))
    #SET(%WinProgressTimer, %True)
    #RETURN %True
  #ELSE
    #RETURN %False
  #END
#!
#GROUP(%WebWindowInit, %WebWindowName='WebWindow')
  #DECLARE (%InstanceName)
  #IF (%WinDisableFromBrowser)
IF (WebServer.Active)
  POST(EVENT:CloseWindow)
END
  #ENDIF
!- Initialise the internet classes
#IF (%WebWindowName='WebWindow')
%WebWindowName.Init(WebServer, HtmlManager, %Window{PROP:text} & ' (%'Procedure)')
#ELSE
%WebWindowName.Init(WebServer, HtmlManager, 0{PROP:text} & ' (%'Procedure)')
#ENDIF
%WebWindowName.SetFormatOptions(%WinGridSnapDeltaX, %WinGridSnapDeltaY, %WinPixelsPerCharX, %WinPixelsPerCharY)
%WebWindowName.MenubarType = %WinMenuAlign
  #IF (%WinOverrideClose)
%WebWindowName.CreateClose = CLOSE:%(CHOOSE(%WinCreateExtraClose, 'Always', 'Never'))
  #ELSE
%WebWindowName.CreateClose = CLOSE:%AppCreateExtraClose
  #END
  #IF (%WinToolbarCloseImage <> 'exit.ico')
%WebWindowName.CloseImage = '%'WinToolbarCloseImage'
  #END
  #IF ((%WinWindowBackColor <> -1) OR %WinWindowBackImage)
%WebWindowName.SetBackground(%WinWindowBackColor, '%'WinWindowBackImage')
  #END
  #IF (NOT %WinCenterWindow)
%WebWindowName.SetCentered(FALSE)
  #END
  #IF ((%WinPageBackColor <> -1) OR %WinPageBackImage)
%WebWindowName.SetPageBackground(%WinPageBackColor, '%'WinPageBackImage')
  #END
  #IF (%WinAuthorize)
%WebWindowName.SetPassword(%(%Quote(%WinAuthorizePassword)), %(%GetBoolText(%WinAuthorizeCaseSensitive)))
  #END
  #IF (%WinProgressTimer)
%WebWindowName.SetTimer(%WinProgressTimerDelay, Update:%WinProgressTimerAction)
  #ELSE
    #IF (%WinTimer)
%WebWindowName.SetTimer(%WinTimerDelay, Update:%WinTimerAction)
    #END
  #END
  #IF (%AppHelpEnabled)
    #IF (%WinHelpRelative)
%WebWindowName.SetHelpDocument('%'WinHelpDocument', '%'WinHelpStyle')
    #ELSE
%WebWindowName.SetHelpURL('%'WinHelpURL', '%'WinHelpStyle')
    #END
  #END
  #IF (%ProcedureTemplate='Splash')
%WebWindowName.SetSplash(%DisplayTime)
%WebWindowName.AllowJava = FALSE
%WebWindowName.CreateClose = CLOSE:Never
  #ENDIF
%WebWindowName.BorderWidth = %WinWindowBorderWidth
%WebWindowName.SheetBorderWidth = %WinSheetBorderWidth
%WebWindowName.OptionBorderWidth = %WinOptionBorderWidth
%WebWindowName.GroupBorderWidth = %WinGroupBorderWidth
#IF (%WinOnDisabled <> 'Hide')
%WebWindowName.DisabledAction = DISABLE:%WinOnDisabled
#END
#IF (%WinSecure)
%WebWindowName.IsSecure = TRUE
#END
%WebWindowName.CreateCaption = %WinDisplayCaption
#!
#! Components of a window - Caption, Toolbar, Menubar, ...
#!
  #FOR (%AppPseudoControl)
    #IF (%NeedPseudoControl())
      #CASE (%AppPseudoControl)
      #OF ('Menubar')
%WebWindowName.AddControl(%WebWindowName.GetMenubarFeq(), Web%AppPseudoControl)
      #OF ('Toolbar')
%WebWindowName.AddControl(%WebWindowName.GetToolbarFeq(), Web%AppPseudoControl)
      #ELSE
%WebWindowName.AddControl(FEQ:%AppPseudoControl, Web%AppPseudoControl)
      #END

      #CASE (%AppPseudoControl)
      #OF ('Menubar')
        #IF ((%WinMenuBackColor<>800000H) OR %WinMenuBackImage)
WebMenubar.SetBackground(%WinMenuBackColor, '%'WinMenuBackImage')
        #END
      #OF ('Toolbar')
        #IF ((%WinToolbarBackColor<>800000H) OR %WinToolbarBackImage)
WebToolbar.SetBackground(%WinToolbarBackColor, '%'WinToolbarBackImage')
        #END
      #OF ('ClientArea')
        #IF ((%WinClientAreaBackColor<>800000H) OR %WinClientAreaBackImage)
WebClientArea.SetBackground(%WinClientAreaBackColor, '%'WinClientAreaBackImage')
        #END
      #OF ('Caption')
        #IF (%NeedCaptionBack())
WebCaption.SetBackground(%WinCaptionBackColor, '%'WinCaptionBackImage')
        #END
        #IF (%NeedCaptionAlign())
WebCaption.Alignment = %WinCaptionAlign
        #END
        #IF (%NeedCaptionFont())
WebCaption.SetFont('%'WinCaptionFontFace', %WinCaptionFontSize, %WinCaptionFontColor)
        #END
      #END
    #END
  #END
  #IF (%WebWindowName='WebWindow')
    #!
    #! Initialize the control instances.  If they are statically defined then
    #! add them into the window structure.  If any properties need changing,
    #! for the controls to be created now.
    #!
    #FOR (%Control),WHERE(%Control)
      #IF (%CtlDisableFromBrowser)
%WebWindowName.SuppressControl(%Control)
      #ELSE
        #IF (%ControlInstance)
          #FIND (%ActiveTemplateInstance, %ControlInstance, %ActiveTemplate)
        #END
        #SUSPEND
#?
        #IF (%NeedControl())
          #SET (%InstanceName, %GetControlInstanceName())
%WebWindowName.AddControl(%Control, %InstanceName)
        #ELSE
#?IC:CurControl &= %WebWindowName.AddControl(%Control)
          #SET (%InstanceName, 'IC:CurControl')
        #END
#EMBED (%InitWebControlProperty),HIDE
        #IF (%ControlType = 'LIST')
          #IF (%ControlFrom AND SUB(%ControlFrom, 1, 1) <> '''')
%InstanceName.SetQueue(%ControlFrom)
          #END
        #END
        #FOR (%ControlEvent)
          #IF (%CtlSetEventAction)
%InstanceName.SetEventAction(EVENT:%ControlEvent, Update:%CtlEventAction)
          #ELSIF (%ActiveTemplate = 'RelationTree(Clarion)')
            #CASE (%ControlEvent)
            #OF ('Expanding') #OROF('Contracting')
%InstanceName.SetEventAction(EVENT:%ControlEvent, Update:Partial)
            #END
          #ELSIF (%ActiveTemplate = 'RelationTree(ABC)')
            #CASE (%ControlEvent)
            #OF ('Expanded') #OROF('Contracted')
%InstanceName.SetEventAction(EVENT:%ControlEvent, Update:Partial)
            #END
          #END
        #END
        #IF (%CtlSetBorderWidth)
%InstanceName.SetBorderWidth(%CtlBorderWidth)
        #END
        #IF (%CtlStringAutoSpot OR %CtlListAutoSpot)
%InstanceName.SetAutoSpotLink(TRUE)
        #END
#IF (%WinOnDisabled <> %CtlOnDisabled)
%InstanceName.DisabledAction = DISABLE:%CtlOnDisabled
#END
#IF (%CtlAltText)
%InstanceName.SetDescription('%'CtlAltText')
#END
        #RESUME
      #END
    #END
  #ENDIF
  #!
  #!
  #!
  #!
  #EMBED (%AfterInitialiseWebWindow, 'Internet, after initialising the Window object'),WHERE(%ProcedureHasWebWindow())
  #IF (%IsFrame)
SetWebActiveFrame(%(%Procedure & 'Frame'))
  #ELSIF (EXTRACT(%WindowStatement,'MDI') AND (%ProcedureTemplate<>'Splash'))
  #!
  #EQUATE (%MergeMenu, %GetBoolText(%WinMergeMenu AND NOT EXTRACT(%MenubarStatement, 'NOMERGE')))
  #EQUATE (%MergeTool, %GetBoolText(%WinMergeTool AND NOT EXTRACT(%ToolbarStatement, 'NOMERGE')))
IF (WebServer.Active)
  IC:CurFrame &= GetWebActiveFrame()
  IC:CurFrame.CopyControlsToWindow(%WebWindowName, %MergeMenu, %MergeTool)
END
  #END
#!
#GROUP(%WebWindowKill, %WebWindowName='WebWindow')
%WebWindowName.Kill
  #FOR (%AppPseudoControl)
    #IF (%NeedPseudoControl())
Web%AppPseudoControl.Kill
    #END
  #END
  #!
  #IF (%IsFrame)
SetWebActiveFrame()
  #END
IF (WebServer.Active)
  POST(EVENT:NewPage)
END
#!
#GROUP(%WebWindowTakeEvent, %WebWindowName='WebWindow')
IF %WebWindowName.TakeEvent()
  #IF (INLIST('SaveButton(Clarion)', %ActiveTemplate))
  DO CancelAutoIncrement
  #ENDIF
  BREAK
END
#!
#GROUP(%WebWindowDeclare, %WebWindowName='WebWindow')
%WebWindowName            CLASS(WebWindowClass)
#CALL (%DeclareVirtual, %GetUsesToolbar(), 'GetToolbarMode', 'PROCEDURE,SIGNED')
#CALL (%DeclareVirtual, %DeriveWindowTitleContents, 'TitleContents', 'PROCEDURE(*HtmlClass)')
#CALL (%DeclareVirtual, %DeriveWindowBodyHeader, 'BodyHeader', 'PROCEDURE(*HtmlClass)')
#CALL (%DeclareVirtual, %DeriveWindowBodyFooter, 'BodyFooter', 'PROCEDURE(*HtmlClass)')
#CALL (%DeclareVirtual, %DeriveWindowCreateHtmlPage, 'CreateHtmlPage', 'PROCEDURE(*HtmlClass, STRING)')
#CALL (%DeclareVirtual, %DeriveWindowValidatePassword, 'ValidatePassword', 'PROCEDURE(STRING UserName, STRING Password),BYTE')
#CALL (%DeclareVirtual, %DeriveWindowTakeUnknownSubmit, 'TakeUnknownSubmit', 'PROCEDURE(STRING, STRING)')
                     END
#!
#GROUP(%FindControlTemplate, %CTName),PRESERVE
  #FIX(%ActiveTemplate, %CTName)
  #IF (%ActiveTemplate = %CTName)
    #RETURN %True
  #ELSE
    #RETURN %False
  #ENDIF
#!
#GROUP(%CheckQBEList),PRESERVE
  #FIX(%ActiveTemplate, 'BrowseQBEButton(ABC)')
  #IF (%ActiveTemplate='BrowseQBEButton(ABC)')
    #FOR (%ActiveTemplateInstance)
      #CALL(%QBEIsList)
    #ENDFOR
  #ENDIF
#!
#GROUP(%QBEIsList),AUTO
  #ALIAS(%IsList,%Interface,%ActiveTemplateInstance)
  #IF (%IsList='LIST')
    #ERROR ('Internet templates cannot use the QBE List interface since it used EIP. Procedure: '&%Procedure)
  #ENDIF
#!
