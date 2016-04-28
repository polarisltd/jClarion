!ABCIncludeFile(WEB)

OMIT('_EndOfInclude_',_AbcWebFileDetailProperties_)
_AbcWebFileDetailProperties_ EQUATE(1)

  INCLUDE('ABLPROPR.INC'),ONCE

  INCLUDE('ABLPROP.INC'),ONCE
  INCLUDE('LAYVALUE.INT'),ONCE

  MAP
    MODULE('WBFILE.CLW')
SetTableProperties  PROCEDURE(WbTableProperties TP, ASTRING Tag)
    END
  END

WbFileProperties      CLASS(WbControlHtmlProperties),TYPE,MODULE('WBFILE.CLW'),DLL(_ABCDllMode_),LINK('WBFILE',_ABCLinkMode_)
GetProperty             PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0),*IValue,DERIVED
                      END


WbTableProperties     CLASS(WbPropertiesClass),TYPE,MODULE('WBFILE.CLW'),DLL(_WebAbcDllMode_),LINK('WBFILE',_WebAbcLinkMode_)

Init                    PROCEDURE(String TableName,String TableTag)
Kill                    PROCEDURE

GetProperty             PROCEDURE(ASTRING name,UNSIGNED idx1=0,UNSIGNED idx2=0),*IValue,DERIVED

TableTag                &STRING,PROTECTED
TableName               &STRING,PROTECTED
                      END


  _EndOfInclude_
