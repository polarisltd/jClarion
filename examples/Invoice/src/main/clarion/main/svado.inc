!ABCIncludeFile(SV)
  omit('EndDefine',_ADOSupport_)
_ADOSupport_  equate(1)


!*
!* Includes
!*

  include('svbase.inc'),once
  include('svmapper.inc'), once

!*
!* Defines
!*

!*
!* Declarations
!*

ADOConnectionEvents class(CConnectionEvents),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)
                    end


ADORecordsetEvents  class(CRecordsetEvents),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)
                    end


ADOError            class(CError),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)
                    end


ADOErrors           class(CErrors),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)
                    end


ADOField            class(CField20),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, byte fPreInstantiated = false, long bFetchProperties),HRESULT,proc,virtual
GetValue              procedure(*long pData, *gVariant vtValue, *long dwSize),HRESULT,virtual
PutValue              procedure(*gVariant vtValue, long dwSize),HRESULT,virtual
SetBlockReadSize      procedure(long dwBlockSize),byte
GetBlockReadSize      procedure,long
ReadBlob              procedure(long dwSize),HRESULT
PutBlob               procedure(long pData, long dwSize),HRESULT

! Protected

ArrayTypeHandler      procedure(long dwType),long,protected
_GetType              procedure(*long dwDataType),HRESULT,protected

bFetchProperties      long,protected
Type                  long,protected
pBlob                 long,protected
dwBlobSize            long,protected

! Private

dwBlockSize           long,private

                    end


ADOFields           class(CFields),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

GetField           procedure(long dwIndex, *long hr, long bFetchProperties = false),*ADOField,derived

                    end


ADOBlob             class,type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

InsertBlob            procedure(*ADOField ADOFld, *cstring szFileName),HRESULT
InsertBlob            procedure(*ADOField ADOFld, long pBlob),HRESULT
InsertBlob            procedure(*ADOResultset ADORst, *cstring szFieldName, *cstring szFileName),HRESULT
InsertBlob            procedure(*ADOResultset ADORst, *cstring szFieldName, long pBlob),HRESULT
GetBlob               procedure(*ADOField ADOFld, *cstring szOutFileName),HRESULT
GetBlob               procedure(*ADOField ADOFld, *long pBlob),HRESULT
GetBlob               procedure(*ADOResultset ADORst, *cstring szFieldName, *cstring szOutFileName),HRESULT
GetBlob               procedure(*ADOResultset ADORst, *cstring szFieldName, *long szOutFileName),HRESULT

                    end


ADOConnection       class(CConnection),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)
                    end


ADOResultSet        class(CRecordSet),type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

SetCacheSettings      procedure(long dwPageSize, long dwPages),HRESULT,proc
GetCacheSettings      procedure(*long dwPageSize, *long dwPages),HRESULT,proc
Bof                   procedure(*short bBof),HRESULT
Eof                   procedure(*short bEof),HRESULT
GetFields             procedure(*long hr),*ADOFields,derived
Collect               procedure(long FieldOrdinal, *gVariant vtOutValue),HRESULT
Collect               procedure(*cstring szFieldName, *gVariant vtOutValue),HRESULT
NextResultset         procedure(*long dwRecordsAffected, *long hr),*CRecordSet
InsertRow             procedure,HRESULT

! Protected

dwPageSize            long,protected
dwPages               long,protected

                    end
                    
CWRecordset         class(CRecordset), type, module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Attach                procedure(long pUnk, *group pGrp, byte fPreInstantiated = false),HRESULT,proc
Attach                procedure(long pUnk, *queue pQ, byte fPreInstantiated = false),HRESULT,proc

Find                  procedure(*cstring szCriteria, long SkipRecords, long SearchDirection, *gVariant vtStart),HRESULT, virtual

Init                  procedure(*group pGrp), HRESULT, virtual
Init                  procedure(*queue pQ), HRESULT, virtual

Move                  procedure(long NumRecords, *gVariant vtStart),HRESULT, virtual
MoveNext              procedure,HRESULT, virtual
MovePrevious          procedure,HRESULT, virtual
MoveFirst             procedure,HRESULT, virtual
MoveLast              procedure,HRESULT, virtual
Map                   procedure(), virtual

Open                  procedure(*cstring szSource, *CConnection Conn, long CursorType, long LockType, long Options),HRESULT, virtual
Open                  procedure(*cstring szSource, *cstring szConnection, long CursorType, long LockType, long Options), HRESULT, virtual

PutAbsolutePosition   procedure(long lPos), HRESULT, virtual
PutBookmark           procedure(*gVariant vtBookmark),HRESULT, virtual
PutFilter             procedure(*gVariant vtCriteria),HRESULT, virtual
PutSort               procedure(*cstring szCriteria),HRESULT, virtual

! Properties

Grp                   &group
Q                     &queue
Mapper                &TableMapper

                    end
                                         


ADOManager          class,type,module('svado.clw'),link('svado.clw', _svLinkMode_),dll(_svDllMode_)

Construct             procedure
Destruct              procedure,virtual

Connect               procedure(*cstring szConnectStr, *cstring szUID, *cstring szPWD, *long hr),*ADOConnection
Disconnect            procedure(*ADOConnection ADOConn, bool bDispose = true),HRESULT

! Protected

bInitialised          byte,protected

                    end


  EndDefine

