! DynStr interface for Clarion

 OMIT('__EndOfInclude__',_DynStrPresent_)
_DynStrPresent_ EQUATE(1)

  MAP
    MODULE('')
      NewDynStr(),*IDynStr,NAME('Cla$NewDynStr')
      DisposeDynStr(*IDynStr),NAME('Cla$DisposeDynStr')
    END
  END



IDynStr  INTERFACE
Str          PROCEDURE(),STRING
CStr         PROCEDURE(),*CSTRING
Kill         PROCEDURE()
Cat          PROCEDURE(STRING)
Cat          PROCEDURE(*STRING)
Cat          PROCEDURE(*DECIMAL)
Cat          PROCEDURE(*CSTRING)
CatNum       PROCEDURE(LONG,USHORT Base=10)
CatChr       PROCEDURE(BYTE chr)
Clip         PROCEDURE()
Trunc        PROCEDURE(LONG newlen)
StrLen       PROCEDURE(),LONG
BinaryToText PROCEDURE(STRING)          ! Expand ' to '' etc.
TextToBinary PROCEDURE(STRING,LONG pos=1),LONG  ! Lex a string (return 0 if failed)
PadTo        PROCEDURE(LONG)
CopyTo       PROCEDURE(*STRING,LONG limit=-1)
CopyTo       PROCEDURE(*CSTRING,LONG limit=-1)
GetChr       PROCEDURE(LONG index),BYTE
CStrRef      PROCEDURE(),LONG
CDynStrRef   PROCEDURE(),LONG
Release      PROCEDURE()
         END

__EndOfInclude__
