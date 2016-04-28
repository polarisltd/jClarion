! Process server header module

!ABCIncludeFile

  OMIT('_EndOfInclude_',_ReportsPresent_)
_ReportsPresent_   EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('ABWMFPAR.INC'),ONCE
  INCLUDE('ABRPTGEN.INT'),ONCE
  INCLUDE('ABRPATMG.INC'),ONCE
  INCLUDE('ABRPPSEL.INC'),ONCE
  INCLUDE('ABBreak.INC'),ONCE
  INCLUDE('PRNPROP.CLW'),ONCE

NoZoom            EQUATE(-2)
PageWidth         EQUATE(-1)

PreviewQueue      EQUATE(PrintPreviewFileQueue)

ProcessClass      CLASS(ViewManager),TYPE,MODULE('ABREPORT.CLW'),LINK('ABREPORT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
BytesRead           LONG,PRIVATE
FileSize            LONG,PRIVATE
ChildRead           BYTE
Children            &ChildList,PRIVATE
Percentile          &BYTE,PROTECTED
PText               SIGNED,PROTECTED
Query               &QueryClass
RecordsProcessed    LONG
RecordsToProcess    LONG
StepMgr             &StepClass,PRIVATE
ValueField          ANY,PRIVATE
CaseSensitiveValue  BYTE

AddItem             PROCEDURE(ViewManager VM),USHORT
Init                PROCEDURE(VIEW V,RelationManager RM,SIGNED ProgressText = 0,<*BYTE PercentProgress>,LONG GuessRecords=0)   !,EXTENDS
Init                PROCEDURE(VIEW V,RelationManager RM,SIGNED ProgressText = 0,<*BYTE PercentProgress>,StepClass SC,*? ValueField)   !,EXTENDS
Kill                PROCEDURE,VIRTUAL
Next                PROCEDURE(BYTE ProcessRecords=True),VIRTUAL,BYTE
Reset               PROCEDURE,VIRTUAL
SetProgressLimits   PROCEDURE
SetProgressLimits   PROCEDURE(STRING Low,STRING High)
TakeAccepted        PROCEDURE,VIRTUAL
TakeLocate          PROCEDURE,VIRTUAL
TakeRecord          PROCEDURE,BYTE,VIRTUAL,PROC
UpdateDisplay       PROCEDURE,PRIVATE
               END


MinXSeperation      EQUATE(3)                        !thumbnail minimum seperations in X and Y directions
MinYSeperation      EQUATE(3)
ZoomItem            EQUATE(200)                      !Base feq for zoom menu items
BaseFeq             EQUATE(500)                      !Base feq for dynamically created controls

SaveSizeType      GROUP,TYPE
Set                 BYTE
XPos                SHORT
YPos                SHORT
Width               USHORT
Height              USHORT
                  END

PrintPreviewClass CLASS(WindowManager),TYPE,MODULE('ABREPORT.CLW'),LINK('ABREPORT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AllowUserZoom       BYTE                                      !Set to false to remove User Zoom feature - backward compatibility
ConfirmPages        BYTE                                      !Set true to force 'pages to print' confirmation before printing
CurrentPage         LONG
MDIWindow           BOOL                                      !Set true to open the previewer window as an MDI child window
FirstPage           LONG,PRIVATE
ImageQueue          &PreviewQueue,PROTECTED
OutputFileQueue     &OutputFileQueue,PROTECTED
INIMgr              &INIClass,PRIVATE
InitZoom            SHORT,PRIVATE
Maximize            BYTE                                      !Set true to maximize Viewer Window
mUse                BYTE,DIM(32),PRIVATE                      !Use variables for dynamically created menu items
PageManager         &PageManagerClass,PRIVATE                 !Pointer to last page manager in linked list
PagesAcross         USHORT
PagesDown           USHORT
PagesToPrint        CSTRING(256),PROTECTED
Popup               &PopupClass,PROTECTED
PreviewWindow       &WINDOW,PRIVATE
PrintEngine         &PrintEngineClass,PROTECTED
PrintOK             BYTE,PRIVATE
TargetSelector      &ReportTargetSelectorClass,PROTECTED
SaveSize            LIKE(SaveSizeType),PRIVATE
ThumbnailsPresent   USHORT,PRIVATE
UserPercentile      USHORT(0)                                 !Allows user to set their own percentile zoom factor
WindowPosSet        BYTE(False)                               !Flags prefered initial position set
WindowSizeSet       BYTE(False)                               !Flags prefered initial size set
WinHeight           SHORT,PRIVATE
WinWidth            SHORT,PRIVATE
WinXPos             SHORT,PRIVATE
WinYPos             SHORT,PRIVATE
WMFParser           &WMFDocumentParser,PROTECTED
ZoomQueue           &ZoomItemQueue,PRIVATE
ReportTarget        &IReportGenerator,PROTECTED
ZoomIndex           BYTE                                      !index number of zoom factor in ZoomPresets group or 0 if user zoom active
ZoomList            STRING(16),PRIVATE                        !Use variable for drop Combo, zoom list

PrtPrev:TBarZoom    USHORT,PROTECTED                           !These variables hold the feq's of various preview window components
PrtPrev:TBarPrint   USHORT,PROTECTED
PrtPrev:TBarExit    USHORT,PROTECTED
PrtPrev:MenuPages   USHORT,PROTECTED
PrtPrev:MenuPrint   USHORT,PROTECTED
PrtPrev:MenuSaveAs  USHORT,PROTECTED
PrtPrev:MenuExit    USHORT,PROTECTED
PrtPrev:ZoomList    USHORT,PROTECTED
PrtPrev:ZoomPrompt  USHORT,PROTECTED
PrtPrev:PagePrompt  USHORT,PROTECTED
PrtPrev:CurrentPage USHORT,PROTECTED
PrtPrev:PagesAcross USHORT,PROTECTED
PrtPrev:PagesDown   USHORT,PROTECTED
PrtPrev:Next        USHORT,PROTECTED
PrtPrev:Previous    USHORT,PROTECTED
PrtPrev:Jump        USHORT,PROTECTED
PrtPrev:ChangeDisplay USHORT,PROTECTED
PrtPrev:ViewMenu    USHORT,PROTECTED
PrtPrev:ZoomMenu    USHORT,PROTECTED
PrtPrev:LastCtrl    USHORT,PROTECTED
PrtPrev:LastDynCtrl USHORT,PROTECTED

AskPage             PROCEDURE,BYTE,PROC,VIRTUAL,PROTECTED
AskPrintPages       PROCEDURE,BYTE,PROC,VIRTUAL,PROTECTED     !Returns false if user cancelled
AskThumbnails       PROCEDURE,VIRTUAL,PROTECTED
ConfigMenuChecks    PROCEDURE,PRIVATE
DeleteImageQueue    PROCEDURE(LONG Idx),BYTE,PROC,VIRTUAL
Display             PROCEDURE(SHORT InitZoomFactor=0,LONG InitCurrentPage=1,USHORT InitPagesAcross=1,USHORT InitPagesDown=1),BYTE,VIRTUAL
DrawPage            PROCEDURE,PRIVATE
Init                PROCEDURE(PreviewQueue ImageQueue),VIRTUAL
Init                PROCEDURE(PreviewQueue ImageQueue, ReportTargetSelectorClass pTargetSelector, WMFDocumentParser WMFDocParser),VIRTUAL
InPageList          PROCEDURE(LONG PageNumber),BYTE
Kill                PROCEDURE,PROC,BYTE,VIRTUAL
NewZoom             PROCEDURE,PRIVATE
Open                PROCEDURE,VIRTUAL
ProcessResultFiles  PROCEDURE(OutputFileQueue OutputFile),BYTE,VIRTUAL
ResetUserZoom       PROCEDURE,PRIVATE
SetDefaultPages     PROCEDURE,VIRTUAL
SetINIManager       PROCEDURE(INIClass INI)                 !Allows Previewer to use programs INI file for setting restoration between calls
SetPosition         PROCEDURE(<SHORT XPos>,<SHORT YPos>,<SHORT Width>,<SHORT Height>)
SetZoomPercentile   PROCEDURE(SHORT Percentile)                !Sets zoom to a given percentage
SyncImageQueue      PROCEDURE,VIRTUAL
TakeAccepted        PROCEDURE,VIRTUAL,BYTE,PROC
TakeEvent           PROCEDURE,VIRTUAL,BYTE,PROC
TakeWindowEvent     PROCEDURE,VIRTUAL,BYTE,PROC
TakeFieldEvent      PROCEDURE,VIRTUAL,BYTE,PROC
                  END

ReportManager CLASS(WindowManager),TYPE,MODULE('ABREPORT.CLW'),LINK('ABREPORT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
DeferOpenReport     BYTE,PROTECTED
DeferWindow         USHORT,PROTECTED
KeepVisible         BYTE,PROTECTED
OpenFailed          BYTE,PRIVATE
Processors          &ProcessorQueue,PRIVATE
Preview             &PrintPreviewClass,PROTECTED
PreviewQueue        &PreviewQueue,PROTECTED
OutputFileQueue     &OutputFileQueue,PROTECTED
Process             &ProcessClass,PROTECTED
Attribute           &ReportAttributeManager,PROTECTED
ReportTarget        &IReportGenerator,PROTECTED
TargetSelector      &ReportTargetSelectorClass,PROTECTED
TargetSelectorCreated    BYTE,PROTECTED
BreakMan            &BreakManagerClass,PROTECTED
RecordsPerCycle     LONG,PRIVATE
QueryControl        SIGNED
Report              &WINDOW
SkipPreview         BYTE
StartTime           LONG,PRIVATE
TimeSlice           USHORT
WaitCursor          BYTE,PROTECTED
WMFParser           &WMFDocumentParser,PROTECTED
Zoom                SHORT
AddItem             PROCEDURE(RecordProcessor RC)
AddItem             PROCEDURE(*ReportTargetSelectorClass pTargetSelector)
AddItem             PROCEDURE(*BreakManagerClass pBreakMan)
SetReportTarget     PROCEDURE(IReportGenerator pReportTarget)
Ask                 PROCEDURE,VIRTUAL
AskPreview          PROCEDURE,VIRTUAL
EndReport           PROCEDURE(),BYTE,VIRTUAL
PrintReport         PROCEDURE(),VIRTUAL
CancelPrintReport   PROCEDURE(),VIRTUAL
Next                PROCEDURE,PROC,BYTE,VIRTUAL
Init                PROCEDURE(ProcessClass PC,<REPORT R>,<PrintPreviewClass PV>)   !,EXTENDS
Kill                PROCEDURE,PROC,BYTE,VIRTUAL
Open                PROCEDURE,VIRTUAL
OpenReport          PROCEDURE,BYTE,PROC,PROTECTED,VIRTUAL
ProcessResultFiles  PROCEDURE(OutputFileQueue OutputFile),BYTE,VIRTUAL
SetStaticControlsAttributes PROCEDURE(),VIRTUAL
SetDynamicControlsAttributes PROCEDURE(),VIRTUAL
TakeAccepted        PROCEDURE,BYTE,PROC,PROTECTED,DERIVED
TakeCloseEvent      PROCEDURE,BYTE,PROC,VIRTUAL
TakeNoRecords       PROCEDURE,VIRTUAL
TakeRecord          PROCEDURE,BYTE,VIRTUAL,PROC
TakeWindowEvent     PROCEDURE,VIRTUAL,BYTE,PROC
  END

  _EndOfInclude_

