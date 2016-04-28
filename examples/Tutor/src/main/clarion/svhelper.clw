
  member

!**********************************************************************
!
!   Module:         sv_helper.clw
!
!
!**********************************************************************

!*
!*  Includes
!*

  include('svhelper.inc'),once

!*
!*  Equates
!*

!*
!*  Declarations
!*

!*
!*  Function Prototypes
!*

adoCreateConnection procedure(*ADOManager ADOMgr, *cstring szServer, *cstring szDriver, |
                              *cstring szDatabase, *cstring szUsername, *cstring szPassword, |
                              *HRESULT hr)

ADOConn         &ADOConnection
szConnectStr    cstring(512)

  code
    ADOConn &= null
?   assert(~ADOMgr &= null)
    if (~ADOMgr &= null)
      szConnectStr = 'Driver=' & szDriver & ';Server=' & szServer & ';DATABASE=' & szDatabase
      ADOConn &= ADOMgr.Connect(szConnectStr, szUsername, szPassword, hr)
    end
    return ADOConn


adoDisconnect procedure(*ADOManager ADOMgr, *ADOConnection ADOConn)

hr              HRESULT,auto

  code
    hr = S_OK
?   assert(~ADOMgr &= null)
    if (~ADOMgr &= null)
      hr = ADOMgr.Disconnect(ADOConn, true)
    end
    return hr


adoQuery procedure(*ADOConnection ADOConn, *cstring szQuery, long CursorType, long LockType, |
                   long Options, *HRESULT hr, *long dwRecordsAffected, <CRecordsetEvents RstEvts>)

Rs              &ADOResultset

  code
    Rs &= null
    Rs &= new ADOResultset
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.Init(RstEvts)
      if (hr = S_OK)
        Rs.SetCacheSettings(3, 50)
        hr = Rs.Open(szQuery, ADOConn, CursorType, LockType, Options)
        if hr ~= S_OK
          dispose(Rs)
          Rs &= null
        end
      end
    end
    return Rs


adoFirst procedure(*ADOResultSet Rs, *group grp, *HRESULT hr)

bResult         bool

  code
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.MoveFirst().
    return bResult


adoNext procedure(*ADOResultSet Rs, *group grp, *HRESULT hr)

bResult         bool

  code
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.MoveNext().
    return bResult


adoPrevious procedure(*ADOResultSet Rs, *group grp, *HRESULT hr)

bResult         bool

  code
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.MovePrevious().
    return bResult


adoBof procedure(*ADOResultSet Rs, *HRESULT hr)

bRetVal         short
bResult         byte

  code
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.Bof(bRetVal).
    if bRetVal
      bResult = true.
    return bResult


adoEof procedure(*ADOResultSet Rs, *HRESULT hr)

bRetVal         short
bResult         byte

  code
?   assert(~Rs &= null)
    if (~Rs &= null)
      hr = Rs.Eof(bRetVal).
    if bRetVal
      bResult = true.
    return bResult

