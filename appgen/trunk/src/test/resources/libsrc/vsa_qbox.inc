!ABCIncludeFile

  OMIT('_EndOfInclude_',_vsQueueListBoxPresent_)
_vsQueueListBoxPresent_ EQUATE(1)

QBoxClass CLASS,MODULE('VSA_QBOX.CLW'),TYPE,LINK('VSA_QBOX.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)

Q                         &QUEUE,PRIVATE
ListFEQ                   LONG,PRIVATE
LastLeftClick             REAL
LastMouseX                LONG
LastMouseY                LONG
!Choice                   LONG

Init                      PROCEDURE(QUEUE pQueue,LONG pFEQ)
!UpdateChoice             PROCEDURE
Update                    PROCEDURE
UpdatePosition            PROCEDURE(LONG pNewChoice)
ScrollUp                  PROCEDURE
ScrollDown                PROCEDURE
PageUp                    PROCEDURE
PageDown                  PROCEDURE
Drag                      PROCEDURE(LONG pPos)
TakeAccepted              PROCEDURE(LONG pEnterMode=0)
                    END

  _EndOfInclude_
