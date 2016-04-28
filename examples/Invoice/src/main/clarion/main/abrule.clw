    MEMBER
 INCLUDE('abrule.inc'),ONCE

    MAP
    END

Rule.GetName PROCEDURE
    CODE
    RETURN(SELF.Name)

Rule.SetName PROCEDURE(STRING Rulename)
    CODE
    SELF.Name = Rulename

Rule.GetExpression PROCEDURE
    CODE
    RETURN(SELF.Expression)

Rule.SetExpression PROCEDURE(STRING Expression)
    CODE
    SELF.Expression = Expression

Rule.GetControlNum PROCEDURE
    CODE
    RETURN(SELF.ControlNum)

Rule.SetControlNum PROCEDURE(LONG ControlNum)
    CODE
    SELF.ControlNum = ControlNum

Rule.GetDescription PROCEDURE
    CODE
    RETURN(SELF.Description)

Rule.SetDescription PROCEDURE(STRING RuleDescription)
    CODE
    SELF.Description = RuleDescription

Rule.GetErrorIndicator PROCEDURE
    CODE
    RETURN(SELF.ErrorIndicator)

Rule.SetErrorIndicator PROCEDURE(LONG RuleErrorIndicator)
    CODE
    SELF.ErrorIndicator = RuleErrorIndicator

Rule.GetErrorImage PROCEDURE
    CODE
    RETURN(SELF.ErrorImage)

Rule.SetErrorImage PROCEDURE(STRING RuleErrorImage)
    CODE
    SELF.ErrorImage = RuleErrorImage

Rule.GetIsBroken PROCEDURE
    CODE
    RETURN(SELF.IsBroken)

Rule.SetIsBroken PROCEDURE(LONG RuleIsBroken)
    CODE
    SELF.IsBroken = RuleIsBroken

Rule.GetOffsetRight PROCEDURE
    CODE
    RETURN(SELF.OffsetRight)

Rule.SetOffsetRight PROCEDURE(LONG OS)
    CODE
    SELF.OffsetRight = OS

Rule.ResetGlobalRule PROCEDURE
    CODE
    IF NOT SELF.GlobalRule &= NULL
      SELF.GlobalRule = 0
    END

Rule.SetGlobalRule PROCEDURE
    CODE
    IF NOT SELF.GlobalRule &= NULL
      SELF.GlobalRule = ADDRESS(SELF)
    END

Rule.RuleIsBroken PROCEDURE(Byte DisplayIndicator)
RetVal              LONG
!IF the evaluate RETURNs a FALSE then the rule is broken!
EvaluateResults byte
    CODE
    SELF.SetGlobalRule
    EvaluateResults = EVALUATE(SELF.Expression)
    IF INLIST(ERRORCODE(),800,810,1011)         ! Check only errors attributable to EVALUATE
       RetVal = ERRORCODE() 
       STOP('Evaluate Syntax error: Rule.RuleIsBroken PROCEDURE tried to evaluate the expression "' & Clip(SELF.Expression) & '" and it caused error:' & ERROR()&'('&ERRORCODE()&')')
    ELSE
       RetVal = CHOOSE(EvaluateResults = 0,1,0)
       SELF.SetIsBroken(RetVal)        
       IF DisplayIndicator
          SELF.SetIndicator(RetVal)        
       END
    END
    SELF.ResetGlobalRule
    RETURN(RetVal)

Rule.SetIndicator PROCEDURE(LONG Err)
ErrInd LONG

    CODE
    ErrInd = SELF.ControlNum + 1000
    IF ErrInd
       HIDE(ErrInd)
       DESTROY(ErrInd)
    END 
    IF Err
        CREATE(ErrInd,CREATE:BUTTON,SELF.ControlNum{Prop:Parent},)
        ErrInd{Prop:Icon}   = LEFT(CLIP(SELF.ErrorImage))
        ErrInd{Prop:Xpos}   = SELF.ControlNum{Prop:Xpos} + SELF.ControlNum{Prop:Width} + SELF.OffsetRight
        ErrInd{Prop:Ypos}   = SELF.ControlNum{Prop:Ypos}
        ErrInd{Prop:Height} = SELF.ControlNum{Prop:Height}
        ErrInd{Prop:Width}  = ErrInd{Prop:Height}
        ErrInd{Prop:Flat}   = True
        ErrInd{Prop:Skip}   = True
        ErrInd{Prop:Tip}    = SELF.Description
        UNHIDE(ErrInd)
    END
!*************************************************
RulesCollection.Construct Procedure
    CODE
    SELF.BrokenRuleQueue &= NEW(qBrokenRules)
    SELF.Controls        &= NEW(qRuleControls)
    SELF.ChangeControlsStatus = True
    SELF.Supervisor      &= NULL

