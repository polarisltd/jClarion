  omit('EndDefine',_ADOHelperSupport_)
_ADOHelperSupport_  equate(1)


!*
!* Includes
!*

  include('svado.inc'),once

!*
!* Defines
!*

!*
!* Declarations
!*

adoHelpers      class,type,module('svhelper.clw'),link('svhelper.clw', _svLinkMode_),dll(_svDllMode_)
                end

!*
!* Func Proto
!*

  map
    module('svhelper')
      adoCreateConnection(*ADOManager ADOMgr, *cstring szServer, *cstring szDriver, |
                          *cstring szDatabase, *cstring szUsername, *cstring szPassword, |
                          *HRESULT hr),*ADOConnection,dll(_svDllMode_)
      adoDisconnect(*ADOManager ADOMgr, *ADOConnection ADOConn),HRESULT,dll(_svDllMode_)
      adoQuery(*ADOConnection ADOConn, *cstring szQuery, long CursorType, long LockType, |
               long Options, *HRESULT hr, *long dwRecordsAffected, <CRecordsetEvents RstEvts>),*ADOResultset,dll(_svDllMode_)
      adoFirst(*ADOResultSet Rs, *group grp, *HRESULT hr),byte,dll(_svDllMode_)
      adoNext(*ADOResultSet Rs, *group grp, *HRESULT hr),byte,dll(_svDllMode_)
      adoPrevious(*ADOResultSet Rs, *group grp, *HRESULT hr),byte,dll(_svDllMode_)
      adoBof(*ADOResultSet Rs, *long hr),byte,dll(_svDllMode_)
      adoEof(*ADOResultSet Rs, *long hr),byte,dll(_svDllMode_)
    end
  end


  EndDefine

