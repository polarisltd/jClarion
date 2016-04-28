
  MEMBER

  MAP
    MODULE('C55RUNX')
      LOCKTHREAD_NCT(),NAME('Cla$LOCKTHREAD_NCT')
      UNLOCKTHREAD_NCT(),NAME('Cla$UNLOCKTHREAD_NCT')
    END
  END

  INCLUDE('ABAPI.INC'),ONCE


WSock2Lib       CLASS,TYPE,LINK('ws2_32.lib',_APILinkMode_)
                END

WinINetLib      CLASS,TYPE,LINK('wininet.lib',_APILinkMode_)
                END


EventThread PROCEDURE(LONG lpParameter)

nErr                LONG
hEvent              LONG
lphEvent            LONG
WinSockMgr          &CWinSock20
SockMgr             LONG
dwResult            LONG
SocketConn          LONG
Connection          &CSocketConnection

  CODE
    MoveMemory(ADDRESS(hEvent), lpParameter, 4)
    MoveMemory(ADDRESS(SockMgr), lpParameter + 12, 4)
    lphEvent = ADDRESS(hEvent)
    WinSockMgr &= AssignAddr(SockMgr)
    MoveMemory(ADDRESS(SocketConn), lpParameter + 8, 4)
    Connection &= AssignAddr(SocketConn)
    LOOP
      IF ~IsBadReadPtr(SockMgr, 4) AND ~IsBadReadPtr(SocketConn, 4)
        nErr = WSAWaitForMultipleEvents(1, lphEvent, true, WSA_INFINITE, false)
        dwResult = WinSockMgr.ProcessEvent(Connection, nErr, hEvent)
        IF dwResult ~= 0
          dwResult = true
          BREAK
        END
      ELSE
        dwResult = SCL:BadPtrs
        BREAK
      END
    END
    RETURN dwResult


AssignAddr PROCEDURE(LONG dwVal)

  CODE
    RETURN dwVal


CProtocolSocket.Construct PROCEDURE

  CODE


CProtocolSocket.Destruct PROCEDURE

  CODE


CProtocolSocket.Init PROCEDURE(SOCKET Sock, LONG lpqsResults, LONG qsResultsBuffSize)

  CODE
    IF Sock ~= INVALID_SOCKET AND ~SELF.bInitialised
      SELF.Sock = Sock
?     ASSERT(lpqsResults AND qsResultsBuffSize, 'CProtocolSocket.Init Error : lpQSResult Buffer or Size was NULL')
      IF lpqsResults AND qsResultsBuffSize
        SELF.lpqsResults = lpqsResults
        SELF.qsResultsBuffSize = qsResultsBuffSize
        SELF.bInitialised = SELF.AssignBuffers()
      END
    END
    RETURN SELF.bInitialised


CProtocolSocket.Kill PROCEDURE

  CODE
?   ASSERT(SELF.lpqsResults AND SELF.qsResultsBuffSize, 'CProtocolSocket.Kill Error : lpQSResult Buffer or Size was NULL')
    IF SELF.lpqsResults
      VirtualFree(SELF.lpqsResults, SELF.qsResultsBuffSize, MEM_DECOMMIT).


CProtocolSocket.GetSocket PROCEDURE

  CODE
    RETURN SELF.Sock


CProtocolSocket.GetLocalAddr PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.LocalAddr.lpSockaddr


CProtocolSocket.GetLocalAddrLen PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.LocalAddr.iSockaddrLength


CProtocolSocket.GetRemoteAddr PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.RemoteAddr.lpSockaddr


CProtocolSocket.GetRemoteAddrLen PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.RemoteAddr.iSockaddrLength


CProtocolSocket.GetSocketType PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.iSocketType


CProtocolSocket.GetProtocol PROCEDURE

  CODE
    RETURN SELF.ICSAddr_Info.iProtocol


CProtocolSocket.AssignBuffers PROCEDURE

bResult     BOOL

  CODE
    MoveMemory(ADDRESS(SELF.QSResults), SELF.lpQSResults, SIZE(WSAQUERYSET))
?   ASSERT(SELF.QSResults.lpcsaBuffer)
    IF SELF.QSResults.lpcsaBuffer
      MoveMemory(ADDRESS(SELF.ICSAddr_Info), SELF.QSResults.lpcsaBuffer, SIZE(CSADDR_INFO))
?     ASSERT(SELF.ICSAddr_Info.LocalAddr.lpSockaddr)
      IF SELF.ICSAddr_Info.LocalAddr.lpSockaddr
        MoveMemory(ADDRESS(SELF.LocalSockAddr), SELF.ICSAddr_Info.LocalAddr.lpSockaddr, SIZE(SOCKADDR))
        bResult = true
      END
      IF SELF.ICSAddr_Info.RemoteAddr.lpSockaddr
        MoveMemory(ADDRESS(SELF.RemoteSockAddr), SELF.ICSAddr_Info.RemoteAddr.lpSockaddr, SIZE(SOCKADDR))
        bResult = true
      ELSE
        bResult = false
      END
    END
    RETURN bResult


CProtocolGenerator.Construct PROCEDURE

  CODE
    SELF.ProtocolInfoQueue &= NEW(ProtocolInfoQueue)


CProtocolGenerator.Destruct PROCEDURE

  CODE
    SELF.Kill()
    IF ~SELF.ProtocolInfoQueue &= NULL
      DISPOSE(SELF.ProtocolInfoQueue).


CProtocolGenerator.Init PROCEDURE(<ErrorClass ErrHdlr>)

  CODE
    IF SELF.IsInitialised()
      SELF.Kill()
    END
    SELF.ErrHdlr &= NULL
    IF ~OMITTED(2)
      SELF.ErrHdlr &= ErrHdlr
    END
    SELF.bInitialised = true


CProtocolGenerator.IsInitialised PROCEDURE

  CODE
    RETURN SELF.bInitialised


CProtocolGenerator.Kill PROCEDURE

  CODE
    IF SELF.IsInitialised()
      IF SELF.lpProtocolBuffer AND SELF.dwProtBufSize
        VirtualFree(SELF.lpProtocolBuffer, SELF.dwProtBufSize, MEM_DECOMMIT).
      IF SELF.lpAfProtocols AND SELF.AfProtocolsSize
        VirtualFree(SELF.lpAfProtocols, SELF.AfProtocolsSize, MEM_DECOMMIT).
      FREE(SELF.ProtocolInfoQueue)
      SELF.bProtsEnumerated = false
      SELF.SearchInfo &= NULL
      SELF.bInitialised = false
    END


CProtocolGenerator.CreateProtocol PROCEDURE(SearchCriteria SearchInfo, *CSTRING szServiceName, LONG lpServiceType, LONG dwPort, *LONG nErr, LONG dwNameSpace)


dwProtBufSize       LONG
lpProtocolBuffer    LONG
Socket              &CProtocolSocket
nProts              LONG

  CODE
    Socket &= NULL
    IF SELF.IsInitialised()
      SELF.SearchInfo &= SearchInfo
      IF ~SELF.bProtsEnumerated
        nProts = SELF.EnumProtocols(lpProtocolBuffer, dwProtBufSize)
      END
      IF nProts
        SELF.BuildAfProtocolsList()
      END
    END
    RETURN Socket


CProtocolGenerator.CreateProtocol PROCEDURE(LONG AddressFamily, LONG Protocol, LONG SocketType, *CSTRING szServiceName, LONG dwPort, *LONG nErr, LONG dwNameSpace)

LocAfProtocol       GROUP(AFPROTOCOLS).
Socket              &CProtocolSocket
LocCSAddrInfo       LIKE(CSADDR_INFO)
LocalSockAddr       LIKE(SOCKADDR)
RemoteSockAddr      LIKE(SOCKADDR)
ServiceType         LIKE(GUID)
sock                SOCKET
lpServiceType       LONG
lpCSAddrInfos       LONG
CSAddrBuffSize      LONG
dwNumCSAddrInfos    LONG
lpQSResults         LONG
QSResultsBuffSize   LONG

  CODE
    IF SELF.IsInitialised()
      Socket &= NULL
      ServiceType = SVCID_HOSTNAME()
      SELF.AfProtocolsSize = SIZE(AFPROTOCOLS)
      SELF.dwNumAfProtocols = 1
      SELF.lpAfProtocols = VirtualAlloc(0, SELF.AfProtocolsSize, MEM_COMMIT, PAGE_READWRITE)
