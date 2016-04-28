#TEMPLATE (C55Cr8, 'Crystal 8 interface for Clarion'),FAMILY('ABC'),FAMILY('CW20')
#HELP('C55HELP.HLP')
#! -------------------------------------------------------------------------
#! (C55Cr8.TPL)
#! -------------------------------------------------------------------------
#!  VERSION 1.0
#! -------------------------------------------------------------------------
#! -------------------------------------------------------------------------
#EXTENSION (C55Cr8Global, 'Include Crystal 8 for Clarion Global Definitions'), DESCRIPTION('Crystal 8 Global Definitions'), APPLICATION, HLP('~TPLC8Global')
#! -------------------------------------------------------------------------
#DISPLAY
#DISPLAY
#DISPLAY('This Extension is nolonger used.')
#DISPLAY
#! -------------------------------------------------------------------------
#CODE (PreviewCrystalReport, 'Preview Crystal Report'),DESCRIPTION( 'Preview (and Optionally print) a Crystal 8 Report'),HLP('~TPLPreviewCrystal')
#! -------------------------------------------------------------------------
#SHEET
  #TAB('General')
    #PROMPT ('Object Name:', @s20 ),%CrystalObjectName, REQ, DEFAULT('oCrystal8')
    #DISPLAY('Report Name or' )
    #PROMPT (' variable (prefixed with !):', @s128 ),%CrystalReportName
    #DISPLAY('Window Title or' )
    #PROMPT (' variable (prefixed with !):', @s128 ),%CrystalWindowTitle
    #PROMPT ('Show Print Controls?', CHECK ), %CrystalShowPrintControls, DEFAULT( 1 ),AT(10)
  #ENDTAB
  #TAB('Control Options'),WHERE(%CrystalShowPrintControls)
    #PROMPT ('&Allow Prompting?', CHECK ), %CrystalAllowPrompt, DEFAULT( 1 ),AT(4)
    #PROMPT ('Allow &Drill Down?', CHECK ), %CrystalAllowDrill, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show &Cancel Button?', CHECK ), %CrystalShowCancel, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show C&lose Button?', CHECK ), %CrystalShowClose, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show &Export Button?', CHECK ), %CrystalShowExport, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show La&unch Button?', CHECK ), %CrystalShowLaunch, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show &Navigation Buttons?', CHECK ), %CrystalShowNav, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show &Print Button?', CHECK ), %CrystalShowPrint, DEFAULT( 1 ),AT(4)
    #PROMPT ('Show P&rint Setup?', CHECK ), %CrystalShowPrintSetup, DEFAULT( 1 ),AT(,18)
    #PROMPT ('Show Pr&ogress?', CHECK ), %CrystalShowProgress, DEFAULT( 1 )
    #PROMPT ('Show Re&fresh?', CHECK ), %CrystalShowRefresh, DEFAULT( 1 )
    #PROMPT ('Show &Search?', CHECK ), %CrystalShowSearch, DEFAULT( 1 )
    #PROMPT ('Show &Zoom?', CHECK ), %CrystalShowZoom, DEFAULT( 1 )
    #PROMPT ('Show &Toolbar Tips?', CHECK ), %CrystalShowTbTips, DEFAULT( 1 )
    #PROMPT ('&Show Document Tips?', CHECK ), %CrystalShowDocTips, DEFAULT( 1 )
  #ENDTAB
  #TAB('Window Options')
    #PROMPT('&Initial State: ', DROP('Normal|Maximized|Iconized') ),%Cr8InitState,DEFAULT('Normal')
    #PROMPT('&Frame Type: ', DROP('Single|Double|Resizeable|None') ),%Cr8FrameType,DEFAULT('Resizeable')
    #PROMPT('&Icon: ', OPENDIALOG('Select Icon','Icon Files|*.ico') ),%Cr8Icon
    #PROMPT('S&ystem Menu', CHECK ),%Cr8SystemMenu,DEFAULT( 0 ), AT( 10 )
    #PROMPT('Ma&ximize Box', CHECK ),%Cr8MaxBox,DEFAULT( 1 ), AT( 10 )
    #PROMPT('&3D Look', CHECK ),%Cr83D,DEFAULT( 1 ), AT( 10 )
  #ENDTAB
