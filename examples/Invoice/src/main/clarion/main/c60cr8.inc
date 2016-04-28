HTMLExportOptions     ITEMIZE
UXFHTML3Type            EQUATE(0)          !// Draft HTML 3.0 tags
UXFExplorer2Type        EQUATE(1)          !// Include MS Explorer 2.0 tags
UXFNetscape2Type        EQUATE(2)          !// Include Netscape 2.0 tags
UXFHTML32ExtType        EQUATE(1)          !// HTML 3.2 tags + bg color extensions
UXFHTML32StdType        EQUATE(2)          !// HTML 3.2 tags
UXFHTML4Type            EQUATE(3)          !// HTML 4.0
                      END

Crystal8              CLASS,TYPE,DLL(TRUE),MODULE('cwCR8')
hPrintJob               SHORT
szReportName            CSTRING( FILE:MaxFilePath + FILE:MaxFileName )

bAllowPrompt            BYTE(TRUE),PRIVATE
bCanDrillDown           BYTE(TRUE),PRIVATE
bHasCancelButton        BYTE(TRUE),PRIVATE
bHasCloseButton         BYTE(TRUE),PRIVATE
bHasExportButton        BYTE(TRUE),PRIVATE
bHasLaunchButton        BYTE(TRUE),PRIVATE
bHasNavigationControls  BYTE(TRUE),PRIVATE
bHasPrintButton         BYTE(TRUE),PRIVATE
bHasPrintSetupButton    BYTE(TRUE),PRIVATE
bHasProgressControls    BYTE(TRUE),PRIVATE
bHasRefreshButton       BYTE(TRUE),PRIVATE
bHasSearchButton        BYTE(TRUE),PRIVATE
bHasZoomControl         BYTE(TRUE),PRIVATE
bShowToolbarTips        BYTE(TRUE),PRIVATE
bShowDocumentTips       BYTE(TRUE),PRIVATE
bShowReportControls     BYTE(TRUE),PRIVATE
hEngine                 UNSIGNED,PRIVATE
hReport                 UNSIGNED,PRIVATE

Init                    PROCEDURE( STRING sReportName ), BYTE
Kill                    PROCEDURE()
Preview                 PROCEDURE( <STRING sWindowTitle>, <STRING sInitState>, <STRING sFrame>, <STRING sIcon>, BYTE bSysMnu=FALSE, BYTE bMaxBox=TRUE, BYTE b3d=TRUE )
_Print                  PROCEDURE( SHORT iCopies=1, BYTE bPrinterSetup=FALSE )
AllowPrompt             PROCEDURE( <BYTE bAllowPrompt> ), PROC, BYTE
CanDrillDown            PROCEDURE( <BYTE bCanDrillDown> ), PROC, BYTE
HasCancelButton         PROCEDURE( <BYTE bHasCancelButton> ), PROC, BYTE
HasCloseButton          PROCEDURE( <BYTE bHasCloseButton> ), PROC, BYTE
HasExportButton         PROCEDURE( <BYTE bHasExportButton> ), PROC, BYTE
HasLaunchButton         PROCEDURE( <BYTE bHasLaunchButton> ), PROC, BYTE
HasNavigationControls   PROCEDURE( <BYTE bHasNavigationControls> ), PROC, BYTE
HasPrintButton          PROCEDURE( <BYTE bHasPrintButton> ), PROC, BYTE
HasPrintSetupButton     PROCEDURE( <BYTE bHasPrintSetupButton> ), PROC, BYTE
HasProgressControls     PROCEDURE( <BYTE bHasProgressControls> ), PROC, BYTE
HasRefreshButton        PROCEDURE( <BYTE bHasRefreshButton> ), PROC, BYTE
HasSearchButton         PROCEDURE( <BYTE bHasSearchButton> ), PROC, BYTE
HasZoomControl          PROCEDURE( <BYTE bHasZoomControl> ), PROC, BYTE
ShowToolbarTips         PROCEDURE( <BYTE bShowToolbarTips> ), PROC, BYTE
ShowDocumentTips        PROCEDURE( <BYTE bShowDocumentTips> ), PROC, BYTE
ShowReportControls      PROCEDURE( <BYTE bShowReportControls> ), PROC, BYTE
Query                   PROCEDURE( <STRING sQueryString> ),PROC,STRING
SelectionFormula        PROCEDURE( <STRING sFormulaString> ),PROC,STRING
CrystalError            PROCEDURE( STRING sErrorMsg )
!ExportHTML              PROCEDURE( STRING sFileName, LONG lExportType=UXFHTML32StdType )
                      END
