#TEMPLATE(ABCWizards,'Clarion 5.5 Wizard Templates'),FAMILY('ABC')
#HELP('C55HELP.HLP')
#GROUP(%DeclareSymbols)
#!
#DECLARE(%ProgramType)
#SET(%ProgramType,'Simple')                 #!Mutually exclusive options
#!SET(%ProgramType,'Full')
#!
#DECLARE(%EditInPlaceString)                #!Dictionary user option constants - Should be case INSENSITIVE
#SET(%EditInPlaceString,'EDITINPLACE')
#!
#DECLARE(%BrowseRoutine)                    #!Used to construct the browse routine name to call for a given tab
#!
#EQUATE(%GenerationReporting,%False)
#EQUATE(%GenerateAllReports,%True)

#DECLARE(%ReplaceExistingProcedures)
#DECLARE(%TXAFile)
#DECLARE(%Comments)
#DECLARE(%CurrentProcedure)
#DECLARE(%CurrentTab)
#DECLARE(%InitializeTab)
#!
#DECLARE(%WindowWidth)
#DECLARE(%WindowHeight)
#DECLARE(%WindowButtonRows)
#DECLARE(%WindowButtonColumns)
#!
#DECLARE(%WorksheetWidth)
#DECLARE(%WorksheetHeight)
#DECLARE(%WorksheetButtonRows)
#DECLARE(%WorksheetButtonColumns)
#!
#DECLARE(%MaximumTopOffset)
#DECLARE(%CurrentX)
#DECLARE(%CurrentY)
#DECLARE(%CurrentLineLength)
#DECLARE(%ValueConstruct)
#DECLARE(%HoldConstruct)
#DECLARE(%TestHeight)
#DECLARE(%TestWidth)
#DECLARE(%TestControlType)
#DECLARE(%PictureType)
#DECLARE(%RelationRows)
#DECLARE(%RelationCols)
#DECLARE(%TabLineCount)
#DECLARE(%CheckIndentWidth)
#DECLARE(%CurrentTabLength)
#DECLARE(%CurrentTabLineLength)
#DECLARE(%ControlPlacementTries)
#DECLARE(%VerticalSpaceNextControl)
#DECLARE(%GenerateProgramSection)
#DECLARE(%GenerateInternet)
#DECLARE(%ProcCount)
#DECLARE(%ContCounter)
#DECLARE(%DecimalPortion)
#!
#DECLARE(%RelationList),MULTI
#DECLARE(%BrowseFiles),UNIQUE
#DECLARE(%ChildBrowseFiles),UNIQUE
#DECLARE(%SelectFiles),UNIQUE
#DECLARE(%UpdateFiles),UNIQUE
#!
#DECLARE(%SQLUsed)
#DECLARE(%SQLDrivers),UNIQUE
#DECLARE(%SQLFile,%SQLDrivers)
#!
#DECLARE(%ProcedureList),MULTI
#DECLARE(%QuickProcedureType,%ProcedureList)
#DECLARE(%QuickProcedurePrimary,%ProcedureList)
#DECLARE(%QuickProcedurePrimaryKey,%ProcedureList)
#DECLARE(%QuickProcedureDescription,%ProcedureList)
#DECLARE(%QuickProcedureDefault,%ProcedureList)
#DECLARE(%QuickProcedureWindow,%ProcedureList)
#DECLARE(%QuickProcedureReport,%ProcedureList)
#DECLARE(%QuickProcedureReportColumns,%ProcedureList)
#!
#DECLARE(%FilledEmbed,%ProcedureList),UNIQUE
#DECLARE(%FilledEmbedContents,%FilledEmbed),MULTI
#!
#DECLARE(%QuickOtherFiles,%ProcedureList),UNIQUE
#!
#DECLARE(%WindowLayerID,LONG),UNIQUE
#DECLARE(%WindowLayerTabText,%WindowLayerID)
#DECLARE(%WindowLayerTabREQ,%WindowLayerID)
#DECLARE(%WindowLayerTopOffset,%WindowLayerID)
#DECLARE(%WindowLayerBottomOffset,%WindowLayerID)
#DECLARE(%WindowLayerSpecialCase,%WindowLayerID)
#DECLARE(%WindowLayerCheckIndentLevel,%WindowLayerID)
#DECLARE(%WindowLayerClosed,%WindowLayerID)
#!
#DECLARE(%WindowControlID,%WindowLayerID,LONG),MULTI
#DECLARE(%WindowControl,%WindowControlID)
#DECLARE(%WindowControlXOffset,%WindowControlID)
#DECLARE(%WindowControlYOffset,%WindowControlID)
#DECLARE(%WindowControlWidth,%WindowControlID)
#DECLARE(%WindowControlHeight,%WindowControlID)
#DECLARE(%WindowControlStatement,%WindowControlID)
#!
#DECLARE(%ProcedureDataItemID,LONG),MULTI
#DECLARE(%ProcedureDataItem,%ProcedureDataItemID)
#DECLARE(%ProceduredataItemType,%ProcedureDataItemID)
#!
#DECLARE(%QuickTemplateInstance,LONG),MULTI
#DECLARE(%QuickTemplateType,%QuickTemplateInstance)
#DECLARE(%QuickTemplateParent,%QuickTemplateInstance)
#DECLARE(%QuickTemplatePrimary,%QuickTemplateInstance)
#DECLARE(%QuickTemplatePrimaryKey,%QuickTemplateInstance)
#DECLARE(%QuickTemplateProcProp,%QuickTemplateInstance)
#DECLARE(%QuickTemplateControl,%QuickTemplateInstance),MULTI
#DECLARE(%QuickTemplateSecondaryFiles,%QuickTemplateInstance),UNIQUE
#!
#DECLARE(%FileList),MULTI
#DECLARE(%FileListPromptWidth,%FileList)
#DECLARE(%FileListControlsWidth,%FileList)
#DECLARE(%FileListDescription,%FileList)
#DECLARE(%FileListSQL,%FileList)
#DECLARE(%FileListTab,%FileList),MULTI
#DECLARE(%FileListTabHasPrompts,%FileListTab)
#!
#DECLARE(%FieldListID,%FileList,LONG),UNIQUE
#DECLARE(%FieldList,%FieldListID)
#DECLARE(%FieldListType,%FieldListID)
#DECLARE(%FieldListJustification,%FieldListID)
#DECLARE(%FieldListLookup,%FieldListID)
#DECLARE(%FieldListLookupKey,%FieldListID)
#DECLARE(%FieldListLookupField,%FieldListID)
#DECLARE(%FieldListVerticalSpace,%FieldListID)
#DECLARE(%FieldListControl,%FieldListID),MULTI
#DECLARE(%FieldListControlType,%FieldListControl)
#DECLARE(%FieldListControlXOffset,%FieldListControl)
#DECLARE(%FieldListControlYOffset,%FieldListControl)
#DECLARE(%FieldListControlWidth,%FieldListControl)
#DECLARE(%FieldListControlHeight,%FieldListControl)
#DECLARE(%FieldListControlOrig,%FieldListControl)
#DECLARE(%FieldListControlLink,%FieldListControl)
#DECLARE(%FieldListCheckColumn,%FieldListID,LONG)
#DECLARE(%FieldListLinkList,%FieldListID),MULTI
#DECLARE(%FieldListTab,%FieldListID)
#DECLARE(%FieldListHeader,%FieldListID)
#DECLARE(%FieldListPicture,%FieldListID)
#DECLARE(%FieldListPromptWidth,%FieldListID)
#DECLARE(%FieldListBrowseWidth,%FieldListID)
#DECLARE(%FieldListBrowseHeaderWidth,%FieldListID)
#DECLARE(%FieldListBrowseHeaderJust,%FieldListID)
#DECLARE(%FieldListBrowseHeaderIndent,%FieldListID)
#DECLARE(%FieldListBrowseColumnJust,%FieldListID)
#DECLARE(%FieldListBrowseColumnIndent,%FieldListID)
#DECLARE(%FieldListTotalWidth,%FieldListID)
#DECLARE(%FieldListTotalHeight,%FieldListID)
#DECLARE(%FieldListRequiresEnd,%FieldListID)
#DECLARE(%FieldListReportControl,%FieldListID),MULTI
#DECLARE(%FieldListReportControlType,%FieldListReportControl)
#DECLARE(%FieldListReportControlXOffset,%FieldListReportControl)
#DECLARE(%FieldListReportControlYOffset,%FieldListReportControl)
#DECLARE(%FieldListReportControlWidth,%FieldListReportControl)
#DECLARE(%FieldListReportControlHeight,%FieldListReportControl)
#!
#DECLARE(%KeyListID,%FileList,LONG),UNIQUE
#DECLARE(%KeyList,%KeyListID)
#DECLARE(%KeyListTab,%KeyListID)
#DECLARE(%KeyListNoPopulate,%KeyListID)
#DECLARE(%KeyListDescription,%KeyListID)
#DECLARE(%KeyListField,%KeyListID),MULTI
#!
#INSERT(%QuickBrowseDeclarations)
#INSERT(%QuickFormDeclarations)
#INSERT(%QuickAppDeclarations)
#INSERT(%QuickDeclareAdditions)
#INSERT(%QuickDeclareFields)
#INSERT(%QuickDeclareProcedure)
#INSERT(%QuickDeclareDefaults)
#!--------------------------------------------------------------------------
#GROUP(%QuickDeclareDefaults)
#DECLARE(%HighestUserLevel)
#DECLARE(%Menubar)
#DECLARE(%LayerWindow)
#DECLARE(%LayerPreSheet)
#DECLARE(%LayerPostSheet)
#DECLARE(%LayerFirstChildBrowse)
#DECLARE(%MaximumSheetHeight)
#DECLARE(%MaximumSheetWidth)
#DECLARE(%MinimumSheetWidth)
#DECLARE(%MinimumTextHeight)
#DECLARE(%MinimumBrowseHeight)
#DECLARE(%MaximumBrowseItemWidth)
#DECLARE(%InitialSheetYOffset)
#DECLARE(%DefaultXOffset)
#DECLARE(%DefaultYOffset)
#DECLARE(%DefaultReportXOffset)
#DECLARE(%DefaultReportColumns)
#DECLARE(%DefaultReportInitialYOffset)
#DECLARE(%DefaultReportYOffset)
#DECLARE(%DefaultReportTextYOffset)
#DECLARE(%DefaultButtonWidth)
#DECLARE(%DefaultButtonHeight)
#DECLARE(%DefaultRadioHeight)
#DECLARE(%DefaultRadioWidth)
#DECLARE(%DefaultCheckHeight)
#DECLARE(%DefaultCheckBoxXOffset)
#DECLARE(%DefaultPromptWidth)
#DECLARE(%DefaultPromptHeight)
#DECLARE(%DefaultControlHeight)
#DECLARE(%DefaultControlWidth)
#DECLARE(%MinimumControlWidth)
#DECLARE(%DefaultPromptYOffset)
#DECLARE(%DefaultListItemHeight)
#DECLARE(%MaximumRelationCols)
#DECLARE(%MinimumTabLength)
#DECLARE(%TabTextOffset)
#DECLARE(%TabLineVerticalOffset)
#DECLARE(%TabDefaultVerticalOffset)
#DECLARE(%DefaultSpinWidthOffset)
#DECLARE(%MaximumCheckColumns)
#DECLARE(%CheckColumnWidth)
#DECLARE(%MaximumBrowseFields)
#DECLARE(%RadioInitialYOffset)
#DECLARE(%DefaultRadioXOffset)
#DECLARE(%DefaultRadioYOffset)
#DECLARE(%TopControlOffset)
#DECLARE(%MiddleControlOffset)
#DECLARE(%BottomControlOffset)
#DECLARE(%TextControlOffset)
#DECLARE(%DefaultSelectControlText)
#DECLARE(%DefaultInsertControlText)
#DECLARE(%DefaultChangeControlText)
#DECLARE(%DefaultDeleteControlText)
#DECLARE(%DefaultCancelControlText)
#DECLARE(%DefaultCloseControlText)
#DECLARE(%DefaultHelpControlText)
#DECLARE(%DefaultOKControlText)
#EQUATE(%DataOptimize,'ISAM')
#!--------------------------------------------------------------------------
#GROUP(%BeginGeneration)
#SET(%TXAFile,%Application & '.txa')
#CREATE(%TXAFile)
#!--------------------------------------------------------------------------
#GROUP(%GenerateProcedures)
#SET(%ProcCount,0)
#MESSAGE('Wizard Code Generation Progress',0)
#MESSAGE('Beginning Generation',1)
#INSERT(%BeginGeneration)
#IF(%GenerateProgramSection)
[APPLICATION]
#IF(%FirstProcedure)
PROCEDURE %FirstProcedure
#ELSE
PROCEDURE Main
#ENDIF
DICTIONARY '%DictionaryFile'
[COMMON]
FROM ABC
[PROMPTS]
  #FOR(%File)
    #FIX(%Driver,%FileDriver)
    #IF(%Driver NOT=%FileDriver)
      #ERROR('Required driver not registered, please register '&%FileDriver)
      #ABORT
    #ENDIF
    #IF(%DriverSQL)
      #SET(%DataOptimize,'SQL')
      #BREAK
    #END
  #ENDFOR
  #MESSAGE('Optimizing code for '&%DataOptimize&'.',2)
  #CASE(%DataOptimize)
  #OF('ISAM')