?     ASSERT(SELF.lpAfProtocols)
      IF SELF.lpAfProtocols
        LocAfProtocol.iAddressFamily = AddressFamily
        LocAfProtocol.iProtocol = Protocol
        MoveMemory(SELF.lpAfProtocols, ADDRESS(LocAfProtocol), SIZE(LocAfProtocol))
        nErr = SELF.LookupServiceAddresses(szServiceName, ADDRESS(ServiceType), lpCSAddrInfos, CSAddrBuffSize, dwNumCSAddrInfos, lpQSResults, QSResultsBuffSize, dwNameSpace)
        IF ~nErr
          MoveMemory(ADDRESS(LocCSAddrInfo), lpCSAddrInfos, SIZE(CSADDR_INFO))
          MoveMemory(ADDRESS(LocalSockAddr), LocCSAddrInfo.LocalAddr.lpSockAddr, SIZE(SOCKADDR))
          MoveMemory(ADDRESS(RemoteSockAddr), LocCSAddrInfo.RemoteAddr.lpSockAddr, SIZE(SOCKADDR))
          nErr = SELF.CrackSockAddr(dwPort, LocalSockAddr, RemoteSockAddr, SocketType, Protocol, sock)
          MoveMemory(LocCSAddrInfo.LocalAddr.lpSockAddr, ADDRESS(LocalSockAddr), SIZE(SOCKADDR))
          MoveMemory(LocCSAddrInfo.RemoteAddr.lpSockAddr, ADDRESS(RemoteSockAddr), SIZE(SOCKADDR))
          MoveMemory(lpCSAddrInfos, ADDRESS(LocCSAddrInfo), SIZE(CSADDR_INFO))
          IF nErr = 0
            Socket &= NEW(CProtocolSocket)
            nErr = Socket.Init(sock, lpqsResults, QSResultsBuffSize)
            IF ~nErr
              nErr = INVALID_SOCKET.
          END
        END
      END
    END
    RETURN Socket


CProtocolGenerator.EnumProtocols PROCEDURE(*LONG lpProtocolBuffer, *LONG dwProtBufSize)

nErr                            SIGNED
dwProtBufs                      LONG
LocProtocolInfo                 GROUP(WSAPROTOCOL_INFOA).
szErrMsg                        CSTRING(64)

  CODE
    dwProtBufSize = 0
    nErr = WSAEnumProtocols(0, ADDRESS(LocProtocolInfo), ADDRESS(dwProtBufSize))
    IF nErr = SOCKET_ERROR AND WSAGetLastError() = WSAENOBUFS
      SELF.lpProtocolBuffer = VirtualAlloc(0, dwProtBufSize, MEM_COMMIT, PAGE_READWRITE)
      SELF.dwProtBufSize = dwProtBufSize
?     ASSERT(SELF.lpProtocolBuffer, '<13><10>VirtualAlloc failed to Allocate ' & SELF.dwProtBufSize & ' Bytes for the Protocol Buffer.')
      IF SELF.lpProtocolBuffer
        nErr = WSAEnumProtocols(0, SELF.lpProtocolBuffer, ADDRESS(SELF.dwProtBufSize))
        IF nErr = SOCKET_ERROR
          nErr = WSAGetLastError()
          szErrMsg = 'CProtocolGenerator.EnumProtocols, WSAEnumProtocols failed, Err : ' & nErr
          SELF.ThrowError(szErrMsg)
          dwProtBufs = 0
          VirtualFree(SELF.lpProtocolBuffer, SELF.dwProtBufSize, MEM_DECOMMIT)
          lpProtocolBuffer = 0
          SELF.dwProtBufSize = 0
        ELSE
          SELF.bProtsEnumerated = true
          dwProtBufs = nErr
        END
      END
    END
    RETURN dwProtBufs


CProtocolGenerator.BuildAfProtocolsList PROCEDURE

LocProtocolInfo     GROUP(WSAPROTOCOL_INFOA).
LocAfProtocol       GROUP(AFPROTOCOLS).
nProtocolBufSize    LONG
ICnt                LONG
LocProtocolName     CSTRING(64)
nErr                LONG

  CODE
    SELF.AfProtocolsSize = SELF.dwProtInfoStructs * SIZE(AFPROTOCOLS)
    SELF.lpAfProtocols = VirtualAlloc(0, SELF.AfProtocolsSize, MEM_COMMIT, PAGE_READWRITE)
?   ASSERT(SELF.lpAfProtocols)
    IF SELF.lpAfProtocols
?     ASSERT(SELF.lpProtocolBuffer)
      IF SELF.lpProtocolBuffer
      nProtocolBufSize = SIZE(WSAPROTOCOL_INFOA)
      SELF.dwNumAfProtocols = 0
      LOOP ICnt = 0 TO SELF.dwProtInfoStructs - 1
        MoveMemory(ADDRESS(LocProtocolInfo), (SIZE(WSAPROTOCOL_INFOA) * ICnt) + |
                   SELF.lpProtocolBuffer, SIZE(WSAPROTOCOL_INFOA))
        SELF.ProtocolInfoQueue.szProtocolName = LocProtocolInfo.szProtocol
        SELF.ProtocolInfoQueue :=: LocProtocolInfo
        IF SELF.IsGoodProtocol(SELF.ProtocolInfoQueue.dwServiceFlags1)
          ADD(SELF.ProtocolInfoQueue, SELF.ProtocolInfoQueue.iProtocol)
          LocAfProtocol.iProtocol = SELF.ProtocolInfoQueue.iProtocol
          LocAfProtocol.iAddressFamily = SELF.ProtocolInfoQueue.iAddressFamily
          MoveMemory((SIZE(LocAfProtocol) * SELF.dwNumAfProtocols) + SELF.lpAfProtocols, ADDRESS(LocAfProtocol), |
                      SIZE(LocAfProtocol))
          SELF.dwNumAfProtocols += 1
          LocProtocolName = LocProtocolInfo.szProtocol
          SELF.OnEnumProtocol(LocProtocolInfo, LocProtocolName)
        END
      END
      IF ~SELF.dwNumAfProtocols
        nErr = ERR_NO_GOOD_PROTOCOLS.
      END
    ELSE
      nErr = ERR_MEM_ALLOC_FAILED
    END


CProtocolGenerator.GetAFProtocolsAddr PROCEDURE

  CODE
    RETURN SELF.lpAfProtocols


CProtocolGenerator.GetProtocolCount PROCEDURE

  CODE
    RETURN RECORDS(SELF.ProtocolInfoQueue)


CProtocolGenerator.LookupServiceAddresses PROCEDURE(*CSTRING szServiceName, LONG lpServiceType, *LONG lpCSAddrInfos, *LONG CSAddrBuffSize, *LONG dwNumCsAddrInfos, *LONG lpqsResults, *LONG qsResultsBuffSize, LONG dwNameSpace)

hLookup         LONG
Err             SIGNED
qsResultQSet    LIKE(WSAQUERYSET)
qsRestrictions  LIKE(WSAQUERYSET)

  CODE
    qsRestrictions.dwSize = SIZE(WSAQUERYSET)
    qsRestrictions.lpszServiceInstanceName = ADDRESS(szServiceName)
    qsRestrictions.lpServiceClassID = lpServiceType
    qsRestrictions.dwNameSpace = dwNameSpace
    qsRestrictions.dwNumberOfProtocols = SELF.dwNumAfProtocols
    qsRestrictions.lpAfpProtocols = SELF.lpAfProtocols
    Err = WSALookupServiceBegin(ADDRESS(qsRestrictions), LUP_RETURN_NAME + LUP_RETURN_ADDR, ADDRESS(hLookup))
    IF Err ~= SOCKET_ERROR
      qsResultsBuffSize = 2048
      lpqsResults = VirtualAlloc(0, qsResultsBuffSize, MEM_COMMIT, PAGE_READWRITE)
?     ASSERT(lpqsResults, '<13><10>VirtualAlloc failed to Allocate ' & qsResultsBuffSize & ' Bytes for the WSAQUERYSET Buffer.')
      IF lpqsResults
        LOOP
          Err = WSALookupServiceNext(hLookup, 0, ADDRESS(qsResultsBuffSize), lpqsResults)
          IF Err = SOCKET_ERROR
            Err = WSAGetLastError()
            IF Err = WSA_E_NO_MORE OR Err = WSAENOMORE
              Err = 0
            ELSIF Err = WSASERVICE_NOT_FOUND
              Err = WSAHOST_NOT_FOUND
            END
            BREAK
          END
        END
        IF Err = 0
          MoveMemory(ADDRESS(qsResultQSet), lpqsResults, SIZE(WSAQUERYSET))
          dwNumCsAddrInfos = qsResultQSet.dwNumberOfCsAddrs
          CSAddrBuffSize = SIZE(CSADDR_INFO) * dwNumCsAddrInfos
          lpCSAddrInfos = VirtualAlloc(0, CSAddrBuffSize, MEM_COMMIT, PAGE_READWRITE)
          MoveMemory(lpCSAddrInfos, qsResultQSet.lpcsaBuffer, CSAddrBuffSize)
        END
      END
      WSALookupServiceEnd(hLookup)
    ELSE
      Err = WSAGetLastError()
    END
    RETURN Err


