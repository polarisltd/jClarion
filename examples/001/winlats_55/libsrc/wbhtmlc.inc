
!ABCIncludeFile(WEB)

OMIT('_EndOfInclude_',_GridHtmlPresent_)
_GridHtmlPresent_ EQUATE(1)

  INCLUDE ('IBCBASE.INC'),ONCE
  INCLUDE ('ABLPROPR.INC'),ONCE
  INCLUDE ('ABLPROP.INT'),ONCE
  INCLUDE ('LAYBUILD.INT'),ONCE
  INCLUDE ('LAYVALUE.INT'),ONCE
  INCLUDE ('ABGRID.INC'),ONCE


ResponseQType QUEUE,TYPE
Record          SIGNED
Control         &CSTRING
Value           &CSTRING
Type            ResetType
EP              &IWbEventProcessor
              END


WbGridHtmlProperties CLASS(WbControlHtmlProperties),TYPE,MODULE('WBHTMLC.CLW'),DLL(_WebRunDllMode_),LINK('WBHTMLC',_WebRunLinkMode_)
Grid                 &GridClass,PRIVATE
Record               LONG,PRIVATE
ResponseQ            &ResponseQType,PRIVATE
Selected             SIGNED,PRIVATE
ViewOnly             CBOOL,PRIVATE
WebWindow            &WbWindowClass,PRIVATE

Construct            PROCEDURE
Destruct             PROCEDURE,DERIVED
AfterResponse        PROCEDURE,DERIVED
ClearResponseQ       PROCEDURE,PRIVATE
Init                 PROCEDURE(WbWindowClass WebWindow, GridClass Grid, SIGNED Feq, SIGNED Container=FEQ:Unknown)   !,EXTENDS
GetControlType       PROCEDURE(IControlToHtml Control),STRING,PRIVATE
GetPosition          PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>),DERIVED
GetProperty          PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr      PROCEDURE(SIGNED whichAttr),STRING,DERIVED
Select               PROCEDURE(SIGNED Choice)
SetProperty          PROCEDURE(ASTRING name, STRING value),DERIVED
TakeResponse         PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor),DERIVED
                   END


  _EndOfInclude_