%%ActiveInvisible  DEFAULT (0)
%%AllowUnFilled    DEFAULT (0)
%%RetainRow        DEFAULT (1)
%%ResetOnGainFocus DEFAULT (0)
%%AutoToolBar      DEFAULT (1)
%%AutoRefresh      DEFAULT (1)
  #OF('SQL')
%%ActiveInvisible  DEFAULT (0)
%%AllowUnFilled    DEFAULT (0)
%%RetainRow        DEFAULT (0)
%%ResetOnGainFocus DEFAULT (0)
%%AutoToolBar      DEFAULT (1)
%%AutoRefresh      DEFAULT (1)
  #ENDCASE
#ENDIF
  #IF (%GenerateInternet)
[ADDITION]
NAME Web Web
[INSTANCE]
INSTANCE 1
[PROJECT]
-- Generator
%#noedit
%#system win32
%#model clarion dll
  #ENDIF
#FOR(%ProcedureList)
  #SET(%ProcCount,%ProcCount + 1)
  #MESSAGE('Generating Procedure ' & %ProcCount & ':  ' & %ProcedureList,1)
  #MESSAGE('Generating Symbols',2)
  #INSERT(%ResetGlobalSymbols)
  #IF(%QuickProcedurePrimary)
    #FIX(%FileList,%QuickProcedurePrimary)
    #IF(NOT %FileList)
      #ADD(%FileList,%QuickProcedurePrimary)
      #INSERT(%AccumulateFieldList,%FileList)
    #ENDIF
  #ENDIF
  #SET(%CurrentProcedure,%ProcedureList)
  #MESSAGE('Constructing Procedure',2)
  #CASE(%QuickProcedureType)
  #OF('ABC Browse')
    #INSERT(%ConstructQuickBrowse)
  #OF('ABC Form')
    #INSERT(%ConstructQuickForm)
  #OF('ABC Frame')
    #INSERT(%ConstructQuickApp)
  #OF('ABC Report')
    #IF(~%GenerateAllReports)
      #CYCLE
    #ENDIF
  #ELSE
    #CYCLE
  #ENDCASE
  #FIX(%FileList,%QuickProcedurePrimary)
