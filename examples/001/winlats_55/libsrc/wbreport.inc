!ABCIncludeFile(WEB)

OMIT('_EndOfInclude_',_AbcWebReportDetailProperties_)
_AbcWebReportDetailProperties_ EQUATE(1)

  INCLUDE('ABLPROPR.INC'),ONCE
  INCLUDE('ABREPORT.INC'),ONCE

  INCLUDE('LAYSKEL.INT'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABLWIN.INC'),ONCE
  INCLUDE('ABLPROP.INC'),ONCE
  INCLUDE('ABLPROPR.INC'),ONCE
  INCLUDE('LAYVALUE.INT'),ONCE
  INCLUDE('WSLPROP.INT'),ONCE
  INCLUDE('WBFILE.INC'),ONCE

A:MoreRecords         ASTRING('MoreRecords')
A:NextRecord          ASTRING('NextRecord')
A:CheckPageBreak      ASTRING('CheckPageBreak')
A:Reset               ASTRING('Reset')

WebDetailProperties   CLASS(WbControlHtmlProperties),TYPE,MODULE('WBREPORT.CLW'),DLL(_WebRunDllMode_),LINK('WBREPORT',_WebRunLinkMode_)
GetProperty             PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0),*IValue,DERIVED
GetSkeletonAttr         PROCEDURE(SIGNED WhichAttr),STRING,DERIVED
SetProperty             PROCEDURE(ASTRING name, STRING value),DERIVED
Init                    PROCEDURE(WbFileProperties Wbf, SIGNED feq,ProcessClass Process,SIGNED NextFeq, SIGNED PreviousFeq, STRING SkeletonFile)
Kill                    PROCEDURE
NextPage                PROCEDURE
PreviousPage            PROCEDURE
ChangePage              PROCEDURE

MaxRecordCount          SIGNED(30)
UseLineCounting         BYTE

AnyMore                 BYTE,PROTECTED
PageBreak               BYTE,PROTECTED
CurPage                 SIGNED
LastPage                SIGNED
NextFeq                 SIGNED,PROTECTED
PreviousFeq             SIGNED,PROTECTED
OldSuffix               ANY,PROTECTED
GlobalFiles             &WbFilesClass,PROTECTED
Process                 &ProcessClass,PROTECTED
SkeletonFile            &STRING,PRIVATE
WebFileAccess           &WbFileProperties,PRIVATE
                      END

  _EndOfInclude_
