
!ABCIncludeFile

OMIT('_EndOfInclude_',_QueryClassPresent_)
_QueryClassPresent_ EQUATE(1)

          INCLUDE('ABWINDOW.INC'),ONCE
          INCLUDE('ABUTIL.INC'),ONCE


  ITEMIZE(0)
QBEUnknown      EQUATE
QBEFormBased    EQUATE
QBEListBased    EQUATE
  END


QueryClass  CLASS,TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Errors          &ErrorClass,PRIVATE
Fields          &FieldQueue,PRIVATE
Family          &STRING,PRIVATE
INIMgr          &INICLass,PRIVATE
PopupList       &PopupQueue,PRIVATE
QkSupport       BYTE
QkIcon          CSTRING(255)
QkMenuIcon      CSTRING(255)
QkSubMenuPos    USHORT,PRIVATE
QkCurrentQuery  CSTRING(100)
ParentWindow    &Window
Window          &Window
Win             &QueryVisual,PRIVATE
AddItem         PROCEDURE(STRING FieldName, STRING Title, <STRING Picture>,BYTE ForceEditPicture=1)
Ask             PROCEDURE(BYTE UseLast=1),BYTE,PROC,VIRTUAL    ! Level:Blarg error code
FindName        PROCEDURE(STRING Nme),PRIVATE
GetName         PROCEDURE(STRING Title),STRING,PRIVATE
GetFilter       PROCEDURE,STRING
GetLimit        PROCEDURE(*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,BYTE High=0),BYTE,PROC,PRIVATE
GetLimit        PROCEDURE(STRING FieldName,*CSTRING Value,*CSTRING Operator,*BYTE CaseLess),PROTECTED  ! ***Direct use of these functions implies only formatted data accepted
GetLimit        PROCEDURE(STRING FieldName,*CSTRING Low,*CSTRING High,*CSTRING Eq),PROTECTED           ! ***Direct use of these functions implies only formatted data accepted
GetLimit        PROCEDURE(*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,BYTE High=0,*CSTRING Picture),BYTE,PROC,PRIVATE
GetLimit        PROCEDURE(STRING FieldName,*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,*CSTRING Picture),PROTECTED
Init            PROCEDURE(<QueryVisual Q>)   !,EXTENDS
Init            PROCEDURE(QueryVisual Q,INIClass INIMgr, STRING Family, ErrorClass E)   !,EXTENDS
Kill            PROCEDURE,VIRTUAL
Quote           PROCEDURE(STRING Txt),STRING,PRIVATE
Reset           PROCEDURE(<STRING FieldName>)
SetLimit        PROCEDURE(STRING FieldName,<STRING Low>,<STRING High>,<STRING Eq>)
SetQuickPopup   PROCEDURE(PopupClass Popup, USHORT QueryControl)
Save            PROCEDURE(STRING QueryName)
Take            PROCEDURE(PopupClass Popup),BYTE
Restore         PROCEDURE(STRING QueryName)
Delete          PROCEDURE(STRING QueryName),PROTECTED
GetQueries      PROCEDURE(*SectorQueue QQ),PROTECTED
ClearQuery      PROCEDURE(),PROTECTED
                              END

QueryVisual  CLASS(WindowManager),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
QC                &QueryClass
Resizer           &WindowResizeClass
Queries           &SectorQueue,PRIVATE

Init              PROCEDURE,BYTE,DERIVED,PROC
TakeAccepted      PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent    PROCEDURE,DERIVED,BYTE,PROC
Kill              PROCEDURE,DERIVED,PROC,BYTE
Reset             PROCEDURE(BYTE Force=0),DERIVED
TakeWindowEvent   PROCEDURE,DERIVED,BYTE,PROC
ResetFromQuery    PROCEDURE,VIRTUAL
Type              PROCEDURE(),UNSIGNED,VIRTUAL
UpdateFields      PROCEDURE(),VIRTUAL
  END

QueryFormVisual CLASS(QueryVisual),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
QFC               &QueryFormClass
GetButtonFeq      PROCEDURE(SIGNED index),SIGNED
Init              PROCEDURE,BYTE,DERIVED,PROC   !,EXTENDS
SetText           PROCEDURE(USHORT Control, STRING EntryText)
TakeAccepted      PROCEDURE,DERIVED,BYTE,PROC
TakeCompleted     PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent    PROCEDURE,DERIVED,BYTE,PROC
ResetFromQuery    PROCEDURE,DERIVED
Type              PROCEDURE(),UNSIGNED,DERIVED
UpdateFields      PROCEDURE(),DERIVED
  END

QueryFormClass CLASS(QueryClass),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Win             &QueryFormVisual,PRIVATE
Init            PROCEDURE(QueryFormVisual Q)   !,EXTENDS
Init            PROCEDURE(QueryFormVisual Q, INIClass INIMgr, STRING Family, ErrorClass E)   !,EXTENDS
Kill            PROCEDURE,DERIVED
  END

QEditEntryClass CLASS(EditEntryClass),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
SetAlerts        PROCEDURE,DERIVED
                END


QueryListVisual CLASS(QueryVisual),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
QFC               &QueryListClass
Vals              &ValueList,PRIVATE
Flds              &StringList,PRIVATE
Ops               &StringList,PRIVATE
OpsEIP            &EditDropListClass,PROTECTED
FldsEIP           &EditDropListClass,PROTECTED
ValueEIP          &EditEntryClass,PROTECTED
Init              PROCEDURE,BYTE,DERIVED,PROC
Kill              PROCEDURE,PROC,BYTE,DERIVED    ! Level:Notify means dead already
SetAlerts         PROCEDURE,DERIVED
TakeAccepted      PROCEDURE,DERIVED,BYTE,PROC
TakeCompleted     PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent    PROCEDURE,DERIVED,BYTE,PROC
ResetFromQuery    PROCEDURE,DERIVED
Type              PROCEDURE(),UNSIGNED,DERIVED
UpdateFields      PROCEDURE(),DERIVED
UpdateControl     PROCEDURE(STRING FieldName)
  END

QueryListClass CLASS(QueryClass),TYPE,MODULE('ABQUERY.CLW'),LINK('ABQUERY.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Win             &QueryListVisual,PRIVATE
Init            PROCEDURE(QueryListVisual Q)   !,EXTENDS
Init            PROCEDURE(QueryListVisual Q,INIClass INIMgr, STRING Family, ErrorClass E)   !,EXTENDS
Kill            PROCEDURE,DERIVED
  END

  ITEMIZE(1000),PRE(FEQ)
FirstControl        EQUATE
OK                  EQUATE(FEQ:FirstControl)
Cancel              EQUATE
Clear               EQUATE
Insert              EQUATE
Change              EQUATE
Delete              EQUATE
ListBox             EQUATE
SheetControl        EQUATE
ControlTab          EQUATE
SaveListbox         EQUATE
SaveQueryButton     EQUATE
DeleteQueryButton   EQUATE
RestoreQueryButton  EQUATE
QueryNamePrompt     EQUATE
QueryNameField      EQUATE
SaveRestoreTab      EQUATE
LastControl         EQUATE
StartControl        EQUATE
  END

_EndOfInclude_