#INSERT(%GenerateProcedure)
#ENDFOR
#PURGE(%RelationList)
#PURGE(%BrowseFiles)
#PURGE(%ChildBrowseFiles)
#PURGE(%SelectFiles)
#PURGE(%UpdateFiles)
#PURGE(%ProcedureList)
#MESSAGE('Importing...',1)
#INSERT(%CloseAndImport)
#!--------------------------------------------------------------------------
#GROUP(%ResetGlobalSymbols)
#INSERT(%SetGlobalDefaults)
#SET(%HighestUserLevel,9999)
#SET(%Menubar,10000)
#SET(%LayerWindow,10001)
#SET(%LayerPostSheet,10002)
#SET(%LayerFirstChildBrowse,9950)
#SET(%TopControlOffset,0)
#SET(%MiddleControlOffset,10000)
#SET(%BottomControlOffset,20000)
#SET(%TextControlOffset,30000)
#FREE(%QuickTemplateInstance)
#FREE(%ProcedureDataItemID)
#FREE(%WindowLayerID)
#FREE(%RelationList)
#!--------------------------------------------------------------------------
#GROUP(%GenerateProcedure)
#IF(%QuickProcedureType='ABC Form' AND (%QuickProcedure <> %ProcedureList))
  #FIX(%File,%QuickProcedurePrimary)
  #IF(INSTRING(%EditInPlaceString,UPPER(%FileUserOptions),1,1))
    #RETURN                                                             #!Don't generate
  #ENDIF