RulesCollection.Destruct Procedure
Counter  LONG
Counter2 LONG
    CODE
    LOOP Counter = 1 TO RECORDS(SELF.BrokenRuleQueue)
      GET(SELF.BrokenRuleQueue,Counter)
      DISPOSE(SELF.BrokenRuleQueue.BrokenRuleInstance)
    END
    DISPOSE(SELF.BrokenRuleQueue)
    LOOP Counter = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls,Counter)
      FREE(SELF.Controls.RulesToHide)
      DISPOSE(SELF.Controls.RulesToHide)
      FREE(SELF.Controls.RulesToDisable)
      DISPOSE(SELF.Controls.RulesToDisable)
      FREE(SELF.Controls.RulesToUnHide)
      DISPOSE(SELF.Controls.RulesToUnHide)
      FREE(SELF.Controls.RulesToEnable)
      DISPOSE(SELF.Controls.RulesToEnable)
    END
    FREE(SELF.Controls)
    DISPOSE(SELF.Controls)

RulesCollection.AddRule Procedure(STRING RuleName,STRING RuleDescription,STRING RuleExpression,<LONG ControlNum>,LONG OSR=3)
Counter LONG
Found       BYTE    
    CODE
    SELF.BrokenRuleQueue.BrokenRuleInstance &= NEW(Rule)
    SELF.BrokenRuleQueue.BrokenRuleInstance.SetName(RuleName)
    SELF.BrokenRuleQueue.BrokenRuleInstance.SetExpression(RuleExpression)           !The rule expression must RETURN true, if false then the rule is broken 
    SELF.BrokenRuleQueue.BrokenRuleInstance.SetDescription(RuleDescription)
    SELF.BrokenRuleQueue.BrokenRuleInstance.SetErrorImage(SELF.ErrorImage)
    IF ~OMITTED(5)
       SELF.BrokenRuleQueue.BrokenRuleInstance.SetControlNum(ControlNum)
       SELF.BrokenRuleQueue.BrokenRuleInstance.SetErrorIndicator(ControlNum+1000)
       SELF.BrokenRuleQueue.BrokenRuleInstance.SetOffsetRight(OSR)
    END
    ADD(SELF.BrokenRuleQueue)

RulesCollection.AddControl              PROCEDURE(UNSIGNED pControlFeq,BYTE pAction,BYTE pToAllRules=1)
lFound  BYTE
lIndex  LONG
    CODE
        lFound = False
        LOOP lIndex=1 TO RECORDS(SELF.Controls)
             GET(SELF.Controls,lIndex)
             IF SELF.Controls.Control = pControlFeq 
                lFound = True
                BREAK
             END
        END
        IF lFound = False 
           CLEAR(SELF.Controls)
           SELF.Controls.Control         = pControlFeq
           SELF.Controls.RulesToHide    &= NEW(qBrokenRules)
           SELF.Controls.RulesToDisable &= NEW(qBrokenRules)
           SELF.Controls.RulesToUnHide  &= NEW(qBrokenRules)
           SELF.Controls.RulesToEnable  &= NEW(qBrokenRules)
           ADD(SELF.Controls)
        END
        IF pToAllRules 
           SELF.Controls.AllRules = True
           SELF.Controls.Action   = pAction
           PUT(SELF.Controls)
        ELSE
           CASE pAction
           OF RuleAction:Hide
              SELF.Controls.RulesToHide.BrokenRuleInstance &= SELF.BrokenRuleQueue.BrokenRuleInstance
              ADD(SELF.Controls.RulesToHide)
           OF RuleAction:UnHide
              SELF.Controls.RulesToUnHide.BrokenRuleInstance &= SELF.BrokenRuleQueue.BrokenRuleInstance
              ADD(SELF.Controls.RulesToUnHide)
           OF RuleAction:Disable
              SELF.Controls.RulesToDisable.BrokenRuleInstance &= SELF.BrokenRuleQueue.BrokenRuleInstance
              ADD(SELF.Controls.RulesToDisable)
           OF RuleAction:Enable
              SELF.Controls.RulesToEnable.BrokenRuleInstance &= SELF.BrokenRuleQueue.BrokenRuleInstance
              ADD(SELF.Controls.RulesToEnable)
           END
        END
       
RulesCollection.AddControlToRule         PROCEDURE(STRING RuleName,UNSIGNED pControlFeq,BYTE pAction)
    CODE
        IF SELF.Item(RuleName)<>0 
           SELF.AddControl(pControlFeq,pAction,False)
        END

RulesCollection.RuleCount     Procedure
    CODE
    RETURN(RECORDS(SELF.BrokenRuleQueue))

RulesCollection.BrokenRuleCount     Procedure
LBR             &Rule 
NumberOfRules   LONG
Counter         LONG
RetVal          LONG

    CODE
    NumberOfRules = SELF.RuleCount()
    LOOP Counter = 1 TO NumberOfRules
        LBR &= SELF.Item(Counter)   !don't need to check for null with ordinal value
        IF LBR.GetIsBroken()
           Retval += 1
        END
    END
    RETURN(Retval)