#ENDSHEET
#! --------------------------------------------------------------------------
#AT(%CustomGlobalDeclarations)
#! --------------------------------------------------------------------------
#IF( %ApplicationLocalLibrary )
  #ADD( %CustomGlobalDeclarationIncludes,'C55Cr8L.INC' )
#ELSE
  #ADD( %CustomGlobalDeclarationIncludes,'C55Cr8.INC')
#ENDIF
#IF(~%Target32)
  #ERROR('The Crystal Interface may only be used with 32 bit programs.')
#ELSE
  #IF( %ApplicationLocalLibrary )
    #PROJECT( 'C55Cr8L.LIB' )
  #ELSE
    #PROJECT( 'C55Cr8.LIB' )
  #ENDIF
#ENDIF
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
#! --------------------------------------------------------------------------
#AT(%DataSectionAfterWindow)
#! --------------------------------------------------------------------------
%CrystalObjectName         &Crystal8
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
%CrystalObjectName &= NEW Crystal8
#DECLARE( %TempRptName )
#IF( SUB(%CrystalReportName,1,1) = '!' )
  #SET( %TempRptName, SUB( %CrystalReportName, 2, LEN( %CrystalReportName ) ) )
IF %CrystalObjectName.Init( %TempRptName )
#ELSE
IF %CrystalObjectName.Init( '%CrystalReportName' )
#ENDIF
  %CrystalObjectName.ShowReportControls(%CrystalShowPrintControls)
  #IF( %CrystalShowPrintControls = 1 )
  %CrystalObjectName.AllowPrompt(%CrystalAllowPrompt)
  %CrystalObjectName.CanDrillDown(%CrystalAllowDrill)
  %CrystalObjectName.HasCancelButton(%CrystalShowCancel)
  %CrystalObjectName.HasCloseButton(%CrystalShowClose)
  %CrystalObjectName.HasExportButton(%CrystalShowExport)
  %CrystalObjectName.HasLaunchButton(%CrystalShowLaunch)
  %CrystalObjectName.HasNavigationControls(%CrystalShowNav)
  %CrystalObjectName.HasPrintButton(%CrystalShowPrint)
  %CrystalObjectName.HasPrintSetupButton(%CrystalShowPrintSetup)
  %CrystalObjectName.HasProgressControls(%CrystalShowProgress)
  %CrystalObjectName.HasRefreshButton(%CrystalShowRefresh)
  %CrystalObjectName.HasSearchButton(%CrystalShowSearch)
  %CrystalObjectName.HasZoomControl(%CrystalShowZoom)
  %CrystalObjectName.ShowToolBarTips(%CrystalShowTbTips)
  %CrystalObjectName.ShowDocumentTips(%CrystalShowDocTips)
  #ENDIF
  Do %CrystalObjectName:PreviewSetupOptions
#DECLARE(%Cr8PreviewParms)
#IF( SUB( %CrystalWindowTitle, 1,1 ) = '!' )
  #SET( %Cr8PreviewParms, %CrystalWindowTitle )
#ELSE
  #SET( %Cr8PreviewParms, '''' & CLIP( %CrystalWindowTitle ) & '''' )
#ENDIF
#SET( %Cr8PreviewParms, CLIP( %Cr8PreviewParms ) & ',''' & SUB( %Cr8InitState, 1, 1 ) & '''' )
#SET( %Cr8PreviewParms, CLIP( %Cr8PreviewParms ) & ',''' & SUB( %Cr8FrameType, 1, 1 ) & '''' )
#IF( CLIP( %Cr8Icon ) <> '' )
  #SET( %Cr8PreviewParms, CLIP( %Cr8PreviewParms ) & ',''' & SUB( %Cr8Icon, 1, 1 ) & '.ICO''' )