#ENDIF
#MESSAGE('',3)
#MESSAGE('Generating Procedure Header',2)
#INSERT(%GenerateProcedureHeader)
#MESSAGE('Generating File List',2)
#INSERT(%GenerateFileList)
#MESSAGE('Generating Procedure Prompts',2)
#INSERT(%GenerateProcedurePrompts)
#MESSAGE('Generating Field Prompts',2)
#INSERT(%GenerateFieldPrompts)
#MESSAGE('Generating Extensions',2)
#INSERT(%GenerateAdditionPrompts)
#MESSAGE('Generating Embeds',2)
#INSERT(%GenerateEmbeds)
#IF(%QuickProcedureType='ABC Frame' AND %SQLUsed)
[EMBED]
EMBED %%WindowManagerMethodCodeSection
[INSTANCES]
WHEN 'Init'
[INSTANCES]
WHEN '(),BYTE'
[DEFINITION]
[SOURCE]
PROPERTY:BEGIN
PRIORITY 6400
PROPERTY:END
SETCURSOR(Cursor:Wait)
OPEN(SQLOpenWindow)
ACCEPT
  IF EVENT() = Event:OpenWindow
[SOURCE]
PROPERTY:BEGIN
PRIORITY 7800
PROPERTY:END
    POST(EVENT:CloseWindow)
  END
END
CLOSE(SQLOpenWindow)
SETCURSOR()
[END]
[END]
[END]
[END]
#ENDIF
#IF(%QuickProcedureWindow)
#MESSAGE('Generating Window',2)
#INSERT(%GenerateWindow)
#ENDIF
#IF(%QuickProcedureReport)
#MESSAGE('Generating Report',2)
#INSERT(%GenerateReport)
#ENDIF
#MESSAGE('',2)
#!--------------------------------------------------------------------------
#GROUP(%CloseAndImport)
#CLOSE(%TXAFile)
#!CLOSE(%Comments)
#IMPORT(%TXAFile),REPLACE
#!--------------------------------------------------------------------------
#GROUP(%GenerateFileList)
[FILES]
#IF(%QuickProcedureWindow)
  #FOR(%QuickTemplateInstance),WHERE(%QuickTemplatePrimary)
[PRIMARY]
%QuickTemplatePrimary
[INSTANCE]
%QuickTemplateInstance
    #IF(%QuickTemplatePrimaryKey)
[KEY]
%QuickTemplatePrimaryKey
    #ENDIF
    #IF(ITEMS(%QuickTemplateSecondaryFiles))
[SECONDARY]
      #FOR(%QuickTemplateSecondaryFiles)
%QuickTemplateSecondaryFiles
      #ENDFOR
    #ENDIF
  #ENDFOR
#ELSIF(%QuickProcedureReport)
[PRIMARY]
%QuickProcedurePrimary
[INSTANCE]
0
  #IF(%QuickProcedurePrimaryKey)
[KEY]
%QuickProcedurePrimaryKey
  #ENDIF
#ENDIF
#IF(ITEMS(%QuickOtherFiles))
[OTHERS]
  #FOR(%QuickOtherFiles)
%QuickOtherFiles
  #ENDFOR
#ENDIF
#!--------------------------------------------------------------------------
#GROUP(%GenerateEmbeds)
#IF(ITEMS(%FilledEmbed))
[EMBED]
  #FOR(%FilledEmbed)
EMBED %%%FilledEmbed
[DEFINITION]
[SOURCE]
    #FOR(%FilledEmbedContents)
%FilledEmbedContents
    #ENDFOR
[END]
  #ENDFOR
[END]
#ENDIF
#!--------------------------------------------------------------------------
#GROUP(%GenerateWindow)
#CASE(%QuickProcedureType)
#OF('ABC Frame')
  #IF(%ControlModel='Button')
[WINDOW]
AppFrame APPLICATION('Application'),AT(,,400,240),STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,FONT('MS Sans Serif',8,,)
  #ELSE