RulesCollection.TakeAccepted Procedure(LONG Control)
Counter         LONG
LBR             &Rule 
NumberOfRules   LONG
Desc            STRING(255)
MoreString      CSTRING(20)
BrokenRuleCount Long
SelectControl   Long
ReturnValue     BYTE
    CODE
    IF SELF.Supervisor &= NULL
      ReturnValue = False
      NumberOfRules   = SELF.RuleCount()
      BrokenRuleCount = SELF.BrokenRuleCount()
      MoreString      = CHOOSE(BrokenRuleCount > 1, Left(Clip(BrokenRuleCount)) & ' Errors','')
      LOOP Counter = 1 TO NumberOfRules
          LBR &= SELF.Item(Counter)
          IF LBR.GetErrorIndicator() = Control
             Desc = LBR.GetDescription() 
             IF LEN(CLIP(Desc))              
                IF MESSAGE(Desc,'Error Information',ICON:ASTERISK,'Close |' & MoreString) = 2                 
                   SelectControl = SELF.EnumerateBrokenRules(SELF.GetDescription())
                   IF SelectControl
                      SELECT(SelectControl)
                   END
                END            
             END
             ReturnValue = True
             BREAK
          END
      END
    ELSE
      ReturnValue = False
      NumberOfRules   = SELF.RuleCount()
      LOOP Counter = 1 TO NumberOfRules
          LBR &= SELF.Item(Counter)
          IF LBR.GetErrorIndicator() = Control
             Desc = LBR.GetDescription() 
             IF LEN(CLIP(Desc))              
                BrokenRuleCount = SELF.Supervisor.BrokenRulesCount()
                MoreString      = CHOOSE(BrokenRuleCount > 1, Left(Clip(BrokenRuleCount)) & ' Errors','')
                IF MESSAGE(Desc,'Error Information',ICON:ASTERISK,'Close |' & MoreString) = 2
                   SelectControl = SELF.Supervisor.EnumerateBrokenRules('Broken Rules')
                   IF SelectControl
                      SELECT(SelectControl)
                   END
                END            
             END
             ReturnValue = True
             BREAK
          END
      END
    END
    RETURN ReturnValue

RulesCollection.Item     Procedure(STRING Object)
Counter         BYTE
OrdinalValue    LONG
DescriptorValue STRING(20)
Found           BYTE
    CODE

    IF Numeric(Object)
        OrdinalValue = Object
    ELSE
        DescriptorValue = Upper(Clip(Object))
    END

    Found   = FALSE
    IF OrdinalValue   
        IF OrdinalValue <= SELF.RuleCount()
            GET(SELF.BrokenRuleQueue,OrdinalValue)
            IF ~error()
               Found = TRUE
            END     
        END
    ELSE
        IF UPPER(CLIP(SELF.BrokenRuleQueue.BrokenRuleInstance.GetName())) = DescriptorValue 
           Found = TRUE
        ELSE
           LOOP Counter = 1 TO SELF.RuleCount()
               GET(SELF.BrokenRuleQueue,Counter)
               IF Upper(Clip(SELF.BrokenRuleQueue.BrokenRuleInstance.GetName())) = DescriptorValue
                   Found = TRUE
                   BREAK
               END
           END     
        END
    END
    IF Found 
        RETURN(ADDRESS(SELF.BrokenRuleQueue.BrokenRuleInstance))
    ELSE
        MESSAGE('Missing rule discovered while executing RulesCollection.Item - Rule Descriptor was not found in the Rules List: ' & Object,'Undefined rule in Rule Manager',ICON:EXCLAMATION)
        RETURN(0)
    END

RulesCollection.CheckRule Procedure(STRING RuleName,<BYTE DisplayIndicator>)
RetVal          BYTE    
LBR             &Rule 
    CODE
    LBR &= SELF.Item(RuleName)
    IF LBR &= NULL
       RetVal = 0
    ELSE
       RetVal = LBR.RuleIsBroken(DisplayIndicator)
    END

    RETURN(RetVal)
    
RulesCollection.CheckAllRules Procedure(<BYTE DisplayIndicator>)
RetVal          LONG
LBR             &Rule
Counter         LONG
Recs            LONG
lIsBroken       BYTE
    CODE
    Recs    = SELF.RuleCount()
    Retval  = 0
    LOOP Counter = 1 TO Recs
       LBR    &= SELF.Item(Counter)
       lIsBroken= LBR.RuleIsBroken(DisplayIndicator)
       RetVal +=lIsBroken
    END
    IF SELF.ChangeControlsStatus 
       SELF.SetControlsStatus()
    END
    
    RETURN(RetVal)
