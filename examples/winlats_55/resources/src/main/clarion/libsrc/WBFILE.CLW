
  MEMBER

  pragma('debug(vid=>full)')

  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('WBFILE.INC'),ONCE


WebTPIndex LONG


WbFileProperties.GetProperty                  PROCEDURE(ASTRING name, unsigned idx1, unsigned idx2)

Tp  &WbTableProperties

  CODE

    Tp &= TIED(name, WebTPIndex)
    IF ~Tp &= NULL
      RETURN CreateReferenceValue(Tp.IProperties)
    ELSE
      RETURN NULL
    END


WbTableProperties.GetProperty                    PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0)

ColumnNum   LONG
Result      CSTRING(255),AUTO

  CODE
    Result = GetFieldValue(SELF.TableName, name)
    IF (ISSTRING(Result))
      RETURN CreateStringValue(Result)
    ELSE
      RETURN CreateIntegerValue(Result)
    END

WbTableProperties.Init                           PROCEDURE(String TableName, String TableTag)

  CODE
    SELF.TableTag &= NEW(STRING(LEN(CLIP(TableTag))))
    SELF.TableTag = TableTag
    SELF.TableName &= NEW(STRING(LEN(CLIP(TableName))))
    SELF.TableName = UPPER(TableName)

WbTableProperties.Kill                           PROCEDURE

  CODE
    DISPOSE(SELF.TableTag)
    DISPOSE(SELF.TableName)

SetTableProperties                               PROCEDURE(WbTableProperties TP, ASTRING Tag)

  CODE
    WebTPIndex = TIE(UPPER(Tag), WebTPIndex, ADDRESS(TP))

