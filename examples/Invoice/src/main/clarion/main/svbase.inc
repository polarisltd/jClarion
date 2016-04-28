
!ABCIncludeFile(SV)

OMIT('_EndOfInclude_',_ADOBaseSupport_)
_ADOBaseSupport_ EQUATE(1)



!*
!* Includes
!*

  include('adoint.inc'),once

!*
!* Defines
!*

!*
!* Declarations
!*

CConnectionEvents   class(CCOMUserObject),implements(IConnectionEventsVt),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

QueryInterface        procedure(long riid, *long ppvObject),HRESULT,virtual

! Protected

InfoMessage           procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
BeginTransComplete    procedure(long TransactionLevel, *IError Error, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
CommitTransComplete   procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
RollbackTransComplete procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
WillExecute           procedure(*long bstrSource, *long CursorType, *long LockType, *long Options, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection),HRESULT,virtual,protected
ExecuteComplete       procedure(long RecordsAffected, *IError Error, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection),HRESULT,virtual,protected
WillConnect           procedure(*long bstrConnectionString, *long bstrUserID, *long bstrPassword, *long Options, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
ConnectComplete       procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,virtual,protected
Disconnect            procedure(*long adStatus, *_IConnection Connection),HRESULT,virtual,protected

                    end


CRecordsetEvents    class(CCOMUserObject),implements(IRecordsetEventsVt),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

QueryInterface        procedure(long riid, *long ppvObject),HRESULT,virtual

! Protected

WillChangeField       procedure(long dwFields, variant vtFields, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
FieldChangeComplete   procedure(long dwFields, variant vtFields, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
WillChangeRecord      procedure(long adReason, long dwRecords, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
RecordChangeComplete  procedure(long adReason, long dwRecords, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
WillChangeRecordset   procedure(long adReason, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
RecordsetChangeComplete procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
WillMove              procedure(long adReason, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
MoveComplete          procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
EndOfRecordset        procedure(*long pfMoreData, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
FetchProgress         procedure(long Progress, long MaxProgress, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected
FetchComplete         procedure(*IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,virtual,protected

                    end


CADO                class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived


GetProperties         procedure(*long hr),*CProperties

! Protected

IADOInt               &IADO,protected

                    end


CCollection         class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetCount              procedure(*long Count),HRESULT
NewEnum               procedure(*long pvObject),HRESULT
Refresh               procedure,HRESULT

! Protected

ICol                  &ICollection,protected

                    end


CDynaCollection     class(CCollection),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

_Append               procedure(*IDispatch Object),HRESULT
Delete                procedure(gVariant vtIndex),HRESULT

! Protected

IDynCol               &IDynaCollection,protected

                    end


CError              class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived
Number                procedure(*long lErr),HRESULT
Source                procedure(*long hr),*CStr
Description           procedure(*long hr),*CStr
HelpFile              procedure(*long hr),*CStr
HelpContext           procedure(*long lHCtxt),HRESULT
SQLState              procedure(*string s), HRESULT
NativeError           procedure(*long lErr),HRESULT

! Protected

IErr                  &IError,protected

                    end


CErrors             class(CCollection),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,derived
Error                 procedure(long dwIndex, *long hr),*CError
ClearError            procedure,HRESULT

! Protected

IErrs                 &IErrors,protected

                    end


CProperty           class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,derived
GetValue          procedure(*gVariant vtValue), HRESULT, pascal
PutValue              procedure(gvariant vtValue),HRESULT,pascal
GetName               procedure(*bstring pBstr),HRESULT,pascal
GetType               procedure(*long ptype),HRESULT,pascal
GetAttributes         procedure(*long lAttributes),HRESULT,pascal
PutAttributes         procedure(long lAttributes),HRESULT,pascal

! Protected

IProp                 &IProperty,protected

                    end


CProperties         class(CCollection),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,derived
GetItem               procedure(long dwIndex, *long hr),*CProperty
GetItem               procedure(*cstring scName, *long hr), *CProperty
GetItem               procedure(*string sName, *long hr), *CProperty

! Protected

IProps                &_IProperties,protected

                    end


CCommand15          class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,HRESULT,virtual

GetActiveConnection   procedure(*long hr),*CConnection
PutRefActiveConnection procedure(*CConnection Conn),HRESULT
PutActiveConnection   procedure(*gVariant vtppvObject),HRESULT
GetCommandText        procedure(*long hr), bstring !*CStr
PutCommandText        procedure(*cstring szCmdText),HRESULT
PutCommandText        procedure(string sCmdText), HRESULT
GetCommandTimeout     procedure(*long lTimeout),HRESULT
PutCommandTimeout     procedure(long lTimeout),HRESULT
GetPrepared           procedure(*short fPrepared),HRESULT
PutPrepared           procedure(short fPrepared),HRESULT
_Execute              procedure(*long vtRecordsAffected , *gVariant vtParameters , long Options, *long hr),*CRecordSet
_Execute              procedure(<*long RecordsAffected>, *long hr), *CRecordSet, proc
CreateParameter       procedure(*cstring szName, long dwType, long dwDirection, long dwSize, gvariant vtValue, *long hr), *CParameter
!GetParameters         procedure(*long ppvObject),HRESULT
GetParameters         procedure(*long  hr), *CParameters
PutCommandType        procedure(long lCmdType),HRESULT
GetCommandType        procedure(*long lCmdType),HRESULT
GetName               procedure(*long hr), bstring!*CStr
PutName               procedure(*cstring szName),HRESULT

! Protected

ICmd15                &ICommand15,protected
bInitialised          byte,protected

                    end


CCommand            class(CCommand15),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,HRESULT,derived

GetState              procedure(*long lObjState),HRESULT
Cancel                procedure,HRESULT

! Protected

ICmd                  &ICommand,protected

                    end


CField15            class(CADO),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetActualSize         procedure(*long pl), HRESULT
GetAttributes         procedure(*long pl), HRESULT
GetDefinedSize        procedure(*long pl), HRESULT
GetName               procedure(*cstring szName), HRESULT
GetType           procedure(*long pDataType), HRESULT
!get_Type                      procedure(*long pDataType),HRESULT,pascal
!get_Value                     procedure(*long pvtVar),HRESULT,pascal
!put_Value                     procedure(variant pvar),HRESULT,pascal
!get_Precision                 procedure(*byte pbPrecision),HRESULT,pascal
!get_NumericScale              procedure(*byte pbNumericScale),HRESULT,pascal
!raw_AppendChunk               procedure(variant vtData),HRESULT,pascal
!raw_GetChunk                  procedure(long dwLength, *long pvtVar),HRESULT,pascal
!get_OriginalValue             procedure(*long pvtVar),HRESULT,pascal
!get_UnderlyingValue           procedure(*long pvtVar),HRESULT,pascal

! Protected

IFld15                &IField15,protected

                    end


CField20            class(CADO),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetActualSize         procedure(*long l),HRESULT
GetAttributes         procedure(*long l),HRESULT
GetDefinedSize        procedure(*long l),HRESULT
GetName               procedure(*long hr),*CStr
GetName               procedure(*bstring bName), HRESULT
GetType               procedure(*long DataType),HRESULT
GetValue              procedure(*gVariant vtVar),HRESULT
!GetValue              procedure(long vVar), HRESULT
PutValue              procedure(gVariant vtVar),HRESULT
GetPrecision          procedure(*byte bPrecision),HRESULT
GetNumericScale       procedure(*byte bNumericScale),HRESULT
AppendChunk           procedure(*gVariant vtData),HRESULT
GetChunk              procedure(long Length, *tVariant vtVar),HRESULT
GetOriginalValue      procedure(*gVariant vtVar),HRESULT
GetUnderlyingValue    procedure(*gVariant vtVar),HRESULT
GetDataFormat         procedure(*long ppiDF),HRESULT
PutRefDataFormat      procedure(long ppiDF),HRESULT
PutPrecision          procedure(byte bPrecision),HRESULT
PutNumericScale       procedure(byte bNumericScale),HRESULT
PutType               procedure(long DataType),HRESULT
PutDefinedSize        procedure(long l),HRESULT
PutAttributes         procedure(long l),HRESULT

! Protected

IFld20                &IField20,protected

                    end


CField              class(CField20),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

Construct             procedure
Destruct              procedure,virtual

GetStatus             procedure(*long FStatus),HRESULT

! Protected

IFld                  &IField,protected

                    end


CFields15           class(CCollection),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetItem               procedure(gVariant vtIndex, *long hr),*CField

! Protected

IFlds15               &IFields15,protected

                    end


CFields20           class(CFields15),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

_Append               procedure(*cstring szName, long dwType, long DefinedSize, long Attrib),HRESULT
Delete                procedure(gVariant vtIndex),HRESULT

! Protected

IFlds20               &IFields20,protected

                    end


CFields             class(CFields20),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetField              procedure(long dwIndex, *long hr, long bFetchProperties = false),*CField,virtual
GetField          procedure(*cstring pName, *long hr, long bFetchProperties = false), *CField, virtual
GetField          procedure(*string pName, *long hr, long bFetchProperties = false), *CField, virtual
AppendFld             procedure(*cstring szName, long dwType, long DefinedSize, long Attrib, *gVariant vtValue),HRESULT
Update                procedure,HRESULT
Resync                procedure(long ResyncValues),HRESULT
CancelUpdate          procedure,HRESULT

! Protected

IFlds                 &IFields,protected

                    end


CRecordSet15        class(CADO),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,HRESULT,virtual
Init                  procedure(CRecordsetEvents RstEvts),HRESULT,virtual
Init                  procedure(CRecordsetEvents RstEvts, *cstring szSource, long LockType, long CursorType),HRESULT,virtual
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

Open                  procedure(long CursorType, long LockType, long Options),HRESULT

GetAbsolutePosition   procedure(*long lPos),HRESULT
PutAbsolutePosition   procedure(long lPos),HRESULT, virtual
PutRefActiveConn      procedure(*IDispatch pConn),HRESULT
PutActiveConnection   procedure(*gVariant vtVar),HRESULT
GetActiveConnection   procedure(*gVariant vtVar),HRESULT
GetBOF                procedure(*short b),HRESULT
GetBookmark           procedure(*gVariant vtBookmark),HRESULT
PutBookmark           procedure(*gVariant vtBookmark),HRESULT, virtual
GetCacheSize          procedure(*long l),HRESULT
PutCacheSize          procedure(long l),HRESULT
GetCursorType         procedure(*long lCursorType),HRESULT
PutCursorType         procedure(long lCursorType),HRESULT
GetEOF                procedure(*short b),HRESULT
GetFields             procedure(*long hr),*CFields,virtual
GetLockType           procedure(*long lLockType),HRESULT
PutLockType           procedure(long lLockType),HRESULT
GetMaxRecords         procedure(*long lMaxRecords),HRESULT
PutMaxRecords         procedure(long lMaxRecords),HRESULT
GetRecordCount        procedure(*long lRecCount),HRESULT,proc
PutRefSource          procedure(*IDispatch pvSource),HRESULT
PutSource             procedure(*cstring szSource),HRESULT
GetSource             procedure(*gVariant vtSource),HRESULT
AddNew                procedure(*gVariant vtFieldlist, *gVariant vtValues),HRESULT
AddNew            procedure(), HRESULT
CancelUpdate          procedure,HRESULT
Close                 procedure,HRESULT,proc
Delete                procedure(long AffectRecords),HRESULT
GetRows               procedure(long Rows, gVariant vtStart, gVariant vtFields, *gVariant vtVar),HRESULT
Move                  procedure(long NumRecords, *gVariant vtStart),HRESULT, virtual
MoveNext              procedure,HRESULT, virtual
MovePrevious          procedure,HRESULT, virtual
MoveFirst             procedure,HRESULT, virtual
MoveLast              procedure,HRESULT, virtual
Open                  procedure(*cstring szSource, *CConnection Conn, long CursorType, long LockType, long Options),virtual, HRESULT
Open                  procedure(*cstring szSource, *cstring szConnection, long CursorType, long LockType, long Options), virtual, HRESULT
Requery               procedure(long Options),HRESULT
xResync               procedure(long AffectRecords),HRESULT
Update                procedure(*gVariant vtFields, *gVariant vtValues),HRESULT
Update            procedure(), HRESULT
GetAbsolutePage       procedure(*long l),HRESULT
PutAbsolutePage       procedure(long l),HRESULT
GetEditMode           procedure(*long l),HRESULT
GetFilter             procedure(*gVariant vtCriteria),HRESULT
PutFilter             procedure(*gVariant vtCriteria),HRESULT, virtual
GetPageCount          procedure(*long l),HRESULT
GetPageSize           procedure(*long l),HRESULT
PutPageSize           procedure(long l),HRESULT
GetSort               procedure(*long hr),*CStr
PutSort               procedure(*cstring szCriteria),HRESULT, virtual
GetStatus             procedure(*long l),HRESULT
GetState              procedure(*long lObjState),HRESULT
_xClone               procedure(*long ppvObject),HRESULT
UpdateBatch           procedure(long AffectRecords),HRESULT
UpdateBatch       procedure(), HRESULT
CancelBatch           procedure(long AffectRecords),HRESULT
GetCursorLocation     procedure(*long lCursorLoc),HRESULT
PutCursorLocation     procedure(long lCursorLoc),HRESULT
NextRecordset         procedure(*gVariant vtRecordsAffected, *long ppiRs),HRESULT
Supports              procedure(long CursorOptions, *short b),HRESULT
GetCollect            procedure(*gVariant vtIndex, *gVariant vtVar),HRESULT
PutCollect            procedure(gVariant vtIndex, gVariant vtVar),HRESULT
GetMarshalOptions     procedure(*long eMarshal),HRESULT
PutMarshalOptions     procedure(long eMarshal),HRESULT
Find                  procedure(*cstring szCriteria, long SkipRecords, long SearchDirection, *gVariant vtStart),HRESULT, virtual
Find                  procedure(string strCriteria), HRESULT, virtual

! Protected

IRst15                &_IRecordset15,protected
EvtHndlr              &CRecordsetEvents,protected
dwRstEvtCookie        long,protected
bInitialised          byte,protected

                    end


CRecordSet20        class(CRecordSet15),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,HRESULT,virtual
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

Cancel                procedure,HRESULT
GetDataSource         procedure(*long punkDataSource),HRESULT
PutRefDataSource      procedure(*IUnknown unkDataSource),HRESULT
_xSave                procedure(*cstring szFileName, long PersistFormat),HRESULT
GetActiveCommand      procedure(*long pCmd),HRESULT
PutStayInSync         procedure(long bStayInSync),HRESULT
GetStayInSync         procedure(*long bStayInSync),HRESULT

GetString             procedure(long StringFormat, long NumRows, bstring bstrColumnDelimeter, bstring bstrRowDelimeter, bstring bstrNullExpr, *bstring bstrRetString),HRESULT,pascal
GetDataMember         procedure(*bstring bstrDataMember),HRESULT,pascal
PutDataMember         procedure(bstring bstrDataMember),HRESULT,pascal
CompareBookmarks      procedure(gVariant vtBookmark1, gVariant vtBookmark2, *long Compare),HRESULT,pascal

Clone                 procedure(long LockType, *long ppvObject),HRESULT
Resync                procedure(long AffectRecords, long ResyncValues),HRESULT

! Protected

IRst20                &_IRecordset20,protected

                    end


CRecordSet21        class(CRecordSet20),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Init                  procedure,HRESULT,virtual
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived
Seek                  procedure(*gVariant vtKeyValues, long SeekOption),HRESULT
PutIndex              procedure(bstring bstrIndex),HRESULT
GetIndex              procedure(*bstring bstrIndex),HRESULT

! Protected

IRst21                &_IRecordset21,protected

                    end


CRecordSet          class(CRecordSet21),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived


Init                  procedure,HRESULT,virtual

Save                  procedure(gVariant vtDestination, long PersistFormat),HRESULT

! Protected

IRst                  &_IRecordset,protected

                    end


CConnection         class(CCOMObject),type,module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual
Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

Init                  procedure,HRESULT,virtual
Init                  procedure(*CConnectionEvents ConnEvts),HRESULT,virtual
Connect               procedure(*cstring szConnectStr, *cstring szUID, *cstring szPWD),HRESULT
Connect               procedure(*cstring szConnectStr), HRESULT
Connect               procedure(string sConnectStr), HRESULT
Disconnect            procedure,HRESULT,proc
Query                 procedure(*cstring szCommandText, *long dwRecordsAffected, long Options, *long hrOut),*CRecordSet,PROC
GetConnection         procedure,*_IConnection
Version               procedure(*long hr),*cstring
BeginTrans            procedure(long pTransactionLevel),HRESULT
CommitTrans           procedure,HRESULT
RollbackTrans         procedure,HRESULT
Errors                procedure(*long hr),*CErrors
Properties            procedure(*long hr),*CProperties
IsolationLevel        PROCEDURE( <LONG lIsolationLevel> ), LONG,PROC
GetCursorLocation     procedure(*long pCursorLocation), HRESULT
PutCursorLocation     procedure(long pCursorLocation), HRESULT

PutConnectionTimeOut  procedure(long pTimeOut), HRESULT
PutCommandTimeOut     procedure(long pTimeOut), HRESULT

Close                 procedure,HRESULT,proc
_Execute              procedure(*cstring szCommandText, *long RecordsAffected, long Options, *long hr),*CRecordSet
_Execute              procedure(string sCommandText, *long RecordsAffected, long Options, *long hr),*CRecordSet
Open                  procedure(<*cstring szConnectStr>, <*cstring szUserID>, <*cstring szPassword>, <long Options>),HRESULT
State                 procedure(*long lObjState),HRESULT
OpenSchema            procedure(long Schema, *long hr), *CRecordset
OpenSchema            procedure(long Schema, *gVariant gCriteria, *long hr), *CRecordset

! Protected

CreateEventHandler    procedure(*long pUnk),HRESULT,protected

pConn                 &_IConnection,protected
EvtHndlr              &CConnectionEvents,protected
dwConnEvtCookie       long,protected
bInitialised          byte,protected
bConnected            byte,protected

                    end
                    

CParameter          class(CADO), type, module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure, virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

Init                  procedure(), HRESULT, virtual
GetName               procedure(*long hr), *cstring
PutName               procedure(*cstring pName), HRESULT
GetValue              procedure(*gVariant pvtVar), HResULT
PutValue              procedure(gVariant vtVar), HRESULT
GetType               procedure(*long psDataType), HRESULT
PutType               procedure(long psDatatype), HRESULT
PutDirection          procedure(long lParamDirection),HRESULT
GetDirection          procedure(*long lParamDirection),HRESULT
PutPrecision          procedure(long bPrecision),HRESULT
GetPrecision          procedure(*long pbPrecision),HRESULT
PutNumericScale       procedure(long bScale),HRESULT
GetNumericScale       procedure(*long pbScale),HRESULT
PutSize               procedure(long lSize),HRESULT
GetSize               procedure(*long plSize),HRESULT
AppendChunk           procedure(gVariant vtVal),HRESULT
GetAttributes         procedure(*long plParmAttribs),HRESULT
PutAttributes         procedure(long lParmAttribs),HRESULT

! protected

IParam                &IParameter, protected

                    end
                    
                    
CParameters         class(CDynaCollection), type, module('svbase.clw'),link('svbase.clw', _svLinkMode_),dll(_svDllMode_)

Construct         procedure
Destruct              procedure, virtual


Attach            procedure(long pUnk, byte fPreInstantiated = false),HRESULT,proc,derived

GetItem               procedure(gVariant vIndex, *long hr), *CParameter

! protected

IParams               &IParameters, protected

            end
            
            
            
            

  _EndOfInclude_

