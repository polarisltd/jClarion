!ABCIncludeFile(IBC)

OMIT('_EndOfInclude_',_IInterfacePresent_)
_IInterfacePresent_ EQUATE(1)

   INCLUDE('IBCBASE.INT'),ONCE

!!--------------------------------------------------------------------------

CInterface        CLASS,TYPE,MODULE('IBCBASE.Clw'),DLL(_IbcDllMode_),LINK('IBCBASE.CLW',_IbcLinkMode_)
Construct         PROCEDURE
Destruct          PROCEDURE,VIRTUAL
Link              PROCEDURE                     !,FINAL
Release           PROCEDURE                     !,FINAL

Count             LONG,PRIVATE
                END

!!--------------------------------------------------------------------------

MyString        CLASS(CInterface),IMPLEMENTS(IStringVal),TYPE,MODULE('IBCBASE.Clw'),DLL(_IbcDllMode_)
Destruct          PROCEDURE,VIRTUAL
Text              &CSTRING,protected
                END


AStringValue    CLASS(CInterface),IMPLEMENTS(IAStringVal),TYPE,MODULE('IBCBASE.Clw'),DLL(_IbcDllMode_)
Value             ASTRING,PRIVATE
                END


_EndOfInclude_

