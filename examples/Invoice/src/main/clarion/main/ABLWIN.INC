                                             !ABCIncludeFile(ABL)

OMIT('_EndOfInclude_',_AbcHtmlWindowPresent_)
_AbcHtmlWindowPresent_ EQUATE(1)

  INCLUDE ('LAYBUILD.INT'),ONCE
  INCLUDE ('ABLWMAN.INT'),ONCE
  INCLUDE ('ABWINDOW.INC'),ONCE
  INCLUDE ('ABLPROP.INT'),ONCE

WbWindowBaseClass      CLASS,IMPLEMENTS(IPageCreator),IMPLEMENTS(WindowComponent),IMPLEMENTS(IMapFeqToControl),TYPE,MODULE('ABLWIN.CLW'),DLL(_WebCoreDllMode_),LINK('ABLWIN.CLW',_WebCoreLinkMode_)
AddControl                PROCEDURE(IControlToHtml Properties)!,FINAL
AddOwnedControl           PROCEDURE(IControlToHtml Properties)!,FINAL
GenerateHTML              PROCEDURE(STRING Filename),VIRTUAL
GetControl                PROCEDURE(STRING Name),*IControlToHtml !,FINAL
GetHasControl             PROCEDURE(WebControlId Id),BOOL !,FINAL
Init                      PROCEDURE   !,EXTENDS
InitialiseDefaults        PROCEDURE,VIRTUAL
Kill                      PROCEDURE,VIRTUAL
MapToIControl             PROCEDURE(WebControlId From),*IControlToHtml
Reset                     PROCEDURE
ResetFromWindow           PROCEDURE,VIRTUAL
ResetVisibility           PROCEDURE,VIRTUAL
SetFormatOptions          PROCEDURE(SIGNED dx, SIGNED dy, SIGNED d2x, SIGNED d2y)
SetParentDefaults         PROCEDURE
TakeEvent                 PROCEDURE,BYTE,PROC,VIRTUAL

AddToContainers           PROCEDURE,PRIVATE
AddCurrentToContainer     PROCEDURE,PROTECTED
ResetVisibility           PROCEDURE(WebControlId root, SkeletonElementId ParentId),SkeletonElementId,PROC,PRIVATE
SetControlParentDefaults  PROCEDURE(WebControlId Id),PROTECTED

Controls                  &ControlMapQueue
Builder                   &ISkeletonPageBuilder
NeedToSync                BOOL,PRIVATE
SkeletonRoot              SkeletonElementId
RootId                    WebControlId,PROTECTED
UnknownId                 WebControlId,PROTECTED
                        END

ControlMapQueue         QUEUE,TYPE
CId                       WebControlId
ContainerNotified         BOOL
Control                   &IControlToHtml
Name                      CSTRING(64)
                        END

PositionQueue           QUEUE,TYPE
cid                       WebControlId
Control                   &IControlToHtml
x                         SIGNED
y                         SIGNED
w                         SIGNED
h                         SIGNED
                        END

_EndOfInclude_
