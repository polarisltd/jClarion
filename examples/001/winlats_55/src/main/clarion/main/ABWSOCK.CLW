
  MEMBER


  INCLUDE('ABWSOCK.INC'),ONCE


WinSock.Construct                           PROCEDURE

  CODE


WinSock.Destruct                            PROCEDURE

  CODE
    SELF.Kill


WinSock.InitWinsock                         PROCEDURE(<ErrorClass ErrHdlr>)

Err             LONG
iCnt            LONG
dwResult        LONG

  CODE
    IF SELF.bInitialised
      SELF.Kill
    END
    IF OMITTED(2)
      dwResult = SELF.Init()
    ELSE
      dwResult = SELF.Init(ErrHdlr)
    END
    IF dwResult = 0
      SELF.DataQueue &= NEW(DataResponseQueue)
      SELF.ServerDataQueue &= NEW(DataResponseQueue)
      SELF.bInitialised = true
    END
    RETURN dwResult


WinSock.Kill                                PROCEDURE

  CODE
    IF SELF.bInitialised
      DISPOSE(SELF.ProtocolList)
      SELF.DisposeDataQueue(SELF.DataQueue)
      SELF.DisposeDataQueue(SELF.ServerDataQueue)
      DISPOSE(SELF.DataQueue)
      DISPOSE(SELF.ServerDataQueue)
    END
    PARENT.Kill


WinSock.DisposeDataQueue                    PROCEDURE(DataResponseQueue DRQ)

iCnt        LONG

  CODE
    IF RECORDS(DRQ)
      LOOP iCnt = 1 TO RECORDS(DRQ)
        GET(DRQ, 1)
        IF ERRORCODE()
          BREAK.
        DISPOSE(DRQ.strResponseData)
        DELETE(DRQ)
      END
    END


WinSock.Connect                             PROCEDURE(LONG dwThreadID, LONG dwSocket, *CSTRING szServiceName, CProtocolSocket Socket, *LONG nErr)

Connection      &CSocketConnection

  CODE
    IF SELF.bInitialised
      Connection &= SELF.SocketConnect(dwThreadID, dwSocket, szServiceName, Socket, nErr)
    END
    IF ~Connection &= NULL
      RETURN Connection.IConnection
    ELSE
      RETURN 0
    END


WinSock.IsDataReady                         PROCEDURE

  CODE
    RETURN SELF.bDataReady


WinSock.GetNextResponse                     PROCEDURE(IConnection Connection, *STRING strResponseBuffer)

  CODE
    IF SELF.IsDataReady()
      SELF.DataQueue.Socket = Connection.GetSocket()
      GET(SELF.DataQueue, SELF.DataQueue.Socket)
      IF ~ERRORCODE()
        strResponseBuffer = SELF.DataQueue.strResponseData
        DISPOSE(SELF.DataQueue.strResponseData)
        DELETE(SELF.DataQueue)
      ELSE
?       ASSERT(~ERRORCODE(), 'An Error occured fetching the next Response for a socket : ' & ERROR())
      END
      IF ~RECORDS(SELF.DataQueue)
        SELF.bDataReady = false
      END
    END


WinSock.GetNextResponseSize                 PROCEDURE(IConnection Connection)

dwBytes         LONG

  CODE
    IF SELF.IsDataReady()
      SELF.DataQueue.Socket = Connection.GetSocket()
      GET(SELF.DataQueue, SELF.DataQueue.Socket)
      IF ~ERRORCODE()
        dwBytes = SELF.DataQueue.dwBytes
      END
    END
    RETURN dwBytes


WinSock.IsServerDataReady                   PROCEDURE

  CODE
    RETURN SELF.bServerDataReady


WinSock.GetNextServerResponse               PROCEDURE(*STRING strResponseBuffer)

  CODE
    IF ~RECORDS(SELF.ServerDataQueue)
      SELF.bServerDataReady = false
    END
    IF SELF.bServerDataReady
      GET(SELF.ServerDataQueue, 1)
      IF ~ERRORCODE()
        strResponseBuffer = SELF.ServerDataQueue.strResponseData
        DISPOSE(SELF.ServerDataQueue.strResponseData)
        DELETE(SELF.ServerDataQueue)
      ELSE
?       ASSERT(~ERRORCODE(), 'An Error occured fetching the next Response for a socket : ' & ERROR())
      END
    END


WinSock.GetNextServerResponseSize           PROCEDURE

