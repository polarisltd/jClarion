
!ABCIncludeFile

OMIT('_EndOfInclude_',_vsBtnIcnMgrPresent_)
_vsBtnIcnMgrPresent_ EQUATE(1)

! Equates

tBtnQ           QUEUE,TYPE
BtnText              STRING(256)
Icon                 STRING(256)
NewBtnText           STRING(256)
                   END


vsBtnIcnMgrClass              CLASS,TYPE,MODULE('VSA_BTN.CLW'),LINK('VSA_BTN.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Active                          BYTE                          ! Active
Path                            STRING(256)
BtnQ                            &tBtnQ                        ! Queue of button combinations

Init                            PROCEDURE(STRING pFilename)
SetPath                         PROCEDURE(STRING pFilename)
CopyQ                           PROCEDURE(tBtnQ pQ)
CheckButton                     PROCEDURE(LONG pFEQ,STRING pText)
CheckButtons                    PROCEDURE
Assign                          PROCEDURE(LONG pFEQ)
Kill                            PROCEDURE
                              END

_EndOfInclude_