RulesCollection.SetControlsStatus       PROCEDURE(UNSIGNED pControlFeq,BYTE pAction=0)
lChange BYTE
lFound  BYTE
lIndex  LONG
lIndex2 LONG
lAction BYTE
lActionExist BYTE
   CODE
       IF pControlFeq=0 THEN RETURN.
       IF pAction 
          lActionExist = RuleAction:None
          lChange = SELF.NeedChangeControlStatus(pControlFeq,pAction,lActionExist)
          IF lActionExist<>pAction THEN RETURN.
          CASE pAction
          OF RuleAction:Hide
             IF lChange 
                HIDE(pControlFeq)
             ELSE
                UNHIDE(pControlFeq)
             END
          OF RuleAction:UnHide
             IF lChange 
                UNHIDE(pControlFeq)
             ELSE
                HIDE(pControlFeq)
             END
          OF RuleAction:Disable
             IF lChange 
                DISABLE(pControlFeq)
             ELSE
                ENABLE(pControlFeq)
             END
          OF RuleAction:Enable
             IF lChange 
                ENABLE(pControlFeq)
             ELSE
                DISABLE(pControlFeq)
             END
          END
       ELSE
          lChange       = False
          lActionExist  = RuleAction:None
          lAction       = RuleAction:Hide
          lChange       = SELF.NeedChangeControlStatus(pControlFeq,lAction,lActionExist)
          IF lActionExist=lAction 
             IF lChange 
                HIDE(pControlFeq)
             ELSE
                UNHIDE(pControlFeq)
             END
          END
          lChange       = False
          lActionExist  = RuleAction:None
          lAction       = RuleAction:UnHide
          lChange       = SELF.NeedChangeControlStatus(pControlFeq,lAction,lActionExist)
          IF lActionExist=lAction 
             IF lChange 
                UNHIDE(pControlFeq)
             ELSE
                HIDE(pControlFeq)
             END
          END
          lChange       = False
          lActionExist  = RuleAction:None
          lAction       = RuleAction:Disable
          lChange       = SELF.NeedChangeControlStatus(pControlFeq,lAction,lActionExist)
          IF lActionExist=lAction 
             IF lChange 
                DISABLE(pControlFeq)
             ELSE
                ENABLE(pControlFeq)
             END
          END
          lChange       = False
          lActionExist  = RuleAction:None
          lAction       = RuleAction:Enable
          lChange       = SELF.NeedChangeControlStatus(pControlFeq,lAction,lActionExist)
          IF lActionExist=lAction 
             IF lChange 
                ENABLE(pControlFeq)
             ELSE
                DISABLE(pControlFeq)
             END
          END
       END
RulesCollection.NeedChangeControlStatus    PROCEDURE(UNSIGNED pControlFeq,BYTE pAction,*BYTE pActionExist)
lChange LONG
lFound  BYTE
lIndex  LONG
lIndex2 LONG
   CODE
       pActionExist = RuleAction:None
       IF pAction = RuleAction:None 
          RETURN False
       END
       lFound = False
       IF SELF.Controls.Control = pControlFeq 
          lFound = True
       ELSE
          LOOP lIndex=1 TO RECORDS(SELF.Controls)
             GET(SELF.Controls,lIndex)
             IF ERRORCODE() THEN BREAK.
             IF SELF.Controls.Control = pControlFeq 
                lFound = True
                BREAK
             END
          END
       END
       IF NOT lFound 
          RETURN False
       ELSE
             lChange = 0 ! False
             IF SELF.Controls.AllRules = True 
                lChange = SELF.BrokenRuleCount()
                IF pAction<>SELF.Controls.Action THEN RETURN False.
                pActionExist = SELF.Controls.Action
             ELSE
                CASE pAction
                OF RuleAction:Hide
                   LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToHide)
                        GET(SELF.Controls.RulesToHide,lIndex2)
                        pActionExist = pAction
                        lChange += SELF.Controls.RulesToHide.BrokenRuleInstance.GetIsBroken()
                        IF lChange 
                           BREAK
                        END
                   END
                OF RuleAction:UnHide
                   LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToUnHide)
                        GET(SELF.Controls.RulesToUnHide,lIndex2)
                        pActionExist = pAction
                        lChange += SELF.Controls.RulesToUnHide.BrokenRuleInstance.GetIsBroken()
                        IF lChange 
                           BREAK
                        END
                   END
                OF RuleAction:Disable
                   LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToDisable)
                        GET(SELF.Controls.RulesToDisable,lIndex2)
                        pActionExist = pAction
                        lChange += SELF.Controls.RulesToDisable.BrokenRuleInstance.GetIsBroken()
                        IF lChange 
                           BREAK
                        END
                   END
                OF RuleAction:Enable
                   LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToEnable)
                        GET(SELF.Controls.RulesToEnable,lIndex2)
                        pActionExist = pAction
                        lChange = SELF.Controls.RulesToEnable.BrokenRuleInstance.GetIsBroken()
                        IF lChange 
                           BREAK
                        END
                   END
                END
             END
             IF lChange 
                RETURN True
             ELSE
                RETURN False
             END
       END
RulesCollection.SetControlsStatus       PROCEDURE(BYTE pAction=0)
lIndex  LONG
lIndex2 LONG
lChange BYTE
    CODE
        LOOP lIndex=1 TO RECORDS(SELF.Controls)
             GET(SELF.Controls,lIndex)
             IF ERRORCODE() THEN BREAK.
             SELF.SetControlsStatus(SELF.Controls.Control,pAction)
        END

RulesCollection.SetChangeControls       PROCEDURE(BYTE pStatus)
    CODE
    SELF.ChangeControlsStatus = pStatus