CProtocolGenerator.CrackSockAddr PROCEDURE(LONG dwPort, *SOCKADDR _LocalSockAddr, *SOCKADDR _RemoteSockAddr, LONG iSocketType, LONG iProtocol, *SOCKET sock)

nErr                SIGNED
LocSockAddr_In      &SOCKADDR_IN
Sin_Port            SHORT
szErrMsg            CSTRING(64)

  CODE
    LocSockAddr_In &= _RemoteSockAddr
    Sin_Port = 0
    sock = CreateSocket(_LocalSockAddr.sa_family, iSocketType, iProtocol)
    IF sock ~= SOCKET_ERROR
      nErr = WSAHtons(sock, dwPort, Sin_Port)
      IF nErr ~= SOCKET_ERROR
        LocSockAddr_In.sin_port = Sin_Port
      ELSE
        nErr = WSAGetLastError()
      END
    ELSE
      nErr = WSAGetLastError()
      szErrMsg = 'CProtocolGenerator.CrackSockAddr, CreateSocket failed, Err : ' & nErr
      SELF.ThrowError(szErrMsg)
    END
    RETURN nErr


CProtocolGenerator.ThrowError PROCEDURE(*CSTRING szErrMsg)

  CODE
    IF ~SELF.ErrHdlr &= NULL
      SELF.ErrHdlr.ThrowMessage(Msg:WinsockError, szErrMsg).


CProtocolGenerator.IsGoodProtocol PROCEDURE(LONG dwServiceFlags)

bGoodProtocol       BOOL(true)

  CODE
    IF SELF.SearchInfo.bReliable
      bGoodProtocol = SELF.IsReliable(dwServiceFlags)
    ELSIF SELF.SearchInfo.bConnectionless
      bGoodProtocol = SELF.IsConnectionless(dwServiceFlags)
    END
    RETURN bGoodProtocol


CProtocolGenerator.IsReliable PROCEDURE(LONG dwServiceFlags)

bSuccess        BOOL(true)

  CODE
    IF ~BAND(dwServiceFlags, XP1_GUARANTEED_DELIVERY) OR |
       ~BAND(dwServiceFlags, XP1_GUARANTEED_ORDER)
      bSuccess = false
    END
    IF SELF.IsConnectionless(dwServiceFlags)
      bSuccess = false
    END
    IF SELF.SearchInfo.bStreamOriented AND |
       BAND(dwServiceFlags, XP1_MESSAGE_ORIENTED) AND |
       ~BAND(dwServiceFlags, XP1_PSEUDO_STREAM)
      bSuccess = false
    END
    IF SELF.SearchInfo.bMsgOriented AND |
       ~BAND(dwServiceFlags, XP1_MESSAGE_ORIENTED)
      bSuccess = false
    END
    RETURN bSuccess


CProtocolGenerator.IsConnectionless PROCEDURE(LONG dwServiceFlags)

bSuccess        BOOL

  CODE
    IF BAND(dwServiceFlags, XP1_CONNECTIONLESS)
      bSuccess = true
    END
    RETURN bSuccess


CProtocolGenerator.OnEnumProtocol PROCEDURE(WSAPROTOCOL_INFOA ProtocolInfo, *CSTRING ProtocolName)

  CODE


CSocketConnection.Construct PROCEDURE

  CODE
    InitializeCriticalSection(SELF.CloseCritSection)


CSocketConnection.Destruct PROCEDURE

  CODE
    SELF.Kill
    DeleteCriticalSection(SELF.CloseCritSection)


CSocketConnection.Init PROCEDURE(LONG dwThreadID, CWinSock20 WinSockMgr, CProtocolSocket Socket, BYTE bServerSocket)

dwResult        SIGNED
ThreadID        LONG
nErr            SIGNED
szErrMsg        CSTRING(64)

  CODE
    SELF.Socket &= Socket
    SELF.Sock = SELF.Socket.GetSocket()
?   ASSERT(~SELF.Sock = INVALID_SOCKET, '<13><10>Socket creation Failure.')
    IF SELF.Sock ~= INVALID_SOCKET
      SELF.dwThreadID = dwThreadID
      SELF.WinSockMgr &= WinSockMgr
      SELF.bServerSocket = bServerSocket
      IF SELF.bServerSocket
        SELF.hEvent = WSACreateEvent()
        SELF.ThreadParams.hEvent = SELF.hEvent
        SELF.ThreadParams.Socket = SELF.Sock
        SELF.ThreadParams.lpConnection = ADDRESS(SELF)
        SELF.ThreadParams.lpWinSockMgr = ADDRESS(SELF.WinSockMgr)
        nErr = WSAEventSelect(SELF.Sock, SELF.hEvent, BOR(FD_READ, BOR(FD_WRITE, BOR(FD_CLOSE, FD_ACCEPT))))
        IF nErr ~= SOCKET_ERROR
          SELF.hThread = CreateThread(, 0, ADDRESS(EventThread), ADDRESS(SELF.ThreadParams), 0, ThreadID)
          IF SELF.hThread
            nErr = Listen(SELF.Sock, SOMAXCONN)
            IF nErr ~= SOCKET_ERROR
              nErr = WSAGetLastError()
              TerminateThread(SELF.hThread, 0)
              CloseHandle(SELF.hThread)
            END
          ELSE
            nErr = GetLastError()
            szErrMsg = 'CSocketConnection.Init, CreateThread failed with Err : ' & nErr
            SELF.WinSockMgr.ThrowError(szErrMsg)
            CloseHandle(SELF.hEvent)
          END
        ELSE
          nErr = WSAGetLastError()
          szErrMsg = 'CSocketConnection.Init, WSAEventSelect failed with Err : ' & nErr
          SELF.WinSockMgr.ThrowError(szErrMsg)
          CloseHandle(SELF.hEvent)
        END
      END
      SELF.bInitialised = true
    END
    RETURN nErr


CSocketConnection.Kill PROCEDURE

bResult     BOOL

  CODE
    EnterCriticalSection(SELF.CloseCritSection)
    IF SELF.bConnected
      Shutdown(SELF.Sock, SD_BOTH)
      bResult = WSACloseEvent(SELF.hEvent)
?     ASSERT(bResult, '<13><10>Warning : The Event object tied to this socket failed to close.')
      SELF.hEvent = 0
      CloseSocket(SELF.Sock)
      TerminateThread(SELF.hThread, 0)
      CloseHandle(SELF.hThread)
      SELF.hThread = 0
      SELF.bConnected = false
      DISPOSE(SELF.Socket)
    END
    LeaveCriticalSection(SELF.CloseCritSection)


CSocketConnection.IsInitialised PROCEDURE

  CODE
    RETURN SELF.bInitialised


CSocketConnection.IsConnected PROCEDURE

  CODE
    RETURN SELF.bConnected


CSocketConnection.IsServerSocket PROCEDURE

  CODE
    RETURN SELF.bServerSocket


CSocketConnection.Connect PROCEDURE

