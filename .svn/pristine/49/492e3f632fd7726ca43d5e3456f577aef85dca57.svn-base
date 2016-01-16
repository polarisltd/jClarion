
!ABCIncludeFile

OMIT('_EndOfInclude_',_RptFldOvrMgrPresent_)
_RptFldOvrMgrPresent_ EQUATE(1)

rfom:DefaultJustification EQUATE(0)
rfom:RightJustified       EQUATE(1)
rfom:LeftJustified        EQUATE(2)
rfom:Centered             EQUATE(4)

tRptFldPairQ     QUEUE,TYPE
PrimaryFEQ           LONG

lFEQ                 LONG
lFEQ:XPos            LONG
lFEQ:YPos            LONG
lFEQ:Height          LONG
lFEQ:Width           LONG
lFEQ:NoWidth         LONG
lFEQ:Justification   LONG

rFEQ                 LONG
rFEQ:XPos            LONG
rFEQ:YPos            LONG
rFEQ:Height          LONG
rFEQ:Width           LONG
rFEQ:NoWidth         LONG
rFEQ:Justification   LONG
                   END


RptFldOvrClass                CLASS,TYPE,MODULE('VSA_RFOM.CLW'),LINK('VSA_RFOM.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)

Report                          &REPORT
RptFldPairQ                     &tRptFldPairQ,PROTECTED       ! Queue of report field pairs

Init                            PROCEDURE(REPORT Report)
Kill                            PROCEDURE
AddPair                         PROCEDURE(LONG lFEQ, LONG rFEQ, LONG PrimaryFEQ=0)
Resize                          PROCEDURE()
Resize                          PROCEDURE(LONG PrimaryFEQ)
SaveJustification               PROCEDURE(LONG FEQ,*LONG Justification)
SetJustification                PROCEDURE(LONG FEQ,LONG Justification)
                              END

_EndOfInclude_
