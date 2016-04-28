! Declarations of Resize Classes and Types

ControlPosType      GROUP,TYPE
XPos                  SIGNED
YPos                  SIGNED
Width                 UNSIGNED
Height                UNSIGNED
                    END

ControlQueueType    QUEUE,TYPE
ID                    SIGNED
Type                  UNSIGNED
PositionalStrategy    USHORT                !strategy for 'moving' control
ResizeStrategy        USHORT                !strategy for sizing control
Pos                   LIKE(ControlPosType)
                    END

!--------------------------------------------------

WindowResizeType    CLASS,TYPE,MODULE('ResCode.Clw')
OrigWin               LIKE(ControlPosType),PRIVATE
PreviousWin           LIKE(ControlPosType),PRIVATE
ControlQueue          &ControlQueueType,PRIVATE
Initialize            PROCEDURE(UNSIGNED AppStrategy=0)
Resize                PROCEDURE
Destroy               PROCEDURE
SetControlStrategy    PROCEDURE(SIGNED ControlID=0, USHORT PositionalStrategy, USHORT ResizeStrategy)
                    END

!--------------------------------------------------
