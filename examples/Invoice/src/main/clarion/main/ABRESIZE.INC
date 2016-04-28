! Declarations of Resize Classes and Types

!ABCIncludeFile

    OMIT('_EndOfInclude_',_ResizePresent_)
_ResizePresent_               EQUATE(1)

 INCLUDE('ABRESIZE.EQU'),ONCE


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
ResizeChildren                  PROCEDURE(SIGNED ParentId,*PositionGroup ParentOrigPos,*PositionGroup ParentCurrentPos),PROTECTED
RestoreWindow                   PROCEDURE,VIRTUAL
SetParentControl                PROCEDURE(SIGNED Control,SIGNED ParentFeq=0)
SetParentDefaults               PROCEDURE,VIRTUAL
SetPosition                     PROCEDURE(SIGNED Control,*PositionGroup ParentOrigPos,*PositionGroup ParentNewPos,*PositionGroup OrigPos,*PositionGroup NewPos),VIRTUAL
SetStrategy                     PROCEDURE(SIGNED Source,SIGNED Destination)
SetStrategy                     PROCEDURE(SIGNED Control=0,USHORT PositionStrategy,USHORT ResizeStrategy)
TakeResize                      PROCEDURE,BYTE,PRIVATE
                              END

!--------------------------------------------------

_EndOfInclude_