dwBytes         LONG

  CODE
    IF SELF.bServerDataReady
      GET(SELF.ServerDataQueue, 1)
      IF ~ERRORCODE()
        dwBytes = SELF.ServerDataQueue.dwBytes
      END
    END
    RETURN dwBytes


WinSock.GetProtocolSize                     PROCEDURE(*CSTRING szProtocolToFind)

LocBuffer       CSTRING(256)

  CODE
    RETURN SELF.GetProtocol(szProtocolToFind, LocBuffer)


WinSock.GetProtocol                         PROCEDURE(*CSTRING szProtocolToFind, *CSTRING szProtocolBuffer)

iCnt            LONG

  CODE
    LOOP iCnt = 1 TO RECORDS(SELF.ProtocolList)
      CLEAR(SELF.ProtocolList)
      GET(SELF.ProtocolList, iCnt)
      IF ERRORCODE()
        BREAK.
      IF INSTRING(UPPER(szProtocolToFind), UPPER(SELF.ProtocolList.ProtocolName), 1, 1)
        szProtocolBuffer = SELF.ProtocolList.ProtocolName
        BREAK
      END
    END
    RETURN LEN(SELF.ProtocolList.ProtocolName)


WinSock.OnEnumProtocol                      PROCEDURE(*CSTRING ProtocolName)

  CODE


WinSock.OnReadEventTS                       PROCEDURE(LONG dwThreadID, SOCKET Sock, *STRING strReceiveBuffer, |
                                                      LONG dwBytes, BYTE bServerSocket)

  CODE
    IF bServerSocket
      SELF.ServerDataQueue.strResponseData &= NEW(STRING(dwBytes))
      SELF.ServerDataQueue.strResponseData = strReceiveBuffer
      SELF.ServerDataQueue.dwBytes = dwBytes
      SELF.ServerDataQueue.Socket = Sock
      ADD(SELF.ServerDataQueue)
?     ASSERT(~ERRORCODE(), 'An Error occured Inserting a response into the response queue : ' & ERROR())
      SELF.bServerDataReady = true
      POST(Msg:ServerDataReady, , dwThreadID)
    ELSE
      SELF.DataQueue.strResponseData &= NEW(STRING(dwBytes))
      SELF.DataQueue.strResponseData = strReceiveBuffer
      SELF.DataQueue.dwBytes = dwBytes
      SELF.DataQueue.Socket = Sock
      ADD(SELF.DataQueue)
?     ASSERT(~ERRORCODE(), 'An Error occured Inserting a response into the response queue : ' & ERROR())
      SELF.bDataReady = true
      POST(Msg:DataReady, , dwThreadID)
    END
    RETURN 0


WinSock.OnWriteEventTS                      PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode)

  CODE
    RETURN 0


WinSock.OnSocketClosed                      PROCEDURE(SOCKET Sock, *IConnection Connection)

  CODE


WinSock.ITransport.Connect                  PROCEDURE(LONG dwThreadID, LONG dwSocket, *CSTRING szServiceName, CProtocolSocket Socket, *LONG nErr)

  CODE
    RETURN SELF.Connect(dwThreadID, dwSocket, szServiceName, Socket, nErr)


WinSock.ITransport.Disconnect               PROCEDURE(*IConnection Connection)

  CODE
    SELF.Disconnect(Connection)


WinSock.ITransport.SendData                 PROCEDURE(IConnection Connection, *STRING strSendBuffer, *LONG BytesSent)

  CODE
    RETURN SELF.SendData(Connection, strSendBuffer, BytesSent)


WinSock.ITransport.GetNextResponse          PROCEDURE(IConnection Connection, *STRING strResponseBuffer)

  CODE
    SELF.GetNextResponse(Connection, strResponseBuffer)


WinSock.ITransport.GetNextResponseSize      PROCEDURE(IConnection Connection)

  CODE
    RETURN SELF.GetNextResponseSize(Connection)


WinSock.ITransport.IsDataReady              PROCEDURE

  CODE
    RETURN SELF.IsDataReady()


WinSock.ITransport.GetNextServerResponse    PROCEDURE(*STRING strResponseBuffer)

  CODE
    SELF.GetNextServerResponse(strResponseBuffer)


WinSock.ITransport.GetNextServerResponseSize PROCEDURE

  CODE
    RETURN SELF.GetNextServerResponseSize()


WinSock.ITransport.IsServerDataReady        PROCEDURE

  CODE
    RETURN SELF.IsServerDataReady()


WinSock.ITransport.Listen                   PROCEDURE

  CODE