[ADDITION]
NAME ABC FrameBrowseControl
[INSTANCE]
INSTANCE 1
PROCPROP
[WINDOW]
AppFrame APPLICATION('Application'),AT(,,400,240),STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,FONT('MS Sans Serif',8,,)
  TOOLBAR,AT(0,0,400,22),USE(?Toolbar)
  #IF (%GenerateInternet)
    BUTTON,AT(4,2,16,14),TIP('Go to the First Page'),USE(?Toolbar:Top,Toolbar:Top),DISABLE,ICON('VCRFIRST.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Top,Toolbar:Top)
    BUTTON,AT(20,2,16,14),TIP('Go to the Prior Page'),USE(?Toolbar:PageUp,Toolbar:PageUp),DISABLE,ICON('VCRPRIOR.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:PageUp,Toolbar:PageUp)
    BUTTON,AT(36,2,16,14),TIP('Go to the Prior Record'),USE(?Toolbar:Up,Toolbar:Up),DISABLE,ICON('VCRUP.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Up,Toolbar:Up)
    BUTTON,AT(52,2,16,14),TIP('Locate record'),USE(?Toolbar:Locate,Toolbar:Locate),DISABLE,ICON('FIND.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Locate,Toolbar:Locate)
    BUTTON,AT(68,2,16,14),TIP('Go to the Next Record'),USE(?Toolbar:Down,Toolbar:Down),DISABLE,ICON('VCRDOWN.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Down,Toolbar:Down)
    BUTTON,AT(84,2,16,14),TIP('Go to the Next Page'),USE(?Toolbar:PageDown,Toolbar:PageDown),DISABLE,ICON('VCRNEXT.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:PageDown,Toolbar:PageDown)
    BUTTON,AT(100,2,16,14),TIP('Go to the Last Page'),USE(?Toolbar:Bottom,Toolbar:Bottom),DISABLE,ICON('VCRLAST.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Bottom,Toolbar:Bottom)
    BUTTON,AT(120,2,16,14),TIP('Select This Record'),USE(?Toolbar:Select,Toolbar:Select),DISABLE,ICON('MARK.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Select,Toolbar:Select)
    BUTTON,AT(136,2,16,14),TIP('Insert a New Record'),USE(?Toolbar:Insert,Toolbar:Insert),DISABLE,ICON('INSERT.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Insert,Toolbar:Insert)
    BUTTON,AT(152,2,16,14),TIP('Edit This Record'),USE(?Toolbar:Change,Toolbar:Change),DISABLE,ICON('EDIT.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Change,Toolbar:Change)
    BUTTON,AT(168,2,16,14),TIP('Delete This Record'),USE(?Toolbar:Delete,Toolbar:Delete),DISABLE,ICON('DELETE.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Delete,Toolbar:Delete)
    BUTTON,AT(188,2,16,14),TIP('Previous value'),USE(?Toolbar:History,Toolbar:History),DISABLE,ICON('DITTO.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Help,Toolbar:History)
    BUTTON,AT(204,2,16,14),TIP('Get Help'),USE(?Toolbar:Help,Toolbar:Help),DISABLE,ICON('HELP.GIF'),FLAT,#SEQ(1),#ORIG(?Toolbar:Help,Toolbar:Help)
  #ELSE
    BUTTON,AT(4,2,16,14),TIP('Go to the First Page'),USE(?Toolbar:Top,Toolbar:Top),DISABLE,ICON('VCRFIRST.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Top,Toolbar:Top)
    BUTTON,AT(20,2,16,14),TIP('Go to the Prior Page'),USE(?Toolbar:PageUp,Toolbar:PageUp),DISABLE,ICON('VCRPRIOR.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:PageUp,Toolbar:PageUp)
    BUTTON,AT(36,2,16,14),TIP('Go to the Prior Record'),USE(?Toolbar:Up,Toolbar:Up),DISABLE,ICON('VCRUP.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Up,Toolbar:Up)
    BUTTON,AT(52,2,16,14),TIP('Locate record'),USE(?Toolbar:Locate,Toolbar:Locate),DISABLE,ICON('FIND.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Locate,Toolbar:Locate)
    BUTTON,AT(68,2,16,14),TIP('Go to the Next Record'),USE(?Toolbar:Down,Toolbar:Down),DISABLE,ICON('VCRDOWN.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Down,Toolbar:Down)
    BUTTON,AT(84,2,16,14),TIP('Go to the Next Page'),USE(?Toolbar:PageDown,Toolbar:PageDown),DISABLE,ICON('VCRNEXT.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:PageDown,Toolbar:PageDown)
    BUTTON,AT(100,2,16,14),TIP('Go to the Last Page'),USE(?Toolbar:Bottom,Toolbar:Bottom),DISABLE,ICON('VCRLAST.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Bottom,Toolbar:Bottom)
    BUTTON,AT(120,2,16,14),TIP('Select This Record'),USE(?Toolbar:Select,Toolbar:Select),DISABLE,ICON('MARK.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Select,Toolbar:Select)
    BUTTON,AT(136,2,16,14),TIP('Insert a New Record'),USE(?Toolbar:Insert,Toolbar:Insert),DISABLE,ICON('INSERT.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Insert,Toolbar:Insert)
    BUTTON,AT(152,2,16,14),TIP('Edit This Record'),USE(?Toolbar:Change,Toolbar:Change),DISABLE,ICON('EDIT.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Change,Toolbar:Change)
    BUTTON,AT(168,2,16,14),TIP('Delete This Record'),USE(?Toolbar:Delete,Toolbar:Delete),DISABLE,ICON('DELETE.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Delete,Toolbar:Delete)
    BUTTON,AT(188,2,16,14),TIP('Previous value'),USE(?Toolbar:History,Toolbar:History),DISABLE,ICON('DITTO.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Help,Toolbar:History)
    BUTTON,AT(204,2,16,14),TIP('Get Help'),USE(?Toolbar:Help,Toolbar:Help),DISABLE,ICON('HELP.ICO'),FLAT,#SEQ(1),#ORIG(?Toolbar:Help,Toolbar:Help)
  #ENDIF
  END
  #ENDIF
#OF('ABC Form')
  #IF(%ControlModel NOT='Button')
[ADDITION]
NAME ABC FormVCRControls
[INSTANCE]
#SET(%ValueConstruct,ITEMS(%QuickTemplateInstance)+1)
INSTANCE %ValueConstruct
  #ENDIF
[ADDITION]
NAME ABC WindowResize
[INSTANCE]
#SET(%ValueConstruct,ITEMS(%QuickTemplateInstance)+2)
INSTANCE %ValueConstruct
[PROMPTS]
%%UseAppStrategy    DEFAULT (1)
%%AppStrategy       DEFAULT ('Surface')
%%RestrictMinSize   DEFAULT (1)
%%WindowMinWidth    DEFAULT (0)
%%WindowMaxWidth    DEFAULT (0)
[WINDOW]
QuickWindow WINDOW('%'QuickProcedureDescription'),AT(,,%WindowWidth,%WindowHeight),FONT('MS Sans Serif',8,,),RESIZE,IMM,SYSTEM,GRAY,MDI,HLP('%ProcedureList')
#OF('ABC Browse')
[ADDITION]
NAME ABC WindowResize
[INSTANCE]
#SET(%ValueConstruct,ITEMS(%QuickTemplateInstance)+1)
INSTANCE %ValueConstruct
[PROMPTS]
%%UseAppStrategy    DEFAULT (1)
%%AppStrategy       DEFAULT ('Surface')
%%RestrictMinSize   DEFAULT (1)
%%WindowMinWidth    DEFAULT (0)
%%WindowMaxWidth    DEFAULT (0)
[WINDOW]
  #IF(%ControlModel='Toolbar' AND %ProgramType NOT='Full')
    #SET(%WindowHeight,%WindowHeight-18)
  #ENDIF
QuickWindow WINDOW('%'QuickProcedureDescription'),AT(,,%WindowWidth,%WindowHeight),FONT('MS Sans Serif',8,,),IMM,SYSTEM,RESIZE,GRAY,MDI,HLP('%ProcedureList')
#ELSE
[WINDOW]
QuickWindow WINDOW('%'QuickProcedureDescription'),AT(,,%WindowWidth,%WindowHeight),FONT('MS Sans Serif',8,,),IMM,SYSTEM,GRAY,MDI,HLP('%ProcedureList')
#ENDCASE
#FIX(%WindowLayerID,%MenuBar)
#SUSPEND
  #?MENUBAR,USE(?Menubar)
    #FOR(%WindowControlID)
       %WindowControlStatement
    #ENDFOR
  #?END
#RESUME
#FIX(%WindowLayerID,%LayerPreSheet)
  #INSERT(%ConstructWindowLayer)
#SUSPEND
  #?SHEET,AT(%DefaultXOffset,%DefaultYOffset,%WorksheetWidth,%WorksheetHeight),USE(?CurrentTab),#ORIG(CurrentTab)
#FOR(%WindowLayerID),WHERE(%WindowLayerID =< %HighestUserLevel AND %WindowLayerID > %LayerPreSheet)
    TAB('%WindowLayerTabText'),USE(?Tab:%WindowLayerID)
      #INSERT(%ConstructWindowLayer)
    END
#ENDFOR
  #?END
#RESUME
#FIX(%WindowLayerID,%LayerPostSheet)
#INSERT(%ConstructWindowLayer)
#FIX(%WindowLayerID,%LayerWindow)
#INSERT(%ConstructWindowLayer)
 END
#!--------------------------------------------------------------------------
#GROUP(%ConstructWindowLayer)
#FOR(%WindowControlID)
  #FIND(%QuickTemplateControl,%WindowControl)
  #IF(%QuickTemplateControl)
 #INSERT(%PopulateControlTemplate)
  #ELSE
    #FIND(%FieldList,%WindowControl)
    #IF(%FieldList)
      #IF(%WindowLayerID = %LayerWindow)
 #INSERT(%PopulateDictionaryControl,%WindowControlXOffset,%WindowControlYOffset,%WindowWidth,%WindowHeight)
      #ELSE
 #INSERT(%PopulateDictionaryControl,%WindowControlXOffset,%WindowControlYOffset,%WorksheetWidth,%WorksheetHeight)
      #ENDIF
    #ELSE
 %WindowControlStatement,USE(%WindowControl),AT(%WindowControlXOffset,%WindowControlYOffset,%WindowControlWidth,%WindowControlHeight)
    #ENDIF
  #ENDIF
#ENDFOR
#!--------------------------------------------------------------------------
#GROUP(%GetColorSuffix),AUTO
#DECLARE(%ColorSuffix)
#IF (VAREXISTS(%Host32) AND %Host32)
  #SERVICE('C55TPLSX.DLL','GenGetColorSuffix')
#ELSE
  #SERVICE('C55TPLS.DLL','GenGetColorSuffix')
#ENDIF
#RETURN %ColorSuffix
#!--------------------------------------------------------------------------
#GROUP(%GenerateReport),AUTO
#DECLARE(%RowCount)
#DECLARE(%ColumnCount)
#DECLARE(%DetailHeight)
#DECLARE(%ReportStartX)
#DECLARE(%ReportHeight)
#DECLARE(%HeaderHeight)
#DECLARE(%ColumnWidth)
#DECLARE(%ControlPositionX)
#DECLARE(%ControlPositionY)
#DECLARE(%HeaderStartX)
#FIX(%FileList,%QuickProcedurePrimary)
#FIX(%File,%QuickProcedurePrimary)
#FIX(%Key,%QuickProcedurePrimaryKey)
#SET(%RowCount,0)
#SET(%ColumnCount,0)
#FOR(%FieldListID),WHERE(%FieldListType <> 'MEMO')
  #IF(%ColumnCount = 0)
    #SET(%RowCount,%RowCount+1)
  #ENDIF
  #SET(%ColumnCount,%ColumnCount + 1)
  #IF(%ColumnCount = %QuickProcedureReportColumns)
    #SET(%ColumnCount,0)
  #ENDIF
#ENDFOR
#IF(%RowCount = 1 AND %ColumnCount <> 0)
  #SET(%QuickProcedureReportColumns,%ColumnCount)
#ENDIF
#SET(%DetailHeight,100 + (180 * %RowCount))
#SET(%HeaderHeight,%DetailHeight + 260)
#SET(%ColumnWidth,(6000 - (100 * %QuickProcedureReportColumns)) / %QuickProcedureReportColumns)
#SET(%HeaderStartX,1000)
#SET(%ReportStartX,%HeaderHeight + %HeaderStartX)
#SET(%ReportHeight,9000 - %ReportStartX)
[WINDOW]
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100),#ORIG(Progress:Thermometer)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER,#ORIG(?Progress:UserString)
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER,#ORIG(?Progress:PctText)
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel),#ORIG(?Progress:Cancel)
     END
[REPORT]
report REPORT,AT(1000,%ReportStartX,6000,%ReportHeight),PRE(RPT),FONT('Arial',10,,),THOUS
       HEADER,AT(1000,%HeaderStartX,6000,%HeaderHeight)
         STRING('%'QuickProcedureDescription'),AT(0,20,6000,220),CENTER,FONT(,,,FONT:bold)
         BOX,AT(0,260,6000,%DetailHeight),COLOR(00H),FILL(0C0C0C0H)
#SET(%ValueConstruct,1)
#LOOP
  #IF(%ValueConstruct = %QuickProcedureReportColumns)
    #BREAK
  #ENDIF
  #SET(%ControlPositionX,%ValueConstruct * (100 + %ColumnWidth))
         LINE,AT(%ControlPositionX,260,0,%DetailHeight),COLOR(00H)
  #SET(%ValueConstruct,%ValueConstruct+1)
#ENDLOOP
#SET(%ColumnCount,0)
#SET(%RowCount,0)
#FIX(%File,%QuickProcedurePrimary)
#FOR(%FieldListID),WHERE(%FieldListType <> 'MEMO')
  #FOR(%FieldListReportControl)
    #SET(%ColumnCount,%ColumnCount+1)
    #IF(%ColumnCount > %QuickProcedureReportColumns)
      #SET(%ColumnCount,1)
      #SET(%RowCount,%RowCount+1)
    #ENDIF
    #SET(%ControlPositionX,50 + ((%ColumnCount - 1) * (100 + %ColumnWidth)))
    #SET(%ControlPositionY,50 + (%RowCount * 180) + 260)
         STRING('%'FieldListHeader'),AT(%ControlPositionX,%ControlPositionY,%ColumnWidth,170),TRN
  #ENDFOR
#ENDFOR
       END
#SET(%ColumnCount,0)
#SET(%RowCount,0)
detail DETAIL,AT(0,0,6000,%DetailHeight),USE(?detail)
#SET(%ValueConstruct,1)
#LOOP
  #IF(%ValueConstruct = %QuickProcedureReportColumns)
    #BREAK
  #ENDIF
  #SET(%ControlPositionX,%ValueConstruct * (100 + %ColumnWidth))
         LINE,AT(%ControlPositionX,0,0,%DetailHeight),COLOR(00H)
  #SET(%ValueConstruct,%ValueConstruct+1)
#ENDLOOP
#FIX(%File,%QuickProcedurePrimary)
#FOR(%FieldListID),WHERE(%FieldListType <> 'MEMO')
  #FOR(%FieldListReportControl)
    #SET(%ValueConstruct,%FieldListReportControl)
    #SET(%ValueConstruct,REPLACE(%ValueConstruct,'MSG',''))
    #SET(%ColumnCount,%ColumnCount+1)
    #IF(%ColumnCount > %QuickProcedureReportColumns)
      #SET(%ColumnCount,1)
      #SET(%RowCount,%RowCount+1)
    #ENDIF
    #SET(%ControlPositionX,50 + ((%ColumnCount - 1) * (100 + %ColumnWidth)))
    #SET(%ControlPositionY,50 + (%RowCount * 180))
         %ValueConstruct,AT(%ControlPositionX,%ControlPositionY,%ColumnWidth,170)
  #ENDFOR
#ENDFOR
         LINE,AT(50,%DetailHeight,5900,0),COLOR(00H)
       END
       FOOTER,AT(1000,9000,6000,219)
         STRING(@pPage <<<#p),AT(5250,30,700,135),FONT('Arial',8,,FONT:regular),PAGENO,USE(?PageCount)
       END
     END
#!-------------------------------------------------------
#GROUP(%AddPrimaryBrowse,%NewProcedureFile)
#DECLARE(%NewProcedureName)
#FIND(%File,%NewProcedureFile)
#SET(%NewProcedureName,'Browse' & %File)
#IF(NOT %ReplaceExistingProcedures)
  #FIX(%Procedure,%NewProcedureName)
#ENDIF
#IF(NOT %Procedure)
  #FIX(%ProcedureList,%NewProcedureName)
  #IF(NOT %ProcedureList)
    #ADD(%ProcedureList,%NewProcedureName)
    #SET(%QuickProcedureType,'ABC Browse')
    #SET(%QuickProcedurePrimary,%File)
    #SET(%QuickProcedureDescription,'Browse the ' & %File & ' File')
    #SET(%QuickProcedureDefault,'Primary Browse')
    #SET(%QuickProcedureWindow,%True)
  #ENDIF
#ENDIF
#!-------------------------------------------------------
#GROUP(%AddSecondaryBrowse,%NewProcedureKey)
#DECLARE(%NewProcedureName)
#FIND(%Key,%NewProcedureKey)
#SET(%NewProcedureName,'Browse' & %Key)
#IF(NOT %ReplaceExistingProcedures)
  #FIX(%Procedure,%NewProcedureName)
#ENDIF
#IF(NOT %Procedure)
  #FIX(%ProcedureList,%NewProcedureName)
  #IF(NOT %ProcedureList)
    #ADD(%ProcedureList,%NewProcedureName)
    #SET(%QuickProcedureType,'ABC Browse')
    #SET(%QuickProcedurePrimary,%File)
    #SET(%QuickProcedurePrimaryKey,%Key)
    #SET(%QuickProcedureDescription,'Browse the ' & %File & ' File by ' & %Key)
    #SET(%QuickProcedureDefault,'Secondary Browse')
    #SET(%QuickProcedureWindow,%True)
  #ENDIF
#ENDIF
#!-------------------------------------------------------
#GROUP(%AddSelectBrowse,%NewProcedureFile)
#DECLARE(%NewProcedureName)
#FIX(%File,%NewProcedureFile)
#SET(%NewProcedureName,'Select' & %File)
#IF(NOT %ReplaceExistingProcedures)
  #FIX(%Procedure,%NewProcedureName)
#ENDIF
#IF(NOT %Procedure)
  #FIX(%ProcedureList,%NewProcedureName)
  #IF(NOT %ProcedureList)
    #ADD(%ProcedureList,%NewProcedureName)
    #SET(%QuickProcedureType,'ABC Browse')
    #SET(%QuickProcedurePrimary,%File)
    #SET(%QuickProcedureDescription,'Select a ' & %File & ' Record')
    #SET(%QuickProcedureDefault,'Select Browse')
    #SET(%QuickProcedureWindow,%True)
  #ENDIF
#ENDIF
#!-------------------------------------------------------
#GROUP(%AddUpdateProcedure,%NewProcedureFile,%OverrideProcedureName)
#DECLARE(%NewProcedureName)
#IF(NOT %OverrideProcedureName)
  #SET(%NewProcedureName,'Update' & %NewProcedureFile)
#ELSE
  #SET(%NewProcedureName,%OverrideProcedureName)
#ENDIF
#IF(NOT %ReplaceExistingProcedures)
  #FIX(%Procedure,%NewProcedureName)
#ENDIF
#IF(NOT %Procedure)
  #FIX(%ProcedureList,%NewProcedureName)
  #IF(NOT %ProcedureList)
    #ADD(%ProcedureList,%NewProcedureName)
    #SET(%QuickProcedureType,'ABC Form')
    #SET(%QuickProcedurePrimary,%NewProcedureFile)
    #SET(%QuickProcedureDescription,'Update the ' & %NewProcedureFile & ' File')
    #SET(%QuickProcedureDefault,'Update Form')
    #SET(%QuickProcedureWindow,%True)
  #ENDIF
#ENDIF
#!-------------------------------------------------------
#GROUP(%AddReportProcedure,%NewProcedurePrimary)
#DECLARE(%NewProcedureName)
#FIX(%File,%NewProcedurePrimary)
#IF(%File)
  #SET(%NewProcedureName,'Print' & %File)
#ELSE
  #FIND(%Key,%NewProcedurePrimary)
  #SET(%NewProcedureName,'Print' & %Key)
#ENDIF
#IF(NOT %ReplaceExistingProcedures)
  #FIX(%Procedure,%NewProcedureName)
#ENDIF
#IF(NOT %Procedure)
  #FIX(%ProcedureList,%NewProcedureName)
  #IF(NOT %ProcedureList)
    #ADD(%ProcedureList,%NewProcedureName)
    #SET(%QuickProcedureType,'ABC Report')
    #SET(%QuickProcedurePrimary,%File)
    #SET(%QuickProcedurePrimaryKey,%Key)
    #IF(%Key)
      #SET(%QuickProcedureDescription,'Print the ' & %File & ' File by ' & %Key)
    #ELSE
      #SET(%QuickProcedureDescription,'Print the ' & %File & ' File')
    #ENDIF
    #SET(%QuickProcedureDefault,'Report')
    #SET(%QuickProcedureReport,%True)
    #SET(%QuickProcedureReportColumns,%DefaultReportColumns)
  #ENDIF
#ENDIF
#!--------------------------------------------------------------------------
#INCLUDE('ABWProc.TPW')
#INCLUDE('ABWCntrl.TPW')
#INCLUDE('ABWField.TPW')
#INCLUDE('ABWBrw.TPW')
#INCLUDE('ABWForm.TPW')
#INCLUDE('ABWRep.TPW')
#INCLUDE('ABWStart.TPW')
#INCLUDE('ABWApp.TPW')
#INCLUDE('ABWDeflt.TPW')
#INCLUDE('ABWDctP.TPW')