#ELSE
  #SET( %Cr8PreviewParms, CLIP( %Cr8PreviewParms ) & ',' )
#ENDIF
#SET( %Cr8PreviewParms, CLIP( %Cr8PreviewParms ) & ',' & %Cr8SystemMenu & ',' & %Cr8MaxBox & ',' & %Cr83d )
  %CrystalObjectname.Preview( %Cr8PreviewParms )
END
%CrystalObjectName.Kill()
DISPOSE( %CrystalObjectName )
#! --------------------------------------------------------------------------
#AT(%ProcedureRoutines)
#! --------------------------------------------------------------------------
%CrystalObjectName:PreviewSetupOptions  ROUTINE
  #EMBED( %CrystalOptions, 'Set Preview Options for Crystal Report' ),%ActiveTemplateInstance[%CrystalReportName],MAP(%ActiveTemplateInstance, %ActiveTemplateInstanceDescription),TREE('Set Preview Options for Crystal 8 Report{{PRIORITY(0)}|' & CLIP(%CrystalReportName) & ' (' & CLIP( %CrystalObjectName) & '){{COLOR('&%ColorCodeSection&')}')
  EXIT
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
#! -------------------------------------------------------------------------
#CODE (PrintCrystalReport, 'Print Crystal Report'),DESCRIPTION( 'Print (without a preview) a Crystal 8 Report'),HLP('~TPLPrintCrystal')
#! -------------------------------------------------------------------------
#PROMPT ('Object Name:', @s20 ),%CrystalObjectName, REQ, DEFAULT('oCrystal8')
#DISPLAY('Report Name or' )
#PROMPT (' variable (prefixed with !):', @s128 ),%CrystalReportName
#DISPLAY('Number of copies or' )
#PROMPT (' variable:', @s128 ),%CrystalNumberOfCopies, DEFAULT('1')
#PROMPT ('Show Printer Setup?', CHECK ), %CrystalShowPrintSetup, DEFAULT( 0 ),AT(10)
#! --------------------------------------------------------------------------
#AT(%CustomGlobalDeclarations)
#! --------------------------------------------------------------------------
#IF( %ApplicationLocalLibrary )
  #ADD( %CustomGlobalDeclarationIncludes,'C55Cr8L.INC' )
#ELSE
  #ADD( %CustomGlobalDeclarationIncludes,'C55Cr8.INC')
#ENDIF
#IF(~%Target32)
  #ERROR('The Crystal Interface may only be used with 32 bit programs.')
#ELSE
  #IF( %ApplicationLocalLibrary )
    #PROJECT( 'C55Cr8L.LIB' )
  #ELSE
    #PROJECT( 'C55Cr8.LIB' )
  #ENDIF
#ENDIF
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
#! --------------------------------------------------------------------------
#AT(%DataSectionAfterWindow)
#! --------------------------------------------------------------------------
%CrystalObjectName         &Crystal8
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
%CrystalObjectName &= NEW Crystal8
#DECLARE( %TempRptName )
#IF( SUB(%CrystalReportName,1,1) = '!' )
  #SET( %TempRptName, SUB( %CrystalReportName, 2, LEN( %CrystalReportName ) ) )
IF %CrystalObjectName.Init( %TempRptName )
#ELSE
IF %CrystalObjectName.Init( '%CrystalReportName' )
#ENDIF
  Do %CrystalObjectName:PrintSetupOptions
  %CrystalObjectname._Print( %CrystalNumberOfCopies, %CrystalShowPrintSetup )
END
%CrystalObjectName.Kill()
DISPOSE( %CrystalObjectName )
#! --------------------------------------------------------------------------
#AT(%ProcedureRoutines)
#! --------------------------------------------------------------------------
%CrystalObjectName:PrintSetupOptions  ROUTINE
  #EMBED( %CrystalPrintOptions, 'Set Print Options for Crystal Report' ),%ActiveTemplateInstance[%CrystalReportName],MAP(%ActiveTemplateInstance, %ActiveTemplateInstanceDescription),TREE('Set Print Options for Crystal 8 Report{{PRIORITY(0)}|' & CLIP(%CrystalReportName) & ' (' & CLIP( %CrystalObjectName) & '){{COLOR('&%ColorCodeSection&')}')
  EXIT
