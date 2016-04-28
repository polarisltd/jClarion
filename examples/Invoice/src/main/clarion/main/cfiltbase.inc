!ABCIncludeFile

omit('End of include', _cFiltBasePresent_)
_cFiltBasePresent_        equate(1)

TColFilter      group, type
ColName           string(25)
ColName_SQL       &string
ColDataType       long
ColPicture        string(25)
CaseSensitive     byte
                end

TFilter         group, type
Column            string(25)
Operator          string(25)
Value             string(128)
Connection        string(25)
                end

TColFilterQ     queue(TColFilter), type
                end

TFilterQ        queue(TFilter), type
                end

TColOpe         group, type
OperatorUser      string(25)
Operator          string(100)
                end

TColOpeQ        queue(TColOpe), type
                end

TColOpeExcept   group, type
ColDataType       long
OperatorUser      string(25)
Operator          string(100)
                end

TColOpeExceptQ  queue(TColOpeExcept), type
                end

cFilterBase     class, type, module('cFiltbase.clw'), link('cFiltbase.clw', _ABCLinkMode_), DLL(_ABCDLLMode_)

FilterQ           &TFilterQ                 ! Queue holding all the filter conditions
ColFilterQ        &TColFilterQ              ! Queue holding cols that can be used in the Filter
ColOpeQRef        &TColOpeQ
ColOpeExQRef      &TColOpeExceptQ


!Save Query Data information  -----------
UserID            string(50)
AppID             string(50)
ProcID            string(50)
QueryName         string(50)
Saved             byte
IsNew             byte

UseSQL            byte                      ! Flag used to indicate for which file system (SQL or TPS/Clarion etc...) the filter string should be generated
CopyToCB          byte                      ! Flag that indicate if the filter string generated should be copied to the clipboard

!BackendType       long                      ! ID to identify for which backend the Filter string should be generated in regards with datetime conversion


SQLFilterStr      string(1024)   

Construct         procedure()
Destruct          procedure()

GenerateFilter    procedure(), byte, virtual
GenerateSet       procedure(string pValues, long pDatatype, <string pPicture>), string, virtual

ParseAndReplace   procedure(), string, virtual

Reset             procedure(), virtual
Save              procedure(string pQueryName), virtual
SaveAS            procedure(string pQueryName), virtual
SetCaseSensitive  procedure(byte pCase), virtual
Load              procedure(), long, proc, virtual

                end

    End of include

