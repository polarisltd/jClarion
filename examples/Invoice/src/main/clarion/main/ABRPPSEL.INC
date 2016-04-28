!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_ReportTargetSelectorClassPresent_)
_ReportTargetSelectorClassPresent_ EQUATE(1)

 INCLUDE('abrptgen.int'),ONCE

TargetReportGeneratorQueue   QUEUE(ReportGeneratorQueue),TYPE
EnableOnPreview                 BYTE
                             END
                       
ReportTargetSelectorClass    CLASS,MODULE('ABRPPSEL.CLW'),TYPE,LINK('ABRPPSEL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Horizontal              BYTE
Stretch                 BYTE
WithPrinter             BYTE,PROTECTED
PrintSelected           BYTE,PROTECTED
PlugInSelected          &IReportGenerator,PROTECTED!only is valid if the ASK return true
QPlugIn                 &TargetReportGeneratorQueue,PROTECTED
SetSize                 PROCEDURE(BYTE pHorizontal=6,BYTE pStretch=1) ! The dialog resize it self, the pHorizontal is the max number of option to display before create a second option's row
AddItem                 PROCEDURE(IReportGenerator pPlugIn,BYTE pEnableOnPreview=1) ! Add a plugin to the object
Ask                     PROCEDURE(BYTE pWithPrinter=0,BYTE pFromPreview=0),BYTE !Return true if the user click OK and false if the user click Cancel. If pWithPrinter=True then the printer Option is showed on the dialog
Items                   PROCEDURE(),BYTE ! Return the number of plugin registered into the object
GetPrintSelected        PROCEDURE(),BYTE ! After the Ask it Return true if the print option was supported and selected.
GetSelected             PROCEDURE(),*IReportGenerator !It is only valid to call this method if GetPrintSelected=False
FillQueue               PROCEDURE(QUEUE QueueToFill,BYTE ColumnToFill=1)
GetReportGenerator      PROCEDURE(STRING GeneratorName),*IReportGenerator
GetReportGeneratorName  PROCEDURE(SHORT GeneratorPos),STRING !If the Pos is not valid it return ''
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
                      END

 _EndOfInclude_
