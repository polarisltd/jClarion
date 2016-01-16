!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaReqFldPresent_)
_vsaReqFldPresent_ EQUATE(1)

ReqFldQ             QUEUE,TYPE
FEQ                   LONG
Prompt                STRING(80)
Msg                   STRING(80)
Tip                   STRING(80)
FldName               STRING(40)
!UseField             &ANY
                    END

ReqFldTextQ         QUEUE,TYPE              ! Override standard text
FEQ                   LONG
Title                 STRING(255)
Text                  STRING(1024)
!UseField             &ANY
                    END

ReqFldClass      CLASS,TYPE,MODULE('VSA_REQF.CLW'),LINK('VSA_REQF.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ReqFldQ                 &ReqFldQ,PRIVATE
ReqFldTextQ             &ReqFldTextQ,PRIVATE
Title                   STRING(255)
Text                    STRING(1024)
ValidateOnFieldAccept   BYTE
WizardSheet             LONG

Init                    PROCEDURE(STRING pText,STRING pTitle,BYTE pValidate)
AddField                PROCEDURE(LONG FEQ,STRING pPrompt,STRING pMsg,STRING pTip,STRING pFldName,BYTE pAllowUpdate=1)
AddField                PROCEDURE(LONG FEQ,STRING pText,STRING pTitle)
RemoveField             PROCEDURE(LONG FEQ)
GetField                PROCEDURE(LONG FEQ),LONG,PRIVATE
!SetUseField            PROCEDURE(LONG FEQ,*? pUseField)
Incomplete              PROCEDURE(LONG VisibleOnly=0),LONG
RegisterWizard          PROCEDURE(LONG FEQ)
ThrowError              PROCEDURE(),PRIVATE
TakeSelected            PROCEDURE()
TakeAccepted            PROCEDURE()
Kill                    PROCEDURE
                  END

_EndOfInclude_