nErr            SIGNED
dwResult        SIGNED
ThreadID        LONG
lNetworkEvents  LONG
LocSockAddr     &SOCKADDR
szErrMsg        CSTRING(64)

  CODE
    LocSockAddr &= SELF.Socket.GetRemoteAddr()
    SELF.hEvent = WSACreateEvent()
    IF SELF.hEvent ~= WSA_INVALID_EVENT
      SELF.ThreadParams.hEvent = SELF.hEvent
      SELF.ThreadParams.Socket = SELF.Sock
      SELF.ThreadParams.lpConnection = ADDRESS(SELF)
      SELF.ThreadParams.lpWinSockMgr = ADDRESS(SELF.WinSockMgr)
      lNetworkEvents = FD_CONNECT + FD_READ + FD_WRITE + FD_OOB + FD_ACCEPT + FD_CLOSE
      dwResult = WSAEventSelect(SELF.Sock, SELF.hEvent, lNetworkEvents)
      IF dwResult ~= SOCKET_ERROR
        IF SELF.bUserThreadProc
          SELF.hThread = CreateThread(, 0, ADDRESS(SELF.lpThreadProc), ADDRESS(SELF.ThreadParams), 0, ThreadID)
        ELSE
          SELF.hThread = CreateThread(, 0, ADDRESS(EventThread), ADDRESS(SELF.ThreadParams), 0, ThreadID)
        END
        IF SELF.hThread
          nErr = Connect(SELF.Sock, ADDRESS(LocSockAddr), SELF.Socket.GetRemoteAddrLen())
          IF nErr = SOCKET_ERROR
            nErr = WSAGetLastError().
          IF nErr = WSAEWOULDBLOCK OR nErr = 0
            SELF.bConnected = true
          ELSE
            szErrMsg = 'CSocketConnection.Connect, Connect failed with Err : ' & nErr
            SELF.WinSockMgr.ThrowError(szErrMsg)
          END
        ELSE
          CloseHandle(SELF.hEvent)
          nErr = GetLastError()
          szErrMsg = 'CSocketConnection.Connect, CreateThread failed with Err : ' & nErr
          SELF.WinSockMgr.ThrowError(szErrMsg)
        END
      ELSE
        CloseHandle(SELF.hEvent)
        nErr = WSAGetLastError()
        szErrMsg = 'CSocketConnection.Connect, WSAEventSelect failed with Err : ' & nErr
        SELF.WinSockMgr.ThrowError(szErrMsg)
      END
    ELSE
      CloseHandle(SELF.hEvent)
      nErr = WSAGetLastError()
    END
    RETURN nErr


CSocketConnection.SetThreadProc PROCEDURE(LONG lpThreadProc)

  CODE
    ASSERT(lpThreadProc)
    IF lpThreadProc
      SELF.lpThreadProc = lpThreadProc
      SELF.bUserThreadProc = true
    END


CSocketConnection.GetSocket PROCEDURE

  CODE
    RETURN SELF.Sock


CSocketConnection.CloseSocket PROCEDURE

bResult     BOOL

  CODE
    IF SELF.bConnected
      bResult = WSACloseEvent(SELF.hEvent)
?     ASSERT(bResult, '<13><10>Warning : The Event object tied to this socket failed to close.')
      SELF.hEvent = 0
      CloseSocket(SELF.Sock)
      TerminateThread(SELF.hThread, 0)
      CloseHandle(SELF.hThread)
      SELF.hThread = 0
      SELF.bConnected = false
      DISPOSE(SELF.Socket)
    END


CSocketConnection.SafeClose PROCEDURE

nErr            LONG
bResult         BYTE
szErrMsg        CSTRING(64)

  CODE
    nErr = WaitForSingleObject(SELF.hThread, 500)
    IF nErr = WAIT_OBJECT_0
      bResult = WSACloseEvent(SELF.hEvent)
?     ASSERT(bResult, '<13><10>Warning : The Event object tied to this socket failed to close.')
      SELF.hEvent = 0
      CloseSocket(SELF.Sock)
      CloseHandle(SELF.hThread)
      SELF.hThread = 0
      SELF.bConnected = false
      DISPOSE(SELF.Socket)
    ELSE
      szErrMsg = 'CSocketConnection.SafeClose, WaitForSingleObject failed with Err : ' & nErr
      SELF.WinSockMgr.ThrowError(szErrMsg)
    END


CSocketConnection.Shutdown PROCEDURE

nErr            LONG

  CODE
    nErr = Shutdown(SELF.Sock, SD_SEND)
    SELF.bShutdown = true
    IF nErr = SOCKET_ERROR
      nErr = WSAGetLastError().
    RETURN nErr


CSocketConnection.SetSendTimeout PROCEDURE(LONG dwTimeout)

dwValue         LONG

  CODE
    dwValue = dwTimeout
    RETURN setsockopt(SELF.Sock, IPPROTO_TCP, SO_SNDTIMEO, ADDRESS(dwValue), 4)


CSocketConnection.SetRecvTimeout PROCEDURE(LONG dwTimeout)

dwValue         LONG

  CODE
    dwValue = dwTimeout
    RETURN setsockopt(SELF.Sock, IPPROTO_TCP, SO_RCVTIMEO, ADDRESS(dwValue), 4)


CSocketConnection.SendData PROCEDURE(*STRING strSendBuffer, *LONG BytesSent)

TotalBytes          SIGNED
nErr                SIGNED
nResult             SIGNED

  CODE
    BytesSent = 0
    TotalBytes = LEN(strSendBuffer)
    LOOP WHILE(BytesSent < TotalBytes)
      nResult = SendData(SELF.Sock, ADDRESS(strSendbuffer) + BytesSent, |
                         TotalBytes - BytesSent, 0)
      IF nResult = SOCKET_ERROR
        nErr = WSAGetLastError()
        BREAK
      ELSE
        BytesSent += nResult
      END
    END
    RETURN nErr


CSocketConnection.ReceiveData PROCEDURE(LONG lpReceiveBuffer, LONG dwSize, *LONG BytesReceived)

nErr            LONG

  CODE
    nErr = ReceiveData(SELF.Sock, lpReceiveBuffer, dwSize, 0)
    IF nErr = SOCKET_ERROR
      nErr = WSAGetLastError()
    ELSIF nErr = 0
    ELSE
      BytesReceived = nErr
      nErr = 0
    END
    RETURN nErr


CSocketConnection.OnCloseSocket PROCEDURE(LONG dwReason, *CProtocolSocket Socket)

PSocket     &CProtocolSocket

  CODE
    PSocket &= Socket
    DISPOSE(PSocket)


CSocketConnection.IConnection.CloseSocket PROCEDURE

  CODE
    SELF.CloseSocket


CSocketConnection.IConnection.Shutdown PROCEDURE

  CODE
    RETURN SELF.Shutdown()


CSocketConnection.IConnection.SendData PROCEDURE(*STRING strSendBuffer, *LONG BytesSent)

  CODE
    RETURN SELF.SendData(StrSendBuffer, BytesSent)


CSocketConnection.IConnection.ReceiveData PROCEDURE(LONG lpReceiveBuffer, LONG dwSize, *LONG BytesReceived)

  CODE
    RETURN SELF.ReceiveData(lpReceiveBuffer, dwSize, BytesReceived)


CSocketConnection.IConnection.SetSendTimeout PROCEDURE(LONG dwTimeout)

  CODE
    RETURN SELF.SetSendTimeout(dwTimeout)


CSocketConnection.IConnection.SetRecvTimeout PROCEDURE(LONG dwTimeout)

  CODE
    RETURN SELF.SetRecvTimeout(dwTimeout)


CSocketConnection.IConnection.GetSocket PROCEDURE

  CODE
    RETURN SELF.Sock


CSocketConnection.IConnection.IsServerSocket PROCEDURE

  CODE
    RETURN SELF.IsServerSocket()


CSocketConnection.IConnection.GetThreadID PROCEDURE

  CODE
    RETURN SELF.dwThreadID


CWinSock20.Construct PROCEDURE

  CODE


CWinSock20.Destruct PROCEDURE

  CODE
    SELF.Kill()


CWinSock20.Init PROCEDURE(<ErrorClass ErrHdlr>)

nErr        SIGNED
szErrMsg    CSTRING(64)

  CODE
    IF SELF.IsInitialised()
      SELF.Kill()
    END
    SELF.ErrHdlr &= NULL
    IF ~OMITTED(2)
      SELF.ErrHdlr &= ErrHdlr
    END
    IF WSAStartup(MakeWord(2, 2), ADDRESS(SELF.WSADataGrp)) = 0
      SELF.ClientConnectionQueue &= NEW(ConnectionQueue)
      SELF.bInitialised = true
    ELSE
      nErr = WSAGetLastError()
      szErrMsg = 'CWinSock20.Init, WSAStartup failed with Err : ' & nErr
      SELF.ThrowError(szErrMsg)
    END
    RETURN nErr


CWinSock20.InitServer PROCEDURE(LONG dwServerPort, LONG dwServerThreadID)

  CODE
    IF SELF.IsServerInitialised()
      SELF.KillServer()
    END
    SELF.ServerConnectionQueue &= NEW(ConnectionQueue)
    SELF.dwServerPort = dwServerPort
    RETURN SELF.ServerConnect(dwServerThreadID)


CWinSock20.Kill PROCEDURE

nErr            SIGNED

  CODE
    SELF.KillServer()
    IF SELF.IsInitialised()
      nErr = WSACleanup()
