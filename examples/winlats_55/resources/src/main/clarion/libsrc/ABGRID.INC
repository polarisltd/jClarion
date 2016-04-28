
!ABCIncludeFile

OMIT('_EndOfInclude_',_GridPresent_)
_GridPresent_ EQUATE(1)

  INCLUDE ('ABBROWSE.INC'),ONCE

ChildQueue QUEUE,TYPE
Feq SIGNED
XD  SIGNED
YD  SIGNED
HE  SIGNED
WI  SIGNED
Use ANY
  END

GridClass CLASS(BrowseClass),IMPLEMENTS(IListControl),TYPE,MODULE('ABGRID.CLW'),DLL(_ABCDllMode_),LINK('ABGRID.CLW',_ABCLinkMode_)
ListControl          SIGNED,PRIVATE
UpdateControl        SIGNED
UpdateControlEvent   SIGNED

Across               SIGNED,PRIVATE
Children             &ChildQueue,PROTECTED
Chosen               SIGNED,PROTECTED
ClickPress           SIGNED,PROTECTED
Down                 SIGNED,PRIVATE
GroupColor           LONG,PROTECTED
GroupControl         SIGNED,PROTECTED
GroupTitle           ASTRING,PROTECTED
FetchRecord          PROCEDURE(LONG Record)
ControlBase          SIGNED,PROTECTED
ControlNumber        SIGNED,PROTECTED
MyBehavior            &StandardBehavior,PRIVATE
SelColor             LONG,PROTECTED
Selectable           BYTE
HWM                  SIGNED,PRIVATE
AddLocator           PROCEDURE(LocatorClass LC)
CheckChildren        PROCEDURE,PRIVATE
CreateControls       PROCEDURE,PRIVATE
GetDimensions        PROCEDURE,PRIVATE
GetPosition          PROCEDURE(SIGNED Instance, *SIGNED XPos, *SIGNED Ypos),VIRTUAL,PROTECTED
Init                 PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)   !,EXTENDS
Kill                 PROCEDURE,DERIVED
SetAlerts            PROCEDURE,DERIVED
SyncGroup            PROCEDURE(LONG Record)
TakeEvent            PROCEDURE,DERIVED
UpdateWindow         PROCEDURE,DERIVED
IfGroupField         PROCEDURE(SIGNED Fld),BYTE
GetAcross            PROCEDURE,SIGNED
GetDown              PROCEDURE,SIGNED
GetClickPress        PROCEDURE,SIGNED
IsSkelActive         PROCEDURE,BYTE,VIRTUAL
UpdateControls       PROCEDURE(LONG Record),PRIVATE
UpdateRecord         PROCEDURE(SIGNED Record),VIRTUAL
  END

_EndOfInclude_






