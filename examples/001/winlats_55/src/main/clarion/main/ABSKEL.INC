
  !ABCIncludeFile(DOC)


  OMIT('_EndOfInclude_', _ABSkelPresent_)
_ABSkelPresent_  EQUATE(1)


   INCLUDE('LAYBUILD.INT'),ONCE
   INCLUDE('LAYVALUE.INT'),ONCE
   INCLUDE('WBFILE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE


  MAP
  END

MergeElement CLASS(),TYPE,IMPLEMENTS(IHtmlElementProperties),MODULE('ABSKEL.CLW'),DLL(_SkelsDLLMode_),LINK('ABSKEL.CLW', _SkelsLinkMode_)
Init               PROCEDURE(STRING SkeletonFile, WbFileProperties Wbf)
Kill               PROCEDURE()
GetProperty        PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0),*IValue,VIRTUAL
SetProperty        PROCEDURE(ASTRING name, STRING value),VIRTUAL
GenerateDocument   PROCEDURE(STRING FileName),VIRTUAL
GetName            PROCEDURE(),STRING
GetPosition        PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),VIRTUAL
GetSkeletonAttr    PROCEDURE(SIGNED whichAttr),STRING,VIRTUAL

MaxRecordCount    SIGNED(30)
PageBuilder       &ISkeletonPageBuilder
SkeletonFile      &STRING,PRIVATE
WebFileAccess     &WbFileProperties,PRIVATE
             END

ReportElement CLASS(MergeElement),TYPE,MODULE('ABSKEL.CLW'),DLL(_SkelsDLLMode_),LINK('ABSKEL.CLW', _SkelsLinkMode_)
Init               PROCEDURE(ProcessClass Process, STRING SkeletonFile, WbFileProperties Wbf)
GetProperty        PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0),*IValue,VIRTUAL
SetProperty        PROCEDURE(ASTRING name, STRING value),VIRTUAL
GetSkeletonAttr    PROCEDURE(SIGNED whichAttr),STRING,VIRTUAL

AnyMore           BYTE,PROTECTED
Process           &ProcessClass
              END

  _EndOfInclude_