?     ASSERT(nErr = 0, 'WSACleanup unsuccessful, Still pending activity on a Socket.')
      IF nErr
      ELSE
        SELF.bInitialised = false
      END
      SELF.CleanupConnectionQueue(SELF.ClientConnectionQueue)
      DISPOSE(SELF.ClientConnectionQueue)
    END


CWinSock20.KillServer PROCEDURE

  CODE
    IF SELF.bServerInitialised
      SELF.CleanupConnectionQueue(SELF.ServerConnectionQueue)
      DISPOSE(SELF.ServerConnectionQueue)
    END


CWinSock20.IsInitialised PROCEDURE

  CODE
    RETURN SELF.bInitialised


CWinSock20.IsServerInitialised PROCEDURE

  CODE
    RETURN SELF.bServerInitialised


CWinSock20.SetSendTimeout PROCEDURE(*IConnection Connection, LONG dwTimeout)

  CODE
    RETURN Connection.SetSendTimeout(dwTimeout)


CWinSock20.SetRecvTimeout PROCEDURE(*IConnection Connection, LONG dwTimeout)

  CODE
    RETURN Connection.SetRecvTimeout(dwTimeout)


CWinSock20.CleanupConnectionQueue PROCEDURE(ConnectionQueue Connections)

iCnt            LONG

  CODE
    LOOP iCnt = 1 TO RECORDS(Connections)
      GET(Connections, 1)
      IF ERRORCODE()
        BREAK.
      DISPOSE(Connections.Connection)
      DELETE(Connections)
    END


CWinSock20.ServerConnect PROCEDURE(LONG dwThreadID)

iCnt            LONG
NewServerSocket &CSocketConnection
szServiceName   CSTRING('')

  CODE
!    LOOP iCnt = 1 TO RECORDS(SELF.ProtocolInfoQueue)
!      GET(SELF.ProtocolInfoQueue, iCnt)
!      IF ERRORCODE()
!        BREAK.
!      IF SELF.ProtocolInfoQueue.iAddressFamily = AF_INET
!        NewServerSocket &= NEW(CSocketConnection)
!        IF SELF.InitSocket(dwThreadID, NewServerSocket, SELF.ProtocolInfoQueue.szProtocolName, SELF.dwServerPort, szServiceName, true)
!          SELF.ServerConnectionQueue.Connection &= NewServerSocket
!          SELF.ServerConnectionQueue.IConnectionAddress = ADDRESS(NewServerSocket.IConnection)
!          ADD(SELF.ServerConnectionQueue, SELF.ServerConnectionQueue.IConnectionAddress)
!        ELSE
!          DISPOSE(NewServerSocket)
!        END
!      END
!    END
    RETURN 0


CWinSock20.SocketConnect PROCEDURE(LONG dwThreadID, LONG dwPort, *CSTRING szServerName, |
                                   CProtocolSocket Socket, *LONG nErr, <*CSocketConnection Connection>)

LocSocketConn   &CSocketConnection
bNewSocket      BYTE
bGoodSocket     BYTE
WSAErr          SIGNED

  CODE
    IF ~OMITTED(7)
      LocSocketConn &= Connection
    ELSE
      LocSocketConn &= NEW(CSocketConnection)
      bNewSocket = true
    END
    IF bNewSocket OR ~LocSocketConn.IsInitialised()
      nErr = LocSocketConn.Init(dwThreadID, SELF, Socket, false)
      IF ~nErr
        bGoodSocket = true.
    ELSE
      bGoodSocket = true
    END
    IF bGoodSocket AND ~LocSocketConn.IsConnected()
      nErr = LocSocketConn.Connect()
      IF nErr = SOCKET_ERROR
        WSAErr = WSAGetLastError().
      IF nErr = SOCKET_ERROR AND WSAErr ~= WSAEWOULDBLOCK
        IF bNewSocket
          DISPOSE(LocSocketConn)
          LocSocketConn &= NULL
        END
      ELSE
        SELF.ClientConnectionQueue.Connection &= LocSocketConn
        SELF.ClientConnectionQueue.IConnectionAddress = ADDRESS(LocSocketConn.IConnection)
        ADD(SELF.ClientConnectionQueue, SELF.ClientConnectionQueue.IConnectionAddress)
      END
      IF WSAErr
        nErr = WSAErr.
    ELSE
      DISPOSE(LocSocketConn)
      LocSocketConn &= NULL
    END
    RETURN LocSocketConn


CWinSock20.Disconnect PROCEDURE(*IConnection Connection)

nErr            LONG

  CODE
    nErr = Connection.Shutdown()
    IF nErr = SOCKET_ERROR
      nErr = WSAGetLastError().
    RETURN nErr


CWinSock20.CleanupConnection PROCEDURE(*IConnection Connection)

  CODE
    SELF.ClientConnectionQueue.IConnectionAddress = ADDRESS(Connection)
    GET(SELF.ClientConnectionQueue, SELF.ClientConnectionQueue.IConnectionAddress)
    IF ~ERRORCODE()
      SELF.ClientConnectionQueue.Connection.SafeClose
    END
    DISPOSE(SELF.ClientConnectionQueue.Connection)
    DELETE(SELF.ClientConnectionQueue)


CWinSock20.Listen PROCEDURE

  CODE


CWinSock20.SendData PROCEDURE(*IConnection Connection, *STRING strSendBuffer, *LONG BytesSent)

  CODE
    RETURN Connection.SendData(strSendBuffer, BytesSent)


CWinSock20.ReceiveData PROCEDURE(*IConnection Connection, *STRING strReceiveBuffer, *LONG BytesReceived)

  CODE
    RETURN Connection.ReceiveData(ADDRESS(strReceiveBuffer), SIZE(strReceiveBuffer), BytesReceived)


CWinSock20.ReceiveServerData PROCEDURE(*STRING strReceiveBuffer)

Connection          &IConnection

  CODE
    RETURN false


CWinSock20.ProcessEvent PROCEDURE(*CSocketConnection Connection, LONG nErr, LONG hEvent)

dwResult        LONG

  CODE
    IF nErr ~= WSA_INVALID_HANDLE
      IF ~IsBadReadPtr(ADDRESS(Connection), 4)
        EnterCriticalSection(Connection.CloseCritSection)
        IF nErr = WSA_WAIT_EVENT_0
          dwResult = SELF.ProcessNetworkEvent(Connection, hEvent)
        ELSIF nErr = WAIT_IO_COMPLETION
        ELSIF nErr = WSA_WAIT_FAILED
          dwResult = SELF.ProcessWaitError(Connection)
        END
        LeaveCriticalSection(Connection.CloseCritSection)
      END
    ELSE
      dwResult = SCL:CleanExit
    END
    RETURN dwResult


CWinSock20.ThrowError PROCEDURE(*CSTRING szErrMsg)

  CODE
    IF ~SELF.ErrHdlr &= NULL
      SELF.ErrHdlr.ThrowMessage(Msg:WinsockError, szErrMsg).


CWinSock20.ProcessWaitError PROCEDURE(*CSocketConnection Connection)

dwResult        LONG

  CODE
    LOCKTHREAD_NCT
      dwResult = SELF.OnWaitFailedTS(Connection)
    UNLOCKTHREAD_NCT
    dwResult = SELF.OnWaitFailedPostTS(Connection)
    RETURN dwResult


CWinSock20.ProcessNetworkEvent PROCEDURE(*CSocketConnection Connection, LONG hEvent)

nErr                LONG
WSAErr              LONG
lpWSANetworkEvents  LONG
lNetworkEvents      LONG
iErrorCode          LONG,DIM(FD_MAX_EVENTS)
dwResult            LONG
SaveResult          LONG
dwSize              LONG(SIZE_WSANETWORKEVENTS)

  CODE
    lpWSANetworkEvents = VirtualAlloc(0, dwSize, MEM_COMMIT, PAGE_READWRITE)