RulesCollection.GetChangeControls       PROCEDURE()
    CODE
    RETURN(SELF.ChangeControlsStatus)

RulesCollection.GetErrorImage Procedure
    CODE
    RETURN(SELF.ErrorImage)

RulesCollection.SetErrorImage Procedure(STRING ErrorImage)

    CODE
    SELF.ErrorImage = ErrorImage

RulesCollection.SetEnumerateIcons       PROCEDURE(STRING pHeaderIcon,STRING pValidRuleIcon,STRING pBrokenRuleIcon)
    CODE
    SELF.EnumHeaderIcon     = pHeaderIcon
    SELF.EnumValidRuleIcon  = pValidRuleIcon
    SELF.EnumBrokenRuleIcon = pBrokenRuleIcon

RulesCollection.GetDescription Procedure
    CODE
    RETURN(SELF.Description)

RulesCollection.SetDescription Procedure(STRING Description)

    CODE
    SELF.Description = Description

RulesCollection.EnumerateBrokenRules Procedure(STRING Header,BYTE pOnlyBroken=1)
qBR QUEUE
RuleDesc        STRING(255)
Rule_Icon       LONG                           !Entry's icon ID
ControlNum      LONG
             End
LBR             &Rule 
NumberOfRules   LONG
Counter         LONG
RetVal          LONG

EnumBRWindow WINDOW('Broken Rules'),AT(,,139,126),FONT('Arial',8,,FONT:regular,CHARSET:ANSI),SYSTEM,GRAY, |
         RESIZE,AUTO
       LIST,AT(0,0,,104),USE(?List:BR),FULL,VSCROLL,ALRT(MouseLeft2),VCR,FORMAT('500L(2)J'),FROM(qBR)
       BUTTON('Go To...'),AT(76,109,45,14),USE(?Button:OK)
       BUTTON('Cancel'),AT(17,109,45,14),USE(?Button:Cancel),STD(STD:Close)
     END

    CODE
    RetVal = 0
    NumberOfRules = SELF.RuleCount()
    LOOP Counter = 1 TO NumberOfRules
       LBR &= SELF.Item(Counter)   !don't need to check for null with ordinal value

       qBR.RuleDesc = LBR.GetDescription()
       qBR.ControlNum = LBR.GetControlNum()
       IF pOnlyBroken 
          IF LBR.GetIsBroken() = TRUE
             qBR.Rule_Icon = 1
             ADD(qBR)
          END
       ELSE
          IF LBR.GetIsBroken() = TRUE 
             qBR.Rule_Icon = 1
          ELSE
             qBR.Rule_Icon = 2
          END
          ADD(qBR)
       END
    END
    OPEN(EnumBRWindow)
    ?List:BR{PROP:ICONLIST,1}=CLIP(SELF.EnumBrokenRuleIcon)  !'~BRuleNO.ICO'
    ?List:BR{PROP:ICONLIST,2}=CLIP(SELF.EnumValidRuleIcon)   !'~BRuleOk.ICO'
    EnumBRWindow{Prop:Text} = CLIP(Header)
    EnumBRWindow{Prop:Icon} = CLIP(SELF.EnumHeaderIcon)      !'~BRules.ICO'
    ACCEPT
       ?Button:OK{Prop:Disable}=Choose(Choice(?List:BR) = 0)
       IF KEYCODE() = MouseLeft2 or Accepted() = ?Button:OK
        GET(qBR,CHOICE(?List:BR))   
          Retval = qBR.ControlNum
          BREAK
       END
    END
    CLOSE(EnumBRWindow)
    SELF.BrokenRuleControl = Retval
    RETURN(Retval)
!*************************************************
RulesManager.Construct Procedure
    CODE
    SELF.Rules      &= NEW(qRulesCollection)
    SELF.Controls   &= NEW(qRulesControls)
    SELF.ChangeControlsStatus = True
    

RulesManager.Destruct Procedure
Counter BYTE        
    CODE
       
    FREE(SELF.Rules)
    DISPOSE(SELF.Rules)

    LOOP Counter = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls,Counter)
      FREE(SELF.Controls.RulesToHide)
      DISPOSE(SELF.Controls.RulesToHide)
      FREE(SELF.Controls.RulesToDisable)
      DISPOSE(SELF.Controls.RulesToDisable)
      FREE(SELF.Controls.RulesToUnHide)
      DISPOSE(SELF.Controls.RulesToUnHide)
      FREE(SELF.Controls.RulesToEnable)
      DISPOSE(SELF.Controls.RulesToEnable)
    END
    FREE(SELF.Controls)
    DISPOSE(SELF.Controls)


RulesManager.SetChangeControls       PROCEDURE(BYTE pStatus)
    CODE
    SELF.ChangeControlsStatus = pStatus

RulesManager.GetChangeControls       PROCEDURE()
    CODE
    RETURN(SELF.ChangeControlsStatus)
    
