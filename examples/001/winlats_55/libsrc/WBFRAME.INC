!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICFramePresent_)
_ICFramePresent_ EQUATE(1)

  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('WBSERVER.INC'),ONCE

!- Frame management ---------------------------------------------------------

CREATEBUTTON:Disable EQUATE(1)
CREATEBUTTON:Hide    EQUATE(2)

REPLY:NONE           EQUATE(0)
REPLY:CYCLE          EQUATE(1)
REPLY:BREAK          EQUATE(2)

Global:AnonBase      EQUATE(-5000)

WbFrameClass           CLASS,TYPE,MODULE('WBFRAME.CLW'),LINK('WBFRAME',_WebAbcLinkMode_),DLL(_WebAbcDllMode_)
CopyControlsToWindow      PROCEDURE(BYTE MergeMenu, BYTE MergeTool),VIRTUAL
CopyControlToWindow       PROCEDURE(SIGNED feq),PROTECTED
Init                      PROCEDURE()   !,EXTENDS
GetMenubarFeq             PROCEDURE,SIGNED
GetToolbarFeq             PROCEDURE,SIGNED
TakeEvent                 PROCEDURE,SIGNED,VIRTUAL,PROC

AfterCopy                 PROCEDURE,PROTECTED!,FINAL
BeforeCopy                PROCEDURE,PROTECTED!,FINAL

FrameWindow               &WINDOW
MenubarFeq                SIGNED
ToolbarFeq                SIGNED
FrameMenubarFeq           SIGNED
FrameToolbarFeq           SIGNED
                        END

  MAP
    MODULE('WBFRAME')
GetWebActiveFrame PROCEDURE,*WbFrameClass,NAME('WbFrame$GetActiveFrame')
SetWebActiveFrame PROCEDURE(<*WbFrameClass frame>),NAME('WBFRAME$SetActiveFrame')
    END
  END

  _EndOfInclude_
