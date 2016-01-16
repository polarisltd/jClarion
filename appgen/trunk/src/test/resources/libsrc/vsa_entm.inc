!ABCIncludeFile

  OMIT('_EndOfInclude_',_vsEnterCompletesFieldPresent_)
_vsEnterCompletesFieldPresent_ EQUATE(1)

EQUATE:ECF:DoNothing          EQUATE(0)
EQUATE:ECF:ClickMouseLeft2    EQUATE(1)
EQUATE:ECF:PressDefaultButton EQUATE(2)
EQUATE:ECF:OnlyEntryFields    EQUATE(3)
EQUATE:ECF:BestGuess          EQUATE(4)

!tECFOverrideQ            QUEUE,TYPE
!Win                        &WINDOW
!ListFEQ                    LONG
!DefaultFEQ                 LONG
!                         END

EnterCompletesFieldClass CLASS,MODULE('VSA_ENTM.CLW'),TYPE,LINK('VSA_ENTM.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Active                    BYTE
Switchable                BYTE
HandleList                BYTE
TextLineHeight            BYTE
!OverrideQ                &tECFOverrideQ
CurFEQ                    LONG,PRIVATE !JB Enter to TabKey Control Variable
CRLF                      BYTE,PRIVATE !JB Last line of text field
Ptr                       LONG,PRIVATE !JB Location in text field

Init                      PROCEDURE(BYTE pActive,BYTE pHandleList=1,BYTE pSwitchable=1,BYTE pTextLineHeight=9)
Init                      PROCEDURE()
TakeAlert                 PROCEDURE(),LONG
TakeFieldAlert            PROCEDURE(),LONG
SetAlerts                 PROCEDURE()
SetActive                 PROCEDURE()
SetActiveOff              PROCEDURE()
!AddOverride              PROCEDURE(WINDOW pWindow,LONG pListFEQ,LONG pDefaultFEQ)
                    END

  _EndOfInclude_
