  MEMBER

  INCLUDE('ABRPATMG.INC'),ONCE
  INCLUDE('ABERROR.INC'),ONCE

TokenType:String                    EQUATE(1)
TokenType:Writer_AttributeSeperator EQUATE(2)
TokenType:AttributeSeperator        EQUATE(3)
TokenType:AttributeListEnd          EQUATE(4)
TokenType:WriterSeperator           EQUATE(5)
TokenType:AttributeTypeSeperator    EQUATE(6)

AttributeSeperator     EQUATE('|')
AttributeListStart     EQUATE('(')
AttributeListEnd       EQUATE(')')
WriterSeperator        EQUATE(',')
QuoteChar              EQUATE('''')
AttributeTypeSeperator EQUATE('=')

AttributeParser.GetNextToken PROCEDURE(*STRING Comment, SIGNED StrLen, CONST *STRING EndList, *SIGNED Pos)
StrPos  SIGNED,AUTO
InQuote BYTE,AUTO
  CODE
    LOOP WHILE Pos <= StrLen AND (VAL(Comment[Pos]) = VAL(' '))
      Pos += 1
    END
    IF Pos <= StrLen
      CASE VAL(Comment[Pos])
      OF VAL(AttributeTypeSeperator)
        SELF.Token.Type = TokenType:AttributeTypeSeperator
        Pos += 1
        RETURN FALSE
      OF VAL(AttributeSeperator)
        SELF.Token.Type = TokenType:AttributeSeperator
        Pos += 1
        RETURN FALSE
      OF VAL(AttributeListStart)
        SELF.Token.Type = TokenType:Writer_AttributeSeperator
        Pos += 1
        RETURN FALSE
      OF VAL(AttributeListEnd)
        SELF.Token.Type = TokenType:AttributeListEnd
        Pos += 1
        RETURN FALSE
      OF VAL(WriterSeperator)
        SELF.Token.Type = TokenType:WriterSeperator
        Pos += 1
        RETURN FALSE
      ELSE
        SELF.Token.Type = TokenType:String
        StrPos = 1
        IF VAL(Comment[Pos]) = VAL(QuoteChar)
          InQuote = TRUE
          Pos += 1
        ELSE
          InQuote = FALSE
        END
        SELF.Token.Str = ' '
        LOOP WHILE Pos <= StrLen
          IF InQuote
            IF VAL(Comment[Pos]) = VAL(QuoteChar)
              Pos += 1
              IF Pos > StrLen OR VAL(Comment[Pos]) <> VAL(QuoteChar)
                InQuote = FALSE
                BREAK
              END
            END
          ELSIF INSTRING(Comment[Pos], EndList, 1, 1)
            BREAK
          END
          SELF.Token.Str[StrPos] = Comment[Pos]
          StrPos += 1
          Pos += 1
        END
        IF InQuote AND NOT SELF.Errors &= NULL
          SELF.Errors.SetField(Pos - 1)
          SELF.Errors.ThrowMessage(Msg:RWPPoorComment, Comment)
        END
        RETURN FALSE
      END
    ELSE
      RETURN TRUE
    END

AttributeParser.Init PROCEDURE (<ErrorClass EC>)
  CODE
    IF OMITTED(2)
      SELF.Errors &= NULL
    ELSE
      SELF.Errors &= EC
    END

AttributeParser.ProcessAttributes PROCEDURE(CONST *STRING AttributeList)
AttrType         STRING(256),AUTO
BlankStr         STRING(1)
Pos              SIGNED(1)
EndOfLine        BYTE,AUTO
HaveError        BYTE(FALSE)
IgnoreAttributes BYTE,AUTO
StrLen           SIGNED,AUTO
EndList          STRING(3),AUTO  !This must be fully populated to make sure space is not treated as an end char
PState           BYTE   ! 0 = need writer type
                        ! 1 = need write/attribute seperator
                        ! 2 = need attribute
                        ! 3 = need attribute type seperator or attribute seperator or attribute list end
                        ! 4 = need writer seperator
                        ! 5 = need attribute seperator or attribute list end
  CODE
  StrLen = LEN(CLIP(AttributeList))
  LOOP
    IF PState = 0
      EndList[1] = AttributeListStart
      EndList[2] = AttributeListStart
      EndList[3] = AttributeListStart
    ELSIF PState = 2
      EndList[1] = AttributeSeperator
      EndList[2] = AttributeListEnd
      EndList[3] = AttributeTypeSeperator
    END
    EndOfLine = SELF.GetNextToken(AttributeList, StrLen, EndList, Pos)
    IF EndOfLine
      IF PState <> 4 AND PState <> 0
        HaveError = TRUE
      END
      BREAK
    ELSE
      CASE PState
      OF 0
        IF SELF.Token.Type = TokenType:String
          PState = 1
          IgnoreAttributes = CHOOSE(UPPER(SELF.Token.Str) <> UPPER(SELF.Caller) AND UPPER(SELF.Token.Str) <> 'ALL')
        ELSE
          HaveError = TRUE
        END
      OF 1
        IF SELF.Token.Type <> TokenType:Writer_AttributeSeperator
          HaveError = TRUE
        ELSE
          PState = 2
        END
      OF 2
        IF SELF.Token.Type <> TokenType:String
          HaveError = TRUE
        ELSE
          PState = 3
          IF NOT IgnoreAttributes
            AttrType = UPPER(SELF.Token.Str)
          END
        END
      OF 3
        IF SELF.Token.Type = TokenType:AttributeSeperator
          PState = 2
        ELSIF SELF.Token.Type = TokenType:AttributeListEnd
          PState = 4
        ELSIF SELF.Token.Type = TokenType:AttributeTypeSeperator
          PState = 5
        ELSE
          HaveError = TRUE
        END
        IF NOT IgnoreAttributes AND NOT HaveError AND PState <> 5
          SELF.ProcessAttribute(AttrType, BlankStr)
        END
      OF 4
        IF SELF.Token.Type <> TokenType:WriterSeperator
          HaveError = TRUE
        ELSE
          PState = 0
        END
      OF 5
        IF SELF.Token.Type = TokenType:AttributeSeperator
          PState = 2
        ELSIF SELF.Token.Type = TokenType:AttributeListEnd
          PState = 4
        ELSE
          HaveError = TRUE
        END
        IF NOT IgnoreAttributes AND NOT HaveError
          SELF.ProcessAttribute(AttrType, SELF.Token.Str)
        END
      ELSE
?       ASSERT(FALSE, 'Attribute Parser Error')
        BREAK
      END
      IF HaveError
        BREAK
      END
    END
  END
  IF HaveError AND NOT SELF.Errors &= NULL
    SELF.Errors.SetField(Pos)
    SELF.Errors.ThrowMessage(Msg:RWPPoorComment, AttributeList)
  END
  
AttributeParser.ProcessAttribute PROCEDURE(CONST *STRING AttrType, CONST *STRING AttrValue)
  CODE
? ASSERT(FALSE,'ProcessAttribute not implemented')


ReportAttributeManager.Construct                  PROCEDURE()
  CODE
    SELF.HCQ &= NEW(HiddenControlsQueue)

ReportAttributeManager.Destruct                   PROCEDURE()
  CODE
    FREE(SELF.HCQ)
    DISPOSE(SELF.HCQ)

ReportAttributeManager.SetHideControls            PROCEDURE() !Set the Width and Height off all controls in HCQ to 0 and store it original size in the ALL(HW=,HH=) attribute
lIndex   SHORT,AUTO
lWidth   LONG,AUTO
lHeight  LONG,AUTO
lCoordinateMeasure  REAL,AUTO
lNeedToChangeMeasure BYTE,AUTO
  CODE
   lCoordinateMeasure = 0
   lNeedToChangeMeasure=False
   IF SELF.R{PROP:THOUS} THEN
      lCoordinateMeasure = 1
   ELSIF SELF.R{PROP:MM} THEN
      lCoordinateMeasure = 40
   ELSIF SELF.R{PROP:POINTS} THEN
      lCoordinateMeasure = 13.89
   ELSE
      lNeedToChangeMeasure= true
      lCoordinateMeasure  = 1
   END
   IF lNeedToChangeMeasure THEN
      SELF.R{PROP:THOUS} = True
   END
   LOOP lIndex = 1 TO RECORDS(SELF.HCQ)
        GET(SELF.HCQ,lIndex)
        IF ERRORCODE() THEN BREAK.
        lWidth = SELF.R $ SELF.HCQ.Control{PROP:width}
        lHeight= SELF.R $ SELF.HCQ.Control{PROP:height}

        lWidth = (lWidth * lCoordinateMeasure)
        lHeight= (lHeight * lCoordinateMeasure)

        SELF.Set(SELF.HCQ.Control,RepGen:ALL,TargetAttr:HideWidth,lWidth)
        SELF.Set(SELF.HCQ.Control,RepGen:ALL,TargetAttr:HideHeight,lHeight)
        SELF.R $ SELF.HCQ.Control{PROP:width}=0
        SELF.R $ SELF.HCQ.Control{PROP:height}=0
   END
   IF lNeedToChangeMeasure THEN
      SELF.R{PROP:THOUS} = False
   END

ReportAttributeManager.Init PROCEDURE(*REPORT pReport)
  CODE
    SELF.R &= pReport

! Warning:  There is a bug in this code that an EXTEND string with an ')' in an attribute value will cause a poorly formed string

ReportAttributeManager.Set PROCEDURE(SHORT pReportControl,STRING pReportGeneratorType,STRING pAttribute,<STRING pAttributeValue>)
lStartPos   LONG,AUTO
lEndPos     LONG,AUTO
lAttrPos    LONG,AUTO
lNextAttr   LONG,AUTO
lAttrExists BYTE,AUTO
lReadPos    LONG,AUTO
lWritePos   LONG,AUTO
lReadLen    LONG,AUTO
lAttribute  CSTRING(MaxAttributeSize+1),AUTO
lEnd        CSTRING(MaxAttributeSize+1),AUTO
  CODE
    IF pAttribute = TargetAttr:HIDE AND pReportGeneratorType=RepGen:ALL THEN
       SELF.HCQ.Control = pReportControl
       ADD(SELF.HCQ)
    END
    lAttribute = SELF.R $ pReportControl{PROP:Extend}
    lStartPos = INSTRING(pReportGeneratorType,lAttribute,1,1)
    IF ~lStartPos
      IF pAttribute
        IF lAttribute
          lAttribute = lAttribute & WriterSeperator
        END
        lAttribute = lAttribute & pReportGeneratorType & AttributeListStart & pAttribute
        IF ~OMITTED(5)
          lAttribute = lAttribute & AttributeTypeSeperator & pAttributeValue
        END
        lAttribute = lAttribute & AttributeListEnd
      END
    ELSE
      lEndPos = INSTRING(AttributeListEnd, lAttribute, 1, lStartPos)
?     ASSERT(lEndPos ~= 0, 'Badly formed attribute string')
      IF lEndPos=0
        lAttribute = lAttribute & AttributeListEnd
        lEndPos = LEN(lAttribute)
      END
      lAttrPos = INSTRING(pAttribute, lAttribute, 1, lStartPos)
      IF lAttrPos AND lAttrPos < lEndPos
        lAttrExists = TRUE
        lNextAttr = INSTRING(AttributeSeperator, lAttribute, 1, lAttrPos)
        IF lNextAttr AND lNextAttr < lEndPos
          lEndPos = lNextAttr
        END
      ELSE
        lAttrExists = FALSE
      END
      lEnd = SUB(lAttribute,lEndPos,LEN(lAttribute) - lEndPos + 1)
      IF lAttrExists
        lAttribute = SUB(lAttribute,1,lAttrPos-1) & pAttribute
      ELSE
        lAttribute = SUB(lAttribute,1,lEndPos-1) & AttributeSeperator & pAttribute
      END
      IF ~OMITTED(5)
        lAttribute = lAttribute & AttributeTypeSeperator
        IF INSTRING(AttributeSeperator, pAttributeValue, 1, 1)
          lReadLen = LEN(CLIP(pAttributeValue))
          lReadPos = 1
          lWritePos = LEN(lAttribute) + 1
          lAttribute[lWritePos] = QuoteChar
          lWritePos += 1
          LOOP WHILE lReadPos <= lReadLen
            IF VAL(pAttributeValue[lReadPos]) = VAL(QuoteChar)
              lAttribute[lWritePos] = QuoteChar
              lWritePos += 1
            END
            lAttribute[lWritePos] = pAttributeValue[lReadPos]
            lReadPos += 1
            lWritePos += 1
          END
          lAttribute[lWritePos+1] = QuoteChar
          lAttribute[lWritePos+2] = CHR(0)
        ELSE
          lAttribute = lAttribute & pAttributeValue
        END
      END
      lAttribute = lAttribute & lEnd
    END
    SELF.R $ pReportControl{PROP:Extend} = lAttribute

ReportAttributeManager.IsValid  PROCEDURE(STRING pReportGeneratorType,STRING pControlExtendAttribute)
lAttribute  CSTRING(MaxAttributeSize+1),AUTO
lStartPos   LONG,AUTO
lEndPos     LONG,AUTO
lAttrPos    LONG,AUTO
  CODE
    lAttribute = pControlExtendAttribute
    lStartPos = INSTRING(pReportGeneratorType,lAttribute,1,1)
    IF ~lStartPos
        RETURN False
    ELSE
      lEndPos = INSTRING(AttributeListEnd, lAttribute, 1, lStartPos)
?     ASSERT(lEndPos ~= 0, 'Badly formed attribute string')
      IF lEndPos=0
         RETURN False
      END
      RETURN True
    END

ReportAttributeManager.IsValid  PROCEDURE(STRING pReportGeneratorType,STRING pAttribute,STRING pControlExtendAttribute) ! Return true if exist the attribute for the given ReportProcessorType
lAttribute  CSTRING(MaxAttributeSize+1),AUTO
lStartPos   LONG,AUTO
lEndPos     LONG,AUTO
lAttrPos    LONG,AUTO
  CODE
    lAttribute = pControlExtendAttribute
    lStartPos = INSTRING(pReportGeneratorType,lAttribute,1,1)
    IF ~lStartPos
        RETURN False
    ELSE
      lEndPos = INSTRING(AttributeListEnd, lAttribute, 1, lStartPos)
?     ASSERT(lEndPos ~= 0, 'Badly formed attribute string')
      IF lEndPos=0
         RETURN False
      END
      lAttrPos = INSTRING(pAttribute, lAttribute, 1, lStartPos)
      IF lAttrPos
         RETURN True
      ELSE
         RETURN False
      END
    END

ReportAttributeManager.Extract  PROCEDURE(STRING pReportGeneratorType,STRING pAttribute,STRING pControlExtendAttribute)
lAttribute  CSTRING(MaxAttributeSize+1),AUTO
lStartPos   LONG,AUTO
lEndPos     LONG,AUTO
lAttrPos    LONG,AUTO
lAttrEnd    LONG,AUTO
lNextAttr   LONG,AUTO
lValStart   LONG,AUTO
lValLen     LONG,AUTO
  CODE
    lAttribute = pControlExtendAttribute
    lStartPos = INSTRING(pReportGeneratorType,lAttribute,1,1)
    IF ~lStartPos
        RETURN ''
    ELSE
      lEndPos = INSTRING(AttributeListEnd, lAttribute, 1, lStartPos)
?     ASSERT(lEndPos ~= 0, 'Badly formed attribute string')
      IF lEndPos=0
         RETURN ''
      END
      lAttrPos = INSTRING(pAttribute, lAttribute, 1, lStartPos)
      IF lAttrPos AND lAttrPos < lEndPos
        lAttrEnd = INSTRING(AttributeSeperator, lAttribute, 1, lAttrPos)
        IF NOT lAttrEnd OR lAttrEnd>lEndPos
          lAttrEnd = lEndPos
        END
        lValStart = lAttrPos+LEN(pAttribute)+1
        lValLen   = lAttrEnd - lValStart
        RETURN SUB(lAttribute,lValStart,lValLen)
      ELSE
        RETURN ''
      END
    END
