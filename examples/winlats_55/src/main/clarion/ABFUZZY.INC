!ABCIncludeFile

  OMIT('_EndOfInclude_', _FuzzyPresent_)
_FuzzyPresent_  EQUATE(1)


MaxWords    EQUATE(10)
MaxDocLen   EQUATE(1000)
MaxWordLen  EQUATE(256)
MaxResults  EQUATE(20)


  ITEMIZE(),PRE(MatchOption)
NoCase          EQUATE
WordOnly        EQUATE
  END

ProcedureBindName   EQUATE('FuzzyMatch')

  MAP
    MODULE('ABFUZZY.CLW')
FuzzyMatch   PROCEDURE(STRING Query, STRING Document),STRING
    END
  END


FuzzyClass          CLASS,TYPE,MODULE('ABFUZZY.CLW'),LINK('ABFUZZY.CLW', _ABCLinkMode_),DLL(_ABCDllMode_)
BaseValue             BYTE,DIM(MaxWords),DIM(MaxWords),PRIVATE
Doc                   ASTRING,PRIVATE
NoCase                BYTE,PRIVATE
Query                 ASTRING,PRIVATE
QWordPos              USHORT,DIM(MaxWords),PRIVATE
Res                   BYTE,PRIVATE
ResultIndex           USHORT,DIM(MaxResults),DIM(MaxWords),PRIVATE
ret                   BYTE,PRIVATE
ReturnIndex           BYTE,DIM(MaxWordLen),DIM(MaxWords),PRIVATE
ReturnIndexDone       BYTE,DIM(MaxWords),PRIVATE
WordCnt               BYTE,PRIVATE
WordOnly              BYTE,PRIVATE
Words                 CSTRING(MaxWordLen),DIM(MaxWords),PRIVATE

_ComputePercentage    PROCEDURE(ASTRING Doc, BYTE Pos, ASTRING Word, BYTE WhichWord),BYTE,PRIVATE
_ComputeReturnIndex   PROCEDURE(USHORT WhichWord),PRIVATE
_Evaluate             PROCEDURE(ASTRING Doc),BYTE,PRIVATE
_EvaluateWord         PROCEDURE(ASTRING Doc, ASTRING Word, BYTE WhichWord),BYTE,PRIVATE
_GetReturnIndex       PROCEDURE(USHORT WhichWord, USHORT Idx),BYTE,PRIVATE
_IsWordDelimiter      PROCEDURE(STRING C, BYTE Leading=FALSE),BYTE,PRIVATE
_SplitQuery           PROCEDURE(ASTRING SearchExp),PRIVATE
_FindMatches          PROCEDURE(ASTRING DocumentToSearch),PRIVATE

Construct             PROCEDURE
Init                  PROCEDURE   !,EXTENDS
Kill                  PROCEDURE
Match                 PROCEDURE(ASTRING DocumentToSearch, ASTRING SearchExp),BYTE
SetOption             PROCEDURE(BYTE WhichOption, BYTE Value=TRUE)
                   END

  _EndOfInclude_
