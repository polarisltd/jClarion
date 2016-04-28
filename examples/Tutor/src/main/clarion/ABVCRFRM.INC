
!ABCIncludeFile

    OMIT('_EndOfInclude_',_FormVCRPresent_)
_FormVCRPresent_ EQUATE(1)

  INCLUDE ('ABFILE.INC'),ONCE
  INCLUDE ('ABTOOLBA.INC'),ONCE

  INCLUDE ('ABBROWSE.EQU'),ONCE
  INCLUDE ('ABBROWSE.INC'),ONCE

FormVCRClass             CLASS(ViewManager),IMPLEMENTS(FormVCRWindowComponent),TYPE,MODULE('ABVCRFRM.CLW'),LINK('ABVCRFRM.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
SaveRequired                 BYTE,PRIVATE
RestoreRequired              BYTE,PRIVATE
ViewPosition                 STRING(1024)                   !Entry's view position
CurrentEvent                 LONG,PRIVATE
ItemsToFill                  LONG,PRIVATE
VCRPageSize                  LONG,PRIVATE
QuickScan                    BYTE
OnFirstRecord                BYTE,PRIVATE
OnLastRecord                 BYTE,PRIVATE
NoRecords                    BYTE,PRIVATE
InsertWhenNoRecords          BYTE
MSAccessMode                 BYTE
MSAccessOnInsertMode         BYTE,PRIVATE
MoveDirection                BYTE,PRIVATE
VCRGroup                     LONG,PRIVATE
VCRTop                       LONG,PRIVATE
VCRUp                        LONG,PRIVATE
VCRPageUp                    LONG,PRIVATE
VCRPageDown                  LONG,PRIVATE
VCRDown                      LONG,PRIVATE
VCRBottom                    LONG,PRIVATE
VCRRequest                   LONG,PRIVATE
VCRPrevRequest               LONG,PRIVATE
VCRInsert                    LONG,PRIVATE
VCRChange                    LONG,PRIVATE
VCRDelete                    LONG,PRIVATE
VCRView                      LONG,PRIVATE
VCRNewRecord                 LONG,PRIVATE
Window                       &WindowManager,PROTECTED
RecordStatus                 BYTE,PRIVATE
Sort                         &BrowseSortOrder,PROTECTED    ! Is really a 'shadow' of the parent ORDER queue
Toolbar                      &ToolbarClass
ToolbarItem                  &ToolbarFormVCRClass
Init                         PROCEDURE(SIGNED VCRGroup,SIGNED VCRPageSize,VIEW V,RelationManager RM,WindowManager WM)   !,EXTENDS
SetVCRControls               PROCEDURE(SIGNED pVCRTop,SIGNED pVCRUp,SIGNED pVCRPageUp,SIGNED pVCRPageDown,SIGNED pVCRDown,SIGNED pVCRBottom,SIGNED pVCRNewRecord=0)
SetRequestControl            PROCEDURE(SIGNED pVCRRequest,SIGNED pVCRViewRecord,SIGNED pVCRInsertRecord,SIGNED pVCRChangeRecord,SIGNED pVCRDeleteRecord)
AddLocator                   PROCEDURE(LocatorClass L)
AddToolbarTarget             PROCEDURE(ToolbarClass TC)
TakeScroll                   PROCEDURE(SIGNED Event = 0),VIRTUAL
TakeLocate                   PROCEDURE,VIRTUAL
TakeEvent                    PROCEDURE,VIRTUAL
TakeAcceptedLocator          PROCEDURE,VIRTUAL
TakeRequestChanged           PROCEDURE(BYTE pPreviousRequest,BYTE pActualRequest),VIRTUAL
Previous                     PROCEDURE,VIRTUAL,BYTE        ! :Notify for eof, :Fatal for error condition
Next                         PROCEDURE,BYTE,VIRTUAL
TakeNextRecord               PROCEDURE(),VIRTUAL
ScrollEnd                    PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
ScrollOne                    PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
ScrollPage                   PROCEDURE(SIGNED Event),VIRTUAL,PROTECTED
SetRecord                    PROCEDURE(),VIRTUAL,PROC
Fetch                        PROCEDURE(BYTE Direction),VIRTUAL,PROTECTED
UpdateResets                 PROCEDURE(),PROTECTED
SetAlerts                    PROCEDURE(),VIRTUAL
UpdateWindow                 PROCEDURE(),VIRTUAL
UpdateToolbarButtons         PROCEDURE,PRIVATE
UpdateViewRecord             PROCEDURE(),VIRTUAL
InitSort                     PROCEDURE(BYTE NewOrder),BYTE,VIRTUAL
SetSort                      PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,VIRTUAL,PROC
ResetSort                    PROCEDURE(BYTE Force),BYTE,VIRTUAL,PROC
UpdateButtons                PROCEDURE(),VIRTUAL
Kill                         PROCEDURE(),VIRTUAL
CheckBorders                 PROCEDURE(),VIRTUAL
GetActionAllowed             PROCEDURE(SIGNED E,BYTE pActionRequested=0),BYTE,VIRTUAL
GetAction                    PROCEDURE(),BYTE,VIRTUAL
                         END

  _EndOfInclude_