RulesManager.SetControlsStatus       PROCEDURE()
lIndex1  LONG
lIndex2  LONG
lChange      LONG
lActionExist BYTE
    CODE
       LOOP lIndex1=1 TO RECORDS(SELF.Controls)
            GET(SELF.Controls,lIndex1)
            IF ERRORCODE() THEN BREAK.
            IF SELF.Controls.AllRules = True 
               lChange = False
               LOOP lIndex2=1 TO RECORDS(SELF.Rules)
                    GET(SELF.Rules,lIndex2)
                    IF ERRORCODE() THEN BREAK.
                    lChange = SELF.Rules.RM.BrokenRuleCount()
                    IF lChange THEN BREAK.
               END
               CASE SELF.Controls.Action
               OF RuleAction:Hide
                  IF lChange 
                     HIDE(SELF.Controls.Control)
                  ELSE
                     UNHIDE(SELF.Controls.Control)
                  END
               OF RuleAction:UnHide
                  IF lChange 
                     UNHIDE(SELF.Controls.Control)
                  ELSE
                     HIDE(SELF.Controls.Control)
                  END
               OF RuleAction:Disable
                  IF lChange 
                     DISABLE(SELF.Controls.Control)
                  ELSE
                     ENABLE(SELF.Controls.Control)
                  END
               OF RuleAction:Enable
                  IF lChange 
                     ENABLE(SELF.Controls.Control)
                  ELSE
                     DISABLE(SELF.Controls.Control)
                  END
               END
            ELSE
               IF RECORDS(SELF.Controls.RulesToHide) 
                  lChange = False
                  LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToHide)
                       GET(SELF.Controls.RulesToHide,lIndex2)
                       IF ERRORCODE() THEN BREAK.
                       lActionExist = RuleAction:None
                       lChange      = SELF.Controls.RulesToHide.RM.NeedChangeControlStatus(SELF.Controls.Control,RuleAction:Hide,lActionExist)
                       IF lActionExist<>RuleAction:Hide 
                          CYCLE
                       END
                       IF lChange THEN BREAK.
                  END
                  IF lChange 
                     HIDE(SELF.Controls.Control)
                  ELSE
                     UNHIDE(SELF.Controls.Control)
                  END
               END
               IF RECORDS(SELF.Controls.RulesToDisable) 
                  lChange = False
                  LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToDisable)
                       GET(SELF.Controls.RulesToDisable,lIndex2)
                       IF ERRORCODE() THEN BREAK.
                       lActionExist = RuleAction:None
                       lChange      = SELF.Controls.RulesToDisable.RM.NeedChangeControlStatus(SELF.Controls.Control,RuleAction:Disable,lActionExist)
                       IF lActionExist<>RuleAction:Disable 
                          CYCLE
                       END
                       IF lChange THEN BREAK.
                  END
                  IF lChange 
                     DISABLE(SELF.Controls.Control)
                  ELSE
                     ENABLE(SELF.Controls.Control)
                  END
               END
               IF RECORDS(SELF.Controls.RulesToUnHide) 
                  lChange = False
                  LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToUnHide)
                       GET(SELF.Controls.RulesToUnHide,lIndex2)
                       IF ERRORCODE() THEN BREAK.
                       lActionExist = RuleAction:None
                       lChange      = SELF.Controls.RulesToUnHide.RM.NeedChangeControlStatus(SELF.Controls.Control,RuleAction:UnHide,lActionExist)
                       IF lActionExist<>RuleAction:UnHide 
                          CYCLE
                       END
                       IF lChange THEN BREAK.
                  END
                  IF lChange 
                     UNHIDE(SELF.Controls.Control)
                  ELSE
                     HIDE(SELF.Controls.Control)
                  END
               END
               IF RECORDS(SELF.Controls.RulesToEnable) 
                  lChange = False
                  LOOP lIndex2=1 TO RECORDS(SELF.Controls.RulesToEnable)
                       GET(SELF.Controls.RulesToEnable,lIndex2)
                       IF ERRORCODE() THEN BREAK.
                       lActionExist = RuleAction:None
                       lChange      = SELF.Controls.RulesToEnable.RM.NeedChangeControlStatus(SELF.Controls.Control,RuleAction:Enable,lActionExist)
                       IF lActionExist<>RuleAction:Enable 
                          CYCLE
                       END
                       IF lChange THEN BREAK.
                  END
                  IF lChange 
                     Enable(SELF.Controls.Control)
                  ELSE
                     DISABLE(SELF.Controls.Control)
                  END
               END
            END
       END
