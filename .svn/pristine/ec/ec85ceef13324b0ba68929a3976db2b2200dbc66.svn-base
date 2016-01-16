!ABCIncludeFile
OMIT('_EndOfInclude_',_vsaEPrnPresent_)
_vsaEPrnPresent_ EQUATE(1)

tPrinterQ           QUEUE,TYPE
ShowName              CSTRING(256)
PrinterName           CSTRING(256)
                    END

APIPrinterClass  CLASS,TYPE,MODULE('VSA_EPRN.CLW'),LINK('VSA_EPRN.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
DefaultPrinter          STRING(256)
PrinterQ                &tPrinterQ
Init                    PROCEDURE,VIRTUAL
Reset                   PROCEDURE,VIRTUAL
Kill                    PROCEDURE,VIRTUAL
GetPrinterList          PROCEDURE(*tPrinterQ PrinterQueue),LONG,PASCAL,PROC
GetDefaultPrinter       PROCEDURE(),STRING
GetDefaultPrinter       PROCEDURE(*CSTRING DefaultPrinter),LONG,PASCAL,PROC
                  END

_EndOfInclude_
