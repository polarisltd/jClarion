   MEMBER
   MAP
   .

   INCLUDE('IBCBASE.INC'),ONCE

!!--------------------------------------------------------------------------

CInterface.Construct  PROCEDURE
  CODE
  SELF.Count = 0

CInterface.Destruct PROCEDURE
  CODE
  ASSERT(SELF.Count = 0)

CInterface.Link     PROCEDURE
  CODE
  SELF.Count += 1


CInterface.Release         PROCEDURE
THIS                    &CInterface,auto
  CODE
  IF (SELF.Count <> 0)
     SELF.Count -= 1
  ELSE
     THIS &= SELF
     DISPOSE(THIS)
  END

!! Copy the following lines into your class
OMIT('**End Demo Code**')
Class.IInterface.Link       PROCEDURE
  CODE
  SELF.Link()

Class.IInterface.Release    PROCEDURE
  CODE
  SELF.Release()

**End Demo Code**

!!--------------------------------------------------------------------------

MyString.Destruct                PROCEDURE
  CODE
    DISPOSE(SELF.Text)

MyString.IStringVal.Link            PROCEDURE
  CODE
    SELF.Link()

MyString.IStringVal.Release           PROCEDURE
  CODE
    SELF.Release()

MyString.IStringVal.GetValue          PROCEDURE
  CODE
    RETURN SELF.Text

MyString.IStringVal.SetValue          PROCEDURE(CONST *CSTRING NewText)
  CODE
    DISPOSE(SELF.Text)
    SELF.Text &= NEW CSTRING(LEN(NewText)+1)
    SELF.Text = NewText

MyString.IStringVal.ClearValue          PROCEDURE()
  CODE
    DISPOSE(SELF.Text)
    SELF.Text &= NEW CSTRING(1)
    CLEAR(SELF.Text)






AStringValue.IAStringVal.GetValue PROCEDURE

  CODE
  RETURN SELF.Value


AStringValue.IAStringVal.SetValue PROCEDURE(ASTRING V)

  CODE
  SELF.Value = V


AStringValue.IAStringVal.Link PROCEDURE

  CODE
  SELF.Link


AStringValue.IAStringVal.Release PROCEDURE

  CODE
  SELF.Release


AStringValue.IAStringVal.ClearValue PROCEDURE

  CODE
  SELF.Value = ''




IStringVal::Create  PROCEDURE

Result  &MyString,AUTO

  CODE
    Result &= NEW MyString
    RETURN Result.IStringVal



IAStringVal::Create PROCEDURE(<ASTRING InitVal>)

Tmp &AStringValue,AUTO

  CODE
  Tmp &= NEW AStringValue
  IF OMITTED(1)
    Tmp.IAstringVal.ClearValue
  ELSE
    Tmp.IAStringVal.SetValue(InitVal)
  END
  RETURN Tmp.IAStringVal

