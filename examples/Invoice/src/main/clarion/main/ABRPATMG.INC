!ABCIncludeFile

  OMIT('_EndOfInclude_',_ReportAttributeManagerPresent_)
_ReportAttributeManagerPresent_   EQUATE(1)

  INCLUDE('ABRPTGEN.INT'),ONCE
  INCLUDE('ABRPATMG.EQU'),ONCE
  INCLUDE('ABERROR.INC'),ONCE
  
AttributeParser CLASS,TYPE,MODULE('ABRPATMG.CLW'),LINK('ABRPATMG.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Errors           &ErrorClass,PROTECTED
Caller           &STRING,PROTECTED ! Must be initialised in the constructor of the derived class
Token            GROUP,PRIVATE
Type               BYTE
Str                STRING(MaxAttributeSize)
                 END

GetNextToken            PROCEDURE(CONST *STRING Comment, SIGNED StrLen, CONST *STRING EndList, *SIGNED Pos),BYTE,PRIVATE
ProcessAttribute        PROCEDURE(CONST *STRING AttrType, CONST *STRING AttrValue),PROTECTED,VIRTUAL

Init                    PROCEDURE(<ErrorClass EC>)
ProcessAttributes       PROCEDURE(CONST *STRING AttributeList)

                 END
HiddenControlsQueue QUEUE,TYPE
Control               SHORT
                    END

ReportAttributeManager CLASS,MODULE('ABRPATMG.CLW'),TYPE,LINK('ABRPATMG.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
R                          &REPORT,PRIVATE
HCQ                        &HiddenControlsQueue
Construct                  PROCEDURE()
Destruct                   PROCEDURE()
Init                       PROCEDURE(*REPORT pReport),VIRTUAL ! Set the target where the controls used in the SET method are populated
Set                        PROCEDURE(SHORT pReportControl,STRING pReportGeneratorType,STRING pAttribute,<STRING pAttributeValue>) !pReportProcessorType EQUATE defined in abrptgen.int
SetHideControls            PROCEDURE() !Set the Width and Height off all controls in HCQ to 0 and store it original size in the ALL(HW=,HH=) attribute
Extract                    PROCEDURE(STRING pReportGeneratorType,STRING pAttribute,STRING pControlExtendAttribute),STRING
IsValid                    PROCEDURE(STRING pReportGeneratorType,STRING pControlExtendAttribute),BYTE ! Return true if exist any attribute for the given ReportProcessorType
IsValid                    PROCEDURE(STRING pReportGeneratorType,STRING pAttribute,STRING pControlExtendAttribute),BYTE ! Return true if exist the attribute for the given ReportProcessorType
                       END

 _EndOfInclude_