RulesManager.AddRulesCollection          PROCEDURE(RulesCollection pRM)
lIndex1  LONG
lIndex2  LONG
lFound   BYTE
    CODE
    SELF.Rules.RM &= pRM
    ADD(SELF.Rules)
    ASSERT(~ERRORCODE())
    ! to avoid the double refresh and only change the status from the RulesManager
    SELF.Rules.RM.ChangeControlsStatus = False
    ! pass supervisor's address (SELF) to RulesCollection object
    SELF.Rules.RM.Supervisor &= SELF
    LOOP lIndex1=1 TO RECORDS(SELF.Rules.RM.Controls)
         GET(SELF.Rules.RM.Controls,lIndex1)
         IF ERRORCODE() THEN BREAK.
         lFound = False
         LOOP lIndex2=1 TO RECORDS(SELF.Controls)
              GET(SELF.Controls,lIndex2)
              IF ERRORCODE() THEN BREAK.
              IF SELF.Controls.Control=SELF.Rules.RM.Controls.Control 
                 lFound = True
                 BREAK
              END
         END
         IF lFound = False 
            SELF.Controls.Control        = SELF.Rules.RM.Controls.Control
            SELF.Controls.AllRules       = False
            SELF.Controls.Action         = 0
            SELF.Controls.RulesToHide    &= NEW(qRulesCollection)
            SELF.Controls.RulesToDisable &= NEW(qRulesCollection)
            SELF.Controls.RulesToUnHide  &= NEW(qRulesCollection)
            SELF.Controls.RulesToEnable  &= NEW(qRulesCollection)
            ADD(SELF.Controls)
         END
         IF SELF.Rules.RM.Controls.AllRules 
            CASE SELF.Rules.RM.Controls.Action
            OF RuleAction:Hide
               SELF.Controls.RulesToHide.RM &= pRM
               ADD(SELF.Controls.RulesToHide)
            OF RuleAction:UnHide
               SELF.Controls.RulesToDisable.RM &= pRM
               ADD(SELF.Controls.RulesToDisable)
            OF RuleAction:Disable
               SELF.Controls.RulesToUnHide.RM &= pRM
               ADD(SELF.Controls.RulesToUnHide)
            OF RuleAction:Enable
               SELF.Controls.RulesToEnable.RM &= pRM
               ADD(SELF.Controls.RulesToEnable)
            END
         ELSE
            IF RECORDS(SELF.Rules.RM.Controls.RulesToHide)
               SELF.Controls.RulesToHide.RM &= pRM
               ADD(SELF.Controls.RulesToHide)
            END
            IF RECORDS(SELF.Rules.RM.Controls.RulesToDisable)
               SELF.Controls.RulesToDisable.RM &= pRM
               ADD(SELF.Controls.RulesToDisable)
            END
            IF RECORDS(SELF.Rules.RM.Controls.RulesToUnHide)
               SELF.Controls.RulesToUnHide.RM &= pRM
               ADD(SELF.Controls.RulesToUnHide)
            END
            IF RECORDS(SELF.Rules.RM.Controls.RulesToEnable)
               SELF.Controls.RulesToEnable.RM &= pRM
               ADD(SELF.Controls.RulesToEnable)
            END
         END
    END
RulesManager.AddControl              PROCEDURE(UNSIGNED pControlFeq,BYTE pAction)
lFound  BYTE
lIndex  LONG
    CODE
        IF pAction = RuleAction:None THEN RETURN.
        lFound = False
        LOOP lIndex=1 TO RECORDS(SELF.Controls)
             GET(SELF.Controls,lIndex)
             IF SELF.Controls.Control = pControlFeq 
                lFound = True
                BREAK
             END
        END
        IF lFound = False 
           CLEAR(SELF.Controls)
           SELF.Controls.Control        = pControlFeq
           SELF.Controls.AllRules       = True
           SELF.Controls.Action         = pAction
           SELF.Controls.RulesToHide    &= NEW(qRulesCollection)
           SELF.Controls.RulesToDisable &= NEW(qRulesCollection)
           SELF.Controls.RulesToUnHide  &= NEW(qRulesCollection)
           SELF.Controls.RulesToEnable  &= NEW(qRulesCollection)
           ADD(SELF.Controls)
        ELSE
           SELF.Controls.AllRules       = True
           PUT(SELF.Controls)
        END
RulesManager.RulesManagerCount       PROCEDURE()
    CODE
        RETURN RECORDS(SELF.Rules)
RulesManager.RulesCount               PROCEDURE()
Counter BYTE
RulesCounter    LONG
    CODE
    RulesCounter = 0
    LOOP Counter = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,Counter)
      RulesCounter += SELF.Rules.RM.RuleCount()
    END
    RETURN RulesCounter
RulesManager.BrokenRulesCount         PROCEDURE()
Counter BYTE
RulesCounter    LONG
    CODE
    RulesCounter = 0
    LOOP Counter = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,Counter)
      RulesCounter += SELF.Rules.RM.BrokenRuleCount()
    END
    RETURN RulesCounter
RulesManager.CheckAllRules           PROCEDURE(<BYTE DisplayIndicator>)
Counter BYTE
RulesCounter    LONG
    CODE
    RulesCounter = 0
    LOOP Counter = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,Counter)
      IF NOT OMITTED(2)
         RulesCounter += SELF.Rules.RM.CheckAllRules(DisplayIndicator)
      ELSE
         RulesCounter += SELF.Rules.RM.CheckAllRules()
      END
    END
    IF SELF.ChangeControlsStatus 
       SELF.SetControlsStatus()
    END
    RETURN RulesCounter
