!ABCIncludeFile

  OMIT('_EndOfInclude_',_ToolbarPresent_)
_ToolbarPresent_ EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE

! Field equate labels for toolbar buttons
  INCLUDE ('ABTOOLBA.EQU'),ONCE

ToolbarTarget CLASS,TYPE,MODULE('ABTOOLBA.CLW'),LINK('ABTOOLBA.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Control        SIGNED
HelpButton     SIGNED
InsertButton   SIGNED
ChangeButton   SIGNED
DeleteButton   SIGNED
SelectButton   SIGNED
LocateButton   SIGNED
DisplayButtons PROCEDURE,VIRTUAL
TakeToolbar    PROCEDURE,VIRTUAL
TryTakeToolbar PROCEDURE,BYTE,VIRTUAL
TakeEvent      PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
  END

ToolbarListboxClass CLASS(ToolbarTarget),TYPE,MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
Browse         &BrowseClass
DisplayButtons PROCEDURE,VIRTUAL
TakeToolbar    PROCEDURE,VIRTUAL
TakeEvent      PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
TryTakeToolbar PROCEDURE,BYTE,VIRTUAL
  END

ToolbarFormVCRClass CLASS(ToolbarTarget),TYPE,MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
FormVCR        &FormVCRClass
DisplayButtons PROCEDURE,VIRTUAL
TakeToolbar    PROCEDURE,VIRTUAL
TakeEvent      PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
TryTakeToolbar PROCEDURE,BYTE,VIRTUAL
  END

ToolbarReltreeClass CLASS(ToolbarTarget),TYPE,MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
DisplayButtons PROCEDURE,VIRTUAL
TakeToolbar    PROCEDURE,VIRTUAL
  END

ToolbarUpdateClass  CLASS(ToolbarTarget),TYPE,MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
Request        BYTE
History        BYTE
DisplayButtons PROCEDURE,VIRTUAL
TakeToolbar    PROCEDURE,VIRTUAL
TakeEvent      PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
TryTakeToolbar PROCEDURE,BYTE,VIRTUAL
  END


ToolbarClass CLASS,TYPE,MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
List            &ToolbarTargetQueue,PRIVATE
AddTarget       PROCEDURE(ToolbarTarget T,SIGNED Identifier)
DisplayButtons  PROCEDURE,VIRTUAL
Init            PROCEDURE   !,EXTENDS
Kill            PROCEDURE,VIRTUAL
SetTarget       PROCEDURE(SIGNED Identifier=0)    ! => zero means try to guess who has toolbar
TakeEvent       PROCEDURE(<*LONG VCR>,WindowManager WM),VIRTUAL
  END

BrowseToolbarClass    CLASS,TYPE,IMPLEMENTS(WindowComponent),MODULE('ABTOOLBA.CLW'),DLL(_ABCDllMode_)
Init                    PROCEDURE(WindowManager Window, BrowseClass Browse)
InitMisc                PROCEDURE(SIGNED History, SIGNED Help)
InitBrowse              PROCEDURE(SIGNED Insert, SIGNED Change, SIGNED Delete, SIGNED Select)
InitVCR                 PROCEDURE(SIGNED Top, SIGNED Bottom, SIGNED PageUp, SIGNED PageDown, SIGNED Up, SIGNED Down, SIGNED Locate)
ResetFromBrowse         PROCEDURE,VIRTUAL
TakeEvent               PROCEDURE,BYTE,VIRTUAL

ResetButton             PROCEDURE(SIGNED ToolButton, SIGNED BrowseButton),protected

Browse                  &BrowseClass,PROTECTED
Window                  &WindowManager,PROTECTED
Button                  SIGNED,DIM(Toolbar:Last+1-Toolbar:First),PROTECTED
                      END
_EndOfInclude_