?   ASSERT(lpWSANetworkEvents, 'Failed to Allocate a buffer for the Network Events')
    IF lpWSANetworkEvents
      nErr = WSAEnumNetworkEvents(Connection.GetSocket(), hEvent, lpWSANetworkEvents)
      IF nErr = SOCKET_ERROR
        WSAErr = WSAGetLastError().
      IF ~WSAErr AND WSAErr ~= WSAEINPROGRESS
        MoveMemory(ADDRESS(lNetworkEvents), lpWSANetworkEvents, 4)
        MoveMemory(ADDRESS(iErrorCode), lpWSANetworkEvents + 4, FD_MAX_EVENTS * 4)
        IF BAND(lNetworkEvents, FD_READ)
          dwResult = SELF.ProcessReadEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_READ_BIT])
        ELSIF BAND(lNetworkEvents, FD_WRITE)
          dwResult = SELF.ProcessWriteEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_WRITE_BIT])
        ELSIF BAND(lNetworkEvents, FD_ACCEPT)
          dwResult = SELF.ProcessAcceptEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_ACCEPT_BIT])
        ELSIF BAND(lNetworkEvents, FD_OOB)
          dwResult = SELF.ProcessOOBEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_OOB_BIT])
        ELSIF BAND(lNetworkEvents, FD_CONNECT)
          dwResult = SELF.ProcessConnectEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_CONNECT_BIT])
        ELSIF BAND(lNetworkEvents, FD_CLOSE)
          dwResult = SELF.ProcessCloseEvent(Connection.GetSocket(), Connection.IConnection, iErrorCode[FD_CLOSE_BIT])
        END
      ELSE
        IF WSAErr = WSAENETDOWN
          dwResult = SCL:NetDown
        ELSE
          dwResult = Evt:CloseDown
        END
        SaveResult = dwResult
        dwResult = SELF.OnEnumNetEventError(WSAErr, Connection.IConnection)
        IF dwResult = 0
          dwResult = SaveResult.
      END
      VirtualFree(lpWSANetworkEvents, dwSize, MEM_DECOMMIT)
    END
    RETURN dwResult


CWinSock20.ProcessReadEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwBytesRead             LONG
lpReceiveBuffer         LONG
dwSize                  LONG(8192)
strReceiveBuffer        &STRING,AUTO
nErr                    LONG
dwResult                LONG

  CODE
    IF iErrorCode = WSAENETDOWN
      LOCKTHREAD_NCT
!        dwResult = SELF.OnReadEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      lpReceiveBuffer = VirtualAlloc(0, dwSize, MEM_COMMIT, PAGE_READWRITE)
      IF lpReceiveBuffer
        nErr = Connection.ReceiveData(lpReceiveBuffer, dwSize, dwBytesRead)
        IF ~nErr

! Wrapped to preserve Thread safety during potential unsafe handshake with OnReadEvent method
! as this method is Pre-Emptive due to being called from a Pre-Emptive thread.

          LOCKTHREAD_NCT
            strReceiveBuffer &= NEW(STRING(dwBytesRead))
            MoveMemory(ADDRESS(strReceiveBuffer), lpReceiveBuffer, dwBytesRead)
            dwResult = SELF.OnReadEventTS(Connection.GetThreadID(), Sock, strReceiveBuffer, dwBytesRead, Connection.IsServerSocket())
            DISPOSE(strReceiveBuffer)
          UNLOCKTHREAD_NCT
        ELSE
          SELF.nLastError = nErr
        END
        VirtualFree(lpReceiveBuffer, dwSize, MEM_DECOMMIT)
      END
      IF dwResult = 0
        dwResult = SELF.OnReadEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.ProcessWriteEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG

  CODE
    IF iErrorCode = WSAENETDOWN
      LOCKTHREAD_NCT
        dwResult = SELF.OnWriteEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      LOCKTHREAD_NCT
        POST(Msg:LastWriteCompleted, , Connection.GetThreadID())
        dwResult = SELF.OnWriteEventTS(Sock, Connection)
      UNLOCKTHREAD_NCT
      IF dwResult = 0
        dwResult = SELF.OnWriteEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.ProcessAcceptEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG
ConnSocket      SOCKET

  CODE
    IF iErrorCode = WSAENETDOWN
      LOCKTHREAD_NCT
        dwResult = SELF.OnAcceptEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      ConnSocket = AcceptSocket(Sock)
      LOCKTHREAD_NCT
        dwResult = SELF.OnAcceptEventTS(Sock, Connection,, ConnSocket)
      UNLOCKTHREAD_NCT
      IF dwResult = 0
        dwResult = SELF.OnAcceptEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.ProcessOOBEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG

  CODE
    IF iErrorCode = WSAENETDOWN
      LOCKTHREAD_NCT
        dwResult = SELF.OnOOBEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      LOCKTHREAD_NCT
        dwResult = SELF.OnOOBEventTS(Sock, Connection)
      UNLOCKTHREAD_NCT
      IF dwResult = 0
        dwResult = SELF.OnOOBEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.ProcessConnectEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG

  CODE
    IF iErrorCode ~= NO_ERROR
      LOCKTHREAD_NCT
        POST(Msg:ErrorConnecting, , Connection.GetThreadID())
        dwResult = SELF.OnConnectEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      LOCKTHREAD_NCT
        POST(Msg:Connected, , Connection.GetThreadID())
        dwResult = SELF.OnConnectEventTS(Sock, Connection)
      UNLOCKTHREAD_NCT
      IF dwResult = 0
        dwResult = SELF.OnConnectEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.ProcessCloseEvent PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG

  CODE
    IF iErrorCode ~= NO_ERROR
      LOCKTHREAD_NCT
        POST(Msg:ConnectionLost, , Connection.GetThreadID())
        dwResult = SELF.OnCloseEventTS(Sock, Connection, iErrorCode)
      UNLOCKTHREAD_NCT
    ELSE
      LOCKTHREAD_NCT
        POST(Msg:SocketClosed, , Connection.GetThreadID())
        dwResult = SELF.OnCloseEventTS(Sock, Connection)
      UNLOCKTHREAD_NCT
      IF dwResult = 0
        dwResult = SELF.OnCloseEventPostTS(Sock, Connection).
    END
    RETURN dwResult


CWinSock20.OnWaitFailedTS PROCEDURE(*CSocketConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnReadEventTS PROCEDURE(LONG dwThreadID, SOCKET Sock, *STRING strReceiveBuffer, LONG dwBytes, BYTE bServerSocket)

  CODE
    RETURN 0


CWinSock20.OnWriteEventTS PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

  CODE
    RETURN 0


CWinSock20.OnOOBEventTS PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

  CODE
    RETURN 0


CWinSock20.OnAcceptEventTS PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode, SOCKET InboundSock)

  CODE
    RETURN 0


CWinSock20.OnCloseEventTS PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

dwResult        LONG

  CODE
    IF iErrorCode = WSAENETDOWN
      dwResult = SCL:NetDown
    ELSIF iErrorCode = WSAECONNRESET
      dwResult = SCL:ConnReset
    ELSIF iErrorCode = WSAECONNABORTED
      dwResult = SCL:ConnAborted
    ELSIF iErrorCode = NO_ERROR
      dwResult = SCL:CleanExit
      SELF.OnSocketClosed(Sock, IConnection)
    END
    RETURN dwResult


CWinSock20.OnConnectEventTS PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

  CODE
    RETURN 0