RulesManager.TakeAccepted            PROCEDURE(LONG Control)
Counter BYTE
RulesCounter    LONG
    CODE
    LOOP Counter = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,Counter)
      IF SELF.Rules.RM.TakeAccepted(Control) 
         BREAK
      END
    END

RulesManager.SetEnumerateIcons       PROCEDURE(STRING pHeaderIcon,STRING pValidRuleIcon,STRING pBrokenRuleIcon)
    CODE
    SELF.EnumHeaderIcon     = pHeaderIcon
    SELF.EnumValidRuleIcon  = pValidRuleIcon
    SELF.EnumBrokenRuleIcon = pBrokenRuleIcon

RulesManager.EnumerateBrokenRules    PROCEDURE(STRING Header,BYTE pOnlyBroken=1)
qBR QUEUE
RuleDesc        STRING(255)
Rule_Icon       LONG                           !Entry's icon ID
Rule_Level      LONG                           !Tree level
ControlNum      LONG
             End
LBRM            &RulesCollection
LBR             &Rule 
NumberOfRules   LONG
MCounter        LONG
Counter         LONG
RetVal          LONG
HasRules        BYTE
IsBroken        BYTE

EnumBRWindow WINDOW('Broken Rules'),AT(,,139,126),FONT('Arial',8,,FONT:regular,CHARSET:ANSI),SYSTEM,GRAY, |
         RESIZE,AUTO
       LIST,AT(0,0,,104),USE(?List:BR),FULL,VSCROLL,ALRT(MouseLeft2),VCR,FORMAT('500L(2)JT'),FROM(qBR)
       BUTTON('Go To...'),AT(76,109,45,14),USE(?Button:OK)
       BUTTON('Cancel'),AT(17,109,45,14),USE(?Button:Cancel),STD(STD:Close)
     END

    CODE
    RetVal = 0
    LOOP MCounter = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,MCounter)
      qBR.RuleDesc   = SELF.Rules.RM.GetDescription()
      qBR.Rule_Icon  = 1
      qBR.ControlNum = 0
      qBR.Rule_Level = 1
      ADD(qBR)
      HasRules = False

      NumberOfRules = SELF.Rules.RM.RuleCount()
      LOOP Counter = 1 TO NumberOfRules
         LBR &= SELF.Rules.RM.Item(Counter)   !don't need to check for null with ordinal value
         IsBroken = LBR.GetIsBroken()
         IF IsBroken = TRUE
            qBR.Rule_Icon  = 2
         ELSE
            qBR.Rule_Icon  = 3
         END
         qBR.RuleDesc   = LBR.GetDescription()
         qBR.ControlNum = LBR.GetControlNum()
         qBR.Rule_Level = 2
         IF pOnlyBroken 
            IF IsBroken 
               ADD(qBR)
               HasRules = True
            END
         ELSE
            ADD(qBR)
            HasRules = True
         END
      END
      IF pOnlyBroken 
         IF HasRules = False 
            GET(qBR,RECORDS(qBR))
            DELETE(qBR)
         END
      END
    END

    OPEN(EnumBRWindow)

    ?List:BR{PROP:ICONLIST,1}=CLIP(SELF.EnumHeaderIcon)     !'~BRules.ICO'
    ?List:BR{PROP:ICONLIST,2}=CLIP(SELF.EnumBrokenRuleIcon) !'~BRuleNO.ICO'
    ?List:BR{PROP:ICONLIST,3}=CLIP(SELF.EnumValidRuleIcon)  !'~BRuleOk.ICO'
    EnumBRWindow{Prop:Text} = CLIP(Header)
    EnumBRWindow{Prop:Icon} = CLIP(SELF.EnumHeaderIcon)     !'~BRules.ICO'
    IF RECORDS(qBR) 
        ?List:BR{PROP:SELECTED}=1
        GET(qBR,1)
    END
    ACCEPT
       IF EVENT()=EVENT:NewSelection OR EVENT()=EVENT:Accepted AND Accepted()=?List:BR 
          GET(qBR,CHOICE(?List:BR))
       END
       ?Button:OK{Prop:Disable}=CHOOSE(qBR.ControlNum = 0,True,False)
       IF KEYCODE() = MouseLeft2 or Accepted() = ?Button:OK
        GET(qBR,CHOICE(?List:BR))
        IF qBR.ControlNum 
          Retval = qBR.ControlNum
          BREAK
        END
       END
    END
    CLOSE(EnumBRWindow)
    SELF.BrokenRuleControl = Retval
    RETURN(Retval)

RulesManager.SetGlobalRuleReferences PROCEDURE(*LONG Ref)
Counter1 LONG
Counter2 LONG
    CODE
    LOOP Counter1 = 1 TO RECORDS(SELF.Rules)
      GET(SELF.Rules,Counter1)
      LOOP Counter2 = 1 TO RECORDS(SELF.Rules.RM.BrokenRuleQueue)
        GET(SELF.Rules.RM.BrokenRuleQueue,Counter2)
        SELF.Rules.RM.BrokenRuleQueue.BrokenRuleInstance.GlobalRule &= Ref
      END
    END

