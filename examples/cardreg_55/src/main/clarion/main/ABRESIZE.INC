! Declarations of Resize Classes and Types

!ABCIncludeFile

    OMIT('_EndOfInclude_',_ResizePresent_)
_ResizePresent_               EQUATE(1)

!Resize strategies
Resize:Resize                 EQUATE(00000000b)      !rescale height & width
Resize:LockWidth              EQUATE(00000001b)      !locks width
Resize:LockHeight             EQUATE(00000010b)      !locks height
Resize:LockSize               EQUATE(00000011b)      !locks height & width
Resize:ConstantRight          EQUATE(00000100b)      !locks right edge, moves left
Resize:ConstantBottom         EQUATE(00001000b)      !locks bottom edge, moves top
Resize:ConstantSize           EQUATE(00001100b)      !locks bottom & right edge
Resize:ConstantRightCenter    EQUATE(00010000b)      !locks right edge, moves left
Resize:ConstantBottomCenter   EQUATE(00100000b)      !locks right edge, moves left

!Reposition Strategies - Horizontal position
Resize:Reposition             EQUATE(0000h)      !rescale X & Y
Resize:LockXPos               EQUATE(0001h)      !locks left edge (absolute)
Resize:FixRight               EQUATE(0002h)      !fixes right edge (relative)
Resize:FixLeft                EQUATE(0003h)      !fixes left edge (relative)
Resize:FixXCenter             EQUATE(0004h)      !fixes horizontal center (relative)
Resize:FixNearestX            EQUATE(0005h)      !FixRight or FixLeft

!Reposition Strategies - Vertical position
Resize:LockYPos               EQUATE(0100h)      !locks top edge (absolute)
Resize:FixBottom              EQUATE(0200h)      !fixes bottom edge (relative)
Resize:FixTop                 EQUATE(0300h)      !fixes top edge (relative)
Resize:FixYCenter             EQUATE(0400h)      !fixes vertical center (relative)
Resize:FixNearestY            EQUATE(0500h)      !FixTop or FixBottom

Resize:LockPosition           EQUATE(0101h)      !locks X and Y position

Resize:SetMinSize             EQUATE(1)          !Passed to Init(), locks minimum size of window to design size
Resize:SetMaxSize             EQUATE(1)          !Passes to Init(), locks maximum size of window to design size

!Overall Strategies for the entire window
  ITEMIZE(0),PRE(AppStrategy)
Resize    EQUATE                                   !Rescale all proportionally
Spread    EQUATE                                   !Resize surface controls, move others
Surface   EQUATE                                   !Max surface controls, move others
NoResize  EQUATE                                   !Does not resize any controls
  END

PositionGroup                 GROUP,TYPE         !Control coordinates
XPos                            SIGNED           !Horizontal coordinate
YPos                            SIGNED           !Vertical coordinate
Width                           UNSIGNED         !Width
Height                          UNSIGNED         !Height
                              END

WindowPositionGroup           GROUP(PositionGroup),TYPE
Maximized                       BYTE
Iconized                        BYTE
                              END

ControlQueue                  QUEUE,TYPE         !Info for all the window controls
ID                              SIGNED           !Control number
Type                            UNSIGNED         !Control type
HasChildren                     BYTE             !Set true if this control has children
PositionalStrategy              USHORT           !strategy for 'moving' control
ResizeStrategy                  USHORT           !strategy for sizing control
Pos                             LIKE(PositionGroup) !Control coordinates
ParentID                        SIGNED           !Parent's control number
                              END

ResizeQueue                   QUEUE,TYPE
Priority                        LONG
ControlID                       SIGNED
Type                            UNSIGNED
Before                          LIKE(PositionGroup)
After                           LIKE(PositionGroup)
                              END


!--------------------------------------------------

WindowResizeClass             CLASS,TYPE,MODULE('ABRESIZE.CLW'),LINK('ABRESIZE.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AppStrategy                     BYTE,PRIVATE
AutoTransparent                 BYTE
OrigWin                         LIKE(WindowPositionGroup),PRIVATE
ControlQueue                    &ControlQueue,PRIVATE
DeferMoves                      BYTE
PreviousWin                     LIKE(PositionGroup),PRIVATE
ResizeCalled                    BYTE(False),PRIVATE
ResizeList                      &ResizeQueue,PRIVATE

GetParentControl                PROCEDURE(SIGNED Control),SIGNED,VIRTUAL
GetPositionStrategy             PROCEDURE(SHORT ControlType,<BYTE AppStrategy>),USHORT
GetResizeStrategy               PROCEDURE(SHORT ControlType,<BYTE AppStrategy>),USHORT
GetOrigPos                      PROCEDURE(SIGNED Control,*PositionGroup PG),BYTE,PROC
GetCurrentPos                   PROCEDURE(SIGNED Control,*PositionGroup PG),BYTE,PROC
Init                            PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)   !,EXTENDS
Kill                            PROCEDURE
RemoveControl                   PROCEDURE(SIGNED Control)
Reset                           PROCEDURE,VIRTUAL
Resize                          PROCEDURE,BYTE,VIRTUAL,PROC
Resize                          PROCEDURE(SIGNED Control),BYTE,VIRTUAL,PROC
ResizeChildren                  PROCEDURE(SIGNED ParentId,PositionGroup ParentOrigPos,PositionGroup ParentCurrentPos),PROTECTED
RestoreWindow                   PROCEDURE,VIRTUAL
SetParentControl                PROCEDURE(SIGNED Control,SIGNED ParentFeq=0)
SetParentDefaults               PROCEDURE,VIRTUAL
SetPosition                     PROCEDURE(SIGNED Control,PositionGroup ParentOrigPos,PositionGroup ParentNewPos,PositionGroup OrigPos,PositionGroup NewPos),VIRTUAL
SetStrategy                     PROCEDURE(SIGNED Source,SIGNED Destination)
SetStrategy                     PROCEDURE(SIGNED Control=0,USHORT PositionStrategy,USHORT ResizeStrategy)
TakeResize                      PROCEDURE,BYTE,PRIVATE
                              END

!--------------------------------------------------

_EndOfInclude_