CWinSock20.OnWaitFailedPostTS PROCEDURE(*CSocketConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnReadEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnWriteEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnOOBEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnAcceptEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnCloseEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnConnectEventPostTS PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnEnumNetEventError PROCEDURE(LONG WSAError, *CSocketConnection Connection)

  CODE
    RETURN 0


CWinSock20.OnSocketClosed PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE


CHttpConnection.Construct       PROCEDURE

  CODE


CHttpConnection.Destruct        PROCEDURE

  CODE
    SELF.Kill


CHttpConnection.Init            PROCEDURE(CWinINet WinINetMgr, LONG hInternetSession, LONG hInternetConnect, ASTRING ASVerb, *CSTRING szServerName)

bSuccess        BYTE

  CODE
?   ASSERT(hInternetSession AND hInternetConnect)
    IF hInternetSession AND hInternetConnect
      SELF.hInternetSession = hInternetSession
      SELF.hInternetConnect = hInternetConnect
      SELF.ASVerb = ASVerb
      SELF.szServerName &= NEW(CSTRING(LEN(szServerName)))
      SELF.szServerName = szServerName
      SELF.ConnectionMgr &= WinINetMgr
      bSuccess = true
    END
    RETURN bSuccess


CHttpConnection.Kill            PROCEDURE

  CODE
    IF ~SELF.szServerName &= NULL
      DISPOSE(SELF.szServerName).
    IF ~SELF.szReferer &= NULL
      DISPOSE(SELF.szReferer).
    IF ~SELF.szAcceptTypes &= NULL
      DISPOSE(SELF.szAcceptTypes).


CHttpConnection.SetOptions      PROCEDURE(*CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext)

  CODE
    IF ~SELF.szReferer &= NULL
      DISPOSE(SELF.szReferer).
    IF ~SELF.szAcceptTypes &= NULL
      DISPOSE(SELF.szAcceptTypes).
    SELF.szReferer &= NEW(CSTRING(LEN(szReferer)))
    SELF.szReferer = szReferer
    SELF.szAcceptTypes &= NEW(CSTRING(LEN(szAcceptTypes)))
    SELF.szAcceptTypes = szAcceptTypes
    SELF.dwFlags = dwFlags
    SELF.dwContext = dwContext


CHttpConnection.OpenRequest     PROCEDURE(ASTRING ASVerb, *CSTRING szObjectName, *CSTRING szVersion, *CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext)

bSuccess        BYTE
szVerb          CSTRING(20)

  CODE
    szVerb = ASVerb
    SELF.hInternetOpenRequest = HttpOpenRequest(SELF.hInternetConnect, szVerb, szObjectName, |
                                                szVersion, szReferer, szAcceptTypes, dwFlags, |
                                                dwContext)
    IF SELF.hInternetOpenRequest
      bSuccess = true.
    RETURN bSuccess


CHttpConnection.SendRequest     PROCEDURE(*CSTRING szHeaders, LONG dwHeadersLength, LONG lpOptional, LONG dwOptionalLength)

bSuccess        BYTE

  CODE
?   ASSERT(SELF.hInternetOpenRequest)
    IF SELF.hInternetOpenRequest
      bSuccess = HttpSendRequest(SELF.hInternetOpenRequest, szHeaders, dwHeadersLength, lpOptional, dwOptionalLength).
    RETURN bSuccess


CHttpConnection.QueryInfo       PROCEDURE(LONG dwInfoLevel, LONG lpBuffer, LONG dwBufferLength, LONG dwIndex)

bSuccess        BYTE

  CODE
?   ASSERT(SELF.hInternetOpenRequest)
    IF SELF.hInternetOpenRequest
      bSuccess = HttpQueryInfo(SELF.hInternetOpenRequest, dwInfoLevel, lpBuffer, dwBufferLength, dwIndex).
    RETURN bSuccess


CHttpConnection.ReceiveData     PROCEDURE(LONG lpReceiveBuffer, LONG dwSize)

NumRead         LONG

  CODE
?   ASSERT(SELF.hInternetOpenRequest)
    IF SELF.hInternetOpenRequest
      IF ~InternetReadFile(SELF.hInternetOpenRequest, lpReceiveBuffer, dwSize, NumRead)
        !Throw Error
      END
    END
    RETURN NumRead


CHttpConnection.IINetConnectionHttp.CloseConnection PROCEDURE

  CODE
! Does not need to do anything


CHttpConnection.IINetConnectionHttp.SendData PROCEDURE(<*STRING strSendBuffer>, <*STRING strObjName>)

bSuccess        BYTE
dwResult        LONG
szEmptyStr      CSTRING('')
szVersion       CSTRING('HTTP/1.0')
strReadBuffer   STRING(128)
strRecieveBuffer &STRING
TotalNumRead    LONG
NumRead         LONG
szObjectName    CSTRING(64)

  CODE
    IF ~OMITTED(3)
      szObjectName = CLIP(strObjName)
    END
    IF SELF.OpenRequest(SELF.ASVerb, szObjectName, szVersion, SELF.szReferer, SELF.szAcceptTypes, SELF.dwFlags, SELF.dwContext)
?     ASSERT(SELF.hInternetOpenRequest)
      IF SELF.hInternetOpenRequest
        IF ~OMITTED(2)
          bSuccess = HttpSendRequest(SELF.hInternetOpenRequest, szEmptyStr, 0, ADDRESS(strSendBuffer), SIZE(strSendBuffer))
        ELSE
          bSuccess = HttpSendRequest(SELF.hInternetOpenRequest, szEmptyStr, 0, 0, 0)
        END
        IF bSuccess
          IF SELF.QueryInfo(HTTP_QUERY_STATUS_CODE, ADDRESS(strReadBuffer), SIZE(strReadBuffer), 0)
            dwResult = strReadBuffer
            SELF.dwStatus = dwResult
            IF dwResult >= 200 AND dwResult <= 299
              !bSuccess = true
              !strReadBuffer = ''
              !SELF.QueryInfo(HTTP_QUERY_CONTENT_LENGTH, ADDRESS(strReadBuffer), SIZE(strReadBuffer), 0)
              !dwResult = strReadBuffer
              strRecieveBuffer &= NEW(STRING(1024))
              LOOP
                NumRead = SELF.ReceiveData(ADDRESS(strReadBuffer), SIZE(strReadBuffer))
                TotalNumRead += NumRead
                IF ~NumRead
                  BREAK.
                strRecieveBuffer = CLIP(strRecieveBuffer) & strReadBuffer[1 : NumRead]
              END
              SELF.ConnectionMgr.OnReadEvent(SELF.IINetConnectionHttp, strRecieveBuffer, dwResult)
              DISPOSE(strRecieveBuffer)
            ELSE
              bSuccess = false
            END
          END
        END
      END
    END
    RETURN bSuccess


CHttpConnection.IINetConnectionHttp.ReceiveData PROCEDURE(LONG lpReceiveBuffer, LONG dwSize)

  CODE
    RETURN SELF.ReceiveData(lpReceiveBuffer, dwSize)


CHttpConnection.IINetConnectionHttp.GetConnectionID PROCEDURE

  CODE
    RETURN SELF.hInternetOpenRequest


CHttpConnection.IINetConnectionHttp.IsServerConnection PROCEDURE

  CODE
    RETURN false    !Allways false, can't have a Server Connection in WinINet


CHttpConnection.IINetConnectionHttp.SetOptions PROCEDURE(*CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext)

  CODE


CHttpConnection.IINetConnectionHttp.GetStatus PROCEDURE

  CODE
    RETURN SELF.dwStatus


CHttpConnection.IINetConnectionHttp.GetThreadID PROCEDURE

  CODE
    RETURN SELF.dwThreadID


CFtpConnection.SendCommand      PROCEDURE(BYTE fExpectResponse, LONG dwFlags, *CSTRING szCommand, *LONG lpdwContext, *LONG lphFtpCommand)

dwResult            LONG

  CODE

    IF ~FtpCommand(SELF.hInternetConnect, fExpectResponse, dwFlags, szCommand, lpdwContext, lphFtpCommand)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.FindFirstFile    PROCEDURE(*CSTRING szSearchFile, WIN32_FIND_DATA lpFindFileData, LONG dwFlags, LONG dwContext = 0)

dwResult            LONG

  CODE
    SELF.hFind = FtpFindFirstFile(SELF.hInternetConnect, szSearchFile, lpFindFileData, dwFlags, dwContext)
    IF ~SELF.hFind
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.FindNextFile     PROCEDURE(WIN32_FIND_DATA lpFindFileData)

dwResult            LONG

  CODE
?   ASSERT(SELF.hFind, 'FindFirstFile must be called to start an Enumeration')
    IF SELF.hFind
      IF ~InternetFindNextFile(SELF.hFind, lpFindFileData)
        dwResult = GetLastError()
      END
    END
    RETURN dwResult


CFtpConnection.GetFileSize      PROCEDURE(*CSTRING szFileName, LONG dwAccess, LONG dwFlags, *LONG dwContext, *LONG dwFileSizeHigh)

dwResult            LONG
hFile               LONG

  CODE
    hFile = FtpOpenFile(SELF.hInternetConnect, szFileName, dwAccess, dwFlags, dwContext)
    IF ~hFile
      dwResult = GetLastError()
    ELSE
      IF ~FtpGetFileSize(hFile, dwFileSizeHigh)
        dwResult = GetLastError()
      END
    END
    RETURN dwResult


CFtpConnection.GetFile          PROCEDURE(*CSTRING szRemoteFile, *CSTRING szNewFile, BYTE bFailIfExists, LONG dwLocalFlagsAndAttributes, LONG dwInternetFlags, LONG dwContext = 0)

dwResult            LONG

  CODE
    IF ~FtpGetFile(SELF.hInternetConnect, szRemoteFile, szNewFile, bFailIfExists, dwLocalFlagsAndAttributes, dwInternetFlags, dwContext)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.PutFile          PROCEDURE(*CSTRING szLocalFile, *CSTRING szNewRemoteFile, LONG dwFlags, LONG dwContext = 0)

dwResult            LONG

  CODE
    IF ~FtpPutFile(SELF.hInternetConnect, szLocalFile, szNewRemoteFile, dwFlags, dwContext)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.GetCurrentDirectory PROCEDURE(*CSTRING szCurrentDirectory, *LONG dwCurrentDirectory)

dwResult            LONG

  CODE
    IF ~FtpGetCurrentDirectory(SELF.hInternetConnect, szCurrentDirectory, dwCurrentDirectory)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.SetCurrentDirectory PROCEDURE(*CSTRING szDirectory)

dwResult            LONG

  CODE
    IF ~FtpSetCurrentDirectory(SELF.hInternetConnect, szDirectory)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.CreateDirectory  PROCEDURE(*CSTRING szDirectory)

dwResult            LONG

  CODE
    IF ~FtpCreateDirectory(SELF.hInternetConnect, szDirectory)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.RemoveDirectory  PROCEDURE(*CSTRING szDirectory)

dwResult            LONG

  CODE
    IF ~FtpRemoveDirectory(SELF.hInternetConnect, szDirectory)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.RenameFile       PROCEDURE(*CSTRING szExisting, *CSTRING szNew)

dwResult            LONG

  CODE
    IF ~FtpRenameFile(SELF.hInternetConnect, szExisting, szNew)
      dwResult = GetLastError()
    END
    RETURN dwResult


CFtpConnection.DeleteFile       PROCEDURE(*CSTRING szFileName)

dwResult            LONG

  CODE
    IF ~FtpDeleteFile(SELF.hInternetConnect, szFileName)
      dwResult = GetLastError()
    END
    RETURN dwResult


CWinINet.Construct              PROCEDURE

  CODE
    SELF.HttpConnectionQueue &= NEW(HttpConnectionQueue)


CWinINet.Destruct               PROCEDURE

  CODE
    SELF.Kill


CWinINet.Init                   PROCEDURE(*CSTRING szAgent, LONG dwAccessType, LONG dwFlags, <ErrorClass ErrHdlr>)

bSuccess        BYTE

  CODE
    SELF.szAgent &= NEW(CSTRING(LEN(szAgent)))
    SELF.szAgent = szAgent
    SELF.hInternetSession = InternetOpen(szAgent, dwAccessType,,,dwFlags)
?   ASSERT(SELF.hInternetSession)
    IF SELF.hInternetSession
      bSuccess = true
    END
    RETURN bSuccess


CWinINet.InitProxy              PROCEDURE(*CSTRING szAgent, LONG dwAccessType, *CSTRING szProxyName, *CSTRING szProxyBypass, LONG dwFlags, <ErrorClass ErrHdlr>)

  CODE
    RETURN 0


CWinINet.Kill                   PROCEDURE

iCnt        LONG,AUTO

  CODE
    IF ~SELF.szUserName &= NULL
      DISPOSE(SELF.szUserName)
    END
    IF ~SELF.szPassword &= NULL
      DISPOSE(SELF.szPassword)
    END
    LOOP iCnt = 1 TO RECORDS(SELF.HttpConnectionQueue)
      GET(SELF.HttpConnectionQueue, 1)
      IF ERRORCODE()
        BREAK
      END
      DISPOSE(SELF.HttpConnectionQueue.Connection)
      DELETE(SELF.HttpConnectionQueue)
    END
    DISPOSE(SELF.HttpConnectionQueue)
    DISPOSE(SELF.szAgent)
    IF SELF.hInternetSession
      InternetCloseHandle(SELF.hInternetSession)
    END


CWinINet.SetUser                PROCEDURE(*CSTRING szUserName, *CSTRING szPassword)

  CODE
    IF ~SELF.szUserName &= NULL
      DISPOSE(SELF.szUserName)
    END
    SELF.szUserName &= NEW(CSTRING(LEN(szUserName)))
    SELF.szUserName = szUserName
    IF ~SELF.szPassword &= NULL
      DISPOSE(SELF.szPassword)
    END
    SELF.szPassword &= NEW(CSTRING(LEN(szPassword)))
    SELF.szPassword = szPassword


CWinINet.Connect                PROCEDURE(*CSTRING szServerName, LONG nPort, *CSTRING szUserName, *CSTRING szPassword, LONG dwService, LONG dwFlags, LONG dwContext, ASTRING ASVerb)

hInternetConnect        LONG,AUTO
LocHttpConn             &CHttpConnection

  CODE
    LocHttpConn &= NULL
?   ASSERT(SELF.hInternetSession)
    IF SELF.hInternetSession
      hInternetConnect = InternetConnect(SELF.hInternetSession, szServerName, nPort, szUserName, szPassword, dwService, dwFlags, dwContext)
?     ASSERT(hInternetConnect)
      IF hInternetConnect
        LocHttpConn &= NEW(CHttpConnection)
        LocHttpConn.Init(SELF, SELF.hInternetSession, hInternetConnect, ASVerb, szServerName)
        SELF.HttpConnectionQueue.Connection &= LocHttpConn
        SELF.HttpConnectionQueue.IConnectionAddress = ADDRESS(LocHttpConn.IINetConnectionHttp)
        ADD(SELF.HttpConnectionQueue, SELF.HttpConnectionQueue.IConnectionAddress)
      ELSE
        !Throw Error - no connection handle
      END
    ELSE
      !Throw Error - no session handle
    END
    RETURN LocHttpConn


CWinINet.Disconnect             PROCEDURE(*IINetConnection Connection)

! Only need to dispose of the CHttpConnection from the connection queue. A later
! call to InternetCloseHandle will clean the handles for us.

  CODE
    SELF.HttpConnectionQueue.IConnectionAddress = ADDRESS(Connection)
    GET(SELF.HttpConnectionQueue, SELF.HttpConnectionQueue.IConnectionAddress)
    IF ~ERRORCODE()
      DISPOSE(SELF.HttpConnectionQueue.Connection)
      DELETE(SELF.HttpConnectionQueue)
    END


CWinINet.OnReadEvent            PROCEDURE(IINetConnection Connection,*STRING strReceiveBuffer,LONG dwBytes)

  CODE


! Macros for defining and testing TCP and UDP GUIDs from a well-known
! port.


SVCID_HOSTNAME                  PROCEDURE

retGUID         GROUP(GUID).

  CODE
    retGUID.Data1 = 02a800h
    retGUID.Data2 = 0
    retGUID.Data3 = 0
    retGUID.Data4Str = '<0C0h><0><0><0><0><0><0><046h>'
    RETURN retGUID


SVCID_TCP_RR                    PROCEDURE(LONG _Port, SHORT _RR)

retGUID         GROUP(GUID).

  CODE
    retGUID.Data1 = BOR(BSHIFT(09h, 16), _Port)
    retGUID.Data2 = 0
    retGUID.Data3 = _RR
    retGUID.Data4Str = '<0C0h><0><0><0><0><0><0><046h>'
    RETURN retGUID


SVCID_TCP                       PROCEDURE(LONG _Port)

  CODE
    RETURN SVCID_TCP_RR(_Port, 0)


IS_SVCID_TCP                    PROCEDURE(GUID _g)

bResult         BYTE

  CODE
    IF BAND(_g.Data1, 0FFFF0000h) = 000090000h AND |
            _g.Data2 = 0 AND                       |
            _g.Data4[1] = 0C0h AND                 |
            _g.Data4[2] = 0 AND                    |
            _g.Data4[3] = 0 AND                    |
            _g.Data4[4] = 0 AND                    |
            _g.Data4[5] = 0 AND                    |
            _g.Data4[6] = 0 AND                    |
            _g.Data4[7] = 0 AND                    |
            _g.Data4[8] = 046h
      bResult = true
    END
    RETURN bResult


PORT_FROM_SVCID_TCP             PROCEDURE(GUID _g)

  CODE
    RETURN BAND(_g.Data1, 0FFFFh)


! Miscellaneous API Helper Utility functions


MakeWord                        PROCEDURE(BYTE LowByte, BYTE HiByte)

aWord                           SHORT

  CODE
    aWord = LowByte + BSHIFT(HiByte, 8)
    RETURN aWord


MakeLong                        PROCEDURE(BYTE LowWord, BYTE HiWord)

aLong                           LONG

  CODE
    aLong = LowWord + BSHIFT(HiWord, 16)
    RETURN aLong


LoWord                          PROCEDURE(LONG nValue)

aWord                           SHORT

  CODE
    aWord = nValue
    RETURN aWord


HiWord                          PROCEDURE(LONG nValue)

aWord                           SHORT

  CODE
    aWord = BSHIFT(nValue, -16)
    RETURN aWord


LoByte                          PROCEDURE(SHORT nValue)

aByte                           BYTE

  CODE
    aByte = nValue
    RETURN aByte


HiByte                          PROCEDURE(SHORT nValue)

aByte                           BYTE

  CODE
    aByte = BSHIFT(nValue, -8)
    RETURN aByte
