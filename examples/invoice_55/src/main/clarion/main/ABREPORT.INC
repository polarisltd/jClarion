! Process server header module

!ABCIncludeFile

  OMIT('_EndOfInclude_',_ReportsPresent_)
_ReportsPresent_   EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE

NoZoom            EQUATE(-2)
PageWidth         EQUATE(-1)

PreviewQueue      QUEUE,TYPE
Filename            STRING(128)
                  END

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
FirstPage           LONG,PRIVATE
ImageQueue          &PreviewQueue,PROTECTED
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
PrintOK             BYTE,PRIVATE
SaveSize            LIKE(SaveSizeType),PRIVATE
ThumbnailsPresent   USHORT,PRIVATE
UserPercentile      USHORT(0)                                 !Allows user to set their own percentile zoom factor
WindowPosSet        BYTE(False)                               !Flags prefered initial position set
WindowSizeSet       BYTE(False)                               !Flags prefered initial size set
WinHeight           SHORT,PRIVATE
WinWidth            SHORT,PRIVATE
WinXPos             SHORT,PRIVATE
WinYPos             SHORT,PRIVATE
ZoomQueue           &ZoomItemQueue,PRIVATE
ZoomIndex           BYTE                                      !index number of zoom factor in ZoomPresets group or 0 if user zoom active
ZoomList            STRING(16),PRIVATE                        !Use variable for drop Combo, zoom list

PrtPrev:TBarZoom    USHORT,PRIVATE                            !These variables hold the feq's of various preview window components
PrtPrev:TBarPrint   USHORT,PRIVATE
PrtPrev:TBarExit    USHORT,PRIVATE
PrtPrev:MenuPages   USHORT,PRIVATE
PrtPrev:MenuPrint   USHORT,PRIVATE
PrtPrev:MenuExit    USHORT,PRIVATE
PrtPrev:ZoomList    USHORT,PRIVATE
PrtPrev:ZoomPrompt  USHORT,PRIVATE
PrtPrev:PagePrompt  USHORT,PRIVATE
PrtPrev:CurrentPage USHORT,PRIVATE
PrtPrev:PagesAcross USHORT,PRIVATE
PrtPrev:PagesDown   USHORT,PRIVATE
PrtPrev:Next        USHORT,PRIVATE
PrtPrev:Previous    USHORT,PRIVATE
PrtPrev:Jump        USHORT,PRIVATE
PrtPrev:ChangeDisplay USHORT,PRIVATE
PrtPrev:ViewMenu    USHORT,PRIVATE
PrtPrev:ZoomMenu    USHORT,PRIVATE

AskPage             PROCEDURE,BYTE,PROC,VIRTUAL,PROTECTED
AskPrintPages       PROCEDURE,BYTE,PROC,VIRTUAL,PROTECTED     !Returns false if user cancelled
AskThumbnails       PROCEDURE,VIRTUAL,PROTECTED
ConfigMenuChecks    PROCEDURE,PRIVATE
DeleteImageQueue    PROCEDURE(LONG Idx),BYTE,PROC,VIRTUAL
Display             PROCEDURE(SHORT InitZoomFactor=0,LONG InitCurrentPage=1,USHORT InitPagesAcross=1,USHORT InitPagesDown=1),BYTE,VIRTUAL
DrawPage            PROCEDURE,PRIVATE
Init                PROCEDURE(PreviewQueue ImageQueue),VIRTUAL
InPageList          PROCEDURE(LONG PageNumber),BYTE
Kill                PROCEDURE,PROC,BYTE,VIRTUAL
NewZoom             PROCEDURE,PRIVATE
Open                PROCEDURE,VIRTUAL
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
Process             &ProcessClass,PROTECTED
RecordsPerCycle     LONG,PRIVATE
QueryControl        SIGNED
Report              &WINDOW
SkipPreview         BYTE
StartTime           LONG,PRIVATE
TimeSlice           USHORT
WaitCursor          BYTE,PROTECTED
Zoom                SHORT
AddItem             PROCEDURE(RecordProcessor RC)
Ask                 PROCEDURE,VIRTUAL
AskPreview          PROCEDURE,VIRTUAL
Next                PROCEDURE,PROC,BYTE,VIRTUAL
Init                PROCEDURE(ProcessClass PC,<REPORT R>,<PrintPreviewClass PV>)   !,EXTENDS
Kill                PROCEDURE,PROC,BYTE,VIRTUAL
Open                PROCEDURE,VIRTUAL
OpenReport          PROCEDURE,BYTE,PROC,PROTECTED,VIRTUAL
TakeAccepted        PROCEDURE,BYTE,PROC,PROTECTED,DERIVED
TakeCloseEvent      PROCEDURE,BYTE,PROC,VIRTUAL
TakeNoRecords       PROCEDURE,VIRTUAL
TakeRecord          PROCEDURE,BYTE,VIRTUAL,PROC
TakeWindowEvent     PROCEDURE,VIRTUAL,BYTE,PROC
  END

  _EndOfInclude_

