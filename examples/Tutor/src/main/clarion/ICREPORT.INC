OMIT('_EndOfInclude_',_ICReportPresent_)
_ICReportPresent_ EQUATE(1)

  INCLUDE('ICCLIENT.INC')

WebReportClass       CLASS,TYPE,MODULE('ICREPORT.CLW'),LINK('ICREPORT',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
Init                   PROCEDURE(WebServerClass, HtmlClass, QUEUE PreviewQueue)
Kill                   PROCEDURE,VIRTUAL
Preview                PROCEDURE,VIRTUAL
SetNumPages            PROCEDURE(SIGNED NumPages=0),VIRTUAL

Q                      &QUEUE,PROTECTED
Server                 &WebServerClass
Html                   &HtmlClass
NumPages               SIGNED,PROTECTED
                     END

_EndOfInclude_
