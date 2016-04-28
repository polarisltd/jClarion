!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_RulesManagerPresente_)
_RulesManagerPresente_ EQUATE(1)

    INCLUDE('KEYCODES.CLW'),ONCE

RuleAction:None     EQUATE(0)
RuleAction:Hide     EQUATE(1)
RuleAction:UnHide   EQUATE(2)
RuleAction:Disable  EQUATE(3)
RuleAction:Enable   EQUATE(4)

qBrokenRules    QUEUE,TYPE
BrokenRuleInstance  &Rule
                END

qRulesCollection    QUEUE,TYPE
RM                  &RulesCollection
                END

qRuleControls  QUEUE,TYPE
Control             UNSIGNED
AllRules            BYTE
Action              BYTE
RulesToHide         &qBrokenRules
RulesToDisable      &qBrokenRules
RulesToUnHide       &qBrokenRules
RulesToEnable       &qBrokenRules
                END
qRulesControls  QUEUE,TYPE
Control             UNSIGNED
AllRules            BYTE
Action              BYTE
RulesToHide         &qRulesCollection
RulesToDisable      &qRulesCollection
RulesToUnHide       &qRulesCollection
RulesToEnable       &qRulesCollection
                END

Rule            CLASS,TYPE,MODULE('abRule.CLW'),LINK('abRule.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Name                    STRING(20),PRIVATE
Expression              STRING(500),PRIVATE
ControlNum              LONG,PRIVATE                        ! the relevant control that is invalid
ErrorIndicator          LONG,PRIVATE                        ! the CREATEd control that makes the errors
Description             STRING(255),PRIVATE                 ! the Message displayed when clicking the error indicator
ErrorImage              STRING(255),PRIVATE                 ! the icon used for the error indicator
IsBroken                BYTE,PRIVATE                ! record or most recent evaluation of error
OffsetRight             LONG,PRIVATE                ! distance error-indicator is from right hand edge of associated control
GlobalRule              &LONG                       ! GlobalRule stores the address of this rule

GetName                 PROCEDURE(),STRING
SetName                 PROCEDURE(STRING Value)

GetExpression           PROCEDURE(),STRING
SetExpression           PROCEDURE(STRING Value)

GetControlNum           PROCEDURE(),STRING
SetControlNum           PROCEDURE(LONG ControlNum)

GetDescription          PROCEDURE(),STRING
SetDescription          PROCEDURE(STRING Value)

GetErrorIndicator       PROCEDURE(),LONG
SetErrorIndicator       PROCEDURE(LONG Value)

GetErrorImage           PROCEDURE(),STRING
SeterrorImage           PROCEDURE(STRING Value)

GetIsBroken             PROCEDURE(),LONG
SetIsBroken             PROCEDURE(LONG Value)

GetOffsetRight          PROCEDURE(),LONG
SetOffsetRight          PROCEDURE(LONG Value)

ResetGlobalRule         PROCEDURE
SetGlobalRule           PROCEDURE

RuleIsBroken            PROCEDURE(BYTE DisplayIndicator),BYTE
SetIndicator            PROCEDURE(LONG Err)
                END
RulesCollection     CLASS,TYPE,MODULE('abRule.CLW'),LINK('abRule.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Controls                &qRuleControls,PRIVATE
BrokenRuleQueue         &qBrokenRules,PRIVATE
BrokenRuleControl       SHORT
ChangeControlsStatus    BYTE,PRIVATE
ErrorImage              STRING(255),PRIVATE
Description             STRING(255),PRIVATE
EnumHeaderIcon          STRING(255),PRIVATE
EnumBrokenRuleIcon      STRING(255),PRIVATE
EnumValidRuleIcon       STRING(255),PRIVATE
Supervisor              &RulesManager,PRIVATE
GetDescription          PROCEDURE(),STRING
SetDescription          PROCEDURE(STRING Value)
GetErrorImage           PROCEDURE(),STRING
SetErrorImage           PROCEDURE(STRING Value)
Construct               PROCEDURE
Destruct                PROCEDURE
RuleCount               PROCEDURE,LONG
BrokenRuleCount         PROCEDURE,LONG
AddRule                 PROCEDURE(STRING RuleName,STRING RuleDescription, STRING RuleExpression,<LONG ControlNum>,LONG OSR=3)
AddControl              PROCEDURE(UNSIGNED pControlFeq,BYTE pAction,BYTE pToAllRules=1) ! Add all rules to act over this control if pToAllRules else only to the actual rule only
AddControlToRule        PROCEDURE(STRING RuleName,UNSIGNED pControlFeq,BYTE pAction)
CheckRule               PROCEDURE(STRING RuleName,<BYTE DisplayIndicator>),BYTE,PROC,VIRTUAL
CheckAllRules           PROCEDURE(<BYTE DisplayIndicator>),LONG,PROC,VIRTUAL
Item                    PROCEDURE(STRING Value),LONG
TakeAccepted            PROCEDURE(LONG Control),VIRTUAL,BYTE,PROC
SetEnumerateIcons       PROCEDURE(STRING pHeaderIcon,STRING pValidRuleIcon,STRING pBrokenRuleIcon)
EnumerateBrokenRules    PROCEDURE(STRING Header,BYTE pOnlyBroken=1),LONG,PROC
SetControlsStatus       PROCEDURE(BYTE pAction=0),VIRTUAL
SetControlsStatus       PROCEDURE(UNSIGNED pControlFeq,BYTE pAction=0),VIRTUAL
NeedChangeControlStatus PROCEDURE(UNSIGNED pControlFeq,BYTE pAction,*BYTE pActionExist),BYTE,VIRTUAL
SetChangeControls       PROCEDURE(BYTE pStatus)
GetChangeControls       PROCEDURE(),BYTE
                END
RulesManager    CLASS,TYPE,MODULE('abRule.CLW'),LINK('abRule.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Controls                &qRulesControls,PRIVATE
Rules                   &qRulesCollection,PRIVATE
ChangeControlsStatus    BYTE,PRIVATE
EnumHeaderIcon          STRING(255),PRIVATE
EnumValidRuleIcon       STRING(255),PRIVATE
EnumBrokenRuleIcon      STRING(255),PRIVATE
Construct               PROCEDURE
Destruct                PROCEDURE
RulesManagerCount       PROCEDURE,LONG
RulesCount              PROCEDURE,LONG
BrokenRulesCount        PROCEDURE,LONG
BrokenRuleControl       SHORT
AddRulesCollection          PROCEDURE(RulesCollection pR)
CheckAllRules           PROCEDURE(<BYTE DisplayIndicator>),LONG,PROC,VIRTUAL
TakeAccepted            PROCEDURE(LONG Control),VIRTUAL
SetEnumerateIcons       PROCEDURE(STRING pHeaderIcon,STRING pValidRuleIcon,STRING pBrokenRuleIcon)
EnumerateBrokenRules    PROCEDURE(STRING Header,BYTE pOnlyBroken=1),LONG,PROC
AddControl              PROCEDURE(UNSIGNED pControlFeq,BYTE pAction) ! Add all rules to act over this control
SetControlsStatus       PROCEDURE(),VIRTUAL
SetChangeControls       PROCEDURE(BYTE pStatus)
GetChangeControls       PROCEDURE(),BYTE
SetGlobalRuleReferences PROCEDURE(*LONG Ref)
                END

 _EndOfInclude_
