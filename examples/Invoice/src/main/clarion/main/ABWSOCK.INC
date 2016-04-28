!ABCIncludeFile(WinSock)


  OMIT('EndDefine',_ABWINSOCK_)
_ABWINSOCK_  EQUATE(1)


  INCLUDE('ABAPI.INC'),ONCE


DataResponseQueue  QUEUE,TYPE
strResponseData      &STRING
dwBytes              LONG
Socket               SOCKET
bServerSocket        BYTE
                   END

MsgEventCodes_ABWSock   ITEMIZE(Msg:Last)
Msg:DataReady             EQUATE
Msg:ServerDataReady       EQUATE
Msg:Last_ABWSock          EQUATE
                        END

WinSock            CLASS(CWinSock20),TYPE,MODULE('ABWSOCK.CLW'),LINK('ABWSOCK.CLW',_WinSockLinkMode_),DLL(_WinSockDllMode_),IMPLEMENTS(ITransport)

Construct            PROCEDURE
Destruct             PROCEDURE,DERIVED
InitWinsock          PROCEDURE(<ErrorClass ErrHdlr>),BOOL
Kill                 PROCEDURE,DERIVED
DisposeDataQueue     PROCEDURE(DataResponseQueue DRQ)
Connect              PROCEDURE(LONG dwThreadID, LONG dwSocket, *CSTRING szServiceName, CProtocolSocket Socket, *LONG nErr),*IConnection

IsDataReady          PROCEDURE,BYTE
GetNextResponse      PROCEDURE(IConnection Connection,*STRING strResponseBuffer)
GetNextResponseSize  PROCEDURE(IConnection Connection),LONG
GetProtocolSize      PROCEDURE(*CSTRING szProtocolToFind),LONG
GetProtocol          PROCEDURE(*CSTRING szProtocolToFind,*CSTRING szProtocolBuffer),LONG

IsServerDataReady    PROCEDURE,BYTE
GetNextServerResponse PROCEDURE(*STRING strResponseBuffer)
GetNextServerResponseSize PROCEDURE,BYTE

OnEnumProtocol       PROCEDURE(*CSTRING ProtocolName),VIRTUAL,PROTECTED
OnReadEventTS        PROCEDURE(LONG dwThreadID, SOCKET Sock, *STRING strReceiveBuffer, LONG dwBytes, BYTE bServerSocket = false),LONG,DERIVED,PROTECTED
OnWriteEventTS       PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0),LONG,DERIVED,PROTECTED
OnSocketClosed       PROCEDURE(SOCKET Sock, *IConnection Connection),DERIVED

ProtocolList         &ProtocolListQueue,PROTECTED
DataQueue            &DataResponseQueue,PROTECTED
ServerDataQueue      &DataResponseQueue,PROTECTED
bDataReady           BYTE,PROTECTED
bServerDataReady     BYTE,PROTECTED
ErrHdlr              &ErrorClass,PROTECTED
bErrorClassOwned     BYTE,PRIVATE

                   END

  EndDefine
