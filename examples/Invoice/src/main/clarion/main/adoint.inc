
  omit('EndDefine',_ADOInterfaces_)
_ADOInterfaces_  equate(1)



!*
!* Includes
!*

  include('svcom.inc'),once

!*
!* Defines
!*

!*
!* Declarations
!*

! Clarion source equivalent of Win32 type library msado15.dll


_Collection             group
Data1                     long(0512h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_DynaCollection         group
Data1                     long(0513h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_ADO                    group
Data1                     long(0534h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Properties             group
Data1                     long(0504h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Property               group
Data1                     long(0503h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Error                  group
Data1                     long(0500h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Errors                 group
Data1                     long(0501h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

Command15               group
Data1                     long(0508h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Connection             group
Data1                     long(0550h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Connection15           group
Data1                     long(0515h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Recordset              group
Data1                     long(0556h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Recordset21            group
Data1                     long(0555h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Recordset20            group
Data1                     long(054fh)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Recordset15            group
Data1                     long(050eh)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Fields                 group
Data1                     long(0564h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Fields20               group
Data1                     long(054dh)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

Fields15                group
Data1                     long(0506h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Field                  group
Data1                     long(0569h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Field20                group
Data1                     long(054ch)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Parameter              group
Data1                     long(050ch)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

Parameters              group
Data1                     long(050dh)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Command                group
Data1                     long(054eh)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ConnectionEventsVt      group
Data1                     long(0402h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end
                        
RecordsetEventsVt       group
Data1                     long(0403h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_ConnectionEvents       group
Data1                     long(0400h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_RecordsetEvents        group
Data1                     long(0266h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ADOConnectionConstruction15 group
Data1                     long(0516h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ADOConnectionConstruction group
Data1                     long(0551h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_Record                 group
Data1                     long(0562h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

RecFields               group
Data1                     long(0563h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

_ADOStream              group
Data1                     long(0565h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ADOStreamConstruction   group
Data1                     long(0568h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ADOCommandConstruction  group
Data1                     long(0517h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

ADORecordsetConstruction group
Data1                     long(0283h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

Field15                 group
Data1                     long(0505h)
Data2                     short(0)
Data3                     short(010h)
Data4                     string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                        end

!//
!// Type library items
!//

CursorTypeEnum          itemize
adOpenUnspecified         equate(-1)
adOpenForwardOnly         equate(0)
adOpenKeyset              equate(1)
adOpenDynamic             equate(2)
adOpenStatic              equate(3)
                        end

CursorOptionEnum        itemize
adHoldRecords             equate(256)
adMovePrevious            equate(512)
adAddNew                  equate(16778240)
adDelete                  equate(16779264)
adUpdate                  equate(16809984)
adBookmark                equate(8192)
adApproxPosition          equate(16384)
adUpdateBatch             equate(65536)
adResync                  equate(131072)
adNotify                  equate(262144)
adFind                    equate(524288)
adSeek                    equate(4194304)
adIndex                   equate(8388608)
                        end

LockTypeEnum            itemize
adLockUnspecified         equate(-1)
adLockReadOnly            equate(1)
adLockPessimistic         equate(2)
adLockOptimistic          equate(3)
adLockBatchOptimistic     equate(4)
                        end

ExecuteOptionEnum       itemize
adOptionUnspecified       equate(-1)
adAsyncExecute            equate(16)
adAsyncFetch              equate(32)
adAsyncFetchNonBlocking   equate(64)
adExecuteNoRecords        equate(128)
                        end

ConnectOptionEnum       itemize
adConnectUnspecified      equate(-1)
adAsyncConnect            equate(16)
                        end

ObjectStateEnum         itemize
adStateClosed             equate(0)
adStateOpen               equate(1)
adStateConnecting         equate(2)
adStateExecuting          equate(4)
adStateFetching           equate(8)
                        end

CursorLocationEnum      itemize
adUseNone                 equate(1)
adUseServer               equate(2)
adUseClient               equate(3)
adUseClientBatch          equate(3)
                        end

DataTypeEnum            itemize
adEmpty                   equate(0)
adTinyInt                 equate(16)
adSmallInt                equate(2)
adInteger                 equate(3)
adBigInt                  equate(20)
adUnsignedTinyInt         equate(17)
adUnsignedSmallInt        equate(18)
adUnsignedInt             equate(19)
adUnsignedBigInt          equate(21)
adSingle                  equate(4)
adDouble                  equate(5)
adCurrency                equate(6)
adDecimal                 equate(14)
adNumeric                 equate(131)
adBoolean                 equate(11)
adError                   equate(10)
adUserDefined             equate(132)
adVariant                 equate(12)
adIDispatch               equate(9)
adIUnknown                equate(13)
adGUID                    equate(72)
adDate                    equate(7)
adDBDate                  equate(133)
adDBTime                  equate(134)
adDBTimeStamp             equate(135)
adBSTR                    equate(8)
adChar                    equate(129)
adVarChar                 equate(200)
adLongVarChar             equate(201)
adWChar                   equate(130)
adVarWChar                equate(202)
adLongVarWChar            equate(203)
adBinary                  equate(128)
adVarBinary               equate(204)
adLongVarBinary           equate(205)
adChapter                 equate(136)
adFileTime                equate(64)
adPropVariant             equate(138)
adVarNumeric              equate(139)
adArray                   equate(8192)
                        end

FieldAttributeEnum      itemize
adFldUnspecified          equate(-1)
adFldMayDefer             equate(2)
adFldUpdatable            equate(4)
adFldUnknownUpdatable     equate(8)
adFldFixed                equate(16)
adFldIsNullable           equate(32)
adFldMayBeNull            equate(64)
adFldLong                 equate(128)
adFldRowID                equate(256)
adFldRowVersion           equate(512)
adFldCacheDeferred        equate(4096)
adFldIsChapter            equate(8192)
adFldNegativeScale        equate(16384)
adFldKeyColumn            equate(32768)
adFldIsRowURL             equate(65536)
adFldIsDefaultStream      equate(131072)
adFldIsCollection         equate(262144)
                        end

EditModeEnum            itemize
adEditNone                equate(0)
adEditInProgress          equate(1)
adEditAdd                 equate(2)
adEditDelete              equate(4)
                        end

RecordStatusEnum        itemize
adRecOK                   equate(0)
adRecNew                  equate(1)
adRecModified             equate(2)
adRecDeleted              equate(4)
adRecUnmodified           equate(8)
adRecInvalid              equate(16)
adRecMultipleChanges      equate(64)
adRecPendingChanges       equate(128)
adRecCanceled             equate(256)
adRecCantRelease          equate(1024)
adRecConcurrencyViolation equate(2048)
adRecIntegrityViolation   equate(4096)
adRecMaxChangesExceeded   equate(8192)
adRecObjectOpen           equate(16384)
adRecOutOfMemory          equate(32768)
adRecPermissionDenied     equate(65536)
adRecSchemaViolation      equate(131072)
adRecDBDeleted            equate(262144)
                        end

GetRowsOptionEnum       itemize
adGetRowsRest             equate(-1)
                        end

PositionEnum            itemize
adPosUnknown              equate(-1)
adPosBOF                  equate(-2)
adPosEOF                  equate(-3)
                        end

BookmarkEnum            itemize
adBookmarkCurrent         equate(0)
adBookmarkFirst           equate(1)
adBookmarkLast            equate(2)
                        end

MarshalOptionsEnum      itemize
adMarshalAll              equate(0)
adMarshalModifiedOnly     equate(1)
                        end

AffectEnum              itemize
adAffectCurrent           equate(1)
adAffectGroup             equate(2)
adAffectAll               equate(3)
adAffectAllChapters       equate(4)
                        end

ResyncEnum              itemize
adResyncUnderlyingValues  equate(1)
adResyncAllValues         equate(2)
                        end

CompareEnum             itemize
adCompareLessThan         equate(0)
adCompareEqual            equate(1)
adCompareGreaterThan      equate(2)
adCompareNotEqual         equate(3)
adCompareNotComparable    equate(4)
                        end

FilterGroupEnum         itemize
adFilterNone              equate(0)
adFilterPendingRecords    equate(1)
adFilterAffectedRecords   equate(2)
adFilterFetchedRecords    equate(3)
adFilterPredicate         equate(4)
adFilterConflictingRecords equate(5)
                        end

SearchDirectionEnum     itemize
adSearchForward           equate(1)
adSearchBackward          equate(-1)
                        end

PersistFormatEnum       itemize
adPersistADTG             equate(0)
adPersistXML              equate(1)
                        end

StringFormatEnum        itemize
adClipString              equate(2)
                        end

ConnectPromptEnum       itemize
adPromptAlways            equate(1)
adPromptComplete          equate(2)
adPromptCompleteRequired  equate(3)
adPromptNever             equate(4)
                        end

ConnectModeEnum         itemize
adModeUnknown             equate(0)
adModeRead                equate(1)
adModeWrite               equate(2)
adModeReadWrite           equate(3)
adModeShareDenyRead       equate(4)
adModeShareDenyWrite      equate(8)
adModeShareExclusive      equate(12)
adModeShareDenyNone       equate(16)
adModeRecursive           equate(4194304)
                        end

RecordCreateOptionsEnum itemize
adCreateCollection        equate(8192)
adCreateStructDoc         equate(0FFFFFFFF80000000h)    !-2147483648
adCreateNonCollection     equate(0)
adOpenIfExists            equate(33554432)
adCreateOverwrite         equate(67108864)
adFailIfNotExists         equate(-1)
                        end

RecordOpenOptionsEnum   itemize
adOpenRecordUnspecified   equate(-1)
adOpenSource              equate(8388608)
adOpenAsync               equate(4096)
adDelayFetchStream        equate(16384)
adDelayFetchFields        equate(32768)
                        end

IsolationLevelEnum      itemize
adXactUnspecified         equate(-1)
adXactChaos               equate(16)
adXactReadUncommitted     equate(256)
adXactBrowse              equate(256)
adXactCursorStability     equate(4096)
adXactReadCommitted       equate(4096)
adXactRepeatableRead      equate(65536)
adXactSerializable        equate(1048576)
adXactIsolated            equate(1048576)
                        end

XactAttributeEnum       itemize
adXactCommitRetaining     equate(131072)
adXactAbortRetaining      equate(262144)
adXactAsyncPhaseOne       equate(524288)
adXactSyncPhaseOne        equate(1048576)
                        end

PropertyAttributesEnum  itemize
adPropNotSupported        equate(0)
adPropRequired            equate(1)
adPropOptional            equate(2)
adPropRead                equate(512)
adPropWrite               equate(1024)
                        end

ErrorValueEnum          itemize
adErrProviderFailed       equate(3000)
adErrInvalidArgument      equate(3001)
adErrOpeningFile          equate(3002)
adErrReadFile             equate(3003)
adErrWriteFile            equate(3004)
adErrNoCurrentRecord      equate(3021)
adErrIllegalOperation     equate(3219)
adErrCantChangeProvider   equate(3220)
adErrInTransaction        equate(3246)
adErrFeatureNotAvailable  equate(3251)
adErrItemNotFound         equate(3265)
adErrObjectInCollection   equate(3367)
adErrObjectNotSet         equate(3420)
adErrDataConversion       equate(3421)
adErrObjectClosed         equate(3704)
adErrObjectOpen           equate(3705)
adErrProviderNotFound     equate(3706)
adErrBoundToCommand       equate(3707)
adErrInvalidParamInfo     equate(3708)
adErrInvalidConnection    equate(3709)
adErrNotReentrant         equate(3710)
adErrStillExecuting       equate(3711)
adErrOperationCancelled   equate(3712)
adErrStillConnecting      equate(3713)
adErrInvalidTransaction   equate(3714)
adErrNotExecuting         equate(3715)
adErrUnsafeOperation      equate(3716)
adwrnSecurityDialog       equate(3717)
adwrnSecurityDialogHeader equate(3718)
adErrIntegrityViolation   equate(3719)
adErrPermissionDenied     equate(3720)
adErrDataOverflow         equate(3721)
adErrSchemaViolation      equate(3722)
adErrSignMismatch         equate(3723)
adErrCantConvertvalue     equate(3724)
adErrCantCreate           equate(3725)
adErrColumnNotOnThisRow   equate(3726)
adErrURLDoesNotExist      equate(3727)
adErrTreePermissionDenied equate(3728)
adErrInvalidURL           equate(3729)
adErrResourceLocked       equate(3730)
adErrResourceExists       equate(3731)
adErrCannotComplete       equate(3732)
adErrVolumeNotFound       equate(3733)
adErrOutOfSpace           equate(3734)
adErrResourceOutOfScope   equate(3735)
adErrUnavailable          equate(3736)
adErrURLNamedRowDoesNotExist equate(3737)
adErrDelResOutOfScope     equate(3738)
adErrPropInvalidColumn    equate(3739)
adErrPropInvalidOption    equate(3740)
adErrPropInvalidValue     equate(3741)
adErrPropConflicting      equate(3742)
adErrPropNotAllSettable   equate(3743)
adErrPropNotSet           equate(3744)
adErrPropNotSettable      equate(3745)
adErrPropNotSupported     equate(3746)
adErrCatalogNotSet        equate(3747)
adErrCantChangeConnection equate(3748)
adErrFieldsUpdateFailed   equate(3749)
adErrDenyNotSupported     equate(3750)
adErrDenyTypeNotSupported equate(3751)
                        end

ParameterAttributesEnum     itemize
adParamSigned                 equate(16)
adParamNullable               equate(64)
adParamLong                   equate(128)
                            end

ParameterDirectionEnum      itemize
adParamUnknown                equate(0)
adParamInput                  equate(1)
adParamOutput                 equate(2)
adParamInputOutput            equate(3)
adParamReturnValue            equate(4)
                            end

CommandTypeEnum             itemize
adCmdUnspecified              equate(-1)
adCmdUnknown                  equate(8)
adCmdText                     equate(1)
adCmdTable                    equate(2)
adCmdStoredProc               equate(4)
adCmdFile                     equate(256)
adCmdTableDirect              equate(512)
                            end

EventStatusEnum             itemize
adStatusOK                    equate
adStatusErrorsOccurred        equate
adStatusCantDeny              equate
adStatusCancel                equate
adStatusUnwantedEvent         equate
                            end

EventReasonEnum             itemize
adRsnAddNew                   equate(1)
adRsnDelete                   equate(2)
adRsnUpdate                   equate(3)
adRsnUndoUpdate               equate(4)
adRsnUndoAddNew               equate(5)
adRsnUndoDelete               equate(6)
adRsnRequery                  equate(7)
adRsnResynch                  equate(8)
adRsnClose                    equate(9)
adRsnMove                     equate(10)
adRsnFirstChange              equate(11)
adRsnMoveFirst                equate(12)
adRsnMoveNext                 equate(13)
adRsnMovePrevious             equate(14)
adRsnMoveLast                 equate(15)
                            end

SchemaEnum                  itemize
adSchemaProviderSpecific      equate(-1)
adSchemaAsserts               equate(0)
adSchemaCatalogs              equate(1)
adSchemaCharacterSets         equate(2)
adSchemaCollations            equate(3)
adSchemaColumns               equate(4)
adSchemaCheckConstraints      equate(5)
adSchemaConstraintColumnUsage equate(6)
adSchemaConstraintTableUsage  equate(7)
adSchemaKeyColumnUsage        equate(8)
adSchemaReferentialContraints equate(9)
adSchemaReferentialConstraints equate(9)
adSchemaTableConstraints      equate(10)
adSchemaColumnsDomainUsage    equate(11)
adSchemaIndexes               equate(12)
adSchemaColumnPrivileges      equate(13)
adSchemaTablePrivileges       equate(14)
adSchemaUsagePrivileges       equate(15)
adSchemaProcedures            equate(16)
adSchemaSchemata              equate(17)
adSchemaSQLLanguages          equate(18)
adSchemaStatistics            equate(19)
adSchemaTables                equate(20)
adSchemaTranslations          equate(21)
adSchemaProviderTypes         equate(22)
adSchemaViews                 equate(23)
adSchemaViewColumnUsage       equate(24)
adSchemaViewTableUsage        equate(25)
adSchemaProcedureParameters   equate(26)
adSchemaForeignKeys           equate(27)
adSchemaPrimaryKeys           equate(28)
adSchemaProcedureColumns      equate(29)
adSchemaDBInfoKeywords        equate(30)
adSchemaDBInfoLiterals        equate(31)
adSchemaCubes                 equate(32)
adSchemaDimensions            equate(33)
adSchemaHierarchies           equate(34)
adSchemaLevels                equate(35)
adSchemaMeasures              equate(36)
adSchemaProperties            equate(37)
adSchemaMembers               equate(38)
adSchemaTrustees              equate(39)
                            end

FieldStatusEnum             itemize
adFieldOK                     equate(0)
adFieldCantConvertValue       equate(2)
adFieldIsNull                 equate(3)
adFieldTruncated              equate(4)
adFieldSignMismatch           equate(5)
adFieldDataOverflow           equate(6)
adFieldCantCreate             equate(7)
adFieldUnavailable            equate(8)
adFieldPermissionDenied       equate(9)
adFieldIntegrityViolation     equate(10)
adFieldSchemaViolation        equate(11)
adFieldBadStatus              equate(12)
adFieldDefault                equate(13)
adFieldIgnore                 equate(15)
adFieldDoesNotExist           equate(16)
adFieldInvalidURL             equate(17)
adFieldResourceLocked         equate(18)
adFieldResourceExists         equate(19)
adFieldCannotComplete         equate(20)
adFieldVolumeNotFound         equate(21)
adFieldOutOfSpace             equate(22)
adFieldCannotDeleteSource     equate(23)
adFieldReadOnly               equate(24)
adFieldResourceOutOfScope     equate(25)
adFieldAlreadyExists          equate(26)
adFieldPendingInsert          equate(65536)
adFieldPendingDelete          equate(131072)
adFieldPendingChange          equate(262144)
adFieldPendingUnknown         equate(524288)
adFieldPendingUnknownDelete   equate(1048576)
                            end

SeekEnum                    itemize
adSeekFirstEQ                 equate(1)
adSeekLastEQ                  equate(2)
adSeekAfterEQ                 equate(4)
adSeekAfter                   equate(8)
adSeekBeforeEQ                equate(16)
adSeekBefore                  equate(32)
                            end

ADCPROP_UPDATECRITERIA_ENUM itemize
adCriteriaKey                 equate(0)
adCriteriaAllCols             equate(1)
adCriteriaUpdCols             equate(2)
adCriteriaTimeStamp           equate(3)
                            end

ADCPROP_ASYNCTHREADPRIORITY_ENUM    itemize
adPriorityLowest                      equate(1)
adPriorityBelowNormal                 equate(2)
adPriorityNormal                      equate(3)
adPriorityAboveNormal                 equate(4)
adPriorityHighest                     equate(5)
                                    end

ADCPROP_AUTORECALC_ENUM     itemize
adRecalcUpFront               equate(0)
adRecalcAlways                equate(1)
                            end

ADCPROP_UPDATERESYNC_ENUM   itemize
adResyncNone                  equate(0)
adResyncAutoIncrement         equate(1)
adResyncConflicts             equate(2)
adResyncUpdates               equate(4)
adResyncInserts               equate(8)
adResyncAll                   equate(15)
                            end

MoveRecordOptionsEnum       itemize
adMoveUnspecified             equate(-1)
adMoveOverWrite               equate(1)
adMoveDontUpdateLinks         equate(2)
adMoveAllowEmulation          equate(4)
                            end

CopyRecordOptionsEnum       itemize
adCopyUnspecified             equate(-1)
adCopyOverWrite               equate(1)
adCopyAllowEmulation          equate(4)
adCopyNonRecursive            equate(2)
                            end

StreamTypeEnum              itemize
adTypeBinary                  equate(1)
adTypeText                    equate(2)
                            end

LineSeparatorEnum           itemize
adLF                          equate(10)
adCR                          equate(13)
adCRLF                        equate(-1)
                            end

StreamOpenOptionsEnum       itemize
adOpenStreamUnspecified       equate(-1)
adOpenStreamAsync             equate(1)
adOpenStreamFromRecord        equate(4)
                            end

StreamWriteEnum             itemize
adWriteChar                   equate(0)
adWriteLine                   equate(1)
stWriteChar                   equate(0)
stWriteLine                   equate(1)
                            end

SaveOptionsEnum             itemize
adSaveCreateNotExist          equate(1)
adSaveCreateOverWrite         equate(2)
                            end

FieldEnum                   itemize
adDefaultStream               equate(-1)
adRecordURL                   equate(-2)
                            end

StreamReadEnum              itemize
adReadAll                     equate(-1)
adReadLine                    equate(-2)
                            end

RecordTypeEnum              itemize
adSimpleRecord                equate(0)
adCollectionRecord            equate(1)
adStructDoc                   equate(2)
                            end

!struct __declspec(uuid("00000512-0000-0010-8000-00aa006d2ea4"))

ICollection                 interface(IDispatch)
get_Count                     procedure(*long count),HRESULT,pascal
NewEnum                       procedure(*long pvObject),HRESULT,pascal
Refresh                       procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000513-0000-0010-8000-00aa006d2ea4"))

IDynaCollection             interface(ICollection)
_Append                       procedure(*IDispatch Object),HRESULT,pascal
Delete                        procedure(gVariant vtIndex),HRESULT,pascal, raw
                            end

!struct __declspec(uuid("00000534-0000-0010-8000-00aa006d2ea4"))

IADO                        interface(IDispatch)
get_Properties                procedure(*long ppvObject),HRESULT,pascal
                            end

!struct __declspec(uuid("00000504-0000-0010-8000-00aa006d2ea4"))

_IProperties                interface(ICollection)
get_Item                      procedure(gVariant vtIndex, *long ppvObject),HRESULT, pascal, raw
                            end

!struct __declspec(uuid("00000503-0000-0010-8000-00aa006d2ea4"))

IProperty                   interface(IDispatch)
get_Value                     procedure(*gVariant vtVal),HRESULT,pascal, raw
put_Value                     procedure(gVariant vtVal),HRESULT,pascal, raw
get_Name                      procedure(*bstring pbstr),HRESULT,pascal
get_Type                      procedure(*long ptype),HRESULT,pascal
get_Attributes                procedure(*long lAttributes),HRESULT,pascal
put_Attributes                procedure(long plAttributes),HRESULT,pascal
                            end

!struct __declspec(uuid("00000500-0000-0010-8000-00aa006d2ea4"))

IError                      interface(IDispatch)
get_Number                    procedure(*long lErr),HRESULT,pascal
get_Source                    procedure(*long bstr),HRESULT,pascal
get_Description               procedure(*long bstr),HRESULT,pascal
get_HelpFile                  procedure(*long bstr),HRESULT,pascal
get_HelpContext               procedure(*long lHCtxt),HRESULT,pascal
get_SQLState                  procedure(*bstring bstr),HRESULT,pascal
get_NativeError               procedure(*long lErr),HRESULT,pascal
                            end

!struct __declspec(uuid("00000501-0000-0010-8000-00aa006d2ea4"))

IErrors                     interface(ICollection)
get_Item                      procedure(gVariant vtIndex, *long ppvObject),HRESULT,pascal, raw
raw_Clear                     procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000508-0000-0010-8000-00aa006d2ea4"))

ICommand15                  interface(IADO)
get_ActiveConnection          procedure(*long ppvObject),HRESULT,pascal
putref_ActiveConnection       procedure(long ppvObject),HRESULT,pascal
put_ActiveConnection          procedure(gVariant vtppvObject),HRESULT,pascal, raw
get_CommandText               procedure(*bstring bstr),HRESULT,pascal
put_CommandText               procedure(bstring bstr),HRESULT,pascal
get_CommandTimeout            procedure(*long plTimeout),HRESULT,pascal
put_CommandTimeout            procedure(long plTimeout),HRESULT,pascal
get_Prepared                  procedure(*short pfPrepared ),HRESULT,pascal
put_Prepared                  procedure(short pfPrepared ),HRESULT,pascal
raw_Execute                   procedure(*gVariant vtRecordsAffected , *gVariant vtParameters , long Options, *long ppiRs),HRESULT,pascal, raw
raw_CreateParameter           procedure(bstring bstrName, long dwType, long dwDirection, long dwSize, gVariant vtValue, *long ppiprm),HRESULT,pascal, raw
get_Parameters                procedure(*long ppvObject),HRESULT,pascal
put_CommandType               procedure(long lCmdType),HRESULT,pascal
get_CommandType               procedure(*long plCmdType),HRESULT,pascal
get_Name                      procedure(*bstring bstrName),HRESULT,pascal
put_Name                      procedure(bstring bstrName),HRESULT,pascal
                            end

!struct __declspec(uuid("00000515-0000-0010-8000-00aa006d2ea4"))

_IConnection15              interface(IADO)
get_ConnectionString          procedure(*long bstr),HRESULT,pascal
put_ConnectionString          procedure(long bstr),HRESULT,pascal
get_CommandTimeout            procedure(*long lTimeout),HRESULT,pascal
put_CommandTimeout            procedure(long lTimeout),HRESULT,pascal
get_ConnectionTimeout         procedure(*long lTimeout),HRESULT,pascal
put_ConnectionTimeout         procedure(long lTimeout),HRESULT,pascal
get_Version                   procedure(*long bstr),HRESULT,pascal
Close                         procedure,HRESULT,pascal
raw_Execute                   procedure(bstring bstrCommandText, *gVariant pvRecordsAffected, long Options, |
                                        *long pIRset),HRESULT,pascal, raw                                        
BeginTrans                    procedure(*long pTransactionLevel),HRESULT,pascal
CommitTrans                   procedure,HRESULT,pascal
RollbackTrans                 procedure,HRESULT,pascal
Open                          procedure(bstring bstrConnectionString, bstring bstrUserID, bstring bstrPassword, long Options),HRESULT,pascal
get_Errors                    procedure(*long ppvObject),HRESULT,pascal
get_DefaultDatabase           procedure(*long bstr),HRESULT,pascal
put_DefaultDatabase           procedure(long bstr),HRESULT,pascal
get_IsolationLevel            procedure(*long Level),HRESULT,pascal
put_IsolationLevel            procedure(long Level),HRESULT,pascal
get_Attributes                procedure(*long lAttr),HRESULT,pascal
put_Attributes                procedure(long lAttr),HRESULT,pascal
get_CursorLocation            procedure(*long lCursorLoc),HRESULT,pascal
put_CursorLocation            procedure(long lCursorLoc),HRESULT,pascal
get_Mode                      procedure(*long lMode),HRESULT,pascal
put_Mode                      procedure(long lMode),HRESULT,pascal
get_Provider                  procedure(*long bstr),HRESULT,pascal
put_Provider                  procedure(long bstr),HRESULT,pascal
get_State                     procedure(*long lObjState),HRESULT,pascal
OpenSchema                    procedure(long Schema, gVARIANT Restrictions, gVARIANT SchemaID, *long pprset), raw, HRESULT, pascal

                            end

!struct __declspec(uuid("00000550-0000-0010-8000-00aa006d2ea4"))

_IConnection                interface(_IConnection15)
Cancel                        procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("0000050e-0000-0010-8000-00aa006d2ea4"))

_IRecordset15               interface(IADO)
get_AbsolutePosition          procedure(*long lPos),HRESULT,pascal
put_AbsolutePosition          procedure(long lPos),HRESULT,pascal
putref_ActiveConnection       procedure(long pDisp),HRESULT,pascal
put_ActiveConnection          procedure(gVariant vtVar), HRESULT, pascal, raw
get_ActiveConnection          procedure(*gVariant pvtVar),HRESULT,pascal, raw
get_BOF                       procedure(*short b),HRESULT,pascal
get_Bookmark                  procedure(*gVariant pvtBookmark),HRESULT,pascal, raw
put_Bookmark                  procedure(gVariant vtBookmark),HRESULT,pascal, raw
get_CacheSize                 procedure(*long l),HRESULT,pascal
put_CacheSize                 procedure(long l),HRESULT,pascal
get_CursorType                procedure(*long lCursorType),HRESULT,pascal
put_CursorType                procedure(long lCursorType),HRESULT,pascal
get_adoEOF                    procedure(*short b),HRESULT,pascal
get_Fields                    procedure(*long ppvObject),HRESULT,pascal
get_LockType                  procedure(*long lLockType),HRESULT,pascal
put_LockType                  procedure(long lLockType),HRESULT,pascal
get_MaxRecords                procedure(*long lMaxRecords),HRESULT,pascal
put_MaxRecords                procedure(long lMaxRecords),HRESULT,pascal
get_RecordCount               procedure(*long lRecCount),HRESULT,pascal
putref_Source                 procedure(*IDispatch pvSource),HRESULT,pascal
put_Source                    procedure(long bstrvSource),HRESULT,pascal
get_Source                    procedure(*gVariant pvtSource),HRESULT,pascal, raw
raw_AddNew                    procedure(gVariant vtFieldlist, gVariant vtValues),HRESULT,pascal, raw ! vtMissing = default params
raw_CancelUpdate              procedure,HRESULT,pascal
raw_Close                     procedure,HRESULT,pascal
raw_Delete                    procedure(long AffectRecords),HRESULT,pascal
raw_GetRows                   procedure(long Rows, gVariant vtStart, gVariant vtFields, *gVariant pvtVar),HRESULT,pascal, raw
raw_Move                      procedure(long NumRecords, gVariant vtStart),HRESULT,pascal, raw ! vtMissing = default params
MoveNext                      procedure,HRESULT,pascal
MovePrevious                  procedure,HRESULT,pascal
MoveFirst                     procedure,HRESULT,pascal
MoveLast                      procedure,HRESULT,pascal
raw_Open                      procedure(gVariant vSource, gVariant vActiveConnection, long CursorType, long LockType, long Options),HRESULT,pascal, raw
Requery                       procedure(long Options),HRESULT,pascal
xResync                       procedure(long AffectRecords),HRESULT,pascal 
raw_Update                    procedure(gVariant vtFields, gVariant vtValues),HRESULT,pascal, raw ! vtMissing = default params
get_AbsolutePage              procedure(*long l),HRESULT,pascal
put_AbsolutePage              procedure(long l),HRESULT,pascal
get_EditMode                  procedure(*long l),HRESULT,pascal
get_Filter                    procedure(*gVariant pvtCriteria),HRESULT,pascal, raw
put_Filter                    procedure(gVariant vtCriteria),HRESULT,pascal, raw
get_PageCount                 procedure(*long l),HRESULT,pascal
get_PageSize                  procedure(*long l),HRESULT,pascal
put_PageSize                  procedure(long l),HRESULT,pascal
get_Sort                      procedure(*long pbstrCriteria),HRESULT,pascal
put_Sort                      procedure(long bstrCriteria),HRESULT,pascal
get_Status                    procedure(*long l),HRESULT,pascal
get_State                     procedure(*long lObjState),HRESULT,pascal
raw__xClone                   procedure(*long ppvObject),HRESULT,pascal
raw_UpdateBatch               procedure(long AffectRecords),HRESULT,pascal
raw_CancelBatch               procedure(long AffectRecords),HRESULT,pascal
get_CursorLocation            procedure(*long lCursorLoc),HRESULT,pascal
put_CursorLocation            procedure(long lCursorLoc),HRESULT,pascal
raw_NextRecordset             procedure(*gVariant pvtRecordsAffected, *long ppiRs),HRESULT,pascal, raw
raw_Supports                  procedure(long CursorOptions, *short b),HRESULT,pascal
get_Collect                   procedure(gVariant vtIndex, *gVariant pvtVar),HRESULT,pascal, raw
put_Collect                   procedure(gVariant vtIndex, gVariant vtVar),HRESULT,pascal, raw
get_MarshalOptions            procedure(*long eMarshal),HRESULT,pascal
put_MarshalOptions            procedure(long eMarshal),HRESULT,pascal
raw_Find                      procedure(long bstrCriteria, long SkipRecords, long SearchDirection, gVariant vtStart),HRESULT,pascal, raw ! vtMissing = default params
                            end

!struct __declspec(uuid("0000054f-0000-0010-8000-00aa006d2ea4"))

_IRecordset20               interface(_IRecordset15)
raw_Cancel                    procedure,HRESULT,pascal
get_DataSource                procedure(*long punkDataSource),HRESULT,pascal
putref_DataSource             procedure(*IUnknown unkDataSource),HRESULT,pascal
raw__xSave                    procedure(long bstrFileName, long PersistFormat),HRESULT,pascal
get_ActiveCommand             procedure(*long pCmd),HRESULT,pascal
put_StayInSync                procedure(long bStayInSync),HRESULT,pascal
get_StayInSync                procedure(*long bStayInSync),HRESULT,pascal
raw_GetString                 procedure(long StringFormat, long NumRows, bstring bstrColumnDelimeter, |
                                        bstring bstrRowDelimeter, bstring bstrNullExpr, *bstring bstrRetString),HRESULT,pascal
get_DataMember                procedure(*bstring bstrDataMember),HRESULT,pascal
put_DataMember                procedure(bstring bstrDataMember),HRESULT,pascal
raw_CompareBookmarks          procedure(gVariant vtBookmark1, gVariant vtBookmark2, *long Compare),HRESULT,pascal, raw
raw_Clone                     procedure(long LockType, *long ppvObject),HRESULT,pascal
raw_Resync                    procedure(long AffectRecords, long ResyncValues),HRESULT,pascal
                            end

!struct __declspec(uuid("00000555-0000-0010-8000-00aa006d2ea4"))

_IRecordset21               interface(_IRecordset20)
raw_Seek                      procedure(gVariant vtKeyValues, long SeekOption),HRESULT,pascal, raw
put_Index                     procedure(bstring bstrIndex),HRESULT,pascal
get_Index                     procedure(*bstring bstrIndex),HRESULT,pascal
                            end

!struct __declspec(uuid("00000556-0000-0010-8000-00aa006d2ea4"))

_IRecordset                 interface(_IRecordset21)
raw_Save                      procedure(gVariant vtDestination, long PersistFormat),HRESULT,pascal, raw
                            end

!struct __declspec(uuid("00000506-0000-0010-8000-00aa006d2ea4"))

IFields15                   interface(ICollection)
get_Item                      procedure(gvariant vtIndex, *long ppvObject),HRESULT, pascal, raw
                            end

!struct __declspec(uuid("0000054d-0000-0010-8000-00aa006d2ea4"))

IFields20                   interface(IFields15)
raw_Append                    procedure(bstring bstrName, long lType, long DefinedSize, long Attrib),HRESULT,pascal
raw_Delete                    procedure(gVariant vtIndex),HRESULT,pascal, raw
                            end

!struct __declspec(uuid("00000564-0000-0010-8000-00aa006d2ea4"))

IFields                     interface(IFields20)
raw_Append                    procedure(bstring bstrName, long lType, long DefinedSize, long Attrib, |
                                        long vtFieldValue),HRESULT,pascal
raw_Update                    procedure,HRESULT,pascal
raw_Resync                    procedure(long ResyncValues),HRESULT,pascal
raw_CancelUpdate              procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("0000054c-0000-0010-8000-00aa006d2ea4"))

IField20                    interface(IADO)
get_ActualSize                procedure(*long pl),HRESULT,pascal
get_Attributes                procedure(*long pl),HRESULT,pascal
get_DefinedSize               procedure(*long pl),HRESULT,pascal
get_Name                      procedure(*bstring pbstr),HRESULT,pascal
get_Type                      procedure(*long pDataType),HRESULT,pascal
get_Value                     procedure(*gVariant pvtVar),HRESULT,pascal, raw
put_Value                     procedure(gVariant vtVar),HRESULT,pascal, raw
get_Precision                 procedure(*byte pbPrecision),HRESULT,pascal
get_NumericScale              procedure(*byte pbNumericScale),HRESULT,pascal
raw_AppendChunk               procedure(gVariant vtData),HRESULT,pascal, raw
raw_GetChunk                  procedure(long Length, long pvtVar),HRESULT,pascal
get_OriginalValue             procedure(*gVariant pvtVar),HRESULT,pascal, raw
get_UnderlyingValue           procedure(*gVariant pvtVar),HRESULT,pascal, raw
get_DataFormat                procedure(*long ppiDF),HRESULT,pascal
putref_DataFormat             procedure(long ppiDF),HRESULT,pascal
put_Precision                 procedure(byte bPrecision),HRESULT,pascal
put_NumericScale              procedure(byte bNumericScale),HRESULT,pascal
put_Type                      procedure(long DataType),HRESULT,pascal
put_DefinedSize               procedure(long pl),HRESULT,pascal
put_Attributes                procedure(long pl),HRESULT,pascal
                            end

!struct __declspec(uuid("00000569-0000-0010-8000-00aa006d2ea4"))

IField                      interface(IField20)
get_Status                    procedure(*long pFStatus),HRESULT,pascal
                            end

!struct __declspec(uuid("0000050c-0000-0010-8000-00aa006d2ea4"))

IParameter                  interface(IADO)
get_Name                      procedure(*bstring pbstr),HRESULT,pascal, raw
put_Name                      procedure(bstring pbstr),HRESULT,pascal, raw
get_Value                     procedure(*gVariant pvtVar),HRESULT,pascal, raw
put_Value                     procedure(gVariant vtVar),HRESULT,pascal, raw
get_Type                      procedure(*long psDataType),HRESULT,pascal
put_Type                      procedure(long sDataType),HRESULT,pascal
put_Direction                 procedure(long lParmDirection),HRESULT,pascal
get_Direction                 procedure(*long plParmDirection),HRESULT,pascal
put_Precision                 procedure(long bPrecision),HRESULT,pascal
get_Precision                 procedure(*long pbPrecision),HRESULT,pascal
put_NumericScale              procedure(long bScale),HRESULT,pascal
get_NumericScale              procedure(*long pbScale),HRESULT,pascal
put_Size                      procedure(long lSize),HRESULT,pascal
get_Size                      procedure(*long plSize),HRESULT,pascal
raw_AppendChunk               procedure(gVariant vtVal),HRESULT,pascal, raw
get_Attributes                procedure(*long plParmAttribs),HRESULT,pascal
put_Attributes                procedure(long lParmAttribs),HRESULT,pascal
                            end

!struct __declspec(uuid("0000050d-0000-0010-8000-00aa006d2ea4"))

IParameters                 interface(IDynaCollection)
get_Item                      procedure(gvariant vtIndex, *long ppvObject),HRESULT,pascal, raw
                            end

!struct __declspec(uuid("0000054e-0000-0010-8000-00aa006d2ea4"))

ICommand                    interface(ICommand15)
get_State                     procedure(*long plObjState),HRESULT,pascal
raw_Cancel                    procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000402-0000-0010-8000-00aa006d2ea4"))

IConnectionEventsVt         interface(IUnknown)
InfoMessage                   procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,pascal
BeginTransComplete            procedure(long TransactionLevel, *IError Error, *long adStatus, *_IConnection Connection),HRESULT,pascal
CommitTransComplete           procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,pascal
RollbackTransComplete         procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,pascal
WillExecute                   procedure(*long bstrSource, *long CursorType, *long LockType, *long Options, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection),HRESULT,pascal
ExecuteComplete               procedure(long RecordsAffected, *IError Error, *long adStatus, *ICommand Command, *_IRecordset Recordset, *_IConnection Connection),HRESULT,pascal
WillConnect                   procedure(*long bstrConnectionString, *long bstrUserID, *long bstrPassword, *long Options, *long adStatus, *_IConnection Connection),HRESULT,pascal
ConnectComplete               procedure(*IError Error, *long adStatus, *_IConnection Connection),HRESULT,pascal
Disconnect                    procedure(*long adStatus, *_IConnection Connection),HRESULT,pascal
                            end

!struct __declspec(uuid("00000403-0000-0010-8000-00aa006d2ea4"))

IRecordsetEventsVt          interface(IUnknown)
WillChangeField               procedure(long dwFields, variant vtFields, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
FieldChangeComplete           procedure(long dwFields, variant vtFields, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
WillChangeRecord              procedure(long adReason, long dwRecords, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
RecordChangeComplete          procedure(long adReason, long dwRecords, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
WillChangeRecordset           procedure(long adReason, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
RecordsetChangeComplete       procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
WillMove                      procedure(long adReason, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
MoveComplete                  procedure(long adReason, *IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
EndOfRecordset                procedure(*long pfMoreData, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
FetchProgress                 procedure(long Progress, long MaxProgress, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
FetchComplete                 procedure(*IError Error, *long adStatus, *_IRecordset Recordset),HRESULT,pascal
                            end

!struct __declspec(uuid("00000400-0000-0010-8000-00aa006d2ea4"))

IConnectionEvents           interface(IDispatch)
InfoMessage                   procedure(long pError, *long adStatus, long pConnection),HRESULT,pascal
BeginTransComplete            procedure(long TransactionLevel, long pError, *long adStatus, long pConnection),HRESULT,pascal
CommitTransComplete           procedure(long pError, *long adStatus, long pConnection),HRESULT,pascal
RollbackTransComplete         procedure(long pError, *long adStatus, long pConnection),HRESULT,pascal
WillExecute                   procedure(long pSource, long pCursorType, long pLockType, long pOptions, *long adStatus, long pCommand, long pRecordset, long pConnection),HRESULT,pascal
ExecuteComplete               procedure(long RecordsAffected, long pError, *long adStatus, long pCommand, long pRecordset, long pConnection),HRESULT,pascal
WillConnect                   procedure(long pConnectionString, long pUserID, long pPassword, long pOptions, *long adStatus, long pConnection),HRESULT,pascal
ConnectComplete               procedure(long pError, *long adStatus, long pConnection),HRESULT,pascal
Disconnect                    procedure(*long adStatus, long pConnection),HRESULT,pascal
                            end

!struct __declspec(uuid("00000266-0000-0010-8000-00aa006d2ea4"))

IRecordsetEvents            interface(IDispatch)
WillChangeField               procedure(long cFields, long vtFields, *long adStatus, long pRecordset),HRESULT,pascal
FieldChangeComplete           procedure(long cFields, long vtFields, long pError, *long adStatus, |
                                        long pRecordset),HRESULT,pascal
WillChangeRecord              procedure(long adReason, long cRecords, *long adStatus, long pRecordset),HRESULT,pascal
RecordChangeComplete          procedure(long adReason, long cRecords, long pError, *long adStatus, |
                                        long pRecordset),HRESULT,pascal
WillChangeRecordset           procedure(long adReason, *long adStatus, long pRecordset),HRESULT,pascal
RecordsetChangeComplete       procedure(long adReason, long pError, *long adStatus, long pRecordset),HRESULT,pascal
WillMove                      procedure(long adReason, *long adStatus, long pRecordset),HRESULT,pascal
MoveComplete                  procedure(long adReason, long pError, *long adStatus, long pRecordset),HRESULT,pascal
EndOfRecordset                procedure(long pfMoreData, *long adStatus, long pRecordset),HRESULT,pascal
FetchProgress                 procedure(long Progress, long MaxProgress, *long adStatus, long pRecordset),HRESULT,pascal
FetchComplete                 procedure(long pError, *long adStatus, long pRecordset),HRESULT,pascal
                            end

!struct __declspec(uuid("00000516-0000-0010-8000-00aa006d2ea4"))

IADOConnectionConstruction15 interface(IUnknown)
get_DSO                       procedure(*long pDSO),HRESULT,pascal
get_Session                   procedure(*long pSession),HRESULT,pascal
WrapDSOandSession             procedure(*IUnknown DSO, *IUnknown Session),HRESULT,pascal
                            end

!struct __declspec(uuid("00000551-0000-0010-8000-00aa006d2ea4"))

IADOConnectionConstruction  interface(IADOConnectionConstruction15)
                            end

!struct __declspec(uuid("00000514-0000-0010-8000-00aa006d2ea4"))

__Connection                group
Data1                         long(0514h)
Data2                         short(0)
Data3                         short(010h)
Data4                         string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                            end

!IConnection                 interface
!                            end

!    // [ default ] interface _Connection
!    // [ default, source ] dispinterface ConnectionEvents

!struct __declspec(uuid("00000562-0000-0010-8000-00aa006d2ea4"))

_IRecord                    interface(IADO)
get_ActiveConnection          procedure(long pvtVar),HRESULT,pascal
put_ActiveConnection          procedure(long pbstrVar),HRESULT,pascal
putref_ActiveConnection       procedure(long pVar),HRESULT,pascal
get_State                     procedure(*long pState),HRESULT,pascal
get_Source                    procedure(*long pvtVar),HRESULT,pascal
put_Source                    procedure(long pbstrVar),HRESULT,pascal
putref_Source                 procedure(*long pvar),HRESULT,pascal
get_Mode                      procedure(*long pMode),HRESULT,pascal
put_Mode                      procedure(long Mode),HRESULT,pascal
get_ParentURL                 procedure(*long pbstrParentURL),HRESULT,pascal
raw_MoveRecord                procedure(long bstrSource, long bstrDestination, long bstrUserName, long bstrPassword, long Options, long Async, *long pbstrNewURL),HRESULT,pascal
raw_CopyRecord                procedure(long bstrSource, long bstrDestination, long bstrUserName, long bstrPassword, long Options, long Async, *long pbstrNewURL),HRESULT,pascal
raw_DeleteRecord              procedure(long bstrSource, long Async),HRESULT,pascal
raw_Open                      procedure(variant vtSource, variant vtActiveConnection, long Mode, long CreateOptions, long Options, long bstrUserName, long bstrPassword),HRESULT,pascal
raw_Close                     procedure,HRESULT,pascal
get_Fields                    procedure(*long ppFlds),HRESULT,pascal
get_RecordType                procedure(*long ptype),HRESULT,pascal
raw_GetChildren               procedure(*long pprset),HRESULT,pascal
raw_Cancel                    procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000560-0000-0010-8000-00aa006d2ea4"))

IRecord                     interface
                            end

!    // [ default ] interface _Record

!struct __declspec(uuid("00000563-0000-0010-8000-00aa006d2ea4"))

IRecFields                  interface(IUnknown)
ADOCheck                      procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000565-0000-0010-8000-00aa006d2ea4"))

_IADOStream                 interface(IDispatch)
get_Size                      procedure(*long pSize),HRESULT,pascal
get_EOS                       procedure(*long pEOS),HRESULT,pascal
get_Position                  procedure(*long pPos),HRESULT,pascal
put_Position                  procedure(long pPos),HRESULT,pascal
get_Type                      procedure(*long ptype),HRESULT,pascal
put_Type                      procedure(long dwType),HRESULT,pascal
get_LineSeparator             procedure(*long pLS),HRESULT,pascal
put_LineSeparator             procedure(long LS),HRESULT,pascal
get_State                     procedure(*long pState),HRESULT,pascal
get_Mode                      procedure(*long pMode),HRESULT,pascal
put_Mode                      procedure(long pMode),HRESULT,pascal
get_Charset                   procedure(*long pbstrCharset),HRESULT,pascal
put_Charset                   procedure(long bstrCharset),HRESULT,pascal
raw_Read                      procedure(long NumBytes, *long pvtVal),HRESULT,pascal
raw_Open                      procedure(variant vtSource, long Mode, long Options, long bstrUserName, long bstrPassword),HRESULT,pascal
raw_Close                     procedure,HRESULT,pascal
raw_SkipLine                  procedure,HRESULT,pascal
raw_Write                     procedure(variant vtBuffer),HRESULT,pascal
raw_SetEOS                    procedure,HRESULT,pascal
raw_CopyTo                    procedure(*long pDestStream, long CharNumber),HRESULT,pascal
raw_Flush                     procedure,HRESULT,pascal
raw_SaveToFile                procedure(long bstrFileName, long Options),HRESULT,pascal
raw_LoadFromFile              procedure(long bstrFileName),HRESULT,pascal
raw_ReadText                  procedure(long NumChars, *long pbstr),HRESULT,pascal
raw_WriteText                 procedure(long bstrData, long Options),HRESULT,pascal
raw_Cancel                    procedure,HRESULT,pascal
                            end

!struct __declspec(uuid("00000566-0000-0010-8000-00aa006d2ea4"))
!Stream;
!    // [ default ] interface _Stream
!
!struct __declspec(uuid("00000567-0000-0010-8000-00aa006d2ea4"))

IADORecordConstruction      interface(IDispatch)
get_Row                       procedure(*long ppRow),HRESULT,pascal
put_Row                       procedure(*long ppRow),HRESULT,pascal
put_ParentRow                 procedure(*long _arg1),HRESULT,pascal
                            end

!struct __declspec(uuid("00000568-0000-0010-8000-00aa006d2ea4"))

IADOStreamConstruction      interface(IDispatch)
get_Stream                    procedure(*long ppStm),HRESULT,pascal
put_Stream                    procedure(*long ppStm),HRESULT,pascal
                            end

!struct __declspec(uuid("00000517-0000-0010-8000-00aa006d2ea4"))

IADOCommandConstruction     interface(IUnknown)
get_OLEDBCommand              procedure(*long ppOLEDBCommand),HRESULT,pascal
put_OLEDBCommand              procedure(*long ppOLEDBCommand),HRESULT,pascal
                            end

!struct __declspec(uuid("00000507-0000-0010-8000-00aa006d2ea4"))

__Command                   group
Data1                         long(0507h)
Data2                         short(0)
Data3                         short(010h)
Data4                         string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                            end

!struct __declspec(uuid("00000535-0000-0010-8000-00aa006d2ea4"))

__Recordset                 group
Data1                         long(0535h)
Data2                         short(0)
Data3                         short(010h)
Data4                         string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                            end

!_IRecordset                 interface
!                            end

!    // [ default ] interface _Recordset
!    // [ default, source ] dispinterface RecordsetEvents

!struct __declspec(uuid("00000283-0000-0010-8000-00aa006d2ea4"))

IADORecordsetConstruction   interface(IDispatch)
get_Rowset                    procedure(*long ppRowset),HRESULT,pascal
put_Rowset                    procedure(*long ppRowset),HRESULT,pascal
get_Chapter                   procedure(*long plChapter),HRESULT,pascal
put_Chapter                   procedure(long plChapter),HRESULT,pascal
get_RowPosition               procedure(*long ppRowPos),HRESULT,pascal
put_RowPosition               procedure(*long ppRowPos),HRESULT,pascal
                            end

!struct __declspec(uuid("00000505-0000-0010-8000-00aa006d2ea4"))

IField15                    interface(_ADO)
get_ActualSize                procedure(*long pl),HRESULT,pascal
get_Attributes                procedure(*long pl),HRESULT,pascal
get_DefinedSize               procedure(*long pl),HRESULT,pascal
get_Name                      procedure(*bstring pbstr),HRESULT,pascal
get_Type                      procedure(*long pDataType),HRESULT,pascal
get_Value                     procedure(*long pvtVar),HRESULT,pascal
put_Value                     procedure(gVariant pvar),HRESULT,pascal, raw
get_Precision                 procedure(*byte pbPrecision),HRESULT,pascal
get_NumericScale              procedure(*byte pbNumericScale),HRESULT,pascal
raw_AppendChunk               procedure(gvariant vtData),HRESULT,pascal, raw
raw_GetChunk                  procedure(long dwLength, *long pvtVar),HRESULT,pascal
get_OriginalValue             procedure(*long pvtVar),HRESULT,pascal
get_UnderlyingValue           procedure(*long pvtVar),HRESULT,pascal
                            end

!struct __declspec(uuid("0000050b-0000-0010-8000-00aa006d2ea4"))

__Parameter                 group
Data1                         long(050bh)
Data2                         short(0)
Data3                         short(010h)
Data4                         string('<080h><0><0><0aah><0><06dh><02eh><0a4h>')
                            end


  EndDefine

