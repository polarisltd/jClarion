
!ABCIncludeFile(SV)

OMIT('_EndOfInclude_',_CWADO_)
_CWADO_ EQUATE(1)

  include('svado.inc'),once
  include('svmapper.inc'), once
  include('ado_sql.int'), once  ! Interface definition for ADO_SQL access
  include('cFldPair.inc'), once


TRowInfoGrp         group, type
AbsolutePage          long
AbsolutePos           long
Bookmark              group(gVariant).
                    end

TErrorGrp           group, type
NativeError           long
Description           string(256)
                    end

TerrorQ             queue(TerrorGrp), type
                    end

TSupportGrp         group, type
adAddNew              short
adApproxPosition      short
adBookmark            short
adDelete              short
adFind                short
adHoldRecords         short
adIndex               short
adMovePrevious        short
adNotify              short
adResync              short
adSeek                short
adUpdate              short
adUpdateBatch         short
                    end



cCWAdo              class, implements(ADO_SQL), type, module('cwado.clw'),link('cwado.clw', _svLinkMode_),dll(_svDLLMode_)
Conn                  &CConnection
Rs                    &CRecordset
Mapper                &TableMapper

szUniqueTable         cstring(128)
szResyncCmd           cstring(1024)


FieldPair             &cFieldPair                               ! FieldPair class that will update row information (Bookmark, absolutepage etc..) in the
                                                                ! Data queue

AbsolutePage          long
AbsolutePos           long
vBookmark             group(gVariant).

SupportGrp            group(TSupportGrp).                       ! Group that contains what the Recordset can support

CursorLocation        long                                      ! Cursor location (adUseServer, adUseClient, etc...)
CursorType            long                                      ! Cursor type (adOpenDynamic, adOpenKeyset, adOpenStatic, adOpenForwardOnly)
LockType              long
Options               long
CacheSize             long
ExecOptions           long

szConnectStr          &cstring

PageCount             long                                      ! Nbr of page in recordset
PageSize              long                                      ! Nbr of record per page
CurrentPage           long                                      ! Page nbr currently on
CurPos                long

DataGrp               &group                                    ! Reference to the group structure representing the data
DataQueue             &queue

bOpen                 byte                                      ! Indicate that the RS object is open
MaxRecords            long

ErrorQ                &TerrorQ

szQuery               &cstring

szOrderByStr          &cstring

szSortstr             cstring(512)
szFilterStr           cstring(512)

Construct             procedure                                 ! Constructor
Close                 procedure(), virtual                      ! Destructor
Destruct              procedure
AddRowInfoQ           procedure(), virtual
ExecuteQuery          procedure(string sQuery), bool, virtual
Errors                procedure(), long
GetMaxRecords         procedure(), long, virtual
GetPage               procedure(), long, virtual
GetPosition           procedure(), long, virtual
GetRow                procedure(), long, proc, virtual
IsOpen                procedure(), bool, virtual
InitDataInfo          procedure(*TRowInfoGrp gInfoGrp), virtual
MapRSToGroup          procedure(), virtual
Map                   procedure(), virtual
Next                  procedure(), byte, virtual
Persist               procedure(string sFileName), virtual
PersistXML            procedure(string sXMLFileName), virtual
Previous              procedure(), byte, virtual
ReportErrors          procedure(<STRING sQuery>)
SetCacheSize          procedure(long pCacheSize), virtual
SetConnection         procedure(*CConnection pConn), virtual
SetConnection         procedure(*cstring szConnectStr), virtual
SetCursorLocation     procedure(long pCursorLocation), virtual
SetCursorType         procedure(long pCursorType), virtual
SetLockType           procedure(long pLockType), virtual
SetMaxRecords         procedure(long pMaxRecords), virtual
SetOptions            procedure(long pOptions), virtual
SetExecOptions        procedure(long pExecOptions), virtual
SetPageSize           procedure(long pPageSize), virtual
SetDataGroup          procedure(*group pGrp), virtual
SetDataGroup          procedure(*queue pQueue), virtual
SetorderBy            procedure(string sOrderBy), virtual
SetUniqueTable        procedure(), virtual
SetResyncCmd          procedure(), virtual
EOF                   procedure(),short,virtual
BOF                   procedure(),short,virtual
MoveFirst             procedure(), byte, virtual
MoveLast              procedure(), byte, virtual
UpdateSupportGrp      procedure()
AddFieldsInfo         procedure(string pTableName, string pColName, *? pTargetVar, short pDateTimeID)
AddFieldsInfo         procedure(string pTableName, *group pFileRecord)
                    end
                    

 _EndOfInclude_


