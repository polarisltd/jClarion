  MEMBER

  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('WBFRAME.INC'),ONCE
  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

  MAP
    MODULE('WSL')
WSLFIELDNAME     PROCEDURE(SIGNED Feq),*CSTRING,NAME('Cla$FIELDNAME')
    END
    Anonymous(SIGNED Feq),BOOL
    SetPseudoFeqs(*SIGNED ToolbarFeq, *SIGNED MenubarFeq)
  END

FEQ:ToolbarDefault   EQUATE(32640)
FEQ:MenubarDefault   EQUATE(32641)

WebActiveFrame       &WbFrameClass
DummyFrame           WbFrameClass

!- Frame Management ----------------------------------------------------------

WbFrameClass.CopyControlsToWindow     PROCEDURE(BYTE MergeMenu, BYTE MergeTool)

  CODE


WbFrameClass.TakeEvent                PROCEDURE

  CODE
  RETURN REPLY:NONE


WbFrameClass.AfterCopy         PROCEDURE
  CODE
  SELF.ToolbarFeq = 0
  SELF.MenubarFeq = 0

WbFrameClass.BeforeCopy         PROCEDURE
  CODE
  SetPseudoFeqs(SELF.ToolbarFeq, SELF.MenubarFeq)

WbFrameClass.CopyControlToWindow      PROCEDURE(SIGNED Feq)
ThisParent           SIGNED,AUTO
inToolbar            BOOL,AUTO
  CODE
  ThisParent = SELF.FrameWindow $ Feq{PROP:parent}

  ! Does the parent control exist in this window?
  IF (ThisParent{PROP:type} = '')
    inToolbar = SELF.FrameWindow $ Feq{PROP:intoolbar}
    IF (inToolbar)
      IF (SELF.ToolbarFeq)
        ThisParent = SELF.ToolbarFeq
      ELSE
        SELF.ToolbarFEQ = CREATE(ThisParent, CREATE:toolbar, 0)
        UNHIDE(SELF.ToolbarFEQ)
      END
    ELSE
      IF (SELF.MenubarFeq)
        ThisParent = SELF.MenubarFeq
      ELSE
        SELF.MenubarFEQ = CREATE(ThisParent, CREATE:menubar, 0)
        UNHIDE(SELF.MenubarFEQ)
      END
!      ThisParent = 0
    END
  END
  CLONE(Feq, Feq, ThisParent,,SELF.FrameWindow)


WbFrameClass.GetToolbarFeq      PROCEDURE
  CODE

  RETURN SELF.ToolbarFeq


WbFrameClass.GetMenubarFeq      PROCEDURE
  CODE

  RETURN SELF.MenubarFeq

WbFrameClass.Init               PROCEDURE
  CODE
  SetPseudoFeqs(SELF.FrameToolbarFeq, SELF.FrameMenubarFeq)

  ! If the toolbar or menubar are anonymous move them to a non-anonymous
  ! field equate range so they don't clash with controls on the sub windows.
  IF (SELF.FrameToolbarFeq AND Anonymous(SELF.FrameToolbarFeq))
    SELF.FrameToolbarFeq{PROP:feq} = FEQ:ToolbarDefault
    SELF.FrameToolbarFeq = FEQ:ToolbarDefault
  END
  IF (SELF.FrameMenubarFeq AND Anonymous(SELF.FrameMenubarFeq))
    SELF.FrameMenubarFeq{PROP:feq} = FEQ:MenubarDefault
    SELF.FrameMenubarFeq = FEQ:MenubarDefault
  END

Anonymous                      PROCEDURE(SIGNED Feq)
  CODE
  RETURN CHOOSE(WSLFIELDNAME(Feq) = '')

GetWebActiveFrame                  PROCEDURE

Result                &WbFrameClass
  CODE
  Result &= WebActiveFrame
  IF (WebActiveFrame &= NULL)
    Result &= DummyFrame
  END
  RETURN Result


SetWebActiveFrame                  PROCEDURE(<*WbFrameClass NewFrame>)
  CODE
  IF (NewFrame &= NULL)
    WebActiveFrame &= DummyFrame
  ELSE
    WebActiveFrame &= NewFrame
    NewFrame.Init()
  END


SetPseudoFeqs                      PROCEDURE(*SIGNED ToolbarFeq, *SIGNED MenubarFeq)
CurFeq          SIGNED,AUTO
Type            SIGNED,AUTO

  CODE

  ToolbarFeq = 0
  MenubarFeq = 0

  CurFeq = 0{PROP:nextfield}
  LOOP WHILE (CurFeq)
    IF (CurFeq)
      Type = IC:GetControlType(CurFeq)
      CASE (Type)
      OF CREATE:TOOLBAR
        ToolbarFeq = CurFeq
      OF CREATE:Menubar
        MenubarFeq = CurFeq
      END
    END
    CurFeq = 0{PROP:nextfield, CurFeq}
  END





