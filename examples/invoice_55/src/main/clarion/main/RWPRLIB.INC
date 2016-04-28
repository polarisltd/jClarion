! ReportWriter Print Engine DLL Interface

 OMIT('_End_RwEngineDllMode_Set',_RwEngineDllMode_Set)
_RwEngineDllMode      EQUATE(1)
_RwEngineDllMode_Set  EQUATE(1)
_End_RwEngineDllMode_Set

 OMIT('__EndOfInclude__',_ReportEnginePresent_)
_ReportEnginePresent_ EQUATE(1)


! Main Print Engine Class
ReportEngine      CLASS,TYPE,MODULE('RWPRLIB'),DLL(_RwEngineDllMode)

LoadReportLibrary   PROCEDURE(STRING txrname,<STRING password>),SIGNED,PROC,VIRTUAL
PrintReport         PROCEDURE(STRING rptname),SIGNED,PROC,VIRTUAL
UnloadReportLibrary PROCEDURE(),VIRTUAL

SetVariable         PROCEDURE(STRING varname,STRING value),VIRTUAL
SetPreview          PROCEDURE(SIGNED numpages=-1),VIRTUAL
SetPrinter          PROCEDURE(STRING printdef),VIRTUAL
SetPageRange        PROCEDURE(LONG frompage=-1,LONG topage=-1),VIRTUAL
SetNumberOfCopies   PROCEDURE(LONG numcopies),VIRTUAL
SetNextPageNumber   PROCEDURE(LONG pagenum),VIRTUAL
GetNextPageNumber   PROCEDURE(),LONG,VIRTUAL

!Print Preview and Run hook
PrintHook           PROCEDURE(),SIGNED,VIRTUAL

!Helper functions (called by PrintHook)
Reset               PROCEDURE(),LONG,VIRTUAL ! returns records to process
Next                PROCEDURE(),BYTE,VIRTUAL ! returns Level:Notify when finished
PrintAction         PROCEDURE(),VIRTUAL      ! called after next
EndReport           PROCEDURE(),VIRTUAL      ! call to close report

!Helper variables (set before entry to PrintHook)
ReportName          STRING(FILE:MaxFilePath)
Report              &WINDOW
View                &VIEW
PagesToPreview      LONG                    ! 0  = no preview
                                            ! -1 = all pages
!User file hook
AttachOpenFile      PROCEDURE(STRING label),*FILE,VIRTUAL
ResolveVariableFilename PROCEDURE(STRING vname,*STRING value),SIGNED,VIRTUAL
ReadReportLibrary   PROCEDURE(*CSTRING buffer,USHORT count),SHORT,VIRTUAL !returns amount read

!View Control (overrides TXR defaults)
SetReportFilter     PROCEDURE(STRING report,STRING filter)
SetReportOrder      PROCEDURE(STRING report,STRING order)

SetOpenMode         PROCEDURE(SIGNED mode)
GetOpenMode         PROCEDURE(),SIGNED

!Internal
Handle              LONG
Construct           PROCEDURE()
Destruct            PROCEDURE(),VIRTUAL
             END



__EndOfInclude__