#! --------------------------------------------------------------------------
#ENDAT
#! --------------------------------------------------------------------------
#! -------------------------------------------------------------------------
#CODE (GetCrystalQueryPreview, 'Get the SQL query used for a Crystal report'),DESCRIPTION( 'Get the SQL query used for a Crystal report'),HLP('~TPLGetQueryCrystal'),REQ(PreviewCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Target variable:', FIELD ),%CrystalQueryTarget,REQ
%CrystalQueryTarget = %CrystalObjectName.Query()
#! -------------------------------------------------------------------------
#CODE (GetCrystalQueryPrint, 'Get the SQL query used for a Crystal report'),DESCRIPTION( 'Get the SQL query used for a Crystal report'),HLP('~TPLGetQueryCrystal'),REQ(PrintCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Target variable:', FIELD ),%CrystalQueryTarget,REQ
%CrystalQueryTarget = %CrystalObjectName.Query()
#! -------------------------------------------------------------------------
#CODE (SetCrystalQueryPreview, 'Set the SQL query used for a Crystal report'),DESCRIPTION( 'Set the SQL query used for a Crystal report'),HLP('~TPLSetQueryCrystal'),REQ(PreviewCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Query Variable:', FIELD ),%CrystalQuery,REQ
%CrystalObjectName.Query( %CrystalQuery )
#! -------------------------------------------------------------------------
#CODE (SetCrystalQueryPrint, 'Set the SQL query used for a Crystal report'),DESCRIPTION( 'Set the SQL query used for a Crystal report'),HLP('~TPLSetQueryCrystal'),REQ(PrintCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Query Variable:', FIELD ),%CrystalQuery,REQ
%CrystalObjectName.Query( %CrystalQuery )
#! -------------------------------------------------------------------------
#CODE (GetCrystalFormulaPreview, 'Get the Selection Formula used for a Crystal report'),DESCRIPTION( 'Get the Selection Formula used for a Crystal report'),HLP('~TPLGetFormulaCrystal'),REQ(PreviewCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Target variable:', FIELD ),%CrystalFormulaTarget,REQ
%CrystalFormulaTarget = %CrystalObjectName.SelectionFormula()
#! -------------------------------------------------------------------------
#CODE (GetCrystalFormulaPrint, 'Get the Selection Formula used for a Crystal report'),DESCRIPTION( 'Get the Selection Formula used for a Crystal report'),HLP('~TPLGetFormulaCrystal'),REQ(PrintCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Target variable:', FIELD ),%CrystalFormulaTarget,REQ
%CrystalFormulaTarget = %CrystalObjectName.SelectionFormula()
#! -------------------------------------------------------------------------
#CODE (SetCrystalFormulaPreview, 'Set the Selection Formula used for a Crystal report'),DESCRIPTION( 'Set the Selection Formula used for a Crystal report'),HLP('~TPLSetFormulaCrystal'),REQ(PreviewCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Formula Variable:', FIELD ),%CrystalFormula,REQ
%CrystalObjectName.SelectionFormula( %CrystalFormula )
#! -------------------------------------------------------------------------
#CODE (SetCrystalFormulaPrint, 'Set the Selection Formula used for a Crystal report'),DESCRIPTION( 'Set the Selection Formula used for a Crystal report'),HLP('~TPLSetFormulaCrystal'),REQ(PrintCrystalReport)
#! -------------------------------------------------------------------------
#PROMPT ('Formula Variable:', FIELD ),%CrystalFormula,REQ
%CrystalObjectName.SelectionFormula( %CrystalFormula )
#! -------------------------------------------------------------------------
