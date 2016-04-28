!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_NameGeneratorPresent_)
_NameGeneratorPresent_ EQUATE(1)

!Equates used in GetName
Name:Path      EQUATE(01H)
Name:Name      EQUATE(02H)
Name:Extension EQUATE(04H)
Name:NoPath    EQUATE(Name:Name + Name:Extension)
Name:Full      EQUATE(Name:Path + Name:NoPath)

! Class to generate file names based on an initial value and a mask.
! The mask can have <%p> to indicate where the page number goes and a <%t>
! to indicate where the total pages go.  Both are optional.  <%p> can
! also have a 0 before the > to indicate that the number is 0 padded.
! The default mask is <%p0>_OF_<%t>.

NameGenerator CLASS,MODULE('ABPRNAME.CLW'),TYPE,LINK('ABPRNAME.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ReportName       CSTRING(FILE:MaxFilePath+1),PRIVATE
Extension        CSTRING(FILE:MaxFileName+1),PRIVATE
DefaultName      CSTRING(FILE:MaxFilePath+1),PRIVATE
DefaultExtension CSTRING(FILE:MaxFileName+1),PRIVATE
GenerationMask   CSTRING(20),PRIVATE
TotalPages       SHORT,PRIVATE
MaskBits         LONG,DIM(6),PRIVATE
PPos             LONG,PRIVATE
TPos             LONG,PRIVATE
PPad             BYTE,PRIVATE

MakeNumber      PROCEDURE(SHORT num),STRING,PRIVATE
MakeMask        PROCEDURE(SHORT PageNumber),STRING,PRIVATE

Construct       PROCEDURE()
Init            PROCEDURE(STRING defaultName, STRING defaultExtension)
SetTotalPages   PROCEDURE(SHORT TotalPages)
SetNameMask     PROCEDURE(STRING Mask)
ExtractFileName PROCEDURE(STRING value)
MakeName        PROCEDURE(SHORT PageNumber),STRING
GetName         PROCEDURE(BYTE nameType = Name:Full,SHORT PageNumber = 0),STRING
GetDataFromName PROCEDURE(STRING Name,BYTE nameType = Name:Full,SHORT PageNumber = 0),STRING
GetExtension    PROCEDURE(),STRING
              END

 _EndOfInclude_
