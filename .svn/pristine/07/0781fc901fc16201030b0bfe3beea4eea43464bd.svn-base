!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaFormWizardPresent_)
_vsaFormWizardPresent_ EQUATE(1)

!tTabQ              QUEUE,TYPE
!Number                LONG
!                   END
!tHideControlQ      QUEUE,TYPE
!Feq                   LONG
!TabQ                  &tTabQ
!                   END

FormWizardClass CLASS,TYPE,MODULE('VSA_FWiz.CLW'),LINK('VSA_FWiz.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
BackFeq                 LONG,PROTECTED
NextFeq                 LONG,PROTECTED
OkFeq                   LONG,PROTECTED
CancelFeq               LONG,PROTECTED
SheetFeq                LONG,PRIVATE
CurTabFeq               LONG,PRIVATE
ImageFeq                LONG,PRIVATE        ! Feq of Wizard Image
TextBoxFeq              LONG,PRIVATE        ! Feq of TextBox
MaxTab                  LONG
MinTab                  LONG
CurTabNum               LONG
SkipHidden              BYTE,PRIVATE
CoExistOkNext           BYTE,PRIVATE
ValidateOnNext          BYTE,PRIVATE
WizardActive            BYTE,PRIVATE             ! Only be a wizard if required
EnableOkOnTab           BYTE,PRIVATE             ! What tab to enable the OK button on
!HideControlQ           &tHideControlQ

Init                    PROCEDURE(LONG pSheetFeq,LONG pBackFeq,LONG pNextFeq,LONG pOKFeq,LONG pCancelFeq,BYTE pSkipHidden,BYTE pCoExistOkNext,BYTE pValidateOnNext,LONG Request=1)
InitMultiUseForm        PROCEDURE(LONG ImageFEQ=0,LONG TextBoxFEQ=0)
!HideControl            PROCEDURE(LONG pFeq,LONG pTabNumber)
NextControl             PROCEDURE(),LONG
ShrinkSheet             PROCEDURE(LONG pShrinkBy=14)
TakeAccepted            PROCEDURE,VIRTUAL
TakeNewSelection        PROCEDURE,VIRTUAL
TakeBack                PROCEDURE
TakeNext                PROCEDURE
TakeBackEmbed           PROCEDURE,VIRTUAL
TakeNextEmbed           PROCEDURE,VIRTUAL
Validate                PROCEDURE(),LONG,VIRTUAL
FindMinTab              PROCEDURE
FindMaxTab              PROCEDURE
ResetRange              PROCEDURE
ApplyRange              PROCEDURE
Kill                    PROCEDURE
                  END

_EndOfInclude_
