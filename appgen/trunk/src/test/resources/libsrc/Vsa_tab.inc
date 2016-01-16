!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaTabPresent_)
_vsaTabPresent_ EQUATE(1)

ColourTabQ          QUEUE,TYPE
FEQ                   LONG
ParentFEQ             LONG
GrandParentFEQ        LONG
                    END

ColourTabClass   CLASS,TYPE,MODULE('VSA_TAB.CLW'),LINK('VSA_TAB.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
TabQ                    &ColourTabQ,PRIVATE
ChildQ                  &ColourTabQ,PRIVATE
SelTabCol               LONG,PRIVATE
SelTextCol              LONG,PRIVATE
UnSelTabCol             LONG,PRIVATE
UnSelTextCol            LONG,PRIVATE
BoldSelected            LONG,PRIVATE
NoWizard                LONG,PRIVATE
InclChild               LONG,PRIVATE

Init                    PROCEDURE(LONG pSelTabCol,LONG pSelTextCol,LONG pBold,LONG pUnselTabCol,LONG pUnselTextCol,LONG pWizard=0,LONG pInclChild=0)
ColourTabs              PROCEDURE
ColourSelectedControl   PROCEDURE(LONG pFEQ),PRIVATE
ColourUnselectedControl PROCEDURE(LONG pFEQ),PRIVATE
Kill                    PROCEDURE
                  END

_EndOfInclude_
